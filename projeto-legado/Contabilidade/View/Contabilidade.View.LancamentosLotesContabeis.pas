unit Contabilidade.View.LancamentosLotesContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxContainer,
  Vcl.ComCtrls, dxCore, cxDateUtils, Vcl.Mask, MaskEditFocus, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, EditFocus, cxCurrencyEdit,
  CurrencyEditFocus, MemoFocus, ComboBoxFocus, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, MemDS, DBAccess, Uni, Datasnap.DBClient, UniClientDataSet,
  System.Generics.Collections, cxProgressBar, Contabilidade.Interfaces,
  cxGroupBox, Contabilidade.Classes.LancamentosPeriodicos;

type
  TrecDadosLote = record
    con_parmul : integer ;
    con_dtalan : TDateTime ;
    con_emplan : string ;
    con_concre : string ;
    con_condeb : string ;
    con_vallan : double ;
    con_histor : string ;
    con_ccusto : string ;
    con_ccuscr : string ;
    con_hispad : string ;
    con_automa : string ;
    con_codope : string ;
    con_tiplan : string ;
    con_clifor : string ;
    con_tip_fc : string ;
  end;

  TrecControleLancamentoSemLote = record
    conta_credito: boolean ;
    conta_debito: boolean ;
  end;

  TfrmLancamentosLotesContabeis = class(TfrmPaiContabilidade)
    gbDadosLancamento: TGroupBox;
    gbBotoes: TGroupBox;
    gbLancamentos: TGroupBox;
    GridCitelTableView: TcxGridDBTableViewCitel;
    GridCitelLevel1: TcxGridLevel;
    GridCitel: TcxGridCitel;
    dsLancamentos: TDataSource;
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    Label14: TLabel;
    mskDtaLan: TcxDateEdit;
    Label12: TLabel;
    mskContaDebito: TMaskEditFocus;
    edtDesContaDebito: TEditFocus;
    lbCCustoDebito: TLabel;
    edtCCustoDebito: TEditFocus;
    edtDesCCustoDebito: TEditFocus;
    lbContaCredito: TLabel;
    mskContaCredito: TMaskEditFocus;
    edtDesContaCRedito: TEditFocus;
    lbCCustoCredito: TLabel;
    edtCCustoCredito: TEditFocus;
    edtDesCCustoCredito: TEditFocus;
    lbValor: TLabel;
    edtValor: TCurrencyEditFocus;
    lbOpeLan: TLabel;
    edtOpeLan: TEditFocus;
    edtNomOpe: TEditFocus;
    lbHisPad: TLabel;
    edtHisPad: TEditFocus;
    edtDesHistPadrao: TEditFocus;
    edtHistor: TMemoFocus;
    lbHistor: TLabel;
    lbTipLan: TLabel;
    edtTipLan: TComboBoxFocus;
    edtAutoma: TCheckBox;
    edtConDebRed: TEditFocus;
    edtConCreRed: TEditFocus;
    dtsBusca: TDataSource;
    dbgBuscaConta: TDBGridCitel;
    GridCitelTableViewAUTOINCREM: TcxGridDBColumn;
    GridCitelTableViewCON_DTALAN: TcxGridDBColumn;
    GridCitelTableViewCON_INCDOC: TcxGridDBColumn;
    GridCitelTableViewCON_EMPLAN: TcxGridDBColumn;
    GridCitelTableViewCON_CONCRE: TcxGridDBColumn;
    GridCitelTableViewCON_CONDEB: TcxGridDBColumn;
    GridCitelTableViewCON_VALLAN: TcxGridDBColumn;
    GridCitelTableViewCON_HISTOR: TcxGridDBColumn;
    GridCitelTableViewCON_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewCON_CCUSCR: TcxGridDBColumn;
    GridCitelTableViewDES_CONDEB: TcxGridDBColumn;
    GridCitelTableViewDES_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewDES_CCUSCR: TcxGridDBColumn;
    GridCitelTableViewDES_CONCRE: TcxGridDBColumn;
    GridCitelTableViewCON_HISPAD: TcxGridDBColumn;
    GridCitelTableViewDES_HISPAD: TcxGridDBColumn;
    GridCitelTableViewCON_AUTOMA: TcxGridDBColumn;
    GridCitelTableViewCON_TIPLAN: TcxGridDBColumn;
    GridCitelTableViewCON_CODOPE: TcxGridDBColumn;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    btnSairModulo: TBitBtnLocked;
    edtNumLot: TEditFocus;
    lblNumLot: TLabel;
    GridCitelTableViewCON_PARMUL: TcxGridDBColumn;
    edtAutoInc: TEditFocus;
    lblUltimoLoteGerado: TLabel;
    gbDiferenca: TcxGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtDebito: TCurrencyEditFocus;
    edtCredito: TCurrencyEditFocus;
    edtDiferenca: TCurrencyEditFocus;
    btnGravarLote: TBitBtnLocked;
    btnCancelarLote: TBitBtnLocked;
    btnCancelarEfetivacao: TBitBtnLocked;
    popPeriodicos: TPopupMenu;
    btnSalvarPop: TMenuItem;
    btnRecuperarPop: TMenuItem;
    btnPeriodicos: TBitBtnLocked;
    lbSubcontaDebito: TLabel;
    lbSubcontaCredito: TLabel;
    edtOpcSubcontaDebito: TEditFocus;
    edtOpcSubcontaCredito: TEditFocus;
    edtCodCliForSubcontaDebito: TEditFocus;
    edtCodCliForSubcontaCredito: TEditFocus;
    GridCitelTableViewCON_CLIFOR: TcxGridDBColumn;
    GridCitelTableViewCON_TIP_FC: TcxGridDBColumn;
    edtNomCliForSubcontaCredito: TEditFocus;
    edtNomCliForSubcontaDebito: TEditFocus;
    edtAutomaticoModificado: TCheckBox;
    bntInfoLancamento: TBitBtnLocked;
    btnExclusaoLote: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    edtIncDoc: TEditFocus;
    lblNumLan: TLabel;
    btnAuditoria: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure mskContaDebitoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskContaCreditoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskContaDebitoClick(Sender: TObject);
    procedure mskContaCreditoClick(Sender: TObject);
    procedure edtConDebRedClick(Sender: TObject);
    procedure edtConCreRedClick(Sender: TObject);
    procedure edtConDebRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConCreRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure edtCCustoDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure edtHisPadKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure GridCitelTableViewDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnGravarLoteClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelarEfetivacaoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnExclusaoLoteClick(Sender: TObject);
    procedure edtValorEnter(Sender: TObject);
    procedure edtCCustoDebitoEnter(Sender: TObject);
    procedure edtCCustoCreditoEnter(Sender: TObject);
    procedure edtConCreRedExit(Sender: TObject);
    procedure btnCancelarLoteClick(Sender: TObject);
    procedure btnPeriodicosClick(Sender: TObject);
    procedure btnSalvarPopClick(Sender: TObject);
    procedure btnRecuperarPopClick(Sender: TObject);
    procedure edtCodCliForSubcontaDebitoKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtCodCliForSubcontaCreditoKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtOpcSubcontaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpcSubcontaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure bntInfoLancamentoClick(Sender: TObject);
    procedure edtEmpLanExit(Sender: TObject);
    procedure btnAuditoriaClick(Sender: TObject);
  private
    { Private declarations }
    FrecSugestaoProximoInsert: TDadosSugestaoInsertLancamentoContabil ;
    FTipoPesquisa: TPesquisaLancamentoContabil;
    FblnFormInCreate: Boolean ;
    FdictDefaultTop: TDictionary<String,Integer> ;
    FdictDefaultHeight: TDictionary<String,Integer> ;
    FblnDebitoComSubconta: Boolean ;
    FblnCreditoComSubconta: Boolean ;
    FlblGravando : TLabel;
    FControleLancSemLote : TrecControleLancamentoSemLote ;
    FModoInclusao : boolean ;
    FModoEdicao : boolean ;
    FModoLote : boolean ;
    FHeightGbLancamentos : integer ;
    FLeftExclusaoLote : integer ;
    FLeftSair : integer ;
    FValidarVigenciaCta : boolean;
    blnExisteCampoNCO_NATURE: boolean ;
    blnExisteCampoCON_CCUSCR: boolean ;
    blnExisteCampoCON_CCUSTO: boolean ;
    blnExisteCampoCON_AUTMOD: boolean ;
    qryBusca : TUniQuery;
    cdsDados : TUniClientDataSet;
    cdsPlancoVigencia: TUniClientDataSet;
    FNumParMul : integer;
    FLoteGravacao : string;
    blnCfg_SENLCOExiste : boolean;
    blnExisteCampoCON_VERSIS : boolean ;
    blnExisteCampoCON_EMPLOG : boolean ;
    procedure pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean;
      intTag: Integer);
    procedure pShowInfo(const AstrMsg: String) ;
    procedure pCarregaPlanoContabilCredito(const blnBuscaPorChave: Boolean=False; blnCampoContaReduzida: Boolean=False);
    procedure pCarregaPlanoContabilDebito(const blnBuscaPorChave: Boolean=False; blnCampoContaReduzida: Boolean=False);
    function fCarregaCentroCusto(const ACodigo: string):string ;
    function fCarregaHistoricoPadrao(const ACodigo: string):string ;
    procedure pDesabilitarCampos ;
    procedure pDesativaCentroCustoCredito(const AContaContabil: string) ;
    procedure pDesativaCentroCustoDebito(const AContaContabil: string) ;
    function fCriaCdsDados(blnCriaSoma: boolean = False): TUniClientDataSet;
    procedure pHabilitaControles(const AHabilitar: boolean; const ALote: boolean=False) ;
    function fLoteFechado(const ANumLot: string): boolean;
    procedure pLiberaPlancoVigencia;
    procedure pLancar(var ACdsDados: TUniClientDataSet; const ADados: TList<TrecDadosLote>; const AModoInclusao: boolean; const AParMul: integer = 0);
    procedure pLimparCampos(const AZeraParMul: boolean = False);
    procedure pValorCampoPadrao ;
    function fCarregarGridParaCampos: boolean ;
    function fTemInformacaoGrid: boolean ;
    function fInformouPartidaSimples(var fltValorLancamento: double): boolean;
    function fValidarTrDcZe: Boolean;
    procedure pSetFocusValidacaoTrDcZe;
    function fLancamentoPartidaMultipla(const AValor: double; const ACodEmp: string; const ADtaLan: TDateTime; const ATipLan, AOpeLan: string; const AAutoma:boolean; var ALancamentos: TList<TrecDadosLote>; var APartida:TrecDadosLote; const AParMul: integer = 0):boolean ;
    function fIndexTipLan(const ATipLan: string): integer ;
    function fEmEdicao:boolean ;
    function fPermiteEfetivar: boolean;
    procedure pSomatorioDados(var ADebitos, ACreditos: double; var ACount: integer);
    function fGravarDadosDoLote(pgbProgresso: TcxProgressBar): Boolean;
    function fGravarDadosLanCon(pgbProgresso: TcxProgressBar): Boolean;
    function fDeletaDadosGeradosPorOutraEmpresa(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarDados(const AAutoInc: string; const ATipoPesquisa: TPesquisaLancamentoContabil; const AUsarNumLot: boolean = False);
    function fCarregaDescricaoOperador(const ACodigo: string):string ;
    procedure pDeletaLotCon(strNumLot: string);
    procedure pGravaLotCon(strNumLot: string);
    procedure pGravaLotLan(strNumLot: string; pgbProgresso: TcxProgressBar);
    function fRetornaDictIncDoc(const ACdsDados: TUniClientDataSet): TDictionary<Integer,String> ;
    procedure pLimparGrid;
    function fPodeCancelarPeriodo(strNumLot: string): boolean;
    function fCancelarEfetivacao(strNumLot: string): boolean;
    function fLoteEfetivado(const ANumLot: string): boolean;
    procedure pSetModoLote(const ATipoPesquisa: TPesquisaLancamentoContabil; const AForce: Boolean = False) ;
    procedure pAjustaVisualModoLote ;
    function fGravarLote: boolean ;
    function fAlterarLote: boolean ;
    function fExcluirItemLote: boolean ;
    function fCancelarItemLote: boolean ;
    procedure pExcluirLote ;
    function fGravarLancamento(const AAutoInc: string): boolean ;
    function fAlterarLancamento(const AAutoInc: string): boolean ;
    function fCancelarlancamento(const AAutoInc: string): boolean ;
    function fExcluirLancamento(const AAutoInc: string): boolean ;
    procedure pExcluirLoteLancamento ;
    function fValidouOperacao: boolean;
    procedure pAtualizaPanelCredDebLote ;
    procedure pCdsDadosAfterDelete(DataSet: TDataSet);
    procedure pCdsDadosAfterOpen(DataSet: TDataSet);
    procedure pCdsDadosAfterPost(DataSet: TDataSet);
    procedure pLancaPartidaMultiplaSemValor ;
    function fMovimentaLinha(const Key: Word; Sender: TObject): boolean ;
    procedure pMensagemCodigoUltimoLote(const AAutoInc: string) ;
    function fValidaLancamentoContabil:Boolean ;
    function fValidaLancamentoContabilLote:Boolean ;
    procedure pSetValorLancon(const AFieldName: String; const AValor: string; ALancon: TUniQuery);
    function fGerarLancamentoPartidaMutiplaLote(var AParMul: boolean;
                                                var ArecDados: TrecDadosLote;
                                                var ALancamentos: TList<TrecDadosLote>;
                                                const AValorLancamento: Double):boolean ;
    function fAlterarLotePartidaMultipla: boolean ;
    function fIsPartidaSimples: boolean ;
    procedure pDesabilitaCamposLancamentosSemLote(const AHabilitar: boolean) ;
    function fValidaCamposLancamentosSemLote:boolean ;
    procedure pCarregaTipoContabeisManutencao ;
    function fValidacaoPrimariaAlteracao(const AAutoInc: string):boolean ;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fSalvarPeriodico:boolean ;
    function fIncluirLancamentoPeriodico:boolean ;
    function fAlterarLancamentoPeriodico:boolean ;
    function fRetornaAutoIncPeriodico(var AstrAuto: string):boolean ;
    function fDescricaoPeriodico(var AstrDescri: string):boolean ;
    function fLancamentosPeriodicoDet(const AstrSeqGer: string):TPeriodicosDetalhe ;
    function fRecuperarPeriodico:boolean ;
    function fValidaValorZerado:boolean ;
    procedure pSetaRegistroAutomaticoModificado(AqryLancon: TUniQuery) ;
    procedure pAtualizaCheckBoxAutomaticoModificado(AdtsLancon: TDataSet) ;
    procedure pAtualizaOpUltimaAltPeriodico(const AstrAuto: string) ;
    procedure pReorganizaEntradaDadosSubContasInterno(const AblnCredito, AblnDebito: Boolean) ;
    procedure pReorganizaEntradaDadosSubContas ;
    procedure pSalvaPosicionamentoSubContasDefault ;
    procedure pRestauraPosicionamentoSubContasDefault ;
    procedure pSetDebitoComSubconta(const AValue: Boolean) ;
    procedure pSetCreditoComSubconta(const AValue: Boolean) ;
    procedure pEhDebitoComSubConta(const AstrConta, AstrEmpLan: String; const AblnAtualizaControlesVisuais: Boolean = True) ;
    procedure pEhCreditoComSubConta(const AstrConta, AstrEmpLan: String; const AblnAtualizaControlesVisuais: Boolean = True) ;
    function fValidaOpcaoSubConta(AedtCampo: TEditFocus): Boolean ;
    function fCarregaCliForSubConta(AedtCodigo, AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean ;
    procedure pMostraColunasSubConta(const AblnMostrar: Boolean);
    procedure pFormBeginUpdate;
    procedure pFormEndUpdate ;
    procedure pRetornaDadosCliFor(var AstrCliFor, AstrTipo: String) ;
    property DebitoComSubconta: Boolean read FblnDebitoComSubconta write pSetDebitoComSubconta ;
    property CreditoComSubconta: Boolean read FblnCreditoComSubconta write pSetCreditoComSubconta ;
    procedure pCarregaSugestaoUltimoInsert();
    procedure pSalvaSugestaoUltimoInsert();
    function fTemLancamentoCarregado: Boolean ;
    procedure pMostraInfoAlteracaoInclusao ;
    function fRetornaAutoIncremLancon: String ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Consultas, untTypesSistema,
     untConsultas, Contabilidade.Funcoes, Contabilidade.View.ExclusaoLanctoContabil,
     Contabilidade.View.MultLancamentosLotesContabeis,
     Contabilidade.Classes.TValidaProcessoLancamentoContabil,
     untInputDialog, untFuncoes, strUtils,
     Contabilidade.View.PeriodoDatasPeriodicos,
     Contabilidade.Classes.TPeriodoDatas , Contabilidade.View.MemoInfo,
     Contabilidade.Classes.TransferenciaLancamentosEntreContas,
  Contabilidade.Classes.FechamentoDiaMes,
  Contabilidade.Classes.UniQueryAuditoria,
  Contabilidade.View.AuditoriaLancamentos;

const
  ALTERARPERIODICO =  1 ;
  INCLUIRPERIODICO =  2 ;
  CANCELARPERIODICO = 3 ;
  SIMPERIODICO = 1 ;
  NAOPERIODICO = 2 ;
  FORMEXPANDIDO = 'exp' ;
  FORMRECOLHIDO = 'rec' ;

{$R *.dfm}

procedure TfrmLancamentosLotesContabeis.bntInfoLancamentoClick(Sender: TObject);
begin
  inherited;
  if not fTemLancamentoCarregado then
    Exit ;

  pMostraInfoAlteracaoInclusao ;
end;

procedure TfrmLancamentosLotesContabeis.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if FModoLote then
  begin
    if not fAlterarLote then
    begin
      exit ;
    end;
  end
  else
  begin
    if not fAlterarLancamento(edtAutoInc.Text) then
    begin
      exit ;
    end;
  end;
  pHabilitaControles(True, True) ;
  pSetFocus(edtEmpLan) ;
end;

procedure TfrmLancamentosLotesContabeis.btnAuditoriaClick(Sender: TObject);
var
  LfrmAuditoriaLancamentos: TfrmAuditoriaLancamentos;
begin
  inherited;
  pCriarFormularios(TfrmAuditoriaLancamentos, LfrmAuditoriaLancamentos) ;
  try
    if FModoLote then
    begin
      LfrmAuditoriaLancamentos.AutoIncremLancon := cdsDados.FieldByName('CON_AUTINC').AsString;
    end
    else
    begin
      LfrmAuditoriaLancamentos.AutoIncremLancon := edtAutoInc.Text;
    end;
    LfrmAuditoriaLancamentos.TipoPesquisa := FTipoPesquisa;
    LfrmAuditoriaLancamentos.ShowModal ;
  finally
    pFreeAndNil(LfrmAuditoriaLancamentos);
  end;
end;

procedure TfrmLancamentosLotesContabeis.btnCancelaClick(Sender: TObject);
begin
  inherited;

  if FModoLote then
  begin
    if not fCancelarItemLote then
    begin
      exit ;
    end;
  end
  else
  begin
    if not fCancelarlancamento(edtAutoInc.Text) then
    begin
      exit ;
    end;
  end;

  FModoInclusao := False ;
  FModoEdicao := False ;
  pHabilitaControles(False, True) ;
  pSetFocus(btnIncluir);
end;

procedure TfrmLancamentosLotesContabeis.btnCancelarEfetivacaoClick(
  Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtNumLot.Text) then
  begin
    fMensagem('', 'É necessário carregar um lote!', ['&OK']);
    Exit;
  end;

  if not fPodeCancelarPeriodo(edtNumLot.Text) then
    exit;

  if not fLoteEfetivado(edtNumLot.Text) then
  begin
    fMensagem('', 'Lote "' + edtNumLot.Text + '" não efetivado!', ['&OK']);
    Exit;
  end;


  if (fMensagem('', 'Deseja cancelar a efetivação do lote "' + edtNumLot.Text + '"?', ['&Sim', '&Não'], 2) = 1) then
  begin
    if fCancelarEfetivacao(edtNumLot.Text) then
    begin
      pCarregarDados(edtNumLot.Text, plcLote, True);
      fMensagem('ATENÇÃO!', 'Cancelamento da efetivação concluído com sucesso!', ['&OK']);
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.btnCancelarLoteClick(Sender: TObject);
begin
  inherited;
  if (fMensagem('AVISO', 'Deseja realmente cancelar a edição do registro?', ['&Sim', '&Não']) = 2) then
  begin
    Exit;
  end;
  pLimparGrid ;
  pLimparCampos();
  pSetModoLote(plcLancon, True) ;
  pHabilitaControles(False, True) ;
  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
end;

procedure TfrmLancamentosLotesContabeis.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if FModoLote then
  begin
    if not fExcluirItemLote then
    begin
      exit ;
    end;
  end
  else
  begin
    if not fExcluirLancamento(edtAutoInc.Text) then
    begin
      exit ;
    end;
  end;

  pLimparCampos();
end;

procedure TfrmLancamentosLotesContabeis.btnExclusaoLoteClick(Sender: TObject);
begin
  inherited;
  if FModoLote then
  begin
    pExcluirLote ;
  end
  else
  begin
    pExcluirLoteLancamento ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.btnGravarClick(Sender: TObject);
begin
  inherited;

  if not fValidaLancamentoContabil then
  begin
    exit ;
  end;

  if not fPodeIncluirComSubconta(edtCodCliForSubcontaDebito.Visible, edtCodCliForSubcontaCredito.Visible) then
  begin
    fMensagem('ATENÇÃO!', 'Apenas uma conta pode ser informada como subconta!', ['&OK']);
    pSetFocus(edtEmpLan) ;
    Exit;
  end ;

  if FModoLote then
  begin
    if not fGravarLote then
    begin
      exit ;
    end;
  end
  else
  begin
    if not fValidaCamposLancamentosSemLote then
    begin
      exit ;
    end;

    if not fGravarLancamento(edtAutoInc.Text) then
    begin
      exit ;
    end;
  end;

  FModoInclusao := False ;
  FModoEdicao := False ;

  pHabilitaControles(False, True) ;

  pSetFocus(btnIncluir);

end;

procedure TfrmLancamentosLotesContabeis.btnGravarLoteClick(Sender: TObject);
begin
  inherited;
  if fLoteFechado(edtNumLot.Text) then
  begin
    exit;
  end;

  if cdsDados.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Nenhum registro foi informado!', ['&OK']);
    exit;
  end;

  if not fValidaValorZerado then
    exit ;

  if not fValidaLancamentoContabilLote then
    exit ;

  if (fMensagem('', 'Confirma gravação do ' + IIF(fEmptyStr(edtNumLot.Text), ' novo lote', 'lote ' + edtNumLot.Text) + '?', ['&Sim', '&Não'], 2) = 2) then
    exit;

  if fChamaTelaGravando(fGravarDadosDoLote) then
  begin
    if (fPermiteEfetivar) then
    begin
      if (fMensagem('', 'Deseja efetuar o fechamento do lote selecionado?', ['&Sim', '&Não'], 2) = 1) then
      begin
        // tranforma os dados da LOTCON em LANCON e grava a DATA DE FECHAMENTO na LOTCON
        fChamaTelaGravando(fGravarDadosLanCon);
      end;
    end;
  end;
  pLimparCampos(True);
  pLimparGrid ;
  pSetModoLote(plcLancon, True) ;
  pHabilitaControles(False, True) ;
  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
end;

procedure TfrmLancamentosLotesContabeis.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if not FModoLote then
  begin
    pLimparCampos(True);
    pLimparGrid ;
    pSetModoLote(plcLote) ;
  end ;

  if fLoteFechado(edtNumLot.Text) then
  begin
    exit;
  end;

  pMensagemCodigoUltimoLote('') ;

  FModoInclusao := True ;

  pHabilitaControles(True, True) ;

  pCarregaSugestaoUltimoInsert ;

  pSetFocus(edtEmpLan);

end;

procedure TfrmLancamentosLotesContabeis.btnPeriodicosClick(Sender: TObject);
Var
  pnt : TPoint;
begin
  inherited;
  pnt.X := 0 ;
  pnt.Y := 0 ;
  pnt   := btnPeriodicos.ClientToScreen( pnt );
  pnt.Y := pnt.Y + btnPeriodicos.Height;
  popPeriodicos.Popup(pnt.X, pnt.Y);
end;

procedure TfrmLancamentosLotesContabeis.btnPesquisaClick(Sender: TObject);
Var
  arrSel : TConsultasArray;
  chrkey : Char;
  LAutoInc: String ;
begin
  chrKey := '/';
  If fPesqLanCon(Self, edtAutoInc, edtEmpLan, qryTabela, chrKey, arrSel, FTipoPesquisa) Then
  Begin
    If btnAlterar.Visible And btnAlterar.Enabled Then
    begin
      LAutoInc := edtAutoInc.Text ;
      pCarregarDados(edtAutoInc.Text, FTipoPesquisa) ;
      pHabilitaControles(False) ;
      edtAutoInc.Text := LAutoInc ;
      pSetFocus(btnAlterar);
    end;
  End;
end;

procedure TfrmLancamentosLotesContabeis.btnRecuperarPopClick(Sender: TObject);
begin
  inherited;

  if fRecuperarPeriodico then
    fMensagem('ATENÇÃO!', 'Concluído!', ['&OK']);

end;

procedure TfrmLancamentosLotesContabeis.btnSalvarPopClick(Sender: TObject);
begin
  inherited;
  if not fTemInformacaoGrid then
    exit ;

  if fSalvarPeriodico then
    fMensagem('ATENÇÃO!', 'Concluído!', ['&OK']);

end;

procedure TfrmLancamentosLotesContabeis.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) or (dbgBuscaConta.Tag = 11) Then
  Begin
    mskContaDebito.Text := qryBusca.FieldByName('CODCON').AsString;
    pDesativaCentroCustoDebito(mskContaDebito.Text) ;
    edtConDebRed.Text := qryBusca.FieldByName('CONRED').AsString;
    edtDesContaDebito.Text := qryBusca.FieldByName('DESCON').AsString;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
    if dbgBuscaConta.Tag = 1 then
      pSetFocus(mskContaDebito)
    else
      pSetFocus(edtConDebRed) ;
  End
  Else If (dbgBuscaConta.Tag = 2) or (dbgBuscaConta.Tag = 12) Then
  Begin
    mskContaCredito.Text := qryBusca.FieldByName('CODCON').AsString;
    pDesativaCentroCustoCredito(mskContaCredito.Text) ;
    edtConCreRed.Text := qryBusca.FieldByName('CONRED').AsString;
    edtDesContaCredito.Text := qryBusca.FieldByName('DESCON').AsString;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
    if dbgBuscaConta.Tag = 2 then
      pSetFocus(mskContaCredito)
    else
      pSetFocus(edtConCreRed) ;
  End;

end;

procedure TfrmLancamentosLotesContabeis.edtCCustoCreditoEnter(Sender: TObject);
begin
  inherited;
  if fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    edtCCustoCredito.Clear ;
    edtDesCCustoCredito.Clear ;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLancamentosLotesContabeis.edtCCustoCreditoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoCredito, edtDesCCustoCredito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoCredito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosLotesContabeis.edtCCustoDebitoEnter(Sender: TObject);
begin
  inherited;
  if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    edtCCustoDebito.Clear ;
    edtDesCCustoDebito.Clear ;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLancamentosLotesContabeis.edtCCustoDebitoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoDebito, edtDesCCustoDebito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoDebito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosLotesContabeis.edtCodCliForSubcontaCreditoKeyPress(
  Sender: TObject; var Key: Char);
var
  arrRetornoConsultas : TConsultasArray;
begin
  inherited;

  if not fValidaOpcaoSubConta(edtOpcSubcontaCredito) then
  begin
    pSetFocus(edtOpcSubcontaCredito);
    Exit ;
  end ;

  if edtOpcSubcontaCredito.Text = 'C' then //clientes
  begin
    If fPesqClientesCont(Self, edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaCredito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else // fornecedores
  begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaCredito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.edtCodCliForSubcontaDebitoKeyPress(
  Sender: TObject; var Key: Char);
var
  arrRetornoConsultas : TConsultasArray;
begin
  inherited;

  if not fValidaOpcaoSubConta(edtOpcSubcontaDebito) then
  begin
    pSetFocus(edtOpcSubcontaDebito);
    Exit ;
  end ;

  if edtOpcSubcontaDebito.Text = 'C' then //clientes
  begin
    If fPesqClientesCont(Self, edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaDebito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else // fornecedores
  begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaDebito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end ;

end;

procedure TfrmLancamentosLotesContabeis.edtConCreRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosLotesContabeis.edtConCreRedExit(Sender: TObject);
begin
  inherited;
  pLancaPartidaMultiplaSemValor ;
end;

procedure TfrmLancamentosLotesContabeis.edtConCreRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConCreRed, True, 2);
  end;
end;

procedure TfrmLancamentosLotesContabeis.edtConDebRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosLotesContabeis.edtConDebRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConDebRed, True, 1);
  end;
end;

procedure TfrmLancamentosLotesContabeis.edtEmpLanExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtHisPad);
end;

