{***************************}
{* qryConCid -> CADCID     *}
{************************JB*}
{***************************}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadTransportadoras;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, DB, Menus, EditFocus, Uni, AppEvnts, UniClientDataSet,
  Grids, DBGridCitel, DBGrids, untTraCtt, Contnrs, Windows, untMskTelefone, untDBECgcCpf,
  untDBETipoCgcCpf, untLabelCgcCpf, BitBtnLockedIncrem, MaskEditFocus, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, DBMemoFocus, untZClient,
  QColorLabel, untTypesSistema, ComboBoxFocus, untFramePlanoDeContasMaskEdit,
  System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, untLiberacaoFactory,
  untILiberacao, Vcl.CheckLst, Faturamento.Classes.TiposDeRateioFrete,
  Faturamento.Classes.TiposFretesPermitidosTransp;

type
  TfrmCadTransportadoras = class(TfrmPaiCad)
    tbsContatos: TTabSheet;
    dbgContatos: TDBGridCitel;
    pnlContatos: TPanel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtNomCtt: TEditFocus;
    edtEndCtt: TEditFocus;
    edtBaiCtt: TEditFocus;
    edtDesCidCtt: TEditFocus;
    edtCidCtt: TEditFocus;
    edtEstadoCtt: TEditFocus;
    edtEmaCtt: TEditFocus;
    cdsTraCtt: TUniClientDataSet;
    cdsTraCttNOMCTT: TStringField;
    cdsTraCttENDCTT: TStringField;
    cdsTraCttBAICTT: TStringField;
    cdsTraCttNOMCID: TStringField;
    cdsTraCttESTCID: TStringField;
    cdsTraCttTELCTT: TStringField;
    cdsTraCttEMACTT: TStringField;
    cdsTraCttCODCID: TStringField;
    dtsTraCtt: TDataSource;
    Label36: TLabel;
    edtDepCtt: TEditFocus;
    Label34: TLabel;
    Label35: TLabel;
    cdsTraCttCELCTT: TStringField;
    cdsTraCttFAXCTT: TStringField;
    cdsTraCttDEPCTT: TStringField;
    dtsCadTra: TDataSource;
    mskTelCtt: TMaskEditTelefone;
    mskCelCtt: TMaskEditTelefone;
    mskFaxCtt: TMaskEditTelefone;
    btnAdicionarCtt: TBitBtnLocked;
    btnCancelaCtt: TBitBtnLocked;
    tbsExportacao: TTabSheet;
    pnlEtqDados: TPanel;
    grbObjetos: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    dbeSeqIni: TDBEditFocus;
    dbeSeqFin: TDBEditFocus;
    dbeSeqAtu: TDBEditFocus;
    dbeSiglaS: TDBEditFocus;
    dbeSiglaP: TDBEditFocus;
    grbImpressao: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    edtDesLay: TEditFocus;
    dbeLayEtq: TDBEditFocus;
    edtDtaLay: TEditFocus;
    pnlEtqTipo: TPanel;
    drgTipEtq: TDBRadioGroup;
    pnlSerCor: TPanel;
    dbgCorTra: TDBGridCitel;
    btnCarregarServicoCorreio: TBitBtnLocked;
    btnRemoverServicoCorreio: TBitBtnLocked;
    btnCadClientes: TBitBtnLocked;
    btnCadFor: TBitBtnLocked;
    tsMandae: TTabSheet;
    Label39: TLabel;
    edtUtilizaIntegracaoMandae: TDBEditFocus;
    ColorLabel1: TColorLabel;
    GroupBox1: TGroupBox;
    Label40: TLabel;
    edtNomeLayoutImpressaoMandae: TEditFocus;
    edtLayoutImpressaoMandae: TDBEditFocus;
    edtTipoDeEntregaMandae: TDBEditFocus;
    Label42: TLabel;
    ColorLabel2: TColorLabel;
    Label41: TLabel;
    edtDataHoraUltimaAtualizacaoMandae: TDBEditFocus;
    tsConFreteEletr: TTabSheet;
    lblTranspHabilitadaFE: TLabel;
    ColorLabel3: TColorLabel;
    Label148: TLabel;
    dbeTranspHabFE: TDBEditFocus;
    edtDesEmpRespConh: TEditFocus;
    dbeCodEmpRespConh: TDBEditFocus;
    gpbPadraoCTe: TGroupBox;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    edtCFOP: TEditFocus;
    edtNaturezaOp: TEditFocus;
    edtSerie: TEditFocus;
    cmbTomadorServ: TComboBoxFocus;
    cmbCodigoClassTrib: TComboBoxFocus;
    edtProdutoPredom: TEditFocus;
    edtDescricaoServ: TEditFocus;
    edtRNTRC: TEditFocus;
    gpbFinanceiro: TGroupBox;
    Label53: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    mskConPagPagar: TMaskEditFocus;
    mskConPagReceber: TMaskEditFocus;
    lblAliquota: TLabel;
    edtAliquota: TEditFocus;
    Label53x: TLabel;
    edtCFOPJU: TEditFocus;
    fraPlanoDeContasPga: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasRec: TfraPlanoDeContasMskEdit;
    ImageSefaz: TcxImageList;
    tbsIntelipost: TTabSheet;
    lblUtilizaIntelipost: TLabel;
    dbeUtiItelipost: TDBEditFocus;
    lblSimNaoIntelipost: TColorLabel;
    lblCodTranspIntelipost: TLabel;
    dbeCodTranspIntelipost: TDBEditFocus;
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label47: TLabel;
    Label19: TLabel;
    LabelCgcCpf1: TLabelCgcCpf;
    Label9: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    lblFrete: TLabel;
    Label54: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    dbeCodTra: TDBEditFocus;
    dbeDtaCad: TDBEditFocus;
    dbeNomTra: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeNumIes: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeNumPla: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeHomPag: TDBEditFocus;
    dbeNomFan: TDBEditFocus;
    dbeValFre: TDBEditFocus;
    Panel1: TPanel;
    dbeCgcCpf: TDBEditTipoCgcCpf;
    dbeNumCgc: TDBEditCgcCpf;
    btnConsultaFit: TBitBtnLocked;
    dbePriExp: TDBEditFocus;
    dbeC_ANTT: TDBEditFocus;
    dbeObserv: TDBMemoFocus;
    dbeCodFrg: TDBEditFocus;
    edtDesFrg: TEditFocus;
    dbchekTRA_ATIVA_: TDBCheckBox;
    pnlFrenet: TPanel;
    pnlEscCre: TPanel;
    cbbEtiquetaDespacho: TComboBoxFocus;
    edtEstado: TEditFocus;
    edtCidade: TEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    pnlDataFrete: TPanel;
    dbcheckVeiEst: TDBCheckBox;
    tsComplemento: TTabSheet;
    rdgFreVen: TDBRadioGroup;
    cklOpcoesRateioFrete: TCheckListBox;
    lblTipoFretePermitido: TLabel;
    cklTipoFretePermitido: TCheckListBox;
    Label48: TLabel;
    dbeEscCre: TDBEditCgcCpf;
    pnlComplementos1: TPanel;
    pnlRealizaColetaB2W: TPanel;
    lblRealizaColetaB2WEnt: TLabel;
    ColorLabel4: TColorLabel;
    dbTRA_B2WENT: TDBEditFocus;
    pnlIntegracaoFusion: TPanel;
    lblIntFus: TLabel;
    corIntFus: TColorLabel;
    dbeIntFus: TDBEditFocus;
    pnlExportaParaB2B: TPanel;
    lblExpB2B: TLabel;
    corExpB2B: TColorLabel;
    dbeExpB2B: TDBEditFocus;
    pnlObrigatorioInformarRota: TPanel;
    lblObrigatorioInformarRota: TLabel;
    clbObrigatorioInformarRota: TColorLabel;
    dbOBGROT: TDBEditFocus;
    pnlComplementos2: TPanel;
    pnlUtilizaBox: TPanel;
    lblUtilizaBox: TLabel;
    lblUtilizaBoxSN: TColorLabel;
    dbeUtilizaBox: TDBEditFocus;
    pnlControlaCanhoto: TPanel;
    lbl15: TLabel;
    ColorLabel28: TColorLabel;
    dbeControlaCanhoto: TDBEditFocus;
    pnlIMPDES: TPanel;
    lblIMPDES: TLabel;
    corIMPDES: TColorLabel;
    dbeIMPDES: TDBEditFocus;
    grbJaglog: TGroupBox;
    Label61: TLabel;
    lblModJadLog: TLabel;
    edtLayJad: TEditFocus;
    edtCodLayJad: TDBEditFocus;
    cbbModJadLog: TComboBoxFocus;
    grpFrenet: TGroupBox;
    Panel2: TPanel;
    lblDataFrete: TLabel;
    DBECODDTF: TDBEditFocus;
    Panel3: TPanel;
    Label57: TLabel;
    edtFrenet: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function dbeCodCidChamaCadastro(Key: Word): String;
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCgcCpfExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaCttClick(Sender: TObject);
    procedure btnAdicionarCttClick(Sender: TObject);
    procedure dbgContatosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCidCttKeyPress(Sender: TObject; var Key: Char);
    procedure edtCidCttKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgContatosEnter(Sender: TObject);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure rdgFreVenEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure drgTipEtqChange(Sender: TObject);
    procedure dbeSeqIniExit(Sender: TObject);
    procedure dbeLayEtqKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodFrgKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarregarServicoCorreioClick(Sender: TObject);
    procedure btnRemoverServicoCorreioClick(Sender: TObject);
    procedure btnCadClientesClick(Sender: TObject);
    procedure btnCadForClick(Sender: TObject);
    procedure edtLayoutImpressaoMandaeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpRespConhExit(Sender: TObject);
    procedure dbeCodEmpRespConhKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTranspHabFEExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasPgaMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasRecMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure cbbEtiquetaDespachoChange(Sender: TObject);
    procedure edtCodLayJadKeyPress(Sender: TObject; var Key: Char);
    procedure btnConsultaFitClick(Sender: TObject);
    procedure dbeNumCgcChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rdgFreVenClick(Sender: TObject);
    procedure cklOpcoesRateioFreteClickCheck(Sender: TObject);
    procedure cklTipoFretePermitidoClick(Sender: TObject);
  private
    { Private declarations }
    objTiposDeRateioFreteDAO : TTiposDeRateioFreteDAO;
    objTiposDeFretePermitidosDAO : TTiposDeFretePermitidosDAO;
    objTraCtt: TTraCtt;
    lstContatos: TObjectList;
    blnAltContato: Boolean;

    qryConCtt: TUniQuery;
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;
    cdsCorTra: TZClient;

    strCepAnt: String;

    strUtilizaMandaeAnterior,
    strTipoEntregaMandaeAnterior,
    strLayoutMandaeAnterior : String;

    intSeqIni: Integer;
    intSeqFin: Integer;
    blnTemDivergenciaSefaz: Boolean;

    objLiberacao : ILiberacao;
    blnJaValidouTravaCnpjCpf : Boolean;

    procedure pCarregaCidade(blnAtuCep: Boolean = True);
    procedure pCarregaFaixaFrete;
    procedure pLimpaEdits;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pFormataCampos;

    {*************************}
    { ABA - CONTATO           }
    {**********************JB*}
    procedure pCarregaContatos(strCodTra: String);
    procedure pAdicionaContatoCds(objContato: TTraCtt);
    procedure pCarregaContatoAlteracao;
    procedure pAtualizaEditsContato(DataSet: TDataSet);
    procedure pLimpaEditsContatos;
    procedure pCarregaCidadeCtt;
    procedure pCarregaSequenciaAtual;
    procedure pCarregaLayout(AedtCodigo : TDBEditFocus; AedtDescricao : TEditFocus);
    function fGetSQLCorTra: String;
    procedure pAbreCorTra;
    function fGravaCorTra: Boolean;
    function fInformaAtividade: string;
    procedure pCarregaPadraoCTe;
    function fValidaCondPagamento(var mskCndPag: TMaskEditFocus; blnBuscaPorChave: Boolean): Boolean;

    procedure pPesquisa(strCodTransportadora: String = '');
    function fSetaTransportadoraInformada(strCodTransportadora: String = ''): Boolean;
    procedure pAlteraEtiquetaDespacho;

    function fValidaExisteCpfCnpj: Boolean;
    procedure pCarregaOpcoesTiposDeFreteDoRateio;
    procedure pMarcarOpcaoTodosTiposdeFreteDoRateio;
    procedure pBloquearOpcaoTodosOsTiposDeFreteDoRateio;
    procedure pOnChechUncheckOpcoesRateioFrete;
    procedure pSetarStatusListaOpcoesRateioFrete;
    procedure pLiberarTodasOpcoesTiposDeFreteDoRateio;
    procedure pCarregarDadosTiposDeFreteDoRateio(const strCodTra : String; const strFreVen : String);
    procedure pGravarDadosTiposDeFreteDoRateio(const strCodTra : String);
    function fValidouPreenchimentoOpcoesRateio(const strFreVen : String): Boolean;
    procedure pAjustaTelaUtilizaCampoInformarRotaObr;
    procedure pAjustaTipoFretePermitido;
    procedure pAjustaDefaultTipoFretePermitido(ABloqueiaTodos: Boolean);
    procedure pObrigarPreenchimentoTipoFretePermitido;
    function fNenhumTipoFretePermitidoSelecionado: Boolean;
    procedure pGravarDadosTiposDeFretePermitido(const ACodTra : String);
    procedure pCarregarDadosTiposDeFretePermitido(const ACodTra : String);
    procedure pCarregaOpcoesTiposDeFrete;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange;override;

  public
    { Public declarations }
    fCadastroRapidoCliente: TfCadastroRapidoCliente;
    fCadastroRapidoFornecedor: TfCadastroRapidoFornecedor;
    strCodTransportadoraIniciarCadastro: String;
    Class function fCadastroRapidoTransportadora(var strCodTra: string;
                                                 strNomTra,
                                                 strNomFan,
                                                 strEndere,
                                                 strBairro,
                                                 strCodCid,
                                                 strNumCep,
                                                 strFone01,
                                                 strEmail,
                                                 strNumCgc,
                                                 strFone02,
                                                 strInsEst,
                                                 strHomPag: string;
                                                 intCgcCpf: integer):Boolean;
  end;

