unit untConfirmaImportaPlanilhaMetaVendForn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGridCitel,
  Vcl.ComCtrls, Uni, UniClientDataSet, cxProgressBar;

type
  TfrmConfirmaImportaPlanilhaMetaVendForn = class(TfrmPaiConfirma)
    pgcDados: TPageControl;
    tbsDados: TTabSheet;
    cxgDados: TcxGridCitel;
    cxgDadosTbv: TcxGridDBTableView;
    cxgDadosTbvPERMES: TcxGridDBColumn;
    cxgDadosTbvPERANO: TcxGridDBColumn;
    cxgDadosTbvCODVEN: TcxGridDBColumn;
    cxgDadosTbvNOMVEN: TcxGridDBColumn;
    cxgDadosTbvCODFOR: TcxGridDBColumn;
    cxgDadosTbvNOMFOR: TcxGridDBColumn;
    cxgDadosTbvVALOR_: TcxGridDBColumn;
    cxgDadosLevel: TcxGridLevel;
    tbsErros: TTabSheet;
    cxgErros: TcxGridCitel;
    cxgErrosTbv: TcxGridDBTableView;
    cxgErrosTbvMENSAG: TcxGridDBColumn;
    cxgErrosTbvLINHA: TcxGridDBColumn;
    cxgErrosTbvCOLUNA: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxgDadosTbvEXISTE: TcxGridDBColumn;
    dtsDados: TDataSource;
    dtsErros: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FcdsDados: TUniClientDataSet;
    FcdsErros: TUniClientDataSet;
    FOk: Boolean;
  protected
    function Confirma(pgbProgresso: TcxProgressBar): Boolean;
  public
    property cdsDados: TUniClientDataSet read FcdsDados write FcdsDados;
    property cdsErros: TUniClientDataSet read FcdsErros write FcdsErros;
    property Ok: Boolean read FOk;
  end;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmConfirmaImportaPlanilhaMetaVendForn.btnConfirmaClick(
  Sender: TObject);
Var
  frmGravando : TfrmGravando;
begin
  If cdsDados.IsEmpty Then
  Begin
    pMensagemOk('Não há nenhum registro válido para processamento!');
    Exit;
  End;

  frmGravando := nil;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    if Assigned(frmGravando) then
    begin
      frmGravando.fExecutarAcao := Confirma;
      frmGravando.lblGravando.Caption := 'Aguarde... Processando registros...';
      frmGravando.Showmodal;

      If FOk Then
      Begin
        pMensagemOk('Processo concluído com êxito!');
        inherited;
      End;
    end
  Finally
    if Assigned(frmGravando) then
      pFreeAndNil(frmGravando);
  End;
end;

function TfrmConfirmaImportaPlanilhaMetaVendForn.Confirma(
  pgbProgresso: TcxProgressBar): Boolean;
Var
  LqryExec : TUniQuery;
  LFS: TFormatSettings;
begin
  Result := False;
  pgbProgresso.Properties.Max := cdsDados.RecordCount;

  FOk := False;

  if cdsDados.RecordCount = 0 then
    Exit;

  LqryExec := fCriaQuery;
  Try
    cdsDados.DisableControls;
    Try
      fStartTransaction;
      Try
        cdsDados.First;
        While Not cdsDados.Eof Do
        Begin
          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;

          If cdsDados.FieldByName('EXISTE').AsString = 'N' Then
          Begin
            LqryExec.SQL.Clear;
            LqryExec.SQL.Add('INSERT INTO VALGER(AUTOINCREM, VAL_CODEMP, VAL_CODVEN, VAL_CODFOR, VAL_NUMANO, VAL_NUMMES, VAL_TOTVAL)');
            LqryExec.SQL.Add('VALUES (:AUTINC, :CODEMP, :CODVEN, :CODFOR, :NUMANO, :NUMMES, :TOTVAL)');

            LqryExec.ParamByName('AUTINC').AsString := fRetAutoIncrem('VALGER', VS_strCodEmp);
            if fEmptyStr(LqryExec.ParamByName('AUTINC').AsString) then
              raise Exception.Create('Não foi possível obter o próximo AUTOINCREM para VALGER');
          End
          Else
          Begin
            LqryExec.SQL.Clear;
            LqryExec.SQL.Add('UPDATE VALGER');
            LqryExec.SQL.Add('SET VAL_TOTVAL = :TOTVAL');
            LqryExec.SQL.Add('WHERE VAL_CODEMP = :CODEMP');
            LqryExec.SQL.Add('  AND VAL_CODFOR = :CODFOR');
            LqryExec.SQL.Add('  AND VAL_NUMANO = :NUMANO');
            LqryExec.SQL.Add('  AND VAL_NUMMES = :NUMMES');
            LqryExec.SQL.Add('  AND VAL_CODVEN = :CODVEN');
          End;

          LqryExec.ParamByName('CODEMP').AsString := VS_StrCodEmp;
          LqryExec.ParamByName('CODVEN').AsString := cdsDados.FieldByName('CODVEN').AsString;
          LqryExec.ParamByName('CODFOR').AsString := cdsDados.FieldByName('CODFOR').AsString;
          LqryExec.ParamByName('NUMANO').AsString := cdsDados.FieldByName('PERANO').AsString;
          LqryExec.ParamByName('NUMMES').AsString := cdsDados.FieldByName('PERMES').AsString;
          LFS := TFormatSettings.Create;
          LFS.DecimalSeparator := '.';
          LqryExec.ParamByName('TOTVAL').AsFloat := StrToFloat(cdsDados.FieldByName('VALOR_').AsString, LFS);
          LqryExec.ExecSQL;

          cdsDados.Next;
        End;

        fCommit;
        FOk := True;
        Result := True;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          Result := False;
          pMensagensErro(E.Message, '[TfrmConfirmaImportaPlanilhaMetaVendForn.Confirma]');
        End;
      End;
    Finally
      cdsDados.EnableControls;
    End;
  Finally
    FreeAndNil(LqryExec);
  End;
end;

procedure TfrmConfirmaImportaPlanilhaMetaVendForn.FormShow(Sender: TObject);
begin
  inherited;
  cdsErros.IndexFieldNames := 'LINHA';

  dtsDados.DataSet := cdsDados;
  dtsErros.DataSet := cdsErros;
end;

end.
