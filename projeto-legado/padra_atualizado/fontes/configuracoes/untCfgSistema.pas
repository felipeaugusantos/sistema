unit untCfgSistema;

interface

uses
  Windows, SysUtils, Classes, Controls, EditFocus, cxProgressBar, UITypes, IOUtils,
  untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  Uni, UniDataSetProvider, UniClientDataSet, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGrid, cxPC, cxDropDownEdit, cxEditRepositoryItems, cxHint, cxDBExtLookupComboBox,
  cxShellEditRepositoryItems, cxGridBandedTableView, DateUtils, untSpoolImpressao,
  cxGridDBBandedTableView, cxExtEditRepositoryItems, cxCheckBox, ExtDlgs, untcxGridDBColumnHelper,
  cxTextEdit, ComCtrls, cxDBEditRepository, untCfgRepositorio, TypesRel,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxScreenTip, dxCustomHint,
  MemDS, DBAccess, Provider, Dialogs, frxClass, frxExportCSVTestabilidade, Datasnap.DBClient, cxRadioGroup,
  cxDataControllerConditionalFormattingRulesManagerDialog, Generics.Collections, untCfgEveNec,
  cxContainer, dxGDIPlusClasses, cxGroupBox, untCfgAdquirentesUsaNsuHost, Printers,
  cxButtons, untTypesSistema,
  PNGImage, JPEG, untPreAlt_Trigger,untCfgRelacionaFornecedorSkyFornecedorAutcom,
  untTLog, untCadClientesAjusteEstoque, untFornecedoresGenericos,
  untCfgSms, untCfgEmailAutSaida, untCadastroCartaoTefConferencia;

type
  TfrmCfgSistema = class(TfrmPai)
    cxDadosDBTableView1: TcxGridDBTableView;
    cxDadosLevel1: TcxGridLevel;
    cxDados: TcxGrid;
    dtsCfgSis: TDataSource;
    cdsCfgSis: TUniClientDataSet;
    cpvCfgSis: TUniDataSetProvider;
    qryCfgSis: TUniQuery;
    cxDadosDBTableView1SIS_CODEMP: TcxGridDBColumn;
    cxDadosDBTableView1SIS_CODCFG: TcxGridDBColumn;
    cxDadosDBTableView1SIS_DESCRI: TcxGridDBColumn;
    cxDadosDBTableView1SIS_VALCFG: TcxGridDBColumn;
    cxDadosDBTableView1SIS_GRUCFG: TcxGridDBColumn;
    cxHintStyleController: TcxHintStyleController;
    opdPatPic: TOpenPictureDialog;
    pgbProgresso: TProgressBar;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    ApplicationEvents1: TApplicationEvents;
    btnGravar: TBitBtnLocked;
    btnVerConf: TBitBtnLocked;
    btnVerProCod: TBitBtnLocked;
    lblInformacao: TLabel;
    pnlInfoCfgSis: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    mmoInfoCfgSis: TMemo;
    opdPatSnd: TOpenPictureDialog;
    opdPatArq: TOpenDialog;
    pnlPesquisar: TPanel;
    pnlFiltroPesquisa: TPanel;
    Image2: TImage;
    edtPesquisar: TEdit;
    tmrPesquisar: TTimer;
    chkPesquisarPorValor: TCheckBox;
    btnLayout: TBitBtnLocked;
    Shape1: TShape;
    pnlLegUsoCit: TPanel;
    shpLegUsoCit: TShape;
    Label1: TLabel;
    btnCfgEmp: TBitBtnLocked;
    procedure btnGravarClick(Sender: TObject);
    procedure cxDadosDBTableView1SIS_VALCFGGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure cxDadosDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnVerConfClick(Sender: TObject);
    procedure btnVerProCodClick(Sender: TObject);
    procedure cdsCfgSisBeforeEdit(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure cdsCfgSisAfterScroll(DataSet: TDataSet);
    procedure cdsCfgSisBeforePost(DataSet: TDataSet);
    procedure cxDadosDBTableView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxDadosDBTableView1SIS_VALCFGGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure cdsCfgSisAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure cdsCfgSisAfterPost(DataSet: TDataSet);
    procedure cxDadosDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure edtPesquisarChange(Sender: TObject);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure cdsCfgSisFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarClick(Sender: TObject);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkPesquisarPorValorClick(Sender: TObject);
    procedure btnLayoutClick(Sender: TObject);
    procedure btnLayoutMouseEnter(Sender: TObject);
    procedure btnLayoutMouseLeave(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCfgEmpClick(Sender: TObject);
    procedure cxDadosDBTableView1Editing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure cxDadosDBTableView1EditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);

  private
    { Private declarations }
    blnExibiuMensagemClaSub : Boolean;
    strConfiguracoesSomenteCitel  : String;
    blnModoDeDesenvolvimento : Boolean;
    dicAlteracoes : TDictionary<String,String>;
    GerenciaCliAju: TGerenciaCliAju;
    arrPalavrasPesquisar: TArray<String>;
    strUsaTipExpLocal: String;

    strValMsgPedNov,
    strValMsgOrcNov: String;

    blnAppEntregaArqIni: Boolean;
    blnWhatsappArqIni: Boolean;

    FSpoolImpressaoCitel: Boolean;

    FStrCfgOcu: String;

    FGridClickPoint: TPoint;

    arrConfigComuns: Array Of Array[0..1] Of String;//Array contendo as config. comuns (0 - código, 1 - valor anterior)

    blnIniciandoConfiguracoes : Boolean;

    function fConfigOculta: String;
    procedure pAttEventos;
    procedure pRemoveMarkup4_5;

    procedure pCarregarDescricaoValorConfiguracoes;
    procedure pPesquisarConfiguracoes;
    procedure pVerificarConfiguracoes;
    procedure pVerificaConfig(blnMostraProgresso    : Boolean = True;
                              blnAtualizarDescricao : Boolean = True;
                              blnVerificarPaths     : Boolean = True;
                              blnDecriptaCfgs : Boolean = False);
    procedure pAtualizaConfiguracoesComuns;

    procedure btnOpen_MensAdicORCPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnOpen_MensAdicPEDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_ImpNfiPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_CupFisPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_ReplicacaoPropertiesButtonClick( Sender: TObject; AButtonIndex: Integer);
    procedure pedtValFCustoPropertiesChange(Sender: TObject);
    procedure pbtnOpen_ImpChqPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_MarcasBoshPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_RomIprPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_DescProdAcabPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_CodFabrProdAcabPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConClientePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnAjuClientePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConPlaNcoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConServicoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure pbtnPatEndPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnPatImgPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnPatImgConsultaPrecoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnPatArqPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnPatSndPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_NFCePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_GavetaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnOpen_SATCFePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);

    function fIniciaTelaConfiguracoes(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pIniciaTelaConfiguracoes;

    procedure pInformacao(strInfo: String; blnExibir: Boolean = True) overload;
    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar) overload;

    procedure pbtnConEmpresaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConEmpresasMultiselecaoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConItemPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbntLAYPADPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConFornecedorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConFornecedorSkyPecasPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConFornecedorMultiPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConMatrizIcmsPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConVerbasClick(Sender: TObject; AButtonIndex: Integer);

    procedure pbtnFornecedoresTigrePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConPortadorPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConPortRcxPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConCtaPropertiesButtonClick(Sender: TObject; 
      AButtonIndex: Integer);
    procedure btnConAjuICMPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pbtnConHisPadPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConAtividadePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConBancoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConTranspPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConOperadorPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConTipClientePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConEventoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConTipTriPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConAtePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConFasePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConTipOcoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConMotVenPerdPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConCondicaoPgtoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConFormaPgtoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConDepartamentoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConAbrPisPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConFinalidadeAjustePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConAbrCofPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConDiversosPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConCidadePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConMarcasPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConUnidadePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConOcorrenciaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLayoutPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLayOrcPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLayPedPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLayFFPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLaySepPedPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnCfgLocFisPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnCfgSUFIPCPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnCfgEveNecPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure btnCfgNsuHosPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pBtnConCadTpaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure pbtnConRotaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnBloFilPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConCartaoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConClassedeLocalPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);


    procedure pbtnConCartaoMultiselecaoPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnCadEstabelecimentosCartoesPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure btnCadastroLinksAPIBancosPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure btnHorExeRoboPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure btnDownLoadDfeTerPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);

    procedure pbtnConChavesPixPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnCRELPCPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnConLayCEQPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnCadFilaWppPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConfigWppPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConfigEmailAutSaidaPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConfigSMSPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnConCatCrmPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnLocalizacaoFisicaPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnPesquisasOpiniOnePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure rdgTipoFechamentoCaixaButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConfigContelePropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pbtnConVeiculosPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pGravarCfgSis;

    procedure pEditarConfiguracaoPorEmpresa;

    function fRetornaFornecedorMulti(const arrSelecao: TConsultasArray): String;

    procedure btnEXCENTPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure btnEXCSAIPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);

    procedure pAdicionarHintCFG_CLCCTR;
    procedure AdicionarHintCFG_F11TFO;
    procedure pAdicionarHintCFG_ZFMDES;
    procedure pAdicionarHintCFG_CLAIMP;
    procedure pAdicionarHintCFG_MUNINC;
    procedure pAdicionarHintCFG_DEIPCT;
    procedure pAdicionarHintCFG_BEACCS;
    procedure pAdicionarHintCFG_SUFIPC;
    procedure pAdicionarHintCFG_RSAPRP;
    procedure pAdicionarHintCFG_CENDNE;
    procedure pAdicionarHintCFG_UEVPRI;

    procedure pAdicionarHintPerguntasImpressao;

    procedure pExibirBtnCfgEmp;

    function fSalvaLogCfg(cdsCfgSis: TUniClientDataSet): Boolean;
    function fValidaConfiguracaoDiasTolerancia: Boolean;

    procedure pbtnFornecedoresGenericosButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure pAdicionarHintCFG_CARREA;
    function fPermitirEditarConfiguracao(const strCodigoConfiguracao : String) : Boolean;
    procedure pSetarInformacaoOperador(const blnPermitiuAlterarCfg : Boolean);
    procedure pAdicionarHintCFG_HPNAUT;
    procedure pAdicionarHintCFG_OSEVSL;
    procedure pAdicionarHintCFG_SOLOLA;
    procedure pAdicionarHintCFG_LSEWMS;
    procedure pAdicionarHintCFG_LIBAJU;
    procedure pAdicionarHintCFG_SPCDEN;
    procedure pAdicionarHintCFG_SONCEE;
    procedure pAdicionarHintCFG_ENDAUT;
    procedure pAdicionarHintCFG_INVCRI;
    procedure pAdicionarHintCFG_SUPSEP;
    procedure pAdicionarHintCFG_PRQSEC;
    procedure pAdicionarHintCFG_UTILLC;
    procedure pAdicionarHintCFG_EMBMAS;
    procedure pAdicionarHintCFG_ENPAFR;
    procedure pAdicionarHintCFG_URMEIE;
    procedure pAdicionarHintCFG_ENDPRO;
    procedure pAdicionarHintCFG_TRAFRE;
    procedure pAdicionarHintCFG_COFTRA;
    procedure pAdicionarHintCFG_DVTBCR;
    procedure pAdicionarHintCFG_OBRLPK;
    procedure pAdicionarHintCFG_USALAL;
    procedure pAdicionarHintCFG_UDEVME;
    procedure pAdicionarHintCFG_COFEND;
    procedure pAdicionarHintCFG_FREIPI;
    procedure pAdicionarHintCFG_FREPES;
    procedure pAdicionarHintCFG_NSNATP;
    function fValidaCOFEND: Boolean;
    procedure pExibeInformacoesClaSub(const Sender: TcxCustomGridTableView; const AItem: TcxCustomGridTableItem);
    procedure pAdicionarHintCFG_MERCRE;
    procedure pAdicionarHintCFG_DFLLUB;
    procedure pAdicionarHintCFG_DIMPF4;
    procedure pAdicionarHintCFG_DVSPCL;
    procedure pAdicionarHintCFG_ICMSEP;
    procedure pAdicionarHintCFG_UASCCR;
    procedure pAdicionarHintCFG_LEVREC;
    procedure pAdicionarHintCFG_ALTVMT;
    procedure pAdicionarHintCFG_DOCPRO;
    procedure pAdicionarHintCFG_GERTRF;
    procedure pAdicionarHintCFG_CTGRTN;
    procedure pAdicionarHintCFG_SEPLCS;
  public
    cfgRepositorio: TfrmCfgRepositorio;
    { Public declarations }
  end;

implementation

uses Variants, Graphics, Forms, FileCtrl, untFuncoes, untFuncoesSimples,
  untMemo, StrUtils, untCfgImpNaoFiscal, Math, untCfgSistemaValidar,
  untCfgCupomFiscal, untCfgReplicacao, untCfgFormulasPrecoCusto, untCfgImpCheques,
  untCfgMarcasBosh, untFatRomaneioImpr, untCadRcxx, untCadDescProdAcab,
  untCadCodFabrProdAcab, untCfgNFCe, untConsultas, cxButtonEdit,
  untGravando, untConstantes, untCfgSATCFe, untCfgLocFis, untConfiguraDadosGiro,
  untSaldoPedidoCompra, untFornecedoresTigre, Contabilidade.Consultas, untFuncoesEtiqItens,
  untHighlightGrid, untModelosLayout,
  untRcxTResumoDeCaixa, Contabilidade.Classes.TControleContabilidade,
  untCadImpressaoPedido, untCadCfopCst, untCfgSistemaEmp,
  Contabilidade.Funcoes, untCfgCadEstabelecimentosOperadorasCartoes,
  untCadFilaAtenderBem, untCfgWpp, untCfgMensAdicPedidoCompra,
  untHorarioDisparaRobo, untForTagController, untCfgGavetaImpNaoFiscal,
  untListaPesquisaOpiniOne, untCfgContele, untCfgPisCofinsSuframa,
  untCfgDownLoadDfeTer, untConfiguracoesLinksAPIBancos;

{$R *.dfm}

procedure TfrmCfgSistema.cxDadosDBTableView1SIS_VALCFGGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  cfgRepositorio.pOnGetDataTextSIS_VALCFG(Sender, ARecordIndex, AText);
end;

procedure TfrmCfgSistema.cxDadosDBTableView1SIS_VALCFGGetProperties(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
  Var
    intIdx: Integer;
begin
  inherited;
  intIdx := cxDadosDBTableView1SIS_CODCFG.Index;
  If (Assigned(ARecord)) And (ARecord.Values[intIdx] <> Null) Then
  begin
    cfgRepositorio.pRetProperties(ARecord.Values[intIdx], AProperties);
    if AProperties is TcxRadioGroupProperties then
      TcxRadioGroupProperties(AProperties).WordWrap := True;
  end;
end;

procedure TfrmCfgSistema.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  arrPalavrasPesquisar := String(edtPesquisar.Text).Split([' ']);
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmCfgSistema.edtPesquisarClick(Sender: TObject);
begin
  inherited;
  edtPesquisar.SelectAll;
end;

procedure TfrmCfgSistema.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  edtPesquisar.SelectAll;
end;

procedure TfrmCfgSistema.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then btnSair.Click;
end;

function TfrmCfgSistema.fConfigOculta: String;
begin
  Result := 'CFG_RCXTCC_CFG_PAFRCX_CFG_CHVCIT_CFG_PIXTLA_CFG_SANWEB_CFG_RCXNEG_CFG_HRAATM_';
  If (fCfgSis('PREGER', varString) <> '2') Then
    Result := Result + 'CFG_TABTER_';
end;

procedure TfrmCfgSistema.pAttEventos;
Begin
  TCfgRepositorioContabilidade.pInicializaParametros(cfgRepositorio) ;
  cfgRepositorio.pPopularItensEDUNIF;
  With cfgRepositorio Do
  Begin
    btnOpen_MensAdicPED.Properties.OnButtonClick     := btnOpen_MensAdicPEDPropertiesButtonClick;
    btnOpen_MensAdicORC.Properties.OnButtonClick     := btnOpen_MensAdicORCPropertiesButtonClick;
    btnOpen_ImpNfi.Properties.OnButtonClick          := pbtnOpen_ImpNfiPropertiesButtonClick;
    btnOpen_CupFis.Properties.OnButtonClick          := pbtnOpen_CupFisPropertiesButtonClick;
    btnOpen_Replicacao.Properties.OnButtonClick      := pbtnOpen_ReplicacaoPropertiesButtonClick;
    btnOpen_ImpChq.Properties.OnButtonClick          := pbtnOpen_ImpChqPropertiesButtonClick;
    btnPatEnd.Properties.OnButtonClick               := pbtnPatEndPropertiesButtonClick;
    btnPatImg.Properties.OnButtonClick               := pbtnPatImgPropertiesButtonClick;
    btnPatImgConsultaPreco.Properties.OnButtonClick  := pbtnPatImgConsultaPrecoPropertiesButtonClick;
    btnPatArq.Properties.OnButtonClick               := pbtnPatArqPropertiesButtonClick;
    btnPatSnd.Properties.OnButtonClick               := pbtnPatSndPropertiesButtonClick;
    btnConFinalidadeAjuste.Properties.OnButtonClick  := btnConFinalidadeAjustePropertiesButtonClick;
    btnOpen_MarcasBosh.Properties.OnButtonClick      := pbtnOpen_MarcasBoshPropertiesButtonClick;
    btnOpen_RomIpr.Properties.OnButtonClick          := pbtnOpen_RomIprPropertiesButtonClick;
    btnOpen_DescProdAcab.Properties.OnButtonClick    := pbtnOpen_DescProdAcabPropertiesButtonClick;
    btnOpen_CodFabrProdAcab.Properties.OnButtonClick := pbtnOpen_CodFabrProdAcabPropertiesButtonClick;
    btnOpen_NFCe.Properties.OnButtonClick            := pbtnOpen_NFCePropertiesButtonClick;
    btnOpen_Gaveta.Properties.OnButtonClick          := pbtnOpen_GavetaPropertiesButtonClick ;
    btnOpen_SATCFe.Properties.OnButtonClick          := pbtnOpen_SATCFePropertiesButtonClick;

    btnConPlaNco.Properties.OnButtonClick            := pbtnConPlaNcoPropertiesButtonClick;
    btnConCliente.Properties.OnButtonClick           := pbtnConClientePropertiesButtonClick;
    btnAjuCliente.Properties.OnButtonClick           := pbtnAjuClientePropertiesButtonClick;
    btnConEmpresa.Properties.OnButtonClick           := pbtnConEmpresaPropertiesButtonClick;
    btnConEmpresasMultiSelecao.Properties.OnButtonClick := pbtnConEmpresasMultiSelecaoPropertiesButtonClick;
    btnConItem.Properties.OnButtonClick              := pbtnConItemPropertiesButtonClick;
    bntLAYPAD.Properties.OnButtonClick               := pbntLAYPADPropertiesButtonClick;
    btnConFornecedor.Properties.OnButtonClick        := pbtnConFornecedorPropertiesButtonClick;
    btnConFornecedorSkyPecas.Properties.OnButtonClick := pbtnConFornecedorSkyPecasPropertiesButtonClick;
    btnConFornecedorMulti.Properties.OnButtonClick   := pbtnConFornecedorMultiPropertiesButtonClick;
    btnConMatrizIcms.Properties.OnButtonClick        := pbtnConMatrizIcmsPropertiesButtonClick;
    btnFornecedoresTigre.Properties.OnButtonClick    := pbtnFornecedoresTigrePropertiesButtonClick;
    btnConPortador.Properties.OnButtonClick          := pbtnConPortadorPropertiesButtonClick;
    btnConPortRcx.Properties.OnButtonClick           := pbtnConPortRcxPropertiesButtonClick;
    btnConCta.Properties.OnButtonClick               := pbtnConCtaPropertiesButtonClick;
    btnConAjuICM .Properties.OnButtonClick           := btnConAjuICMPropertiesButtonClick;
    btnConHisPad.Properties.OnButtonClick            := pbtnConHisPadPropertiesButtonClick;
    btnConAtividade.Properties.OnButtonClick         := pbtnConAtividadePropertiesButtonClick;
    btnConBanco.Properties.OnButtonClick             := pbtnConBancoPropertiesButtonClick;
    btnConTransp.Properties.OnButtonClick            := btnConTranspPropertiesButtonClick;
    btnConOcorrencia.Properties.OnButtonClick        := btnConOcorrenciaPropertiesButtonClick;
    btnConOperador.Properties.OnButtonClick          := btnConOperadorPropertiesButtonClick;
    btnConTipCliente.Properties.OnButtonClick        := btnConTipClientePropertiesButtonClick;
    btnConEvento.Properties.OnButtonClick            := btnConEventoPropertiesButtonClick;
    btnConTipTri.Properties.OnButtonClick            := btnConTipTriPropertiesButtonClick;
    btnConAte.Properties.OnButtonClick               := btnConAtePropertiesButtonClick;
    btnConFase.Properties.OnButtonClick              := btnConFasePropertiesButtonClick;
    btnConTipOco.Properties.OnButtonClick            := btnConTipOcoPropertiesButtonClick;
    btnConMotVenPerd.Properties.OnButtonClick        := btnConMotVenPerdPropertiesButtonClick;
    btnConCondicaoPgto.Properties.OnButtonClick      := btnConCondicaoPgtoPropertiesButtonClick;
    btnConFormaPgto.Properties.OnButtonClick         := btnConFormaPgtoPropertiesButtonClick;
    btnConDepartamento.Properties.OnButtonClick      := btnConDepartamentoPropertiesButtonClick;
    btnConAbrPis.Properties.OnButtonClick            := btnConAbrPisPropertiesButtonClick;
    btnConAbrCof.Properties.OnButtonClick            := btnConAbrCofPropertiesButtonClick;
    btnConDiversos.Properties.OnButtonClick          := btnConDiversosPropertiesButtonClick;
    btnConCidade.Properties.OnButtonClick            := btnConCidadePropertiesButtonClick;
    btnConMarcas.Properties.OnButtonClick            := btnConMarcasPropertiesButtonClick;
    btnConUnidade.Properties.OnButtonClick           := btnConUnidadePropertiesButtonClick;
    btnConLayout.Properties.OnButtonClick            := btnConLayoutPropertiesButtonClick;
    btnConLayOrc.Properties.OnButtonClick            := btnConLayOrcPropertiesButtonClick;
    btnConLayPed.Properties.OnButtonClick            := btnConLayPedPropertiesButtonClick;
    btnConLayFF.Properties.OnButtonClick             := btnConLayFFPropertiesButtonClick;
    btnConLaySepPed.Properties.OnButtonClick         := btnConLaySepPedPropertiesButtonClick;
    btnConCadTpa.Properties.OnButtonClick            := pBtnConCadTpaPropertiesButtonClick;
    btnConServico.Properties.OnButtonClick           := pbtnConServicoPropertiesButtonClick;
    btnCfgLocFis.Properties.OnButtonClick            := btnCfgLocFisPropertiesOnButtonClick;
    btnCfgSUFIPC.Properties.OnButtonClick            := btnCfgSUFIPCPropertiesOnButtonClick;
    btnConLayCEQ.Properties.OnButtonClick            := btnConLayCEQPropertiesButtonClick;

    btnCRELPC.Properties.OnButtonClick               := btnCRELPCPropertiesOnButtonClick;
    btnEXCENT.Properties.OnButtonClick               := btnEXCENTPropertiesOnButtonClick;
    btnEXCSAI.Properties.OnButtonClick               := btnEXCSAIPropertiesOnButtonClick;

    btnCfgEveNec.Properties.OnButtonClick            := btnCfgEveNecPropertiesOnButtonClick;
    btnCfgNsuHos.Properties.OnButtonClick            := btnCfgNsuHosPropertiesOnButtonClick;
    btnBloFil.Properties.OnButtonClick               := btnBloFilPropertiesOnButtonClick;
    btnConRota.Properties.OnButtonClick              := pbtnConRotaPropertiesButtonClick;
    btnConCartao.Properties.OnButtonClick            := pbtnConCartaoPropertiesButtonClick;
    btnConClasseLocal.Properties.OnButtonClick     := pbtnConClassedeLocalPropertiesButtonClick;
    btnConCartaoMultiSelecao.Properties.OnButtonClick := pbtnConCartaoMultiselecaoPropertiesButtonClick;
    btnCadEstabelecimentosCartoes.Properties.OnButtonClick := btnCadEstabelecimentosCartoesPropertiesOnButtonClick;
    btnCadastroChaveAutenticacaoCartoes.Properties.OnButtonClick := btnCadEstabelecimentosCartoes.Properties.OnButtonClick;
    btnCadastroIDRecebedorPagarMe.Properties.OnButtonClick := btnCadEstabelecimentosCartoes.Properties.OnButtonClick;

    btnCadastroLinksAPIBancos.Properties.OnButtonClick := btnCadastroLinksAPIBancosPropertiesOnButtonClick;

    btnHorExeRobo.Properties.OnButtonClick           :=  btnHorExeRoboPropertiesOnButtonClick;
    btnDownLoadDfeTer.Properties.OnButtonClick       := btnDownLoadDfeTerPropertiesOnButtonClick;

    btnConChavesPix.Properties.OnButtonClick        := pbtnConChavesPixPropertiesButtonClick;
    edtValFCusto.Properties.OnChange                 := pedtValFCustoPropertiesChange;

    btnCadFilaWpp.Properties.OnButtonClick           := pbtnCadFilaWppPropertiesOnButtonClick;
    btnConfigWpp.Properties.OnButtonClick            := pbtnConfigWppPropertiesOnButtonClick;
    btnConCatCrm.Properties.OnButtonClick            := btnConCatCrmPropertiesButtonClick;
    btnLocalizacaoFisica.Properties.OnButtonClick    := btnLocalizacaoFisicaPropertiesButtonClick;
    btnPesquisasOpiniOne.Properties.OnButtonClick    := btnPesquisasOpiniOnePropertiesButtonClick;
    btnConfigContele.Properties.OnButtonClick        := pbtnConfigContelePropertiesOnButtonClick;
    btnConVeiculos.Properties.OnButtonClick          := pbtnConVeiculosPropertiesButtonClick;
    btnForGnn.Properties.OnButtonClick               := pbtnFornecedoresGenericosButtonClick;
    btnConVerbas.Properties.OnButtonClick            := pbtnConVerbasClick;

    btnConfigSMS.Properties.OnButtonClick            := pbtnConfigSMSPropertiesOnButtonClick;
    btnEmailAutSaida.Properties.OnButtonClick        := pbtnConfigEmailAutSaidaPropertiesOnButtonClick;
  End;
End;

procedure TfrmCfgSistema.btnEXCENTPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);
Begin
  TfrmCadCfopCst.pCarregaDados(True);
End;

procedure TfrmCfgSistema.btnEXCSAIPropertiesOnButtonClick(Sender: TObject;
      AButtonIndex: Integer);
Begin
  TfrmCadCfopCst.pCarregaDados(False);
End;

