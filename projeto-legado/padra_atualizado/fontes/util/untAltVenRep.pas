{***************************}
{* qryConCli -> CADCLI     *}
{* qryConOpe -> CADOPE     *}
{************************JB*}
unit untAltVenRep;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Uni, ComCtrls, AppEvnts, QColorLabel, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Vcl.Mask, MaskEditFocus, StrUtils, untTypesSistema,
  ComboBoxFocus, UniClientDataSet;

type
  TfrmAltVenRep = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label3: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    Label5: TLabel;
    edtEstado: TEditFocus;
    Label6: TLabel;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    Label7: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    Label10: TLabel;
    edtDiaCon: TEditFocus;
    Label11: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    edtCodVe1: TEditFocus;
    edtDesVe1: TEditFocus;
    edtCodVe2: TEditFocus;
    edtDesVe2: TEditFocus;
    pgbStatus: TProgressBar;
    btnConfirma: TBitBtnLocked;
    grpModoConsidVendaCli: TGroupBox;
    grpPeriodoVendas: TGroupBox;
    chkPeriodoVendas: TCheckBox;
    grpDiasNaoCompra: TGroupBox;
    lblNaoCompraAcima: TLabel;
    lblDias: TLabel;
    edtNaoCompraAcima: TEditFocus;
    chkDiasNaoCompra: TCheckBox;
    lblVlrMinFat: TLabel;
    edtVlrMinFat: TEditFocus;
    lblQtdMinDocVen: TLabel;
    edtQtdMinDocVen: TEditFocus;
    lblPeriodoFat: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label8: TLabel;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    Label9: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    Label27: TLabel;
    cmbTabPre: TComboBoxFocus;
    chkNuncaComprou: TCheckBox;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodVe1KeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVe2KeyPress(Sender: TObject; var Key: Char);
    procedure chkDiasNaoCompraClick(Sender: TObject);
    procedure chkPeriodoVendasClick(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkNuncaComprouClick(Sender: TObject);
  private
    { Private declarations }
    intVenRep: Integer;
    FstrCampo: String;
    qryConCli: TUniQuery;
    qryConOpe: TUniQuery;
    arrRed: TConsultasArray;
    arrCidade: TConsultasArray;
    arrClientes: TConsultasArray;
    cdsAltCli: TUniClientDataSet;

    procedure pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
    procedure pIniciarComponentesTela;
    procedure pEventoCheckBox;
    function fSelectVendas: String;
    Function fSQLFromMovDet: String;
    Procedure pSetaParamMovDet(qryMovDet: TUniQuery; dtaDtaIni, dtaDtaFim: TDate);
    procedure pCriaAltCli;
    procedure pCarregaAltCli(qryCli: TUniQuery);
    function fConfirmaAtualizacao: Boolean;
    function fAtualizaRegistros: Boolean;
    procedure pHabilitaDesabilitaDiasNaoCompra(blnHabilita: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses SysUtils, Forms, untConsultas, untfuncoesSimples, untPesqAux,
  untPanelCxClientes, untPnlDadosCliente, untCadClientes, Data.DB,
  untConstantes, untFuncoesConsulta, untConfirmaAlteracaoRepVen,
  untLogAltCadCli;

{$R *.dfm}

procedure TfrmAltVenRep.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRed.Enabled := False;
    edtCodRed.Clear;
    pEdtCodSelectExit(edtCodRed,edtDesRed,arrRed, nil,fRetNomeRedeLoja,'da rede');
    pSetfocus(edtCodCid);
  End Else
  Begin
    edtCodRed.Enabled := True;
    pSetFocus(edtCodRed);
  End;
end;

procedure TfrmAltVenRep.edtCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    objfrmPnl  : TPanelCxClientes;
begin
  objfrmPnl := TPanelCxClientes.Create(TfrmPnlDadosCliente);
  Try
    {*******************************}
    {* NOVA CONSULTA DE CLIENTES   *}
    {****************************RV*}
    If fPesqCliente(conCliCompleta, Self, edtCodCli, edtNomCli, qryTabela, Key, arrClientes, False, objfrmPnl) And (Not edtCodCli.ReadOnly) Then
    Begin
      If (fValidaCampos(edtCodCli, True)) and (blnMudarFoco) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmAltVenRep.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRed) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVenRep.edtCodRegKeyPress(Sender: TObject; var Key: Char);
var
  arrReg : TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrReg) Then
  Begin
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVenRep.FormCreate(Sender: TObject);
begin
  inherited;
  intVenRep := fMensagem('','Opção:',['&Vendedor','&Represent.']);
  FstrCampo := IIF((intVenRep = 1), 'CLI_CODVEN', 'CLI_CODREP');

  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);

  pIniciarComponentesTela();
