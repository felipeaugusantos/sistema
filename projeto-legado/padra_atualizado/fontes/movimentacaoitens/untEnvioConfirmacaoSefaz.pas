unit untEnvioConfirmacaoSefaz;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, Uni, untFuncoesSimples, cxContainer,
  cxProgressBar, cxCurrencyEdit, untZClient, cxGridCitel;

type
  TfrmEnvioConfirmacaoSefaz = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    dtsDados: TDataSource;
    Panel1: TPanel;
    pnlFiltros: TPanel;
    Label8: TLabel;
    Label13: TLabel;
    Label12: TLabel;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    mskDtaEntIni: TMaskEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    btnFiltra: TBitBtnLocked;
    cxDocs: TcxGridCitel;
    cxgDocs: TcxGridDBTableViewCitel;
    cxgDocsDTAENT: TcxGridDBColumn;
    cxgDocsDTADOC: TcxGridDBColumn;
    cxgDocsNUMDOC: TcxGridDBColumn;
    cxgDocsSERIE_: TcxGridDBColumn;
    cxgDocsCODFOR: TcxGridDBColumn;
    cxgDocsRAZSOC: TcxGridDBColumn;
    cxgDocsCLAFIS: TcxGridDBColumn;
    cxgDocsVLRCON: TcxGridDBColumn;
    cxlDocs: TcxGridLevel;
    pnlErros: TPanel;
    cxgDocsColumn1: TcxGridDBColumn;
    cxgDocsColumn2: TcxGridDBColumn;
    memErro: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnFiltraClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cdsDocumentosAfterScroll(DataSet: TDataSet);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsDocumentos: TZClient;
    qryExec: TUniQuery;
    function fAbreConsulta:Boolean;
    Function fEnviaConfirmacao(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAutalizaEnviado;


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
  end;

implementation

uses
  untGravando, untFuncoesConsulta, untTypesSistema, untLibNfe, untConsultas;

{$R *.dfm}

procedure TfrmEnvioConfirmacaoSefaz.btnFiltraClick(Sender: TObject);
begin
  inherited;
  If fAbreConsulta And (cdsDocumentos.IsEmpty) Then
    pMensagemOk('Sem documentos para confirmar.');
end;

procedure TfrmEnvioConfirmacaoSefaz.cdsDocumentosAfterScroll(DataSet: TDataSet);
begin
  pnlErros.Visible := (cdsDocumentos.FieldByName('ERRO').AsString <> '');

  memErro.Text := cdsDocumentos.FieldByName('ERRO').AsString;
end;

procedure TfrmEnvioConfirmacaoSefaz.edtForNotKeyPress(Sender: TObject; var Key: Char);
  Var arrForNot : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEnvioConfirmacaoSefaz.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If cdsDocumentos.IsEmpty Then
  Begin
    pMensagemOk('Sem documentos para confirmar. Por favor utilize o botão filtrar.');
    Exit;
  End;
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    cdsDocumentos.DisableControls;
    frmGravando.fExecutarAcao := fEnviaConfirmacao;
    frmGravando.lblGravando.Caption := 'Aguarde, enviando arquivos para confirmação.';
    frmGravando.ShowModal;
    cdsDocumentos.Filtered := False;
    cdsDocumentos.Filter := 'ERRO <> ' + QuotedStr('');
    cdsDocumentos.Filtered := True;
  Finally
    cdsDocumentos.EnableControls;
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmEnvioConfirmacaoSefaz.fAbreConsulta: Boolean;
begin
  Result := True;
  Try
    If fValidaPanel(pnlFiltros) Then
    Begin
      If Assigned(cdsDocumentos) Then
      Begin
        FreeAndNil(cdsDocumentos);
        cdsDocumentos := TZClient.Create(nil);
        dtsDados.DataSet := cdsDocumentos;
        cdsDocumentos.AfterScroll := cdsDocumentosAfterScroll;
      End;

      cdsDocumentos.qryQuery.SQL.Add('SELECT GER_DTAENT DTAENT,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_DTADOC AS DTADOC,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_NUMDOC AS NUMDOC,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_ESPDOC AS ESPDOC,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_SERIE_ AS SERIE_,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_CODFOR AS CODFOR,');
      cdsDocumentos.qryQuery.SQL.Add('       FOR_NOMFOR AS RAZSOC,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_CLAFIS AS CLAFIS,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_VLRCON AS VLRCON,');
      cdsDocumentos.qryQuery.SQL.Add('       FIS_ACESSO AS CHAVE_,');
      cdsDocumentos.qryQuery.SQL.Add('       GER_CODEMP AS CODEMP,');

      cdsDocumentos.qryQuery.SQL.Add('       CAST("" AS CHAR(255)) AS ERRO,');

      cdsDocumentos.qryQuery.SQL.Add('       MOVGER.AUTOINCREM AS AUTINC');
      cdsDocumentos.qryQuery.SQL.Add(' FROM MOVGER');
      cdsDocumentos.qryQuery.SQL.Add(' INNER JOIN AUXMOV ON  AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM');
      cdsDocumentos.qryQuery.SQL.Add(' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR');
      cdsDocumentos.qryQuery.SQL.Add(' INNER JOIN CADFIS ON FIS_NUMDOC = MOVGER.GER_NUMDOC');
      cdsDocumentos.qryQuery.SQL.Add('                 AND FIS_CODEMP = MOVGER.GER_CODEMP');
      cdsDocumentos.qryQuery.SQL.Add('                 AND FIS_SERIE_ = MOVGER.GER_SERIE_');
      cdsDocumentos.qryQuery.SQL.Add('                 AND FIS_TIP_FC = MOVGER.GER_TIP_FC');
      cdsDocumentos.qryQuery.SQL.Add('                 AND FIS_FORCLI = IF(MOVGER.GER_TIP_FC = "F", MOVGER.GER_CODFOR, MOVGER.GER_CODCLI)');
      cdsDocumentos.qryQuery.SQL.Add(' WHERE GER_ESPDOC = "NF"');
      cdsDocumentos.qryQuery.SQL.Add('   AND GER_TIP_FC = "F"');
      cdsDocumentos.qryQuery.SQL.Add('   AND IFNULL(GER_ORIDOC, "") = ""');
      cdsDocumentos.qryQuery.SQL.Add('   AND GER_CLAFIS < 5000');
      cdsDocumentos.qryQuery.SQL.Add('   AND IFNULL(AUX_SEFREC, "N") = "N"');
      cdsDocumentos.qryQuery.SQL.Add('   AND GER_DTAENT IS NOT NULL ');
      cdsDocumentos.qryQuery.SQL.Add('   AND GER_CODEMP = "' + VS_strCodEmp + '" ');

      If Not fEmptyStr(edtForNot.Text) Then
        cdsDocumentos.qryQuery.SQL.Add('   AND GER_CODFOR = "' + edtForNot.Text + '"');

      If Not fEmptyDate(mskDtaEntIni.Text) Then
        cdsDocumentos.qryQuery.SQL.Add('   AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN');

      cdsDocumentos.qryQuery.SQL.Add('    ORDER BY GER_DTAENT, GER_CODEMP, GER_ESPDOC, GER_NUMDOC ');
      If Not fEmptyDate(mskDtaEntIni.Text) Then
      Begin
        cdsDocumentos.qryQuery.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaEntIni.Text);
        cdsDocumentos.qryQuery.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaEntFin.Text);
      End;

      cdsDocumentos.fAbreClient();
    End;
  Except
    on E: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmEnvioConfirmacaoSefaz.fAbreConsulta]');
    End;
  End;