function TfrmCfgSistema.fIniciaTelaConfiguracoes(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    strCodigos: String;
    intCont: Integer;
    dtaDtaCai : TDateTime;
    strCfgIgn: String;

    procedure pCarregaDiversos;
      Var
        cdsAux: TUniClientDataSet;
    Begin
      Try
        cdsAux := TUniClientDataSet.Create(Nil);
        cdsAux.Data := cdsCfgSis.Data;

        cdsAux.Filtered := False;
        cdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_CPRIND');
        cdsAux.Filtered := True;

        SetLength(arrConfigComuns, 1);
        arrConfigComuns[0][0] := 'CFG_CPRIND';
        arrConfigComuns[0][1] := cdsAux.FieldByName('SIS_VALCFG').AsString;

        dtaDtaCai := VS_Date;

        fNecessitaFecharCaixa(False, dtaDtaCai);

        cdsAux.Filtered := False;
        cdsAux.Filter := 'SIS_CODCFG = ' + QuotedStr('CFG_RCXTCC');
        cdsAux.Filtered := True;

        If (cdsAux.FieldByName('SIS_VALCFG').AsString = '1') And
           (fCaixaTemMovimento(dtaDtaCai, nil))              Then
        Begin
          cfgRepositorio.rdgTrChCa_1_2.Properties.ReadOnly := True;
        End;

        cdsAux.Filtered := False;
        cdsAux.Filter := 'SIS_CODCFG = ' + QuotedStr('CFG_TPFCCX');
        cdsAux.Filtered := True;

        cfgRepositorio.rdgTipoFechamentoCaixa.Properties.ReadOnly := ((cdsAux.FieldByName('SIS_VALCFG').AsString = 'T') And
                                                                     (fCaixaTemMovimento(dtaDtaCai, nil))) Or
                                                                     ((cdsAux.FieldByName('SIS_VALCFG').AsString = 'C') And
                                                                      (Not TResumoDeCaixa.Create('C').fTodosOsCaixasEstaoFechados));

        cfgRepositorio.rdgTipoFechamentoCaixa.Properties.OnButtonClick := rdgTipoFechamentoCaixaButtonClick;

      Except
        On E: Exception Do
          pMensagensErro(E.message, '');
      End;

      FreeAndNil(cdsAux);
    End;

begin
  inherited;
  dtsCfgSis.DataSet := nil;

  Result := True;

  pgbStatus.Visible := False;
  pInformacao('Aguarde, Carregando configurações...', pgbStatus);
  pAttEventos;

  strCfgIgn := fConfigOculta;

  For intCont := 0 To Length(arrCamposCfg)-1 Do
  Begin
    If (Pos(arrCamposCfg[intCont].strCodCfg, strCfgIgn) > 0) Then
      Continue;

    {**************************REQ 227028*************************}
    {*** CFG_UTIWMS Removido da tela de configurações para que ***}
    {*** seja feita manualmente pela citel, aplicando todos os ***}
    {*** processos completos.                                  ***}
    {**********************************************************BL*}
    If fGetConfiguracoesSomenteCitel.Contains(arrCamposCfg[intCont].strCodCfg) Then
      If Not fEhAdministrador(strLoginUsuarioLogado) Then
        Continue;

    If (Not blnAppEntregaArqIni) And
       (arrCamposCfg[intCont].strGruCfg = 'APP ENTREGA') Then
      Continue;

    If (Not blnWhatsappArqIni) And
       (arrCamposCfg[intCont].strGruCfg = 'INTEGRAÇÃO DE SISTEMAS - WHATSAPP') Then
      Continue;

    If (arrCamposCfg[intCont].strCodCfg = 'CFG_BAIVEF') Then
      If fCfgSis('OPINLT', varString) <> 'S' Then
        Continue;

    strCodigos := strCodigos + arrCamposCfg[intCont].strCodCfg;
    strCodigos := strCodigos + '_';
  End;

  With qryCfgSis Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND (LOCATE(SIS_CODCFG,:CODCFG) > 0) ORDER BY SIS_GRUCFG');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CODCFG').AsString := strCodigos;
    Open;
    FieldByName('SIS_CODEMP').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
    FieldByName('SIS_CODCFG').ProviderFlags := [pfInKey, pfInWhere, pfInUpdate];
  End;

  pSetaClient(qryCfgSis);

  cpvCfgSis.UpdateMode := upWhereKeyOnly;

  cdsCfgSis.IndexFieldNames := 'SIS_CODCFG;SIS_CODEMP';

  cdsCfgSis.Close;
  cdsCfgSis.SetProvider(cpvCfgSis);
  cdsCfgSis.Open;

  If Not VS_CfgJaVerificadas Then
  Begin
    pInformacao('Aguarde, Verificando novas configurações...', pgbStatus);
    cdsCfgSis.CancelUpdates;
    pVerificaConfig(False, False, False, False);
    TValidarConfiguracoes.pDecriptarConfiguracoes;
  End;

  pInformacao('Aguarde, Verificando diversos...', pgbStatus);
  pCarregaDiversos;

  dtsCfgSis.DataSet := cdsCfgSis;
end;

procedure TfrmCfgSistema.rdgTipoFechamentoCaixaButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  If cfgRepositorio.rdgTipoFechamentoCaixa.Properties.ReadOnly Then
    fMensagem('ATENÇÃO', 'Para realizar a alteração dessa configuração, todos os caixas devem estar "FECHADOS" e, ' +
                         'a data do fechamento deve ser inferior a data atual.' + #13 +
                         'Ou seja, nenhum lançamento deve ter sido feito no caixa na data atual.', ['&Ok']);
end;

procedure TfrmCfgSistema.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  Try
    tmrPesquisar.Enabled := False;
    cdsCfgSis.DisableControls;
    pPesquisarConfiguracoes;
  Finally
    cdsCfgSis.EnableControls;
  End;

  If String(edtPesquisar.Text).Trim.Length >= 2 Then
    cxDadosDBTableView1.ViewData.Expand(True)
  Else
    cxDadosDBTableView1.ViewData.Collapse(True);

  cdsCfgSisAfterScroll(cdsCfgSis);
end;

procedure TfrmCfgSistema.btnGravarClick(Sender: TObject);
begin
  fExecutarModal(pGravarCfgSis, 'Aguarde, Gravando configurações ...', '');
end;

procedure TfrmCfgSistema.btnHorExeRoboPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
   LHorarioDisparaRobo: TfrmHorarioDisparaRobo;
begin
  Try
    pCriarFormularios(TfrmHorarioDisparaRobo, LHorarioDisparaRobo);
    LHorarioDisparaRobo.Configuracao := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_CODCFG').EditValue;
    LHorarioDisparaRobo.ShowModal;

    If Not fEmptyStr(LHorarioDisparaRobo.Horario) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := LHorarioDisparaRobo.Horario;
    End;
  Finally
    FreeAndNil(LHorarioDisparaRobo);
  End;
end;

procedure TfrmCfgSistema.btnDownLoadDfeTerPropertiesOnButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    strValCfg: String;
    strCodCfg: String;
begin
  strCodCfg := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_CODCFG').EditValue;
  strValCfg := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;

  If TfrmCfgDownLoadDfeTer.Execute(strCodCfg, strValCfg, FGridClickPoint) Then
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := strValCfg;
end;

procedure TfrmCfgSistema.pGravarCfgSis;
  Var
    prcScroll: TprcScroll;
    blnPersistiu : boolean;
    strTimeZoneOld : String;
    strUsaTmzOld : String;
begin
  inherited;
  edtPesquisar.Clear;
  cdsCfgSis.Filtered := False;
  blnPersistiu := False;
  Try
    strTimeZoneOld := fCfgSis('TMZONE', varString);
    strUsaTmzOld := fCfgSis('USATMZ', varString);
    pDisableControls(cdsCfgSis, prcScroll);

    If (Not fValidaConfiguracaoDiasTolerancia) Then
      Exit;

    TValidarConfiguracoes.cdsCfgSis      := Self.cdsCfgSis;
    TValidarConfiguracoes.lblInformacao  := Self.lblInformacao;
    TValidarConfiguracoes.dicAlteracoes  := Self.dicAlteracoes;
    TValidarConfiguracoes.cfgRepositorio := Self.cfgRepositorio;
    TValidarConfiguracoes.blnAdicionarConfigDuranteValidacao := False;
    TValidarConfiguracoes.funcCadastroCartaoTefConferencia := TClassCadastroCartaoTefConferencia.fExecutar ;

    If Not TValidarConfiguracoes.fValidarConfiguracoes Then
      Exit;

    If Not TValidarConfiguracoes.fValidaUDEVME Then
      Exit;

    If (Not fValidaCOFEND) Then
      Exit;

    cxDadosDBTableView1.ViewData.Collapse(True);

    pInformacao('Aguardando selecionar uma opção!');

    If fMensagem('','Deseja salvar as configurações?',['','']) = 1 Then
    Begin
      /// precisa ficar fora de transação
      if not TValidarConfiguracoes.fCadastrarCadBanNovaFormaCadCartaoTef() then
        Exit ;

      pInformacao('Aguarde, gravando configurações do sistema!');
      Try
        fStartTransaction;

        If cdsCfgSis.State = dsEdit Then
          cdsCfgSis.Post;

        TValidarConfiguracoes.pEncriptarConfiguracoes;

        If fSalvaLogCfg(cdsCfgSis) Then
        Begin
          TValidarConfiguracoes.pAtualizarStatusPlanosRecebimento;
          TValidarConfiguracoes.pNormalizaDadosAlteracaoROMPLP;
          TValidarConfiguracoes.pAtualizaLayoutAutocenter;

          cdsCfgSis.ApplyUpdates(0);

          pAtualizaConfiguracoesComuns;

          strValMsgPedNov := '#NDEF';
          strValMsgOrcNov := '#NDEF';

          If TValidarConfiguracoes.blnAtualizarComissaoProfissionais Then
            TValidarConfiguracoes.pAtualizarComissaoProfissionais;

          If TValidarConfiguracoes.blnBaixaPedidosEnderecamento Then
            TValidarConfiguracoes.pBaixaPedidosEnderecamento;

          If Assigned(GerenciaCliAju) Then
            GerenciaCliAju.PersisteBanco;

          If TValidarConfiguracoes.blnAtualizarSaldoPedido Then
          Begin
            If fAtualizaSaldoPedidoCompraGeral Then
              blnPersistiu := fCommit
            Else
              fRollBack;
          End
          Else blnPersistiu := fCommit;
        End
        Else fRollBack;

      Except
        On E: Exception Do
        Begin
          fRollBack;
          pInformacao(E.Message);
          pMensagensErro(E.Message, '[TfrmCfgSistema.btnGravarClick]');
        End;
      End;

      fExecutarModal(TValidarConfiguracoes.pAtualizarVariaveisDeSistema, 'Aguarde, atualizando variáveis de sistema!', '');
    End
    Else
      Close;

    pInformacao('', False);
  Finally

    if blnPersistiu then
    begin
      dicAlteracoes.Clear;
      TValidarConfiguracoes.pAtualizarTimeZone(strTimeZoneOld, strUsaTmzOld);
    end;

    TValidarConfiguracoes.pDecriptarConfiguracoes;
    pEnableControls(cdsCfgSis, prcScroll);
    pInformacao('', False);
    TValidarConfiguracoes.strValAnt := '';
    cdsCfgSis.Filtered := True;
    cxDadosDBTableView1.ViewData.Collapse(True);
    VS_blnPreAltViaTrigger := fConfiguracaoAtivaTriggerPreAlt;
  End;

end;

procedure TfrmCfgSistema.btnLayoutClick(Sender: TObject);
  Var
    frmModelosLayout: TfrmModelosLayout;
begin
  inherited;
  pCriarFormularios(TfrmModelosLayout, frmModelosLayout);
  With cdsCfgSis do
  Begin
    frmModelosLayout.pExibeLayout(FieldByName('SIS_CODCFG').AsString);
  End;
  pFreeAndNil(frmModelosLayout);
end;

procedure TfrmCfgSistema.btnLayoutMouseEnter(Sender: TObject);
begin
  inherited;
  cxHintStyleController.HideHint;
  cxHintStyleController.ShowHint(Mouse.CursorPos.X,
                                 Mouse.CursorPos.Y,
                                 'Informações',
                                 'Clique aqui para Visualizar os Modelos de Layouts');
end;

procedure TfrmCfgSistema.btnLayoutMouseLeave(Sender: TObject);
begin
  inherited;
  cxHintStyleController.HideHint;
end;

procedure TfrmCfgSistema.btnLocalizacaoFisicaPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  edtCodigo: TEditFocus;
  edtDescri: TEditFocus;
  arrSelecao: TConsultasArray;
  Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLocFisica(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ZFMDES;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_ZFMDES' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 100;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Para clientes "Zona Franca = S" e "Consumidor Final = N" o Icms é calculado e dado como desconto na operação.');
  mmoInfoCfgSis.Lines.Add('** Essa configuração não se aplica: ');
  mmoInfoCfgSis.Lines.Add('   - Quando o emitente do documento é simples nacional.');
  mmoInfoCfgSis.Lines.Add('   - Quando no cadastro do cliente estiver ligado o campo: ');
  mmoInfoCfgSis.Lines.Add('"Aplicar desconto especial somente da diferença entre aliquota praticada e aliquota interestadual, e destacar o icms da aliquota praticada na venda, para produtos importados?"');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_CLAIMP;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_CLAIMP' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 100;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Nesta configuração deve informar todas as CFOPs permitidas na nota de importação, na CFG_IMPFIS');
  mmoInfoCfgSis.Lines.Add('será definida a CFOP padrão que sempre vai carregar ao emitir uma nota de importação.');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SONCEE;
begin
  if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SONCEE') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clBlack;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração quando utilizada na opção "CONFERÊNCIA DE ENTRADA", só poderá ser usada quando a configuração ');
    mmoInfoCfgSis.Lines.Add('[CFG_NUMSER] Utilizar controle simplificado de números de série para produtos, sem necessidade de lote e/ou wms? estiver com a opção SIM.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_MUNINC;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_MUNINC' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 100;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Caso essa configuração for ativada, não será possível enviar o endereço da obra CFG_ENOOBR');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_CARREA;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_CARREA' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 40;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('A sugestão só terá efeito se as duas opções estiverem habilitadas. As regras para travar uma das opções continuam validas.');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_CENDNE;
begin
  if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CENDNE') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessário definir as configurações: ');
    mmoInfoCfgSis.Lines.Add('  [CFG_CFVLCB] Solicitar conferencia de volumes por código de barras? = SIM ');
    mmoInfoCfgSis.Lines.Add('  [CFG_ROMBCX] Utilizar código de barras dos volumes para montar romaneio, para Romaneio [ 2 ] e [ 3 ] ? = NÃO ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_CLCCTR;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLCCTR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Calculado pela Aplicação:');
    mmoInfoCfgSis.Lines.Add('TOTAL A ADQUIRIR = [ (DOSAGEM APLICAÇÃO) * ( (ÁREA APLICAÇÃO) / (DOSAGEM ESPECIFICADA) ) * (NÚMERO DE APLICAÇÃO) ]');
    mmoInfoCfgSis.Lines.Add('Calculado por quantidade de Receituários:');
    mmoInfoCfgSis.Lines.Add('TOTAL A ADQUIRIR = [ (VALOR POR ART) / (QUANTIDADE DE RECEITUÁRIOS POR ART) ]');
    mmoInfoCfgSis.Lines.Add('TOTAL A ADQUIRIR = [ ( CFG_VLRART ) / ( CFG_QTDREC ) ]');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DEIPCT;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DEIPCT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 45;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Possibilidade de deduzir ICMS da base de calculo PIS/COFINS, conforme lei: nº 14592/2023 desde o dia 30/05/2023.');
    mmoInfoCfgSis.Lines.Add('         (www.planalto.gov.br/ccivil_03/_ato2023-2026/2023/lei/L14592.htm) .');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ENDAUT;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENDAUT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração o sistema deverá estar configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerênciamento de Armazém )? = NÃO');
    mmoInfoCfgSis.Lines.Add('[CFG_UM1LFL] = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_LOTEND] = 1');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ENDPRO;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENDPRO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para funcionamento deste recurso, as configurações abaixo deverão estar da seguinte maneira:');
    mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = SIM.');
    mmoInfoCfgSis.Lines.Add('[ CFG_TPLREC ] Quando utiliza WMS como será feito o Plano de Recebimento? = (C)LASSE OU (L)OCAL DE SEPARAÇÃO.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_RSAPRP;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RSAPRP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao desligar esta configuração, será impresso somente a Remessa de Separação!');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_UEVPRI;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UEVPRI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 45;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('O centro de custo não é obrigatório na entrada de uso/consumo quando configurado:');
    mmoInfoCfgSis.Lines.Add('CFG_CTPOBE - Obrigar o preenchimento do Centro de Custos na manutenção de contas a pagar = NÃO ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_URMEIE;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_URMEIE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 55;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração habilita nova tela para Cadastrar Solicitações de Manutenção de Equipamentos Internos.');
    mmoInfoCfgSis.Lines.Add('E a Solicitação poderá ser associada com Cotação e Pedido de Compras, caso necessite comprar peças/serviços para realizar a manutenção.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_UTILLC;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UTILLC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração o sistema deverá estar configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerênciamento de Armazém )? = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_GRUSEP] = Imprimir separação por setor, onde o setor será definido: = "Por Local de Separação"');
    mmoInfoCfgSis.Lines.Add('[CFG_LSEWMS] = NÃO');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SOLOLA;
begin
  if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SOLOLA') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clBlack;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao finalizar a Separação do Produto no Coletor, será criado um novo LOTE com a LOCALIZAÇÃO vinculada no cadastro ');
    mmoInfoCfgSis.Lines.Add('e gerado uma ''TA'' transferindo o saldo do lote da separação para o lote do local de armazenamento escolhido.');
    mmoInfoCfgSis.Lines.Add('É preciso habilitar a configuração [CFG_GDPDCN] Quando usar wms(CFG_UTIWMS = Sim) utilizar rotina de guarda de produtos de pedidos cancelados?');
    mmoInfoCfgSis.Lines.Add('Necessário desabilitar a configuração CFG_LSEWMS');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SUFIPC;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SUFIPC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 55;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa for da Zona Franca (ou Livro Comércio),');
    mmoInfoCfgSis.Lines.Add('onde ela tem direito a crédito de PIS/COFINS. Nesses cenários o sistema não irá buscar as aliquotas de PIS/COFINS');
    mmoInfoCfgSis.Lines.Add('do Cadastro de Abreviação Fiscal, e utilizará os valores definidos nesse configuração.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SUPSEP;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SUPSEP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração o sistema deverá estar configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerênciamento de Armazém )? = NÃO');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_TRAFRE;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRAFRE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 55;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se "Maior que o sugestão", utiliza o direito de acesso "Direitos de Acesso > Faturamento > Alterar valor do frete de sugestão com valor Maior"');
    mmoInfoCfgSis.Lines.Add('Se "Menor que o sugestão", utiliza o direito de acesso "Direitos de Acesso > Faturamento > Alterar valor do frete de sugestão com valor Menor"');
    mmoInfoCfgSis.Lines.Add('Se "Ambos", utiliza o direito de acesso "Direitos de Acesso > Faturamento > Alterar valor do frete de sugestão"');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ALTVMT;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_ALTVMT' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 40;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('A configuração [CFG_TRVEPR] deve estar marcado "2-Travar no final da venda" para ativar esta configuração.');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_BEACCS;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BEACCS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 45;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Na opção[2], O Sistema deve somar o saldo reservado dos pedidos de venda ainda não Faturados, porém ja SEPARADOS E CONFERIDOS:');
    mmoInfoCfgSis.Lines.Add('    ( A.FGO_ESPDOC = "PD" AND A.FGO_JAFATU = 0 AND B.FGO_DOCEND IS NULL AND A.FGO_VLRCON > 0 AND A.FGO_LIBERA > 0 AND A.FGO_LIBCOM > 0 AND B.FGO_DTLBEX IS NOT NULL )');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;


procedure TfrmCfgSistema.pAdicionarHintPerguntasImpressao;
begin
  If (Not MatchStr(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, ['CFG_SUGIPD','CFG_SUGIOR', 'CFG_SUGISP'])) Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 30;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Essa configuração funciona em conjunto com o novo fechamento de pedido/orçamento de venda ( CFG_NVORPD = S ).');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pVerificaConfig(blnMostraProgresso    : Boolean = True;
                                         blnAtualizarDescricao : Boolean = True;
                                         blnVerificarPaths     : Boolean = True;
                                         blnDecriptaCfgs : Boolean = False);
  Var
    intContador: Integer;
    lstLista   : TStringList;
    blnAtualizou: Boolean;
    blnRecarrega: Boolean;
    blnInconsist: Boolean;
    prcScroll: TprcScroll;
    AProperties: TcxCustomEditProperties;
    strValorDefault: String;
    strCfgIgn: String;
