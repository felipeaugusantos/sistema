unit Contabilidade.View.ParametrosContabilizacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, ComboBoxFocus, Vcl.Mask, MaskEditFocus, EditFocus, Uni,
  Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCheckBox, Vcl.DBCtrls,
  Datasnap.DBClient, UniClientDataSet, Contabilidade.View.TfrmPaiContabilidade, Vcl.CheckLst,
  Contabilidade.Interfaces, cxRadioGroup, cxDBLookupComboBox, cxContainer,
  cxCustomListBox, cxCheckListBox, cxMaskEdit, cxCalendar,
  untGeraExcel, untExcel, cxTextEdit;

type
  TFiltroDados = record
    AStrData: string;
    ARadio: TRadioButton;
  end;

  TfrmParametrosContabilizacao = class(TfrmPaiContabilidade)
    pnlParametros: TPanel;
    PanelGroup: TCategoryPanelGroup;
    pnlTipLan: TCategoryPanel;
    pnlForPag: TCategoryPanel;
    edtTipLan: TComboBoxFocus;
    edtForPag: TComboBoxFocus;
    pnlCfop: TCategoryPanel;
    lstCfoTod: TListBox;
    lstCfoSel: TListBox;
    Label10: TLabel;
    Label1: TLabel;
    pnlNatOpe: TCategoryPanel;
    edtNatOpe: TComboBoxFocus;
    pnlValor: TCategoryPanel;
    edtValor: TComboBoxFocus;
    btnAddCfo: TBitBtnLocked;
    btnClaTod: TBitBtnLocked;
    CategoryPanelGroup2: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    edtDesContaCRedito: TEditFocus;
    edtDesContaDebito: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnConfirmar: TBitBtnLocked;
    edtCmpDebito: TComboBoxFocus;
    edtHisCre: TEditFocus;
    pnlGrid: TPanel;
    dtsDados: TDataSource;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1CON_TIPPLA: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CFOP: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_FORPGO: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_NATOPE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_DESVAL: TcxGridDBColumn;
    edtDesHisCre: TEditFocus;
    btnAddTod: TBitBtnLocked;
    cxGridCitel1DBTableViewCitel1CON_CONCRE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_CFCRED: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_CFDEBI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_CONDEB: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_PORCRE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_PORDEB: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1HISCRE: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_CMPDEB: TcxGridDBColumn;
    btnRemTod: TBitBtnLocked;
    btnRemCfo: TBitBtnLocked;
    cxGridCitel1DBTableViewCitel1DESDEB: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1DESCRE: TcxGridDBColumn;
    Splitter1: TSplitter;
    pnlFundo: TPanel;
    mskContaCredito: TMaskEditFocus;
    mskContaDebito: TMaskEditFocus;
    Label11: TLabel;
    cxGridCitel1DBTableViewCitel1CON_PCCRED: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_PCDEBI: TcxGridDBColumn;
    Label12: TLabel;
    edtNatCfo: TDBLookupComboBox;
    dtsNatCfo: TDataSource;
    pnlPagamentos: TCategoryPanel;
    edtPagamentos: TComboBoxFocus;
    cdsNatKey: TUniClientDataSet;
    cdsNatKeyKeyValue: TStringField;
    dtsNatKey: TDataSource;
    pnlOrigem: TCategoryPanel;
    edtOrigem: TComboBoxFocus;
    btnPlaNcoDeb: TBitBtnLocked;
    btnPlaNcoCre: TBitBtnLocked;
    Label13: TLabel;
    gbCredito: TGroupBox;
    chkCliForCre: TCheckBox;
    chkPorCre: TCheckBox;
    chkPlaConCre: TCheckBox;
    rdbCreCad: TRadioButton;
    rdbCreBai: TRadioButton;
    gbDebito: TGroupBox;
    chkCliForDeb: TCheckBox;
    chkPorDeb: TCheckBox;
    chkPlaConDeb: TCheckBox;
    rdbDebBai: TRadioButton;
    rdbDebCad: TRadioButton;
    Label14: TLabel;
    chkBandeiraDebito: TCheckBox;
    chkBandeiraCredito: TCheckBox;
    cklComplemento: TCheckListBox;
    Label15: TLabel;
    chkAbrevDebito: TCheckBox;
    chkAbrevCredito: TCheckBox;
    pnlAdiantamento: TCategoryPanel;
    edtAdiantamento: TComboBoxFocus;
    edtContaReduzidaCredito: TEditFocus;
    edtContaReduzidaDebito: TEditFocus;
    Label16: TLabel;
    pnlTitPDD: TCategoryPanel;
    rgTitPDD: TRadioGroup;
    cxGridCitel1DBTableViewCitel1CON_TITPDD: TcxGridDBColumn;
    pnlCst: TCategoryPanel;
    edtCST: TComboBoxFocus;
    cxGridCitel1DBTableViewCitel1CON_CODTRI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_NATCFO: TcxGridDBColumn;
    pnlMarketPlace: TCategoryPanel;
    lstMarketPlace: TcxCheckListBox;
    cxGridCitel1DBTableViewCitel1CON_CODORI: TcxGridDBColumn;
    pnlGrupoProd: TCategoryPanel;
    cxGridCitel1DBTableViewCitel1CON_CODGRU: TcxGridDBColumn;
    cdsGrupoProd: TUniClientDataSet;
    cdsGrupoProdSELECI: TBooleanField;
    dsGrupoProd: TDataSource;
    cdsGrupoProdGRUPO: TStringField;
    GridGrupoTableView: TcxGridDBTableViewCitel;
    GridGrupoLevel1: TcxGridLevel;
    GridGrupo: TcxGridCitel;
    GridGrupoTableViewSELECI: TcxGridDBColumn;
    GridGrupoTableViewGRUPO: TcxGridDBColumn;
    cdsGrupoProdCODGRU: TStringField;
    cdsGrupoProdDESGRU: TStringField;
    pnlFiltros: TPanel;
    rdbInativos: TRadioButton;
    rdbAtivos: TRadioButton;
    rdbTodos: TRadioButton;
    Label17: TLabel;
    mskDataExibicao: TMaskEditFocus;
    Label18: TLabel;
    cxGridCitel1DBTableViewCitel1STATUS: TcxGridDBColumn;
    StyleRepository: TcxStyleRepository;
    estiloInativo: TcxStyle;
    estiloPadrao: TcxStyle;
    CategoryPanel2: TCategoryPanel;
    mskVigIni: TMaskEditFocus;
    Label19: TLabel;
    Label20: TLabel;
    mskVigFin: TMaskEditFocus;
    cxGridCitel1DBTableViewCitel1CON_VIGINI: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1CON_VIGFIN: TcxGridDBColumn;
    btnExportar: TBitBtnLocked;
    cxGridCitel1DBTableViewCitel1CON_PAGAME: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1ORIGEM: TcxGridDBColumn;
    pnlOrigemCPC: TCategoryPanel;
    lstOrigemCPC: TcxCheckListBox;
    cxGridCitel1DBTableViewCitel1CON_PAGANT: TcxGridDBColumn;
    procedure edtTipLanChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddCfoClick(Sender: TObject);
    procedure lstCfoSelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnClaTodClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtHisCreKeyPress(Sender: TObject; var Key: Char);
    procedure chkCliForCreClick(Sender: TObject);
    procedure chkPorCreClick(Sender: TObject);
    procedure chkCliForDebClick(Sender: TObject);
    procedure chkPorDebClick(Sender: TObject);
    procedure cxGridCitel1DBTableViewCitel1DblClick(Sender: TObject);
    procedure edtHisCreExit(Sender: TObject);
    procedure lstCfoSelDblClick(Sender: TObject);
    procedure lstCfoTodDblClick(Sender: TObject);
    procedure btnRemCfoClick(Sender: TObject);
    procedure cxGridCitel1DBTableViewCitel1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnAddTodClick(Sender: TObject);
    procedure btnRemTodClick(Sender: TObject);
    procedure mskContaCreditoExit(Sender: TObject);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoExit(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure chkPlaConCreClick(Sender: TObject);
    procedure chkPlaConDebClick(Sender: TObject);
    procedure edtNatCfoDropDown(Sender: TObject);
    procedure edtPagamentosExit(Sender: TObject);
    procedure btnPlaNcoDebClick(Sender: TObject);
    procedure btnPlaNcoCreClick(Sender: TObject);
    procedure chkBandeiraDebitoClick(Sender: TObject);
    procedure chkBandeiraCreditoClick(Sender: TObject);
    procedure edtForPagExit(Sender: TObject);
    procedure chkAbrevDebitoClick(Sender: TObject);
    procedure chkAbrevCreditoClick(Sender: TObject);
    procedure edtForPagChange(Sender: TObject);
    procedure edtOrigemChange(Sender: TObject);
    procedure edtValorEnter(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure edtContaReduzidaDebitoExit(Sender: TObject);
    procedure edtContaReduzidaDebitoEnter(Sender: TObject);
    procedure edtContaReduzidaCreditoEnter(Sender: TObject);
    procedure edtContaReduzidaCreditoExit(Sender: TObject);
    procedure rdbAtivosClick(Sender: TObject);
    procedure rdbInativosClick(Sender: TObject);
    procedure rdbTodosClick(Sender: TObject);
    procedure mskDataExibicaoExit(Sender: TObject);
    procedure cxGridCitel1DBTableViewCitel1StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnExportarClick(Sender: TObject);
    procedure lstOrigemCPCClickCheck(Sender: TObject; AIndex: Integer;
      APrevState, ANewState: TcxCheckBoxState);
  private
    { Private declarations }
    qryCadCfo : TUniQuery;
    qryNatCfo : TUniQuery;
    lstTodosCfops    : TStringList;
    lstTodosCfopsEnt : TStringList;
    lstTodosCfopsSai : TStringList;
    qryParCon : TUniQuery;
    strMascara : String;
    blnCON_ORIGEM : Boolean;
    blnCON_BANDEB : Boolean;
    blnCON_ABFDEB : Boolean;
    blnCON_PAGANT : Boolean;
    blnCON_TITPDD : Boolean;
    cdsConDeb : TUniClientDataSet;
    cdsConCre : TUniClientDataSet;
    strTplAco : String;
    blnAltera : Boolean;
    intAltera : Integer;
    strSeqPar : String;
    // CON_TIPLAN do registro carregado para alteração; vazio = nenhum registro carregado
    strTipLanOriginal : String;
    blnUsaCheckListComplemento : boolean;
    intRegAlt: integer;
    blnRotinaImobilizado : boolean;
    FblnCadGruExiste : boolean;
    FstrContaReduzidaDebito : string ;
    FstrContaReduzidaCredito : string ;
    FblnDescontoHub: Boolean ;
    FblnFreteHub: Boolean ;
    FblnAjusteHub: Boolean ;
    FblnDesligaContaReduzidaNaPesquisa: Boolean ;
    FFiltroAtual: TFiltroDados;
    blnRotinaCPC: boolean;
    blnRotinaANT: boolean;
    function fVerificaHistoricoComplemento:boolean;
    function fValidaDuplicidade(const blnModoIncluir:boolean=False):boolean;
    procedure pCarregaCfo;
    procedure pAddCfop(lstOrigem, lstDestino: TListBox; blnFocu: Boolean = False);
    procedure pCarregaParCon;
    procedure pLimparTela;
    function fGetIndexTipLan(strTipLan: String): Integer;
    procedure pCarregarDadosEmTela;
    procedure pLimparGrupoLancamentos;
    procedure pCarregaNatCfo;
    procedure pAtualizaMd5;
    function fObrigaParteContraria: Boolean;
    function fMD5Chave(strClaFis, strPagamentos, strOrigem, strPagant: String): String;
    procedure pSetaItensCTR_PCR(var cmbItens: TComboBoxFocus);
    procedure pSetaItensCTP_PCP(var cmbItens: TComboBoxFocus);
    procedure pSetarNatOpe(AValue: String);
    procedure pCarregaContasDesmem(strMd5Key, strSeqPar: String);
    procedure pCarregaCdsContasDesmem(const strMd5Key, strSeqPar, strCreDeb: String; var Acds: TUniClientDataSet);
    procedure pDeletarContasDesmem(const strSeqPar: String);
    procedure pGravarContasDesmem(strMd5Key, strSeqPar: String);
    procedure pAjustaDesmem(btn: TBitBtnLocked; cds: TUniClientDataSet);
    procedure pAjustaDataDeLancamentoDebito;
    procedure pAjustaDataDeLancamentoCredito;
    function fPermiteParametrizarBandeira(blnCampoExiste: Boolean): boolean;
    function fPermiteParametrizarAbreviacao(blnCampoExiste: Boolean): boolean;
    procedure pStatusLinhaDebito(blnHabilitado: Boolean);
    procedure pStatusLinhaCredito(blnHabilitado: Boolean);
    function fUtilizouFormaDePagamentoCartao: boolean;
    procedure pDeletarParametro(strSeqPar: String);
    procedure pCarregarListaDeComplementos;
    procedure pGravarComplementos(strMd5Key, strSeqPar: string);
    procedure pCarregarComboDeComplementos;
    procedure pCarregarDadosDoComplemento(strMd5Key, strSeqPar: string; strComplementoAntigo: string = '');
    procedure pDeletarDadosDoComplemento(const strSeqPar: string);
    procedure pSetaInformacaoFormaCreditoCtp;
    function fValidaSAI_ENT(const strTipLan: string): Boolean;
    procedure pPopularComboBoxOrigem(const ATipoContabil: TTiposContabeis);
    procedure pCarregarTipoImobilizaveis(Items: TStrings);
    function fgetOrigemSelecionada: string;
    function fgetIndexOrigem(const AOrigem: string): integer;
    function fValidouTravaCustoMercadoriaVendida(const ATipoSelecionado: TTiposContabeis; const AClaFis: string): boolean;
    function fLancouContasIguais: boolean;
    procedure pSetaItensGNRE(cmbItens: TComboBoxFocus);
    procedure pSetaItensPDD(cmbItens: TComboBoxFocus);
    function fUtilizouFormaDePagamentoDescontoTotal: boolean;
    procedure pMostraPnlPagamentosBan(const AOrigem: String) ;
    procedure pMostraPnlFormaPagamentosBan(const AOrigem: String) ;
    procedure pLimpaTodosPagamentoBan ;
    procedure pCarregaFormaPagamentosPadrao ;
    procedure pCarregaFormaPagamentoPCP ;
    procedure pCarregaPagamentoPCP ;
    procedure pCarregaPagamentoCTP ;
    procedure pCarregaFormaPagamentoPCR ;
    procedure pCarregaPagamentoPCR ;
    procedure pCarregaPagamentoCTR ;
    procedure pMensagemISSRetido(const AValor: string) ;
    procedure pCarregaCST ;
    procedure pMostrarCST(const ATipoContabil: TTiposContabeis) ;
    procedure pHabilitarCST(const ACfop: TStrings) ;
    procedure pAjustaCheckPlanoContas ;
    function fVerificaContaContabilEmpresaLogada:boolean ;
    procedure pSetaItensAGR(cmbItens: TComboBoxFocus);
    procedure pSetaItensTCC(cmbItens: TComboBoxFocus);
    procedure pCarregaValorAGR(const AOrigem: String);
    procedure pCarregaMarketPlace(var AlstItens: TcxCheckListBox);
    procedure pSetMarketPlace(const AfldParcon: TFields; var AlstItens: TcxCheckListBox);
    function fCodigoSelMarketPlace(const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel):string ;
    procedure pSalvaMarketPlace(AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
    procedure pParamMarketPlace(var AqryParam: TUniQuery; const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
    procedure pParamLocateMarketPlace(var AqryParam: TUniQuery; const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
    procedure pLimpaMarketPlaceSel(var AlstItens: TcxCheckListBox);
    procedure pParamGrupoProd(var AqryParam: TUniQuery; const AfldParcon: TFields; const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel);
    function  fCodigoSelGrupoProd(const AfldParcon: TFields; const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel):string ;
    procedure pSalvaGrupoProd(AfldParcon: TFields; const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel);
    procedure pParamLocateGrupoProd(var AqryParam: TUniQuery; const AfldParcon: TFields; const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel);
    procedure pLimpaGrupoProdSel(var AcdsDados: TUniClientDataSet);
    procedure pSetGrupoProd(const AfldParcon: TFields; var AcdsDados: TUniClientDataSet);
    procedure pCarregaGrupoProd(var AcdsDados: TUniClientDataSet);
    procedure pSalvaEmpresaLogada(AfldParcon: TFields) ;
    function fRetornaValorDescricao:string ;
    procedure pLogDelParcon ;
    procedure pLogDelParNco ;
    procedure pAjustaWhereParcon(var AqryParcon: TUniQuery) ;
    function fSeqParValido: Boolean ;
    function fRetornaMd5Key: String ;
    function fHabilitaPlanoContasSAI: Boolean ;
    function fHabilitaPlanoContasCoeCos: Boolean ;
    procedure pAdicionaOpcaoFreteHub ;
    procedure pAdicionaOpcaoDescontoHub ;
    procedure pAdicionaOpcaoAjusteHub ;
    function fHabilitaFormasPagamentoCaixaCRC: Boolean ;
    function fPlanoContabilConfiguradoOutrosModulosCredito: Boolean ;
    function fPlanoContabilConfiguradoOutrosModulosDebito: Boolean ;
    procedure pConfiguraVendorCampoValorCTP(var AComboBoxValor: TComboBoxFocus) ;
    function fVerificaRegistroEmEdicao: Boolean;
    procedure pAtualizaFiltroAtual;
    procedure pReverteParaFiltroAtual(Sender: TWinControl);
    function fSelecionouFiltroAtual(Sender: TWinControl): Boolean;
    procedure pFiltrar(Sender: TWinControl);
    function fValidaVigencia: Boolean;
    function fPreencheuVigencia: Boolean;
    function fPreencheuVigenciaFinal: Boolean;
    procedure pAtualizaVigenciaNull;
    function fGetDatasetDuplicados(const blnModoIncluir: boolean): TDataSet;
    function fPeriodosSeSobrepoem(dtaIni1, dtaFin1, dtaIni2, dtaFin2: TDateTime): Boolean;
    function fRetDataVigInicial(const AStrData: string): TDate;
    function fRetDataVigFinal(const AStrData: string): TDate;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure pConfiguraPICORFCampoValor(var AComboBoxValor: TComboBoxFocus) ;
    procedure pAjustaCampoForPgo;
    procedure pCarregaOrigemCPC(var AlstItens: TcxCheckListBox);
    procedure pSetOrigemCPC(const AfldParcon: TFields; var AlstItens: TcxCheckListBox);
    function fCodigoSelOrigemCPC(const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel):string ;
    procedure pSalvaOrigemCPC(AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel);
    procedure pParamOrigemCPC(var AqryParam: TUniQuery; const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel);
    procedure pParamLocateOrigemCPC(var AqryParam: TUniQuery; const AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel);
    procedure pLimpaOrigemCPCSel(var AlstItens: TcxCheckListBox);
    procedure pSetaItensCPC(cmbItens: TComboBoxFocus);
    function fValidaCPC(const strTipLan: string): Boolean;
    procedure pSetaItensANT(cmbItens: TComboBoxFocus);
    procedure pCarregaPagamentoANT ;
    function fPeloMenosUmaContaInformada: Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strSeqParIniciarCadastro: String;
  end;

implementation

{$R *.dfm}

uses StrUtils, untConstantes, untTypesSistema, Contabilidade.Funcoes,
     untFuncoesSimples, Contabilidade.Consultas,
     untFuncoes, Contabilidade.View.ContasPorEmpresa, System.MaskUtils,
     untFuncoesHash, System.Generics.Collections, System.Types, System.DateUtils,
     Contabilidade.Classes.THashParCon, Contabilidade.Classes.LogAjcOp,
     Contabilidade.Classes.UniQueryAuditoria;

procedure TfrmParametrosContabilizacao.btnRemCfoClick(Sender: TObject);
begin
  inherited;
  pAddCfop(lstCfoSel, lstCfoTod);
  pHabilitarCST(lstCfoSel.Items);
  pSetarNatOpe('');
end;

procedure TfrmParametrosContabilizacao.btnRemTodClick(Sender: TObject);
begin
  inherited;
  lstCfoSel.Items.Clear;
  If (edtTipLan.ItemIndex = 5) Then
    lstCfoTod.Items.Assign(lstTodosCfopsEnt)
  Else If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcSAI], COD_CONTABIL[tcCMV]]) Then
    lstCfoTod.Items.Assign(lstTodosCfopsSai)
  Else If (edtTipLan.ItemIndex In [7,8]) Then
    lstCfoTod.Items.Assign(lstTodosCfops);
  pHabilitarCST(lstCfoSel.Items);
  pSetarNatOpe('');
end;

procedure TfrmParametrosContabilizacao.btnAddTodClick(Sender: TObject);
begin
  inherited;
  lstCfoTod.Items.Clear;
  If (edtTipLan.ItemIndex = 5) Then
    lstCfoSel.Items.Assign(lstTodosCfopsEnt)
  Else If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcSAI], COD_CONTABIL[tcCMV]]) Then
    lstCfoSel.Items.Assign(lstTodosCfopsSai)
  Else If (edtTipLan.ItemIndex In [7,8]) Then
    lstCfoSel.Items.Assign(lstTodosCfops);
  pHabilitarCST(lstCfoSel.Items);
end;

procedure TfrmParametrosContabilizacao.btnAddCfoClick(Sender: TObject);
begin
  inherited;
  pAddCfop(lstCfoTod, lstCfoSel);
  pHabilitarCST(lstCfoSel.Items);
end;

procedure TfrmParametrosContabilizacao.btnClaTodClick(Sender: TObject);
  Var
    intCnt : Integer;
    arrAdd : Array Of String;
    strCaption : String;
begin
  inherited;
  SetLength(arrAdd, 0);
  strCaption := btnClaTod.Caption;
  If strCaption.Contains('compra') Then
  Begin
    for intCnt := 0 To lstCfoTod.Count-1 Do
    begin
      If VS_strClaCom.Contains(lstCfoTod.Items[intCnt]) Then
      begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[Length(arrAdd)-1] := lstCfoTod.Items[intCnt];
      end;
    end;
  End
  Else If strCaption.Contains('venda') Then
  Begin
    for intCnt := 0 To lstCfoTod.Count-1 Do
    begin
      If (VS_strClaVen.Contains(lstCfoTod.Items[intCnt])) Then
      begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[Length(arrAdd)-1] := lstCfoTod.Items[intCnt];
      end;
    end;
  End;

  for intCnt := Low(arrAdd) To High(arrAdd) do
  begin
    lstCfoTod.Selected[lstCfoTod.Items.IndexOf(arrAdd[intCnt])] := True;
    pAddCfop(lstCfoTod, lstCfoSel);
  end;

  pHabilitarCST(lstCfoSel.Items);

end;

procedure TfrmParametrosContabilizacao.btnConfirmarClick(Sender: TObject);
  Var
    qryInsert : TUniQuery;
    blnConfirma : Boolean;
    strMd5Key : String;
    strTipLan: string;
    blnCancelarOperacao : boolean;
    dtaAux : TDateTime;
