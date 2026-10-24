unit untCfgSpedFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, Data.DB,
  untFuncoesConsulta, untTypesSistema, untSelecionaEmpresa, Vcl.Mask,
  MaskEditFocus, System.StrUtils;

type
  TfrmCfgSpedFiscal = class(TfrmPaiCad)
    dtsSpedConfEfd: TDataSource;
    tsSpedFiscal2: TTabSheet;
    chkEnviarFcpNfSpedFiscal: TCheckBox;
    chkRegraCat66ConsolidadoSpedfiscal: TCheckBox;
    chkRegraCat66Spedfiscal: TCheckBox;
    chkEnviarFcpNfceSpedFiscal: TCheckBox;
    chkRegraCat66ApenasCfop: TCheckBox;
    chkEnviarVlrFcpCampo24C100_09C190: TCheckBox;
    chk54Detalhado: TCheckBox;
    chkFiscaisCat42: TCheckBox;
    Label247: TLabel;
    edtCstServicoSpedFiscal: TEditFocus;
    Label264: TLabel;
    Label265: TLabel;
    edtCodAjuE111TransfCre: TEditFocus;
    edtDesAjuE111TransfCre: TEditFocus;
    Label266: TLabel;
    Label267: TLabel;
    edtCodAjuE111TransfDeb: TEditFocus;
    edtDesAjuE111TransfDeb: TEditFocus;
    Label268: TLabel;
    Label269: TLabel;
    edtCodAjuE111MudancaTribSpedFiscal: TEditFocus;
    edtDesAjuE111MudancaTribSpedFiscal: TEditFocus;
    Label248: TLabel;
    edtCodAjuE116DifAliqSpedFiscal: TEditFocus;
    chkEnviarCST090CT: TCheckBox;
    grpCstRegD190SpedFiscal: TGroupBox;
    Label273: TLabel;
    Label274: TLabel;
    Label275: TLabel;
    Label276: TLabel;
    edtCstBaseIcmsMenorD190: TEditFocus;
    edtCstBaseIcmsZeradoD190: TEditFocus;
    edtCstBaseIcmsIgualD190: TEditFocus;
    edtCstCteComplementarD190: TEditFocus;
    gpbEnviarContaContabil: TGroupBox;
    Label277: TLabel;
    chkUtilizarRotinaDeContabilidade: TCheckBox;
    Label61: TLabel;
    Label209: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtSpedCfopIndPag: TEditFocus;
    chkEnvia0460icmstipi: TCheckBox;
    chkRegE316Analitico: TCheckBox;
    chkEnviarRegE316IESubstSpedFiscal: TCheckBox;
    chkAjuDet: TCheckBox;
    chkEnviaPrecoLiquidoH010: TCheckBox;
    chkEnviarNfSaidaRegE250: TCheckBox;
    chkEnviarDadosEmpresaAnteriorSpedFiscal: TCheckBox;
    chkEnviarValDevDifal: TCheckBox;
    chkEnviarCredIcmsCat158Sped: TCheckBox;
    chkEnviarFixo1RegC100Campo13: TCheckBox;
    chkEnviarC195: TCheckBox;
    chkEnviarH020Especial: TCheckBox;
    chkEnviaAjustesFECP: TCheckBox;
    chkEnviarDesc0460_C195: TCheckBox;
    chkUniCompraEntradaConvertida: TCheckBox;
    chkUniCompraEntradaFornecedor: TCheckBox;
    rgTipExpE200: TRadioGroup;
    rgInfoBlocoK: TRadioGroup;
    chkEnviarRegistrosK220: TCheckBox;
    chkEnviarRegistros0210: TCheckBox;
    GroupBox47: TGroupBox;
    chkEnviarRegSomenteK200Sped: TCheckBox;
    grbInfoFECP: TGroupBox;
    Label180: TLabel;
    edtCodRecFECP: TEditFocus;
    grbInfoGare: TGroupBox;
    Label87: TLabel;
    edtCodGare: TEditFocus;
    grbInventario: TGroupBox;
    Label202: TLabel;
    Label204: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label278: TLabel;
    cmbPrecoRegH010Campo06: TComboBox;
    cmbPrecoRegH010Campo11: TComboBox;
    chkUtilizarPrecoConfiguradoRegH010: TCheckBox;
    rgAlteracaoTributaria: TRadioGroup;
    edtPartBrokerSped: TEditFocus;
    edtContaAnaliticaBrokerSpedBlocoH: TEditFocus;
    edtEmpresasSelecionadas: TEditFocus;
    gbUsarAliqInventOuAliqDigitada: TGroupBox;
    Label279: TLabel;
    Label280: TLabel;
    Label281: TLabel;
    edtAliqInventOuAliqDigitada: TEditFocus;
    chkEnviarApenasOsItensTributados: TCheckBox;
    chkUtilizaPartBrokerOuTerceiro: TCheckBox;
    edtPartTerceiroSped: TEditFocus;
    edtContaAnaliticaTerceiroSpedBlocoH: TEditFocus;
    btnSelEmpresa: TBitBtnLocked;
    chkEnviaCodFabricaNaDescricaoRegC170: TCheckBox;
    gpbRegistro0205: TGroupBox;
    chkEnvCodProd0205: TCheckBox;
    Label1: TLabel;
    mskDtIni0205: TMaskEditFocus;
    Label2: TLabel;
    mskDtFin0205: TMaskEditFocus;
    gpbRegistro1400: TGroupBox;
    chkReg1400: TCheckBox;
    Label3: TLabel;
    edtCodigoItemIPM: TEditFocus;
    gpbBlocoG: TGroupBox;
    chkIncluirCFOP5929_6959RegG110: TCheckBox;
    chkG110TributContabil: TCheckBox;
    gpbServicos: TGroupBox;
    chkEntrarNotasMunicipaisServico: TCheckBox;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label47: TLabel;
    Label48: TLabel;
    Label4: TLabel;
    edtCodEstadRecolheIcms: TEditFocus;
    edtDiaVencIcms: TMaskEditFocus;
    edtDiaVencIcmsST: TMaskEditFocus;
    lblCodEstadualDentroEstado: TLabel;
    edtCodEstadRecolheIcmsSTDentroEstado: TEditFocus;
    Label140: TLabel;
    edtDiaVencDifalDestino: TMaskEditFocus;
    btnCodigosRecolhimentoST: TBitBtnLocked;
    btnCodigosRecolhimentoDIFAL: TBitBtnLocked;
    btnLinGruExcluir: TBitBtnLocked;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label176: TLabel;
    edtCodAjIcmsProprioFECP: TEditFocus;
    Label241: TLabel;
    edtCodAjIcmsProprioFECP2: TEditFocus;
    Label177: TLabel;
    edtDescAjIcmsProprioFECP: TEditFocus;
    Label242: TLabel;
    edtDescAjIcmsProprioFECP2: TEditFocus;
    GroupBox4: TGroupBox;
    chk19XXSubApuracaoICMS: TCheckBox;
    Label5: TLabel;
    edtDescr19XXSubApuracaoICMS: TEditFocus;
    chkEnviarRegistrosK280: TCheckBox;
    cmbPeriodoK280: TComboBox;
    Label6: TLabel;
    edtSPED_COD_RECOLHE_ICMS_1926: TEditFocus;
    chkENVIA1923SUB: TCheckBox;
    chkSubApuCorrImporta: TCheckBox;
    chkEnvDescrC170UsoCon: TCheckBox;
    chkEnviarPisCofins_: TCheckBox;
    tsSpedFiscal3: TTabSheet;
    chkENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR: TCheckBox;
    Label7: TLabel;
    edtCFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR: TEditFocus;
    Label8: TLabel;
    edtCOD_AJU_E113_PRESUM_PR_CRE: TEditFocus;
    rgInfoBlocoK010: TGroupBox;
    Label9: TLabel;
    cmbIndTipLayK010: TComboBox;
    gbCFOPNaoGeraReceita: TGroupBox;
    Label11: TLabel;
    edtCFOP: TEditFocus;
    btnIncluiCFOP: TBitBtnLocked;
    btnRemoveCFOP: TBitBtnLocked;
    edtCFOPNaoGeraReceita: TEditFocus;
    gbCFOP_Tratada_Como_Substituto: TGroupBox;
    Label10: TLabel;
    edtCFOPSubstituto: TEditFocus;
    btnIncluiCFOPSubstituto: TBitBtnLocked;
    btnRemoveCFOPSubstituto: TBitBtnLocked;
    edtCFOP_Tratada_Como_Substituto: TEditFocus;
    cmbENVIA_VLDOC_VLMERC_5929: TComboBox;
    Label12: TLabel;
    Label13: TLabel;
    edtCODIGO_RECEITA_090_E116: TEditFocus;
    gbCST_MONOFASICO_ICMS_ENTRADA: TGroupBox;
    Label14: TLabel;
    edtCST: TEditFocus;
    btnIncluiCST: TBitBtnLocked;
    btnRemoveCST: TBitBtnLocked;
    edtCST_MONOFASICO_ICMS_ENTRADA: TEditFocus;
    GroupBox5: TGroupBox;
    chkG_DTAAQU_MES: TCheckBox;
    GroupBox6: TGroupBox;
    Label15: TLabel;
    edtCFOPCIAP: TEditFocus;
    btnIncluiCFOPCIAP: TBitBtnLocked;
    btnRemoveCFOPCIAP: TBitBtnLocked;
    edtCFOP_ISENTAS_CIAP_MODELO_C: TEditFocus;
    chkENVIAR_VALOR_DIFAL_CIAP: TCheckBox;
    chkENVIAR_X929_SAIDA_CIAP: TCheckBox;
    chkNAO_ENVIAR_E200_SE_VALORES_IGUAL0: TCheckBox;
    TabSheet3: TTabSheet;
    chkVALIDAR_CODIGO_RECEITA_REG_E: TCheckBox;
    tbsFiltros: TTabSheet;
    Label21: TLabel;
    cmbPERFIL_DECLARANTE: TComboBox;
    Label22: TLabel;
    cmbFINALIDADE_ARQUIVO: TComboBox;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    cmbREG0015_ENV_IE_UF_DEST: TComboBox;
    cmbTIPO_ATIVIDADE: TComboBox;
    cmbCLASSIF_CONTRIB_IPI: TComboBox;
    cmbREGIME_SUBST_TRIB: TComboBox;
    chkENVIAR_C180_C185: TCheckBox;
    chkENVIANOTADEBITOCREDITODEVOLUCAO: TCheckBox;
    Label29: TLabel;
    edtCST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190: TEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnSelEmpresaClick(Sender: TObject);
    procedure btnLinGruExcluirClick(Sender: TObject);
    procedure btnCodigosRecolhimentoSTClick(Sender: TObject);
    procedure btnCodigosRecolhimentoDIFALClick(Sender: TObject);
    procedure btnIncluiCFOPClick(Sender: TObject);
    procedure btnRemoveCFOPClick(Sender: TObject);
    procedure btnIncluiCFOPSubstitutoClick(Sender: TObject);
    procedure btnRemoveCFOPSubstitutoClick(Sender: TObject);
    procedure btnIncluiCSTClick(Sender: TObject);
    procedure btnRemoveCSTClick(Sender: TObject);
    procedure btnIncluiCFOPCIAPClick(Sender: TObject);
    procedure btnRemoveCFOPCIAPClick(Sender: TObject);

  const
    VS_TAMAMNHO_COD_NATUREZA_CREDITO_FRETE = 2;
    VS_STR_NATUREZA_CREDITO_FRETE = '14';

  private
    { Private declarations }
    qryAux: TUniQuery;
    arrFornec: TConsultasArray;
    objEmpresa: TfrmSelecionaEmpresa;
    function fRetConfiguracao(strConfiguracao: string): string;
    procedure pHabilitaDesabilitaObjetosEmTela;
    procedure pAlimentaObjetosEmTelaComBaseNoBancoDados;
    procedure pGravarNoBancoDadosComBaseEmObjetosDeTela;
    procedure pHabilitaDesabilitaEnviarRegistrosK220;
    procedure pHabilitaDesabilitaPartBrokerOuTerceiro;
    procedure pCriaConfiguracoesBancoDeDadosDefault;
    procedure pGeraConfiguracoesBancoDeDados(strCodEmp, strCodCfg, strCdCfAb,
      strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg, strGruCfg: string;
      intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime;
      strLayout: string);
    function fTemCodigoRecolhimentoDifalPreenchido: Boolean;
    function pGetComboFiltroValor(cmbCombo: TComboBox): String;
    procedure pSetComboFiltroValor(cmbCombo: TComboBox; strValor: String);
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmCfgSpedFiscal: TfrmCfgSpedFiscal;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untConfigLinhaGrupoSped,
  untConfiguracoesCodigosRecolhimentoST, untConfiguracoesCodigosRecolhimentoDifal;


