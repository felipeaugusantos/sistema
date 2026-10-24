unit untRelCtrExportaCobranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, QColorLabel, EditFocus, Vcl.Mask, MaskEditFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  DirectoryEditFocus, untTypesSistema, Clipbrd, Uni, Data.DB, Vcl.ComCtrls,
  dxCore, cxDateUtils, cxDropDownEdit, cxCalendar, untFrameCentroCustoEditFocus,
  untFrameDirectoryEditFocus;

type
  TfrmRelCtrExportaCobranca = class(TfrmPai)
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    lblPortador: TLabel;
    lblEmpresa: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    lblCndPag: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    Label7: TLabel;
    lblAtivid: TLabel;
    edtCodCliente: TEditFocus;
    edtCodPor: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesCliente: TEditFocus;
    edtDesPortador: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodRep: TEditFocus;
    edtNomRep: TEditFocus;
    edtExcPor: TEditFocus;
    edtDesExcPortador: TEditFocus;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    edtRedLoj: TEditFocus;
    edtDesRedLoj: TEditFocus;
    edtCodCnd: TEditFocus;
    edtDesCnd: TEditFocus;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtPorCli: TEditFocus;
    edtDesPorCli: TEditFocus;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    Label9: TLabel;
    edtEspDoc: TEditFocus;
    gpbTipCliente: TGroupBox;
    ColorLabel7: TColorLabel;
    edtTipCliente: TEditFocus;
    gbpDupDesc: TGroupBox;
    ColorLabel2: TColorLabel;
    edtDupDesc: TEditFocus;
    gpbOpcValor: TGroupBox;
    Label15: TLabel;
    edtValIni: TEditFocus;
    cbxValor: TComboBox;
    edtValFin: TEditFocus;
    rdgEmpresa: TRadioGroup;
    Label13: TLabel;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    btnConfirma: TBitBtnLocked;
    fraCaminho: TfraDirectoryEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskCadIni: TcxDateEdit;
    mskCadFin: TcxDateEdit;
    fraCentroCusto: TfraCentroCustoEditFocus;
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtExcPorExit(Sender: TObject);
    procedure edtExcPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtRedLojExit(Sender: TObject);
    procedure edtRedLojKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure cbxValorChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
  private
    arrClientes,
    arrEmpresa,
    arrPortador,
    arrPorCli,
    arrExcetPor,
    arrEvento,
    arrCidade,
    arrVendedor,
    arrRepresentante,
    arrRegiao,
    arrSubReg,
    arrRedeLojas,
    arrCndPag,
    arrAtivid,
    arrDepart : TConsultasArray;
    strEmpresa,
    strClientes,
    strPortador,
    strPorCli,
    strExcetPor,
    strEvento,
    strCidade,
    strVendedor,
    strRepresentante,
    strRegiao,
    strSubReg,
    strRedeLojas,
    strConPag,
    strAtivid,
    strDepart,
    strAceCtr,
    strCodVen,
    strCodRep : String;
    qryDados: TUniQuery;
    function fMontaSQL(): String;
    procedure pSetaParametros(qryDados: TUniQuery);
    procedure pExportaDados();
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untSelCtrExportaCobranca, untClassPanelCx, untIFuncoes, untFuncoesSimples,
     untConsultas, untFuncoes, untCfgRel, untPesqAux, untFuncoesConsulta, untMemo,
     untFuncoesRel, untFuncoesRel2;

procedure TfrmRelCtrExportaCobranca.btnConfirmaClick(Sender: TObject);
  Var
    frmSelCtrExportaCobranca: TfrmSelCtrExportaCobranca;
begin
  inherited;
  If fVerificaCampos Then
  Begin
    qryDados.SQL.Text := fMontaSQL();
    pSetaParametros(qryDados);
    qryDados.Open;

    qryDados.FieldByName('MARDES').ReadOnly := False;
    TFloatField(qryDados.FieldByName('CTR_VALORI')).DisplayFormat := '0.00';

    frmSelCtrExportaCobranca := TfrmSelCtrExportaCobranca.Create(nil);
    try
      frmSelCtrExportaCobranca.DataSet := qryDados;
      if frmSelCtrExportaCobranca.ShowModal = mrOk then
      begin
        fExecutarModal(pExportaDados, 'Aguarde... Gerando arquivo de cobrança.', '');
        Close;
      end;
    finally
      FreeAndNil(frmSelCtrExportaCobranca);
    end;
  End;
end;