begin
  inherited;

  blnConfirma := False;

  If (pnlTipLan.Visible) Then
  Begin
    If (edtTipLan.ItemIndex < 0) Then
    Begin
      fMensagem('ATENÇÃO!','Tipo de Lançamento deve ser preenchido!',['&OK']);
      Exit;
    End;

    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcPCP]]) And
       (Not ((chkPlaConDeb.Checked) Or (chkPlaConCre.Checked))) then
    begin
      fMensagem('ATENÇÃO!','Provisão necessita que crédito ou débito seja no "plano de contas"!',['&OK']);
      Exit;
    end;
  End;

  if (not blnRotinaImobilizado) and (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcIMO]) then
  begin
    fMensagem('ATENÇÃO!','A versão atual não suporta a rotina de imobilizado, solicite atualização!',['&OK']);
    Exit;
  end;

  if (not blnRotinaCPC) and (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCPC]) then
  begin
    fMensagem('ATENÇÃO!','A versão atual não suporta a rotina de CPC, solicite atualização!',['&OK']);
    Exit;
  end;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcANT]) and (not blnRotinaANT) then
  begin
    fMensagem('ATENÇÃO!','A versão atual não é compatível com a rotina ANT!',['&OK']);
    Exit;
  end;

  If (pnlForPag.Visible) Then
  Begin
    If (edtForPag.ItemIndex < 0) Then
    Begin
      fMensagem('ATENÇÃO!','Forma de Pagamento deve ser preenchido!',['&OK']);
      Exit;
    End;
  End;

  If (pnlCfop.Visible) Then
  Begin
    If (lstCfoSel.Count < 0) Then
    Begin
      fMensagem('ATENÇÃO!','Deve ser informado alguma informação no CFOP!',['&OK']);
      Exit;
    End;
  End;

  If (pnlNatOpe.Visible) Then
  Begin
    If (edtNatOpe.ItemIndex < 0) Then
    Begin
      fMensagem('ATENÇÃO!','A Condição de pagamento deve ser preenchida!',['&OK']);
      Exit;
    End;
  End;

  If (pnlPagamentos.Visible) Then
  Begin
    If (edtPagamentos.ItemIndex < 0) Then
    Begin
      fMensagem('ATENÇÃO!','O pagamento deve ser preenchido!',['&OK']);
      Exit;
    End;
  End;

  if (pnlOrigem.Visible) then
  begin
    if (edtOrigem.ItemIndex < 0) then
    begin
      fMensagem('ATENÇÃO!','A origem deve ser preenchida!',['&OK']);
      Exit;
    end;
  end;

  { fPreencheuVigencia / fPreencheuVigenciaFinal só testam se há texto, não se é data
    válida. Sem esta crítica, algo como "31/__/2024" atravessa e só estoura lá na frente,
    no StrToDate entre o Edit e o Post. Verificar Nota 1 - Req. 462247. }
  If (Not fEmptyStr(fTiraCaracEspeciais(mskVigIni.Text))) And
     (Not TryStrToDate(mskVigIni.Text, dtaAux)) Then
  Begin
    fMensagem('ATENÇÃO!','A data inicial de vigência é inválida!',['&OK']);
    Exit;
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text))) And
     (Not TryStrToDate(mskVigFin.Text, dtaAux)) Then
  Begin
    fMensagem('ATENÇÃO!','A data final de vigência é inválida!',['&OK']);
    Exit;
  End;

  If (fObrigaParteContraria) Then
  Begin
    If ((fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) and (cdsConCre.IsEmpty)) And
       (Not chkCliForCre.Checked) And
       (Not chkPorCre.Checked) And
       (Not chkPlaConCre.Checked) and
       (Not chkAbrevCredito.Checked) Then
    Begin
      fMensagem('ATENÇÃO!','O lançamento de crédito deve ser preenchido com alguma das opções:' + sLineBreak +
                           '[Conta] ou [Cli/For] ou [Portador] ou [Plano de Contas] ou [Abreviação]!',['&OK']);
      Exit;
    End;

    If ((fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) and (cdsConDeb.IsEmpty)) And
       (Not chkCliForDeb.Checked) And
       (Not chkPorDeb.Checked) And
       (Not chkPlaConDeb.Checked) and
       (Not chkAbrevDebito.Checked) Then
    Begin
      fMensagem('ATENÇÃO!','O lançamento de débito deve ser preenchido com alguma das opções:' + sLineBreak +
                           '[Conta] ou [Cli/For] ou [Portador] ou [Plano de Contas] ou [Abreviação]!',['&OK']);
      Exit;
    End;
  End;

  if (chkBandeiraDebito.Checked or chkBandeiraCredito.Checked) and
     (Not fUtilizouFormaDePagamentoCartao) And
     (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCAR]) then
  begin
    fMensagem('ATENÇÃO!','Ao utilizar crédito/débito na bandeira a forma de pagamento deve ser "Cartão"',['&OK']);
    Exit;
  end;

  if fUtilizaNaturezaDeOperacao(LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)) then
  begin
    if (lstCfoSel.Count > 1) and (not VarIsNull(edtNatCfo.KeyValue)) Then
    begin
      fMensagem('ATENÇÃO!','Quando selecionar mais de um CFOP a natureza de operação não deve ser preenchida!', ['&OK']);
      Exit;
    end;
  end;

  if (fLancouContasIguais) then
  begin
    fMensagem('ATENÇÃO!','Não é permitido o lançamento das contas de crédito e débito iguais!', ['&OK']);
    exit;
  end;

  If fEmptyStr(fRetornaValorDescricao) Then
  Begin
    fMensagem('ATENÇÃO!','O valor deve ser preenchido!',['&OK']);
    Exit;
  End;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCMV]) then
  begin
    if not fValidouTravaCustoMercadoriaVendida(tcCMV, lstCfoSel.Items.CommaText) then
    begin
      fMensagem('ATENÇÃO!','Não é possível efetuar lançamentos do tipo CMV, este já foi lançado no TIPO SAI!',['&OK']);
      Exit;
    end;
  end;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcSAI]) and
     (edtValor.Items[edtValor.ItemIndex] = DES_VALOR_CMV) then
  begin
    if not fValidouTravaCustoMercadoriaVendida(tcSAI, lstCfoSel.Items.CommaText) then
    begin
      fMensagem('ATENÇÃO!','Não é possível efetuar lançamentos do tipo SAI, com Valor "' + edtValor.Items[edtValor.ItemIndex] + '", este já foi lançado no TIPO CMV!',['&OK']);
      Exit;
    end;
  end;

  if not fVerificaHistoricoComplemento then
  begin
    fMensagem('ATENÇÃO!','Histórico ou/e complemento deve(m) ser informado(s)!',['&OK']);
    Exit;
  end ;

  if not fPeloMenosUmaContaInformada then
  begin
    fMensagem('ATENÇÃO!','Pelo menos um plano de contas deve ser informado!',['&OK']);
    Exit;
  end ;

  if not fValidaVigencia then
  begin
    exit ;
  end;

  //////valida para evitar duplicidade
  if not fValidaDuplicidade then
  begin
    exit ;
  end;

  qryInsert := fCriaQuery(Self);
  Try
    qryInsert.SQL.Add(' SELECT * ');
    qryInsert.SQL.Add('   FROM PARCON ');
    qryInsert.SQL.Add('  WHERE CON_TIPLAN = :TIPLAN ');
    qryInsert.SQL.Add('    AND CON_FORPGO = :FORPGO ');
    qryInsert.SQL.Add('    AND CON_DESVAL = :DESVAL ');
    qryInsert.SQL.Add('    AND CON_NATOPE = :NATOPE ');
    qryInsert.SQL.Add('    AND CON_CLAFIS = :CLAFIS ');
    qryInsert.SQL.Add('    AND CON_MD5CLA = :MD5CLA ');
    qryInsert.SQL.Add('    AND IFNULL(CON_PAGAME,"") = :PAGAME ');
    if (blnCON_ORIGEM) then
      qryInsert.SQL.Add('  AND IFNULL(CON_ORIGEM,"") = :ORIGEM ');
    if (blnCON_PAGANT) then
      qryInsert.SQL.Add('  AND IFNULL(CON_PAGANT,"") = :PAGANT ');
    if fColunaExisteConCodTri then
    begin
      qryInsert.SQL.Add('  AND IFNULL(CON_CODTRI,"") = :CODTRI ');
      qryInsert.ParamByName('CODTRI').AsString := edtCST.Items[edtCST.ItemIndex];
    end;

    If (Not VarIsNull(edtNatCfo.KeyValue)) Then
    begin
      qryInsert.SQL.Add('    AND CON_NATCFO = :NATCFO ');
      qryInsert.ParamByName('NATCFO').AsString := edtNatCfo.KeyValue ;
    end
    else
     qryInsert.SQL.Add('    AND CON_NATCFO IS NULL ');

    if fPreencheuVigencia then
    begin
      qryInsert.SQL.Add(' AND CON_VIGINI = :VIGINI ');
      qryInsert.ParamByName('VIGINI').AsDate := StrToDate(mskVigIni.Text);
    end
    else
      qryInsert.SQL.Add(' AND CON_VIGINI IS NULL ');

    pSetarFiltroEmpresa(qryInsert) ;
    pParamMarketPlace(qryInsert, qryParCon.Fields, lstMarketPlace, pnlMarketPlace) ;
    pParamOrigemCPC(qryInsert, qryParCon.Fields, lstOrigemCPC, pnlOrigemCPC) ;
    pParamGrupoProd(qryInsert, qryParCon.Fields, cdsGrupoProd, pnlGrupoProd) ;
    qryInsert.ParamByName('TIPLAN').AsString := LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3);
    qryInsert.ParamByName('FORPGO').AsString := edtForPag.Items[edtForPag.ItemIndex];
    qryInsert.ParamByName('DESVAL').AsString := fRetornaValorDescricao;
    qryInsert.ParamByName('NATOPE').AsString := edtNatOpe.Items[edtNatOpe.ItemIndex];
    qryInsert.ParamByName('PAGAME').AsString := edtPagamentos.Items[edtPagamentos.ItemIndex];
    qryInsert.ParamByName('CLAFIS').AsString := lstCfoSel.Items.CommaText;
    qryInsert.ParamByName('MD5CLA').AsString := fMD5Chave(qryInsert.ParamByName('CLAFIS').AsString, edtPagamentos.Items[edtPagamentos.ItemIndex], fgetOrigemSelecionada, edtAdiantamento.Items[edtAdiantamento.ItemIndex]);
    if (blnCON_ORIGEM) then
      qryInsert.ParamByName('ORIGEM').AsString := fgetOrigemSelecionada;
    if (blnCON_PAGANT) then
      qryInsert.ParamByName('PAGANT').AsString := edtAdiantamento.Items[edtAdiantamento.ItemIndex];
    qryInsert.Open;

    If (Not qryInsert.IsEmpty) Or (blnAltera) Then
    begin
      intAltera := fMensagem('', 'Os dados atuais foram modificados. O que deseja fazer?', ['&Alterar', '&Incluir Novo', '&Cancelar'], 1);
      blnCancelarOperacao := (intAltera = 3);
    end
    Else
    Begin
      blnConfirma := (fMensagem('', 'Confirmar inclusão do parâmetro?', ['&Sim', '&Não'], 1) = 1);
      intAltera := 2;
      blnCancelarOperacao := (not blnConfirma);
    End;

    // Impede ALTERAR quando o Tipo de Lançamento mudou: o caminho intAltera=1 reaproveita
    // o mesmo CON_SEQPAR e sobrescreve o registro, destruindo a rastreabilidade. Trocar de
    // tipo exige "Incluir Novo" (intAltera=2), que gera SEQPAR próprio e roda
    // fValidaDuplicidade / fValidaSAI_ENT / fValidaCPC.
    If (intAltera = 1) And (blnAltera) And (edtTipLan.ItemIndex >= 0) And
       (Not fEmptyStr(strTipLanOriginal)) And
       (LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3) <> strTipLanOriginal) Then
    Begin
      fMensagem('ATENÇÃO!',
                'Não é permitido ALTERAR o Tipo de Lançamento de um parâmetro existente ' +
                '(de "' + strTipLanOriginal + '" para "' +
                LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3) + '").' + sLineBreak + sLineBreak +
                'Para mudar o tipo utilize "Incluir Novo": será gerado um novo parâmetro com ' +
                'novo código, preservando a rastreabilidade do registro original.',
                ['&OK']);
      Exit;
    End;

    If (not blnCancelarOperacao) and ((intAltera=1) Or (intAltera=2)) Then
    Begin
      If (intAltera=2) Then
      begin
        if not fValidaDuplicidade(True) then
        begin
          exit ;
        end;
      end;
      strTipLan := LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3);
      if ((strTipLan = 'SAI') or (strTipLan = 'ENT')) and (not fValidaSAI_ENT(strTipLan)) then
      begin
        fMensagem('ATENÇÃO!','Não foi possível efetivar este conjunto de Parâmetros pois entra em conflito com outro conjunto de Parâmetros existente',['&OK']);
        Exit;
      end;

      if not fValidaCPC(strTipLan) then
      begin
        fMensagem('ATENÇÃO!','Não foi possível efetivar este conjunto de Parâmetros pois entra em conflito com outro conjunto de Parâmetros existente',['&OK']);
        Exit;
      end;

      If (qryParCon.FindField('CON_SEQPAR') <> Nil) Then
      Begin
        If (intAltera=2) Then
          strSeqPar := fAtualizaProCod('PARCON', 'CON_SEQPAR')
        Else
        begin
          strSeqPar := qryParCon.FieldByName('CON_SEQPAR').AsString;
          if fEmptyStr(strSeqPar) then
            strSeqPar := fAtualizaProCod('PARCON', 'CON_SEQPAR')
        end;

      End;

      TLogAjcOpContext.BeginContext;
      fStartTransaction;

      Try
      try

        If (blnConfirma) Or (intAltera=2) Then
        Begin
          qryParCon.Append;
          If (qryParCon.FindField('CON_SEQPAR') <> Nil) Then
            qryParCon.FieldByName('CON_SEQPAR').AsString := strSeqPar;
          qryParCon.FieldByName('CON_TIPLAN').AsString := LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3);
          qryParCon.FieldByName('CON_FORPGO').AsString := edtForPag.Items[edtForPag.ItemIndex];
          qryParCon.FieldByName('CON_NATOPE').AsString := edtNatOpe.Items[edtNatOpe.ItemIndex];
          qryParCon.FieldByName('CON_DESVAL').AsString := fRetornaValorDescricao;
          qryParCon.FieldByName('CON_PAGAME').AsString := edtPagamentos.Items[edtPagamentos.ItemIndex];
          qryParCon.FieldByName('CON_CLAFIS').AsString := lstCfoSel.Items.CommaText;
          If (Not VarIsNull(edtNatCfo.KeyValue)) Then
            qryParCon.FieldByName('CON_NATCFO').AsString := edtNatCfo.KeyValue
          Else
            qryParCon.FieldByName('CON_NATCFO').Value := null;

          if fPreencheuVigencia then
            qryParcon.FieldByName('CON_VIGINI').AsDateTime := StrToDate(mskVigIni.Text)
          else
            qryParcon.FieldByName('CON_VIGINI').Clear;

          if fPreencheuVigenciaFinal then
            qryParcon.FieldByName('CON_VIGFIN').AsDateTime := StrToDate(mskVigFin.Text)
          else
            qryParcon.FieldByName('CON_VIGFIN').Clear;
          qryParCon.FieldByName('CON_MD5CLA').AsString := fRetornaMd5Key ;
        End
        Else If (intAltera=1) Then
        Begin
          qryParCon.Edit;
          If (qryParCon.FindField('CON_SEQPAR') <> Nil) Then
            qryParCon.FieldByName('CON_SEQPAR').AsString := strSeqPar;
          qryParCon.FieldByName('CON_TIPLAN').AsString := LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3);
          qryParCon.FieldByName('CON_DESVAL').AsString := fRetornaValorDescricao;
          qryParCon.FieldByName('CON_FORPGO').AsString := edtForPag.Items[edtForPag.ItemIndex];
          qryParCon.FieldByName('CON_CLAFIS').AsString := lstCfoSel.Items.CommaText;
          qryParCon.FieldByName('CON_PAGAME').AsString := edtPagamentos.Items[edtPagamentos.ItemIndex];
          qryParCon.FieldByName('CON_NATOPE').AsString := edtNatOpe.Items[edtNatOpe.ItemIndex];
          If (Not VarIsNull(edtNatCfo.KeyValue)) Then
            qryParCon.FieldByName('CON_NATCFO').AsString := edtNatCfo.KeyValue
          Else
            qryParCon.FieldByName('CON_NATCFO').Value := null;
          qryParCon.FieldByName('CON_MD5CLA').AsString := fRetornaMd5Key ;
        End;

        if fColunaExisteConCodTri then
        begin
          qryParCon.FieldByName('CON_CODTRI').AsString := edtCST.Items[edtCST.ItemIndex];
        end;
        qryParCon.FieldByName('CON_DTAHRA').AsDateTime := fNow();

        If fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) Then
          qryParCon.FieldByName('CON_CONCRE').Value := Null
        Else
          qryParCon.FieldByName('CON_CONCRE').AsString := fSemMascaraPlaNco(mskContaCredito.Text);

        qryParCon.FieldByName('CON_CFCRED').AsInteger := IIF(chkCliForCre.Checked, 1, 0);
        qryParCon.FieldByName('CON_PORCRE').AsInteger := IIF(chkPorCre.Checked, 1, 0);

        qryParCon.FieldByName('CON_PCCRED').AsInteger := IIF(chkPlaConCre.Checked, 1, 0);
        qryParCon.FieldByName('CON_PCDEBI').AsInteger := IIF(chkPlaConDeb.Checked, 1, 0);

        If fEmptyStr(edtHisCre.Text) Then
          qryParCon.FieldByName('CON_HISCRE').Value := Null
        Else
          qryParCon.FieldByName('CON_HISCRE').AsString := edtHisCre.Text;

        If fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) Then
          qryParCon.FieldByName('CON_CONDEB').Value := Null
        Else
          qryParCon.FieldByName('CON_CONDEB').AsString := fSemMascaraPlaNco(mskContaDebito.Text);

        qryParCon.FieldByName('CON_CFDEBI').AsInteger := IIF(chkCliForDeb.Checked, 1, 0);
        qryParCon.FieldByName('CON_PORDEB').AsInteger := IIF(chkPorDeb.Checked, 1, 0);

        { pCarregarComboDeComplementos faz Items.Clear, que zera o ItemIndex para -1, e
          nada o reposiciona até o usuário escolher ou pCarregarDadosEmTela carregar um
          registro. O combo também fica oculto quando o check list de complementos está
          em uso. Items[-1] levantaria exceção no meio do Edit/Post; "nada selecionado"
          equivale ao primeiro item da lista, que é vazio. }
        If (edtCmpDebito.ItemIndex < 0) Then
          qryParCon.FieldByName('CON_CMPDEB').AsString := ''
        Else
          qryParCon.FieldByName('CON_CMPDEB').AsString := edtCmpDebito.Items[edtCmpDebito.ItemIndex];

        if (blnCON_ORIGEM) then
          qryParCon.FieldByName('CON_ORIGEM').AsString := fgetOrigemSelecionada;

        if (blnCON_PAGANT) then
          qryParCon.FieldByName('CON_PAGANT').AsString := edtAdiantamento.Items[edtAdiantamento.ItemIndex];

        if (blnCON_BANDEB) then
        begin
          qryParCon.FieldByName('CON_BANDEB').AsInteger := IIF(chkBandeiraDebito.Checked, 1, 0);
          qryParCon.FieldByName('CON_BANCRE').AsInteger := IIF(chkBandeiraCredito.Checked, 1, 0);
        end;

        if (blnCON_ABFDEB) then
        begin
          qryParCon.FieldByName('CON_ABFDEB').AsInteger := IIF(chkAbrevDebito.Checked, 1, 0);
          qryParCon.FieldByName('CON_ABFCRE').AsInteger := IIF(chkAbrevCredito.Checked, 1, 0);
        end;

        If (rdbDebBai.Enabled) And (rdbDebCad.Enabled) Then
          qryParCon.FieldByName('CON_TIPPCD').AsString := IIF(rdbDebBai.Checked, CONTA_DA_BAIXA, CONTA_DO_CADASTRO)
        Else
          qryParCon.FieldByName('CON_TIPPCD').Clear;

        If (rdbCreBai.Enabled) And (rdbCreCad.Enabled) Then
          qryParCon.FieldByName('CON_TIPPCC').AsString := IIF(rdbCreBai.Checked, CONTA_DA_BAIXA, CONTA_DO_CADASTRO)
        Else
          qryParCon.FieldByName('CON_TIPPCC').Clear;

        if qryParCon.FieldByName('CON_TIPLAN').AsString = 'GNR' then
        begin
          qryParCon.FieldByName('CON_TIPPCD').AsString := IIF(rdbDebBai.Checked, CONTA_DA_BAIXA, CONTA_DO_CADASTRO) ;
          qryParCon.FieldByName('CON_TIPPCC').AsString := IIF(rdbCreBai.Checked, CONTA_DA_BAIXA, CONTA_DO_CADASTRO) ;
        end;

        if blnCON_TITPDD then
        begin
          if rgTitPDD.ItemIndex = 1 then
            qryParCon.FieldByName('CON_TITPDD').AsString := 'S'
          else
            qryParCon.FieldByName('CON_TITPDD').AsString := 'N' ;
        end;

        if fPreencheuVigencia then
          qryParcon.FieldByName('CON_VIGINI').AsDateTime := StrToDate(mskVigIni.Text)
        else
          qryParcon.FieldByName('CON_VIGINI').Clear;

        if fPreencheuVigenciaFinal then
          qryParcon.FieldByName('CON_VIGFIN').AsDateTime := StrToDate(mskVigFin.Text)
        else
          qryParcon.FieldByName('CON_VIGFIN').Clear;

        pSalvaMarketPlace(qryParCon.Fields, lstMarketPlace, pnlMarketPlace) ;
        pSalvaOrigemCPC(qryParCon.Fields, lstOrigemCPC, pnlOrigemCPC) ;
        pSalvaGrupoProd(qryParCon.Fields, cdsGrupoProd, pnlGrupoProd) ;
        pSalvaEmpresaLogada(qryParCon.Fields) ;

        qryParCon.Post;

        strMd5Key := qryParCon.FieldByName('CON_MD5CLA').AsString ;

        pDeletarContasDesmem(strSeqPar);
        pGravarContasDesmem(strMd5Key, strSeqPar);

        pDeletarDadosDoComplemento(strSeqPar);
        pGravarComplementos(strMd5Key, strSeqPar);

        pAtualizaVigenciaNull;

        fCommit;

        pLimparTela;
        pCarregaParCon;
      Except
        On E: EUniError Do
        Begin
          fRollBack;
          cxGridCitel1DBTableViewCitel1.DataController.Cancel;
          If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
            fMensagem('ERRO!', 'Já existe um registro com esses dados [Indice]!', ['&OK'])
          Else
            pMensagensErro(E.Message, '[TfrmParametrosContabilizacao.btnConfirmarClick]');
        End;
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[TfrmParametrosContabilizacao.btnConfirmarClick]');

        End;
      End;
      Finally
        { Rede de segurança contra gravação atrasada. Entre o Edit/Append e o Post só
          exceção escapa, e o fRollBack dos handlers desfaz a transação mas não limpa o
          buffer: a query fica em dsEdit/dsInsert com os valores novos. A próxima
          navegação na grade dispara CheckBrowseMode e, com ele, um Post implícito --
          que gravaria fora da transação, sem auditoria e só com os campos atribuídos
          antes da falha. Verificar Nota 1 - Req. 462247. }
        If qryParCon.State In [dsEdit, dsInsert] Then
          qryParCon.Cancel;

        TLogAjcOpContext.EndContext;
      End;
    End
    Else If (intAltera=3) Then
    Begin
      blnAltera := False;
      fRollBack;
      pLimparTela;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmParametrosContabilizacao.btnExportarClick(Sender: TObject);
begin
  If TGeraExcel.fGerarRelatorio(cxGridCitel1DBTableViewCitel1, 'Exportar Parâmetros Contabilidade', OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmParametrosContabilizacao.btnPlaNcoCreClick(Sender: TObject);
begin
  inherited;
  pPlanoDeContasPorEmpresaParametro('PARNCO', mskContaCredito.Text, cdsConCre, 'C');
  if not FblnDesligaContaReduzidaNaPesquisa then
    edtContaReduzidaCredito.Enabled := cdsConCre.IsEmpty;
  mskContaCredito.Enabled := cdsConCre.IsEmpty;
  if not mskContaCredito.Enabled then
  begin
    mskContaCredito.Clear;
    edtContaReduzidaCredito.Clear;
    edtDesContaCredito.Clear;
  end ;
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
end;

procedure TfrmParametrosContabilizacao.btnPlaNcoDebClick(Sender: TObject);
begin
  inherited;
  pPlanoDeContasPorEmpresaParametro('PARNCO', mskContaDebito.Text, cdsConDeb, 'D');
  mskContaDebito.Enabled := cdsConDeb.IsEmpty;
  if not FblnDesligaContaReduzidaNaPesquisa then
    edtContaReduzidaDebito.Enabled := cdsConDeb.IsEmpty;
  if not mskContaDebito.Enabled then
  begin
    mskContaDebito.Clear;
    edtContaReduzidaDebito.Clear;
    edtDesContaDebito.Clear;
  end ;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
end;

procedure TfrmParametrosContabilizacao.chkAbrevCreditoClick(Sender: TObject);
  var
    blnChkOld : boolean;
begin
  inherited;
  blnChkOld := chkAbrevCredito.Checked;
  chkAbrevCredito.OnClick := nil;
  try
    if (blnChkOld) then
      pStatusLinhaCredito(False) ;

    chkAbrevCredito.Checked := blnChkOld;
    pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
    pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  finally
    chkAbrevCredito.OnClick := chkAbrevCreditoClick;
  end;
end;

procedure TfrmParametrosContabilizacao.chkAbrevDebitoClick(Sender: TObject);
  var
    blnChkOld : boolean;
begin
  inherited;
  blnChkOld := chkAbrevDebito.Checked;
  chkAbrevDebito.Onclick := nil;
  try
    if (blnChkOld) then
      pStatusLinhaDebito(False) ;

    chkAbrevDebito.Checked := blnChkOld;
    pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
    pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  finally
    chkAbrevDebito.OnClick := chkAbrevDebitoClick;
  end;
end;

procedure TfrmParametrosContabilizacao.chkBandeiraCreditoClick(Sender: TObject);
  var
    blnChkOld : boolean;
begin
  inherited;
  blnChkOld := chkBandeiraCredito.Checked;
  chkBandeiraCredito.OnClick := nil;
  try
    if (blnChkOld) then
      pStatusLinhaCredito(False) ;
    
    chkBandeiraCredito.Checked := blnChkOld;
    pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
    pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  finally
    chkBandeiraCredito.OnClick := chkBandeiraCreditoClick;
  end;
end;

procedure TfrmParametrosContabilizacao.chkBandeiraDebitoClick(Sender: TObject);
  var
    blnChkOld : boolean;
begin
  inherited;
  blnChkOld := chkBandeiraDebito.Checked;
  chkBandeiraDebito.Onclick := nil;
  try
    if (blnChkOld) then
      pStatusLinhaDebito(False) ;

    chkBandeiraDebito.Checked := blnChkOld;
    pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
    pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  finally
    chkBandeiraDebito.OnClick := chkBandeiraDebitoClick;
  end;
end;

procedure TfrmParametrosContabilizacao.chkCliForCreClick(Sender: TObject);
begin
  inherited;
  If chkCliForCre.Checked Then
  Begin
    chkPorCre.Checked := False;
    chkPlaConCre.Checked := False;
    chkBandeiraCredito.Checked := False;
    chkAbrevCredito.Checked    := False;
    mskContaCredito.Clear;
    edtDesContaCredito.Clear;
    edtContaReduzidaCredito.Clear;
    if Copy(edtTipLan.Text,1,3) <> 'GNR' then
    begin
      rdbCreBai.Enabled := False;
      rdbCreCad.Enabled := False;
      rdbCreBai.Checked := False;
      rdbCreCad.Checked := False;
    end;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  pAjustaDataDeLancamentoCredito;
end;

procedure TfrmParametrosContabilizacao.chkCliForDebClick(Sender: TObject);
begin
  inherited;
  If (chkCliForDeb.Checked) Then
  Begin
    chkPorDeb.Checked         := False;
    chkPlaConDeb.Checked      := False;
    chkBandeiraDebito.Checked := False;
    chkAbrevDebito.Checked    := False;
    mskContaDebito.Clear;
    edtDesContaDebito.Clear;
    edtContaReduzidaDebito.Clear;
    if Copy(edtTipLan.Text,1,3) <> 'GNR' then
    begin
      rdbDebBai.Enabled := False;
      rdbDebCad.Enabled := False;
      rdbDebBai.Checked := False;
      rdbDebCad.Checked := False;
    end;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  pAjustaDataDeLancamentoDebito;
end;

procedure TfrmParametrosContabilizacao.pAjustaDataDeLancamentoDebito;
begin
  If (Copy(edtTipLan.Text,1,3) = 'CTP') Or
     (Copy(edtTipLan.Text,1,3) = 'CTR') or
     (Copy(edtTipLan.Text,1,3) = 'ADT') or
     (Copy(edtTipLan.Text,1,3) = 'CRC') Then
  Begin
    If (chkPlaConDeb.Checked) Then
    Begin
      rdbDebBai.Enabled := True;
      rdbDebCad.Enabled := True;
      rdbDebBai.Checked := True;
      rdbDebCad.Checked := True;
    End
    Else
    Begin
      rdbDebBai.Enabled := False;
      rdbDebCad.Enabled := False;
      rdbDebBai.Checked := False;
      rdbDebCad.Checked := False;
    End;
  End
  else if Copy(edtTipLan.Text,1,3) = 'GNR' then
  begin
    rdbDebBai.Enabled := False;
    rdbDebCad.Enabled := False;
    rdbCreBai.Enabled := False;
    rdbCreCad.Enabled := False;
    rdbDebBai.Checked := False;
    rdbCreBai.Checked := False;
    rdbDebCad.Checked := True;
    rdbCreCad.Checked := True;
  end;
end;

procedure TfrmParametrosContabilizacao.pAjustaCampoForPgo;
begin
  if (edtValor.Text = DES_VALOR_PIS_RF) or (edtValor.Text = DES_VALOR_COF_RF) then
  begin
    edtForPag.Enabled := True;
    edtForPag.ItemIndex := edtForPag.Items.IndexOf('Todas');
    edtForPag.Enabled := False;
  end
  else
  begin
    edtForPag.Enabled := True;
  end;
end;

procedure TfrmParametrosContabilizacao.pAjustaCheckPlanoContas;
const
  PAGAMENTO_AVULSO : Integer = 0;
begin
  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCRC], COD_CONTABIL[tcPCR], COD_CONTABIL[tcPCP], COD_CONTABIL[tcPDD], COD_CONTABIL[tcAGP], COD_CONTABIL[tcAGR], COD_CONTABIL[tcANT]]) then
  begin
    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) IN [COD_CONTABIL[tcCTR], COD_CONTABIL[tcPDD], COD_CONTABIL[tcAGP], COD_CONTABIL[tcAGR], COD_CONTABIL[tcPCP], COD_CONTABIL[tcPCR]]) then
    begin
      chkPlaConDeb.Enabled := True;
      chkPlaConCre.Enabled := True;
    end
    else
    begin
      chkPlaConDeb.Enabled := (edtPagamentos.ItemIndex = PAGAMENTO_AVULSO);
      chkPlaConCre.Enabled := (edtPagamentos.ItemIndex = PAGAMENTO_AVULSO);
    end;
  end;