procedure TfrmLancamentosLotesContabeis.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosLotesContabeis.edtHisPadKeyPress(Sender: TObject;
  var Key: Char);
var
  arrHisPad : TConsultasArray;
begin
  inherited;

  if fEmptyStr(edtEmpLan.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Preencha o código da empresa do lançamento!', ['&OK']);
    pSetFocus(edtEmpLan);
    Key := #0;
    Exit;
  end;

  If fPesqHistoricoPadrao(Self, edtHisPad, edtDesHistPadrao, Nil, Key, arrHisPad, True, edtEmpLan.Text) Then
  Begin
    If fValidaCampos(edtHisPad, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosLotesContabeis.edtOpcSubcontaCreditoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(key, [#13, #9]) then
  begin
    edtCodCliForSubcontaCredito.Clear ;
    edtNomCliForSubcontaCredito.Clear ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.edtOpcSubcontaDebitoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(key, [#13, #9]) then
  begin
    edtCodCliForSubcontaDebito.Clear ;
    edtNomCliForSubcontaDebito.Clear ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.edtValorEnter(Sender: TObject);
begin
  inherited;
  pLancaPartidaMultiplaSemValor ;
end;

function TfrmLancamentosLotesContabeis.fCarregaCentroCusto(
  const ACodigo: string): string;
begin
  result := fRetNomEvento(ACodigo) ;
end;

function TfrmLancamentosLotesContabeis.fCarregaCliForSubConta(AedtCodigo,
  AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean;
var
  LstrDescrMensagem: String ;
begin
  Result := True ;
  If Not fEmptyStr(AedtCodigo.Text) Then
  Begin
    AedtDescricao.Text := fCarregaCliForBD(AedtCodigo.Text, AstrOpcao) ;
    if AstrOpcao = 'C' then // cliente
      LstrDescrMensagem := 'Esse cliente não está cadastrado!'
    else // fornecedor
      LstrDescrMensagem := 'Esse fornecedor não está cadastrado!' ;

    If fEmptyStr(AedtDescricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', LstrDescrMensagem, ['&OK']);
      Result := False;
    End;
  End
  Else
  Begin
    AedtDescricao.Clear;
  End;
end;

function TfrmLancamentosLotesContabeis.fCarregaDescricaoOperador(
  const ACodigo: string): string;
begin
  result := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [ACodigo]);
end;

function TfrmLancamentosLotesContabeis.fCarregaHistoricoPadrao(
  const ACodigo: string): string;
begin
  if fEmptyStr(edtEmplan.Text) then
  begin
    result := '';
    exit;
  end;

  result := fRetDescHistoricoPadrao(ACodigo, edtEmplan.Text);
end;

procedure TfrmLancamentosLotesContabeis.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fEmEdicao then
  begin
    if (fMensagem('', 'As informações modificadas serão perdidas!'+#13+'Deseja Continuar?', ['&Sim', '&Não'], 2) = 1) then
    begin
      CanClose := True ;
    end
    else
    begin
      CanClose := False ;
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.FormCreate(Sender: TObject);
var
  strMascara: string ;
begin
  inherited;
  FblnFormInCreate := True ;
  FdictDefaultTop := TDictionary<String,Integer>.Create ;
  FdictDefaultHeight := TDictionary<String,Integer>.Create ;
  pSalvaPosicionamentoSubContasDefault ;
  FHeightGbLancamentos := gbLancamentos.Height + pnlBotoes.Height + (gbDiferenca.Height-10) ;
  FLeftExclusaoLote := btnExclusaoLote.Left ;
  FLeftSair := btnSairModulo.Left ;
  pCarregaTipoContabeisManutencao ;
  pSetModoLote(plcLancon, True) ;
  FdictDefaultHeight.Items[Self.Name+FORMRECOLHIDO] := Self.Height ;
  FModoLote := False ;
  pReorganizaEntradaDadosSubContasInterno(False, False) ;

  pValorCampoPadrao ;

  qryBusca := fCriaQuery(Self);
  dtsBusca.DataSet := qryBusca;

  strMascara := fMskCon;
  mskContaDebito.EditMask := strMascara;
  mskContaCredito.EditMask := strMascara;

  blnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');
  blnCfg_SENLCOExiste := fConfiguracaoExiste('SENLCO');

  blnExisteCampoCON_CCUSCR := fCampoExiste('LANCON', 'CON_CCUSCR');
  blnExisteCampoCON_CCUSTO := True ;

  blnExisteCampoCON_AUTMOD := fCampoExiste('LANCON', 'CON_AUTMOD');
  edtAutomaticoModificado.Visible := blnExisteCampoCON_AUTMOD ;

  if (fCfgExpEcd = 'S') and (fCfgObrCcu = 'N') then
  begin
    blnExisteCampoCON_CCUSCR := False ;
    blnExisteCampoCON_CCUSTO := False ;
  end;

  blnExisteCampoCON_VERSIS := fCampoExiste('LANCON', 'CON_VERSIS');
  blnExisteCampoCON_EMPLOG := fCampoExiste('LANCON', 'CON_EMPLOG');

  FValidarVigenciaCta := fTemVigencia;

  pDesabilitarCampos ;

  cdsDados := fCriaCdsDados(False) ;
  cdsDados.AfterOpen := pCdsDadosAfterOpen;
  cdsDados.AfterDelete := pCdsDadosAfterDelete;
  cdsDados.AfterPost := pCdsDadosAfterPost;
  dsLancamentos.DataSet := cdsDados ;

  cdsPlancoVigencia := fCarregaPlancoVigencia ;

  pHabilitaControles(False) ;

  pMensagemCodigoUltimoLote('') ;

  FNumParMul := 0 ;

  FControleLancSemLote.conta_credito := False ;
  FControleLancSemLote.conta_debito := False ;

  FModoInclusao := False ;
  FModoEdicao := False ;
  FLoteGravacao := '' ;
  FblnDebitoComSubconta  := False ;
  FblnCreditoComSubconta := False ;
  pMostraColunasSubConta(fCfgDesmembrarSubContaCliFor = 'S') ;
  FblnFormInCreate := False ;
  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
  FTipoPesquisa := plcLancon;
end;

procedure TfrmLancamentosLotesContabeis.FormDestroy(Sender: TObject);
begin
  inherited;
  pLiberaPlancoVigencia ;
  FreeAndNil(cdsDados) ;
  FreeAndNil(qryBusca) ;
  FreeAndNil(FdictDefaultTop) ;
  FreeAndNil(FdictDefaultHeight) ;
end;

function TfrmLancamentosLotesContabeis.fTemInformacaoGrid: boolean;
begin
  result := false ;
  if not cdsDados.Active then
  begin
    fMensagem('ATENÇÃO!', 'Lote não selecionado!', ['&OK']);
    exit ;
  end;

  if cdsDados.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Lote não selecionado!', ['&OK']);
    exit ;
  end;
  result := true ;
end;

function TfrmLancamentosLotesContabeis.fTemLancamentoCarregado: Boolean;
begin
  Result := False ;
  if FModoLote then
  begin
    if not fTemInformacaoGrid then
      exit ;
  end
  else
  begin
    if fEmptyStr(edtAutoInc.Text) then
    begin
      fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&OK']);
      exit ;
    end;
  end ;
  Result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strTplaco: string ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpLan) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End

    Else If (Sender = mskContaCredito) Then
    Begin
      pCarregaPlanoContabilCredito(blnBuscaPorChave) ;
      pDesativaCentroCustoCredito(mskContaCredito.Text) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
        Result := False;
      end
      else if (blnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) then
      begin
        strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConCreRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilCredito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = mskContaDebito) Then
    Begin
      pCarregaPlanoContabilDebito(blnBuscaPorChave) ;
      pDesativaCentroCustoDebito(mskContaDebito.Text) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
        Result := False;
      end
      else if (blnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
      begin
        strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConDebRed) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilDebito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = edtTipLan) Then
    Begin
      if fEmptyStr(edtTipLan.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtCCustoDebito) and (edtCCustoDebito.Enabled) Then
    Begin
      If Not fEmptyStr(edtCCustoDebito.Text) Then
      Begin
        edtDesCCustoDebito.Text := fCarregaCentroCusto(edtCCustoDebito.Text);
        If fEmptyStr(edtDesCCustoDebito.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCCustoDebito.Clear;
      End;
    End

    Else If (Sender = edtCCustoCredito)  and (edtCCustoCredito.Enabled) Then
    Begin
      If Not fEmptyStr(edtCCustoCredito.Text) Then
      Begin
        edtDesCCustoCredito.Text := fCarregaCentroCusto(edtCCustoCredito.Text);
        If fEmptyStr(edtDesCCustoCredito.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCCustoCredito.Clear;
      End;
    End

    else if (Sender = edtHisPad) then
    begin
      If Not fEmptyStr(edtHisPad.Text) Then
      Begin
        if not fValidaCampos(edtEmpLan) then
        begin
          edtHisPad.Text := '';
          Result := False;
          Exit;
        end;

        edtDesHistPadrao.Text := fCarregaHistoricoPadrao(edtHisPad.Text);
        If fEmptyStr(edtDesHistPadrao.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse histórico padrão não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesHistPadrao.Clear;
      End;

    end
    else if (Sender = edtOpcSubcontaDebito) and (edtOpcSubcontaDebito.Visible) then
    begin
      Result := fValidaOpcaoSubConta(edtOpcSubcontaDebito) ;
    end
    else if (Sender = edtOpcSubcontaCredito) and (edtOpcSubcontaCredito.Visible) then
    begin
      Result := fValidaOpcaoSubConta(edtOpcSubcontaCredito) ;
    end
    else if (Sender = edtCodCliForSubcontaDebito) and (edtCodCliForSubcontaDebito.Visible) then
    begin
      if not fValidaOpcaoSubConta(edtOpcSubcontaDebito) then
      begin
        pSetFocus(edtOpcSubcontaDebito);
        Result := False ;
        Exit ;
      end ;
      Result := fCarregaCliForSubConta(edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, edtOpcSubcontaDebito.Text) ;
    end
    else if (Sender = edtCodCliForSubcontaCredito) and (edtCodCliForSubcontaCredito.Visible) then
    begin
      if not fValidaOpcaoSubConta(edtOpcSubcontaCredito) then
      begin
        pSetFocus(edtOpcSubcontaCredito);
        Result := False ;
        Exit ;
      end ;
      Result := fCarregaCliForSubConta(edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, edtOpcSubcontaCredito.Text) ;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmLancamentosLotesContabeis.fValidaCamposLancamentosSemLote: boolean;
begin
  Result := False ;
  if not fIsPartidaSimples then
  begin
    if FControleLancSemLote.conta_credito then
    begin
      if fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
      begin
        fMensagem('ATENÇÃO!', '"C. Crédito" não informado!', ['&OK']);
        pSetFocus(mskContaCredito);
        Exit ;
      end;
    end;

    if FControleLancSemLote.conta_debito then
    begin
      if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
      begin
        fMensagem('ATENÇÃO!', '"C. Débito" não informado!', ['&OK']);
        pSetFocus(mskContaDebito);
        Exit ;
      end;
    end;
  end ;
  Result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidacaoPrimariaAlteracao(
  const AAutoInc: string): boolean;
var
  strMensagem: string;
begin
  result := False ;
  if fEmptyStr(AAutoInc) then
  begin
    fMensagem('ATENÇÃO!', 'Registro não selecionado!', ['&OK']);
    exit ;
  end;
  if copy(edtTipLan.Text, 1, 3) = 'FEC' then
  begin
    fMensagem('ATENÇÃO!', 'Não é possível alterar registro de fechamento!', ['&OK']);
    exit ;
  end;
  if fLancamentoAnteriorFechamento(mskDtaLan.Date, edtEmpLan.Text, strMensagem) then
  begin
    fMensagem('ATENÇÃO!', strMensagem, ['&OK']);
    Exit;
  end;
  if TVerificaFechamentoDiaMes.fTemFechamento(mskDtaLan.Date, mskDtaLan.Date, edtEmpLan.Text, False) then
  begin
    Exit;
  end;

  result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidaLancamentoContabil: Boolean;
var
  LdvlDados : TDadosValidacaoLanCon ;
begin
  result := False ;

  if not fVerificaCampos then
    exit;

  if fEmptyStr(edtEmpLan.Text) then
    edtEmpLan.Text := VS_strCodEmp;

  LdvlDados.dtaLan := mskDtaLan.Date ;
  LdvlDados.strCodEmp := edtEmpLan.Text ;
  LdvlDados.fltValor := edtValor.Value ;
  LdvlDados.strContaCredito := mskContaCredito.Text ;
  LdvlDados.strContaDebito := mskContaDebito.Text ;
  LdvlDados.strCentroCustoCredito := edtCCustoCredito.Text ;
  LdvlDados.strCentroCustoDebito := edtCCustoDebito.Text ;
  LdvlDados.strComplemento := edtHistor.Text ;
  LdvlDados.strHistoricoPadrao := edtHisPad.Text ;
  LdvlDados.blnValidarClienteFornecedorDebito := edtOpcSubcontaDebito.Visible ;
  LdvlDados.strTipoFCDebito := edtOpcSubcontaDebito.Text ;
  LdvlDados.strClienteFornecedorDebito := edtCodCliForSubcontaDebito.Text ;
  LdvlDados.blnValidarClienteFornecedorCredito := edtOpcSubcontaCredito.Visible ;
  LdvlDados.strTipoFCCredito := edtOpcSubcontaCredito.Text ;
  LdvlDados.strClienteFornecedorCredito := edtCodCliForSubcontaCredito.Text ;
  if not TValidaProcessoLancamentoContabil.fValida(LdvlDados, cdsPlancoVigencia, FModoLote) then
  begin
    exit ;
  end;

  result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidaLancamentoContabilLote: Boolean;
var
  LdvlDados : TDadosValidacaoLanCon ;
begin
  cdsDados.DisableControls ;
  try
    cdsDados.First;
    while not cdsDados.Eof do
    begin
      FillChar(LdvlDados, SizeOf(LdvlDados), #0);
      LdvlDados.dtaLan := cdsDados.FieldByName('CON_DTALAN').AsDateTime ;
      LdvlDados.strCodEmp := cdsDados.FieldByName('CON_EMPLAN').AsString ;
      LdvlDados.fltValor := cdsDados.FieldByName('CON_VALLAN').AsFloat ;
      LdvlDados.strContaCredito := cdsDados.FieldByName('CON_CONCRE').AsString ;
      LdvlDados.strContaDebito := cdsDados.FieldByName('CON_CONDEB').AsString ;
      LdvlDados.strCentroCustoCredito := cdsDados.FieldByName('CON_CCUSCR').AsString ;
      LdvlDados.strCentroCustoDebito := cdsDados.FieldByName('CON_CCUSTO').AsString ;
      LdvlDados.strComplemento := cdsDados.FieldByName('CON_HISTOR').AsString ;
      LdvlDados.strHistoricoPadrao := cdsDados.FieldByName('CON_HISPAD').AsString ;

      pEhDebitoComSubConta(LdvlDados.strContaDebito, LdvlDados.strCodEmp, False) ;
      LdvlDados.blnValidarClienteFornecedorDebito := FblnDebitoComSubconta ;
      if LdvlDados.blnValidarClienteFornecedorDebito then
      begin
        LdvlDados.strTipoFCDebito := cdsDados.FieldByName('CON_TIP_FC').AsString ;
        LdvlDados.strClienteFornecedorDebito := cdsDados.FieldByName('CON_CLIFOR').AsString ;
      end ;

      pEhCreditoComSubConta(LdvlDados.strContaCredito, LdvlDados.strCodEmp, False) ;
      LdvlDados.blnValidarClienteFornecedorCredito := FblnCreditoComSubconta ;
      if LdvlDados.blnValidarClienteFornecedorCredito then
      begin
        LdvlDados.strTipoFCCredito := cdsDados.FieldByName('CON_TIP_FC').AsString ;
        LdvlDados.strClienteFornecedorCredito := cdsDados.FieldByName('CON_CLIFOR').AsString ;
      end ;

      if not TValidaProcessoLancamentoContabil.fValida(LdvlDados, cdsPlancoVigencia, True) then
        exit(False) ;

      cdsDados.Next ;
    end ;
  finally
    cdsDados.EnableControls ;
  end ;
  Result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidaOpcaoSubConta(
  AedtCampo: TEditFocus): Boolean;
begin
  Result := False ;
  If fEmptyStr(AedtCampo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta deve ser preenchido!', ['&Ok']);
    exit ;
  End
  Else If (AedtCampo.Text <> 'C') And (AedtCampo.Text <> 'F') Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta com valor inválido[C/F]!', ['&Ok']);
    Exit ;
  End;
  Result := True ;
end;

procedure TfrmLancamentosLotesContabeis.GridCitelTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  btnAlterar.Click ;
end;

procedure TfrmLancamentosLotesContabeis.mskContaCreditoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosLotesContabeis.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCredito, Nil, Key, arrPlan, True, strTplaco, not blnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaCredito.Text := fCarregaDescricaoConta(edtDesContaCredito.Text, edtEmpLan.Text) ;
    edtConCreRed.Text := fCarregaContaReduzida(edtDesContaCredito.Text, edtEmpLan.Text) ;
    pDesativaCentroCustoCredito(mskContaCredito.Text) ;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmLancamentosLotesContabeis.mskContaCreditoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaCredito, False, 2);
  end;
end;

procedure TfrmLancamentosLotesContabeis.mskContaDebitoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosLotesContabeis.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan, True, strTplaco, not blnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaDebito.Text := fCarregaDescricaoConta(mskContaDebito.Text, edtEmpLan.Text) ;
    edtConDebRed.Text := fCarregaContaReduzida(mskContaDebito.Text, edtEmpLan.Text) ;
    pDesativaCentroCustoDebito(mskContaDebito.Text) ;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmLancamentosLotesContabeis.mskContaDebitoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaDebito, False, 1);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pAjustaVisualModoLote;
begin
  gbLancamentos.Visible := FModoLote ;
  lblNumLot.Visible := FModoLote ;
  edtNumLot.Visible := FModoLote ;
  pnlStatus.Visible := not FModoLote ;
  gbDiferenca.Visible := FModoLote ;
  pnlBotoes.Visible :=  FModoLote ;
  ////ajusta o tamanho do formulario e o posicionamento dos botões
  if FModoLote then
  begin
    Self.Height := Self.Height + FHeightGbLancamentos ;
    Self.Width := 1053 ;
    btnSalvarPop.Enabled :=  True;
  end
  else
  begin
    Self.Height := Self.Height - FHeightGbLancamentos ;
    Self.Width := 1041;
    btnSalvarPop.Enabled :=  False;
  end;
  Self.Top := IIF(Trunc((Screen.Height - Self.Height)/ 2) > 0, Trunc((Screen.Height - Self.Height)/ 2), 0);
  Self.Left := IIF(Trunc((Screen.Width - Self.Width)/ 2) > 0, Trunc((Screen.Width - Self.Width)/ 2), 0);
  if edtNumLot.Visible then
  begin
    lblUltimoLoteGerado.Visible := false ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pAtualizaCheckBoxAutomaticoModificado(AdtsLancon: TDataSet);
begin
  if not blnExisteCampoCON_AUTMOD then
    exit ;

  edtAutomaticoModificado.Checked := AdtsLancon.FieldByName('CON_AUTMOD').AsString = 'S' ;

end;

procedure TfrmLancamentosLotesContabeis.pAtualizaOpUltimaAltPeriodico(const AstrAuto: string);
var
  LobjCapaSel: TPeriodicoCapa ;
  LobjCapaUpd: TPeriodicoCapa ;
begin
  LobjCapaSel := TDadosPeriodicoCapa.fSelecionaDados(AstrAuto).Items[0] ;
  LobjCapaUpd := TPeriodicoCapa.Create ;
  try
    LobjCapaUpd.Descri := LobjCapaSel.Descri ;
    LobjCapaUpd.Codope := strLoginUsuarioLogado ;
    LobjCapaUpd.Dtaalt := VS_Date ;
    LobjCapaUpd.Hraalt := TimeToStr(fTime()) ;
    TDadosPeriodicoCapa.fAtualizaDados(AstrAuto, LobjCapaUpd);
  finally
    FreeAndNil(LobjCapaUpd) ;
    FreeAndNil(LobjCapaSel) ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.pAtualizaPanelCredDebLote;
var
  fltCreditos, fltDebitos: double ;
  intRegistros: integer ;
begin
  pSomatorioDados(fltDebitos, fltCreditos, intRegistros);
  edtDebito.Value := fltDebitos ;
  edtCredito.Value := fltCreditos ;
  edtDiferenca.Value := edtCredito.Value - edtDebito.Value ;
end;

procedure TfrmLancamentosLotesContabeis.pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer);
var
  strTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(dbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;

  dbgBuscaConta.Tag := 0;

  qryBusca.Close;
  qryBusca.SQL.Clear;
  qryBusca.SQL.Add(' SELECT NCO_CODCON AS CODCON, NCO_DESCRI AS DESCON, NCO_CONRED AS CONRED ');
  qryBusca.SQL.Add('   FROM PLANCO ');
  qryBusca.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
  qryBusca.ParamByName('TPLACO').AsString := strTplaco ;
  If (blnRed) Then
    qryBusca.SQL.Add('  AND (NCO_CONRED LIKE :CODCON) ')
  Else
    qryBusca.SQL.Add('  AND (NCO_CODCON LIKE :CODCON) ');

  if fCfgCtntsi = 'N' then
  begin
    qryBusca.SQL.Add(' AND IFNULL(NCO_NATURE,"A") = "A" ') ;
  end ;

  qryBusca.ParamByName('CODCON').AsString := '%' + fTiraCaracEspeciais(fSemMascaraPlaNco(dbeTexto.Text), True, True, True, True, True) + '%';
  qryBusca.SQL.Add('  ORDER BY NCO_CODCON ');
  qryBusca.Open;

  If (Not qryBusca.IsEmpty) Then
  Begin
    If (blnRed) Then
    begin
      if (intTag = 1) then
        qryBusca.Locate('NCO_CODCON', mskContaDebito.Text, [])
      else
        qryBusca.Locate('NCO_CODCON', mskContaCredito.Text, []);
    end;

    dbgBuscaConta.Left := dbeTexto.Left;
    dbgBuscaConta.Top := dbeTexto.Top + dbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := intTag;
    if blnRed then
    begin
      dbgBuscaConta.Tag := dbgBuscaConta.Tag + 10 ;
    end;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosLotesContabeis.pCarregaPlanoContabilCredito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strTplaco: string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    end;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
  end
  else
  begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaCredito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]);
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pCarregaPlanoContabilDebito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strTplaco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    end;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
  end
  else
  begin
    strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pCarregarDados(const AAutoInc: string; const ATipoPesquisa: TPesquisaLancamentoContabil; const AUsarNumLot: boolean = False);
var
  qryDados: TUniQuery ;
  LLote: string;
  LblnSubCnt: Boolean;
begin
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  pLimparCampos(True);
  pLimparGrid ;
  pSetModoLote(ATipoPesquisa) ;
  qryDados := fCriaQuery() ;
  try
    case ATipoPesquisa of
      plcLancon:
      begin
        qryDados.Close ;
        qryDados.SQL.Clear ;
        qryDados.SQL.Add(' SELECT LANCON.AUTOINCREM, ') ;
        qryDados.SQL.Add(' LANCON.CON_EMPLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_DTALAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_TIPLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_CLAFIS, ') ;
        qryDados.SQL.Add(' LANCON.CON_NATOPE, ') ;
        qryDados.SQL.Add(' LANCON.CON_DESVAL, ') ;
        qryDados.SQL.Add(' LANCON.CON_CONCRE, ') ;
        qryDados.SQL.Add(' LANCON.CON_CONDEB, ') ;
        qryDados.SQL.Add(' LANCON.CON_HISPAD, ') ;
        qryDados.SQL.Add(' REPLACE(UPPER(COALESCE(CON_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ') ;
        qryDados.SQL.Add(' LANCON.CON_VALLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_AUTOMA, ') ;
        qryDados.SQL.Add(' LANCON.CON_CCUSTO, ') ;
        qryDados.SQL.Add(' LANCON.CON_CODOPE, ') ;
        qryDados.SQL.Add(' LANCON.CON_INCDOC, ') ;
        qryDados.SQL.Add(' LANCON.CON_C_G_C_, ') ;
        qryDados.SQL.Add(' LANCON.CON_CCUSCR, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LANCON.', 'CAST(NULL AS CHAR(1)) AS ') + 'CON_CLIFOR, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LANCON.', 'CAST(NULL AS CHAR(1)) AS ') + 'CON_TIP_FC, ') ;
        qryDados.SQL.Add(' ' + ifthen(blnExisteCampoCON_AUTMOD, 'LANCON.', 'CAST("N" AS CHAR(1)) AS ') + 'CON_AUTMOD, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_NUMLOT  ') ;
        qryDados.SQL.Add(' FROM LANCON LEFT JOIN HISPAD ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO ') ;
        qryDados.SQL.Add('      LEFT JOIN LO2LAN ON LANCON.AUTOINCREM = LO2LAN.LAN_CODLAN ') ;
        qryDados.SQL.Add(' WHERE LANCON.AUTOINCREM = :AUTOINCREM ') ;
        qryDados.ParamByName('AUTOINCREM').AsString := AAutoInc ;
        qryDados.Open ;
        qryDados.First ;
        ////atualiza os campos
        mskDtaLan.Date := qryDados.FieldByName('CON_DTALAN').AsDateTime ;
        edtEmpLan.Text := qryDados.FieldByName('CON_EMPLAN').AsString ;
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtEmpLan.Text);
        edtTipLan.ItemIndex := fIndexTipLan(qryDados.FieldByName('CON_TIPLAN').AsString) ;

        mskContaDebito.Text := qryDados.FieldByName('CON_CONDEB').AsString;
        edtDesContaDebito.Text := fCarregaDescricaoConta(mskContaDebito.Text, edtEmpLan.Text) ;
        edtConDebRed.Text := fCarregaContaReduzida(mskContaDebito.Text, edtEmpLan.Text) ;
        pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;

        mskContaCredito.Text := qryDados.FieldByName('CON_CONCRE').AsString;
        edtDesContaCRedito.Text := fCarregaDescricaoConta(mskContaCredito.Text, edtEmpLan.Text) ;
        edtConCreRed.Text := fCarregaContaReduzida(mskContaCredito.Text, edtEmpLan.Text) ;
        pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;

        edtValor.Value := qryDados.FieldByName('CON_VALLAN').AsFloat ;
        edtHistor.Text := qryDados.FieldByName('CON_HISTOR').AsString ;

        edtCCustoDebito.Text := qryDados.FieldByName('CON_CCUSTO').AsString ;
        edtDesCCustoDebito.Text := fCarregaCentroCusto(edtCCustoDebito.Text) ;

        edtCCustoCredito.Text := qryDados.FieldByName('CON_CCUSCR').AsString ;
        edtDesCCustoCredito.Text :=  fCarregaCentroCusto(edtCCustoCredito.Text);

        edtHisPad.Text := qryDados.FieldByName('CON_HISPAD').AsString;
        edtDesHistPadrao.Text := fCarregaHistoricoPadrao(edtHisPad.Text);
        edtOpeLan.Text := qryDados.FieldByName('CON_CODOPE').AsString ;
        edtNomOpe.Text := fCarregaDescricaoOperador(edtOpeLan.Text) ;
        edtAutoma.Checked := iif(qryDados.FieldByName('CON_AUTOMA').AsInteger = 1, True, False) ;
        pAtualizaCheckBoxAutomaticoModificado(qryDados) ;
        edtTipLan.ItemIndex := fIndexTipLan(qryDados.FieldByName('CON_TIPLAN').AsString) ;
        edtIncDoc.Text := qryDados.FieldByName('CON_INCDOC').AsString ;
        FControleLancSemLote.conta_credito := (not fEmptyStr(qryDados.FieldByName('CON_CONCRE').AsString)) ;
        FControleLancSemLote.conta_debito := (not fEmptyStr(qryDados.FieldByName('CON_CONDEB').AsString)) ;

        if (qryDados.FieldByName('CON_AUTOMA').AsString = '1') and (edtTipLan.ItemIndex = -1) then
          edtTipLan.ItemIndex := fIndexTipLan('MAN') ;

        if edtCodCliForSubcontaDebito.Visible then
        begin
          edtOpcSubcontaDebito.Text := qryDados.FieldByName('CON_TIP_FC').AsString ;
          edtCodCliForSubcontaDebito.Text := qryDados.FieldByName('CON_CLIFOR').AsString ;
          edtNomCliForSubcontaDebito.Text := fCarregaCliForBD(edtCodCliForSubcontaDebito.Text, edtOpcSubcontaDebito.Text) ;
        end
        else if edtCodCliForSubcontaCredito.Visible then
        begin
          edtOpcSubcontaCredito.Text := qryDados.FieldByName('CON_TIP_FC').AsString ;
          edtCodCliForSubcontaCredito.Text := qryDados.FieldByName('CON_CLIFOR').AsString ;
          edtNomCliForSubcontaCredito.Text := fCarregaCliForBD(edtCodCliForSubcontaCredito.Text, edtOpcSubcontaCredito.Text) ;
        end
        else
        begin
          edtOpcSubcontaDebito.Clear ;
          edtCodCliForSubcontaDebito.Clear ;
          edtNomCliForSubcontaDebito.Clear ;
          edtOpcSubcontaCredito.Clear ;
          edtCodCliForSubcontaCredito.Clear ;
          edtNomCliForSubcontaCredito.Clear ;
        end ;
      end ;
      plcLote, plcLoteLancado:
      begin
        ///pesquisa todos os lançamentos do lote
        if ATipoPesquisa = plcLoteLancado then
        begin
          LLote := fCampoTabela('LAN_NUMLOT', 'LO2LAN', ['LAN_CODLAN'], [AAutoInc]) ;
        end
        else /// lote não lançado
        begin
          if AUsarNumLot then
          begin
            LLote := AAutoInc ;
          end
          else
          begin
            LLote := fCampoTabela('LAN_NUMLOT', 'LO2LAN', ['AUTOINCREM'], [AAutoInc]) ;
          end;
        end;

        edtNumLot.Text := LLote ;
        qryDados.Close ;
        qryDados.SQL.Clear ;
        qryDados.SQL.Add('SELECT LANCON.AUTOINCREM, ') ;
        qryDados.SQL.Add(' LANCON.CON_EMPLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_DTALAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_TIPLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_CONCRE, ') ;
        qryDados.SQL.Add(' PLANCR.NCO_DESCRI AS DES_CONCRE, ') ;
        qryDados.SQL.Add(' PLANCR.NCO_CONRED AS RED_CONCRE, ') ;
        qryDados.SQL.Add(' LANCON.CON_CONDEB, ') ;
        qryDados.SQL.Add(' PLANDE.NCO_DESCRI AS DES_CONDEB, ') ;
        qryDados.SQL.Add(' PLANDE.NCO_CONRED AS RED_CONDEB, ') ;
        qryDados.SQL.Add(' LANCON.CON_HISPAD, ') ;
        qryDados.SQL.Add(' HISPAD.PAD_DESCRI AS DES_HISPAD, ') ;
        qryDados.SQL.Add(' REPLACE(UPPER(COALESCE(CON_HISTOR,"")), "<<CSQ>>", "") AS CON_HISTOR, ') ;
        qryDados.SQL.Add(' LANCON.CON_VALLAN, ') ;
        qryDados.SQL.Add(' LANCON.CON_AUTOMA, ') ;
        qryDados.SQL.Add(' LANCON.CON_CCUSTO, ') ;
        qryDados.SQL.Add(' EVEDEB.EVE_DESEVE AS DES_CCUSTO, ') ;
        qryDados.SQL.Add(' LANCON.CON_CODOPE, ') ;
        qryDados.SQL.Add(' LANCON.CON_INCDOC, ') ;
        qryDados.SQL.Add(' LANCON.CON_CCUSCR, ') ;
        qryDados.SQL.Add(' EVECRE.EVE_DESEVE AS DES_CCUSCR, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CODLAN, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LANCON.', 'CAST(NULL AS CHAR(1)) AS ') + 'CON_CLIFOR, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LANCON.', 'CAST(NULL AS CHAR(1)) AS ') + 'CON_TIP_FC, ') ;
        qryDados.SQL.Add(' ' + ifthen(blnExisteCampoCON_AUTMOD, 'LANCON.', 'CAST("N" AS CHAR(1)) AS ') + 'CON_AUTMOD, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_PARMUL ') ;
        qryDados.SQL.Add('FROM LANCON ') ;
        qryDados.SQL.Add('      LEFT JOIN LO2LAN ON LANCON.AUTOINCREM = LO2LAN.LAN_CODLAN ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEMP ON LANCON.CON_EMPLAN = CADEMP.EMP_CODEMP ') ;
        qryDados.SQL.Add('      LEFT JOIN HISPAD ON LANCON.CON_HISPAD = HISPAD.PAD_CODIGO ') ;
        if fCfgHisTpl then
          qryDados.SQL.Add(' AND PAD_TPLACO = EMP_TPLACO ')
        else
          qryDados.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');
        qryDados.SQL.Add('      LEFT JOIN PLANCO AS PLANCR ON LANCON.CON_CONCRE = PLANCR.NCO_CODCON AND PLANCR.NCO_TPLACO = CADEMP.EMP_TPLACO ') ;
        qryDados.SQL.Add('      LEFT JOIN PLANCO AS PLANDE ON LANCON.CON_CONDEB = PLANDE.NCO_CODCON AND PLANDE.NCO_TPLACO = CADEMP.EMP_TPLACO ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEVE AS EVECRE ON LANCON.CON_CCUSCR = EVECRE.EVE_CODEVE ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEVE AS EVEDEB ON LANCON.CON_CCUSTO = EVEDEB.EVE_CODEVE ') ;
        qryDados.SQL.Add('WHERE LO2LAN.LAN_NUMLOT = :NUMLOT ') ;
        qryDados.SQL.Add('UNION ALL ') ;
        qryDados.SQL.Add('SELECT LO2LAN.AUTOINCREM, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_EMPLAN AS CON_EMPLAN, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_DTALAN AS CON_DTALAN, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_TIPLAN AS CON_TIPLAN, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CONCRE AS CON_CONCRE, ') ;
        qryDados.SQL.Add(' PLANCR.NCO_DESCRI AS DES_CONCRE, ') ;
        qryDados.SQL.Add(' PLANCR.NCO_CONRED AS RED_CONCRE, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CONDEB AS CON_CONDEB, ') ;
        qryDados.SQL.Add(' PLANDE.NCO_DESCRI AS DES_CONDEB, ') ;
        qryDados.SQL.Add(' PLANDE.NCO_CONRED AS RED_CONDEB, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_HISPAD AS CON_HISPAD, ') ;
        qryDados.SQL.Add(' HISPAD.PAD_DESCRI AS DES_HISPAD, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_HISTOR AS CON_HISTOR, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_VALLAN AS CON_VALLAN, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_AUTOMA AS CON_AUTOMA, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CCUSTO AS CON_CCUSTO, ') ;
        qryDados.SQL.Add(' EVEDEB.EVE_DESEVE AS DES_CCUSTO, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CODOPE AS CON_CODOPE, ') ;
        qryDados.SQL.Add(' LO2LAN.AUTOINCREM AS CON_INCDOC, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CCUSCR AS CON_CCUSCR, ') ;
        qryDados.SQL.Add(' EVECRE.EVE_DESEVE AS DES_CCUSCR, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_CODLAN, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LO2LAN.LAN_CLIFOR', 'CAST(NULL AS CHAR(1))') + ' AS CON_CLIFOR, ') ;
        qryDados.SQL.Add(' ' + ifthen(LblnSubCnt, 'LO2LAN.LAN_TIP_FC', 'CAST(NULL AS CHAR(1))') + ' AS CON_TIP_FC, ') ;
        qryDados.SQL.Add(' CAST("N" AS CHAR(1)) AS CON_AUTMOD, ') ;
        qryDados.SQL.Add(' LO2LAN.LAN_PARMUL ') ;
        qryDados.SQL.Add('FROM LO2LAN ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEMP ON LAN_EMPLAN = CADEMP.EMP_CODEMP ') ;
        qryDados.SQL.Add('      LEFT JOIN HISPAD ON LAN_HISPAD = HISPAD.PAD_CODIGO ') ;
        if fCfgHisTpl then
          qryDados.SQL.Add(' AND PAD_TPLACO = EMP_TPLACO ')
        else
          qryDados.SQL.Add(' AND IFNULL(PAD_TPLACO, "") = "" ');
        qryDados.SQL.Add('      LEFT JOIN PLANCO AS PLANCR ON LAN_CONCRE = PLANCR.NCO_CODCON AND PLANCR.NCO_TPLACO = CADEMP.EMP_TPLACO ') ;
        qryDados.SQL.Add('      LEFT JOIN PLANCO AS PLANDE ON LAN_CONDEB = PLANDE.NCO_CODCON AND PLANDE.NCO_TPLACO = CADEMP.EMP_TPLACO ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEVE AS EVECRE ON LAN_CCUSCR = EVECRE.EVE_CODEVE ') ;
        qryDados.SQL.Add('      LEFT JOIN CADEVE AS EVEDEB ON LAN_CCUSTO = EVEDEB.EVE_CODEVE ') ;
        qryDados.SQL.Add('WHERE LO2LAN.LAN_NUMLOT = :NUMLOT AND LO2LAN.LAN_CODLAN IS NULL ') ;
        qryDados.ParamByName('NUMLOT').AsString := LLote ;
        qryDados.Open ;
        qryDados.First ;
        ///carrega o cds
        while not qryDados.Eof do
        begin
          CdsDados.Insert;
          CdsDados.FieldByName('CON_PARMUL').AsInteger := qryDados.FieldByName('LAN_PARMUL').AsInteger ;
          CdsDados.FieldByName('CON_MODIFI').AsBoolean := False ;
          CdsDados.FieldByName('CON_DTALAN').AsDateTime := qryDados.FieldByName('CON_DTALAN').AsDateTime ;
          CdsDados.FieldByName('CON_EMPLAN').AsString := qryDados.FieldByName('CON_EMPLAN').AsString ;
          CdsDados.FieldByName('CON_TIPLAN').AsString := qryDados.FieldByName('CON_TIPLAN').AsString ;
          CdsDados.FieldByName('CON_CONDEB').AsString := qryDados.FieldByName('CON_CONDEB').AsString ;
          CdsDados.FieldByName('CON_CONCRE').AsString := qryDados.FieldByName('CON_CONCRE').AsString ;
          CdsDados.FieldByName('CON_VALLAN').AsFloat  := qryDados.FieldByName('CON_VALLAN').AsFloat ;
          CdsDados.FieldByName('CON_HISTOR').AsString := qryDados.FieldByName('CON_HISTOR').AsString ;
          CdsDados.FieldByName('CON_CCUSTO').AsString := qryDados.FieldByName('CON_CCUSTO').AsString ;
          CdsDados.FieldByName('CON_CCUSCR').AsString := qryDados.FieldByName('CON_CCUSCR').AsString ;
          CdsDados.FieldByName('DES_CONDEB').AsString := qryDados.FieldByName('DES_CONDEB').AsString ;
          CdsDados.FieldByName('DES_CONCRE').AsString := qryDados.FieldByName('DES_CONCRE').AsString ;
          CdsDados.FieldByName('DES_CCUSTO').AsString := qryDados.FieldByName('DES_CCUSTO').AsString ;
          CdsDados.FieldByName('DES_CCUSCR').AsString := qryDados.FieldByName('DES_CCUSCR').AsString ;
          CdsDados.FieldByName('CON_HISPAD').AsString := qryDados.FieldByName('CON_HISPAD').AsString ;
          CdsDados.FieldByName('DES_HISPAD').AsString := qryDados.FieldByName('DES_HISPAD').AsString ;
          CdsDados.FieldByName('CON_CODOPE').AsString := qryDados.FieldByName('CON_CODOPE').AsString ;
          CdsDados.FieldByName('CON_AUTOMA').AsInteger := qryDados.FieldByName('CON_AUTOMA').AsInteger ;
          CdsDados.FieldByName('CON_CLIFOR').AsString := qryDados.FieldByName('CON_CLIFOR').AsString ;
          CdsDados.FieldByName('CON_TIP_FC').AsString := qryDados.FieldByName('CON_TIP_FC').AsString ;
          CdsDados.FieldByName('CON_AUTMOD').AsString := qryDados.FieldByName('CON_AUTMOD').AsString ;
          CdsDados.FieldByName('CON_AUTINC').AsString := qryDados.FieldByName('AUTOINCREM').AsString ;
          cdsDados.FieldByName('CON_INCDOC').AsString := qryDados.FieldByName('CON_INCDOC').AsString ;
          CdsDados.Post;
          qryDados.Next ;
        end;
      end;
    end ;
  finally
    FreeAndNil(qryDados) ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pCarregaSugestaoUltimoInsert;
var
  LrecSugestaoVazia: TDadosSugestaoInsertLancamentoContabil ;
begin
  if not FModoInclusao then
    Exit ;

  FillChar(LrecSugestaoVazia, SizeOf(LrecSugestaoVazia), #0) ;

  if CompareMem(@FrecSugestaoProximoInsert,
                @LrecSugestaoVazia,
                SizeOf(TDadosSugestaoInsertLancamentoContabil)) then
    Exit ;

  mskDtaLan.Date := FrecSugestaoProximoInsert.dtaLan ;
  edtEmpLan.Text := FrecSugestaoProximoInsert.strCodEmp ;
  fValidaCampos(edtEmpLan) ;
  edtValor.Value := FrecSugestaoProximoInsert.fltValor ;
  mskContaCredito.Text := FrecSugestaoProximoInsert.strContaCredito ;
  fValidaCampos(mskContaCredito) ;
  mskContaDebito.Text := FrecSugestaoProximoInsert.strContaDebito ;
  fValidaCampos(mskContaDebito) ;
  edtCCustoCredito.Text := FrecSugestaoProximoInsert.strCentroCustoCredito ;
  fValidaCampos(edtCCustoCredito) ;
  edtCCustoDebito.Text := FrecSugestaoProximoInsert.strCentroCustoDebito ;
  fValidaCampos(edtCCustoDebito) ;
  edtHistor.Texto := FrecSugestaoProximoInsert.strComplemento ;
  edtHisPad.Text := FrecSugestaoProximoInsert.strHistoricoPadrao ;
  edtIncDoc.Text := '';
  fValidaCampos(edtHisPad) ;
  edtOpcSubcontaDebito.Text := FrecSugestaoProximoInsert.strTipoFCDebito ;
  edtCodCliForSubcontaDebito.Text := FrecSugestaoProximoInsert.strClienteFornecedorDebito ;
  fValidaCampos(edtCodCliForSubcontaDebito) ;
  edtOpcSubcontaCredito.Text := FrecSugestaoProximoInsert.strTipoFCCredito ;
  edtCodCliForSubcontaCredito.Text := FrecSugestaoProximoInsert.strClienteFornecedorCredito ;
  fValidaCampos(edtCodCliForSubcontaCredito) ;
  edtTipLan.ItemIndex := fIndexTipLan(FrecSugestaoProximoInsert.strTipoLancamento) ;
end;

procedure TfrmLancamentosLotesContabeis.pCarregaTipoContabeisManutencao;
begin
  pCarregaTiposContabeis(edtTipLan, True, True);
  edtTipLan.Items.Add('FEC-Fechamento Contábil');
end;

function TfrmLancamentosLotesContabeis.fCarregarGridParaCampos:boolean;
begin
  result := false ;
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;
  // se for partida multipla, não carrega os valores da grid nos campos
  if cdsDados.FieldByName('CON_PARMUL').AsInteger > 0 then
  begin
    exit ;
  end;

  mskDtaLan.Date := cdsDados.FieldByName('CON_DTALAN').AsDateTime ;
  edtEmpLan.Text := cdsDados.FieldByName('CON_EMPLAN').AsString ;
  edtNomEmp.Text := fRetNomeEmpresaSelec(edtEmpLan.Text);
  edtTipLan.ItemIndex := fIndexTipLan(cdsDados.FieldByName('CON_TIPLAN').AsString) ;

  mskContaDebito.Text := cdsDados.FieldByName('CON_CONDEB').AsString;
  edtDesContaDebito.Text := cdsDados.FieldByName('DES_CONDEB').AsString ;
  pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;

  mskContaCredito.Text := cdsDados.FieldByName('CON_CONCRE').AsString;
  edtDesContaCRedito.Text := cdsDados.FieldByName('DES_CONCRE').AsString ;
  pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;

  if edtCodCliForSubcontaDebito.Visible then
  begin
    edtOpcSubcontaDebito.Text := cdsDados.FieldByName('CON_TIP_FC').AsString ;
    edtCodCliForSubcontaDebito.Text := cdsDados.FieldByName('CON_CLIFOR').AsString ;
    edtNomCliForSubcontaDebito.Text := fCarregaCliForBD(edtCodCliForSubcontaDebito.Text, edtOpcSubcontaDebito.Text) ;
  end
  else if edtCodCliForSubcontaCredito.Visible then
  begin
    edtOpcSubcontaCredito.Text := cdsDados.FieldByName('CON_TIP_FC').AsString ;
    edtCodCliForSubcontaCredito.Text := cdsDados.FieldByName('CON_CLIFOR').AsString ;
    edtNomCliForSubcontaCredito.Text := fCarregaCliForBD(edtCodCliForSubcontaCredito.Text, edtOpcSubcontaCredito.Text) ;
  end
  else
  begin
    edtOpcSubcontaDebito.Clear ;
    edtCodCliForSubcontaDebito.Clear ;
    edtNomCliForSubcontaDebito.Clear ;
    edtOpcSubcontaCredito.Clear ;
    edtCodCliForSubcontaCredito.Clear ;
    edtNomCliForSubcontaCredito.Clear ;
  end ;

  edtValor.Value := cdsDados.FieldByName('CON_VALLAN').AsFloat ;
  edtHistor.Text := cdsDados.FieldByName('CON_HISTOR').AsString ;

  edtCCustoDebito.Text := cdsDados.FieldByName('CON_CCUSTO').AsString ;
  edtDesCCustoDebito.Text := cdsDados.FieldByName('DES_CCUSTO').AsString ;

  edtCCustoCredito.Text := cdsDados.FieldByName('CON_CCUSCR').AsString ;
  edtDesCCustoCredito.Text :=  cdsDados.FieldByName('DES_CCUSCR').AsString ;

  edtHisPad.Text := cdsDados.FieldByName('CON_HISPAD').AsString;
  edtDesHistPadrao.Text := cdsDados.FieldByName('DES_HISPAD').AsString ;
  edtOpeLan.Text := strLoginUsuarioLogado ;
  edtNomOpe.Text := strDescriUsuarioLogado ;
  edtAutoma.Checked := iif(cdsDados.FieldByName('CON_AUTOMA').AsInteger = 1, True, False) ;
  pAtualizaCheckBoxAutomaticoModificado(cdsDados as TDataSet) ;
  edtIncDoc.Text := cdsDados.FieldByName('CON_INCDOC').AsString;
  result := true ;
end;

procedure TfrmLancamentosLotesContabeis.pDeletaLotCon(strNumLot: string);
var
  qryLotCon : TUniQuery;
begin
  qryLotCon := fCriaQueryContabilidade('LO2CON', Self.Name, Self);
  try
    qryLotCon.SQL.Text := 'SELECT * FROM LO2CON WHERE CON_NUMLOT = :NUMLOT';
    qryLotCon.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotCon.Open;

    if not qryLotCon.IsEmpty then
    begin
      qryLotCon.Delete;
    end ;

  finally
    FreeAndNil(qryLotCon);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pDesabilitaCamposLancamentosSemLote(const AHabilitar: boolean);
begin
  if FModoLote then
  begin
    exit ;
  end;

  if not AHabilitar then
  begin
    exit ;
  end;

  if fIsPartidaSimples then
  begin
    if not FControleLancSemLote.conta_credito then
    begin
      mskContaCredito.Enabled := False ;
      edtConCreRed.Enabled := False ;
      edtCCustoCredito.Enabled := False ;
    end;

    if not FControleLancSemLote.conta_debito then
    begin
      mskContaDebito.Enabled := False ;
      edtConDebRed.Enabled := False ;
      edtCCustoDebito.Enabled := False ;
    end;

    edtEmpLan.Enabled := False ;
    mskDtaLan.Enabled := False ;
    edtValor.Enabled := False ;
  end;
  edtTipLan.Enabled := False ;

end;

procedure TfrmLancamentosLotesContabeis.pDesabilitarCampos;
begin
  edtCCustoCredito.Enabled := blnExisteCampoCON_CCUSCR ;
  edtCCustoDebito.Enabled := blnExisteCampoCON_CCUSTO ;
end;

procedure TfrmLancamentosLotesContabeis.pDesativaCentroCustoCredito(
  const AContaContabil: string);
var
  LPatrim: string ;
  strTplaco: string ;
begin
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;
  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;
  strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  LPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AContaContabil), strTplaco]) ;
  if LPatrim = 'S' then
  begin
    edtCCustoCredito.Enabled := False ;
    edtCCustoCredito.Clear ;
    edtDesCCustoCredito.Clear ;
  end;

  if LPatrim = 'N' then
  begin
    if blnExisteCampoCON_CCUSTO then
    begin
      edtCCustoCredito.Enabled := True ;
    end;
  end;

