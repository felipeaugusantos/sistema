unit untPnlDadosItemResumido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxCurrencyEdit, Vcl.Menus, cxClasses, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGridDBTableView, cxGridCitel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCustomView, cxGrid, cxVGrid,
  cxInplaceContainer, Vcl.ComCtrls, Vcl.DBCtrls, DBMemoFocus,
  UniClientDataSet, untConstantes, Math,
  untLegendasItem, untTypesSistema, untFuncoesSimples, untClassPanelCx,
  untSaldoLojas, untZClient, untGerenciaPropriedadesComponentes, cxTextEdit,
  Vcl.AppEvnts, System.ImageList, Vcl.ImgList, cxImageComboBox, untPnlDadosItem,
  EditFocus, untTCadProdutosVeiculoModelo, System.StrUtils, MemoFocus, Uni,
  untVisualizarAplicacaoProduto, untCadArmazem, untCadLoteItens, untFatMostraProdSimilar,
  untFatSelPedidoCompraRequisicao, Winapi.RichEdit, untFraConsultaEstrutura;

type
  TfrmPnlDadosItemResumido = class(TfrmPnlDadosItem)
    pnlDadosItem: TPanel;
    pnlAplicacao: TPanel;
    pnlAplic: TPanel;
    Panel1: TPanel;
    pnlMsgLivre: TPanel;
    Panel2: TPanel;
    dbeMSGLIV: TDBMemoFocus;
    pnlRodape: TPanel;
    dtsConsulta: TDataSource;
    cxsGrid: TcxStyleRepository;
    cxsSaldos: TcxStyle;
    cxsSaldosDisponivel: TcxStyle;
    cxsSaldosML: TcxStyle;
    cxsSaldosCD: TcxStyle;
    cxsSaldosCDML: TcxStyle;
    cxsSaldosMLDisponivel: TcxStyle;
    cxsSaldosCDDisponivel: TcxStyle;
    cxsSaldosCDMLDisponivel: TcxStyle;
    cxsValorDisponivel: TcxStyle;
    popMenu: TPopupMenu;
    btnCompCusto: TMenuItem;
    btnComSisAnt: TMenuItem;
    btnExiEstrutura: TMenuItem;
    btnItensComp: TMenuItem;
    btnItensVend: TMenuItem;
    btnFichaKardex: TMenuItem;
    btnOrcamentos: TMenuItem;
    btnMostraPrecoVenda: TMenuItem;
    btnSepIte: TMenuItem;
    btnConsVendasPerdidas: TMenuItem;
    btnVendasPerdidas: TMenuItem;
    btnVedasSisAnt: TMenuItem;
    popSaldos: TPopupMenu;
    mnuConfigRel: TMenuItem;
    dtsSalLoj: TDataSource;
    dtsSimilares: TDataSource;
    btnAlterarModoTAB: TMenuItem;
    AppEvents: TApplicationEvents;
    imglImageList: TImageList;
    pnlTotaisRodape: TPanel;
    lblTotaisRodape: TLabel;
    ransfEstoqueemAndamento1: TMenuItem;
    btnLotIte: TMenuItem;
    DBAplica: TDBRichEdit;
    btnCndPag: TBitBtnLocked;
    pnlCndPag: TPanel;
    edtDesMax: TEditFocus;
    lblDesMax: TLabel;
    lblCndPag: TLabel;
    lblExpandirAplicacao: TLabel;
    mnuCadArmazem: TMenuItem;
    mnuCadSimilaridade: TMenuItem;
    mnuAgregados: TMenuItem;
    mnuSimilar: TMenuItem;
    ChecklistDevoluoGarantia1: TMenuItem;
    GarantiadeMercadoria1: TMenuItem;
    rocadeMercadoria1: TMenuItem;
    mnuEstVendaForaEstab: TMenuItem;
    mnuSolicitarRequisicaodeCompras: TMenuItem;
    popImgPro: TPopupMenu;
    mnuEnviarporWhatsapp: TMenuItem;
    mnuSemelhantes: TMenuItem;
    mnuNotasFiscaisAssociadasEmAberto: TMenuItem;
    pnlPaineis: TPanel;
    btnEstDet: TBitBtnLocked;
    pnlPgcSaldos: TPanel;
    pgcSaldos: TPageControl;
    tbsSaldos: TTabSheet;
    cxvSaldos: TcxVerticalGrid;
    cxvEstFisico: TcxEditorRow;
    cxvGarantia: TcxEditorRow;
    cxvPedidoVenda: TcxEditorRow;
    cxvEnderecamento: TcxEditorRow;
    cxvExterno: TcxEditorRow;
    cxvOrdemProducao: TcxEditorRow;
    cxvEntFutPrevisao: TcxEditorRow;
    cxvEntFutFalta: TcxEditorRow;
    cxvEntFutAguarda: TcxEditorRow;
    cxvDisponivel: TcxEditorRow;
    cxvPedidoCompra: TcxEditorRow;
    cxvPedidoCompraPendenteLojas: TcxEditorRow;
    cxvReqPendente: TcxEditorRow;
    cxvReqPendenteLojas: TcxEditorRow;
    cxvPedidoBaixaEntregaFutura: TcxEditorRow;
    cxvTransfEstAndamentoAgFat: TcxEditorRow;
    cxvTransfEstAndamentoAgEnt: TcxEditorRow;
    cxvSaldoCompartilhado: TcxEditorRow;
    cxvTotalEmOrdProd: TcxEditorRow;
    tbsSaldosML: TTabSheet;
    cxvSaldosML: TcxVerticalGrid;
    cxvEstFisicoML: TcxEditorRow;
    cxvGarantiaML: TcxEditorRow;
    cxvPedidoVendaML: TcxEditorRow;
    cxvEnderecamentoML: TcxEditorRow;
    cxvExternoML: TcxEditorRow;
    cxvEntFutPrevisaoML: TcxEditorRow;
    cxvEntFutFaltaML: TcxEditorRow;
    cxvEntFutAguardaML: TcxEditorRow;
    cxvDisponivelML: TcxEditorRow;
    cxvPedidoCompraML: TcxEditorRow;
    cxvTransfEstAndamentoML: TcxEditorRow;
    cxvOrdemProducaoML: TcxEditorRow;
    cxvPedidoBaixaEntregaFuturaML: TcxEditorRow;
    pnlSaldoLojas: TPanel;
    pnlEsqLojas: TPanel;
    pnlDirLojas: TPanel;
    cxgLojas: TcxGrid;
    cxvLojas: TcxGridDBBandedTableView;
    cxvLojasColumn1: TcxGridDBBandedColumn;
    cxvLojasSALFIS: TcxGridDBBandedColumn;
    cxvLojasSALDIS: TcxGridDBBandedColumn;
    cxvLojasLISREG: TcxGridDBBandedColumn;
    cxgLojasLevel1: TcxGridLevel;
    pnlGrupoDireita: TPanel;
    pnlProBrin: TPanel;
    MemProBrin: TMemoFocus;
    pnlTotais: TPanel;
    pnlGrupoSimilares: TPanel;
    pnlGrupoVeiculos: TPanel;
    pnlVeiculos_Embalagens: TPanel;
    pnlEmbFec: TPanel;
    lblIteEmb: TLabel;
    cxgIteEmb: TcxGridCitel;
    cxgIteEmbTableView: TcxGridDBTableViewCitel;
    cxgIteEmbTableViewQTDEMB: TcxGridDBColumn;
    cxgIteEmbTableViewDESCON: TcxGridDBColumn;
    cxgIteEmbTableViewTABPRE: TcxGridDBColumn;
    cxgIteEmbTableViewUNITAR: TcxGridDBColumn;
    cxgIteEmbLevel: TcxGridLevel;
    pnlIteVeiculo: TPanel;
    Label1: TLabel;
    cxVeiculos: TcxGridCitel;
    cxVeiculosDB: TcxGridDBTableViewCitel;
    cxVeiculosMARCA: TcxGridDBColumn;
    cxVeiculoMODELO: TcxGridDBColumn;
    cxVeiculosANOINI: TcxGridDBColumn;
    cxVeiculosANOFIM: TcxGridDBColumn;
    cxVeiculosVALVUL: TcxGridDBColumn;
    cxVeiculosCILIND: TcxGridDBColumn;
    cxVeiculosPOTENC: TcxGridDBColumn;
    cxVeiculosCOMBUST: TcxGridDBColumn;
    cxVeiculosOBSERV: TcxGridDBColumn;
    cxVeiculosLevel: TcxGridLevel;
    pnlTopMeio: TPanel;
    pnlSimilares: TPanel;
    cxgSimilares: TcxGrid;
    cxvSilimares: TcxGridDBBandedTableView;
    cxvSimilaresCODITE: TcxGridDBBandedColumn;
    cxvSimilaresDESITE: TcxGridDBBandedColumn;
    cxvSilimaresSIGUNI: TcxGridDBBandedColumn;
    cxvSilimaresPREVEN: TcxGridDBBandedColumn;
    cxvSimilaresSALDIS: TcxGridDBBandedColumn;
    cxvSilimaresREFERE: TcxGridDBBandedColumn;
    cxvSilimaresTAB: TcxGridDBBandedColumn;
    cxvSilimaresDESMAR: TcxGridDBBandedColumn;
    cxvSilimaresFABRIC: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    Panel3: TPanel;
    btnPopup: TBitBtnLocked;
    lblLegendas: TLabel;
    pnlFoto: TPanel;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblErrImg: TLabel;
    pnlTotaisLateral: TPanel;
    pnlTotaisLateralFlow: TFlowPanel;
    pnlTotGer: TPanel;
    lblTotGer: TLabel;
    edtTotGer: TEditFocus;
    pnlSohIPI: TPanel;
    lblSohIPI: TLabel;
    edtSohIPI: TEditFocus;
    pnlTotIpi: TPanel;
    lblTotIpi: TLabel;
    edtTotIpi: TEditFocus;
    pnlSohST: TPanel;
    lblSohST: TLabel;
    edtSohST: TEditFocus;
    pnlSohFCP: TPanel;
    lblSohFCP: TLabel;
    edtSohFCP: TEditFocus;
    pnlSohCBS: TPanel;
    lblSohCBS: TLabel;
    edtSohCBS: TEditFocus;
    pnlSohIBS: TPanel;
    lblSohIBS: TLabel;
    edtSohIBS: TEditFocus;
    pnlSohIS: TPanel;
    lblSohIS: TLabel;
    edtSohIS: TEditFocus;
    pnlTotSer: TPanel;
    lblTotSer: TLabel;
    edtTotSer: TEditFocus;
    pnlTotImp: TPanel;
    lblTotImp: TLabel;
    edtTotImp: TEditFocus;
    mnuConsultaBalcao: TMenuItem;
    dtsSubConsulta: TDataSource;
    pnlEstrutura: TPanel;
    spltGrupoSimilares: TSplitter;
    mnuPedCompGrid: TMenuItem;
    procedure cxgSimilaresEnter(Sender: TObject);
    procedure cxgSimilaresExit(Sender: TObject);
    procedure tmrAtualizarDadosTimer(Sender: TObject);
    procedure cxgIteEmbEnter(Sender: TObject);
    procedure cxgIteEmbExit(Sender: TObject);
    procedure pgcSaldosEnter(Sender: TObject);
    procedure pgcSaldosExit(Sender: TObject);
    procedure cxvGarantiaEditPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure popSaldosPopup(Sender: TObject);
    procedure cxgLojasEnter(Sender: TObject);
    procedure cxgLojasExit(Sender: TObject);
    procedure btnEstDetClick(Sender: TObject);
    procedure cxvSaldosEnter(Sender: TObject);
    procedure cxvSaldosExit(Sender: TObject);
    procedure cxvSaldosMLEnter(Sender: TObject);
    procedure cxvSaldosMLExit(Sender: TObject);
    procedure imgProDblClick(Sender: TObject);
    procedure btnCompCustoClick(Sender: TObject);
    procedure btnComSisAntClick(Sender: TObject);
    procedure btnExiEstruturaClick(Sender: TObject);
    procedure btnItensCompClick(Sender: TObject);
    procedure btnItensVendClick(Sender: TObject);
    procedure btnFichaKardexClick(Sender: TObject);
    procedure btnOrcamentosClick(Sender: TObject);
    procedure btnMostraPrecoVendaClick(Sender: TObject);
    procedure btnSepIteClick(Sender: TObject);
    procedure btnConsVendasPerdidasClick(Sender: TObject);
    procedure btnVendasPerdidasClick(Sender: TObject);
    procedure cxvSaldosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnPopupClick(Sender: TObject);
    procedure lblLegendasClick(Sender: TObject);
    procedure btnVedasSisAntClick(Sender: TObject);
    procedure btnAlterarModoTABClick(Sender: TObject);
    procedure AppEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure cxvSilimaresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvSilimaresCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxvLojasCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuConfigRelClick(Sender: TObject);
    procedure ransfEstoqueemAndamento1Click(Sender: TObject);
    procedure btnLotIteClick(Sender: TObject);
    procedure btnCndPagClick(Sender: TObject);
    procedure edtDesMaxExit(Sender: TObject);
    procedure edtDesMaxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblExpandirAplicacaoClick(Sender: TObject);
    procedure mnuCadSimilaridadeClick(Sender: TObject);
    procedure mnuCadArmazemClick(Sender: TObject);
    procedure mnuAgregadosClick(Sender: TObject);
    procedure mnuSimilarClick(Sender: TObject);
    procedure GarantiadeMercadoria1Click(Sender: TObject);
    procedure rocadeMercadoria1Click(Sender: TObject);
    procedure mnuEstVendaForaEstabClick(Sender: TObject);
    procedure mnuSolicitarRequisicaodeComprasClick(Sender: TObject);
    procedure mnuEnviarporWhatsappClick(Sender: TObject);
    procedure mnuSemelhantesClick(Sender: TObject);
    procedure mnuNotasFiscaisAssociadasEmAbertoClick(Sender: TObject);
    procedure mnuConsultaBalcaoClick(Sender: TObject);
    procedure mnuPedCompGridClick(Sender: TObject);
    procedure cxvSilimaresCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    blnModeloVeiculo,
    blnOrcPen : Boolean;
    bnlLigaScroll: Boolean;
    blnOrdPro,
    blnUsaPDV,
    blnEntFut,
    blnImgPro,
    blnEstExt,
    blnHabF7 : Boolean;
    blnSalvar_lblAplicacao: Boolean;
    objCadProdutosVeiculoModelo : TCadProdutosVeiculoModelo;
    intDecUni: Integer;

    cdsLegendas: TLegendasItem;

    recSaldos,
    recSaldosML: TRecSaldos;

    blnAtualizandoInformacaoSubConsulta : Boolean;
    blnFocadoNaSubConsulta : Boolean;
    blnNavegandoGridSimilares: Boolean;
    blnExecutandoTABGridSimilares: Boolean;

    objGerenciaRodape : TGerenciaPropriedadesComponentes;

    strPDCPRO: String;

    blnDirAceConsulta,
    blnSimilaresLocal: Boolean;

    intTotaisLateralHeight,
    intDefaultWidthTotais,
    intLockTab: Integer;

    cdsIteEmb : TEmbalagens;

    intIdxCol,
    intCalSal: Integer;

    objSalLoj: TSaldoLojas;

    FDefaultFormWidth: Integer;
    FDefaultFormHeight: Integer;
    FDefaultcxgSimilaresWidth: Integer;
    FDefaultpnlVeiculos_EmbalagensWidth: Integer;
    FDefaultpnlTotaisLateralLeft: Integer;
    FDefaultpnlTotaisRodapeWidth: Integer;
    FDefaultpnlTotaisRodapeHeight: Integer;
    FDefaultpnlImgProLeft: Integer;
    FDefaultpnlCndPagWidth: Integer;
    FDefaultpnlCndPagHeight: Integer;
    blnUtilizaChecklistGarantia: Boolean;

    fraConsultaEstrutura: TfraConsultaEstrutura;

    function tmrAtualizarDados: TNewTimer;

    procedure pAtualizaPainelTotaisVenda;
    procedure pAjustaAlturaRodapeTotais;
    procedure pCalculaDesconto;

    procedure pSetPosicaoVertical;
    procedure pSetPosicaoHorizontal(const intDefaultPanelWidth : Integer);
    procedure pAjustaAlturaTotais(const blnSetaPosVertical: Boolean; const intDefaultPanelWidth : Integer);

    procedure pAjustaAlturaPainelPrincipal;
    procedure pInformaCndPag;
    procedure pSetaDescricaoModoTAB;

    procedure pChamaRelatorio(Sender: TObject);

    procedure pAtualizaDados;
    procedure pLimpaDados;
    procedure pEscreveAtualizando;
    procedure pMostraBotaoEstrutura;
    procedure pInicialializaTelaSaldos;
    procedure pAjustaAlturaSaldos;

    procedure pMostraAtualizandoSaldos(cxvSaldos: TcxVerticalGrid; strMensagem: String = 'Atualizando...');

    Procedure pCarregaSaldos;

    procedure pSetVisible(cxg: TcxEditorRow; bln: Boolean);
    procedure pSetIndex(cxg: TcxEditorRow); overload;
    procedure pSetIndex(cxg: TcxEditorRow; const intIdx : Integer); overload;
    procedure pOrdemInicial;

    procedure pHabilitaTeclas(blnTravar: Boolean);

    procedure pWMMessageRedimensionouFormConsulta;
    procedure pWMMessageAtualizouTotalVenda;
    procedure pWMMessagePressionouTabConsulta;
    procedure pWMMessageNavegandoGridConsulta;
    procedure pAtualizarCorInformacoesItens;
    procedure pSetarItemVendidoConsulta;

    procedure pExecutarAcaoTAB;

    function GetDataSetItem: TDataSet;
    function GetCampoItem(ACampo: String): TField;

    procedure pAbreIteEmb;
    procedure pDestacaCorDeFonteFiltroAplicacao;

    procedure pLimpaCamposSemSQL;

    Function fValidaCampos(arrCampo: Array Of String): Boolean;

    function MyPos(stringtofind, stringtosearch: string; CaseInsensitive:boolean = true): integer;
    procedure TrocarCorPalavra(oRichEdit : TDBRichEdit; sText : String; Color, bkpColor: TColor);
    procedure pSetUtilizaChecklistGarantia(Value: Boolean);
    procedure pExecutaFichaKardex;
    function fExisteSemelhantes(strCodIte: String): Boolean;
    function fCondicaoAbateDescontoAutomaticamente(const strCodCnd : String) : Boolean;
    procedure pAtualizaDataSourceSubConsulta;
  public
    { Public declarations }
    procedure pResetatmrAtualizarDados; override;
    procedure pSetPnlDadosItemVisible(AVisible: Boolean); override;
    procedure pAtualizarAplicacao; override;
    procedure pIniciouNavegacaoGridConsulta; override;
    procedure pParouNavegacaoGridConsulta; override;
    procedure pOnDisplayText(Sender: TcxCustomGridTableItem;
                             ARecord: TcxCustomGridRecord;
                             var AText: string); override;
    procedure pAtualizaInformacaoSubConsulta; override;
  end;

