{***************************}
{* qryConIte -> CADITE     *}
{************************JB*}

{*********************************************************************}
{* SE CASO MEXER NA REGRA DOS CAMPOS QUE SÃO UTILIZADOS PARA VENDA   *}
{* MADEIRA, SERÁ NECESSÁRIO TAMBÉM MEXER NO FATURAMENTO E VICE-VERSA *}
{******************************************************************FC*}
unit untCadEstruturas;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls, cxProgressBar,
  EditFocus, Mask, DBCtrls, Uni, Grids, DBGridCitel, DBGrids, AppEvnts, frxClass, frxDBSet, System.Math,
  QColorLabel, Data.DB, UniClientDataSet, Datasnap.Provider, StrUtils, Vcl.Graphics,
  UniDataSetProvider, MemDS, DBAccess, frxExportCSVTestabilidade, BitBtnLockedIncrem,
  DBEditFocus, Datasnap.DBClient, Vcl.ComCtrls, untZClient, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, DBComboBoxFocus, ComboBoxFocus,
  cxContainer, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, DBLookupComboBoxFocus, untLayoutsEstrutura,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxBarBuiltInMenu,
  cxGridCustomPopupMenu, cxGridPopupMenu, untFuncoesRel, untFuncoesRel2, untTEstruturaPersonalizada,
  cxCheckBox, untOrdProMonitoramento;

type
  TTipoOperacao = (toIncluir, toEditar);

type
  TfrmCadEstruturas = class(TfrmPai)
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    cdsConsultaMAX_SEQGER: TAggregateField;
    btnConfirma: TBitBtnLocked;
    btnEstrutura: TBitBtnLocked;
    btnComentario: TBitBtnLocked;
    btnMoveCima: TBitBtnLocked;
    btnMoveBaixo: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    cdsConsultaSUM_TOTITE: TAggregateField;
    pgcPagina: TPageControl;
    tbsEstrutura: TTabSheet;
    tbsEteMat: TTabSheet;
    pnlProdutos: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtDesProduto: TEditFocus;
    edtProdutos: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    shpESTPRE: TShape;
    rdgPrecos: TRadioGroup;
    edtDesSubProduto: TEditFocus;
    edtSubProduto: TEditFocus;
    edtSubReferencia: TEditFocus;
    edtSubUnidade: TEditFocus;
    edtSubDestino: TEditFocus;
    cmbPreVen: TComboBox;
    pnlQtdMadeira: TPanel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblQtdMadeira: TLabel;
    Label19: TLabel;
    ColorLabel2: TColorLabel;
    Label20: TLabel;
    ColorLabel5: TColorLabel;
    Label21: TLabel;
    ColorLabel3: TColorLabel;
    Label22: TLabel;
    ColorLabel1: TColorLabel;
    edtComPec: TEditFocus;
    edtLarPec: TEditFocus;
    edtEspPec: TEditFocus;
    edtQtdPec: TEditFocus;
    edtAparel: TEditFocus;
    edtPerApa: TEditFocus;
    edtBenefi: TEditFocus;
    edtPerBen: TEditFocus;
    pnlQuantidade: TPanel;
    lblQtdIte: TLabel;
    Label8: TLabel;
    ColorLabel6: TColorLabel;
    edtSubQtdIte: TEditFocus;
    edtAcumOp: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    pnlTopEteMat: TPanel;
    pnlAlClientEteMat: TPanel;
    cxgEteMatLevel: TcxGridLevel;
    cxgEteMatTableView: TcxGridDBTableViewCitel;
    cxgEteMat: TcxGridCitel;
    lbl23: TLabel;
    edtMaxEte: TEditFocus;
    btnAdicionaIteEmb: TBitBtnLocked;
    btnCancelaIteEmb: TBitBtnLocked;
    Label6: TLabel;
    edtMinEte: TEditFocus;
    Label9: TLabel;
    edtCodEte: TEditFocus;
    edtDesEte: TEditFocus;
    cxgEteMatTableViewCODETE: TcxGridDBColumn;
    cxgEteMatTableViewDESCRI: TcxGridDBColumn;
    cxgEteMatTableViewVALMIN: TcxGridDBColumn;
    cxgEteMatTableViewVALMAX: TcxGridDBColumn;
    Panel1: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtDesAcabado: TEditFocus;
    edtProAcabado: TEditFocus;
    edtRefAcabado: TEditFocus;
    edtUndAcabado: TEditFocus;
    Bevel1: TBevel;
    Panel2: TPanel;
    pnlQtd: TPanel;
    Label18: TLabel;
    dbeQtdTotal: TDBEditFocus;
    pnlTotal: TPanel;
    lblTotal: TLabel;
    dbeTotal: TDBEditFocus;
    lblTipQtd: TLabel;
    cbxTipQtd: TComboBoxFocus;
    cdsConsultaSUM_QTDITE: TAggregateField;
    btnLayouts: TBitBtnLocked;
    shpEstrutura: TShape;
    Label15: TLabel;
    btnExiEstrutura: TBitBtnLocked;
    cxgDadosLevel: TcxGridLevel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDados: TcxGridCitel;
    cxgDadosTableViewDMT_ITESUB: TcxGridDBColumn;
    cxgDadosTableViewITE_CODFAB: TcxGridDBColumn;
    cxgDadosTableViewDMT_DESCRI: TcxGridDBColumn;
    cxgDadosTableViewDMT_REFERE: TcxGridDBColumn;
    cxgDadosTableViewDMT_QTDITE: TcxGridDBColumn;
    cxgDadosTableViewITE_DENSID: TcxGridDBColumn;
    cxgDadosTableViewMASSA: TcxGridDBColumn;
    cxgDadosTableViewITE_PREVE1: TcxGridDBColumn;
    cxgDadosTableViewTOTITE: TcxGridDBColumn;
    cxgDadosTableViewDMT_ACUMOP: TcxGridDBColumn;
    cxgDadosTableViewDMT_DESPCA: TcxGridDBColumn;
    cxgDadosTableViewEstrur: TcxGridDBColumn;
    cxgDadosTableViewDMT_SEQUEN: TcxGridDBColumn;
    cxgDadosTableViewUNI_SIGUNI: TcxGridDBColumn;
    btnEditar: TBitBtnLocked;
    cxGridPopupMenu1: TcxGridPopupMenu;
    cxgDadosTableViewDMT_PRESUB: TcxGridDBColumn;
    Label23: TLabel;
    edtCodFabrica: TEditFocus;
    Label24: TLabel;
    edtCodFabAcabado: TEditFocus;
    lblFatorPrecoVenda: TLabel;
    edtFatorPrecoVenda: TEditFocus;
    tbsFases: TTabSheet;
    pnlFases: TPanel;
    cxgCadFas: TcxGrid;
    cxgCadFasView: TcxGridDBTableView;
    cxgCadFasCODIGO: TcxGridDBColumn;
    cxgCadFasDESFAS: TcxGridDBColumn;
    cxgCadFasSEQUEN: TcxGridDBColumn;
    cxgCadFasUTILIZ: TcxGridDBColumn;
    cxgCadFasLevel1: TcxGridLevel;
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure pCarregaProduto(qryConsulta: TUniQuery);
    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
    procedure edtSubProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria(intPosicao: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure pLimparDadosSub;
    procedure pLimparDados;
    procedure pHabilitaCampos;
    procedure pDeletaItem;
    function fRetCustoItem(strCodite: String): String;
    function fRetPreVenda1(strCodIte :String): String;
    function fRetPreVenda2(strCodIte :String): String;
    function fRetPreVenda3(strCodIte :String): String;
    function fRetPreVenda4(strCodIte :String): String;
    function fRetPreVenda5(strCodIte :String): String;
    function fRetPreVenda6(strCodIte :String): String;
    function fRetPreVenda7(strCodIte :String): String;
    function fRetPreUlt(strCodIte    :String): String;
    function fRetImpUlt(strCodIte    :String): String;
    function fRetSeqGer: String;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnEstruturaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnComentarioClick(Sender: TObject);
    procedure pCarregaEstrutura;
    procedure btnMoveCimaClick(Sender: TObject);
    procedure btnMoveBaixoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtAparelChange(Sender: TObject);
    procedure edtBenefiChange(Sender: TObject);
    procedure rdgPrecosClick(Sender: TObject);
    procedure cmbPreVenChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnCancelaIteEmbClick(Sender: TObject);
    procedure btnAdicionaIteEmbClick(Sender: TObject);
    procedure tbsEteMatShow(Sender: TObject);
    procedure pgcPaginaChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edtCodEteKeyPress(Sender: TObject; var Key: Char);
    procedure cxgEteMatTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgEteMatTableViewDblClick(Sender: TObject);
    procedure cbxTipQtdChange(Sender: TObject);
    procedure btnLayoutsClick(Sender: TObject);
    procedure btnExiEstruturaClick(Sender: TObject);
    procedure cxgDados_TableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDados_TableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDados_TableViewColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxgDados_TableViewColumnPosChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure btnEditarClick(Sender: TObject);
    procedure cxgDadosTableViewColumnPosChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxgDadosTableViewColumnSizeChanged(Sender: TcxGridTableView;
      AColumn: TcxGridColumn);
    procedure cxgDadosTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDadosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);

  private

    intQtdDigitos : Integer;
    intCorZeb: Integer;
    strCusIte: String;
    strPreVe1: String;
    strPreVe2: String;
    strPreVe3: String;
    strPreVe4: String;
    strPreVe5: String;
    strPreVe6: String;
    strPreVe7: String;
    strPreUlt: String;
    strImpUlt: String;
    strSeqGer: String;
    strDescri: String;
    qryConIte: TUniQuery;

    strAutoInc: String;

    intSequenAlt: Integer;
    blnUtilizaVendaMadeira: Boolean;
    blnQualidadeEstrutura : Boolean;

    cdsEteMat : TZClient;

    objLayEst : TLayoutsEstrutura;

    FModoEstruturaPersonalizada : Boolean;
    FobjEstruturaPersonalizada  : TEstruturaPersonalizada;

    cdsCadFas: TZClient;
    blnMONFAS: Boolean;

    procedure pCriarQryConIte;
    procedure pConfirmarEstruturaPersonalizada;

    function fRetSQLCarregaEstrutura : String;

    function fRetTabGer : String;
    function fRetTabDet : String;

    function fBuscaEstrutura(blnImportacao: Boolean): String;
    procedure pCarregaItemAlteracao;

    procedure pCalculaQuantidadeMetrosCubicos;
    procedure pFormataQtdPec;
    function fRetCampoPreco(intItemIndex: Integer; strTabPre: String): String;
    procedure pCalculaTotal;
    function fCalculaTotal(cxProgresso: TcxProgressBar): Boolean;
    procedure pLimpaEteMat;
    procedure pCarregaEteMatEdicao;
    procedure pAttTipoQtd(strTipQtd: String);
    function fLeftColumn(objColumn: TcxGridDBColumn): Integer;
    function fRetQtdCalc: real;
    procedure pCdsConsultaAfterScroll(DataSet: TDataSet);
    procedure pPosicionaPanels;
    procedure pTrataComentario(enuTipoOperacao: TTipoOperacao);
    function fMovimentaSubItemNaVenda: Boolean;
    function fBuscaPedPendentes: String;
    procedure pMostraPedPendentes(Const strAcao: String);
    function fVerificaSeExisteOrdemProducao: Boolean;
    procedure pCarregaFases(AStrCodIte: String);
    function fGetSQLFases: String;
    function fSalvarFases(AStrAutIncGerMat: String): Boolean;
    function fValidaInclusaoSubProduto(AStrCodItePai, AStrCodIteFilho: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pGravaTemporaria(strCodIte, strDescri, strDestino, strAcumOp: String;
                               fltQtdIte: Double;
                               fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double;
                               strAparel, strBenefi: String;
    fltPerApa, fltPerBen, fltPreSub: Double);
  public
    blnConfirma: Boolean;
    strObs001: String;
    strObs002: String;
    strObs003: String;
    strObs004: String;
    strObs005: String;
    strObs006: String;
    strObs007: String;
    strComent: String;

    procedure pCarregarEstruturaParaPersonalizacao(const strIteEst : String; objEstruturaPersonalizada : TEstruturaPersonalizada);
    procedure pExecBloqueiosModoEstruturaPersonalizada;

  end;

implementation

uses SysUtils, Variants, untFuncoes, untfuncoesSimples, untPesqAux, untObsEstrutura,
 untComentEstrutura, untGerMat, untCfgRel, untConsultas,
 untTypesSistema, untFuncFat, untGravando, TypesRel, untMostraEstruturas, untMemo;

{$R *.dfm}

procedure TfrmCadEstruturas.edtProdutosKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
 inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      fValidaCampos(edtProdutos, True);
      rdgPrecosClick(Sender);
    End;

  End;

end;

procedure TfrmCadEstruturas.edtAparelChange(Sender: TObject);
begin
 inherited;
  If Not(edtAparel.Focused) Then
    Exit;

  If edtAparel.Text <> 'S' Then
  Begin
    edtPerApa.Text := '0,00';
    edtPerApa.Enabled := False;
  End
  Else
  Begin
    edtPerApa.Enabled := True;
    edtPerApa.ReadOnly := True;
    edtPerApa.Text := FormatFloat('#,##0.00', fCfgSis('PERAPA', varDouble));
  End;
end;

procedure TfrmCadEstruturas.edtBenefiChange(Sender: TObject);
begin
 inherited;
  If Not(edtBenefi.Focused) Then
    Exit;

  If edtBenefi.Text <> 'S' Then
  Begin
    edtPerBen.Text := '0,00';
    edtPerBen.Enabled := False;
  End
  Else
  Begin
    edtPerBen.Enabled := True;
    edtPerBen.Text := FormatFloat('#,##0.00', fCfgSis('PERBEN', varDouble));
  End;
end;

procedure TfrmCadEstruturas.edtCodEteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEspecificacoesTecnicas(Self, edtCodEte, edtDesEte, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodEte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturas.edtProdutosExit(Sender: TObject);
begin
 inherited;
  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text)) Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;