end;

procedure TfrmParametrosContabilizacao.pAjustaDataDeLancamentoCredito;
begin
  If (Copy(edtTipLan.Text,1,3) = 'CTP') Or
     (Copy(edtTipLan.Text,1,3) = 'CTR') or
     (Copy(edtTipLan.Text,1,3) = 'ADT') or
     (Copy(edtTipLan.Text,1,3) = 'CRC') Then
  Begin
    If (chkPlaConCre.Checked) Then
    Begin
      rdbCreBai.Enabled := True;
      rdbCreCad.Enabled := True;
      rdbCreBai.Checked := True;
      rdbCreCad.Checked := True;
    End
    Else
    Begin
      rdbCreBai.Enabled := False;
      rdbCreCad.Enabled := False;
      rdbCreBai.Checked := False;
      rdbCreCad.Checked := False;
    End;
  End;
end;

procedure TfrmParametrosContabilizacao.chkPlaConCreClick(Sender: TObject);
begin
  inherited;
  If chkPlaConCre.Checked Then
  Begin
    mskContaCredito.Clear;
    edtDesContaCredito.Clear;
    edtContaReduzidaCredito.Clear;
    edtDesContaCredito.Enabled := False;
    chkCliForCre.Checked := False;
    chkPorCre.Checked := False;
    chkAbrevCredito.Checked := False;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  pAjustaDataDeLancamentoCredito;
end;

procedure TfrmParametrosContabilizacao.chkPlaConDebClick(Sender: TObject);
begin
  inherited;
  If chkPlaConDeb.Checked Then
  Begin
    mskContaDebito.Clear;
    edtDesContaDebito.Clear;
    edtContaReduzidaDebito.Clear;
    edtDesContaDebito.Enabled := False;
    chkCliForDeb.Checked := False;
    chkPorDeb.Checked := False;
    chkAbrevDebito.Checked := False;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
  pAjustaDataDeLancamentoDebito;
end;

procedure TfrmParametrosContabilizacao.chkPorCreClick(Sender: TObject);
begin
  inherited;
  If chkPorCre.Checked Then
  Begin
    chkCliForCre.Checked       := False;
    chkPlaConCre.Checked       := False;
    chkBandeiraCredito.Checked := False;
    chkAbrevCredito.Checked    := False;
    edtDesContaCredito.Enabled := False;
    mskContaCredito.Clear;
    edtDesContaCredito.Clear;
    edtContaReduzidaCredito.Clear;
    pAjustaDataDeLancamentoCredito;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
end;

procedure TfrmParametrosContabilizacao.chkPorDebClick(Sender: TObject);
begin
  inherited;
  If (chkPorDeb.Checked) Then
  Begin
    chkCliForDeb.Checked      := False;
    chkPlaConDeb.Checked      := False;
    chkBandeiraDebito.Checked := False;
    chkAbrevDebito.Checked    := False;
    edtDesContaDebito.Enabled := False;
    mskContaDebito.Clear;
    edtDesContaDebito.Clear;
    edtContaReduzidaDebito.Clear;
    pAjustaDataDeLancamentoDebito;
  End;
  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
end;

procedure TfrmParametrosContabilizacao.cxGridCitel1DBTableViewCitel1DblClick(
  Sender: TObject);
begin
  pCarregarDadosEmTela;
end;

procedure TfrmParametrosContabilizacao.cxGridCitel1DBTableViewCitel1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    qryDelete : TUniQuery;
    strSeqPar,
    strMd5Key : String;
begin
  inherited;
  If (Key = VK_Return) Then
    pCarregarDadosEmTela
  Else If (Key = VK_Delete) And (Not qryParCon.IsEmpty) Then
  Begin
    If (fMensagem('', 'Deseja realmente excluir o parâmetro selecionado?', ['&Sim', '&Não'], 1) = 1) Then
    Begin
      TLogAjcOpContext.BeginContext;
      try
        strSeqPar := '';
        strMd5Key := qryParCon.FieldByName('CON_MD5CLA').AsString ;
        If fSeqParValido Then
        Begin
          strSeqPar :=  qryParCon.FieldByName('CON_SEQPAR').AsString;

          pLogDelParcon ;
          pLogDelParNco ;
          pDeletarParametro(strSeqPar);
          pDeletarContasDesmem(strSeqPar);
          pDeletarDadosDoComplemento(strSeqPar);
          pCarregaParCon;
        End
        Else // pouco provavel
        Begin
          pLogDelParcon ;
          pLogDelParNco ;

          qryDelete := fCriaQueryContabilidade('PARCON', Self.Name, Self);
          Try
            qryDelete.Close;
            qryDelete.SQL.Clear;
            qryDelete.SQL.Add(' SELECT * ');
            qryDelete.SQL.Add(' FROM PARCON ');
            qryDelete.SQL.Add(' WHERE ');
            pAjustaWhereParcon(qryDelete) ;

            qryDelete.Open;
            while not qryDelete.Eof do
              qryDelete.Delete;

            pDeletarContasDesmem(strSeqPar);
            pDeletarDadosDoComplemento(strSeqPar);
            pCarregaParCon;
          Finally
            FreeAndNil(qryDelete);
          End;
        End;
      finally
        TLogAjcOpContext.EndContext;
      end;

    End;
  End;
end;

procedure TfrmParametrosContabilizacao.cxGridCitel1DBTableViewCitel1StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  LStatus: string;
  LRowInfo: TcxRowInfo;
begin
  inherited;

  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      LRowInfo := cxGridCitel1DBTableViewCitel1.DataController.GetRowInfo(ARecord.Index);
      LStatus := VarToStr(cxGridCitel1DBTableViewCitel1.DataController.Values[LRowInfo.RecordIndex, cxGridCitel1DBTableViewCitel1STATUS.Index]);

      if LStatus = 'INATIVO' then
        AStyle := estiloInativo
      else
        AStyle := estiloPadrao;
    end;
  end;
end;

procedure TfrmParametrosContabilizacao.edtContaReduzidaCreditoEnter(
  Sender: TObject);
begin
  inherited;
  FstrContaReduzidaCredito := TEditFocus(Sender).Text ;
end;

procedure TfrmParametrosContabilizacao.edtContaReduzidaCreditoExit(
  Sender: TObject);
var
  LNatureza: String ;
begin
  inherited;
  if (fEmptyStr(edtContaReduzidaCredito.Text)) and (not fEmptyStr(FstrContaReduzidaCredito))  then
  begin
    edtDesContaCredito.Clear ;
    mskContaCredito.Clear ;
    exit ;
  end ;

  if not fEmptyStr(edtContaReduzidaCredito.Text)  then
  begin
    edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaCredito.Text, strTplAco], False);
    mskContaCredito.Text := fCampoTabelaPlanco('NCO_CODCON', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaCredito.Text, strTplAco], False);
    LNatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaCredito.Text, strTplAco], False);
    If (Not fEmptyStr(edtContaReduzidaCredito.Text)) And (fEmptyStr(edtDesContaCredito.Text)) Then
    Begin
      fMensagem('ATENÇÃO!',IfThen(LNatureza = 'S', 'Não é possível utilizar uma Conta Contábil de Natureza Sintética', 'Conta Reduzida de Crédito Inválida!'),['&OK']);
      edtDesContaCredito.Clear ;
      mskContaCredito.Clear ;
      pSetFocus(edtContaReduzidaCredito);
      Exit;
    End;
  end ;
end;

procedure TfrmParametrosContabilizacao.edtContaReduzidaDebitoEnter(
  Sender: TObject);
begin
  inherited;
  FstrContaReduzidaDebito := TEditFocus(Sender).Text ;
end;

procedure TfrmParametrosContabilizacao.edtContaReduzidaDebitoExit(
  Sender: TObject);
var
  LNatureza: String ;
begin
  inherited;
  if (fEmptyStr(edtContaReduzidaDebito.Text)) and (not fEmptyStr(FstrContaReduzidaDebito))  then
  begin
    edtDesContaDebito.Clear ;
    mskContaDebito.Clear ;
    exit ;
  end ;

  if not fEmptyStr(edtContaReduzidaDebito.Text)  then
  begin
    edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaDebito.Text, strTplAco], False);
    mskContaDebito.Text := fCampoTabelaPlanco('NCO_CODCON', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaDebito.Text, strTplAco], False);
    LNatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CONRED', 'NCO_TPLACO'], [edtContaReduzidaDebito.Text, strTplAco], False);
    If (Not fEmptyStr(edtContaReduzidaDebito.Text)) And (fEmptyStr(edtDesContaDebito.Text)) Then
    Begin
      fMensagem('ATENÇÃO!',IfThen(LNatureza = 'S', 'Não é possível utilizar uma Conta Contábil de Natureza Sintética', 'Conta Reduzida de Débito Inválida!'),['&OK']);
      edtDesContaDebito.Clear ;
      mskContaDebito.Clear ;
      pSetFocus(edtContaReduzidaDebito);
      Exit;
    End;
  end ;
end;

procedure TfrmParametrosContabilizacao.edtForPagChange(Sender: TObject);
begin
  inherited;
  pSetaInformacaoFormaCreditoCtp;
end;

procedure TfrmParametrosContabilizacao.edtForPagExit(Sender: TObject);
var
  LstrAux: string ;
begin
  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCTP]]) then
  begin
    if fUtilizouFormaDePagamentoDescontoTotal then
    begin
      edtValor.Items.Clear;
      edtValor.Items.Add('Vr.Original');
      edtValor.ItemIndex := 0 ;
    end
    else
    begin
      if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR]) then
      begin
        LstrAux := edtValor.Text ;
        edtValor.Items.Clear;
        pSetaItensCTR_PCR(edtValor) ;
        edtValor.ItemIndex := edtValor.Items.IndexOf(LstrAux) ;
      end
      else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]) then
      begin
        LstrAux := edtValor.Text ;
        edtValor.Items.Clear;
        pSetaItensCTP_PCP(edtValor) ;
        edtValor.ItemIndex := edtValor.Items.IndexOf(LstrAux) ;
      end ;
    end ;
  end ;

end;

procedure TfrmParametrosContabilizacao.edtHisCreExit(Sender: TObject);
begin
  inherited;
  edtDesHisCre.Text := fRetDescHistoricoPadrao(edtHisCre.Text);
  If (Not fEmptyStr(edtHisCre.Text)) And (fEmptyStr(edtDesHisCre.Text)) Then
  Begin
    fMensagem('ATENÇÃO!','Histórico Inválido!',['&OK']);
    pSetFocus(edtHisCre);
    Exit;
  End;
end;

procedure TfrmParametrosContabilizacao.edtHisCreKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrHist: TConsultasArray;
begin
  inherited;
  If fPesqHistoricoPadrao(Self, edtHisCre, Nil, Nil, Key, arrHist) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmParametrosContabilizacao.edtNatCfoDropDown(Sender: TObject);
begin
  inherited;
  pCarregaNatCfo;
end;

procedure TfrmParametrosContabilizacao.edtOrigemChange(Sender: TObject);
begin
  inherited;
  pMostraPnlPagamentosBan(edtOrigem.Text) ;
  pMostraPnlFormaPagamentosBan(edtOrigem.Text) ;
  pCarregaValorAGR(edtOrigem.Text) ;
end;

procedure TfrmParametrosContabilizacao.edtPagamentosExit(Sender: TObject);
begin
  pAjustaCheckPlanoContas ;
end;

procedure TfrmParametrosContabilizacao.edtTipLanChange(Sender: TObject);
  Var
    intTop : Integer;
    intTaborder : Integer;

  procedure pSetTabOrder(pnlPanel: TCategoryPanel);
  begin
    pnlPanel.TabOrder := intTaborder;
    intTaborder := intTaborder + 1;
  end;

begin
  inherited;

  pSetarNatOpe('');

  pnlTipLan.Top := 0;
  intTaborder := 1;
  intTop := pnlTipLan.Height;
  pnlTipLan.TabOrder := 0;

  pMostrarCST(TTiposContabeis(fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items)));

  pnlForPag.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTP],
                                                COD_CONTABIL[tcCTR],
                                                COD_CONTABIL[tcADT],
                                                COD_CONTABIL[tcCHQ],
                                                COD_CONTABIL[tcTCC],
                                                COD_CONTABIL[tcANT]]) or fHabilitaFormasPagamentoCaixaCRC;

  If Not pnlForPag.Visible Then
  begin
    edtForPag.ItemIndex := -1 ;
    pCarregaFormaPagamentoPCP ;
    pCarregaFormaPagamentoPCR ;
  end
  Else
  Begin
    pnlForPag.Top := intTop;
    pCarregaFormaPagamentosPadrao ;
  End;

  pnlCfop.Visible := fUtilizaNaturezaDeOperacao(LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3));

  If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT]) Then
    lstCfoTod.Items.Assign(lstTodosCfopsEnt)
  Else If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcSAI], COD_CONTABIL[tcCMV]]) Then
    lstCfoTod.Items.Assign(lstTodosCfopsSai)
  Else If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCOE],COD_CONTABIL[tcCOS]]) Then
    lstCfoTod.Items.Assign(lstTodosCfops);

  lstCfoSel.Clear;

  If (pnlCfop.Visible) Then
  Begin
    intTop := intTop + pnlCfop.Height;
    pnlCfop.Top := intTop;

    If (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcENT],COD_CONTABIL[tcCOE]]) Then
      btnClaTod.Caption := 'CFOPs compra >'
    Else
      btnClaTod.Caption := 'CFOPs venda >';
  End;

  pnlNatOpe.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcENT],COD_CONTABIL[tcSAI]]);

  pnlPagamentos.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTP],
                                                    COD_CONTABIL[tcCTR],
                                                    COD_CONTABIL[tcCRC],
                                                    COD_CONTABIL[tcPDD],
                                                    COD_CONTABIL[tcTCC],
                                                    COD_CONTABIL[tcANT]]);

  pnlOrigem.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcBAN], COD_CONTABIL[tcIMO], COD_CONTABIL[tcAGR], COD_CONTABIL[tcAGP], COD_CONTABIL[tcAJI]]) And (blnCON_ORIGEM);

  pnlAdiantamento.Visible := (blnCON_PAGANT) and (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]);

  pLimparGrupoLancamentos;

  if (pnlOrigem.Visible) then
    pPopularComboBoxOrigem(TTiposContabeis(fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items)));

  If (pnlNatOpe.Visible) Then
  Begin
    intTop := intTop + pnlNatOpe.Height;
    pnlNatOpe.Top := intTop;
  End
  else
    edtNatOpe.ItemIndex := -1;

  If (pnlPagamentos.Visible) Then
  Begin
    intTop := intTop + pnlPagamentos.Height;
    pnlPagamentos.Top := intTop;

    edtPagamentos.Items.Clear;
    pCarregaPagamentoCTP ;
    pCarregaPagamentoCTR ;
    edtPagamentos.Items.Add('Pagamentos Avulsos');
    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTP], COD_CONTABIL[tcCTR], COD_CONTABIL[tcPDD], COD_CONTABIL[tcTCC]]) then
    begin
      edtPagamentos.Items.Add('Pagamentos Fatura');
      if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcTCC]]) then
      begin
        edtPagamentos.Items.Add('Todos');
      end ;
    end ;
  End;
  pCarregaPagamentoPCP ;
  pCarregaPagamentoPCR ;
  pCarregaPagamentoANT ;

  if (pnlOrigem.Visible) then
  begin
    intTop := intTop + pnlOrigem.Height;
    pnlOrigem.Top := intTop;
  end
  else
    edtOrigem.ItemIndex := -1;

  if (pnlAdiantamento.Visible) then
  begin
    intTop := intTop + pnlADiantamento.Height;
    pnlAdiantamento.Top := intTop;
  end
  else
    edtAdiantamento.ItemIndex := -1;

  intTop := intTop + pnlValor.Height;
  pnlValor.Top := intTop;

  pCarregarListaDeComplementos;
  pCarregarComboDeComplementos;

  edtValor.Items.Clear;
  Case fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) Of
    Integer(tcCTP),Integer(tcPCP):
    Begin
      pSetaItensCTP_PCP(edtValor) ;
    End;
    Integer(tcCTR),Integer(tcPCR):
    Begin
      pSetaItensCTR_PCR(edtValor);
    End;
    Integer(tcCRC):
    begin
      edtValor.Items.Add(DES_VALOR_DUPLICATA);
    end;
    Integer(tcADT):
    begin
      edtValor.Items.Add('Vr.Recebido');
    end;
    Integer(tcCHQ):
    Begin
      edtValor.Items.Add('Vr.Cheque Depositado');
      edtValor.Items.Add('Vr.Cheque Devolvido');
      edtValor.Items.Add('Vr.Cheque Redepositado');
      edtValor.Items.Add('Vr.Cheque Dev.Definitiva');
      edtValor.Items.Add(DES_VALOR_CHEQUE_TRANSF_CTR);
      edtValor.Items.Add(DES_VALOR_CHEQUE_VALOR_REPASSE);
    End;
    Integer(tcCAR):
    Begin
      edtValor.Items.Add('Vr.Recebido');
      edtValor.Items.Add('Vr.Bruto');
      edtValor.Items.Add('Vr.Taxa');
      pAdicionaOpcaoDescontoHub ;
      pAdicionaOpcaoFreteHub ;
      pAdicionaOpcaoAjusteHub ;
    End;
    Integer(tcBAN):
    Begin
      edtValor.Items.Add('Vr.Lançamento');
    End;
    Integer(tcAJI):
    Begin
      edtValor.Items.Add('Vr.ICMS');
    End;
    Integer(tcENT),Integer(tcSAI): // Entrada/Saída
    Begin
      pSetaItensEntradaSaida(edtValor, lstCfoSel.Items.CommaText.Contains('933'), IIF(fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT], 'ENT', 'SAI'), lstCfoSel.Items.CommaText.Contains('933'));
    End;
    Integer(tcCOE),Integer(tcCOS):
    Begin
      edtValor.Items.Add('Vr.Contábil');
      edtValor.Items.Add('Vr.ICMS');
      edtValor.Items.Add('Vr.PIS');
      edtValor.Items.Add('Vr.COFINS');
      edtValor.Items.Add(DES_VALOR_LIQUIDO_ENTRADA);
    End;
    Integer(tcAJE),Integer(tcAJS):
    Begin
      edtValor.Items.Add(DES_VALOR_CMV);
    End;
    Integer(tcIMO):
    begin
      edtValor.Items.Add('Depreciar');
    end;
    Integer(tcGNR):
    begin
      pSetaItensGNRE(edtValor) ;
    end;
    Integer(tcPDD):
    begin
      pSetaItensPDD(edtValor) ;
    end;
    Integer(tcAGR):
    begin
      pSetaItensAGR(edtValor) ;
    end;
    Integer(tcTCC):
    begin
      pSetaItensTCC(edtValor) ;
    end;
    Integer(tcCPC):
    begin
      pSetaItensCPC(edtValor) ;
    end;
    Integer(tcANT):
    begin
      pSetaItensANT(edtValor) ;
    end;
  End;

  if (cklComplemento.Visible) then
    cklComplemento.Enabled := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCMV]);

  if (edtCmpDebito.Visible) then
    edtCmpDebito.Enabled := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCMV]);

  pnlValor.Visible := not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCMV], COD_CONTABIL[tcAGP]]);

  chkCliForDeb.Enabled := not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcIMO], COD_CONTABIL[tcCMV]]);
  chkCliForCre.Enabled := not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcIMO], COD_CONTABIL[tcCMV]]);

  chkPorCre.Enabled := Not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcENT],COD_CONTABIL[tcSAI],COD_CONTABIL[tcCOE],COD_CONTABIL[tcCOS],COD_CONTABIL[tcAJE],COD_CONTABIL[tcAJS],COD_CONTABIL[tcIMO],COD_CONTABIL[tcCMV],COD_CONTABIL[tcGNR], COD_CONTABIL[tcCPC], COD_CONTABIL[tcAJI]]); // > 4
  chkPorDeb.Enabled := Not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcENT],COD_CONTABIL[tcSAI],COD_CONTABIL[tcCOE],COD_CONTABIL[tcCOS],COD_CONTABIL[tcAJE],COD_CONTABIL[tcAJS],COD_CONTABIL[tcIMO],COD_CONTABIL[tcCMV],COD_CONTABIL[tcGNR], COD_CONTABIL[tcCPC], COD_CONTABIL[tcAJI]]);

  chkPlaConCre.Enabled := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTP],
                                                   COD_CONTABIL[tcBAN],
                                                   COD_CONTABIL[tcENT],
                                                   COD_CONTABIL[tcPCP],
                                                   COD_CONTABIL[tcCAR],
                                                   COD_CONTABIL[tcGNR],
                                                   COD_CONTABIL[tcPDD],
                                                   COD_CONTABIL[tcCPC],
                                                   COD_CONTABIL[tcANT]]) or fHabilitaPlanoContasSAI or fHabilitaPlanoContasCoeCos ;

  chkPlaConDeb.Enabled := chkPlaConCre.Enabled;

  chkBandeiraDebito.Enabled := fPermiteParametrizarBandeira(blnCON_BANDEB);
  chkBandeiraCredito.Enabled := fPermiteParametrizarBandeira(blnCON_BANDEB);

  chkAbrevDebito.Enabled := fPermiteParametrizarAbreviacao(blnCON_ABFDEB);
  chkAbrevCredito.Enabled := fPermiteParametrizarAbreviacao(blnCON_ABFDEB);

  if blnCON_TITPDD then
  begin
    if fCfgLigPdd = 'S' then
    begin
      pnlTitPDD.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR]);
    end
    else
    begin
      pnlTitPDD.Visible := False ;
    end ;
  end;

  pnlMarketPlace.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcSAI]]) and (fCfgMktPla = 'S') and (Assigned(qryParCon.Fields.FindField('CON_CODORI'))) ;

  pnlOrigemCPC.Visible := fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCPC];

  pnlGrupoProd.Visible := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcSAI], COD_CONTABIL[tcENT]]) and (fCfgConGru = 'S') and (Assigned(qryParCon.Fields.FindField('CON_CODGRU'))) and (FblnCadGruExiste) ;

  intTabOrder := 0;
  If (pnlTipLan.Visible) Then
    pSetTabOrder(pnlTipLan);

  If (pnlForPag.Visible) Then
    pSetTabOrder(pnlForPag);

  If (pnlCfop.Visible) Then
    pSetTabOrder(pnlCfop);

  If (pnlNatOpe.Visible) Then
    pSetTabOrder(pnlNatOpe);

  If (pnlPagamentos.Visible) Then
    pSetTabOrder(pnlPagamentos);

  if (pnlOrigem.Visible) then
    pSetTabOrder(pnlOrigem);

  If (pnlValor.Visible) Then
    pSetTabOrder(pnlValor);

  if pnlAdiantamento.Visible then
    pSetTabOrder(pnlAdiantamento);

  if pnlTitPDD.Visible then
    pSetTabOrder(pnlTitPDD);

  if pnlMarketPlace.Visible then
    pSetTabOrder(pnlMarketPlace);

  if pnlOrigemCPC.Visible then
    pSetTabOrder(pnlOrigemCPC);

  if pnlGrupoProd.Visible then
    pSetTabOrder(pnlGrupoProd);

  pAjustaCheckPlanoContas ;
end;

procedure TfrmParametrosContabilizacao.edtValorChange(Sender: TObject);
begin
  inherited;
  pAjustaCampoForPgo;
  pMensagemISSRetido(TComboBoxFocus(Sender).Text) ;
end;

procedure TfrmParametrosContabilizacao.edtValorEnter(Sender: TObject);
begin
  inherited;
  pMensagemISSRetido(edtValor.Text) ;
end;

procedure TfrmParametrosContabilizacao.edtValorExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '' ;
end;

function TfrmParametrosContabilizacao.fGetIndexTipLan(
  strTipLan: String): Integer;
  Var
   intCnt : Integer;