implementation

{$R *.dfm}

Uses
  TypesRel,
  untFuncoesRel2,
  untControleSepAvulsa,
  untMostraLegendasItem,
  untConsultaOrcPesqItem,
  untRelFatVendasCliente,
  untMostraEstruturas,
  untIteBar,
  untFatConsVendasAntigas,
  untCadProdutosCompCusto,
  untImagens,
  untFuncoesRel,
  untCadProFoto,
  untFuncoesGen,
  untController.CheckListGarantia,
  untBloquearTela, untRelacSimilaridade, untFuncoes,
  untCfgHabilitaConsultaCotacaoAPIBalcao, untConsultaEstoqueApis;

procedure TfrmPnlDadosItemResumido.tmrAtualizarDadosTimer(Sender: TObject);
begin
  tmrAtualizarDados.Enabled := False;
  pAtualizaDados;
end;

procedure TfrmPnlDadosItemResumido.pChamaRelatorio(Sender: TObject);
  Var
    strCodIte,
    strCodEmp: String;
    intCodAta: Integer;
begin
  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  If GetDataSetItem.IsEmpty And (Not (Sender Is TMenuItem)) Then
    Exit;

  strCodEmp := strEmpSal;

  If GetDataSetItem.IsEmpty Then
  Begin
    strCodIte := ''
  End Else
  Begin
  If Not fValidaCampos(['ITE_CODITE']) Then
      Exit;

    strCodIte := GetCampoItem('ITE_CODITE').AsString;
  End;

  If pgcSaldos.ActivePage = tbsSaldos Then
  Begin

    If Not Assigned(cxvSaldos.FocusedRow) Then
      cxvEstFisico.Focused := True;

    intCodAta := cxvSaldos.FocusedRow.Tag;
  End Else
  Begin

    If Not Assigned(cxvSaldosML.FocusedRow) Then
      cxvEstFisicoML.Focused := True;

    intCodAta := cxvSaldosML.FocusedRow.Tag;
  End;

  If intCodAta = 0 Then
    Exit;

  If intCodAta = 411 then
  begin
    strCodEmp := '';
  end;

  prcExecutaRelatorio(intCodAta, 0,
                     [],
                     ['CODITE', 'CODEMP'],
                     [strCodIte, strCodEmp],
                      Sender,
                     ['CODITE', 'CODEMP'],
                     True);
end;

function TfrmPnlDadosItemResumido.MyPos(stringtofind, stringtosearch: string; CaseInsensitive:
   boolean = true): integer;
begin
  if CaseInsensitive then
  begin
    stringtofind := LowerCase(stringtofind);
    stringtosearch := LowerCase(stringtosearch);
  end;
  Result := Pos(stringtofind, stringtosearch);
end;

procedure TfrmPnlDadosItemResumido.TrocarCorPalavra(oRichEdit : TDBRichEdit; sText : String; Color, bkpColor: TColor);
var iPos : Integer;
    iLen : Integer;
    Format: CHARFORMAT2;
begin
  FillChar(Format, SizeOf(Format), 0);
  Format.cbSize := SizeOf(Format);
  Format.dwMask := CFM_BACKCOLOR;
  Format.crBackColor := bkpColor;

  iPos := 0;
  iLen := Length(oRichEdit.Lines.Text) ;
  iPos := oRichEdit.FindText(sText, iPos, iLen, []);

  while iPos > -1 do
  begin
    oRichEdit.SelStart  := iPos;
    oRichEdit.SelLength := Length(sText) ;
    oRichEdit.SelAttributes.Color := Color;
    oRichEdit.SelAttributes.Style := [fsBold];

    oRichEdit.Perform(EM_SETCHARFORMAT, SCF_SELECTION, Longint(@Format));
    iPos := oRichEdit.FindText(sText,iPos + Length(sText),iLen, []) ;
  end;
end;

procedure TfrmPnlDadosItemResumido.pDestacaCorDeFonteFiltroAplicacao;
var
 strPalavra: String;
begin
  inherited;
  strPalavra:= objPanel.strFiltroEspecifico;
  if mypos(strPalavra,DBAplica.Text,true) > 0 then
  Begin
    If Not (cdsConsulta.State In dsEditModes) Then
      cdsConsulta.Edit;
    TrocarCorPalavra(DBAplica, strPalavra, clBlue, clYellow);
    cdsConsulta.Post;
  End;

end;