end;

procedure TfrmLancamentosLotesContabeis.pDesativaCentroCustoDebito(
  const AContaContabil: string);
var
  LPatrim: string ;
  strTplaco: string ;
begin
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;

  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;
  strTplaco := fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  LPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AContaContabil), strTplaco]) ;
  if LPatrim = 'S' then
  begin
    edtCCustoDebito.Enabled := False ;
    edtCCustoDebito.Clear ;
    edtDesCCustoDebito.Clear ;
  end;

  if LPatrim = 'N' then
  begin
    edtCCustoDebito.Enabled := True ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pGravaLotCon(strNumLot: string);
var
  qryLotCon : TUniQuery;
begin
  qryLotCon := fCriaQueryContabilidade('LO2CON', Self.Name, Self);
  try
    qryLotCon.SQL.Text := 'SELECT * FROM LO2CON WHERE FALSE';
    qryLotCon.Open;
    qryLotCon.Insert;
    qryLotCon.FieldByName('CON_NUMLOT').AsString := strNumLot;
    qryLotCon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LO2CON', VS_strCodEmp);
    qryLotCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
    qryLotCon.FieldByName('CON_DTALAN').AsDateTime := VS_Date;
    qryLotCon.Post;
  finally
    FreeAndNil(qryLotCon);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pGravaLotLan(strNumLot: string;
  pgbProgresso: TcxProgressBar);
