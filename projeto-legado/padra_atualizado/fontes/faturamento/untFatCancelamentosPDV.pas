unit untFatCancelamentosPDV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB,   Uni, MemDS, DBAccess, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatCancelamentosPDV = class(TfrmPai)
    dbgCancelamentos: TDBGridCitel;
    qryCancelamentos: TUniQuery;
    dtsCancelamentos: TDataSource;
    Label1: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgCancelamentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pCarregaDocumentos;
    procedure pAbrirCancelamento;
    procedure pAbrirCancelamentoInterna;
    function fConfereResultadoCancelamento: Boolean;
  public
    { Public declarations }
  end;

var
  frmFatCancelamentosPDV: TfrmFatCancelamentosPDV;

implementation

uses untFuncoesSimples, untCancelamentoDocumentos;

{$R *.dfm}

{ TfrmFatCancelamentosPDV }



procedure TfrmFatCancelamentosPDV.pAbrirCancelamento;
  function fLockCancelamento: String;
  begin
    Result := 'CANCELAMENTO_PDV_' + VS_strCodEmp;
  end;
begin
  If fLock_Unlock(fLockCancelamento, True, False, False, '', False) Then
  Begin
    Try
      pAbrirCancelamentoInterna;
      pCarregaDocumentos;
    Finally
      fLock_Unlock(fLockCancelamento, False, False, False, '', False)
    End;
  End
  Else
  Begin
    pMensagemOk('A rotina de finalização de cancelamentos do PDV está sendo usada por outro operador: ' + fGetHostLock(fLockCancelamento) + '.');
  End;
end;

procedure TfrmFatCancelamentosPDV.pAbrirCancelamentoInterna;
  Var
    frmCancelamentoDocumentos : TfrmCancelamentoDocumentos;
begin
  If qryCancelamentos.IsEmpty Then
    Exit;
    
  If qryCancelamentos.FieldByName('FIS_NUMDOC').IsNull Then
  Begin
    pMensagemOk('Este documento ainda não foi importado pelo Autcom. Por favor, aguarde alguns minutos e tente novamente.');
    Exit;
  End;

  If fConfereResultadoCancelamento Then
  Begin
    pMensagemOk('Este documento já foi cancelado.');
    Exit;
  End;

  if (fCfgSis('CANCIF') <> 'S') then
  Begin
    pMensagemOk('Sistema não configurado para cancelamento de Cupom Fiscal.' + #13 +
                'Configure a opção "CFG_CANCIF" para "Sim".');
    Exit;
  End;

  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
  Try
    frmCancelamentoDocumentos.edtNumDoc.Text := qryCancelamentos.FieldByName('FIS_NUMDOC').AsString;
    frmCancelamentoDocumentos.edtCliFor.Text := qryCancelamentos.FieldByName('FIS_FORCLI').AsString;
    frmCancelamentoDocumentos.blnPDV  := True;
    frmCancelamentoDocumentos.strCancelandoIF := 'S';
    frmCancelamentoDocumentos.strNumDocCanc   := qryCancelamentos.FieldByName('FIS_NUMDOC').AsString;
    frmCancelamentoDocumentos.ShowModal;
  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;

  fConfereResultadoCancelamento;

end;

procedure TfrmFatCancelamentosPDV.pCarregaDocumentos;
begin
  qryCancelamentos.SQL.Clear;
  qryCancelamentos.SQL.Add('SELECT ');
  qryCancelamentos.SQL.Add('  CAN_NUMSER, ');
  qryCancelamentos.SQL.Add('  CAN_NUMCOO, ');
  qryCancelamentos.SQL.Add('  FIS_NUMDOC, ');
  qryCancelamentos.SQL.Add('  FIS_ESPDOC, ');
  qryCancelamentos.SQL.Add('  FIS_CODEMP, ');
  qryCancelamentos.SQL.Add('  FIS_FORCLI, ');
  qryCancelamentos.SQL.Add('  FIS_SERIE_, ');
  qryCancelamentos.SQL.Add('  IFNULL(CLI_NOMCLI, "DOCUMENTO AINDA NÃO FATURADO") AS CLI_NOMCLI ');
  qryCancelamentos.SQL.Add('FROM ');
  qryCancelamentos.SQL.Add('  PAF_CANCELAMENTOS ');
  qryCancelamentos.SQL.Add('  LEFT JOIN CADFIS ON REPLACE(FIS_NUMSER, "\0", "") = REPLACE(CAN_NUMSER, "\0", "") ');
  qryCancelamentos.SQL.Add('                  AND LPAD(FIS_NUMCOO, 10, "0") = LPAD(CAN_NUMCOO, 10, "0") ');
  qryCancelamentos.SQL.Add('                  AND FIS_CODEMP = CAN_CODEMP ');
  qryCancelamentos.SQL.Add('  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ');
  qryCancelamentos.SQL.Add('WHERE ');
  qryCancelamentos.SQL.Add('  CAN_CODEMP = :CODEMP AND ');
  qryCancelamentos.SQL.Add('  CAN_CANCEL = 0 ');

  qryCancelamentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryCancelamentos.Open;
end;

procedure TfrmFatCancelamentosPDV.dbgCancelamentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    pAbrirCancelamento;
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End
  Else
    inherited;
end;

function TfrmFatCancelamentosPDV.fConfereResultadoCancelamento: Boolean;
  Var
    qryAux: TUniQuery;
    qryUpd: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT FIS_HISTOR FROM CADFIS WHERE ');
  qryAux.SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  FIS_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  FIS_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  FIS_FORCLI = :CODCLI AND ');
  qryAux.SQL.Add('  FIS_SERIE_ = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := qryCancelamentos.FieldByName('FIS_NUMDOC').AsString;
  qryAux.ParamByName('ESPDOC').AsString := qryCancelamentos.FieldByName('FIS_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryCancelamentos.FieldByName('FIS_CODEMP').AsString;
  qryAux.ParamByName('CODCLI').AsString := qryCancelamentos.FieldByName('FIS_FORCLI').AsString;
  qryAux.ParamByName('SERIE_').AsString := qryCancelamentos.FieldByName('FIS_SERIE_').AsString;
  qryAux.Open;

  Result := False;

  If Pos('CANCELADO', qryAux.FieldByName('FIS_HISTOR').AsString) > 0 Then
  Begin
    qryUpd := fCriaQuery(Self);
    qryUpd.SQL.Add('UPDATE PAF_CANCELAMENTOS SET CAN_CANCEL = 1 WHERE ');
    qryUpd.SQL.Add('  REPLACE(CAN_NUMSER, "\0", "") = :NUMSER AND ');
    qryUpd.SQL.Add('  CAN_NUMCOO = :NUMCOO AND ');
    qryUpd.SQL.Add('  CAN_CODEMP = :CODEMP ');

    qryUpd.ParamByName('NUMSER').AsString := qryCancelamentos.FieldByName('CAN_NUMSER').AsString;
    qryUpd.ParamByName('NUMCOO').AsString := qryCancelamentos.FieldByName('CAN_NUMCOO').AsString;
    qryUpd.ParamByName('CODEMP').AsString := qryCancelamentos.FieldByName('FIS_CODEMP').AsString;
    qryUpd.ExecSQL;

    FreeAndNil(qryUpd);

    Result := True;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmFatCancelamentosPDV.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgCancelamentos);
end;

procedure TfrmFatCancelamentosPDV.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
end;

procedure TfrmFatCancelamentosPDV.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgCancelamentos);
end;

end.