{ TfrmConfiguracoesSpedContribuicao }

procedure TfrmCfgSpedFiscal.btnLinGruExcluirClick(Sender: TObject);
var
  frmConfigLinhaGrupoSped: TfrmConfigLinhaGrupoSped;
begin
  inherited;
  if (fTabelaExiste('CONLGS', True)) then
  begin
    pVerificaProCod;
    pValidaProCod('CONLGS');
    frmConfigLinhaGrupoSped := TfrmConfigLinhaGrupoSped.Create(Nil);
    Try
      frmConfigLinhaGrupoSped.blnFiscal := True;
      frmConfigLinhaGrupoSped.ShowModal;
    Finally
      frmConfigLinhaGrupoSped.Free;
    End;
  end
  else
    fMensagem('ATENÇÃO','A tabela CONLGS não existe, favor entrar em contato com o suporte!', ['&Ok']);
end;

procedure TfrmCfgSpedFiscal.btnRemoveCFOPCIAPClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOPCIAP.Text) then
  begin
    if Length(edtCFOPCIAP.Text) = 4 then
    begin
      if Pos(edtCFOPCIAP.Text, edtCFOP_ISENTAS_CIAP_MODELO_C.Text) > 0 then
        edtCFOP_ISENTAS_CIAP_MODELO_C.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(edtCFOP_ISENTAS_CIAP_MODELO_C.Text, '_' + edtCFOPCIAP.Text, ''), edtCFOPCIAP.Text + '_', ''), edtCFOPCIAP.Text, '');
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnRemoveCFOPClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOP.Text) then
  begin
    if Length(edtCFOP.Text) = 4 then
    begin
      if Pos(edtCFOP.Text, edtCFOPNaoGeraReceita.Text) > 0 then
        edtCFOPNaoGeraReceita.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(edtCFOPNaoGeraReceita.Text, '_' + edtCFOP.Text, ''), edtCFOP.Text + '_', ''), edtCFOP.Text, '');
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnRemoveCFOPSubstitutoClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOPSubstituto.Text) then
  begin
    if Length(edtCFOPSubstituto.Text) = 4 then
    begin
      if Pos(edtCFOPSubstituto.Text, edtCFOP_Tratada_Como_Substituto.Text) > 0 then
        edtCFOP_Tratada_Como_Substituto.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(edtCFOP_Tratada_Como_Substituto.Text, '_' + edtCFOPSubstituto.Text, ''), edtCFOPSubstituto.Text + '_', ''), edtCFOPSubstituto.Text, '');
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnRemoveCSTClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCST.Text) then
  begin
    if Length(edtCST.Text) = 3 then
    begin
      if Pos(edtCST.Text, edtCST_MONOFASICO_ICMS_ENTRADA.Text) > 0 then
        edtCST_MONOFASICO_ICMS_ENTRADA.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(edtCST_MONOFASICO_ICMS_ENTRADA.Text, '_' + edtCST.Text, ''), edtCST.Text + '_', ''), edtCST.Text, '');
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnSelEmpresaClick(Sender: TObject);
begin
  inherited;
  objEmpresa := TfrmSelecionaEmpresa.Create(Nil);
  Try
    objEmpresa.blnRecuperaEmpresaLogada:= True;
    objEmpresa.strCodEmpresa := edtEmpresasSelecionadas.Text;

    objEmpresa.ShowModal;
    edtEmpresasSelecionadas.Text := objEmpresa.strCodEmpresa;
  Finally
    objEmpresa.Free;
  End;
end;

procedure TfrmCfgSpedFiscal.btnCodigosRecolhimentoDIFALClick(Sender: TObject);
begin
  inherited;
  if fTabelaExiste('CRDFAL', True) then
    pCriarForm(TfrmConfiguracoesCodigosRecolhimentoDifal)
  else
    fMensagem('AVISO', 'É necessário criar a tabela "CRDFAL" para continuação do processo, favor entrar em contato com a citel!', ['OK']);
end;

procedure TfrmCfgSpedFiscal.btnCodigosRecolhimentoSTClick(Sender: TObject);
begin
  inherited;
  if fTabelaExiste('TBRCST', True) then
    pCriarForm(TfrmConfiguracoesCodigosRecolhimentoST)
  else
    fMensagem('AVISO', 'É necessário criar a tabela "TBRCST" para continuação do processo, favor entrar em contato com a citel!', ['OK']);
end;

procedure TfrmCfgSpedFiscal.btnGravarClick(Sender: TObject);
begin
  If Not fValidaCampos(edtDiaVencIcms, True) Then
    Exit;

  If Not fValidaCampos(edtDiaVencIcmsST, True) Then
    Exit;

  If Not fValidaCampos(edtDiaVencDifalDestino, True) Then
    Exit;

  inherited;
  try
    pGravarNoBancoDadosComBaseEmObjetosDeTela;
    fMensagem('', 'Configurações Salvas com sucesso!', ['&Ok']);
    Close;
  except
    On E: Exception Do
    begin
      fMensagem('ATENÇÃO!', 'Ocorreu problemas na gravação das informações, ' + e.Message, ['&Ok']);
      pnlInfo.Caption := 'Ocorreu problemas na gravação das informações';
      Abort;
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnIncluiCFOPCIAPClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOPCIAP.Text) then
  begin
    if Length(edtCFOPCIAP.Text) = 4 then
    begin
      if Pos(edtCFOPCIAP.Text, edtCFOP_ISENTAS_CIAP_MODELO_C.Text) <= 0 then
        edtCFOP_ISENTAS_CIAP_MODELO_C.Text := edtCFOP_ISENTAS_CIAP_MODELO_C.Text + IIF(fEmptyStr(edtCFOP_ISENTAS_CIAP_MODELO_C.Text), '', '_') + edtCFOPCIAP.Text;
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnIncluiCFOPClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOP.Text) then
  begin
    if Length(edtCFOP.Text) = 4 then
    begin
      if Pos(edtCFOP.Text, edtCFOPNaoGeraReceita.Text) <= 0 then
        edtCFOPNaoGeraReceita.Text := edtCFOPNaoGeraReceita.Text + IIF(fEmptyStr(edtCFOPNaoGeraReceita.Text), '', '_') + edtCFOP.Text;
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnIncluiCFOPSubstitutoClick(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(edtCFOPSubstituto.Text) then
  begin
    if Length(edtCFOPSubstituto.Text) = 4 then
    begin
      if Pos(edtCFOPSubstituto.Text, edtCFOP_Tratada_Como_Substituto.Text) <= 0 then
        edtCFOP_Tratada_Como_Substituto.Text := edtCFOP_Tratada_Como_Substituto.Text + IIF(fEmptyStr(edtCFOP_Tratada_Como_Substituto.Text), '', '_') + edtCFOPSubstituto.Text;
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.btnIncluiCSTClick(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(edtCST.Text) then
  begin
    if Length(edtCST.Text) = 3 then
    begin
      if Pos(edtCST.Text, edtCST_MONOFASICO_ICMS_ENTRADA.Text) <= 0 then
        edtCST_MONOFASICO_ICMS_ENTRADA.Text := AnsiReplaceStr(edtCST_MONOFASICO_ICMS_ENTRADA.Text + IIF(fEmptyStr(edtCST_MONOFASICO_ICMS_ENTRADA.Text), '', '_') + edtCST.Text, '__', '_');
    end;
  end;
end;

procedure TfrmCfgSpedFiscal.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do fornecedor', 8);
end;

procedure TfrmCfgSpedFiscal.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, True) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgSpedFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  qryAux := fCriaQuery(Self);

  blnVerificaProCod        := False;
  strNomeTabela            := 'CFGSPD';
  strNomeCampo             := 'SPD_CODCFG';

  qryTabela                := fCriaQuery(Self);
  dtsSpedConfEfd.DataSet   := qryTabela;

  SetLength(arrCamposChave, 1);

  pCriaConfiguracoesBancoDeDadosDefault;
end;

procedure TfrmCfgSpedFiscal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryAux);
end;