end;

procedure TfrmCadEstruturas.pCarregaProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProdutos.Text, '');
  With qryConsulta Do
  Begin
    edtDesProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
    edtCodFabrica.Text := qryConsulta.FieldByName('ITE_CODFAB').AsString;
  End;
end;

procedure TfrmCadEstruturas.pCarregarEstruturaParaPersonalizacao(const strIteEst : String; objEstruturaPersonalizada : TEstruturaPersonalizada);
  var
    strTipQtd : String;
begin

  edtProdutos.Text := strIteEst;

  FModoEstruturaPersonalizada := True;
  FobjEstruturaPersonalizada  := objEstruturaPersonalizada;
  FobjEstruturaPersonalizada.pCarregarItemEstruturaParaTabelasTemporarias(strIteEst);

  strTipQtd := fCampoTabela('GMT_TIPQTD', fRetTabGer, ['GMT_CODITE', 'GMT_CODEMP'], [edtProdutos.Text, VS_strCodEmp]);
  pAttTipoQtd(strTipQtd);

  pCriarQryConIte;

  pCarregaProduto(qryConIte);
  pCarregaEstrutura;

  pHabilitaCampos;
  pExecBloqueiosModoEstruturaPersonalizada;

  Self.WindowState := wsNormal;
  Self.Caption     := Self.Caption + ' (Alterar Estrutura para Venda Específica)';

end;

procedure TfrmCadEstruturas.edtSubProdutoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
 inherited;

  If fEntraCons(Key) Then
  Begin
    Try
      if fPesqItem(conIteSimples, Self, edtSubProduto, edtDesSubProduto, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
      Begin
        If fValidaCampos(edtSubProduto, True) Then
         SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturas.edtSubProdutoKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturas.pCarregaSubProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtSubProduto.Text, '');
  With qryConsulta Do
  Begin
    strCusIte := fRetCustoItem(edtSubProduto.Text);
    strPreVe1 := fRetPreVenda1(edtSubProduto.Text);
    strPreVe2 := fRetPreVenda2(edtSubProduto.Text);
    strPreVe3 := fRetPreVenda3(edtSubProduto.Text);
    strPreVe4 := fRetPreVenda4(edtSubProduto.Text);
    strPreVe5 := fRetPreVenda5(edtSubProduto.Text);
    strPreVe6 := fRetPreVenda6(edtSubProduto.Text);
    strPreVe7 := fRetPreVenda7(edtSubProduto.Text);
    strPreUlt := fRetPreUlt(edtSubProduto.Text);
    strImpUlt := fRetImpUlt(edtSubProduto.Text);

    edtDesSubProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtSubReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtSubUnidade.Text := qryConsulta.FieldByName('ITE_CODUNI').AsString;

    If fItemFracionado(edtSubUnidade.Text) Then
    Begin
      edtSubQtdIte.TipoTexto := EditFocus.ttNumerico;
      edtSubQtdIte.EditFormat := fMskDigitos(intQtdDigitos);
    End
    Else
    Begin
      edtSubQtdIte.TipoTexto := EditFocus.ttInteiro;
      edtSubQtdIte.EditFormat := '0';
    End;

    edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, fStrToFloat(edtSubQtdIte.Text) );

    If blnUtilizaVendaMadeira Then
    Begin
      pFormataQtdPec;

      pnlQtdMadeira.Enabled := fMetragemObrigatoria(edtSubUnidade.Text);

      edtQtdPec.Enabled := pnlQtdMadeira.Enabled;
      edtComPec.Enabled := pnlQtdMadeira.Enabled;
      edtLarPec.Enabled := pnlQtdMadeira.Enabled;
      edtEspPec.Enabled := pnlQtdMadeira.Enabled;
      edtSubQtdIte.ReadOnly := pnlQtdMadeira.Enabled;

      If Not pnlQtdMadeira.Enabled Then
      Begin
        edtQtdPec.Text := '0,00000';
        edtComPec.Text := '0,00000';
        edtLarPec.Text := '0,00000';
        edtEspPec.Text := '0,00000';
        edtPerApa.Text := '0,00';
        edtPerBen.Text := '0,00';
      End;

      edtPerApa.Enabled := SameText(edtAparel.Text, 'S');
      edtPerBen.Enabled := SameText(edtBenefi.Text, 'S');
      edtPerApa.ReadOnly := True;
    End;
  End;
end;

procedure TfrmCadEstruturas.pDeletaTemporaria;
begin
 If cdsConsulta.Active Then
  cdsConsulta.EmptyDataSet;
end;

procedure TfrmCadEstruturas.pExecBloqueiosModoEstruturaPersonalizada;
  var
    intComponente : Integer;
begin

  for intComponente := 0 to Self.ComponentCount -1 do
  begin

    If (Self.Components[intComponente] Is TEditFocus) Then
    begin
      If ((Self.Components[intComponente] as TEditFocus).Name = edtSubQtdIte.Name) Then
        Continue;
      If ((Self.Components[intComponente] as TEditFocus).Name = edtSubProduto.Name) Then
        Continue;
      (Self.Components[intComponente] as TEditFocus).ReadOnly    := True;
      (Self.Components[intComponente] as TEditFocus).Color       := $00FFDFB8;
      (Self.Components[intComponente] as TEditFocus).NormalColor := $00FFDFB8;
      (Self.Components[intComponente] as TEditFocus).TabStop     := False;
    end;

    If (Self.Components[intComponente] Is TBitBtnLocked) Then
    begin
      If ((Self.Components[intComponente] as TBitBtnLocked).Name = btnConfirma.Name) Then
        Continue;
      If ((Self.Components[intComponente] as TBitBtnLocked).Name = btnSair.Name) Then
        Continue;
      If ((Self.Components[intComponente] as TBitBtnLocked).Name = btnAdicionar.Name) Then
        Continue;
      If ((Self.Components[intComponente] as TBitBtnLocked).Name = btnCancelaItem.Name) Then
        Continue;
      (Self.Components[intComponente] as TBitBtnLocked).Enabled := False;
    end;

    If (Self.Components[intComponente] Is TRadioGroup) Then
      (Self.Components[intComponente] as TRadioGroup).Enabled := False;

    If (Self.Components[intComponente] Is TComboBox) Then
      (Self.Components[intComponente] as TComboBox).Enabled := False;

    If (Self.Components[intComponente] Is TComboBoxFocus) Then
      (Self.Components[intComponente] as TComboBoxFocus).Enabled := False;

  end;

end;

procedure TfrmCadEstruturas.pFormataQtdPec;
begin
  If blnUtilizaVendaMadeira Then
  begin
    edtQtdPec.EditFormat :=  edtSubQtdIte.EditFormat;
    edtQtdPec.TipoTexto  :=  edtSubQtdIte.TipoTexto;
    edtQtdPec.Text       :=  FormatFloat(edtQtdPec.EditFormat, fStrToFloat(edtQtdPec.Text) );
  end;
end;