end;

procedure TfrmAltVenRep.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsAltCli);
end;

function TfrmAltVenRep.fSQLFromMovDet: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + 'WHERE    ';

  strSQL := strSQL + '  DET_CODEMP = :CODEMP                     AND ';
  strSQL := strSQL + '  DET_PROEMB <> "S"                        AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C"                         AND ';
  strSQL := strSQL + '  DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
  strSQL := strSQL + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';

  strSQL := strSQL + cnsFiltroFFDVTR;

  strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

  If (fCfgSis('ENTBRF', varBoolean)) Then
    strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    strSQL := strSQL + ') ';

  strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'DET_CODCLI', 'CODCLI');

//  If Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text)) Then
//    strSQL := strSQL + '  AND LOCATE(DET_ESPDOC, :ESPDOC) > 0 ';

  Result := strSQL;
End;

function TfrmAltVenRep.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  {*********************}
  {* VALIDA  EDTCODCLI *}
  {******************AF*}
  If (Sender = edtCodCli) Then
    pDesmarcaLista(edtCodCli, arrClientes)

  Else If (Sender = edtCodReg) Then
  Begin
    If Not fEmptyStr(edtCodReg.Text) Then
    Begin
      edtDesReg.Text := fRetNomRegiao(edtCodReg.Text);
      If fEmptyStr(edtDesReg.Text) Then
      Begin
        fMensagem('','Região não cadastrada!',['&Ok']);
        Result := False;
      End;
    End
    Else
      edtDesReg.Text := 'TODOS';
  End

  Else If (Sender = edtCodAti) Then
  Begin
    If Not fEmptyStr(edtCodAti.Text) Then
    Begin
      edtDesAti.Text := fCampoTabela('ATI_DESATI','CADATI',['ATI_CODATI'],[edtCodAti.Text]);
      If fEmptyStr(edtDesAti.Text) Then
      Begin
        fMensagem('','Atividade não cadastrada!',['&Ok']);
        Result := False;
      End;
    End
    Else
      edtDesAti.Text := 'TODOS';
  End

  Else If (Sender = edtNaoCompraAcima) Or (Sender = edtDiaCon) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','A quantidade de dias deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtQtdMinDocVen) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','A quantidade de documentos de venda deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtVlrMinFat) Then
  Begin
    If fStrToFloat(TEditFocus(Sender).Text) < 0 Then
    Begin
      fMensagem('','O valor mínimo de faturamento deve ser maior ou igual à zero!',['&Ok']);
      Result := False;
    End;
  End

  Else If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) And (chkPeriodoVendas.Checked) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (Sender = mskDtaFin) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&OK']);
            Result := False;
          End;
        End;
      End
    End;
  End

  Else If (Sender = edtStatus) Then
  Begin
    If Pos(edtStatus.Text, 'A_I_T_') <= 0 Then
    Begin
      fMensagem('','O status do cliente deve ser (A)tivo, (I)nativo ou (T)odos!',['&Ok']);
      Result := False;
    End;
  End

  {********************}
  {* VALIDA EDTCODVE1 *}
  {*****************AF*}
  Else If (Sender = edtCodVe1) Then
  Begin

    If fEmptyStr(edtCodVe1.Text) Then
      edtDesVe1.Text := 'TODOS'
    Else
    Begin
      pCarregaVendedor(edtCodVe1, edtDesVe1);
      If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor / representante não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;

  End

  {********************}
  {* VALIDA EDTCODCID *}
  {*****************AF*}
  Else If (Sender = edtCodCid) Then
    pDesmarcaLista(edtCodCid, arrCidade)

  {********************}
  {* VALIDA EDTCODVE2 *}
  {*****************AF*}
  Else If (Sender = edtCodVe2) Then
  Begin

    If fEmptyStr(edtCodVe2.Text) Then
    Begin
      fMensagem('','O Vendedor / Representante novo deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin
      pCarregaVendedor(edtCodVe2, edtDesVe2);
      If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse vendedor / representante não está cadastrado!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodRed) Then
  Begin

    If Not fEmptyStr(edtCodRed.Text) Then
    Begin
      edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text);
      If fEmptyStr(edtDesRed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esta rede não está cadastrada!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      edtDesRed.Text := 'TODAS';
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmAltVenRep.edtCodVe1KeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVe1, edtDesVe1, qryConOpe, Key, arrSel) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVenRep.edtCodVe2KeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodVe2, edtDesVe2, qryConOpe, Key, arrSel) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAltVenRep.fAtualizaRegistros: Boolean;
  Var
    LogAltCadCli : TLogAltCadCli;
    strUpdCadCli : String;