procedure TfrmPnlDadosItemResumido.pAtualizaDados;
begin
  Self.blnFocadoNaSubConsulta := False;

  If Not bnlLigaScroll Then
    Exit;

  If Not Self.Showing Then
    Exit;

  If (Not GetDataSetItem.Active) or GetDataSetItem.IsEmpty then
  begin
    pLimpaDados;
    Exit;
  end;

  If GetDataSetItem.Active then
  Begin
    {************************************************************************}
    {* TRECHO QUE PERMITE EXIBIR A IMAGEM DO PRODUTO                        *}
    {******************************************************************* AM *}
    If fValidaCampos(['ITE_CODITE']) Then
      TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, GetCampoItem('ITE_CODITE').AsString);

    Application.ProcessMessages;
    Repaint;


    If pgcSaldos.Visible Then
    Begin

      If fValidaCampos(['ITE_CODITE', 'ITE_CODSIM', 'ITE_CNV_ML']) Then
      Begin

        mnuAgregados.Visible := (Assigned(procExibeAgregados)) And (cdsConsulta.FindField('AGR_CODAGR') <> Nil) And (Not fEmptyStr(cdsConsulta.FieldByName('AGR_CODAGR').AsString));

        btnOrcamentos.Visible := blnOrcPen And fValidaCampos(['ORCPEN']) And (GetCampoItem('ORCPEN').AsInteger > 0);

        btnConsVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0)                               And
                                         (Not fEmptyStr(strCodCli))                                      And
                                         (Not fEmptyStr(GetCampoItem('ITE_CODITE').AsString)) And
                                         (Assigned(procRelVendasPerdidas));

        mnuSemelhantes.Visible := fExisteSemelhantes(cdsConsulta.FieldByName('ITE_CODITE').AsString);

        pCarregaSaldos;

        objSalLoj.pCarregaSaldos(GetCampoItem('ITE_CODITE').AsString,
                                 GetCampoItem('ITE_CODSIM').AsString,
                                 strEmpSal,
                                 GetCampoItem('ITE_CNV_ML').Asfloat,
                                 ((blnSimilaresLocal) And ((Not blnNavegandoGridSimilares) And (Not blnExecutandoTABGridSimilares))),
                                 objPanel.sltLista, strTabPre, fltDescApli);

        cxvLojas.OptionsView.NoDataToDisplayInfoText := '';
        cxvSilimares.OptionsView.NoDataToDisplayInfoText := '<Nenhum similar encontrado>';

        If blnUsaPDV Then
          blnHabF7 := (recSaldos.fltSalPed > 0) Or
                      (recSaldos.fltSalOrd > 0) Or
                      (recSaldos.fltSalGar > 0) Or
                      (recSaldos.fltSalEnd > 0);
      End Else
      Begin
        pMostraAtualizandoSaldos(cxvSaldos, '');
        pMostraAtualizandoSaldos(cxvSaldosML, '');
      End;

    End;

    {************************************************************************}
    {* TRECHO QUE PERMITE EXIBIR A IMAGEM DO PRODUTO                        *}
    {******************************************************************* AM *}

    If fValidaCampos(['ITE_CODITE']) Then
      TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, GetCampoItem('ITE_CODITE').AsString);

    If objpanel.blnAlternarModoTab Then
      mnuSolicitarRequisicaodeCompras.Visible := fVerificaAcessoSistema('PSRDCNTC', strLoginUsuarioLogado) And fCfgSis('REQAUT', varBoolean);

    pAtualizaDataSourceSubConsulta;
    Self.blnFocadoNaSubConsulta := Self.blnAtualizandoInformacaoSubConsulta;
  End;

  pMostraBotaoEstrutura;
  pAbreIteEmb;
  If (fCfgSis('PROBRI', VarBoolean)) And (Pos(strOpcDoc, 'VN_PD_OR_') > 0) Then
  Begin
    If fValidaCampos([ 'ITE_CODITE']) Then
      pAbrePromocaoBrindes(cdsConsulta.FieldByName('ITE_CODITE').AsString,MemProBrin);
  End;

  If (GetCampoItem('ITE_CNV_ML') <> Nil) And (GetCampoItem('ITE_CNV_ML').AsFloat > 0) Then
  Begin
    tbsSaldosML.TabVisible   := True;
  End Else
  Begin
    tbsSaldosML.TabVisible   := False;
  End;

  pDestacaCorDeFonteFiltroAplicacao;

  if fCfgSis('CPEEST', varBoolean) then
    fraConsultaEstrutura.pCarregarEstrutura(GetCampoItem('ITE_CODITE').AsString, strEmpSal);

  tmrAtualizarDados.Enabled := False;
end;

procedure TfrmPnlDadosItemResumido.pAtualizarAplicacao;
begin
  If Not objPanel.blnExpand Then
  Begin
    If pnlAplicacao.Visible Then
    Begin
      objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height - pnlAplicacao.Height;
      pnlAplicacao.Visible := False;
    End;
  End
  Else
  Begin
    If Not pnlAplicacao.Visible Then
    Begin
      pnlAplicacao.Visible := True;
      objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height + pnlAplicacao.Height;
    End;
  End;

  pDestacaCorDeFonteFiltroAplicacao;

end;

procedure TfrmPnlDadosItemResumido.pAtualizarCorInformacoesItens;
begin
  If blnNavegandoGridSimilares Or blnExecutandoTABGridSimilares Then
  Begin
    cxsSaldos.Color := COR_INFORMACOES_SIMILARES_CONSULTA;
    cxsSaldosDisponivel.Color := COR_INFORMACOES_SIMILARES_CONSULTA;
  End
  Else
  Begin
    cxsSaldos.Color := COR_INFORMACOES_ITEM_CONSULTA;
    cxsSaldosDisponivel.Color := COR_INFORMACOES_ITEM_CONSULTA;
  End;
end;

procedure TfrmPnlDadosItemResumido.pMostraBotaoEstrutura;
Begin
  btnExiEstrutura.Visible := (GetDataSetItem.Active) And fValidaCampos(['ESTRUT']) And
                             (GetCampoItem('ESTRUT').AsInteger > 0);
End;

procedure TfrmPnlDadosItemResumido.pOnDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
  var
    AValue: Double;
begin
  If (fltDescApli <= 0) And (fltTxJuros <= 0) Then
    Exit;

  If ARecord.IsData And (ARecord.Index > -1) Then
  Begin
    If TCxGridDBBandedColumn(Sender).DataBinding.FieldName.Contains('ITE_PREVE') And
       (TCxGridDBBandedColumn(Sender).DataBinding.Field Is TFloatField) Then
    Begin
      AValue := IfNull(ARecord.Values[TcxGridDBBandedColumn(Sender).Index], 0);
      AValue := (AValue + (AValue * fltTxJuros / 100));
      AText := FloatToStrF((AValue - (AValue * fltDescApli / 100)), ffFixed, 12, intDecUni);
    End;
  End;
end;

procedure TfrmPnlDadosItemResumido.popSaldosPopup(Sender: TObject);
begin
  If pgcSaldos.ActivePage = tbsSaldos Then
  Begin

    If Not Assigned(cxvSaldos.FocusedRow) Then
      cxvEstFisico.Focused := True;

    If cxvSaldos.FocusedRow.Tag = 0 Then
      mnuConfigRel.Caption := 'Não há relatório para "' + Trim(TcxEditorRow(cxvSaldos.FocusedRow).Properties.Caption) + '"!'
    Else
      mnuConfigRel.Caption := 'Configurar o relatório para "'+ Trim(TcxEditorRow(cxvSaldos.FocusedRow).Properties.Caption) + '".';

  End Else
  Begin

    If Not Assigned(cxvSaldosML.FocusedRow) Then
      cxvEstFisicoML.Focused := True;

    If cxvSaldosML.FocusedRow.Tag = 0 Then
      mnuConfigRel.Caption := 'Não há relatório para "' + Trim(TcxEditorRow(cxvSaldosML.FocusedRow).Properties.Caption) + '"!'
    Else
      mnuConfigRel.Caption := 'Configurar o relatório para "'+ Trim(TcxEditorRow(cxvSaldosML.FocusedRow).Properties.Caption) + '".';
  End;
end;

procedure TfrmPnlDadosItemResumido.pParouNavegacaoGridConsulta;
begin
  inherited;
  If (Not Self.Showing) Then
    Exit;

  Try
    tmrAtualizarDados.Enabled := False;
    tmrAtualizarDados.Enabled := True;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message + ': ' + SysErrorMessage(GetLastError));
  End;
end;

procedure TfrmPnlDadosItemResumido.pLimpaDados;
begin
  pMostraAtualizandoSaldos(cxvSaldos, '');
  pMostraAtualizandoSaldos(cxvSaldosML, '');

  cxvLojas.OptionsView.NoDataToDisplayInfoText := '';
  cxvSilimares.OptionsView.NoDataToDisplayInfoText := '<Nenhum similar encontrado>';

  objSalLoj.qrySaldos.Close;
  objSalLoj.qrySimilares.Close;

  imgPro.Picture := nil;

  pnlEmbFec.Visible := False;
  pnlIteVeiculo.Visible := False;
end;

procedure TfrmPnlDadosItemResumido.pResetatmrAtualizarDados;
begin
  pEscreveAtualizando;
  tmrAtualizarDados.Enabled := False;
  tmrAtualizarDados.Enabled := True;
end;

procedure TfrmPnlDadosItemResumido.pEscreveAtualizando;
begin
  If Not bnlLigaScroll Then
    Exit;

  If Not Self.Showing Then
    Exit;

  If Not GetDataSetItem.Active then
    Exit;

  If GetDataSetItem.IsEmpty then
    Exit;

  If TcxEditorRow(cxvSaldos.Rows[0]).Properties.Value = 'Atualizando...' Then
    Exit;

  pMostraAtualizandoSaldos(cxvSaldos);
  pMostraAtualizandoSaldos(cxvSaldosML);

  cxvLojas.OptionsView.NoDataToDisplayInfoText := 'Atualizando...';
  cxvSilimares.OptionsView.NoDataToDisplayInfoText := 'Atualizando...';
  MemProBrin.Lines.Text := 'Atualizando...';

  pnlEmbFec.Visible := False;
  pnlIteVeiculo.Visible := False;

  objSalLoj.qrySaldos.Close;
  objSalLoj.qrySimilares.Close;

  imgPro.Visible := False;

  Application.ProcessMessages;
end;

procedure TfrmPnlDadosItemResumido.pExecutarAcaoTAB;
begin
  Try
    If InterlockedIncrement(intLockTab) = 0 Then
    Begin
      Try
        blnExecutandoTABGridSimilares := True;
        If objPanel.fncTeclaTab(objSalLoj.qrySimilares, Self, fGetGridRowScreenPosition(cxgSimilares, cxvSilimares)) Then
          pSetarItemVendidoConsulta;
      Finally
        blnExecutandoTABGridSimilares := False;
      End;
    End;
  Finally
    InterlockedDecrement(intLockTab);
  End;
end;

procedure TfrmPnlDadosItemResumido.pgcSaldosEnter(Sender: TObject);
begin
  bnlLigaScroll := False;
end;

procedure TfrmPnlDadosItemResumido.pgcSaldosExit(Sender: TObject);
begin
  bnlLigaScroll := True;
end;

procedure TfrmPnlDadosItemResumido.pMostraAtualizandoSaldos(cxvSaldos: TcxVerticalGrid; strMensagem: String = 'Atualizando...');
  Var
    intContador: Integer;
Begin
  For intContador := 0 To cxvSaldos.Rows.Count - 1 Do
    TcxEditorRow(cxvSaldos.Rows[intContador]).Properties.Value := strMensagem;
End;

procedure TfrmPnlDadosItemResumido.pCarregaSaldos;
  Var
    fltSaldos,
    fltCnvML: Double;
    mskSaldo: String;
    intDecQtd: Integer;