Begin
  edtPesquisar.Clear;
  cdsCfgSis.Filtered := False;

  blnAtualizou := False;
  blnRecarrega := False;
  blnInconsist := False;

  pDisableControls(cdsCfgSis, prcScroll);
  lstLista := TStringList.Create;
  Try

    lstLista.Add('INCONSISTÊNCIAS');
    lstLista.Add('***********************************************');

    lstLista.Add('');

    lstLista.Add('CAMPOS NÃO ENCONTRADOS NO BANCO DE DADOS       ');
    lstLista.Add('***********************************************');

    If blnMostraProgresso Then
    Begin
      pgbProgresso.Visible := True;
      pgbProgresso.Max := Length(arrCamposCfg);
      pgbProgresso.Position := 0;

      pInformacao('Aguarde! Criando configurações inexistentes e/ou corrigindo descrições...', True);
    End;

    strCfgIgn := fConfigOculta;
    strCfgIgn := strCfgIgn + FStrCfgOcu;

    For intContador := 0 To Length(arrCamposCfg) -1 Do
    Begin
      If fNaoCriarConfiguracoes(arrCamposCfg[intContador].strCodCfg) Then
        Continue;

      If (Pos(arrCamposCfg[intContador].strCodCfg, strCfgIgn) > 0) Then
        If (fCampoTabela('SIS_CODCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], [arrCamposCfg[intContador].strCodCfg, VS_strCodEmp]) <> '') Then
          Continue;

      {**************************REQ 227028*************************}
      {*** CFG_UTIWMS Removido da tela de configurações para que ***}
      {*** seja feita manualmente pela citel, aplicando todos os ***}
      {*** processos completos.                                  ***}
      {**********************************************************BL*}
      If fGetConfiguracoesSomenteCitel.Contains(arrCamposCfg[intContador].strCodCfg) Then
        If Not fEhAdministrador(strLoginUsuarioLogado) Then
          Continue;

      If (Not blnAppEntregaArqIni) And
         (arrCamposCfg[intContador].strGruCfg = 'APP ENTREGA') Then
        Continue;

      If (Not blnWhatsappArqIni) And
         (arrCamposCfg[intContador].strGruCfg = 'INTEGRAÇÃO DE SISTEMAS - WHATSAPP') Then
        Continue;

      If Not cdsCfgSis.FindKey([arrCamposCfg[intContador].strCodCfg, VS_strCodEmp]) Then
      Begin
        If (Not fCriarConfiguracoes(arrCamposCfg[intContador].strCodCfg, VS_strCodEmp)) Then
        Begin
          lstLista.Add(arrCamposCfg[intContador].strCodCfg);
          blnInconsist := True;
        End
        Else
        Begin
          blnAtualizou := True;
          blnRecarrega := True;
        End;
      End
      Else
      Begin

        If blnAtualizarDescricao Then
        Begin
          {*******************************************}
          {* SE O CAMPO JA EXISTIR VERIFICA A DESCRI *}
          {****************************************AF*}
          If (Trim(cdsCfgSis.FieldByName('SIS_DESCRI').AsString) <> Trim(arrCamposCfg[intContador].strDescri)) Or
             (cdsCfgSis.FieldByName('SIS_NUMHLP').AsInteger <> arrCamposCfg[intContador].intNumHlp) Or
             (Trim(cdsCfgSis.FieldByName('SIS_GRUCFG').AsString) <> Trim(arrCamposCfg[intContador].strGruCfg)) Or
             (Trim(cdsCfgSis.FieldByName('SIS_LAYOUT').AsString) <> Trim(arrCamposCfg[intContador].strLayout))Then
          Begin
            cdsCfgSis.Edit;
            cdsCfgSis.FieldByName('SIS_DESCRI').AsString := arrCamposCfg[intContador].strDescri;
            cdsCfgSis.FieldByName('SIS_GRUCFG').AsString := arrCamposCfg[intContador].strGruCfg;
            cdsCfgSis.FieldByName('SIS_NUMHLP').AsInteger := arrCamposCfg[intContador].intNumHlp;
            cdsCfgSis.FieldByName('SIS_LAYOUT').AsString := arrCamposCfg[intContador].strLayout;
            cdsCfgSis.Post;
            blnAtualizou := True;
            blnRecarrega := True;
          End;
        End;

      End;

      If blnMostraProgresso Then
        pgbProgresso.Position := pgbProgresso.Position + 1;

    End;

    If (blnInconsist) Then
      lstLista.Add('***********************************************')
    Else
      lstLista.Add('');

    {Valida PATHs}
    If (blnVerificarPaths) Then
    Begin

      pInformacao('Aguarde! Validando configurações de PATHs...', True);

      lstLista.Add('PATHS INVÁLIDOS (VERIFICAR)                    ');
      lstLista.Add('***********************************************');

      If blnMostraProgresso Then
      Begin
        pgbProgresso.Visible  := True;
        pgbProgresso.Max      := Length(arrCamposCfg);
        pgbProgresso.Position := 0;
      End;

      For intContador := 0 To Length(arrCamposCfg) -1 Do
      Begin
        If blnMostraProgresso Then
          pgbProgresso.Position := pgbProgresso.Position + 1;

        If (arrCamposCfg[intContador].strCodCfg = 'CFG_TAXDIA') Then
          Continue;

        strValorDefault := Trim(AnsiUpperCase(arrCamposCfg[intContador].strValCfg));

        If (Length(strValorDefault) = 1) Then
        Begin
          If (CharInSet(strValorDefault[1], ['+','-','%','$','0'..'9','A'..'Z'])) Then
            Continue;
        End;

        If cdsCfgSis.FindKey([arrCamposCfg[intContador].strCodCfg, VS_strCodEmp]) Then
        Begin
          If Not fEmptyStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
          Begin
            cfgRepositorio.pRetProperties(arrCamposCfg[intContador].strCodCfg, AProperties);

            If Assigned(AProperties) Then
            Begin
              If (AProperties Is TcxButtonEditProperties) Then
              Begin
                {Verifica se é uma configuração de PATH}
                If (TcxButtonEditProperties(AProperties).ImeMode = imOpen) Then
                Begin
                  {Verifica se é um "Diretório/Arquivo" válido}
                  If Not DirectoryExists(cdsCfgSis.FieldByName('SIS_VALCFG').AsString) And
                     Not FileExists(cdsCfgSis.FieldByName('SIS_VALCFG').AsString)      Then
                  Begin
                    lstLista.Add(arrCamposCfg[intContador].strCodCfg);
                    blnInconsist := True;
                  End;
                End;
              End;
            End;
          End;
        End;
      End;

      If (blnInconsist) Then
      Begin
        lstLista.Add('***********************************************')
      End
      Else
      Begin
        If blnMostraProgresso Then
        Begin
          pInformacao('Configurações validadas com sucesso!', True);
          Sleep(1500);
        End;
      End;

    End;

  Finally

    pInformacao('', False);

    If blnAtualizou Then
    Begin
      If cdsCfgSis.State = dsEdit Then
        cdsCfgSis.Post;
      TValidarConfiguracoes.pEncriptarConfiguracoes;
      cdsCfgSis.ApplyUpdates(0);
    End;

    If blnRecarrega Then
      cdsCfgSis.Refresh;

    If (blnAtualizou) And (blnDecriptaCfgs) Then
      TValidarConfiguracoes.pDecriptarConfiguracoes;

    If blnMostraProgresso Then
    Begin
      If blnInconsist Then
      Begin
        Try
          pCriarFormularios(TfrmMemo, frmMemo);
          frmMemo.cxMemo.Lines := lstLista;
          frmMemo.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[frmCfgSistema.pVerificaConfig]');
          End;
        End;
        pFreeAndNil(frmMemo);
      End;
      pgbProgresso.Visible := False;
      pgbProgresso.Position := 0;
    End;

    pEnableControls(cdsCfgSis, prcScroll);
    FreeAndNil(lstLista);

    cdsCfgSis.Filtered := True;
  End;

End;

procedure TfrmCfgSistema.pVerificarConfiguracoes;
begin
  Self.pVerificaConfig(True, True, True, True);
end;

procedure TfrmCfgSistema.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F9:
    Begin
      fExecutarModal(pVerificarConfiguracoes, 'Aguarde, Verificando configurações ...', '');
    End;
    VK_F10:
    Begin
      pSetFocus(btnLayout);
      btnLayout.Click;
    End;
  End;

end;

procedure TfrmCfgSistema.FormResize(Sender: TObject);
begin
  inherited;
  cxDadosDBTableView1SIS_CODCFG.Width := 100;
  cxDadosDBTableView1SIS_DESCRI.Width := Floor(Self.Width * 0.5);
  cxDadosDBTableView1SIS_VALCFG.Width := Floor(Self.Width * 0.5) - 200;
end;

procedure TfrmCfgSistema.FormShow(Sender: TObject);
  Var
    AProperties: TcxCustomEditProperties;
    intCont: Integer;
    strPatIni: String;
    Buffer: Array[0..254] Of Char;
begin
  inherited;
  TValidarConfiguracoes.cfgRepositorio := Self.cfgRepositorio;

  strUsaTipExpLocal := '';
  strPatIni := fCfgSis('PATINI');
  If fEmptyStr(strPatIni) Then
  Begin
    GetWindowsDirectory(Buffer, 255);
    strPatIni := StrPas(Buffer);
  End;
  strPatIni := strPatIni + '\OPCOES_LOCAIS.INI';
  If FileExists(strPatIni) Then
  Begin
    strUsaTipExpLocal := fArqIniLocal(0, 'TIPO_FATURAMENTO', 'EXPEDICAO' , strUsaTipExpLocal, strPatIni);
    If (Not fEmptyStr(strUsaTipExpLocal)) Then
    Begin
      If Assigned(cfgRepositorio) Then
      Begin
        cfgRepositorio.pRetProperties('CFG_TIPEXP', AProperties);
        With TcxCustomRadioGroupProperties(AProperties) Do
        Begin
          For intCont:=0 To Items.Count-1 Do
          Begin
            If Items[intCont].Value = strUsaTipExpLocal Then
              strUsaTipExpLocal := Items[intCont].Caption;
          End
        End;
      End;
    End;
  End;

  TValidarConfiguracoes.strValAnt := '';
  pIniciaTelaConfiguracoes;
  cxDadosDBTableView1.ViewData.Collapse(True);
  cfgRepositorio.cdsCfgSis := cdsCfgSis;
  TValidarConfiguracoes.pAjustaLabelCfgVlcUne;
  pSetFocus(edtPesquisar);

  If Not EXIBE_MARMKP_4_5 then
    pRemoveMarkup4_5;

  TValidarConfiguracoes.pAjustaCFG_PLAROT;
end;

procedure TfrmCfgSistema.pbtnPatEndPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  const
    SELDIRHELP = 1000;
  var
    strDir: string;
    sisVal: string;
begin
  inherited;

  strDir := 'C:\';
  sisVal := VarToStr(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);

  If (TryDirectoryExists(sisVal)) Then
    strDir := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;

  If SelectDirectory(strDir, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) Then
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := strDir;
end;

procedure TfrmCfgSistema.pbtnPatImgConsultaPrecoPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var
    strDir: string;
    sisVal: string;
begin
  inherited;

  strDir := 'C:\';
  sisVal := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;

  If (TryDirectoryExists(ExtractFilePath(sisVal))) Then
    strDir := ExtractFilePath(sisVal);

  opdPatPic.InitialDir := strDir;

  If opdPatPic.Execute Then
  Begin
    If TValidarConfiguracoes.fValidaTamanhoIdealImagem(opdPatPic.FileName) Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := opdPatPic.FileName;
  End;
end;

procedure TfrmCfgSistema.pbtnPatImgPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  var
    strDir: string;
    sisVal: Variant;
begin
  inherited;

  strDir := 'C:\';
  sisVal := VarToStr(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);

  If (TryDirectoryExists(sisVal)) Then
    strDir := ExtractFilePath(sisVal);

  opdPatPic.InitialDir := strDir;

  If opdPatPic.Execute Then
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := opdPatPic.FileName;
end;

procedure TfrmCfgSistema.pbtnPatArqPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  var
    strDir: string;
    sisVal: string;
begin
  inherited;

  strDir := 'C:\';
  sisVal := VarToStr(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);

  If (TryDirectoryExists(sisVal)) Then
    strDir := ExtractFilePath(sisVal);

  opdPatArq.InitialDir := strDir;

  If opdPatArq.Execute Then
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := opdPatArq.FileName;
end;

procedure TfrmCfgSistema.pbtnPatSndPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
var
  strDir: string;
  sisVal: string;
  strDes: string;
begin
  inherited;

  if AButtonIndex = 1 then
  begin
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := '';
    Exit;
  end;

  strDir := 'C:\';
  sisVal := VarToStr(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);

  If (TryDirectoryExists(sisVal)) Then
    strDir := ExtractFilePath(sisVal);

  opdPatSnd.InitialDir := strDir;

  If Not opdPatSnd.Execute Then
    Exit;

  sisVal := opdPatSnd.FileName;

  If sisVal.ToLower.StartsWith('\\tsclient') then
  Begin
    Try
      pMensagemOk('Não é permitido selecionar um arquivo de áudio diretamente do computador local. '+
        'O arquivo será copiado para um diretório válido!');

      strDes := GetCurrentDir + '\Sistema Sonoro';

      If Not DirectoryExists(strDes) Then
        ForceDirectories(strDes);

      strDes := strDes + '\' + VS_strCodEmp;

      If Not DirectoryExists(strDes) Then
        ForceDirectories(strDes);

      strDes := strDes + '\' + ExtractFileName(sisVal);

      TFile.Copy(sisVal, strDes, True);

      If FileExists(strDes) Then
        sisVal := strDes;
    Except
      On E: Exception Do
      Begin
        sisVal := '';
        pMensagemOk(E.Message);
      End;
    End;
  End;

  TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := sisVal;
end;

procedure TfrmCfgSistema.pCarregarDescricaoValorConfiguracoes;
begin
  Try
    edtPesquisar.Clear;
    cdsCfgSis.Filtered := False;
    cdsCfgSis.DisableControls;
    cdsCfgSis.First;
    While Not cdsCfgSis.Eof Do
    Begin
      cfgRepositorio.fRetDescricaoValoresCfg(cdsCfgSis.FieldByName('SIS_CODCFG').AsString,
                                             cdsCfgSis.FieldByName('SIS_VALCFG').AsString);
      cdsCfgSis.Next;
    End;
  Finally
    cdsCfgSis.EnableControls;
    cdsCfgSis.Filtered := True;
    cxDadosDBTableView1.ViewData.Collapse(True);
  End;
end;

procedure TfrmCfgSistema.pbtnConCartaoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    try
      Key := '/';
      If fPesqCartao(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

procedure TfrmCfgSistema.pbtnConCartaoMultiselecaoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;

    LValorConfiguracao: String;

    LContador: Integer;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    try
      Key := '/';
      If fPesqCartao(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, False) Then
      Begin
        LValorConfiguracao := '';
        For LContador := 0 To Length(arrSelecao) - 1 Do
          LValorConfiguracao := LValorConfiguracao + arrSelecao[LContador].strCodigo + '_';

        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := LValorConfiguracao;
      End
      Else
      Begin
        If fMensagem('ATENÇÃO', 'Nenhum cartão foi selecionado, Deseja Limpar o Valor do Campo ?', ['&Sim', '&Não'], 2) = 1 Then
        Begin
           TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := '';
        End;
      End;
    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

procedure TfrmCfgSistema.pbtnConChavesPixPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    try
      Key := '/';
      If fPesqChavesPixContas(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

procedure TfrmCfgSistema.pbtnConClassedeLocalPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
  arrSel : TConsultasArray;
  edtCodigo: TEditFocus;
  Key : Char;
begin
  inherited;

  Key := '/';
  Try
    edtCodigo := TEditFocus.Create(Nil);
    If fPesqClasseLocFis(Self, edtCodigo, nil, Key, arrSel) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Finally
    FreeAndNil(edtCodigo)
  End;
end;

procedure TfrmCfgSistema.pbtnConClientePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCliente(conCliSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnAjuClientePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  GerenciaCliAju := TGerenciaCliAju.fDefiniCliAju(TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue);
  TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := GerenciaCliAju.strCliPrincipal;
end;

procedure TfrmCfgSistema.pbtnConEmpresaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqEmpresa(conEmpSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConEmpresasMultiselecaoPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;

    LEmpresaAtual: TConsultas;

    LSelecionados: String;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqEmpresa(conEmpSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, False) Then
    Begin
      LSelecionados := '';

      For LEmpresaAtual In arrSelecao Do
        LSelecionados := LSelecionados + LEmpresaAtual.strCodigo + '_';

      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := LSelecionados;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConfigContelePropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmCfgContele: TfrmCfgContele;
begin
  pCriarFormularios(TfrmCfgContele, frmCfgContele);
  try
    frmCfgContele.ShowModal;
  finally
    pFreeAndNil(frmCfgContele);
  end;
end;

procedure TfrmCfgSistema.pbtnConfigEmailAutSaidaPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    LCfgEmailAutSaida: TfrmCfgEmailAutSaida;
begin
  Try
    pCriarFormularios(TfrmCfgEmailAutSaida, LCfgEmailAutSaida);
    LCfgEmailAutSaida.MostraAvisoProximoDiaUtil := TValidarConfiguracoes.fGetValorConfiguracao('AVIFDS').Equals('S');
    LCfgEmailAutSaida.ShowModal;

    If (cdsCfgSis.State = dsBrowse) Then
      cdsCfgSis.Edit;
    cdsCfgSis.FieldByName('SIS_VALCFG').AsString := fCfgSisL('EMASAI', VarString);
    cdsCfgSis.Post;
  Finally
    FreeAndNil(LCfgEmailAutSaida);
  End;
end;

procedure TfrmCfgSistema.pbtnConfigSMSPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    LCfgSMS: TfrmCfgSMS;
begin
  Try
    pCriarFormularios(TfrmCfgSMS, LCfgSMS);
    LCfgSMS.MostraAvisoProximoDiaUtil := TValidarConfiguracoes.fGetValorConfiguracao('AVIFDS').Equals('S');
    LCfgSMS.ShowModal;
  Finally
    FreeAndNil(LCfgSMS);
  End;
end;

procedure TfrmCfgSistema.pbtnConfigWppPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  frmCfgWpp: TfrmCfgWpp;
begin
  pCriarFormularios(TfrmCfgWpp, frmCfgWpp);
  try
    frmCfgWpp.MostraAvisoProximoDiaUtil := TValidarConfiguracoes.fGetValorConfiguracao('AVIFDS').Equals('S');

    frmCfgWpp.ShowModal;
  finally
    pFreeAndNil(frmCfgWpp);
  end;
end;

procedure TfrmCfgSistema.pbtnConItemPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqItem(conIteSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConMatrizIcmsPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqMatrizAliquotasIcms(Self, edtCodigo, Nil, nil, Key, arrSelecao) Then
      cxDadosDBTableView1SIS_VALCFG.EditValue := edtCodigo.Text
    Else
    Begin
      if fMensagem('ATENÇÃO', 'Nenhuma Matriz de ICMS foi selecionada, Deseja Limpar o Valor do Campo ?', ['&Sim', '&Não'], 2) = 1 then
      Begin
        cxDadosDBTableView1SIS_VALCFG.EditValue := '';
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConFornecedorMultiPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, False) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := fRetornaFornecedorMulti(arrSelecao);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConFornecedorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConPortadorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqPortador(conSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(edtCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
      End;
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End
    Else
    Begin
      if fMensagem('ATENÇÃO', 'Nenhum portador foi selecionado, Deseja Limpar o Valor do Campo ?', ['&Sim', '&Não'], 2) = 1 then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := '';
      End;
    End;


  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConPortRcxPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqPortador(conParaBaixas, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      {*REQ*145940**********RP*}
      If Not fEmpresaTemAcessoPortador(edtCodigo.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
      End;
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConServicoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqServicos(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConVeiculosPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo  : TEditFocus;
    edtDescri  : TEditFocus;
    arrSelecao : TConsultasArray;
    Key        : Char;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqVeiculos(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, False) Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConVerbasClick(Sender: TObject;
  AButtonIndex: Integer);
Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqVerbas(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      If Not fEmptyStr(edtCodigo.Text) Then
      Begin
        If Not EhVerbaDebito(edtCodigo.Text) Then
          Exit;
      End;
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConRotaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo : TEditFocus;
    edtDescri : TEditFocus;
    arrSelecao: TConsultasArray;
    Key       : Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqEntregasRotasRegiao(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, '','', False) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);

end;

procedure TfrmCfgSistema.pbtnConHisPadPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
    LcdsAux: TClientDataset;
    LstrHisTpl: string;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);
    try
      Key := '/';

      LstrHisTpl := '';
      LcdsAux := TUniClientDataSet.Create(nil);
      try
        LcdsAux.Data := cdsCfgSis.Data;

        LcdsAux.Filtered := False;
        LcdsAux.Filter   := 'SIS_CODCFG = ' + QuotedStr('CFG_HISTPL') + ' AND SIS_CODEMP = ' + QuotedStr(VS_strCodEmp);
        LcdsAux.Filtered := True;

        if not LcdsAux.Eof then
          LstrHisTpl := LcdsAux.FieldByName('SIS_VALCFG').AsString ;
      finally
        FreeAndNil(LcdsAux);
      end;

      If fPesqHistoricoPadrao(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, VS_strCodEmp, LstrHisTpl) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    finally
      FreeAndNil(edtCodigo);
      FreeAndNil(edtDescri);
    end;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

procedure TfrmCfgSistema.pbtnConCtaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCentroCusto(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      If Not fEmptyStr(edtCodigo.Text) Then
      Begin
        If Not PlanoDeContasAtivo(edtCodigo.Text) Then
          Exit;
      End;

      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End
    Else
    Begin
      If fMensagem('ATENÇÃO', 'Nenhum plano de contas foi selecionado, Deseja Limpar o Valor do Campo ?', ['&Sim', '&Não'], 2) = 1 Then
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := '';
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbntLAYPADPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  var blnPrePro, blnExiPrePro: Boolean;
      intTabPre: integer;
      strCodCnd,
      strDesEti,
      strCfgTipEti,
      strCndPag,
      strNumPar : String;
      TipoEtiqueta: TTipoEtiqueta;
begin
  strCfgTipEti := fCfgSis('TIPETI');

  If ((fEmptyStr(strCfgTipEti)) OR (strCfgTipEti = 'S') Or (strCfgTipEti = 'M') ) Then
  Begin
    fMensagem('ATENÇÃO!', 'A configuração [CFG_TIPETI - Etiqueta de Produto] ' + #13#10 +
                          'não pode estar nas opções: ' + #13#10 +
                          '[Selecionar no ato da impress'+#227+'o]' + ' ou ' +
                          '[Matricial]' , ['&Ok']);
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := 'Nenhum';
  End
  Else
  Begin
    fEscolheTipoEtiqueta(TipoEtiqueta, False, blnPrePro, intTabPre, strCodCnd, strCndPag, strNumPar, strDesEti, blnExiPrePro, True, True);
    If TipoEtiqueta.GetName.Equals('Não identificado') Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := 'Nenhum'
    Else
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := TipoEtiqueta.GetName;
  End;
end;

procedure TfrmCfgSistema.pbtnCadFilaWppPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  frmCadFilaAtenderBem: TfrmCadFilaAtenderBem;
begin
  pCriarFormularios(TfrmCadFilaAtenderBem, frmCadFilaAtenderBem);
  try
    frmCadFilaAtenderBem.ShowModal;
  finally
    pFreeAndNil(frmCadFilaAtenderBem);
  end;
end;

procedure TfrmCfgSistema.pbtnConAtividadePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqAtividade(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConBancoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqBanco(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConTranspPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqTransportadora(conTraSimples,Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConOcorrenciaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqOcorrencia(Self, edtCodigo, edtDescri, NIl, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConOperadorPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqOperador(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConTipClientePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqTipoCliente(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConEventoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqEventos(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, False, 'P') Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConTipTriPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqGuiaReceitaFederal(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, True, True) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;


procedure TfrmCfgSistema.btnConAtePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCadAte(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConFasePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFases(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConFinalidadeAjustePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFinalidadeAjuste(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConTipOcoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqTiposOcorrencias(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConMotVenPerdPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqMotVendasPerdidas(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConCondicaoPgtoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    recSelecao: TConsultas;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCondicoesPgto(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao, False, False, conCndSimples, 0, 0, '', True) Then
    Begin
      if edtCodigo.Text <> '000' then
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text
      else
      begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := EmptyStr;

        for recSelecao in arrSelecao do
          TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue + recSelecao.strCodigo+'_';

      end;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConFormaPgtoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFormaPgto(conFpgSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConLayoutPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, NIl, 'J', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpeSepRomaneio].ToString {82}) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConDepartamentoPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqDepartamento(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConAbrPisPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqPisSai(Self, edtCodigo, Nil, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
end;

procedure TfrmCfgSistema.btnConAjuICMPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    arrSelecao: TConsultasArray;
    Key: Char;
    qryConsulta: TUniQuery;
begin

  Try
    qryConsulta := fCriaQuery;
    Try
      Key := '/';
      If fPesqTabelaAjuste(Self, qryConsulta, Key, arrSelecao) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := qryConsulta.FieldByName('AJU_CODAJU').AsString;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

procedure TfrmCfgSistema.btnCadastroLinksAPIBancosPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    LConfiguracoesLinksAPIBancos: TfrmConfiguracoesLinksAPIBancos;
begin
  If Not fTabelaExiste('LNKBCO') Then
  Begin
    fMensagem('ATENÇÃO', 'A tabela de links de API dos Bancos não existe. Entre em contato com a Citel!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmConfiguracoesLinksAPIBancos, LConfiguracoesLinksAPIBancos);
    LConfiguracoesLinksAPIBancos.ShowModal;
  Finally
    pFreeAndNil(LConfiguracoesLinksAPIBancos);
  End;
end;

procedure TfrmCfgSistema.btnCadEstabelecimentosCartoesPropertiesOnButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCriarFormularios(TfrmCfgCadEstabelecimentosOperadorasCartoes, frmCfgCadEstabelecimentosOperadorasCartoes);
  frmCfgCadEstabelecimentosOperadorasCartoes.Configuracao := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_CODCFG').EditValue;
  frmCfgCadEstabelecimentosOperadorasCartoes.ShowModal;

  TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := frmCfgCadEstabelecimentosOperadorasCartoes.EstabelecimentosCadastrados;

  FreeAndNil(frmCfgCadEstabelecimentosOperadorasCartoes);
end;

procedure TfrmCfgSistema.pEditarConfiguracaoPorEmpresa;
var
  frmCfgSistemaEmp: TfrmCfgSistemaEmp;
begin
  inherited;
  If Not fConfiguracaoPermiteReplicar(cdsCfgSis.FieldByName('SIS_CODCFG').AsString) Then
    Exit;

  pCriarFormularios(TfrmCfgSistemaEmp, frmCfgSistemaEmp);
  Try
    frmCfgSistemaEmp.fncPermitirEditarConfiguracao := fPermitirEditarConfiguracao;
    frmCfgSistemaEmp.edtCodCfg.Text := cdsCfgSis.FieldByName('SIS_CODCFG').AsString;
    frmCfgSistemaEmp.edtDesCfg.Text := cdsCfgSis.FieldByName('SIS_DESCRI').AsString;
    frmCfgSistemaEmp.cfgRepositorio := Self.cfgRepositorio;

    Try
      If frmCfgSistemaEmp.ShowModal = mrOk Then
      Begin
        If frmCfgSistemaEmp.stlEmpAlteradas.IndexOf(VS_strCodEmp) >= 0 Then
        Begin
          frmCfgSistemaEmp.pFiltrarEmpresa(VS_strCodEmp);
          If TValidarConfiguracoes.fFindCfg(cdsCfgSis.FieldByName('SIS_CODCFG').AsString) Then
          Begin
            Self.cdsCfgSis.Edit;
            Self.cdsCfgSis.FieldByName('SIS_VALCFG').AsString := frmCfgSistemaEmp.cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
            Self.cdsCfgSis.Post;
          End;
        End;
      End;

    Finally
      TValidarConfiguracoes.cdsCfgSis      := Self.cdsCfgSis;
      TValidarConfiguracoes.lblInformacao  := Self.lblInformacao;
      TValidarConfiguracoes.dicAlteracoes  := Self.dicAlteracoes;
      TValidarConfiguracoes.cfgRepositorio := Self.cfgRepositorio;
      TValidarConfiguracoes.cxDBTableView  := Self.cxDadosDBTableView1;
      TValidarConfiguracoes.blnAdicionarConfigDuranteValidacao := False;
    End;

  Finally
    pFreeAndNil(frmCfgSistemaEmp);
  End;
end;

procedure TfrmCfgSistema.btnCfgEmpClick(Sender: TObject);
begin
  inherited;
  If btnCfgEmp.Visible Then
    fExecutarModal(pEditarConfiguracaoPorEmpresa, 'Aguarde, Atualizando configuração por empresa ...', '');
end;

procedure TfrmCfgSistema.btnCfgEveNecPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmCfgEveNec);
end;

procedure TfrmCfgSistema.btnCfgLocFisPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarFormularios(TfrmCfgLocFis, frmCfgLocFis);
  frmCfgLocFis.strLocFis := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;
  frmCfgLocFis.ShowModal;
  If frmCfgLocFis.ModalResult = MrOk Then
  Begin
    TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := frmCfgLocFis.fGetConfiguracao;
  End;
  FreeAndNil(frmCfgLocFis);
end;

procedure TfrmCfgSistema.btnCRELPCPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmCadImpressaoPedido);
end;

procedure TfrmCfgSistema.btnCfgNsuHosPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmCfgAdquirentesUsaNsuHost);
end;

procedure TfrmCfgSistema.btnCfgSUFIPCPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  TCfgPisCofinsSuframa.pAbreConfiguracao(VS_StrCodEmp);
end;

procedure TfrmCfgSistema.btnBloFilPropertiesOnButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin

  pCriarForm(TfrmConfiguraDadosGiro);
end;

procedure TfrmCfgSistema.btnConAbrCofPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCofSai(Self, edtCodigo, Nil, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
end;

procedure TfrmCfgSistema.btnConDiversosPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqDiversos(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pBtnConCadTpaPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    Try
      Key := '/';
      If fPesqTipoAtendimento(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      Begin
       TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  Finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  End;
end;

procedure TfrmCfgSistema.btnConCatCrmPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    Try


      Key := '/';
      If fPesqCategoriaCRM(Self, edtCodigo, edtDescri, NIl, Key, arrSelecao) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  Finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  End;
end;

procedure TfrmCfgSistema.btnConCidadePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    edtEstado: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);
    edtEstado := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqCidade(Self, edtCodigo, edtDescri, edtEstado, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
  FreeAndNil(edtEstado);
end;

procedure TfrmCfgSistema.btnConMarcasPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqMarcas(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConUnidadePropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    edtSigla_: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);
    edtSigla_ := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqUnidade(Self, edtCodigo, edtDescri, edtSigla_, Nil, Key, arrSelecao) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
  FreeAndNil(edtSigla_);
end;

procedure TfrmCfgSistema.pbtnFornecedoresGenericosButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmFornecedoresGenericos);
end;

procedure TfrmCfgSistema.pbtnFornecedoresTigrePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCriarForm(TfrmFornecedoresTigre);
end;

procedure TfrmCfgSistema.pbtnOpen_RomIprPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pCriarFormularios(TfrmFatRomaneioImpr, frmFatRomaneioImpr);

  With frmFatRomaneioImpr Do
  Begin
    blnConfig := True;
    strConfig := TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue;

    ShowModal;

    If blnGravar Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := strConfig;
  End;

  FreeAndNil(frmFatRomaneioImpr);

end;

procedure TfrmCfgSistema.pbtnOpen_SATCFePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmCfgSATCFe);
end;

procedure TfrmCfgSistema.pbtnOpen_ImpNfiPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pCriarForm(TfrmCfgImpNaoFiscal);
end;

procedure TfrmCfgSistema.pbtnOpen_CodFabrProdAcabPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCriarForm(TfrmCadCodFabrProdAcab);
end;

procedure TfrmCfgSistema.pbtnOpen_CupFisPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pCriarForm(TfrmCfgCupomFiscal, frmCfgCupomFiscal);
end;

procedure TfrmCfgSistema.btnOpen_MensAdicORCPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  Try
    pCriarFormularios(TfrmCfgMensAdicPedidoCompra, frmCfgMensAdicPedidoCompra);
    frmCfgMensAdicPedidoCompra.memMsgAdicional.Lines.Text := fGetConteudoMensagemPedidoCompra('OR');
    frmCfgMensAdicPedidoCompra.ShowModal;
    If frmCfgMensAdicPedidoCompra.blnConfirma then
    begin
      If (cdsCfgSis.Locate('SIS_CODCFG', 'CFG_MSGAOR', []))  Then
      Begin
        strValMsgOrcNov := frmCfgMensAdicPedidoCompra.memMsgAdicional.Lines.Text;
        cdsCfgSis.Edit;
        cdsCfgSis.FieldByName('SIS_VALCFG').AsString :=  strValMsgOrcNov;
        cdsCfgSis.Post;
      End;
    End
  Finally
    FreeAndNil(frmCfgMensAdicPedidoCompra);
  End;
end;

procedure TfrmCfgSistema.btnOpen_MensAdicPEDPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
begin
  Try
    pCriarFormularios(TfrmCfgMensAdicPedidoCompra, frmCfgMensAdicPedidoCompra);
    frmCfgMensAdicPedidoCompra.memMsgAdicional.Lines.Text := fGetConteudoMensagemPedidoCompra('PD');
    frmCfgMensAdicPedidoCompra.ShowModal;
    If (cdsCfgSis.Locate('SIS_CODCFG', 'CFG_MSGAPD', []))  Then
    Begin
      strValMsgPedNov := frmCfgMensAdicPedidoCompra.memMsgAdicional.Lines.Text;
      cdsCfgSis.Edit;
      cdsCfgSis.FieldByName('SIS_VALCFG').AsString :=  strValMsgPedNov;
      cdsCfgSis.Post;
    End;
  Finally
    FreeAndNil(frmCfgMensAdicPedidoCompra);
  End;
end;

procedure TfrmCfgSistema.btnPesquisasOpiniOnePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmListaPesquisaOpiniOne: TfrmListaPesquisaOpiniOne;
begin
  pCriarFormularios(TfrmListaPesquisaOpiniOne, frmListaPesquisaOpiniOne);
  try
    frmListaPesquisaOpiniOne.ShowModal;
    if frmListaPesquisaOpiniOne.ModalResult = mrOk then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := frmListaPesquisaOpiniOne.strHash;
  finally
    pFreeAndNil(frmListaPesquisaOpiniOne);
  end;
end;

procedure TfrmCfgSistema.pbtnOpen_DescProdAcabPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pCriarForm(TfrmCadDescProdAcab);
end;

procedure TfrmCfgSistema.pbtnOpen_GavetaPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  LfrmCfgGavetaImpNaoFiscal : TfrmCfgGavetaImpNaoFiscal;
begin
  pCriarFormularios(TfrmCfgGavetaImpNaoFiscal, LfrmCfgGavetaImpNaoFiscal);
  try
    LfrmCfgGavetaImpNaoFiscal.ShowModal;
  finally
    pFreeAndNil(LfrmCfgGavetaImpNaoFiscal);
  end;
end;

procedure TfrmCfgSistema.cxDadosDBTableView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  var
  CellRect: TRect;
begin
  inherited;

  CellRect := ACellViewInfo.Bounds;

  // Calcula o centro da célula
  FGridClickPoint.X := CellRect.Left + (CellRect.Width div 2);
  FGridClickPoint.Y := CellRect.Top + (CellRect.Height div 2);
  FGridClickPoint := ACellViewInfo.GridView.Site.ClientToScreen(FGridClickPoint);

  //teste
  cxHintStyleController.HideHint;

  If ACellViewInfo.GridRecord.Values[cxDadosDBTableView1SIS_CODCFG.Index] = 'CFG_ETIDIF' Then
  Begin
    cxHintStyleController.ShowHint(Mouse.CursorPos.X, Mouse.CursorPos.Y + 30, 'Informações',
                                   'Esta configuração será utilizada para imprimir etiqueta de produtos ' + //#13#10 +
                                   'que são vendidos em quantidades fora das embalagens já existentes,  ' + #13#10 +
                                   'havendo a necessidade da emissão de etiqueta com embalagem especial ' + //#13#10 +
                                   'conforme esta quantidade vendida.');
  End;
  
end;

procedure TfrmCfgSistema.cxDadosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strCodCfg: String;
begin
  inherited;
  If AViewInfo.GridRecord.IsData And (AViewInfo.GridRecord.Index > -1) Then
  Begin
    strCodCfg := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxDadosDBTableView1SIS_CODCFG.Index]);
    If fGetConfiguracoesSomenteCitel.Contains(strCodCfg) Then
      ACanvas.Brush.Color := shpLegUsoCit.Brush.Color;
  End;
  If Pos(TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName, 'SIS_VALCFG') <= 0 Then
  Begin
    pHighlightCxGrid(ACanvas, AViewInfo, arrPalavrasPesquisar);
    ADone := True;
  End;
end;

procedure TfrmCfgSistema.cxDadosDBTableView1Editing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
  Var
    strCodCfg : String;
begin
  inherited;
  Try
    strCodCfg := cdsCfgSis.FieldByName('SIS_CODCFG').AsString;
  Except
    strCodCfg := EmptyStr;
  End;
  AAllow := fPermitirEditarConfiguracao(strCodCfg);
  pSetarInformacaoOperador(AAllow);
end;

procedure TfrmCfgSistema.cxDadosDBTableView1EditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  pExibeInformacoesClaSub(Sender, AItem);
end;

procedure TfrmCfgSistema.cxDadosDBTableView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DELETE:
    Begin
      If (Pos(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CNDINI_CFG_CNDPTE_CFG_CLIFPG_CFG_SUGEMP') > 0) Then
      Begin
        If fMensagem('','Deseja limpar o valor informado nesta configuração?',['&Sim', '&Não'], 2) = 1 Then
        Begin
          If Not (cdsCfgSis.State = dsEdit) Then
            cdsCfgSis.Edit;
          cdsCfgSis.FieldByName('SIS_VALCFG').AsString := '';
          cdsCfgSis.Post;
        End;
      End
      Else
        pMensagemOk('Não é permitido deletar configurações do sistema!');
    End;
    VK_Escape: btnSair.Click;
  End;
end;

procedure TfrmCfgSistema.btnVerConfClick(Sender: TObject);
  Var
    strVal : Variant;
    strErro: TCaption;
    blnErro: Boolean;
    intCont: Integer;
    stlErro: TStringList;
    prpProp: TcxCustomEditProperties;
begin
  inherited;
  edtPesquisar.Clear;
  cdsCfgSis.Filtered := False;
  Try
    intCont := 0;
    stlErro := TStringList.Create;
    stlErro.Add('           CONFIGURAÇÕES INCORRETAS            ');
    stlErro.Add('***********************************************');
    cdsCfgSis.DisableControls;
    cdsCfgSis.First;

    pgbProgresso.Visible  := True;
    pgbProgresso.Max      := cdsCfgSis.RecordCount;
    pgbProgresso.Position := 0;

    cxDadosDBTableView1.ViewData.Expand(True);

    While Not cdsCfgSis.Eof Do
    Begin
      prpProp := cxDadosDBTableView1.Items[cxDadosDBTableView1SIS_VALCFG.Index].GetProperties(intCont);

      If (prpProp.ClassName = 'TcxMaskEditProperties') Or
         (prpProp.ClassName = 'TcxButtonEditProperties') Or
        ((prpProp.ClassName = 'TcxExtLookupComboBoxProperties') And
         (Not fEmptyStr(TcxExtLookupComboBoxProperties(prpProp).ImeName))) Then
      Begin
        strVal  := cxDadosDBTableView1.Items[cxDadosDBTableView1SIS_VALCFG.Index].EditValue;
        strErro := 'VALID';
        blnErro := False;

        If Not fEmptyStr(VarToStrDef(strVal,'')) Then
        Begin
          If Assigned(TcxCustomEditProperties(prpProp).OnValidate) Then
            TcxCustomEditProperties(prpProp).OnValidate(Sender, strVal, strErro, blnErro);
          
          If blnErro Then
            stlErro.Add(cxDadosDBTableView1.Items[cxDadosDBTableView1SIS_GRUCFG.Index].EditValue + ' - ' +
                        cxDadosDBTableView1.Items[cxDadosDBTableView1SIS_DESCRI.Index].EditValue);
        End;

      End;

      inc(intCont);
      cdsCfgSis.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
    End;

    stlErro.Add('***********************************************');

  Finally

    pgbProgresso.Visible  := False;
    pgbProgresso.Position := 0;

    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines := stlErro;
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCfgSistema.btnVerConfClick]');
      End;
    End;

    pFreeAndNil(frmMemo);

    cdsCfgSis.Filtered := True;

    cxDadosDBTableView1.ViewData.Collapse(True);
    cdsCfgSis.First;
    cdsCfgSis.EnableControls;

    FreeAndNil(stlErro);
  End;

end;

procedure TfrmCfgSistema.pbtnOpen_ReplicacaoPropertiesButtonClick( Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pCriarForm(TfrmCfgReplicacao);
end;

procedure TfrmCfgSistema.btnVerProCodClick(Sender: TObject);
  Var
    qryShowTab : TUniQuery;
    stlNomTab  : TStringList;
    strProCod  : String;
    intContador: Integer;

begin
  inherited;
  edtPesquisar.Clear;
  cdsCfgSis.Filtered := False;
  Try
    strProcod :='';
    stlNomTab := TStringList.Create;
    stlNomTab.Add('  TABELAS NÃO ENCONTRADAS NO VETOR(PROCOD)     ');
    stlNomTab.Add('***********************************************');

    For intContador := 0 To  length(arrProcod) - 1 Do
        strProcod   := strProcod + arrProCod[intContador].strNomArq + '_';

    qryShowTab := fCriaQuery(Self);
    qryShowTab.SQL.Add(' SHOW TABLES ');
    qryShowTab.Open;

    pgbProgresso.Visible  := True;
    pgbProgresso.Max      := qryShowTab.RecordCount;
    pgbProgresso.Position := 0;

    While Not qryShowTab.Eof  Do
    Begin
      If (Pos(qryShowTab.Fields[0].AsString,strProCod)=0)                And
         (LeftStr(UpperCase(qryShowTab.Fields[0].AsString),2) <> 'I_')   And
         (LeftStr(UpperCase(qryShowTab.Fields[0].AsString),3) <> 'TMP')  And
         (LeftStr(UpperCase(qryShowTab.Fields[0].AsString),4) <> 'DEL_') And
         (Pos(qryShowTab.Fields[0].AsString, 'CFGSIS_CNFCHQ_CNFETI_CNF_NF_TABNRE_SEQLOG_APGTMP') <= 0)//FILTRO DE TABELAS QUE NÃO DEVEM APARECER
      Then
          stlNomTab.Add(qryShowTab.fields[0].AsString);

      qryShowTab.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
    End;

    qryShowTab.Close;

    pgbProgresso.Visible  := False;
    pgbProgresso.Position := 0;

    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines := stlNomTab;
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCfgSistema.btnVerProCodClick]');
      End;
    End;

    pFreeAndNil(frmMemo);
    FreeAndNil(qryShowTab);
    FreeAndNil(stlNomTab);
  Finally
    cdsCfgSis.Filtered := True;
  End;

end;


procedure TfrmCfgSistema.pedtValFCustoPropertiesChange(Sender: TObject);
begin
  inherited;

  if cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRMCUS' Then
  Begin
    Try
      pCriarFormularios(TfrmFormulaCalcPCusto,frmFormulaCalcPCusto);
      frmFormulaCalcPCusto.edtTipoFormula.Text := IntToStr(TValidarConfiguracoes.intValAnt);
      frmFormulaCalcPCusto.ShowModal;

      If intTipoFormula <> 0  Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := IntToStr(intTipoFormula);
      End
      Else
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := IntToStr(TValidarConfiguracoes.intValAnt);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCfgSistema.edtValFCustoPropertiesChange]');
      End;
    End;

    pFreeAndNil(frmFormulaCalcPCusto);

  End;

end;

procedure TfrmCfgSistema.cdsCfgSisAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TValidarConfiguracoes.cdsCfgSisAfterOpen(DataSet);
end;

procedure TfrmCfgSistema.cdsCfgSisAfterPost(DataSet: TDataSet);
begin
  inherited;
  TValidarConfiguracoes.cdsCfgSisAfterPost(DataSet);
end;

procedure TfrmCfgSistema.pPesquisarConfiguracoes;
begin
  Try
    Screen.Cursor := crHourGlass;
    cdsCfgSis.Filtered := False;
    cdsCfgSis.Filtered := True;
  Finally
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmCfgSistema.cdsCfgSisAfterScroll(DataSet: TDataSet);

  function fRetCaptionItemRadio(strNomeComponente: String; Index: Integer): String; Overload;
    Var
      rdg: TcxEditRepositoryRadioGroupItem;
  begin
    rdg := TcxEditRepositoryRadioGroupItem(cfgRepositorio.FindComponent(strNomeComponente));

    If Assigned(rdg) Then
      Result := rdg.Properties.Items[Index].Caption;
  end;

  function fRetCaptionItemRadio(strNomeComponente: String; Value: String): String; Overload;
    Var
      idx: Integer;
      rdg: TcxEditRepositoryRadioGroupItem;
  begin
    rdg := TcxEditRepositoryRadioGroupItem(cfgRepositorio.FindComponent(strNomeComponente));

    If Assigned(rdg) Then
      For idx :=0 To rdg.Properties.Items.Count-1 Do
      Begin
        If String(rdg.Properties.Items[idx].Value) = Value Then
          Result := rdg.Properties.Items[idx].Caption;
      End;
  end;

begin

  inherited;
  If DataSet.ControlsDisabled Then
    Exit;

  If (blnIniciandoConfiguracoes) Then
    Exit;

  pExibirBtnCfgEmp;

  pnlInfoCfgSis.Visible := False;
  btnLayout.Visible := (cdsCfgSis.FieldByName('SIS_LAYOUT').AsString = 'S') Or
                       (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_MDORIN');
  pnlInfoCfgSis.Height      := 20;
  pnlInfoCfgSis.Caption     := '';
  pnlInfoCfgSis.Font.Height := 14;
  pnlInfoCfgSis.Font.Color  := clBlack;
  mmoInfoCfgSis.Font.Name   := 'Arial';

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MODFUL') Then
  Begin

    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('No modelo "Movimentar quantidade separada", o sistema irá movimentar exatamente o que foi separado e a nota será apenas para escrituração fiscal.');
    mmoInfoCfgSis.Lines.Add('No modelo "Gerar pedido para "Guardar" as diferenças", o sistema irá movimentar a quantidade que está no xml, gerando operação para guardar a diferença');
    mmoInfoCfgSis.Lines.Add('no estoque ou, no caso de ter separado a menos, movimentar pela "TL" - registro para movimentação de saldo.');
    mmoInfoCfgSis.Lines.Add('');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_INFPCE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa utiliza ''Cadastro de Embalagens'' e não utiliza');
    mmoInfoCfgSis.Lines.Add('tabela de preços do fornecedor.');
    mmoInfoCfgSis.Lines.Add('CFG_CNVEMB - Sistema de conversão de embalagem para unidade: Pelo cadastro de embalagens');
    mmoInfoCfgSis.Lines.Add('CFG_TABPRF - Utilizar cadastro "Fornecedores - Formação de Preços" (Cadastrado de Tabelas de Preços do Fornecedor) ? = NÃO');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ALTEST') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add(' - Quando ativado será aberto rotina para alterar temporariamente os sub-produtos para inclusão na venda,');
    mmoInfoCfgSis.Lines.Add('   não será alterado o cadastro da estrutura original. ');
    mmoInfoCfgSis.Lines.Add('');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ESTMAN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Name := 'Consolas';

    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('Na opção[2], O Sistema deve somar o saldo reservado dos pedidos em aberto oriundos de OS aprovadas com os seguintes status:');
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('FASE               SITUACAO                      COMPLEMENTO');
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('M - Manutenção     EM - Em Manutenção            AM - Ag. Manutenção');
    mmoInfoCfgSis.Lines.Add('                   MF - Manutenção Finalizada    AA - Ag. Armazenamento');
    mmoInfoCfgSis.Lines.Add('                   AR - Armazenada               AF - Ag. Faturamento');
    mmoInfoCfgSis.Lines.Add('R - OS Finalizada  AF - Ag. Faturamento          ER - Equipamento Retirado');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else
  If  SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PDISIF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add(' - Quando esta configuração for ativada, sera´ necessário realizar alteração global de preços com fator 1 no preço de compra,');
    mmoInfoCfgSis.Lines.Add('   e recalcular preço de venda ou margem de lucro, pois esta configuração altera o cálculo do composição do preço do produto.');
    mmoInfoCfgSis.Lines.Add('');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If (SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_APISFS')) Or
     (SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ACOSFS')) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Atenção:');
    mmoInfoCfgSis.Lines.Add('Se a configuração CFG_ZPCCON - Zerar PIS e COFINS no conhecimento de frete quando a Empresa ou o Fornecedor é optante pelo simples nacional? ');
    mmoInfoCfgSis.Lines.Add('estiver ativa, base, valor e aliquota do pis e confis serão zerados.');
    mmoInfoCfgSis.Lines.Add('');
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TIPPRC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add(' - Apenas uma opção pode ser marcada;');
    mmoInfoCfgSis.Lines.Add(' - Quando estiver definido uma opção como padrão, ao escolher outra opção na importação,');
    mmoInfoCfgSis.Lines.Add('   será solicitado senha de liberação.');
    mmoInfoCfgSis.Lines.Add('');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TRCOF2') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, após informar o frete à cobrar e o frete cotado, o faturamento irá fazer uma revalidação da');
    mmoInfoCfgSis.Lines.Add('trava de preço, podendo assim exibir a trava na finalização do documento.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Cálculo:');
    mmoInfoCfgSis.Lines.Add('(( Total do documento (Valor já utilizado atualmente para trava de preço) - frete cotado) < preço mínimo calculado ).');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Essa opção funciona apenas para a opção de "Desconto Máximo por Produto".');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TRCOFR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, após informar a comissão do profissional, o faturamento irá fazer uma revalidação da trava');
    mmoInfoCfgSis.Lines.Add('de preço, podendo assim exibir a trava na finalização do documento.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Cálculo:');
    mmoInfoCfgSis.Lines.Add('(( Total do documento (Valor já utilizado atualmente para trava de preço) - comissão do profissional ) < preço mínimo calculado ).');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Essa opção funciona apenas para a opção de "Desconto Máximo por Produto".');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_OPCCOM') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('*** Desc. por Comissão do Cad. Produtos ***');
    mmoInfoCfgSis.Lines.Add('Exemplos: C = Comissão % | F = Faixa (Acréscimo/Decréscimo)');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('C = 3,00; (%)');
    mmoInfoCfgSis.Lines.Add('F = 1,50;');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Desc. por Comissão do Cad. Produtos:');
    mmoInfoCfgSis.Lines.Add('Comissão Final (C - F) = 2,96 %');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Desc. por Comissão do Cad. Produtos (Antigo):');
    mmoInfoCfgSis.Lines.Add('Comissão Final (C - F) = 1,50 %');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DCHVAR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa utiliza compra e venda de marmores e granito (CFG_MARMOR - Utilizar rotina de compra e venda de mármore e granito?)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SINPDC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada não será sintetizado os produtos que possuem as informações [MOVTRI.DET_NUMCMP] e [MOVTRI.DET_NITCMP] diferentes.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_APLDES') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('Quando ativar a configuração será verificado se o Cliente tem permissão para emitir FF.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Se Cliente marcado "Permitir FF(À Prazo) = N" e "Permitir FF(À Vista) = N":');
    mmoInfoCfgSis.Lines.Add('  - Se o desconto para profissionais for maior que zero, então será aplicado o desconto para profissionais, porém não será permitido alterar. ');
    mmoInfoCfgSis.Lines.Add('  - Se o desconto para profissionais estiver zerado, então será permitido informar o desconto.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Se Cliente marcado "Permitir FF(À Prazo) = S" ou "Permitir FF(À Vista) = S": ');
    mmoInfoCfgSis.Lines.Add('  - Não será aplicado o desconto para profissionais e não será permitido informar.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TIPMOV') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Para usar a segunda opção dessa configuração, as localizações devem ter capacidade máxima informada e o sistema deve estar ');
    mmoInfoCfgSis.Lines.Add('configurado dessa forma:');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('CFG_WMSMOV - Quando utiliza WMS, na separação de mercadorias, utilizar movimentação programada para abastecimento dos PICKINS? = SIM');
    mmoInfoCfgSis.Lines.Add('CFG_WMSPIC - Quando utiliza WMS, na separação de mercadorias utilizar apenas PICKING? = SIM');
    mmoInfoCfgSis.Lines.Add('CFG_MOSPUL - Quando utilizar CFG_WMSPIC = SIM mostrar também lote de pulmão quando a quantidade do picking for menor que a quantidade ');
    mmoInfoCfgSis.Lines.Add('vendida? = NÃO');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ESTMIN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao desativar essa configuração, o sistema irá desconsiderar o estoque mínimo da filial, podendo assim solicitar a transferência');
    mmoInfoCfgSis.Lines.Add('mesmo que o estoque disponível fique abaixo do mínimo quando a transferência for realizada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DEVAUT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração somente pode ser utilizada se existir banco de dados único.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_UTISIN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração o sistema irá exibir o cadastro "Sinaleiro de Faturamento - Faixa de Margem/Markup x Vendedor');
    mmoInfoCfgSis.Lines.Add('para que seja realilizado o cadastro de faixas e habilitará dois sinaleiros no faturamento que irão exibir as cores conforme a faixa cadastrada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End

  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_EMPIMP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A empresa logada só poderá baixar/atualizar arquivos retornos importados por ela mesma.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End

  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DMEFEM') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('No cadastro de operadores existe a opção para marcar se o mesmo deve receber essas mensagens.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_HABCMP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração irá atualizar na etapa de Ativação do Lote de Preços, o campo definido na');
    mmoInfoCfgSis.Lines.Add('CFG_DESADI -  "Descontos Adicionais" - Descrição do campo na composição do preço do produto');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SLRQPE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema irá desconsiderar o saldo em requisição que está vinculado ao pedido de venda e que');
    mmoInfoCfgSis.Lines.Add('ainda não foi atendido da quantidade "Reservado Pedido Venda". Sendo assim, o saldo ficará disponível para faturamento.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DIASIN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('O dia informado nesta configuração será o dia utilizado para corte do mês de apuração. Exemplo: Se for informado o');
    mmoInfoCfgSis.Lines.Add('dia "31", no faturamento o sistema levantará as vendas realizadas a partir do dia 01 do próximo mês até o dia 31.');
    mmoInfoCfgSis.Lines.Add('Se for informado o dia "24", no faturamento o sistema levantará as vendas realizadas a partir do dia 25 do próximo mês até o dia 24.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AGC_CC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se SIM a rotina de agrupamento manual ira considerar agrupar os créditos de acordo com a configuração [CFG_AGP_CC].');
    mmoInfoCfgSis.Lines.Add('Se NÃO a rotina de agrupamento manual ira SEMPRE considerar agrupar os créditos independente da configuração [CFG_AGP_CC].');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DEMCLA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Caso esta configuração não seja informada, o sistema irá utilizar a primeira classificação');
    mmoInfoCfgSis.Lines.Add('da configuração CFG_CLADEM.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PCPRVE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração permite evitar que grandes distorções ocorram sem que exista liberação consciente por senha remota.');
    mmoInfoCfgSis.Lines.Add('Informando zero na configuração, este recurso fica desligado');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End

  Else If (SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CCDPRM')) Or
          (SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CSDPRM')) Then
  Begin
    mmoInfoCfgSis.Clear;

    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    If (SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CCDPRM')) Then
    begin
      pnlInfoCfgSis.Height      := 130;
      mmoInfoCfgSis.Lines.Add('Esta rotina permite informar por fornecedor se haverá ou não cobrança por descarregamento de pallets. No cadastro do produto,');
      mmoInfoCfgSis.Lines.Add('deve ser configurado a quantidade de itens por pallet e o valor cobrado por ele.');
      mmoInfoCfgSis.Lines.Add('No plano de recebimento após a efetivação do movimento fiscal, ao optar em gerar cobrança de descarregamento por pallet, será gerado um pedido de venda');
      mmoInfoCfgSis.Lines.Add('para o cliente informado no cadastro do fornecedor e o item serviço informado na configuração "CFG_CSDPRM".');
    End;

    mmoInfoCfgSis.Lines.Add('"Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:');
    mmoInfoCfgSis.Lines.Add('[CFG_CLIFOR] Permitir vincular Código do Cliente correspondente ao Fornecedor = Sim');
    mmoInfoCfgSis.Lines.Add('[CFG_USASER] Usar Serviço = Sim');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End

  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ITESER') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Também tem a função de receber entrada de mercadorias de notas de serviços ( Serviço Prestado com Crédito de PIS e COFINS )');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SERTER') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Também tem a função de receber entrada de mercadorias de notas de serviços ( Serviço Prestado sem Crédito de PIS e COFINS )');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End



  Else

  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ULEADS') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar essa rotina tambem é necessário ativar a configuração: "CFG_FASOBR"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SOMALG') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando essa configuração for habilitada, antes da geração do produto acabado,');
    mmoInfoCfgSis.Lines.Add('o operador poderá informar a marca e a linha/grupo do produto acabado.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ETRAUT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('É obrigatório uso de banco de dados único, sem replicação.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_UCLVEN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Este cadastro permite vincular mais de um vendedor/supervisor/repositor ao mesmo cliente.');
    mmoInfoCfgSis.Lines.Add('Estas informações serão utilizadas pela FAITH SYSTEM para integração com seu software.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_UTIVMA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Este cadastro relaciona as marcas que cada vendedor pode vender.');
    mmoInfoCfgSis.Lines.Add('Estas informações serão utilizadas pela FAITH SYSTEM para integração com seu software.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AGRLOT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração devera ser utilizada quando habilitado especificamente o');
    mmoInfoCfgSis.Lines.Add('layout de ordem de produção no modelo 5 e rotina de WMS. Verifique com a Citel a');
    mmoInfoCfgSis.Lines.Add('possíbilidade de utilizar esta configuração para sua empresa.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ATUMED') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração, além de atualizar o preço médio e dados da última compra para CFOP de compra,');
    mmoInfoCfgSis.Lines.Add('também atualiza as mesmas informações quando for transferência de estoque proveniente das empresas');
    mmoInfoCfgSis.Lines.Add('do grupo.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UTIDEF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para este recurso ficar disponível na tela de vendas, também é necessário cadastrar a configuração');
    mmoInfoCfgSis.Lines.Add('[CFG_FATCOM] Digitar complemento do produto? com a opção SIM.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TOLETE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração torna obrigatório a efetivação da entrada de mercadorias por transferência');
    mmoInfoCfgSis.Lines.Add('de estoque na empresa, para que o fechamento do caixa seja liberado. Nenhum documento de');
    mmoInfoCfgSis.Lines.Add('transferência de estoque ( NF/TE ) poderá ficar fora da tolerância.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_VRACLI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando este cliente estiver configurado, orçamento e pedido de venda terão');
    mmoInfoCfgSis.Lines.Add('comportamentos otimizados, operando o faturamento em VENDA RAPIDA.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_NSSCPF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração apenas poderá ser habilitada caso a empresa emissora da nota fiscal for');
    mmoInfoCfgSis.Lines.Add('da cidade de São Paulo-SP, pois trata-se de uma particularidade específica desta prefeitura.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_UTIWMS') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('"Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:"');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [ CFG_CTLEST ] Tipo de controle de sub-estoque na mesma loja = POR LOTE.                   ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_CADLOC ] Utilizar cadastro de localizações físicas? = SIM.                           ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_CONFME ] Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA.       ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_USACON ] Utilizar Conferência para Entrada de Mercadorias? = SIM.                    ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_TIPEXP ] Expedição = FATURAMENTO DEPOIS DA EXPEDICAO.                                ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_WMRBTP') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('Se essa configuração for maior que zero, o sistema executará o robô "definição automática de lotes para separação" de forma independente dos demais robôs do sistema e no intervalo aqui definido!');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LOTCRP') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 130;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('"Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:"                                                             ');
    mmoInfoCfgSis.Lines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = SIM.                                                                             ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_WMSLOT ] Quando estiver utilizando rotina WMS, permitir definir no cadastro de produtos, se o produto terá seu lote definido pelo vendedor? = NÃO.');
    mmoInfoCfgSis.Lines.Add('----------------------------------------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_EXDACO') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver "NÃO",');
    mmoInfoCfgSis.Lines.Add('a telinha do consumidor poderá ser acionada pela tecla F12,');
    mmoInfoCfgSis.Lines.Add('que encontra-se no rodapé da tela de vendas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CLIDOP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração for diferente de "Não utilizar", no cadastro de clientes irá exibir um campo na aba "Complementos".');
    mmoInfoCfgSis.Lines.Add('Caso esteja na opção "Utilizar, de forma complementar...", as "Despesas Operacionais Complementar" serão somadas ao valor das');
    mmoInfoCfgSis.Lines.Add('despesas operacionais do produto no cálculo do preço de custo dos documentos de venda!"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CORRES') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar este recurso, será possível definir no cadastro de clientes um cliente correspondente para cada cliente.');
    mmoInfoCfgSis.Lines.Add('Quando um cliente que tem cliente correspondente cadastrado for digitado na tela de vendas, o sistema informará');
    mmoInfoCfgSis.Lines.Add('ao vendedor e trocará o cliente para o cliente correspondente, na qual será feita a venda.');
    mmoInfoCfgSis.Lines.Add('Este recurso é utilizado para centralizar as vendas em um determinado cliente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ITECCR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver NAO, todos os produtos estrutura são considerados ITEM CONCRETO.');
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver SIM, será habilitado um campo no cadastro de produtos para identificar');
    mmoInfoCfgSis.Lines.Add('se o produto é concreto, tormando possível diferenciar FCK de ARGAMASSA, onde ambos sao estruturas,');
    mmoInfoCfgSis.Lines.Add('mas apenas produtos FCK deverão se comportar como ITEM CONCRETO.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MODCOC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A impressão de Conta Corrente MODELO 2 só será utilizada se, e somente se,');
    mmoInfoCfgSis.Lines.Add('o sistema estiver configurado para utilizar Desconto para Profissionais.');
    mmoInfoCfgSis.Lines.Add('Procure pela configuração: "Utilizar desconto para profissionais (Autopeças)"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_FREDEV') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Ao escolher a opção "VALOR CONTÁBIL DA NOTA FISCAL E PARA O FRETE CONSIDERAR O TIPO DE FRETE DO DOCUMENTO QUE ESTÁ SENDO DEVOLVIDO",');
    mmoInfoCfgSis.Lines.Add('então na emissão da devolução o sistema vai verificar o tipo de frete do documento devolvido para considerar ou não o');
    mmoInfoCfgSis.Lines.Add('valor do frete no crédito que será gerado no financeiro.');
    mmoInfoCfgSis.Lines.Add('SE O TIPO DO FRETE FOR DESTINATÁRIO(FOB) OU TRANSPORTE PRÓPRIO DESTINATÁRIO, O VALOR DO FRETE SERÁ SOMADO AO CRÉDITO.');
    mmoInfoCfgSis.Lines.Add('SE O TIPO DO FRETE FOR EMITENTE(CIF), TERCEIROS, SEM FRETE OU TRANSPORTE PRÓPRIO REMETENTE, O VALOR DO FRETE NÃO SERÁ SOMADO AO CRÉDITO.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';

  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_EXLEND') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração é necessário estar com o sistema configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS - Utilizar WMS ( Sistema de Gerenciamento de Armazém )?  = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP - Tipo de expedição = 4(pedido)]');
    mmoInfoCfgSis.Lines.Add('[CFG_TPLREC - Quando utiliza WMS como será feito o Plano de Recebimento?] = R/C');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_VEMACS') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração é necessário estar com o sistema configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIVMA] - Utilizar cadastro de Vendedores - Marcas?  = SIM');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_FATCNS') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração é necessário estar com o sistema configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerenciamento de Armazém )?  = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_SOLOLA] - Solicitar local de armazenamento por local de separação na rotina de separação? = SIM');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SUGCAP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração é necessário estar com o sistema configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_SUGPIC] - Sugerir uma localização picking na rotina "Guardar Vendas Cancel./Devol."  = SIM');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DFPSSL') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração é necessário estar com o sistema configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_ROMLOT] - Utilizar rotina de lote de separação para antecipar inclusão dos romaneios ?  = SIM');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TCOPRO') And
          SameText(cdsCfgSis.FieldByName('SIS_VALCFG').AsString, '4'         ) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração não alimenta automaticamente a comissão de profissionais pelo');
    mmoInfoCfgSis.Lines.Add('faturamento, ou seja, a negociação é realizada diretamente com o profissional');
    mmoInfoCfgSis.Lines.Add('e inserida manualmente na manutenção da comissão do profissional.');
    mmoInfoCfgSis.Lines.Add('Esta configuração desconsidera as configurações: ');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPCOM]-Tipo de comissão para profissionais ');
    mmoInfoCfgSis.Lines.Add('[CFG_ORIPRO]-Origem da comissão de profissionais ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RCXTCC') And
     (cfgRepositorio.rdgTrChCa_1_2.Properties.ReadOnly)           Then
  Begin
    pnlInfoCfgSis.Font.Color  := clRed;
    pnlInfoCfgSis.Font.Height := 16;
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SIULCO' Then
  Begin
    pnlInfoCfgSis.Font.Color  := clRed;
    pnlInfoCfgSis.Font.Height := 16;

    pnlInfoCfgSis.Caption := 'Esta configuração não se aplica para transferências de mercadorias. ' +
                             'Quando estiver desligada, somente produtos com IPI de Saída serão afetados, pois são eles que tem crédito/débito de IPI.';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_USACTF' Then
  Begin
    pnlInfoCfgSis.Font.Color  := clRed;
    pnlInfoCfgSis.Font.Height := 16;

    pnlInfoCfgSis.Caption := 'Caso utilize esta configuração, preencha a aba "Plano de Contas" do ' +
                             'Cadastro do Fornecedor.';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EMPFVN') Or
          (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENSF11') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('ATENÇÃO: Esta configuração não pode ser utilizada com Replicação.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CNDEMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Caso informada a condição de pagamento "a vista", o sistema irá desconsiderar as travas de cliente.');
    mmoInfoCfgSis.Lines.Add('Caso informada a condição de pagamento "a prazo", o sistema irá considerar as travas de cliente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';    
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_HEFCOE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando habilitada esta configuração, ao realizar uma venda com entrega futura, será emitido');
    mmoInfoCfgSis.Lines.Add('o documento com CFOP de venda (EX.:5102,5405) ao invés do CFOP 5922, e o controle de baixas será');
    mmoInfoCfgSis.Lines.Add('obrigatoriamente feito pela emissão de FF (apenas para controle de entregas)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_INOBSF') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Os relatórios de livros fiscais anteriores à data informada na configuração não farão a');
    mmoInfoCfgSis.Lines.Add('verificação dos cadastros das reduções z do(s) ecf(s) pois já existe movimento no caixa!');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CVIPIA') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Setar esta configuração para NÃO caso seja necessário realizar ajustes de centavos');
    mmoInfoCfgSis.Lines.Add('no valor do IPI nos itens, quando editados no livro fiscal. Verificar também');
    mmoInfoCfgSis.Lines.Add('a tolerância máxima para diferença entre Base IPI x Alq. IPI e o valor digitado.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TDFIPI') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando o cálculo do IPI nos itens do livro fiscal não for calculado automático, ');
    mmoInfoCfgSis.Lines.Add('este valor indica a tolerância máxima para a diferença entre');
    mmoInfoCfgSis.Lines.Add('a Base IPI x Alq IPI do item e o valor do IPI do item digitado pelo usuário.');
    mmoInfoCfgSis.Lines.Add('É recomendado manter este valor o mais baixo possível, para evitar distorções');
    mmoInfoCfgSis.Lines.Add('nos valores de IPI.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_NCDP11') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando habilitada esta configuração, caso o Faturamento/Recebimento seja ');
    mmoInfoCfgSis.Lines.Add('realizado através do F11 do resumo de caixa, será considerado como portador ');
    mmoInfoCfgSis.Lines.Add('da baixa o da configuração "CFG_PORRCX"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ALVECO') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente nos casos onde não existe');
    mmoInfoCfgSis.Lines.Add('script noturno para cálculo de comissão');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AB2GAV') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Habilitar somente se não utiliza cupom fiscal, "NFC-E/SAT" ou "Impressora fiscal"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ALTARM') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração permitirá o usuário escolher outro armazém nas telas de Faturamento (frmFatVendas).');
    mmoInfoCfgSis.Lines.Add('Ex.: Pedido, Orçamento, VN, Outras Saídas, etc.');
    mmoInfoCfgSis.Lines.Add('Porém ainda assim, será obrigatório informar um armazém caso o item possua armazéns.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MMDTPR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height    := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para nao considerar o item promocional na trava, as seguintes regras deverão ser obedecidas: ');
    mmoInfoCfgSis.Lines.Add('1) O valor do preço praticado do item promocional deve ser maior ou igual ao preço da promocao. ');
    mmoInfoCfgSis.Lines.Add('2) [CFG_MAGRVN]-Exibir margem gráfica no rodapé da tela de vendas, quando utilizar trava de ');
    mmoInfoCfgSis.Lines.Add('                preço por margem minima por documento? = ( SIM ) ');
    mmoInfoCfgSis.Lines.Add('3) [CFG_TRADES]-Opção de trava de preço de produto: = ( Margem Minima por Documento ) ');
    mmoInfoCfgSis.Lines.Add('4) [CFG_EDIUNP]-Alterar o valor unitário de produtos em promoção? = ( NAO ) ');
    mmoInfoCfgSis.Lines.Add('5) [CFG_PROPRE]-Quando produto em promoção, trazer preço de sugestão: = ( PREÇO DE PROMOCAO ) ');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PCBCFF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Este percentual será aplicado sobre o valor dos produtos dos Faturamentos Futuros [FF],');
    mmoInfoCfgSis.Lines.Add('antes de calcular a comissão do profissional.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ITECND' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração irá habilitar novo Cadastro "Produtos x Condição de Pagamento", onde será possível');
    mmoInfoCfgSis.Lines.Add('amarrar as condições permitidas por Linha/Grupo. Caso não seja amarrada a linha em nenhuma condição,');
    mmoInfoCfgSis.Lines.Add('o sistema irá considerar que esta linha tem permissão a todas as condições de pagamento.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FECZER' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Caso esta configuração esteja "SIM", será permitido fechar o caixa somente com saldo final zero, ou seja,');
    mmoInfoCfgSis.Lines.Add('se todas as modalidades de pagamento estiverem zeradas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_EDUNFI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando transferência entre lojas, esta configuração permitirá a alteração do preço sugerido.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CNDPRA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se caso a configuração CFG_USATPC = "S", e houver condição de pagamento associado ao "Tipo de Cliente", esta');
    mmoInfoCfgSis.Lines.Add('configuração será anulada pois o sistema irá considerar as condições de pagamentos associado ao "Tipo de Cliente".');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PORPGR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    mmoInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Os portadores para esta configuração devem estar com os campos: "Permitir Baixa CTP/CTR/CHQ/CAR?" e ');
    mmoInfoCfgSis.Lines.Add('"Permitir Movimento Bancário?" marcados em seu cadastro.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LAYREC') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('"ATENÇÃO: O RECIBO É SEMPRE IMPRESSO EM TAMANHO FIXO EM MEIA FOLHA A4."');
    mmoInfoCfgSis.Lines.Add('Para a configuração "FOLHA A4 COM PICOTE NO MEIO", as vias serão impressas na metade da folha');
    mmoInfoCfgSis.Lines.Add('Para a configuração "FOLHA A4 COMUM", as vias serão impressas em sequência, sem considerar o espaço até metade da folha.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_OCCOPD') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 105;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add(' Esta ocorrência será utilizada para Corte de Pedido de Venda, quando estiver utilizando uma das duas ');
    mmoInfoCfgSis.Lines.Add(' configurações informadas abaixo: ');
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [CFG_UTIPEN] Utilizar rotina que define se "Gera Pendência de Pedido de Venda" no faturamento? = SIM ');
    mmoInfoCfgSis.Lines.Add('* [CFG_PENTRA] Gerar pendência nos pedidos de transferência de estoque quando estiver sendo faturado? = NAO ');
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_USRASE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add(' Para este recurso ficar disponível na tela de serviços, também é necessário cadastrar as configurações: ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [CFG_AUTCEN] Utilizar Rotinas de Autocenter? = SIM ');
    mmoInfoCfgSis.Lines.Add('* [CFG_BTDISE] Permitir a digitação dos serviços antes do fechamento da Venda? = NÃO ');
    mmoInfoCfgSis.Lines.Add('* [CFG_ACOSER] Acompanhamento de Serviços realizado pelo: = Pedido de Venda (PD) ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRIEST' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando estiver habilitada, esta configuração fará o faturamento tributar todos os produtos na ');
    mmoInfoCfgSis.Lines.Add('alíquota do estado, praticando CST 000 para todos eles, quando vendidos para fora do estado, ');
    mmoInfoCfgSis.Lines.Add('para não contribuintes (CPF ou CNPJ sem inscrição estadual).');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_BRIDIV') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver "SIM", o sistema permitirá emitir BRINDES somente para clientes');
    mmoInfoCfgSis.Lines.Add('que estiverem cadastrados no Cadastro de Diversos e com o "Código do Profissional no Cadastro  de');
    mmoInfoCfgSis.Lines.Add('Clientes" cadastrado, ou seja, não será permitido emitir BRINDES para clientes consumidores. Deve');
    mmoInfoCfgSis.Lines.Add('ser utilizada por empresas que concedem BRINDE somente para profissionais.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MLJNPD') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando estiver utilizando a configuração "[CFG_EMPFAT] Solicitar empresa de faturamento nos itens da tela');
    mmoInfoCfgSis.Lines.Add('de orçamento/pedido ?" = SIM, através desta configuração será possível gravar o numero do pedido de venda');
    mmoInfoCfgSis.Lines.Add('original, no momento que o operador finalizar o pedido e gerar todos os pedidos conforme empresas informadas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SMSCTR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Este recurso está disponível apenas quando utiliza-se a configuração [CFG_USAGAG] Utilizar "Geração de');
    mmoInfoCfgSis.Lines.Add('Duplicatas à Receber (AG)" e "Geração de Nota de Débito (AG)" ? = SIM.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_USPRRO') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta opção não solicitará dados da transportadora, motorista e veículo, e não emitirá');
    mmoInfoCfgSis.Lines.Add('o relatório oficial do romaneio. Nesta rotina será listado apenas a prévia do romaneio.');
    mmoInfoCfgSis.Lines.Add('Na rotina de "Ativação do Pré-Romaneio", serão solicitadas as informações citadas aqui');
    mmoInfoCfgSis.Lines.Add('e será emitido o relatório final do romaneio.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ALTCLA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver "NÃO", o sistema não permitirá');
    mmoInfoCfgSis.Lines.Add('alterar as Classificações Fiscais (se já estiverem preenchidas)');
    mmoInfoCfgSis.Lines.Add('na tela "Dados Fiscais" nos documentos dos tipos VN, VS, CP, OV, CF e CT.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RMCCLF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Exibe movimentações referentes a "Clientes Filial" quando o relatório é emitido pela tela de faturamento (Opções: F9, Alt+F11, Alt+F12).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FATCLF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('São considerados nos relatórios de Faturamento as vendas realizadas para clientes filiais,');
    mmoInfoCfgSis.Lines.Add('ou seja, Transferências de Estoque que foram emitidas com CFOP de Venda (CFG_CLAVEN)');
    mmoInfoCfgSis.Lines.Add('Essa alteração afeta somente relatórios construídos no Editor de Relatórios e que utilizam');
    mmoInfoCfgSis.Lines.Add('os templates padrões.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_COENRE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, o sistema não permite a seleção de documentos "Entrega" com documentos "Retira" nas rotinas:');
    mmoInfoCfgSis.Lines.Add('Confirmação de Documentos, Confirmação de Transferência de Estoque, Confirmação de Cupom Fiscal.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SINCNF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Somente serão sintetizados automaticamente, documentos onde o contas a receber esteja totalmente aberto ou quitado.');
    mmoInfoCfgSis.Lines.Add('Devoluções referentes a mais de um documento, também não serão sintetizadas automaticamente.');
    mmoInfoCfgSis.Lines.Add('Caso o sistema não consiga sintetizar, as devoluções serão destacadas com legenda específica na tela de confirmação.');
    mmoInfoCfgSis.Lines.Add('Clicando com o botão direito do mouse, o usuário poderá ver os documentos relacionados à devolução.');
    mmoInfoCfgSis.Lines.Add('Também não ocorrerá sintetização quando o usuário filtrar por espécie ou apenas um documento mesmo que este tenha devolução e também,');
    mmoInfoCfgSis.Lines.Add('eventuais documentos de devolução fora do intervalo de datas (quando informado). Nestes casos, o sistema exibirá um aviso ao usuário.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + ''
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TABPAD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao inserir clientes ou condições de pagamento, o sistema traz como sugestão a tabela de preço definida nesta configuração.');
    mmoInfoCfgSis.Lines.Add('Na condição de pagamento, a tabela de preço fica visível se a configuração "CFG_TBPCND - Utilizar tabela de preço por condição de pagamento?" estiver habilitada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_POPTIN' Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 140;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ');
    mmoInfoCfgSis.Lines.Add('| Para a configuração "CFG_POPTIN" surtir o efeito desejável no sistema, os parâmetros "CFG_EXIDOC", "CFG_USATMQ", "CFG_ORD_OR" e  "CFG_ORD_PD" devem estar configurados conforme exemplo abaixo:| ');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ');
    mmoInfoCfgSis.Lines.Add('*                                                                                                                                                                                                * ');
    mmoInfoCfgSis.Lines.Add('* [CFG_EXIDOC] Tipo de documentação para exibição na formulação de tinta de máquina : "Orçamentos/Pedidos/Ordem de Produção Avulsa" , "Orçamentos" , "Pedidos", "Ordem de Produção Avulsa"       * ');
    mmoInfoCfgSis.Lines.Add('*                                                                                                                                                                                                * ');
    mmoInfoCfgSis.Lines.Add('* [CFG_USATMQ] Usar Tinta de Máquina : "Sim"                                                                                                                                                     * ');
    mmoInfoCfgSis.Lines.Add('*                                                                                                                                                                                                * ');
    mmoInfoCfgSis.Lines.Add('* [CFG_ORD_OR] Utilizar ordem de produção para Tinta de Máquina - Orçamento: "SIM"                                                                                                               * ');
    mmoInfoCfgSis.Lines.Add('*                                                                                                                                                                                                * ');
    mmoInfoCfgSis.Lines.Add('* [CFG_ORD_PD] Utilizar ordem de produção para Tinta de Máquina - Pedido: "SIM"                                                                                                                  * ');
    mmoInfoCfgSis.Lines.Add('*                                                                                                                                                                                                * ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENTABA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, ao faturar um Pedido de Entrega Futura (CFOP 5922/6922) pelo F11 do Resumo');
    mmoInfoCfgSis.Lines.Add('de Caixa, o sistema gera automaticamente um pedido para a Empresa CD solicitando o abastecimento dos itens. A Empresa');
    mmoInfoCfgSis.Lines.Add('CD é definida na configuração: "CFG_EMP_CD - Código da Empresa C.D.". O pedido será gerado conforme regras definidas ');
    mmoInfoCfgSis.Lines.Add('no cadastro de empresas (Configuração de Transf. de Estoque e Configurações Financeiras) e ficará visível na Expedição do CD.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RECEMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, as Faixas de Comissão presentes no caminho (Relatórios -> Relatórios de Faturamento ');
    mmoInfoCfgSis.Lines.Add('-> Comissões -> Comissão por Faixa de Recebimento -> Faixa de Recebimento para Comissão de Vendedores) passam a ser por empresa, ');
    mmoInfoCfgSis.Lines.Add('bem como o relatório e todos os locais que utilizam este percentual de comissão.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SABUTI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Configuração utilizada para determinar a representação do sábado em cálculos de metas.');
    mmoInfoCfgSis.Lines.Add('Utilizam essa configuração: "Cadastro de Empresas" (Aba Metas), "Relatório de Metas por Vendedor/Representante - Faturamento"');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DOMUTI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Configuração utilizada para determinar a representação do domingo em cálculos de metas.');
    mmoInfoCfgSis.Lines.Add('Utilizam essa configuração: "Cadastro de Empresas" (Aba Metas), "Relatório de Metas por Vendedor/Representante - Faturamento"');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXIDOC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('"VENDAS DIRETAS" SE REFEREM AS VENDAS EMITIDAS DIRETAMENTE PELO VENDA NORMAL SEM ORIGINAR DE UM ORÇAMENTO/PEDIDO. ');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LIMSEN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração tem efeito quando não é utilizado digitador no faturamento (CFG_USADIG). Ao carregar');
    mmoInfoCfgSis.Lines.Add('um pedido ou orçamento e alterar o vendedor, o sistema exibe uma trava solicitando a liberação para');
    mmoInfoCfgSis.Lines.Add('esta alteração. Se o operador não possuir acesso e abortar, o sistema não irá mais retornar a senha');
    mmoInfoCfgSis.Lines.Add('do vendedor anterior. Desta forma, apenas o vendedor do pedido poderá realizar as devidas alterações.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_RESPOP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('Na opção SOMAR, o relatório deve somar todas as quantidades separadadas.');
    mmoInfoCfgSis.Lines.Add('EX( SOMAR  ): 20 Produtos A / 2 Produtos B / 15 Produtos C = 37 Produtos');
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('Na opção CONTAR, o relatório deve contas os produtos separados.');
    mmoInfoCfgSis.Lines.Add('EX( CONTAR ): 20 Produtos A / 2 Produtos B / 15 Produtos C =  3 Produtos');
    mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CXAEXP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando a configuração está setada na primeira opção (Primeiro receber e liberar pelo caixa [ ALT+L ], depois expedir o documento pela ');
    mmoInfoCfgSis.Lines.Add('expedição), para os documentos a prazo, é preciso efetuar a liberação pelo caixa somente se a primeira parcela for uma entrada à vista.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ESPCAR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração só será utilizada se a configuração ');
    mmoInfoCfgSis.Lines.Add('[CFG_IMPCAR] Quando configurado que utiliza Sistema de Crediário, imprimir contrato e carnê de pagamento automaticamente? estiver com a opção SIM.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (Pos(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_OPSOAB_CFG_SOLITE_') > 0) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao usar CFG_OPSOAB: '+fRetNomCfg('CFG_OPSOAB')+' = "No Pedido" ou "Somente Venda Normal" com CFG_SOLITE:'+fRetNomCfg('CFG_SOLITE')+' = SIM, ');
    mmoInfoCfgSis.Lines.Add('a CFG_SLD_VN: '+fRetNomCfg('CFG_SLD_VN')+' deve ser "Avisar" ou "Travar", para que a tela de abastecimento seja aberta!');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CALSUB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se a configuração CFG_IPSTMF - Calcular IPI e ST para documentos com especie MI/FF? estiver setada em "Não" e na emissão do pedido o tipo de faturamento escolhido for B - MI/FF, ');
    mmoInfoCfgSis.Lines.Add('o sistema irá zerar a substitução tributária independentemente desta configuração.');
    mmoInfoCfgSis.Lines.Add('Obs: Nos orçamentos, a ST será calculada normalmente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_AMZSFA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, ao importar os pedidos, o sistema define AUTOMATICAMENTE o Armazém ou o Lote para os itens do pedido.');
    mmoInfoCfgSis.Lines.Add('É definido aquele que possui maior saldo de estoque.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CUPNOT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração quando utilizada na opção Cupom + Cupom, só poderá ser usada quando a configuração');
    mmoInfoCfgSis.Lines.Add('[CFG_USNFCE] NFCe: Utilizar? estiver com a opção NÃO.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_POCAS2' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Este portador será utilizando quando a configuração "CFG_FINMNO - Na expedição, quando faturar um pedido em nota especial pela quantidade, ');
    mmoInfoCfgSis.Lines.Add('seguir o seguinte procedimento quanto à gravação do financeiro:" estiver setada na segunda opção.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ETRF11' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Permite a troca da transportadora na "Confirmação de Orçamentos", mesmo que, não seja "Cliente Consumidor" ou que "CFG_ECLF11" esteja igual a "Não"');
    mmoInfoCfgSis.Lines.Add('Se a transportadora for alterada, o sistema não irá recalcular o frete do Pedido/Orçamento. Será mantido o valor de frete original.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PROCTR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando marcado "Apagar o Contas a Receber do Cupom Fiscal e gravar o da Nota Fiscal" o sistema só se comportará desta forma se o Contas a Receber do documento original estiver em aberto.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DESF11' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao desabilitar esta configuração, se o operador for adicionar itens em um pedido/orçamento que possua desconto, o sistema ao fechar a venda, irá exibir a tela de desconto mas não vai permitir alterações.'); 
    mmoInfoCfgSis.Lines.Add('O desconto não será rateado entre os itens inseridos através do F3 exceto se o "Operador do Caixa" tiver o Direito de Acesso: "Quando CFG_DESF11 = NÃO, aplicar desconto dado no pedido/orçamento sobre itens de check-out (F3 do F11)?"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VALFOR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver habilitada, será possível informar a data de validade do preço no cadastro de cada produto,');
    mmoInfoCfgSis.Lines.Add('de forma que a rotina de venda não permitirá operação de venda com produtos com data de validade de preço vencida.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PDVIME') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando habilitada esta configuração, o sistema irá permitir informar diferentes datas de entrega');
    mmoInfoCfgSis.Lines.Add('imediata para itens da venda, realizando o desmembramento em um pedido para uma das datas, com');
    mmoInfoCfgSis.Lines.Add('seus respectivos itens, caso condição de pagamento a prazo. Caso condição de pagamento à vista,');
    mmoInfoCfgSis.Lines.Add('o desmembramento será realizado no F11 do resumo de caixa.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UGPDTE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando habilitada esta configuração, o sistema irá permitir informar diferentes datas de entrega');
    mmoInfoCfgSis.Lines.Add('imediata para itens da venda, realizando o desmembramento em um pedido para uma das datas, com');
    mmoInfoCfgSis.Lines.Add('seus respectivos itens, independente da condição de pagamento.');
    mmoInfoCfgSis.Lines.Add('Para cada Pedido que será gerado deverá ser informado uma rota - [CFG_REGCID - Utilizar controle de rotas por Regiões/Cidades?]');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (Not fEmptyStr(strUsaTipExpLocal)) And SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TIPEXP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('ATENÇÃO: Essa estação está usando "Tipo de Expedição: '+strUsaTipExpLocal+'" definido por arquivo local. Portanto não será considerado o valor definido em CFG_TIPEXP.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_AMTPRO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando a configuração está habilitada, ao aumentar o valor unitário do produto, não será considerada a quantidade limite consumida da promoção.');
    mmoInfoCfgSis.Lines.Add('Este processo só ocorre quando a configuração "CFG_PROPRE - Quando produto em promoção, trazer preço de sugestão estiver na opção" = "Preço de Promoção".');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_APERET' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, obrigatoriamente deverá ser utilizadas as configurações: CFG_TR1DES = "N" e CFG_ENTFAT = "S".');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DTPDCR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Quando habilitada esta configuração, não será permitido utilizar condição de pagamento diferente de Fora "Nenhum" e Fora "Outros"');
    mmoInfoCfgSis.Lines.Add('Também não será permitido utilizar dia Fixo ou Semanal do cadastro do Cliente"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CNDPTE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Esta configuração sobrepõe as condições de pagamento que estão vinculadas ao cliente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RCXSDM' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, é importante utilizar o controle do resumo de caixa por operador.');
    mmoInfoCfgSis.Lines.Add('Quando estiver ZERO, o sistema entenderá que não utiliza este recurso.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ESCEMB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Ao habilitar esta configuração, quando o vendedor informar o código de um produto que possua mais que uma embalagem cadastrada, o');
    mmoInfoCfgSis.Lines.Add('sistema irá exibir uma tela onde o usuário poderá escolher qual embalagem ele deseja utilizar na venda.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UTNUPV' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao habilitar esta configuração, será possível informar no pedido de compra o número e a data de entrega');
    mmoInfoCfgSis.Lines.Add('de um determinado pedido de venda. Quando a entrada de mercadorias for realizada e tiver vinculo com este');
    mmoInfoCfgSis.Lines.Add('pedido de compra, o vendedor do pedido de venda receberá uma mensagem do sistema, informando que a compra');
    mmoInfoCfgSis.Lines.Add('foi efetuada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_MINIMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Caso a soma dos impostos IRPJ / PIS / COFINS / CSLL for menor que o valor mínimo informado nesta configuração, o sistema não tributará nada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRCLTB') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração só será aplicada quando o sistema estiver configurado para permitir selecionar tabela de');
    mmoInfoCfgSis.Lines.Add('preços no faturamento ou por item, sendo:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SUGTBP] Permitir selecionar tabela de preços no faturamento? = (SIM)');
    mmoInfoCfgSis.Lines.Add('ou...');
    mmoInfoCfgSis.Lines.Add('[CFG_TABITE] Definir a Tabela de Preços por Item no Faturamento? = (SIM)');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('e a configuração (CFG_UTAPTB - Utilizar apenas uma tabela de preço no faturamento "esta configuração ignora ');
    mmoInfoCfgSis.Lines.Add('todas as outras configurações sobre sugestão de tabela"). ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VMINFC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema habilitará dois novos campos no cadastro de clientes para que');
    mmoInfoCfgSis.Lines.Add('possam ser informados os valores mínimos para emitir nota de entrega e retira. Se houver valor preenchido');
    mmoInfoCfgSis.Lines.Add('nestes campos, o sistema vai efetuar a trava de acordo com o cadastro do cliente. Senão, a trava será efetuada');
    mmoInfoCfgSis.Lines.Add('através dos valores definidos nas configurações [CFG_VALMNF] e [CFG_VLMNFR].');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BXLCSP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização das seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SEPSET] Imprimir separação por setor? = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_GRUSEP] Imprimir separação por setor, onde o setor será definido: = "Por Local de Separação"');
    mmoInfoCfgSis.Lines.Add('[CFG_BAISEP] Utilizar módulo de impressão e baixa da separação? = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP] Expedição = [2]Faturamento antes da expedição, [3]Faturamento depois da expedição ou [4]Pedido - O pedido não será faturado');
    mmoInfoCfgSis.Lines.Add('[CFG_EXPPAR] Expedição Parcial (Esta configuração se aplica para Expedição antes e depois da Venda) = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_BAIAVI] Baixar duplicata caso seja à vista pela Venda Normal e Expedicão? (NÃO GRAVA AUTOMATICAMENTE O CAIXA, CASO SEJA NÃO) = "NÃO"');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXPECO') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 75;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa configuração sugere o valor para o campo "Exportação para E-Commerce" da aba "E-Commerce" do "Cadastro de Produtos"');
    mmoInfoCfgSis.Lines.Add('[Original]: Nas inclusões diretas (Incluir/Gravar) o campo será marcado como "N". Nas inclusões através da opção "Herança de Itens" o campo herdará a mesma marcação do produto original.');
    mmoInfoCfgSis.Lines.Add('[Sempre "Sim"]: O campo será marcado como "S" tanto na inclusão direta quanto na utilização de herança.');
    mmoInfoCfgSis.Lines.Add('[Sempre "Não"]: O campo será marcado como "N" tanto na inclusão direta quanto na utilização de herança.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TPBXCE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 75;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Opção 1 - Operação cega: Nesta opção, o operador só consegue visualizar os documentos envolvidos na entrega se possuir direito de acesso liberado no botão "[F5] - Mostrar Doc. Pendentes".');
    mmoInfoCfgSis.Lines.Add('Ele só conseguirá marcar o documento se digitar sua chave (número + espécie + empresa) ou se bipar o código de barras - Definido na configuração "CFG_TPDCEN -'+fRetNomCfg('TPDCEN')+'".');
    mmoInfoCfgSis.Lines.Add('Opção 2 - Operação rápida: Nesta opção, o operador conseguirá visualizar os documentos que estão vinculados à entrega e poderá marcar todos documentos, apenas pressionando [Enter] sobre uma "Entrega" ou sobre um "Documento" de uma "Entrega".');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_USGURE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 75;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_TR1DES] Travar para permitir apenas 1 destino no faturamento (Retira/Entrega) = ( SIM )');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VENBRI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está ativa, os Produtos de Brinde não serão desmembrados dos demais Produtos. ');
    mmoInfoCfgSis.Lines.Add('Será gerado um único documento de venda, com os Produtos de Brinde e Produtos Normais.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TEPREV') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('*** Essa configuração só será utilizada nos casos onde o "Preço de Transferência" não for');
    mmoInfoCfgSis.Lines.Add('informado no Cadastro de Empresas aba: "Configuração de Transf. de Estoque"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ROPDFI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao desabilitar essa configuração, o sistema passará a validar a situação financeira dos pedidos.');
    mmoInfoCfgSis.Lines.Add('Pedidos à vista que ainda não tem adiantamento ou ainda não foram recebidos, por exemplo, não serão listados.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXIDES' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Ao desabilitar esta configuração, será permitido apenas digitar desconto em percentual no faturamento.');
    mmoInfoCfgSis.Lines.Add('O campo para digitação de desconto em valor ficará desabilitado.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLASER') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 126;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização das seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SIMPAU] Optante por simples nacional? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('[CFG_USASER] Usar serviço? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Configuração utilizada somente para apuração do Resumo de Impostos do Simples Nacional.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If Pos(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, consCFGSQueValidaIMG) > 0 Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Caso a imagem não esteja sendo exibida na impressão, verifique se a mesma está corrompida, abrindo pelo visualizador de imagens do Windows.');
    mmoInfoCfgSis.Lines.Add('Caso ela esteja corrompida, indique uma imagem válida e de LogOff/LogOn no sistema para que a mesma possa ser recarregada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRECOR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Indica o código dos Correios na Frenet.');
    mmoInfoCfgSis.Lines.Add('Como na Frenet pode haver dois códigos COR (um para Sedex e outro para PAC), caso você tenha no Cadastro de Transportadora');
    mmoInfoCfgSis.Lines.Add('Sedex e PAC, coloque no campo "Código da Transportadora pela Frenet:" o código COR, de ambas.'); 
    mmoInfoCfgSis.Lines.Add('Na descrição, garanta que tenha a palavra coresponde a modalidade, em qualquer parte do texto, ex:'); 
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('CORREIOS PAC');
    mmoInfoCfgSis.Lines.Add('CORREIOS SEDEX');
    mmoInfoCfgSis.Lines.Add('TRANSPORTADORA PAC');
    mmoInfoCfgSis.Lines.Add('TRANSPORTADORA SEDEX');
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('Dessa forma o Autcom saberá diferenciar entre os dois códigos COR, desde que tenha a palavra Sedex ou PAC');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRESVC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando essa configuração estiver habilitada, é necessário que os códigos FRENET nos cadastros de');
    mmoInfoCfgSis.Lines.Add('transportadoras estejam devidamente vinculados ao campo código do serviço de entrega que fica no');
    mmoInfoCfgSis.Lines.Add('painel de controle da FRENET, opção de menu MEIOS DE ENVIOS -> TRANSPORTADORAS.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLAIND') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização das seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SIMPAU] Optante por simples nacional? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Configuração utilizada somente para apuração do Resumo de Impostos do Simples Nacional.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ORSPSM') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A configuração CFG_ORCSPR também precisa estar ativa para essa ter efeito.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CFODVF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Esta configuração é utilizada para destacar os impostos ou não quando a empresa é optante pelo Simples Nacional (CFG_SIMPAU),');
    mmoInfoCfgSis.Lines.Add('e está sendo emitida uma nota fiscal de devolução de compra.');
    mmoInfoCfgSis.Lines.Add('Se a cfop estiver relacionada nesta configuração e o regime tributário do fornecedor não for Simples, os impostos serão destacados na nota.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPESP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Esta configuração define um layout específico e estático para impressão de separação de Pedidos.');
    mmoInfoCfgSis.Lines.Add('Ao habilitá-la será somente utilizada para impressão de separação de Pedidos em vídeo.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_REPLOT') Or
          (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_AMZEMP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 85;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add(' Para este recurso ficar disponível, também é necessário cadastrar as configurações: ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [CFG_CTLEST] Tipo de controle de sub-estoque na mesma loja = ARMAZÉM ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LIB_CD') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;

    mmoInfoCfgSis.Lines.Add('Esta configuração não deve ser utilizada quando existe Replicação de Dados, pois o Pedido pode estar sendo');
    mmoInfoCfgSis.Lines.Add('faturado no CD, e o vendedor estar alterando-o nesta empresa.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LIMCNH') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Caso o cliente tenha NF pendente no recebimento do canhoto pela rotina de Controle de Canhotos de');
    mmoInfoCfgSis.Lines.Add('NFs, emitidas em um prazo superior ao cadastrado nesta configuração, o Sistema irá bloquear emissão');
    mmoInfoCfgSis.Lines.Add('de novas NFs para o cliente. Quando o limite for igual a zero esta validação não será realizada.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_NOTPFF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será necessário utilizar o banco de código 778 na impressão de boleto.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_IMPRNF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('* Para utilizar esta configuração na opção ( 2 ), será necessário confirmar se o layout da nota eletrônica está ajustado para suportar as colunas de valor bruto, desconto e valor líquido.');
    mmoInfoCfgSis.Lines.Add('* Em ambos os casos, o desconto especial em valor permanece sendo impresso no campo próprio para desconto em valor.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CTRCDV') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando o centro de custo está preenchido, o sistema o trará como sugestão nas rotinas ');
    mmoInfoCfgSis.Lines.Add('"Devolução de Mercadorias" e "Outras Entradas"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SENJM1') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao configurar uma senha nesse campo, as senhas das configurações CFG_SENJUR e CFG_CTRSJU ');
    mmoInfoCfgSis.Lines.Add('serão inutilizadas');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_AUTCGC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para a utilização desta rotina, será necessário ativar a configuração CFG_AUTDOW - ');
    mmoInfoCfgSis.Lines.Add('"Tigre - Utilizar envio das informações de venda na Nota Fiscal Eletrônica ( somente itens da Tigre ) - TAG "NFE-PESSOA-DOWNLOAD-XML" ?"');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ESCCGC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para a utilização desta rotina, será necessário ativar a configuração CFG_ESCDOW - ');
    mmoInfoCfgSis.Lines.Add('"Escritório Credenciado - Utilizar envio das informações de venda na Nota Fiscal Eletrônica ( para todas as notas ) - TAG "NFE-PESSOA-DOWNLOAD-XML" "');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PCMPRO') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('ATENÇÃO: A opção "'+fRetCaptionItemRadio('rdgPerComPro',1)+'" só deve ser usada com as seguintes opções de comissão (CFG_OPCCOM) referentes a PRODUTOS:');
    mmoInfoCfgSis.Lines.Add('"'+fRetCaptionItemRadio('rdgOpcComVend','P') +'"');
    mmoInfoCfgSis.Lines.Add('"'+fRetCaptionItemRadio('rdgOpcComVend','PD')+'"');
    mmoInfoCfgSis.Lines.Add('"'+fRetCaptionItemRadio('rdgOpcComVend','PP')+'"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRQLGD') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_PRDFRQ] Utilizar Importação de Produtos Franqueadora? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_OSPDVN') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('  - Esta rotina habilita um campo no cad.produtos, para definir qual terá necessidade de');
    mmoInfoCfgSis.Lines.Add('    ordem de serviço após ser vendido.');
    mmoInfoCfgSis.Lines.Add('  - Este tipo de material estará na tela de manutenção de ordem de serviço de produtos');
    mmoInfoCfgSis.Lines.Add('    de venda para que seja realizado.');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PESOBR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada em conjunto com a configuração [CFG_MONCAI] Quando estiver utilizando faturamento');
    mmoInfoCfgSis.Lines.Add('depois da Expedição (CFG_TIPEXP), utilizar rotina de montagem de caixa(embalagem) para despacho de mercadorias? ( SIM )');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_FORESP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativa, permite cadastrar fórmulas sem matéria prima, para movimentação de estoque apenas da composição.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TRAANA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta trava, o operador deve utilizar a rotina de "Análise de Amostras" para registrar os resultados da produção.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AGRTPR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('|-------------------------------------------------------------------------------------------------------------------------------------------------------------|');
    mmoInfoCfgSis.Lines.Add('| * Opção 3 - Só irá funcionar no agrupamento tradicional.                                                                           |');
    mmoInfoCfgSis.Lines.Add('| * Opção 4 - Na geração automática, será usado a empresa do vendedor vinculado ao cadastro do cliente.    |');
    mmoInfoCfgSis.Lines.Add('|-------------------------------------------------------------------------------------------------------------------------------------------------------------|');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DESAVI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao inativar esta configuração, será obrigatório passar pelo caixa (Botão [F11] Conf. Orc.) para realizar o recebimento e posteriormente o desmembramento do pedido quando o mesmo for à vista.');
    mmoInfoCfgSis.Lines.Add('Lembrando que quando esta configuração for INATIVADA, para ser possível faturar pelo "F11-Caixa" é obrigatório habilitar as seguintes configurações (em todas as filiais):');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_ENT_CD] Utilizar entrega pelo C.D. = (SIM)');
    mmoInfoCfgSis.Lines.Add('[CFG_EMP_CD] Código da Empresa C.D. = ("A própria empresa")');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FTEXPC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_EXPPAR] Expedição Parcial (Esta configuração se aplica para Expedição antes e depois da Venda) = ( SIM )');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SLTFRC') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SOLITE] Utilizar solicitação de transferência de estoque para itens sem saldo? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('[CFG_CONENT] Usar controle de entrega? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('[CFG_SLRQPV] Solicitar tela de Requisição de Compra para produtos sem saldo de estoque na emissão do Pedido de Venda? = ( SIM )');
    mmoInfoCfgSis.Lines.Add('[CFG_OPSOAB] Utilizar tela de solicitação de abastecimento: = ( No PEDIDO )');
    mmoInfoCfgSis.Lines.Add('[CFG_CEATMN] Quando solicitar transferência para item sem saldo, realizar operação de forma: = ( Manual (Pedido de Venda) )');
    mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEQABA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para que esta configuração tenha efeito é preciso ativar a configuração [CFG_SLTFRC];');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Após ativar esta configuração é necessário acessar o "Cadastro de Empresa"');
    mmoInfoCfgSis.Lines.Add('e configurar a sequência na aba "2 - CONFIGURAÇÃO DE TRANSF. DE ESTOQUE",');
    mmoInfoCfgSis.Lines.Add('na coluna "SEQ." do grid;');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LOTCRO') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando utilizar endereçamento de produtos de entrada, o sistema armazenará os produtos sob-encomenda ligados à');
    mmoInfoCfgSis.Lines.Add('pedidos de venda, no lote CrossDocking, que estará vinculado à localização física específica para CrossDocking.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DMOBMV') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('É obrigatório utilizar esta configuração quando o pagamento da comissão é realizado através da comissão por contas a receber,');
    mmoInfoCfgSis.Lines.Add('para que o valor devolvido possa ser abatido da comissão do vendedor correto.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DESCND') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para que esta configuração seja ativada, as configurações abaixo precisam estar da seguinte forma:');
    mmoInfoCfgSis.Lines.Add('[CFG_EDIUNP] Alterar o valor unitário de produtos em promoção? ( NAO )');
    mmoInfoCfgSis.Lines.Add('[CFG_EDUNTB] Alterar o valor unitário na venda - Faturamento?  ( TODOS OS CHECK-BOX DESMARCADOS )');
    mmoInfoCfgSis.Lines.Add('[CFG_VALDOC] Validar a espécie do documento informada no perfil da condição de pagamento na confirmação de documentos? - Faturamento?  ( NAO )');
    mmoInfoCfgSis.Lines.Add('[CFG_UNIBRI] Alterar o valor unitário no Brinde? ( NAO )');
    mmoInfoCfgSis.Lines.Add('[CFG_EDIDES] Abrir tela para digitação de desconto especial no faturamento? ( NAO )');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BXAZSP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 150;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização das seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('[CFG_SEPSET] Imprimir separação por setor? = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_GRUSEP] Imprimir separação por setor, onde o setor será definido: = "Por Local de Separação"');
    mmoInfoCfgSis.Lines.Add('[CFG_BAISEP] Utilizar módulo de impressão e baixa da separação? = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP] Expedição = [2]Faturamento antes da expedição, [3]Faturamento depois da expedição ou [4]Pedido - O pedido não será faturado');
    mmoInfoCfgSis.Lines.Add('[CFG_EXPPAR] Expedição Parcial (Esta configuração se aplica para Expedição antes e depois da Venda) = "SIM"');
    mmoInfoCfgSis.Lines.Add('[CFG_CTLEST] Tipo de controle de sub-estoque na mesma loja = "Por armazém"');
    mmoInfoCfgSis.Lines.Add('-------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VLDTAX') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Local onde será validado se a taxa administrativa do registro importado está diferente do esperado.');
    mmoInfoCfgSis.Lines.Add('Conciliações: Cielo, Stone, PagSeguro(Arquivo e API), RedeCard(Arquivo e API), GetNet, Amex, SafraPay e Sicredi.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ONDASE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta rotina, será obrigatória a utilização das seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('[CFG_VENMAD]: MADEIRA - Utilizar rotinas de venda de madeira? = "NÃO"');
    mmoInfoCfgSis.Lines.Add('[CFG_VENVID]: VIDRO - Utilizar rotinas de venda de vidro? = "NÃO"');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP] Expedição = [3]Faturamento depois da expedição ou [4]Pedido - O pedido não será faturado');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ITEBAR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('ESTA CONFIGURACAO DEVE SER UTILIZADA QUANDO OS PRODUTOS ESTAO ETIQUETADOS COM CODIGO DE BARRAS <= 5 CARACTERES,');
    mmoInfoCfgSis.Lines.Add('IMPEDINDO QUE O SISTEMA USE O RECURSO DE PROCURAR PELO CODIGO CITEL OU PELO CODIGO DE BARRAS.');
    mmoInfoCfgSis.Lines.Add('DESTA FORMA, O SISTEMA IRA´ FAZER A PESQUISA SOMENTE PELO ITEBAR->BAR_CODBAR.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PEDBEF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao gerar pedido na baixa de entrega futura, é possível reservar o estoque dos produtos até realizar a expedição e faturamento do documento de venda.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RASIND' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração permite informar o lote do produto para rastreamento sem necessidade de toda a rotina de lote ( CADLOT ).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PESITE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Configuração tem efeito se não utilizar código da fábrica.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If MatchStr(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, ['CFG_FUNCPG', 'CFG_FUNFOR', 'CFG_FUNCTA', 'CFG_FUNPOR', 'CFG_FUNEVE']) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('*Quando "CFG_FUNCPG" = "SINTÉTICO", são consideradas as Configurações: [CFG_FUNFOR], [CFG_FUNCTA], [CFG_FUNPOR] e [CFG_FUNEVE] na geração do Contas a Pagar.');
    mmoInfoCfgSis.Lines.Add('*Quando "CFG_FUNCPG" = "ANALÍTICO", os dados são buscados do cadastro de Funcionários (aba Integração Tese).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PROSUG') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add(
      'Quando esta configuração estiver ativada, o Sistema habilitará a definição de preço para sugestão ' +
      'no Cadastro de Promoções, substituindo a configuração [CFG_PROPRE].');
    mmoInfoCfgSis.Lines.Add('Esta regra não afeta produtos tintométricos. No caso de tintométricos, o sistema continua utilizando a configuracao [CFG_PROPRE].');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BAITMQ' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('*Quando "CFG_BAITMQ" = "S", Ao baixar a formulação o saldo reservado retorna como saldo disponível.');
    mmoInfoCfgSis.Lines.Add('*Quando "CFG_BAITMQ" = "N", Ao baixar a formulação o saldo reservado permanece como saldo reservado e só será baixado no faturamento.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PROKIT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar promoção composta com brinde é preciso ativar a utilização de brinde '+
      'no faturamento (CFG_USABRI). Se esta configuração não for ativada, não será permitido informar brindes na promoção');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ITESIN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('As duas primeiras opções desta configuração (código do item e descrição do item) não podem ser desmarcadas '+
    'para que não ocorra problemas no momento da impressão da separação de pedidos');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If AnsiMatchStr(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, ['CFG_CNEXCP', 'CFG_CNDICP']) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Opção "Pedir senha de liberação" = Permite selecionar os pedidos com condições diferentes e ao finalizar a expedição o operador'+
    'define qual condição será utilizada dentre as condições dos pedidos.');
    mmoInfoCfgSis.Lines.Add('Opção "Não permitir selecionar"  = Trava a seleção dos pedidos na expedição, impedindo que o operador fature os pedidos no mesmo documento.');
    mmoInfoCfgSis.Lines.Add('Opção "Permitir selecionar" = Permite selecionar os pedidos e utiliza a condição do último pedido selecionado.');
    mmoInfoCfgSis.Lines.Add('Opção "Permitir selecionar e considerar a condição de maior prazo desde que satisfaça o valor da parcela mínima definida no perfil'+
    'da condição. Se não fizer, operador deverá decidir qual condição será utilizada" = Permite selecionar os pedidos e utiliza a'+
    'condição de maior prazo desde que o valor da parcela gerada para o documento se enquadre dentro do valor mínimo definido para'+
    'parcela na aba do perfil da condição (CFG_PFLCLI).');
    mmoInfoCfgSis.Lines.Add('Opção "Permitir selecionar, faturando separadamente por condição de pagamento" = Permite selecionar os pedidos e realiza o faturamento agrupando pela condição de pagamento'+
    ' então se houver duas condições diferentes será gerado um faturamento para cada condição.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DEVEFT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração na rotina de baixa de entrega futura será possível emitir baixa e devolução da entrega futura'+
    ' que passou do prazo de cancelamento e houve desistência antes da saída da mercadoria');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SPOBFM' Then
  Begin
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, será preciso bipar no coletor o código de barras da base da tinta e também o código de barras da fórmula (etiqueta do produto acabado)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RETACS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está ativada, ao fazer o faturamento de consignação para um cliente que é pessoa física '+
    'ou pessoa jurídica sem inscrição estadual (que não emite nota fiscal) o sistema irá realizar o retorno do envio da consignação '+
    '(devolução) da quantidade pendente e irá efetuar o faturamento sem vinculo de cfop com a consignação. A venda será emitida '+
    'como é feito pela rotina de Venda Normal, Expedição e/ou F11');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EMPCAR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta rotina permite definir no cadastro de produtos a empresa responsável pelo carregamento e entrega do item.');
    mmoInfoCfgSis.Lines.Add('Ao faturar um documento utilizando como destino a opção "Entrega", o sistema gerará automaticamente a saída por '+
      'transferência de estoque da empresa responsável pelo carregamento para a empresa que está faturando e a entrada na empresa que está faturando.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXIEMB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver ativa, na tela de divergências será exibida a quantidade de embalagens ' +
      'e o sistema só permitirá finalizar a conferência quando o total em unidades representar embalagens completas');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLUMPD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + 'Esta configuração só fará efeito se a configuração CFG_SENSEP estiver setada para solicitar senha ou código do separador';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RETDEV' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + 'Esta configuração não tem dependência do AUTOCENTER. Ela oferece o controle de inclusão e exclusão de produtos para imprimir a separaçao incremental.';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VNDSPD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção! Só é possível ativar e utilizar esta configuração se a comissão for paga pelo faturamento. Se a comissão é ' +
                            'paga pelo contas a receber não é possível realizar o pagamento da comissão de diversos vendedores em um mesmo documento ' +
                            'por conta da gravação das duplicatas no financeiro (CADREC)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LOTIMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + 'Caso esteja parametrizado para utiliar WMS, o lote considerado no processo será sempre "A DEFINIR" independente do valor desta configuração.';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PRZREC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Cálculo utilizado quando esta configuração estiver com valor diferente de "999", '+
                            'Média de dias cheque pré = (Dt. vencimento cheque - Dt. cadastro cheque)/(Qt.Cheques Digitados)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_B2WIMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + 'Esta rotina realiza a impressão da etiqueta de despacho ao faturar pedidos oriundos da B2W/Skyhub '+
                                                       '(Lojas Americanas, Submarino e Shoptime) para que possa ser solicitada a coleta destas mercadorias '+
                                                       'pela transportadora Direct.';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FRDVES' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao escolher a opção "Considerar o tipo de frete do documento que está sendo devolvido" e usar devolução espelho, na emissão');
    mmoInfoCfgSis.Lines.Add('da devolução o sistema vai verificar o tipo do frete do documento devolvido para considerar ou não o valor do frete no');
    mmoInfoCfgSis.Lines.Add('crédito que será gerado no financeiro.');
    mmoInfoCfgSis.Lines.Add('Se o tipo do frete for Destinatário(FOB) ou Transporte Próprio Destinatário, o valor do frete será somado ao crédito.');
    mmoInfoCfgSis.Lines.Add('Se o tipo do frete for Emitente(CIF), Terceiros, Sem Frete ou Transporte Próprio Remetente, o valor do frete não será somado ao crédito.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPOND' Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 116;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('"Para funcionamento desta rotina no coletor, as configurações abaixo deverão estar da seguinte maneira:"');
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = NÃO                            ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_ONDASE ] Utilizar Onda de Separação? = SIM.                                                     ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_TIPEXP ] Expedição = 4                                                                          ');
    mmoInfoCfgSis.Lines.Add('* [ CFG_SEPSIM ] Utilizar separação simplificada, separando pela localização física do produto? = SIM   ');
    mmoInfoCfgSis.Lines.Add('--------------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLAGAE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + 'Classificação fiscal para envio de mercadorias para fornecedor.';
  end

  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_INFCLI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('QUANDO A CONFIGURACAO ( 1 ) ESTIVER ATIVADA, E O OPERADOR ESTIVER REALIZANDO O LANCAMENTO DE UM RECEBIMENTO DE GARANTIA DE CLIENTE,');
    mmoInfoCfgSis.Lines.Add('NO QUAL É INDICADO O CLIENTE FILIAL (EMP_CLIFIL)  OU CONSUMIDOR GENÉRICO, E SELECIONE A OPCAO DE "GERAR CREDITO", SOLICITAR A TELA PARA INDICAR O NOVO ');
    mmoInfoCfgSis.Lines.Add('CLIENTE PARA GERACAO DO CREDITO');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXOULJ' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para habilitar esta configuração não é permitido usar replicação. As empresas devem estar no mesmo servidor pois o documento' +
                            ' de faturamento será emitido na empresa responsável pela expedição do Pedido e não pela empresa logada.');
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_COENFI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 180;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atualmente, quando usa controle de entrega, na rotina de baixa de entrega futura e expedição o sistema faz o seguinte filto nos documentos:');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Se a empresa é gerencial (CFG_EMPGER):');
    mmoInfoCfgSis.Lines.Add('* O sistema filtra os documentos onde o código da empresa é o código da empresa matriz (GER_CODMAT) ou o documento foi gerado como entrega (GER_CONENT = ''S'').');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Se a empresa não é gerencial (CFG_EMPGER):');
    mmoInfoCfgSis.Lines.Add('* O sistema filtra os documentos que não foram gerados como entrega (GER_CONENT = ''N'') e o código da empresa do documento é o código da empresa logada.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('- Com esta nova configuração será possível desviar destas regras de filtro de empresa.');
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VESPRO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser ativada somente se é gerada ordem de produção para o item estrutura quando não há estoque do mesmo. '+
      'Caso contrário, a validação de saldos ficará incoerente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LECRSN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está ativada, o sistema passa a não emitir mais a nota fiscal de serviços no '+
                            'faturamento de locação de equipamentos. Neste caso, será gerada apenas a duplicata no contas a receber.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ABADEP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('* É obrigatório uso de banco de dados único, sem replicação');
    mmoInfoCfgSis.Lines.Add('* É obrigatório uso de multi-lojas + CD [CFG_EMPFAT, CFG_ENT_CD ]');
    mmoInfoCfgSis.Lines.Add('* Não pode ser utilizada em conjunto com [ CFG_EXOULJ ]');
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ALTSER' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está ativa, é possível alterar o valor do Serviço na rotina "Manutenção de Ordem de Serviço - Conserto de Equipamento"');
    mmoInfoCfgSis.Lines.Add('Será verificado o "Desconto Máximo", informado no "Cadastro de Serviços", e solicitado liberação caso ultrapasse');
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_MULSEP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('* Para utilizar a configuração [CFG_MULSEP] = "S" ');
    mmoInfoCfgSis.Lines.Add('* É obrigatório uso da configuração [CFG_UTIWMS] = "S" ');
    mmoInfoCfgSis.Lines.Add('* É obrigatório uso da configuração [CFG_ROMLOT] = "S" ');
  end
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TACAEX') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('"Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:"');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [ CFG_CTLEST ] Tipo de controle de sub-estoque na mesma loja = POR ARMAZÉM.                ');
    mmoInfoCfgSis.Lines.Add('---------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MLTBOL') Then
  Begin
    mmoInfoCfgSis.Clear;
    mmoInfoCfgSis.Font.Name   := 'Courier New';
    pnlInfoCfgSis.Height      := 116;
    pnlInfoCfgSis.Top         := IIF((pnlInfoCfgSis.Top > lblInformacao.Top), lblInformacao.Top,pnlInfoCfgSis.Top);
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('+--------------------------------------------------------------------------------------------------------------+');
    mmoInfoCfgSis.Lines.Add('|Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:                   |');
    mmoInfoCfgSis.Lines.Add('+--------------------------------------------------------------------------------------------------------------+');
    mmoInfoCfgSis.Lines.Add('| * A impressão do boleto deve ocorrer sem a realização da pergunta referente a portador e banco [CFG_IMPBOL]. |');
    mmoInfoCfgSis.Lines.Add('| * Não deve haver portador configurado na forma de pagamento.                                                 |');
    mmoInfoCfgSis.Lines.Add('| * Não deve haver portador configurado na condição de pagamento.                                              |');
    mmoInfoCfgSis.Lines.Add('| * Não deve haver portador configurado no cadastro do cliente.                                                |');
    mmoInfoCfgSis.Lines.Add('+--------------------------------------------------------------------------------------------------------------+');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPCPD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 110;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para o funcionamento desta opção, as configurações abaixo deverão estar da seguinte maneira:');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* [ CFG_UTIWMS ] Utilizar WMS (Sistema de Gerenciamento de Armazém) = NÃO');
    mmoInfoCfgSis.Lines.Add('* [ CFG_ROMLOT ] Utilizar rotina de lote de separação para antecipar inclusão dos romaneios = NÃO');
    mmoInfoCfgSis.Lines.Add('* [ CFG_AUTCEN ] Utilizar Rotinas de Autocenter = NÃO');
    mmoInfoCfgSis.Lines.Add('* [ CFG_LIBPED ] Realizar Liberação de Pedidos = NÃO');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXINPD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o pedido será exibido na expedição e no romaneio somente após ');
    mmoInfoCfgSis.Lines.Add('passar pelo caixa e gerar um novo pedido. (CFG_NPDF11 - Gerar novo Pedido de Venda para itens ');
    mmoInfoCfgSis.Lines.Add('de entrega imediata quando faturar um pedido pelo F11 do Resumo de Caixa?)');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LMCEMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração o sistema passará a considerar os empréstimos de saída que ainda estão em aberto '+
                            'no valor total do limite de crédito');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PASARC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 180;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está ativada, o sistema permite que através de um direito de acesso, o operador libere as travas');
    mmoInfoCfgSis.Lines.Add('abaixo na expedição e na impressão da separação:');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Ainda não foi emitido requisição de compra para abastecimento de estoque do pedido de venda!');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Ainda não foi emitido pedido de compra para a requisição "xxx" emitida para abastecimento de estoque do pedido de venda!');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Ainda não foi realizada a entrada de mercadorias do pedido de compra "xxx" emitido através de requisição para');
    mmoInfoCfgSis.Lines.Add('  abastecimento de estoque do pedido de venda! "');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENDSTR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar a configuração, o sistema passará a validar o tamanho do endereço no cadastro do cliente para que a nota não fique ' +
                            'parada no painel por conta do Sefaz. Atualmente, o Sefaz permite endereço com no máximo 60 caracteres.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PPLBAI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('O portador do cadastro de uso e consumo vem da configuração "CFG_PORUSO" e o plano de contas é definido na rotina, ' +
                            'ao gravar o documento.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DITBAL' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema vai exibir no cadastro de produtos um novo campo que permitirá que o operador informe ' +
                            'se aquele item será pesado pela balança ou não no faturamento, podendo assim ignorar a configuração "CFG_DIGBAL".');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SGLTVL' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração o lote principal para venda (Armazém/Lote Principal para vendas no Orçamento/Pedido/Venda Normal) ' +
                            'será ignorado. O sistema irá carregar como sugestão aquele lote que tem data de validade mais próxima ao dia de hoje.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VENDIA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração está em uso somente se [CFG_PFLCLI] = NAO');
    mmoInfoCfgSis.Lines.Add('Quando [CFG_PFLCLI] = SIM, o controle está no Cad.Cond.Pagamento, aba PERFIL');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CNDDES' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 70;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema passará a exibir uma nova opção no desmembramento.');
    mmoInfoCfgSis.Lines.Add('Será permitido alterar a condição de pagamento e recalcular os preços do documento novo desde que o ');
    mmoInfoCfgSis.Lines.Add('pedido não possua adiantamento ou boleto de adiantamento.');
   end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UTCFOP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando estiver em branco, aplica-se para todas as CFOPs.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_MSGALL' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar a configuração, o sistema passará a disponibilizar a opção para responder a todos os usuários de destino da mensagem '+
                            'inicial ao responder uma mensagem recebida. Não haverá a possibilidade de alterar os usuários de destino da resposta.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_GARIND' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa é uma indústria,');
    mmoInfoCfgSis.Lines.Add('onde ela própria aplica suas garantias aos clientes');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end

  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_WACRGB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A assinutura capturada do aparelho Wacom Ctl-472 gera uma imgagem em bitmap.');
    mmoInfoCfgSis.Lines.Add('A imagem será convertida em preto utilizando a seguinte regra: Os pixels cujo a média do valor RGB for menor do que o valor dessa configuração, será convertido para preto absoluto.');
    mmoInfoCfgSis.Lines.Add('Valor RGB: Quanto mais próximo do valor 255 o pixel tenderá a cor branca e quanto mais próximo do valor 0 o pixel tenderá a cor preta.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End

  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TIPTER') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('Ao alterar o modo de uso da configuração [CFG_TIPTER] todo cadastro de terminais deve ser refeito em: ');
    mmoInfoCfgSis.Lines.Add('Principal > Manutenção de Cadastros > Configurações de Terminais TEF, pois utilizará regras diferentes para ');
    mmoInfoCfgSis.Lines.Add('gravação das informações dos terminais.');
    mmoInfoCfgSis.Lines.Add('Utilizar "Tipo 2" somente se as cópias de Homologação (se for o caso) e Produção estiverem atualizadas e ');
    mmoInfoCfgSis.Lines.Add('ambas contêm a configuração [CFG_TIPTER], a utilização de cópias divergentes vai comprometer o funcionamento dos terminais TEF.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_OBDCAR') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 50;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('Quando ativa, sistema irá ignorar campos "Obrigatório Núm. Liberação?" / "Obrigatório Núm. NSU?" do cadastro de cartões');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PP_MSG') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('O visor do Pin Pad aceita 8 linhas com 16 caracteres cada linha');
    mmoInfoCfgSis.Lines.Add('para configurar quebra de linha use o "|" (Pipe). ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_POOCRE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('Créditos no contas a receber, vinculados a este portador não serão exibidos na utilização de crédito, baixas de contas a receber, nem em notificaçoes do faturamento. ');
    mmoInfoCfgSis.Lines.Add('É um recurso para não permitir a utilização do crédito existente, sem necessidade de apagá-lo do contas a receber.                                                    ');
    mmoInfoCfgSis.Lines.Add('O objetivo é deixar bloqueado créditos específicos ou antigos.                                                                                                        ');
    mmoInfoCfgSis.Lines.Add('O vínculo do referido crédito a este portador, causará este efeito. Para liberá-lo, basta vinculá-lo a qualquer outro portador.                                       ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_DUCNPB') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('Valor: -1, para desativar a configuração. ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_QDCNPB') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção!');
    mmoInfoCfgSis.Lines.Add('Valor: -1, para desativar a configuração. ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BAREXP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração tem a função de desligar a obrigatoriedade de expedição com código de barras em algumas empresas.');
    mmoInfoCfgSis.Lines.Add('O campo do Cad.Produtos é geral, não é por empresa. Então sua manutenção pode ser feita em qualquer empresa, que afeta todas as empresas.');
    mmoInfoCfgSis.Lines.Add('No entando, caso esta configuração esteja desligada, apenas esta empresa não terá obrigatoriedade de expedir com código de barras.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BRIVEN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando essa configuração estiver ativada, a tela de Dados fiscais irá considerar a Classificação Fiscal para Brinde (CFG_CLABRI) ');
    mmoInfoCfgSis.Lines.Add('como uma Classificação de Venda (CFG_CLAVEN) e ao informar duas ou mais classificações, ira permitir informar uma Classificação ');
    mmoInfoCfgSis.Lines.Add('Fiscal para Brinde junto com uma Classificação de Venda!');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CDLTAU' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa não utiliza WMS.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CTECPG' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 14;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, após calcular a Data de Vencimento do contas a pagar considerando a Data de Emissão do CTE, se: Data Vencimento <= Data Atual, então a Data de Vencimento automaticamente será inserida Data Atual + 1. '
    +'Assim, não teremos duplicatas de contas a pagar vencida. ');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRLOSW' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para a rotina funcionar corretamente é necessãrio que a loja possua lotes e localizações cadastradas para os itens!');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_NFEQRC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar essa configuração é necessário que a impressora tenha suporte a impressão duplex ( frente-verso ).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CFOIPI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa configuração vai ignorar a situação de IPI informada no cadastro de clientes,');
    mmoInfoCfgSis.Lines.Add('vai usar exclusivamente o cadastro de abreviação de IPI para obter o CST de IPI.');
    mmoInfoCfgSis.Lines.Add('Caso essa configuração estiver vazia, este recurso fica desligado');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FXALCG' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para a rotina funcionar é necessário:');
    mmoInfoCfgSis.Lines.Add('  a. Vincular produto ao equipamento');
    mmoInfoCfgSis.Lines.Add('  b. Vincular Cliente no Fornecedor que está vinculado ao produto do equipamento');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LOTBAR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa opção só pode ser utilizada atualmente na expedição por pedido (CFG_TIPEXP = 3 OU 4) e quando não usa Wms.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_IDCTRA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativar esta configuração, o sistema irá ignorar a [CFG_IMPDES]');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FDECXR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada será exibido o checkbox "Caixa Rápida".');
    mmoInfoCfgSis.Lines.Add('Quando marcado, será gerado a abertura e o fechamento da caixa automaticamente,');
    mmoInfoCfgSis.Lines.Add('apenas com o produto bipado.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FDEUIS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada será exibido o checkbox "impressão sequencial". ');
    mmoInfoCfgSis.Lines.Add('Quando marcado será obrigatorio informar o total de volumes,');
    mmoInfoCfgSis.Lines.Add('ao fechar cada caixa será impresso a etiqueta automaticamente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FDEUMA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada não será exibido as mesagens de abertura e fechamento de caixa.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ALPDEM' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('É obrigatório uso de banco de dados único, sem replicação.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CODCAI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Sugestão: Utilize um código não conflitante com os produtos do cadastro.');
    mmoInfoCfgSis.Lines.Add('Exemplo: 9999999999994');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EMLEMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar a configuração o sistema irá buscar os e-mails de outra tabela. É preciso rodar script para converter.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SLIBDA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Travas afetadas:');
    mmoInfoCfgSis.Lines.Add('  - Emissão de Faturamento - PD;');
    mmoInfoCfgSis.Lines.Add('  - Venda de produtos em entrega futura para produtos não liberados;');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ALITPR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando a configuração está habilitada, será exibido no item o combo [Tab. Preço = P], caso altere para alguma tabela será desconsiderado a promoção.');
    mmoInfoCfgSis.Lines.Add('Este processo só ocorre quando [CFG_PROPRE = "Preço de Promoção"] e [CFG_TABITE = Sim].');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TR1DES' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando [CFG_LOCRET=S] será considerado na trava o local de retira.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_VCPPRO') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, o sistema vai permitir cadastrar mais de uma promoção vigente para o mesmo produto desde que as');
    mmoInfoCfgSis.Lines.Add('condições de pagamento sejam diferentes entre elas.');
    mmoInfoCfgSis.Lines.Add('Regras para usar esse recurso:');
    mmoInfoCfgSis.Lines.Add('1 - A configuração "CFG_PRZPRO - Considerar Prazo Médio nas Promoções?" precisa estar ativada.');
    mmoInfoCfgSis.Lines.Add('2 - É preciso utilizar condição de pagamento no início (CFG_CNDVEN). Motivo: É preciso saber qual é a condição de pagamento que');
    mmoInfoCfgSis.Lines.Add('    será utilizada na venda para que possa ser feita a carga correta dos preços promocionais.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLACDT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção! Para usar a rotina de controle de produtos cilindro e vasilhame para remessa de comodato (CFG_CDTCLV), Informe a cfop');
    mmoInfoCfgSis.Lines.Add('que deve ser utilizada na configuração CFG_CLACDT - Classificação fiscal para remessa de comodato de envio de produtos cilindro e');
    mmoInfoCfgSis.Lines.Add('vasilhame.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_PICOUT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar Picking Check-out, é preciso:');
    mmoInfoCfgSis.Lines.Add('1 - Utilizar WMS (CFG_UTIWMS);');
    mmoInfoCfgSis.Lines.Add('2 - Realizar o faturamento pela expedição ou pelo resumo de caixa;');
    mmoInfoCfgSis.Lines.Add('3 - Utilizar local de retira na emissão de orçamentos e pedidos (CFG_LOCRET);');
    mmoInfoCfgSis.Lines.Add('4 - Utilizar geração de novo pedido de venda para itens de entrega imediata quando faturar um pedido pelo F11 do Resumo de Caixa (CFG_NPDF11);');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRADOC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando possuir transportadoras diferentes entre os selecionados será aberto tela para definição.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_CHQNVT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando a configuração estiver habilitada o sistema irá considerar o cheque repassado como cheque em aberto até a data do');
    mmoInfoCfgSis.Lines.Add('vencimento, após o vencimento o cheque será considerado como liquidado. Desta forma o limite de crédito será influenciado.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CPFNOB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração estiver desabilitada, o sistema irá travar pedidos sem identificação válida (CPF/CNPJ)');
    mmoInfoCfgSis.Lines.Add('apenas nos casos em que já foi definido o tipo de faturamento.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_MDLVFE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 200;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Resumo de como funciona cada modelo:');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Modelo 1 - Quantidade total de unidades enviadas do produto é igual à quantidade faturada + quantidade retornada. Não há');
    mmoInfoCfgSis.Lines.Add('cálculo de impostos na remessa e no retorno da operação.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Rotina de remessa: Movimenta estoque e não calcula impostos (CFOP da operação não deve estar na CFG_CLAVEN)');
    mmoInfoCfgSis.Lines.Add('* Rotina de faturamento: Gera financeiro e não movimenta estoque, visto que o estoque é movimentado na remessa e calcula');
    mmoInfoCfgSis.Lines.Add('impostos normalmente (CFOP da operação deve estar na CFG_CLAVEN, visto que é um faturamento)');
    mmoInfoCfgSis.Lines.Add('* Rotina de retorno: Movimenta estoque e não calcula impostos (CFOP da operação não deve estar na CFG_CLAVEN)');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Quantidade pendente tanto na rotina de retorno quanto na rotina de faturamento é quantidade da remessa - quantidade faturada');
    mmoInfoCfgSis.Lines.Add('- quantidade retornada.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Modelo 2 - Quantidade total de unidades enviadas do produto é diferente da quantidade faturada + quantidade retornada.');
    mmoInfoCfgSis.Lines.Add('Nesse modelo, o retorno será sempre da totalidade das peças enviadas e há calculo de impostos na operação de remessa e');
    mmoInfoCfgSis.Lines.Add('retorno.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('* Rotina de remessa: Movimenta estoque e calcula impostos (CFOP da operação não deve estar na CFG_CLAVEN)');
    mmoInfoCfgSis.Lines.Add('* Rotina de faturamento: Gera financeiro, movimenta estoque novamente e calcula impostos (CFOP da operação deve estar na');
    mmoInfoCfgSis.Lines.Add('CFG_CLAVEN, visto que é um faturamento)');
    mmoInfoCfgSis.Lines.Add('* Rotina de retorno: Movimenta estoque e calcula impostos para abater os impostos da remessa (CFOP da operação não deve estar');
    mmoInfoCfgSis.Lines.Add('na CFG_CLAVEN)');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('A quantidade pendente nesse modelo para a operação de retorno será a quantidade da remessa - quantidade retornada.');
    mmoInfoCfgSis.Lines.Add('A quantidade pendente nesse modelo para a operação de faturamento será a quantidade da remessa - quantidade faturada.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BCFDCP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Brinde/Bonificação debitam o valor do ponto (CFG_VALPCF) * a quantidade do item da pontuação do Clube Fidelidade');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_REGCMT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('É necessário utilizar relatório específico.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EMPCNF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se estiver vazio será permitido todas as Empresas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TAGITE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção: Algumas tags de FCP mesmo marcadas nesta configuração, poderão ser exibidas ou não mediante a configuração:');
    mmoInfoCfgSis.Lines.Add('CFG_FCPZER:');
    mmoInfoCfgSis.Lines.Add('  1 - Listar somente valor de FCP maior que zero.');
    mmoInfoCfgSis.Lines.Add('  2 - Listar FCP mesmo zerado, para identificar os produtos enquadrados no Decreto 44498/2013.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FHRENO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Valores permitidos: -2, -3, -4 ou -5. Para limpar o valor dessa configuração use CTRL + DEL.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_LPVDAC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 100;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando Ativada, se Operador possuir direito de acesso, não será exibido o campo "Digitador" na Liberação do Pedido.');
    mmoInfoCfgSis.Lines.Add('Direitos de Acesso:');
    mmoInfoCfgSis.Lines.Add('  > PRINCIPAL > CONTROLE FINANCEIRO > LIBERAÇÃO DE PEDIDOS');
    mmoInfoCfgSis.Lines.Add('  > PRINCIPAL > CONTROLE FINANCEIRO > LIBERAÇÃO DE PEDIDOS - COMERCIAL');
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ORDORC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando estiver utilizando editor de documentos, com a ordenação definida nele, esta configuração é ignorada.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DELORE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A descrição será concatenada na tela principal do faturamento, na tela da Expedição, na Formulação e no cadastro de Produtos.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPEXC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, será exibido no cadastro de produtos, aba "Dados de Saída", um novo campo para informar que o');
    mmoInfoCfgSis.Lines.Add('item terá separação exclusiva. O objetivo desse campo é fazer um cálculo de volume a parte para itens desse tipo durante o');
    mmoInfoCfgSis.Lines.Add('faturamento e, ao imprimir a etiqueta de despacho, o autcom irá gerar 1 etiqueta para cada produto desse tipo.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CFPREP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para habilitar a configuração CFG_CFPREP, é necessário informar uma tabela de preços na configuração CFG_TBCNPR.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENTEQU' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Analítico = Permite vincular o mesmo produto em mais de uma O.S, de acordo com a quantidade na nota de entrada.');
    mmoInfoCfgSis.Lines.Add('Sintético = Permite vincular o mesmo produto em apenas uma O.S, indepentente da quantidade na nota de entrada.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_RSAIAN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada, a nota de saída será emitida com a quantidade = 1.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CSDFTA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada, caso a data de vencimento for um Sábado, Domingo ou Feriado, será considerado o próximo dia útil como data de vencimento.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_OPISUG' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Os lotes serão criados com o mesmo numero da OPI para permitir o rastreamento.');
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente com as configurações abaixo:');
    mmoInfoCfgSis.Lines.Add('   CFG_UTIWMS = ''S''');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CCRF11' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para ativar a configuração CFG_CCRF11, a configuração CFG_USACCR "Utilizar nota fiscal de concreto?", deve ser ativada.');

    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ABLOTT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração e colocar no faturamento um produto que tenha lote cadastrado, o sistema vai fazer o cálculo se vai');
    mmoInfoCfgSis.Lines.Add('ter estoque para atender, se vai gerar requisição de compra ou solicitação de transferência considerando o saldo total dos lotes');
    mmoInfoCfgSis.Lines.Add('do item de forma invidual. Ou seja, para conseguir atender a venda, um lote precisa ter a quantidade total.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ANAQTP') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração habilita a coluna de "Qtd.Produzir", na Análise de Produção, para que o operador informe');
    mmoInfoCfgSis.Lines.Add('as quantidade que deseja produzir e posteriormente gere um relatórrio com as quantidades solicitadas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXIORD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa informação não irá compor o Saldo Fisico/Disponivel. Portanto, não entra no cálculo');
    mmoInfoCfgSis.Lines.Add('da configuração CFG_CALSAL. Será um valor apenas informativo.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SUGBOI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se não utilizar a Procedure, sistema irá utilizar o mesmo cálculo de localizações ');
    mmoInfoCfgSis.Lines.Add('já existente na rotina de Plano de Recebimento.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UTIRRD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa rotina só pode ser utilizada com WMS (CFG_UTIWMS)');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SMSMKM' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao utilizar a integração com a MKOM para envio de sms apenas as seguintes configurações devem ser informadas:');
    mmoInfoCfgSis.Lines.Add('CFG_URLSMS (Informar a Base da Url da MKOM)');
    mmoInfoCfgSis.Lines.Add('CFG_TOKMKM (Informar o token gerado na plataforma da MKOM)');
    mmoInfoCfgSis.Lines.Add('CFG_CCUMKM (Informar o centro de custo cadastrado na plataforma da MKOM)');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TIPCNS') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, no momento da impressão da separação, o operador '
                           +'irá definir se o pedido irá ficar disponível no coletor.');
    mmoInfoCfgSis.Lines.Add('Se for definido que irá para o coletor, não será emitido nenhum papel e o pedido será listado '
                           +'na rotina de conferência de saída do coletor.');
    mmoInfoCfgSis.Lines.Add('Se for definido que não irá para o coletor então será impresso o documento de separação com o '
                           +'código de barras do pedido de venda.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else
  If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ENDBAI') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se ativada essa configuração, serão disponibilizados para Endereçamento ');
    mmoInfoCfgSis.Lines.Add('os Produtos que estão cadastrados para realizar endereçamento (Cadastro de Produtos / Aba Dados Compra) ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRCLCS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Será permitido a troca do cliente apenas de consignação enviada com espécie "CS"');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CHKNFS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa configuração só funciona quando usa integração com o eNotas (CFG_NFSENO).');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CUPIPI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativar a configuração, será obrigatorio emitir diariamene uma Nota Fiscal Especial para regularizar o destaque do IPI.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CNDETI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para empresas que utilizam a impressão de preços na etiqueta de produtos, essa configuração irá exibir tela solicitando a ');
    mmoInfoCfgSis.Lines.Add('condição de pagamento, e assim será impresso na etiqueta o "PREÇO A PRAZO" e "QTD DE PARCELAS".');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CONEFE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se ''Sim'', então a atualização do estoque e demais autalizações fiscais serão feitas automaticamente na Entrada Simplificada.');
    mmoInfoCfgSis.Lines.Add('Se ''Não'', então será necessário entrar na rotina de ''Efetivar Movimento Fiscal'' para concluir a operação de entrada.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_GLTFSP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando esta configuração está habilitada, ao importar os Pedidos, o sistema verifica se o Lote possui saldo suficiente.');
    mmoInfoCfgSis.Lines.Add('Caso sim grava o Lote da FSPEDIDOITENS.');
    mmoInfoCfgSis.Lines.Add('Caso não grava o Lote ''A DEFINIR''.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FUSUSA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A integração Fusion funciona para empresas que utilizam a CFG_OPCROM = 1 (Pedido de Venda).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ENITCN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração, o sistema deferá estar utilizando as seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = Sim');
    mmoInfoCfgSis.Lines.Add('[ CFG_ENDITE ] Permitir o endereçamento de itens já conferidos, mesmo que a conferência da nota não tenha sido totalmente finalizada? = Sim');
    mmoInfoCfgSis.Lines.Add('[ CFG_WMSPLA ] Quando utiliza WMS com Plano de Recebimento, quando será realizado o plano de recebimento? = Após o recebimento do caminhão na portaria');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXFPFF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa configuração funciona apenas para expedição tipo 4.');
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, na expedição tipo 4, no momento do faturamento (Botão F11 - Faturar Expedidos) se a quantidade for');
    mmoInfoCfgSis.Lines.Add('parcial ou se o pedido já foi faturado parcialmente, será emitida uma FF, obrigatoriamente.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Essa FF deverá ser confirmada em nota pela rotina de confirmação de documentos, conforme necessidade.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Essa regra não se aplica a pedidos de cliente filial (transferências e abastecimentos)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_VVCSDV') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Informar a porcentagem de variação sobre o custo permitida para determinar o valor do crédito quando CFG_HLVCSD E CFG_HLVCSD estiverem com valor = Sim.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXITCB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Rotina depende de TRIGGER');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPITE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração, o sistema deferá estar utilizando as seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = Não');
    mmoInfoCfgSis.Lines.Add('[ CFG_TIPEXP ] Tipo de expedição = 4 (Pedido)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPFAT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração, o sistema deferá estar utilizando as seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = Não');
    mmoInfoCfgSis.Lines.Add('[ CFG_TIPEXP ] Tipo de expedição = 4 (Pedido)');
    mmoInfoCfgSis.Lines.Add('[ CFG_SEPDTC ] Data de corte para exibir pedidos não separados e já faturados nas rotinas de separação e conferência de saída = Preenchido');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPDTC' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração, o sistema deferá estar utilizando as seguintes configurações:');
    mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = Não');
    mmoInfoCfgSis.Lines.Add('[ CFG_TIPEXP ] Tipo de expedição = 4 (Pedido)');
    mmoInfoCfgSis.Lines.Add('[ CFG_SEPFAT ] Permitir realizar separação e conferência de saída de pedidos já faturados? = Sim');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EDEQSA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando no quadro "Documento de Entrada" tem o equipamento vinculado no campo "Equip. NF-e", o sistema já carrega o equipamento');
    mmoInfoCfgSis.Lines.Add('da entrada para fazer a saida e não deixa alterar os dados do item. Ao ativar essa configuração, o item ficará habilitado para');
    mmoInfoCfgSis.Lines.Add('alteração, sendo responsabilidade do operador informar os dados corretamente do equipamento para fazer a saída.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_USAPCA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Se informar ( S ), o Sistema irá adotá-lo para sugestão de preço unitário de venda.');
    mmoInfoCfgSis.Lines.Add('Se informar ( N ), o Sistema irá praticar o melhor preço possível, participando da comparação: campanha, promoção, embalagem, ou qualquer outra regra de preço existente.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_ITECNF') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando a empresa utiliza Conferencia de Entrada (CFG_USACON).');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_BLNSTE') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando ativada, os Produtos com controle de número de série serão obrigados a serem incluídos em um Pedido para que sejam conferidos na Expedição e então gerar a Transferência de Estoque.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AVIREW') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao utilizar a opção "[] - Selecionados", utilizar a (CFG_AVIRWS) para informar as espécies selecionadas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ALPDAD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção! Mesmo ativando essa configuração não será permitido trocar o cliente do pedido.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_AVIRES') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao utilizar a opção "[] - Selecionados", utilizar a (CFG_AVIRSS) para informar as espécies selecionadas.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_TVMPDD') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A configuração não altera o comportamento da trava, apenas a exibição do desconto máximo permitido, para melhor leitura do operador que irá liberar.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_BFSGIS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar essa configuração é necessário definir na rotina de mapeamento de localização física a quantidade máxima que o picking suporta.');
    mmoInfoCfgSis.Lines.Add('Regra: Se a quantidade a ser separada for maior ou igual à capacidade máxima do picking, na impressão da separação pela expedição o');
    mmoInfoCfgSis.Lines.Add('sistema irá trazer o lote buffer como sugestão. Dessa forma, não será gerada a movimentação programada para o picking e o saldo do');
    mmoInfoCfgSis.Lines.Add('mesmo será preservado para atender os pedidos com quantidades menores. ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PRILAB' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, no cadastro de localização física será disponibilizado um novo tipo de localização chamado "Picking Laboratório".');
    mmoInfoCfgSis.Lines.Add('Esse tipo de localização só poderá ser vinculado a produtos que são bases de tinta de máquina (para produção de tinta imobiliária). Na impressão da');
    mmoInfoCfgSis.Lines.Add('separação, se o produto for uma tinta imobiliária, o sistema irá carregar como sugestão o lote que está vinculado à localização Picking Laboratório.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_EMPFAT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando CFG_EMPFAT = "S", valor da CFG_EMP_CD deverá ser o código da própria loja.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_GFPVBT') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Será gerado um Contas a Receber no valor do total de produtos para recebimento!');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TRAMZ2' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    case AnsiIndexStr(cdsCfgSis.FieldByName('SIS_VALCFG').AsString,['S','C']) of
      0: mmoInfoCfgSis.Lines.Add('Ao marcar a opção em 2 etapas, será gerada uma ' +
        'reserva de saldo e somente após confirmar a Liberação será feita a movimentação de saldo entre armazéns.');
      1: mmoInfoCfgSis.Lines.Add('Ao marcar a opção em 3 etapas, será gerada uma ' +
        'reserva de saldo e somente na Conferencia de Entrada será feita a movimentação de saldo entre armazéns.');
    End;
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CARFRE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao desligar essa configuração, o sistema não irá mais dar opção para o operador não carregar o frete da transportadora informada. ');
    mmoInfoCfgSis.Lines.Add('O frete será sempre carregado conforme demais configurações para o cálculo do mesmo e cadastrados.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PRAUDI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao utilizar esta configuração, será validado os Direitos de Acesso:');
    mmoInfoCfgSis.Lines.Add('1-"Senha para Manter os Preços da Venda - Preço atual MENOR que o preço da nova condição"');
    mmoInfoCfgSis.Lines.Add('2-"Senha para Manter os Preços da Venda - Preço atual MAIOR ou IGUAL ao preço da nova condição"');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_LMTDIA') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add(' Ao ultrapassar a quantidade de dias informada nessa configuração, se usuário não realizar a Importação de Novos Produtos da ');
    mmoInfoCfgSis.Lines.Add(' Franqueadora, somente usuário com Direito de Acesso poderá acessar Autcom. ');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TPLLOT' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração só terá efeito quando o sistema estiver configurado com controle de número de lote (CFG_LOTEND = 2), controle de data de validade (CFG_COLVAL = S) e tipo de plano de recebimento por local de separação (CFG_TIPLREC = L)');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SCDEEI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 25;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('É importante lembrar que este campo é obrigatório na tela da venda.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EXCBRF' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Rotina depende de TRIGGER');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CAMEDI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 20;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar essa configuração, a CFG_USAEDI deve estar ativa.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VAQTTR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Com essa configuração habilitada, sistema permitirá realizar transferência de estoque apenas da quantidade que está negativa no saldo físico da empresa que irá receber a transferência. Caso seja informada uma');
    mmoInfoCfgSis.Lines.Add('quantidade positivando o saldo, será apresentada trava com opção de liberação');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PSEPPA' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 160;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar a configuração será permitido apenas selecionar os itens que serão impresso na separação, todo o processo continua o mesmo.');
    mmoInfoCfgSis.Lines.Add('');
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP] - Expedição = 3 ou 4');
    mmoInfoCfgSis.Lines.Add('[CFG_EXPPAR] - Expedição Parcial (Esta configuração se aplica para Expedição antes e depois da Venda) = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_BAISEP] - Utilizar módulo de impressão e baixa da separação? = NÃO');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerênciamento de Armazém )? = NÃO');
    mmoInfoCfgSis.Lines.Add('[CFG_DLSWMS] - Utilizar definição de lote na separação sem WMS ? = NÃO');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_VPDSNI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 120;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('[CFG_TIPEXP] - Expedição = 3 ou 4');
    mmoInfoCfgSis.Lines.Add('[CFG_EXPPAR] - Expedição Parcial (Esta configuração se aplica para Expedição antes e depois da Venda) = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_BAISEP] - Utilizar módulo de impressão e baixa da separação? = NÃO');
    mmoInfoCfgSis.Lines.Add('[CFG_UTIWMS] - Utilizar WMS ( Sistema de Gerênciamento de Armazém )? = NÃO');
    mmoInfoCfgSis.Lines.Add('[CFG_DLSWMS] - Utilizar definição de lote na separação sem WMS ? = NÃO');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PCTINE' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quanto ativada e responder sim na pergunta, a nota de saída será emitida com todos os itens da nota de entrada vinculada a ordem de serviço.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PERIMP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilização desta configuração na opção abreviação fiscal, será necessária a utilização da seguinte configuração:');
    mmoInfoCfgSis.Lines.Add('[CFG_IMPIMP] - Atribuir Impostos no Pedido de Importação? = SIM');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SCPDES' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Atenção! Para utilizar a configuração [CFG_SCPDES = "S"]');
    mmoInfoCfgSis.Lines.Add('A configuração [CFG_UPSEML] deve estár ativada');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TPCHFD' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A configuração [CFG_TPCHFD] só pode ser ligada se a [CFG_OPCCOM] estiver na opção "Hierarquia por Faixa de Desconto (menu Comissão por Hierarquia por Faixa de Desconto)".');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FULSLO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Essa configuração só se aplica ao Fulfillment de empresas onde a nota de remessa (envio das mercadorias para o Full) '+
                            'é feita fora do autcom (Exemplo: Mercado Livre).');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_PTCCKO' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar a configuração [CFG_PTCCKO], a configuração [CFG_PCLF11] de deve estar ligada!');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_SEPORD') Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração, é necessário que a CFG_LOCFIS esteja configurada com a seguinte ordem (RUA, PRÉDIO, ANDAR, APARTAMENTO) e ter todos os dados configurados como numéricos.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_IGNLPK' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Pode ser informada uma localização completa, ou pode ser informado um pedaço da localização com "*" no final.');
    mmoInfoCfgSis.Lines.Add('O Sistema entenderá que é pra não permitir informar tudo que comece com esta parte cadastrada.');
    mmoInfoCfgSis.Lines.Add('Separar cada localização por vírgula.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CONDEV' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Os documentos de devolução emitidos pela rotina de Faturamento (Emissão de Faturamento - Devolução), só serão solicitados a Conferencia');
    mmoInfoCfgSis.Lines.Add('quando o tipo de expedição for = 3 ou 4 (CFG_TIPEXP = 3 ou 4) ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If SameText(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_USA_PF') Then
  Begin
    pnlInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height    := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando essa configuração estiver ativa, será habilitada nova aba no cadastro de produtos para parametrização dos preços de pauta fiscal. ');
    mmoInfoCfgSis.Lines.Add('Se preenchida, o sistema irá utilizar este valor como base de cálculo de ICMS-ST.');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  End
  Else If (Pos(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, 'CFG_IPANOP') > 0) Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 40;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, produto acabado que não tiver OPI em aberto, poderá ser inativado no autcom, mesmo tendo OPI em aberto');
    mmoInfoCfgSis.Lines.Add('para outros Acabados do mesmo GRANEL/FÓRMULA. ');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;

  pAdicionarHintCFG_CLCCTR;
  pAdicionarHintCFG_BEACCS;
  pAdicionarHintCFG_SUFIPC;
  pAdicionarHintCFG_ZFMDES;
  pAdicionarHintCFG_CLAIMP;
  pAdicionarHintCFG_MUNINC;
  pAdicionarHintPerguntasImpressao;
  pAdicionarHintCFG_DEIPCT;
  AdicionarHintCFG_F11TFO;
  pAdicionarHintCFG_CARREA;
  pAdicionarHintCFG_RSAPRP;
  pAdicionarHintCFG_HPNAUT;
  pAdicionarHintCFG_CENDNE;
  pAdicionarHintCFG_OSEVSL;
  pAdicionarHintCFG_SOLOLA;
  pAdicionarHintCFG_LSEWMS;
  pAdicionarHintCFG_LIBAJU;
  pAdicionarHintCFG_SPCDEN;
  pAdicionarHintCFG_UEVPRI;
  pAdicionarHintCFG_SONCEE;
  pAdicionarHintCFG_ENDAUT;
  pAdicionarHintCFG_INVCRI;
  pAdicionarHintCFG_SUPSEP;
  pAdicionarHintCFG_PRQSEC;
  pAdicionarHintCFG_UTILLC;
  pAdicionarHintCFG_EMBMAS;
  pAdicionarHintCFG_ENPAFR;
  pAdicionarHintCFG_URMEIE;
  pAdicionarHintCFG_ENDPRO;
  pAdicionarHintCFG_TRAFRE;
  pAdicionarHintCFG_COFTRA;
  pAdicionarHintCFG_DVTBCR;
  pAdicionarHintCFG_OBRLPK;
  pAdicionarHintCFG_USALAL;
  pAdicionarHintCFG_UDEVME;
  pAdicionarHintCFG_COFEND;
  pAdicionarHintCFG_FREIPI;
  pAdicionarHintCFG_FREPES;
  pAdicionarHintCFG_NSNATP;
  pAdicionarHintCFG_MERCRE;
  pAdicionarHintCFG_DVSPCL;
  pAdicionarHintCFG_DIMPF4;
  pAdicionarHintCFG_DFLLUB;
  pAdicionarHintCFG_ICMSEP;
  pAdicionarHintCFG_UASCCR;
  pAdicionarHintCFG_LEVREC;
  pAdicionarHintCFG_ALTVMT;
  pAdicionarHintCFG_DOCPRO;
  pAdicionarHintCFG_GERTRF;
  pAdicionarHintCFG_CTGRTN;
  pAdicionarHintCFG_SEPLCS;
  cxHintStyleController.HideHint;
end;

procedure TfrmCfgSistema.cdsCfgSisBeforeEdit(DataSet: TDataSet);
begin
  TValidarConfiguracoes.cdsCfgSisBeforeEdit(DataSet);
end;

procedure TfrmCfgSistema.cdsCfgSisBeforePost(DataSet: TDataSet);
begin
  TValidarConfiguracoes.cdsCfgSisBeforePost(DataSet);
end;

procedure TfrmCfgSistema.cdsCfgSisFilterRecord(DataSet: TDataSet;  var Accept: Boolean);
const
  SPOIMP_CONFIG_EXIBIR: Array[0..3] Of String = ('CFG_PONPRE', 'CFG_PONPI1', 'CFG_PONPM1', 'CFG_PONPR7');
  SPOIMP_CONFIG_NAO_EXIBIR: Array[0..12] Of String = ('CFG_PATLAS','CFG_PATLA2','CFG_PATLA3',
    'CFG_CADIMP','CFG_CITIMP','CFG_IMPCHQ','CFG_USAICH','CFG_IMPNFI','CFG_TIPIMP', 'CFG_PATPRE',
    'CFG_PATPI1', 'CFG_PATPM1', 'CFG_PATPR7');
Var
  strValorBuscar: String;

  function fConfiguracaoSatisfazFiltro(strValue: String): Boolean;
    Var
      strPalavra: String;
  begin
    Result := True;
    For strPalavra In arrPalavrasPesquisar Do
      If Not strPalavra.Trim.IsEmpty Then
        Result := Result And fRemoveAcento(strValue.ToLower)
          .Contains(fRemoveAcento(strPalavra.ToLower));
  end;

begin
  If FSpoolImpressaoCitel And
     MatchStr(DataSet.FieldByName('SIS_CODCFG').AsString, SPOIMP_CONFIG_NAO_EXIBIR) Then
  Begin
    If (Pos(DataSet.FieldByName('SIS_CODCFG').AsString, FStrCfgOcu) = 0) then
      FStrCfgOcu := FStrCfgOcu + DataSet.FieldByName('SIS_CODCFG').AsString + '_';

    Accept := False;
    Exit;
  End;

  If Not FSpoolImpressaoCitel And
     MatchStr(DataSet.FieldByName('SIS_CODCFG').AsString, SPOIMP_CONFIG_EXIBIR) Then
  Begin
    If (Pos(DataSet.FieldByName('SIS_CODCFG').AsString, FStrCfgOcu) = 0) then
      FStrCfgOcu := FStrCfgOcu + DataSet.FieldByName('SIS_CODCFG').AsString + '_';

    Accept := False;
    Exit;
  End;

  If String(edtPesquisar.Text).Trim.Length < 2 Then
  Begin
    Accept := True;
    Exit;
  End;

  strValorBuscar := DataSet.FieldByName('SIS_CODCFG').AsString + ' ' +
                    DataSet.FieldByName('SIS_DESCRI').AsString + ' ' +
                    DataSet.FieldByName('SIS_GRUCFG').AsString;

  If chkPesquisarPorValor.Checked Then
    strValorBuscar := strValorBuscar + ' ' +
      cfgRepositorio.fRetDescricaoValoresCfg(DataSet.FieldByName('SIS_CODCFG').AsString,
                                             DataSet.FieldByName('SIS_VALCFG').AsString);

  Accept := fConfiguracaoSatisfazFiltro(strValorBuscar);
end;

procedure TfrmCfgSistema.chkPesquisarPorValorClick(Sender: TObject);
begin
  inherited;
  If chkPesquisarPorValor.Checked And fPergunta('Confirma buscar por valor da configuração?') Then
  Begin
    fExecutarModal(pCarregarDescricaoValorConfiguracoes, 'Aguarde, carregando valores para pesquisa ...', '');
    pSetFocus(edtPesquisar);
    Exit;
  End;
  chkPesquisarPorValor.Checked := False;
end;

procedure TfrmCfgSistema.pAtualizaConfiguracoesComuns;
  Var
    qryUpd: TUniQuery;
    intContador: Integer;
    bkmRegistro: TBookmark;
begin
  qryUpd := fCriaQuery(Self);

  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  CFGSIS ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  SIS_VALCFG = :VALCFG ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  SIS_CODCFG = :CODCFG ');

  bkmRegistro := cdsCfgSis.GetBookmark;

  For intContador := Low(arrConfigComuns) To High(arrConfigComuns) Do
  Begin
    If (cdsCfgSis.FindKey([arrConfigComuns[intContador][0], VS_strCodEmp])) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> arrConfigComuns[intContador][1]) Then
    Begin
      qryUpd.Close;
      qryUpd.ParamByName('VALCFG').AsString := cdsCfgSis.FieldByName('SIS_VALCFG').AsString;
      qryUpd.ParamByName('CODCFG').AsString := cdsCfgSis.FieldByName('SIS_CODCFG').AsString;
      qryUpd.ExecSQL;
    End;
  End;

  cdsCfgSis.GotoBookmark(bkmRegistro);

  FreeMemory(bkmRegistro);
  FreeAndNil(qryUpd);

  TfrmCfgMensAdicPedidoCompra.fSalvaMensagem('PD', strValMsgPedNov);
  TfrmCfgMensAdicPedidoCompra.fSalvaMensagem('OR', strValMsgOrcNov);

