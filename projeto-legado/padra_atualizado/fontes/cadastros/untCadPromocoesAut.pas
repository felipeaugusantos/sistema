Unit untCadPromocoesAut;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  cxRadioGroup, cxDBEdit, Vcl.CheckLst, Vcl.DBCtrls, Vcl.Mask, DBEditFocus,
  Data.DB, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  QColorLabel, untCadPro, cxGridBandedTableView, cxGridDBBandedTableView,
  MaskEditFocus, untConstantes, Datasnap.DBClient, UniClientDataSet, Uni, cxCheckBox,
  cxProgressBar, untTypesSistema, MemDS, DBAccess, Datasnap.Provider,
  UniDataSetProvider;

type
  TfrmCadPromocoesAut = class(TfrmPaiCad)
    dtsCadPpa: TDataSource;
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodPro: TDBEditFocus;
    dbeDesPro: TDBEditFocus;
    Label4: TLabel;
    pnlTabelas: TPanel;
    lblTabPreco: TLabel;
    lblLegCondicoes: TLabel;
    clbTabPre: TCheckListBox;
    pnlOpcoesGerais: TPanel;
    chkPromocaoRestritaClientesNaoConsumidor: TDBCheckBox;
    chkTraPro: TDBCheckBox;
    pnlChecks: TPanel;
    pnlValidades: TPanel;
    Label2: TLabel;
    grdValidadesTv: TcxGridDBTableViewCitel;
    grdValidadesLv: TcxGridLevel;
    grdValidades: TcxGridCitel;
    Panel4: TPanel;
    btnAddVpa: TBitBtnLocked;
    btnCancelVpa: TBitBtnLocked;
    pnlEmpresa: TPanel;
    Label16: TLabel;
    clbEmpresa: TCheckListBox;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel5: TPanel;
    btnMarcarTodasEmpresas: TBitBtnLocked;
    btnDesmarcarTodasEmpresas: TBitBtnLocked;
    pnlCndPag: TPanel;
    Label8: TLabel;
    pnlCndPagCab: TPanel;
    lblCndPag: TLabel;
    ColorLabel2: TColorLabel;
    lblJurRem: TLabel;
    edtCodCnd: TEditFocus;
    btnIncCndPag: TBitBtnLocked;
    btnCancelCndPag: TBitBtnLocked;
    edtDesCnd: TEditFocus;
    edtJurRem: TEditFocus;
    Panel6: TPanel;
    Panel7: TPanel;
    pnlTrazerPrecoSugestao: TPanel;
    btnHlpCom: TBitBtnLocked;
    btnHlpQtdLim: TBitBtnLocked;
    rdgProPre: TcxDBRadioGroup;
    tbsItens: TTabSheet;
    pnlInformacoesItens: TPanel;
    pnlDadosItem: TPanel;
    dtsPpaIte: TDataSource;
    cxgItens: TcxGridCitel;
    cxgItensTableView: TcxGridDBBandedTableViewCitel;
    cxgItensIPA_CODITE: TcxGridDBBandedColumn;
    cxgItensITE_CODFAB: TcxGridDBBandedColumn;
    cxgItensITE_DESITE: TcxGridDBBandedColumn;
    cxgItensUNI_SIGUNI: TcxGridDBBandedColumn;
    cxgItensMAR_DESMAR: TcxGridDBBandedColumn;
    cxgItensITE_SALDOS: TcxGridDBBandedColumn;
    cxgItensITE_SALDIS: TcxGridDBBandedColumn;
    cxgItensIPA_QTDLIM: TcxGridDBBandedColumn;
    cxgItensIPA_QTDMIN: TcxGridDBBandedColumn;
    cxgItensIPA_PRZMED: TcxGridDBBandedColumn;
    cxgItensIPA_PERDES: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS: TcxGridDBBandedColumn;
    cxgItensIPA_CUSREA: TcxGridDBBandedColumn;
    cxgItensIPA_MARBRU: TcxGridDBBandedColumn;
    cxgItensIPA_MARLIQ: TcxGridDBBandedColumn;
    cxgItensIPA_PREVEN: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS1: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE1: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR1: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ1: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE1: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS2: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE2: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR2: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ2: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE2: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS3: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE3: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR3: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ3: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE3: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS4: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE4: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR4: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ4: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE4: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS5: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE5: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR5: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ5: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE5: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS6: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE6: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR6: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ6: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE6: TcxGridDBBandedColumn;
    cxgItensIPA_PRECUS7: TcxGridDBBandedColumn;
    cxgItensIPA_CUSRE7: TcxGridDBBandedColumn;
    cxgItensIPA_MARBR7: TcxGridDBBandedColumn;
    cxgItensIPA_MARLQ7: TcxGridDBBandedColumn;
    cxgItensIPA_PREVE7: TcxGridDBBandedColumn;
    cxgItensITE_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_CUSREA: TcxGridDBBandedColumn;
    cxgItensITE_MARBR1: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ1: TcxGridDBBandedColumn;
    cxgItensITE_PREVE1: TcxGridDBBandedColumn;
    cxgItensITE_MARBR2: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ2: TcxGridDBBandedColumn;
    cxgItensITE_PREVE2: TcxGridDBBandedColumn;
    cxgItensITE_MARBR3: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ3: TcxGridDBBandedColumn;
    cxgItensITE_PREVE3: TcxGridDBBandedColumn;
    cxgItensITE_MARBR4: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ4: TcxGridDBBandedColumn;
    cxgItensITE_PREVE4: TcxGridDBBandedColumn;
    cxgItensITE_MARBR5: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ5: TcxGridDBBandedColumn;
    cxgItensITE_PREVE5: TcxGridDBBandedColumn;
    cxgItensITE_MARBR6: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ6: TcxGridDBBandedColumn;
    cxgItensITE_PREVE6: TcxGridDBBandedColumn;
    cxgItensITE_MARBR7: TcxGridDBBandedColumn;
    cxgItensITE_MARLQ7: TcxGridDBBandedColumn;
    cxgItensITE_PREVE7: TcxGridDBBandedColumn;
    cxgItensITE_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_PREULT: TcxGridDBBandedColumn;
    cxgItensITE_IMPULT: TcxGridDBBandedColumn;
    cxgItensIPA_COMVAR: TcxGridDBBandedColumn;
    cxgItensIPA_COMATA: TcxGridDBBandedColumn;
    cxgItensIPA_COMDIS: TcxGridDBBandedColumn;
    cxgItenslevel: TcxGridLevel;
    tbsClientes: TTabSheet;
    dtsPpaCli: TDataSource;
    pnlPesqCli: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lblCategoria: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    edtEstado: TEditFocus;
    edtCgcCpf: TEditFocus;
    edtNuCnPj: TMaskEditFocus;
    btnIncCli: TBitBtnLocked;
    btnCancelCli: TBitBtnLocked;
    cbxCategoria: TComboBox;
    cxgClientes: TcxGridCitel;
    cxgClientesTv: TcxGridDBTableViewCitel;
    cxgClientesTvColumn1: TcxGridDBColumn;
    cxgClientesTvColumn2: TcxGridDBColumn;
    cxgClientesTvColumn5: TcxGridDBColumn;
    cxgClientesTvColumn4: TcxGridDBColumn;
    cxgClientesTvColumn3: TcxGridDBColumn;
    cxgClientesTvColumn6: TcxGridDBColumn;
    cxgClientesLv: TcxGridLevel;
    grdValidadesTvColumn1: TcxGridDBColumn;
    grdValidadesTvDESVPA: TcxGridDBColumn;
    grdValidadesTvDTAINI: TcxGridDBColumn;
    grdValidadesTvDTAFIN: TcxGridDBColumn;
    dtsPpaVal: TDataSource;
    cxgCndPag: TcxGridCitel;
    cxgCndPagTv: TcxGridDBTableViewCitel;
    cxgCndPagTvCODCND: TcxGridDBColumn;
    cxgCndPagTvDESCND: TcxGridDBColumn;
    cxgCndPagTvCNDPAG: TcxGridDBColumn;
    cxgCndPagTvJURREM: TcxGridDBColumn;
    cxgCndPagLv: TcxGridLevel;
    chkEntIme: TDBCheckBox;
    chkEntFut: TDBCheckBox;
    chkEcommerce: TDBCheckBox;
    rdgQtdLim: TcxDBRadioGroup;
    rdgComPro: TcxDBRadioGroup;
    edtDtaInicial: TMaskEditFocus;
    edtDtaFinal: TMaskEditFocus;
    edtDesPro: TEditFocus;
    dtsPpaCnd: TDataSource;
    Panel8: TPanel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    lblDescricao: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    lbl1: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDescriIni: TEditFocus;
    edtRefere: TEditFocus;
    edtDescriFin: TEditFocus;
    edtPrzMed: TEditFocus;
    Panel9: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    lbl8: TLabel;
    edtComVar: TEditFocus;
    edtComAta: TEditFocus;
    edtComDis: TEditFocus;
    Label10: TLabel;
    Panel10: TPanel;
    btnConfirmar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    Label11: TLabel;
    edtUnidade: TEditFocus;
    Label17: TLabel;
    lbl2: TLabel;
    edtQtdLim: TEditFocus;
    edtQtdMin: TEditFocus;
    Label21: TLabel;
    edtPerDes: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkEcommerceClick(Sender: TObject);
    procedure btnHlpComClick(Sender: TObject);
    procedure btnHlpQtdLimClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreExit(Sender: TObject);
    procedure clbTabPreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgComProClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnMarcarTodasEmpresasClick(Sender: TObject);
    procedure btnDesmarcarTodasEmpresasClick(Sender: TObject);
    procedure btnAddVpaClick(Sender: TObject);
    procedure btnCancelVpaClick(Sender: TObject);
    procedure grdValidadesTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdValidadesTvCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnIncCndPagClick(Sender: TObject);
    procedure btnCancelCndPagClick(Sender: TObject);
    procedure cxgCndPagTvCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgCndPagTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure cxgCndPagTvCNDPAGGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure edtNuCnPjEnter(Sender: TObject);
    procedure cbxCategoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncCliClick(Sender: TObject);
    procedure btnCancelCliClick(Sender: TObject);
    procedure cxgClientesTvColumn5GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxgClientesTvKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgItensTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dtsCadPpaStateChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);
  private
    { Private declarations }
    FstrEmpSelAnt: String;
    FstrTabSelAnt: String;
    FopcTipDes: TTipDescPro;
    FintDecUni: Integer;
    FblnEcomme: Boolean;
    FintPrecisaoDescontoItem: Integer;

    FarrClientes,
    FarrCidade,
    FarrAtiv,
    FarrCndPag: TConsultasArray;

    FInseriuItem : Boolean;
    FblnUsaComissaoCadastroProduto: Boolean;
    FblnAltGrd: Boolean;

    FqryConIte: TUniQuery;

    FcdsPpaVal,
    FcdsPpaCnd,
    FcdsPpaCli,
    FcdsPpaIte: TUniClientDataSet;

    FarrGrupos,
    FarrProdutos,
    FarrMarca,
    FarrFornec,
    FarrUnidades: TConsultasArray;

    function fGravarPromocao(pgbStatus: TcxProgressBar): Boolean;
    procedure pGravarEmpresas(strAutInc: String; pgbStatus: TcxProgressBar);
    procedure pGravarValidades(strAutInc: String; pgbStatus: TcxProgressBar);
    procedure pGravarCondicoes(strAutInc: String; pgbStatus: TcxProgressBar);
    procedure pGravarClientes(strAutInc: String; pgbStatus: TcxProgressBar);
    procedure pGravarItens(strAutInc: String; pgbStatus: TcxProgressBar);

    function fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
    procedure pCarregaTabelasPreco(strTabelas: String);
    procedure pCarregaEmpresas(strAutInc: String);
    procedure pCarregaValidades(strAutInc: String);
    procedure pCarregaCondicoes(strAutInc: String);
    procedure pCarregaClientes(strAutInc: String);
    procedure pCarregaItens(strAutInc: String);

    procedure pCarregaCadIte(blnAtualizaTela: Boolean);

    function fValidaVpaVal: Boolean;


    procedure pSetEnabledComissao;
    procedure pAfterScroll(Dataset: TDataset);

    procedure pMarcarEmpresas(strEmpresas: String);
    procedure pMarcarTabelasPreco(strTabelas: String);

    function fGetEmpresasSelecionadas: String;
    function fGetTabelasPrecoSelecionadas: String;
    procedure pEscondeColunasTab(intTabPre: Integer);
    procedure pControlaPrecoDesconto(opcPreDes: TTipDescPro);
    procedure pEnabledEdit(Edit: TCustomEdit);
    function fVerificaProdutoTintaMaquina: Boolean;
    procedure pSetEnabledCliente;
    procedure pDeletaTemporaria;
    procedure pBuscaDadosCliente;

    procedure pLimpaDadosValidades;

    procedure pLimpaDadosCondicao;
    function fValidaCndPag: Boolean;
    procedure pInsereCliente;
    function fInsereCliente(pgbStatus: TcxProgressBar): Boolean;
    procedure pAdicionaItem;
    procedure pLimpaDadosItem;
    function fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
    procedure pLimpaInputsDadosItem;
    procedure pCarregaItemAlteracao;
    function fItemJaCadastrado(strCodIte: String): Boolean;
    procedure pCalculaCustoEMargem;
    function fPreComLiq(DataSet: TDataSet; fltDesF07: Double): Double;
    function fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String;
      fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
    function fValidaLimiteMinima(edtLim, edtMin: TCustomEdit;
      Sender: TObject): Boolean;

    procedure pCarregaCadastro;
    procedure pZeraComissao;
    function fRetornaProdutosDaPromocao: string;
    function fSqlDefault: String;
    function fCustoReal(strCampoCusto, strCampoVenda: String): Double;
    function fMargemBruta(strCampoCusto, strCampoVenda: String): Double;
    function fMargemLiquida(strCampoCusto, strCampoVenda,
      strCampoComissao: String): Double;
    procedure pMostraObservacoes(strMsgProJaInc, strMsgProIncOu,
      strMsgItemEstr01, strMsgItemEstr02, strMsgProSemEstoque: String);
    procedure pIncluiAlteraItem(qryGen: TUniQuery);
    function fAddParametro(strValor, strSQL: String): String;
    procedure pSetParametro(qrySelect: TUniQuery; strParametro, strValor: String);
    procedure pMontaParametros(qryGen: TUniQuery);
    procedure pLimpaPainel(pnlLimpar: TPanel);

  public
    { Public declarations }
    blnComPro: Boolean;
    FstrAutInc: String;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untFuncoes, Promocao.Regra.Preco.Sugestao, System.StrUtils,
  untConsultas, untGravando, untObservacao, untFuncoesConsulta, System.MaskUtils,
  untFuncoesGenerica, untModulo, untMostraEstruturas, untIcmsSTParteVenda;

{$R *.dfm}