begin
  Result := True;
  cdsAltCli.Filtered := False;
  cdsAltCli.Filter := 'MARDES=1';
  cdsAltCli.Filtered := True;
  cdsAltCli.First;

  pgbStatus.Visible := True;
  pgbStatus.Max := cdsAltCli.RecordCount;

  LogAltCadCli := TLogAltCadCli.Create(Self);
  Try
    fStartTransaction;

    while not cdsAltCli.Eof do
    begin
      LogAltCadCli.pLogAdd('CADCLI', ['AUTOINCREM'], 'CLI_CODCLI = ' + QuotedStr(cdsAltCli.FieldByName('CODCLI').AsString), pSetaDisplayLabelCadCli);
      LogAltCadCli.LogVar.Clear;
      LogAltCadCli.LogVar.AddOrSetValue(FstrCampo, strLoginUsuarioLogado);

      TfrmCadClientes.fGeraLogLimiteStatusCliente(cdsAltCli.FieldByName('CODCLI').AsString,
                                                  VS_Date,
                                                  fTime(),
                                                  strLoginUsuarioLogado,
                                                  FstrCampo,
                                                  cdsAltCli.FieldByName('CODVENREPANT').AsString,
                                                  edtCodVe2.Text,
                                                  0,
                                                  0);
      strUpdCadCli := '';
      strUpdCadCli := strUpdCadCli + ' UPDATE CADCLI SET ';
      strUpdCadCli := strUpdCadCli + '   ' + FstrCampo + ' = "' + edtCodVe2.Text + '", ';
      strUpdCadCli := strUpdCadCli + '   CLI_DTAALT = "' + FormatDateTime('yyyy-mm-dd', VS_Date) + '", ';
      strUpdCadCli := strUpdCadCli + '   CLI_CODOPE = "' + strLoginUsuarioLogado + '" ';
      strUpdCadCli := strUpdCadCli + ' WHERE CLI_CODCLI = "' + cdsAltCli.FieldByName('CODCLI').AsString + '" ';

      Result := fExecutaSQL(strUpdCadCli);

      if (intVenRep = 1) then
        Result := Result and fExecutaSQL(' UPDATE AGETEL SET AGE_CODVEN = "'  + edtCodVe2.Text + '" WHERE AGE_CODCLI = "' + cdsAltCli.FieldByName('CODCLI').AsString + '" AND AGE_DTABAI IS NULL');

      If Result Then
        LogAltCadCli.pProcessarLogs;

      if (not Result) then
      begin
        fRollback;
        Exit;
      end;

      cdsAltCli.Next;
      pnlInfo.Caption    := 'Registro: ' + IntToStr(cdsAltCli.RecNo) + '/' + IntToStr(cdsAltCli.RecordCount);
      pgbStatus.Position := cdsAltCli.RecNo;
      Application.ProcessMessages;
    end;

    fCommit;
  Finally
    FreeAndNil(LogAltCadCli);
  End;
