unit untFatRelLiberacaoRemota;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Uni, untZClient,
  frxDBSet, System.StrUtils, untFuncoesRel;

type
  TfrmRelLiberacaoRemota = class(TfrmPaiConfirma)
    pnlFiltro: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    lblOpe: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    lblNumDoc: TLabel;
    lblEspFat: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label1: TLabel;
    edtNomCli: TEditFocus;
    rdgStatus: TRadioGroup;
    edtCodCli: TEditFocus;
    edtPalCha: TEditFocus;
    Label4: TLabel;
    rdgOrdena: TRadioGroup;
    cxgConsultaView: TcxGridDBTableViewCitel;
    cxgConsultaLevel1: TcxGridLevel;
    cxgConsulta: TcxGridCitel;
    dtsConsul: TDataSource;
    cxgConsultaViewSTATUS: TcxGridDBColumn;
    cxgConsultaViewDTACAD: TcxGridDBColumn;
    cxgConsultaViewNOMOPECAD: TcxGridDBColumn;
    cxgConsultaViewDOCUME: TcxGridDBColumn;
    cxgConsultaViewEMPRES: TcxGridDBColumn;
    cxgConsultaViewNOMCLI: TcxGridDBColumn;
    cxgConsultaViewTITULO: TcxGridDBColumn;
    cxgConsultaViewNOMVEN: TcxGridDBColumn;
    cxgConsultaViewNOMOPELIB: TcxGridDBColumn;
    btnCadCliente: TBitBtnLocked;
    btnReimprimir: TBitBtnLocked;
    btnAnalisar: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    edtCodEmp: TEditFocus;
    Label5: TLabel;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadClienteClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAnalisarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    qryCadCli: TUniQuery;
    cdsConsul: TZClient;
    procedure pCarregaCliente;
    procedure pCarregaOperador;

    procedure pAbreConsulta;
    function fSqlConsulta(blnVazio: Boolean): String;

    Procedure pFechaConsulta;

  public
    { Public declarations }
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untGravando, untConsultas, untPesqAux, untTypesSistema,
  untImpressaoDocs, untCadClientes, untObservacao, untConstantes;

{$R *.dfm}

procedure TfrmRelLiberacaoRemota.btnReimprimirClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmReimpressaoDocs2') Then
  Begin
    pMensagemOk('Você não tem direito para acessar a Reimpressão de Documentos.');
    Exit;
  End;

  if (not cdsConsul.Active) or cdsConsul.IsEmpty then
    Exit;

  pImprimeDocumento(
    cdsConsul.FieldByName('NUMDOC').AsString,
    cdsConsul.FieldByName('ESPDOC').AsString,
    cdsConsul.FieldByName('CODEMP').AsString);
end;

procedure TfrmRelLiberacaoRemota.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pAbreConsulta, 'Aguarde, Carregando Solicitações...', '');
end;

procedure TfrmRelLiberacaoRemota.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pFechaConsulta;
end;

procedure TfrmRelLiberacaoRemota.btnImprimirClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsul.Active) or cdsConsul.IsEmpty then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(451, 28040, [],
                        ['DTAINI',
                         'DTAFIN',
                         'OPECAD',
                         'OBSERV',
                         'NUMDOC',
                         'ESPDOC',
                         'CODEMP',
                         'CODCLI',
                         'STATUS',
                         'ORDENA'],
                        [mskDtaIni.Text,
                         mskDtaFin.Text,
                         edtCodOpe.Text,
                         edtPalCha.Text,
                         edtNumDoc.Text,
                         edtEspDoc.Text,
                         edtCodEmp.Text,
                         edtCodCli.Text,
                         rdgStatus.Items[rdgStatus.ItemIndex],
                         rdgOrdena.Items[rdgOrdena.ItemIndex]],
                        nil,
                        nil);
end;