const
  MODALIDADE_JADLOG: array[0..9] of Integer = (0, 3, 4, 5, 6, 7, 9, 10, 12, 14);

implementation

uses SysUtils, Variants, StrUtils, untFuncoesGenerica, untFuncoesSimples,
     untPai, untFuncIns2, untPesqAux, untCadCidades, untCadCid, untConstantes,
     System.Types, untConsultas, untAtividades, untIConsultaCadastroFit,
     untUnidac, System.Generics.Collections, untTipoFreteAtc;

{$R *.dfm}

procedure TfrmCadTransportadoras.FormCreate(Sender: TObject);
begin
  inherited;
  objTiposDeRateioFreteDAO := TTiposDeRateioFreteDAO.Create(TUnidacConnection.Create);
  objTiposDeFretePermitidosDAO := TTiposDeFretePermitidosDAO.Create(TUnidacConnection.Create);
  strCodTransportadoraIniciarCadastro := '';
  strNomeTabela         := 'CADTRA';
  strNomeCampo          := 'TRA_CODTRA';
  qryTabela             := fCriarQuery('SELECT * FROM CADTRA', Self);
  qryTabela.AfterScroll := pAfterScroll;
  qryTabela.AfterOpen   := pAfterOpen;
  dtsCadTra.DataSet     := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodTra;

  objTraCtt := TTraCtt.Create;
  blnAltContato := False;

  dbgContatos.ReadOnly := True;
  pnlContatos.Enabled  := False;

  cdsTraCtt.CreateDataSet;
  cdsTraCtt.AfterScroll := pAtualizaEditsContato;
  pgcDados.ActivePageIndex := 0;

  strCepAnt := '';

  cdsCorTra := TZClient.Create(Self, fGetSQLCorTra);
  dbgCorTra.DataSource := cdsCorTra.dtsSource;

  pCarregaSequenciaAtual;

  If fCfgSis('USIGEP', varString) = 'A' Then
  Begin
    pnlSerCor.Visible    := True;

    pnlEtqDados.Visible  := False;
    pnlEtqTipo.Visible   := False;

    tbsExportacao.TabVisible := True;
  End
  Else
  If fCfgSis('USIGEP', varString) = 'O' Then
  Begin
    pnlSerCor.Visible    := False;

    pnlEtqDados.Visible  := True;
    pnlEtqTipo.Visible   := True;

    tbsExportacao.TabVisible := True;
  End;

  tsConFreteEletr.TabVisible := (fCfgSis('UTICTE', varString) = 'S');

  lblFrete.Visible := (fCfgSis('FRETRA', varString) = FRETRA_POR_FAIXA_FATURAMENTO);
  dbeCodFrg.Visible := lblFrete.Visible;
  edtDesFrg.Visible := lblFrete.Visible;

  fCadastroRapidoCliente := Nil;
  fCadastroRapidoFornecedor := Nil;


  if (tsMandae.TabVisible) and not(tbsExportacao.TabVisible) then
    tsMandae.Caption := '&3 - Etiqueta Despacho - Mandaê';

  If FileExists(ExtractFilePath(Application.ExeName) + 'libPluginHubCitel.dll') Then
  Begin
    cbbEtiquetaDespacho.Items.Add('MERCADO LIVRE');
    cbbEtiquetaDespacho.Items.Add('MAGALU');
    cbbEtiquetaDespacho.Items.Add('SHOPEE');
    cbbEtiquetaDespacho.Items.Add('VIA VAREJO');
    cbbEtiquetaDespacho.Items.Add('OLIST');
    cbbEtiquetaDespacho.Items.Add('AMAZON');
    cbbEtiquetaDespacho.Items.Add('TIKTOK');
  End;

  If (fCfgSis('USALAL', varString) = 'S') Then
    cbbEtiquetaDespacho.Items.Add('LALAMOVE');

  strUtilizaMandaeAnterior     := '';
  strTipoEntregaMandaeAnterior := '';
  strLayoutMandaeAnterior      := '';
  blnTemDivergenciaSefaz := False;

  pAjustaTelaUtilizaCampoInformarRotaObr;

  pnlUtilizaBox.Visible   := fCfgSis('USABEI', varBoolean);
  pnlRealizaColetaB2W.Visible := fCfgSis('B2WIMP', varBoolean);

  dbeIMPDES.Visible := fCfgSis('IDCTRA', VarBoolean);
  lblIMPDES.Visible := fCfgSis('IDCTRA', VarBoolean);
  corIMPDES.Visible := fCfgSis('IDCTRA', VarBoolean);

  pnlIntegracaoFusion.Visible := fCfgSis('FUSUSA', varBoolean);

  tbsIntelipost.TabVisible := fCfgSis('ITPUTI', varBoolean);

  cklTipoFretePermitido.Visible := fCfgSis('TRPPRM', varBoolean);
  lblTipoFretePermitido.Visible := cklTipoFretePermitido.Visible;

  pAjustaDefaultTipoFretePermitido(True);
end;

procedure TfrmCadTransportadoras.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objTiposDeRateioFreteDAO);
  FreeAndNil(objTiposDeFretePermitidosDAO);

  inherited;
end;

procedure TfrmCadTransportadoras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnCadClientes.Click;

  If (Key = VK_F3) Then
    btnCadFor.Click;

  If (Key = VK_RETURN) And Assigned(ActiveControl) And (ActiveControl Is TRadioButton) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadTransportadoras.pFormataCampos;
Begin
  With qryTabela Do
  Begin
    TFloatField(FieldByName('TRA_VALFRE')).DisplayFormat := '#,##0.00';
  End;
End;

procedure TfrmCadTransportadoras.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If Active Then
    Begin

      If FindField('TRA_C_E_P_') <> nil Then
        TStringField(FieldByName('TRA_C_E_P_')).EditMask := '99999-999;0;_';

      If FindField('TRA_FONE01') <> nil Then
        TStringField(FieldByName('TRA_FONE01')).EditMask := fRetMascaraFonePais;

      If FindField('TRA_FONE02') <> nil Then
        TStringField(FieldByName('TRA_FONE02')).EditMask := fRetMascaraFonePais;

      If FindField('TRA_F_A_X_') <> nil Then
        TStringField(FieldByName('TRA_F_A_X_')).EditMask := fRetMascaraFonePais;

    End;
  End;
end;

