unit untCadFuncionarios;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, Contnrs, ExtCtrls, EditFocus, Mask, MaskEditFocus, untControlePagtoFunc,
  DB, DBCtrls, DBMemoFocus, DBEditFocus, Uni, Grids, DBGridCitel, DBGrids, UniClientDataSet,
  DBComboBoxFocus, ComboBoxFocus, untFuncoesRel2, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient, Vcl.Forms, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxCalendar,
  cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxMaskEdit,
  cxDropDownEdit, untMskC_G_C_, QColorLabel, System.ImageList, Vcl.ImgList,
  System.StrUtils, Vcl.Dialogs, Vcl.ExtDlgs, dxScreenTip, dxCustomHint, cxHint, System.IOUtils,
  untFramePlanoDeContasDBEditFocus,System.DateUtils;

type
  TfrmCadFuncionarios = class(TfrmPaiCad)
    dtsCadFun: TDataSource;
    tbsFerias: TTabSheet;
    pnlFundo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    gpbCtaCor: TGroupBox;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    dbeBanco_: TDBEditFocus;
    dbeAgenci: TDBEditFocus;
    dbeConta_: TDBEditFocus;
    edtNomBan: TEditFocus;
    dbeCodFun: TDBEditFocus;
    dbeNomFun: TDBEditFocus;
    dbeCodFnc: TDBEditFocus;
    dbePisPas: TDBEditFocus;
    dbeObserv: TDBMemoFocus;
    dbchkFUN_CARPON: TDBCheckBox;
    dbchkFUN_REGIST: TDBCheckBox;
    dbeDtaAdm: TDBEditFocus;
    dbeCodEmp: TDBEditFocus;
    edtNomEmp: TEditFocus;
    pnlFerias: TPanel;
    pnl3: TPanel;
    lbl18: TLabel;
    lbl19: TLabel;
    cdsFerias: TUniClientDataSet;
    cdsFeriasCODFUN: TStringField;
    cdsFeriasAQUINI: TDateField;
    cdsFeriasAQUFIN: TDateField;
    cdsFeriasGOZINI: TDateField;
    cdsFeriasGOZFIN: TDateField;
    cdsFeriasDTAREC: TDateField;
    fltfldFeriasVALREC: TFloatField;
    dtsFerias: TDataSource;
    tbsComp: TTabSheet;
    tbsBeneficiarios: TTabSheet;
    Label6: TLabel;
    dbeCTPS: TDBEditFocus;
    Label13: TLabel;
    dbeNumSerie: TDBEditFocus;
    Label14: TLabel;
    dbeCPF: TDBEditFocus;
    dbcGrauInstrucao: TDBComboBoxFocus;
    Label15: TLabel;
    dbeRG: TDBEditFocus;
    Label16: TLabel;
    Label17: TLabel;
    dbeNacionalidade: TDBEditFocus;
    Label18: TLabel;
    dbeNomePai: TDBEditFocus;
    dbeCodLocNascto: TDBEditFocus;
    edtLocalNascto: TEditFocus;
    Label19: TLabel;
    Label24: TLabel;
    dbeNomeMae: TDBEditFocus;
    Label23: TLabel;
    dbeDtaNascto: TDBEditFocus;
    Label20: TLabel;
    dbcEstadoCivil: TDBComboBoxFocus;
    dbeCertificadoMilitar: TDBEditFocus;
    Label22: TLabel;
    gpbHorTrab: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    dbeDom1: TDBEditFocus;
    dbeDom2: TDBEditFocus;
    dbeDom3: TDBEditFocus;
    dbeDom4: TDBEditFocus;
    dbeSeg1: TDBEditFocus;
    dbeSeg2: TDBEditFocus;
    dbeSeg3: TDBEditFocus;
    dbeSeg4: TDBEditFocus;
    dbeTer4: TDBEditFocus;
    dbeTer3: TDBEditFocus;
    dbeTer2: TDBEditFocus;
    dbeTer1: TDBEditFocus;
    dbeQua1: TDBEditFocus;
    dbeQua2: TDBEditFocus;
    dbeQua3: TDBEditFocus;
    dbeQua4: TDBEditFocus;
    dbeQui1: TDBEditFocus;
    dbeQui2: TDBEditFocus;
    dbeQui3: TDBEditFocus;
    dbeQui4: TDBEditFocus;
    dbeSex1: TDBEditFocus;
    dbeSex2: TDBEditFocus;
    dbeSex3: TDBEditFocus;
    dbeSex4: TDBEditFocus;
    dbeSab1: TDBEditFocus;
    dbeSab2: TDBEditFocus;
    dbeSab3: TDBEditFocus;
    dbeSab4: TDBEditFocus;
    pnlBenef: TPanel;
    Label53: TLabel;
    Label54: TLabel;
    edtBenefNome: TEditFocus;
    cbxBenefgrauParen: TComboBoxFocus;
    cdsBenef: TUniClientDataSet;
    cdsBenefCODFUN: TStringField;
    cdsBenefNOMBEN: TStringField;
    cdsBenefGRAPAR: TStringField;
    dtsBenef: TDataSource;
    gpbDesligamento: TGroupBox;
    lbl5: TLabel;
    dbeDtaDem: TDBEditFocus;
    Label55: TLabel;
    dbcMotDes: TDBComboBoxFocus;
    gpbTitEle: TGroupBox;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    dbeNumTit: TDBEditFocus;
    dbeZonTit: TDBEditFocus;
    dbeSecTit: TDBEditFocus;
    gpbCarHab: TGroupBox;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    dbeCatHab: TDBEditFocus;
    dbeValHab: TDBEditFocus;
    dbeHabilitacao: TDBEditFocus;
    lbl20: TLabel;
    dbeCodVen: TDBEditFocus;
    edtNomVen: TEditFocus;
    dbeEndFun: TDBEditFocus;
    dbeComple: TDBEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    dbeEndNum: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeBairro: TDBEditFocus;
    dbeCodCid: TDBEditFocus;
    Label5: TLabel;
    Label7: TLabel;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    dbeNumCep: TDBEditFocus;
    Label9: TLabel;
    DbeNumTel: TDBEditFocus;
    DbeNumCel: TDBEditFocus;
    Label8: TLabel;
    Label10: TLabel;
    btnFichaCad: TBitBtnLocked;
    tbsIntegracaoCitel: TTabSheet;
    grpVincTese: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label21: TLabel;
    dbEmpTes: TDBEditFocus;
    dbCodTes: TDBEditFocus;
    dbDigTes: TDBEditFocus;
    Label66: TLabel;
    DbeEmailFun: TDBEditFocus;
    Label67: TLabel;
    edtRG: TEditFocus;
    Label68: TLabel;
    Label69: TLabel;
    cdsBenefNUMRG: TStringField;
    cdsBenefNUMCPF: TStringField;
    cdsBenefDTANAS: TDateField;
    dbgFerias: TcxGrid;
    dbgFeriasDBTableView1: TcxGridDBTableView;
    dbgFeriasDBTableViewAQUINI: TcxGridDBColumn;
    dbgFeriasDBTableViewAQUFIN: TcxGridDBColumn;
    dbgFeriasDBTableViewGOZINI: TcxGridDBColumn;
    dbgFeriasDBTableViewGOZFIN: TcxGridDBColumn;
    dbgFeriasDBTableViewDTAREC: TcxGridDBColumn;
    dbgFeriasDBTableViewVALREC: TcxGridDBColumn;
    dbgFeriasLevel1: TcxGridLevel;
    dbgBenef: TcxGrid;
    dbgBenefDBTableView: TcxGridDBTableView;
    dbgBenefDBTableViewNOMBEN: TcxGridDBColumn;
    dbgBenefDBTableViewGRAPAR: TcxGridDBColumn;
    dbgBenefDBTableViewNUMRG: TcxGridDBColumn;
    dbgBenefDBTableViewNUMCPF: TcxGridDBColumn;
    dbgBenefDBTableViewDTANAS: TcxGridDBColumn;
    dbgBenefLevel1: TcxGridLevel;
    mskDtaNasc: TcxDateEdit;
    mskCpf: TMaskEditC_G_C_;
    pnlAcoesBeneficiario: TPanel;
    btnIncluirBeneficiario: TBitBtnLocked;
    btnAlterarBeneficiario: TBitBtnLocked;
    btnExcluirBeneficiario: TBitBtnLocked;
    btnCancelarBeneficiario: TBitBtnLocked;
    btnGravarBeneficiario: TBitBtnLocked;
    cdsBenefAUTOINCREM: TStringField;
    pnlAcoesFerias: TPanel;
    btnIncluirFerias: TBitBtnLocked;
    btnAlterarFerias: TBitBtnLocked;
    btnExcluirFerias: TBitBtnLocked;
    btnCancelarFerias: TBitBtnLocked;
    btnGravarFerias: TBitBtnLocked;
    cdsFeriasAUTOINCREM: TStringField;
    cdsFeriasCODEMP: TStringField;
    cdsBenefCODEMP: TStringField;
    edtNomFnc: TEditFocus;
    gpbDadosPess: TGroupBox;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    ColorLabel1: TColorLabel;
    Label75: TLabel;
    ColorLabel2: TColorLabel;
    lbl21: TLabel;
    ColorLabel3: TColorLabel;
    Label76: TLabel;
    lbl42: TLabel;
    dbeAltura: TDBEditFocus;
    dbePesFun: TDBEditFocus;
    dbeFilhos: TDBEditFocus;
    dbeCorFun: TDBEditFocus;
    dbeTamanh: TDBEditFocus;
    dbeQtdFil: TDBEditFocus;
    pnlSemaforo: TPanel;
    imgCinza: TImage;
    imgAzul: TImage;
    imgVerde: TImage;
    imglSemaforoOn: TImageList;
    imglSemaforoOff: TImageList;
    pnlImgFun1: TPanel;
    imgFoto01: TImage;
    btnAmpliar1: TSpeedButton;
    pnlImgFun2: TPanel;
    imgFoto02: TImage;
    btnAmpliar2: TSpeedButton;
    lbl22: TLabel;
    lbl23: TLabel;
    dlgOpenPic: TOpenPictureDialog;
    tbsCtaPag: TTabSheet;
    grpDadosCP: TGroupBox;
    Label62: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    edtDesPorTes: TEditFocus;
    edtDesForTes: TEditFocus;
    edtDesEveTes: TEditFocus;
    dbForTes: TDBEditFocus;
    dbEveTes: TDBEditFocus;
    dbPorTes: TDBEditFocus;
    HintControler: TcxHintStyleController;
    pnlBotoesInfo: TPanel;
    btnAbrirPastaAnexos: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    lbl6: TLabel;
    dbeSalBas: TDBEditFocus;
    Label63: TLabel;
    dbeAlqIns: TDBEditFocus;
    Label77: TLabel;
    dbeBCalIr: TDBEditFocus;
    dbeAliqIr: TDBEditFocus;
    Label78: TLabel;
    btnCadFor: TBitBtnLocked;
    DBEditFocus1: TDBEditFocus;
    Label79: TLabel;
    DBComboBoxFocus1: TDBComboBoxFocus;
    lbl12: TLabel;
    lbl13: TLabel;
    mskAquIni: TcxDateEdit;
    mskAquFin: TcxDateEdit;
    lbl14: TLabel;
    lbl15: TLabel;
    mskGozIni: TcxDateEdit;
    mskGozFin: TcxDateEdit;
    lbl16: TLabel;
    mskDtaRec: TcxDateEdit;
    lbl17: TLabel;
    dbeValRec: TEditFocus;
    dbgFeriasDBTableView1DIAGOZ: TcxGridDBColumn;
    dbgFeriasDBTableView1SALGOZ: TcxGridDBColumn;
    cdsFeriasSALDO: TIntegerField;
    cdsFeriasClone: TUniClientDataSet;
    cdsFeriasANO: TIntegerField;
    cdsFeriasDIAGOZ: TIntegerField;
    cdsFeriasSALGOZ: TIntegerField;
    dbgFeriasDBTableView1ANO: TcxGridDBColumn;
    Label80: TLabel;
    DBComboBoxFocus2: TDBComboBoxFocus;
    DBEditFocus2: TDBEditFocus;
    Label81: TLabel;
    DBComboBoxFocus3: TDBComboBoxFocus;
    Label82: TLabel;
    DBEditFocus3: TDBEditFocus;
    Label83: TLabel;
    Label84: TLabel;
    DBEditFocus4: TDBEditFocus;
    dbeDtaExa: TDBEditFocus;
    Label85: TLabel;
    Label86: TLabel;
    ColorLabel6: TColorLabel;
    edtBenefEntraIR: TEditFocus;
    cdsBenefDEPEIR: TStringField;
    dbgBenefDBTableViewDEPEIR: TcxGridDBColumn;
    btnCadOpe: TBitBtnLocked;
    Label87: TLabel;
    Label88: TLabel;
    cbQtdDiasCompra: TComboBox;
    dbgFeriasDBTableViewFER_DIACOM: TcxGridDBColumn;
    cdsFeriasDIACOM: TIntegerField;
    GroupBox1: TGroupBox;
    Label89: TLabel;
    ColorLabel4: TColorLabel;
    dbeEmExpe: TDBEditFocus;
    dbchkExpM45: TDBCheckBox;
    dbchkExp45d: TDBCheckBox;
    Label91: TLabel;
    dbeCNS: TDBEditFocus;
    lCodNacionalidade: TLabel;
    dbeCodNacionalidade: TDBEditFocus;
    lNaturezaOcupacao: TLabel;
    dbeNatOcupacao: TDBEditFocus;
    lDtIniEmprego: TLabel;
    dbeDtaInicioEmprego: TDBEditFocus;
    lRendimento: TLabel;
    dbeRendimento: TDBEditFocus;
    grpExpContabil: TGroupBox;
    lblEmpContab:   TLabel;
    dbeEmpCont:     TDBEditFocus;
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeBanco_KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeObservKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodLocNasctoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnFichaCadClick(Sender: TObject);
    procedure dbeNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure dbPorTesKeyPress(Sender: TObject; var Key: Char);
    procedure dbEveTesKeyPress(Sender: TObject; var Key: Char);
    procedure dbForTesKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtRGExit(Sender: TObject);
    procedure edtRGKeyPress(Sender: TObject; var Key: Char);
    procedure edtBenefNomeExit(Sender: TObject);
    procedure btnIncluirBeneficiarioClick(Sender: TObject);
    procedure btnGravarBeneficiarioClick(Sender: TObject);
    procedure btnAlterarBeneficiarioClick(Sender: TObject);
    procedure btnExcluirBeneficiarioClick(Sender: TObject);
    procedure btnCancelarBeneficiarioClick(Sender: TObject);
    procedure dtsBenefStateChange(Sender: TObject);
    procedure btnIncluirFeriasClick(Sender: TObject);
    procedure btnGravarFeriasClick(Sender: TObject);
    procedure btnAlterarFeriasClick(Sender: TObject);
    procedure btnExcluirFeriasClick(Sender: TObject);
    procedure btnCancelarFeriasClick(Sender: TObject);
    procedure dtsFeriasStateChange(Sender: TObject);
    procedure dbeCodFncKeyPress(Sender: TObject; var Key: Char);
    procedure imgCinzaClick(Sender: TObject);
    procedure btnAmpliar1Click(Sender: TObject);
    procedure imgFoto01DblClick(Sender: TObject);
    procedure imgFoto02DblClick(Sender: TObject);
    procedure btnAmpliar2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pgcDadosEnter(Sender: TObject);
    procedure pgcDadosExit(Sender: TObject);
    procedure pgcDadosMouseEnter(Sender: TObject);
    procedure pgcDadosMouseLeave(Sender: TObject);
    procedure btnAbrirPastaAnexosClick(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
    procedure btnCadForClick(Sender: TObject);
    procedure mskAquIniExit(Sender: TObject);
    procedure tbsFeriasShow(Sender: TObject);
    procedure dbEmpTesChange(Sender: TObject);
    procedure dbEmpTesExit(Sender: TObject);
    procedure btnCadOpeClick(Sender: TObject);
    procedure cbQtdDiasCompraExit(Sender: TObject);
    procedure dbchkExpM45Click(Sender: TObject);
    procedure dbchkExp45dClick(Sender: TObject);
  private
    strCepAnt: String;
    objCadFun: TCadFun;
    strObsAnt: String;
    qryCadPor,
    qryCadFor,
    qryCadCta: TUniQuery;
    AEmpresaInicial: String;
    AGravar: Boolean;
    AInsertDadosBeneficiario: Boolean;
    AInsertDadosFerias: Boolean;
    strFoto01: String;
    strFoto02: String;

    FCadFnc: TUniQuery;

    strPlCtaOld : String;

    procedure pLimpaDadosTese;
    procedure pCarregaDadosAdicionais(DataSet: TDataSet);
    procedure pCarregaCidade;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCodCta: String;  edtLabel: TEdit);
    procedure pCarregaEventos;
    procedure pCarregaDadosTese;
    function TemMovimentoComEmpresa: Boolean;
    procedure pPaginaAnterior;

    function GetSQLDadosBeneficiario: String;
    procedure CarregarDadosBeneficiario;
    procedure LimparDadosBeneficiario;
    procedure HabilitarBotoesBeneficiario(InclusaoAltera: Boolean);
    procedure GravarDadosBeneficiario;
    procedure AtualizaDadosBeneficiariosDeVersoesAnteriores;

    function GetSQLDadosFerias: String;
    procedure CarregarDadosFerias;
    procedure ProcessaDiasGozoFerias;
    procedure LimparDadosFerias;
    procedure HabilitarBotoesFerias(InclusaoAltera: Boolean);
    procedure GravarDadosFerias;
    procedure AtualizaDadosFeriasDeVersoesAnteriores;

    function ExisteFuncionarioComOCodigoNaMesmaEmpresa: Boolean;
    function ExisteMovimentacaoAntigaDoFuncionario: Boolean;

    procedure AtualizandoDadosFuncionarioDeVersoesAnteriores;

    procedure pSetaSemaforo(objImage: TImage);
    procedure pSetaSemaforos;
    procedure pAmpliarFoto(strFoto: String);
    function fCarregaFoto : String;
    procedure pCarregaImagem;

    function AtualizaFuncaoFuncionario: Boolean;
    procedure CarregaFuncao;

    procedure pHabilitaBotoes;
    procedure pHabilitaDesabiltabtnAbrirPastaAnexos;
    function PeriodoGozoMaiorQuePeriodoAquisitivo: Boolean;
    function PeriodoDeGozoJaIncluindo: Boolean;
    function AtingiuLimiteDeFeriasNoAno:Boolean;
    function PeriodoDeGozoUmAnoAposAquisicao: Boolean;
    function fCadastroRapidoFornecedor(var strCodFor: String; cdsDados: TDataSet): Boolean;
    function fCadastroRapidoOperador(var strCodOpe: String; cdsDados: TDataSet): Boolean;
    function ExisteCTRPAGParaOFuncionario(out AMsgValidacao: String): Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadFuncionarios: TfrmCadFuncionarios;

