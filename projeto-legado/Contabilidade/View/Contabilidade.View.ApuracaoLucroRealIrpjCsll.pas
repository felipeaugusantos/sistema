unit Contabilidade.View.ApuracaoLucroRealIrpjCsll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, cxControls, cxContainer, cxEdit, EditFocus,
  cxLabel, dxBarBuiltInMenu, cxPC, cxSplitter, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, cxCalc, System.Generics.Collections,
  Contabilidade.Interfaces, cxProgressBar, cxTextEdit, cxCurrencyEdit,
  Contabilidade.Classes.ApuracaoLucroRealIrpjCsll, cxGroupBox, cxMaskEdit,
  cxDropDownEdit;

type
  TArrayPeriodo = array of string ;
  TfrmApuracaoLucroRealIrpjCsll = class(TfrmPaiContabilidade)
    gbFiltroInicial: TGroupBox;
    btnAbrir: TcxButton;
    cxLabel1: TcxLabel;
    edtExercicio: TEditFocus;
    btnFechar: TcxButton;
    pgCalculos: TcxPageControl;
    tsApuracaoReceitasAcrescimos: TcxTabSheet;
    tsDeducoesRetencoesCSLL: TcxTabSheet;
    tsDeducoesRetencoesIRPJ: TcxTabSheet;
    tsDemonstrativoApuracao: TcxTabSheet;
    tsDeterminacaoEstimativasMensais: TcxTabSheet;
    pnlApuRecAcrIrpj: TPanel;
    Splitter: TcxSplitter;
    GridCitelApuRecAcrCsllTableView: TcxGridDBTableViewCitel;
    GridCitelApuRecAcrCsllLevel: TcxGridLevel;
    GridCitelApuRecAcrCsll: TcxGridCitel;
    GridCitelApuRecAcrIrpjTableView: TcxGridDBTableViewCitel;
    GridCitelApuRecAcrIrpjLevel: TcxGridLevel;
    GridCitelApuRecAcrIrpj: TcxGridCitel;
    dsApuRecAcrCsll: TDataSource;
    dsApuRecAcrIrpj: TDataSource;
    GridCitelApuRecAcrCsllTableViewCODIGO: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewDESCRI: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL01: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL02: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL03: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL04: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL05: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL06: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL07: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL08: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL09: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL10: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL11: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCAL12: TcxGridDBColumn;
    GridCitelApuRecAcrCsllTableViewBCALTT: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewCODIGO: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewDESCRI: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL01: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL02: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL03: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL04: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL05: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL06: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL07: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL08: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL09: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL10: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL11: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCAL12: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewBCALTT: TcxGridDBColumn;
    pnlBotoesApuRecAcr: TPanel;
    btnConfirmarApuRecAcr: TcxButton;
    btnCancelarApuRecAcr: TcxButton;
    GridCitelApuRecAcrCsllTableViewPERCEN: TcxGridDBColumn;
    GridCitelApuRecAcrIrpjTableViewPERCEN: TcxGridDBColumn;
    EstiloRepositorio: TcxStyleRepository;
    sltLinhaDestacada: TcxStyle;
    GridCitelDedRetCsllTableView: TcxGridDBTableViewCitel;
    GridCitelDedRetCsllLevel: TcxGridLevel;
    GridCitelDedRetCsll: TcxGridCitel;
    pnlBotoesDedRetCsll: TPanel;
    btnConfirmarDedRetCsll: TcxButton;
    btnCancelarDedRetCsll: TcxButton;
    dsDedRetCsll: TDataSource;
    GridCitelDedRetIrpj: TcxGridCitel;
    GridCitelDedRetIrpjTableView: TcxGridDBTableViewCitel;
    GridCitelDedRetIrpjLevel: TcxGridLevel;
    pnlBotoesDedRetIrpj: TPanel;
    btnConfirmarDedRetIrpj: TcxButton;
    btnCancelarDedRetIrpj: TcxButton;
    dsDedRetIrpj: TDataSource;
    gbContribuicaoSocial: TcxGroupBox;
    gbImpostoRenda: TcxGroupBox;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    lblReceitaCsll: TcxLabel;
    edtBaseCalculoCsllBal: TcxCalcEdit;
    edtCsllBal: TcxCalcEdit;
    edtDeducaoCsllBal: TcxCalcEdit;
    edtCsllRecolherBal: TcxCalcEdit;
    edtBaseCalculoCslRec: TcxCalcEdit;
    edtCsllRec: TcxCalcEdit;
    edtCsllRecolherRec: TcxCalcEdit;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    cxLabel11: TcxLabel;
    cxLabel12: TcxLabel;
    edtBaseCalculoIrpjBal: TcxCalcEdit;
    edtBaseCalculoIrpjRec: TcxCalcEdit;
    edtIrpjBal: TcxCalcEdit;
    edtIrpjRec: TcxCalcEdit;
    edtDeducaoIrpjBal: TcxCalcEdit;
    edtIrpjRecolherBal: TcxCalcEdit;
    edtIrpjRecolherRec: TcxCalcEdit;
    edtAdicionalIrpjBal: TcxCalcEdit;
    edtAdicionalIrpjRec: TcxCalcEdit;
    cxLabel13: TcxLabel;
    lblReceitaIrpj: TcxLabel;
    cxLabel15: TcxLabel;
    edtPeriodo: TcxComboBox;
    gbAba05Csll: TcxGroupBox;
    gbAba05Irpj: TcxGroupBox;
    gbAba05Recolhimento: TcxGroupBox;
    GridCitelDetEstMenCsllTableView: TcxGridDBTableViewCitel;
    GridCitelDetEstMenCsllLevel: TcxGridLevel;
    GridCitelDetEstMenCsll: TcxGridCitel;
    GridCitellDetEstMenIrpjTableView: TcxGridDBTableViewCitel;
    GridCitellDetEstMenIrpjLevel: TcxGridLevel;
    GridCitellDetEstMenIrpj: TcxGridCitel;
    GridlDetEstMenCsllRecolhimentoTableView: TcxGridDBTableView;
    GridlDetEstMenCsllRecolhimentoLevel: TcxGridLevel;
    GridlDetEstMenCsllRecolhimento: TcxGrid;
    dsDetEstMenCsll: TDataSource;
    dsDetEstMenIrpj: TDataSource;
    dsDetEstMenRecolhimento: TDataSource;
    GridCitelDetEstMenCsllTableViewCODIGO: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewDESCRI: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR01: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR02: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR03: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR04: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR05: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR06: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR07: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR08: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR09: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR10: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR11: TcxGridDBColumn;
    GridCitelDetEstMenCsllTableViewEVLR12: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewCODIGO: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewDESCRI: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR01: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR02: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR03: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR04: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR05: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR06: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR07: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR08: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR09: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR10: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR11: TcxGridDBColumn;
    GridCitellDetEstMenIrpjTableViewEVLR12: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewCODIGO: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewDESCRI: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR01: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR02: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR03: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR04: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR05: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR06: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR07: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR08: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR09: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR10: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR11: TcxGridDBColumn;
    GridlDetEstMenCsllRecolhimentoTableViewEVLR12: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableView: TcxGridDBTableViewCitel;
    GridCitelDetEstMenOpcaoLevel: TcxGridLevel;
    GridCitelDetEstMenOpcao: TcxGridCitel;
    dsDetEstMenOpcao: TDataSource;
    GridCitelDetEstMenOpcaoTableViewCODIGO: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewDESCRI: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR01: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR02: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR03: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR04: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR05: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR06: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR07: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR08: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR09: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR10: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR11: TcxGridDBColumn;
    GridCitelDetEstMenOpcaoTableViewEVLR12: TcxGridDBColumn;
    pnlRecolhimentoIPRJ: TPanel;
    btnRecolhimentoIRPJ: TcxButton;
    pnlRecolhimentoCSLL: TPanel;
    btnRecolhimentoCSLL: TcxButton;
    cxLabel7: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAbrirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure pgCalculosPageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnConfirmarApuRecAcrClick(Sender: TObject);
    procedure btnCancelarApuRecAcrClick(Sender: TObject);
    procedure GridCitelApuRecAcrCsllTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure GridCitelApuRecAcrIrpjTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure GridCitelApuRecAcrCsllTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure GridCitelApuRecAcrIrpjTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure btnCancelarDedRetCsllClick(Sender: TObject);
    procedure btnCancelarDedRetIrpjClick(Sender: TObject);
    procedure btnConfirmarDedRetCsllClick(Sender: TObject);
    procedure btnConfirmarDedRetIrpjClick(Sender: TObject);
    procedure GridCitelDedRetCsllTableViewEditing(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      var AAllow: Boolean);
    procedure GridCitelDedRetCsllTableViewStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure edtPeriodoPropertiesEditValueChanged(Sender: TObject);
    procedure btnRecolhimentoCSLLClick(Sender: TObject);
    procedure btnRecolhimentoIRPJClick(Sender: TObject);
    procedure GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged(
      Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridlDetEstMenCsllRecolhimentoTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure GridlDetEstMenCsllRecolhimentoTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure GridCitelDetEstMenOpcaoTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure GridCitelDetEstMenOpcaoTableViewFocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FftForma: TFormaTributacao ;
    FecEncerramento: TEncerramentoContabil ;
    FlrdrCsll: TLucroRealDeducoesRetencoes ;
    FlrdrIrpj: TLucroRealDeducoesRetencoes ;
    FdaDemonstrativo: TDemonstrativoApuracao ;
    FdemEstimativaMensal: TDeterminacaoEstimativaMensal ;
    FaraApuracaoReceitasAcrecimos: TApuracaoReceitasAcrecimos ;
    procedure pHabilitaCalculos(const AblnHabilitar: boolean) ;
    function fCarregaCalculos(const AintExercicio: integer; ApgbProgresso: TcxProgressBar; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean ;
    function fExecCarregaCalculos(ApgbProgresso: TcxProgressBar): boolean ;
    function fCarregaApuDedRet(const AintExercicio: integer; const AiiTipo: TCsllIrpj; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean ;
    function fCarregaDemonstrativoApuracao(const AintExercicio: integer; const AecEncerramento: TEncerramentoContabil):boolean ;
    function fCarregaDeterminacaoEstimativa(const AintExercicio: integer; const AecEncerramento: TEncerramentoContabil):boolean ;
    procedure pLimpaCalulos;
    procedure pInformacoesAlteradasApuRecAcr(const AblnAlteradas: boolean) ;
    procedure pInformacoesAlteradasApuDedRetCsll(const AblnAlteradas: boolean) ;
    procedure pInformacoesAlteradasApuDedRetIrpj(const AblnAlteradas: boolean) ;
    function fFoiAlteradaApuRecAcr: boolean ;
    function fFoiAlteradaApuDedRetCsll: boolean ;
    function fFoiAlteradaApuDedRetIrpj: boolean ;
    procedure pApuRecAcrAfterEdit(DataSet: TDataSet) ;
    procedure pApuRecAcrCsllAfterPost(DataSet: TDataSet) ;
    procedure pApuRecAcrIrpjAfterPost(DataSet: TDataSet) ;
    procedure pApuDedRetCsllAfterPost(DataSet: TDataSet) ;
    procedure pApuDedRetIrpjAfterPost(DataSet: TDataSet) ;
    procedure pApuDedRetCsllAfterEdit(DataSet: TDataSet) ;
    procedure pApuDedRetIrpjAfterEdit(DataSet: TDataSet) ;
    function fExecCancelaApuRecAcr(ApgbProgresso: TcxProgressBar): boolean ;
    function fExecCancelaApuDedRetCsll(ApgbProgresso: TcxProgressBar): boolean ;
    function fExecCancelaApuDedRetIrpj(ApgbProgresso: TcxProgressBar): boolean ;
    function fExecGravaApuRecAcr(ApgbProgresso: TcxProgressBar): boolean ;
    function fExecGravaApuDedRetCsll(ApgbProgresso: TcxProgressBar): boolean ;
    function fExecGravaApuDedRetIrpj(ApgbProgresso: TcxProgressBar): boolean ;
    procedure pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; AstrTexto: String);
    function fIsAssignedProgresso(ApgbProgresso: TcxProgressBar): boolean;
    procedure pCriaColunasGrid(var AGridTableView: TcxGridDBTableViewCitel; const AecEncerramento: TEncerramentoContabil) ;
    function fRetornaColbyFieldName(Sender: TcxCustomGridTableView; FieldName: String): TcxCustomGridTableItem;
    procedure pCarregaDadosDemonstrativo(const AdtaDataInicial, AdtaDataFinal: TDateTime) ;
    procedure pCaptionColunaGridPeriodo(AgridTableView: TcxCustomGridTableView) ;
    function fArrPeriodo(const AecEncerramento: TEncerramentoContabil): TArrayPeriodo ;
    procedure pAjustaColunasEstimativasMensaisPelaResolucaoTela ;
    procedure pCalculaTamanhoColunaGrid(var AintWidthColuna: integer) ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

const
  DES_ARRAY_MES : array[1..12] of string = ('Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro') ;
  DES_ARRAY_TRIMESTRE : array[1..4] of string = ('1º Trimestre', '2º Trimestre', '3º Trimestre', '4º Trimestre') ;

implementation

uses untFuncoesSimples, Contabilidade.Classes.ApuracaoLucroRealLalurLacs,
     untConsultas, untTypesSistema ;

{$R *.dfm}

procedure TfrmApuracaoLucroRealIrpjCsll.btnAbrirClick(Sender: TObject);
begin
  inherited;

  if fEmptyStr(edtExercicio.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  if not fValidarExercicioInformado(edtExercicio.Text, edtEmpSel.Text, FftForma, FecEncerramento) then
  begin
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  if FecEncerramento = ecTrimestral then
  begin
    // manda o foco para a segunda aba
    pgCalculos.ActivePageIndex := 1 ;
  end;

  Try
    fChamaTelaGravando(fExecCarregaCalculos) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;

end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnCancelarApuRecAcrClick(
  Sender: TObject);
begin
  inherited;

  Try
    fChamaTelaGravando(fExecCancelaApuRecAcr) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
  
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnCancelarDedRetCsllClick(
  Sender: TObject);
begin
  inherited;

  if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar as alterações?', ['&Sim', '&Não'], 2) = 2 then
  begin
    exit ;
  end;

  Try
    fChamaTelaGravando(fExecCancelaApuDedRetCsll) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnCancelarDedRetIrpjClick(
  Sender: TObject);
begin
  inherited;

  if fMensagem('ATENÇÃO!', 'Deseja realmente cancelar as alterações?', ['&Sim', '&Não'], 2) = 2 then
  begin
    exit ;
  end;

  Try
    fChamaTelaGravando(fExecCancelaApuDedRetIrpj) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnConfirmarApuRecAcrClick(
  Sender: TObject);
begin
  inherited;
  Try
    fChamaTelaGravando(fExecGravaApuRecAcr) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnConfirmarDedRetCsllClick(
  Sender: TObject);
begin
  inherited;
  Try
    fChamaTelaGravando(fExecGravaApuDedRetCsll) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnConfirmarDedRetIrpjClick(
  Sender: TObject);
begin
  inherited;
  Try
    fChamaTelaGravando(fExecGravaApuDedRetIrpj) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnFecharClick(Sender: TObject);
begin
  inherited;

  if fFoiAlteradaApuRecAcr then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsApuracaoReceitasAcrescimos.Caption + '" !', ['&Ok']);
    exit ;
  end;

  if fFoiAlteradaApuDedRetCsll then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesCSLL.Caption + '" !', ['&Ok']);
    exit ;
  end;

  if fFoiAlteradaApuDedRetIrpj then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesIrpj.Caption + '" !', ['&Ok']);
    exit ;
  end;

  /// grava a apuração da 5 aba
  FdemEstimativaMensal.pGravaApuracao(FecEncerramento);

  pLimpaCalulos;
  pHabilitaCalculos(False) ;
  pgCalculos.ActivePageIndex := 0 ;
  pSetFocus(edtExercicio) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnRecolhimentoCSLLClick(
  Sender: TObject);
