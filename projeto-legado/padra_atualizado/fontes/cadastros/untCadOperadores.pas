{***************************}
{* qryConCid -> CADCID     *}
{* qryConFor -> CADFOR     *}
{* qryConEmp -> CADEMP     *}
{************************JB*}
{***************************}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadOperadores;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, EditFocus, Menus, Uni, AppEvnts, QColorLabel,
  CheckLst, UniClientDataSet, DB, untFuncoesGenerica, untLabelCpf, untLabelRg,
  untDBECgcCpf, BitBtnLockedIncrem, DBLookupComboBoxFocus, UniDataSetProvider,
  frxClass, frxExportCSVTestabilidade, Vcl.Grids, Vcl.DBGrids, CurrencyEditFocus,
  untComFor, Winapi.Windows, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit, DBGridCitel, MemoFocus,
  Vcl.Dialogs, Graphics, Jpeg, untTEnvioEmail,
  System.ImageList, Vcl.ImgList, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, cxCheckBox,
  cxTimeEdit, dxGDIPlusClasses, DBAccess, cxMaskEdit, cxDropDownEdit,
  cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox;

type
  TOpcSelecao = (opcMarcar, opcDesmarcar, opcInverter);

  TfrmCadOperadores = class(TfrmPaiCad)
    dtsTabela: TDataSource;
    btnComissao: TBitBtnLocked;
    btnMobile: TBitBtnLocked;
    dtsListTipVen: TDataSource;
    tsComissao: TTabSheet;
    GroupBox1: TGroupBox;
    gpbSubGer: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    dbeComCMF: TDBEditFocus;
    dbeComCFA: TDBEditFocus;
    dbeComCMA: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    lblLimCred: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label37: TLabel;
    ColorLabel1: TColorLabel;
    Label24: TLabel;
    lblCodDep: TLabel;
    LabelCpf1: TLabelCpf;
    LabelRg1: TLabelRg;
    lbl7: TLabel;
    edtEstado: TEditFocus;
    dbeCodOpe: TDBEditFocus;
    dbeNomOpe: TDBEditFocus;
    edtConSenha: TEditFocus;
    edtSenha: TEditFocus;
    dbeNomFan: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    dbeNumCep: TDBEditFocus;
    dbeDtaNas: TDBEditFocus;
    dbeDtaAdm: TDBEditFocus;
    dbeDtaDem: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeNumRg: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeObse01: TDBEditFocus;
    dbeObse02: TDBEditFocus;
    edtCidade: TEditFocus;
    dbeE_mail: TDBEditFocus;
    dbeLimCred: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    edtDesEmp: TEditFocus;
    dbeCodFor: TDBEditFocus;
    edtNomFor: TEditFocus;
    dbeStatus: TDBEditFocus;
    dbeCodDep: TDBEditFocus;
    edtDesDep: TEditFocus;
    dbeNumCPF: TDBEditCgcCpf;
    dbeNEXTEL: TDBEditFocus;
    dbeRamal1: TDBEditFocus;
    dbeRamal2: TDBEditFocus;
    dbeIntExt: TDBLookupComboBoxFocus;
    Label40: TLabel;
    Label46: TLabel;
    dbeCodSub: TDBEditFocus;
    edtDesSub: TEditFocus;
    dbeCodGer: TDBEditFocus;
    edtDesGer: TEditFocus;
    Label27: TLabel;
    dbeSalBas: TDBEditFocus;
    grpComMecanicos: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    dbeMecCIt: TDBEditFocus;
    dbeMecCSe: TDBEditFocus;
    tsFinanceiro: TTabSheet;
    pnlPortadores: TPanel;
    clbPortadores: TCheckListBox;
    pnlTitPor: TPanel;
    tbsComForEsp: TTabSheet;
    lbl20: TLabel;
    edtCodFor: TEditFocus;
    edtNomForn: TEditFocus;
    dbgForCom: TDBGridCitel;
    edtComFor: TCurrencyEditFocus;
    Label14: TLabel;
    dtsComFor: TDataSource;
    btnAddComFor: TBitBtnLocked;
    btnRemComFor: TBitBtnLocked;
    gpbBaixaPagar: TGroupBox;
    clbBaixaPagar: TCheckListBox;
    tbsAcessoEmp: TTabSheet;
    Panel1: TPanel;
    gpbEmpresaAcesso: TGroupBox;
    clbEmpresa: TCheckListBox;
    gpbEmpresaIncRom: TGroupBox;
    clbIncRom: TCheckListBox;
    gpbBaixaReceber: TGroupBox;
    clbBaixaReceber: TCheckListBox;
    gpbEmpresaLogin: TGroupBox;
    clbLogin: TCheckListBox;
    Label162: TLabel;
    dbeTpCoMc: TDBEditFocus;
    ColorLabel31: TColorLabel;
    lblMecCItPerVal: TLabel;
    lblMecCSePerVal: TLabel;
    grbComSerVen: TGroupBox;
    grbComSer: TGroupBox;
    Label17: TLabel;
    ColorLabel2: TColorLabel;
    Label26: TLabel;
    lblTpComSerVen: TLabel;
    dbeTpCoVn: TDBEditFocus;
    dbeVenCSe: TDBEditFocus;
    gpbEmpresaEstoque: TGroupBox;
    clbEmpEst: TCheckListBox;
    gpbComPro: TGroupBox;
    Label16: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl1: TLabel;
    dbePerCom: TDBEditFocus;
    dbePerCo2: TDBEditFocus;
    gpbComAti: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    dbeComAta: TDBEditFocus;
    dbeComVar: TDBEditFocus;
    dbeCom_SM: TDBEditFocus;
    tbsEmail: TTabSheet;
    grbProvedor: TGroupBox;
    dlgAssinatura: TOpenDialog;
    lblTipCli: TLabel;
    dbeTipCli: TDBEditFocus;
    clbTipCli: TColorLabel;
    imgValidacaoEmail: TImageList;
    tbsMensagensRecebidas: TTabSheet;
    lblMsgPos: TLabel;
    clbMsgPos: TColorLabel;
    chkMsgOrc: TDBCheckBox;
    chkMsgPed: TDBCheckBox;
    chkMsgTre: TDBCheckBox;
    chkMsgLib: TDBCheckBox;
    dbeMsgPos: TDBEditFocus;
    chkMsgETF: TDBCheckBox;
    dbeIteMin: TDBCheckBox;
    chkMsgSfa: TDBCheckBox;
    chkMsgPedAlt: TDBCheckBox;
    chkMsgPedCanc: TDBCheckBox;
    shpLimCred: TShape;
    lblPrazoMedioVenda: TLabel;
    dbePrazoMedioVenda: TDBEditFocus;
    lblLimCredA: TLabel;
    dbeLimCredA: TDBEditFocus;
    shpLimCredA: TShape;
    lblclbGeral: TLabel;
    lblclbLogin: TLabel;
    lblclbEmpresa: TLabel;
    lblclbIncRom: TLabel;
    lblclbBaixaReceber: TLabel;
    lblclbBaixaPagar: TLabel;
    lblclbEmpEst: TLabel;
    popOpSele: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    InverterSeleo1: TMenuItem;
    chkMsgLpa: TDBCheckBox;
    gpbEmpConsVendFatur: TGroupBox;
    lblclbEmpConsVendFatur: TLabel;
    clbEmpConsVendFatur: TCheckListBox;
    chkMsgTab: TDBCheckBox;
    chkMsgPdl: TDBCheckBox;
    chkMsgDfl: TDBCheckBox;
    chkMsgOrcCompra: TDBCheckBox;
    chbPermiteCreditoTransferencia: TDBCheckBox;
    dbeEmailsB2B: TDBEditFocus;
    lblEmailsB2B: TLabel;
    dbeInformarSenhaLiberacao: TDBEditFocus;
    shpInformarSenhaLiberacao: TShape;
    lblInformarSenhaLiberacao: TLabel;
    tbsPermissaoHorariosOperacaoSistema: TTabSheet;
    pnlPerHorOpeSis_Cabecalho: TPanel;
    pnlPerHorOpeSis: TPanel;
    cxPermissaoHorarios: TcxGrid;
    cxTblPermissaoHorarios: TcxGridDBTableView;
    cxPermissaoHorariosLvl: TcxGridLevel;
    cdsHorOpe: TUniClientDataSet;
    cdsHorOpeDIASEM: TStringField;
    cdsHorOpeRESACE: TStringField;
    cdsHorOpeRESVEN: TStringField;
    cdsHorOpeHINI_1: TTimeField;
    cdsHorOpeHFIN_1: TTimeField;
    cdsHorOpeHINI_2: TTimeField;
    cdsHorOpeHFIN_2: TTimeField;
    cxTblPermissaoHorariosDIASEM: TcxGridDBColumn;
    dtsHorOpe: TDataSource;
    cxTblPermissaoHorariosRESACE: TcxGridDBColumn;
    cxTblPermissaoHorariosRESVEN: TcxGridDBColumn;
    cxTblPermissaoHorariosHINI_1: TcxGridDBColumn;
    cxTblPermissaoHorariosHFIN_1: TcxGridDBColumn;
    cxTblPermissaoHorariosHINI_2: TcxGridDBColumn;
    cxTblPermissaoHorariosHFIN_2: TcxGridDBColumn;
    lblTabPre: TLabel;
    dbeTabPre: TDBEditFocus;
    clbTabPre: TColorLabel;
    chkUtiDef: TDBCheckBox;
    cdsHorOpeAUTINC: TStringField;
    pnlPerHorOpeSis_Rodape: TPanel;
    Label41: TLabel;
    Label42: TLabel;
    dbeCodCax: TDBEditFocus;
    edtDesCaixa: TEditFocus;
    chkMensagemPrevisionamentoCTP: TDBCheckBox;
    chkMsgCVA: TDBCheckBox;
    chkMsgPrj: TDBCheckBox;
    tbsColetor: TTabSheet;
    GroupBox2: TGroupBox;
    lblClbEmpresasNotificacaoColetor: TLabel;
    clbEmpresasNotificacaoColetor: TCheckListBox;
    grbRotinaFlex: TGroupBox;
    Label44: TLabel;
    Label45: TLabel;
    dbePEEMFL: TDBEditFocus;
    dbePEOPFL: TDBEditFocus;
    chkMsgGNR: TDBCheckBox;
    chkMsgCRM: TDBCheckBox;
    gpbEmpLibRemota: TGroupBox;
     chkPEDMLT: TDBCheckBox;
    lblclbEmpLibRemota: TLabel;
    clbEmpLibRemota: TCheckListBox;
    lblMatricula: TLabel;
    dbeMatricula: TDBEditFocus;
    chkIgMsgL: TDBCheckBox;
    chkMensagensPix: TDBCheckBox;
    chkDMEFEM: TDBCheckBox;
    chkMngCad: TDBCheckBox;
    chkMSGDIV: TDBCheckBox;
    chkCertificadosPix: TDBCheckBox;
    grpComAssTec: TGroupBox;
    pnlComAte: TPanel;
    Label43: TLabel;
    dbeComATe: TDBEditFocus;
    Label47: TLabel;
    dbgOpeTec: TDBGridCitel;
    pnlTecnico: TPanel;
    lblNomTec: TLabel;
    edtCodTec: TEditFocus;
    edtNomTec: TEditFocus;
    btnAdicionaTec: TBitBtnLocked;
    dtsOpeATe: TDataSource;
    lblclbPortadores: TLabel;
    chkSinalSonoro: TDBCheckBox;
    chkContratoLocVencer: TDBCheckBox;
    tbsWhatsapp: TTabSheet;
    gpbCitelDesk: TGroupBox;
    lblIDCIDE: TLabel;
    dbeIdCiDe: TDBEditFocus;
    chkMsgReqCompIncluida: TDBCheckBox;
    gpbFilas: TGroupBox;
    rdgUsaFil: TDBRadioGroup;
    lkpFilaEnvio: TDBLookupComboBoxFocus;
    Label48: TLabel;
    dbeCodBar: TDBEditFocus;
    Label25: TLabel;
    lblNumWpp: TLabel;
    dbeNumWpp: TDBEditFocus;
    imgNumWpp: TImage;
    grpMltLjs: TGroupBox;
    lblclbEmpMltLjs: TLabel;
    clbEmpMltLjs: TCheckListBox;
    btnHlpLogin: TSpeedButton;
    btnHlpEmpresa: TSpeedButton;
    btnHlpRom: TSpeedButton;
    btnHlpBaixaReceber: TSpeedButton;
    btnHlpBaixaPagar: TSpeedButton;
    btnHlpEmpEst: TSpeedButton;
    btnHlpConsVendFutur: TSpeedButton;
    btnHlpLibRemota: TSpeedButton;
    btnHlpEmpMltLjs: TSpeedButton;
    lblAutSenhaOpe: TLabel;
    dbeAutSenhaOpe: TDBEditFocus;
    grpEstMin: TGroupBox;
    lblclbEmpEstMin: TLabel;
    clbEmpEstMin: TCheckListBox;
    btnHlpEmpEstMin: TSpeedButton;
    btnHeranca: TBitBtnLocked;
    gpbEmpReimpressaoDocs: TGroupBox;
    lblclbEmpReimpressaoDocs: TLabel;
    btnHlpReimpressaoDocs: TSpeedButton;
    clbEmpReimpressaoDocs: TCheckListBox;
    pnlPortifolioContele: TPanel;
    lblIdPortifolioContele: TLabel;
    btnPortifolioContele: TBitBtnLocked;
    dbeIdPortifolioContele: TDBEditFocus;
    chkMsgMedAtrasoClientes: TDBCheckBox;
    pnlEmails: TPanel;
    dbgEmails: TDBGridCitel;
    pnlEmailTop: TPanel;
    Label21: TLabel;
    lblProvedor: TLabel;
    Label34: TLabel;
    Label39: TLabel;
    lblSenhaEmail: TLabel;
    edtSenhaEmail: TEditFocus;
    chkMostrarSenha: TCheckBox;
    btnValidarDadosEmail: TBitBtnLocked;
    pnlValidaDadosConta: TPanel;
    btnDadosSmtp: TSpeedButton;
    btnDadosImap: TSpeedButton;
    btnAutenticacaoSmtp: TSpeedButton;
    btnAjudaProvedores: TBitBtnLocked;
    btnLimparDadosProvedor: TBitBtnLocked;
    grbEmailEmps: TGroupBox;
    lblEmailOpc: TLabel;
    btnEmailHelp: TSpeedButton;
    clbEmailEmps: TCheckListBox;
    pnlEmailCenter: TPanel;
    grbAssinaturaEmail: TGroupBox;
    grbAssinaturaTexto: TGroupBox;
    mmoAssinatura: TMemoFocus;
    grbAssinaturaImagem: TGroupBox;
    imgAssinatura: TImage;
    pnlBotoesAssinatura: TPanel;
    btnAdicionarAssinatura: TBitBtnLocked;
    btnLimparAssinatura: TBitBtnLocked;
    pnlEmailBottom: TPanel;
    btnEmailAdd: TBitBtnLocked;
    btnEmailCan: TBitBtnLocked;
    dtsOpeEml: TUniDataSource;
    cdsOpeEml: TUniClientDataSet;
    cdsOpeEmlEML_E_NOME: TStringField;
    cdsOpeEmlEML_CODPRV: TStringField;
    cdsOpeEmlEML_E_MAIL: TStringField;
    cdsOpeEmlEML_EMALOG: TStringField;
    cdsOpeEmlEML_PRVSEN: TStringField;
    cdsOpeEmlEML_EMAAUT: TStringField;
    cdsOpeEmlEML_EMAEMP: TStringField;
    lblTitPorApp: TLabel;
    dbeCodPorApp: TDBEditFocus;
    edtDesPorApp: TEditFocus;
    edtRemetente: TEditFocus;
    edtEmail: TEditFocus;
    edtLogin: TEditFocus;
    cmbProvedores: TcxLookupComboBox;
    chkEmaAut: TcxCheckBox;
    cdsOpeEmlEML_NOMPRV: TStringField;
    cdsOpeEmlEML_IMGB64: TBlobField;
    cdsOpeEmlEML_TEXTO_: TBlobField;
    cdsOpeEmlEML_SEQUEN: TAutoIncField;
    cdsOpeEmlEML_CODOPE: TStringField;
    cdsOpeEmlEML_IMAGEM: TBlobField;
    chkMsgReqCompNegada: TDBCheckBox;
    chkMSGCER: TDBCheckBox;
    tbsCartPremi: TTabSheet;
    grpCartaoPremiacao: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    dbeCPRIdH: TDBEditFocus;
    dbeCPRCiC: TDBEditFocus;
    dbeCPRNum: TDBEditFocus;
    rdgRequisicaoComprasAtendidas: TDBRadioGroup;
    rdgRequisicaoComprasIncluidas: TDBRadioGroup;
    chkItePPF: TDBCheckBox;
    lblFuncionario: TLabel;
    dbeCodFun: TDBEditFocus;
    edtDesFun: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure btnComissaoClick(Sender: TObject);
    procedure dbeStatusEnter(Sender: TObject);
    procedure btnMobileClick(Sender: TObject);
    procedure dbeCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function dbeCodCidChamaCadastro(Key: Word): string;
    function dbeCodEmpChamaCadastro(Key: Word): string;
    function dbeCodForChamaCadastro(Key: Word): string;
    function dbeCodDepChamaCadastro(Key: Word): string;
    procedure dbeCodGerKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure tsFinanceiroShow(Sender: TObject);
    procedure btnAddComForClick(Sender: TObject);
    procedure btnRemComForClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbgForComKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeTpCoMcExit(Sender: TObject);
    procedure dbeMsgPosEnter(Sender: TObject);
    procedure clbPortadoresClickCheck(Sender: TObject);
    procedure dbeTpCoVnExit(Sender: TObject);
    procedure btnAdicionarAssinaturaClick(Sender: TObject);
    procedure btnLimparAssinaturaClick(Sender: TObject);
    procedure btnValidarDadosEmailClick(Sender: TObject);
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure lblclbLoginClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure lblclbBaixaPagarClick(Sender: TObject);
    procedure lblclbEmpresaClick(Sender: TObject);
    procedure lblclbEmpEstClick(Sender: TObject);
    procedure lblclbIncRomClick(Sender: TObject);
    procedure lblclbBaixaReceberClick(Sender: TObject);
    procedure lblclbEmpConsVendFaturClick(Sender: TObject);
    procedure lblclbEmpLibRemotaClick(Sender: TObject);
    procedure chkUtiDefClick(Sender: TObject);
    procedure dbeCodCaxKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCaxEnter(Sender: TObject);
    procedure dbeCodCaxExit(Sender: TObject);
    procedure lblClbEmpresasNotificacaoColetorClick(Sender: TObject);
    procedure edtCodTecExit(Sender: TObject);
    procedure edtCodTecKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionaTecClick(Sender: TObject);
    procedure dbgOpeTecKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeIntExtExit(Sender: TObject);
    procedure lblclbPortadoresClick(Sender: TObject);
    procedure lblclbGeralClick(Sender: TObject);
    procedure dbgForComDblClick(Sender: TObject);
    procedure dbgForComEnter(Sender: TObject);
    procedure dbgForComExit(Sender: TObject);
    procedure btnAjudaProvedoresClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure rdgUsaFilClick(Sender: TObject);
    procedure lblclbEmpMltLjsClick(Sender: TObject);
    procedure btnHlpLoginClick(Sender: TObject);
    procedure btnHlpEmpresaClick(Sender: TObject);
    procedure btnHlpRomClick(Sender: TObject);
    procedure btnHlpBaixaReceberClick(Sender: TObject);
    procedure btnHlpBaixaPagarClick(Sender: TObject);
    procedure btnHlpEmpEstClick(Sender: TObject);
    procedure btnHlpConsVendFuturClick(Sender: TObject);
    procedure btnHlpLibRemotaClick(Sender: TObject);
    procedure btnHlpEmpMltLjsClick(Sender: TObject);
    procedure lblclbEmpEstMinClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure edtEmailChange(Sender: TObject);
    procedure btnLimparDadosProvedorClick(Sender: TObject);
    procedure lblclbEmpReimpressaoDocsClick(Sender: TObject);
    procedure btnHlpReimpressaoDocsClick(Sender: TObject);
    procedure btnPortifolioConteleClick(Sender: TObject);
    procedure clbLoginClickCheck(Sender: TObject);
    procedure cmbProvedoresClick(Sender: TObject);
    procedure btnEmailAddClick(Sender: TObject);
    procedure btnEmailCanClick(Sender: TObject);
    procedure dbgEmailsDblClick(Sender: TObject);
    procedure dbeCodPorAppKeyPress(Sender: TObject; var Key: Char);
    procedure dbgEmailsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblEmailOpcClick(Sender: TObject);
    procedure dbeE_mailExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure chkMsgCVAClick(Sender: TObject);
    procedure chkMsgReqCompIncluidaClick(Sender: TObject);
    function dbeCodFunChamaCadastro(Key: Word): string;
    procedure dbeCodFunKeyPress(Sender: TObject; var Key: Char);
  private
    strCepAnt: String;
    strVrfTpr: String;
    qryConFor: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCid: TUniQuery;
    qryCadCid: TUniQuery;
    qryCadPor: TUniQuery;
    qryPorApp: TUniQuery;
    qryConFun: TUniQuery;

    intPos : Integer;
    blnValidou: Boolean;
    blnUsaEmailPorEmpresa: Boolean;
    blnGravacao: Boolean;
    blnEdicaoEmail: Boolean;

    blnCepNaoEncontradoContinuar: Boolean;

    FPais: TPais;

    cdsListTipVen: TUniClientDataSet;
    cdsPorOpe: TUniClientDataSet;

    objComFor : TComFor;

    strImagemAssinatura: String;
    clbSelecionados    : array of TCheckListBox;
    cdsOpeATe: TUniClientDataSet;

    qryListaFilas: TUniQuery;
    dtsListaFilas: TDataSource;

    FValidacaoEmailObrigatoria: Boolean;

    FDatasetOpeAss,
    FDatasetCadPrv: TUniQuery;

    { Private declarations }
    Function fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
    function fValidaCodBarra(strCodBar, strCodOpe: String): Boolean;
    Function fRetNumero(strCodOpe: String): String;
    function fJaCarregouPortadores: Boolean;

    procedure pRetSenha;

    procedure pCarregaCidade;
    procedure pCarregaEmpresa;
    procedure pCarregaFornecedor;
    procedure pExcluiPortador;
    procedure pCarregaCaixa;
    procedure pCarregaFuncionario;

    procedure pCarregaLstEmpresa;

    procedure pCarregaListTipVen;

    procedure pCarregaHorOpe;
    procedure pHabilitaHorOpe(blnHabilita : Boolean);

    // seleciona na lista somente a empresa gravada com o operador
    procedure pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox; cdsDados: TUniClientDataSet = Nil);

    procedure pLimpaProvedor;
    procedure pAfterOpen(DataSet: TDataSet);
    function fVerificaGerenteTemVinculo(strCodOp: String): Boolean;
    function fVerificaSubGerenteTemVinculo(strCodOp: String): Boolean;
    function fVerificaOperadorEhGerente(strCodOp: String): Boolean;
    function fVerificaOperadorEhSubGerente(strCodOp: String): Boolean;
    function fOperadorNaoAcessaPortadores:Boolean;
    procedure pCarregaGerente;
    procedure pCarregaSubGerente;
    function  fCarregaPortadoresOperador: Boolean;
    function  fGravaPortadoresOperador: Boolean;
    procedure pMontaTitulosPageControl;
    procedure pHabilitarCamposComFor(blnHab: Boolean);
    procedure pCarregarImagemAssinatura();
    procedure pSalvarImagemAssinatura();
    procedure pCancelarAlteracaoImagemAssinatura();
    procedure pResetarBotoesAutDadosEmail;
    procedure pAbrirPoup;
    procedure pSetaCheckList(ASelecionados: array of TCheckListBox);
    procedure pExecutarSelecao(Opcao: TOpcSelecao);
    procedure pMarcaDesmarca(Opcao: Boolean);
    procedure pInverteSelecao;
    procedure pEnabledLabel(Opcao: Boolean);
    procedure pAtualizaEmpresasNotificacaoColetor;
    procedure pSalvaEmpresasNotificacaoColetor;
    procedure pCriaClientOpeATe;
    procedure pCarregaOpeATe;
    procedure pExcluirOpeATe;
    procedure pGravarOpeATe;
    procedure pEditarComissaoFornecedoresEspecificos();

    procedure ExibeAjudaProvedores;
    procedure ExibeSenhaEmailOperador;

    procedure pCarregarOperador(blnPreencheSenha: Boolean = True);
    procedure pBuscaOperador(strCodOperador: String);
    function fListaFilas: TDataSource;
    procedure pCopiaDadosHeranca(qryDados: TUniQuery);
    procedure pExecutaHeranca;
    procedure pLimpaDadosPessoaisHerdados;
    procedure pRecarregaSubTabelas;
    procedure pRecarregaComFor;
    procedure pRecarregaOpeAte;
    procedure pCarregaDadosHeranca;
    function fEmpresasInativasSelecionadas(arrEmp: array of TCheckListBox): String;
    function fValidaEmpresasSelecionadas: Boolean;
    procedure pDesmarcaEmpresas(strEmpresas: String; arrEmp: array of TCheckListBox);
    procedure pAjustaAbaEmail;
    procedure pCarregaDadosEmail;
    procedure pCarregaDadosEmailEmpresas;
    procedure pCarregaDadosEmailOperador;
    procedure pCarregaPortadorAppSales;
    procedure pGravaDadosEmail;
    procedure pGravaDadosEmailEmpresas;
    procedure pGravaDadosEmailOperador;
    procedure pAdicionaDadosEmail;
    procedure pLimpaDadosEmail;
    procedure pCarregaAssinatura;
    procedure pPreencheCamposEdicaoEmail;
    procedure pHabilitaCamposEmail(blnHabilita: Boolean);
    function fValidaDadosEmail: Boolean;
    function fConfirmaExclusaoEmail: Boolean;
    function fValidaEmpresasEmail: Boolean;
    function fValidaCamposEmail(Sender: TWinControl): Boolean;
    procedure pPreencheCodOpeEmail;
    procedure pLimpaSenhaEmail;
    function fValidaSenhasEmail: Boolean;
    function fValidarInativacaoExclusaoOperador: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaSomaBaixaFlex : Boolean;
  public
    { Public declarations }
    strEmpSel : String;
    strCodOpe : String;
    strCodOperadorIniciarCadastro: String;
  end;