procedure TfrmRelCtrExportaCobranca.cbxValorChange(Sender: TObject);
begin
  inherited;
  case cbxValor.ItemIndex Of
    0: Begin
         edtValIni.Text    := '0,00';
         edtValFin.Text    := '0,00';
         edtValIni.Enabled := False;
         edtValFin.Enabled := False;
       End;
    1,
    2: Begin
         edtValFin.Text    := '0,00';
         edtValIni.Enabled := True;
         edtValFin.Enabled := False;
       End;
    3: Begin
         edtValIni.Enabled := True;
         edtValFin.Enabled := True;
       End;
  end;
end;

procedure TfrmRelCtrExportaCobranca.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAtivid, Nil, fRetNomAtividade, 'do atividade');
end;

procedure TfrmRelCtrExportaCobranca.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtivid, False) Then
	Begin
		fValidaCampos(edtCodAti, False);
		Self.SelectNext(ActiveControl, True, True);
	End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodCidExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCid.ReadOnly Then
    pEdtCodSelectExit(edtCodCid, edtDesCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da cidade');
end;

procedure TfrmRelCtrExportaCobranca.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtDesCid, Nil, Nil, Key, arrCidade, False) Then
  Begin
    fValidaCampos(edtCodCid, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  If Not edtCodCliente.ReadOnly Then
    pEdtCodSelectExit(edtCodCliente, edtDesCliente, arrClientes, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCliente.Text) Then
  Begin
    edtRedLoj.Enabled := False;
    edtRedLoj.Clear;
    pEdtCodSelectExit(edtRedLoj,edtDesRedLoj,arrRedeLojas,nil,fRetNomeRedeLoja,'da rede');
  End Else
    edtRedLoj.Enabled := True;
end;

procedure TfrmRelCtrExportaCobranca.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd,edtDesCnd,arrCndPag,fRetDesConPag,Nil,'da Condição de Pagamento');
end;

procedure TfrmRelCtrExportaCobranca.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Not fCfgSis('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepart, fRetDescDepartamento, Nil, 'do departamento');
end;

procedure TfrmRelCtrExportaCobranca.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, Nil, 'da empresa');
end;

procedure TfrmRelCtrExportaCobranca.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True, '', True, strAceCtr) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmpresa.Text) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodRegExit(Sender: TObject);
begin
  inherited;
  If Not edtCodReg.ReadOnly Then
    pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, fRetDesReg, Nil, 'da região');
end;

procedure TfrmRelCtrExportaCobranca.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodRepExit(Sender: TObject);
begin
  inherited;
  If Not edtCodRep.ReadOnly Then
    pEdtCodSelectExit(edtCodRep, edtNomRep, arrRepresentante, fRetNomVendRep, Nil, 'do representante');
end;

procedure TfrmRelCtrExportaCobranca.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodRep, edtNomRep, nil, Key, arrRepresentante, False) Then
  Begin
    fValidaCampos(edtCodRep,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSubReg, nil, fRetNomSubRegiao, 'da Sub-Região');
end;

procedure TfrmRelCtrExportaCobranca.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSubReg, False) Then
  Begin
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtCodVenExit(Sender: TObject);
begin
  inherited;
  If Not edtCodVen.ReadOnly Then
    pEdtCodSelectExit(edtCodVen, edtNomVen, arrVendedor, fRetNomVendRep, Nil, 'do vendedor');
end;

procedure TfrmRelCtrExportaCobranca.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVendedor, False) Then
  Begin
    fValidaCampos(edtCodVen,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtExcPorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtExcPor.Text) Then
    edtDesExcPortador.Text := 'NENHUM';
end;