procedure TfrmRelLiberacaoRemota.btnAnalisarClick(Sender: TObject);
begin
  inherited;
  if (not cdsConsul.Active) or cdsConsul.IsEmpty then
    Exit;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  try
    frmObservacao.lblMensagem.Caption := 'Solicitação de Liberação';
    frmObservacao.memObs.Text := AnsiReplaceStr(cdsConsul.FieldByName('OBSERV').AsString, STRING_QUEBRA, sLineBreak);
    frmObservacao.memObs.Font.Name := 'Courier New';
    frmObservacao.Height := 600;
    frmObservacao.Width  := 1050;
    frmObservacao.BorderStyle := bsSizeable;
    frmObservacao.ShowModal;
  finally
    pFreeAndNil(frmObservacao);
  end;
end;

procedure TfrmRelLiberacaoRemota.btnCadClienteClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadClientes') Then
  Begin
    pMensagemOk('Você não tem direito para acessar o cadastro de Clientes.');
    Exit;
  End;

  if (not cdsConsul.Active) or cdsConsul.IsEmpty then
    Exit;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := cdsConsul.FieldByName('CODCLI').AsString;
    frmCadClientes.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadClientes);
end;

procedure TfrmRelLiberacaoRemota.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelLiberacaoRemota.edtCodOpeKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrSel) then
    Begin
      If (fValidaCampos(edtCodOpe, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelLiberacaoRemota.FormCreate(Sender: TObject);
begin
  inherited;
  blnPassarRadioButtonComEnter := False;
  WindowState := wsMaximized;
  qryCadCli := fCriaQuery(Self);

  cdsConsul := TZClient.Create(Self);
  dtsConsul.DataSet := cdsConsul;

  cxgConsultaView.ApplyBestFit();
end;

procedure TfrmRelLiberacaoRemota.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F5    : btnCadCliente.Click;
    VK_F6    : btnReimprimir.Click;
    VK_F7    : btnAnalisar.Click;
    VK_F8    : btnImprimir.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmRelLiberacaoRemota.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

function TfrmRelLiberacaoRemota.fSqlConsulta(blnVazio: Boolean): String;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT TEMP.*,';
  strSQL := strSQL + '        CONCAT(CODCLI, "-", CLI_NOMCLI) AS NOMCLI,';
  strSQL := strSQL + '        CONCAT(OPECAD, "-", CADOPEC.OPE_NOMOPE) NOMOPECAD,';
  strSQL := strSQL + '        CONCAT(CODVEN, "-", CADOPEV.OPE_NOMOPE) AS NOMVEN,';
  strSQL := strSQL + '        CONCAT(OPELIB, "-", CADOPEL.OPE_NOMOPE) AS NOMOPELIB,';
  strSQL := strSQL + '        CONCAT(NUMDOC, "-", ESPDOC) AS DOCUME,';
  strSQL := strSQL + '        CONCAT(CODEMP, "-", EMP_NOMEMP) AS EMPRES';
  strSQL := strSQL + ' FROM (';
  strSQL := strSQL + '   SELECT "Liberado" AS STATUS,';
  strSQL := strSQL + '          LOG_DTACAD AS DTACAD,';
  strSQL := strSQL + '          LOG_HRACAD AS HRACAD,';
  strSQL := strSQL + '          COALESCE(COALESCE(FG.FGO_CODDIG, MG.GER_CODDIG), NG.GER_CODDIG) AS OPECAD,';
  strSQL := strSQL + '          LOG_NUMDOC AS NUMDOC,';
  strSQL := strSQL + '          LOG_ESPDOC AS ESPDOC,';
  strSQL := strSQL + '          LOG_CODEMP AS CODEMP,';
  strSQL := strSQL + '          COALESCE(COALESCE(FG.FGO_CODCLI, MG.GER_CODCLI), NG.GER_CODCLI) AS CODCLI,';
  strSQL := strSQL + '          LOG_TITULO AS TITULO,';
  strSQL := strSQL + '          LOG_CODVEN AS CODVEN,';
  strSQL := strSQL + '          LOG_CODOPE AS OPELIB,';
  strSQL := strSQL + '          LOG_OBSERV AS OBSERV';
  strSQL := strSQL + '                   ';
  strSQL := strSQL + '   FROM LOGLIB';
  strSQL := strSQL + '   LEFT JOIN FATGOR FG ON FG.FGO_NUMDOC = LOG_NUMDOC AND FG.FGO_ESPDOC = LOG_ESPDOC AND FG.FGO_CODEMP = LOG_CODEMP';
  strSQL := strSQL + '   LEFT JOIN MOVGER MG ON MG.GER_NUMDOC = LOG_NUMDOC AND MG.GER_ESPDOC = LOG_ESPDOC AND MG.GER_CODEMP = LOG_CODEMP';
  strSQL := strSQL + '   LEFT JOIN NOTGER NG ON NG.GER_NUMDOC = LOG_NUMDOC AND NG.GER_ESPDOC = LOG_ESPDOC AND NG.GER_CODEMP = LOG_CODEMP';

  strSQL := strSQL + '   WHERE TRUE ';

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + '  AND LOG_CODEMP = :CODEMP ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    strSQL := strSQL + '  AND LOG_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If (Not fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL + '  AND COALESCE(COALESCE(FG.FGO_CODDIG, MG.GER_CODDIG), NG.GER_CODDIG) = :OPECAD ';

  If (Not fEmptyStr(edtPalCha.Text)) Then
    strSQL := strSQL + '  AND LOG_OBSERV LIKE :OBSERV ';

  If (Not fEmptyStr(edtNumDoc.Text)) Then
    strSQL := strSQL + '  AND LOG_NUMDOC = :NUMDOC ';

  If (Not fEmptyStr(edtEspDoc.Text)) Then
    strSQL := strSQL + '  AND LOG_ESPDOC = :ESPDOC ';

  If (Not fEmptyStr(edtCodCli.Text)) Then
    strSQL := strSQL + '  AND COALESCE(COALESCE(FG.FGO_CODCLI, MG.GER_CODCLI), NG.GER_CODCLI) = :CODCLI ';

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + '  AND TRUE ';
    1: strSQL := strSQL + '  AND FALSE ';
  End;

  strSQL := strSQL + '   ';
  strSQL := strSQL + '   UNION ALL';
  strSQL := strSQL + '   ';
  strSQL := strSQL + '   SELECT "Negado" AS STATUS,';
  strSQL := strSQL + '          NEG_DTAENV AS DTACAD,';
  strSQL := strSQL + '          NEG_HORENV AS HRACAD,';
  strSQL := strSQL + '          NEG_OPEENV AS OPECAD,';
  strSQL := strSQL + '          NULL AS NUMDOC,';
  strSQL := strSQL + '          NULL AS ESPDOC,';
  strSQL := strSQL + '          NEG_CODEMP AS CODEMP,';
  strSQL := strSQL + '          NEG_CODCLI AS CODCLI,';
  strSQL := strSQL + '          NEG_TITULO AS TITULO,';
  strSQL := strSQL + '          NULL AS CODVEN,';
  strSQL := strSQL + '          NEG_OPENEG AS OPELIB,';
  strSQL := strSQL + '          NEG_MSGENV AS OBSERV';
  strSQL := strSQL + '   FROM MSGNEG   ';

  strSQL := strSQL + '   WHERE TRUE ';

  If (Not fEmptyStr(edtCodEmp.Text)) Then
    strSQL := strSQL + '  AND NEG_CODEMP = :CODEMP ';

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    strSQL := strSQL + '  AND NEG_DTAENV BETWEEN :DTAINI AND :DTAFIN ';

  If (Not fEmptyStr(edtCodOpe.Text)) Then
    strSQL := strSQL + '  AND NEG_OPEENV = :OPECAD ';

  If (Not fEmptyStr(edtPalCha.Text)) Then
    strSQL := strSQL + '  AND NEG_MSGENV LIKE :OBSERV ';

  If (Not fEmptyStr(edtNumDoc.Text)) Then
    strSQL := strSQL + '  AND NULL = :NUMDOC ';

  If (Not fEmptyStr(edtEspDoc.Text)) Then
    strSQL := strSQL + '  AND NULL = :ESPDOC ';

  If (Not fEmptyStr(edtCodCli.Text)) Then
    strSQL := strSQL + '  AND NEG_CODCLI = :CODCLI ';

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + '  AND FALSE ';
    1: strSQL := strSQL + '  AND TRUE ';
  End;

  strSQL := strSQL + ' ) AS TEMP';
  strSQL := strSQL + ' LEFT JOIN CADEMP ON CODEMP = EMP_CODEMP';
  strSQL := strSQL + ' LEFT JOIN CADCLI ON CODCLI = CLI_CODCLI';
  strSQL := strSQL + ' LEFT JOIN CADOPE AS CADOPEC ON OPECAD = CADOPEC.OPE_CODOPE';
  strSQL := strSQL + ' LEFT JOIN CADOPE AS CADOPEV ON CODVEN = CADOPEV.OPE_CODOPE';
  strSQL := strSQL + ' LEFT JOIN CADOPE AS CADOPEL ON OPELIB = CADOPEL.OPE_CODOPE';
  strSQL := strSQL + ' WHERE ';

  If blnVazio Then
  Begin
    strSQL := strSQL + ' FALSE';
    Exit(strSQL);
  End;

  strSQL := strSQL + ' TRUE ';

  strSQL := strSQL + '  ORDER BY';
  Case rdgOrdena.ItemIndex Of
    0: strSQL := strSQL + ' DTACAD, HRACAD ';
    1: strSQL := strSQL + ' OPECAD, DTACAD, HRACAD ';
    2: strSQL := strSQL + ' CODCLI, DTACAD, HRACAD ';
  End;

  Result := strSQL;
End;

function TfrmRelLiberacaoRemota.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodCli) Then
  Begin
    If fEmptyStr(edtCodCli.Text) Then
    Begin
      edtNomCli.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaCliente;
      If (qryCadCli.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodOpe) Then
  Begin
    If fEmptyStr(edtCodOpe.Text) Then
    Begin
      edtNomOpe.Text := 'TODOS';
    End
    Else
    Begin
      pCarregaOperador;
      If fEmptyStr(edtNomOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse operador não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaFin) And (mskDtaFin.Enabled) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And  (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data inicial deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And  (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)))  Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&Ok']);
      Result := False;
    End

    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data final deve ser maior que a data inicial!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmRelLiberacaoRemota.pCarregaCliente;
begin
  pPesquisaCadCli(Nil, qryCadCli, edtCodCli.Text);
  edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
end;

procedure TfrmRelLiberacaoRemota.pCarregaOperador;
begin
  edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
end;

procedure TfrmRelLiberacaoRemota.pEscapePressed;
begin
  inherited;
  If (Not cdsConsul.IsEmpty) Then
    btnCancelaItem.Click
  Else
    btnSair.Click;
end;

procedure TfrmRelLiberacaoRemota.pFechaConsulta;
begin
  cdsConsul.Close;
  qryCadCli.Close;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodOpe.Clear;
  edtNomOpe.Clear;
  edtPalCha.Clear;
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;

//  pSetarControles(True);
  pSetFocus(mskDtaIni);
end;

Procedure TfrmRelLiberacaoRemota.pAbreConsulta;
Begin
  Try
    cxgConsulta.Enabled := False;

    cdsConsul.qryQuery.Close;

    cdsConsul.qryQuery.SQL.Text := fSqlConsulta(False);

    If (cdsConsul.qryQuery.FindParam('DTAINI') <> Nil) Then
    Begin
      cdsConsul.qryQuery.ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      cdsConsul.qryQuery.ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If (cdsConsul.qryQuery.FindParam('OPECAD') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('OPECAD').AsString := edtCodOpe.Text;

    If (cdsConsul.qryQuery.FindParam('OBSERV') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('OBSERV').AsString := '%' + edtPalCha.Text + '%';

    If (cdsConsul.qryQuery.FindParam('NUMDOC') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    If (cdsConsul.qryQuery.FindParam('ESPDOC') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    If (cdsConsul.qryQuery.FindParam('CODEMP') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If (cdsConsul.qryQuery.FindParam('CODCLI') <> Nil) Then
      cdsConsul.qryQuery.ParamByName('CODCLI').AsString := edtCodCli.Text;

    cdsConsul.fAbreClient(True, 'TfrmRelLiberacaoRemota.pAbreConsulta');

    cxgConsultaView.ApplyBestFit();

    cxgConsulta.Enabled := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmRelLiberacaoRemota.pAbreConsulta');
    End;
  End;

  pSetFocus(cxgConsulta);
end;

end.