Const
  arrTipOpe: Array[0..5] Of String = ('A','C','I','E','R','N');
  MSG_VALIDAFLEX = 'O valor do Percentual de distribuição na baixa de créditos FLEX - Parte da Empresa somado ao '+
                   'valor do Percentual de distribuição na baixa de créditos FLEX - Parte do Vendedor não pode ultrapassar 100 !';

implementation

uses  SysUtils, StrUtils, Variants, untFuncoes, untFuncoesSimples, untPai, untPesqAux,
      untConsultas, untComVendedores, untCadOpeConfig, untFuncIns, untFuncIns2, untConstantes,
      untTypesSistema, untValidaCaracteres, untCadCidades, untCadCid, untLiberacao,
      untLiberacaoFactory, untImagemBase64, untTHorOpe, untRelAjudaMod, untTipoOperadores,
      untAjudaPorAbas, untHerancaOperador, untConsultaIdContele, untOpeEmlController,untCadFuncionarios;

{$R *.dfm}

procedure TfrmCadOperadores.FormActivate(Sender: TObject);
 Var
     LMonitor: TMonitor;
begin
  inherited;

  If fUsaDoisMonitores Then
  Begin
     LMonitor := TMonitor(Screen.MonitorFromWindow(Application.Handle));
     MakeFullyVisible(LMonitor);
     pCentralizarForm(Self);
  End;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadOperadores.pEditarComissaoFornecedoresEspecificos;
begin
  if (not edtCodFor.Enabled) then
    Exit;

  If (Not objComFor.fGetCds.IsEmpty) Then
  begin
    edtCodFor.Text  := objComFor.fGetCds.FieldByName('FOR_CODFOR').AsString;
    edtNomForn.Text := objComFor.fGetCds.FieldByName('FOR_NOMFOR').AsString;
    edtComFor.Text  := FloatToStr(objComFor.fGetCds.FieldByName('FOR_PERCOM').AsFloat);

    objComFor.pDeletar(dbeCodOpe.Text, objComFor.fGetCds.FieldByName('FOR_CODFOR').AsString);

    pSetFocus(edtCodFor);
  end;
end;

procedure TfrmCadOperadores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  {**************************************************}
  {* ATUALIZA OS PORTADORES QUE A EMPRESA TEM ACESSO*}
  {***********************************************LE*}
  If fCfgSis('DACPOR', varBoolean) Then
    strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);


  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadOperadores.FormCreate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
  strNomeTabela       := 'CADOPE';
  strNomeCampo        := 'OPE_CODOPE';
  qryTabela           := fCriaQuery(Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet   := qryTabela;

  blnCepNaoEncontradoContinuar := False;

  lblTitPorApp.Visible := fCfgSis('APPSAL', varBoolean);
  dbeCodPorApp.Visible := fCfgSis('APPSAL', varBoolean);
  edtDesPorApp.Visible := fCfgSis('APPSAL', varBoolean);

  chkMsgETF.Visible   := fCfgSis('PRFEFE', VarBoolean);
  chkMsgMedAtrasoClientes.Visible := (fCfgSis('CREAUT', VarBoolean)) And (fCfgSis('MSGCRE', VarBoolean));

  FPais := fSetaPais;

  SetLength(clbSelecionados, 0);

  qryCadCid           := fCriaQuery(Self);
  qryConCid           := qryCadCid;
  qryConEmp           := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConFor           := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryPorApp           := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);
  qryConFun           := fCriarQuery('SELECT * FROM CADFUN WHERE FALSE', Self);

  intPaginasAtivas := IIF(fCfgSis('DACPOR', varBoolean), 3, 2);

  cdsListTipVen := TUniClientDataSet.Create(Self);

  strCodOperadorIniciarCadastro := EmptyStr;

  {*****************************************************}
  {**** CARREGA O CLIENT QUE CONTROLA OS PORTADORES ****}
  {* LEMBRANDO QUE SÓ É CARREGADO CASO A TABFINANCEIRO *}
  {******************* ESTIVER ATIVA *******************}
  {**************************************************MO*}
  If (tsFinanceiro.TabVisible) Then
  Begin
    cdsPorOpe     := TUniClientDataSet.Create(Self);

    With cdsPorOpe.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODOPE';
      DataType := ftString;
      Size     := 3;
    End;

    With cdsPorOpe.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'CODPOR';
      DataType := ftString;
      Size     := 5;
    End;

    With cdsPorOpe.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'NOMPOR';
      DataType := ftString;
      Size     := 40;
    End;

    With cdsPorOpe.FieldDefs.AddFieldDef Do
    Begin
      Name     := 'ACESSO';
      DataType := ftString;
      Size     := 1;
    End;

    cdsPorOpe.CreateDataSet;
  End;

  Setlength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodOpe;

  pgcDados.Pages[2].TabVisible := fCfgSis('DACPOR', varBoolean);
  tbsComForEsp.TabVisible := (fCfgSis('OPCCOM') = 'SH');

  dbeAutSenhaOpe.Visible := fCfgSis('CASOPE', varBoolean);
  lblAutSenhaOpe.Visible := dbeAutSenhaOpe.Visible;

  If (tbsComForEsp.TabVisible) Then
  Begin
    Inc(intPaginasAtivas);
    pMontaTitulosPageControl;
    objComFor := TComFor.Create(Self);
    dtsComFor.DataSet := objComFor.fGetCds;
  End
  Else
    objComFor := Nil;

  tbsWhatsapp.TabVisible := fCfgSis('UTIWPP', varBoolean);
  tbsCartPremi.TabVisible := fCfgSis('CARPRM', varBoolean);

  lblNumWpp.Visible := tbsWhatsapp.TabVisible;
  dbeNumWpp.Visible := tbsWhatsapp.TabVisible;
  imgNumWpp.Visible := tbsWhatsapp.TabVisible;

  FDatasetCadPrv := fCriarQuery('SELECT * FROM CADPRV ORDER BY PRV_NOMPRV');
  FDatasetCadPrv.Open;
  cmbProvedores.Properties.ListSource := fCriaDataSource(FDatasetCadPrv);

  lkpFilaEnvio.ListSource := fListaFilas;

  FDatasetOpeAss := fCriarQuery('SELECT * FROM OPEASS WHERE FALSE');

  strImagemAssinatura := '';

  //Ativando Comissão.
  If fCfgSis('OPCCOM', varString) = 'TA' Then
  Begin
    gpbComAti.Visible := True;
    gpbComAti.Align   := AlClient;
  End
  Else
  Begin
    gpbComPro.Visible := True;
    gpbComPro.Align   := AlClient;
  End;


  //Ativando LG Sistemas.
  If fCfgSis('COM_LG', varBoolean) Then
  Begin
    lblMatricula.Visible := True;
    dbeMatricula.Visible := True;
  End
  Else
  Begin
    lblMatricula.Visible := False;
    dbeMatricula.Visible := False;
  End;

  {Prazo médio de venda}
  lblPrazoMedioVenda.Visible := fCfgSis('PRZMED', varBoolean);
  dbePrazoMedioVenda.Visible := fCfgSis('PRZMED', varBoolean);
  lblLimCredA.Caption := Format(lblLimCredA.Caption, [fCfgSis('QTMCLA')]);

  {Permissão de horários de operação do sistema}
  tbsPermissaoHorariosOperacaoSistema.TabVisible := THorOpe.fUtilizaControlePermissaoHorario;
  cdsHorOpe.CreateDataSet;
  cdsHorOpe.EmptyDataSet;
  If fCfgSis('DMEFEM') <> '0' Then
    chkDMEFEM.Visible := True;

  chkMsgCRM.Visible := fCfgSis('UTICRM', varBoolean);

  chkContratoLocVencer.Visible := fCfgSis('LOCEQU', varBoolean);

  pCriaClientOpeATe;
  cdsOpeEml.CreateDataSet;

  FValidacaoEmailObrigatoria := False;
  blnUsaEmailPorEmpresa := fCfgSis('EMLEMP', varBoolean);
  blnGravacao := False;
  pAjustaAbaEmail;
end;

function TfrmCadOperadores.fListaFilas: TDataSource;
begin
  if Assigned(dtsListaFilas) then
    FreeAndNil(dtsListaFilas);

  if Assigned(qryListaFilas) then
    FreeAndNil(qryListaFilas);

  qryListaFilas := fCriaQuery(Self);
  dtsListaFilas := TDataSource.Create(qryListaFilas);

  qryListaFilas.Close;
  qryListaFilas.SQL.Text :=
  ' SELECT '+
  '   " " AS AUTOINCREM, '+
  '   " " AS FILAS '+

  ' UNION '+

  ' SELECT '+
  '   AUTOINCREM, '+
  '   CONCAT(FIL_IDFILA, "-", FIL_DESFIL) AS FILAS '+
  ' FROM '+
  '   CADFIL '+
  IIF(rdgUsaFil.ItemIndex = 0, ' WHERE FIL_CODEMP = :CODEMP ', '');

  if rdgUsaFil.ItemIndex = 0 then
    qryListaFilas.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryListaFilas.Open;

  dtsListaFilas.DataSet := qryListaFilas;
  Result := dtsListaFilas;
end;

procedure TfrmCadOperadores.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsListTipVen);
  FreeAndNil(cdsPorOpe);
  If Assigned(objComFor) Then
    FreeAndNil(objComFor);

  FDatasetCadPrv.Close;
  FreeAndNil(FDatasetCadPrv);

  FDatasetOpeAss.Close;
  FreeAndNil(FDatasetOpeAss);

  FreeAndNil(cdsOpeATe);

  FreeAndNil(dtsListaFilas);
  FreeAndNil(qryListaFilas);

end;

procedure TfrmCadOperadores.pLimpaProvedor;
begin
  If (fEmptyStr(edtSenhaEmail.Text)) And (fEmptyStr(edtEmail.Text)) And
    (fEmptyStr(edtLogin.Text)) And (cmbProvedores.EditValue <> Null) Then
    cmbProvedores.EditValue := Null;
end;

function TfrmCadOperadores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCaption: String;
  procedure pProPagina;
  begin
    pgcDados.SelectNextPage(True, True);
    Case pgcDados.ActivePageIndex Of
      0: pSetFocus(dbeCodOpe);
      1: pSetFocus(dbeComCMF);
      2: pSetFocus(clbPortadores);
      3: pSetFocus(edtCodFor);
      5: pSetFocus(edtRemetente);
      6: pSetFocus(dbeMsgPos);
    End;
  End;
  var
    strFalha: string;
    strCodCid   : String;
    strEndere   : String;
    strBairro   : String;
    strNomCid   : String;
    strEstado   : String;
    blnAtualizar : Boolean;
    intNumCar   : Integer;
    intNumRep   : Integer;
    LCodigoCorreio: String;