procedure TfrmCfgSpedFiscal.FormShow(Sender: TObject);
begin
  inherited;

  pHabilitaDesabilitaObjetosEmTela;

  pHabilitaDesabilitaEnviarRegistrosK220;
  pHabilitaDesabilitaPartBrokerOuTerceiro;

  pAlimentaObjetosEmTelaComBaseNoBancoDados;
  pSetFocus(edtCodFor);
end;

procedure TfrmCfgSpedFiscal.pHabilitaDesabilitaEnviarRegistrosK220;
begin
  if ((rgInfoBlocoK.ItemIndex = 1) or (rgInfoBlocoK.ItemIndex = 2)) then
  begin
    chkEnviarRegistrosK220.Checked := False;
    chkEnviarRegistrosK220.Enabled := False;
    chkEnviarRegistros0210.Checked := False;
    chkEnviarRegistros0210.Enabled := False;
  end else
  begin
    chkEnviarRegistrosK220.Enabled := True;
    chkEnviarRegistros0210.Enabled := True;
  end;
end;

procedure TfrmCfgSpedFiscal.pHabilitaDesabilitaPartBrokerOuTerceiro;
begin
  if (chkUtilizaPartBrokerOuTerceiro.Checked) then
  begin
    label211.Caption := 'Participante Terceiro';
    label212.Caption := 'Conta Analítica Terceiro';

    edtPartBrokerSped.Text := '';
    edtContaAnaliticaBrokerSpedBlocoH.Text := edtPartBrokerSped.Text;
    edtPartBrokerSped.Visible := False;
    edtContaAnaliticaBrokerSpedBlocoH.Visible := edtPartBrokerSped.Visible;

    edtPartTerceiroSped.Visible := True;
    edtContaAnaliticaTerceiroSpedBlocoH.Visible := edtPartTerceiroSped.Visible;
  end
  else
  begin
    label211.Caption := 'Participante Broker';
    label212.Caption := 'Conta Analítica Broker';

    edtPartTerceiroSped.Text := '';
    edtContaAnaliticaTerceiroSpedBlocoH.Text := edtPartTerceiroSped.Text;
    edtPartTerceiroSped.Visible := False;
    edtContaAnaliticaTerceiroSpedBlocoH.Visible := edtPartTerceiroSped.Visible;

    edtPartBrokerSped.Visible := True;
    edtContaAnaliticaBrokerSpedBlocoH.Visible := edtPartBrokerSped.Visible;
  end;
end;

function TfrmCfgSpedFiscal.fTemCodigoRecolhimentoDifalPreenchido: Boolean;
begin
  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT * FROM CRDFAL WHERE CRD_CODEMP = :CODEMP;');
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  Result := Not qryAux.IsEmpty;
end;

function TfrmCfgSpedFiscal.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodFor) then
    Begin
      pDesmarcaLista(edtCodFor, arrFornec);
    End
    Else
    If (Sender = mskDtIni0205) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtIni0205.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial do Registro 0205 deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaDataStr(mskDtIni0205.Text) Then
      Begin
        fMensagem('', 'Data Inicial do Registro 0205 não é válida!', ['&O k']);
        Result := False;
        Sender := mskDtIni0205;
      End;
    End
    Else
    If (Sender = mskDtIni0205) Or (Sender = mskDtFin0205) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtIni0205.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial do Registro 0205 deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtFin0205) Then
          Sender := mskDtIni0205;
      End
      Else
      Begin
        If (Sender = mskDtFin0205) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtFin0205.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final do Registro 0205 deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaDataStr(mskDtIni0205.Text) Then
          Begin
            fMensagem('', 'Data Inicial do Registro 0205 não é válida!', ['&O k']);
            Result := False;
            Sender := mskDtIni0205;
          End
          Else If Not fValidaDataStr(mskDtFin0205.Text) Then
          Begin
            fMensagem('', 'Data Final do Registro 0205 não é válida!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtIni0205.Text) > StrToDate(mskDtFin0205.Text) Then
            Begin
              fMensagem('','A Data Inicial do Registro 0205 deve ser menor que a Data Final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;
    End
    Else
    If (Sender = edtDiaVencIcms) Then
    Begin
      If fEmptyStr(edtDiaVencIcms.Text) And Not fEmptyStr(edtCodEstadRecolheIcms.Text) Then
      Begin
        fMensagem('', 'Cód. Estadual (dentro estado) foi preenchido. Obrigatório preencher Dia de Vencto. (ICMS)!', ['&O k']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtDiaVencIcmsST) Then
    Begin
      If fEmptyStr(edtDiaVencIcmsST.Text) And Not fEmptyStr(edtCodEstadRecolheIcmsSTDentroEstado.Text) Then
      Begin
        fMensagem('', 'Cód. Estadual ST (dentro estado) foi preenchido. Obrigatório preencher Dia de Vencto. (ST)!', ['&O k']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtDiaVencDifalDestino) Then
    Begin
      If fEmptyStr(edtDiaVencDifalDestino.Text) And fTemCodigoRecolhimentoDifalPreenchido Then
      Begin
        fMensagem('', 'Códigos de recolhimento Difal foi preenchido. Obrigatório preencher Dia Vencimento DIFAL!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCfgSpedFiscal.fRetConfiguracao(strConfiguracao: string): string;
begin
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   SUBSTRING(SPD_VALCFG, 1, 1200) AS SPD_VALCFG ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   CFGSPD ');
    qryAux.SQL.Add(' WHERE SPD_CODCFG = :CODCFG ');
    qryAux.SQL.Add('   AND SPD_CODEMP = :CODEMP ');
    qryAux.SQL.Add(' LIMIT 1 ');

    qryAux.ParamByName('CODCFG').AsString  := strConfiguracao;
    qryAux.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryAux.Open;

    if not(qryAux.IsEmpty) then
      Result := qryAux.FieldByName('SPD_VALCFG').AsString
    else Result := '';
  finally
  end;
end;

procedure TfrmCfgSpedFiscal.pHabilitaDesabilitaObjetosEmTela;
var
  intComponente: Integer;
begin
  btnIncluir.Visible  := False;
  btnAlterar.Visible  := False;
  btnExcluir.Visible  := False;
  btnCancela.Visible  := False;
  btnPesquisa.Visible := False;
  btnGravar.Enabled   := True;

  for intComponente := 0 to ComponentCount - 1 do
    if (Components[intComponente] is TControl) then
      if TControl(Components[intComponente]).Tag = 99 then
        TControl(Components[intComponente]).Enabled := btnGravar.Enabled;
end;

procedure TfrmCfgSpedFiscal.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCfgSpedFiscal.pGravarNoBancoDadosComBaseEmObjetosDeTela;
begin
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    {Aba Filtros}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbPERFIL_DECLARANTE) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PERFIL_DECLARANTE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbFINALIDADE_ARQUIVO) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "FINALIDADE_ARQUIVO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbTIPO_ATIVIDADE) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "TIPO_ATIVIDADE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbCLASSIF_CONTRIB_IPI) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CLASSIF_CONTRIB_IPI";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbREGIME_SUBST_TRIB) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REGIME_SUBST_TRIB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + pGetComboFiltroValor(cmbREG0015_ENV_IE_UF_DEST) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REG0015_ENV_IE_UF_DEST";');

    {Aba Fiscal}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodFor.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "FORNECEDOR_ICMS_ANTECIPADO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtSpedCfopIndPag.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CFOP_INDICADOR_PAGAMENTO_FIXO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnvia0460icmstipi.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "TIP_EXPORTACAO_0460";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkAjuDet.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "TIP_AJUSTE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarNfSaidaRegE250.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_NF_SAIDA_E250";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarValDevDifal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_VALOR_DEV_DIFAL";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarC195.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_C195";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviaAjustesFECP.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_AJU_FECP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUniCompraEntradaConvertida.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_UN_COMPRA_CONVERTIDA";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkRegE316Analitico.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REG_E316";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviaPrecoLiquidoH010.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PRECO_LIQUIDO_H010_CAMPO11";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarDadosEmpresaAnteriorSpedFiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_DADOS_EMPANT";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarCredIcmsCat158Sped.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_CREDICMS_CAT158";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarFixo1RegC100Campo13.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_FIXO_1_REGC100_CAMPO13";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarH020Especial.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_H020_ESPECIAL";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarDesc0460_C195.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ALTERAR_DESCR_REG_0460_E_C195";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUniCompraEntradaFornecedor.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_UN_COMPRA_FORNECEDOR";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarRegE316IESubstSpedFiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REG_E316_IE_SUBST";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(rgTipExpE200.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "TIP_EXPORTACAO_E200";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(rgInfoBlocoK.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DADOS_BLOCOK_SIM_NAO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarRegistrosK220.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_REGISTRO_K220";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarRegistros0210.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_REGISTRO_0210";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarRegistrosK280.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_REGISTRO_K280";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbPeriodoK280.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PERIODO_K280";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarRegSomenteK200Sped.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_SOMENTE_K200";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodRecFECP.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CODIGO_RECEITA_FECP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodGare.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CODIGO_RECEITA_GARE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUtilizarPrecoConfiguradoRegH010.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "UTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUtilizaPartBrokerOuTerceiro.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "UTILIZA_ESTOQUE_TERCEIRO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbPrecoRegH010Campo06.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PRECO_REGH010_CAMPO06";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbPrecoRegH010Campo11.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PRECO_REGH010_CAMPO11";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtPartTerceiroSped.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PARTICIPANTE_TERCEIRO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtPartBrokerSped.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PARTICIPANTE_BROKER";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtContaAnaliticaTerceiroSpedBlocoH.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CONTA_ANALITICA_TERCEIRO_H010";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtContaAnaliticaBrokerSpedBlocoH.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CONTA_ANALITICA_BROKER_H010";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(rgAlteracaoTributaria.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ALTERACAO_TRIBUTARIA";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarApenasOsItensTributados.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_APENAS_OS_ITENS_TRIBUTADOS";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtAliqInventOuAliqDigitada.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "USAR_ALIQ_INVENT_OU_ALIQ_DIGITADA";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtEmpresasSelecionadas.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EMPRESAS_SELECIONADAS_REGH010_REGK200";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarPisCofins_.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EnviarPisCofins_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIAR_C180_C185.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_C180_C185";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIANOTADEBITOCREDITODEVOLUCAO.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIANOTADEBITOCREDITODEVOLUCAO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190";');

    {Aba Fiscal - 2}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarFcpNfSpedFiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_FCP_NFE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarFcpNfceSpedFiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_FCP_NFCE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarVlrFcpCampo24C100_09C190.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_VALFCP_CAMPO_24C100_09C190";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkFiscaisCat42.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_FISCAIS_CAT42";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkRegraCat66ConsolidadoSpedfiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REGRA_CAT66_CONSOLIDADO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkRegraCat66Spedfiscal.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REGRA_CAT66";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkRegraCat66ApenasCfop.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REGRA_CAT66_CFOP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chk54Detalhado.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "REGRA_CAT54_DETALHADO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCstServicoSpedFiscal.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_SERVICO_REGC170";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjuE111TransfCre.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "COD_AJU_E111_TRANSF_CRE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDesAjuE111TransfCre.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DES_AJU_E111_TRANSF_CRE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjuE111TransfDeb.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "COD_AJU_E111_TRANSF_DEB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDesAjuE111TransfDeb.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DES_AJU_E111_TRANSF_DEB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjuE111MudancaTribSpedFiscal.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "COD_AJU_E111_MUDANCA_TRIB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDesAjuE111MudancaTribSpedFiscal.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DES_AJU_E111_MUDANCA_TRIB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjuE116DifAliqSpedFiscal.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "COD_AJU_E116_DIFERENCA_ALIQ";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviarCST090CT.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_090_CT";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCstBaseIcmsIgualD190.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_BASE_ICMS_IGUAL_D190";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCstBaseIcmsMenorD190.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_BASE_ICMS_MENOR_D190";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCstBaseIcmsZeradoD190.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_BASE_ICMS_ZERADO_D190";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCstCteComplementarD190.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_CTE_COMPLEMENTAR_D190";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkUtilizarRotinaDeContabilidade.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "UTILIZAR_ROTINA_DE_CONTABILIDADE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnviaCodFabricaNaDescricaoRegC170.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EnviaCodFabricaNaDescricaoRegC170_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnvDescrC170UsoCon.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EnvDescrC170UsoCon";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEnvCodProd0205.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EnviarCodigoAnteriorProduto_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + mskDtIni0205.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DataInicialCodigoAnterior_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + mskDtFin0205.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DataFinalCodigoAnterior_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkReg1400.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "Reg1400_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodigoItemIPM.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CodIPMReg1400_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkIncluirCFOP5929_6959RegG110.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "IncluirCFOP5929_6959RegG110_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkG110TributContabil.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "G110TributContabil_";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkEntrarNotasMunicipaisServico.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "EntrarNotasMunicipaisDeServico_";');

    {Aba Fiscal - 3}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCOD_AJU_E113_PRESUM_PR_CRE.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "COD_AJU_E113_PRESUM_PR_CRE";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbIndTipLayK010.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "IndTipLayK010";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCFOPNaoGeraReceita.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CFOPNaoGeraReceita";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCFOP_Tratada_Como_Substituto.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CFOP_Tratada_Como_Substituto";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbENVIA_VLDOC_VLMERC_5929.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIA_VLDOC_VLMERC_5929";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCODIGO_RECEITA_090_E116.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CODIGO_RECEITA_090_E116";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCST_MONOFASICO_ICMS_ENTRADA.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CST_MONOFASICO_ICMS_ENTRADA";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkNAO_ENVIAR_E200_SE_VALORES_IGUAL0.Checked, '1', '0') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "NAO_ENVIAR_E200_SE_VALORES_IGUAL0";');

    {Aba Dados Recolhimento ICMS}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodEstadRecolheIcms.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_COD_ESTAD_RECOLHE_ICMS";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDiaVencIcms.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_DIA_VENC_ICMS";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDiaVencIcmsST.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_DIA_VENC_ICMS_ST";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodEstadRecolheIcmsSTDentroEstado.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDiaVencDifalDestino.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_DIA_VENC_DIFAL_DESTINO";');

    {Aba Códigos de Ajustes}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjIcmsProprioFECP.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CODIGO_ICMS_PROPRIO_FCP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDescAjIcmsProprioFECP.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DESC_ICMS_PROPRIO_FCP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCodAjIcmsProprioFECP2.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CODIGO_ICMS_PROPRIO_FCP_2";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDescAjIcmsProprioFECP2.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "DESC_ICMS_PROPRIO_FCP_2";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chk19XXSubApuracaoICMS.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "19XXSubApuracaoICMS";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtDescr19XXSubApuracaoICMS.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "Descr19XXSubApuracaoICMS";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtSPED_COD_RECOLHE_ICMS_1926.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SPED_COD_RECOLHE_ICMS_1926";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIA1923SUB.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIA1923SUB";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkG_DTAAQU_MES.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "G_DTAAQU_MES";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkSubApuCorrImporta.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "SubApuCorrImporta";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + edtCFOP_ISENTAS_CIAP_MODELO_C.Text + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "CFOP_ISENTAS_CIAP_MODELO_C";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIAR_VALOR_DIFAL_CIAP.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_VALOR_DIFAL_CIAP";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkENVIAR_X929_SAIDA_CIAP.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "ENVIAR_X929_SAIDA_CIAP";');

    {Aba Validações}
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IIF(chkVALIDAR_CODIGO_RECEITA_REG_E.Checked, 'S', 'N') + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "VALIDAR_CODIGO_RECEITA_REG_E";');

    qryAux.ExecSQL;

  finally
  end;