begin
  inherited;
  if FdemEstimativaMensal.fManutencaoRecolhimentosRealizados(edtExercicio.Text, iiCSLL) then
  begin
    FdemEstimativaMensal.pCalculaValores(FecEncerramento, edtExercicio.Text);
  end;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.btnRecolhimentoIRPJClick(
  Sender: TObject);
begin
  inherited;
  if FdemEstimativaMensal.fManutencaoRecolhimentosRealizados(edtExercicio.Text, iiIRPJ) then
  begin
    FdemEstimativaMensal.pCalculaValores(FecEncerramento, edtExercicio.Text);
  end;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.edtPeriodoPropertiesEditValueChanged(
  Sender: TObject);
var
  LDictSelecionado: TDictionary<string, TDateTime> ;
  LDataInicio, LDataFinal: TDateTime ;
begin
  inherited;

  if edtPeriodo.ItemIndex < 0 then
  begin
    exit ;
  end;

  LDictSelecionado := edtPeriodo.Properties.Items.Objects[edtPeriodo.ItemIndex] as TDictionary<string, TDateTime> ;
  LDataInicio := LDictSelecionado['inicio'] ;
  LDataFinal := LDictSelecionado['final'] ;

  pCarregaDadosDemonstrativo(LDataInicio, LDataFinal) ;

