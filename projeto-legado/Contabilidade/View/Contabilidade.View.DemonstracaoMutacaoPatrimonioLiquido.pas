unit Contabilidade.View.DemonstracaoMutacaoPatrimonioLiquido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxStyles, cxClasses, Data.DB,
  dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxTextEdit,
  cxButtonEdit, cxCalc, cxGridBandedTableView, cxGridDBBandedTableView,
  cxCheckBox, EditFocus, cxDropDownEdit, cxLabel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxGrid, cxButtons, cxMaskEdit, cxSpinEdit, cxGroupBox, cxPC,
  Datasnap.DBClient, UniClientDataSet, untTypesSistema, MemDS, DBAccess, Uni,
  Contabilidade.Classes.TDemonstracaoMutacaoPatrimonioLiquido, cxCheckGroup,
  cxCheckComboBox, cxProgressBar, cxCurrencyEdit, cxGridCustomPopupMenu,
  cxGridPopupMenu, frxExportPDF, frxDBSet, System.Generics.Collections,
  Contabilidade.Interfaces, Vcl.Samples.Spin;

const
  TITULO_RELATORIO = 'DMPL - Demonstração Mutação do Patrimônio Liquido' ;

type
  TfrmDemonstracaoMutacaoPatrimonioLiquido = class(TfrmPaiContabilidade)
    dsParametros: TDataSource;
    mnuIncluir: TPopupMenu;
    Incluir1: TMenuItem;
    Incluirde1: TMenuItem;
    StyleRepository: TcxStyleRepository;
    EstiloNegrito: TcxStyle;
    dsGerar: TDataSource;
    ControlePaginas: TcxPageControl;
    tsParametros: TcxTabSheet;
    gbExercicio: TcxGroupBox;
    edtExercicio: TcxSpinEdit;
    gbBotoes: TcxGroupBox;
    btnIncluir: TcxButton;
    btnGravar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnCancela: TcxButton;
    btnPesquisa: TcxButton;
    GridParametros: TcxGridCitel;
    GridParametrosView: TcxGridDBTableViewCitel;
    GridParametrosViewAUTOINCREM: TcxGridDBColumn;
    GridParametrosViewDMP_EXERCI: TcxGridDBColumn;
    GridParametrosViewDMP_DESCRI: TcxGridDBColumn;
    GridParametrosViewDMP_NIVEL_: TcxGridDBColumn;
    GridParametrosViewDMP_ORDEM_: TcxGridDBColumn;
    GridParametrosViewDMP_EDITAV: TcxGridDBColumn;
    GridParametrosViewDMP_NEGRIT: TcxGridDBColumn;
    GridParametrosViewCNT_BTN: TcxGridDBColumn;
    GridParametrosViewDMP_CONTAS: TcxGridDBColumn;
    GridParametrosLevel: TcxGridLevel;
    tsNotasExplicativas: TcxTabSheet;
    tsCadastroMovimentacao: TcxTabSheet;
    tsGeracao: TcxTabSheet;
    gbBotoesGerar: TcxGroupBox;
    btnFecharGeracao: TcxButton;
    gbGeracao: TcxGroupBox;
    cxLabel1: TcxLabel;
    cbAnoExercicio: TcxComboBox;
    cxLabel2: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    chkImprimirAssinatura: TcxCheckBox;
    btnGerarDados: TcxButton;
    btnImprimir: TcxButton;
    GridGeracao: TcxGridCitel;
    GridGeracaoView: TcxGridDBBandedTableView;
    GridGeracaoLevel: TcxGridLevel;
    gbNotaExplicativa: TcxGroupBox;
    gbBotoesNotasExplicativas: TcxGroupBox;
    btnIncluirNtExpl: TcxButton;
    btnGravarNtExpl: TcxButton;
    btnAlterarNtExpl: TcxButton;
    btnExcluirNtExpl: TcxButton;
    btnCancelaNtExpl: TcxButton;
    btnPesquisaNtExpl: TcxButton;
    mnuIncluirNtExpl: TPopupMenu;
    Incluir1NtExpl: TMenuItem;
    Incluirde1NtExpl: TMenuItem;
    gbMovimentacao: TcxGroupBox;
    gbBotoesMovimentacao: TcxGroupBox;
    btnIncluirMovime: TcxButton;
    btnGravarMovime: TcxButton;
    btnAlterarMovime: TcxButton;
    btnExcluirMovime: TcxButton;
    btnCancelaMovime: TcxButton;
    btnPesquisaMovime: TcxButton;
    edtExercicioNtExpl: TcxSpinEdit;
    GridNotasExplicativasView: TcxGridDBTableView;
    GridNotasExplicativasLevel: TcxGridLevel;
    GridNotasExplicativas: TcxGrid;
    dsNotasExplicativas: TDataSource;
    GridNotasExplicativasViewAUTOINCREM: TcxGridDBColumn;
    GridNotasExplicativasViewDMP_EXERCI: TcxGridDBColumn;
    GridNotasExplicativasViewDMP_CODEXP: TcxGridDBColumn;
    GridNotasExplicativasViewEXP_NOTEXP: TcxGridDBColumn;
    edtExercicioMovime: TcxSpinEdit;
    dsMovimentacao: TDataSource;
    mnuIncluirMovime: TPopupMenu;
    Incluir1Movime: TMenuItem;
    Incluirde1Movime: TMenuItem;
    GridMovimentacaoView: TcxGridDBTableView;
    GridMovimentacaoLevel: TcxGridLevel;
    GridMovimentacao: TcxGrid;
    GridMovimentacaoViewAUTOINCREM: TcxGridDBColumn;
    GridMovimentacaoViewDMP_EXERCI: TcxGridDBColumn;
    GridMovimentacaoViewDMP_CONTIT: TcxGridDBColumn;
    GridMovimentacaoViewDMP_CODMOV: TcxGridDBColumn;
    GridMovimentacaoViewHST_DESCRI: TcxGridDBColumn;
    GridMovimentacaoViewDMP_HISPAD: TcxGridDBColumn;
    GridMovimentacaoViewPAD_DESCRI: TcxGridDBColumn;
    GridMovimentacaoViewDMP_CONCRE: TcxGridDBColumn;
    GridMovimentacaoViewDMP_CONDEB: TcxGridDBColumn;
    GridMovimentacaoViewDMP_NOTEXP: TcxGridDBColumn;
    chkNaoMostrarLinhaSemValor: TcxCheckBox;
    chkNaoMostrarColunaSemValor: TcxCheckBox;
    chkSimplificada: TcxCheckBox;
    GridGeracaoViewTMP_ID: TcxGridDBBandedColumn;
    GridGeracaoViewTMP_CODMOV: TcxGridDBBandedColumn;
    GridGeracaoViewTMP_HISTMV: TcxGridDBBandedColumn;
    GridGeracaoViewTMP_NTEXPL: TcxGridDBBandedColumn;
    lbAtencaoDivergencia: TLabel;
    GridPopupMenu: TcxGridPopupMenu;
    cdsDadosRelatorioSimplificado: TUniClientDataSet;
    frxRelatorioSimplificado: TfrxReport;
    frxDBRelatorioSimplificado: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    lbResponsavelEmpresa: TcxLabel;
    cbResponsavelEmpresa: TcxComboBox;
    lbResponsavelContador: TcxLabel;
    cbResponsavelContador: TcxComboBox;
    chkImprimirParaArquivo: TcxCheckBox;
    cdsDadosRelatorioSimplificadoHISTMV: TStringField;
    cdsDadosRelatorioSimplificadoNTEXPL: TStringField;
    cdsDadosRelatorioSimplificadoTOTAL_: TStringField;
    cdsDadosRelatorioSimplificado_00002: TStringField;
    cdsDadosRelatorioSimplificado_00003: TStringField;
    cdsDadosRelatorioSimplificado_00008: TStringField;
    cdsDadosRelatorioSimplificado_00012: TStringField;
    cdsDadosRelatorioSimplificado_00019: TStringField;
    cdsDadosRelatorio: TUniClientDataSet;
    cdsDadosRelatorioHISTMV: TStringField;
    cdsDadosRelatorioNTEXPL: TStringField;
    cdsDadosRelatorioTOTAL_: TStringField;
    cdsDadosRelatorio_00004: TStringField;
    cdsDadosRelatorio_00005: TStringField;
    cdsDadosRelatorio_00006: TStringField;
    cdsDadosRelatorio_00009: TStringField;
    cdsDadosRelatorio_00010: TStringField;
    cdsDadosRelatorio_00013: TStringField;
    cdsDadosRelatorio_00014: TStringField;
    cdsDadosRelatorio_00015: TStringField;
    cdsDadosRelatorio_00016: TStringField;
    cdsDadosRelatorio_00017: TStringField;
    frxRelatorio: TfrxReport;
    frxDBRelatorio: TfrxDBDataset;
    cdsDadosNotasExpl: TUniClientDataSet;
    frxDBNotasExplicativas: TfrxDBDataset;
    cdsDadosNotasExplCODIGO: TStringField;
    cdsDadosNotasExplDESCRI: TStringField;
    cdsDadosRelatorio_00002: TStringField;
    cdsDadosRelatorio_00019: TStringField;
    cxLabel3: TcxLabel;
    edtEmpSel01: TEditFocus;
    edtNomEmpSel01: TEditFocus;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edtEmpSel02: TEditFocus;
    edtNomEmpSel02: TEditFocus;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    edtEmpSel03: TEditFocus;
    edtNomEmpSel03: TEditFocus;
    cxLabel8: TcxLabel;
    procedure Incluir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridParametrosViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridParametrosViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure GridParametrosViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridParametrosViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure Incluirde1Click(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure ControlePaginasPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure btnPesquisaClick(Sender: TObject);
    procedure Incluir1NtExplClick(Sender: TObject);
    procedure btnGravarNtExplClick(Sender: TObject);
    procedure btnAlterarNtExplClick(Sender: TObject);
    procedure btnExcluirNtExplClick(Sender: TObject);
    procedure btnCancelaNtExplClick(Sender: TObject);
    procedure btnPesquisaNtExplClick(Sender: TObject);
    procedure GridNotasExplicativasViewDMP_CODEXPPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridNotasExplicativasViewDMP_CODEXPPropertiesEditValueChanged(
      Sender: TObject);
    procedure Incluirde1NtExplClick(Sender: TObject);
    procedure GridNotasExplicativasViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure GridNotasExplicativasViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure Incluir1MovimeClick(Sender: TObject);
    procedure btnGravarMovimeClick(Sender: TObject);
    procedure btnAlterarMovimeClick(Sender: TObject);
    procedure btnExcluirMovimeClick(Sender: TObject);
    procedure btnCancelaMovimeClick(Sender: TObject);
    procedure btnPesquisaMovimeClick(Sender: TObject);
    procedure GridMovimentacaoViewDMP_CODMOVPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridMovimentacaoViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure GridMovimentacaoViewDMP_CODMOVPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridMovimentacaoViewDMP_HISPADPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridMovimentacaoViewDMP_HISPADPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridParametrosViewCNT_BTNPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure GridMovimentacaoViewDMP_CONCREPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridMovimentacaoViewDMP_CONDEBPropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure GridMovimentacaoViewDMP_CONTITPropertiesEditValueChanged(
      Sender: TObject);
    procedure GridMovimentacaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure GridMovimentacaoViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure Incluirde1MovimeClick(Sender: TObject);
    procedure GridMovimentacaoViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure btnGerarDadosClick(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharGeracaoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridGeracaoViewEditing(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; var AAllow: Boolean);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkImprimirAssinaturaPropertiesEditValueChanged(Sender: TObject);
    procedure chkImprimirParaArquivoPropertiesEditValueChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pTotalizaRelatorio(var ARelatorio: TfrxReport;
                                 const ASimplificado: boolean) ;
    procedure edtEmpSel01KeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSel02KeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSel03KeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpSelExit(Sender: TObject);
  private
    { Private declarations }
    FListResponsavelContador: TObjectList<TInfoResponsavelContador> ;
    FListResponsavelEmpresa: TObjectList<TInfoResponsavelEmpresa> ;
    FModoInsert: boolean;
    cdsParametros: TUniClientDataSet;
    cdsParametrosContas: TUniClientDataSet;
    cdsNotasExplicativas: TUniClientDataSet;
    cdsMovimentacao: TUniClientDataSet;
    cdsMovimentacaoConCre: TUniClientDataSet;
    cdsMovimentacaoConDeb: TUniClientDataSet;
    cdsMovimentacaoNotExp: TUniClientDataSet;
    cdsGerar: TUniClientDataSet;
    arrEmpSel: TConsultasArray;
    procedure pCarregaDadosParametros(const AExercicio: integer; const ACodEmp: String);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pOcorrenciaContas(const AAutoIncParametros: string='');
    procedure pBotoesParametros(const AHabilitar: boolean);
    function fEmEdicao: boolean;
    procedure pBotoesGerar(const AHabilitar: boolean);
    procedure pInclusaoParametros;
    procedure pInclusaoParametrosContas(const AArrSel: TConsultasArray;
              const AAutoIncParametros: string);
    function fListaExercicios(const ACodEmp: String): TStringList;
    function fIncluirDe(const AExercicio: integer; const ACodEmp: String): boolean;
    function fExercicioCadastrado(const AExercicio: integer; const ATipo: TTipoExercicio; const ACodEmp: String): boolean;
    function fGravarParametros: boolean;
    function fDeletarParametros: boolean;
    function fEmEdicaoGeracao: boolean;
    procedure pReplicaExercicio(const AExercicio: integer; const ACodEmp: String);
    procedure pBotoesNotasExplicativas(const AHabilitar: boolean);
    function fEmEdicaoNotasExplicativas: boolean;
    function fGravarNotasExplicativas: boolean;
    procedure pCarregaDadosNotasExplicativas(const AExercicio: integer; const ACodEmp: String);
    function fDeletarNotasExplicativas: boolean;
    procedure pReplicaExercicioNotasExplicativas(const AExercicio: integer; const ACodEmp: String);
    procedure pAfterInsertNotasExplicativas(DataSet: TDataSet);
    procedure pOnPostErrorNotasExplicativas(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    function fListaExerciciosNotasExplicativas(const ACodEmp: String): TStringList;
    procedure pPesquisaNotasExplicativas ;
    function fIncluirNotasExplicativasDe(const AExercicio: integer; const ACodEmp: String): boolean;
    function fPesquisaNotasExplicativasPeloCodigo(const ACodigo: integer): String;
    procedure pCarregaDadosMovimentacao(const AExercicio: integer; const ACodEmp: String);
    procedure pOcorrenciaMovimentacao(const AAutoInc: string='');
    procedure pBotoesMovimentacao(const AHabilitar: boolean);
    function fEmEdicaoMovimentacao: boolean;
    function fGravarMovimentacao: boolean;
    function fDeletarMovimentacao: boolean;
    procedure pReplicaExercicioMovimentacao(const AExercicio: integer; const ACodEmp: String);
    procedure pPesquisaHistoricoMovimentacao ;
    procedure pAfterInsertMovimentacao(DataSet: TDataSet);
    procedure pOnPostErrorMovimentacao(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure pPreparaNewItemRowGrid(const AGridTableView: TcxGridDBTableView) ;
    procedure pModoEdicaoGrid(const AGridTableView: TcxGridDBTableView);
    procedure pPesquisaHistoricoPadrao ;
    procedure pInclusaoMovimentacaoContas(const AArrSel: TConsultasArray;
              const AAutoIncParametros, ACreDeb: string);
    function fPodeIncluirContaContabilMovimentacao:boolean ;
    procedure pAdicionaContaContabilMovimentacao(var AArrPesq: TConsultasArray; var AKey: Char; const ACreDeb: String) ;
    procedure pManutencaoContaContabilMovimentacao(const ACreDeb: String) ;
    procedure pAfterInsertCreditoContaContabilMovimentacao(DataSet: TDataSet) ;
    procedure pAfterInsertDebitoContaContabilMovimentacao(DataSet: TDataSet) ;
    procedure pCriaIndexContaContabil(const ACreDeb: String) ;
    function fGetContaContabilMovimentacaoByCreDeb(const ACreDeb: String): TUniClientDataSet ;
    function fVerificaContabilMovimentacaoEspelho(const AAutoIncMovimento, AContaContabil, ACreDeb: String): String ;
    function fGetCreDebEspelho(const ACreDeb: String):String ;
    procedure pMensagemInformativa(const AMensagem: String; AMensagemSufixo: String = ''; AMensagemPrefixo: String = '') ;
    procedure pVerificaContaContabilAposManutencao(var ACdsConta: TUniClientDataSet; const ACreDeb, AAutoInc: String) ;
    procedure pLimpaConfiguracaoContaTitulo(const AAutoInc: String) ;
    function fListaExerciciosMovimentacao(const ACodEmp: String): TStringList;
    function fIncluirMovimentacaoDe(const AExercicio: integer; const ACodEmp: String): boolean;
    function fPodeMostrarMensagemPesquisaMovimentacao(const AFocusedItem: TcxCustomGridTableItem): boolean;
    procedure pCarregaNotasExplicativasNaMovimentacao(const AExercicio: integer; const ACodEmp: String) ;
    procedure pSelecionaNotasExplicativasNaMovimentacao(const ACdsMovimentacao, ACdsMovimentacaoNotas: TUniClientDataSet) ;
    function fGravarMovimentacaoNotasExplicativas(const ACdsMovimentacao, ACdsMovimentacaoNotas: TUniClientDataSet): boolean;
    function fDecompoeNotasExplicativas(const AValor: String):TStringList ;
    procedure pRefreshPorPagina(APagina: TcxTabSheet) ;
    procedure pCarregaAnoExercicio ;
    function fGerarDados(pgbProgresso: TcxProgressBar): boolean;
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fEmpresasArrToList:TStringList ;
    procedure pCriarColunas(const ASimplificado:boolean; const ACdsColunas, ACdsBandas: TUniClientDataSet) ;
    procedure pLimparItensGridGeracao ;
    procedure pVerificaDivergencia(const AValorPL: double);
    function fTrataTituloColuna(ATitulo: string):string ;
    function fValidaImpressao: boolean;
    procedure pCarregaDadosRelatorio(var ADadosRelatorio: TUniClientDataSet; const ASimplificado: boolean);
    procedure pShowComboResponsavel(const AAssinatura, AArquivo: Boolean);
    function fTrataNumeroFloatRelatorio(const AValor: Double):string ;
    procedure pCarregaNotasExplicativas(const ADadosRelatorio: TUniClientDataSet);
    procedure pMergeStringListsSemDuplicados(const ADest: TStringList; const AList1, AList2, AList3: TStringList);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples,
  Contabilidade.Consultas , Contabilidade.View.IncluirDeExercicio,
  Contabilidade.View.DemonstracaoMutacaoPatrimonioLiquidoHistMov,
  Contabilidade.View.DemonstracaoFluxoCaixaContasContabeis,
  untConsultas, untFuncoesConsulta, math, untObservacao, Contabilidade.Funcoes;

const
  MENSAGEM_PESQUISA_CONTAS = 'Tecle / para adicionar contas contábeis!' ;

{$R *.dfm}

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnAlterarClick(
  Sender: TObject);
begin
  inherited;

  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesParametros(False) ;
  pSetFocus(GridParametros) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnAlterarMovimeClick(
  Sender: TObject);
begin
  inherited;

  if cdsMovimentacao.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesMovimentacao(False) ;
  pSetFocus(GridMovimentacao) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnAlterarNtExplClick(
  Sender: TObject);
begin
  inherited;
  if cdsNotasExplicativas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não selecionado!' , ['&Ok']);
    exit ;
  end;

  pBotoesNotasExplicativas(False) ;
  pSetFocus(GridNotasExplicativas) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnCancelaClick(
  Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosParametros(edtExercicio.Value, edtEmpSel01.Text) ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnCancelaMovimeClick(
  Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosMovimentacao(edtExercicioMovime.Value, edtEmpSel03.Text) ;
  pBotoesMovimentacao(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnCancelaNtExplClick(
  Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  pCarregaDadosNotasExplicativas(edtExercicioNtExpl.Value, edtEmpSel02.Text) ;
  pBotoesNotasExplicativas(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnExcluirClick(
  Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não Selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão dos parametros do exercício '+
                cdsParametros.FieldByName('DMP_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarParametros then
  begin
    exit ;
  end;

  pCarregaDadosParametros(-1, edtEmpSel01.Text) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnExcluirMovimeClick(
  Sender: TObject);
begin
  inherited;
  if cdsMovimentacao.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não Selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão de TODAS movimentações do exercício '+
                cdsMovimentacao.FieldByName('DMP_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarMovimentacao then
  begin
    exit ;
  end;

  pCarregaDadosMovimentacao(-1, edtEmpSel03.Text) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnExcluirNtExplClick(
  Sender: TObject);
begin
  inherited;
  if cdsNotasExplicativas.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não Selecionado!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão de TODAS notas explicativas do exercício '+
                cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsString+'? ', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarNotasExplicativas then
  begin
    exit ;
  end;

  pCarregaDadosNotasExplicativas(-1, edtEmpSel02.Text) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnFecharGeracaoClick(
  Sender: TObject);
begin
  inherited;
  cdsGerar.EmptyDataSet ;
  pLimparItensGridGeracao ;
  pBotoesGerar(True) ;
  lbAtencaoDivergencia.Visible := False ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnGerarDadosClick(
  Sender: TObject);
var
  lstExercicioMovimentacao: TStringList ;
begin
  inherited;
  ///valida as informações
  if cbAnoExercicio.ItemIndex < 0 then
  begin
    fMensagem('ATENÇÃO!', 'Ano exercício não informado!' , ['&Ok']);
    pSetFocus(cbAnoExercicio);
    exit ;
  end;

  fValidaCampos(edtEmpSel) ;

  ////verificar os parametros do exercicio foram configurados na movimentação.
  lstExercicioMovimentacao := fListaExerciciosMovimentacao(edtEmpSel.Text) ;
  try
    if lstExercicioMovimentacao.IndexOf(cbAnoExercicio.Text) = -1 then
    begin
      fMensagem('ATENÇÃO!', 'Ano exercício [03 - Cadastro da Movimentação] não cadastrado!' , ['&Ok']);
      exit ;
    end;

  finally
    FreeAndNil(lstExercicioMovimentacao) ;
  end;

  Try
    fChamaTelaGravando(fGerarDados) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnGravarClick(
  Sender: TObject);
begin
  inherited;
  if edtExercicio.Value = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicio);
    exit ;
  end;

  if fEmptyStr(edtEmpSel01.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!' , ['&Ok']);
    pSetFocus(edtEmpSel01);
    exit ;
  end;

  If not fValidaCampos(edtEmpSel01) Then
    Exit ;

  pReplicaExercicio(edtExercicio.Value, edtEmpSel01.Text);

  if fExercicioCadastrado(edtExercicio.Value, teParametro, edtEmpSel01.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício '+inttostr(edtExercicio.Value)+' já cadastrado!' , ['&Ok']);
    pSetFocus(edtExercicio);
    exit ;
  end;

  if not fGravarParametros then
  begin
    exit ;
  end;
  FModoInsert := False ;
  pBotoesParametros(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnGravarMovimeClick(
  Sender: TObject);
begin
  inherited;
  if edtExercicioMovime.Value = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicioMovime);
    exit ;
  end;

  if fEmptyStr(edtEmpSel03.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!' , ['&Ok']);
    pSetFocus(edtEmpSel03);
    exit ;
  end;

  If not fValidaCampos(edtEmpSel03) Then
    Exit ;

  pReplicaExercicioMovimentacao(edtExercicioMovime.Value, edtEmpSel03.Text);
  pCarregaNotasExplicativasNaMovimentacao(edtExercicioMovime.Value, edtEmpSel03.Text) ;

  if fExercicioCadastrado(edtExercicioMovime.Value, teMovimentacao, edtEmpSel03.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício '+inttostr(edtExercicioMovime.Value)+' já cadastrado!' , ['&Ok']);
    pSetFocus(edtExercicioMovime);
    exit ;
  end;

  if not fGravarMovimentacao then
  begin
    exit ;
  end;

  FModoInsert := False ;
  pBotoesMovimentacao(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnGravarNtExplClick(
  Sender: TObject);
begin
  inherited;
  if edtExercicioNtExpl.Value = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicioNtExpl);
    exit ;
  end;

  if fEmptyStr(edtEmpSel02.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Empresa não informada!' , ['&Ok']);
    pSetFocus(edtEmpSel02);
    exit ;
  end;

  If not fValidaCampos(edtEmpSel02) Then
    Exit ;

  pReplicaExercicioNotasExplicativas(edtExercicioNtExpl.Value, edtEmpSel02.Text);

  if fExercicioCadastrado(edtExercicio.Value, teNotaExplicativa, edtEmpSel02.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício '+inttostr(edtExercicio.Value)+' já cadastrado!' , ['&Ok']);
    pSetFocus(edtExercicio);
    exit ;
  end;

  if not fGravarNotasExplicativas then
  begin
    exit ;
  end;

  FModoInsert := False ;
  pBotoesNotasExplicativas(True) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnImprimirClick(
  Sender: TObject);
var
  LInfoResponsavelEmpresa: TInfoResponsavelEmpresa ;
  LInfoResponsavelContador: TInfoResponsavelContador ;
  LRelatorio: TfrxReport ;
  LCdsDadosRelatorio: TUniClientDataSet ;
begin
  inherited;

  ///valida as informações selecionadas
  if not fValidaImpressao then
  begin
    exit ;
  end;

  if chkSimplificada.Checked then
  begin
    LRelatorio := frxRelatorioSimplificado ;
    LCdsDadosRelatorio := cdsDadosRelatorioSimplificado ;
  end
  else
  begin
    LRelatorio := frxRelatorio ;
    LCdsDadosRelatorio := cdsDadosRelatorio ;
  end;

  pCarregaDadosRelatorio(LCdsDadosRelatorio, chkSimplificada.Checked) ;
  pCarregaNotasExplicativas(LCdsDadosRelatorio) ;

  LInfoResponsavelEmpresa := Nil ;
  LInfoResponsavelContador := Nil ;
  if cbResponsavelEmpresa.ItemIndex <> -1 then
  begin
    LInfoResponsavelEmpresa := TInfoResponsavelEmpresa(cbResponsavelEmpresa.Properties.Items.Objects[cbResponsavelEmpresa.ItemIndex]) ;
  end;
  if cbResponsavelContador.ItemIndex <> -1 then
  begin
    LInfoResponsavelContador := TInfoResponsavelContador(cbResponsavelContador.Properties.Items.Objects[cbResponsavelContador.ItemIndex]) ;
  end;

  pPreparaRelatorio(strToInt(cbAnoExercicio.Text),
                    arrEmpSel,
                    chkImprimirAssinatura.Checked,
                    chkImprimirParaArquivo.Checked,
                    -1,
                    -1,
                    LInfoResponsavelEmpresa,
                    LInfoResponsavelContador,
                    TITULO_RELATORIO,
                    LRelatorio);

  pTotalizaRelatorio(LRelatorio, chkSimplificada.Checked) ;

  pExibirRelatorio(Self.Name, TITULO_RELATORIO, LRelatorio);
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnPesquisaClick(
  Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoMutacaoPatrimonioLiquido(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      LRetornoPesquisa := arrPesq[0].strCodigo ;
      pTrataExercicioCodEmp(LRetornoPesquisa, LExercicio, LCodEmp) ;
      pCarregaDadosParametros(LExercicio, LCodEmp) ;
      pSetFocus(btnAlterar);
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnPesquisaMovimeClick(
  Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoMutacaoPatrimonioLiquidoMovimentacao(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      LRetornoPesquisa := arrPesq[0].strCodigo ;
      pTrataExercicioCodEmp(LRetornoPesquisa, LExercicio, LCodEmp) ;
      pCarregaDadosMovimentacao(LExercicio, LCodEmp) ;
      pSetFocus(btnAlterarMovime);
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.btnPesquisaNtExplClick(
  Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
  LExercicio: Integer ;
  LCodEmp: String ;
  LRetornoPesquisa: String ;
begin
  chrKey := '/';
  If fPesqDemonstracaoMutacaoPatrimonioLiquidoNtExpl(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      LRetornoPesquisa := arrPesq[0].strCodigo ;
      pTrataExercicioCodEmp(LRetornoPesquisa, LExercicio, LCodEmp) ;
      pCarregaDadosNotasExplicativas(LExercicio, LCodEmp) ;
      pSetFocus(btnAlterarNtExpl);
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.chkImprimirAssinaturaPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(TcxCheckBox(Sender).Checked, chkImprimirParaArquivo.Checked) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.chkImprimirParaArquivoPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  pShowComboResponsavel(chkImprimirAssinatura.Checked, TcxCheckBox(Sender).Checked) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.ControlePaginasPageChanging(
  Sender: TObject; NewPage: TcxTabSheet; var AllowChange: Boolean);
begin
  inherited;
  if fEmEdicao then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações dos parâmetros, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
  if fEmEdicaoNotasExplicativas then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações das notas explicativas, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
  if fEmEdicaoMovimentacao then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações das movimentações, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
  if NewPage = tsGeracao then
    pSetFocus(edtEmpSel);

  if fEmEdicaoGeracao then
  begin
    fMensagem('ATENÇÃO!', 'Fechar o DMPL, antes de mudar de página!' , ['&Ok']);
    AllowChange := false ;
    exit ;
  end;
  ////refresh dependendo da aba selecionada.
  pRefreshPorPagina(NewPage) ;
  ///
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.edtEmpSel01KeyPress(
  Sender: TObject; var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel01, edtNomEmpSel01, Nil, Key, LEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel01) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.edtEmpSel02KeyPress(
  Sender: TObject; var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel02, edtNomEmpSel02, Nil, Key, LEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel02) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.edtEmpSel03KeyPress(
  Sender: TObject; var Key: Char);
var
  LEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel03, edtNomEmpSel03, Nil, Key, LEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel03) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.edtEmpSelExit(
  Sender: TObject);
begin
  inherited;
  pCarregaAnoExercicio ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.edtEmpSelKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, True) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fDecompoeNotasExplicativas(
  const AValor: String): TStringList;
var
  intCnt: integer ;
  intCnt2: integer ;
  strAux: string ;
  strTamanho: string ;
  intCntInterno: integer ;
  LValor: string ;
begin
  result := TStringList.Create ;
  if trim(AValor) = '' then
  begin
    exit ;
  end;

  ///desconsidera o primeiro caracter
  strTamanho := '' ;
  intCnt := 2;
  LValor := AValor ;
  LValor[1] := ' ';
  while intCnt < Length(LValor) do
  begin
    if LValor[intCnt] <> ':' then
    begin
      strTamanho := strTamanho + LValor[intCnt] ;
      LValor[intCnt] := ' ';
      inc(intCnt) ;
    end
    else
    begin
      ///pula o caracter ':'
      LValor[intCnt] := ' ';
      inc(intCnt) ;
      ////extrai o texto de acordo com o tamanho.
      intCntInterno := StrToInt(strTamanho) ;
      strTamanho := '' ;
      strAux := '' ;
      for intCnt2 := 1 to intCntInterno do
      begin
        strAux := strAux + LValor[intCnt] ;
        LValor[intCnt] := ' ';
        inc(intCnt) ;
      end;
      ///adiciona o strAux no StringList
      result.Add(strAux) ;
      ///remove os espaços em branco
      LValor := trim(LValor) ;
      ////reinicia o contador para 1
      intCnt := 1 ;
    end;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fDeletarMovimentacao: boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Deletar(cdsMovimentacao.FieldByName('DMP_EXERCI').AsInteger, cdsMovimentacao.FieldByName('DMP_CODEMP').AsString) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fDeletarNotasExplicativas:boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Deletar(cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsInteger, cdsNotasExplicativas.FieldByName('DMP_CODEMP').AsString) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fDeletarParametros: boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoParametros.Deletar(cdsParametros.FieldByName('DMP_EXERCI').AsInteger, cdsParametros.FieldByName('DMP_CODEMP').AsString) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fEmEdicao: boolean;
begin
  result := btnGravar.Enabled ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fEmEdicaoGeracao: boolean;
begin
  result := btnFecharGeracao.Enabled ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fEmEdicaoMovimentacao: boolean;
begin
  result := btnGravarMovime.Enabled ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fEmEdicaoNotasExplicativas: boolean;
begin
  result := btnGravarNtExpl.Enabled ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fEmpresasArrToList: TStringList;
var
  intCnt : integer ;
begin
  result := TStringList.Create ;
  if Length(arrEmpSel) = 0 then
  begin
    if not fEmptyStr(edtEmpSel.Text) then
    begin
      SetLength(arrEmpSel, 0);
      SetLength(arrEmpSel, 1);
      arrEmpSel[0].strCodigo := edtEmpSel.Text ;
      result.Add(arrEmpSel[0].strCodigo) ;
    end;
  end
  else
  begin
    for intCnt := Low(arrEmpSel) to High(arrEmpSel) do
    begin
      result.Add(arrEmpSel[intCnt].strCodigo) ;
    end;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fExercicioCadastrado(
  const AExercicio: integer; const ATipo: TTipoExercicio; const ACodEmp: String): boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoExercicio.VerificarExistente(AExercicio, FModoInsert, ATipo, ACodEmp);
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGetContaContabilMovimentacaoByCreDeb(
  const ACreDeb: String): TUniClientDataSet;
begin
  if ACreDeb = 'C' then
  begin
    result := cdsMovimentacaoConCre ;
  end
  else
  begin
    result := cdsMovimentacaoConDeb ;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGetCreDebEspelho(
  const ACreDeb: String): String;
begin
  if ACreDeb = 'C' then
  begin
    result := 'D' ;
  end
  else
  begin
    result := 'C' ;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGravarMovimentacao: boolean;
begin

  if not fGravarMovimentacaoNotasExplicativas(cdsMovimentacao, cdsMovimentacaoNotExp) then
  begin
    result := false ;
    exit ;
  end;

  result := TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Gravar(edtExercicioMovime.Value,
                                                                     cdsMovimentacao,
                                                                     cdsMovimentacaoConCre,
                                                                     cdsMovimentacaoConDeb,
                                                                     cdsMovimentacaoNotExp,
                                                                     FModoInsert,
                                                                     edtEmpSel03.Text) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGravarMovimentacaoNotasExplicativas(const ACdsMovimentacao, ACdsMovimentacaoNotas: TUniClientDataSet): boolean;
var
  strNotasExplicativas : string ;
  lstNotasExplicativas : TStringList ;
  intCnt : integer ;
begin
  ACdsMovimentacao.DisableControls ;
  ACdsMovimentacaoNotas.DisableControls ;
  try
    ACdsMovimentacaoNotas.EmptyDataSet;
    ACdsMovimentacao.First ;
    while not ACdsMovimentacao.Eof do
    begin
      strNotasExplicativas := ACdsMovimentacao.FieldByName('DMP_NOTEXP').AsString ;
      lstNotasExplicativas := fDecompoeNotasExplicativas(strNotasExplicativas) ;
      for intCnt := 0 to lstNotasExplicativas.Count-1 do
      begin
        ACdsMovimentacaoNotas.Append ;
        ACdsMovimentacaoNotas.FieldByName('DMP_SEQDMP').AsString := ACdsMovimentacao.FieldByName('AUTOINCREM').AsString ;
        ACdsMovimentacaoNotas.FieldByName('DMP_CODEXP').AsInteger := fCampoTabela('EXP_CODIGO', 'NTEXPL', ['EXP_NOTEXP'], [lstNotasExplicativas.Strings[intCnt]], True);
        ACdsMovimentacaoNotas.Post ;
      end;
      ACdsMovimentacao.Next ;
    end;
  finally
    ACdsMovimentacao.EnableControls ;
    ACdsMovimentacaoNotas.EnableControls ;
  end;
  result := True ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGravarNotasExplicativas: boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Gravar(edtExercicioNtExpl.Value, cdsNotasExplicativas, FModoInsert, edtEmpSel02.Text) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGravarParametros: boolean;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoParametros.Gravar(edtExercicio.Value, cdsParametros, cdsParametrosContas, FModoInsert, edtEmpSel01.Text) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fIncluirDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryCopiar : TUniquery ;
  cdsCon : TUniClientDataSet ;
  strIdent : string ;
begin
  ////busca os dados do exercicio a ser copiado
  qryCopiar := fCriaQuery() ;
  try
    TDemonstracaoMutacaoPatrimonioLiquidoParametros.IncluirDe(AExercicio, ACodEmp, qryCopiar, cdsCon) ;

    cdsParametros.DisableControls ;
    cdsParametrosContas.DisableControls ;
    try
      cdsParametros.EmptyDataSet;
      cdsParametrosContas.EmptyDataSet;
      while not qryCopiar.Eof do
      begin
        cdsParametros.Append ;
        cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRDMPL',Vs_strCodEmp) ;
        cdsParametros.FieldByName('DMP_NIVEL_').AsString := qryCopiar.FieldByName('DMP_NIVEL_').AsString ;
        cdsParametros.FieldByName('DMP_ORDEM_').AsString := qryCopiar.FieldByName('DMP_ORDEM_').AsString ;
        cdsParametros.FieldByName('DMP_EDITAV').AsString := qryCopiar.FieldByName('DMP_EDITAV').AsString ;
        cdsParametros.FieldByName('DMP_NEGRIT').AsString := qryCopiar.FieldByName('DMP_NEGRIT').AsString ;
        cdsParametros.FieldByName('DMP_CONTAS').AsString := qryCopiar.FieldByName('DMP_CONTAS').AsString ;
        strIdent := fReplicatorStr(' ',qryCopiar.FieldByName('DMP_NIVEL_').AsInteger*3) ;
        cdsParametros.FieldByName('DMP_DESCRI').AsString := strIdent + qryCopiar.FieldByName('DMP_DESCRI').AsString ;
        cdsParametros.Post ;
        ////adiciona as contas
        if cdsCon.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsCon.FieldByName('DMP_SEQLAN').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsCon.Eof) do
          begin

            cdsParametrosContas.Append ;
            cdsParametrosContas.FieldByName('DMP_SEQLAN').AsString := cdsParametros.FieldByName('AUTOINCREM').AsString ;
            cdsParametrosContas.FieldByName('DMP_CODCON').AsString := cdsCon.FieldByName('DMP_CODCON').AsString ;
            cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsCon.FieldByName('DMP_CODCON').AsString], False);
            cdsParametrosContas.Post ;

            cdsCon.Next;
          end;
        end;
        qryCopiar.Next;
      end;
      cdsParametros.First ;
    finally
      cdsParametros.EnableControls ;
      cdsParametrosContas.EnableControls ;
    end;

  finally
    FreeAndNil(qryCopiar) ;
    FreeAndNil(cdsCon) ;
  end;
  result := true ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fIncluirMovimentacaoDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryCopiar : TUniquery ;
  cdsConCre : TUniClientDataSet ;
  cdsConDeb : TUniClientDataSet ;
  cdsNotas : TUniClientDataSet ;
begin
  ////busca os dados do exercicio a ser copiado
  qryCopiar := fCriaQuery() ;
  try
    TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.IncluirDe(AExercicio,
                                                                ACodEmp,
                                                                qryCopiar,
                                                                cdsConCre,
                                                                cdsConDeb,
                                                                cdsNotas) ;

    cdsMovimentacao.DisableControls ;
    cdsMovimentacaoConCre.DisableControls ;
    cdsMovimentacaoConDeb.DisableControls ;
    cdsMovimentacaoNotExp.DisableControls ;
    try
      cdsMovimentacao.EmptyDataSet;
      cdsMovimentacaoConCre.EmptyDataSet;
      cdsMovimentacaoConDeb.EmptyDataSet;
      cdsMovimentacaoNotExp.EmptyDataSet;
      while not qryCopiar.Eof do
      begin
        cdsMovimentacao.Append ;
        cdsMovimentacao.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MVDMPL',Vs_strCodEmp) ;
        cdsMovimentacao.FieldByName('DMP_EXERCI').AsString := qryCopiar.FieldByName('DMP_EXERCI').AsString ;
        cdsMovimentacao.FieldByName('DMP_CODEMP').AsString := qryCopiar.FieldByName('DMP_CODEMP').AsString ;
        cdsMovimentacao.FieldByName('DMP_CONTIT').AsString := qryCopiar.FieldByName('DMP_CONTIT').AsString ;
        cdsMovimentacao.FieldByName('DMP_CODMOV').AsString := qryCopiar.FieldByName('DMP_CODMOV').AsString ;
        cdsMovimentacao.FieldByName('HST_DESCRI').AsString := qryCopiar.FieldByName('HST_DESCRI').AsString ;
        cdsMovimentacao.FieldByName('DMP_HISPAD').AsString := qryCopiar.FieldByName('DMP_HISPAD').AsString ;
        cdsMovimentacao.FieldByName('PAD_DESCRI').AsString := qryCopiar.FieldByName('PAD_DESCRI').AsString ;
        cdsMovimentacao.Post ;
        ////adiciona as contas
        ///  Crédito
        if cdsConCre.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsConCre.FieldByName('DMP_SEQDMP').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsConCre.Eof) do
          begin

            cdsMovimentacaoConCre.Append ;
            cdsMovimentacaoConCre.FieldByName('DMP_SEQDMP').AsString := cdsMovimentacao.FieldByName('AUTOINCREM').AsString ;
            cdsMovimentacaoConCre.FieldByName('DMP_CODCON').AsString := cdsConCre.FieldByName('DMP_CODCON').AsString ;
            cdsMovimentacaoConCre.FieldByName('DMP_CREDEB').AsString := cdsConCre.FieldByName('DMP_CREDEB').AsString ;
            cdsMovimentacaoConCre.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsConCre.FieldByName('DMP_CODCON').AsString], False);
            cdsMovimentacaoConCre.Post ;

            cdsConCre.Next;
          end;
        end;
        ///  Dédito
        if cdsConDeb.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsConDeb.FieldByName('DMP_SEQDMP').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsConDeb.Eof) do
          begin

            cdsMovimentacaoConDeb.Append ;
            cdsMovimentacaoConDeb.FieldByName('DMP_SEQDMP').AsString := cdsMovimentacao.FieldByName('AUTOINCREM').AsString ;
            cdsMovimentacaoConDeb.FieldByName('DMP_CODCON').AsString := cdsConDeb.FieldByName('DMP_CODCON').AsString ;
            cdsMovimentacaoConDeb.FieldByName('DMP_CREDEB').AsString := cdsConDeb.FieldByName('DMP_CREDEB').AsString ;
            cdsMovimentacaoConDeb.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [cdsConDeb.FieldByName('DMP_CODCON').AsString], False);
            cdsMovimentacaoConDeb.Post ;

            cdsConDeb.Next;
          end;
        end;
        /// Notas Explicativas
        if cdsNotas.FindKey([qryCopiar.FieldByName('AUTOINCREM').AsString]) then
        begin
          while (cdsNotas.FieldByName('DMP_SEQDMP').AsString = qryCopiar.FieldByName('AUTOINCREM').AsString) and (not cdsNotas.Eof) do
          begin

            cdsMovimentacaoNotExp.Append ;
            cdsMovimentacaoNotExp.FieldByName('DMP_SEQDMP').AsString := cdsMovimentacao.FieldByName('AUTOINCREM').AsString ;
            cdsMovimentacaoNotExp.FieldByName('DMP_CODEXP').AsString := cdsNotas.FieldByName('DMP_CODEXP').AsString ;
            cdsMovimentacaoNotExp.FieldByName('EXP_NOTEXP').AsString := cdsNotas.FieldByName('EXP_NOTEXP').AsString ;
            cdsMovimentacaoNotExp.Post ;

            cdsNotas.Next;
          end;
        end;
        qryCopiar.Next;
      end;
      cdsMovimentacao.First ;
    finally
      cdsMovimentacao.EnableControls ;
      cdsMovimentacaoConCre.EnableControls ;
      cdsMovimentacaoConDeb.EnableControls ;
      cdsMovimentacaoNotExp.EnableControls ;
    end;

  finally
    FreeAndNil(qryCopiar) ;
    FreeAndNil(cdsConCre) ;
    FreeAndNil(cdsConDeb) ;
    FreeAndNil(cdsNotas) ;
  end;
  result := true ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fIncluirNotasExplicativasDe(
  const AExercicio: integer; const ACodEmp: String): boolean;
var
  qryCopiar : TUniquery ;
begin
  ////busca os dados do exercicio a ser copiado
  qryCopiar := fCriaQuery() ;
  try
    TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.IncluirDe(AExercicio, ACodEmp, qryCopiar) ;

    cdsNotasExplicativas.DisableControls ;
    try
      cdsNotasExplicativas.EmptyDataSet;
      while not qryCopiar.Eof do
      begin
        cdsNotasExplicativas.Append ;
        cdsNotasExplicativas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NEDMPL',Vs_strCodEmp) ;
        cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsString := qryCopiar.FieldByName('DMP_EXERCI').AsString ;
        cdsNotasExplicativas.FieldByName('DMP_CODEMP').AsString := qryCopiar.FieldByName('DMP_CODEMP').AsString ;
        cdsNotasExplicativas.FieldByName('DMP_CODEXP').AsString := qryCopiar.FieldByName('DMP_CODEXP').AsString ;
        cdsNotasExplicativas.FieldByName('EXP_NOTEXP').AsString := qryCopiar.FieldByName('EXP_NOTEXP').AsString ;
        cdsNotasExplicativas.Post ;
        qryCopiar.Next;
      end;
      cdsNotasExplicativas.First ;
    finally
      cdsNotasExplicativas.EnableControls ;
    end;

  finally
    FreeAndNil(qryCopiar) ;
  end;
  result := true ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fListaExercicios(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoExercicio.Listar(ACodEmp, teParametro) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fListaExerciciosMovimentacao(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoExercicio.Listar(ACodEmp, teMovimentacao) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fListaExerciciosNotasExplicativas(const ACodEmp: String): TStringList;
begin
  result := TDemonstracaoMutacaoPatrimonioLiquidoExercicio.Listar(ACodEmp, teNotaExplicativa) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.FormCloseQuery(
  Sender: TObject; var CanClose: Boolean);
var
  blnFlag: boolean ;
begin
  inherited;
  blnFlag := fEmEdicao or fEmEdicaoNotasExplicativas or fEmEdicaoMovimentacao ;

  if blnFlag then
  begin
    fMensagem('ATENÇÃO!', 'Gravar as alterações, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;

  if fEmEdicaoGeracao then
  begin
    fMensagem('ATENÇÃO!', 'Fechar o DMPL, antes de fechar o módulo!' , ['&Ok']);
    CanClose := False ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.FormCreate(Sender: TObject);
begin
  inherited;
  FListResponsavelContador := TObjectList<TInfoResponsavelContador>.Create() ;
  FListResponsavelEmpresa := TObjectList<TInfoResponsavelEmpresa>.Create() ;
  pCarregaResponsavel(FListResponsavelContador, FListResponsavelEmpresa) ;
  cdsDadosRelatorioSimplificado.CreateDataSet ;
  cdsDadosRelatorioSimplificado.Open ;
  cdsDadosRelatorio.CreateDataSet ;
  cdsDadosRelatorio.Open ;
  cdsDadosNotasExpl.CreateDataSet ;
  cdsDadosNotasExpl.Open ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListResponsavelContador) ;
  FreeAndNil(FListResponsavelEmpresa) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.FormShow(Sender: TObject);
begin
  inherited;
  pBotoesParametros(True) ;
  pBotoesNotasExplicativas(True) ;
  pBotoesMovimentacao(True) ;
  pBotoesGerar(True) ;
  pCarregaDadosParametros(-1, edtEmpSel01.Text) ;
  pCarregaDadosNotasExplicativas(-1, edtEmpSel02.Text) ;
  pCarregaDadosMovimentacao(-1, edtEmpSel03.Text) ;
  pCarregaResponsavelComboBoxAdministrador(FListResponsavelEmpresa, cbResponsavelEmpresa) ;
  pCarregaResponsavelComboBoxContador(FListResponsavelContador, cbResponsavelContador) ;
  ControlePaginas.ActivePageIndex := 0 ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fPesquisaNotasExplicativasPeloCodigo(
  const ACodigo: integer): String;
var
  qryConsulta: TUniQuery;
begin
  result := '' ;
  qryConsulta := fCriaQuery() ;
  try
    qryConsulta.SQL.Clear ;
    qryConsulta.SQL.Add(' SELECT EXP_NOTEXP FROM NTEXPL WHERE EXP_CODIGO = :CODIGO ') ;
    qryConsulta.ParamByName('CODIGO').AsInteger := ACodigo ;

    if edtExercicioNtExpl.Value > 0 then
    begin
      qryConsulta.SQL.Add(' AND :EXERCI BETWEEN COALESCE(EXP_ANOINI,0) AND CASE WHEN COALESCE(EXP_ANOINI,0) = 0 THEN 9999 ELSE EXP_ANOINI END ') ;
      qryConsulta.ParamByName('EXERCI').AsInteger := edtExercicioNtExpl.Value ;
    end;

    qryConsulta.Open ;
    if not qryConsulta.IsEmpty then
    begin
      result := qryConsulta.FieldByName('EXP_NOTEXP').AsString ;
    end;
  finally
    FreeAndNil(qryConsulta) ;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fPodeIncluirContaContabilMovimentacao: boolean;
begin
  Result := False ;
  if fEmptyStr(GridMovimentacaoViewAUTOINCREM.DataBinding.Field.AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Confirme a inclusão do registro, antes de adicionar conta contábil!' , ['&Ok']);
    exit ;
  end;
  Result := True ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fPodeMostrarMensagemPesquisaMovimentacao(
  const AFocusedItem: TcxCustomGridTableItem): boolean;
begin
  result := True ;
  if AFocusedItem = GridMovimentacaoViewDMP_CODMOV then
  begin
    exit ;
  end;
  if AFocusedItem = GridMovimentacaoViewDMP_HISPAD then
  begin
    exit ;
  end;
  if AFocusedItem = GridMovimentacaoViewDMP_CONCRE then
  begin
    exit ;
  end;
  if AFocusedItem = GridMovimentacaoViewDMP_CONDEB then
  begin
    exit ;
  end;
  result := False ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fTrataNumeroFloatRelatorio(
  const AValor: Double): string;
begin
  if AValor < 0 then
  begin
    result := '('+FormatCurr('#,##0.00', abs(AValor))+')' ;
  end
  else
  begin
    result := FormatCurr('#,##0.00', AValor) ;
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fTrataTituloColuna(
  ATitulo: string): string;
begin
  result := copy(ATitulo, 6, Length(ATitulo)-5) ;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  intIndex : integer ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpSel) Then
    Begin
      if fEmptyStr(edtEmpSel.Text) then
      begin
        SetLength(arrEmpSel,0) ;
        edtNomEmpSel.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        If (fEmptyStr(edtNomEmpSel.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end
        else
        begin
          pDesmarcaLista(edtEmpSel, arrEmpSel);

          If Length(arrEmpSel) > 0 Then
          Begin
            For intIndex := Low(arrEmpSel) To High(arrEmpSel) Do
            Begin
              If Pos(arrEmpSel[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                edtNomEmpSel.Clear;
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpSel[intIndex].strCodigo + '!', ['&O k']);
                Result := False;
                Break;
              End;
            End;
          End
          Else If Not fEmptyStr(edtEmpSel.Text) Then
          Begin
            If Pos(edtEmpSel.Text, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              edtNomEmpSel.Clear;
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    else If (Sender = edtEmpSel01) Then
    begin
      if not fEmptyStr(edtEmpSel01.Text) then
      Begin
        edtNomEmpSel01.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel01.Text], False);
        if fEmptyStr(edtNomEmpSel01.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel01.Clear;
        edtEmpSel01.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end
    else If (Sender = edtEmpSel02) Then
    begin
      if not fEmptyStr(edtEmpSel02.Text) then
      Begin
        edtNomEmpSel02.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel02.Text], False);
        if fEmptyStr(edtNomEmpSel02.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel02.Clear;
        edtEmpSel02.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end
    else If (Sender = edtEmpSel03) Then
    begin
      if not fEmptyStr(edtEmpSel03.Text) then
      Begin
        edtNomEmpSel03.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel03.Text], False);
        if fEmptyStr(edtNomEmpSel03.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel03.Clear;
        edtEmpSel03.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End ;
    end ;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fVerificaContabilMovimentacaoEspelho(
  const AAutoIncMovimento, AContaContabil, ACreDeb: String): String;
var
  cdsConta : TUniClientDataSet ;
begin
  result := '' ;
  cdsConta := fGetContaContabilMovimentacaoByCreDeb(fGetCreDebEspelho(ACreDeb)) ;

  if cdsConta.FindKey([AAutoIncMovimento, AContaContabil]) then
  begin
    result := cdsConta.FieldByName('DMP_CODCON').AsString ;
  end;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridGeracaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := False ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_CODMOVPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmDMPLHistoricoMovimentacao : TfrmDMPLHistoricoMovimentacao ;
begin
  inherited;
  if AButtonIndex = 0 then
  begin
    if not fEmEdicaoMovimentacao then
    begin
      fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
      exit ;
    end;

    pPesquisaHistoricoMovimentacao ;
  end
  else /////chama o cadastro
  begin
    Try
      pCriarFormularios(TfrmDMPLHistoricoMovimentacao, frmDMPLHistoricoMovimentacao);
      frmDMPLHistoricoMovimentacao.showModal;
    Finally
      pFreeAndNil(frmDMPLHistoricoMovimentacao);
    End;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_CODMOVPropertiesEditValueChanged(
  Sender: TObject);
var
  intCodigo: integer ;
  strDescricao: string ;
begin
  inherited;

  intCodigo := strToIntDef(TcxButtonEdit(Sender).Text,0) ;
  if intCodigo = 0 then
  begin
    GridMovimentacaoViewHST_DESCRI.DataBinding.Field.Clear ;
    GridMovimentacaoViewDMP_CODMOV.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  strDescricao := fCampoTabela('HST_DESCRI', 'HISTMV', ['HST_CODIGO'], [intCodigo], False) ;
  if fEmptyStr(strDescricao) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico movimentação não encontrada!' , ['&Ok']);
    GridMovimentacaoViewHST_DESCRI.DataBinding.Field.Clear ;
    GridMovimentacaoViewDMP_CODMOV.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  GridMovimentacaoViewDMP_CODMOV.DataBinding.Field.AsInteger := intCodigo ;
  GridMovimentacaoViewHST_DESCRI.DataBinding.Field.AsString := strDescricao ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_CONCREPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pManutencaoContaContabilMovimentacao('C') ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_CONDEBPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pManutencaoContaContabilMovimentacao('D') ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_CONTITPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  GridMovimentacaoViewDMP_CONTIT.DataBinding.Field.AsInteger := TcxCheckBox(Sender).EditValue ;
  ////limpa as configurações
  pLimpaConfiguracaoContaTitulo(GridMovimentacaoViewAUTOINCREM.DataBinding.Field.AsString) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_HISPADPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  if not fEmEdicaoMovimentacao then
  begin
    fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
    exit ;
  end;
  pPesquisaHistoricoPadrao ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewDMP_HISPADPropertiesEditValueChanged(
  Sender: TObject);
var
  intCodigo: integer ;
  strDescricao: string ;
begin
  inherited;

  intCodigo := strToIntDef(TcxButtonEdit(Sender).Text,0) ;
  if intCodigo = 0 then
  begin
    GridMovimentacaoViewPAD_DESCRI.DataBinding.Field.Clear ;
    GridMovimentacaoViewDMP_HISPAD.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  strDescricao := fCampoTabela('PAD_DESCRI', 'HISPAD', ['PAD_CODIGO'], [intCodigo], False) ;
  if fEmptyStr(strDescricao) then
  begin
    fMensagem('ATENÇÃO!', 'Histórico padrão não encontrado!' , ['&Ok']);
    GridMovimentacaoViewPAD_DESCRI.DataBinding.Field.Clear ;
    GridMovimentacaoViewDMP_HISPAD.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  GridMovimentacaoViewDMP_HISPAD.DataBinding.Field.AsInteger := intCodigo ;
  GridMovimentacaoViewPAD_DESCRI.DataBinding.Field.AsString := strDescricao ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridMovimentacaoViewDMP_CONTIT then
  begin
    exit ;
  end;

  if AItem = GridMovimentacaoViewDMP_CODMOV then
  begin
    exit ;
  end;

  if GridMovimentacaoViewDMP_CONTIT.DataBinding.Field.AsInteger <> 1 then
  begin
    exit ;
  end;

  AAllow := False ;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  arrPesq: TConsultasArray;
begin
  inherited;
  if key = '/' then
  begin
    if not fEmEdicaoMovimentacao then
    begin
      fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
      key := #0 ;
      exit ;
    end;
    if GridMovimentacaoViewDMP_CONTIT.DataBinding.Field.AsInteger = 1 then
    begin
      key := #0 ;
      exit ;
    end;

    if AItem = GridMovimentacaoViewDMP_CODMOV then
    begin
      key := #0 ;
      pPreparaNewItemRowGrid(GridMovimentacaoView) ;
      pPesquisaHistoricoMovimentacao ;
    end
    else if AItem = GridMovimentacaoViewDMP_HISPAD then
    begin
      key := #0 ;
      pPreparaNewItemRowGrid(GridMovimentacaoView) ;
      pPesquisaHistoricoPadrao ;
    end
    else if AItem = GridMovimentacaoViewDMP_CONCRE then
    begin
      pAdicionaContaContabilMovimentacao(arrPesq, Key, 'C') ;
    end
    else if AItem = GridMovimentacaoViewDMP_CONDEB then
    begin
      pAdicionaContaContabilMovimentacao(arrPesq, Key, 'D') ;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if fPodeMostrarMensagemPesquisaMovimentacao(AFocusedItem) then
  begin
    pnlInfo.Caption := 'Tecle / para pesquisar' ;
  end
  else
  begin
    pnlInfo.Caption := 'Tecle [Del] para excluir apenas um Histórico da Movimentação' ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridMovimentacaoViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridMovimentacaoView.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(GridMovimentacaoView.DataController.Values[ARowInfo.RecordIndex,
                         GridMovimentacaoViewDMP_CONTIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridNotasExplicativasViewDMP_CODEXPPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  GridNotasExplicativasViewDMP_CODEXP.Properties.OnEditValueChanged := Nil ;
  try
    pPesquisaNotasExplicativas ;
  finally
    GridNotasExplicativasViewDMP_CODEXP.Properties.OnEditValueChanged := GridNotasExplicativasViewDMP_CODEXPPropertiesEditValueChanged ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridNotasExplicativasViewDMP_CODEXPPropertiesEditValueChanged(
  Sender: TObject);
var
  intCodigo: integer ;
  strDescricao: string ;
begin
  inherited;

  if edtExercicioNtExpl.Value <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicioNtExpl) ;
    exit ;
  end;

  intCodigo := strToIntDef(TcxButtonEdit(Sender).Text,0) ;
  if intCodigo = 0 then
  begin
    GridNotasExplicativasViewEXP_NOTEXP.DataBinding.Field.Clear ;
    GridNotasExplicativasViewDMP_CODEXP.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  strDescricao := fPesquisaNotasExplicativasPeloCodigo(intCodigo) ;
  if fEmptyStr(strDescricao) then
  begin
    fMensagem('ATENÇÃO!', 'Nota explicativa não encontrada!' , ['&Ok']);
    GridNotasExplicativasViewEXP_NOTEXP.DataBinding.Field.Clear ;
    GridNotasExplicativasViewDMP_CODEXP.DataBinding.Field.Clear ;
    TcxButtonEdit(Sender).Clear ;
    exit ;
  end;
  GridNotasExplicativasViewDMP_CODEXP.DataBinding.Field.AsInteger := intCodigo ;
  GridNotasExplicativasViewEXP_NOTEXP.DataBinding.Field.AsString := strDescricao ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridNotasExplicativasViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  if AItem = GridNotasExplicativasViewDMP_CODEXP then
  begin
    if key = '/' then
    begin
      key := #0 ;
      pPreparaNewItemRowGrid(GridNotasExplicativasView) ;
      pPesquisaNotasExplicativas ;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridNotasExplicativasViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if AFocusedItem = GridNotasExplicativasViewDMP_CODEXP then
  begin
    pnlInfo.Caption := 'Tecle / para pesquisar Nota Explicativa' ;
  end
  else
  begin
    pnlInfo.Caption := 'Tecle [Del] para excluir apenas uma Nota Explicativa' ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridParametrosViewCNT_BTNPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmDemonstracaoFluxoCaixaContasContabeis : TfrmDemonstracaoFluxoCaixaContasContabeis ;
  cdsTemp : TUniClientDataSet ;
begin
  inherited;
  pCriarFormularios(TfrmDemonstracaoFluxoCaixaContasContabeis, frmDemonstracaoFluxoCaixaContasContabeis);
  cdsTemp := TUniClientDataSet.Create(Self);
  try
    pCloneDataSet(cdsTemp, cdsParametrosContas);

    cdsParametrosContas.Filter := 'DMP_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    cdsParametrosContas.Filtered := True ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrAutoIncParametros := cdsParametros.FieldByName('AUTOINCREM').AsString ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldCodCon := 'DMP_CODCON' ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldDescri := 'NCO_DESCRI' ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldSeqLan := 'DMP_SEQLAN' ;
    frmDemonstracaoFluxoCaixaContasContabeis.dsPlanco.DataSet := cdsParametrosContas ;
    frmDemonstracaoFluxoCaixaContasContabeis.blnModoEdicao := fEmEdicao ;
    frmDemonstracaoFluxoCaixaContasContabeis.ShowModal ;
    if frmDemonstracaoFluxoCaixaContasContabeis.ModalResult = idOK then
    begin
      pOcorrenciaContas(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
    end
    else
    begin
      cdsParametrosContas.Close ;
      cdsParametrosContas.Open ;
      cdsParametrosContas.Data := cdsTemp.Data ;
    end;
  finally
    FreeAndNil(cdsTemp) ;
    pFreeAndNil(frmDemonstracaoFluxoCaixaContasContabeis) ;
    cdsParametrosContas.Filtered := False ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridParametrosViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  if AItem = GridParametrosViewDMP_DESCRI then
  begin
    AAllow := GridParametrosViewDMP_EDITAV.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
  if AItem = GridParametrosViewCNT_BTN then
  begin
    AAllow := GridParametrosViewDMP_CONTAS.DataBinding.Field.AsString = '1' ;
    exit ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridParametrosViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  if AItem = GridParametrosViewCNT_BTN then
  begin

    if not fEmEdicao then
    begin
      key := #0 ;
      fMensagem('ATENÇÃO!', 'Coloque em modo de edição!' , ['&Ok']);
      exit ;
    end;

    if key = '/' then
    begin
      If Contabilidade.Consultas.fPesqPlanoContabil(Self, Nil, Nil, Nil, Key, arrSel, False, '', True, True) Then
      Begin
        key := #0 ;
        pPreparaNewItemRowGrid(GridParametrosView) ;
        pInclusaoParametrosContas(arrSel, cdsParametros.FieldByName('AUTOINCREM').AsString) ;
        pOcorrenciaContas(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
      End;
    end
    else
    begin
      key := #0 ;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridParametrosViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  if AFocusedItem = GridParametrosViewCNT_BTN then
  begin
    if GridParametrosViewDMP_CONTAS.DataBinding.Field.AsString = '1' then
    begin
      pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
    end
    else
    begin
      pnlInfo.Caption := '' ;
    end;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.GridParametrosViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
Var
  ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData Then
  begin
    if ARecord.Index > -1 then
    begin
      ARowInfo := GridParametrosView.DataController.GetRowInfo(ARecord.Index);
      If VarToStr(GridParametrosView.DataController.Values[ARowInfo.RecordIndex,
                         GridParametrosViewDMP_NEGRIT.Index]) = '1' Then
      Begin
        AStyle := EstiloNegrito;
      End;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluir1Click(
  Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pInclusaoParametros ;
  pBotoesParametros(False) ;
  pSetFocus(edtExercicio) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluir1MovimeClick(
  Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pCarregaDadosMovimentacao(-1, edtEmpSel03.Text) ; ////filtra em branco
  pBotoesMovimentacao(False) ;
  pSetFocus(edtExercicioMovime) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluir1NtExplClick(
  Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  pCarregaDadosNotasExplicativas(-1, edtEmpSel02.Text) ; ////filtra em branco
  edtExercicioNtExpl.Value := 0 ;
  pBotoesNotasExplicativas(False) ;
  pSetFocus(edtExercicioNtExpl) ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluirde1Click(
  Sender: TObject);
var
  frmIncluirDeExercicio : TfrmIncluirDeExercicio ;
  LExercicio : Integer ;
  LCodEmp: String ;
begin
  inherited;
  pCriarFormularios(TfrmIncluirDeExercicio, frmIncluirDeExercicio);
  try
    frmIncluirDeExercicio.Tipo := teParametro ;
    frmIncluirDeExercicio.ShowModal ;
    if frmIncluirDeExercicio.Confirmado then
    begin
      LExercicio := frmIncluirDeExercicio.Exercicio ;
      LCodEmp := frmIncluirDeExercicio.CodEmpresa ;

      if fIncluirDe(LExercicio, LCodEmp) then
      begin
        FModoInsert := True ;
        pBotoesParametros(False) ;
        edtExercicio.Value := 0 ;
        pOcorrenciaContas ;
        pSetFocus(edtExercicio) ;
        edtEmpSel01.Text := LCodEmp ;
        fValidaCampos(edtEmpSel01) ;
      end;
    end;
  finally
    pFreeAndNil(frmIncluirDeExercicio) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluirde1MovimeClick(
  Sender: TObject);
var
  frmIncluirDeExercicio : TfrmIncluirDeExercicio ;
  LExercicio : integer ;
  LCodEmp: String ;
begin
  inherited;
  pCriarFormularios(TfrmIncluirDeExercicio, frmIncluirDeExercicio);
  try
    frmIncluirDeExercicio.Tipo := teMovimentacao ;
    frmIncluirDeExercicio.ShowModal ;
    if frmIncluirDeExercicio.Confirmado then
    begin
      LExercicio := frmIncluirDeExercicio.Exercicio ;
      LCodEmp := frmIncluirDeExercicio.CodEmpresa ;
      if fIncluirMovimentacaoDe(LExercicio, LCodEmp) then
      begin
        FModoInsert := True ;
        pBotoesMovimentacao(False) ;
        edtExercicioMovime.Value := 0 ;
        pOcorrenciaMovimentacao ;
        pSetFocus(edtExercicioMovime) ;
        edtEmpSel03.Text := LCodEmp ;
        fValidaCampos(edtEmpSel03) ;
      end;
    end;
  finally
    pFreeAndNil(frmIncluirDeExercicio) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.Incluirde1NtExplClick(
  Sender: TObject);
var
  frmIncluirDeExercicio : TfrmIncluirDeExercicio ;
  LExercicio: Integer ;
  LCodEmp: String ;
begin
  inherited;
  pCriarFormularios(TfrmIncluirDeExercicio, frmIncluirDeExercicio);
  try
    frmIncluirDeExercicio.Tipo := teNotaExplicativa ;
    frmIncluirDeExercicio.ShowModal ;
    if frmIncluirDeExercicio.Confirmado then
    begin
      LExercicio := frmIncluirDeExercicio.Exercicio ;
      LCodEmp := frmIncluirDeExercicio.CodEmpresa ;
      if fIncluirNotasExplicativasDe(LExercicio, LCodEmp) then
      begin
        FModoInsert := True ;
        pBotoesNotasExplicativas(False) ;
        edtExercicioNtExpl.Value := 0 ;
        pSetFocus(edtExercicioNtExpl) ;
        edtEmpSel02.Text := LCodEmp ;
        fValidaCampos(edtEmpSel02) ;
      end;
    end;
  finally
    pFreeAndNil(frmIncluirDeExercicio) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAdicionaContaContabilMovimentacao(
  var AArrPesq: TConsultasArray; var AKey: Char; const ACreDeb: String);
begin
  if not fPodeIncluirContaContabilMovimentacao then
  begin
    AKey := #0 ;
    exit ;
  end;
  If Contabilidade.Consultas.fPesqPlanoContabil(Self, Nil, Nil, Nil, AKey, AArrPesq, False, '', True, True) Then
  Begin
    AKey := #0 ;
    pPreparaNewItemRowGrid(GridMovimentacaoView) ;
    pInclusaoMovimentacaoContas(AArrPesq, cdsMovimentacao.FieldByName('AUTOINCREM').AsString, ACreDeb) ;
    pOcorrenciaMovimentacao(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
  End;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAfterInsertCreditoContaContabilMovimentacao(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('DMP_CREDEB').AsString := 'C' ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAfterInsertDebitoContaContabilMovimentacao(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('DMP_CREDEB').AsString := 'D' ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAfterInsertMovimentacao(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MVDMPL',Vs_strCodEmp) ;
  DataSet.FieldByName('DMP_EXERCI').AsInteger := edtExercicioMovime.Value ;
  DataSet.FieldByName('DMP_CODEMP').AsString := edtEmpSel03.Text ;
  DataSet.FieldByName('DMP_CONTIT').AsInteger := 0 ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAfterInsertNotasExplicativas(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NEDMPL',Vs_strCodEmp) ;
  DataSet.FieldByName('DMP_EXERCI').AsInteger := edtExercicioNtExpl.Value ;
  DataSet.FieldByName('DMP_CODEMP').AsString := edtEmpSel02.Text ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pAfterScroll(
  DataSet: TDataSet);
begin
  if DataSet.FieldByName('DMP_CONTAS').AsString = '1' then
  begin
    pnlInfo.Caption := MENSAGEM_PESQUISA_CONTAS ;
  end
  else
  begin
    pnlInfo.Caption := '' ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pBotoesGerar(
  const AHabilitar: boolean);
begin
  btnGerarDados.Enabled := AHabilitar ;
  btnImprimir.Enabled := not AHabilitar ;
  btnFecharGeracao.Enabled := not AHabilitar ;
  /////
  cbAnoExercicio.Enabled := AHabilitar ;
  edtEmpSel.Enabled := AHabilitar ;
  chkSimplificada.Enabled := AHabilitar ;
  chkNaoMostrarLinhaSemValor.Enabled := AHabilitar ;
  chkNaoMostrarColunaSemValor.Enabled := AHabilitar ;
  GridGeracao.Visible := not AHabilitar ;
  /////
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pBotoesMovimentacao(
  const AHabilitar: boolean);
begin
  btnIncluirMovime.Enabled  :=  AHabilitar ;
  btnGravarMovime.Enabled   :=  not AHabilitar ;
  btnAlterarMovime.Enabled  :=  AHabilitar ;
  btnExcluirMovime.Enabled  :=  AHabilitar ;
  btnCancelaMovime.Enabled  :=  not AHabilitar ;
  btnPesquisaMovime.Enabled :=  AHabilitar ;
  /////
  //GridMovimentacao.Enabled := fEmEdicaoMovimentacao ;
  TcxCheckBoxProperties(GridMovimentacaoViewDMP_CONTIT.Properties).ReadOnly := not fEmEdicaoMovimentacao ;
  TcxButtonEditProperties(GridMovimentacaoViewDMP_CODMOV.Properties).ReadOnly := not fEmEdicaoMovimentacao ;
  TcxButtonEditProperties(GridMovimentacaoViewDMP_HISPAD.Properties).ReadOnly := not fEmEdicaoMovimentacao ;
  TcxCheckComboBoxProperties(GridMovimentacaoViewDMP_NOTEXP.Properties).ReadOnly := not fEmEdicaoMovimentacao ;
  GridMovimentacaoView.OptionsData.Deleting := fEmEdicaoMovimentacao ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicioMovime.Enabled := FModoInsert ;
  edtEmpSel03.Enabled := FModoInsert ;
  edtNomEmpSel03.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pBotoesNotasExplicativas(
  const AHabilitar: boolean);
begin
  btnIncluirNtExpl.Enabled  :=  AHabilitar ;
  btnGravarNtExpl.Enabled   :=  not AHabilitar ;
  btnAlterarNtExpl.Enabled  :=  AHabilitar ;
  btnExcluirNtExpl.Enabled  :=  AHabilitar ;
  btnCancelaNtExpl.Enabled  :=  not AHabilitar ;
  btnPesquisaNtExpl.Enabled :=  AHabilitar ;
  /////
  GridNotasExplicativas.Enabled := fEmEdicaoNotasExplicativas ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicioNtExpl.Enabled := FModoInsert ;
  edtEmpSel02.Enabled := FModoInsert ;
  edtNomEmpSel02.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pBotoesParametros(
  const AHabilitar: boolean);
begin
  btnIncluir.Enabled  :=  AHabilitar ;
  btnGravar.Enabled   :=  not AHabilitar ;
  btnAlterar.Enabled  :=  AHabilitar ;
  btnExcluir.Enabled  :=  AHabilitar ;
  btnCancela.Enabled  :=  not AHabilitar ;
  btnPesquisa.Enabled :=  AHabilitar ;
  /////
  TcxTextEditProperties(GridParametrosViewDMP_DESCRI.Properties).ReadOnly := not fEmEdicao ;
  TcxButtonEditProperties(GridParametrosViewCNT_BTN.Properties).ReadOnly := not fEmEdicao ;
  ////no modo de alteração não é possivel alterar o exercicio, somente em inclusão.
  edtExercicio.Enabled := FModoInsert ;
  edtEmpSel01.Enabled := FModoInsert ;
  edtNomEmpSel01.Enabled := FModoInsert ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaAnoExercicio;
var
  LlstMerge : TStringList ;
  LExerciciosCadastroConta, LExerciciosNotaExpl, LExerciciosMoviment: TStringList ;
begin
  LlstMerge := TStringList.Create ;
  LExerciciosCadastroConta := fListaExercicios(edtEmpSel.Text) ;
  LExerciciosNotaExpl := fListaExerciciosNotasExplicativas(edtEmpSel.Text) ;
  LExerciciosMoviment := fListaExerciciosMovimentacao(edtEmpSel.Text) ;
  try
    pMergeStringListsSemDuplicados(LlstMerge, LExerciciosCadastroConta, LExerciciosNotaExpl, LExerciciosMoviment);
    cbAnoExercicio.Properties.Items.Assign(LlstMerge);
  finally
    FreeAndNil(LlstMerge) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaDadosMovimentacao(
  const AExercicio: integer; const ACodEmp: String);
begin
  dsMovimentacao.Enabled := False ;
  dsMovimentacao.DataSet := Nil ;

  TDemonstracaoMutacaoPatrimonioLiquidoMovimentacao.Carregar(AExercicio,
                                                             ACodEmp,
                                                             cdsMovimentacao,
                                                             cdsMovimentacaoConCre,
                                                             cdsMovimentacaoConDeb,
                                                             cdsMovimentacaoNotExp) ;

  cdsMovimentacao.AfterInsert := pAfterInsertMovimentacao ;
  cdsMovimentacao.OnPostError := pOnPostErrorMovimentacao ;

  cdsMovimentacaoConCre.AfterInsert := pAfterInsertCreditoContaContabilMovimentacao ;
  pCriaIndexContaContabil('C') ;
  cdsMovimentacaoConDeb.AfterInsert := pAfterInsertDebitoContaContabilMovimentacao ;
  pCriaIndexContaContabil('D') ;

  pOcorrenciaMovimentacao ;

  pCarregaNotasExplicativasNaMovimentacao(AExercicio, ACodEmp) ;
  pSelecionaNotasExplicativasNaMovimentacao(cdsMovimentacao,cdsMovimentacaoNotExp) ;

  if not cdsMovimentacao.IsEmpty then
  begin
    edtExercicioMovime.Value := cdsMovimentacao.FieldByName('DMP_EXERCI').AsInteger ;
    edtEmpSel03.Text := cdsMovimentacao.FieldByName('DMP_CODEMP').AsString ;
    fValidaCampos(edtEmpSel03) ;
  end
  else
  begin
    edtExercicioMovime.Clear ;
    edtEmpSel03.Clear ;
  end;

  dsMovimentacao.DataSet := cdsMovimentacao ;
  dsMovimentacao.Enabled := True ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaDadosNotasExplicativas(
  const AExercicio: integer; const ACodEmp: String);
begin
  dsNotasExplicativas.Enabled := False ;
  dsNotasExplicativas.DataSet := Nil ;

  TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Carregar(AExercicio, ACodEmp, cdsNotasExplicativas) ;

  cdsNotasExplicativas.AfterInsert := pAfterInsertNotasExplicativas ;
  cdsNotasExplicativas.OnPostError := pOnPostErrorNotasExplicativas ;

  if not cdsNotasExplicativas.IsEmpty then
  begin
    edtExercicioNtExpl.Value := cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsInteger ;
    edtEmpSel02.Text := cdsNotasExplicativas.FieldByName('DMP_CODEMP').AsString ;
    fValidaCampos(edtEmpSel02) ;
  end
  else
  begin
    edtExercicioNtExpl.Clear ;
    edtEmpSel02.Clear ;
  end;

  dsNotasExplicativas.DataSet := cdsNotasExplicativas ;
  dsNotasExplicativas.Enabled := True ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaDadosParametros(
  const AExercicio: integer; const ACodEmp: String);
begin
  dsParametros.Enabled := False ;
  dsParametros.DataSet := Nil ;

  TDemonstracaoMutacaoPatrimonioLiquidoParametros.Carregar(AExercicio, ACodEmp, cdsParametros, cdsParametrosContas) ;

  cdsParametros.AfterScroll := pAfterScroll;

  pOcorrenciaContas ;

  if not cdsParametros.IsEmpty then
  begin
    edtExercicio.Value := cdsParametros.FieldByName('DMP_EXERCI').AsInteger ;
    edtEmpSel01.Text := cdsParametros.FieldByName('DMP_CODEMP').AsString ;
    fValidaCampos(edtEmpSel01) ;
  end
  else
  begin
    edtExercicio.Clear ;
    edtEmpSel01.Clear ;
  end;

  dsParametros.DataSet := cdsParametros ;
  dsParametros.Enabled := True ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaNotasExplicativas(const ADadosRelatorio: TUniClientDataSet);
var
  lstTrataCodigos, lstCodigos: TStringList ;
  intCnt: integer ;
  strFiltro: string ;
  qryConsulta: TUniQuery ;
begin
  cdsDadosNotasExpl.EmptyDataSet ;

  lstTrataCodigos := TStringList.Create ;
  lstCodigos := TStringList.Create ;
  qryConsulta := fCriaQuery() ;
  try
    lstTrataCodigos.Delimiter := ',' ;
    lstTrataCodigos.StrictDelimiter := True ;
    ADadosRelatorio.First ;
    while not ADadosRelatorio.Eof do
    begin
      if not fEmptyStr(ADadosRelatorio.FieldByName('NTEXPL').AsString) then
      begin
        lstTrataCodigos.DelimitedText := ADadosRelatorio.FieldByName('NTEXPL').AsString ;
        for intCnt := 0 to lstTrataCodigos.Count-1 do
        begin
          if lstCodigos.IndexOf(lstTrataCodigos.Strings[intCnt]) = -1 then
          begin
            lstCodigos.Add(lstTrataCodigos.Strings[intCnt]) ;
          end;
        end;
      end;
      ADadosRelatorio.Next ;
    end;

    if lstCodigos.Count > 0 then
    begin
      strFiltro := '' ;
      for intCnt := 0 to lstCodigos.Count-1 do
      begin
        if fEmptyStr(strFiltro) then
        begin
          strFiltro := lstCodigos.Strings[intCnt] ;
        end
        else
        begin
          strFiltro := strFiltro + ',' + lstCodigos.Strings[intCnt] ;
        end;
      end;

      qryConsulta.SQL.Clear ;
      qryConsulta.SQL.Add('SELECT EXP_CODIGO, EXP_NOTEXP FROM NTEXPL WHERE EXP_CODIGO IN ('+strFiltro+') ORDER BY EXP_CODIGO ;') ;
      qryConsulta.Open ;
      qryConsulta.First ;
      while not qryConsulta.Eof do
      begin
        cdsDadosNotasExpl.Append ;
        cdsDadosNotasExpl.FieldByName('CODIGO').AsString := fStrZero(qryConsulta.FieldByName('EXP_CODIGO').AsString,3) ;
        cdsDadosNotasExpl.FieldByName('DESCRI').AsString := qryConsulta.FieldByName('EXP_NOTEXP').AsString ;
        cdsDadosNotasExpl.Post ;
        qryConsulta.Next ;
      end;

    end;

  finally
    FreeAndNil(lstTrataCodigos) ;
    FreeAndNil(lstCodigos) ;
    FreeAndNil(qryConsulta) ;
  end;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaNotasExplicativasNaMovimentacao(const AExercicio: integer; const ACodEmp: String);
var
  cdsNotasExp : TUniClientDataSet ;
  checkGroupItem : TcxCheckComboBoxItem ;
begin
  cdsNotasExp := nil ;
  TDemonstracaoMutacaoPatrimonioLiquidoNotasExplicativas.Carregar(AExercicio, ACodEmp, cdsNotasExp) ;
  try
    TcxCheckComboBoxProperties(GridMovimentacaoViewDMP_NOTEXP.Properties).Items.Clear ;
    cdsNotasExp.First ;
    while not cdsNotasExp.Eof do
    begin
      checkGroupItem := TcxCheckComboBoxProperties(GridMovimentacaoViewDMP_NOTEXP.Properties).Items.Add ;
      checkGroupItem.Description := cdsNotasExp.FieldByName('EXP_NOTEXP').AsString ;
      checkGroupItem.ShortDescription := fStrZero(cdsNotasExp.FieldByName('DMP_CODEXP').AsString,3) ;
      cdsNotasExp.Next ;
    end;
  finally
    FreeAndNil(cdsNotasExp) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCriaIndexContaContabil(
  const ACreDeb: String);
const
  DESCARTE_INDEX = 'DEFAULT_ORDER_CHANGEINDEX' ;
var
  cdsConta : TUniClientDataSet ;
  lstIndex : TStringList ;
  intCnt : Integer ;
begin
  cdsConta := fGetContaContabilMovimentacaoByCreDeb(ACreDeb) ;
  ////apaga os indices
  cdsConta.IndexName := '' ;
  lstIndex := TStringList.Create ;
  try
    cdsConta.GetIndexNames(lstIndex);
    for intCnt := 0 to lstIndex.Count-1 do
    begin
      if pos(lstIndex.Strings[intCnt],DESCARTE_INDEX) > 0 then
      begin
        continue;
      end;
      cdsConta.DeleteIndex(lstIndex.Strings[intCnt]);
    end;
  finally
    FreeAndNil(lstIndex) ;
  end;
  ////cria Indices
  cdsConta.AddIndex('IndiceSincroniza','DMP_SEQDMP;DMP_CODCON', []);
  cdsConta.AddIndex('IndiceGrava','DMP_SEQDMP', []);
  cdsConta.IndexName := 'IndiceSincroniza' ;  ///default
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCriarColunas(const ASimplificado:boolean;
const ACdsColunas, ACdsBandas: TUniClientDataSet);
var
  colGrid : TcxGridDBBandedColumn ;
  BandItem : TcxGridBand ;
  strFieldName : string ;
begin
  GridGeracaoView.DataController.BeginFullUpdate;
  try
    if not ASimplificado then
    begin
      ////cria as abas dos agrupamento
      ACdsBandas.First ;
      while not ACdsBandas.Eof do
      begin
        BandItem := GridGeracaoView.Bands.Add ;
        BandItem.Position.BandIndex := GridGeracaoView.Bands.Items[1].Index ;
        BandItem.Caption := fTrataTituloColuna(ACdsBandas.FieldByName('DESCRI').AsString) ;
        BandItem.Tag := ACdsBandas.FieldByName('CODIGO').AsInteger ;
        ////adiciona as colunas para a respectiva aba
        if ACdsColunas.FindKey([ACdsBandas.FieldByName('CODIGO').AsInteger]) then
        begin
          while (ACdsColunas.FieldByName('ABACOD').AsInteger = ACdsBandas.FieldByName('CODIGO').AsInteger) and (not ACdsColunas.Eof) do
          begin
            strFieldName := 'TMP_'+fStrZero(ACdsColunas.FieldByName('CODIGO').AsString, 6) ;
            colGrid := GridGeracaoView.CreateColumn ;
            colGrid.DataBinding.FieldName := strFieldName ;
            colGrid.Caption := fTrataTituloColuna(ACdsColunas.FieldByName('DESCRI').AsString) ;
            colGrid.Position.BandIndex := BandItem.Index;
            colGrid.Name := GridGeracaoView.Name+strFieldName;
            colGrid.Tag := ACdsColunas.FieldByName('CODIGO').AsInteger ;
            colGrid.PropertiesClass := TcxCurrencyEditProperties;
            TcxCurrencyEditProperties(colGrid.Properties).DisplayFormat := ',#,##0.00;,(#,##0.00)' ;
            ACdsColunas.Next ;
          end;
        end;
        ////
        ACdsBandas.Next ;
      end ;
    end
    else
    begin
      ACdsBandas.First ;
      while not ACdsBandas.Eof do
      begin
        strFieldName := 'TMP_'+fStrZero(inttostr(abs(ACdsBandas.FieldByName('CODIGO').AsInteger)), 6) ;

        colGrid := GridGeracaoView.CreateColumn ;
        colGrid.DataBinding.FieldName := strFieldName ;
        colGrid.Caption := fTrataTituloColuna(ACdsBandas.FieldByName('DESCRI').AsString) ;
        colGrid.Position.BandIndex := GridGeracaoView.Bands.Items[1].Index;
        colGrid.Name := GridGeracaoView.Name+strFieldName;
        colGrid.Tag := ACdsBandas.FieldByName('CODIGO').AsInteger ;
        colGrid.PropertiesClass := TcxCurrencyEditProperties;
        TcxCurrencyEditProperties(colGrid.Properties).DisplayFormat := ',#,##0.00;,(#,##0.00)' ;

        ACdsBandas.Next ;
      end;
    end;
    /////ultima banda é o total
    BandItem := GridGeracaoView.Bands.Add ;
    BandItem.Position.BandIndex := GridGeracaoView.Bands.Items[1].Index ;
    BandItem.Caption := '' ;
    BandItem.Tag := -1 ;
    strFieldName := 'TMP_TOTAL_' ;

    colGrid := GridGeracaoView.CreateColumn ;
    colGrid.DataBinding.FieldName := strFieldName ;
    colGrid.Caption := 'Total Patrimônio Liquido' ;
    colGrid.Position.BandIndex := BandItem.Index;
    colGrid.Name := GridGeracaoView.Name+strFieldName;
    colGrid.Tag := ifThen(ACdsColunas.FieldByName('CODIGO').AsInteger = 0, -1, ACdsColunas.FieldByName('CODIGO').AsInteger) ;
    colGrid.PropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(colGrid.Properties).DisplayFormat := ',#,##0.00;,(#,##0.00)' ;

  finally
    GridGeracaoView.DataController.EndFullUpdate;
  end;

  GridGeracaoView.ApplyBestFit();

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pInclusaoMovimentacaoContas(
  const AArrSel: TConsultasArray; const AAutoIncParametros, ACreDeb: string);
var
  intCnt : integer ;
  cdsContas : TUniClientDataSet ;
  strConta : String ;
  strMensagem : String ;
begin
  cdsContas := fGetContaContabilMovimentacaoByCreDeb(ACreDeb) ;
  cdsContas.DisableControls ;
  try
    strMensagem := '' ;
    for intCnt := Low(AArrSel) to High(AArrSel) do
    begin
      ////evita duplicidade
      if cdsContas.FindKey([AAutoIncParametros, AArrSel[intCnt].strCodigo]) then
      begin
        continue ;
      end;
      ////verifica se a conta está no cdsEspelho
      strConta := fVerificaContabilMovimentacaoEspelho(AAutoIncParametros, AArrSel[intCnt].strCodigo, ACreDeb) ;
      if not fEmptyStr(strConta) then
      begin
        strMensagem := strMensagem + strConta + ' - ' + fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strConta], False) + #13#10 ;
        continue ;
      end;
      ///
      cdsContas.Append ;
      cdsContas.FieldByName('DMP_SEQDMP').AsString := AAutoIncParametros ;
      cdsContas.FieldByName('DMP_CODCON').AsString := AArrSel[intCnt].strCodigo ;
      cdsContas.FieldByName('DMP_CREDEB').AsString := ACreDeb ;
      cdsContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [AArrSel[intCnt].strCodigo], False);
      cdsContas.Post ;
    end;

    pMensagemInformativa(strMensagem, 'As seguintes contas contábeis foram descartadas!'+ #13#10 + 'Pois estão adicionadas em Contas do PL ('+iif(fGetCreDebEspelho(ACreDeb) = 'C', 'Crédito', 'Débito')+')' + #13#10  );

  finally
    cdsContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pInclusaoParametros;
var
  intLinhas : integer ;
  strIdent : string ;
begin
  cdsParametros.DisableControls ;
  try
    cdsParametros.EmptyDataSet;
    for intLinhas := PARAMETROS_LINHA_MIN to PARAMETROS_LINHA_MAX do
    begin
      cdsParametros.Append ;
      cdsParametros.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PRDMPL',Vs_strCodEmp) ;
      cdsParametros.FieldByName('DMP_NIVEL_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NIVEL_] ;
      cdsParametros.FieldByName('DMP_ORDEM_').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_ORDEM_] ;
      cdsParametros.FieldByName('DMP_EDITAV').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_EDITAV] ;
      cdsParametros.FieldByName('DMP_NEGRIT').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_NEGRIT] ;
      cdsParametros.FieldByName('DMP_CONTAS').AsString := PARAMETROS_PADRAO[intLinhas, PARAMETROS_CONTAS] ;
      strIdent := fReplicatorStr(' ',cdsParametros.FieldByName('DMP_NIVEL_').AsInteger*3) ;
      cdsParametros.FieldByName('DMP_DESCRI').AsString := strIdent + PARAMETROS_PADRAO[intLinhas, PARAMETROS_DESCRI] ;
      cdsParametros.Post ;
    end;
    cdsParametros.First ;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pInclusaoParametrosContas(
  const AArrSel: TConsultasArray; const AAutoIncParametros: string);
var
  intCnt : integer ;
begin
  cdsParametrosContas.DisableControls ;
  try
    for intCnt := Low(AArrSel) to High(AArrSel) do
    begin
      ////evita duplicidade
      if cdsParametrosContas.FindKey([AArrSel[intCnt].strCodigo, AAutoIncParametros]) then
      begin
        continue ;
      end;
      ///
      cdsParametrosContas.Append ;
      cdsParametrosContas.FieldByName('DMP_SEQLAN').AsString := AAutoIncParametros ;
      cdsParametrosContas.FieldByName('DMP_CODCON').AsString := AArrSel[intCnt].strCodigo ;
      cdsParametrosContas.FieldByName('NCO_DESCRI').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [AArrSel[intCnt].strCodigo], False);
      cdsParametrosContas.Post ;
    end;
  finally
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pLimpaConfiguracaoContaTitulo(
  const AAutoInc: String);
begin
  pModoEdicaoGrid(GridMovimentacaoView) ;
  GridMovimentacaoViewDMP_HISPAD.DataBinding.Field.Clear ;
  GridMovimentacaoViewPAD_DESCRI.DataBinding.Field.Clear ;
  GridMovimentacaoViewDMP_NOTEXP.DataBinding.Field.Clear ;
  ///limpa as contas
  ///crédito
  try
    cdsMovimentacaoConCre.Filter := 'DMP_SEQDMP = '+quotedstr(AAutoInc) ;
    cdsMovimentacaoConCre.Filtered := True ;
    cdsMovimentacaoConCre.First ;
    while not cdsMovimentacaoConCre.Eof do
    begin
      cdsMovimentacaoConCre.Delete ;
    end;
  finally
    cdsMovimentacaoConCre.Filtered := False ;
  end;

  ///débito
  try
    cdsMovimentacaoConDeb.Filter := 'DMP_SEQDMP = '+quotedstr(AAutoInc) ;
    cdsMovimentacaoConDeb.Filtered := True ;
    cdsMovimentacaoConDeb.First ;
    while not cdsMovimentacaoConDeb.Eof do
    begin
      cdsMovimentacaoConDeb.Delete ;
    end;
  finally
    cdsMovimentacaoConDeb.Filtered := False ;
  end;

  pOcorrenciaMovimentacao(AAutoInc) ;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pLimparItensGridGeracao;
var
  intCnt : integer ;
begin
  ////limpa as colunas
  for intCnt := GridGeracaoView.ColumnCount-1 downto 0 do
  begin
    if TcxGridDBBandedColumn(GridGeracaoView.Columns[intCnt]).Tag <> 0 then
    begin
      GridGeracaoView.Columns[intCnt].Free;
    end;
  end;
  ////limpa as bandas
  for intCnt := GridGeracaoView.Bands.Count-1 downto 0 do
  begin
    if GridGeracaoView.Bands.Items[intCnt].Tag <> 0 then
    begin
      GridGeracaoView.Bands.Items[intCnt].Free;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pManutencaoContaContabilMovimentacao(
  const ACreDeb: String);
var
  frmDemonstracaoFluxoCaixaContasContabeis : TfrmDemonstracaoFluxoCaixaContasContabeis ;
  cdsTemp : TUniClientDataSet ;
  cdsConta : TUniClientDataSet ;
begin
  inherited;
  cdsConta := fGetContaContabilMovimentacaoByCreDeb(ACreDeb) ;

  pCriarFormularios(TfrmDemonstracaoFluxoCaixaContasContabeis, frmDemonstracaoFluxoCaixaContasContabeis);
  cdsTemp := TUniClientDataSet.Create(Self);
  try
    pCloneDataSet(cdsTemp, cdsConta);

    cdsConta.Filter := 'DMP_SEQDMP = '+quotedstr(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
    cdsConta.Filtered := True ;
    frmDemonstracaoFluxoCaixaContasContabeis.StrAutoIncParametros := cdsMovimentacao.FieldByName('AUTOINCREM').AsString ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldCodCon := 'DMP_CODCON' ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldDescri := 'NCO_DESCRI' ;
    frmDemonstracaoFluxoCaixaContasContabeis.strFieldSeqLan := 'DMP_SEQDMP' ;
    frmDemonstracaoFluxoCaixaContasContabeis.dsPlanco.DataSet := cdsConta ;
    frmDemonstracaoFluxoCaixaContasContabeis.blnModoEdicao := fEmEdicaoMovimentacao ;
    frmDemonstracaoFluxoCaixaContasContabeis.ShowModal ;
    if frmDemonstracaoFluxoCaixaContasContabeis.ModalResult = idOK then
    begin
      pVerificaContaContabilAposManutencao(cdsConta, ACreDeb, cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
      pOcorrenciaMovimentacao(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
    end
    else
    begin
      cdsConta.Close ;
      cdsConta.IndexName := '' ;
      cdsConta.Open ;
      cdsConta.Data := cdsTemp.Data ;
      pCriaIndexContaContabil(ACreDeb) ;
    end;
  finally
    FreeAndNil(cdsTemp) ;
    pFreeAndNil(frmDemonstracaoFluxoCaixaContasContabeis) ;
    cdsConta.Filtered := False ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pMensagemInformativa(
  const AMensagem: String; AMensagemSufixo: String = ''; AMensagemPrefixo: String = '');
var
  LStrMensagem : string ;
  frmObservacao : TfrmObservacao ;
begin
  if fEmptyStr(AMensagem) then
  begin
    exit ;
  end;

  frmObservacao := TfrmObservacao.Create(Nil) ;
  try
    LStrMensagem := '' ;
    if not fEmptyStr(AMensagemSufixo) then
    begin
      LStrMensagem := AMensagemSufixo + #13#10 ;
    end;
    LStrMensagem := LStrMensagem + AMensagem ;
    if not fEmptyStr(AMensagemPrefixo) then
    begin
      LStrMensagem := LStrMensagem + #13#10 + AMensagemPrefixo ;
    end;
    frmObservacao.blnUtilizarConfirmacao := False ;
    frmObservacao.memObs.Text := LStrMensagem ;
    frmObservacao.lblMensagem.Caption := 'Atenção!' ;
    frmObservacao.ShowModal ;
  finally
    pFreeAndNil(frmObservacao) ;
  end;

end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pMergeStringListsSemDuplicados(
  const ADest, AList1, AList2, AList3: TStringList);
begin
  ADest.Clear;
  ADest.Sorted := True;
  ADest.Duplicates := dupIgnore;

  ADest.AddStrings(AList1);
  ADest.AddStrings(AList2);
  ADest.AddStrings(AList3);
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pModoEdicaoGrid(
  const AGridTableView: TcxGridDBTableView);
begin
  if not AGridTableView.DataController.IsEditing then
  begin
    AGridTableView.DataController.Edit ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pOcorrenciaContas(
  const AAutoIncParametros: string);
var
  intCount : integer ;
begin
  cdsParametros.DisableControls ;
  cdsParametrosContas.DisableControls ;
  try
    if fEmptyStr(AAutoIncParametros) then
    begin
      cdsParametros.First ;
      while not cdsParametros.Eof do
      begin
        try
          cdsParametrosContas.Filter := 'DMP_SEQLAN = '+quotedstr(cdsParametros.FieldByName('AUTOINCREM').AsString) ;
          cdsParametrosContas.Filtered := True ;
          intCount := cdsParametrosContas.RecordCount ;
          cdsParametros.Edit ;
          cdsParametros.FieldByName('CNT_BTN').AsString := iif(intCount <> 0, '+'+inttostr(intCount), '') ;
          cdsParametros.Post ;
        finally
          cdsParametrosContas.Filtered := False ;
        end;
        cdsParametros.Next ;
      end;
    end
    else
    begin
      try
        cdsParametrosContas.Filter := 'DMP_SEQLAN = '+quotedstr(AAutoIncParametros) ;
        cdsParametrosContas.Filtered := True ;
        intCount := cdsParametrosContas.RecordCount ;
        pModoEdicaoGrid(GridParametrosView) ;
        GridParametrosViewCNT_BTN.DataBinding.Field.AsString := iif(intCount <> 0, '+'+inttostr(intCount), '') ;

      finally
        cdsParametrosContas.Filtered := False ;
      end;
    end;
  finally
    cdsParametros.EnableControls ;
    cdsParametrosContas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pOcorrenciaMovimentacao(
  const AAutoInc: string);
var
  intCountConCre : integer ;
  intCountConDeb : integer ;
begin
  cdsMovimentacao.DisableControls ;
  cdsMovimentacaoConCre.DisableControls ;
  cdsMovimentacaoConDeb.DisableControls ;
  try
    if fEmptyStr(AAutoInc) then
    begin
      cdsMovimentacao.First ;
      while not cdsMovimentacao.Eof do
      begin

        try
          cdsMovimentacaoConCre.Filter := 'DMP_SEQDMP = '+quotedstr(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
          cdsMovimentacaoConCre.Filtered := True ;
          intCountConCre := cdsMovimentacaoConCre.RecordCount ;
        finally
          cdsMovimentacaoConCre.Filtered := False ;
        end;

        try
          cdsMovimentacaoConDeb.Filter := 'DMP_SEQDMP = '+quotedstr(cdsMovimentacao.FieldByName('AUTOINCREM').AsString) ;
          cdsMovimentacaoConDeb.Filtered := True ;
          intCountConDeb := cdsMovimentacaoConDeb.RecordCount ;
        finally
          cdsMovimentacaoConDeb.Filtered := False ;
        end;

        cdsMovimentacao.Edit ;
        cdsMovimentacao.FieldByName('DMP_CONCRE').AsString := iif(intCountConCre <> 0, '+'+inttostr(intCountConCre), '') ;
        cdsMovimentacao.FieldByName('DMP_CONDEB').AsString := iif(intCountConDeb <> 0, '+'+inttostr(intCountConDeb), '') ;
        cdsMovimentacao.Post ;

        cdsMovimentacao.Next ;
      end;
    end
    else
    begin
      try
        cdsMovimentacaoConCre.Filter := 'DMP_SEQDMP = '+quotedstr(AAutoInc) ;
        cdsMovimentacaoConCre.Filtered := True ;
        intCountConCre := cdsMovimentacaoConCre.RecordCount ;
      finally
        cdsMovimentacaoConCre.Filtered := False ;
      end;

      try
        cdsMovimentacaoConDeb.Filter := 'DMP_SEQDMP = '+quotedstr(AAutoInc) ;
        cdsMovimentacaoConDeb.Filtered := True ;
        intCountConDeb := cdsMovimentacaoConDeb.RecordCount ;
      finally
        cdsMovimentacaoConDeb.Filtered := False ;
      end;

      pModoEdicaoGrid(GridMovimentacaoView) ;
      GridMovimentacaoViewDMP_CONCRE.DataBinding.Field.AsString := iif(intCountConCre <> 0, '+'+inttostr(intCountConCre), '') ;
      GridMovimentacaoViewDMP_CONDEB.DataBinding.Field.AsString := iif(intCountConDeb <> 0, '+'+inttostr(intCountConDeb), '') ;

    end;
  finally
    cdsMovimentacao.EnableControls ;
    cdsMovimentacaoConCre.EnableControls ;
    cdsMovimentacaoConDeb.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pPesquisaHistoricoMovimentacao;
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
begin
  chrKey := '/';
  If fPesqHistoricoMovimentacao(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      GridMovimentacaoViewDMP_CODMOV.Properties.OnEditValueChanged := nil ;
      try
        pModoEdicaoGrid(GridMovimentacaoView) ;
        GridMovimentacaoViewDMP_CODMOV.DataBinding.Field.AsInteger := strToint(arrPesq[0].strCodigo) ;
        GridMovimentacaoViewHST_DESCRI.DataBinding.Field.AsString := fCampoTabela('HST_DESCRI', 'HISTMV', ['HST_CODIGO'], [arrPesq[0].strCodigo], False);
      finally
        GridMovimentacaoViewDMP_CODMOV.Properties.OnEditValueChanged := GridMovimentacaoViewDMP_CODMOVPropertiesEditValueChanged ;
      end;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pPesquisaHistoricoPadrao;
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
begin
  chrKey := '/';
  If fPesqHistoricoPadrao(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      GridMovimentacaoViewDMP_HISPAD.Properties.OnEditValueChanged := nil ;
      try
        pModoEdicaoGrid(GridMovimentacaoView) ;
        GridMovimentacaoViewDMP_HISPAD.DataBinding.Field.AsInteger := strToint(arrPesq[0].strCodigo) ;
        GridMovimentacaoViewPAD_DESCRI.DataBinding.Field.AsString := fCampoTabela('PAD_DESCRI', 'HISPAD', ['PAD_CODIGO'], [arrPesq[0].strCodigo], False);
      finally
        GridMovimentacaoViewDMP_HISPAD.Properties.OnEditValueChanged := GridMovimentacaoViewDMP_HISPADPropertiesEditValueChanged ;
      end;
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pPesquisaNotasExplicativas;
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
begin

  if edtExercicioNtExpl.Value <= 0 then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!' , ['&Ok']);
    pSetFocus(edtExercicioNtExpl) ;
    exit ;
  end;

  chrKey := '/';
  If fPesqNotaExplicativaV2(Self, Nil, Nil, Nil, chrKey, arrPesq, False, edtExercicioNtExpl.Value) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      pModoEdicaoGrid(GridNotasExplicativasView) ;
      GridNotasExplicativasViewDMP_CODEXP.DataBinding.Field.AsInteger := strToint(arrPesq[0].strCodigo) ;
      GridNotasExplicativasViewEXP_NOTEXP.DataBinding.Field.AsString := fCampoTabela('EXP_NOTEXP', 'NTEXPL', ['EXP_CODIGO'], [arrPesq[0].strCodigo], False);
    end;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pPreparaNewItemRowGrid(const AGridTableView: TcxGridDBTableView);
begin
  if AGridTableView.Controller.IsNewItemRowFocused then
  begin
    if not AGridTableView.DataController.IsEditing then
    begin
      AGridTableView.DataController.Insert ;
    end;
  end;
  AGridTableView.Controller.EditingController.ShowEdit ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pRefreshPorPagina(
  APagina: TcxTabSheet);
begin
  if APagina = tsCadastroMovimentacao then
  begin
    pCarregaDadosMovimentacao(edtExercicioMovime.Value, edtEmpSel03.Text) ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pReplicaExercicio(
  const AExercicio: integer; const ACodEmp: String);
begin
  if (AExercicio = 0) and (fEmptyStr(ACodEmp)) then
    exit ;

  cdsParametros.DisableControls ;
  try
    cdsParametros.First ;
    while not cdsParametros.Eof do
    begin
      cdsParametros.Edit ;
      cdsParametros.FieldByName('DMP_EXERCI').AsInteger := AExercicio ;
      cdsParametros.FieldByName('DMP_CODEMP').AsString := ACodEmp ;
      cdsParametros.Post ;
      cdsParametros.Next ;
    end;
  finally
    cdsParametros.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pReplicaExercicioMovimentacao(
  const AExercicio: integer; const ACodEmp: String);
var
  strNomeIndiceAnterior : string ;
begin
  if (AExercicio = 0) and (fEmptyStr(ACodEmp)) then
    exit ;

  strNomeIndiceAnterior := cdsMovimentacao.IndexName ;
  cdsMovimentacao.DisableControls ;
  try
    cdsMovimentacao.IndexName := '' ;
    cdsMovimentacao.First ;
    while not cdsMovimentacao.Eof do
    begin
      cdsMovimentacao.Edit ;
      cdsMovimentacao.FieldByName('DMP_EXERCI').AsInteger := AExercicio ;
      cdsMovimentacao.FieldByName('DMP_CODEMP').AsString := ACodEmp ;
      cdsMovimentacao.Post ;
      cdsMovimentacao.Next ;
    end;
  finally
    cdsMovimentacao.IndexName := strNomeIndiceAnterior ;
    cdsMovimentacao.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pReplicaExercicioNotasExplicativas(
  const AExercicio: integer; const ACodEmp: String);
var
  strNomeIndiceAnterior : string ;
begin
  if (AExercicio = 0) and (fEmptyStr(ACodEmp)) then
    exit ;

  strNomeIndiceAnterior := cdsNotasExplicativas.IndexName ;
  cdsNotasExplicativas.DisableControls ;
  try
    cdsNotasExplicativas.IndexName := '' ;
    cdsNotasExplicativas.First ;
    while not cdsNotasExplicativas.Eof do
    begin
      cdsNotasExplicativas.Edit ;
      cdsNotasExplicativas.FieldByName('DMP_EXERCI').AsInteger := AExercicio ;
      cdsNotasExplicativas.FieldByName('DMP_CODEMP').AsString := ACodEmp ;
      cdsNotasExplicativas.Post ;
      cdsNotasExplicativas.Next ;
    end;
  finally
    cdsNotasExplicativas.IndexName := strNomeIndiceAnterior ;
    cdsNotasExplicativas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pSelecionaNotasExplicativasNaMovimentacao(
  const ACdsMovimentacao, ACdsMovimentacaoNotas: TUniClientDataSet);
var
  strSelecao: string ;
begin
  ACdsMovimentacao.DisableControls ;
  ACdsMovimentacaoNotas.DisableControls ;
  try
    ACdsMovimentacao.First ;
    while not ACdsMovimentacao.Eof do
    begin
      strSelecao := '' ;
      if ACdsMovimentacaoNotas.FindKey([ACdsMovimentacao.FieldByName('AUTOINCREM').AsString]) then
      begin
        while (ACdsMovimentacao.FieldByName('AUTOINCREM').AsString = ACdsMovimentacaoNotas.FieldByName('DMP_SEQDMP').AsString)
              and (not ACdsMovimentacaoNotas.Eof) do
        begin
          strSelecao := strSelecao + inttostr(Length(ACdsMovimentacaoNotas.FieldByName('EXP_NOTEXP').AsString))+':'+ACdsMovimentacaoNotas.FieldByName('EXP_NOTEXP').AsString ;
          ACdsMovimentacaoNotas.Next ;
        end;
        strSelecao := ';' +strSelecao ;
      end;
      ACdsMovimentacao.Edit ;
      ACdsMovimentacao.FieldByName('DMP_NOTEXP').AsString := strSelecao ;
      ACdsMovimentacao.Post ;
      ACdsMovimentacao.Next ;
    end;
  finally
    ACdsMovimentacao.EnableControls ;
    ACdsMovimentacaoNotas.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pVerificaContaContabilAposManutencao(
  var ACdsConta: TUniClientDataSet; const ACreDeb, AAutoInc: String);
var
  strConta : string ;
  strMensagem : string ;
begin
  strMensagem := '' ;
  ACdsConta.First ;
  while not ACdsConta.Eof do
  begin
    ////verifica se a conta está no cdsEspelho
    strConta := fVerificaContabilMovimentacaoEspelho(AAutoInc, ACdsConta.FieldByName('DMP_CODCON').AsString, ACreDeb) ;
    if not fEmptyStr(strConta) then
    begin
      strMensagem := strMensagem + strConta + ' - ' + fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strConta], False) + #13#10 ;
      ACdsConta.Delete ;
      continue ;
    end;
    ///
    ACdsConta.Next ;
  end;
  pMensagemInformativa(strMensagem, 'As seguintes contas contábeis foram descartadas!'+ #13#10 + 'Pois estão adicionadas em Contas do PL ('+iif(fGetCreDebEspelho(ACreDeb) = 'C', 'Crédito', 'Débito')+')' + #13#10  );
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pVerificaDivergencia(
  const AValorPL: double);
var
  fltValorGerado: double ;
  LValorPL: double ;
begin
  cdsGerar.DisableControls ;
  try
    cdsGerar.First ;
    fltValorGerado := 0.00 ;
    while not cdsGerar.Eof do
    begin
      fltValorGerado := fltValorGerado + cdsGerar.FieldByName('TMP_TOTAL_').AsFloat ;
      cdsGerar.Next ;
    end;
    cdsGerar.First ;

    LValorPL := roundto(abs(AValorPL),-2) ;
    fltValorGerado := roundto(abs(fltValorGerado),-2) ;

    if fltValorGerado <> LValorPL then
    begin
      lbAtencaoDivergencia.Caption := 'Valor do patrimônio liquido ('+FormatCurr('#,##0.00',LValorPL)+') divergente da DMPL ('+FormatCurr('#,##0.00',fltValorGerado)+')' ;
      lbAtencaoDivergencia.Visible := True ;
    end;

  finally
    cdsGerar.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pOnPostErrorMovimentacao(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if pos('key violation',lowerCase(E.Message)) > 0 then
  begin
    Action := daAbort ;
    fMensagem('ATENÇÃO!', 'Movimentação duplicada no exercício!' , ['&Ok']);
  end
  else if pos('must have a value',lowerCase(E.Message)) > 0 then
  begin
    Action := daAbort ;
    fMensagem('ATENÇÃO!', 'Coluna com valor obrigatório!'+#13+'Informe um valor ou tecle [ESC] para cancelar!' , ['&Ok']);
  end ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pOnPostErrorNotasExplicativas(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  if pos('key violation',lowerCase(E.Message)) > 0 then
  begin
    Action := daAbort ;
    fMensagem('ATENÇÃO!', 'Nota explicativa duplicada no exercício!' , ['&Ok']);
  end
  else if pos('must have a value',lowerCase(E.Message)) > 0 then
  begin
    Action := daAbort ;
    fMensagem('ATENÇÃO!', 'Coluna com valor obrigatório!'+#13+'Informe um valor ou tecle [ESC] para cancelar!' , ['&Ok']);
  end;
end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fGerarDados(
  pgbProgresso: TcxProgressBar): boolean;
var
  objGerar : TDemonstracaoMutacaoPatrimonioLiquidoGerar  ;
  lstEmpresas : TStringList ;
  LCdsColunas, LCdsBandas : TUniClientDataSet ;
begin
  Result := True;
  pgbProgresso.Properties.Max := 6 ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando' + ' Lançamentos: DMPL ' + cbAnoExercicio.Text);

  dsGerar.Enabled := False ;
  dsGerar.DataSet := Nil ;
  if Assigned(cdsGerar) then
  begin
    FreeAndNil(cdsGerar) ;
  end;


  lstEmpresas := fEmpresasArrToList ;
  objGerar := TDemonstracaoMutacaoPatrimonioLiquidoGerar.Create  ;
  try
    objGerar.AnoExercicio := strtoint(cbAnoExercicio.Text) ;
    objGerar.Empresas.Assign(lstEmpresas);
    objGerar.Simplificado := chkSimplificada.Checked ;
    objGerar.NaoMostrarColunasSemLancamento := chkNaoMostrarColunaSemValor.Checked ;
    objGerar.NaoMostrarLinhasSemLancamento := chkNaoMostrarLinhaSemValor.Checked ;
    objGerar.Progresso := pgbProgresso ;
    cdsGerar := objGerar.Processar ;
    if not Assigned(cdsGerar) then
    begin
      exit ;
    end;

    dsGerar.DataSet := cdsGerar ;
    dsGerar.Enabled := True ;

    LCdsColunas := objGerar.cdsColunas ;
    LCdsBandas := objGerar.cdsBandas ;

    pCriarColunas(chkSimplificada.Checked, LCdsColunas, LCdsBandas) ;

    pVerificaDivergencia(objGerar.fCalculaValorPatrimonioLiquidoPrimeiraAba(strtoint(cbAnoExercicio.Text), lstEmpresas)) ;

    pgbProgresso.Position := 0;
    Application.ProcessMessages;

  finally
    FreeAndNil(objGerar) ;
    FreeAndNil(lstEmpresas) ;
  end;
  pBotoesGerar(False) ;

end;

function TfrmDemonstracaoMutacaoPatrimonioLiquido.fValidaImpressao: boolean;
begin
  result := False ;
  if (chkImprimirAssinatura.Checked) or (chkImprimirParaArquivo.Checked) then
  begin
    if cbResponsavelEmpresa.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'Responsável empresa não selecionado!' , ['&Ok']);
      pSetFocus(cbResponsavelEmpresa);
      exit ;
    end;

    if cbResponsavelContador.ItemIndex = -1 then
    begin
      fMensagem('ATENÇÃO!', 'Responsável contador não selecionado!' , ['&Ok']);
      pSetFocus(cbResponsavelContador);
      exit ;
    end;
  end;
  result := True ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pCarregaDadosRelatorio(var ADadosRelatorio: TUniClientDataSet; const ASimplificado: boolean);
begin
  ADadosRelatorio.EmptyDataSet ;
  cdsGerar.DisableControls ;
  try
    cdsGerar.First ;
    while not cdsGerar.Eof do
    begin
      ADadosRelatorio.Append ;
      ADadosRelatorio.FieldByName('HISTMV').AsString := cdsGerar.FieldByName('TMP_HISTMV').AsString ;
      ADadosRelatorio.FieldByName('NTEXPL').AsString := cdsGerar.FieldByName('TMP_NTEXPL').AsString ;
      ADadosRelatorio.FieldByName('_00002').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000002').AsFloat) ;
      ADadosRelatorio.FieldByName('_00019').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000019').AsFloat) ;
      if ASimplificado then
      begin
        ADadosRelatorio.FieldByName('_00003').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000003').AsFloat) ;
        ADadosRelatorio.FieldByName('_00008').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000008').AsFloat) ;
        ADadosRelatorio.FieldByName('_00012').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000012').AsFloat) ;
      end
      else
      begin
        ADadosRelatorio.FieldByName('_00004').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000004').AsFloat) ;
        ADadosRelatorio.FieldByName('_00005').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000005').AsFloat) ;
        ADadosRelatorio.FieldByName('_00006').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000006').AsFloat) ;
        ADadosRelatorio.FieldByName('_00009').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000009').AsFloat) ;
        ADadosRelatorio.FieldByName('_00010').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000010').AsFloat) ;
        ADadosRelatorio.FieldByName('_00013').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000013').AsFloat) ;
        ADadosRelatorio.FieldByName('_00014').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000014').AsFloat) ;
        ADadosRelatorio.FieldByName('_00015').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000015').AsFloat) ;
        ADadosRelatorio.FieldByName('_00016').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000016').AsFloat) ;
        ADadosRelatorio.FieldByName('_00017').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_000017').AsFloat) ;
      end;
      ADadosRelatorio.FieldByName('TOTAL_').AsString := fTrataNumeroFloatRelatorio(cdsGerar.FieldByName('TMP_TOTAL_').AsFloat) ;
      ADadosRelatorio.Post ;
      cdsGerar.Next ;
    end;
  finally
    cdsGerar.EnableControls ;
  end;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pShowComboResponsavel(
  const AAssinatura, AArquivo: Boolean);
var
  LCondicao: boolean ;
begin
  LCondicao := AAssinatura or AArquivo ;

  lbResponsavelEmpresa.Visible := LCondicao ;
  cbResponsavelEmpresa.Visible := LCondicao ;
  lbResponsavelContador.Visible := LCondicao ;
  cbResponsavelContador.Visible := LCondicao ;
end;

procedure TfrmDemonstracaoMutacaoPatrimonioLiquido.pTotalizaRelatorio(
  var ARelatorio: TfrxReport; const ASimplificado: boolean);
var
  L002, L003, L008, L012, L019: double ;
  L004, L005, L006, L009, L010, L013, L014, L015, L016, L017: double ;
  LTotal: double ;
begin
  L002 := 0 ;
  L003 := 0 ;
  L008 := 0 ;
  L012 := 0 ;
  L019 := 0 ;
  L004 := 0 ;
  L005 := 0 ;
  L006 := 0 ;
  L009 := 0 ;
  L010 := 0 ;
  L013 := 0 ;
  L014 := 0 ;
  L015 := 0 ;
  L016 := 0 ;
  L017 := 0 ;
  LTotal := 0 ;

  cdsGerar.First ;
  while not cdsGerar.Eof do
  begin

    L002 := L002 + cdsGerar.FieldByName('TMP_000002').AsFloat ;
    L019 := L019 + cdsGerar.FieldByName('TMP_000019').AsFloat ;
    if ASimplificado then
    begin
      L003 := L003 + cdsGerar.FieldByName('TMP_000003').AsFloat ;
      L008 := L008 + cdsGerar.FieldByName('TMP_000008').AsFloat ;
      L012 := L012 + cdsGerar.FieldByName('TMP_000012').AsFloat ;
    end
    else
    begin
      L004 := L004 + cdsGerar.FieldByName('TMP_000004').AsFloat ;
      L005 := L005 + cdsGerar.FieldByName('TMP_000005').AsFloat ;
      L006 := L006 + cdsGerar.FieldByName('TMP_000006').AsFloat ;
      L009 := L009 + cdsGerar.FieldByName('TMP_000009').AsFloat ;
      L010 := L010 + cdsGerar.FieldByName('TMP_000010').AsFloat ;
      L013 := L013 + cdsGerar.FieldByName('TMP_000013').AsFloat ;
      L014 := L014 + cdsGerar.FieldByName('TMP_000014').AsFloat ;
      L015 := L015 + cdsGerar.FieldByName('TMP_000015').AsFloat ;
      L016 := L016 + cdsGerar.FieldByName('TMP_000016').AsFloat ;
      L017 := L017 + cdsGerar.FieldByName('TMP_000017').AsFloat ;
    end;
    LTotal := LTotal + cdsGerar.FieldByName('TMP_TOTAL_').AsFloat ;

    cdsGerar.Next ;
  end;

  ARelatorio.Script.Variables['GR_0002'] := fTrataNumeroFloatRelatorio(L002);
  ARelatorio.Script.Variables['GR_0003'] := fTrataNumeroFloatRelatorio(L003);
  ARelatorio.Script.Variables['GR_0008'] := fTrataNumeroFloatRelatorio(L008);
  ARelatorio.Script.Variables['GR_0012'] := fTrataNumeroFloatRelatorio(L012);
  ARelatorio.Script.Variables['GR_0019'] := fTrataNumeroFloatRelatorio(L019);

  ARelatorio.Script.Variables['GR_0004'] := fTrataNumeroFloatRelatorio(L004);
  ARelatorio.Script.Variables['GR_0005'] := fTrataNumeroFloatRelatorio(L005);
  ARelatorio.Script.Variables['GR_0006'] := fTrataNumeroFloatRelatorio(L006);
  ARelatorio.Script.Variables['GR_0009'] := fTrataNumeroFloatRelatorio(L009);
  ARelatorio.Script.Variables['GR_0010'] := fTrataNumeroFloatRelatorio(L010);
  ARelatorio.Script.Variables['GR_0013'] := fTrataNumeroFloatRelatorio(L013);
  ARelatorio.Script.Variables['GR_0014'] := fTrataNumeroFloatRelatorio(L014);
  ARelatorio.Script.Variables['GR_0015'] := fTrataNumeroFloatRelatorio(L015);
  ARelatorio.Script.Variables['GR_0016'] := fTrataNumeroFloatRelatorio(L016);
  ARelatorio.Script.Variables['GR_0017'] := fTrataNumeroFloatRelatorio(L017);
  ARelatorio.Script.Variables['GR_TOTAL'] := fTrataNumeroFloatRelatorio(LTotal);

end;

end.