implementation

uses SysUtils, Variants, untFuncoesSimples, untPai, untConsultas,
     untConstantes, untPesqAux, System.Types, untTypesSistema,
     untFuncoesGenerica, TypesRel, untRelFichaCadFuncionario, untCadCid,
     untCadCidades, untCadCta, untImagem, untGravando, untFuncIns,
     untGravaArquivoPasta, untLiberacaoFactory, untILiberacao;

{$R *.dfm}

procedure TfrmCadFuncionarios.fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.dbeCodCtaExit(Sender);

end;

procedure TfrmCadFuncionarios.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContas.dbeCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;

end;

function TfrmCadFuncionarios.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    strCodCid   : String;
    strEndere   : String;
    strBairro   : String;
    strNomCid   : String;
    strEstado   : String;
    blnAtualizar : Boolean;


    LCodigoCorreio: String;
    LWhereValidaCPF: String;
    LObjLiberacao : ILiberacao;
begin
  blnAtualizar := False;
  Result := True;


  Try
    If (inherited fValidaCampos(Sender)) Then
    Begin
      {******************************}
      {* VALIDA O CODIGO DA EMPRESA *}
      {***************************PZ*}

      If (Sender = dbeCodEmp) Then
      Begin

        If (fEmptyStr(dbeCodEmp.Text)) Then
        Begin
          edtNomEmp.Clear;
          fMensagem('ATENÇÃO!','O Código da Empresa deve ser preenchido!',['&O k']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeCodEmp);
          Result := False;
        End
        Else
        Begin
          edtNomEmp.Text := fRetNomeEmpresa(dbeCodEmp.Text);
          If (fEmptyStr(edtNomEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada!',['&O k']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodEmp);
            Result := False;
          End;
        End;
        pHabilitaBotoes;
      End

      Else If (Sender = dbeCodFun) Then
      Begin
        If (dbeCodFun.Enabled) And (fEmptyStr(dbeCodFun.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O Código do funcionário deve ser preenchido!',['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeCodFun);
          Result := False;
        End;

        If (Result) And (dbeCodFun.DataSource.DataSet.State = dsInsert) Then
          dbeCodFun.Field.Value := fStrZero(dbeCodFun.Text, 6);
      End

      {********************************}
      {* VALIDA O NOME DO FUNCIONÁRIO *}
      {*****************************PZ*}
      Else If (Sender = dbeNomFun) Then
      Begin

        If (fEmptyStr(dbeNomFun.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Nome do Funcionário deve ser preenchido!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeNomFun);
          Result := False;
        End;

      End
      {**********************************}
      {* VALIDA A FUNÇÃO DO FUNCIONÁRIO *}
      {*******************************PZ*}
      Else If (Sender = dbeCodFnc) Then
      Begin

        If (fEmptyStr(dbeCodFnc.Text)) Then
        Begin
          edtNomFnc.Clear;
          fMensagem('ATENÇÃO!', 'A Função deve ser preenchida!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeCodFnc);
          Result := False;
        End
        Else
        Begin
          CarregaFuncao;
          If (fEmptyStr(edtNomFnc.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','Essa Função não está cadastrada!',['&O k']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodFnc);
            Result := False;
          End;
        End;

      End

      Else If (Sender = dbeCodVen) Then
      Begin
        If (Not fEmptyStr(dbeCodVen.Text)) Then
        Begin
          edtNomVen.Text := fRetNomVendRep(dbeCodVen.Text);
          If (fEmptyStr(edtNomVen.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','Esse Vendedor não está cadastrado!',['&O k']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodVen);
            Result := False;
          End;
        End
        Else
          edtNomVen.Clear;
      End

      {*****************************}
      {* VALIDA A DATA DE ADMISSÃO *}
      {**************************PZ*}
      Else If (Sender = dbeDtaAdm) Then
      Begin

        If (fEmptyStr(fTiraCaracEspeciais(dbeDtaAdm.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Admissão deve ser preenchida!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeDtaAdm);
          Result := False;
        End;

      End
      {*************************}
      {* VALIDA O SALÁRIO BASE *}
      {**********************PZ*}
      Else If (Sender = dbeSalBas) Then
      Begin

        If (fEmptyStr(dbeSalBas.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Salário Base deve ser preenchido!', ['&Ok']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(dbeSalBas);
          Result := False;
        End
        Else If (fStrToFloat(dbeSalBas.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!','O Salário Base não pode ser um valor negativo!',['&O k']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(dbeSalBas);
          Result := False;
        End;
      End

      {*************************}
      {* VALIDA A ALIQ. INSS   *}
      {*************************}
      Else If (Sender = dbeAlqIns) Then
      Begin

        If (fStrToFloat(dbeAlqIns.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!','A Alíquota INSS não pode ter um valor negativo!',['&Ok']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(dbeAlqIns);
          Result := False;
        End;
      End

      {***************************}
      {* VALIDA A BASE CAL. I.R. *}
      {***************************}
      Else If (Sender = dbeBCalIr) Then
      Begin

        If (fStrToFloat(dbeBCalIr.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!','A Base Cál. I.R. não pode ter um valor negativo!',['&Ok']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(dbeBCalIr);
          Result := False;
        End;
      End

      {*************************}
      {* VALIDA O ALIQ. I.R *}
      {*************************}

      Else If (Sender = dbeAliqIR) Then
      Begin

        If (fStrToFloat(dbeAliqIR.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!','O A Alíq. I.R  não pode ter um valor negativo!',['&Ok']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(dbeAliqIR);
          Result := False;
        End;
      End

      {*****************************}
      {* VALIDA A DATA DE DEMISSÃO *}
      {**************************PZ*}
      Else If (Sender = dbeDtaDem) Then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDem.Text))) Then
        Begin
          If (fEmptyStr(fTiraCaracEspeciais(dbeDtaAdm.Text))) Then
          Begin
            fMensagem('ATENÇÃO!','Não é possível definir uma Data de Demissão, pois não foi definida a Data de Admissão!',['&O k']);
            Result := False;
            blnMudarFoco := False;
            pSetFocus(dbeDtaAdm);
            Exit;
          End
          Else If (strToDate(dbeDtaDem.Text) < strToDate(dbeDtaAdm.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','A Data de Demissão não pode ser menor que a Data de Admissão!',['&O k']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeDtaDem);
            Result := False;
          End;
        End
        Else
        Begin
          dbeDtaDem.Field.Value := Null;
          dbcMotDes.Field.Value := '';
        End;

      End
      {******************}
      {* VALIDA O BANCO *}
      {***************PZ*}
      Else If (Sender = dbeBanco_) Then
      Begin

        If (fEmptyStr(dbeBanco_.Text)) Then
        Begin
          dbeBanco_.Field.Value := Null;
          edtNomBan.Clear;
          dbeAgenci.Field.Value := '';
          dbeConta_.Field.Value := '';
          dbeAgenci.Enabled     := False;
          dbeConta_.Enabled     := False;
        End
        Else
        Begin
          edtNomBan.Text := fRetNomBanco(dbeBanco_.Text);
          If (fEmptyStr(edtNomBan.Text)) Then
          Begin
            fMensagem('ATENÇÃO','Esse Banco não está cadastrado!',['&O k']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeBanco_);
            Result := False;
          End
          Else
          Begin
            dbeAgenci.Enabled := True;
            dbeConta_.Enabled := True;
          End;
        End
      End

      {******************************************************}
      {* VALIDA A AGÊNCIA CASO TENHA SIDO INFORMADO O BANCO *}
      {***************************************************PZ*}
      Else If (Sender = dbeAgenci) And (Not fEmptyStr(dbeBanco_.Text)) Then
      Begin
        If (fEmptyStr(dbeAgenci.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Agência deve ser preenchida!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeAgenci);
          Result := False;
        End;
      End

      {****************************************************}
      {* VALIDA A CONTA CASO TENHA SIDO INFORMADO O BANCO *}
      {*************************************************PZ*}
      Else If (Sender = dbeConta_) And (Not fEmptyStr(dbeBanco_.Text)) Then
      Begin
        If (fEmptyStr(dbeConta_.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Número da Conta deve ser preenchido!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeConta_);
          Result := False;
        End;
      End

      Else If (Sender = dbeObserv) Then
      Begin
        If (Result) And (blnBuscaPorChave) Then
          pProximaPagina;
      End

      Else If ((Sender = mskAquIni) Or (Sender = mskAquFin)) And (blnBuscaPorChave) Then
      Begin

        If (Sender = mskAquIni) And (fEmptyStr(fTiraCaracEspeciais(mskAquIni.Text))) Then
        Begin
          fMensagem('ATENÇÃO!','A data inicial do período aquisitivo deve ser preenchida!',['&O k']);
          pgcDados.ActivePage := tbsFerias;
          pSetFocus(Sender);
          Exit(False);
        End;

        If (Sender = mskAquFin) And fEmptyStr(fTiraCaracEspeciais(mskAquFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','A data final do período aquisitivo deve ser preenchida!',['&O k']);
          pgcDados.ActivePage := tbsFerias;
          pSetFocus(Sender);
          Exit(False);
        End;

        If (Not fEmptyStr(fTiraCaracEspeciais(mskAquIni.Text))) Then
          mskAquIni.Text := DateToStr(StrToDate(mskAquIni.Text));

        If (Not fEmptyStr(fTiraCaracEspeciais(mskAquFin.Text))) Then
          mskAquFin.Text := DateToStr(StrToDate(mskAquFin.Text));

        If (Not fEmptyStr(fTiraCaracEspeciais(mskAquIni.Text))) And
           (Not fEmptyStr(fTiraCaracEspeciais(mskAquFin.Text))) Then
        Begin
          If (StrToDate(mskAquFin.Text) < StrToDate(mskAquIni.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','A Data Final não pode ser menor que a Data Inicial!',['&O k']);
            pgcDados.ActivePage := tbsFerias;
            pSetFocus(mskAquFin);
            Result := False;
          End;
        End;
      End

      Else If (Sender = cbQtdDiasCompra) And (blnBuscaPorChave) Then
      Begin
       if (cdsFerias.State in [DsInsert,DsEdit])  Then
        Begin

          if (AtingiuLimiteDeFeriasNoAno ) Then
          Begin
            fMensagem('ATENÇÃO!','Funcionário atingiu o limite de férias para este ano.',['&O k']);
            pgcDados.ActivePage := tbsFerias;
            pSetFocus(mskGozIni);
            Exit(False);
          End;

        End;
      End

      Else If ((Sender = mskGozIni) Or (Sender = mskGozFin)) And (blnBuscaPorChave) Then
      Begin

        If (Not fEmptyStr(fTiraCaracEspeciais(mskGozIni.Text))) Then
          mskGozIni.Text := DateToStr(StrToDate(mskGozIni.Text));

        If (Not fEmptyStr(fTiraCaracEspeciais(mskGozFin.Text))) Then
          mskGozFin.Text := DateToStr(StrToDate(mskGozFin.Text));

        If (Not fEmptyStr(fTiraCaracEspeciais(mskGozIni.Text))) And
           (Not fEmptyStr(fTiraCaracEspeciais(mskGozFin.Text))) Then
        Begin
          If (StrToDate(mskGozFin.Text) < StrToDate(mskGozIni.Text)) Then
          Begin
            fMensagem('ATENÇÃO!','A Data Final não pode ser menor que a Data Inicial!',['&O k']);
            pgcDados.ActivePage := tbsFerias;
            pSetFocus(Sender);
            Result := False;
          End
          Else If PeriodoDeGozoUmAnoAposAquisicao Then
          Begin
            fMensagem('ATENÇÃO!','O período de gozo ultrapassa 1 ano e 11 meses do período aquisitivo!',['&O k']);
            pgcDados.ActivePage := tbsFerias;
            pSetFocus(mskGozFin);
            Result := False;
          End;

          If Not fValidaCampos(mskAquIni, blnBuscaPorChave) Then
            Exit;

          cdsFeriasClone.Filtered:=False;
          cdsFeriasClone.Filter:='ANO='+QuotedStr(Copy(mskAquIni.Text,7,4));
          cdsFeriasClone.Filtered:=True;
          cdsFeriasClone.Last;


          if (cdsFerias.State in [DsInsert,DsEdit])  Then
          Begin

            if (AtingiuLimiteDeFeriasNoAno ) Then
            Begin
              fMensagem('ATENÇÃO!','Funcionário atingiu o limite de férias para este ano.',['&O k']);
              pgcDados.ActivePage := tbsFerias;
              pSetFocus(mskGozIni);
              Exit(False);
            End;

          End;

         { if (cdsFerias.State in [DsEdit]) Then
          Begin
              SDiasGozo := cdsFerias.FieldByName('SALDO').AsInteger;

              diasGozoA := cdsFerias.FieldByName('DIAGOZ').AsInteger;
              SDiasGozo :=SDiasGozo + diasGozoA;
              diasGozo  := DaysBetween(StrToDate(mskGozIni.Text),StrToDate(mskGozFin.Text)+1);

              if (SDiasGozo-diasGozo < 0) Then
              Begin
                  fMensagem('ATENÇÃO!','Funcionário atingiu o limite de férias para este ano.',['&O k']);
                  pgcDados.ActivePage := tbsFerias;
                  pSetFocus(mskGozIni);
                  Exit(False);
              End;
          End;    }


        End

      End

      Else If (Sender = mskDtaRec) And (blnBuscaPorChave) Then
      Begin

        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaRec.Text))) Then
          mskDtaRec.Text := DateToStr(StrToDate(mskDtaRec.Text));
      End
      Else If (Sender = dbeCPF) Then
      Begin
        If Not fEmptyStr(dbeCPF.Text) Then
        Begin
          Result := fValidaCnpjCpf('2', dbeCPF.Text);

          If (Result) Then
          Begin

            If Not fValidaCampos(dbeCodEmp) Then
              Exit(False);

            LWhereValidaCPF := ' AND T1.FUN_CODEMP = ' + dbeCodEmp.Field.AsString.QuotedString;

            Result := not fExisteCnpjCpf('CADFUN', 'FUN_CODFUN', dbeCodFun.Text, 'FUN_C_P_F_', dbeCPF.Text, '','', LWhereValidaCPF);
            If (Not Result) And (fCfgSis('VERCGC') = 'L') Then
            begin
              LObjLiberacao := TLiberacaoFactory.fGetLiberacao;
              LObjLiberacao.Clear;
              LObjLiberacao.objMsgLibera.pAddTexto('Já existe um outro funcionário cadastrado com o CPF ' + dbeCPF.Text + '!');

              LObjLiberacao.strDirAce := 'VEFCPF';
              LObjLiberacao.strCodOpe := strLoginUsuarioLogado;

              Result := LObjLiberacao.fLibera;
            end;
          End
            Else
              Result := True;
        End;
      End

      Else If (Sender = dbeCodLocNascto) Then
      Begin
        If Not fEmptyStr(dbeCodLocNascto.Text) Then
        Begin

          edtLocalNascto.Text := fRetNomCidade(dbeCodLocNascto.Text);

          If fEmptyStr(edtLocalNascto.Text) Then
          Begin
            fMensagem('','Local de nascimento não encontrado!',['&Ok']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodLocNascto);
            Result := False;
          End;

        End;
      End

      Else If (Sender = dbcMotDes) Then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaDem.Text))) And (fEmptyStr(dbcMotDes.Text)) Then
        Begin
          fMensagem('','Informe o motivo do desligamento!',['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbcMotDes);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DA CIDADE             *}
      {**************************************AC*}
      Else If (Sender = dbeCodCid) Then
      Begin
        If fEmptyStr(dbeCodCid.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código da Cidade deve ser preenchido!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          pSetFocus(dbeCodCid);
          Result := False;
        End
        Else
        Begin
          pCarregaCidade;
          If fEmptyStr(edtNomCid.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodCid);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeNumCep) Then
      Begin

        If (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
        Begin
          If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
          Begin
            fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeNumCep);
            Result := False;
          End;
        End;

        If (Result) And (fCfgSis('USACEP', varBoolean)) And (edtEstado.Text <> 'EX') Then
        Begin

          If (Not fCadCepDadosCep(dbeNumCep.Text, strCodCid, strEndere, strBairro, strNomCid, strEstado, LCodigoCorreio,
                                                  '' {qryConCid.FieldByName('CID_ESTADO').AsString},
                                                  '' {qryConCid.FieldByName('CID_CODCOR').AsString})) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fVerificaAcessoSistema('frmCadCidades') Then
              Begin
                fMensagem('ATENÇÃO!', fMensagemTravaAcessoCadCid(dbeCodCid.Text, edtNomCid.Text), ['&Ok']);

                Result := False;

              End

              Else

              If Not fEmptyStr(fRetNomCidade(dbeCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
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

              If fEmptyStr(dbeEndFun.Text) Or (blnAtualizar) Then
                dbeEndFun.Field.AsString := strEndere;

              If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
                dbeBairro.Field.AsString := strBairro;

              {***********************************}
              {* CASO O CEP NÃO POSSUIR ENDERECO *}
              {********************************JB*}
              If (Not fEmptyStr(strNomCid)) And (fEmptyStr(strEndere)) Then
              Begin
                If fEmptyStr(dbeEndFun.Text) Or (blnAtualizar) Then
                Begin
                  dbeEndFun.Field.AsString := fTiraCaracEspeciais(strNomCid);
                  strEndere                := dbeEndFun.Field.AsString;
                End;
              End;

              If (strCodCid <> dbeCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
              Begin
                Result := False;
                pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCodCid.Text) + '!');
                pgcDados.ActivePage := tbsGeral;
                pSetFocus(dbeNumCep);
              End;

            End;

          End;

          If (Result) Then
          Begin
            strCepAnt := dbeNumCep.Text;

            If blnAtualizar Then
            Begin
              pSetFocus(dbeEndNum);
              blnMudarFoco := False;
            End;
          End;

        End;


      End

      Else If (Sender = edtBenefNome) then
      begin
        if fEmptyStr(edtBenefNome.Text) and (cdsBenef.State in dsEditModes) then
        begin
          fMensagem('', 'O nome do beneficiário deve ser preenchido!', ['&Ok']);
          pgcDados.ActivePage := tbsBeneficiarios;
          pSetFocus(edtBenefNome);
          Result := False;
        end;
      end

      Else If (Sender = mskDtaNasc) then
      begin
        if (fEmptyStr(fTiraCaracEspeciais(mskDtaNasc.Text))) and (cdsBenef.State in dsEditModes) then
        begin
          fMensagem('', 'A data de nascimento do beneficiário deve ser preenchida!', ['&Ok']);
          pgcDados.ActivePage := tbsBeneficiarios;
          pSetFocus(mskDtaNasc);
          Result := False;
        end;
      end
      //MF: 288302 - 24/05/23 - INI
      Else If (Sender = edtBenefEntraIR) and (cdsBenef.State in dsEditModes) Then
      Begin

        If Pos(edtBenefEntraIR.Text, 'SN') <= 0 Then
        Begin
          Result := False;
          fMensagem('','O campo Dependente entra no IR deve ser informado com (S)im ou (N)ão!', ['&Ok']);
        End
      End
      //MF: 288302 - 24/05/23 - fim

      Else If (Sender = DbeNumTel) or (Sender = DbeNumCel) then
      Begin
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
      End

      {*Req. 203320 *****************************************}
      {* EXCLUSÃO DA OBRIGATORIEDADE DE INFORMAR O PORTADOR *}
      {***************************************************MR*}
      Else If (Sender = dbPorTes) Then
      Begin
        Result := True;
        pCarregaPortador(dbPorTes.Text, edtDesPorTes);
        If Not fEmptyStr(dbPorTes.Text) Then
        begin
          If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('', 'Esse portador não está cadastrado!', ['&Ok']);
            pgcDados.ActivePage := tbsCtaPag;
            pSetFocus(dbPorTes);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbPorTes.Text, dbeCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            pgcDados.ActivePage := tbsGeral;
            pSetFocus(dbeCodEmp);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If (Pos(dbPorTes.Text, strPortadoresOperador) <= 0) Then
            Begin
              If Not fEmptyStr(edtDesPorTes.Text) Then
              Begin
                fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!', ['&Ok']);
                pgcDados.ActivePage := tbsCtaPag;
                pSetFocus(dbPorTes);
                Result := False;
              End
            End;

          End;
        end;
      End

      Else if (Sender = dbForTes)  Then
      Begin
        edtDesForTes.Clear;
        If fEmptyStr(dbForTes.Text) Then
        begin
          if not fEmptyStr(dbCodTes.Text) then
          Begin
            fMensagem('ATENÇÃO','O Código do fornecedor para integração com o contas a pagar deve ser preenchido!',['&OK']);
            pgcDados.ActivePage := tbsCtaPag;
            pSetFocus(dbForTes);
            Result := False;
          End;
        end
        else
        begin
          pPesquisaCadFor(qryCadFor, qryCadFor, dbForTes.Text);

          If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('', 'Esse fornecedor não está cadastrado!', ['&Ok']);
            pgcDados.ActivePage := tbsCtaPag;
            pSetFocus(dbForTes);
            Result := False;
          End
          else
            edtDesForTes.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
        end;
      End

      {*Req. 203320 ************************************************}
      {* EXCLUSÃO DA OBRIGATORIEDADE DE INFORMAR O PLANO DE CONTAS *}
      {**********************************************************MR*}
      Else If (Sender = fraPlanoDeContas.dbeCodCta) Then
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
        If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          pgcDados.ActivePage := tbsCtaPag;
          pSetFocus(fraPlanoDeContas.dbeCodCta);
          Result := False;
        End
        else
        Begin
          pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta.Text, fraPlanoDeContas.edtDesCta);
          If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
            pgcDados.ActivePage := tbsCtaPag;
            pSetFocus(fraPlanoDeContas.dbeCodCta);
            Result := False;
          End
          else
          Begin
            fraPlanoDeContas.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
            if ((qryTabela.State in [dsInsert]) or (strPlCtaOld <> fraPlanoDeContas.dbeCodCta.Text))
            And (fraPlanoDeContas.dbeCodCta.Text <> '') then
              Result := PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text,True)
            Else
            If fraPlanoDeContas.dbeCodCta.Text = '' Then
              fraPlanoDeContas.edtDesCta.Clear;
          End;
        end;

      End
      Else If (Sender = dbEveTes) Then
      Begin
        edtDesEveTes.Clear;
        If Not fEmptyStr(dbEveTes.Text) Then
        Begin
          pCarregaEventos;
          If fEmptyStr(edtDesEveTes.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
            pgcDados.ActivePage := tbsCtaPag;
            pSetFocus(dbEveTes);
            Result := False;
          End;
        End
        Else
          dbEveTes.Clear;
      End

      Else If (Sender = dbeFilhos) Or (Sender = dbeQtdFil) Then
      Begin
        If Not fEmptyStr(dbeFilhos.Text) And (Pos(dbeFilhos.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Possui Filhos deve ser preenchido com "N" ou "S"!', ['&Ok']);
          pgcDados.ActivePage := tbsComp;
          pSetFocus(dbeFilhos);
          Result := False;
        End
        Else If (Sender = dbeFilhos) And (dbeFilhos.Text = 'N') Then
        Begin
          dbeQtdFil.Field.AsInteger := 0;
        End
        Else If (Sender = dbeQtdFil) And (dbeFilhos.Text = 'N') Then
        Begin
          If (StrToIntDef(dbeQtdFil.Text,0) > 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Quantidade de Filhos não pode ser maior que 0 (zero)!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeQtdFil);
            Result := False;
          End;
        End
        Else If (Sender = dbeQtdFil) And (dbeFilhos.Text = 'S') Then
        Begin
          If (StrToIntDef(dbeQtdFil.Text,0) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'Quantidade de Filhos não pode ser menor ou igual a 0 (zero)!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeQtdFil);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbeEmExpe) Or (Sender = dbchkExp45d) Or (Sender = dbchkExpM45)  Then
      Begin
        If Not fEmptyStr(dbeEmExpe.Text) And (Pos(dbeEmExpe.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Em Experiência deve ser preenchido com "N" ou "S"!', ['&Ok']);
          pgcDados.ActivePage := tbsComp;
          pSetFocus(dbeEmExpe);
          Result := False;
        End
        Else If (Sender = dbeEmExpe) And (dbeEmExpe.Text = 'N') Then
        Begin
          dbchkExpM45.Enabled := False;
          dbchkExp45d.Enabled := False;
          dbchkExpM45.Field.AsString := 'N';
          dbchkExp45d.Field.AsString := 'N';
        End
        Else If (Sender = dbeEmExpe) And (dbeEmExpe.Text = 'S') Then
        Begin
          dbchkExp45d.Enabled := True;
          dbchkExpM45.Enabled := True;
        End
        Else If (dtsCadFun.DataSet.State in [dsEdit, dsInsert]) And
                ((dbchkExpM45.Checked) And (Not dbchkExp45d.Checked)) Then
        Begin
          fMensagem('ATENÇÃO!', '"Em Experiência - mais 45 dias" só pode ser selecionado caso "Em Experiência - 45 dias" ja tiver sido selecionado anteriormente !', ['&Ok']);
          pgcDados.ActivePage := tbsComp;
          dbchkExpM45.Checked := False;
          pSetFocus(dbeEmExpe);
          Result := False;
        End
      End

      Else If (Sender = dbeCorFun) Then
      Begin
        If Not fEmptyStr(dbeCorFun.Text) Then
          If Not MatchStr(dbeCorFun.Text, ['A','B','R','P']) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Cor deve ser preenchida com "A", "B", "R" ou "P"!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeCorFun);
            Result := False;
          End;
      End

      Else If (Sender = dbeTamanh) Then
      Begin
        If Not fEmptyStr(dbeTamanh.Text) Then
          If Not MatchStr(dbeTamanh.Text, ['P','M','G','GG','XG']) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Tamanho deve ser preenchido com "P", "M", "G", "GG" ou "XG"!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeTamanh);
            Result := False;
          End;
      End

      Else If (Sender = dbeAltura) Then
      Begin
        If Not fEmptyStr(dbeAltura.Text) Then
        Begin
          If StrToFloat(dbeAltura.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A altura deve ser maior que 0 (zero)!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeAltura);
            Result := False;
          End
          Else If StrToFloat(dbeAltura.Text) > 9.99 Then
          Begin
            fMensagem('ATENÇÃO!', 'A altura deve ser menor que 9,99!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbeAltura);
            Result := False;
          End;
        End;
      End

      Else If (Sender = dbePesFun) Then
      Begin
        If Not fEmptyStr(dbePesFun.Text) Then
        Begin
          If StrToFloat(dbePesFun.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O peso deve ser maior que 0 (zero)!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbePesFun);
            Result := False;
          End
          Else If StrToFloat(dbePesFun.Text) > 999.999 Then
          Begin
            fMensagem('ATENÇÃO!', 'O peso deve ser menor que 999,99!', ['&Ok']);
            pgcDados.ActivePage := tbsComp;
            pSetFocus(dbePesFun);
            Result := False;
          End;
        End;
      End

    End;
  Except
    On E: ExceptionAutCom Do
    Begin
			fMensagem('', E.Message, ['&Ok']);
      Result := False;
    End;

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmCadFuncionarios.fValidaCampos]');
      Result := False;  
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadFuncionarios.GetSQLDadosBeneficiario: String;
begin
  Result := 'SELECT AUTOINCREM, ' +
            '       BNF_NOMBEN AS NOMBEN, ' +
            '       BNF_GRAPAR AS GRAPAR, ' +
            '       BNF_CODFUN AS CODFUN, ' +
            '       BNF_CODEMP AS CODEMP, ' +
            '       BNF_NUMCPF AS NUMCPF, ' +
            '       BNF_DTANAS AS DTANAS, ' +
            '       BNF_NUMRG  AS NUMRG,  ' +
            '       BNF_DEPEIR AS DEPEIR, ' +//MF: 288302 - 24/05/23
            '       BNF_AUTFUN AS AUTFUN  ' +
            'FROM FUNBNF ' +
            'WHERE BNF_AUTFUN=:INCFUN     ';
end;

function TfrmCadFuncionarios.GetSQLDadosFerias: String;
begin
  Result := 'SELECT AUTOINCREM, ' +
            '       FER_CODEMP AS CODEMP, ' +
            '       FER_CODFUN AS CODFUN, ' +
            '       FER_AQUINI AS AQUINI, ' +
            '       FER_AQUFIN AS AQUFIN, ' +
            '       FER_GOZINI AS GOZINI, ' +
            '       FER_GOZFIN AS GOZFIN, ' +
            '       FER_DIACOM AS DIACOM, ' +
            '       FER_DTAREC AS DTAREC, ' +
            '       FER_VALREC AS VALREC, ' +
            '       FER_AUTFUN AS AUTFUN  ' +
            'FROM FUNFER ' +
            'WHERE FER_AUTFUN=:INCFUN     '+
            'ORDER BY AQUINI ';
end;

procedure TfrmCadFuncionarios.GravarDadosBeneficiario;
Var
  qryBeneficiario: TUniQuery;
  qryExecuta     : TUniQuery;
  AutoIncrem     : string;

  procedure ApagaBeneficiario(AutoIncremento: string);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('DELETE FROM FUNBNF ');
    qryExecuta.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    qryExecuta.ParamByName('AUTINC').AsString := AutoIncremento;
    qryExecuta.ExecSQL;
  end;

  procedure InsereBeneficiario(ANomeBeneficiario,
                               AGrauParentesco,
                               ACodFuncionario,
                               ACodEmpresa,
                               ANumeroCPF,
                               ANumeroRG,
                               ADepEntraIR,//MF: 288302 - 24/05/23
                               AAutoIncremFuncionario: string;
                               ADataNasc: TDateTime;
                               out AAutoIncrem: string);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('INSERT INTO FUNBNF ( AUTOINCREM');
    qryExecuta.SQL.Add('                    ,BNF_NOMBEN');
    qryExecuta.SQL.Add('                    ,BNF_GRAPAR');
    qryExecuta.SQL.Add('                    ,BNF_CODFUN');
    qryExecuta.SQL.Add('                    ,BNF_CODEMP');
    qryExecuta.SQL.Add('                    ,BNF_NUMCPF');
    qryExecuta.SQL.Add('                    ,BNF_DTANAS');
    qryExecuta.SQL.Add('                    ,BNF_NUMRG ');
    qryExecuta.SQL.Add('                    ,BNF_DEPEIR');//MF: 288302 - 24/05/23
    qryExecuta.SQL.Add('                    ,BNF_AUTFUN');
    qryExecuta.SQL.Add(' ) VALUES         ( :AUTINC    ');
    qryExecuta.SQL.Add('                   ,:NOMBEN    ');
    qryExecuta.SQL.Add('                   ,:GRAPAR    ');
    qryExecuta.SQL.Add('                   ,:CODFUN    ');
    qryExecuta.SQL.Add('                   ,:CODEMP    ');
    qryExecuta.SQL.Add('                   ,:NUMCPF    ');
    qryExecuta.SQL.Add('                   ,:DTANAS    ');
    qryExecuta.SQL.Add('                   ,:NUMRG     ');
    qryExecuta.SQL.Add('                   ,:DEPEIR    ');//MF: 288302 - 24/05/23
    qryExecuta.SQL.Add('                   ,:AUTFUN)   ');

    AAutoIncrem := fRetAutoIncrem('FUNBNF', VS_strCodEmp);
    qryExecuta.ParamByName('AUTINC').AsString   := AAutoIncrem;
    qryExecuta.ParamByName('NOMBEN').AsString   := ANomeBeneficiario;
    qryExecuta.ParamByName('GRAPAR').AsString   := AGrauParentesco;
    qryExecuta.ParamByName('CODFUN').AsString   := ACodFuncionario;
    qryExecuta.ParamByName('CODEMP').AsString   := ACodEmpresa;
    qryExecuta.ParamByName('NUMCPF').AsString   := ANumeroCPF;
    qryExecuta.ParamByName('DTANAS').AsDateTime := ADataNasc;
    qryExecuta.ParamByName('NUMRG').AsString    := ANumeroRG;
    qryExecuta.ParamByName('DEPEIR').AsString   := ADepEntraIR; //MF: 288302 - 24/05/23
    qryExecuta.ParamByName('AUTFUN').AsString   := AAutoIncremFuncionario;
    qryExecuta.ExecSQL;
  end;

  procedure AtualizaBeneficiario(ANomeBeneficiario,
                                 AGrauParentesco,
                                 ACodFuncionario,
                                 ACodEmpresa,
                                 ANumeroCPF,
                                 ANumeroRG,
                                 ADepEntraIR,//MF: 288302 - 24/05/23
                                 AAutoIncrem,
                                 AAutoIncremFuncionario: string;
                                 ADataNasc: TDateTime);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('UPDATE FUNBNF SET ');
    qryExecuta.SQL.Add('              BNF_NOMBEN = :NOMBEN ');
    qryExecuta.SQL.Add('             ,BNF_GRAPAR = :GRAPAR ');
    qryExecuta.SQL.Add('             ,BNF_CODFUN = :CODFUN ');
    qryExecuta.SQL.Add('             ,BNF_CODEMP = :CODEMP ');
    qryExecuta.SQL.Add('             ,BNF_NUMCPF = :NUMCPF ');
    qryExecuta.SQL.Add('             ,BNF_DTANAS = :DTANAS ');
    qryExecuta.SQL.Add('             ,BNF_NUMRG  = :NUMRG  ');
    qryExecuta.SQL.Add('             ,BNF_DEPEIR = :DEPEIR ');//MF: 288302 - 24/05/23
    qryExecuta.SQL.Add('             ,BNF_AUTFUN = :AUTFUN ');
    qryExecuta.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryExecuta.ParamByName('AUTINC').AsString   := AAutoIncrem;
    qryExecuta.ParamByName('NOMBEN').AsString   := ANomeBeneficiario;
    qryExecuta.ParamByName('GRAPAR').AsString   := AGrauParentesco;
    qryExecuta.ParamByName('CODFUN').AsString   := ACodFuncionario;
    qryExecuta.ParamByName('CODEMP').AsString   := ACodEmpresa;
    qryExecuta.ParamByName('NUMCPF').AsString   := ANumeroCPF;
    qryExecuta.ParamByName('DTANAS').AsDateTime := ADataNasc;
    qryExecuta.ParamByName('NUMRG').AsString    := ANumeroRG;
    qryExecuta.ParamByName('DEPEIR').AsString   := ADepEntraIR; //MF: 288302 - 24/05/23
    qryExecuta.ParamByName('AUTFUN').AsString   := AAutoIncremFuncionario;
    qryExecuta.ExecSQL;
  end;
begin
  qryBeneficiario := fCriaQuery();
  qryExecuta      := fCriaQuery();

  Try
    cdsBenef.DisableControls;
    qryBeneficiario.SQL.Clear;
    qryBeneficiario.SQL.Text := GetSQLDadosBeneficiario;
    qryBeneficiario.ParamByName('INCFUN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

    qryBeneficiario.Open;

    While (Not qryBeneficiario.Eof) Do
    Begin
      If (Not cdsBenef.Locate('AUTOINCREM', qryBeneficiario.FieldByName('AUTOINCREM').AsString, [])) Then
        ApagaBeneficiario(qryBeneficiario.FieldByName('AUTOINCREM').AsString);

      qryBeneficiario.Next;
    End;

    cdsBenef.First;
    While (Not cdsBenef.Eof) Do
    Begin
      Try
        If (fEmptyStr(cdsBenef.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          InsereBeneficiario(cdsBenef.FieldByName('NOMBEN').AsString,
                             cdsBenef.FieldByName('GRAPAR').AsString,
                             cdsBenef.FieldByName('CODFUN').AsString,
                             cdsBenef.FieldByName('CODEMP').AsString,
                             cdsBenef.FieldByName('NUMCPF').AsString,
                             cdsBenef.FieldByName('NUMRG').AsString,
                             cdsBenef.FieldByName('DEPEIR').AsString,//MF: 288302 - 24/05/23
                             qryTabela.FieldByName('AUTOINCREM').AsString,
                             cdsBenef.FieldByName('DTANAS').AsDateTime,
                             AutoIncrem);

          cdsBenef.Edit;
          cdsBenef.FieldByName('AUTOINCREM').AsString := AutoIncrem;
          cdsBenef.Post;
        End
        Else
        Begin
          If (qryBeneficiario.Locate('AUTOINCREM', cdsBenef.FieldByName('AUTOINCREM').AsString, [])) Then
            AtualizaBeneficiario(cdsBenef.FieldByName('NOMBEN').AsString,
                                 cdsBenef.FieldByName('GRAPAR').AsString,
                                 cdsBenef.FieldByName('CODFUN').AsString,
                                 qryTabela.FieldByName('FUN_CODEMP').AsString,
                                 cdsBenef.FieldByName('NUMCPF').AsString,
                                 cdsBenef.FieldByName('NUMRG').AsString,
                                 cdsBenef.FieldByName('DEPEIR').AsString,//MF: 288302 - 24/05/23
                                 cdsBenef.FieldByName('AUTOINCREM').AsString,
                                 qryTabela.FieldByName('AUTOINCREM').AsString,
                                 cdsBenef.FieldByName('DTANAS').AsDateTime);
        End;

        cdsBenef.Next;
      Except
        on E: Exception do
          pMensagensErro(E.Message, '[TfrmCadFuncionarios.GravarDadosBeneficiario]');
      End;
    End;

    pnlAcoesBeneficiario.Enabled := False;
  Finally
    cdsBenef.EnableControls;
    FreeAndNil(qryExecuta);
    FreeAndNil(qryBeneficiario);
  End;
end;

procedure TfrmCadFuncionarios.GravarDadosFerias;
Var
  qryFerias : TUniQuery;
  qryExecuta: TUniQuery;
  AutoIncrem: string;

  procedure ApagaFerias(AutoIncremento: string);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('DELETE FROM FUNFER ');
    qryExecuta.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
    qryExecuta.ParamByName('AUTINC').AsString := AutoIncremento;
    qryExecuta.ExecSQL;
  end;

  procedure InsereFerias(ACodFuncionario,
                         ACodEmpresa: String;
                         AAquisitivoIni,
                         AAquisitivoFin,
                         AGozoIni,
                         AGozoFin,
                         ADataRecebimento,
                         AAutoIncremFuncionario: String;
                         AValorRecebido: Double;
                         out AAutoIncrem: string;
                         ADiasComprados:Integer);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('INSERT INTO FUNFER ( AUTOINCREM');
    qryExecuta.SQL.Add('                    ,FER_CODFUN');
    qryExecuta.SQL.Add('                    ,FER_AQUINI');
    qryExecuta.SQL.Add('                    ,FER_AQUFIN');
    qryExecuta.SQL.Add('                    ,FER_GOZINI');
    qryExecuta.SQL.Add('                    ,FER_GOZFIN');
    qryExecuta.SQL.Add('                    ,FER_DIACOM');
    qryExecuta.SQL.Add('                    ,FER_DTAREC');
    qryExecuta.SQL.Add('                    ,FER_VALREC');
    qryExecuta.SQL.Add('                    ,FER_CODEMP');
    qryExecuta.SQL.Add('                    ,FER_AUTFUN');
    qryExecuta.SQL.Add(' ) VALUES         ( :AUTINC    ');
    qryExecuta.SQL.Add('                   ,:CODFUN    ');
    qryExecuta.SQL.Add('                   ,:AQUINI    ');
    qryExecuta.SQL.Add('                   ,:AQUFIN    ');
    qryExecuta.SQL.Add('                   ,:GOZINI    ');
    qryExecuta.SQL.Add('                   ,:GOZFIN    ');
    qryExecuta.SQL.Add('                   ,:DIACOM    ');
    qryExecuta.SQL.Add('                   ,:DTAREC    ');
    qryExecuta.SQL.Add('                   ,:VALREC    ');
    qryExecuta.SQL.Add('                   ,:CODEMP    ');
    qryExecuta.SQL.Add('                   ,:AUTFUN)   ');

    AAutoIncrem := fRetAutoIncrem('FUNFER', VS_strCodEmp);
    qryExecuta.ParamByName('AUTINC').AsString   := AAutoIncrem;
    qryExecuta.ParamByName('CODFUN').AsString   := ACodFuncionario;
    If Not fEmptyStr(AAquisitivoIni) Then
      qryExecuta.ParamByName('AQUINI').AsDateTime := StrToDate(AAquisitivoIni);
    If Not fEmptyStr(AAquisitivoFin) Then
      qryExecuta.ParamByName('AQUFIN').AsDateTime := StrToDate(AAquisitivoFin);
    If Not fEmptyStr(AGozoIni) Then
      qryExecuta.ParamByName('GOZINI').AsDateTime := StrToDate(AGozoIni);
    If Not fEmptyStr(AGozoFin) Then
      qryExecuta.ParamByName('GOZFIN').AsDateTime := StrToDate(AGozoFin);
    If Not fEmptyStr(ADataRecebimento) Then
      qryExecuta.ParamByName('DTAREC').AsDateTime := StrToDate(ADataRecebimento);
    qryExecuta.ParamByName('VALREC').AsFloat    := AValorRecebido;
    qryExecuta.ParamByName('CODEMP').AsString   := ACodEmpresa;
    qryExecuta.ParamByName('AUTFUN').AsString   := AAutoIncremFuncionario;
    qryExecuta.ParamByName('DIACOM').AsInteger   := ADiasComprados;
    qryExecuta.ExecSQL;
  end;

  procedure AtualizaFerias(ACodFuncionario,
                           AAutoIncremFuncionario,
                           AAutoIncrem: String;
                           AAquisitivoIni,
                           AAquisitivoFin,
                           AGozoIni,
                           AGozoFin,
                           ADataRecebimento: String;
                           AValorRecebido: Double;
                           ADiasComprado:Integer);
  begin
    qryExecuta.SQL.Clear;
    qryExecuta.SQL.Add('UPDATE FUNFER SET ');
    qryExecuta.SQL.Add('              FER_CODFUN = :CODFUN ');
    qryExecuta.SQL.Add('             ,FER_AQUINI = :AQUINI ');
    qryExecuta.SQL.Add('             ,FER_AQUFIN = :AQUFIN ');
    qryExecuta.SQL.Add('             ,FER_GOZINI = :GOZINI ');
    qryExecuta.SQL.Add('             ,FER_GOZFIN = :GOZFIN ');
    qryExecuta.SQL.Add('             ,FER_DIACOM = :DIACOM ');
    qryExecuta.SQL.Add('             ,FER_DTAREC = :DTAREC ');
    qryExecuta.SQL.Add('             ,FER_VALREC = :VALREC ');
    qryExecuta.SQL.Add('             ,FER_AUTFUN = :AUTFUN ');
    qryExecuta.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryExecuta.ParamByName('AUTINC').AsString   := AAutoIncrem;
    qryExecuta.ParamByName('CODFUN').AsString   := ACodFuncionario;
    If Not fEmptyStr(AAquisitivoIni) Then
      qryExecuta.ParamByName('AQUINI').AsDateTime := StrToDate(AAquisitivoIni);
    If Not fEmptyStr(AAquisitivoFin) Then
      qryExecuta.ParamByName('AQUFIN').AsDateTime := StrToDate(AAquisitivoFin);
    If Not fEmptyStr(AGozoIni) Then
      qryExecuta.ParamByName('GOZINI').AsDateTime := StrToDate(AGozoIni);
    If Not fEmptyStr(AGozoFin) Then
      qryExecuta.ParamByName('GOZFIN').AsDateTime := StrToDate(AGozoFin);
    If Not fEmptyStr(ADataRecebimento) Then
      qryExecuta.ParamByName('DTAREC').AsDateTime := StrToDate(ADataRecebimento);
    qryExecuta.ParamByName('VALREC').AsFloat    := AValorRecebido;
    qryExecuta.ParamByName('AUTFUN').AsString   := AAutoIncremFuncionario;
    qryExecuta.ParamByName('DIACOM').AsInteger  := ADiasComprado;
    qryExecuta.ExecSQL;
  end;
begin
  qryFerias  := fCriaQuery();
  qryExecuta := fCriaQuery();

  Try
    cdsFerias.DisableControls;
    qryFerias.SQL.Clear;
    qryFerias.SQL.Text := GetSQLDadosFerias;
    qryFerias.ParamByName('INCFUN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryFerias.Open;

    While (Not qryFerias.Eof) Do
    Begin
      If (Not cdsFerias.Locate('AUTOINCREM', qryFerias.FieldByName('AUTOINCREM').AsString, [])) Then
        ApagaFerias(qryFerias.FieldByName('AUTOINCREM').AsString);

      qryFerias.Next;
    End;

    cdsFerias.First;
    While (Not cdsFerias.Eof) Do
    Begin
      Try
        If (fEmptyStr(cdsFerias.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          InsereFerias(cdsFerias.FieldByName('CODFUN').AsString,
                       cdsFerias.FieldByName('CODEMP').AsString,
                       cdsFerias.FieldByName('AQUINI').AsString,
                       cdsFerias.FieldByName('AQUFIN').AsString,
                       cdsFerias.FieldByName('GOZINI').AsString,
                       cdsFerias.FieldByName('GOZFIN').AsString,
                       cdsFerias.FieldByName('DTAREC').AsString,
                       qryTabela.FieldByName('AUTOINCREM').AsString,
                       cdsFerias.FieldByName('VALREC').AsFloat,
                       AutoIncrem,
                       cdsFerias.FieldByName('DIACOM').AsInteger);

          cdsFerias.Edit;
          cdsFerias.FieldByName('AUTOINCREM').AsString := AutoIncrem;
          cdsFerias.Post;
        End
        Else
        Begin
          If (qryFerias.Locate('AUTOINCREM', cdsFerias.FieldByName('AUTOINCREM').AsString, [])) Then
            AtualizaFerias(cdsFerias.FieldByName('CODFUN').AsString,
                           qryTabela.FieldByName('AUTOINCREM').AsString,
                           cdsFerias.FieldByName('AUTOINCREM').AsString,
                           cdsFerias.FieldByName('AQUINI').AsString,
                           cdsFerias.FieldByName('AQUFIN').AsString,
                           cdsFerias.FieldByName('GOZINI').AsString,
                           cdsFerias.FieldByName('GOZFIN').AsString,
                           cdsFerias.FieldByName('DTAREC').AsString,
                           cdsFerias.FieldByName('VALREC').AsFloat,
                           cdsFerias.FieldByName('DIACOM').AsInteger);
        End;

        cdsFerias.Next;
      Except
        on E: Exception do
          pMensagensErro(E.Message, '[TfrmCadFuncionarios.GravarDadosFerias]');
      End;
    End;

    pnlAcoesFerias.Enabled := False;
  Finally
    cdsFerias.EnableControls;
    FreeAndNil(qryExecuta);
    FreeAndNil(qryFerias);
  End;
end;

procedure TfrmCadFuncionarios.HabilitarBotoesBeneficiario(InclusaoAltera: Boolean);
begin
  btnGravarBeneficiario.Enabled   := (InclusaoAltera);
  btnCancelarBeneficiario.Enabled := (InclusaoAltera);
  btnIncluirBeneficiario.Enabled  := (Not InclusaoAltera);
  btnAlterarBeneficiario.Enabled  := (Not InclusaoAltera);
  btnExcluirBeneficiario.Enabled  := (Not InclusaoAltera);
end;

procedure TfrmCadFuncionarios.HabilitarBotoesFerias(InclusaoAltera: Boolean);
begin
  btnGravarFerias.Enabled   := (InclusaoAltera);
  btnCancelarFerias.Enabled := (InclusaoAltera);
  btnIncluirFerias.Enabled  := (Not InclusaoAltera);
  btnAlterarFerias.Enabled  := (Not InclusaoAltera);
  btnExcluirFerias.Enabled  := (Not InclusaoAltera);
end;

procedure TfrmCadFuncionarios.imgCinzaClick(Sender: TObject);
begin
  inherited;
  If dtsCadFun.State in [dsInsert, dsEdit] Then
  Begin
    pSetaSemaforo(TImage(Sender));
    qryTabela.FieldByName('FUN_NIVGRU').AsString := Copy(TImage(Sender).Name,4,1);
  End;
end;

procedure TfrmCadFuncionarios.imgFoto01DblClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in [dsInsert, dsEdit] Then
  Begin
    Try
      strFoto01 := fCarregaFoto;
      If fEmptyStr(strFoto01) Then
        imgFoto01.Picture := nil
      Else
        imgFoto01.Picture.LoadFromFile(strFoto01);
    Finally
      btnAmpliar1.Enabled := (strFoto01 <> '');
    End;
  End;
end;

procedure TfrmCadFuncionarios.imgFoto02DblClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in [dsInsert, dsEdit] Then
  Begin
    Try
      strFoto02 := fCarregaFoto;
      If fEmptyStr(strFoto02) Then
        imgFoto02.Picture := nil
      Else
        imgFoto02.Picture.LoadFromFile(strFoto02);
    Finally
      btnAmpliar2.Enabled := (strFoto02 <> '');
    End;
  End;
end;

procedure TfrmCadFuncionarios.LimparDadosBeneficiario;
begin
  edtBenefNome.Clear;
  cbxBenefgrauParen.ItemIndex := -1;
  edtRG.Clear;
  mskCpf.Clear;
  mskDtaNasc.Clear;
  edtBenefEntraIR.Text := 'N';//MF: 288302 - 24/05/23
end;

procedure TfrmCadFuncionarios.LimparDadosFerias;
begin
  mskAquIni.Clear;
  mskAquFin.Clear;
  mskGozIni.Clear;
  mskGozFin.Clear;
  mskDtaRec.Clear;
  dbeValRec.Text := '0,00';
  cbQtdDiasCompra.ItemIndex := 0;
end;

procedure TfrmCadFuncionarios.mskAquIniExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(mskAquIni.Text) Then Exit;

  cdsFeriasClone.Filtered:=False;
  cdsFeriasClone.Filter:='ANO='+QuotedStr(Copy(mskAquIni.Text,7,4));
  cdsFeriasClone.Filtered:=True;
  cdsFeriasClone.Last;

end;

procedure TfrmCadFuncionarios.btnIncluirBeneficiarioClick(Sender: TObject);
begin
  inherited;
  LimparDadosBeneficiario;
  cdsBenef.Insert;
  pnlAcoesBeneficiario.Enabled := True;
  pSetFocus(edtBenefNome);
  AInsertDadosBeneficiario := True;
end;

procedure TfrmCadFuncionarios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  strCepAnt := '';
  pgcDados.ActivePageIndex := 0;
  qryTabela.FieldByName('FUN_CARPON').AsString := 'N';
  qryTabela.FieldByName('FUN_REGIST').AsString := 'N';
  edtNomBan.Clear;
  dbeCodEmp.Field.Value := VS_strCodEmp;
  edtNomEmp.Text        := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  dbeSalBas.Field.Value := '0,00';
  dbeObserv.ReadOnly    := False;
  pnlFundo.Enabled   := True;

  LimparDadosBeneficiario;
  cdsBenef.EmptyDataSet;

  LimparDadosFerias;
  cdsFerias.EmptyDataSet;

  pCarregaCidade;
  pSetaSemaforos;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFun, dbeNomFun, False)
  Else
    pHabilitaCodigo(dbeCodFun, dbeCodFun, True);

  TFloatField(qryTabela.FieldByName('FUN_SALBAS')).DisplayFormat := '###,###,##0.00';
  strFoto01 := '';
  strFoto02 := '';
  pCarregaImagem;

  strPlCtaOld := '';

  AEmpresaInicial := VS_strCodEmp;
  pgcDados.ShowHint := False;

  dbeBCalIr.Field.Value := '0,00';
  dbeAlqIns.Field.Value := '0,00';
  dbeAliqIr.Field.Value := '0,00';

  dbeEmExpe.Field.Value   := 'N';
  dbchkExp45d.Field.Value := 'N';
  dbchkExpM45.Field.Value := 'N';
  dbchkExp45d.Enabled     := False;
  dbchkExpM45.Enabled     := False;
end;

procedure TfrmCadFuncionarios.btnIncluirFeriasClick(Sender: TObject);
begin
  inherited;

  LimparDadosFerias;
  cdsFerias.Insert;
  pnlAcoesFerias.Enabled := True;
  pSetFocus(mskAquIni);
  AInsertDadosFerias := True;
end;

procedure TfrmCadFuncionarios.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('FUN_C_E_P_') <> nil Then
      TStringField(FieldByName('FUN_C_E_P_')).EditMask := '99999-999;0;_';

    If FindField('FUN_DTAADM') <> nil Then
      TDateField(FieldByName('FUN_DTAADM')).EditMask := '99/99/9999';

    If FindField('FUN_DTANAS') <> nil Then
      TDateField(FieldByName('FUN_DTANAS')).EditMask := '99/99/9999';

    If FindField('FUN_DTADEM') <> nil Then
      TDateField(FieldByName('FUN_DTADEM')).EditMask := '99/99/9999';

    If FindField('FUN_VALHAB') <> nil Then
      TDateField(FieldByName('FUN_VALHAB')).EditMask := '99/99/9999';

    If FindField('FUN_NUMTEL') <> nil Then
      TStringField(FieldByName('FUN_NUMTEL')).EditMask := fRetMascaraFonePais;

    If FindField('FUN_NUMCEL') <> nil Then
      TStringField(FieldByName('FUN_NUMCEL')).EditMask := fRetMascaraFonePais;

    If FindField('FUN_ALTURA') <> nil Then
      TFloatField(FieldByName('FUN_ALTURA')).DisplayFormat := '0.00';

    If FindField('FUN_PESFUN') <> nil Then
      TFloatField(FieldByName('FUN_PESFUN')).DisplayFormat := '0.00';

    If FindField('FUN_ALQINS') <> nil Then
      TFloatField(FieldByName('FUN_ALQINS')).DisplayFormat := '0.00';

    If FindField('FUN_ALIQIR') <> nil Then
      TFloatField(FieldByName('FUN_ALIQIR')).DisplayFormat := '0.00';

    If FindField('FUN_BCALIR') <> nil Then
      TFloatField(FieldByName('FUN_BCALIR')).DisplayFormat := '###,###,##0.00';

    If FindField('FUNC_RGDEM') <> nil Then
      TDateField(FieldByName('FUNC_RGDEM')).EditMask := '99/99/9999';

    If FindField('FUN_CPFDEM') <> nil Then
      TDateField(FieldByName('FUN_CPFDEM')).EditMask := '99/99/9999';

    If FindField('FUN_CODCBO') <> nil Then
      TDateField(FieldByName('FUN_CODCBO')).EditMask := '!999999999;0;_';

    If FindField('FUN_DTAEXA') <> nil Then
      TDateField(FieldByName('FUN_DTAEXA')).EditMask := '99/99/9999';

    If FindField('FUN_DTIEMP') <> nil Then
      TDateField(FieldByName('FUN_DTIEMP')).EditMask := '99/99/9999';

    If FindField('FUN_RENDIM') <> nil Then
      TFloatField(FieldByName('FUN_RENDIM')).DisplayFormat := '###,###,##0.00';

  End;
end;

procedure TfrmCadFuncionarios.pAmpliarFoto(strFoto: String);
var
  frmImagem: TfrmImagem;
begin
  pCriarFormularios(TfrmImagem, frmImagem);

  If FileExists(strFoto) Then
  Begin
    frmImagem.imgFoto.Visible := True;
    frmImagem.imgFoto.Picture.LoadFromFile(strFoto);
  End
  Else
  Begin
    frmImagem.imgFoto.Visible := False;
  End;

  frmImagem.Caption := 'Foto';
  frmImagem.ShowModal;

  pFreeAndNil(frmImagem);
end;

procedure TfrmCadFuncionarios.pBeforePost(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If fEmptyStr(FieldByName('FUN_CODVEN').AsString) Then
      FieldByName('FUN_CODVEN').Value := Null;
  End;
end;

procedure TfrmCadFuncionarios.pCarregaPortador(strCodPor: String;
  edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

function TfrmCadFuncionarios.PeriodoDeGozoJaIncluindo: Boolean;
begin
  Result := False;

  If AInsertDadosFerias And  (Not fEmptyStr(mskGozIni.Text) And
                              Not fEmptyStr(mskGozFin.Text)) Then
  Begin
    If (cdsFerias.Locate('CODFUN;GOZINI;GOZFIN',
                          VarArrayOf([qryTabela.FieldByName('FUN_CODFUN').AsString,
                                      (mskGozIni.Text),
                                      (mskGozFin.Text)]), [])) Then
    Begin
      Result := True;
    End;

  End;
end;

function TfrmCadFuncionarios.PeriodoDeGozoUmAnoAposAquisicao: Boolean;
begin
  Result := False;
  If (Not fEmptyStr(mskGozIni.Text) And Not fEmptyStr(mskAquFin.Text)) Then
  Begin                                        // 1 ano e 11 meses
    If (StrToDate(mskGozIni.Text) > IncMonth(IncYear(StrToDate(mskAquFin.Text),+2),-1)) Then
    Begin
      Result := True;
    End;
  End;
end;

function TfrmCadFuncionarios.PeriodoGozoMaiorQuePeriodoAquisitivo: Boolean;
  Var
    cdsClone: TUniClientDataSet;
    LPeriodo: Integer;
begin
  Result := False;
  Try
    Try
      If(Not fEmptyStr(mskAquIni.Text) And Not fEmptyStr(mskAquFin.Text)) And
        (Not fEmptyStr(mskGozIni.Text) And Not fEmptyStr(mskGozFin.Text)) Then
      Begin
        cdsClone := TUniClientDataSet.Create(Self);
        pCloneDataSet(cdsClone, cdsFerias);
        LPeriodo := DaysBetween(StrToDate(mskGozIni.Text),StrToDate(mskGozFin.Text)) + 1;

        cdsClone.Filtered := False;
        cdsClone.Filter := 'AQUINI = ' + QuotedStr(mskAquIni.Text) + ' AND ' +
                           'AQUFIN = ' + QuotedStr(mskAquFin.Text);
        cdsClone.Filtered := True;
        cdsClone.First;


        While Not cdsClone.Eof Do
        Begin
          If (Not fEmptyStr(cdsClone.FieldByName('GOZINI').AsString) And
              Not fEmptyStr(cdsClone.FieldByName('GOZFIN').AsString))Then
            LPeriodo := LPeriodo + DaysBetween(cdsClone.FieldByName('GOZINI').AsDateTime, cdsClone.FieldByName('GOZFIN').AsDateTime) + 1;

          cdsClone.Next;
        End;

        If LPeriodo > DaysBetween(StrToDate(mskAquIni.Text),StrToDate(mskAquFin.Text)) + 1 Then
        Begin
          Result := True;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadFuncionarios.pgcDadosEnter(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := True;
end;

procedure TfrmCadFuncionarios.pgcDadosExit(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := False;
end;

procedure TfrmCadFuncionarios.pgcDadosMouseEnter(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := True;
end;

procedure TfrmCadFuncionarios.pgcDadosMouseLeave(Sender: TObject);
begin
  inherited;
  pgcDados.ShowHint := False;
end;

procedure TfrmCadFuncionarios.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FUN_CODFUN');
  stlCampos.Add('FUN_NOMFUN');
  stlCampos.Add('FUN_FUNATU');
  stlCampos.Add('FUN_DTAADM');
  stlCampos.Add('FUN_SALBAS');
  stlCampos.Add('FUN_PISPAS');
  stlCampos.Add('FUN_DTADEM');
  stlCampos.Add('FUN_BANCO_');
  stlCampos.Add('FUN_AGENCI');
  stlCampos.Add('FUN_CONTA_');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FUN_NOMFUN');
  stlCamInd.Add('FUN_CODFUN');
  stlCamInd.Add('FUN_FUNATU');
  stlCamInd.Add('FUN_DTAADM');
  stlCamInd.Add('FUN_SALBAS');
  stlCamInd.Add('FUN_PISPAS');
  stlCamInd.Add('FUN_DTADEM');
  stlCamInd.Add('FUN_BANCO_');
  stlCamInd.Add('FUN_AGENCI');
  stlCamInd.Add('FUN_CONTA_');

  stlDesInd.Add('Nome');
  stlDesInd.Add('Código');
  stlDesInd.Add('Função');
  stlDesInd.Add('Data Admissão');
  stlDesInd.Add('Salário Base');
  stlDesInd.Add('Pis_Pasep');
  stlDesInd.Add('Data Demissão');
  stlDesInd.Add('Banco');
  stlDesInd.Add('Agência');
  stlDesInd.Add('Conta');

  strPlCtaOld := '';
end;

procedure TfrmCadFuncionarios.pLimpaDadosTese;
begin
  edtDesForTes.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtDesEveTes.Clear;
  edtDesPorTes.Clear;
end;

procedure TfrmCadFuncionarios.pPaginaAnterior;
begin
  pgcDados.SelectNextPage(False);
end;

procedure TfrmCadFuncionarios.pSetaSemaforo(objImage: TImage);
begin
  imglSemaforoOff.GetIcon(imgCinza.Tag, imgCinza.Picture.Icon);
  imglSemaforoOff.GetIcon(imgAzul.Tag, imgAzul.Picture.Icon);
  imglSemaforoOff.GetIcon(imgVerde.Tag, imgVerde.Picture.Icon);

  if Assigned(objImage) Then
    imglSemaforoOn.GetIcon(objImage.Tag, objImage.Picture.Icon);

  imgCinza.Repaint;
  imgAzul.Repaint;
  imgVerde.Repaint;
end;

procedure TfrmCadFuncionarios.pSetaSemaforos;
begin
  If qryTabela.FieldByName('FUN_NIVGRU').IsNull Then
    pSetaSemaforo(Nil)
  Else
    Case qryTabela.FieldByName('FUN_NIVGRU').AsString[1] Of
      'A': pSetaSemaforo(imgAzul);
      'C': pSetaSemaforo(imgCinza);
      'V': pSetaSemaforo(imgVerde);
    End;
end;

procedure TfrmCadFuncionarios.tbsFeriasShow(Sender: TObject);
begin
  inherited;
  dbgFeriasDBTableView1.DataController.Groups.FullExpand;
  ProcessaDiasGozoFerias;
end;

function TfrmCadFuncionarios.TemMovimentoComEmpresa: Boolean;
var
  qryBusca: TUniQuery;
begin
  Result := False;
  qryBusca := fCriaQuery;

  qryBusca.Close;
  qryBusca.SQL.Clear;
  qryBusca.SQL.Add('SELECT COUNT(AUTOINCREM) AS QUANTIDADE ');
  qryBusca.SQL.Add('FROM CTRPAG ');
  qryBusca.SQL.Add('WHERE PAG_CODFUN = :CODFUN AND  ');
  qryBusca.SQL.Add('      PAG_CODEMP = :CODEMP ');
  qryBusca.ParamByName('CODFUN').AsString := qryTabela.FieldByName('FUN_CODFUN').AsString;
  qryBusca.ParamByName('CODEMP').AsString := AEmpresaInicial;
  qryBusca.Open;

  if qryBusca.FieldByName('QUANTIDADE').AsInteger > 0 Then
    Result := True;
end;

procedure TfrmCadFuncionarios.FormCreate(Sender: TObject);
begin
  objCadFun := TCadFun.Create(Self);

  inherited;
  intPaginasAtivas := 2;
  strNomeTabela := 'CADFUN';
  strNomeCampo  := 'FUN_CODFUN';
  qryTabela     := objCadFun.qryCadFun;

  dtsCadFun.DataSet := qryTabela;

  qryTabela.AfterScroll := pCarregaDadosAdicionais;

  qryTabela.AfterOpen  := pAfterOpen;
  qryTabela.BeforePost := pBeforePost;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodFun;
  arrCamposChave[1] := dbeCodEmp;

  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  qryCadCta := fCriaQuery(Self);
  FCadFnc   := fCriaQuery(Self);

  blnValidaDataMuitoAntiga := False;
  cdsFerias.CreateDataSet;
  cdsBenef.CreateDataSet;

  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;
end;

procedure TfrmCadFuncionarios.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadPor);
  FreeAndNil(qryCadFor);
  FreeAndNil(qryCadCta);
end;

procedure TfrmCadFuncionarios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) Then
  Begin
    if dbeCodEmp.Focused then
      dbeCodEmp.Text := fChamaCadEmp(Key);

    if dbeCodVen.Focused then
      dbeCodVen.Text := fChamaCadOpe(Key);

    if dbeCodFnc.Focused then
      dbeCodFnc.Text := fChamaCadFun(Key);

    if dbForTes.Focused then
      dbForTes.Text := fChamaCadFor(Key);

    if fraPlanoDeContas.dbeCodCta.Focused then
      fraPlanoDeContas.dbeCodCta.Text := fChamaCadCta(Key);

    if dbEveTes.Focused then
      dbEveTes.Text := fChamaCadEve(Key);

    if dbPorTes.Focused then
      dbPorTes.Text := fChamaCadPor(Key);
  End
  Else If (Shift = [ssAlt]) And (Key = VK_RIGHT) Then
    pProximaPagina
  Else If (Shift = [ssAlt]) And (Key = VK_LEFT) Then
    pPaginaAnterior;
end;

function TfrmCadFuncionarios.AtingiuLimiteDeFeriasNoAno: Boolean;
  Var
    cdsClone: TUniClientDataSet;
    LPeriodo: Integer;
    LGozo: Integer;
    LGozoTotal : Integer;
begin
  Result := False;
  LPeriodo := 0;
  LGozoTotal := 0;
  Try
    Try
      If(Not fEmptyStr(mskAquIni.Text) And Not fEmptyStr(mskAquFin.Text)) Then
      Begin
        cdsClone := TUniClientDataSet.Create(Self);
        cdsClone.CloneCursor(cdsFerias, False, False);;

        If (Not fEmptyStr(mskGozIni.Text) And Not fEmptyStr(mskGozFin.Text)) Then
          LPeriodo := DaysBetween(StrToDate(mskGozIni.Text),StrToDate(mskGozFin.Text)) + 1;

        LGozo := LPeriodo + cbQtdDiasCompra.ItemIndex;

        cdsClone.Filtered := False;
        cdsClone.Filter := 'ANO=' + QuotedStr(FormatDateTime('yyyy', StrToDate(mskAquIni.Text)));
        cdsClone.Filtered := True;
        cdsClone.First;


        While Not cdsClone.Eof Do
        Begin

          If (Not fEmptyStr(cdsClone.FieldByName('GOZINI').AsString) And
              Not fEmptyStr(cdsClone.FieldByName('GOZFIN').AsString))Then
            LGozoTotal := LGozoTotal + DaysBetween(cdsClone.FieldByName('GOZINI').AsDateTime, cdsClone.FieldByName('GOZFIN').AsDateTime) + 1;

          LGozoTotal := LGozoTotal + cdsClone.FieldByName('DIACOM').AsInteger;

          cdsClone.Next;
        End;

        LGozoTotal := LGozoTotal + LGozo;

        If LGozoTotal > 30 Then
        Begin
          Result := True;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);
  End;
end;

procedure TfrmCadFuncionarios.AtualizaDadosBeneficiariosDeVersoesAnteriores;
  Var
    LSQL: String;
begin
  If qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit;

  Try
    LSQL := 'UPDATE FUNBNF SET BNF_AUTFUN="' + qryTabela.FieldByName('AUTOINCREM').AsString + '"';
    LSQL := LSQL + ' WHERE                               ';
    LSQL := LSQL + '   BNF_CODFUN = "' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
    LSQL := LSQL + '   BNF_CODEMP = "' + qryTabela.FieldByName('FUN_CODEMP').AsString + '" AND ';
    LSQL := LSQL + '   BNF_AUTFUN IS NULL                 ';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadFuncionarios.AtualizaDadosFeriasDeVersoesAnteriores;
  Var
    LSQL: String;
begin
  If qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit;

  Try
    LSQL := 'UPDATE FUNFER SET FER_AUTFUN="' + qryTabela.FieldByName('AUTOINCREM').AsString + '"';
    LSQL := LSQL + ' WHERE                               ';
    LSQL := LSQL + '   FER_CODFUN = "' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
    LSQL := LSQL + '   FER_CODEMP = "' + qryTabela.FieldByName('FUN_CODEMP').AsString + '" AND ';
    LSQL := LSQL + '   FER_AUTFUN IS NULL                 ';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

function TfrmCadFuncionarios.AtualizaFuncaoFuncionario: Boolean;
begin
  Result := qryTabela.State <> dsBrowse;

  If Result Then
    Result := qryTabela.FieldByName('FUN_AUTFNC').AsString.IsEmpty;

  If Not Result Then
    Result := fCampoTabela('AUTOINCREM',
                           'CADFNC',
                           ['FNC_CODFNC'],
                           [dbeCodFnc.Text]) <> qryTabela.FieldByName('FUN_AUTFNC').AsString;
end;

procedure TfrmCadFuncionarios.AtualizandoDadosFuncionarioDeVersoesAnteriores;
  Var
    LSQL: String;
begin
  Try
    LSQL := 'UPDATE CTRPAG SET PAG_AUTFUN="' + qryTabela.FieldByName('AUTOINCREM').AsString + '"';
    LSQL := LSQL + ' WHERE                 ';
    LSQL := LSQL + '   PAG_CODFUN = "' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
    LSQL := LSQL + '   PAG_CODEMP = "' + AEmpresaInicial + '" AND ';
    LSQL := LSQL + '   PAG_AUTFUN IS NULL  ';

    fExecutaSQL(LSQL);

    LSQL := 'UPDATE EVEDET SET DET_AUTFUN="' + qryTabela.FieldByName('AUTOINCREM').AsString + '", ';
    LSQL := LSQL + 'DET_CODEMP="' + qryTabela.FieldByName('FUN_CODEMP').AsString + '" ';
    LSQL := LSQL + ' WHERE                 ';
    LSQL := LSQL + '   DET_CODFUN = "' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
    LSQL := LSQL + '   DET_CODEMP = "' + AEmpresaInicial + '" AND ';
    LSQL := LSQL + '   DET_AUTFUN IS NULL  ';

    fExecutaSQL(LSQL);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TfrmCadFuncionarios.pHabilitaBotoes;
begin
  pHabilitaDesabiltabtnAbrirPastaAnexos;
end;

procedure TfrmCadFuncionarios.pHabilitaDesabiltabtnAbrirPastaAnexos;
begin
  If (qryTabela.Active)      And
     Not (qryTabela.IsEmpty) Then
    btnAbrirPastaAnexos.Enabled := Not (qryTabela.State = dsInsert);
end;

procedure TfrmCadFuncionarios.btnAbrirPastaAnexosClick(Sender: TObject);
var
  strCaminhoPastaAntiga: String;
begin
  inherited;
  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);

    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CADFUN\' + qryTabela.FieldByName('AUTOINCREM').AsString ;

    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CADFUN\' +
                                                            fStrZero( qryTabela.FieldByName('FUN_CODFUN').AsString, 12  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('FUN_CODEMP').AsString, 3  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('AUTOINCREM').AsString, 20 ) ;
    if DirectoryExists( strCaminhoPastaAntiga ) then
    begin
       TDirectory.Move( strCaminhoPastaAntiga, frmGravaArquivoPasta.strCaminhoPasta );
       Sleep(500);
    end;

    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos Anexos )';
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);
end;

procedure TfrmCadFuncionarios.btnAlterarBeneficiarioClick(Sender: TObject);
begin
  inherited;
  If (Not cdsBenef.IsEmpty) Then
  Begin
    edtBenefNome.Text           := cdsBenef.FieldByName('NOMBEN').AsString;
    cbxBenefgrauParen.ItemIndex := cbxBenefgrauParen.Items.IndexOf(cdsBenef.FieldByName('GRAPAR').AsString);
    edtRG.Text                  := cdsBenef.FieldByName('NUMRG').AsString;
    mskCpf.Text                 := cdsBenef.FieldByName('NUMCPF').AsString;
    mskDtaNasc.Text             := FormatDateTime('dd/mm/yyyy', cdsBenef.FieldByName('DTANAS').AsDateTime);
    edtBenefEntraIR.Text        := cdsBenef.FieldByName('DEPEIR').AsString; //MF: 288302 - 24/05/23

    cdsBenef.Edit;
    pnlAcoesBeneficiario.Enabled := True;
    pSetFocus(edtBenefNome);
    AInsertDadosBeneficiario     := False;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para alteração!', ['&OK']);
end;

procedure TfrmCadFuncionarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in [dsEdit] Then
  Begin
    pgcDados.ActivePageIndex := 0;
    If blnAlterou And Not fVerificaAcessoSistema('HISFUN', strLoginUsuarioLogado) Then
    Begin
      strObsAnt := qryTabela.FieldByName('FUN_OBSERV').AsString;
      qryTabela.FieldByName('FUN_OBSERV').AsString := '';
    End;
    dbeCodFun.Enabled  := False;
    pnlFundo.Enabled   := True;
    dbeObserv.ReadOnly := False;

    If (qryTabela.FieldByName('FUN_EMEXPE').AsString <> 'S') Then
    Begin
      dbchkExp45d.Enabled := False;
      dbchkExpM45.Enabled := False;
    End;

    pHabilitaBotoes;

    LimparDadosBeneficiario;
    pnlAcoesBeneficiario.Enabled := True;

    LimparDadosFerias;
    pnlAcoesFerias.Enabled := True;

    pSetaSemaforos;

    strCepAnt    := qryTabela.FieldByName('FUN_C_E_P_').AsString;

    If dbeNomFun.Enabled Then
      pSetFocus(dbeNomFun);

    AEmpresaInicial := qryTabela.FieldByName('FUN_CODEMP').AsString;

    strPlCtaOld := qryTabela.FieldByName('FUN_CODCTA').AsString;
  End;
end;

procedure TfrmCadFuncionarios.btnAlterarFeriasClick(Sender: TObject);
begin
  inherited;
  If (Not cdsFerias.IsEmpty) Then
  Begin
    mskAquIni.Text :=  cdsFerias.FieldByName('AQUINI').AsString;
    mskAquFin.Text :=  cdsFerias.FieldByName('AQUFIN').AsString;
    mskGozIni.Text :=  cdsFerias.FieldByName('GOZINI').AsString;
    mskGozFin.Text :=  cdsFerias.FieldByName('GOZFIN').AsString;
    mskDtaRec.Text :=  cdsFerias.FieldByName('DTAREC').AsString;
    cbQtdDiasCompra.ItemIndex :=  cdsFerias.FieldByName('DIACOM').AsInteger;

    dbeValRec.Text := FloatToStrF(cdsFerias.FieldByName('VALREC').AsFloat, ffFixed, 12, 2);

    cdsFerias.Edit;
    pnlAcoesFerias.Enabled := True;
    pSetFocus(mskAquIni);
    AInsertDadosFerias := False;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para alteração!', ['&OK']);
end;

procedure TfrmCadFuncionarios.btnAmpliar1Click(Sender: TObject);
begin
  inherited;
  pAmpliarFoto(strFoto01);
end;

procedure TfrmCadFuncionarios.btnAmpliar2Click(Sender: TObject);
begin
  inherited;
  pAmpliarFoto(strFoto02);
end;

procedure TfrmCadFuncionarios.btnCadForClick(Sender: TObject);
 Var
    strCodFor: String;

    function fExisteCpfFornecedor(Var strCodFor: String; strCodigo, strEstado: String): Boolean;
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
          strSQL := strSQL + '   FOR_CODFOR           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADFOR               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   FOR_C_G_C_ = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodFor := FieldByName('FOR_CODFOR').AsString;
              fMensagem('ATENÇÃO','Já existe o CNPJ / CPF cadastrado para o Código: ' + #13 +
                                  strCodFor + ' no Cadastro de Fornecedores!',['&OK']);
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

  strCodFor := '';

  If Not (btnCadFor.Visible And btnCadFor.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodFun.Text)) And (dbeCodFun.Enabled) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeNomFun.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCPF.Text)) Or (dbeCPF.Text = '0') Then
  Begin
    fMensagem('ATENÇÃO!', 'O CPF deve ser preenchido!', ['&Ok']);
    Exit;
  End
  Else If Not fValidaCnpjCpf('2', dbeCPF.Text, False, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'CPF inválido!', ['&Ok']);
    Exit;
  End;

  If (Not fExisteCpfFornecedor(strCodFor, dbeCPF.Text, edtEstado.Text)) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) Then
      Exit;

  If fCadastroRapidoFornecedor(strCodFor, qryTabela) Then
    fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                          'Cadastro de Fornecedores criado com o Código: ' + strCodFor, ['&Ok']);
  End
  Else
  Begin
    If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Fornecedores?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If fCadastroRapidoFornecedor(strCodFor, qryTabela) Then
      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
  End;

end;

procedure TfrmCadFuncionarios.btnCadOpeClick(Sender: TObject);
Var
    strCodOpe: String;
    blnAchou : Boolean;

  function fExisteCpfOperador(Var strCodFor: String; strCodigo, strEstado: String): Boolean;
      Var
        strSQL   : String;
        qryGenTmp: TUniQuery;
    Begin
      qryGenTmp := Nil;
      Try
        Result := False;
        If (strEstado = 'EX') Then
          Exit;
        qryGenTmp := fCriaQuery;
        If Not fEmptyStr(strCodigo) Then
        Begin

          strSQL := '';
          strSQL := strSQL + ' SELECT                 ';
          strSQL := strSQL + '   OPE_CODOPE           ';
          strSQL := strSQL + ' FROM                   ';
          strSQL := strSQL + '   CADOPE               ';
          strSQL := strSQL + ' WHERE                  ';
          strSQL := strSQL + '   OPE_NUMCPF = :CODIGO ';

          With qryGenTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODIGO').AsString := strCodigo;
            Open;

            If Not IsEmpty Then
            Begin
              strCodFor := FieldByName('OPE_CODOPE').AsString;
              fMensagem('ATENÇÃO','Já existe o CPF cadastrado para o Código: ' + #13 +
                                  strCodOpe + ' no Cadastro de Operadores!',['&OK']);
              Result := True;
            End;
            Close;
          End;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;

    function fExisteFuncionarioOperador(Var strCodOpe: String; strCodFun: String): Boolean;
    Var
      strSQL   : String;
      qryGenTmp: TUniQuery;
    Begin
      qryGenTmp := Nil;
      Try
        Result := False;
        If fEmptyStr(strCodFun) Then
          Exit;

        qryGenTmp := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + ' SELECT                 ';
        strSQL := strSQL + '   OPE_CODOPE           ';
        strSQL := strSQL + ' FROM                   ';
        strSQL := strSQL + '   CADOPE               ';
        strSQL := strSQL + ' WHERE                  ';
        strSQL := strSQL + '   OPE_CODFUN = :CODIGO ';

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODIGO').AsString := strCodFun;
          Open;

          If Not IsEmpty Then
          Begin
            strCodOpe := FieldByName('OPE_CODOPE').AsString;
            Result := True;
          End;
          Close;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    End;

begin
  inherited;
    strCodOpe := '';

  If Not (btnCadOpe.Visible And btnCadOpe.Enabled) Then
    Exit;

  If (qryTabela.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário escolher um registro!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCodFun.Text)) And (dbeCodFun.Enabled) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(dbeNomFun.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Nome deve ser preenchido!', ['&Ok']);
    Exit;
  End;

  If (fEmptyStr(dbeCPF.Text)) Or (dbeCPF.Text = '0') Then
  Begin
    fMensagem('ATENÇÃO!', 'O CPF deve ser preenchido!', ['&Ok']);
    Exit;
  End
  Else If Not fValidaCnpjCpf('2', dbeCPF.Text, False, True) Then
  Begin
    fMensagem('ATENÇÃO!', 'CPF inválido!', ['&Ok']);
    Exit;
  End;

  blnAchou := False;
  If fCfgSis('VINCOF', varBoolean) Then
    blnAchou := fExisteFuncionarioOperador(strCodOpe, dbeCodFun.Text);

  If Not blnAchou Then
    blnAchou := fExisteCpfOperador(strCodOpe, dbeCPF.Text, edtEstado.Text);

  If (Not blnAchou) Then
  Begin
    If (fMensagem('AVISO', 'Confirma a Geração do Cadastro de Operador?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If fCadastroRapidoOperador(strCodOpe, qryTabela) Then
      fMensagem('ATENÇÃO!', 'Geração concluída com sucesso!' + #13 +
                          'Cadastro de Operador criado com o Código: ' + strCodOpe, ['&Ok']);
  End
  Else
  Begin
    If (fMensagem('AVISO', 'Confirma a Atualização do Cadastro de Operador?', ['&Sim', '&Não']) = 2) Then
      Exit;

    If fCadastroRapidoOperador(strCodOpe, qryTabela) Then
      fMensagem('ATENÇÃO!', 'Atualização concluída com sucesso!', ['&Ok']);
  End;


end;

procedure TfrmCadFuncionarios.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlFundo.Enabled   := False;
  pLimpaDadosTese;
  pCarregaCidade;  
  pSetaSemaforos;
  CarregarDadosBeneficiario;
  pCarregaImagem;
  CarregarDadosFerias;
  pgcDados.ActivePageIndex := 0;
  pCarregaDadosAdicionais(Nil);
  pCarregaDadosTese;

  AEmpresaInicial := qryTabela.FieldByName('FUN_CODEMP').AsString;
end;

procedure TfrmCadFuncionarios.btnCancelarBeneficiarioClick(Sender: TObject);
begin
  inherited;
  cdsBenef.Cancel;
  LimparDadosBeneficiario;
  AInsertDadosBeneficiario := False;
end;

procedure TfrmCadFuncionarios.btnCancelarFeriasClick(Sender: TObject);
begin
  inherited;
  cdsFerias.Cancel;
  LimparDadosFerias;
  AInsertDadosFerias := False;
  ProcessaDiasGozoFerias;
end;

procedure TfrmCadFuncionarios.dbchkExp45dClick(Sender: TObject);
begin
  fValidaCampos(dbchkExp45d, False);
end;

procedure TfrmCadFuncionarios.dbchkExpM45Click(Sender: TObject);
begin
  fValidaCampos(dbchkExpM45, False);
end;

procedure TfrmCadFuncionarios.dbeBanco_KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, dbeBanco_, edtNomBan, Nil, Key, arrBancos) Then
  Begin
    if fValidaCampos(dbeBanco_, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.FormShow(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  // Muda pra true apenas quando onter para resolver bug de mostrando hint em todos componentes
  pgcDados.ShowHint := False;
  edtNomBan.Enabled := False;
  pnlFundo.Enabled  := True;
  dbeObserv.Enabled := True;
  CarregarDadosBeneficiario;
  pCarregaImagem;
  CarregarDadosFerias;
  ProcessaDiasGozoFerias;
  pSetaSemaforos;


  btnCadFor.Visible := fVerificaAcessoSistema('frmCadFornecedores', strLoginUsuarioLogado);

  btnCadOpe.Visible := fVerificaAcessoSistema('frmCadOperadores', strLoginUsuarioLogado);

  If Not fVerificaAcessoSistema('HISFUN', strLoginUsuarioLogado) Then
    dbeObserv.ReadOnly := True
  Else
    dbeObserv.ReadOnly := IIF(btnGravar.Enabled, False, True);

  TfrmGravando.fExecutarModal(TCadFun.CriaNovosRegistrosDeFuncoes, 'Aguarde... Atualizando registros de versões  anteriores.', '');
  If TCadFun.ExistemFuncoesCadastradasNaFormaAntiga Then
    TfrmGravando.fExecutarModal(TCadFun.CorrigeCadastroDeFuncoes, 'Aguarde... Atualizando registros de versões anteriores.', '');
end;

procedure TfrmCadFuncionarios.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrFunc: TConsultasArray;
begin
  {*********************************}
  {* NOVA CONSULTA DE FUNCIONÁRIOS *}
  {******************************RV*}
  chrKey := '/';
  If fPesqFuncionarios(Self, Nil, Nil, qryTabela, chrKey, arrFunc) Then
  Begin
    pLimpaDadosTese;

    If Not qryTabela.IsEmpty Then
    Begin
      pCarregaCidade;
      pCarregaDadosTese;
      CarregarDadosBeneficiario;
      pCarregaImagem;
      CarregarDadosFerias;
      ProcessaDiasGozoFerias;
      pSetaSemaforos;
      AEmpresaInicial := qryTabela.FieldByName('FUN_CODEMP').AsString;
      TFloatField(qryTabela.FieldByName('FUN_SALBAS')).DisplayFormat := '###,###,##0.00';
    End;

    pSetFocus(btnAlterar);
  End;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCadFuncionarios.CarregaFuncao;
  Var
    LAtualizaAutoIncrem: Boolean;
begin
  LAtualizaAutoIncrem := AtualizaFuncaoFuncionario;

  pPesquisaCadFnc(FCadFnc, FCadFnc, dbeCodFnc.Text, IIF(LAtualizaAutoIncrem, '', qryTabela.FieldByName('FUN_AUTFNC').AsString));

  edtNomFnc.Clear;
  If Not FCadFnc.IsEmpty Then
  Begin
    edtNomFnc.Text := FCadFnc.FieldByName('FNC_NOMFNC').AsString;

    If LAtualizaAutoIncrem Then
      qryTabela.FieldByName('FUN_AUTFNC').AsString := FCadFnc.FieldByName('AUTOINCREM').AsString;
  End;
end;

procedure TfrmCadFuncionarios.CarregarDadosBeneficiario;
Var
  qryBeneficiario: TUniQuery;
begin
  AtualizaDadosBeneficiariosDeVersoesAnteriores;

  qryBeneficiario := fCriaQuery();

  Try
    With qryBeneficiario Do
    Begin
      cdsBenef.EmptyDataSet;
      SQL.Clear;
      SQL.Text := GetSQLDadosBeneficiario;
      ParamByName('INCFUN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      While Not Eof Do
      Begin
        cdsBenef.AppendRecord([FieldByName('CODFUN').AsString,
                               FieldByName('NOMBEN').AsString,
                               FieldByName('GRAPAR').AsString,
                               FieldByName('NUMRG').AsString,
                               FieldByName('NUMCPF').AsString,
                               FieldByName('DTANAS').AsDateTime,
                               FieldByName('AUTOINCREM').AsString,
                               FieldByName('CODEMP').AsString, //MF: 288302 - 24/05/23
                               FieldByName('DEPEIR').AsString]);//MF: 288302 - 24/05/23

        Next;
      End;
    End;

    pnlAcoesBeneficiario.Enabled := False;
  Finally
    cdsBenef.First;
    qryBeneficiario.Close;
    FreeAndNil(qryBeneficiario);
  End;
end;

procedure TfrmCadFuncionarios.ProcessaDiasGozoFerias;
var
  saldo:integer;
  anoC,anoP:string;
begin
  inherited;

   cdsFerias.First;
   saldo:=30;
   While not cdsFerias.EOF Do
   Begin
      cdsFerias.Edit;
      anoC  :=Copy(cdsFerias.FieldByName('AQUINI').AsString,7,4);

      If cdsFerias.FieldByName('GOZINI').AsDateTime <> 0 Then
      Begin
        cdsFerias.FieldByName('DIAGOZ').AsInteger := DaysBetween(cdsFerias.FieldByName('GOZINI').AsDateTime,cdsFerias.FieldByName('GOZFIN').AsDateTime+1);
        cdsFerias.FieldByName('SALGOZ').AsInteger := 30 - DaysBetween(cdsFerias.FieldByName('GOZINI').AsDateTime,cdsFerias.FieldByName('GOZFIN').AsDateTime+1);
      End;

      cdsFerias.FieldByName('SALGOZ').AsInteger := cdsFerias.FieldByName('SALGOZ').AsInteger +  cdsFerias.FieldByName('DIACOM').AsInteger;

      saldo:= saldo - (cdsFerias.FieldByName('DIAGOZ').AsInteger + cdsFerias.FieldByName('DIACOM').AsInteger);

      cdsFerias.FieldByName('SALDO').AsInteger:=saldo;
      cdsFerias.FieldByName('ANO').AsString:=Copy(cdsFerias.FieldByName('AQUINI').AsString,7,4);
      cdsFerias.Post;
      cdsFerias.Next;
      If cdsFerias.FieldByName('AQUINI').OldValue <> Null Then
        anoP  :=Copy(cdsFerias.FieldByName('AQUINI').OldValue,7,4);

      if anoP <> anoC Then
      Begin
       saldo:=30;
       anoP:='';
      End;

   End;
   cdsFeriasClone.Filtered:=False;
   cdsFeriasClone.CloneCursor(cdsFerias, False, False);
end;

procedure TfrmCadFuncionarios.CarregarDadosFerias;
Var
  qryFerias: TUniQuery;
begin
  AtualizaDadosFeriasDeVersoesAnteriores;

  qryFerias := fCriaQuery();

  Try
    With qryFerias Do
    Begin
      cdsFerias.EmptyDataSet;
      SQL.Clear;
      SQL.Text := GetSQLDadosFerias;
      ParamByName('INCFUN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      While Not Eof Do
      Begin
        cdsFerias.AppendRecord([FieldByName('CODFUN').AsString,
                                FieldByName('AQUINI').AsString,
                                FieldByName('AQUFIN').AsString,
                                FieldByName('GOZINI').AsString,
                                FieldByName('GOZFIN').AsString,
                                FieldByName('DTAREC').AsString,
                                FieldByName('VALREC').AsFloat,
                                FieldByName('AUTOINCREM').AsString,
                                FieldByName('CODEMP').AsString,
                                FieldByName('DIACOM').AsInteger]);

        Next;
      End;
    End;

    pnlAcoesFerias.Enabled := False;
  Finally
    cdsFerias.First;
    qryFerias.Close;
    FreeAndNil(qryFerias);
  End;
end;

procedure TfrmCadFuncionarios.cbQtdDiasCompraExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(cbQtdDiasCompra);
end;

procedure TfrmCadFuncionarios.btnExcluirBeneficiarioClick(Sender: TObject);
begin
  inherited;
  AInsertDadosBeneficiario := False;
  If (Not cdsBenef.IsEmpty) Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Excluir Beneficiário?', ['&Sim', '&Não'], 2) = 1) Then
      cdsBenef.Delete
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para exclusão!', ['&OK']);
end;

procedure TfrmCadFuncionarios.btnExcluirClick(Sender: TObject);
var
  LMsgValidacao: String;
begin
  If ExisteMovimentacaoAntigaDoFuncionario Then
  Begin
    fMensagem('ATENÇÂO', 'Não é possível excluir o funcionário pois existem movimentações.', ['&OK']);
    Exit;
  End;

  If ExisteCTRPAGParaOFuncionario(LMsgValidacao) Then
  Begin
    fMensagem('ATENÇÃO', LMsgValidacao , ['&OK']);
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFuncionarios.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  If (fEmptyStr(dbeCodFun.Text)) Then
    edtNomBan.Clear;
  pgcDados.ActivePageIndex := 0;
  pLimpaDadosTese;
  pCarregaCidade;
  pSetaSemaforos;
  strFoto01 := '';
  strFoto02 := '';
  pCarregaImagem;

  AEmpresaInicial := qryTabela.FieldByName('FUN_CODEMP').AsString;
end;

procedure TfrmCadFuncionarios.btnExcluirFeriasClick(Sender: TObject);
begin
  inherited;
  AInsertDadosFerias := False;
  If (Not cdsFerias.IsEmpty) Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Excluir Férias?', ['&Sim', '&Não'], 2) = 1) Then
      cdsFerias.Delete
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para exclusão!', ['&OK']);
  ProcessaDiasGozoFerias;
end;

procedure TfrmCadFuncionarios.btnFichaCadClick(Sender: TObject);
begin
   TfrmRelFichaCadFuncionario.pRelFichaCadFuncionario(dbeCodFun.Text, dbeCodEmp.Text);
end;

procedure TfrmCadFuncionarios.dbeCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbeCodFncKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFnc: TConsultasArray;
begin
  inherited;
  if fPesqFuncoes(Self, dbeCodFnc, edtNomFnc, FCadFnc, Key, arrFnc, True, dbeCodEmp.Text) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbeCodLocNasctoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, dbeCodLocNascto, edtLocalNascto, Nil, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCodLocNascto, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbeCodVenKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVen: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodVen, edtNomVen, nil, Key, arrVen) then
  Begin
    If fValidaCampos(TDBEditFocus(Sender), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbEmpTesChange(Sender: TObject);
begin
  inherited;
  dbEmpTes.Text := RightStr(dbEmpTes.Text,3);
end;

procedure TfrmCadFuncionarios.dbEmpTesExit(Sender: TObject);
begin
  inherited;
  dbEmpTes.text := fStrZero(RightStr(dbEmpTes.text,3),3);
end;

procedure TfrmCadFuncionarios.dbeNumCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);
  End;
end;

procedure TfrmCadFuncionarios.dbeObservKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadFuncionarios.dbEveTesKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, dbEveTes, edtDesEveTes, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(dbEveTes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbForTesKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************KP*}
  If fPesqFornecedor(conForCompleta, Self, dbForTes, edtDesForTes, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbForTes, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dbPorTesKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     dbPorTes,
                     edtDesPorTes,
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     dbeCodEmp.Text) then
      If fValidaCampos(dbPorTes) Then
        Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadFuncionarios.dtsBenefStateChange(Sender: TObject);
begin
  inherited;
  HabilitarBotoesBeneficiario(cdsBenef.State in dsEditModes);
  pnlBenef.Enabled := (cdsBenef.State in dsEditModes);
end;

procedure TfrmCadFuncionarios.dtsFeriasStateChange(Sender: TObject);
begin
  inherited;
  HabilitarBotoesFerias(cdsFerias.State in dsEditModes);
  pnlFerias.Enabled := (cdsFerias.State in dsEditModes);
end;

procedure TfrmCadFuncionarios.edtBenefNomeExit(Sender: TObject);
begin
  inherited;
  edtBenefNome.Text := TrimLeft(fTiraCaracEspeciaisPonto(edtBenefNome.Text));
end;

procedure TfrmCadFuncionarios.edtRGExit(Sender: TObject);
begin
  inherited;
  edtRG.Text := StringReplace(edtRG.Text, ' ', '', [rfReplaceAll]);
  edtRG.Text := Trim(edtRG.Text);
end;

procedure TfrmCadFuncionarios.edtRGKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['/', '\', '+', '#', ',', ';','<','>',
  '|','*','ª','º','°','&', '"','(',')','%']) then
    Key := #0;
end;

function TfrmCadFuncionarios.fCadastroRapidoFornecedor(var strCodFor: String;
  cdsDados: TDataSet): Boolean;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADFOR', 'FOR_CODFOR');
  end;

  function fGetAtividade: String;
  var
    arrAtiv: TConsultasArray;
    qryAtiv: TUniQuery;
    key: Char;
  begin
    Key := '/';
    qryAtiv := fCriaQuery;
    Try
      If fPesqAtividade(Self, Nil, Nil, qryAtiv, Key, arrAtiv) Then
        Result := qryAtiv.FieldByName('ATI_CODATI').AsString;
    Finally
      FreeAndNil(qryAtiv);
    End;
  end;

  function fGetCodFor: String;
  var
    qryCod: TUniQuery;
    strCod: String;
  begin
    Try
      qryCod := fCriarQuery('SELECT DISTINCT FOR_CODFOR FROM CADFOR');
      qryCod.Open;

      strCod := IntToStr(Random(99999));

      While qryCod.Locate('FOR_CODFOR', strCod, []) Do
        strCod := IntToStr(Random(99999));

      Result := strCod;
    Finally
      FreeAndNil(qryCod);
    End;
  end;

var
  qryIns: TUniQuery;
  strAti: String;
begin
  Result := False;
  qryIns := nil;
  Try
    If fEmptyStr(strCodFor) Then
      qryIns := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE')
    Else
      qryIns := fCriarQuery('SELECT * FROM CADFOR WHERE FOR_CODFOR = ' + QuotedStr(strCodFor));

    qryIns.Open;

    If fEmptyStr(strCodFor) Then
    Begin
      If fUsaProCodigo('CADFOR') Then
        strCodFor := fProximoCodigo
      Else
        strCodFor := fGetCodFor;

      qryIns.Append;
      qryIns.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADFOR', VS_strCodEmp);

      strAti := fGetAtividade;

      If fEmptyStr(strAti) Then
      Begin
        fMensagem('', 'É necessário selecionar uma atividade para cadastrar um novo fornecedor', ['&Ok']);
        Exit;
      End;
    End
    Else
    Begin
      qryIns.Edit;
    End;

    fStartTransaction;

    qryIns.FieldByName('FOR_CODFOR').AsString   :=  strCodFor;
    qryIns.FieldByName('FOR_NOMFOR').AsString   :=  cdsDados.FieldByName('FUN_NOMFUN').AsString;
    qryIns.FieldByName('FOR_C_E_P_').AsString   :=  cdsDados.FieldByName('FUN_C_E_P_').AsString;
    qryIns.FieldByName('FOR_CODCID').AsString   :=  cdsDados.FieldByName('FUN_CODCID').AsString;
    qryIns.FieldByName('FOR_C_G_C_').AsString   :=  cdsDados.FieldByName('FUN_C_P_F_').AsString;
    qryIns.FieldByName('FOR_ENDERE').AsString   :=  cdsDados.FieldByName('FUN_ENDERE').AsString;
    qryIns.FieldByName('FOR_ENDNUM').AsString   :=  cdsDados.FieldByName('FUN_ENDNUM').AsString;
    qryIns.FieldByName('FOR_ENDCOM').AsString   :=  cdsDados.FieldByName('FUN_COMPLE').AsString;
    qryIns.FieldByName('FOR_BAIRRO').AsString   :=  cdsDados.FieldByName('FUN_BAIRRO').AsString;
    qryIns.FieldByName('FOR_NUMRG_').AsString   :=  cdsDados.FieldByName('FUN_NUM_RG').AsString;
    qryIns.FieldByName('FOR_CODOPE').AsString   :=  strLoginUsuarioLogado;
    qryIns.FieldByName('FOR_CODEMP').AsString   :=  VS_strCodEmp;
    qryIns.FieldByName('FOR_STATUS').AsString   :=  'A';
    qryIns.FieldByName('FOR_CGCCPF').AsInteger  :=  2;


    qryIns.FieldByName('FOR_DTAALT').AsDateTime :=  fNow();

    If qryIns.State = dsInsert Then
    Begin
      qryIns.FieldByName('FOR_DTACAD').AsDateTime :=  fNow();
      qryIns.FieldByName('FOR_CODATI').AsString   :=  strAti;
    End;

    qryIns.Post;
    fCommit;

    Result := True;

  Except On
    E:Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Assigned(qryIns) Then FreeAndNil(qryIns);
end;

function TfrmCadFuncionarios.fCadastroRapidoOperador(var strCodOpe: String;
  cdsDados: TDataSet): Boolean;

  function fProximoCodigo: String;
  begin
    Result := fAtualizaProCod('CADOPE', 'OPE_CODOPE');
  end;

  function fGetCodOpe: String;
  var
    qryCod: TUniQuery;
    strCod: String;
  begin
    Try
      qryCod := fCriarQuery('SELECT DISTINCT OPE_CODOPE FROM CADOPE');
      qryCod.Open;

      strCod := RetornaCodigoAleatorio(3);

      While qryCod.Locate('OPE_CODOPE', strCod, []) Do
      Begin
        strCod := RetornaCodigoAleatorio(3);
      End;

      Result := strCod;
    Finally
      FreeAndNil(qryCod);
    End;
  end;

var
  qryIns: TUniQuery;
begin
  qryIns := nil;
  Try
    If fEmptyStr(strCodOpe) Then
      qryIns := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE')
    Else
      qryIns := fCriarQuery('SELECT * FROM CADOPE WHERE OPE_CODOPE = ' + QuotedStr(strCodOpe));

    qryIns.Open;

    If fEmptyStr(strCodOpe) Then
    Begin
      If fUsaProCodigo('CADOPE') Then
        strCodOpe := fProximoCodigo
      Else
        strCodOpe := fGetCodOpe;

      qryIns.Append;
      qryIns.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADOPE', VS_strCodEmp);

    End
    Else
    Begin
      qryIns.Edit;
    End;

    fStartTransaction;


    qryIns.FieldByName('OPE_CODOPE').AsString   :=  strCodOpe;
    qryIns.FieldByName('OPE_NOMOPE').AsString   :=  cdsDados.FieldByName('FUN_NOMFUN').AsString;

    If fCfgSis('VINCOF', varBoolean) Then
     qryIns.FieldByName('OPE_CODFUN').AsString := cdsDados.FieldByName('FUN_CODFUN').AsString;

    qryIns.FieldByName('OPE_C_E_P_').AsString   :=  cdsDados.FieldByName('FUN_C_E_P_').AsString;
    qryIns.FieldByName('OPE_CODCID').AsString   :=  cdsDados.FieldByName('FUN_CODCID').AsString;
    qryIns.FieldByName('OPE_NUMCPF').AsString   :=  cdsDados.FieldByName('FUN_C_P_F_').AsString;
    qryIns.FieldByName('OPE_ENDERE').AsString   :=  cdsDados.FieldByName('FUN_ENDERE').AsString;
    qryIns.FieldByName('OPE_BAIRRO').AsString   :=  cdsDados.FieldByName('FUN_BAIRRO').AsString;
    qryIns.FieldByName('OPE_NUM_RG').AsString   :=  cdsDados.FieldByName('FUN_NUM_RG').AsString;
    qryIns.FieldByName('OPE_FONE01').AsString   :=  cdsDados.FieldByName('FUN_NUMTEL').AsString;
    qryIns.FieldByName('OPE_DTANAS').AsString   :=  cdsDados.FieldByName('FUN_DTANAS').AsString;
    qryIns.FieldByName('OPE_E_MAIL').AsString   :=  cdsDados.FieldByName('FUN_EMAIL_').AsString;
    qryIns.FieldByName('OPE_CODEMP').AsString   :=  VS_strCodEmp;
    qryIns.FieldByName('OPE_STATUS').AsString   :=  'A';
    qryIns.FieldByName('OPE_ULTALT').AsDateTime :=  fNow();

    qryIns.Post;
    fCommit;

    Result := True;

  Except On
    E:Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
  If Assigned(qryIns) Then FreeAndNil(qryIns);
end;

function TfrmCadFuncionarios.fCarregaFoto: String;
begin
  Result := '';
  If dlgOpenPic.Execute Then
  Begin
    Result := dlgOpenPic.FileName;
  End;
end;

function TfrmCadFuncionarios.ExisteCTRPAGParaOFuncionario(out AMsgValidacao: String): Boolean;
var
  LConsulta: TUniQuery;
  LMesBase: TDate;
begin
  Result := False;
  AMsgValidacao := '';

  If Not qryTabela.Active Then
    Exit;

  If qryTabela.FieldByName('AUTOINCREM').IsNull Then
    Exit;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Add('SELECT DISTINCT PAG_MESBAS FROM CTRPAG WHERE PAG_AUTFUN = :AUTOINCREM');
    LConsulta.ParamByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    LConsulta.Open;
    LConsulta.First;

    Result := Not LConsulta.Eof;

    If Result Then
    Begin
      AMsgValidacao := 'Não é possível excluir o funcionário, pois existem pagamentos vinculados à ele(a).';

      If LConsulta.RecordCount = 1 Then
      Begin
        LMesBase := LConsulta.FieldByName('PAG_MESBAS').AsDateTime;
        AMsgValidacao := Format(
          'Não é possível excluir o funcionário, pois existe(m) pagamento(s) vinculado(s) à ele(a) no mês base %s.',
          [FormatDateTime('mm/yyyy', LMesBase)]);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TfrmCadFuncionarios.ExisteFuncionarioComOCodigoNaMesmaEmpresa: Boolean;
  Var
    LRegistros: TUniQuery;

    LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + 'SELECT FUN_CODFUN FROM CADFUN WHERE ';
  LSQL := LSQL + ' FUN_CODFUN="' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
  LSQL := LSQL + ' FUN_CODEMP="' + qryTabela.FieldByName('FUN_CODEMP').AsString + '" ';

  If Not qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    LSQL := LSQL + ' AND AUTOINCREM <>"' + qryTabela.FieldByName('AUTOINCREM').AsString + '" ';

  Try
    LRegistros := fCriarQuery(LSQL);
    LRegistros.Open;

    Result := Not LRegistros.IsEmpty;
  Finally
    FreeAndNil(LRegistros);
  End;
end;

function TfrmCadFuncionarios.ExisteMovimentacaoAntigaDoFuncionario: Boolean;
  Var
    LRegistros: TUniQuery;

    LSQL: String;
begin
  LSQL := '';
  LSQL := LSQL + 'SELECT PAG_CODFUN, FUN_CODFUN, IFNULL(FUN_CODEMP, "") AS FUN_CODEMP FROM CTRPAG ';
  LSQL := LSQL + ' LEFT JOIN CADFUN ON ';
  LSQL := LSQL + ' FUN_CODFUN=PAG_CODFUN AND ';
  LSQL := LSQL + ' FUN_CODEMP=PAG_CODEMP ';
  LSQL := LSQL + ' WHERE PAG_CODFUN="' + qryTabela.FieldByName('FUN_CODFUN').AsString + '" AND ';
  LSQL := LSQL + '       PAG_AUTFUN IS NULL ';

  Try
    LRegistros := fCriarQuery(LSQL);
    LRegistros.Open;

    Result := LRegistros.Locate('FUN_CODFUN;FUN_CODEMP',
                                VarArrayOf([qryTabela.FieldByName('FUN_CODFUN').AsString,
                                            qryTabela.FieldByName('FUN_CODEMP').AsString]),
                                []);

    If Not Result Then
      Result := LRegistros.Locate('PAG_CODFUN;FUN_CODEMP',
                                  VarArrayOf([qryTabela.FieldByName('FUN_CODFUN').AsString,
                                              '']),
                                  []);

  Finally
    FreeAndNil(LRegistros);
  End;
end;

procedure TfrmCadFuncionarios.btnGravarBeneficiarioClick(Sender: TObject);
Var
  AValido: Boolean;
begin
  //inherited;
  AValido := fValidaCampos(edtBenefNome) And fValidaCampos(mskDtaNasc)
              And fValidaCampos(edtBenefEntraIR);//MF: 288302 - 24/05/23

  If Not AValido Then
    Exit;

  If (AInsertDadosBeneficiario) And
     (cdsBenef.Locate('CODFUN;NOMBEN',
                      VarArrayOf([qryTabela.FieldByName('FUN_CODFUN').AsString,
                                  edtBenefNome.Text]), [])) Then
  Begin
    cdsBenef.First;
    fMensagem('ATENÇÃO!', 'Os dados do beneficiário informados já estão cadastrados!', ['&Ok']);
    cdsBenef.Insert;
    pSetFocus(edtBenefNome);
    Exit;
  End;

  If (AInsertDadosBeneficiario) Then
    cdsBenef.Insert
  Else
    cdsBenef.Edit;

  cdsBenef.FieldByName('CODFUN').AsString   := qryTabela.FieldByName('FUN_CODFUN').AsString;
  cdsBenef.FieldByName('NOMBEN').AsString   := edtBenefNome.Text;
  cdsBenef.FieldByName('GRAPAR').AsString   := cbxBenefgrauParen.Text;
  cdsBenef.FieldByName('NUMRG').AsString    := edtRG.Text;
  cdsBenef.FieldByName('NUMCPF').AsString   := mskCpf.Text;
  cdsBenef.FieldByName('DTANAS').AsDateTime := StrToDateTime(mskDtaNasc.Text);
  cdsBenef.FieldByName('CODEMP').AsString   := qryTabela.FieldByName('FUN_CODEMP').AsString;
  cdsBenef.FieldByName('DEPEIR').AsString   := edtBenefEntraIR.Text; //MF: 288302 - 24/05/23

  cdsBenef.Post;
  LimparDadosBeneficiario;
  pSetFocus(btnIncluirBeneficiario);
end;

procedure TfrmCadFuncionarios.btnGravarClick(Sender: TObject);
  Var
    strObsAtu: String;

    LAtualizar: Boolean;
    LInserindo: Boolean;
begin
  LAtualizar := False;

  AGravar := True;
  LInserindo := qryTabela.State = dsInsert;

  If Not fVerificaAcessoSistema('HISFUN', strLoginUsuarioLogado) Then
  Begin
    strObsAtu := dbeObserv.Text + #10 + #13;
    qryTabela.FieldByName('FUN_OBSERV').AsString := strObsAnt + strObsAtu;
  End;

  qryTabela.FieldByName('FUN_FOTO01').AsString := strFoto01;
  qryTabela.FieldByName('FUN_FOTO02').AsString := strFoto02;

  If ExisteFuncionarioComOCodigoNaMesmaEmpresa Then
  Begin
    fMensagem('ATENÇÃO!','O funcionário não pode ter cadastrado nessa empresa, pois já ' +
                         ' existe outro cadastrado com o mesmo código.',['&Ok']);
    Exit;
  End;

  if AEmpresaInicial <> dbeCodEmp.Text then
  begin
    if TemMovimentoComEmpresa then
    Begin
      AGravar := fMensagem('ATENÇÃO!','O funcionário possui movimento na empresa ' + AEmpresaInicial + '.' + #13 +
                                      'Confirma alteração da empresa do funcionário?',['&Sim', 'Não'], 2) = 1;

      LAtualizar := AGravar;
    End;
  end;

  if AGravar then
  begin
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    If LAtualizar Then
      TfrmGravando.fExecutarModal(AtualizandoDadosFuncionarioDeVersoesAnteriores, 'Aguarde... Atualizando registros do funcionário.', '');

    inherited;

    If blnGravou Then
    Begin

      If LInserindo Then
      Begin
        If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Or
           fEmptyStr(qryTabela.FieldByName('FUN_CODFUN').AsString) Or
         (qryTabela.FieldByName('FUN_CODFUN').AsString = '000000') Then
        Begin
          fRollBack;
          Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
        End;
      End;

      GravarDadosBeneficiario;
      GravarDadosFerias;

      If blnGravou Then
        fCommit;

      AEmpresaInicial := qryTabela.FieldByName('FUN_CODEMP').AsString;
    End
    Else
      fRollBack;
  end;

  pHabilitaBotoes;
  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCadFuncionarios.btnGravarFeriasClick(Sender: TObject);
Var
  AValido: Boolean;
begin
  inherited;
  AValido := fValidaCampos(edtBenefNome) And fValidaCampos(mskDtaNasc) And
             fValidaCampos(mskAquIni) And fValidaCampos(mskAquFin) And
             fValidaCampos(mskGozIni) And fValidaCampos(mskGozIni) And
             fValidaCampos(mskDtaRec)And fValidaCampos(cbQtdDiasCompra);

  If Not AValido Then
    Exit;

  If PeriodoDeGozoJaIncluindo Then
  Begin
    cdsFerias.First;
    fMensagem('ATENÇÃO!', 'Os dados das férias informados já estão cadastrados!', ['&Ok']);
    cdsFerias.Insert;
    pSetFocus(mskAquIni);
    Exit;
  End
  Else If PeriodoGozoMaiorQuePeriodoAquisitivo Then
  Begin
    cdsFerias.First;
    fMensagem('ATENÇÃO!','O período de gozo não pode ser maior que o período aquisitivo!',['&O k']);
    cdsFerias.Insert;
    pSetFocus(mskGozIni);
    Exit;
  End;

  If (AInsertDadosFerias) Then
    cdsFerias.Insert
  Else
    cdsFerias.Edit;

  cdsFerias.FieldByName('CODFUN').AsString   := qryTabela.FieldByName('FUN_CODFUN').AsString;
  If Not fEmptyStr(mskAquIni.Text) Then
    cdsFerias.FieldByName('AQUINI').AsDateTime := mskAquIni.Date;
  If Not fEmptyStr(mskAquFin.Text) Then
    cdsFerias.FieldByName('AQUFIN').AsDateTime := mskAquFin.Date;
  If Not fEmptyStr(mskGozIni.Text) Then
    cdsFerias.FieldByName('GOZINI').AsDateTime := mskGozIni.Date;
  If Not fEmptyStr(mskGozFin.Text) Then
    cdsFerias.FieldByName('GOZFIN').AsDateTime := mskGozFin.Date;
  If Not fEmptyStr(mskDtaRec.Text) Then
    cdsFerias.FieldByName('DTAREC').AsDateTime := mskDtaRec.Date;
  cdsFerias.FieldByName('VALREC').AsFloat    := fStrToFloat(dbeValRec.Text);

  cdsFerias.FieldByName('DIACOM').AsInteger  := cbQtdDiasCompra.ItemIndex;
  cdsFerias.FieldByName('CODEMP').AsString   := qryTabela.FieldByName('FUN_CODEMP').AsString;

  cdsFerias.Post;
  LimparDadosFerias;
  pSetFocus(btnIncluirFerias);
  ProcessaDiasGozoFerias;

end;

procedure TfrmCadFuncionarios.pCarregaCentroCusto(strCodCta: String;
  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCodCta);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmCadFuncionarios.pCarregaCidade;
var
  qryCadCid: TUniQuery;
begin
  Try
    qryCadCid := fCriaQuery(Self);

    pPesquisaCadCid(qryCadCid, qryCadCid, dbeCodCid.Text);

    With qryCadCid Do
    Begin
      edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
      edtEstado.Text := FieldByName('CID_ESTADO').AsString;
      If (dbeNumCep.Field <> Nil) And (dbeNumCep.Field.IsNull) And fEmptyStr(dbeNumCep.Text) Then
      Begin
        dbeNumCep.Text := FieldByName('CID_C_E_P_').AsString;
        strCepAnt   := FieldByName('CID_C_E_P_').AsString;
      End;
    End;
  Finally
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadFuncionarios.pCarregaDadosAdicionais(DataSet: TDataSet);
begin
  edtNomEmp.Text      := fRetNomeEmpresaSelec(dbeCodEmp.Text);
  edtNomBan.Text      := fRetNomBanco(dbeBanco_.Text);
  edtLocalNascto.Text := fRetNomCidade(dbeCodLocNascto.Text);
  edtNomVen.Text      := fRetNomVendRep(dbeCodVen.Text);

  edtNomFnc.Text := fRetNomFnc(qryTabela.FieldByName('FUN_AUTFNC').AsString);

  pHabilitaBotoes;
end;

procedure TfrmCadFuncionarios.pCarregaDadosTese;
begin
  If Not fEmptyStr( dbPorTes.Text ) Then
    pCarregaPortador(dbPorTes.Text, edtDesPorTes);

  If Not fEmptyStr( fraPlanoDeContas.dbeCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.dbeCodCta.Text, fraPlanoDeContas.edtDesCta);

  If Not fEmptyStr( dbEveTes.Text ) Then
    pCarregaEventos;

  If Not fEmptyStr( dbForTes.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, dbForTes.Text);
    edtDesForTes.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;
end;

procedure TfrmCadFuncionarios.pCarregaEventos;
begin
  If Not fEmptyStr(dbEveTes.Text) Then
    edtDesEveTes.Text := fRetNomEvento(dbEveTes.Text)
  Else
    edtDesEveTes.Clear;
end;

procedure TfrmCadFuncionarios.pCarregaImagem;
begin
  {**********************************}
  {* CARREGA A FOTO 1 DO FUNCIONÁRIO*}
  {*******************************RV*}
  Try
    strFoto01 := qryTabela.FieldByName('FUN_FOTO01').AsString;
    If fEmptyStr(strFoto01) Then
      imgFoto01.Picture := nil
    Else If FileExists(strFoto01) Then
      imgFoto01.Picture.LoadFromFile(strFoto01)
    Else
      strFoto01 := '';
  Finally
    btnAmpliar1.Enabled := (strFoto01 <> '');
  End;
  {**********************************}
  {* CARREGA A FOTO 2 DO FUNCIONÁRIO*}
  {*******************************RV*}
  Try
    strFoto02 := qryTabela.FieldByName('FUN_FOTO02').AsString;
    If fEmptyStr(strFoto02) Then
      imgFoto02.Picture := nil
    Else If FileExists(strFoto02) Then
      imgFoto02.Picture.LoadFromFile(strFoto02)
    Else
      strFoto02 := '';
  Finally
    btnAmpliar2.Enabled := (strFoto02 <> '');
  End;

end;

end.
