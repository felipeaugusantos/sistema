unit untCadNegociacaoClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, Vcl.Menus, CurrencyEditFocus,
  Vcl.StdCtrls, Vcl.CheckLst, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Mask, MaskEditFocus,
  EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untPnlPoliticaDesAcr,
  System.Generics.Collections, UniClientDataSet, UniDataSetProvider, Uni,
  untFuncoesConsulta, untTypesSistema, cxProgressBar, System.StrUtils,
  Vcl.DBCtrls, DBEditFocus, untConsultas, untCadNegBussiness, Math, cxContainer, cxTextEdit, cxCurrencyEdit,
  DBComboBoxFocus, ComboBoxFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxLabel;

type
  TVisualiza = (vsSoValida, vsExibeTela, vsGrava);

type
  TfrmCadNegociacaoClientes = class(TfrmPaiCad)
    TabSheet1: TTabSheet;
    pnlPesqCli: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
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
    cxGridClientes: TcxGridCitel;
    cxGridClientesTableClientes: TcxGridDBTableViewCitel;
    cxGridClientesTableCODCLI: TcxGridDBColumn;
    cxGridClientesTableNOMCLI: TcxGridDBColumn;
    cxGridClientesTableCPFCGC: TcxGridDBColumn;
    cxGridClientesTableNOMCID: TcxGridDBColumn;
    cxGridClientesTableNOMATI: TcxGridDBColumn;
    cxGridClientesLevel1: TcxGridLevel;
    pnlTabPrecos: TPanel;
    pgcTabelas: TPageControl;
    tbsTab1: TTabSheet;
    pnlPoliticaTab1: TPanel;
    tbsTab2: TTabSheet;
    pnlPoliticaTab2: TPanel;
    tbsTab3: TTabSheet;
    pnlPoliticaTab3: TPanel;
    tbsTab4: TTabSheet;
    pnlPoliticaTab4: TPanel;
    tbsTab5: TTabSheet;
    pnlPoliticaTab5: TPanel;
    tbsTab6: TTabSheet;
    pnlPoliticaTab6: TPanel;
    tbsTab7: TTabSheet;
    pnlPoliticaTab7: TPanel;
    pnlTabelas: TPanel;
    lblTabPreco: TLabel;
    clbTabPre: TCheckListBox;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    pnlTitulo2: TPanel;
    lblTitulo2: TLabel;
    pnlDataCompra: TPanel;
    pnlDescontoCompras: TPanel;
    cxGridDataCompra: TcxGridCitel;
    cxGridDBTableCompra: TcxGridDBTableViewCitel;
    cxGridLevel2: TcxGridLevel;
    Panel3: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    lblTotalCmp: TLabel;
    lblRodape2: TLabel;
    btnCima: TBitBtnLocked;
    btnBaixo: TBitBtnLocked;
    pnlDadosDtaCmp: TPanel;
    Label13: TLabel;
    Label14: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtDiaIni: TEditFocus;
    btnAddDescCompra: TBitBtnLocked;
    btnCancDescCompra: TBitBtnLocked;
    edtPerDesCmp: TCurrencyEditFocus;
    edtDiaFim: TEditFocus;
    dtsCliNeg: TDataSource;
    dbeCodNeg: TDBEditFocus;
    dbeDesNeg: TDBEditFocus;
    btnHeranca: TBitBtnLocked;
    dtsCadNeg: TDataSource;
    tabProdutos: TTabSheet;
    pnlFiltros: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    btnAddIte: TBitBtnLocked;
    btnCancIte: TBitBtnLocked;
    cxGridProdutos: TcxGridCitel;
    cxGridDBTableProdutos: TcxGridDBTableViewCitel;
    cxGridProdutosCODITE: TcxGridDBColumn;
    cxGridProdutosDESITE: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dtsIteNeg: TDataSource;
    cxGridDBTableCompraDIAINI: TcxGridDBColumn;
    cxGridDBTableCompraDIAFIM: TcxGridDBColumn;
    cxGridDBTableCompraPERCON: TcxGridDBColumn;
    dtsCmpNeg: TDataSource;
    rdgStatus: TDBRadioGroup;
    Label5: TLabel;
    edtCodRede: TEditFocus;
    edtDesRede: TEditFocus;
    lblUnidade: TLabel;
    edtCodUni: TEditFocus;
    edtDesUni: TEditFocus;
    Label6: TLabel;
    cxGridProdutosSIGUNI: TcxGridDBColumn;
    cxGridProdutosPERITE: TcxGridDBColumn;
    btnRepassaTab: TBitBtnLocked;
    edtDescIte: TCurrencyEditFocus;
    tabCompraMinima: TTabSheet;
    pnlFiltrosQtd: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtCodIteQtd: TEditFocus;
    edtDesIteQtd: TEditFocus;
    mskLinhaGrupoQtd: TMaskEditFocus;
    edtDesGrupoQtd: TEditFocus;
    edtFornecedorQtd: TEditFocus;
    edtDesFornecedorQtd: TEditFocus;
    edtMarcaQtd: TEditFocus;
    edtDesMarcaQtd: TEditFocus;
    btnAddQtdIte: TBitBtnLocked;
    btnCancQtdIte: TBitBtnLocked;
    edtCodUniQtd: TEditFocus;
    edtDesUniQtd: TEditFocus;
    edtDescIteQtd: TCurrencyEditFocus;
    cxGridProdutosQtd: TcxGridCitel;
    cxGridDBTableQtdProdutos: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridLevel3: TcxGridLevel;
    dtsQtdNeg: TDataSource;
    cxGridDBColumn5: TcxGridDBColumn;
    Label20: TLabel;
    edtQtdIte: TCurrencyEditFocus;
    edtCodRegiao: TEditFocus;
    edtDesRegiao: TEditFocus;
    lblRegiao: TLabel;
    cxGridClientesTableNUMDOC: TcxGridDBColumn;
    cxGridClientesTableESPDOC: TcxGridDBColumn;
    cxGridClientesTableDTAUCP: TcxGridDBColumn;
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreExit(Sender: TObject);
    procedure clbTabPreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure clbTabPreEnter(Sender: TObject);
    procedure btnCancDescCompraClick(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure btnIncCliClick(Sender: TObject);
    procedure btnCancelCliClick(Sender: TObject);
    procedure cxGridClientesTableClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtNuCnPjEnter(Sender: TObject);
    procedure btnCancIteClick(Sender: TObject);
    procedure btnAddIteClick(Sender: TObject);
    procedure cxGridDBTableProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbsGeralShow(Sender: TObject);
    procedure btnAddDescCompraClick(Sender: TObject);
    procedure cxGridDBTableCompraDblClick(Sender: TObject);
    procedure cxGridDBTableCompraKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDBTableCompraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCimaClick(Sender: TObject);
    procedure btnBaixoClick(Sender: TObject);
    procedure edtDiaIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtDiaFimKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtsCmpNegStateChange(Sender: TObject);
    procedure edtCodRedeExit(Sender: TObject);
    procedure edtCodRedeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dtsCadNegStateChange(Sender: TObject);
    procedure btnRepassaTabClick(Sender: TObject);
    procedure cxGridDBTableQtdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAddQtdIteClick(Sender: TObject);
    procedure btnCancQtdIteClick(Sender: TObject);
    procedure edtCodIteQtdExit(Sender: TObject);
    procedure edtCodIteQtdKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoQtdExit(Sender: TObject);
    procedure mskLinhaGrupoQtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaQtdExit(Sender: TObject);
    procedure edtMarcaQtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniQtdExit(Sender: TObject);
    procedure edtCodUniQtdKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorQtdExit(Sender: TObject);
    procedure edtFornecedorQtdKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDBTableQtdProdutosEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure cxGridDBTableProdutosEditValueChanged(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure edtCodRegiaoExit(Sender: TObject);
    procedure edtCodRegiaoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    blnCriando: Boolean;
    intOrdDes : Integer;
    strTabelas: String;
    lstPolicaTabs: TList<TfrmPnlPoliticaDesAcr>;

    cdsCliNeg: TUniClientDataSet;
    cdsIteNeg: TUniClientDataSet;
    cdsCmpNeg: TUniClientDataSet;
    cdsQtdNeg: TUniClientDataSet;

    dspIteNeg: TUniDataSetProvider;
    qryIteNeg: TUniQuery;

    dspCliNeg: TUniDataSetProvider;
    qryCliNeg: TUniQuery;

    dspQtdNeg: TUniDataSetProvider;
    qryQtdNeg: TUniQuery;

    arrLinhaGrupo,
    arrProdutos,
    arrMarca,
    arrFornecedor,
    arrCidade,
    arrCliente,
    arrRede,
    arrUni,
    arrRegiao,
    arrLinAti: TConsultasArray;

    arrLinhaGrupoQtd,
    arrProdutosQtd,
    arrMarcaQtd,
    arrFornecedorQtd,
    arrUniQtd: TConsultasArray;

    strLinhaGrupo,
    strProdutos,
    strMarca,
    strFornecedor,
    strCidade,
    strCliente,
    strRede,
    strUni,
    strRegiao,
    strLinAti: String;

    stlItensAlterados: TStringList;
    stlItensDeletados: TStringList;

    procedure pRepassaTabelas;
    function fRepassaTabelas(pgbStatus: TcxProgressBar): Boolean;

    function fCodCli: String;

    procedure pCarregaTodosDadosNegociacao(blnHeranca: Boolean = False);

    procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
    procedure pStepStatusGravacao(pgbStatus: TcxProgressBar);

    procedure pCriaTelaPoliticaTabs;
    function fGetTabelasPrecoSelecionadas: String;
    procedure pCarregaTabelas;
    procedure pLimpaTodosCamposPageTabelas;
    procedure pLimpaTodosGridPageTabelas;

    procedure pLimpaGrids;

    procedure pMarcarTabelasPreco(strTabelas: String);
    procedure pAfterScroll(DataSet: TDataSet);

    procedure pAdicionaPoliticaDescCompra;
    procedure pCancelaPoliticaDescCompra;
    procedure pAtualizaOrdenacao(intOrdTmp: Integer; blnCima: Boolean);
    procedure pCarregaItemAlteracaoCmp;
    procedure pOrdenaItem(blnCima: Boolean);
    procedure pCalculaTotal;

    procedure pCriaClientCliente;
    function fRetornaSQLUltimaVenda: String;
    function fAdicionaCliente(pgbStatus: TcxProgressBar): Boolean;
    procedure pCancelaCliente;
    procedure pBuscaDadosCliente;
    function fCarregaClientesNegociacao(pgbStatus: TcxProgressBar): Boolean;
    procedure pCarregaClientesNegociacao;

    procedure pCriaClientProduto;
    procedure pCriaQuantidadeProduto;
    procedure pCarregaProdutosNegociacao;
    function fCarregaProdutosNegociacao(pgbStatus: TcxProgressBar): Boolean;
    function fAdicionaProdutos(pgbStatus: TcxProgressBar): Boolean;
    function fAdicionaProdutosQtd(pgbStatus: TcxProgressBar): Boolean;
    procedure pCancelaItens;
    procedure pCancelaItensQtd;
    procedure pAfterOpenItens(DataSet: TDataSet);
    procedure pBeforePostItens(DataSet: TDataSet);
    procedure pBeforeDeleteItens(DataSet: TDataSet);

    procedure pGravaPoliticasDesAcr;

    procedure pDeletaProdutosPoliticas;
    procedure pGravaPoliticasProdutos;
    function fGravaPoliticasProdutos(pgbStatus: TcxProgressBar): Boolean;

    procedure pSetaSequencialPoliiticaDesAcr(blnHeranca: Boolean = False);
    function fVerificaNegociacoes(strCodCli, strCodNeg: String): Boolean;

    procedure pDeletaClientesPoliticas;
    procedure pGravaPoliticaClientes;
    function fGravaPoliticaClientes(pgbStatus: TcxProgressBar): Boolean;

    procedure pCriaClientCompra;
    procedure pCarregaPoliticasCompras;
    function fCarregaPoliticasCompras(pgbStatus: TcxProgressBar): Boolean;
    procedure pDeletaComprasPoliticas;
    procedure pGravaPoliticaCompras;
    function fGravaPoliticaCompras(pgbStatus: TcxProgressBar): Boolean;
    procedure pDeletaQuantidadePoliticas;
    procedure pGravaPoliticaQuantidade;
    function fGravaPoliticaQuantidade(pgbStatus: TcxProgressBar): Boolean;
    function fCarregaPoliticasQuantidade(pgbStatus: TcxProgressBar): Boolean;
    procedure pCarregaPoliticasQuantidade;
    procedure pAfterScrollCompras(DataSet: TDataSet);

    function fValidandoGravacao(pgbStatus: TcxProgressBar): Boolean;
    function fItensConcatenado: String;

    function fItensAlterados: String;
    function fItensDeletados: String;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoes, untFuncoesSimples, untGravando, untHerancaNegociacao, untObservacao, untFuncoesGenerica;

{ TfrmCadNegociacaoClientes }

procedure TfrmCadNegociacaoClientes.btnAddDescCompraClick(Sender: TObject);
begin
  inherited;
  pAdicionaPoliticaDescCompra;
end;

procedure TfrmCadNegociacaoClientes.btnAddIteClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupo.Text))) Or
     (Not fEmptyStr(edtMarca.Text))                           Or
     (Not fEmptyStr(edtCodIte.Text))                          Or
     (Not fEmptyStr(edtCodUni.Text))                          Or
     (Not fEmptyStr(edtFornecedor.Text))                      Then
  Begin
    If fValidaCampos(edtDescIte, True) Then
    Begin
      Try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fAdicionaProdutos;
        frmAguarde.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmAguarde);
    End;
  End
  Else
    fMensagem('ATENÇÃO', 'Defina pelo menos um filtro para realizar as inclusões dos itens!', ['&OK']);
end;