begin
  Result := -1;
  For intCnt := 0 To edtTipLan.Items.Count-1 Do
  Begin
    If (LeftStr(edtTipLan.Items[intCnt], 3) = strTipLan) Then
    Begin
      Result := intCnt;
      Break;
    End;
  End;
end;

function TfrmParametrosContabilizacao.fHabilitaFormasPagamentoCaixaCRC: Boolean;
begin
  Result := False ;

  if fAtivaFormasPagamentoCaixaCRC = 'N' then
    Exit ;

  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCRC] then
    Exit ;

  Result := True ;
end;

function TfrmParametrosContabilizacao.fCodigoSelGrupoProd(
  const AfldParcon: TFields; const AcdsDados: TUniClientDataSet;
  const Apnl: TCategoryPanel): string;
var
  LstrCodigo: string ;
begin
  LstrCodigo := '' ;
  if Apnl.Visible then
  begin
    AcdsDados.DisableControls;
    try
      AcdsDados.First ;
      while not AcdsDados.Eof do
      begin
        if AcdsDados.FieldByName('SELECI').AsBoolean then
        begin
          if fEmptyStr(LstrCodigo) then
          begin
            LstrCodigo := AcdsDados.FieldByName('CODGRU').AsString ;
          end
          else
          begin
            LstrCodigo := LstrCodigo + ',' + AcdsDados.FieldByName('CODGRU').AsString ;
          end;
        end;
        AcdsDados.Next;
      end;
    finally
      AcdsDados.EnableControls ;
    end ;
  end;
  result := LstrCodigo ;
end;

function TfrmParametrosContabilizacao.fCodigoSelMarketPlace(
  const AfldParcon: TFields; const AlstItens: TcxCheckListBox;
  const ApnlMarket: TCategoryPanel): string;
var
  LstrCodigo: string ;
  LintItem: integer ;
begin
  LstrCodigo := '' ;
  if ApnlMarket.Visible then
  begin
    for LintItem := 0 to AlstItens.Items.Count-1 do
    begin
      if AlstItens.Items.Items[LintItem].Checked then
      begin
        if fEmptyStr(LstrCodigo) then
        begin
          LstrCodigo := fStrZero(AlstItens.Items.Items[LintItem].Tag, 3) ;
        end
        else
        begin
          LstrCodigo := LstrCodigo + ',' + fStrZero(AlstItens.Items.Items[LintItem].Tag, 3) ;
        end;
      end;
    end;
  end;
  result := LstrCodigo ;
end;

function TfrmParametrosContabilizacao.fCodigoSelOrigemCPC(
  const AfldParcon: TFields; const AlstItens: TcxCheckListBox;
  const ApnlOri: TCategoryPanel): string;
var
  LstrCodigo: string ;
  LintItem: integer ;
begin
  Result := '';

  if not blnRotinaCPC then
    Exit;

  LstrCodigo := '' ;
  if ApnlOri.Visible then
  begin
    for LintItem := 0 to AlstItens.Items.Count-1 do
    begin
      if AlstItens.Items.Items[LintItem].Checked then
      begin
        if fEmptyStr(LstrCodigo) then
        begin
          LstrCodigo := fStrZero(AlstItens.Items.Items[LintItem].Tag, 2) ;
        end
        else
        begin
          LstrCodigo := LstrCodigo + ',' + fStrZero(AlstItens.Items.Items[LintItem].Tag, 2) ;
        end;
      end;
    end;
  end;
  result := LstrCodigo ;
end;

function TfrmParametrosContabilizacao.fGetDatasetDuplicados(
  const blnModoIncluir: boolean): TDataSet;
var
  qryAux: TUniQuery;
  strSql : string ;
  intCountFor: integer;
  strWhereClaFis: string;
begin
  qryAux := fCriaQuery(Self);
  try
    strSql := ' SELECT CON_SEQPAR, CON_VIGINI, CON_VIGFIN ' ;
    strSql := strSql + ' FROM PARCON ' ;
    strSql := strSql + ' WHERE TRUE ' ;
    strSql := strSql + '       AND COALESCE(CON_DESVAL,"") = :DESVAL ' ;
    strSql := strSql + '       AND COALESCE(CON_FORPGO,"") = :FORPGO ' ;
    strSql := strSql + '       AND COALESCE(CON_TIPLAN,"") = :TIPLAN ' ;
    strSql := strSql + '       AND COALESCE(CON_NATOPE,"") = :NATOPE ' ;
    strSql := strSql + '       AND COALESCE(CON_ORIGEM,"") = :ORIGEM ' ;
    strSql := strSql + '       AND IFNULL(CON_PAGAME,"") =   :PAGAME ' ;

    strWhereClaFis := '';
    for intCountFor := 0 to lstCfoSel.Count - 1 do
    begin
      if (intCountFor > 0) then
      begin
        strWhereClaFis := strWhereClaFis + ' OR '
      end;
      strWhereClaFis := strWhereClaFis + '(FIND_IN_SET("' +
                        lstCfoSel.Items[intCountFor] +
                        '", CON_CLAFIS) > 0)';
    end;

    if not (fEmptyStr(strWhereClaFis)) then
      strSql := strSql + '  AND (' + strWhereClaFis + ') '
    else
      strSql := strSql + '       AND IFNULL(CON_CLAFIS,"") =   "" ' ;

    if fColunaExisteConCodTri then
    begin
      strSql := strSql + '       AND IFNULL(CON_CODTRI,"") =   :CODTRI ' ;
    end;
    if blnCON_TITPDD then
      strSql := strSql + '       AND COALESCE(CON_TITPDD,"") = :TITPDD ' ;
    if not blnModoIncluir then
      strSql := strSql + '       AND CON_SEQPAR <> :SEQPAR ' ;
    if not fEmptyStr(trim(edtAdiantamento.Items[edtAdiantamento.ItemIndex])) then
      strSql := strSql + '       AND COALESCE(CON_PAGANT,"") = :PAGANT ' ;
    qryAux.Close ;
    qryAux.SQL.Clear ;
    qryAux.SQL.Add(strSql) ;
    pSetarFiltroEmpresa(qryAux) ;
    pParamMarketPlace(qryAux, qryParCon.Fields, lstMarketPlace, pnlMarketPlace) ;
    pParamOrigemCPC(qryAux, qryParCon.Fields, lstOrigemCPC, pnlOrigemCPC) ;
    pParamGrupoProd(qryAux, qryParCon.Fields, cdsGrupoProd, pnlGrupoProd) ;

    If (Not VarIsNull(edtNatCfo.KeyValue)) Then
    begin
      qryAux.SQL.Add('       AND COALESCE(CON_NATCFO,"") = :NATCFO ') ;
      qryAux.ParamByName('NATCFO').AsString := edtNatCfo.KeyValue ;
    end
    else
      qryAux.SQL.Add('       AND CON_NATCFO IS NULL ') ;

    qryAux.SQL.Add(' ORDER BY CON_VIGINI desc, CON_VIGFIN desc ');

    qryAux.ParamByName('DESVAL').AsString := fRetornaValorDescricao ;
    qryAux.ParamByName('FORPGO').AsString := edtForPag.Items[edtForPag.ItemIndex] ;
    qryAux.ParamByName('NATOPE').AsString := edtNatOpe.Items[edtNatOpe.ItemIndex];
    qryAux.ParamByName('TIPLAN').AsString := LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3);
    qryAux.ParamByName('PAGAME').AsString := edtPagamentos.Items[edtPagamentos.ItemIndex];

    if fColunaExisteConCodTri then
    begin
      qryAux.ParamByName('CODTRI').AsString := edtCST.Items[edtCST.ItemIndex];
    end;
    if (blnCON_ORIGEM) then
      qryAux.ParamByName('ORIGEM').AsString := fgetOrigemSelecionada;
    if blnCON_TITPDD then
      qryAux.ParamByName('TITPDD').AsString := IIF(rgTitPDD.ItemIndex = 1, 'S', 'N') ;
    if not blnModoIncluir then
      qryAux.ParamByName('SEQPAR').AsString := qryParCon.FieldByName('CON_SEQPAR').AsString ;
    if not fEmptyStr(trim(edtAdiantamento.Items[edtAdiantamento.ItemIndex])) then
      qryAux.ParamByName('PAGANT').AsString := trim(edtAdiantamento.Items[edtAdiantamento.ItemIndex]) ;

    qryAux.Open ;

    result := qryAux;
  except
    if Assigned(qryAux) then
      FreeAndNil(qryAux);

    raise;
  end;
end;

function TfrmParametrosContabilizacao.fgetIndexOrigem(const AOrigem: string): integer;
  var
    intCnt : Integer;
begin
  Result := -1;

  if fEmptyStr(AOrigem) then
    Exit(0);

  for intCnt := 0 to Pred(edtOrigem.Items.Count) do
  begin
    if LeftStr(edtOrigem.Items[intCnt], 3) = AOrigem then
      Exit(intCnt);
  end;
end;

function TfrmParametrosContabilizacao.fgetOrigemSelecionada: string;
begin
  result := '' ;
  if not pnlOrigem.Visible then
  begin
    exit ;
  end;
  if ((LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)) = 'IMO') then
  begin
    Result := LeftStr(edtOrigem.Items[edtOrigem.ItemIndex], 3) ;
  end
  else if ((LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)) = 'AGP') or
          ((LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)) = 'AGR') or
          ((LeftStr(edtTipLan.Items[edtTipLan.ItemIndex], 3)) = 'AJI') then
  begin
    Result := LeftStr(edtOrigem.Items[edtOrigem.ItemIndex], 3) ;
  end
  else
  begin
    if (edtOrigem.ItemIndex = 0) then
      Result := ''
    else
      Result := LeftStr(edtOrigem.Items[edtOrigem.ItemIndex], 3);
  end;
end;

function TfrmParametrosContabilizacao.fHabilitaPlanoContasCoeCos: Boolean;
begin
  result := False ;
  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCOE]) and
     (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCOS]) then
    Exit ;

  if fAtivaPlanoContasCoeCos = 'N' then
    Exit ;

  result := True ;
end;

function TfrmParametrosContabilizacao.fHabilitaPlanoContasSAI: Boolean;
begin
  result := False ;
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcSAI] then
    Exit ;

  if fInformaPlanoContasFaturamento = 'N' then
    Exit ;

  if fAtivaPlanoContasSAI = 'N' then
    Exit ;

  result := True ;
end;

function TfrmParametrosContabilizacao.fLancouContasIguais: boolean;
begin
  Result := False;

  if (not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) and
     (not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) then
  begin
    Result := SameText(fSemMascaraPlaNco(mskContaCredito.Text), fSemMascaraPlaNco(mskContaDebito.Text));
  end;

  if (not Result) and (chkCliForDeb.Checked) then
    Result := chkCliForDeb.Checked = chkCliForCre.Checked;

  if (not Result) and (chkPorDeb.Checked or chkPorCre.Checked) then
    Result := (chkPorDeb.Checked = chkPorCre.Checked) and (rdbDebBai.Checked = rdbCreBai.Checked);

  if (not Result) and (chkPorDeb.Checked or chkPorCre.Checked) then
    Result := (chkPorDeb.Checked = chkPorCre.Checked) and (rdbDebCad.Checked = rdbCreCad.Checked);

  if (not Result) and (chkBandeiraDebito.Checked or chkBandeiraCredito.Checked) then
    Result := chkBandeiraDebito.Checked = chkBandeiraCredito.Checked;

  if (not Result) and (chkAbrevDebito.Checked or chkAbrevCredito.Checked) then
    Result := chkAbrevDebito.Checked = chkAbrevCredito.Checked;

  if (not Result) and (chkPlaConDeb.Checked or chkPlaConCre.Checked) then
    Result := (chkPlaConDeb.Checked = chkPlaConCre.Checked) and (rdbDebBai.Checked = rdbCreBai.Checked);

  if (not Result) and (chkPlaConDeb.Checked or chkPlaConCre.Checked) then
    Result := (chkPlaConDeb.Checked = chkPlaConCre.Checked) and (rdbDebCad.Checked = rdbCreCad.Checked);
end;

function TfrmParametrosContabilizacao.fMD5Chave(strClaFis,
  strPagamentos, strOrigem, strPagant: String): String;
begin
  Result := fRetHashString(strClaFis + strPagamentos + strOrigem + strPagant);
end;

function TfrmParametrosContabilizacao.fObrigaParteContraria: Boolean;
begin
  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCOS],
                                                                             COD_CONTABIL[tcCOE]]) and
     (edtValor.Text = DES_VALOR_LIQUIDO_ENTRADA) then
  begin
    Result := False ;
    exit ;
  end ;

  Result := (Not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTP],
                                          COD_CONTABIL[tcCTR],
                                          COD_CONTABIL[tcADT],
                                          COD_CONTABIL[tcCAR],
                                          COD_CONTABIL[tcPCP],
                                          COD_CONTABIL[tcPCR],
                                          COD_CONTABIL[tcCRC],
                                          COD_CONTABIL[tcENT],
                                          COD_CONTABIL[tcSAI]]));
end;

procedure TfrmParametrosContabilizacao.FormCreate(Sender: TObject);
begin
  inherited;
  FblnCadGruExiste := fTabelaExiste('CADGRU') ;
  cdsGrupoProd.CreateDataSet ;
  cdsGrupoProd.IndexFieldNames := 'DESGRU' ;
  qryCadCfo := fCriaQuery(Self);
  qryParCon := fCriaQueryContabilidade('PARCON', Self.Name, Self);
  qryNatCfo := fCriaQuery(Self);
  lstTodosCfopsEnt := TStringList.Create;
  lstTodosCfopsSai := TStringList.Create;
  lstTodosCfops := TStringList.Create;
  strMascara := fMskCon;
  mskContaDebito.EditMask := strMascara;
  mskContaCredito.EditMask := strMascara;
  cdsNatKey.CreateDataSet;
  pCarregaTiposContabeis(edtTipLan);
  blnCON_ORIGEM := False;
  blnCON_BANDEB := False;
  blnCON_ABFDEB := False;
  blnCON_TITPDD := False;
  cdsConDeb := TfrmContasPorEmpresa.fCriaCdsDados(Self);
  cdsConCre := TfrmContasPorEmpresa.fCriaCdsDados(Self);
  blnAltera := False;
  strSeqPar := '';
  strTipLanOriginal := '';
  intRegAlt := 0;
  blnRotinaCPC := fCampoExiste('PARCON', 'CON_ORICPC');
  blnRotinaANT := fTabelaExiste('PAGANT');
  cxGridCitel1DBTableViewCitel1CON_CODTRI.Visible := fColunaExisteConCodTri ;
  cxGridCitel1DBTableViewCitel1CON_CODTRI.VisibleForCustomization := fColunaExisteConCodTri ;
  pCarregaMarketPlace(lstMarketPlace) ;
  pCarregaOrigemCPC(lstOrigemCPC) ;
  pCarregaGrupoProd(cdsGrupoProd) ;
  FstrContaReduzidaDebito := '' ;
  FstrContaReduzidaCredito := '' ;
  FblnDescontoHub := fTemColDescontoHub ;
  FblnFreteHub := fTemColFreteHub ;
  FblnAjusteHub := fTemColAjusteHub ;
end;

procedure TfrmParametrosContabilizacao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCadCfo);
  FreeAndNil(lstTodosCfopsEnt);
  FreeAndNil(lstTodosCfopsSai);
  FreeAndNil(lstTodosCfops);
  FreeAndNil(qryParCon);
  FreeAndNil(qryNatCfo);
  FreeAndNil(cdsConDeb);
  FreeAndNil(cdsConCre);
  inherited;
end;

procedure TfrmParametrosContabilizacao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaCfo;
  pAtualizaFiltroAtual;
  pCarregaParCon;
  pCarregaCST;

  blnCON_ORIGEM := Assigned(qryParCon.FindField('CON_ORIGEM'));
  blnCON_BANDEB := Assigned(qryParCon.FindField('CON_BANDEB'));
  blnCON_ABFDEB := Assigned(qryParCon.FindField('CON_ABFDEB'));
  blnCON_PAGANT := Assigned(qryParCon.FindField('CON_PAGANT'));
  blnCON_TITPDD := Assigned(qryParCon.FindField('CON_TITPDD'));
  strTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);
  blnRotinaImobilizado := fTabelaExiste('CADIMO') and fTabelaExiste('IMOAMO');

  pCarregaNatCfo;
  pAtualizaMd5;
  dtsNatCfo.DataSet := qryNatCfo;

  blnUsaCheckListComplemento := fTabelaExiste('CMPPAR');
  cklComplemento.Visible := blnUsaCheckListComplemento;
  edtCmpDebito.Visible := not cklComplemento.Visible;
  pnlTitPDD.Visible := False;
  pnlMarketPlace.Visible := False;
  pnlOrigemCPC.Visible := False;
  pnlGrupoProd.Visible := False;
  cxGridCitel1DBTableViewCitel1CON_CODORI.Visible := (Assigned(qryParCon.Fields.FindField('CON_CODORI'))) and (fCfgMktPla = 'S') ;
  cxGridCitel1DBTableViewCitel1CON_CODGRU.Visible := (Assigned(qryParCon.Fields.FindField('CON_CODGRU'))) and (fCfgConGru = 'S') ;
  cxGridCitel1DBTableViewCitel1CON_TITPDD.Visible := iif(fCfgLigPdd = 'S', blnCON_TITPDD, False) ;
  FblnDesligaContaReduzidaNaPesquisa := fCfgRpCtRd = 'S' ;
  if FblnDesligaContaReduzidaNaPesquisa then
  begin
    edtContaReduzidaDebito.Enabled := False ;
    edtContaReduzidaCredito.Enabled := False ;
  end ;

  If Not fEmptyStr(strSeqParIniciarCadastro) Then
  Begin
    Try
      // Garante visibilidade do registro, independentemente de ativo/inativo/vigência.
      If Not qryParCon.Locate('CON_SEQPAR', strSeqParIniciarCadastro, []) Then
      Begin
        rdbTodos.Checked := True;
        pAtualizaFiltroAtual;
        pCarregaParCon;
        If Not qryParCon.Locate('CON_SEQPAR', strSeqParIniciarCadastro, []) Then
          pMensagemOk('Parâmetro contábil (CON_SEQPAR = ' +
                      strSeqParIniciarCadastro + ') não encontrado.');
      End;

      pCarregarDadosEmTela;
      pSetFocus(cxGridCitel1);
    Finally
      strSeqParIniciarCadastro := '';
    End;
  End;
end;

function TfrmParametrosContabilizacao.fPermiteParametrizarBandeira(
  blnCampoExiste: Boolean): boolean;
begin
  Result := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcADT], COD_CONTABIL[tcCTR], COD_CONTABIL[tcCRC], COD_CONTABIL[tcCAR]]) And (blnCampoExiste);
end;

function TfrmParametrosContabilizacao.fPlanoContabilConfiguradoOutrosModulosDebito: Boolean;
begin
  Result := True ;

  if chkCliForDeb.Checked then
    Exit ;

  if chkPorDeb.Checked then
    Exit ;

  if chkPlaConDeb.Checked then
    Exit ;

  if chkBandeiraDebito.Checked then
    Exit ;

  if chkAbrevDebito.Checked then
    Exit ;

  Result := False ;
end;

function TfrmParametrosContabilizacao.fPreencheuVigencia: Boolean;
begin
  Result := (not fEmptyStr(fTiraCaracEspeciais(mskVigIni.Text))) or (not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text)));
end;

function TfrmParametrosContabilizacao.fPreencheuVigenciaFinal: Boolean;
begin
  Result := not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text));
end;

function TfrmParametrosContabilizacao.fPlanoContabilConfiguradoOutrosModulosCredito: Boolean;
begin
  Result := True ;

  if chkCliForCre.Checked then
    Exit ;

  if chkPorCre.Checked then
    Exit ;

  if chkPlaConCre.Checked then
    Exit ;

  if chkBandeiraCredito.Checked then
    Exit ;

  if chkAbrevCredito.Checked then
    Exit ;

  Result := False ;
end;

function TfrmParametrosContabilizacao.fRetDataVigFinal(
  const AStrData: string): TDate;
begin
  if fEmptyStr(fTiraCaracEspeciais(AStrData)) then
    Result:= StrToDate('01/01/3000')
  else
    Result := StrToDate(AStrData);
end;

function TfrmParametrosContabilizacao.fRetDataVigInicial(
  const AStrData: string): TDate;
begin
  if fEmptyStr(fTiraCaracEspeciais(AStrData)) then
    Result:= StrToDate('01/01/2000')
  else
    Result := StrToDate(AStrData);
end;

function TfrmParametrosContabilizacao.fRetornaMd5Key: String;
var
  LSeqPar: String ;
begin
  LSeqPar := '' ;
  If (qryParCon.FindField('CON_SEQPAR') <> Nil) Then
    LSeqPar := qryParCon.FieldByName('CON_SEQPAR').AsString ;

  Result :=
    THashParCon.New(
      qryParCon.FieldByName('CON_DESVAL').AsString,
      qryParCon.FieldByName('CON_FORPGO').AsString,
      qryParCon.FieldByName('CON_NATOPE').AsString,
      qryParCon.FieldByName('CON_TIPLAN').AsString,
      qryParCon.FieldByName('CON_NATCFO').AsString,
      LSeqPar,
      qryParCon.FieldByName('CON_VIGINI').AsString,
      qryParCon.FieldByName('CON_VIGFIN').AsString
    ).getHash;
end;

function TfrmParametrosContabilizacao.fRetornaValorDescricao: string;
begin
  result := '' ;
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCMV] then
  begin
    result := DES_VALOR_CMV ;
    exit ;
  end ;

  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcAGP] then
  begin
    result := DES_VALOR_ORIGINAL ;
    exit ;
  end ;

  if edtTipLan.ItemIndex = -1 then
    exit ;

  result := edtValor.Items[edtValor.ItemIndex] ;
end;

function TfrmParametrosContabilizacao.fPeloMenosUmaContaInformada: Boolean;
begin
  Result := True ;

  if (not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) or
     (not cdsConCre.IsEmpty) or
     (chkCliForCre.Checked) or
     (chkPorCre.Checked) or
     (chkPlaConCre.Checked) or
     (chkBandeiraCredito.Checked) or
     (chkAbrevCredito.Checked) then
    Exit ;

  if (not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) or
     (not cdsConDeb.IsEmpty) or
     (chkCliForDeb.Checked) or
     (chkPorDeb.Checked) or
     (chkPlaConDeb.Checked) or
     (chkBandeiraDebito.Checked) or
     (chkAbrevDebito.Checked) then
    Exit ;

  Result := False ;
end;

function TfrmParametrosContabilizacao.fPeriodosSeSobrepoem(dtaIni1, dtaFin1,
  dtaIni2, dtaFin2: TDateTime): Boolean;
begin
  Result := (dtaIni1 <= dtaFin2) and (dtaFin1 >= dtaIni2);
end;

function TfrmParametrosContabilizacao.fPermiteParametrizarAbreviacao(
  blnCampoExiste: Boolean): boolean;
begin
  if fUsarAbrevProdNoCoeCos then
    Result := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcENT], COD_CONTABIL[tcSAI], COD_CONTABIL[tcCOE], COD_CONTABIL[tcCOS]]) And (blnCampoExiste)
  else
    Result := (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcENT], COD_CONTABIL[tcSAI]]) And (blnCampoExiste) ;
end;

function TfrmParametrosContabilizacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDataExibicao) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDataExibicao.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de exibição deve ser preenchida!', ['&O k']);
        Result := False;
      End
      else if not fDataValida(StrToDate(mskDataExibicao.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'Data de exibição inválida!', ['&O k']);
        Result := False;
      end;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmParametrosContabilizacao.fValidaCPC(
  const strTipLan: string): Boolean;
var
  qryAux: TUniQuery;
  intRegAtu: Integer;
  blnTemVigenciaNaQuery, blnTemVigenciaNaTela, blnTemVigenciaSobreposta: boolean;
begin
  Result := True;

  if strTipLan <> 'CPC' then
    Exit;

  if not blnRotinaCPC then
    Exit;

  intRegAtu := qryParCon.RecordCount;

  qryAux := fCriaQuery();
  try
    qryAux.SQL.Clear;

    qryAux.SQL.Add('SELECT * ');
    qryAux.SQL.Add('FROM PARCON ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CON_TIPLAN = :TIPLAN ');
    qryAux.SQL.Add('  AND CON_DESVAL = :DESVAL ');
    pSetarFiltroEmpresa(qryAux) ;
    pParamLocateOrigemCPC(qryAux, qryParCon.Fields, lstOrigemCPC, pnlOrigemCPC) ;

    qryAux.ParamByName('TIPLAN').AsString := strTipLan;
    qryAux.ParamByName('DESVAL').AsString := fRetornaValorDescricao;

    if (intAltera = 1) and (intRegAlt > 0) and (intRegAlt <= qryParCon.RecordCount) then
    begin
      qryParCon.DisableControls;
      if (intRegAtu <> intRegAlt) then
      begin
        qryParCon.RecNo := intRegAlt;
      end;

      qryAux.SQL.Add('  AND CON_SEQPAR <> :SEQPAR ');
      qryAux.ParamByName('SEQPAR').AsString := qryParCon.FieldByName('CON_SEQPAR').AsString;

      qryParCon.EnableControls;
    end;

    qryAux.Open;

    Result := qryAux.IsEmpty;

    if not Result then
    begin
      blnTemVigenciaNaTela := fPreencheuVigencia;
      while not qryAux.Eof do
      begin
        blnTemVigenciaNaQuery := not qryAux.FieldByName('CON_VIGINI').IsNull;

        if blnTemVigenciaNaQuery and blnTemVigenciaNaTela then
        begin
          if qryAux.FieldByName('CON_VIGFIN').IsNull and (not fPreencheuVigenciaFinal) then
          begin
            blnTemVigenciaSobreposta :=
              fRetDataVigInicial(qryAux.FieldByName('CON_VIGINI').AsString) >= fRetDataVigInicial(mskVigIni.Text);
          end
          else
          begin
            blnTemVigenciaSobreposta :=
              fPeriodosSeSobrepoem(
                fRetDataVigInicial(qryAux.FieldByName('CON_VIGINI').AsString),
                fRetDataVigFinal(qryAux.FieldByName('CON_VIGFIN').AsString),
                fRetDataVigInicial(mskVigIni.Text),
                fRetDataVigFinal(mskVigFin.Text)
              );
          end;

          result := not blnTemVigenciaSobreposta;
        end

        else if (not blnTemVigenciaNaQuery) and blnTemVigenciaNaTela then
          result := true

        else
          result := false;

        if not result then
          break;

        qryAux.Next;
      end;
    end;

  finally
    FreeAndNil(qryAux);
  end;

end;

function TfrmParametrosContabilizacao.fValidaDuplicidade(const blnModoIncluir:boolean = False): boolean;
var
  dtsDuplicados: TDataset;
  strMsg: string;
  blnTemVigenciaNaTela, blnTemVigenciaNaQuery, blnTemVigenciaSobreposta: Boolean;
begin
  dtsDuplicados := fGetDatasetDuplicados(blnModoIncluir);
  try
    result := dtsDuplicados.IsEmpty;

    if not result then
    begin
      strMsg := '';
      blnTemVigenciaNaTela := fPreencheuVigencia;

      while not dtsDuplicados.Eof do
      begin
        blnTemVigenciaNaQuery := (not dtsDuplicados.FieldByName('CON_VIGINI').IsNull);

        if blnTemVigenciaNaQuery and blnTemVigenciaNaTela then
        begin
          if dtsDuplicados.FieldByName('CON_VIGFIN').IsNull and (not fPreencheuVigenciaFinal) then
          begin
            blnTemVigenciaSobreposta :=
              fRetDataVigInicial(dtsDuplicados.FieldByName('CON_VIGINI').AsString) >= fRetDataVigInicial(mskVigIni.Text);
          end
          else
          begin
            blnTemVigenciaSobreposta :=
              fPeriodosSeSobrepoem(
                fRetDataVigInicial(dtsDuplicados.FieldByName('CON_VIGINI').AsString),
                fRetDataVigFinal(dtsDuplicados.FieldByName('CON_VIGFIN').AsString),
                fRetDataVigInicial(mskVigIni.Text),
                fRetDataVigFinal(mskVigFin.Text)
              );
          end;

          if blnTemVigenciaSobreposta then
          begin
            strMsg := 'Já existe um registro com esses dados cobrindo o mesmo período de vigência (ou parte dele).';
            result := false;
          end
          else
          begin
            result := true;
          end;
        end

        else if (not blnTemVigenciaNaQuery) and blnTemVigenciaNaTela then
        begin
          result := true;
        end

        else if blnTemVigenciaNaQuery and (not blnTemVigenciaNaTela) then
        begin
          strMsg := 'Já existe um outro registro com os mesmos dados utilizando vigência. ';
          strMsg := strMsg + #13 + 'Caso queira confirmar o registro atual, é obrigatório preencher a vigência.';
          result := false;
        end

        else //(not blnTemVigenciaNaQuery) and (not blnTemVigenciaNaTela)
        begin
          strMsg := 'Já existe um registro com esses dados!';
          result := false;
        end;

        if not result then
        begin
          fMensagem('ATENÇÃO!', strMsg, ['&OK']);
          break;
        end;

        dtsDuplicados.Next;
      end;
    end;
  finally
    FreeAndNil(dtsDuplicados);
  end;
end;

function TfrmParametrosContabilizacao.fValidaSAI_ENT(const strTipLan: string): Boolean;
  Var
    qryAux: TUniQuery;
    intCountFor: Integer;
    strWhereClaFis: string;
    intRegAtu: Integer;
    blnTemVigenciaNaQuery, blnTemVigenciaNaTela, blnTemVigenciaSobreposta: boolean;
begin
  intRegAtu := qryParCon.RecNo;
  qryAux := fCriaQuery(Self);
  try
    qryAux.SQL.Add('SELECT * ');
    qryAux.SQL.Add('FROM PARCON ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CON_TIPLAN = :TIPLAN ');
    qryAux.SQL.Add('  AND CON_DESVAL = :DESVAL ');
    pSetarFiltroEmpresa(qryAux) ;
    strWhereClaFis := '  AND (';
    for intCountFor := 0 to lstCfoSel.Count - 1 do
    begin
      if (intCountFor > 0) then
      begin
        strWhereClaFis := strWhereClaFis + ' OR '
      end;
      strWhereClaFis := strWhereClaFis + '(FIND_IN_SET("' +
                        lstCfoSel.Items[intCountFor] +
                        '", CON_CLAFIS) > 0)';
    end;
    qryAux.SQL.Add(strWhereClaFis + ') ');

    pParamLocateMarketPlace(qryAux, qryParCon.Fields, lstMarketPlace, pnlMarketPlace) ;
    pParamLocateGrupoProd(qryAux, qryParCon.Fields, cdsGrupoProd, pnlGrupoProd) ;

    if (edtNatOpe.Text = 'Todos') then
    begin
      qryAux.SQL.Add('  AND (CON_NATOPE <> "Todos" OR CON_NATOPE = "Todos") ');
    end
    else
    begin
      qryAux.SQL.Add('  AND (CON_NATOPE = :NATOPE OR CON_NATOPE = "Todos") ');
    end;

    if fColunaExisteConCodTri then
    begin
      qryAux.SQL.Add('  AND IFNULL(CON_CODTRI,"") = :CODTRI ');
      qryAux.ParamByName('CODTRI').AsString := edtCST.Items[edtCST.ItemIndex];
    end;

    If (Not VarIsNull(edtNatCfo.KeyValue)) Then
    begin
      qryAux.SQL.Add('  AND CON_NATCFO = :NATCFO ');
      qryAux.ParamByName('NATCFO').AsString := edtNatCfo.KeyValue ;
    end
    else
      qryAux.SQL.Add('  AND CON_NATCFO IS NULL ');

    if (intAltera = 1) and (intRegAlt > 0) and (intRegAlt <= qryParCon.RecordCount) then
    begin
      qryParCon.DisableControls;
      if (intRegAtu <> intRegAlt) then
      begin
        qryParCon.RecNo := intRegAlt;
      end;

      if (qryParCon.FindField('CON_SEQPAR') <> nil) then
      begin
        qryAux.SQL.Add('  AND CON_SEQPAR <> :SEQPAR ');
        qryAux.ParamByName('SEQPAR').AsString := qryParCon.FieldByName('CON_SEQPAR').AsString;
      end
      else
      begin
        qryAux.SQL.Add('  AND NOT (CON_TIPLAN = :TIPLAN ');
        qryAux.SQL.Add('  AND CON_FORPGO = :FORPGO ');
        qryAux.SQL.Add('  AND CON_DESVAL = :DESVAL ');
        qryAux.SQL.Add('  AND CON_NATOPE = :NATOPE ');
        qryAux.SQL.Add('  AND CON_CLAFIS = :CLAFIS ');
        qryAux.SQL.Add('  AND CON_MD5CLA = :MD5CLA ');
        qryAux.SQL.Add('  AND IFNULL(CON_PAGAME,"") = :PAGAME ');
        qryAux.SQL.Add('  AND IFNULL(CON_ORIGEM,"") = :ORIGEM ');
        qryAux.SQL.Add('  AND IFNULL(CON_PAGANT,"") = :PAGANT) ');

        qryAux.ParamByName('FORPGO').AsString := qryParCon.FieldByName('CON_FORPGO').AsString;
        qryAux.ParamByName('DESVAL').AsString := qryParCon.FieldByName('CON_DESVAL').AsString;
        qryAux.ParamByName('NATOPE').AsString := qryParCon.FieldByName('CON_NATOPE').AsString;
        qryAux.ParamByName('CLAFIS').AsString := qryParCon.FieldByName('CON_CLAFIS').AsString;
        qryAux.ParamByName('MD5CLA').AsString := qryParCon.FieldByName('CON_MD5CLA').AsString;
        qryAux.ParamByName('PAGAME').AsString := qryParCon.FieldByName('CON_PAGAME').AsString;
        qryAux.ParamByName('ORIGEM').AsString := qryParCon.FieldByName('CON_ORIGEM').AsString;
        qryAux.ParamByName('PAGANT').AsString := qryParCon.FieldByName('CON_PAGANT').AsString;
      end;
      qryParCon.EnableControls;
    end;

    if (edtNatOpe.Text <> 'Todos') then
    begin
      qryAux.ParamByName('NATOPE').AsString := edtNatOpe.Text;
    end;
    qryAux.ParamByName('TIPLAN').AsString := strTipLan;
    qryAux.ParamByName('DESVAL').AsString := fRetornaValorDescricao;

    qryAux.Open;

    Result := qryAux.IsEmpty;

    if not Result then
    begin
      blnTemVigenciaNaTela := fPreencheuVigencia;
      while not qryAux.Eof do
      begin
        blnTemVigenciaNaQuery := not qryAux.FieldByName('CON_VIGINI').IsNull;

        if blnTemVigenciaNaQuery and blnTemVigenciaNaTela then
        begin
          if qryAux.FieldByName('CON_VIGFIN').IsNull and (not fPreencheuVigenciaFinal) then
          begin
            blnTemVigenciaSobreposta :=
              fRetDataVigInicial(qryAux.FieldByName('CON_VIGINI').AsString) >= fRetDataVigInicial(mskVigIni.Text);
          end
          else
          begin
            blnTemVigenciaSobreposta :=
              fPeriodosSeSobrepoem(
                fRetDataVigInicial(qryAux.FieldByName('CON_VIGINI').AsString),
                fRetDataVigFinal(qryAux.FieldByName('CON_VIGFIN').AsString),
                fRetDataVigInicial(mskVigIni.Text),
                fRetDataVigFinal(mskVigFin.Text)
              );
          end;

          result := not blnTemVigenciaSobreposta;
        end

        else if (not blnTemVigenciaNaQuery) and blnTemVigenciaNaTela then
          result := true

        else
          result := false;

        if not result then
          break;

        qryAux.Next;
      end;
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmParametrosContabilizacao.fValidaVigencia: Boolean;
begin
  Result := False;

  if fPreencheuVigencia then
  begin
    if (not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text))) and fEmptyStr(fTiraCaracEspeciais(mskVigIni.Text)) then
    begin
      fMensagem('ATENÇÃO!','A data de vigência inicial não pode estar em branco quando a vigência final está preenchida.',['&OK']);
      Exit;
    end;

    if not fDataValida(StrToDate(mskVigIni.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'Data de vigência inicial inválida!', ['&OK']);
      Exit;
    end;

    if (not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text))) and (not fDataValida(StrToDate(mskVigFin.Text))) then
    begin
      fMensagem('ATENÇÃO!', 'Data de vigência final inválida!', ['&OK']);
      Exit;
    end;

    if (not fEmptyStr(fTiraCaracEspeciais(mskVigFin.Text))) and (StrToDate(mskVigIni.Text) > StrToDate(mskVigFin.Text)) then
    begin
      fMensagem('ATENÇÃO!', 'A data de vigência inicial não pode ser maior que a final!', ['&OK']);
      Exit;
    end;
  end;

  Result := True;
end;

function TfrmParametrosContabilizacao.fValidouTravaCustoMercadoriaVendida(const ATipoSelecionado: TTiposContabeis; const AClaFis: string): boolean;
  var
    qryBusca : TUniQuery;
    stlClaFis : TStringList;
    strClaFis : string;
begin
  Result := True;

  if AClaFis.IsEmpty then
    Exit;

  qryBusca := fCriaQuery(Self);
  stlClaFis := TStringList.Create;
  try
    stlClaFis.CommaText := AClaFis;

    if (ATipoSelecionado = tcCMV) then
    begin
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(' SELECT CON_CLAFIS, CON_VIGINI, CON_VIGFIN ');
      qryBusca.SQL.Add('   FROM PARCON ');
      qryBusca.SQL.Add('  WHERE CON_TIPLAN = "SAI" ');
      qryBusca.SQL.Add('    AND CON_DESVAL = ' + QuotedStr(DES_VALOR_CMV));
      pSetarFiltroEmpresa(qryBusca) ;
      qryBusca.Open;
    end
    else if (ATipoSelecionado = tcSAI) then
    begin
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add(' SELECT CON_CLAFIS, CON_VIGINI, CON_VIGFIN ');
      qryBusca.SQL.Add('   FROM PARCON ');
      qryBusca.SQL.Add('  WHERE CON_TIPLAN = "CMV" ');
      pSetarFiltroEmpresa(qryBusca) ;
      qryBusca.Open;
    end;

    if (qryBusca.Active) and (not qryBusca.IsEmpty) then
    begin
      qryBusca.First;
      while not qryBusca.Eof do
      begin
        if fPeriodosSeSobrepoem(
             fRetDataVigInicial(mskVigIni.Text),
             fRetDataVigFinal(mskVigFin.Text),
             fRetDataVigInicial(qryBusca.FieldByName('CON_VIGINI').AsString),
             fRetDataVigFinal(qryBusca.FieldByName('CON_VIGFIN').AsString)
           )
        then
        begin
          for strClaFis in stlClaFis do
          begin
            if qryBusca.FieldByName('CON_CLAFIS').AsString.Contains(strClaFis) then
            begin
              Result := False;
              Break;
            end;
          end;
        end;
        qryBusca.Next;
      end;
    end;
  finally
    FreeAndNil(qryBusca);
    FreeAndNil(stlClaFis);
  end;
end;

function TfrmParametrosContabilizacao.fVerificaContaContabilEmpresaLogada: boolean;
var
  qryVerifica: TUniQuery ;
  strContaCredito, strContaDebito: string ;
  strContas: string ;
  blnTemTpLaco: boolean ;
  lstTplaco: TList<string> ;
  LstrTpLaCo: string ;
  strItem: string ;
  strMensagem: string ;
  LLimiteLinhasMsg: Integer ;
begin
  result := True ;

  strContaCredito := fSemMascaraPlaNco(qryParCon.FieldByName('CON_CONCRE').AsString);
  strContaDebito  := fSemMascaraPlaNco(qryParCon.FieldByName('CON_CONDEB').AsString);

  if fEmptyStr(strContaCredito) and fEmptyStr(strContaDebito) then
  begin
    exit ;
  end;

  strContas := '' ;
  if not fEmptyStr(strContaCredito) then
  begin
    strContas := strContas + '"' + strContaCredito + '"' ;
  end;
  if not fEmptyStr(strContaDebito) then
  begin
    if fEmptyStr(strContas) then
    begin
      strContas := '"' + strContaDebito + '"' ;
    end
    else
    begin
      strContas := strContas + ',"' + strContaDebito + '"' ;
    end;
  end;

  qryVerifica := fCriaQuery() ;
  lstTplaco := TList<string>.Create() ;
  try
    blnTemTpLaco := False ;
    qryVerifica.Close ;
    qryVerifica.SQL.Clear ;
    qryVerifica.SQL.Add('SELECT DISTINCT NCO_TPLACO FROM PLANCO WHERE NCO_CODCON IN ( ' + strContas + ') ' ) ;
    qryVerifica.Open ;

    if qryVerifica.IsEmpty then
    begin
      exit ;
    end;

    qryVerifica.First ;
    while not qryVerifica.Eof do
    begin
      if qryVerifica.FieldByName('NCO_TPLACO').AsString = strTplAco then
      begin
        blnTemTpLaco := True ;
        qryVerifica.Next ;
        continue ;
      end;
      lstTplaco.Add(qryVerifica.FieldByName('NCO_TPLACO').AsString) ;
      qryVerifica.Next ;
    end;

    if blnTemTpLaco then
    begin
      exit ;
    end;

    ////separa as empresas que podem alterar a configuração na parcon
    LstrTpLaCo := '' ;
    for strItem in lstTplaco do
    begin
      if fEmptyStr(LstrTpLaCo) then
      begin
        LstrTpLaCo := '"' + strItem + '"' ;
      end
      else
      begin
        LstrTpLaCo := LstrTpLaCo + ',"' + strItem + '"' ;
      end;
    end;

    strMensagem := '' ;
    qryVerifica.Close ;
    qryVerifica.SQL.Clear ;
    qryVerifica.SQL.Add('SELECT EMP_CODEMP, EMP_NOMFAN FROM CADEMP WHERE EMP_TPLACO IN (' + LstrTpLaCo + ')') ;
    qryVerifica.Open ;
    qryVerifica.First ;
    LLimiteLinhasMsg := 1 ;
    while not qryVerifica.Eof do
    begin
      strMensagem := strMensagem + '[' + qryVerifica.FieldByName('EMP_CODEMP').AsString + '] ' + qryVerifica.FieldByName('EMP_NOMFAN').AsString + #13#10  ;
      qryVerifica.Next ;
      inc(LLimiteLinhasMsg) ;
      if LLimiteLinhasMsg > 10 then
        Break ;
    end;

    strMensagem := 'O parâmetro poderá ser alterado, quando o usuário estiver logado na empresa:' + #13#10 + strMensagem ;
    fMensagem('ATENÇÃO!',strMensagem,['&OK'], 1, False, 1, 0, False, 0, False, False, False, 0, 0, 7);
    result := False ;
  finally
    FreeAndNil(qryVerifica) ;
    FreeAndNil(lstTplaco) ;
  end;

end;

function TfrmParametrosContabilizacao.fVerificaHistoricoComplemento: boolean;
var
  LintCnt: integer ;
begin
  result := True ;

  if not fEmptyStr(edtHisCre.Text) then
  begin
    exit ;
  end ;

  if blnUsaCheckListComplemento then
  begin
    for LintCnt := 0 to cklComplemento.Count-1 do
    begin
      if cklComplemento.Checked[LintCnt] then
      begin
        exit ;
      end;
    end;
  end
  else
  begin
    if not fEmptyStr(edtCmpDebito.Text) then
    begin
      exit ;
    end ;
  end ;

  result := False ;
end;

function TfrmParametrosContabilizacao.fVerificaRegistroEmEdicao: Boolean;
begin
  Result := True;

  if fEmptyStr(edtTipLan.Text) then
    Exit;

  if fMensagem('', 'Os dados em alteração serão descartados.' + #13 + 'Deseja continuar ?', ['&Sim', '&Não'], 1) = 1 then
    pLimparTela
  else
    Result := False;
end;

procedure TfrmParametrosContabilizacao.lstCfoSelDblClick(Sender: TObject);
begin
  inherited;
  pAddCfop(lstCfoSel, lstCfoTod, True);
  pHabilitarCST(lstCfoSel.Items);
  pSetarNatOpe('');
end;

procedure TfrmParametrosContabilizacao.lstCfoSelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Delete) Then
  begin
    pAddCfop(lstCfoSel, lstCfoTod, True);
    pHabilitarCST(lstCfoSel.Items);
    pSetarNatOpe('');
  end;
end;

procedure TfrmParametrosContabilizacao.lstCfoTodDblClick(Sender: TObject);
begin
  inherited;
  pAddCfop(lstCfoTod, lstCfoSel, True);
  pHabilitarCST(lstCfoSel.Items);
end;

procedure TfrmParametrosContabilizacao.lstOrigemCPCClickCheck(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  inherited;

  if not blnRotinaCPC then
    Exit;

  if ANewState = cbsChecked then
  begin
    if lstOrigemCPC.Items.Items[AIndex].Tag = 99 then
    begin
      pLimpaOrigemCPCSel(lstOrigemCPC);
      lstOrigemCPC.Items.Items[AIndex].Checked := True;
    end
    else
    begin
      lstOrigemCPC.Items.Items[0].Checked := False;
    end;
  end;
end;

procedure TfrmParametrosContabilizacao.mskContaCreditoExit(Sender: TObject);
var
  LNatureza: String ;
begin 
  edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplAco], False);
  edtContaReduzidaCredito.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplAco], False);
  LNatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplAco], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!',IfThen(LNatureza = 'S', 'Não é possível utilizar uma Conta Contábil de Natureza Sintética', 'Conta de Crédito Inválida!'),['&OK']);
    pSetFocus(mskContaCredito);
    Exit;
  End;
end;

procedure TfrmParametrosContabilizacao.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCRedito, Nil, Key, arrPlan, True, strTplAco, True, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmParametrosContabilizacao.mskContaDebitoExit(Sender: TObject);
var
  LNatureza: String ;
begin
  edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplAco], False);
  edtContaReduzidaDebito.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplAco], False);
  LNatureza := fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplAco], False);
  If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', IfThen(LNatureza = 'S', 'Não é possível utilizar uma Conta Contábil de Natureza Sintética', 'Conta de Débito Inválida!'),['&OK']);
    pSetFocus(mskContaDebito);
    Exit;
  End;
end;

procedure TfrmParametrosContabilizacao.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPlan: TConsultasArray;
begin
  If fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan, True, strTplAco, True, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmParametrosContabilizacao.mskDataExibicaoExit(Sender: TObject);
begin
  inherited;

  if not fValidaCampos(mskDataExibicao) then
    Exit;

  pFiltrar(mskDataExibicao);
end;

procedure TfrmParametrosContabilizacao.OnGeraExcel(Excel: TExcel;
  Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
begin
  //
end;

procedure TfrmParametrosContabilizacao.pAddCfop(lstOrigem, lstDestino: TListBox; blnFocu: Boolean = False);
  Var
    intCnt : Integer;
    intLastDel : Integer;
    strValorAnterior : string;
begin
  inherited;

  For intCnt := 0 To lstOrigem.Count-1 Do
  Begin
    If lstOrigem.Selected[intCnt] Then
      lstDestino.Items.Add(lstOrigem.Items[intCnt]);
  End;

  intLastDel := -1;

  While lstOrigem.SelCount > 0 Do
  Begin
    For intCnt := 0 To lstOrigem.Count-1 Do
    Begin
      If lstOrigem.Selected[intCnt] Then
      Begin
        lstOrigem.Items.Delete(intCnt);
        intLastDel := intCnt;
        Break;
      End;
    End;
  End;

  If (blnFocu) And (lstOrigem.Count > 0) Then
  Begin
    If (intLastDel-1) <= (lstOrigem.Count-1) Then
      lstOrigem.Selected[intLastDel-1] := True
    Else
      lstOrigem.Selected[0] := True;
  End;

  If (edtTipLan.ItemIndex In [5,6]) Then
  Begin
    strValorAnterior := edtValor.Text;
    edtValor.Items.Clear;
    pSetaItensEntradaSaida(edtValor, lstCfoSel.Items.CommaText.Contains('933'), IIF(fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT], 'ENT', 'SAI'), lstCfoSel.Items.CommaText.Contains('933'));
    edtValor.ItemIndex := edtValor.Items.IndexOf(strValorAnterior);
  End;
end;

procedure TfrmParametrosContabilizacao.pAdicionaOpcaoAjusteHub;
begin
  if not FblnAjusteHub then
    Exit ;

  edtValor.Items.Add(DES_VALOR_AJUSTE_HUB) ;
end;

procedure TfrmParametrosContabilizacao.pAdicionaOpcaoDescontoHub;
begin
  if not FblnDescontoHub then
    Exit ;

  edtValor.Items.Add(DES_VALOR_DESCONTO_HUB) ;
end;

procedure TfrmParametrosContabilizacao.pAdicionaOpcaoFreteHub;
begin
  if not FblnFreteHub then
    Exit ;

  edtValor.Items.Add(DES_VALOR_FRETE_HUB) ;
end;

procedure TfrmParametrosContabilizacao.pFiltrar(Sender: TWinControl);
begin
  if fSelecionouFiltroAtual(Sender) then
    Exit;

  if fVerificaRegistroEmEdicao then
  begin
    pAtualizaFiltroAtual;
    pCarregaParCon;
  end
  else
    pReverteParaFiltroAtual(Sender);
end;

procedure TfrmParametrosContabilizacao.pAtualizaFiltroAtual;
begin
  if rdbAtivos.Checked then
    FFiltroAtual.ARadio := rdbAtivos
  else if rdbInativos.Checked then
    FFiltroAtual.ARadio := rdbInativos
  else if rdbTodos.Checked then
    FFiltroAtual.ARadio := rdbTodos
  else
  begin
    rdbAtivos.Checked := True;
    FFiltroAtual.ARadio := rdbAtivos;
  end;

  if fEmptyStr(fTiraCaracEspeciais(mskDataExibicao.Text)) then
    mskDataExibicao.Text := FormatDateTime('DD/MM/YYYY', VS_Date);

  FFiltroAtual.AStrData := mskDataExibicao.Text;
end;

procedure TfrmParametrosContabilizacao.pAtualizaMd5;
  Var
    qryMd5 : TUniQuery;
    strOrigem : String;
    strPagant : string;
begin
  { Grava em PARCON, entao tem de passar pela query auditada -- antes usava fCriaQuery,
    uma TUniQuery comum, sem os hooks de LOGAJC. Roda no FormCreate e reescreve todas as
    linhas de MD5 vazio, o que tornava a omissao especialmente cara. A variavel fica
    declarada como TUniQuery porque pSetarFiltroEmpresa recebe var TUniQuery; o objeto
    em si e TUniQueryAuditoria e os hooks disparam normalmente. }
  qryMd5 := fCriaQueryContabilidade('PARCON', Self.Name, Self);
  Try
    { Um SEQAJU para todo o preenchimento, e nao um por linha: e uma operacao so. }
    TLogAjcOpContext.BeginContext;
    Try
      qryMd5.SQL.Clear ;
      qryMd5.SQL.Add('SELECT * FROM PARCON WHERE IFNULL(CON_MD5CLA,"") = "" ') ;
      pSetarFiltroEmpresa(qryMd5) ;
      qryMd5.Open;
      qryMd5.First;
      While Not qryMd5.Eof Do
      Begin
        strOrigem := '';
        if (blnCON_ORIGEM) then
          strOrigem := qryMd5.FieldByName('CON_ORIGEM').AsString;

        strPagant := '';
        if Assigned(qryMd5.FindField('CON_PAGANT')) then
          strPagant := qryMd5.FieldByName('CON_PAGANT').AsString;

        qryMd5.Edit;
        qryMd5.FieldByName('CON_MD5CLA').AsString := fMD5Chave(qryMd5.FieldByName('CON_CLAFIS').AsString, qryMd5.FieldByName('CON_PAGAME').AsString, strOrigem, strPagant);
        qryMd5.Post;
        qryMd5.Next;
      End;
    Finally
      TLogAjcOpContext.EndContext;
    End;
  Finally
    FreeAndNil(qryMd5);
  End;
end;

procedure TfrmParametrosContabilizacao.pAtualizaVigenciaNull;
var
  dtsDuplicados: TDataset;
  qryUpdate: TUniquery;