end;

procedure TfrmAltVenRep.pCarregaAltCli(qryCli: TUniQuery);
begin
  cdsAltCli.EmptyDataSet;
  qryCli.First;

  while not qryCli.Eof do
  begin
    cdsAltCli.Append;
    cdsAltCli.FieldByName('CODCLI').AsString := qryCli.FieldByName('CLI_CODCLI').AsString;
    cdsAltCli.FieldByName('NOMCLI').AsString := qryCli.FieldByName('CLI_NOMCLI').AsString;
    cdsAltCli.FieldByName('ULTCOM').AsString := qryCli.FieldByName('CLI_ULTCOM').AsString;
    cdsAltCli.FieldByName('CODVENREPANT').AsString := qryCli.FieldByName(FstrCampo).AsString;
    cdsAltCli.FieldByName('CODVENREPNOV').AsString := edtCodVe2.Text;
    cdsAltCli.FieldByName('VENREPANT').AsString := qryCli.FieldByName(FstrCampo).AsString + '-' + fRetNomeOperador(qryCli.FieldByName(FstrCampo).AsString);
    cdsAltCli.FieldByName('VENREPNOV').AsString := edtCodVe2.Text + '-' + edtDesVe2.Text;
    cdsAltCli.FieldByName('MARDES').AsInteger := 1;
    cdsAltCli.Post;

    qryCli.Next;
  end;

  cdsAltCli.First;
end;

procedure TfrmAltVenRep.pCarregaVendedor(edtCodigo, edtNome: TEditFocus);
begin

  pPesquisaCadOpe(qryConOpe, qryConOpe, edtCodigo.Text);

  With qryConOpe Do
    edtNome.Text := FieldByName('OPE_NOMOPE').AsString;

end;

function TfrmAltVenRep.fConfirmaAtualizacao: Boolean;
var
  frmConfirmaAlteracaoRepVen: TfrmConfirmaAlteracaoRepVen;
begin
  pCriarFormularios(TfrmConfirmaAlteracaoRepVen, frmConfirmaAlteracaoRepVen);

  try
    frmConfirmaAlteracaoRepVen.cdsGrid := cdsAltCli;
    frmConfirmaAlteracaoRepVen.intVenRep := intVenRep;
    frmConfirmaAlteracaoRepVen.ShowModal;

    Result := frmConfirmaAlteracaoRepVen.blnConfirma;
  finally
    pFreeAndNil(frmConfirmaAlteracaoRepVen);
  end;
end;

procedure TfrmAltVenRep.pCriaAltCli;
var
  aggTotSel: TAggregateField;
begin
  cdsAltCli := TUniClientDataSet.Create(Self);
  cdsAltCli.AggregatesActive := True;
  cdsAltCli.FieldDefs.Add('CODCLI', ftString, 8);
  cdsAltCli.FieldDefs.Add('NOMCLI', ftString, 60);
  cdsAltCli.FieldDefs.Add('ULTCOM', ftDate);
  cdsAltCli.FieldDefs.Add('CODVENREPANT', ftString, 3);
  cdsAltCli.FieldDefs.Add('CODVENREPNOV', ftString, 3);
  cdsAltCli.FieldDefs.Add('VENREPANT', ftString, 60);
  cdsAltCli.FieldDefs.Add('VENREPNOV', ftString, 60);
  cdsAltCli.FieldDefs.Add('MARDES', ftInteger);

  aggTotSel := TAggregateField.Create(cdsAltCli);

  aggTotSel.FieldName := 'TOTSEL';
  aggTotSel.Expression := 'SUM(MARDES)';
  aggTotSel.Active := True;
  aggTotSel.DataSet := cdsAltCli;
  aggTotSel.Active := True;

  cdsAltCli.CreateDataSet;
end;

