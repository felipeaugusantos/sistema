unit untFatRomaneioLoteSeparacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, StrUtils, Uni,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, untZClient,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, untHelperCitel,
  cxClasses, cxGridLevel, cxGrid, Vcl.Mask, MaskEditFocus, EditFocus, cxProgressBar,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, UniClientDataSet, untSaldoLojas,
  cxDataControllerConditionalFormattingRulesManagerDialog, System.ImageList,
  Vcl.ImgList, cxImageList, cxImageComboBox, untCfgColRomLoteSep, Vcl.DBCtrls, untTLock;

const
  strNomePanelRodape = 'pnlCamposRodape';

type
  TOpcaoSelecao = (opTodos, opParcial, opGravado);

  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);

  TfrmFatRomaneioLoteSeparacao = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtNumLot: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    chbDocumentos: TCheckBox;
    cxgDocumentosLevel: TcxGridLevel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentos: TcxGridCitel;
    cxgDTAENT: TcxGridDBColumn;
    cxgHORENT: TcxGridDBColumn;
    cxgDTENTR: TcxGridDBColumn;
    cxgNUMDOC: TcxGridDBColumn;
    cxgESPDOC: TcxGridDBColumn;
    cxgSERIE_: TcxGridDBColumn;
    cxgCODEMP: TcxGridDBColumn;
    cxgNOMCLI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    cxgSEQUEN: TcxGridDBColumn;
    cxgMARDES: TcxGridDBColumn;
    cxgSEPIMP: TcxGridDBColumn;
    pnlFiltros: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    lbl1: TLabel;
    Label13: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodVen: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    rdbEntrada: TRadioButton;
    rdbEntrega: TRadioButton;
    edtCodTra: TEditFocus;
    edtDesTra: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnDefRota: TBitBtnLocked;
    btnDesmarTodos: TBitBtnLocked;
    btnMarTodos: TBitBtnLocked;
    cxgDESREG: TcxGridDBColumn;
    cxgNOMCID: TcxGridDBColumn;
    cxgBAIENT: TcxGridDBColumn;
    cxgENDENT: TcxGridDBColumn;
    cxgPESBRU: TcxGridDBColumn;
    cxgDESFPG: TcxGridDBColumn;
    cxgNOMTRA: TcxGridDBColumn;
    cxgVLRCON: TcxGridDBColumn;
    cxgCODVEN: TcxGridDBColumn;
    pnlRodape: TPanel;
    btnExcluir: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnObservacoes: TBitBtnLocked;
    pnlObserv: TPanel;
    edtObs2: TEditFocus;
    edtObs1: TEditFocus;
    Label5: TLabel;
    cxgNUMFAT: TcxGridDBColumn;
    cxgCEPENT: TcxGridDBColumn;
    Panel2: TPanel;
    lblMarca: TLabel;
    lblMarcaParc: TLabel;
    imglIconesGrid: TcxImageList;
    rdgDoc: TRadioGroup;
    btnAlterarDataEntrega: TBitBtnLocked;
    imgIndica: TcxImageList;
    cxgAUTINC: TcxGridDBColumn;
    rdgEmpresa: TRadioGroup;
    pnlCamposRodape: TPanel;
    pnlMsgPed: TPanel;
    Label9: TLabel;
    edtMsgPed: TEditFocus;
    pnlMsgExp: TPanel;
    Label10: TLabel;
    edtMsgExp: TEditFocus;
    pnlBotoes2: TPanel;
    btnCfgRomLoteSep: TBitBtnLocked;
    btnVisualizarItensDocumentos: TBitBtnLocked;
    cxgCODCLI: TcxGridDBColumn;
    chbDocumentosFatParcial: TCheckBox;
    shpSalDoc: TShape;
    lblSalDoc: TLabel;
    cxgSALDOC: TcxGridDBColumn;
    Panel1: TPanel;
    Shape3: TShape;
    lblSepImpExpNaoImp: TLabel;
    popProdutos: TPopupMenu;
    mnuProdutosPedidos: TMenuItem;
    N2: TMenuItem;
    mnuProdutosPedidoAtual: TMenuItem;
    btnProdutos: TBitBtnLocked;
    cxgVOLUME: TcxGridDBColumn;
    cxgCATEGO: TcxGridDBColumn;
    cxgREDLOJ: TcxGridDBColumn;
    ckbPedLotSep: TCheckBox;
    btnVisualizarVolume: TBitBtnLocked;
    cxgNOMOPE: TcxGridDBColumn;
    cxgESTADO: TcxGridDBColumn;
    pnlBotoesItens: TPanel;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    pnlLegendaItens: TPanel;
    lblVolTot: TLabel;
    edtVolTot: TEditFocus;
    lblVolSel: TLabel;
    edtVolSel: TEditFocus;
    lblQtdDoc: TLabel;
    edtQtdDoc: TEditFocus;
    lblQtdSel: TLabel;
    edtQtdSel: TEditFocus;
    lbl2: TLabel;
    edtTotPes: TEditFocus;
    Label7: TLabel;
    edtTotVal: TEditFocus;
    lblPesoTot: TLabel;
    edtPesoTot: TEditFocus;
    lblValorTotal: TLabel;
    edtValorTotal: TEditFocus;
    cxgVLRITE: TcxGridDBColumn;
    cxgESTCLI: TcxGridDBColumn;
    lblValorTotalProdutosSel: TLabel;
    lblValorTotalProdutos: TLabel;
    edtValorTotalProdutosSel: TEditFocus;
    edtValorTotalProdutos: TEditFocus;
    cxgTOTFAT: TcxGridDBColumn;
    lblValorTotalFaturado: TLabel;
    edtValorTotalFaturado: TEditFocus;
    lblCodRot: TLabel;
    edtCodRot: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodTraExit(Sender: TObject);
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumLotExit(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgDocumentosTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure chbDocumentosClick(Sender: TObject);
    procedure btnMarTodosClick(Sender: TObject);
    procedure btnDesmarTodosClick(Sender: TObject);
    procedure btnDefRotaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure btnLocProxClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnObservacoesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgDocumentosTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgCEPENTGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarDataEntregaClick(Sender: TObject);
    procedure btnCfgRomLoteSepClick(Sender: TObject);
    procedure cxgTIPOPEGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure btnVisualizarItensDocumentosClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure mnuProdutosPedidosClick(Sender: TObject);
    procedure mnuProdutosPedidoAtualClick(Sender: TObject);
    procedure btnVisualizarVolumeClick(Sender: TObject);
    procedure edtCodRotKeyPress(Sender: TObject; var Key: Char);
  private
    strClaVenLoc: String;
    qryLroObs   : TUniQuery;
    cdsDocume   : TZClient;
    cdsItensSepPar: TUniClientDataSet;

    intUltSeq : Integer;
    strCodTra : String;
    strPlaVei : String;
    strCodMot : String;
    strDesLot : String;
    strDesVei : String;
    strBoxLot : String;

    strFiltroNumDoc : String;
    strFiltroEspDoc : String;

    arrEmpres,
    arrRegiao,
    arrCidade,
    arrTransp,
    arrVended: TConsultasArray;
    arrRotReg: TConsultasArray;

    FcxgFFNCON: TcxGridDBColumn;

    objLock: TLock;

    FstrBaixarROMLIT: String;

    procedure pCriarCdsItensSepParcial;
    procedure pCarregarItensSepParcial(cxProgressBar: TcxProgressBar);

    procedure pMarcarItensSepParcial(strNumDoc,
                                     strEspDoc,
                                     strCodEmp,
                                     strSerie_: String;
                                     Opcao: TOpcaoSelecao); overload;

    procedure pMarcarItensSepParcial(Opcao: TOpcaoSelecao); overload;

    procedure pDesmarcarItensSepParcial(strNumDoc,
                                        strEspDoc,
                                        strCodEmp,
                                        strSerie_: String); overload;

    procedure pDesmarcarItensSepParcial(); overload;

    procedure pGravarItensSepParcial(strNumDoc,
                                     strEspDoc,
                                     strCodEmp,
                                     strSerie_,
                                     strSeqRld: String);

    function fGetSQL : String;
    function fSQLQuantidadeItem(strPrefix: String): String;
    function fSQLQuantidadeJaSeparadaItem(strPrefix, strTabDet: String): String;
    function fSQLQuantidadeBaixadaItem(strPrefix, strTabDet: String): String;

    function fSQLQuantidadeRestanteItem(strPrefix, strTabDet: String): String;
    function fLoteSeparacaoRomaneioExiste(strNumLot : String):Boolean;
    function fUltimaSequencia(strNumLot : String):Integer;
    function fAbreDados(cxProgressBar: TcxProgressBar): Boolean;
    function fGravaDados(cxProgressBar: TcxProgressBar): Boolean;

    function fMarcar(strMarDes: String = 'M'): Boolean;
    procedure pDesmarcar;
    procedure pInverte;
    procedure pIniciaDados;
    procedure fPesoBrutoSelecionado;
    procedure pValidaSituacaoFinanceiraPedido_E_VinculoLoteSeparacao(cxProgressBar: TcxProgressBar);
    procedure pImprimir(strNumLote: String);
    procedure pAfterScrollDoc(DataSet: TDataSet);
    procedure pSetaSQLLroObs;

    procedure pVerificaDocumentosCliente;
    function fAtualizaDataEntregaPedidos(cxProgressBar: TcxProgressBar): Boolean;

    procedure pVerificaFFNaoConfirmada;

    function fGridFiltrado: Boolean;
    procedure pMarcarTodos;
    procedure pMarcarTodosFiltrados;
    procedure pDesmarcarTodos;
    function fVerificaCadLot(strNumDoc, strCodEmp: string): Boolean;
    procedure pDesmarcarTodosFiltrados;
    procedure pGravarConfiguracoesLoteSepRom;
    procedure pVerificaVisibilidadeCampos;
    procedure pIncluirVisibilidade(strNamCom,
                                   strCodEmp,
                                   strDesCom : String;
                                   blnVisivel : Boolean);
    procedure pDimensionarPanelCamposRodape;
    function fGetMensagens: String;
    function fGetMsgPed(strFgoInc : String) : String;
    function fGetMsgExp(strFgoInc : String) : String;
    procedure pCriaColunasGrid;

    function fRetTrava: String;
    function fValidaLotesAbertos: Boolean;
    function fRetInfStatusSaldo(strMarDes: string = 'M'): integer;
    function fRetSaldoDisponivelItemDoc(strCodIte, strCodEmp: string): Double;
    function fAtualizaStatusSaldo(cxProgressBar: TcxProgressBar): Boolean;
    procedure pExibeProdutosPedidosSelecinados (strPedido : String = ''; strEspecieDoc : String = ''; strEmpresa : String = '');
    procedure pVisualizarVolumeItem;
    procedure pPreencheSQLQueryItens(var qryItens: TUniQuery);
    procedure pSomaCamposItens(var fltPesoTot, fltValorTot, fltValorProdutos: Double;
      strNumDoc, strEspDoc, strCodEmp, strSerie_: String);
    function fGerarLockRegistrosMarcados: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; override;
  end;

implementation

uses untFatLotRomTransMot, untGravando, untFatRomaneioLoteSeparacaoRota,
  untRomaneioLoteSeparacaoBusca, untObsGarantia, untFuncoesSimples,
  untQckRomLoteSeparacao, untFuncoesConsulta, untConstantes, untConsultas,
  untFatItensLoteSeparacaoRomaneio, untValidaSituacaoFinanceiraPedido,
  untMensagemExplicativa, untLiberacao, untMsgLiberacao, untFuncoes, untConfDocs,
  System.Generics.Collections, untConfigRomaneioLoteSeparacao, untFuncoesRel,
  Shared.Functions.Faturamento.Impostos.Regras, untRomLge, untLoteReimpressao,
  untFatRomaneioLoteSeparacaoProdutosPedido, untFormGrid;

{$R *.dfm}

{ TfrmFatRomaneioLoteSeparacao }

procedure TfrmFatRomaneioLoteSeparacao.pIniciaDados;
Begin
  edtNumLot.ReadOnly := False;
  edtNumLot.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtCodReg.Clear;
  edtNomReg.Clear;
  edtCodTra.Clear;
  edtDesTra.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtCodEmp.Clear;
  edtNomEmp.Clear;
  edtCodRot.Clear;

  strDesLot := '';
  strBoxLot := '';
  edtTotPes.Text := '0,00';
  edtPesoTot.Text := '0,00';
  edtTotVal.Text := '0,00';
  edtValorTotal.Text := '0,00';
  edtQtdDoc.Text := '0';
  edtQtdSel.Text := '0';
  edtVolTot.Text := '0,000';
  edtVolSel.Text := '0,000';

  edtValorTotalProdutos.Text    := '0,00';
  edtValorTotalProdutosSel.Text := '0,00';

  if cdsDocume.Active Then
    cdsDocume.EmptyDataSet;

  if cdsItensSepPar.Active Then
    cdsItensSepPar.EmptyDataSet;

  edtCodEmp.Text := VS_strCodEmp;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');

  btnAlterarDataEntrega.Visible := fVerificaAcessoSistema('LSRALTDTENT');

  btnCfgRomLoteSep.Visible := fVerificaAcessoSistema('LSRACECONEX');

  lblCodRot.Visible := fCfgSis('REGCID', varBoolean);
  edtCodRot.Visible := lblCodRot.Visible;

  pSetFocus(edtNumLot);

  pCriaColunasGrid;

  TCfgColRomLoteSep.pIniciar(cxgDocumentos, cxgDocumentosTableView);

  pVerificaVisibilidadeCampos;

  objLock.pDestravarTodos;
end;

procedure TfrmFatRomaneioLoteSeparacao.pCriaColunasGrid;
var
  Column: TcxGridDBColumn;
begin
  if fCfgSis('EXITUR', varBoolean) then
  begin
    Column := cxgDocumentosTableView.CreateColumn;
    Column.Caption := 'Turno';
    Column.DataBinding.FieldName := 'TURNO';
    Column.Width := 74;
    Column.Index := cxgNUMDOC.Index;
  end;

  if fCfgSis('EXISTA', varBoolean) then
  begin
    Column := cxgDocumentosTableView.CreateColumn;
    Column.Caption := 'Status';
    Column.DataBinding.FieldName := 'STATUS';
    Column.Index := cxgNUMFAT.Index;
  end;

  if fCfgSis('INFLSR', VarBoolean) then
  begin
    Column := cxgDocumentosTableView.CreateColumn;
    Column.Caption := 'FF não confirmada';
    Column.DataBinding.FieldName := 'FFNCON';
    Column.Width := 100;

    FcxgFFNCON := Column;
  end;

  if fCfgSis('BONPED', varBoolean) then
  begin
    Column := cxgDocumentosTableView.CreateColumn;
    Column.Caption := 'Tipo de Operação';
    Column.DataBinding.FieldName := 'TIPOPE';
    Column.OnGetDataText := cxgTIPOPEGetDataText;
    Column.MinWidth := 100;
  end;

end;

function TfrmFatRomaneioLoteSeparacao.fAbreDados(cxProgressBar : TcxProgressBar):Boolean;
  Var
    strLinCid : String;
    strLinReg : String;
    strLinTra : String;
    strLinVen : String;
    strEmpres : String;
    strLinRot : String;
begin
  inherited;
  pInfoStatusGravacao(cxProgressBar, 'Aguarde, Carregando documentos ...');

  objLock.pDestravarTodos;

  if cdsDocume.Active Then
  Begin
    cdsDocume.AfterScroll := Nil;
    cdsDocume.EmptyDataSet;
  End;

  btnConfirma.Enabled := True;
  btnExcluir.Enabled := True;
  btnAlterarDataEntrega.Enabled := True;
  if not fEmptyStr(edtNumLot.Text) and (fCfgSis('MULSEP', varBoolean)) then
  begin
    if fVerificaCadLot(edtNumLot.Text, edtCodEmp.Text) then
    begin
      btnConfirma.Enabled := False;
      btnExcluir.Enabled := False;
      btnAlterarDataEntrega.Enabled := False;
      fMensagem('ATENÇÃO!', 'Este lote de separação de pedidos para romaneio já teve sua separação impressa e não pode ser alterado.', ['&Ok']);
    end;
  end;

  With cdsDocume.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add( fGetSQL );

    If not fEmptyStr(edtNumLot.Text) then
      ParamByName('NUMLOT').AsString := edtNumLot.Text;

    If FindParam('DOCVEN') <> Nil Then
      ParamByName('DOCVEN').AsString := strClaVenLoc;

    If Not fEmptyDate(mskDtaIni.Text) And chbDocumentos.Checked Then
    Begin
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDateTime := StrToDate(mskDtaFin.Text);
    End;

    If FindParam('ITESER') <> Nil Then
      ParamByName('ITESER').AsString := fCfgSis('ITESER');

    If FindParam('SERTER') <> Nil Then
      ParamByName('SERTER').AsString := fCfgSis('SERTER');

    pSetaParam(edtCodCid.Text,arrCidade,strLinCid,'CODCID', cdsDocume.qryQuery);
    pSetaParam(edtCodReg.Text,arrRegiao,strLinReg,'CODREG', cdsDocume.qryQuery);
    pSetaParam(edtCodTra.Text,arrTransp,strLinTra,'CODTRA', cdsDocume.qryQuery);
    pSetaParam(edtCodVen.Text,arrVended,strLinVen,'CODVEN', cdsDocume.qryQuery);
    pSetaParam(edtCodRot.Text,arrRotReg,strLinRot,'CODROT', cdsDocume.qryQuery);

    If not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text,arrEmpres,strEmpres,'CODEMP', cdsDocume.qryQuery);
  End;

  If fEmptyStr(edtNumLot.Text)  And
     fEmptyDate(mskDtaIni.Text) And
     fEmptyDate(edtCodCid.Text) And
     fEmptyDate(edtCodReg.Text) And
     fEmptyDate(edtCodTra.Text) And
     fEmptyDate(edtCodVen.Text) And
     fEmptyDate(edtCodEmp.Text) Then
  Begin
    Result := fMensagem('', 'Não foi informado nenhum filtro, essa operação sem filtros pode demorar, tem certeza que deseja continuar?', ['&Sim', 'Não'], 2) = 1;
    If not Result Then
      Exit;
  End;

  Result := cdsDocume.fAbreClient(True, 'TfrmFatRomaneioLoteSeparacao.btnFiltrarClick');

  if Result and (not fGerarLockRegistrosMarcados) then
  begin
    Result := False;
    pIniciaDados;
    Exit;
  end;

  TFloatField(cdsDocume.FieldByName('PESBRU')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocume.FieldByName('VLRCON')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocume.FieldByName('VLRITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsDocume.FieldByName('VOLUME')).DisplayFormat := '#,##0.000';
  TFloatField(cdsDocume.FieldByName('TOTFAT')).DisplayFormat := '#,##0.00';
  //cxgDocumentosTableView.ApplyBestFit();
  TCfgColRomLoteSep.pCarregarDadosSalvos(cxgDocumentosTableView);
  intUltSeq := fUltimaSequencia(edtNumLot.Text);

  pValidaSituacaoFinanceiraPedido_E_VinculoLoteSeparacao(cxProgressBar);

  pCarregarItensSepParcial(cxProgressBar);

  pInfoStatusGravacao(cxProgressBar, 'Aguarde, Calculando peso total ...');
  fPesoBrutoSelecionado;

  If fCfgSis('INFLSR', VarBoolean) Then
  begin
    pInfoStatusGravacao(cxProgressBar, 'Aguarde, Verificando FF não confirmada ...');
    pVerificaFFNaoConfirmada;
  end;

  cdsDocume.AfterScroll := pAfterScrollDoc;
  pAfterScrollDoc(cdsDocume);

  edtNumLot.ReadOnly := True;

end;

function TfrmFatRomaneioLoteSeparacao.fAtualizaDataEntregaPedidos(
  cxProgressBar: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
  dtaDtaEntrega: TDateTime;
  qryUpdate: TUniQuery;
begin
  Result := False;
  Try
    pDisableControls(cdsDocume, prcScroll);
    cdsDocume.Filter := 'SEQUEN > 0';
    cdsDocume.Filtered := True;
    cdsDocume.IndexFieldNames := 'SEQUEN';

    If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Begin
      fMensagem('', 'Nenhum registro selecionado!', ['&OK']);
      Exit;
    End;

    dtaDtaEntrega := VS_Date;
    if not ffrmDataNovo(dtaDtaEntrega, 'Data de Entrega', 'Nova data de entrega') then
      Exit;

    pInfoStatusGravacao(cxProgressBar, 'Aguarde, alterando a data de entrega dos pedidos ...', cdsDocume.RecordCount);

    qryUpdate := fCriaQuery;
    try

      try
        fStartTransaction;

        cdsDocume.First;
        While not cdsDocume.eof do
        Begin
          pStepStatusGravacao(cxProgressBar);

          if (cdsDocume.FieldByName('TABELA').AsString = 'FATGOR') then
          begin
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('UPDATE FATGOR SET');
            qryUpdate.SQL.Add('FGO_DTENTR = :DTENTR');
            qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC;');
            qryUpdate.SQL.Add('');
            qryUpdate.SQL.Add('UPDATE EXTDOR, FATDOR');
            qryUpdate.SQL.Add('  SET FDO_DTENTR = :DTENTR');
            qryUpdate.SQL.Add('WHERE EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM');
            qryUpdate.SQL.Add('  AND FATDOR.FDO_SEQGER = :AUTINC');
            qryUpdate.SQL.Add('  AND FDO_ENTRET = "E"');
            qryUpdate.SQL.Add('  AND FDO_DTENTR IS NOT NULL;');
          end
          else
          if (cdsDocume.FieldByName('TABELA').AsString = 'MOVDET') then
          begin
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('UPDATE MOVGER SET');
            qryUpdate.SQL.Add('GER_DTENTR = :DTENTR');
            qryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTINC');
          end;

          qryUpdate.ParamByName('DTENTR').AsDateTime := dtaDtaEntrega;
          qryUpdate.ParamByName('AUTINC').AsString   := cdsDocume.FieldByName('AUTINC').AsString;
          qryUpdate.ExecSQL;

          cdsDocume.Edit;
          cdsDocume.FieldByName('DTENTR').AsDateTime := dtaDtaEntrega;
          cdsDocume.Post;

          cdsDocume.Next;
        End;

        fCommit;
        Result := True;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TfrmFatRomaneioLoteSeparacao.btnAlterarDataEntregaClick');
        End;
      End;
    finally
      FreeAndNil(qryUpdate);
    end;

  Finally
    cdsDocume.Filtered := False;
    cdsDocume.Filter   := '';
    cdsDocume.IndexFieldNames := 'SEQUEN';
    if cdsDocume.Active then
      cdsDocume.First;
    pEnableControls(cdsDocume, prcScroll);
    pAfterScrollDoc(cdsDocume);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnAlterarDataEntregaClick(
  Sender: TObject);
begin
  inherited;
  if not btnAlterarDataEntrega.Visible then
    Exit;

  fChamaTelaGravando(fAtualizaDataEntregaPedidos);
end;

procedure TfrmFatRomaneioLoteSeparacao.btnCancelarClick(Sender: TObject);
begin
  inherited;
  pIniciaDados;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnCfgRomLoteSepClick(Sender: TObject);
var
  frmConfigRomaneioLoteSeparacao : TfrmConfigRomaneioLoteSeparacao;
begin
  inherited;
  If (btnCfgRomLoteSep.Visible) Then
  Begin
    pCriarFormularios(TfrmConfigRomaneioLoteSeparacao, frmConfigRomaneioLoteSeparacao);
    Try
      frmConfigRomaneioLoteSeparacao.dtsLotSep := cxgDocumentosTableView.DataController.DataSource.DataSet;
      frmConfigRomaneioLoteSeparacao.ShowModal;
      If (frmConfigRomaneioLoteSeparacao.blnConfirma) Then
      begin
        TFrmGravando.fExecutarModal( pGravarConfiguracoesLoteSepRom, 'Aguarde... Gravando Configurações!', '');
        pVerificaVisibilidadeCampos;
      end;
    Finally
      pFreeAndNil(frmConfigRomaneioLoteSeparacao);
    End;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnConfirmaClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
begin
  if (not btnConfirma.Enabled) then
    Exit;

  inherited;
  Try
    pDisableControls(cdsDocume, prcScroll);
    cdsDocume.Filter := 'SEQUEN > 0';
    cdsDocume.Filtered := True;
    cdsDocume.IndexFieldNames := 'SEQUEN';

    If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Begin
      fMensagem('', 'Não existe registro para gravar!', ['&OK']);
      Exit;
    End;

    if not fValidaLotesAbertos then
      Exit;
  Finally
    cdsDocume.Filtered := False;
    cdsDocume.Filter   := '';
    cdsDocume.IndexFieldNames := 'SEQUEN';
    cdsDocume.First;
    pEnableControls(cdsDocume, prcScroll);
    pAfterScrollDoc(cdsDocume);
  End;

  Try
    pCriarFormularios(TfrmFatLotRomTransMot, frmFatLotRomTransMot);
    frmFatLotRomTransMot.edtCodTra.Text := strCodTra;
    frmFatLotRomTransMot.mskPlaVei.Text := strPlaVei;
    frmFatLotRomTransMot.edtCodMot.Text := strCodMot;
    frmFatLotRomTransMot.edtDesLot.Text := strDesLot;
    frmFatLotRomTransMot.edtBoxLot.Text := strBoxLot;
    frmFatLotRomTransMot.ShowModal;

    If frmFatLotRomTransMot.ModalResult = mrOk Then
    Begin
      strCodTra := frmFatLotRomTransMot.edtCodTra.Text;
      strPlaVei := frmFatLotRomTransMot.mskPlaVei.Text;
      strCodMot := frmFatLotRomTransMot.edtCodMot.Text;
      strDesLot := frmFatLotRomTransMot.edtDesLot.Text;
      strDesVei := frmFatLotRomTransMot.edtDesVei.Text;
      strBoxLot := frmFatLotRomTransMot.edtBoxLot.Text;

      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fGravaDados;
        frmGravando.ShowModal;
      Finally
        FreeAndNil(frmGravando);
      End;

    End;

  Finally
    FreeAndNil(frmFatLotRomTransMot);
  End;

end;

procedure TfrmFatRomaneioLoteSeparacao.btnDefRotaClick(Sender: TObject);
var
  intContadorAtualiza: integer;
begin
  inherited;
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  Try
    pCriarFormularios(TfrmFatRomaneioLoteSeparacaoRota, frmFatRomaneioLoteSeparacaoRota);
    With frmFatRomaneioLoteSeparacaoRota Do
    Begin
      cdsRotas.CloneCursor(cdsDocume, False, True);
      TFloatField(cdsRotas.FieldByName('PESBRU')).DisplayFormat := '#,##0.00';
      cdsRotas.Filter := 'SEQUEN > 0';
      cdsRotas.Filtered := True;
      cdsRotas.IndexFieldNames := 'SEQUEN';

      cdsRotas.First;
      While Not cdsRotas.Eof Do
      Begin
        cdsRotas.Edit;
        cdsRotas.FieldByName('SEQUEN').AsInteger := cdsRotas.RecNo;
        cdsRotas.FieldByName('SEQORD').AsInteger := cdsRotas.RecNo;
        cdsRotas.Post;
        cdsRotas.Next;
      End;
      intUltSeq := cdsRotas.RecordCount;
      cdsRotas.First;

      TCfgColRomLoteSep.pCarregarDadosSalvos(cxgDocumentosTableView);
    End;

    frmFatRomaneioLoteSeparacaoRota.ShowModal;

    frmFatRomaneioLoteSeparacaoRota.cdsRotas.First;
    for intContadorAtualiza := 0 to frmFatRomaneioLoteSeparacaoRota.cdsRotas.recordcount -1 do
    begin
      if cdsDocume.locate('NOMCLI;NUMDOC;ESPDOC;CODEMP',
         VarArrayOf([frmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('NOMCLI').AsString,
                     frmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('NUMDOC').AsString,
                     frmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('ESPDOC').AsString,
                     frmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('CODEMP').AsString]),[]) then
      begin
        cdsDocume.edit;
        cdsDocume.FieldByName('SEQUEN').AsInteger := frmFatRomaneioLoteSeparacaoRota.cdsRotas.FieldByName('SEQUEN').AsInteger;
        cdsDocume.post;
      end;
     frmFatRomaneioLoteSeparacaoRota.cdsRotas.next;
    end;
     cdsDocume.IndexFieldNames := 'SEQUEN';

  Finally
    FreeAndNil(frmFatRomaneioLoteSeparacaoRota);
  End;

end;

procedure TfrmFatRomaneioLoteSeparacao.pDesmarcarTodosFiltrados;
var
  intContador: Integer;
  RecNo: Integer;
  strAutInc: String;
begin
  for intContador := 0 to cxgDocumentosTableView.DataController.FilteredRecordCount - 1 do
  begin
    RecNo := cxgDocumentosTableView.DataController.FilteredRecordIndex[intContador];
    strAutInc := cxgDocumentosTableView.DataController.Values[RecNo, cxgAUTINC.INDEX];
    if cdsDocume.Locate('AUTINC', strAutInc, []) then
    begin
      pDesmarcar;
      pDesmarcarItensSepParcial;
    end;
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pDesmarcarTodos;
begin
  cdsDocume.First;
  While Not cdsDocume.Eof Do
  Begin
    pDesmarcar;
    pDesmarcarItensSepParcial;
    cdsDocume.
    Next;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnDesmarTodosClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
begin
  inherited;
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  With cdsDocume Do
  Begin
    Try
      pDisableControls(cdsDocume, prcScroll);
      cxgDocumentosTableView.BeginUpdate;

      if fGridFiltrado then
        pDesmarcarTodosFiltrados
      else
        pDesmarcarTodos;

      fPesoBrutoSelecionado;

    Finally
      First;
      pEnableControls(cdsDocume, prcScroll);
      cxgDocumentosTableView.EndUpdate;
      pAfterScrollDoc(cdsDocume);
    End;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnExcluirClick(Sender: TObject);
Begin
  If (not fEmptyStr(edtNumLot.Text)) And
     (fMensagem('', 'Deseja excluir o lote de separação ?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    if fExcluirLoteSeparacao(edtNumLot.Text, VS_strCodEmp) then
      pIniciaDados;
  End;
end;

function TfrmFatRomaneioLoteSeparacao.fGravaDados(cxProgressBar : TcxProgressBar) : Boolean;
  Var
    qryDados : TUniQuery;
    strCodLot: String;
    strAutInc: String;
    intSeq   : Integer;
    prcScroll: TprcScroll;
Begin
  Result := True;
  Try
    Try
      fStartTransaction;

      qryDados := fCriaQuery(Self);
      With qryDados, SQL Do
      Begin
        Close;
        Clear;

        If not fEmptyStr(edtNumLot.Text) Then
          fExcluirLoteSeparacao(edtNumLot.Text, VS_strCodEmp);

        if not FEmptyStr(FstrBaixarROMLIT) then
        begin
          Add(' UPDATE ROMLIT SET ');
          Add(' RLI_QTDSEP = RLI_QTDBAI,');
          Add(' RLI_JAFATU = 1');
          Add(' WHERE AUTOINCREM IN (' + FstrBaixarROMLIT + ')');
          ExecSQL;

          Close;
          Clear;
        end;

        Add(' INSERT INTO ROMLGE(AUTOINCREM, RLG_NUMLOT, RLG_DESLOT, RLG_CODTRA, RLG_PLAVEI, RLG_CODMOT, RLG_CODEMP, RLG_DTACAD, RLG_DESVEI, RLG_BOXLOT) ');
        Add(' VALUES (:AUTINC, :NUMLOT, :DESLOT, :CODTRA, :PLAVEI, :CODMOT, :CODEMP, :DTACAD, :DESVEI, :BOXLOT) ');

        strAutInc := fRetAutoIncrem('ROMLGE', VS_strCodEmp);

        If fEmptyStr(edtNumLot.Text) Then
          ParamByName('NUMLOT').AsString := fAtualizaProCod('ROMLGE', 'RLG_NUMLOT')
        Else
          ParamByName('NUMLOT').AsString := edtNumLot.Text;

        ParamByName('AUTINC').AsString := strAutInc;
        ParamByName('CODTRA').AsString := strCodTra;
        ParamByName('PLAVEI').AsString := strPlaVei;
        ParamByName('CODMOT').AsString := strCodMot;
        ParamByName('DESLOT').AsString := strDesLot;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('DTACAD').AsDate   := Date;
        ParamByName('DESVEI').AsString := strDesVei;

        if fEmptyStr(ParamByName('CODTRA').AsString) Then ParamByName('CODTRA').Clear;
        if fEmptyStr(ParamByName('PLAVEI').AsString) Then ParamByName('PLAVEI').Clear;
        if fEmptyStr(ParamByName('CODMOT').AsString) Then ParamByName('CODMOT').Clear;

        if not fEmptyStr(strBoxLot) then
          ParamByName('BOXLOT').AsString := strBoxLot
        else
          ParamByName('BOXLOT').Clear;

        strCodLot := ParamByName('NUMLOT').AsString;

        ExecSQL;

        Close;
        Clear;
        Add(' INSERT INTO ROMLDE(AUTOINCREM, RLD_SEQRLG, RLD_NUMDOC, RLD_ESPDOC, RLD_SERIE_, RLD_CODEMP, RLD_SEQUEN, RLD_QTDPAR) ');
        Add(' VALUES (:AUTINC, :SEQRLG, :NUMDOC, :ESPDOC, :SERIE_, :CODEMP, :SEQUEN, :QTDPAR)');

      End;

      With cdsDocume Do
      Begin
        Try
          pDisableControls(cdsDocume, prcScroll);
          Filter := 'SEQUEN > 0';
          Filtered := True;
          IndexFieldNames := 'SEQUEN';
          First;

          cxProgressBar.pSetMax(RecordCount);

          qryDados.ParamByName('SEQRLG').AsString := strAutInc;

          intSeq := 0;
          While Not Eof Do
          Begin
            Inc(intSeq);
            qryDados.ParamByName('AUTINC').AsString := fRetAutoIncrem('ROMLDE', VS_strCodEmp);
            qryDados.ParamByName('NUMDOC').AsString := FieldByName('NUMDOC').AsString;
            qryDados.ParamByName('ESPDOC').AsString := FieldByName('ESPDOC').AsString;
            qryDados.ParamByName('SERIE_').AsString := FieldByName('SERIE_').AsString;
            qryDados.ParamByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
            qryDados.ParamByName('SEQUEN').AsString := IntToStr(intSeq);
            qryDados.ParamByName('QTDPAR').AsString := IIF(FieldByName('MARDES').AsString = 'P', 'S', 'N');
            qryDados.ExecSQL;

            pGravarItensSepParcial(qryDados.ParamByName('NUMDOC').AsString,
                                   qryDados.ParamByName('ESPDOC').AsString,
                                   qryDados.ParamByName('CODEMP').AsString,
                                   qryDados.ParamByName('SERIE_').AsString,
                                   qryDados.ParamByName('AUTINC').AsString);
            Next;

            cxProgressBar.pStep;

            Application.ProcessMessages;
          End;

        Finally
          Filtered := False;
          Filter   := '';
          IndexFieldNames := 'SEQUEN';
          First;
          pEnableControls(cdsDocume, prcScroll);
          pAfterScrollDoc(cdsDocume);
        End;
      End;

      fCommit;
      pImprimir(strCodLot);
      pIniciaDados;
    Finally
      FreeAndNil(qryDados);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, 'TfrmFatRomaneioLoteSeparacao.fGravaDados');
    End;
  End;

End;

procedure TfrmFatRomaneioLoteSeparacao.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  If (not chbDocumentos.Checked) And fEmptyStr(edtNumLot.Text) Then
  Begin
    fMensagem('', 'Para não incluir os documento sem lote de separação é preciso informar um número de lote válido!', ['&OK']);
    pSetFocus(edtNumLot);
    Exit;
  End;

  if not fVerificaCampos Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAbreDados;
    frmGravando.ShowModal;
    If frmGravando.blnConfirma Then
    Begin
      pSetFocus(cxgDocumentos);
      fChamaTelaGravando(fAtualizaStatusSaldo);
    End
    Else
      SelectFirst;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnImprimirClick(Sender: TObject);
var
  frmLoteReimpressao: TfrmLoteReimpressao;
begin
  inherited;

  pCriarFormularios(TfrmLoteReimpressao, frmLoteReimpressao);

  try
    If frmLoteReimpressao.ShowModal = mrOk Then
      pImprimir(frmLoteReimpressao.edtNumLot.Text);
  finally
    pFreeAndNil(frmLoteReimpressao);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pImprimir(strNumLote: String);
begin
  If fMensagem('', 'Selecione o modelo desejado', ['&Separação', '&Conferência'], 1) = 1 Then
    pImprimeRomaneioLoteSeparacao(modSeparacao,   strNumLote, VS_strCodEmp)
  Else
    pImprimeRomaneioLoteSeparacao(modConferencia, strNumLote, VS_strCodEmp);
end;

procedure TfrmFatRomaneioLoteSeparacao.btnIniBusClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
    blnWasEnabled: Boolean;
    frmRomaneioLoteSeparacaoBusca: TfrmRomaneioLoteSeparacaoBusca;
begin
  inherited;
  If (Not cdsDocume.Active) Or
     (cdsDocume.IsEmpty)    Then
  Begin
    Exit;
  End;

  Try

    pCriarFormularios(TfrmRomaneioLoteSeparacaoBusca, frmRomaneioLoteSeparacaoBusca);

    frmRomaneioLoteSeparacaoBusca.ShowModal;
    strFiltroNumDoc := frmRomaneioLoteSeparacaoBusca.strFiltroNumDoc;
    strFiltroEspDoc := frmRomaneioLoteSeparacaoBusca.strFiltroEspDoc;

    if frmRomaneioLoteSeparacaoBusca.blnConfirma then
    begin
      pSetFocus(cxgDocumentos);

      blnWasEnabled := Not cdsDocume.ControlsDisabled;

      If blnWasEnabled Then
        pDisableControls(cdsDocume, prcScroll);

      if not cdsDocume.locate('NUMDOC;ESPDOC',VarArrayOf([strFiltroNumDoc,strFiltroEspDoc]),[]) Then
        fMensagem('ATENÇÃO!', 'O Documento não foi localizado!', ['&Ok']);

      If blnWasEnabled Then
      begin
        pEnableControls(cdsDocume, prcScroll);
        pAfterScrollDoc(cdsDocume);
    end;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatRomaneioLoteSeparacao - Inicia Busca]');
    End;
  End;

  pFreeAndNil(frmRomaneioLoteSeparacaoBusca);

  pSetFocus(cxgDocumentos);
end;

procedure TfrmFatRomaneioLoteSeparacao.btnLocProxClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
    blnWasEnabled: Boolean;
begin
  inherited;
  If (cdsDocume.Active) Then
  Begin
    blnWasEnabled := Not cdsDocume.ControlsDisabled;

    If blnWasEnabled Then
      pDisableControls(cdsDocume, prcScroll);

    cdsDocume.FindNext;

    If blnWasEnabled Then
    begin
      pEnableControls(cdsDocume, prcScroll);
      pAfterScrollDoc(cdsDocume);
    end;

    pSetFocus(cxgDocumentos);
  End;
end;

function TfrmFatRomaneioLoteSeparacao.fGridFiltrado: Boolean;
begin
  Result := True;

  if (cxgDocumentosTableView.DataController.FilteredRecordCount = 0) then
    Exit(False);

  if (cxgDocumentosTableView.DataController.FilteredRecordCount = cxgDocumentosTableView.DataController.RecordCount) then
    Exit(False);
end;

procedure TfrmFatRomaneioLoteSeparacao.pMarcarTodos;
begin
  cdsDocume.First;
  While Not cdsDocume.Eof Do
  Begin
    if fMarcar then
      pMarcarItensSepParcial(opTodos);

    cdsDocume.Next;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pMarcarTodosFiltrados;
var
  intContador: Integer;
  RecNo: Integer;
  strAutInc: String;
begin
  for intContador := 0 to cxgDocumentosTableView.DataController.FilteredRecordCount - 1 do
  begin
    RecNo := cxgDocumentosTableView.DataController.FilteredRecordIndex[intContador];
    strAutInc := cxgDocumentosTableView.DataController.Values[RecNo, cxgAUTINC.INDEX];
    if cdsDocume.Locate('AUTINC', strAutInc, []) then
    begin
      if fMarcar then
        pMarcarItensSepParcial(opTodos);
    end;
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnMarTodosClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;

begin
  inherited;
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  With cdsDocume Do
  Begin
    Try
      pDisableControls(cdsDocume, prcScroll);
      cxgDocumentosTableView.BeginUpdate;

      if fGridFiltrado then
        pMarcarTodosFiltrados
      else
        pMarcarTodos;

    Finally
      First;
      pEnableControls(cdsDocume, prcScroll);
      cxgDocumentosTableView.EndUpdate;
      pAfterScrollDoc(cdsDocume);
    End;
  End;
  fPesoBrutoSelecionado;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnObservacoesClick(Sender: TObject);
begin
  inherited;

  If (Not cdsDocume.Active) Or
     (cdsDocume.IsEmpty) Or
     (Not qryLroObs.Active) Then
  Begin
    fMensagem('', 'Registro não encontrado para alteração da observação!', ['&OK']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmObsGarantia, frmObsGarantia);
    frmObsGarantia.edtObs1.Text := qryLroObs.FieldByName('OBS_OBSER1').AsString;
    frmObsGarantia.edtObs2.Text := qryLroObs.FieldByName('OBS_OBSER2').AsString;
    frmObsGarantia.pnlNomeForm.Caption := '';
    frmObsGarantia.ShowModal;

    If (frmObsGarantia.ModalResult = mrOk) Then
    Begin
      If (qryLroObs.IsEmpty) Then
      Begin
        qryLroObs.Insert;
        qryLroObs.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LROOBS', VS_strCodEmp);
        qryLroObs.FieldByName('OBS_NUMDOC').AsString := cdsDocume.FieldByName('NUMDOC').AsString;
        qryLroObs.FieldByName('OBS_ESPDOC').AsString := cdsDocume.FieldByName('ESPDOC').AsString;
        qryLroObs.FieldByName('OBS_CODEMP').AsString := cdsDocume.FieldByName('CODEMP').AsString;
        qryLroObs.FieldByName('OBS_CODCLI').AsString := cdsDocume.FieldByName('CODCLI').AsString;
        If (Not cdsDocume.FieldByName('SERIE_').IsNull) Then
          qryLroObs.FieldByName('OBS_SERIE_').AsString := cdsDocume.FieldByName('SERIE_').AsString;
      End
      Else
        qryLroObs.Edit;

      qryLroObs.FieldByName('OBS_OBSER1').AsString := frmObsGarantia.edtObs1.Text;
      qryLroObs.FieldByName('OBS_OBSER2').AsString := frmObsGarantia.edtObs2.Text;
      qryLroObs.Post;

      pAfterScrollDoc(cdsDocume);
    End;
  Finally
    pFreeAndNil(frmObsGarantia);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.btnProdutosClick(Sender: TObject);
begin
  inherited;
  popProdutos.Popup(TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)).X, TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)).Y);