begin
  Result := True;
  blnValidou := True;
  blnAtualizar := False;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    If (Sender = dbeCodOpe) And (dbeCodOpe.Enabled) Then
    Begin
      If fEmptyStr(dbeCodOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Operador não pode ser vazio!', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End
      Else If (Length(dbeCodOpe.Text) <> 3) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Operador deve ter 3 caracteres!', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          dbeLimCred.Field.AsFloat := 0.0;
          dbeLimCredA.Field.AsFloat:= 0.0;
          dbePerCom.Field.AsFloat  := 0.0;
          dbePerCo2.Field.AsFloat  := 0.0;
          edtSenha.Enabled    := True;
          edtConSenha.Enabled := True;
          dbeNumCpf.Enabled   := True;
          dbeIntExt.Enabled   := True;
        End
        Else
        Begin
          edtSenha.Text       := fDecrypt(qryTabela.FieldByName('OPE_SENOPE').AsString);
          edtConSenha.Text    := edtSenha.Text;
          qryTabela.Edit;
          edtSenha.Enabled    := False;
          edtConSenha.Enabled := False;
          dbeNumCpf.Enabled   := False;
          dbeIntExt.Enabled   := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A TABELA DE PRECO              *}
    {**************************************MA*}
    Else If (Sender = dbeTabPre) And dbeTabPre.Visible Then
    Begin

      If Not fEmptyStr(dbeTabPre.Text) Then
      Begin

        If Pos( dbeTabPre.Text, strVrfTpr ) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Tabela de ' + clbTabPre.Caption + '!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (grbRotinaFlex.Visible) And (Sender = dbePEEMFL) Then
    Begin
      If Not fEmptyStr(dbePEEMFL.Text) Then
      Begin
        If (StrToFloatDef(dbePEEMFL.Text,0) < 0) Or (StrToFloatDef(dbePEEMFL.Text,0) > 100) then
        Begin
          fMensagem('ATENÇÃO!', 'O valor do Percentual de distribuição na baixa de créditos FLEX - Parte da Empresa deve ser entre 0 e 100!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fValidaSomaBaixaFlex) Then
          Begin
            fMensagem('ATENÇÃO!', MSG_VALIDAFLEX, ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        dbePEEMFL.Text := '0,00';
      End;
    End

    Else If (grbRotinaFlex.Visible) And (Sender = dbePEOPFL) Then
    Begin
      If Not fEmptyStr(dbePEOPFL.Text) Then
      Begin
        If (StrToFloatDef(dbePEOPFL.Text,0) < 0) Or (StrToFloatDef(dbePEOPFL.Text,0) > 100) then
        Begin
          fMensagem('ATENÇÃO!', 'O valor do Percentual de distribuição na baixa de créditos FLEX - Parte do Vendedor deve ser entre 0 e 100!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If (Not fValidaSomaBaixaFlex) Then
          Begin
            fMensagem('ATENÇÃO!', MSG_VALIDAFLEX, ['&Ok']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        dbePEOPFL.Text := '0,00';
      End;
    End

    Else If (Sender = dbeStatus) Then
    Begin
      If Pos(dbeStatus.Text,'AI') <= 0 Then
      Begin
        fMensagem('', 'O campo situação do operador deve ser A ou I!', ['&O k']);
        Result := False;
      End
      Else
      If SameText(dbeStatus.Text,'I') Then
      Begin
        if not fValidarInativacaoExclusaoOperador then
          Result := False;
      End;
    End

    Else If (Sender = dbeMsgPos) Then
    Begin
      If Pos(dbeMsgPos.Text,'ED') <= 0 Then
      Begin
        fMensagem('', 'O campo exibir popup de mensagens deve ser E ou D!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeCodPorApp) And dbeCodPorApp.Visible Then
    Begin
      If fEmptyStr(dbeCodPorApp.Text) Then
      Begin
        dbeCodPorApp.Field.Clear;
        edtDesPorApp.Clear;
      End
      Else
      Begin
        pCarregaPortadorAppSales;
        if (qryPorApp.FieldByName('POR_CODPOR').IsNull) then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
        End
        Else if (Not fEmpresaTemAcessoPortador(dbeCodEmp.Text)) then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        End;
      End;
    End

    Else If (Not fValidaCamposEmail(Sender)) Then
      Result := False

    Else If (Sender = dbeIntExt) Then
    Begin

      If (dbeIntExt.KeyValue = null) Then
      Begin
        fMensagem('', 'O campo tipo de operador não pode ser vazio!', ['&O k']);
        tbsGeral.Show;
        Result := False;
      End

      Else If Pos(dbeIntExt.KeyValue,'A_C_I_E_D_S_G_M_O_T_') <= 0 Then
      Begin
        fMensagem('', 'O campo tipo de operador deve ser A, C, I, E, D, S, G, M, O OU T!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If (dbeIntExt.KeyValue = 'G') Then
        begin
          dbeCodGer.Field.Value := Null;
          dbeCodGer.Enabled     := False;
          edtDesGer.Clear;
        End
        Else Begin
          dbeCodGer.Enabled        := True;

          If Not blnUsaProCodigo Then
          Begin
            If fVerificaGerenteTemVinculo(dbeCodOpe.Text) Then
            Begin
              fMensagem('', 'Existem vendedores vinculados a essa gerência, remova esses vínculos antes de alterar.', ['&OK']);
              tbsGeral.Show;
              Result := False;
            End;
          End;
        End;

        If (dbeIntExt.KeyValue = 'S') Then
        Begin
          dbeCodSub.Field.Value := Null;
          dbeCodSub.Enabled := False;
          edtDesSub.Clear;
        End
        Else Begin
          dbeCodSub.Enabled := True;

          If Not blnUsaProCodigo Then
          Begin
            If fVerificaSubGerenteTemVinculo(dbeCodOpe.Text) Then
            Begin
              fMensagem('', 'Existem vendedores vinculados a essa sub-gerência, remova esses vínculos antes de alterar.', ['&OK']);
              tbsGeral.Show;
              Result := False;
            End;
          End;
        End;

      End;

    End

    Else If (Sender = dbeNomOpe) Then
    Begin
      If fEmptyStr(dbeNomOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome do Operador não pode ser vazio!', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End;
    End

    Else If (Sender = edtSenha) Then
    Begin
      intNumCar := fCfgSis('QTMICR', varInteger);
      intNumRep := fCfgSis('QTRTCR', varInteger);

      If fCfgSis('SENSEG', varBoolean) Then
      Begin
        If (Not TValidaCaracteres.fValida([tcvLetra, tcvNumero, tcvSimbolo], edtSenha.Text, strFalha)) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', strFalha, ['&Ok']);
        end;
      End;

      If fEmptyStr(edtSenha.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo senha é de preenchimento obrigatório!', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End
      Else If (Length(edtSenha.Text) < intNumCar) Then
      Begin
        pMensagemOk('A senha deve possuir no mínimo '+IntToStr(intNumCar)+' caracteres  ');
        Result := False;
      End
      Else If (fContaCaracterRepetido(edtSenha.Text, intNumRep)) Then
      Begin
        pMensagemOk('Não é permitido repetir o mesmo caracter mais de '+IntToStr(intNumRep)+' vezes.  ');
        Result := False;
      End
      Else If Not fSenhaPermitida(edtSenha.Text) Then
      Begin
        pMensagemOk('Caracteres aceitos na senha: ' + STR_CHAR_SENHA);
        Result := False;
      End
      Else If (edtSenha.Enabled)                                                      And
              (fCrypt(edtSenha.Text) <> qryTabela.FieldByName('OPE_SENOPE').AsString) And
              (fVerificaSenhaVend(edtSenha.Text))                                     Then
      Begin
        fMensagem('ATENÇÃO!', 'Senha inválida ou fora dos padrões exigidos. Verifique.', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtConSenha) Then
    Begin
      If (edtConSenha.Text <> edtSenha.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A confirmação da senha é diferente da Senha! Verifique...', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA CIDADE E CARREGA   *}
    {* OS DADOS REFERENTES À MESMA           *}
    {**************************************MV*}
    Else If (Sender = dbeCodCid) Then
    Begin
      If fEmptyStr(dbeCodCid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo código da cidade deve ser preechido!', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End
      Else
      Begin
        pCarregaCidade;
        If qryConCid.FieldByName('CID_NOMCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeNumCep) Then
    Begin

      If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cep deve conter 8 digitos.', ['&Ok']);
        tbsGeral.Show;
        Result := False;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) And (edtEstado.Text <> 'EX') Then
      Begin

        If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado,  LCodigoCorreio,
                                                '' {qryConCid.FieldByName('CID_ESTADO').AsString},
                                                '' {qryConCid.FieldByName('CID_CODCOR').AsString})) Then
        Begin
          if (fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text)) or (not blnCepNaoEncontradoContinuar) then
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          blnCepNaoEncontradoContinuar := Result;
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
              pCarregaCidade;
            End;

            If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
              dbeEndere.Field.AsString := strEndere;

            If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
              dbeBairro.Field.AsString := strBairro;

            {***********************************}
            {* CASO O CEP NÃO POSSUIR ENDERECO *}
            {********************************JB*}
            If (Not fEmptyStr(strNomCid)) And (fEmptyStr(strEndere)) And (blnAtualizar) Then
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

    Else If (Sender = dbeNumCPF) Then
    Begin
      If Not fEmptyStr(dbeNumCPF.Text) Then
      Begin
        dbeNumCPF.Text := fTiraCaracEspeciais(dbeNumCPF.Text);
        If Not fValidaCPF(dbeNumCPF.Text) Then
        Begin
          fMensagem('ATENÇÃO!', dbeNumCPF.Text + ' não é um CPF válido!', ['&Ok']);
          tbsGeral.Show;
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeLimCred) and dbeLimCred.Visible Then
    Begin

      If fEmptyStr(dbeLimCred.Text) Then
      Begin
        fMensagem('','O campo limite de crédito deve ser preenchido!',['&OK']);
        tbsGeral.Show;
        Result := False;
      End
      Else
      Begin

        If fStrToFloat(dbeLimCred.Text) < 0 Then
        Begin
          fMensagem('','O campo limite de crédito deve ser maior ou igual a zero!',['&OK']);
          tbsGeral.Show;
          result := False;
        End;

      End;

    End

    Else If (Sender = dbeLimCredA) Then
    Begin
      strCaption := LeftStr(lblLimCredA.Caption, Pred(Length(lblLimCredA.Caption)));

      If fEmptyStr(dbeLimCredA.Text) Then
      Begin
        fMensagem('', Format('O campo %s deve ser preenchido!', [strCaption]),['&OK']);
        tbsGeral.Show;
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(dbeLimCredA.Text) < 0 Then
        Begin
          fMensagem('', Format('O campo %s deve ser maior ou igual a zero!', [strCaption]),['&OK']);
          tbsGeral.Show;
          result := False;
        End;
      End;
    End

    {*****************************}
    {* VALIDA TELEFONES          *}
    {*************************MM**}
    Else If (Sender = dbeFone01) Or (Sender = dbeFone02) Or (Sender = dbeNumWpp) Then
    Begin
      If (TDBEditFocus(Sender).Visible) And
         (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
         (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o número do telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End

    Else If (Sender = dbeEmailsB2B) Then
      Result := fValidarCampoEmail(dbeEmailsB2B, 'E-mails B2B')

    Else If (Sender = dbeCodEmp) Then
    Begin

      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        fMensagem('','O código da empresa deve ser preenchido!',['&OK']);
        tbsGeral.Show;
        edtDesEmp.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(qryConEmp.FieldByName('EMP_CODEMP').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','A empresa não está cadastrada!',['&OK']);
          Result := False;
        End
        Else If (Not fEmpresaAtiva(qryConEmp.FieldByName('EMP_CODEMP').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A empresa '+ qryConEmp.FieldByName('EMP_CODEMP').AsString +
                                ' vinculada ao operador está inativa no cadastro de empresas '+
                                'e não pode ser utilizada. Altere a empresa antes de continuar!',
                                ['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodFor) Then
    Begin

      If (fEmptyStr(dbeCodFor.Text)) Then
        edtNomFor.Clear
      Else
      Begin
        pCarregaFornecedor;
        If (fEmptyStr(qryConFor.FieldByName('FOR_CODFOR').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse fornecedor não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeCodFun) And (dbeCodFun.Visible) Then
    Begin
      If (fEmptyStr(dbeCodFun.Text)) Then
        edtDesFun.Clear
      Else
      Begin
        pCarregaFuncionario;
        If (fEmptyStr(qryConFun.FieldByName('FUN_CODFUN').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!','Esse funcionário não está cadastrado!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodDep) Then
    Begin

      If (fEmptyStr(dbeCodDep.Text)) Then
        edtDesDep.Clear
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[dbeCodDep.Text]);

        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodCax) Then
    Begin

      If (fEmptyStr(dbeCodCax.Text)) Then
        edtDesCaixa.Clear
      Else
      Begin
        pCarregaCaixa;

        If fEmptyStr(edtDesCaixa.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse caixa não está cadastrado, está inativo ou não faz parte da empresa atual!',['&OK']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodBar) Then
    Begin

      If (Not fEmptyStr(dbeCodBar.Text)) then
      begin
        if Not fValidaEan13(dbeCodBar.Text) then
        begin
          fMensagem('ATENÇÃO!', 'Não é um código de barras válido!', ['&OK']);
          Result := False;
        end;

        if (Not fValidaCodBarra(dbeCodBar.Text, dbeCodOpe.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'Código de Barras duplicado!', ['&OK']);
          Result := False;
        end;
      end;

    End

    Else If (Sender = dbeCodGer) Then
    Begin
      If fEmptyStr(dbeCodGer.Text) Then
        edtDesGer.Clear
      Else
      Begin
        If (dbeCodOpe.Text = dbeCodGer.Text) Then
        Begin
          fMensagem('', 'Gerente Inválido!', ['&OK']);
          Result := False;
        End
        Else If (fRetNomeOperador(dbeCodGer.Text) = '') Then
        Begin
          fMensagem('', 'Gerente Inválido!', ['&OK']);
          Result := False;
        End
        Else If (Not fVerificaOperadorEhGerente(dbeCodGer.Text)) Then
        Begin
          pCarregaGerente;
          fMensagem('', 'Operador selecionado não é Gerente!', ['&OK']);
          Result := False;
        End
        Else
          pCarregaGerente;
      End;

      pProPagina;
    End

    Else If (Sender = dbeCodSub) Then
    Begin
      If fEmptyStr(dbeCodSub.Text) Then
        edtDesSub.Clear
      Else
      Begin
        If (dbeCodOpe.Text = dbeCodSub.Text) Then
        Begin
          fMensagem('', 'Sub-Gerente Inválido!', ['&OK']);
          Result := False;
        End
        Else If (fRetNomeOperador(dbeCodSub.Text) = '') Then
        Begin
          fMensagem('', 'Sub-Gerente Inválido!', ['&OK']);
          Result := False;
        End
        Else If (Not fVerificaOperadorEhSubGerente(dbeCodSub.Text)) Then
        Begin
          pCarregaSubGerente;
          fMensagem('', 'Operador selecionado não é Sub-Gerente!', ['&OK']);
          Result := False;
        End
        Else
          pCarregaSubGerente;
      End;
    End

//    Else If (Sender = dbeMecani) And dbeMecani.Visible Then
//    Begin
//      If Pos(dbeMecani.Text, 'SN') <= 0 Then
//      Begin
//        fMensagem('', 'O Campo deve ser preenchido com (S)im ou (N)ão!', ['&OK']);
//        Result := False;
//      End
//    End

    Else If (Sender = dbeTipCli) Then
    Begin
      If Pos(dbeTipCli.Text,'AV') <= 0 Then
      Begin
        tbsGeral.Show;
        fMensagem('ATENÇÃO!', 'O Tipo de Cliente deve ser (A)tacado ou (V)arejo!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = chkMSGCER) Then
      pProPagina

    Else If (Sender = dbeTpCoMc) And grpComMecanicos.Visible Then
    Begin
      If (Pos(dbeTpCoMc.Text, 'P_V_') <= 0) Then
      Begin
        pgcDados.ActivePage := tsComissao;
        fMensagem('ATENÇÃO!', 'O tipo de comissão do mecânico deve ser P ou V!', ['&OK']);
        Result := False;
      End;

      lblMecCItPerVal.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
      lblMecCSePerVal.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
    End

    Else If (Sender = dbeTpCoVn) And grbComSerVen.Visible Then
    Begin
      If (Pos(dbeTpCoVn.Text, 'P_V_') <= 0) Then
      Begin
        pgcDados.ActivePage := tsComissao;
        fMensagem('ATENÇÃO!', 'O tipo de comissão do vendedor deve ser P ou V!', ['&OK']);
        Result := False;
      End;

      lblTpComSerVen.Caption := IIF(dbeTpCoVn.Text = 'V', '$', '%');
    End

    Else If (Sender = dbeMecCIt) And grpComMecanicos.Visible Then
      Result := fValidaMaiorZero(dbeMecCIt, IIF(dbeTpCoMc.Text = 'P', '%', '$') + ' Comissão Mecânico sobre Produtos')

    Else If (Sender = dbeMecCSe) And grpComMecanicos.Visible Then
      Result := fValidaMaiorZero(dbeMecCSe, IIF(dbeTpCoMc.Text = 'P', '%', '$') + ' Comissão Mecânico sobre Serviços')

    Else If (Sender = dbeVenCSe) And grbComSerVen.Visible Then
      Result := fValidaMaiorZero(dbeVenCSe, IIF(dbeTpCoVn.Text = 'P', '%', '$') + ' Comissão Vendedor sobre Serviços')

    Else If (Sender = dbeSalBas) Then
      Result := fValidaMaiorZero(dbeSalBas, 'Salário Base')

    // Metas
    Else If (Sender = dbeComCMF) Then
      Result := fValidaMaiorZero(dbeComCMF, '% Comissão sobre meta de faturamento')

    Else If (Sender = dbeComCFA) Then
      Result := fValidaMaiorZero(dbeComCFA, '% Comissão aceleradora sobre meta faturamento')

    Else If (Sender = dbeComCMA) Then
      Result := fValidaMaiorZero(dbeComCMA, '% Comissão aceleradora sobre meta margem')

    Else If (Sender = edtCodFor) And (tbsComForEsp.TabVisible) Then
    Begin
      If Not fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomForn.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomForn.Text) Then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsComForEsp;
          pMensagemOk('Fornecedor não encontrado!');
        End;
      End;
    End

    Else If (Sender = dbeAutSenhaOpe) And (dbeAutSenhaOpe.Visible) Then
    Begin
      If Pos(dbeAutSenhaOpe.Text, 'SN') <= 0 Then
      Begin
        fMensagem('', 'O Campo deve ser preenchido com (S)im ou (N)ão!', ['&OK']);
        Result := False;
      End
    End

    Else
    If (Sender = dbeComAta) Or
       (Sender = dbeComVar) Or
       (Sender = dbeCom_SM) Then
    Begin
      If (fStrToFloat(TDBEditFocus(Sender).Text) < 0) Or
         (fStrToFloat(TDBEditFocus(Sender).Text) > 100) Then
      Begin
        fMensagem('', 'O Percentual da Comissão deve ser entre 0 e 100', ['&Ok']);
        Result := False;
      End;

    End

    Else
    If (Sender = dbePrazoMedioVenda) Then
    Begin
      If fCfgSis('PRZMED', varBoolean) Then
      Begin

        If fEmptyStr(dbePrazoMedioVenda.Text) Then
        Begin
          fMensagem('', 'O Prazo Médio de Venda deve ser informado!', ['&Ok']);
          Result := False;
        End
        Else
        If (StrToInt(dbePrazoMedioVenda.Text) < 0) Then
        Begin
          fMensagem('', 'O Prazo Médio de Venda não deve ser inferior a zero!', ['&Ok']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = dbeComATe) Then
    Begin
      If (fStrToFloat(dbeComATe.Text) < 0) Or
         (fStrToFloat(dbeComATe.Text) > 100) Then
      Begin
        fMensagem('', 'O Percentual da Comissão "Assistência Técnica" deve ser entre 0 e 100', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodTec) and (grpComAssTec.Visible) Then
    Begin
      If Not fEmptyStr(edtCodTec.Text) Then
      Begin
        edtNomTec.Text := fRetNomeOperador(edtCodTec.Text);

        If fEmptyStr(edtNomTec.Text) Then
        Begin
          fMensagem('AVISO', 'Técnico não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If (Not Result) Then
  Begin
    blnValidou := False;
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadOperadores.pCarregaPortadorAppSales;
begin
  pPesquisaCadPor(Nil, qryPorApp, dbeCodPorApp.Text);
  edtDesPorApp.Text := qryPorApp.FieldByName('POR_NOMPOR').AsString;
end;

procedure TfrmCadOperadores.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('OPE_CODOPE');
  stlCampos.Add('OPE_NOMOPE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('OPE_CODOPE');
  stlCamInd.Add('OPE_NOMOPE');
  stlDesInd.Add('Código do Operador');
  stlDesInd.Add('Nome do Operador');
end;

procedure TfrmCadOperadores.pInverteSelecao;
var
  intCount: Integer;
  clbSelecionado: TCheckListBox;
begin
  for clbSelecionado in clbSelecionados do
    If Assigned(clbSelecionado) Then
    Begin
      For intCount := 0 to clbSelecionado.Items.Count - 1 Do
      Begin
        If clbSelecionado.Checked [intCount] = True then
          clbSelecionado.Checked [intCount] := False
        Else
          clbSelecionado.Checked [intCount] := True;

        If (clbSelecionado.Name = 'clbLogin') Then
        Begin
          clbEmpresa.Checked[intCount] := clbSelecionado.Checked[intCount];
        End;
      End;
    End;
end;

procedure TfrmCadOperadores.pMarcaDesmarca(Opcao: Boolean);
var
  intCount: Integer;
  clbSelecionado: TCheckListBox;
begin
  for clbSelecionado in clbSelecionados do
    If Assigned(clbSelecionado) Then
    Begin
      for intCount := 0 to clbSelecionado.Items.Count - 1 do
      Begin
        clbSelecionado.Checked [intCount] := Opcao;

        If (clbSelecionado.Name = 'clbLogin') Then
          clbEmpresa.Checked[intCount] := Opcao;
      End;
    End;
end;

procedure TfrmCadOperadores.pMontaTitulosPageControl;
  Var
    strCaption: String;
    intIndex  : Integer;
    intPosSep : Integer;
begin
  pAtribuiTags;

  For intIndex := 0 To pgcDados.PageCount -1 Do
  Begin
    strCaption := pgcDados.Pages[intIndex].Caption;
    intPosSep  := Pos('-', strCaption);

    strCaption := '&' + IntToStr(pgcDados.Pages[intIndex].Tag) + ' ' +
                  MidStr(strCaption, intPosSep, 255);

    pgcDados.Pages[intIndex].Caption := strCaption;
  End;
end;

procedure TfrmCadOperadores.btnPesquisaClick(Sender: TObject);
  var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  //inherited;

  chrKey := '?';
  if fPesqOperador(Self, nil, nil, qryTabela, chrKey, arrSel) then
    pCarregarOperador;
end;

procedure TfrmCadOperadores.btnPortifolioConteleClick(Sender: TObject);
var
  frmConsultaIDContele: TfrmConsultaIDContele;
begin
  pCriarFormularios(TfrmConsultaIDContele, frmConsultaIDContele);
  try
    frmConsultaIDContele.InfoConsultar := apiPortifolios;
    frmConsultaIDContele.ShowModal;
    if frmConsultaIDContele.ModalResult = mrOk then
      dbeIdPortifolioContele.Text := frmConsultaIDContele.strInfoRetornar;
  finally
    pFreeAndNil(frmConsultaIDContele);
  end;
end;

procedure TfrmCadOperadores.pCarregarOperador(blnPreencheSenha: Boolean = True);
begin
  btnComissao.Enabled := True;

  If (blnPreencheSenha) Then
    pRetSenha;

  imgAssinatura.Picture.Assign(nil);

  pCarregaCidade;
  pCarregaEmpresa;
  pCarregaFornecedor;
  pCarregaFuncionario;
  pCarregaGerente;
  pCarregaSubGerente;
  pCarregaHorOpe;
  pCarregaCaixa;
  pCarregaDadosEmail;
  pCarregaPortadorAppSales;

  pAtualizaLstEmpresa('OPE_EMPACE', clbEmpresa);
  pAtualizaLstEmpresa('OPE_EMPROM', clbIncRom);
  pAtualizaLstEmpresa('OPE_EMPLOG', clbLogin);
  pAtualizaLstEmpresa('OPE_EMPCTR', clbBaixaReceber);
  pAtualizaLstEmpresa('OPE_EMPCTP', clbBaixaPagar);
  pAtualizaLstEmpresa('OPE_EMPEST', clbEmpEst);
  pAtualizaLstEmpresa('OPE_EMPFAT', clbEmpConsVendFatur);
  pAtualizaLstEmpresa('OPE_EMPLIB', clbEmpLibRemota);
  pAtualizaLstEmpresa('OPE_EMPMTL', clbEmpMltLjs);
  pAtualizaLstEmpresa('OPE_EMPESM', clbEmpEstMin);
  pAtualizaLstEmpresa('OPE_EMPRDS', clbEmpReimpressaoDocs);
  pAtualizaEmpresasNotificacaoColetor();

  btnMobile.Enabled := btnAlterar.Enabled;

  edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[dbeCodDep.Text]);

  If Assigned(objComFor) Then
    objComFor.pCarregar(dbeCodOpe.Text);

  pResetarBotoesAutDadosEmail();

  chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Checked := False;

  lblMecCItPerVal.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
  lblMecCSePerVal.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
  lblTpComSerVen.Caption  := IIF(dbeTpCoVn.Text = 'V', '$', '%');

  pSetFocus(btnAlterar);

  If fCfgSis('DACPOR', VarBoolean) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    clbPortadores.Clear;

    If (cdsPorOpe.Active) and
       (cdsPorOpe.RecordCount > 0) Then
      cdsPorOpe.EmptyDataSet;
  End;

  grpComAssTec.Visible := dbeIntExt.KeyValue = 'T';
  pCarregaOpeATe;

  ExibeAjudaProvedores;
  ExibeSenhaEmailOperador;

  lkpFilaEnvio.ListSource := fListaFilas;

  FValidacaoEmailObrigatoria := False;
end;

procedure TfrmCadOperadores.btnRemComForClick(Sender: TObject);
begin
  inherited;

  If Not btnRemComFor.Enabled Then
    Exit;

  If fEmptyStr(dbeCodOpe.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um operador!', ['&OK']);
    Exit;
  End;

  If (Not objComFor.fGetCds.IsEmpty) And
     (fMensagem('AVISO!', 'Confirmar Exclusão da Comissão?', ['&Sim', '&Não']) = 1) Then
    objComFor.pDeletar(dbeCodOpe.Text, objComFor.fGetCds.FieldByName('FOR_CODFOR').AsString);

  pSetFocus(edtCodFor);
end;

procedure TfrmCadOperadores.btnValidarDadosEmailClick(Sender: TObject);
  Var
    blnConexaoProvedor: Boolean;
    objAutenticacaoEmail: TAutenticacaoEmail;

  procedure pAlterarGlyphButton(Var button: TSpeedButton; intIndexImage: Integer); begin
    button.Glyph.Assign(nil);
    imgValidacaoEmail.GetBitmap(intIndexImage, button.Glyph);
  end;
begin
  If (cmbProvedores.EditValue = Null) Then
  Begin
    fMensagem('AVISO!', 'O campo Provedor das Configurações de e-Mail deve ser informado!', ['&OK']);
    Exit;
  End;

  if fEmptyStr(edtEmail.Text) then
  begin
    fMensagem('AVISO!', 'e-Mail não informado!', ['&OK']);
    Exit;
  end;

  if not fValidarEmail(edtEmail.Text, False) then
  begin
    fMensagem('AVISO!', 'e-Mail informado é inválido!', ['&OK']);
    Exit;
  end;

  If (Not ( (fValidaCampos(cmbProvedores, True))
    And (fValidaCampos(edtEmail, True))
    And (fValidaCampos(edtSenhaEmail, True)) ) ) Then
    fMensagem('AVISO!', 'Informe os dados de autenticação da conta de e-mail!', ['&OK'])
  Else
  Begin
    objAutenticacaoEmail := nil;
    Try
      btnValidarDadosEmail.Caption := 'Aguarde...';
      btnValidarDadosEmail.Enabled := False;
      btnLimparDadosProvedor.Enabled := False;

      pAlterarGlyphButton(btnDadosSmtp, 2);
      pAlterarGlyphButton(btnDadosImap, 2);
      pAlterarGlyphButton(btnAutenticacaoSmtp, 2);

      blnConexaoProvedor := False;

      Application.ProcessMessages;

      objAutenticacaoEmail := TAutenticacaoEmail.Create(qryTabela.FieldByName('OPE_CODOPE').AsString,
                                                        edtEmail.Text,
                                                        edtLogin.Text,
                                                        '',
                                                        edtSenhaEmail.Text,
                                                        cmbProvedores.EditValue,
                                                        Not cmbProvedores.Properties.ListSource.DataSet.FieldByName('PRV_USAOA2').AsString.Equals('S'));

      FValidacaoEmailObrigatoria := False;
      If TAutenticacaoEmail.fValidarAutenticacaoSmtp(Self, objAutenticacaoEmail, blnConexaoProvedor, True) Then
      Begin
        If (blnConexaoProvedor) Then
          pAlterarGlyphButton(btnDadosSmtp, 0)
        Else
        Begin
          pAlterarGlyphButton(btnDadosSmtp, 1);
          FValidacaoEmailObrigatoria := True;
        End;

        pAlterarGlyphButton(btnAutenticacaoSmtp, 0);

        qryTabela.FieldByName('OPE_EMA_ID').Value := Null;
        If Not objAutenticacaoEmail.EmailIdAzure.IsEmpty Then
          qryTabela.FieldByName('OPE_EMA_ID').AsString := objAutenticacaoEmail.EmailIdAzure;
      End
      Else
      Begin
        If (blnConexaoProvedor) Then
          pAlterarGlyphButton(btnDadosSmtp, 0)
        Else
          pAlterarGlyphButton(btnDadosSmtp, 1);

        fMensagem('DADOS SMTP', 'Não foi possível conectar com o servidor SMTP. Verifique o e-Mail e senha informados ou os dados do provedor nas configurações do sistema e tente novamente!', ['&OK']);
        pAlterarGlyphButton(btnAutenticacaoSmtp, 1);
        FValidacaoEmailObrigatoria := True;
      End;

      Application.ProcessMessages;

      If TAutenticacaoEmail.fValidarAutenticacaoImap(objAutenticacaoEmail) Then
        pAlterarGlyphButton(btnDadosImap, 0)
      Else
      Begin
        fMensagem('DADOS IMAP', 'Não foi possível conectar com o servidor IMAP. Verifique o e-Mail e senha informados ou os dados do provedor nas configurações do sistema e tente novamente!', ['&OK']);
        pAlterarGlyphButton(btnDadosImap, 1);

        If Not FValidacaoEmailObrigatoria Then
        Begin
          FValidacaoEmailObrigatoria := objAutenticacaoEmail.strGravaPastaEnviados = 'S';

          If FValidacaoEmailObrigatoria Then
            fMensagem('ATENÇÃO', 'O provedor ' + cmbProvedores.Text + ' está marcado para gravar os e-mails ' +
                                 'na pasta "Enviados". Portanto é obrigatória a validação do Provedor Imap.', ['&Ok']);
        End;
      End;

      Application.ProcessMessages;
    Finally
      btnValidarDadosEmail.Caption := 'Validar dados';
      btnValidarDadosEmail.Enabled := True;
      btnLimparDadosProvedor.Enabled := True;
      FreeAndNil(objAutenticacaoEmail);
    End;
  End;
end;

procedure TfrmCadOperadores.chkMostrarSenhaClick(Sender: TObject);
begin
  inherited;

  If (chkMostrarSenha.Checked) Then
    edtSenhaEmail.PasswordChar := #0
  Else
    edtSenhaEmail.PasswordChar := '*';
end;

procedure TfrmCadOperadores.chkMsgCVAClick(Sender: TObject);
begin
  inherited;

  if chkMsgCVA.Checked then
    rdgRequisicaoComprasAtendidas.ItemIndex := 0;
end;

procedure TfrmCadOperadores.chkMsgReqCompIncluidaClick(Sender: TObject);
begin
  inherited;

  if chkMsgReqCompIncluida.Checked then
    rdgRequisicaoComprasIncluidas.ItemIndex := 0;
end;

procedure TfrmCadOperadores.chkUtiDefClick(Sender: TObject);
begin
  inherited;
  pnlPerHorOpeSis.Visible := chkUtiDef.Checked;
  pCarregaHorOpe;
end;

procedure TfrmCadOperadores.clbLoginClickCheck(Sender: TObject);
begin
  inherited;
  clbEmpresa.Checked[clbLogin.ItemIndex] := clbLogin.Checked[clbLogin.ItemIndex];
end;

procedure TfrmCadOperadores.clbPortadoresClickCheck(Sender: TObject);
begin
  inherited;
  if cdsPorOpe.RecordCount > 0 Then
  Begin
    cdsPorOpe.First;
    intPos := 0;

    While Not cdsPorOpe.Eof Do
    Begin
      cdsPorOpe.Edit;
      If (clbPortadores.Checked[intPos]) Then
      Begin
        cdsPorOpe.FieldByName('ACESSO').AsString := 'S';
      End
      Else
      Begin
        cdsPorOpe.FieldByName('ACESSO').AsString := 'N';
      End;

      cdsPorOpe.Post;

      Inc(IntPos);
      cdsPorOpe.Next;
    End;
  End;
end;

procedure TfrmCadOperadores.pAbrirPoup;
begin
  popOpSele.Popup(Mouse.CursorPos.X + 2, Mouse.CursorPos.Y + 2);
end;

procedure TfrmCadOperadores.btnAddComForClick(Sender: TObject);
begin
  inherited;

  If Not btnAddComFor.Enabled Then
    Exit;

  If fEmptyStr(dbeCodOpe.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um operador!', ['&OK']);
    Exit;
  End;

  If fEmptyStr(edtCodFor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&OK']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  If fEmptyStr(edtNomForn.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O fornecedor deve ser preenchido!', ['&OK']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  If (edtComFor.Value <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual de comissão deve ser maior que zero!', ['&OK']);
    pSetFocus(edtComFor);
    Exit;
  End;

  If objComFor.fJaInformado(dbeCodOpe.Text, edtCodFor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Fornecedor já foi informado!', ['&OK']);
    pSetFocus(edtCodFor);
    Exit;
  End;

  objComFor.pIncluir(dbeCodOpe.Text, edtCodFor.Text, edtComFor.Value);

  edtCodFor.Text := '';
  edtNomForn.Text := '';
  edtComFor.Value := 0;

  pSetFocus(edtCodFor);
end;

procedure TfrmCadOperadores.btnAdicionarAssinaturaClick(Sender: TObject);
begin
  inherited;

  // Verifica se o JPG é válido e não está corrompido
  // Evita de o cliente anexar arquivos .bmp com extensão alterada,
  // que resultava no Erro JPEG #53 (RQ.78634)
  try
    If (dlgAssinatura.Execute()) Then
    Begin
      strImagemAssinatura := dlgAssinatura.Files[0];
      imgAssinatura.Picture.LoadFromFile(strImagemAssinatura);
    End;
  except
    on E: EInvalidGraphic do
    begin
      pMensagemOK('O arquivo JPEG selecionado é inválido ou está corrompido' +#13
                 +'Verifique a integridade do arquivo e tente novamente');

      btnLimparAssinatura.Click;
    end;
  end;
end;

procedure TfrmCadOperadores.btnAdicionaTecClick(Sender: TObject);
begin
  inherited;

  if (not grpComAssTec.Visible) then
    Exit;

  if not fValidaCampos(edtCodTec, True) then
    Exit;

  if (cdsOpeATe.Locate('CODTEC', edtCodTec.Text, [])) then
  begin
    fMensagem('ATENÇÃO!', 'O Técnico ' + edtCodTec.Text + ' - ' + edtNomTec.Text + ' já foi vinculado ao operador.', ['&Ok']);
    Exit;
  end;

  cdsOpeATe.Append;
  cdsOpeATe.FieldByName('CODTEC').AsString := edtCodTec.Text;
  cdsOpeATe.FieldByName('NOMTEC').AsString := edtNomTec.Text;
  cdsOpeATe.FieldByName('OPERAC').AsString := 'I';
  cdsOpeATe.Post;

  edtCodTec.Clear;
  edtNomTec.Clear;
  pSetFocus(edtCodTec);
end;

procedure TfrmCadOperadores.btnAjudaProvedoresClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
    If Not cmbProvedores.Properties.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Gmail)', frmRelAjudaMod.frxAjudaGmail)
    Else
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Outlook/Office 365)', frmRelAjudaMod.frxAjudaOutlook);
  Finally
    FreeAndNil(frmRelAjudaMod);
  End;
end;

procedure TfrmCadOperadores.btnAlterarClick(Sender: TObject);
  Var
    strSenha: String;
begin
  {**********************************************************}
  {* VERIFICA SE O USUARIO TEM PERMISSAO PARA ALTERAR SENHA *}
  {*******************************************************LU*}
  If (fEhAdministrador(qryTabela.FieldByName('OPE_CODOPE').AsString) And
      (Not SameText(qryTabela.FieldByName('OPE_CODOPE').AsString, strLoginUsuarioLogado))) Then
  Begin
    If (Not qryTabela.IsEmpty) And
       (fMensagem('AVISO!', 'Deseja alterar a senha?', ['&Sim', '&Não']) = 1) Then
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If (strSenha = fDecrypt(qryTabela.FieldByName('OPE_SENOPE').AsString)) Then
        Begin
          edtSenha.Enabled    := True;
          edtConSenha.Enabled := True;
          dbeNumCpf.Enabled   := True;
          dbeIntExt.Enabled   := True;
          cmbProvedores.Enabled := True;
          inherited;
          pHabilitaCodigo(dbeCodOpe, dbeNomOpe, False);
          clbEmpresa.Enabled      := True;
          clbIncRom.Enabled       := True;
          clbLogin.Enabled        := True;
          clbEmpMltLjs.Enabled    := True;
          clbEmpEstMin.Enabled    := True;
          clbEmpresasNotificacaoColetor.Enabled := True;
          clbBaixaReceber.Enabled := True;
          clbBaixaPagar.Enabled   := True;
          clbPortadores.Enabled   := fVerificaAcessoSistema('POROPE');
          clbEmpEst.Enabled := True;
          clbEmpConsVendFatur.Enabled := True;
          clbEmpLibRemota.Enabled := True;
          clbEmpReimpressaoDocs.Enabled := True;
          pEnabledLabel(True);
        End
        Else
        Begin
          edtSenha.Enabled    := False;
          edtConSenha.Enabled := False;
          dbeNumCpf.Enabled   := False;
          dbeIntExt.Enabled   := False;
          cmbProvedores.Enabled := False;
          Exit;
        End;
      End;
    End
    Else
    Begin
      inherited;
      dbeCodOpe.Enabled := False;
      dbeNumCpf.Enabled   := True;
      dbeIntExt.Enabled   := True;
      cmbProvedores.Enabled := True;
      pHabilitaCodigo(dbeCodOpe, dbeNomOpe, False);
      edtSenha.Enabled        := False;
      edtConSenha.Enabled     := False;
      clbEmpresa.Enabled      := True;
      clbIncRom.Enabled       := True;
      clbLogin.Enabled        := True;
      clbEmpMltLjs.Enabled    := True;
      clbEmpEstMin.Enabled    := True;
      clbEmpresasNotificacaoColetor.Enabled := True;
      clbBaixaReceber.Enabled := True;
      clbBaixaPagar.Enabled   := True;
      clbPortadores.Enabled := fVerificaAcessoSistema('POROPE');
      clbEmpEst.Enabled := True;
      clbEmpConsVendFatur.Enabled := True;
      clbEmpLibRemota.Enabled := True;
      clbEmpReimpressaoDocs.Enabled := True;
      pEnabledLabel(True);
    End;
  End
  Else
    if dtsTabela.DataSet.FieldByName('OPE_CODOPE').AsString = '' then
      inherited
    else
      Begin
        inherited;
        edtSenha.Enabled    := fVerificaAcessoSistema('ALTSEN',strLoginUsuarioLogado);
        edtConSenha.Enabled := edtSenha.Enabled;
        dbeNumCpf.Enabled   := True;
        dbeIntExt.Enabled   := edtSenha.Enabled;
        cmbProvedores.Enabled := True;
        pHabilitaCodigo(dbeCodOpe, dbeNomOpe, False);
        clbEmpresa.Enabled      := True;
        clbIncRom.Enabled       := True;
        clbLogin.Enabled        := True;
        clbEmpMltLjs.Enabled    := True;
        clbEmpEstMin.Enabled    := True;
        clbEmpresasNotificacaoColetor.Enabled := True;
        clbBaixaReceber.Enabled := True;
        clbBaixaPagar.Enabled   := True;
        clbPortadores.Enabled := fVerificaAcessoSistema('POROPE');
        clbEmpEst.Enabled := True;
        clbEmpConsVendFatur.Enabled := True;
        clbEmpLibRemota.Enabled := True;
        clbEmpReimpressaoDocs.Enabled := True;
        pEnabledLabel(True);
      End;
  If (blnAlterou) Then
    pHabilitarCamposComFor(True);

  grbAssinaturaEmail.Enabled := True;
  btnValidarDadosEmail.Enabled := edtSenhaEmail.Enabled;
  btnLimparDadosProvedor.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Checked := False;

  If fCfgSis('DACPOR', VarBoolean) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    clbPortadores.Clear;

    If (cdsPorOpe.Active) and
       (cdsPorOpe.RecordCount > 0) Then
      cdsPorOpe.EmptyDataSet;
  End;

  blnCepNaoEncontradoContinuar := False;

  strCepAnt    := qryTabela.FieldByName('OPE_C_E_P_').AsString;
  pHabilitaHorOpe(True);

  btnAdicionaTec.Enabled := grpComAssTec.Visible;
  dbgOpeTec.Enabled := btnAdicionaTec.Enabled;

  FValidacaoEmailObrigatoria := False;
  pHabilitaCamposEmail(True);
end;

procedure TfrmCadOperadores.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaHorOpe(True);

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodOpe, dbeNomOpe, False)
  Else
    pHabilitaCodigo(dbeCodOpe, dbeCodOpe, True);

  edtSenha.Clear;
  edtConSenha.Clear;

  pLimparCampos;

  edtNomFor.Clear;
  edtDesDep.Clear;
  edtCidade.Clear;
  edtEstado.Clear;
  edtDesFun.Clear;

  blnCepNaoEncontradoContinuar := False;

  dbeCodFun.Field.Value    := Null;
  dbeNumCpf.Enabled        := True;
  dbeIntExt.Enabled        := True;
  cmbProvedores.Enabled    := True;
  dbeCodEmp.Field.Value    := VS_strCodEmp;
  edtDesEmp.Text           := fRetNomeEmpresa;
  dbeLimCred.Field.AsFloat := 0.0;
  dbeLimCredA.Field.AsFloat:= 0.0;
  dbeComCMF.Field.AsFloat  := 0.0;
  dbeComCFA.Field.AsFloat  := 0.0;
  dbeComCMA.Field.AsFloat  := 0.0;
  dbePerCom.Field.AsFloat  := 0.0;
  dbePerCo2.Field.AsFloat  := 0.0;
  dbeMecCIt.Field.AsFloat  := 0.0;
  dbeMecCSe.Field.AsFloat  := 0.0;
  dbeVenCSe.Field.AsFloat  := 0.0;
  dbeComAta.Field.AsFloat  := 0.0;
  dbeComVar.Field.AsFloat  := 0.0;
  dbeCom_SM.Field.AsFloat  := 0.0;
  dbeComATe.Field.AsFloat  := 0.0;
  dbeIntExt.Field.AsString := 'I';
  dbeStatus.Field.AsString := 'A';
  dbeMsgPos.Field.AsString := 'E';
  chkMsgOrc.Field.AsString := 'N';
  dbeTabPre.Field.AsString := fCfgSis('TABPAD');
  chkMsgPed.Field.AsString := 'N';
  chkMsgPedAlt.Field.AsString  := 'N';
  chkMsgPedCanc.Field.AsString := 'N';
  chkMsgTre.Field.AsString := 'N';
  chkMsgLib.Field.AsString := 'S';
  chkMsgSfa.Field.AsString := 'N';
  chkMsgLpa.Field.AsString := 'N';
  chkMsgPdl.Field.AsString := 'N';
  chkMsgDfl.Field.AsString := 'N';
  dbeTipCli.Field.AsString := 'A';
  chkMsgETF.Field.AsString := 'N';
  dbeIteMin.Field.AsString := 'N';
  chkMsgCVA.Field.AsString := 'N';
  chkItePPF.Field.AsString := 'N';

  rdgRequisicaoComprasAtendidas.Field.AsString := 'S';
  rdgRequisicaoComprasIncluidas.Field.AsString := 'S';

  chkMsgReqCompNegada.Field.AsString := 'N';
  chkDMEFEM.Field.AsString := 'N';
  chkMsgPrj.Field.AsString := 'N';
  chkMngCad.Field.AsString := 'N';
  chkPEDMLT.Field.AsString := 'S';
  chkMsgGnr.Field.AsString := 'N';
//  dbeMecani.Field.AsString := 'N';
  chkMsgTab.Field.AsString := 'N';
  chkIgMsgL.Field.AsString := 'N';
  chkMensagensPix.Field.AsString := 'N';
  chkCertificadosPix.Field.AsString := 'N';
  chkMSGDIV.Field.AsString := 'N';
  chkSinalSonoro.Field.AsString := 'S';
  chkMsgMedAtrasoClientes.Field.AsString := 'N';
  chkMSGCER.Field.AsString := 'N';

  chkMensagemPrevisionamentoCTP.Field.AsString := 'N';

  dbePrazoMedioVenda.Field.AsInteger := 0;
  dbeInformarSenhaLiberacao.Field.AsString := 'S';
  dbeAutSenhaOpe.Field.AsString := 'N';
  chkUtiDef.Field.AsString := 'N';
  pCarregaEmpresa;
  pCarregaLstEmpresa;
  pCarregaGerente;
  pCarregaSubGerente;
  pCarregaHorOpe;
  pCarregaCaixa;
  pCarregaPortadorAppSales;

  clbEmpresa.Enabled      := True;
  clbIncRom.Enabled       := True;
  clbLogin.Enabled        := True;
  clbEmpMltLjs.Enabled    := True;
  clbEmpEstMin.Enabled    := True;
  clbEmpresasNotificacaoColetor.Enabled := True;
  clbBaixaReceber.Enabled := True;
  clbBaixaPagar.Enabled   := True;
  clbPortadores.Enabled   := fVerificaAcessoSistema('POROPE');
  clbEmpEst.Enabled := True;
  clbEmpConsVendFatur.Enabled := True;
  clbEmpLibRemota.Enabled := True;
  clbEmpReimpressaoDocs.Enabled := True;
  pEnabledLabel(True);
  strCepAnt := '';

  If clbPortadores.Enabled Then
  Begin
    If (cdsPorOpe.Active) and
       (cdsPorOpe.RecordCount > 0) Then
      cdsPorOpe.EmptyDataSet;
  End;

  pHabilitarCamposComFor(True);
  If Assigned(objComFor) Then
    objComFor.pCarregar(dbeCodOpe.Text);

  grbAssinaturaEmail.Enabled := True;
  btnValidarDadosEmail.Enabled := edtSenhaEmail.Enabled;
  btnLimparDadosProvedor.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Checked := False;
  btnHeranca.Enabled := True;

  imgAssinatura.Picture.Assign(nil);
  mmoAssinatura.Lines.Clear;

  If fCfgSis('DACPOR', VarBoolean) Then
  Begin
    pgcDados.ActivePageIndex;
    clbPortadores.Clear;

    If (cdsPorOpe.Active) and
       (cdsPorOpe.RecordCount > 0) Then
      cdsPorOpe.EmptyDataSet;
  End;

  If grbRotinaFlex.Visible Then
  Begin
    dbePEEMFL.Field.AsFloat := 0.00;
    dbePEOPFL.Field.AsFloat := 0.00;
  End;

  chkMsgCRM.Field.AsString := 'N';
  grpComAssTec.Visible := dbeIntExt.KeyValue = 'T';
  chkContratoLocVencer.Field.AsString := 'N';
  chkMsgReqCompIncluida.Field.AsString := 'N';

  cdsOpeATe.EmptyDataSet;

  rdgUsaFil.Field.AsString := 'L';

  FValidacaoEmailObrigatoria := False;
  pHabilitaCamposEmail(True);
  pLimpaDadosEmail;
  cdsOpeEml.EmptyDataSet;
end;

procedure TfrmCadOperadores.btnLimparAssinaturaClick(Sender: TObject);
begin
  inherited;

  strImagemAssinatura   := '';
  imgAssinatura.Picture.Assign(Nil);
end;

procedure TfrmCadOperadores.btnLimparDadosProvedorClick(Sender: TObject);
begin
  inherited;
  If (cmbProvedores.Enabled) Then
  Begin
    If Concat(edtRemetente.Text, cmbProvedores.Text, edtEmail.Text, edtLogin.Text, edtSenhaEmail.Text) = '' Then
    Begin
      fMensagem('ATENÇÃO', 'Os dados do provedor de e-mail já estão vazios.', ['&Ok']);
      Exit;
    End;

    If fMensagem('ATENÇÃO', 'Deseja realmente limpar os dados do provedor?', ['&Sim', '&Não']) = 2 Then
      Exit;

    cmbProvedores.EditValue := Null;
    edtRemetente.Text := '';
    edtEmail.Text := '';
    edtLogin.Text := '';
    edtSenhaEmail.Text := '';

    FValidacaoEmailObrigatoria := False;
  End;
end;

procedure TfrmCadOperadores.pResetarBotoesAutDadosEmail;
begin
  btnDadosSmtp.Glyph.Assign(nil);
  imgValidacaoEmail.GetBitmap(1, btnDadosSmtp.Glyph);
  btnDadosImap.Glyph.Assign(nil);
  imgValidacaoEmail.GetBitmap(1, btnDadosImap.Glyph);
  btnAutenticacaoSmtp.Glyph.Assign(nil);
  imgValidacaoEmail.GetBitmap(1, btnAutenticacaoSmtp.Glyph);
end;

procedure TfrmCadOperadores.pRetSenha;
begin
  edtSenha.Text      := fDecrypt(qryTabela.FieldByName('OPE_SENOPE').AsString);
  edtConSenha.Text   := fDecrypt(qryTabela.FieldByName('OPE_SENOPE').AsString);
end;

procedure TfrmCadOperadores.pSalvarImagemAssinatura;
begin
  inherited;

  If (Not Assigned(imgAssinatura.Picture.Graphic))
      and (fEmptyStr(mmoAssinatura.Lines.Text))
      and (FDatasetOpeAss.IsEmpty) Then
    Exit;

  Try
    If (Not Assigned(imgAssinatura.Picture.Graphic))
      and (fEmptyStr(mmoAssinatura.Lines.Text))
      and (Not FDatasetOpeAss.IsEmpty) Then
    Begin
      FDatasetOpeAss.Delete;
    End
    Else
    Begin
      If FDatasetOpeAss.IsEmpty Then
      Begin
        If (Not FDatasetOpeAss.Active) Then
          FDatasetOpeAss.Open;
        FDatasetOpeAss.Append;
        FDatasetOpeAss.FieldByName('ASS_CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
      End
      Else
        FDatasetOpeAss.Edit;

      If (Not fEmptyStr(mmoAssinatura.Lines.Text)) Then
        FDatasetOpeAss.FieldByName('ASS_TEXTO_').AsString := AnsiReplaceStr(mmoAssinatura.Lines.Text, STRING_ENTER, STRING_QUEBRA);

      If (strImagemAssinatura <> '') Then
      Begin
        FDatasetOpeAss.FieldByName('ASS_IMGB64').AsString := fBase64FromFile(strImagemAssinatura);
      End
      Else If Not Assigned(imgAssinatura.Picture.Graphic) Then
        FDatasetOpeAss.FieldByName('ASS_IMGB64').Clear;

      FDatasetOpeAss.Post;
    End;
  Finally
    grbAssinaturaEmail.Enabled := False;
    btnValidarDadosEmail.Enabled := edtSenhaEmail.Enabled;
    btnLimparDadosProvedor.Enabled := edtSenhaEmail.Enabled;
    chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
    chkMostrarSenha.Checked := False;
  End;
end;

procedure TfrmCadOperadores.pSetaCheckList(ASelecionados: array of TCheckListBox);
var
  intCont: Integer;
begin
  SetLength(clbSelecionados, Length(ASelecionados));
  for intCont := Low(ASelecionados) to High(ASelecionados) do
    clbSelecionados[intCont] := ASelecionados[intCont];
end;

procedure TfrmCadOperadores.rdgUsaFilClick(Sender: TObject);
begin
  inherited;
  lkpFilaEnvio.ListSource := fListaFilas;
end;

procedure TfrmCadOperadores.tsFinanceiroShow(Sender: TObject);
begin
  inherited;
  If clbPortadores.Count > 0 Then
    Exit;

  fCarregaPortadoresOperador;
end;

procedure TfrmCadOperadores.FormShow(Sender: TObject);
Var
  intCon: Integer;
begin
  inherited;
  pRetSenha;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  {*************************************}
  { HAB SOMENTE AS TABS CONFORME A CFG  }
  {**********************************JB*}
  strVrfTpr := EmptyStr;
  clbTabPre.Caption := EmptyStr;

  For intCon:= 1 To Length(Trim(VS_strTabVen)) Do
  Begin
    strVrfTpr := strVrfTpr + IfThen(SameText(VS_strTabVen[intCon], 'S'), IntToStr(intCon), '');
    If (VS_strTabVen[intCon] = 'S') Then
    Begin
      If intCon <> Length(Trim(VS_strTabVen)) Then
        clbTabPre.Caption := clbTabPre.Caption + ' (' + IntToStr(intCon) + ')'
      Else
        clbTabPre.Caption := clbTabPre.Caption + ' ou (' + IntToStr(intCon) + ')'
    End;
  End;

  lblTabPre.Visible := fCfgSis('HIETAB', VarBoolean);
  dbeTabPre.Visible := fCfgSis('HIETAB', VarBoolean);
  clbTabPre.Visible := fCfgSis('HIETAB', VarBoolean);

  lblFuncionario.Visible := fCfgSis('VINCOF', varBoolean);
  dbeCodFun.Visible := lblFuncionario.Visible;
  edtDesFun.Visible := lblFuncionario.Visible;

  If (Not (fCfgSis('MSGTRE', varBoolean))) Then
    chkMsgTre.Visible := False
  Else
    chkMsgTre.Visible := True;

  If (Not (fCfgSis('HABREM', varBoolean))) Then
    chkMsgLib.Visible := False
  Else
    chkMsgLib.Visible := True;

  pCarregaListTipVen;
  pCarregaLstEmpresa;

  If Not fEmptyStr(strCodOperadorIniciarCadastro) Then
    pBuscaOperador(strCodOperadorIniciarCadastro);

  If (fCfgSis('OPCCOM', varString) = 'D') Or
     (fCfgSis('OPCCOM', varString) = 'MV') Or
     (fCfgSis('OPCCOM', varString) = 'MVI') Then
    btnComissao.Visible := True
  Else
    btnComissao.Visible := False;

  grpComMecanicos.Visible := (fCfgSis('AUTCEN', VarBoolean)) And
                             (fCfgSis('OPCMEC', VarString ) = 'CO');//Opcao de Comissao Mecanico: (C)adastro de (O)peradores

  grbComSerVen.Visible    := (fCfgSis('AUTCEN', VarBoolean)) And
                             (fCfgSis('OPCVEN', VarString ) = 'CO');//Opcao de Comissao Mecanico: (C)adastro de (O)peradores

  lblLimCred.Visible := fCfgSis('LMCROP', VarBoolean);
  dbeLimCred.Visible := lblLimCred.Visible;
  shpLimCred.Visible := lblLimCred.Visible;

  lblLimCredA.Visible := lblLimCred.Visible;
  dbeLimCredA.Visible := lblLimCred.Visible;
  shpLimCredA.Visible := lblLimCred.Visible;

  pVerdeVermelho(dbeLimCred, shpLimCred, fVerificaAcessoSistema('LMCROP'), False, False);
  pVerdeVermelho(dbeLimCredA, shpLimCredA, fVerificaAcessoSistema('LMCROP'), False, False);

  pVerdeVermelho(dbeInformarSenhaLiberacao, shpInformarSenhaLiberacao, fVerificaAcessoSistema('ISLTRA'), False, False);

  chkMsgPdl.Visible := fCfgSis('LIBPCM', varBoolean);
  chkMsgTab.Visible := (fCfgSis('LIBPED', varBoolean) And fCfgSis('LIBSFA', varBoolean));

  chkMensagensPix.Visible := fCfgSis('USAPIX', varBoolean);
  chkCertificadosPix.Visible := chkMensagensPix.Visible;
  chkItePPF.Visible := fCfgSis('USA_PF', varBoolean);

  chkMsgDfl.Visible := fUsaRotinaWMS And (fCfgSis('WMSSEP') = '2');

  chkMensagemPrevisionamentoCTP.Visible := fCfgSis('CTPPRE') = 'S';

  chkMngCad.Visible := fCfgSis('UTIWMS', varBoolean) And fCfgSis('MNGCAD', varBoolean);

  chkMSGDIV.Visible := fCfgSis('UTIWMS', varBoolean) And (fCfgSis('TPLREC', varString) <> 'N') And (fCfgSis('TIPPNT', varString) = 'D');

  tbsGeral.Show;

  pMontaTitulosPageControl;

  pHabilitarCamposComFor(False);

  chkMsgPrj.Visible := fCfgSis('UTLPRJ', varBoolean);

  grbRotinaFlex.Visible := (fCfgSis('ROTFLE') = '2') And (fCfgSis('USAFLE', varBoolean));

  chkEmaAut.Visible := Not fEmptyStr(fCfgSis('OPEAUT', varString));

  btnAdicionaTec.Enabled := False;
  dbgOpeTec.Enabled := btnAdicionaTec.Enabled;

  grpMltLjs.Visible := (fCfgSis('EMPFAT', varBoolean) Or fCfgSis('EMPFVN', varBoolean));

  grpEstMin.Visible := fCfgSis('UTINEM', varBoolean);

  pnlPortifolioContele.Visible := fCfgSis('APICON', varBoolean);
end;

procedure TfrmCadOperadores.pCancelarAlteracaoImagemAssinatura;
begin
  imgAssinatura.Picture.Assign(nil);
  mmoAssinatura.Lines.Clear();

  pCarregarImagemAssinatura;

  If FDatasetOpeAss.IsEmpty Then
    Exit;

  If Not FDatasetOpeAss.FieldByName('ASS_TEXTO_').AsString.IsEmpty Then
    mmoAssinatura.Text := FDatasetOpeAss.FieldByName('ASS_TEXTO_').AsString;
end;

procedure TfrmCadOperadores.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, dbeCodCid.Text);

  With qryConCid Do
  Begin

    edtCidade.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
    If (dbeNumCep.Field <> Nil) And (dbeNumCep.Field.IsNull) and fEmptyStr(dbeNumCep.Text) Then
    Begin
      dbeNumCep.Text := FieldByName('CID_C_E_P_').AsString;
      strCepAnt   := FieldByName('CID_C_E_P_').AsString;
    End;

  End;
end;

Function TfrmCadOperadores.fRetEmpresasSel(clbEmpresa: TCheckListBox): String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
End;

procedure TfrmCadOperadores.btnGravarClick(Sender: TObject);
  Var
    strEmpLog   : String;
    strEmpAce   : String;
    blnGravouPor: Boolean;
    blnInsert   : Boolean;
begin
  blnGravouPor := True;
  blnGravacao := True;

  Try
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    blnInsert := (qryTabela.State In [dsInsert]);

    If (Not blnUsaEmailPorEmpresa ) And (FValidacaoEmailObrigatoria) Then
    Begin
      If Not qryTabela.FieldByName('OPE_CODPRV').AsString.IsEmpty Then
      Begin
        fMensagem('ATENÇÃO', 'Os dados de autorização do e-mail foram alterados e ' +
                             'é obrigatória a validação dos dados informados.' + #13 +
                             'Clique em validar dados antes de confirmar as alterações.', ['&Ok']);

        pgcDados.ActivePage := tbsEmail;

        Exit;
      End;
    End;

    If (fEmptyStr(dbeCodFor.Text)) Then
      qryTabela.FieldByName('OPE_CODFOR').Value := Null;

    If (fEmptyStr(dbeCodDep.Text)) Then
      qryTabela.FieldByName('OPE_CODDEP').Value := Null;

    If (fEmptyStr(dbeCodGer.Text)) Then
      qryTabela.FieldByName('OPE_CODGER').Value := Null;

    If (fEmptyStr(dbeCodSub.Text)) Then
      qryTabela.FieldByName('OPE_CODSUB').Value := Null;

    If (fEmptyStr(dbeCodCax.Text)) Then
      qryTabela.FieldByName('OPE_CODCAX').Value := Null;

    If dbeCodFun.Visible And (fEmptyStr(dbeCodFun.Text)) Then
      qryTabela.FieldByName('OPE_CODFUN').Value := Null;

    qryTabela.FieldByName('OPE_MODCLA').Value := IfThen(blnUsuarioLogadoUtilizaModoClassico, 'S', 'N');

    If (tbsPermissaoHorariosOperacaoSistema.TabVisible) And (chkUtiDef.Checked) Then
    Begin
      blnValidou := THorOpe.fValidacoes(cdsHorOpe);
      If (Not blnValidou) Then
      Begin
        tbsPermissaoHorariosOperacaoSistema.Show;
        Exit;
      End;
    End;

    If (Not fValidaEmpresasSelecionadas) Then
      Exit;

    {**********************************}
    {* SALVA AS EMPRESAS SELECIONADAS *}
    {*******************************LU*}
    qryTabela.FieldByName('OPE_EMPROM').Value := fRetEmpresasSel(clbIncRom);
    qryTabela.FieldByName('OPE_EMPCTR').Value := fRetEmpresasSel(clbBaixaReceber);
    qryTabela.FieldByName('OPE_EMPCTP').Value := fRetEmpresasSel(clbBaixaPagar);
    qryTabela.FieldByName('OPE_EMPEST').Value := fRetEmpresasSel(clbEmpEst);
    qryTabela.FieldByName('OPE_EMPFAT').Value := fRetEmpresasSel(clbEmpConsVendFatur);
    qryTabela.FieldByName('OPE_EMPLIB').Value := fRetEmpresasSel(clbEmpLibRemota);
    qryTabela.FieldByName('OPE_EMPRDS').Value := fRetEmpresasSel(clbEmpReimpressaoDocs);
    qryTabela.FieldByName('OPE_EMPMTL').Value := fRetEmpresasSel(clbEmpMltLjs);
    qryTabela.FieldByName('OPE_EMPESM').Value := fRetEmpresasSel(clbEmpEstMin);

    If fEmptyStr(dbeCodBar.Text) {And
       (fMensagem('', 'Deseja gerar um Código de Barras para o operador?', ['&Sim', '&Não']) = 1)} Then
    Begin
      dbeCodBar.Text := fGeraCodBarraEAN13(RightStr('111100' +  dbeCodEmp.Text + fRetNumero(dbeCodOpe.Text), 12));
    End;

    strEmpLog := fRetEmpresasSel(clbLogin);

    If fEmptyStr(strEmpLog) Then
    Begin
      fMensagem('', 'Nenhuma Empresa de Login para acesso foi selecionada!',['&OK']);
      tbsAcessoEmp.Show;
      pSetFocus(clbEmpresa);
      Exit;
    End
    Else
      qryTabela.FieldByName('OPE_EMPLOG').Value := strEmpLog;

  strEmpAce := fRetEmpresasSel(clbEmpresa);

  If fEmptyStr(strEmpAce) Then
  Begin
    fMensagem('', 'Nenhuma Empresa - Acesso foi selecionada!',['&OK']);
    tbsAcessoEmp.Show;
    pSetFocus(clbEmpresa);
    Exit;
  End
  Else
    qryTabela.FieldByName('OPE_EMPACE').Value := strEmpAce;

    pLimpaProvedor;

    pSalvaEmpresasNotificacaoColetor();

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    Try
      inherited;

      pHabilitaHorOpe(False);

      If (Not blnValidou) Then
      begin
        fRollBack;
        Exit;
      End;


      If blnGravou Then
      Begin
        If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If fOperadorNaoAcessaPortadores Then
            blnGravouPor := fCarregaPortadoresOperador;

          If blnGravouPor Then
            blnGravouPor := fGravaPortadoresOperador;
        End;

        pResetarBotoesAutDadosEmail();
        pGravarOpeATe();
      End;

      If blnGravou And blnGravouPor Then
      Begin
        If Assigned(objComFor) Then
          objComFor.pConfirmarGravacao(dbeCodOpe.Text);

        If blnInsert Then
        Begin
          qryTabela.Edit;
          qryTabela.FieldByName('OPE_ALTSEN').AsDaTeTime := VS_Date;
          qryTabela.FieldByName('OPE_SENEXP').AsString := 'N';
          qryTabela.Post;
        End;

        qryTabela.Edit;
        qryTabela.FieldByName('OPE_SENOPE').AsString := fCrypt(edtSenha.Text);
        qryTabela.Post;

        pGravaDadosEmail;

        blnGravou := False;

        pgcDados.ActivePage := tbsGeral;
        btnComissao.Enabled := False;

        If Assigned(objComFor) Then
          objComFor.pCarregar(dbeCodOpe.Text);

        If (tbsPermissaoHorariosOperacaoSistema.TabVisible) And (chkUtiDef.Checked) Then
        Begin
          blnGravou := THorOpe.fGravarHorOpe(cdsHorOpe, dbeCodOpe.Text);
          If blnGravou Then
            pCarregaHorOpe;
        End;

        fCommit;

      End
      Else
        fRollBack;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'[untCadOperadores.btnGravarClick]');
      End;
    End;

    clbEmpresa.Enabled      := False;
    clbIncRom.Enabled       := False;
    clbLogin.Enabled        := False;
    clbEmpresasNotificacaoColetor.Enabled := False;
    clbPortadores.Enabled   := False;
    clbBaixaReceber.Enabled := False;
    clbBaixaPagar.Enabled   := False;
    clbEmpEst.Enabled       := False;
    clbEmpConsVendFatur.Enabled := False;
    clbEmpLibRemota.Enabled := False;
    clbEmpMltLjs.Enabled    := False;
    clbEmpEstMin.Enabled    := False;
    clbEmpReimpressaoDocs.Enabled := False;

    dbeNumCpf.Enabled       := False;
    dbeIntExt.Enabled       := False;
    cmbProvedores.Enabled   := False;
    btnHeranca.Enabled := False;
    pEnabledLabel(False);
    pAtualizaLstEmpresa('OPE_EMPACE', clbEmpresa);
    pAtualizaLstEmpresa('OPE_EMPROM', clbIncRom);
    pAtualizaLstEmpresa('OPE_EMPLOG', clbLogin);
    pAtualizaLstEmpresa('OPE_EMPCTR', clbBaixaReceber);
    pAtualizaLstEmpresa('OPE_EMPCTP', clbBaixaPagar);
    pAtualizaLstEmpresa('OPE_EMPEST', clbEmpEst);
    pAtualizaLstEmpresa('OPE_EMPFAT', clbEmpConsVendFatur);
    pAtualizaLstEmpresa('OPE_EMPLIB', clbEmpLibRemota);
    pAtualizaLstEmpresa('OPE_EMPMTL', clbEmpMltLjs);
    pAtualizaLstEmpresa('OPE_EMPESM', clbEmpEstMin);
    pAtualizaLstEmpresa('OPE_EMPRDS', clbEmpReimpressaoDocs);
    pAtualizaEmpresasNotificacaoColetor();

    {**************************************************}
    {* ATUALIZA AS EMPRESAS QUE O OPERADOR TEM ACESSO *}
    {***********************************************LU*}
    strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(strLoginUsuarioLogado);
    strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);
    pHabilitarCamposComFor(False);
    btnAdicionaTec.Enabled := False;
    dbgOpeTec.Enabled := btnAdicionaTec.Enabled;

  blnCepNaoEncontradoContinuar := False;

  ExibeAjudaProvedores;
  ExibeSenhaEmailOperador;

  FValidacaoEmailObrigatoria := False;
    pHabilitaCamposEmail(False);
  Finally
    blnGravacao := False;
  End;
end;

procedure TfrmCadOperadores.btnHerancaClick(Sender: TObject);
begin
  inherited;
  pExecutaHeranca;
end;

procedure TfrmCadOperadores.pExecutaHeranca;
  Var
    frmHeranca: TfrmHerancaOperador;
begin
  pCriarFormularios(TfrmHerancaOperador, frmHeranca);

  Try
    Try
      If (frmHeranca.ShowModal = mrOk) Then
      Begin
        pCopiaDadosHeranca(frmHeranca.getQryCadOpe());
        pCarregaDadosHeranca;
        pLimpaDadosPessoaisHerdados;
        pRecarregaSubTabelas;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadOperadores.pExecutaHeranca]');
    End;
  Finally
    pFreeAndNil(frmHeranca);
  End;
end;

procedure TfrmCadOperadores.pCarregaDadosHeranca;
begin
  pCarregarOperador(False);

  If (fCfgSis('DACPOR', varBoolean)) Then
    fCarregaPortadoresOperador;
end;

procedure TfrmCadOperadores.pRecarregaSubTabelas;
begin
  pRecarregaComFor;
  pRecarregaOpeAte;
end;

procedure TfrmCadOperadores.pLimpaDadosPessoaisHerdados;
begin
  qryTabela.FieldByName('OPE_CODOPE').Clear;
  qryTabela.FieldByName('OPE_SENOPE').Clear;
  pLimpaSenhaEmail;
end;

procedure TfrmCadOperadores.pRecarregaOpeAte;
begin
  If (cdsOpeATe = Nil) Then
    Exit;

  While (Not cdsOpeATe.Eof) Do
  Begin
    cdsOpeATe.Edit;
    cdsOpeATe.FieldByName('AUTINC').AsString := '';
    cdsOpeATe.FieldByName('OPERAC').AsString := 'I';
    cdsOpeATe.Post;
    cdsOpeATe.Next;
  End;

  btnAdicionaTec.Enabled := grpComAssTec.Visible;
  dbgOpeTec.Enabled := btnAdicionaTec.Enabled;
end;

procedure TfrmCadOperadores.pRecarregaComFor;
  Var
    cdsClone: TUniClientDataSet;
begin
  If (objComFor = Nil) Or (objComFor.fGetCds = Nil) Then
    Exit;

  cdsClone := TUniClientDataSet.Create(Self);

  Try
    pCloneDataSet(cdsClone, objComFor.fGetCds);
    objComFor.fGetCds.EmptyDataSet;
    cdsClone.First;

    While (Not cdsClone.Eof) Do
    Begin
      objComFor.pIncluir(dbeCodOpe.Text, cdsClone.FieldByName('FOR_CODFOR').AsString,
        cdsClone.FieldByName('FOR_PERCOM').AsFloat);
      cdsClone.Next;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadOperadores.pCopiaDadosHeranca(qryDados: TUniQuery);
  Var
    intCont: Integer;
    strNomCampo: String;
Begin
  If (qryDados.IsEmpty) Then
    Exit;

  For intCont := 0 To pred(qryDados.FieldCount) Do
  Begin
    strNomCampo := qryDados.Fields[intCont].FieldName;

    If (qryTabela.FindField(strNomCampo) <> nil) Then
      qryTabela.FindField(strNomCampo).Value := qryDados.Fields[intCont].Value;
  End;
end;

procedure TfrmCadOperadores.btnHlpBaixaPagarClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbBaixaPagar.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para operações relacionadas com Contas a Pagar:')
      .fAddLinhaTexto('-Baixa de Contas a Pagar')
      .fAddLinhaTexto('-Liberação de baixa de Contas a Pagar')
      .fAddLinhaTexto('-Manutenção coletiva das duplicatas de Geração Automática')
      .fAddLinhaTexto('-Seleção de duplicatas para vínculo DDA (Autban)');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpBaixaReceberClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbBaixaReceber.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para operações relacionadas com Contas a Receber:')
      .fAddLinhaTexto('-Baixa de Contas a Receber')
      .fAddLinhaTexto('-Utilização de Créditos de Cliente')
      .fAddLinhaTexto('-Relatório de Conta Corrente a Receber')
      .fAddLinhaTexto('-Geração de Duplicatas (Autban)');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpConsVendFuturClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpConsVendFatur.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para visualizar as últimas vendas:')
      .fAddLinhaTexto('-Faturamento: Vendas por Cliente, Últimas Vendas e Vendas por Linha')
      .fAddLinhaTexto('-Consulta de Produtos: Itens Vendidos');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpEmpEstClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpresaEstoque.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para operações relacionadas a estoque, como:')
      .fAddLinhaTexto('-Liberação remota de itens sem saldo multiloja, quando CFG_TRAEST = "item a item" '+
                      '(obs: também é necessário permissão na empresa em "Acesso para receber liberação remota")')
      .fAddLinhaTexto('-Visualizar saldo de produto nas lojas');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpEmpresaClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpresaAcesso.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para liberação local, recebimento de '+
                      'mensagens do faturamento, além das rotinas que envolvem empresa, como:')
      .fAddLinhaTexto('Cadastros, relatórios, movimentações, entre outros.');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpLibRemotaClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpLibRemota.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para receber, liberar e negar as Liberações Remotas');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpLoginClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpresaLogin.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para logar no sistema');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpReimpressaoDocsClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpReimpressaoDocs.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso a Reimpressão de Documentos');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpRomClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(gpbEmpresaIncRom.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso para operações relacionadas a Romaneio, como:')
      .fAddLinhaTexto('Geração, manutenção e ativação de Pré-Romaneio');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnHlpEmpMltLjsClick(Sender: TObject);
  Var
    frmAjudaPorAbas: TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Acesso Empresa';
    frmAjudaPorAbas.fAddPagina
      .fSetaTituloGuia('Ajuda')
      .fSetaTituloPagina(grpMltLjs.Caption)
      .fAddLinhaTexto('Empresa(s) que o operador tem acesso multiloja no faturamento (quando utiliza CFG_EMPFAT ou CFG_EMPFVN)');

    frmAjudaPorAbas.ShowModal;
  Finally
    pFreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadOperadores.btnEmailAddClick(Sender: TObject);
begin
  inherited;

  If (fValidaDadosEmail) Then
  Begin
    pAdicionaDadosEmail;
    pLimpaDadosEmail;
    dbgEmails.Enabled := True;
  End;
end;

procedure TfrmCadOperadores.btnEmailCanClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosEmail;
  dbgEmails.Enabled := True;
end;

function TfrmCadOperadores.fValidarInativacaoExclusaoOperador: Boolean;
var
  LstrEmpresas: String;
begin
  Result := True;

  LstrEmpresas := fRetEmpresasPorConfiguracaoEValor('CFG_GATOPE', dbeCodOpe.Text);
  if not fEmptyStr(LstrEmpresas) then
  begin
    pMensagemOk('O operador está sendo usado na configuração "CFG_GATOPE" nas empresas '+LstrEmpresas+'. Portanto, não pode ser desativado ou excluído!');
    Result := False;
  end;
end;

procedure TfrmCadOperadores.btnExcluirClick(Sender: TObject);
begin
  strCodOpe := dbeCodOpe.Text;

  if not fValidarInativacaoExclusaoOperador then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
    pHabilitaHorOpe(False);

    If blnExcluiu Then
    Begin
      pExcluiPortador;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'[untCadOperadores.btnExcluirClick]');
    End;
  End;

  pCarregaCidade;
  pCarregaEmpresa;
  pCarregaFuncionario;
  pCarregaGerente;
  pCarregaSubGerente;
  pCarregaHorOpe;
  pCarregaCaixa;
  pCarregaOpeATe;
  pCarregaPortadorAppSales;

  If Not fEmptyStr(dbeCodOpe.Text) Then
  Begin
    qryTabela.Edit;
    edtSenha.Text      := fDecrypt(qryTabela.FieldByName('OPE_SENOPE').AsString);
    edtConSenha.Text   := edtSenha.Text;
    edtSenhaEmail.Text := '';
  End;

  grbAssinaturaEmail.Enabled := False;
  btnValidarDadosEmail.Enabled := edtSenhaEmail.Enabled;
  btnLimparDadosProvedor.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Checked := False;

  blnCepNaoEncontradoContinuar := False;

  pCancelarAlteracaoImagemAssinatura();
  ExibeAjudaProvedores;
  ExibeSenhaEmailOperador;
end;

procedure TfrmCadOperadores.dbeCodCaxEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Para operador de caixa, é possível identificar o caixa que esse trabalha.' +
                     'O preenchimento não é obrigatório.';
  pnlInfo.Font.Color := clRed;
end;

procedure TfrmCadOperadores.dbeCodCaxExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
  pnlInfo.Font.Color := clBlack;
end;

procedure TfrmCadOperadores.dbeCodCaxKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCaixa: TConsultasArray;
begin
  inherited;
  If fPesqCaixas(Self, dbeCodCax, edtDesCaixa, Nil, Key, arrCaixa, True, VS_strCodEmp, True) Then
  Begin
    If fValidaCampos(dbeCodCax, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadOperadores.dbeCodCidChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadCid(Key);
end;

procedure TfrmCadOperadores.dbeCodCidKeyPress(Sender: TObject;
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

procedure TfrmCadOperadores.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaHorOpe(False);

  pCarregaCidade;
  pCarregaEmpresa;
  pCarregaFuncionario;
  pCarregaGerente;
  pCarregaSubGerente;
  pCarregaHorOpe;
  pCarregaCaixa;
  pCarregaPortadorAppSales;

  If Assigned(objComFor) Then
  Begin
    objComFor.pCancelarAlteracoes;
    objComFor.pCarregar(dbeCodOpe.Text);
  End;

  btnComissao.Enabled := False;
  btnHeranca.Enabled := False;
  pAtualizaLstEmpresa('OPE_EMPACE', clbEmpresa);
  pAtualizaLstEmpresa('OPE_EMPROM', clbIncRom);
  pAtualizaLstEmpresa('OPE_EMPLOG', clbLogin);
  pAtualizaLstEmpresa('OPE_EMPCTR', clbBaixaReceber);
  pAtualizaLstEmpresa('OPE_EMPCTP', clbBaixaPagar);
  pAtualizaLstEmpresa('OPE_EMPEST', clbEmpEst);
  pAtualizaLstEmpresa('OPE_EMPFAT', clbEmpConsVendFatur);
  pAtualizaLstEmpresa('OPE_EMPLIB', clbEmpLibRemota);
  pAtualizaLstEmpresa('OPE_EMPMTL', clbEmpMltLjs);
  pAtualizaLstEmpresa('OPE_EMPESM', clbEmpEstMin);
  pAtualizaLstEmpresa('OPE_EMPRDS', clbEmpReimpressaoDocs);
  pAtualizaEmpresasNotificacaoColetor();
  clbEmpresa.Enabled   := False;
  clbIncRom.Enabled    := False;
  clbLogin.Enabled     := False;
  clbEmpresasNotificacaoColetor.Enabled := False;
  pEnabledLabel(False);
  clbPortadores.Clear;

  clbPortadores.Enabled   := False;
  clbBaixaReceber.Enabled := False;
  clbBaixaPagar.Enabled   := False;
  clbEmpEst.Enabled   := False;
  clbEmpConsVendFatur.Enabled := False;
  clbEmpLibRemota.Enabled := False;
  clbEmpMltLjs.Enabled := False;
  clbEmpEstMin.Enabled := False;
  clbEmpReimpressaoDocs.Enabled := False;

  dbeNumCpf.Enabled   := False;
  dbeIntExt.Enabled   := False;
  cmbProvedores.Enabled := False;
  pHabilitarCamposComFor(False);
  btnAdicionaTec.Enabled := False;
  dbgOpeTec.Enabled := btnAdicionaTec.Enabled;
  grbAssinaturaEmail.Enabled := False;
  btnValidarDadosEmail.Enabled := edtSenhaEmail.Enabled;
  btnLimparDadosProvedor.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Enabled := edtSenhaEmail.Enabled;
  chkMostrarSenha.Checked := False;

  pResetarBotoesAutDadosEmail();

  blnCepNaoEncontradoContinuar := False;

  pCancelarAlteracaoImagemAssinatura();

  grpComAssTec.Visible := dbeIntExt.KeyValue = 'T';
  pCarregaOpeATe;

  tbsGeral.Show;

  FValidacaoEmailObrigatoria := False;
  pLimpaDadosEmail;
  pCarregaDadosEmail;
  pHabilitaCamposEmail(False);
end;

function TfrmCadOperadores.dbeCodEmpChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadEmp(Key);
end;

procedure TfrmCadOperadores.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadOperadores.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);

  With qryConEmp Do
  Begin
    edtDesEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;

end;

procedure TfrmCadOperadores.pCarregaCaixa;
begin
  edtDesCaixa.Text := fCampoTabela('CAX_DESCRI',
                                   'CADCAX',
                                   ['CAX_CODCAX', 'CAX_CODEMP', 'CAX_STATUS'],
                                   [dbeCodCax.Text, VS_strCodEmp, 'A']);
end;

function TfrmCadOperadores.dbeCodForChamaCadastro(Key: Word): string;
begin
  inherited;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  Result := untFuncIns.fChamaCadFor(Key);
end;

procedure TfrmCadOperadores.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadOperadores.dbeCodFunChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaForm(Key, TfrmCadFuncionarios, frmCadFuncionarios);
end;

procedure TfrmCadOperadores.dbeCodFunKeyPress(Sender: TObject; var Key: Char);
Var
  arrFun: TConsultasArray;
begin
  inherited;
  If fPesqFuncionarios(Self, dbeCodFun, edtDesFun, Nil, Key, arrFun) Then
  Begin
    If fValidaCampos(dbeCodFun, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadOperadores.dbeCodGerKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOpe : TConsultasArray;
begin
  inherited;                                                   
  If fPesqOperador(Self, dbeCodGer, edtDesGer, Nil, Key, arrOpe, True, True, True) Then
  Begin
    If fValidaCampos(dbeCodGer, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadOperadores.dbeCodPorAppKeyPress(Sender: TObject;
  var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples, Self, dbeCodPorApp, edtDesPorApp, Nil, Key, arrSel) Then
  begin
    if fValidaCampos(dbeCodPorApp, True) then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadOperadores.dbeCodSubKeyPress(Sender: TObject; var Key: Char);
  Var
    arrOpe : TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, dbeCodSub, edtDesSub, Nil, Key, arrOpe, True, True, False, False, False, False, False, True) Then
  Begin
    If fValidaCampos(dbeCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadOperadores.dbeE_mailExit(Sender: TObject);
begin
  inherited;
  If blnUsaEmailPorEmpresa Then
    Exit;

  //dbeE_mail e edtEmail compartilham o mesmo campo (OPE_E_MAIL) desde o requisito original 59184
  //foi adicionada a sincronização abaixo porque o edtEmail foi alterado de TDBEdit para TEdit no req 312437
  If (qryTabela.State In [dsInsert, dsEdit]) Then
    edtEmail.Text := qryTabela.FieldByName('OPE_E_MAIL').AsString;
end;

procedure TfrmCadOperadores.edtEmailExit(Sender: TObject);
begin
  inherited;
  If blnUsaEmailPorEmpresa Then
    Exit;

  //dbeE_mail e edtEmail compartilham o mesmo campo (OPE_E_MAIL) desde o requisito original 59184
  //foi adicionada a sincronização abaixo porque o edtEmail foi alterado de TDBEdit para TEdit no req 312437
  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    qryTabela.FieldByName('OPE_E_MAIL').AsString := edtEmail.Text;

    If Not FValidacaoEmailObrigatoria Then
      Exit;

    If cmbProvedores.Properties.ListSource.DataSet.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
    Begin
      If qryTabela.FieldByName('OPE_E_MAIL').OldValue <> qryTabela.FieldByName('OPE_E_MAIL').Value Then
        edtLogin.Text := edtEmail.Text;
    End;
  End;
end;

procedure TfrmCadOperadores.edtEmailChange(Sender: TObject);
begin
  inherited;
  FValidacaoEmailObrigatoria := cmbProvedores.EditValue <> Null;
end;

procedure TfrmCadOperadores.dbeIntExtExit(Sender: TObject);
begin
  inherited;
  grpComAssTec.Visible := dbeIntExt.KeyValue = 'T';
  btnAdicionaTec.Enabled := grpComAssTec.Visible;
  dbgOpeTec.Enabled := btnAdicionaTec.Enabled;
end;

procedure TfrmCadOperadores.dbeMsgPosEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeMsgPos.Text) Then
    dbeMsgPos.Text := 'E';
end;

procedure TfrmCadOperadores.dbeNumCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);
  End;

end;

procedure TfrmCadOperadores.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;

end;

procedure TfrmCadOperadores.pCarregaFuncionario;
begin
  edtDesFun.Text := EmptyStr;

  if not dbeCodFun.Visible then
    Exit;

  pPesquisaCadFun(qryConFun, qryConFun, dbeCodFun.Text);
  edtDesFun.Text := qryConFun.FieldByName('FUN_NOMFUN').AsString;
end;

procedure TfrmCadOperadores.pCarregaGerente;
begin
  edtDesGer.Text := fRetNomeOperador(dbeCodGer.Text);
end;

procedure TfrmCadOperadores.pCarregaHorOpe;
begin

  If Pos(dbeCodOpe.Text, THorOpe.fOperadoresExcecao) > 0 Then
    chkUtiDef.Enabled := False
  Else
    chkUtiDef.Enabled := True;

  If (chkUtiDef.Enabled) And (chkUtiDef.Checked) Then
    THorOpe.fCarregarHorOpe(cdsHorOpe, dbeCodOpe.Text);

end;

procedure TfrmCadOperadores.btnComissaoClick(Sender: TObject);
  Var
    frmComVendedores: TfrmComVendedores;
begin
  inherited;

  If (dbeCodOpe.Text <> '') Then
  Begin
  
    Try
      pCriarFormularios(TfrmComVendedores, frmComVendedores);
      frmComVendedores.Caption           := IIF(((fCfgSis('OPCCOM',varString) = 'MV') Or (fCfgSis('OPCCOM',varString) = 'MVI')),
                                                 'Comissão de Vendedor por Faixa de Margem',
                                                 'Comissão de Vendedor por Faixa de Desconto');
      frmComVendedores.lblCodOpe.Caption := dbeCodOpe.Text;
      frmComVendedores.lblNomOpe.Caption := dbeNomOpe.Text;
      frmComVendedores.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadOperadores.btnComissaoClick]');
      End;
    End;

    pFreeAndNil(frmComVendedores);

  End
  Else
    fMensagem('Aviso', 'Nenhum operador foi selecionado',['&OK']);
end;

procedure TfrmCadOperadores.dbeStatusEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeStatus.Text) Then
    dbeStatus.Text := 'A';
end;

procedure TfrmCadOperadores.dbeTpCoMcExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) And
     (dbeTpCoMc.Text = 'V') Then
    fMensagem('', 'A comissão será calculada multiplicando o valor informado pela quantidade dos produtos/serviços', ['&OK']);
end;

procedure TfrmCadOperadores.dbeTpCoVnExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State in [dsInsert, dsEdit]) And
     (dbeTpCoVn.Text = 'V') Then
    fMensagem('', 'A comissão será calculada multiplicando o valor informado pela quantidade dos produtos/serviços', ['&OK']);
end;

procedure TfrmCadOperadores.dbgEmailsDblClick(Sender: TObject);
begin
  inherited;
  pPreencheCamposEdicaoEmail;
end;

procedure TfrmCadOperadores.dbgEmailsKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) And (fConfirmaExclusaoEmail) Then
  Begin
    cdsOpeEml.Delete;
    pLimpaDadosEmail;
  End;
end;

procedure TfrmCadOperadores.dbgForComDblClick(Sender: TObject);
begin
  inherited;
  pEditarComissaoFornecedoresEspecificos();
end;

procedure TfrmCadOperadores.dbgForComEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Enter ou duplo clique p/ editar';
end;

procedure TfrmCadOperadores.dbgForComExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadOperadores.dbgForComKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Delete Then
    btnRemComFor.Click;

  if (Key = VK_Return) then
    pEditarComissaoFornecedoresEspecificos();
end;

procedure TfrmCadOperadores.dbgOpeTecKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_DELETE then
    pExcluirOpeATe();
end;

procedure TfrmCadOperadores.DesmarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcDesmarcar);
end;

procedure TfrmCadOperadores.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomForn, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadOperadores.edtCodTecExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodTec.Text) then
    edtNomTec.Text := EmptyStr;
end;

procedure TfrmCadOperadores.edtCodTecKeyPress(Sender: TObject; var Key: Char);
var
  qryCons: TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;

  if fEntraCons(Key) then
  begin
    qryCons := fCriaQuery(nil);

    try
      if fPesqOperador(Self, edtCodTec, edtNomTec, qryCons, Key, arrSel) then
      begin
        if (fValidaCampos(edtCodTec, True)) then
          Self.SelectNext(ActiveControl, True, True);
      end;
    finally
      FreeAndNil(qryCons);
    end;
  end;
end;

procedure TfrmCadOperadores.ExibeAjudaProvedores;
begin
  btnAjudaProvedores.Visible := False;

  If qryTabela.IsEmpty Then
    Exit;

  If fEmptyStr(cmbProvedores.Text) Then
    Exit;

  btnAjudaProvedores.Visible := Pos('.gmail.com',
                                    Concat(cmbProvedores.Properties.ListSource.Dataset.FieldByName('PRV_URIMAP').AsString,
                                          cmbProvedores.Properties.ListSource.Dataset.FieldByName('PRV_URSMTP').AsString)
                                    .ToLower) > 0;

  If Not btnAjudaProvedores.Visible Then
    btnAjudaProvedores.Visible := cmbProvedores.Properties.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S');
end;

procedure TfrmCadOperadores.ExibeSenhaEmailOperador;
begin
  lblSenhaEmail.Visible := True;
  edtSenhaEmail.Visible := True;
  chkMostrarSenha.Visible := strLoginUsuarioLogado.Equals(dbeCodOpe.Text);

  If qryTabela.IsEmpty Then
    Exit;

  If fEmptyStr(cmbProvedores.Text) Then
    Exit;

  lblSenhaEmail.Visible := Not cmbProvedores.Properties.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S');
  edtSenhaEmail.Visible := lblSenhaEmail.Visible;

  chkMostrarSenha.Visible := lblSenhaEmail.Visible;
  If lblSenhaEmail.Visible Then
    chkMostrarSenha.Visible := strLoginUsuarioLogado.Equals(dbeCodOpe.Text);
end;

procedure TfrmCadOperadores.pExecutarSelecao(Opcao: TOpcSelecao);
begin
  case Opcao of
    opcMarcar:    pMarcaDesmarca(True);
    opcDesmarcar: pMarcaDesmarca(False);
    opcInverter:  pInverteSelecao;
  End;
end;

procedure TfrmCadOperadores.pgcDadosChange(Sender: TObject);
begin
  inherited;
  ExibeAjudaProvedores;
  ExibeSenhaEmailOperador;
end;

procedure TfrmCadOperadores.pGravarOpeATe;
var
  strSQL: String;
  qryGravar: TUniQuery;
  cdsDados: TUniClientDataSet;
begin
  if (not grpComAssTec.Visible) then
    Exit;

  qryGravar := fCriaQuery;
  cdsDados  := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsOpeATe);

  cdsDados.Filtered := False;
  cdsDados.Filter   := 'OPERAC <> ''''';
  cdsDados.Filtered := True;

  try
    try
      cdsDados.First;

      while not cdsDados.Eof do
      begin
        if cdsDados.FieldByName('OPERAC').AsString = 'I' then
        begin
          strSQL := '';
          strSQL := strSQL + ' INSERT INTO OPEATE (AUTOINCREM, ATE_CODOPE, ATE_CODTEC) ';
          strSQL := strSQL + ' VALUES (:AUTINC, :CODOPE, :CODTEC) ';

          qryGravar.Close;
          qryGravar.SQL.Clear;
          qryGravar.SQL.Text := strSQL;
          qryGravar.ParamByName('AUTINC').AsString := fRetAutoIncrem('OPEATE', VS_strCodEmp);
          qryGravar.ParamByName('CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
          qryGravar.ParamByName('CODTEC').AsString := cdsDados.FieldByName('CODTEC').AsString;
          qryGravar.ExecSQL;
        end
        else if cdsDados.FieldByName('OPERAC').AsString = 'D' then
        begin
          strSQL := '';
          strSQL := strSQL + 'DELETE FROM OPEATE WHERE AUTOINCREM = :AUTINC ';

          qryGravar.Close;
          qryGravar.SQL.Clear;
          qryGravar.SQL.Text := strSQL;
          qryGravar.ParamByName('AUTINC').AsString := cdsDados.FieldByName('AUTINC').AsString;
          qryGravar.ExecSQL;
        end;

        cdsDados.Next;
      end;

      pCarregaOpeATe();
    except on E: Exception do
      begin
        pMensagensErro(E.Message,'[TfrmCadDefeitos.btnGravarClick]');
      end;
    end;
  finally
    FreeAndNil(qryGravar);
    FreeAndNil(cdsDados);
  end;
end;

function TfrmCadOperadores.fJaCarregouPortadores: Boolean;
begin
  If clbPortadores.Count > 0 Then
    Result := True
  Else
    Result := False;
end;

function TfrmCadOperadores.fOperadorNaoAcessaPortadores: Boolean;
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin

  qryAux := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM                   ';
  strSQL := strSQL + '   POROPE               ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   OPE_CODOPE = :CODOPE ';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := dbeCodOpe.Text;
    Open;
  End;

  Result := qryAux.FieldByName('QTD').AsInteger = 0;

  FreeAndNil(qryAux);

end;

procedure TfrmCadOperadores.pCarregaListTipVen;
begin
  With cdsListTipVen Do
  Begin
    With FieldDefs.AddFieldDef Do Begin Name := 'CODTIP'; DataType := ftString; Size := 001; End;
    With FieldDefs.AddFieldDef Do Begin Name := 'DESTIP'; DataType := ftString; Size := 030; End;

    CreateDataSet;
    Open;

    TListaTipoOperadores.pCarregaListaDataSet(cdsListTipVen, 'CODTIP', 'DESTIP');
  End;

  dtsListTipVen.DataSet := cdsListTipVen;
end;

procedure TfrmCadOperadores.pCarregaLstEmpresa;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      clbEmpresa.Items.Clear;
      Clear;
      Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP ORDER BY EMP_CODEMP');
      Open;
      First;
      While Not Eof Do
      Begin
        clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
        Next;
      End;

      clbIncRom.Items.Text := clbEmpresa.Items.Text;
      clbLogin.Items.Text := clbEmpresa.Items.Text;
      clbBaixaReceber.Items.Text := clbEmpresa.Items.Text;
      clbBaixaPagar.Items.Text := clbEmpresa.Items.Text;
      clbEmpEst.Items.Text := clbEmpresa.Items.Text;
      clbEmpConsVendFatur.Items.Text := clbEmpresa.Items.Text;
      clbEmpLibRemota.Items.Text := clbEmpresa.Items.Text;
      clbEmpresasNotificacaoColetor.Items.Text := clbEmpresa.Items.Text;
      clbEmpMltLjs.Items.Text := clbEmpresa.Items.Text;
      clbEmpEstMin.Items.Text := clbEmpresa.Items.Text;
      clbEmpReimpressaoDocs.Items.Text := clbEmpresa.Items.Text;
      clbEmailEmps.Items.Text := clbEmpresa.Items.Text;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmCadOperadores.pCarregaOpeATe;
var
  qryAux: TUniQuery;
  strSQL: String;
begin
  cdsOpeATe.EmptyDataSet;

  if (not grpComAssTec.Visible) or (qryTabela.IsEmpty) then
    Exit;

  qryAux := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT AUTOINCREM AUTINC, ATE_CODTEC CODTEC, ';
  strSQL := strSQL + '     (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = ATE_CODTEC) NOMTEC ';
  strSQL := strSQL + ' FROM OPEATE ';
  strSQL := strSQL + ' WHERE ATE_CODOPE = :CODOPE ';

  try
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
    qryAux.Open;

    while not qryAux.Eof do
    begin
      cdsOpeATe.Append;
      cdsOpeATe.FieldByName('AUTINC').AsString := qryAux.FieldByName('AUTINC').AsString;
      cdsOpeATe.FieldByName('CODTEC').AsString := qryAux.FieldByName('CODTEC').AsString;
      cdsOpeATe.FieldByName('NOMTEC').AsString := qryAux.FieldByName('NOMTEC').AsString;
      cdsOpeATe.FieldByName('OPERAC').AsString := '';
      cdsOpeATe.Post;

      qryAux.Next;
    end;

    cdsOpeATe.First;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadOperadores.pCarregarImagemAssinatura;
var
  LPict: TPicture;
begin
  inherited;
  imgAssinatura.Picture.Assign(Nil);
  mmoAssinatura.Lines.Clear;

  If (not ((qryTabela.Active) and (qryTabela.FieldByName('OPE_CODOPE').AsString <> ''))) Then
    Exit;

  FDatasetOpeAss := fCriaQuery;
  FDatasetOpeAss.SQL.Text := 'SELECT * FROM OPEASS WHERE ASS_CODOPE=:CODOPE';
  FDatasetOpeAss.ParamByName('CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
  FDatasetOpeAss.Open;

  If FDatasetOpeAss.IsEmpty Then
    Exit;

  If Not FDatasetOpeAss.FieldByName('ASS_IMGB64').AsString.IsEmpty Then
  Begin
    LPict := TPicture.Create();
    Try
      pImagemFromBase64(FDatasetOpeAss.FieldByName('ASS_IMGB64').AsString, LPict);

      imgAssinatura.Picture.Assign(LPict);
    Finally
      FreeAndNil(LPict);
    End;
  End;

  If Not FDatasetOpeAss.FieldByName('ASS_TEXTO_').AsString.IsEmpty Then
    mmoAssinatura.Lines.Text := AnsiReplaceStr(FDatasetOpeAss.FieldByName('ASS_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER);
end;

function TfrmCadOperadores.fCarregaPortadoresOperador: Boolean;
  Var
    strSQL   : String;
    qryAux   : TUniQuery;
    qryQtdPor: TUniQuery;
    intPos   : Integer;
    intQtdPor: Integer;
begin
  Try
    Result := True;

    If fEmptyStr(dbeCodOpe.Text) Then
      Exit;

    If fJaCarregouPortadores Then
      Exit;

    qryQtdPor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' SELECT COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM CADPOR            ';

    With qryQtdPor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      intQtdPor := FieldByName('QTD').AsInteger;
    End;

    qryCadPor := fCriaQuery(Self);

    {***********************************************}
    {* ENCONTRAR PORTADOR FILTRANDO O COD OPERADOR *}
    {********************************************MO*}
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE                           ';
    strSQL := strSQL + '   POR_CODPOR,                                 ';
    strSQL := strSQL + '   POR_NOMPOR,                                 ';
    strSQL := strSQL + '   OPE_ACESSO                                  ';
    strSQL := strSQL + ' FROM                                          ';
    strSQL := strSQL + '   CADPOR                                      ';
    strSQL := strSQL + '   LEFT JOIN POROPE ON OPE_CODPOR = POR_CODPOR ';
    strSQL := strSQL + ' WHERE                                         ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE                        ';
    strSQL := strSQL + ' ORDER BY POR_NOMPOR                           ';

    With qryCadPor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := dbeCodOpe.Text;
      Open;

      {*****************************************}
      {*** CASO NÃO ENCONTRE NENHUM REGISTRO, **}
      {****** CARREGA TODOS OS PORTADORES ******}
      {* E VAI INCLUINDO REGISTRO A REGISTRO NO }
      {**** CLIENT PARA SER EXIBIDO NA TELA ****}
      {**************************************MO*}
      If IsEmpty Then
      Begin
        qryAux := fCriaQuery(Self);

        strSQL := '';
        strSQL := strSQL + 'SELECT * FROM CADPOR ';

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strSQL);
        qryAux.Open;

        With qryAux Do
        Begin
          First;
          If cdsPorOpe.IsEmpty Then
          Begin
            While Not qryAux.Eof Do
            Begin
              cdsPorOpe.Insert;
              cdsPorOpe.FieldByName('CODOPE').AsString := dbeCodOpe.Text;
              cdsPorOpe.FieldByName('CODPOR').AsString := qryAux.FieldByName('POR_CODPOR').AsString;
              cdsPorOpe.FieldByName('NOMPOR').AsString := qryAux.FieldByName('POR_NOMPOR').AsString;
              cdsPorOpe.FieldByName('ACESSO').AsString := IIF(fCfgSis('DACPOR', varBoolean), 'S', 'N');

              cdsPorOpe.Post;
              Next;
            End;
          End;
        End;

        FreeAndNil(qryAux);

        {*******************************}
        {* INCLUINDO ITEM NO CHECKLIST *}
        {****************************MO*}
        With cdsPorOpe Do
        Begin
          First;
          intPos := 0;

          While Not Eof Do
          Begin
            clbPortadores.AddItem(FieldByName('CODPOR').AsString + ' - ' +FieldByName('NOMPOR').AsString, Nil);
            clbPortadores.Checked[intPos] := FieldByName('ACESSO').AsString = 'S';

            Inc(IntPos);
            Next;
          End;
        End;
      End
      Else
      If RecordCount < intQtdPor Then
      Begin
        qryAux := fCriaQuery(Self);

        strSQL := '';
        strSQL := strSQL + '   SELECT                             ';
        strSQL := strSQL + '     POR_CODPOR,                      ';
        strSQL := strSQL + '     POR_NOMPOR                       ';
        strSQL := strSQL + '   FROM                               ';
        strSQL := strSQL + '     CADPOR                           ';
        strSQL := strSQL + '   WHERE                              ';
        strSQL := strSQL + '     POR_CODPOR NOT IN (              ';
        strSQL := strSQL + '     SELECT OPE_CODPOR                ';
        strSQL := strSQL + '     FROM POROPE                      ';
        strSQL := strSQL + '     WHERE OPE_CODOPE = ' + QuotedStr(dbeCodOpe.Text);
        strSQL := strSQL + '     )                                ';

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(strSQL);
        qryAux.Open;

        With qryAux Do
        Begin
          First;

          While Not qryAux.Eof Do
          Begin
            cdsPorOpe.Insert;
            cdsPorOpe.FieldByName('CODOPE').AsString := dbeCodOpe.Text;
            cdsPorOpe.FieldByName('CODPOR').AsString := qryAux.FieldByName('POR_CODPOR').AsString;
            cdsPorOpe.FieldByName('NOMPOR').AsString := qryAux.FieldByName('POR_NOMPOR').AsString;
            cdsPorOpe.FieldByName('ACESSO').AsString := IIF(fCfgSis('DACPOR', varBoolean), 'S', 'N');

            cdsPorOpe.Post;
            Next;
          End;
        End;

        With qryCadPor Do
        Begin
          First;
          intPos := 0;

          While Not Eof Do
          Begin
            clbPortadores.AddItem(FieldByName('POR_CODPOR').AsString + ' - ' +FieldByName('POR_NOMPOR').AsString, Nil);

            If FieldByName('OPE_ACESSO').AsString = 'S' Then
              clbPortadores.Checked[intPos] := True
            Else
              clbPortadores.Checked[intPos] := False;

            Inc(IntPos);
            Next;
          End;
        End;

        With cdsPorOpe Do
        Begin
          First;

          While Not Eof Do
          Begin
            clbPortadores.AddItem(FieldByName('CODPOR').AsString + ' - ' +FieldByName('NOMPOR').AsString, Nil);
            clbPortadores.Checked[intPos] := FieldByName('ACESSO').AsString = 'S';

            Inc(IntPos);
            Next;
          End;
        End;
      End
      Else
      Begin

        {************************************************************}
        {* CASO ENCONTRE REGISTRO, CARREGA OS DADOS QUE ESTÃO NO BD *}
        {*********************************************************MO*}
        With qryCadPor Do
        Begin
          First;
          intPos := 0;

          While Not Eof Do
          Begin
            clbPortadores.AddItem(FieldByName('POR_CODPOR').AsString + ' - ' +FieldByName('POR_NOMPOR').AsString, Nil);

            If FieldByName('OPE_ACESSO').AsString = 'S' Then
              clbPortadores.Checked[intPos] := True
            Else
              clbPortadores.Checked[intPos] := False;

            Inc(IntPos);
            Next;
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('Erro ao carregar portadores', 'TfrmCadOperadores.fCarregaPortadoresOperador');
      Exit;
    End;
  End;

  FreeAndNil(qryCadPor);
  FreeAndNil(qryQtdPor);

end;

procedure TfrmCadOperadores.pCarregaSubGerente;
begin
  edtDesSub.Text := fRetNomeOperador(dbeCodSub.Text);
end;

procedure TfrmCadOperadores.pCriaClientOpeATe;
begin
  cdsOpeATe := TUniClientDataSet.Create(Self);
  cdsOpeATe.FieldDefs.Add('AUTINC', ftString, 20);
  cdsOpeATe.FieldDefs.Add('CODTEC', ftString,  3);
  cdsOpeATe.FieldDefs.Add('NOMTEC', ftString, 30);
  cdsOpeATe.FieldDefs.Add('OPERAC', ftString,  1);
  cdsOpeATe.CreateDataSet;

  cdsOpeATe.Filtered := False;
  cdsOpeATe.Filter := 'OPERAC <> ''D''';
  cdsOpeATe.Filtered := True;

  dtsOpeATe.DataSet := cdsOpeATe;
end;

procedure TfrmCadOperadores.pEnabledLabel(Opcao: Boolean);
begin
  lblclbGeral.Enabled        := Opcao;
  lblclbLogin.Enabled        := Opcao;
  lblclbEmpresa.Enabled      := Opcao;
  lblclbIncRom.Enabled       := Opcao;
  lblclbBaixaReceber.Enabled := Opcao;
  lblclbBaixaPagar.Enabled   := Opcao;
  lblclbEmpEst.Enabled       := Opcao;
  lblclbEmpConsVendFatur.Enabled := Opcao;
  lblclbEmpLibRemota.Enabled     := Opcao;
  lblClbEmpresasNotificacaoColetor.Enabled := Opcao;
  lblclbPortadores.Enabled := Opcao;
  lblclbEmpMltLjs.Enabled  := Opcao;
  lblclbEmpEstMin.Enabled  := Opcao;
  lblclbEmpReimpressaoDocs.Enabled := Opcao;
end;

procedure TfrmCadOperadores.pExcluiPortador;
  Var
    qryAux : TUniQuery;
    strSQL : String;
begin
  Try
    qryAux:= fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM POROPE ';
    strSQL := strSQL + 'WHERE OPE_CODOPE = :CODOPE ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      ExecSQL;
    End;

    clbPortadores.Clear;
    If (cdsPorOpe.Active) and (cdsPorOpe.RecordCount > 0) Then
      cdsPorOpe.EmptyDataSet;

    pLimparCampos;
  Except
    fRollBack;
    Raise Exception.Create('Erro ao deletar portador.');
  End;
end;

procedure TfrmCadOperadores.pExcluirOpeATe;
begin
  if not (fMensagem('AVISO', 'Confirma a exclusão do técnico vinculado?', ['&Sim', '&Não']) = 1) then
    Exit;

  if cdsOpeATe.FieldByName('OPERAC').AsString = 'I' then
    cdsOpeATe.Delete
  else
  begin
    cdsOpeATe.Edit;
    cdsOpeATe.FieldByName('OPERAC').AsString := 'D';
    cdsOpeATe.Post;
  end;
end;

function TfrmCadOperadores.fGravaPortadoresOperador: Boolean;
  Var
    qryAux : TUniQuery;
    strSQL1: String;
    strSQL2: String;
    intP   : Integer;

  function fGetApenasNumeros(strTexto: String): String;
  Var
    i : Integer;
  Begin
    for i := Length(strTexto) downto 1 do
      if not CharInSet(strTexto[i], ['0'..'9']) then
        Delete(strTexto,i,1);
    Result := strTexto;
  end;

  function fExistePorOpe(strCodOpe, strCodPor: String):Boolean;
    Var
      qryPorOpe: TUniQuery;
      strSQL   : String;
  Begin
    qryPorOpe := fCriaQuery(Self);

    strCodPor := fGetApenasNumeros(strCodPor);
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(*) AS QTD ';
    strSQL := strSQL + ' FROM       ';
    strSQL := strSQL + '   POROPE   ';
    strSQL := strSQL + ' WHERE      ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE AND ';
    strSQL := strSQL + '   OPE_CODPOR = :CODPOR ';

    With qryPorOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      ParamByName('CODPOR').AsString := strCodPor;
      Open;

      Result := FieldByName('QTD').AsInteger > 0;
    End;

    FreeAndNil(qryPorOpe);

  End;

begin

  Try
    qryAux := fCriaQuery(Self);

    {*************************************************************}
    {* CASO EXISTA VALOR NO CDS QUE DIZER QUE É UM REGISTRO NOVO *}
    {**********************************************************MO*}
    strSQL1 := '';
    strSQL1 := strSQL1 + ' REPLACE INTO ';
    strSQL1 := strSQL1 + '        POROPE (';
    strSQL1 := strSQL1 + '        OPE_CODOPE, ';
    strSQL1 := strSQL1 + '        OPE_CODPOR, ';
    strSQL1 := strSQL1 + '        OPE_ACESSO) ';
    strSQL1 := strSQL1 + ' VALUES(            ';
    strSQL1 := strSQL1 + '        :CODOPE,    ';
    strSQL1 := strSQL1 + '        :CODPOR,    ';
    strSQL1 := strSQL1 + '        :ACESSO)    ';
    {***********************************************}
    {* ATUALIZA VALOR DE UM REGISTRO QUE JÁ EXISTE *}
    {********************************************MO*}
    strSQL2 := '';
    strSQL2 := strSQL2 + ' UPDATE POROPE              ';
    strSQL2 := strSQL2 + ' SET OPE_ACESSO = :ACESSO   ';
    strSQL2 := strSQL2 + ' WHERE                      ';
    strSQL2 := strSQL2 + '   OPE_CODOPE = :CODOPE AND ';
    strSQL2 := strSQL2 + '   OPE_CODPOR = :CODPOR     ';

    With qryAux Do
    Begin
      For intP := 0 To clbPortadores.Count - 1 Do
      Begin
        Close;
        SQL.Clear;

        If fExistePorOpe(dbeCodOpe.Text, Copy(clbPortadores.Items.Strings[intP], 01, 05)) Then
          SQL.Add(strSQL2)
        Else
          SQL.Add(strSQL1);

        ParamByName('ACESSO').AsString := IIF(clbPortadores.Checked[intP], 'S', 'N');
        ParamByName('CODOPE').AsString := dbeCodOpe.Text;
        ParamByName('CODPOR').AsString := fGetApenasNumeros(Copy(clbPortadores.Items.Strings[intP], 01, 05));

        ExecSQL;
      End;
    End;
    Result := True;
  Except
    Raise Exception.Create('Erro ao gravar portadores do operador ');
  End;

end;

procedure TfrmCadOperadores.pHabilitaHorOpe(blnHabilita: Boolean);
begin
  tbsPermissaoHorariosOperacaoSistema.Enabled := blnHabilita;
end;

procedure TfrmCadOperadores.pHabilitarCamposComFor(blnHab: Boolean);
begin
  If (tbsComForEsp.TabVisible) Then
  Begin
    edtCodFor.Enabled := blnHab;
    edtComFor.Enabled := blnHab;
    btnAddComFor.Enabled := blnHab;
    btnRemComFor.Enabled := blnHab;
  End;
end;

procedure TfrmCadOperadores.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin

    If FindField('OPE_NUMCPF') <> nil Then
      TStringField(FieldByName('OPE_NUMCPF')).EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

    If FindField('OPE_C_E_P_') <> nil Then
      TStringField(FieldByName('OPE_C_E_P_')).EditMask := '99999-999;0;_';

    If FindField('OPE_PERCOM') <> nil Then
      TFloatField(FieldByName('OPE_PERCOM')).DisplayFormat := '#,##0.000';

    If FindField('OPE_COMEQS') <> nil Then
      TFloatField(FieldByName('OPE_COMEQS')).DisplayFormat := '#,##0.000';

    If FindField('OPE_PERCO2') <> nil Then
      TFloatField(FieldByName('OPE_PERCO2')).DisplayFormat := '#,##0.000';

    If FindField('OPE_MECCIT') <> nil Then
      TFloatField(FieldByName('OPE_MECCIT')).DisplayFormat := '#,##0.000';

    If FindField('OPE_MECCSE') <> nil Then
      TFloatField(FieldByName('OPE_MECCSE')).DisplayFormat := '#,##0.000';

    If FindField('OPE_VENCSE') <> nil Then
      TFloatField(FieldByName('OPE_VENCSE')).DisplayFormat := '#,##0.000';

    If FindField('OPE_NUMWPP') <> nil Then
      TStringField(FieldByName('OPE_NUMWPP')).EditMask := fRetMascaraFonePais;

    If FindField('OPE_FONE01') <> nil Then
      TStringField(FieldByName('OPE_FONE01')).EditMask := fRetMascaraFonePais;

    If FindField('OPE_FONE02') <> nil Then
      TStringField(FieldByName('OPE_FONE02')).EditMask := fRetMascaraFonePais;

    If FindField('OPE_DTANAS') <> nil Then
      TDateField(FieldByName('OPE_DTANAS')).EditMask := '99/99/9999';

    If FindField('OPE_DTAADM') <> nil Then
      TDateField(FieldByName('OPE_DTAADM')).EditMask := '99/99/9999';

    If FindField('OPE_DTADMI') <> nil Then
      TDateField(FieldByName('OPE_DTADMI')).EditMask := '99/99/9999';

    If FindField('OPE_LIMCRE') <> nil Then
      TFloatField(FieldByName('OPE_LIMCRE')).DisplayFormat := '#,##0.00';

    If FindField('OPE_LIMCRA') <> nil Then
      TFloatField(FieldByName('OPE_LIMCRA')).DisplayFormat := '#,##0.00';

    If FindField('OPE_SALBAS') <> nil Then
      TFloatField(FieldByName('OPE_SALBAS')).DisplayFormat := '#,##0.00';

    // Meta
    If FindField('OPE_COMCMF') <> nil Then
      TFloatField(FieldByName('OPE_COMCMF')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COMCFA') <> nil Then
      TFloatField(FieldByName('OPE_COMCFA')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COMCMA') <> nil Then
      TFloatField(FieldByName('OPE_COMCMA')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COMATA') <> nil Then
      TFloatField(FieldByName('OPE_COMATA')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COMVAR') <> nil Then
      TFloatField(FieldByName('OPE_COMVAR')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COM_SM') <> nil Then
      TFloatField(FieldByName('OPE_COM_SM')).DisplayFormat := '#,##0.00';

    If FindField('OPE_PEEMFL') <> nil Then
      TFloatField(FieldByName('OPE_PEEMFL')).DisplayFormat := '#,##0.00';

    If FindField('OPE_PEOPFL') <> nil Then
      TFloatField(FieldByName('OPE_PEOPFL')).DisplayFormat := '#,##0.00';

    If FindField('OPE_COMATE') <> nil Then
      TFloatField(FieldByName('OPE_COMATE')).DisplayFormat := '#,##0.000';
  End;
end;

procedure TfrmCadOperadores.pAtualizaLstEmpresa(strNomCam: String; clbEmpresa: TCheckListBox; cdsDados: TUniClientDataSet = Nil);
  Var
    intContador: Integer;
    intFocus   : Integer;
begin
  {******************************************}
  {* SELECIONA A EMPRESA CADASTRADA NO ITEM *}
  {***************************************LU*}
  intFocus := -1;

  If (Assigned(cdsDados)) Then
    strEmpSel := cdsDados.FieldByName(strNomCam).AsString
  Else
    strEmpSel := qryTabela.fieldbyname(strNomCam).AsString;

  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If (Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpSel) > 0) Then
    Begin
      If intFocus = -1 Then
        intFocus := intContador;
      clbEmpresa.Checked[intContador] := True;
    End
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
  clbEmpresa.ItemIndex := intFocus;
end;

procedure TfrmCadOperadores.pBuscaOperador(strCodOperador: String);
begin
  pPesquisaCadOpe(qryTabela, qryTabela, strCodOperador);
  if not qryTabela.IsEmpty then
    pCarregarOperador;
end;

procedure TfrmCadOperadores.pAtualizaEmpresasNotificacaoColetor();
  Var
    intContador: Integer;
    intFocus   : Integer;
    qryNotificacaoColetor : TUniQuery;
begin
  qryNotificacaoColetor := fCriaQuery(nil);
  try
    qryNotificacaoColetor.SQL.Add('SELECT                          ');
    qryNotificacaoColetor.SQL.Add('  NOT_CODEMP                    ');
    qryNotificacaoColetor.SQL.Add('FROM                            ');
    qryNotificacaoColetor.SQL.Add('  NOTOPE                        ');
    qryNotificacaoColetor.SQL.Add('WHERE                           ');
    qryNotificacaoColetor.SQL.Add('  NOT_CODOPE = :CODIGO_OPERADOR ');

    qryNotificacaoColetor.ParamByName('CODIGO_OPERADOR').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
    qryNotificacaoColetor.Open;

    intFocus := -1;

    For intContador := 0 To clbEmpresasNotificacaoColetor.Items.Count -1 Do
    Begin
      If (qryNotificacaoColetor.Locate('NOT_CODEMP', LeftStr(clbEmpresasNotificacaoColetor.Items[intContador],3), [])) Then
      Begin
        If intFocus = -1 Then
          intFocus := intContador;

        clbEmpresasNotificacaoColetor.Checked[intContador] := True;
      End
      Else
        clbEmpresasNotificacaoColetor.Checked[intContador] := False;
    End;

    qryNotificacaoColetor.Close;

    clbEmpresasNotificacaoColetor.ItemIndex := intFocus;

  finally
    FreeAndNil(qryNotificacaoColetor);
  end;
end;

procedure TfrmCadOperadores.pSalvaEmpresasNotificacaoColetor();
  Var
    intContador: Integer;
    qryNotificacaoColetor : TUniQuery;
    strCodigoEmpresa : String;
begin
  qryNotificacaoColetor := fCriaQuery(nil);
  try
    qryNotificacaoColetor.SQL.Add('SELECT                          ');
    qryNotificacaoColetor.SQL.Add('  *                             ');
    qryNotificacaoColetor.SQL.Add('FROM                            ');
    qryNotificacaoColetor.SQL.Add('  NOTOPE                        ');
    qryNotificacaoColetor.SQL.Add('WHERE                           ');
    qryNotificacaoColetor.SQL.Add('  NOT_CODOPE = :CODIGO_OPERADOR ');

    qryNotificacaoColetor.ParamByName('CODIGO_OPERADOR').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
    qryNotificacaoColetor.Open;


    //deleta empresas desmarcadas
    For intContador := 0 To clbEmpresasNotificacaoColetor.Items.Count -1 Do
    Begin
      strCodigoEmpresa := LeftStr(clbEmpresasNotificacaoColetor.Items[intContador],3);
      If (qryNotificacaoColetor.Locate('NOT_CODEMP', strCodigoEmpresa, [])) Then
      Begin
        If not clbEmpresasNotificacaoColetor.Checked[intContador] Then
          qryNotificacaoColetor.Delete;
      End
      Else if clbEmpresasNotificacaoColetor.Checked[intContador] then
      begin
        qryNotificacaoColetor.Append;
        qryNotificacaoColetor.FieldByName('AUTOINCREM').AsString := fRetAutoincrem('NOTOPE', VS_strCodEmp);
        qryNotificacaoColetor.FieldByName('NOT_CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
        qryNotificacaoColetor.FieldByName('NOT_CODEMP').AsString := strCodigoEmpresa;
        qryNotificacaoColetor.Post;
      end;
    End;

    qryNotificacaoColetor.Close;


  finally
    FreeAndNil(qryNotificacaoColetor);
  end;
end;

procedure TfrmCadOperadores.btnMobileClick(Sender: TObject);
  Var
    frmCadOpeConfig: TfrmCadOpeConfig;
begin
  inherited;
  If (dbeCodOpe.Text <> '') Then
  begin
    Try
      frmCadOpeConfig := TfrmCadOpeConfig.Create(Self, qryTabela.FieldByName('OPE_CODOPE').AsString);
      frmCadOpeConfig.ShowModal;
      pFreeAndNil(frmCadOpeConfig);
    Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmCadOperadores.btnMobileClick]');
        End;
    End;
  End
  Else
    fMensagem('Aviso', 'Nenhum operador foi selecionado',['&OK']);
end;

function TfrmCadOperadores.dbeCodDepChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadDep(Key);
end;

procedure TfrmCadOperadores.dbeCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE DEPARTAMENTO *}
  {******************************RV*}
  If fPesqDepartamento(Self, dbeCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(dbeCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadOperadores.fValidaCodBarra(strCodBar, strCodOpe: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *    ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODBAR =  :CODBAR AND ';
    strSQL := strSQL + '  OPE_CODOPE <> :CODOPE     ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBAR').AsString := strCodBar;
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;

      Result := IsEmpty;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmCadOperadores.fValidaSomaBaixaFlex: Boolean;
begin
  Result := (StrToFloatDef(dbePEEMFL.Text,0)  +  StrToFloatDef(dbePEOPFL.Text,0) <= 100);
end;

function TfrmCadOperadores.fVerificaGerenteTemVinculo(
  strCodOp: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  Result := False;

  qryTmp := fCriaQuery(Self);

  Try
    qryTmp.SQL.Add(' SELECT * ');
    qryTmp.SQL.Add(' FROM CADOPE ');
    qryTmp.SQL.Add(' WHERE OPE_CODGER = :CODOPE ');
    qryTmp.ParamByName('CODOPE').AsString := strCodOp;
    qryTmp.Open;

    Result := (qryTmp.RecordCount > 0);

    qryTmp.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadOperadores.fVerificaGerenteTemVinculo]');
  End;

  FreeAndNil(qryTmp);
end;

function TfrmCadOperadores.fVerificaOperadorEhGerente(strCodOp: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  Result := False;

  qryTmp := fCriaQuery(Self);

  Try
    qryTmp.SQL.Add(' SELECT OPE_INTEXT ');
    qryTmp.SQL.Add(' FROM CADOPE ');
    qryTmp.SQL.Add(' WHERE OPE_CODOPE = :CODOPE ');
    qryTmp.ParamByName('CODOPE').AsString := strCodOp;
    qryTmp.Open;

    Result := (qryTmp.FieldByName('OPE_INTEXT').AsString = 'G');

    qryTmp.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadOperadores.fVerificaOperadorEhGerente]');
  End;

  FreeAndNil(qryTmp);
end;

function TfrmCadOperadores.fVerificaOperadorEhSubGerente(strCodOp: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  Result := False;

  qryTmp := fCriaQuery(Self);

  Try
    qryTmp.SQL.Add('SELECT COUNT(1)');
    qryTmp.SQL.Add('  FROM CADOPE ');
    qryTmp.SQL.Add(' WHERE OPE_CODOPE = :CODOPE ');
    qryTmp.SQL.Add('   AND OPE_INTEXT = "S" ');
    qryTmp.ParamByName('CODOPE').AsString := strCodOp;
    qryTmp.Open;

    Result := qryTmp.Fields[0].AsInteger > 0;

    qryTmp.Close;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadOperadores.fVerificaOperadorEhSubGerente]');
  End;

  FreeAndNil(qryTmp);
end;

function TfrmCadOperadores.fVerificaSubGerenteTemVinculo(
  strCodOp: String): Boolean;
  Var
    qryTmp : TUniQuery;
begin
  Result := False;
  Try
    qryTmp := fCriaQuery(Self);

    Try
      qryTmp.SQL.Add(' SELECT * ');
      qryTmp.SQL.Add(' FROM CADOPE ');
      qryTmp.SQL.Add(' WHERE OPE_CODSUB = :CODOPE ');
      qryTmp.ParamByName('CODOPE').AsString := strCodOp;
      qryTmp.Open;

      Result := (qryTmp.RecordCount > 0);

      qryTmp.Close;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadOperadores.fVerificaGerenteTemVinculo]');
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TfrmCadOperadores.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcInverter);
end;

procedure TfrmCadOperadores.lblClbEmpresasNotificacaoColetorClick(Sender: TObject);
begin
  pSetaCheckList(clbEmpresasNotificacaoColetor);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpresaClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpresa);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbGeralClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList([clbLogin,clbEmpresa,clbIncRom,clbBaixaReceber,clbBaixaPagar,clbEmpEst,clbEmpConsVendFatur,clbEmpLibRemota,clbEmpMltLjs, clbEmpReimpressaoDocs]);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbIncRomClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbIncRom);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbBaixaReceberClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbBaixaReceber);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbBaixaPagarClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbBaixaPagar);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpConsVendFaturClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpConsVendFatur);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpEstClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpEst);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpEstMinClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpEstMin);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpLibRemotaClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpLibRemota);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpMltLjsClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpMltLjs);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbEmpReimpressaoDocsClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmpReimpressaoDocs);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbLoginClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbLogin);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblclbPortadoresClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbPortadores);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.lblEmailOpcClick(Sender: TObject);