var
  qryLotLan : TUniQuery;
  LblnSubCnt : Boolean ;
begin
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  qryLotLan := fCriaQueryContabilidade('LO2LAN', Self.Name, Self);
  try
    qryLotLan.SQL.Text := 'SELECT * FROM LO2LAN WHERE FALSE';
    qryLotLan.Open;

    if Assigned(pgbProgresso) then
      pgbProgresso.Properties.Max := cdsDados.RecordCount;

    cdsDados.First;
    while not cdsDados.Eof do
    begin
      if Assigned(pgbProgresso) then
      begin
        pgbProgresso.Position := cdsDados.RecNo;
        Application.ProcessMessages;
      end;

      qryLotLan.Insert;
      qryLotLan.FieldByName('LAN_NUMLOT').AsString := strNumLot;
      qryLotLan.FieldByName('LAN_EMPLAN').AsString := cdsDados.FieldByName('CON_EMPLAN').AsString;
      qryLotLan.FieldByName('LAN_DTALAN').AsDateTime := cdsDados.FieldByName('CON_DTALAN').AsDateTime;

      if not fEmptyStr(cdsDados.FieldByName('CON_CONDEB').AsString) then
        qryLotLan.FieldByName('LAN_CONDEB').AsString := cdsDados.FieldByName('CON_CONDEB').AsString;

      if not fEmptystr(cdsDados.FieldByName('CON_CONCRE').AsString) then
        qryLotLan.FieldByName('LAN_CONCRE').AsString := cdsDados.FieldByName('CON_CONCRE').AsString;

      if not fEmptyStr(cdsDados.FieldByName('CON_CCUSTO').AsString) then
        qryLotLan.FieldByName('LAN_CCUSTO').AsString := cdsDados.FieldByName('CON_CCUSTO').AsString;

      if not fEmptyStr(cdsDados.FieldByName('CON_CCUSCR').AsString) then
        qryLotLan.FieldByName('LAN_CCUSCR').AsString := cdsDados.FieldByName('CON_CCUSCR').AsString;

      qryLotLan.FieldByName('LAN_HISTOR').AsString := cdsDados.FieldByName('CON_HISTOR').AsString;
      qryLotLan.FieldByName('LAN_VALLAN').AsFloat := cdsDados.FieldByName('CON_VALLAN').AsFloat;
      qryLotLan.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LO2LAN', VS_strCodEmp);
      qryLotLan.FieldByName('LAN_PARMUL').AsInteger := cdsDados.FieldByName('CON_PARMUL').AsInteger;
      qryLotLan.FieldByName('LAN_HISPAD').AsString := cdsDados.FieldByName('CON_HISPAD').AsString;
      qryLotLan.FieldByName('LAN_TIPLAN').AsString := cdsDados.FieldByName('CON_TIPLAN').AsString;
      qryLotLan.FieldByName('LAN_AUTOMA').AsInteger := cdsDados.FieldByName('CON_AUTOMA').AsInteger;
      qryLotLan.FieldByName('LAN_CODOPE').AsString := cdsDados.FieldByName('CON_CODOPE').AsString;
      if LblnSubCnt then
      begin
        qryLotLan.FieldByName('LAN_CLIFOR').AsString := cdsDados.FieldByName('CON_CLIFOR').AsString;
        qryLotLan.FieldByName('LAN_TIP_FC').AsString := cdsDados.FieldByName('CON_TIP_FC').AsString;
      end ;
      qryLotLan.Post;

      cdsDados.Edit;
      cdsDados.FieldByName('CON_INCDOC').AsString := qryLotLan.FieldByName('AUTOINCREM').AsString;
      cdsDados.Post;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(qryLotLan);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pHabilitaControles(
  const AHabilitar: boolean; const ALote: boolean=False);