end;

procedure TfrmCfgSpedFiscal.pAlimentaObjetosEmTelaComBaseNoBancoDados;
begin

  {Aba Filtros}
  pSetComboFiltroValor(cmbPERFIL_DECLARANTE, fRetConfiguracao('PERFIL_DECLARANTE'));
  pSetComboFiltroValor(cmbFINALIDADE_ARQUIVO, fRetConfiguracao('FINALIDADE_ARQUIVO'));
  pSetComboFiltroValor(cmbTIPO_ATIVIDADE, fRetConfiguracao('TIPO_ATIVIDADE'));
  pSetComboFiltroValor(cmbCLASSIF_CONTRIB_IPI, fRetConfiguracao('CLASSIF_CONTRIB_IPI'));
  pSetComboFiltroValor(cmbREGIME_SUBST_TRIB, fRetConfiguracao('REGIME_SUBST_TRIB'));
  pSetComboFiltroValor(cmbREG0015_ENV_IE_UF_DEST, fRetConfiguracao('REG0015_ENV_IE_UF_DEST'));

  {Aba Fiscal}
  edtCodFor.Text := fRetConfiguracao('FORNECEDOR_ICMS_ANTECIPADO');
  edtSpedCfopIndPag.Text := fRetConfiguracao('CFOP_INDICADOR_PAGAMENTO_FIXO');
  chkEnvia0460icmstipi.Checked := fRetConfiguracao('TIP_EXPORTACAO_0460') = '1';
  chkAjuDet.Checked := fRetConfiguracao('TIP_AJUSTE') = '1';
  chkEnviarNfSaidaRegE250.Checked := fRetConfiguracao('ENVIAR_NF_SAIDA_E250') = '1';
  chkEnviarValDevDifal.Checked := fRetConfiguracao('ENVIAR_VALOR_DEV_DIFAL') = '1';
  chkEnviarC195.Checked := fRetConfiguracao('ENVIAR_C195') = '1';
  chkEnviaAjustesFECP.Checked := fRetConfiguracao('ENVIAR_AJU_FECP') = '1';
  chkUniCompraEntradaConvertida.Checked := fRetConfiguracao('ENVIAR_UN_COMPRA_CONVERTIDA') = '1';
  chkRegE316Analitico.Checked := fRetConfiguracao('REG_E316') = '1';
  chkEnviaPrecoLiquidoH010.Checked := fRetConfiguracao('PRECO_LIQUIDO_H010_CAMPO11') = '1';
  chkEnviarDadosEmpresaAnteriorSpedFiscal.Checked := fRetConfiguracao('ENVIAR_DADOS_EMPANT') = '1';
  chkEnviarCredIcmsCat158Sped.Checked := fRetConfiguracao('ENVIAR_CREDICMS_CAT158') = '1';
  chkEnviarFixo1RegC100Campo13.Checked := fRetConfiguracao('ENVIAR_FIXO_1_REGC100_CAMPO13') = 'S';
  chkEnviarH020Especial.Checked := fRetConfiguracao('ENVIAR_H020_ESPECIAL') = '1';
  chkEnviarDesc0460_C195.Checked := fRetConfiguracao('ALTERAR_DESCR_REG_0460_E_C195') = 'S';
  chkUniCompraEntradaFornecedor.Checked := fRetConfiguracao('ENVIAR_UN_COMPRA_FORNECEDOR') = '1';
  chkEnviarRegE316IESubstSpedFiscal.Checked := fRetConfiguracao('REG_E316_IE_SUBST') = '1';
  rgTipExpE200.ItemIndex := StrToIntDef(fRetConfiguracao('TIP_EXPORTACAO_E200'), -1);
  rgInfoBlocoK.ItemIndex := StrToIntDef(fRetConfiguracao('DADOS_BLOCOK_SIM_NAO'), -1);
  chkEnviarRegistrosK220.Checked := fRetConfiguracao('ENVIAR_REGISTRO_K220') = 'S';
  chkEnviarRegistros0210.Checked := fRetConfiguracao('ENVIAR_REGISTRO_0210') = 'S';
  chkEnviarRegistrosK280.Checked := fRetConfiguracao('ENVIAR_REGISTRO_K280') = 'S';
  cmbPeriodoK280.ItemIndex := StrToIntDef(fRetConfiguracao('PERIODO_K280'), 0);
  chkEnviarRegSomenteK200Sped.Checked := fRetConfiguracao('ENVIAR_SOMENTE_K200') = 'S';
  edtCodRecFECP.Text := fRetConfiguracao('CODIGO_RECEITA_FECP');
  edtCodGare.Text := fRetConfiguracao('CODIGO_RECEITA_GARE');
  chkUtilizarPrecoConfiguradoRegH010.Checked := fRetConfiguracao('UTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11') = 'S';
  chkUtilizaPartBrokerOuTerceiro.Checked := fRetConfiguracao('UTILIZA_ESTOQUE_TERCEIRO') = '1';
  cmbPrecoRegH010Campo06.ItemIndex := StrToIntDef(fRetConfiguracao('PRECO_REGH010_CAMPO06'), -1);
  cmbPrecoRegH010Campo11.ItemIndex :=  StrToIntDef(fRetConfiguracao('PRECO_REGH010_CAMPO11'), -1);
  edtPartTerceiroSped.Text := fRetConfiguracao('PARTICIPANTE_TERCEIRO');
  edtPartBrokerSped.Text := fRetConfiguracao('PARTICIPANTE_BROKER');
  edtContaAnaliticaTerceiroSpedBlocoH.Text := fRetConfiguracao('CONTA_ANALITICA_TERCEIRO_H010');
  edtContaAnaliticaBrokerSpedBlocoH.Text := fRetConfiguracao('CONTA_ANALITICA_BROKER_H010');
  rgAlteracaoTributaria.ItemIndex := StrToIntDef(fRetConfiguracao('ALTERACAO_TRIBUTARIA'), -1);
  chkEnviarApenasOsItensTributados.Checked := fRetConfiguracao('ENVIAR_APENAS_OS_ITENS_TRIBUTADOS') = 'S';
  edtAliqInventOuAliqDigitada.Text := fRetConfiguracao('USAR_ALIQ_INVENT_OU_ALIQ_DIGITADA');
  edtEmpresasSelecionadas.Text := fRetConfiguracao('EMPRESAS_SELECIONADAS_REGH010_REGK200');
  chkEnviarPisCofins_.Checked := fRetConfiguracao('EnviarPisCofins_') = 'S';
  chkENVIAR_C180_C185.Checked := fRetConfiguracao('ENVIAR_C180_C185') = 'S';
  chkENVIANOTADEBITOCREDITODEVOLUCAO.Checked := fRetConfiguracao('ENVIANOTADEBITOCREDITODEVOLUCAO') = 'S';
  edtCST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190.Text := fRetConfiguracao('CST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190');

  {Aba Fiscal - 2}
  chkEnviarFcpNfSpedFiscal.Checked := fRetConfiguracao('ENVIAR_FCP_NFE') = '1';
  chkEnviarFcpNfceSpedFiscal.Checked := fRetConfiguracao('ENVIAR_FCP_NFCE') = '1';
  chkEnviarVlrFcpCampo24C100_09C190.Checked := fRetConfiguracao('ENVIAR_VALFCP_CAMPO_24C100_09C190') = 'S';
  chkFiscaisCat42.Checked := fRetConfiguracao('ENVIAR_FISCAIS_CAT42') = '1';
  chkRegraCat66ConsolidadoSpedfiscal.Checked := fRetConfiguracao('REGRA_CAT66_CONSOLIDADO') = '1';
  chkRegraCat66Spedfiscal.Checked := fRetConfiguracao('REGRA_CAT66') = '1';
  chkRegraCat66ApenasCfop.Checked := fRetConfiguracao('REGRA_CAT66_CFOP') = '1';
  chk54Detalhado.Checked := fRetConfiguracao('REGRA_CAT54_DETALHADO') = '1';
  edtCstServicoSpedFiscal.Text := fRetConfiguracao('CST_SERVICO_REGC170');
  edtCodAjuE111TransfCre.Text := fRetConfiguracao('COD_AJU_E111_TRANSF_CRE');
  edtDesAjuE111TransfCre.Text := fRetConfiguracao('DES_AJU_E111_TRANSF_CRE');
  edtCodAjuE111TransfDeb.Text := fRetConfiguracao('COD_AJU_E111_TRANSF_DEB');
  edtDesAjuE111TransfDeb.Text := fRetConfiguracao('DES_AJU_E111_TRANSF_DEB');
  edtCodAjuE111MudancaTribSpedFiscal.Text := fRetConfiguracao('COD_AJU_E111_MUDANCA_TRIB');
  edtDesAjuE111MudancaTribSpedFiscal.Text := fRetConfiguracao('DES_AJU_E111_MUDANCA_TRIB');
  edtCodAjuE116DifAliqSpedFiscal.Text := fRetConfiguracao('COD_AJU_E116_DIFERENCA_ALIQ');
  chkEnviarCST090CT.Checked := fRetConfiguracao('CST_090_CT') = '1';
  edtCstBaseIcmsIgualD190.Text := fRetConfiguracao('CST_BASE_ICMS_IGUAL_D190');
  edtCstBaseIcmsMenorD190.Text := fRetConfiguracao('CST_BASE_ICMS_MENOR_D190');
  edtCstBaseIcmsZeradoD190.Text := fRetConfiguracao('CST_BASE_ICMS_ZERADO_D190');
  edtCstCteComplementarD190.Text := fRetConfiguracao('CST_CTE_COMPLEMENTAR_D190');
  chkUtilizarRotinaDeContabilidade.Checked := fRetConfiguracao('UTILIZAR_ROTINA_DE_CONTABILIDADE') = 'S';
  chkEnviaCodFabricaNaDescricaoRegC170.Checked := fRetConfiguracao('EnviaCodFabricaNaDescricaoRegC170_') = 'S';
  chkEnvDescrC170UsoCon.Checked := fRetConfiguracao('EnvDescrC170UsoCon') = 'S';
  chkEnvCodProd0205.Checked := fRetConfiguracao('EnviarCodigoAnteriorProduto_') = 'S';
  mskDtIni0205.Text :=  fRetConfiguracao('DataInicialCodigoAnterior_');
  mskDtFin0205.Text :=  fRetConfiguracao('DataFinalCodigoAnterior_');
  chkReg1400.Checked := fRetConfiguracao('Reg1400_') = 'S';
  edtCodigoItemIPM.Text := fRetConfiguracao('CodIPMReg1400_');
  chkIncluirCFOP5929_6959RegG110.Checked := fRetConfiguracao('IncluirCFOP5929_6959RegG110_') = 'S';
  chkG110TributContabil.Checked := fRetConfiguracao('G110TributContabil_') = 'S';
  chkEntrarNotasMunicipaisServico.Checked := fRetConfiguracao('EntrarNotasMunicipaisDeServico_') = 'S';
  chkRegraCat66ApenasCfop.Visible := ((chkRegraCat66Spedfiscal.Checked) or (chkRegraCat66ConsolidadoSpedfiscal.Checked));

  {Aba Fiscal - 3}
  chkENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR.Checked := fRetConfiguracao('ENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR') = 'S';
  edtCFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR.Text :=  fRetConfiguracao('CFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR');
  edtCOD_AJU_E113_PRESUM_PR_CRE.Text :=  fRetConfiguracao('COD_AJU_E113_PRESUM_PR_CRE');
  cmbIndTipLayK010.ItemIndex := StrToIntDef(fRetConfiguracao('IndTipLayK010'), 0);
  edtCFOPNaoGeraReceita.Text := fRetConfiguracao('CFOPNaoGeraReceita');
  edtCFOP_Tratada_Como_Substituto.Text := fRetConfiguracao('CFOP_Tratada_Como_Substituto');
  cmbENVIA_VLDOC_VLMERC_5929.ItemIndex := StrToIntDef(fRetConfiguracao('ENVIA_VLDOC_VLMERC_5929'), 0);
  edtCODIGO_RECEITA_090_E116.Text := fRetConfiguracao('CODIGO_RECEITA_090_E116');
  edtCST_MONOFASICO_ICMS_ENTRADA.Text := fRetConfiguracao('CST_MONOFASICO_ICMS_ENTRADA');
  chkNAO_ENVIAR_E200_SE_VALORES_IGUAL0.Checked := fRetConfiguracao('NAO_ENVIAR_E200_SE_VALORES_IGUAL0') = '1';

  {Aba Dados Recolhimento ICMS}
  edtCodEstadRecolheIcms.Text := fRetConfiguracao('SPED_COD_ESTAD_RECOLHE_ICMS');
  edtDiaVencIcms.Text := fRetConfiguracao('SPED_DIA_VENC_ICMS');
  edtDiaVencIcmsST.Text := fRetConfiguracao('SPED_DIA_VENC_ICMS_ST');
  edtCodEstadRecolheIcmsSTDentroEstado.Text := fRetConfiguracao('SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO');
  edtDiaVencDifalDestino.Text := fRetConfiguracao('SPED_DIA_VENC_DIFAL_DESTINO');

  {Aba Códigos de Ajustes}
  edtCodAjIcmsProprioFECP.Text := fRetConfiguracao('CODIGO_ICMS_PROPRIO_FCP');
  edtDescAjIcmsProprioFECP.Text := fRetConfiguracao('DESC_ICMS_PROPRIO_FCP');
  edtCodAjIcmsProprioFECP2.Text := fRetConfiguracao('CODIGO_ICMS_PROPRIO_FCP_2');
  edtDescAjIcmsProprioFECP2.Text := fRetConfiguracao('DESC_ICMS_PROPRIO_FCP_2');
  chk19XXSubApuracaoICMS.Checked := fRetConfiguracao('19XXSubApuracaoICMS') = 'S';
  edtDescr19XXSubApuracaoICMS.Text := fRetConfiguracao('Descr19XXSubApuracaoICMS');
  edtSPED_COD_RECOLHE_ICMS_1926.Text := fRetConfiguracao('SPED_COD_RECOLHE_ICMS_1926');
  chkENVIA1923SUB.Checked := fRetConfiguracao('ENVIA1923SUB') = 'S';
  chkG_DTAAQU_MES.Checked := fRetConfiguracao('G_DTAAQU_MES') = 'S';
  chkSubApuCorrImporta.Checked := fRetConfiguracao('SubApuCorrImporta') = 'S';
  edtCFOP_ISENTAS_CIAP_MODELO_C.Text := fRetConfiguracao('CFOP_ISENTAS_CIAP_MODELO_C');
  chkENVIAR_VALOR_DIFAL_CIAP.Checked := fRetConfiguracao('ENVIAR_VALOR_DIFAL_CIAP') = 'S';
  chkENVIAR_X929_SAIDA_CIAP.Checked := fRetConfiguracao('ENVIAR_X929_SAIDA_CIAP') = 'S';

  {Aba Validações}
  chkVALIDAR_CODIGO_RECEITA_REG_E.Checked := fRetConfiguracao('VALIDAR_CODIGO_RECEITA_REG_E') = 'S';