procedure TfrmCadPromocoesAut.FormCreate(Sender: TObject);
begin
  inherited;

  TRegraPrecoSugestao.MontarRegraRadioGroupItems(rdgProPre.Properties.Items);
  FInseriuItem  := False;

  strNomeTabela           := 'CADPPA';
  strNomeCampo            := 'PPA_CODPPA';

  qryTabela               := fCriarQuery('SELECT * FROM CADPPA WHERE FALSE', Self);
  qryTabela.AfterScroll   := pAfterScroll;
  dtsCadPpa.DataSet := qryTabela;

  FqryConIte               := fCriaQuery(Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPro;

  pnlCndPag.Visible := (fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S');

  edtQtdLim.EditFormat := '#,##0.'+ StringOfChar('0', StrToIntDef(fCfgSis('DECUNI'), 0));
  edtQtdMin.EditFormat := edtQtdLim.EditFormat;

  FintDecUni := fCfgSis('DECUNI', varInteger);

  pPreencheCombo(TCustomComboBox(cbxCategoria),  arrCtgCli);
  cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(' ');

  FstrAutInc := '';
end;

procedure TfrmCadPromocoesAut.FormDestroy(Sender: TObject);
begin
  If Assigned(FcdsPpaVal) Then
    FreeAndNil(FcdsPpaVal);

  If Assigned(FcdsPpaCnd) Then
    FreeAndNil(FcdsPpaCnd);

  If Assigned(FcdsPpaCli) Then
    FreeAndNil(FcdsPpaCli);

  If Assigned(FcdsPpaIte) Then
    FreeAndNil(FcdsPpaIte);

  inherited;

end;

procedure TfrmCadPromocoesAut.FormResize(Sender: TObject);
var
  intHeight: Integer;
begin
  inherited;
  intHeight := 0;
  if pnlCabecalho.Visible then
    intHeight := intHeight + pnlCabecalho.Height;

  if pnlChecks.Visible then
    intHeight := intHeight + pnlChecks.Height;

  if pnlTabelas.Visible then
    intHeight := intHeight + pnlTabelas.Height;

  if pnlOpcoesGerais.Visible then
    intHeight := intHeight + pnlOpcoesGerais.Height;

  intHeight := clbEmpresa.Height - intHeight;
  intHeight := Round(intHeight / 2);

  pnlCndPag.Height    := intHeight;
  pnlValidades.Height := intHeight;
end;

procedure TfrmCadPromocoesAut.FormShow(Sender: TObject);
begin
  inherited;
  TCadPro.pCarregaEmpresa(clbEmpresa);

  pnlTrazerPrecoSugestao.Visible := fCfgSis('PROSUG', varBoolean);

  chkEcommerce.visible := fCfgSis('PROECO', varBoolean);

  pgcDados.ActivePageIndex := 0;

  FintPrecisaoDescontoItem := fRetPrecisaoDescontoItem;
  edtPerDes.EditFormat := fMskDigitos(FintPrecisaoDescontoItem);

  blnComPro := fVerificaAcessoSistema('COMPRO');
  pSetEnabledComissao;
  pAfterScroll(Nil);

  pSetaCodIte( dbeCodPro );
  pSetaCodIte( edtCodIte );

  cxgItensITE_PREMED.Visible := fCfgSis('PREPRO', VarBoolean);
  cxgItensITE_PREULT.Visible := fCfgSis('PREPRO', VarBoolean);
  cxgItensITE_IMPULT.Visible := fCfgSis('PREPRO', VarBoolean);

  chkTraPro.Visible := fCfgSis('TRAPRO', varString) = 'C';
  FblnAltGrd := False;

  if not fEmptyStr(FstrAutInc) then
    pCarregaCadastro;
end;

procedure TfrmCadPromocoesAut.pSetEnabledComissao;
begin
  edtComVar.Enabled := blnComPro And pnlDadosItem.Enabled;
  edtComAta.Enabled := blnComPro And pnlDadosItem.Enabled;
  edtComDis.Enabled := blnComPro And pnlDadosItem.Enabled;
end;

procedure TfrmCadPromocoesAut.pAfterScroll(Dataset: TDataset);
var
  frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  try
    Try
      frmGravando.fExecutarAcao := fCarregaDados;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  finally
    pFreeAndNil(frmGravando);
  end;


  FstrEmpSelAnt := fGetEmpresasSelecionadas;
  FstrTabSelAnt := fGetTabelasPrecoSelecionadas;

  pControlaPrecoDesconto(TTipDescPro.tdpDescon);
end;

procedure TfrmCadPromocoesAut.pMarcarEmpresas(strEmpresas: String);
Var
  intContador: Integer;
begin
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpresas) > 0 Then
      clbEmpresa.Checked[intContador] := True
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
end;

procedure TfrmCadPromocoesAut.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If (blnAlterou) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    pHabilitaCodigo(dbeCodPro, dbeDesPro, False);

    cxgItens.Refresh;

//    pAfterScroll(Nil);

    pSetEnabledComissao;
  End;

  pSetEnabledCliente;
end;

procedure TfrmCadPromocoesAut.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pAfterScroll(Nil);
end;

procedure TfrmCadPromocoesAut.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
end;

procedure TfrmCadPromocoesAut.btnCancelCliClick(Sender: TObject);
Var
  intContador : Integer;
begin
  inherited;

  If pnlPesqCli.Enabled Then
    For intContador := 0 To pnlPesqCli.ControlCount - 1 Do
    Begin
      If pnlPesqCli.Controls[intContador] is TMaskEdit Then
        TMaskEdit(pnlPesqCli.Controls[intContador]).Clear;
      If (pnlPesqCli.Controls[intContador] is TEditFocus) And (pnlPesqCli.Controls[intContador].Name <> 'edtCgcCpf') Then
        TEditFocus(pnlPesqCli.Controls[intContador]).Clear;
    End;

  FarrClientes := Nil;
  FarrCidade := Nil;
  FarrAtiv := Nil;

  If (pnlPesqCli.Enabled) Then
    pSetFocus(edtCodCli);

  cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(' ');
end;

procedure TfrmCadPromocoesAut.btnCancelCndPagClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosCondicao;
  pSetFocus(edtCodCnd);
  btnIncCndPag.Tag := 0;
end;

procedure TfrmCadPromocoesAut.btnCancelVpaClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosValidades;
  pSetFocus(edtDesPro);
  btnAddVpa.Tag := 0;
end;

procedure TfrmCadPromocoesAut.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  FInseriuItem := False;
  If (fVerificaCampos()) Then
  Begin
    pAdicionaItem;
    FblnAltGrd := False;
    edtCodIte.Enabled := True;
    FInseriuItem := True;
  End;
end;

procedure TfrmCadPromocoesAut.btnDesmarcarTodasEmpresasClick(
  Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  For intContador := 0 To clbEmpresa.Items.Count -1 Do
    clbEmpresa.Checked[intContador] := False;
end;

procedure TfrmCadPromocoesAut.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadPromocoesAut.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadPromocoesAut.btnGravarClick(Sender: TObject);
begin
  pgcDados.ActivePage := tbsGeral;

  If fEmptyStr(fGetEmpresasSelecionadas) Then
  Begin
    fMensagem('','Selecione alguma empresa!',['&OK']);
    pSetFocus(clbEmpresa);
    Exit;
  End;

  If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
  Begin
    fMensagem('','Selecione alguma tabela de preço!',['&OK']);
    pSetFocus(clbTabPre);
    Exit;
  End;

  If (Not fValidaCampos(dbeDesPro, True)) Then
    Exit;

  If ((Not FcdsPpaIte.Active) Or (FcdsPpaIte.IsEmpty)) Then
  Begin
    fMensagem('','Inclua os itens da promoção!',['&OK']);
    Exit;
  End;

  //Somente avisa
  If (fVerificaProdutoTintaMaquina) Then
    fMensagem('Atenção','As opções quantidade limite e quantidade mínima,' + #13#10 +
                        ' não são utilizadas para tinta formulada(F8 - Tinta de Máquina).' + #13#10 +
                        'A quantidade considerada é a partir de uma unidade da fórmula escolhida.',['&OK']);

  If (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 2) Then
    Exit;

  btnCancelCli.Click;

  pCriarFormularios(TfrmGravando, frmGravando);
  try
    Try
      frmGravando.fExecutarAcao := fGravarPromocao;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  finally
    pFreeAndNil(frmGravando);
  end;

  pSetEnabledCliente;

end;

procedure TfrmCadPromocoesAut.btnHlpComClick(Sender: TObject);
begin
  inherited;
  TCadPro.pHelpConsiderarComissao(Sender);
end;

procedure TfrmCadPromocoesAut.btnHlpQtdLimClick(Sender: TObject);
begin
  inherited;
  TCadPro.pHelpQuantidadeLimite(Sender);
end;

procedure TfrmCadPromocoesAut.btnAddVpaClick(Sender: TObject);
begin
  inherited;
  if not fValidaVpaVal then
    Exit;

  if btnAddVpa.Tag = 0 then
    FcdsPpaVal.Append
  else
  begin
    FcdsPpaVal.RecNo := btnAddVpa.Tag;
    FcdsPpaVal.Edit;
  end;

  FcdsPpaVal.FieldByName('VPA_DESVPA').AsString := edtDesPro.Text;
  FcdsPpaVal.FieldByName('VPA_DTAINI').AsDateTime := StrToDate(edtDtaInicial.Text);
  FcdsPpaVal.FieldByName('VPA_DTAFIN').AsDateTime := StrToDate(edtDtaFinal.Text);
  FcdsPpaVal.Post;

  pLimpaDadosValidades;
  pSetFocus(edtDesPro);
  btnAddVpa.Tag := 0;
end;

procedure TfrmCadPromocoesAut.btnIncCliClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(edtCodCli, True) then
  Begin
    btnCancelCli.Click;
    Exit;
  End;

  If (Not fEmptyStr(edtCodCli.Text)) Or
     (Not fEmptyStr(edtCodAti.Text)) Or
     (Not fEmptyStr(edtCodCid.Text)) Or
     (Not fEmptyStr(edtEstado.Text)) Or
     (Not fEmptyStr(fTiraCaracEspeciais(edtNuCnpj.Text))) Or
     (Not fEmptyStr(cbxCategoria.Text)) Then
  Begin
    pInsereCliente;
  End
  Else
    fMensagem('ATENÇÃO', 'Defina pelo menos uma pesquisa para inserir os clientes que irão fazer parte desta promoção!', ['&OK']);
end;

procedure TfrmCadPromocoesAut.btnIncCndPagClick(Sender: TObject);
begin
  inherited;
  if not fValidaCndPag then
    Exit;

  If (btnIncCndPag.Tag = 0) and FcdsPpaCnd.Locate('NPA_CODCND', edtCodCnd.Text, []) tHEN
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento já foi escolhida!', ['&Ok']);
    pSetFocus(edtCodCnd);
    Exit;
  end;

  if btnIncCndPag.Tag = 0 then
  begin
    FcdsPpaCnd.Append;
    FcdsPpaCnd.FieldByName('NPA_CODCND').AsString := edtCodCnd.Text;
    FcdsPpaCnd.FieldByName('CND_DESCRI').AsString := edtDesCnd.Text;
    FcdsPpaCnd.FieldByName('CND_CNDPAG').AsString := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False);
    FcdsPpaCnd.FieldByName('NPA_JURREM').AsString := edtJurRem.Text;
  end
  else
  begin
    FcdsPpaCnd.RecNo := btnIncCndPag.Tag;
    FcdsPpaCnd.Edit;
  end;

  FcdsPpaCnd.FieldByName('NPA_JURREM').AsString := edtJurRem.Text;
  FcdsPpaCnd.Post;

  pLimpaDadosCondicao;
  pSetFocus(edtCodCnd);
  btnIncCndPag.Tag := 0;
end;

procedure TfrmCadPromocoesAut.btnIncluirClick(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  pControlaPrecoDesconto(TTipDescPro.tdpDescon);

  pgcDados.ActivePageIndex := 0;

  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);

  pDeletaTemporaria;

  edtNomCli.Clear;
  edtJurRem.Text := 'S';

  pLimpaDadosValidades;

  qryTabela.FieldByName('PPA_COMPRO').AsString := 'P';
  qryTabela.FieldByName('PPA_IDXQTD').AsInteger := 0;
  qryTabela.FieldByName('PPA_PROPRE').AsString := fCfgSis('PROPRE');
  qryTabela.FieldByName('PPA_RESNCO').AsString := 'N';
  qryTabela.FieldByName('PPA_ECOMME').AsString := 'N';
  qryTabela.FieldByName('PPA_ENTIME').AsString := 'S';
  qryTabela.FieldByName('PPA_ENTFUT').AsString := 'S';
  qryTabela.FieldByName('PPA_TRAPRO').AsString := 'S';

  {**********************************}
  {* SELECIONANDO TODAS AS EMPRESAS *}
  {*******************************LU*}
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    clbEmpresa.Checked[intContador] := True;
  End;

  {**********************************}
  {* SELECIONANDO TODAS AS TABELAS  *}
  {*******************************LU*}
  For intContador := 0 To clbTabPre.Items.Count -1 Do
  Begin
    clbTabPre.Checked[intContador] := VS_strTabVen[Succ(intContador)] = 'S';
    pEscondeColunasTab(intContador + 1);
  End;

  pSetEnabledCliente;
end;

procedure TfrmCadPromocoesAut.btnMarcarTodasEmpresasClick(
  Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  For intContador := 0 To clbEmpresa.Items.Count -1 Do
    clbEmpresa.Checked[intContador] := True;

end;

procedure TfrmCadPromocoesAut.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPromocoes: TConsultasArray;
begin
  pgcDados.ActivePageIndex := 0;

  chrKey := '/';
  pDeletaTemporaria;
  If fPesqPromocoesAutomatizadas(Self, Nil, Nil, qryTabela, chrKey, arrPromocoes) Then
  Begin
    pAfterScroll(Nil);

    If (btnAlterar.Enabled) Then
      pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadPromocoesAut.cbxCategoriaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
   If (Key = VK_RETURN) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.chkEcommerceClick(Sender: TObject);
begin
  inherited;
  if chkEcommerce.Checked then
  begin
    if not FcdsPpaCli.isEmpty then
    begin
      fMensagem('','Uma Promoção para e-commerce não pode conter clientes.', ['&OK']);
      chkEcommerce.Checked := false;
      exit;
    end;
  end;

  FblnEcomme := chkEcommerce.Checked;
  tbsClientes.Enabled := Not FblnEcomme;
  pnlCndPag.Enabled := Not FblnEcomme;

  If FblnEcomme Then
    chkPromocaoRestritaClientesNaoConsumidor.Checked := False;

  chkPromocaoRestritaClientesNaoConsumidor.Enabled := (dtsCadPpa.DataSet.State in dsEditModes) and (Not FblnEcomme);
end;

procedure TfrmCadPromocoesAut.clbTabPreClickCheck(Sender: TObject);
Var
  intTab: Integer;
begin
  inherited;
  For intTab := 1 To clbTabPre.Items.Count Do
  Begin
    If VS_strTabVen[intTab] <> 'S' Then
      clbTabPre.Checked[Pred(intTab)] := False;

    pEscondeColunasTab(intTab);
  End;
end;

procedure TfrmCadPromocoesAut.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
Var
  Flags: Longint;
begin
  If VS_strTabVen[Succ(Index)] <> 'S' Then
    TCheckListBox(Control).Canvas.Font.Color  := clSilver;

//  TCheckListBox(Control).Canvas.Brush.Color := clWhite;
  TCheckListBox(Control).Canvas.FillRect(Rect);

  Flags := TCheckListBox(Control).DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

  If Not TCheckListBox(Control).UseRightToLeftAlignment then
    Inc(Rect.Left, 2)
  Else
    Dec(Rect.Right, 2);

  DrawText(TCheckListBox(Control).Canvas.Handle, pWideChar(TCheckListBox(Control).Items[Index]), Length(TCheckListBox(Control).Items[Index]), Rect, Flags);
end;

procedure TfrmCadPromocoesAut.clbTabPreExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
    Begin
      fMensagem('AVISO','Selecione ao menos uma tabela de preço para a promoção!', ['&O K']);
      pSetFocus(clbTabPre);
    End;
  End;
end;

procedure TfrmCadPromocoesAut.clbTabPreKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl,True,True);
  End;
end;

procedure TfrmCadPromocoesAut.cxgClientesTvColumn5GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
var
  LText: String;
begin
  inherited;
  LText := AText;
  If (Length(LText) > 12) Then
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), LText)
  Else
    AText := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), LText);