procedure TfrmRelCtrExportaCobranca.edtExcPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtExcPor, edtDesExcPortador, nil, Key, arrExcetPor, False) Then
  Begin
    If fValidaCampos(edtExcPor,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtPorCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtPorCli, edtDesPorCli, nil, Key, arrPorCli, False) Then
  Begin
    If fValidaCampos(edtPorCli, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrExportaCobranca.edtRedLojExit(Sender: TObject);
begin
  inherited;
  If Not edtRedLoj.ReadOnly Then
    pEdtCodSelectExit(edtRedLoj, edtDesRedLoj, arrRedeLojas, nil, fRetNomeRedeLoja, 'da rede de lojas');
end;

procedure TfrmRelCtrExportaCobranca.edtRedLojKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtRedLoj, edtDesRedLoj, Nil, Key, arrRedeLojas, False) Then
  Begin
    If fValidaCampos(edtRedLoj, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelCtrExportaCobranca.fMontaSQL: String;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                        ';
  strSQL := strSQL + '  EMP_C_G_C_,                 ';
  strSQL := strSQL + '  EMP_NOMEMP,                 ';
  strSQL := strSQL + '  CLI_C_G_C_,                 ';
  strSQL := strSQL + '  CLI_NOMCLI,                 ';
  strSQL := strSQL + '  CLI_ENDERE,                 ';
  strSQL := strSQL + '  CLI_ENDNUM,                 ';
  strSQL := strSQL + '  CLI_ENDCOM,                 ';
  strSQL := strSQL + '  CLI_BAIRRO,                 ';
  strSQL := strSQL + '  CID_NOMCID,                 ';
  strSQL := strSQL + '  CID_ESTADO,                 ';
  strSQL := strSQL + '  CLI_C_E_P_,                 ';
  strSQL := strSQL + '  CLI_FONE01,                 ';
  strSQL := strSQL + '  CTR_NUMDUP,                 ';
  strSQL := strSQL + '  CTR_PARCEL,                 ';
  strSQL := strSQL + '  CTR_DTACAD,                 ';
  strSQL := strSQL + '  CTR_DTAVEN,                 ';
  strSQL := strSQL + '  CTR_VALORI,                 ';
  strSQL := strSQL + '  CTR_VALDUP,                 ';
  strSQL := strSQL + '  CTR_ESPDOC,                 ';
  strSQL := strSQL + '  CTR_CODEMP,                 ';
  strSQL := strSQL + '  CTR_CODCLI,                 ';
  strSQL := strSQL + '  ''S'' AS MARDES,            ';
  strSQL := strSQL + '  CADREC.AUTOINCREM AS INCCTR ';
  strSQL := strSQL + 'FROM                          ';
  strSQL := strSQL + '  CADREC                      ';
  strSQL := strSQL + 'INNER JOIN CADEMP             ';
  strSQL := strSQL + '  ON EMP_CODEMP = CTR_CODEMP  ';
  strSQL := strSQL + 'INNER JOIN CADCLI             ';
  strSQL := strSQL + '  ON CLI_CODCLI = CTR_CODCLI  ';
  strSQL := strSQL + 'INNER JOIN CADCID             ';
  strSQL := strSQL + '  ON CID_CODCID = CLI_CODCID  ';
  strSQL := strSQL + 'WHERE CTR_DTAREC IS NULL      ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    strSQL := strSQL + '  AND CTR_DTACAD BETWEEN :CADINI AND :CADFIN ';

  If Not fEmptyStr(edtDesCliente.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCliente,  arrClientes,  'CLI_CODCLI', 'CODCLI');

  If Not fEmptyStr(edtDesPortador.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor,  arrPortador,  'CTR_CODPOR', 'CODPOR')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If Not fEmptyStr(edtDesCnd.Text) then
    strSQL := strSQL + fStrLocate(edtCodCnd, arrCndPag, 'CTR_CODCND', 'CODCND');

  If Not fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
    strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve,  arrEvento,  'CTR_CODEVE', 'CODEVE');

  If Not fEmptyStr(edtDesPorCli.Text) Then
    strSQL := strSQL + fStrLocate(edtPorCli,  arrPorCli,  'CLI_CODPOR', 'PORCLI')
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CLI_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CLI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  If Not fEmptyStr(edtNomVen.Text) Then
    strSQL := strSQL + fStrLocate(edtCodVen,  arrVendedor,  'CTR_CODVEN', 'CODVEN', False, False, strCodVen);

  Case rdgEmpresa.ItemIndex Of
    0: Begin
      If (edtDesEmpresa.Text = 'TODOS') Or (edtDesEmpresa.Text = '') Then
        strSQL := strSQL + '  AND (LOCATE(CTR_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 OR LOCATE(CTR_CODEMP,' + QuotedStr(strAceCtr) + ') > 0) '
      else
        strSql := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'CTR_CODEMP', 'CODEMP');
    End;
    1: Begin
      If (edtDesEmpresa.Text = 'TODOS') Or (edtDesEmpresa.Text = '') Then
        strSQL := strSQL + '  AND (LOCATE(IFNULL(CTR_EMP_PD, CTR_CODEMP),' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 OR LOCATE(IFNULL(CTR_EMP_PD, CTR_CODEMP),' + QuotedStr(strAceCtr) + ') > 0) '
      else
        strSql := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IFNULL(CTR_EMP_PD, CTR_CODEMP)', 'CODEMP');
    End;
  End;

  If Not fEmptyStr(edtDesReg.Text) Then
    strSQL := strSQL + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');

  If Not fEmptyStr(edtExcPor.Text) Then
  Begin
    If Length(arrExcetPor) > 1 Then
    Begin
      strSQL := strSQL + '  AND ((' + fStrLocate(edtExcPor, arrExcetPor,  'CTR_CODPOR', 'EXCPOR', True, True) + ')';
      strSQL := strSQL + '  OR (CTR_CODPOR IS NULL)) ';
    End
    Else
      strSQL := strSQL + '  AND IFNULL(CTR_CODPOR, "") <> :EXCPOR ';
  End;

  If Not fEmptyStr(edtDesAti.Text) Then
    strSQL := strSQL + fStrLocate(edtCodAti,  arrAtivid,  'ATI_CODATI', 'CODATI');

  If Not fEmptyStr(edtDesCid.Text) Then
    strSQL := strSQL + fStrLocate(edtCodCid, arrCidade,  'CLI_CODCID', 'CODCID');

  If Not fEmptyStr(edtRedLoj.Text) Then
    strSQL := strSQL + fStrLocate(edtRedLoj, arrRedeLojas, 'CLI_CODRED', 'CODRED');

  If Not fEmptyStr(edtNomRep.Text) Then
    strSQL := strSQL + fStrLocate(edtCodRep,  arrRepresentante,  'CLI_CODREP', 'CODREP', False, False, strCodRep);

  If Not fEmptyStr(edtDesDep.Text) Then
    strSQL := strSQL + fStrLocate(edtCodDep,  arrDepart,  'OPE_CODDEP', 'CODDEP');

  If Not fEmptyStr(edtDesSub.Text) Then
    strSQL := strSQL + fStrLocate(edtCodSub, arrSubReg, 'CLI_CODSUB', 'CODSUB');

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

  If edtTipCliente.Text = 'J' Then
    strSQL := strSQL + ' AND CLI_CGCCPF = 1 '
  Else If edtTipCliente.Text = 'F' Then
    strSQL := strSQL + ' AND CLI_CGCCPF = 2 ';

  If (edtDupDesc.Text = 'S') Then
    strSQL := strSQL + '  AND CTR_DESCON = "S" '
  Else If (edtDupDesc.Text = 'N') Then
    strSQL := strSQL + '  AND CTR_DESCON = "N" ';

  Case cbxValor.ItemIndex Of
    1: strSQL := strSQL + '  AND CTR_VALDUP > :VALINI ';
    2: strSQL := strSQL + '  AND CTR_VALDUP < :VALFIN ';
    3: strSQL := strSQL + '  AND CTR_VALDUP >= :VALINI  AND CTR_VALDUP <= :VALFIN ';
  End;

  strSQL := strSQL + ' ORDER BY CTR_DTAVEN, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP';

  Clipboard.AsText := strSQL;

  Result := strSQL;