end;

procedure TfrmFatRomaneioLoteSeparacao.btnVisualizarItensDocumentosClick(
  Sender: TObject);
begin
  inherited;

  If (cdsDocume.Active) and (Not cdsDocume.IsEmpty) Then
  begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(215, 7674, [],
                          ['RELDOC'],
                          ['"'+(cdsDocume.FieldByName('NUMDOC').AsString +'-'+ cdsDocume.FieldByName('ESPDOC').AsString +'-'+ cdsDocume.FieldByName('CODEMP').AsString)+ '"'],
                          Sender,
                          ['RELDOC'],
                          False);
    End;
  end;

end;

procedure TfrmFatRomaneioLoteSeparacao.btnVisualizarVolumeClick(
  Sender: TObject);
begin
  inherited;
  pVisualizarVolumeItem;
end;

procedure TfrmFatRomaneioLoteSeparacao.chbDocumentosClick(Sender: TObject);
begin
  inherited;
  pnlFiltros.Enabled := chbDocumentos.Checked;
end;

procedure TfrmFatRomaneioLoteSeparacao.cxgCEPENTGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If (Not fEmptyStr(AText)) Then
    AText := Copy(AText, 1, 5) + '-' + Copy(AText, 6, 3);
end;

procedure TfrmFatRomaneioLoteSeparacao.cxgDocumentosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  Painter: TcxPainterAccess;
  Rect: TRect;