Begin
  If Not fValidaCampos(['ITE_SALDOS', 'ITE_CODITE']) Then
  Begin
    pMostraAtualizandoSaldos(cxvSaldos, '');
    pMostraAtualizandoSaldos(cxvSaldosML, '');

    Exit;
  End;

   fltSaldos := GetCampoItem('ITE_SALDOS').AsFloat;

   If (GetCampoItem('ITE_CNV_ML') <> Nil)      And
      (GetCampoItem('ITE_CNV_ML').AsFloat > 0) Then
     fltCnvML := GetCampoItem('ITE_CNV_ML').AsFloat
   Else
     fltCnvML := 0;

   If (fltCnvML > 0) And fValidaCampos(['ITE_SAL_ML']) Then
     fltSaldos := fltSaldos + GetCampoItem('ITE_SAL_ML').AsFloat / fltCnvML;

   objSalLoj.pCalculaSaldos(GetDataSetItem,
                            recSaldos, recSaldosML,
                            fltSaldos, strEmpSal, strEmpSal,
                            GetCampoItem('ITE_CODITE').AsString, fltCnvML,
                            blnEntFut, blnPedCorte, blnOrdPro, intCalSal);

  intDecQtd := Max(3, fCfgSis('DECQTD', varInteger));

  mskSaldo := fMskDigitos(intDecQtd);

  With recSaldos Do
  Begin
    cxvEntFutPrevisao.Properties.Value := FormatFloat(mskSaldo, fltEntPre);
    cxvEntFutFalta.Properties.Value    := FormatFloat(mskSaldo, fltEntFal);
    cxvEntFutAguarda.Properties.Value  := FormatFloat(mskSaldo, fltEntAgu);
    cxvEstFisico.Properties.Value      := FormatFloat(mskSaldo, fltEstFis);
    cxvPedidoVenda.Properties.Value    := FormatFloat(mskSaldo, fltSalPed);
    cxvEnderecamento.Properties.Value  := FormatFloat(mskSaldo, fltSalEnd);
    cxvOrdemProducao.Properties.Value  := FormatFloat(mskSaldo, fltSalOrd);
    cxvGarantia.Properties.Value       := FormatFloat(mskSaldo, fltSalGar);
    cxvDisponivel.Properties.Value     := FormatFloat(mskSaldo, fltSalDis);
    cxvTransfEstAndamentoAgFat.Properties.Value := FormatFloat(mskSaldo, fltEstEnv);
    cxvTransfEstAndamentoAgEnt.Properties.Value := FormatFloat(mskSaldo, fltEstRec);

    If cxvSaldoCompartilhado.Visible And fValidaCampos(['SALCMP']) Then
      cxvSaldoCompartilhado.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('SALCMP').AsFloat);

    If cxvTotalEmOrdProd.Visible And fValidaCampos(['SALROP']) Then
      cxvTotalEmOrdProd.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('SALROP').AsFloat);

    If (strPDCPRO <> 'N') And fValidaCampos(['QTD_PEDCOM']) Then
      cxvPedidoCompra.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('QTD_PEDCOM').AsFloat)
    Else
      cxvPedidoCompra.Properties.Value := '';

    If (strPDCPRO = 'T') And fValidaCampos(['QTD_PEDCOT']) Then
      cxvPedidoCompraPendenteLojas.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('QTD_PEDCOT').AsFloat)
    Else
      cxvPedidoCompraPendenteLojas.Properties.Value := '';

    If (strPDCPRO <> 'N') And fValidaCampos(['QTD_REQPEN']) Then
      cxvReqPendente.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('QTD_REQPEN').AsFloat)
    Else
      cxvReqPendente.Properties.Value := '';

    If (strPDCPRO = 'T') And fValidaCampos(['QTD_REQPET']) Then
      cxvReqPendenteLojas.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('QTD_REQPET').AsFloat)
    Else
      cxvReqPendenteLojas.Properties.Value := '';

    cxvExterno.Properties.Value             := FormatFloat(mskSaldo, fltSalExt);
    cxvPedidoBaixaEntregaFutura.Properties.Value := FormatFloat(mskSaldo, fltSdPdBf);
  End;

  With recSaldosML Do
  Begin
    cxvEntFutPrevisaoML.Properties.Value := FormatFloat(mskSaldo, fltEntPre);
    cxvEntFutFaltaML.Properties.Value    := FormatFloat(mskSaldo, fltEntFal);
    cxvEntFutAguardaML.Properties.Value  := FormatFloat(mskSaldo, fltEntAgu);
    cxvEstFisicoML.Properties.Value      := FormatFloat(mskSaldo, fltEstFis);
    cxvPedidoVendaML.Properties.Value    := FormatFloat(mskSaldo, fltSalPed);
    cxvEnderecamentoML.Properties.Value  := FormatFloat(mskSaldo, fltSalEnd);
    cxvOrdemProducaoML.Properties.Value  := FormatFloat(mskSaldo, fltSalOrd);
    cxvGarantiaML.Properties.Value       := FormatFloat(mskSaldo, fltSalGar);
    cxvDisponivelML.Properties.Value     := FormatFloat(mskSaldo, fltSalDis);

    If (strPDCPRO <> 'N') And fValidaCampos(['QTD_PEDCOM']) Then
      cxvPedidoCompraML.Properties.Value := FormatFloat(mskSaldo, GetCampoItem('QTD_PEDCOM').AsFloat *
                  IIF(fValidaCampos(['ITE_CNV_ML']), GetCampoItem('ITE_CNV_ML').asFloat, 1))
    Else
       cxvPedidoCompraML.Properties.Value := '';

    cxvTransfEstAndamentoML.Properties.Value  := FormatFloat(mskSaldo, fltTraEst);
    cxvExternoML.Properties.Value             := FormatFloat(mskSaldo, fltSalExt);
    cxvPedidoBaixaEntregaFuturaML.Properties.Value := FormatFloat(mskSaldo, fltSdPdBf);
  End;

  TcxCurrencyEditProperties(cxvLojasSALFIS.Properties).DecimalPlaces := intDecQtd;
  TcxCurrencyEditProperties(cxvLojasSALFIS.Properties).DisplayFormat := mskSaldo;
  cxvLojasSALFIS.Summary.FooterFormat                                := mskSaldo;

  TcxCurrencyEditProperties(cxvLojasSALDIS.Properties).DecimalPlaces := intDecQtd;
  TcxCurrencyEditProperties(cxvLojasSALDIS.Properties).DisplayFormat := mskSaldo;
  cxvLojasSALDIS.Summary.FooterFormat                                := mskSaldo;

  TcxCurrencyEditProperties(cxvSimilaresSALDIS.Properties).DecimalPlaces := intDecQtd;
  TcxCurrencyEditProperties(cxvSimilaresSALDIS.Properties).DisplayFormat := mskSaldo;
End;

procedure TfrmPnlDadosItemResumido.AppEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
  If Msg.message = WM_MESSAGENAVEGANDOGRIDCONSULTA Then
    pWMMessageNavegandoGridConsulta;

  If Msg.message = WM_MESSAGEPRESSIONOUTABCONSULTA Then
    pWMMessagePressionouTabConsulta;

  If Msg.message = WM_MESSAGECONSULTAFORMRESIZE Then
    pWMMessageRedimensionouFormConsulta;

  If Msg.message = WM_MESSAGEATUALIZOUTOTALVENDA Then
    pWMMessageAtualizouTotalVenda;
end;

procedure TfrmPnlDadosItemResumido.btnAlterarModoTABClick(Sender: TObject);
begin
  If Not btnAlterarModoTAB.Visible Then Exit;
  VS_strModoTAB := IIF(VS_strModoTAB = '1', '2', '1');
  pSetaDescricaoModoTAB;
end;

procedure TfrmPnlDadosItemResumido.btnCndPagClick(Sender: TObject);
begin
  If Not Assigned(procExibeCndPag) Then
    Exit;

  procExibeCndPag(strCodCndPag,
                  strCndPag,
                  strCodForPag,
                  strDesForPag,
                  blnConfirmaCndPag);

  If blnConfirmaCndPag Then
  Begin
    pInformaCndPag;

    pSetFocus(edtDesMax);

    blnConfirmaCndPag := False;
  End;
end;