end;

procedure TfrmCfgSpedFiscal.pCriaConfiguracoesBancoDeDadosDefault;
begin

  {Aba Filtros}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PERFIL_DECLARANTE',                          'CFG_PERDEC', '',     '', 'Perfil do Declarante',                                                                                                                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'FINALIDADE_ARQUIVO',                         'CFG_FINARQ', '',     '', 'Finalidade do Arquivo',                                                                                                                                                                                                              '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'TIPO_ATIVIDADE',                             'CFG_TIPATI', '',     '', 'Tipo de Atividade',                                                                                                                                                                                                                  '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CLASSIF_CONTRIB_IPI',                        'CFG_CLCTIP', '',     '', 'Classificação de Contribuintes do IPI',                                                                                                                                                                                              '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REGIME_SUBST_TRIB',                          'CFG_RESUTR', '',     '', 'Regime de Substituição Tributária',                                                                                                                                                                                                  '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REG0015_ENV_IE_UF_DEST',                     'CFG_R15UFD', '',     '', 'Registro 0015 - Enviar IE na UF de Destino',                                                                                                                                                                                         '', '',   'CONFIGURACOES-12_SPED_FISCAL_F', 0, Date, fTime(), 'S');

  {Aba Fiscal}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'FORNECEDOR_ICMS_ANTECIPADO',                 'CFG_FICMAT', '',     '', 'Código do Fornecedor ICMS antecipado',                                                                                                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CFOP_INDICADOR_PAGAMENTO_FIXO',              'CFG_CIPGFX', '',     '', 'CFOP com indicador de pagamento 2=OUTROS',                                                                                                                                                                                           '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'TIP_EXPORTACAO_0460',                        'CFG_TEX460', '0',    '', 'Enviar Somente o registro 0460 de ICMS-ST e IPI 0=Não 1=Sim',                                                                                                                                                                        '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'TIP_AJUSTE',                                 'CFG_TIPAJU', '',     '', 'Enviar os Ajustes Detalhado por Produtos 0=Não 1=Sim',                                                                                                                                                                               '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_NF_SAIDA_E250',                       'CFG_ENFSE2', 'E',    '', 'Enviar Notas Fiscais de Saídas registro E250 0=Não 1=Sim',                                                                                                                                                                           '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_VALOR_DEV_DIFAL',                     'CFG_EVLDVD', '',     '', 'Enviar valores de Devolução de venda de DIFAL não contribuinte (Valores da UF destino) 0=Não 1=Sim',                                                                                                                                 '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_C195',                                'CFG_ENC195', 'C',    '', 'Enviar registro C195 0=Não 1=Sim',                                                                                                                                                                                                   '', '1',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_AJU_FECP',                            'CFG_ENFECP', '',     '', 'Enviar Ajustes do FECP 0=Não 1=Sim',                                                                                                                                                                                                 '','0',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_UN_COMPRA_CONVERTIDA',                'CFG_EUCCON', '',     '', 'Enviar Unidade de Compra para Entradas Convertidas 0=Não 1=Sim',                                                                                                                                                                     '','0',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REG_E316',                                   'CFG_RGE316', 'E',    '', 'Enviar registro E316 Analítico 0=Não 1=Sim',                                                                                                                                                                                         '','0',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PRECO_LIQUIDO_H010_CAMPO11',                 'CFG_PLH010', 'H',    '', 'Enviar preço líquido registro H010 campo 11 0=Não 1=Sim',                                                                                                                                                                            '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_DADOS_EMPANT',                        'CFG_EDEMPA', '',     '', 'Enviar dados de Empresas Anteriores 1=Sim 0=Não',                                                                                                                                                                                    '', '0',  'CONFIGURACOES-PIS_COFINS',       0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_CREDICMS_CAT158',                     'CFG_CAT158', '',     '', 'Enviar Crédito de ICMS CAT158 0=Não 1=Sim',                                                                                                                                                                                          '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_FIXO_1_REGC100_CAMPO13',              'CFG_F1C100', 'C',    '', 'Enviar fixo 1 registro C100 Campo 13',                                                                                                                                                                                               '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_H020_ESPECIAL',                       'CFG_EH020E', 'H',    '', 'Enviar H020 Especial 0=Não 1=Sim',                                                                                                                                                                                                   '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALTERAR_DESCR_REG_0460_E_C195',              'CFG_EDRCDB', '0, C', '', 'Enviar Desc. do Reg. 0460/C195 qdo Código de Ajuste XX23000999',                                                                                                                                                                     '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_UN_COMPRA_FORNECEDOR',                'CFG_UNCOFO', '',     '', 'Enviar Unidade de Compra para Entradas do Fornecedor 0=Não 1=Sim',                                                                                                                                                                   '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REG_E316_IE_SUBST',                          'CFG_E316IE', 'E',    '', 'Enviar registro E316 Inscrição Estadual Substituição Tributária 0=Não 1=Sim',                                                                                                                                                        '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'TIP_EXPORTACAO_E200',                        'CFG_TEE200', 'E',    '', 'Tipo da Exportação Registro E200 0=GNRE 1=GARE',                                                                                                                                                                                     '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DADOS_BLOCOK_SIM_NAO',                       'CFG_DBLKSN', 'K',    '', 'Informações Bloco K 0=Sim 1=Não 2=Indústria Não enviar K230/K235',                                                                                                                                                                   '', '1',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_REGISTRO_K220',                       'CFG_RGK220', 'K',    '', 'Informações Bloco K Enviar Registros K220, configuração casada com a configuração Informações Bloco K 0=Sim',                                                                                                                        '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_REGISTRO_0210',                       'CFG_RG0210', '0, K', '', 'Informações Bloco K Enviar Registros 0210, configuração casada com a configuração Informações Bloco K 0=Sim',                                                                                                                        '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_REGISTRO_K280',                       'CFG_RGK280', 'K',    '', 'Informações Bloco K Enviar Registros K280, configuração casada com a configuração Informações Bloco K 0=Sim',                                                                                                                        '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PERIODO_K280',                               'CFG_PEK280', 'K',    '', 'Período K280 (0 - Anual, 1 - Trimestral)',                                                                                                                                                                                           '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_SOMENTE_K200',                        'CFG_SMK200', 'K',    '', 'Enviar Somente registro K200',                                                                                                                                                                                                       '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_FECP',                        'CFG_CRFECP', '',     '', 'Informações da FECP - Código Receita',                                                                                                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_GARE',                        'CFG_CRGARE', 'E',    '', 'Informações da GARE - Código Receita, configuração casada com a configuração Tipo da Exportação Registro E200 1=GARE',                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'UTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11', 'CFG_UPC611', 'H',    '', 'Inventário - Utilizar os Preços Configurados, configuração com vinculo das configurações Preço campo 06 Registro H010 e/ou Preço campo 11 Registro H010',                                                                            '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'UTILIZA_ESTOQUE_TERCEIRO',                   'CFG_UEBRPT', 'H',    '', 'Utilizar Estoque Participante Terceiro 0=Broker 1=Terceiro',                                                                                                                                                                         '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PRECO_REGH010_CAMPO06',                      'CFG_PRHCM6', 'H',    '', 'Inventário - Preço campo 06 Registro H010, 0=Compra 1=Custo 2=Venda1 3=Venda2 4=Venda3 5=Venda4 6=Venda5 7=Venda6 8=Venda7 9=Médio Compra 10=Últ. Compra menos Impostos Federais 11=Compra mais Impostos 12=Compra Líquido',         '', '-1', 'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PRECO_REGH010_CAMPO11',                      'CFG_PRHC11', 'H',    '', 'Inventário - Preço campo 11 Registro H010, 0=Compra 1=Custo 2=Venda1 3=Venda2 4=Venda3 5=Venda4 6=Venda5 7=Venda6 8=Venda7 9=Médio Compra 10=Últ. Compra menos Impostos Federais 11=Compra mais Impostos 12=Compra Líquido',         '', '-1', 'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PARTICIPANTE_TERCEIRO',                      'CFG_PARTER', 'H',    '', 'Inventário - Participante Terceiro',                                                                                                                                                                                                 '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PARTICIPANTE_BROKER',                        'CFG_PARBRO', 'H',    '', 'Inventário - Participante Broker',                                                                                                                                                                                                   '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CONTA_ANALITICA_TERCEIRO_H010',              'CFG_CATERH', 'H',    '', 'Inventário - Conta Analítica Terceiro',                                                                                                                                                                                              '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CONTA_ANALITICA_BROKER_H010',                'CFG_CAH010', 'H',    '', 'Inventário - Conta Analítica Broker',                                                                                                                                                                                                '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ALTERACAO_TRIBUTARIA',                       'CFG_ATRPRO', 'H',    '', 'Alteração Tributária de Produtos, 0=Substituídos Produtos Tributados 1=Tributados Produtos Substituídos',                                                                                                                            '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_APENAS_OS_ITENS_TRIBUTADOS',          'CFG_EAOSIT', 'H',    '', 'Aliquota para o Crédito - Enviar Apenas os Itens Tributados',                                                                                                                                                                        '', 'N',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'USAR_ALIQ_INVENT_OU_ALIQ_DIGITADA',          'CFG_UAIOAD', 'H',    '', 'Aliquota para o Crédito Registro H020 Moitvo 04 - Aplicado apenas p/ Itens Tributados, configuração determina se usa Aliquota Digitada ou do Inventário',                                                                            '', '0',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EMPRESAS_SELECIONADAS_REGH010_REGK200',      'CFG_ESRHEK', 'H, K', '', 'Empresa(s) á Considerar no Somatório dos Registros H010 e K200',                                                                                                                                                                     '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EnviarPisCofins_',                           'CFG_PISCOF', 'C',    '', 'Enviar PIS e a COFINS',                                                                                                                                                                                                              '', 'S',  'TELA-OPC002-PIS-COFINS',         0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_C180_C185',                           'CFG_ERC18X', '',     '', 'Enviar o Registro C180/C185 no Sped Fiscal?',                                                                                                                                                                                        '', 'S',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIANOTADEBITOCREDITODEVOLUCAO',            'CFG_ENDCDV', '',     '', 'Enviar Notas de Debito/Credito de Devoluções?',                                                                                                                                                                                      '', 'S',  'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_BASE_ICMS_ZERADO_VLR_CONTABIL_MAIOR_ZERO_D190', 'CFG_BIZVCM', 'D', '', 'Com Base de Cálculo Zero e Valor Contábil Maior que Zero',                                                                                                                                                                       '', '',   'CONFIGURACOES-12_SPED_FISCAL',   0, Date, fTime(), 'S');

  {Aba Fiscal - 2}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_FCP_NFE',                             'CFG_FCPNFE', '',     '', 'Enviar FCP=Fundo de Combate a Pobreza Somado a NF-e 0=Não 1=Sim',                                                                                                                                                                    '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_FCP_NFCE',                            'CFG_FCPNFC', '',     '', 'Enviar FCP=Fundo de Combate a Pobreza Somado a NFC-e 0=Não 1=Sim',                                                                                                                                                                   '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_VALFCP_CAMPO_24C100_09C190',          'CFG_E2409C', 'C',    '', 'Enviar VALOR FCP-ST nos campos de ST, C100 / C170 / C190',                                                                                                                                                                           '', 'N',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_FISCAIS_CAT42',                       'CFG_FISCAT', 'E',    '', 'Enviar Fiscais Cat-42 (Registros E111/E112) 0=Não 1=Sim',                                                                                                                                                                            '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REGRA_CAT66_CONSOLIDADO',                    'CFG_CAT66C', '',     '', 'Regra Cat-66 Consolidado, está configuração não pode ser setada com a configuração (Regra Cat-66) e esta configuração e casada com a configuração (Enviar apenas o CFOP na Descrição do Ajuste da Regra Cat-66 1=Sim) 0=Não 1=Sim',  '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REGRA_CAT66',                                'CFG_RCAT66', '',     '', 'Regra Cat-66, está configuração não pode ser setada com a configuração (Regra Cat-66 Consolidados) e esta configuração e casada com a configuração (Enviar apenas o CFOP na Descrição do Ajuste da Regra Cat-66 1=Sim) 0=Não 1=Sim', '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REGRA_CAT66_CFOP',                           'CFG_C66CFO', '',     '', 'Enviar apenas o CFOP na Descrição do Ajuste da Regra Cat-66 0=Não 1=Sim',                                                                                                                                                            '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'REGRA_CAT54_DETALHADO',                      'CFG_CAT54D', '',     '', 'Regra Cat-54 Detalhado 0=Não 1=Sim',                                                                                                                                                                                                 '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_SERVICO_REGC170',                        'CFG_CSR170', 'C',    '', 'CST p/ Serviço Registro C170',                                                                                                                                                                                                       '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_AJU_E111_TRANSF_CRE',                    'CFG_CAE1TC', 'E',    '', 'Código do Ajuste E111 Transferência Crédito',                                                                                                                                                                                        '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DES_AJU_E111_TRANSF_CRE',                    'CFG_DAE1TC', 'E',    '', 'Descrição do Ajuste E111 Transferência Crédito',                                                                                                                                                                                     '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_AJU_E111_TRANSF_DEB',                    'CFG_CAE1TD', 'E',    '', 'Código do Ajuste E111 Transferência Débito',                                                                                                                                                                                         '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DES_AJU_E111_TRANSF_DEB',                    'CFG_DAE1TD', 'E',    '', 'Descrição do Ajuste E111 Transferência Débito',                                                                                                                                                                                      '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_AJU_E111_MUDANCA_TRIB',                  'CFG_CAE1MT', 'E, H', '', 'Código Ajuste E111 H020 Mudança Tributária',                                                                                                                                                                                         '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DES_AJU_E111_MUDANCA_TRIB',                  'CFG_DAE1MT', 'E, H', '', 'Descrição Ajuste E111 H020 Mudança Tributária',                                                                                                                                                                                      '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_AJU_E116_DIFERENCA_ALIQ',                'CFG_CAE1DA', 'E',    '', 'Código Ajuste E116 Diferencial de Alíquota',                                                                                                                                                                                         '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_090_CT',                                 'CFG_C090CT', 'D',    '', 'Enviar CST 090 para Documentos com Espécie CT, configuração casada com as configurações de grupo (CST Transporte Registro D190 0=Não) 0=Não 1=Sim',                                                                                  '', '0',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_BASE_ICMS_IGUAL_D190',                   'CFG_CBIID1', 'D',    '', 'CST Transporte Registro D190 - Com ICMS e Base de Cálculo igual ao Valor Contábil, configuração casada com a configuração (Enviar CST 090 para Documentos com Espécie CT 0=Não)',                                                    '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_BASE_ICMS_MENOR_D190',                   'CFG_CBIMD1', 'D',    '', 'CST Transporte Registro D190 - Com ICMS e Base de Cáculo menor que o Valor Contábil, configuração casada com a configuração (Enviar CST 090 para Documentos com Espécie CT 0=Não)',                                                  '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_BASE_ICMS_ZERADO_D190',                  'CFG_CBIZD1', 'D',    '', 'CST Transporte Registro D190 - Base de ICMS Zero, configuração casada com a configuração (Enviar CST 090 para Documentos com Espécie CT 0=Não)',                                                                                     '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_CTE_COMPLEMENTAR_D190',                  'CFG_CBICD1', 'D',    '', 'CST Transporte Registro D190 - CTE Complementar, configuração casada com a configuração (Enviar CST 090 para Documentos com Espécie CT 0=Não)',                                                                                      '', '',   'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'UTILIZAR_ROTINA_DE_CONTABILIDADE',           'CFG_URCONT', 'C, D', '', 'Enviar Conta Analítica Contábil - Utilizar Rotina de Contabilidade',                                                                                                                                                                 '', 'N',  'CONFIGURACOES-12_SPED_FISCAL_2', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EnviaCodFabricaNaDescricaoRegC170_',         'CFG_EFABDE', '',     '', 'Opções Extras - Enviar Código de Fábrica na Descrição dos Registros C170',                                                                                                                                                           '', 'N',  'TELA-OPC002-OPCOES-EXTRAS',      0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EnvDescrC170UsoCon',                         'CFG_EDIDUC', '',     '', 'Enviar Descrição dos Itens nos Documentos de Uso e Consumo',                                                                                                                                                                         '', 'N',  'TELA-OPC002-OPCOES-EXTRAS',      0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EnviarCodigoAnteriorProduto_',               'CFG_205CAP', '0',    '', 'Registro 0205, Enviar Código Anterior do Produto',                                                                                                                                                                                   '', 'N',           'TELA-OPC001-REG_0205',  0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DataInicialCodigoAnterior_',                 'CFG_205DTI', '0',    '', 'Registro 0205, Data Inicial configuração casa com a configuração Enviar Código Anterior do Produto',                                                                                                                                 '', '30/12/1899',  'TELA-OPC001-REG_0205',  0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DataFinalCodigoAnterior_',                   'CFG_205DTF', '0',    '', 'Registro 0205, Data Final configuração casa com a configuração Enviar Código Anterior do Produto',                                                                                                                                   '', '30/12/1899',  'TELA-OPC001-REG_0205',  0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'Reg1400_',                                   'CFG_ER1400', '1',    '', 'Enviar Registro 1400, Informação sobre Valores agregados',                                                                                                                                                                           '', 'N','TELA-OPC001-COMPL_ENV_BLC_OU_REG', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CodIPMReg1400_',                             'CFG_IPM140', '1',    '', 'Código do item (Índice de Participação dos Municípios - IPM) Reg. 1400 - (Casada com a configuração (CFG_ER1400 = S))',                                                                                                              '', '', 'TELA-OPC001-COMPL_ENV_BLC_OU_REG', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'IncluirCFOP5929_6959RegG110_',               'CFG_ECG110', 'G',    '', 'Enviar CFOP 5929/6929 na parte das saídas do Registro G110 (esta opção somente terá efeito casada com a configuração Enviar Bloco G habilitada)',                                                                                    '', 'N','TELA-OPC001-COMPL_ENV_BLC_OU_REG', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'G110TributContabil_',                        'CFG_TCG110', 'G',    '', 'Enviar CFOP 5929/6929 no campo 06 do registro G110 (esta opção somente terá efeito casada com a configuração Enviar Bloco G habilitada)',                                                                                            '', 'N','TELA-OPC001-COMPL_ENV_BLC_OU_REG', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'EntrarNotasMunicipaisDeServico_',            'CFG_OENFSV',  '',    '', 'Opções Extras - Enviar Notas Fiscais Municipais 1933/2933',                                                                                                                                                                          '', 'N','TELA-OPC002-SERVICOS',             0, Date, fTime(), 'S');

  {Aba Fiscal - 3}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIACREDITOPRESUMIDODOREGESPECOMMERCEPR',    'CFG_ENVCPR' ,'E',   '', 'Envia crédito presumido do regime especial E-Commerce do Paraná',                                                                                                                                                                    '', 'N',  'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CFOPSPARACREDITOPRESUMIDODOREGESPECOMMERCEPR','CFG_CFGCPR' ,'E',   '', 'CFOPs para crédito presumido do regime especial E-Commerce do Paraná',                                                                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'COD_AJU_E113_PRESUM_PR_CRE',                  'CFG_E113AJ' ,'E',   '', 'Código do ajuste usado no regime presumido do estado do Paraná para crédito (E113)',                                                                                                                                                 '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'IndTipLayK010',                               'CFG_IPLK10' ,'K',   '', 'Indicador de Tipo de Layout (K010)',                                                                                                                                                                                                 '', '0',  'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CFOPNaoGeraReceita',                          'CFG_CFNGRE' ,'',    '', 'CFOPs que não geram receita',                                                                                                                                                                                                        '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CFOP_Tratada_Como_Substituto',                'CFG_CFNGRE' ,'',    '', 'CFOPs tratadas como substituto',                                                                                                                                                                                                     '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIA_VLDOC_VLMERC_5929',                     'CFG_EVC100', 'C',   '', 'Enviar informação de valores no Campo Valor do Documento ou Valor da Mercadoria da CFOP 5929 no Registro C100',                                                                                                                      '', '0',  'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_RECEITA_090_E116',                     'CFG_CRC090', 'E',   '', 'Código da Receita para Cód. do ICMS 090 do Reg. E116',                                                                                                                                                                               '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CST_MONOFASICO_ICMS_ENTRADA',                 'CFG_CSTIEP' ,'',    '', 'CSTs Monofasicas de ICMS na Entrada de Produtos ',                                                                                                                                                                                   '', '',   'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'NAO_ENVIAR_E200_SE_VALORES_IGUAL0',           'CFG_NEE2VZ' ,'',    '', 'Não Enviar o Registro E200/E210, quando valores igual zero.',                                                                                                                                                                        '', '0',  'CONFIGURACOES-12_SPED_FISCAL_3', 0, Date, fTime(), 'S');

  {Aba Dados Recolhimento ICMS}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_COD_ESTAD_RECOLHE_ICMS',                'CFG_SPCERI',  '',    '', 'Código Estadual dentro Estado',                                                                                                                                                                                                      '', '',   'CONFIGURACOES-GERAL',            0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_DIA_VENC_ICMS',                         'CFG_SPDVIC',  '',    '', 'Dia do Vecimento do ICMS',                                                                                                                                                                                                           '', '',   'CONFIGURACOES-GERAL',            0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_DIA_VENC_ICMS_ST',                      'CFG_SPDVST',  '',    '', 'Dia do Vecimento do ICMS-ST',                                                                                                                                                                                                        '', '',   'CONFIGURACOES-GERAL',            0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO','CFG_CERIDE',  '',    '', 'Códico Estadual ICMS-ST dentro Estado',                                                                                                                                                                                              '', '',   'CONFIGURACOES-GERAL',            0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_DIA_VENC_DIFAL_DESTINO',                'CFG_SPDVDD',  '',    '', 'Data do Vencimento DIFAL Destino',                                                                                                                                                                                                   '', '',   'CONFIGURACOES-GERAL',            0, Date, fTime(), 'S');

  {Aba Códigos de Ajustes}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_ICMS_PROPRIO_FCP',                    'CFG_CIFCP1',  'E',    '', 'Código de Ajuste ICMS Próprio FCP Campo 12',                                                                                                                                                                                        '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DESC_ICMS_PROPRIO_FCP',                      'CFG_DIFCP1',  'E',    '', 'Descrição de Ajuste ICMS Próprio FCP Regsitro E110 Campo 12',                                                                                                                                                                       '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CODIGO_ICMS_PROPRIO_FCP_2',                  'CFG_CIFCP2',  'E',    '', 'Código de Ajuste ICMS Próprio FCP Campo 15',                                                                                                                                                                                        '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'DESC_ICMS_PROPRIO_FCP_2',                    'CFG_DIFCP2',  'E',    '', 'Descrição de Ajuste ICMS Próprio FCP Regsitro E110 Campo 15',                                                                                                                                                                       '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, '19XXSubApuracaoICMS',                        'CFG_ES19XX',  'E',    '', 'Enviar Sub-Apuração (19xx)',                                                                                                                                                                                                        '','N',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'Descr19XXSubApuracaoICMS',                   'CFG_DS19XX',  'E',    '', 'Descrição do campo 3 (1900)',                                                                                                                                                                                                       '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SPED_COD_RECOLHE_ICMS_1926',                 'CFG_SCRI19',  'E',    '', 'Cód. Receita ref. obrigação próprio da UF, conforme legislação estadual',                                                                                                                                                           '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIA1923SUB',                               'CFG_E19SUB',  'E',    '', 'Enviar informações adicionais (1923) Sub-apuração',                                                                                                                                                                                 '', 'N',  'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'G_DTAAQU_MES',                               'CFG_GDTMES',  'E',    '', 'Considerar o valor do G - CIAP dentro do mês de aquisição',                                                                                                                                                                         '', 'N',  'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'SubApuCorrImporta',                          'CFG_SACIMP',  'E',    '', '(1921 / 1923) Considerar alíquota de crédito presumido Ret. (Corredor de importação)',                                                                                                                                              '', 'N',  'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'CFOP_ISENTAS_CIAP_MODELO_C',                 'CFG_ISCIMC',  'E',    '', 'Lista de CFOPs que são consideradas isentas para o relatório CIAP Modelo C',                                                                                                                                                        '', '',   'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_VALOR_DIFAL_CIAP',                    'CFG_EDAVIC',  'E',    '', 'Envia Diferencial de Alíquota + Valor de ICMS no CIAP?',                                                                                                                                                                            '', 'N',  'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'ENVIAR_X929_SAIDA_CIAP',                     'CFG_ECXSAC',  'E',    '', 'Envia CFOP X929 na saída do CIAP?',                                                                                                                                                                                                 '', 'N',  'CONFIGURACOES-12_SPED_CODIGOS_AJUSTES', 0, Date, fTime(), 'S');

  {Aba Validações}
  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'VALIDAR_CODIGO_RECEITA_REG_E',               'CFG_VCRDRE',  'E',    '', 'Validar código de receita dos registros E116, E250 e E316',                                                                                                                                                                         '', 'S',  'CONFIGURACOES-12_SPED_VALIDACOES', 0, Date, fTime(), 'S');