end;

procedure TfrmCadPromocoesAut.cxgClientesTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      If (qryTabela.State In dsEditModes) And (Not FcdsPpaCli.IsEmpty) then
      Begin
        If fPergunta('Deseja remover o cliente ' + FcdsPpaCli.FieldByName('CPA_CODCLI').AsString + ' da promoção?') then
          FcdsPpaCli.Delete;
      End;
  end;
end;

procedure TfrmCadPromocoesAut.cxgCndPagTvCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (FcdsPpaCnd.RecordCount > 0) And (qryTabela.State In dsEditModes) Then
  Begin
    pLimpaDadosValidades;
    pSetFocus(edtCodCnd);

    edtCodCnd.Text := FcdsPpaCnd.FieldByName('NPA_CODCND').AsString;
    edtDesCnd.Text := FcdsPpaCnd.FieldByName('CND_DESCRI').AsString;
    edtJurRem.Text := FcdsPpaCnd.FieldByName('NPA_JURREM').AsString;

    btnIncCndPag.Tag := FcdsPpaCnd.RecNo;
  End;

end;

procedure TfrmCadPromocoesAut.cxgCndPagTvCNDPAGGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := fFormataCondPag(AText);
end;

procedure TfrmCadPromocoesAut.cxgCndPagTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      Begin
        If (qryTabela.State In dsEditModes) And (Not FcdsPpaCnd.IsEmpty) Then
          If fPergunta('Deseja remover a condição de pagamento ' + FcdsPpaCnd.FieldByName('CND_DESCRI').AsString + ' da promoção?') Then
            FcdsPpaCnd.Delete;
      End;
    VK_ESCAPE: pSetFocus(edtCodCnd);
  end;
end;

procedure TfrmCadPromocoesAut.cxgItensTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (FcdsPpaIte.RecordCount > 0) And (qryTabela.State In dsEditModes) Then
  Begin
    btnCancelaItem.Click;
    pCarregaItemAlteracao;
    FblnAltGrd := True;
  End;
end;

procedure TfrmCadPromocoesAut.cxgItensTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (qryTabela.State In dsEditModes) Then
  Begin
    btnCancelaItem.Click;
    pCarregaItemAlteracao;
    FblnAltGrd := True;
  End
  Else If (Key = VK_DELETE) And (qryTabela.State In dsEditModes) Then
  Begin
    If (FcdsPpaIte.Active) And (Not FcdsPpaIte.IsEmpty) Then
      FcdsPpaIte.Delete;
  End;
end;

procedure TfrmCadPromocoesAut.dtsCadPpaStateChange(Sender: TObject);
begin
  inherited;
  pnlTabelas.Enabled := (qryTabela.State In dsEditModes);
  pnlEmpresa.Enabled := (qryTabela.State In dsEditModes);
  pnlValidades.Enabled := (qryTabela.State In dsEditModes);
  pnlCndPag.Enabled := (qryTabela.State In dsEditModes);
end;

procedure TfrmCadPromocoesAut.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    edtNuCnpj.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else If (edtCgcCpf.Text = '2') Then
    edtNuCnpj.EditMask := '999.999.999-99;0;'
  Else
    edtNuCnpj.EditMask := '';
end;

procedure TfrmCadPromocoesAut.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, FarrAtiv, nil, fRetNomAtividade, 'da atividade', 3);
end;

procedure TfrmCadPromocoesAut.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, FarrAtiv, False) Then
    if fValidaCampos(edtCodAti, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtDesCid, FarrCidade, fRetNomCidadeSemOpc, Nil, 'da cidade', 5);
end;

procedure TfrmCadPromocoesAut.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtDesCid, edtEstado, Nil, Key, FarrCidade, False) Then
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, FarrClientes, nil, fRetNomCliente, 'do cliente', 8);
end;

procedure TfrmCadPromocoesAut.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, FarrClientes, False) Then
    If fValidaCampos(edtCodCli, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, FarrCndPag, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmCadPromocoesAut.edtCodCndKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, FarrCndPag) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadPromocoesAut.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If fEmptyStr(edtCodIte.Text) or (Length(FarrProdutos) > 1) Then
    pLimpaInputsDadosItem;

  pEdtCodSelectExit(edtCodIte, edtDesIte, FarrProdutos, Nil, fRetNomProduto, 'do produto');
end;

procedure TfrmCadPromocoesAut.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, FqryConIte, Key, FarrProdutos, False) Then
    if fValidaCampos(edtCodIte, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  If edtFornecedor.ReadOnly Then
    Exit;

  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, FarrFornec, fRetNomFornecedor, Nil, 'do fornecedor');
end;

procedure TfrmCadPromocoesAut.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If edtFornecedor.ReadOnly Then
    Exit;

  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, FarrFornec, False) Then
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtMarcaExit(Sender: TObject);
begin
  inherited;
  If edtMarca.ReadOnly Then
    Exit;

  pEdtCodSelectExit(edtMarca, edtDesMarca, FarrMarca, fRetNomMarca, Nil, 'da marca');
end;