begin
  inherited;
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgSEQUEN.Index] > 0) Then
  Begin
    ACanvas.Brush.Color := $00B9B900;
  End;

  If not fEmptyStr(VarToStr (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgNUMFAT.Index])) Then
  Begin
    ACanvas.Font.Color := clPurple
  End;

  if Assigned(FcxgFFNCON) and (AViewInfo.Item.Index = FcxgFFNCON.Index) then
  begin
    Painter := TcxPainterAccess(TcxViewInfoAcess(AViewInfo).GetPainterClass.Create(ACanvas, AViewInfo));
    try
      Painter.DrawBorders;
      Rect := AViewInfo.ClientBounds;

      if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, FcxgFFNCON.Index]) = 'S' then
        imgIndica.Draw(ACanvas.Canvas, Rect.Left + ((Rect.Width - 16) div 2), Rect.Top + ((Rect.Height - 16) div 2), 0 );

      ADone := True;
    finally
      FreeAndNil(Painter);
    end;

  end;

end;

procedure TfrmFatRomaneioLoteSeparacao.cxgDocumentosTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnObservacoes.Click;
    VK_SPACE: Begin
                if not fCfgSis('ROMLPA', VarBoolean) then
                begin
                  fMensagem('ATENÇÃO!', 'Não é possível marca o documento parcialmente pois a configuração CFG_ROMLPA está desativada!', ['&Ok']);
                  Exit;
                end;
                pMarcarItensSepParcial(opParcial);
                fPesoBrutoSelecionado;
              End;
    VK_Return: pInverte;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.cxgTIPOPEGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  if cxgDocumentosTableView.DataController.Values[ARecordIndex, cxgESPDOC.Index] = 'PD' then
    AText := TFunctionsRegrasImpostosFaturamento.RetornarTipoOperacaoPedidoVenda(AText)
  else
    AText := '';
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtNomCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da Cidade');
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade, False) Then
  Begin
    If fValidaCampos(edtCodCid, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, False, False) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtNomReg, arrRegiao, Nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, arrRegiao, False) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodRotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEntregasRotasRegiao(Self, edtCodRot, Nil, Nil, Key, arrRotReg, False, '', '', False) Then
  Begin
    If fValidaCampos(edtCodRot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodTraExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodTra,edtDesTra,arrTransp,fRetNomTransportadora,nil,'da Transportadora');
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtDesTra, nil, Key, arrTransp, False) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVended, fRetNomeOperador, Nil, 'do Vendedor');
end;

procedure TfrmFatRomaneioLoteSeparacao.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVended, False) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.edtNumLotExit(Sender: TObject);
begin
  inherited;
  chbDocumentos.Enabled := Not fEmptyStr(edtNumLot.Text);

  if chbDocumentosFatParcial.Visible then
  begin
    chbDocumentosFatParcial.Enabled  := fEmptyStr(edtNumLot.Text);
    chbDocumentosFatParcial.checked  := fEmptyStr(edtNumLot.Text);
  end;

  If (chbDocumentos.Enabled) Then
    pSetFocus(chbDocumentos)
  Else If rdbEntrada.Checked Then
    pSetFocus(rdbEntrada)
  Else
    pSetFocus(rdbEntrega);
end;

procedure TfrmFatRomaneioLoteSeparacao.edtNumLotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryConsulta: TUniQuery;
    arrSel   : TConsultasArray;
begin
  inherited;

  If (edtNumLot.ReadOnly) Then
    Exit;

  qryConsulta := fCriaQuery(Self);

  If fPesqRomaneioLoteSeparacao(Self, edtNumLot, qryConsulta, Key, arrSel, True ) Then
  Begin
    If (fValidaCampos(edtNumLot, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

  FreeAndNil(qryConsulta);

end;

function TfrmFatRomaneioLoteSeparacao.fSQLQuantidadeItem(strPrefix: String): String;
begin
  Result := '';
  Result := Result + ' ( ';

  If strPrefix = 'FDO' Then
    Result := Result + ' FDO_QTDITE '
  Else
    Result := Result + ' DET_QTDITE ';

  Result := Result + ' ) ';
end;

function TfrmFatRomaneioLoteSeparacao.fSQLQuantidadeJaSeparadaItem(strPrefix, strTabDet: String): String;
begin
  Result := ' IFNULL(( ' +
            '   SELECT  ' +
            '     SUM(A.RLI_QTDSEP) ' +
            '   FROM ROMLIT A ' +
            '     INNER JOIN ROMLDE B ON B.AUTOINCREM = A.RLI_SEQRLD ' +
            '     INNER JOIN ROMLGE C ON C.AUTOINCREM = B.RLD_SEQRLG ' +
            '   WHERE C.RLG_NUMLOT <> ' + String(edtNumLot.Text).QuotedString() +
            '     AND A.RLI_SEQ' + strPrefix + ' = ' + strTabDet + '.AUTOINCREM ' +
            ' ), 0) ';
end;

function TfrmFatRomaneioLoteSeparacao.fSQLQuantidadeBaixadaItem(strPrefix, strTabDet: String): String;
begin
  Result := ' IFNULL(( ' +
            '   SELECT  ' +
            '     SUM(A.RLI_QTDBAI) ' +
            '   FROM ROMLIT A ' +
            '     INNER JOIN ROMLDE B ON B.AUTOINCREM = A.RLI_SEQRLD ' +
            '     INNER JOIN ROMLGE C ON C.AUTOINCREM = B.RLD_SEQRLG ' +
            '   WHERE C.RLG_NUMLOT <> ' + String(edtNumLot.Text).QuotedString() +
            '     AND A.RLI_SEQ' + strPrefix + ' = ' + strTabDet + '.AUTOINCREM ' +
            ' ), 0) ';
end;

function TfrmFatRomaneioLoteSeparacao.fSQLQuantidadeRestanteItem(strPrefix, strTabDet: String): String;
begin
  Result := ' ( ' + fSQLQuantidadeItem(strPrefix) + ' - ' + fSQLQuantidadeBaixadaItem(strPrefix, strTabDet) + ' ) ';
end;

function TfrmFatRomaneioLoteSeparacao.fGerarLockRegistrosMarcados: Boolean;
begin
  Result := True;

  cdsDocume.First;

  while not cdsDocume.Eof do
  begin
    if (cdsDocume.FieldByName('MARDES').AsString = 'M') then
    begin
      if (not objLock.fLock_Unlock(fRetTrava, True, False)) then
      begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock(fRetTrava)  + '!', ['&Ok']);
        Exit(False);
      end;
    end;

    cdsDocume.Next;
  end;

  cdsDocume.First;
end;

function TfrmFatRomaneioLoteSeparacao.fGetSQL: String;

  function fRetEhSQLParcial: String;
  begin
    Result := ' (SELECT IF((SUM(Y.FDO_QTDBAI)>0) AND (SUM(Y.FDO_QTDBAI)<SUM(Y.FDO_QTDITE)),"*","") FROM FATDOR Y WHERE Y.FDO_SEQGER = G.AUTOINCREM) ';
  end;

  function fRetPesoProporcional: String;
  begin
    Result := ' (SELECT SUM( ROUND( (Y.FDO_TOTPES / Y.FDO_QTDITE) * IF( (Y.FDO_QTDBAI > 0) AND (Y.FDO_QTDBAI < Y.FDO_QTDITE), (Y.FDO_QTDITE - Y.FDO_QTDBAI), Y.FDO_QTDITE), 2 )) '+
              '    FROM FATDOR Y WHERE Y.FDO_SEQGER = G.AUTOINCREM AND Y.FDO_JAFATU = 0) ';
  end;

  function fFatGor(blnComSeq : Boolean = True) : String;
  Begin
    Result := '';

    Result := Result + ' SELECT "FATGOR" AS TABELA,     ';
    Result := Result + '        G.AUTOINCREM AS AUTINC, ';
    Result := Result + '        FGO_DTAENT AS DTAENT,   ';
    Result := Result + '        FGO_HORENT AS HORENT,   ';
    Result := Result + '        FGO_DTENTR AS DTENTR,   ';
    Result := Result + '        FGO_NUMDOC AS NUMDOC,   ';
    Result := Result + '        FGO_ESPDOC AS ESPDOC,   ';
    Result := Result + '        FGO_SERIE_ AS SERIE_,   ';
    Result := Result + '        FGO_CODEMP AS CODEMP,   ';
    Result := Result + '        FGO_CODCLI AS CODCLI,   ';
    Result := Result + '        FGO_VOLUME AS VOLUME,   ';
    Result := Result + '        IF('+fRetEhSQLParcial+' = "*" ,'+fRetPesoProporcional+',FGO_PESBRU) AS PESBRU,   ';
    Result := Result + '        FGO_CODFPG AS CODFPG,   ';
    Result := Result + '        FGO_CODTRA AS CODTRA,   ';
    Result := Result + '        FGO_VLRCON AS VLRCON,   ';
    Result := Result + '        FGO_CODVEN AS CODVEN,   ';
    Result := Result + '        OPE_NOMOPE AS NOMOPE,   ';
    Result := Result + '        C.CID_ESTADO AS UFVEND,   ';
    Result := Result + '        M.CID_ESTADO AS UFCLIE,   ';
    Result := Result + '        G.FGO_TOTPRO - G.FGO_DESESP AS VLRITE,   ';
    Result := Result + '        ETC_CIDENT AS CIDENT,   ';
    Result := Result + '        ETC_ENDENT AS ENDENT,   ';
    Result := Result + '        ETC_BAIENT AS BAIENT,   ';
    Result := Result + '        CLI_CATEGO AS CATEGO,   ';
    Result := Result + '        CONCAT(RED_CODRED,"-",RED_DESRED) AS REDLOJ,   ';
    Result := Result + '        0          AS SALDOC,   ';
    Result := Result + '        IF(AUX_ENTGER IS NULL, CLI_CODREG, ETC_CODREG) AS CODREG, ';
    Result := Result + '        STA_DESCRI AS STATUS,   ';
    Result := Result + '        CAST((SELECT GROUP_CONCAT(DISTINCT CONCAT(X.DET_NUMDOC,"-",X.DET_ESPDOC)) FROM MOVDET X WHERE X.DET_NUM_PD = FGO_NUMDOC AND X.DET_ESP_PD = FGO_ESPDOC AND X.DET_EMP_PD = FGO_CODEMP) AS CHAR(255)) AS NUMFAT, ';
    Result := Result + '   (SELECT ';
    Result := Result + '      SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0)) ';
    Result := Result + '    FROM ';
    Result := Result + '      CADREC ';
    Result := Result + '    WHERE ';
    Result := Result + '      CTR_NUMDUP = FGO_NUMDOC AND ';
    Result := Result + '      CTR_ESPDOC = FGO_ESPDOC AND ';
    Result := Result + '      CTR_CODEMP = FGO_CODEMP AND ';
    Result := Result + '      CTR_CODCLI = FGO_CODCLI AND ';
    Result := Result + '      CTR_DTAREC IS NOT NULL) AS VALREC, ';

    Result := Result + '   (SELECT ';
    Result := Result + '      SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ';
    Result := Result + '    FROM ';
    Result := Result + '      ADTCLI ';
    Result := Result + '    WHERE ';
    Result := Result + '      ADT_NUMDOC = FGO_NUMDOC AND ';
    Result := Result + '      ADT_ESPDOC = FGO_ESPDOC AND ';
    Result := Result + '      ADT_CODEMP = FGO_CODEMP AND ';
    Result := Result + '      ADT_CODCLI = FGO_CODCLI) AS VALADT, ';

    Result := Result + '   (SELECT ';
    Result := Result + '     SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ', ';
    Result := Result + '              ROUND( (FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ') - ';
    Result := Result + '              IFNULL( ( SELECT SUM(DET_VLRCON) ';
    Result := Result + '                        FROM   MOVDET ';
    Result := Result + '                        WHERE  DET_NUM_PD = FDO_NUMDOC ';
    Result := Result + '                        AND    DET_ESP_PD = FDO_ESPDOC ';
    Result := Result + '                        AND    DET_EMP_PD = FDO_CODEMP ';
    Result := Result + '                        AND    DET_CODITE = FDO_CODITE ';
    Result := Result + '                        AND    DET_IND_PD = FDO_SEQIND ';
    Result := Result + '                        AND    (SELECT COUNT(BRI_SEQDET) FROM BRIDET WHERE BRI_SEQDET = MOVDET.AUTOINCREM) = 0), 0), 2 ) ) ) ';
    Result := Result + '    FROM FATDOR ';
    Result := Result + '    LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
    Result := Result + '    WHERE FDO_NUMDOC = FGO_NUMDOC ';
    Result := Result + '      AND FDO_ESPDOC = FGO_ESPDOC ';
    Result := Result + '      AND FDO_CODEMP = FGO_CODEMP ';
    Result := Result + '      AND FDO_CODCLI = FGO_CODCLI) AS CONORI, ';

    Result := Result + '      FGO_TIPOPE AS TIPOPE, ';

    If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) And
       (Not fCfgSis('NPLF11', VarBoolean)) And (Not fCfgSis('LOCRET', VarBoolean)) Then
      Result := Result + '  "N" AS ORIF11,'
    Else
    Begin
      Result := Result + ' (SELECT ';
      Result := Result + '    IF(COUNT(*) > 0, "S", "N") ';
      Result := Result + '  FROM ';
      Result := Result + '    FATDOR AS PEDORI ';
      Result := Result + '  WHERE ';
      Result := Result + '    PEDORI.FDO_NUMFAT = G.FGO_NUMDOC AND ';
      Result := Result + '    PEDORI.FDO_TIPFAT = G.FGO_ESPDOC AND ';
      Result := Result + '    PEDORI.FDO_EMPFAT = G.FGO_CODEMP) AS ORIF11, ';
    End;

    Result := Result + '  (SELECT ';
    Result := Result + '     GROUP_CONCAT(FPN_CODFPG) ';
    Result := Result + '   FROM ';
    Result := Result + '     FPGNEG ';
    Result := Result + '   WHERE ';
    Result := Result + '     FPGNEG.FPN_SEQFGO = G.AUTOINCREM) AS FPGNEG, ';
    Result := Result + '  FGO_CONPAG AS CONPAG, ';

    Result := Result + '  EXTGOR.FGO_BOLADT AS BOLADT, ';
    Result := Result + '  EXTGOR.FGO_BOLVEN AS BOLVEN, ';

    Result := Result + ' IF(IFNULL(EXTDOR.FDO_INCFUT, "N") = "N","N","S") AS BENFUT, ';

    if chbDocumentosFatParcial.checked Then
    begin
      Result := Result + '-1  AS SEQUEN, ';
      Result := Result + '"D" AS MARDES, ';
      Result := Result + '"N" AS SEPIMP, ';
    end
    else
    begin
      Result := Result + IfThen( blnComSeq , 'RLD_SEQUEN AS SEQUEN', '-1 AS SEQUEN') + ', ';
      Result := Result + IfThen( blnComSeq , 'IF(RLD_QTDPAR = "S", "P", "M") AS MARDES', '"D" AS MARDES') + ', ';
      Result := Result + IfThen( blnComSeq , 'RLD_SEPIMP AS SEPIMP', '"N" AS SEPIMP') + ', ';
    end;

    Result := Result + ' EXTDOR.FDO_TURENT AS TURNO, ';
    Result := Result + ' ETC_CEPENT AS CEPENT, ';
    Result := Result + ' (SELECT                                         ';
    Result := Result + '   SUM(D.DET_VLRCON) AS VLTOT                    ';
    Result := Result + '  FROM                                           ';
    Result := Result + '    MOVDET D                                     ';
    Result := Result + '  WHERE D.DET_NUM_PD = G.FGO_NUMDOC              ';
    Result := Result + '    AND D.DET_ESP_PD = G.FGO_ESPDOC              ';
    Result := Result + '    AND D.DET_EMP_PD = G.FGO_CODEMP) AS TOTFAT   ';
    Result := Result + ' FROM FATGOR G              ';
    Result := Result + '   LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = G.AUTOINCREM ';
    Result := Result + '   LEFT JOIN FATDOR ON FATDOR.FDO_SEQGER = G.AUTOINCREM AND FATDOR.FDO_ORDPRO IS NULL ';
    Result := Result + '   LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
    Result := Result + '   LEFT JOIN AUXGOR ON AUX_SEQGER = G.AUTOINCREM ';
    Result := Result + '   LEFT JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
    Result := Result + '   LEFT JOIN CADOPE ON FGO_CODVEN = OPE_CODOPE ';
    Result := Result + '   LEFT JOIN CADCID C ON OPE_CODCID = C.CID_CODCID ';
    Result := Result + '   LEFT JOIN CADCID M ON CLI_CODCID = M.CID_CODCID ';
    Result := Result + '   LEFT JOIN CADRED ON CLI_CODRED = RED_CODRED ';
    Result := Result + '   LEFT JOIN ENTCLI ON ETC_CODCLI = FGO_CODCLI AND      ';
    Result := Result + '         IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER, ';
    Result := Result + '         ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = FGO_CODCLI)) ';
    Result := Result + '   LEFT JOIN FGOSTA S ON FGO_STATUS = S.STA_CODIGO  ';
  End;

  function fMovDet(blnComSeq : Boolean = True) : String;
  Begin
    Result := '';

    Result := Result + ' SELECT "MOVDET" AS TABELA,     ';
    Result := Result + '        G.AUTOINCREM AS AUTINC, ';
    Result := Result + '        GER_DTAENT AS DTAENT,   ';
    Result := Result + '        GER_HORENT AS HORENT,   ';
    Result := Result + '        GER_DTENTR AS DTENTR,   ';
    Result := Result + '        GER_NUMDOC AS NUMDOC,   ';
    Result := Result + '        GER_ESPDOC AS ESPDOC,   ';
    Result := Result + '        GER_SERIE_ AS SERIE_,   ';
    Result := Result + '        GER_CODEMP AS CODEMP,   ';
    Result := Result + '        GER_CODCLI AS CODCLI,   ';
    Result := Result + '        GER_VOLUME AS VOLUME,   ';
    Result := Result + '        GER_PESBRU AS PESBRU,   ';
    Result := Result + '        GER_CODFPG AS CODFPG,   ';
    Result := Result + '        GER_CODTRA AS CODTRA,   ';
    Result := Result + '        GER_VLRCON AS VLRCON,   ';
    Result := Result + '        GER_CODVEN AS CODVEN,   ';
    Result := Result + '        OPE_NOMOPE AS NOMOPE,   ';
    Result := Result + '        C.CID_ESTADO AS UFVEND,   ';
    Result := Result + '        M.CID_ESTADO AS UFCLIE,   ';
    Result := Result + '        0.00       AS VLRITE,   ';
    Result := Result + '        ETC_CIDENT AS CIDENT,   ';
    Result := Result + '        ETC_ENDENT AS ENDENT,   ';
    Result := Result + '        ETC_BAIENT AS BAIENT,   ';
    Result := Result + '        CLI_CATEGO AS CATEGO,   ';
    Result := Result + '        CONCAT(RED_CODRED,"-",RED_DESRED) AS REDLOJ,   ';
    Result := Result + '        0          AS SALDOC,   ';
    Result := Result + '        ETC_CODREG AS CODREG,   ';
    Result := Result + '        " "        AS STATUS,   ';
    Result := Result + '        " "        AS NUMFAT,   ';
    Result := Result + '        0.00       AS VALREC,   ';
    Result := Result + '        0.00       AS VALADT,   ';
    Result := Result + '        GER_VLRCON AS CONORI,   ';
    Result := Result + '        " "        AS TIPOPE,   ';
    Result := Result + '        "N"        AS ORIF11,   ';
    Result := Result + '        " "        AS FPGNEG,   ';
    Result := Result + '        GER_CONPAG AS CONPAG,   ';
    Result := Result + '        0.00       AS BOLADT,   ';
    Result := Result + '        "N"        AS BOLVEN,   ';
    Result := Result + '        "N"        AS BENFUT,   ';

    if chbDocumentosFatParcial.checked Then
    begin
      Result := Result + '-1  AS SEQUEN, ';
      Result := Result + '"D" AS MARDES, ';
      Result := Result + '"N" AS SEPIMP, ';
    end
    else
    begin
      Result := Result + IfThen( blnComSeq , 'RLD_SEQUEN AS SEQUEN', '-1 AS SEQUEN') + ', ';
      Result := Result + IfThen( blnComSeq , 'IF(RLD_QTDPAR = "S", "P", "M") AS MARDES', '"D" AS MARDES') + ', ';
      Result := Result + IfThen( blnComSeq , 'RLD_SEPIMP AS SEPIMP', '"N" AS SEPIMP') + ', ';
    end;

    Result := Result + ' MOVTRI.DET_TURENT AS TURNO, ';
    Result := Result + ' ETC_CEPENT AS CEPENT, ';
    Result := Result + ' G.GER_VLRCON AS TOTFAT   ';
    Result := Result + ' FROM MOVGER G ';
    Result := Result + '   LEFT JOIN MOVDET ON MOVDET.DET_SEQGER = G.AUTOINCREM';
    Result := Result + '   LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    Result := Result + '   LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = G.AUTOINCREM ';
    Result := Result + '   LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
    Result := Result + '   LEFT JOIN CADOPE ON GER_CODVEN = OPE_CODOPE ';
    Result := Result + '   LEFT JOIN CADCID C ON OPE_CODCID = C.CID_CODCID ';
    Result := Result + '   LEFT JOIN CADCID M ON CLI_CODCID = M.CID_CODCID ';
    Result := Result + '   LEFT JOIN CADRED ON CLI_CODRED = RED_CODRED ';
    Result := Result + '   LEFT JOIN ENTCLI ON ETC_CODCLI = GER_CODCLI AND      ';
    Result := Result + '         IF(IFNULL(AUX_ENTGER,"") <> "", ENTCLI.AUTOINCREM = AUX_ENTGER, ';
    Result := Result + '         ETC_SEQIND = (SELECT MIN(ETC_SEQIND) FROM ENTCLI WHERE ETC_CODCLI = GER_CODCLI)) ';
  End;

  function fFiltrosDocumento(strPrefix : String) : String;
  Begin
    Result := '';
    If Not fEmptyDate(mskDtaIni.Text) Then
      Result := Result + ' AND ' + IfThen(rdbEntrada.Checked, strPrefix + '_DTAENT', strPrefix + '_DTENTR') + ' BETWEEN :DTAINI AND :DTAFIN ';

    Result := Result + fStrLocate(edtCodCid,arrCidade, 'ETC_CIDENT', 'CODCID');
    Result := Result + fStrLocate(edtCodReg,arrRegiao, 'ETC_CODREG', 'CODREG');
    Result := Result + fStrLocate(edtCodTra,arrTransp, strPrefix + '_CODTRA', 'CODTRA');
    Result := Result + fStrLocate(edtCodVen,arrVended, strPrefix + '_CODVEN', 'CODVEN');

    if (strPrefix = 'FGO') and ((rdgEmpresa.ItemIndex) = 1) then
      Result := Result + fStrLocate(edtCodEmp,arrEmpres, strPrefix + '_EMPEXP', 'CODEMP')
    else
      Result := Result + fStrLocate(edtCodEmp,arrEmpres, strPrefix + '_CODEMP', 'CODEMP');
  End;

  function fFiltroQuantidadePendente(strPrefix, strTabDet: String): String;
  begin
    Result := ' AND ((' +
      '(' + fSQLQuantidadeJaSeparadaItem(strPrefix, strTabDet) + ' = 0) OR (' +
      fSQLQuantidadeItem(strPrefix) + ' - ' + fSQLQuantidadeBaixadaItem(strPrefix, strTabDet) + ')) > 0) ';
  end;