end;

procedure TfrmCfgSistema.pbtnOpen_ImpChqPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pCriarForm(TfrmCfgImpCheques);
end;

procedure TfrmCfgSistema.pbtnOpen_MarcasBoshPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;

  pCriarForm(TfrmCfgMarcasBosh);
end;


procedure TfrmCfgSistema.pbtnOpen_NFCePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  pCriarForm(TfrmCfgNFCe);
end;

procedure TfrmCfgSistema.AdicionarHintCFG_F11TFO;
begin
  If Not cdsCfgSis.FieldByName('SIS_CODCFG').AsString.Equals('CFG_F11TFO') Then
    Exit;

  mmoInfoCfgSis.Clear;
  mmoInfoCfgSis.StyleElements := [seClient, seBorder];
  pnlInfoCfgSis.Height      := 100;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('***ATENÇÃO***');
  mmoInfoCfgSis.Lines.Add('Quando essa configuração estiver igual a "Sim", as configurações [CFG_TPFCCX = "Caixas"] e ["CFG_SARCX" = "Caixa"], ');
  mmoInfoCfgSis.Lines.Add('o sistema irá considerar o valor da CFG_CXMVTP.');
  mmoInfoCfgSis.Lines.Add('Essa configuração estando igual a "1", as transferências nos recebimentos por Ordem de Pagamento no Venda Normal e F11/F3 do Resumo de Caixa, ');
  mmoInfoCfgSis.Lines.Add('ficará a cargo de cada operador, fazendo com que um operador possa transferir valor maior em Ordem de Pagamento do que realmente ');
  mmoInfoCfgSis.Lines.Add('recebeu, podendo gerar inconsistências nos valores de transferência ao filtrar um operador.');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_OBRLPK;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_OBRLPK') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração o sistema deverá estar configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('CFG_LOTPIC - Utilizar apenas um lote do produto por localização PICKING independente da data de validade? = SIM.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_OSEVSL;