begin
  inherited;
  pSetaCheckList(clbEmailEmps);
  pAbrirPoup;
end;

procedure TfrmCadOperadores.cmbProvedoresClick(Sender: TObject);
begin
  inherited;
  ExibeAjudaProvedores;
  ExibeSenhaEmailOperador;
  FValidacaoEmailObrigatoria := cmbProvedores.EditValue <> Null;
end;

procedure TfrmCadOperadores.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  pExecutarSelecao(opcMarcar);
end;

Function TfrmCadOperadores.fRetNumero(strCodOpe: String): String;
  Var
    intIndice: Integer;
Begin
  Result := '';
  For intIndice := 1 To Length(strCodOpe) Do
    If CharInSet(strCodOpe[intIndice], ['0'..'9']) Then
      Result := Result + strCodOpe[intIndice]
    Else
      Result := Result + IntToStr(Ord(strCodOpe[intIndice]));
End;

function TfrmCadOperadores.fValidaEmpresasSelecionadas: Boolean;
  Var
    strInativas: String;
    strMensagem: String;
begin
  Result := False;

  strInativas := fEmpresasInativasSelecionadas([clbEmpresa, clbIncRom, clbBaixaReceber,
    clbBaixaPagar, clbEmpEst, clbEmpConsVendFatur, clbEmpLibRemota, clbEmpReimpressaoDocs,
    clbEmpMltLjs, clbEmpEstMin, clbLogin]);

  If (Not fEmptyStr(strInativas)) Then
  Begin
    If (pos(',', strInativas) > 0) Or (pos(' e ', strInativas) > 0) Then
    Begin
      strMensagem := 'As empresas '+ strInativas + ' estão inativas no cadastro '+
        'de empresas e não podem ser utilizadas nos quadros da aba "Acesso Empresa". '+
        'Deseja desmarcar as empresas e continuar?'
    End
    Else
    Begin
      strMensagem := 'A empresa '+ strInativas + ' está inativa no cadastro '+
        'de empresas e não pode ser utilizada nos quadros da aba "Acesso Empresa". '+
        'Deseja desmarcar-la e continuar?'
    End;

    If (fMensagem('ATENÇÃO!', strMensagem, ['&Sim', '&Não'], 1) = 1) Then
    Begin
      pDesmarcaEmpresas(strInativas, [clbEmpresa, clbIncRom, clbBaixaReceber,
        clbBaixaPagar, clbEmpEst, clbEmpConsVendFatur, clbEmpLibRemota,
        clbEmpReimpressaoDocs, clbEmpMltLjs, clbEmpEstMin, clbLogin]);
    End
    Else
    Begin
      tbsAcessoEmp.Show;
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmCadOperadores.fEmpresasInativasSelecionadas(arrEmp: Array Of TCheckListBox): String;
  Var
    intIndexCount: Integer;
    intIndexItens: Integer;
    intPosVirgula: Integer;
    strCodEmp: String;
    strInativas: String;