procedure TfrmCadPromocoesAut.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If edtMarca.ReadOnly Then
    Exit;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, FarrMarca, False) Then
    if fValidaCampos(edtMarca, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.edtNuCnPjEnter(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Or (edtCgcCpf.Text = '2') Then
    edtNuCnPj.ReadOnly := False
  Else
    edtNuCnPj.ReadOnly := True;
end;

procedure TfrmCadPromocoesAut.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtUnidade, Nil, FarrUnidades, fRetNomUnidade, Nil, 'da unidade');
end;

procedure TfrmCadPromocoesAut.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqUnidade(Self, edtUnidade, Nil, Nil, Nil, Key, FarrUnidades, False) then
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCadPromocoesAut.fGetEmpresasSelecionadas: String;
  Var
    intContador: Integer;
begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
end;

procedure TfrmCadPromocoesAut.pMarcarTabelasPreco(strTabelas: String);
  Var
    intTabPre: Integer;
begin
  //Caso a string esteja menor que a quantidade de tabelas de preço preenche com 'N'
  strTabelas := fPadR(strTabelas, clbTabPre.Items.Count, 'N'); //'NNNNNNN'
  //Marca as tabelas de preco utilizadas na promocao
  For intTabPre := 1 To clbTabPre.Items.Count Do
  Begin
    clbTabPre.Checked[intTabPre - 1] := (strTabelas[intTabPre] = 'S') And (VS_strTabVen[intTabPre] = 'S');
    pEscondeColunasTab(intTabPre);
  End;
end;

function TfrmCadPromocoesAut.fGetTabelasPrecoSelecionadas: String;
  Var
    intTabPre: Integer;
begin
  Result := '';
  For intTabPre := 1 To clbTabPre.Items.Count Do
    Result := Result + IIF(clbTabPre.Checked[intTabPre -1], 'S', 'N');
end;

procedure TfrmCadPromocoesAut.pEscondeColunasTab(intTabPre: Integer);
  Var
    blnDesc: Boolean;
begin
  blnDesc := (FopcTipDes In [tdpDescon,
                             tdpPorcentoDescontoComDescontoAdicional,
                             tdpPorcentoDescontoQuantidadeColetiva,
                             tdpNegociacaoEspecialFornecedorPC]);
  cxgItensIPA_PERDES.Visible := blnDesc And (Not (FopcTipDes = tdpNegociacaoEspecialFornecedorPC));

  cxgItensTableView.Bands[3].Visible := Not blnDesc;
  cxgItensTableView.Bands[4].Visible := blnDesc And clbTabPre.Checked[0];
  cxgItensTableView.Bands[5].Visible := blnDesc And clbTabPre.Checked[1];
  cxgItensTableView.Bands[6].Visible := blnDesc And clbTabPre.Checked[2];
  cxgItensTableView.Bands[7].Visible := blnDesc And clbTabPre.Checked[3];
  cxgItensTableView.Bands[8].Visible := blnDesc And clbTabPre.Checked[4];
  cxgItensTableView.Bands[9].Visible := blnDesc And clbTabPre.Checked[5];
  cxgItensTableView.Bands[10].Visible := blnDesc And clbTabPre.Checked[6];

  cxgItensITE_MARBR1.Visible := clbTabPre.Checked[0];
  cxgItensITE_MARLQ1.Visible := clbTabPre.Checked[0];
  cxgItensITE_PREVE1.Visible := clbTabPre.Checked[0];
  cxgItensITE_MARBR2.Visible := clbTabPre.Checked[1];
  cxgItensITE_MARLQ2.Visible := clbTabPre.Checked[1];
  cxgItensITE_PREVE2.Visible := clbTabPre.Checked[1];
  cxgItensITE_MARBR3.Visible := clbTabPre.Checked[2];
  cxgItensITE_MARLQ3.Visible := clbTabPre.Checked[2];
  cxgItensITE_PREVE3.Visible := clbTabPre.Checked[2];
  cxgItensITE_MARBR4.Visible := clbTabPre.Checked[3];
  cxgItensITE_MARLQ4.Visible := clbTabPre.Checked[3];
  cxgItensITE_PREVE4.Visible := clbTabPre.Checked[3];
  cxgItensITE_MARBR5.Visible := clbTabPre.Checked[4];
  cxgItensITE_MARLQ5.Visible := clbTabPre.Checked[4];
  cxgItensITE_PREVE5.Visible := clbTabPre.Checked[4];
  cxgItensITE_MARBR6.Visible := clbTabPre.Checked[5];
  cxgItensITE_MARLQ6.Visible := clbTabPre.Checked[5];
  cxgItensITE_PREVE6.Visible := clbTabPre.Checked[5];
  cxgItensITE_MARBR7.Visible := clbTabPre.Checked[6];
  cxgItensITE_MARLQ7.Visible := clbTabPre.Checked[6];
  cxgItensITE_PREVE7.Visible := clbTabPre.Checked[6];
end;

procedure TfrmCadPromocoesAut.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('PPA_CODPPA');
  stlCamInd.Add('PPA_DESPPA');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadPromocoesAut.pLimpaDadosCondicao;
begin
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  edtJurRem.Text := 'S';
end;

procedure TfrmCadPromocoesAut.pLimpaDadosValidades;
begin
  edtDesPro.Clear;
  edtDtaInicial.Clear;
  edtDtaFinal.Clear;
end;

procedure TfrmCadPromocoesAut.rdgComProClick(Sender: TObject);
begin
  inherited;
  If (not btnAlterar.Enabled) And ( not FcdsPpaIte.isEmpty) And (rdgComPro.ItemIndex = 1) then
    If fMensagem('ATENÇÃO!', 'A opção "Considerar comissão definida nas configurações do sistema",'+
                             ' vai zerar as comissões de todos os itens dessa promoção.'+#13+
                             'Deseja continuar?', ['&Sim', '&Não']) = 1 Then
      pZeraComissao
    Else
      rdgComPro.ItemIndex := 0;
end;

procedure TfrmCadPromocoesAut.pControlaPrecoDesconto(opcPreDes: TTipDescPro);
Var
  blnDesc: Boolean;
begin
  blnDesc := (opcPreDes In [tdpDescon, tdpPorcentoDescontoComDescontoAdicional, tdpPorcentoDescontoQuantidadeColetiva]);
  cxgItensIPA_PERDES.Visible := blnDesc;

  cxgItensTableView.Bands[3].Visible := Not blnDesc;
  cxgItensTableView.Bands[4].Visible := blnDesc And clbTabPre.Checked[0];
  cxgItensTableView.Bands[5].Visible := blnDesc And clbTabPre.Checked[1];
  cxgItensTableView.Bands[6].Visible := blnDesc And clbTabPre.Checked[2];
  cxgItensTableView.Bands[7].Visible := blnDesc And clbTabPre.Checked[3];
  cxgItensTableView.Bands[8].Visible := blnDesc And clbTabPre.Checked[4];
  cxgItensTableView.Bands[9].Visible := blnDesc And clbTabPre.Checked[5];
  cxgItensTableView.Bands[10].Visible := blnDesc And clbTabPre.Checked[6];

  cxgItensITE_MARBR1.Visible := clbTabPre.Checked[0];
  cxgItensITE_MARLQ1.Visible := clbTabPre.Checked[0];
  cxgItensITE_PREVE1.Visible := clbTabPre.Checked[0];
  cxgItensITE_MARBR2.Visible := clbTabPre.Checked[1];
  cxgItensITE_MARLQ2.Visible := clbTabPre.Checked[1];
  cxgItensITE_PREVE2.Visible := clbTabPre.Checked[1];
  cxgItensITE_MARBR3.Visible := clbTabPre.Checked[2];
  cxgItensITE_MARLQ3.Visible := clbTabPre.Checked[2];
  cxgItensITE_PREVE3.Visible := clbTabPre.Checked[2];
  cxgItensITE_MARBR4.Visible := clbTabPre.Checked[3];
  cxgItensITE_MARLQ4.Visible := clbTabPre.Checked[3];
  cxgItensITE_PREVE4.Visible := clbTabPre.Checked[3];
  cxgItensITE_MARBR5.Visible := clbTabPre.Checked[4];
  cxgItensITE_MARLQ5.Visible := clbTabPre.Checked[4];
  cxgItensITE_PREVE5.Visible := clbTabPre.Checked[4];
  cxgItensITE_MARBR6.Visible := clbTabPre.Checked[5];
  cxgItensITE_MARLQ6.Visible := clbTabPre.Checked[5];
  cxgItensITE_PREVE6.Visible := clbTabPre.Checked[5];
  cxgItensITE_MARBR7.Visible := clbTabPre.Checked[6];
  cxgItensITE_MARLQ7.Visible := clbTabPre.Checked[6];
  cxgItensITE_PREVE7.Visible := clbTabPre.Checked[6];

  pEnabledEdit(mskLinhaGrupo);
  pEnabledEdit(edtCodIte);
  pEnabledEdit(edtMarca);
  pEnabledEdit(edtFornecedor);
  pEnabledEdit(edtDescriIni);
  pEnabledEdit(edtDescriFin);
  pEnabledEdit(edtRefere);
end;

procedure TfrmCadPromocoesAut.pEnabledEdit(Edit: TCustomEdit);
begin
  If (Edit Is TEditFocus) Then
  Begin
    TEditFocus(Edit).ReadOnly := False;
    TEditFocus(Edit).TabStop := True;
    TEditFocus(Edit).Color := clWindow;
  End
  Else If (Edit Is TMaskEditFocus) Then
  Begin
    TMaskEditFocus(Edit).ReadOnly := False;
    TMaskEditFocus(Edit).TabStop := True;
    TMaskEditFocus(Edit).Color := clWindow;
  End
  Else If (Edit Is TDBEditFocus) Then
  Begin
    TDBEditFocus(Edit).ReadOnly := False;
    TDBEditFocus(Edit).TabStop := True;
    TDBEditFocus(Edit).Color := clWindow;
    If (TDBEditFocus(Edit).DataSource.DataSet.State In [dsInsert, dsEdit]) Then
      TDBEditFocus(Edit).Enabled := True;
  End;
end;

function TfrmCadPromocoesAut.fGravarPromocao(pgbStatus: TcxProgressBar): Boolean;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

  {**********************************************}
  {* VERIFICA SE ALGUMA EMPRESA FOI SELECIONADA *}
  {*******************************************LU*}
  Result := False;

  pnlInfo.Caption := 'Gerando Registros!!!';

  Try

    {********************************}
    {* COMEÇA A GRAVAR AS PROMOÇÕES *}
    {*****************************LU*}
    fStartTransaction;

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

    If qryTabela.State = dsBrowse Then
      qryTabela.Insert;

    If qryTabela.State = dsInsert Then
    Begin
      qryTabela.FieldByName('PPA_CODPPA').AsString := fAtualizaProCod('CADPPA', 'PPA_CODPPA', '', 1, Nil,
        function (const AValue : String) : String
        begin
          Result := Concat(VS_strCodEmp, AValue);
        end
      );
      qryTabela.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADPPA', VS_strCodEmp);
      qryTabela.FieldByName('PPA_DTACAD').AsDateTime := fNow;
      qryTabela.FieldByName('PPA_HORCAD').AsDateTime := fNow;
      qryTabela.FieldByName('PPA_OPECAD').AsString   := strLoginUsuarioLogado;
    End
    Else
    If qryTabela.State = dsEdit Then
    begin
      qryTabela.FieldByName('PPA_DTAALT').AsDateTime := fNow;
      qryTabela.FieldByName('PPA_HORALT').AsDateTime := fNow;
      qryTabela.FieldByName('PPA_OPEALT').AsString   := strLoginUsuarioLogado;
    end;

    qryTabela.FieldByName('PPA_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('PPA_TABPRE').AsString   := fGetTabelasPrecoSelecionadas;
    qryTabela.Post;

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Itens...', FcdsPpaIte.RecordCount);
    pGravarItens(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Clientes...', FcdsPpaCli.RecordCount);
    pGravarClientes(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Empresas...', clbEmpresa.Items.Count);
    pGravarEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Validades...', FcdsPpaVal.RecordCount);
    pGravarValidades(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Condições de Pagamentos...', FcdsPpaCnd.RecordCount);
    pGravarCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pnlInfo.Caption := '';

    pInfoStatusGravacao(pgbStatus, 'Gravação da Promoção Concluída... Carregando Dados.');

    fCommit;

    pDeletaTemporaria;
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
    pEnabled(Self, False);
    pSetFocus(btnIncluir);
    pAfterScroll(Nil);

    pgcDados.ActivePageIndex := 0;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadPromocoes.btnGravarClick]');
    End;
  End;

end;

function TfrmCadPromocoesAut.fRetornaProdutosDaPromocao: string;
begin
  Result := '';
  Try
    FcdsPpaIte.DisableControls;
    FcdsPpaIte.First;

    While Not FcdsPpaIte.Eof Do
    Begin
      If fEmptyStr(Result) Then
        Result := '"' + FcdsPpaIte.FieldByName('IPA_CODITE').AsString + '"'
      Else
        Result := Result + ',"' + FcdsPpaIte.FieldByName('IPA_CODITE').AsString + '"';

      FcdsPpaIte.Next;
    End;

  Finally
    FcdsPpaIte.First;
    FcdsPpaIte.EnableControls;
  End;
end;

function TfrmCadPromocoesAut.fVerificaProdutoTintaMaquina: Boolean;
var
  qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ITE_CODITE        ');
    qryGen.SQL.Add('  FROM CADITE            ');
    qryGen.SQL.Add(' WHERE (ITE_ITEBAS = "S" ');
    qryGen.SQL.Add('    OR  ITE_ITEPIG = "S" ');
    qryGen.SQL.Add('    OR  ITE_PROEMB = "S" ');
    qryGen.SQL.Add('    OR  ITE_CNV_ML > 0)  ');
    qryGen.SQL.Add('   AND ITE_CODITE IN (' + fRetornaProdutosDaPromocao + ') ');
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadPromocoesAut.grdValidadesTvCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (FcdsPpaVal.RecordCount > 0) And (qryTabela.State In dsEditModes) Then
  Begin
    pLimpaDadosValidades;
    pSetFocus(edtDesPro);

    edtDesPro.Text := FcdsPpaVal.FieldByName('VPA_DESVPA').AsString;
    edtDtaInicial.Text := DateToStr(FcdsPpaVal.FieldByName('VPA_DTAINI').AsDateTime);
    edtDtaFinal.Text := DateToStr(FcdsPpaVal.FieldByName('VPA_DTAFIN').AsDateTime);

    btnAddVpa.Tag := FcdsPpaVal.RecNo;
  End;
end;

procedure TfrmCadPromocoesAut.grdValidadesTvKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      Begin
        If (qryTabela.State In dsEditModes) And (Not FcdsPpaVal.IsEmpty) Then
          If fPergunta('Deseja remover a validade ' + FcdsPpaVal.FieldByName('VPA_DESVPA').AsString + ' da promoção?') Then
            FcdsPpaVal.Delete;
      End;
    VK_ESCAPE: pSetFocus(edtDesPro);
  end;
end;

procedure TfrmCadPromocoesAut.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  If mskLinhaGrupo.ReadOnly Then
    Exit;

  pEdtCodSelectExit(mskLinhaGrupo, edtDesGrupo, FarrGrupos, fRetNomeLinhaGrupo, Nil, 'da linha / grupo', 6);
end;

procedure TfrmCadPromocoesAut.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If mskLinhaGrupo.ReadOnly Then
    Exit;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, FarrGrupos, False) Then
    if fValidaCampos(mskLinhaGrupo, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoesAut.pSetEnabledCliente;
begin
  If (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    edtNuCnPj.Enabled    := True;
    cbxCategoria.Enabled := True;
  End
  Else
  Begin
    edtNuCnPj.Enabled    := False;
    edtNuCnPj.Text       := '';
    cbxCategoria.Enabled := False;
    cbxCategoria.Text    := '';
  End;
end;

procedure TfrmCadPromocoesAut.pDeletaTemporaria;
begin
  Exit;

  If FcdsPpaIte.Active Then
    FcdsPpaIte.EmptyDataSet;

  If FcdsPpaCli.Active Then
    FcdsPpaCli.EmptyDataSet;

  If FcdsPpaCnd.Active Then
    FcdsPpaCnd.EmptyDataSet;

  If FcdsPpaVal.Active Then
    FcdsPpaVal.EmptyDataSet;
end;

function TfrmCadPromocoesAut.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDesPro) Then
    Begin

      If (fEmptyStr(dbeDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da promoção automatizada deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDesPro) Then
    Begin

      If (fEmptyStr(edtDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da promoção deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtDtaInicial) and blnBuscaPorChave Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(edtDtaInicial.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A data inicial deve ser preenchida!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtDtaFinal) and blnBuscaPorChave Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDtaFinal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(edtDtaInicial.Text, edtDtaFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodCli.Text)) and (Length(FarrClientes) = 1) Then
      Begin
        pBuscaDadosCliente;

        If (fEmptyStr(edtNomCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Este cliente não está cadastrado!',['&O K']);
          Result := False;
        End
        Else If chkPromocaoRestritaClientesNaoConsumidor.Checked And
           fClienteConsumidor(edtNomCli.Text, True, True) Then
        Begin
          fMensagem('ATENÇÃO','Promoção restrita a clientes não consumidor!',['&O K']);
          Result := False;
        End
      End;

    End

    Else If (Sender = edtCodAti) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodAti.Text)) and (Length(FarrAtiv) = 1) Then
      Begin
        edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);

        If (fEmptyStr(edtDesAti.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Esta atividade não está cadastrada!',['&O K']);
          Result := False;
        End

      End;

    End

    Else If (Sender = edtCodCid) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodCid.Text)) and (Length(FarrCidade) = 1) Then
      Begin
        edtDesCid.Text := fRetNomCidade(edtCodCid.Text);
        edtEstado.Text := fRetNomCidade(edtCodCid.Text,1);

        If (fEmptyStr(edtDesCid.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Esta cidade não está cadastrada!',['&O K']);
          Result := False;
        End

      End;

    End

    {*****************************************}
    {* VALIDA O CAMPO CNPJ / CPF             *}
    {**************************************MV*}
    Else If (Sender = edtCgcCpf) And (edtCgcCpf.Enabled) Then
    Begin

      If Not fEmptyStr(edtCgcCpf.Text)Then
      Begin
        If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
          Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA CNPJ / CPF                     *}
    {**************************************MV*}
    Else If (Sender = edtNuCnpj) And (edtNuCnpj.Enabled) Then
    Begin

      If fEmptyStr(edtNuCnpj.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ / CPF deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        Result := fValidaCampos(edtCgcCpf, True);
        If (Result) Then
          Result := fValidaCnpjCpf(edtCgcCpf.Text, edtNuCnpj.Text, False, True);

        If Not Result Then
          Sender := edtCgcCpf;

      End;

    End

    Else If (Sender = edtDescriIni) Then
    Begin
      If fEmptyStr(edtDescriIni.Text) Then
        edtDescriFin.Enabled := False
      Else
        edtDescriFin.Enabled := True;
    End

    Else If (Sender = edtDescriFin) Then
    Begin
      If Not fEmptyStr(edtDescriIni.Text) Then
      Begin
        If fEmptyStr(edtDescriFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A descrição final deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodIte) And (Not edtCodIte.ReadOnly) Then
    Begin

      If Length(FArrProdutos) = 1 then
      begin
        pCarregaCadIte(blnBuscaPorChave); // localiza o item

        If (FqryConIte.FieldByName('ITE_CODITE').IsNull) Then // caso nao seja encontrado
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
      If (Result) And (fEmptyStr(edtQtdMin.Text)) Then
        edtQtdMin.Text := '1,00';
    End

    Else If ((Sender = edtQtdLim) Or (Sender = edtQtdMin)) And
            ((Not edtQtdLim.ReadOnly) And (Not edtQtdMin.ReadOnly)) Then
    Begin
      If (Sender = edtQtdMin) Then
      begin
        Result := fValidaLimiteMinima(edtQtdLim, edtQtdMin, Sender);
      end;
    End

    Else If (Sender = edtPerDes) And (Not edtPerDes.ReadOnly) Then
    Begin

      If (fEmptyStr(edtPerDes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtPerDes.Text) <= 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto deve ser maior que zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPrzMed) And (blnBuscaPorChave) Then
    Begin
      If fEmptyStr(edtPrzMed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O prazo médio da condição de pagamento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtPrzMed.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O prazo médio da condição de pagamento deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtComVar) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(edtComVar.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "vendedor interno" deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtComVar.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "vendedor interno" deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtComAta) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(edtComAta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "representante externo loja" deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtComAta.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "representante externo loja" deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtComDis) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(edtComDis.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "representante externo distribuidor" deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtComDis.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A comissão do "representante externo distribuidor" deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCnd) and blnBuscaPorChave Then
    Begin
      If Not fEmptyStr(edtCodCnd.Text) Then
      Begin
        If fEmptyStr(fRetDesConPag(edtCodCnd.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Condição não cadastrada!', ['&Ok']);
          Result := False;
        End
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A Condição de Pagamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    end

    Else If (Sender = edtJurRem) and blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtJurRem.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Aplicar Juros Remanescentes deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (edtJurRem.Text <> 'S') And (edtJurRem.Text <> 'N') Then
      Begin
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadPromocoesAut.fValidaVpaVal: Boolean;
begin
  Result := False;

  if (Not fValidaCampos(edtDesPro, True)) then
    Exit;
  if (Not fValidaCampos(edtDtaInicial, True)) then
    Exit;
  if (Not fValidaCampos(edtDtaFinal, True)) then
    Exit;

  Result := True;
end;

procedure TfrmCadPromocoesAut.pBuscaDadosCliente;
Var
  strSQL   : String;
  qryGenCli: TUniQuery;
Begin
  Try

    qryGenCli := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CLI_NOMCLI, ';
    strSQL := strSQL + '  CLI_CODATI, ';
    strSQL := strSQL + '  CLI_CODCID, ';
    strSQL := strSQL + '  CLI_CGCCPF, ';
    strSQL := strSQL + '  CLI_C_G_C_, ';
    strSQL := strSQL + '  CID_NOMCID, ';
    strSQL := strSQL + '  CID_ESTADO, ';
    strSQL := strSQL + '  ATI_DESATI, ';
    strSQL := strSQL + '  CLI_CATEGO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C LEFT JOIN CADATI A ON C.CLI_CODATI = A.ATI_CODATI ';
    strSQL := strSQL + '           LEFT JOIN CADCID D ON C.CLI_CODCID = D.CID_CODCID ';

    If fCfgSis('UCLVEN', VarBoolean) Then
      strSQL := strSQL + '           LEFT JOIN VENCLI V ON C.CLI_CODCLI = V.CVN_CODCLI ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI ';

    qryGenCli.Close;
    qryGenCli.SQL.Clear;
    qryGenCli.SQL.Add(strSQL);
    qryGenCli.ParamByName('CODCLI').AsString := edtCodCli.Text;
    qryGenCli.Open;
    If Not qryGenCli.IsEmpty Then
    Begin
      edtNomCli.Text := qryGenCli.FieldByName('CLI_NOMCLI').AsString;
      edtCodAti.Text := qryGenCli.FieldByName('CLI_CODATI').AsString;
      edtDesAti.Text := qryGenCli.FieldByName('ATI_DESATI').AsString;
      edtCodCid.Text := qryGenCli.FieldByName('CLI_CODCID').AsString;
      edtDesCid.Text := qryGenCli.FieldByName('CID_NOMCID').AsString;
      edtEstado.Text := qryGenCli.FieldByName('CID_ESTADO').AsString;
      edtCgcCpf.Text := qryGenCli.FieldByName('CLI_CGCCPF').AsString;
      edtNuCnPj.Text := qryGenCli.FieldByName('CLI_C_G_C_').AsString;
      cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(qryGenCli.FieldByName('CLI_CATEGO').AsString);
    End
    Else
    Begin
      edtNomCli.Text := '';
      edtCodAti.Text := '';
      edtDesAti.Text := '';
      edtCodCid.Text := '';
      edtDesCid.Text := '';
      edtEstado.Text := '';
      edtCgcCpf.Text := '';
      edtNuCnPj.Text := '';
      cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(' ');
    End;
    qryGenCli.Close;

  Finally
    FreeAndNil(qryGenCli);
  End;

end;

procedure TfrmCadPromocoesAut.pCarregaCadastro;
begin
  qryTabela.Close;
  qryTabela.SQL.Text := 'SELECT * FROM CADPPA WHERE AUTOINCREM = :AUTINC';
  qryTabela.ParamByName('AUTINC').AsString := FstrAutInc;
  qryTabela.Open;

  pAfterScroll(Nil);

  If (btnAlterar.Enabled) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadPromocoesAut.pCarregaCadIte(blnAtualizaTela: Boolean);
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE, ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
  strSQL := strSQL + '  ITEGER.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  ITEGER.ITE_CODEMP = :CODEMP ';

  FqryConIte.Close;
  FqryConIte.SQL.Clear;
  FqryConIte.SQL.Add(strSQL);
  FqryConIte.ParamByName('CODITE').AsString := edtCodIte.Text;
  FqryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
  FqryConIte.Open;

  If (blnAtualizaTela) Then
  Begin

    edtDesIte.Text := FqryConIte.FieldByName('ITE_DESITE').AsString;// + ' ' + FieldByName('ITE_REFERE').AsString;
    edtComVar.Text := FloatToStrF(FqryConIte.FieldByName('ITE_COMVAR').AsFloat, ffFixed, 12, 2);
    edtComAta.Text := FloatToStrF(FqryConIte.FieldByName('ITE_COMATA').AsFloat, ffFixed, 12, 2);
    edtComDis.Text := FloatToStrF(FqryConIte.FieldByName('ITE_COMDIS').AsFloat, ffFixed, 12, 2);
    edtPrzMed.Text := '0';
  End;
end;

procedure TfrmCadPromocoesAut.pCarregaClientes(strAutInc: String);
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  P.*, ';
  strSQL := strSQL + '  C.CLI_NOMCLI AS PRO_NOMCLI, ';
  strSQL := strSQL + '  A.ATI_DESATI AS PRO_ATIVID, ';
  strSQL := strSQL + '  CONCAT(D.CID_NOMCID," - ",D.CID_ESTADO) AS PRO_CIDEST, ';
  strSQL := strSQL + '  C.CLI_C_G_C_ AS PRO_CGCCPF, ';
  strSQL := strSQL + '  C.CLI_CATEGO AS PRO_CATEGO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PPACLI P ';
  strSQL := strSQL + '  JOIN CADCLI C ON P.CPA_CODCLI = C.CLI_CODCLI ';
  strSQL := strSQL + '  JOIN CADATI A ON C.CLI_CODATI = A.ATI_CODATI ';
  strSQL := strSQL + '  JOIN CADCID D ON C.CLI_CODCID = D.CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CPA_SEQPPA = ' + QuotedStr(strAutInc);

  If Assigned(FcdsPpaCli) Then
    FreeAndNil(FcdsPpaCli);

  FcdsPpaCli := fCriaClientDataset(strSQL);
  dtsPpaCli.DataSet := FcdsPpaCli;
end;

procedure TfrmCadPromocoesAut.pCarregaCondicoes(strAutInc: String);
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT PPACND.*, CND_DESCRI, CND_CNDPAG ';
  strSQL := strSQL + 'FROM PPACND ';
  strSQL := strSQL + 'JOIN CADCND ON CND_CODIGO = NPA_CODCND ';
  strSQL := strSQL + 'WHERE NPA_SEQPPA = ' + QuotedStr(strAutInc);

  If Assigned(FcdsPpaCnd) Then
    FreeAndNil(FcdsPpaCnd);

  FcdsPpaCnd := fCriaClientDataset(strSQL);
  dtsPpaCnd.DataSet := FcdsPpaCnd;
end;

function TfrmCadPromocoesAut.fCarregaDados(pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  pInfoStatusGravacao(pgbStatus, 'Aguarde... Carregando Promoção...', 6);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Empresas...');
  pCarregaEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Tabelas de Preço...');
  pCarregaTabelasPreco(qryTabela.FieldByName('PPA_TABPRE').AsString);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Validades...');
  pCarregaValidades(qryTabela.FieldByName('AUTOINCREM').AsString);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Condições de Pagamento...');
  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Clientes...');
  pCarregaClientes(qryTabela.FieldByName('AUTOINCREM').AsString);

  pStepStatusGravacao(pgbStatus, 'Aguarde... Carregando Itens...');
  pCarregaItens(qryTabela.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmCadPromocoesAut.pCarregaEmpresas(strAutInc: String);
var
  strEmpresas: String;
begin
  strEmpresas := fCampoTabela('GROUP_CONCAT(EPA_CODEMP)', 'PPAEMP', ['EPA_SEQPPA'], [strAutInc]);

  pMarcarEmpresas(strEmpresas);
end;

procedure TfrmCadPromocoesAut.pCarregaTabelasPreco(
  strTabelas: String);
begin
  pMarcarTabelasPreco(strTabelas);
end;

procedure TfrmCadPromocoesAut.pCarregaValidades(strAutInc: String);
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT * ';
  strSQL := strSQL + 'FROM PPAVAL ';
  strSQL := strSQL + 'WHERE VPA_SEQPPA = ' + QuotedStr(strAutInc);

  If Assigned(FcdsPpaVal) Then
    FreeAndNil(FcdsPpaVal);

  FcdsPpaVal := fCriaClientDataset(strSQL);
  dtsPpaVal.DataSet := FcdsPpaVal;
end;

procedure TfrmCadPromocoesAut.pCarregaItens(strAutInc: String);
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IPA_CODITE, ';
  strSQL := strSQL + '  ITE_CODFAB, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + '  (ITE_SALDOS + ITE_QTEF_A + ITE_QTEF_F + ITE_QTEF_P + ITE_QTPDBF) AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel('', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL + '  IPA_QTDLIM, ';
  strSQL := strSQL + '  IPA_QTDMIN, ';
  strSQL := strSQL + '  IPA_PRZMED, ';
  // VALORES DA PROMOÇÃO POR PRECO
  strSQL := strSQL + '  IPA_PRECUS, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSREA, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBRU, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLIQ, ';
  strSQL := strSQL + '  IPA_PREVEN, ';
  // VALORES DA PROMOCAO POR PERCENTUAL
  strSQL := strSQL + '  IPA_PERDES, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE1, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR1, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ1, ';
  strSQL := strSQL + '  IPA_PREVEN AS IPA_PREVE1, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE2, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR2, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ2, ';
  strSQL := strSQL + '  IPA_PREVE2, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE3, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR3, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ3, ';
  strSQL := strSQL + '  IPA_PREVE3, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE4, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR4, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ4, ';
  strSQL := strSQL + '  IPA_PREVE4, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE5, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR5, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ5, ';
  strSQL := strSQL + '  IPA_PREVE5, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE6, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR6, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ6, ';
  strSQL := strSQL + '  IPA_PREVE6, ';
  strSQL := strSQL + '  0.00 AS IPA_CUSRE7, ';
  strSQL := strSQL + '  0.00 AS IPA_MARBR7, ';
  strSQL := strSQL + '  0.00 AS IPA_MARLQ7, ';
  strSQL := strSQL + '  IPA_PREVE7, ';
  // VALORES DO CADASTRO DE PRODUTOS
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  ITE_OUTVAL, ';
  strSQL := strSQL + '  ITE_ICMSAI, ';
  strSQL := strSQL + '  ITE_IMPFED, ';
  strSQL := strSQL + '  ITE_DESOPE, ';
  strSQL := strSQL + '  ITE_COMTB1, ';
  strSQL := strSQL + '  ITE_COMTB2, ';
  strSQL := strSQL + '  ITE_COMTB3, ';
  strSQL := strSQL + '  ITE_COMTB4, ';
  strSQL := strSQL + '  ITE_COMTB5, ';
  strSQL := strSQL + '  ITE_COMTB6, ';
  strSQL := strSQL + '  ITE_COMTB7, ';
  strSQL := strSQL + '  0.00 AS ITE_CUSREA, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR1, 0.00) AS ITE_MARLQ1, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR1, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE1, 0.00) AS ITE_PREVE1, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR2, 0.00) AS ITE_MARLQ2, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR2, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE2, 0.00) AS ITE_PREVE2, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR3, 0.00) AS ITE_MARLQ3, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR3, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE3, 0.00) AS ITE_PREVE3, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR4, 0.00) AS ITE_MARLQ4, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR4, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE4, 0.00) AS ITE_PREVE4, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR5, 0.00) AS ITE_MARLQ5, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR5, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE5, 0.00) AS ITE_PREVE5, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR6, 0.00) AS ITE_MARLQ6, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR6, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE6, 0.00) AS ITE_PREVE6, ';
  strSQL := strSQL + '  IFNULL(ITE_MARBR7, 0.00) AS ITE_MARLQ7, ';
  strSQL := strSQL + '  0.00 AS ITE_MARBR7, ';
  strSQL := strSQL + '  IFNULL(ITE_PREVE7, 0.00) AS ITE_PREVE7, ';
  strSQL := strSQL + '  IFNULL(ITE_PREMED, 0.00) AS ITE_PREMED, ';
  strSQL := strSQL + '  IFNULL(ITE_PREULT, 0.00) AS ITE_PREULT, ';
  strSQL := strSQL + '  IFNULL(ITE_IMPULT, 0.00) AS ITE_IMPULT, ';
  // COMISSÃO
  strSQL := strSQL + '  IPA_COMVAR, ';
  strSQL := strSQL + '  IPA_COMATA, ';
  strSQL := strSQL + '  IPA_COMDIS, ';

  strSQL := strSQL + '  ITE_IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM, ';
  strSQL := strSQL + '  ITE_DESF01, ';
  strSQL := strSQL + '  ITE_DESF02, ';
  strSQL := strSQL + '  ITE_DESF03, ';
  strSQL := strSQL + '  ITE_DESF04, ';
  strSQL := strSQL + '  ITE_DESF05, ';
  strSQL := strSQL + '  ITE_DESF06, ';
  strSQL := strSQL + '  ITE_PREDOL, ';
//  strSQL := strSQL + '  IPA_ULTALT, ';

  If (fCfgSis('TIPABF') = '1') Then
    strSQL := strSQL + ' CADITE.ITE_CODABF AS ITE_CODABF '
  Else
    strSQL := strSQL + ' ITEGER.ITE_CODABF AS ITE_CODABF ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PPAITE ';
  strSQL := strSQL + '  INNER JOIN CADITE ON CADITE.ITE_CODITE = PPAITE.IPA_CODITE ';
  strSQL := strSQL + '  INNER JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = IPA_CODEMP ';
  strSQL := strSQL + '  INNER JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + '  INNER JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PPAITE.IPA_SEQPPA = ' + QuotedStr(strAutInc);

  If Assigned(FcdsPpaIte) Then
    FreeAndNil(FcdsPpaIte);

  FcdsPpaIte := fCriaClientDataset(strSQL);
  dtsPpaIte.DataSet := FcdsPpaIte;

  TFloatField(FcdsPpaIte.FieldByName('IPA_QTDLIM')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_QTDMIN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

  // VALORES DA PROMOÇÃO POR PRECO
  TFloatField(FcdsPpaIte.FieldByName('IPA_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSREA')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBRU')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLIQ')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVEN')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  // VALORES DA PROMOCAO POR PERCENTUAL
  TFloatField(FcdsPpaIte.FieldByName('IPA_PERDES')).DisplayFormat := fMskDigitos(FintPrecisaoDescontoItem);
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE1')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR1')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ1')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE1')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE2')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR2')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ2')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE2')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE3')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR3')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ3')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE3')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE4')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR4')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ4')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE4')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE5')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR5')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ5')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE5')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE6')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR6')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ6')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE6')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('IPA_CUSRE7')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARBR7')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_MARLQ7')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_PREVE7')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));

  // VALORES DO CADASTRO DE PRODUTOS
  TFloatField(FcdsPpaIte.FieldByName('ITE_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_CUSREA')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR1')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ1')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE1')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR2')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ2')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE2')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR3')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ3')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE3')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR4')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ4')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE4')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR5')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ5')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE5')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR6')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ6')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE6')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARBR7')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_MARLQ7')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREVE7')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREMED')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_PREULT')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('ITE_IMPULT')).DisplayFormat := '#,##0.00';

  // COMISSÃO
  TFloatField(FcdsPpaIte.FieldByName('IPA_COMVAR')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_COMATA')).DisplayFormat := '#,##0.00';
  TFloatField(FcdsPpaIte.FieldByName('IPA_COMDIS')).DisplayFormat := '#,##0.00';

  //SALDO
  TFloatField(FcdsPpaIte.FieldByName('ITE_SALFIS')).DisplayFormat := '#,##0.000';
  TFloatField(FcdsPpaIte.FieldByName('ITE_SALDIS')).DisplayFormat := '#,##0.000';

end;

procedure TfrmCadPromocoesAut.pGravarClientes(strAutInc: String;
  pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
  strPar: String;
  strVir: String;
  intCon: Integer;
  intTot: Integer;
  strSQL: String;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PPACLI WHERE CPA_SEQPPA = :SEQPPA');
    qryGen.ParamByName('SEQPPA').AsString := strAutInc;
    qryGen.ExecSQL;

    if FcdsPpaCli.IsEmpty then
      Exit;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO PPACLI (CPA_SEQPPA, CPA_CODCLI)');
    qryGen.SQL.Add('VALUES ');

    intTot := Pred(FcdsPpaCli.RecordCount);
    for intCon := 0 to intTot do
    Begin
      strPar := IntToStr(intCon);

      if (intCon = intTot) then
        strVir := ''
      else
        strVir := ',';

      strSQL := strSQL + '(:SEQGER' + strPar + ', :CODCLI' + strPar + ')' + strVir;
    End;

    qryGen.SQL.Add(strSQL);
    FcdsPpaCli.DisableControls;
    try
      FcdsPpaCli.First;
      while not FcdsPpaCli.Eof do
      Begin
        pStepStatusGravacao(pgbStatus);

        strPar := IntToStr(FcdsPpaCli.RecNo-1);

        qryGen.ParamByName('SEQGER'+strPar).AsString := strAutInc;
        qryGen.ParamByName('CODCLI'+strPar).AsString := FcdsPpaCli.FieldByName('CPA_CODCLI').AsString;

        FcdsPpaCli.Next;
      End;

      qryGen.ExecSQL;
    finally
      FcdsPpaCli.EnableControls;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadPromocoesAut.pGravarCondicoes(strAutInc: String;
  pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PPACND WHERE NPA_SEQPPA = :SEQPPA');
    qryGen.ParamByName('SEQPPA').AsString := strAutInc;
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO PPACND (NPA_SEQPPA, NPA_CODCND, NPA_JURREM)');
    qryGen.SQL.Add('VALUES (:SEQGER, :CODCND, :JURREM) ');

    FcdsPpaCnd.DisableControls;
    try
      FcdsPpaCnd.First;
      while not FcdsPpaCnd.Eof do
      Begin
        pStepStatusGravacao(pgbStatus);

        qryGen.Close;
        qryGen.ParamByName('SEQGER').AsString := strAutInc;
        qryGen.ParamByName('CODCND').AsString := FcdsPpaCnd.FieldByName('NPA_CODCND').AsString;
        qryGen.ParamByName('JURREM').AsString := FcdsPpaCnd.FieldByName('NPA_JURREM').AsString;
        qryGen.ExecSQL;

        FcdsPpaCnd.Next;
      End;
    finally
      FcdsPpaCnd.EnableControls;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadPromocoesAut.pGravarEmpresas(strAutInc: String; pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
  intContador: Integer;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PPAEMP WHERE EPA_SEQPPA = :SEQPPA');
    qryGen.ParamByName('SEQPPA').AsString := strAutInc;
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO PPAEMP (EPA_SEQPPA, EPA_CODEMP) VALUES (:SEQGER, :CODEMP) ');

    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If clbEmpresa.Checked[intContador] Then
      Begin
        qryGen.Close;
        qryGen.ParamByName('SEQGER').AsString := strAutInc;
        qryGen.ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador],3);
        qryGen.ExecSQL;
      End;
    End;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadPromocoesAut.pGravarItens(strAutInc: String;
  pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
  strPar: String;
  strVir: String;
  intCon: Integer;
  intTot: Integer;
  strSQL: String;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PPAITE WHERE IPA_SEQPPA = :SEQPPA');
    qryGen.ParamByName('SEQPPA').AsString := strAutInc;
    qryGen.ExecSQL;

    if FcdsPpaIte.IsEmpty then
      Exit;

    qryGen.SQL.Clear;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO PPAITE ( ';
    strSQL := strSQL + 'AUTOINCREM, ';
    strSQL := strSQL + 'IPA_SEQPPA, ';
    strSQL := strSQL + 'IPA_CODITE, ';
    strSQL := strSQL + 'IPA_PRECUS, ';
    strSQL := strSQL + 'IPA_PREVEN, ';
    strSQL := strSQL + 'IPA_COMVAR, ';
    strSQL := strSQL + 'IPA_PRZMED, ';
    strSQL := strSQL + 'IPA_CODEMP, ';
    strSQL := strSQL + 'IPA_COMATA, ';
    strSQL := strSQL + 'IPA_QTDLIM, ';
    strSQL := strSQL + 'IPA_QTDMIN, ';
    strSQL := strSQL + 'IPA_PERDES, ';
    strSQL := strSQL + 'IPA_COMDIS, ';
    strSQL := strSQL + 'IPA_PREVE2, ';
    strSQL := strSQL + 'IPA_PREVE3, ';
    strSQL := strSQL + 'IPA_PREVE4, ';
    strSQL := strSQL + 'IPA_PREVE5, ';
    strSQL := strSQL + 'IPA_PREVE6, ';
    strSQL := strSQL + 'IPA_PREVE7) ';
    strSQL := strSQL + 'VALUES ';

    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);

    strSQL := '';

    intTot := Pred(FcdsPpaIte.RecordCount);
    for intCon := 0 to intTot do
    Begin
      strPar := IntToStr(intCon);

      if (intCon = intTot) then
        strVir := ''
      else
        strVir := ',';

      strSQL := strSQL + '(';
      strSQL := strSQL + '  :AUTINC' + strPar;
      strSQL := strSQL + ', :SEQPPA' + strPar;
      strSQL := strSQL + ', :CODITE' + strPar;
      strSQL := strSQL + ', :PRECUS' + strPar;
      strSQL := strSQL + ', :PREVEN' + strPar;
      strSQL := strSQL + ', :COMVAR' + strPar;
      strSQL := strSQL + ', :PRZMED' + strPar;
      strSQL := strSQL + ', :CODEMP' + strPar;
      strSQL := strSQL + ', :COMATA' + strPar;
      strSQL := strSQL + ', :QTDLIM' + strPar;
      strSQL := strSQL + ', :QTDMIN' + strPar;
      strSQL := strSQL + ', :PERDES' + strPar;
      strSQL := strSQL + ', :COMDIS' + strPar;
      strSQL := strSQL + ', :PREVE2' + strPar;
      strSQL := strSQL + ', :PREVE3' + strPar;
      strSQL := strSQL + ', :PREVE4' + strPar;
      strSQL := strSQL + ', :PREVE5' + strPar;
      strSQL := strSQL + ', :PREVE6' + strPar;
      strSQL := strSQL + ', :PREVE7' + strPar;
      strSQL := strSQL + ')' + strVir;
    End;

    qryGen.SQL.Add(strSQL);
    FcdsPpaIte.DisableControls;
    try
      FcdsPpaIte.First;
      while not FcdsPpaIte.Eof do
      Begin
        pStepStatusGravacao(pgbStatus);

        strPar := IntToStr(FcdsPpaIte.RecNo-1);

        qryGen.ParamByName('AUTINC'+strPar).AsString := fRetAutoIncrem('PPAITE', VS_strCodEmp);
        qryGen.ParamByName('SEQPPA'+strPar).AsString := strAutInc;
        qryGen.ParamByName('CODITE'+strPar).AsString := FcdsPpaIte.FieldByName('IPA_CODITE').AsString;
        qryGen.ParamByName('PRECUS'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PRECUS').AsFloat;
        qryGen.ParamByName('PREVEN'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVEN').AsFloat;
        qryGen.ParamByName('COMVAR'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_COMVAR').AsFloat;
        qryGen.ParamByName('PRZMED'+strPar).AsInteger := FcdsPpaIte.FieldByName('IPA_PRZMED').AsInteger;
        qryGen.ParamByName('CODEMP'+strPar).AsString := VS_strCodEmp;
        qryGen.ParamByName('COMATA'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_COMATA').AsFloat;
        qryGen.ParamByName('QTDLIM'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_QTDLIM').AsFloat;
        qryGen.ParamByName('QTDMIN'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_QTDMIN').AsFloat;
        qryGen.ParamByName('PERDES'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PERDES').AsFloat;
        qryGen.ParamByName('COMDIS'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_COMDIS').AsFloat;
        qryGen.ParamByName('PREVE2'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE2').AsFloat;
        qryGen.ParamByName('PREVE3'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE3').AsFloat;
        qryGen.ParamByName('PREVE4'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE4').AsFloat;
        qryGen.ParamByName('PREVE5'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE5').AsFloat;
        qryGen.ParamByName('PREVE6'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE6').AsFloat;
        qryGen.ParamByName('PREVE7'+strPar).AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE7').AsFloat;

        FcdsPpaIte.Next;
      End;

      qryGen.ExecSQL;
    finally
      FcdsPpaIte.EnableControls;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadPromocoesAut.pGravarValidades(strAutInc: String;
  pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PPAVAL WHERE VPA_SEQPPA = :SEQPPA');
    qryGen.ParamByName('SEQPPA').AsString := strAutInc;
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO PPAVAL (AUTOINCREM, VPA_SEQPPA, VPA_DESVPA, VPA_DTAINI, VPA_DTAFIN, VPA_CODPRO)');
    qryGen.SQL.Add('VALUES (:AUTINC, :SEQGER, :DESVPA, :DTAINI, :DTAFIN, :CODPRO) ');

    FcdsPpaVal.DisableControls;
    try
      FcdsPpaVal.First;
      while not FcdsPpaVal.Eof do
      Begin
        pStepStatusGravacao(pgbStatus);

        qryGen.Close;
        qryGen.ParamByName('AUTINC').AsString   := fRetAutoIncrem('PPAVAL', VS_strCodEmp);
        qryGen.ParamByName('SEQGER').AsString   := strAutInc;
        qryGen.ParamByName('DESVPA').AsString   := FcdsPpaVal.FieldByName('VPA_DESVPA').AsString;
        qryGen.ParamByName('DTAINI').AsDateTime := FcdsPpaVal.FieldByName('VPA_DTAINI').AsDateTime;
        qryGen.ParamByName('DTAFIN').AsDateTime := FcdsPpaVal.FieldByName('VPA_DTAFIN').AsDateTime;
        qryGen.ParamByName('CODPRO').AsString   := FcdsPpaVal.FieldByName('VPA_CODPRO').AsString;

        qryGen.ExecSQL;

        FcdsPpaVal.Next;
      End;
    finally
      FcdsPpaVal.EnableControls;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TfrmCadPromocoesAut.fValidaCndPag: Boolean;
begin
  Result := False;

  if (Not fValidaCampos(edtCodCnd, True)) then
    Exit;
  if (Not fValidaCampos(edtJurRem, True)) then
    Exit;

  Result := True;
end;

procedure TfrmCadPromocoesAut.pInsereCliente;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fInsereCliente;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);
End;

function TfrmCadPromocoesAut.fInsereCliente(pgbStatus: TcxProgressBar): Boolean;
Var
  qryGen : TUniQuery;
  strSQL : String;
  prcScroll: TprcScroll;
  strLinha: String;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando clientes...');

  Result := False;

  qryGen := fCriaQuery;

  pDisableControls(FcdsPpaCli, prcScroll);


  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  CONCAT(CID_NOMCID," - ",CID_ESTADO) AS CIDEST, ';
  strSQL := strSQL + '  ATI_DESATI AS ATIVID, ';
  strSQL := strSQL + '  CLI_C_G_C_ AS CGCCPF, ';
  strSQL := strSQL + '  CLI_CATEGO AS CATEGO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCLI, ';
  strSQL := strSQL + '  CADCID, ';
  strSQL := strSQL + '  CADATI  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CLI_CODATI = ATI_CODATI AND ';
  strSQL := strSQL + '  CLI_CODCID = CID_CODCID ';
  strSQL := strSQL + fStrLocate(edtCodCli, FarrClientes, 'CLI_CODCLI', 'CODCLI');
  strSQL := strSQL + fStrLocate(edtCodAti, FarrAtiv    , 'CLI_CODATI', 'CODATI');
  strSQL := strSQL + fStrLocate(edtCodCid, FarrCidade  , 'CLI_CODCID', 'CODCID');
  strSQL := strSQL + fAddParametro(edtEstado.Text,    '  AND CID_ESTADO = :ESTADO ');
  strSQL := strSQL + fAddParametro(edtNuCnpj.Text,    '  AND CLI_C_G_C_ = :CGCCPF ');
  strSQL := strSQL + fAddParametro(cbxCategoria.Text, '  AND CLI_CATEGO = :CATEGO ');
  strSQL := strSQL + 'ORDER BY CLI_CODCLI ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);

  pSetaParam(edtCodCli.Text, FarrClientes, strLinha, 'CODCLI', qryGen);
  pSetaParam(edtCodAti.Text, FarrAtiv    , strLinha, 'CODATI', qryGen);
  pSetaParam(edtCodCid.Text, FarrCidade  , strLinha, 'CODCID', qryGen);
  pSetParametro(qryGen, 'ESTADO', edtEstado.Text);
  pSetParametro(qryGen, 'CGCCPF', fTiraCaracEspeciais(edtNuCnpj.Text));
  pSetParametro(qryGen, 'CATEGO', cbxCategoria.Text);

  qryGen.Open;

  If qryGen.RecordCount = 0 Then
  Begin
    fMensagem('','Nenhum Cliente foi encontrado!',['&O K'],0);
  End
  Else
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Cliente...', qryGen.RecordCount);

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      If chkPromocaoRestritaClientesNaoConsumidor.Checked And
         fClienteConsumidor(qryGen.FieldByName('NOMCLI').AsString, True, True) Then
      Begin
        qryGen.Next;
        Continue;
      End;

      {***************************}
      {* INCLUI OU ALTERA O ITEM *}
      {************************JB*}
      If Not FcdsPpaCli.Locate('CPA_CODCLI', qryGen.FieldByName('CODCLI').AsString, []) Then
      Begin
        FcdsPpaCli.Insert;
        FcdsPpaCli.FieldByName('CPA_CODCLI').AsString := qryGen.FieldByName('CODCLI').AsString;
        FcdsPpaCli.FieldByName('PRO_NOMCLI').AsString := qryGen.FieldByName('NOMCLI').AsString;
        FcdsPpaCli.FieldByName('PRO_ATIVID').AsString := qryGen.FieldByName('ATIVID').AsString;
        FcdsPpaCli.FieldByName('PRO_CIDEST').AsString := qryGen.FieldByName('CIDEST').AsString;
        FcdsPpaCli.FieldByName('PRO_CGCCPF').AsString := qryGen.FieldByName('CGCCPF').AsString;
        FcdsPpaCli.FieldByName('PRO_CATEGO').AsString := qryGen.FieldByName('CATEGO').AsString;
        FcdsPpaCli.Post;
      End;

      qryGen.Next;

    End;

    Result := True;

  End;

  pEnableControls(FcdsPpaCli, prcScroll);

  cxgClientes.Enabled := True;
  cxgClientes.Refresh;
  btnCancelCli.Click;
  FreeAndNil(qryGen);
end;

procedure TfrmCadPromocoesAut.pAdicionaItem;
Begin
  Try
    FblnUsaComissaoCadastroProduto := False;
    If (fStrToFloat(edtComVar.Text) <= 0) Or
       (fStrToFloat(edtComAta.Text) <= 0) Or
       (fStrToFloat(edtComDis.Text) <= 0) Then
    Begin
      FblnUsaComissaoCadastroProduto := (fMensagem('', 'Existem percentuais de comissão não informados. Deseja utilizar os percentuais de comissão do cadastro de produtos?', ['&Sim', '&Não']) = 1);
    End;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAdicionaItem;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);
End;

procedure TfrmCadPromocoesAut.pLimpaPainel(pnlLimpar: TPanel);
Var
  intContador : Integer;
begin
  For intContador := 0 To pnlLimpar.ControlCount - 1 Do
  Begin
    if pnlLimpar.Controls[intContador] is TPanel then
      pLimpaPainel(TPanel(pnlLimpar.Controls[intContador]))
    else
    If pnlLimpar.Controls[intContador] is TMaskEdit Then
      TMaskEdit(pnlLimpar.Controls[intContador]).Clear
    else
    If pnlLimpar.Controls[intContador] is TEditFocus Then
      TEditFocus(pnlLimpar.Controls[intContador]).Clear;
  End;
end;

procedure TfrmCadPromocoesAut.pLimpaDadosItem;
begin
  If pnlDadosItem.Enabled Then
    pLimpaPainel(pnlInformacoesItens);

  FarrGrupos := nil;
  FarrProdutos := nil;
  FarrMarca := nil;
  FarrFornec := nil;
  FarrUnidades := nil;

  pSetFocus(mskLinhaGrupo);

  FblnAltGrd := False;
  btnConfirmar.Tag := 0;
  edtCodIte.Enabled := True;
  edtCodIte.Clear;
  pLimpaInputsDadosItem;
end;

function TfrmCadPromocoesAut.fSqlDefault : String;
var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '  (ITEGER.ITE_SALDOS + ITEGER.ITE_QTEF_A + ITEGER.ITE_QTEF_F + ITEGER.ITE_QTEF_P + ITEGER.ITE_QTPDBF) AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL + '  ITEGER.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR1 AS MARBR1, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE1 AS PREVE1, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR2 AS MARBR2, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE2 AS PREVE2, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR3 AS MARBR3, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE3 AS PREVE3, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR4 AS MARBR4, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE4 AS PREVE4, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR5 AS MARBR5, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE5 AS PREVE5, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR6 AS MARBR6, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE6 AS PREVE6, ';
  strSQL := strSQL + '  ITEGER.ITE_MARBR7 AS MARBR7, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE7 AS PREVE7, ';
  strSQL := strSQL + '  ITEGER.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '  ITEGER.ITE_PREULT AS PREULT, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPULT AS IMPULT, ';
  strSQL := strSQL + '  ITEGER.ITE_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '  ITEGER.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '  ITEGER.ITE_DESOPE AS DESOPE, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB1 AS COMTB1, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB2 AS COMTB2, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB3 AS COMTB3, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB4 AS COMTB4, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB5 AS COMTB5, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB6 AS COMTB6, ';
  strSQL := strSQL + '  ITEGER.ITE_COMTB7 AS COMTB7, ';
  strSQL := strSQL + '  ITEGER.ITE_COMVAR AS COMVAR, ';
  strSQL := strSQL + '  ITEGER.ITE_COMATA AS COMATA, ';
  strSQL := strSQL + '  ITEGER.ITE_COMDIS AS COMDIS, ';

  strSQL := strSQL + '  ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM AS PRECOM, ';
  strSQL := strSQL + '  ITE_DESF01 AS DESF01, ';
  strSQL := strSQL + '  ITE_DESF02 AS DESF02, ';
  strSQL := strSQL + '  ITE_DESF03 AS DESF03, ';
  strSQL := strSQL + '  ITE_DESF04 AS DESF04, ';
  strSQL := strSQL + '  ITE_DESF05 AS DESF05, ';
  strSQL := strSQL + '  ITE_DESF06 AS DESF06, ';
  strSQL := strSQL + '  ITE_PREDOL AS PREDOL, ';

  If (fCfgSis('TIPABF') = '1') Then
    strSQL := strSQL + ' CADITE.ITE_CODABF AS CODABF '
  Else
    strSQL := strSQL + ' ITEGER.ITE_CODABF AS CODABF ';

  strSQL := strSQL + '  FROM CADITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '                  AND ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL + ' INNER JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
  strSQL := strSQL + ' INNER JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + ' WHERE CADITE.ITE_ITEATI = "S" ';

  if FblnAltGrd then
    strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE  '
  else
  begin
    strSQL := strSQL + fStrLocate(edtCodIte, FarrProdutos  , 'CADITE.ITE_CODITE', 'CODITE');
    strSQL := strSQL + fStrLocate(mskLinhaGrupo, FarrGrupos  , 'ITE_CODGRU', 'CODGRU');
    strSQL := strSQL + fStrLocate(edtFornecedor, FarrFornec  , 'ITE_CODFOR', 'CODFOR');
    strSQL := strSQL + fStrLocate(edtMarca, FarrMarca  , 'ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtUnidade, FarrUnidades  , 'ITE_CODUNI', 'CODUNI');

    If (Not fEmptyStr(edtDescriIni.Text)) and (Not fEmptyStr(edtDescriFin.Text)) Then
      strSQL := strSQL + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

    strSQL := strSQL + fAddParametro(edtRefere.Text, '  AND ITE_REFERE = :REFERE ');

    strSQL := strSQL + ' ORDER BY CADITE.ITE_DESITE ';
  end;

  Result := strSQL;
End;

procedure TfrmCadPromocoesAut.pSetParametro(qrySelect: TUniQuery; strParametro, strValor: String);
begin
  If (Not fEmptyStr(strValor)) Then
    qrySelect.ParamByName(strParametro).AsString := strValor;
end;

function TfrmCadPromocoesAut.fAddParametro(strValor, strSQL: String): String;
begin
  Result := '';
  If (Not fEmptyStr(strValor)) Then
    Result := strSQL;
end;

procedure TfrmCadPromocoesAut.pMontaParametros(qryGen: TUniQuery);
var
  strLinha: String;
begin
  if FblnAltGrd then
    pSetParametro(qryGen, 'CODITE', edtCodIte.Text)
  else
  begin
    pSetaParam(edtCodIte.Text    , FarrProdutos, strLinha, 'CODITE', qryGen);
    pSetaParam(mskLinhaGrupo.Text, FarrGrupos  , strLinha, 'CODGRU', qryGen);
    pSetaParam(edtFornecedor.Text, FarrFornec  , strLinha, 'CODFOR', qryGen);
    pSetaParam(edtMarca.Text     , FarrMarca   , strLinha, 'CODMAR', qryGen);
    pSetaParam(edtUnidade.Text   , FarrUnidades, strLinha, 'CODUNI', qryGen);

    If (Not fEmptyStr(edtDescriIni.Text)) and (Not fEmptyStr(edtDescriFin.Text)) Then
    Begin
      qryGen.ParamByName('MAIOR').AsString := edtDescriIni.Text;
      qryGen.ParamByName('DESITE').AsString := edtDescriIni.Text;
      qryGen.ParamByName('DESITE1').AsString := edtDescriFin.Text;
    End
    Else
    Begin
      If Not fEmptyStr(edtDescriIni.Text) Then
        qryGen.ParamByName('DESITE').AsString := edtDescriIni.Text + '%';
    End;

    pSetParametro(qryGen, 'REFERE', edtRefere.Text);
  end;
end;

function TfrmCadPromocoesAut.fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
Var
  recIteEst: TItemEstru;
  qryGen   : TUniQuery;
  strMsgProJaInc: String;   //ARMAZENA OS ITENS JÁ INCLUSOS NESTA PROMOÇÃO
  strMsgProIncOu: String;   //ARMAZENA OS ITENS JÁ INCLUSOS OUTRA PROMOÇÃO
  strMsgProSemEstoque: String;
  strMsgItemEstr01: String;
  strMsgItemEstr02: String;
  prcScroll: TprcScroll;
  cfgSUGVLE: Integer;
  cfgCAREST: String;
  cfgRATEST: Boolean;
begin
  Result := False;
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...');

  qryGen   := fCriaQuery;

  pDisableControls(FcdsPpaIte, prcScroll);

  qryGen.Close;
  qryGen.SQL.Clear;

  qryGen.SQL.Add(fSqlDefault);

  pMontaParametros(qryGen);

  qryGen.Open;

  If qryGen.RecordCount = 0 Then
    fMensagem('','Nenhum Produto foi encontrado para essas condições!',['&OK'], 0)
  Else
  Begin

    strMsgProJaInc      := '';
    strMsgProIncOu      := '';
    strMsgItemEstr01    := '';
    strMsgItemEstr02    := '';
    strMsgProSemEstoque := '';

    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...', qryGen.RecordCount);

    cfgSUGVLE := fCfgSis('SUGVLE', varInteger);
    cfgCAREST := fCfgSis('CAREST', varString);
    cfgRATEST := fCfgSis('RATEST', varString) = 'S';

    While Not qryGen.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      recIteEst := fEhOuCompoeEstrutura(qryGen.FieldByName('CODITE').AsString);

      //SUGVLE - SUSGESTÃO DO PREÇO DE VENDA: [1=DO ITEM PRINCIPAL] [2=SOMANDO ITENS ESTRUTURA]
      //CAREST - PERGUNTA SE CARREGA ESTRUTURA: ['S'=PERGUNTA] ['N'=SEMPRE CARREGA ITEM PRINCIPAL] ['P'=SEMPRE CARREGA ITENS ESTRUTURA]
      //RATEST - RATEIA O VALOR DA VENDA ENTRE OS ITENS ESTRUTURA;

      //COMEÇA A VERIFICAR AS EXCESSÕES
      If (recIteEst.blnEstrutura) And (recIteEst.blnPrincipal) And
         (cfgSUGVLE = 1) And (CharInSet(cfgCAREST[1], ['P'])) And (Not cfgRATEST) Then
      Begin
        //DEVERIA CADASTRAR OS SUB-PRODUTOS, MAS ESTÁ TENTANDO CADASTRAR ITEM PRINCIPAL
        strMsgItemEstr01 := strMsgItemEstr01 + IIF(fEmptyStr(strMsgItemEstr01),'',', ') + qryGen.FieldByName('CODITE').AsString;
      End

      Else If (recIteEst.blnEstrutura) And (recIteEst.blnPrincipal) And
              (cfgSUGVLE = 2) Then
      Begin
        //DEVERIA CADASTRAR OS SUB-PRODUTOS, MAS ESTÁ TENTANDO CADASTRAR ITEM PRINCIPAL
        strMsgItemEstr02 := strMsgItemEstr02 + IIF(fEmptyStr(strMsgItemEstr02),'',', ') + qryGen.FieldByName('CODITE').AsString;
      End

      //SE JÁ NESTA PROMOÇÃO, PULA
      Else If (not FblnAltGrd) And (fItemJaCadastrado(qryGen.fieldbyname('CODITE').AsString)) Then
      Begin
        strMsgProJaInc := strMsgProJaInc + qryGen.fieldbyname('CODITE').AsString + '  -  ' + qryGen.fieldbyname('DESITE').AsString + #13#10;
      End

      Else
      Begin
        {***************************}
        {* INCLUI OU ALTERA O ITEM *}
        {************************JB*}

        pIncluiAlteraItem(qryGen);
      End;
      qryGen.Next;
    End;

    Result := True;
  End;


  pMostraObservacoes(strMsgProJaInc, strMsgProIncOu, strMsgItemEstr01, strMsgItemEstr02, strMsgProSemEstoque);

  pEnableControls(FcdsPpaIte, prcScroll);

  cxgItens.Refresh;
  pLimpaDadosItem;
  FreeAndNil(qryGen);
end;

procedure TfrmCadPromocoesAut.pLimpaInputsDadosItem;
begin
  edtComVar.Text := '0,00';
  edtComAta.Text := '0,00';
  edtComDis.Text := '0,00';
  edtPrzMed.Text := '0';
  edtUnidade.Text := '';
  edtPerDes.Text := '0,00';
  edtQtdLim.Text := '';
  edtQtdMin.Text := '';
end;

procedure TfrmCadPromocoesAut.pCarregaItemAlteracao;
begin
  btnConfirmar.Tag := 1;

  edtCodIte.Text := FcdsPpaIte.FieldByName('IPA_CODITE').AsString;
  pCarregaCadIte(True);

  edtDesIte.Text := FcdsPpaIte.FieldByName('ITE_DESITE').AsString;
  edtQtdLim.Text := FcdsPpaIte.FieldByName('IPA_QTDLIM').AsString;
  edtQtdMin.Text := FcdsPpaIte.FieldByName('IPA_QTDMIN').AsString;
  edtPerDes.Text := FloatToStrF(FcdsPpaIte.FieldByName('IPA_PERDES').AsFloat, ffFixed, 12, FintPrecisaoDescontoItem);
  edtComVar.Text := FloatToStrF(FcdsPpaIte.FieldByName('IPA_COMVAR').AsFloat, ffFixed, 12, 2);
  edtComAta.Text := FloatToStrF(FcdsPpaIte.FieldByName('IPA_COMATA').AsFloat, ffFixed, 12, 2);
  edtComDis.Text := FloatToStrF(FcdsPpaIte.FieldByName('IPA_COMDIS').AsFloat, ffFixed, 12, 2);
  edtPrzMed.Text := IntToStr(FcdsPpaIte.FieldByName('IPA_PRZMED').AsInteger);

  pSetEnabledComissao;

  SelectNext(edtCodIte, True, True);
  edtCodIte.Enabled := False;
end;

function TfrmCadPromocoesAut.fItemJaCadastrado(strCodIte: String): Boolean;
  Var
    prcScroll: TprcScroll;
begin
  Try

    pDisableControls(FcdsPpaIte, prcScroll);

    Result := FcdsPpaIte.Locate('IPA_CODITE', strCodIte, []);

  Finally
    pEnableControls(FcdsPpaIte, prcScroll);
  End;

end;

function TfrmCadPromocoesAut.fMargemBruta(strCampoCusto, strCampoVenda: String): Double;
Begin
  Result := fCalculaPrecoVenda(2,
                               FcdsPpaIte.FieldByName(strCampoCusto).AsFloat,
                               FcdsPpaIte.FieldByName(strCampoVenda).AsFloat,
                               0, 0, 0, 0, 0);
End;

function TfrmCadPromocoesAut.fMargemLiquida(strCampoCusto, strCampoVenda, strCampoComissao: String): Double;
  Var
    fltIcmsST : Double;
    blnCalcSt : Boolean;
    strCodAbf : String;
Begin
  if (FcdsPpaIte.FindField('CODABF') <> Nil) then
    strCodAbf := FcdsPpaIte.FieldByName('CODABF').AsString
  else
    strCodAbf := FcdsPpaIte.FieldByName('ITE_CODABF').AsString;

  fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                    strCodAbf,
                                    fPreComLiq(FcdsPpaIte, 0),
                                    FcdsPpaIte.FieldByName('ITE_IPIENT').AsFloat,
                                    FcdsPpaIte.FieldByName('ITE_ICMSAI').AsFloat);

  Result := fCalculaPrecoVenda(2,
                               FcdsPpaIte.FieldByName(strCampoCusto).AsFloat + FcdsPpaIte.FieldByName('ITE_OUTVAL').AsFloat,
                               FcdsPpaIte.FieldByName(strCampoVenda).AsFloat,
                               0,
                               FcdsPpaIte.FieldByName('ITE_ICMSAI').AsFloat,
                               FcdsPpaIte.FieldByName('ITE_IMPFED').AsFloat,
                               FcdsPpaIte.FieldByName('ITE_DESOPE').AsFloat,
                               FcdsPpaIte.FieldByName(strCampoComissao).AsFloat,
                               '',
                               '',
                               -1,
                               fltIcmsST,
                               blnCalcSt);
End;

function TfrmCadPromocoesAut.fCustoReal(strCampoCusto, strCampoVenda: String): Double;
Begin
  If fEmptyStr(strCampoVenda) Then
    Result := fCalculaCustoReal(FcdsPpaIte.FieldByName(strCampoCusto).AsFloat,
                                FcdsPpaIte.FieldByName('ITE_ICMSAI').AsFloat,
                                FcdsPpaIte.FieldByName('ITE_IMPFED').AsFloat,
                                FcdsPpaIte.FieldByName('ITE_DESOPE').AsFloat,
                                FcdsPpaIte.FieldByName('ITE_OUTVAL').AsFloat)
  Else
    Result := fCalculaPrecoCustoRealVenda(FcdsPpaIte.FieldByName(strCampoVenda).AsFloat,
                                          FcdsPpaIte.FieldByName(strCampoCusto).AsFloat,
                                          FcdsPpaIte.FieldByName('ITE_OUTVAL').AsFloat,
                                          FcdsPpaIte.FieldByName('ITE_ICMSAI').AsFloat,
                                          FcdsPpaIte.FieldByName('ITE_IMPFED').AsFloat,
                                          FcdsPpaIte.FieldByName('ITE_DESOPE').AsFloat,
                                          0,
                                          0);
End;

procedure TfrmCadPromocoesAut.pCalculaCustoEMargem;
begin
  If FcdsPpaIte.FieldByName('IPA_PRECUS').AsFloat <> 0 Then
  Begin
    FcdsPpaIte.FieldByName('IPA_CUSRE1').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE1');
    FcdsPpaIte.FieldByName('IPA_MARBR1').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE1');
    FcdsPpaIte.FieldByName('IPA_MARLQ1').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE1', 'ITE_COMTB1');
    FcdsPpaIte.FieldByName('IPA_CUSRE2').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE2');
    FcdsPpaIte.FieldByName('IPA_MARBR2').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE2');
    FcdsPpaIte.FieldByName('IPA_MARLQ2').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE2', 'ITE_COMTB2');
    FcdsPpaIte.FieldByName('IPA_CUSRE3').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE3');
    FcdsPpaIte.FieldByName('IPA_MARBR3').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE3');
    FcdsPpaIte.FieldByName('IPA_MARLQ3').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE3', 'ITE_COMTB3');
    FcdsPpaIte.FieldByName('IPA_CUSRE4').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE4');
    FcdsPpaIte.FieldByName('IPA_MARBR4').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE4');
    FcdsPpaIte.FieldByName('IPA_MARLQ4').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE4', 'ITE_COMTB4');
    FcdsPpaIte.FieldByName('IPA_CUSRE5').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE5');
    FcdsPpaIte.FieldByName('IPA_MARBR5').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE5');
    FcdsPpaIte.FieldByName('IPA_MARLQ5').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE5', 'ITE_COMTB5');
    FcdsPpaIte.FieldByName('IPA_CUSRE6').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE6');
    FcdsPpaIte.FieldByName('IPA_MARBR6').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE6');
    FcdsPpaIte.FieldByName('IPA_MARLQ6').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE6', 'ITE_COMTB6');
    FcdsPpaIte.FieldByName('IPA_CUSRE7').AsFloat := fCustoReal('IPA_PRECUS', 'IPA_PREVE7');
    FcdsPpaIte.FieldByName('IPA_MARBR7').AsFloat := fMargemBruta('IPA_PRECUS', 'IPA_PREVE7');
    FcdsPpaIte.FieldByName('IPA_MARLQ7').AsFloat := fMargemLiquida('IPA_PRECUS', 'IPA_PREVE7', 'ITE_COMTB7');
  End
  Else
  Begin
    FcdsPpaIte.FieldByName('IPA_CUSRE1').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE1');
    FcdsPpaIte.FieldByName('IPA_MARBR1').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE1');
    FcdsPpaIte.FieldByName('IPA_MARLQ1').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE1', 'ITE_COMTB1');
    FcdsPpaIte.FieldByName('IPA_CUSRE2').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE2');
    FcdsPpaIte.FieldByName('IPA_MARBR2').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE2');
    FcdsPpaIte.FieldByName('IPA_MARLQ2').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE2', 'ITE_COMTB2');
    FcdsPpaIte.FieldByName('IPA_CUSRE3').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE3');
    FcdsPpaIte.FieldByName('IPA_MARBR3').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE3');
    FcdsPpaIte.FieldByName('IPA_MARLQ3').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE3', 'ITE_COMTB3');
    FcdsPpaIte.FieldByName('IPA_CUSRE4').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE4');
    FcdsPpaIte.FieldByName('IPA_MARBR4').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE4');
    FcdsPpaIte.FieldByName('IPA_MARLQ4').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE4', 'ITE_COMTB4');
    FcdsPpaIte.FieldByName('IPA_CUSRE5').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE5');
    FcdsPpaIte.FieldByName('IPA_MARBR5').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE5');
    FcdsPpaIte.FieldByName('IPA_MARLQ5').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE5', 'ITE_COMTB5');
    FcdsPpaIte.FieldByName('IPA_CUSRE6').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE6');
    FcdsPpaIte.FieldByName('IPA_MARBR6').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE6');
    FcdsPpaIte.FieldByName('IPA_MARLQ6').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE6', 'ITE_COMTB6');
    FcdsPpaIte.FieldByName('IPA_CUSRE7').AsFloat := fCustoReal('ITE_PRECUS', 'IPA_PREVE7');
    FcdsPpaIte.FieldByName('IPA_MARBR7').AsFloat := fMargemBruta('ITE_PRECUS', 'IPA_PREVE7');
    FcdsPpaIte.FieldByName('IPA_MARLQ7').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPA_PREVE7', 'ITE_COMTB7');
  End;

end;

function TfrmCadPromocoesAut.fPreComLiq(DataSet: TDataSet; fltDesF07: Double): Double;
begin
  Result := untfuncoesSimples.fCalculaPrecoCompraLiq(DataSet.FieldByName('ITE_PRECOM').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF01').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF02').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF03').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF04').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF05').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF06').AsFloat,
                                                     FintDecUni,
                                                     (DataSet.FieldByName('ITE_PREDOL').AsString = 'S'),
                                                     fltDesF07);
end;

function TfrmCadPromocoesAut.fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
  Var
    strCodSit : String;
    strEstEmp : String;
begin
  Result := 0.00;
  blnST := False;
  strEstEmp := fCadEmp('ESTADO');
  If (fCfgSis('MARMKP',varString) = '4') And (Not fEmptyStr(strCodAbf)) Then
  Begin
    strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [strCodAbf, strEstEmp], False);
    Result := untIcmsSTParteVenda.fGetIcmsSTParteVenda(strCodAbf, '_SAI_CCO', strCodSit, strEstEmp, fltPreComLiq, fltIpiEnt, fltImcSai, strEstEmp, blnST, fCfgSis('MARMKP',varString));
  End;
end;

function TfrmCadPromocoesAut.fValidaLimiteMinima(edtLim,
  edtMin: TCustomEdit; Sender: TObject): Boolean;
begin
  Result := True;

  If (Sender = edtLim) Then
  Begin
    If (fEmptyStr(edtLim.Text)) Then
      edtLim.Text := '0,00';

    If (fStrToFloat(edtLim.Text) < 0) Then
      Result := False;
  End
  Else If (Sender = edtMin) Then
  Begin
    If (fEmptyStr(edtMin.Text)) Then
      edtMin.Text := '0,00';

    If (fStrToFloat(edtMin.Text) < 0) Then
      Result := False
    Else If (fStrToFloat(edtMin.Text) = 0) And (fStrToFloat(edtLim.Text) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a quantidade (limite e/ou mínima) da promoção!', ['&OK']);
      Result := False;
    End;
  End;

  If (fStrToFloat(edtLim.Text) > 0) And (fStrToFloat(edtMin.Text) > 0) And
     (fStrToFloat(edtMin.Text) > fStrToFloat(edtLim.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A quantidade mínima deve ser menor ou igual a quantidade limite!', ['&OK']);
    Result := False;
  End;
End;

procedure TfrmCadPromocoesAut.pZeraComissao;
begin
  FcdsPpaIte.DisableControls;
  FcdsPpaIte.First;
  While not FcdsPpaIte.eof do
  begin
    FcdsPpaIte.Edit;
    FcdsPpaIte.FieldByName('IPA_COMVAR').AsFloat := 0;
    FcdsPpaIte.FieldByName('IPA_COMATA').AsFloat := 0;
    FcdsPpaIte.FieldByName('IPA_COMDIS').AsFloat := 0;
    FcdsPpaIte.Post;

    FcdsPpaIte.Next;
  end;
  FcdsPpaIte.EnableControls;
end;

procedure TfrmCadPromocoesAut.pMostraObservacoes(strMsgProJaInc,
  strMsgProIncOu, strMsgItemEstr01, strMsgItemEstr02, strMsgProSemEstoque: String);
var
  intObs: Integer;
begin
  If (fEmptyStr(strMsgProJaInc + strMsgProIncOu + strMsgItemEstr01 + strMsgItemEstr02 + strMsgProSemEstoque)) Then
    Exit;

  intObs := 0;

  pCriarFormularios(TfrmObservacao, frmObservacao);
  try
    try
      frmObservacao.lblMensagem.Caption := 'O(s) item(s) abaixo possuem as seguintes observações:';

      If Not fEmptyStr(strMsgProIncOu) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+'Produtos que estão vigentes em outras promoções: ' + #13#10 + strMsgProIncOu + #13#10);
      End;

      If Not fEmptyStr(strMsgProJaInc) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+'Produtos que estão vigente nesta promoção: ' + #13#10 + strMsgProJaInc + #13#10);
      End;

      If Not fEmptyStr(strMsgProSemEstoque) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+'Produtos sem quantidade limite para promoção: ' + #13#10 + strMsgProSemEstoque + #13#10);
      End;

      If Not fEmptyStr(strMsgItemEstr01) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+
               'Quando o sistema está configurado para sugerir o preço de venda do produto principal da estrutura '+
               '(CFG_SUGVLE-'+fRetNomCfg('SUGVLE')+'), no faturamento é carregado os sub-produtos (CFG_CAREST-'+fRetNomCfg('CAREST')+') e o sistema está configurado '+
               'para não ratear o valor sugerido entre os itens (CFG_RATEST-'+fRetNomCfg('RATEST')+'), não é permitido inserir na promoção o item estrutura. Cadastre a promoção para os sub-produtos.'+#13#10+
               'Itens Estrutura: '+strMsgItemEstr01+#13#10+#13#10+'Você pode consultar a estrutura completa no botão específico nesta tela.');
      End;

      If Not fEmptyStr(strMsgItemEstr02) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+
               'Quando o sistema está configurado para sugerir o preço de venda dos sub-produtos (CFG_SUGVLE-'+fRetNomCfg('SUGVLE')+') '+
               'e no faturamento é carregado o item estrutura (CFG_CAREST-'+fRetNomCfg('CAREST')+'), não é permitido inserir na promoção o item estrutura. Cadastre a promoção para os sub-produtos.'+#13#10+
               'Itens Estrutura: '+strMsgItemEstr02+#13#10+#13#10+'Você pode consultar a estrutura completa no botão específico nesta tela.');
      End;

      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadPromocoes.pAdicionaItem]');
      End;
    End;
  finally
    pFreeAndNil(frmObservacao);
  end;
end;

procedure TfrmCadPromocoesAut.pIncluiAlteraItem(qryGen: TUniQuery);
var
  intCnt : Integer;
begin
  If (btnConfirmar.Tag > 0) Then
    FcdsPpaIte.Edit
  Else
    FcdsPpaIte.Insert;

  FcdsPpaIte.FieldByName('IPA_CODITE').AsString  := qryGen.fieldbyname('CODITE').AsString;
  FcdsPpaIte.FieldByName('ITE_CODFAB').AsString  := qryGen.fieldbyname('CODFAB').AsString;
  FcdsPpaIte.FieldByName('ITE_DESITE').AsString  := qryGen.fieldbyname('DESITE').AsString;
  FcdsPpaIte.FieldByName('UNI_SIGUNI').AsString  := qryGen.fieldbyname('UNIDAD').AsString;
  FcdsPpaIte.FieldByName('MAR_DESMAR').AsString  := qryGen.fieldbyname('DESMAR').AsString;

  FcdsPpaIte.FieldByName('ITE_SALFIS').AsString  := qryGen.fieldbyname('ITE_SALFIS').AsString;
  FcdsPpaIte.FieldByName('ITE_SALDIS').AsString  := qryGen.fieldbyname('ITE_SALDIS').AsString;

  FcdsPpaIte.FieldByName('IPA_QTDMIN').AsFloat   := fStrToFloat(edtQtdMin.Text);
  FcdsPpaIte.FieldByName('IPA_QTDLIM').AsFloat   := fStrToFloat(edtQtdLim.Text);

  If FblnUsaComissaoCadastroProduto And (fStrToFloat(edtComVar.Text) <= 0) Then
    FcdsPpaIte.FieldByName('IPA_COMVAR').AsFloat := qryGen.fieldbyname('COMVAR').AsFloat
  Else
    FcdsPpaIte.FieldByName('IPA_COMVAR').AsFloat := fStrToFloat(edtComVar.Text);

  If FblnUsaComissaoCadastroProduto And (fStrToFloat(edtComAta.Text) <= 0) Then
    FcdsPpaIte.FieldByName('IPA_COMATA').AsFloat := qryGen.fieldbyname('COMATA').AsFloat
  Else
    FcdsPpaIte.FieldByName('IPA_COMATA').AsFloat := fStrToFloat(edtComAta.Text);

  If FblnUsaComissaoCadastroProduto And (fStrToFloat(edtComDis.Text) <= 0) Then
    FcdsPpaIte.FieldByName('IPA_COMDIS').AsFloat := qryGen.fieldbyname('COMDIS').AsFloat
  Else
    FcdsPpaIte.FieldByName('IPA_COMDIS').AsFloat := fStrToFloat(edtComDis.Text);

  FcdsPpaIte.FieldByName('IPA_PRZMED').AsInteger := StrToIntDef(edtPrzMed.Text,0);

  FcdsPpaIte.FieldByName('IPA_PRECUS').AsFloat := 0;
  FcdsPpaIte.FieldByName('IPA_PERDES').AsFloat := fStrToFloat(edtPerDes.Text);
  For intCnt := 1 To 7 Do
    FcdsPpaIte.FieldByName('IPA_PREVE' + IntToStr(intCnt)).AsFloat := qryGen.fieldbyname('PREVE' + IntToStr(intCnt)).AsFloat *
                                                           (1 - (FcdsPpaIte.FieldByName('IPA_PERDES').AsFloat / 100));
  FcdsPpaIte.FieldByName('IPA_PREVEN').AsFloat := FcdsPpaIte.FieldByName('IPA_PREVE1').AsFloat;

  FcdsPpaIte.FieldByName('ITE_PRECUS').AsFloat   := qryGen.fieldbyname('PRECUS').AsFloat;
  FcdsPpaIte.FieldByName('ITE_OUTVAL').AsFloat   := qryGen.fieldbyname('OUTVAL').AsFloat;
  FcdsPpaIte.FieldByName('ITE_ICMSAI').AsFloat   := qryGen.fieldbyname('ICMSAI').AsFloat;
  FcdsPpaIte.FieldByName('ITE_IMPFED').AsFloat   := qryGen.fieldbyname('IMPFED').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESOPE').AsFloat   := qryGen.fieldbyname('DESOPE').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB1').AsFloat   := qryGen.fieldbyname('COMTB1').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB2').AsFloat   := qryGen.fieldbyname('COMTB2').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB3').AsFloat   := qryGen.fieldbyname('COMTB3').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB4').AsFloat   := qryGen.fieldbyname('COMTB4').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB5').AsFloat   := qryGen.fieldbyname('COMTB5').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB6').AsFloat   := qryGen.fieldbyname('COMTB6').AsFloat;
  FcdsPpaIte.FieldByName('ITE_COMTB7').AsFloat   := qryGen.fieldbyname('COMTB7').AsFloat;

  FcdsPpaIte.FieldByName('ITE_MARBR1').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ1').AsFloat   := qryGen.fieldbyname('MARBR1').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE1').AsFloat   := qryGen.fieldbyname('PREVE1').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR2').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ2').AsFloat   := qryGen.fieldbyname('MARBR2').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE2').AsFloat   := qryGen.fieldbyname('PREVE2').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR3').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ3').AsFloat   := qryGen.fieldbyname('MARBR3').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE3').AsFloat   := qryGen.fieldbyname('PREVE3').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR4').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ4').AsFloat   := qryGen.fieldbyname('MARBR4').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE4').AsFloat   := qryGen.fieldbyname('PREVE4').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR5').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ5').AsFloat   := qryGen.fieldbyname('MARBR5').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE5').AsFloat   := qryGen.fieldbyname('PREVE5').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR6').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ6').AsFloat   := qryGen.fieldbyname('MARBR6').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE6').AsFloat   := qryGen.fieldbyname('PREVE6').AsFloat;
  FcdsPpaIte.FieldByName('ITE_MARBR7').AsFloat   := 0;
  FcdsPpaIte.FieldByName('ITE_MARLQ7').AsFloat   := qryGen.fieldbyname('MARBR7').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREVE7').AsFloat   := qryGen.fieldbyname('PREVE7').AsFloat;

  FcdsPpaIte.FieldByName('ITE_PREMED').AsFloat   := qryGen.fieldbyname('PREMED').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREULT').AsFloat   := qryGen.fieldbyname('PREULT').AsFloat;
  FcdsPpaIte.FieldByName('ITE_IMPULT').AsFloat   := qryGen.fieldbyname('IMPULT').AsFloat;

  FcdsPpaIte.FieldByName('ITE_IPIENT').AsFloat   := qryGen.fieldbyname('IPIENT').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PRECOM').AsFloat   := qryGen.fieldbyname('PRECOM').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF01').AsFloat   := qryGen.fieldbyname('DESF01').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF02').AsFloat   := qryGen.fieldbyname('DESF02').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF03').AsFloat   := qryGen.fieldbyname('DESF03').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF04').AsFloat   := qryGen.fieldbyname('DESF04').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF05').AsFloat   := qryGen.fieldbyname('DESF05').AsFloat;
  FcdsPpaIte.FieldByName('ITE_DESF06').AsFloat   := qryGen.fieldbyname('DESF06').AsFloat;
  FcdsPpaIte.FieldByName('ITE_PREDOL').AsString  := qryGen.fieldbyname('PREDOL').AsString;
  FcdsPpaIte.FieldByName('ITE_CODABF').AsString  := qryGen.fieldbyname('CODABF').AsString;

  FcdsPpaIte.FieldByName('IPA_CUSREA').AsFloat := 0;
  FcdsPpaIte.FieldByName('IPA_MARBRU').AsFloat := 0;
  FcdsPpaIte.FieldByName('IPA_MARLIQ').AsFloat := 0;
  FcdsPpaIte.FieldByName('ITE_CUSREA').AsFloat := 0;

  pCalculaCustoEMargem();

  FcdsPpaIte.Post;
end;

end.