procedure TfrmCadEstruturas.pAtualizaTemporaria(intPosicao: Integer);
begin
  With cdsConsulta Do
  Begin
    If (RecordCount > 0) And (RecordCount >= intPosicao) Then
      RecNo := intPosicao;

    (FieldByName('DMT_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(intQtdDigitos);
  End;
end;

function TfrmCadEstruturas.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtProdutos) Then
    Begin
      If fEmptyStr(edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Digite o código do produto!', ['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO', 'Código do produto não encontrado!', ['&O K']);
          Result := False;
        End
        Else
        Begin
          If blnValidaIndividual Then
          Begin
            //altera o layout
            objLayEst.Clear;
            objLayEst.strCodIte := edtProdutos.Text;
            objLayEst.pCarregaLayGmt;
            if btnLayouts.Visible then
              btnLayouts.Enabled := True;

            pCarregaEstrutura;
            pAtualizaTemporaria(1);
            if not (cbxTipQtd.Visible or btnLayouts.Visible) then
              pHabilitaCampos
            else
            begin
              SelectNext(ActiveControl, True, True);
              if (not cbxTipQtd.Visible) and btnLayouts.Visible then
                btnLayouts.Click;
            end;
          End;
        End;
      End;
    End

    else If (Sender = cbxTipQtd) Then
    Begin
      if blnValidaIndividual and  cbxTipQtd.Visible  and (not btnLayouts.Visible)  then
        pHabilitaCampos
      else if blnValidaIndividual and  btnLayouts.Visible then
        btnLayouts.Click;
    end

    { ************************** }
    { * VALIDA SE ACUMULA NA OP * }
    { ***********************CI* }
    Else
    If (Sender = edtAcumOp) Then
    Begin
      If Pos(edtAcumOp.Text, 'SN') <= 0 Then
      Begin
        fMensagem('', 'O campo Acumula na OP deve ser S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtSubProduto) Then
    Begin
      If (fEmptyStr(edtSubProduto.Text)) Then
      Begin
        {If (Not cdsConsulta.IsEmpty) Then
        Begin
         pSetFocus(dbgDados);
         blnMudarFoco := False;
        End
        Else}
        Result := False;
      End
      Else If (edtSubProduto.Text = edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Sub. Produto não pode ser igual a Estrutura!',['&OK']);
        Result := False;
      End
      Else If (intSequenAlt = 0) And (Not fCfgSis('REPEST', varBoolean)) And cdsConsulta.Locate('DMT_ITESUB', edtSubProduto.Text, []) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse item já se encontra na estrutura!', ['&O K']);
        Result := False;
      End
      Else If (fItemEstrutura(edtSubProduto.Text)) And (fValidaInclusaoSubProduto(edtSubProduto.Text, edtProdutos.Text)) Then
      Begin
        {Para evitar recursividade. Req: 388086}
        fMensagem('AVISO', 'Não é possível incluir esse item, pois o item: ' + edtProdutos.Text + ' é um subitem na estrutura do item: ' + edtSubProduto.Text + ' ', ['&O K']);
        Result := False;
      End
      Else
      Begin

        If Not fEmptyStr(edtSubProduto.Text) Then
          pCarregaSubProduto(qryConIte);

        If fEmptyStr(edtDesSubProduto.Text) And (Not fEmptyStr(edtSubProduto.Text))  Then
        Begin
          fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End;

    End

    Else
    If (Sender = edtSubQtdIte) Then
    Begin
      If ((Not pnlQtdMadeira.Visible) Or
          (Not pnlQtdMadeira.Enabled)) Then
      Begin
        If (Not edtSubQtdIte.ReadOnly) Then
        Begin
          If Not fEmptyStr(edtSubProduto.Text) Then
          Begin
            If fEmptyStr(edtSubQtdIte.Text) Then
            Begin
              fMensagem('ATENÇÃO', 'Digite a quantidade do produto!', ['&O K']);
              Result := False;
            End
            Else If fStrToFloat(edtSubQtdIte.Text) <= 0.00 Then
            Begin
              fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
              Result := False;
            End;
          End;
        End;
      End;
    End
    { ************************ }
    { * VALIDA DADOS MADEIRA * }
    { *********************FC* }
    Else
    If (Sender = edtAparel) And (blnUtilizaVendaMadeira) Then
    Begin
      If Pos(edtAparel.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo aparelhada deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else
    If (Sender = edtPerApa) And (edtPerApa.Enabled) And (blnUtilizaVendaMadeira) Then
    Begin
      If Not fValidaEscala(edtPerApa.Text, 0, 100) Then
      Begin
        fMensagem('','O percentual de acréscimo para aparelhado deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtPerApa.Text) Then
        edtPerApa.Text := '0,00';
    End

    Else
    If (Sender = edtBenefi) And (blnUtilizaVendaMadeira) Then
    Begin
      If Pos(edtBenefi.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo aparelhada deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = edtPerBen) And (edtPerBen.Enabled) And (blnUtilizaVendaMadeira) Then
    Begin
      If Not fValidaEscala(edtPerBen.Text, 0, 100) Then
      Begin
        fMensagem('','O percentual de acréscimo para beneficiamento deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtPerBen.Text) Then
        edtPerBen.Text := '0,00';
    End

    Else
    If (Sender = edtQtdPec)     And
       (edtQtdPec.Enabled)      And
       (blnUtilizaVendaMadeira) And
       (blnValidaIndividual)    Then
    Begin
      If (fStrToFloat(edtQtdPec.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else
    If (Sender = edtComPec)     And
       (edtComPec.Enabled)      And
       (blnUtilizaVendaMadeira) And
       (blnValidaIndividual)    Then
    Begin
      If fStrToFloat(edtComPec.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O comprimento deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else
    If (Sender = edtLarPec)     And
       (edtLarPec.Enabled)      And
       (blnUtilizaVendaMadeira) And
       (blnValidaIndividual)    Then
    Begin
      If fStrToFloat(edtLarPec.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Largura deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else
    If (Sender = edtEspPec)     And
       (edtEspPec.Enabled)      And
       (blnUtilizaVendaMadeira) And
       (blnValidaIndividual)    Then
    Begin
      If fStrToFloat(edtEspPec.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Espessura deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaQuantidadeMetrosCubicos;
    End

    Else
    If (fCfgSis('RATEST', varString) = 'C') And (edtFatorPrecoVenda.Visible) And (fStrToFloat(edtFatorPrecoVenda.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator deve ser maior que Zero!', ['&O k']);
      Result := False;
    End

    Else
    If (Sender = edtCodEte) And blnValidaIndividual Then
    Begin
      If fEmptyStr(edtCodEte.Text) Then
      Begin
        Result := False;
        fMensagem('', 'Informe o Código da Específicação!', ['&Ok']);
      End
      Else
      Begin
        edtDesEte.Text := fRetDesEspecifiTecnica(edtCodEte.Text);
        If fEmptyStr(edtDesEte.Text) Then
        Begin
          Result := False;
          fMensagem('', 'Informe um Código de Específicação Válido!', ['&Ok']);
        End;
      End;
    End

    Else
    If (Sender = edtMinEte) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtMinEte.Text) < 0 Then
      Begin
        Result := False;
        fMensagem('', 'O Valor Mínimo deve ser Maior que Zero!', ['&Ok']);
      End;

    End

    Else
    If (Sender = edtMaxEte) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtMaxEte.Text) < 0 Then
      Begin
        Result := False;
        fMensagem('', 'O Valor Máximo deve ser Maior que Zero!', ['&Ok']);
      End
      Else If fStrToFloat(edtMaxEte.Text) < fStrToFloat(edtMinEte.Text) Then
      Begin
        Result := False;
        fMensagem('', 'O Valor Máximo deve ser Maior ou Igual o Valor Mínimo!', ['&Ok']);
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;


function TfrmCadEstruturas.fVerificaSeExisteOrdemProducao: Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   COUNT(1) AS QTD ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('   MOVPRO ');
    qryAux.SQL.Add(' WHERE PRO_CODITE = :CODITE ');
    qryAux.SQL.Add(' AND PRO_DTABAI IS NULL ');

    qryAux.ParamByName('CODITE').AsString := edtProdutos.Text;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsFloat > 0;

    If Result Then
      pMensagemOk('Não é possível excluir pois existe ordem de produção para essa estrutura!');

  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadEstruturas.FormCreate(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;

  FModoEstruturaPersonalizada := False;

  WindowState := wsMaximized;

  intQtdDigitos := fCfgSis('ESTDEC', varInteger);
  intCorZeb := fCfgSis('CORZEB', varInteger);
  blnUtilizaVendaMadeira := fCfgSis('VENMAD', varBoolean);

  cxgDadosTableView.OptionsCustomize.ColumnSorting := fCfgSis('ORDGOP', varBoolean);
  {btnComentario.Visible := Not fCfgSis('ORDGOP', varBoolean);
  btnMoveCima.Visible   := Not fCfgSis('ORDGOP', varBoolean);
  btnMoveBaixo.Visible  := Not fCfgSis('ORDGOP', varBoolean);}

  if fCfgSis('ESTPER', varBoolean) then
  begin
    lblTipQtd.Visible := True;
    cbxTipQtd.Visible := True;
  end
  else
  begin
    lblTipQtd.Visible := False;
    cbxTipQtd.Visible := False;
  end;

  If blnUtilizaVendaMadeira Then
    lblQtdIte.Caption := 'Quantidade Total:'
  Else
    lblQtdIte.Caption := 'Quantidade:';

  objLayEst := TLayoutsEstrutura.Create;
  if not fCfgSis('ESTLAY', varBoolean) then
  begin
    btnLayouts.Visible := False;
    pnlProdutos.Height := pnlProdutos.Height - btnLayouts.Height - 4;
  end;


  pLimparDados;
  pnlQtdMadeira.Visible := blnUtilizaVendaMadeira;

  //densidade
  cxgDadosTableViewITE_DENSID.Visible := fCfgSis('DENMAS', varBoolean);

  //massa
  cxgDadosTableViewMASSA.Visible := fCfgSis('DENMAS', varBoolean);


  edtSubQtdIte.EditFormat := fMskDigitos(intQtdDigitos);
  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, 0);
  pFormataQtdPec;

  cmbPreVen.Items.Clear;
  For intIndex := 1 To Length(VS_strTabVen) Do
    If VS_strTabVen[intIndex] = 'S' Then
      cmbPreVen.Items.Add(IntToStr(intIndex));

  cmbPreVen.ItemIndex := 0;

  blnQualidadeEstrutura := fCfgSis('QLDEST', varBoolean) And (Not FModoEstruturaPersonalizada);
  tbsEteMat.TabVisible  := blnQualidadeEstrutura;

  edtFatorPrecoVenda.Visible := (fCfgSis('RATEST', varString) = 'C');
  lblFatorPrecoVenda.Visible := edtFatorPrecoVenda.Visible;
  edtFatorPrecoVenda.Text := '1,000';
  cxgDadosTableViewDMT_PRESUB.Visible := edtFatorPrecoVenda.Visible;

  cdsEteMat := TZClient.Create(Self);
  With cdsEteMat, qryQuery.SQL Do
  Begin
    Clear;
    Add(' SELECT A.AUTOINCREM,                             ');
    Add('        A.ETM_CODETE,                             ');
    Add('        E.ETE_DESCRI,                             ');
    Add('        A.ETM_VALMIN,                             ');
    Add('        A.ETM_VALMAX                              ');
    Add(' FROM ETEMAT A                                    ');
    Add('   INNER JOIN ESPTEC E ON ETE_CODIGO = ETM_CODETE ');
    Add(' WHERE ETM_SEQMAT = :SEQMAT                       ');
  End;

  pgcPagina.ActivePageIndex := 0;

  pPosicionaPanels;

  blnMONFAS := fCfgSis('MONFAS', varBoolean);
  tbsFases.tabVisible := blnMONFAS;
end;

procedure TfrmCadEstruturas.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsCadFas) Then
    FreeAndNil(cdsCadFas);
end;

procedure TfrmCadEstruturas.pPosicionaPanels;
Begin
  //13 - tamanho do indicador de linahs
  pnlTotal.Left := fLeftColumn(cxgDadosTableViewTOTITE) - pnlTotal.Width + 13;
  pnlQtd.Left   := fLeftColumn(cxgDadosTableViewDMT_QTDITE) - pnlQtd.Width + 13;
End;

procedure TfrmCadEstruturas.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If cdsConsulta.Locate('DMT_ITESUB', edtSubProduto.Text, []) And (intSequenAlt = 0) And
     (fMensagem('', 'Esse item já existe na estrutura, deseja adicionar mais de 1 vez ?', ['&Sim', '&Não'], 2 ) = 2) Then
  Begin
    pLimparDadosSub;
    pSetFocus(edtSubProduto);
    Exit;
  End;

  cdsConsulta.Locate('DMT_SEQUEN', intSequenAlt, []);
  pGravaTemporaria(edtSubProduto.Text,
                   edtDesSubProduto.Text,
                   edtSubDestino.Text,
                   edtAcumOp.Text,
                   fStrToFloat(edtSubQtdIte.Text),
                   fStrToFloat(edtQtdPec.Text),
                   fStrToFloat(edtComPec.Text),
                   fStrToFloat(edtLarPec.Text),
                   fStrToFloat(edtEspPec.Text),
                   edtAparel.Text,
                   edtBenefi.Text,
                   fStrToFloat(edtPerApa.Text),
                   fStrToFloat(edtPerBen.Text),
                   fStrToFloat(edtFatorPrecoVenda.Text));
  pLimparDadosSub;
  pSetFocus(edtSubProduto);
  btnConfirma.Enabled := True;
  btnImprimir.Enabled := True;
  btnComentario.Enabled := True;

  If (cdsConsulta.RecordCount > 1) Then
  Begin
    btnMoveCima.Enabled := True;
    btnMoveBaixo.Enabled := True;
  End;
end;

procedure TfrmCadEstruturas.pGravaTemporaria(strCodIte, strDescri, strDestino, strAcumOp: String;
                                             fltQtdIte: Double;
                                             fltQtdPec, fltComPec, fltLarPec, fltEspPec: Double;
                                             strAparel, strBenefi: String; fltPerApa, fltPerBen, fltPreSub: Double);
  Var
    strSequen: String;
begin
  If fEmptyStr(strCusIte) Then
    strCusIte := '0.00';

  If fEmptyStr(strPreVe1) Then
    strPreVe1 := '0.00';

  If fEmptyStr(strPreVe2) Then
    strPreVe2 := '0.00';

  If fEmptyStr(strPreVe3) Then
    strPreVe3 := '0.00';

  If fEmptyStr(strPreVe4) Then
    strPreVe4 := '0.00';

  If fEmptyStr(strPreVe5) Then
    strPreVe5 := '0.00';

  If fEmptyStr(strPreVe6) Then
    strPreVe6 := '0.00';

  If fEmptyStr(strPreVe7) Then
    strPreVe7 := '0.00';

  If intSequenAlt = 0 Then
  Begin
    With cdsConsulta Do
    Begin
      strSequen := fRetSeqGer;
      Insert;
      FieldByName('DMT_ITESUB').AsString  := strCodIte;
      FieldByName('DMT_SEQUEN').AsString := strSequen;
      FieldByName('DMT_CODEMP').AsString := VS_strCodEmp;
      FieldByName('DMT_QTDITE').AsFloat := fltQtdIte;
      FieldByName('DMT_PRESUB').AsFloat := fltPreSub;
      FieldByName('DMT_CUSITE').AsFloat := fStrToFloat(strCusIte);
      FieldByName('ITE_PRECUS').AsFloat := fStrToFloat(strCusIte);
      FieldByName('ITE_PREVE1').AsFloat := fStrToFloat(strPreVe1);
      FieldByName('ITE_PREVE2').AsFloat := fStrToFloat(strPreVe2);
      FieldByName('ITE_PREVE3').AsFloat := fStrToFloat(strPreVe3);
      FieldByName('ITE_PREVE4').AsFloat := fStrToFloat(strPreVe4);
      FieldByName('ITE_PREVE5').AsFloat := fStrToFloat(strPreVe5);
      FieldByName('ITE_PREVE6').AsFloat := fStrToFloat(strPreVe6);
      FieldByName('ITE_PREVE7').AsFloat := fStrToFloat(strPreVe7);
      FieldByName('ITE_PREULT').AsFloat := fStrToFloat(strPreUlt);
      FieldByName('ITE_IMPULT').AsFloat := fStrToFloat(strImpUlt);
      FieldByName('ITE_DENSID').AsFloat := fStrToFloat(fCampoTabela('ITE_DENSID', 'CADITE', ['ITE_CODITE'], [strCodIte]));
      If rdgPrecos.ItemIndex > 0 Then
        FieldByName('TOTITE').AsFloat       := FieldByName(fRetCampoPreco(rdgPrecos.ItemIndex, cmbPreVen.Text)).AsFloat * fRetQtdCalc;
      FieldByName('DMT_SEQGER').AsInteger := 1;

      FieldByName('MASSA').AsFloat      := fltQtdIte  * FieldByName('ITE_DENSID').AsFloat;

      If blnUtilizaVendaMadeira Then
      Begin
        FieldByName('DMT_QTDPEC').AsFloat := fltQtdPec;
        FieldByName('DMT_COMPEC').AsFloat := fltComPec;
        FieldByName('DMT_LARPEC').AsFloat := fltLarPec;
        FieldByName('DMT_ESPPEC').AsFloat := fltEspPec;
        FieldByName('DMT_APAREL').AsString := strAparel;
        FieldByName('DMT_BENEFI').AsString := strBenefi;
        FieldByName('DMT_PERAPA').AsFloat := fltPerApa;
        FieldByName('DMT_PERBEN').AsFloat := fltPerBen;
      End;

      If Not fEmptyStr(strCodIte) Then
        FieldByName('DMT_DESCRI').AsString := edtDesSubProduto.Text
      Else
        FieldByName('DMT_DESCRI').AsString := strDescri;

      FieldByName('DMT_REFERE').AsString := edtSubReferencia.Text;
      FieldByName('DMT_DESPCA').AsString := strDestino;
      FieldByName('DMT_ACUMOP').AsString := strAcumOp;
      FieldByName('ESTRUR').AsString := IfThen(fItemEstrutura(strCodIte), 'S', 'N');

      Post;
    End;
  End
  Else
  Begin
    cdsConsulta.Edit;

    If fEmptyStr(strCodIte) Then
      cdsConsulta.FieldByName('DMT_DESCRI').AsString := strDescri;

    cdsConsulta.FieldByName('DMT_QTDITE').AsFloat := fltQtdIte;
    cdsConsulta.FieldByName('DMT_DESPCA').AsString := strDestino;
    cdsConsulta.FieldByName('DMT_ACUMOP').AsString := strAcumOp;
    cdsConsulta.FieldByName('DMT_PRESUB').AsFloat := fltPreSub;
    If rdgPrecos.ItemIndex > 0 Then
     cdsConsulta.FieldByName('TOTITE').AsFloat      := cdsConsulta.FieldByName(fRetCampoPreco(rdgPrecos.ItemIndex, cmbPreVen.Text)).AsFloat * fRetQtdCalc;
    If blnUtilizaVendaMadeira Then
    Begin
      cdsConsulta.FieldByName('DMT_QTDPEC').AsFloat := fltQtdPec;
      cdsConsulta.FieldByName('DMT_COMPEC').AsFloat := fltComPec;
      cdsConsulta.FieldByName('DMT_LARPEC').AsFloat := fltLarPec;
      cdsConsulta.FieldByName('DMT_ESPPEC').AsFloat := fltEspPec;
      cdsConsulta.FieldByName('DMT_APAREL').AsString := strAparel;
      cdsConsulta.FieldByName('DMT_BENEFI').AsString := strBenefi;
      cdsConsulta.FieldByName('DMT_PERAPA').AsFloat := fltPerApa;
      cdsConsulta.FieldByName('DMT_PERBEN').AsFloat := fltPerBen;
    End;
    cdsConsulta.FieldByName('MASSA').AsFloat := fltQtdIte  * cdsConsulta.FieldByName('ITE_DENSID').AsFloat;

    cdsConsulta.Post;
  End;

  intSequenAlt := 0;
end;

procedure TfrmCadEstruturas.pLimparDados;
begin
  pLimparDadosSub;
  pDeletaTemporaria;

  pnlProdutos.Enabled := True;
  pnlSubProdutos.Enabled := False;
  pnlQuantidade.Enabled := False;
  pnlQtdMadeira.Enabled := False;
  edtProdutos.ReadOnly := False;
  edtProdutos.Clear;
  pSetFocus(edtProdutos);
  edtDesProduto.Clear;
  edtReferencia.Clear;
  edtUnidade.Clear;
  edtCodFabrica.Clear;
  cxgDados.Enabled := False;
  btnConfirma.Enabled := False;
  btnApaga.Enabled := False;
  btnEditar.Enabled := False;
  btnImprimir.Enabled := False;
  btnEstrutura.Enabled := True;
  btnComentario.Enabled := False;
  btnMoveCima.Enabled := False;
  btnMoveBaixo.Enabled := False;
  cbxTipQtd.ItemIndex := 0;
  objLayEst.Clear;

{  rdgPrecos.ItemIndex := 0;
  rdgPrecosClick(rdgPrecos);}
  if btnLayouts.Visible then
    btnLayouts.Enabled := False;

  strSeqGer := '';
  strObs001 := '';
  strObs002 := '';
  strObs003 := '';
  strObs004 := '';
  strObs005 := '';
  strObs006 := '';
  strObs007 := '';


  pgcPagina.ActivePageIndex := 0;

end;


procedure TfrmCadEstruturas.pLimparDadosSub;
begin
  edtSubProduto.Clear;
  edtDesSubProduto.Clear;
  edtSubReferencia.Clear;
  edtSubUnidade.Clear;
  edtSubQtdIte.Clear;
  edtSubDestino.Clear;
  edtQtdPec.Clear;
  edtComPec.Clear;
  edtLarPec.Clear;
  edtEspPec.Clear;
  edtPerApa.Clear;
  edtPerBen.Clear;
  edtFatorPrecoVenda.Clear;

  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, 0);
  edtQtdPec.Text := FormatFloat(edtQtdPec.EditFormat, 0);
  edtComPec.Text := FormatFloat(edtComPec.EditFormat, 0);
  edtLarPec.Text := FormatFloat(edtLarPec.EditFormat, 0);
  edtEspPec.Text := FormatFloat(edtEspPec.EditFormat, 0);
  edtPerApa.Text := FormatFloat(edtPerApa.EditFormat, 0);
  edtPerBen.Text := FormatFloat(edtPerBen.EditFormat, 0);
  edtFatorPrecoVenda.Text := FormatFloat(edtFatorPrecoVenda.EditFormat, 0);

  edtAparel.Text := 'N';
  edtBenefi.Text := 'N';
  edtAcumOp.Text := 'S';
end;

procedure TfrmCadEstruturas.pMostraPedPendentes(Const strAcao: String);
  Var
    strPedPendentes: String;
begin
  strPedPendentes := fBuscaPedPendentes;

  If Not fEmptyStr(strPedPendentes) Then
  Begin
    strPedPendentes := WrapText(strPedPendentes, sLineBreak, [' '], 50);

    TfrmMemo.pShowMessage(
      'ATENÇÃO: Existem Pedidos/Orçamentos em aberto, com o produto '+ edtProdutos.Text +' entre os itens.'+ sLineBreak + sLineBreak +
      'Para a baixa correta de estoque do produto, após a '+ strAcao +' da estrutura é necessário regravar o(s) '+
      'documentos(s) a seguir, excluindo e incluindo novamente o item estrutura do PD/OR:'+
      sLineBreak + sLineBreak + strPedPendentes, 18);
  End;
end;

procedure TfrmCadEstruturas.cbxTipQtdChange(Sender: TObject);
begin
  inherited;
  if cbxTipQtd.Text = 'QUANTIDADE' Then
  begin
    TAggregatefield(cdsConsulta.AggFields.FieldByName('SUM_QTDITE')).DisplayFormat :=  fMskDigitos(intQtdDigitos);
  end
  else
  begin
    TAggregatefield(cdsConsulta.AggFields.FieldByName('SUM_QTDITE')).DisplayFormat :=  fMskDigitos(intQtdDigitos) + '"%"';
  end;
end;

procedure TfrmCadEstruturas.rdgPrecosClick(Sender: TObject);
begin
  inherited;
  cxgDadosTableViewTOTITE.Visible := (rdgPrecos.ItemIndex > 0);
  cxgDadosTableViewITE_PREVE1.Visible := (rdgPrecos.ItemIndex > 0);
  lblTotal.Visible := (rdgPrecos.ItemIndex > 0);
  pnlTotal.Visible := (rdgPrecos.ItemIndex > 0);
  cmbPreVen.Enabled := (rdgPrecos.ItemIndex = 5);

  If  cxgDadosTableViewTOTITE.Visible Then
  Begin
    pCalculaTotal;
    cxgDadosTableViewITE_PREVE1.DataBinding.FieldName := fRetCampoPreco(rdgPrecos.ItemIndex, cmbPreVen.Text);
  End;
  pPosicionaPanels;
end;

procedure TfrmCadEstruturas.cmbPreVenChange(Sender: TObject);
begin
  inherited;
  If cxgDadosTableViewITE_PREVE1.Visible Then
  Begin
    pCalculaTotal;
    cxgDadosTableViewITE_PREVE1.DataBinding.FieldName := fRetCampoPreco(rdgPrecos.ItemIndex, cmbPreVen.Text);
  End;

end;

procedure TfrmCadEstruturas.cxgDadosTableViewColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  pPosicionaPanels;
end;

procedure TfrmCadEstruturas.cxgDadosTableViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  pPosicionaPanels;

end;

procedure TfrmCadEstruturas.cxgDadosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosTableViewESTRUR.Index] = 'S') Then
    ACanvas.Font.Color := clRed;

end;

procedure TfrmCadEstruturas.cxgDadosTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelaItem.Click;
  End
  Else If (Key = VK_Return) Then
  Begin
    btnEditar.Click;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaItem;
  End;

end;

procedure TfrmCadEstruturas.cxgDados_TableViewColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  pPosicionaPanels;
end;

procedure TfrmCadEstruturas.cxgDados_TableViewColumnSizeChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  pPosicionaPanels;
end;

procedure TfrmCadEstruturas.cxgDados_TableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDadosTableViewESTRUR.Index] = 'S') Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmCadEstruturas.cxgDados_TableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelaItem.Click;
  End
  Else If (Key = VK_Return) Then
  Begin
    btnEditar.Click;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaItem;
  End;
end;

procedure TfrmCadEstruturas.cxgEteMatTableViewDblClick(Sender: TObject);
begin
  inherited;
  pCarregaEteMatEdicao;
end;

procedure TfrmCadEstruturas.cxgEteMatTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pCarregaEteMatEdicao
  Else
    If Key = VK_DELETE Then
      If fMensagem('', 'Deseja excluir a especificação técnica?', ['&Sim', '&Não'], 2) = 1 Then
        cdsEteMat.Delete;

end;

function TfrmCadEstruturas.fRetCampoPreco(intItemIndex : Integer; strTabPre : String): String;
begin
  Case intItemIndex Of
    1 : Result := 'ITE_PRECUS';
    2 : Result := 'ITE_PREULT';
    3 : Result := 'ITE_IMPULT';
    4 : Result := 'ITE_PREMED';
    5 : Result := 'ITE_PREVE' + strTabPre;
  End;

end;

function TfrmCadEstruturas.fRetCustoItem(strCodIte:String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PRECUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PRECUS').AsString;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function TfrmCadEstruturas.fRetImpUlt(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_IMPULT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_IMPULT').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreUlt(strCodIte: String): String;
  Var
    strSQL: String;
   qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREULT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREULT').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;

end;

function TfrmCadEstruturas.fRetPreVenda1(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE1 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
       Result := FieldByName('ITE_PREVE1').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda2(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE2 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE2').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda3(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE3 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE3').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda4(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE4 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE4').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda5(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE5 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE5').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda6(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE6 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE6').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetPreVenda7(strCodIte: String): String;
  Var
    strSQL: String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE7 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ITE_CODITE = :CODITE ';
    strSQL := strSQL + '  AND ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('ITE_PREVE7').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturas.fRetSeqGer: String;
begin
  With cdsConsulta Do
  Begin
    If TAggregateField(FieldByName('MAX_SEQGER')).Value = Null Then
      Result := '1'
    Else
      Result := IntToStr(Trunc(TAggregateField(FieldByName('MAX_SEQGER')).Value) + 1);
  End;
end;


function TfrmCadEstruturas.fRetSQLCarregaEstrutura: String;
  var
    strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + '  SELECT G.AUTOINCREM, ';
  strSQL := strSQL + '    DMT_SEQUEN, ';
  strSQL := strSQL + '    DMT_CODEMP, ';
  strSQL := strSQL + '    DMT_ITESUB, ';
  strSQL := strSQL + '    IF(DMT_ITESUB IS NULL, DMT_DESCRI, ITE_DESITE) AS DMT_DESCRI, ';
  strSQL := strSQL + '    DMT_REFERE, ';
  strSQL := strSQL + '    DMT_QTDITE, ';
  strSQL := strSQL + '    DMT_DESPCA, ';
  strSQL := strSQL + '    DMT_CUSITE, ';
  strSQL := strSQL + '    DMT_ACUMOP, ';
  strSQL := strSQL + '    DMT_PRESUB, ';
  strSQL := strSQL + '    GMT_TIPQTD, ';

  If blnUtilizaVendaMadeira Then
  Begin
    strSQL := strSQL + '  DMT_QTDPEC, ';
    strSQL := strSQL + '  DMT_COMPEC, ';
    strSQL := strSQL + '  DMT_LARPEC, ';
    strSQL := strSQL + '  DMT_ESPPEC, ';
    strSQL := strSQL + '  DMT_APAREL, ';
    strSQL := strSQL + '  DMT_BENEFI, ';
    strSQL := strSQL + '  DMT_PERAPA, ';
    strSQL := strSQL + '  DMT_PERBEN, ';
  End
  Else
  Begin
    strSQL := strSQL + '  0.00 AS DMT_QTDPEC, ';
    strSQL := strSQL + '  0.00 AS DMT_COMPEC, ';
    strSQL := strSQL + '  0.00 AS DMT_LARPEC, ';
    strSQL := strSQL + '  0.00 AS DMT_ESPPEC, ';
    strSQL := strSQL + '  0.00 AS DMT_APAREL, ';
    strSQL := strSQL + '  0.00 AS DMT_BENEFI, ';
    strSQL := strSQL + '  0.00 AS DMT_PERAPA, ';
    strSQL := strSQL + '  0.00 AS DMT_PERBEN, ';
  End;

  strSQL := strSQL + '    ITE_PREVE1, ';
  strSQL := strSQL + '    ITE_PREVE2, ';
  strSQL := strSQL + '    ITE_PREVE3, ';
  strSQL := strSQL + '    ITE_PREVE4, ';
  strSQL := strSQL + '    ITE_PREVE5, ';
  strSQL := strSQL + '    ITE_PREVE6, ';
  strSQL := strSQL + '    ITE_PREVE7, ';
  strSQL := strSQL + '    ITE_PRECUS, ';
  strSQL := strSQL + '    ITE_PREMED, ';
  strSQL := strSQL + '    ITE_PREULT, ';
  strSQL := strSQL + '    ITE_IMPULT, ';
  strSQL := strSQL + '0.00 AS TOTITE, ';
  strSQL := strSQL + '    ITE_DTAULT, ';
  strSQL := strSQL + '    ITE_CODFAB, ';
  strSQL := strSQL + '    ITE_DENSID, ';
  strSQL := strSQL + '    UNI_SIGUNI, ';
  strSQL := strSQL + 'IFNULL(DMT_QTDITE * ITE_DENSID, 0.00) AS MASSA, ';
  strSQL := strSQL + 'IF((SELECT COUNT(0) FROM '+fRetTabGer+' WHERE GMT_CODITE = DMT_ITESUB) > 0, "S","N") ESTRUR, ';

  strSQL := strSQL + '    DMT_SEQGER,  ';

  strSQL := strSQL + '    G.GMT_OBS001,  ';
  strSQL := strSQL + '    G.GMT_OBS002,  ';
  strSQL := strSQL + '    G.GMT_OBS003,  ';
  strSQL := strSQL + '    G.GMT_OBS004,  ';
  strSQL := strSQL + '    G.GMT_OBS005,  ';
  strSQL := strSQL + '    G.GMT_OBS006,  ';
  strSQL := strSQL + '    G.GMT_OBS007  ';

  strSQL := strSQL + '  FROM ';
  strSQL := strSQL + '    '+fRetTabDet+' ';
  strSQL := strSQL + '    JOIN '+fRetTabGer+' G ON DMT_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '    LEFT JOIN CADITE ON DMT_ITESUB = CADITE.ITE_CODITE ';
  strSQL := strSQL + '    LEFT JOIN ITEGER I ON DMT_ITESUB = I.ITE_CODITE AND I.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + '    LEFT JOIN CADUNI U ON ITE_CODUNI = U.UNI_CODUNI ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '    G.GMT_CODITE = :CODITE ';

  If FModoEstruturaPersonalizada Then
  Begin
    strSQL := strSQL + ' AND G.GMT_SEQPER = :SEQPER ';
    strSQL := strSQL + ' AND   DMT_SEQPER = :SEQPER ';
  End;

  Result := strSQL;

end;

function TfrmCadEstruturas.fRetTabDet: String;
begin

  Result := 'DETMAT';

  If (FModoEstruturaPersonalizada) Then
    If Assigned(FobjEstruturaPersonalizada) Then
      If Not FobjEstruturaPersonalizada.strTabTmpDet.IsEmpty Then
        Result := FobjEstruturaPersonalizada.strTabTmpDet;

end;

function TfrmCadEstruturas.fRetTabGer: String;
begin

  Result := 'GERMAT';

  If (FModoEstruturaPersonalizada) Then
    If Assigned(FobjEstruturaPersonalizada) Then
      If Not FobjEstruturaPersonalizada.strTabTmpGer.IsEmpty Then
        Result := FobjEstruturaPersonalizada.strTabTmpGer;

end;

procedure TfrmCadEstruturas.pHabilitaCampos;
begin
  If not fValidaPanel(pnlProdutos) Then
    Exit;

  if btnLayouts.Visible then
  begin
    If objLayEst.cdsLayGmt.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Selecione o Layout de Impressão para Ordem de Produção!', ['&O K']);
      btnLayouts.Click;
      exit;
    end;
  End;

  blnMudarFoco := False;
  pnlSubProdutos.Enabled := True;
  pnlQuantidade.Enabled := True;
  pnlQtdMadeira.Enabled := True;
  cxgDados.Enabled := True;
  pnlProdutos.Enabled := False;
  btnEstrutura.Enabled := False;
  pSetFocus(edtsubProduto);
end;

procedure TfrmCadEstruturas.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDadosSub;
  pSetFocus(edtSubProduto);
end;

procedure TfrmCadEstruturas.btnEditarClick(Sender: TObject);
begin

  inherited;

  If FModoEstruturaPersonalizada Then
    pCarregaItemAlteracao;

  If btnEditar.Enabled Then
    pCarregaItemAlteracao;

end;

procedure TfrmCadEstruturas.btnEstruturaClick(Sender: TObject);
begin
  fBuscaEstrutura(False);
  rdgPrecosClick(Sender);
end;

procedure TfrmCadEstruturas.btnExiEstruturaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('CPEXTR', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not btnExiEstrutura.Visible Then
    Exit;

  pMostraEstrutura(cdsConsulta.FieldByName('DMT_ITESUB').AsString);

end;

procedure TfrmCadEstruturas.pDeletaItem;
begin
  Try
    If Not cdsConsulta.IsEmpty Then
      cdsConsulta.Delete;

    If cdsConsulta.IsEmpty Then
    Begin
      btnConfirma.Enabled := False;
      btnEditar.Enabled := False;
      btnImprimir.Enabled := False;
      btnComentario.Enabled := False;
      btnMoveCima.Enabled := False;
      btnMoveBaixo.Enabled := False;
    End;
  Finally

  End;
end;

procedure TfrmCadEstruturas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;
end;

procedure TfrmCadEstruturas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (ActiveControl.Parent = pnlSubProdutos) Then
  Begin
    Key := 0;
    If ( fMensagem( '', 'Cancela edição da Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    pLimparDados;
  End;

  inherited;

  If btnEstrutura.Enabled Then
  Begin
    If (Key = VK_F3) Then
      btnEstrutura.Click;
  End;

  If btnImprimir.Enabled Then
  Begin
    If (Key = VK_F5) Then
      btnImprimir.Click;
  End;

  If btnComentario.Enabled Then
  Begin
    If (Key = VK_INSERT) Then
      btnComentario.Click;
  End;

  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
      btnConfirma.Click;
  End;

  If btnApaga.Enabled Then
  Begin
    If (Key = VK_F2) Then
    Begin
      btnApaga.Click;
      Key := 0;
    End;
  End;

  If btnExiEstrutura.Visible Then
  Begin
    If (Key = VK_F8) And (Shift = [ssAlt]) Then
    Begin
      btnExiEstrutura.Click;
      Key := 0;
    End;
  End;

end;

procedure TfrmCadEstruturas.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.Width - btnSair.Width - 5;
end;

procedure TfrmCadEstruturas.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
    qryGerMat: TUniQuery;
    strSequen: String;
    fltQtdPec,
    fltComPec,
    fltLarPec,
    fltEspPec: Double;
    strAparel,
    strBenefi: String;
    fltPerApa,
    fltPerBen : Double;
begin

 inherited;

  If (cdsConsulta.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 subproduto!', ['&Ok']);
    Exit;
  End;

  If (cbxTipQtd.Text = 'PORCENTAGEM') and (RoundTo(fDoubleAggregate(cdsConsulta, 'SUM_QTDITE'), -2) <> 100) then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual total dos Sub. Produtos tem que fechar ' +
                          'em 100% !', ['&Ok']);
    Exit;
  End;

  If FModoEstruturaPersonalizada Then
  Begin
    pConfirmarEstruturaPersonalizada;
    ModalResult := mrOk;
    Exit;
  End;

  Try
    pCriarFormularios(TfrmObsEstrutura, frmObsEstrutura);

    frmObsEstrutura.edtObs01.Text := strObs001;
    frmObsEstrutura.edtObs02.Text := strObs002;
    frmObsEstrutura.edtObs03.Text := strObs003;
    frmObsEstrutura.edtObs04.Text := strObs004;
    frmObsEstrutura.edtObs05.Text := strObs005;
    frmObsEstrutura.edtObs06.Text := strObs006;
    frmObsEstrutura.edtObs07.Text := strObs007;

    frmObsEstrutura.ShowModal;

    blnConfirma := frmObsEstrutura.blnConfirma;

    If blnConfirma Then
    Begin
     strObs001 := frmObsEstrutura.edtObs01.Text;
     strObs002 := frmObsEstrutura.edtObs02.Text;
     strObs003 := frmObsEstrutura.edtObs03.Text;
     strObs004 := frmObsEstrutura.edtObs04.Text;
     strObs005 := frmObsEstrutura.edtObs05.Text;
     strObs006 := frmObsEstrutura.edtObs06.Text;
     strObs007 := frmObsEstrutura.edtObs07.Text;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmCadEstruturas.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmObsEstrutura);

  { ******************************************** }
  { * VERIFICA SE A ESTRUTURA EXISTE NO BANCO  * }
  { * SE EXISTIR APAGA                         * }
  { *****************************************LB* }

  If Not blnConfirma Then
    Exit;

  //cadastrando nova estrutura
  If fEmptyStr(strSeqGer) And fMovimentaSubItemNaVenda Then
  Begin
    pMostraPedPendentes('gravação');

    If Not fPergunta('Confirma a inclusão da estrutura?') Then
      Exit;
  End;

  Try
    fStartTransaction;

    Try
      qryGerMat := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + ' '+fRetTabGer+' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  GMT_CODITE = :CODITE ';

      With qryGerMat Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := edtProdutos.Text;
        ExecSQL;
        Close;
      End;

    Finally
      FreeAndNil(qryGerMat);
    End;

    {*********************************** }
    {* EFETUA A GRAVAÇÃO NO BANCO      * }
    {********************************LB* }

    fGravaGerMat(strAutoInc,
                 VS_strCodEmp,
                 edtProdutos.Text,
                 edtReferencia.Text,
                 strObs001,
                 strObs002,
                 strObs003,
                 strObs004,
                 cbxTipQtd.Text[1],
                 strObs005,
                 strObs006,
                 strObs007,
                 fRetTabGer);

    objLayEst.cdsLayGmt.fSalva();

    With cdsConsulta Do
    Begin
      strSequen := '0';
      First;
      While Not(Eof) Do
      Begin
        If fEmptyStr(FieldByName('DMT_ITESUB').AsString) Then
          strDescri := FieldByName('DMT_DESCRI').AsString
        Else
          strDescri := '';

        If blnUtilizaVendaMadeira Then
        Begin
          fltQtdPec := FieldByName('DMT_QTDPEC').AsFloat;
          fltComPec := FieldByName('DMT_COMPEC').AsFloat;
          fltLarPec := FieldByName('DMT_LARPEC').AsFloat;
          fltEspPec := FieldByName('DMT_ESPPEC').AsFloat;
          strAparel := FieldByName('DMT_APAREL').AsString;
          strBenefi := FieldByName('DMT_BENEFI').AsString;
          fltPerApa := FieldByName('DMT_PERAPA').AsFloat;
          fltPerBen := FieldByName('DMT_PERBEN').AsFloat;
        End
        Else
        Begin
          fltQtdPec := 0;
          fltComPec := 0;
          fltLarPec := 0;
          fltEspPec := 0;
          strAparel := 'N';
          strBenefi := 'N';
          fltPerApa := 0;
          fltPerBen := 0;
        End;

        strSequen := fStrZero(IntToStr(StrToInt(strSequen) + 1),6);
        fGravaDetMat(strAutoInc,
                     strSequen,
                     VS_strCodEmp,
                     FieldByName('DMT_ITESUB').AsString,
                     strDescri,
                     FieldByName('DMT_DESPCA').AsString,
                     FieldByName('DMT_REFERE').AsString,
                     FieldByName('DMT_QTDITE').AsFloat,
                     FieldByName('DMT_CUSITE').AsString,
                     FieldByName('DMT_ACUMOP').AsString,
                     fltQtdPec,
                     fltComPec,
                     fltLarPec,
                     fltEspPec,
                     strAparel,
                     strBenefi,
                     fltPerApa,
                     fltPerBen,
                     FieldByName('DMT_PRESUB').AsFloat,
                     fRetTabDet);

        Next;
      End;
    End;

    If blnQualidadeEstrutura Then
    Begin
      With cdsEteMat Do
      Begin
        Try
          DisableControls;
          First;
          While Not Eof Do
          Begin
            fGravaEteMat(strAutoInc,
                         FieldByName('ETM_CODETE').AsString,
                         FieldByName('ETM_VALMIN').AsFloat,
                         FieldByName('ETM_VALMAX').AsFloat);
            Next;
          End;
        Finally
          EnableControls;
        End;
      End;
    End;

    If blnMONFAS Then
      fSalvarFases(strAutoInc);

    pLimparDados;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadEstruturas.btnConfirmaClick]');
    End;
  End;
end;

procedure TfrmCadEstruturas.btnComentarioClick(Sender: TObject);
begin
  pTrataComentario(toIncluir);
end;


procedure TfrmCadEstruturas.pTrataComentario(enuTipoOperacao : TTipoOperacao);
begin
  If not btnComentario.Visible Then
  begin
    intSequenAlt := 0;
    Exit;
  end;

  Try
    Try
      pCriarFormularios(TfrmComentEstrutura, frmComentEstrutura);
      frmComentEstrutura.blnIndustrial  := False;

      if enuTipoOperacao = toEditar then
        frmComentEstrutura.edtComentario.Text := cdsConsulta.FieldByName('DMT_DESCRI').AsString
      else
        intSequenAlt := 0;

      frmComentEstrutura.ShowModal;
      blnConfirma := frmComentEstrutura.blnConfirma;


      If blnConfirma Then
      Begin
        strComent := frmComentEstrutura.edtComentario.Text;
        pGravaTemporaria('',strComent,'', '', 0.00, 0.00, 0.00, 0.00, 0.00, '', '', 0.00, 0.00, 1.000);
      End
      else
        intSequenAlt := 0;


    Except
     On E: Exception Do
     Begin
       pMensagensErro(E.Message, '[frmCadEstruturas.btnComentarioClick]');
     End;
    End;
  Finally
    If Assigned(frmComentEstrutura) then
      FreeAndNil(frmComentEstrutura);
  end;
end;

procedure TfrmCadEstruturas.pCalculaQuantidadeMetrosCubicos;
  Var
   qryCadUni: TUniQuery;
begin
  qryCadUni := fCriaQuery(Self);
  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat,
                                   fCalculaQuantidadeMetrosCubicos(fStrToFloat(edtQtdPec.Text),
                                                                   fStrToFloat(edtComPec.Text),
                                                                   fStrToFloat(edtLarPec.Text),
                                                                   fStrToFloat(edtEspPec.Text),
                                                                   fRetSiglaUnidade(edtSubUnidade.Text, qryCadUni)));
  FreeAndNil(qryCadUni);
end;

procedure TfrmCadEstruturas.pCalculaTotal;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fCalculaTotal;
  frmGravando.lblGravando.Caption := 'Calculando totais...';
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);
end;

function TfrmCadEstruturas.fRetQtdCalc : real;
begin
  Result := cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;

  if fCfgSis('DENMAS', varBoolean) then
  begin
    if cdsConsulta.FieldByName('ITE_DENSID').AsFloat > 0 Then
      Result := Result * cdsConsulta.FieldByName('ITE_DENSID').AsFloat;
  end;

  if cbxTipQtd.Text = 'PORCENTAGEM' then
    Result := Result/100;
end;

function TfrmCadEstruturas.fCalculaTotal(cxProgresso: TcxProgressBar): Boolean;
  Var
    BookMark: TBookMark;
begin
  Try
    Result := True;
    BookMark := cdsConsulta.Bookmark;
    cdsConsulta.DisableControls;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If rdgPrecos.ItemIndex > 0 Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('TOTITE').AsFloat := cdsConsulta.FieldByName(fRetCampoPreco(rdgPrecos.ItemIndex, cmbPreVen.Text)).AsFloat * fRetQtdCalc;
        cdsConsulta.Post;
      End;
      cdsConsulta.Next;
    End;

  Finally
    cdsConsulta.Bookmark := BookMark;
    cdsConsulta.EnableControls;
  End;
end;

function TfrmCadEstruturas.fLeftColumn(objColumn: TcxGridDBColumn): Integer;
var
  i : integer;
begin
  Result := 0;

  for i := 0 to  cxgDadosTableView.ColumnCount - 1 do
  begin
    if cxgDadosTableView.Columns[i] = objColumn then
    Begin
      Result := Result + cxgDadosTableView.Columns[i].Width;
      Break;
    End
    Else
    begin
      if cxgDadosTableView.Columns[i].Visible then
        Result := Result + cxgDadosTableView.Columns[i].Width;
    end;
  end;
end;

function TfrmCadEstruturas.fMovimentaSubItemNaVenda: Boolean;
begin
  Result := False;

  If fCfgSis('CAREST') = 'P' Then //Carrega sempre Sub-Produtos
    Exit;

  If fCfgSis('BXSBIT') = '1' Then //Item estrutura
    Exit;

  Result := True;
end;

procedure TfrmCadEstruturas.pCarregaEstrutura;
  Var
    blnImpEstrutura: Boolean;
    strCodIte: String;
    intQtdeReg: Integer;
begin

  blnImpEstrutura := False;
  strCodIte       := '';
  strSeqGer       := '';
  intQtdeReg      := fCampoTabela('COUNT(*) AS QTD', fRetTabGer, ['GMT_CODITE'], [edtProdutos.Text]);

  If (intQtdeReg = 0) Then
  Begin
    btnApaga.Enabled := False;
    blnImpEstrutura := True;
  End
  Else
  Begin
    btnApaga.Enabled := True;
  End;

  If blnImpEstrutura And (fMensagem('', 'Importar Estrutura?', ['&Sim', '&Não']) = 1) Then
  Begin
    strCodIte := fBuscaEstrutura( True );
  End;
  blnMudarFoco := False;

  With qryConsulta Do
  Begin
    cdsConsulta.Close;
    Close;
    SQL.Clear;
    SQL.Add(fRetSQLCarregaEstrutura);

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If ( blnImpEstrutura ) And ( Not fEmptyStr( strCodIte ) ) Then
      ParamByName('CODITE').AsString := strCodIte
    Else
     ParamByName('CODITE').AsString := edtProdutos.Text;

    If FModoEstruturaPersonalizada Then
      If Assigned(FindParam('SEQPER')) And Assigned(FobjEstruturaPersonalizada) Then
        ParamByName('SEQPER').AsInteger := FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada;

    Open;

    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    cdsConsulta.IndexFieldNames := 'DMT_SEQUEN';

    If blnMONFAS Then
      pCarregaFases(strCodIte);
  End;

  With cdsConsulta Do
  Begin
    TFloatField(FieldByName('DMT_QTDITE')).DisplayFormat := fMskDigitos(intQtdDigitos);
    TFloatField(FieldByName('DMT_QTDITE')).EditFormat := fMskDigitos(intQtdDigitos);
    TAggregatefield(cdsConsulta.AggFields.FieldByName('SUM_QTDITE')).DisplayFormat :=  fMskDigitos(intQtdDigitos);

    strObs001 := FieldByName('GMT_OBS001').AsString;
    strObs002 := FieldByName('GMT_OBS002').AsString;
    strObs003 := FieldByName('GMT_OBS003').AsString;
    strObs004 := FieldByName('GMT_OBS004').AsString;
    strObs005 := FieldByName('GMT_OBS005').AsString;
    strObs006 := FieldByName('GMT_OBS006').AsString;
    strObs007 := FieldByName('GMT_OBS007').AsString;

    TFloatField(FieldByName('DMT_PRESUB')).DisplayFormat := edtFatorPrecoVenda.EditFormat;
    TFloatField(FieldByName('DMT_PRESUB')).EditFormat := edtFatorPrecoVenda.EditFormat;

    If blnUtilizaVendaMadeira Then
    Begin
     TFloatField(FieldByName('DMT_QTDPEC')).DisplayFormat := edtQtdPec.EditFormat;
     TFloatField(FieldByName('DMT_QTDPEC')).EditFormat := edtQtdPec.EditFormat;

     TFloatField(FieldByName('DMT_COMPEC')).DisplayFormat := edtComPec.EditFormat;
     TFloatField(FieldByName('DMT_COMPEC')).EditFormat := edtComPec.EditFormat;

     TFloatField(FieldByName('DMT_LARPEC')).DisplayFormat := edtLarPec.EditFormat;
     TFloatField(FieldByName('DMT_LARPEC')).EditFormat := edtLarPec.EditFormat;

     TFloatField(FieldByName('DMT_ESPPEC')).DisplayFormat := edtEspPec.EditFormat;
     TFloatField(FieldByName('DMT_ESPPEC')).EditFormat := edtEspPec.EditFormat;

     TFloatField(FieldByName('DMT_PERAPA')).DisplayFormat := edtPerApa.EditFormat;
     TFloatField(FieldByName('DMT_PERAPA')).EditFormat := edtPerApa.EditFormat;

     TFloatField(FieldByName('DMT_PERBEN')).DisplayFormat := edtPerBen.EditFormat;
     TFloatField(FieldByName('DMT_PERBEN')).EditFormat := edtPerBen.EditFormat;
    End;

    TFloatField(FieldByName('ITE_PREVE1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PRECUS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREMED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREULT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IMPULT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('TOTITE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DENSID')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('MASSA')).DisplayFormat := '#,##0.00';
  End;

  If Not cdsConsulta.IsEmpty Then
  Begin
    If fEmptyStr(strCodIte) Then
      strSeqGer := cdsConsulta.FieldByName('DMT_SEQGER').AsString;
    pAttTipoQtd(cdsConsulta.FieldByName('GMT_TIPQTD').AsString);
    btnConfirma.Enabled := True;
    btnEditar.Enabled := True;
    btnImprimir.Enabled := True;
    btnComentario.Enabled := True;
    btnMoveCima.Enabled := True;
    btnMoveBaixo.Enabled := True;
    cdsConsulta.AfterScroll := pCdsConsultaAfterScroll;
    pCdsConsultaAfterScroll(cdsConsulta);
    cxgDadosTableView.ApplyBestFit();
    pPosicionaPanels;
  End;

  If blnQualidadeEstrutura Then
  Begin
    cdsEteMat.qryQuery.Close;
    cdsEteMat.qryQuery.ParamByName('SEQMAT').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
    cdsEteMat.fAbreClient(True, 'TfrmCadEstruturas.pCarregaEstrutura');

    TFloatField(cdsEteMat.FieldByName('ETM_VALMIN')).DisplayFormat := fMskDigitos(4);
    TFloatField(cdsEteMat.FieldByName('ETM_VALMAX')).DisplayFormat := fMskDigitos(4);

    cxgEteMatTableView.DataController.DataSource := cdsEteMat.dtsSource;
    pLimpaEteMat;
  End;

end;

procedure TfrmCadEstruturas.pCdsConsultaAfterScroll(DataSet : TDataSet);
Begin
  btnExiEstrutura.Visible := DataSet.FieldByName('ESTRUR').AsString = 'S';
End;

procedure TfrmCadEstruturas.pConfirmarEstruturaPersonalizada;
  var
    strAutInc : String;
    strSequen : String;
begin

  Try

    fStartTransaction;

    strAutInc := FobjEstruturaPersonalizada.fRetAutIncByPerSeq(FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada, fRetTabGer);

    fExecutaSQL('DELETE FROM ' + fRetTabGer + ' WHERE GMT_SEQPER = ' + FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada.ToString);
    fExecutaSQL('DELETE FROM ' + fRetTabDet + ' WHERE DMT_SEQPER = ' + FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada.ToString);

    fGravaGerMat(strAutInc,
                 VS_strCodEmp,
                 edtProdutos.Text,
                 edtReferencia.Text,
                 strObs001,
                 strObs002,
                 strObs003,
                 strObs004,
                 cbxTipQtd.Text[1],
                 strObs005,
                 strObs006,
                 strObs007,
                 fRetTabGer);

    With cdsConsulta Do
    Begin

      strSequen := '0';
      First;

      While Not(Eof) Do
      Begin

        If fEmptyStr(FieldByName('DMT_ITESUB').AsString) Then
          strDescri := FieldByName('DMT_DESCRI').AsString
        Else
          strDescri := '';

        strSequen := fStrZero(IntToStr(StrToInt(strSequen) + 1),6);
        fGravaDetMat(strAutInc,
                     strSequen,
                     VS_strCodEmp,
                     FieldByName('DMT_ITESUB').AsString,
                     strDescri,
                     FieldByName('DMT_DESPCA').AsString,
                     FieldByName('DMT_REFERE').AsString,
                     FieldByName('DMT_QTDITE').AsFloat,
                     FieldByName('DMT_CUSITE').AsString,
                     FieldByName('DMT_ACUMOP').AsString,
                     0,
                     0,
                     0,
                     0,
                     'N',
                     'N',
                     0,
                     0,
                     FieldByName('DMT_PRESUB').AsFloat,
                     fRetTabDet);

        Next;

      End;

    End;

    fExecutaSQL('UPDATE ' + fRetTabGer + ' SET GMT_SEQPER = ' + FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada.ToString + ' WHERE GMT_SEQPER IS NULL');
    fExecutaSQL('UPDATE ' + fRetTabDet + ' SET DMT_SEQPER = ' + FobjEstruturaPersonalizada.intSequencialDaEstruturaPersonalizada.ToString + ' WHERE DMT_SEQPER IS NULL');

    pLimparDados;
    fCommit;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pConfirmarEstruturaPersonalizada]');
    End;
  End;

end;

procedure TfrmCadEstruturas.pCriarQryConIte;
begin
  If Not Assigned(qryConIte) Then
    qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

procedure TfrmCadEstruturas.btnMoveCimaClick(Sender: TObject);
  Var
    strSeqAtu: String;
    strSeqAnt: String;
begin
 inherited;
  With cdsConsulta Do
  Begin
    If (RecNo > 1) Then
    Begin
      strSeqAtu := FieldByName('DMT_SEQUEN').AsString;
      Prior;
      strSeqAnt := FieldByName('DMT_SEQUEN').AsString;

      If Locate('DMT_SEQUEN', strSeqAtu, []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := '-1';
        Post;
      End;

      If Locate('DMT_SEQUEN', strSeqAnt, []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := strSeqAtu;
        Post;
      End;

      If Locate('DMT_SEQUEN', '-1', []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := strSeqAnt;
        Post;
      End;
    End;
  End;
end;

procedure TfrmCadEstruturas.btnMoveBaixoClick(Sender: TObject);
  Var
    strSeqAtu: String;
    strSeqAnt: String;
begin
  inherited;
  With cdsConsulta Do
  Begin
    If (RecNo < RecordCount) Then
    Begin
      strSeqAtu := FieldByName('DMT_SEQUEN').AsString;
      Next;
      strSeqAnt := FieldByName('DMT_SEQUEN').AsString;

      If Locate('DMT_SEQUEN', strSeqAtu, []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := '-1';
        Post;
      End;

      If Locate('DMT_SEQUEN', strSeqAnt, []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := strSeqAtu;
        Post;
      End;

      If Locate('DMT_SEQUEN', '-1', []) Then
      Begin
        Edit;
        FieldByName('DMT_SEQUEN').AsString := strSeqAnt;
        Post;
      End;
    End;
  End;
end;

procedure TfrmCadEstruturas.pAttTipoQtd(strTipQtd : String);
begin
  if cbxTipQtd.Visible Then
  begin
    cbxTipQtd.ItemIndex := AnsiIndexStr(strTipQtd, ['Q', 'P']);
    cbxTipQtdChange(cbxTipQtd);
  end;
end;

function TfrmCadEstruturas.fBuscaEstrutura(blnImportacao: Boolean): String;
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  Try
    qryTabela := fCriaQuery(nil);
    chrKey := '/';

    If fPesqEstrutura(Self, nil, qryTabela, chrKey, arrSel) Then
    Begin
      If blnImportacao Then
      Begin
        Result := qryTabela.FieldByName('GMT_CODITE').AsString;
      End
      Else
      Begin
        edtProdutos.Text := qryTabela.FieldByName('GMT_CODITE').AsString;
        pAttTipoQtd(qryTabela.FieldByName('GMT_TIPQTD').AsString);

        pCarregaProduto(qryConIte);

        //altera o layout
        objLayEst.Clear;
        objLayEst.strCodIte := edtProdutos.Text;
        objLayEst.pCarregaLayGmt;
        if btnLayouts.Visible then
          btnLayouts.Enabled := True;

        pCarregaEstrutura;

        if fValidaPanel(pnlProdutos) then
        begin
          if not (cbxTipQtd.Visible or btnLayouts.Visible) then
          begin
            pHabilitaCampos;
            pSetFocus(edtSubProduto);
          end
          else
          begin
            If cbxTipQtd.visible then
              pSetFocus(cbxTipQtd)
            else if btnLayouts.Visible then
              btnLayouts.Click;
          end;
        end;
      End;

    End;
  Finally
    FreeAndNil(qryTabela);
  End;
End;

function TfrmCadEstruturas.fBuscaPedPendentes: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP)');
    qryAux.SQL.Add('                    ORDER BY FDO_CODEMP, FDO_ESPDOC, FDO_NUMDOC');
    qryAux.SQL.Add('                    SEPARATOR ", ") AS PEDIDOS');
    qryAux.SQL.Add('FROM FATDOR');
    qryAux.SQL.Add('WHERE FDO_CODITE = :CODITE');
    qryAux.SQL.Add('  AND FDO_ESPDOC IN ("OR", "PD")');
    qryAux.SQL.Add('  AND FDO_JAFATU = 0');

    qryAux.ParamByName('CODITE').AsString := edtProdutos.Text;
    qryAux.Open;

    Result := qryAux.FieldByName('PEDIDOS').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadEstruturas.FormShow(Sender: TObject);
begin
  inherited;

  pCriarQryConIte;

  If not fVerificaAcessoSistema('ESTPRE') Then
  Begin
    shpESTPRE.Brush.Color := clRed;
    rdgPrecos.Buttons[1].Enabled := False;
    rdgPrecos.Buttons[2].Enabled := False;
    rdgPrecos.Buttons[3].Enabled := False;
    rdgPrecos.Buttons[4].Enabled := False;
  End;

  pSetaCodIte( edtProdutos );
  pSetaCodIte( edtSubProduto );
  pSetaCodIte( edtProAcabado );

  rdgPrecosClick(Sender);
end;

procedure TfrmCadEstruturas.btnApagaClick(Sender: TObject);
  Var
    strSql: String;
    qryGenMat: TUniQuery;
begin
  inherited;
  Try
    qryGenMat := fCriaQuery(Self);

    If (fEmptyStr(edtProdutos.Text) Or fEmptyStr(strSeqGer)) Then
    Begin
     fMensagem('AVISO', 'É necessário selecionar uma estrutura antes.', ['&O K']);
     Exit;
    End;

    If fMovimentaSubItemNaVenda Then
      pMostraPedPendentes('exclusão');

    If fVerificaSeExisteOrdemProducao Then
      Exit;

    If (fMensagem('', 'Apagar Estrutura?', ['&Sim', '&Não'], 2) = 2) Then
     Exit;

    With qryGenMat Do
    Begin
      strSql := '';
      strSql := strSql + ' SELECT * FROM '+fRetTabDet+' ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, fRetTabDet, qryGenMat);
        Next;
      End;

      strSql := '';
      strSql := strSql + ' DELETE FROM '+fRetTabDet+' ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strSeqGer;
      ExecSql;

      strSql := '';
      strSql := strSql + ' SELECT * FROM '+fRetTabGer+' ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, fRetTabGer, qryGenMat);
        Next;
      End;

      strSql := '';
      strSql := strSql + ' DELETE FROM '+fRetTabGer+' ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strSeqGer;
      ExecSql;
      Close;
    End;

    pLimparDados;
  Finally
    FreeAndNil(qryGenMat);
  End;
end;

procedure TfrmCadEstruturas.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(60, 4994, [4994,4995,4996,4997,4998,4999],
                        ['CODITE','TIPPRE','TABPRE'],
                        [edtProdutos.Text,
                        rdgPrecos.Items.Strings[rdgPrecos.ItemIndex],
                        IntToStr(cmbPreVen.ItemIndex+1)],
                        Sender,
                        nil,
                        False);
end;

procedure TfrmCadEstruturas.btnLayoutsClick(Sender: TObject);
begin
  inherited;
  if objLayEst.fEditarLayouts then
    pHabilitaCampos;
end;

procedure TfrmCadEstruturas.pCarregaItemAlteracao;
begin
  if cdsConsulta.IsEmpty then
    exit;

  intSequenAlt := cdsConsulta.FieldByName('DMT_SEQUEN').AsInteger;
  if fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString) then
    pTrataComentario(toEditar)
  else
  begin
    edtSubProduto.Text := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
    pCarregaSubProduto(qryConIte);

    edtSubDestino.Text := cdsConsulta.FieldByName('DMT_DESPCA').AsString;
    edtAcumOp.Text := cdsConsulta.FieldByName('DMT_ACUMOP').AsString;
    edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat);
    edtFatorPrecoVenda.Text := FormatFloat(edtFatorPrecoVenda.EditFormat, cdsConsulta.FieldByName('DMT_PRESUB').AsFloat);

    If blnUtilizaVendaMadeira And
       pnlQtdMadeira.Enabled  Then
    Begin
      edtQtdPec.Text := FormatFloat(edtQtdPec.EditFormat, cdsConsulta.FieldByName('DMT_QTDPEC').AsFloat);
      edtComPec.Text := FormatFloat(edtComPec.EditFormat, cdsConsulta.FieldByName('DMT_COMPEC').AsFloat);
      edtLarPec.Text := FormatFloat(edtLarPec.EditFormat, cdsConsulta.FieldByName('DMT_LARPEC').AsFloat);
      edtEspPec.Text := FormatFloat(edtEspPec.EditFormat, cdsConsulta.FieldByName('DMT_ESPPEC').AsFloat);
      edtAparel.Text := IfThen(fEmptyStr(cdsConsulta.FieldByName('DMT_APAREL').AsString), 'N', cdsConsulta.FieldByName('DMT_APAREL').AsString);
      edtBenefi.Text := IfThen(fEmptyStr(cdsConsulta.FieldByName('DMT_BENEFI').AsString), 'N', cdsConsulta.FieldByName('DMT_BENEFI').AsString);
      edtPerApa.Text := FormatFloat(edtPerApa.EditFormat, cdsConsulta.FieldByName('DMT_PERAPA').AsFloat);
      edtPerBen.Text := FormatFloat(edtPerBen.EditFormat, cdsConsulta.FieldByName('DMT_PERBEN').AsFloat);

      edtPerApa.Enabled := SameText(edtAparel.Text, 'S');
      edtPerBen.Enabled := SameText(edtBenefi.Text, 'S');
    End;

    If FModoEstruturaPersonalizada Then
      pSetFocus(edtSubProduto)
    Else
      pSetFocus(edtSubDestino);

  end;
end;

procedure TfrmCadEstruturas.pLimpaEteMat;
Begin
  edtCodEte.Clear;
  edtDesEte.Clear;
  edtMaxEte.Clear;
  edtMinEte.Clear;
End;

procedure TfrmCadEstruturas.btnAdicionaIteEmbClick(Sender: TObject);
begin
  inherited;
  If not fValidaPanel(pnlTopEteMat, True) Then
    Exit;

  If (cdsEteMat.Locate('ETM_CODETE', edtCodEte.Text, [])) Or
     (btnAdicionaIteEmb.Tag = Ord(dsEdit)) Then
  Begin
    cdsEteMat.Edit;
  End
  Else
  Begin
    cdsEteMat.Append;
    cdsEteMat.FieldByName('AUTOINCREM').AsString := '';
  End;

  cdsEteMat.FieldByName('ETM_CODETE').AsString := edtCodEte.Text;
  cdsEteMat.FieldByName('ETE_DESCRI').AsString := fRetDesEspecifiTecnica(edtCodEte.Text);
  cdsEteMat.FieldByName('ETM_VALMIN').AsFloat  := fStrToFloat(edtMinEte.Text);
  cdsEteMat.FieldByName('ETM_VALMAX').AsFloat  := fStrToFloat(edtMaxEte.Text);

  cdsEteMat.Post;
  btnCancelaIteEmbClick(Nil);
end;

procedure TfrmCadEstruturas.btnCancelaIteEmbClick(Sender: TObject);
begin
  inherited;
  pLimpaEteMat;
  btnAdicionaIteEmb.Tag := 0;
  cxgEteMat.Enabled     := True;
  pSetFocus(edtCodEte);
end;

procedure TfrmCadEstruturas.tbsEteMatShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodEte);
end;

procedure TfrmCadEstruturas.pgcPaginaChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  inherited;
  AllowChange := cdsConsulta.Active And ((cdsConsulta.RecordCount > 0) Or
                                         (cdsConsulta.State in DsEditModes));

  If AllowChange Then
  Begin
    edtProAcabado.Text    := edtProdutos.Text;
    edtDesAcabado.Text    := edtDesProduto.Text;
    edtRefAcabado.Text    := edtReferencia.Text;
    edtUndAcabado.Text    := edtUnidade.Text;
    edtCodFabAcabado.Text := edtCodFabrica.Text;
  End;
end;

procedure TfrmCadEstruturas.pCarregaEteMatEdicao;
Begin
  edtCodEte.Text := cdsEteMat.FieldByName('ETM_CODETE').AsString;
  edtDesEte.Text := cdsEteMat.FieldByName('ETE_DESCRI').AsString;
  edtMinEte.Text := FormatFloat(fMskDigitos(4), cdsEteMat.FieldByName('ETM_VALMIN').AsFloat);
  edtMaxEte.Text := FormatFloat(fMskDigitos(4), cdsEteMat.FieldByName('ETM_VALMAX').AsFloat);

  btnAdicionaIteEmb.Tag := Ord(dsEdit);
  cxgEteMat.Enabled := False;
  pSetFocus(edtCodEte);


End;

function TfrmCadEstruturas.fGetSQLFases: String;
begin
  Result := '';
  Result := Result + 'SELECT                                                                ';
  Result := Result + ' FASGER.AUTOINCREM,                                                   ';
  Result := Result + ' FAS_CODIGO,                                                          ';
  Result := Result + ' FAS_SEQUEN,                                                          ';
  Result := Result + ' FAS_DESFAS,                                                          ';
  Result := Result + ' CAST(IF(FASMAT.AUTOINCREM IS NULL,"N","S") AS CHAR(1)) AS FAS_UTILIZ ';
  Result := Result + 'FROM FASGER                                                           ';
  Result := Result + '  LEFT JOIN FASMAT ON MAT_SEQFAS = FASGER.AUTOINCREM                  ';
  Result := Result + '                  AND MAT_SEQMAT = :AUTINC                            ';
  Result := Result + ' WHERE TRUE                                                           ';
  Result := Result + '   AND FAS_CODEMP = :CODEMP                                           ';
  Result := Result + ' GROUP BY FASGER.AUTOINCREM                                           ';
  Result := Result + ' ORDER BY FAS_SEQUEN                                                  ';
end;

procedure TfrmCadEstruturas.pCarregaFases(AStrCodIte: String);
var
  strOpis: String;
begin
  cdsCadFas := TZClient.Create(Self, fGetSQLFases);
  cdsCadFas.qryQuery.ParamByName('AUTINC').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;
  cdsCadFas.qryQuery.ParamByName('CODEMP').AsString := VS_StrCodEmp;
  cdsCadFas.fAbreClient(True, 'TfrmCadEstruturas.pCarregaFases');
  cdsCadFas.IndexFieldNames := 'FAS_SEQUEN';

  cxgCadFasView.DataController.DataSource := cdsCadFas.dtsSource;

  cxgCadFasUTILIZ.Options.Editing := Not TOrdProMonitoramento.fTemOperacaoIniciadaDeOPAberta(strOpis, AStrCodIte);
  If Not cxgCadFasUTILIZ.Options.Editing Then
    fMensagem('ATENÇÃO', 'Produto associado a uma ordem de produção não baixada: ' + strOpis + #13#10 + 'Não será possível marcar ou desmarcar a utilização de fases!', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 230, 760);
end;

function TfrmCadEstruturas.fSalvarFases(AStrAutIncGerMat: String): Boolean;
var
  qryIns: TUniQuery;
begin
  qryIns := fCriaQuery;

  Try
    Try
      qryIns.SQL.Clear;
      qryIns.SQL.Add('DELETE FROM FASMAT WHERE AUTOINCREM = :AUTINC');
      qryIns.ParamByName('AUTINC').AsString := AStrAutIncGerMat;
      qryIns.ExecSQL;

      qryIns.SQL.Clear;
      qryIns.SQL.Add('INSERT INTO FASMAT (AUTOINCREM, MAT_SEQMAT, MAT_SEQFAS, MAT_CODEMP) VALUES (:AUTINC, :SEQMAT, :SEQFAS, :CODEMP)');

      cdsCadFas.DisableControls;
      cdsCadFas.Filter := 'FAS_UTILIZ = ''S''';
      cdsCadFas.Filtered := True;
      cdsCadFas.First;
      While Not cdsCadFas.Eof Do
      Begin
        qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('FASMAT', VS_StrCodEmp);
        qryIns.ParamByName('SEQMAT').AsString := AStrAutIncGerMat;
        qryIns.ParamByName('SEQFAS').AsString := cdsCadFas.FieldByName('AUTOINCREM').AsString;
        qryIns.ParamByName('CODEMP').AsString := VS_StrCodEmp;
        qryIns.ExecSQL;

        cdsCadFas.Next;
      End;
      Result := True;
    Except On
      E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TFrmCadEstruturas.fSalvarFases');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
    cdsCadFas.Filtered := False;
    cdsCadFas.EnableControls;
  End;
end;

function TfrmCadEstruturas.fValidaInclusaoSubProduto(AStrCodItePai, AStrCodIteFilho: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD ');
    qryAux.SQL.Add('   FROM GERMAT ');
    qryAux.SQL.Add('  INNER JOIN DETMAT ON GERMAT.AUTOINCREM = DETMAT.DMT_SEQGER ');
    qryAux.SQL.Add('   WHERE TRUE ');
    qryAux.SQL.Add('     AND DMT_ITESUB = :CODITESUB ');
    qryAux.SQL.Add('     AND GMT_CODITE = :CODITEPAI ');

    qryAux.ParamByName('CODITESUB').AsString := AStrCodIteFilho;
    qryAux.ParamByName('CODITEPAI').AsString := AStrCodItePai;

    qryAux.Open;

    Result := qryAux.FieldByName('QTD').AsFloat > 0;

  Finally
    FreeAndNil(qryAux);
  End;
end;

End.