begin
  if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_OSEVSL') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Pedidos não atendidos, não serão inclusos na onda e não terão separação impressa.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_PRQSEC;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_PRQSEC' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 60;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente se CFG_ENTVAL = Conferencia de Entrada e/ou CFG_ENTLOT = Conferencia de Entrada.');
  mmoInfoCfgSis.Lines.Add('[CFG_ENTVAL] - Quando não estiver utilizando wms "CFG_UTIWMS = N", caso o produto possua lote, solicitar a data de validade na rotina de: Conferencia de Entrada');
  mmoInfoCfgSis.Lines.Add('[CFG_ENTLOT] - Quando não estiver utilizando wms "CFG_UTIWMS = N", caso o produto possua lote, solicitar o nome do lote na rotina de: Conferencia de Entrada');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  inherited;
  ShowMessage(e.Message);
end;

procedure TfrmCfgSistema.FormCreate(Sender: TObject);
begin
  inherited;
  blnExibiuMensagemClaSub := False;
  strConfiguracoesSomenteCitel := fGetConfiguracoesSomenteCitel;
  blnModoDeDesenvolvimento := fModoDeDesenvolvimento;
  blnIniciandoConfiguracoes := False;
  strValMsgPedNov := '#NDEF';
  strValMsgOrcNov := '#NDEF';
  FSpoolImpressaoCitel      := VS_SpoolImpressaoCitel;
  dicAlteracoes := TDictionary<String, String>.Create;
  blnAppEntregaArqIni := fArqIni(0, 'GERAL', 'APP_ENTREGA', '') = 'S';
  blnWhatsappArqIni := fArqIni(0, 'GERAL', 'WHATSAPP', '') = 'S';

  TValidarConfiguracoes.cdsCfgSis      := Self.cdsCfgSis;
  TValidarConfiguracoes.cfgRepositorio := Self.cfgRepositorio;
  TValidarConfiguracoes.lblInformacao  := Self.lblInformacao;
  TValidarConfiguracoes.dicAlteracoes  := Self.dicAlteracoes;
  TValidarConfiguracoes.cxDBTableView  := Self.cxDadosDBTableView1;
  TValidarConfiguracoes.blnAdicionarConfigDuranteValidacao := False;