begin
  Result := '';
  Result := Result + ' SELECT DISTINCT  ';
  Result := Result + '        TABELA,   ';
  Result := Result + '        AUTINC,   ';
  Result := Result + '        DTAENT,   ';
  Result := Result + '        HORENT,   ';
  Result := Result + '        DTENTR,   ';
  Result := Result + '        NUMDOC,   ';
  Result := Result + '        ESPDOC,   ';
  Result := Result + '        SERIE_,   ';
  Result := Result + '        CODEMP,   ';
  Result := Result + '        CODCLI,   ';
  Result := Result + '        VOLUME,   ';
  Result := Result + '        PESBRU,   ';
  Result := Result + '        CODFPG,   ';
  Result := Result + '        CODTRA,   ';
  Result := Result + '        VLRCON,   ';
  Result := Result + '        CODVEN,   ';
  Result := Result + '        NOMOPE,   ';
  Result := Result + '        UFVEND,   ';
  Result := Result + '        UFCLIE,   ';
  Result := Result + '        VLRITE,   ';
  Result := Result + '        CIDENT,   ';
  Result := Result + '        ENDENT,   ';
  Result := Result + '        BAIENT,   ';
  Result := Result + '        CATEGO,   ';
  Result := Result + '        REDLOJ,   ';
  Result := Result + '        SALDOC,   ';
  Result := Result + '        CODREG,   ';
  Result := Result + '        STATUS,   ';
  Result := Result + '        SEQUEN,   ';
  Result := Result + '        MARDES,   ';
  Result := Result + '        SEPIMP,   ';
  Result := Result + '        SEQUEN AS SEQORD,   ';
  Result := Result + '        IF(SEQUEN > 0, 0, 1) AS SEQINI, ';
  Result := Result + '        CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        FPG_DESCRI AS DESFPG, ';
  Result := Result + '        REG_DESREG AS DESREG, ';
  Result := Result + '        TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '        VLRCON,               ';
  Result := Result + '        VALREC,               ';
  Result := Result + '        VALADT,               ';
  Result := Result + '        CONORI,               ';
  Result := Result + '        TIPOPE,               ';
  Result := Result + '        ORIF11,               ';
  Result := Result + '        FPGNEG,               ';
  Result := Result + '        CONPAG,               ';
  Result := Result + '        BOLADT,               ';
  Result := Result + '        BOLVEN,               ';
  Result := Result + '        BENFUT,               ';
  Result := Result + '        TURNO,                ';
  Result := Result + '        CEPENT,               ';
  Result := Result + '        NUMFAT,               ';
  Result := Result + ' "X" AS FFNCON,               ';
  Result := Result + '        TOTFAT                ';
  Result := Result + ' FROM ( ';

  //Carregando o que já esta gravado
  If Not fEmptyStr(edtNumLot.Text) or chbDocumentosFatParcial.checked Then
  Begin
    Result := Result + fFatGor;
    Result := Result + ' INNER JOIN ROMLDE ON RLD_NUMDOC = FGO_NUMDOC        ';
    Result := Result + '                  AND RLD_ESPDOC = FGO_ESPDOC        ';
    Result := Result + '                  AND RLD_SERIE_ = COALESCE(FGO_SERIE_, "") ';
    Result := Result + '                  AND RLD_CODEMP = FGO_CODEMP        ';
    Result := Result + ' INNER JOIN ROMLGE ON ROMLGE.AUTOINCREM = RLD_SEQRLG ';

    Result := Result + ' WHERE TRUE ';

    If Not fEmptyStr(edtNumLot.Text)   Then
      Result := Result + ' AND RLG_NUMLOT = :NUMLOT                          '
    Else
    begin
      If Not fEmptyDate(mskDtaIni.Text) Then
        Result := Result + '  AND FGO_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
      Result := Result + '  AND FGO_JAFATU = 0  ';
      Result := Result + '  AND EXTDOR.FDO_ENTRET <> "R" ';
      Result := Result + '   AND NOT (LOCATE(IFNULL(FGO_STATUS,0), "' +  fCfgSis('STALSR', varString) + '"))';
    end;
    If not fEmptyStr(edtCodEmp.Text) Then
      Result := Result + '   AND RLG_CODEMP = :CODEMP                          ';

    If fCfgSis('OPROML') <> '1' Then
    Begin
      Result := Result + ' UNION ALL ';
      Result := Result + fMovDet;
      Result := Result + ' INNER JOIN ROMLDE ON RLD_NUMDOC = GER_NUMDOC        ';
      Result := Result + '                  AND RLD_ESPDOC = GER_ESPDOC        ';
      Result := Result + '                  AND RLD_SERIE_ = GER_SERIE_        ';
      Result := Result + '                  AND RLD_CODEMP = GER_CODEMP        ';
      Result := Result + ' INNER JOIN ROMLGE ON ROMLGE.AUTOINCREM = RLD_SEQRLG ';
      Result := Result + ' WHERE RLG_NUMLOT = :NUMLOT                          ';
      Result := Result + '   AND DET_TIP_FC = "C"                              ';

      If not fEmptyStr(edtCodEmp.Text) Then
        Result := Result + '   AND RLG_CODEMP = :CODEMP                          ';
    End;

    If chbDocumentos.Checked Then
      Result := Result + ' UNION ALL ';
  End;

  //Carregando documentos fora do lote
  If chbDocumentos.Checked Then
  Begin
    Result := Result + fFatGor(False);

    If Not fCfgSis('ROMLPA', VarBoolean) Then
    Begin
      Result := Result + '  LEFT JOIN ROMLDE ON RLD_NUMDOC = FGO_NUMDOC  ';
      Result := Result + '                  AND RLD_ESPDOC = FGO_ESPDOC  ';
      Result := Result + '                  AND RLD_SERIE_ = COALESCE(FGO_SERIE_, "") ';
      Result := Result + '                  AND RLD_CODEMP = FGO_CODEMP  ';
    End;

    If (fCfgSis('OPROSE', varString) = '1') Then
    Begin
      Result := Result + '  LEFT JOIN ROMDELX ON DEL_NUMDOC = FGO_NUMDOC ';
      Result := Result + '                   AND DEL_ESPDOC = FGO_ESPDOC ';
      Result := Result + '                   AND DEL_CODEMP = FGO_CODEMP ';

      Result := Result + ' WHERE ROMDELX.DEL_NUMDOC IS NULL   ';
    End
    Else
    Begin
      Result := Result + ' WHERE FATDOR.FDO_CLAFIS >= 5000 ';
    End;

    Result := Result + '   AND IFNULL(FGO_NUMROM, "") = ""  ';
    Result := Result + '   AND IFNULL(FGO_ENTFUT,"N") = "N" ';
    Result := Result + '   AND IFNULL(FGO_LIBERA, 0) > 0    ';
    Result := Result + '   AND IFNULL(FGO_LIBCOM, 0) > 0    ';
    Result := Result + '   AND FGO_ENTFAT = "S"             ';
    Result := Result + '   AND FGO_JAFATU = 0               ';
    Result := Result + '   AND IFNULL(FGO_LOC_PD, "N") <> "S"';

    If (fCfgSis('REGCID', varBoolean)) And (Not fEmptyStr(edtCodRot.Text)) Then
      Result := Result + fStrLocate(edtCodRot, arrRotReg, 'EXTGOR.FGO_CODROT','CODROT');

    If Not fCfgSis('ROMLPA', VarBoolean) Then
      Result := Result + '   AND RLD_NUMDOC IS NULL         ';

    Result := Result + '   AND FATDOR.FDO_CODITE <> :ITESER ';
    Result := Result + '   AND FATDOR.FDO_CODITE <> :SERTER ';

    Result := Result + '   AND NOT (LOCATE(IFNULL(FGO_STATUS,0), "' +  fCfgSis('STALSR', varString) + '"))';

    Result := Result + '   AND FGO_ESPDOC = "PD"            ';
    Result := Result + '   AND EXTDOR.FDO_ENTRET <> "R"     ';

    If rdgDoc.ItemIndex = 0 Then
    begin
      Result := Result + '   AND ((LOCATE(FATDOR.FDO_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0 AND FGO_VLRCON > 0) OR LOCATE(FATDOR.FDO_CLAFIS,' + CLAFIS_BR + '))';
      Result := Result + '   AND FGO_CODCLI NOT IN ('  + fRetClientesFilial + ') ';
    end
    Else If rdgDoc.ItemIndex = 1 Then
    Begin
      Result := Result + ' AND FGO_CODCLI IN ('  + fRetClientesFilial + ') ';
    End
    Else
    Begin
      Result := Result + ' AND ((LOCATE(FATDOR.FDO_CLAFIS,'+ QuotedStr(strClaVenLoc) + ') > 0 AND FGO_VLRCON > 0) OR LOCATE(FATDOR.FDO_CLAFIS, ' + CLAFIS_BR + ') ';
      Result := Result + ' OR FGO_CODCLI IN ('  + fRetClientesFilial + ')) ';
    End;

    Result := Result + fFiltrosDocumento('FGO');

    If fCfgSis('ROMLPA', VarBoolean) Then
      Result := Result + fFiltroQuantidadePendente('FDO','FATDOR');

    If fCfgSis('OPROML') <> '1' Then
    Begin
      Result := Result + ' UNION ALL ';
      Result := Result + fMovDet(False);

      If Not fCfgSis('ROMLPA', VarBoolean) Then
      Begin
        Result := Result + '   LEFT JOIN ROMLDE ON RLD_NUMDOC = GER_NUMDOC ';
        Result := Result + '                   AND RLD_ESPDOC = GER_ESPDOC ';
        Result := Result + '                   AND RLD_SERIE_ = GER_SERIE_ ';
        Result := Result + '                   AND RLD_CODEMP = GER_CODEMP ';
      End;

      If (fCfgSis('OPROSE', varString) = '1') Then
      Begin
        Result := Result + ' INNER JOIN ROMDELX ON DEL_NUMDOC = GER_NUMDOC ';
        Result := Result + '                   AND DEL_ESPDOC = GER_ESPDOC ';
        Result := Result + '                   AND DEL_CODEMP = GER_CODEMP ';
      End;

      Result := Result + ' WHERE TRUE                                    ';
      Result := Result + '   AND DET_TIP_FC = "C"                        ';

      If Not fCfgSis('ROMLPA', VarBoolean) Then
        Result := Result + '   AND RLD_NUMDOC IS NULL                    ';

      Result := Result + '   AND MOVDET.DET_CODITE <> :ITESER        ';
      Result := Result + '   AND MOVDET.DET_CODITE <> :SERTER        ';

      Result := Result + '   AND IFNULL(GER_NUMROM, "") = ""             ';

      If (fCfgSis('OPROSE', varString) = '2') Then
      Begin
        If rdgDoc.ItemIndex = 0 Then
        Begin
          Result := Result + ' AND MOVDET.DET_CLAFIS >= 5000 ';
          Result := Result + ' AND (LOCATE(MOVDET.DET_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0)';
          Result := Result + ' AND GER_CODCLI NOT IN ('  + fRetClientesFilial + ') ';
        End
        Else If rdgDoc.ItemIndex = 1 Then
        Begin
          Result := Result + ' AND MOVDET.DET_CLAFIS >= 5000 ';
          Result := Result + ' AND GER_CODCLI IN ('  + fRetClientesFilial + ') ';
        End
        Else
        Begin
          Result := Result + ' AND ((MOVDET.DET_CLAFIS >= 5000 ';
          Result := Result + ' AND (LOCATE(MOVDET.DET_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0))';
          Result := Result + ' OR GER_CODCLI IN ('  + fRetClientesFilial + ')) ';
        End;
      End;

      Result := Result + fFiltrosDocumento('GER');

      If fCfgSis('ROMLPA', VarBoolean) Then
        Result := Result + fFiltroQuantidadePendente('DET','MOVDET');
    End;
  End;

  Result := Result + ' ) AS DOCUMENTOS ';
  Result := Result + ' LEFT JOIN CADCID ON CID_CODCID = CIDENT ';
  Result := Result + ' LEFT JOIN CADREG ON REG_CODREG = CODREG ';
  Result := Result + ' LEFT JOIN CADCLI ON CLI_CODCLI = CODCLI ';
  Result := Result + ' LEFT JOIN CADFPG ON FPG_CODIGO = CODFPG ';
  Result := Result + ' LEFT JOIN CADTRA ON TRA_CODTRA = CODTRA ';
  Result := Result + ' GROUP BY CONCAT(TABELA, AUTINC)         ';
  Result := Result + ' ORDER BY SEQINI, SEQORD, NUMDOC         ';