begin
  /// campos
  edtEmpLan.Enabled := AHabilitar ;
  mskDtaLan.Enabled := AHabilitar ;
  mskContaDebito.Enabled := AHabilitar ;
  edtConDebRed.Enabled := AHabilitar ;
  edtCCustoDebito.Enabled := AHabilitar ;
  edtOpcSubcontaDebito.Enabled := AHabilitar ;
  edtCodCliForSubcontaDebito.Enabled := AHabilitar ;
  mskContaCredito.Enabled := AHabilitar ;
  edtConCreRed.Enabled := AHabilitar ;
  edtCCustoCredito.Enabled := AHabilitar ;
  edtOpcSubcontaCredito.Enabled := AHabilitar ;
  edtCodCliForSubcontaCredito.Enabled := AHabilitar ;
  edtValor.Enabled := AHabilitar ;
  edtHisPad.Enabled := AHabilitar ;
  edtHistor.Enabled := AHabilitar ;
  edtTipLan.Enabled := AHabilitar ;
  edtIncDoc.Enabled := AHabilitar ;
  /// botões
  btnIncluir.Enabled := not AHabilitar ;
  btnGravar.Enabled := AHabilitar ;
  btnAlterar.Enabled := not AHabilitar ;
  btnExcluir.Enabled := not AHabilitar ;
  btnCancela.Enabled := AHabilitar ;
  btnSairModulo.Enabled := not AHabilitar ;
  GridCitel.Enabled := not AHabilitar ;
  btnPeriodicos.Enabled := not AHabilitar ;
  bntInfoLancamento.Enabled := not AHabilitar ;

  if AHabilitar then
  begin
    pDesabilitarCampos ;
  end;

  ///essa função deve ficar sempre no final.
  pDesabilitaCamposLancamentosSemLote(AHabilitar) ;
end;

function TfrmLancamentosLotesContabeis.fCriaCdsDados(blnCriaSoma: boolean = false): TUniClientDataSet;
var
  LField : TFieldDef ;
begin
  Result := TUniClientDataSet.Create(Self);

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'AUTOINCREM';
  LField.DataType := ftAutoInc;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_PARMUL';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_DTALAN';
  LField.DataType := ftDate;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_INCDOC';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_EMPLAN';
  LField.DataType := ftString;
  LField.Size     := 3;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CONCRE';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_VALLAN';
  LField.DataType := ftFloat;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_HISTOR';
  LField.DataType := ftString;
  LField.Size     := 400;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 5;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CCUSCR';
  LField.DataType := ftString;
  LField.Size     := 5;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CCUSCR';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CONCRE';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_HISPAD';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_HISPAD';
  LField.DataType := ftString;
  LField.Size     := 200;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_AUTOMA';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_CODOPE';
  LField.DataType := ftString;
  LField.Size     := 3;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_TIPLAN';
  LField.DataType := ftString;
  LField.Size     := 3;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_MODIFI';
  LField.DataType := ftBoolean;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_CLIFOR';
  LField.DataType := ftString;
  LField.Size     := 8;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_TIP_FC';
  LField.DataType := ftString;
  LField.Size     := 1;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_AUTMOD';
  LField.DataType := ftString;
  LField.Size     := 1;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_AUTINC';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  /// CON_CODOPE

  Result.IndexFieldNames := 'CON_DTALAN';
  Result.CreateDataSet;

  if (blnCriaSoma) then
  begin
    Result.AggregatesActive := True;
    Result.Close;
    pCriaAggregate(Result, 'CON_VALLAN', 'TOT_VALLAN');
    Result.Open;
  end;

  TFloatField(Result.FieldByName('CON_VALLAN')).DisplayFormat := '##,#0.00';
  Result.FieldByName('CON_CONDEB').EditMask := fMskCon;
  Result.FieldByName('CON_CONCRE').EditMask := fMskCon;
end;

function TfrmLancamentosLotesContabeis.fDeletaDadosGeradosPorOutraEmpresa(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LstrOrigem: string ;
  LstrIncDoc: string ;
  LarrIncDoc: TArrIncDoc ;
begin
  result := True ;
  /// busca o autoincrem original
  LstrOrigem := VarTostr(fCampoTabela('CNT_ORIGEM', 'LANCNT', ['CNT_ORIGEM'], [edtAutoInc.Text], False)) ;
  if fEmptyStr(LstrOrigem) then
  begin
    LstrOrigem := VarToStr(fCampoTabela('CNT_ORIGEM', 'LANCNT', ['CNT_CONTRO'], [edtAutoInc.Text], False)) ;
  end ;

  if not fEmptyStr(LstrOrigem) then
  begin
    LstrIncDoc := VarToStr(fCampoTabela('CON_INCDOC', 'LANCON', ['AUTOINCREM'], [LstrOrigem], False))  ;
    SetLength(LarrIncDoc, 0);
    result := fDeletaLacamentosGeradosParaOutraEmpresaExec(Default(TDateTime),
                                                              Default(TDateTime),
                                                              '',
                                                              LstrIncDoc,
                                                              LarrIncDoc,
                                                              pSetaTextoProgresso,
                                                              pgbProgresso,
                                                              0.00,
                                                              '',
                                                              '',
                                                              '',
                                                              copy(edtTipLan.Text, 1, 3));
  end ;
end;

function TfrmLancamentosLotesContabeis.fDescricaoPeriodico(
  var AstrDescri: string): boolean;
var
  LfrmInputDialog: TfrmInputDialog ;
begin
  result := False ;
  pCriarFormularios(TfrmInputDialog, LfrmInputDialog);
  Try
    LfrmInputDialog.Caption := 'Descrição do periódico';
    LfrmInputDialog.lblPrompt.Caption := 'Digite a descrição do periódico';
    LfrmInputDialog.ShowModal;

    If LfrmInputDialog.ModalResult <> mrOK Then
      Exit;

    If fEmptyStr(LfrmInputDialog.edtValue.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'Você precisa digitar a descrição do periódico!', ['&Ok']);
      Exit;
    End;

    AstrDescri := LfrmInputDialog.edtValue.Text;
    result := True ;
  Finally
    FreeAndNil(LfrmInputDialog);
  End;
end;

function TfrmLancamentosLotesContabeis.fExcluirLancamento(
  const AAutoInc: string): boolean;
var
  LqryExec: TUniQuery ;
  LarrAutoInc: Tarray<string>;
  Lindice: integer;

begin
  Result := False ;
  if not fValidacaoPrimariaAlteracao(AAutoInc) then
  begin
    exit ;
  end;

  if not fValidouOperacao then
    exit;

  LqryExec := fCriaQuery ;
  try
    SetLength(LarrAutoInc, 0);
    if fEhExclusaoLancamentoPartidaSimples(AAutoInc, LarrAutoInc, LqryExec) then
    begin
      if (fMensagem('AVISO', 'Esse Lançamento foi efetuado por Partida Simples, e possui Lançamentos dependentes, que também serão EXCLUÍDOS. Deseja visualizar os Lançamentos?', ['&Sim', '&Não']) = 1) then
      begin
        pMostraLancamentosDependentesDaPartidaSimples(LqryExec);
      end;
      if (fMensagem('AVISO', 'Confirma a EXCLUSÃO do Lançamento e de todos os seus Lançamentos dependentes?', ['&Sim', '&Não']) = 2) then
        Exit;
    end
    else
      if (fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 2) then
        Exit;

  finally
    FreeAndNil(LqryExec) ;
  end;

  fStartTransaction();
  try
    if copy(edtTipLan.Text,1,3) = 'CTR' then
    begin
      FlblGravando := Nil ;
      try
        fChamaTelaGravando(fDeletaDadosGeradosPorOutraEmpresa) ;
      finally
        FlblGravando := Nil ;
      end ;
    end ;

    LqryExec := fCriaQueryContabilidade('LANCON', Self.Name, Self);
    try
      if Length(LarrAutoInc) = 0 then
      begin
        SetLength(LarrAutoInc, 1);
        LarrAutoInc[0] := AAutoInc;
      end;

      LqryExec.SQL.Text := 'SELECT * FROM LANCON WHERE AUTOINCREM = :AUTOINCREM' ;

      for Lindice := low(LarrAutoInc) to high(LarrAutoInc) do
      begin
        LqryExec.Close;
        LqryExec.ParamByName('AUTOINCREM').AsString := LarrAutoInc[Lindice];
        LqryExec.Open ;

        if not LqryExec.IsEmpty then
          LqryExec.Delete ;
      end;

    finally
      FreeAndNil(LqryExec) ;
    end;

    fCommit();
  Except
    On E: Exception Do
    begin
      fRollBack();
      pMensagensErro(E.Message, 'TfrmLancamentosLotesContabeis.fExcluirLancamento');
    end ;
  End;

  Result := True ;
end;

procedure TfrmLancamentosLotesContabeis.pEhCreditoComSubConta(const AstrConta,
  AstrEmpLan: String; const AblnAtualizaControlesVisuais: Boolean = True);
var
  LstrConta: String ;
  LstrTplaco: String ;
  LstrSubConta: String ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  LstrTplaco := fRetTplacoEmpresaLogada(AstrEmpLan) ;
  LstrConta := fSemMascaraPlaNco(AstrConta) ;

  LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LstrConta, LstrTplaco], False) ;

  if AblnAtualizaControlesVisuais then
    CreditoComSubconta := LstrSubConta = 'S'
  else
    FblnCreditoComSubconta := LstrSubConta = 'S' ;
end;

procedure TfrmLancamentosLotesContabeis.pEhDebitoComSubConta(
  const AstrConta, AstrEmpLan: String; const AblnAtualizaControlesVisuais: Boolean = True);
var
  LstrConta: String ;
  LstrTplaco: String ;
  LstrSubConta: String ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  LstrTplaco := fRetTplacoEmpresaLogada(AstrEmpLan) ;
  LstrConta := fSemMascaraPlaNco(AstrConta) ;

  LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LstrConta, LstrTplaco], False) ;

  if AblnAtualizaControlesVisuais then
    DebitoComSubconta := LstrSubConta = 'S'
  else
    FblnDebitoComSubconta := LstrSubConta = 'S' ;
end;

procedure TfrmLancamentosLotesContabeis.pExcluirLote;
begin
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  if fEmptyStr(edtNumLot.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Lote não informado!', ['&OK']);
    exit;
  end;

  if fLoteFechado(edtNumLot.Text) then
  begin
    exit;
  end;

  if (fMensagem('', 'Deseja excluir o lote "' + edtNumLot.Text + '"?', ['&Sim', '&Não'], 2) = 1) then
  begin
    pDeletaLotCon(edtNumLot.Text);
    pLimparCampos(True);
    pLimparGrid;
    edtNumLot.Clear;
    pSetModoLote(plcLancon, True) ;
    pHabilitaControles(False, True) ;
    fMensagem('ATENÇÃO!', 'Lote excluido com sucesso!', ['&OK']);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pExcluirLoteLancamento;
var
  LfrmExclusaoLanctoContabil: TfrmExclusaoLanctoContabil ;
begin
  pCriarFormularios(TfrmExclusaoLanctoContabil, LfrmExclusaoLanctoContabil) ;
  try
    LfrmExclusaoLanctoContabil.ShowModal ;
  finally
    pFreeAndNil(LfrmExclusaoLanctoContabil);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pFormBeginUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(False), 0);
end;