begin
  strInativas := '';

  For intIndexCount := 0 To High(arrEmp) Do
  Begin
    For intIndexItens := 0 To arrEmp[intIndexCount].Items.Count -1 Do
    Begin
      strCodEmp := LeftStr(arrEmp[intIndexCount].Items[intIndexItens], 3);

      If (Not arrEmp[intIndexCount].Checked[intIndexItens]) Or (Pos(strCodEmp, strInativas) > 0) Then
        Continue;

      If (Not fEmpresaAtiva(strCodEmp)) Then
      Begin
        If (Not fEmptyStr(strInativas)) Then
          strInativas := strInativas + ', ';

        strInativas := strInativas + strCodEmp;
      End;
    End;
  End;

  intPosVirgula := LastDelimiter(',', strInativas);

  If (intPosVirgula > 0) Then
  Begin
    strInativas := Copy(strInativas, 1, intPosVirgula - 1) + ' e' +
      Copy(strInativas, intPosVirgula + 1, Length(strInativas));
  End;

  Result := strInativas;
end;

procedure TfrmCadOperadores.pDesmarcaEmpresas(strEmpresas: String; arrEmp: Array Of TCheckListBox);
  Var
    intIndexCount: Integer;
    intIndexItens: Integer;
    strCodEmp: String;