end;

procedure TfrmEnvioConfirmacaoSefaz.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDocumentos := TZClient.Create(nil);
  qryExec := fCriaQuery;
  dtsDados.DataSet := cdsDocumentos;
  cdsDocumentos.AfterScroll := cdsDocumentosAfterScroll;
end;

procedure TfrmEnvioConfirmacaoSefaz.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDocumentos);
  FreeAndNil(qryExec);
end;

procedure TfrmEnvioConfirmacaoSefaz.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtForNot);
end;

function TfrmEnvioConfirmacaoSefaz.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
var arrForNot: TConsultasArray;
begin
  Result := True;
  If (Sender = edtForNot) And (Not fEmptyStr(edtForNot.Text)) Then
  Begin
    pEdtCodSelectExit(edtForNot, edtDesForNot, arrForNot, fRetNomFornecedor, Nil, 'do Fornecedor');
    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      Result := False;
      pMensagemOk('Código do Fornecedor inválido!');
    End;
  End

  Else if (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
  Begin
    if StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
    Begin
      pMensagemOk('Data Inicial Inválida!');
      Result := False;
    End;
  End
  Else If (Sender = mskDtaEntFin) And  (Not fEmptyDate(mskDtaEntFin.Text)) And (fEmptyDate(mskDtaEntIni.Text)) Then
  Begin
    pMensagemOk('Data Inicial deve ser preenchida!');
    Result := False;
  End
  Else if (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
  Begin
    if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
    Begin
      pMensagemOk('Data Final Inválida!');
      Result := False;
    End;

    If Result And (StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0)) Then
    Begin
      pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
      Result := False;
    End;
  End
end;

procedure TfrmEnvioConfirmacaoSefaz.pAutalizaEnviado;
begin
  qryExec.SQL.Clear;
  qryExec.SQL.Add('UPDATE AUXMOV SET AUX_SEFREC = "S" ');
  qryExec.SQL.Add(' WHERE AUXMOV.AUX_SEQGER = "' + cdsDocumentos.FieldByName('AUTINC').AsString + '"');
  qryExec.ExecSQL;
end;

Function  TfrmEnvioConfirmacaoSefaz.fEnviaConfirmacao(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strResult: String;
Begin
  Result := True;
  pgbProgresso.Properties.Max := cdsDocumentos.RecordCount;
  cdsDocumentos.First;
  While Not cdsDocumentos.Eof Do
  begin
    Try
      strResult := fLibConfirmacaoOperacaoEntradaMercadoria(cdsDocumentos.FieldByName('CODEMP').AsString,
                                                            cdsDocumentos.FieldByName('CHAVE_').AsString);
      If UpperCase(strResult) = 'OK' Then
        pAutalizaEnviado
      Else
        raise Exception.Create(strResult);

    Except
      cdsDocumentos.Edit;
      cdsDocumentos.FieldByName('ERRO').AsString := strResult;
      cdsDocumentos.Post;
    End;

    cdsDocumentos.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages
  End;
End;


end.