end;

procedure TfrmCfgSistema.pRemoveMarkup4_5;
var i: Integer;
begin
  For i := cfgRepositorio.rdgMarkup.Properties.Items.Count -1 downto 0 do
  Begin
    If (cfgRepositorio.rdgMarkup.Properties.Items[i].Value = '5') Then
    begin
      cfgRepositorio.rdgMarkup.Properties.Items.Delete(i);
      break;
    End;
  End;

  For i := cfgRepositorio.rdgMarkup.Properties.Items.Count -1 downto 0 do
  Begin
    If (cfgRepositorio.rdgMarkup.Properties.Items[i].Value = '4') Then
    begin
      cfgRepositorio.rdgMarkup.Properties.Items.Delete(i);
      break;
    End;
  End;
end;

procedure TfrmCfgSistema.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(GerenciaCliAju) Then
    FreeAndNil(GerenciaCliAju);

  FreeAndNil(dicAlteracoes);
  pDestroiModulo(cfgRepositorio);
  cfgRepositorio := Nil;
end;

function TfrmCfgSistema.fRetornaFornecedorMulti(
  const arrSelecao: TConsultasArray): String;
Var
  intContador : integer;
Begin
  Result := '';
  For intContador := 0 To Length(arrSelecao) -1 Do
  Begin
    If intContador = 0 Then
    Begin
      Result := arrSelecao[intContador].strCodigo;
      Continue;
    End;

    Result := Result + ',' + arrSelecao[intContador].strCodigo;
  End;