procedure TfrmLancamentosLotesContabeis.pFormEndUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(True), 0);
  RedrawWindow(Self.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

function TfrmLancamentosLotesContabeis.fEmEdicao: boolean;
var
  cdsAux: TUniClientDataSet ;
  blnFlag: boolean ;
begin
  result := True ;

  if btnGravar.Enabled then
  begin
    exit ;
  end;

  ///verifica foi incluido ou alterado
  cdsAux := TUniClientDataSet.Create(Nil) ;
  try
    blnFlag := False ;
    cdsAux.Data := cdsDados.Data;
    cdsAux.First ;
    while not cdsAux.Eof do
    begin
      if cdsAux.FieldByName('CON_MODIFI').AsBoolean then
      begin
        blnFlag := True ;
        Break ;
      end;
      cdsAux.Next ;
    end;
  finally
    FreeAndNil(cdsAux) ;
  end;

  result := blnFlag ;
end;

function TfrmLancamentosLotesContabeis.fExcluirItemLote: boolean;
begin
  result := False ;
  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  if fLoteFechado(edtNumLot.Text) then
  begin
    exit;
  end;

  if fAlterarLotePartidaMultipla then
  begin
    exit ;
  end;

  if (fMensagem('', 'Deseja excluir o lançamento?', ['&Sim', '&Não'], 2) = 1) then
  begin
    result := True ;
    cdsDados.Delete ;
    fMensagem('ATENÇÃO!', 'Lançamento excluido com sucesso!', ['&OK']);
  end;
end;

function TfrmLancamentosLotesContabeis.fIncluirLancamentoPeriodico: boolean;
var
  LstrDescri: string ;
  LobjCapa: TPeriodicoCapa ;
  LlstDetalhe: TPeriodicosDetalhe ;
  LstrAutoInc: string ;
begin
  result := False ;
  if not fDescricaoPeriodico(LstrDescri) then
    exit ;

  LobjCapa := TPeriodicoCapa.Create ;
  LlstDetalhe := Nil ;
  try
    LobjCapa.Descri := LstrDescri ;
    LobjCapa.Codope := strLoginUsuarioLogado ;
    LobjCapa.Dtaalt := VS_Date ;
    LobjCapa.Hraalt := TimeToStr(fTime()) ;
    LstrAutoInc := TDadosPeriodicoCapa.fInsereDados(LobjCapa) ;

    LlstDetalhe := fLancamentosPeriodicoDet(LstrAutoInc) ;

    result := TDadosPeriodicoDetalhe.fInsereDados(LlstDetalhe) ;
  finally
    FreeAndNil(LobjCapa);
    if Assigned(LlstDetalhe) then
      FreeAndNil(LlstDetalhe);
  end ;

end;

function TfrmLancamentosLotesContabeis.fIndexTipLan(
  const ATipLan: string): integer;
var
  intCnt: integer ;
begin
  result := -1 ;
  for intCnt := 0 to edtTipLan.Items.Count -1 do
  begin
    if copy(edtTipLan.Items.Strings[intCnt], 1, 3) = copy(ATipLan, 1, 3) then
    begin
      result := intCnt ;
      break ;
    end;
  end;
end;

function TfrmLancamentosLotesContabeis.fLoteEfetivado(
  const ANumLot: string): boolean;
var
  qryAux: TUniQuery ;
begin
  result := False ;
  qryAux := fCriaQuery() ;
  try
    qryAux.SQL.Text := 'SELECT CON_DTAFEC FROM LO2CON WHERE CON_NUMLOT = :NUMLOT AND CON_DTAFEC IS NULL ' ;
    qryAux.ParamByName('NUMLOT').AsString := ANumLot ;
    qryAux.Open ;
    if not qryAux.IsEmpty then
    begin
      exit ;
    end;
  finally
    FreeAndNil(qryAux) ;
  end;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fLoteFechado(const ANumLot: string): boolean;
var
  qryLotCon : TUniQuery;
begin
  result := False ;
  if fEmptyStr(ANumLot) then
  begin
    exit ;
  end;

  qryLotCon := fCriaQUery(Self);
  try
    qryLotCon.SQL.Text := 'SELECT CON_DTAFEC FROM LO2CON WHERE CON_NUMLOT = :NUMLOT';
    qryLotCon.ParamByName('NUMLOT').AsString := ANumLot;
    qryLotCon.Open;

    if not qryLotCon.IsEmpty then
      Result := not qryLotCon.FieldByName('CON_DTAFEC').IsNull
    else
      Result := False;

    if Result then
      fMensagem('ATENÇÃO!', 'Lote já foi fechado, não permite mais alterações!', ['&OK']);
  finally
    FreeAndNil(qryLotCon);
  end;
end;

procedure TfrmLancamentosLotesContabeis.pLiberaPlancoVigencia;
begin
  if not FValidarVigenciaCta then
  begin
    exit ;
  end;

  if assigned(cdsPlancoVigencia) then
    FreeAndNil(cdsPlancoVigencia);
end;

procedure TfrmLancamentosLotesContabeis.pLimparCampos(
  const AZeraParMul: boolean);
begin
  edtAutoInc.Clear ;
  mskDtaLan.Clear ;
  edtEmpLan.Clear ;
  edtNomEmp.Clear ;
  mskContaCredito.Clear ;
  edtConCreRed.Clear ;
  edtDesContaCredito.Clear ;
  mskContaDebito.Clear ;
  edtConDebRed.Clear ;
  edtDesContaDebito.Clear ;
  edtValor.Clear ;
  edtHistor.Clear ;
  edtCCustoDebito.Clear ;
  edtDesCCustoDebito.Clear ;
  edtCCustoCredito.Clear;
  edtDesCCustoCredito.Clear ;
  edtHisPad.Clear ;
  edtDesHistPadrao.Clear ;
  edtAutoma.Checked := False ;
  edtAutomaticoModificado.Checked := False ;
  edtOpcSubcontaDebito.Clear ;
  edtCodCliForSubcontaDebito.Clear ;
  edtOpcSubcontaCredito.Clear ;
  edtCodCliForSubcontaCredito.Clear ;
  if AZeraParMul then
  begin
    FNumParMul := 0 ;
    edtNumLot.Clear ;
  end;
  DebitoComSubconta := False ;
  CreditoComSubconta := False ;
  pValorCampoPadrao ;
  edtIncDoc.Clear;
end;

procedure TfrmLancamentosLotesContabeis.pLimparGrid;
begin
  cdsDados.EmptyDataSet ;
  cdsDados.Close ;
  cdsDados.Open ;
end;

procedure TfrmLancamentosLotesContabeis.pMensagemCodigoUltimoLote(
  const AAutoInc: string);
begin
  lblUltimoLoteGerado.Left := lblNumLot.Left ;
  if fEmptyStr(AAutoInc) then
  begin
    lblUltimoLoteGerado.Caption := AAutoInc ;
    lblUltimoLoteGerado.Visible := False ;
  end
  else
  begin
    lblUltimoLoteGerado.Caption := 'Último lote alterado: ' + AAutoInc ;
    lblUltimoLoteGerado.Visible := True ;
    lblNumLot.Visible := False ;
    edtNumLot.Visible := False ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pMostraColunasSubConta(
  const AblnMostrar: Boolean);
begin
  GridCitelTableViewCON_TIP_FC.Visible := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.Visible := AblnMostrar ;

  GridCitelTableViewCON_TIP_FC.VisibleForCustomization := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.VisibleForCustomization := AblnMostrar ;
end;

procedure TfrmLancamentosLotesContabeis.pMostraInfoAlteracaoInclusao;
var
  LstrAutoIncLancon: String ;
  LqryDados: TUniQuery ;
  LstrMensagem: String ;
begin
  LstrAutoIncLancon := fRetornaAutoIncremLancon ;
  if fEmptyStr(LstrAutoIncLancon) then
  begin
    fMensagem('', 'Lote não lançado na LANCON!', ['&OK']);
    Exit;
  end ;

  LqryDados := fCriaQuery() ;
  try
    LqryDados.Close ;
    LqryDados.SQL.Clear ;
    LqryDados.SQL.Add('SELECT CON_CODOPE, CON_TT_ULT FROM LANCON WHERE AUTOINCREM = :AUTOINCREM') ;
    LqryDados.ParamByName('AUTOINCREM').AsString := LstrAutoIncLancon ;
    LqryDados.Open ;

    LstrMensagem := 'Data última modificação: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LqryDados.FieldByName('CON_TT_ULT').AsDateTime) + #13#10 ;
    LstrMensagem := LstrMensagem + 'Operador: ' + LqryDados.FieldByName('CON_CODOPE').AsString + ' ' + fCarregaDescricaoOperador(LqryDados.FieldByName('CON_CODOPE').AsString) + #13#10 ;

    LstrMensagem := LstrMensagem + TTransferenciaLancamentosEntreContas.fInfoOperadorTransferencia(LstrAutoIncLancon) ;

    pShowInfo(LstrMensagem) ;

  finally
    FreeAndNil(LqryDados) ;
  end ;

end;

procedure TfrmLancamentosLotesContabeis.pReorganizaEntradaDadosSubContas;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  pReorganizaEntradaDadosSubContasInterno(FblnCreditoComSubconta, FblnDebitoComSubconta) ;
end;

procedure TfrmLancamentosLotesContabeis.pReorganizaEntradaDadosSubContasInterno(
  const AblnCredito, AblnDebito: Boolean);
const
  INT_ESPACAMENTO = 25 ;
var
  LintValor: Integer ;
begin
  pFormBeginUpdate ;
  try
    lbSubcontaDebito.Visible := AblnDebito ;
    edtCodCliForSubcontaDebito.Visible := AblnDebito ;
    edtNomCliForSubcontaDebito.Visible := AblnDebito ;
    edtOpcSubcontaDebito.Visible := AblnDebito ;

    lbSubcontaCredito.Visible := AblnCredito ;
    edtCodCliForSubcontaCredito.Visible := AblnCredito ;
    edtNomCliForSubcontaCredito.Visible := AblnCredito ;
    edtOpcSubcontaCredito.Visible := AblnCredito ;

    pRestauraPosicionamentoSubContasDefault ;
    LintValor := 0 ;

    if not AblnDebito then
    begin
      lbCCustoDebito.Top := lbCCustoDebito.Top - INT_ESPACAMENTO ;
      edtCCustoDebito.Top := edtCCustoDebito.Top - INT_ESPACAMENTO ;
      edtDesCCustoDebito.Top := edtDesCCustoDebito.Top - INT_ESPACAMENTO ;
      lbContaCredito.Top := lbContaCredito.Top - INT_ESPACAMENTO ;
      mskContaCredito.Top := mskContaCredito.Top - INT_ESPACAMENTO ;
      edtConCreRed.Top := edtConCreRed.Top - INT_ESPACAMENTO ;
      edtDesContaCRedito.Top := edtDesContaCRedito.Top - INT_ESPACAMENTO ;
      lbSubcontaCredito.Top := lbSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtOpcSubcontaCredito.Top := edtOpcSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtCodCliForSubcontaCredito.Top := edtCodCliForSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtNomCliForSubcontaCredito.Top := edtNomCliForSubcontaCredito.Top - INT_ESPACAMENTO ;
      lbCCustoCredito.Top := lbCCustoCredito.Top - INT_ESPACAMENTO ;
      edtCCustoCredito.Top := edtCCustoCredito.Top - INT_ESPACAMENTO ;
      edtDesCCustoCredito.Top := edtDesCCustoCredito.Top - INT_ESPACAMENTO ;
      lbValor.Top := lbValor.Top - INT_ESPACAMENTO ;
      edtValor.Top := edtValor.Top - INT_ESPACAMENTO ;
      lbOpeLan.Top := lbOpeLan.Top - INT_ESPACAMENTO ;
      edtOpeLan.Top := edtOpeLan.Top - INT_ESPACAMENTO ;
      edtNomOpe.Top := edtNomOpe.Top - INT_ESPACAMENTO ;
      lbHisPad.Top := lbHisPad.Top - INT_ESPACAMENTO ;
      edtHisPad.Top := edtHisPad.Top - INT_ESPACAMENTO ;
      edtDesHistPadrao.Top := edtDesHistPadrao.Top - INT_ESPACAMENTO ;
      lbHistor.Top := lbHistor.Top - INT_ESPACAMENTO ;
      edtHistor.Top := edtHistor.Top - INT_ESPACAMENTO ;
      lbTipLan.Top := lbTipLan.Top - INT_ESPACAMENTO ;
      edtTipLan.Top := edtTipLan.Top - INT_ESPACAMENTO ;
      edtAutoma.Top := edtAutoma.Top - INT_ESPACAMENTO ;
      edtAutomaticoModificado.Top := edtAutomaticoModificado.Top - INT_ESPACAMENTO ;
      edtIncDoc.Top := edtIncDoc.Top - INT_ESPACAMENTO ;
      lblNumLan.Top := lblNumLan.Top - INT_ESPACAMENTO ;
      LintValor := LintValor + INT_ESPACAMENTO ;
    end ;

    if not AblnCredito then
    begin
      lbCCustoCredito.Top := lbCCustoCredito.Top - INT_ESPACAMENTO ;
      edtCCustoCredito.Top := edtCCustoCredito.Top - INT_ESPACAMENTO ;
      edtDesCCustoCredito.Top := edtDesCCustoCredito.Top - INT_ESPACAMENTO ;
      lbValor.Top := lbValor.Top - INT_ESPACAMENTO ;
      edtValor.Top := edtValor.Top - INT_ESPACAMENTO ;
      lbOpeLan.Top := lbOpeLan.Top - INT_ESPACAMENTO ;
      edtOpeLan.Top := edtOpeLan.Top - INT_ESPACAMENTO ;
      edtNomOpe.Top := edtNomOpe.Top - INT_ESPACAMENTO ;
      lbHisPad.Top := lbHisPad.Top - INT_ESPACAMENTO ;
      edtHisPad.Top := edtHisPad.Top - INT_ESPACAMENTO ;
      edtDesHistPadrao.Top := edtDesHistPadrao.Top - INT_ESPACAMENTO ;
      lbHistor.Top := lbHistor.Top - INT_ESPACAMENTO ;
      edtHistor.Top := edtHistor.Top - INT_ESPACAMENTO ;
      lbTipLan.Top := lbTipLan.Top - INT_ESPACAMENTO ;
      edtTipLan.Top := edtTipLan.Top - INT_ESPACAMENTO ;
      edtAutoma.Top := edtAutoma.Top - INT_ESPACAMENTO ;
      edtAutomaticoModificado.Top := edtAutomaticoModificado.Top - INT_ESPACAMENTO ;
      edtIncDoc.Top := edtIncDoc.Top - INT_ESPACAMENTO ;
      lblNumLan.Top := lblNumLan.Top - INT_ESPACAMENTO ;
      LintValor := LintValor + INT_ESPACAMENTO ;
    end ;

    gbDadosLancamento.Height :=  gbDadosLancamento.Height - LintValor ;
    self.Height :=  self.Height - LintValor ;
  finally
    pFormEndUpdate ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.pRestauraPosicionamentoSubContasDefault;
var
  AprInfoTop: TPair<String,Integer> ;
  Lcmp: TComponent ;
begin
  for AprInfoTop in FdictDefaultTop do
  begin
    Lcmp := self.FindComponent(AprInfoTop.Key) ;
    if Assigned(Lcmp) then
    begin
      TWinControl(Lcmp).Top := AprInfoTop.Value ;
    end ;
  end ;

  if FModoLote then
    Self.Height := FdictDefaultHeight.Items[Self.Name+FORMEXPANDIDO]
  else
    Self.Height := FdictDefaultHeight.Items[Self.Name+FORMRECOLHIDO] ;

  gbDadosLancamento.Height := FdictDefaultHeight.Items[gbDadosLancamento.Name] ;
end;

procedure TfrmLancamentosLotesContabeis.pRetornaDadosCliFor(var AstrCliFor,
  AstrTipo: String);
begin
  if edtCodCliForSubcontaDebito.Visible then
  begin
    AstrCliFor := fRetornaCliFor(edtCodCliForSubcontaDebito) ;
    AstrTipo := fRetornaTipoFC(edtOpcSubcontaDebito) ;
  end
  else if edtCodCliForSubcontaCredito.Visible then
  begin
    AstrCliFor := fRetornaCliFor(edtCodCliForSubcontaCredito) ;
    AstrTipo := fRetornaTipoFC(edtOpcSubcontaCredito) ;
  end
  else
  begin
    AstrCliFor := '' ;
    AstrTipo := '' ;
  end ;
end;

function TfrmLancamentosLotesContabeis.fMovimentaLinha(const Key: Word;
  Sender: TObject):boolean;
begin
  Result := False ;
  if not dbgBuscaConta.Visible then
  begin
    exit ;
  end;
  if key = VK_DOWN then
  begin
    if not qryBusca.Active then
    begin
      exit ;
    end ;
    qryBusca.Next ;
    Result := True ;
  end
  else if key = VK_UP then
  begin
    if not qryBusca.Active then
    begin
      exit ;
    end ;
    qryBusca.Prior ;
    Result := True ;
  end ;
  if Result then
  begin
    if Sender is TMaskEditFocus then
    begin
      TMaskEditFocus(Sender).Text := qryBusca.FieldByName('CODCON').AsString;
    end
    else if Sender is TEditFocus then
    begin
      TMaskEditFocus(Sender).Text := qryBusca.FieldByName('CONRED').AsString;
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pValorCampoPadrao;
begin
  edtEmpLan.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  mskDtaLan.Date := VS_Date ;
  edtOpeLan.Text := strLoginUsuarioLogado ;
  edtNomOpe.Text := strDescriUsuarioLogado ;
  edtTipLan.ItemIndex := edtTipLan.Items.IndexOf(DES_CONTABIL_MANUAL) ;
end;

function TfrmLancamentosLotesContabeis.fLancamentoPartidaMultipla(const AValor: double; const ACodEmp: string; const ADtaLan: TDateTime; const ATipLan, AOpeLan: string; const AAutoma:boolean; var ALancamentos: TList<TrecDadosLote>; var APartida:TrecDadosLote; const AParMul: integer = 0 ):boolean;
var
  LfrmMultLancamentosLotesContabeis : TfrmMultLancamentosLotesContabeis ;
  LCdsDados: TDataSet ;
  recDados : TrecDadosLote ;
  cdsAux: TUniClientDataSet ;
  LNumParMul: integer ;
begin
  result := false ;
  LfrmMultLancamentosLotesContabeis := TfrmMultLancamentosLotesContabeis.Create(Nil) ;
  try
    LfrmMultLancamentosLotesContabeis.HabilitaTipoLancamento := AValor = 0.00 ;
    LfrmMultLancamentosLotesContabeis.ValorLancado := AValor ;
    LfrmMultLancamentosLotesContabeis.CodEmp := ACodEmp ;
    LfrmMultLancamentosLotesContabeis.DtaLan := ADtaLan ;
    ////carrega os lançamentos multipartida para o usuário fazer a edição
    if AParMul <> 0 then
    begin
      cdsAux := TUniClientDataSet.Create(Nil) ;
      try
        cdsAux.Data := cdsDados.Data ;
        cdsAux.Filtered := False ;
        cdsAux.Filter := ' CON_PARMUL = ' + IntToStr(AParMul) ;
        cdsAux.Filtered := True ;
        LfrmMultLancamentosLotesContabeis.pCarregaDadosAlteracao(cdsAux) ;
      finally
        FreeAndNil(cdsAux) ;
      end;
    end;
    LfrmMultLancamentosLotesContabeis.ShowModal ;
    if LfrmMultLancamentosLotesContabeis.blnConfirma then
    begin
      if AParMul = 0 then
      begin
        inc(FNumParMul) ;
        LNumParMul := FNumParMul ;
      end
      else
      begin
        LNumParMul := AParMul ;
      end;

      if (not fEmptyStr(APartida.con_concre)) or (not fEmptyStr(APartida.con_condeb)) then
      begin
        APartida.con_parmul := LNumParMul ;
        ALancamentos.Add(APartida) ;
      end;

      LCdsDados := LfrmMultLancamentosLotesContabeis.dtsDados.DataSet ;
      LCdsDados.First ;
      while not LCdsDados.Eof do
      begin

        recDados.con_dtalan := ADtaLan ;
        recDados.con_emplan := ACodEmp ;
        recDados.con_tiplan := copy(ATipLan,1,3) ;
        ///sempre limpa por causa do IF
        recDados.con_concre := '' ;
        recDados.con_ccusto := '' ;
        recDados.con_condeb := '' ;
        recDados.con_ccuscr := '' ;
        recDados.con_clifor := '' ;
        recDados.con_tip_fc := '' ;
        if Copy(LCdsDados.FieldByName('CON_TIPLAN').AsString,1,1) = 'C' then
        begin
          recDados.con_concre := fSemMascaraPlaNco(LCdsDados.FieldByName('CON_CONDEB').AsString) ;
          recDados.con_ccuscr := LCdsDados.FieldByName('CON_CCUSTO').AsString ;
          recDados.con_clifor := LCdsDados.FieldByName('CON_CLIFOR').AsString ;
          recDados.con_tip_fc := LCdsDados.FieldByName('CON_TIP_FC').AsString ;
        end
        else ///debito
        begin
          recDados.con_condeb := fSemMascaraPlaNco(LCdsDados.FieldByName('CON_CONDEB').AsString) ;
          recDados.con_ccusto := LCdsDados.FieldByName('CON_CCUSTO').AsString ;
          recDados.con_clifor := LCdsDados.FieldByName('CON_CLIFOR').AsString ;
          recDados.con_tip_fc := LCdsDados.FieldByName('CON_TIP_FC').AsString ;
        end;
        recDados.con_vallan := LCdsDados.FieldByName('CON_VALLAN').AsFloat ;
        recDados.con_histor := LCdsDados.FieldByName('CON_HISTOR').AsString ;
        recDados.con_hispad := LCdsDados.FieldByName('CON_HISPAD').AsString ;
        recDados.con_automa := iif(AAutoma, '1', '0') ;
        recDados.con_codope := AOpeLan ;
        recDados.con_parmul := LNumParMul ;
        ALancamentos.Add(recDados) ;

        LCdsDados.Next ;
      end;
      result := True ;
    end;
  finally
    pFreeAndNil(LfrmMultLancamentosLotesContabeis) ;
  end;
end;

function TfrmLancamentosLotesContabeis.fLancamentosPeriodicoDet(const AstrSeqGer: string): TPeriodicosDetalhe;
var
  LdstDados: TDataSet ;
  LobjItem: TPeriodicoDetalhe ;
begin
  result := TPeriodicosDetalhe.Create();

  LdstDados := dsLancamentos.DataSet ;
  LdstDados.DisableControls ;
  try
    LdstDados.First ;
    while not LdstDados.Eof do
    begin
      LobjItem := TPeriodicoDetalhe.Create ;
      LobjItem.Seqger := AstrSeqGer ;
      LobjItem.Seqlan := LdstDados.FieldByName('AUTOINCREM').AsInteger ;
      LobjItem.Emplan := LdstDados.FieldByName('CON_EMPLAN').AsString ;
      LobjItem.Concre := LdstDados.FieldByName('CON_CONCRE').AsString ;
      LobjItem.Condeb := LdstDados.FieldByName('CON_CONDEB').AsString ;
      LobjItem.Ccuscr := LdstDados.FieldByName('CON_CCUSCR').AsString ;
      LobjItem.Ccusto := LdstDados.FieldByName('CON_CCUSTO').AsString ;
      LobjItem.Hispad := LdstDados.FieldByName('CON_HISPAD').AsInteger ;
      LobjItem.Histor := LdstDados.FieldByName('CON_HISTOR').AsString ;
      LobjItem.Tiplan := LdstDados.FieldByName('CON_TIPLAN').AsString ;
      LobjItem.ValLan := LdstDados.FieldByName('CON_VALLAN').AsFloat ;
      LobjItem.Parmul := LdstDados.FieldByName('CON_PARMUL').AsInteger ;
      LobjItem.Clifor := LdstDados.FieldByName('CON_CLIFOR').AsString ;
      LobjItem.Tip_fc := LdstDados.FieldByName('CON_TIP_FC').AsString ;
      result.Add(LobjItem) ;

      LdstDados.Next ;
    end ;
  finally
    LdstDados.EnableControls ;
  end ;

end;

procedure TfrmLancamentosLotesContabeis.pLancaPartidaMultiplaSemValor;
var
  recDados : TrecDadosLote ;
  lstLancamentos : TList<TrecDadosLote> ;
begin
  if not FModoLote then
  begin
    exit ;
  end;
  if FModoInclusao then
  begin
    if (fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) and (fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
    begin
      if edtValor.Value = 0 then
      begin
        if (fMensagem('', 'Deseja informar os lançamentos da partida múltipla?', ['&Sim', '&Não'], 2) = 1) Then
        begin

          recDados.con_emplan := '' ;
          recDados.con_concre := '' ;
          recDados.con_condeb := '' ;
          recDados.con_vallan := 0.00 ;
          recDados.con_histor := '' ;
          recDados.con_ccusto := '' ;
          recDados.con_ccuscr := '' ;
          recDados.con_hispad := '' ;
          recDados.con_automa := '' ;
          recDados.con_codope := '' ;
          recDados.con_clifor := '' ;
          recDados.con_tip_fc := '' ;
          lstLancamentos := TList<TrecDadosLote>.Create ;
          try
            if not fLancamentoPartidaMultipla(edtValor.Value, edtEmpLan.Text, mskDtaLan.Date, edtTipLan.Text, strLoginUsuarioLogado, edtAutoma.Checked, lstLancamentos, recDados) then
            begin
              exit ;
            end;
            pLancar(cdsDados, lstLancamentos, FModoInclusao);

            FModoInclusao := False ;

            pLimparCampos ;

            pHabilitaControles(False, True) ;

            pSetFocus(btnIncluir);

          finally
            FreeAndNil(lstLancamentos) ;
          end;
        end
      end;
    end;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pLancar(var ACdsDados: TUniClientDataSet; const ADados: TList<TrecDadosLote>; const AModoInclusao: boolean; const AParMul: integer = 0);
var
  recDados: TrecDadosLote ;
  strTplaco: string ;
begin
  if AParMul <> 0 then
  begin
    /// apaga para relançar
    ACdsDados.DisableControls ;
    try
      ACdsDados.First ;
      while not ACdsDados.Eof do
      begin
        if ACdsDados.FieldByName('CON_PARMUL').AsInteger = AParMul then
        begin
          ACdsDados.Delete ;
          continue ;
        end;
        ACdsDados.Next ;
      end;
    finally
      ACdsDados.EnableControls ;
    end;
  end;

  for recDados in ADados do
  begin
    if AModoInclusao then
    begin
      ACdsDados.Insert;
      ACdsDados.FieldByName('CON_PARMUL').AsInteger := recDados.con_parmul ;
    end
    else
    begin
      ACdsDados.Edit;
    end;
    ACdsDados.FieldByName('CON_MODIFI').AsBoolean := True ;
    ACdsDados.FieldByName('CON_DTALAN').AsDateTime := recDados.con_dtalan;
    ACdsDados.FieldByName('CON_EMPLAN').AsString := recDados.con_emplan;
    ACdsDados.FieldByName('CON_TIPLAN').AsString := recDados.con_tiplan;
    ACdsDados.FieldByName('CON_CONDEB').AsString := recDados.con_condeb;
    ACdsDados.FieldByName('CON_CLIFOR').AsString := recDados.con_clifor;
    ACdsDados.FieldByName('CON_TIP_FC').AsString := recDados.con_tip_fc;
    ACdsDados.FieldByName('CON_CONCRE').AsString := recDados.con_concre;
    ACdsDados.FieldByName('CON_VALLAN').AsFloat  := recDados.con_vallan;
    ACdsDados.FieldByName('CON_HISTOR').AsString := recDados.con_histor;
    ACdsDados.FieldByName('CON_CCUSTO').AsString := recDados.con_ccusto;
    ACdsDados.FieldByName('CON_CCUSCR').AsString := recDados.con_ccuscr;
    strTplaco := fRetTplacoEmpresaLogada(recDados.con_emplan) ;
    ACdsDados.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [recDados.con_condeb, strTplaco], False);
    ACdsDados.FieldByName('DES_CONCRE').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [recDados.con_concre, strTplaco], False);
    ACdsDados.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [recDados.con_ccusto], False);
    ACdsDados.FieldByName('DES_CCUSCR').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [recDados.con_ccuscr], False);
    ACdsDados.FieldByName('CON_HISPAD').AsString := recDados.con_hispad;
    ACdsDados.FieldByName('DES_HISPAD').AsString := fRetDescHistoricoPadrao(recDados.con_hispad, recDados.con_emplan);
    ACdsDados.FieldByName('CON_CODOPE').AsString := recDados.con_codope;
    ACdsDados.FieldByName('CON_AUTOMA').AsInteger := StrToIntDef(recDados.con_automa, 0);
    ACdsDados.Post;
  end;