begin
  For intIndexCount := 0 To High(arrEmp) Do
  Begin
    For intIndexItens := 0 To arrEmp[intIndexCount].Items.Count -1 Do
    Begin
      strCodEmp := LeftStr(arrEmp[intIndexCount].Items[intIndexItens], 3);

      If (Pos(strCodEmp, strEmpresas) > 0) Then
        arrEmp[intIndexCount].Checked[intIndexItens] := False;
    End;
  End;
end;

procedure TfrmCadOperadores.pAdicionaDadosEmail;
  Var
    strEmpresas: String;
begin
  If (blnEdicaoEmail) Then
    cdsOpeEml.Edit
  Else
    cdsOpeEml.Append;

  strEmpresas := fRetEmpresasSel(clbEmailEmps);

  cdsOpeEml.FieldByName('EML_EMAEMP').AsString := Copy(strEmpresas, 1, Length(strEmpresas) - 1);
  cdsOpeEml.FieldByName('EML_E_NOME').AsString := edtRemetente.Text;
  cdsOpeEml.FieldByName('EML_CODPRV').AsString := IIF(cmbProvedores.EditValue = Null, '', cmbProvedores.EditValue);
  cdsOpeEml.FieldByName('EML_NOMPRV').AsString := cmbProvedores.Text;
  cdsOpeEml.FieldByName('EML_E_MAIL').AsString := edtEmail.Text;
  cdsOpeEml.FieldByName('EML_EMALOG').AsString := edtLogin.Text;
  cdsOpeEml.FieldByName('EML_PRVSEN').AsString := CriptografarSenhaEmail(edtSenhaEmail.Text);
  cdsOpeEml.FieldByName('EML_EMAAUT').AsString := IIF(chkEmaAut.Checked, 'Sim', 'Não');
  cdsOpeEml.FieldByName('EML_TEXTO_').AsString := AnsiReplaceStr(mmoAssinatura.Lines.Text, STRING_ENTER, STRING_QUEBRA);

  If (Not fEmptyStr(strImagemAssinatura)) Then
  Begin
    cdsOpeEml.FieldByName('EML_IMGB64').AsString := fBase64FromFile(strImagemAssinatura);
  End
  Else If (Not Assigned(imgAssinatura.Picture)) Then
  Begin
    cdsOpeEml.FieldByName('EML_IMGB64').AsString := '';
  End;

  cdsOpeEml.Post;