begin
  if not fPreencheuVigencia then
    exit;

  dtsDuplicados := fGetDatasetDuplicados(False);
  try
    while not dtsDuplicados.Eof do
    begin
      if dtsDuplicados.FieldByName('CON_VIGFIN').IsNull then
      begin
        if (dtsDuplicados.FieldByName('CON_VIGINI').IsNull) or (StrToDateTime(mskVigIni.Text) > dtsDuplicados.FieldByName('CON_VIGINI').AsDateTime) then
        begin
          { Fecha a vigencia de um parametro VIZINHO, nao do que o usuario editou. Era um
            UPDATE por ExecSQL numa query comum: alterava PARCON sem gerar LOGAJC e sem
            tocar CON_DTAHRA. Agora abre o registro pela query auditada e grava por
            Edit/Post, que e o que dispara os hooks -- ExecSQL nao dispara. Roda dentro da
            transacao e do contexto do btnConfirmarClick, entao compartilha o SEQAJU da
            operacao. }
          qryUpdate := fCriaQueryContabilidade('PARCON', Self.Name, Self);
          try
            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add(' SELECT * ');
            qryUpdate.SQL.Add('   FROM PARCON ');
            qryUpdate.SQL.Add('  WHERE CON_SEQPAR = :SEQPAR ');
            pSetarFiltroEmpresa(qryUpdate) ;

            qryUpdate.ParamByName('SEQPAR').AsString := dtsDuplicados.FieldByName('CON_SEQPAR').AsString;
            qryUpdate.Open;

            if not qryUpdate.IsEmpty then
            begin
              qryUpdate.Edit;

              if dtsDuplicados.FieldByName('CON_VIGINI').IsNull then
                qryUpdate.FieldByName('CON_VIGINI').AsDateTime := StrToDate('01/01/2000')
              else
                qryUpdate.FieldByName('CON_VIGINI').AsDateTime := dtsDuplicados.FieldByName('CON_VIGINI').AsDateTime;

              qryUpdate.FieldByName('CON_VIGFIN').AsDateTime := IncDay(StrToDate(mskVigIni.Text), -1);

              qryUpdate.Post;
            end;
          finally
            FreeAndNil(qryUpdate);
          end;

          break;
        end;
      end;

      dtsDuplicados.Next;
    end;
  finally
    FreeAndNil(dtsDuplicados);
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregaCdsContasDesmem(const strMd5Key,
  strSeqPar, strCreDeb: String; var Acds: TUniClientDataSet);
var
  LqryParNco : TUniQuery;
begin
  LqryParNco := fCriaQuery(Self);
  try
    Acds.EmptyDataSet;
    LqryParNco.Close;
    LqryParNco.SQL.Clear;
    LqryParNco.SQL.Add('SELECT PARNCO.*');
    LqryParNco.SQL.Add('FROM PARNCO ');
    LqryParNco.SQL.Add('WHERE NCO_CREDEB = :CREDEB ');
    LqryParNco.SQL.Add('  AND ' + fParNcoWhereSql(strSeqPar));
    LqryParNco.SQL.Add('ORDER BY NCO_CODEMP ');
    LqryParNco.ParamByName('CREDEB').AsString := strCreDeb;
    LqryParNco.Open;

    LqryParNco.First;
    While Not LqryParNco.Eof Do
    Begin
      Acds.Insert;
      Acds.FieldByName('CODCON').AsString := LqryParNco.FieldByName('NCO_CODCON').AsString;
      Acds.FieldByName('CODEMP').AsString := LqryParNco.FieldByName('NCO_CODEMP').AsString;
      Acds.FieldByName('CONMSK').AsString := FormatMaskText(fMskCon, LqryParNco.FieldByName('NCO_CODCON').AsString);
      Acds.Post;
      LqryParNco.Next;
    End;
    LqryParNco.Close;
  finally
    FreeAndNil(LqryParNco);
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregaCfo;
begin
  qryCadCfo.Close;
  qryCadCfo.SQL.Text := 'SELECT CFO_CODCFO FROM CADCFO ORDER BY CFO_CODCFO';
  qryCadCfo.Open;

  lstTodosCfopsEnt.Clear;
  lstTodosCfopsSai.Clear;
  lstTodosCfops.Clear;
  qryCadCfo.First;
  While Not qryCadCfo.Eof Do
  Begin

    lstTodosCfops.Add(qryCadCfo.FieldByName('CFO_CODCFO').AsString);

    If StrToIntDef(LeftStr(qryCadCfo.FieldByName('CFO_CODCFO').AsString, 1), 0) >= 5 Then
      lstTodosCfopsSai.Add(qryCadCfo.FieldByName('CFO_CODCFO').AsString)
    Else
      lstTodosCfopsEnt.Add(qryCadCfo.FieldByName('CFO_CODCFO').AsString);

    qryCadCfo.Next;
  End;
end;

procedure TfrmParametrosContabilizacao.pCarregaContasDesmem(strMd5Key, strSeqPar: String);
begin
  pCarregaCdsContasDesmem(strMd5Key, strSeqPar, 'D', cdsConDeb);
  pCarregaCdsContasDesmem(strMd5Key, strSeqPar, 'C', cdsConCre);

  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);

  if not cdsConCre.isEmpty then
  begin
    mskContaCredito.Enabled := False;
    mskContaCredito.Clear;
  end;

  if not cdsConDeb.isEmpty then
  begin
    mskContaDebito.Enabled := False;
    mskContaDebito.Clear;
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregaCST;
var
  qryCST: TUniQuery ;
begin
  qryCST := fCriaQuery() ;
  try
    qryCST.Close ;
    qryCST.SQL.Clear ;
    qryCST.SQL.Add('SELECT DISTINCT TRI_CODTRI FROM CADTRI ORDER BY TRI_CODTRI') ;
    qryCST.Open ;
    qryCST.First ;
    edtCST.Items.BeginUpdate ;
    try
      edtCST.Items.Clear ;
      edtCST.Items.Add('');
      while not qryCST.Eof do
      begin
        edtCST.Items.Add(qryCST.FieldByName('TRI_CODTRI').AsString) ;
        qryCST.Next ;
      end;
    finally
      edtCST.Items.EndUpdate ;
    end;
  finally
    FreeAndNil(qryCST) ;
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregaFormaPagamentoPCP;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcPCP] then
    exit ;

  edtForPag.Items.Clear ;
  edtForPag.Items.Add(FPG_TODAS);
  edtForPag.ItemIndex := 0 ;
end;

procedure TfrmParametrosContabilizacao.pCarregaFormaPagamentoPCR;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcPCR] then
    exit ;

  edtForPag.Items.Clear ;
  edtForPag.Items.Add(FPG_TODAS);
  edtForPag.ItemIndex := 0 ;
end;

procedure TfrmParametrosContabilizacao.pCarregaFormaPagamentosPadrao;
begin
  edtForPag.Items.Clear;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcTCC]) then
  begin
    edtForPag.Items.Add(FPG_CHEQUE_VISTA);
    edtForPag.Items.Add(FPG_CHEQUE_PRE);
    edtForPag.Items.Add(FPG_CARTAO);
    exit ;
  end ;

  if (not (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcPCP], COD_CONTABIL[tcPCR], COD_CONTABIL[tcCHQ]])) then
  begin
    edtForPag.Items.Add(FPG_DINHEIRO);
    edtForPag.Items.Add(FPG_CHEQUE_VISTA);
    edtForPag.Items.Add(FPG_CHEQUE_PRE);
    edtForPag.Items.Add(FPG_CARTAO);
    edtForPag.Items.Add(FPG_ORDPAG);
  end;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcADT], COD_CONTABIL[tcCTP]]) then
    edtForPag.Items.Add(FPG_CREDITO);

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCRC]]) then
  begin
    edtForPag.Items.Add(FPG_ADIANTAMENTO);
  end ;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]) then
  begin
    edtForPag.Items.Add(FPG_GARANTIA);
  end ;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcBAN]) then
  begin
    edtForPag.Items.Add(FPG_FINANCIAMENTO) ;
  end ;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCTP]]) then
  begin
    edtForPag.Items.Add(FPG_DESCONTO_TOTAL);
    edtForPag.Items.Add(FPG_DESCONTO_TOTAL_CREDITO);
  end ;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCHQ]) then
  begin
    edtForPag.Items.Add(FPG_CHEQUE_VISTA);
    edtForPag.Items.Add(FPG_CHEQUE_PRE);
  end ;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcANT]) then
  begin
    edtForPag.Items.Clear;
    edtForPag.Items.Add(FPG_DINHEIRO);
    edtForPag.Items.Add(FPG_CHEQUE_VISTA);
    edtForPag.Items.Add(FPG_ORDPAG);
  end ;

  edtForPag.Items.Add(FPG_TODAS);
end;

procedure TfrmParametrosContabilizacao.pCarregaGrupoProd(
  var AcdsDados: TUniClientDataSet);
var
  LqryConsulta: TUniQuery ;
begin

  if not FblnCadGruExiste then
  begin
    exit ;
  end ;

  AcdsDados.DisableControls ;
  try
    AcdsDados.EmptyDataSet ;

    LqryConsulta := fCriaQuery() ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT GRU_CODGRU, GRU_DESGRU FROM CADGRU ORDER BY GRU_DESGRU') ;
      LqryConsulta.Open ;
      LqryConsulta.First ;

      while not LqryConsulta.Eof do
      begin
        AcdsDados.Append ;
        AcdsDados.FieldByName('SELECI').AsBoolean := False ;
        AcdsDados.FieldByName('CODGRU').AsString := LqryConsulta.FieldByName('GRU_CODGRU').AsString ;
        AcdsDados.FieldByName('DESGRU').AsString := LqryConsulta.FieldByName('GRU_DESGRU').AsString ;
        AcdsDados.FieldByName('GRUPO').AsString := LqryConsulta.FieldByName('GRU_CODGRU').asString + '-' + LqryConsulta.FieldByName('GRU_DESGRU').asString ;
        AcdsDados.Post ;
        LqryConsulta.Next ;
      end;
      AcdsDados.First ;
    finally
      FreeAndNil(LqryConsulta) ;
    end;

  finally
    AcdsDados.EnableControls ;
  end;

end;

procedure TfrmParametrosContabilizacao.pCarregaMarketPlace(
  var AlstItens: TcxCheckListBox);
var
  LqryConsulta: TUniQuery ;
  LclbiItem: TcxCheckListBoxItem ;
begin

  AlstItens.Items.BeginUpdate ;
  try
    AlstItens.Items.Clear ;

    LqryConsulta := fCriaQuery() ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT ORI_CODORI, ORI_DESORI FROM ORIFGO ORDER BY ORI_CODORI') ;
      LqryConsulta.Open ;
      LqryConsulta.First ;

      while not LqryConsulta.Eof do
      begin
        LclbiItem := AlstItens.Items.Add ;
        LclbiItem.Text := LqryConsulta.FieldByName('ORI_CODORI').asString + '-' + LqryConsulta.FieldByName('ORI_DESORI').asString ;
        LclbiItem.Tag := LqryConsulta.FieldByName('ORI_CODORI').asInteger ;
        LqryConsulta.Next ;
      end;

    finally
      FreeAndNil(LqryConsulta) ;
    end;

  finally
    AlstItens.Items.EndUpdate ;
  end;

end;

procedure TfrmParametrosContabilizacao.pCarregaNatCfo;
begin
  qryNatCfo.Close;
  qryNatCfo.SQL.Clear;
  qryNatCfo.SQL.Add(' SELECT  NAT_CODCFO, CAST(COALESCE(NAT_DESCRI,CONCAT("(Descrição em branco - ", NAT_CODCFO, ")")) AS CHAR(50)) AS NAT_DESCRI, AUTOINCREM ');
  qryNatCfo.SQL.Add('   FROM NATCFO ');

  If lstCfoSel.Count > 0 Then
    qryNatCfo.SQL.Add(' WHERE LOCATE(NAT_CODCFO, ' + QuotedStr(lstCfoSel.Items.CommaText) + ') > 0 ');

  qryNatCfo.SQL.Add('  ORDER BY NAT_CODCFO, NAT_DESCRI ');
  qryNatCfo.Open;
end;

procedure TfrmParametrosContabilizacao.pCarregaOrigemCPC(
  var AlstItens: TcxCheckListBox);
var
  LqryConsulta: TUniQuery ;
  LclbiItem: TcxCheckListBoxItem ;
begin
  if not blnRotinaCPC then
    Exit;

  AlstItens.Items.BeginUpdate ;
  try
    AlstItens.Items.Clear ;

    LqryConsulta := fCriaQuery() ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Text := 'SELECT FIN_CODIGO, FIN_DESCRI FROM CBCFIN ORDER BY FIN_CODIGO ';
      LqryConsulta.Open ;

      if LqryConsulta.RecordCount > 0 then
      begin
        LclbiItem := AlstItens.Items.Add ;
        LclbiItem.Text := '99-TODAS' ;
        LclbiItem.Tag := 99;

        while not LqryConsulta.Eof do
        begin
          LclbiItem := AlstItens.Items.Add ;
          LclbiItem.Text := LqryConsulta.FieldByName('FIN_CODIGO').asString + '-' + LqryConsulta.FieldByName('FIN_DESCRI').asString ;
          LclbiItem.Tag := StrToIntDef(LqryConsulta.FieldByName('FIN_CODIGO').asString, 0);
          LqryConsulta.Next ;
        end;
      end;

    finally
      FreeAndNil(LqryConsulta) ;
    end;

  finally
    AlstItens.Items.EndUpdate ;
  end;

end;

procedure TfrmParametrosContabilizacao.pCarregaPagamentoANT;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcANT] then
    exit ;

  edtPagamentos.Items.Clear;
  edtPagamentos.Items.Add('Pagamentos Avulsos');
  edtPagamentos.ItemIndex := 0 ;
end;

procedure TfrmParametrosContabilizacao.pCarregaPagamentoCTP;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCTP] then
    exit ;

  edtPagamentos.Items.Add(PGT_PAGAMENTO_PCP);
end;

procedure TfrmParametrosContabilizacao.pCarregaPagamentoCTR;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCTR] then
    exit ;

  edtPagamentos.Items.Add(PGT_PAGAMENTO_PCR);
end;

procedure TfrmParametrosContabilizacao.pCarregaPagamentoPCP;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcPCP] then
    exit ;

  edtPagamentos.Items.Clear;
  edtPagamentos.Items.Add('Pagamentos Avulsos');
  edtPagamentos.ItemIndex := 0 ;
end;

procedure TfrmParametrosContabilizacao.pCarregaPagamentoPCR;
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcPCR] then
    exit ;

  edtPagamentos.Items.Clear;
  edtPagamentos.Items.Add('Pagamentos Avulsos');
  edtPagamentos.ItemIndex := 0 ;
end;

procedure TfrmParametrosContabilizacao.pCarregaParCon;
var
  strTplaco: string ;
  LblnHisTpl: Boolean;
begin
  strTplaco := fRetTplacoEmpresaLogada ;
  LblnHisTpl := fCfgHisTpl;

  qryParCon.Close;
  qryParCon.SQL.Clear;
  qryParCon.SQL.Add(' SELECT PARCON.*, CON_CLAFIS AS CLAFIS, '); // LEFT(CON_CLAFIS, 4) AS CLAFIS
  qryParCon.SQL.Add('        CRE.NCO_DESCRI AS DESCRE, DEB.NCO_DESCRI AS DESDEB, ');
  qryParCon.SQL.Add('        HISCRE.PAD_DESCRI AS HISCRE, CON_NATCFO, CON_MD5CLA,  ');
  qryParCon.SQL.Add('        IF(TRUE ' + fFiltroVigenciaParcon(strToDate(FFiltroAtual.AStrData)) + ', "ATIVO", "INATIVO") AS STATUS, ');
  qryParCon.SQL.Add('        IF(PARCON.CON_TIPLAN <> "CPC", CON_ORIGEM, CON_ORICPC) AS ORIGEM, NATCFO.NAT_DESCRI ');
  qryParCon.SQL.Add('   FROM PARCON ');
  qryParCon.SQL.Add('   LEFT JOIN PLANCO CRE ON CRE.NCO_CODCON = CON_CONCRE AND CRE.NCO_TPLACO = :TPLACO ');
  qryParCon.SQL.Add('   LEFT JOIN PLANCO DEB ON DEB.NCO_CODCON = CON_CONDEB AND DEB.NCO_TPLACO = :TPLACO ');
  qryParCon.SQL.Add('   LEFT JOIN NATCFO ON NATCFO.AUTOINCREM = CON_NATCFO ');

  qryParCon.SQL.Add('   LEFT JOIN HISPAD HISCRE ON HISCRE.PAD_CODIGO = CON_HISCRE ');
  if LblnHisTpl then
    qryParCon.SQL.Add(' AND HISCRE.PAD_TPLACO = :TPLACO ')
  else
    qryParCon.SQL.Add(' AND IFNULL(HISCRE.PAD_TPLACO, "") = "" ');

  qryParCon.SQL.Add('   LEFT JOIN HISPAD HISDEB ON HISDEB.PAD_CODIGO = CON_HISDEB ');
  if LblnHisTpl then
    qryParCon.SQL.Add(' AND HISDEB.PAD_TPLACO = :TPLACO')
  else
    qryParCon.SQL.Add(' AND IFNULL(HISDEB.PAD_TPLACO, "") = "" ');

  if fCfgConEmp = 'S' then
  begin
    qryParCon.SQL.Add(' WHERE PARCON.CON_CODEMP = :CODEMP ');
    qryParCon.ParamByName('CODEMP').AsString := VS_strCodEmp ;
  end
  else
  begin
    qryParCon.SQL.Add(' WHERE PARCON.CON_CODEMP IS NULL ');
  end ;

  if not fCfgSis('AJUPAR', varBoolean) then
    qryParCon.SQL.Add(' AND PARCON.CON_TIPLAN NOT IN ("AJE","AJS") ');

  if not fCfgSis('AJUICM', varBoolean) then
    qryParCon.SQL.Add(' AND PARCON.CON_TIPLAN <> "AJI" ');

  if FFiltroAtual.ARadio = rdbAtivos then
    qryParCon.SQL.Add(fFiltroVigenciaParcon(strToDate(FFiltroAtual.AStrData), true))
  else if FFiltroAtual.ARadio = rdbInativos then
    qryParCon.SQL.Add(fFiltroVigenciaParcon(strToDate(FFiltroAtual.AStrData), false));

  qryParCon.SQL.Add('  ORDER BY CON_DTAHRA DESC ');
  qryParCon.ParamByName('TPLACO').AsString := strTplaco ;
  qryParCon.Open;
  dtsDados.DataSet := qryParCon;

  qryParCon.FieldByName('CON_CONCRE').EditMask := strMascara;
  qryParCon.FieldByName('CON_CONDEB').EditMask := strMascara;
end;

procedure TfrmParametrosContabilizacao.pCarregarListaDeComplementos;
begin
  if not cklComplemento.Visible then
    exit;

  cklComplemento.Items.Clear;
  cklComplemento.Items.Add('N. Docto');
  cklComplemento.Items.Add('Nome fornecedor/cliente');
  cklComplemento.Items.Add('CNPJ');

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcIMO] ) then
  begin
    cklComplemento.Items.Add('Codigo Bem');
    cklComplemento.Items.Add('N. Patrimonio');
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTP], COD_CONTABIL[tcPCP], COD_CONTABIL[tcAGP]]) then
  begin
    cklComplemento.Items.Add('Competência');
    cklComplemento.Items.Add('Parcela');
    cklComplemento.Items.Add('Nome Empresa');
    cklComplemento.Items.Add('Código Empresa');
    cklComplemento.Items.Add('Data de Cadastro');
    cklComplemento.Items.Add('N. Cheque');
    cklComplemento.Items.Add('Hist. Padrão');

    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]) then
    begin
      cklComplemento.Items.Add('Histórico da Baixa');
      cklComplemento.Items.Add('Portador da Baixa');
    end;
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTR], COD_CONTABIL[tcPCR], COD_CONTABIL[tcCRC], COD_CONTABIL[tcAGR]]) then
  begin
    cklComplemento.Items.Add('Parcela');
    cklComplemento.Items.Add('N. Cheque');
    cklComplemento.Items.Add('Hist. Padrão');

    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCRC]]) then
    begin
      cklComplemento.Items.Add('Nome Empresa');
      cklComplemento.Items.Add('Código Empresa');
      cklComplemento.Items.Add('Data de Cadastro');
    end;

    if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR] then
    begin
      cklComplemento.Items.Add('Portador Recebimento');
      cklComplemento.Items.Add('Histórico da Baixa');
    end;
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcADT]]) then
  begin
    cklComplemento.Items.Add('Parcela');
    cklComplemento.Items.Add('N. Cheque');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT] then
  begin
    cklComplemento.Items.Add('Nome Empresa');
    cklComplemento.Items.Add('Código Empresa');
    cklComplemento.Items.Add('Data de Pagamento');
    If fCfgAgrLan <> 'S' Then
      cklComplemento.Items.Add('CFOP');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcBAN] then
  begin
    cklComplemento.Items.Add('Histórico da Movimentação');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcSAI] then
  begin
    cklComplemento.Items.Add('Nome Empresa');
    cklComplemento.Items.Add('Código Empresa');
    cklComplemento.Items.Add('Data de Recebimento');
    If fCfgAgrLan <> 'S' Then
      cklComplemento.Items.Add('CFOP');
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCMV], COD_CONTABIL[tcCOE], COD_CONTABIL[tcCOS]]) then
  begin
    cklComplemento.Items.Add('CFOP');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcGNR] then
  begin
    cklComplemento.Items.Add('Hist. Padrão');
    cklComplemento.Items.Add('Histórico da Baixa');
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCAR], COD_CONTABIL[tcCHQ]]) then
  begin
    cklComplemento.Items.Add('Histórico da Baixa');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcAJI] then
  begin
    cklComplemento.Items.Add('Nota Fiscal');
    cklComplemento.Items.Add('Observação');
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregarComboDeComplementos;
begin
  edtCmpDebito.Items.Clear;

  edtCmpDebito.Items.Add('');
  edtCmpDebito.Items.Add('N. Docto');
  edtCmpDebito.Items.Add('N. Docto. Nome fornecedor/cliente');
  edtCmpDebito.Items.Add('Nome fornecedor/cliente');
  edtCmpDebito.Items.Add('N. Conhecimento. Nome transportadora');
  edtCmpDebito.Items.Add('N. Docto. / CNPJ / Nome fornecedor/cliente');

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcIMO]) then
  begin
    edtCmpDebito.Items.Add('Codigo Bem');
    edtCmpDebito.Items.Add('N. Patrimonio');
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTP], COD_CONTABIL[tcPCP], COD_CONTABIL[tcAGP]]) then
  begin
    edtCmpDebito.Items.Add('N.Docto/Nome fornec./cliente/Comp./Parcela');
    edtCmpDebito.Items.Add('N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Ori');
    edtCmpDebito.Items.Add('N.Docto / Nome fornecedor/cliente / N.Cheque');
    edtCmpDebito.Items.Add('N.Docto / Nome fornecedor/cliente / Hist.Padrão');
    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]) then
      edtCmpDebito.Items.Add('N.Docto/Histórico da baixa');
  end
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTR], COD_CONTABIL[tcPCR], COD_CONTABIL[tcCRC], COD_CONTABIL[tcAGR]]) then
  begin
    edtCmpDebito.Items.Add('N.Docto/Nome fornec./cliente/Parcela');
    edtCmpDebito.Items.Add('N.Docto / Nome fornecedor/cliente / N.Cheque');
    edtCmpDebito.Items.Add('N.Docto / Nome fornecedor/cliente / Hist.Padrão');
    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCTR], COD_CONTABIL[tcCRC]]) then
      edtCmpDebito.Items.Add('N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Ori');
    if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR] then
      edtCmpDebito.Items.Add('N.Docto/Histórico da baixa');
  end
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT] then
    edtCmpDebito.Items.Add('N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Pgo')
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcBAN] then
    edtCmpDebito.Items.Add('Histórico da Movimentação')
  else if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcSAI] then
    edtCmpDebito.Items.Add('N.Docto/Nome forn./cli./Nome Emp/N.Emp./DtaDoc.Rec')
  else if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) in [COD_CONTABIL[tcCAR], COD_CONTABIL[tcCHQ]]) then
    edtCmpDebito.Items.Add('N.Docto/Histórico da baixa');
end;

procedure TfrmParametrosContabilizacao.pCarregarDadosDoComplemento(strMd5Key,
  strSeqPar: string; strComplementoAntigo: string = '');

  var
    intIndex : Integer;

  procedure pSetarComple(Value: string);
  begin
    intIndex := cklComplemento.Items.IndexOf(Value);
    if (intIndex >= 0) then
      cklComplemento.Checked[intIndex] := True;
  end;

  var
    qryDados : TUniQuery;