procedure TfrmAltVenRep.pEventoCheckBox;
begin
  chkPeriodoVendas.Checked := (Not chkDiasNaoCompra.Checked) And (chkPeriodoVendas.Checked);
  edtQtdMinDocVen.Enabled  := (chkPeriodoVendas.Checked);
  edtVlrMinFat.Enabled     := (chkPeriodoVendas.Checked);
  mskDtaIni.Enabled        := (chkPeriodoVendas.Checked);
  mskDtaFin.Enabled        := (chkPeriodoVendas.Checked);

  edtQtdMinDocVen.Text  := '0';
  edtVlrMinFat.Text     := '0,00';
  mskDtaIni.Text        := '__/__/____';
  mskDtaFin.Text        := '__/__/____';

  chkDiasNaoCompra.Checked  := (chkDiasNaoCompra.Checked) And (Not chkPeriodoVendas.Checked);
  edtNaoCompraAcima.Enabled := (chkDiasNaoCompra.Checked);

  edtNaoCompraAcima.Text    := '0';
end;

procedure TfrmAltVenRep.pIniciarComponentesTela;
begin
  chkPeriodoVendas.Checked := False;
  edtQtdMinDocVen.Enabled  := False;
  edtVlrMinFat.Enabled     := False;
  mskDtaIni.Enabled        := False;
  mskDtaFin.Enabled        := False;

  edtQtdMinDocVen.Text  := '0';
  edtVlrMinFat.Text     := '0,00';
  mskDtaIni.Text        := '__/__/____';
  mskDtaFin.Text        := '__/__/____';

  chkDiasNaoCompra.Checked  := True;
  edtNaoCompraAcima.Enabled := True;

  edtNaoCompraAcima.Text    := '0';

  pCriaAltCli;
end;

function TfrmAltVenRep.fSelectVendas: String;
  Var
    strSQL       : String;
    strSQLUnion  : String;
    //strSQLMovGer : String;
    //strSQLNotGer : String;
    //strSQLFatGor : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DET_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  COUNT(*) AS QTDDOC, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENVIS, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG<> "01000" AND DET_ESPDOC NOT IN ("TR","DV") AND LEFT(DET_CLAFIS,1) >= 5, IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)),0.00)) AS VENPRA, ';
  strSQL := strSQL + '  SUM(IF(DET_ESPDOC IN ("TR","DV") OR LEFT(DET_CLAFIS,1) < 5, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE-DET_DESESP-DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF),0.00)) AS VENDEV, ';
  strSQL := strSQL + '  SUM(IF(DET_CONPAG = "01000", (IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)), 0)) AS AVIDIA, ';
  strSQL := strSQL + '  SUM(IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF)) AS VENDIA ';

  strSQL := strSQL + fSQLFromMovDet;

  strSQL := strSQL + ' GROUP BY     ';
  strSQL := strSQL + '   DET_CODCLI ';

  strSQL := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);

  strSQLUnion := strSQL;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CODCLI, ';
  strSQL := strSQL + '  QTDDOC, ';
  strSQL := strSQL + '  SUM(VENVIS) AS VENVIS, ';
  strSQL := strSQL + '  SUM(VENPRA) AS VENPRA, ';
  strSQL := strSQL + '  SUM(VENDEV) AS VENDEV, ';
  strSQL := strSQL + '  SUM(AVIDIA) AS AVIDIA, ';
  strSQL := strSQL + '  SUM(VENDIA) AS VENDIA  ';
  strSQL := strSQL + 'FROM   ';
  strSQL := strSQL + '(';

  strSQL := strSQL +  strSQLUnion;

  strSQL := strSQL + ') AS TMP_TABELA ';

  strSQL := strSQL + ' GROUP BY    ';
  strSQL := strSQL + '   CODCLI    ';

  Result := ' (' + strSQL + ') AS TMP_VENDAS ';
End;

procedure TfrmAltVenRep.pSetaParamMovDet(qryMovDet: TUniQuery; dtaDtaIni,
  dtaDtaFim: TDate);
begin
  With qryMovDet Do Begin
    ParamByName('DTAINI').AsDate   := dtaDtaIni;
    ParamByName('DTAFIN').AsDate   := dtaDtaFim;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

//    If (Not fEmptyStr(fTiraCaracEspeciais(mskEspecie.Text))) And
//       (Params.FindParam('ESPDOC') <> Nil) Then
//      ParamByName('ESPDOC').AsString := mskEspecie.Text;
  End;