end;

function TfrmFatRomaneioLoteSeparacao.fLoteSeparacaoRomaneioExiste( strNumLot: String): Boolean;
  Var
    qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery(Self);
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT RLG_CODTRA,         ');
      Add('        RLG_PLAVEI,         ');
      Add('        RLG_CODMOT,         ');
      Add('        RLG_DESLOT,         ');
      Add('        RLG_DESVEI,         ');
      Add('        RLG_BOXLOT          ');
      Add(' FROM ROMLGE                ');
      Add(' WHERE RLG_NUMLOT = :NUMLOT ');
      Add('   AND RLG_CODEMP = :CODEMP ');

      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := not IsEmpty;

      If Result Then
      Begin
        strCodTra := FieldByName('RLG_CODTRA').AsString;
        strPlaVei := FieldByName('RLG_PLAVEI').AsString;
        strCodMot := FieldByName('RLG_CODMOT').AsString;
        strDesLot := FieldByName('RLG_DESLOT').AsString;
        strDesVei := FieldByName('RLG_DESVEI').AsString;
        strBoxLot := FieldByName('RLG_BOXLOT').AsString;
      End
      Else
      Begin
        strCodTra := '';
        strPlaVei := '';
        strCodMot := '';
        strDesLot := '';
        strDesVei := '';
        strBoxLot := '';
      End;

      Close;

    End;

  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (cdsDocume.Active) And (not cdsDocume.IsEmpty) Then
  Begin
    Action := caNone;

    If fMensagem('', 'Deseja cancelar?', ['&Sim', '&Não'], 2) = 1 Then
      pIniciaDados;

    Exit;
  End;

  If Assigned(cdsItensSepPar) then
    FreeAndNil(cdsItensSepPar);

  objLock.pDestravarTodos;
end;

procedure TfrmFatRomaneioLoteSeparacao.FormCreate(Sender: TObject);
begin
  inherited;
  strClaVenLoc := (VS_strClaVen + AnsiReplaceStr(CLAFIS_ENTFUT_VEN, '"', ''));
  intUltSeq := 0;
  strCodTra := '';
  strPlaVei := '';
  strCodMot := '';
  strDesLot := '';
  strDesVei := '';
  strBoxLot := '';
  FstrBaixarROMLIT := '';

  cdsDocume := TZClient.Create(Self);
  cxgDocumentosTableView.DataController.DataSource := cdsDocume.dtsSource;

  qryLroObs := fCriaQuery(Self);
  pSetaSQLLroObs;

  lblMarcaParc.Visible := fCfgSis('ROMLPA', VarBoolean);
  chbDocumentosFatParcial.Visible := fCfgSis('ROMLPA', VarBoolean);
  if not chbDocumentosFatParcial.Visible then
    chbDocumentosFatParcial.Checked := False;

  pCriarCdsItensSepParcial;

  objLock := TLock.Create;
end;

procedure TfrmFatRomaneioLoteSeparacao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryLroObs);
  FreeAndNil(objLock);
  inherited;
end;

procedure TfrmFatRomaneioLoteSeparacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) Then
    btnIniBus.Click
  Else
  If (Key = VK_F4) Then
    btnLocProx.Click
  Else
  If (Key = VK_F5) Then
    btnExcluir.Click
  Else
  If (Key = VK_F6) Then
    btnImprimir.Click
  Else
  If Key = VK_F10 Then
    btnConfirma.Click
  Else
  If Key = VK_F7 Then
    btnMarTodos.Click
  Else
  If Key = VK_F8 Then
    btnDesmarTodos.Click
  Else
  If Key = VK_F9 Then
    btnDefRota.Click
  Else
  If Key = VK_F11 Then
    btnAlterarDataEntrega.Click
  Else
  If Key = VK_F12 Then
    btnVisualizarItensDocumentos.Click;

end;

procedure TfrmFatRomaneioLoteSeparacao.FormShow(Sender: TObject);
begin
  inherited;
  pIniciaDados;
end;

function TfrmFatRomaneioLoteSeparacao.fUltimaSequencia(strNumLot: String): Integer;
  Var
    qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery(Self);
    With qryDados, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT MAX(RLD_SEQUEN) AS SEQUEN                    ');
      Add(' FROM ROMLGE                                         ');
      Add(' INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM ');
      Add(' WHERE RLG_NUMLOT = :NUMLOT ');
      Add('   AND RLG_CODEMP = :CODEMP ');

      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      Result := FieldByName('SEQUEN').AsInteger;

      Close;

    End;

  Finally
    FreeAndNil(qryDados);
  End;

end;