begin
  if not blnUsaCheckListComplemento then
    exit;

  qryDados := fCriaQuery(Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT PAR_COMPLE FROM CMPPAR WHERE');

    if (not fEmptyStr(strSeqPar)) then
    begin
      qryDados.SQL.Add(' PAR_SEQPAR = :SEQPAR ');
      qryDados.ParamByName('SEQPAR').AsString := strSeqPar;
    end
    else
    begin
      qryDados.SQL.Add(' PAR_MD5KEY = :MD5KEY ');
      qryDados.ParamByName('MD5KEY').AsString := strMd5Key;
    end;

    qryDados.Open;

    if not qryDados.isEmpty then
    begin
      qryDados.First;
      while not qryDados.eof do
      begin
        intIndex := cklComplemento.Items.IndexOf(qryDados.FieldByName('PAR_COMPLE').AsString);
        if (intIndex >= 0) then
          cklComplemento.Checked[intIndex] := True;
        qryDados.next;
      end;
    end
    else if (not fEmptyStr(strComplementoAntigo)) then
    begin
      if (strComplementoAntigo.Contains('N. Doct')) or
         (strComplementoAntigo.Contains('N.Doct')) then
      begin
        pSetarComple('N. Docto');
      end;

      if (strComplementoAntigo.Contains('Nome fornecedor/client')) or
         (strComplementoAntigo.Contains('Nome fornec./client')) or
         (strComplementoAntigo.Contains('Nome forn./cli')) then
      begin
        pSetarComple('Nome fornecedor/cliente');
      end;

      if (strComplementoAntigo.Contains('N. Conhec')) then
      begin
        pSetarComple('N. Conhecimento');
      end;

      if (strComplementoAntigo.Contains('Nome transp')) then
      begin
        pSetarComple('Nome transportadora');
      end;

      if (strComplementoAntigo.Contains('CNPJ')) then
      begin
        pSetarComple('CNPJ');
      end;

      if (strComplementoAntigo.Contains('Comp.')) then
      begin
        pSetarComple('Competência');
      end;

      if (strComplementoAntigo.Contains('Parcel')) then
      begin
        pSetarComple('Parcela');
      end;

      if (strComplementoAntigo.Contains('Nome Emp')) then
      begin
        pSetarComple('Nome Empresa');
      end;

      if (strComplementoAntigo.Contains('N.Emp')) then
      begin
        pSetarComple('Código Empresa');
      end;

      if (strComplementoAntigo.Contains('DtaDoc.Or')) then
      begin
        pSetarComple('Data de Cadastro');
      end;

      if (strComplementoAntigo.Contains('N.Chequ')) then
      begin
        pSetarComple('N. Cheque');
      end;

      if (strComplementoAntigo.Contains('Hist.Padr')) then
      begin
        pSetarComple('Hist. Padrão');
      end;

      if (strComplementoAntigo.Contains('Histórico da baix')) then
      begin
        pSetarComple('Histórico da Baixa');
      end;

      if (strComplementoAntigo.Contains('DtaDoc.Pg')) then
      begin
        pSetarComple('Data de Pagamento');
      end;

      if (strComplementoAntigo.Contains('Histórico da Movimenta')) then
      begin
        pSetarComple('Histórico da Movimentação');
      end;

      if (strComplementoAntigo.Contains('DtaDoc.Re')) then
      begin
        pSetarComple('Data de Recebimento');
      end;
    end;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregarDadosEmTela;
  Var
    intCnt : Integer;
    intIndice : Integer;
    strMd5Key, strSeqPar : string;
begin
  inherited;
  If (Not qryParCon.IsEmpty) Then
  Begin
    pLimparTela;

    if not fVerificaContaContabilEmpresaLogada then
    begin
      exit ;
    end;

    intRegAlt := qryParCon.RecNo;

    edtTipLan.ItemIndex := fGetIndexTipLan(qryParCon.FieldByName('CON_TIPLAN').AsString);
    strTipLanOriginal := qryParCon.FieldByName('CON_TIPLAN').AsString;
    edtTipLanChange(Nil);

    edtForPag.ItemIndex := edtForPag.Items.IndexOf(qryParCon.FieldByName('CON_FORPGO').AsString);

    pSetMarketPlace(qryParCon.Fields, lstMarketPlace) ;
    pSetOrigemCPC(qryParCon.Fields, lstOrigemCPC) ;
    pSetGrupoProd(qryParCon.Fields, cdsGrupoProd) ;

    // carregar os cfops
    lstCfoSel.Items.CommaText := qryParCon.FieldByName('CON_CLAFIS').AsString;
    for intCnt := 0 To lstCfoSel.Items.Count-1 do
    begin
      intIndice := lstCfoTod.Items.IndexOf(lstCfoSel.Items[intCnt]);
      If (intIndice >= 0) Then
        lstCfoTod.Items.Delete(intIndice);
    end;

    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR]) then
      pSetaItensCTR_PCR(edtValor);

    If (edtTipLan.ItemIndex In [5,6]) Then
    begin
      edtValor.Clear;
      pSetaItensEntradaSaida(edtValor, lstCfoSel.Items.CommaText.Contains('933'), IIF(fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcENT], 'ENT', 'SAI'), lstCfoSel.Items.CommaText.Contains('933'));
    end;

    edtNatOpe.ItemIndex := edtNatOpe.Items.IndexOf(qryParCon.FieldByName('CON_NATOPE').AsString);

    if fColunaExisteConCodTri then
    begin
      edtCST.ItemIndex := edtCST.Items.IndexOf(qryParCon.FieldByName('CON_CODTRI').AsString);
    end;

    if blnCON_ORIGEM then
    begin
      edtOrigem.ItemIndex := fgetIndexOrigem(qryParCon.FieldByName('CON_ORIGEM').AsString);
      pMostraPnlPagamentosBan(qryParCon.FieldByName('CON_ORIGEM').AsString) ;
      pMostraPnlFormaPagamentosBan(qryParCon.FieldByName('CON_ORIGEM').AsString);
      pCarregaValorAGR(qryParCon.FieldByName('CON_ORIGEM').AsString);
    end;
    edtPagamentos.ItemIndex := edtPagamentos.Items.IndexOf(qryParCon.FieldByName('CON_PAGAME').AsString);
    edtForPag.ItemIndex := edtForPag.Items.IndexOf(qryParCon.FieldByName('CON_FORPGO').AsString);

    edtValor.ItemIndex := edtValor.Items.IndexOf(qryParCon.FieldByName('CON_DESVAL').AsString);

    if blnCON_BANDEB then
    begin
      chkBandeiraDebito.Checked :=  (qryParCon.FieldByName('CON_BANDEB').AsInteger = 1);
      chkBandeiraCredito.Checked := (qryParCon.FieldByName('CON_BANCRE').AsInteger = 1);
    end;

    if blnCON_ABFDEB then
    begin
      chkAbrevDebito.Checked :=  (qryParCon.FieldByName('CON_ABFDEB').AsInteger = 1);
      chkAbrevCredito.Checked := (qryParCon.FieldByName('CON_ABFCRE').AsInteger = 1);
    end;

    mskContaCredito.Text := qryParCon.FieldByName('CON_CONCRE').AsString;
    mskContaDebito.Text := qryParCon.FieldByName('CON_CONDEB').AsString;

    edtDesContaCredito.Clear;
    edtContaReduzidaCredito.Clear;
    If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) Then
    begin
      edtDesContaCredito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplAco], False);
      edtContaReduzidaCredito.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplAco], False);
    end;

    edtDesContaDebito.Clear;
    edtContaReduzidaDebito.Clear;
    If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) Then
    begin
      edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplAco], False);
      edtContaReduzidaDebito.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplAco], False);
    end;

    chkCliForCre.Checked := (qryParCon.FieldByName('CON_CFCRED').AsInteger = 1);
    chkCliForDeb.Checked := (qryParCon.FieldByName('CON_CFDEBI').AsInteger = 1);

    chkPorCre.Checked := (qryParCon.FieldByName('CON_PORCRE').AsInteger = 1);
    chkPorDeb.Checked := (qryParCon.FieldByName('CON_PORDEB').AsInteger = 1);

	  chkPlaConCre.Checked := (qryParCon.FieldByName('CON_PCCRED').AsInteger = 1);
    chkPlaConDeb.Checked := (qryParCon.FieldByName('CON_PCDEBI').AsInteger = 1);

    if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcPCR], COD_CONTABIL[tcPCP], COD_CONTABIL[tcPDD]]) then
    begin
      if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) In [COD_CONTABIL[tcCTR], COD_CONTABIL[tcPDD], COD_CONTABIL[tcPCP], COD_CONTABIL[tcPCR]]) then
      begin
        chkPlaConCre.Enabled := True;
        chkPlaConDeb.Enabled := True;
      end
      else
      begin
        chkPlaConCre.Enabled := (edtPagamentos.ItemIndex = 0);
        chkPlaConDeb.Enabled := (edtPagamentos.ItemIndex = 0);
      end;
    end;

    edtHisCre.Text := qryParCon.FieldByName('CON_HISCRE').AsString;

    edtDesHisCre.Clear;
    If (Not fEmptyStr(edtHisCre.Text)) Then
      edtDesHisCre.Text := fRetDescHistoricoPadrao(edtHisCre.Text);

    edtCmpDebito.ItemIndex := edtCmpDebito.Items.IndexOf(qryParCon.FieldByName('CON_CMPDEB').AsString);

    If Not fEmptyStr(qryParCon.FieldByName('CON_NATCFO').AsString) Then
    begin
      //edtNatCfo.KeyValue := qryParCon.FieldByName('CON_NATCFO').AsString;
      pSetarNatOpe(qryParCon.FieldByName('CON_NATCFO').AsString)
    end;

    strSeqPar := '';
    if (assigned(qryParCon.FindField('CON_SEQPAR'))) then
      strSeqPar := qryParCon.FieldByName('CON_SEQPAR').AsString;

    strMd5Key := qryParCon.FieldByName('CON_MD5CLA').AsString ;

    pCarregaContasDesmem(strMd5Key, strSeqPar);

    pCarregarDadosDoComplemento(strMd5Key, strSeqPar, qryParCon.FieldByName('CON_CMPDEB').AsString);

    If ((qryParCon.FieldByName('CON_TIPLAN').AsString = 'CTP') Or (qryParCon.FieldByName('CON_TIPLAN').AsString = 'CTR')
         Or (qryParCon.FieldByName('CON_TIPLAN').AsString = 'CRC')) And
        (fEmptyStr(qryParCon.FieldByName('CON_CONCRE').AsString)) And
        (qryParCon.FieldByName('CON_CFCRED').AsInteger = 0) And
        (qryParCon.FieldByName('CON_PORCRE').AsInteger = 0) And
        (qryParCon.FieldByName('CON_PCCRED').AsInteger = 1) Then
    Begin
      rdbCreBai.Checked := (qryParCon.FieldByName('CON_TIPPCC').AsString = 'B');
      rdbCreCad.Checked := (qryParCon.FieldByName('CON_TIPPCC').AsString = 'C');
      rdbCreBai.Enabled := True;
      rdbCreCad.Enabled := True;
    End
    Else
    Begin
      rdbCreBai.Checked := False;
      rdbCreCad.Checked := False;
      rdbCreBai.Enabled := False;
      rdbCreCad.Enabled := False;
    End;

    If ((qryParCon.FieldByName('CON_TIPLAN').AsString = 'CTP') Or (qryParCon.FieldByName('CON_TIPLAN').AsString = 'CTR')
         Or (qryParCon.FieldByName('CON_TIPLAN').AsString = 'CRC')) And
        (fEmptyStr(qryParCon.FieldByName('CON_CONDEB').AsString)) And
        (qryParCon.FieldByName('CON_CFDEBI').AsInteger = 0) And
        (qryParCon.FieldByName('CON_PORDEB').AsInteger = 0) And
        (qryParCon.FieldByName('CON_PCDEBI').AsInteger = 1) Then
    Begin
      rdbDebBai.Checked := (qryParCon.FieldByName('CON_TIPPCD').AsString = CONTA_DA_BAIXA);
      rdbDebCad.Checked := (qryParCon.FieldByName('CON_TIPPCD').AsString = CONTA_DO_CADASTRO);
      rdbDebBai.Enabled := True;
      rdbDebCad.Enabled := True;
    End
    else if (qryParCon.FieldByName('CON_TIPLAN').AsString = 'GNR') then
    begin
      rdbDebBai.Enabled := False;
      rdbDebCad.Enabled := False;
      rdbCreBai.Enabled := False;
      rdbCreCad.Enabled := False;
      rdbDebBai.Checked := False;
      rdbCreBai.Checked := False;
      rdbDebCad.Checked := True;
      rdbCreCad.Checked := True;
    end
    Else
    Begin
      rdbDebBai.Checked := False;
      rdbDebCad.Checked := False;
      rdbDebBai.Enabled := False;
      rdbDebCad.Enabled := False;
    End;

    if not qryParcon.FieldByName('CON_VIGINI').IsNull then
      mskVigIni.Text :=  FormatDateTime('DD/MM/YYYY', qryParcon.FieldByName('CON_VIGINI').AsDateTime);

    if not qryParcon.FieldByName('CON_VIGFIN').IsNull then
      mskVigFin.Text :=  FormatDateTime('DD/MM/YYYY', qryParcon.FieldByName('CON_VIGFIN').AsDateTime);

    if blnCON_PAGANT then
    begin
      if fEmptyStr(qryParCon.FieldByName('CON_PAGANT').AsString) then
        edtAdiantamento.ItemIndex := 0
      else
        edtAdiantamento.ItemIndex := edtAdiantamento.Items.IndexOf(qryParCon.FieldByName('CON_PAGANT').AsString);
    end;

    if blnCON_TITPDD then
    begin
      if fEmptyStr(qryParCon.FieldByName('CON_TITPDD').AsString) then
        rgTitPDD.ItemIndex := 0
      else
        if qryParCon.FieldByName('CON_TITPDD').AsString = 'S' then
          rgTitPDD.ItemIndex := iif(fCfgLigPdd = 'S', 1, 0)
        else
          rgTitPDD.ItemIndex := 0;
    end;
    pHabilitarCST(lstCfoSel.Items);
    //PanelGroup.ExpandAll;
  End;

  pAjustaCampoForPgo;

  blnAltera := True;
end;

procedure TfrmParametrosContabilizacao.pDeletarParametro(strSeqPar: String);
  var
    qryDados : TUniQuery;
begin
  qryDados := fCriaQueryContabilidade('PARCON', Self.Name, Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    { SELECT + Delete em vez de DELETE por ExecSQL: os hooks de auditoria sao eventos de
      dataset e ExecSQL nao os dispara, entao a exclusao do PARCON nao gerava LOGAJC --
      enquanto PARNCO e CMPPAR, que ja usavam este formato, geravam. Mesmo padrao de
      pDeletarContasDesmem e pDeletarDadosDoComplemento. }
    qryDados.SQL.Add(' SELECT * ');
    qryDados.SQL.Add('   FROM PARCON ');
    qryDados.SQL.Add('  WHERE CON_SEQPAR = :SEQPAR ');
    pSetarFiltroEmpresa(qryDados) ;
    qryDados.ParamByName('SEQPAR').AsString := strSeqPar;
    qryDados.Open;

    qryDados.First;
    while not qryDados.Eof do
      qryDados.Delete;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pDeletarDadosDoComplemento(const strSeqPar: string);
  var
    qryDados : TUniQuery;
begin
  if not blnUsaCheckListComplemento then
    exit;

  qryDados := fCriaQueryContabilidade('CMPPAR', Self.Name, Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT * FROM CMPPAR WHERE');
    qryDados.SQL.Add(' PAR_SEQPAR = :SEQPAR ');
    qryDados.ParamByName('SEQPAR').AsString := strSeqPar;
    qryDados.Open;

    qryDados.First;
    while not qryDados.Eof do
      qryDados.Delete;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pDeletarContasDesmem(const strSeqPar: String);
  var
    qryDados : TUniQuery;
    fldSeq: TField;
begin
  qryDados := fCriaQueryContabilidade('PARNCO', Self.Name, Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT * FROM PARNCO WHERE ' + fParNcoWhereSql(strSeqPar));
    qryDados.Open;

    fldSeq := qryDados.FindField('CON_SEQPAR');
    if Assigned(fldSeq) then
      fldSeq.ProviderFlags := fldSeq.ProviderFlags + [pfInKey];

    qryDados.First;
    while not qryDados.Eof do
      qryDados.Delete;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pStatusLinhaCredito(blnHabilitado: Boolean);
begin
  mskContaCredito.Clear;

  edtDesContaCredito.Clear;
  edtContaReduzidaCredito.Clear;
  edtDesContaCredito.Enabled := blnHabilitado;

  chkCliForCre.Checked := blnHabilitado;
  chkPorCre.Checked := blnHabilitado;
  chkPlaConCre.Checked := blnHabilitado;
  chkBandeiraCredito.Checked := blnHabilitado;
  chkAbrevCredito.Checked := blnHabilitado;

  pAjustaDataDeLancamentoCredito;
end;

procedure TfrmParametrosContabilizacao.pStatusLinhaDebito(blnHabilitado: Boolean);
begin
  mskContaDebito.Clear;

  edtDesContaDebito.Clear;
  edtContaReduzidaDebito.Clear;
  edtDesContaDebito.Enabled := blnHabilitado;

  chkCliForDeb.Checked := blnHabilitado;
  chkPorDeb.Checked := blnHabilitado;
  chkPlaConDeb.Checked := blnHabilitado;
  chkBandeiraDebito.Checked := blnHabilitado;
  chkAbrevDebito.Checked := blnHabilitado;

  pAjustaDataDeLancamentoDebito;
end;

procedure TfrmParametrosContabilizacao.rdbAtivosClick(Sender: TObject);
begin
  inherited;
  pFiltrar(rdbAtivos);
end;

procedure TfrmParametrosContabilizacao.rdbInativosClick(Sender: TObject);
begin
  inherited;
  pFiltrar(rdbInativos);
end;

procedure TfrmParametrosContabilizacao.rdbTodosClick(Sender: TObject);
begin
  inherited;
  pFiltrar(rdbTodos);
end;

procedure TfrmParametrosContabilizacao.pGravarComplementos(strMd5Key, strSeqPar: string);
  var
    qryDados : TUniQuery;
    intCnt : Integer;
begin
  if not blnUsaCheckListComplemento then
    exit;

  qryDados := fCriaQueryContabilidade('CMPPAR', Self.Name, Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT * FROM CMPPAR WHERE FALSE');
    qryDados.Open;

    for intCnt := 0 to cklComplemento.Count-1 do
    begin
      if cklComplemento.Checked[intCnt] then
      begin
        qryDados.Insert;
        qryDados.FieldByName('PAR_MD5KEY').AsString := strMd5Key;
        if fEmptyStr(strSeqPar) then
          qryDados.FieldByName('PAR_SEQPAR').Value := Null
        else
          qryDados.FieldByName('PAR_SEQPAR').AsString := strSeqPar;
        qryDados.FieldByName('PAR_COMPLE').AsString := cklComplemento.Items[intCnt];
        qryDados.Post;
      end;
    end;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pGravarContasDesmem(strMd5Key, strSeqPar: String);
  var
    qryDados : TUniQuery;
begin

  if fPlanoContabilConfiguradoOutrosModulosDebito then
    cdsConDeb.EmptyDataSet ;

  if fPlanoContabilConfiguradoOutrosModulosCredito then
    cdsConCre.EmptyDataSet ;

  qryDados := fCriaQueryContabilidade('PARNCO', Self.Name, Self);
  try
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT * FROM PARNCO WHERE FALSE');
    qryDados.Open;

    cdsConDeb.First;
    While Not cdsConDeb.Eof Do
    Begin
      qryDados.Insert;
      If (qryDados.FindField('CON_SEQPAR') <> Nil) Then
        qryDados.FieldByName('CON_SEQPAR').AsString := strSeqPar;
      qryDados.FieldByName('NCO_CODEMP').AsString := cdsConDeb.FieldByName('CODEMP').AsString;
      qryDados.FieldByName('NCO_CODCON').AsString := cdsConDeb.FieldByName('CODCON').AsString;
      qryDados.FieldByName('NCO_MD5KEY').AsString := strMd5Key;
      qryDados.FieldByName('NCO_CREDEB').AsString := 'D';
      qryDados.Post;

      cdsConDeb.Next;
    End;

    cdsConCre.First;
    While Not cdsConCre.Eof Do
    Begin
      qryDados.Insert;
      If (qryDados.FindField('CON_SEQPAR') <> Nil) Then
        qryDados.FieldByName('CON_SEQPAR').AsString := strSeqPar;
      qryDados.FieldByName('NCO_CODEMP').AsString := cdsConCre.FieldByName('CODEMP').AsString;
      qryDados.FieldByName('NCO_CODCON').AsString := cdsConCre.FieldByName('CODCON').AsString;
      qryDados.FieldByName('NCO_MD5KEY').AsString := strMd5Key;
      qryDados.FieldByName('NCO_CREDEB').AsString := 'C';
      qryDados.Post;

      cdsConCre.Next;
    End;

    qryDados.Close;
  finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmParametrosContabilizacao.pHabilitarCST(const ACfop: TStrings);
var
  LGrupo: TList<string> ;
  intCnt: integer ;
  strParte: string ;
begin
  edtCST.Enabled := False ;
  LGrupo := TList<string>.Create ;
  try
    for intCnt := 0 to ACfop.Count-1  do
    begin
      strParte := RightStr(ACfop.Strings[intCnt], 3) ;
      if LGrupo.IndexOf(strParte) = -1 then
      begin
        LGrupo.Add(strParte) ;
      end;
    end;

    if LGrupo.Count <> 1 then
    begin
      edtCST.ItemIndex := -1 ;
      exit ;
    end;
  finally
    FreeAndNil(LGrupo) ;
  end;
  edtCST.Enabled := True ;
end;

procedure TfrmParametrosContabilizacao.pLimpaGrupoProdSel(
  var AcdsDados: TUniClientDataSet);
begin
  AcdsDados.DisableControls ;
  try
    AcdsDados.First ;
    while not AcdsDados.Eof do
    begin
      AcdsDados.Edit ;
      AcdsDados.FieldByName('SELECI').AsBoolean := False ;
      AcdsDados.Post ;
      AcdsDados.Next ;
    end;
    AcdsDados.First ;
  finally
    AcdsDados.EnableControls ;
  end ;
end;

procedure TfrmParametrosContabilizacao.pLimpaMarketPlaceSel(
  var AlstItens: TcxCheckListBox);
var
  LintItem: integer ;
begin
  for LintItem:= 0 to AlstItens.Items.Count-1 do
  begin
    AlstItens.Items.Items[LintItem].Checked := False ;
  end;
end;

procedure TfrmParametrosContabilizacao.pLimpaOrigemCPCSel(
  var AlstItens: TcxCheckListBox);
var
  LintItem: integer ;
begin
  if not blnRotinaCPC then
    Exit;

  for LintItem:= 0 to AlstItens.Items.Count-1 do
  begin
    AlstItens.Items.Items[LintItem].Checked := False ;
  end;
end;

procedure TfrmParametrosContabilizacao.pLimparGrupoLancamentos;
begin
  mskContaCredito.Clear;
  edtDesContaCredito.Clear;
  edtContaReduzidaCredito.Clear;
  chkCliForCre.Checked := False;
  chkPorCre.Checked := False;

  chkBandeiraDebito.Checked := False;
  chkBandeiraCredito.Checked := False;

  chkAbrevDebito.Checked := False;
  chkAbrevCredito.Checked := False;

  chkPlaConCre.Checked := False;
  chkPlaConDeb.Checked := False;

  pAjustaDataDeLancamentoDebito;
  pAjustaDataDeLancamentoCredito;

  edtHisCre.Clear;
  edtDesHisCre.Clear;

  mskContaDebito.Clear;
  edtDesContaDebito.Clear;
  edtContaReduzidaDebito.Clear;
  chkCliForDeb.Checked := False;
  chkPorDeb.Checked := False;

  edtCmpDebito.ItemIndex := -1;
  cklComplemento.Items.Clear;
end;

procedure TfrmParametrosContabilizacao.pLimparTela;
begin
  pnlForPag.Visible := False;
  pnlCfop.Visible := False;
  pnlNatOpe.Visible := False;
  pnlValor.Visible := False;
  pnlPagamentos.Visible := False;
  pnlOrigem.Visible := False;
  pnlAdiantamento.Visible := False;
  pnlTitPdd.Visible := False;
  pnlMarketPlace.Visible := False;
  pnlOrigemCPC.Visible := False;
  pnlGrupoProd.Visible := False;
  pLimpaMarketPlaceSel(lstMarketPlace) ;
  pLimpaOrigemCPCSel (lstOrigemCPC) ;
  pLimpaGrupoProdSel(cdsGrupoProd) ;

  edtTipLan.ItemIndex := -1;
  strTipLanOriginal := '';
  edtForPag.ItemIndex := -1;
  edtNatOpe.ItemIndex := -1;
  edtValor.ItemIndex := -1;
  edtPagamentos.ItemIndex := -1;
  edtOrigem.ItemIndex := -1;
  edtAdiantamento.ItemIndex := -1;
  rgTitPDD.ItemIndex := -1;
  edtCST.ItemIndex := -1 ;

  pAjustaCampoForPgo;

  mskVigIni.Text := '  /  /    ';
  mskVigFin.Text := '  /  /    ';

  //edtNatCfo.KeyValue := Null;
  pSetarNatOpe('');

  pLimparGrupoLancamentos;

  lstCfoTod.Clear;
  lstCfoSel.Clear;

  cdsConDeb.EmptyDataSet;
  cdsConCre.EmptyDataSet;

  pAjustaDesmem(btnPlaNcoDeb, cdsConDeb);
  pAjustaDesmem(btnPlaNcoCre, cdsConCre);
end;

procedure TfrmParametrosContabilizacao.pLimpaTodosPagamentoBan;
begin
  if edtPagamentos.Items.IndexOf('Todos') >= 0 then
  begin
    edtPagamentos.Items.Delete(0);
  end;
end;

procedure TfrmParametrosContabilizacao.pLogDelParcon;
var
  LqryLog: TUniQuery ;
begin
  LqryLog := fCriaQuery() ;
  try
    LqryLog.Close;
    LqryLog.SQL.Clear ;
    LqryLog.SQL.Add('SELECT * FROM PARCON WHERE ') ;
    If fSeqParValido Then
    Begin
      LqryLog.SQL.Add(' CON_SEQPAR = :SEQPAR ') ;
      LqryLog.ParamByName('SEQPAR').AsString := qryParCon.FieldByName('CON_SEQPAR').AsString ;
    end
    else
    begin
      pAjustaWhereParcon(LqryLog) ;
    end ;
    LqryLog.Open ;
    fVerificaIntegridade(Self.Name, 'PARCON', LqryLog);
  finally
    FreeAndNil(LqryLog) ;
  end ;
end;

procedure TfrmParametrosContabilizacao.pLogDelParNco;
var
  LqryLog: TUniQuery ;
  LstrMd5Key: String ;
begin
  LqryLog := fCriaQuery() ;
  try
    LqryLog.Close;
    LqryLog.SQL.Clear ;
    LqryLog.SQL.Add('SELECT * FROM PARNCO WHERE ') ;
    If fSeqParValido Then
    Begin
      LqryLog.SQL.Add(' CON_SEQPAR = :SEQPAR ') ;
      LqryLog.ParamByName('SEQPAR').AsString := qryParCon.FieldByName('CON_SEQPAR').AsString ;
    end
    else
    begin
      LstrMd5Key := qryParCon.FieldByName('CON_MD5CLA').AsString;
      LqryLog.SQL.Add(' NCO_MD5KEY = :MD5KEY ') ;
      LqryLog.ParamByName('MD5KEY').AsString := LstrMd5Key ;
    end ;
    LqryLog.Open ;
    LqryLog.First ;
    while not LqryLog.Eof do
    begin
      fVerificaIntegridade(Self.Name, 'PARNCO', LqryLog);
      LqryLog.Next ;
    end ;
  finally
    FreeAndNil(LqryLog) ;
  end ;
end;

procedure TfrmParametrosContabilizacao.pAjustaWhereParcon(var AqryParcon: TUniQuery) ;
var
  LstrPagant: String ;
  LstrOrigem: String ;
begin
  LstrPagant := '';
  if Assigned(qryParCon.FindField('CON_PAGANT')) then
    LstrPagant := qryParCon.FieldByName('CON_PAGANT').AsString;

  AqryParcon.SQL.Add('    CON_TIPLAN = :TIPLAN ');
  AqryParcon.SQL.Add('    AND CON_FORPGO = :FORPGO ');
  AqryParcon.SQL.Add('    AND CON_NATOPE = :NATOPE ');
  AqryParcon.SQL.Add('    AND CON_DESVAL = :DESVAL ');
  AqryParcon.SQL.Add('    AND CON_MD5CLA = :MD5CLA ');
  AqryParcon.SQL.Add('    AND IFNULL(CON_PAGAME,"") = :PAGAME ');
  if (blnCON_ORIGEM) then
    AqryParcon.SQL.Add('    AND IFNULL(CON_ORIGEM,"") = :ORIGEM ');
  pSetarFiltroEmpresa(AqryParcon) ;
  AqryParcon.ParamByName('TIPLAN').AsString := qryParCon.FieldByName('CON_TIPLAN').AsString;
  AqryParcon.ParamByName('FORPGO').AsString := qryParCon.FieldByName('CON_FORPGO').AsString;
  AqryParcon.ParamByName('NATOPE').AsString := qryParCon.FieldByName('CON_NATOPE').AsString;
  AqryParcon.ParamByName('DESVAL').AsString := qryParCon.FieldByName('CON_DESVAL').AsString;

  If (Not VarIsNull(edtNatCfo.KeyValue)) Then
  begin
    AqryParcon.SQL.Add('    AND CON_NATCFO = :NATCFO ');
    AqryParcon.ParamByName('NATCFO').AsString := edtNatCfo.KeyValue;
  end
  else
    AqryParcon.SQL.Add('    AND CON_NATCFO IS NULL ');

  AqryParcon.ParamByName('PAGAME').AsString := qryParCon.FieldByName('CON_PAGAME').AsString;

  LstrOrigem := '' ;
  if (blnCON_ORIGEM) then
  begin
    LstrOrigem := qryParCon.FieldByName('CON_ORIGEM').AsString ;
    AqryParcon.ParamByName('ORIGEM').AsString := LstrOrigem ;
  end ;

  AqryParcon.ParamByName('MD5CLA').AsString := fMD5Chave(qryParCon.FieldByName('CON_CLAFIS').AsString, qryParCon.FieldByName('CON_PAGAME').AsString, LstrOrigem, LstrPagant);
end ;

function TfrmParametrosContabilizacao.fSelecionouFiltroAtual(
  Sender: TWinControl): Boolean;
begin
  Result := False;

  if Sender is TRadioButton then
  begin
    if (Sender as TRadioButton) = FFiltroAtual.ARadio then
      Result := True;

    Exit;
  end;

  if Sender is TMaskEditFocus then
  begin
    if (Sender as TMaskEditFocus).Text = FFiltroAtual.AStrData then
      Result := True;

    Exit;
  end;
end;

function TfrmParametrosContabilizacao.fSeqParValido:boolean ;
begin
  result := False ;
  if not  fCampoExiste('PARCON', 'CON_SEQPAR') then
    exit ;

  if fEmptyStr(qryParCon.FieldByName('CON_SEQPAR').AsString) then
    exit ;

  result := True ;
end ;

procedure TfrmParametrosContabilizacao.pMensagemISSRetido(const AValor: string);
begin
  if LeftStr(edtTipLan.Text, 3) = 'ENT' then
  begin
    if AValor = DES_VALOR_ISS then
    begin
      pnlInfo.Caption := DES_VALOR_ISS+' corresponde ao valor retido do ISS!';
    end
    else
    begin
      pnlInfo.Caption := '' ;
    end;
  end;
end;

procedure TfrmParametrosContabilizacao.pMostraPnlFormaPagamentosBan(
  const AOrigem: String);
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcBAN] then
  begin
    exit ;
  end;

  if not blnCON_ORIGEM then
  begin
    exit ;
  end;

  pCarregaFormaPagamentosPadrao ;
  if (pos('TRF', AOrigem) > 0) then
  begin
    pnlForPag.Visible := True ;
  end
  else
  begin
    edtForPag.ItemIndex := -1 ;
    pnlForPag.Visible := False ;
  end;
end;

procedure TfrmParametrosContabilizacao.pCarregaValorAGR(
  const AOrigem: String);
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcAGR] then
  begin
    exit ;
  end;

  if not blnCON_ORIGEM then
  begin
    exit ;
  end;

  edtValor.Items.Clear ;
  edtValor.Items.Add(DES_VALOR_ORIGINAL) ;
  if (copy(AOrigem,1,3) = copy(ORI_AG_TITULOS,1,3)) or (copy(AOrigem,1,3) = copy(ORI_AG_DEVOLUCAO_CREDITO,1,3)) then
  begin
    edtValor.Items.Add(DES_VALOR_JUROS) ;
    edtValor.Items.Add(DES_VALOR_DESCONTO) ;
  end;
end;

procedure TfrmParametrosContabilizacao.pConfiguraPICORFCampoValor(
  var AComboBoxValor: TComboBoxFocus);
begin
  if fCfgPiCoRf then
  begin
    AComboBoxValor.Items.Add(DES_VALOR_PIS_RF);
    AComboBoxValor.Items.Add(DES_VALOR_COF_RF);
  end;
end;

procedure TfrmParametrosContabilizacao.pConfiguraVendorCampoValorCTP(
  var AComboBoxValor: TComboBoxFocus);
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcCTP] then
    Exit ;

  if fCfgCtpVnd <> 'S' then
    Exit ;

  edtValor.Items.Add(DES_VALOR_VENDOR);

end;

procedure TfrmParametrosContabilizacao.pMostraPnlPagamentosBan(const AOrigem: String);
begin
  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcTCC] then
  begin
    pLimpaTodosPagamentoBan ;
  end ;

  if fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) <> COD_CONTABIL[tcBAN] then
  begin
    exit ;
  end;

  if not blnCON_ORIGEM then
  begin
    exit ;
  end;

  if (pos('CTR', AOrigem) > 0) or (pos('CTP', AOrigem) > 0) then
  begin
    edtPagamentos.Items.Insert(0, 'Todos');
    pnlPagamentos.Visible := True ;
  end
  else
  begin
    edtPagamentos.ItemIndex := -1 ;
    pnlPagamentos.Visible := False ;
  end;
