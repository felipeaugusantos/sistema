
{***************************************************************}
{* TELA DO PAINEL CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{************************************************************JU*}
unit untPnlDadosItemAntigo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DBMemoFocus, Mask, DBEditFocus, Buttons,
  EditFocus, UniClientDataSet, DB, Uni, ActnList, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxColorComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, untLegendasItem, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, untZClient, cxNavigator, untTypesSistema, untFuncoesSimples,
  untClassPanelCx, cxGridDBTableView, cxGridCitel,
  untGerenciaPropriedadesComponentes, cxProgressBar, Vcl.Menus, cxContainer, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  cxInplaceContainer, cxVGrid, cxCurrencyEdit, cxTextEdit, untSaldoLojas,
  untPnlDadosItem, MemoFocus, System.Math, untVisualizarAplicacaoProduto,
  untRelacSimilaridade, untCadArmazem, untCadLoteItens, Winapi.RichEdit;

type
  TfrmPnlDadosItemAntigo = class(TfrmPnlDadosItem)
    pnlDadosItem: TPanel;
    dtsConsulta: TDataSource;
    popAtalhos: TPopupMenu;
    mnuAgregados: TMenuItem;
    mnuReqCompra: TMenuItem;
    cxsGrid: TcxStyleRepository;
    cxsSaldos: TcxStyle;
    cxsSaldosDisponivel: TcxStyle;
    pnlRodape: TPanel;
    pgcSaldos: TPageControl;
    tbsSaldos: TTabSheet;
    cxvSaldos: TcxVerticalGrid;
    cxvEstFisico: TcxEditorRow;
    cxvGarantia: TcxEditorRow;
    cxvPedidoVenda: TcxEditorRow;
    cxvEnderecamento: TcxEditorRow;
    cxvOrdemProducao: TcxEditorRow;
    cxvEntFutPrevisao: TcxEditorRow;
    cxvEntFutFalta: TcxEditorRow;
    cxvEntFutAguarda: TcxEditorRow;
    cxvDisponivel: TcxEditorRow;
    cxvSalDisMenosEntFut: TcxEditorRow;
    cxvPedidoCompra: TcxEditorRow;
    lblIteAti: TLabel;
    pnlImgPro: TPanel;
    imgPro: TImage;
    lblErrImg: TLabel;
    GroupBox2: TGroupBox;
    lblPreCus: TLabel;
    lblUltVen: TLabel;
    lblPreBoca: TLabel;
    lblComBoca: TLabel;
    dbePreVen: TDBEditFocus;
    dbeUltVen: TDBEditFocus;
    edtPrecoBoca: TEditFocus;
    edtComBoca: TEditFocus;
    lblLocFis: TLabel;
    dbeLocFis: TDBEditFocus;
    Label1: TLabel;
    dbeLocSup: TDBEditFocus;
    lblLegendas: TLabel;
    lblIteEmb: TLabel;
    pnlMetragem: TPanel;
    lblQtdPec: TLabel;
    lblComPec: TLabel;
    lblLarPec: TLabel;
    lblEspPec: TLabel;
    btnMetragem: TBitBtnLocked;
    cxgIteEmb: TcxGridCitel;
    cxgIteEmbTableView: TcxGridDBTableViewCitel;
    cxgIteEmbTableViewQTDEMB: TcxGridDBColumn;
    cxgIteEmbTableViewDESCON: TcxGridDBColumn;
    cxgIteEmbTableViewTABPRE: TcxGridDBColumn;
    cxgIteEmbTableViewUNITAR: TcxGridDBColumn;
    cxgIteEmbLevel: TcxGridLevel;
    btnTranEst: TBitBtnLocked;
    btnVendasPerdidas: TBitBtnLocked;
    btnEmbalagem: TBitBtnLocked;
    btnExecutaTarefa: TBitBtnLocked;
    btnItensVend: TBitBtnLocked;
    btnConsVendasPerdidas: TBitBtnLocked;
    btnExiEstrutura: TBitBtnLocked;
    btnEntregasPendentes: TBitBtnLocked;
    btnItensComp: TBitBtnLocked;
    btnMostraPrecoVenda: TBitBtnLocked;
    btnMostraEstoque: TBitBtnLocked;
    btnPedComp: TBitBtnLocked;
    btnSepIte: TBitBtnLocked;
    btnPedSalRes: TBitBtnLocked;
    btnPedCompGrid: TBitBtnLocked;
    btnLotIte: TBitBtnLocked;
    btnComSisAnt: TBitBtnLocked;
    btnVedasSisAnt: TBitBtnLocked;
    btnAtalhos: TBitBtnLocked;
    btnFichaKardex: TBitBtnLocked;
    btnSemelhantes: TBitBtnLocked;
    btnSimilares: TBitBtnLocked;
    lblTmpGar: TLabel;
    dbeTmpGar: TDBEditFocus;
    lblInfGar: TLabel;
    dbeInfGar: TDBEditFocus;
    tbsSaldosML: TTabSheet;
    cxvSaldosML: TcxVerticalGrid;
    cxvEstFisicoML: TcxEditorRow;
    cxvGarantiaML: TcxEditorRow;
    cxvPedidoVendaML: TcxEditorRow;
    cxvEnderecamentoML: TcxEditorRow;
    cxvOrdemProducaoML: TcxEditorRow;
    cxvEntFutPrevisaoML: TcxEditorRow;
    cxvEntFutFaltaML: TcxEditorRow;
    cxvEntFutAguardaML: TcxEditorRow;
    cxvDisponivelML: TcxEditorRow;
    cxvSalDisMenosEntFutML: TcxEditorRow;
    cxvPedidoCompraML: TcxEditorRow;
    cxsSaldosML: TcxStyle;
    cxsSaldosCD: TcxStyle;
    cxsSaldosCDML: TcxStyle;
    cxsSaldosMLDisponivel: TcxStyle;
    cxsSaldosCDDisponivel: TcxStyle;
    cxsSaldosCDMLDisponivel: TcxStyle;
    cxsValorDisponivel: TcxStyle;
    btnImgSite: TMenuItem;
    pnlPrePromoc: TPanel;
    lblValPro: TLabel;
    lblMinPro: TLabel;
    lblLimPro: TLabel;
    lblDispPro: TLabel;
    edtValPro: TEditFocus;
    edtMinPro: TEditFocus;
    edtLimPro: TEditFocus;
    edtDispPro: TEditFocus;
    lblDesPro: TcxLabel;
    btnOrcamentos: TBitBtnLocked;
    btnSimilaresOrcPed: TBitBtnLocked;
    cxvExterno: TcxEditorRow;
    cxvExternoML: TcxEditorRow;
    cxvPedidoBaixaEntregaFutura: TcxEditorRow;
    cxvPedidoBaixaEntregaFuturaML: TcxEditorRow;
    MemProBrin: TMemoFocus;
    pnlAplicacao: TPanel;
    pnlAplic: TPanel;
    Panel1: TPanel;
    DBAplica: TDBRichEdit;
    pnlMsgLivre: TPanel;
    Panel2: TPanel;
    dbeMSGLIV: TDBMemoFocus;
    cxvPedidoCompraLoja: TcxEditorRow;
    lblExpandirAplicacao: TLabel;
    cxvTransfEstAndamentoAgFat: TcxEditorRow;
    cxvTransfEstAndamentoAgEnt: TcxEditorRow;
    btnCadArmazem: TBitBtnLocked;
    btnCadSimilaridade: TBitBtnLocked;
    btnChkLstDevGar: TBitBtnLocked;
    ppmGarantia: TPopupMenu;
    ChecklistdeGarantiadeMercadorias1: TMenuItem;
    ChecklistdeTrocadeMercadorias1: TMenuItem;
    mnuEstVendaForaEstab: TMenuItem;
    popImgPro: TPopupMenu;
    mnuEnviarporWhatsapp: TMenuItem;
    mnuNotasFiscaisAssociadasEmAberto: TMenuItem;
    btnRedeAncora: TBitBtnLocked;
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure pMostraEstoqueLojas;
    procedure btnPedSalResClick(Sender: TObject);
    procedure btnSimilaresClick(Sender: TObject);
    procedure btnItensVendClick(Sender: TObject);
    procedure btnItensCompClick(Sender: TObject);
    procedure btnPedCompClick(Sender: TObject);
    procedure btnEntregasPendentesClick(Sender: TObject);
    procedure btnSemelhantesClick(Sender: TObject);
    procedure btnLotIteClick(Sender: TObject);
    procedure btnPedCompGridClick(Sender: TObject);
    procedure btnExecutaTarefaClick(Sender: TObject);
    procedure btnSepIteClick(Sender: TObject);
    procedure btnEmbalagemClick(Sender: TObject);
    procedure btnExiEstruturaClick(Sender: TObject);
    procedure btnMostraPrecoVendaClick(Sender: TObject);
    procedure btnVendasPerdidasClick(Sender: TObject);
    procedure btnMetragemClick(Sender: TObject);
    procedure lblLegendasClick(Sender: TObject);
    procedure btnConsVendasPerdidasClick(Sender: TObject);
    procedure btnOrcamentosClick(Sender: TObject);
    procedure btnTranEstClick(Sender: TObject);
    procedure tmrAtualizarDadosTimer(Sender: TObject);
    procedure mnuAgregadosClick(Sender: TObject);
    procedure btnAtalhosClick(Sender: TObject);
    procedure mnuReqCompraClick(Sender: TObject);
    procedure btnComSisAntClick(Sender: TObject);
    procedure btnVedasSisAntClick(Sender: TObject);
    procedure imgProDblClick(Sender: TObject);
    procedure btnFichaKardexClick(Sender: TObject);
    procedure btnImgSiteClick(Sender: TObject);
    procedure btnSimilaresOrcPedClick(Sender: TObject);
    procedure pgcSaldosEnter(Sender: TObject);
    procedure pgcSaldosExit(Sender: TObject);
    procedure cxvSaldosEnter(Sender: TObject);
    procedure cxvSaldosExit(Sender: TObject);
    procedure cxvSaldosMLExit(Sender: TObject);
    procedure cxvSaldosMLEnter(Sender: TObject);
    procedure cxgIteEmbEnter(Sender: TObject);
    procedure cxgIteEmbExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblExpandirAplicacaoClick(Sender: TObject);
    procedure btnCadSimilaridadeClick(Sender: TObject);
    procedure btnCadArmazemClick(Sender: TObject);
    procedure ChecklistdeGarantiadeMercadorias1Click(Sender: TObject);
    procedure ChecklistdeTrocadeMercadorias1Click(Sender: TObject);
    procedure btnChkLstDevGarClick(Sender: TObject);
    procedure mnuEstVendaForaEstabClick(Sender: TObject);
    procedure mnuEnviarporWhatsappClick(Sender: TObject);
    procedure mnuNotasFiscaisAssociadasEmAbertoClick(Sender: TObject);
  private
    { Private declarations }
    blnOrcPen,
    blnNaoTecla : Boolean;
    bnlLigaScroll: Boolean;
    blnOrdPro,
    blnUsaPDV,
    blnEntFut,
    blnImgPro,
    blnEstExt,
    blnHabF7 : Boolean;
    strSUGVLE,
    strComBca: String;
    blnEnterSim: Boolean;
    strAutIncSim: String;
    objGerenciaRodape : TGerenciaPropriedadesComponentes;
    blnSalvar_lblAplicacao: Boolean;

    objSalLoj: TSaldoLojas;

    recSaldos,
    recSaldosML: TRecSaldos;

    strPDCPRO: String;
    blnBefTrg,
    blnUtilizaVendaMadeira : Boolean;
    fltQtdMt3 : Double;

    cdsIteEmb : TZClient;

    intIdxCol,
    intCalSal: Integer;

    cdsLegendas: TLegendasItem;
    FQtdPec: Double;
    FLarPec: Double;
    FComPec: Double;
    FEspPec: Double;
    blnUtilizaCheckListGarantia: Boolean;

    function tmrAtualizarDados: TNewTimer;

    procedure pHabilitaTeclas(blnTravar: Boolean);

    procedure pLimpaCamposSemSQL;

    procedure pAtualizaLabelMetragem;
    procedure SetComPec(const Value: Double);
    procedure SetEspPec(const Value: Double);
    procedure SetLarPec(const Value: Double);
    procedure SetQtdPec(const Value: Double);

    procedure pMostraBotaoSalRes;
    procedure pMostraBotaoSimilares;
    procedure pMostraPrecoPromocional;
    procedure pMostraPrecoBoca;
    procedure pImprimeSeparacaoItem;
    procedure pEnviarParaVendasPerdidas;
    procedure pMostraBotaoEstrutura;
    procedure pAtualizaDados;
    procedure pLimpaDados;
    procedure pEscreveAtualizando;

    procedure pInicialializaTelaSaldoss;

    procedure pMostraAtualizandoSaldos(cxvSaldos: TcxVerticalGrid; strMensagem: String = 'Atualizando...');

    Procedure pCarregaSaldos;

    procedure pSetVisible(cxg: TcxEditorRow; bln: Boolean);
    procedure pSetIndex(cxg: TcxEditorRow); overload;
    procedure pSetIndex(cxg: TcxEditorRow; const intIdx : Integer); overload;
    procedure pOrdemInicial;

    function fExisteSemelhantes(strCodIte: String): Boolean;
    procedure pAbreIteEmb;
    procedure pDestacaCorDeFonteFiltroAplicacao;

    function fGetSQLIteEmb: String;
    function fMostrarOrcPedProdSimilar(pgbStatus: TcxProgressBar = nil): Boolean;

    Function fValidaCampos(arrCampo: Array Of String): Boolean;

    function MyPos(stringtofind, stringtosearch: string; CaseInsensitive:boolean = true): integer;
    procedure TrocarCorPalavra(oRichEdit : TDBRichEdit; sText : String; Color, bkpColor: TColor);


    procedure pSetUtilizaCheckListGarantia(Value: Boolean);

  public
    { Public declarations }

    procedure pResetatmrAtualizarDados; override;
    procedure pOnDisplayText(Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord; var AText: string); override;
    procedure pSetPnlDadosItemVisible(AVisible: Boolean); override;
    procedure pAtualizarAplicacao; override;

    procedure pIniciouNavegacaoGridConsulta; override;
    procedure pParouNavegacaoGridConsulta; override;

   Published
     Property fltComPec : Double Read FComPec Write SetComPec;
     Property fltLarPec : Double Read FLarPec Write SetLarPec;
     Property fltEspPec : Double Read FEspPec Write SetEspPec;
     Property fltQtdPec : Double Read FQtdPec Write SetQtdPec;
  end;

implementation

uses  untFatMostraProdSimilar, untConstantes,
      untFatMostraPedSalRes, untFatMostraEstoqueEmp,
      untFuncoesRel, untFuncoesRel2, TypesRel,
      untCadProdutosCompCusto,
      untCadPro, untCadProFoto,
      untModuloFatImp, untCfgRel, StrUtils, untRelFatVendasCliente,
      untIteBar, untMostraEstruturas,
      untGetMetragem, untMostraLegendasItem,
      untControleSepAvulsa, untConsultaOrcPesqItem,
      untGravando, untCadProFotoURL, untFuncoesImagem,
      untFatConsVendasAntigas, untImagens, untIFatReservaSaldo,
      untTFatReservaSaldo, untIFatEntregaFutura, untTFatEntregaFutura, untRelEstPedCompraGrid,
      untController.CheckListGarantia, untFuncoes,
  untCfgHabilitaConsultaCotacaoAPIBalcao;

{$R *.dfm}

Function TfrmPnlDadosItemAntigo.fValidaCampos(arrCampo: Array Of String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := Low(arrCampo) To High(arrCampo) Do
    If Not Assigned(cdsConsulta.FindField(arrCampo[intContador])) Then
    Begin
      Result := False;
      Exit;
    End;
End;

procedure TfrmPnlDadosItemAntigo.mnuAgregadosClick(Sender: TObject);
begin
  If Not mnuAgregados.Visible Then
    Exit;

  If Not Assigned(procExibeAgregados) Then
    Exit;

  If (cdsConsulta.FindField('AGR_CODAGR') <> Nil) And
     (Not fEmptyStr(cdsConsulta.FieldByName('AGR_CODAGR').AsString)) Then
    procExibeAgregados(cdsConsulta.FieldByName('AGR_CODAGR').AsString, strTabPre, blnFaturamento);
end;

procedure TfrmPnlDadosItemAntigo.mnuEnviarporWhatsappClick(Sender: TObject);
var
  recImagem: TArray<TRecArquivosGatilhos>;
begin
  inherited;

  if cdsConsulta.IsEmpty then
    Exit;

  SetLength(recImagem, 1);
  recImagem[0] := TRecArquivosGatilhos.Create('IMAGEM PRODUTO_'+cdsConsulta.FieldByName('ITE_CODITE').AsString+'-'+Copy(fRetNomProduto(cdsConsulta.FieldByName('ITE_CODITE').AsString),1,10),
                                              fCampoTabela('ITE_IMGB64',
                                                           'ITEIMG',
                                                           ['ITE_CODITE', 'ITE_PRINCI'],
                                                           [cdsConsulta.FieldByName('ITE_CODITE').AsString, 'S']),
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
                                cdsConsulta.FieldByName('ITE_CODITE').AsString) then
    fMensagem('', 'Whatsapp enviado com sucesso!', ['&Ok'])
  else
    fMensagem('', 'Whatsapp não enviado!', ['&Ok']);
end;

procedure TfrmPnlDadosItemAntigo.mnuEstVendaForaEstabClick(Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(387, 17937,
                         [17937],
                         ['CODEMP','CODITE'],
                         [VS_strCodEmp, cdsConsulta.FieldByName('ITE_CODITE').AsString],
                         Sender,
                         Nil,
                         True);
end;

procedure TfrmPnlDadosItemAntigo.mnuNotasFiscaisAssociadasEmAbertoClick(
  Sender: TObject);
begin
  If cdsConsulta.IsEmpty Then
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
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                        Sender,
                        ['CODITE'],
                        False);
end;

procedure TfrmPnlDadosItemAntigo.mnuReqCompraClick(Sender: TObject);
begin
  If Not mnuReqCompra.Visible Then
    Exit;

  If Not Assigned(procExibeRequisicaoCompra) Then
    Exit;

  If fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
     procExibeRequisicaoCompra(cdsConsulta.FieldByName('ITE_CODITE').AsString,
                               cdsConsulta.FieldByName('ITE_DESITE').AsString);

end;

procedure TfrmPnlDadosItemAntigo.btnCadArmazemClick(Sender: TObject);
begin
  pCriarForm(TfrmCadLoteItens);
end;

procedure TfrmPnlDadosItemAntigo.btnCadSimilaridadeClick(Sender: TObject);
begin
  Try
    pCriarFormularios(TfrmRelacSimilaridade, frmRelacSimilaridade);
    frmRelacSimilaridade.edtCodIte.Text:= cdsConsulta.FieldByName('ITE_CODITE').AsString;
    frmRelacSimilaridade.ShowModal;
  Finally
    FreeAndNil(frmRelacSimilaridade);
  End;
end;

procedure TfrmPnlDadosItemAntigo.btnChkLstDevGarClick(Sender: TObject);
  Var
    intposY, intPosX: Integer;
    objWinControl: TWinControl;
    blnContinuar: Boolean;
begin

  objWinControl := TWinControl(Sender);
  intPosX := objWinControl.Parent.Left + objWinControl.Left+objWinControl.Width+ 10;

  intPosY := 0;
  Repeat
    intPosY := IntPosY + objWinControl.Top;
    blnContinuar := Assigned(objWinControl.Parent) and (objWinControl is TWinControl);
    if blnContinuar then
      objWinControl := objWinControl.Parent
    else begin
      if Assigned(Self.Owner) and  (Self.Owner is TWinControl) then
      begin
        objWinControl :=  TWinControl(Self.Owner);
        blnContinuar := True;
      end;
    end;


  Until Not blnContinuar;

  ppmGarantia.Popup(intPosX, intPosY);

end;

procedure TfrmPnlDadosItemAntigo.btnComSisAntClick(Sender: TObject);
begin
  If Not btnComSisAnt.Visible Then
    Exit;

  If fValidaCampos(['ITE_CODITE']) Then
    TfrmFatConsVendasAntigas.pMostraComprasAntigas(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemAntigo.btnConsVendasPerdidasClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If btnConsVendasPerdidas.Visible   And
     Assigned(procRelVendasPerdidas) Then
  Begin
    If Not fVerificaAcessoSistema('CPVEPE', strLoginUsuarioLogado) Then
    Begin
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
      Exit;
    End;

    procRelVendasPerdidas(strCodCli, cdsConsulta.FieldByName('ITE_CODITE').AsString);
  End;
end;

procedure TfrmPnlDadosItemAntigo.btnEmbalagemClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  TIteBar.pEmbalagem(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemAntigo.btnEntregasPendentesClick(Sender: TObject);
begin

  If Not fVerificaAcessoSistema('CPENTP', strLoginUsuarioLogado) Then
  begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  end;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE', 'ITE_SALDOS']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(197, 7534, [],
                        ['CODITE','CODEMP','SALDOS','FATURA'],
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString,
                        strEmpSal,
                        FloatToStr(cdsConsulta.FieldByName('ITE_SALDOS').AsFloat),
                        IfThen(blnFaturamento,'S','N')],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnExecutaTarefaClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    TfrmCadProdutosCompCusto.pMostraComposicaoPrecoCusto(cdsConsulta.FieldByName('ITE_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
end;

procedure TfrmPnlDadosItemAntigo.btnExiEstruturaClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPEXTR', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not btnExiEstrutura.Visible Then
    Exit;

  pMostraEstrutura(cdsConsulta.FieldByName('ITE_CODITE').AsString, strEmpSal, True, blnPedCorte, True, False);
end;

procedure TfrmPnlDadosItemAntigo.btnFichaKardexClick(Sender: TObject);
begin
   If cdsConsulta.IsEmpty Then
     Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
     prcExecutaRelatorio(34, 2951, [2951,2958],
                        ['CODEMP','CODITE'],
                        [VS_STRCODEMP,cdsConsulta.FieldByName('ITE_CODITE').AsString],
                        Sender, Nil, False, True, 'frmRelEstKardex');
end;

procedure TfrmPnlDadosItemAntigo.btnImgSiteClick(Sender: TObject);
begin
  If Not btnImgSite.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('VIMASIT') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso "Visualizar Imagem Site [ Alt + F9 ] - Consulta de Produtos"!', ['&OK']);
    Exit;
  End;

  pExibirImagemProdutoSite(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemAntigo.btnItensCompClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('ITECMP') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso aos Itens Comprados!', ['&O k']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(73, 5226, [],
                        ['CODITE','DESITE'],
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString,
                        cdsConsulta.FieldByName('ITE_DESITE').AsString],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnItensVendClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

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

    if fEmptyStr(cdsConsulta.FieldByName('ITE_CODITE').AsString) then
    begin
      fMensagem('', 'Atenção! Para gerar o relatório, escolha um produto no grid!', ['&O k']);
      Exit;
    end
    else
      TfrmRelFatVendasCliente.pMostraItensVendidos(cdsConsulta.FieldByName('ITE_CODITE').AsString, procMostraDocumentoReimpressao);
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnLotIteClick(Sender: TObject);
Begin

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPLOTI', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(207, 7616, [7719,7720,7721,7722],
                      ['CODITE'],
                      [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                      Sender,
                      ['CODITE'],
                      not fCfgSis('CNLOTD', VarBoolean));
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnSimilaresOrcPedClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODSIM']) Then
    Exit;

  If (btnSimilaresOrcPed.Visible) Then
  Begin
    If Not fVerificaAcessoSistema('CPSVOR', strLoginUsuarioLogado) Then
    Begin
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
      Exit;
    End;

    Try
      If (fEmptyStr(cdsConsulta.FieldByName('ITE_CODSIM').AsString)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há itens similares!', ['&Ok']);
        Exit;
      End
      Else
      Begin
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.fExecutarAcao := fMostrarOrcPedProdSimilar;
        frmGravando.lblGravando.Caption := 'Aguarde... Carregando similares.';
        frmGravando.ShowModal;
      End;
    Except
      pFreeAndNil(frmGravando);
    End;
  End;
  pDestacaCorDeFonteFiltroAplicacao;
end;

procedure TfrmPnlDadosItemAntigo.btnAtalhosClick(Sender: TObject);
begin

  ShowPopupMenu(btnAtalhos, popAtalhos,  btnAtalhos.ClientOrigin.X, btnAtalhos.ClientOrigin.y);

end;

procedure TfrmPnlDadosItemAntigo.btnMetragemClick(Sender: TObject);
  Var
    fltComPecP, fltLarPecP, fltEspPecP, fltQtdPecP : Double;
begin
  inherited;
  If (Not btnMetragem.Visible) Or (Not pnlMetragem.Visible) Then
    Exit;

  If Not fVerificaAcessoSistema('CPMETR', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  fltComPecP := 1.00;
  fltLarPecP := 1.00;
  fltEspPecP := 1.00;
  fltQtdPecP := 1.00;

  fltQtdMt3 := TfrmGetMetragem.fGetQuantidadeTotal(dbePreVen.Field.AsFloat, fltComPecP, fltLarPecP, fltEspPecP, fltQtdPecP);

  fltComPec := fltComPecP;
  fltLarPec := fltLarPecP;
  fltEspPec := fltEspPecP;
  fltQtdPec := fltQtdPecP;
end;

procedure TfrmPnlDadosItemAntigo.btnMostraEstoqueClick(Sender: TObject);
begin
  If btnMostraEstoque.Visible Then
  Begin
    if (not fVerificaAcessoSistema('PVISPF')) then
    begin
      fMensagem('ATENÇÃO','Operador não possui acesso para visualizar informações de saldo de produtos no faturamento.',['&OK']);
      Exit;
    end;

    If Not fVerificaAcessoSistema('CPELOJ', strLoginUsuarioLogado) Then
      fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
    Else
      pMostraEstoqueLojas;
  End;
end;

procedure TfrmPnlDadosItemAntigo.btnMostraPrecoVendaClick(Sender: TObject);
begin

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  If Not fVerificaAcessoSistema('PREVEN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso.', ['&O k']);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(74, 5242, [],
                        ['CODITE'],
                        [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnOrcamentosClick(Sender: TObject);
begin
  If Not fVerificaAcessoSistema('CPORCA', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
    Exit;

  TfrmConsultaOrcPesqItem.pMostraOrcamento(cdsConsulta.FieldByName('ITE_CODITE').AsString,
                                           cdsConsulta.FieldByName('ITE_DESITE').AsString,
                                           procMostraDocumentoReimpressao);
end;

procedure TfrmPnlDadosItemAntigo.btnPedCompClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not btnPedComp.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('CPPECO', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If ( btnPedComp.Visible ) And Not(fEmptyStr(cdsConsulta.FieldByName('ITE_CODITE').AsString)) Then
  Begin
    If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(36, 2327, [2327, 2334],
                            ['CODITE'],
                            [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                            Sender);
  End;

end;

procedure TfrmPnlDadosItemAntigo.btnPedCompGridClick(Sender: TObject);
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

procedure TfrmPnlDadosItemAntigo.btnPedSalResClick(Sender: TObject);
Begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not  btnPedSalRes.Visible Then
    Exit;
  If Not fVerificaAcessoSistema('CPSARE', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
    TfrmFatMostraPedSalRes.pExibeDocsSaldosReservado(cdsConsulta.FieldByName('ITE_CODITE').AsString, strEmpSal, procMostraDocumentoReimpressao);
end;

procedure TfrmPnlDadosItemAntigo.btnSemelhantesClick(Sender: TObject);
begin
  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If Not btnSemelhantes.Visible  Then
    Exit;

  If Not fVerificaAcessoSistema('CPSEME', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  else
  begin
    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(64, 5044, [],
                            ['CODITE'],
                            [cdsConsulta.FieldByName('ITE_CODITE').AsString],
                            nil,
                            nil,
                            True);
    End;
  end;
end;

procedure TfrmPnlDadosItemAntigo.btnSepIteClick(Sender: TObject);
Begin
  If Not fVerificaAcessoSistema('CPSEIT', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  else
    pImprimeSeparacaoItem;
end;

procedure TfrmPnlDadosItemAntigo.btnSimilaresClick(Sender: TObject);
  Var
    strCodFab,
    strCodIte: String;
begin
  If Not btnSimilares.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE', 'ITE_CODSIM']) Then
    Exit;

  If Not fVerificaAcessoSistema('CPSIMI', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
  Begin
    If TfrmFatMostraProdSimilar.fMostraSimilar(cdsConsulta.FieldByName('ITE_CODSIM').AsString,
                                               cdsConsulta.FieldByName('ITE_CODITE').AsString,
                                               cdsConsulta.FieldByName('ITE_DESITE').AsString,
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

procedure TfrmPnlDadosItemAntigo.btnTranEstClick(Sender: TObject);
  Var
    strCodIte: String;
begin
  If Not fVerificaAcessoSistema('CPTREA', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);
    Exit;
  End;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  If cdsConsulta.Active And (cdsConsulta.Fields.FindField('ITE_CODITE') <> Nil) Then
    strCodIte := cdsConsulta.FieldByName('ITE_CODITE').AsString
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

procedure TfrmPnlDadosItemAntigo.btnVedasSisAntClick(Sender: TObject);
begin
  If Not btnVedasSisAnt.Visible Then
    Exit;

  If Not fValidaCampos(['ITE_CODITE']) Then
    Exit;

  TfrmFatConsVendasAntigas.pMostraVendasAntigas(cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemAntigo.btnVendasPerdidasClick(Sender: TObject);
begin
  If Not btnVendasPerdidas.Visible Then
    Exit;
  If Not fVerificaAcessoSistema('CPIVPE', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  else
    pEnviarParaVendasPerdidas;

end;

procedure TfrmPnlDadosItemAntigo.ChecklistdeGarantiadeMercadorias1Click(Sender: TObject);
begin
  inherited;
  TCheckListGarantiaController
    .pImprimirCheckListGarantiaMercadoriaItem(cdsConsulta.FieldByName('ITE_CODITE').AsString,'',False);
end;

procedure TfrmPnlDadosItemAntigo.ChecklistdeTrocadeMercadorias1Click(Sender: TObject);
begin
  inherited;
  TCheckListGarantiaController
    .pImprimirCheckListTrocaMercadoria(cdsConsulta.FieldByName('ITE_CODITE').AsString,'', False);
end;

procedure TfrmPnlDadosItemAntigo.cxgIteEmbEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemAntigo.cxgIteEmbExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemAntigo.cxvSaldosEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemAntigo.cxvSaldosExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemAntigo.cxvSaldosMLEnter(Sender: TObject);
begin
  pHabilitaTeclas(True);
end;

procedure TfrmPnlDadosItemAntigo.cxvSaldosMLExit(Sender: TObject);
begin
  pHabilitaTeclas(False);
end;

procedure TfrmPnlDadosItemAntigo.pMostraAtualizandoSaldos(cxvSaldos: TcxVerticalGrid; strMensagem: String = 'Atualizando...');
  Var
    intContador: Integer;
Begin
  For intContador := 0 To cxvSaldos.Rows.Count - 1 Do
    TcxEditorRow(cxvSaldos.Rows[intContador]).Properties.Value := strMensagem;
End;

procedure TfrmPnlDadosItemAntigo.pEscreveAtualizando;
begin
  If Not bnlLigaScroll Then
    Exit;

  If Not Self.Showing Then
    Exit;

  If Not cdsConsulta.Active then
    Exit;

  If cdsConsulta.IsEmpty then
    Exit;

  If TcxEditorRow(cxvSaldos.Rows[0]).Properties.Value = 'Atualizando...' Then
    Exit;

  pMostraAtualizandoSaldos(cxvSaldos);
  pMostraAtualizandoSaldos(cxvSaldosML);
  MemProBrin.Lines.Text := 'Atualizando...';

  imgPro.Visible := False;

  Application.ProcessMessages;
end;

procedure TfrmPnlDadosItemAntigo.pgcSaldosEnter(Sender: TObject);
begin
  bnlLigaScroll := False;
end;

procedure TfrmPnlDadosItemAntigo.pgcSaldosExit(Sender: TObject);
begin
  bnlLigaScroll := True;
end;

function TfrmPnlDadosItemAntigo.fExisteSemelhantes(strCodIte: String): Boolean;
Var
  qrySem: TUniQuery;
begin

  Result := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  qrySem := fCriaQuery;

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

procedure TfrmPnlDadosItemAntigo.SetComPec(const Value: Double);
begin
  FComPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmPnlDadosItemAntigo.SetEspPec(const Value: Double);
begin
  FEspPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmPnlDadosItemAntigo.SetLarPec(const Value: Double);
begin
  FLarPec := Value;
  pAtualizaLabelMetragem;
end;

procedure TfrmPnlDadosItemAntigo.SetQtdPec(const Value: Double);
begin
  FQtdPec := Value;
  pAtualizaLabelMetragem;
end;

function TfrmPnlDadosItemAntigo.tmrAtualizarDados: TNewTimer;
begin
  if not TNewTimer.Has(Self.Name + '.tmrAtualizarDados') then
  begin
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
    Result.Timeout  := 2000;
    Result.Interval := 300;
    Result.Enabled  := False;
    Result.OnTimer  := tmrAtualizarDadosTimer;
  end
  else
    Result := TNewTimer.Get(Self.Name + '.tmrAtualizarDados');
end;

procedure TfrmPnlDadosItemAntigo.tmrAtualizarDadosTimer(Sender: TObject);
begin
  tmrAtualizarDados.Enabled := False;
  pAtualizaDados;
end;

procedure TfrmPnlDadosItemAntigo.pCarregaSaldos;
  Var
    fltSaldos,
    fltCnvML: Double;
    mskSaldo: String;
Begin
  If Not fValidaCampos(['ITE_CODITE', 'ITE_SALDOS', 'ITE_CNV_ML', 'ITE_SAL_ML']) Then
  Begin
    pMostraAtualizandoSaldos(cxvSaldos, '');
    pMostraAtualizandoSaldos(cxvSaldosML, '');
    Exit;
  End;

  fltSaldos := cdsConsulta.FieldByName('ITE_SALDOS').AsFloat;

  If (cdsConsulta.FindField('ITE_CNV_ML') <> Nil)      And
     (cdsConsulta.FindField('ITE_CNV_ML').AsFloat > 0) Then
    fltCnvML := cdsConsulta.FindField('ITE_CNV_ML').AsFloat
  Else
    fltCnvML := 0;

  If fltCnvML > 0 Then
    fltSaldos := fltSaldos + cdsConsulta.FindField('ITE_SAL_ML').AsFloat / fltCnvML;

  objSalLoj.pCalculaSaldos(cdsConsulta,
                           recSaldos, recSaldosML,
                           fltSaldos, strEmpSal, strEmpSal,
                           cdsConsulta.FieldByName('ITE_CODITE').AsString, fltCnvML,
                           blnEntFut, blnPedCorte, blnOrdPro, intCalSal);

  mskSaldo := fMskDigitos(Max(3, fCfgSis('DECQTD', varInteger)));

  With recSaldos Do
  Begin
    cxvEntFutPrevisao.Properties.Value := FormatFloat(mskSaldo, fltEntPre);
    cxvEntFutFalta.Properties.Value    := FormatFloat(mskSaldo, fltEntFal);
    cxvEntFutAguarda.Properties.Value  := FormatFloat(mskSaldo, fltEntAgu);
    cxvEstFisico.Properties.Value      := FormatFloat(mskSaldo, fltEstFis);
    cxvPedidoVenda.Properties.Value    := FormatFloat(mskSaldo, fltSalPed);
    cxvEnderecamento.Properties.Value  := FormatFloat(mskSaldo, fltSalEnd);
    cxvExterno.Properties.Value        := FormatFloat(mskSaldo, fltSalExt);
    cxvOrdemProducao.Properties.Value  := FormatFloat(mskSaldo, fltSalOrd);
    cxvGarantia.Properties.Value       := FormatFloat(mskSaldo, fltSalGar);
    cxvDisponivel.Properties.Value     := FormatFloat(mskSaldo, fltSalDis);
    cxvTransfEstAndamentoAgFat.Properties.Value := FormatFloat(mskSaldo, fltEstEnv);
    cxvTransfEstAndamentoAgEnt.Properties.Value := FormatFloat(mskSaldo, fltEstRec);

    If blnBefTrg Then
      cxvSalDisMenosEntFut.Properties.Value := FormatFloat(mskSaldo, fltSalDis - fltEntPre - fltEntFal - fltEntAgu);

    If strPDCPRO <> 'N' Then
      If fValidaCampos(['QTD_PEDCOM']) Then
        cxvPedidoCompra.Properties.Value := FormatFloat(mskSaldo, cdsConsulta.FieldByName('QTD_PEDCOM').AsFloat);

    If strPDCPRO = 'T' Then
      If fValidaCampos(['QTD_PEDCOT']) Then
        cxvPedidoCompraLoja.Properties.Value := FormatFloat(mskSaldo, cdsConsulta.FieldByName('QTD_PEDCOT').AsFloat);

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
    cxvExternoML.Properties.Value        := FormatFloat(mskSaldo, fltSalExt);
    cxvOrdemProducaoML.Properties.Value  := FormatFloat(mskSaldo, fltSalOrd);
    cxvGarantiaML.Properties.Value       := FormatFloat(mskSaldo, fltSalGar);
    cxvDisponivelML.Properties.Value     := FormatFloat(mskSaldo, fltSalDis);

    If blnBefTrg Then
      cxvSalDisMenosEntFutML.Properties.Value := FormatFloat(mskSaldo, fltSalDis - fltEntPre - fltEntFal - fltEntAgu);

    If strPDCPRO <> 'N' Then
     If fValidaCampos(['QTD_PEDCOM']) Then
       cxvPedidoCompraML.Properties.Value := FormatFloat(mskSaldo, cdsConsulta.FieldByName('QTD_PEDCOM').AsFloat* cdsConsulta.FieldByName('ITE_CNV_ML').asFloat);

    cxvPedidoBaixaEntregaFuturaML.Properties.Value := FormatFloat(mskSaldo, fltSdPdBf);
  End;
End;

function TfrmPnlDadosItemAntigo.MyPos(stringtofind, stringtosearch: string; CaseInsensitive:
   boolean = true): integer;
begin
  if CaseInsensitive then
  begin
    stringtofind := LowerCase(stringtofind);
    stringtosearch := LowerCase(stringtosearch);
  end;
  Result := Pos(stringtofind, stringtosearch);
end;



procedure TfrmPnlDadosItemAntigo.TrocarCorPalavra(oRichEdit : TDBRichEdit; sText : String; Color, bkpColor: TColor);
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



procedure TfrmPnlDadosItemAntigo.pDestacaCorDeFonteFiltroAplicacao;
var
  strPalavra: String;
begin
  strPalavra:= objPanel.strFiltroEspecifico;
  if mypos(strPalavra,DBAplica.Text,true) > 0 then
  Begin
    If Not (cdsConsulta.State In dsEditModes) Then
      cdsConsulta.Edit;
    TrocarCorPalavra(DBAplica, strPalavra, clBlue, clYellow);
    cdsConsulta.Post;
  End;
end;

procedure TfrmPnlDadosItemAntigo.pAtualizaDados;
begin
  If Not bnlLigaScroll Then
    Exit;

  If Not Self.Showing Then
    Exit;

  If (Not cdsConsulta.Active) or cdsConsulta.IsEmpty then
  begin
    pLimpaDados;
    Exit;
  end;

  If cdsConsulta.Active And fValidaCampos(['ITE_CODITE']) then
  Begin

    If pgcSaldos.Visible Then
    Begin
      mnuAgregados.Visible := (Assigned(procExibeAgregados)) And (cdsConsulta.FindField('AGR_CODAGR') <> Nil) And (Not fEmptyStr(cdsConsulta.FieldByName('AGR_CODAGR').AsString));
      mnuReqCompra.Visible := (Assigned(procExibeRequisicaoCompra));

      btnOrcamentos.Visible := blnOrcPen And fValidaCampos(['ORCPEN']) And (cdsConsulta.FieldByName('ORCPEN').AsInteger > 0);

      btnConsVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0)                               And
                                       (Not fEmptyStr(strCodCli))                                      And
                                       (Not fEmptyStr(cdsConsulta.FieldByName('ITE_CODITE').AsString)) And
                                       (Assigned(procRelVendasPerdidas));

      pnlMetragem.Visible    := blnUtilizaVendaMadeira And dbePreVen.Visible And fMetragemObrigatoria( fRetUnidadeItem(cdsConsulta.FieldByName('ITE_CODITE').AsString) );
      btnSemelhantes.Visible := fExisteSemelhantes(cdsConsulta.FieldByName('ITE_CODITE').AsString);

      pCarregaSaldos;

      If blnUsaPDV Then
        blnHabF7 := (recSaldos.fltSalPed > 0) Or
                    (recSaldos.fltSalOrd > 0) Or
                    (recSaldos.fltSalGar > 0) Or
                    (recSaldos.fltSalEnd > 0);
    End;

    {************************************************************************}
    {* TRECHO QUE PERMITE EXIBIR A IMAGEM DO PRODUTO                        *}
    {******************************************************************* AM *}

    TfrmCadProFoto.pMostraImagemProduto(ImgPro, lblErrImg, blnImgPro, cdsConsulta.FieldByName('ITE_CODITE').AsString);
  End;

  pMostraBotaoSalRes;
  pMostraBotaoSimilares;
  pMostraPrecoPromocional;
  pMostraPrecoBoca;
  pMostraBotaoEstrutura;
  pAbreIteEmb;
  If (fCfgSis('PROBRI', VarBoolean)) And (Pos(strOpcDoc, 'VN_PD_OR_') > 0) Then
  Begin
    If fValidaCampos([ 'ITE_CODITE']) Then
      pAbrePromocaoBrindes(cdsConsulta.FieldByName('ITE_CODITE').AsString,MemProBrin);
  End;
  pAtualizarAplicacao;

  If fValidaCampos(['ITEITEATI']) Then
  Begin

    If cdsConsulta.FieldByName('ITEITEATI').AsString = 'ATIVO' Then
    begin
      lblIteAti.Font.Color := clGreen;
      lblIteAti.Caption := 'ATIVO';
    end
    Else
    begin
      lblIteAti.Font.Color := ARRCOR_SITUACAO_ITEM[sitInativo];
      lblIteAti.Caption := 'INATIVO';
    end;

  End;

  If (cdsConsulta.FindField('ITE_CNV_ML') <> Nil)      And
     (cdsConsulta.FindField('ITE_CNV_ML').AsFloat > 0) Then
  Begin
    tbsSaldosML.TabVisible   := True;
  End Else
  Begin
    tbsSaldosML.TabVisible   := False;
  End;

  pDestacaCorDeFonteFiltroAplicacao;

  tmrAtualizarDados.Enabled := False;
end;

procedure TfrmPnlDadosItemAntigo.pAtualizaLabelMetragem;
Begin
  lblQtdPec.Caption := 'Qtde.  : ' + FormatFloat('#0.00', fltQtdPec);
  lblComPec.Caption := 'Compri.: ' + FormatFloat('#0.00', fltComPec);
  lblLarPec.Caption := 'Largura: ' + FormatFloat('#0.00', fltLarPec);
  lblEspPec.Caption := 'Espess.: ' + FormatFloat('#0.00', fltEspPec);
End;

procedure TfrmPnlDadosItemAntigo.pAtualizarAplicacao;
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

  pDestacaCorDeFonteFiltroAplicacao

end;

procedure TfrmPnlDadosItemAntigo.pSetVisible(cxg: TcxEditorRow; bln: Boolean);
begin
  cxg.Visible := bln;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Visible := bln
end;
    
procedure TfrmPnlDadosItemAntigo.pSetIndex(cxg: TcxEditorRow);
begin
  Inc(intIdxCol);
      
  cxg.Index := intIdxCol;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdxCol;
end;

procedure TfrmPnlDadosItemAntigo.pOrdemInicial;
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
         pSetIndex(cxvSalDisMenosEntFut); 
              
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutFalta);
         pSetIndex(cxvEntFutAguarda);
       End;
    2: Begin
         If fCfgSis('BEFTRG', VarBoolean) Then
         Begin
           pSetIndex(cxvDisponivel);
           pSetIndex(cxvSalDisMenosEntFut); 
                
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
           pSetIndex(cxvSalDisMenosEntFut);  
         End;
       End;
    3: Begin
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);

         pSetIndex(cxvDisponivel);
         pSetIndex(cxvSalDisMenosEntFut);  

         pSetIndex(cxvEntFutFalta);
       End;
    4: Begin
         pSetIndex(cxvEntFutFalta);
               
         pSetIndex(cxvDisponivel);
         pSetIndex(cxvSalDisMenosEntFut);  
             
         pSetIndex(cxvEntFutPrevisao);
         pSetIndex(cxvEntFutAguarda);
       End;
    5: Begin
         pSetIndex(cxvEntFutPrevisao);
               
         pSetIndex(cxvDisponivel);
         pSetIndex(cxvSalDisMenosEntFut);  

         pSetIndex(cxvEntFutAguarda);
         pSetIndex(cxvEntFutFalta);
       End;
  End;

  If (fCfgSis('MOVFUL', varString) = '2') Then
  Begin
    cxvExterno.Properties.Caption := 'Estoque Externo';
    cxvExternoML.Properties.Caption := 'Estoque Externo';
    pSetIndex(cxvExterno, cxvDisponivel.Index + 1);
  End;

  pSetIndex(cxvPedidoCompra);
end;

procedure TfrmPnlDadosItemAntigo.pInicialializaTelaSaldoss;
Begin
  pOrdemInicial;
  
  pSetVisible(cxvSalDisMenosEntFut, blnBefTrg);
  
  pSetVisible(cxvPedidoCompra, strPDCPRO <> 'N');
  cxvPedidoCompraLoja.Visible := strPDCPRO = 'T';

  pSetVisible(cxvEntFutPrevisao,           blnEntFut);
  pSetVisible(cxvEntFutFalta,              blnEntFut);
  pSetVisible(cxvEntFutAguarda,            blnEntFut);

  pSetVisible(cxvPedidoVenda,   blnUsaPDV);
  pSetVisible(cxvEnderecamento, blnUsaPDV);
  pSetVisible(cxvOrdemProducao, blnUsaPDV And blnOrdPro);

  pSetVisible(cxvExterno, blnEstExt);

  pSetVisible(cxvPedidoBaixaEntregaFutura, blnEntFut And fReservaSaldoPedidosBaixaEntregaFutura);
  
  if blnEstExt then
    pgcSaldos.Height := pgcSaldos.Height + cxvSaldos.OptionsView.RowHeight;

  If (strPDCPRO = 'N') Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;

  If Not blnEntFut Then
    pgcSaldos.Height := pgcSaldos.Height - (3 * cxvSaldos.OptionsView.RowHeight);
    
  If Not cxvPedidoBaixaEntregaFutura.Visible Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;
    
  If Not blnUsaPDV Then
    pgcSaldos.Height := pgcSaldos.Height - (3 * cxvSaldos.OptionsView.RowHeight)

  Else If Not blnOrdPro Then
    pgcSaldos.Height := pgcSaldos.Height - cxvSaldos.OptionsView.RowHeight;

  tbsSaldosML.TabVisible   := False;
End;

procedure TfrmPnlDadosItemAntigo.pIniciouNavegacaoGridConsulta;
begin
  inherited;
  pEscreveAtualizando;
end;

procedure TfrmPnlDadosItemAntigo.pHabilitaTeclas(blnTravar: Boolean);
Begin
  blnEstaNoPainel := blnTravar;

  If Assigned(objPanel) Then
    objPanel.blnIgnorarTeclas := blnTravar;
End;

procedure TfrmPnlDadosItemAntigo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  bnlLigaScroll := False;
end;

procedure TfrmPnlDadosItemAntigo.FormCreate(Sender: TObject);
begin
  inherited;

  blnEstaNoPainel := False;

  objSalLoj := TSaldoLojas.Create(Self);

  blnUtilizaVendaMadeira := fCfgSis('VENMAD', varBoolean);
  blnExibirVrUnitarioPedCompraGrid := false;

  If fCfgSis('CTLEST', VarString) = '1' Then
    btnCadArmazem.Caption := 'Cadastro de Lotes'
  Else
    btnCadArmazem.Caption := 'Cadastro de Armazém';

  btnCadArmazem.Visible     :=  fVerificaAcessoSistema('frmCadArmazem', strLoginUsuarioLogado);
  btnCadSimilaridade.Visible:=  (fCfgSis('EMPGER', VarBoolean)) And (fVerificaAcessoSistema('frmSimilaridade', strLoginUsuarioLogado));
  btnRedeAncora.Visible := TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fBalcaoHabilitado;


  blnBefTrg := fCfgSis('BEFTRG', VarBoolean);
  strSUGVLE := fCfgSis('SUGVLE', varString);
  strPDCPRO := fCfgSis('PDCPRO', VarString);
  intCalSal := fCfgSis('CALSAL', varInteger);
  blnUsaPDV := fCfgSis('USAPDV', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnImgPro := fCfgSis('IMGPRO') = 'S';
  strComBca := fCfgSis('COMBCA', varString);

  If fCfgSis('CTLEST') = '2' Then
    btnLotIte.Caption := AnsiReplaceText(btnLotIte.Caption, 'Lotes', 'Armazéns');

  blnExiSalDisCD  := False;
  strEmpSal := '';

  lblIteAti.Caption := '';
  bnlLigaScroll     := False;

  objGerenciaRodape := TGerenciaPropriedadesComponentes.Create(TComponent(Self), 'ConsultadeItens');

  blnHabF7 := False;

  objPanel := Nil;

  cdsIteEmb := TZClient.Create(Self);
  cxgIteEmbTableView.DataController.DataSource := cdsIteEmb.dtsSource;

  pConfiguraPopup(btnPedComp);
  pConfiguraPopup(btnFichaKardex);
  pSetUtilizaCheckListGarantia(TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia);
end;

procedure TfrmPnlDadosItemAntigo.FormDestroy(Sender: TObject);
begin
  TNewTimer.Del(Self.Name + '.tmrAtualizarDados');
  inherited;
  If blnSalvar_lblAplicacao Then
     objGerenciaRodape.pSalvar;
  FreeAndNil(objGerenciaRodape);
end;

procedure TfrmPnlDadosItemAntigo.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 inherited;

 case Key of
    VK_F1 :If ssAlt In Shift Then
             btnComSisAntClick(Sender)
           Else
            btnMetragem.Click;

    VK_F2 :If ssAlt In Shift Then
             btnVedasSisAntClick(Sender)
           Else
             btnSemelhantesClick(Sender);

    VK_F4 : btnExecutaTarefaClick(Sender);

    VK_F5 : If ssAlt In Shift Then
              btnSepIte.Click
            Else
              btnEntregasPendentesClick(Sender);

    VK_F6 : If ssAlt In Shift Then
              btnLotIteClick(Sender)
            Else
              btnMostraEstoqueClick(Sender);

    VK_F7 : If ssAlt In Shift Then
              btnEmbalagemClick(Sender)
            Else
              btnPedSalResClick(Sender);

    VK_F8 : If ssAlt In Shift Then
              btnExiEstruturaClick(Sender)
            Else
              btnSimilaresClick(Sender);

    VK_F9 : If ssAlt In Shift Then
              btnImgSiteClick(Sender)
            Else
              btnItensVendClick(Sender);

    VK_F10: If (ssAlt In Shift) Then
            Begin
              If (btnOrcamentos.Visible) Then
                btnOrcamentosClick(Sender)
            End

            Else
              btnItensCompClick(Sender);

    VK_F11 : If (ssAlt In Shift) Then
               btnSimilaresOrcPedClick(Sender)
             Else
               btnPedCompClick(Sender);

    VK_F12: If (ssAlt In Shift) Then
              btnTranEstClick(Sender)
            Else
              btnPedCompGridClick(Sender);
  end;

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
end;

procedure TfrmPnlDadosItemAntigo.pLimpaCamposSemSQL;
Begin
  If cdsConsulta.Active Then
  Begin

    If Not fValidaCampos(['ITE_INFGAR']) Then
      dbeInfGar.DataField := '';

    If Not fValidaCampos(['ITE_TMPGAR']) Then
      dbeTmpGar.DataField := '';

    If Not fValidaCampos(['ITE_PREVEN']) Then
      dbePreVen.DataField := '';

    If Not fValidaCampos(['ULTVEN']) Then
      dbeUltVen.DataField := '';

    If Not fValidaCampos(['CAM_LOCFIS']) Then
      dbeLocFis.DataField := '';

    If Not fValidaCampos(['ITE_LOCSUP']) Then
      dbeLocSup.DataField := '';

    If Not fValidaCampos(['ITE_APLICA']) Then
      DBAplica.DataField := '';

    If Not fValidaCampos(['MSGLIV']) Then
      dbeMSGLIV.DataField := '';
  End;

End;

procedure TfrmPnlDadosItemAntigo.FormShow(Sender: TObject);
begin
  inherited;
  blnOrcPen := fCfgSis('ORCPEN', VarBoolean);

  If fEmptyStr(strEmpSal) Then
    strEmpSal := VS_strCodEmp;

  blnEstExt := fCfgSis('ESTEXT', varBoolean, strEmpSal);

  //Ajusta Componentes do Rodape de acordo com os posicionamentos e valores utilizados da ultima vez

  objGerenciaRodape.pCarregar(True);
  blnSalvar_lblAplicacao := False;

  pLimpaCamposSemSQL;

  dtsConsulta.DataSet := cdsConsulta;

  if (not cdsConsulta.Active) then
    cdsConsulta.Open;

  cdsConsulta.First;

  btnEntregasPendentes.Visible := blnEntFut;
  btnMostraEstoque.Visible     := VS_blnTemFil;
  btnSemelhantes.Visible       := fCfgSis('UTISEM', varBoolean);

  pnlMsgLivre.Visible := fVerificaAcessoSistema('VISMLCP', strLoginUsuarioLogado);

  btnSemelhantes.Visible := False;

  If (cdsConsulta.Active) And fValidaCampos(['ITE_CODITE']) Then
    btnSemelhantes.Visible := fExisteSemelhantes(cdsConsulta.FieldByName('ITE_CODITE').AsString);

  btnVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And
                               (Not fEmptyStr(strCodCli)) And
                               (Not fEmptyStr(strSenVen)) And
                               (Assigned(procVendasPerdidas));

  btnImgSite.Visible := fCfgSis('IMGURL', VarBoolean);

  lblExpandirAplicacao.Visible := fCfgSis('EXIAPL', varBoolean);

  btnConsVendasPerdidas.Visible := (Pos(strOpcDoc, 'VN_PD_OR_') > 0) And
                                   (Not fEmptyStr(strCodCli)) And
                                   (Assigned(procRelVendasPerdidas));

  blnNaoTecla := True;

  bnlLigaScroll := True;

  pConfiguraPopup(btnItensComp);

  btnComSisAnt.Visible := fCfgSis('PCGANT') = 'S';
  btnVedasSisAnt.Visible := fCfgSis('SISANT') = 'S';

  If Assigned(objPanel) Then
    pgcSaldos.Visible := objPanel.blnExibirSaldos;

  pgcSaldos.Visible := (pgcSaldos.Visible And fVerificaAcessoSistema('PVISPF'));

  pInicialializaTelaSaldoss;
end;

procedure TfrmPnlDadosItemAntigo.imgProDblClick(Sender: TObject);
begin
  try
    if blnImgPro and (not cdsConsulta.IsEmpty) And fValidaCampos(['ITE_CODITE']) then
      TfrmImagens.pAbrirImagens(tiProduto, cdsConsulta.FieldByName('ITE_CODITE').AsString, True, '', strCodCli, True);
  Except

    On E: ExceptionAutCom do
      pMensagemOk(E.Message);

    On E: Exception do
      pMensagensErro(E.Message, '[imgProDblClick]');

  End;
end;

procedure TfrmPnlDadosItemAntigo.lblExpandirAplicacaoClick(Sender: TObject);
begin
  inherited;
  If (Assigned(cdsConsulta.FindField('ITE_APLICA')) And (Not fEmptyStr(cdsConsulta.FieldByName('ITE_APLICA').AsString))) Then
  Begin
    Try
      pCriarFormularios(TfrmVisualizarAplicacaoProduto, frmVisualizarAplicacaoProduto);
      frmVisualizarAplicacaoProduto.edtAplicacao.Lines := TRichEdit(DBAplica).Lines;
      frmVisualizarAplicacaoProduto.FCodIte := cdsConsulta.FieldByName('ITE_CODITE').AsInteger;
      frmVisualizarAplicacaoProduto.lblProd.Caption := 'Aplicação: ' + cdsConsulta.FieldByName('ITE_DESITE').AsString;
      frmVisualizarAplicacaoProduto.ShowModal;
    Finally
      FreeAndNil(frmVisualizarAplicacaoProduto);
    End;
  End;

end;

procedure TfrmPnlDadosItemAntigo.lblLegendasClick(Sender: TObject);
begin
  Try
    cdsLegendas := TLegendasItem.Create(Self);
    TfrmMostraLegendasItem.pMostraLegendas(cdsLegendas);
    cdsLegendas.fAbreClient(True,'');
  Finally
    FreeAndNil(cdsLegendas);
  End;
end;

procedure TfrmPnlDadosItemAntigo.pMostraBotaoSalRes;
begin

  If blnUsaPDV Then
    btnPedSalRes.Visible := blnHabF7;
end;

procedure TfrmPnlDadosItemAntigo.pMostraBotaoEstrutura;
Begin
  btnExiEstrutura.Visible := (cdsConsulta.Active) And fValidaCampos(['ESTRUT']) And
                             (cdsConsulta.FieldByName('ESTRUT').AsInteger > 0);
End;

procedure TfrmPnlDadosItemAntigo.pMostraBotaoSimilares;
begin
  If Not fValidaCampos(['ITE_CODSIM']) Then
    Exit;

  If (Not cdsConsulta.FieldByName('ITE_CODSIM').IsNull) Then
  Begin
    btnSimilares.Visible := True;
    btnSimilaresOrcPed.Visible := True;
  End Else
  Begin
    btnSimilares.Visible := False;
    btnSimilaresOrcPed.Visible := False;
  End;
end;

procedure TfrmPnlDadosItemAntigo.pMostraEstoqueLojas;
  Var
    frmFatMostraEstoqueEmp : TfrmFatMostraEstoqueEmp;
begin
  Try

    If Not fValidaCampos(['ITE_CODITE', 'ITE_DESITE']) Then
      Exit;

    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);

    frmFatMostraEstoqueEmp.blnFaturamento := blnFaturamento;
    frmFatMostraEstoqueEmp.strCodIte      := cdsConsulta.FieldByName('ITE_CODITE').AsString;
    frmFatMostraEstoqueEmp.strTabPre      := strTabPre;
    frmFatMostraEstoqueEmp.edtItem.Text   := cdsConsulta.FieldByName('ITE_CODITE').AsString + ' - ' +
                                             cdsConsulta.FieldByName('ITE_DESITE').AsString;
    frmFatMostraEstoqueEmp.blnEstrutura   := fItemEstrutura(cdsConsulta.FieldByName('ITE_CODITE').AsString);
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

procedure TfrmPnlDadosItemAntigo.pMostraPrecoBoca;
begin
  {****************************************************}
  {* EXIBE OU NÃO O PREÇO DE BOCA NA TELA DE CONSULTA *}
  {**23/02/2011-15:48*******************************DP*}
  If cdsConsulta.FindField('BOCACAIXA') <> Nil Then
    If (cdsConsulta.FieldByName('BOCACAIXA').AsString = 'SIM') Then
    Begin
      If Not fValidaCampos(['BCA_PREMIN', 'BCA_COMVAR']) Then
        Exit;

      edtPrecoBoca.Text := FloatToStrF(cdsConsulta.FieldByName('BCA_PREMIN').asFloat,ffFixed,12,2);
      edtComBoca.Text   := FloatToStrF(cdsConsulta.FieldByName('BCA_COMVAR').asFloat,ffFixed,12,2);

      edtPrecoBoca.Visible := True;
      edtComBoca.Visible   := True;
      lblPreBoca.Visible   := True;
      lblComBoca.Visible   := True;

      lblComBoca.Caption:= 'Comiss. Boca Cx:';
      lblComBoca.Caption := IfThen((strComBca = '%'), '%', 'Valor')+' '+lblComBoca.Caption;

    End Else
    Begin
      edtPrecoBoca.Visible := False;
      edtComBoca.Visible   := False;
      lblPreBoca.Visible   := False;
      lblComBoca.Visible   := False;
    End;
end;

procedure TfrmPnlDadosItemAntigo.pMostraPrecoPromocional;
  Var
    fltPreCus: Double;
    fltPreVen: Double;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    fltQtdDis: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    dadosPromocao: TDadosPromocao;
    fltMinPro: Double;
    fltLimPro: Double;
    strComPro: String;
    strCodPro: String;
    fltDesF07: Double;
begin
  fltMinPro := 0;
  fltLimPro := 0;

  If Not fValidaCampos(['ITE_CODITE']) Then
     Exit;

  If (strSUGVLE = '2') And
     (cdsConsulta.FindField('EMPROMOC') <> Nil) And (cdsConsulta.FindField('ESTRUT') <> Nil) And
     (cdsConsulta.FieldByName('EMPROMOC').AsString = 'SIM') And (cdsConsulta.FieldByName('ESTRUT').AsInteger > 0) Then
  Begin
    edtValPro.Visible := True;
    lblValPro.Visible := True;
    edtValPro.Text    := FloatToStrF(cdsConsulta.FieldByName('IPR_PREPRO').AsFloat, ffFixed, 12, 2);
  End
  Else If fValidaCampos(['EMPROMOC']) And
          (cdsConsulta.FieldByName('EMPROMOC').AsString = 'SIM') And
          (fRetornaPrecosPromocao(cdsConsulta.FieldByName('ITE_CODITE').AsString,
                                  strCodCli,
                                  VS_Date,
                                  1,
                                  0,
                                  0,
                                  intPraMedio,
                                  fltPreCus,
                                  fltPreVen,
                                  fltComVar,
                                  fltComAta,
                                  fltComDis,
                                  fltQtdDis,
                                  fltDesF07,
                                  strComPro,
                                  strCodPro,
                                  blnParticiona,
                                  blnPromo,
                                  strTabPre,
                                  strCodCnd,
                                  '',
                                  '',
                                  True,
                                  False,
                                  '-1',
                                  False,
                                  False,
                                  '',
                                  '',
                                  strNumOrc,
                                  strEspOrc,
                                  Nil,
                                  True)) Then
  Begin
    edtValPro.Visible := True;
    lblValPro.Visible := True;
    lblDesPro.Visible := True;
    edtValPro.Text    := FloatToStrF(fltPreVen, ffFixed, 12, 2);

    lblDesPro.Caption := '';
    dadosPromocao := fDadosPromocao(cdsConsulta.FieldByName('ITE_CODITE').AsString, VS_strCodEmp, strCodCli, strTabPre, '', strNumOrc, strEspOrc, strCodPro);
    fltMinPro := dadosPromocao.fltQtdMin;
    fltLimPro := dadosPromocao.fltQtdLim;

    If Not fEmptyStr(dadosPromocao.strDesPro) Then
      lblDesPro.Caption := Trim(LeftStr(Trim(dadosPromocao.strDesPro), 57));

    lblValPro.Caption := 'Preço Promocional:';

    If Not fEmptyStr(strTabPre) Then
      lblValPro.Caption := 'Preço Promoc. (' + strTabPre + '):';

    lblDesPro.Visible := (lblDesPro.Caption <> '.........');
  End
  Else
  Begin
    edtValPro.Visible := False;
    lblValPro.Visible := False;
    lblDesPro.Visible := False;
    edtValPro.Clear;
  End;

  If (edtValPro.Visible) And ((fltMinPro > 1) Or (fltLimPro > 0)) Then
  Begin
    lblMinPro.Visible := True;
    edtMinPro.Visible := True;
    edtMinPro.Text    := FloatToStrF(fltMinPro, ffFixed, 12, 2);

    lblLimPro.Visible := True;
    edtLimPro.Visible := True;
    edtLimPro.Text    := FloatToStrF(fltLimPro, ffFixed, 12, 2);

    lblDispPro.Visible := True;
    edtDispPro.Visible := True;
    edtDispPro.Text    := FloatToStrF(fltQtdDis, ffFixed, 12, 2);

    lblDesPro.AutoSize := False;
    lblDesPro.Properties.WordWrap := False;
    lblDesPro.Properties.Alignment.Horz := taLeftJustify;
  End
  Else
  Begin
    lblMinPro.Visible := False;
    edtMinPro.Visible := False;

    lblLimPro.Visible := False;
    edtLimPro.Visible := False;

    lblDispPro.Visible := False;
    edtDispPro.Visible := False;

    lblDesPro.AutoSize := True;
    lblDesPro.Properties.WordWrap := True;
    lblDesPro.Properties.Alignment.Horz := taCenter;
  End;
end;

procedure TfrmPnlDadosItemAntigo.pParouNavegacaoGridConsulta;
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

procedure TfrmPnlDadosItemAntigo.pResetatmrAtualizarDados;
begin
  pEscreveAtualizando;
  tmrAtualizarDados.Enabled := False;
  tmrAtualizarDados.Enabled := True;
end;

procedure TfrmPnlDadosItemAntigo.pSetIndex(cxg: TcxEditorRow; const intIdx: Integer);
begin
  Inc(intIdxCol);

  cxg.Index := intIdx;
  TcxEditorRow(Self.FindComponent(cxg.Name+'ML')).Index := intIdx;
end;

procedure TfrmPnlDadosItemAntigo.pSetPnlDadosItemVisible(AVisible: Boolean);
begin
  inherited;
  pnlDadosItem.Visible := AVisible;
end;

procedure TfrmPnlDadosItemAntigo.pSetUtilizaCheckListGarantia(Value: Boolean);
begin
  blnUtilizaCheckListGarantia := Value;
  btnChkLstDevGar.Enabled := blnUtilizaCheckListGarantia;
  btnChkLstDevGar.Visible := btnChkLstDevGar.Enabled;
end;

procedure TfrmPnlDadosItemAntigo.pImprimeSeparacaoItem;
  Var
    strRefere,
    strMsgLv1 : String;
Begin

  If Not fValidaCampos(['ITE_REFERE', 'ITE_CODITE', 'ITE_DESITE', 'CAM_LOCFIS', 'UNI_SIGUNI', 'ITE_PREVEN']) Then
     Exit;

  strRefere := '';
  strMsgLv1 := '';

  If cdsConsulta.FindField('ITE_REFERE') <> Nil Then
    strRefere := cdsConsulta.FieldByName('ITE_REFERE').AsString;

  If cdsConsulta.FindField('ITE_MSGLV1') <> Nil Then
    strMsgLv1 := cdsConsulta.FieldByName('ITE_MSGLV1').AsString;

  If (cxvDisponivel.Properties.Value <= 0) Then
    If (Not (fMensagem('AVISO',
                       'Este produto não tem estoque disponível para novas vendas !' + #10+#13+
                       'Deseja imprimir a separação mesmo assim ?',
                       ['&Sim', '&Não'], 2) = 1)) Then
      Exit;

  TfrmControleSepAvulsa.pImprimeSeparacaoItem(cdsConsulta.FieldByName('ITE_CODITE').AsString,
                                              cdsConsulta.FieldByName('ITE_DESITE').AsString,
                                              cdsConsulta.FieldByName('CAM_LOCFIS').AsString,
                                              cdsConsulta.FieldByName('UNI_SIGUNI').AsString,
                                              fRetCodFabrica(cdsConsulta.FieldByName('ITE_CODITE').AsString),
                                              strCodCli,
                                              strCodVen,
                                              strCodDig,
                                              cdsConsulta.FieldByName('ITE_PREVEN').AsFloat,
                                              strRefere,
                                              strMsgLv1);
End;

procedure TfrmPnlDadosItemAntigo.pLimpaDados;
begin
  pMostraAtualizandoSaldos(cxvSaldos, '');
  pMostraAtualizandoSaldos(cxvSaldosML, '');

  edtPrecoBoca.Clear;
  edtMinPro.Clear;
  edtLimPro.Clear;
  edtValPro.Clear;
  imgPro.Picture := nil;
end;

procedure TfrmPnlDadosItemAntigo.pEnviarParaVendasPerdidas;
begin
  If Not fValidaCampos([ 'ITE_CODITE']) Then
     Exit;

  If Assigned(procVendasPerdidas) Then
    procVendasPerdidas(strCodCli, fRetSenhaVendedor(strSenVen), cdsConsulta.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmPnlDadosItemAntigo.pAbreIteEmb;
Begin
  If Not fValidaCampos([ 'ITE_CODITE']) Then
     Exit;

  cdsIteEmb.qryQuery.Close;
  cdsIteEmb.qryQuery.SQL.Text := fGetSQLIteEmb;
  cdsIteEmb.qryQuery.ParamByName('CODITE').AsString := cdsConsulta.FieldByName('ITE_CODITE').AsString;
  cdsIteEmb.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  cdsIteEmb.fAbreClient(True, 'TfrmPnlDadosItem.pAbreIteEmb');

  TFloatField(cdsIteEmb.FieldByName('ITB_DESCON')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsIteEmb.FieldByName('UNITAR'    )).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).DisplayFormat := IIF(fUnidadeDoProdutoEhFracionaria(cdsConsulta.FieldByName('ITE_CODITE').AsString),
                                                                        fMskDigitos(4), '');
  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).Alignment     := taCenter;
  TFloatField(cdsIteEmb.FieldByName('ITB_TABPRE')).Alignment     := taCenter;

  lblIteEmb.Visible := (cdsIteEmb.RecordCount > 0);
  cxgIteEmb.Visible := (cdsIteEmb.RecordCount > 0);

End;

Function TfrmPnlDadosItemAntigo.fGetSQLIteEmb: String;
Begin
  Result := '';
  Result := Result + ' SELECT ITB_QTDEMB,                                             ';
  Result := Result + '        ITB_DESCON,                                             ';
  Result := Result + '        IFNULL(ITB_TABPRE,"TODAS") AS ITB_TABPRE,               ';
  Result := Result + '        CASE IF(IFNULL(ITB_TABPRE,"")="","' + IfThen(fEmptyStr(strTabPre), '0', strTabPre) + '",ITB_TABPRE) ';
  Result := Result + '          WHEN "0" THEN NULL                                    ';
  Result := Result + '          WHEN "1" THEN (ITE_PREVE1 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "2" THEN (ITE_PREVE2 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "3" THEN (ITE_PREVE3 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "4" THEN (ITE_PREVE4 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "5" THEN (ITE_PREVE5 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "6" THEN (ITE_PREVE6 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '          WHEN "7" THEN (ITE_PREVE7 * ((100-ITB_DESCON) / 100)) ';
  Result := Result + '        END AS UNITAR                                           ';
  Result := Result + ' FROM ITEEMB                                                    ';
  Result := Result + ' INNER JOIN ITEGER ON ITE_CODITE = ITB_CODITE                   ';
  Result := Result + '                  AND ITE_CODEMP = ITB_CODEMP                   ';
  Result := Result + ' WHERE ITB_CODITE = :CODITE                                     ';
  Result := Result + '   AND ITB_CODEMP = :CODEMP                                     ';
  Result := Result + ' ORDER BY ITB_QTDEMB DESC                                       ';
End;

function TfrmPnlDadosItemAntigo.fMostrarOrcPedProdSimilar(pgbStatus: TcxProgressBar): Boolean;
begin

  Result := False;

  If Not fValidaCampos(['ITE_CODSIM']) Then
     Exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    Result := fncExecutaRelatorio(192, 7482, [7483],
                                  ['CODSIM'],
                                  [cdsConsulta.FieldByName('ITE_CODSIM').AsString],
                                  nil,
                                  nil,
                                  True);
  End;

end;

procedure TfrmPnlDadosItemAntigo.pOnDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
 {}
end;


end.