end;

procedure TfrmCadOperadores.pPreencheCamposEdicaoEmail;
  Var
    objOldChange: TNotifyEvent;
    strCodPrv: String;
begin
  objOldChange := edtEmail.OnChange;
  edtEmail.OnChange := Nil;
  edtSenhaEmail.OnChange := Nil;
  dbgEmails.Enabled := False;

  blnEdicaoEmail := True;
  pAtualizaLstEmpresa('EML_EMAEMP', clbEmailEmps, cdsOpeEml);
  edtRemetente.Text := cdsOpeEml.FieldByName('EML_E_NOME').AsString;
  strCodPrv := cdsOpeEml.FieldByName('EML_CODPRV').AsString;
  cmbProvedores.EditValue := IIF(Not fEmptyStr(strCodPrv), strCodPrv, Null);
  edtEmail.Text := cdsOpeEml.FieldByName('EML_E_MAIL').AsString;
  edtLogin.Text := cdsOpeEml.FieldByName('EML_EMALOG').AsString;
  edtSenhaEmail.Text := CriptografarSenhaEmail(cdsOpeEml.FieldByName('EML_PRVSEN').AsString);
  chkEmaAut.Checked := cdsOpeEml.FieldByName('EML_EMAAUT').AsString = 'Sim';
  pCarregaAssinatura;

  edtEmail.OnChange := objOldChange;
  edtSenhaEmail.OnChange := objOldChange;