end;

Function TfrmCfgSistema.fSalvaLogCfg(cdsCfgSis: TUniClientDataSet): Boolean;
  Var
    FDeltaDS: TPacketDataSet;
    qryLogCfg: TUniQuery;
Begin
  Try
    Result := True;
    If cdsCfgSis.ChangeCount > 0 Then
    Begin
      qryLogCfg     := fCriaQuery;
      With qryLogCfg, SQL Do
      Begin
        Clear;
        Add('SELECT * FROM LOGCFG WHERE FALSE');
        Open;
      End;

      FDeltaDS      := TPacketDataSet.Create(nil);
      FDeltaDS.Data := cdsCfgSis.Delta;

      With FDeltaDS Do
      Begin
        First;
        While Not Eof Do
        Begin
          qryLogCfg.Insert;
          qryLogCfg.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCFG', VS_strCodEmp);
          qryLogCfg.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
          qryLogCfg.FieldByName('LOG_HORALT').AsDateTime := fTime();
          qryLogCfg.FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
          qryLogCfg.FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
          qryLogCfg.FieldByName('LOG_EMPCFG').AsString   := FieldByName('SIS_CODEMP').AsString;
          qryLogCfg.FieldByName('LOG_CODCFG').AsString   := FieldByName('SIS_CODCFG').AsString;
          qryLogCfg.FieldByName('LOG_VALANT').AsString   := FieldByName('SIS_VALCFG').AsString;

          Next;

          If Not Eof Then
          Begin
            qryLogCfg.FieldByName('LOG_VALATU').AsString := FieldByName('SIS_VALCFG').AsString;
            qryLogCfg.Post;
          End

          Else qryLogCfg.Cancel;

          Next;
        End;
      End;

      FreeAndNil(FDeltaDS);
      FreeAndNil(qryLogCfg);

    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fSalvaLogCfg]');
    End;
  End;