end;

procedure TfrmParametrosContabilizacao.pMostrarCST(const ATipoContabil: TTiposContabeis);
begin
  pnlCst.Visible := False ;
  if fCfgCSaCst = 'N' then
  begin
    exit ;
  end;

  if ATipoContabil <> tcSAI then
  begin
    exit ;
  end;
  pnlCst.Visible := True ;
end;

procedure TfrmParametrosContabilizacao.pCarregarTipoImobilizaveis(Items: TStrings);
  var
    qryTipImo : TUniQuery;
begin
  if not blnRotinaImobilizado then
    exit;

  qryTipImo := fCriaQuery(Self);
  try
    qryTipImo.SQL.Add(' SELECT CONCAT(TIP_CODTIP, "-", TIP_DESCRI) AS DESCRI ');
    qryTipImo.SQL.Add('   FROM TIPIMO ');
    qryTipImo.SQL.Add('  ORDER BY TIP_CODTIP ');
    qryTipImo.Open;
    qryTipImo.First;
    while not qryTipImo.Eof do
    begin
      Items.Add(qryTipImo.FieldByName('DESCRI').AsString);
      qryTipImo.Next;
    end;
    qryTipImo.Close;
  finally
    FreeAndNil(qryTipImo);
  end;
end;

procedure TfrmParametrosContabilizacao.pParamGrupoProd(var AqryParam: TUniQuery;
  const AfldParcon: TFields; const AcdsDados: TUniClientDataSet;
  const Apnl: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODGRU')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelGrupoProd(AfldParcon, AcdsDados, Apnl) ;

  AqryParam.SQL.Add('  AND IFNULL(CON_CODGRU,"") = :CODGRU ') ;
  AqryParam.ParamByName('CODGRU').AsString := LstrCodigo ;
end;

procedure TfrmParametrosContabilizacao.pParamLocateGrupoProd(
  var AqryParam: TUniQuery; const AfldParcon: TFields;
  const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel);
var
  LstrWhere: string ;
  LintControle: integer ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODGRU')) then
  begin
    exit ;
  end;

  if not Apnl.Visible then
  begin
    exit ;
  end;

  AcdsDados.DisableControls ;
  try
    LintControle := 0 ;
    LstrWhere := '  AND (';
    AcdsDados.First ;
    while not AcdsDados.Eof do
    begin
      if AcdsDados.FieldByName('SELECI').AsBoolean then
      begin
        Inc(LintControle) ;
        if (LintControle > 1) then
        begin
          LstrWhere := LstrWhere + ' OR '
        end;
        LstrWhere := LstrWhere + '(LOCATE("' +
                          AcdsDados.FieldByName('CODGRU').AsString +
                          '", CON_CODGRU) > 0)';
      end;
      AcdsDados.Next ;
    end;
  finally
    AcdsDados.EnableControls ;
  end ;

  if LintControle <> 0 then
  begin
    AqryParam.SQL.Add(LstrWhere + ') ');
  end
  else
  begin
    AqryParam.SQL.Add(' AND TRIM(COALESCE(CON_CODGRU,"")) = "" ')
  end ;

end;

procedure TfrmParametrosContabilizacao.pParamLocateMarketPlace(
  var AqryParam: TUniQuery; const AfldParcon: TFields;
  const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
var
  LstrWhere: string ;
  LintCount: integer ;
  LintControle: integer ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODORI')) then
  begin
    exit ;
  end;

  if not ApnlMarket.Visible then
  begin
    exit ;
  end;

  LintControle := 0 ;
  LstrWhere := '  AND (';
  for LintCount := 0 to AlstItens.Items.Count - 1 do
  begin
    if AlstItens.Items.Items[LintCount].Checked then
    begin
      Inc(LintControle) ;
      if (LintControle > 1) then
      begin
        LstrWhere := LstrWhere + ' OR '
      end;
      LstrWhere := LstrWhere + '(LOCATE("' +
                        fStrZero(AlstItens.Items.Items[LintCount].Tag,3) +
                        '", CON_CODORI) > 0)';
    end;
  end;

  if LintControle <> 0 then
  begin
    AqryParam.SQL.Add(LstrWhere + ') ');
  end
  else
  begin
    AqryParam.SQL.Add(' AND TRIM(COALESCE(CON_CODORI,"")) = "" ')
  end

end;

procedure TfrmParametrosContabilizacao.pParamLocateOrigemCPC(
  var AqryParam: TUniQuery; const AfldParcon: TFields;
  const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel);
var
  LstrWhere: string ;
  LintCount: integer ;
  LintControle: integer ;
begin
  if not Assigned(AfldParcon.FindField('CON_ORICPC')) then
  begin
    exit ;
  end;

  if not ApnlOri.Visible then
  begin
    exit ;
  end;

  LintControle := 0 ;
  LstrWhere := '  AND (';
  for LintCount := 0 to AlstItens.Items.Count - 1 do
  begin
    if AlstItens.Items.Items[LintCount].Checked then
    begin
      Inc(LintControle) ;
      if (LintControle > 1) then
      begin
        LstrWhere := LstrWhere + ' OR '
      end;
      LstrWhere := LstrWhere + '(LOCATE("' +
                        fStrZero(AlstItens.Items.Items[LintCount].Tag,2) +
                        '", CON_ORICPC) > 0)';
    end;
  end;

  if LintControle <> 0 then
  begin
    AqryParam.SQL.Add(LstrWhere + ') ');
  end
  else
  begin
    AqryParam.SQL.Add(' AND TRIM(COALESCE(CON_ORICPC,"")) = "" ')
  end

end;


procedure TfrmParametrosContabilizacao.pParamMarketPlace(
  var AqryParam: TUniQuery; const AfldParcon: TFields;
  const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODORI')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelMarketPlace(AfldParcon, AlstItens, ApnlMarket) ;

  AqryParam.SQL.Add('  AND IFNULL(CON_CODORI,"") = :CODORI ') ;
  AqryParam.ParamByName('CODORI').AsString := LstrCodigo ;

end;

procedure TfrmParametrosContabilizacao.pParamOrigemCPC(var AqryParam: TUniQuery;
  const AfldParcon: TFields; const AlstItens: TcxCheckListBox;
  const ApnlOri: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_ORICPC')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelOrigemCPC(AfldParcon, AlstItens, ApnlOri) ;

  AqryParam.SQL.Add('  AND IFNULL(CON_ORICPC,"") = :ORICPC ') ;
  AqryParam.ParamByName('ORICPC').AsString := LstrCodigo ;

end;

procedure TfrmParametrosContabilizacao.pPopularComboBoxOrigem(const ATipoContabil: TTiposContabeis);
begin
  edtOrigem.Items.Clear;
  if (ATipoContabil = tcBAN) then
  begin
    edtOrigem.Items.Add('MOVIMENTAÇÃO CONTA BANCO');
    edtOrigem.Items.Add('CTR - CONTAS A RECEBER');
    edtOrigem.Items.Add('CTP - CONTAS A PAGAR');
    edtOrigem.Items.Add('CHQ - CHEQUE');
    edtOrigem.Items.Add('TRF - RESUMO DE CAIXA');
    edtOrigem.Items.Add('MCA - CARTÃO');
    edtOrigem.Items.Add('ECR - ESTORNO CARTÃO');
    edtOrigem.Items.Add('ERC - ESTORNO CONTAS A RECEBER');
    edtOrigem.Items.Add('EPG - ESTORNO CONTAS A PAGAR');
  end
  else if (ATipoContabil = tcIMO) then
  begin
    pCarregarTipoImobilizaveis(edtOrigem.Items);
  end
  else if (ATipoContabil in [tcAGR, tcAGP] ) then
  begin
    edtOrigem.Items.Add(ORI_AG_TITULOS);
    edtOrigem.Items.Add(ORI_AG_AGRUPAMENTO);
    edtOrigem.Items.Add(ORI_AG_DEVOLUCAO_CREDITO);
    edtOrigem.Items.Add(ORI_AG_CREDITO_AGRUPAMENTO);
  end
  else if (ATipoContabil = tcAJI) then
  begin
    edtOrigem.Items.Add('000-OUTROS DÉBITOS');
    edtOrigem.Items.Add('001-ESTORNO DE CRÉDITOS');
    edtOrigem.Items.Add('002-OUTROS CRÉDITOS');
    edtOrigem.Items.Add('003-ESTORNO DE DÉBITOS');
    edtOrigem.Items.Add('004-DEDUÇÕES DO IMPOSTO APURADO');
    edtOrigem.Items.Add('005-DÉBITOS ESPECIAIS');
  end;
end;

procedure TfrmParametrosContabilizacao.pReverteParaFiltroAtual(Sender: TWinControl);
begin
  if Sender is TRadioButton then
    FFiltroAtual.ARadio.Checked := True;

  if Sender is TMaskEditFocus then
    (Sender as TMaskEditFocus).Text := FFiltroAtual.AStrData;
end;

procedure TfrmParametrosContabilizacao.pSalvaEmpresaLogada(AfldParcon: TFields);
begin
  if fCfgConEmp = 'S' then
  begin
    AfldParcon.FieldByName('CON_CODEMP').AsString := VS_strCodEmp ;
  end
  else
  begin
    AfldParcon.FieldByName('CON_CODEMP').Value := Null ;
  end ;
end;

procedure TfrmParametrosContabilizacao.pSalvaGrupoProd(AfldParcon: TFields;
  const AcdsDados: TUniClientDataSet; const Apnl: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODGRU')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelGrupoProd(AfldParcon, AcdsDados, Apnl) ;
  AfldParcon.FieldByName('CON_CODGRU').AsString := LstrCodigo ;
end;

procedure TfrmParametrosContabilizacao.pSalvaMarketPlace(
  AfldParcon: TFields; const AlstItens: TcxCheckListBox; const ApnlMarket: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODORI')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelMarketPlace(AfldParcon, AlstItens, ApnlMarket) ;
  AfldParcon.FieldByName('CON_CODORI').AsString := LstrCodigo ;
end;

procedure TfrmParametrosContabilizacao.pSalvaOrigemCPC(AfldParcon: TFields;
  const AlstItens: TcxCheckListBox; const ApnlOri: TCategoryPanel);
var
  LstrCodigo: string ;
begin
  if not blnRotinaCPC then
    Exit;

  if not Assigned(AfldParcon.FindField('CON_ORICPC')) then
  begin
    exit ;
  end;

  LstrCodigo := fCodigoSelOrigemCPC(AfldParcon, AlstItens, ApnlOri) ;
  AfldParcon.FieldByName('CON_ORICPC').AsString := LstrCodigo ;
end;

procedure TfrmParametrosContabilizacao.pAjustaDesmem(btn: TBitBtnLocked;
  cds: TUniClientDataSet);
var
  LintCount: Integer ;
begin
  LintCount := cds.RecordCount ;
  if btn.Name = btnPlaNcoDeb.Name then
  begin
    if fPlanoContabilConfiguradoOutrosModulosDebito then
    begin
      LintCount := 0 ;

      mskContaDebito.Enabled := False;
      edtContaReduzidaDebito.Enabled := False;
      btnPlaNcoDeb.Enabled := False;
    end
    else
    begin
      mskContaDebito.Enabled := True;
      if not FblnDesligaContaReduzidaNaPesquisa then
        edtContaReduzidaDebito.Enabled := True;
      btnPlaNcoDeb.Enabled := True;
    end ;

    if LintCount <> 0 then
    begin
      mskContaDebito.Enabled := False;
      edtContaReduzidaDebito.Enabled := False;
    end ;

  end
  else if btn.Name = btnPlaNcoCre.Name then
  begin
    if fPlanoContabilConfiguradoOutrosModulosCredito then
    begin
      LintCount := 0 ;

      mskContaCredito.Enabled    := False;
      edtContaReduzidaCredito.Enabled := False;
      btnPlaNcoCre.Enabled := False;
    end
    else
    begin
      mskContaCredito.Enabled    := True;
      if not FblnDesligaContaReduzidaNaPesquisa then
        edtContaReduzidaCredito.Enabled := True;
      btnPlaNcoCre.Enabled := True;
    end ;

    if LintCount <> 0 then
    begin
      mskContaCredito.Enabled := False;
      edtContaReduzidaCredito.Enabled := False;
    end ;

  end ;

  btn.Caption := '(' + IntToStr(LintCount) + ')';
end;

procedure TfrmParametrosContabilizacao.pSetaInformacaoFormaCreditoCtp;
begin
  pnlInfo.Caption := '';
  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTP]) and (edtForPag.ItemIndex = edtForPag.Items.IndexOf('Todas')) then
    pnlInfo.Caption := '** Forma de pagamento "Todas" não contempla a forma: "' + FPG_CREDITO + '"';
end;

procedure TfrmParametrosContabilizacao.pSetaItensAGR(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Add(DES_VALOR_ORIGINAL);
end;

procedure TfrmParametrosContabilizacao.pSetaItensANT(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Clear;
  cmbItens.Items.Add(DES_VALOR_PAGO);
  cmbItens.ItemIndex := 0;
end;

procedure TfrmParametrosContabilizacao.pSetaItensCPC(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Clear;

  cmbItens.Items.Add(DES_VALOR_PIS);
  cmbItens.Items.Add(DES_VALOR_COFINS);
end;

procedure TfrmParametrosContabilizacao.pSetaItensCTP_PCP(
  var cmbItens: TComboBoxFocus);
begin
  if (edtTipLan.ItemIndex = 0) then
    edtValor.Items.Add('Vr.Pago');
  edtValor.Items.Add('Vr.Juros');
  edtValor.Items.Add('Vr.Descontos');
  edtValor.Items.Add('Vr.Original');
  if fTemCampoMultaCTP then
    edtValor.Items.Add(DES_VALOR_MULTA);
  pConfiguraVendorCampoValorCTP(edtValor) ;
  pConfiguraPICORFCampoValor(edtValor) ;
end;

procedure TfrmParametrosContabilizacao.pSetaItensCTR_PCR(var cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Clear;

  if (fAjustaIndexDescricaoContabil(edtTipLan.ItemIndex, edtTipLan.Items) = COD_CONTABIL[tcCTR]) then
  begin
    cmbItens.Items.Add('Vr.Recebido');
    if fContabilizarDespesasCobrancaCTR then
      cmbItens.Items.Add(DES_VALOR_DESPESAS_COBRANCA);
  end;

  cmbItens.Items.Add('Vr.Juros');
  cmbItens.Items.Add('Vr.Descontos');

  cmbItens.Items.Add('Vr.Original');

  pConfiguraPICORFCampoValor(cmbItens);
end;

procedure TfrmParametrosContabilizacao.pSetaItensGNRE(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Add(DES_VALOR_GNRE);
end;

procedure TfrmParametrosContabilizacao.pSetaItensPDD(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Add(DES_VALOR_ORIGINAL);
  cmbItens.Items.Add(DES_VALOR_REVERSAO_PDD);
end;

procedure TfrmParametrosContabilizacao.pSetaItensTCC(cmbItens: TComboBoxFocus);
begin
  cmbItens.Items.Add(DES_VALOR_RECEBIDO);
end;

procedure TfrmParametrosContabilizacao.pSetarNatOpe(AValue: String);
begin
  cdsNatKey.EmptyDataSet;
  If (Not fEmptyStr(AValue)) Then
  Begin
    cdsNatKey.Insert;
    cdsNatKey.FieldByName('KeyValue').AsString := AValue;
    cdsNatKey.Post;
  End;
end;

procedure TfrmParametrosContabilizacao.pSetGrupoProd(const AfldParcon: TFields;
  var AcdsDados: TUniClientDataSet);
var
  LarrItens: TStringDynArray ;
  LintCnt: integer ;
  LstrCodigo: string ;
  LstrBkpIndName: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODGRU')) then
  begin
    exit ;
  end;
  LstrCodigo := AfldParcon.FieldByName('CON_CODGRU').AsString ;

  pLimpaGrupoProdSel(AcdsDados) ;

  AcdsDados.DisableControls ;
  try
    LstrBkpIndName := AcdsDados.IndexFieldNames ;
    AcdsDados.IndexFieldNames := 'CODGRU' ;
    AcdsDados.First ;
    LarrItens := SplitString(LstrCodigo, ',') ;
    for LintCnt := Low(LarrItens) to High(LarrItens) do
    begin
      if AcdsDados.FindKey([LarrItens[LintCnt]]) then
      begin
        AcdsDados.Edit ;
        AcdsDados.FieldByName('SELECI').AsBoolean := True ;
        AcdsDados.Post ;
      end;
    end;
  finally
    AcdsDados.IndexFieldNames := LstrBkpIndName ;
    AcdsDados.First ;
    AcdsDados.EnableControls ;
  end ;

end;

procedure TfrmParametrosContabilizacao.pSetMarketPlace(
  const AfldParcon: TFields; var AlstItens: TcxCheckListBox);
var
  LarrItens: TStringDynArray ;
  LintCnt: integer ;
  LintItem: integer ;
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_CODORI')) then
  begin
    exit ;
  end;
  LstrCodigo := AfldParcon.FieldByName('CON_CODORI').AsString ;

  pLimpaMarketPlaceSel(AlstItens) ;
  LarrItens := SplitString(LstrCodigo, ',') ;
  for LintCnt := Low(LarrItens) to High(LarrItens) do
  begin
    for LintItem:= 0 to AlstItens.Items.Count-1 do
    begin
      if AlstItens.Items.Items[LintItem].Tag = strtoint(LarrItens[LintCnt]) then
      begin
        AlstItens.Items.Items[LintItem].Checked := True ;
        break ;
      end;
    end;
  end;
end;

procedure TfrmParametrosContabilizacao.pSetOrigemCPC(const AfldParcon: TFields;
  var AlstItens: TcxCheckListBox);
var
  LarrItens: TStringDynArray ;
  LintCnt: integer ;
  LintItem: integer ;
  LstrCodigo: string ;
begin
  if not Assigned(AfldParcon.FindField('CON_ORICPC')) then
  begin
    exit ;
  end;
  LstrCodigo := AfldParcon.FieldByName('CON_ORICPC').AsString ;

  pLimpaOrigemCPCSel(AlstItens) ;
  LarrItens := SplitString(LstrCodigo, ',') ;
  for LintCnt := Low(LarrItens) to High(LarrItens) do
  begin
    for LintItem:= 0 to AlstItens.Items.Count-1 do
    begin
      if AlstItens.Items.Items[LintItem].Tag = StrToIntDef(LarrItens[LintCnt], 0) then
      begin
        AlstItens.Items.Items[LintItem].Checked := True ;
        break ;
      end;
    end;
  end;
end;

function TfrmParametrosContabilizacao.fUtilizouFormaDePagamentoCartao: boolean;
begin
  Result := (edtForPag.Items.IndexOf('Cartão') = edtForPag.ItemIndex);
end;

function TfrmParametrosContabilizacao.fUtilizouFormaDePagamentoDescontoTotal: boolean;
begin
  result := false ;
  if (edtForPag.Items.IndexOf(FPG_DESCONTO_TOTAL) = -1) and (edtForPag.Items.IndexOf(FPG_DESCONTO_TOTAL_CREDITO) = -1) then
    exit ;

  Result := ((pnlForPag.Visible) and ((edtForPag.ItemIndex = edtForPag.Items.IndexOf(FPG_DESCONTO_TOTAL)) or (edtForPag.ItemIndex = edtForPag.Items.IndexOf(FPG_DESCONTO_TOTAL_CREDITO))) ) ;
end;

end.