end;

procedure TfrmCadOperadores.pCarregaAssinatura;
  Var
    objPict: TPicture;
begin
  imgAssinatura.Picture.Assign(nil);

  If (Not fEmptyStr(cdsOpeEml.FieldByName('EML_IMGB64').AsString)) Then
  Begin
    objPict := TPicture.Create();
    Try
      pImagemFromBase64(cdsOpeEml.FieldByName('EML_IMGB64').AsString, objPict);

      imgAssinatura.Picture.Assign(objPict);
    Finally
      FreeAndNil(objPict);
    End;
  End;

  If (Not fEmptyStr(cdsOpeEml.FieldByName('EML_TEXTO_').AsString)) Then
    mmoAssinatura.Lines.Text := AnsiReplaceStr(cdsOpeEml.FieldByName('EML_TEXTO_').AsString, STRING_QUEBRA, STRING_ENTER)
  Else
    mmoAssinatura.Lines.Clear();
end;

function TfrmCadOperadores.fValidaDadosEmail: Boolean;
begin
  Result := False;

  If (FValidacaoEmailObrigatoria) Then
  Begin
    If (cmbProvedores.EditValue <> Null) Then
    Begin
      fMensagem('ATENÇÃO', 'Os dados de autorização do e-mail foram alterados e ' +
                           'é obrigatória a validação dos dados informados.' + #13 +
                           'Clique em validar dados antes de confirmar as alterações.', ['&Ok']);

      pgcDados.ActivePage := tbsEmail;

      Exit;
    End;
  End;

  If (Not (fValidaPanel(pnlEmailTop))) Then
    Exit;

  If (Not fValidaEmpresasEmail) Then
  Begin
    pgcDados.ActivePage := tbsEmail;
    Exit;
  End;

  Result := True;
end;

procedure TfrmCadOperadores.pLimpaDadosEmail;
begin
  edtRemetente.Text := '';
  cmbProvedores.EditValue := Null;
  edtEmail.Text := '';
  edtLogin.Text := '';
  edtSenhaEmail.Text := '';
  pResetarBotoesAutDadosEmail();
  imgAssinatura.Picture.Assign(nil);
  mmoAssinatura.Lines.Clear();
  chkEmaAut.Checked := False;
  pSetaCheckList(clbEmailEmps);
  pMarcaDesmarca(False);
  blnEdicaoEmail := False;
  strImagemAssinatura := '';
  pSetFocus(edtRemetente);
end;

function TfrmCadOperadores.fConfirmaExclusaoEmail: Boolean;
begin
  Result := fMensagem('ATENÇÃO!', 'Confirmar exclusão do registro?', ['&Sim', '&Não'], 2) = 1;
end;

function TfrmCadOperadores.fValidaEmpresasEmail: Boolean;
  Var
    strCodEmp: String;
    strEmpresasRep: String;
    intIndex: Integer;
    cdsClone: TUniClientDataSet;
begin
  Result := False;
  strEmpresasRep := '';
  cdsClone := TUniClientDataSet.Create(Self);

  Try
    pCloneDataSet(cdsClone, cdsOpeEml);
    cdsClone.First;

    While (Not cdsClone.Eof) Do
    Begin
      If (blnEdicaoEmail) And (cdsClone.FieldByName('EML_SEQUEN').AsString = cdsOpeEml.FieldByName('EML_SEQUEN').AsString) Then
      Begin
        cdsClone.Next;
        Continue;
      End;

      For intIndex := 0 To clbEmailEmps.Items.Count -1 Do
      Begin
        If (Not clbEmailEmps.Checked[intIndex]) Then
          Continue;

        strCodEmp := LeftStr(clbEmailEmps.Items[intIndex], 3);

        If (Pos(strCodEmp, cdsClone.FieldByName('EML_EMAEMP').AsString) > 0) Then
        Begin
          If (Not fEmptyStr(strEmpresasRep)) Then
            strEmpresasRep := strEmpresasRep + ', ';

          strEmpresasRep := strEmpresasRep + strCodEmp;
        End;
      End;

      cdsClone.Next;
    End;

  Finally
    FreeAndNil(cdsClone);
  End;

  If (Not fEmptyStr(strEmpresasRep)) Then
  Begin
    fMensagem('ATENÇÃO', 'Já existe um e-mail cadastrado para a(s) seguinte(s) empresa(s): '+
                         #13 + strEmpresasRep + #13+
                         'Favor verificar!', ['&Ok']);
    pgcDados.ActivePage := tbsEmail;
    Exit;
  End;

  Result := True;
end;

procedure TfrmCadOperadores.pHabilitaCamposEmail(blnHabilita: Boolean);
begin
  pnlEmails.Enabled := blnHabilita;
  pnlEmailBottom.Enabled := blnHabilita;
  grbEmailEmps.Enabled := blnHabilita;
  lblEmailOpc.Enabled := blnHabilita;
  clbEmailEmps.Enabled := blnHabilita;
  dbgEmails.Enabled := blnHabilita;
end;

procedure TfrmCadOperadores.pAjustaAbaEmail;
begin
  If (Not blnUsaEmailPorEmpresa) Then
  Begin
    grbEmailEmps.Visible := False;
    pnlEmails.Visible := False;
    btnEmailAdd.Visible := False;
    btnEmailCan.Visible := False;
  End;

  blnEdicaoEmail := False;
  pHabilitaCamposEmail(False);
end;

procedure TfrmCadOperadores.pCarregaDadosEmail;
begin
  If (blnUsaEmailPorEmpresa) Then
    pCarregaDadosEmailEmpresas
  Else
    pCarregaDadosEmailOperador;
end;

procedure TfrmCadOperadores.pCarregaDadosEmailOperador;
  Var
    strCodPrv: String;
begin
  strCodPrv               := qryTabela.FieldByName('OPE_CODPRV').AsString;
  cmbProvedores.EditValue := IIF(Not fEmptyStr(strCodPrv), strCodPrv, Null);
  edtRemetente.Text       := qryTabela.FieldByName('OPE_E_NOME').AsString;
  edtEmail.Text           := qryTabela.FieldByName('OPE_E_MAIL').AsString;
  edtLogin.Text           := qryTabela.FieldByName('OPE_EMALOG').AsString;
  edtSenhaEmail.Text      := CriptografarSenhaEmail(qryTabela.FieldByName('OPE_PRVSEN').AsString);
  chkEmaAut.Checked       := qryTabela.FieldByName('OPE_EMAAUT').AsString = 'S';

  pCarregarImagemAssinatura();
end;

procedure TfrmCadOperadores.pCarregaDadosEmailEmpresas;
  Var
    objOpeEmlController: TOpeEmlController;
begin
  objOpeEmlController := TOpeEmlController.Create;

  Try
    objOpeEmlController.pCarregaLista(qryTabela.FieldByName('OPE_CODOPE').AsString, cdsOpeEml);
  Finally
    FreeAndNil(objOpeEmlController);
  End;
end;

procedure TfrmCadOperadores.pGravaDadosEmail;
begin
  If (blnUsaEmailPorEmpresa) Then
    pGravaDadosEmailEmpresas
  Else
    pGravaDadosEmailOperador;
end;

procedure TfrmCadOperadores.pGravaDadosEmailOperador;
begin
  pSalvarImagemAssinatura();

  qryTabela.Edit;
  qryTabela.FieldByName('OPE_E_NOME').AsString := edtRemetente.Text;
  qryTabela.FieldByName('OPE_EMALOG').AsString := edtLogin.Text;
  qryTabela.FieldByName('OPE_CODPRV').AsString := IIF(cmbProvedores.EditValue = Null, '', cmbProvedores.EditValue);
  qryTabela.FieldByName('OPE_PRVSEN').AsString := CriptografarSenhaEmail(edtSenhaEmail.Text);
  qryTabela.FieldByName('OPE_EMAAUT').AsString := IIF(chkEmaAut.Checked, 'S', 'N');
  qryTabela.Post;
end;

procedure TfrmCadOperadores.pGravaDadosEmailEmpresas;
  Var
    objOpeEmlController: TOpeEmlController;
begin
  objOpeEmlController := TOpeEmlController.Create;

  Try
    Try
      pPreencheCodOpeEmail;
      objOpeEmlController.fGravarColecao(cdsOpeEml);
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[untCadOperadores.pGravaDadosEmailEmpresas]');
    End;
  Finally
    FreeAndNil(objOpeEmlController);
  End;
end;

function TfrmCadOperadores.fValidaCamposEmail(Sender: TWinControl): Boolean;
  Var
    LSenhaPreenchida: Boolean;
begin
  Result := True;

  LSenhaPreenchida := Not edtSenhaEmail.Visible;
  If Not LSenhaPreenchida Then
    LSenhaPreenchida := Not fEmptyStr(edtSenhaEmail.Text);

  If ((blnGravacao) And (Not blnUsaEmailPorEmpresa)) Or (Not blnGravacao) Then
  Begin
    If (Sender = dbeE_mail) Then
    Begin
      If ((cmbProvedores.EditValue <> Null) Or (LSenhaPreenchida)) And (fEmptyStr(dbeE_mail.Text)) Then
      Begin
        fMensagem('', 'O campo e-Mail das Configurações de e-Mail deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmptyStr(dbeE_mail.Text)) And (Pos('@', dbeE_mail.Text) = 0) Then
      Begin
        fMensagem('', 'O e-Mail informado nas Configurações de e-Mail é inválido!', ['&O k']);
        Result := False;
      End;
    End;

    If (Sender = edtSenhaEmail) Then
    Begin
      If (cmbProvedores.EditValue <> Null) And (Not LSenhaPreenchida And (Not fEmptyStr(edtEmail.Text))) Then
      Begin
        fMensagem('', 'O campo Senha das Configurações de e-Mail deve ser informado!', ['&O k']);
        Result := False;
      End;
    End;

    If (Sender = edtLogin) Then
    Begin
      If (cmbProvedores.EditValue <> Null) And (fEmptyStr(edtLogin.Text) And (Not fEmptyStr(edtEmail.Text))) Then
      Begin
        fMensagem('', 'O campo Login das Configurações de e-Mail deve ser informado!', ['&O k']);
        Result := False;
      End;
    End;

    If (Sender = cmbProvedores) Then
    Begin
      If (cmbProvedores.EditValue = Null) And ((LSenhaPreenchida) Or (Not fEmptyStr(edtLogin.Text))) Then
      Begin
        fMensagem('', 'O campo Provedor das Configurações de e-Mail deve ser informado!', ['&O k']);
        Result := False;
      End;

      If (Assigned(imgAssinatura.Picture.Graphic)) And ((cmbProvedores.EditValue = Null) Or (Not LSenhaPreenchida) Or (fEmptyStr(edtEmail.Text))) Then
      Begin
        fMensagem('', 'Os campos Provedor, e-Mail e Senha da aba Complementos devem ser informados!', ['&O k']);
        Result := False;
      End;
    End;

    If (Sender = grbEmailEmps) And (blnUsaEmailPorEmpresa) Then
    Begin
      If (fEmptyStr(fRetEmpresasSel(clbEmailEmps))) Then
      Begin
        fMensagem('', 'Selecione ao menos uma empresa para continuar!', ['&Ok']);
        Result := False;
      End;
    End;
  End
  Else If (blnUsaEmailPorEmpresa) Then
  Begin
    If (cdsOpeEml.RecordCount <= 0) Then
    Begin
      fMensagem('', 'Os dados de e-mail devem ser preenchidos!', ['&Ok']);
      Result := False;
    End
    Else If (btnHeranca.Enabled) And (Not fValidaSenhasEmail) Then
      Result := False;
  End;

  If (Not Result) Then
    tbsEmail.Show;
end;

procedure TfrmCadOperadores.pPreencheCodOpeEmail;
begin
  cdsOpeEml.First;

  While (Not cdsOpeEml.Eof) Do
  Begin
    cdsOpeEml.Edit;
    cdsOpeEml.FieldByName('EML_CODOPE').AsString := qryTabela.FieldByName('OPE_CODOPE').AsString;
    cdsOpeEml.Post;
    cdsOpeEml.Next;
  End;
end;

procedure TfrmCadOperadores.pLimpaSenhaEmail;
begin
  If (blnUsaEmailPorEmpresa) Then
  Begin
    cdsOpeEml.First;

    While (Not cdsOpeEml.Eof) Do
    Begin
      cdsOpeEml.Edit;
      cdsOpeEml.FieldByName('EML_PRVSEN').AsString := '';
      cdsOpeEml.Post;
      cdsOpeEml.Next;
    End;
  End
  Else
    qryTabela.FieldByName('OPE_PRVSEN').Clear;
end;

function TfrmCadOperadores.fValidaSenhasEmail: Boolean;
begin
  Result := False;
  cdsOpeEml.First;

  While (Not cdsOpeEml.Eof) Do
  Begin
    If (fEmptyStr(cdsOpeEml.FieldByName('EML_PRVSEN').AsString)) Then
    Begin
      fMensagem('', 'A senha referente ao e-mail ' +
                    cdsOpeEml.FieldByName('EML_E_MAIL').AsString +
                    ' deve ser preenchida!', ['&Ok']);
      tbsEmail.Show;
      pSetFocus(dbgEmails);
      Exit;
    End;

    cdsOpeEml.Next;
  End;

  Result := True;
end;

end.