procedure TfrmCadNegociacaoClientes.btnAddQtdIteClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskLinhaGrupoQtd.Text))) Or
     (Not fEmptyStr(edtMarcaQtd.Text))                           Or
     (Not fEmptyStr(edtCodIteQtd.Text))                          Or
     (Not fEmptyStr(edtCodUniQtd.Text))                          Or
     (Not fEmptyStr(edtFornecedorQtd.Text))                      Then
  Begin
    If fValidaCampos(edtDescIteQtd, True) And
       fValidaCampos(edtQtdIte, True) Then
    Begin
      Try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fAdicionaProdutosQtd;
        frmAguarde.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmAguarde);
    End;
  End
  Else
    fMensagem('ATENÇÃO', 'Defina pelo menos um filtro para realizar as inclusões dos itens!', ['&OK']);
end;

procedure TfrmCadNegociacaoClientes.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pAfterScroll(Nil);
end;

procedure TfrmCadNegociacaoClientes.btnCancDescCompraClick(Sender: TObject);
begin
  inherited;

  pCancelaPoliticaDescCompra;
end;

procedure TfrmCadNegociacaoClientes.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pCancelaCliente;
  pCancelaPoliticaDescCompra;
  pLimpaTodosCamposPageTabelas;
  pCancelaItens;

  pCarregaTodosDadosNegociacao;
  pAfterScroll(Nil);
end;

procedure TfrmCadNegociacaoClientes.btnCancelCliClick(Sender: TObject);
begin
  inherited;
  pCancelaCliente;
end;

procedure TfrmCadNegociacaoClientes.btnCancIteClick(Sender: TObject);
begin
  inherited;

  pCancelaItens;
end;

procedure TfrmCadNegociacaoClientes.btnCancQtdIteClick(Sender: TObject);
begin
  inherited;
  pCancelaItensQtd;
end;

procedure TfrmCadNegociacaoClientes.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNegociacaoClientes.btnExcluirClick]');
    End;
  End;


  If blnExcluiu Then
  Begin
    fCommit;
    pCancelaCliente;
    pCancelaPoliticaDescCompra;
    pLimpaTodosCamposPageTabelas;
    pLimpaTodosGridPageTabelas;
    pCancelaItens;
    pLimpaGrids;

    pCarregaTodosDadosNegociacao;
  End
  Else
    fRollBack;
end;

procedure TfrmCadNegociacaoClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    intIndex: Integer;
begin
  inherited;

  If Action <> CaNone Then
  Begin
    If Assigned(lstPolicaTabs) Then
    Begin
      For intIndex := 0 To lstPolicaTabs.Count-1 Do
       lstPolicaTabs[intIndex].Free;

      If Assigned(lstPolicaTabs) Then
        FreeAndNil(lstPolicaTabs);
    End;

    If Assigned(cdsCliNeg) Then
      FreeAndNil(cdsCliNeg);

    If Assigned(cdsIteNeg) Then
      FreeAndNil(cdsIteNeg);

    If Assigned(cdsCmpNeg) Then
      FreeAndNil(cdsCmpNeg);

    If Assigned(dspIteNeg) Then
      FreeAndNil(dspIteNeg);

    If Assigned(qryIteNeg) Then
      FreeAndNil(qryIteNeg);

    If Assigned(dspCliNeg) Then
      FreeAndNil(dspCliNeg);

    If Assigned(qryCliNeg) Then
      FreeAndNil(qryCliNeg);

    If Assigned(dspQtdNeg) Then
      FreeAndNil(dspQtdNeg);

    If Assigned(qryQtdNeg) Then
      FreeAndNil(qryQtdNeg);

    If Assigned(cdsQtdNeg) Then
      FreeAndNil(cdsQtdNeg);
  End;
end;

procedure TfrmCadNegociacaoClientes.FormShow(Sender: TObject);
begin
  inherited;

  pAfterScroll(Nil);
  pgcDados.ActivePageIndex := 0;
  pSetFocus(btnIncluir);

  pSetaCodIte(edtCodIte);
  pSetaCodIte(edtCodIteQtd);
end;

procedure TfrmCadNegociacaoClientes.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinhaGrupo,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmCadNegociacaoClientes.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.mskLinhaGrupoQtdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupoQtd,edtDesGrupoQtd,arrLinhaGrupoQtd,fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmCadNegociacaoClientes.mskLinhaGrupoQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinhaGrupoQtd, edtDesGrupoQtd, Nil, Key, arrLinhaGrupoQtd, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupoQtd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.FormCreate(Sender: TObject);
begin
  inherited;
  blnCriando    := True;
  strNomeTabela := 'CADNEG';
  strNomeCampo  := 'NEG_CODNEG';
  intOrdDes     := -1;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNeg;

  qryTabela := fCriarQuery('SELECT * FROM CADNEG WHERE FALSE', Self);
  qryTabela.AfterScroll := pAfterScroll;
  dtsCadNeg.DataSet := qryTabela;

  lstPolicaTabs := TList<TfrmPnlPoliticaDesAcr>.Create;
  strTabelas := fPadR(VS_strTabVen, clbTabPre.Items.Count, 'N');
  pCriaTelaPoliticaTabs;
  pCriaClientCliente;
  pCriaClientProduto;
  pCriaClientCompra;
  pCriaQuantidadeProduto;

  stlItensAlterados := TStringList.Create;
  stlItensDeletados := TStringList.Create;
end;

procedure TfrmCadNegociacaoClientes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(stlItensAlterados);
  FreeAndNil(stlItensDeletados);

  inherited;

end;

procedure TfrmCadNegociacaoClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Return Then
  Begin
    If ((ActiveControl) Is TRadioButton) And (ActiveControl.Parent <> Nil) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.btnGravarClick(Sender: TObject);
  Var
    intIndex: Integer;
    arrTabTmp: TStringArray;
    frmAguarde: TfrmGravando;

  procedure pMontaArrayTab;
    Var
      intCont,
      intPos: Integer;
  Begin
    intPos := 0;
    SetLength(arrTabTmp, lstPolicaTabs.Count);

    For intCont := 1 To Length(VS_strTabVen) Do
    Begin
      If VS_strTabVen[intCont] = 'S' Then
      Begin
        arrTabTmp[intPos] := IntToStr(intCont);
        Inc(intPos);
      End;
    End;
  End;

  function fNenhumDescontoOuAcrescimoDefinido: Boolean;
    Var
      intCont: Integer;
  Begin
    Result := True;

    For intCont := 0 To lstPolicaTabs.Count-1 Do
    Begin
      If Not lstPolicaTabs[intCont].cdsDesconto.IsEmpty Then
      Begin
        Result := False;
        Break;
      End;

      If Not lstPolicaTabs[intCont].cdsAcrescimo.IsEmpty Then
      Begin
        Result := False;
        Break;
      End;
    End;
  End;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
  Begin
    fMensagem('','Selecione alguma tabela de preço!',['&OK']);
    pSetFocus(clbTabPre);
    Exit;
  End
  Else
  Begin
    If qryTabela.State In [dsEdit, dsInsert] Then
      qryTabela.FieldByName('NEG_TABPRE').AsString := fGetTabelasPrecoSelecionadas;
  End;

  If cdsIteNeg.IsEmpty Then
  Begin
    fMensagem('','Defina algum item para compor esta negociação!',['&OK']);
    pgcDados.ActivePageIndex := 1;
    pSetFocus(mskLinhaGrupo);
    Exit;
  End;

  If cdsCmpNeg.IsEmpty And fNenhumDescontoOuAcrescimoDefinido Then
  Begin
    fMensagem('','Defina algum desconto/acréscimo para compor esta negociação!',['&OK']);
    pgcDados.ActivePageIndex := 0;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fValidandoGravacao;
    frmAguarde.ShowModal;

    If Not frmAguarde.blnConfirma Then
    Begin
      pFreeAndNil(frmAguarde);
      Exit;
    End
    Else
      pFreeAndNil(frmAguarde);

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    inherited;

    If blnGravou Then
    Begin
      pMontaArrayTab;

      For intIndex := 0 To lstPolicaTabs.Count-1 Do
        lstPolicaTabs[intIndex].pAtualizaSeqGer(qryTabela.FieldByName('AUTOINCREM').AsString, arrTabTmp[intIndex]);

      pGravaPoliticasDesAcr;
      pGravaPoliticasProdutos;
      pGravaPoliticaClientes;
      pGravaPoliticaCompras;
      pGravaPoliticaQuantidade;

      fCommit;
      pAfterScroll(Nil);

      pgcDados.ActivePageIndex := 0;
      pSetFocus(btnAlterar);
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadNegociacaoClientes.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadNegociacaoClientes.btnHerancaClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmHerancaNegociacao, frmHerancaNegociacao);
    frmHerancaNegociacao.ShowModal;

    If frmHerancaNegociacao.blnConfirma Then
    Begin
      qryTabela.FieldByName('AUTOINCREM').AsString := frmHerancaNegociacao.qryGenNeg.FieldByName('AUTOINCREM').AsString;
      qryTabela.FieldByName('NEG_TABPRE').AsString := frmHerancaNegociacao.qryGenNeg.FieldByName('NEG_TABPRE').AsString;
      qryTabela.FieldByName('NEG_DESCRI').AsString := frmHerancaNegociacao.qryGenNeg.FieldByName('NEG_DESCRI').AsString;
      qryTabela.FieldByName('NEG_STATUS').AsString := frmHerancaNegociacao.qryGenNeg.FieldByName('NEG_STATUS').AsString;

      pCarregaTodosDadosNegociacao(True);
      pAfterScroll(Nil);

      qryTabela.FieldByName('AUTOINCREM').AsString := '';

      If pnlCabecalho.Enabled And dbeDesNeg.CanFocus Then
        pSetFocus(dbeDesNeg);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadNegociacaoClientes.btnHerancaClick]');
    End;
  End;

  pFreeAndNil(frmHerancaNegociacao);
end;

function TfrmCadNegociacaoClientes.fItensAlterados: String;
  Var
    L: Integer;
Begin
  Result := '';

  For L := 0 To stlItensAlterados.Count -1 Do
  Begin
    Result := Result + '_' + stlItensAlterados[L];
  End;
end;

function TfrmCadNegociacaoClientes.fItensConcatenado: String;
  Var
    cdsItens: TUniClientDataSet;
begin
  Result := '';

  cdsItens := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsItens, cdsIteNeg);
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fEmptyStr(Result) Then
        Result := QuotedStr(cdsItens.FieldByName('ITE_CODITE').AsString)
      Else
        Result := Result + ',' + QuotedStr(cdsItens.FieldByName('ITE_CODITE').AsString);

      cdsItens.Next;
    End;
  Finally
    FreeAndNil(cdsItens);
  End;
end;

function TfrmCadNegociacaoClientes.fItensDeletados: String;
  Var
    L: Integer;
Begin
  Result := '';

  For L := 0 To stlItensDeletados.Count -1 Do
  Begin
    Result := Result + '_' + stlItensDeletados[L];
  End;
end;

procedure TfrmCadNegociacaoClientes.btnIncCliClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If Not fValidaCampos(edtCodCli, True) then
  Begin
    btnCancelCli.Click;
    Exit;
  End;

  If cdsIteNeg.IsEmpty Then
  Begin
    pMensagemOk('Antes de inserir o cliente, escolha os itens!');
    Exit;
  End;

  If (Not fEmptyStr(edtCodCli.Text))  Or
     (Not fEmptyStr(edtCodAti.Text))  Or
     (Not fEmptyStr(edtCodCid.Text))  Or
     (Not fEmptyStr(edtCodRede.Text)) Or
     (Not fEmptyStr(edtEstado.Text))  Or
     (Not fEmptyStr(edtCodRegiao.Text)) Or
     (Not fEmptyStr(fTiraCaracEspeciais(edtNuCnpj.Text))) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fAdicionaCliente;
      frmAguarde.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmAguarde);
  End
  Else
    fMensagem('ATENÇÃO', 'Defina pelo menos um filtro para realizar as inclusões dos clientes!', ['&OK']);
end;

procedure TfrmCadNegociacaoClientes.btnIncluirClick(Sender: TObject);
  Var
    intContador: Integer;
begin
  inherited;

  pLimparCampos;
  pCancelaCliente;
  pCancelaPoliticaDescCompra;
  pLimpaTodosCamposPageTabelas;
  pLimpaTodosGridPageTabelas;
  pCancelaItens;
  pLimpaGrids;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodNeg, dbeDesNeg, False)
  Else
    pHabilitaCodigo(dbeCodNeg, dbeCodNeg, True);

  For intContador := 0 To clbTabPre.Items.Count -1 Do
    clbTabPre.Checked[intContador] := strTabelas[Succ(intContador)] = 'S';

  btnHeranca.Enabled := True;
  qryTabela.FieldByName('NEG_STATUS').AsString := 'A';
end;

procedure TfrmCadNegociacaoClientes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrNegociacao: TConsultasArray;
begin
  chrKey := '/';

  If fPesqNegociacao(Self, Nil, Nil, qryTabela, chrKey, arrNegociacao) Then
  Begin
    pCancelaCliente;
    pCancelaPoliticaDescCompra;
    pLimpaTodosCamposPageTabelas;
    pLimpaTodosGridPageTabelas;
    pCancelaItens;
    pLimpaGrids;

    pCarregaTodosDadosNegociacao;
    pAfterScroll(Nil);

    If (btnAlterar.Enabled) Then
      pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadNegociacaoClientes.btnRepassaTabClick(Sender: TObject);
begin
  inherited;

  If (lstPolicaTabs.Count > 1) And
     (fMensagem('ATENÇÃO', 'Deseja repassar os descontos/acréscimos da ' + fTiraCaracEspeciais(pgcTabelas.ActivePage.Caption) + ' para as demais tabelas?', ['&Sim', '&Não'], 1) = 1) Then
    pRepassaTabelas;
end;