end;

function TfrmApuracaoLucroRealIrpjCsll.fArrPeriodo(
  const AecEncerramento: TEncerramentoContabil): TArrayPeriodo;
var
  LintCnt: integer ;
begin
  if AecEncerramento = ecTrimestral then
  begin
    SetLength(Result, 4);
    for LintCnt := Low(DES_ARRAY_TRIMESTRE) to High(DES_ARRAY_TRIMESTRE) do
    begin
      Result[LintCnt-1] := DES_ARRAY_TRIMESTRE[LintCnt] ;
    end;
  end
  else
  begin
    SetLength(Result, 12);
    for LintCnt := Low(DES_ARRAY_MES) to High(DES_ARRAY_MES) do
    begin
      Result[LintCnt-1] := DES_ARRAY_MES[LintCnt] ;
    end;
  end;
end;

function TfrmApuracaoLucroRealIrpjCsll.fCarregaApuDedRet(
  const AintExercicio: integer; const AiiTipo: TCsllIrpj; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean;
begin
  if AiiTipo = iiCSLL then
  begin
    FlrdrCsll.Encerramento := AecEncerramento ;
    FlrdrCsll.pSetEmpresa(AstrCodEmp);
    FlrdrCsll.pPrepara(AintExercicio, AiiTipo) ;
    dsDedRetCsll.Enabled := False ;
    dsDedRetCsll.DataSet := FlrdrCsll.CdsDados ;
    dsDedRetCsll.Enabled := True ;
    pCriaColunasGrid(GridCitelDedRetCsllTableView, AecEncerramento) ;
    if not FlrdrCsll.fTemDadosGravados then
      FlrdrCsll.fGravaAlteracoes(AecEncerramento, Nil)
  end
  else if AiiTipo = iiIRPJ then
  begin
    FlrdrIrpj.Encerramento := AecEncerramento ;
    FlrdrIrpj.pSetEmpresa(AstrCodEmp);
    FlrdrIrpj.pPrepara(AintExercicio, AiiTipo) ;
    dsDedRetIrpj.Enabled := False ;
    dsDedRetIrpj.DataSet := FlrdrIrpj.CdsDados ;
    dsDedRetIrpj.Enabled := True ;
    pCriaColunasGrid(GridCitelDedRetIrpjTableView, AecEncerramento) ;
    if not FlrdrIrpj.fTemDadosGravados then
      FlrdrIrpj.fGravaAlteracoes(AecEncerramento, Nil)
  end;
  Result := True ;
end;


function TfrmApuracaoLucroRealIrpjCsll.fCarregaCalculos(const AintExercicio: integer; ApgbProgresso: TcxProgressBar; const AecEncerramento: TEncerramentoContabil; const AstrCodEmp: String): boolean;
var
  LintPassos: integer ;
  LintPassosTotal: integer ;
begin
  result := False ;
  LintPassos := 0 ;
  LintPassosTotal := 5 ;
  ApgbProgresso.Properties.Max := LintPassosTotal ;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Carregando Lançamentos: ' + tsApuracaoReceitasAcrescimos.Caption );

  FaraApuracaoReceitasAcrecimos.pSetEmpresa(AstrCodEmp) ;
  if not FaraApuracaoReceitasAcrecimos.fCarregaDados(AintExercicio) then
  begin
    exit ;
  end;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Carregando Lançamentos: ' + tsDeducoesRetencoesCSLL.Caption );

  if not fCarregaApuDedRet(AintExercicio, iiCSLL, AecEncerramento, AstrCodEmp) then
  begin
    exit ;
  end;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Carregando Lançamentos: ' + tsDeducoesRetencoesIRPJ.Caption );

  if not fCarregaApuDedRet(AintExercicio, iiIRPJ, AecEncerramento, AstrCodEmp) then
  begin
    exit ;
  end;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Carregando Lançamentos: ' + tsDemonstrativoApuracao.Caption );

  FdaDemonstrativo.pSetEmpresa(AstrCodEmp) ;
  if not fCarregaDemonstrativoApuracao(AintExercicio, AecEncerramento) then
  begin
    exit ;
  end;

  inc(LintPassos) ;
  ApgbProgresso.Position := LintPassos;
  Application.ProcessMessages;
  pSetaTextoProgresso(ApgbProgresso, 'Carregando Lançamentos: ' + tsDeterminacaoEstimativasMensais.Caption );

  FdemEstimativaMensal.pSetEmpresa(AstrCodEmp) ;
  if not fCarregaDeterminacaoEstimativa(AintExercicio, AecEncerramento) then
  begin
    exit ;
  end;

  ///implementação de proximas abas
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fCarregaDemonstrativoApuracao(const AintExercicio: integer; const AecEncerramento: TEncerramentoContabil): boolean;
begin
  pAjustaPeriodoEncerramento(IntToStr(AintExercicio), AecEncerramento, edtPeriodo) ;
  ///regrava as informações nas tabelas de controle, para evitar divergencia quando as bases de calculos são alteradas, essa informação gravada impacta na aba 05
  FdaDemonstrativo.fGravaAlteracoes(FecEncerramento, strtoint(edtExercicio.Text), FlrdrCsll.CdsDados, FlrdrIrpj.CdsDados, TUniClientDataSet(dsApuRecAcrCsll.DataSet), TUniClientDataSet(dsApuRecAcrIrpj.DataSet)) ;
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fCarregaDeterminacaoEstimativa(
  const AintExercicio: integer;
  const AecEncerramento: TEncerramentoContabil): boolean;
begin
  FdemEstimativaMensal.pCalculaValores(AecEncerramento, IntToStr(AintExercicio));
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecCancelaApuDedRetCsll(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Cancelando Alterações' );
  FlrdrCsll.pCancelaAlteracoes ;
  pInformacoesAlteradasApuDedRetCsll(False) ;
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecCancelaApuDedRetIrpj(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Cancelando Alterações' );
  FlrdrIrpj.pCancelaAlteracoes ;
  pInformacoesAlteradasApuDedRetIrpj(False) ;
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecCancelaApuRecAcr(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Cancelando Alterações' );
  FaraApuracaoReceitasAcrecimos.pLimpaDados ;
  FaraApuracaoReceitasAcrecimos.fCarregaDados(StrToInt(edtExercicio.Text)) ;
  pInformacoesAlteradasApuRecAcr(False) ;
  result := True ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecCarregaCalculos(
  ApgbProgresso: TcxProgressBar): boolean;
begin

  result := fCarregaCalculos(StrToInt(edtExercicio.Text), ApgbProgresso, FecEncerramento, edtEmpSel.Text) ;
  if result then
  begin
    pHabilitaCalculos(True) ;
  end ;

end;

function TfrmApuracaoLucroRealIrpjCsll.fExecGravaApuDedRetCsll(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Gravando Lançamentos: ' + tsDeducoesRetencoesCSLL.Caption );
  result := FlrdrCsll.fGravaAlteracoes(FecEncerramento, ApgbProgresso) ;
  if not result then
  begin
    exit ;
  end ;
  pSetaTextoProgresso(ApgbProgresso, 'Gravando Demonstrativo Apuração ' );
  result := FdaDemonstrativo.fGravaAlteracoes(FecEncerramento, strtoint(edtExercicio.Text), FlrdrCsll.CdsDados, FlrdrIrpj.CdsDados, TUniClientDataSet(dsApuRecAcrCsll.DataSet), TUniClientDataSet(dsApuRecAcrIrpj.DataSet)) ;
  if not result then
  begin
    exit ;
  end ;

  FdemEstimativaMensal.pCalculaValores(FecEncerramento, edtExercicio.Text);

  pInformacoesAlteradasApuDedRetCsll(False) ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecGravaApuDedRetIrpj(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Gravando Lançamentos: ' + tsDeducoesRetencoesIRPJ.Caption );
  result := FlrdrIrpj.fGravaAlteracoes(FecEncerramento, ApgbProgresso) ;
  if not result then
  begin
    exit ;
  end ;

  pSetaTextoProgresso(ApgbProgresso, 'Gravando Demonstrativo Apuração ' );
  result := FdaDemonstrativo.fGravaAlteracoes(FecEncerramento, strtoint(edtExercicio.Text), FlrdrCsll.CdsDados, FlrdrIrpj.CdsDados, TUniClientDataSet(dsApuRecAcrCsll.DataSet), TUniClientDataSet(dsApuRecAcrIrpj.DataSet)) ;
  if not result then
  begin
    exit ;
  end ;

  FdemEstimativaMensal.pCalculaValores(FecEncerramento, edtExercicio.Text);

  pInformacoesAlteradasApuDedRetIrpj(False) ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fExecGravaApuRecAcr(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  pSetaTextoProgresso(ApgbProgresso, 'Gravando Lançamentos: ' + tsApuracaoReceitasAcrescimos.Caption );

  result := FaraApuracaoReceitasAcrecimos.fGravaDados(strtoint(edtExercicio.Text), ApgbProgresso) ;
  if not result then
  begin
    exit ;
  end ;
  pInformacoesAlteradasApuRecAcr(False) ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fFoiAlteradaApuDedRetCsll: boolean;
begin
  result := btnConfirmarDedRetCsll.Enabled and btnCancelarDedRetCsll.Enabled ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fFoiAlteradaApuDedRetIrpj: boolean;
begin
  result := btnConfirmarDedRetIrpj.Enabled and btnCancelarDedRetIrpj.Enabled ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fFoiAlteradaApuRecAcr: boolean;
begin
  result := btnConfirmarApuRecAcr.Enabled and btnCancelarApuRecAcr.Enabled ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if fFoiAlteradaApuRecAcr then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsApuracaoReceitasAcrescimos.Caption + '" !', ['&Ok']);
    CanClose := False ;
    exit ;
  end;

  if fFoiAlteradaApuDedRetCsll then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesCSLL.Caption + '" !', ['&Ok']);
    CanClose := False ;
    exit ;
  end;

  if fFoiAlteradaApuDedRetIrpj then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesIrpj.Caption + '" !', ['&Ok']);
    CanClose := False ;
    exit ;
  end;

  if btnFechar.Enabled then
  begin
    fMensagem('ATENÇÃO!', 'Clique em "Fechar Cálculos" antes de fechar o módulo!', ['&Ok']);
    CanClose := False ;
    exit ;
  end;

end;

procedure TfrmApuracaoLucroRealIrpjCsll.FormCreate(Sender: TObject);
begin
  inherited;
  FaraApuracaoReceitasAcrecimos := TApuracaoReceitasAcrecimos.Create() ;
  FaraApuracaoReceitasAcrecimos.pAfterEditCsll(pApuRecAcrAfterEdit);
  FaraApuracaoReceitasAcrecimos.pAfterPostCsll(pApuRecAcrCsllAfterPost);
  FaraApuracaoReceitasAcrecimos.pAfterEditIrpj(pApuRecAcrAfterEdit);
  FaraApuracaoReceitasAcrecimos.pAfterPostIrpj(pApuRecAcrIrpjAfterPost);

  dsApuRecAcrCsll.DataSet := FaraApuracaoReceitasAcrecimos.CdsApuRecAcrCsll ;
  dsApuRecAcrIrpj.DataSet := FaraApuracaoReceitasAcrecimos.CdsApuRecAcrIrpj ;

  FftForma := ftNada ;
  FecEncerramento := ecNada ;
  pHabilitaCalculos(False) ;
  FlrdrCsll := TLucroRealDeducoesRetencoes.Create(pApuDedRetCsllAfterPost, pApuDedRetCsllAfterEdit) ;
  FlrdrIrpj := TLucroRealDeducoesRetencoes.Create(pApuDedRetIrpjAfterPost, pApuDedRetIrpjAfterEdit) ;
  FdaDemonstrativo := TDemonstrativoApuracao.Create() ;

  FdemEstimativaMensal := TDeterminacaoEstimativaMensal.Create() ;
  dsDetEstMenCsll.DataSet := FdemEstimativaMensal.cdsDadosCsll ;
  dsDetEstMenIrpj.DataSet := FdemEstimativaMensal.cdsDadosIrpj ;
  dsDetEstMenRecolhimento.DataSet := FdemEstimativaMensal.cdsDadosRecolhimento ;
  dsDetEstMenOpcao.DataSet := FdemEstimativaMensal.cdsDadosOpcao ;

  pCaptionColunaGridPeriodo(GridCitelDetEstMenCsllTableView) ;
  pCaptionColunaGridPeriodo(GridCitellDetEstMenIrpjTableView) ;
  pgCalculos.ActivePageIndex := 0 ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FaraApuracaoReceitasAcrecimos) ;
  FreeAndNil(FlrdrCsll) ;
  FreeAndNil(FlrdrIrpj) ;
  FreeAndNil(FdaDemonstrativo) ;
  FreeAndNil(FdemEstimativaMensal) ;
  pLimparPeriodoEncerramento(edtPeriodo) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.FormShow(Sender: TObject);
begin
  inherited;
  pAjustaColunasEstimativasMensaisPelaResolucaoTela ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelApuRecAcrCsllTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := GridCitelApuRecAcrCsllTableViewCODIGO.DataBinding.Field.AsInteger > 0 ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelApuRecAcrCsllTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  LColumn: TcxGridDBColumn;
begin
  inherited;
  LColumn := GridCitelApuRecAcrCsllTableView.GetColumnByFieldName('CODIGO');
  If LColumn <> Nil Then
  Begin
    if (ARecord is TcxGridDataRow) And (ARecord.Values[LColumn.Index] < 0) then
    begin
      AStyle := sltLinhaDestacada;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelApuRecAcrIrpjTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
begin
  inherited;
  AAllow := GridCitelApuRecAcrIrpjTableViewCODIGO.DataBinding.Field.AsInteger > 0 ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelApuRecAcrIrpjTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  LColumn: TcxGridDBColumn;
begin
  inherited;
  LColumn := GridCitelApuRecAcrIrpjTableView.GetColumnByFieldName('CODIGO');
  If LColumn <> Nil Then
  Begin
    if (ARecord is TcxGridDataRow) And (ARecord.Values[LColumn.Index] < 0) then
    begin
      AStyle := sltLinhaDestacada;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelDedRetCsllTableViewEditing(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  var AAllow: Boolean);
var
  LitemCONTRO : TcxCustomGridTableItem ;
begin
  inherited;
  LitemCONTRO := fRetornaColbyFieldName(Sender, 'CONTRO') ;
  if Assigned(LitemCONTRO) then
  begin
    AAllow := TcxGridDBColumn(LitemCONTRO).DataBinding.Field.AsInteger >= 0 ;
  end;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelDedRetCsllTableViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
var
  LitemCONTRO : TcxCustomGridTableItem ;
begin
  inherited;
  LitemCONTRO := fRetornaColbyFieldName(Sender, 'CONTRO') ;
  If LitemCONTRO <> Nil Then
  Begin
    if (ARecord is TcxGridDataRow) And (ARecord.Values[TcxGridDBColumn(LitemCONTRO).Index] < 0) then
    begin
      AStyle := sltLinhaDestacada;
    end;
  End;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelDetEstMenOpcaoTableViewEVLR01PropertiesEditValueChanged(
  Sender: TObject);
var
  LGridDBTableView:TcxGridDBTableView;
  LintColIndex:Integer;
  LstrFieldName:string;
  LstrMes: string ;
begin
  inherited;

  LGridDBTableView := TcxGridDBTableView(TcxGridSite(TcxComboBox(Sender).Parent).ViewInfo.GridView);
  LintColIndex := TcxGridTableController(TcxGridSite(TcxComboBox(Sender).Parent).ViewInfo.GridView.Controller).FocusedColumn.Index;
  LstrFieldName := LGridDBTableView.Columns[LintColIndex].DataBinding.FieldName;
  LstrMes := copy(LstrFieldName, Length(LstrFieldName)-1, 2) ;
  LGridDBTableView.DataController.PostEditingData ;
  FdemEstimativaMensal.pGravaOpcaoRecolhimentoEscolhida(TcxComboBox(Sender).Text, StrToInt(LstrMes));
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelDetEstMenOpcaoTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  GridlDetEstMenCsllRecolhimentoTableView.Columns[AFocusedItem.Index].Focused := True ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridCitelDetEstMenOpcaoTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DOWN) and (GridCitelDetEstMenOpcaoTableView.DataController.IsEOF) then
    pSetFocus(GridlDetEstMenCsllRecolhimento) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridlDetEstMenCsllRecolhimentoTableViewFocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  inherited;
  GridCitelDetEstMenOpcaoTableView.Columns[AFocusedItem.Index].Focused := True ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.GridlDetEstMenCsllRecolhimentoTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_UP) and (GridlDetEstMenCsllRecolhimentoTableView.DataController.IsBOF) then
    pSetFocus(GridCitelDetEstMenOpcao) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pAjustaColunasEstimativasMensaisPelaResolucaoTela;
var
  LintWidthColuna: Integer ;
  LintCnt: Integer ;
begin
  pCalculaTamanhoColunaGrid(LintWidthColuna) ;

  for LintCnt := 0 to GridCitelDetEstMenCsllTableView.ColumnCount -1 do
  begin
    if Pos('EVLR', GridCitelDetEstMenCsllTableView.Columns[LintCnt].Name) > 0 then
      GridCitelDetEstMenCsllTableView.Columns[LintCnt].Width := LintWidthColuna ;
  end ;

  for LintCnt := 0 to GridCitellDetEstMenIrpjTableView.ColumnCount -1 do
  begin
    if Pos('EVLR', GridCitellDetEstMenIrpjTableView.Columns[LintCnt].Name) > 0 then
      GridCitellDetEstMenIrpjTableView.Columns[LintCnt].Width := LintWidthColuna ;
  end ;

  for LintCnt := 0 to GridCitelDetEstMenOpcaoTableView.ColumnCount -1 do
  begin
    if Pos('EVLR', GridCitelDetEstMenOpcaoTableView.Columns[LintCnt].Name) > 0 then
      GridCitelDetEstMenOpcaoTableView.Columns[LintCnt].Width := LintWidthColuna ;
  end ;

  for LintCnt := 0 to GridlDetEstMenCsllRecolhimentoTableView.ColumnCount -1 do
  begin
    if Pos('EVLR', GridlDetEstMenCsllRecolhimentoTableView.Columns[LintCnt].Name) > 0 then
      GridlDetEstMenCsllRecolhimentoTableView.Columns[LintCnt].Width := LintWidthColuna ;
  end ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuDedRetCsllAfterEdit(
  DataSet: TDataSet);
begin
  pInformacoesAlteradasApuDedRetCsll(True) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuDedRetCsllAfterPost(
  DataSet: TDataSet);
begin
  FlrdrCsll.pProcessaCalculos ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuDedRetIrpjAfterEdit(
  DataSet: TDataSet);
begin
  pInformacoesAlteradasApuDedRetIrpj(True) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuDedRetIrpjAfterPost(
  DataSet: TDataSet);
begin
  FlrdrIrpj.pProcessaCalculos ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuRecAcrAfterEdit(DataSet: TDataSet);
begin
  pInformacoesAlteradasApuRecAcr(True) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuRecAcrCsllAfterPost(
  DataSet: TDataSet);
begin
  FaraApuracaoReceitasAcrecimos.pProcessaCalculos(FaraApuracaoReceitasAcrecimos.cdsApuRecAcrCsll) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pApuRecAcrIrpjAfterPost(
  DataSet: TDataSet);
begin
  FaraApuracaoReceitasAcrecimos.pProcessaCalculos(FaraApuracaoReceitasAcrecimos.cdsApuRecAcrIrpj) ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pCalculaTamanhoColunaGrid(
  var AintWidthColuna: integer);
var
  LintWidthTela: integer ;
begin
  LintWidthTela := Screen.Width ;

  if LintWidthTela <= 1024 then
    AintWidthColuna := 60
  else if (LintWidthTela >= 1025) and (LintWidthTela <= 1280) then
    AintWidthColuna := 80
  else
    AintWidthColuna := 85 ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pCaptionColunaGridPeriodo(AgridTableView: TcxCustomGridTableView);
var
  LitemValor: TcxCustomGridTableItem ;
  LintCnt: Integer ;
  LarrDescricaoPeriodos : TArrayPeriodo ;
begin
  inherited;
  LarrDescricaoPeriodos := fArrPeriodo(ecAnual) ;
  for LintCnt := Low(LarrDescricaoPeriodos) to High(LarrDescricaoPeriodos) do
  begin
    LitemValor := fRetornaColbyFieldName(AgridTableView, 'EVLR' + fStrZero(LintCnt+1,2) ) ;
    if Assigned(LitemValor) then
    begin
      LitemValor.Caption := LarrDescricaoPeriodos[LintCnt] + string(#13#10 + 'Jan-'+copy(LarrDescricaoPeriodos[LintCnt], 1, 3)) ;
    end;
  end;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pCarregaDadosDemonstrativo(
  const AdtaDataInicial, AdtaDataFinal: TDateTime);
begin
  FdaDemonstrativo.pCalculaValores(FecEncerramento, AdtaDataInicial, AdtaDataFinal, FlrdrCsll.CdsDados, FlrdrIrpj.CdsDados, TUniClientDataSet(dsApuRecAcrCsll.DataSet), TUniClientDataSet(dsApuRecAcrIrpj.DataSet));

  edtBaseCalculoCsllBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['BaseCalculoCsll'] ;
  edtBaseCalculoCslRec.Value  := FdaDemonstrativo.ValoresCalculadosReceita['BaseCalculoCsll'] ;
  edtBaseCalculoIrpjBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['BaseCalculoIrpj'] ;
  edtBaseCalculoIrpjRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['BaseCalculoIrpj'] ;

  edtCsllBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['Csll'] ;
  edtCsllRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['Csll'] ;
  edtIrpjBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['Irpj'] ;
  edtIrpjRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['Irpj'] ;

  edtAdicionalIrpjBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['AdicionalIrpj'] ;
  edtAdicionalIrpjRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['AdicionalIrpj'] ;

  edtDeducaoCsllBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['DeducaoCsll'] ;
  edtDeducaoIrpjBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['DeducaoIrpj'] ;

  edtCsllRecolherBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['CsllRecolher'] ;
  edtCsllRecolherRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['CsllRecolher'] ;
  edtIrpjRecolherBal.Value := FdaDemonstrativo.ValoresCalculadosBalancete['IrpjRecolher'] ;
  edtIrpjRecolherRec.Value := FdaDemonstrativo.ValoresCalculadosReceita['IrpjRecolher'] ;

end;

procedure TfrmApuracaoLucroRealIrpjCsll.pCriaColunasGrid(
  var AGridTableView: TcxGridDBTableViewCitel;
  const AecEncerramento: TEncerramentoContabil);
var
  LcolGrid : TcxGridDBColumn ;
  LintPeriodo : Integer ;
  LarrDescricaoPeriodos : TArrayPeriodo ;
  LpropCurr : TcxCurrencyEditProperties ;
begin

  LarrDescricaoPeriodos := fArrPeriodo(AecEncerramento) ;

  AGridTableView.DataController.BeginFullUpdate;
  try
    AGridTableView.ClearItems ;

    LcolGrid := AGridTableView.CreateColumn ;
    LcolGrid.DataBinding.FieldName := 'CONTRO' ;
    LcolGrid.Visible := False ;
    LcolGrid.VisibleForCustomization := False ;
    LcolGrid.Name := AGridTableView.Name+LcolGrid.DataBinding.FieldName;

    LcolGrid := AGridTableView.CreateColumn ;
    LcolGrid.DataBinding.FieldName := 'CODIGO' ;
    LcolGrid.Caption := 'Código' ;
    LcolGrid.Visible := True ;
    LcolGrid.VisibleForCustomization := True ;
    LcolGrid.Name := AGridTableView.Name+LcolGrid.DataBinding.FieldName;
    LcolGrid.Options.Editing := False ;

    LcolGrid := AGridTableView.CreateColumn ;
    LcolGrid.DataBinding.FieldName := 'DESCRI' ;
    LcolGrid.Caption := 'Descrição' ;
    LcolGrid.Visible := True ;
    LcolGrid.VisibleForCustomization := True ;
    LcolGrid.Name := AGridTableView.Name+LcolGrid.DataBinding.FieldName;
    LcolGrid.Width := 350 ;
    LcolGrid.Options.Editing := False ;

    for LintPeriodo := Low(LarrDescricaoPeriodos) to High(LarrDescricaoPeriodos) do
    begin
      LcolGrid := AGridTableView.CreateColumn ;
      LcolGrid.DataBinding.FieldName := 'VVAL'+fStrZero(inttostr(LintPeriodo+1), 2) ;
      LcolGrid.Caption := LarrDescricaoPeriodos[LintPeriodo] + iif(AecEncerramento <> ecTrimestral, string(#13#10 + 'Jan-'+copy(LarrDescricaoPeriodos[LintPeriodo], 1, 3)), '') ;
      LcolGrid.Visible := True ;
      LcolGrid.VisibleForCustomization := True ;
      LcolGrid.Name := AGridTableView.Name+LcolGrid.DataBinding.FieldName;
      LcolGrid.Width := 95 ;

      LpropCurr := TcxCurrencyEditProperties.Create(LcolGrid) ;
      try
        LpropCurr.DisplayFormat := '#,##0.00' ;
        LcolGrid.PropertiesClassName := 'TcxCurrencyEditProperties' ;
        LcolGrid.Properties.Assign(LpropCurr);
      finally
        LpropCurr.Free ;
      end;
      
    end;
    
  finally
    AGridTableView.DataController.EndFullUpdate;
  end;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pgCalculosPageChanging(Sender: TObject;
  NewPage: TcxTabSheet; var AllowChange: Boolean);
var
  LDictSelecionado: TDictionary<string, TDateTime> ;
  LDataInicio, LDataFinal: TDateTime ;
begin
  inherited;

  if FecEncerramento = ecTrimestral then
  begin
    if (NewPage = tsApuracaoReceitasAcrescimos) or (NewPage = tsDeterminacaoEstimativasMensais) then
    begin
      fMensagem('ATENÇÃO!', 'Aba disponível somente no tipo de encerramento "Lucro Real (Estimativa Mensal)"!', ['&Ok']);
      AllowChange := False ;
      exit ;
    end;
  end;

  if fFoiAlteradaApuRecAcr then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsApuracaoReceitasAcrescimos.Caption + '" !', ['&Ok']);
    AllowChange := False ;
    exit ;
  end;

  if fFoiAlteradaApuDedRetCsll then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesCSLL.Caption + '" !', ['&Ok']);
    AllowChange := False ;
    exit ;
  end;

  if fFoiAlteradaApuDedRetIrpj then
  begin
    fMensagem('ATENÇÃO!', 'Confirme ou Cancele as alterações em "' + tsDeducoesRetencoesIRPJ.Caption + '" !', ['&Ok']);
    AllowChange := False ;
    exit ;
  end;

  if NewPage = tsDemonstrativoApuracao then
  begin
    LDictSelecionado := edtPeriodo.Properties.Items.Objects[edtPeriodo.ItemIndex] as TDictionary<string, TDateTime> ;
    LDataInicio := LDictSelecionado['inicio'] ;
    LDataFinal := LDictSelecionado['final'] ;

    pCarregaDadosDemonstrativo(LDataInicio, LDataFinal) ;
  end;


end;

procedure TfrmApuracaoLucroRealIrpjCsll.pHabilitaCalculos(
  const AblnHabilitar: boolean);
begin
  pgCalculos.Enabled := AblnHabilitar ;
  btnFechar.Enabled := AblnHabilitar ;
  edtExercicio.Enabled := not AblnHabilitar ;
  btnAbrir.Enabled := not AblnHabilitar ;
  edtEmpSel.Enabled := not AblnHabilitar ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pInformacoesAlteradasApuDedRetCsll(
  const AblnAlteradas: boolean);
begin
  btnConfirmarDedRetCsll.Enabled := AblnAlteradas ;
  btnCancelarDedRetCsll.Enabled := AblnAlteradas ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pInformacoesAlteradasApuDedRetIrpj(
  const AblnAlteradas: boolean);
begin
  btnConfirmarDedRetIrpj.Enabled := AblnAlteradas ;
  btnCancelarDedRetIrpj.Enabled := AblnAlteradas ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pInformacoesAlteradasApuRecAcr(
  const AblnAlteradas: boolean);
begin
  btnConfirmarApuRecAcr.Enabled := AblnAlteradas ;
  btnCancelarApuRecAcr.Enabled := AblnAlteradas ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pLimpaCalulos;
begin
  FftForma := ftNada ;
  FecEncerramento := ecNada ;
  FaraApuracaoReceitasAcrecimos.pLimpaDados ;
  FlrdrCsll.pEmptyCds ;
  FlrdrIrpj.pEmptyCds ;
  edtExercicio.Clear ;
  edtEmpSel.Clear ;
  edtNomEmpSel.Clear ;
end;

procedure TfrmApuracaoLucroRealIrpjCsll.pSetaTextoProgresso(ApgbProgresso: TcxProgressBar; AstrTexto: String);
begin
  if fIsAssignedProgresso(ApgbProgresso) then
  Begin
    TLabel(GetParentForm(ApgbProgresso).FindComponent('lblGravando')).Caption := AstrTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmApuracaoLucroRealIrpjCsll.fIsAssignedProgresso(
  ApgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(ApgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(ApgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fRetornaColbyFieldName(Sender: TcxCustomGridTableView; FieldName: String): TcxCustomGridTableItem;
var
  strColunaFormula : string ;
begin
  strColunaFormula := Sender.Name+FieldName ;
  result := Sender.FindItemByName(strColunaFormula) ;
end;

function TfrmApuracaoLucroRealIrpjCsll.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin

    If (Sender = edtEmpSel) Then
    begin

      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End

    end;

  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