end;

procedure TfrmRelCtrExportaCobranca.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := fCriaQuery(nil);
end;

procedure TfrmRelCtrExportaCobranca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryDados);
end;

procedure TfrmRelCtrExportaCobranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) And
                  (Not (ActiveControl.Parent = gpbOpcValor)) Then
               Begin
                 self.SelectNext(ActiveControl, True, True);
               End
               Else
               If (ActiveControl Is TComboBox)  And
                  (ActiveControl.Parent = gpbOpcValor) Then
               Begin
                 self.SelectNext(ActiveControl, True, True);
               End;

    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;
  End;
end;

procedure TfrmRelCtrExportaCobranca.FormShow(Sender: TObject);
begin
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  strCodRep := '';
  strCodVen := '';

  inherited;

  If Not fCfgSis('USACND', varBoolean) Then
  Begin
    lblCndPag.Visible := False;
    edtCodCnd.Visible := False;
    edtDesCnd.Visible := False;
  End;
end;

procedure TfrmRelCtrExportaCobranca.fraCentroCustoedtCodEveExit(
  Sender: TObject);
begin
  inherited;
  If Not fraCentroCusto.edtCodEve.ReadOnly Then
    pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

function TfrmRelCtrExportaCobranca.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {**************************}
    {* VALIDA DATA VENCIMENTO *}
    {***********************MO*}
    If (Sender = mskDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo data final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo data inicial de vencimento deve ser preenchido!', ['&Ok']);
          Sender := mskDtaIni;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'A data final de vencimento informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
              Sender := mskDtaIni;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A data inicial de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End;

    {************************}
    {* VALIDA DATA CADASTRO *}
    {*********************MO*}
    If (Sender = mskCadFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de Cadastro deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de Cadastro deve ser preenchido!', ['&Ok']);
          Sender := mskCadIni;
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And (StrToDateDef(mskCadFin.Text, 0) <= 0) Then
          Begin
            fMensagem('', 'A Data Final de Cadastro informada é inválida! Necessário correção.', ['&O k']);
            Result := False;
          End
          Else
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
          Begin
            If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
            Begin
              fMensagem('','A Data Inicial de Cadastro deve ser menor que a Data Final de Cadastro!',['&O K']);
              Sender := mskCadIni;
              Result := False;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskCadIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) and (StrToDateDef(mskCadIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de Cadastro informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskCadIni;
      End;
    End;

    If (Sender = edtDupDesc) Then
    Begin
      If fEmptyStr(edtDupDesc.Text) then
      Begin
        fMensagem('ATENÇÃO','O campo Duplicata Descontada deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else
      If Pos(edtDupDesc.Text, 'SNT') <= 0 Then
      Begin
        fMensagem('','O campo ''Duplicata Descontada'' deve conter somente T, S ou N!',['&O K']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtTipCliente) Then
    Begin

      If fEmptyStr(edtTipCliente.Text) Then
      Begin
        fMensagem('','O Campo ''Tipo de Pessoa Cliente'' deve ser preenchido!',['&O K']);
        Result := False;
      End
      Else If (Pos(edtTipCliente.Text, 'FJT') <= 0) Then
      Begin
        fMensagem('','O Campo ''Tipo de Pessoa Cliente'' deve ser F,J ou T!',['&O K']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtCodEmpresa) Then
    Begin
      pDesmarcaLista(edtCodEmpresa, arrEmpresa);

      If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
      Begin
        If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          //Verifica se possui acesso na Baixa de Contas a Receber
          If (Pos(edtCodEmpresa.Text, strAceCtr) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End
    Else
    If (Sender = edtCodVen) Then
    Begin
      If Not fEmptyStr(edtCodVen.Text) Then
      Begin
        strCodVen := fRetCodVendedor(edtCodVen.Text);
        If Not fEmptyStr(strCodVen) Then
          edtNomVen.Text := fRetNomVendRep(strCodVen)
        Else
        Begin
          Result := False;
          fMensagem('','Vendedor não encontrado.', ['&O K']);
        End;
      End
      Else
      Begin
        edtNomVen.Text := 'TODOS';
        strCodVen := '';
      End;
    End
    Else
    If (Sender = edtCodRep) Then
    Begin
      If Not fEmptyStr(edtCodRep.Text) Then
      Begin
        strCodRep := fRetCodVendedor(edtCodRep.Text);

        If Not fEmptyStr(strCodRep) Then
          edtNomRep.Text := fRetNomVendRep(strCodRep)
        Else
        Begin
          Result := False;
          fMensagem('','Representante não encontrado.', ['&O K']);
        End;
      End
      Else
      Begin
        edtNomRep.Text := 'TODOS';
        strCodRep := '';
      End;
    End
    Else
    If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin
        edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If (High(arrEmpresa) > 0) Then
          Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa) Then
              Result := False;
          End
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtCodPor.Text = '00000') Then
          edtDesPortador.text := '+1'
        else
          edtDesPortador.Text := 'TODOS';
    End
    Else
    If Sender = edtPorCli Then
    Begin
      If Not fEmptyStr(edtPorCli.Text) And (edtPorCli.Text <> '00000') Then
      Begin
        edtDesPorCli.Text := fRetNomPortador(edtPorCli.Text);

        If fEmptyStr(edtDesPorCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorCli.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtPorCli.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtPorCli.Text = '00000') Then
          edtDesPorCli.Text := '+1'
        else
          edtDesPorCli.Text := 'TODOS';
    End
    Else
    If Sender = edtExcPor Then
    Begin
      If Not fEmptyStr(edtExcPor.Text) And (edtExcPor.Text <> '00000') Then
      Begin
        edtDesExcPortador.Text := fRetNomPortador(edtExcPor.Text);

        If fEmptyStr(edtDesExcPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtExcPor.Text, edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtExcPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End
    Else
    If Sender = fraCaminho Then
    Begin
      If fEmptyStr(fraCaminho.edtDirectory.text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Caminho do arquivo não informado!', ['&O k']);
        Result := False;
      End;
    end
    Else
    If Sender = fraCentroCusto.edtCodEve Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve);

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Sender = edtCodSub) Then
    pDesmarcaLista(edtCodSub, arrSubReg);

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRelCtrExportaCobranca.pExportaDados;
var
  objBookmark: TBookmark;
  strAutIncremento: String;

begin

  inherited;

  qryDados.DisableControls;
  objBookmark := qryDados.GetBookmark;
  strAutIncremento := '';

  try

    qryDados.First;

    while not qryDados.Eof do
    Begin
      if qryDados.FieldByName('MARDES').AsString = 'S' then
      begin
        strAutIncremento := strAutIncremento + '_' + qryDados.FieldByName('INCCTR').AsString;
      end;
      qryDados.Next;
    End;

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(269, 8789, [],
                          ['STRINC','PATEXP'],
                          [strAutIncremento,fraCaminho.edtDirectory.text],
                          nil,
                          nil,
                          True);
    End;

  finally
    qryDados.EnableControls;
    if qryDados.BookmarkValid(objBookmark) then
      qryDados.GotoBookmark(objBookmark);
  end;

end;

procedure TfrmRelCtrExportaCobranca.pSetaParametros(qryDados: TUniQuery);
begin
  With qryDados Do
  Begin
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    Begin
      ParamByName('CADINI').AsDate := StrToDate(mskCadIni.Text);
      ParamByName('CADFIN').AsDate := StrToDate(mskCadFin.Text);
    End;

    If Not fEmptyStr(edtDesCliente.Text) Then
      pSetaParam(edtCodCliente.Text, arrClientes, strClientes, 'CODCLI', qryDados);

    If Not fEmptyStr(edtDesPortador.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryDados);

    If Not fEmptyStr(edtDesCnd.Text) Then
      pSetaParam(edtCodCnd.Text, arrCndPag, strConPag, 'CODCND', qryDados);

    If Not fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
      pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryDados);

    If Not fEmptyStr(edtDesPorCli.Text) Then
      pSetaParam(edtPorCli.Text, arrPorCli, strPorCli, 'PORCLI', qryDados);

    If Not fEmptyStr(edtNomVen.Text) Then
      pSetaParam(strCodVen, arrVendedor, strVendedor, 'CODVEN', qryDados);

    If (edtDesEmpresa.Text <> 'TODOS') And (edtDesEmpresa.Text <> '') Then
      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryDados);

    If Not fEmptyStr(edtDesReg.Text) Then
      pSetaParam(edtCodReg.Text, arrRegiao, strRegiao, 'CODREG', qryDados);

    If Not fEmptyStr(edtExcPor.Text) Then
      pSetaParam(edtExcPor.Text, arrExcetPor, strExcetPor, 'EXCPOR', qryDados);

    If Not fEmptyStr(edtDesAti.Text) Then
      pSetaParam(edtCodAti.Text, arrAtivid, strAtivid, 'CODATI', qryDados);

    If Not fEmptyStr(edtDesCid.Text) Then
      pSetaParam(edtCodCid.Text, arrCidade, strCidade, 'CODCID', qryDados);

    If Not fEmptyStr(edtDesRedLoj.Text) Then
      pSetaParam(edtRedLoj.Text, arrRedeLojas, strRedeLojas, 'CODRED', qryDados);

    If Not fEmptyStr(edtNomRep.Text) Then
      pSetaParam(strCodRep, arrRepresentante, strRepresentante, 'CODREP', qryDados);

    If Not fEmptyStr(edtDesDep.Text) Then
      pSetaParam(edtCodDep.Text, arrDepart, strDepart, 'CODDEP', qryDados);

    If Not fEmptyStr(edtDesSub.Text) Then
      pSetaParam(edtCodSub.Text, arrSubReg, strSubReg, 'CODSUB', qryDados);

    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    Case cbxValor.ItemIndex Of
      1: ParamByName('VALINI').AsFloat := fStrToFloat(edtValIni.Text);
      2: ParamByName('VALFIN').AsFloat := fStrToFloat(edtValIni.Text);
      3: Begin
        ParamByName('VALINI').AsFloat := fStrToFloat(edtValIni.Text);
        ParamByName('VALFIN').AsFloat := fStrToFloat(edtValFin.Text);
      End;
    End;
  End;
end;

end.