end;

function TfrmLancamentosLotesContabeis.fInformouPartidaSimples(var fltValorLancamento: double): boolean;
begin
  fltValorLancamento := edtValor.Value;

  Result := (fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) or
            (fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)));

  if (fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) and
            (fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
  begin
    Result := False ;
  end;

  if (fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) then
    fltValorLancamento := -fltValorLancamento;
end;

function TfrmLancamentosLotesContabeis.fIsPartidaSimples: boolean;
begin
  result := not (FControleLancSemLote.conta_credito and FControleLancSemLote.conta_debito) ;
end;

function TfrmLancamentosLotesContabeis.fValidarTrDcZe: Boolean;
begin
  Result := True ;
  if (fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) or
            (fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
  begin
    if fCfgTrDcZe = 'S' then
    begin
      fMensagem('', '"Conta de Débito" e "Conta de Crédito" devem ser informadas!', ['&OK']);
      Result := False ;
      pSetFocusValidacaoTrDcZe ;
      Exit;
    end;
  end;
end;

function TfrmLancamentosLotesContabeis.fValidaValorZerado: boolean;
begin
  result := False ;
  cdsDados.DisableControls ;
  try
    cdsDados.First ;
    while not cdsDados.Eof do
    begin
      if cdsDados.FieldByName('CON_VALLAN').AsFloat <= 0.00 then
      begin
        fMensagem('', 'Valor inválido!' + #13 + 'O campo valor deve ser maior que zero' , ['&OK']);
        exit ;
      end ;
      cdsDados.Next ;
    end ;
  finally
    cdsDados.EnableControls ;
  end ;
  result := True ;
end;

procedure TfrmLancamentosLotesContabeis.pSetFocusValidacaoTrDcZe;
begin
  if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    pSetFocus(mskContaDebito);
    exit ;
  end ;

  if fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    pSetFocus(mskContaCredito);
    exit ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.pSetModoLote(
  const ATipoPesquisa: TPesquisaLancamentoContabil; const AForce: Boolean = False);
begin
  if ATipoPesquisa in [plcLote, plcLoteLancado] then
  begin
    if (FModoLote) and (not AForce) then
    begin
      exit ;
    end;
    FModoLote := True ;
  end
  else
  begin
    if (not FModoLote) and (not AForce) then
    begin
      exit ;
    end;
    FModoLote := False ;
  end;
  pAjustaVisualModoLote ;
end;

procedure TfrmLancamentosLotesContabeis.pSetValorLancon(const AFieldName,
  AValor: string; ALancon: TUniQuery);
begin
  if not fEmptyStr(AValor) then
  begin
    ALancon.FieldByName(AFieldName).AsString := AValor ;
  end
  else
  begin
    ALancon.FieldByName(AFieldName).Clear ;
  end;
end;

procedure TfrmLancamentosLotesContabeis.pShowInfo(const AstrMsg: String);
var
  LfrmMemoInfo: TfrmMemoInfo ;
begin
  pCriarFormularios(TfrmMemoInfo, LfrmMemoInfo) ;
  try
    LfrmMemoInfo.edtInfo.Lines.Text := AstrMsg ;
    LfrmMemoInfo.ShowModal ;
  finally
    pFreeAndNil(LfrmMemoInfo) ;
  end ;
end;

function TfrmLancamentosLotesContabeis.fPermiteEfetivar: boolean;
var
  fltDebitos, fltCreditos: double;
  intCount: integer ;
begin
  pSomatorioDados(fltDebitos, fltCreditos, intCount);
  Result := (fFormataFloat(fltDebitos, 2) = fFormataFloat(fltCreditos, 2));
end;

function TfrmLancamentosLotesContabeis.fPodeCancelarPeriodo(
  strNumLot: string): boolean;
var
  qryLotLan : TUniQuery;
  dtaDtaIni, dtaDtaFin: TDateTime;
  strMensagem: string;
begin
  qryLotLan := fCriaQUery(Self);
  try
    Result := True;

    qryLotLan.SQL.Text := 'SELECT MIN(LAN_DTALAN) AS DTAINI, MAX(LAN_DTALAN) AS DTAFIN, LAN_EMPLAN FROM LO2LAN WHERE LAN_NUMLOT = :NUMLOT GROUP BY LAN_EMPLAN';
    qryLotLan.ParamByName('NUMLOT').AsString := strNumLot;
    qryLotLan.Open;

    if not qryLotLan.IsEmpty then
    begin
      qryLotLan.First;
      while not qryLotLan.Eof do
      begin
        dtaDtaIni := 0;
        dtaDtaFin := 0;

        if not qryLotLan.FieldByName('DTAINI').IsNull then
          dtaDtaIni := qryLotLan.FieldByName('DTAINI').AsDateTime;

        if not qryLotLan.FieldByName('DTAFIN').IsNull then
          dtaDtaFin := qryLotLan.FieldByName('DTAFIN').AsDateTime;

        if (dtaDtaIni <> 0) and (dtaDtaFin <> 0) then
        begin
          if fLancamentoAnteriorFechamento(dtaDtaIni, qryLotLan.FieldByName('LAN_EMPLAN').AsString, strMensagem) then
          begin
            Result := False;
            fMensagem('', strMensagem, ['&OK']);
            Exit;
          end;

          if TVerificaFechamentoDiaMes.fTemFechamento(dtaDtaIni, dtaDtaFin, qryLotLan.FieldByName('LAN_EMPLAN').AsString, False) then
          begin
            Result := False;
            Exit;
          end;

        end;

        qryLotLan.Next;
      end;
    end;
  finally
    FreeAndNil(qryLotLan);
  end;
end;

function TfrmLancamentosLotesContabeis.fRecuperarPeriodico: boolean;
var
  LstrAutoInc : string ;
  LlstDetalhe : TPeriodicosDetalhe ;
  LobjItem    : TPeriodicoDetalhe ;
  LdtaLan     : TDateTime ;
  LstrTplaco  : string ;
  LintOpcao   : integer ;
  LarrDatas   : TArrayPeriodoDatas ;
  LintCnt     : Integer ;
begin
  result := False ;

  if not cdsDados.IsEmpty then
  begin
    LintOpcao := fMensagem('', 'Ao recuperar o modelo periódico, os lançamentos do lote serão perdido!'+ #13 + 'Deseja continuar?', ['&Sim', '&Não'], 1);
    if LintOpcao = NAOPERIODICO then
      exit ;
  end ;

  if not fRetornaAutoIncPeriodico(LstrAutoInc) then
    exit ;


  if not TGetPeriodoDatasPeriodicos.fRetornaDatasPeriodicos(LarrDatas) then
    exit ;

  if not FModoLote then
  begin
    pLimparCampos(True);
    pLimparGrid ;
    pSetModoLote(plcLote) ;
  end ;

  cdsDados.DisableControls ;
  LlstDetalhe := TDadosPeriodicoDetalhe.fSelecionaDados(LstrAutoInc) ;
  try
    ///limpa o clientDataset do Lote
    cdsDados.EmptyDataSet ;
    for LobjItem in LlstDetalhe do
    begin
      LstrTplaco := fRetTplacoEmpresaLogada(LobjItem.Emplan) ;

      for LintCnt := low(LarrDatas) to High(LarrDatas) do
      begin
        LdtaLan := LarrDatas[LintCnt] ;
        cdsDados.Append ;
        cdsDados.FieldByName('CON_DTALAN').AsDateTime := LdtaLan ;
        cdsDados.FieldByName('CON_EMPLAN').AsString := LobjItem.Emplan ;
        cdsDados.FieldByName('CON_CONCRE').AsString := LobjItem.Concre ;
        cdsDados.FieldByName('DES_CONCRE').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LobjItem.Concre, LstrTplaco], False);
        cdsDados.FieldByName('CON_CONDEB').AsString := LobjItem.Condeb ;
        cdsDados.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LobjItem.Condeb, LstrTplaco], False) ;
        cdsDados.FieldByName('CON_CCUSCR').AsString := LobjItem.Ccuscr ;
        cdsDados.FieldByName('DES_CCUSCR').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [LobjItem.Ccuscr], False) ;
        cdsDados.FieldByName('CON_CCUSTO').AsString := LobjItem.Ccusto ;
        cdsDados.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [LobjItem.Ccusto], False) ;
        cdsDados.FieldByName('CON_HISPAD').AsInteger := LobjItem.Hispad ;
        cdsDados.FieldByName('DES_HISPAD').AsString := fRetDescHistoricoPadrao(LobjItem.Hispad.ToString, LobjItem.Emplan);
        cdsDados.FieldByName('CON_HISTOR').AsString := LobjItem.Histor ;
        cdsDados.FieldByName('CON_VALLAN').AsFloat := LobjItem.ValLan;
        cdsDados.FieldByName('CON_TIPLAN').AsString := LobjItem.Tiplan ;
        cdsDados.FieldByName('CON_PARMUL').AsInteger := LobjItem.Parmul ;
        cdsDados.FieldByName('CON_AUTOMA').AsInteger := 0 ;
        cdsDados.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado ;

        cdsDados.FieldByName('CON_CLIFOR').AsString := LobjItem.Clifor ;
        cdsDados.FieldByName('CON_TIP_FC').AsString := LobjItem.Tip_fc ;

        cdsDados.Post ;
      end ;
    end ;
  finally
    FreeAndNil(LlstDetalhe) ;
    cdsDados.EnableControls ;
  end ;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fRetornaAutoIncPeriodico(var AstrAuto: string):boolean ;
var
  LItem: TPeriodicoCapa ;
  LItensCapa: TPeriodicosCapa ;
  LarrMenu: array of string ;
  LintRetorno: integer ;
begin
  Result := False ;
  LItensCapa  := TDadosPeriodicoCapa.fSelecionaDados() ;
  try
    if LItensCapa.Count > 1 then
    begin
      SetLength(LarrMenu, 0);
      for LItem in LItensCapa do
      begin
        SetLength(LarrMenu, Length(LarrMenu)+1);
        LarrMenu[High(LarrMenu)] := LItem.Descri ;
      end ;
      LintRetorno := fGetMenu('Modelos Periódicos', LarrMenu, 0, True);
      if LintRetorno = -1 then
      begin
        fMensagem('ATENÇÃO!', 'Operação cancelada!', ['&OK']);
        exit ;
      end ;
      AstrAuto := LItensCapa.Items[LintRetorno-1].Autoincrem ;
      Result := True ;
    end
    else if LItensCapa.Count = 1 then
    begin
      AstrAuto := LItensCapa.Items[0].Autoincrem ;
      Result := True ;
    end ;
  finally
    FreeAndNil(LItensCapa) ;
  end ;
end;

function TfrmLancamentosLotesContabeis.fRetornaAutoIncremLancon: String;
begin
  if FModoLote then
    Result := CdsDados.FieldByName('CON_AUTINC').AsString
  else
    Result := edtAutoInc.Text ;
end;

function TfrmLancamentosLotesContabeis.fRetornaDictIncDoc(
  const ACdsDados: TUniClientDataSet): TDictionary<Integer, String>;
var
  cdsAux: TUniClientDataSet ;
begin
  result := TDictionary<Integer, String>.Create();
  cdsAux := TUniClientDataSet.Create(Nil) ;
  try
    cdsAux.Data := ACdsDados.Data ;
    cdsAux.First ;
    while not cdsAux.Eof do
    begin
      if cdsAux.FieldByName('CON_PARMUL').AsInteger <> 0 then
      begin
        if not result.ContainsKey(cdsAux.FieldByName('CON_PARMUL').AsInteger) then
        begin
          result.Add(cdsAux.FieldByName('CON_PARMUL').AsInteger, fGerarIncDocLanConManual);
        end;
      end;
      cdsAux.Next ;
    end;
  finally
    FreeAndNil(cdsAux) ;
  end;
end;

function TfrmLancamentosLotesContabeis.fSalvarPeriodico: boolean;
var
  LintOpcao: Integer ;
begin
  result := False ;
  LintOpcao := fMensagem('', 'O que deseja fazer?', ['&Alterar Modelo', '&Incluir Modelo', '&Cancelar'], 1);
  if LintOpcao = ALTERARPERIODICO then
  begin
    result := fAlterarLancamentoPeriodico ;
  end
  else if LintOpcao = INCLUIRPERIODICO then
  begin
    result := fIncluirLancamentoPeriodico ;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.pSomatorioDados(var ADebitos, ACreditos: double; var ACount: integer);
var
  cdsAux: TUniClientDataSet ;
begin
  ADebitos := 0.00 ;
  ACreditos := 0.00 ;
  ACount := 0 ;
  cdsAux := TUniClientDataSet.Create(Nil) ;
  try
    cdsAux.Data := cdsDados.Data ;
    cdsAux.First ;
    while not cdsAux.Eof do
    begin
      if not fEmptyStr(fSemMascaraPlaNco(cdsAux.FieldByName('CON_CONDEB').AsString)) then
      begin
        ADebitos := ADebitos + cdsAux.FieldByName('CON_VALLAN').AsFloat ;
      end;
      if not fEmptyStr(fSemMascaraPlaNco(cdsAux.FieldByName('CON_CONCRE').AsString)) then
      begin
        ACreditos := ACreditos + cdsAux.FieldByName('CON_VALLAN').AsFloat ;
      end;

      ACount := ACount + 1 ;

      cdsAux.Next ;
    end;

  finally
    FreeAndNil(cdsAux) ;
  end;
end;

function TfrmLancamentosLotesContabeis.fGerarLancamentoPartidaMutiplaLote(var AParMul: boolean;
                                                                          var ArecDados: TrecDadosLote;
                                                                          var ALancamentos : TList<TrecDadosLote>;
                                                                          const AValorLancamento: Double): boolean;
begin
  result := False ;
  if (fMensagem('', 'Deseja informar os lançamentos da partida múltipla?', ['&Sim', '&Não'], 2) = 1) Then
  begin
    ArecDados.con_dtalan := mskDtaLan.Date ;
    ArecDados.con_emplan := edtEmpLan.Text ;
    ArecDados.con_tiplan := copy(edtTipLan.Text,1,3) ;
    ArecDados.con_concre := fSemMascaraPlaNco(mskContaCredito.Text) ;
    ArecDados.con_condeb := fSemMascaraPlaNco(mskContaDebito.Text) ;
    ArecDados.con_vallan := edtValor.Value ;
    ArecDados.con_histor := edtHistor.Text ;
    ArecDados.con_ccusto := edtCCustoDebito.Text ;
    ArecDados.con_ccuscr := edtCCustoCredito.Text ;
    ArecDados.con_hispad := edtHisPad.Text ;
    ArecDados.con_automa := iif(edtAutoma.Checked, '1', '0') ;
    ArecDados.con_codope := edtOpeLan.Text ;
    if edtCodCliForSubcontaDebito.Visible then
    begin
      ArecDados.con_clifor := fRetornaCliFor(edtCodCliForSubcontaDebito) ;
      ArecDados.con_tip_fc := fRetornaTipoFC(edtOpcSubcontaDebito) ;
    end
    else if edtCodCliForSubcontaDebito.Visible then
    begin
      ArecDados.con_clifor := fRetornaCliFor(edtCodCliForSubcontaCredito) ;
      ArecDados.con_tip_fc := fRetornaTipoFC(edtOpcSubcontaCredito) ;
    end
    else
    begin
      ArecDados.con_clifor := '' ;
      ArecDados.con_tip_fc := '' ;
    end ;

    if not fLancamentoPartidaMultipla(AValorLancamento, edtEmpLan.Text, mskDtaLan.Date, edtTipLan.Text, strLoginUsuarioLogado, edtAutoma.Checked, ALancamentos, ArecDados) then
    begin
      exit ;
    end;
    AParMul := True ;
  end
  else
  begin
    if not fValidarTrDcZe then
    begin
      Exit;
    end;
  end;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fGravarDadosDoLote(pgbProgresso: TcxProgressBar): Boolean;
begin
  fStartTransaction;
  try
    FLoteGravacao := edtNumLot.Text;
    if fEmptyStr(FLoteGravacao) then
      FLoteGravacao := fInserirLo2Inc('LOTE', 'LOT', VS_strCodEmp, VS_Date, 0);
    pDeletaLotCon(FLoteGravacao);
    pGravaLotCon(FLoteGravacao);
    pGravaLotLan(FLoteGravacao, pgbProgresso);
    pMensagemCodigoUltimoLote(FLoteGravacao) ;
    fCommit;
    fMensagem('ATENÇÃO!', 'Gravação do lote efetuada com sucesso!', ['&OK']);
    Result := true;
  except
    on E: Exception do
    begin
      fRollBack;
      raise;
    end;
  end;
end;

function TfrmLancamentosLotesContabeis.fGravarDadosLanCon(
  pgbProgresso: TcxProgressBar): Boolean;
var
  qryLanCon : TUniQuery;
  qryLotCon : TUniQuery;
  qryLotLan : TUniQuery;
  dictIncDoc : TDictionary<Integer,String>;
  LblnSubCnt : Boolean ;