procedure TfrmCadTransportadoras.pAfterScroll(DataSet: TDataSet);
Begin
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('TRA_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);;

  If (dbeCgcCpf.Text = '2') Then
    qryTabela.FieldByName('TRA_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);;

  qryTabela.FieldByName('TRA_ESCCRE').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_);;

End;

procedure TfrmCadTransportadoras.pAjustaDefaultTipoFretePermitido(
  ABloqueiaTodos: Boolean);
Var
  LIntCnt : Integer;
begin
  cklTipoFretePermitido.Enabled := cklTipoFretePermitido.Visible and (((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)));

  For LIntCnt := 0 To Pred(cklTipoFretePermitido.Count) Do
  Begin
    If ABloqueiaTodos Then
    Begin
      cklTipoFretePermitido.Checked[LIntCnt] := IIF(LIntCnt = 0, True, False);
      cklTipoFretePermitido.ItemEnabled[LIntCnt] := IIF(LIntCnt = 0, True, False);
    End
    Else
    Begin
      cklTipoFretePermitido.ItemEnabled[LIntCnt] := True;
    End;
  End;
end;

procedure TfrmCadTransportadoras.pAjustaTelaUtilizaCampoInformarRotaObr;
begin
  pnlObrigatorioInformarRota.Visible := False;

  if (fCfgSis('OBGROT', varString) = '2') and ( fCfgSis('REGCID', varBoolean))then
    pnlObrigatorioInformarRota.Visible := True;
end;

procedure TfrmCadTransportadoras.pAjustaTipoFretePermitido;
Var
  LIndexChecked : Integer;
  LIntCnt : Integer;
begin
  LIndexChecked := -1;
  For LIntCnt := 0 To Pred(cklTipoFretePermitido.Count) Do
  Begin
    If Not cklTipoFretePermitido.Checked[LIntCnt] Then
      Continue;

    LIndexChecked := LIntCnt;
    Break;
  End;

  Case LIndexChecked Of
    -1: Begin
          pAjustaDefaultTipoFretePermitido(False);
          pObrigarPreenchimentoTipoFretePermitido;
        End;
     0: pAjustaDefaultTipoFretePermitido(True);
     1,2,3,4,5,6: pAjustaDefaultTipoFretePermitido(False);
  End;
end;

procedure TfrmCadTransportadoras.pAlteraEtiquetaDespacho;
begin
  tbsExportacao.TabVisible := False;
  tsMandae.TabVisible := False;
  lblModJadLog.Visible := False;
  cbbModJadLog.Visible := False;
  grbJaglog.Visible := False;

  case cbbEtiquetaDespacho.ItemIndex of
    1: if fCfgSis('USIGEP', varString) = 'N' then
       begin
         fMensagem('ATENÇÃO!', 'Para utilizar esta opção é preciso ativar a configuração "CFG_USIGEP - Utilizar rotina de etiqueta do correios (SIGEP-WEB), para impressão da etiqueta de despacho?', ['&Ok']);
         cbbEtiquetaDespacho.ItemIndex := 0;
         Exit;
       end
       else
       begin
         tbsExportacao.TabVisible := True;
       end;

    2: if not fCfgSis('MANUSA', varBoolean) then
       begin
         fMensagem('ATENÇÃO!', 'Para utilizar esta opção é preciso ativar a configuração "CFG_MANUSA - Utilizar integração Mandaê?', ['&Ok']);
         cbbEtiquetaDespacho.ItemIndex := 0;
         Exit;
       end
       else
       begin
         tsMandae.TabVisible := True;
       end;

    3: if not fCfgSis('B2WIMP', varBoolean) then
       begin
         fMensagem('ATENÇÃO!', 'Para utilizar esta opção é preciso ativar a configuração "CFG_B2WIMP - Utilizar rotina de impressão de etiqueta de despacho e coleta da B2W Entrega?', ['&Ok']);
         cbbEtiquetaDespacho.ItemIndex := 0;
         Exit;
       end;

    4: if not fCfgSis('USAJAD', varBoolean) then
       begin
         fMensagem('ATENÇÃO!', 'Para utilizar esta opção é preciso ativar a configuração "CFG_USAJAD - Utilizar rotina de impressão de etiqueta de despacho e envio de PLP da Jadlog?', ['&Ok']);
         cbbEtiquetaDespacho.ItemIndex := 0;
         cbbModJadLog.ItemIndex := 0;
         Exit;
       end
       else
       begin
         lblModJadLog.Visible := True;
         cbbModJadLog.Visible := True;
         grbJaglog.Visible := True;
       end;
  end;
end;

function TfrmCadTransportadoras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strEstado: String;
    strCodCid: String;
    strEndere: String;
    strBairro: String;
    strNomCid: String;
    blnAtualizar: Boolean;

    LCodigoCorreio: String;
begin
  blnAtualizar := False;
  Result := True;

  Try

    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin
      {*****************************************}
      {* VALIDA O CÓDIGO DA TRANSPORTADORA     *}
      {**************************************MV*}
      If ((Sender = dbeCodTra)) And (dbeCodTra.Enabled) Then
      Begin
        If fEmptyStr(dbeCodTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código da Transportadora deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin
            pLimparCampos;
            dbeDtaCad.Field.AsDateTime := VS_Date;
          End
          Else
          Begin
            pCarregaCidade;
            strCepAnt := qryTabela.FieldByName('TRA_C_E_P_').AsString;

            btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');
          End;
        End;
      End

      Else If (Sender = dbeCgcCpf) Then
      Begin
        btnConsultaFit.Visible := (dbeCgcCpf.Text = '1');

        If (dbeCgcCpf.Enabled) Then
        Begin
          if (not fEmptyStr(dbeCgcCpf.Text)) then
          begin
            if (dbeCgcCpf.Text <> '1') And (dbeCgcCpf.Text <> '2') then
              Result := False;
          end
          else if (not fEmptyStr(dbeNumCgc.Text)) then
            Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O NOME DA TRANSPORTADORA       *}
      {**************************************MV*}
      Else If (Sender = dbeNomTra) Then
      Begin
        If fEmptyStr(dbeNomTra.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Nome da Transportadora deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End

      {*******************************}
      {* VALIDA ENDERECO             *}
      {****************************JC*}
      Else if (Sender = dbeEndere) Then
      Begin
        If fEmptyStr(dbeEndere.Text) Then
        Begin
          fMensagem('', 'Infome o endereço da transportadora !', ['&Ok']);
          Result := False;
        End
      End

      {*****************************************}
      {* VALIDA O CODIGO DA CIDADE             *}
      {**************************************MV*}
      Else if (Sender = dbeCodCid) Then
      Begin
        If Not fEmptyStr(dbeCodCid.Text) Then
        Begin
          pCarregaCidade;
          If qryConCid.FieldByName('CID_CODCID').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('', 'Digite o código da cidade !', ['&Ok']);
          Result := False;
        End;
      End

      Else if (Sender = cbbModJadLog) Then
      Begin
        If (cbbEtiquetaDespacho.Text = 'JADLOG') And (cbbModJadLog.Visible) And (fEmptyStr(cbbModJadLog.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'É obrigatório o preenchimento da Modalidade Jadlog para utilizar a integração com esta transportadora!', ['&Ok']);
          Result := False;
        End;
      End

      Else if (Sender = dbeCodEmpRespConh) and (dbeCodEmpRespConh.Enabled) and (tsConFreteEletr.TabVisible) Then
      Begin
        If Not fEmptyStr(dbeCodEmpRespConh.Text) Then
        Begin
          If qryTabela.FieldByName('TRA_EMPRES').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('', 'Digite o código da empresa !', ['&Ok']);
          Result := False;
        End;
      End

      {**************************}
      {* VALIDA CEP             *}
      {***********************JC*}
      Else if (Sender = dbeNumCep) Then
      Begin

        dbeNumCep.Text := fTiraCaracEspeciais(dbeNumCep.Text);

        If fEmptyStr(dbeNumCep.Text) Then
        Begin
          fMensagem('', 'Infome o CEP da cidade!', ['&Ok']);
          Result := False;
        End
        Else If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve conter 8 digitos.', ['&Ok']);
          Result := False;
        End;

        If (Result) And (fCfgSis('USACEP', varBoolean)) Then
        Begin

          If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio)) Then
                                                  //qryConCid.FieldByName('CID_ESTADO').AsString,
                                                  //qryConCid.FieldByName('CID_CODCOR').AsString)) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fVerificaAcessoSistema('frmCadCidades') Then
              Begin
                fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, edtCidade.Text), ['&Ok']);

                Result := False;

              End

              Else

              If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtCidade.Text + ' está em branco.' + #13#10 +
                             'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                Begin
                  pAtualizaCodigoCorreios(dbeCodCid.Text, dbeNumCep.Text);
                End

                Else Result := False;

              End Else

              Begin
                fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                      'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
                pCriarForm(TfrmCadCidades);

                Result := False;
              End;
            End;

            If (Result) Then
            Begin

              blnAtualizar := False;
              If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
              Begin
                If fTiraCaracEspeciais(strCepAnt) = '' Then
                Begin
                  blnAtualizar := True;
                End
                Else
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizar := True;
                End

              End;

              If fEmptyStr(dbeCodCid.Text) Or ((blnAtualizar) And (Not fEmptyStr(strCodCid))) Then
              Begin
                dbeCodCid.Field.AsString := strCodCid;
                pCarregaCidade(False);
              End;

              If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
              Begin
                //Modificado para quando a rua for a mesma então não faz a troca, isso estava apagando o número do endereço.
                If Not dbeEndere.Field.AsString.Contains(fTiraCaracEspeciais(strEndere)) then
                  dbeEndere.Field.AsString := strEndere;
              End;

              If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
              Begin
                //Modificado para a alteração do sefaz não ser sobreposta com a consulta de cpf no caso de ter acento na palavra.
                If Not dbeBairro.Field.AsString.Equals(fTiraCaracEspeciais(strBairro)) then
                  dbeBairro.Field.AsString := strBairro;
              End;

              {***********************************}
              {* CASO O CEP NÃO POSSUIR ENDERECO *}
              {********************************JB*}
              If (Not fEmptyStr(strNomCid)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
              Begin
                dbeEndere.Field.AsString := fTiraCaracEspeciais(strNomCid);
                strEndere                := dbeEndere.Field.AsString;
              End;

              If (strCodCid <> dbeCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
              Begin
                Result := False;
                pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCodCid.Text) + '!');
              End;

            End;

          End;

          If (Result) Then
          Begin
            strCepAnt := dbeNumCep.Text;
            If blnAtualizar Then
            Begin
              pSetFocus(dbeEndere);
              blnMudarFoco := False;
            End;
          End;


        End;

      End

      {*****************************}
      {* VALIDA BAIRRO             *}
      {**************************JC*}
      Else if (Sender = dbeBairro) Then
      Begin
        If fEmptyStr(dbeBairro.Text) Then
        Begin
          fMensagem('', 'Infome o bairro da transportadora !', ['&Ok']);
          Result := False;
        End
      End

      {*****************************************}
      {* VALIDA O CGC / CPF                    *}
      {**************************************MV*}
      Else If (Sender = dbeNumCgc) Then
      Begin
        If Not fEmptyStr(dbeNumCgc.Text) Then
        Begin
          If dbeCgcCpf.Text = '1' Then
          Begin
            If (Not fTestaCgc(dbeNumCgc.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', dbeNumCgc.Text + ' não é um CNPJ válido!', ['&Ok']);
              Result := False
            End;
          End
          Else
          Begin
            If (Not fValidaCPF(dbeNumCgc.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', dbeNumCgc.Text + ' não é um CPF válido!', ['&Ok']);
              Result := False
            End;
          End;

          if Result then
          begin
            if (fCfgSis('TRPCCD', varString) <> 'N') then
              Result := fValidaExisteCpfCnpj;
          end;
        End;
      End

      {*****************************************}
      {* VALIDA INSCRIÇÃO ESTADUAL             *}
      {**************************************MV*}
      Else If (Sender = dbeNumIes) Then
      Begin
        If (Not fEmptyStr(dbeNumIes.Text)) And (Not qryConCid.IsEmpty) Then
        Begin
          dbeNumIes.Text := AnsiReplaceStr(dbeNumIes.Text, ',', '.');
          If Not fValidaIES(dbeNumIes.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
          Begin
            fMensagem('ATENÇÃO!', dbeNumIes.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
            Begin
              dbeNumIes.Text := fRetornaZerosNumIes(dbeNumIes.Text) + dbeNumIes.Text;
            End;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA O E-MAIL                       *}
      {**************************************MV*}
      Else If (Sender = dbeEmail) Then
      Begin
        If Not fEmptyStr(dbeEmail.Text) Then
        Begin
          If Pos('@', dbeEmail.Text) = 0 Then
          Begin
            fMensagem('ATENÇÃO!', dbeEmail.Text + ' não é um e-mail válido!', ['&Ok']);
            Result := False;
          End;
        End;
      End

      {***********************************}
      { VALIDA CONTATOS                   }
      {********************************JB*}
      Else If (Sender = edtNomCtt) And (blnBuscaPorChave) Then
      Begin
        If Not fEmptyStr(edtNomCtt.Text) Then
          objTraCtt.strNomCtt := edtNomCtt.Text
        Else
        Begin
          blnMudarFoco := False;
          pSetFocus(btnGravar);
        End;
      End

      Else If (sender = dbeTranspHabFE) Then
      Begin
        If (Pos(dbeTranspHabFE.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Transportadora Habilitada para Emissão de Conhecimento de Frete Eletrônico?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O CODIGO DO FRETE              *}
      {**************************************MV*}
      Else if (Sender = dbeCodFrg) Then
      Begin
        If Not fEmptyStr(dbeCodFrg.Text) Then
        Begin
          pCarregaFaixaFrete;
          If fEmptyStr(edtDesFrg.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Faixa de Frete não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End

      End

      {***********************************}
      { VALIDA TELEFONES                  }
      {********************************MM*}
      Else If (Sender = dbeFone01) Or (Sender = dbeFone02) Or (Sender = dbeNumFax) Then
      Begin
        If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
           (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
        Begin
          fMensagem('','Informe o telefone corretamente!', ['&Ok']);
          Result := False;
        End
        Else
          TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
      End

      Else If (Sender = edtEndCtt) And (blnBuscaPorChave) Then
      Begin
        objTraCtt.strEndCtt := edtEndCtt.Text;
      End

      Else If (Sender = edtBaiCtt) And (blnBuscaPorChave) Then
      Begin
        objTraCtt.strBaiCtt := edtBaiCtt.Text;
      End

      Else If (Sender = edtCidCtt) And (blnBuscaPorChave) Then
      Begin
        objTraCtt.strCidCtt := edtCidCtt.Text;
        edtDesCidCtt.Text := objTraCtt.strNomCid;
        edtEstadoCtt.Text := objTraCtt.strEstado;
      End

      Else If ((Sender = mskTelCtt) Or (Sender = mskCelCtt) Or
              (Sender = mskFaxCtt)) And (blnBuscaPorChave) Then
      Begin

        If (Not fEmptyStr(TMaskEditTelefone(Sender).Text)) And
           (Not fValidaTelefone(TMaskEditTelefone(Sender).Text)) Then
        Begin
          fMensagem('','Informe o telefone corretamente!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          TMaskEditTelefone(Sender).Text := fAcertaMaskTel(TMaskEditTelefone(Sender).Text);

          If (Sender = mskTelCtt) Then
            objTraCtt.strTelCtt := mskTelCtt.Text
          Else If (Sender = mskCelCtt) Then
            objTraCtt.strCelCtt := mskCelCtt.Text
          Else If (Sender = mskFaxCtt) Then
            objTraCtt.strFaxCtt := mskFaxCtt.Text;
        End;

      End

      Else If (Sender = edtDepCtt) And (blnBuscaPorChave) Then
      Begin
        objTraCtt.strDepCtt := edtDepCtt.Text;
      End

      Else If (Sender = edtEmaCtt) And (blnBuscaPorChave) Then
      Begin
        objTraCtt.strEmaCtt := edtEmaCtt.Text;
      End

      Else if (Sender = dbeValFre) Then
      Begin

        If fStrToFloat(dbeValFre.Text) < 0 Then
        Begin
          fMensagem('', 'O valor do frete deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End

      End

      Else If (sender = dbeControlaCanhoto) Then
      Begin
        If (Pos(dbeControlaCanhoto.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Controlar canhoto de notas emitidas?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (sender = dbeUtilizaBox) Then
      Begin
        If (Pos(dbeUtilizaBox.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Entra no controle de Box de Entrega ENTREGA IMEDIATA?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbePriExp) Then
      Begin
        If StrToIntDef(dbePriExp.Text, -1) < 0 Then
        Begin
          fMensagem('', 'O valor da prioridade para expedição deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeSeqIni) And (pnlEtqDados.Visible) and (tbsExportacao.TabVisible) Then
      Begin
        Result := StrToIntDef(dbeSeqIni.Text, -1) >= 1;
        If Not Result Then
        Begin
          fMensagem('', 'O valor Inicial deve ser preenchido e não pode ser menor que 1!', ['&OK']);
        End;

      End

      Else If (Sender = dbeSeqFin) And (pnlEtqDados.Visible) and (tbsExportacao.TabVisible) Then
      Begin
        Result := StrToIntDef(dbeSeqIni.Text, -1) < StrToIntDef(dbeSeqFin.Text, -2);
        If Not Result Then
          fMensagem('', 'O valor Final deve ser preenchido e não pode ser menor ou igual que o Inicial!', ['&OK'])
        Else
          intSeqFin := StrToIntDef(dbeSeqFin.Text, 0);

      End

      Else If (Sender = dbeSiglaS) And (pnlEtqDados.Visible) and (tbsExportacao.TabVisible) Then
      Begin
        If fEmptyStr(dbeSiglaS.Text) Then
          Result := fMensagem('', 'Preencha a sigla do Serviço!', ['&OK'])= -1;
      End

      Else If (Sender = dbeSiglaP) And (pnlEtqDados.Visible) and (tbsExportacao.TabVisible) Then
      Begin
        If fEmptyStr(dbeSiglaP.Text) Then
          Result := fMensagem('', 'Preencha a sigla do País!', ['&OK'])= -1;
      End

      Else If (Sender = dbeLayEtq) And (pnlEtqDados.Visible) and (tbsExportacao.TabVisible) Then
      Begin
        If fEmptyStr(dbeLayEtq.Text) Then
        Begin
          edtDesLay.Clear;
          edtDtaLay.Clear;
        End
        Else
        Begin
          pCarregaLayout(dbeLayEtq, edtDesLay);
        End;
      End

      Else If (Sender = edtUtilizaIntegracaoMandae) And (tsMandae.TabVisible) Then
      Begin
        If not fEmptyStr(edtUtilizaIntegracaoMandae.text) and (Pos(edtUtilizaIntegracaoMandae.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Transportadora Utiliza Integração com Mandaê?" corretamente!', ['&Ok']);
          Result := False;
        End;

        if (Result) and (strUtilizaMandaeAnterior <> edtUtilizaIntegracaoMandae.Text) then     
        begin
          strUtilizaMandaeAnterior := edtUtilizaIntegracaoMandae.Text; 
          qryTabela.FieldByName('TRA_MANATU').AsDateTime := fNow();
        end;        
      End

      Else If (Sender = edtTipoDeEntregaMandae) And (tsMandae.TabVisible) Then
      Begin
        If not fEmptyStr(edtTipoDeEntregaMandae.text) and (Pos(edtTipoDeEntregaMandae.Text, 'RE') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Tipo de Entrega" corretamente!', ['&Ok']);
          Result := False;
        End;

        if (Result) and (strTipoEntregaMandaeAnterior <> edtTipoDeEntregaMandae.Text) then     
        begin
          strTipoEntregaMandaeAnterior := edtTipoDeEntregaMandae.Text; 
          qryTabela.FieldByName('TRA_MANATU').AsDateTime := fNow();
        end;
      End

      Else If (Sender = edtLayoutImpressaoMandae) And (tsMandae.TabVisible) Then
      Begin
        If fEmptyStr(edtLayoutImpressaoMandae.Text) Then
        Begin
          edtNomeLayoutImpressaoMandae.Clear;
        End
        Else
        Begin
          pCarregaLayout(edtLayoutImpressaoMandae, edtNomeLayoutImpressaoMandae);
          if fEmptyStr(edtNomeLayoutImpressaoMandae.Text) then
          begin
            fMensagem('ATENÇÃO!', 'Preencha o campo "Layout de Impressão" corretamente!', ['&Ok']);
            Result := False;
          end;
        End;

        if (Result) and (strLayoutMandaeAnterior <> edtLayoutImpressaoMandae.Text) then
        begin
          strLayoutMandaeAnterior := edtLayoutImpressaoMandae.Text;
          qryTabela.FieldByName('TRA_MANATU').AsDateTime := fNow();
        end;
      End

      Else If (Sender = edtCodLayJad) And (grbJaglog.Visible) Then
      Begin
        If fEmptyStr(edtCodLayJad.Text) Then
        Begin
          edtLayJad.Clear;
        End
        Else
        Begin
          pCarregaLayout(edtCodLayJad, edtLayJad);
          if fEmptyStr(edtLayJad.Text) then
          begin
            fMensagem('ATENÇÃO!', 'Preencha o campo "Layout de Impressão" corretamente!', ['&Ok']);
            Result := False;
          end;
        End;
      End

      else if (Sender = edtCodPor) then
      begin
        if not fEmptyStr(edtCodPor.Text) Then
        begin
          edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
          if fEmptyStr(edtNomPor.Text) then
          begin
            fMensagem('ATENÇÃO!','Código do Portador incorreto !',['&O K']);
            Result := False;
          end
          else if not fEmpresaTemAcessoPortador(edtCodPor.Text,   qryTabela.FieldByName('TRA_EMPRES').AsString) then
          begin
            fMensagem('ATENÇÃO!', 'Empresa Transportadora sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          end;
        end;
      end

      Else If (Sender = fraPlanoDeContasPga.MskCodCta) Then
      Begin
        If not fEmptyStr(fraPlanoDeContasPga.MskCodCta.Text) Then
        Begin
          If (qryTabela.State = dsInsert) Then
          Begin
            fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);

            If Not PlanoDeContasAtivo(fraPlanoDeContasPga.MskCodCta.Text) Then
              Result := False;
          End
          Else
          Begin
            If qryTabela.FieldByName('TRA_PLCTPG').AsString <> fraPlanoDeContasPga.MskCodCta.Text Then
            Begin
              If Not PlanoDeContasAtivo(fraPlanoDeContasPga.MskCodCta.Text) Then
                Result := False;
              fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);
            End;
          End;
          If fEmptyStr(fraPlanoDeContasPga.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Código do Plano de Contas a Pagar incorreto !',['&O K']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = fraPlanoDeContasRec.MskCodCta) Then
      Begin
        If not fEmptyStr(fraPlanoDeContasRec.MskCodCta.Text) Then
        Begin
          If (qryTabela.State = dsInsert) Then
          Begin
            fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);

            If Not PlanoDeContasAtivo(fraPlanoDeContasRec.MskCodCta.Text) Then
              Result := False;
          End
          Else
          Begin
            If qryTabela.FieldByName('TRA_PLCTRC').AsString <> fraPlanoDeContasRec.MskCodCta.Text Then
            Begin
              If Not PlanoDeContasAtivo(fraPlanoDeContasRec.MskCodCta.Text) Then
                Result := False;
              fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);
            End;
          End;

          If fEmptyStr(fraPlanoDeContasRec.edtDesCta.Text) Then
          Begin
            fMensagem('ATENÇÃO!','Código do Plano de Contas a Receber incorreto !',['&O K']);
            Result := False;
          End;
        End;
      End

      Else If (Sender = mskConPagPagar) and (not fEmptyStr(mskConPagPagar.Text)) Then
      Begin
        Result := fValidaCondPagamento(mskConPagPagar, blnBuscaPorChave);
      End

      Else If (Sender = mskConPagReceber) and (not fEmptyStr(mskConPagReceber.Text)) Then
      Begin
        Result := fValidaCondPagamento(mskConPagReceber, blnBuscaPorChave);
      End

      Else If (Sender = dbeIntFus) and (dbeIntFus.Visible) Then
      Begin
        If (Pos(dbeIntFus.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Integração Fusion?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeExpB2B) Then
      Begin
        If (Pos(dbeExpB2B.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Exporta para o B2B ?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeIMPDES) Then
      Begin
        If (Not 'SN'.Contains(dbeIMPDES.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Trazer marcado o check-box "Imprimir Etiquetas de Despacho" na Expedição?" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbeUtiItelipost) And (tbsIntelipost.TabVisible) Then
      Begin
        If not fEmptyStr(dbeUtiItelipost.text) and (Pos(dbeUtiItelipost.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Preencha o campo "Transportadora Utiliza Integração com a Intelipost??" corretamente!', ['&Ok']);
          Result := False;
        End;
      End

      Else If  (Sender = cklTipoFretePermitido) And cklTipoFretePermitido.Visible Then
      Begin
        If fNenhumTipoFretePermitidoSelecionado Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'O campo "Tipo de Frete Permitido" deve ser informado! Selecione uma das opções!', ['&Ok']);
        End;
      End

      Else If (Sender = dbOBGROT) and (pnlObrigatorioInformarRota.Visible) Then
      Begin
        If (Pos(dbOBGROT.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!',  'O Campo "Obrigatório informar a Rota?", deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End

      Else If (Sender = dbTRA_B2WENT) and (dbTRA_B2WENT.Visible) Then
      Begin
        If (Pos(dbTRA_B2WENT.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!',  'O Campo "Realiza coleta da B2W Entrega?", deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;
      End;

    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      Result := False;
      fMensagem('',E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadTransportadoras.fValidaCampos]');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadTransportadoras.fValidaCondPagamento(var mskCndPag: TMaskEditFocus; blnBuscaPorChave: Boolean): Boolean;
var
 strConPag: String;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskCndPag.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End

  Else If fEmptyStr(Copy(mskCndPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskCndPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskCndPag.Text, strConPag, VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskCndPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;

  End;
end;

function TfrmCadTransportadoras.fValidaExisteCpfCnpj: Boolean;
var
  LQuery : TUniQuery;
  LSql   : String;
begin
  Result := True;

  if blnJaValidouTravaCnpjCpf then
    Exit;

  LQuery := fCriaQuery(nil);

  try
    LSql := 'select '
          + '       TRA_CODTRA '
          + '     , TRA_NOMTRA '
          + '  FROM CADTRA '
          + ' WHERE TRA_C_G_C_ = :C_G_C_';

    LQuery.Close;
    LQuery.SQL.Text := LSql;
    LQuery.ParamByName('C_G_C_').AsString := dbeNumCgc.Text;
    LQuery.Open;

    if (LQuery.IsEmpty) or
       (LQuery.FieldByName('TRA_CODTRA').AsString = dbeCodTra.Text) then
      Exit;

    if (fCfgSis('TRPCCD', varString) = 'A') then
      fMensagem('AVISO!', 'Já existe um CNPJ/CPF com esse número cadastrado.', ['&Ok'])
    else
    if (fCfgSis('TRPCCD', varString) = 'T') then
    begin
      Result := False;
      fMensagem('AVISO!', 'Já existe um CNPJ/CPF com esse número cadastrado.', ['&Ok']);
    end
    else
    if (fCfgSis('TRPCCD', varString) = 'L') then
    begin
      objLiberacao := TLiberacaoFactory.fGetLiberacao;
      objLiberacao.Clear;
      objLiberacao.strDirAce    := 'TRACGC';
      objLiberacao.strCodOpe    := strLoginUsuarioLogado;
      objLiberacao.objMsgLibera.strTitulo := 'Liberação de CNPJ/CPF Transportadora';
      objLiberacao.objMsgLibera.pAddTexto('Já existe uma outra Transportadora com o CNPJ/CPF '+dbeNumCgc.Text+' cadastrado: '+
                                          LQuery.FieldByName('TRA_NOMTRA').AsString+'.');

      Result := objLiberacao.fLibera;
    end;

    blnJaValidouTravaCnpjCpf := Result;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TfrmCadTransportadoras.pCarregaCidade(blnAtuCep: Boolean = True);
begin
  pPesquisaCadCid(qryCadCid, qryConCid, dbeCodCid.Text);
  With qryConCid Do
  Begin
    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    If (blnAtuCep) And (dbeNumCep.Field <> Nil) And (dbeNumCep.Field.IsNull) Then
    Begin
      dbeNumCep.Text := FieldByName('CID_C_E_P_').AsString;
      strCepAnt      := FieldByName('CID_C_E_P_').AsString;
    End;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
  End;
end;

procedure TfrmCadTransportadoras.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('TRA_CODTRA');
  stlCampos.Add('TRA_NOMTRA');
  stlCampos.Add('TRA_NOMFAN');
  stlCampos.Add('TRA_ENDERE');
  stlCampos.Add('TRA_BAIRRO');
  stlCampos.Add('TRA_C_G_C_');
  stlCampos.Add('TRA_NUMPLA');
  stlCampos.Add('TRA_NOMFAN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('TRA_NOMTRA');
  stlCamInd.Add('TRA_NOMFAN');
  stlCamInd.Add('TRA_CODTRA');
  stlCamInd.Add('TRA_NUMPLA');
  stlCamInd.Add('TRA_C_G_C_');
  stlCamInd.Add('TRA_NOMFAN');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Fantasia');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nro. Placa');
  stlDesInd.Add('CNPJ-CPF');
  stlDesInd.Add('Fantasia');

  qryCadCid := fCriaQuery(Self);

  qryConCid := qryCadCid;
  qryConCtt := qryCadCid;
end;

procedure TfrmCadTransportadoras.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
  pFormataCampos;

  qryTabela.FieldByName('TRA_VALFRE').AsFloat := 0;
  qryTabela.FieldByName('TRA_FREVEN').AsString := 'D';//Destacado no documento
  qryTabela.FieldByName('TRA_PROFRE').AsString := 'D';//Definido no documento
  qryTabela.FieldByName('TRA_CNHREC').AsString := 'S';
  qryTabela.FieldByName('TRA_ATIVA_').AsString := 'S';
  qryTabela.FieldByName('TRA_CONHAB').AsString := 'N';
  qryTabela.FieldByName('TRA_B2WENT').AsString := 'N';
  qryTabela.FieldByName('TRA_UTIBOX').AsString := 'N';
  qryTabela.FieldByName('TRA_EXPB2B').AsString := 'S';
  qryTabela.FieldByName('TRA_IMPDES').AsString := 'S';
  qryTabela.FieldByName('TRA_INTFUS').AsString := 'N';

  dbeDtaCad.Field.AsDateTime := VS_Date;
  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodTra, dbeNomTra, False)
  Else
    pHabilitaCodigo(dbeCodTra, dbeCodTra, True);

  btnCadClientes.Enabled := True;
  btnCadFor.Enabled := True;


  {******************************}
  { ROTINAS P\ ABA CONTATO       }
  {***************************JB*}
  cdsTraCtt.EmptyDataSet;
  dbgContatos.ReadOnly := False;
  pnlContatos.Enabled  := True;

  If (Not Assigned(lstContatos)) Then
    lstContatos := TObjectList.Create(True);

  lstContatos.Clear;
  If (Assigned(objTraCtt)) Then
    FreeAndNil(objTraCtt);

  pCarregaOpcoesTiposDeFreteDoRateio;
  pSetarStatusListaOpcoesRateioFrete;
  objTraCtt := TTraCtt.Create;
  pAbreCorTra;

  strUtilizaMandaeAnterior     := '';
  strTipoEntregaMandaeAnterior := '';
  strLayoutMandaeAnterior      := '';

  if tsConFreteEletr.TabVisible then
    dbeCodEmpRespConh.Enabled := (dbeTranspHabFE.Text = 'S');
  drgTipEtq.ItemIndex  := 0;

  btnConsultaFit.Glyph := Nil;
  ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
  btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
  btnConsultaFit.Enabled :=  (dbeCgcCpf.Enabled) And (dbeCgcCpf.Text = '1');

  pCarregaOpcoesTiposDeFrete;
  pAjustaDefaultTipoFretePermitido(True);
end;

procedure TfrmCadTransportadoras.btnAlterarClick(Sender: TObject);
var
  strDtaSef: string;
begin
  inherited;
  if qryTabela.IsEmpty then
    Exit;

  pLimpaEditsContatos;
  dbgContatos.ReadOnly := False;
  pnlContatos.Enabled  := True;

  pgcDados.ActivePageIndex := 0;

  pHabilitaCodigo(dbeCodTra, dbeNomTra, False);

  pSetarStatusListaOpcoesRateioFrete;

  btnCadClientes.Enabled := True;
  btnCadFor.Enabled := True;

  if tsConFreteEletr.TabVisible then
    dbeCodEmpRespConh.Enabled := (dbeTranspHabFE.Text = 'S');

  btnConsultaFit.Enabled := (dbeCgcCpf.Enabled) And (dbeCgcCpf.Text = '1');

  if btnConsultaFit.Enabled then
  begin
    if fTeveConsultaSefaz('CADTRA', 'TRA_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, strDtaSef) then
    begin
      btnConsultaFit.Glyph := Nil;
      ImageSefaz.GetBitmap(1, btnConsultaFit.Glyph);
      btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.' + sLineBreak + 'Última consulta realizada em '+strDtaSef+'.';
    end
    else
    begin
      btnConsultaFit.Glyph := Nil;
      ImageSefaz.GetBitmap(0, btnConsultaFit.Glyph);
      btnConsultaFit.Hint := 'Consulta Dados Cadastrais do CNPJ.';
    end;
  end;

  pAjustaTipoFretePermitido;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadTransportadoras.pLimpaEdits;
begin
  edtCidade.Clear;
  edtEstado.Clear;
  edtDesFrg.Clear;
  If cdsCorTra.Active And (cdsCorTra.RecordCount > 0) Then
    cdsCorTra.EmptyDataSet;

  edtCFOP.Clear;
  edtCFOPJU.Clear;
  edtNaturezaOp.Clear;
  edtSerie.Clear;
  cmbTomadorServ.ItemIndex := -1;
  cmbCodigoClassTrib.ItemIndex := -1;
  edtProdutoPredom.Clear;
  edtDescricaoServ.Clear;
  edtRNTRC.Clear;
  edtCodPor.Clear;
  fraPlanoDeContasPga.MskCodCta.Clear;
  mskConPagPagar.Clear;
  fraPlanoDeContasRec.MskCodCta.Clear;
  mskConPagReceber.Clear;
  edtAliquota.Clear;
  edtDesLay.Clear;
  edtDtaLay.Clear;
  edtNomeLayoutImpressaoMandae.Clear;

  edtDesEmpRespConh.Clear;
  edtNomPor.Clear;
  fraPlanoDeContasPga.edtDesCta.Clear;
  fraPlanoDeContasRec.edtDesCta.Clear;
  blnJaValidouTravaCnpjCpf := False;
end;

procedure TfrmCadTransportadoras.btnCadClientesClick(Sender: TObject);
var
  strCodCli: string;

    function fExisteCnpjCpfCliente(Var strCodCli: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   CLI_CODCLI           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADCLI               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   CLI_C_G_C_ = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodCli := FieldByName('CLI_CODCLI').AsString;
              fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                  strCodCli + ' no Cadastro de Clientes!',['&OK']);
              Result := True;
            End;
            Close;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;

begin
  inherited;
  if (qryTabela.State in [dsEdit, dsInsert]) then
  begin
    If Not fUsaProCodigo('CADCLI') Then
    Begin
      fMensagem('ATENÇÃO!',
                'Para utilizar o "Cadastro Rápido" para o "Cadastro de Clientes" é necessário:'     + #13 +
                'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
                'localize o arquivo "CADCLI" e habilite a opção "Automático".',
                ['&Ok'],
                1,
                False,
                1,
                0,
                False,
                0,
                False,
                False,
                False,
                0,
                500);
      Exit;
    End;

    if (dbeCgcCpf.Text = '1') and (not fVerificaAcessoSistema('ALTPJU', strLoginUsuarioLogado)) then
    begin
      pMensagemOk('Usuário sem permissão para incluir ou alterar cliente do tipo pessoa jurídica!');
      Exit;
    end;

    if (dbeCgcCpf.Text = '2') and (not fVerificaAcessoSistema('ALTPFI', strLoginUsuarioLogado)) then
    begin
      pMensagemOk('Usuário sem permissão para incluir ou alterar cliente do tipo pessoa física!');
      Exit;
    end;

    if (qryTabela.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodTra.Text)) and (dbeCodTra.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomTra.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if ((fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0')) or  fEmptyStr(dbeNumCgc.Text) then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfCliente(strCodCli, dbeNumCgc.Text, edtEstado.Text)) then
    begin
      If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
        Exit;

      If fCadastroRapidoCliente(strCodCli,
                                dbeNomTra.Text,
                                dbeNomFan.Text,
                                dbeEndere.Text,
                                '',
                                '',
                                dbeBairro.Text,
                                dbeCodCid.Text,
                                dbeNumCep.Text,
                                dbeFone01.Text,
                                '',
                                '',
                                dbeNumIes.Text,
                                dbeEmail.Text,
                                '',
                                'A',
                                '',
                                StrToInt(dbeCgcCpf.Text),
                                dbeNumCgc.Text,
                                '',
                                '',
                                StrToDateDef(dbeDtaCad.Text,0),
                                0,
                                dbeFone02.Text,
                                '',
                                dbeHomPag.Text) Then

      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Clientes criado com o Código: ' + strCodCli, ['&Ok']);
    end
    else
    begin
      If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Clientes?', ['&Sim', '&Não']) = 2) Then
        Exit;

      If fCadastroRapidoCliente(strCodCli,
                                dbeNomTra.Text,
                                dbeNomFan.Text,
                                dbeEndere.Text,
                                '',
                                '',
                                dbeBairro.Text,
                                dbeCodCid.Text,
                                dbeNumCep.Text,
                                dbeFone01.Text,
                                '',
                                '',
                                dbeNumIes.Text,
                                dbeEmail.Text,
                                '',
                                'A',
                                '',
                                StrToInt(dbeCgcCpf.Text),
                                dbeNumCgc.Text,
                                '',
                                '',
                                StrToDateDef(dbeDtaCad.Text,0),
                                0,
                                dbeFone02.Text,
                                '',
                                dbeHomPag.Text) Then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;
  end;
end;

procedure TfrmCadTransportadoras.btnCadForClick(Sender: TObject);
var
  strCodAti,
  strCodFor: string;

    function fExisteCnpjCpfFornecedor(Var strCodFor: String; var strCodAti:String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      Try
        Result := False;
        strCodAti := '';

        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   FOR_CODFOR,          ';
          strSQL := strSQL + '   FOR_CODATI           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADFOR               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   FOR_C_G_C_ = :CODIGO ';

          qryGenTmp.Close;
          qryGenTmp.SQL.Clear;
          qryGenTmp.SQL.Add(strSQL);
          qryGenTmp.ParamByName('CODIGO').AsString := strCodigo;
          qryGenTmp.Open;

          If Not qryGenTmp.IsEmpty Then
          Begin
            strCodFor := qryGenTmp.FieldByName('FOR_CODFOR').AsString;
            strCodAti := qryGenTmp.FieldByName('FOR_CODATI').AsString;
            fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                strCodFor + ' no Cadastro de Fornecedor!',['&OK']);
            Result := True;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;
begin
  inherited;
  if qryTabela.State in [dsEdit, dsInsert] then
  begin
    If Not fUsaProCodigo('CADFOR') Then
    Begin
      fMensagem('ATENÇÃO!',
                'Para utilizar o "Cadastro Rápido" para o "Cadastro de Fornecedore" é necessário:'     + #13 +
                'Habilitar a geração de código automático acessando:  "> Útil > Próximos Códigos",' + #13 +
                'localize o arquivo "CADFOR" e habilite a opção "Automático".',
                ['&Ok'],
                1,
                False,
                1,
                0,
                False,
                0,
                False,
                False,
                False,
                0,
                500);
      Exit;
    End;

    if (qryTabela.IsEmpty) then
    begin
      fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCodTra.Text)) and (dbeCodTra.Enabled) then
    begin
      fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeNomTra.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
      Exit;
    end;

    if (fEmptyStr(dbeCgcCpf.Text)) or (dbeCgcCpf.Text = '0') then
    begin
      fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
      Exit;
    end
    else if (not fValidaCnpjCpf(dbeCgcCpf.Text, dbeNumCgc.Text, False, False)) then
    begin
      fMensagem('ATENÇÃO!', 'CNPJ / CPF inválido!', ['&Ok']);
      Exit;
    end;

    if (not fExisteCnpjCpfFornecedor(strCodFor, strCodAti, dbeNumCgc.Text, edtEstado.Text)) then
    begin
      if (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) then
        Exit;

      strCodAti := fInformaAtividade;

      if (fEmptyStr(strCodAti)) then
      begin
        fMensagem('ATENÇÃO!', 'Atividade não informada!', ['&Ok']);
        Exit;
      end;

      if fCadastroRapidoFornecedor(strCodFor,
                                   dbeNomTra.Text,
                                   dbeNomFan.Text,
                                   dbeEndere.Text,
                                   dbeBairro.Text,
                                   dbeCodCid.Text,
                                   dbeNumCep.Text,
                                   dbeFone01.Text,
                                   '',
                                   dbeEmail.Text,
                                   'A',
                                   dbeNumCgc.Text,
                                   dbeFone02.Text,
                                   '',
                                   dbeHomPag.Text,
                                   '',
                                   dbeNumIes.Text,
                                   strCodAti,
                                   StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                            'Cadastro de Fornecedor criado com o Código: ' + strCodFor, ['&Ok']);
    end
    else
    begin
      If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) Then
        Exit;

      if fCadastroRapidoFornecedor(strCodFor,
                                   dbeNomTra.Text,
                                   dbeNomFan.Text,
                                   dbeEndere.Text,
                                   dbeBairro.Text,
                                   dbeCodCid.Text,
                                   dbeNumCep.Text,
                                   dbeFone01.Text,
                                   '',
                                   dbeEmail.Text,
                                   'A',
                                   dbeNumCgc.Text,
                                   dbeFone02.Text,
                                   '',
                                   dbeHomPag.Text,
                                   '',
                                   dbeNumIes.Text,
                                   strCodAti,
                                   StrToInt(dbeCgcCpf.Text)) then

      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
    end;
  end;
end;

Procedure TfrmCadTransportadoras.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;

  dbgContatos.ReadOnly := True;
  pnlContatos.Enabled  := False;
  pCarregaCidade;
  pCarregaFaixaFrete();
  pCarregaContatos(qryTabela.FieldByName('TRA_CODTRA').AsString);
  pCarregarDadosTiposDeFreteDoRateio(qryTabela.FieldByName('TRA_CODTRA').AsString, qryTabela.FieldByName('TRA_FREVEN').AsString);
  pCarregarDadosTiposDeFretePermitido(qryTabela.FieldByName('TRA_CODTRA').AsString);
  pCarregaPadraoCTe;
  pSetarStatusListaOpcoesRateioFrete;
  dbeCodEmpRespConhExit(Self);
  If pnlEtqTipo.Visible then
    pCarregaLayout(dbeLayEtq, edtDesLay);
  pCarregaLayout(edtLayoutImpressaoMandae, edtNomeLayoutImpressaoMandae);

  pgcDados.ActivePageIndex := 0;

  btnCadClientes.Enabled := False;
  btnCadFor.Enabled := False;
  cbbEtiquetaDespacho.ItemIndex := 0;
  cbbModJadLog.ItemIndex := 0;
  pAlteraEtiquetaDespacho;

  btnConsultaFit.Enabled := False;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadTransportadoras.dbeCodCidKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCodCid, edtCidade, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.dbeCodEmpRespConhExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCodEmpRespConh.Text) Then
    edtDesEmpRespConh.Clear
  Else
  Begin
    edtDesEmpRespConh.Text := fRetNomeEmpresaSelec(dbeCodEmpRespConh.Text);

    If fEmptyStr(edtDesEmpRespConh.Text) Then
    Begin
      fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
      dbeCodEmpRespConh.Clear;
      pSetFocus(dbeCodEmpRespConh);
    End;
  End;
end;

procedure TfrmCadTransportadoras.dbeCodEmpRespConhKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, TDBEditFocus(Sender), Nil, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.dbeCodFrgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFreteFaixaFaturamento(Self, dbeCodFrg, edtDesFrg, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodFrg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.dbeLayEtqKeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayoutEtiquetaDespacho(Self, dbeLayEtq, edtDesLay, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeLayEtq, True) Then
      SelectNext(ActiveControl, True, True);
  End;

  pAjustaTelaUtilizaCampoInformarRotaObr;
end;

procedure TfrmCadTransportadoras.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTransportadoras.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaCidade;
  pCarregaFaixaFrete;
  pCarregaContatos(qryTabela.FieldByName('TRA_CODTRA').AsString);
  pCarregarDadosTiposDeFreteDoRateio(qryTabela.FieldByName('TRA_CODTRA').AsString, qryTabela.FieldByName('TRA_FREVEN').AsString);
  pCarregarDadosTiposDeFretePermitido(qryTabela.FieldByName('TRA_CODTRA').AsString);
  if pnlEtqTipo.Visible then
    pCarregaLayout(dbeLayEtq, edtDesLay);
  pCarregaLayout(edtLayoutImpressaoMandae, edtNomeLayoutImpressaoMandae);
  dbeCodEmpRespConhExit(Self);
  pgcDados.ActivePageIndex := 0;
  cbbEtiquetaDespacho.ItemIndex := 0;
  cbbModJadLog.ItemIndex := 0;
  pAlteraEtiquetaDespacho;
end;

procedure TfrmCadTransportadoras.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCidade;
  pCarregaFaixaFrete;
  pCarregaCidadeCtt;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  If Not fEmptyStr(strCodTransportadoraIniciarCadastro) Then
    Self.pPesquisa(strCodTransportadoraIniciarCadastro);

  dbeCodEmpRespConhExit(Self);

  pnlFrenet.Visible        := fCfgSis('FREUSA', varBoolean);
  pnlEscCre.Visible        := fCfgSis('ESCDOW', varBoolean);
  pnlDataFrete.Visible     := fCfgSis('DTFUSA', varBoolean);

  grpFrenet.Visible :=  pnlFrenet.Visible or pnlDataFrete.Visible;

  tbsExportacao.TabVisible := False;
  tsMandae.TabVisible := False;
  lblModJadLog.Visible := False;
  cbbModJadLog.Visible := False;
  grbJaglog.Visible := False;
  pCarregaOpcoesTiposDeFreteDoRateio;
end;

function TfrmCadTransportadoras.dbeCodCidChamaCadastro(Key: Word): String;
begin
  inherited;
  Result    := fChamaCadCid(Key);
  qryConCid := qryCadCid;
end;

procedure TfrmCadTransportadoras.btnPesquisaClick(Sender: TObject);
begin
  Self.pPesquisa;
  If pnlEtqTipo.Visible then
    pCarregaLayout(dbeLayEtq, edtDesLay);
  pCarregaLayout(edtLayoutImpressaoMandae, edtNomeLayoutImpressaoMandae);
  pnlEtqDados.Visible := drgTipEtq.ItemIndex > 0;

  fValidaCampos(dbeCgcCpf);
end;

procedure TfrmCadTransportadoras.btnRemoverServicoCorreioClick(Sender: TObject);
begin
  inherited;
  cdsCorTra.Edit;
  cdsCorTra.FieldByName('CODSER').Clear;
  cdsCorTra.FieldByName('DESCRI').Clear;
  cdsCorTra.Post;
end;

procedure TfrmCadTransportadoras.cbbEtiquetaDespachoChange(Sender: TObject);
begin
  inherited;
  pAlteraEtiquetaDespacho;
end;

procedure TfrmCadTransportadoras.dbeCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (dbeCgcCpf.Text = '1') Then
    qryTabela.FieldByName('TRA_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    qryTabela.FieldByName('TRA_C_G_C_').EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

  btnConsultaFit.Enabled := (dbeCgcCpf.Enabled) And (dbeCgcCpf.Text = '1') And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert));
end;

procedure TfrmCadTransportadoras.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  qryTabela.AfterScroll := Nil;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadTransportadoras.btnCancelaCttClick(Sender: TObject);
begin
  inherited;
  pLimpaEditsContatos;
  If edtNomCtt.Enabled Then
    pSetFocus(edtNomCtt);
  blnAltContato := False;
end;

procedure TfrmCadTransportadoras.pCarregaContatos(strCodTra: String);
  Var
    intContador: Integer;
begin
  pLimpaEditsContatos;
  lstContatos := TTraCtt.fRetContatos(strCodTra);
  cdsTraCtt.EmptyDataSet;

  For intContador := 0 To lstContatos.Count -1 Do
  Begin

    objTraCtt := TTraCtt(lstContatos[intContador]);
    pAdicionaContatoCds(objTraCtt);

  End;
end;

procedure TfrmCadTransportadoras.pCarregaFaixaFrete;
begin
  edtDesFrg.Text := fCampoTabela('FRG_DESFRG', 'CADFRG', ['FRG_CODFRG'], [dbeCodFrg.Text]);
end;

procedure TfrmCadTransportadoras.pAdicionaContatoCds(objContato: TTraCtt);
begin
  With cdsTraCtt Do
  Begin

    If (blnAltContato) Then
      Edit
    Else
      Append;

    FieldByName('NOMCTT').AsString := objContato.strNomCtt;
    FieldByName('ENDCTT').AsString := objContato.strEndCtt;
    FieldByName('BAICTT').AsString := objContato.strBaiCtt;
    FieldByName('CODCID').AsString := objContato.strCidCtt;
    FieldByName('NOMCID').AsString := objContato.strNomCid;
    FieldByName('ESTCID').AsString := objContato.strEstado;
    FieldByName('TELCTT').AsString := objContato.strTelCtt;
    FieldByName('CELCTT').AsString := objContato.strCelCtt;
    FieldByName('FAXCTT').AsString := objContato.strFaxCtt;
    FieldByName('DEPCTT').AsString := objContato.strDepCtt;
    FieldByName('EMACTT').AsString := objContato.strEmaCtt;
    Post;

    If (blnAltContato) Then
      lstContatos.Items[RecNo-1] := objContato
    Else If (lstContatos.IndexOf(objContato) < 0) Then
      lstContatos.Add(objContato);

    // Gera novo objeto em branco.
    objTraCtt := TTraCtt.Create;

  End;
end;

procedure TfrmCadTransportadoras.pCarregaContatoAlteracao;
begin
  If (Assigned(objTraCtt)) Then
    FreeAndNil(objTraCtt);

  objTraCtt := TTraCtt(lstContatos[cdsTraCtt.RecNo-1]);
  If edtNomCtt.Enabled Then
    pSetFocus(edtNomCtt);
  blnAltContato := True;
end;

procedure TfrmCadTransportadoras.pAtualizaEditsContato(DataSet: TDataSet);
begin
  With cdsTraCtt Do
  Begin

    If (IsEmpty) Then
      Exit;

    If FindField('TELCTT') <> nil Then
      TStringField(FieldByName('TELCTT')).EditMask := fRetMascaraFonePais;

    If FindField('CELCTT') <> nil Then
      TStringField(FieldByName('CELCTT')).EditMask := fRetMascaraFonePais;

    If FindField('FAXCTT') <> nil Then
      TStringField(FieldByName('FAXCTT')).EditMask := fRetMascaraFonePais;

    edtNomCtt.Text    := FieldByName('NOMCTT').AsString;
    edtEndCtt.Text    := FieldByName('ENDCTT').AsString;
    edtBaiCtt.Text    := FieldByName('BAICTT').AsString;
    mskTelCtt.Text    := FieldByName('TELCTT').AsString;
    mskCelCtt.Text    := FieldByName('CELCTT').AsString;
    mskFaxCtt.Text    := FieldByName('FAXCTT').AsString;
    edtDepCtt.Text    := FieldByName('DEPCTT').AsString;
    edtCidCtt.Text    := FieldByName('CODCID').AsString;
    edtDesCidCtt.Text := FieldByName('NOMCID').AsString;
    edtEstadoCtt.Text := FieldByName('ESTCID').AsString;
    edtEmaCtt.Text    := FieldByName('EMACTT').AsString;

  End;
end;

procedure TfrmCadTransportadoras.pLimpaEditsContatos;
begin
  edtNomCtt.Clear;
  edtEndCtt.Clear;
  edtBaiCtt.Clear;
  mskTelCtt.Clear;
  mskCelCtt.Clear;
  mskFaxCtt.Clear;
  edtDepCtt.Clear;
  edtCidCtt.Clear;
  edtDesCidCtt.Clear;
  edtEstadoCtt.Clear;
  edtEmaCtt.Clear;
end;

procedure TfrmCadTransportadoras.pOnStateChange;
begin
  inherited;
  btnCarregarServicoCorreio.Enabled := btnGravar.Enabled;
  btnRemoverServicoCorreio.Enabled := btnGravar.Enabled;

end;

procedure TfrmCadTransportadoras.pPesquisa(strCodTransportadora: String = '');
var
  chrKey: Char;
  arrTransp: TConsultasArray;
  intContador: Integer;
begin
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  chrKey := '/';
  If fSetaTransportadoraInformada(strCodTransportadora) Or
     fPesqTransportadora(conTraCompleta, Self, Nil, Nil, qryTabela, chrKey, arrTransp) Then
  Begin
    pCarregaCidade;
    pCarregaFaixaFrete();
    pAbreCorTra();
    pCarregaContatos(qryTabela.FieldByName('TRA_CODTRA').AsString);
    pCarregarDadosTiposDeFreteDoRateio(qryTabela.FieldByName('TRA_CODTRA').AsString, qryTabela.FieldByName('TRA_FREVEN').AsString);
    pCarregarDadosTiposDeFretePermitido(qryTabela.FieldByName('TRA_CODTRA').AsString);
    if tsConFreteEletr.TabVisible then
    begin
      edtDesEmpRespConh.Text := fRetNomeEmpresaSelec(dbeCodEmpRespConh.Text);
      pCarregaPadraoCTe;
    end;
    strCepAnt                := qryTabela.FieldByName('TRA_C_E_P_').AsString;

    strUtilizaMandaeAnterior     := IIF(qryTabela.FieldByName('TRA_ETIDES').AsString = 'MANDAE', 'S', 'N');
    strTipoEntregaMandaeAnterior := qryTabela.FieldByName('TRA_MANTEN').AsString;
    strLayoutMandaeAnterior      := qryTabela.FieldByName('TRA_MANLAY').AsString;

    cbbEtiquetaDespacho.ItemIndex := 0;
    cbbModJadLog.ItemIndex := 0;
    if not fEmptyStr(qryTabela.FieldByName('TRA_ETIDES').AsString) then
    begin
      cbbEtiquetaDespacho.ItemIndex := cbbEtiquetaDespacho.Items.IndexOf(qryTabela.FieldByName('TRA_ETIDES').AsString);

      cbbModJadLog.ItemIndex := -1;
      for intContador := Low(MODALIDADE_JADLOG) to High(MODALIDADE_JADLOG) do
        if MODALIDADE_JADLOG[intContador] = qryTabela.FieldByName('TRA_MODJED').AsInteger then
        begin
          cbbModJadLog.ItemIndex := intContador +1;
          Break;
        end;

      pAlteraEtiquetaDespacho;
    end;

    if not fEmptyStr(edtCodLayJad.Text) then
    begin
      pCarregaLayout(edtCodLayJad, edtLayJad);
    end;

    pSetarStatusListaOpcoesRateioFrete;
    pgcDados.ActivePageIndex := 0;
    pSetFocus(btnAlterar);
  End
  Else
  Begin
    If (Assigned(lstContatos)) Then
      lstContatos.Clear;

    cdsTraCtt.EmptyDataSet;
  End;

  pFormataCampos;
end;

procedure TfrmCadTransportadoras.fraPlanoDeContasPgaMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasPga.MskCodCta, fraPlanoDeContasPga.edtDesCta, Nil, Key, arrCentroCusto) Then
    begin
      if fValidaCampos(fraPlanoDeContasPga.MskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End
end;

procedure TfrmCadTransportadoras.fraPlanoDeContasRecMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self, fraPlanoDeContasRec.MskCodCta, fraPlanoDeContasRec.edtDesCta, Nil, Key, arrCentroCusto) Then
    begin
      if fValidaCampos(fraPlanoDeContasRec.MskCodCta) then
        SelectNext(ActiveControl, True, True);
    end;
  End
end;

function TfrmCadTransportadoras.fSetaTransportadoraInformada(strCodTransportadora: String = ''): Boolean;
begin
  Result := False;
  If Not fEmptyStr(strCodTransportadora) Then
  Begin
    pPesquisaCadTra(qryTabela, qryTabela, strCodTransportadora);
    Result := True;
  End;
end;

procedure TfrmCadTransportadoras.rdgFreVenEnter(Sender: TObject);
begin
  inherited;
  if rdgFreVen.ItemIndex > -1 then
    pSetFocus(TWinControl(rdgFreVen.Controls[rdgFreVen.ItemIndex]));
end;

procedure TfrmCadTransportadoras.pCarregaCidadeCtt;
begin
  pPesquisaCadCid(qryCadCid, qryConCtt, edtCidCtt.Text);
  With qryConCtt Do
  Begin
    edtDesCidCtt.Text := FieldByName('CID_NOMCID').AsString;
    edtEstadoCtt.Text := FieldByName('CID_ESTADO').AsString;
  End;
end;

procedure TfrmCadTransportadoras.btnCarregarServicoCorreioClick(Sender: TObject);
  Var
    arrSel : TConsultasArray;
    qryConsulta : TUniQuery;
    Key : Char;
begin
  inherited;
  Key := '/';
  qryConsulta := fCriaQuery;
  Try
    If fPesqServicoCorreio(Self, Nil, Nil, qryConsulta,Key, arrSel, True, cdsCorTra.FieldByName('CODEMP').AsString) Then
    Begin
      cdsCorTra.Edit;
      cdsCorTra.FieldByName('CODSER').AsString := qryConsulta.FieldByName('CSE_CODIGO').AsString;
      cdsCorTra.FieldByName('DESCRI').AsString := qryConsulta.FieldByName('CSE_DESCRI').AsString;
      cdsCorTra.Post;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadTransportadoras.btnConsultaFitClick(Sender: TObject);
var
  dicValoresAtuais, dicResultado: TDicionario;
begin
  inherited;

  if dbeCgcCpf.Text <> '1' then
    Exit;

  If fEmptyStr(dbeNumCgc.Text) Then
  Begin
    fMensagem('Atenção', 'Informe o CNPJ antes de realizar a consulta', ['&Ok']);
    Exit;
  End;

  dicValoresAtuais := TDicionario.Create;
  dicResultado := TDicionario.Create;
  try
    dicValoresAtuais.Limpar;
    dicValoresAtuais.Adicionar(DESC_RAZAO_SOCIAL,  qryTabela.FieldByName('TRA_NOMTRA').AsString);
    dicValoresAtuais.Adicionar(DESC_NOME_FANTASIA, qryTabela.FieldByName('TRA_NOMFAN').AsString);
    dicValoresAtuais.Adicionar(DESC_INSC_EST,      qryTabela.FieldByName('TRA_I_E_S_').AsString);
    dicValoresAtuais.Adicionar(DESC_ENDERECO,      qryTabela.FieldByName('TRA_ENDERE').AsString);
    dicValoresAtuais.Adicionar(DESC_NUMERO,        '');
    dicValoresAtuais.Adicionar(DESC_BAIRRO,        qryTabela.FieldByName('TRA_BAIRRO').AsString);
    dicValoresAtuais.Adicionar(DESC_CEP,           qryTabela.FieldByName('TRA_C_E_P_').AsString);
    dicValoresAtuais.Adicionar(DESC_CNPJ,          qryTabela.FieldByName('TRA_C_G_C_').AsString);
    dicValoresAtuais.Adicionar(DESC_IBGE_CIDADE,   fRetornaCodIBGE(qryTabela.FieldByName('TRA_CODCID').AsString));

    objConsultaCadastroFit.pConsulta(dicValoresAtuais,
                                     dicResultado,
                                     fTiraCaracEspeciaisPonto(dbeNumCgc.Text),
                                     False,
                                     blnTemDivergenciaSefaz,
                                     True,
                                     'untCadTransportadoras');

    if dicResultado.Chaves.IndexOf(DESC_RAZAO_SOCIAL) > -1 then
      qryTabela.FieldByName('TRA_NOMTRA').AsString := dicResultado.Retorna(DESC_RAZAO_SOCIAL);
    if dicResultado.Chaves.IndexOf(DESC_NOME_FANTASIA) > -1 then
      qryTabela.FieldByName('TRA_NOMFAN').AsString := dicResultado.Retorna(DESC_NOME_FANTASIA);
    if dicResultado.Chaves.IndexOf(DESC_INSC_EST) > -1 then
      qryTabela.FieldByName('TRA_I_E_S_').AsString := dicResultado.Retorna(DESC_INSC_EST);
    if dicResultado.Chaves.IndexOf(DESC_ENDERECO) > -1 then
      qryTabela.FieldByName('TRA_ENDERE').AsString := dicResultado.Retorna(DESC_ENDERECO);
    if dicResultado.Chaves.IndexOf(DESC_NUMERO) > -1 then
      qryTabela.FieldByName('TRA_ENDERE').AsString := qryTabela.FieldByName('TRA_ENDERE').AsString + ' ' + dicResultado.Retorna(DESC_NUMERO);
    if dicResultado.Chaves.IndexOf(DESC_BAIRRO) > -1 then
      qryTabela.FieldByName('TRA_BAIRRO').AsString := dicResultado.Retorna(DESC_BAIRRO);
    if dicResultado.Chaves.IndexOf(DESC_CEP) > -1 then
    begin
      qryTabela.FieldByName('TRA_C_E_P_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CEP));
      fValidaCampos(dbeNumCep);
    end;
    if dicResultado.Chaves.IndexOf(DESC_CNPJ) > -1 then
      qryTabela.FieldByName('TRA_C_G_C_').AsString := fTiraCaracEspeciaisPonto(dicResultado.Retorna(DESC_CNPJ));

    if not blnTemDivergenciaSefaz then
      pSalvaDataConsultaSefaz('CADTRA', 'TRA_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);
  finally
    FreeAndNil(dicValoresAtuais);
    FreeAndNil(dicResultado);
  end;
end;

procedure TfrmCadTransportadoras.btnAdicionarCttClick(Sender: TObject);
begin
  inherited;
  {*******************************************}
  {* COLOQUEI AQUI PARA VALIDAR O NOME.      *}
  {* SE OLHAR NO VALIDA, VAI ENTENDER PORQUE *}
  {****************************************JB*}
  Try
    objTraCtt.strNomCtt := edtNomCtt.Text;
  Except
    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadTransportadoras.btnAdicionarCttClick]');                               	
      If edtNomCtt.Enabled Then
        pSetFocus(edtNomCtt);
      Exit;
    End;
  End;

  If (fValidaPanel(pnlContatos, True)) Then
  Begin
    pAdicionaContatoCds(objTraCtt);
    btnCancelaCtt.Click;
    blnAltContato := False;
  End;
end;

procedure TfrmCadTransportadoras.dbgContatosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (pnlContatos.Enabled) Then
  Begin
    If (Not cdsTraCtt.IsEmpty) And ((qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert)) Then
    Begin
      If cdsTraCtt.RecordCount = 1 Then
        pAtualizaEditsContato(Nil);

      pCarregaContatoAlteracao;
    End;
  End
  Else If (Key = VK_DELETE) And (pnlContatos.Enabled) Then
  Begin
    If (Not cdsTraCtt.IsEmpty) And (Not dbgContatos.ReadOnly) Then
    Begin
      If fMensagem('ATENÇÃO','Confirma excluir contato "' +
         cdsTraCtt.FieldByName('NOMCTT').AsString + '" ?',['','']) = 1 then
      Begin
        lstContatos.Remove(lstContatos[cdsTraCtt.RecNo-1]);
        cdsTraCtt.Delete;
      End;  
    End
    Else
    Begin
      pnlContatos.Enabled := True;
      dbgContatos.ReadOnly := True;
      pLimpaEditsContatos;
    End;
  End
  Else If (Key = VK_ESCAPE) And (qryTabela.State = dsEdit) And (pnlContatos.Enabled) Then
  Begin
    pnlContatos.Enabled := True;
    dbgContatos.ReadOnly := True;
    btnCancelaCtt.Click;
    If edtNomCtt.Enabled Then
      pSetFocus(edtNomCtt);
  End;
end;

procedure TfrmCadTransportadoras.drgTipEtqChange(Sender: TObject);
begin
  inherited;
  pnlEtqDados.Visible := (drgTipEtq.ItemIndex > 0);
end;

procedure TfrmCadTransportadoras.btnGravarClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If (Not fValidouPreenchimentoOpcoesRateio(qryTabela.FieldByName('TRA_FREVEN').AsString)) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If fEmptyStr(qryTabela.FieldByName('TRA_SERCOR').AsString) Then
      qryTabela.FieldByName('TRA_SERCOR').Clear;

    If (not dbeCodEmpRespConh.Enabled) Then
      qryTabela.FieldByName('TRA_EMPRES').Clear;

  if cbbEtiquetaDespacho.ItemIndex >= 0 then
    qryTabela.FieldByName('TRA_ETIDES').AsString  := cbbEtiquetaDespacho.Text;

  if (cbbEtiquetaDespacho.Text = 'JADLOG') and (cbbModJadLog.Visible) and (cbbModJadLog.ItemIndex > 0) then
    qryTabela.FieldByName('TRA_MODJED').AsInteger := MODALIDADE_JADLOG[cbbModJadLog.ItemIndex-1]
  else
    qryTabela.FieldByName('TRA_MODJED').Clear;

  if gpbPadraoCTe.Enabled then
  begin
    qryTabela.FieldByName('TRA_CFOP__').AsString := edtCFOP.Text;
    If qryTabela.FindField('TRA_CFOPJU') <> Nil Then
      qryTabela.FieldByName('TRA_CFOPJU').AsString := edtCFOPJU.Text;
    qryTabela.FieldByName('TRA_NATOPE').AsString := edtNaturezaOp.Text;
    qryTabela.FieldByName('TRA_SERIE_').AsString := edtSerie.Text;
    qryTabela.FieldByName('TRA_TOMSER').AsString := cmbTomadorServ.Text;
    qryTabela.FieldByName('TRA_CLATRI').AsString := cmbCodigoClassTrib.Text;
    qryTabela.FieldByName('TRA_PROPRE').AsString := edtProdutoPredom.Text;
    qryTabela.FieldByName('TRA_DESSER').AsString := edtDescricaoServ.Text;
    qryTabela.FieldByName('TRA_RNTRC_').AsString := edtRNTRC.Text;
    qryTabela.FieldByName('TRA_CODPOR').AsString := edtCodPor.Text;
    qryTabela.FieldByName('TRA_PLCTPG').AsString := fraPlanoDeContasPga.MskCodCta.Text;
    qryTabela.FieldByName('TRA_CNDPAG').AsString := mskConPagPagar.Text;
    qryTabela.FieldByName('TRA_PLCTRC').AsString := fraPlanoDeContasRec.MskCodCta.Text;
    qryTabela.FieldByName('TRA_CNDREC').AsString := mskConPagReceber.Text;
    qryTabela.FieldByName('TRA_ALIQUO').AsFloat  := fStrToFloat(edtAliquota.Text);
  end;

    inherited;
    If (blnGravou) Then
    Begin
      Try
        if blnTemDivergenciaSefaz then
          pSalvaDataConsultaSefaz('CADTRA', 'TRA_DTASEF', qryTabela.FieldByName('AUTOINCREM').AsString, fRetDataServidor);

        pLimpaEditsContatos;
        TTraCtt.pApagarCadCtt(qryTabela.FieldByName('TRA_CODTRA').AsString);
        For intContador := 0 To lstContatos.Count -1 Do
        Begin
          TTraCtt(lstContatos[intContador]).strCodTra := qryTabela.FieldByName('TRA_CODTRA').AsString;
          TTraCtt(lstContatos[intContador]).pInsereTraCtt;
        End;

        fGravaCorTra;
        pGravarDadosTiposDeFreteDoRateio(qryTabela.FieldByName('TRA_CODTRA').AsString);
        pGravarDadosTiposDeFretePermitido(qryTabela.FieldByName('TRA_CODTRA').AsString);

        fCommit;
        dbgContatos.ReadOnly := True;
        pnlContatos.Enabled  := False;

        btnCadClientes.Enabled := False;
        btnCadFor.Enabled := False;
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pCarregaContatos(qryTabela.FieldByName('TRA_CODTRA').AsString);
          pCarregarDadosTiposDeFreteDoRateio(qryTabela.FieldByName('TRA_CODTRA').AsString, qryTabela.FieldByName('TRA_FREVEN').AsString);
          pCarregarDadosTiposDeFretePermitido(qryTabela.FieldByName('TRA_CODTRA').AsString);

          pMensagensErro('Não foi possível inserir os contatos da Transportadora!' + E.Message,
                         '[Inserção de Contatos]');
        End;
      End;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadTransportadoras.btnGravarClick]');
    End;
  End;
  pSetarStatusListaOpcoesRateioFrete;
  pgcDados.ActivePageIndex := 0;
  btnConsultaFit.Enabled := False;
  pAjustaDefaultTipoFretePermitido(True);
end;

procedure TfrmCadTransportadoras.edtCidCttKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCidCtt, edtDesCidCtt, edtEstadoCtt, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCidCtt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.edtCidCttKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If fChamaCadCid(Key) <> NULL Then
    qryConCid := qryCadCid;
end;

procedure TfrmCadTransportadoras.edtCodLayJadKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayoutEtiquetaDespacho(Self, edtCodLayJad, edtLayJad, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodLayJad, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.edtCodPorKeyPress(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPor) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.edtLayoutImpressaoMandaeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayoutEtiquetaDespacho(Self, edtLayoutImpressaoMandae, edtNomeLayoutImpressaoMandae, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtLayoutImpressaoMandae, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadTransportadoras.dbgContatosEnter(Sender: TObject);
begin
  inherited;
  If cdsTraCtt.RecordCount > 0 Then
    cdsTraCtt.First;
end;

procedure TfrmCadTransportadoras.dbeNumCepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
     Key := #0;

    dbeNumCep.Text := fConsultarCep(Self,dbeNumCep.Text,
                          dbeNumCep);
                          //qryConCid.FieldByName('CID_ESTADO').AsString,
                          //qryConCid.FieldByName('CID_CODCOR').AsString,
                          //qryConCid.FieldByName('CID_NOMCID').AsString);

  End;
end;

procedure TfrmCadTransportadoras.dbeNumCgcChange(Sender: TObject);
begin
  inherited;
  blnJaValidouTravaCnpjCpf := False;
end;

procedure TfrmCadTransportadoras.dbeSeqIniExit(Sender: TObject);
begin
  inherited;
  If (blnAlterou) Then
  Begin
    dbeSeqIni.Text := fStrZero(dbeSeqIni.Text, dbeSeqIni.Field.Size);
    If StrToIntDef(dbeSeqIni.Text, 0) <> intSeqIni Then
    Begin
      If fMensagem('','Deseja iniciar um novo sequêncial?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        dbeSeqFin.ReadOnly := False;
        dbeSeqFin.TabStop  := True;

        dbeSiglaS.ReadOnly := False;
        dbeSiglaS.TabStop  := True;

        dbeSiglaP.ReadOnly := False;
        dbeSiglaP.TabStop  := True;

        dbeSeqFin.Clear;
        dbeSeqAtu.Field.AsString := dbeSeqIni.Text;
        dbeSeqAtu.Text := dbeSeqIni.Text;

        intSeqIni := StrToIntDef(dbeSeqIni.Text, 0);
        pSetFocus(dbeSeqFin);
      End
      Else
      Begin
        dbeSeqIni.Field.AsString := fStrZero(IntToStr(intSeqIni),8);
        pSetFocus(dbeSeqIni);
      End;
    End;
  End;
end;


procedure TfrmCadTransportadoras.dbeTranspHabFEExit(Sender: TObject);
begin
  inherited;
  dbeCodEmpRespConh.Enabled := (dbeTranspHabFE.Text = 'S');
  if (not dbeCodEmpRespConh.Enabled) then
  begin
    dbeCodEmpRespConh.Clear;
    edtDesEmpRespConh.Clear;
  end;
  gpbPadraoCTe.Enabled := dbeCodEmpRespConh.Enabled;
  gpbFinanceiro.Enabled := gpbPadraoCTe.Enabled;
end;

procedure TfrmCadTransportadoras.pCarregaSequenciaAtual;
begin
  intSeqIni := StrToIntDef(dbeSeqIni.Text, 0);
  intSeqFin := StrToIntDef(dbeSeqFin.Text, 0);

  dbeSeqFin.ReadOnly := True;
  dbeSeqFin.TabStop  := False;

  dbeSiglaS.ReadOnly := True;
  dbeSiglaS.TabStop  := False;

  dbeSiglaP.ReadOnly := True;
  dbeSiglaP.TabStop  := False;

end;

procedure TfrmCadTransportadoras.pCarregaLayout(AedtCodigo : TDBEditFocus; AedtDescricao : TEditFocus);
  var
    qryLayEti : TUniQuery;
Begin
  Try
    qryLayEti := fCriaQuery;
    With qryLayEti, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT CAST(CONCAT(LAY_DTAALT, " ", LAY_HORALT ) AS DATETIME) AS ULTALT, ');
      Add('        LAY_DESCRI          ');
      Add(' FROM LAYETI                ');
      Add(' WHERE LAY_CODLAY = :CODLAY ');
      Add(' AND LAY_CODEMP = :CODEMP ');

      ParamByName('CODLAY').AsString := AedtCodigo.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      AedtDescricao.Text := FieldByName('LAY_DESCRI').AsString;

      if AedtCodigo = dbeLayEtq then
      Begin
        If (not qryLayEti.FieldByName('ULTALT').IsNull) And (FieldByName('ULTALT').AsDateTime > 0) Then
          edtDtaLay.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', FieldByName('ULTALT').AsDateTime)
        Else
          edtDtaLay.Clear;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryLayEti);
  End;
End;

procedure TfrmCadTransportadoras.pCarregaPadraoCTe;
begin
  edtCFOP.Text                 := qryTabela.FieldByName('TRA_CFOP__').AsString;
  If qryTabela.FindField('TRA_CFOPJU') <> Nil Then
    edtCFOPJU.Text               := qryTabela.FieldByName('TRA_CFOPJU').AsString;
  edtNaturezaOp.Text           := qryTabela.FieldByName('TRA_NATOPE').AsString;
  edtSerie.Text                := qryTabela.FieldByName('TRA_SERIE_').AsString;
  cmbTomadorServ.ItemIndex     := cmbTomadorServ.Items.IndexOf(qryTabela.FieldByName('TRA_TOMSER').AsString);
  cmbCodigoClassTrib.ItemIndex := cmbCodigoClassTrib.Items.IndexOf(qryTabela.FieldByName('TRA_CLATRI').AsString);
  edtProdutoPredom.Text        := qryTabela.FieldByName('TRA_PROPRE').AsString;
  edtDescricaoServ.Text        := qryTabela.FieldByName('TRA_DESSER').AsString;
  edtRNTRC.Text                := qryTabela.FieldByName('TRA_RNTRC_').AsString;
  edtCodPor.Text               := qryTabela.FieldByName('TRA_CODPOR').AsString;
  edtNomPor.Text               := fRetNomPortador(edtCodPor.Text);
  fraPlanoDeContasPga.MskCodCta.Text := qryTabela.FieldByName('TRA_PLCTPG').AsString;
  fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);
  mskConPagPagar.Text          := qryTabela.FieldByName('TRA_CNDPAG').AsString;
  fraPlanoDeContasRec.MskCodCta.Text := qryTabela.FieldByName('TRA_PLCTRC').AsString;
  fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);
  mskConPagReceber.Text        := qryTabela.FieldByName('TRA_CNDREC').AsString;
  edtAliquota.Text             := FloatToStrF(qryTabela.FieldByName('TRA_ALIQUO').AsFloat, ffFixed, 12, 2);
end;

procedure TfrmCadTransportadoras.pAbreCorTra;
Begin
  cdsCorTra.qryQuery.Close;
  cdsCorTra.qryQuery.ParamByName('CODTRA').AsString := qryTabela.FieldByName('TRA_CODTRA').AsString;
  cdsCorTra.fAbreClient(True, 'TfrmCadTransportadoras.pAbreCorTra');
End;

class function TfrmCadTransportadoras.fCadastroRapidoTransportadora(var strCodTra: string;
                                                                    strNomTra,
                                                                    strNomFan,
                                                                    strEndere,
                                                                    strBairro,
                                                                    strCodCid,
                                                                    strNumCep,
                                                                    strFone01,
                                                                    strEmail,
                                                                    strNumCgc,
                                                                    strFone02,
                                                                    strInsEst,
                                                                    strHomPag: string;
                                                                    intCgcCpf: integer): Boolean;
var
  qryCadTra: TUniQuery;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADTRA', 'TRA_CODTRA');
  end;
begin
  Result := False;
  fStartTransaction;

  if (fEmptyStr(strCodTra)) then
  begin
    qryCadTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE');
  end
  else
  begin
    qryCadTra := fCriarQuery('SELECT * FROM CADTRA WHERE TRA_CODTRA = ' + QuotedStr(strCodTra));
  end;

  try
    try
      qryCadTra.Open;

      if (fEmptyStr(strCodTra)) then
      begin
        if (fUsaProCodigo('CADTRA')) then
        begin
          strCodTra := fProximoCodigo;
        end;

        qryCadTra.Append;

        qryCadTra.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADTRA', VS_strCodEmp);
        qryCadTra.FieldByName('TRA_CODEMP').AsString   := VS_strCodEmp;
        qryCadTra.FieldByName('TRA_DTACAD').AsDateTime := VS_Date;
        qryCadTra.FieldByName('TRA_PRIEXP').AsInteger  := 0;
        qryCadTra.FieldByName('TRA_VALFRE').AsFloat    := 0;
        qryCadTra.FieldByName('TRA_FREVEN').AsString   := 'D';
        qryCadTra.FieldByName('TRA_PROFRE').AsString   := 'D';
        qryCadTra.FieldByName('TRA_CNHREC').AsString   := 'S';
      end
      else
      begin
        qryCadTra.Edit;
      end;

      qryCadTra.FieldByName('TRA_CODTRA').AsString  := strCodTra;
      qryCadTra.FieldByName('TRA_NOMTRA').AsString  := strNomTra;
      qryCadTra.FieldByName('TRA_NOMFAN').AsString  := strNomFan;
      qryCadTra.FieldByName('TRA_ENDERE').AsString  := strEndere;
      qryCadTra.FieldByName('TRA_BAIRRO').AsString  := strBairro;
      qryCadTra.FieldByName('TRA_CODCID').AsString  := strCodCid;
      qryCadTra.FieldByName('TRA_C_E_P_').AsString  := fTiraCaracEspeciais(strNumCep);
      qryCadTra.FieldByName('TRA_FONE01').AsString  := fTiraCaracEspeciais(strFone01);
      qryCadTra.FieldByName('TRA_EMAIL_').AsString  := strEmail;
      qryCadTra.FieldByName('TRA_C_G_C_').AsString  := strNumCgc;
      qryCadTra.FieldByName('TRA_FONE02').AsString  := fTiraCaracEspeciais(strFone02);
      qryCadTra.FieldByName('TRA_HOMEPA').AsString  := strHomPag;
      qryCadTra.FieldByName('TRA_I_E_S_').AsString  := strInsEst;
      qryCadTra.FieldByName('TRA_CGCCPF').AsInteger := intCgcCpf;

      qryCadTra.Post;

      fCommit;

      Result := True;
    except
      on E: Exception do
      begin
        fRollBack;
        pMensagensErro(E.message, '');
      end;
    end;
  finally
    FreeAndNil(qryCadTra);
  end;
end;

function TfrmCadTransportadoras.fGetSQLCorTra : String;
Begin
  Result := '';
  Result := Result + ' SELECT CFG_CODEMP AS CODEMP, ';
  Result := Result + '        TRA_CODSER AS CODSER, ';
  Result := Result + '        CSE_DESCRI AS DESCRI, ';
  Result := Result + '        CORSER.AUTOINCREM     ';
  Result := Result + ' FROM CORCFG                                    ';
  Result := Result + '   LEFT JOIN CORTRA ON TRA_CODEMP = CFG_CODEMP  ';
  Result := Result + '                   AND TRA_CODTRA = :CODTRA     ';
  Result := Result + '   LEFT JOIN CORSER ON CSE_CODIGO = TRA_CODSER  ';
  Result := Result + ' WHERE CFG_STATUS = "A"                         ';
  Result := Result + ' ORDER BY CFG_CODEMP                            ';
End;

function TfrmCadTransportadoras.fGravaCorTra : Boolean;
  Var
    qryCorTra : TUniQuery;
Begin
  Result := True;
  qryCorTra := fCriaQuery;
  Try
    With qryCorTra, SQL Do
    Begin
      Close;
      Clear;
      Add(' DELETE FROM CORTRA WHERE TRA_CODTRA = :CODTRA ');
      ParamByName('CODTRA').AsString := qryTabela.FieldByName('TRA_CODTRA').AsString;
      ExecSQL;

      Close;
      Clear;
      Add(' INSERT INTO CORTRA (AUTOINCREM, TRA_CODTRA, TRA_CODEMP, TRA_CODSER ) ');
      Add(' VALUES (:AUTINC, :CODTRA, :CODEMP, :CODSER) ');

      cdsCorTra.First;
      While Not cdsCorTra.Eof Do
      Begin
        If not fEmptyStr(cdsCorTra.FieldByName('CODSER').AsString) Then
        Begin
          ParamByName('AUTINC').AsString := fRetAutoIncrem('CORTRA', cdsCorTra.FieldByName('CODEMP').AsString);
          ParamByName('CODTRA').AsString := qryTabela.FieldByName('TRA_CODTRA').AsString;
          ParamByName('CODEMP').AsString := cdsCorTra.FieldByName('CODEMP').AsString;
          ParamByName('CODSER').AsString := cdsCorTra.FieldByName('CODSER').AsString;
          ExecSQL;
        End;
        cdsCorTra.Next;
      End;

    End;

  Finally
    FreeAndNil(qryCorTra);
  End;

End;

function TfrmCadTransportadoras.fInformaAtividade: string;
var
  frmAtividadeLocal: TfrmAtividades;
  strCodAti: string;
begin
  Result := EmptyStr;

  pCriarFormularios(TfrmAtividades, frmAtividadeLocal);
  try
    frmAtividadeLocal.ShowModal;
    begin
      strCodAti := frmAtividadeLocal.edtCodAti.Text;

      if (not fEmptyStr(strCodAti)) then
      begin
        Result := strCodAti;
      end;
    end;
  finally
    pFreeAndNil(frmAtividadeLocal);
  end;

end;

function TfrmCadTransportadoras.fNenhumTipoFretePermitidoSelecionado: Boolean;
Var
  LIntCnt : Integer;
  LIndexChecked: Integer;
begin
  LIndexChecked := -1;
  For LIntCnt := 0 To Pred(cklTipoFretePermitido.Count) Do
  Begin
    If Not cklTipoFretePermitido.Checked[LIntCnt] Then
      Continue;

    LIndexChecked := LIntCnt;
    Break;
  End;

  Result := (LIndexChecked < 0);
end;

procedure TfrmCadTransportadoras.rdgFreVenClick(Sender: TObject);
begin
  inherited;
  pSetarStatusListaOpcoesRateioFrete;
end;

procedure TfrmCadTransportadoras.pSetarStatusListaOpcoesRateioFrete;
begin
  cklOpcoesRateioFrete.Enabled := (rdgFreVen.ItemIndex = 1) And (qryTabela.State in [dsInsert, dsEdit]);
end;

procedure TfrmCadTransportadoras.cklOpcoesRateioFreteClickCheck(
  Sender: TObject);
begin
  inherited;
  pOnChechUncheckOpcoesRateioFrete;
end;

procedure TfrmCadTransportadoras.cklTipoFretePermitidoClick(Sender: TObject);
begin
  inherited;

  pAjustaTipoFretePermitido;

end;

procedure TfrmCadTransportadoras.pObrigarPreenchimentoTipoFretePermitido;
begin
  If fValidaCampos(cklTipoFretePermitido, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadTransportadoras.pOnChechUncheckOpcoesRateioFrete;
  Var
    intIndexChecked : Integer;
    intCnt : Integer;
begin
  intIndexChecked := -1;
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
  Begin
    If Not cklOpcoesRateioFrete.Checked[intCnt] Then
      Continue;
    intIndexChecked := intCnt;
    Break;
  End;
  If (intIndexChecked = 0) Then
    pMarcarOpcaoTodosTiposdeFreteDoRateio
  Else If (intIndexChecked > 0) Then
    pBloquearOpcaoTodosOsTiposDeFreteDoRateio
  Else
    pLiberarTodasOpcoesTiposDeFreteDoRateio;
end;

procedure TfrmCadTransportadoras.pLiberarTodasOpcoesTiposDeFreteDoRateio;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
  Begin
    cklOpcoesRateioFrete.Checked[intCnt] := False;
    cklOpcoesRateioFrete.ItemEnabled[intCnt] := True;
  End;
end;

procedure TfrmCadTransportadoras.pCarregaOpcoesTiposDeFrete;
begin
  cklTipoFretePermitido.Items.Clear;
  cklTipoFretePermitido.Items.Add('Todos os tipos de frete');
  pCarregarDescricaoFrete(cklTipoFretePermitido.Items);
end;

procedure TfrmCadTransportadoras.pCarregaOpcoesTiposDeFreteDoRateio;
begin
  cklOpcoesRateioFrete.Items.Clear;
  cklOpcoesRateioFrete.Items.Add('Todos os tipos de frete');
  pCarregarDescricaoFrete(cklOpcoesRateioFrete.Items);
end;

procedure TfrmCadTransportadoras.pMarcarOpcaoTodosTiposdeFreteDoRateio;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
  Begin
    cklOpcoesRateioFrete.Checked[intCnt] := IIF(intCnt = 0, True, False);
    cklOpcoesRateioFrete.ItemEnabled[intCnt] := IIF(intCnt = 0, True, False);
  End;
end;

procedure TfrmCadTransportadoras.pBloquearOpcaoTodosOsTiposDeFreteDoRateio;
  Var
    intCnt : Integer;
begin
  cklOpcoesRateioFrete.Checked[0] := False;
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
    cklOpcoesRateioFrete.ItemEnabled[intCnt] := IIF(intCnt = 0, False, True);
end;

procedure TfrmCadTransportadoras.pCarregarDadosTiposDeFreteDoRateio(const strCodTra : String; const strFreVen : String);
  Var
    dicTiposDeRateioFrete : TDictionary<TTiposDeRateioFrete, Integer>;
    LTiposDeRateioFrete : TTiposDeRateioFrete;
    strDescricaoFrete : String;
begin
  pCarregaOpcoesTiposDeFreteDoRateio;
  If (strFreVen = 'D') Then
    Exit;
  dicTiposDeRateioFrete := objTiposDeRateioFreteDAO.GetTiposDeRateioFrete(strCodTra);
  Try
    If (dicTiposDeRateioFrete.Count = 0) Then
    Begin
      pMarcarOpcaoTodosTiposDeFreteDoRateio;
      Exit;
    End;
    For LTiposDeRateioFrete In dicTiposDeRateioFrete.Keys Do
    Begin
      If (LTiposDeRateioFrete = trfTodos) Then
      Begin
        pMarcarOpcaoTodosTiposDeFreteDoRateio;
        Exit;
      End
      Else
      Begin
        strDescricaoFrete := fDescricaoFrete(dicTiposDeRateioFrete[LTiposDeRateioFrete].ToString());
        cklOpcoesRateioFrete.Checked[cklOpcoesRateioFrete.Items.IndexOf(strDescricaoFrete)] := True;
        pBloquearOpcaoTodosOsTiposDeFreteDoRateio;
      End;
    End;
  Finally
    FreeAndNil(dicTiposDeRateioFrete)
  End;
end;

procedure TfrmCadTransportadoras.pCarregarDadosTiposDeFretePermitido(
  const ACodTra: String);
Var
  LDicTiposFrete : TDictionary<TTiposDeFrete, Integer>;
  LTiposDeFrete : TTiposDeFrete;
  LDescricaoFrete : String;
begin
  pCarregaOpcoesTiposDeFrete;

  LDicTiposFrete := objTiposDeFretePermitidosDAO.GetTiposFrete(ACodTra);
  Try
    For LTiposDeFrete In LDicTiposFrete.Keys Do
    Begin
      If (LTiposDeFrete = tfpTodos) Then
      Begin
        pAjustaDefaultTipoFretePermitido(True);
        Exit;
      End
      Else
      Begin
        LDescricaoFrete := fDescricaoFrete(LDicTiposFrete[LTiposDeFrete].ToString());
        cklTipoFretePermitido.Checked[cklOpcoesRateioFrete.Items.IndexOf(LDescricaoFrete)] := True;
      End;
    End;
  Finally
    FreeAndNil(LDicTiposFrete)
  End;
end;

procedure TfrmCadTransportadoras.pGravarDadosTiposDeFreteDoRateio(const strCodTra : String);
  Var
    intCnt : Integer;
    strTipoFrete : String;
    arrTipFre : TIntArray;
begin
  SetLength(arrTipFre, 0);
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
  Begin
    If Not cklOpcoesRateioFrete.ItemEnabled[intCnt] Then
      Continue;
    If Not cklOpcoesRateioFrete.Checked[intCnt] Then
      Continue;

    If (intCnt = 0) And (cklOpcoesRateioFrete.Checked[intCnt]) Then
      Break;

    strTipoFrete := fTipoFrete(cklOpcoesRateioFrete.Items[intCnt]);
    If fEmptyStr(strTipoFrete) Then
      Continue;

    SetLength(arrTipFre, Succ(Length(arrTipFre)));
    arrTipFre[Pred(Length(arrTipFre))] := StrToInt(strTipoFrete);
  End;
  objTiposDeRateioFreteDAO.GravarTiposDeRateioFrete(strCodTra, arrTipFre);
end;

procedure TfrmCadTransportadoras.pGravarDadosTiposDeFretePermitido(
  const ACodTra: String);
Var
  LIntCnt : Integer;
  LTipoFrete : String;
  arrTipFre : TIntArray;
begin
  SetLength(arrTipFre, 0);
  For LIntCnt := 0 To Pred(cklTipoFretePermitido.Count) Do
  Begin
    If Not cklTipoFretePermitido.ItemEnabled[LIntCnt] Then
      Continue;

    If Not cklTipoFretePermitido.Checked[LIntCnt] Then
      Continue;

    If (LIntCnt = 0) And (cklTipoFretePermitido.Checked[LIntCnt]) Then
      Break;

    LTipoFrete := fTipoFrete(cklTipoFretePermitido.Items[LIntCnt]);
    If fEmptyStr(LTipoFrete) Then
      Continue;

    SetLength(arrTipFre, Succ(Length(arrTipFre)));
    arrTipFre[Pred(Length(arrTipFre))] := StrToInt(LTipoFrete);
  End;

  objTiposDeFretePermitidosDAO.GravarTiposDeFrete(ACodTra, arrTipFre);
end;

function TfrmCadTransportadoras.fValidouPreenchimentoOpcoesRateio(const strFreVen : String): Boolean;
  Var
    intCnt : Integer;
begin
  Result := True;
  If (strFreVen = 'D') Then
    Exit;
  For intCnt := 0 To Pred(cklOpcoesRateioFrete.Count) Do
  Begin
    If cklOpcoesRateioFrete.Checked[intCnt] Then
      Exit(True);
  End;
  fMensagem('ATENÇÃO!', 'Quando (Frete na Venda) estiver selecionado como (Rateio) é necessário marcar ao menos uma opção', ['&OK']);
  pSetFocus(cklOpcoesRateioFrete);
  Result := False;
end;

end.