function TfrmFatRomaneioLoteSeparacao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNumLot) Then
  Begin

    If (Not fEmptyStr(edtNumLot.Text)) Then
    Begin

      If (Not fLoteSeparacaoRomaneioExiste(edtNumLot.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse lote de separação para romaneio não está cadastrado!', ['&Ok']);
        Result := False;
      End;

    End;

  End

  Else If (Sender = mskDtaIni) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      mskDtaFin.Enabled := False
    Else
      mskDtaFin.Enabled := True;

  End

  Else If (Sender = mskDtaFin) Then
  Begin

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
        Begin
          fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
          Result := False;
        End;
      End;
    End;

  End

  Else If Sender = edtCodEmp Then
    pDesmarcaLista(edtCodEmp, arrEmpres)

  Else If (Sender = edtCodTra) Then
    pDesmarcaLista(edtCodTra, arrTransp);

  If (Not Result) Then
    pSetFocus(Sender);
end;


function TfrmFatRomaneioLoteSeparacao.fVerificaCadLot(strNumDoc,
  strCodEmp: string): Boolean;
var
  qryLotDor: TUniQuery;
begin
  qryLotDor := fCriaQuery;

  try
    qryLotDor.Close;
    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Add('SELECT L.* ');
    qryLotDor.SQL.Add('FROM FATGOR F');
    qryLotDor.SQL.Add('INNER JOIN EXTGOR E');
    qryLotDor.SQL.Add('ON(F.AUTOINCREM = E.FGO_SEQFGO)');
    qryLotDor.SQL.Add('INNER JOIN FATDOR D');
    qryLotDor.SQL.Add('ON(F.AUTOINCREM = D.FDO_SEQGER)');
    qryLotDor.SQL.Add('INNER JOIN EXTDOR ED');
    qryLotDor.SQL.Add('ON(D.AUTOINCREM = ED.FDO_SEQFDO)');
    qryLotDor.SQL.Add('INNER JOIN LOTDOR L');
    qryLotDor.SQL.Add('ON(D.AUTOINCREM = L.LDO_SEQFDO)');
    qryLotDor.SQL.Add('INNER JOIN ROMLDE RL');
    qryLotDor.SQL.Add('ON(D.FDO_NUMDOC = RL.RLD_NUMDOC AND D.FDO_ESPDOC = RL.RLD_ESPDOC AND D.FDO_CODEMP = RL.RLD_CODEMP)');
    qryLotDor.SQL.Add('INNER JOIN ROMLGE G');
    qryLotDor.SQL.Add('ON(RL.RLD_SEQRLG = G.AUTOINCREM)');
    qryLotDor.SQL.Add('WHERE G.RLG_NUMLOT = :NUMDOC');
    qryLotDor.SQL.Add('AND G.RLG_CODEMP = :CODEMP');

    qryLotDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryLotDor.ParamByName('CODEMP').AsString := strCodEmp;

    qryLotDor.Open;

    Result := not qryLotDor.IsEmpty;
  finally
    FreeAndNil(qryLotDor);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.mnuProdutosPedidoAtualClick(
  Sender: TObject);
begin
  inherited;
  pExibeProdutosPedidosSelecinados(cdsDocume.FieldByName('NUMDOC').AsString, cdsDocume.FieldByName('ESPDOC').AsString, cdsDocume.FieldByName('CODEMP').AsString);
end;

procedure TfrmFatRomaneioLoteSeparacao.mnuProdutosPedidosClick(Sender: TObject);
begin
  inherited;
  pExibeProdutosPedidosSelecinados();
end;

procedure TfrmFatRomaneioLoteSeparacao.pAfterScrollDoc(DataSet: TDataSet);
begin
  qryLroObs.Close;
  qryLroObs.ParamByName('NUMDOC').AsString := DataSet.FieldByName('NUMDOC').AsString;
  qryLroObs.ParamByName('ESPDOC').AsString := DataSet.FieldByName('ESPDOC').AsString;
  qryLroObs.ParamByName('CODEMP').AsString := DataSet.FieldByName('CODEMP').AsString;
  qryLroObs.ParamByName('CODCLI').AsString := DataSet.FieldByName('CODCLI').AsString;

  If DataSet.FieldByName('SERIE_').isNull Then
    qryLroObs.ParamByName('SERIE_').Value := Null
  Else
    qryLroObs.ParamByName('SERIE_').AsString := DataSet.FieldByName('SERIE_').AsString;

  qryLroObs.Open;

  edtObs1.Text := '';
  edtObs2.Text := '';

  If (Not qryLroObs.IsEmpty) Then
  Begin
    edtObs1.Text := qryLroObs.FieldbyName('OBS_OBSER1').AsString;
    edtObs2.Text := qryLroObs.FieldbyName('OBS_OBSER2').AsString;
  End;

  fGetMensagens;
end;

function TfrmFatRomaneioLoteSeparacao.fAtualizaStatusSaldo(cxProgressBar: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
begin
  Result := True;
  if Not Assigned(cdsDocume) then
    Exit;

  if not cdsDocume.Active then
    Exit;

  if cdsDocume.RecordCount <= 0 then
    Exit;

  if not cxgSALDOC.Visible then
    Exit;

  pInfoStatusGravacao(cxProgressBar, 'Aguarde, carregando Status de Saldo dos pedidos ...', cdsDocume.RecordCount);

  pDisableControls(cdsDocume, prcScroll);
  try
    cdsDocume.First;

    while not cdsDocume.Eof do
    begin
      pStepStatusGravacao(cxProgressBar);

      cdsDocume.Edit;
      cdsDocume.FieldByName('SALDOC').AsInteger := fRetInfStatusSaldo;
      cdsDocume.Post;
      cdsDocume.Next;
    end;

  finally
    if cdsDocume.Active then
      cdsDocume.First;
    pEnableControls(cdsDocume, prcScroll);
    pAfterScrollDoc(cdsDocume);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pCarregarItensSepParcial(cxProgressBar: TcxProgressBar);
Var
  qryDocs: TUniQuery;
  prcScroll: TprcScroll;
begin
  qryDocs := fCriaQuery;
  Try
    qryDocs.Sql.Add(' SELECT SQL_NO_CACHE ');
    qryDocs.Sql.Add('   RLD_NUMDOC AS NUMDOC, ');
    qryDocs.Sql.Add('   RLD_ESPDOC AS ESPDOC, ');
    qryDocs.Sql.Add('   RLD_CODEMP AS CODEMP, ');
    qryDocs.Sql.Add('   RLD_SERIE_ AS SERIE_  ');
    qryDocs.Sql.Add(' FROM ');
    qryDocs.Sql.Add('   ROMLDE ');
    qryDocs.Sql.Add('   INNER JOIN ROMLGE ');
    qryDocs.Sql.Add('     ON ROMLGE.AUTOINCREM = RLD_SEQRLG ');
    qryDocs.Sql.Add(' WHERE RLG_NUMLOT = :NUMLOT ');
    qryDocs.Sql.Add('   AND RLG_CODEMP = :CODEMP ');

    qryDocs.ParamByName('NUMLOT').AsString := edtNumLot.Text;
    qryDocs.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryDocs.Open;

    pInfoStatusGravacao(cxProgressBar, 'Aguarde, Carregando quantidade dos produtos ...', qryDocs.RecordCount);

    cdsItensSepPar.EmptyDataSet;

    qryDocs.First;

    pDisableControls(cdsDocume, prcScroll);
    try

      While Not qryDocs.Eof Do
      Begin
        pStepStatusGravacao(cxProgressBar);

        If cdsDocume.Locate('NUMDOC;ESPDOC;CODEMP;SERIE_',
                VarArrayOf([qryDocs.FieldByName('NUMDOC').AsString,
                            qryDocs.FieldByName('ESPDOC').AsString,
                            qryDocs.FieldByName('CODEMP').AsString,
                            qryDocs.FieldByName('SERIE_').AsString]), []) Then
        Begin
          If cdsDocume.FieldByName('MARDES').AsString = 'P' Then
            pMarcarItensSepParcial(opGravado)
          Else If cdsDocume.FieldByName('MARDES').AsString = 'M' Then
            pMarcarItensSepParcial(opTodos);
        End;

        qryDocs.Next;
      End;

      fPesoBrutoSelecionado;
    finally
      cdsDocume.First;
      pEnableControls(cdsDocume, prcScroll);
      pAfterScrollDoc(cdsDocume);
    end;

  Finally
    FreeAndNil(qryDocs);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pCriarCdsItensSepParcial;
begin
  cdsItensSepPar := TUniClientDataSet.Create(Self);
  cdsItensSepPar.FieldDefs.Add('TABELA',ftString, 12);
  cdsItensSepPar.FieldDefs.Add('NUMDOC',ftString, 12);
  cdsItensSepPar.FieldDefs.Add('ESPDOC',ftString, 02);
  cdsItensSepPar.FieldDefs.Add('CODEMP',ftString, 03);
  cdsItensSepPar.FieldDefs.Add('SERIE_',ftString, 03);
  cdsItensSepPar.FieldDefs.Add('AUTINC',ftString, 20);
  cdsItensSepPar.FieldDefs.Add('CODITE',ftString, fTamCodIte);
  cdsItensSepPar.FieldDefs.Add('DESCRI',ftString,100);
  cdsItensSepPar.FieldDefs.Add('NUMLOT',ftString, VS_Size_NumLot);
  cdsItensSepPar.FieldDefs.Add('SIGUNI',ftString, 07);
  cdsItensSepPar.FieldDefs.Add('SALDIS',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('QTDITE',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('QJASEP',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('QTDRES',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('QTDSEP',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('PESOIT',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('PESSEL',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('PESTOT',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('VLRSEL',ftFloat , 00);
  cdsItensSepPar.FieldDefs.Add('TOTITE',ftFloat , 00);
  cdsItensSepPar.CreateDataSet;
  cdsItensSepPar.Open;
  cdsItensSepPar.IndexFieldNames := 'NUMDOC;ESPDOC;CODEMP;SERIE_;AUTINC';
end;

procedure TfrmFatRomaneioLoteSeparacao.pDesmarcar;
begin
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  cdsDocume.Edit;
  cdsDocume.FieldByName('SEQUEN').AsInteger := -1;
  cdsDocume.FieldByName('MARDES').AsString  := 'D';
  cdsDocume.FieldByName('SALDOC').AsInteger := fRetInfStatusSaldo('D');
  cdsDocume.Post;

  objLock.fLock_Unlock(fRetTrava, False, False);
end;

procedure TfrmFatRomaneioLoteSeparacao.pDesmarcarItensSepParcial;
begin
  pDesmarcarItensSepParcial(cdsDocume.FieldByName('NUMDOC').AsString,
                            cdsDocume.FieldByName('ESPDOC').AsString,
                            cdsDocume.FieldByName('CODEMP').AsString,
                            cdsDocume.FieldByName('SERIE_').AsString);
end;

procedure TfrmFatRomaneioLoteSeparacao.pDesmarcarItensSepParcial(strNumDoc,
  strEspDoc, strCodEmp, strSerie_: String);
begin
  Try
    cdsItensSepPar.Filtered := False;
    cdsItensSepPar.Filter   := 'NUMDOC = ' + strNumDoc.QuotedString + ' AND ' +
                               'ESPDOC = ' + strEspDoc.QuotedString + ' AND ' +
                               'CODEMP = ' + strCodEmp.QuotedString + ' AND ' +
                               'SERIE_ = ' + strSerie_.QuotedString;
    cdsItensSepPar.Filtered := True;
    While Not cdsItensSepPar.IsEmpty Do
      cdsItensSepPar.Delete;
  Finally
    cdsItensSepPar.Filtered := False;
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pGravarItensSepParcial(strNumDoc,
  strEspDoc, strCodEmp, strSerie_, strSeqRld: String);
  Var
    qryGravar: TUniQuery;
begin
  qryGravar := fCriaQuery(nil);

  Try
    qryGravar.SQL.Text := 'SELECT * FROM ROMLIT WHERE FALSE';
    qryGravar.Open;

    Try
      cdsItensSepPar.Filtered := False;
      cdsItensSepPar.Filter   := 'NUMDOC = ' + strNumDoc.QuotedString + ' AND ' +
                                 'ESPDOC = ' + strEspDoc.QuotedString + ' AND ' +
                                 'CODEMP = ' + strCodEmp.QuotedString + ' AND ' +
                                 'SERIE_ = ' + strSerie_.QuotedString;
      cdsItensSepPar.Filtered := True;

      cdsItensSepPar.First;

      While Not cdsItensSepPar.Eof Do
      Begin
        If cdsItensSepPar.FieldByName('QTDSEP').AsFloat > 0 Then
        Begin
          qryGravar.Append;
          qryGravar.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ROMLIT', VS_strCodEmp);
          qryGravar.FieldByName('RLI_SEQRLD').AsString := strSeqRld;

          If cdsItensSepPar.FieldByName('TABELA').AsString = 'FATDOR' Then
            qryGravar.FieldByName('RLI_SEQFDO').AsString := cdsItensSepPar.FieldByName('AUTINC').AsString
          Else
            qryGravar.FieldByName('RLI_SEQDET').AsString := cdsItensSepPar.FieldByName('AUTINC').AsString;

          qryGravar.FieldByName('RLI_QTDSEP').AsFloat := cdsItensSepPar.FieldByName('QTDSEP').AsFloat;
          qryGravar.Post;
        End;
        cdsItensSepPar.Next;
      End;

    Finally
      cdsItensSepPar.Filtered := False;
    End;

  Finally
    FreeAndNil(qryGravar);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pInverte;
begin
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  If cdsDocume.FieldByName('SEQUEN').AsInteger < 0 Then
  Begin
    if fMarcar then
      pMarcarItensSepParcial(opTodos);
  End
  Else
  Begin
    pDesmarcar;
    pDesmarcarItensSepParcial;
  End;

  fPesoBrutoSelecionado;
end;

function TfrmFatRomaneioLoteSeparacao.fMarcar(strMarDes: String = 'M'): Boolean;
begin
  Result := False;
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  if cdsDocume.FieldByName('MARDES').AsString = 'D' then
  begin
    Screen.Cursor := crHourGlass;
    try
      If Not objLock.fLock_Unlock(fRetTrava, True, False) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                      fGetHostLock(fRetTrava)  + '!', ['&Ok']);
        Exit;
      End;
    finally
      Screen.Cursor := crDefault;
    end;
  end;

  cdsDocume.Edit;

  If cdsDocume.FieldByName('SEQUEN').AsInteger < 0 Then
  Begin
    Inc(intUltSeq);
    cdsDocume.FieldByName('SEQUEN').AsInteger := intUltSeq;
  End;

  cdsDocume.FieldByName('MARDES').AsString  := strMarDes;
  cdsDocume.FieldByName('SALDOC').AsInteger := fRetInfStatusSaldo;
  cdsDocume.Post;

  pVerificaDocumentosCliente;
  Result := True;
end;

procedure TfrmFatRomaneioLoteSeparacao.pMarcarItensSepParcial(Opcao: TOpcaoSelecao);
begin
  pMarcarItensSepParcial(cdsDocume.FieldByName('NUMDOC').AsString,
                         cdsDocume.FieldByName('ESPDOC').AsString,
                         cdsDocume.FieldByName('CODEMP').AsString,
                         cdsDocume.FieldByName('SERIE_').AsString,
                         Opcao);
end;

procedure TfrmFatRomaneioLoteSeparacao.pMarcarItensSepParcial(strNumDoc,
  strEspDoc, strCodEmp, strSerie_: String; Opcao: TOpcaoSelecao);
Var
  qryItens: TUniQuery;
  intField: Integer;
  blnLocalizou: Boolean;
  blnConfirma: Boolean;
  strLetMar: String;
  blnTemQtdJaSep: Boolean;
  frmFatItensLoteSep: TfrmFatItensLoteSeparacaoRomaneio;

  function fField(strName: String): TField;
  begin
    Result := qryItens.FieldByName(strName);
  end;

begin
  qryItens := fCriaQuery;
  Try
    pPreencheSQLQueryItens(qryItens);

    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('SERIE_').AsString := strSerie_;
    qryItens.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryItens.ParamByName('SERTER').AsString := fCfgSis('SERTER');

    qryItens.Open;

    blnTemQtdJaSep := False;

    qryItens.First;

    While Not qryItens.Eof Do
    Begin
      If fField('QJASEP').AsFloat > 0 Then
        blnTemQtdJaSep := True;

      blnLocalizou :=
        cdsItensSepPar.Locate('NUMDOC;ESPDOC;CODEMP;SERIE_;AUTINC',
                  VarArrayOf([fField('NUMDOC').AsString,
                              fField('ESPDOC').AsString,
                              fField('CODEMP').AsString,
                              fField('SERIE_').AsString,
                              fField('AUTINC').AsString]), []);

      If blnLocalizou Then
        cdsItensSepPar.Edit
      Else
        cdsItensSepPar.Append;

      For intField := 0 To cdsItensSepPar.Fields.Count -1 Do
        If (Opcao = opTodos) Or (Not blnLocalizou) Or
           (cdsItensSepPar.Fields[intField].FieldName <> 'QTDSEP') Then
        Begin
          cdsItensSepPar.Fields[intField].Value :=
            fField(cdsItensSepPar.Fields[intField].FieldName).Value;
        End;

      If Opcao = opGravado Then
        cdsItensSepPar.FieldByName('QTDSEP').AsFloat :=
          fCampoTabela('RLI_QTDSEP',
                       'ROMLIT ' +
                       'INNER JOIN ROMLDE ON ROMLDE.AUTOINCREM = RLI_SEQRLD ' +
                       'INNER JOIN ROMLGE ON ROMLGE.AUTOINCREM = RLD_SEQRLG ',
                       ['RLG_NUMLOT','RLG_CODEMP',IIF(fField('TABELA').AsString = 'MOVDET', 'RLI_SEQDET', 'RLI_SEQFDO')],
                       [edtNumLot.Text, VS_strCodEmp, fField('AUTINC').AsString]);

      cdsItensSepPar.FieldByName('PESSEL').AsFloat := cdsItensSepPar.FieldByName('PESOIT').AsFloat * cdsItensSepPar.FieldByName('QTDSEP').AsFloat;
      cdsItensSepPar.Post;

      qryItens.Next;
    End;

  Finally
    FreeAndNil(qryItens);
  End;

  If Opcao <> opParcial Then
  Begin
    If blnTemQtdJaSep Then
      fMarcar('P');
    Exit;
  End;

  Try
    cdsItensSepPar.Filtered := False;
    cdsItensSepPar.Filter   := 'NUMDOC = ' + strNumDoc.QuotedString + ' AND ' +
                               'ESPDOC = ' + strEspDoc.QuotedString + ' AND ' +
                               'CODEMP = ' + strCodEmp.QuotedString + ' AND ' +
                               'SERIE_ = ' + strSerie_.QuotedString;
    cdsItensSepPar.Filtered := True;

    If cdsItensSepPar.IsEmpty Then
    Begin
      pMensagemOk('Nenhum produto foi encontrado para este documento!');
      Exit;
    End;

    (cdsItensSepPar.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('QJASEP') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('QTDRES') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('QTDSEP') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('PESSEL') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('PESTOT') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('VLRSEL') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('SALDIS') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (cdsItensSepPar.FieldByName('TOTITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    pCriarFormularios(TfrmFatItensLoteSeparacaoRomaneio, frmFatItensLoteSep);
    Try
      frmFatItensLoteSep.Caption := Concat(strNumDoc, '-', strEspDoc, '-', strCodEmp);
      frmFatItensLoteSep.dtsItens.Dataset := cdsItensSepPar;
      blnConfirma := (frmFatItensLoteSep.ShowModal = mrOk);
      strLetMar   := frmFatItensLoteSep.strLetMar;
    Finally
      pFreeAndNil(frmFatItensLoteSep);
    End;
  Finally
    cdsItensSepPar.Filter   := '';
    cdsItensSepPar.Filtered := False;
  End;

  If (blnConfirma) Then
  Begin
    If (strLetMar = 'D') Then
      pDesmarcar
    Else
      fMarcar(strLetMar);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pPreencheSQLQueryItens(Var qryItens: TUniQuery);
begin
  qryItens.Sql.Add(' SELECT SQL_NO_CACHE     ');
  qryItens.Sql.Add('   "FATDOR"   AS TABELA, ');
  qryItens.Sql.Add('   FDO_NUMDOC AS NUMDOC, ');
  qryItens.Sql.Add('   FDO_ESPDOC AS ESPDOC, ');
  qryItens.Sql.Add('   FDO_CODEMP AS CODEMP, ');
  qryItens.Sql.Add('   FDO_SERIE_ AS SERIE_, ');
  qryItens.Sql.Add('   FATDOR.AUTOINCREM AS AUTINC, ');
  qryItens.Sql.Add('   FDO_CODITE AS CODITE, ');
  qryItens.Sql.Add('   FDO_DESCRI AS DESCRI, ');
  qryItens.Sql.Add('   FDO_NUMLOT AS NUMLOT, ');
  qryItens.Sql.Add('   UNI_SIGUNI AS SIGUNI, ');
  qryItens.Sql.Add('   0.00 AS SALDIS, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeItem('FDO') + ' AS QTDITE, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeJaSeparadaItem('FDO', 'FATDOR')+' AS QJASEP, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeRestanteItem('FDO', 'FATDOR') + ' AS QTDRES, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeRestanteItem('FDO', 'FATDOR') + ' AS QTDSEP, ');
  qryItens.Sql.Add('   FDO_TOTPES / FDO_QTDITE AS PESOIT, ');
  qryItens.Sql.Add('   FDO_TOTPES / FDO_QTDITE * ' + fSQLQuantidadeRestanteItem('FDO', 'FATDOR') + ' AS PESSEL, ');
  qryItens.Sql.Add('   FDO_VLRCON / FDO_QTDITE * ' + fSQLQuantidadeRestanteItem('FDO', 'FATDOR') + ' AS VLRSEL, ');
  qryItens.Sql.Add('   FDO_TOTPES AS PESTOT,  ');
  qryItens.Sql.Add('   FDO_TOTITE AS TOTITE  ');
  qryItens.Sql.Add(' FROM ');
  qryItens.Sql.Add('   FATDOR ');
  qryItens.Sql.Add('   INNER JOIN EXTDOR ');
  qryItens.Sql.Add('     ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
  qryItens.Sql.Add('   LEFT JOIN CADUNI ');
  qryItens.Sql.Add('     ON UNI_CODUNI = FDO_UNIDAD ');
  qryItens.Sql.Add(' WHERE FDO_NUMDOC = :NUMDOC  ');
  qryItens.Sql.Add('   AND FDO_ESPDOC = :ESPDOC  ');
  qryItens.Sql.Add('   AND FDO_CODEMP = :CODEMP  ');
  qryItens.Sql.Add('   AND FDO_CODITE <> :ITESER ');
  qryItens.Sql.Add('   AND FDO_CODITE <> :SERTER ');
  qryItens.Sql.Add('   AND FDO_ENTRET <> "R" ');
  qryItens.Sql.Add('   AND FDO_ENTFUT <> "S" ');

  If (rdgDoc.ItemIndex = 0) Then
  Begin
    qryItens.Sql.Add('  AND (  ');
    qryItens.Sql.Add('    (LOCATE(FDO_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0 AND FDO_VLRCON > 0) ');
    qryItens.Sql.Add('       OR LOCATE(FDO_CLAFIS,' + CLAFIS_BR + ')                                  ');
    qryItens.Sql.Add('  )      ');
    qryItens.Sql.Add('  AND FDO_CODCLI NOT IN ('  + fRetClientesFilial + ') ');
  End
  Else If (rdgDoc.ItemIndex = 1) Then
  Begin
    qryItens.Sql.Add('  AND FDO_CODCLI IN (' + fRetClientesFilial + ')');
  End
  Else
  Begin
    qryItens.Sql.Add('  AND (  ');
    qryItens.Sql.Add('    (LOCATE(FDO_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0 AND FDO_VLRCON > 0)  ');
    qryItens.Sql.Add('     OR LOCATE(FDO_CLAFIS,' + CLAFIS_BR + ')                                     ');
    qryItens.Sql.Add('     OR FDO_CODCLI IN (' + fRetClientesFilial + ')                               ');
    qryItens.Sql.Add('  )      ');
  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    qryItens.Sql.Add('   AND FDO_PROEMB <> "S" ');

  qryItens.Sql.Add('   AND RIGHT(FDO_CLAFIS, 3) <> "999" ');

  If fCfgSis('CLBUEF',varboolean) Then
    qryItens.Sql.Add('   AND FDO_CLIBUS = "N" ');

  qryItens.Sql.Add(' UNION ALL ');

  qryItens.Sql.Add(' SELECT SQL_NO_CACHE     ');
  qryItens.Sql.Add('   "MOVDET"   AS TABELA, ');
  qryItens.Sql.Add('   DET_NUMDOC AS NUMDOC, ');
  qryItens.Sql.Add('   DET_ESPDOC AS ESPDOC, ');
  qryItens.Sql.Add('   DET_CODEMP AS CODEMP, ');
  qryItens.Sql.Add('   DET_SERIE_ AS SERIE_, ');
  qryItens.Sql.Add('   MOVDET.AUTOINCREM AS AUTINC, ');
  qryItens.Sql.Add('   DET_CODITE AS CODITE, ');
  qryItens.Sql.Add('   DET_DESCRI AS DESCRI, ');
  qryItens.Sql.Add('   DET_NUMLOT AS NUMLOT, ');
  qryItens.Sql.Add('   UNI_SIGUNI AS SIGUNI, ');
  qryItens.Sql.Add('   0.00 AS SALDIS, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeItem('DET') + ' AS QTDITE, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeJaSeparadaItem('DET', 'MOVDET')+' AS QJASEP, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeRestanteItem('DET', 'MOVDET') + ' AS QTDRES, ');
  qryItens.Sql.Add('   ' + fSQLQuantidadeRestanteItem('DET', 'MOVDET') + ' AS QTDSEP, ');
  qryItens.Sql.Add('   DET_TOTPES / DET_QTDITE AS PESOIT,  ');
  qryItens.Sql.Add('   DET_TOTPES / DET_QTDITE * ' + fSQLQuantidadeRestanteItem('DET', 'MOVDET') + ' AS PESSEL, ');
  qryItens.Sql.Add('   DET_VLRCON / DET_QTDITE * ' + fSQLQuantidadeRestanteItem('DET', 'MOVDET') + ' AS VLRSEL, ');
  qryItens.Sql.Add('   DET_TOTPES AS PESTOT,  ');
  qryItens.Sql.Add('   DET_TOTITE AS TOTITE  ');

  qryItens.Sql.Add(' FROM ');
  qryItens.Sql.Add('   MOVDET ');
  qryItens.Sql.Add('   LEFT JOIN CADUNI ');
  qryItens.Sql.Add('     ON UNI_CODUNI = DET_UNIDAD ');
  qryItens.Sql.Add('   LEFT JOIN MOVTRI ');
  qryItens.Sql.Add('     ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
  qryItens.Sql.Add(' WHERE DET_NUMDOC = :NUMDOC ');
  qryItens.Sql.Add('   AND DET_ESPDOC = :ESPDOC ');
  qryItens.Sql.Add('   AND DET_CODEMP = :CODEMP ');
  qryItens.Sql.Add('   AND IFNULL(DET_SERIE_, "") = :SERIE_ ');
  qryItens.Sql.Add('   AND DET_CODITE <> :ITESER ');
  qryItens.Sql.Add('   AND DET_CODITE <> :SERTER ');
  qryItens.Sql.Add('   AND DET_ENTFUT <> "S" ');

  If (fCfgSis('OPROSE', varString) = '2') Then
  Begin
    qryItens.Sql.Add('   AND DET_CLAFIS >= 5000 ');
    If (rdgDoc.ItemIndex = 0) Then
    Begin
      qryItens.Sql.Add('  AND (LOCATE(DET_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0) ');
      qryItens.Sql.Add('  AND DET_CODCLI NOT IN ('  + fRetClientesFilial + ') ');
    End
    Else If (rdgDoc.ItemIndex = 1) Then
    Begin
      qryItens.Sql.Add('  AND DET_CODCLI IN ('  + fRetClientesFilial + ') ');
    End
    Else
    Begin
      qryItens.Sql.Add('  AND (  ');
      qryItens.Sql.Add('    (LOCATE(DET_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0) ');
      qryItens.Sql.Add('    OR DET_CODCLI IN ('  + fRetClientesFilial + ')           ');
      qryItens.Sql.Add('  )      ');
    End;

  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    qryItens.Sql.Add('   AND DET_PROEMB <> "S" ');

  qryItens.Sql.Add('   AND RIGHT(DET_CLAFIS, 3) <> "999" ');

  If fCfgSis('CLBUEF',varboolean) Then
    qryItens.Sql.Add('   AND DET_CLIBUS = "N" ');
end;

procedure TfrmFatRomaneioLoteSeparacao.pSetaSQLLroObs;
begin
  qryLroObs.SQL.Clear;
  qryLroObs.SQL.Add(' SELECT * ');
  qryLroObs.SQL.Add('   FROM LROOBS ');
  qryLroObs.SQL.Add('  WHERE OBS_NUMDOC = :NUMDOC ');
  qryLroObs.SQL.Add('    AND OBS_ESPDOC = :ESPDOC ');
  qryLroObs.SQL.Add('    AND OBS_CODEMP = :CODEMP ');
  qryLroObs.SQL.Add('    AND OBS_SERIE_ = :SERIE_ ');
  qryLroObs.SQL.Add('    AND OBS_CODCLI = :CODCLI ');
end;

procedure TfrmFatRomaneioLoteSeparacao.pDimensionarPanelCamposRodape;
var
  intCont : Integer;
  intHeightVisible : Integer;
begin
  intHeightVisible := 0;
  for intCont := 0 to Self.ComponentCount -1 do
  begin
    if (Self.Components[intCont].GetParentComponent = pnlCamposRodape) then
    begin
      if (Self.Components[intCont] is TPanel) then
      begin
        if TPanel(Self.Components[intCont]).Visible then
          intHeightVisible := intHeightVisible + TPanel(Self.Components[intCont]).Height;
      end;
    end;
  end;

  pnlCamposRodape.Visible := True;

  if intHeightVisible = 0 then
    pnlCamposRodape.Visible := False
  else
    pnlCamposRodape.Height := intHeightVisible;

  pnlRodape.Visible := False;
  pnlRodape.Visible := True;
end;

procedure TfrmFatRomaneioLoteSeparacao.fPesoBrutoSelecionado;
var
  fltPeso: Double;
  fltValor: Double;
  fltPesoTot: Double;
  fltValorTot: Double;
  fltValorTotProdutos: Double;
  fltValorTotProdutosSel: Double;
  cdsTmp : TZClient;
  intQtdDoc: Integer;
  intQtdSel: Integer;
  fltVolTot: Double;
  fltVolSel: Double;
  fltValorTotFaturado : Double;
begin
  fltPeso  := 0;
  fltValor := 0;
  fltPesoTot := 0;
  fltValorTot := 0;
  fltValorTotProdutos := 0;
  fltValorTotProdutosSel := 0;
  intQtdDoc := 0;
  intQtdSel := 0;
  fltVolTot := 0;
  fltVolSel := 0;
  fltValorTotFaturado := 0;

  cdsTmp := TZClient.Create(Self);
  try
    cdsTmp.data := cdsDocume.data;

    cdsTmp.DisableControls;
    cdsTmp.First;
    while not cdsTmp.eof do
    begin
      if cdsTmp.FieldByName('SEQUEN').AsInteger > 0 then
      Begin
        Try
          cdsItensSepPar.Filtered := False;
          cdsItensSepPar.Filter   := 'NUMDOC = ' + cdsTmp.FieldByName('NUMDOC').AsString.QuotedString + ' AND ' +
                                     'ESPDOC = ' + cdsTmp.FieldByName('ESPDOC').AsString.QuotedString + ' AND ' +
                                     'CODEMP = ' + cdsTmp.FieldByName('CODEMP').AsString.QuotedString + ' AND ' +
                                     'SERIE_ = ' + cdsTmp.FieldByName('SERIE_').AsString.QuotedString;
          cdsItensSepPar.Filtered := True;
          cdsItensSepPar.First;
          While Not cdsItensSepPar.Eof Do
          Begin
            fltPeso  := fltPeso  + cdsItensSepPar.FieldByName('PESSEL').AsFloat;
            fltValor := fltValor + cdsItensSepPar.FieldByName('VLRSEL').AsFloat;
            fltValorTotProdutosSel := fltValorTotProdutosSel + cdsItensSepPar.FieldByName('TOTITE').AsFloat;
            cdsItensSepPar.Next;
          End;
        Finally
          cdsItensSepPar.Filtered := False;
        End;
        Inc(intQtdSel);
        fltVolSel := fltVolSel + cdsTmp.FieldByName('VOLUME').AsFloat;
      End;

      Inc(intQtdDoc);
      fltVolTot := fltVolTot + cdsTmp.FieldByName('VOLUME').AsFloat;

      pSomaCamposItens(fltPesoTot, fltValorTot, fltValorTotProdutos,
        cdsTmp.FieldByName('NUMDOC').AsString, cdsTmp.FieldByName('ESPDOC').AsString,
        cdsTmp.FieldByName('CODEMP').AsString, cdsTmp.FieldByName('SERIE_').AsString);

      fltValorTotFaturado := fltValorTotFaturado + cdsTmp.FieldByName('TOTFAT').AsFloat;

      cdsTmp.next;
    end;

    edtTotPes.Text := FloatToStrF(fltPeso,  ffFixed, 12, 2);
    edtTotVal.Text := FloatToStrF(fltValor, ffFixed, 12, 2);
    edtQtdDoc.Text := IntToStr(intQtdDoc);
    edtQtdSel.Text := IntToStr(intQtdSel);
    edtVolTot.Text := FloatToStrF(fltVolTot,  ffFixed, 12, 3);
    edtVolSel.Text := FloatToStrF(fltVolSel,  ffFixed, 12, 3);
    edtPesoTot.Text := FloatToStrF(fltPesoTot, ffFixed, 12, 2);
    edtValorTotal.Text := FloatToStrF(fltValorTot, ffFixed, 12, 2);

    edtValorTotalProdutos.Text    := FloatToStrF(fltValorTotProdutos, ffFixed, 12, 2);
    edtValorTotalProdutosSel.Text := FloatToStrF(fltValorTotProdutosSel, ffFixed, 12, 2);

    edtValorTotalFaturado.Text    := FloatToStrF(fltValorTotFaturado, ffFixed, 12, 2);
  finally
    FreeAndNil(cdsTmp);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pSomaCamposItens(Var fltPesoTot, fltValorTot, fltValorProdutos: Double;
  strNumDoc, strEspDoc, strCodEmp, strSerie_: String);
  Var
    qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  Try
    qryItens.Close;
    qryItens.SQL.Clear;
    pPreencheSQLQueryItens(qryItens);
    qryItens.ParamByName('NUMDOC').AsString := strNumDoc;
    qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
    qryItens.ParamByName('CODEMP').AsString := strCodEmp;
    qryItens.ParamByName('SERIE_').AsString := strSerie_;
    qryItens.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryItens.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qryItens.Open;

    If (qryItens.IsEmpty) Then
      Exit;

    qryItens.First;

    While (Not qryItens.Eof) Do
    Begin
      fltPesoTot := fltPesoTot + qryItens.FieldByName('PESOIT').AsFloat * qryItens.FieldByName('QTDSEP').AsFloat;
      fltValorTot := fltValorTot + qryItens.FieldByName('VLRSEL').AsFloat;
      fltValorProdutos := fltValorProdutos + qryItens.FieldByName('TOTITE').AsFloat;
      qryItens.Next;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TfrmFatRomaneioLoteSeparacao.pValidaSituacaoFinanceiraPedido_E_VinculoLoteSeparacao;
var strIncGor,
    strPenFin: String;
    prcScroll: TprcScroll;
    strAutIncLotSep: String;
Begin
  pInfoStatusGravacao(cxProgressBar, 'Aguarde, Validando situação financeira pedidos ...', cdsDocume.RecordCount);

  pDisableControls(cdsDocume, prcScroll);
  cdsDocume.First;
  While not cdsDocume.eof do
  Begin
    pStepStatusGravacao(cxProgressBar);

    If (cdsDocume.FieldByName('ESPDOC').AsString = 'PD') Then
    Begin
      If (cdsDocume.FieldByName('CODFPG').AsString = '016') Then
        strIncGor := fCampoTabela('AUTOINCREM', 'FATGOR',
                                  ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                                  [cdsDocume.FieldByName('NUMDOC').AsString,
                                   cdsDocume.FieldByName('ESPDOC').AsString,
                                   cdsDocume.FieldByName('CODEMP').AsString,
                                   cdsDocume.FieldByName('CODCLI').AsString])
      Else
        strIncGor := '';

      If Not fValidaSituacaoFinanceiraPedido(cdsDocume.FieldByName('CODCLI').AsString,
                                             cdsDocume.FieldByName('ESPDOC').AsString,
                                             cdsDocume.FieldByName('CODFPG').AsString,
                                             cdsDocume.FieldByName('CONPAG').AsString,
                                             cdsDocume.FieldByName('FPGNEG').AsString,
                                             strIncGor,
                                             cdsDocume.FieldByName('TIPOPE').AsString,
                                             cdsDocume.FieldByName('ORIF11').AsString = 'S',
                                             cdsDocume.FieldByName('CONORI').AsFloat,
                                             fFormataFloat(cdsDocume.FieldByName('VALADT').AsFloat + cdsDocume.FieldByName('VALREC').AsFloat, 2),
                                             cdsDocume.FieldByName('BOLADT').AsFloat,
                                             cdsDocume.FieldByName('BOLVEN').AsString = 'S',
                                             cdsDocume.FieldByName('BENFUT').AsString = 'S',
                                             strPenFin) Then
      Begin
         cdsDocume.Delete;
      End
      Else If Not ckbPedLotSep.Checked Then
      Begin
        strAutIncLotSep := fCampoTabela('AUTOINCREM', 'FATGOR',
                                        ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                                        [cdsDocume.FieldByName('NUMDOC').AsString,
                                         cdsDocume.FieldByName('ESPDOC').AsString,
                                         cdsDocume.FieldByName('CODEMP').AsString,
                                         cdsDocume.FieldByName('CODCLI').AsString]);

        If fExisteLoteSeparacaoRomaneioParaPedido(strAutIncLotSep, edtNumLot.Text) Then
          cdsDocume.Delete
        Else
          cdsDocume.Next;
      End
      Else
         cdsDocume.Next;
    End
    Else
     cdsDocume.Next;

  End;
  pEnableControls(cdsDocume, prcScroll);
  pAfterScrollDoc(cdsDocume);
End;

procedure TfrmFatRomaneioLoteSeparacao.pVerificaDocumentosCliente;
var
  LqryDocumentos: TUniQuery;
  LfrmMensagemExplicativa: TfrmMensagemExplicativa;
  objMsg    : TMensagemLiberacao;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  if not fCfgSis('LSRUSA', varBoolean) then
    Exit;


  LqryDocumentos := fCriaQuery;
  try
    LqryDocumentos.SQL.Add('SELECT ');
    LqryDocumentos.SQL.Add('  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_DTAENT, RLG_NUMLOT, RLG_DTACAD ');
    LqryDocumentos.SQL.Add('FROM');
    LqryDocumentos.SQL.Add('  FATGOR ');
    LqryDocumentos.SQL.Add('  INNER JOIN ROMLDE ');
    LqryDocumentos.SQL.Add('    ON RLD_NUMDOC = FGO_NUMDOC ');
    LqryDocumentos.SQL.Add('    AND RLD_ESPDOC = FGO_ESPDOC ');
    LqryDocumentos.SQL.Add('    AND RLD_SERIE_ = COALESCE(FGO_SERIE_, "") ');
    LqryDocumentos.SQL.Add('    AND RLD_CODEMP = FGO_CODEMP ');
    LqryDocumentos.SQL.Add('  INNER JOIN ROMLGE ');
    LqryDocumentos.SQL.Add('    ON ROMLGE.AUTOINCREM = RLD_SEQRLG ');
    LqryDocumentos.SQL.Add('WHERE FGO_CODCLI = :CODCLI ');
    LqryDocumentos.SQL.Add('  AND FGO_JAFATU = 0 ');
    LqryDocumentos.SQL.Add('  AND RLG_DTACAD >= (CURRENT_DATE - INTERVAL :DIA DAY)');

    LqryDocumentos.ParamByName('CODCLI').AsString := cdsDocume.FieldByName('CODCLI').AsString;
    LqryDocumentos.ParamByName('DIA').AsString := fCfgSis('LSRDIA', VarString);

    LqryDocumentos.Open;

    if not LqryDocumentos.IsEmpty then
    begin
      pCriarFormularios(TfrmMensagemExplicativa, LfrmMensagemExplicativa);
      Try
        LfrmMensagemExplicativa.Caption := 'Pedidos do cliente';
        LfrmMensagemExplicativa.Width   := 1000;
        LfrmMensagemExplicativa.Height  := 600;

        objTabela := TRegistroMsgLiberaTabela.Create;
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna('', 'Pedido'          , 19, alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'Data Emi. Pedido', 16, alCentro  , teAutcom);
        objLinha.pAddColuna('', 'Lote'            , 8 , alEsquerda, teAutcom);
        objLinha.pAddColuna('', 'Data Inc. Lote'  , 14, alCentro  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        LqryDocumentos.First;
        while not LqryDocumentos.Eof do
        begin
          objLinha := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
           objLinha.pAddColuna('Pedido'             ,
            LqryDocumentos.FieldByName('FGO_NUMDOC').AsString + '-' +
            LqryDocumentos.FieldByName('FGO_ESPDOC').AsString + '-' +
            LqryDocumentos.FieldByName('FGO_CODEMP').AsString                                         , 19, alEsquerda, teAutcom);
          objLinha.pAddColuna('Data Emissão Pedido', LqryDocumentos.FieldByName('FGO_DTAENT').AsString, 16, alCentro  , teAutcom);
          objLinha.pAddColuna('Lote'               , LqryDocumentos.FieldByName('RLG_NUMLOT').AsString, 8 , alEsquerda, teAutcom);
          objLinha.pAddColuna('Data Inc. Lote'     , LqryDocumentos.FieldByName('RLG_DTACAD').AsString, 14, alCentro  , teAutcom);

          objTabela.lstLinhas.Add(objLinha);

          LqryDocumentos.Next;
        end;

        objMsg := TMensagemLiberacao.Create(nil);
        Try
          objMsg.pAddTexto('Existe outro(s) pedido(s) de venda deste mesmo cliente, ainda não faturado, em outro lote de separação de romaneio.');
          objMsg.pAddQuebra;
          objMsg.pAddTexto('Cliente: ' + cdsDocume.FieldByName('CODCLI').AsString + ' - ' + fRetNomCliente(cdsDocume.FieldByName('CODCLI').AsString));
          objMsg.lstRegistros.Add(objTabela);

          LfrmMensagemExplicativa.mmoInstru.Font.Style := [];
          LfrmMensagemExplicativa.mmoInstru.Lines.Add(objMsg.fGetMensagem());

          LfrmMensagemExplicativa.ShowModal;
        Finally
          FreeAndNil(objMsg);
        End;
      Finally
        pFreeAndNil(LfrmMensagemExplicativa);
      End;
    end;

  finally
    FreeAndNil(LqryDocumentos);
  end;

end;

procedure TfrmFatRomaneioLoteSeparacao.pVerificaFFNaoConfirmada;
var
  intRecNo: Integer;
  Dic: TDictionary<String, String>;
  objConfFF: TConfirmacaoDocumentos;
  strFFNCON: String;
begin
  intRecNo := cdsDocume.RecNo;
  cdsDocume.DisableControls;
  cdsDocume.First;
  Dic := TDictionary<String, String>.Create;
  objConfFF := TConfirmacaoDocumentos.Create(Nil);
  try

    objConfFF.blnFiltrarEmp := True;
    objConfFF.strEmpDoc := VS_strCodEmp;

    while not cdsDocume.Eof do
    begin

      if fClienteConsumidor(cdsDocume.FieldByName('NOMCLI').AsString) then
      begin
        cdsDocume.Next;
        Continue;
      end;

      if not Dic.TryGetValue(cdsDocume.FieldByName('CODCLI').AsString, strFFNCON) then
      begin
        objConfFF.strCodCli := cdsDocume.FieldByName('CODCLI').AsString;
        objConfFF.pCriaTemporariaConfirmacao;

        If objConfFF.blnSemDocumentosParaConfirmar Then
          strFFNCON := 'N'
        else
          strFFNCON := 'S';

        Dic.Add(cdsDocume.FieldByName('CODCLI').AsString, strFFNCON);
      end;

      cdsDocume.Edit;
      cdsDocume.FieldByName('FFNCON').AsString := strFFNCON;
      cdsDocume.Post;

      cdsDocume.Next;
    end;
  finally
    FreeAndNil(objConfFF);
    FreeAndNil(Dic);
    cdsDocume.RecNo := intRecNo;
    cdsDocume.EnableControls;
  end;

end;

procedure TfrmFatRomaneioLoteSeparacao.pVerificaVisibilidadeCampos;
var
  intContador : Integer;
  qryVisComp : TUniQuery;
begin
  qryVisComp := fCriaQuery(nil);
  try
    qryVisComp.Close;
    qryVisComp.SQL.Clear;
    qryVisComp.SQL.Add('SELECT * FROM VISRLS WHERE RLS_CODEMP = :CODEMP');
    qryVisComp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryVisComp.Open;

    for intContador := 0 to Self.ComponentCount -1 do
    begin
      if (Self.Components[intContador].GetParentComponent = pnlCamposRodape) then
      begin
        if (Self.Components[intContador] is TPanel) then
        begin
          if not qryVisComp.Locate('RLS_NAMCOM', TPanel(Self.Components[intContador]).Name, []) then
            pIncluirVisibilidade(TPanel(Self.Components[intContador]).Name,
                                 VS_strCodEmp,
                                 TPanel(Self.Components[intContador]).Hint,
                                 TPanel(Self.Components[intContador]).Visible)
          else
            TPanel(Self.Components[intContador]).Visible := qryVisComp.FieldByName('RLS_VISIBL').AsString = 'S';
        end;
      end;
    end;

    shpSalDoc.Visible := cxgSALDOC.Visible;
    lblSalDoc.Visible := shpSalDoc.Visible;
    pDimensionarPanelCamposRodape;
  finally
    FreeAndNil(qryVisComp);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pVisualizarVolumeItem;
var
  frmGrid: TfrmGrid;
  cdsTmp: TZClient;
  cdsVolume: TUniClientDataSet;
  qryProdutos: TUniQuery;
  Field: TFieldDef;
  strCodIte: String;
  strUnidad: String;
  fltQtdIte: Double;
  fltEmbala: Double;
begin
  cdsVolume := TUniClientDataSet.Create(Nil);
  cdsTmp := TZClient.Create(Nil);
  qryProdutos := fCriaQuery;

  try
    Field := cdsVolume.FieldDefs.AddFieldDef;
    Field.Name := 'DESITE';
    Field.DataType := ftString;
    Field.Size := 70;

    Field := cdsVolume.FieldDefs.AddFieldDef;
    Field.Name := 'SIGUNI';
    Field.DataType := ftString;
    Field.Size := 4;

    Field := cdsVolume.FieldDefs.AddFieldDef;
    Field.Name := 'QTDITE';
    Field.DataType := ftFloat;

    Field := cdsVolume.FieldDefs.AddFieldDef;
    Field.Name := 'VOLUME';
    Field.DataType := ftFloat;

    cdsVolume.CreateDataSet;
    cdsVolume.Open;

    TFloatField(cdsVolume.FieldByName('VOLUME')).DisplayFormat := '#,##0.000';
    TFloatField(cdsVolume.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    cdsVolume.FieldByName('SIGUNI').DisplayLabel := 'UN';
    cdsVolume.FieldByName('DESITE').DisplayLabel := 'Produto';
    cdsVolume.FieldByName('VOLUME').DisplayLabel := 'Volume';
    cdsVolume.FieldByName('QTDITE').DisplayLabel := 'Qtd';

    cdsTmp.data := cdsDocume.data;

    cdsTmp.DisableControls;
    cdsTmp.First;

    qryProdutos.Close;
    qryProdutos.SQL.Clear;
    qryProdutos.SQL.Add('SELECT FDO_CODITE, FDO_QTDITE, FDO_UNIDAD FROM FATDOR WHERE FDO_SEQGER = :AUTINC');

    while not cdsTmp.Eof do
    begin
      if (cdsTmp.FieldByName('SEQUEN').AsInteger > 0) and (cdsTmp.FieldByName('ESPDOC').AsString = 'PD') then
      begin
        qryProdutos.Close;
        qryProdutos.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('AUTINC').AsString;
        qryProdutos.Open;

        while not qryProdutos.Eof do
        begin
          strCodIte := qryProdutos.FieldByName('FDO_CODITE').AsString;
          strUnidad := qryProdutos.FieldByName('FDO_UNIDAD').AsString;
          fltQtdIte := qryProdutos.FieldByName('FDO_QTDITE').AsFloat;
          fltEmbala := fCampoTabela('ITE_EMBALA', 'CADITE', ['ITE_CODITE'], [strCodIte], False);

          cdsVolume.Append;
          cdsVolume.FieldByName('DESITE').AsString := strCodIte + ' - ' +fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
          cdsVolume.FieldByName('SIGUNI').AsString := fCampoTabela('UNI_SIGUNI', 'CADUNI', ['UNI_CODUNI'], [strUnidad], False);
          cdsVolume.FieldByName('VOLUME').AsFloat  := fCalcVolumes(strCodIte, fltQtdIte, fltEmbala);
          cdsVolume.FieldByName('QTDITE').AsFloat  := fltQtdIte;
          cdsVolume.Post;

          qryProdutos.Next;
        end;
      end;

      cdsTmp.Next;
    end;

    if not cdsVolume.IsEmpty then
    begin
      pCriarFormularios(TfrmGrid, frmGrid);

      try
        frmGrid.Width := 920;
        frmGrid.DataSet := cdsVolume;
        frmGrid.Caption := 'Visualizar Volume X Unidades Selecionados';
        frmGrid.pnlInfo.Caption := 'O volume do item é calculado pelo sistema, porém pode ter diferença com o volume atual do documento que pode ter sido digitado manualmente pelo operador';
        frmGrid.ShowModal;
      finally
        pFreeAndNil(frmGrid);
      end;
    end;
  finally
    FreeAndNil(cdsVolume);
    FreeAndNil(cdsTmp);
    FreeAndNil(qryProdutos);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pIncluirVisibilidade(strNamCom,
                                                            strCodEmp,
                                                            strDesCom : String;
                                                            blnVisivel : Boolean);
var
  qryVisComp : TUniQuery;
begin
  qryVisComp := fCriaQuery(nil);
  try
    qryVisComp.Close;
    qryVisComp.SQL.Clear;
    qryVisComp.SQL.Add('SELECT * FROM VISRLS WHERE FALSE');
    qryVisComp.Open;

    qryVisComp.Append;
    qryVisComp.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VISRLS', VS_strCodEmp);
    qryVisComp.FieldByName('RLS_NAMCOM').AsString := strNamCom;
    qryVisComp.FieldByName('RLS_VISIBL').AsString := ifThen(blnVisivel, 'S', 'N');
    qryVisComp.FieldByName('RLS_CODEMP').AsString := strCodEmp;
    qryVisComp.FieldByName('RLS_DESCOM').AsString := strDesCom;
    qryVisComp.Post;
  finally
    FreeAndNil(qryVisComp);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pGravarConfiguracoesLoteSepRom;
begin
  TCfgColRomLoteSep.pCarregarDadosSalvos(cxgDocumentosTableView);
end;

function TfrmFatRomaneioLoteSeparacao.fGetMensagens: String;
var
  strFgoInc : String;
begin
  strFgoInc := fCampoTabela('AUTOINCREM', 'FATGOR',
                            ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],
                            [cdsDocume.FieldByName('NUMDOC').AsString,
                             cdsDocume.FieldByName('ESPDOC').AsString,
                             cdsDocume.FieldByName('CODEMP').AsString,
                             cdsDocume.FieldByName('CODCLI').AsString]);

  if pnlMsgPed.Visible then
    edtMsgPed.Text := fGetMsgPed(strFgoInc);

  if pnlMsgExp.Visible then
    edtMsgExp.Text := fGetMsgExp(strFgoInc);
end;

function TfrmFatRomaneioLoteSeparacao.fGetMsgPed(strFgoInc : String) : String;
  var
    qryMsgPed : TUniQuery;
begin
  Result := '';

  if not fEmptyStr(strFgoInc) then
  begin
    qryMsgPed := fCriaQuery;
    try
      qryMsgPed.Close;
      qryMsgPed.SQL.Clear;
      qryMsgPed.SQL.Add(' SELECT  ');
      qryMsgPed.SQL.Add('   CONCAT(FGO_MEN001, (CASE WHEN COALESCE(FGO_MEN002,"") <> "" THEN ", " ELSE "" END), ');
      qryMsgPed.SQL.Add('          FGO_MEN002) AS MSGPED ');
      qryMsgPed.SQL.Add(' FROM FATGOR ');
      qryMsgPed.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
      qryMsgPed.ParamByName('AUTOINCREM').AsString := strFgoInc;
      qryMsgPed.Open;

      Result := qryMsgPed.FieldByName('MSGPED').AsString;
    finally
      FreeAndNil(qryMsgPed);
    end;
  end;
end;

function TfrmFatRomaneioLoteSeparacao.fGetMsgExp(strFgoInc : String) : String;
  var
    qryMsgeExp : TUniQuery;
begin
  Result := '';

  if not fEmptyStr(strFgoInc) then
  begin
    qryMsgeExp := fCriaQuery;
    try
      qryMsgeExp.Close;
      qryMsgeExp.SQL.Clear;
      qryMsgeExp.SQL.Add(' SELECT  ');
      qryMsgeExp.SQL.Add('   CONCAT(FGO_MENEXP, (CASE WHEN COALESCE(FGO_MENEX2,"") <> "" THEN ", " ELSE "" END),');
      qryMsgeExp.SQL.Add('          FGO_MENEX2, (CASE WHEN COALESCE(FGO_MENEX3,"") <> "" THEN ", " ELSE "" END),');
      qryMsgeExp.SQL.Add('          FGO_MENEX3, (CASE WHEN COALESCE(FGO_MENEX4,"") <> "" THEN ", " ELSE "" END),');
      qryMsgeExp.SQL.Add('          FGO_MENEX4) AS MSGEXP ');
      qryMsgeExp.SQL.Add(' FROM FATGOR ');
      qryMsgeExp.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM');
      qryMsgeExp.ParamByName('AUTOINCREM').AsString := strFgoInc;
      qryMsgeExp.Open;

      Result := qryMsgeExp.FieldByName('MSGEXP').AsString;
    finally
      FreeAndNil(qryMsgeExp);
    end;
  end;
end;

function TfrmFatRomaneioLoteSeparacao.fRetInfStatusSaldo(
  strMarDes: string): integer;
var
  qryItens: TUniQuery;
begin
  qryItens := fCriaQuery;

  Try
    Result := 0;

    qryItens.Close;
    qryItens.SQL.Clear;
    qryItens.Sql.Add(' SELECT  ' + fSQLQuantidadeRestanteItem('FDO', 'FATDOR') + ' AS QTDSEP, ');
    qryItens.Sql.Add('   FDO_SERIE_ AS SERIE_, ');
    qryItens.Sql.Add('   FATDOR.AUTOINCREM AS AUTINC, ');
    qryItens.Sql.Add('   FDO_NUMDOC AS NUMDOC, ');
    qryItens.Sql.Add('   FDO_ESPDOC AS ESPDOC, ');
    qryItens.Sql.Add('   FDO_CODEMP AS CODEMP, ');
    qryItens.Sql.Add('   FDO_CODITE AS CODITE  ');
    qryItens.Sql.Add(' FROM ');
    qryItens.Sql.Add('   FATDOR ');
    qryItens.Sql.Add('   INNER JOIN EXTDOR ');
    qryItens.Sql.Add('     ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryItens.Sql.Add(' WHERE FDO_NUMDOC = :NUMDOC  ');
    qryItens.Sql.Add('   AND FDO_ESPDOC = :ESPDOC  ');
    qryItens.Sql.Add('   AND FDO_CODEMP = :CODEMP  ');
    qryItens.Sql.Add('   AND FDO_CODITE <> :ITESER ');
    qryItens.Sql.Add('   AND FDO_CODITE <> :SERTER ');
    qryItens.Sql.Add('   AND FDO_ENTRET <> "R" ');
    qryItens.Sql.Add('   AND FDO_ENTFUT <> "S" ');

    qryItens.Sql.Add('   AND ((LOCATE(FDO_CLAFIS, '+
      QuotedStr(strClaVenLoc) + ') > 0 AND FDO_VLRCON > 0) OR '+
        'LOCATE(FDO_CLAFIS,' + CLAFIS_BR + ')) ');

    If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
      qryItens.Sql.Add('   AND FDO_PROEMB <> "S" ');

    qryItens.Sql.Add('   AND RIGHT(FDO_CLAFIS, 3) <> "999" ');

    If fCfgSis('CLBUEF',varboolean) Then
      qryItens.Sql.Add('   AND FDO_CLIBUS = "N" ');

    qryItens.Sql.Add(' UNION ALL ');

    qryItens.Sql.Add(' SELECT  ' + fSQLQuantidadeRestanteItem('DET', 'MOVDET') + ' AS QTDSEP, ');
    qryItens.Sql.Add('   DET_SERIE_ AS SERIE_, ');
    qryItens.Sql.Add('   MOVDET.AUTOINCREM AS AUTINC, ');
    qryItens.Sql.Add('   DET_NUMDOC AS NUMDOC, ');
    qryItens.Sql.Add('   DET_ESPDOC AS ESPDOC, ');
    qryItens.Sql.Add('   DET_CODEMP AS CODEMP, ');
    qryItens.Sql.Add('   DET_CODITE AS CODITE  ');
    qryItens.Sql.Add(' FROM ');
    qryItens.Sql.Add('   MOVDET ');
    qryItens.Sql.Add('   LEFT JOIN MOVTRI ');
    qryItens.Sql.Add('     ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ');
    qryItens.Sql.Add(' WHERE DET_NUMDOC = :NUMDOC ');
    qryItens.Sql.Add('   AND DET_ESPDOC = :ESPDOC ');
    qryItens.Sql.Add('   AND DET_CODEMP = :CODEMP ');
    qryItens.Sql.Add('   AND IFNULL(DET_SERIE_, "") = :SERIE_ ');
    qryItens.Sql.Add('   AND DET_CODITE <> :ITESER ');
    qryItens.Sql.Add('   AND DET_CODITE <> :SERTER ');
    qryItens.Sql.Add('   AND DET_ENTFUT <> "S" ');

    If (fCfgSis('OPROSE', varString) = '2') Then
    Begin
      qryItens.Sql.Add('   AND DET_CLAFIS >= 5000 ');
      qryItens.Sql.Add('   AND (LOCATE(DET_CLAFIS, '+ QuotedStr(strClaVenLoc) + ') > 0) ');
    End;

    If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
      qryItens.Sql.Add('   AND DET_PROEMB <> "S" ');

    qryItens.Sql.Add('   AND RIGHT(DET_CLAFIS, 3) <> "999" ');

    If fCfgSis('CLBUEF',varboolean) Then
      qryItens.Sql.Add('   AND DET_CLIBUS = "N" ');

    qryItens.ParamByName('NUMDOC').AsString := cdsDocume.FieldByName('NUMDOC').AsString;
    qryItens.ParamByName('ESPDOC').AsString := cdsDocume.FieldByName('ESPDOC').AsString;
    qryItens.ParamByName('CODEMP').AsString := cdsDocume.FieldByName('CODEMP').AsString;
    qryItens.ParamByName('SERIE_').AsString := cdsDocume.FieldByName('SERIE_').AsString;
    qryItens.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryItens.ParamByName('SERTER').AsString := fCfgSis('SERTER');

    qryItens.Open;

    if qryItens.IsEmpty then
      Exit;

    qryItens.First;

    cdsItensSepPar.DisableControls;
    try
      while not qryItens.Eof do
      begin
        if (strMarDes = 'M') and
           (cdsItensSepPar.Locate('NUMDOC;ESPDOC;CODEMP;SERIE_;AUTINC',
            VarArrayOf([qryItens.FieldByName('NUMDOC').AsString,
                        qryItens.FieldByName('ESPDOC').AsString,
                        qryItens.FieldByName('CODEMP').AsString,
                        qryItens.FieldByName('SERIE_').AsString,
                        qryItens.FieldByName('AUTINC').AsString]), [])) Then
        begin
          if (cdsItensSepPar.FieldByName('QTDSEP').AsFloat > fRetSaldoDisponivelItemDoc(cdsItensSepPar.FieldByName('CODITE').AsString, cdsItensSepPar.FieldByName('CODEMP').AsString)) then
          begin
            Result := 1;
            Exit;
          end;
        end
        else
        begin
          if (qryItens.FieldByName('QTDSEP').AsFloat > fRetSaldoDisponivelItemDoc(qryItens.FieldByName('CODITE').AsString, qryItens.FieldByName('CODEMP').AsString)) then
          begin
            Result := 1;
            Exit;
          end;
        end;
        qryItens.Next;
      end;
    finally
      cdsItensSepPar.EnableControls;
    end;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmFatRomaneioLoteSeparacao.fRetSaldoDisponivelItemDoc(strCodIte,
  strCodEmp: string): Double;
var
  fltSaldos, fltCnvML, fltSalML: Double;
  recSaldos, recSaldosML: TRecSaldos;
  objSalLoj: TSaldoLojas;
begin
  objSalLoj := TSaldoLojas.Create(Self);

  try
    pBuscaInfSaldos(fltSaldos, fltCnvML, fltSalML, strCodIte, strCodEmp);

    if fltCnvML > 0 then
    begin
      fltSaldos := fltSaldos + fltSalML;
    end;

    objSalLoj.pCalculaSaldos(Nil,
                             recSaldos, recSaldosML,
                             fltSaldos, VS_strCodEmp, strCodEmp,
                             strCodIte, fltCnvML,
                             fCfgSis('ENTFUT', varBoolean), False, fCfgSis('ORDPRO', varBoolean), fCfgSis('CALSAL', varInteger));

    Result := recSaldos.fltSalDis;
  finally
    FreeAndNil(objSalLoj);
  end;
end;

function TfrmFatRomaneioLoteSeparacao.fRetTrava: String;
begin
  Result := cdsDocume.FieldByName('TABELA').AsString +
            cdsDocume.FieldByName('NUMDOC').AsString +
            cdsDocume.FieldByName('ESPDOC').AsString +
            cdsDocume.FieldByName('CODEMP').AsString;
end;

function TfrmFatRomaneioLoteSeparacao.fValidaLotesAbertos: Boolean;
var
  strSql: String;
  strSeqFdo: String;
  strSeqDet: String;
  qrySelect: TUniQuery;
  prcScroll: TprcScroll;
begin
  Result := True;
  FstrBaixarROMLIT := '';

  strSeqFdo := '';
  strSeqDet := '';

  strSql := '';
  strSql := strSql + 'SELECT ROMLIT.AUTOINCREM ';
  strSql := strSql + '  FROM ROMLIT ';
  strSql := strSql + ' INNER JOIN ROMLDE ON ROMLDE.AUTOINCREM = RLI_SEQRLD ';
  strSql := strSql + ' INNER JOIN ROMLGE ON ROMLGE.AUTOINCREM = RLD_SEQRLG ';
  strSql := strSql + 'WHERE RLI_JAFATU = 0 ';

  pDisableControls(cdsDocume, prcScroll);
  cdsDocume.First;
  try
    while not cdsDocume.Eof do
    begin

      Try
        cdsItensSepPar.Filtered := False;
        cdsItensSepPar.Filter   := 'NUMDOC = ' + cdsDocume.FieldByName('NUMDOC').AsString.QuotedString + ' AND ' +
                                   'ESPDOC = ' + cdsDocume.FieldByName('ESPDOC').AsString.QuotedString + ' AND ' +
                                   'CODEMP = ' + cdsDocume.FieldByName('CODEMP').AsString.QuotedString + ' AND ' +
                                   'SERIE_ = ' + cdsDocume.FieldByName('SERIE_').AsString.QuotedString;
        cdsItensSepPar.Filtered := True;

        cdsItensSepPar.First;

        While Not cdsItensSepPar.Eof Do
        Begin
          If cdsItensSepPar.FieldByName('TABELA').AsString = 'FATDOR' Then
            strSeqFdo := strSeqFdo + cdsItensSepPar.FieldByName('AUTINC').AsString.QuotedString + ','
          Else
            strSeqDet := strSeqDet + cdsItensSepPar.FieldByName('AUTINC').AsString.QuotedString + ',';

          cdsItensSepPar.Next;
        End;

      Finally
        cdsItensSepPar.Filtered := False;
      End;

      cdsDocume.Next;
    end;
  finally
    cdsDocume.First;
    pEnableControls(cdsDocume, prcScroll);
    pAfterScrollDoc(cdsDocume);
  end;

  if not fEmptyStr(strSeqFdo) then
  begin
    Delete(strSeqFdo, Length(strSeqFdo), 1);
    strSql := strSql + '  AND RLI_SEQFDO IN (' + strSeqFdo + ')';
  end;

  if not fEmptyStr(strSeqDet) then
  begin
    Delete(strSeqDet, Length(strSeqDet), 1);
    strSql := strSql + '  AND RLI_SEQDET IN (' + strSeqDet + ')';
  end;

  if not fEmptyStr(edtNumLot.Text) then
    strSql := strSql + '  AND RLG_NUMLOT <> ' + QuotedStr(edtNumLot.Text);

  qrySelect := fCriaQuery;
  try
    qrySelect.SQL.Text := strSql;
    qrySelect.Open;

    if not fEmptyStr(qrySelect.Fields[0].AsString) then
    begin
      Result := (fMensagem('', 'Existem lotes em aberto para um ou mais itens dos documentos selecionados. ' +
      'Ao gerar um novo lote, o lote em aberto será baixado. Deseja realmente prosseguir?', ['&Sim', '&Não'], 2) = 1);
    end;

    while not qrySelect.Eof do
    begin
      FstrBaixarROMLIT := FstrBaixarROMLIT + QuotedStr(qrySelect.Fields[0].AsString) + ',';
      qrySelect.Next;
    end;

    if not fEmptyStr(FstrBaixarROMLIT) then
      Delete(FstrBaixarROMLIT, Length(FstrBaixarROMLIT), 1);
  finally
    FreeAndNil(qrySelect);
  end;
end;

procedure TfrmFatRomaneioLoteSeparacao.pExibeProdutosPedidosSelecinados(
  strPedido: String; strEspecieDoc : String; strEmpresa : String);
var
  qryConsulta : TUniQuery;
  intContador : Integer;
  strNomeCampo : String;
  frmFatRomaneioLoteSeparacaoProdutosPedido : TfrmFatRomaneioLoteSeparacaoProdutosPedido;

begin
  inherited;
  If (not cdsDocume.Active) Or (cdsDocume.IsEmpty) Then
    Exit;

  Try
    qryConsulta := fCriaQuery(Self);

    pCriarFormularios(TfrmFatRomaneioLoteSeparacaoProdutosPedido, frmFatRomaneioLoteSeparacaoProdutosPedido);

    pCloneDataSet(frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido, cdsDocume);

    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Filtered := False;

    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Filter := 'MARDES = '+  QuotedStr('M');

    if (strPedido <> '') and (strEspecieDoc <> '') and (strEmpresa <> '') then
      frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Filter := 'NUMDOC = '+  QuotedStr(strPedido) +
                                                                       'and ESPDOC = '+ QuotedStr(strEspecieDoc)+
                                                                       'and CODEMP = '+ QuotedStr(strEmpresa);

    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Filtered := True;
    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.First;

    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Close;
    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.CreateDataSet;

    qryConsulta.Sql.Clear;
    qryConsulta.Sql.Text :=  'SELECT                                              '
                           + 'FD.FDO_CODITE as CODITE,                            '
                           + 'CI.ITE_FABRIC as FABRIC,                            '
                           + 'CI.ITE_CODBAR as CODBAR,                            '
                           + 'FD.FDO_DESCRI as DESCRI,                            '
                           + 'FD.FDO_UNIDAD as UNIDAD,                            '
                           + 'FD.FDO_NUMLOT as NUMLOT,                            '
                           + 'CI.ITE_REFERE as REFERE,                            '
                           + 'CM.MAR_DESMAR as DESMAR,                            '
                           + 'FD.FDO_QTDITE as QTDITE,                            '
                           + 'FD.FDO_TOTPES as TOTPES,                            '
                           + 'CONCAT(FD.FDO_CODVEN, "-", CO.OPE_NOMOPE) AS VENDED '
                           + 'FROM                                                '
                           + 'FATGOR FG                                           '
                           + 'LEFT JOIN FATDOR FD                                 '
                           + 'ON FD.FDO_SEQGER = FG.AUTOINCREM                    '
                           + 'LEFT JOIN CADITE CI                                 '
                           + 'ON CI.ITE_CODITE = FD.FDO_CODITE                    '
                           + 'LEFT JOIN CADMAR CM                                 '
                           + 'ON CM.MAR_CODMAR = FD.FDO_CODMAR                    '
                           + 'LEFT JOIN CADOPE CO                                 '
                           + 'ON CO.OPE_CODOPE = FD.FDO_CODVEN                    '
                           + 'WHERE FD.FDO_NUMDOC = :NUMDOC                       '
                           + 'AND FD.FDO_ESPDOC= :ESPDOC                          '
                           + 'AND FD.FDO_CODEMP = :CODEMP                         ';

    while not frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Eof do
    begin
      qryConsulta.Close;
      qryConsulta.ParamByName('NUMDOC').AsString := frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.FieldByName('NUMDOC').AsString;
      qryConsulta.ParamByName('ESPDOC').AsString := frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.FieldByName('ESPDOC').AsString;
      qryConsulta.ParamByName('CODEMP').AsString := frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.FieldByName('CODEMP').AsString;
      qryConsulta.Open;

      qryConsulta.First;
      while not qryConsulta.Eof do
      begin
        frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Filtered := False;

        frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Filter :=
          'CODITE = '+ QuotedStr(qryConsulta.FieldByName('CODITE').AsString)+
          ' and NUMLOT = '+ QuotedStr(qryConsulta.FieldByName('NUMLOT').AsString)+
          ' and VENDED = '+ QuotedStr(qryConsulta.FieldByName('VENDED').AsString);

        frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Filtered := True;

        if frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.RecordCount > 0 then
        begin
          frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Edit;

          frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldByName('QTDITE').AsFloat :=
            frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldByName('QTDITE').AsFloat +
            qryConsulta.FieldByName('QTDITE').AsFloat;

          frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldByName('TOTPES').AsFloat :=
            frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldByName('TOTPES').AsFloat +
            qryConsulta.FieldByName('TOTPES').AsFloat;

          frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Post;
          qryConsulta.Next;
          Continue
        end;

        strNomeCampo := '';
        frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Insert;
        for intContador := 0 to frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldDefs.Count - 1 do
        begin
          strNomeCampo := frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldDefs[intContador].Name;
          frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.FieldByName(strNomeCampo).Value := qryConsulta.FieldByName(strNomeCampo).Value;
        end;

        frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Post;
        qryConsulta.Next;
      end;

      frmFatRomaneioLoteSeparacaoProdutosPedido.cdsMovPedido.Next;
    end;

    frmFatRomaneioLoteSeparacaoProdutosPedido.cdsProdutosPedido.Filtered := False;
    frmFatRomaneioLoteSeparacaoProdutosPedido.cxgProdutosTableView.ApplyBestFit;


    frmFatRomaneioLoteSeparacaoProdutosPedido.ShowModal;
  Finally
    pFreeAndNil(frmFatRomaneioLoteSeparacaoProdutosPedido);
    FreeAndNil(qryConsulta);
  end;

end;

end.