begin
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  qryLanCon := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  qryLotCon := fCriaQueryContabilidade('LO2CON', Self.Name, Self);
  qryLotLan := fCriaQueryContabilidade('LO2LAN', Self.Name, Self);
  dictIncDoc := fRetornaDictIncDoc(cdsDados);
  try
    cdsDados.DisableControls;

    qryLanCon.SQL.Text := 'SELECT * FROM LANCON WHERE FALSE';
    qryLanCon.Open;

    fStartTransaction;
    try
      if Assigned(pgbProgresso) then
        pgbProgresso.Properties.Max := cdsDados.RecordCount;

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        if Assigned(pgbProgresso) then
        begin
          pgbProgresso.Position := cdsDados.RecNo;
          Application.ProcessMessages;
        end;

        qryLanCon.Insert;
        qryLanCon.FieldByName('CON_TIPLAN').AsString := cdsDados.FieldByName('CON_TIPLAN').AsString;
        qryLanCon.FieldByName('CON_EMPLAN').AsString := cdsDados.FieldByName('CON_EMPLAN').AsString;
        qryLanCon.FieldByName('CON_DTALAN').AsDateTime := cdsDados.FieldByName('CON_DTALAN').AsDateTime;

        if not fEmptyStr(cdsDados.FieldByName('CON_CONCRE').AsString) then
          qryLanCon.FieldByName('CON_CONCRE').AsString := cdsDados.FieldByName('CON_CONCRE').AsString;

        if not fEmptyStr(cdsDados.FieldByName('CON_CONDEB').AsString) then
          qryLanCon.FieldByName('CON_CONDEB').AsString := cdsDados.FieldByName('CON_CONDEB').AsString;

        qryLanCon.FieldByName('CON_HISTOR').AsString := cdsDados.FieldByName('CON_HISTOR').AsString;
        qryLanCon.FieldByName('CON_HISPAD').AsString := cdsDados.FieldByName('CON_HISPAD').AsString;
        qryLanCon.FieldByName('CON_VALLAN').AsFloat := cdsDados.FieldByName('CON_VALLAN').AsFloat;
        qryLanCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;

        if not fEmptyStr(cdsDados.FieldByName('CON_CCUSTO').AsString) then
          qryLanCon.FieldByName('CON_CCUSTO').AsString := cdsDados.FieldByName('CON_CCUSTO').AsString;

        if not fEmptyStr(cdsDados.FieldByName('CON_CCUSCR').AsString) then
          qryLanCon.FieldByName('CON_CCUSCR').AsString := cdsDados.FieldByName('CON_CCUSCR').AsString;

        if cdsDados.FieldByName('CON_PARMUL').AsInteger <> 0 then
        begin
          qryLanCon.FieldByName('CON_INCDOC').AsString := dictIncDoc.Items[cdsDados.FieldByName('CON_PARMUL').AsInteger];
        end
        else
        begin
          qryLanCon.FieldByName('CON_INCDOC').AsString := cdsDados.FieldByName('CON_INCDOC').AsString;
        end;

        if LblnSubCnt then
        begin
          qryLanCon.FieldByName('CON_CLIFOR').AsString := cdsDados.FieldByName('CON_CLIFOR').AsString;
          qryLanCon.FieldByName('CON_TIP_FC').AsString := cdsDados.FieldByName('CON_TIP_FC').AsString;
        end ;

        if blnExisteCampoCON_VERSIS then
          qryLanCon.FieldByName('CON_VERSIS').AsString := VC_StrVersaoContabilidade;

        if blnExisteCampoCON_EMPLOG then
          qryLanCon.FieldByName('CON_EMPLOG').AsString := VS_strCodEmp;

        qryLanCon.Post;

        qryLotLan.Close;
        qryLotLan.SQL.Text := 'SELECT * FROM LO2LAN WHERE AUTOINCREM = :AUTOINCREM;';
        qryLotLan.ParamByName('AUTOINCREM').AsString := cdsDados.FieldByName('CON_INCDOC').AsString;
        qryLotLan.Open;
        qryLotLan.Edit;
        qryLotLan.FieldByName('LAN_CODLAN').AsString := qryLanCon.FieldByName('AUTOINCREM').AsString;
        qryLotLan.Post;

        cdsDados.Next;
      end;

      qryLotCon.Close;
      qryLotCon.SQL.Text := 'SELECT * FROM LO2CON WHERE CON_NUMLOT = :NUMLOT';
      qryLotCon.ParamByName('NUMLOT').AsString := FLoteGravacao;
      qryLotCon.Open;
      qryLotCon.First;
      while not qryLotCon.Eof do
      begin
        qryLotCon.Edit;
        qryLotCon.FieldByName('CON_DTAFEC').AsDateTime := VS_Date;
        qryLotCon.Post;
        qryLotCon.Next;
      end;

      fCommit;
      fMensagem('ATENÇÃO!', 'Lote lançado nos lançamentos contábeis com sucesso!', ['&OK']);

      Result := true;
    except
      on E: Exception do
      begin
        Result := false;
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao efetuar Lote: ' + E.Message, ['&OK']);
      end;
    end;
  finally
    cdsDados.First;
    cdsDados.EnableControls;
    FreeAndNil(qryLanCon);
    FreeAndNil(qryLotCon);
    FreeAndNil(qryLotLan);
    FreeandNil(dictIncDoc);
  end;
end;

function TfrmLancamentosLotesContabeis.fGravarLancamento(const AAutoInc: string): boolean;
var
  qryLanCon : TUniQuery;
  LblnSubCnt : Boolean;
  LstrCliFor : String ;
  LstrTipo   : String ;
begin
  result := False ;
  LblnSubCnt := fCfgDesmembrarSubContaCliFor = 'S' ;
  if fEmptyStr(AAutoInc) then
  begin
    fMensagem('ATENÇÃO!', 'Valor do campo "AUTOINCREM" não informado!', ['&OK']);
    exit ;
  end;

  qryLanCon := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  try
    qryLanCon.SQL.Text := 'SELECT * FROM LANCON WHERE AUTOINCREM = :AUTOINCREM ';
    qryLanCon.ParamByName('AUTOINCREM').AsString := AAutoInc ;
    qryLanCon.Open;
    if qryLanCon.IsEmpty then
    begin
      fMensagem('ATENÇÃO!', 'Registro não encontrado ["' + AAutoInc + '"] para alteração!', ['&OK']);
      exit ;
    end;

    fStartTransaction;
    try
      qryLanCon.Edit;
      qryLanCon.FieldByName('CON_TIPLAN').AsString := copy(edtTipLan.Text,1,3) ;
      qryLanCon.FieldByName('CON_EMPLAN').AsString := edtEmpLan.Text ;
      qryLanCon.FieldByName('CON_DTALAN').AsDateTime := mskDtaLan.Date;
      pSetValorLancon('CON_CONCRE', fSemMascaraPlaNco(mskContaCredito.Text), qryLanCon) ;
      pSetValorLancon('CON_CONDEB', fSemMascaraPlaNco(mskContaDebito.Text), qryLanCon) ;
      qryLanCon.FieldByName('CON_HISTOR').AsString := edtHistor.Text ;
      qryLanCon.FieldByName('CON_VALLAN').AsFloat := edtValor.Value ;
      qryLanCon.FieldByName('CON_CODOPE').AsString := strLoginUsuarioLogado;
      pSetValorLancon('CON_CCUSTO', edtCCustoDebito.Text, qryLanCon) ;
      pSetValorLancon('CON_CCUSCR', edtCCustoCredito.Text, qryLanCon) ;
      pSetValorLancon('CON_HISPAD', edtHisPad.Text, qryLanCon) ;
      qryLanCon.FieldByName('CON_AUTOMA').AsString := iif(edtAutoma.Checked, '1', '0') ;
      pSetaRegistroAutomaticoModificado(qryLanCon) ;
      if LblnSubCnt then
      begin
        pRetornaDadosCliFor(LstrCliFor, LstrTipo) ;
        pSetValorLancon('CON_CLIFOR', LstrCliFor , qryLanCon) ;
        pSetValorLancon('CON_TIP_FC', LstrTipo, qryLanCon) ;
      end ;
      qryLanCon.Post;
      fCommit;
      pAtualizaCheckBoxAutomaticoModificado(qryLanCon) ;
      fMensagem('ATENÇÃO!', 'Lançamento contábil alterado com sucesso!', ['&OK']);
    except
      on E: Exception do
      begin
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao alterar lançamento contábil: ' + E.Message, ['&OK']);
      end;
    end;

  finally
    FreeAndNil(qryLanCon) ;
  end;

  result := True ;
end;

function TfrmLancamentosLotesContabeis.fGravarLote: boolean;
var
  lstLancamentos : TList<TrecDadosLote> ;
  blnFlagParMul: boolean ;
  recDados : TrecDadosLote ;
  fltValorLancamento : double ;
  LstrCliFor, LstrTipo : String ;
begin
  result := False ;

  blnFlagParMul := False ;

  lstLancamentos := TList<TrecDadosLote>.Create ;
  try
    if FModoInclusao then
    begin
      if fInformouPartidaSimples(fltValorLancamento) then
      begin
        if not fGerarLancamentoPartidaMutiplaLote(blnFlagParMul, recDados, lstLancamentos, fltValorLancamento) then
        begin
          exit ;
        end;
      end
      else
      begin
        if not fValidarTrDcZe then
        begin
          Exit;
        end;
      end;
    end;

    if not blnFlagParMul then
    begin
      recDados.con_dtalan := mskDtaLan.Date ;
      recDados.con_emplan := edtEmpLan.Text ;
      recDados.con_tiplan := copy(edtTipLan.Text,1,3) ;
      recDados.con_concre := fSemMascaraPlaNco(mskContaCredito.Text) ;
      recDados.con_condeb := fSemMascaraPlaNco(mskContaDebito.Text) ;
      recDados.con_vallan := edtValor.Value ;
      recDados.con_histor := edtHistor.Text ;
      recDados.con_ccusto := edtCCustoDebito.Text ;
      recDados.con_ccuscr := edtCCustoCredito.Text ;
      recDados.con_hispad := edtHisPad.Text ;
      recDados.con_automa := iif(edtAutoma.Checked, '1', '0') ;
      recDados.con_codope := edtOpeLan.Text ;
      recDados.con_parmul := 0 ;
      pRetornaDadosCliFor(LstrCliFor, LstrTipo) ;
      recDados.con_clifor := LstrCliFor ;
      recDados.con_tip_fc := LstrTipo ;
      lstLancamentos.Add(recDados) ;
    end;

    pLancar(cdsDados, lstLancamentos, FModoInclusao);

  finally
    FreeAndNil(lstLancamentos) ;
  end;

  pSalvaSugestaoUltimoInsert ;

  pLimparCampos ;

  result := True ;
end;

function TfrmLancamentosLotesContabeis.fAlterarLancamento(
  const AAutoInc: string): boolean;
begin
  result := False ;
  if not fValidacaoPrimariaAlteracao(AAutoInc) then
  begin
    exit ;
  end;

  FModoEdicao := True ;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fAlterarLancamentoPeriodico: boolean;
var
  LItensCapa: TPeriodicosCapa ;
  LintOpcao: integer ;
  LstrAutoInc: string ;
  LlstDetalhe: TPeriodicosDetalhe ;
begin
  Result := False ;
  LstrAutoInc := '' ;
  LItensCapa  := TDadosPeriodicoCapa.fSelecionaDados() ;
  try
    if LItensCapa.Count = 0 then
    begin
      fMensagem('ATENÇÃO!', 'Nenhum modelo periódico cadastrado!', ['&OK']);
      exit ;
    end
    else if LItensCapa.Count = 1 then
    begin
      LintOpcao := fMensagem('', 'Deseja realmente alterar o modelo "'+LItensCapa.Items[0].Descri+'"?', ['&Sim', '&Não'], 1);
      if LintOpcao = NAOPERIODICO then
        exit ;
      LstrAutoInc := LItensCapa.Items[0].Autoincrem ;
    end
    else
    begin
      if not fRetornaAutoIncPeriodico(LstrAutoInc) then
        exit ;
    end ;

    LlstDetalhe := fLancamentosPeriodicoDet(LstrAutoInc) ;
    try
      result := TDadosPeriodicoDetalhe.fAtualizaDados(LstrAutoInc, LlstDetalhe) ;
    finally
      FreeAndNil(LlstDetalhe) ;
    end ;

    ///atualiza data, hora e operador que fez a ultima alteração
    pAtualizaOpUltimaAltPeriodico(LstrAutoInc) ;

  finally
    FreeAndNil(LItensCapa) ;
  end ;
end;

function TfrmLancamentosLotesContabeis.fAlterarLote: boolean;
begin
  result := False ;

  if not fTemInformacaoGrid then
  begin
    exit ;
  end;

  fCarregarGridParaCampos ;

  if fLoteFechado(edtNumLot.Text) then
  begin
    exit;
  end;

  if fAlterarLotePartidaMultipla then
  begin
    exit ;
  end;

  FModoEdicao := True ;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fAlterarLotePartidaMultipla: boolean;
var
  recDados : TrecDadosLote ;
  lstLancamentos : TList<TrecDadosLote> ;
begin
  result := False ;
  if cdsDados.FieldByName('CON_PARMUL').AsInteger > 0 then
  begin
    recDados.con_emplan := '' ;
    recDados.con_concre := '' ;
    recDados.con_condeb := '' ;
    recDados.con_vallan := 0.00 ;
    recDados.con_histor := '' ;
    recDados.con_ccusto := '' ;
    recDados.con_ccuscr := '' ;
    recDados.con_hispad := '' ;
    recDados.con_automa := '' ;
    recDados.con_codope := '' ;
    recDados.con_clifor := '' ;
    recDados.con_tip_fc := '' ;
    lstLancamentos := TList<TrecDadosLote>.Create ;
    try
      if not fLancamentoPartidaMultipla(0.00,
                                        cdsDados.FieldByName('CON_EMPLAN').AsString,
                                        cdsDados.FieldByName('CON_DTALAN').AsDateTime,
                                        cdsDados.FieldByName('CON_TIPLAN').AsString,
                                        strLoginUsuarioLogado,
                                        iif(cdsDados.FieldByName('CON_AUTOMA').AsInteger = 1, True, False),
                                        lstLancamentos,
                                        recDados,
                                        cdsDados.FieldByName('CON_PARMUL').AsInteger) then
      begin
        result := True ;
        exit ;
      end;
      FModoInclusao := True ;
      pLancar(cdsDados, lstLancamentos, FModoInclusao, cdsDados.FieldByName('CON_PARMUL').AsInteger);
      FModoInclusao := False ;
      FModoEdicao := False ;
      pHabilitaControles(False, True) ;
      pLimparCampos ;
      result := True ;
    finally
      FreeAndNil(lstLancamentos) ;
    end;
  end;
end;

function TfrmLancamentosLotesContabeis.fCancelarItemLote: boolean;
begin
  pLimparCampos ;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fCancelarEfetivacao(strNumLot: string): boolean;
var
  qryCancela : TUniQuery;
  qryLotLan : TUniQuery;
  qryLo2Lan : TUniQuery;
  LAtualizaLo2Con: TUniQuery;
begin
  qryCancela := fCriaQueryContabilidade('LANCON', Self.Name, Self);
  LAtualizaLo2Con := fCriaQueryContabilidade('LO2CON', Self.Name, Self);
  qryLotLan := fCriaQuery(Self);
  qryLo2Lan := fCriaQueryContabilidade('LO2LAN', Self.Name, Self);
  try
    fStartTransaction;
    try
      LAtualizaLo2Con.Close;
      LAtualizaLo2Con.SQL.Clear;
      LAtualizaLo2Con.SQL.Add('SELECT * FROM LO2CON WHERE CON_NUMLOT = :NUMLOT');
      LAtualizaLo2Con.ParamByName('NUMLOT').AsString := strNumLot;
      LAtualizaLo2Con.Open;
      LAtualizaLo2Con.First;
      while not LAtualizaLo2Con.Eof do
      begin
        LAtualizaLo2Con.Edit;
        LAtualizaLo2Con.FieldByName('CON_DTAFEC').Clear;
        LAtualizaLo2Con.Post;
        LAtualizaLo2Con.Next;
      end;

      qryLotLan.SQL.Text := 'SELECT LAN_CODLAN, AUTOINCREM FROM LO2LAN WHERE LAN_NUMLOT = :NUMLOT';
      qryLotLan.ParamByName('NUMLOT').AsString := strNumLot;
      qryLotLan.Open;

      qryCancela.Close;
      qryCancela.SQL.Text := 'SELECT * FROM LANCON WHERE AUTOINCREM = :AUTOINCREM';

      qryLotLan.First;
      while not qryLotLan.Eof do
      begin

        qryLo2Lan.Close;
        qryLo2Lan.SQL.Text := 'SELECT * FROM LO2LAN WHERE AUTOINCREM = :AUTOINCREM';
        qryLo2Lan.ParamByName('AUTOINCREM').AsString := qryLotLan.FieldByName('AUTOINCREM').AsString;
        qryLo2Lan.Open;
        qryLo2Lan.Edit;
        qryLo2Lan.FieldByName('LAN_CODLAN').Clear;
        qryLo2Lan.Post;

        qryCancela.Close;
        qryCancela.ParamByName('AUTOINCREM').AsString := qryLotLan.FieldByName('LAN_CODLAN').AsString;
        qryCancela.Open;

        if not qryCancela.IsEmpty then
        begin
          qryCancela.Delete ;
        end ;

        qryLotLan.Next;
      end;

      fCommit;
      Result := True;
    except
      on E: Exception do
      begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[TfrmManutencaoLoteContabil.fCancelarEfetivacao]');
      end;
    end;
  finally
    FreeAndNil(qryCancela);
    FreeAndNil(qryLotLan);
    FreeAndNil(qryLo2Lan) ;
  end;
end;

function TfrmLancamentosLotesContabeis.fCancelarlancamento(
  const AAutoInc: string): boolean;
begin
  pCarregarDados(AAutoInc, plcLancon) ;
  edtAutoInc.Text := AAutoInc ;
  result := True ;
end;

function TfrmLancamentosLotesContabeis.fValidouOperacao: boolean;
var
  strSenha : string;
begin
  Result := True;

  if (not blnCfg_SENLCOExiste) then
    exit;

  if (fEmptyStr(fCfgSis('SENLCO', VarString))) then
    exit;

  strSenha := '';
  If ffrmSenha(strSenha, 'Bloqueio do lançamento contábil.') Then
    Result := (strSenha = fCfgSis('SENVRU'))
  Else
    Result := False;
end;

procedure TfrmLancamentosLotesContabeis.pCdsDadosAfterPost(DataSet: TDataSet);
begin
  pAtualizaPanelCredDebLote ;
end;

procedure TfrmLancamentosLotesContabeis.pCdsDadosAfterOpen(DataSet: TDataSet);
begin
  pAtualizaPanelCredDebLote ;
end;

procedure TfrmLancamentosLotesContabeis.pCdsDadosAfterDelete(DataSet: TDataSet);
begin
  pAtualizaPanelCredDebLote ;
end;

procedure TfrmLancamentosLotesContabeis.pSalvaPosicionamentoSubContasDefault;
var
  LintCnt: Integer ;
  LcmpParent: TComponent ;
begin
  FdictDefaultTop.Clear ;
  for LintCnt := 0 to self.ComponentCount-1 do
  begin
    LcmpParent := self.Components[LintCnt].GetParentComponent ;
    if Assigned(LcmpParent) then
    begin
      if LcmpParent.Name = gbDadosLancamento.Name then
      begin
        FdictDefaultTop.Add(self.Components[LintCnt].Name, TWinControl(self.Components[LintCnt]).Top);
      end ;
    end ;
  end ;
  ///Height do Tgroup e TForm
  FdictDefaultHeight.Add(gbDadosLancamento.Name, gbDadosLancamento.Height);
  FdictDefaultHeight.Add(Self.Name+FORMEXPANDIDO, Self.Height);
  FdictDefaultHeight.Add(Self.Name+FORMRECOLHIDO, 0);
end;

procedure TfrmLancamentosLotesContabeis.pSalvaSugestaoUltimoInsert;
begin
  if not FModoInclusao then
    Exit ;

  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
  FrecSugestaoProximoInsert.dtaLan := mskDtaLan.Date ;
  FrecSugestaoProximoInsert.strCodEmp := edtEmpLan.Text ;
  FrecSugestaoProximoInsert.fltValor := edtValor.Value ;
  FrecSugestaoProximoInsert.strContaCredito := mskContaCredito.Text ;
  FrecSugestaoProximoInsert.strContaDebito := mskContaDebito.Text ;
  FrecSugestaoProximoInsert.strCentroCustoCredito := edtCCustoCredito.Text ;
  FrecSugestaoProximoInsert.strCentroCustoDebito := edtCCustoDebito.Text ;
  FrecSugestaoProximoInsert.strComplemento := edtHistor.Texto ;
  FrecSugestaoProximoInsert.strHistoricoPadrao := edtHisPad.Text ;
  FrecSugestaoProximoInsert.strTipoFCDebito := edtOpcSubcontaDebito.Text ;
  FrecSugestaoProximoInsert.strClienteFornecedorDebito := edtCodCliForSubcontaDebito.Text ;
  FrecSugestaoProximoInsert.strTipoFCCredito := edtOpcSubcontaCredito.Text ;
  FrecSugestaoProximoInsert.strClienteFornecedorCredito := edtCodCliForSubcontaCredito.Text ;
  FrecSugestaoProximoInsert.strTipoLancamento := edtTipLan.Text ;
end;

procedure TfrmLancamentosLotesContabeis.pSetaRegistroAutomaticoModificado(
  AqryLancon: TUniQuery);
begin
  if not blnExisteCampoCON_AUTMOD then
    exit ;

  if AqryLancon.FieldByName('CON_AUTOMA').AsInteger <> 1 then
    exit ;

  AqryLancon.FieldByName('CON_AUTMOD').AsString := 'S' ;
end;

procedure TfrmLancamentosLotesContabeis.pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if assigned(FlblGravando) then
    FlblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    FlblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    FlblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TfrmLancamentosLotesContabeis.pSetCreditoComSubconta(
  const AValue: Boolean);
begin
  if FblnCreditoComSubconta <> AValue then
  begin
    FblnCreditoComSubconta := AValue ;
    pReorganizaEntradaDadosSubContas;
  end ;
end;

procedure TfrmLancamentosLotesContabeis.pSetDebitoComSubconta(
  const AValue: Boolean);
begin
  if FblnDebitoComSubconta <> AValue then
  begin
    FblnDebitoComSubconta := AValue ;
    pReorganizaEntradaDadosSubContas;
  end ;
end;

end.