procedure TfrmPnlDadosItemResumido.btnCompCustoClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    TfrmCadProdutosCompCusto.pMostraComposicaoPrecoCusto(GetCampoItem('ITE_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmPnlDadosItemResumido.btnComSisAntClick(Sender: TObject);
begin
  If Not btnComSisAnt.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  TfrmFatConsVendasAntigas.pMostraComprasAntigas(GetCampoItem('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemResumido.btnConsVendasPerdidasClick(Sender: TObject);
begin
  If btnConsVendasPerdidas.Visible   And
     Assigned(procRelVendasPerdidas) Then
  Begin
    If Not fVerificaAcessoSistema('CPVEPE', strLoginUsuarioLogado) Then
    Begin
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
      Exit;
    End;

    If Not fValidaCampos(['ITE_CODITE']) Then
      Exit;

    procRelVendasPerdidas(strCodCli, GetCampoItem('ITE_CODITE').AsString);
  End;
end;

procedure TfrmPnlDadosItemResumido.btnEstDetClick(Sender: TObject);
begin
   If GetDataSetItem.IsEmpty Then
     Exit;

  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  prcExecutaRelatorio(319, 0,
                     [],
                     ['CODITE'],
                     [GetCampoItem('ITE_CODITE').AsString],
                      Sender,
                     ['CODITE'],
                     True);

end;

procedure TfrmPnlDadosItemResumido.btnExiEstruturaClick(Sender: TObject);
begin
  If Not fVerificaAcessoSistema('CPEXTR', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not btnExiEstrutura.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  pMostraEstrutura(GetCampoItem('ITE_CODITE').AsString, strEmpSal, True, blnPedCorte, True, False);
end;

procedure TfrmPnlDadosItemResumido.pExecutaFichaKardex;
begin
  If GetDataSetItem.IsEmpty Then
     Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(34, 2951, [2951,2958],
                         ['CODEMP','CODITE'],
                         [VS_STRCODEMP,GetCampoItem('ITE_CODITE').AsString],
                         Nil, Nil, False, True, 'frmRelEstKardex');
end;

procedure TfrmPnlDadosItemResumido.btnFichaKardexClick(Sender: TObject);
begin
  pExecutaFichaKardex;
end;

procedure TfrmPnlDadosItemResumido.btnItensCompClick(Sender: TObject);
begin

  If Not fVerificaAcessoSistema('ITECMP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Comprados!', ['&O k']);
    Exit;
  End;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(73, 5226, [],
                        ['CODITE','DESITE'],
                        [GetCampoItem('ITE_CODITE').AsString,
                        GetCampoItem('ITE_DESITE').AsString],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPnlDadosItemResumido.btnItensVendClick(Sender: TObject);
begin
  If fEmptyStr(strEmpConsVendFatur) Then
    strEmpConsVendFatur := fRetEmpConsVendFatur(strLoginUsuarioLogado);

  If (Pos(VS_strCodEmp, strEmpConsVendFatur) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
    Exit;
  End
  Else
  Begin

    If Not fVerificaAcessoSistema('ITEVEN') Then
    Begin
      fMensagem('', 'Operador não tem direito de acesso aos Itens Vendidos!', ['&O k']);
      Exit;
    End;

    If Not fValidaCampos(['ITE_CODITE']) Then
      Exit;

    TfrmRelFatVendasCliente.pMostraItensVendidos(GetCampoItem('ITE_CODITE').AsString, procMostraDocumentoReimpressao);
  End;

end;

procedure TfrmPnlDadosItemResumido.btnLotIteClick(Sender: TObject);
begin

  inherited;

  If Not fVerificaAcessoSistema('CPLOTI', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(320, 12128, [12129,12130,12131,12132],
                      ['CODITE', 'FILLOJ'],
                      [GetCampoItem('ITE_CODITE').AsString, 'N'],
                      Sender,
                      ['CODITE'],
                      not fCfgSis('CNLOTD', VarBoolean));
  End;

end;

procedure TfrmPnlDadosItemResumido.btnMostraPrecoVendaClick(Sender: TObject);
begin

  If Not fVerificaAcessoSistema('PREVEN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso.', ['&O k']);
    Exit;
  End;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(74, 5242, [],
                        ['CODITE'],
                        [GetCampoItem('ITE_CODITE').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlDadosItemResumido.btnOrcamentosClick(Sender: TObject);
begin
  If Not fVerificaAcessoSistema('CPORCA', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  TfrmConsultaOrcPesqItem.pMostraOrcamento(GetCampoItem('ITE_CODITE').AsString,
                                           GetCampoItem('ITE_DESITE').AsString,
                                           procMostraDocumentoReimpressao);
end;

procedure TfrmPnlDadosItemResumido.btnPopupClick(Sender: TObject);
begin
  pSetaDescricaoModoTAB;
  ShowPopupMenu(btnPopup, popMenu,  btnPopup.ClientOrigin.X, btnPopup.ClientOrigin.y);
end;

procedure TfrmPnlDadosItemResumido.btnSepIteClick(Sender: TObject);
  Var
    strRefere,
    strMsgLv1 : String;
begin

  If Not fVerificaAcessoSistema('CPSEIT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  strRefere := '';
  strMsgLv1 := '';

  If GetCampoItem('ITE_REFERE') <> Nil Then
    strRefere := GetCampoItem('ITE_REFERE').AsString;

  If GetCampoItem('ITE_MSGLV1') <> Nil Then
    strMsgLv1 := GetCampoItem('ITE_MSGLV1').AsString;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE', 'CAM_LOCFIS', 'UNI_SIGUNI', 'ITE_PREVEN']) Then
    Exit;

  TfrmControleSepAvulsa.pImprimeSeparacaoItem(GetCampoItem('ITE_CODITE').AsString,
                                              GetCampoItem('ITE_DESITE').AsString,
                                              GetCampoItem('CAM_LOCFIS').AsString,
                                              GetCampoItem('UNI_SIGUNI').AsString,
                                              fRetCodFabrica(GetCampoItem('ITE_CODITE').AsString),
                                              strCodCli,
                                              strCodVen,
                                              strCodDig,
                                              GetCampoItem('ITE_PREVEN').AsFloat,
                                              strRefere,
                                              strMsgLv1);
end;


procedure TfrmPnlDadosItemResumido.btnVedasSisAntClick(Sender: TObject);
begin
  If Not btnVedasSisAnt.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  TfrmFatConsVendasAntigas.pMostraVendasAntigas(GetCampoItem('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemResumido.btnVendasPerdidasClick(Sender: TObject);
begin
  If Not btnVendasPerdidas.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPIVPE', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  else
    If Assigned(procVendasPerdidas) Then
      procVendasPerdidas(strCodCli, fRetSenhaVendedor(strSenVen), GetCampoItem('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemResumido.mnuAgregadosClick(Sender: TObject);
begin
  If Not mnuAgregados.Visible Then
    Exit;

  If Not Assigned(procExibeAgregados) Then
    Exit;

  If (cdsConsulta.FindField('AGR_CODAGR') <> Nil) And
     (Not fEmptyStr(cdsConsulta.FieldByName('AGR_CODAGR').AsString)) Then
    procExibeAgregados(cdsConsulta.FieldByName('AGR_CODAGR').AsString, strTabPre, blnFaturamento);
end;

procedure TfrmPnlDadosItemResumido.mnuCadArmazemClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLoteItens);
end;

procedure TfrmPnlDadosItemResumido.mnuCadSimilaridadeClick(
  Sender: TObject);
  Var
    frmRelacSimilaridade : TfrmRelacSimilaridade;
begin
  If GetDataSetItem.IsEmpty Then
    Exit;
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;
  pCriarFormularios(TfrmRelacSimilaridade, frmRelacSimilaridade);
  Try
    frmRelacSimilaridade.edtCodIte.Text := GetCampoItem('ITE_CODITE').AsString;
    frmRelacSimilaridade.ShowModal;
  Finally
    pFreeAndNil(frmRelacSimilaridade);
  End;
end;

procedure TfrmPnlDadosItemResumido.cxgIteEmbEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemResumido.cxgIteEmbExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemResumido.cxgLojasEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemResumido.cxgLojasExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemResumido.cxgSimilaresEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
  blnNavegandoGridSimilares := (Not dtsSimilares.DataSet.IsEmpty);

  objPanel.blnEstaNoGridSimilar := True;

  pAtualizarCorInformacoesItens;
  If blnNavegandoGridSimilares Then
    pAtualizaDados;
end;

procedure TfrmPnlDadosItemResumido.cxgSimilaresExit(Sender: TObject);
begin
  objPanel.blnEstaNoGridSimilar := False;
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemResumido.cxvGarantiaEditPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  pChamaRelatorio(Sender);
end;

procedure TfrmPnlDadosItemResumido.cxvLojasCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If (fCfgSis('UPSEML', varBoolean)) And ((Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxvLojasLISREG.Index]) = '1') Then
  Begin
    ACanvas.Brush.Color := $0077A4FF;
  End;

  If AViewInfo.Selected Then
    If AViewInfo.Item.Styles.Content = cxsSaldos Then
    Begin
      ACanvas.Brush.Color := cxsSaldos.Color;
      ACanvas.Font.Color  := cxsSaldos.Font.Color;
    End;
end;

procedure TfrmPnlDadosItemResumido.cxvSaldosEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemResumido.cxvSaldosExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemResumido.cxvSaldosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    cmpPai: TWinControl;
begin
  Case Key Of
    VK_ESCAPE: Begin
                 cmpPai := Self.Parent;

                 While Not (cmpPai Is TForm) Do
                   cmpPai := cmpPai.Parent;

                 (cmpPai As TForm).Close;
    End;
  End;

  pDestacaCorDeFonteFiltroAplicacao;
end;

procedure TfrmPnlDadosItemResumido.cxvSaldosMLEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemResumido.cxvSaldosMLExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemResumido.cxvSilimaresCellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  tmrAtualizarDados.Enabled := True;
end;

procedure TfrmPnlDadosItemResumido.cxvSilimaresCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  If AViewInfo.Selected Then
    If AViewInfo.Item.Styles.Content = cxsSaldos Then
    Begin
      ACanvas.Brush.Color := cxsSaldos.Color;
      ACanvas.Font.Color  := cxsSaldos.Font.Color;
    End;
end;

procedure TfrmPnlDadosItemResumido.cxvSilimaresKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FormKeyDown(Sender, Key, Shift);
end;

procedure TfrmPnlDadosItemResumido.edtDesMaxExit(Sender: TObject);
begin
  inherited;
  If StrToFloatDef(edtDesMax.Text, 0) <> fltDescApli Then
    pCalculaDesconto;
end;

procedure TfrmPnlDadosItemResumido.edtDesMaxKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
  Begin
    pCalculaDesconto;
    edtDesMax.SelectAll;
    Key := 0;
  End;
end;

procedure TfrmPnlDadosItemResumido.pCalculaDesconto;
begin
  fltDescApli := StrToFloatDef(edtDesMax.Text, 0);
  edtDesMax.Text := FormatFloat(edtDesMax.EditFormat, fltDescApli);

  If (fltDescApli > fltDescMaxV) Or (fltDescApli > fltDescMaxG) Then
  Begin
    edtDesMax.NormalColor := clRed;
    edtDesMax.FocusColor  := clRed;
  End
  Else
  Begin
    edtDesMax.NormalColor := clWindow;
    edtDesMax.FocusColor  := clWindow;
  End;

  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    cdsConsulta.Refresh;
    pAtualizaDados;
  End;
end;

procedure TfrmPnlDadosItemResumido.imgProDblClick(Sender: TObject);
begin
  try
    If Not fValidaCampos(['ITE_CODITE']) Then
      Exit;

    if blnImgPro and (not GetDataSetItem.IsEmpty) then
      TfrmImagens.pAbrirImagens(tiProduto, GetCampoItem('ITE_CODITE').AsString, True, '', strCodCli, True);
  Except

    On E: ExceptionAutCom do
      pMensagemOk(E.Message);

    On E: Exception do
      pMensagensErro(E.Message, '[imgProDblClick]');

  End;
end;

procedure TfrmPnlDadosItemResumido.lblExpandirAplicacaoClick(Sender: TObject);
  Var
    frmVisualizarAplicacaoProduto : TfrmVisualizarAplicacaoProduto;
    LDataSet : TDataSet;
begin
  inherited;
  If (Not Assigned(DBAplica.DataSource)) Then
    Exit;

  If (Not Assigned(DBAplica.DataSource.DataSet)) Then
    Exit;

  LDataSet := DBAplica.DataSource.DataSet;

  If (Not Assigned(LDataSet.FindField('ITE_APLICA'))) Then
    Exit;

  If (fEmptyStr(LDataSet.FieldByName('ITE_APLICA').AsString)) Then
    Exit;

  pCriarFormularios(TfrmVisualizarAplicacaoProduto, frmVisualizarAplicacaoProduto);
  Try
    frmVisualizarAplicacaoProduto.edtAplicacao.Lines := TRichEdit(DBAplica).Lines;
    frmVisualizarAplicacaoProduto.FCodIte := LDataSet.FieldByName('ITE_CODITE').AsInteger;
    frmVisualizarAplicacaoProduto.lblProd.Caption := 'Aplicação: ' + LDataSet.FieldByName('ITE_DESITE').AsString;
    frmVisualizarAplicacaoProduto.ShowModal;
  Finally
    pFreeAndNil(frmVisualizarAplicacaoProduto);
  End;
end;

procedure TfrmPnlDadosItemResumido.lblLegendasClick(Sender: TObject);
begin
  Try
    cdsLegendas := TLegendasItem.Create(Self);
    TfrmMostraLegendasItem.pMostraLegendas(cdsLegendas);
    cdsLegendas.fAbreClient(True,'');
  Finally
    FreeAndNil(cdsLegendas);
  End;
end;

procedure TfrmPnlDadosItemResumido.mnuConfigRelClick(Sender: TObject);
begin
  inherited;
  pChamaRelatorio(Sender);
end;

procedure TfrmPnlDadosItemResumido.mnuConsultaBalcaoClick(Sender: TObject);
begin
  inherited;
  If GetDataSetItem.IsEmpty Then
    Exit;
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;
  TfrmConsultaEstoqueApis.pConsultaFullSearch(GetCampoItem('ITE_CODITE').AsString);

end;

Procedure TfrmPnlDadosItemResumido.mnuEnviarporWhatsappClick(Sender: TObject);
var
  recImagem: TArray<TRecArquivosGatilhos>;
begin
  inherited;

  if GetDataSetItem.IsEmpty then
    Exit;

  SetLength(recImagem, 1);
  recImagem[0] := TRecArquivosGatilhos.Create('IMAGEM PRODUTO_'+GetCampoItem('ITE_CODITE').AsString+'-'+Copy(fRetNomProduto(GetCampoItem('ITE_CODITE').AsString),1,10),
                                              fCampoTabela('ITE_IMGB64',
                                                           'ITEIMG',
                                                           ['ITE_CODITE', 'ITE_PRINCI'],
                                                           [GetCampoItem('ITE_CODITE').AsString, 'S']),
                                              EmptyStr,
                                              tpaImagem);

  if fEmptyStr(recImagem[0].Arquivo) then
    Exit;

  if fDisparaWhatsappAutomatico('',
                                'PR',
                                '',
                                '',
                                'FP',
                                '',
                                '',
                                '',
                                False,
                                '',
                                nil,
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                False,
                                False,
                                nil,
                                '',
                                '',
                                recImagem,
                                GetCampoItem('ITE_CODITE').AsString) then
    fMensagem('', 'Whatsapp enviado com sucesso!', ['&Ok'])
  else
    fMensagem('', 'Whatsapp não enviado!', ['&Ok']);
end;

procedure TfrmPnlDadosItemResumido.mnuEstVendaForaEstabClick(Sender: TObject);
begin
  If GetDataSetItem.IsEmpty Then
     Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(387, 17937,
                         [17937],
                         ['CODEMP','CODITE'],
                         [VS_strCodEmp, GetCampoItem('ITE_CODITE').AsString],
                         Sender,
                         Nil,
                         True);
end;

procedure TfrmPnlDadosItemResumido.mnuNotasFiscaisAssociadasEmAbertoClick(
  Sender: TObject);
begin
  If GetDataSetItem.IsEmpty Then
     Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('VNFACP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso "Visualizar relatório de Notas Fiscais Associadas - Em Aberto na consulta de produtos"!', ['&OK']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(440, 22808,
                        [],
                        ['CODITE'],
                        [GetCampoItem('ITE_CODITE').AsString],
                        Sender,
                        ['CODITE'],
                        False);
end;

procedure TfrmPnlDadosItemResumido.mnuPedCompGridClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPPECG', strLoginUsuarioLogado) Then
  begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  end;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(452, 28152,
                        [],
                        ['CODITE'],
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                        Sender,
                        ['CODITE'],
                        True);
end;

procedure TfrmPnlDadosItemResumido.pAbreIteEmb;
Begin
  pnlEmbFec.Visible := False;
  pnlIteVeiculo.Visible := False;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If blnModeloVeiculo Then
  Begin
    objCadProdutosVeiculoModelo.pIniciaProcesso(GetCampoItem('ITE_CODITE').AsString, '');
    pnlIteVeiculo.Visible := objCadProdutosVeiculoModelo.DataSource.DataSet.RecordCount > 0;
    If pnlIteVeiculo.Visible Then
      cxVeiculosDB.ApplyBestFit()
    Else
    Begin
      cdsIteEmb.pAbreIteEmb(strTabPre, GetCampoItem('ITE_CODITE').AsString);
      pnlEmbFec.Visible := (cdsIteEmb.RecordCount > 0);
    End;
  End
  Else
  Begin
    cdsIteEmb.pAbreIteEmb(strTabPre, GetCampoItem('ITE_CODITE').AsString);
    pnlEmbFec.Visible := (cdsIteEmb.RecordCount > 0);
  End;
End;

procedure TfrmPnlDadosItemResumido.pAjustaAlturaPainelPrincipal;
  Var
    intMinHeight,
    intAlturaTotais,
    intAltura: Integer;
begin
  pnlProBrin.Visible := (fCfgSis('PROBRI', VarBoolean)) And (Pos(strOpcDoc, 'VN_PD_OR_') > 0);

  intMinHeight := 0;

  If pnlSimilares.Visible Then
    intMinHeight := intMinHeight + 120 {Tamanho mínimo - Está alClient};

  intMinHeight := intMinHeight + pnlGrupoVeiculos.Height;

  If (Not Assigned(objPanel)) Or (Not objPanel.blnExibeCamposTotalVenda) Then
    intAlturaTotais := pnlGrupoVeiculos.Height
  Else
    intAlturaTotais := intTotaisLateralHeight;

  intMinHeight := Max(intAlturaTotais, intMinHeight);

  intAltura := 0;

  If pnlProBrin.Visible Then
    intAltura := intAltura + pnlProBrin.Height;

  If pnlCndPag.Visible Then
    intAltura := intAltura + pnlCndPag.Height;

  If pnlTotaisRodape.Visible Then
    intAltura := intAltura + pnlTotaisRodape.Height + 5;

  If pnlAplicacao.Visible Then
    intAltura := intAltura + pnlAplicacao.Height;

  objPanel.pgcDropControl.Height := intAltura + pnlTopMeio.Height + Max(intMinHeight, cxvSaldos.Height) + 10;

  cxvSaldos.Align := alClient;
end;

procedure TfrmPnlDadosItemResumido.pAtualizaPainelTotaisVenda;
  Var
    blnSetaPosVertical: Boolean;
begin
  If (Not Assigned(objPanel)) Or (Not objPanel.blnExibeCamposTotalVenda) Then
  Begin
    pnlTotaisLateral.Visible := False;

    If pnlTotaisRodape.Visible Then
    Begin
      pnlTotaisRodape.Visible := False;

      If Assigned(objPanel) And Assigned(objPanel.pgcDropControl) Then
        objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height - pnlTotaisRodape.Height;
    End;
    Exit;
  End;

  If Not Assigned(objPanel.pgcDropControl) Then
    Exit;

  If (Self.Width > FDefaultFormWidth) And (Not blnModeloVeiculo) Then
  Begin
    pnlTotaisLateralFlow.Parent := pnlTotaisLateral;

    If pnlTotaisRodape.Visible Then
    Begin
      pnlTotaisRodape.Visible := False;
      objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height - pnlTotaisRodape.Height;
    End;
    pnlTotaisLateral.Visible := True;

    blnSetaPosVertical := True;
  End
  Else
  Begin
    pnlTotaisLateralFlow.Parent := pnlTotaisRodape;

    If Not pnlTotaisRodape.Visible Then
    Begin
      pnlTotaisRodape.Visible := True;
      objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height + pnlTotaisRodape.Height;
    End;
    pnlTotaisLateral.Visible := False;

    blnSetaPosVertical := False;
  End;

  edtTotGer.Text := objPanel.CamposTotalVenda.edtTotGer.Text;
  edtSohIPI.Text := objPanel.CamposTotalVenda.edtSohIPI.Text;
  edtTotIpi.Text := objPanel.CamposTotalVenda.edtTotIpi.Text;
  edtSohST.Text  := objPanel.CamposTotalVenda.edtSohST.Text;
  edtSohFCP.Text := objPanel.CamposTotalVenda.edtSohFCP.Text;
  edtSohCBS.Text := objPanel.CamposTotalVenda.edtSohCBS.Text;
  edtSohIBS.Text := objPanel.CamposTotalVenda.edtSohIBS.Text;
  edtSohIS.Text  := objPanel.CamposTotalVenda.edtSohIS.Text;
  edtTotSer.Text := objPanel.CamposTotalVenda.edtTotSer.Text;
  edtTotImp.Text := objPanel.CamposTotalVenda.edtTotImp.Text;

  pnlTotGer.Visible := objPanel.CamposTotalVenda.edtTotGer.Visible;
  pnlSohIPI.Visible := objPanel.CamposTotalVenda.edtSohIPI.Visible;
  pnlTotIpi.Visible := objPanel.CamposTotalVenda.edtTotIpi.Visible;
  pnlSohST.Visible  := objPanel.CamposTotalVenda.edtSohST.Visible;
  pnlSohFCP.Visible := objPanel.CamposTotalVenda.edtSohFCP.Visible;
  pnlSohCBS.Visible := objPanel.CamposTotalVenda.edtSohCBS.Visible;
  pnlSohIBS.Visible := objPanel.CamposTotalVenda.edtSohIBS.Visible;
  pnlSohIS.Visible  := objPanel.CamposTotalVenda.edtSohIS.Visible;
  pnlTotSer.Visible := objPanel.CamposTotalVenda.edtTotSer.Visible;
  pnlTotImp.Visible := objPanel.CamposTotalVenda.edtTotImp.Visible;

  pAjustaAlturaTotais(blnSetaPosVertical, intDefaultWidthTotais);

  If Not blnSetaPosVertical Then
    pAjustaAlturaRodapeTotais;
end;

procedure TfrmPnlDadosItemResumido.pAjustaAlturaRodapeTotais;
  Var
    intLarguraUtil,
    intLarguraLinha,
    intLinhas,
    intAltura,
    intContador: Integer;
    objPainel: TControl;
Begin
  intLarguraUtil  := pnlTotaisLateralFlow.ClientWidth - pnlTotaisLateralFlow.Padding.Left - pnlTotaisLateralFlow.Padding.Right;
  intLarguraLinha := 0;
  intLinhas       := 1;

  For intContador := 0 To pnlTotaisLateralFlow.ControlCount - 1 Do
  Begin
    objPainel := pnlTotaisLateralFlow.Controls[intContador];

    If Not objPainel.Visible Then
      Continue;

    If (intLarguraLinha > 0) And (intLarguraLinha + objPainel.Width >= intLarguraUtil) Then
    Begin
      Inc(intLinhas);
      intLarguraLinha := 0;
    End;

    intLarguraLinha := intLarguraLinha + objPainel.Width;
  End;

  intAltura := FDefaultpnlTotaisRodapeHeight + (intLinhas - 1) * pnlTotImp.Height;

  If intAltura = pnlTotaisRodape.Height Then
    Exit;

  objPanel.pgcDropControl.Height := objPanel.pgcDropControl.Height + intAltura - pnlTotaisRodape.Height;
  pnlTotaisRodape.Height := intAltura;
End;

function TfrmPnlDadosItemResumido.fCondicaoAbateDescontoAutomaticamente(const strCodCnd : String) : Boolean;
begin
  Result := True;

  If fEmptyStr(strCodCnd) Then
    Exit;

  Result := (fCampoTabela('CND_ABADES','CADCND', ['CND_CODIGO'], [strCodCnd], False) = 'S');
end;

procedure TfrmPnlDadosItemResumido.pInformaCndPag;
var
  fltTxJCnd: Double;
begin
  fltDescMaxV := fRetDescMaxCnd(strCodCndPag, mdVendedor);
  fltDescMaxG := fRetDescMaxCnd(strCodCndPag, mdGerenteJunior);
  fltDescApli := fltDescMaxV;
  If (Not fCondicaoAbateDescontoAutomaticamente(strCodCndPag)) Then
    fltDescApli := 0;
  fltTxJCnd := fCampoTabela('CND_TXJURO','CADCND',['CND_CODIGO'],[strCodCndPag], False);
  fltTxJuros := fCalculaTaxVpr(strCndPag, fltTxJCnd);

  edtDesMax.Text := FormatFloat(edtDesMax.EditFormat, fltDescApli);

  If (fltDescApli > fltDescMaxG) Then
  Begin
    edtDesMax.NormalColor := clRed;
    edtDesMax.FocusColor  := clRed;
  End
  Else
  Begin
    edtDesMax.NormalColor := clWindow;
    edtDesMax.FocusColor  := clWindow;
  End;

  lblCndPag.Caption := 'Cond. Pgto.: ' + strCodCndPag + ' - ' + strCndPag +
                       ' / Forma Pgto.: ' + strCodForPag + ' - ' + strDesForPag;

  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    cdsConsulta.Refresh;
    pAtualizaDados;
  End;
end;

procedure TfrmPnlDadosItemResumido.pSetVisible(cxg: TcxEditorRow; bln: Boolean);
begin
  cxg.Visible := bln;
  if Assigned(Self.FindComponent(cxg.Name+'ML')) then
    TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Visible := bln
end;
    
procedure TfrmPnlDadosItemResumido.pSetIndex(cxg: TcxEditorRow);
begin
  Inc(intIdxCol);
      
  cxg.Index := intIdxCol;
  if Assigned(Self.FindComponent(cxg.Name+'ML')) then
    TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdxCol;
end;

procedure TfrmPnlDadosItemResumido.pOrdemInicial;
begin
  intIdxCol := -1;
      
  pSetIndex(cxvEstFisico);
  pSetIndex(cxvGarantia); 
  pSetIndex(cxvPedidoVenda);

  pSetIndex(cxvPedidoBaixaEntregaFutura);

  pSetIndex(cxvEnderecamento);

  If (fCfgSis('MOVFUL', varString) = '1') Then
    pSetIndex(cxvExterno);

  pSetIndex(cxvOrdemProducao);

  Case intCalSal Of
    1: Begin
         pSetIndex(cxvDisponivel); 
              
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutFalta);
         pSetIndex(cxvEntFutAguarda);
       End;
    2: Begin
         If fCfgSis('BEFTRG', VarBoolean) Then
         Begin
           pSetIndex(cxvDisponivel); 
                
           pSetIndex(cxvEntFutPrevisao);
           pSetIndex(cxvEntFutFalta);
           pSetIndex(cxvEntFutAguarda);
         End
         Else
         Begin
           pSetIndex(cxvEntFutPrevisao);
           pSetIndex(cxvEntFutFalta);
           pSetIndex(cxvEntFutAguarda);
               
           pSetIndex(cxvDisponivel);  
         End;
       End;
    3: Begin
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);

         pSetIndex(cxvDisponivel);  

         pSetIndex(cxvEntFutFalta);
       End;
    4: Begin
         pSetIndex(cxvEntFutFalta);
               
         pSetIndex(cxvDisponivel);  
             
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);
       End;
    5: Begin
         pSetIndex(cxvEntFutPrevisao);
               
         pSetIndex(cxvDisponivel);  

         pSetIndex(cxvEntFutAguarda);
         pSetIndex(cxvEntFutFalta);
       End;
  End;

  If (fCfgSis('MOVFUL', varString) = '2') Then
  Begin
    cxvExterno.Properties.Caption := 'Estoque Externo';
    if Assigned(Self.FindComponent(cxvExterno.Name+'ML')) then
      TcxEditorRow(Self.FindComponent(cxvExterno.Name+'ML')).Properties.Caption := 'Estoque Externo';
    pSetIndex(cxvExterno, cxvDisponivel.Index + 1);
  End;

  pSetIndex(cxvPedidoCompra);
  pSetIndex(cxvPedidoCompraPendenteLojas);
  pSetIndex(cxvReqPendente);
  pSetIndex(cxvReqPendenteLojas);
end;

procedure TfrmPnlDadosItemResumido.pAjustaAlturaSaldos;
var
  h: Integer;
  i: Integer;
  ARowBorder: Integer;
  blnListouSaldoDisponivel: Boolean;
begin
  cxvSaldos.Align := alNone;

  h := 0;
  if (cxvSaldos.OptionsView.GridLines = vglHorizontal) or (cxvSaldos.OptionsView.GridLines = vglBoth) then
    ARowBorder := cxvSaldos.ViewInfo.HorzLineWidth
  else
    ARowBorder := 0;

  blnListouSaldoDisponivel := False;

  for I := 0 to cxvSaldos.ViewInfo.VisibleRowCount - 1 do
  Begin
    h := h + cxvSaldos.ViewInfo.CalcRowHeight(cxvSaldos.ViewInfo.VisibleRows[I]) + ARowBorder;

    If (cxvSaldos.ViewInfo.VisibleRows[I] = cxvDisponivel) Then
      blnListouSaldoDisponivel := True;

    If blnListouSaldoDisponivel And ((Not blnSimilaresLocal) Or (I > 9)) {Espaço para 4 similares} Then
      Break;
  End;

  cxvSaldos.Height := h + 2 * cxvSaldos.ViewInfo.HorzLineWidth + ARowBorder;

  cxvSaldos.Height := cxvSaldos.Height + 27;
end;

procedure TfrmPnlDadosItemResumido.pInicialializaTelaSaldos;
Begin
  pOrdemInicial;

  pSetVisible(cxvPedidoCompraPendenteLojas, strPDCPRO = 'T');
  pSetVisible(cxvPedidoCompra, strPDCPRO = 'S');

  pSetVisible(cxvReqPendenteLojas, strPDCPRO = 'T');
  pSetVisible(cxvReqPendente, strPDCPRO = 'S');

  pSetVisible(cxvEntFutPrevisao,           blnEntFut);
  pSetVisible(cxvEntFutFalta,              blnEntFut);
  pSetVisible(cxvEntFutAguarda,            blnEntFut);

  pSetVisible(cxvPedidoVenda,   blnUsaPDV);
  pSetVisible(cxvEnderecamento, blnUsaPDV);
  pSetVisible(cxvOrdemProducao, blnUsaPDV And blnOrdPro);

  pSetVisible(cxvPedidoBaixaEntregaFutura, blnEntFut And fReservaSaldoPedidosBaixaEntregaFutura);

  cxvSaldoCompartilhado.Visible := fCfgSis('UPSEML', varBoolean);
  cxvTotalEmOrdProd.Visible := fCfgSis('EXIORD', varBoolean) And fCfgSis('ORDPRO', varBoolean);

  pAjustaAlturaSaldos;

 // cxgLojas.Height := pnlPgcSaldos.Height - cxgLojas.Top;

  tbsSaldosML.TabVisible   := False;
End;

procedure TfrmPnlDadosItemResumido.pIniciouNavegacaoGridConsulta;
begin
  inherited;
  pEscreveAtualizando;
end;

procedure TfrmPnlDadosItemResumido.pAtualizaInformacaoSubConsulta;
begin
  inherited;
  If (Not Self.Showing) Then
    Exit;
  If (Not Assigned(Self.cdsSubConsulta)) Then
    Exit;
  Self.blnAtualizandoInformacaoSubConsulta := True;
  Try
    pAtualizaDados;
  Finally
    Self.blnAtualizandoInformacaoSubConsulta := False;
  End;
end;

procedure TfrmPnlDadosItemResumido.pHabilitaTeclas(blnTravar: Boolean);
Begin
  blnEstaNoPainel := blnTravar;

  If Assigned(objPanel) Then
    objPanel.blnIgnorarTeclas := blnTravar;
End;

procedure TfrmPnlDadosItemResumido.pSetaDescricaoModoTAB;
begin
  If VS_strModoTAB = '1' Then
    btnAlterarModoTAB.Caption := STR_TAB_MODO_RESUMIDO
  Else
    btnAlterarModoTAB.Caption := STR_TAB_MODO_COMPLETO;
end;

procedure TfrmPnlDadosItemResumido.pSetarItemVendidoConsulta;
  Var
    strCodigo: String;
    strCodigoAtual: String;
    varVendido: Variant;
begin
  If Not fValidaCampos(['CODITE', 'VENDIDO']) Then
    Exit;

  strCodigo  := GetCampoItem('CODITE').AsString;
  varVendido := GetCampoItem('VENDIDO').Value;

  Try
    If (cdsConsulta.Active) And
       (Not cdsConsulta.IsEmpty) And
       (cdsConsulta.FindField('VENDIDO') <> Nil) And
       (cdsConsulta.FindField('ITE_CODITE') <> Nil) Then
    Begin
      strCodigoAtual := cdsConsulta.FindField('ITE_CODITE').AsString;

      If (cdsConsulta.Locate('ITE_CODITE', strCodigo, [])) Then
      Begin
        cdsConsulta.Edit;
        cdsConsulta.FieldByName('VENDIDO').Value := varVendido;
        cdsConsulta.Post;
      End;

      cdsConsulta.Locate('ITE_CODITE', strCodigoAtual, []);
    End;
  Finally
    Application.ProcessMessages;
      pSetFocus(cxgSimilares);
      cxgSimilaresEnter(nil);
      objSalLoj.qrySimilares.Locate('CODITE', strCodigo, []);
    End;
end;

procedure TfrmPnlDadosItemResumido.pSetIndex(cxg: TcxEditorRow;
  const intIdx: Integer);
begin
  Inc(intIdxCol);

  cxg.Index := intIdx;
  if Assigned(Self.FindComponent(cxg.Name+'ML')) then
    TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdx;
end;

procedure TfrmPnlDadosItemResumido.pSetPnlDadosItemVisible(AVisible: Boolean);
begin
  inherited;
  pnlDadosItem.Visible := AVisible;
end;

procedure TfrmPnlDadosItemResumido.pSetUtilizaChecklistGarantia(Value: Boolean);
begin
  blnUtilizaChecklistGarantia := Value;
  ChecklistDevoluoGarantia1.Enabled := blnUtilizaChecklistGarantia;
  ChecklistDevoluoGarantia1.Visible := ChecklistDevoluoGarantia1.Enabled;
end;

procedure TfrmPnlDadosItemResumido.pWMMessagePressionouTabConsulta;
begin
  If Not fCheckParent(GetParentForm(Self).ActiveControl, cxgSimilares) Then
    Exit;

  If (objSalLoj.qrySimilares.Active) And (Not objSalLoj.qrySimilares.IsEmpty) And
     Assigned(objPanel) And objPanel.blnTemPan And Assigned(objPanel.fncTeclaTab) Then
  Begin
    TfrmBloquearTela.fExecutarOperacao(pExecutarAcaoTAB);
  End;
end;

procedure TfrmPnlDadosItemResumido.pWMMessageRedimensionouFormConsulta;
begin
  pAtualizaPainelTotaisVenda;
end;

procedure TfrmPnlDadosItemResumido.ransfEstoqueemAndamento1Click(
  Sender: TObject);
 Var
    strCodIte: String;
begin
  inherited;

  If Not Assigned(prcExecutaRelatorio) Then
    Exit;

  If Not fVerificaAcessoSistema('CPTREA', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If (Not GetDataSetItem.IsEmpty) And (fValidaCampos(['ITE_CODITE'])) Then
    strCodIte := GetCampoItem('ITE_CODITE').AsString
  Else
    strCodIte := '';

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(106, 5813, [],
                        ['CODITE'],
                        [strCodIte],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlDadosItemResumido.mnuSemelhantesClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not mnuSemelhantes.Visible  Then
    Exit;

  If Not fVerificaAcessoSistema('CPSEME', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  else
  begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(64, 5044, [],
                            ['CODITE'],
                            [GetCampoItem('ITE_CODITE').AsString],
                            nil,
                            nil,
                            True);
    End;
  end;
end;

procedure TfrmPnlDadosItemResumido.mnuSimilarClick(Sender: TObject);
  Var
    strAutIncSim,
    strCodFab,
    strCodIte: String;
    blnEnterSim: Boolean;
begin
  If Not mnuSimilar.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE', 'ITE_CODSIM']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPSIMI', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
  Begin
    If TfrmFatMostraProdSimilar.fMostraSimilar(GetCampoItem('ITE_CODSIM').AsString,
                                               GetCampoItem('ITE_CODITE').AsString,
                                               GetCampoItem('ITE_DESITE').AsString,
                                               strTabPre,
                                               blnEnterSim,
                                               strAutIncSim,
                                               strCodFab,
                                               strCodIte,
                                               objPanel.blnItemDiferenteSimilar,
                                               False,
                                               blnFaturamento,
                                               False,
                                               '',
                                               '',
                                               intPraMedio) Then
    Begin
      If objPanel.blnConfirmaSimilar And blnEnterSim Then
      Begin
        objPanel.strSimilar := strAutIncSim;
        btnConfirma.Click;
      End;
    End

    Else fMensagem('', 'Não há itens similares!', ['&O k']);
  End;

end;

procedure TfrmPnlDadosItemResumido.rocadeMercadoria1Click(Sender: TObject);
begin
  If GetDataSetItem.IsEmpty Then
    Exit;
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;
  inherited;
  TCheckListGarantiaController
    .pImprimirCheckListTrocaMercadoria(GetCampoItem('ITE_CODITE').AsString,'', False);
end;

function TfrmPnlDadosItemResumido.tmrAtualizarDados: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrAtualizarDados') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
    Result.Timeout  := 2000;
    Result.Interval := 100;
    Result.Enabled  := False;
    Result.OnTimer  := tmrAtualizarDadosTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
end;

procedure TfrmPnlDadosItemResumido.mnuSolicitarRequisicaodeComprasClick(
  Sender: TObject);
begin
  inherited;
  {If TfrmFatSelPedidoCompraRequisicao.fJaPossuiVinculos(GetCampoItem('ITE_CODITE').AsString) Then
  Begin
    pMensagemOk('Já foram feitos vínculos para este item. Utilize o botão manutenção na tela do pedido de venda');
    Exit;
  End;}
  If Not fEmptyStr(GetCampoItem('ITE_CODITE').AsString) Then
    TfrmFatSelPedidoCompraRequisicao.pMostraTela(GetCampoItem('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemResumido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  bnlLigaScroll := False;
end;

procedure TfrmPnlDadosItemResumido.FormCreate(Sender: TObject);
begin
  inherited;
  blnSimilaresLocal := fCfgSis('POSSIM', varInteger) = 1;
  pnlSimilares.Visible := blnSimilaresLocal;

  intTotaisLateralHeight := pnlTotaisLateral.Height;
  intDefaultWidthTotais  := pnlTotImp.Width;

  If fCfgSis('CTLEST', VarString) = '1' Then
    mnuCadArmazem.Caption := 'Cadastro de Lotes'
  Else
    mnuCadArmazem.Caption := 'Cadastro de Armazém';

  mnuCadArmazem.Visible     := fVerificaAcessoSistema('frmCadArmazem', strLoginUsuarioLogado);

  mnuConsultaBalcao.Visible := TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fBalcaoHabilitado;


  mnuCadSimilaridade.Visible:=  (fCfgSis('EMPGER', VarBoolean)) And (fVerificaAcessoSistema('frmSimilaridade', strLoginUsuarioLogado));

  FDefaultFormWidth := Self.Width;
  FDefaultFormHeight := Self.Height;
  FDefaultcxgSimilaresWidth := cxgSimilares.Width;
  FDefaultpnlVeiculos_EmbalagensWidth := pnlVeiculos_Embalagens.Width;
  FDefaultpnlTotaisLateralLeft := pnlTotaisLateral.Left;
  FDefaultpnlTotaisRodapeWidth := pnlTotaisRodape.Width;
  FDefaultpnlTotaisRodapeHeight := pnlTotaisRodape.Height;
  FDefaultpnlImgProLeft := pnlImgPro.Left;
  FDefaultpnlCndPagWidth := pnlCndPag.Width;
  FDefaultpnlCndPagHeight := pnlCndPag.Height;

  cdsIteEmb := TEmbalagens.Create(Self);
  cxgIteEmbTableView.DataController.DataSource := cdsIteEmb.dtsSource;

  objGerenciaRodape := TGerenciaPropriedadesComponentes.Create(Self, 'ConsultadeItens');

  blnEstaNoPainel := False;
  blnModeloVeiculo := fCfgSis('PROVEI', varBoolean);

  If blnModeloVeiculo Then
  Begin
    objCadProdutosVeiculoModelo := TCadProdutosVeiculoModelo.Create;
    cxVeiculosDB.DataController.DataSource := objCadProdutosVeiculoModelo.DataSource;
  End;

  blnDirAceConsulta := fVerificaAcessoSistema('frmConsultaCxGridNova');

  If blnDirAceConsulta Then
  Begin
    pConfiguraPopup(btnEstDet);
  End Else
  Begin
    pgcSaldos.PopupMenu := Nil;
  End;

  blnExibirVrUnitarioPedCompraGrid := false;

  strPDCPRO := fCfgSis('PDCPRO', VarString);
  intCalSal := fCfgSis('CALSAL', varInteger);
  blnUsaPDV := fCfgSis('USAPDV', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnImgPro := fCfgSis('IMGPRO') = 'S';

  If fCfgSis('CTLEST') = '2' Then
    btnLotIte.Caption := StringReplace(btnLotIte.Caption, 'Lotes', 'Armazéns', []);

  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > fTamPrecoIteger Then
    intDecUni := 4;

  blnExiSalDisCD  := False;
  strEmpSal := '';

  bnlLigaScroll     := False;

  blnHabF7 := False;

  objPanel := Nil;

  objSalLoj := TSaldoLojas.Create(Self);
  dtsSalLoj.DataSet    := objSalLoj.qrySaldos;
  dtsSimilares.DataSet := objSalLoj.qrySimilares;

  pnlIteVeiculo.Visible := False;
  pConfiguraPopup(btnFichaKardex);
  pSetUtilizaChecklistGarantia(TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia);

  mnuSolicitarRequisicaodeCompras.Visible := fVerificaAcessoSistema('PSRDCNTC', strLoginUsuarioLogado) And fCfgSis('REQAUT', varBoolean);

  If Not pnlSimilares.Visible Then
  Begin
    pnlGrupoVeiculos.Align := alTop;
    pnlProBrin.Align := alTop;
  End;

  fraConsultaEstrutura := TfraConsultaEstrutura.Create(Self);
  fraConsultaEstrutura.Parent := pnlEstrutura;
End;

procedure TfrmPnlDadosItemResumido.FormDestroy(Sender: TObject);
begin
  TNewTimer.Del(Self.Name + '.tmrAtualizarDados');
  inherited;
  If blnSalvar_lblAplicacao Then
    objGerenciaRodape.pSalvar;
  FreeAndNil(objGerenciaRodape);
  FreeAndNil(objSalLoj);
  If (Assigned(objCadProdutosVeiculoModelo)) Then
    FreeAndNil(objCadProdutosVeiculoModelo);
end;

procedure TfrmPnlDadosItemResumido.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_TAB: If Assigned(objPanel) And objPanel.blnTemPan And Assigned(objPanel.fncTeclaTab) Then
              Key := 0;

    VK_F1 :If ssAlt In Shift Then
             btnComSisAnt.Click;

    VK_F2 :If ssAlt In Shift Then
             btnVedasSisAnt.Click
           Else If Shift = [] Then
             btnAlterarModoTAB.Click;

    VK_F4 : If ssCtrl In Shift Then
              btnCompCusto.Click;

    VK_F5 : If ssAlt In Shift Then
              btnSepIte.Click
            Else
              btnConsVendasPerdidas.Click;

    VK_F6 : If ssAlt In Shift Then
              btnLotIte.Click
            Else
              btnMostraPrecoVenda.Click;

    VK_F7 : If ssAlt In Shift Then
              mnuAgregados.Click
            Else
              mnuSemelhantes.Click;

    VK_F8 : If ssAlt In Shift Then
              btnExiEstrutura.Click
            Else
              pExecutaFichaKardex;

    VK_F9 : btnItensVend.Click;

    VK_F10: If (ssAlt In Shift) Then
            Begin
              If (btnOrcamentos.Visible) Then
                btnOrcamentos.Click
            End

            Else
              btnItensComp.Click;

    VK_F11: btnVendasPerdidas.Click;

    VK_F12: If ssAlt In Shift Then
              ransfEstoqueemAndamento1.Click
            Else
              mnuPedCompGrid.Click;

  end;

  If (Shift = [ssAlt]) And (char(Key) = 'R')  Then
    mnuSolicitarRequisicaodeCompras.Click;

  case Key of
    VK_F1,
    VK_F2,
    VK_F4,
    VK_F5,
    VK_F6,
    VK_F7,
    VK_F8,
    VK_F9,
    VK_F10,
    VK_F11,
    VK_F12: Key := 0;
   End;

End;

procedure TfrmPnlDadosItemResumido.pLimpaCamposSemSQL;
Begin
  If cdsConsulta.Active Then
  Begin
    If Not fValidaCampos(['ITE_APLICA']) Then
      DBAplica.DataField := '';

    If Not fValidaCampos(['MSGLIV']) Then
      dbeMSGLIV.DataField := '';
  End;

End;

procedure TfrmPnlDadosItemResumido.FormShow(Sender: TObject);
begin
  inherited;

  pLimpaCamposSemSQL;

  intLockTab := -1;
  blnNavegandoGridSimilares := False;
  blnAtualizandoInformacaoSubConsulta := False;
  blnFocadoNaSubConsulta := False;
  blnOrcPen := fCfgSis('ORCPEN', VarBoolean);

  If fEmptyStr(strEmpSal) Then
    strEmpSal := VS_strCodEmp;

  blnEstExt := fCfgSis('ESTEXT', varBoolean, strEmpSal);

  dtsConsulta.DataSet := cdsConsulta;

  cdsConsulta.First;

  btnVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And
                               (Not fEmptyStr(strCodCli)) And
                               (Not fEmptyStr(strSenVen)) And
                               (Assigned(procVendasPerdidas));

  btnConsVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And
                                   (Not fEmptyStr(strCodCli)) And
                                   (Assigned(procRelVendasPerdidas));

  bnlLigaScroll := True;

  btnComSisAnt.Visible := fCfgSis('PCGANT') = 'S';
  btnVedasSisAnt.Visible := fCfgSis('SISANT') = 'S';

  lblExpandirAplicacao.Visible := fCfgSis('EXIAPL', varBoolean);

  pnlCndPag.Visible := blnCndPag;
  lblCndPag.Caption := '';

  cxvSilimaresTAB.Visible := Assigned(objPanel) And Assigned(objPanel.sltLista);
  cxvSilimaresREFERE.Visible := fCfgSis('REFSIM') = 'S';

  If Assigned(objPanel) Then
  Begin
    pgcSaldos.Visible := objPanel.blnExibirSaldos;
    btnAlterarModoTAB.Visible := objPanel.blnAlternarModoTab;
  End;

  pnlSaldoLojas.Caption := '';
  pgcSaldos.Visible := (pgcSaldos.Visible And fVerificaAcessoSistema('PVISPF'));
  cxgLojas.Visible := fVerificaAcessoSistema('PVISPF');
  btnEstDet.Visible := fVerificaAcessoSistema('PVISPF');
  cxvSimilaresSALDIS.Visible := fVerificaAcessoSistema('PVISPF');
  pnlMsgLivre.Visible := fVerificaAcessoSistema('VISMLCP', strLoginUsuarioLogado);

  pInicialializaTelaSaldos;
  pAtualizarCorInformacoesItens;
  pSetaDescricaoModoTAB;
  pAtualizaPainelTotaisVenda;
  pAjustaAlturaPainelPrincipal;

  If blnCndPag Then
  Begin
    strCodCndPag := fCfgSis('CNDSCP');

    If Not fEmptyStr(strCodCndPag) Then
    Begin
      strCndPag    := fRetConPag(strCodCndPag);
      strCodForPag := fRetCodFpg(strCodCndPag);
      strDesForPag := fRetDescFpg(strCodForPag);

      pInformaCndPag;
    End;
  End;

  objGerenciaRodape.pCarregar(True);
  blnSalvar_lblAplicacao := False;

  cxvTotalEmOrdProd.Visible := fCfgSis('EXIORD', varBoolean) And fCfgSis('ORDPRO', varBoolean);

  fraConsultaEstrutura.SALDIS.Visible := fVerificaAcessoSistema('PVISPF');

  pnlEstrutura.Visible := fCfgSis('CPEEST', varBoolean);
  spltGrupoSimilares.Visible := pnlEstrutura.Visible and pnlSimilares.Visible;

  if pnlEstrutura.Visible then
  begin
    if pnlSimilares.Visible then
    begin
      pnlEstrutura.Width := pnlGrupoSimilares.Width div 3;
    end
    else
    begin
      pnlEstrutura.Align := alClient;
    end;
  end;
End;

procedure TfrmPnlDadosItemResumido.pWMMessageAtualizouTotalVenda;
begin
  pAtualizaPainelTotaisVenda;
end;

procedure TfrmPnlDadosItemResumido.pWMMessageNavegandoGridConsulta;
begin
  blnNavegandoGridSimilares := False;
  pAtualizarCorInformacoesItens;
end;

procedure TfrmPnlDadosItemResumido.GarantiadeMercadoria1Click(Sender: TObject);
begin
  If GetDataSetItem.IsEmpty Then
    Exit;
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;
  inherited;
  TCheckListGarantiaController
    .pImprimirCheckListGarantiaMercadoriaItem(GetCampoItem('ITE_CODITE').AsString,'', False);
end;

function TfrmPnlDadosItemResumido.GetCampoItem(ACampo: String): TField;
begin
  Result := GetDataSetItem.FindField(ACampo);

  If Result = nil Then
    Result := GetDataSetItem.FindField('ITE_'+ ACampo);

  If Result = nil Then
  Begin
    If Pos('_', ACampo) > 0 Then
      System.Delete(ACampo, 1, Pos('_', ACampo));
    Result := GetDataSetItem.FindField(ACampo);
  End;
end;

function TfrmPnlDadosItemResumido.GetDataSetItem: TDataSet;
begin
  If (Self.blnAtualizandoInformacaoSubConsulta Or Self.blnFocadoNaSubConsulta) And (Assigned(Self.cdsSubConsulta)) Then
    Result := Self.cdsSubConsulta
  Else If blnNavegandoGridSimilares Or blnExecutandoTABGridSimilares Then
    Result := dtsSimilares.DataSet
  Else
    Result := cdsConsulta;
end;

Function TfrmPnlDadosItemResumido.fValidaCampos(arrCampo: Array Of String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not Assigned(GetCampoItem(arrCampo[intContador])) Then
    Begin
      Result := False;
      Exit;
    End;
End;

function TfrmPnlDadosItemResumido.fExisteSemelhantes(strCodIte: String): Boolean;
Var
  qrySem: TUniQuery;
begin

  Result := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  qrySem := fCriaQuery(Self);

  Try

    With qrySem Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQLCadSemelhantes);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      Result := (Not IsEmpty);
    End;

  Finally
    FreeAndNil(qrySem);
  End;

end;

procedure TfrmPnlDadosItemResumido.pAjustaAlturaTotais(const blnSetaPosVertical: Boolean; const intDefaultPanelWidth : Integer);
  Var
    Result: Integer;
Begin
  Result := 0;

  pnlTotaisLateral.Align := alTop;

  If pnlTotGer.Visible Then
    Result := Result + pnlTotGer.Height;

  If pnlSohIPI.Visible Then
    Result := Result + pnlSohIPI.Height;

  If pnlTotIpi.Visible Then
    Result := Result + pnlTotIpi.Height;

  If pnlSohST.Visible Then
    Result := Result + pnlSohST.Height;

  If pnlSohFCP.Visible Then
    Result := Result + pnlSohFCP.Height;

  If pnlSohCBS.Visible Then
    Result := Result + pnlSohCBS.Height;

  If pnlSohIBS.Visible Then
    Result := Result + pnlSohIBS.Height;

  If pnlSohIS.Visible Then
    Result := Result + pnlSohIS.Height;

  If pnlTotSer.Visible Then
    Result := Result + pnlTotSer.Height;

  If pnlTotImp.Visible Then
    Result := Result + pnlTotImp.Height;

  pnlTotaisLateral.ClientHeight := Result + 5;

  intTotaisLateralHeight := Result + 5;

  If blnSetaPosVertical Then
    pSetPosicaoVertical
  Else
    pSetPosicaoHorizontal(intDefaultPanelWidth - IfThen(pnlSohCBS.Visible, 5, 0));
End;

procedure TfrmPnlDadosItemResumido.pSetPosicaoVertical;
  Var
    intAltura: Integer;
Begin
  intAltura := pnlTotaisLateral.Height;

  pnlTotaisLateral.Align := alClient;

  intAltura := pnlTotaisLateral.Height - intAltura;

  lblTotGer.Top := 9;
  edtTotGer.Top := 5;

  lblSohIPI.Top := 9;
  edtSohIPI.Top := 5;

  lblTotIpi.Top := 9;
  edtTotIpi.Top := 5;

  lblSohST.Top := 9;
  edtSohST.Top := 5;

  lblSohFCP.Top := 9;
  edtSohFCP.Top := 5;

  lblSohCBS.Top := 9;
  edtSohCBS.Top := 5;

  lblSohIBS.Top := 9;
  edtSohIBS.Top := 5;

  lblSohIS.Top := 9;
  edtSohIS.Top := 5;

  lblTotSer.Top := 9;
  edtTotSer.Top := 5;

  lblTotImp.Top := 9;
  edtTotImp.Top := 5;

  If pnlTotGer.Visible Then
    pnlTotaisLateralFlow.Padding.top := intAltura Div 2;
End;

procedure TfrmPnlDadosItemResumido.pSetPosicaoHorizontal(const intDefaultPanelWidth : Integer);
Begin
  pnlTotaisLateralFlow.DisableAlign;
  Try
    SendMessage(pnlTotaisLateralFlow.Handle, WM_SETREDRAW, WPARAM(False), 0);
    Try
      pnlTotaisLateralFlow.Padding.Bottom := 0;
      pnlTotaisLateralFlow.Align := alClient;

      lblTotGer.Top := 5;
      edtTotGer.Top := 1;
      pnlTotGer.Width := intDefaultPanelWidth;

      lblSohIPI.Top := 5;
      edtSohIPI.Top := 1;
      pnlSohIPI.Width := intDefaultPanelWidth;

      lblTotIpi.Top := 5;
      edtTotIpi.Top := 1;
      pnlTotIpi.Width := intDefaultPanelWidth;

      lblSohST.Top := 5;
      edtSohST.Top := 1;
      pnlSohST.Width := intDefaultPanelWidth;

      lblSohFCP.Top := 5;
      edtSohFCP.Top := 1;
      pnlSohFCP.Width := intDefaultPanelWidth;

      lblSohCBS.Top := 5;
      edtSohCBS.Top := 1;
      pnlSohCBS.Width := intDefaultPanelWidth;

      lblSohIBS.Top := 5;
      edtSohIBS.Top := 1;
      pnlSohIBS.Width := intDefaultPanelWidth;

      lblSohIS.Top := 5;
      edtSohIS.Top := 1;
      pnlSohIS.Width := intDefaultPanelWidth;

      lblTotSer.Top := 5;
      edtTotSer.Top := 1;
      pnlTotSer.Width := intDefaultPanelWidth;

      lblTotImp.Top := 5;
      edtTotImp.Top := 1;
      pnlTotImp.Width := intDefaultPanelWidth;
    Finally
      SendMessage(pnlTotaisLateralFlow.Handle, WM_SETREDRAW, WPARAM(True), 0);
    End;
  Finally
    pnlTotaisLateralFlow.EnableAlign;
    RedrawWindow(pnlTotaisLateralFlow.Handle, nil, 0, RDW_ERASE or RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
  End;
End;

procedure TfrmPnlDadosItemResumido.pAtualizaDataSourceSubConsulta;
begin
  dtsSubConsulta.DataSet := Nil;

  If (Self.blnAtualizandoInformacaoSubConsulta) And (Assigned(Self.cdsSubConsulta)) Then
    dtsSubConsulta.DataSet := Self.cdsSubConsulta;

  If (Not fValidaCampos(['ITE_APLICA'])) Then
  Begin
    DBAplica.DataField := EmptyStr;
    DBAplica.DataSource := dtsConsulta;
  End
  Else
  Begin
    DBAplica.DataField := 'ITE_APLICA';
    If (Self.blnAtualizandoInformacaoSubConsulta) And (Assigned(Self.cdsSubConsulta)) Then
      DBAplica.DataSource := dtsSubConsulta
    Else
      DBAplica.DataSource := dtsConsulta;
  End;

  If (Not fValidaCampos(['MSGLIV'])) Then
  Begin
    dbeMSGLIV.DataField := EmptyStr;
    dbeMSGLIV.DataSource := dtsConsulta;
  End
  Else
  Begin
    dbeMSGLIV.DataField := 'MSGLIV';
    If (Self.blnAtualizandoInformacaoSubConsulta) And (Assigned(Self.cdsSubConsulta)) Then
      dbeMSGLIV.DataSource := dtsSubConsulta
    Else
      dbeMSGLIV.DataSource := dtsConsulta;
  End;
end;

end.