End;


function TfrmCfgSistema.fValidaConfiguracaoDiasTolerancia: Boolean;
begin
  Result := True;

  pInformacao('Aguarde, validando configuração de dias de tolerância!');

  With cdsCfgSis Do
  Begin
    If (FindKey(['CFG_QDFECA'])) And
       (cdsCfgSis.FieldByName('SIS_VALCFG').Asinteger <> 0) Then
    Begin
      If (FindKey(['CFG_RCXPDP'])) And
         (cdsCfgSis.FieldByName('SIS_VALCFG').AsString <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Para os dias de tolerância a configuração CFG_RCXPDP' + #13 +
                              'deve ser alterada para "Sim".', ['&Ok']);
        Result := False;
      End;
    End;
  End;

end;

procedure TfrmCfgSistema.pInformacao(strInfo: String; blnExibir: Boolean = True);
begin
  lblInformacao.Visible := blnExibir;
  lblInformacao.Caption := strInfo;
  Application.ProcessMessages;
end;

procedure TfrmCfgSistema.pIniciaTelaConfiguracoes;
  Var
    frmAguarde: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmAguarde);
  blnIniciandoConfiguracoes := True;
  Try
    Try
      frmAguarde.fExecutarAcao := fIniciaTelaConfiguracoes;
      frmAguarde.ShowModal;
      VS_CfgJaVerificadas := frmAguarde.blnConfirma;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    blnIniciandoConfiguracoes := False;
    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmCfgSistema.pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCfgSistema.btnConLayCEQPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  edtCodigo: TEditFocus;
  edtDescri: TEditFocus;
  arrSelecao: TConsultasArray;
  Key: Char;
begin
  try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, Nil, '', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpeOrdemServico].ToString {89}) Then
    begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    end;
  except
    On E: Exception do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConLayFFPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  edtCodigo: TEditFocus;
  edtDescri: TEditFocus;
  arrSelecao: TConsultasArray;
  Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, Nil, '', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpeFF].ToString {51}) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConLayOrcPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, Nil, '', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpeOR].ToString {53}) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConLayPedPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, Nil, '', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpePD].ToString {52}) Then
    Begin
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.btnConLaySepPedPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqLayout(Self, edtCodigo, edtDescri, Nil, '', Key, arrSelecao, True, ARR_TIPO_LAYOUT[tpeSepPedido].ToString {55}) Then
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text
    Else
    Begin
      If fPergunta('Nenhum layout foi selecionado. Deseja limpar o valor do campo?') Then
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := '';
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

procedure TfrmCfgSistema.pbtnConPlaNcoPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin
  edtCodigo := TEditFocus.Create(Nil);
  edtDescri := TEditFocus.Create(Nil);
  Try
    try
      Key := '/';
      If fPesqPlanoContabil(Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
      Begin
        TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  end;
end;

procedure TfrmCfgSistema.pExibirBtnCfgEmp;
var
  intContador: Integer;
  LProperties: TcxCustomEditProperties;
begin
  btnCfgEmp.Visible := fConfiguracaoPermiteReplicar(cdsCfgSis.FieldByName('SIS_CODCFG').AsString);

  For intContador := Low(arrConfigComuns) To High(arrConfigComuns) Do
    If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = arrConfigComuns[intContador][0] Then
      btnCfgEmp.Visible := False;

  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CLIAJU' Then
    btnCfgEmp.Visible := False;

  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CDCRNV' Then
    btnCfgEmp.Visible := False;

  LProperties := Nil;

  cfgRepositorio.pRetProperties(cdsCfgSis.FieldByName('SIS_CODCFG').AsString, LProperties);

  If Not Assigned(LProperties) Then
    Exit;

  If LProperties = cfgRepositorio.btnConfigWpp.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCadFilaWpp.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCadEstabelecimentosCartoes.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCadastroIDRecebedorPagarMe.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCadastroChaveAutenticacaoCartoes.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCfgEveNec.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCfgLocFis.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCRELPC.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnCfgNsuHos.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnBloFil.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnFornecedoresTigre.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_RomIpr.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_SATCFe.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_ImpNfi.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_CodFabrProdAcab.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_CupFis.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_MensAdicORC.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_MensAdicPED.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnPesquisasOpiniOne.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnConfigContele.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_DescProdAcab.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_Gaveta.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_Replicacao.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_ImpChq.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_MarcasBosh.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnOpen_NFCe.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnForGnn.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnSelEndPartidaConFrete.Properties Then
    btnCfgEmp.Visible := False;

  If LProperties = cfgRepositorio.btnHRTCOD.Properties Then
    btnCfgEmp.Visible := False;
end;

procedure TfrmCfgSistema.pbtnConFornecedorSkyPecasPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;
begin

  Try
    edtCodigo := TEditFocus.Create(Nil);
    edtDescri := TEditFocus.Create(Nil);

    Key := '/';
    If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
    Begin
      If TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fFornecedorSky(edtCodigo.Text) = -1 Then
      begin
        pMensagemOk('Fornecedor não esta configurado. Verifique a configuração [CFG_SKYRSF - Sky Peças - Relaciona Fornecedor Sky com cadastro de Fornecedor Autcom]');
        Exit;
      End;
      TValidarConfiguracoes.cxDBTableView.GetColumnByFieldName('SIS_VALCFG').EditValue := edtCodigo.Text;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(edtCodigo);
  FreeAndNil(edtDescri);
end;

function TfrmCfgSistema.fPermitirEditarConfiguracao(const strCodigoConfiguracao : String) : Boolean;
begin
  Result := True;
  If (blnModoDeDesenvolvimento) Then
    Exit;
  If (strLoginUsuarioLogado = '999') Then
    Exit;
  If (Not fEhAdministrador(strLoginUsuarioLogado)) Then
    Exit;
  If fEmptyStr(strCodigoConfiguracao) Then
    Exit;
  If (strConfiguracoesSomenteCitel.Contains(strCodigoConfiguracao)) Then
    Exit;
  Result := False;
end;

procedure TfrmCfgSistema.pSetarInformacaoOperador(const blnPermitiuAlterarCfg : Boolean);
begin
  If (blnPermitiuAlterarCfg) Then
    Exit;
  pnlInfo.Caption := '* Operador só pode alterar configurações de uso exclusivo Citel *';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_HPNAUT;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_HPNAUT' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 60;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Quando existir notas em contingência que não estão autorizadas, o Painel vai desligar automaticamente a [CFG_POSNAB], para que os caixas ');
  mmoInfoCfgSis.Lines.Add('possam ser fechados no final do dia sem nenhum transtorno, nos demais casos ela será habilitada, forçando o operador a resolver as pendências dos documentos ');
  mmoInfoCfgSis.Lines.Add('fiscais eletrônicos antes do fechamento do caixa.');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ICMSEP;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_ICMSEP' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando utilizar esta configuração ativada, passa a existir na Abreviação de ICMS, alíquota de ICMS para destaque no documento de venda,');
    mmoInfoCfgSis.Lines.Add('e alíquota ICMS para cálculo do preço.');
    mmoInfoCfgSis.Lines.Add('Deve ser utilizado quando existir benefícios fiscais no Estado, onde destaca-se alíquota cheia e depois faz recuperação do ICMS.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_INVCRI;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_INVCRI' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 80;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar esta configuração o sistema deverá estar configurado conforme abaixo:');
    mmoInfoCfgSis.Lines.Add('[CFG_LRGMIC] = SIM');
    mmoInfoCfgSis.Lines.Add('[CFG_MPINAT] = SIM');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_LSEWMS;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_LSEWMS' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 60;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Necessário desabilitar a configuração CFG_SOLOLA');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_LIBAJU;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_LIBAJU' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 50;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, apenas a gravação manual do ajuste de estoque irá solicitar Trava de Liberação. ');
  mmoInfoCfgSis.Lines.Add('Os ajustes de estoque que são criados automaticamente pelo Autcom não serão afetados.');

  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SPCDEN;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_SPCDEN' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 80;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Esta configuração depende das triggers BI_EXTGOR_DOCEND e BU_EXTGOR_DOCEND, que preenchem os campos ');
  mmoInfoCfgSis.Lines.Add('FGO_DCENUM, FGO_DCEESP, FGO_DCESER, FGO_DCEEMP, FGO_DCEFOR e FGO_DCETFC da EXTGOR a partir do FGO_DOCEND.');
  mmoInfoCfgSis.Lines.Add('Antes de ativar, é necessário rodar um UPDATE para alimentar esses campos nos documentos já existentes.');
  mmoInfoCfgSis.Lines.Add('Entre em contato com a Citel para disponibilizar as triggers e o script de atualização.');

  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;


procedure TfrmCfgSistema.pAdicionarHintCFG_EMBMAS;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_EMBMAS' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A quantidade da embalagem master será exibida nas telas de faturamento (apenas como informativo):');
    mmoInfoCfgSis.Lines.Add('ORÇAMENTO / PEDIDO / VENDA NORMAL / OUTRAS SAIDAS / TRANSFERENCIA / NOTA ESPECIAL');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_ENPAFR;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_ENPAFR' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 30;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('A configuração terá efeito nas integrações: "FRENET", "QUALP" e "DATAFRETE"');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_COFTRA;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_COFTRA' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 120;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, no Endereçamento ficará disponível apenas a quantidade conferida.');
  mmoInfoCfgSis.Lines.Add('Caso a quantidade conferida seja menor que a quantidade da Transferência, então o saldo a devolver ficará disponível na rotina Devolução de Mercadorias - Pré-nota');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_CTGRTN;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_CTGRTN' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 90;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('SEP = SEPARAÇÃO / TRL = TRANSFERÊNCIA DE LOCAL / END = ENDERECAMENTO');
    mmoInfoCfgSis.Lines.Add('MVP = MOVIMENTAÇÃO PROGRAMADA / GVC = GUARDAR VENDAS CANCELADAS/DEVOLVIDAS');
    mmoInfoCfgSis.Lines.Add('EDA = ENDEREÇAR DIVERGÊNCIAS/AVARIAS / GIS = GUARDAR ITENS JÁ SEPARADOS / GOE = GUARDAR OUTRAS ENTRADAS;');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DVTBCR;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DVTBCR' Then
  Begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Grava Contas a Receber baixado somente quando a venda foi paga em Cartão.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_USALAL;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_USALAL' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 240;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Text := MESSAGE_CFG_LALAMOVE;
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_UASCCR;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_UASCCR') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando utilizar esta configuração ativada, passa a existir na Abreviação de ICMS, alíquota de ICMS para destaque no documento de venda, e alíquota ICMS para cálculo do custo real e impostos.');
    mmoInfoCfgSis.Lines.Add('Deve ser utilizado quando existir benefícios fiscais no Estado, onde destaca-se alíquota cheia e depois faz recuperação do ICMS.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_UDEVME;
Begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_UDEVME' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 130;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, no Endereçamento ficará disponível apenas a quantidade conferida.');
  mmoInfoCfgSis.Lines.Add('Caso a quantidade conferida seja menor que a quantidade da Nota Fiscal, então o saldo a devolver ficará disponível na rotina ''Devolução de Mercadorias - Pré-nota'' ');
  mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------------------------------------------------------------------------------');
  mmoInfoCfgSis.Lines.Add('Para funcionamento deste recurso, o sistema deverá estar configurado da seguinte forma:');
  mmoInfoCfgSis.Lines.Add('------------------------------------------------------------------------------------------------------------------------------------------------');
  mmoInfoCfgSis.Lines.Add('[ CFG_UTIWMS ] Utilizar WMS ( Sistema de Gerenciamento de Armazém )? = NÃO');
  mmoInfoCfgSis.Lines.Add('[ CFG_QTDEND ] Informar quantidade na rotina de endereçamento sem WMS? = SIM');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
End;

procedure TfrmCfgSistema.pAdicionarHintCFG_COFEND;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_COFEND' Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 100;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Ao ativar essa configuração, sistema irá permitir realizar a conferencia parcial, liberando o que já foi conferido para Endereçamento,');
  mmoInfoCfgSis.Lines.Add('e permanecendo com a Conferência do restante em aberto.');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

function TfrmCfgSistema.fValidaCOFEND: Boolean;
begin
  Result := True;

  With cdsCfgSis Do Begin
    If ((cdsCfgSis.FieldByName('SIS_CODCFG').AsString  = 'CFG_COFEND') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((cdsCfgSis.FieldByName('SIS_CODCFG').AsString  = 'CFG_NUMSER') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_COFEND] = "S" com:' + #13#10 +
        '[CFG_NUMSER] = "S" - Utilizar controle simplificado de números de série para produtos, sem necessidade de lote e/ou wms.' + #13#10 + 'Verifique!'
        , ['&Ok']);
      Result := False;
    End Else If ((cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_COFEND') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')) And
       ((cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_TIPPNT') And (cdsCfgSis.FieldByName('SIS_VALCFG').AsString = 'A')) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido utilizar a configuração [CFG_COFEND] = "S" com:' + #13#10 +
        '[CFG_TIPPNT] = "A" -Quando Utiliza Conferência de Mercadorias (CFG_USACON) com Pré-Nota.' + #13#10 +
        'Verifique!', ['&Ok']);
      Result := False;
    End;
  End;
end;

procedure TfrmCfgSistema.pExibeInformacoesClaSub(const Sender: TcxCustomGridTableView; const AItem: TcxCustomGridTableItem);
  Var
    Editor: TcxCustomEdit;
begin
  If (blnExibiuMensagemClaSub) Then
    Exit;
  If (cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_CLASUB') Then
    Exit;
  Try
    Editor := Sender.Controller.EditingController.Edit;
    If (Not Assigned(Editor)) Then
      Exit;
    If (Editor.EditValue = cdsCfgSis.FieldByName('SIS_VALCFG').AsString) Then
      Exit;
    blnExibiuMensagemClaSub := True;
    fMensagem('ATENÇÃO', 'Para conhecimento, existe a configuração [CFG_CLASUF] que controla, em separado, o comportamento da empresa '+
                         'quando à Sub.Tributária para operações de Outras Saidas para Fornecedor, inclusive operações de Envio de Garantia.' + sLineBreak +
                         'Utilize-a, se for este o caso.', ['&OK']);
  Except
  End;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_FREPES;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FREPES') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A configuração só terá efeito se a configuração "CFG_RATFRE" = "Proporcional ao peso do item".');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_FREIPI;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_FREIPI') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('A configuração só terá efeito se a configuração "CFG_RATFRE" = "Proporcional ao valor do item".');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_NSNATP;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_NSNATP') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Quando for informado no Cad.Serviços, será prioritário sobre as todas as regras existentes que determinam esta informação.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_MERCRE;
begin
  If Not cdsCfgSis.FieldByName('SIS_CODCFG').AsString.Equals('CFG_MERCRE') Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 120;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------' +
                          '----------------------------------------------------------------');
  mmoInfoCfgSis.Lines.Add('Esta configuração deve ser ligada quando estiver ocorrendo transferência de valores da Shopee para o Mercado Livre, e posteriormente ');
  mmoInfoCfgSis.Lines.Add('a execução do saque somente pelo Mercado Livre.');
  mmoInfoCfgSis.Lines.Add('São casos onde o lojista "NÃO" pratica a transferência de valores da Shopee para rede bancária diretamente, além de realizar a conciliação ');
  mmoInfoCfgSis.Lines.Add('de recebíveis da Shopee e do Mercado Livre no sistema.');
  mmoInfoCfgSis.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------' +
                          '----------------------------------------------------------------');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DVSPCL;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DVSPCL') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 30;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Esta configuração deve ser utilizada somente quando o coletor estiver configurado para coletar divergências na Separação (CFG_CTGRTN)');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DFLLUB;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_DFLLUB') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema calculará o DIFAL para itens com isenção ou não incidência (CST x30, x40 e x41).' + sLineBreak +
                            'Na Abreviação de ICMS, assegure-se de que todos os campos necessários estejam preenchidos para evitar o recolhimento indevido do DIFAL sobre o valor cheio.');
    mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_LEVREC;
begin
  If Not cdsCfgSis.FieldByName('SIS_CODCFG').AsString.Equals('CFG_LEVREC') Then
    Exit;

  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 60;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Ao ativar esta configuração, o sistema deve gerar o contas a pagar, lendo primeiro o valor do xml contrido em "Valor a Receber" (vRec). ');
  mmoInfoCfgSis.Lines.Add('E caso não tenha valor nesse campo, deve gerar o contas a pagar lendo "Valor total da Prestação" (vTPrest). ');
  mmoInfoCfgSis.Lines[0]    := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DIMPF4;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_DIMPF4' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height      := 40;
  pnlInfoCfgSis.Visible     := True;
  mmoInfoCfgSis.Font.Color  := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Para ocorrer as deduções, deve ativar as configurações [CFG_ICMDEB] e [CFG_FCPBPC] e desativar a configuração [CFG_PDISIF].');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_DOCPRO;
begin
  If cdsCfgSis.FieldByName('SIS_CODCFG').AsString <> 'CFG_DOCPRO' Then
    Exit;
  mmoInfoCfgSis.Clear;
  pnlInfoCfgSis.Height := 40;
  pnlInfoCfgSis.Visible := True;
  mmoInfoCfgSis.Font.Color := clRed;
  mmoInfoCfgSis.Font.Height := 16;
  mmoInfoCfgSis.Lines.Add('Na opção [ 2 ], será permitido lançar Orçamentos sem reduzir a quantidade limite do produto não promoção. ');
  mmoInfoCfgSis.Lines.Add('Somente após a conversão em Pedido de Venda, que passa a reduzir a quantidade limite.');
  mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_GERTRF;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_GERTRF') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Ao concluir a conferência serão gerados Pedidos de Transferência para os produtos divergentes (faltantes ou excedentes).');
    mmoInfoCfgSis.Lines.Add('----------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('Para funcionamento desta rotina, as configurações abaixo deverão estar da seguinte maneira:');
    mmoInfoCfgSis.Lines.Add('----------------------------------------------------------------------------------------------------');
    mmoInfoCfgSis.Lines.Add('* [CFG_USACON] - Utilizar Conferência para Entrada de Mercadorias? = SIM');
    mmoInfoCfgSis.Lines.Add('* [CFG_ENTEND] - Utilizar endereçamento de produtos após processo de Entrada de Mercadoria? = NÃO');
    mmoInfoCfgSis.Lines.Add('* [CFG_CONSIM] - Fazer Entrada de Mercadorias Simplificada somente com conferência <> "NÃO UTILIZA"');
    mmoInfoCfgSis.Lines.Add('* [CFG_COFTRA] - Se utilizar Conferencia para Entrada Simplificada ' +
      'então utilizar processo Devolução de Mercadorias - Pré-nota, quando a Conferência da Entrada Simplificada = "NÃO"');
  end;
end;

procedure TfrmCfgSistema.pAdicionarHintCFG_SEPLCS;
begin
 if (cdsCfgSis.FieldByName('SIS_CODCFG').AsString = 'CFG_SEPLCS') then
  begin
    mmoInfoCfgSis.Clear;
    pnlInfoCfgSis.Height      := 60;
    pnlInfoCfgSis.Visible     := True;
    mmoInfoCfgSis.Font.Color  := clRed;
    mmoInfoCfgSis.Font.Height := 16;
    mmoInfoCfgSis.Lines.Add('Para utilizar a configuração [CFG_SEPLCS] = S, é obrigatório [CFG_UTIWMS] = S');
    mmoInfoCfgSis.Lines[0] := mmoInfoCfgSis.Lines[0] + '';
  end;
end;

end.