procedure TfrmCadNegociacaoClientes.clbTabPreClickCheck(Sender: TObject);
  Var
    intTab: Integer;
begin
  inherited;

  For intTab := 1 To clbTabPre.Items.Count Do
    If strTabelas[intTab] <> 'S' Then
      clbTabPre.Checked[Pred(intTab)] := False;
end;

procedure TfrmCadNegociacaoClientes.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  Var
    Flags: Longint;
begin
  With TCheckListBox(Control) Do
  Begin
    If strTabelas[Succ(Index)] <> 'S' Then
      Canvas.Font.Color  := clSilver;

    Canvas.FillRect(Rect);

    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

    If Not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    Else
      Dec(Rect.Right, 2);

    DrawText(Canvas.Handle, pWideChar(Items[Index]), Length(Items[Index]), Rect, Flags);
  End;
end;

procedure TfrmCadNegociacaoClientes.clbTabPreEnter(Sender: TObject);
begin
  inherited;
  TCheckListBox(Sender).Color := $008080FF;
end;

procedure TfrmCadNegociacaoClientes.clbTabPreExit(Sender: TObject);
begin
  inherited;
  If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
  Begin
    fMensagem('AVISO','Selecione ao menos uma tabela de preço para a negociação!', ['&O K']);
    pSetFocus(clbTabPre);
  End
  Else
    TCheckListBox(Sender).Color := clWindow;
end;

procedure TfrmCadNegociacaoClientes.clbTabPreKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    SelectNext(ActiveControl,True,True);
end;

procedure TfrmCadNegociacaoClientes.btnCimaClick(Sender: TObject);
begin
  inherited;
  pOrdenaItem(True);
end;

procedure TfrmCadNegociacaoClientes.btnBaixoClick(Sender: TObject);
begin
  inherited;
  pOrdenaItem(False);
end;

procedure TfrmCadNegociacaoClientes.cxGridClientesTableClientesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_DELETE: If (qryTabela.State In [dsEdit, dsInsert]) And (cdsCliNeg.Active) And (Not cdsCliNeg.IsEmpty) then
               Begin
                 If fPergunta('Deseja remover o cliente ' + cdsCliNeg.FieldByName('NOMCLI').AsString + ' da Negociação?') then
                   cdsCliNeg.Delete;
               End;
  End;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableCompraDblClick(
  Sender: TObject);
begin
  inherited;
  pCarregaItemAlteracaoCmp;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableCompraKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If cdsCmpNeg.IsEmpty Then
    Exit;

  If Key = VK_DELETE Then
  Begin
    cdsCmpNeg.Delete;
    pAtualizaOrdenacao(-1, True);
    pCalculaTotal;
  End;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableCompraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
    pCarregaItemAlteracaoCmp;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableProdutosEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  If (cxGridDBTableProdutos.GetColumnByFieldName('PERITE').Index = cxGridDBTableProdutos.Controller.FocusedColumnIndex) Then
    If StringToFloat(Sender.Controller.EditingController.Edit.EditingValue) < 0 Then
      TcxTextEdit(Sender.Controller.EditingController.Edit).Undo;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableProdutosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: If (Not cdsIteNeg.IsEmpty) And (cdsIteNeg.State = dsEdit) Then
                 cdsIteNeg.Cancel
               Else
                 Close;
    VK_RETURN: Begin
                 If cxGridDBTableProdutos.GetColumnByFieldName('PERITE').Index <> cxGridDBTableProdutos.Controller.FocusedColumnIndex Then
                   cxGridDBTableProdutos.Controller.FocusedColumnIndex := cxGridDBTableProdutos.GetColumnByFieldName('PERITE').Index
                 Else
                 Begin
                   If Not cdsIteNeg.IsEmpty Then
                   Begin
                     cdsIteNeg.Next;

                     If cdsIteNeg.Eof Then
                       cdsIteNeg.First;
                   End;
                 End;
               End;
    VK_DELETE: If (qryTabela.State In [dsEdit, dsInsert]) And (cdsIteNeg.Active) And (Not cdsIteNeg.IsEmpty) then
               Begin
                 If fPergunta('Deseja remover o produto ' + cdsIteNeg.FieldByName('ITE_DESITE').AsString + ' da Negociação?') then
                   cdsIteNeg.Delete;
               End;
  End;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableQtdProdutosEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;
  If (cxGridDBTableQtdProdutos.GetColumnByFieldName('QTDITE').Index = cxGridDBTableQtdProdutos.Controller.FocusedColumnIndex) Or
     (cxGridDBTableQtdProdutos.GetColumnByFieldName('PERITE').Index = cxGridDBTableQtdProdutos.Controller.FocusedColumnIndex) Then
    If StringToFloat(Sender.Controller.EditingController.Edit.EditingValue) = 0 Then
      TcxTextEdit(Sender.Controller.EditingController.Edit).Undo;
end;

procedure TfrmCadNegociacaoClientes.cxGridDBTableQtdProdutosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: If (Not cdsQtdNeg.IsEmpty) And (cdsQtdNeg.State = dsEdit) Then
                 cdsQtdNeg.Cancel
               Else
                 Close;
    VK_RETURN: Begin
                 If cxGridDBTableQtdProdutos.GetColumnByFieldName('QTDITE').Index <> cxGridDBTableQtdProdutos.Controller.FocusedColumnIndex Then
                   cxGridDBTableQtdProdutos.Controller.FocusedColumnIndex := cxGridDBTableQtdProdutos.GetColumnByFieldName('QTDITE').Index
                 Else
                 Begin
                   If Not cdsQtdNeg.IsEmpty Then
                   Begin
                     cdsQtdNeg.Next;

                     If cdsQtdNeg.Eof Then
                       cdsQtdNeg.First;
                   End;
                 End;
               End;
    VK_DELETE: If (qryTabela.State In [dsEdit, dsInsert]) And (cdsQtdNeg.Active) And (Not cdsQtdNeg.IsEmpty) then
               Begin
                 If fPergunta('Deseja remover da negociação? ' + Chr(13) +
                              'Produto: ' + cdsQtdNeg.FieldByName('ITE_DESITE').AsString +
                              ' / Quantidade mínima: ' + cdsQtdNeg.FieldByName('QTDITE').AsString) then
                   cdsQtdNeg.Delete;
               End;
  End;
end;

procedure TfrmCadNegociacaoClientes.dtsCadNegStateChange(Sender: TObject);
begin
  inherited;
  btnRepassaTab.Enabled := qryTabela.State in [dsEdit, dsInsert];
  btnHeranca.Enabled    := qryTabela.State in [dsInsert];
end;

procedure TfrmCadNegociacaoClientes.dtsCmpNegStateChange(Sender: TObject);
begin
  inherited;

  cxGridDataCompra.Enabled := dtsCmpNeg.State = dsBrowse;
end;

procedure TfrmCadNegociacaoClientes.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    edtNuCnpj.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else If (edtCgcCpf.Text = '2') Then
    edtNuCnpj.EditMask := '999.999.999-99;0;'
  Else
    edtNuCnpj.EditMask := '';
end;

procedure TfrmCadNegociacaoClientes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrLinAti, nil, fRetNomAtividade, 'da Atividade');
end;

procedure TfrmCadNegociacaoClientes.edtCodAtiKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrLinAti, False) Then
  Begin
    fValidaCampos(edtCodAti, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtDesCid, arrCidade, fRetNomCidadeSemOpc,Nil, 'da cidade');
end;

procedure TfrmCadNegociacaoClientes.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtDesCid, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente, 'do cliente');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtCodRede.Enabled := False;
    edtCodRede.Clear;
    pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede',5);
    pSetFocus(edtCodAti);
  End
  Else
  Begin
    edtCodRede.Enabled := True;
    pSetFocus(edtCodRede);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodIteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProdutos,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmCadNegociacaoClientes.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProdutos, False, nil, 'Consulta de Produtos', '1') Then
  Begin
    fValidaCampos(edtCodIte,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodIteQtdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodIteQtd,edtDesIteQtd,arrProdutosQtd,nil,fRetNomProduto,'do Produto');
end;

procedure TfrmCadNegociacaoClientes.edtCodIteQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Not fEmptyStr(mskLinhaGrupoQtd.Text) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fPesqItem(conIteSimples, Self, edtCodIteQtd, edtDesIteQtd, nil, Key, arrProdutosQtd, False, nil, 'Consulta de Produtos', '1') Then
  Begin
    fValidaCampos(edtCodIteQtd,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodRedeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRede,edtDesRede,arrRede,nil,fRetNomeRedeLoja,'da rede', 5);
end;

procedure TfrmCadNegociacaoClientes.edtCodRedeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRede, edtDesRede, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRede, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodRegiaoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRegiao, edtDesRegiao, arrRegiao,  Nil, fRetNomRegiao, 'da região');
end;

procedure TfrmCadNegociacaoClientes.edtCodRegiaoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqRegiao(Self, edtCodRegiao, edtDesRegiao, Nil, Key, arrRegiao, False) then
  begin
    fValidaCampos(edtCodRegiao, False);
    Self.SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadNegociacaoClientes.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, edtDesUni, arrUni, fRetNomUnidade, nil, 'da Unidade');
end;

procedure TfrmCadNegociacaoClientes.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, edtDesUni, Nil, Nil, Key, arrUni, False) Then
  Begin
    If fValidaCampos(edtCodUni, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtCodUniQtdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUniQtd, edtDesUniQtd, arrUniQtd, fRetNomUnidade, nil, 'da Unidade');
end;

procedure TfrmCadNegociacaoClientes.edtCodUniQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUniQtd, edtDesUniQtd, Nil, Nil, Key, arrUniQtd, False) Then
  Begin
    If fValidaCampos(edtCodUniQtd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtDiaFimKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Not CharInSet(Key, ['0'..'9']) Then
  Begin
    If Key <> #13 Then
      pSetFocus(TEditFocus(Sender))
    Else
      fValidaCampos(TWinControl(Sender), True);

    Key := #0;
  End
  Else
    inherited;
end;

procedure TfrmCadNegociacaoClientes.edtDiaIniKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Not CharInSet(Key, ['0'..'9']) Then
  Begin
    If Key <> #13 Then
      pSetFocus(TEditFocus(Sender))
    Else
      fValidaCampos(TWinControl(Sender), True);

    Key := #0;
  End
  Else
    inherited;
end;

procedure TfrmCadNegociacaoClientes.edtFornecedorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmCadNegociacaoClientes.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtFornecedorQtdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtFornecedorQtd,edtDesFornecedorQtd,arrFornecedorQtd,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmCadNegociacaoClientes.edtFornecedorQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtFornecedorQtd, edtDesFornecedorQtd, Nil, Key, arrFornecedorQtd, False) Then
  Begin
    fValidaCampos(edtFornecedorQtd, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtMarcaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarca,edtDesMarca,arrMarca,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCadNegociacaoClientes.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtMarcaQtdExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtMarcaQtd,edtDesMarcaQtd,arrMarcaQtd,fRetNomMarca,nil,'da Marca');
end;