end;

procedure TfrmAltVenRep.btnConfirmaClick(Sender: TObject);
  Var
    qryGen   : TUniQuery;
    strSQL   : String;
    strLinCid: String;
    strLinCli: String;

    function fConfirma: Boolean;
    begin
      Result := fVerificaCampos;

      If Result And fEmptyStr(edtCodVe1.Text) Then
        Result := fMensagem('','O vendedor/Representante anterior não foi informado, sendo assim ' +
                               'todos os clientes que satisfaçam os filtros código/cidade serão alterados. ' + #13#10 +
                               'Deseja realmente continuar?',['&Sim', '&Não'], 2) = 1;
    end;

begin
  inherited;

  If (not fConfirma) Then
    Exit;

  Self.Enabled := False;
  qryGen := fCriaQuery;

  try
    try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_CODCLI, ';
      strSQL := strSQL + '  CLI_NOMCLI, ';
      strSQL := strSQL + '  CLI_ULTCOM, ';
      strSQL := strSQL + FstrCampo + ' ' ;
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';

      If (chkPeriodoVendas.Checked) Then
        strSQL := strSQL + ' INNER JOIN ' + fSelectVendas() + ' ON CADCLI.CLI_CODCLI = TMP_VENDAS.CODCLI ';

      strSQL := strSQL + 'WHERE  ';
      strSQL := strSQL + '  TRUE ';

      If Not fEmptyStr(edtCodVe1.Text) Then
        strSQL := strSQL + '  AND ' + FstrCampo + ' = "' + edtCodVe1.Text + '" ';

      strSQL := strSQL + fStrLocate(edtCodCid,arrCidade,'CLI_CODCID', 'CODCID');
      strSQL := strSQL + fStrLocate(edtCodCli,arrClientes,'CLI_CODCLI', 'CODCLI');

      If Not fEmptyStr(edtCodReg.Text) Then
        strSQL := strSQL + '  AND CLI_CODREG = "' + edtCodReg.Text + '" ';

      If Not fEmptyStr(edtCodAti.Text) Then
        strSQL := strSQL + '  AND CLI_CODATI = "' + edtCodAti.Text + '" ';

      If edtStatus.Text <> 'T' Then
        strSQL := strSQL + '  AND CLI_STATUS = "' + edtStatus.Text + '" ';

      If (chkDiasNaoCompra.Checked) And (chkNuncaComprou.Checked) Then
      Begin
        strSQL := strSQL + '  AND CLI_ULTCOM IS NULL ';
      End
      Else If (chkDiasNaoCompra.Checked) And (fStrToFloat(edtNaoCompraAcima.Text) >= 0) Then
      Begin
        strSQL := strSQL + '  AND CLI_ULTCOM IS NOT NULL ';
        strSQL := strSQL + '  AND CLI_ULTCOM < DATE_SUB(' + fCurrentDate + ', INTERVAL ' + edtNaoCompraAcima.Text + ' DAY) ';
      End;

      If (chkPeriodoVendas.Checked) Then
      Begin
        If fStrToFloat(edtQtdMinDocVen.Text) > 0 Then
          strSQL := strSQL + '  AND TMP_VENDAS.QTDDOC >= :QTDDOC ';

        If fStrToFloat(edtVlrMinFat.Text) > 0 Then
          strSQL := strSQL + '  AND (TMP_VENDAS.VENVIS + TMP_VENDAS.VENPRA + TMP_VENDAS.VENDEV + TMP_VENDAS.AVIDIA + TMP_VENDAS.VENDIA) >= :VALFAT ';
      End;

      If fStrToFloat(edtDiaCon.Text) > 0 Then
      Begin
        strSQL := strSQL + '  AND (SELECT AGE_DTABAI FROM AGETEL WHERE AGE_CODCLI = CLI_CODCLI AND AGE_DTABAI IS NOT NULL ORDER BY AGE_DTABAI DESC LIMIT 1) ';
        strSQL := strSQL + '       < DATE_SUB(' + fCurrentDate + ', INTERVAL ' + edtDiaCon.Text + ' DAY) ';
      End;

      If Not fEmptyStr(edtCodRed.Text) Then
        strSQL := strSQL + '  AND CLI_CODRED = "' + edtCodRed.Text + '" ';

      If Not fEmptyStr(cmbTabPre.Items[cmbTabPre.ItemIndex]) Then
        strSQL := strSQL + ' AND CLI_TABPRE = ' + QuotedStr(cmbTabPre.Items[cmbTabPre.ItemIndex]);

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);

      If (chkPeriodoVendas.Checked) And (fStrToFloat(edtQtdMinDocVen.Text) > 0) Then
        qryGen.ParamByName('QTDDOC').AsFloat := fStrToFloat(edtQtdMinDocVen.Text);

      If (chkPeriodoVendas.Checked) And (fStrToFloat(edtVlrMinFat.Text) > 0) Then
        qryGen.ParamByName('VALFAT').AsFloat := fStrToFloat(edtVlrMinFat.Text);

      If (chkPeriodoVendas.Checked) Then
        pSetaParamMovDet(qryGen, StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text));

      pSetaParam(edtCodCli.Text, arrClientes, strLinCli, 'CODCLI', qryGen);
      pSetaParam(edtCodCid.Text, arrCidade, strLinCid, 'CODCID', qryGen);

      qryGen.Open;

      if qryGen.IsEmpty then
      begin
        fMensagem('','Nenhum cliente foi encontrado com estes dados!',['&OK']);
        Exit;
      end;

      pCarregaAltCli(qryGen);
      if (not fConfirmaAtualizacao) then
        Exit;

      if fAtualizaRegistros then
        fMensagem('','Troca efetuada com sucesso!',['&OK']);
    Except
      On E: Exception Do
      Begin
        fRollback;
        pMensagensErro(E.Message,'[TfrmAltVenRep.btnConfirmaClick]');
      End;
    End;
  finally
    FreeAndNil(qryGen);
    cdsAltCli.Filtered := False;
    cdsAltCli.EmptyDataSet;
    pgbStatus.Visible := False;
    Self.Enabled := True;
    pnlInfo.Caption := '';
    SelectFirst;
  end;