end;

procedure TfrmCfgSpedFiscal.pGeraConfiguracoesBancoDeDados(strCodEmp,
  strCodCfg, strCdCfAb, strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg,
  strGruCfg: string; intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime;
  strLayout: string);
var
  Hora, Min, Sec, MSec : Word;
  strHraUltAlt: string;
begin
  DecodeTime(fNow, Hora, Min, Sec, MSec);
  strHraUltAlt := FormatDateTime('hh:mm:ss', hraUltAlt) + ':' + FormatFloat('000', MSec);

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT SPD_CODCFG FROM CFGSPD WHERE SPD_CODEMP = :CODEMP AND SPD_CODCFG = :CODCFG;');
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;
  if qryAux.IsEmpty then
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add( ' INSERT INTO CFGSPD ( ');
    qryAux.SQL.Add( '   SPD_CODEMP, ');
    qryAux.SQL.Add( '   SPD_CODCFG, ');
    qryAux.SQL.Add( '   SPD_CDCFAB, ');
    qryAux.SQL.Add( '   SPD_UTIBLC, ');
    qryAux.SQL.Add( '   SPD_PRIORI, ');
    qryAux.SQL.Add( '   SPD_DESCRI, ');
    qryAux.SQL.Add( '   SPD_REGNEG, ');
    qryAux.SQL.Add( '   SPD_VALCFG, ');
    qryAux.SQL.Add( '   SPD_GRUCFG, ');
    qryAux.SQL.Add( '   SPD_NUMHLP, ');
    qryAux.SQL.Add( '   SPD_ULTALT, ');
    qryAux.SQL.Add( '   SPD_CODGEN, ');
    qryAux.SQL.Add( '   SPD_LAYOUT ');
    qryAux.SQL.Add( ' ) ');
    qryAux.SQL.Add( ' VALUES ');
    qryAux.SQL.Add( '   ( ');
    qryAux.SQL.Add( '     :CODEMP, ');
    qryAux.SQL.Add( '     :CODCFG, ');
    qryAux.SQL.Add( '     :CDCFAB, ');
    qryAux.SQL.Add( '     :UTIBLC, ');
    qryAux.SQL.Add( '     :PRIORI, ');
    qryAux.SQL.Add( '     :DESCRI, ');
    qryAux.SQL.Add( '     :REGNEG, ');
    qryAux.SQL.Add( '     :VALCFG, ');
    qryAux.SQL.Add( '     :GRUCFG, ');
    qryAux.SQL.Add( '     :NUMHLP, ');
    qryAux.SQL.Add( '     :ULTALT, ');
    qryAux.SQL.Add( '     :CODGEN, ');
    qryAux.SQL.Add( '     :LAYOUT ');
    qryAux.SQL.Add( '   ) ');

    qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAux.ParamByName('CODCFG').AsString  := strCodCfg;
    qryAux.ParamByName('CDCFAB').AsString  := strCdCfAb;
    qryAux.ParamByName('UTIBLC').AsString  := strUtiBlc;
    qryAux.ParamByName('PRIORI').AsString  := strPriori;
    qryAux.ParamByName('DESCRI').AsString  := strDescri;
    qryAux.ParamByName('REGNEG').AsString  := strRegNeg;
    qryAux.ParamByName('VALCFG').AsString  := strValCfg;
    qryAux.ParamByName('GRUCFG').AsString  := strGruCfg;
    qryAux.ParamByName('NUMHLP').AsInteger := intNumHlp;
    qryAux.ParamByName('ULTALT').AsDate    := dtaUltAlt;
    qryAux.ParamByName('CODGEN').AsString  := strHraUltAlt;
    qryAux.ParamByName('LAYOUT').AsString  := strLayout;
    qryAux.ExecSQL;
  end;

end;

procedure TfrmCfgSpedFiscal.pSetComboFiltroValor(cmbCombo: TComboBox; strValor: String);
var
  intContador: Integer;
  strCodigo: String;
begin
  cmbCombo.ItemIndex := -1;

  for intContador := 0 to cmbCombo.Items.Count - 1 do
  begin
    strCodigo := SplitString(cmbCombo.Items[intContador], ' ')[0];
    if strCodigo = strValor then
    begin
      cmbCombo.ItemIndex := intContador;
      Exit;
    end;
  end;
end;

function TfrmCfgSpedFiscal.pGetComboFiltroValor(cmbCombo: TComboBox): String;
begin
  if (cmbCombo.ItemIndex <> -1) and (cmbCombo.Items[cmbCombo.ItemIndex] <> '') then
    Result := SplitString(cmbCombo.Items[cmbCombo.ItemIndex], ' ')[0]
  else
    Result := '';
end;

end.