procedure TfrmCadNegociacaoClientes.edtMarcaQtdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtMarcaQtd, edtDesMarcaQtd, Nil, Key, arrMarcaQtd, False) Then
  Begin
    If fValidaCampos(edtMarcaQtd, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadNegociacaoClientes.edtNuCnPjEnter(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Or (edtCgcCpf.Text = '2') Then
    edtNuCnPj.ReadOnly := False
  Else
    edtNuCnPj.ReadOnly := True;
end;

function TfrmCadNegociacaoClientes.fRetornaSQLUltimaVenda: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                   ';
  Result := Result + '   DET_NUMDOC AS NUMDOC,               ';
  Result := Result + '   DET_ESPDOC AS ESPDOC,               ';
  Result := Result + '   DET_DTAENT AS DTAUCP                ';
  Result := Result + ' FROM MOVDET                           ';
  Result := Result + ' WHERE DET_CODCLI = :CODCLI            ';
  If (Not cdsIteNeg.IsEmpty) Then
    Result := Result + ' AND DET_CODITE IN ('+ fItensConcatenado +') ';
  Result := Result + '   AND DET_TIP_FC = "C"                ';
  Result := Result + '   AND LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaVen) + ') > 0 ';
  Result := Result + ' ORDER BY DET_DTAENT DESC,            ';
  Result := Result + '          DET_HORENT DESC             ';
  Result := Result + ' LIMIT 1;                             ';
end;

function TfrmCadNegociacaoClientes.fAdicionaCliente(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryGen : TUniQuery;
    strSQL : String;
    prcScroll: TprcScroll;
    qryItens : TUniQuery;
begin
  Result := False;

  qryGen := fCriaQuery;
  Try
    If Not cdsCliNeg.Active Then
      cdsCliNeg.Open;

    pDisableControls(cdsCliNeg, prcScroll);
    cxGridClientes.Enabled := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CLI_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CONCAT(CID_NOMCID," - ",CID_ESTADO) AS NOMCID, ';
    strSQL := strSQL + '  ATI_DESATI AS NOMATI, ';
    strSQL := strSQL + '  CLI_C_G_C_ AS CGCCPF  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI, ';
    strSQL := strSQL + '  CADCID, ';
    strSQL := strSQL + '  CADATI  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODATI = ATI_CODATI AND ';
    strSQL := strSQL + '  CLI_CODCID = CID_CODCID ';

    If (Not fEmptyStr(edtCodCli.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodCli,arrCliente,'CLI_CODCLI','CODCLI');

    If (Not fEmptyStr(edtCodRede.Text)) Then
      strSQL := strSQL + fStrSQLOr(edtCodRede,arrRede,'CLI_CODRED','CODRED');

    If Not fEmptyStr(edtCodAti.Text) Then
      strSQL := strSQL + fStrLocate(edtCodAti,arrLinAti,'CLI_CODATI','CODATI');

    If Not fEmptyStr(edtCodCid.Text) Then
      strSQL := strSQL + fStrLocate(edtCodCid,arrCidade,'CLI_CODCID','CODCID');

    If Not fEmptyStr(edtEstado.Text) Then
      strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    If Not fEmptyStr(edtNuCnpj.Text) Then
      strSQL := strSQL + '  AND CLI_C_G_C_ = :CGCCPF ';

    If Not fEmptyStr(edtCodRegiao.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRegiao,arrRegiao,'CLI_CODREG','CODREG');

    strSQL := strSQL + 'ORDER BY CLI_CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtCodCli.Text)) Then
        pSetaParam(edtCodCli.Text,arrCliente,strCliente,'CODCLI', qryGen);

      If (Not fEmptyStr(edtCodRede.Text)) Then
        pSetaParamOR(edtCodRede,arrRede,'CODRED', qryGen);

      If Not fEmptyStr(edtCodAti.Text) Then
        pSetaParam(edtCodAti.Text,arrLinAti,strLinAti,'CODATI', qryGen);

      If Not fEmptyStr(edtCodCid.Text) Then
        pSetaParam(edtCodCid.Text,arrCidade,strCidade,'CODCID', qryGen);

      If Not fEmptyStr(edtEstado.Text) Then
        ParamByName('ESTADO').AsString := edtEstado.Text;

      If Not fEmptyStr(fTiraCaracEspeciais(edtNuCnpj.Text)) Then
        ParamByName('CGCCPF').AsString := fTiraCaracEspeciais(edtNuCnpj.Text);

      If Not fEmptyStr(edtCodRegiao.Text) Then
        pSetaParam(edtCodRegiao.Text,arrRegiao,strRegiao,'CODREG', qryGen);
      Open;
    End;

    If qryGen.RecordCount = 0 Then
      fMensagem('','Nenhum Cliente foi encontrado!',['&O K'], 0)
    Else
    Begin
      pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Cliente...', qryGen.RecordCount);

      qryItens := fCriaQuery;
      Try
        qryGen.First;

        While Not qryGen.Eof Do
        Begin
          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          With cdsCliNeg Do
          Begin
            If (Not Locate('CLI_CODCLI', qryGen.FieldByName('CODCLI').AsString, []))       And
               fVerificaNegociacoes(qryGen.FieldByName('CODCLI').AsString, dbeCodNeg.Text) Then
            Begin
              qryItens.Close;
              qryItens.SQL.Clear;
              qryItens.SQL.Add(fRetornaSQLUltimaVenda);
              qryItens.ParamByName('CODCLI').AsString := qryGen.FieldByName('CODCLI').AsString;
              qryItens.Open;

              Insert;
              FieldByName('CLI_CODCLI').AsString := qryGen.FieldByName('CODCLI').AsString;
              FieldByName('NOMCLI').AsString := qryGen.FieldByName('NOMCLI').AsString;
              FieldByName('NOMATI').AsString := qryGen.FieldByName('NOMATI').AsString;
              FieldByName('NOMCID').AsString := qryGen.FieldByName('NOMCID').AsString;
              FieldByName('CGCCPF').AsString := qryGen.FieldByName('CGCCPF').AsString;

              FieldByName('NUMDOC').AsString := qryItens.FieldByName('NUMDOC').AsString;
              FieldByName('ESPDOC').AsString := qryItens.FieldByName('ESPDOC').AsString;
              FieldByName('DTAUCP').AsString := qryItens.FieldByName('DTAUCP').AsString;
              Post;
            End;
          End;

          qryGen.Next;
        End;

        Result := True;
      Finally
        FreeAndNil(qryItens);
      End;
    End;

    pEnableControls(cdsCliNeg, prcScroll);

    cxGridClientes.Enabled := True;
    cxGridClientes.Refresh;
    btnCancelCli.Click;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadNegociacaoClientes.fAdicionaProdutos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryGen : TUniQuery;
    strSQL,
    strMsgCli,
    strMsgPro,
    strSQLLinGru: String;
    prcScroll: TprcScroll;
    intCnt: Integer;
begin
  Result := False;

  qryGen := fCriaQuery;

  If Not cdsIteNeg.Active Then
    cdsIteNeg.Open;

  pDisableControls(cdsIteNeg, prcScroll);
  cxGridProdutos.Enabled := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_CODITE,    ';
  strSQL := strSQL + '  ITE_DESITE,    ';
  strSQL := strSQL + '  COALESCE(UNI_SIGUNI, "") AS UNI_SIGUNI, ';
  strSQL := strSQL + '  0.00 AS PERITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE C  ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI)  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If (Not fEmptyStr(edtMarca.Text)) Then
    strSQL := strSQL + fStrLocate(edtMarca,arrMarca,'ITE_CODMAR','CODMAR');

  If Not fEmptyStr(edtFornecedor.Text) Then
    strSQL := strSQL + fStrLocate(edtFornecedor,arrFornecedor,'ITE_CODFOR','CODFOR');

  strSQLLinGru := '';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    If Length(arrLinhaGrupo) > 1 Then
    Begin
      For intCnt := Low(arrLinhaGrupo) To High(arrLinhaGrupo) Do
      Begin
        If Not fEmptyStr(arrLinhaGrupo[intCnt].strCodigo) Then
        Begin
          If Not fEmptyStr(strSQLLinGru) Then
            strSQLLinGru := strSQLLinGru + ' OR ';

          If RightStr(arrLinhaGrupo[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + '(LEFT(ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrLinhaGrupo[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + '(ITE_CODGRU = ' + QuotedStr(arrLinhaGrupo[intCnt].strCodigo) + ')';
        End;
      End;

      If Not fEmptyStr(strSQLLinGru) Then
        strSQL := strSQL + ' AND (' + strSQLLinGru + ') ';
    End
    Else
    Begin
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    End;
  End;

  If Not fEmptyStr(edtCodIte.Text) Then
    strSQL := strSQL + fStrLocate(edtCodIte,arrProdutos,'ITE_CODITE','CODITE');

  If Not fEmptyStr(edtCodUni.Text) Then
    strSQL := strSQL + fStrLocate(edtCodUni, arrUni, 'ITE_CODUNI', 'CODUNI');

  strSQL := strSQL + ' ORDER BY ITE_DESITE ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not fEmptyStr(edtMarca.Text)) Then
      pSetaParam(edtMarca.Text,arrMarca,strMarca,'CODMAR', qryGen);

    If Not fEmptyStr(edtFornecedor.Text) Then
      pSetaParam(edtFornecedor.Text,arrFornecedor,strFornecedor,'CODFOR', qryGen);

    pSetaParam(mskLinhaGrupo.Text,arrLinhaGrupo,strLinhaGrupo,'CODGRU', qryGen);

    If Not fEmptyStr(edtCodIte.Text) Then
      pSetaParam(edtCodIte.Text,arrProdutos,strProdutos,'CODITE', qryGen);

    If Not fEmptyStr(edtCodUni.Text) Then
      pSetaParam(edtCodUni.Text,arrUni,strUni,'CODUNI', qryGen);

    Open;
  End;

  If qryGen.RecordCount = 0 Then
    fMensagem('','Nenhum Produto foi encontrado!',['&O K'], 0)
  Else
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Produtos...', qryGen.RecordCount);

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      With cdsIteNeg Do
      Begin
        If (Not Locate('ITE_CODITE', qryGen.FieldByName('ITE_CODITE').AsString, [])) And
           (Not TCadNegBussiness.fItemCadastradoNegociacao(dbeCodNeg.Text,
                                                           fCodCli,
                                                           cdsIteNeg.FieldByName('ITE_CODITE').AsString,
                                                           fGetTabelasPrecoSelecionadas,
                                                           strMsgCli,
                                                           strMsgPro)) Then
        Begin
          Insert;
          FieldByName('ITE_CODITE').AsString := qryGen.FieldByName('ITE_CODITE').AsString;
          FieldByName('ITE_DESITE').AsString := qryGen.FieldByName('ITE_DESITE').AsString;
          FieldByName('UNI_SIGUNI').AsString := qryGen.FieldByName('UNI_SIGUNI').AsString;
          FieldByName('PERITE').AsFloat      := edtDescIte.Value;
          Post;
        End;
      End;

      qryGen.Next;
    End;

    Result := True;
  End;

  pEnableControls(cdsIteNeg, prcScroll);

  cxGridProdutos.Enabled := True;
  cxGridProdutos.Refresh;
  btnCancIte.Click;
  FreeAndNil(qryGen);
end;

function TfrmCadNegociacaoClientes.fAdicionaProdutosQtd(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryGen : TUniQuery;
    strSQL,
    strSQLLinGru: String;
    prcScroll: TprcScroll;
    intCnt: Integer;
begin
  Result := False;

  qryGen := fCriaQuery;

  If Not cdsQtdNeg.Active Then
    cdsQtdNeg.Open;

  pDisableControls(cdsQtdNeg, prcScroll);
  cxGridProdutosQtd.Enabled := False;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_CODITE,    ';
  strSQL := strSQL + '  ITE_DESITE,    ';
  strSQL := strSQL + '  COALESCE(UNI_SIGUNI, "") AS UNI_SIGUNI, ';
  strSQL := strSQL + '  0.00 AS PERITE, ';
  strSQL := strSQL + '  0.00 AS QTDITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE C  ';
  strSQL := strSQL + '  LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI)  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If (Not fEmptyStr(edtMarcaQtd.Text)) Then
    strSQL := strSQL + fStrLocate(edtMarcaQtd,arrMarcaQtd,'ITE_CODMAR','CODMAR');

  If Not fEmptyStr(edtFornecedorQtd.Text) Then
    strSQL := strSQL + fStrLocate(edtFornecedorQtd,arrFornecedorQtd,'ITE_CODFOR','CODFOR');

  strSQLLinGru := '';

  If Not fEmptyStr(mskLinhaGrupoQtd.Text) Then
  Begin
    If Length(arrLinhaGrupoQtd) > 1 Then
    Begin
      For intCnt := Low(arrLinhaGrupoQtd) To High(arrLinhaGrupoQtd) Do
      Begin
        If Not fEmptyStr(arrLinhaGrupoQtd[intCnt].strCodigo) Then
        Begin
          If Not fEmptyStr(strSQLLinGru) Then
            strSQLLinGru := strSQLLinGru + ' OR ';

          If RightStr(arrLinhaGrupoQtd[intCnt].strCodigo,3) = '000' Then
            strSQLLinGru := strSQLLinGru + '(LEFT(ITE_CODGRU,3) = ' + QuotedStr(LeftStr(arrLinhaGrupoQtd[intCnt].strCodigo,3)) + ')'
          Else
            strSQLLinGru := strSQLLinGru + '(ITE_CODGRU = ' + QuotedStr(arrLinhaGrupoQtd[intCnt].strCodigo) + ')';
        End;
      End;

      If Not fEmptyStr(strSQLLinGru) Then
        strSQL := strSQL + ' AND (' + strSQLLinGru + ') ';
    End
    Else
    Begin
      If RightStr(mskLinhaGrupoQtd.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    End;
  End;

  If Not fEmptyStr(edtCodIteQtd.Text) Then
    strSQL := strSQL + fStrLocate(edtCodIteQtd,arrProdutosQtd,'ITE_CODITE','CODITE');

  If Not fEmptyStr(edtCodUniQtd.Text) Then
    strSQL := strSQL + fStrLocate(edtCodUniQtd, arrUniQtd, 'ITE_CODUNI', 'CODUNI');

  strSQL := strSQL + ' ORDER BY ITE_DESITE ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not fEmptyStr(edtMarcaQtd.Text)) Then
      pSetaParam(edtMarcaQtd.Text,arrMarcaQtd,strMarca,'CODMAR', qryGen);

    If Not fEmptyStr(edtFornecedorQtd.Text) Then
      pSetaParam(edtFornecedorQtd.Text,arrFornecedorQtd,strFornecedor,'CODFOR', qryGen);

    pSetaParam(mskLinhaGrupoQtd.Text,arrLinhaGrupoQtd,strLinhaGrupo,'CODGRU', qryGen);

    If Not fEmptyStr(edtCodIteQtd.Text) Then
      pSetaParam(edtCodIteQtd.Text,arrProdutosQtd,strProdutos,'CODITE', qryGen);

    If Not fEmptyStr(edtCodUniQtd.Text) Then
      pSetaParam(edtCodUniQtd.Text,arrUniQtd,strUni,'CODUNI', qryGen);

    Open;
  End;

  If qryGen.RecordCount = 0 Then
    fMensagem('','Nenhum Produto foi encontrado!',['&O K'], 0)
  Else
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Produtos...', qryGen.RecordCount);

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      With cdsQtdNeg Do
      Begin
         //If (Not Locate('ITE_CODITE', qryGen.FieldByName('ITE_CODITE').AsString, [])) And
         If (Not Locate('ITE_CODITE;QTDITE', VarArrayOf([qryGen.FieldByName('ITE_CODITE').AsString, edtQtdIte.Value]), [])) And
           (Not TCadNegBussiness.fItemQtdCadastradoNegociacao(dbeCodNeg.Text,
                                                              fCodCli,
                                                              qryGen.FieldByName('ITE_CODITE').AsString,
                                                              edtQtdIte.Value)) Then
        Begin
          Insert;
          FieldByName('ITE_CODITE').AsString := qryGen.FieldByName('ITE_CODITE').AsString;
          FieldByName('ITE_DESITE').AsString := qryGen.FieldByName('ITE_DESITE').AsString;
          FieldByName('UNI_SIGUNI').AsString := qryGen.FieldByName('UNI_SIGUNI').AsString;
          FieldByName('PERITE').AsFloat      := edtDescIteQtd.Value;
          FieldByName('QTDITE').AsFloat      := edtQtdIte.Value;
          Post;
        End;
      End;

      qryGen.Next;
    End;

    Result := True;
  End;

  pEnableControls(cdsQtdNeg, prcScroll);

  cxGridProdutosQtd.Enabled := True;
  cxGridProdutosQtd.Refresh;
  btnCancQtdIte.Click;
  FreeAndNil(qryGen);
end;

function TfrmCadNegociacaoClientes.fCarregaClientesNegociacao(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryItens : TUniQuery;
begin
  Try
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Clientes...', 1);

    If cdsCliNeg.Active Then
      cdsCliNeg.EmptyDataSet;

    With qryCliNeg Do
    Begin
      If cdsCliNeg.Active Then
        cdsCliNeg.Close;

      Close;

      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  P.*, ');
      SQL.Add('  C.CLI_NOMCLI AS NOMCLI, ');
      SQL.Add('  A.ATI_DESATI AS NOMATI, ');
      SQL.Add('  CONCAT(D.CID_NOMCID," - ",D.CID_ESTADO) AS NOMCID, ');
      SQL.Add('  C.CLI_C_G_C_ AS CGCCPF, ');
      SQL.Add('  "" AS NUMDOC, ');
      SQL.Add('  "" AS ESPDOC, ');
      SQL.Add('  "" AS DTAUCP ');
      SQL.Add('FROM ');
      SQL.Add('  CLINEG P, ');
      SQL.Add('  CADCLI C, ');
      SQL.Add('  CADATI A, ');
      SQL.Add('  CADCID D ');
      SQL.Add('WHERE ');
      SQL.Add('  P.CLI_CODCLI = C.CLI_CODCLI AND ');
      SQL.Add('  C.CLI_CODATI = A.ATI_CODATI AND ');
      SQL.Add('  C.CLI_CODCID = D.CID_CODCID AND ');
      SQL.Add('  CLI_SEQGER = :SEQGER ');
      ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      pSetaClient(qryCliNeg);

      cdsCliNeg.SetProvider(dspCliNeg);
      cdsCliNeg.Open;
      pSetaClient(cdsCliNeg);

      qryItens := fCriaQuery;
      Try
        cdsCliNeg.First;
        While Not cdsCliNeg.Eof Do
        Begin
          qryItens.Close;
          qryItens.SQL.Clear;
          qryItens.SQL.Add(fRetornaSQLUltimaVenda);
          qryItens.ParamByName('CODCLI').AsString := cdsCliNeg.FieldByName('CLI_CODCLI').AsString;
          qryItens.Open;

          cdsCliNeg.Edit;
          cdsCliNeg.FieldByName('NUMDOC').AsString := qryItens.FieldByName('NUMDOC').AsString;
          cdsCliNeg.FieldByName('ESPDOC').AsString := qryItens.FieldByName('ESPDOC').AsString;
          cdsCliNeg.FieldByName('DTAUCP').AsString := qryItens.FieldByName('DTAUCP').AsString;
          cdsCliNeg.Post;

          cdsCliNeg.Next;
        End;
      Finally
        FreeAndNil(qryItens);
      End;

      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      Result := True;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmCadNegociacaoClientes.fCarregaPoliticasCompras(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryTmp: TUniQuery;
begin
  Try
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Analisando Dados...', 1);

    If cdsCmpNeg.Active Then
      cdsCmpNeg.EmptyDataSet;

    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM CMPNEG WHERE CMP_SEQGER = :SEQGER');
      ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Política de Desconto por Data de Compra...', qryTmp.RecordCount);

      If Not IsEmpty Then
      Begin
        If Not cdsCmpNeg.Active Then
          cdsCmpNeg.Open;

        First;

        While Not Eof Do
        Begin
          cdsCmpNeg.Append;
          cdsCmpNeg.FieldByName('AUTOINCREM').AsString  := FieldByName('AUTOINCREM').AsString;
          cdsCmpNeg.FieldByName('CMP_SEQGER').AsString  := FieldByName('CMP_SEQGER').AsString;
          cdsCmpNeg.FieldByName('CMP_DIAINI').AsInteger := FieldByName('CMP_DIAINI').AsInteger;
          cdsCmpNeg.FieldByName('CMP_DIAFIM').AsInteger := FieldByName('CMP_DIAFIM').AsInteger;
          cdsCmpNeg.FieldByName('CMP_PERDES').AsFloat   := FieldByName('CMP_PERDES').AsFloat;
          cdsCmpNeg.FieldByName('CMP_ORDDES').AsInteger := FieldByName('CMP_ORDDES').AsInteger;
          cdsCmpNeg.Post;

          pStepStatusGravacao(pgbStatus);
          Application.ProcessMessages;

          Next;
        End;
      End;

      Result := True;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryTmp);
  pCalculaTotal;
end;

function TfrmCadNegociacaoClientes.fCarregaProdutosNegociacao(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Try
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produtos...', 1);

    If cdsIteNeg.Active Then
      cdsIteNeg.EmptyDataSet;

    With qryIteNeg Do
    Begin
      If cdsIteNeg.Active Then
        cdsIteNeg.Close;

      Close;

      SQL.Clear;
      SQL.Add('SELECT I.*, ');
      SQL.Add('  C.ITE_DESITE,  ');
      SQL.Add('  C.ITE_DESITE,  ');
      SQL.Add('  COALESCE(U.UNI_SIGUNI, "") AS UNI_SIGUNI, ');
      SQL.Add('  ITE_PERITE AS PERITE ');
      SQL.Add('FROM ');
      SQL.Add('  ITENEG I ');
      SQL.Add('JOIN CADITE C ON (C.ITE_CODITE = I.ITE_CODITE) ');
      SQL.Add('LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ');
      SQL.Add('WHERE ITE_SEQGER = :SEQGER ');

      ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      Open;
      pSetaClient(qryIteNeg);

      cdsIteNeg.SetProvider(dspIteNeg);
      cdsIteNeg.Open;
      pSetaClient(cdsIteNeg);

      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      Result := True;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmCadNegociacaoClientes.fCarregaPoliticasQuantidade(pgbStatus: TcxProgressBar): Boolean;
begin
  Try
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Desconto Por Quantidade ...', 1);

    If cdsQtdNeg.Active Then
      cdsQtdNeg.EmptyDataSet;

    With qryQtdNeg Do
    Begin
      If cdsQtdNeg.Active Then
        cdsQtdNeg.Close;

      Close;

      SQL.Clear;
      SQL.Add('SELECT I.*, ');
      SQL.Add('  C.ITE_DESITE,  ');
      SQL.Add('  C.ITE_DESITE,  ');
      SQL.Add('  COALESCE(U.UNI_SIGUNI, "") AS UNI_SIGUNI, ');
      SQL.Add('  ITE_PERITE AS PERITE, ');
      SQL.Add('  ITE_QTDITE AS QTDITE ');
      SQL.Add('FROM ');
      SQL.Add('  QTDNEG I ');
      SQL.Add('JOIN CADITE C ON (C.ITE_CODITE = I.ITE_CODITE) ');
      SQL.Add('LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ');
      SQL.Add('WHERE ITE_SEQGER = :SEQGER ');

      ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      Open;

      Open;
      pSetaClient(qryQtdNeg);

      cdsQtdNeg.SetProvider(dspQtdNeg);
      cdsQtdNeg.Open;
      pSetaClient(cdsQtdNeg);

      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      Result := True;
    End;
  Except
    On E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
end;

function TfrmCadNegociacaoClientes.fCodCli: String;
  Var
    intRecNo: Integer;
Begin
  Result := '';

  With cdsCliNeg Do
  Begin
    DisableControls;
    intRecNo := RecNo;

    First;
    While Not Eof Do
    Begin
      Result := Result + '_' + FieldByName('CLI_CODCLI').AsString;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
end;

function TfrmCadNegociacaoClientes.fGetTabelasPrecoSelecionadas: String;
  Var
    intTabPre: Integer;
begin
  Result := '';

  For intTabPre := 1 To clbTabPre.Items.Count Do
    Result := Result + IIF(clbTabPre.Checked[intTabPre -1], 'S', 'N');
end;

function TfrmCadNegociacaoClientes.fGravaPoliticaClientes(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryInsert: TUniQuery;
Begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Cliente...', 1);
  pDeletaClientesPoliticas;
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  If cdsCliNeg.Active And (Not cdsCliNeg.IsEmpty) Then
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Cliente...', cdsCliNeg.RecordCount);

    qryInsert := fCriaQuery(Self);
    qryInsert.SQL.Text := 'SELECT * FROM CLINEG WHERE FALSE';
    qryInsert.Open;

    With cdsCliNeg Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);
        Application.ProcessMessages;

        qryInsert.Insert;
        qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLINEG', VS_strCodEmp);
        qryInsert.FieldByName('CLI_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryInsert.FieldByName('CLI_CODCLI').AsString := FieldByName('CLI_CODCLI').AsString;
        qryInsert.Post;

        Next;
      End;

      EnableControls;
    End;

    FreeAndNil(qryInsert);
  End;

  Result := True;
end;

function TfrmCadNegociacaoClientes.fGravaPoliticaCompras(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryInsert: TUniQuery;
Begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Política de Desconto por Data de Compra...', 1);
  pDeletaComprasPoliticas;
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  If cdsCmpNeg.Active And (Not cdsCmpNeg.IsEmpty) Then
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Política de Desconto por Data de Compra...', cdsCmpNeg.RecordCount);

    qryInsert := fCriaQuery(Self);
    qryInsert.SQL.Text := 'SELECT * FROM CMPNEG WHERE FALSE';
    qryInsert.Open;

    With cdsCmpNeg Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);
        Application.ProcessMessages;

        qryInsert.Insert;
        qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CMPNEG', VS_strCodEmp);
        qryInsert.FieldByName('CMP_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryInsert.FieldByName('CMP_DIAINI').AsString := FieldByName('CMP_DIAINI').AsString;
        qryInsert.FieldByName('CMP_DIAFIM').AsString := FieldByName('CMP_DIAFIM').AsString;
        qryInsert.FieldByName('CMP_PERDES').AsString := FieldByName('CMP_PERDES').AsString;
        qryInsert.FieldByName('CMP_ORDDES').AsString := FieldByName('CMP_ORDDES').AsString;
        qryInsert.Post;

        Next;
      End;

      EnableControls;
    End;

    FreeAndNil(qryInsert);
  End;

  Result := True;
end;

function TfrmCadNegociacaoClientes.fGravaPoliticaQuantidade(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryInsert: TUniQuery;
Begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Política de Desconto por Quantidade do Item...', 1);
  pDeletaQuantidadePoliticas;
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  If cdsQtdNeg.Active And (Not cdsQtdNeg.IsEmpty) Then
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Política de Desconto por Quantidade do Item...', cdsCmpNeg.RecordCount);

    qryInsert := fCriaQuery(Self);
    qryInsert.SQL.Text := 'SELECT * FROM QTDNEG WHERE FALSE';
    qryInsert.Open;

    With cdsQtdNeg Do
    Begin
      DisableControls;
      First;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);
        Application.ProcessMessages;

        qryInsert.Insert;
        qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('QTDNEG', VS_strCodEmp);
        qryInsert.FieldByName('ITE_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryInsert.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        qryInsert.FieldByName('ITE_QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat;
        qryInsert.FieldByName('ITE_PERITE').AsFloat  := FieldByName('PERITE').AsFloat;
        qryInsert.Post;

        Next;
      End;

      EnableControls;
    End;

    FreeAndNil(qryInsert);
  End;

  Result := True;
end;

function TfrmCadNegociacaoClientes.fGravaPoliticasProdutos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryInsert: TUniQuery;
    L: Integer;
Begin
  If fEmptyStr(fItensAlterados) And (fEmptyStr(fItensDeletados)) Then
  Begin
    Result := True;
    Exit;
  End;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Deletando Produtos...', 1);
  pDeletaProdutosPoliticas;
  pStepStatusGravacao(pgbStatus);
  Application.ProcessMessages;

  If cdsIteNeg.Active And (Not cdsIteNeg.IsEmpty) Then
  Begin
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Inserindo Produtos...', cdsIteNeg.RecordCount);

    qryInsert := fCriaQuery(Self);
    qryInsert.SQL.Text := 'SELECT * FROM ITENEG WHERE FALSE';
    qryInsert.Open;

    cdsIteNeg.DisableControls;

    cdsIteNeg.IndexFieldNames := 'ITE_CODITE';

    For L := 0 To stlItensAlterados.Count -1 Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If not cdsIteNeg.FindKey([stlItensAlterados[L]]) Then
      Begin
        Continue;
      End;

      Application.ProcessMessages;

      qryInsert.Insert;
      qryInsert.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITENEG', VS_strCodEmp);
      qryInsert.FieldByName('ITE_SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryInsert.FieldByName('ITE_CODITE').AsString := cdsIteNeg.FieldByName('ITE_CODITE').AsString;
      qryInsert.FieldByName('ITE_PERITE').AsFloat  := cdsIteNeg.FieldByName('PERITE').AsFloat;
      qryInsert.Post;
    End;

    cdsIteNeg.IndexFieldNames := '';

    cdsIteNeg.First;

    cdsIteNeg.EnableControls;

    FreeAndNil(qryInsert);
  End;

  Result := True;
end;

function TfrmCadNegociacaoClientes.fRepassaTabelas(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    intCont: Integer;
    cdsDesClone,
    cdsAcrClone: TUniClientDataSet;
begin
  inherited;

  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Repassando descontos/acréscimos para demais tabelas...', lstPolicaTabs.Count);

  cdsDesClone := TUniClientDataSet.Create(Self);
  cdsAcrClone := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsDesClone, lstPolicaTabs[pgcTabelas.ActivePageIndex].cdsDesconto);
  pCloneDataSet(cdsAcrClone, lstPolicaTabs[pgcTabelas.ActivePageIndex].cdsAcrescimo);

  For intCont := 0 To lstPolicaTabs.Count-1 Do
  Begin
    pStepStatusGravacao(pgbStatus);
    Application.ProcessMessages;

    If intCont = pgcTabelas.ActivePageIndex Then
      Continue;

    lstPolicaTabs[intCont].cdsDesconto.EmptyDataSet;
    lstPolicaTabs[intCont].cdsAcrescimo.EmptyDataSet;

    pCloneDataSet(lstPolicaTabs[intCont].cdsDesconto,  cdsDesClone);
    pCloneDataSet(lstPolicaTabs[intCont].cdsAcrescimo, cdsAcrClone);

    lstPolicaTabs[intCont].pCalculaTotal(lstPolicaTabs[intCont].cdsDesconto , tdDesconto);
    lstPolicaTabs[intCont].pCalculaTotal(lstPolicaTabs[intCont].cdsAcrescimo, tdAcrescimo);

    With lstPolicaTabs[intCont].cdsDesconto Do
    Begin
      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          Edit;
          FieldByName('AUTOINCREM').AsString := '';
          Post;

          Next;
        End;
      End;
    End;

    With lstPolicaTabs[intCont].cdsAcrescimo Do
    Begin
      If Not IsEmpty Then
      Begin
        First;

        While Not Eof Do
        Begin
          Edit;
          FieldByName('AUTOINCREM').AsString := '';
          Post;

          Next;
        End;
      End;
    End;
  End;

  FreeAndNil(cdsDesClone);
  FreeAndNil(cdsAcrClone);
end;

function TfrmCadNegociacaoClientes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  function fCheckRange(fltFat: Double): Boolean;
    Var
      cdsAux  : TUniClientDataSet;
      oldState: TDataSetState;
  begin
    Result := True;

    cdsAux := TUniClientDataSet.Create(Self);

    Try
      oldState := cdsCmpNeg.State;

      pCloneDataSet(cdsAux, cdsCmpNeg);

      If oldState = dsEdit Then
        cdsCmpNeg.Edit;

      cdsAux.First;

      While Not cdsAux.Eof Do
      Begin
        If (cdsAux.FieldByName('CMP_ORDDES').AsInteger = intOrdDes) Then
        Begin
          cdsAux.Next;
          Continue;
        End;

        If (fltFat >= cdsAux.FieldByName('CMP_DIAINI').AsFloat) And (fltFat <= cdsAux.FieldByName('CMP_DIAFIM').AsFloat) Then
        Begin
          Result := False;
          Exit;
        End;

        cdsAux.Next;
      End;
    Finally
      FreeAndNil(cdsAux);
    End;
  end;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodNeg) And (Not blnUsaProCodigo) Then
    Begin
      If fEmptyStr(dbeCodNeg.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um código', ['&OK']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        fBuscaPorCamposChave;
      End;
    End
    Else If (Sender = dbeDesNeg) Then
    Begin
      If fEmptyStr(dbeDesNeg.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina uma descrição', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = rdgStatus) Then
    Begin
      If rdgStatus.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um Status', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = clbTabPre) Then
    Begin
      If Pos('S', fGetTabelasPrecoSelecionadas) <= 0 Then
      Begin
        fMensagem('ATENÇÃO','Selecione ao menos uma tabela de preço para a negociação!', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = mskLinhaGrupo) Then
    Begin
      If fEmptyStr(mskLinhaGrupo.Text) Then
        edtCodIte.Enabled := True
      Else
        edtCodIte.Enabled := False;

      pDesmarcaLista(mskLinhaGrupo,arrLinhaGrupo,'',6);
    End
    Else If (Sender = mskLinhaGrupoQtd) Then
    Begin
      If fEmptyStr(mskLinhaGrupoQtd.Text) Then
        edtCodIteQtd.Enabled := True
      Else
        edtCodIteQtd.Enabled := False;

      pDesmarcaLista(mskLinhaGrupoQtd,arrLinhaGrupoQtd,'',6);
    End
    Else If (Sender = edtCodIte) Then
      pDesmarcaLista(edtCodIte,arrProdutos)
    Else If (Sender = edtCodIteQtd) Then
      pDesmarcaLista(edtCodIteQtd,arrProdutosQtd)
    Else If (Sender = edtMarca) Then
      pDesmarcaLista(edtMarca,arrMarca)
    Else If (Sender = edtMarcaQtd) Then
      pDesmarcaLista(edtMarcaQtd,arrMarcaQtd)
    Else If (Sender = edtFornecedor) Then
      pDesmarcaLista(edtFornecedor,arrFornecedor)
    Else If (Sender = edtFornecedorQtd) Then
      pDesmarcaLista(edtFornecedorQtd,arrFornecedorQtd)
    Else If (Sender = edtCodUni) Then
      pDesmarcaLista(edtCodUni,arrUni)
    Else If (Sender = edtCodUniQtd) Then
      pDesmarcaLista(edtCodUniQtd,arrUniQtd)
    Else If (Sender = edtDescIteQtd) And blnBuscaPorChave Then
    Begin
      If edtDescIteQtd.Value = 0 Then
      Begin
        fMensagem('ATENÇÃO','Defina um desconto para o(s) item(s) a serem adicionado(s)!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If edtDescIteQtd.Value < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de desconto do(s) item(s) deve ser maior ou igual a que zero.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtQtdIte) And blnBuscaPorChave Then
    Begin
      If edtQtdIte.Value = 0 Then
      Begin
        fMensagem('ATENÇÃO','Defina a quantidade mínima para aplicação do desconto!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If edtQtdIte.Value < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'A quantidade mínima para aplicação do desconto deve ser maior ou igual a que zero.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodCid) Then
      pDesmarcaLista(edtCodCid,arrCidade)
    Else If (Sender = edtCodCli) Then
    Begin
      pDesmarcaLista(edtCodCli,arrCliente);

      If (Not fEmptyStr(edtCodCli.Text)) And
         (edtCodCli.Text <> '00000000')  Then
      Begin
        pBuscaDadosCliente;

        If (fEmptyStr(edtNomCli.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Este cliente não está cadastrado!',['&O K']);
          Result := False;
        End
      End;
    End
    Else If (Sender = edtCodAti) Then
      pDesmarcaLista(edtCodAti,arrLinAti)
    Else If (Sender = edtCgcCpf) And (edtCgcCpf.Enabled) Then
    Begin
      If Not fEmptyStr(edtCgcCpf.Text)Then
      Begin
        If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
        Begin
          edtCgcCpf.Text := '';
          Result := False;
        End;
      End;
    End
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
    Else If (Sender = edtDiaIni) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDiaIni.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um dia inicial.', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If (Not fValidaEscala(edtDiaIni.Text, 1, 31)) Then
        Begin
          fMensagem('ATENÇÃO', 'Defina um dia válido de 1 a 31.', ['&OK']);
          Result := False;
        End
        Else If Not fCheckRange(fStrToFloat(edtDiaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Dia inicial inválido! Já existe um intervalo contendo o valor especificado.',['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtDiaFim) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtDiaFim.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um dia final.', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If (Not fValidaEscala(edtDiaFim.Text, 1, 31)) Then
        Begin
          fMensagem('ATENÇÃO', 'Defina um dia válido de 1 a 31.', ['&OK']);
          Result := False;
        End
        Else If StrToInt(edtDiaFim.Text) < StrToInt(edtDiaIni.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'O dia final precisa ser maior que o dia inicial.', ['&OK']);
          Result := False;
        End
        Else If Not fCheckRange(fStrToFloat(edtDiaFim.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Dia final inválido! Já existe um intervalo contendo o valor especificado.',['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtPerDesCmp) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtPerDesCmp.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Defina um percentual de desconto.', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If edtPerDesCmp.Value <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'O percentual de desconto deve ser maior que zero.', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else if (Sender = edtCodRegiao) then
    Begin
      pDesmarcaLista(edtCodRegiao,arrRegiao);
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadNegociacaoClientes.fValidandoGravacao(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    strMsgCli,
    strMsgPro,
    strMsgCliFinal,
    strMsgProFinal: String;
    prcScroll: TprcScroll;
    L: Integer;
begin
  Result := True;

  strMsgCli := '';
  strMsgPro := '';
  strMsgCliFinal := '';
  strMsgProFinal := '';

  pDisableControls(cdsIteNeg, prcScroll);

  cdsIteNeg.IndexFieldNames := 'ITE_CODITE';

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Validando itens da Negociação...', stlItensAlterados.Count);

  For L := 0 To stlItensAlterados.Count -1 Do
  Begin
    pStepStatusGravacao(pgbStatus);

    If not cdsIteNeg.FindKey([stlItensAlterados[L]]) Then
    Begin
      Continue;
    End;

    Application.ProcessMessages;

    If TCadNegBussiness.fItemCadastradoNegociacao(dbeCodNeg.Text,
                                                  fCodCli,
                                                  cdsIteNeg.FieldByName('ITE_CODITE').AsString,
                                                  fGetTabelasPrecoSelecionadas,
                                                  strMsgCli,
                                                  strMsgPro) Then
    Begin
      If Not fEmptyStr(strMsgCli) Then
        strMsgCliFinal := strMsgCliFinal + strMsgCli + #13#10;

      If Not fEmptyStr(strMsgPro) Then
        strMsgProFinal := strMsgProFinal + strMsgPro + #13#10;
    End;
  End;

  cdsIteNeg.IndexFieldNames := '';

  cdsIteNeg.First;

  If Not fEmptyStr(strMsgProFinal) Then
  Begin
    Result := False;

    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);

      If Not fEmptyStr(strMsgCliFinal) Then
      Begin
        frmObservacao.lblMensagem.Caption := 'Os itens abaixo já estão incluídos para esse cliente em outras promoções vigentes:';
        frmObservacao.memObs.Texto := 'Cliente: ' + Chr(13) + strMsgCliFinal + Chr(13) + Chr(13) + 'Produtos: ' + Chr(13) + strMsgProFinal;
      End
      Else
      Begin
        frmObservacao.lblMensagem.Caption := 'Promoção não incluída! O(s) item(s) abaixo já estão em outras promoções vigentes:';
        frmObservacao.memObs.Texto := strMsgProFinal;
      End;

      frmObservacao.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadNegociacaoClientes.fValidandoGravacao]');
    End;

    pFreeAndNil(frmObservacao);
  End;

  pnlInfo.Caption := '';
  pEnableControls(cdsIteNeg, prcScroll);
end;

function TfrmCadNegociacaoClientes.fVerificaNegociacoes(strCodCli,
  strCodNeg: String): Boolean;
  Var
    strMsgCli,
    strMsgPro,
    strMsgCliFinal,
    strMsgProFinal: String;
Begin
  Result    := True;
  strMsgCli := '';
  strMsgPro := '';
  strMsgCliFinal := '';
  strMsgProFinal := '';

  cdsIteNeg.First;

  While Not cdsIteNeg.Eof Do
  Begin
    If (TCadNegBussiness.fItemCadastradoNegociacao(strCodNeg,
                                                   strCodCli,
                                                   cdsIteNeg.FieldByName('ITE_CODITE').AsString,
                                                   fGetTabelasPrecoSelecionadas,
                                                   strMsgCli,
                                                   strMsgPro)) Then
    Begin
      If Not fEmptyStr(strMsgCli) Then
        strMsgCliFinal := strMsgCliFinal + strMsgCli + #13#10;

      If Not fEmptyStr(strMsgPro) Then
        strMsgProFinal := strMsgProFinal + strMsgPro + #13#10;
    End;

    cdsIteNeg.Next;
  End;

  If Not fEmptyStr(strMsgProFinal) Then
  Begin
    Result := False;

    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);

      If Not fEmptyStr(strMsgCliFinal) Then
      Begin
        frmObservacao.lblMensagem.Caption := 'Os itens abaixo já estão incluídos para esse cliente em outras promoções vigentes:';
        frmObservacao.memObs.Texto := 'Cliente: ' + Chr(13) + strMsgCliFinal + Chr(13) + Chr(13) + 'Produtos: ' + Chr(13) + strMsgProFinal;
      End
      Else
      Begin
        frmObservacao.lblMensagem.Caption := 'Cliente não incluído! O(s) item(s) abaixo já estão em outras promoções vigentes:';
        frmObservacao.memObs.Texto := strMsgProFinal;
      End;

      frmObservacao.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadNegociacaoClientes.fVerificaNegociacoes]');
    End;

    pFreeAndNil(frmObservacao);
  End;
end;

procedure TfrmCadNegociacaoClientes.pAdicionaPoliticaDescCompra;
  procedure pAddItem;
  Begin
    If cdsCmpNeg.State = dsEdit Then
    Begin
      cdsCmpNeg.FieldByName('CMP_DIAINI').AsInteger := StrToInt(edtDiaIni.Text);
      cdsCmpNeg.FieldByName('CMP_DIAFIM').AsInteger := StrToInt(edtDiaFim.Text);
      cdsCmpNeg.FieldByName('CMP_PERDES').AsFloat   := edtPerDesCmp.Value;
      cdsCmpNeg.Post;
    End
    Else
    Begin
      With cdsCmpNeg Do
      Begin
        Append;
        FieldByName('AUTOINCREM').AsString  := '';
        FieldByName('CMP_SEQGER').AsString  := '';
        FieldByName('CMP_DIAINI').AsInteger := StrToInt(edtDiaIni.Text);
        FieldByName('CMP_DIAFIM').AsInteger := StrToInt(edtDiaFim.Text);
        FieldByName('CMP_PERDES').AsFloat   := edtPerDesCmp.Value;
        FieldByName('CMP_ORDDES').AsInteger := cdsCmpNeg.RecordCount + 1;
        Post;
      End;
    End;

    pCalculaTotal;
  End;
begin
  If fValidaCampos(edtDiaIni, True)    And
     fValidaCampos(edtDiaFim, True)    And
     fValidaCampos(edtPerDesCmp, True) Then
  Begin
    pAddItem;
    pCancelaPoliticaDescCompra;
  End;
end;

procedure TfrmCadNegociacaoClientes.pAfterScroll;
Begin
  pMarcarTabelasPreco(qryTabela.FieldByName('NEG_TABPRE').AsString);

  With qryTabela Do
  Begin
    pnlCabecalho.Enabled      := (State In [dsInsert, dsEdit]);
    pnlTabelas.Enabled        := (State In [dsInsert, dsEdit]);
    pnlFiltros.Enabled        := (State In [dsInsert, dsEdit]);
    pnlFiltrosQtd.Enabled     := (State In [dsInsert, dsEdit]);
    pnlTabPrecos.Enabled      := (State In [dsInsert, dsEdit]);
    pnlDataCompra.Enabled     := (State In [dsInsert, dsEdit]);
    pnlPesqCli.Enabled        := (State In [dsInsert, dsEdit]);
    cxGridClientes.Enabled    := (State In [dsInsert, dsEdit]);
    cxGridProdutos.Enabled    := (State In [dsInsert, dsEdit]);
    cxGridProdutosQtd.Enabled := (State In [dsInsert, dsEdit]);

    pgcTabelas.ActivePageIndex := 0
  End;
end;

procedure TfrmCadNegociacaoClientes.pAfterScrollCompras(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('CMP_PERDES') <> nil Then
      TFloatField(FieldByName('CMP_PERDES')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmCadNegociacaoClientes.pAfterOpenItens(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('PERITE') <> nil Then
      TFloatField(FieldByName('PERITE')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TfrmCadNegociacaoClientes.pAtualizaOrdenacao(intOrdTmp: Integer;
  blnCima: Boolean);
begin
  With cdsCmpNeg Do
  Begin
    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('CMP_ORDDES').AsInteger := RecNo-1;
      Post;

      Next;
    End;
  End;
end;

procedure TfrmCadNegociacaoClientes.pBeforeDeleteItens(DataSet: TDataSet);
begin
  If stlItensDeletados.IndexOf(cdsIteNeg.FieldByName('ITE_CODITE').AsString) = -1 Then
    stlItensDeletados.Add(cdsIteNeg.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmCadNegociacaoClientes.pBeforePostItens(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FieldByName('PERITE').AsFloat < 0 Then
      FieldByName('PERITE').AsFloat := 0;
  End;

  If stlItensAlterados.IndexOf(cdsIteNeg.FieldByName('ITE_CODITE').AsString) = -1 Then
    stlItensAlterados.Add(cdsIteNeg.FieldByName('ITE_CODITE').AsString);

  If stlItensDeletados.IndexOf(cdsIteNeg.FieldByName('ITE_CODITE').AsString) = -1 Then
    stlItensDeletados.Add(cdsIteNeg.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmCadNegociacaoClientes.pBuscaDadosCliente;
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
    strSQL := strSQL + '  ATI_DESATI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI C LEFT JOIN CADATI A ON C.CLI_CODATI = A.ATI_CODATI ';
    strSQL := strSQL + '           LEFT JOIN CADCID D ON C.CLI_CODCID = D.CID_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := edtCodCli.Text;
      Open;

      If Not IsEmpty Then
      Begin
        edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
        edtCodAti.Text := FieldByName('CLI_CODATI').AsString;
        edtDesAti.Text := FieldByName('ATI_DESATI').AsString;
        edtCodCid.Text := FieldByName('CLI_CODCID').AsString;
        edtDesCid.Text := FieldByName('CID_NOMCID').AsString;
        edtEstado.Text := FieldByName('CID_ESTADO').AsString;
        edtCgcCpf.Text := FieldByName('CLI_CGCCPF').AsString;
        edtNuCnPj.Text := FieldByName('CLI_C_G_C_').AsString;
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
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryGenCli);
  End;
end;

procedure TfrmCadNegociacaoClientes.pCalculaTotal;
  Var
    prcScroll: TprcScroll;
    fltTotal : Double;
Begin
  fltTotal := 0.00;
  pDisableControls(cdsCmpNeg, prcScroll);

  With cdsCmpNeg Do
  Begin
    First;

    While Not Eof Do
    Begin
      fltTotal := fltTotal + FieldByName('CMP_PERDES').AsFloat;
      Next;
    End;
  End;

  pEnableControls(cdsCmpNeg, prcScroll);

  lblTotalCmp.Caption := FormatFloat('#,##0.00', fltTotal);
End;

procedure TfrmCadNegociacaoClientes.pCancelaCliente;
  Var
    intContador : Integer;
begin
  SetLength(arrCliente, 0);
  SetLength(arrRede, 0);
  SetLength(arrLinAti, 0);
  SetLength(arrCidade, 0);
  SetLength(arrRegiao, 0);

  strCliente := '';
  strRede := '';
  strLinAti := '';
  strCidade := '';
  strRegiao := '';

  For intContador := 0 To pnlPesqCli.ControlCount - 1 Do
  Begin
    If pnlPesqCli.Enabled Then
    Begin
      If pnlPesqCli.Controls[intContador] is TMaskEdit Then
        TMaskEdit(pnlPesqCli.Controls[intContador]).Clear;
      If (pnlPesqCli.Controls[intContador] is TEditFocus) And (pnlPesqCli.Controls[intContador].Name <> 'edtCgcCpf') Then
        TEditFocus(pnlPesqCli.Controls[intContador]).Clear;
    End;
  End;

  If (pnlPesqCli.Enabled) Then
    pSetFocus(edtCodCli);
end;

procedure TfrmCadNegociacaoClientes.pCancelaItens;
  Var
    intContador : Integer;
begin
  SetLength(arrLinhaGrupo, 0);
  SetLength(arrProdutos, 0);
  SetLength(arrMarca, 0);
  SetLength(arrUni, 0);
  SetLength(arrFornecedor, 0);

  strLinhaGrupo := '';
  strProdutos := '';
  strMarca := '';
  strUni := '';
  strFornecedor := '';

  For intContador := 0 To pnlFiltros.ControlCount - 1 Do
  Begin
    If pnlFiltros.Enabled Then
    Begin
      If pnlFiltros.Controls[intContador] is TMaskEdit Then
        TMaskEdit(pnlFiltros.Controls[intContador]).Clear;
      If (pnlFiltros.Controls[intContador] is TEditFocus) Then
        TEditFocus(pnlFiltros.Controls[intContador]).Clear;
    End;
  End;

  edtDescIte.Value := 0;

  If (pnlFiltros.Enabled) Then
    pSetFocus(mskLinhaGrupo);
end;

procedure TfrmCadNegociacaoClientes.pCancelaItensQtd;
  Var
    intContador : Integer;
begin
  SetLength(arrLinhaGrupoQtd, 0);
  SetLength(arrProdutosQtd, 0);
  SetLength(arrMarcaQtd, 0);
  SetLength(arrUniQtd, 0);
  SetLength(arrFornecedorQtd, 0);

  strLinhaGrupo := '';
  strProdutos := '';
  strMarca := '';
  strUni := '';
  strFornecedor := '';

  For intContador := 0 To pnlFiltrosQtd.ControlCount - 1 Do
  Begin
    If pnlFiltrosQtd.Enabled Then
    Begin
      If pnlFiltrosQtd.Controls[intContador] is TMaskEdit Then
        TMaskEdit(pnlFiltrosQtd.Controls[intContador]).Clear;
      If (pnlFiltrosQtd.Controls[intContador] is TEditFocus) Then
        TEditFocus(pnlFiltrosQtd.Controls[intContador]).Clear;
    End;
  End;

  edtDescIteQtd.Value := 0;
  edtQtdIte.Value     := 0;

  If (pnlFiltrosQtd.Enabled) Then
    pSetFocus(mskLinhaGrupoQtd);

end;

procedure TfrmCadNegociacaoClientes.pCancelaPoliticaDescCompra;
begin
  edtDiaIni.Text := '';
  edtDiaFim.Text := '';
  edtPerDesCmp.Value := 0;
  pSetFocus(edtDiaIni);
  intOrdDes := -1;
end;

procedure TfrmCadNegociacaoClientes.pCarregaClientesNegociacao;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregaClientesNegociacao;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pCarregaItemAlteracaoCmp;
begin
  With cdsCmpNeg Do
  Begin
    If Not IsEmpty Then
    Begin
      Edit;
      edtDiaIni.Text     := FieldByName('CMP_DIAINI').AsString;
      edtDiaFim.Text     := FieldByName('CMP_DIAFIM').AsString;
      edtPerDesCmp.Value := FieldByName('CMP_PERDES').AsFloat;
      intOrdDes          := FieldByName('CMP_ORDDES').AsInteger;
      pSetFocus(edtDiaIni);
    End;
  End;
end;

procedure TfrmCadNegociacaoClientes.pCarregaPoliticasCompras;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregaPoliticasCompras;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pCarregaPoliticasQuantidade;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregaPoliticasQuantidade;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pCarregaProdutosNegociacao;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fCarregaProdutosNegociacao;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
End;

procedure TfrmCadNegociacaoClientes.pCarregaTabelas;
  Var
    intTabPre: Integer;
begin
  For intTabPre := 0 To Length(qryTabela.FieldByName('NEG_TABPRE').AsString)-1 Do
    clbTabPre.Checked[intTabPre] := qryTabela.FieldByName('NEG_TABPRE').AsString[intTabPre+1] = 'S';
end;

procedure TfrmCadNegociacaoClientes.pCarregaTodosDadosNegociacao(blnHeranca: Boolean = False);
begin
  stlItensAlterados.Clear;
  stlItensDeletados.Clear;
  pCarregaTabelas;
  pCarregaProdutosNegociacao;
  pCarregaClientesNegociacao;
  pSetaSequencialPoliiticaDesAcr(blnHeranca);
  pCarregaPoliticasCompras;
  pCarregaPoliticasQuantidade;
end;

procedure TfrmCadNegociacaoClientes.pCriaClientCliente;
begin
  dspCliNeg := TUniDataSetProvider.Create(Self);
  cdsCliNeg := TUniClientDataSet.Create(Self);
  cdsCliNeg.SetProvider(dspCliNeg);
  qryCliNeg := fCriaQuery(Self);
  dspCliNeg.DataSet := qryCliNeg;
  dtsCliNeg.DataSet := cdsCliNeg;

  With qryCliNeg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  P.*, ');
    SQL.Add('  C.CLI_NOMCLI AS NOMCLI, ');
    SQL.Add('  A.ATI_DESATI AS NOMATI, ');
    SQL.Add('  CONCAT(D.CID_NOMCID," - ",D.CID_ESTADO) AS NOMCID, ');
    SQL.Add('  C.CLI_C_G_C_ AS CGCCPF, ');
    SQL.Add('  "" AS NUMDOC, ');
    SQL.Add('  "" AS ESPDOC, ');
    SQL.Add('  "" AS DTAUCP ');
    SQL.Add('FROM ');
    SQL.Add('  CLINEG P, ');
    SQL.Add('  CADCLI C, ');
    SQL.Add('  CADATI A, ');
    SQL.Add('  CADCID D ');
    SQL.Add('WHERE ');
    SQL.Add('  P.CLI_CODCLI = C.CLI_CODCLI AND ');
    SQL.Add('  C.CLI_CODATI = A.ATI_CODATI AND ');
    SQL.Add('  C.CLI_CODCID = D.CID_CODCID AND ');
    SQL.Add('  FALSE ');
    Open;
  End;

  pSetaClient(qryCliNeg);

  cdsCliNeg.SetProvider(dspCliNeg);
  cdsCliNeg.Open;
  pSetaClient(cdsCliNeg);
end;

procedure TfrmCadNegociacaoClientes.pCriaClientCompra;
begin
  cdsCmpNeg := TUniClientDataSet.Create(Self);

  With cdsCmpNeg, FieldDefs Do
  Begin
    With AddFieldDef Do
    Begin
      Name := 'AUTOINCREM';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CMP_SEQGER';
      DataType := ftString;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CMP_DIAINI';
      DataType := ftInteger;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CMP_DIAFIM';
      DataType := ftInteger;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CMP_PERDES';
      DataType := ftFloat;
      Required := False;
    End;

    With AddFieldDef Do
    Begin
      Name := 'CMP_ORDDES';
      DataType := ftInteger;
      Required := False;
    End;

    IndexFieldNames := 'CMP_ORDDES';
    CreateDataSet;

    AfterScroll := pAfterScrollCompras;
  End;

  cdsCmpNeg.Open;
  dtsCmpNeg.DataSet := cdsCmpNeg;
end;

procedure TfrmCadNegociacaoClientes.pCriaClientProduto;
begin
  dspIteNeg := TUniDataSetProvider.Create(Self);
  cdsIteNeg := TUniClientDataSet.Create(Self);
  cdsIteNeg.SetProvider(dspIteNeg);
  qryIteNeg := fCriaQuery(Self);
  dspIteNeg.DataSet := qryIteNeg;
  dtsIteNeg.DataSet := cdsIteNeg;
  cdsIteNeg.AfterOpen  := pAfterOpenItens;
  cdsIteNeg.BeforePost := pBeforePostItens;
  cdsIteNeg.BeforeDelete := pBeforeDeleteItens;

  qryIteNeg.Close;
  qryIteNeg.SQL.Clear;
  qryIteNeg.SQL.Add('SELECT I.*, ');
  qryIteNeg.SQL.Add('  C.ITE_DESITE,  ');
  qryIteNeg.SQL.Add('  C.ITE_DESITE,  ');
  qryIteNeg.SQL.Add('  COALESCE(U.UNI_SIGUNI, "") AS UNI_SIGUNI, ');
  qryIteNeg.SQL.Add('  ITE_PERITE AS PERITE ');
  qryIteNeg.SQL.Add('FROM ');
  qryIteNeg.SQL.Add('  ITENEG I ');
  qryIteNeg.SQL.Add('JOIN CADITE C ON (C.ITE_CODITE = I.ITE_CODITE) ');
  qryIteNeg.SQL.Add('LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ');
  qryIteNeg.SQL.Add('WHERE FALSE');
  qryIteNeg.Open;

  pSetaClient(qryIteNeg);

  cdsIteNeg.SetProvider(dspIteNeg);
  cdsIteNeg.Open;
  pSetaClient(cdsIteNeg);
end;

procedure TfrmCadNegociacaoClientes.pCriaQuantidadeProduto;
begin
  dspQtdNeg := TUniDataSetProvider.Create(Self);
  cdsQtdNeg := TUniClientDataSet.Create(Self);
  cdsQtdNeg.SetProvider(dspQtdNeg);
  qryQtdNeg := fCriaQuery(Self);
  dspQtdNeg.DataSet := qryQtdNeg;
  dtsQtdNeg.DataSet := cdsQtdNeg;
  cdsQtdNeg.AfterOpen  := pAfterOpenItens;
  cdsQtdNeg.BeforePost := pBeforePostItens;

  qryQtdNeg.Close;
  qryQtdNeg.SQL.Clear;
  qryQtdNeg.SQL.Add('SELECT I.*, ');
  qryQtdNeg.SQL.Add('  C.ITE_DESITE,  ');
  qryQtdNeg.SQL.Add('  C.ITE_DESITE,  ');
  qryQtdNeg.SQL.Add('  COALESCE(U.UNI_SIGUNI, "") AS UNI_SIGUNI, ');
  qryQtdNeg.SQL.Add('  ITE_PERITE AS PERITE, ');
  qryQtdNeg.SQL.Add('  ITE_QTDITE AS QTDITE ');
  qryQtdNeg.SQL.Add('FROM ');
  qryQtdNeg.SQL.Add('  QTDNEG I ');
  qryQtdNeg.SQL.Add('JOIN CADITE C ON (C.ITE_CODITE = I.ITE_CODITE) ');
  qryQtdNeg.SQL.Add('LEFT JOIN CADUNI U ON (U.UNI_CODUNI = C.ITE_CODUNI) ');
  qryQtdNeg.SQL.Add('WHERE FALSE');
  qryQtdNeg.Open;

  pSetaClient(qryQtdNeg);

  cdsQtdNeg.SetProvider(dspQtdNeg);
  cdsQtdNeg.Open;
  pSetaClient(cdsQtdNeg);
end;

procedure TfrmCadNegociacaoClientes.pCriaTelaPoliticaTabs;
  Var
    intIndice: Integer;
    pnlPanel: TPanel;
    frmForm: TfrmPnlPoliticaDesAcr;

    function fGetPanel: TPanel;
    Begin
      Result := Nil;

      Case intIndice Of
        1: Result := pnlPoliticaTab1;
        2: Result := pnlPoliticaTab2;
        3: Result := pnlPoliticaTab3;
        4: Result := pnlPoliticaTab4;
        5: Result := pnlPoliticaTab5;
        6: Result := pnlPoliticaTab6;
        7: Result := pnlPoliticaTab7;
      End;
    End;

    procedure pMostraAbaTab(blnVisible: Boolean);
    Begin
      Case intIndice Of
        1: tbsTab1.TabVisible := blnVisible;
        2: tbsTab2.TabVisible := blnVisible;
        3: tbsTab3.TabVisible := blnVisible;
        4: tbsTab4.TabVisible := blnVisible;
        5: tbsTab5.TabVisible := blnVisible;
        6: tbsTab6.TabVisible := blnVisible;
        7: tbsTab7.TabVisible := blnVisible;
      End;

    End;
begin
  For intIndice := 1 To Length(strTabelas) Do
  Begin
    If strTabelas[intIndice] = 'S' Then
    Begin
      pnlPanel := fGetPanel;

      If pnlPanel <> Nil Then
      Begin
        pMostraAbaTab(True);

        pCriarFormularios(TfrmPnlPoliticaDesAcr, frmForm);

        frmForm.Align := alClient;
        frmForm.Dock(pnlPanel, pnlPanel.BoundsRect);
        frmForm.Show;

        lstPolicaTabs.Add(frmForm);
      End;
    End
    Else
      pMostraAbaTab(False);
  End;
end;

procedure TfrmCadNegociacaoClientes.pDeletaClientesPoliticas;
  Var
    strSQL   : String;
    qryGenNeg: TUniQuery;
begin
  Try
    qryGenNeg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CLINEG WHERE CLI_SEQGER = :AUTINC ';

    With qryGenNeg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryGenNeg);
  End;
end;

procedure TfrmCadNegociacaoClientes.pDeletaComprasPoliticas;
  Var
    strSQL   : String;
    qryGenNeg: TUniQuery;
begin
  Try
    qryGenNeg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CMPNEG WHERE CMP_SEQGER = :AUTINC ';

    With qryGenNeg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryGenNeg);
  End;
end;

procedure TfrmCadNegociacaoClientes.pDeletaQuantidadePoliticas;
  Var
    strSQL   : String;
    qryGenNeg: TUniQuery;
begin
  Try
    qryGenNeg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM QTDNEG WHERE ITE_SEQGER = :AUTINC ';

    With qryGenNeg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryGenNeg);
  End;
end;

procedure TfrmCadNegociacaoClientes.pDeletaProdutosPoliticas;
  Var
    strSQL   : String;
    qryGenNeg: TUniQuery;
    LCodIte: string;
begin
  LCodIte := fItensDeletados;

  If fEmptyStr(LCodIte) Then
    Exit;

  Try
    qryGenNeg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM ITENEG ';
    strSQL := strSQL + ' WHERE ITE_SEQGER = :AUTINC ';
    strSQL := strSQL + '   AND (LOCATE(ITE_CODITE, :CODITE) > 0) ';

    With qryGenNeg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ParamByName('CODITE').AsString := LCodIte;
      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryGenNeg);
  End;
end;

procedure TfrmCadNegociacaoClientes.pGravaPoliticaClientes;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGravaPoliticaClientes;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pGravaPoliticaCompras;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGravaPoliticaCompras;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pGravaPoliticaQuantidade;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGravaPoliticaQuantidade;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pGravaPoliticasDesAcr;
  Var
    frmAguarde: TfrmGravando;
    intIndex  : Integer;
    arrTabTmp : TStringArray;

  procedure pMontaArrayTab;
    Var
      intCont,
      intPos: Integer;
  Begin
    intPos := 0;
    SetLength(arrTabTmp, lstPolicaTabs.Count);

    For intCont := 1 To Length(VS_strTabVen) Do
    Begin
      If VS_strTabVen[intCont] = 'S' Then
      Begin
        arrTabTmp[intPos] := IntToStr(intCont);
        Inc(intPos);
      End;
    End;
  End;
begin
  pMontaArrayTab;

  Try
    For intIndex := 0 To lstPolicaTabs.Count-1 Do
    Begin
      lstPolicaTabs[intIndex].strSeqGer := qryTabela.FieldByName('AUTOINCREM').AsString;
      lstPolicaTabs[intIndex].strTabPre := arrTabTmp[intIndex];

      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := lstPolicaTabs[intIndex].fGravaPoliticas;
      frmAguarde.ShowModal;
      pFreeAndNil(frmAguarde);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pGravaPoliticasProdutos;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fGravaPoliticasProdutos;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pInfoStatusGravacao(
  pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadNegociacaoClientes.pInicializaIndices;
begin
  inherited;
  stlCampos   := TStringList.Create;
  stlCamInd   := TStringList.Create;
  stlDesInd   := TStringList.Create;

  stlCamInd.Add('NEG_CODNEG');
  stlCamInd.Add('NEG_DESCRI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadNegociacaoClientes.pLimpaGrids;
begin
  If cdsCmpNeg.Active Then
    cdsCmpNeg.EmptyDataSet;

  If cdsIteNeg.Active Then
    cdsIteNeg.EmptyDataSet;

  If cdsCliNeg.Active Then
    cdsCliNeg.EmptyDataSet;

  If cdsQtdNeg.Active Then
    cdsQtdNeg.EmptyDataSet;
end;

procedure TfrmCadNegociacaoClientes.pLimpaTodosCamposPageTabelas;
  Var
    intIndex: Integer;
begin
  For intIndex := 0 To lstPolicaTabs.Count-1 Do
  Begin
    lstPolicaTabs[intIndex].pCancelaPolitica(tdDesconto);
    lstPolicaTabs[intIndex].pCancelaPolitica(tdAcrescimo);
  End;
end;

procedure TfrmCadNegociacaoClientes.pLimpaTodosGridPageTabelas;
  Var
    intIndex: Integer;
begin
  For intIndex := 0 To lstPolicaTabs.Count-1 Do
  Begin
    lstPolicaTabs[intIndex].cdsDesconto.EmptyDataSet;
    lstPolicaTabs[intIndex].cdsAcrescimo.EmptyDataSet;
  End;
end;

procedure TfrmCadNegociacaoClientes.pMarcarTabelasPreco(strTabelas: String);
  Var
    intTabPre: Integer;
begin
  //Caso a string esteja menor que a quantidade de tabelas de preço preenche com 'N'
  strTabelas := fPadR(strTabelas, clbTabPre.Items.Count, 'N'); //'NNNNNNN'
  //Marca as tabelas de preco utilizadas na negociacao
  For intTabPre := 1 To clbTabPre.Items.Count Do
    clbTabPre.Checked[intTabPre - 1] := (strTabelas[intTabPre] = 'S') And (VS_strTabVen[intTabPre] = 'S');
end;

procedure TfrmCadNegociacaoClientes.pOrdenaItem(blnCima: Boolean);
  Var
    prcScroll: TprcScroll;
    intDiaIni,
    intDiaFim: Integer;

    procedure pMoveItemCima;
      Var
        strSeqAtu, strSeqAnt: String;
    begin
      If (cdsCmpNeg.RecNo <> 1) Then
      Begin
        strSeqAtu := cdsCmpNeg.FieldByName('CMP_ORDDES').AsString;

        cdsCmpNeg.Prior;

        strSeqAnt := cdsCmpNeg.FieldByName('CMP_ORDDES').AsString;

        cdsCmpNeg.Edit;
        cdsCmpNeg.FieldByName('CMP_ORDDES').AsString := strSeqAtu;
        cdsCmpNeg.Post;

        cdsCmpNeg.Prior;

        cdsCmpNeg.Edit;
        cdsCmpNeg.FieldByName('CMP_ORDDES').AsString := strSeqAnt;
        cdsCmpNeg.Post;
      End;
    End;

    procedure pMoveItemBaixo;
      Var
        strSeqAtu, strSeqAnt: String;
    begin
      If (cdsCmpNeg.RecordCount <> cdsCmpNeg.RecNo) Then
      Begin
        strSeqAtu  := cdsCmpNeg.FieldByName('CMP_ORDDES').AsString;

        cdsCmpNeg.Next;

        strSeqAnt := cdsCmpNeg.FieldByName('CMP_ORDDES').AsString;

        cdsCmpNeg.Edit;
        cdsCmpNeg.FieldByName('CMP_ORDDES').AsString := strSeqAtu;
        cdsCmpNeg.Post;

        cdsCmpNeg.Prior;

        cdsCmpNeg.Edit;
        cdsCmpNeg.FieldByName('CMP_ORDDES').AsString := strSeqAnt;
        cdsCmpNeg.Post;
      End;
    End;
begin
  If cdsCmpNeg.IsEmpty Then
    fMensagem('ATENÇÃO', 'Não existem registros na grade para realizar a ordenação.', ['&OK'])
  Else
  Begin
    With cdsCmpNeg Do
    Begin
      intDiaIni := FieldByName('CMP_DIAINI').AsInteger;
      intDiaFim := FieldByName('CMP_DIAFIM').AsInteger;

      If blnCima Then
      Begin
        //Já esta no começo da lista
        If FieldByName('CMP_ORDDES').AsInteger = 1 Then
          Exit;
      End
      Else
      Begin
        //Já esta no fim da lista
        If FieldByName('CMP_ORDDES').AsInteger = RecordCount Then
          Exit;
      End;

      Try
        pDisableControls(cdsCmpNeg, prcScroll);

        If blnCima Then
          pMoveItemCima
        Else
          pMoveItemBaixo;
      Finally
        pEnableControls(cdsCmpNeg, prcScroll);
      End;

      cdsCmpNeg.Locate('CMP_DIAINI;CMP_DIAFIM', VarArrayOf([intDiaIni,intDiaFim]), []);
    End;
  End;
end;

procedure TfrmCadNegociacaoClientes.pRepassaTabelas;
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fRepassaTabelas;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadNegociacaoClientes.pSetaSequencialPoliiticaDesAcr(blnHeranca: Boolean = False);
  Var
    intIndex: Integer;
    arrTabTmp: TStringArray;

  procedure pMontaArrayTab;
    Var
      intCont,
      intPos: Integer;
  Begin
    intPos := 0;
    SetLength(arrTabTmp, lstPolicaTabs.Count);

    For intCont := 1 To Length(VS_strTabVen) Do
    Begin
      If VS_strTabVen[intCont] = 'S' Then
      Begin
        arrTabTmp[intPos] := IntToStr(intCont);
        Inc(intPos);
      End;
    End;
  End;
begin
  pMontaArrayTab;

  For intIndex := 0 To lstPolicaTabs.Count-1 Do
  Begin
    lstPolicaTabs[intIndex].strSeqGer  := qryTabela.FieldByName('AUTOINCREM').AsString;
    lstPolicaTabs[intIndex].strTabPre  := arrTabTmp[intIndex];
    lstPolicaTabs[intIndex].blnHeranca := blnHeranca;
    lstPolicaTabs[intIndex].pCarregaPoliticas;
  End;
end;

procedure TfrmCadNegociacaoClientes.pStepStatusGravacao(
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCadNegociacaoClientes.tbsGeralShow(Sender: TObject);
begin
  inherited;

  If pnlCabecalho.Enabled And (Not blnCriando) Then
    pSetFocus(dbeDesNeg);

  blnCriando := False;
end;

end.