end;

procedure TfrmAltVenRep.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');

  If (fEmptyStr(edtNomCid.Text)) Or (edtNomCid.Text = '+1') Or (edtNomCid.Text = 'TODOS') Then
    edtEstado.Text := EmptyStr
  Else
    edtEstado.Text := fRetNomCidade(edtCodCid.Text, 1);
end;

procedure TfrmAltVenRep.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    if fValidaCampos(edtCodCid, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVenRep.chkDiasNaoCompraClick(Sender: TObject);
begin
  inherited;

  chkPeriodoVendas.OnClick := nil;
  chkPeriodoVendas.Checked := (Not chkPeriodoVendas.Checked);
  pEventoCheckBox();
  chkPeriodoVendas.OnClick := chkPeriodoVendasClick;
end;

procedure TfrmAltVenRep.chkNuncaComprouClick(Sender: TObject);
begin
  inherited;
  pHabilitaDesabilitaDiasNaoCompra(Not chkNuncaComprou.Checked);
end;

procedure TfrmAltVenRep.chkPeriodoVendasClick(Sender: TObject);
begin
  inherited;

  chkDiasNaoCompra.OnClick := nil;
  chkDiasNaoCompra.Checked := (Not chkDiasNaoCompra.Checked);
  pEventoCheckBox();
  chkDiasNaoCompra.OnClick := chkDiasNaoCompraClick;
end;

procedure TfrmAltVenRep.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrAtiv: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
  Begin
    If fValidaCampos(edtCodAti, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltVenRep.pHabilitaDesabilitaDiasNaoCompra(blnHabilita: Boolean);
begin
  lblNaoCompraAcima.Enabled := blnHabilita;
  edtNaoCompraAcima.Enabled := blnHabilita;
  lblDias.Enabled := blnHabilita;
  edtNaoCompraAcima.Text := IIF(blnHabilita, '0', '');
end;

end.
