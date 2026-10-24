unit untCopiasAltIndividual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untFuncoesSimples, Data.DB, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, cxProgressBar, untGravando, cxTextEdit,
  System.DateUtils, UniClientDataSet, System.IOUtils;

type
  TfrmCopiasAltIndividual = class(TfrmPaiConfirma)
    dtsCopias: TDataSource;
    cxGridDBTableView: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    cxGridDBTableViewDTAALT: TcxGridDBColumn;
    cxGridDBTableViewHRAALT: TcxGridDBColumn;
    cxGridDBTableViewTABELA: TcxGridDBColumn;
    btnExcluir: TBitBtnLocked;
    cxGridDBTableViewCODOPE: TcxGridDBColumn;
    cxGridDBTableViewNOMOPE: TcxGridDBColumn;
    cxGridDBTableViewCODEMP: TcxGridDBColumn;
    grpLegenda: TGroupBox;
    Shape1: TShape;
    lblLegenda: TLabel;
    cxGridDBTableViewQTDREG: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxGridDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    qryCons: TUniQuery;
    function fCarregarCopiasAux(pgbProgresso: TCxProgressBar): boolean;
    procedure pExcluirCopia;
  public
    strTabela: String;
    blnRestaurou,
    blnMostrarForm,
    blnHouveEdicao: Boolean;
    cdsParamsRestaurado: TUniClientDataSet;
  end;

var
  frmCopiasAltIndividual: TfrmCopiasAltIndividual;

implementation

{$R *.dfm}

{ TfrmCopiasAltIndividual }

procedure TfrmCopiasAltIndividual.btnConfirmaClick(Sender: TObject);
var
  strPathCds: String;
begin
  inherited;
  strTabela := qryCons.FieldByName('IND_TABELA').AsString;
  blnRestaurou := True;
  blnHouveEdicao := qryCons.FieldByName('IND_EDITOU').AsInteger = 1;
  strPathCds := ExtractFilePath(ParamStr(0)) + 'params_' + strTabela + '.xml';
  TBlobField(qryCons.FieldByName('IND_PARAMS')).SaveToFile(strPathCds);
  cdsParamsRestaurado.LoadFromFile(strPathCds);
  cdsParamsRestaurado.Filter := 'MARCADO = TRUE';
  cdsParamsRestaurado.Filtered := True;
  cdsParamsRestaurado.First;
  TFile.Delete(strPathCds);
end;

procedure TfrmCopiasAltIndividual.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pExcluirCopia;
end;

procedure TfrmCopiasAltIndividual.cxGridDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If DaysBetween(fNow, VarToDateTime(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridDBTableViewDTAALT.Index])) = 0 Then
    ACanvas.Brush.Color := clMoneyGreen;
end;

procedure TfrmCopiasAltIndividual.FormCreate(Sender: TObject);
begin
  inherited;
  qryCons := fCriaQuery;
  TfrmGravando.fExecuta(fCarregarCopiasAux, frmGravando, 'Carregando cópias de segurança...', False);
  cdsParamsRestaurado := TUniClientDataSet.Create(Nil);
end;

procedure TfrmCopiasAltIndividual.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCons);
end;

procedure TfrmCopiasAltIndividual.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: pSetFocus(btnConfirma);
  End;
end;

function TfrmCopiasAltIndividual.fCarregarCopiasAux(pgbProgresso: TCxProgressBar): boolean;
begin
  Result := True;
  qryCons.SQL.Clear;
  qryCons.SQL.Add('SELECT ALTIND.*,                              ');
  qryCons.SQL.Add(' C.OPE_NOMOPE AS IND_NOMOPE                   ');
  qryCons.SQL.Add(' FROM ALTIND                                  ');
  qryCons.SQL.Add('INNER JOIN CADOPE C ON                        ');
  qryCons.SQL.Add(' IND_CODOPE = C.OPE_CODOPE                    ');
  qryCons.SQL.Add('WHERE IND_CODOPE = :CODOPE                    ');
  qryCons.SQL.Add('  AND IND_CODEMP = :CODEMP                    ');
  qryCons.SQL.Add('ORDER BY CONCAT(IND_DTAALT, IND_HRAALT) DESC  ');

  qryCons.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
  qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;

  Try
    qryCons.Open;

    blnMostrarForm := Not (qryCons.IsEmpty);

    dtsCopias.DataSet := qryCons;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro('Erro ao consultar cópias de segurança','[fCarregarCopiasAux]');
    End;
  End;

end;

procedure TfrmCopiasAltIndividual.pExcluirCopia;
var
  qryDel: TUniQuery;
begin
  If fMensagem('', 'Confirma exclusão da cópia?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    qryDel := fCriaQuery;
    qryDel.SQL.Add('DELETE FROM ALTIND ');
    qryDel.SQL.Add('WHERE AUTOINCREM = :AUTINC ');

    qryDel.ParamByName('AUTINC').AsString := qryCons.FieldByName('AUTOINCREM').AsString;

    Try
      fStartTransaction;
      qryDel.ExecSQL;
      fCommit;
      qryCons.Close;
      qryCons.Open;
      If qryCons.IsEmpty Then
        Close;
    Except On
      E:Exception Do
      Begin
        fRollback;
        pMensagensErro('Erro ao tentar excluir a cópia de segurança!','[TfrmCopiasAltIndividual.pExcluirCopia]');
      End;
    End;
  Finally
    FreeAndNil(qryDel);
  End;
end;

end.
