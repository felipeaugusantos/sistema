unit untFatExpedicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, DB,
  Uni, UniClientDataSet, StrUtils, AppEvnts, DBCtrls, cxProgressBar, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridLevel, Math, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem, untZClient,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untfuncoesSimples, untTypesSistema, frxClass,
  frxExportCSVTestabilidade, Vcl.ComCtrls, Vcl.ImgList, cxContainer, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxImageComboBox, System.ImageList, System.Types,
  ComboBoxFocus, EditFocus, untPanelCxItem, untPnlDadosItem, untRcxConfCupom,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFuncFat, System.Generics.Collections,
  untLiberacao, cxCustomListBox, cxCheckListBox, untTLock, untTThreadNotificacao,
  untTipoEntregaRetiraExpedicao, cxGridCitel, cxGridDBDataDefinitions, untTipoFreteAtc,
  untTDefinirLotesWMS, untUtilMonitor, untConfigOcultaInfo, untMethodLoopDetector,
  untFatVerItensDocRom, cxImageList, untSEPDOR_CONDOR, cxGroupBox, cxCheckGroup,
  dxScreenTip, dxCustomHint, cxHint, Expedicao.TemporariaPedidosExpedicao,
  DBAccess, Datasnap.DBClient;

resourcestring
  sqlItensPendentesSeparacao = 'SELECT P.FDO_DTAENT, P.FDO_HORENT, P.NUMPED, P.CLIENTE, P.FGO_CODVEN, '+
                               'CONCAT(D.FDO_CODITE, "-", C.ITE_DESITE) AS PRODUTO, P.UNI_SIGUNI,     '+
                               'P.FDO_QTDITE, D.FDO_CODITE, IFNULL(E.FGO_EMP_CD, D.FDO_CODEMP)        '+
                               ' AS FDO_CODEMP                                                        '+
                               'FROM FATDOR D                                                         '+
                               'INNER JOIN FATGOR G ON D.FDO_SEQGER = G.AUTOINCREM                    '+
                               'INNER JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO                    '+
                               'INNER JOIN (SELECT D.FDO_CODITE, D.FDO_CODEMP, G.FGO_CODVEN,          '+
                               '            CONCAT(D.FDO_NUMDOC, "-", D.FDO_ESPDOC, "-", D.FDO_CODEMP)'+
                               '            AS NUMPED, D.FDO_DTAENT, D.FDO_HORENT, U.UNI_SIGUNI,      '+
                               '            CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE,       '+
                               '            D.FDO_QTDITE, E.FGO_EMP_CD                                '+
                               '            FROM FATDOR D                                             '+
                               '            JOIN FATGOR G ON D.FDO_SEQGER = G.AUTOINCREM              '+
                               '            JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO              '+
                               '            JOIN CADCLI C ON G.FGO_CODCLI = C.CLI_CODCLI              '+
                               '            JOIN CADUNI U ON D.FDO_UNIDAD = U.UNI_CODUNI              '+
                               '            WHERE IF(G.FGO_SEPIMP = "N" OR IFNULL(G.FGO_SEPIMP,"") =  '+
                               '                     "", "0", IF(G.FGO_SEPIMP = "S", "1", G.FGO_SEPIMP'+
                               '                  )) = "0"                                            '+
                               '              AND G.FGO_JAFATU = "0"                                  '+
                               '              AND G.FGO_ESPDOC = :ESPDOC) AS P                        '+
                               '         ON P.FDO_CODITE = D.FDO_CODITE                               '+
                               '        AND IFNULL(P.FGO_EMP_CD, P.FDO_CODEMP) = IFNULL(E.FGO_EMP_CD, '+
                               '                                                         D.FDO_CODEMP)'+
                               'INNER JOIN CADITE C ON D.FDO_CODITE = C.ITE_CODITE                    '+
                               'WHERE D.FDO_NUMDOC = :NUMDOC                                          '+
                               '  AND D.FDO_ESPDOC = :ESPDOC                                          '+
                               '  AND D.FDO_CODEMP = :CODEMP                                          '+
                               '  AND IFNULL(E.FGO_LOC_PD, "N") <> "S"                                '+
                               '  AND CAST(CONCAT(P.FDO_DTAENT, " ", P.FDO_HORENT) AS DATETIME) <     '+
                               '      CAST(CONCAT(D.FDO_DTAENT, " ", D.FDO_HORENT) AS DATETIME)       '+
                               'ORDER BY D.FDO_CODITE, P.FDO_DTAENT, P.FDO_HORENT                     ';

Type
  TTipoImpressaoSeparacao = (tisNormal, tisWMSAtualSemEscolha, tisWMSTodos, tisReimpressaoSeqSeparacaoWMS);

  TLocSep = Record
    strCodigo: String;
    strDescri: String;
  End;

  TLocSepList = Array of TLocSep;

  TFiltroLocSepArmz = (tfLocSep, tfArmazem, tfNenhum);

  TTipFiltExpData = (tfeEntrada, tfePrevisao, tfeEntrega, tfeVazio);

  TFiltroSomentePedidosTransferencia = (tfRetira, tfRetiraEEntrega, tfNao);

  TfrmFatExpedicao = class(TfrmPai)
    dbgPedidos: TDBGridCitel;
    dtsPedidos: TDataSource;
    dtsDuplic: TDataSource;
    btnBuscar: TBitBtnLocked;
    btnLimparBusca: TBitBtnLocked;
    btnConsProduto: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnImpSep: TBitBtnLocked;
    btnRecarrPed: TBitBtnLocked;
    btnFaturarExpedidos: TBitBtnLocked;
    btnCliObs: TBitBtnLocked;
    btnFeriados: TBitBtnLocked;
    pgcExpedicao: TPageControl;
    HintControler: TcxHintStyleController;
    tmrBuscar: TTimer;
    tbsDados: TTabSheet;
    pnlDadosAdc: TPanel;
    pnlMenExp: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    DBText1: TDBText;
    Label2: TLabel;
    DBText2: TDBText;
    dbtPeso: TDBText;
    lblPeso: TLabel;
    Label4: TLabel;
    dbtxtMEN001: TDBText;
    dbtxtMEN002: TDBText;
    lblPrevis: TLabel;
    dbtxtPrevis: TDBText;
    lblTitCND: TLabel;
    lblCONPAG: TDBText;
    lblTitFPG: TLabel;
    lblCODFPG: TDBText;
    lblDESFPG: TLabel;
    lblIteExp: TLabel;
    shpIteExp: TShape;
    lblOrdPro: TLabel;
    dbtxtOrdPro: TDBText;
    lbl6: TLabel;
    Label13: TLabel;
    lblTotExp: TLabel;
    shpTotExp: TShape;
    lblFeriado: TLabel;
    pnlSepImp: TPanel;
    Label5: TLabel;
    lblOBSEXP: TDBText;
    lblNomSep: TLabel;
    dbtxtNomSep: TDBText;
    lblDtaImpSep: TLabel;
    dbtxtDtImSe: TDBText;
    dbtxtHrImSe: TDBText;
    lblDtaBaiSep: TLabel;
    dbtxtDtBxSe: TDBText;
    dbtxtHrBxSe: TDBText;
    pnlLegFat: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    lbl1: TLabel;
    dbtxtDESREG: TDBText;
    lbl2: TLabel;
    dbtxtMINFAT: TDBText;
    pnlLegendEmpVen: TPanel;
    shpVenOutEmp: TShape;
    lbl3: TLabel;
    shpVenEmp: TShape;
    lbl4: TLabel;
    tbsDuplicatas: TTabSheet;
    pnlDuplicatas: TPanel;
    cxgPagamentos: TcxGrid;
    cxgPagamentosDBTableView1: TcxGridDBTableView;
    cxgPagamentosDBTableView1Column1: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column4: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column2: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column5: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column6: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column7: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column8: TcxGridDBColumn;
    cxgPagamentosDBTableView1Column9: TcxGridDBColumn;
    cxgPagamentosLevel1: TcxGridLevel;
    btnBuscaNFe_Estoque: TBitBtnLocked;
    tbsAdiantamentos: TTabSheet;
    dbgAdiantamentos: TDBGridCitel;
    dtsAdiantamentos: TDataSource;
    imglSitFin: TImageList;
    pnlFiltros: TPanel;
    shpGarantia: TShape;
    lblGarantia: TLabel;
    lblTipoAtendimentoC: TLabel;
    lblTipoAtendimentoD: TLabel;
    btnOpeDes: TBitBtnLocked;
    btnConPedPen: TBitBtnLocked;
    btnDesmExpedidos: TBitBtnLocked;
    btnSeparacao: TBitBtnLocked;
    lblGuiche: TLabel;
    lblNumGuiche: TLabel;
    dbeFatTot: TDBText;
    lblPedTransf: TLabel;
    dbePedTransf: TDBText;
    lblReqCompra: TLabel;
    dbeReqCompra: TDBText;
    btnLegenda: TBitBtnLocked;
    popSeparacao: TPopupMenu;
    mnuVerSeparacoes: TMenuItem;
    mnuLimparSeparacao: TMenuItem;
    pnlDiversos: TPanel;
    rdgTipoDocumento: TRadioGroup;
    rdgTipoMov: TRadioGroup;
    grbLocSep: TGroupBox;
    cmbLocSep: TComboBoxFocus;
    pnlFilSitFin: TPanel;
    Label11: TLabel;
    cmbSitFin: TcxImageComboBox;
    pnlStatusPedido: TPanel;
    grbStatusPedido: TGroupBox;
    lstStatusPedido: TcxCheckListBox;
    pnlLateral: TPanel;
    pnlCliLoj: TPanel;
    cmbCliLoj: TComboBoxFocus;
    Label9: TLabel;
    Label10: TLabel;
    lblVendedor: TLabel;
    btnConfirmaCupons: TBitBtnLocked;
    btnFaturarOndaSeparacao: TBitBtnLocked;
    btnExpFatAutTodos: TBitBtnLocked;
    Panel3: TPanel;
    btnEntFutCD: TBitBtnLocked;
    btnCfgExp: TBitBtnLocked;
    tmrTmpRte: TTimer;
    tmrTmpIan: TTimer;
    shpSepNaoImp: TShape;
    lblSepImpNaoImp: TLabel;
    shpSepImp: TShape;
    lblSepImpJaImp: TLabel;
    shpAltSepImp: TShape;
    lblSepImpExpNaoImp: TLabel;
    shpDocDev: TShape;
    btnAltEmpFat: TBitBtnLocked;
    lblSepDocumentoDevolucao: TLabel;
    shpSepReimp: TShape;
    lblSepImpExpJaImp: TLabel;
    shpLibSep: TShape;
    lblLibSep: TLabel;
    btnMensagemExpedicao: TBitBtnLocked;
    lblExibirFiltroStatusPedidos: TLabel;
    btnRevEmpFat: TBitBtnLocked;
    btnSituacaoItens: TBitBtnLocked;
    mnuRemanejarSeparador: TMenuItem;
    btnExpedicao: TBitBtnLocked;
    popExpedicao: TPopupMenu;
    mnuDesfazerExpedicaoDesteDocumento: TMenuItem;
    N2: TMenuItem;
    mnuDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente: TMenuItem;
    btnCortarProdutosPedido: TBitBtnLocked;
    btnDefinirSeparadorConferente: TBitBtnLocked;
    btnAlterarDataEntrega: TBitBtnLocked;
    Label6: TLabel;
    lblConferente: TLabel;
    lblLocArmDesc: TLabel;
    lblLocArm: TLabel;
    tbsPedidosVinculados: TTabSheet;
    imglSeqDmp: TImageList;
    grdPedidosVinculadosDBTableViewCitel1: TcxGridDBTableViewCitel;
    grdPedidosVinculadosLevel1: TcxGridLevel;
    grdPedidosVinculados: TcxGridCitel;
    dtsPedidosVinculados: TDataSource;
    grdPedidosVinculadosFGO_NUMDOC: TcxGridDBColumn;
    grdPedidosVinculadosFGO_DTAENT: TcxGridDBColumn;
    grdPedidosVinculadosVALDOC: TcxGridDBColumn;
    grdPedidosVinculadosFGO_VLRCON: TcxGridDBColumn;
    grdPedidosVinculadosFGO_DTAFAT: TcxGridDBColumn;
    grdPedidosVinculadosFGO_NUMFAT: TcxGridDBColumn;
    grdPedidosVinculadosENTRET: TcxGridDBColumn;
    grdPedidosVinculadosEMPITE: TcxGridDBColumn;
    pnlTotDocs: TPanel;
    Label14: TLabel;
    lblTotDocs: TLabel;
    btnMulSep: TBitBtnLocked;
    lblPesoTotal: TLabel;
    lblPesoTotalV: TLabel;
    lblVolumeTotal: TLabel;
    lblVolumeTotalV: TLabel;
    lblOcultarExibirPainelInformacoes: TLabel;
    pnlGrid: TPanel;
    btnExibirProdutos: TBitBtnLocked;
    imglNFeSta: TcxImageList;
    mnuLimparSeparacaoRomaneio: TMenuItem;
    mnuGuardarItensSep: TMenuItem;
    dbeTotFre: TDBText;
    lblTotFre: TLabel;
    pnlDocumentosSelecionados: TPanel;
    Label3: TLabel;
    Label12: TLabel;
    lblValorContabilTotalSelecionados: TLabel;
    Label16: TLabel;
    lblPesoTotalSelecionados: TLabel;
    Label18: TLabel;
    lblVolumeTotalSelecionados: TLabel;
    lblDocsSelecionados: TLabel;
    rdgFiltroPeriodo: TRadioGroup;
    pnlMenExp2: TPanel;
    dbtxtMENEXP: TDBText;
    dbtxtMENEXP2: TDBText;
    dbtxtMENEXP3: TDBText;
    dbtxtMENEXP4: TDBText;
    lbl5: TLabel;
    pnlResumoExpedicao: TPanel;
    Label15: TLabel;
    lblResumoVlTotal: TLabel;
    lblResumoQtdTotal: TLabel;
    lblResumoQtdNaoSep: TLabel;
    lblResumoVlNaoSep: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    lblResumoVlSep: TLabel;
    lblResumoQtdSep: TLabel;
    lblResumoQtdFat: TLabel;
    lblResumoVlFat: TLabel;
    Label23: TLabel;
    pnlTotSel: TPanel;
    lbl_TotProdExp: TLabel;
    lblTotProdExp: TLabel;
    lblTotProdNotExp: TLabel;
    lbl_TotProdNotExp: TLabel;
    lbl_TotProd: TLabel;
    lblTotProd: TLabel;
    btnFrete: TBitBtnLocked;
    btnBaixarPedidoNaoEntregue: TBitBtnLocked;
    btnFechar: TBitBtnLocked;
    btnRobSep: TBitBtnLocked;
    lblRobSep: TLabel;
    lblFreCot: TLabel;
    dbeFreCot: TDBText;
    lblFreSug: TLabel;
    dbeFreSug: TDBText;
    gpbTipoExpedicao: TGroupBox;
    rdbExpedicaoParcial: TRadioButton;
    rdbSemExpedicao: TRadioButton;
    rdbTodos: TRadioButton;
    btnImpOrdemProducao: TBitBtnLocked;
    btnDesmembrarPed: TBitBtnLocked;
    grbLocRet: TGroupBox;
    lstLocRet: TcxCheckListBox;
    btnAltSitPed: TBitBtnLocked;
    btnAltLotImpSep: TBitBtnLocked;
    Label17: TLabel;
    lblValorTotalSelecionado: TLabel;
    btnConsultaPed: TBitBtnLocked;
    lblCubTotal: TLabel;
    lblVlrCubSelecionados: TLabel;
    dtsFeriados: TUniDataSource;
    pnlOriEnt: TPanel;
    lblOrientacoes: TLabel;
    lblOriEnt: TLabel;
    cdsFeriados: TUniClientDataSet;
    cdsFeriadosFCI_DTAFER: TDateField;
    cdsFeriadosFCI_DESCRI: TStringField;
    pnlFeriados: TPanel;
    dbgFeriados: TDBGridCitel;
    pnlTopFer: TPanel;
    lblFeriados: TLabel;
    dbtCidFer: TDBText;
    pnlOperador: TPanel;
    btnReimprimeDocumento: TBitBtnLocked;
    rdgTipoConferencia: TRadioGroup;
    rdgFiltroDataColeta: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure pgcExpedicaoChange(Sender: TObject);
    procedure dbgPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLimparBuscaClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPedidosDblClick(Sender: TObject);
    procedure btnConsProdutoClick(Sender: TObject);
    procedure dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnImpSepClick(Sender: TObject);
    procedure btnRecarrPedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cdsPedidosAfterScroll(DataSet: TDataSet);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnFaturarExpedidosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure dbgPedidosTitleClick(Column: TColumn);
    procedure btnCliObsClick(Sender: TObject);
    procedure btnFeriadosClick(Sender: TObject);
    procedure rdgTipoDocumentoClick(Sender: TObject);
    procedure btnBuscaNFe_EstoqueClick(Sender: TObject);
    procedure dbgAdiantamentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure cmbSitFinClick(Sender: TObject);
    procedure btnOpeDesClick(Sender: TObject);
    procedure btnConPedPenClick(Sender: TObject);
    procedure btnDesmExpedidosClick(Sender: TObject);
    procedure rdgTipoMovClick(Sender: TObject);
    procedure btnCfgExpClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLegendaClick(Sender: TObject);
    procedure mnuVerSeparacoesClick(Sender: TObject);
    procedure btnSeparacaoClick(Sender: TObject);
    procedure btnRevEmpFatClick(Sender: TObject);
    procedure btnConfirmaCuponsClick(Sender: TObject);
    procedure btnAltEmpFatClick(Sender: TObject);
    procedure mnuLimparSeparacaoClick(Sender: TObject);
    procedure btnFaturarOndaSeparacaoClick(Sender: TObject);
    procedure lstStatusPedidoClickCheck(Sender: TObject; AIndex: Integer;
      APrevState, ANewState: TcxCheckBoxState);
    procedure cmbCliLojClick(Sender: TObject);
    procedure btnEntFutCDClick(Sender: TObject);
    procedure btnExpFatAutTodosClick(Sender: TObject);
    procedure tmrTmpRteTimer(Sender: TObject);
    procedure tmrTmpIanTimer(Sender: TObject);
    procedure btnMensagemExpedicaoClick(Sender: TObject);
    procedure lblExibirFiltroStatusPedidosClick(Sender: TObject);
    procedure btnSituacaoItensClick(Sender: TObject);
    procedure mnuRemanejarSeparadorClick(Sender: TObject);
    procedure mnuDesfazerExpedicaoDesteDocumentoClick(Sender: TObject);
    procedure mnuDesfazerExpedicaoDeDocumentoJaBaixadoTotalmenteClick(
      Sender: TObject);
    procedure btnExpedicaoClick(Sender: TObject);
    procedure btnCortarProdutosPedidoClick(Sender: TObject);
    procedure btnDefinirSeparadorConferenteClick(Sender: TObject);
    procedure btnAlterarDataEntregaClick(Sender: TObject);
    procedure grdPedidosVinculadosDBTableViewCitel1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMulSepClick(Sender: TObject);
    procedure dbgPedidosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgPedidosCellClick(Column: TColumn);
    procedure lblOcultarExibirPainelInformacoesClick(Sender: TObject);
    procedure btnExibirProdutosClick(Sender: TObject);
    procedure mnuLimparSeparacaoRomaneioClick(Sender: TObject);
    procedure mnuGuardarItensSepClick(Sender: TObject);
    procedure btnFreteClick(Sender: TObject);
    procedure btnBaixarPedidoNaoEntregueClick(Sender: TObject);
    procedure btnRobSepClick(Sender: TObject);
    procedure dbgPedidosKeyPress(Sender: TObject; var Key: Char);
    procedure gpbTipoExpedicaoClick(Sender: TObject);
    procedure btnImpOrdemProducaoClick(Sender: TObject);
    procedure btnDesmembrarPedClick(Sender: TObject);
    procedure lstLocRetClickCheck(Sender: TObject; AIndex: Integer; APrevState,
      ANewState: TcxCheckBoxState);
    procedure btnAltSitPedClick(Sender: TObject);
    procedure btnAltLotImpSepClick(Sender: TObject);
    procedure btnConsultaPedClick(Sender: TObject);
    procedure tmrBuscarTimer(Sender: TObject);
    procedure cdsFeriadosAfterOpen(DataSet: TDataSet);
    procedure btnReimprimeDocumentoClick(Sender: TObject);
    procedure rdgTipoConferenciaClick(Sender: TObject);
    procedure rdgFiltroDataColetaClick(Sender: TObject);
  private
    { Private declarations }
    strUltimaTemporariaPedidosAbertoExpedicao : String;
    objTemporariaPedidosExpedicao: TTemporariaPedidosExpedicao;
    intPosicaoCds: Integer;
    blnExibirPedidosFaturamentoAutomatico: Boolean;

    blnEmExpedicaoItens : Boolean;
    intSuspensaoTimersRecarga : Integer;
    blnTmrTmpRteAntSuspensao  : Boolean;
    blnTmrTmpIanAntSuspensao  : Boolean;
    blnSenhaReimpressao : Boolean;
    FTipoImpSep  : TTipoImpressaoSeparacao;
    intQtdImpSepWMS,
    intBusEstSal : Integer;

    intStatusPedidoHeight: Integer;

    strSeqSep: String;
    strSenSep: String;

    blnColetor : Boolean;
    cdsPedidos: TUniClientDataSet;
    qryDuplic: TUniQuery;
    qrySeqCon: TUniQuery;
    blnUsaPafEcf: Boolean;

    qryAdiantamentos: TUniQuery;
    cdsAdiantamentos: TUniClientDataSet;

    qryPedidosVinculados: TUniQuery;

    stlSeqFgo : TStringList;
    cdsFilEst : TUniClientDataSet;

    strNumLotSep : String;
    strCodEmpLot : String;
    strDocsLotSep: String;
    blnMarcPedLot: Boolean;

    blnAltEmpFat: Boolean;

    arrVendedor: TConsultasArray;
    arrCliente : TConsultasArray;
    arrEmp     : TConsultasArray;
    arrTransportadora : TConsultasArray;
    arrOperador: TConsultasArray;
    arrLocArm  : TConsultasArray;
    arrRegiao  : TConsultasArray;
    arrCidade  : TConsultasArray;
    arrTpoAte  : TConsultasArray;
    arrDepVen  : TConsultasArray;
    strDtaIni: String;
    strDtaFin: String;
    tipTipoData : TTipFiltExpData;
    strNumPed: String;
    strBarDoc: String;
    strBarCom: String;
    strEspDoc: String;
    strSepImp: String;
    strBuscaSeqSep: String;
    strBuscaSeqOnd: String;
    strCodIte: String;
    strDtaRot: String;
    arrSeqRot: TConsultasArray;
    strEntRet: String;
    strUrgente: String;
    strFatTot: String;

    stlBarDocLocalizar: TStringList;
    strBarDocLocalizar: string;

    tipOrigem: TOrigemPedido;

    stlPedidos: TStringList;
    stlPedidosBkp: TStringList;
    strFatSel: String;
    cdsDocsExcluirLoteSep: TUniClientDataSet;
    strOriSel: String;
    strEmpSel: String;
    strCliSel: String;
    strFazSel: String;
    strEmbSel: String;
    strFpgSel: String;
    strCndSel: String;
    strCodSel: String;
    strVenSel: String;
    strVe2Sel: String;
    strCcrSel: String;
    strOprFlj: String;
    strTraSel: String;
    strIndSel: String; // Comercialização - Industrialização
    strTppSel: String; // Tipo de Pedido ( "A", "B", "C" ou "D" )
    strPorSel: String;
    strTipSel: String;
    strBeFSel: String;
    strCotLal: String;
    strCfgENFUOPSel: String;
    strSolAbaSel: String;
    blnFreRatSel: Boolean;
    blnDecZfmSel: Boolean;
    strRegEspSel: String;
    strUtiResSel: String;
    strTaxJurSel: String;

    strTemAdt: String;
    strBolAdt: String;
    strTemRec: String;
    blnGarSel: Boolean;
    blnPedTra: Boolean;
    dtaEmiSel: TDate;
    dtaPrevSel: TDate;

    FblnTemPedidoDeConsignacao : Boolean;

    strTipExp: String;

    FiltroOnda                     : TFiltroOndaSeparacao;
    strNumeroOnda                  : String;
    blnSolicitaTelaDeVolume        : Boolean;
    intQtdPedOnda                  : Integer;
    intQtdPro                      : Integer;
    intQtdProOndaDe                : Integer;
    intQtdProOnda                  : Integer;
    fltPesoOndaDe                  : Double;
    fltPesoOndaAte                 : Double;
    blnSelPedOndaAut               : Boolean;
    blnOndaSeparacaoUnicoProduto   : Boolean;
    blnOndaSeparacaoVariosProdutos : Boolean;
    blnOndaSeparacaoPorPeso        : Boolean;
    blnSemSeqSep                   : Boolean;
    blnPermiteExpedirPedidoAVistaCaixaFechado : Boolean;
    blnPDExclusivamenteDeKits      : Boolean;

    blnFaturandoTodosAutomaticamente: Boolean;
    blnVendaPerdidaAutomatica: Boolean;

    strFiltroLocFisAnterior: String;
    strLocFis: String;
    strLocIni: String;
    strLocFin: String;
    strLocIniSup: String;
    strLocFinSup: String;

    strMsgPed: String;

    blnFecharForm: Boolean;

    intSemaforoSelecionar: Integer;
    intSemaforoAtualizar: Integer;
    FSemaforoLimparSeparacao: Integer;

    FAtualizarGridDetector: TMethodLoopDetector;

    blnSepExp: Boolean;
    objTipoEntregaRetiraExpedicao : TTipoEntregaRetiraExpedicao;

    strSeparador: String;
    strTipImpSeparacao: String;
    blnSeparacaoDireto: Boolean;
    blnImprimiuSeparacao: Boolean;
    blnImprimiuSeparacaoWmsOnda: Boolean;

    blnNfeXdf: Boolean;
    blnF3 : Boolean;

    blnExecutandoFormShow : Boolean;
    blnExecutandoFormCreate : Boolean;
    blnScrollPedidos : Boolean;
    blnUsaPTF : Boolean;

    blnExpedicaoParcial: Boolean;
    blnUsaImpressaoSeparacaoPorLocal: Boolean;

    blnRegCid: Boolean;

    tfFiltroLocSepArmz: TFiltroLocSepArmz;
    arrLocSep: TLocSepList;
    objLiberacao : TLiberacao;

    strPedidoInicialDoProcesso: String;
    strEspecieDoPedido: String;
    strEmpresaDoPedido: String;

    blnAtualizandoGrid: Boolean;
    objLock: TLock;

    blnSOMNSP: Boolean;
    intTMPDNS: Integer;
    thrNotificacao: TThreadNotificacao;

    blnSomenteCliFil: Boolean;

    blnPermitirAlterarDataEntregaPedido: Boolean;

    qryFerCid: TUniQuery;
    FLisCodCid,
    FLisCodRot,
    FLisAutIncFgo,
    FLisAutIncGer: String;
    FDicBaiEntFut: TDictionary<String,String>;

    FCorSepNaoImp: TColor;
    FCorSepImp: TColor;
    FCorAltSepImp: TColor;
    FCorDocDev: TColor;
    FCorSepReimp: TColor;
    FCorLibSep: TColor;
    FCorIteExp: TColor;
    FCorTotExp: TColor;
    FCorGarantia: TColor;
    FCorDocSel: TColor;
    FCorUrgente: TColor;
    FCorOrdPro :TColor;
    FCorOrdProPendente: TColor;
    FCorVenEmp: TColor;
    FCorVenOutEmp: TColor;
    FCorDocPosFonte: TColor;
    FCorDocPosFundo: TColor;
    FCorDocSelPos: TColor;

    strBotaoAcionado: string;
    strDescDoc: string;

    FTipoItemDoPedidoOndaSeparacao: TTipoItemDoPedidoExp;

    strNumLotSepLimpa: String;

    blnTravarFiltroVendedor: Boolean;

    FValorContabilTotalDocSelecionados : Double;
    FPesoTotalDocSelecionados          : Double;
    FVolumeTotalDocSelecionados        : Double;
    FCubagemTotalDocSelecionados       : Double;
    FValorTotalDocSelecionados         : Double;

    blnExibeResumoExpedicao : Boolean;

    strNumRom : String;
    strCodEmpRom : String;

    FApenasGeracaoDeRemessaDePedido : Boolean;
    strViaConferenciaSeparacao: String;

    FRemoverPedidoLista: Array of String;
    FGuardarItens: Array of String;

    FUtilizaOndaSeparacaoAgrupamento: Boolean;

    blnAtualizouGridNaImpressaoSeparacao: Boolean;
    blnExisteAlgumFeriadoCadastrado: Boolean;

    intDecCub: Integer;
    FSeqSeparacaoParcial: Integer;

    FPedidosCortados,
    FListaPDMarketPlace,
    FItensSemSaldoDispParaAtenderPDOnda: TStringList;
    FDecQtd: Integer;
    tipFiltroPedidoTransf: TFiltroSomentePedidosTransferencia;
    FExcluirExtLar: Boolean;
    blnOndaSeparacaoApenasPedidoFaturadorAutomatico: Boolean;

    function fPermiteApenasGerarRequisicaoParaItensSemEstoque: Boolean;
    function fDeveLimparOsCamposDeCapaDaBaixaDeSeparacao: Boolean;
    function fDeveLimparOsCamposDaBaixaDeSeparacao: Boolean;
    function fUsaExpedicaoPedidoSemUsarBaixaSeparacao: Boolean;
    function FoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada : Boolean;
    function RemesseDePedidoPertenceARemessaDeSeparacao(ARemessaDePedido : String) : Boolean;
    function FoiSelecionadoPedidoComSeparacaoTotalmenteConcluida: Boolean;

    function fLimparSeparacaoDosPedidosSelecionados(pgbStatus: TcxProgressBar = Nil) : Boolean;

    function fOndaSeparacao : Boolean;

    function fGerarSeqSep : String;

    procedure pGerarOndaSeparacao;
    procedure pLimpaOndaSeparacao;

    function fValida_SelecaoDePedidosOndaWMS(var blnSelecionouOndaJaGerada : Boolean) : Boolean;
    function fValida_SelecaoDePedidosOnda_Baixa(var blnCancelou : Boolean) : Boolean;

    function fTemPedidoDeOndaSelecionado : Boolean;

    function fEmExpedicaoItens: Boolean;

    procedure fImprimirSeparacao(tisTipoImp: TTipoImpressaoSeparacao);

    procedure pAtualizaSeqSep(blnGerarOndaManual : Boolean = False);

    function fUtilizandoImpressaoBaixaSeparacaoPassandoPeloColetorOuRobo: Boolean;
    function fPedidoComTintaImobiliaria: Boolean;

    procedure pFaturarExpedidos;

    procedure pCarregaItensPageControls;

    procedure pAjustaAlturaPanelBotoes;

    procedure pLimparVariaveisSeparadorConferenteOndaSeparacao;
    procedure pHabilitarBotaoFaturarOndaSeparacao;
    procedure pHabilitarBotaoFaturarTodos;
    function fPodeFaturarOndaPedidosTotalmenteExpedidos: Boolean;

    function fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem: String): Boolean; overload;

    function fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem: String;
                                                              ATipoItemDoPedido: TTipoItemDoPedidoExp;
                                                              ATipoPedidoPorQuantidadeDeProdutos: TTipoPedidoPorQuantidadeDeProdutosExp;
                                                              ATipoQuantidadeDoItemNoPedido: TTipoQuantidadeDoItemNoPedidoExp): Boolean; overload;

    procedure pFaturarPedidoOndaSeparacaoPeloProduto;
    procedure pFaturarOndaPedidosTotalmenteExpedidos;
    function fRotasPorRegiaoExpedicaoPedido4: boolean;
//    function fValidaSeparacaoEmLocalizacaoTransitoria(strAutInc: String): boolean;
    procedure pExpedirFaturarTodosPedidosAutomaticamente;
    function fVerificaDesmembramento(var blnLimpouSelecaoELocks: Boolean): Boolean;
    procedure pAtualizarSelecao;
    procedure pVerificaExcluirDocumentoLoteSeparacao;
    function fPedidoGuardado: Boolean;
    function fLimpaSeparacaoLoteSep(pgbProgresso: TcxProgressBar): Boolean;
    function fRetVendedores(strValores: String): TConsultasArray;
    function fRetVendedoresExceto(strValores: String): TConsultasArray;
    procedure pBuscaParametrosAutcom;

    function fGetNFeStatusImageIndex(AStatus: String): Integer;
    function fValidaDireitoDeAcessoParaLimparSeparacao: Boolean;
    function fValidaPedidoParaDesmembramento(blnValidarAdiantamento: Boolean): Boolean;
    function fPedidoRegimeEspecial: Boolean;
    procedure pDesmembrarPedido;
    procedure pAbreTelaDesmembramentoDePedido;
    procedure pMostraMensagemNaoImpressos(const lPedidosNaoImpressos: TStringList);
    function fHabilitaImpSep: Boolean;
    function fAvisaOperadorDestinoDiferente(strEntRet: String) : Boolean;
    procedure pAjustaComponentesFeriado;
    procedure pFeriadosPorCodCid(var qryFerCid: TUniQuery; const strLisCodCid: String);
    procedure pCarregaFeriados;
    procedure pExibeCamposFeriado(blnExibir: Boolean);
    procedure pAjustaComponentesDeOrientacaoParaEntrega;

    Const TOTALIZACAO: String = 'TOTAL LANÇAMENTOS:';

    procedure pCarregaOpcoesLocais;

    function fSelecionaDocumentosLote : String;
    function fField(strFieldName: String): TField;
    function fGetCol(strField: String): TColumn;
    function fMostraDuplicatasPedidoExp: Boolean;
    function fMostraAdiantamentosPedidoExp: Boolean;
    function fSelecionado(DataSet: TDataSet): Boolean;
    function fVerificaSelecionado(DataSet: TDataSet): Boolean;
    function fGetQtdDoc(strAlias: String; blnQtdIte: Boolean = False): String;

    function fRetPrimeiroCliConEntreOsDocsInseridos: String;
    function fTemPedidoSelecionadoComServico: Boolean;
    function fTemPedidoSelecionadoComVidros: Boolean;
    function fTemPedidoSelecionadoComDAV: Boolean;
    function fTemPedidoSelecionadoLibSep: Boolean;
    function fValidaSituacaoFinanceiraPedidosSelecionados: Boolean;

    function fValidaItemEspecial(const strEspDoc: String; const strTemItemEspecial : String): Boolean;

    function fGetDescricaoEntRet(strEntRet : String; strEspDoc : String = ''): String;

    procedure pFiltrarPedidos;

    procedure pSelecionarPedidosOndaAutomaticamente;

    procedure pCriarClientDataSetPedidos(const qryPedidos: TUniQuery);
    procedure pDestruirClientDataSetPedidos;

    procedure pCarregaDocumentos(const strTmpPedidosPendentes: String);

    procedure pCarregaPedidos(const strTmpPedidosPendentes: String);
    procedure pSelecionaPedido(strCodBarrasExp: String = '');
    procedure pSelecionaVariosPedidos;

    function fValidarAbastecimentoEstoquePedido: Boolean;
    function fPedidoComFinanceiroOkComCaixaFechado: Boolean;
    function fPermiteSelecionarPedidoAtual(blnImpSep: Boolean = False): Boolean;
    function fPedeSenhaOperador(strInfo: String): String;
    procedure pAtualizaSeparadorPedido(strCodSep: String);

    function fValidaLocalRetiraAoSelecionarPedido(strNumDoc, strEspDoc,
      strCodEmp: String; blnExibirMensagem: Boolean = True): Boolean;

    function fUsaFiltroLocSepTodos: Boolean;
    function fUsaFiltroLocSep: Boolean;
    function fNaoUsaFiltroLocSep: Boolean;
    function fPossuiLocSepPendente: Boolean;

    procedure pBaixarSeparacaoPedido;
    function fBaixarOndaSeparacao(pgbStatus: TcxProgressBar = Nil) : Boolean;

    function fIgnoraImpOrdemProdItemEstrutura: Boolean;
    procedure pImpOrdemProdItemEstrutura;
    function fGerarOrdemProdItemEstrutura(pgbStatus: TcxProgressBar = nil): Boolean;
    function fVerificaOrdProdEstruturaEstaoBaixadas: Boolean;

    function fDigitaLotesPedidoWMS(strCodSep: String): Boolean;
    function fDigitaLotesPedidoWMSOndaDeSeparacao(strCodSep: String): Boolean;

    procedure pImprimirSeparacao;
    procedure pLimpaEstornoSeparacao(strAutInc: String);
    function fSepImpAtualizado: String;
    function fDataImpressao: TDateTime;
    function fHoraImpressao: TDateTime;

    function fUtilizaImpressaoSeparacao: Boolean;

    function fRetTaxaJurosSelAtu: String;
    procedure pAdicionaListaSelecao;
    procedure pRemoveListaSelecao;
    procedure pTravaDadosGerais(stlMsg: TStringList);
    procedure pLimparSelecaoTotalmente;
    procedure pLimparSelecaoELocks;
    function fPedidoLiberado: Boolean;
    function fValidaClientesPedidos(blnMostraMsg: Boolean = True):Boolean;
    procedure pExpedirPedidos(const strTipExpPar: String; blnExpAut : Boolean = False; strCodBarrasExp: String = ''; blnPermiteExpParcial: Boolean = False; blnFaturarExpedidos: Boolean = False);
    function fGetSqlOrdProEstrutura: String;
    function fGetSQLDetVlrCon: String;
    function fGetSqlEntregaRetira: String;
    function fGetSQLPedidos(blnComOrderBy: Boolean; const strTmpPedidosPendentes: String): String;
    function fGetSQLPedidosReposicao(): String;
    function fGetSQLPedidosFaturamentoAutomatico(const strTmpPedidosPendentes: String): String;
    function fSQLFiltroLocalizacaoFisica(): String;
    function fGetSqlOrdProEmitidaBaixada: String;
    function fGetSqlOrdenacaoEntregaRetira: String;
    function fGetSubSelectLogStatus(const AId: Integer; const ASeqFgo, AAlias: string): String;
    procedure pLimpaVariaveisSelecaoPedidos;
    procedure pExibirBotoesLabels;
    procedure pLimparIndices;
    procedure pAtualizarGrid;
    procedure pCarregaListaCodigos;
    procedure pAtualizaNumeroRomaneio;
    procedure pAtualizaLocaisSeparacao;
    procedure pAtualizaDadosDocumentos(blnCalculaTempoExpedicao: Boolean=False);
    procedure pAtualizaPedidosCampoKIT;
    procedure pAtualizaSituacaoFinanceiraPedidos;
    function fRetPedidosAbaDep: TUniQuery;
    function fRetDetalheDocFat: TUniQuery;

    function fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
    //function fQtdOriImpSep(Var blnAbortar: Boolean): Boolean;
    function fSomenteF3: Boolean;
    procedure pResumo;
    function fRetConPagCalculado(strCodCli, strConPag, strCodCnd: String): String;
    procedure pExibeResumo;
    procedure pMontarOpcoesFiltro;
    function fGetTipoDocumento(strPrefixo: String; strAliasComPonto: String = ''): String;
    function fGetTipoDoctoSelecionado(arrOpcSel: Array Of String): Boolean;
    function fRetSQLTemAoMenosUmItemNormal(strTabela: String): String;
    function fRetornaCampoTurno(sCampo: String): String;
    function fCriarArrItensExpedidosPedido(strSeqGer: String; blnPreencheQtdDesmembramento: Boolean = True): TItensExpedidosPedido;
    function fExibirFiltroPorEstoque: Boolean;
    procedure pOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure pFiltrosEstoqueDefault;
    procedure pInicializarFiltroLocSep(blnEstaNaRotinaBaixaSeparacao: Boolean);
    procedure pInicializarFiltroArmazem(blnEstaNaRotinaBaixaSeparacao: Boolean);
    procedure pInicializarFiltroLocSepArmazem(blnEstaNaRotinaBaixaSeparacao: Boolean);
    function fGetCodigoLocSep(): String;
    function fGetDescricaoLocSep(): String;
    function fExibirTempoExpedicao: Boolean;
    function fGetCorTempoAtrasoExpedicao: TColor;
    function fExpedicaoAtrasada: Boolean;
    function fTodosLocSepLiberados(strIncGer, strEspDoc: String): Boolean;
    function fVisualizarGuiche: Boolean;
    function fPermiteReimpressaoDeSeparacao(stlPedSel: TStringList): Boolean;
    procedure pCriarColunasGridExpedicao;
    procedure pGravarConfiguracoesExpedicao;
    function fExibirInformacaoFaturamentoParcial: Boolean;
    function fInformacaoFatTotal: String;
    function fInformacaoFatParcial: String;
    function fRetSQLPedSolicTransf: String;
    function fRetSQLPedReqCompra: String;
    function fExibirDadosTransReqCompraPedido: Boolean;
    function fVerificaItensPendentesSeparacao(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    procedure pRetornaParaPedidoDoInicioDoProcesso;
    procedure pArmazenaPedidoInicialDoProcesso;
    procedure pInicializarFiltroStatusPedido;
    function fEDocumentoDeDevolucao: Boolean;
    procedure pImprimeOndaSeparacaoItensSintetizados;

    procedure pSintetizaItensImpressaoOndaSeparacao(strAutInc : String);

    procedure pInicializarNotificacoes;
    procedure pDisparaThreadNotificacao;
    procedure pAtivaDesativaTimersNotificaoAndRecarga(blnAtivarDesativar: Boolean);
    procedure pEncerraThreadNotificacao;
    procedure pMostraSituacaoItens;

    procedure pVerificaExpPen(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
    procedure pCarregarEmAvisoPedidosDoMesmoClienteNaExpedicao(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
    procedure pCarregarEmAvisoTodosOsPedidosAbertosParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
    procedure pCarregarPedidosCliente(strCodCli, strNomCli : String);

    procedure pCarregarCores;
    function fSqlPedidosVinculados: String;
    procedure pDataChange(Sender: TObject; Field: TField);
    procedure pNotificaOperadorExpedicao(strCliTra: String);
    procedure pTotalizadoresLinhasSelecionadas;
    function fDebitoCliente(): Boolean;
    function fValidaTravaDoc: Boolean;
    function fLiberouLimparSeparacaoItensExpedidos: Boolean;
    procedure pCriaBackUpPedidosSelecionados;
    function fDesmembrarAutomaticamenteSemPerguntarGerandoVendasPerdidas: Boolean;

    function fValidaFormaNegociada(strDocTra, strEspTra, strEmpTra,
      strCodFpg: String; fltValAdt: Double; blnFaturarExpedidos: Boolean): Boolean;
    function fTemPedidoSelecionadoComFormaNegociada: Boolean;

    procedure pCarregarInformacoesPnlDocumentoSelecionados;

    function fSQLOrdemCor():String;
    procedure pDisableControlsInterna;
    procedure pEnableControlsInterna;
    procedure pMarcaPedidosLotes;
    procedure pCarrecaOpcaoOcultarInformacoes;

    procedure pCalculaResumoTotalDocumentos();
    function fSQL_SOMA_ENTFUT: String;
    function fImprimeOrdemProducaoItemEstrutura: Boolean;
    procedure pMontaFiltroLocalRetira;
    procedure pMarcaFiltroLocalRetiraConformeArquivoIniLocal;
    function fTemPedidoDeAbastecimentoPorDepositoComProducaoForaDaLoja: Boolean;
    function fPedidoComFormulacaoEmAberto: Boolean;
    function fAjustaDadosParaImpressaoDeSeparacao(blnAlteraLote: Boolean = False): Boolean;

    function fVerificaTravaConferencia(blnLibera:Boolean; strChaLck:String; blnMsg: Boolean = True):Boolean;
    function fTravaConferenciaPedidosSelecionados(blnBloqueia:Boolean):Boolean;
    function fVerificaTravaRomaneioPedidosSelecionados():Boolean;
    procedure pLiberaTravaVerificandoRomaneioEmAndamento(strChaLck: String);
    procedure pAlteraSituacaoFaturamentoTotalPedido(strAutInc: String; blnFaturaTotal: Boolean);
    function fUtilizaDefinicaoLoteSemWMS: Boolean;

    function fTravaExpedicaoClienteInativo():Boolean;
    function fPermitirFaturarContaOrdem: Boolean;

    procedure pConfigurarTelaDeExpedicaoParaEmitirApenasGeracaoDeRemessaDePedido;

    procedure pGravarViaConferenciaSeperacao(const strAutInc: String);
    procedure pEscolherViaConferencia;
    procedure pLimparSeparacaoParaColetor(const strNumDoc, strEspDoc,
      strCodEmp: String);
    function fPermiteDesmembrarPedidoGeradoDeOutraLoja(const blnExibeMensagem: Boolean): Boolean;
    function fPedidoTemEnvolvimentoComRegimeEspecial(const strRegimeEspecial: String): Boolean;
    procedure pSetarFromFatgor(var strResult: String; const strTmpPedidosPendentes: String);
    function fRetornaTemporariaPedidosPendentes: String;    
    procedure pGetQuantSepConfOnda(const strAutInc: String; out fltQtdSep, fltQtdCnf: Double);
    function fValidaQuantSepConfOnda(const strNumeroOnda: String; const blnValidaQtdSep, blnValidaQtdCnf: Boolean): Boolean;
    procedure pTotalizaValoresPedidosSelecionados();
    function fPermiteNotificacaoSonoraNovosPedidos(const cdsNovosPedidos: TUniClientDataSet): Boolean;
    function fExisteTransferenciaArmazemOuLoteVendaComTinta(
      const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    function fValidaRemessaSeparacao: Boolean;
    function fLiberaLimparPedidoOndaSeparacao: Boolean;
    procedure pValidaPedidosRemessaSeparacao(ACds: TDataSet);
    function fPodeGuardarItensSeparados: Boolean;
    function fValidarSitFinParaImpressaoSeparacao: Boolean;
    function fPermitirDesmembrarVendaTipoExpedicaoPedidoEGerarVendaPerdida: Boolean;
    function fGuardarItensSeparados: Boolean;
    procedure pCarregaSugestaoDadosFiltroVendedor;
    function fGerarTL: Boolean;
    procedure pCarregaItensParaGerarTL(var AQry: TUniQuery);
    procedure pGeraArquivoEdiCorpemSistemas(stlPedidos: TStringList);
    procedure pAtualizaCADVAL;
    procedure pAlteraNomeColumaSEQSEP;
    function fGetSQLTemItemEspecialNoPedido : String;
    function fImprimirSeparacaoParcial: Boolean;

    function fBaixaOrdemProducaoAutomaticamente: Boolean;
    function fEhMarketPlace: Boolean;

    function fColunaVisivel(const strColuna: String): Boolean;

    function fRetornaTotalProdutosPedidos(strListaAutInc: String): Double;
    function fTravaSelecaoPedidoQuantidade(stlPedidoQtd: TStringList; strNumDoc, strEspDoc, strCodEmp: String): Boolean;

    function fLimpaExpedicaoParcialPedido(strAutInc: String; blnFatAut: Boolean = False; ASeqsFDO: String = ''): Boolean;
    function fLimpaExpedicaoPedido(strAutInc: String; blnFatAut: Boolean = False; ASeqsFDO: String = ''): Boolean;
    function fCortePedidosMarketplaceSemSaldo(AEhOndaSeparacao: Boolean = True): Boolean;
    function fValidaTemPedidosIntegracao(var ASomenteMarketPlace: Boolean): Boolean;
    procedure pRemoveLiberacaoPD(AAutInc, AMotBlo: String);
    procedure pExibePedidosIntegracaoSemSaldoDisp(AEhOndaSeparacao: Boolean = True);
    function fPermiteGerarOndaComClientesFilialDiferentes: Boolean;
    procedure pAtualizaPercentualDeSeparacao;
    function fPermiteReimprimirSeparacao: Boolean;
    function fPossuiItensSeparados(ASeqsFGO: String): Boolean;
    function fPodeBaixarSeparacaoPedidoUtilizandoLocTransitoria: Boolean;
    function fPermiteExecutarRotinaAtualizacaoTela : Boolean;
    procedure pSuspenderTimersRecarga;
    procedure pRestaurarTimersRecarga;
    procedure pCarregaGrid;
    procedure pAtualizarRegistrosCanceladosPeloHUB;
    procedure pLimpaSeparacaoPedido(const AExcluiDocumentoLoteSeparacao: Boolean; const AAutIncLotSep: String);
  public
    { Public declarations }
    blnAutSer: Boolean;
    blnApenasPrazo: Boolean;
    blnApenasImprimirBaixarSeparacao: Boolean;
    blnApenasConferenciaProdutosRetiraCaixa: Boolean;

    strUltimoPedidoRetiradaCaixa: String;
    procedure pDrawColumnCell(dbgDados: TDBGridCitel; Column: TColumn; const Rect: TRect);
    function fUtilizaSolicitacaoSeparador: Boolean;
    function fFiltrarLocalSeparacaoItensWMS: Boolean;
    function fRealizouDefinicaoLotesNoLocalSeparacaoSelecionado(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    function fPedeSeparador(tisTipoImp : TTipoImpressaoSeparacao): String;
    function fValidarPedidosClienteEstoqueExterno: Boolean;
    function fValidaPedidosAguardandoComplemento: Boolean;
    function fPedidoGarantiaEnvioParaOClienteTotalmenteFaturado: Boolean;
    function fEhPedidoGarantiaEnvioParaOCliente: Boolean;

    procedure pSetApenasGeracaoDeRemessaDePedido;

  end;

var
  frmFatExpedicao: TfrmFatExpedicao;

Const
  VENDAS        = 'Vendas';
  TRANSFERENCIA = 'Transferências';
  DEVOLUCAO     = 'Devoluções';
  GARANTIA      = 'Garantias';
  TODOS         = 'Todos';
  ECOMMERCE     = 'E-Commerce/Força de Vend.';
  STR_COL_ENTRET = 'GROUP_CONCAT(DISTINCT IF(FATDOR.FDO_ENTFUT = "S", "F", EXTDOR_.FDO_ENTRET))';
  SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO = ' IFNULL( ' +
    ' (SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) ' +
    '    FROM ADTCLI ' +
    '   WHERE ADT_NUMDOC = FGO_NUMDOC ' +
    '     AND ADT_ESPDOC = FGO_ESPDOC ' +
    '     AND ADT_CODEMP = FGO_CODEMP ' +
    '     AND ADT_CODCLI = FGO_CODCLI), 0) ';
  STR_COL_LOCRET = 'GROUP_CONCAT(DISTINCT EXTDOR.FDO_LOCRET)';

  SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO_FATAUT = ' IFNULL( ' +
    ' (SELECT SUM(ADT_VALLAN) ' +
    '    FROM ADTCLI ' +
    '   WHERE ADT_NUMDOC = FGO_NUMDOC ' +
    '     AND ADT_ESPDOC = FGO_ESPDOC ' +
    '     AND ADT_CODEMP = FGO_CODEMP ' +
    '     AND ADT_CODCLI = FGO_CODCLI ' +
    '     AND ADT_TIPLAN = "C"), 0) ';

implementation

uses  untFuncoes, untFatExpedicaoBusca, untFatExpedicaoItens,untReimpressao,
      untObservacao, untExpBuscaChaveNFe, untDigOperador,
      untFatGor, untConstantes, untConsultas, untDuplicatasPedido,
      untFatOrdProTintaMaquina, untOrdPro, System.UITypes, untFatDefineLotesPedidoWMS,
      untGravando, untFatMostraObsCliente, untFuncFatImp,
      untFuncFatTypes, untAdiantamentoCliente, untFuncoesDiarias,
      untFatDesmembrarPedido, untFatExpedicaoBuscaEstoque, untFatAltEmpFatPedido,
      untFatExpSeparacaoItens, untDisparaEmailAut, untSituacaoItensPedido,
      untConfigExpedicao, untCfgColExp, untCfgSugExp, TypesRel, untFatDigCodBarrasProduto,
      untFuncoesEtiquetas, untTSituacaoPedidoVenda, untLegenda, untFuncoesOcorrenciasCRM,
      untMsgLiberacao, untMovimentacaoProgramada, untFuncTinta, untITintaDeMaquina,
      untTipoTinta, untMensagemExplicativa, untValidaSituacaoFinanceiraPedido,
      untFatEmitirEntFutEmpCD, untQckSintetizaItensSep, untMensagemSonora, untConsultaPedidos,
      untTHorOpe, untFatMensagemExpedicao, untValidacoesRotasRegiao, Yapay.Api.Facade, untSolicitaLocalizacaoFisicaTransitoria, untTransferenciaLotesTransitoria,
      Expedicao.TfrmManutencaoSeparadoresPorLocalView, Expedicao.TManutencaoSeparadoresPorLocal,
      untDesfazerExpedicaoDesteDocumento, untDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente, untFatCortarPedido,
      untFatDigSepConferente, untAlteraDataDocumento, untFuncoesRel, untFuncoesRel2, untSeparacaoFina, untCorGrid, untFatLotePedRom,
      untTPixDao, untFatDigRomaneioLoteSeparacao, untRomLge, untFatDocumentosLoteSep, untGarantiaPropriaEmpresaCancelamento,
      untPedidosNaoFaturadosDoMesmoCliente, untTravaCaixa, untFatAltValorFreteSuges, untFatBaixarPedOrcNaoEntregue,
      untFuncoesComodatoCilindroVasilhame, untTiposPix, untImpressaoSeparacao, untFatDefineLoteSeparacao,
      untAdiantamentoClienteGenerico, AgrupamentoDeOndaDeSeparacao.Funcoes, untCadLote,
      untTransferenciaArmazens, untMensagemExplicativa_ComConsultaProdutos, untEditorFastImpressao,
      untSelItensImprimirSeparacao, Shared.Functions.DataSet, Separacao.Classes.Parcial,
      untDefineLotesWMS, untLibExt, AgrupamentoDeOndaDeSeparacao.Types, untMarketPlace,
      untConsultaSituacaoCadastral;

{$R *.dfm}

{ TfrmFatExpedicao }

function TfrmFatExpedicao.fGetCodigoLocSep: String;
begin
  Result := '';

  If (grbLocSep.Visible) And (cmbLocSep.ItemIndex > 0) Then
    Result := arrLocSep[cmbLocSep.ItemIndex - 1].strCodigo;
end;

function TfrmFatExpedicao.fGetCol(strField: String): TColumn;
begin
  Result := fFindColumnByName(dbgPedidos, strField);
end;

function TfrmFatExpedicao.fGetCorTempoAtrasoExpedicao: TColor;
begin
  Result := clWhite;

  If (Not fExibirTempoExpedicao()) Then Exit;

  If (fField('EXPTOL').AsString = 'SIM') Then
    Result := clRed   //$00CCFFFF
  Else
    Result := clLime; //$0096CFA7
end;

{**************************}
{* F - entrega (F)utura   *}
{* E - (E)ntrega imediata *}
{* R - (R)etira           *}
{**************************}
function TfrmFatExpedicao.fGetSQLDetVlrCon: String;
Begin
  Result := '';
  Result := Result + ' (FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ') - ';
  Result := Result + ' IFNULL( ( SELECT SUM(DET_VLRCON) ';
  Result := Result + '   FROM   MOVDET ';
  Result := Result + '   WHERE  DET_NUM_PD = FDO_NUMDOC  ';
  Result := Result + '   AND    DET_ESP_PD = FDO_ESPDOC  ';
  Result := Result + '   AND    DET_EMP_PD = FDO_CODEMP  ';
  Result := Result + '   AND    DET_CODITE = FDO_CODITE  ';
  Result := Result + '   AND    DET_IND_PD = FDO_SEQIND  ';
  Result := Result + '   AND    (SELECT COUNT(BRI_SEQDET) FROM BRIDET WHERE BRI_SEQDET = MOVDET.AUTOINCREM) = 0), 0) ';
End;

function TfrmFatExpedicao.fGetSqlEntregaRetira: String;
begin
  Result := ' ' + STR_COL_ENTRET + ' ';
end;

function TfrmFatExpedicao.fGetSqlOrdProEmitidaBaixada: String;
begin
  Result := 'IF((SELECT COUNT(*) FROM MOVPRO WHERE PRO_CODPRO = FDO_ORDPRO AND PRO_CODEMP = FDO_CODEMP AND (PRO_DTABAI IS NOT NULL) AND FDO_BXSBIT = "S") > 0, "BAIXADA", "EMITIDA")';
end;

{**************************}
{* 1 - (R)etira           *}
{* 2 - (E)ntrega imediata *}
{* 3 - entrega (F)utura   *}
{**************************}
function TfrmFatExpedicao.fGetSqlOrdenacaoEntregaRetira: String;
begin
  Result := ' CONCAT(IF(LOCATE("R", ' + STR_COL_ENTRET + '), "1"," "), ';
  Result := Result + ' IF(LOCATE("E", ' + STR_COL_ENTRET + '), "2"," "), ';
  Result := Result + ' IF(LOCATE("F", ' + STR_COL_ENTRET + '), "3"," ")) ';
end;

function TfrmFatExpedicao.fGetSqlOrdProEstrutura: String;
begin
  Result := '';
  Result := Result + '( SELECT ';
  Result := Result + '    COUNT(*) AS QTD ';
  Result := Result + '  FROM ';
  Result := Result + '    GERMAT ';
  Result := Result + '  WHERE ';
  Result := Result + '    FDO_CODITE = GMT_CODITE )';

  Result := ' GROUP_CONCAT(IF(' + Result + ' > 0 AND FDO_BXSBIT = "S", CONCAT(FATDOR.AUTOINCREM, "-", IFNULL(FDO_ORDPRO, "PENDENTE")),NULL)) ';
end;

function TfrmFatExpedicao.fGetSQLPedidos(blnComOrderBy: Boolean; const strTmpPedidosPendentes: String): String;
const
  SQL_BENFUT = '(SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N", "N", "S") FROM FATDOR FD LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO WHERE FD.FDO_SEQGER = VW_DOCPED.AUTINC) AS BENFUT, ';
  SQL_PEDPAR = 'IF((SELECT (SUM(FDO_QTDBAI) > 0 OR SUM(FDO_JAFATU > 0)) PEDPAR FROM FATDOR FI WHERE FI.FDO_SEQGER = VW_DOCPED.AUTINC), "P", "T") AS PEDPAR, ';
  SQL_QTDPRO = '(SELECT COUNT(0) FROM FATDOR WHERE FDO_SEQGER = VW_DOCPED.AUTINC AND FDO_JAFATU = 0) AS QTDPRO, ';
  SQL_NUMCMP = '(SELECT CAST(SUBSTRING(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR " "), 1, 140)AS CHAR(140)) FROM NUMCMP WHERE CMP_SEQGER = VW_DOCPED.AUTINC) AS NUMCMP, ';
begin
  {********************************************************}
  {*********************** ATENÇÃO ************************}
  {********************************************************}
  {*                                                      *}
  {* AO CRIAR UM CAMPO NESSA FUNÇÃO VEJA ONDE ELA ESTÁ    *}
  {* SENDO USADA, POIS, FAZ UNION EM ALGUNS LUGARES       *}
  {*                                                      *}
  {*****************************************************AF*}

  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE            ';
  Result := Result + '   "FATGOR" AS TABELA , ';
  If fCfgSis('EXOCOR', varBoolean) Then
    Result := Result + ' ORDGRD.ORDCOR AS ORDCOR,     '
  Else
    Result := Result + ' 0 AS ORDCOR,                 ';
  Result := Result + '   FATGOR.AUTOINCREM AS AUTINC, ';
  Result := Result + '   FGO_DTAENT AS DTAENT,        ';
  Result := Result + '   FGO_HORENT AS HORENT,        ';
  Result := Result + '   CAST(CONCAT(FGO_PREVIS, IF(EXTGOR.FGO_HPREVI <> "", " ", ""), COALESCE(EXTGOR.FGO_HPREVI, "") ) AS DATETIME) AS PREVIS, ';
  Result := Result + '   FGO_NUMDOC AS NUMDOC,        ';
  Result := Result + '   FGO_ESPDOC AS ESPDOC,        ';
  Result := Result + '   FGO_CODCLI AS CODCLI,        ';
  Result := Result + '   FGO_SERIE_ AS SERIE_,        ';
  Result := Result + '   CLI_C_G_C_ AS CNPJCPF,       ';
  Result := Result + '   FGO_CODFAZ AS CODFAZ,        ';
  Result := Result + '   FGO_TIPOPE AS TIPOPE,        ';
  Result := Result + '   FGO_ORIGEM AS ORIGOR,        ';
  Result := Result + '   FGO_EMPEXP AS EMPEXP,        ';
  Result := Result + '   CLI_CODREG AS CODREG,        ';
  Result := Result + '   CLI_ORIENT AS ORIENT,        ';
  Result := Result + '   CAST(NULL AS CHAR(255)) AS ENDDOC, ';
  Result := Result + '   COALESCE(ETC_CIDENT, IF(FGO_NOMCON IS NULL, CLI_CODCID, FGO_CIDCON)) AS CODCID_BUSCA , ';
  Result := Result + '   CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUME,   ';
  Result := Result + '   CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS DOCFAT,   ';
  Result := Result + '   FGO_NUMFAT AS NUMFAT,   ';
  Result := Result + '   FGO_TIPFAT AS TIPFAT,   ';
  Result := Result + '   FGO_EMPFAT AS EMPFAT,   ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_NOMCLI') + ' AS NOMCLI, ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CGCCON', 'CLI_C_G_C_') + ' AS CLICGC, ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_FANSOB') + ' AS FANSOB, ';
  Result := Result + '   CLI_CATEGO AS CATEGO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CIDCON',
                     ' IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT)');
  Result := Result + '  AS CODCID, ';

  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_NOMCID, CIDENT.CID_NOMCID) AS NOMCID, ';
  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_ESTADO, CIDENT.CID_ESTADO) AS ESTADO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_ENDCON',
                     '  IF(IFNULL(AUX_ENTGER, "") <> "", ETC_ENDENT, ' +
                     '     CONCAT(CLI_ENDERE, ' +
                     '     IF(IFNULL(CLI_ENDNUM, " ") = " ", " ", CONCAT(", ", CLI_ENDNUM)), ' +
                     '     IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT(" ", CLI_ENDCOM)))) ');
  Result := Result + '  AS ENDERE, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_BAICON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT) ') + ' AS BAIRRO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CEPCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_C_E_P_, ETC_CEPENT) ') + ' AS C_E_P_, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_TELCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_FONE01, ETC_TELENT) ') + ' AS TELEFO, ';

  Result := Result + fRetSQLDescricaoFrete('FGO_TIPFRE') + ' AS TIPFRE, ';

  Result := Result + '   SUM((FDO_TOTPES / FDO_QTDITE) * (FDO_QTDITE - COALESCE(FDO_QTDBAI, 0))) AS PESBRU, ';
  Result := Result + '   FGO_TOTFRE AS TOTFRE, ';
  Result := Result + '   FGO_VOLUME AS VOLUME, ';
  Result := Result + '   SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ', ROUND(' + fGetSQLDetVlrCon + ', 2 ) ) ) AS VLRCON, ';
  Result := Result + '   SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP, ROUND(((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) * (FDO_QTDITE - FDO_QTDBAI), 2 ) ) ) AS VALDOC,   ';
  Result := Result + '   SUM(FDO_QTDITE) AS QTDITE,   ';
  Result := Result + '   FGO_CODEMP AS CODEMP,        ';
  Result := Result + '   FATGOR.FGO_CODFPG AS CODFPG, ';
  Result := Result + '   CONCAT(FPG_CODIGO, " - ", FPG_DESCRI) AS DESFPG, ';
  Result := Result + '   FATGOR.FGO_CONPAG AS CONPAG, ';
  Result := Result + '   FATGOR.FGO_CODCND AS CODCND, ';
  Result := Result + '   EXTGOR.FGO_OPEEXP AS OPEEXP, ';
  Result := Result + '   FATGOR.FGO_CODVEN AS CODVEN, ';
  Result := Result + '   FATGOR.FGO_CODDIG AS CODDIG, ';
  Result := Result + '   VEN.OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '   VEN.OPE_CODDEP    AS DEPVEN, ';
  Result := Result + '   VEN.OPE_CODEMP    AS EMPVEN, ';
  Result := Result + '   FATDOR.FDO_CODVE2 AS CODVE2, ';
  Result := Result + '   FATGOR.FGO_OPRFLJ AS OPRFLJ, ';
  Result := Result + '   FATGOR.FGO_CODTRA AS CODTRA, ';
  Result := Result + '   TRA.TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '   IF(IF(IFNULL(EXTGOR.FGO_INDCOM,"") = "", "C", EXTGOR.FGO_INDCOM) = "C", "Comercialização", "Industrialização") AS INDCOM, ';
  Result := Result + '   EXTGOR.FGO_CODPOR AS CODPOR, ';
  Result := Result + '   IF(IFNULL(AUX_ENTGER, "") <> "", CADREG3.REG_DESREG, CADREG.REG_DESREG) AS DESREG, ';
  Result := Result + '   CADREG.REG_MINFAT AS MINFAT, ';
  Result := Result + '   FATGOR.FGO_MENEXP AS MENEXP, ';
  Result := Result + '   FATGOR.FGO_MENEX2 AS MENEX2, ';
  Result := Result + '   FATGOR.FGO_MENEX3 AS MENEX3, ';
  Result := Result + '   FATGOR.FGO_MENEX4 AS MENEX4, ';
  Result := Result + '   FATGOR.FGO_MEN001 AS MEN001, ';
  Result := Result + '   FATGOR.FGO_MEN002 AS MEN002, ';
  Result := Result + '   AUXGOR.AUX_MEN003 AS MEN003, ';
  Result := Result + '   AUXGOR.AUX_MEN004 AS MEN004, ';
  Result := Result + '   AUXGOR.AUX_MEN005 AS MEN005, ';
  Result := Result + '   EXTGOR.FGO_OPBXSE AS OPBXSE, ';
  Result := Result + '   EXTGOR.FGO_DTBXSE AS DTBXSE, ';
  Result := Result + '   EXTGOR.FGO_HRBXSE AS HRBXSE, ';
  Result := Result + '   EXTGOR.FGO_DTIMSE AS DTIMSE, ';
  Result := Result + '   EXTGOR.FGO_HRIMSE AS HRIMSE, ';
  Result := Result + '   EXTGOR.FGO_SEQSEP AS SEQSEP, ';
  Result := Result + '   EXTGOR.FGO_SEQOND AS SEQOND, ';
  Result := Result + '   CASE WHEN (SELECT COUNT(1) FROM SEPDOR ';
  Result := Result + '              WHERE SEP_SEQFDO = FATDOR.AUTOINCREM) = 0 THEN "N" ELSE "S" END AS TEMSEPDOR, ';

  //itens para serem utilizados no filtro , adiciona o [] para utilizar a busca contida no cds
  Result := Result + '   GROUP_CONCAT(FATDOR.FDO_CODITE) AS CODITENS, ';

  Result := Result + '   IF(FATGOR.FGO_SEPIMP = "N" OR IFNULL(FATGOR.FGO_SEPIMP,"") = "","0",IF(FATGOR.FGO_SEPIMP = "S","1",FATGOR.FGO_SEPIMP)) AS SEPIMP, ';
  Result := Result + '   EXTGOR.FGO_OPEDES AS OPEDES, ';
  Result := Result + '   DES.OPE_NOMOPE    AS OPDENO, '; //Nome Operador Designado.
  {COLUNA TIPO FATURAMENTO QUE SERÁ EXIBIDA NO GRID/CONFIGURAÇÃO DA CONSULTA}
  If (fCfgSis('TPDCEX') = '1') and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
  Begin
    Result := Result + '   CASE WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "A") THEN "(A)NF" ';
    Result := Result + '        WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "B") THEN "(B)FF" ';
    Result := Result + '        WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "C") THEN "(C)IF" ';
    Result := Result + '        ELSE "" END AS FTIPPED, ';
  End;
  {MANTENDO COLUNA SEM FORMATO UTILIZADA EM OUTRAS CHECAGENS - NÃO É EXIBIDA NO GRID}
  Result := Result + '   FATGOR.FGO_TIPPED AS TIPPED, ';
  Result := Result + '   FATGOR.FGO_CLICTT AS CLICTT, ';
  Result := Result + '   EXTGOR.FGO_OBSEXP AS OBSEXP, ';
  Result := Result + '   IF(IFNULL(EXTGOR.FGO_ENTURG, "") = "S", "SIM", "") AS ENTURG, ';
  Result := Result + '   EXTGOR.FGO_SEPEXP AS CODSEP, ';
  Result := Result + '   EXTGOR.FGO_FASOBR AS FASOBR, ';
  Result := Result + '   EXTGOR.FGO_CODROT AS CODROT, ';
  Result := Result + '   ENTREG.ENT_DTAENT AS DTAROT, ';
  Result := Result + '   ENTREG.ENT_CODIGO AS SEQROT, ';
  Result := Result + '   CADREG2.REG_DESREG AS DESREG2,';
  Result := Result + '  0.00 AS VRROTA, ';

  Result := Result + '   ROTREG.ROT_VLRMIN AS VLRMIN, ';
  Result := Result + '   ENTREG.ENT_LIBSEP AS LIBSEP, ';
  Result := Result + '   CONCAT(IFNULL(EXTGOR.FGO_SEPEXP, ""), "-", IFNULL(SEP.OPE_NOMOPE, "")) AS NOMSEP, ';
  Result := Result + '   CAST(CONCAT(FGO_DTALIC, " ", FGO_HORLIC) AS DATETIME) AS DTALIC, ';
  Result := Result + '   CAST(CONCAT(FGO_DTALIB, " ", FGO_HORLIB) AS DATETIME) AS DTALIB, ';
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

  Result := Result + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' AS VALADT, ';
  Result := Result + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO_FATAUT + ' AS VALADT_FATAUT, ';

  Result := Result +  '   CASE ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' = 0 THEN "Pendente" ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0) - FGO_BOLADT) THEN "Parcialmente" ';
  Result := Result +  '     ELSE "Realizado" ';
  Result := Result +  '   END AS SITADT, ';

  Result := Result + '   (SELECT ';
  Result := Result + '      GROUP_CONCAT(FPN_CODFPG) ';
  Result := Result + '    FROM ';
  Result := Result + '      FPGNEG ';
  Result := Result + '    WHERE ';
  Result := Result + '      FPGNEG.FPN_SEQFGO = FATGOR.AUTOINCREM) AS FPGNEG, ';

  If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) And
     (Not fCfgSis('NPLF11', VarBoolean)) And (Not fCfgSis('LOCRET', VarBoolean)) Then
  Begin
    Result := Result + '  "N" AS ORIF11,';
  End
  Else
  Begin
    Result := Result + ' (SELECT ';
    Result := Result + '    IF(COUNT(*) > 0, "S", "N") ';
    Result := Result + '  FROM ';
    Result := Result + '    FATDOR AS PEDORI ';
    Result := Result + '  WHERE ';
    Result := Result + '    PEDORI.FDO_NUMFAT = FATGOR.FGO_NUMDOC AND ';
    Result := Result + '    PEDORI.FDO_TIPFAT = FATGOR.FGO_ESPDOC AND ';
    Result := Result + '    PEDORI.FDO_EMPFAT = FATGOR.FGO_CODEMP) AS ORIF11, ';
  End;

  Result := Result + '   EXTGOR.FGO_TOTBRI AS TOTBRI, ';
  Result := Result + '   EXTGOR.FGO_BOLADT AS BOLADT, ';
  Result := Result + '   EXTGOR.FGO_BOLVEN AS BOLVEN, ';
  Result := Result + '   "OK" AS SITFIN, ';
  Result := Result + '   EXTGOR.FGO_SEQDMP AS SEQDMP, ';

  Result := Result + '   EXTGOR.FGO_TX_PIX AS TX_PIX, ';
  Result := Result + '   EXTGOR.FGO_EMPPIX AS EMPPIX, ';

  Result := Result + '   IF(SUM(IF(LOCATE(FDO_CODFIS, "' + CST_SUBSTITUICAO + '") > 0, 1, 0)) > 0, TRUE, FALSE) AS TEMSUB, ';
  Result := Result + '   IF(SUM(EXTDOR.FDO_QTDEXP) > 0 AND ((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(EXTDOR.FDO_QTDEXP)), "S", "N") AS TEMEXP, ';
  Result := Result + '   IF((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) = SUM(EXTDOR.FDO_QTDEXP), "S", "N") AS EXPTOT, ';
  Result := Result + '   IF(LOCATE("PENDENTE", ' + fGetSqlOrdProEstrutura + '), "PENDENTE", IF(IFNULL(' + fGetSqlOrdProEstrutura + ', "") <> "", ' + fGetSqlOrdProEmitidaBaixada + ', "")) AS ORDPRO, ';
  Result := Result + '   (' + fGetSqlOrdProEstrutura + ') AS ITE_OP, ';
  Result := Result + '   CAST(' + fGetSqlEntregaRetira   + ' AS CHAR(10)) AS ENTRET, ';
  Result := Result + '   CAST(' + fGetSqlOrdenacaoEntregaRetira + ' AS CHAR(10)) AS IND_ENTRET, ';
  Result := Result + '   CASE WHEN (IFNULL(FGO_PEDSIT,"") <> "") THEN "S" ';
  Result := Result + '        WHEN (IFNULL(FGO_NUMPOK,"") <> "") THEN "P" ';
  Result := Result + '        ELSE "B" END AS ORIPED, ';
  Result := Result +  fSQLBarDoc('FGO') + ' AS BARDOC, ';
  Result := Result + '   IF(EXTGOR.FGO_CLILOJ = "S", "Sim", "Não") AS CLILOJ, ';
  Result := Result + '   FGO_BARCOM AS BARCOM, ';
  Result := Result + '   IFNULL(TRA.TRA_PRIEXP, 0) AS PRIEXP, ';
  Result := Result + '   IF(IFNULL(MIN(EXTDOR.FDO_DTENTR),FGO_DTENTR) < FGO_DTENTR, FGO_DTENTR, IFNULL(MIN(EXTDOR.FDO_DTENTR),FGO_DTENTR)) AS DTENTR, ';
  Result := Result + fRetornaCampoTurno('EXTDOR.FDO_TURENT') + ', ';
  Result := Result + '   FGO_CODTPA AS CODTPA, ';
  Result := Result + '   CAST(' + STR_COL_LOCRET   + ' AS CHAR(10)) AS LOCRET, ';

  If blnUsaPafEcf Then
  Begin
    Result := Result + ' (SELECT IF(COUNT(*) > 0, "S", "N") ';
    Result := Result + '    FROM DAVPVG ';
    Result := Result + '    WHERE ';
    Result := Result + '      DPG_NUMDOC = FGO_NUMDOC AND ';
    Result := Result + '      DPG_ESPDOC = FGO_ESPDOC AND ';
    Result := Result + '      DPG_CODEMP = FGO_CODEMP) AS TEMDAV, ';
  End
  Else
  Begin
    Result := Result + ' "N" AS TEMDAV, ';
  End;

  Result := Result + fGetSQLTemItemEspecialNoPedido + ' AS TEMITEESP, ';
  Result := Result + '   IF(IFNULL(FGO_TOTSER,0) > 0, "S", "N") AS TEMSER ';

  If (grbLocSep.Visible) Then
  Begin
    Result := Result + ', CAST(NULL AS CHAR(255)) AS CODLSE ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPEN ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPAR ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSELIB ';
  End;

  If lblLocArm.Visible Then
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LCLAMZ ';

  If (fCfgSis('CADEMB', varBoolean)) Then
    Result := Result + ' ,EXTGOR.FGO_CODEMB AS CODEMB ';

  If (fVisualizarGuiche()) Then
    Result := Result + ', IF(IFNULL(EXTGOR.FGO_NUMGUI, "") = "", 0, EXTGOR.FGO_NUMGUI) AS GUICHE ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean)) Then
    Result := Result + ', TPA_DESCRI AS DESTPA ';

  If (fExibirTempoExpedicao) Then
  Begin
    Result := Result + ',IFNULL( ';
    Result := Result + '   TIMESTAMPDIFF( ';
    Result := Result + '     SECOND, ';
    Result := Result + '     CONCAT( ';
    Result := Result + '       DATE_FORMAT(FGO_DTAENT, "%Y-%m-%d"), ';
    Result := Result + '       " ", ';
    Result := Result + '       DATE_FORMAT(FGO_HORENT, "%H:%i") ';
    Result := Result + '     ), ';
    Result := Result + '     CONCAT( ';
    Result := Result + '       DATE_FORMAT(CURRENT_DATE, "%Y-%m-%d"), ';
    Result := Result + '       " ", ';
    Result := Result + '       DATE_FORMAT(CURRENT_TIME, "%H:%i") ';
    Result := Result + '     ) ';
    Result := Result + '   ), ';
    Result := Result + '   "0" ';
    Result := Result + ' ) AS TMPEXP ';
    Result := Result + ', CAST(NULL AS CHAR(3)) AS EXPTOL ';
  End;

  if fCfgSis('BOXWMS', varBoolean) Then
  Begin
    Result := Result + ', ';
    Result := Result + ' (SELECT BOX_CODIGO FROM CADBOX            ';
    Result := Result + '  WHERE BOX_NUMDOC = FGO_NUMDOC            ';
    Result := Result + '    AND BOX_ESPDOC = FGO_ESPDOC            ';
    Result := Result + '    AND BOX_EMPDOC = FGO_CODEMP) AS CODBOX ';
  End;

  If (fExibirInformacaoFaturamentoParcial()) Then
    Result := Result + ', IF(FGO_FATTOT = "S", "' + fInformacaoFatTotal() + '", "' + fInformacaoFatParcial() + '") AS FATTOT '
  Else
    Result := Result + ', " " AS FATTOT ';

  Result := Result + ', FGO_FATTOT AS TOTFAT ';

  If (fExibirDadosTransReqCompraPedido()) Then
  Begin
    Result := Result + ', (' + fRetSQLPedSolicTransf() + ') AS PEDTRF ';
    Result := Result + ', (' + fRetSQLPedReqCompra() + ') AS REQCOM ';
  End
  Else
  Begin
    Result := Result + ', " " AS PEDTRF ';
    Result := Result + ', " " AS REQCOM ';
  End;

  If fCfgSis('EXISTA', varBoolean) Then
  Begin
    Result := Result + ', CAST("" AS CHAR(30)) AS STATUS ';
    Result := Result + ', IFNULL(S.STA_DESCRI, CAST("" AS CHAR(80))) AS FGO_STATUS ';
  End;

  Result := Result + ',  CAST("" AS CHAR(4)) AS CLAFIS ';
  Result := Result + ' , IF(IFNULL(MOVGPV.AUTOINCREM, 0) = 0, 0, 1) AS TEMMOVGPV ';

  Result := Result + ',  ROMLGE.RLG_NUMLOT AS ROMDOC ';
  Result := Result + ',  ROMLGE.RLG_DESLOT AS ROMDES ';
  Result := Result + ',  "N" AS KIT ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS KITEST ';
  Result := Result + ',  IFNULL(AUX_ENFUOP, "1") AS ENFUOP ';
  Result := Result + ',  EXTGOR.FGO_ENVCON AS ENVCON ';
  Result := Result + ',  FGO_FRERAT AS FRERAT ';
  Result := Result + ',  FGO_REGDES AS UTIRES ';
  Result := Result + ',  FGO_TAXJUR AS TAXJUR ';
  Result := Result + ',  FGO_ZERTAX AS ZERTAX ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS EPFTGE ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS SOLABA ';
  Result := Result + ',  GROUP_CONCAT(DISTINCT EXTDOR.FDO_REGESP) AS REGESP ';
  Result := Result + ',  CAST(GROUP_CONCAT(DISTINCT EXTDOR.FDO_PEGOU_) AS CHAR(10)) AS PEGOU_ ';
  Result := Result + ',  IFNULL(FGO_CORTE_, "N") AS CORTE_ ';
  Result := Result + ',  "N" AS FATAUT ';
  Result := Result + ',  " " AS NFESTA ';
  Result := Result + ',  " " AS NFEOBS ';
  Result := Result + ',  "N" AS CRTFIL ';
  Result := Result + ',  FGO_ESPECI AS ESPECI ';
  Result := Result + ',  FGO_COTLAL AS COTLAL ';

  if ((fCfgSis('CONEQU') = 'S')) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
  begin
    Result := Result + ' ,  (SELECT E.EQU_NUMOSE FROM EQUGER E ';
    Result := Result + '     WHERE E.EQU_NUMPED = FATGOR.FGO_NUMDOC AND E.EQU_EMPPED = FATGOR.FGO_CODEMP ';
    Result := Result + '         AND E.EQU_TIPPED = FATGOR.FGO_ESPDOC) NUMOSE ';
  end;

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_CODLAR SEPARATOR ", ") ';
  Result := Result + '        FROM EXTLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON EXTLAR.SEQ_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE EXTLAR.COD_FATGOR = FATGOR.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS CODLAR ';

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_DESLAR SEPARATOR ", ") ';
  Result := Result + '        FROM EXTLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON EXTLAR.SEQ_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE EXTLAR.COD_FATGOR = FATGOR.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS DESLAR ';

  If VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA Then
  Begin
    Result := Result + ', 0.00 AS FRESUG ';
    Result := Result + ', 0.00 AS FRECOT ';
  End;

  Result := Result + ', EXTGOR.FGO_DECZFM AS DECZFM ';
  Result := Result + ', EXTGOR.FGO_VENPRE AS VENPRE ';
  Result := Result + ', FATGOR.FGO_NUMROM AS NUMROM ';
  Result := Result + ', FATGOR.FGO_EMPROM AS EMPROM ';
  Result := Result + ', CAST("0.00" AS CHAR(10)) AS PERSEP';
  Result := Result + ', FORMAT((IFNULL(((SUM(IFNULL(EXTDOR.FDO_QTDEXP, 0)) * 100) / (SUM(FDO_QTDITE) - SUM(FDO_QTDBAI))), 0)), 2) AS PERCOF';
  Result := Result + ', SUM(COALESCE(EXTDOR.FDO_CUBAGE, 0)) AS CUBAGEM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + ',  TRD.TRA_NOMTRA AS TRARDP ';

  Result := Result + ', EXTGOR.FGO_DTDIEN AS DTDIEN ';
  Result := Result + ', EXTGOR.FGO_DTLIEN AS DTLIEN ';
  Result := Result + ', EXTGOR.FGO_DTCOAG AS DTCOAG ';

  Result := Result + ', (CASE ';
  Result := Result + '     WHEN CADCLI.CLI_NOMCLI LIKE "%CONSUMIDOR%" THEN ';
  Result := Result + '       FATGOR.FGO_IESCON ';
  Result := Result + '   ELSE ';
  Result := Result + '     CADCLI.CLI_I_E_S_ ';
  Result := Result + '   END)  AS INSEST ';

  If (fCfgSis('EXQTIT', varString) = 'S') Then
  Begin
    Result := Result + ', (SELECT  COUNT(FDO_CODITE)               '+
                       '   FROM                                    '+
                       '     FATDOR FD                             '+
                       '   WHERE FD.FDO_SEQGER = FATGOR.AUTOINCREM ) AS QTDSKU ';
  End;

  Result := Result + ', FGO_NUMPOK AS NUMPOK ';
  Result := Result + ', EXTGOR.FGO_CANHUB AS CANHUB ';
  Result := Result + ', EXTGOR.FGO_STAHUB AS STAHUB ';

  pSetarFromFatgor(Result, strTmpPedidosPendentes);

  Result := Result + '   LEFT JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  Result := Result + '   LEFT JOIN CADFPG ON FPG_CODIGO = FATGOR.FGO_CODFPG ';
  Result := Result + '   LEFT JOIN CADCID ON CADCID.CID_CODCID = IF(FGO_NOMCON IS NULL, CLI_CODCID, FGO_CIDCON) ';
  Result := Result + '   LEFT JOIN CADTRA TRA ON TRA.TRA_CODTRA = FATGOR.FGO_CODTRA ';
  Result := Result + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '   LEFT JOIN CADREG ON REG_CODREG = CADCLI.CLI_CODREG ';

  Result := Result + '   JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER AND FDO_JAFATU = 0 ';

  Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';

  Result := Result + '   LEFT JOIN CADOPE SEP ON SEP.OPE_CODOPE = EXTGOR.FGO_SEPEXP ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = FATGOR.FGO_CODVEN ';
  Result := Result + '   LEFT JOIN CADOPE DES ON DES.OPE_CODOPE = EXTGOR.FGO_OPEDES ';

  Result := Result + '   LEFT JOIN ENTREG ON ENT_CODIGO = EXTGOR.FGO_CODROT ';

  if fCfgSis('ROTEMP', varBoolean) then
    Result := Result + ' AND ENT_CODEMP = FATGOR.FGO_CODEMP ';

  Result := Result + '   LEFT JOIN CADREG CADREG2 ON CADREG2.REG_CODREG = ENTREG.ENT_CODREG ';
  Result := Result + '   LEFT JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
  Result := Result + '   LEFT JOIN FGOSTA S ON FGO_STATUS = S.STA_CODIGO  ';

  Result := Result + '   LEFT JOIN AUXGOR ON AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + '   LEFT JOIN ENTCLI ECGOR ON ECGOR.AUTOINCREM = AUXGOR.AUX_ENTGER ';
  Result := Result + '   LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = ECGOR.ETC_CIDENT ';
  Result := Result + '   LEFT JOIN CADREG CADREG3 ON CADREG3.REG_CODREG = ECGOR.ETC_CODREG ';
  Result := Result + '   LEFT JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM ';

  {Liberação de Pedidos Externos}
  If fCfgSis('LIBEXT', varBoolean) Then
  Begin
    Result := Result + '   LEFT JOIN LIBEXT ON (LEX_NUMDOC = FATGOR.FGO_NUMDOC AND ';
    Result := Result + '                        LEX_ESPDOC = FATGOR.FGO_ESPDOC AND ';
    Result := Result + '                        LEX_CODEMP = FATGOR.FGO_CODEMP)    ';
  End;

  If (fCfgSis('CONEQU') = 'S') Then
  Begin
    Result := Result + '   LEFT JOIN EQUGER ON EQU_NUMPED = FGO_NUMDOC ';
    Result := Result + '                   AND EQU_TIPPED = FGO_ESPDOC ';
    Result := Result + '                   AND EQU_EMPPED = FGO_CODEMP ';
    Result := Result + '                   AND EQU_VENPED = FGO_CODVEN ';
  End;

  Result := Result + '  LEFT JOIN EXTDOR AS EXTDOR_ ON FATDOR.AUTOINCREM = EXTDOR_.FDO_SEQFDO ';

  Result := Result + ' LEFT JOIN ROMLDE ON FATGOR.FGO_NUMDOC = ROMLDE.RLD_NUMDOC AND FATGOR.FGO_ESPDOC = ROMLDE.RLD_ESPDOC AND FATGOR.FGO_CODEMP = ROMLDE.RLD_CODEMP ';
  Result := Result + ' LEFT JOIN ROMLGE ON ROMLDE.RLD_SEQRLG = ROMLGE.AUTOINCREM ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean))Then
    Result := Result + '  LEFT JOIN CADTPA ON TPA_CODIGO = FGO_CODTPA ';

  If (fCfgSis('EXOCOR', varBoolean)) Then
    Result := Result + ' LEFT JOIN ' + fSQLOrdemCor() + ' ON FATGOR.AUTOINCREM = ORDGRD.AUTOINCREM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + '  LEFT JOIN CADTRA TRD ON EXTGOR.FGO_TRARDP = TRD.TRA_CODTRA';

  Result := Result + ' WHERE                            ';
  Result := Result + '   ((FGO_VLRCON > 0) OR (FGO_TEMBRI = "S"))  AND  ';
  Result := Result + '   FGO_ESPDOC = "PD" AND          ';
  Result := Result + '   FGO_TIPOPE <> "R" AND          ';

  Result := Result + '   NOT EXISTS (SELECT SEQ_FATDOR FROM SEQGAR ';
  Result := Result + '               INNER JOIN FATDOR ON FATDOR.AUTOINCREM = SEQ_FATDOR ';
  Result := Result + '               WHERE FDO_SEQGER = FATGOR.AUTOINCREM) AND ';

  {Liberação de Pedidos Externos - Oculta "Não Liberados" externos (Mobile e Site)}
  If fCfgSis('LIBEXT', varBoolean) Then
  Begin
    Result := Result + ' ((LEX_LIBPOK = "S") OR (LEX_LIBPOK IS NULL)) AND ';
  End;

  If fCfgSis('PD_EXP', varBoolean) And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    Result := Result + '   EXTGOR.FGO_PD_EXP = "S" AND  ';

  Result := Result + fGetTipoDocumento('FGO');
  Result := Result + fFiltroEmpresaExpedicaoPedido;
  Result := Result + fRetSQLTemAoMenosUmItemNormal('FATGOR');

  If blnApenasConferenciaProdutosRetiraCaixa Then
  Begin
    Result := Result + '   EXTDOR.FDO_LOCRET = "C" AND  ';//Local de retira caixa
  End
  Else If fCfgSis('LOCRET', VarBoolean) Then
  Begin
    If Not (fUsaRotinaExpedicaoConferenciaRetiraCaixa And blnApenasImprimirBaixarSeparacao) Then
      Result := Result + '   EXTDOR.FDO_LOCRET <> "C" AND  ';//Local de retira caixa deve ser ignorado
  End;

  If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
    If fCfgSis('EMPFAT', VarBoolean) Then
      Result := Result + '  FDO_EMPITE = "' + VS_strCodEmp + '" AND ';

  Result := Result + '   IFNULL(FGO_LIBERA, 0) > 0 AND  ';
  Result := Result + '   IFNULL(FGO_LIBCOM, 0) > 0 AND  ';
  Result := Result + '   IFNULL(EXTGOR.FGO_LOC_PD, "N") <> "S" AND  ';

  {****************************************************************************}
  {* ATENÇÃO! ANTES DE ALTERAR A LINHA ABAIXO CONVERSAR COM RENAN OU MÁRIO.   *}
  {* REFERENTE: LENTIDÃO NA PALÁCIO DAS FERRAMENTAS, REQUISITO: "120624"      *}
  {****************************************************************************}
  Result := Result + '   FGO_JAFATU = 0 AND            ';

  Result := Result + '   FGO_DOCEND IS NULL AND         ';

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (Not fCfgExpedicaoParcialHabilitada) Then
    Result := Result + '   FGO_DTLBEX IS NULL AND  ';

  If fCfgSis('BAISEP', varBoolean) Then
  Begin
    If blnApenasImprimirBaixarSeparacao Then
    Begin
      Result := Result + '   FGO_OPBXSE IS NULL AND ';

      If fCfgSis('EXBXTO', varBoolean) And (Not fCfgSis('ONDASE', VarBoolean)) Then
        Result := Result + '   EXTDOR.FDO_OPBXSE IS NULL AND ';

      If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
        Result := Result + '   EXTDOR.FDO_EXIBSE = "S" AND ';
    End
    Else
    Begin
      If (blnUsaImpressaoSeparacaoPorLocal And fCfgSis('EXBXTO', varBoolean)) or fPermiteImprimirSeparacaoParcial Then
        Result := Result + '   ((FDO_QTDITE - FDO_QTDBAI) - (FDO_QTDITE - EXTDOR.FDO_QTDSEP)) > 0 AND '
      Else
      Begin
        Result := Result + '   FGO_OPBXSE IS NOT NULL AND ';

        If fCfgSis('EXBXTO', varBoolean) And (Not fCfgSis('ONDASE', VarBoolean)) Then
          Result := Result + '   EXTDOR.FDO_OPBXSE IS NOT NULL AND ';
      End;
    End;
  End;

  If (fCfgSis('CONEQU') = 'S') And ((fCfgSis('EQUEXP', varString) = 'N') or fCfgSis('FPOSCP',varBoolean)) Then
    Result := Result + '   EQU_NUMPED IS NULL AND ';

  If Not fEmptyStr(fCfgSis('ITEMAN')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITELAN')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITEBOM')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITETAX')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')) + ' AND ';

  Result := Result + '   (IF(FDO_ENTFUT = "" OR FDO_ENTFUT IS NULL,"N", FDO_ENTFUT) = "N") ';

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EQUEXP', varBoolean)) And (fCfgSis('USASER', varBoolean)) Then
  Begin
    Result := Result + ' AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
    Result := Result + ' AND FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
  End;

  If tipFiltroPedidoTransf <> tfNao Then
    Result := Result + ' AND FGO_CODCLI IN ('  + fRetClientesFilial + ') ';

  if fCfgSis('EXINPD', varBoolean) then
  begin
    Result := Result + ' AND ((FGO_BOLVEN = "S") OR ';
    Result := Result + '    ( ';
    Result := Result + '    ((SELECT COUNT(*) ';
    Result := Result + '      FROM FATDOR FD ';
    Result := Result + '      LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
    Result := Result + '      WHERE FD.FDO_SEQGER = FATGOR.AUTOINCREM ';
    Result := Result + '        AND IFNULL(ED.FDO_INCFUT,"") <> "" ) > 0) ';
    Result := Result + '   OR ';
    Result := Result + '    ((SELECT COUNT(*) ';
    Result := Result + '      FROM FATDOR FATDOR_F11';
    Result := Result + '      WHERE FATDOR_F11.FDO_NUMFAT = FGO_NUMDOC ';
    Result := Result + '        AND FATDOR_F11.FDO_TIPFAT = "PD" ';
    Result := Result + '        AND FATDOR_F11.FDO_EMPFAT = FGO_CODEMP ';
    Result := Result + '        AND FATDOR_F11.FDO_ESPDOC = "PD" ) > 0) ';
    Result := Result + ' )) ';
  end;

  Result := Result  + fSQLFiltroLocalizacaoFisica();

  Result := Result + ' GROUP BY                                         ';
  Result := Result + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ';

  Result := ' SELECT ' +
              SQL_BENFUT +
              SQL_PEDPAR +
              SQL_QTDPRO +
              SQL_NUMCMP +
              fGetSubSelectLogStatus(pvAgSeparacao.fGetId(),   'VW_DOCPED.AUTINC', 'AGSEPA') +
              fGetSubSelectLogStatus(pvSeparando.fGetId(),     'VW_DOCPED.AUTINC', 'INISEP') +
              fGetSubSelectLogStatus(pvAgFaturamento.fGetId(), 'VW_DOCPED.AUTINC', 'AGFATU') +
            ' VW_DOCPED.* FROM ( '+Result+' ) AS VW_DOCPED ';

  If Not blnApenasConferenciaProdutosRetiraCaixa Then
  Begin
    If objTipoEntregaRetiraExpedicao.fGetTipo <> objTipoEntregaRetiraExpedicao.TODOS Then
    Begin
      If tipFiltroPedidoTransf = tfRetiraEEntrega Then
        Result := Result + '   WHERE (IF(CODCLI IN ('  + fRetClientesFilial + ') , 1=1, ENTRET = "'+objTipoEntregaRetiraExpedicao.fGetTipo+'" ))'
      Else
        Result := Result + '   WHERE ENTRET = "'+objTipoEntregaRetiraExpedicao.fGetTipo+'" ';
    End;
  End;

  {*******************************************************}
  {* ADICIONADO PARA MOSTRAR AS REPOSIÇÕES DE GARANTIA.  *}
  {****************************************************LS*}
  If (blnNfeXdf                              And
     ((VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO))  And
     (Not blnApenasConferenciaProdutosRetiraCaixa) And
      fGetTipoDoctoSelecionado([GARANTIA, TODOS])) Then
  begin
    Result := Result + ' UNION ALL ';
    Result := Result + fGetSQLPedidosReposicao;
  end;
  //*******************************
  //*******************************

  {*************************************************************}
  {* ADICIONADO PARA MOSTRAR PEDIDOS DE FATURAMENTO AUTOMATICO *}
  {*********************************************************JC**}
  If blnExibirPedidosFaturamentoAutomatico Then
  Begin
    Result := Result + ' UNION ALL ';
    Result := Result + fGetSQLPedidosFaturamentoAutomatico(strTmpPedidosPendentes);
  End;

  If (blnComOrderBy) Then
  Begin
    Result := Result + ' ORDER BY IND_ENTRET, PRIEXP, DTAENT, HORENT, NUMDOC '
  End;

end;

function TfrmFatExpedicao.fGetSQLPedidosFaturamentoAutomatico(const strTmpPedidosPendentes: String): String;
const
  SQL_BENFUT = '(SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N", "N", "S") FROM FATDOR FD LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO WHERE FD.FDO_SEQGER = VW_FATAUT.AUTINC) AS BENFUT, ';
  SQL_PEDPAR = '"A" AS PEDPAR, ';
  SQL_QTDPRO = '(SELECT COUNT(0) FROM FATDOR WHERE FDO_SEQGER = VW_FATAUT.AUTINC) AS QTDPRO, ';
  SQL_NUMCMP = '(SELECT CAST(SUBSTRING(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR " "), 1, 140)AS CHAR(140)) FROM NUMCMP WHERE CMP_SEQGER = VW_FATAUT.AUTINC) AS NUMCMP, ';
begin
  {********************************************************}
  {*********************** ATENÇÃO ************************}
  {********************************************************}
  {*                                                      *}
  {* AO CRIAR UM CAMPO NESSA FUNÇÃO VEJA ONDE ELA ESTÁ    *}
  {* SENDO USADA, POIS, FAZ UNION EM ALGUNS LUGARES       *}
  {*                                                      *}
  {*****************************************************AF*}
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE            ';
  Result := Result + '   "FATGOR" AS TABELA ,         ';
  If fCfgSis('EXOCOR', varBoolean) Then
    Result := Result + ' ORDGRD.ORDCOR AS ORDCOR,     '
  Else
    Result := Result + ' 0 AS ORDCOR,                 ';
  Result := Result + '   FATGOR.AUTOINCREM AS AUTINC, ';
  Result := Result + '   FGO_DTAENT AS DTAENT,        ';
  Result := Result + '   FGO_HORENT AS HORENT,        ';
  Result := Result + '   CAST(CONCAT(FGO_PREVIS, IF(EXTGOR.FGO_HPREVI <> "", " ", ""), COALESCE(EXTGOR.FGO_HPREVI, "") ) AS DATETIME) AS PREVIS, ';
  Result := Result + '   FGO_NUMDOC AS NUMDOC,        ';
  Result := Result + '   FGO_ESPDOC AS ESPDOC,        ';
  Result := Result + '   FGO_CODCLI AS CODCLI,        ';
  Result := Result + '   FGO_SERIE_ AS SERIE_,        ';
  Result := Result + '   CLI_C_G_C_ AS CNPJCPF,       ';
  Result := Result + '   FGO_CODFAZ AS CODFAZ,        ';
  Result := Result + '   FGO_TIPOPE AS TIPOPE,        ';
  Result := Result + '   FGO_ORIGEM AS ORIGOR,        ';
  Result := Result + '   FGO_EMPEXP AS EMPEXP,        ';
  Result := Result + '   CLI_CODREG AS CODREG,        ';
  Result := Result + '   CLI_ORIENT AS ORIENT,        ';
  Result := Result + '   CAST(NULL AS CHAR(255)) AS ENDDOC, ';
  Result := Result + '   COALESCE(ETC_CIDENT, IF(FGO_NOMCON IS NULL, CLI_CODCID, FGO_CIDCON)) AS CODCID_BUSCA , ';
  Result := Result + '   CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS DOCUME,   ';
  Result := Result + '   CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS DOCFAT,   ';
  Result := Result + '   FGO_NUMFAT AS NUMFAT,   ';
  Result := Result + '   FGO_TIPFAT AS TIPFAT,   ';
  Result := Result + '   FGO_EMPFAT AS EMPFAT,   ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_NOMCLI') + ' AS NOMCLI, ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CGCCON', 'CLI_C_G_C_') + ' AS CLICGC, ';
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_NOMCON', 'CLI_FANSOB') + ' AS FANSOB, ';
  Result := Result + '   CLI_CATEGO AS CATEGO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CIDCON',
                     ' IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT)');
  Result := Result + '  AS CODCID, ';

  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_NOMCID, CIDENT.CID_NOMCID) AS NOMCID, ';
  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_ESTADO, CIDENT.CID_ESTADO) AS ESTADO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_ENDCON',
                     '  IF(IFNULL(AUX_ENTGER, "") <> "", ETC_ENDENT, ' +
                     '     CONCAT(CLI_ENDERE, ' +
                     '     IF(IFNULL(CLI_ENDNUM, " ") = " "," ", CONCAT(", ", CLI_ENDNUM)), ' +
                     '     IF(IFNULL(CLI_ENDCOM, "") = "","", CONCAT(" ", CLI_ENDCOM)))) ');
  Result := Result + '  AS ENDERE, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_BAICON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT) ') + ' AS BAIRRO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_CEPCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_C_E_P_, ETC_CEPENT) ') + ' AS C_E_P_, ';

  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI', 'FGO_TELCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_FONE01, ETC_TELENT) ') + ' AS TELEFO, ';

  Result := Result + fRetSQLDescricaoFrete('FGO_TIPFRE') + ' AS TIPFRE, ';

  Result := Result + '   SUM(FDO_TOTPES) AS PESBRU, ';
  Result := Result + '   FGO_TOTFRE AS TOTFRE, ';
  Result := Result + '   FGO_VOLUME AS VOLUME, ';
  Result := Result + '   SUM( FDO_TOTITE - FDO_DESESP + FDO_VALIPI + FDO_TOTFRE + FDO_VALRET + EXTDOR.FDO_VALFCP' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' ) AS VLRCON, ';
  Result := Result + '   SUM( FDO_TOTITE - FDO_DESESP ) AS VALDOC,   ';
  Result := Result + '   SUM(FDO_QTDITE) AS QTDITE,   ';
  Result := Result + '   FGO_CODEMP AS CODEMP,        ';
  Result := Result + '   FATGOR.FGO_CODFPG AS CODFPG, ';
  Result := Result + '   CONCAT(FPG_CODIGO, " - ",  FPG_DESCRI) AS DESFPG, ';
  Result := Result + '   FATGOR.FGO_CONPAG AS CONPAG, ';
  Result := Result + '   FATGOR.FGO_CODCND AS CODCND, ';
  Result := Result + '   EXTGOR.FGO_OPEEXP AS OPEEXP, ';
  Result := Result + '   FATGOR.FGO_CODVEN AS CODVEN, ';
  Result := Result + '   FATGOR.FGO_CODDIG AS CODDIG, ';
  Result := Result + '   VEN.OPE_NOMOPE    AS NOMOPE, ';
  Result := Result + '   VEN.OPE_CODDEP    AS DEPVEN, ';
  Result := Result + '   VEN.OPE_CODEMP    AS EMPVEN, ';
  Result := Result + '   FATDOR.FDO_CODVE2 AS CODVE2, ';
  Result := Result + '   FATGOR.FGO_OPRFLJ AS OPRFLJ, ';
  Result := Result + '   FATGOR.FGO_CODTRA AS CODTRA, ';
  Result := Result + '   TRA.TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '   IF(IF(IFNULL(EXTGOR.FGO_INDCOM,"") = "", "C", EXTGOR.FGO_INDCOM) = "C", "Comercialização", "Industrialização") AS INDCOM, ';
  Result := Result + '   EXTGOR.FGO_CODPOR AS CODPOR, ';
  Result := Result + '   IF(IFNULL(AUX_ENTGER, "") <> "", CADREG3.REG_DESREG, CADREG.REG_DESREG) AS DESREG, ';
  Result := Result + '   CADREG.REG_MINFAT AS MINFAT, ';
  Result := Result + '   FATGOR.FGO_MENEXP AS MENEXP, ';
  Result := Result + '   FATGOR.FGO_MENEX2 AS MENEX2, ';
  Result := Result + '   FATGOR.FGO_MENEX3 AS MENEX3, ';
  Result := Result + '   FATGOR.FGO_MENEX4 AS MENEX4, ';
  Result := Result + '   FATGOR.FGO_MEN001 AS MEN001, ';
  Result := Result + '   FATGOR.FGO_MEN002 AS MEN002, ';
  Result := Result + '   AUXGOR.AUX_MEN003 AS MEN003, ';
  Result := Result + '   AUXGOR.AUX_MEN004 AS MEN004, ';
  Result := Result + '   AUXGOR.AUX_MEN005 AS MEN005, ';
  Result := Result + '   EXTGOR.FGO_OPBXSE AS OPBXSE, ';
  Result := Result + '   EXTGOR.FGO_DTBXSE AS DTBXSE, ';
  Result := Result + '   EXTGOR.FGO_HRBXSE AS HRBXSE, ';
  Result := Result + '   EXTGOR.FGO_DTIMSE AS DTIMSE, ';
  Result := Result + '   EXTGOR.FGO_HRIMSE AS HRIMSE, ';
  Result := Result + '   EXTGOR.FGO_SEQSEP AS SEQSEP, ';
  Result := Result + '   EXTGOR.FGO_SEQOND AS SEQOND, ';
  Result := Result + '   CASE WHEN (SELECT COUNT(1) FROM SEPDOR ';
  Result := Result + '              WHERE SEP_SEQFDO = FATDOR.AUTOINCREM) = 0 THEN "N" ELSE "S" END AS TEMSEPDOR, ';

  //itens para serem utilizados no filtro , adiciona o [] para utilizar a busca contida no cds
  Result := Result + '   GROUP_CONCAT(FATDOR.FDO_CODITE) AS CODITENS, ';

  Result := Result + '   IF(FATGOR.FGO_SEPIMP = "N" OR IFNULL(FATGOR.FGO_SEPIMP,"") = "","0",IF(FATGOR.FGO_SEPIMP = "S","1",FATGOR.FGO_SEPIMP)) AS SEPIMP, ';
  Result := Result + '   EXTGOR.FGO_OPEDES AS OPEDES, ';
  Result := Result + '   DES.OPE_NOMOPE    AS OPDENO, '; //Nome Operador Designado.

  {COLUNA TIPO FATURAMENTO QUE SERÁ EXIBIDA NO GRID/CONFIGURAÇÃO DA CONSULTA}
  If (fCfgSis('TPDCEX') = '1') and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
  Begin
    Result := Result + '   CASE WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "A") THEN "(A)NF" ';
    Result := Result + '        WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "B") THEN "(B)FF" ';
    Result := Result + '        WHEN (IFNULL(FATGOR.FGO_TIPPED,"") = "C") THEN "(C)IF" ';
    Result := Result + '        ELSE "" END AS FTIPPED, ';
  End;
  {MANTENDO COLUNA SEM FORMATO UTILIZADA EM OUTRAS CHECAGENS - NÃO É EXIBIDA NO GRID}
  Result := Result + '   FATGOR.FGO_TIPPED AS TIPPED, ';

  Result := Result + '   FATGOR.FGO_CLICTT AS CLICTT, ';
  Result := Result + '   EXTGOR.FGO_OBSEXP AS OBSEXP, ';
  Result := Result + '   IF(IFNULL(EXTGOR.FGO_ENTURG, "") = "S", "SIM", "") AS ENTURG, ';
  Result := Result + '   EXTGOR.FGO_SEPEXP AS CODSEP, ';
  Result := Result + '   EXTGOR.FGO_FASOBR AS FASOBR, ';
  Result := Result + '   EXTGOR.FGO_CODROT AS CODROT, ';
  Result := Result + '   ENTREG.ENT_DTAENT AS DTAROT, ';
  Result := Result + '   ENTREG.ENT_CODIGO AS SEQROT, ';
  Result := Result + '   CADREG2.REG_DESREG AS DESREG2,';
  Result := Result + '  0.00 AS VRROTA, ';

  Result := Result + '   ROTREG.ROT_VLRMIN AS VLRMIN, ';
  Result := Result + '   ENTREG.ENT_LIBSEP AS LIBSEP, ';
  Result := Result + '   CONCAT(IFNULL(EXTGOR.FGO_SEPEXP, ""), "-", IFNULL(SEP.OPE_NOMOPE, "")) AS NOMSEP, ';
  Result := Result + '   CAST(CONCAT(FGO_DTALIC, " ", FGO_HORLIC) AS DATETIME) AS DTALIC, ';
  Result := Result + '   CAST(CONCAT(FGO_DTALIB, " ", FGO_HORLIB) AS DATETIME) AS DTALIB, ';
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

  Result := Result + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' AS VALADT, ';
  Result := Result + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO_FATAUT + ' AS VALADT_FATAUT, ';

  Result := Result +  '   CASE ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO_FATAUT + ' = 0 THEN "Pendente" ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO_FATAUT + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0) - FGO_BOLADT) THEN "Parcialmente" ';
  Result := Result +  '     ELSE "Realizado" ';
  Result := Result +  '   END AS SITADT, ';

  Result := Result + '   (SELECT ';
  Result := Result + '      GROUP_CONCAT(FPN_CODFPG) ';
  Result := Result + '    FROM ';
  Result := Result + '      FPGNEG ';
  Result := Result + '    WHERE ';
  Result := Result + '      FPGNEG.FPN_SEQFGO = FATGOR.AUTOINCREM) AS FPGNEG, ';

  If (Not fCfgSis('NPDF11', VarBoolean)) And (Not fCfgSis('NPRF11', VarBoolean)) And
     (Not fCfgSis('NPLF11', VarBoolean)) And (Not fCfgSis('LOCRET', VarBoolean)) Then
  Begin
    Result := Result + '  "N" AS ORIF11,';
  End
  Else
  Begin
    Result := Result + ' (SELECT ';
    Result := Result + '    IF(COUNT(*) > 0, "S", "N") ';
    Result := Result + '  FROM ';
    Result := Result + '    FATDOR AS PEDORI ';
    Result := Result + '  WHERE ';
    Result := Result + '    PEDORI.FDO_NUMFAT = FATGOR.FGO_NUMDOC AND ';
    Result := Result + '    PEDORI.FDO_TIPFAT = FATGOR.FGO_ESPDOC AND ';
    Result := Result + '    PEDORI.FDO_EMPFAT = FATGOR.FGO_CODEMP) AS ORIF11, ';
  End;

  Result := Result + '   EXTGOR.FGO_TOTBRI AS TOTBRI, ';
  Result := Result + '   EXTGOR.FGO_BOLADT AS BOLADT, ';
  Result := Result + '   EXTGOR.FGO_BOLVEN AS BOLVEN, ';
  Result := Result + '   "OK" AS SITFIN, ';
  Result := Result + '   EXTGOR.FGO_SEQDMP AS SEQDMP, ';

  Result := Result + '   EXTGOR.FGO_TX_PIX AS TX_PIX, ';
  Result := Result + '   EXTGOR.FGO_EMPPIX AS EMPPIX, ';

  Result := Result + '   IF(SUM(IF(LOCATE(FDO_CODFIS, "' + CST_SUBSTITUICAO + '") > 0, 1, 0)) > 0, TRUE, FALSE) AS TEMSUB, ';
  Result := Result + '   "N" AS TEMEXP, ';
  Result := Result + '   "N" AS EXPTOT, ';
  Result := Result + '   IF(LOCATE("PENDENTE", ' + fGetSqlOrdProEstrutura + '), "PENDENTE", IF(IFNULL(' + fGetSqlOrdProEstrutura + ', "") <> "", ' + fGetSqlOrdProEmitidaBaixada + ', "")) AS ORDPRO, ';
  Result := Result + '   (' + fGetSqlOrdProEstrutura + ') AS ITE_OP, ';
  Result := Result + '   CAST(' + fGetSqlEntregaRetira   + ' AS CHAR(10)) AS ENTRET, ';
  Result := Result + '   CAST(' + fGetSqlOrdenacaoEntregaRetira + ' AS CHAR(10)) AS IND_ENTRET, ';
  Result := Result + '   CASE WHEN (IFNULL(FGO_PEDSIT,"") <> "") THEN "S" ';
  Result := Result + '        WHEN (IFNULL(FGO_NUMPOK,"") <> "") THEN "P" ';
  Result := Result + '        ELSE "B" END AS ORIPED, ';
  Result := Result +  fSQLBarDoc('FGO') + ' AS BARDOC, ';
  Result := Result + '   IF(EXTGOR.FGO_CLILOJ = "S", "Sim", "Não") AS CLILOJ, ';
  Result := Result + '   FGO_BARCOM AS BARCOM, ';
  Result := Result + '   IFNULL(TRA.TRA_PRIEXP, 0) AS PRIEXP, ';
  Result := Result + '   IF(IFNULL(MIN(EXTDOR.FDO_DTENTR),FGO_DTENTR) < FGO_DTENTR, FGO_DTENTR, IFNULL(MIN(EXTDOR.FDO_DTENTR),FGO_DTENTR)) AS DTENTR, ';
  Result := Result + fRetornaCampoTurno('EXTDOR.FDO_TURENT') + ', ';
  Result := Result + '   FGO_CODTPA AS CODTPA, ';
  Result := Result + '   CAST(' + STR_COL_LOCRET + ' AS CHAR(10)) AS LOCRET, ';

  If blnUsaPafEcf Then
  Begin
    Result := Result + ' (SELECT IF(COUNT(*) > 0, "S", "N") ';
    Result := Result + '    FROM DAVPVG ';
    Result := Result + '    WHERE ';
    Result := Result + '      DPG_NUMDOC = FGO_NUMDOC AND ';
    Result := Result + '      DPG_ESPDOC = FGO_ESPDOC AND ';
    Result := Result + '      DPG_CODEMP = FGO_CODEMP) AS TEMDAV, ';
  End
  Else
  Begin
    Result := Result + ' "N" AS TEMDAV, ';
  End;

  Result := Result + fGetSQLTemItemEspecialNoPedido + ' AS TEMITEESP, ';
  Result := Result + '   IF(IFNULL(FGO_TOTSER,0) > 0, "S", "N") AS TEMSER ';

  If (grbLocSep.Visible) Then
  Begin
    Result := Result + ', CAST(NULL AS CHAR(255)) AS CODLSE ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPEN ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPAR ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSELIB ';
  End;

  If lblLocArm.Visible Then
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LCLAMZ ';

  If (fCfgSis('CADEMB', varBoolean)) Then
    Result := Result + ' ,EXTGOR.FGO_CODEMB AS CODEMB ';

  If (fVisualizarGuiche()) Then
    Result := Result + ', IF(IFNULL(EXTGOR.FGO_NUMGUI, "") = "", 0, EXTGOR.FGO_NUMGUI) AS GUICHE ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean)) Then
    Result := Result + ', TPA_DESCRI AS DESTPA ';

  If (fExibirTempoExpedicao) Then
  Begin
    Result := Result + ',IFNULL( ';
    Result := Result + '   TIMESTAMPDIFF( ';
    Result := Result + '     SECOND, ';
    Result := Result + '     CONCAT( ';
    Result := Result + '       DATE_FORMAT(FGO_DTAENT, "%Y-%m-%d"), ';
    Result := Result + '       " ", ';
    Result := Result + '       DATE_FORMAT(FGO_HORENT, "%H:%i") ';
    Result := Result + '     ), ';
    Result := Result + '     CONCAT( ';
    Result := Result + '       DATE_FORMAT(CURRENT_DATE, "%Y-%m-%d"), ';
    Result := Result + '       " ", ';
    Result := Result + '       DATE_FORMAT(CURRENT_TIME, "%H:%i") ';
    Result := Result + '     ) ';
    Result := Result + '   ), ';
    Result := Result + '   "0" ';
    Result := Result + ' ) AS TMPEXP ';
    Result := Result + ', CAST(NULL AS CHAR(3)) AS EXPTOL ';
  End;

  if fCfgSis('BOXWMS', varBoolean) Then
  Begin
    Result := Result + ', ';
    Result := Result + ' (SELECT BOX_CODIGO FROM CADBOX            ';
    Result := Result + '  WHERE BOX_NUMDOC = FGO_NUMDOC            ';
    Result := Result + '    AND BOX_ESPDOC = FGO_ESPDOC            ';
    Result := Result + '    AND BOX_EMPDOC = FGO_CODEMP) AS CODBOX ';
  End;

  If (fExibirInformacaoFaturamentoParcial()) Then
    Result := Result + ', IF(FGO_FATTOT = "S", "' + fInformacaoFatTotal() + '", "' + fInformacaoFatParcial() + '") AS FATTOT '
  Else
    Result := Result + ', " " AS FATTOT ';

  Result := Result + ', FGO_FATTOT AS TOTFAT ';

  If (fExibirDadosTransReqCompraPedido()) Then
  Begin
    Result := Result + ', (' + fRetSQLPedSolicTransf() + ') AS PEDTRF ';
    Result := Result + ', (' + fRetSQLPedReqCompra() + ') AS REQCOM ';
  End
  Else
  Begin
    Result := Result + ', " " AS PEDTRF ';
    Result := Result + ', " " AS REQCOM ';
  End;

  If fCfgSis('EXISTA', varBoolean) Then
  Begin
    Result := Result + ', CAST("" AS CHAR(30)) AS STATUS ';
    Result := Result + ', IFNULL(S.STA_DESCRI, CAST("" AS CHAR(80))) AS FGO_STATUS ';
  End;

  Result := Result + ',  CAST("" AS CHAR(4)) AS CLAFIS ';
  Result := Result + ' , IF(IFNULL(MOVGPV.AUTOINCREM, 0) = 0, 0, 1) AS TEMMOVGPV ';

  Result := Result + ',  ROMLGE.RLG_NUMLOT AS ROMDOC ';
  Result := Result + ',  ROMLGE.RLG_DESLOT AS ROMDES ';
  Result := Result + ',  "N" AS KIT ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS KITEST ';
  Result := Result + ',  IFNULL(AUX_ENFUOP, "1") AS ENFUOP ';
  Result := Result + ',  EXTGOR.FGO_ENVCON AS ENVCON ';
  Result := Result + ',  FGO_FRERAT AS FRERAT ';
  Result := Result + ',  FGO_REGDES AS UTIRES ';
  Result := Result + ',  FGO_TAXJUR AS TAXJUR ';
  Result := Result + ',  FGO_ZERTAX AS ZERTAX ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS EPFTGE ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS SOLABA ';
  Result := Result + ',  GROUP_CONCAT(DISTINCT EXTDOR.FDO_REGESP) AS REGESP ';
  Result := Result + ',  CAST(GROUP_CONCAT(DISTINCT EXTDOR.FDO_PEGOU_) AS CHAR(10)) AS PEGOU_ ';
  Result := Result + ',  IFNULL(FGO_CORTE_, "N") AS CORTE_ ';
  Result := Result + ',  "S" AS FATAUT ';
  Result := Result + ',  NFE_STATUS AS NFESTA ';
  Result := Result + ',  NFE_OBSERV AS NFEOBS ';
  Result := Result + ',  "N" AS CRTFIL ';

  Result := Result + ',  FGO_ESPECI AS ESPECI ';
  Result := Result + ', CAST(" " AS CHAR(30)) AS COTLAL';

  if ((fCfgSis('CONEQU') = 'S')) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
  begin
    Result := Result + ' ,  (SELECT E.EQU_NUMOSE FROM EQUGER E ';
    Result := Result + '     WHERE E.EQU_NUMPED = FATGOR.FGO_NUMDOC AND E.EQU_EMPPED = FATGOR.FGO_CODEMP ';
    Result := Result + '         AND E.EQU_TIPPED = FATGOR.FGO_ESPDOC) NUMOSE ';
  end;

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_CODLAR SEPARATOR ", ") ';
  Result := Result + '        FROM EXTLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON EXTLAR.SEQ_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE EXTLAR.COD_FATGOR = FATGOR.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS CODLAR ';

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_DESLAR SEPARATOR ", ") ';
  Result := Result + '        FROM EXTLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON EXTLAR.SEQ_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE EXTLAR.COD_FATGOR = FATGOR.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS DESLAR ';

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    Result := Result + ', 0.00 AS FRESUG ';
    Result := Result + ', 0.00 AS FRECOT ';
  End;

  Result := Result + ', EXTGOR.FGO_DECZFM AS DECZFM ';
  Result := Result + ', EXTGOR.FGO_VENPRE AS VENPRE ';
  Result := Result + ', FATGOR.FGO_NUMROM AS NUMROM ';
  Result := Result + ', FATGOR.FGO_EMPROM AS EMPROM ';
  Result := Result + ', CAST("0.00" AS CHAR(10)) AS PERSEP';
  Result := Result + ', FORMAT((IFNULL(((SUM(IFNULL(EXTDOR.FDO_QTDEXP, 0)) * 100) / (SUM(FDO_QTDITE) - SUM(FDO_QTDBAI))), 0)), 2) AS PERCOF';
  Result := Result + ', SUM(COALESCE(EXTDOR.FDO_CUBAGE, 0)) AS CUBAGEM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + ',  TRD.TRA_NOMTRA AS TRARDP ';

  Result := Result + ', EXTGOR.FGO_DTDIEN AS DTDIEN ';
  Result := Result + ', EXTGOR.FGO_DTLIEN AS DTLIEN ';
  Result := Result + ', EXTGOR.FGO_DTCOAG AS DTCOAG ';

  Result := Result + ', (CASE ';
  Result := Result + '     WHEN CADCLI.CLI_NOMCLI LIKE "%CONSUMIDOR%" THEN ';
  Result := Result + '       FATGOR.FGO_IESCON ';
  Result := Result + '   ELSE ';
  Result := Result + '     CADCLI.CLI_I_E_S_ ';
  Result := Result + '   END)  AS INSEST ';

  If (fCfgSis('EXQTIT', varString) = 'S') Then
  Begin
    Result := Result + ', (SELECT  COUNT(FDO_CODITE)               '+
                       '   FROM                                    '+
                       '     FATDOR FD                             '+
                       '   WHERE FD.FDO_SEQGER = FATGOR.AUTOINCREM )  AS QTDSKU ';
  End;

  Result := Result + ', FGO_NUMPOK AS NUMPOK ';
  Result := Result + ', EXTGOR.FGO_CANHUB AS CANHUB ';
  Result := Result + ', EXTGOR.FGO_STAHUB AS STAHUB ';

  pSetarFromFatgor(Result, strTmpPedidosPendentes);

  Result := Result + '   LEFT JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
  Result := Result + '   JOIN FATAUT ON FATGOR.FGO_NUMDOC = FATAUT.FAT_NUMDOC AND FATGOR.FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FATGOR.FGO_CODEMP = FATAUT.FAT_EMPDOC ';
  Result := Result + '   JOIN MOVGER ON FATAUT.FAT_SEQGER = MOVGER.AUTOINCREM ';

  Result := Result + '   JOIN LOGNFE ON NFE_NUMDOC = GER_NUMDOC ';
  Result := Result + '              AND NFE_ESPDOC = GER_ESPDOC ';
  Result := Result + '              AND NFE_CODEMP = GER_CODEMP ';
  Result := Result + '              AND NFE_CODCLI = GER_CODCLI ';
  Result := Result + '              AND IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ';

  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = IF(FGO_NOMCON IS NULL, CLI_CODCID, FGO_CIDCON) ';
  Result := Result + '   LEFT JOIN CADTRA TRA ON TRA.TRA_CODTRA = FATGOR.FGO_CODTRA ';
  Result := Result + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '   LEFT JOIN CADREG ON REG_CODREG = CADCLI.CLI_CODREG ';

  Result := Result + '   JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';

  Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';

  Result := Result + '   LEFT JOIN CADOPE SEP ON SEP.OPE_CODOPE = EXTGOR.FGO_SEPEXP ';
  Result := Result + '   LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = FATGOR.FGO_CODVEN ';
  Result := Result + '   LEFT JOIN CADOPE DES ON DES.OPE_CODOPE = EXTGOR.FGO_OPEDES ';

  Result := Result + '   LEFT JOIN ENTREG ON ENT_CODIGO = EXTGOR.FGO_CODROT ';

  if fCfgSis('ROTEMP', varBoolean) then
    Result := Result + ' AND ENT_CODEMP = FATGOR.FGO_CODEMP ';

  Result := Result + '   LEFT JOIN CADREG CADREG2 ON CADREG2.REG_CODREG = ENTREG.ENT_CODREG ';
  Result := Result + '   LEFT JOIN ROTREG ON ROT_CODREG = ENT_CODREG ';
  Result := Result + '   LEFT JOIN FGOSTA S ON FGO_STATUS = S.STA_CODIGO  ';
  Result := Result + '   LEFT JOIN MOVGPV ON MOVGPV.GPV_SEQFDO = FATDOR.AUTOINCREM ';

  Result := Result + '   LEFT JOIN AUXGOR ON AUXGOR.AUX_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + '   LEFT JOIN ENTCLI ECGOR ON ECGOR.AUTOINCREM = AUXGOR.AUX_ENTGER ';
  Result := Result + '   LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = ECGOR.ETC_CIDENT ';
  Result := Result + '   LEFT JOIN CADREG CADREG3 ON CADREG3.REG_CODREG = ECGOR.ETC_CODREG ';
  Result := Result + '   LEFT JOIN CADFPG ON FPG_CODIGO = FATGOR.FGO_CODFPG ';

  {Liberação de Pedidos Externos}
  If fCfgSis('LIBEXT', varBoolean) Then
  Begin
    Result := Result + '   LEFT JOIN LIBEXT ON (LEX_NUMDOC = FATGOR.FGO_NUMDOC AND ';
    Result := Result + '                        LEX_ESPDOC = FATGOR.FGO_ESPDOC AND ';
    Result := Result + '                        LEX_CODEMP = FATGOR.FGO_CODEMP)    ';
  End;

  If (fCfgSis('CONEQU') = 'S') Then
  Begin
    Result := Result + '   LEFT JOIN EQUGER ON EQU_NUMPED = FGO_NUMDOC ';
    Result := Result + '                   AND EQU_TIPPED = FGO_ESPDOC ';
    Result := Result + '                   AND EQU_EMPPED = FGO_CODEMP ';
    Result := Result + '                   AND EQU_VENPED = FGO_CODVEN ';
  End;

  Result := Result + '  LEFT JOIN EXTDOR AS EXTDOR_ ON FATDOR.AUTOINCREM = EXTDOR_.FDO_SEQFDO ';

  Result := Result + ' LEFT JOIN ROMLDE ON FATGOR.FGO_NUMDOC = ROMLDE.RLD_NUMDOC AND FATGOR.FGO_ESPDOC = ROMLDE.RLD_ESPDOC AND FATGOR.FGO_CODEMP = ROMLDE.RLD_CODEMP ';
  Result := Result + ' LEFT JOIN ROMLGE ON ROMLDE.RLD_SEQRLG = ROMLGE.AUTOINCREM ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean))Then
    Result := Result + '  LEFT JOIN CADTPA ON TPA_CODIGO = FGO_CODTPA ';

  If (fCfgSis('EXOCOR', varBoolean)) Then
    Result := Result + ' LEFT JOIN ' + fSQLOrdemCor() + ' ON FATGOR.AUTOINCREM = ORDGRD.AUTOINCREM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + '  LEFT JOIN CADTRA TRD ON EXTGOR.FGO_TRARDP = TRD.TRA_CODTRA';

  Result := Result + ' WHERE                        ';
  Result := Result + '   FAT_ESPDOC = "PD"      AND ';
  Result := Result + '   FAT_NUMFAT IS NOT NULL AND ';
  Result := Result + '   FAT_DTLBEX IS NULL     AND ';

  Result := Result + '   NOT EXISTS (SELECT SEQ_FATDOR FROM SEQGAR ';
  Result := Result + '               INNER JOIN FATDOR ON FATDOR.AUTOINCREM = SEQ_FATDOR ';
  Result := Result + '               WHERE FDO_SEQGER = FATGOR.AUTOINCREM) AND ';

  {Liberação de Pedidos Externos - Oculta "Não Liberados" externos (Mobile e Site)}
  If fCfgSis('LIBEXT', varBoolean) Then
  Begin
    Result := Result + '   (((IFNULL(FGO_NUMPOK, "") <> "") AND (LEX_LIBPOK = "S")) OR (IFNULL(FGO_NUMPOK, "") = "") OR LEX_LIBPOK IS NULL) AND ';
    Result := Result + '   (((IFNULL(FGO_PEDSIT, "") <> "") AND (LEX_LIBPOK = "S")) OR (IFNULL(FGO_PEDSIT, "") = "") OR LEX_LIBPOK IS NULL) AND ';
  End;

  If fCfgSis('PD_EXP', varBoolean) And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    Result := Result + '   EXTGOR.FGO_PD_EXP = "S" AND  ';

  Result := Result + fGetTipoDocumento('FGO');
  Result := Result + fFiltroEmpresaExpedicaoPedido;
  Result := Result + fRetSQLTemAoMenosUmItemNormal('FATGOR');

  If fCfgSis('LOCRET', VarBoolean) Then
  Begin
    Result := Result + '   EXTDOR.FDO_LOCRET <> "C" AND  ';//Local de retira caixa deve ser ignorado
  End;

  Result := Result + '   IFNULL(FGO_LIBERA, 0) > 0 AND  ';
  Result := Result + '   IFNULL(FGO_LIBCOM, 0) > 0 AND  ';

  If fCfgSis('EXPNFA', varBoolean) Then
    Result := Result + '  NFE_STATUS = "AT" AND ';

  Result := Result + '   FGO_DOCEND IS NULL AND         ';

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (Not fCfgExpedicaoParcialHabilitada) Then
    Result := Result + '   FGO_DTLBEX IS NULL AND  ';

  If fCfgSis('BAISEP', varBoolean) Then
  Begin
    If blnApenasImprimirBaixarSeparacao Then
      Result := Result + '   FGO_OPBXSE IS NULL AND '
    Else
    Begin
      If (blnUsaImpressaoSeparacaoPorLocal And fCfgSis('EXBXTO', varBoolean)) or fPermiteImprimirSeparacaoParcial Then
        Result := Result + '   (FDO_QTDITE - EXTDOR.FDO_QTDSEP) > 0 AND '
      Else
        Result := Result + '   FGO_OPBXSE IS NOT NULL AND ';
    End;
  End;

  If (fCfgSis('CONEQU') = 'S') And ((fCfgSis('EQUEXP', varString) = 'N') or fCfgSis('FPOSCP',varBoolean)) Then
    Result := Result + '   EQU_NUMPED IS NULL AND ';

  If Not fEmptyStr(fCfgSis('ITEMAN')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEMAN')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITELAN')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITELAN')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITEBOM')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITEBOM')) + ' AND ';

  If Not fEmptyStr(fCfgSis('ITETAX')) Then
    Result := Result + '  FDO_CODITE <> ' + QuotedStr(fCfgSis('ITETAX')) + ' AND ';

  Result := Result + '   (IF(FDO_ENTFUT = "" OR FDO_ENTFUT IS NULL,"N", FDO_ENTFUT) = "N") ';

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgSis('EQUEXP', varBoolean)) And (fCfgSis('USASER', varBoolean)) Then
  Begin
    Result := Result + ' AND FDO_CODITE <> ' + QuotedStr(fCfgSis('ITESER')) + ' ';
    Result := Result + ' AND FDO_CODITE <> ' + QuotedStr(fCfgSis('SERTER')) + ' ';
  End;

  If tipFiltroPedidoTransf <> tfNao Then
    Result := Result + ' AND FGO_CODCLI IN ('  + fRetClientesFilial + ') ';

  Result := Result  + fSQLFiltroLocalizacaoFisica();

  Result := Result + ' GROUP BY                                         ';
  Result := Result + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ';

  Result := 'SELECT ' +
              SQL_BENFUT +
              SQL_PEDPAR +
              SQL_QTDPRO +
              SQL_NUMCMP +
              fGetSubSelectLogStatus(pvAgSeparacao.fGetId(),   'VW_FATAUT.AUTINC', 'AGSEPA') +
              fGetSubSelectLogStatus(pvSeparando.fGetId(),     'VW_FATAUT.AUTINC', 'INISEP') +
              fGetSubSelectLogStatus(pvAgFaturamento.fGetId(), 'VW_FATAUT.AUTINC', 'AGFATU') +
            'VW_FATAUT.* FROM ( '+Result+' ) AS VW_FATAUT';

  If objTipoEntregaRetiraExpedicao.fGetTipo <> objTipoEntregaRetiraExpedicao.TODOS Then
    Result := Result + '   WHERE ENTRET = "'+objTipoEntregaRetiraExpedicao.fGetTipo+'" ';
end;

function TfrmFatExpedicao.fGetSQLPedidosReposicao: String;
begin
  Result := '';

  Result := Result + 'SELECT DISTINCT ';
  Result := Result + '  "N"      AS BENFUT, ';
  Result := Result + '  "R"      AS PEDPAR, ';
  Result := Result + '  0        AS QTDPRO, ';
  Result := Result + '  " "      AS NUMCMP, ';
  Result := Result + '  CAST("" AS CHAR(19)) AS AGSEPA, ';
  Result := Result + '  CAST("" AS CHAR(19)) AS INISEP, ';
  Result := Result + '  CAST("" AS CHAR(19)) AS AGFATU, ';
  Result := Result + '  "MOVGRC" AS TABELA, ';
  Result := Result + '  0 AS ORDCOR,            ';
  Result := Result + '  G.AUTOINCREM AS AUTINC, ';
  Result := Result + '  G.GER_DTAENT AS DTAENT, ';
  Result := Result + '  G.GER_HORENT AS HORENT, ';
  Result := Result + '  NULL       AS PREVIS, ';
  Result := Result + '  G.GER_NUMDOC AS NUMDOC, ';
  Result := Result + '  G.GER_ESPDOC AS ESPDOC, ';
  Result := Result + '  G.GER_CODCLI AS CODCLI, ';
  Result := Result + '  G.GER_SERIE_ AS SERIE_, ';
  Result := Result + '  CLI.CLI_C_G_C_ AS CNPJCPF, ';
  Result := Result + '  "      "      AS CODFAZ, ';
  Result := Result + '  "V"           AS TIPOPE, ';
  Result := Result + '  "AUTCOM"      AS ORIGOR, ';
  Result := Result + '  G.GER_CODEMP AS EMPEXP,  ';
  Result := Result + '  CLI.CLI_CODREG AS CODREG, ';
  Result := Result + '  CLI.CLI_ORIENT AS ORIENT, ';
  Result := Result + '  CAST(NULL AS CHAR(255)) AS ENDDOC, ';
  Result := Result + '  COALESCE(ETC_CIDENT, IF(G.GER_NOMCON IS NULL, CLI_CODCID, G.GER_CIDCON)) AS CODCID_BUSCA , ';
  Result := Result + '  CONCAT(G.GER_NUMDOC, "-", G.GER_ESPDOC, "-", G.GER_CODEMP) AS DOCUME, ';
  Result := Result + '  CONCAT(G.GER_NUMFAT, "-", G.GER_TIPFAT, "-", G.GER_EMPFAT) AS DOCFAT, ';
  Result := Result + '  G.GER_NUMFAT AS NUMFAT,   ';
  Result := Result + '  G.GER_TIPFAT AS TIPFAT,   ';
  Result := Result + '  G.GER_EMPFAT AS EMPFAT,   ';
  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_NOMCON', 'CLI.CLI_NOMCLI') + ' AS NOMCLI, ';
  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_CGCCON', 'CLI.CLI_C_G_C_') + ' AS CLICGC, ';
  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_NOMCON', 'CLI.CLI_FANSOB') + ' AS FANSOB, ';
  Result := Result + '   CLI_CATEGO AS CATEGO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_CIDCON',
                     ' IF(IFNULL(AUX_ENTGER, "") = "", CLI.CLI_CODCID, ETC_CIDENT)');
  Result := Result + '  AS CODCID, ';

  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CID.CID_NOMCID, CIDENT.CID_NOMCID) AS NOMCID, ';
  Result := Result + 'IF(IFNULL(AUX_ENTGER, "") = "", CID.CID_ESTADO, CIDENT.CID_ESTADO) AS ESTADO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_ENDCON',
                     '  IF(IFNULL(AUX_ENTGER, "") <> "", ETC_ENDENT, ' +
                     '     CONCAT(CLI.CLI_ENDERE, ' +
                     '     IF(IFNULL(CLI.CLI_ENDNUM, " ") = " "," ", CONCAT(", ", CLI.CLI_ENDNUM)), ' +
                     '     IF(IFNULL(CLI.CLI_ENDCOM, "") = "","", CONCAT(" ", CLI.CLI_ENDCOM)))) ');
  Result := Result + '  AS ENDERE, ';

  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_BAICON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI.CLI_BAIRRO, ETC_BAIENT) ') + ' AS BAIRRO, ';

  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_CEPCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI.CLI_C_E_P_, ETC_CEPENT) ') + ' AS C_E_P_, ';

  Result := Result + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_TELCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI.CLI_FONE01, ETC_TELENT) ') + ' AS TELEFO, ';

  Result := Result + fRetSQLDescricaoFrete('G.GER_TIPFRE') + ' AS TIPFRE, ';

  Result := Result + '  G.GER_PESBRU AS PESBRU, ';
  Result := Result + '  G.GER_TOTFRE AS TOTFRE, ';
  Result := Result + '  G.GER_VOLUME AS VOLUME, ';
  Result := Result + '  G.GER_VLRCON AS VLRCON, ';
  Result := Result + '  G.GER_VLRCON AS VALDOC, ';
  Result := Result + '  SUM(D.DET_QTDITE) AS QTDITE, ';
  Result := Result + '  G.GER_CODEMP AS CODEMP, ';
  Result := Result + '  G.GER_CODFPG AS CODFPG, ';
  Result := Result + '  CONCAT(FPG_CODIGO, " - ", FPG_DESCRI) AS DESFPG, ';
  Result := Result + '  G.GER_CONPAG AS CONPAG, ';
  Result := Result + '  G.GER_CODCND AS CODCND, ';
  Result := Result + '  G.GER_OPEEXP AS OPEEXP, ';
  Result := Result + '  G.GER_CODVEN AS CODVEN, ';
  Result := Result + '  G.GER_CODDIG AS CODDIG, ';
  Result := Result + '  OPE.OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  OPE.OPE_CODDEP AS DEPVEN, ';
  Result := Result + '  OPE.OPE_CODEMP AS EMPVEN, ';
  Result := Result + '  " "        AS CODVE2, ';
  Result := Result + '  " "        AS OPRFLJ, ';
  Result := Result + '  G.GER_CODTRA AS CODTRA, ';
  Result := Result + '  TRA.TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '  IF(IF(IFNULL(G.GER_CONSUM,"") = "", CLI.CLI_CONSUM, G.GER_CONSUM) = "S", "Comercialização", "Industrialização") AS INDCOM, ';
  Result := Result + '  "     "    AS CODPOR, ';
  Result := Result + '  IF(IFNULL(AUX_ENTGER, "") <> "", CADREG3.REG_DESREG, CADREG.REG_DESREG) AS DESREG, ';
  Result := Result + '  0.00       AS MINFAT, ';
  Result := Result + '  G.GER_MENEXP AS MENEXP, ';
  Result := Result + '  G.GER_MENEX2 AS MENEX2, ';
  Result := Result + '  G.GER_MENEX3 AS MENEX3, ';
  Result := Result + '  G.GER_MENEX4 AS MENEX4, ';
  Result := Result + '  G.GER_MEN001 AS MEN001, ';
  Result := Result + '  G.GER_MEN002 AS MEN002, ';
  Result := Result + '  G.GER_MEN003 AS MEN003, ';
  Result := Result + '  G.GER_MEN004 AS MEN004, ';
  Result := Result + '  G.GER_MEN005 AS MEN005, ';
  Result := Result + '  NULL       AS OPBXSE, ';
  Result := Result + '  NULL       AS DTBXSE, ';
  Result := Result + '  NULL       AS HRBXSE, ';
  Result := Result + '  NULL       AS DTIMSE, ';
  Result := Result + '  NULL       AS HRIMSE, ';
  Result := Result + '  NULL       AS SEQSEP, ';
  Result := Result + '  NULL       AS SEQOND, ';
  Result := Result + '  "N"        AS TEMSEPDOR, ';

  //itens para serem utilizados no filtro , adiciona o [] para utilizar a busca contida no cds
  Result := Result + '  GROUP_CONCAT(D.DET_CODITE) AS CODITENS, ';

  Result := Result + '  IF(AUX_SEPIMP = "N" AND COALESCE(' + fGetQtdDoc('G') + ', 0) = 0, "0", IF(AUX_SEPIMP = "S" AND COALESCE(' + fGetQtdDoc('G') + ', 0) = 0, "1", IF(AUX_SEPIMP = "N" AND COALESCE(' + fGetQtdDoc('G') + ', 0) < COALESCE(' + fGetQtdDoc('G', True) + ', 0), "2", "3"))) AS SEPIMP, ';
  Result := Result + '  " "        AS OPEDES, ';
  Result := Result + '  " "        AS OPDENO, '; //Nome Operador Designado.
  If (fCfgSis('TPDCEX') = '1') and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    Result := Result + '  " "        AS FTIPPED, ';
  Result := Result + '  " "        AS TIPPED, ';
  Result := Result + '  " "        AS CLICTT, ';
  Result := Result + '  " "        AS OBSEXP, ';
  Result := Result + '  " "        AS ENTURG, ';
  Result := Result + '  " "        AS CODSEP, ';
  Result := Result + '  " "        AS FASOBR, ';
  Result := Result + '  " "        AS CODROT, ';
  Result := Result + '  " "        AS DTAROT, ';
  Result := Result + '  " "        AS SEQROT, ';
  Result := Result + '  " "        AS DESREG2,';
  Result := Result + '  0.00       AS VRROTA, ';
  Result := Result + '  0.00       AS VLRMIN, ';
  Result := Result + '  "S"        AS LIBSEP, ';
  Result := Result + '  " "        AS NOMSEP, ';
  Result := Result + '  CAST(NULL AS DATETIME) AS DTALIC, ';
  Result := Result + '  CAST(NULL AS DATETIME) AS DTALIB, ';
  Result := Result + '  0.00       AS VALREC, ';
  Result := Result + '  0.00       AS VALADT, ';
  Result := Result + '  0.00       AS VALADT_FATAUT, ';
  Result := Result + '  " "        AS SITADT, ';
  Result := Result + '  " "        AS FPGNEG, ';
  Result := Result + '  "N"        AS ORIF11, ';
  Result := Result + '  0.00       AS TOTBRI, ';
  Result := Result + '  0.00       AS BOLADT, ';
  Result := Result + '  "N"        AS BOLVEN, ';
  Result := Result + '  "OK"       AS SITFIN, ';
  Result := Result + '  AUX_SEQDMP AS SEQDMP, ';

  Result := Result + '   CAST(NULL AS CHAR(50)) AS TX_PIX, ';
  Result := Result + '   CAST(NULL AS CHAR(3))  AS EMPPIX, ';

  Result := Result + '  " "        AS TEMSUB, ';
  Result := Result + '  " "        AS TEMEXP, ';
  Result := Result + '  " "        AS EXPTOT, ';
  Result := Result + '  " "        AS ORDPRO, ';
  Result := Result + '  " "        AS ITE_OP, ';
  Result := Result + '  IF(G.GER_ENTFUT = "S", "F", IF(G.GER_ENTFAT = "S", "E", "R")) AS ENTRET, ';
  Result := Result + '  IF(G.GER_ENTFUT = "S", "3", IF(G.GER_ENTFAT = "S", "2", "1")) AS IND_ENTRET, ';
  Result := Result + '  " "        AS ORIPED, ';
  Result := Result +  fSQLBarDoc('G.GER') + ' AS BARDOC, ';
  Result := Result + '  " "        AS CLILOJ, ';
  Result := Result + '  " "        AS BARCOM, ';
  Result := Result + '  IFNULL(TRA.TRA_PRIEXP, 0) AS PRIEXP, ';
  Result := Result + '  GER_DTENTR AS DTENTR, ';
  Result := Result + '  NULL AS TURENT, ';
  Result := Result + '  " "  AS CODTPA, ';
  Result := Result + '  " " AS LOCRET, ';
  Result := Result + '  "N" AS TEMDAV, ';
  Result := Result + '  "N" AS TEMITEESP, ';
  Result := Result + '  "N" AS TEMSER ';

  If (grbLocSep.Visible) Then
  Begin
    Result := Result + ', CAST(NULL AS CHAR(255)) AS CODLSE ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPEN ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSEPAR ';
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LSELIB ';
  End;

  If lblLocArm.Visible Then
    Result := Result + ', CAST(NULL AS CHAR(255)) AS LCLAMZ ';

  If (fCfgSis('CADEMB', varBoolean)) Then
    Result := Result + '  ," "  AS CODEMB ';

  If (fVisualizarGuiche()) Then
    Result := Result + ', " " AS GUICHE ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean)) Then
    Result := Result + ', " " AS DESTPA ';

  If (fExibirTempoExpedicao) Then
  Begin
    Result := Result + ', 0  AS TMPEXP ';
    Result := Result + ', CAST(NULL AS CHAR(3)) AS EXPTOL ';
  End;

  if fCfgSis('BOXWMS', varBoolean) Then
    Result := Result + ', " " AS CODBOX ';

  Result := Result + ', " " AS FATTOT ';
  Result := Result + ', CAST("" AS CHAR(1)) AS TOTFAT ';
  Result := Result + ', " " AS PEDTRF ';
  Result := Result + ', " " AS REQCOM ';

  If fCfgSis('EXISTA', varBoolean) Then
  Begin
    Result := Result + ', CAST("" AS CHAR(30)) AS STATUS ';
    Result := Result + ', CAST("" AS CHAR(80)) AS FGO_STATUS ';
  End;

  Result := Result + ',  CAST("" AS CHAR(4)) AS CLAFIS ';
  Result := Result + ',  0 AS TEMMOVGPV ';

  Result := Result + ', CAST("" AS CHAR(08)) AS ROMDOC ';
  Result := Result + ', CAST("" AS CHAR(50)) AS ROMDES ';
  Result := Result + ', "N" AS KIT ';
  Result := Result + ',  CAST("" AS CHAR(3)) AS KITEST ';
  Result := Result + ', IFNULL(AUX_ENFUOP, "1") AS ENFUOP ';
  Result := Result + ', " " AS ENVCON ';
  Result := Result + ', AUX_FRERAT AS FRERAT ';
  Result := Result + ', " " AS UTIRES ';
  Result := Result + ', 0   AS TAXJUR ';
  Result := Result + ', "N" AS ZERTAX ';
  Result := Result + ', CAST("" AS CHAR(3)) AS EPFTGE ';
  Result := Result + ', CAST("" AS CHAR(3)) AS SOLABA ';
  Result := Result + ', " " AS REGESP ';
  Result := Result + ', " " AS PEGOU_ ';
  Result := Result + ', "N" AS CORTE_ ';
  Result := Result + ', "N" AS FATAUT ';
  Result := Result + ', " " AS NFESTA ';
  Result := Result + ', " " AS NFEOBS ';
  Result := Result + ', "N" AS CRTFIL ';
  Result := Result + ',  G.GER_ESPECI AS ESPECI ';
  Result := Result + ', CAST(" " AS CHAR(30)) AS COTLAL';

  if ((fCfgSis('CONEQU') = 'S')) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
    Result := Result + ', " " AS NUMOSE ';

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_CODLAR SEPARATOR ", ") ';
  Result := Result + '        FROM MOVLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON MOVLAR.LAM_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE MOVLAR.LAM_SEQGER = G.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS CODLAR ';

  Result := Result + ',  CAST( ';
  Result := Result + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_DESLAR SEPARATOR ", ") ';
  Result := Result + '        FROM MOVLAR ';
  Result := Result + '        LEFT JOIN CADLAR ON MOVLAR.LAM_CODLAR = CADLAR.AUTOINCREM ';
  Result := Result + '       WHERE MOVLAR.LAM_SEQGER = G.AUTOINCREM) ';
  Result := Result + '   AS CHAR(255)) AS DESLAR ';

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    Result := Result + ', SUM(COALESCE(T.DET_FRESUG, 0)) AS FRESUG ';
    Result := Result + ', SUM(COALESCE(T.DET_FRECOT, 0)) AS FRECOT ';
  End;

  Result := Result + ', 0   AS DECZFM ';
  Result := Result + ', " " AS VENPRE ';
  Result := Result + ',  G.GER_NUMROM AS NUMROM ';
  Result := Result + ',  G.GER_EMPROM AS EMPROM ';
  Result := Result + ',  CAST("0.00" AS CHAR(10)) AS PERSEP ';
  Result := Result + ',  0.00 AS PERCOF ';
  Result := Result + ',  SUM(COALESCE(T.DET_CUBAGE, 0)) AS CUBAGEM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + ',  TRD.TRA_NOMTRA AS TRARDP ';

  Result := Result + ',  CAST(NULL AS DATETIME) AS DTDIEN ';
  Result := Result + ',  CAST(NULL AS DATETIME) AS DTLIEN ';
  Result := Result + ',  CAST(NULL AS DATETIME) AS DTCOAG ';

  Result := Result + ',  CLI.CLI_I_E_S_  AS INSEST ';

  If (fCfgSis('EXQTIT', varString) = 'S') Then
  Begin
    Result := Result + ', (SELECT  COUNT(DET_CODITE)               '+
                       '   FROM                                    '+
                       '     MOVDET MD                             '+
                       '   WHERE MD.DET_SEQGER = G.AUTOINCREM ) AS QTDSKU ';
  End;

  Result := Result + ', CAST(NULL AS CHAR(40)) AS NUMPOK ';
  Result := Result + ', "N" AS CANHUB ';
  Result := Result + ', "" AS STAHUB ';

  Result := Result + ' FROM ';
  Result := Result + ' MOVGRC R ';
  Result := Result + ' LEFT JOIN MOVDET D ON D.AUTOINCREM = R.GRC_SEQDET ';
  Result := Result + ' LEFT JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';
  Result := Result + ' LEFT JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ';
  Result := Result + ' LEFT JOIN CADFPG ON FPG_CODIGO = G.GER_CODFPG ';
  Result := Result + ' LEFT JOIN AUXMOV U ON G.AUTOINCREM = U.AUX_SEQGER ';
  Result := Result + ' INNER JOIN MOVGAD A ON A.AUTOINCREM = R.GRC_SEQGAD ';
  Result := Result + ' INNER JOIN MOVGAG M ON M.AUTOINCREM = A.GAD_SEQGAG ';
  Result := Result + ' INNER JOIN MOVGAD A2 ON A2.GAD_SEQGAG = M.AUTOINCREM ';
  Result := Result + ' INNER JOIN MOVGRC R2 ON R2.GRC_SEQGAD = A2.AUTOINCREM AND R2.GRC_OPCDOC IN ("GC", "OU") ';
  Result := Result + ' INNER JOIN CADCLI CLI ON G.GER_CODCLI = CLI.CLI_CODCLI  ';
  Result := Result + ' LEFT  JOIN CADCID CID ON CID.CID_CODCID = ' + fSQLIFClienteConsumidor('CLI.CLI_NOMCLI', 'G.GER_CIDCON ', 'CLI.CLI_CODCID ');
  Result := Result + ' LEFT  JOIN CADTRA TRA ON TRA.TRA_CODTRA = G.GER_CODTRA ';
  Result := Result + ' LEFT  JOIN CADOPE OPE ON OPE.OPE_CODOPE = G.GER_CODVEN ';

  Result := Result + '  LEFT JOIN CADREG ON CADREG.REG_CODREG = CLI.CLI_CODREG ';

  Result := Result + '  LEFT JOIN ENTCLI ECGOR ON ECGOR.AUTOINCREM = U.AUX_ENTGER ';
  Result := Result + '  LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = ECGOR.ETC_CIDENT ';
  Result := Result + '  LEFT JOIN CADREG CADREG3 ON CADREG3.REG_CODREG = ECGOR.ETC_CODREG ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    Result := Result + '  LEFT JOIN CADTRA TRD ON U.AUX_TRARDP = TRD.TRA_CODTRA';

  Result := Result + ' WHERE R.GRC_OPCDOC IN ("OU", "GC") ';
  Result := Result + ' AND G.GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + ' AND G.GER_DTLBEX IS NULL ';
  Result := Result + ' GROUP BY G.GER_NUMDOC, G.GER_ESPDOC, G.GER_SERIE_, G.GER_CODEMP, G.GER_CODCLI ';
end;

function TfrmFatExpedicao.fGetSQLTemItemEspecialNoPedido: String;
begin
  Result := EmptyStr;
  Result := Result + ' (SELECT IF(COUNT(*) > 0, "S", "N") ';
  Result := Result + '    FROM FATDOR FDOESP ';
  Result := Result + '    JOIN CADITE ITEESP ON ITEESP.ITE_CODITE = FDOESP.FDO_CODITE ';
  Result := Result + '   WHERE FDOESP.FDO_NUMDOC = FGO_NUMDOC ';
  Result := Result + '     AND FDOESP.FDO_ESPDOC = FGO_ESPDOC ';
  Result := Result + '     AND FDOESP.FDO_CODEMP = FGO_CODEMP ';
  Result := Result + '     AND ITEESP.ITE_DESITE LIKE "%ITEM ESPECIAL%") ';
end;

function TfrmFatExpedicao.fGetSubSelectLogStatus(const AId: Integer; const ASeqFgo, AAlias: string): String;
begin
  if fCfgSis('EXISTA', varBoolean) then
    Result := '(SELECT CONCAT(DATE_FORMAT(STA_DTAMUD, "%d/%m/%Y"), " ", STA_HRAMUD)'+
              '   FROM ALTSTA                                              ' +
              '  WHERE STA_SEQFGO = ' + ASeqFgo +  ' AND STA_CODIGO = ' + IntToStr(AId) +
              ' ORDER BY STA_DTAMUD DESC, STA_HRAMUD DESC LIMIT 1) AS ' + AAlias + ', '
  else
    Result := 'CAST("" AS CHAR(19)) AS ' + AAlias + ', ';
end;

function TfrmFatExpedicao.fGetTipoDoctoSelecionado(arrOpcSel: Array Of String): Boolean;
  Var
    strOpcTmp: String;
    intIndex: Integer;
begin
  strOpcTmp := '';

  For intIndex := Low(arrOpcSel) To High(arrOpcSel) Do
    strOpcTmp := strOpcTmp + arrOpcSel[intIndex] + '_';

  Result := Pos(rdgTipoDocumento.Items[rdgTipoDocumento.ItemIndex], strOpcTmp) > 0;
end;

function TfrmFatExpedicao.fGetTipoDocumento(strPrefixo: String; strAliasComPonto: String = ''): String;
    function fGetDocDev: String;
    Begin
      Result := ' ((LOCATE(' + strAliasComPonto + 'GER_CLAFIS, "' + VS_strClaDev + '") > 0 AND ' + strAliasComPonto + 'GER_ESPDOC = "NF") OR ' + strAliasComPonto + 'GER_ESPDOC = "DV") ';
    End;

    function fGetDocGar: String;
    Begin
      Result := '';

      //Recebimento de Cliente
      Result := Result + ' ((LOCATE(RIGHT(' + strAliasComPonto + 'GER_CLAFIS, 3), ' + QuotedStr(fTransform(fCfgSis('CRECGC'), 3)) + ') AND ' + strAliasComPonto + 'GER_ESPDOC = "NF") OR ';
      Result := Result + '  (' + strAliasComPonto + 'GER_ESPDOC = "GA") OR ';

      //Reposição de Cliente
      Result := Result + '  (LOCATE(RIGHT(' + strAliasComPonto + 'GER_CLAFIS, 3), ' + QuotedStr(fTransform(fCfgSis('CREPGC'), 3)) + ') AND ' + strAliasComPonto + 'GER_ESPDOC = "NF") OR ';
      Result := Result + '  (' + strAliasComPonto + 'GER_ESPDOC = "GC") OR ';

      //Envio para o Fornecedor
      Result := Result + '  (LOCATE(RIGHT(' + strAliasComPonto + 'GER_CLAFIS, 3), ' + QuotedStr(fTransform(fCfgSis('CLARGF'), 3)) + ') AND ' + strAliasComPonto + 'GER_ESPDOC = "NF") OR ';
      Result := Result + '  (' + strAliasComPonto + 'GER_ESPDOC = "GF") OR ';

      //Retorno do Fornecedor
      Result := Result + '  (LOCATE(RIGHT(' + strAliasComPonto + 'GER_CLAFIS, 3), ' + QuotedStr(fTransform(fCfgSis('CLARGR'), 3)) + ') AND ' + strAliasComPonto + 'GER_ESPDOC = "NF") OR ';
      Result := Result + '  (' + strAliasComPonto + 'GER_ESPDOC = "GR")) ';
    End;
begin
  Result := '';

  If fGetTipoDoctoSelecionado([VENDAS, DEVOLUCAO, GARANTIA]) Then
  Begin
    Result := Result + ' ' + strAliasComPonto + strPrefixo + '_CODCLI NOT IN ('  + fRetClientesFilial + ') AND ';

    //Documentos de Venda
    If SameText(strPrefixo, 'GER') Then
    Begin
      If fGetTipoDoctoSelecionado([VENDAS]) Then
      Begin
        Result := Result + ' (NOT ' + fGetDocDev + ') AND ';
        Result := Result + ' (NOT ' + fGetDocGar + ') AND ';
      End
      Else If fGetTipoDoctoSelecionado([DEVOLUCAO]) Then
        Result := Result + fGetDocDev + ' AND '
      Else If fGetTipoDoctoSelecionado([GARANTIA]) Then
        Result := Result + fGetDocGar + ' AND ';
    End
    Else
    Begin
      // Se caso escolheu a opção somente garantia não traz nenhum pedido
      If fGetTipoDoctoSelecionado([GARANTIA]) Then
        Result := Result + ' FALSE AND ';

      if (fGetTipoDoctoSelecionado([VENDAS])) and (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) and (strPrefixo = 'FGO') then
        Result := Result +  ' ((IFNULL(FGO_NUMPOK,"") = "") AND (IFNULL(FGO_PEDSIT,"") = "")) AND ';
    End;
  End
  Else If fGetTipoDoctoSelecionado([TRANSFERENCIA]) Then
    Result := Result + ' ' + strAliasComPonto + strPrefixo + '_CODCLI     IN ('  + fRetClientesFilial + ') AND '
  Else If (fGetTipoDoctoSelecionado([ECOMMERCE])) And (strPrefixo = 'FGO')  Then
    Result := Result +  ' ((IFNULL(FGO_NUMPOK,"") <> "") OR (IFNULL(FGO_PEDSIT,"") <> "")) AND ';
end;

function TfrmFatExpedicao.fPodeGuardarItensSeparados: Boolean;
var
  strAutIncPed: String;
begin
  Result := False;

  if (not fUsaOndaSeparacaoAgrupamento()) then
    Exit;

  if (Length(FGuardarItens) = 0) then
    Exit;

  for strAutIncPed in FGuardarItens do
    if strAutIncPed = fField('AUTINC').AsString then
      Exit(True);
end;

function TfrmFatExpedicao.fHoraImpressao: TDateTime;
begin
  Result := fCampoTabela('FGO_HRIMSE', 'EXTGOR', ['FGO_SEQFGO'], [fField('AUTINC').AsString]);
end;

function TfrmFatExpedicao.fIgnoraImpOrdemProdItemEstrutura: Boolean;
begin
  Result := False;

  If fCfgSis('ORDPRO', varBoolean) Then
    Exit;

  If fCfgSis('UTIIND', varBoolean) Then
    Exit;

  Result := True;
end;

procedure TfrmFatExpedicao.pCarregaPedidos(const strTmpPedidosPendentes: String);
var
  qryQuery: TUniQuery;
begin
  qryQuery := fCriaQuery;
  Try
    pLimpaVariaveisSelecaoPedidos;

    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add(fGetSQLPedidos(True, strTmpPedidosPendentes));

    If Assigned(qryQuery.Params.FindParam('CODEMP')) Then
      qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryQuery.Open;

    pCriarClientDataSetPedidos(qryQuery);

    cdsPedidos.DisableControls;
    cdsPedidos.AfterScroll  := Nil;
    dtsPedidos.OnDataChange := Nil;
    pCarregaListaCodigos;
    Try
      pAtualizaPedidosCampoKIT;
      pAtualizaLocaisSeparacao;
      pAtualizaNumeroRomaneio;
      pAtualizaDadosDocumentos(fExibirTempoExpedicao);
      pAtualizaSituacaoFinanceiraPedidos;
      pAtualizaPercentualDeSeparacao;
    Finally
      FLisCodCid := '';
      FLisCodRot := '';
      FLisAutIncFgo := '';
      FLisAutIncGer := '';

      pLimparIndices;

      cdsPedidos.AfterScroll  := cdsPedidosAfterScroll;
      dtsPedidos.OnDataChange := pDataChange;
      cdsPedidos.EnableControls;
    End;

    Screen.Cursor := crDefault;

    pFormataDecimal(cdsPedidos, 'VLRCON', 2);
    pFormataDecimal(cdsPedidos, 'VALDOC', 2);
    pFormataDecimal(cdsPedidos, 'PESBRU', 3);
    pFormataDecimal(cdsPedidos, 'MINFAT', 2);
    pFormataDecimal(cdsPedidos, 'VOLUME', 4);
    pFormataDecimal(cdsPedidos, 'TOTFRE', 2);

    If (fGetCol('DOCUME') <> Nil) Then
      fGetCol('DOCUME').Title.Caption := 'Pedido';
  Finally
    FreeAndNil(qryQuery);
  End;
end;

procedure TfrmFatExpedicao.pCarregarCores;
var
  LCorGrid: TCorGrid;
begin
  try
    LCorGrid := TCorGrid.Create('frmFatExpedicao', 'dbgPedidos');

    //FONTE - Separação não impressa.
    FCorSepNaoImp := LCorGrid.CarregarCor('SepNaoImp');
    shpSepNaoImp.Brush.Color := FCorSepNaoImp;

    //FONTE - Separação já impressa.
    FCorSepImp := LCorGrid.CarregarCor('SepImp');
    shpSepImp.Brush.Color := FCorSepImp;

    //FONTE - Alterado com Separação já impressa
    FCorAltSepImp := LCorGrid.CarregarCor('AltSepImp');
    shpAltSepImp.Brush.Color := FCorAltSepImp;

    //FONTE - Documento de Devolução
    FCorDocDev := LCorGrid.CarregarCor('DocDev');
    shpDocDev.Brush.Color := FCorDocDev;

    //FONTE - Separação já reimpressa após alteração do pedido.
    FCorSepReimp := LCorGrid.CarregarCor('SepReimp');
    shpSepReimp.Brush.Color := FCorSepReimp;

    //FONTE - Impressão da Separação não liberada.
    FCorLibSep := LCorGrid.CarregarCor('LibSep');
    shpLibSep.Brush.Color := FCorLibSep;

    //FONTE - Expedidos total.
    FCorIteExp := LCorGrid.CarregarCor('IteExp');
    shpIteExp.Brush.Color := FCorIteExp;

    //FONTE - Expedidos parcial.
    FCorTotExp := LCorGrid.CarregarCor('TotExp');
    shpTotExp.Brush.Color := FCorTotExp;

    //FONTE - Documento posicionado fonte
    FCorDocPosFonte := LCorGrid.CarregarCor('DocPosFonte');

    //FONTE - Documento posicionado e selecionado
    FCorDocSelPos := LCorGrid.CarregarCor('DocSelPos');

    //FUNDO - Pedido referente a garantia
    FCorGarantia := LCorGrid.CarregarCor('Garantia');
    shpGarantia.Brush.Color := FCorGarantia;

    //FUNDO - Documento selecionado
    FCorDocSel := LCorGrid.CarregarCor('DocSel');

    //FUNDO - Documento posicionado fundo
    FCorDocPosFundo := LCorGrid.CarregarCor('DocPosFundo');

    //FONTE - Urgente
    FCorUrgente := LCorGrid.CarregarCor('Urgente');

    //FONTE - Ord. Pro.
    FCorOrdPro := LCorGrid.CarregarCor('OrdPro');

    //FONTE - Ord. Pro. Pendente
    FCorOrdProPendente := LCorGrid.CarregarCor('OrdProPendente');

    //FUNDO - Vendedores da mesma empresa
    FCorVenEmp := LCorGrid.CarregarCor('VenEmp');
    shpVenEmp.Brush.Color := FCorVenEmp;

    //FUNDO - Vendedores de outras empresas
    FCorVenOutEmp := LCorGrid.CarregarCor('VenOutEmp');
    shpVenOutEmp.Brush.Color := FCorVenOutEmp;
  finally
    FreeAndNil(LCorGrid);
  end;
end;

procedure TfrmFatExpedicao.pCarregarEmAvisoPedidosDoMesmoClienteNaExpedicao(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
  var
    LCds                            : TUniClientDataSet;
    PossuiOutrosDocumentosDoCliente : Boolean;
begin

  LCds := TUniClientDataSet.Create(Nil);

  Try
    pCloneDataSet(LCds, cdsPedidos);

    LCds.Filtered := False;
    LCds.Filter   := Format('CODCLI = ''%S'' AND NUMDOC + ESPDOC + CODEMP <> ''%S''',
      [strCodCli, strNumDoc + strEspDoc + strCodEmp]);
    LCds.Filtered := True;

    PossuiOutrosDocumentosDoCliente := (not LCds.ISEmpty);
  Finally
    FreeAndNil(LCds);
  End;

  If Not PossuiOutrosDocumentosDoCliente Then
    Exit;

  if (fMensagem('', 'Atenção! existem pedidos pendentes do mesmo cliente do pedido selecionado. Deseja carregá-los?', ['&Sim', '&Não'], 2) = 1) then
    pCarregarPedidosCliente(strCliSel, strNomCli);

end;

procedure TfrmFatExpedicao.pCarregarEmAvisoTodosOsPedidosAbertosParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
  var
    frmPedidosNaoFaturadosDoMesmoCliente : TfrmPedidosNaoFaturadosDoMesmoCliente;
begin

  pCriarFormularios(TfrmPedidosNaoFaturadosDoMesmoCliente, frmPedidosNaoFaturadosDoMesmoCliente);

  Try

    If frmPedidosNaoFaturadosDoMesmoCliente.fExistePedidosEmAbertoParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp) Then
      If frmPedidosNaoFaturadosDoMesmoCliente.fDesejaCarregarOsPedidosEmAbertoDoMesmoClienteQueEstaoNaExpedicao Then
        pCarregarPedidosCliente(strCliSel, strNomCli);

  Finally
    pFreeAndNil(frmPedidosNaoFaturadosDoMesmoCliente);
  End;

end;

procedure TfrmFatExpedicao.pCarregarInformacoesPnlDocumentoSelecionados;
begin
  if (not Assigned(stlPedidos)) or
     (stlPedidos.Count = 0) then
  begin
    FValorContabilTotalDocSelecionados := 0;
    FPesoTotalDocSelecionados          := 0;
    FVolumeTotalDocSelecionados        := 0;
    FCubagemTotalDocSelecionados       := 0;
    FValorTotalDocSelecionados         := 0;
    pnlDocumentosSelecionados.Visible  := False;
  end
  else
    pnlDocumentosSelecionados.Visible  := True;

  lblDocsSelecionados.Caption               := FormatFloat('00000', stlPedidos.Count);
  lblValorContabilTotalSelecionados.Caption := FormatFloat('#,##0.00', FValorContabilTotalDocSelecionados);
  lblPesoTotalSelecionados.Caption          := FormatFloat('#,##0.00', FPesoTotalDocSelecionados);
  lblVolumeTotalSelecionados.Caption        := FormatFloat('#,##0.00', FVolumeTotalDocSelecionados);
  lblValorTotalSelecionado.Caption          := FormatFloat('#,##0.00', FValorTotalDocSelecionados);

  If (fCfgSis('MOEXSI', varInteger) <> 0) Then
  Begin
    lblCubTotal.Visible := True;
    lblVlrCubSelecionados.Visible := True;
    lblVlrCubSelecionados.Caption := FormatFloat(fMskDigitos(intDecCub), FCubagemTotalDocSelecionados);
  End;
end;

procedure TfrmFatExpedicao.pCarregarPedidosCliente(strCodCli, strNomCli: String);
begin

  btnLimparBusca.Click;

  Try
    SetLength(arrCliente, 1);
    arrCliente[0].strCodigo := strCodCli;
    arrCliente[0].strDescri := strNomCli;
  Finally
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
  End;

end;

procedure TfrmFatExpedicao.pCarregaSugestaoDadosFiltroVendedor;
var
  LValorCampo: String;
  LCodigos: TArray<String>;
  LContador: Integer;
begin
  SetLength(arrVendedor, 0);
  SetLength(arrDepVen, 0);

  LValorCampo := TCfgSugExp.fRetornaValorSusgetao('edtCodVen', True);
  If Not fEmptyStr(LValorCampo) Then
  Begin
    If pos('[', LValorCampo) > 0 Then
    Begin
      LValorCampo := AnsiReplaceStr(AnsiReplaceStr(LValorCampo, ']',''), '[', '');
      LCodigos := LValorCampo.Split([';']);
      SetLength(arrVendedor, Length(LCodigos));

      For LContador := 0 to Length(LCodigos) - 1 Do
      Begin
        arrVendedor[LContador].strCodigo := LCodigos[LContador];
      End;
    End
    Else
    Begin
      SetLength(arrVendedor, Length(arrVendedor)+1);
      arrVendedor[Pred(Length(arrVendedor))].strCodigo := LValorCampo;
    End;
  End;

  LValorCampo := TCfgSugExp.fRetornaValorSusgetao('edtCodDep', True);
  If Not fEmptyStr(LValorCampo) Then
  Begin
    If pos('[', LValorCampo) > 0 Then
    begin
      LValorCampo := AnsiReplaceStr(AnsiReplaceStr(LValorCampo, ']',''), '[', '');
      LCodigos := LValorCampo.Split([';']);
      SetLength(arrDepVen, Length(LCodigos));

      For LContador := 0 to Length(LCodigos) - 1 Do
      Begin
        arrDepVen[LContador].strCodigo := LCodigos[LContador];
      End;
    End
    Else
    Begin
      SetLength(arrDepVen, Length(arrDepVen)+1);
      arrDepVen[Pred(Length(arrDepVen))].strCodigo := LValorCampo;
    End;
  End;
end;

procedure TfrmFatExpedicao.pConfigurarTelaDeExpedicaoParaEmitirApenasGeracaoDeRemessaDePedido;
  var
    intPercorrer : Integer;
    blnBloqueia  : Boolean;
begin

  For intPercorrer := 0 To Self.ComponentCount -1 Do
  Begin

    If Self.Components[intPercorrer] Is TBitBtnLocked Then
    Begin

      blnBloqueia := True;

      If ((Self.Components[intPercorrer]) As TBitBtnLocked).Caption = btnBuscar.Caption Then
        blnBloqueia := False;

      If ((Self.Components[intPercorrer]) As TBitBtnLocked).Caption = btnLimparBusca.Caption Then
        blnBloqueia := False;

      If ((Self.Components[intPercorrer]) As TBitBtnLocked).Caption = btnImpSep.Caption Then
        blnBloqueia := False;

      If ((Self.Components[intPercorrer]) As TBitBtnLocked).Caption = btnCfgExp.Caption Then
        blnBloqueia := False;

      If ((Self.Components[intPercorrer]) As TBitBtnLocked).Caption = btnSair.Caption Then
        blnBloqueia := False;

      ((Self.Components[intPercorrer]) As TBitBtnLocked).Enabled := Not blnBloqueia;

    End;

  End;

  tmrBuscar.Enabled := True;

end;

function TfrmFatExpedicao.fSqlPedidosVinculados: String;
begin
  Result := Result + ' SELECT';
  Result := Result + '   CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMDOC,';
  Result := Result + '   FGO_DTAENT, FGO_VLRCON, ';
  Result := Result + '   SUM( IF( COALESCE(FDO_QTDBAI, 0) = 0, FDO_TOTITE - FDO_DESESP, ROUND(((FDO_TOTITE - FDO_DESESP) / FDO_QTDITE) * (FDO_QTDITE - FDO_QTDBAI), 2 ) ) ) AS VALDOC, ';
  Result := Result + '   CAST( GROUP_CONCAT(DISTINCT IF(FD.FDO_ENTFUT = "S", "F", ED.FDO_ENTRET) SEPARATOR "/") AS CHAR(50)) AS ENTRET, ';
  Result := Result + '   CAST( GROUP_CONCAT(DISTINCT FDO_EMPITE SEPARATOR "/") AS CHAR(50)) AS EMPITE, ';
  Result := Result + '   FGO_DTAFAT,';
  Result := Result + '   CONCAT(FGO_NUMFAT, "-", FGO_TIPFAT, "-", FGO_EMPFAT) AS NUMFAT';
  Result := Result + ' FROM FATGOR FG';
  Result := Result + ' INNER JOIN EXTGOR EG ON EG.FGO_SEQFGO = FG.AUTOINCREM';
  Result := Result + ' INNER JOIN FATDOR FD ON FG.AUTOINCREM = FD.FDO_SEQGER';
  Result := Result + '  LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO ';
  Result := Result + ' WHERE EG.FGO_SEQDMP = :SEQDMP';
  Result := Result + '   AND FG.AUTOINCREM <> :AUTOINC';
  Result := Result + ' GROUP BY';
  Result := Result + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI ';

  Result := Result + ' UNION ALL';

  Result := Result + ' SELECT';
  Result := Result + '   CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS NUMDOC,';
  Result := Result + '   GER_DTAENT, GER_VLRCON, ';
  Result := Result + '   GER_VLRCON AS VALDOC, ';
  Result := Result + '   IF(GER_ENTFUT = "S", "F", IF(GER_ENTFAT = "S", "E", "R")) AS ENTRET, ';
  Result := Result + '   CAST( GROUP_CONCAT(DISTINCT DET_CODEMP SEPARATOR "/") AS CHAR(50)) AS EMPITE, ';
  Result := Result + '   GER_DTAFAT,';
  Result := Result + '   CONCAT(GER_NUMFAT, "-", GER_TIPFAT, "-", GER_EMPFAT) AS NUMFAT';
  Result := Result + ' FROM MOVGER MG';
  Result := Result + ' INNER JOIN AUXMOV AM ON AM.AUX_SEQGER = MG.AUTOINCREM';
  Result := Result + ' INNER JOIN MOVDET MD ON MD.DET_SEQGER = MG.AUTOINCREM';
  Result := Result + ' WHERE AM.AUX_SEQDMP = :SEQDMP';
  Result := Result + '   AND MG.AUTOINCREM <> :AUTOINC';
  Result := Result + ' GROUP BY';
  Result := Result + '   GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_CODCLI ';

end;

function TfrmFatExpedicao.fSQL_SOMA_ENTFUT: String;
  Var
    blnConsiderarCfgCalSal: Boolean;
begin
  blnConsiderarCfgCalSal := cdsPedidos.FieldByName('BENFUT').AsString <> 'S';

  If fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal) Then
    Result := ' ( ' + fGetSQLSomaCamposEntregaFutura('G', True) + ' ) '
  Else
    Result := ' 0.00 ';
end;

procedure TfrmFatExpedicao.FormShow(Sender: TObject);
var
  intRetQtdPedidos: Integer;
begin
  inherited;
  pCarregaSugestaoDadosFiltroVendedor;
  blnExecutandoFormShow := True;

  Try
    pGeraTransferencias;
    pGeraRequisicoesCompra;

    blnExibirPedidosFaturamentoAutomatico := fExibirPedidosFaturamentoAutomatico;
    FUtilizaOndaSeparacaoAgrupamento := fUsaOndaSeparacaoAgrupamento;

    pnlLegendEmpVen.Visible := fCfgSis('EMPVEN', VarBoolean);
    blnRegCid := fCfgSis('REGCID', varBoolean);

    If Not pnlLegendEmpVen.Visible Then
      pgcExpedicao.Height := pgcExpedicao.Height - pnlLegendEmpVen.Height;

    btnEntFutCD.Visible := (fCfgSis('PEF_CD') = 'S') And
                           (fCfgSis('ENT_CD') = 'S') And
                           (fCfgSis('EMP_CD') = VS_strCodEmp) And
                           ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    btnBaixarPedidoNaoEntregue.Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And
                                          (fCfgSis('BXPDNE', varBoolean));

    If ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    Begin
      btnImpSep.Visible := fCfgSis('BTNSEP', varBoolean);

      If btnImpSep.Visible Then
        btnImpSep.Visible := fVerificaAcessoSistema('IMPEXP');

      If btnBaixarPedidoNaoEntregue.Visible Then
        btnBaixarPedidoNaoEntregue.Visible := fVerificaAcessoSistema('BXPDNE');
    End;

    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Begin
      lblTotProdExp.Visible    := True;
      lblTotProdNotExp.Visible := True;
      lblTotProd.Visible       := True;

      lbl_TotProdExp.Visible    := True;
      lbl_TotProdNotExp.Visible := True;
      lbl_TotProd.Visible       := True;

      lblTotProdExp.Caption    := '0,00';
      lblTotProdNotExp.Caption := '0,00';
      lblTotProd.Caption       := '0,00';
    End;

    blnNfeXdf := fCfgSis('NFEXDF', varBoolean);

    stlPedidos := TStringList.Create;
    stlPedidosBkp := TStringList.Create;
    cdsDocsExcluirLoteSep := TUniClientDataSet.Create(Nil);
    strEmpSel  := '';
    strCliSel  := '';
    strFazSel  := '';
    strEmbSel  := '';
    strTipSel  := '';
    strBeFSel  := '';
    strTemAdt  := '';
    strBolAdt  := '';
    strTemRec  := '';
    strOriSel  := '';
    strFatSel  := '';
    strCfgENFUOPSel := '';
    strSolAbaSel := '';
    blnFreRatSel := False;
    blnDecZfmSel := False;
    strRegEspSel := '';
    strUtiResSel := '';
    strTaxJurSel := '';
    strCotLal := '';

    FblnTemPedidoDeConsignacao := False;

    tipOrigem := oriTodas;
    strEntRet := 'T';
    strUrgente := 'T';
    strFatTot := 'T';
    blnOndaSeparacaoApenasPedidoFaturadorAutomatico := False;

    btnLegenda.Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And fCfgSis('EXISTA', varBoolean);

    lblLocArmDesc.Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));
    lblLocArm.Visible     := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    TCfgSugExp.pCarregarSugestoes(pnlFiltros);
    pCarregaOpcoesLocais;

    If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
    Begin
      lblTitCND.Visible := False;
      lblCONPAG.Visible := False;
      lblTitFPG.Visible := False;
      lblCODFPG.Visible := False;
      lblDESFPG.Visible := False;

      lblFreSug.Visible := fCfgSis('FREVEN', varBoolean) and
                           fCfgSis('TRACOT', varBoolean);
      lblFreCot.Visible := lblFreSug.Visible;
      dbeFreSug.Visible := lblFreSug.Visible;
      dbeFreCot.Visible := lblFreSug.Visible;
      dbeFreCot.DataField := 'FRESUG';
      dbeFreSug.DataField := 'FRECOT';

      pInicializarFiltroLocSepArmazem(blnApenasImprimirBaixarSeparacao);

      TFrmGravando.fExecutarModalA( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');

      pExibirBotoesLabels;

      btnConfirma.Visible := False;
      btnImpSep.Visible   := fCfgSis('SEPEXF', varBoolean);
      lblPrevis.Visible   := False;
      dbtxtPrevis.Visible := False;
      pnlLegFat.Visible   := False;

      lblTipoAtendimentoC.Visible := False;
      lblTipoAtendimentoD.Visible := False;

      If btnImpSep.Visible Then
        btnImpSep.Visible := fVerificaAcessoSistema('IMPEXP');
    End
    Else
    Begin
      lblTitCND.Visible := True;
      lblCONPAG.Visible := True;
      lblTitFPG.Visible := fCfgSis('USAFPG', varBoolean);
      lblCODFPG.Visible := lblTitFPG.Visible;
      lblDESFPG.Visible := lblTitFPG.Visible;

      lblTipoAtendimentoC.Visible := True;
      lblTipoAtendimentoD.Visible := True;

      pInicializarFiltroLocSepArmazem(blnApenasImprimirBaixarSeparacao);

      TFrmGravando.fExecutarModalA( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');

      pnlInfo.Caption := '[ENTER] Marca / Desmarca Pedido                     TIP.OPE.: (V)enda (B)onificação (C)onta e Ordem';

      If (fCfgSis('SEPEXP') = 'P') And (Not blnApenasImprimirBaixarSeparacao) Then
        btnImpSep.Caption := '[F6] Imprimir Pedido';
    End;

    strTipExp := VS_strTipExp;

    btnFaturarExpedidos.Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_ROMANEIO_E_PEDIDO_NAO_SERA_FATURADO)) And
                                   (fCfgExpedicaoParcialHabilitada);
    if btnFaturarExpedidos.Visible then
      btnFaturarExpedidos.Enabled := fVerificaAcessoSistema('EXF11P');

    If btnFaturarExpedidos.Visible Then
      btnConfirma.Caption := '[F10] Exp. Itens'
    Else Begin
      shpIteExp.Visible := False;
      lblIteExp.Visible := False;
      shpTotExp.Visible := False;
      lblTotExp.Visible := False;
    End;

    If (grbLocSep.Visible) Then Begin
      shpIteExp.Visible := True;
      shpTotExp.Visible := True;
      lblTotExp.Visible := True;
      lblIteExp.Visible := True;

      lblTotExp.Caption := 'Separação parcial.';
      lblIteExp.Caption := 'Separação total.';
    End;

    If blnApenasImprimirBaixarSeparacao Then
    Begin
      btnImpSep.Visible := True;
      btnConfirma.Visible := False;
      btnFaturarExpedidos.Visible := False;
      btnImpSep.Visible := fVerificaAcessoSistema('IMPEXP');
    End
    Else
    Begin
      If fCfgSis('BAISEP', VarBoolean) And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And blnUsaImpressaoSeparacaoPorLocal Then
      Begin
        If fUsaRotinaWMS And btnImpSep.Visible Then
          btnImpSep.Visible := False;
      End;
    End;

    dbtxtNomSep.Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));
    lblNomSep.Visible   := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    dbtxtOrdPro.Visible := (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And blnApenasImprimirBaixarSeparacao;
    lblOrdPro.Visible   := (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And blnApenasImprimirBaixarSeparacao;

    If blnApenasImprimirBaixarSeparacao Or blnApenasConferenciaProdutosRetiraCaixa Then
    Begin
      If (fGetCol('VALDOC') <> Nil) Then
        fGetCol('VALDOC').Visible := False;

      If (fGetCol('VLRCON') <> Nil) Then
        fGetCol('VLRCON').Visible := False;
    End;

    fGetCol('DTAROT' ).Visible := (VS_strTipExp  = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (fCfgExpedicaoParcialHabilitada) And blnRegCid;
    fGetCol('SEQROT' ).Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And blnRegCid;
    fGetCol('DESREG2').Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And blnRegCid;
    shpLibSep.Visible := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And blnRegCid;
    lblLibSep.Visible := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And blnRegCid;

    btnConPedPen.Visible := fVerificaAcessoSistema('PEDPEN') And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    pExibirBotoesLabels;

    blnUsaPTF := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And ((fCfgExpedicaoParcialHabilitada) And (fCfgSis('USAPTF') = 'S')) And
                  (Not blnApenasImprimirBaixarSeparacao) And (Not blnApenasConferenciaProdutosRetiraCaixa) And
                  (Not((ParamCount > 0) And Not SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA'))));

    btnDesmExpedidos.Visible := (fVerificaAcessoSistema('DSPDEX')) And (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);
    btnDesmembrarPed.Visible := (fVerificaAcessoSistema('frmFatDesmembrarPedido')) And (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO);
    btnCortarProdutosPedido.Visible := (fCfgSis('CORFAT', varBoolean)) And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    pnlDiversos.Visible := rdgTipoDocumento.Visible Or rdgTipoConferencia.Visible Or pnlFilSitFin.Visible Or grbLocSep.Visible;
    pnlFiltros.Visible := pnlDiversos.Visible Or pnlStatusPedido.Visible;



    If pnlFiltros.Visible Then
    Begin
      If Not pnlDiversos.Visible Then
        pnlFiltros.Height := pnlFiltros.Height - pnlDiversos.Height
      Else If Not pnlStatusPedido.Visible Then
        pnlFiltros.Height := pnlFiltros.Height - pnlStatusPedido.Height;
    End;

    mnuVerSeparacoes.Visible := ((blnApenasImprimirBaixarSeparacao) And (grbLocSep.Visible))
      Or (
           (Not blnApenasConferenciaProdutosRetiraCaixa) And
           (Not blnApenasImprimirBaixarSeparacao) And
           (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO])) And
           (fCfgSis('BAISEP', varString) = 'S') And
           (
             ((fCfgSis('BXAZSP', varString) = 'S') And (fCfgSis('CTLEST', varInteger) = 2)) Or
              (fCfgSis('BXLCSP', varString) = 'S')
           )
         );

    btnSeparacao.Visible := (mnuVerSeparacoes.Visible) Or (((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)));
    btnExpedicao.Visible := (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And (Not blnApenasImprimirBaixarSeparacao);

    mnuDesfazerExpedicaoDesteDocumento.Enabled := (fCfgExpedicaoParcialHabilitada);

    {Separação}
    If (btnSeparacao.Visible) Then
    Begin
      btnSeparacao.Caption := 'Separação';
      btnSeparacao.Width   := 92;
    End;

    {Expedição}
    If (btnExpedicao.Visible) Then
    Begin
      btnExpedicao.Caption := 'Expedição';
      btnExpedicao.Width   := 92;
    End;

    If (fGetCol('TMPEXP') <> Nil) Then
      fGetCol('TMPEXP').Visible := (fExibirTempoExpedicao());

    If (fGetCol('EXPTOL') <> Nil) Then
      fGetCol('EXPTOL').Visible := (fExibirTempoExpedicao());

    rdgTipoMov.Visible := (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]));
    grbLocRet.Visible := grbLocRet.Visible and (not blnApenasConferenciaProdutosRetiraCaixa);

    TCfgColExp.pIniciar(dbgPedidos);

    If blnApenasConferenciaProdutosRetiraCaixa Then
    Begin
      cmbSitFin.ItemIndex  := 0;

      rdgTipoMov.ItemIndex := 0; { Retira }
      rdgTipoMov.Enabled   := False;
      rdgTipoMov.Visible   := False;

      dbgPedidos.Options   := dbgPedidos.Options - [dgRowSelect, dgMultiSelect];

      btnImpSep.Visible    := False;
      btnConfirma.Visible  := True;

      blnAltEmpFat := False;
      btnAltEmpFat.Visible  := False;

      btnConfirmaCupons.Visible   := False;
      btnDesmExpedidos.Visible    := False;
      btnBuscaNFe_Estoque.Visible := False;
      btnFaturarExpedidos.Visible := False;
    End;

    pFiltrarPedidos();
    pCalculaResumoTotalDocumentos();

    pInicializarNotificacoes();

    dbeFatTot.Visible := (fExibirInformacaoFaturamentoParcial());
    lblPedTransf.Visible := fExibirDadosTransReqCompraPedido();
    dbePedTransf.Visible := lblPedTransf.Visible;
    lblReqCompra.Visible := lblPedTransf.Visible;
    dbeReqCompra.Visible := lblPedTransf.Visible;

    // TIPO 3 E 4 - Columns = 1 "Nome do Vendedor"
    if ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
      fFindColumnByName(dbgPedidos, 'NOMOPE').Visible := True;

    fFindColumnByName(dbgPedidos, 'CODLAR').Visible := False;
    fFindColumnByName(dbgPedidos, 'DESLAR').Visible := fSolicitaLocalDeArmazenamento;

    fFindColumnByName(dbgPedidos, 'DOCFAT').Visible := blnExibirPedidosFaturamentoAutomatico;
    fFindColumnByName(dbgPedidos, 'PERSEP').Visible := fUsaRotinaWMS;
    fFindColumnByName(dbgPedidos, 'PERCOF').Visible := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_ROMANEIO_E_PEDIDO_NAO_SERA_FATURADO)) And
                                                       (fCfgExpedicaoParcialHabilitada);

    btnMensagemExpedicao.Visible := fVerificaAcessoSistema('MSGEXP') And
                                    ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)
                                    or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)
                                    or (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA)) And
                                    (Not blnApenasImprimirBaixarSeparacao) And
                                    (Not blnApenasConferenciaProdutosRetiraCaixa);

    pHabilitarBotaoFaturarOndaSeparacao;

    btnSituacaoItens.Visible := blnApenasImprimirBaixarSeparacao;

    mnuRemanejarSeparador.Visible := TManutencaoSeparadoresPorLocal.fUtilizaSeparadorPorLocal(
      fCfgSis('SENSEP', varString),
      fCfgSis('UTIWMS', varBoolean),
      fCfgSis('LSEWMS', varBoolean));

    btnDefinirSeparadorConferente.Visible := (fCfgSis('WMSSEP', varString) = '2') and fCfgSis('DESECO', varBoolean);
    blnPermitirAlterarDataEntregaPedido := fVerificaAcessoSistema('mnuPermitirAlterarDataEntregaPedido');

    btnFrete.Enabled := fVerificaAcessoSistema('frmFatAltValorFreteSuges');
    btnFrete.Visible := (fCfgSis('TIPEXP', varString) = TIPEXP_POR_DOCUMENTO_DE_VENDA) and fCfgSis('FREVEN', varBoolean);

    intRetQtdPedidos := fRetQtdPedidosEntFutCD(VS_strCodEmp);
    if intRetQtdPedidos > 0 then
    begin
      btnEntFutCD.Font.Color := clBlue;
      btnEntFutCD.Caption := '[Ctrl+E] Ent.Fut.pelo CD ('+ IntToStr(intRetQtdPedidos) +')';
    end
    else
      btnEntFutCD.Font.Color := clBlack;

    mnuGuardarItensSep.Visible := fUsaRotinaWMS and
                                  (fCfgSis('GDPDCN', varString) = 'S') and
                                  (not blnApenasImprimirBaixarSeparacao) and
                                  (fCfgSis('BXSLSE', varString) = 'N');

    pCarregarInformacoesPnlDocumentoSelecionados;

    If (FApenasGeracaoDeRemessaDePedido) Then
      pConfigurarTelaDeExpedicaoParaEmitirApenasGeracaoDeRemessaDePedido;

    if (fUsaOndaSeparacaoAgrupamento) then
    begin
      btnImpSep.Caption := '[F6] Gerar Remessa de Pedido';
      btnImpSep.Width := 160;
    end;

    pAlteraNomeColumaSEQSEP;
  Finally
    blnExecutandoFormShow := False;
    cdsPedidosAfterScroll(cdsPedidos);
  End;

  btnRobSep.Visible := ((blnApenasImprimirBaixarSeparacao) And (TUtilMonitor.fMonitorIsRunning(spIdMonitorLotWMS)));
  lblRobSep.Visible := False;

  btnAltLotImpSep.Visible := (fUtilizaDefinicaoLoteSemWMS And fVerificaAcessoSistema('ALTLOTNOTWMS'));
  btnConsultaPed.Visible := (pos(fCfgSis('TIPEXP'), '3_4_') > 0);

  If (btnRobSep.Visible) And (TUtilMonitor.fMonitorSuspenso(spIdMonitorLotWMS)) Then
  Begin
    btnRobSep.Caption := 'Habilitar Robô de Separação';
    lblRobSep.Visible := True;
  End;

  lblPeso.Visible := fVerificaAcessoSistema('EXPSPD');
  dbtPeso.Visible := lblPeso.Visible;

  pnlOperador.Caption := strLoginUsuarioLogado+'-'+strDescriUsuarioLogado;

  btnReimprimeDocumento.Visible := (Pos(fCfgSis('TIPEXP'), '2_3_4') > 0) and (fVerificaAcessoSistema('RIMPDC'));
end;

function TfrmFatExpedicao.fSomenteF3 : Boolean;
Begin
  Result := (fCfgSis('OBRSBR', varString) = 'S') And ( Not fVerificaAcessoSistema('LIB_F3') );
End;

function TfrmFatExpedicao.fSQLFiltroLocalizacaoFisica: String;
begin
  If fEmptyStr(strLocFis + strLocIni + strLocIniSup) Then
    Exit('');

  if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
  begin
    Result := ' AND ( ' +
              '((FATDOR.FDO_NUMLOT <> "") AND ' +
              '     EXISTS ( SELECT CADLOT.LOT_CODITE ' +
              '              FROM CADLOT '+
              '              WHERE CADLOT.LOT_CODITE = FATDOR.FDO_CODITE ' +
              '                AND CADLOT.LOT_NUMLOT = FATDOR.FDO_NUMLOT ' +
              '                AND CADLOT.LOT_CODEMP = "' + VS_strCodEmp + '" ';

    If Not fEmptyStr(strLocFis) Then
      Result := Result +
        ' AND  LEFT(CADLOT.LOT_LOCFIS, LENGTH("' + strLocFis + '")) = "' +
          strLocFis + '" ';

    If Not fEmptyStr(strLocIni) Then
      Result := Result +
        ' AND LEFT(CADLOT.LOT_LOCFIS, LENGTH("' + strLocIni + '")) BETWEEN "' +
          strLocIni + '" AND "' + strLocFin + '" ';

    Result := Result + ' )) ';

    Result := Result + ' OR ' +

              ' ((IFNULL(FATDOR.FDO_NUMLOT, "") = "") AND ' +
              '     EXISTS ( SELECT ITEGER.ITE_CODITE ' +
              '              FROM ITEGER '+
              '              WHERE ITEGER.ITE_CODITE = FATDOR.FDO_CODITE ' +
              '                AND ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '" ';

    If Not fEmptyStr(strLocFis) Then
      Result := Result +
        ' AND  LEFT(ITEGER.ITE_LOCFIS, LENGTH("' + strLocFis + '")) = "' +
          strLocFis + '" ';

    If Not fEmptyStr(strLocIni) Then
      Result := Result +
        ' AND LEFT(ITEGER.ITE_LOCFIS, LENGTH("' + strLocIni + '")) BETWEEN "' +
          strLocIni + '" AND "' + strLocFin + '" ';

    If Not fEmptyStr(strLocIniSup) Then
      Result := Result +
        ' AND LEFT(ITEGER.ITE_LOCSUP, LENGTH("' + strLocIniSup + '")) BETWEEN "' +
          strLocIniSup + '" AND "' + strLocFinSup + '" ';

    Result := Result + ' ))) ';

  end
  else
  begin
    Result := ' AND EXISTS ( SELECT ITEGER.ITE_CODITE ' +
              '              FROM ITEGER '+
              '              WHERE ITEGER.ITE_CODITE = FATDOR.FDO_CODITE ' +
              '                AND ITEGER.ITE_CODEMP = "' + VS_strCodEmp + '" ';

    If Not fEmptyStr(strLocFis) Then
      Result := Result +
        ' AND  LEFT(ITEGER.ITE_LOCFIS, LENGTH("' + strLocFis + '")) = "' +
          strLocFis + '" ';

    If Not fEmptyStr(strLocIni) Then
      Result := Result +
        ' AND LEFT(ITEGER.ITE_LOCFIS, LENGTH("' + strLocIni + '")) BETWEEN "' +
          strLocIni + '" AND "' + strLocFin + '" ';

    If Not fEmptyStr(strLocIniSup) Then
      Result := Result +
        ' AND LEFT(ITEGER.ITE_LOCSUP, LENGTH("' + strLocIniSup + '")) BETWEEN "' +
          strLocIniSup + '" AND "' + strLocFinSup + '" ';

    Result := Result + ' ) ';
  end;
end;

function TfrmFatExpedicao.fSQLOrdemCor(): String;
begin
  Result := '';
  Result := Result + '(SELECT                                                            ';
  Result := Result + '  AUTOINCREM,                                                      ';
  Result := Result + '  (SELECT                                                          ';
  Result := Result + '    CAST(COALESCE(GRD_SEQCOR, 1) AS UNSIGNED) AS ORDCOR            ';
  Result := Result + '  FROM                                                             ';
  Result := Result + '    GRDCOR                                                         ';
  Result := Result + '  WHERE GRD_FORMUL = "frmFatExpedicao"                             ';
  Result := Result + '    AND GRD_GRID__ = "dbgPedidos"                                  ';
  Result := Result + '    AND GRD_IDENTI = CHAVES.CHAVE) ORDCOR                          ';
  Result := Result + 'FROM                                                               ';
  Result := Result + '  (SELECT                                                          ';
  Result := Result + '    AUTOINCREM,                                                    ';
  Result := Result + '    IF(                                                            ';
  Result := Result + '      (                                                            ';
  Result := Result + '        VLRMIN > VRROTA                                            ';
  Result := Result + '        AND LIBSEP = "N"                                           ';
  Result := Result + '        AND ' + fBooleanToString(VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) + '           ';
  Result := Result + '        AND ' + fBooleanToString(fCfgSis('REGCID', varBoolean)) + '';
  Result := Result + '      ),                                                           ';
  Result := Result + '      "LibSep",                                                    ';
  Result := Result + '      IF(                                                          ';
  Result := Result + '        DOCDEV = "S",                                              ';
  Result := Result + '        "DocDev",                                                  ';
  Result := Result + '        IF(                                                        ';
  Result := Result + '          EXPTOT = "S",                                            ';
  Result := Result + '          "TotExp",                                                ';
  Result := Result + '          IF(                                                      ';
  Result := Result + '            TEMEXP = "S",                                          ';
  Result := Result + '            "IteExp",                                              ';
  Result := Result + '            CASE                                                   ';
  Result := Result + '              WHEN (SEPIMP = "0")                                  ';
  Result := Result + '              THEN "SepNaoImp"                                     ';
  Result := Result + '              WHEN (SEPIMP = "1")                                  ';
  Result := Result + '              THEN "SepImp"                                        ';
  Result := Result + '              WHEN (SEPIMP = "2")                                  ';
  Result := Result + '              THEN "AltSepImp"                                     ';
  Result := Result + '              WHEN (SEPIMP = "3")                                  ';
  Result := Result + '              THEN "SepReimp"                                      ';
  Result := Result + '              WHEN (SEPIMP = "S")                                  ';
  Result := Result + '              THEN "SepImp"                                        ';
  Result := Result + '              WHEN (SEPIMP = "N")                                  ';
  Result := Result + '              THEN "SepNaoImp"                                     ';
  Result := Result + '            END                                                    ';
  Result := Result + '          )                                                        ';
  Result := Result + '        )                                                          ';
  Result := Result + '      )                                                            ';
  Result := Result + '    ) CHAVE                                                        ';
  Result := Result + '  FROM                                                             ';
  Result := Result + '    (SELECT                                                        ';
  Result := Result + '      FG.AUTOINCREM,                                               ';
  Result := Result + '      COALESCE(FG.FGO_SEPIMP, "0") SEPIMP,                         ';
  Result := Result + '      IF(                                                          ';
  Result := Result + '        SUM(ED.FDO_QTDEXP) > 0                                     ';
  Result := Result + '        AND (                                                      ';
  Result := Result + '          (SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(ED.FDO_QTDEXP) ';
  Result := Result + '        ),                                                         ';
  Result := Result + '        "S",                                                       ';
  Result := Result + '        "N"                                                        ';
  Result := Result + '      ) TEMEXP,                                                    ';
  Result := Result + '      IF(                                                          ';
  Result := Result + '        (SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) = SUM(ED.FDO_QTDEXP),  ';
  Result := Result + '        "S",                                                       ';
  Result := Result + '        "N"                                                        ';
  Result := Result + '      ) EXPTOT,                                                    ';
  Result := Result + '      IF(                                                          ';
  Result := Result + '        (                                                          ';
  Result := Result + '          MG.GER_ESPDOC = "DV"                                     ';
  Result := Result + '          OR MG.GER_ESPDOC = "NF"                                  ';
  Result := Result + '        )                                                          ';
  Result := Result + '        AND (                                                      ';
  Result := Result + '          INSTR(                                                   ';
  Result := Result + '            MG.GER_CLAFIS,                                         ';
  Result := Result + '            "' + VS_strClaDev + '"                                 ';
  Result := Result + '          ) > 0                                                    ';
  Result := Result + '        ),                                                         ';
  Result := Result + '        "S",                                                       ';
  Result := Result + '        "N"                                                        ';
  Result := Result + '      ) DOCDEV,                                                    ';
  Result := Result + '      COALESCE(RR.ROT_VLRMIN, 0) VLRMIN,                           ';
  Result := Result + '      0.00 AS VRROTA,                                              ';
  Result := Result + '      ER.ENT_LIBSEP AS LIBSEP                                      ';
  Result := Result + '    FROM                                                           ';
  Result := Result + '      FATGOR FG                                                    ';
  Result := Result + '      INNER JOIN FATDOR FD                                         ';
  Result := Result + '        ON FG.AUTOINCREM = FD.FDO_SEQGER                           ';
  Result := Result + '      LEFT JOIN EXTDOR ED                                          ';
  Result := Result + '        ON FD.AUTOINCREM = ED.FDO_SEQFDO                           ';
  Result := Result + '      LEFT JOIN ITEGER IG                                          ';
  Result := Result + '        ON IG.ITE_CODITE = FD.FDO_CODITE                           ';
  Result := Result + '        AND IG.ITE_CODEMP = FD.FDO_CODEMP                          ';
  Result := Result + '      LEFT JOIN MOVGER MG                                          ';
  Result := Result + '        ON FG.FGO_NUMFAT = MG.GER_NUMDOC                           ';
  Result := Result + '        AND FG.FGO_TIPFAT = MG.GER_ESPDOC                          ';
  Result := Result + '        AND FG.FGO_EMPFAT = MG.GER_CODEMP                          ';
  Result := Result + '      LEFT JOIN EXTGOR EG                                          ';
  Result := Result + '        ON FG.AUTOINCREM = EG.FGO_SEQFGO                           ';
  Result := Result + '      LEFT JOIN ENTREG ER                                          ';
  Result := Result + '        ON ER.ENT_CODIGO = EG.FGO_CODROT                           ';
  Result := Result + '      LEFT JOIN ROTREG RR                                          ';
  Result := Result + '        ON RR.ROT_CODREG = ER.ENT_CODREG                           ';
  Result := Result + '    WHERE FG.FGO_ESPDOC = "PD" AND                                 ';
  Result := Result + '          IFNULL(FG.FGO_LIBERA, 0) > 0 AND                         ';
  Result := Result + '          IFNULL(FG.FGO_LIBCOM, 0) > 0 AND                         ';
  Result := Result + '          FGO_JAFATU = 0 AND                                       ';
  Result := Result + fFiltroEmpresaExpedicaoPedido(False);
  Result := Result + '    GROUP BY FG.AUTOINCREM) CHAVES) CHAVES) ORDGRD                 ';
end;

procedure TfrmFatExpedicao.dbgPedidosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strBarDocLocalizado: string;
begin
  inherited;
  HintControler.HideHint;

  strBarDocLocalizado := '';

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If blnAtualizandoGrid Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If (Key = VK_ESCAPE) Then
  Begin
    btnFechar.Click;
  End

  Else If (Key = VK_RETURN) Then
  Begin
    If strBarDocLocalizar <> '' Then
    Begin
      strBarDocLocalizado := strBarDocLocalizar;
      strBarDocLocalizar := '';
      If Not cdsPedidos.Locate('BARDOC', strBarDocLocalizado, []) Then
      Begin
        HintControler.ShowHint(pnlGrid.Left + pnlGrid.Width div 2 - 300, pnlGrid.Top + pnlGrid.Height div 2,
                               'Documento não encontrado',
                               'Nenhum documento encontrado com este código de barras:' + #13#10 +
                               fPadC('[ ' + strBarDocLocalizado + ' ]', 55));
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;
    End;

    If fSomenteF3 Then
    Begin
      if not blnF3 Then
      Begin
        fMensagem('', 'Será necessário utilizar botão "[F3] Buscar" para ler o código de barras do '+strDescDoc+'!', ['&OK']);
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;
    End;

    If Not fPermitirFaturarContaOrdem Then
      Exit;

    If InterlockedIncrement(intSemaforoSelecionar) = 0 Then
    Begin
      Try
        if fField('PEDPAR').AsString <> 'R' then
        begin
          If blnApenasConferenciaProdutosRetiraCaixa Then
          Begin
            pSelecionaVariosPedidos;
            If fSelecionado(cdsPedidos) Then
              If strBarDocLocalizado <> '' Then
                btnConfirma.Click;
          End
          Else If blnApenasImprimirBaixarSeparacao Then
            pBaixarSeparacaoPedido
          Else If fField('FATAUT').AsString = 'S' Then
            pSelecionaPedido()
          Else
          Begin
            If (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA) Or (fField('ESPDOC').AsString = 'PD') Then
            Begin
              pSelecionaVariosPedidos;
              If fSelecionado(cdsPedidos) Then
                If strBarDocLocalizado <> '' Then
                  btnConfirma.Click;
            End
            Else
              pSelecionaPedido();
          End;
        end
        else
          pSelecionaPedido;

        If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
          pResumo;

        InterlockedDecrement(intSemaforoSelecionar);
      Except
        InterlockedDecrement(intSemaforoSelecionar);
        Raise;
      End;
    End
    Else
      InterlockedDecrement(intSemaforoSelecionar);
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.dbgPedidosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If stlBarDocLocalizar.Count = 0 Then
    Exit;

  If CharInSet(Key, ['0'..'9']) Then
    strBarDocLocalizar := strBarDocLocalizar + Key;
end;

procedure TfrmFatExpedicao.dbgPedidosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_DOWN) Or (Key = VK_UP) Then
  Begin
    pTotalizadoresLinhasSelecionadas;
    pTotalizaValoresPedidosSelecionados;
  End;
end;

procedure TfrmFatExpedicao.dbgPedidosTitleClick(Column: TColumn);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If Assigned(cdsPedidos) And (cdsPedidos.Active) And (Column <> Nil) Then
    cdsPedidos.IndexFieldNames := Column.FieldName;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnLegendaClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not btnLegenda.Visible Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pShowLegenda(Self, TSituacaoPedidoVenda.fRetornaLegenda);
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnLimparBuscaClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  intQtdPro := 0;
  FiltroOnda := fosNaoUtilizarOnda;
  blnPDExclusivamenteDeKits := False;
  strNumeroOnda := '';
  blnSolicitaTelaDeVolume := False;
  intQtdPedOnda := 0;
  blnSelPedOndaAut := False;
  blnOndaSeparacaoUnicoProduto   := False;
  blnOndaSeparacaoVariosProdutos := False;
  blnOndaSeparacaoPorPeso        := False;
  blnSemSeqSep := False;

  SetLength(arrVendedor, 0);
  SetLength(arrCliente, 0);
  SetLength(arrTransportadora, 0);
  SetLength(arrOperador, 0);
  SetLength(arrLocArm, 0);
  SetLength(arrRegiao, 0);
  SetLength(arrCidade, 0);
  SetLength(arrTpoAte, 0);
  SetLength(arrDepVen, 0);
  SetLength(arrEmp, 0);
  SetLength(arrSeqRot, 0);

  strDtaIni := '';
  strDtaFin := '';
  tipTipoData := tfeVazio;
  strNumPed := '';
  strEspDoc := '';
  strSepImp := '';
  strBarDoc := '';
  strBarCom := '';
  stlSeqFgo.Clear;
  tipOrigem := oriTodas;
  strBuscaSeqSep := '';
  strBuscaSeqOnd := '';
  strCodIte := '';
  strDtaRot := '';
  strNumLotSep := '';
  strCodEmpLot := '';
  strDocsLotSep:= '';
  strUrgente := 'T';
  strFatTot := 'T';
  blnMarcPedLot := False;
  strNumRom := '';
  strCodEmpRom := '';

  pCarregaSugestaoDadosFiltroVendedor;

  blnSomenteCliFil := False;

  If cdsFilEst.Active Then
    cdsFilEst.EmptyDataSet;

  pFiltrosEstoqueDefault;

  pFiltrarPedidos;
  pCalculaResumoTotalDocumentos();

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnMensagemExpedicaoClick(Sender: TObject);
var
  frmFatMensagemExpedicao : TfrmFatMensagemExpedicao;
begin
  if not btnMensagemExpedicao.Visible then
    Exit;

  pCriarFormularios(TfrmFatMensagemExpedicao, frmFatMensagemExpedicao);
  Try
    frmFatMensagemExpedicao.CdsExpedicao := CdsPedidos;
    frmFatMensagemExpedicao.ShowModal;
  Finally
    pFreeAndNil(frmFatMensagemExpedicao);
  End;
end;

procedure TfrmFatExpedicao.btnMulSepClick(Sender: TObject);
var
  frmfatLotePedRom: TfrmFatLotePedRom;
begin
  inherited;

  if not btnMulSep.Visible then
    exit;

  pCriarFormularios(TfrmFatLotePedRom, frmfatLotePedRom);

  try
    pDisableControlsInterna;
    frmfatLotePedRom.blnUtilizaImpressaoSeparacao := fUtilizaImpressaoSeparacao();
    frmfatLotePedRom.blnExpedicao := True;
    if frmfatLotePedRom.ShowModal = mrOk then
    begin
    end;
  finally
    pAtualizarGrid;
    pEnableControlsInterna;
    pFreeAndNil(frmfatLotePedRom);
  end;
end;

procedure TfrmFatExpedicao.btnOpeDesClick(Sender: TObject);
  Var
    strCodOpe : String;
    qryUpdate : TUniQuery;
    intContador : Integer;
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If Not btnOpeDes.Visible Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If (Not cdsPedidos.Active) Or (cdsPedidos.IsEmpty) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if (dbgPedidos.SelectedRows.Count = 0) then
    dbgPedidos.SelectedRows.CurrentRowSelected := True;

  strCodOpe := TfrmDigOperador.fGetCodOperador;
  if Not fEmptyStr( strCodOpe ) Then
  Begin
    Try
      qryUpdate := fCriaQuery;
      With qryUpdate, SQL Do
      Begin
        for intContador := 0 to Pred(dbgPedidos.SelectedRows.Count) do
        begin
          dbgPedidos.DataSource.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);

          Close;
          Clear;
          Add('UPDATE EXTGOR SET FGO_OPEDES = :CODOPE ');
          Add('WHERE FGO_SEQFGO = :AUTINC             ');

          ParamByName('CODOPE').AsString := strCodOpe;
          ParamByName('AUTINC').AsString := cdsPedidos.FieldByName('AUTINC').AsString;

          ExecSQL;

          cdsPedidos.Edit;
          cdsPedidos.FieldByName('OPEDES').AsString := strCodOpe;
          cdsPedidos.Post;
        end;
        pMensagemOK('Operador designado alterado com sucesso!');

      End;
    Finally
      FreeAndNil(qryUpdate);
    End;

  End
  Else
    pMensagemOK('Operador designado não alterado!');

  pHabilitarBotaoFaturarOndaSeparacao;

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnBaixarPedidoNaoEntregueClick(Sender: TObject);
var
  intIndex                                   : Integer;
  BaixarPedOrcNaoEntregue                    : TBaixarPedOrcNaoEntregue;
  blnExecutou                                : Boolean;
  strMSG                                     : String;
  blnOperadorTemDireitoDeAcessoParaLimparSep : Boolean;
  arrPedidosNaoPermitidos                    : TStringArray;
begin
  inherited;
  blnExecutou := False;

  If (Not btnBaixarPedidoNaoEntregue.Visible) Then
    Exit;

  If (cdsPedidos.IsEmpty) Then
    Exit;

  If fSelecionado(dtsPedidos.DataSet) Then
  Begin
    fMensagem('ATENÇÃO!', 'Existe(m) pedido(s) selecionado(s) com a tecla [ENTER]. '+
                          'Retire a seleção para continuar.'+#13#10+
                          'Para selecionar os pedidos utilize [SHIFT+SETA ACIMA], [SHIFT+SETA ABAIXO] '+
                          'ou [CTRL + CLIQUE MOUSE] sobre os registros que deseja baixar.', ['&Ok']);
    Exit;
  End;

  dbgPedidos.SelectedRows.CurrentRowSelected := True;
  If dbgPedidos.SelectedRows.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Selecione pelo menos um documento.', ['&Ok']);
    Exit;
  End;

  BaixarPedOrcNaoEntregue := TBaixarPedOrcNaoEntregue.Create;
  Try
    For intIndex := 0 to Pred(dbgPedidos.SelectedRows.Count) Do
    Begin
      dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intIndex]);

      If (cdsPedidos.FieldByName('ESPDOC').AsString = 'PD') And (fPedidoExpedido(cdsPedidos.FieldByName('AUTINC').AsString)) Then
      Begin
        If Not fVerificaAcessoSistema('CANPDA') Then
        Begin
          SetLength(arrPedidosNaoPermitidos, Length(arrPedidosNaoPermitidos)+1);
          arrPedidosNaoPermitidos[Length(arrPedidosNaoPermitidos)-1] := cdsPedidos.FieldByName('NUMDOC').AsString;
          Continue;
        End
      End;

      If Not fValidaTravaDoc Then
        Exit;

      BaixarPedOrcNaoEntregue.AddDocumento(
        cdsPedidos.FieldByName('NUMDOC').AsString,
        cdsPedidos.FieldByName('ESPDOC').AsString,
        cdsPedidos.FieldByName('CODEMP').AsString
      );
    End;

    If (Length(arrPedidosNaoPermitidos) > 0) Then
    Begin
      fMensagem('Atenção!', 'Os pedidos a seguir foram expedidos, para efetuar a baixa é '+
                'necessário cancelar a expedição:' + sLineBreak +
                '('+fArrayToString(arrPedidosNaoPermitidos, ', ', True)+').', ['&Ok']);

      If (Length(arrPedidosNaoPermitidos) = dbgPedidos.SelectedRows.Count) Then
      Begin
        Exit;
      End;
    End;

    Try
      blnExecutou := BaixarPedOrcNaoEntregue.Executar;
    Except
      On E: EValidaPedidoPossuiItensEmSeparacao Do
      Begin
        blnOperadorTemDireitoDeAcessoParaLimparSep := (fVerificaAcessoSistema('PRODLIMSEP')) And (Not fCfgSis('UTICRM', varBoolean));

        If Not blnOperadorTemDireitoDeAcessoParaLimparSep Then
          fMensagem('ATENÇÃO!', E.Message, ['&Ok'])
        Else
        Begin
          strMSG := E.Message;
          strMSG := IIF(Not strMSG.IsEmpty, strMSG, 'Foi identificado pedido(s) com separação em andamento');

          If (fMensagem('ATENÇÃO', strMSG  +
                        '.' + #13 + #13 + 'Deseja Limpar a Separação e Realizar a Baixa do(s) Pedido(s)?', ['&Sim', '&Não'], 2) = 1) Then
          Begin
            If BaixarPedOrcNaoEntregue.ValidouRestricoesLimparSeparacao Then
            Begin
              BaixarPedOrcNaoEntregue.LimparSeparacao := True;
              BaixarPedOrcNaoEntregue.ReprocessarValidacoes;
              blnExecutou := BaixarPedOrcNaoEntregue.Executar;
            End;
          End;
        End;
      End;
    End;

    If (blnExecutou) Then
      pAtualizarGrid;
  Finally
    FreeAndNil(BaixarPedOrcNaoEntregue);
  End;
end;

procedure TfrmFatExpedicao.btnAltEmpFatClick(Sender: TObject);
begin
  inherited;
  If Not btnAltEmpFat.Visible Then
    Exit;

  If Not fPermiteSelecionarPedidoAtual(True) Then
    Exit;

  If TFatAlterarEmpresaFaturamentoPedido.New(
       fField('NUMDOC').AsString,
       fField('ESPDOC').AsString,
       fField('CODEMP').AsString
     ).fAlterarEmpresaFaturamentoPedido(StrToIntDef(fField('SEPIMP').AsString, 0)) Then
  Begin
    pMensagemOk('Empresa de Faturamento do pedido foi alterada com sucesso!');
    btnRecarrPed.Click;
  End;

end;

procedure TfrmFatExpedicao.btnAlterarDataEntregaClick(Sender: TObject);
var
  frmAlteraDataDocumento: TfrmAlteraDataDocumento;
  qryUpdate: TUniQuery;
  qryItens: TUniQuery;
  Autoincrem: String;
begin
  inherited;
  pCriarFormularios(TfrmAlteraDataDocumento, frmAlteraDataDocumento);
  try
    frmAlteraDataDocumento.edtNumDoc.Text := fField('NUMDOC').AsString;
    frmAlteraDataDocumento.edtEspDoc.Text := fField('ESPDOC').AsString;
    frmAlteraDataDocumento.edtCodEmp.Text := fField('CODEMP').AsString;
    frmAlteraDataDocumento.edtDesEmp.Text := fRetNomeEmpresaSelec(fField('CODEMP').AsString);
    frmAlteraDataDocumento.edtCodCli.Text := fField('CODCLI').AsString;
    frmAlteraDataDocumento.edtNomCli.Text := fRetNomCliente(fField('CODCLI').AsString);
    frmAlteraDataDocumento.mskDtaEntFut.Text := fField('DTENTR').AsString;
    if frmAlteraDataDocumento.ShowModal = MrOk then
    begin
      if (fMensagem('', 'Deseja realmente alterar a data da ' +
                        'entrega dos itens do pedido ' + fField('NUMDOC').AsString +
                        '-' + fField('ESPDOC').AsString + '-' + fField('CODEMP').AsString + '?',
          ['&Sim', '&Não'], 2) = 1) then
      begin
        qryItens := fCriaQuery;
        qryUpdate := fCriaQuery;
        try
          qryItens.SQL.Add('SELECT FD.AUTOINCREM');
          qryItens.SQL.Add('FROM FATDOR FD ');
          qryItens.SQL.Add('INNER JOIN FATGOR FG ON FD.FDO_SEQGER = FG.AUTOINCREM');
          qryItens.SQL.Add('INNER JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO');
          qryItens.SQL.Add('WHERE FG.FGO_NUMDOC = :NUMDOC');
          qryItens.SQL.Add('  AND FG.FGO_ESPDOC = :ESPDOC');
          qryItens.SQL.Add('  AND FG.FGO_CODEMP = :CODEMP');
          qryItens.SQL.Add('  AND ED.FDO_ENTRET = "E"');
          qryItens.SQL.Add('  AND FD.FDO_ENTFUT = "N"');
          qryItens.SQL.Add('  AND FD.FDO_JAFATU = 0');

          qryItens.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
          qryItens.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
          qryItens.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
          qryItens.Open;
          Autoincrem := '';
          while not qryItens.Eof do
          begin
            Autoincrem := Autoincrem + ',' + qryItens.FieldByName('AUTOINCREM').AsString.QuotedString;
            qryItens.Next;
          end;

          if Autoincrem = '' then
            Exit;

          Delete(Autoincrem,1,1);

          qryItens.Close;

          qryUpdate.SQL.Add('UPDATE EXTDOR');
          qryUpdate.SQL.Add('SET FDO_DTENTR = :DTENTR');
          qryUpdate.SQL.Add('WHERE FDO_SEQFDO in (' + Autoincrem + ')');
          qryUpdate.ParamByName('DTENTR').AsDateTime := StrToDateTime(frmAlteraDataDocumento.mskDtaEntFut.Text);
          qryUpdate.ExecSQL;

          qryUpdate.SQL.Clear;
          qryUpdate.SQL.ADD('UPDATE FATGOR SET ');
          qryUpdate.SQL.ADD('  FGO_DTENTR = :DTENTR');
          qryUpdate.SQL.ADD('WHERE FGO_NUMDOC = :NUMDOC');
          qryUpdate.SQL.ADD('  AND FGO_ESPDOC = :ESPDOC');
          qryUpdate.SQL.ADD('  AND FGO_CODEMP = :CODEMP');
          qryUpdate.ParamByName('DTENTR').Value := StrToDateTime(frmAlteraDataDocumento.mskDtaEntFut.Text);
          qryUpdate.ParamByName('NUMDOC').Value := fField('NUMDOC').AsString;
          qryUpdate.ParamByName('ESPDOC').Value := fField('ESPDOC').AsString;
          qryUpdate.ParamByName('CODEMP').Value := fField('CODEMP').AsString;
          qryUpdate.ExecSQL;

          TFrmGravando.fExecutarModalA( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');
          pMensagemOK('Data da entrega atualizada com sucesso!');
        finally
          FreeAndNil(qryItens);
          FreeAndNil(qryUpdate);
        end;
      end;
    end;
  finally
    pFreeAndNil(frmAlteraDataDocumento);
  end;
end;

procedure TfrmFatExpedicao.btnAltLotImpSepClick(Sender: TObject);
begin
  inherited;

  if not btnAltLotImpSep.Visible then
    Exit;

  if fAjustaDadosParaImpressaoDeSeparacao(True) then
    pMensagemOK('Lote(s) atualizado(s) com sucesso!');
end;

procedure TfrmFatExpedicao.btnAltSitPedClick(Sender: TObject);
var
  strMansagem: String;
  objPedido: TPedidoVenda;
  dtaEmissao: TDate;
  strCodVen: String;
  blnFaturaTotal: Boolean;
begin
  inherited;

  If (stlPedidos.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar um pedido.', ['&Ok']);
    Exit;
  End;

  If (stlPedidos.Count > 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'Somente um pedido deve ser alterado por vez.', ['&Ok']);
    Exit;
  End;

  objPedido := TPedidoVenda(stlPedidos.Objects[0]);

  dtaEmissao := fCampoTabela('FGO_DTAENT','FATGOR',['AUTOINCREM'],[fField('AUTINC').AsString],False);
  strCodVen := fCampoTabela('FGO_CODVEN','FATGOR',['AUTOINCREM'],[fField('AUTINC').AsString],False);

  If fCampoTabela('FGO_FATTOT','EXTGOR',['FGO_SEQFGO'],[fField('AUTINC').AsString]) = 'S' Then
  Begin
    strMansagem := 'ALTERAÇÃO DA SITUAÇÃO DO PEDIDO DE VENDA DE EXPEDIÇÃO TOTAL PARA EXPEDIÇÃO PARCIAL';
    blnFaturaTotal := False;
  End
  Else
  Begin
    strMansagem := 'ALTERAÇÃO DA SITUAÇÃO DO PEDIDO DE VENDA DE EXPEDIÇÃO PARCIAL PARA EXPEDIÇÃO TOTAL';
    blnFaturaTotal := True;
  End;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto(strMansagem);
  objLiberacao.objMsgLibera.pAddTexto('');
  objLiberacao.objMsgLibera.pAddTexto('Pedido    : '+ objPedido.strNumDoc +'-'+ objPedido.strEspDoc + '-' + objPedido.strCodEmp);
  objLiberacao.objMsgLibera.pAddTexto('Cliente   : ' + objPedido.strCodCli + ' - ' + fRetNomCliente(objPedido.strCodCli));
  objLiberacao.objMsgLibera.pAddTexto('Dt.Emissão: ' + formatDateTime('DD/MM/YYYY', dtaEmissao));
  objLiberacao.objMsgLibera.pAddTexto('Vendedor  : ' + strCodVen + ' - ' + fRetNomeOperador(strCodVen));

  objLiberacao.strDirAce := 'ALTPEDTOTPARC';
  objLiberacao.strMsgSen := 'Alterar situação do pedido';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  If objLiberacao.fLibera Then
  Begin
    pAlteraSituacaoFaturamentoTotalPedido(fField('AUTINC').AsString, blnFaturaTotal);
    pAtualizarGrid;
    fMensagem('', 'Pedido alterado com sucesso.', ['&Ok']);
  End;
end;

procedure TfrmFatExpedicao.btnBuscaNFe_EstoqueClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If (fExibirFiltroPorEstoque) Then
  Begin
    pCriarFormularios(TfrmFatExpedicaoBuscaEstoque, frmFatExpedicaoBuscaEstoque);
    Try
      cdsPedidos.DisableControls;
      frmFatExpedicaoBuscaEstoque.DataSetPedidos := cdsPedidos;
      frmFatExpedicaoBuscaEstoque.blnExiPedRetiraExpAntFat := objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat;
      frmFatExpedicaoBuscaEstoque.stlSeqFgo := stlSeqFgo;
      frmFatExpedicaoBuscaEstoque.rdgEstoque.ItemIndex := intBusEstSal;
      frmFatExpedicaoBuscaEstoque.ShowModal;

      With frmFatExpedicaoBuscaEstoque Do
      Begin
        If (ModalResult = mrOK) Then
        Begin
          intBusEstSal := rdgEstoque.ItemIndex;

          If cdsFilEst.Active Then
            cdsFilEst.EmptyDataSet;

          If (rdgEstoque.ItemIndex In [0, 1]) Then
          Begin
            TFrmGravando.fExecutarModal(pProcessarSaldoEstoque, 'Aguarde... Processando Documentos!', '');

            If (Not cdsItens.IsEmpty) Then
              pCloneDataSet(cdsFilEst, cdsItens)
            Else
              stlSeqFgo.Add('99999999999999999999');
          End
          Else
          Begin
            stlSeqFgo.Clear;
          End;

          pFiltrarPedidos;
          pCalculaResumoTotalDocumentos();
        End;
        pSetFocus(dbgPedidos);
      End;

    Finally
      pFreeAndNil(frmFatExpedicaoBuscaEstoque);
      cdsPedidos.EnableControls;
    End;
  End
  Else
  Begin
    pCriarFormularios(TfrmExpBuscaChaveNFe, frmExpBuscaChaveNFe);
    Try
      frmExpBuscaChaveNFe.ShowModal;

      With frmExpBuscaChaveNFe Do
      Begin
         If (ModalResult = mrOK) Then
         Begin
           If Not cdsPedidos.Locate('NUMDOC;ESPDOC;CODEMP;CODCLI',
              varArrayOf([strNumDocChv, strEspDocChv, strCodEmpChv, strCodCliChv]), []) Then
           Begin
              fMensagem('ATENÇÃO!', 'Documento ' + strNumDocChv+'-'+strEspDocChv+'-'+strCodEmpChv +
                                    ' encontrado nos registros do Livro Fiscal mas não disponível'+
                                    ' na tela de expedição.'+#13+'Verifique os filtros utilizados!', ['&Ok']);
           End;
         End;
         pSetFocus(dbgPedidos);
      End;

    Finally
      pFreeAndNil(frmExpBuscaChaveNFe);
    End;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnBuscarClick(Sender: TObject);
  Var
    Key: Word;
    blnExibirMensagem: Boolean;

  function fUsaOndaEModuloDeImpressaoEBaixaSepEEstaLiberandoSepOndaParaExp : Boolean;
  begin

    Result := False;

    If Not fOndaSeparacao Then
      Exit;

    If Not blnApenasImprimirBaixarSeparacao Then
      Exit;

    If Not (FiltroOnda = fosFaturamentoLiberacaoOnda) Then
      Exit;

    Result := True;

  end;

begin
  inherited;

  Try
    pAtivaDesativaTimersNotificaoAndRecarga(False);
    pCriarFormularios(TfrmFatExpedicaoBusca, frmFatExpedicaoBusca);
    frmFatExpedicaoBusca.arrVendedor := arrVendedor;
    frmFatExpedicaoBusca.edtCodVen.Enabled := not blnTravarFiltroVendedor;
    frmFatExpedicaoBusca.arrDepVen   := arrDepVen;

    frmFatExpedicaoBusca.mskDtaIni.Text := strDtaIni;
    frmFatExpedicaoBusca.mskDtaFin.Text := strDtaFin;
    frmFatExpedicaoBusca.mskDtaRot.Text := strDtaRot;
    frmFatExpedicaoBusca.arrRotas := arrSeqRot;

    frmFatExpedicaoBusca.rdgDatas.Items.Clear;
    frmFatExpedicaoBusca.rdgDatas.Items.Add('(DATA DE ENTRADA)');
    frmFatExpedicaoBusca.rdgDatas.Items.Add('(DATA DE PREVISÃO)');
    frmFatExpedicaoBusca.rdgDatas.Items.Add('(DATA DE ENTREGA)');
    frmFatExpedicaoBusca.rdgDatas.Columns := 3;

    If (tipOrigem = oriBalcao) Then
      frmFatExpedicaoBusca.cmbOrigem.ItemIndex := 1
    Else If (tipOrigem = oriPocket) Then
      frmFatExpedicaoBusca.cmbOrigem.ItemIndex := 2
    Else If (tipOrigem = oriSite) Then
      frmFatExpedicaoBusca.cmbOrigem.ItemIndex := 3
    Else
      frmFatExpedicaoBusca.cmbOrigem.ItemIndex := 0;

    If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
    Begin
      If strEntRet = 'R' Then
        frmFatExpedicaoBusca.cmbEntRet.ItemIndex := 0
      Else
      If strEntRet = 'E' Then
        frmFatExpedicaoBusca.cmbEntRet.ItemIndex := 1
      Else
        frmFatExpedicaoBusca.cmbEntRet.ItemIndex := 2;
    End;

    frmFatExpedicaoBusca.rdgDatas.ItemIndex := 0;

    Case tipTipoData Of
      tfeEntrada: frmFatExpedicaoBusca.rdgDatas.ItemIndex := 0;
      tfePrevisao: frmFatExpedicaoBusca.rdgDatas.ItemIndex := 1;
      tfeEntrega: frmFatExpedicaoBusca.rdgDatas.ItemIndex := 2;
    End;

    strNumLotSep := '';
    strCodEmpLot := '';
    strDocsLotSep:= '';
    blnMarcPedLot := False;
    strNumRom := '';
    strCodEmpRom := '';
    frmFatExpedicaoBusca.edtNumPed.Text  := strNumPed;

    If FApenasGeracaoDeRemessaDePedido Then
    Begin
      frmFatExpedicaoBusca.FiltroOnda := fosSelecaoPedidosGeracaoOnda;
      frmFatExpedicaoBusca.rdgOndaSeparacao.Enabled := False;
    End Else
      frmFatExpedicaoBusca.FiltroOnda := FiltroOnda;

    frmFatExpedicaoBusca.blnPDExclusivamenteDeKits := blnPDExclusivamenteDeKits;
    frmFatExpedicaoBusca.strNumeroOnda   := strNumeroOnda;
    frmFatExpedicaoBusca.blnSolicitaTelaDeVolume := blnSolicitaTelaDeVolume;
    frmFatExpedicaoBusca.intQtdPedOnda   := intQtdPedOnda;
    frmFatExpedicaoBusca.intQtdProOndaDe := intQtdProOndaDe;
    frmFatExpedicaoBusca.intQtdProOnda   := intQtdProOnda;
    frmFatExpedicaoBusca.intQtdPro       := intQtdPro;
    frmFatExpedicaoBusca.fltPesoOndaDe   := fltPesoOndaDe;
    frmFatExpedicaoBusca.fltPesoOndaAte  := fltPesoOndaAte;
    frmFatExpedicaoBusca.blnSelPedOndaAut:= blnSelPedOndaAut;
    frmFatExpedicaoBusca.blnOndaSeparacaoUnicoProduto   := blnOndaSeparacaoUnicoProduto;
    frmFatExpedicaoBusca.blnOndaSeparacaoVariosProdutos := blnOndaSeparacaoVariosProdutos;
    frmFatExpedicaoBusca.blnOndaSeparacaoPorPeso        := blnOndaSeparacaoPorPeso;
    frmFatExpedicaoBusca.blnSemSeqSep    := blnSemSeqSep;
    frmFatExpedicaoBusca.blnApenasImprimirBaixarSeparacao := Self.blnApenasImprimirBaixarSeparacao;

    frmFatExpedicaoBusca.arrClientes     := arrCliente;
    frmFatExpedicaoBusca.arrEmp          := arrEmp;
    frmFatExpedicaoBusca.arrTransportadoras := arrTransportadora;
    frmFatExpedicaoBusca.edtEspecie.Text := strEspDoc;
    frmFatExpedicaoBusca.edtSepImp.Text  := strSepImp;
    frmFatExpedicaoBusca.arrLocArm       := arrLocArm;
    frmFatExpedicaoBusca.arrRegiao       := arrRegiao;
    frmFatExpedicaoBusca.arrCidade       := arrCidade;
    frmFatExpedicaoBusca.arrTpoAte       := arrTpoAte;
    frmFatExpedicaoBusca.arrOperador     := arrOperador;
    frmFatExpedicaoBusca.edtCodIte.Text  := strCodIte;
    frmFatExpedicaoBusca.edtSeqSep.Text  := strBuscaSeqSep;
    frmFatExpedicaoBusca.edtSeqOnd.Text  := strBuscaSeqOnd;
    frmFatExpedicaoBusca.edtUrgente.Text := strUrgente;
    frmFatExpedicaoBusca.edtFatTot.Text  := strFatTot;

    frmFatExpedicaoBusca.edtLocFis.Text  := strLocFis;
    frmFatExpedicaoBusca.edtLocIni.Text  := strLocIni;
    frmFatExpedicaoBusca.edtLocFin.Text  := strLocFin;
    frmFatExpedicaoBusca.edtLocIniSup.Text := strLocIniSup;
    frmFatExpedicaoBusca.edtLocFinSup.Text := strLocFinSup;
    frmFatExpedicaoBusca.edtMsgPed.Text := strMsgPed;

    frmFatExpedicaoBusca.edtCodEmp.Visible := MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]);
    frmFatExpedicaoBusca.edtNomEmp.Visible := MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]);
    frmFatExpedicaoBusca.lblEmp.Visible    := MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]);

    frmFatExpedicaoBusca.lblPedido.Caption  := IfThen(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA, 'Documento:', 'Pedido:');
    frmFatExpedicaoBusca.chkOndaSeparacaoApenasFaturadorAutomatico.Checked := blnOndaSeparacaoApenasPedidoFaturadorAutomatico;

    If (frmFatExpedicaoBusca.ShowModal = mrOk) Then
    Begin
      rdgFiltroPeriodo.Enabled := frmFatExpedicaoBusca.blnHabilitaFiltroPeriodo;
      If (not rdgFiltroPeriodo.Enabled) Then
        rdgFiltroPeriodo.ItemIndex := 0;

      If frmFatExpedicaoBusca.pnlLoteSep.Visible And
         (not fEmptyStr(frmFatExpedicaoBusca.edtNumLot.Text)) Then
      Begin
        strNumLotSep := frmFatExpedicaoBusca.edtNumLot.Text;
        strCodEmpLot := frmFatExpedicaoBusca.edtCodEmpLote.Text;

        If (frmFatExpedicaoBusca.ckbSelPedAut.Visible) Then
          blnMarcPedLot := frmFatExpedicaoBusca.ckbSelPedAut.Checked
        Else
          blnMarcPedLot := False;
      End
      Else
      Begin
        strNumLotSep := '';
        strCodEmpLot := '';
        blnMarcPedLot := False;
      End;

      If (frmFatExpedicaoBusca.pnlLoteSep.Visible) And (Not fEmptyStr(frmFatExpedicaoBusca.edtNumRom.Text)) Then
      Begin
        strNumRom := frmFatExpedicaoBusca.edtNumRom.Text;
        strCodEmpRom := frmFatExpedicaoBusca.edtCodEmpRom.Text;
      End
      Else If (frmFatExpedicaoBusca.pnlNumRom.Visible) And (Not fEmptyStr(frmFatExpedicaoBusca.edtRomaneio.Text)) Then
      Begin
        strNumRom := frmFatExpedicaoBusca.edtRomaneio.Text;
        strCodEmpRom := Vs_strCodEmp;
      End;

      arrVendedor := frmFatExpedicaoBusca.arrVendedor;
      arrDepVen   := frmFatExpedicaoBusca.arrDepVen;

      If (fEmptyStr(fTiraCaracEspeciais(frmFatExpedicaoBusca.mskDtaIni.Text))) Or
         (fEmptyStr(fTiraCaracEspeciais(frmFatExpedicaoBusca.mskDtaFin.Text))) Then
      Begin
        strDtaIni := '';
        strDtaFin := '';
        tipTipoData := tfeVazio;
      End
      Else
      Begin
        strDtaIni := frmFatExpedicaoBusca.mskDtaIni.Text;
        strDtaFin := frmFatExpedicaoBusca.mskDtaFin.Text;

        tipTipoData := tfeVazio;
        Case frmFatExpedicaoBusca.rdgDatas.ItemIndex Of
          0: tipTipoData := tfeEntrada;
          1: tipTipoData := tfePrevisao;
          2: tipTipoData := tfeEntrega;
        End;
      End;

      strDtaRot := '';
      SetLength(arrSeqRot, 0);

      If frmFatExpedicaoBusca.pnlRota.Visible Then
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(frmFatExpedicaoBusca.mskDtaRot.Text))) Then
          strDtaRot := frmFatExpedicaoBusca.mskDtaRot.Text;

        If (Not fEmptyStr(frmFatExpedicaoBusca.edtSeqRot.Text)) Then
          arrSeqRot := frmFatExpedicaoBusca.arrRotas;
      End;

      arrEmp      := frmFatExpedicaoBusca.arrEmp;
      strNumPed   := frmFatExpedicaoBusca.edtNumPed.Text;
      arrCliente  := frmFatExpedicaoBusca.arrClientes;
      arrTransportadora := frmFatExpedicaoBusca.arrTransportadoras;
      strEspDoc   := frmFatExpedicaoBusca.edtEspecie.Text;
      strSepImp   := frmFatExpedicaoBusca.edtSepImp.Text;
      arrLocArm   := frmFatExpedicaoBusca.arrLocArm;
      arrRegiao   := frmFatExpedicaoBusca.arrRegiao;
      arrCidade   := frmFatExpedicaoBusca.arrCidade;
      strBarDoc   := frmFatExpedicaoBusca.edtBarDoc.Text;
      strBarCom   := frmFatExpedicaoBusca.edtBarCom.Text;
      arrTpoAte   := frmFatExpedicaoBusca.arrTpoAte;
      arrOperador := frmFatExpedicaoBusca.arrOperador;
      strCodIte   := frmFatExpedicaoBusca.edtCodIte.Text;

      strLocFis    := frmFatExpedicaoBusca.edtLocFis.Text;
      strLocIni    := frmFatExpedicaoBusca.edtLocIni.Text;
      strLocFin    := frmFatExpedicaoBusca.edtLocFin.Text;
      strLocIniSup := frmFatExpedicaoBusca.edtLocIniSup.Text;
      strLocFinSup := frmFatExpedicaoBusca.edtLocFinSup.Text;

      strMsgPed := frmFatExpedicaoBusca.edtMsgPed.Text;

      FiltroOnda       := frmFatExpedicaoBusca.FiltroOnda;
      blnPDExclusivamenteDeKits := frmFatExpedicaoBusca.blnPDExclusivamenteDeKits;
      strNumeroOnda    := frmFatExpedicaoBusca.strNumeroOnda;
      blnSolicitaTelaDeVolume := frmFatExpedicaoBusca.blnSolicitaTelaDeVolume;
      intQtdPedOnda    := frmFatExpedicaoBusca.intQtdPedOnda;
      intQtdProOndaDe  := frmFatExpedicaoBusca.intQtdProOndaDe;
      intQtdProOnda    := frmFatExpedicaoBusca.intQtdProOnda;
      intQtdPro        := frmFatExpedicaoBusca.intQtdPro;
      fltPesoOndaDe    := frmFatExpedicaoBusca.fltPesoOndaDe;
      fltPesoOndaAte   := frmFatExpedicaoBusca.fltPesoOndaAte;
      blnSelPedOndaAut := frmFatExpedicaoBusca.blnSelPedOndaAut;
      blnOndaSeparacaoUnicoProduto   := frmFatExpedicaoBusca.blnOndaSeparacaoUnicoProduto;
      blnOndaSeparacaoVariosProdutos := frmFatExpedicaoBusca.blnOndaSeparacaoVariosProdutos;
      blnOndaSeparacaoPorPeso        := frmFatExpedicaoBusca.blnOndaSeparacaoPorPeso;
      blnSemSeqSep     := frmFatExpedicaoBusca.blnSemSeqSep;

      strUrgente       := frmFatExpedicaoBusca.edtUrgente.Text;
      strFatTot        := frmFatExpedicaoBusca.edtFatTot.Text;

      If frmFatExpedicaoBusca.pnlSeqSep.Visible Then
        strBuscaSeqSep := frmFatExpedicaoBusca.edtSeqSep.Text;

      If frmFatExpedicaoBusca.edtSeqOnd.Visible Then
        strBuscaSeqOnd := frmFatExpedicaoBusca.edtSeqOnd.Text;

      If (frmFatExpedicaoBusca.cmbOrigem.ItemIndex = 1) Then
        tipOrigem := oriBalcao
      Else If (frmFatExpedicaoBusca.cmbOrigem.ItemIndex = 2) Then
        tipOrigem := oriPocket
      Else If (frmFatExpedicaoBusca.cmbOrigem.ItemIndex = 3) Then
        tipOrigem := oriSite
      Else
        tipOrigem := oriTodas;

      If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
        strEntRet := frmFatExpedicaoBusca.strEntRet
      Else
        strEntRet := 'T';

      If strFiltroLocFisAnterior <> fSQLFiltroLocalizacaoFisica Then
      Begin
        strFiltroLocFisAnterior := fSQLFiltroLocalizacaoFisica;
        btnRecarrPed.Click;
      End;

      blnSomenteCliFil := frmFatExpedicaoBusca.chkSomenteCliFil.Checked;
      blnOndaSeparacaoApenasPedidoFaturadorAutomatico := frmFatExpedicaoBusca.chkOndaSeparacaoApenasFaturadorAutomatico.Checked;

      pFiltrarPedidos;
      pCalculaResumoTotalDocumentos();

      If Not blnSelPedOndaAut Then
        blnSelPedOndaAut := fUsaOndaEModuloDeImpressaoEBaixaSepEEstaLiberandoSepOndaParaExp;

      pSelecionarPedidosOndaAutomaticamente;
      pLimparVariaveisSeparadorConferenteOndaSeparacao;

      If (fUsaOndaEModuloDeImpressaoEBaixaSepEEstaLiberandoSepOndaParaExp) Then
        pBaixarSeparacaoPedido;

      if blnMarcPedLot then
      begin
        blnExibirMensagem := VS_ExibirMensagemAoUsuario;
        try
          VS_ExibirMensagemAoUsuario := False;
          TFrmGravando.fExecutarModal( pMarcaPedidosLotes, 'Aguarde... Selecionando pedidos do lote!', '');
        finally
          VS_ExibirMensagemAoUsuario := blnExibirMensagem;
        end;
      end;

      If (Not fEmptyStr(strBarDoc)) Then
      Begin
        If (Not cdsPedidos.IsEmpty) Then
        Begin
          blnF3 := True;
          Key := VK_RETURN;
          dbgPedidosKeyDown(dbgPedidos, Key, []);

          If btnConfirma.Visible And btnConfirma.Enabled Then
            btnConfirma.Click;

          blnF3 := False;
          cdsPedidos.Filter := '';
          cdsPedidos.Filtered := False;
          pLimparSelecaoTotalmente;
          TFrmGravando.fExecutarModal( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');

        End
        Else
          fMensagem('', 'Registro não encontrado!', ['&OK']);
      End;

      pAtualizarRegistrosCanceladosPeloHUB;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatExpedicao.btnBuscarClick]');
      pAtivaDesativaTimersNotificaoAndRecarga(True);
    End;
  End;

  pFreeAndNil(frmFatExpedicaoBusca);

  pHabilitarBotaoFaturarOndaSeparacao;
  pHabilitarBotaoFaturarTodos;

  pSetFocus(dbgPedidos);
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.pOnFilterRecord(DataSet: TDataSet; var Accept: Boolean);

var
  intPercorre : Integer;

  function fElementsToString(arrElements: TConsultasArray): String;
    Var
      i: Integer;
  begin
    Result := '';

    For i := 0 To Length(arrElements) - 1 Do Begin
      Result := Result + arrElements[i].strCodigo + '_';
    End;
  end;
begin
  Accept := True;

  If (Assigned(stlSeqFgo)) And (stlSeqFgo.Count > 0) Then
    Accept := (stlSeqFgo.IndexOf(DataSet.FieldByName('AUTINC').AsString) >= 0);

  If (Accept) And (grbLocSep.Visible) And (cmbLocSep.ItemIndex > 0) Then
  Begin
    Accept := (Pos(fGetCodigoLocSep(), DataSet.FieldByName('CODLSE').AsString) > 0);
    If Accept And blnApenasImprimirBaixarSeparacao Then
      Accept := (Pos(fGetCodigoLocSep(), DataSet.FieldByName('LSELIB').AsString) <= 0);
  End;

  If (Accept) And (not fEmptyStr(strDocsLotSep)) Then
    Accept := (Pos(DataSet.FieldByName('DOCUME').AsString, strDocsLotSep) > 0);

  If (Accept) And (Length(arrVendedor) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODVEN').AsString, fElementsToString(arrVendedor)) > 0);

  If (Accept) And (Length(arrCliente) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODCLI').AsString, fElementsToString(arrCliente)) > 0);

  If (Accept) And (Length(arrTransportadora) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODTRA').AsString, fElementsToString(arrTransportadora)) > 0);

  If (Accept) And (Length(arrOperador) > 0) Then
    Accept := (Pos(DataSet.FieldByName('OPEDES').AsString, fElementsToString(arrOperador)) > 0);

  If (Accept) And (Length(arrLocArm) > 0) Then
  Begin
    For intPercorre := Low(arrLocArm) To High(arrLocArm) Do
    Begin
      Accept := (Pos(arrLocArm[intPercorre].strCodigo, DataSet.FieldByName('CODLAR').AsString) > 0);
      If Accept Then
        Break;
    End;
  End;

  If (Accept) And (Length(arrSeqRot) > 0) Then
    Accept := (Pos(DataSet.FieldByName('SEQROT').AsString, fElementsToString(arrSeqRot)) > 0);

  If (Accept) And (Length(arrRegiao) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODREG').AsString, fElementsToString(arrRegiao)) > 0);

  If (Accept) And (Length(arrCidade) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODCID_BUSCA').AsString, fElementsToString(arrCidade)) > 0);

  If (Accept) And (Length(arrTpoAte) > 0) Then
    Accept := (Pos(DataSet.FieldByName('CODTPA').AsString, fElementsToString(arrTpoAte)) > 0);

  If (Accept) And (Length(arrDepVen) > 0) Then
    Accept := (Pos(DataSet.FieldByName('DEPVEN').AsString, fElementsToString(arrDepVen)) > 0);

  If (Accept) And (not fEmptyStr(strMsgPed)) Then
    Accept := (Pos(strMsgPed, DataSet.FieldByName('MEN001').AsString +
                              DataSet.FieldByName('MEN002').AsString +
                              DataSet.FieldByName('MEN003').AsString +
                              DataSet.FieldByName('MEN004').AsString +
                              DataSet.FieldByName('MEN005').AsString) > 0);

  if (Accept) and (Length(arrEmp) > 0) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
    Accept := (Pos(DataSet.FieldByName('CODEMP').AsString, fElementsToString(arrEmp)) > 0)
end;

procedure TfrmFatExpedicao.pFiltrarPedidos;

  function E: String;
  begin
    If (fEmptyStr(cdsPedidos.Filter)) Then
      Result := ''
    Else
      Result := ' AND ';
  end;

  function fGetCampoData: String;
  begin
    Result := '';
    Case tipTipoData Of
      tfeEntrada:  Result := 'DTAENT';
      tfePrevisao: Result := 'PREVIS';
      tfeEntrega:  Result := 'DTENTR';
    End;
  End;

  function fFiltraOrigem: String;
  Begin
    Result := '';

    If (tipOrigem = oriBalcao) Then
      Result := Result + ' ORIPED = ' + QuotedStr('B')
    Else If (tipOrigem = oriPocket) Then
      Result := Result + ' ORIPED = ' + QuotedStr('P')
    Else If (tipOrigem = oriSite) Then
      Result := Result + ' ORIPED = ' + QuotedStr('S');

  End;

  function fFiltrarStatusPedido: Boolean;
  var
    i: Integer;
  Begin
    Result := False;

    For i := 0 To Pred(lstStatusPedido.Items.Count) Do
    Begin
      Result := lstStatusPedido.Items[i].Checked;

      If Result Then
        Break;
    End;
  End;

  function fFiltroStatusPedido: String;
  var
    i: Integer;
  Begin
    Result := '';

    For i := 0 To Pred(lstStatusPedido.Items.Count) Do
    Begin
      If lstStatusPedido.Items[i].Checked Then
        Result := Result + IIF(fEmptyStr(Result), '', ', ') + QuotedStr(lstStatusPedido.Items[i].Text);
    End;
  End;

  function fFiltrarLocRet: Boolean;
  var
    i: Integer;
  Begin
    Result := False;

    if (not grbLocRet.Visible) then
      Exit;

    For i := 0 To Pred(lstLocRet.Items.Count) Do
    Begin
      Result := lstLocRet.Items[i].Checked;

      If Result Then
        Break;
    End;
  End;

  function fFiltroLocRet: String;
  var
    i: Integer;
    strSigla: string;
  Begin
    Result := '';

    For i := 0 To Pred(lstLocRet.Items.Count) Do
    Begin
      If lstLocRet.Items[i].Checked Then
      begin
        strSigla := fRetSiglaLocalRetira(AnsiUpperCase(Copy(lstLocRet.Items[i].Text, 8, Length(lstLocRet.Items[i].Text))));

        if fEmptyStr(strSigla) then
          Continue;

        Result := Result + IIF(fEmptyStr(Result), '(', ' OR ') + '(LOCRET = ' + QuotedStr(strSigla) +
          ' OR LOCRET LIKE ' + QuotedStr('%,' + strSigla + '%') +
          ' OR LOCRET LIKE ' + QuotedStr('%' + strSigla + ',%') + ')';
      end;
    End;

    if (not fEmptyStr(Result)) then
      Result := Result + ')';
  End;

begin
  If Not Assigned(cdsPedidos) Then
    Exit;

  cdsPedidos.Filtered := False;
  cdsPedidos.Filter   := '';
  cdsPedidos.OnFilterRecord := pOnFilterRecord;

  {Comanda}
  If not fEmptyStr(strNumLotSep) And not fEmptyStr(strCodEmpLot) Then
    strDocsLotSep := fSelecionaDocumentosLote
  Else
    strDocsLotSep := '';

  If Not fEmptyStr(strBarCom) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'BARCOM = ' + QuotedStr(strBarCom);

  If (Not fEmptyStr(strBarDoc)) Then
  Begin
    If (Length(strBarDoc) = 18) Then
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'BARDOC = ' + QuotedStr( strBarDoc )
    Else
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'BARDOC = ' + QuotedStr( Copy(strBarDoc,1,12) ); // Pesquisa sem o digito verificador
  End;

  If (Not fEmptyStr(strDtaIni)) And (Not fEmptyStr(strDtaFin)) And (Not fEmptyStr(fGetCampoData)) Then
  Begin
    cdsPedidos.Filter := cdsPedidos.Filter + E + '(' + fGetCampoData + ' >= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(strDtaIni))) + ' AND ' +
                                                       fGetCampoData + ' <= ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(strDtaFin))) + ')';
  End;

  If blnOndaSeparacaoUnicoProduto Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'QTDPRO = 1'
  Else

  If (blnOndaSeparacaoVariosProdutos And (intQtdProOndaDe > 0) And (intQtdProOnda > 0)) Then
  Begin
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'QTDPRO >= ' + IntToStr(intQtdProOndaDe);
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'QTDPRO <= ' + IntToStr(intQtdProOnda);
  End

  Else If intQtdPro > 0 Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'QTDPRO = ' + IntToStr(intQtdPro);

  If blnOndaSeparacaoPorPeso And (fltPesoOndaAte > 0) Then
  Begin
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'PESBRU >= ' + FloatToStr(fltPesoOndaDe);
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'PESBRU <= ' + FloatToStr(fltPesoOndaAte);
  End;

  If blnPDExclusivamenteDeKits Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'KIT = ' + QuotedStr('S');

  If (Not fEmptyStr(strNumPed)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'NUMDOC = ' + QuotedStr(strNumPed);

  If (Not fEmptyStr(strEspDoc)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'ESPDOC = ' + QuotedStr(strEspDoc);

  If (Not fEmptyStr(strSepImp)) Then
  Begin
    Case strSepImp[1] Of
      'S': cdsPedidos.Filter := cdsPedidos.Filter + E + '(SEPIMP = ''1'' OR SEPIMP = ''2'' OR SEPIMP = ''3'')';
      'N': cdsPedidos.Filter := cdsPedidos.Filter + E + 'SEPIMP = ''0'' ';
    End;
  End;

  If (Not fEmptyStr(strUrgente)) Then
  Begin
    Case strUrgente[1] Of
      'S': cdsPedidos.Filter := cdsPedidos.Filter + E + 'ENTURG =  ' + QuotedStr('SIM');
      'N': cdsPedidos.Filter := cdsPedidos.Filter + E + 'ENTURG <> ' + QuotedStr('SIM');
    End;
  End;

  If (Not fEmptyStr(strFatTot)) Then
  Begin
    Case strFatTot[1] Of
      'S': cdsPedidos.Filter := cdsPedidos.Filter + E + 'TOTFAT =  ' + QuotedStr('S');
      'N': cdsPedidos.Filter := cdsPedidos.Filter + E + 'TOTFAT =  ' + QuotedStr('N');
    End;
  End;

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And (strEntRet <> 'T') Then Begin
    If (strEntRet = 'R') Then
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'ENTRET = ' + QuotedStr(strEntRet)
    Else
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'ENTRET <> ' + QuotedStr('R');
  End;

  If pnlFilSitFin.Visible Then
  Begin
    Case cmbSitFin.ItemIndex Of
      1: cdsPedidos.Filter := cdsPedidos.Filter + E + 'SITFIN <> ' + QuotedStr('OK');
      2: cdsPedidos.Filter := cdsPedidos.Filter + E + 'SITFIN =  ' + QuotedStr('OK');
    End;
  End;

  If pnlCliLoj.Visible Then
  Begin
    Case cmbCliLoj.ItemIndex Of
      1: cdsPedidos.Filter := cdsPedidos.Filter + E + 'CLILOJ = ' + QuotedStr('Sim');
      2: cdsPedidos.Filter := cdsPedidos.Filter + E + 'CLILOJ <>  ' + QuotedStr('Sim');
    End;
  End;

  Case rdgTipoConferencia.ItemIndex Of
    0: cdsPedidos.Filter := cdsPedidos.Filter + E + 'EXPTOT = '  + QuotedStr('S');
    1: cdsPedidos.Filter := cdsPedidos.Filter + E + 'EXPTOT <> ' + QuotedStr('S');
    2: cdsPedidos.Filter := cdsPedidos.Filter + E + 'TEMEXP = '  + QuotedStr('S') + ' AND EXPTOT = '+ QuotedStr('N');
    3: cdsPedidos.Filter := cdsPedidos.Filter + E + 'TEMEXP = '  + QuotedStr('N') + ' AND EXPTOT = '+ QuotedStr('N');
  End;

  if fFiltrarLocRet() then
  begin
    Case rdgTipoMov.ItemIndex Of
      0: cdsPedidos.Filter := cdsPedidos.Filter + E + '(ENTRET LIKE ' + QuotedStr('%R%') + ') AND ' + fFiltroLocRet();
      2: cdsPedidos.Filter := cdsPedidos.Filter + E + '(NOT ENTRET LIKE ' + QuotedStr('%R%') + ' OR (ENTRET LIKE ' + QuotedStr('%R%') + ' AND ' + fFiltroLocRet() + '))';
      3: cdsPedidos.Filter := cdsPedidos.Filter + E + '((ENTURG =  ' + QuotedStr('SIM')+ ') AND (NOT ENTRET LIKE ' + QuotedStr('%R%') + ' OR (ENTRET LIKE ' + QuotedStr('%R%') + ' AND ' + fFiltroLocRet() + ')))';
    End;
  end
  else
  begin
    Case rdgTipoMov.ItemIndex Of
      0: cdsPedidos.Filter := cdsPedidos.Filter + E + '(ENTRET LIKE ' + QuotedStr('%R%') + ')';
      1: cdsPedidos.Filter := cdsPedidos.Filter + E + '(ENTRET LIKE ' + QuotedStr('%E%') + ')';
      3: cdsPedidos.Filter := cdsPedidos.Filter + E + '(ENTURG =  ' + QuotedStr('SIM')+ ') ';
    End;
  end;

  Case rdgFiltroPeriodo.ItemIndex Of
    1: cdsPedidos.Filter := cdsPedidos.Filter + E + '(DTAENT = ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + ')';
  End;

  If (gpbTipoExpedicao.Visible) Then
  Begin
    If (rdbExpedicaoParcial.Checked) Then
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'PEDPAR =  ' + QuotedStr('P')
    Else If (rdbSemExpedicao.Checked) Then
      cdsPedidos.Filter := cdsPedidos.Filter + E + 'PEDPAR <> ' + QuotedStr('P');
  End;

  If blnSemSeqSep Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + ' (SEQSEP = ' + QuotedStr('') + ' OR SEQSEP IS NULL) '
  Else If (Not fEmptyStr(strNumeroOnda)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'SEQSEP = ' + QuotedStr(strNumeroOnda)
  Else If (Not fEmptyStr(strBuscaSeqSep)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'SEQSEP = ' + QuotedStr(strBuscaSeqSep);

  If (Not fEmptyStr(strBuscaSeqOnd)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'SEQOND = ' + QuotedStr(strBuscaSeqOnd);

  If (Not fEmptyStr(strCodIte)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'CODITENS LIKE ' + QuotedStr('%'+strCodIte+'%');

  If (tipOrigem <> oriTodas) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + fFiltraOrigem;

  If (Not fEmptyStr(strDtaRot)) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'DTAROT = ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(strDtaRot)));

  If (pnlStatusPedido.Visible And fFiltrarStatusPedido()) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'FGO_STATUS IN (' + fFiltroStatusPedido() + ')';

  If (blnSomenteCliFil) Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'CODCLI IN ('+fRetClientesFilial+') ';

  If fCfgSis('CLIDMP') = '2' Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'CRTFIL <> '+ QuotedStr('S');

  If (Not fEmptyStr(strNumRom)) Then
  Begin
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'NUMROM = ' + QuotedStr(strNumRom);
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'EMPROM = ' + QuotedStr(strCodEmpRom);
  End;

  If rdgFiltroDataColeta.Visible Then
  Begin
    Case rdgFiltroDataColeta.ItemIndex Of
      0: cdsPedidos.Filter := cdsPedidos.Filter + E + '((DTCOAG <> NULL AND DTCOAG < ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + ')'
                                                + ' OR  (DTCOAG = NULL AND DTLIEN <> NULL AND DTLIEN < ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + '))';
      1: cdsPedidos.Filter := cdsPedidos.Filter + E + '((DTCOAG <> NULL AND DTCOAG = ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + ')'
                                                + ' OR  (DTCOAG = NULL AND DTLIEN <> NULL AND DTLIEN = ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + '))';
      2: cdsPedidos.Filter := cdsPedidos.Filter + E + '(DTCOAG  =  NULL AND DTLIEN > ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + ')';
      3: cdsPedidos.Filter := cdsPedidos.Filter + E + '(DTCOAG  <> NULL AND DTCOAG > ' + QuotedStr(FormatDateTime('yyyy-MM-dd', Date)) + ')';
    End;
  End;

  If blnOndaSeparacaoApenasPedidoFaturadorAutomatico Then
    cdsPedidos.Filter := cdsPedidos.Filter + E + 'FATAUT = '+QuotedStr('S');

  cdsPedidos.Filtered := False;
  cdsPedidos.Filtered := True;
end;

procedure TfrmFatExpedicao.pFiltrosEstoqueDefault;
begin
  intBusEstSal := 0;
end;

procedure TfrmFatExpedicao.pAtivaDesativaTimersNotificaoAndRecarga(blnAtivarDesativar: Boolean);
begin
  If (blnSOMNSP) Then
  Begin
    tmrTmpIan.Enabled := blnAtivarDesativar;
    tmrTmpRte.Enabled := blnAtivarDesativar;

    If (Assigned(thrNotificacao)) And (thrNotificacao.Started) Then
    Begin
      thrNotificacao.Terminate();
      thrNotificacao.WaitFor();
      thrNotificacao := Nil;
    End;
  End;
end;

procedure TfrmFatExpedicao.pgcExpedicaoChange(Sender: TObject);
begin
  inherited;
  pCarregaItensPageControls;
end;

procedure TfrmFatExpedicao.pGeraArquivoEdiCorpemSistemas(
  stlPedidos: TStringList);
var
  intContador: integer;
  strPedido: String;
  strDiretorio: String;
  strArquivo: String;
  stlGerarPedidos: TStringList;
begin
  if not fCfgSis('USAEDI', varBoolean) then
    Exit;

  if stlPedidos.Count <= 0 then
    Exit;

  strDiretorio := fCfgSis('CAMEDI', varString);

  if fEmptyStr(strDiretorio) then
  begin
    fMensagem('ATENÇÃO!', 'Diretório dos arquivos da Corpem Sistemas não informado nas configurações, "CFG_CAMEDI".', ['&Ok']);
    Exit;
  end;

  stlGerarPedidos := TStringList.Create;

  try
    for intContador := 0 to stlPedidos.Count - 1 do
    begin
      strPedido := fCampoTabela('FGO_NUMDOC', 'FATGOR', ['AUTOINCREM'], [stlPedidos[intContador]], False);
      strArquivo := Concat(strDiretorio,'\',strPedido+'.txt');

      if not FileExists(strArquivo) then
      begin
        stlGerarPedidos.Add(stlPedidos[intContador]);
      end;
    end;

    pAtualizaCADVAL;

    for intContador := 0 to stlGerarPedidos.Count - 1 do
    begin
      if Assigned(prcExecutaRelatorio) then
        prcExecutaRelatorio(430, 24031, [], ['AUTINC'], [stlGerarPedidos[intContador]], nil, nil, True, False);
    end;

    if FileExists(strArquivo) then
      fMensagem('ATENÇÃO!', 'Arquivos EDI-TXT dos pedidos de venda, para integração com CORPEM SISTEMAS, foram gerados com sucesso.', ['&Ok'])
    else
      fMensagem('ATENÇÃO!', 'Não foram gerados os arquivos EDI-TXT.', ['&Ok']);
  finally
    FreeAndNil(stlGerarPedidos);
  end;

end;

procedure TfrmFatExpedicao.pGerarOndaSeparacao;
var
  intContador         : Integer;
  blnInformouSeqSep   : Boolean;
  intQuantidadeSeqSep : Integer;
  blnDesmarcarPedidos : Boolean;
  Posicao             : TBookmark;
begin

  inherited;

  dbgPedidos.DataSource.DataSet.DisableControls;
  Posicao := dbgPedidos.DataSource.DataSet.GetBookmark;

  Try

    blnInformouSeqSep   := False;
    intQuantidadeSeqSep := 0;

    For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
    Begin

      dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);

      If Not fEmptyStr(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString) Then
      Begin
        blnInformouSeqSep   := True;
        intQuantidadeSeqSep := intQuantidadeSeqSep +1;
      End;

    End;

    {Algum dos pedidos selecionados já tem SEQSEP informado!}
    blnDesmarcarPedidos := False;
    If (blnInformouSeqSep) And (intQuantidadeSeqSep < dbgPedidos.SelectedRows.Count) Then
    Begin

      If (fMensagem('Atenção!', 'Foram selecionados pedidos no grid que já tem onda gerada.' + #13 +
                                'Eles serão desmarcados e será gerada uma nova onda para os demais pedidos. Deseja continuar?', ['&Sim', '&Não'], 2) = 1) Then
        blnDesmarcarPedidos := True;

      If Not blnDesmarcarPedidos Then
        Exit;

    End

    Else

    {Todos os pedidos selecionados já tem SEQSEP informado!}
    If (blnInformouSeqSep) And (intQuantidadeSeqSep >= dbgPedidos.SelectedRows.Count) Then
    Begin
      fMensagem('Atenção!','Não foi possível gerar a onda de separação pois todos os pedidos selecionados já tem onda gerada.',['&OK']);
      Exit;
    End;

    If (blnDesmarcarPedidos) Then
    Begin

      dbgPedidos.DataSource.DataSet.First;
      while not dbgPedidos.DataSource.DataSet.Eof do
      begin

        If dbgPedidos.SelectedRows.CurrentRowSelected Then
          If Not fEmptyStr(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString) Then
            dbgPedidos.SelectedRows.CurrentRowSelected := False;

        dbgPedidos.DataSource.DataSet.Next;
      end;

    End;

    if (not fCortePedidosMarketplaceSemSaldo) then
      Exit;

    Try

      fStartTransaction;

      {Gerar SEQSEP}
      strSeqSep := fGerarSeqSep;

      dbgPedidos.DataSource.DataSet.First;
      while not dbgPedidos.DataSource.DataSet.Eof do
      begin

        If dbgPedidos.SelectedRows.CurrentRowSelected Then
          pAtualizaSeqSep(True); // True = Geração manual!

        dbgPedidos.DataSource.DataSet.Next;
      end;

      If Not fCommit Then
        strSeqSep := '';

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.message, 'TfrmFatExpedicao.pGerarOndaSeparacao');
        strSeqSep := '';
      End;
    End;

  Finally

    dbgPedidos.DataSource.DataSet.EnableControls;

    If dbgPedidos.DataSource.DataSet.BookmarkValid(Posicao) Then
      dbgPedidos.DataSource.DataSet.GotoBookmark(Posicao);
  End;

end;

procedure TfrmFatExpedicao.pDisparaThreadNotificacao;
  Var
    cdsDocsNovos: TUniClientDataSet;
    strCaminhoSom: string;
begin
  cdsDocsNovos := TUniClientDataSet.Create(nil);
  Try
    pCloneDataSet(cdsDocsNovos, cdsPedidos);

    cdsDocsNovos.Filtered := False;
    cdsDocsNovos.Filter := cdsPedidos.Filter;

    If Not fEmptyStr(cdsDocsNovos.Filter) Then
      cdsDocsNovos.Filter := cdsDocsNovos.Filter + ' AND ';

    cdsDocsNovos.Filter := cdsDocsNovos.Filter + ' SEPIMP = 0 ';

    cdsDocsNovos.Filtered := True;

    If (cdsDocsNovos.IsEmpty) Or
       (Not fPermiteNotificacaoSonoraNovosPedidos(cdsDocsNovos)) Then
      Exit;
  finally
    FreeAndNil(cdsDocsNovos);
  end;

  tmrTmpIan.Enabled := False;

  strCaminhoSom := fCfgSis('SOMEXP', varString);

  thrNotificacao := TThreadNotificacao.Create(intTMPDNS, strCaminhoSom);
end;

function TfrmFatExpedicao.fGerarTL : Boolean;
var
  strNumLot,
  strLocFis: String;
  qryItensPD: TUniQuery;
  cdsItensTL: TUniClientDataSet;
  objCadLot: TCadLot;
  objTransf: TTransferenciaArmazens;
begin

  Result := True;

  if (not fUsaRotinaWMS) then
    Exit;

  if (not fUsaOndaSeparacaoAgrupamento) then
    Exit;

  qryItensPD := fCriaQuery;
  objCadLot := TCadLot.Create(Self);

  try
    strNumLot := fCfgSis('LTTAPC', varString);
    strLocFis := fCfgSis('LCTAPC', varString);

    if fEmptyStr(strLocFis) or fEmptyStr(strNumLot) then
    begin
      raise Exception.Create('É necessário definir as configurações [CFG_LCTAPC] e [CFG_LTTAPC] para guardar os itens.');
      Exit;
    end;

    pCarregaItensParaGerarTL(qryItensPD);
    pCriaDataSetItensTL(cdsItensTL);
    objTransf := TTransferenciaArmazens.Create(Self, cdsItensTL, Nil, nil);

    while not qryItensPD.Eof do
    begin
      if (not objCadLot.fExisteLote(qryItensPD.FieldByName('CODITE').AsString,
                                    VS_strCodEmp,
                                    strNumLot,
                                    False,
                                    False)) then
        objCadLot.GeraLoteAtivo(qryItensPD.FieldByName('CODITE').AsString, strNumLot, strLocFis);

      if fFormataFloat(qryItensPD.FieldByName('QTDITE').AsFloat, 4) > 0 then
      begin
        cdsItensTL.Append;
        cdsItensTL.FieldByName('CODITE').AsString := qryItensPD.FieldByName('CODITE').AsString;
        cdsItensTL.FieldByName('ARMDES').AsString := strNumLot;
        cdsItensTL.FieldByName('ARMORI').AsString := qryItensPD.FieldByName('NUMLOT').AsString;
        cdsItensTL.FieldByName('QTDITE').AsFloat  := qryItensPD.FieldByName('QTDITE').AsFloat;
        cdsItensTL.Post;
      end;

      qryItensPD.Next;
    end;

    objTransf.strDocFat := qryItensPD.FieldByName('NUMFAT').AsString;
    objTransf.strEspFat := qryItensPD.FieldByName('TIPFAT').AsString;
    objTransf.strEmpFat := qryItensPD.FieldByName('EMPFAT').AsString;
    objTransf.strCliFat := qryItensPD.FieldByName('CODCLI').AsString;

    if not cdsItensTL.IsEmpty then
      Result := objTransf.fGeraTransferencia(True, False);

  finally
    FreeAndNil(objCadLot);
    FreeAndNil(qryItensPD);
    FreeAndNil(cdsItensTL);
    FreeAndNil(objTransf);
  end;
end;

procedure TfrmFatExpedicao.pGetQuantSepConfOnda(const strAutInc: String; out fltQtdSep, fltQtdCnf: Double);
  Var
    qryOnda: TUniQuery;
begin
  qryOnda := fCriaQuery;
  Try
    qryOnda.SQL.Add('SELECT');
    qryOnda.SQL.Add('  SUM(IFNULL(FDO_QTDSEP, 0)) AS QTD_SEPARADA,');
    qryOnda.SQL.Add('  SUM(IFNULL(FDO_QTDEXP, 0)) AS QTD_CONFERIDA');
    qryOnda.SQL.Add('FROM FATDOR');
    qryOnda.SQL.Add('JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
    qryOnda.SQL.Add('WHERE FDO_SEQGER = :AUTINC');

    qryOnda.ParamByName('AUTINC').AsString := strAutInc;
    qryOnda.Open;

    fltQtdSep := qryOnda.FieldByName('QTD_SEPARADA').AsFloat;
    fltQtdCnf := qryOnda.FieldByName('QTD_CONFERIDA').AsFloat;
  Finally
    FreeAndNil(qryOnda);
  End;
end;

procedure TfrmFatExpedicao.pGravarConfiguracoesExpedicao;
begin
  TCfgColExp.pCarregarDadosSalvos(dbgPedidos);
  TCfgSugExp.pCarregarSugestoes(pnlFiltros);
  pCarregaOpcoesLocais;
  pCarregaSugestaoDadosFiltroVendedor;
  pFiltrarPedidos();
  pCalculaResumoTotalDocumentos();
  pCarregarCores();
  pCarrecaOpcaoOcultarInformacoes;
end;

procedure TfrmFatExpedicao.pGravarViaConferenciaSeperacao(
  const strAutInc: String);
var
  qryAux : TUniQuery;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Text := 'UPDATE EXTGOR '
                     + '   SET FGO_TIPCNS = :TIPCNS '
                     + ' WHERE FGO_SEQFGO = :AUTINC ';

    qryAux.ParamByName('TIPCNS').AsString := strViaConferenciaSeparacao;
    qryAux.ParamByName('AUTINC').AsString := strAutInc;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmFatExpedicao.fGuardarItensSeparados: Boolean;
var
  qryUpdLotDor: TUniQuery;
  qryUpdFatGor: TUniQuery;
  qryUpdExtGor: TUniQuery;
  blnApagarLotDor : Boolean;
begin
  inherited;

  Result := True;

  qryUpdLotDor := fCriaQuery;
  qryUpdFatGor := fCriaQuery;
  qryUpdExtGor := fCriaQuery;

  try
    qryUpdLotDor.SQL.Add('UPDATE LOTDOR');
    qryUpdLotDor.SQL.Add('INNER JOIN FATDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryUpdLotDor.SQL.Add('  SET LDO_PEDCAN = "S"');
    qryUpdLotDor.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qryUpdLotDor.SQL.Add('  AND FDO_ESPDOC = :ESPDOC');
    qryUpdLotDor.SQL.Add('  AND FDO_CODEMP = :CODEMP');

    qryUpdFatGor.SQL.Add('UPDATE FATGOR SET FGO_SEPIMP = "0"');
    qryUpdFatGor.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryUpdFatGor.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
    qryUpdFatGor.SQL.Add('  AND FGO_CODEMP = :CODEMP');

    qryUpdExtGor.SQL.Add('UPDATE EXTGOR');
    qryUpdExtGor.SQL.Add('INNER JOIN FATGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM');
    qryUpdExtGor.SQL.Add(  'SET FGO_EXTSEP = "S"');
    qryUpdExtGor.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryUpdExtGor.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
    qryUpdExtGor.SQL.Add('  AND FGO_CODEMP = :CODEMP');

    try
      qryUpdLotDor.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
      qryUpdLotDor.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
      qryUpdLotDor.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
      qryUpdLotDor.ExecSql;

      qryUpdFatGor.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
      qryUpdFatGor.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
      qryUpdFatGor.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
      qryUpdFatGor.ExecSql;

      qryUpdExtGor.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
      qryUpdExtGor.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
      qryUpdExtGor.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
      qryUpdExtGor.ExecSql;

      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(fField('NUMDOC').AsString)
                          .EspDoc(fField('ESPDOC').AsString)
                          .CodEmp(fField('CODEMP').AsString)).pExecute();

      blnApagarLotDor := False;

      If fUsaOndaSeparacaoAgrupamento Then
      Begin
        blnApagarLotDor := True;
        Result := fGerarTL;
      End;

      Result := Result and untFatGor.fLimpaExpedicaoPedido(fField('AUTINC').AsString, False, IIF(FExcluirExtLar, eeloExcluir, eeloNaoExcluir), blnApagarLotDor);

      if Result then
        pDeletaSepDor(fField('AUTINC').AsString);
    Except
      On E: Exception Do
      Begin
        raise;
      End;
    End;
  finally
    FreeAndNil(qryUpdLotDor);
    FreeAndNil(qryUpdFatGor);
    FreeAndNil(qryUpdExtGor);
  end;
end;

procedure TfrmFatExpedicao.pHabilitarBotaoFaturarOndaSeparacao;
begin
  btnFaturarOndaSeparacao.Visible := fCfgSis('ONDASE', VarBoolean) And
    (Not blnApenasImprimirBaixarSeparacao) And (Not blnApenasConferenciaProdutosRetiraCaixa);
  btnFaturarOndaSeparacao.Enabled := (FiltroOnda = fosFaturamentoLiberacaoOnda) And (Not fEmptyStr(strNumeroOnda));
end;

procedure TfrmFatExpedicao.pHabilitarBotaoFaturarTodos;
begin
  btnExpFatAutTodos.Visible := fCfgSis('EXFTAU', VarBoolean) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And (Not fUsaRotinaWMS);
end;

procedure TfrmFatExpedicao.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
  Var
    intMsg : Integer;
    strValue : String;
begin

  inherited;
  if blnExecutandoFormShow then Exit;   // protege todos os dispatches abaixo evitando Access violation durante formshow

  pAtivaDesativaTimersNotificaoAndRecarga(False);
  {Atalhos com ALT}
  If (Shift = [ssAlt]) Then
  Begin

    If (Key = VK_F1) Then
      btnLegenda.Click
    Else
    If (mnuLimparSeparacao.Visible) And (Key = VK_F2) Then
      mnuLimparSeparacaoClick(Self)
    Else
    If (mnuRemanejarSeparador.Visible) And (Key = VK_F3) Then
      mnuRemanejarSeparadorClick(Self)
    Else
    If (mnuLimparSeparacaoRomaneio.Visible) And (Key = VK_F4) Then
      mnuLimparSeparacaoRomaneioClick(Self)
    Else
    If (mnuVerSeparacoes.Visible) And (Key = VK_F11) Then
      mnuVerSeparacoesClick(Self)
    Else
    If btnFaturarOndaSeparacao.Visible And
       btnFaturarOndaSeparacao.Enabled And (Key = VK_F10) Then
      btnFaturarOndaSeparacao.Click
    Else
    If (Key = VK_F12) Then
      btnConPedPen.Click
    Else
    If (Key = VK_F6) Then
      btnMensagemExpedicao.Click
    Else
    If (Key = VK_F9) Then
      btnImpOrdemProducao.Click
    Else If (Key = VK_F7) And (btnFrete.Visible) And (btnFrete.Enabled) Then
      btnFrete.Click
    else if (Key = VK_F5) then
      btnExibirProdutos.Click;
  End
  Else If (Shift = [ssCtrl]) then
  Begin
    If Key = Ord('E') Then
      btnEntFutCD.Click
    Else If (Key = VK_F2) Then
      btnAltEmpFat.Click
    Else If (Key = VK_F3) Then
      btnRevEmpFat.Click
    Else If (Key = VK_F5) Then
      btnMulSep.Click
    Else If (Key = VK_F6) Then
      btnAltLotImpSep.Click
    Else If (Key = VK_F7) Then
      btnConsultaPed.Click
    Else
    If (mnuGuardarItensSep.Visible) And (Key = VK_F8) Then
      mnuGuardarItensSepClick(Self)
    Else If (Key = VK_F4) And (btnSituacaoItens.Visible) Then
      btnSituacaoItens.Click
    Else If (Key = VK_F10) And btnExpFatAutTodos.Visible Then
      btnExpFatAutTodos.Click;
  End
  Else
  Begin

    If (Key = VK_F2) Then
      btnOpeDes.Click
    Else
    If (Key = VK_F3) Then
      btnBuscar.Click
    Else If (Key = VK_F4) Then
      btnLimparBusca.Click
    Else If (Key = VK_F5) and (btnConsProduto.Visible) Then
      btnConsProduto.Click
    Else If (Key = VK_F6) Then
    Begin
      If Shift = [] Then
      Begin
        btnImpSep.Click;
      End
      Else
      If fUsaRotinaWMS And fConferenciaDepoisDaEntrada Then
      Begin
        If Shift = [ssCtrl] Then
        Begin
          If (fMensagem('', 'Deseja imprimir a separação do '+strDescDoc+' selecionado?', ['&Sim', '&Não'], 2) = 1) Then
            fImprimirSeparacao(tisWMSAtualSemEscolha);
        End
        Else If Shift = [ssShift] Then
        Begin
          intMsg := fMensagem('', 'Deseja imprimir a separação de todos os pedidos com separação não impressa ou deseja escolher uma quantidade de pedidos?', ['&Todos', '&Digitar Qtde.', 'Cancelar'], 3);
          intQtdImpSepWMS := 0;

          If (intMsg = 1) Then
            fImprimirSeparacao(tisWMSTodos)
          Else
          If (intMsg = 2) Then
          Begin
            strValue := '0';
            If fInputQueryTipo('Impressão de Separação', 'Digite a Quantidade de Pedidos que deseja imprimir a separação:',strValue, EditFocus.ttInteiro) Then
            Begin
              intQtdImpSepWMS := StrToIntDef(strValue, 0);
              if (intQtdImpSepWMS <= 1) Then
              Begin
                fMensagem('', 'Para imprimir vários pedidos ao mesmo tempo informe um número maior que 1 ou utilize o [Ctrl + F6] para imprimir apenas um pedido!', ['&OK']);
                pAtivaDesativaTimersNotificaoAndRecarga(True);
                Exit;
              End;

              fImprimirSeparacao(tisWMSTodos);

            End;

          End;
        End
        Else
        If Shift = [ssShift, ssCtrl] Then
        Begin
          If fEmptyStr(fField('SEQSEP').AsString) Then
          Begin
            fMensagem('', 'O Registro atual não possui sequencial de separação, para reimprimir é preciso escolher um registro com separação já impressa!', ['&OK']);
            Key := 0;
            pAtivaDesativaTimersNotificaoAndRecarga(True);
            Exit;
          End;

          If (fMensagem('', 'Deseja reimprimir a separação de todos os pedidos do sequencial de separação:' + fField('SEQSEP').AsString + ' ?', ['&Sim', '&Não'], 2) = 1) Then
            fImprimirSeparacao(tisReimpressaoSeqSeparacaoWMS);
        End;
      End;
    End
    Else If (Key = VK_F7) And (fPermiteExecutarRotinaAtualizacaoTela) Then
      btnRecarrPed.Click
    Else If (ssAlt In Shift) And (Key = VK_F8) Then
      btnCliObs.Click
    Else If (Key = VK_F8) And btnConfirmaCupons.Visible Then
      btnConfirmaCupons.Click
    Else If (Key = VK_F9) Then
    Begin
      If ( btnBuscaNFe_Estoque.Visible ) Then
        btnBuscaNFe_Estoque.Click
    End
    Else If (Key = VK_F10) Then
      btnConfirma.Click
    Else If (Key = VK_F11) Then
      btnFaturarExpedidos.Click
    Else If (Key = VK_F12) Then
      btnFeriados.Click
    Else If (Key = VK_F1) And (btnDesmExpedidos.Visible) AND (Shift = []) Then
      btnDesmExpedidos.Click
    else if (Key = VK_SPACE) then
      btnExibirProdutos.Click;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.pSelecionaPedido(strCodBarrasExp: String = '');
  Var
    strDocTra: String;
    strEspTra: String;
    strEmpTra: String;
    strCliTra: String;
    strChaLck: String;
    blnLibera: Boolean;
    frmFatExpedicaoItens : TfrmFatExpedicaoItens;
begin
  strDocTra := fField('NUMDOC').AsString;
  strEspTra := fField('ESPDOC').AsString;
  strEmpTra := fField('CODEMP').AsString;
  strCliTra := fField('CODCLI').AsString;

  If (Not fPermiteSelecionarPedidoAtual) Then
  Begin
    Exit;
  End;

  If (Not fValidouConsultaSituacaoCadastral(strCliTra)) Then
  Begin
    fMensagem('ATENÇÃO!', Format(MSG_PAINEL_FECHADO_CONSULTA_CADASTRAL, [VS_strCodEmp]), ['&OK']);
    Exit;
  End;

  pNotificaOperadorExpedicao(strCliTra);

  If Not (fAvisaOperadorDestinoDiferente(fField('ENTRET').AsString)) Then
    Exit;


  Screen.Cursor := crHourGlass;
  strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;

  blnLibera := (objLock.fLock_Unlock(strChaLck, True, False));
  blnLibera := fVerificaTravaConferencia(blnLibera, strChaLck);

  If (Not blnLibera) Then
  Begin
    Screen.Cursor := crDefault;
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck)  + '!', ['&Ok']);
    Exit;
  End;

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    objLock.fLock_Unlock(strChaLck + STR_TRAVA_CONFERENCIA, True, False);

  strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;

  If (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
  Begin
    Screen.Cursor := crDefault;
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck)  + '!', ['&Ok']);
    Exit;
  End;

  Screen.Cursor := crDefault;

  pCriarFormularios(TfrmFatExpedicaoItens, frmFatExpedicaoItens);
  Try
    blnEmExpedicaoItens := True;
    pSuspenderTimersRecarga;
    Try
      frmFatExpedicaoItens.Params.blnSolicitaTelaDeVolume := blnSolicitaTelaDeVolume;
      frmFatExpedicaoItens.Params.blnPermiteExpedirPedidoAVistaCaixaFechado := blnPermiteExpedirPedidoAVistaCaixaFechado;

      If stlSeqFgo.Count > 0 Then
        frmFatExpedicaoItens.Params.cdsFilEst := cdsFilEst;

      frmFatExpedicaoItens.Params.blnExiPedRetiraExpAntFat := objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat;

      if (fField('PEDPAR').AsString = 'R') or (fField('FATAUT').AsString = 'S') then
        frmFatExpedicaoItens.Params.VS_strTipExpInterna := TIPEXP_POR_DOCUMENTO_DE_VENDA
      else
        frmFatExpedicaoItens.Params.VS_strTipExpInterna := VS_strTipExp;

      frmFatExpedicaoItens.Params.blnUsaImpressaoSeparacaoPorLocal := blnUsaImpressaoSeparacaoPorLocal;
      frmFatExpedicaoItens.Params.blnSepPorArmazem := (tfFiltroLocSepArmz = tfArmazem);

      frmFatExpedicaoItens.Params.blnCarregarQtdExpedida := VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO;

      frmFatExpedicaoItens.Params.blnAutSer := blnAutSer;

      frmFatExpedicaoItens.btnEditarMensagem.Visible := btnMensagemExpedicao.Visible;
      frmFatExpedicaoItens.Params.cdsExpedicao := cdsPedidos;
      frmFatExpedicaoItens.Params.stlPedidos := stlPedidos;

      if (fField('PEDPAR').AsString <> 'R') And (fField('FATAUT').AsString <> 'S') then
      begin
        If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And (strEspTra <> 'PD') Then
          frmFatExpedicaoItens.Caption := frmFatExpedicaoItens.Caption + ' - Documento: '
        Else
          frmFatExpedicaoItens.Caption := frmFatExpedicaoItens.Caption + ' - Pedido: ';
      end
      else
        frmFatExpedicaoItens.Caption := frmFatExpedicaoItens.Caption + ' - Documento: ';

      frmFatExpedicaoItens.Caption := frmFatExpedicaoItens.Caption +
                                      fField('NUMDOC').AsString + ' - ' +
                                      fField('ESPDOC').AsString + ' - ' +
                                      fField('CODEMP').AsString + ' - ' +
                                      fField('CODCLI').AsString + ' - ' + fField('NOMCLI').AsString + ' - '+
                                      fField('CODVEN').AsString + ' - ' + fRetNomVendRep(fField('CODVEN').AsString) +
                                      IIF(Not fEmptyStr(fField('NOMTRA').AsString), ' - Transportadora: ' + fField('NOMTRA').AsString, '');

      frmFatExpedicaoItens.Params.blnExpedicaoDocumentoFaturadoAutomaticamente := (fField('FATAUT').AsString = 'S');

      If (fField('FATAUT').AsString = 'S') Then
      Begin
        If fOndaSeparacao Then
        Begin
          frmFatExpedicaoItens.Params.TipoItemDoPedidoOndaSeparacao := Self.FTipoItemDoPedidoOndaSeparacao;
          frmFatExpedicaoItens.Params.blnOndaSeparacao := True;
          frmFatExpedicaoItens.Params.strCodBarrasExp  := strCodBarrasExp;
          If fEmptyStr(strCodBarrasExp) Then
            pLimparVariaveisSeparadorConferenteOndaSeparacao;
          frmFatExpedicaoItens.Params.strSeparador := fField('CODSEP').AsString;
        End;
        frmFatExpedicaoItens.Params.strNumDoc := fField('NUMFAT').AsString;
        frmFatExpedicaoItens.Params.strEspDoc := fField('TIPFAT').AsString;
        frmFatExpedicaoItens.Params.strCodEmp := fField('EMPFAT').AsString;
        frmFatExpedicaoItens.Params.strEmpExp := fField('EMPEXP').AsString;
        frmFatExpedicaoItens.Params.strSerie_ := fField('SERIE_').AsString;
        frmFatExpedicaoItens.Params.strSeparador := fField('CODSEP').AsString;
        frmFatExpedicaoItens.Params.blnFatAut := True;
      End
      Else
      Begin
        frmFatExpedicaoItens.Params.strNumDoc := fField('NUMDOC').AsString;
        frmFatExpedicaoItens.Params.strEspDoc := fField('ESPDOC').AsString;
        frmFatExpedicaoItens.Params.strCodEmp := fField('CODEMP').AsString;
        frmFatExpedicaoItens.Params.strEmpExp := fField('EMPEXP').AsString;
        frmFatExpedicaoItens.Params.strSerie_ := fField('SERIE_').AsString;
      End;

      frmFatExpedicaoItens.Params.strCodCli := fField('CODCLI').AsString;
      frmFatExpedicaoItens.Params.blnColetor:= blnColetor;
      frmFatExpedicaoItens.Params.blnExpParcialTipExp4 := blnExpedicaoParcial;
      frmFatExpedicaoItens.Params.blnBaiEntFut := (fField('BENFUT').AsString = 'S');
      frmFatExpedicaoItens.Params.strCfgENFUOP := fField('ENFUOP').AsString;
      frmFatExpedicaoItens.Params.blnExpedicaoDePedidoDeConsignacao := FblnTemPedidoDeConsignacao;
      frmFatExpedicaoItens.Params.blnFreteRateado := (fField('FRERAT').AsFloat > 0);
      frmFatExpedicaoItens.Params.strRegimeEspecial := IIF(fField('REGESP').AsString = 'S', 'S', 'N');
      frmFatExpedicaoItens.Params.stlPedidos := stlPedidos;

      frmFatExpedicaoItens.ShowModal;

      If frmFatExpedicaoItens.blnConfirmou Then
        TFrmGravando.fExecutarModal( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pSelecionaPedido]');
    End;
  Finally
    blnEmExpedicaoItens := False;
    pRestaurarTimersRecarga;
    pFreeAndNil(frmFatExpedicaoItens);
  End;

  strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;
  pLiberaTravaVerificandoRomaneioEmAndamento(strChaLck);

  strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;
  objLock.fLock_Unlock(strChaLck, False, False);
end;

procedure TfrmFatExpedicao.pSelecionarPedidosOndaAutomaticamente;
var
  intMax : Integer;
begin

  dbgPedidos.SelectedRows.Clear;

  If Not fOndaSeparacao Then
    Exit;

  If (Not blnSelPedOndaAut) Then
    Exit;

  if (not Assigned(dbgPedidos.DataSource.DataSet)) then
    Exit;

  intMax := fCfgSis('ONDMAX', varInteger);

  cdsPedidos.First;
  While Not cdsPedidos.Eof Do
  Begin
    dbgPedidos.SelectedRows.CurrentRowSelected := True;

    If intQtdPedOnda > 0 Then
      If (dbgPedidos.SelectedRows.Count >= intQtdPedOnda) Then
        Break;

    If intMax > 0 Then
      If (dbgPedidos.SelectedRows.Count >= intMax) Then
        Break;

    cdsPedidos.Next;
  End;
end;

procedure TfrmFatExpedicao.dbgAdiantamentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Assigned(dtsAdiantamentos.DataSet) Then
  Begin
    With dtsAdiantamentos.DataSet, dbgAdiantamentos.Canvas Do
    Begin
      If Not Active Or IsEmpty Then
        Exit;

      If FieldByName('DESCRI').AsString = TOTALIZACAO Then
      Begin
        Brush.Color := clSilver;
        Font.Color  := clBlack;
        If Column.FieldName = 'TIPLAN' Then
        Begin
          Font.Style  := [fsBold];
          TextOut(Rect.Right - TextWidth(TOTALIZACAO) - 25,
                  Rect.Top + 2, TOTALIZACAO);
        End;
      End
      Else If Font.Color = clHighlightText Then
      Begin
        If FieldByName('TIPLAN').AsString <> 'C' Then
          Font.Color := clYellow
        Else
          Font.Color := clWhite;
      End
      Else
      Begin
        If (RecNo Mod 2 = 0) Then
          Brush.Color := fCfgSis('CORZEB')
        Else
          Brush.Color := ClWhite;

        If FieldByName('TIPLAN').AsString <> 'C' Then
          Font.Color := clRed
        Else
          Font.Color := clBlue;
      End;

      FillRect(Rect);
    End;

    dbgAdiantamentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TfrmFatExpedicao.dbgPedidosCellClick(Column: TColumn);
  var
    intMax : Integer;
begin
  inherited;

  intMax := fCfgSis('ONDMAX', varInteger);

  If (FiltroOnda = fosSelecaoPedidosGeracaoOnda) And (dbgPedidos.SelectedRows.Count > intMax) Then
  Begin
    fMensagem('Informação', 'Não pode ser ultrapassado o limite máximo de pedidos para geração da onda de separação, máximo permitido: ' + intMax.ToString, ['&Ok']);
    dbgPedidos.SelectedRows.CurrentRowSelected := False;
    Exit;
  End;

  pTotalizadoresLinhasSelecionadas;
  pTotalizaValoresPedidosSelecionados;
end;

procedure TfrmFatExpedicao.dbgPedidosDblClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If blnAtualizandoGrid Then
    Exit;

  If fSomenteF3 Then
  Begin
    fMensagem('', 'Será necessário utilizar botão "[F3] Buscar" para ler o código de barras do '+strDescDoc+'!', ['&OK']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If Not fPermitirFaturarContaOrdem Then
    Exit;

  if fField('PEDPAR').AsString <> 'R' then
  begin
    If blnApenasConferenciaProdutosRetiraCaixa Then
      pSelecionaVariosPedidos
    Else If blnApenasImprimirBaixarSeparacao Then
      pBaixarSeparacaoPedido
    Else If fField('FATAUT').AsString = 'S' Then
      pSelecionaPedido()
    Else If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And
            (objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat) And
            (fField('ESPDOC').AsString = 'PD') Then
      pSelecionaVariosPedidos()
    Else If VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA Then
      pSelecionaPedido()
    Else
      pSelecionaVariosPedidos();
  end
  else
    pSelecionaPedido;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

function TfrmFatExpedicao.fGetQtdDoc(strAlias: String; blnQtdIte: Boolean = False): String;
Begin
  Result := '';
  Result := Result + ' (SELECT ';

  If blnQtdIte Then
    Result := Result + '    SUM(COALESCE(TMPDET.DET_QTDITE, 0)) AS QTDITE '
  Else
    Result := Result + '    SUM(COALESCE(TMPTRI.DET_QTDEXP, 0)) AS QTDEXP ';

  Result := Result + '  FROM ';
  Result := Result + '    MOVDET TMPDET ';

  If Not blnQtdIte Then
    Result := Result + '  LEFT JOIN MOVTRI TMPTRI ON (TMPTRI.DET_SEQGER = TMPDET.AUTOINCREM) ';

  Result := Result + '  WHERE ';
  Result := Result + '    TMPDET.DET_SEQGER = ' + strAlias + '.AUTOINCREM) ';
End;


procedure TfrmFatExpedicao.pCarrecaOpcaoOcultarInformacoes;
var
  objConfigOcultInfo: TOcultInfo;
begin
  objConfigOcultInfo := TOcultInfo.Create;

  try
    objConfigOcultInfo.pCarregaConfiguracao;

    if (objConfigOcultInfo.OcultPnlInf) then
    begin
      pgcExpedicao.Visible := False;
      lblOcultarExibirPainelInformacoes.Caption := 'Clique aqui para exibir o Painel de Informações';
    end
    else
    begin
      pgcExpedicao.Visible := True;
      lblOcultarExibirPainelInformacoes.Caption := 'Clique aqui para ocultar o Painel de Informações';
    end;

    pnlFeriados.Visible := Not objConfigOcultInfo.OcultFerMun;

    if (objConfigOcultInfo.OcultStaPed) and (pnlStatusPedido.Visible) then
    begin
      lblExibirFiltroStatusPedidos.Caption := STR_FILTRO_STATUS_PEDIDO_EXIBIR;
      If grbStatusPedido.Visible Then
      Begin
        grbStatusPedido.Visible := False;
        pnlFiltros.Height       := pnlFiltros.Height - intStatusPedidoHeight;
        pnlStatusPedido.Height  := pnlStatusPedido.Height - intStatusPedidoHeight;
      End;
    end
    else
    begin
      lblExibirFiltroStatusPedidos.Caption := STR_FILTRO_STATUS_PEDIDO_OCULTAR;
      If Not grbStatusPedido.Visible Then
      Begin
        grbStatusPedido.Visible := True;
        pnlFiltros.Height       := pnlFiltros.Height + intStatusPedidoHeight;
        pnlStatusPedido.Height  := pnlStatusPedido.Height + intStatusPedidoHeight;
      End;
    end;

  finally
    FreeAndNil(objConfigOcultInfo);
  end;
end;

{*******************************************}
{* CARREGA DOCUMENTOS CASO SEJA OPÇÃO DE   *}
{* FATURAMENTO ANTES DA EXPEDIÇÃO (OPC. 2) *}
{***19/05/2008***************************MV*}
procedure TfrmFatExpedicao.pCarregaDocumentos(const strTmpPedidosPendentes: String);
var
  qryQuery: TUniQuery;
  strSQL: String;
begin

  pLimpaVariaveisSelecaoPedidos;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  "N"  AS BENFUT, ';
  strSQL := strSQL + '  " "  AS PEDPAR, ';
  strSQL := strSQL + '  CAST("" AS CHAR(10)) AS QTDPRO, ';
  strSQL := strSQL + '  " " AS NUMCMP, ';
  strSQL := strSQL + '  CAST("" AS CHAR(19)) AS AGSEPA, ';
  strSQL := strSQL + '  CAST("" AS CHAR(19)) AS INISEP, ';
  strSQL := strSQL + '  CAST("" AS CHAR(19)) AS AGFATU, ';
  strSQL := strSQL + '  "MOVGER" AS TABELA,          ';
  strSQL := strSQL + '  0 AS ORDCOR,                 ';
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '  MOVGER.GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  MOVGER.GER_HORENT AS HORENT, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS PREVIS, ';
  strSQL := strSQL + '  MOVGER.GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  MOVGER.GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  MOVGER.GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  MOVGER.GER_SERIE_ AS SERIE_, ';
  strSQL := strSQL + '  CLI_C_G_C_ AS CNPJCPF, ';
  strSQL := strSQL + '  AUX_CODFAZ AS CODFAZ, ';
  strSQL := strSQL + '  "V"        AS TIPOPE, ';
  strSQL := strSQL + '  "AUTCOM"   AS ORIGOR, ';
  strSQL := strSQL + '  MOVGER.GER_CODEMP AS EMPEXP, ';
  strSQL := strSQL + '  CLI_CODREG AS CODREG, ';
  strSQL := strSQL + '  CLI_ORIENT AS ORIENT, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(255)) AS ENDDOC, ';
  strSQL := strSQL + '  COALESCE(ETC_CIDENT, IF(MOVGER.GER_NOMCON IS NULL, CLI_CODCID, MOVGER.GER_CIDCON)) AS CODCID_BUSCA , ';
  strSQL := strSQL + '  CONCAT(MOVGER.GER_NUMDOC, "-", MOVGER.GER_ESPDOC, "-", MOVGER.GER_CODEMP) AS DOCUME, ';
  strSQL := strSQL + '  CONCAT(MOVGER.GER_NUMFAT, "-", MOVGER.GER_TIPFAT, "-", MOVGER.GER_EMPFAT) AS DOCFAT, ';
  strSQL := strSQL + '  MOVGER.GER_NUMFAT AS NUMFAT, ';
  strSQL := strSQL + '  MOVGER.GER_TIPFAT AS TIPFAT, ';
  strSQL := strSQL + '  MOVGER.GER_EMPFAT AS EMPFAT, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_NOMCON', 'CLI_NOMCLI') + ' AS NOMCLI, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_CGCCON', 'CLI_C_G_C_') + ' AS CLICGC, ';
  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_NOMCON', 'CLI_FANSOB') + ' AS FANSOB, ';
  strSQL := strSQL + '   CLI_CATEGO AS CATEGO, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_CIDCON',
                     ' IF(IFNULL(AUX_ENTGER, "") = "", CLI_CODCID, ETC_CIDENT)');
  strSQL := strSQL + '  AS CODCID, ';

  strSQL := strSQL + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_NOMCID, CIDENT.CID_NOMCID) AS NOMCID, ';
  strSQL := strSQL + 'IF(IFNULL(AUX_ENTGER, "") = "", CADCID.CID_ESTADO, CIDENT.CID_ESTADO) AS ESTADO, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_ENDCON',
                     '  IF(IFNULL(AUX_ENTGER, "") <> "", ETC_ENDENT, ' +
                     '     CONCAT(CLI_ENDERE, ' +
                     '     IF(IFNULL(CLI_ENDNUM, " ") = " "," ", CONCAT(", ", CLI_ENDNUM)), ' +
                     '     IF(IFNULL(CLI_ENDCOM, "") = "","", CONCAT(" ", CLI_ENDCOM)))) ');
  strSQL := strSQL + '  AS ENDERE, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_BAICON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_BAIRRO, ETC_BAIENT) ') + ' AS BAIRRO, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_CEPCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_C_E_P_, ETC_CEPENT) ') + ' AS C_E_P_, ';

  strSQL := strSQL + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_TELCON',
                     '  IF(IFNULL(AUX_ENTGER, "") = "", CLI_FONE01, ETC_TELENT) ') + ' AS TELEFO, ';

  strSQL := strSQL + fRetSQLDescricaoFrete('MOVGER.GER_TIPFRE') + ' AS TIPFRE, ';

  strSQL := strSQL + '  MOVGER.GER_PESBRU AS PESBRU, ';
  strSQL := strSQL + '  MOVGER.GER_TOTFRE AS TOTFRE, ';
  strSQL := strSQL + '  MOVGER.GER_VOLUME AS VOLUME, ';
  strSQL := strSQL + '  MOVGER.GER_VLRCON AS VLRCON, ';
  strSQL := strSQL + '  MOVGER.GER_VLRCON AS VALDOC, ';
  strSQL := strSQL + '  SUM(MOVDET.DET_QTDITE) AS QTDITE, ';
  strSQL := strSQL + '  MOVGER.GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  MOVGER.GER_CODFPG AS CODFPG, ';
  strSQL := strSQL + '  CONCAT(FPG_CODIGO, " - ", FPG_DESCRI) AS DESFPG, ';
  strSQL := strSQL + '  MOVGER.GER_CONPAG AS CONPAG, ';
  strSQL := strSQL + '  MOVGER.GER_CODCND AS CODCND, ';
  strSQL := strSQL + '  MOVGER.GER_OPEEXP AS OPEEXP, ';
  strSQL := strSQL + '  MOVGER.GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  MOVGER.GER_CODDIG AS CODDIG, ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMOPE, ';
  strSQL := strSQL + '  OPE_CODDEP AS DEPVEN, ';
  strSQL := strSQL + '  OPE_CODEMP AS EMPVEN, ';
  strSQL := strSQL + '  " "        AS CODVE2, ';
  strSQL := strSQL + '  " "        AS OPRFLJ, ';
  strSQL := strSQL + '  MOVGER.GER_CODTRA AS CODTRA, ';
  strSQL := strSQL + '  TRA.TRA_NOMTRA AS NOMTRA, ';
  strSQL := strSQL + '  IF(IF(IFNULL(GER_CONSUM,"") = "", CLI_CONSUM, GER_CONSUM) = "S", "Comercialização", "Industrialização") AS INDCOM, ';
  strSQL := strSQL + '  "     "    AS CODPOR, ';
  strSQL := strSQL + '  IF(IFNULL(AUX_ENTGER, "") <> "", CADREG3.REG_DESREG, CADREG.REG_DESREG) AS DESREG, ';
  strSQL := strSQL + '  0.00       AS MINFAT, ';
  strSQL := strSQL + '  GER_MENEXP AS MENEXP, ';
  strSQL := strSQL + '  GER_MENEX2 AS MENEX2, ';
  strSQL := strSQL + '  GER_MENEX3 AS MENEX3, ';
  strSQL := strSQL + '  GER_MENEX4 AS MENEX4, ';
  strSQL := strSQL + '  MOVGER.GER_MEN001 AS MEN001, ';
  strSQL := strSQL + '  MOVGER.GER_MEN002 AS MEN002, ';
  strSQL := strSQL + '  MOVGER.GER_MEN003 AS MEN003, ';
  strSQL := strSQL + '  MOVGER.GER_MEN004 AS MEN004, ';
  strSQL := strSQL + '  MOVGER.GER_MEN005 AS MEN005, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(03)) AS OPBXSE, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTBXSE, ';
  strSQL := strSQL + '  CAST(NULL AS TIME) AS HRBXSE, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTIMSE, ';
  strSQL := strSQL + '  CAST(NULL AS TIME) AS HRIMSE, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(12)) AS SEQSEP, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(12)) AS SEQOND, ';
  strSQL := strSQL + '  "N"                    AS TEMSEPDOR, ';

  //itens para serem utilizados no filtro
  strSQL := strSQL + '  GROUP_CONCAT(MOVDET.DET_CODITE) AS CODITENS, ';

  strSQL := strSQL + '  CAST(NULL AS CHAR(1)) AS SEPIMP ,';
  strSQL := strSQL + '  " "        AS OPEDES, ';
  strSQL := strSQL + '  " "        AS OPDENO, '; //Nome Operador Designado.
  If (fCfgSis('TPDCEX') = '1') and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
    strSQL := strSQL + '  " "        AS FTIPPED, ';
  strSQL := strSQL + '  " "        AS TIPPED, ';
  strSQL := strSQL + '  " "        AS CLICTT, ';
  strSQL := strSQL + '  " "        AS OBSEXP, ';
  strSQL := strSQL + '  " "        AS ENTURG, ';
  strSQL := strSQL + '  " "        AS CODSEP, ';
  strSQL := strSQL + '  AUX_FASOBR AS FASOBR, ';
  strSQL := strSQL + '  " "        AS CODROT, ';
  strSQL := strSQL + '  CAST(NULL AS DATE) AS DTAROT, ';
  strSQL := strSQL + '  "        " AS SEQROT, ';
  strSQL := strSQL + '  "        " AS DESREG2, ';
  strSQL := strSQL + '  0.00       AS VRROTA, ';
  strSQL := strSQL + '  0.00       AS VLRMIN, ';
  strSQL := strSQL + '  "S"        AS LIBSEP, ';
  strSQL := strSQL + '  " "        AS NOMSEP, ';
  strSQL := strSQL + '  CAST(NULL AS DATETIME) AS DTALIC, ';
  strSQL := strSQL + '  CAST(NULL AS DATETIME) AS DTALIB, ';
  strSQL := strSQL + '  0.00       AS VALREC, ';
  strSQL := strSQL + '  0.00       AS VALADT, ';
  strSQL := strSQL + '  0.00       AS VALADT_FATAUT, ';
  strSQL := strSQL + '  " "        AS SITADT, ';
  strSQL := strSQL + '  " "        AS FPGNEG, ';
  strSQL := strSQL + '  "N"        AS ORIF11, ';
  strSQL := strSQL + '  IFNULL(AUX_TOTBRI, 0) AS TOTBRI, ';
  strSQL := strSQL + '  0.00       AS BOLADT, ';
  strSQL := strSQL + '  "N"        AS BOLVEN, ';
  strSQL := strSQL + '  "OK"       AS SITFIN, ';
  strSQL := strSQL + '  AUX_SEQDMP AS SEQDMP, ';

  strSQL := strSQL + '   CAST(NULL AS CHAR(50)) AS TX_PIX, ';
  strSQL := strSQL + '   CAST(NULL AS CHAR(3))  AS EMPPIX, ';

  strSQL := strSQL + '  " "        AS TEMSUB, ';
  strSQL := strSQL + '  " "        AS TEMEXP, ';
  strSQL := strSQL + '  " "        AS EXPTOT, ';
  strSQL := strSQL + '  " "        AS ORDPRO, ';
  strSQL := strSQL + '  " "        AS ITE_OP, ';

  strSQL := strSQL + '  IF(GER_ENTFUT = "S", "F", IF(GER_ENTFAT = "S", "E", "R")) AS ENTRET, ';
  strSQL := strSQL + '  IF(GER_ENTFUT = "S", "3", IF(GER_ENTFAT = "S", "2", "1")) AS IND_ENTRET, ';
  strSQL := strSQL + '  " "        AS ORIPED, ';
  strSQL := strSQL + fSQLBarDoc('MOVGER.GER') + ' AS BARDOC, ';
  strSQL := strSQL + '  " "        AS CLILOJ, ';
  strSQL := strSQL + '  " "        AS BARCOM, ';
  strSQL := strSQL + '  IFNULL(TRA.TRA_PRIEXP, 0) AS PRIEXP, ';
  strSQL := strSQL + '  IF(GER_DTENTR = "1899-12-30", CAST(NULL AS DATE), GER_DTENTR) AS DTENTR, ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(255)) AS TURENT ,';
  strSQL := strSQL + '  " "  AS CODTPA, ';
  strSQL := strSQL + '  " " AS LOCRET, ';
  strSQL := strSQL + '  "N" AS TEMDAV, ';
  strSQL := strSQL + '  "N" AS TEMITEESP, ';
  strSQL := strSQL + '  "N" AS TEMSER ';

  If (grbLocSep.Visible) Then
  Begin
    strSQL := strSQL + ', CAST(NULL AS CHAR(255)) AS CODLSE ';
    strSQL := strSQL + ', CAST(NULL AS CHAR(255)) AS LSEPEN ';
    strSQL := strSQL + ', CAST(NULL AS CHAR(255)) AS LSEPAR ';
    strSQL := strSQL + ', CAST(NULL AS CHAR(255)) AS LSELIB ';
  End;

  If lblLocArm.Visible Then
    strSQL := strSQL + ', CAST(NULL AS CHAR(255)) AS LCLAMZ ';

  If (fCfgSis('CADEMB', varBoolean)) Then
    strSQL := strSQL + ' ,AUXMOV.AUX_CODEMB AS CODEMB ';

  If (fVisualizarGuiche()) Then
    strSQL := strSQL + ', " " AS GUICHE ';

  If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean)) Then
    strSQL := strSQL + ', " " AS DESTPA ';

  If (fExibirTempoExpedicao) Then
  Begin
    strSQL := strSQL + ', 0  AS TMPEXP ';
    strSQL := strSQL + ', CAST(NULL AS CHAR(3)) AS EXPTOL ';
  End;

  if fCfgSis('BOXWMS', varBoolean) Then
    strSQL := strSQL + ', " " AS CODBOX ';

  strSQL := strSQL + ', " " AS FATTOT ';
  strSQL := strSQL + ', CAST("" AS CHAR(1)) AS TOTFAT ';
  strSQL := strSQL + ', " " AS PEDTRF ';
  strSQL := strSQL + ', " " AS REQCOM ';

  If fCfgSis('EXISTA', varBoolean) Then
  Begin
    strSQL := strSQL + ', CAST("" AS CHAR(30)) AS STATUS ';
    strSQL := strSQL + ', CAST("" AS CHAR(80)) AS FGO_STATUS ';
  End;

  strSQL := strSQL + ', MOVGER.GER_CLAFIS AS CLAFIS ';
  strSQL := strSQL + ',  0 AS TEMMOVGPV ';
  strSQL := strSQL + ', CAST("" AS CHAR(08)) AS ROMDOC ';
  strSQL := strSQL + ', CAST("" AS CHAR(50)) AS ROMDES ';
  strSQL := strSQL + ', "N" AS KIT ';
  strSQL := strSQL + ',  CAST("" AS CHAR(3)) AS KITEST ';
  strSQL := strSQL + ', IFNULL(AUX_ENFUOP, "1") AS ENFUOP ';
  strSQL := strSQL + ', " " AS ENVCON ';
  strSQL := strSQL + ', AUX_FRERAT AS FRERAT ';
  strSQL := strSQL + ', " " AS UTIRES ';
  strSQL := strSQL + ', 0   AS TAXJUR ';
  strSQL := strSQL + ', "N" AS ZERTAX ';
  strSQL := strSQL + ', CAST("" AS CHAR(3)) AS EPFTGE ';
  strSQL := strSQL + ', CAST("" AS CHAR(3)) AS SOLABA ';
  strSQL := strSQL + ', " " AS REGESP ';
  strSQL := strSQL + ', " " AS PEGOU_ ';
  strSQL := strSQL + ', "N" AS CORTE_ ';
  strSQL := strSQL + ', "N" AS FATAUT ';
  strSQL := strSQL + ', " " AS NFESTA ';
  strSQL := strSQL + ', " " AS NFEOBS ';
  strSQL := strSQL + ', "N" AS CRTFIL ';
  strSQL := strSQL + ',  MOVGER.GER_ESPECI AS ESPECI ';
  strSQL := strSQL + ', CAST(" " AS CHAR(30)) AS COTLAL';

  if ((fCfgSis('CONEQU') = 'S')) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
    strSQL := strSQL + ', " " AS NUMOSE ';

  strSQL := strSQL + ',  CAST( ';
  strSQL := strSQL + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_CODLAR SEPARATOR ", ") ';
  strSQL := strSQL + '        FROM MOVLAR ';
  strSQL := strSQL + '        LEFT JOIN CADLAR ON MOVLAR.LAM_CODLAR = CADLAR.AUTOINCREM ';
  strSQL := strSQL + '       WHERE MOVLAR.LAM_SEQGER = MOVGER.AUTOINCREM) ';
  strSQL := strSQL + '   AS CHAR(255)) AS CODLAR ';

  strSQL := strSQL + ',  CAST( ';
  strSQL := strSQL + '     (SELECT GROUP_CONCAT( DISTINCT CADLAR.LAR_DESLAR SEPARATOR ", ") ';
  strSQL := strSQL + '        FROM MOVLAR ';
  strSQL := strSQL + '        LEFT JOIN CADLAR ON MOVLAR.LAM_CODLAR = CADLAR.AUTOINCREM ';
  strSQL := strSQL + '       WHERE MOVLAR.LAM_SEQGER = MOVGER.AUTOINCREM) ';
  strSQL := strSQL + '   AS CHAR(255)) AS DESLAR ';

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    strSQL := strSQL + ', SUM(COALESCE(MOVTRI.DET_FRESUG, 0)) AS FRESUG ';
    strSQL := strSQL + ', SUM(COALESCE(MOVTRI.DET_FRECOT, 0)) AS FRECOT ';
  End;

  strSQL := strSQL + ', 0   AS DECZFM ';
  strSQL := strSQL + ', " " AS VENPRE ';

  strSQL := strSQL + ',  MOVGER.GER_NUMROM AS NUMROM ';
  strSQL := strSQL + ',  MOVGER.GER_EMPROM AS EMPROM ';
  strSQL := strSQL + ',  CAST("0.00" AS CHAR(10)) AS PERSEP ';
  strSQL := strSQL + ',  0.00 AS PERCOF ';
  strSQL := strSQL + ',  SUM(COALESCE(MOVTRI.DET_CUBAGE, 0)) AS CUBAGEM ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    strSQL := strSQL + ',  TRD.TRA_NOMTRA AS TRARDP ';

  strSQL := strSQL + ',  CAST(NULL AS DATETIME) AS DTDIEN ';
  strSQL := strSQL + ',  CAST(NULL AS DATETIME) AS DTLIEN ';
  strSQL := strSQL + ',  CAST(NULL AS DATETIME) AS DTCOAG ';

  strSQL := strSQL + ',  CADCLI.CLI_I_E_S_  AS INSEST ';

  If (fCfgSis('EXQTIT', varString) = 'S') Then
  Begin
    strSQL := strSQL + ', (SELECT  COUNT(DET_CODITE)               '+
                       '   FROM                                    '+
                       '     MOVDET MD                             '+
                       '   WHERE MD.DET_SEQGER = MOVGER.AUTOINCREM ) AS QTDSKU ';
  End;

  strSQL := strSQL + ', CAST(NULL AS CHAR(40)) AS NUMPOK ';
  strSQL := strSQL + ', "N" AS CANHUB ';
  strSQL := strSQL + ', "" AS STAHUB ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '  MOVGER ';

  If fCfgSis('EXPNFA', varBoolean) Then
    strSQL := strSQL + '  LEFT JOIN LOGNFE ON NFE_NUMDOC = MOVGER.GER_NUMDOC '+
            ' AND NFE_ESPDOC = MOVGER.GER_ESPDOC '+
            ' AND NFE_CODEMP = MOVGER.GER_CODEMP '+
            ' AND NFE_CODCLI = MOVGER.GER_CODCLI '+
            ' AND IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ';

  strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON GER_CODCLI = CLI_CODCLI  ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = ' + fSQLIFClienteConsumidor('CLI_NOMCLI', 'MOVGER.GER_CIDCON ', 'CLI_CODCID ');
  strSQL := strSQL + '  LEFT JOIN CADTRA TRA ON TRA_CODTRA = GER_CODTRA ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = GER_CODVEN ';
  strSQL := strSQL + '  LEFT JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADFPG ON FPG_CODIGO = GER_CODFPG ';

  strSQL := strSQL + '  LEFT JOIN CADREG ON CADREG.REG_CODREG = CADCLI.CLI_CODREG ';

  strSQL := strSQL + '  LEFT JOIN ENTCLI ECGOR ON ECGOR.AUTOINCREM = AUXMOV.AUX_ENTGER ';
  strSQL := strSQL + '  LEFT JOIN CADCID CIDENT ON CIDENT.CID_CODCID = ECGOR.ETC_CIDENT ';
  strSQL := strSQL + '  LEFT JOIN CADREG CADREG3 ON CADREG3.REG_CODREG = ECGOR.ETC_CODREG ';

  If (fCfgSis('UTTRDP', varBoolean)) Then
    strSQL := strSQL + '  LEFT JOIN CADTRA TRD ON AUXMOV.AUX_TRARDP = TRD.TRA_CODTRA ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  MOVGER.GER_NUMDOC NOT LIKE "F%" AND ';

  strSQL := strSQL + '  ('+ fRetSQLEspDocsNaoListadosNaExpedicao('MOVGER.GER_ESPDOC');
  If (fCfgSis('EESFAE') = 'S') Then
    strSQL := strSQL + '  OR (MOVGER.GER_ESPDOC = "EP" AND LEFT(MOVGER.GER_CLAFIS,1) >= "5")';
  strSQL := strSQL + '  ) AND ';

  strSQL := strSQL + '  (SELECT COUNT(0) FROM MOVDET INNER JOIN MOVGRC ON GRC_SEQDET = MOVDET.AUTOINCREM WHERE DET_SEQGER = MOVGER.AUTOINCREM '+IIF(fCfgSis('DCEXGA', varBoolean), ' AND DET_ESPDOC <> "GA"', '')+') = 0 AND ';
  strSQL := strSQL + '  MOVGER.GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  IFNULL(GER_ENTFUT,"N") = "N" AND ';

  strSQL := strSQL + fGetTipoDocumento('GER', 'MOVGER.');
  strSQL := strSQL + fRetSQLTemAoMenosUmItemNormal('MOVGER');

  strSQL := strSQL + '  AUX_OPCDOC <> "FC" AND ';

  If fCfgSis('CXAEXP') = '1' Then
    strSQL := strSQL + '  GER_DTLBRC IS NOT NULL AND '
  Else
    strSQL := strSQL + '  GER_DTLBRC IS NULL AND ';

  If fCfgSis('BAISEP', varBoolean) And (Not blnApenasConferenciaProdutosRetiraCaixa) Then
  Begin
    If blnApenasImprimirBaixarSeparacao Then
      strSQL := strSQL + '   AUX_OPBXSE IS NULL AND '
    Else
    Begin
      If blnUsaImpressaoSeparacaoPorLocal Then
        strSQL := strSQL + '   ((DET_QTDITE - DET_QTDEXP) - (DET_QTDITE - MOVTRI.DET_QTDSEP)) > 0 AND '
      Else  
        strSQL := strSQL + '   AUX_OPBXSE IS NOT NULL AND ';
    End;  
  End;

  If fCfgSis('EXPNFA', varBoolean) Then
    strSQL := strSQL + '  (NFE_STATUS = "AT" OR MOVGER.GER_ESPDOC = "FF") AND ';

  strSQL := strSQL + '  GER_DTLBEX IS NULL ';

  strSQL := strSQL + ' GROUP BY MOVGER.GER_NUMDOC, MOVGER.GER_ESPDOC, MOVGER.GER_SERIE_, MOVGER.GER_CODEMP, MOVGER.GER_CODCLI ';

  strSQL := 'SELECT * FROM ( '+strSQL+' ) AS VW_DOCFAT ';

  If Pos(VS_strExpRetiraEntregaDocFat, 'R_E_') > 0 Then
    strSQL := strSQL + ' WHERE ENTRET = '+QuotedStr(VS_strExpRetiraEntregaDocFat);

  {********************************************************}
  {*********************** ATENÇÃO ************************}
  {********************************************************}
  {*                                                      *}
  {* CASO VOCÊ MEXA NO SELECT ACIMA NÃO SE ESQUEÇA DO QUE *}
  {* ESTÁ ABAIXO FAZENDO UNION. DETALHE: ESSA FUNÇÃO É    *}
  {* USADA EM OUTROS LUGARES, ENTÃO, << PRESTA ATENÇÃO >> *}
  {*                                                      *}
  {*****************************************************AF*}
  If objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat Then
  Begin
    strSQL := strSQL + ' UNION ALL ' + fGetSQLPedidos(False, strTmpPedidosPendentes);
  End;

  {*******************************************************}
  {* ADICIONADO PARA MOSTRAR AS REPOSIÇÕES DE GARANTIA.  *}
  {****************************************************LS*}
  If (blnNfeXdf                              And
     (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO])) And
      fGetTipoDoctoSelecionado([GARANTIA, TODOS])) Then
  begin
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fGetSQLPedidosReposicao;
  end;

  strSQL := strSQL + 'ORDER BY DTAENT DESC, HORENT DESC ';

  qryQuery := fCriaQuery;
  Try
    Screen.Cursor := crHourGlass;
    Application.ProcessMessages;

    qryQuery.Close;
    qryQuery.SQL.Clear;
    qryQuery.SQL.Add(strSQL);
    qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryQuery.Open;

    pCriarClientDataSetPedidos(qryQuery);

    cdsPedidos.DisableControls;
    cdsPedidos.AfterScroll  := Nil;
    dtsPedidos.OnDataChange := Nil;
    pCarregaListaCodigos;
    Try
      pAtualizaLocaisSeparacao;
      pAtualizaNumeroRomaneio;
      pAtualizaDadosDocumentos;
    Finally
      FLisCodCid := '';
      FLisCodRot := '';
      FLisAutIncFgo := '';
      FLisAutIncGer := '';

      pLimparIndices;

      cdsPedidos.AfterScroll  := cdsPedidosAfterScroll;
      dtsPedidos.OnDataChange := pDataChange;
      cdsPedidos.EnableControls;
    End;

    Screen.Cursor := crDefault;

    pFormataDecimal(cdsPedidos,'VALDOC', 2);
    pFormataDecimal(cdsPedidos,'VLRCON', 2);
    pFormataDecimal(cdsPedidos,'PESBRU', 2);
    pFormataDecimal(cdsPedidos,'MINFAT', 2);

    If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
    Begin
      pFormataDecimal(cdsPedidos,'TOTFRE', 2);
      pFormataDecimal(cdsPedidos,'FRESUG', 2);
      pFormataDecimal(cdsPedidos,'FRECOT', 2);
    End;

    If (fGetCol('DOCUME') <> Nil) Then
      fGetCol('DOCUME').Title.Caption := 'Documento';
  Finally
    FreeAndNil(qryQuery);
  End;
end;

procedure TfrmFatExpedicao.pCarregaItensPageControls;
  Var
    intIdx: Integer;
begin
  If (tbsDuplicatas.TabVisible) And (pgcExpedicao.ActivePage = tbsDuplicatas) Then
  begin
    fMostraDuplicatasPedidoExp;
  end;

  If (tbsAdiantamentos.TabVisible) And (pgcExpedicao.ActivePage = tbsAdiantamentos) Then
  begin
    fMostraAdiantamentosPedidoExp;
  end;

  If (tbsPedidosVinculados.TabVisible) And (pgcExpedicao.ActivePage = tbsPedidosVinculados) Then
  Begin
    qryPedidosVinculados.Close;
    qryPedidosVinculados.ParamByName('SEQDMP').AsString := fField('SEQDMP').AsString;
    qryPedidosVinculados.ParamByName('AUTOINC').AsString := fField('AUTINC').AsString;
    qryPedidosVinculados.Open;

    For intIdx := 0 To qryPedidosVinculados.Fields.Count -1 Do
      If qryPedidosVinculados.Fields[intIdx].DataType = ftFloat Then
        TFloatField(qryPedidosVinculados.Fields[intIdx]).DisplayFormat := fMskDigitos(2);
  End;
end;

procedure TfrmFatExpedicao.pCarregaOpcoesLocais;
var blnPossuiOpcoesLocais: Boolean;
begin

  blnPossuiOpcoesLocais :=
     Not fEmptyStr(VS_strTipExpImpTipoDocumento+
     VS_strTipExpImpTipoMovimento+
     VS_strTipExpImpSituacaoFinanceira+

     VS_strTipExpTipoDocumento+
     VS_strTipExpTipoMovimento+
     VS_strTipExpSituacaoFinanceira+
     VS_strTipExpImpDeptoVendedor+
     VS_strTipExpDeptoVendedor+
     VS_strTipExpImpArmazem+
     VS_strTipExpUrgente+
     VS_strTipExpImpUrgente+
     VS_strTipExpRetiraExpedicao+
     VS_strTipExpRetiraBalcao+
     VS_strTipExpRetiraBalcao2);

  If blnApenasConferenciaProdutosRetiraCaixa Then
    blnPossuiOpcoesLocais := False;

  if blnPossuiOpcoesLocais then
  begin
    try
      if blnApenasImprimirBaixarSeparacao then
      begin
        if not fEmptyStr(VS_strTipExpImpTipoDocumento) then
          rdgTipoDocumento.itemIndex   := StrToInt(VS_strTipExpImpTipoDocumento)-1;
        if not fEmptyStr(VS_strTipExpImpTipoMovimento) then
          rdgTipoMov.itemIndex := StrToInt(VS_strTipExpImpTipoMovimento)-1;
        if not fEmptyStr(VS_strTipExpImpSituacaoFinanceira) then
          cmbSitFin.ItemIndex  := StrToInt(VS_strTipExpImpSituacaoFinanceira)-1;
        if (grbLocSep.Visible) and (not fEmptyStr(VS_strTipExpImpArmazem)) then
          cmbLocSep.ItemIndex  := cmbLocSep.Items.IndexOf(fCampoTabela('AMZ_DESCRI','CADAMZ',['AMZ_CODAMZ'],[VS_strTipExpImpArmazem]));
        If Not fEmptyStr(VS_strTipExpImpUrgente) Then
          strUrgente := VS_strTipExpImpUrgente;

        if not fEmptyStr(VS_strTipExpImpDeptoVendedor) then
        begin
          SetLength(arrDepVen,1);
          arrDepVen[0].strCodigo := VS_strTipExpImpDeptoVendedor;
          arrDepVen[0].strDescri := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[VS_strTipExpImpDeptoVendedor]);
        end;

        pMarcaFiltroLocalRetiraConformeArquivoIniLocal;
      end
      else
      begin
        if not fEmptyStr(VS_strTipExpTipoDocumento) then
          rdgTipoDocumento.itemIndex   := StrToInt(VS_strTipExpTipoDocumento)-1;
        if not fEmptyStr(VS_strTipExpTipoMovimento) then
          rdgTipoMov.itemIndex := StrToInt(VS_strTipExpTipoMovimento)-1;
        if not fEmptyStr(VS_strTipExpSituacaoFinanceira) then
          cmbSitFin.ItemIndex  := StrToInt(VS_strTipExpSituacaoFinanceira)-1;
        If Not fEmptyStr(VS_strTipExpUrgente) Then
          strUrgente := VS_strTipExpUrgente;

        if not fEmptyStr(VS_strTipExpDeptoVendedor) then
        begin
          SetLength(arrDepVen,1);
          arrDepVen[0].strCodigo := VS_strTipExpDeptoVendedor;
          arrDepVen[0].strDescri := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[VS_strTipExpDeptoVendedor]);
        end;

        pMarcaFiltroLocalRetiraConformeArquivoIniLocal;
      end;
    except
    end;
  end;

end;

procedure TfrmFatExpedicao.btnCfgExpClick(Sender: TObject);
begin

  inherited;

  If fCfgSis('ONDASE', VarBoolean) And (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
    pLimparVariaveisSeparadorConferenteOndaSeparacao;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  pCriarFormularios(TfrmConfigExpedicao, frmConfigExpedicao);
  frmConfigExpedicao.frmFatExpedicao := Self;
  frmConfigExpedicao.arrVendedor     := arrVendedor;
  frmConfigExpedicao.arrDepVen       := arrDepVen;

  If Not fVerificaAcessoSistema('EXBCEX') Then
  Begin
    frmConfigExpedicao.pgcCfgExp.Pages[0].TabVisible := False;
    frmConfigExpedicao.pgcCfgExp.Pages[1].TabVisible := False;
    frmConfigExpedicao.pgcCfgExp.Pages[4].TabVisible := False;
    frmConfigExpedicao.pgcCfgExp.Pages[5].TabVisible := False;
    frmConfigExpedicao.btnPadroes.Visible := False;
  End;

  Try
    frmConfigExpedicao.frmFatExpedicao := Self;
    frmConfigExpedicao.ShowModal;
    If (frmConfigExpedicao.blnConfirma) Then
    begin
      TFrmGravando.fExecutarModal( pGravarConfiguracoesExpedicao, 'Aguarde... Gravando Configurações!', '');
      dbgPedidos.Font.Size    := frmConfigExpedicao.speTamanhoFonteConfigExpedicao.Value;
    end;
  Finally
    pFreeAndNil(frmConfigExpedicao);
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnCliObsClick(Sender: TObject);
var
  qryQuery: TUniQuery;
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If (btnCliObs.Visible) And (btnCliObs.Enabled) Then
  Begin
    Try
      qryQuery := fCriaQuery(Self);
      With qryQuery Do
      Begin
        SQL.Clear;
        SQL.Add(' SELECT ');
        SQL.Add('   CLI_OBSERV ');
        SQL.Add(' FROM CADCLI ');
        SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
        ParamByName('CODCLI').AsString := fField('CODCLI').AsString;
        Open;

        If (Not FieldByName('CLI_OBSERV').IsNull) And (FieldByName('CLI_OBSERV').AsString <> '') Then
        Begin
          Try
            pCriarFormularios(TfrmFatMostraObsCliente, frmFatMostraObsCliente);
            frmFatMostraObsCliente.memObserv.Texto := FieldByName('CLI_OBSERV').AsString;
            frmFatMostraObsCliente.strCodCli       := fField('CODCLI').AsString;
            frmFatMostraObsCliente.btnAlterar.Visible := False;
            frmFatMostraObsCliente.showModal;
          Except
            On E: Exception Do
              pMensagensErro(E.Message, '[btnObsCliClick]');
          End;
          pFreeAndNil(frmFatMostraObsCliente);
        End
        Else
          fMensagem('Informação', 'Nenhuma observação encontrada para este cliente', ['&OK']);
      End;
    Finally
      FreeAndNil(qryQuery);
    End;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnConfirmaClick(Sender: TObject);
begin
  if not fVerificaAcessoSistema('EXF10P') then
    Exit;

  inherited;

  strBotaoAcionado := 'F10';
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If blnApenasConferenciaProdutosRetiraCaixa Then
    pExpedirPedidos(TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)
  Else If objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat Then
    pExpedirPedidos(TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)
  Else
    pExpedirPedidos(VS_strTipExp, False, '', btnFaturarExpedidos.Visible);
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnConfirmaCuponsClick(Sender: TObject);
begin
  inherited;
  If fVerificaAcessoSistema('IMPCF8') Then
  Begin
    pCriarFormularios(TfrmRcxConfCupom, frmRcxConfCupom);
    Try
      frmRcxConfCupom.strOpeCai := strLoginUsuarioLogado;
      If Not frmRcxConfCupom.fCriaTemporaria Then
        fMensagem('', 'Não foi encontrado nenhum documento para emissão de Cupom Fiscal!', ['&Ok'])
      Else
        frmRcxConfCupom.showModal;
    Finally
      pFreeAndNil( frmRcxConfCupom );
    End;
  End
  Else
    fMensagem('', 'Você não tem direitos para acessar a confirmação de cupons!', ['&Ok']);
end;

procedure TfrmFatExpedicao.btnConPedPenClick(Sender: TObject);
begin

  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not btnConPedPen.Visible Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(193, 7488, [7489],
                        ['CODCLI'],
                        [fField('CODCLI').AsString],
                        Sender,
                        nil,
                        True);
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);

end;

procedure TfrmFatExpedicao.btnConsProdutoClick(Sender: TObject);
  Var
    qryConGen: TUniQuery;
    chrKey : Char;
    arrSel : TConsultasArray;
    blnMostraSaldo : Boolean;
    objfrmPnl      : TPanelCxItem;
begin
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  objfrmPnl := TPanelCxItem.New();

  blnMostraSaldo := fCfgSis('EXISEE', varBoolean);
  chrKey    := '/';
  qryConGen := fCriaQuery;
  Try
    fPesqItem(conIteSimples,
              Self,
              nil,
              nil,
              qryConGen,
              chrKey,
              arrSel,
              True,
              objfrmPnl,
              'Consulta de Itens',
              '1',
              '',
              0,
              False,
              False,
              0,
              cdrCodIte,
              '',
              False,
              '',
              '',
              False,
              False,
              True,
              '',
              False,
              False,
              False,
              False,
              False,
              False,
              False,
              False,
              '',
              -1,
              True,
              '',
              blnMostraSaldo);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatExpedicao.btnConsProdutoClick]');
      pAtivaDesativaTimersNotificaoAndRecarga(True);
    End;
  End;
  FreeAndNil(objfrmPnl);
  FreeAndNil(qryConGen);
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnConsultaPedClick(Sender: TObject);
var
  frmConsultaPedidos: TfrmConsultaPedidos;
begin
  inherited;

  if not btnConsultaPed.Visible then
    Exit;

  if not btnConsultaPed.Enabled then
    Exit;

  if not Assigned(cdsPedidos) then
    Exit;

  if not cdsPedidos.Active then
    Exit;

  if cdsPedidos.RecordCount <= 0 then
    Exit;

  if cdsPedidos.RecNo <= 0 then
    Exit;

  pCriarFormularios(TfrmConsultaPedidos, frmConsultaPedidos);

  try
    frmConsultaPedidos.edtNumPed.Text := cdsPedidos.FieldByName('NUMDOC').AsString;
    frmConsultaPedidos.edtCodEmp.Text := cdsPedidos.FieldByName('CODEMP').AsString;
    frmConsultaPedidos.blnChamouPelaExpedicao := True;

    frmConsultaPedidos.ShowModal;
  finally
    pFreeAndNil(frmConsultaPedidos);
  end;

end;

procedure TfrmFatExpedicao.pAtualizarSelecao;
Var
  Key: Word;
begin
  Key   := VK_RETURN;
  blnF3 := True;
  dbgPedidosKeyDown(dbgPedidos, Key, []);

  pLimparSelecaoTotalmente;
end;

procedure TfrmFatExpedicao.btnCortarProdutosPedidoClick(Sender: TObject);
var
  frmFatCortarPedido: TfrmFatCortarPedido;
  LfrmGravando: TfrmGravando;
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If (Not cdsPedidos.Active) Or (cdsPedidos.IsEmpty) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if not (fVerificaAcessoSistema('CORFAT')) then
  begin
    fMensagem('', 'Você não tem direitos para acessar o corte de '+strDescDoc+'s!', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  end;

  If (stlPedidos.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um '+strDescDoc+'.', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If (stlPedidos.Count > 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'Somente um '+strDescDoc+' pode ser cortado por vez.', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if not cdsPedidos.Locate('AUTINC', stlPedidos.Strings[0], []) then
  begin
    fMensagem('ATENÇÃO!', 'Não foi possível localizar o '+strDescDoc+' selecionado!', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  end;

  If (fField('CODEMP').AsString <> VS_strCodEmp) Then
  begin
    fMensagem('PEDIDO: ' + fField('NUMDOC').AsString + '-' + fField('CODEMP').AsString,
              'Este pedido foi gerado por outra Empresa, não é possível ser alterado! ' +
              'Favor entrar em contado com a Empresa que originou o pedido e solicitar alteração.', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  end;

  pCriarFormularios(TfrmFatCortarPedido, frmFatCortarPedido);
  Try
    frmFatCortarPedido.strNumPed    := fField('NUMDOC').AsString;
    frmFatCortarPedido.strEspPed    := fField('ESPDOC').AsString;
    frmFatCortarPedido.strEmpPed    := fField('CODEMP').AsString;

    frmFatCortarPedido.ShowModal();

    If (frmFatCortarPedido.blnSucesso) Then
    Begin
      Try
        fMensagem('AVISO!', 'Corte realizado com sucesso!', ['&Ok']);

        pAtualizarSelecao;

        pCriarFormularios(TfrmGravando, LfrmGravando);
        try
          LfrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
        Finally
          pFreeAndNil(LfrmGravando);
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmFatExpedicao.btnCortarProdutosPedidoClick]');
      End;
    End
    Else
    Begin
      pAtualizarSelecao;
      if not frmFatCortarPedido.blnApresentouMensagem then
        fMensagem('AVISO!', 'Corte não foi concluído!', ['&Ok']);
    End;

  Finally
    pFreeAndNil(frmFatCortarPedido);
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnDefinirSeparadorConferenteClick(Sender: TObject);
var
  frmFatDigSepConferente: TfrmFatDigSepConferente;
  blnPodeAlterarSeparador: Boolean;
  blnPodeAlterarConferente: Boolean;
  blnReplicarParaTodosPedidosDaOnda: Boolean;
  fltQtdSep, fltQtdCnf: Double;
  qryUpdate: TUniQuery;
begin
  inherited;

  if fCfgSis('SEPCON', VarBoolean) then
  begin
    pGetQuantSepConfOnda(cdsPedidos.FieldByName('AUTINC').AsString, fltQtdSep, fltQtdCnf);

    blnPodeAlterarSeparador  := (fltQtdSep = 0);
    blnPodeAlterarConferente := (fltQtdCnf = 0);

    if (not blnPodeAlterarSeparador) and (not blnPodeAlterarConferente) then
    begin
      pMensagemOK('Não é possível alterar este documento!');
      Exit;
    end;
  end
  else
  begin
    blnPodeAlterarSeparador := True;
    blnPodeAlterarConferente := True;
  end;

  pCriarFormularios(TfrmFatDigSepConferente, frmFatDigSepConferente);
  try
    frmFatDigSepConferente.Coletor := True;
    frmFatDigSepConferente.ConferenteSenha := not fCfgSis('SEPCON', VarBoolean);

    frmFatDigSepConferente.edtCodSeparador.Enabled := blnPodeAlterarSeparador;
    frmFatDigSepConferente.edtNomSeparador.Enabled := blnPodeAlterarSeparador;
    if (not blnPodeAlterarSeparador) then
      pMensagemOK('Este documento já está em separação, não é possível alterar o separador!');

    frmFatDigSepConferente.edtSenhaConferente.Enabled := blnPodeAlterarConferente;
    frmFatDigSepConferente.edtNomConferente.Enabled   := blnPodeAlterarConferente;
    if (not blnPodeAlterarConferente) then
      pMensagemOK('Este documento já está em conferência, não é possível alterar o conferente!');

    frmFatDigSepConferente.ShowModal;
    if (frmFatDigSepConferente.blnConfirma) then
    begin
      blnReplicarParaTodosPedidosDaOnda := False;
      If (Not fEmptyStr(cdsPedidos.FieldByName('SEQSEP').AsString)) Then
      Begin
        blnReplicarParaTodosPedidosDaOnda :=
          fPergunta('O Pedido pertence a Onda de Separação '+ cdsPedidos.FieldByName('SEQSEP').AsString +'.'+ sLineBreak +
                    'Deseja replicar para todos os Pedidos da Onda?', False);
      End;

      If blnReplicarParaTodosPedidosDaOnda And fCfgSis('SEPCON', varBoolean) Then
      Begin
        If Not fValidaQuantSepConfOnda(cdsPedidos.FieldByName('SEQSEP').AsString, blnPodeAlterarSeparador, blnPodeAlterarConferente) Then
          Exit;
      End;

      qryUpdate := fCriaQuery;
      Try
        qryUpdate.SQL.Add('SELECT FGO_SEQFGO,');
        qryUpdate.SQL.Add('       FGO_SEPEXP,');
        qryUpdate.SQL.Add('       FGO_OPEEXP,');
        qryUpdate.SQL.Add('       FGO_ENTURG');
        qryUpdate.SQL.Add('  FROM EXTGOR');

        If blnReplicarParaTodosPedidosDaOnda Then
        Begin
          qryUpdate.SQL.Add(' WHERE FGO_SEQSEP = :SEQSEP');
          qryUpdate.ParamByName('SEQSEP').AsString := cdsPedidos.FieldByName('SEQSEP').AsString;
        End
        Else
        Begin
          qryUpdate.SQL.Add(' WHERE FGO_SEQFGO = :AUTINC');
          qryUpdate.ParamByName('AUTINC').AsString := cdsPedidos.FieldByName('AUTINC').AsString;
        End;

        qryUpdate.Open;

        qryUpdate.First;
        While Not qryUpdate.Eof Do
        Begin
          qryUpdate.Edit;

          fltQtdSep := 0;
          fltQtdCnf := 0;

          if fCfgSis('SEPCON', varBoolean) then
            pGetQuantSepConfOnda(qryUpdate.FieldByName('FGO_SEQFGO').AsString, fltQtdSep, fltQtdCnf)
          else
          begin
            qryUpdate.FieldByName('FGO_SEPEXP').Clear;
            qryUpdate.FieldByName('FGO_OPEEXP').Clear;
          end;

          if blnPodeAlterarSeparador and (fltQtdSep = 0) and (not fEmptyStr(frmFatDigSepConferente.edtCodSeparador.Text)) then
            qryUpdate.FieldByName('FGO_SEPEXP').AsString := frmFatDigSepConferente.edtCodSeparador.Text;

          if blnPodeAlterarConferente and (fltQtdCnf = 0) and (not fEmptyStr(frmFatDigSepConferente.strCodConferente)) then
            qryUpdate.FieldByName('FGO_OPEEXP').AsString := frmFatDigSepConferente.strCodConferente;

          If fCfgSis('URGOPE', varBoolean) Then
          Begin
            If (qryUpdate.FieldByName('FGO_ENTURG').AsString <> 'S') Then
            Begin
              if qryUpdate.FieldByName('FGO_OPEEXP').IsNull and qryUpdate.FieldByName('FGO_SEPEXP').IsNull then
                qryUpdate.FieldByName('FGO_ENTURG').AsString := 'N'
              else
                qryUpdate.FieldByName('FGO_ENTURG').AsString := 'S';
            End;
          End;

          qryUpdate.Post;
          qryUpdate.Next;
        End;

        pMensagemOK('Dados alterados com sucesso!');

      Finally
        FreeAndNil(qryUpdate);
        pAtualizarGrid();
      End;
    end;
  finally
    pFreeAndNil(frmFatDigSepConferente);
  end;
end;

procedure TfrmFatExpedicao.btnDesmembrarPedClick(Sender: TObject);
begin
  inherited;
  pDesmembrarPedido;
end;

procedure TfrmFatExpedicao.btnDesmExpedidosClick(Sender: TObject);
  Var
    frmFatDesmembrarPedido : TfrmFatDesmembrarPedido;
    blnNenhumProdutoConferido : Boolean;
    blnAbrirDesmembramento : Boolean;
    blnPermiteApenasGerarRequisicaoParaItensSemEstoque : Boolean;
    
  function fDetalharPedido: String; begin
    Result := 'PEDIDO: ' + fField('NUMDOC').AsString + '-' + fField('CODEMP').AsString;
  end;

  function fDetalharMensagem(intOpcao: Integer): String; begin
    Case (intOpcao) Of

      1: begin
           Result := 'Este pedido não tem nenhum produto conferido. ' +
                     'O desmembramento de pedido somente é aplicado ' +
                     'em documentos com alguns itens conferidos, pois a ' +
                     'rotina mantém no pedido original os itens conferidos ' +
                     'e cria um novo pedido com os itens não conferidos.';
         end;

      2: begin
           Result := 'Este pedido possui todos os produtos conferidos. ' +
                     'O desmembramento de pedido somente é aplicado em ' +
                     'documentos com alguns itens conferidos, pois a rotina ' +
                     'mantém no pedido original os itens conferidos e cria um ' +
                     'novo pedido com os itens não conferidos.';
         end;

      3: begin
           If (fPedidoRegimeEspecial) Then
           Begin
             Result := 'Este pedido possui alguns produtos conferidos. ' +
                       'O desmembramento gerará dois novos pedidos ' +
                       'um com os itens conferidos outro com os itens ' +
                       'não conferidos.';
           End
           Else
           Begin
             Result := 'Este pedido possui alguns produtos conferidos. ' +
                       'O desmembramento de pedido manterá no pedido ' +
                       'original os itens conferidos e criará um novo ' +
                       'pedido com os itens não conferidos.';
           End;
         end;

      Else
        Result := '';
    End;
  end;

  procedure pAtualizaPedido;
    Var
      strSQL: String;
      qryUpd: TUniQuery;
  begin
    strSQL := '';
    strSQL := strSQL + 'UPDATE     ';
    strSQL := strSQL + '  EXTGOR E ';
    strSQL := strSQL + '  INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '   E.FGO_DTLBEX = :DTLBEX  ';
    strSQL := strSQL + '  ,E.FGO_HRLBEX = :HRLBEX  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI     ';

    qryUpd := fCriaQuery(Self);

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTLBEX').AsDate   := VS_Date;
      ParamByName('HRLBEX').AsTime   := fTime();
      ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
      ParamByName('CODCLI').AsString := fField('CODCLI').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryUpd);
  End;

begin
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If (Not fValidaPedidoParaDesmembramento(False)) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  blnAbrirDesmembramento := False;
  blnPermiteApenasGerarRequisicaoParaItensSemEstoque := False;
  blnNenhumProdutoConferido := (fField('TEMEXP').AsString = 'N') And (fField('EXPTOT').AsString = 'N');

  If (blnNenhumProdutoConferido) And (fPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
  Begin
    blnAbrirDesmembramento := True;
    blnPermiteApenasGerarRequisicaoParaItensSemEstoque := True;
    fMensagem(fDetalharPedido(), 'Este pedido não tem nenhum produto conferido. Será permitido apenas gerar requisição de compra para os itens sem estoque.', ['&OK']);
  End;

  If (blnNenhumProdutoConferido) And (Not fPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
  Begin
    //CASO O PEDIDO NÃO TENHA NENHUM ITEM EXPEDIDO

    fMensagem(fDetalharPedido(), fDetalharMensagem(1), ['&OK']);

    pAtualizarSelecao();
  End
  Else If (fField('TEMEXP').AsString = 'N') And (fField('EXPTOT').AsString = 'S') Then
  Begin
    //CASO O PEDIDO TENHA TODOS OS ITENS EXPEDIDOS TOTALMENTE

    fMensagem(fDetalharPedido(), fDetalharMensagem(2), ['&OK']);

    pAtualizarSelecao();
  End
  Else If (fField('TEMEXP').AsString = 'S') And (fField('EXPTOT').AsString = 'N') Then
  Begin
    //CASO O PEDIDO TENHA ITENS EXPEDIDOS PARCIALMENTE
    blnAbrirDesmembramento := True;
    fMensagem(fDetalharPedido(), fDetalharMensagem(3), ['&OK']);
  End;

  If (blnAbrirDesmembramento) Then
  Begin
    Try
      pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedido);
      frmFatDesmembrarPedido.strNumPed    := fField('NUMDOC').AsString;
      frmFatDesmembrarPedido.strEspPed    := fField('ESPDOC').AsString;
      frmFatDesmembrarPedido.strEmpPed    := fField('CODEMP').AsString;
      frmFatDesmembrarPedido.blnPedidoRegimeEspecial := fPedidoRegimeEspecial();
      If (Not blnPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
        frmFatDesmembrarPedido.arrIteExpPed := fCriarArrItensExpedidosPedido(stlPedidos.Strings[0]);
      frmFatDesmembrarPedido.blnExpedicao := True;
      frmFatDesmembrarPedido.blnPermiteApenasGerarRequisicaoParaItensSemEstoque := blnPermiteApenasGerarRequisicaoParaItensSemEstoque;

      If (Length(frmFatDesmembrarPedido.arrIteExpPed) = 0) And (Not blnPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
      Begin
        pAtualizarSelecao();
        fMensagem('AVISO!', 'Nenhum item para desmembramento foi encontrado. Operação cancelada!', ['&Ok']);
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;

      frmFatDesmembrarPedido.ShowModal();

      If (frmFatDesmembrarPedido.blnDesmembrou) Then
      Begin
        Try
          pAtualizaPedido();
          pAtualizarSelecao();
          fMensagem('AVISO!', 'Desmembramento realizado com sucesso!', ['&OK']);
          TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[TfrmFatExpedicao.btnDesmExpedidosClick]');
        End;
      End
      Else If (Not blnPermiteApenasGerarRequisicaoParaItensSemEstoque) Then
      Begin
        pAtualizarSelecao();
        fMensagem('AVISO!', 'Desmembramento não foi concluído!', ['&Ok']);
      End
      Else
        pAtualizarSelecao();

    Finally
      pFreeAndNil(frmFatDesmembrarPedido);
    End;
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

function TfrmFatExpedicao.fPermiteApenasGerarRequisicaoParaItensSemEstoque: Boolean;
  Var
    strOpcoesDesmembramentoF1 : String;
begin
  Result := False;
  If (fCfgSis('DEREEX', varString) = 'N') Then
    Exit;
  strOpcoesDesmembramentoF1 := fCfgSis('DMPOPC', varString);
  If (Length(strOpcoesDesmembramentoF1) >= 3) Then
  Begin
    If (Copy(strOpcoesDesmembramentoF1, 3, 1) = 'S') Then
      Exit(True);
  End;
end;

procedure TfrmFatExpedicao.btnEntFutCDClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not btnEntFutCD.Visible Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If Not TfrmFatEmitirEntFutEmpCD.fTemPedidosEntFuturaParaFaturarEmpCD Then
  Begin
    pMensagemOk('Não existem pedidos de entrega futura pelo CD para serem faturados!');
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  If Not fVerificaAcessoSistema('DIRRCXPEF', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Entrega Futura pelo CD');

    objLiberacao.strDirAce := 'DIRRCXPEF';
    objLiberacao.strMsgSen := 'Ent. Futura CD';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    If (Not objLiberacao.fLibera) Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Exit;
    End;
  End;

  pCriarForm(TfrmFatEmitirEntFutEmpCD, frmFatEmitirEntFutEmpCD);
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnExibirProdutosClick(Sender: TObject);
var
  dtsExibeProd: TDataSource;
  qryExibeProd: TUniQuery;
  frmFatVerItensDocRom: TfrmFatVerItensDocRom;
begin
  inherited;
  if not btnExibirProdutos.Visible then
    Exit;

  try
    qryExibeProd := fCriaQuery();
    dtsExibeProd := fCriaDataSource(qryExibeProd);
    try
      qryExibeProd.SQL.Add('SELECT FDO_CODITE AS CODITE, ');
      qryExibeProd.SQL.Add('       FDO_DESCRI AS DESITE, ');
      qryExibeProd.SQL.Add('       FDO_UNIDAD AS UNIDAD, ');
      qryExibeProd.SQL.Add('       FDO_NUMLOT AS NUMLOT, ');
      qryExibeProd.SQL.Add('       FDO_QTDITE AS QTDITE, ');
      qryExibeProd.SQL.Add('       FDO_QTDITE - FDO_QTDBAI AS QTDFAT, ');
      qryExibeProd.SQL.Add('       G.ITE_SALDOS + ' + fSQL_SOMA_ENTFUT + ' AS SALDOS ');
      qryExibeProd.SQL.Add('  FROM FATDOR ');
      qryExibeProd.SQL.Add(' INNER JOIN ITEGER G ON G.ITE_CODITE = FDO_CODITE ');
      qryExibeProd.SQL.Add('                    AND G.ITE_CODEMP = IF(IFNULL(FDO_EMPITE,"") = "", FDO_CODEMP, FDO_EMPITE) ');
      qryExibeProd.SQL.Add('WHERE ');
      qryExibeProd.SQL.Add('  FDO_SEQGER = :SEQGER ');

      qryExibeProd.ParamByName('SEQGER').AsString := cdsPedidos.FieldByName('AUTINC').AsString;

      qryExibeProd.Open;

      (qryExibeProd.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(FDecQtd);
      (qryExibeProd.FieldByName('QTDFAT') As TFloatField).DisplayFormat := fMskDigitos(FDecQtd);

      pCriarFormularios(TfrmFatVerItensDocRom, frmFatVerItensDocRom);
      try
        frmFatVerItensDocRom.blnItensPedidoExpedicao := True;
        frmFatVerItensDocRom.pConfiguraGridItensPedido;
        frmFatVerItensDocRom.dbgItens.DataSource := dtsExibeProd;
        frmFatVerItensDocRom.ShowModal;
      finally
        pFreeAndNil(frmFatVerItensDocRom);
      end;
    finally
      FreeAndNil(dtsExibeProd);
      FreeAndNil(qryExibeProd);
    end;
  except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatExpedicao.btnExibirProdutosClick]');
  end;
end;

procedure TfrmFatExpedicao.btnExpedicaoClick(Sender: TObject);
begin

  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
    popExpedicao.Popup(X, Y);

end;

procedure TfrmFatExpedicao.btnExpFatAutTodosClick(Sender: TObject);
begin
  inherited;
  If btnExpFatAutTodos.Visible And btnExpFatAutTodos.Enabled Then
  Try
    pAtivaDesativaTimersNotificaoAndRecarga(False);
    TfrmGravando.fExecutarModalA(pExpedirFaturarTodosPedidosAutomaticamente,
      'Faturando todos os pedidos automáticamente ...', '');
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    pLimparVariaveisSeparadorConferenteOndaSeparacao;
  End;
end;

function TfrmFatExpedicao.fTemPedidoSelecionadoComVidros: Boolean;
begin
  Result := False;

  If Not fCfgSis('VENVID', varBoolean) Then
    Exit;

  pDisableControlsInterna;
  With cdsPedidos Do
  Begin
    First;
    Filtered := False;
    While Not Eof Do
    Begin
      If fSelecionado(cdsPedidos) And fTemVidro(fField('NUMDOC').AsString,
                                                fField('ESPDOC').AsString,
                                                fField('CODEMP').AsString) Then
      Begin
        fMensagem('','Documento com vidros deve ser faturado pela venda normal!' + #13#10 +
                     fField('NUMDOC').AsString + '-' +
                     fField('ESPDOC').AsString + '-' +
                     fField('CODEMP').AsString,['&OK']);
        Result := True;
        Break;
      End;
      Next;
    End;
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
    pEnableControlsInterna;
  End;
end;

function TfrmFatExpedicao.fTemPedidoSelecionadoComFormaNegociada: Boolean;
begin
  Result := False;

  pDisableControlsInterna;
  cdsPedidos.First;
  try
    cdsPedidos.Filtered := False;
    While Not cdsPedidos.Eof Do
    Begin
      If fSelecionado(cdsPedidos) And (not fValidaFormaNegociada(fField('NUMDOC').AsString,
                                                                 fField('ESPDOC').AsString,
                                                                 fField('CODEMP').AsString,
                                                                 fField('CODFPG').AsString,
                                                                 fField('VALADT_FATAUT').AsFloat,
                                                                 True)) then
      Begin
        fMensagem('','Documento possui formas de pagamento negociadas e deve ser faturado pelo F11 do Resumo de Caixa!' + #13#10 +
                     fField('NUMDOC').AsString + '-' +
                     fField('ESPDOC').AsString + '-' +
                     fField('CODEMP').AsString,['&OK']);
        Result := True;
        Break;
      End;
      cdsPedidos.Next;
    End;
  finally
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
    pEnableControlsInterna;
  end;
end;

function TfrmFatExpedicao.fTemPedidoSelecionadoLibSep: Boolean;
begin
  Result := False;

  If fRotasPorRegiaoExpedicaoPedido4 Then
  Begin
    With cdsPedidos Do
    Begin
      If (stlPedidos.Count = 0) And (fPermiteSelecionarPedidoAtual(True)) Then
      Begin
        If (fField('VLRMIN').AsFloat > fField('VRROTA').AsFloat) And
           (fField('LIBSEP').AsString = 'N') Then
        Begin
          fMensagem('','Não é permitido imprimir a Separação do Pedido: ' +
                        fField('NUMDOC').AsString + '-' +
                        fField('ESPDOC').AsString + '-' +
                        fField('CODEMP').AsString + ' ' +#13+
                        'A rota do mesmo não atingiu a valor mínimo para entrega.', ['&OK']);
          Result := True;
        End;
      End
      Else
      Begin
        First;
        DisableControls;
        Filtered := False;
        While Not Eof Do
        Begin
          If (fSelecionado(cdsPedidos)) And
             (fField('VLRMIN').AsFloat > fField('VRROTA').AsFloat) And
             (fField('LIBSEP').AsString = 'N') Then
          Begin
            fMensagem('','Não é permitido imprimir a Separação do Pedido: ' +
                         fField('NUMDOC').AsString + '-' +
                         fField('ESPDOC').AsString + '-' +
                         fField('CODEMP').AsString + ' ' +#13+
                         'A rota do mesmo não atingiu a valor mínimo para entrega.', ['&OK']);
            Result := True;
            Break;
          End;
          Next;
        End;
        pFiltrarPedidos;
        pCalculaResumoTotalDocumentos();
        EnableControls;
      End;
    End;
  End;
end;

function TfrmFatExpedicao.fTodosLocSepLiberados(strIncGer, strEspDoc: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  Try
    Result  := False;

    qryGen := fCriaQuery(Nil);
    Try
      qryGen.SQL.Clear();

      qryGen.SQL.Text := 'SELECT ' +
                          '  SUM(FDO_QTDITE - IFNULL(FDO_QTDSEP, 0)) AS QTDSEP ' +
                          'FROM ' +
                          '  FATDOR INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
                          'WHERE FATDOR.FDO_SEQGER = :INCGER ';

      If (strEspDoc = 'PD') And fCfgSis('BAISEP', varBoolean) And blnApenasImprimirBaixarSeparacao And fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
      Begin
        qryGen.SQL.Add('  AND EXTDOR.FDO_EXIBSE = "S" ');
        //Req 151661, se ja pegou entao ja definiu o lote no pedido nao precisa separar
        qryGen.SQL.Add('  AND ( ');
        qryGen.SQL.Add('    IFNULL(EXTDOR.FDO_PEGOU_, "N") <> "S" ');
        qryGen.SQL.Add('    OR IFNULL(FATDOR.FDO_NUMLOT, "A DEFINIR") = "A DEFINIR" ');
        qryGen.SQL.Add('  ) ');
      End;

      If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
        If fCfgSis('EMPFAT', VarBoolean) And (strEspDoc = 'PD') Then
          qryGen.SQL.Add('  AND FDO_EMPITE = "' + VS_strCodEmp + '" ');

      If (strEspDoc <> 'PD') Then
      Begin
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FATDOR', 'MOVDET');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'EXTDOR', 'MOVTRI');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FDO_SEQFDO', 'DET_SEQGER');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FDO_', 'DET_');
      End;

      qryGen.ParamByName('INCGER').AsString := strIncGer;
      qryGen.Open();

      Result := (qryGen.FieldByName('QTDSEP').AsFloat = 0);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpedicao.fTodosLocSepLiberados]');
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatExpedicao.fTravaExpedicaoClienteInativo: Boolean;
begin
  Result := (fCfgSis('TRCSEX', varString) = 'S') And (Not fRetStatusCliente(fField('CODCLI').AsString));

  If Result Then
  Begin
    If (fCfgSis('INVNDC', varBoolean)) Then
    Begin
      If fPermiteCondPagtoClienteInativo(fField('CODCND').AsString, fField('CODFPG').AsString) Then
      Begin
        Result := False;
      End;
    End;
  End;
end;

function TfrmFatExpedicao.fTravaSelecaoPedidoQuantidade(
  stlPedidoQtd: TStringList; strNumDoc, strEspDoc, strCodEmp: String): Boolean;
var
  intTotalPedidoPermitido: Integer;
  intTotalProdutoPermitido: Integer;
  strAutIncPed: String;
  strListaPedidos: String;
  strAutIncSelecionado: String;
begin
  Result := True;

  intTotalPedidoPermitido := fCfgSis('QMPEDE', varInteger);
  intTotalProdutoPermitido := fCfgSis('QMITEE', varInteger);

  if intTotalPedidoPermitido < 1 then
    Exit(False);

  if intTotalProdutoPermitido < 1 then
    Exit(False);

  if stlPedidoQtd.Count + 1 > intTotalPedidoPermitido then
  Begin
    fMensagem('ATENÇÃO!', 'O total de pedidos selecionados ultrapassa o total permitido de '+IntToStr(intTotalPedidoPermitido)+'.', ['&Ok']);
    Exit;
  end;

  strListaPedidos := EmptyStr;

  for strAutIncPed in stlPedidoQtd do
  begin
    pIncrementaListaStr(strAutIncPed, strListaPedidos, True);
  end;

  strAutIncSelecionado := fCampoTabela('AUTOINCREM','FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[strNumDoc,strEspDoc,strCodEmp]);

  if not fEmptyStr(strAutIncSelecionado) then
    pIncrementaListaStr(strAutIncSelecionado, strListaPedidos, True);

  if fEmptyStr(strListaPedidos) then
    Exit(False);

  if fRetornaTotalProdutosPedidos(strListaPedidos) > intTotalProdutoPermitido then
  begin
    fMensagem('ATENÇÃO!', 'O total de produtos nos pedidos selecionados ultrapassa o total permitido de '+IntToStr(intTotalProdutoPermitido)+'.', ['&Ok']);
    Exit;
  end;

  Result := False;
end;

function TfrmFatExpedicao.fValidaPedidosAguardandoComplemento: Boolean;
  Var
    strPedidos: String;

  function fLiberarComSenha: Boolean;
    Var
      strNTrava: String;
      objLiberacao : TLiberacao;
  begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto(strPedidos);
      objLiberacao.strDirAce := 'FTPDAGCOM';
      objLiberacao.blnTraTel := True;
      objLiberacao.strSenLib := '';
      objLiberacao.strMsgSen := 'Expedição - Faturar pedidos que ainda estão aguardando complemento!';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := '';

      Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);

    finally
      FreeAndNil(objLiberacao);
    end;
  end;

begin
  Result := True;
  strPedidos := '';

  If fCfgSis('TPDCOM', VarBoolean) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    pDisableControlsInterna;
    With cdsPedidos Do
    Begin
      First;
      Filtered := False;
      While Not Eof Do
      Begin
        If fSelecionado(cdsPedidos) And Assigned(fField('TPDCOM')) And (fField('TPDCOM').AsString = 'SIM') Then
        Begin
          Result := False;

          If strPedidos <> '' Then
            strPedidos := strPedidos + ', ';

          strPedidos := strPedidos + fField('NUMDOC').AsString + '-' +
                                     fField('ESPDOC').AsString + '-' +
                                     fField('CODEMP').AsString;
        End;
        Next;
      End;
      pFiltrarPedidos;
      pCalculaResumoTotalDocumentos();
      pEnableControlsInterna;
    End;
  End;

  If Not Result Then
    Result := fLiberarComSenha;
end;

function TfrmFatExpedicao.fValidaQuantSepConfOnda(const strNumeroOnda: String;
  const blnValidaQtdSep, blnValidaQtdCnf: Boolean): Boolean;
  Var
    qryOnda: TUniQuery;
    stlLista: TStringList;
begin
  stlLista := TStringList.Create;
  qryOnda := fCriaQuery;
  Try
    stlLista.Duplicates := dupIgnore;
    stlLista.Sorted := True;

    qryOnda.SQL.Add('SELECT');
    qryOnda.SQL.Add('  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) NUMDOC,');
    qryOnda.SQL.Add('  SUM(IFNULL(FDO_QTDSEP, 0)) AS QTD_SEPARADA,');
    qryOnda.SQL.Add('  SUM(IFNULL(FDO_QTDEXP, 0)) AS QTD_CONFERIDA');
    qryOnda.SQL.Add('FROM FATGOR');
    qryOnda.SQL.Add('JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM');
    qryOnda.SQL.Add('JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM');
    qryOnda.SQL.Add('JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM');
    qryOnda.SQL.Add('WHERE FGO_SEQSEP = :SEQSEP');
    qryOnda.SQL.Add('GROUP BY NUMDOC');

    qryOnda.ParamByName('SEQSEP').AsString := strNumeroOnda;
    qryOnda.Open;

    qryOnda.First;
    While Not qryOnda.Eof Do
    Begin
      If blnValidaQtdSep And (qryOnda.FieldByName('QTD_SEPARADA').AsFloat > 0) Then
        stlLista.Add(qryOnda.FieldByName('NUMDOC').AsString);

      If blnValidaQtdCnf And (qryOnda.FieldByName('QTD_CONFERIDA').AsFloat > 0) Then
        stlLista.Add(qryOnda.FieldByName('NUMDOC').AsString);

      qryOnda.Next;
    End;

    Result := (stlLista.Count = 0);

    If Not Result Then
      Result := fPergunta('Os pedidos abaixo já estão em separação/conferência, portanto não serão alterados:' +
                          sLineBreak + stlLista.CommaText + sLineBreak +
                          'Deseja prosseguir com a alteração nos demais pedidos da onda?', False);
  Finally
    FreeAndNil(qryOnda);
    stlLista.Free;
  End;
end;

function TfrmFatExpedicao.fValidaSituacaoFinanceiraPedidosSelecionados: Boolean;
  Var
    strPenFin: String;
begin
  Result := True;

  pDisableControlsInterna;
  With cdsPedidos Do
  Begin
    First;
    Filtered := False;
    While Not Eof Do
    Begin
      If fSelecionado(cdsPedidos) And Not fSituacaoFinanceiraPedidoOk(strPenFin) Then
      Begin
        pMensagemOk(strPenFin + '!');
        Result := False;
        Break;
      End;
      Next;
    End;
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
    pEnableControlsInterna;
  End;
end;

function TfrmFatExpedicao.fValidaTemPedidosIntegracao(var ASomenteMarketPlace: Boolean): Boolean;
var
  LCds: TUniClientDataSet;
begin
  Result := False;
  ASomenteMarketPlace := True;

  LCds := TUniClientDataSet.Create(nil);

  try
    pCloneDataSet(LCds, cdsPedidos);
    LCds.First;

    while not LCds.Eof do
    begin
      if (fSelecionado(LCds)) then
      begin
        if fEhMarketPlace then
          Result := True
        else
          ASomenteMarketPlace := False;

        FListaPDMarketPlace.Add(LCds.FieldByName('AUTINC').AsString);
      end;

      LCds.Next;
    end;
  finally
    FreeAndNil(LCds);
  end;
end;

function TfrmFatExpedicao.fValidaTravaDoc: Boolean;
  Var
    strChave, strHost: String;
begin
  Result := False;

  strChave := Concat('FATGOR',
                     fField('NUMDOC').AsString,
                     fField('ESPDOC').AsString,
                     fField('CODEMP').AsString);

  strHost := fGetHostLock(strChave);

  If Not fEmptyStr(strHost) Then
  Begin
    pMensagemOk('Esse Documento está sendo utilizado em Outra Estação por ' + strHost + '!');
    Exit;
  End;

  strChave := Concat('CADREC',
                     fField('NUMDOC').AsString,
                     fField('ESPDOC').AsString,
                     fField('CODEMP').AsString,
                     fField('CODCLI').AsString);

  strHost := fGetHostLock(strChave);

  If Not fEmptyStr(strHost) Then
  Begin
    pMensagemOk('Esse Documento está sendo utilizado em Outra Estação por ' + strHost + '!');
    Exit;
  End;

  Result := True;
end;

function TfrmFatExpedicao.fValida_SelecaoDePedidosOndaWMS(var blnSelecionouOndaJaGerada : Boolean): Boolean;
var
  intContador  : Integer;
  stlOndas     : TStringList;
  stlVazio     : TStringList;
  strMSG       : String;
  cdsClone     : TZClient;
  strSeqSepPed : String;

  blnNaoSelecionouTodosOsPedidosDaOnda : Boolean;

const
  MSG_ABORTAR = 'Não é permitido selecionar pedidos que estão em onda com pedidos que não estão.';

  MSG_QUESTAO = 'Foi selecionado pedido de onda mas não foi selecionada a onda inteira.  ' + #13 +
                'Para continuar, será preciso selecionar todos os pedidos da onda [ONDA].' + #13 +
                'Deseja que o sistema selecione todos os pedidos da onda?';
begin

  Result := True;
  blnSelecionouOndaJaGerada := False;

  If (fUsaOndaSeparacaoExpedicaoWMS) And (dbgPedidos.SelectedRows.Count >= 1) Then
  Begin

    stlOndas := TStringList.Create;
    stlVazio := TStringList.Create;

    stlOndas.Clear;
    stlVazio.Clear;

    cdsPedidos.DisableControls;

    Try

      For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
      Begin
        dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);
        If Not fEmptyStr(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString) Then
          stlOndas.Add(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString)
        Else
          stlVazio.Add(dtsPedidos.DataSet.FieldByName('AUTINC').AsString);
      End;

      {Selecionou pedidos de onda com avulsos!}
      If (stlOndas.Count > 0) And (stlVazio.Count > 0) Then
      Begin
        fMensagem('Atenção!', MSG_ABORTAR, ['&OK']);
        Exit(False);
      End;

      {Selecionou pedido de onda, verifica se foram selecionados todos!}
      If (stlOndas.Count > 0) Then
      Begin

        blnNaoSelecionouTodosOsPedidosDaOnda := False;
        strSeqSepPed := stlOndas.Strings[0];

        If Not strSeqSepPed.IsEmpty Then
        Begin

          cdsClone := TZClient.Create(nil);
          pCloneDataSet(cdsClone, cdsPedidos);
          cdsClone.Filtered := False;

          cdsClone.First;
          While Not cdsClone.Eof Do
          Begin

            If (strSeqSepPed = cdsClone.FieldByName('SEQSEP').AsString) Then
            Begin
              If Not fSelecionado(cdsClone) Then
              Begin
                blnNaoSelecionouTodosOsPedidosDaOnda := True;
                Break;
              End;
            End;

            cdsClone.Next;

          End;

          FreeAndNil(cdsClone);

        End;

        If (blnNaoSelecionouTodosOsPedidosDaOnda) Then
        Begin
          strMSG := StringReplace(MSG_QUESTAO, '[ONDA]', stlOndas.Strings[0], [rfReplaceAll]);
          If (fMensagem('Atenção!', strMSG, ['&Sim', '&Não'], 2) = 2) Then
            Exit(False);
        End;

        {Filtrar e selecionar todos os pedidos da onda}
        btnLimparBusca.Click;

        cdsPedidos.Filtered := False;
        If cdsPedidos.Filter.IsEmpty Then
          cdsPedidos.Filter := '(1=1)';
        cdsPedidos.Filter   := cdsPedidos.Filter + ' AND (SEQSEP = ' + QuotedStr(strSeqSepPed) + ')';
        cdsPedidos.Filtered := True;

        FiltroOnda       := fosSelecaoPedidosGeracaoOnda;
        strNumeroOnda    := strSeqSepPed;
        strSeqSep        := strSeqSepPed;
        blnSelPedOndaAut := True;

        pSelecionarPedidosOndaAutomaticamente;
        blnSelecionouOndaJaGerada := True;

      End;

    Finally

      cdsPedidos.EnableControls;

      FreeAndNil(stlOndas);
      FreeAndNil(stlVazio);

    End;

  End;

end;

function TfrmFatExpedicao.fValida_SelecaoDePedidosOnda_Baixa(var blnCancelou : Boolean): Boolean;
var
  intContador  : Integer;
  cdsClone     : TZClient;
  strSeqSepPed : String;

  blnNaoSelecionouTodosOsPedidosDaOnda : Boolean;
  blnSelecionouAlgumPedido             : Boolean;

const
  MSG_QUESTAO = 'O(s) pedido(s) selecionado(s) pertence(m) à onda [ONDA]. ' + #13 +
                'Confirma a baixa da separação dos pedidos da onda [ONDA]?' + #13 +
                '(Os pedidos serão liberados para expedição)';

  procedure pSelecionarTodosOsPedidosOndaAutomaticamente;
    var
      strFilter : String;
  begin

    strFilter := '(SEQSEP = ' + QuotedStr(strSeqSepPed) + ')';

    {Filtrar e selecionar todos os pedidos da onda}
    btnLimparBusca.Click;

    cdsPedidos.Filtered := False;
    cdsPedidos.Filter   := IIF(cdsPedidos.Filter.IsEmpty, strFilter, cdsPedidos.Filter + ' AND ' + strFilter);
    cdsPedidos.Filtered := True;

    pSelecionarPedidosOndaAutomaticamente;

    {Marcar todos os pedidos da onda}
    dbgPedidos.DataSource.DataSet.First;
    while not dbgPedidos.DataSource.DataSet.Eof do
    begin
      dbgPedidos.SelectedRows.CurrentRowSelected := True;
      dbgPedidos.DataSource.DataSet.Next;
    end;

  end;

  procedure pConfirmaBaixa;
  begin
    Result := fPergunta('Confirma a baixa da separação dos pedidos da onda ' + strSeqSepPed + '?' + #13#10 + '(Os pedidos serão liberados para expedição)');

    If Not Result Then
      blnCancelou := True;
  end;

  function fDesejaQueOAutcomSelecioneOndaInteiraAutomaticamenteELibere(strOnda : String) : Boolean;
  var
    strMSG : String;
  begin
    strMSG := StringReplace(MSG_QUESTAO, '[ONDA]', strOnda, [rfReplaceAll]);
    Result := (fMensagem('Atenção!', strMSG, ['&Sim', '&Não'], 2) = 1);
  end;

begin

  Result := False;

  strSeqSepPed             := '';
  blnSelecionouAlgumPedido := (dbgPedidos.SelectedRows.Count > 0);

  cdsClone := TZClient.Create(nil);
  pCloneDataSet(cdsClone, cdsPedidos);
  cdsClone.Filtered := False;

  cdsPedidos.DisableControls;

  Try

    {Valida SELECIONADOS}
    If (blnSelecionouAlgumPedido) Then
    Begin

      For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
      Begin
        dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);
        pAdicionaListaSelecao;

        If (strSeqSepPed.IsEmpty) And (Not fEmptyStr(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString)) Then
          strSeqSepPed := dtsPedidos.DataSet.FieldByName('SEQSEP').AsString;
      End;

      {Selecionou pedido de onda, mas não todos!}
      blnNaoSelecionouTodosOsPedidosDaOnda := False;

      If Not strSeqSepPed.IsEmpty Then
      Begin

        cdsClone.First;
        While Not cdsClone.Eof Do
        Begin

          If (strSeqSepPed = cdsClone.FieldByName('SEQSEP').AsString) Then
          Begin
            If Not fSelecionado(cdsClone) Then
            Begin
              blnNaoSelecionouTodosOsPedidosDaOnda := True;
              Break;
            End;
          End;

          cdsClone.Next;

        End;

        FreeAndNil(cdsClone);

      End;

      If (blnNaoSelecionouTodosOsPedidosDaOnda) Then
      Begin

        If Not fDesejaQueOAutcomSelecioneOndaInteiraAutomaticamenteELibere(strSeqSepPed) Then
        Begin
          blnCancelou := True;
          Exit(False);
        End;

        pSelecionarTodosOsPedidosOndaAutomaticamente;
        Result := True;

      End Else
        pConfirmaBaixa;

    End
    Else
    {Valida POSICIONADO}
    Begin

      strSeqSepPed := cdsClone.FieldByName('SEQSEP').AsString;

      cdsClone.Filtered := False;
      cdsClone.Filter   := 'SEQSEP = ' + strSeqSepPed.QuotedString;
      cdsClone.Filtered := True;

      If (cdsClone.RecordCount > 1) Then
      Begin

        If Not fDesejaQueOAutcomSelecioneOndaInteiraAutomaticamenteELibere(strSeqSepPed) Then
        Begin
          blnCancelou := True;
          Exit(False);
        End;

        pSelecionarTodosOsPedidosOndaAutomaticamente;
        Result := True;

      End Else
        pConfirmaBaixa;

    End;

  Finally

    pLimparSelecaoTotalmente;
    cdsPedidos.EnableControls;

    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);

  End;


end;

function TfrmFatExpedicao.fTemPedidoDeOndaSelecionado: Boolean;
  var
    intContador              : Integer;
    cdsClone                 : TZClient;
    blnSelecionouAlgumPedido : Boolean;
begin

  Result := False;

  blnSelecionouAlgumPedido := (dbgPedidos.SelectedRows.Count > 0);

  cdsClone := TZClient.Create(nil);
  pCloneDataSet(cdsClone, cdsPedidos);
  cdsClone.Filtered := False;

  cdsPedidos.DisableControls;

  Try

    {Valida SELECIONADOS}
    If (blnSelecionouAlgumPedido) Then
    Begin

      For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
      Begin
        dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);
        If (Not fEmptyStr(dtsPedidos.DataSet.FieldByName('SEQSEP').AsString)) Then
          Exit(True);
      End;

    End
    Else
    {Valida POSICIONADO}
    Begin
      If (Not fEmptyStr(cdsClone.FieldByName('SEQSEP').AsString)) Then
        Exit(True);
    End;

  Finally

    cdsPedidos.EnableControls;

    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);

  End;

end;

function TfrmFatExpedicao.fEmExpedicaoItens: Boolean;
begin
  Result := blnEmExpedicaoItens;

  If Result Then
    pGravarErro(True, 'Atualização de seleção com frmFatExpedicaoItens aberto!', fRetornaStack);
end;

function TfrmFatExpedicao.fTemPedidoSelecionadoComDAV: Boolean;
begin
  Result := False;

  If (blnUsaPafEcf) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    pDisableControlsInterna;
    With cdsPedidos Do
    Begin
      First;
      Filtered := False;
      While Not Eof Do
      Begin
        If fSelecionado(cdsPedidos) And (fField('TEMDAV').AsString = 'S') Then
        Begin
          fMensagem('','Não é permitido faturar o Pedido '+fField('NUMDOC').AsString + '-' +
                                                           fField('ESPDOC').AsString + '-' +
                                                           fField('CODEMP').AsString +' pois o mesmo possui um DAV associado. Use o PDVCitel.',['&OK']);
          Result := True;
          Break;
        End;
        Next;
      End;
      pFiltrarPedidos;
      pCalculaResumoTotalDocumentos();
      pEnableControlsInterna;
    End;
  End;
end;

function TfrmFatExpedicao.fTemPedidoSelecionadoComServico: Boolean;
  Var
    intCnt : Integer;
    blnAchouPedido : Boolean;
    strMsg: String;
begin
  Result := False;

  If Not (Assigned(stlPedidos)) Then
    Exit;

  With cdsPedidos Do
  Begin
    blnScrollPedidos := False;
    pDisableControlsInterna;
    Filtered := False;
    Try
      For intCnt := 0 To stlPedidos.Count -1 Do
      Begin
        blnAchouPedido := cdsPedidos.Locate('AUTINC', stlPedidos.Strings[intCnt], []);

        If (blnAchouPedido) And
           (cdsPedidos.FieldByName('TEMSER').AsString = 'S') Then
        Begin
          strMsg := 'Documento com serviços deve ser faturado pela Venda Normal ou pelo F11 do Resumo de Caixa!';
          If (fCampoTabela('FGO_ORIGEM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], 
                                                   [fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString]) = 'AGRUPAMENTO') Then
          Begin                                         
            strMsg := 'Documento agrupado e com serviços deve ser faturado pelo F11 do Resumo de Caixa!';
          End;
          
          fMensagem('',strMsg + #13#10 +
                       fField('NUMDOC').AsString + '-' +
                       fField('ESPDOC').AsString + '-' +
                       fField('CODEMP').AsString,['&OK']);
          Result := True;
          Break;
        End;
      End;
    Finally
      blnScrollPedidos := True;
      pFiltrarPedidos;
      pCalculaResumoTotalDocumentos();
      pEnableControlsInterna;
    End;
  End;
end;

procedure TfrmFatExpedicao.btnFaturarExpedidosClick(Sender: TObject);
const
  MSG_AGUARDE = 'Aguarde, Faturando Pedido(s) ...';
begin
  if not fVerificaAcessoSistema('EXF11P') then
    Exit;

  Try
    If (Not fTravaConferenciaPedidosSelecionados(False)) Then
      Exit;

    strBotaoAcionado := 'F11';
    pAtivaDesativaTimersNotificaoAndRecarga(False);
    Try
      If fEhPedidoGarantiaEnvioParaOCliente Then
        If Not fPedidoGarantiaEnvioParaOClienteTotalmenteFaturado Then
        Begin
          Exit;
        End;

      If fPedidoComFormulacaoEmAberto Then
      Begin
        pMensagemOk('Esse pedido possui tinta de máquina e a formulação ainda não foi baixada. '+#13+
                    'Antes de faturar, acesse o menu "Principal > Faturamento > Formulação de Tinta de Máquina" e faça a baixa.');
        Exit;
      End;

      If fPodeFaturarOndaPedidosTotalmenteExpedidos Then
        TfrmGravando.fExecutarModalA(pFaturarOndaPedidosTotalmenteExpedidos, MSG_AGUARDE, '')
      Else
        TfrmGravando.fExecutarModalA(pFaturarExpedidos, MSG_AGUARDE, '');
    Finally
      pAtivaDesativaTimersNotificaoAndRecarga(True);
    End;
  Finally
    fTravaConferenciaPedidosSelecionados(True);
  End;
end;

procedure TfrmFatExpedicao.btnFaturarOndaSeparacaoClick(Sender: TObject);
begin
  inherited;
  If btnFaturarOndaSeparacao.Visible And btnFaturarOndaSeparacao.Enabled Then
  Try
    pAtivaDesativaTimersNotificaoAndRecarga(False);
    TfrmGravando.fExecutarModalA(pFaturarPedidoOndaSeparacaoPeloProduto,
      'Faturando Pedido(s) da Onda de Separação Nº ' + strNumeroOnda, '');
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    pLimparVariaveisSeparadorConferenteOndaSeparacao;
  End;
end;

procedure TfrmFatExpedicao.pFaturarExpedidos;
begin
  inherited;
  If (btnFaturarExpedidos.Visible) And
     (Not fTemPedidoSelecionadoComServico) And
     (Not fTemPedidoSelecionadoComVidros) And
     (Not fTemPedidoSelecionadoComDAV) And
     (fValidaPedidosAguardandoComplemento) And
     (fValidarPedidosClienteEstoqueExterno) And
     (Not fTemPedidoSelecionadoComFormaNegociada) And
     (fValidaSituacaoFinanceiraPedidosSelecionados) Then//Trava de segurança
  Begin
    pExpedirPedidos(TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, False, '', False, True);//Faturamento Depois da Expedicao
  End;
end;

procedure TfrmFatExpedicao.pFaturarOndaPedidosTotalmenteExpedidos;
var
  arrPedidos: TArray<String>;
  intContador: Integer;
  strAutIncPed: String;
begin
  If Not fPodeFaturarOndaPedidosTotalmenteExpedidos Then
    Exit;

  If Not fPergunta('Confirma faturar todos os pedidos selecionados já totalmente conferidos ?') Then
    Exit;

  pLimparSelecaoELocks;

  SetLength(arrPedidos, 0);

  For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
  Begin
    dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);
    pAddDados(arrPedidos, dtsPedidos.DataSet.FieldByName('AUTINC').AsString);
  End;

  For strAutIncPed In arrPedidos Do
  Begin
    Try
      If Not cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
        Continue;

      pSelecionaVariosPedidos();

      If fSelecionado(cdsPedidos) Then
        pFaturarExpedidos;
    Finally
      pLimparSelecaoELocks;
    End;
  End;
end;

procedure TfrmFatExpedicao.btnFeriadosClick(Sender: TObject);
begin

  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(185, 7458, [],
                        ['CODCID'],
                        [fField('CODCID').AsString],
                        Sender,
                        nil,
                        False);
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);

end;

procedure TfrmFatExpedicao.btnFreteClick(Sender: TObject);
  Var
    frmFatAltValorFreteSuges : TfrmFatAltValorFreteSuges;
begin
  inherited;

  pCriarFormularios(TfrmFatAltValorFreteSuges, frmFatAltValorFreteSuges);
  Try
    frmFatAltValorFreteSuges.strNumDoc := fField('NUMDOC').AsString;
    frmFatAltValorFreteSuges.strEspDoc := fField('ESPDOC').AsString;
    frmFatAltValorFreteSuges.strCodEmp := fField('CODEMP').AsString;
    frmFatAltValorFreteSuges.blnInformaFreteNaFreCot := fCfgSis('TRACOT', varBoolean);
    frmFatAltValorFreteSuges.tpOrigemAlteracaoFrete := oafExpedicao;
    frmFatAltValorFreteSuges.ShowModal;
  Finally
    pFreeAndNil(frmFatAltValorFreteSuges);
  End;
end;

procedure TfrmFatExpedicao.dbgPedidosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  Var
  blnSeparacaoParcial : Boolean;
  blnSeparacaoTotal : Boolean;
  blnLinhaPosicionada: Boolean;
begin
  inherited;
  If (Not cdsPedidos.Active) Or (cdsPedidos.IsEmpty) Then
    Exit;

  blnLinhaPosicionada := (Rect.Top = TStringGrid(dbgPedidos).CellRect(0, TStringGrid(dbgPedidos).Row).Top);

  If blnLinhaPosicionada Then
    dbgPedidos.Canvas.Font.Color := FCorDocPosFonte;

  If (pnlSepImp.Visible) and (not blnLinhaPosicionada) Then
  Begin
    If (fField('SEPIMP').AsString = '0') Then
      dbgPedidos.Canvas.Font.Color := FCorSepNaoImp;

    If (fField('SEPIMP').AsString = '1') Then
      dbgPedidos.Canvas.Font.Color := FCorSepImp;

    If (fField('SEPIMP').AsString = '2') Then
      dbgPedidos.Canvas.Font.Color := FCorAltSepImp;

    If (fField('SEPIMP').AsString = '3') Then
      dbgPedidos.Canvas.Font.Color := FCorSepReimp;
  End;

  {*********************************************************}
  {* REGRA FOI CRIADA POR CAUSA DA CONFIGURAÇÃO CFG_USAPTF *}
  {* ONDE O CLIENTE SO QUER FATURAR 'TE' E 'SA'            *}
  {*******************************************************LE}
  If blnUsaPTF Then
  Begin
    If (not blnLinhaPosicionada) Then
    begin
      If (fField('TEMEXP').AsString = 'S') Then
        dbgPedidos.Canvas.Font.Color := FCorTotExp;

      If (fField('EXPTOT').AsString = 'S') Then
        dbgPedidos.Canvas.Font.Color := FCorIteExp;
    end;
  End
  Else
  Begin
    If btnFaturarExpedidos.Visible Then
    Begin
      If (not blnLinhaPosicionada) Then
      begin
        If (fField('TEMEXP').AsString = 'S') Then
          dbgPedidos.Canvas.Font.Color := FCorTotExp;

        If (fField('EXPTOT').AsString = 'S') Then
          dbgPedidos.Canvas.Font.Color := FCorIteExp;
      end;
    End;
  End;

  If (grbLocSep.Visible) And (Not blnLinhaPosicionada) Then
  Begin
    if (fCfgSis('EXBXTO', varBoolean)) then
    begin
      blnSeparacaoParcial := (//SEPARAÇÃO PARCIAL
                               (((Not fEmptyStr(fField('LSEPAR').AsString)) And (Pos(fGetCodigoLocSep(), fField('LSEPAR').AsString) > 0)) Or
                                (fUsaFiltroLocSepTodos And
                                 ((Not fEmptyStr(fField('LSEPEN').AsString)) And ((Not fEmptyStr(fField('LSEPAR').AsString)) Or (Not fEmptyStr(fField('LSELIB').AsString)))))
                               )
                             );
    end
    else
    begin
      blnSeparacaoParcial := (//SEPARAÇÃO PARCIAL
                               (Not fEmptyStr(fField('LSEPAR').AsString)) And
                               (Pos(fGetCodigoLocSep(), fField('LSEPAR').AsString) > 0)
                             );
    end;

    If (blnSeparacaoParcial) Then
        dbgPedidos.Canvas.Font.Color := FCorTotExp;

    if (fCfgSis('EXBXTO', varBoolean)) then
    begin
      blnSeparacaoTotal := (//SEPARAÇÃO TOTAL
                             (((Not fEmptyStr(fField('LSELIB').AsString)) And (Pos(fGetCodigoLocSep(), fField('LSELIB').AsString) > 0)) Or
                              (fUsaFiltroLocSepTodos And (Not fEmptyStr(fField('CODLSE').AsString)) And (fEmptyStr(fField('LSEPEN').AsString)))
                             )
                           );
    end
    else
    begin
      blnSeparacaoTotal := (//SEPARAÇÃO TOTAL
                             (Not fEmptyStr(fField('LSELIB').AsString)) And
                             (Pos(fGetCodigoLocSep(), fField('LSELIB').AsString) > 0)
                           );
    end;

    If (blnSeparacaoTotal) Then
        dbgPedidos.Canvas.Font.Color := FCorIteExp;
  End;

  If fSelecionado(cdsPedidos) Then
  Begin
    If blnLinhaPosicionada Then
      dbgPedidos.Canvas.Font.Color := FCorDocSelPos
    Else
      dbgPedidos.Canvas.Brush.Color := FCorDocSel;
  End;

  If (shpGarantia.Visible) And
     (Column.FieldName = 'ENTRET') And
     (dbgPedidos.DataSource.DataSet.FieldByName('MEN001').AsString = 'GARANTIA(TE)') Then
    dbgPedidos.Canvas.Brush.Color := FCorGarantia;

  If (Column.FieldName = 'ENTURG') and (not blnLinhaPosicionada) Then
    If (fField('ENTURG').AsString = 'SIM') Then
    Begin
      dbgPedidos.Canvas.Font.Color := FCorUrgente;
      dbgPedidos.Canvas.Font.Style := [fsBold];
    End
    Else
      dbgPedidos.Canvas.Font.Color := clBlack;
 
  If (Column.FieldName = 'ORDPRO') Then
  Begin
    dbgPedidos.Canvas.Font.Style := [fsBold];

    If (not blnLinhaPosicionada) Then
      If (fField('ORDPRO').AsString = 'PENDENTE') Then
        dbgPedidos.Canvas.Font.Color := FCorOrdProPendente
      Else
        dbgPedidos.Canvas.Font.Color := FCorOrdPro;
  End;

  If (Column.FieldName = 'CODVEN') And
     (pnlLegendEmpVen.Visible) And
     (not blnLinhaPosicionada) Then
    if (fField('EMPVEN').AsString = VS_strCodEmp) Then
      dbgPedidos.Canvas.Brush.Color := FCorVenEmp
    Else
      dbgPedidos.Canvas.Brush.Color := FCorVenOutEmp;

  If (fRotasPorRegiaoExpedicaoPedido4) And
     (fField('VLRMIN').AsFloat > fField('VRROTA').AsFloat) And
     (fField('LIBSEP').AsString = 'N') And
     (not blnLinhaPosicionada) Then
    dbgPedidos.Canvas.Font.Color := FCorLibSep;

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And
     (fEDocumentoDeDevolucao) And
     (not blnLinhaPosicionada) Then
    dbgPedidos.Canvas.Font.Color := FCorDocDev;

  If blnLinhaPosicionada Then
    dbgPedidos.Canvas.Brush.Color := FCorDocPosFundo;

  If (Column.FieldName = 'DOCUME') Then
  Begin
    If (fField('STAHUB').AsString = 'C') Then
    Begin
      dbgPedidos.Canvas.Brush.Color := clRed;
      dbgPedidos.Canvas.Font.Color  := clWhite;
    End
    Else If (fField('STAHUB').AsString = 'Q') Then
    Begin
      dbgPedidos.Canvas.Brush.Color := clYellow;
      dbgPedidos.Canvas.Font.Color  := clBlack;
    End
    Else If (fField('STAHUB').AsString = 'A') Then
    Begin
      dbgPedidos.Canvas.Brush.Color := clGreen;
      dbgPedidos.Canvas.Font.Color  := clWhite;
    End;
  End;

  dbgPedidos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  pDrawColumnCell(dbgPedidos, Column, Rect);
end;

function TfrmFatExpedicao.fGetDescricaoEntRet(strEntRet : String; strEspDoc : String = ''): String;
begin
  Result := '';
  If (strEntRet = 'R') Then
    Result := 'RETIRA'
  Else If (strEntRet = 'E') Then
    Result := 'ENT.IMEDIATA'
  Else If (strEntRet = 'F') Then
    Result := 'ENT.FUTURA'
  Else
  Begin
    Result := '';

    If Pos('R', strEntRet) > 0 Then
      Result := Result + '/ RET ';

    If Pos('E', strEntRet) > 0 Then
      Result := Result + '/ ENT.I ';

    If Pos('F', strEntRet) > 0 Then
      Result := Result + '/ ENT.F ';

    If LeftStr(Result, 2) = '/ ' Then
      System.Delete(Result, 1, 2);

  End;

  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And fEDocumentoDeDevolucao Then
    Result := 'DEVOL.'+Result;

end;

function TfrmFatExpedicao.fGetDescricaoLocSep: String;
begin
  Result := '';

  If (grbLocSep.Visible) And (cmbLocSep.ItemIndex > 0) Then
    Result := arrLocSep[cmbLocSep.ItemIndex - 1].strDescri;
end;

procedure TfrmFatExpedicao.pSelecionaVariosPedidos;
  Var
    strDocTra: String;
    strEspTra: String;
    strEmpTra: String;
    strCliTra: String;
    strNomCli: String;
    stlMsg: TStringList;
    blnLibera: Boolean;
    strChaLck: String;
begin
  strDocTra := fField('NUMDOC').AsString;
  strEspTra := fField('ESPDOC').AsString;
  strEmpTra := fField('CODEMP').AsString;
  strCliTra := fField('CODCLI').AsString;

  If Not fSelecionado(cdsPedidos) Then
  Begin
    If (Not fPermiteSelecionarPedidoAtual) Then
      Exit;

    If (Not fValidouConsultaSituacaoCadastral(strCliTra)) Then
    Begin
      fMensagem('ATENÇÃO!', Format(MSG_PAINEL_FECHADO_CONSULTA_CADASTRAL, [VS_strCodEmp]), ['&OK']);
      Exit;
    End;

    pNotificaOperadorExpedicao(strCliTra);

    If (Not fAvisaOperadorDestinoDiferente(fField('ENTRET').AsString)) Then
      Exit;

    Try
      stlMsg := TStringList.Create;

      pTravaDadosGerais(stlMsg);

      If (stlMsg.Count > 0) Then
      Begin
        Try
          pCriarFormularios(TfrmObservacao, frmObservacao);
          frmObservacao.Width := 700;
          frmObservacao.Caption             := 'Divergências';
          frmObservacao.lblMensagem.Caption := 'Há divergências entre os pedidos.';
          frmObservacao.memObs.Lines.Assign(stlMsg);
          If blnColetor Then
          Begin
            frmObservacao.Position    := poDesigned;
            frmObservacao.WindowState := wsMaximized;
          End;

          frmObservacao.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '[MensagemDivergenciasExpedicao]');
          End;
        End;
        pFreeAndNil(frmObservacao);
      End
      Else
      Begin

        If (btnFaturarExpedidos.Visible) Or (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
        Begin
          If fTemEntFut(strDocTra, strEspTra, strEmpTra) Then
          Begin
            fMensagem('','Documento com entrega futura deve ser faturado pela venda normal!',['&OK']);
            Exit;
          End;
        End;

        If (Not btnFaturarExpedidos.Visible) And fTemServico(strDocTra, strEspTra, strEmpTra, strCliTra) And (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
        Begin
          fMensagem('','Documento com serviços deve ser faturado pela venda normal!',['&OK']);
          Exit;
        End;

        If (Not btnFaturarExpedidos.Visible) And fTemVidro(strDocTra, strEspTra, strEmpTra) Then
        Begin
          fMensagem('','Documento com vidros deve ser faturado pela venda normal!',['&OK']);
          Exit;
        End;

        If (VS_strExpRetiraEntrega = 'E') And fTemRetira(strDocTra, strEspTra, strEmpTra, cdsPedidos.FieldByName('AUTINC').AsString) Then
        Begin
          fMensagem('','Não é permitido pedido com itens de Retira, pois sistema configurado ' +
                       'para expedir somente itens de Entrega. Favor dirigir-se ao caixa ' +
                       'para desmembrar este pedido!',['&OK']);
          Exit;
        End;

        If fValidaItemEspecial(strEspTra, cdsPedidos.FieldByName('TEMITEESP').AsString) Then
          Exit;

        If blnGarSel And ( cdsPedidos.FieldByName('MEN001').AsString <> 'GARANTIA(TE)' ) Then
        Begin
          Screen.Cursor := crDefault;
          fMensagem('', 'Só é permitido selecionar documentos de garantia!', ['&Ok']);
          Exit;
        End;

        If blnPedTra And (Pos(cdsPedidos.FieldByName('CODCLI'). AsString, fRetClientesFilial) < 0) Then
        Begin
          Screen.Cursor := crDefault;
          fMensagem('', 'Só é permitido selecionar pedidos de transferência!', ['&Ok']);
          Exit;
        End;

        If fTravaSelecaoPedidoQuantidade(stlPedidos, strDocTra, strEspTra, strEmpTra) Then
        Begin
          Screen.Cursor := crDefault;
          Exit;
        End;

        Screen.Cursor := crHourGlass;

        strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;

        blnLibera := objLock.fLock_Unlock(strChaLck, True, False);
        blnLibera := fVerificaTravaConferencia(blnLibera, strChaLck);

        If (Not blnLibera) Then
        Begin
          Screen.Cursor := crDefault;
          fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck)  + '!', ['&Ok']);
          Exit;
        End;

        If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
          objLock.fLock_Unlock(strChaLck + STR_TRAVA_CONFERENCIA, True, False);

        strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;

        If (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
        Begin
          Screen.Cursor := crDefault;
          fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck)  + '!', ['&Ok']);
          Exit;
        End;

        If (fCfgSis('USACCR', varString) = 'N') Then
          strCcrSel := 'N'
        Else
          strCcrSel := IIF(fDocumentoPossuiItemConcreto(fField('NUMDOC').AsString,
                                                        fField('ESPDOC').AsString,
                                                        fField('CODEMP').AsString),'S','N');

        strOriSel  := fField('ORIGOR').AsString;
        strFatSel  := fField('FATAUT').AsString;
        strEmpSel  := fField('CODEMP').AsString;
        strCliSel  := fField('CODCLI').AsString;
        strFazSel  := fField('CODFAZ').AsString;
        If (fField('CODEMB') <> Nil) Then
          strEmbSel := fField('CODEMB').AsString;
        strFpgSel  := fField('CODFPG').AsString;
        strCndSel  := fField('CONPAG').AsString;
        strCodSel  := fField('CODCND').AsString;
        strVenSel  := fField('CODVEN').AsString;
        strVe2Sel  := fField('CODVE2').AsString;
        strOprFlj  := fField('OPRFLJ').AsString;
        strTraSel  := fField('CODTRA').AsString;
        strIndSel  := fField('INDCOM').AsString;
        strTppSel  := fField('TIPPED').AsString;
        strPorSel  := fField('CODPOR').AsString;
        strTipSel  := fField('TIPOPE').AsString;
        strBeFSel  := fField('BENFUT').AsString;
        dtaEmiSel  := fField('DTAENT').AsDateTime;
        dtaPrevSel := fField('PREVIS').AsDateTime;
        strNomCli  := fField('NOMCLI').AsString;
        strCfgENFUOPSel := fField('ENFUOP').AsString;
        strSolAbaSel := fField('SOLABA').AsString;
        blnFreRatSel := (fField('FRERAT').AsFloat > 0);
        blnDecZfmSel := (fField('DECZFM').AsFloat > 0);
        strRegEspSel := fField('REGESP').AsString;
        strUtiResSel := fField('UTIRES').AsString;
        strCotLal := fField('COTLAL').AsString;
        strTaxJurSel := fRetTaxaJurosSelAtu;

        strTemAdt := IIF(fFormataFloat(fField('VALADT').AsFloat, 2) > 0.00, 'S', 'N');
        strBolAdt := IIF(fFormataFloat(fField('BOLADT').AsFloat, 2) > 0.00, 'S', 'N');
        strTemRec := IIF(fFormataFloat(fField('VALREC').AsFloat, 2) > 0.00, 'S', 'N');

        FblnTemPedidoDeConsignacao := fField('ENVCON').AsString = 'S';

        Screen.Cursor := crDefault;

        pAdicionaListaSelecao;
      End;
    Finally
      FreeAndNil(stlMsg);
    end;


    pVerificaExpPen(strCliSel, strNomCli, strDocTra, strEspTra, strEmpTra);
  End
  Else
  Begin
    strDocTra := fField('NUMDOC').AsString;
    strEspTra := fField('ESPDOC').AsString;
    strEmpTra := fField('CODEMP').AsString;

    strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;
    pLiberaTravaVerificandoRomaneioEmAndamento(strChaLck);

    strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;
    objLock.fLock_Unlock(strChaLck, False, False);

    pRemoveListaSelecao;

    If stlPedidos.Count = 0 Then
    Begin
      pLimpaVariaveisSelecaoPedidos;
    End;
  End;
  dbgPedidos.Repaint;
end;

procedure TfrmFatExpedicao.pSetApenasGeracaoDeRemessaDePedido;
begin
  FApenasGeracaoDeRemessaDePedido := True;
end;

procedure TfrmFatExpedicao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgPedidos);
  pAjustaAlturaPanelBotoes;
end;

procedure TfrmFatExpedicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  inherited;

  If Assigned(stlPedidos) Then
    FreeAndNil(stlPedidos);

  If Assigned(cdsAdiantamentos) Then
    FreeAndNil(cdsAdiantamentos);

  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);

  If Assigned(cdsDocsExcluirLoteSep) Then
    FreeAndNil(cdsDocsExcluirLoteSep);

  If Assigned(FDicBaiEntFut) Then
    FreeAndNil(FDicBaiEntFut);

  If Assigned(stlBarDocLocalizar) Then
    FreeAndNil(stlBarDocLocalizar);

  If Assigned(qryFerCid) Then
    FreeAndNil(qryFerCid);

  SetLength(arrLocSep, 0);

  pEncerraThreadNotificacao;

  pDestruirClientDataSetPedidos;
  objLock.pDestravarTodos;

end;

function TfrmFatExpedicao.fSelecionado(DataSet: TDataSet): Boolean;
begin
  Result := False;

  If (fVerificaSelecionado(DataSet)) Then
    Result := (stlPedidos.IndexOf(DataSet.FieldByName('AUTINC').AsString) > -1);
end;

function TfrmFatExpedicao.fVerificaSelecionado(DataSet: TDataSet): Boolean;
Begin
  If (strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And (DataSet.FieldByName('ESPDOC').AsString <> 'PD') Then
    Result := False
  Else
  Begin
    If (Assigned(stlPedidos)) And (Assigned(DataSet)) Then
      Result := True
    else
      Result := False;
  End;
End;

function TfrmFatExpedicao.fVerificaTravaConferencia(blnLibera:Boolean; strChaLck: String; blnMsg: Boolean = True): Boolean;
Var
  blnLockRomaneio: Boolean;
  blnLockConferencia: Boolean;
begin
  Result := blnLibera;

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    blnLockRomaneio := fVerificaLockAtivo(strChaLck + STR_TRAVA_ROMANEIO);
    blnLockConferencia := fVerificaLockAtivo(strChaLck + STR_TRAVA_CONFERENCIA);

    If (blnLockConferencia) Then
    Begin
      Result := False;
    End
    Else If (blnLockRomaneio) Then
    Begin
      objLock.pAdicionaTrava(strChaLck);
      Result := True;
    End;

    If (Result) And (blnLockRomaneio) And (blnMsg) Then
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                    fGetHostLock(strChaLck)  + '. Portanto será possível apenas efetuar conferência do mesmo.', ['&Ok']);
  End;
end;

function TfrmFatExpedicao.fVerificaTravaRomaneioPedidosSelecionados: Boolean;
Var
  intIndex: Integer;
  objPedido: TPedidoVenda;
  strChaLck: String;
begin
  Result := True;

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    Result := False;

    For intIndex := 0 To Pred(stlPedidos.Count) Do
    Begin
      objPedido := TPedidoVenda(stlPedidos.Objects[intIndex]);

      strChaLck := 'FATGOR' + objPedido.strNumDoc + objPedido.strEspDoc + objPedido.strCodEmp;

      If fVerificaLockAtivo(strChaLck + STR_TRAVA_ROMANEIO) Then
      Begin
        fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck), ['&Ok']);
        Exit;
      End;
    End;

    Result := True;
  End;
end;

function TfrmFatExpedicao.fRetTaxaJurosSelAtu: String;
  Var
    fltTaxJur: Double;
begin
  fltTaxJur := 0;

  If (fCfgSis('CNDVEN', varString) = 'F') And (fField('ZERTAX').AsString = 'N') And (fField('ESPDOC').AsString = 'PD') Then
    fltTaxJur := fField('TAXJUR').AsFloat;

  Result := FormatFloat('#,##0.00', fFormataFloat(fltTaxJur, 2));
end;

procedure TfrmFatExpedicao.pAdicionaListaSelecao;
  Var
    objPedido: TPedidoVenda;
begin
  If (stlPedidos.IndexOf(fField('AUTINC').AsString) = -1) Then
  Begin
    objPedido := TPedidoVenda.Create;
    objPedido.strNumDoc := fField('NUMDOC').AsString;
    objPedido.strEspDoc := fField('ESPDOC').AsString;
    objPedido.strCodEmp := fField('CODEMP').AsString;
    objPedido.strCodCli := fField('CODCLI').AsString;
    objPedido.strSeqGer := fField('AUTINC').AsString;
    objPedido.strEmpExp := fField('EMPEXP').AsString;
    objPedido.strCodFaz := fField('CODFAZ').AsString;
    objPedido.blnGaraTE := (fField('MEN001').AsString = 'GARANTIA(TE)');

    objPedido.strTemADT := IIF(fField('VALADT').AsFloat > 0, 'S', 'N');

    If (fField('CODEMB') <> Nil) Then
      objPedido.strCodEmb := fField('CODEMB').AsString;

    stlPedidos.AddObject(fField('AUTINC').AsString, objPedido);

    If blnApenasPrazo Then
      blnPermiteExpedirPedidoAVistaCaixaFechado := True;

    FValorContabilTotalDocSelecionados := FValorContabilTotalDocSelecionados
                                        + fField('VLRCON').AsFloat;

    FPesoTotalDocSelecionados          := FPesoTotalDocSelecionados
                                        + fField('PESBRU').AsFloat;

    FVolumeTotalDocSelecionados        := FVolumeTotalDocSelecionados
                                        + fField('VOLUME').AsFloat;

    FCubagemTotalDocSelecionados       := FCubagemTotalDocSelecionados
                                        + fField('CUBAGEM').AsFloat;

    FValorTotalDocSelecionados        := FValorTotalDocSelecionados
                                        + fField('VALDOC').AsFloat;
  End;
  
  If (stlPedidos.Count = 1) And ( cdsPedidos.FieldByName('MEN001').AsString = 'GARANTIA(TE)' ) Then
    blnGarSel := True;

  If (stlPedidos.Count = 1) And (Pos(cdsPedidos.FieldByName('CODCLI'). AsString, fRetClientesFilial) > 0) Then
    blnPedTra := True;

  pCarregarInformacoesPnlDocumentoSelecionados;
end;

procedure TfrmFatExpedicao.pArmazenaPedidoInicialDoProcesso;
begin
  strPedidoInicialDoProcesso := cdsPedidos.FieldByName('NUMDOC').AsString;
  strEspecieDoPedido         := cdsPedidos.FieldByName('ESPDOC').AsString;
  strEmpresaDoPedido         := cdsPedidos.FieldByName('CODEMP').AsString;
end;

procedure TfrmFatExpedicao.pRemoveLiberacaoPD(AAutInc, AMotBlo: String);
const
  INSERT_LIBPED = 'INSERT INTO LIBPED ' +
                  '  (AUTOINCREM, LPD_NUMDOC, LPD_ESPDOC, LPD_CODEMP, LPD_CODCLI, LPD_CONPAG, LPD_CODVEN, ' +
                  '   LPD_CODDIG, LPD_DTACAD, LPD_HORCAD, LPD_VLRCON, LPD_INFBLO, LPD_INFLIB) ' +
                  'VALUES ' +
                  '  (:AUTINC, :NUMDOC, :ESPDOC, :CODEMP, :CODCLI, :CONPAG, :CODVEN, ' +
                  '   :CODDIG, :DTACAD, :HORCAD, :VLRCON, :INFBLO, :INFLIB) ';
var
  LQry,
  LQryPD: TUniQuery;
begin
  LQry := fCriaQuery;
  LQryPD := fCriaQuery;

  try
    try
      LQry.SQL.Add('UPDATE FATGOR ');
      LQry.SQL.Add('SET FGO_LIBERA = 0,    ');
      LQry.SQL.Add('    FGO_DIGLIB = NULL, ');
      LQry.SQL.Add('    FGO_DTALIB = NULL, ');
      LQry.SQL.Add('    FGO_HORLIB = NULL, ');
      LQry.SQL.Add('    FGO_OBSL01 = NULL, ');
      LQry.SQL.Add('    FGO_OBSL02 = NULL  ');
      LQry.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
      LQry.ParamByName('AUTINC').AsString := AAutInc;
      LQry.ExecSQL;

      LQryPD.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, FGO_CODCLI, FGO_CONPAG, FGO_CODVEN, FGO_VLRCON ');
      LQryPD.SQL.Add('FROM FATGOR ');
      LQryPD.SQL.Add('WHERE AUTOINCREM = :AUTINC ');
      LQryPD.ParamByName('AUTINC').AsString := AAutInc;
      LQryPD.Open;

      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('DELETE FROM LIBPED ');
      LQry.SQL.Add('WHERE LPD_OPELIB IS NULL ');
      LQry.SQL.Add('  AND LPD_NUMDOC = :NUMDOC ');
      LQry.SQL.Add('  AND LPD_ESPDOC = :ESPDOC ');
      LQry.SQL.Add('  AND LPD_CODEMP = :CODEMP ');
      LQry.ParamByName('NUMDOC').AsString := LQryPD.FieldByName('FGO_NUMDOC').AsString;
      LQry.ParamByName('ESPDOC').AsString := LQryPD.FieldByName('FGO_ESPDOC').AsString;
      LQry.ParamByName('CODEMP').AsString := LQryPD.FieldByName('FGO_CODEMP').AsString;
      LQry.ExecSQL;

      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Text := INSERT_LIBPED;
      LQry.ParamByName('AUTINC').AsString   := fRetAutoIncrem('LIBPED', VS_strCodEmp);
      LQry.ParamByName('NUMDOC').AsString   := LQryPD.FieldByName('FGO_NUMDOC').AsString;
      LQry.ParamByName('ESPDOC').AsString   := LQryPD.FieldByName('FGO_ESPDOC').AsString;
      LQry.ParamByName('CODEMP').AsString   := LQryPD.FieldByName('FGO_CODEMP').AsString;
      LQry.ParamByName('CODCLI').AsString   := LQryPD.FieldByName('FGO_CODCLI').AsString;
      LQry.ParamByName('CONPAG').AsString   := LQryPD.FieldByName('FGO_CONPAG').AsString;
      LQry.ParamByName('CODVEN').AsString   := LQryPD.FieldByName('FGO_CODVEN').AsString;
      LQry.ParamByName('CODDIG').AsString   := strLoginUsuarioLogado;
      LQry.ParamByName('DTACAD').AsDateTime := VS_Date;
      LQry.ParamByName('HORCAD').AsDateTime := fRetHoraServidor;
      LQry.ParamByName('VLRCON').AsFloat    := LQryPD.FieldByName('FGO_VLRCON').AsFloat;
      LQry.ParamByName('INFBLO').AsString   := AMotBlo;
      LQry.ParamByName('INFLIB').AsString   := AMotBlo;
      LQry.ExecSQL;
    except on E: Exception do
      raise;
    end;
  finally
    FreeAndNil(LQry);
    FreeAndNil(LQryPD);
  end;
end;

procedure TfrmFatExpedicao.pRemoveListaSelecao;
  Var
    objPedido: TObject;
    intIndex: Integer;
begin
  intIndex := stlPedidos.IndexOf(fField('AUTINC').AsString);
  If intIndex > -1 Then
  Begin
    objPedido := stlPedidos.Objects[intIndex];
    stlPedidos.Delete(intIndex);
    If Assigned(objPedido) Then
      FreeAndNil(objPedido);

    FValorContabilTotalDocSelecionados := FValorContabilTotalDocSelecionados
                                        - fField('VLRCON').AsFloat;

    FPesoTotalDocSelecionados          := FPesoTotalDocSelecionados
                                        - fField('PESBRU').AsFloat;

    FVolumeTotalDocSelecionados        := FVolumeTotalDocSelecionados
                                        - fField('VOLUME').AsFloat;

    FCubagemTotalDocSelecionados       := FCubagemTotalDocSelecionados
                                        - fField('CUBAGEM').AsFloat;

    FValorTotalDocSelecionados        := FValorTotalDocSelecionados
                                        - fField('VALDOC').AsFloat;
  End;

  If (stlPedidos.Count <= 0) Then
    blnPermiteExpedirPedidoAVistaCaixaFechado := False;

  pCarregarInformacoesPnlDocumentoSelecionados;
end;

procedure TfrmFatExpedicao.pResumo;
  Var
    qryResumo : TUniQuery;
Begin
  If not fEmptyStr(fCommaText(stlPedidos, True)) Then
  Begin
    Try
      qryResumo := fCriaQuery(Self);
      With qryResumo, SQL Do
      Begin
        Add(' SELECT SUM((FDO_QTDITE - FDO_QTDBAI) * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS VLRTOT, ');
        Add('        SUM(FDO_QTDEXP * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS VLREXP,                ');
        Add('        SUM((FDO_QTDITE - FDO_QTDBAI - FDO_QTDEXP) * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS NAOEXP ');
        Add(' FROM FATDOR                                                   ');
        Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM           ');
        Add(' WHERE FDO_SEQGER IN (' + fCommaText(stlPedidos, True) + ')'    );

        Open;

        lblTotProdExp.Caption    := FormatFloat('#,##0.00', FieldByName('VLREXP').AsFloat);
        lblTotProdNotExp.Caption := FormatFloat('#,##0.00', FieldByName('NAOEXP').AsFloat);
        lblTotProd.Caption       := FormatFloat('#,##0.00', FieldByName('VLRTOT').AsFloat);

        blnExpedicaoParcial := (FieldByName('VLREXP').AsFloat < FieldByName('VLRTOT').AsFloat);

        Close;
      End;
    Finally
      FreeAndNil(qryResumo);
    End;
  End
  Else
  Begin
    blnExpedicaoParcial      := False;
    lblTotProdExp.Caption    := '0,00';
    lblTotProdNotExp.Caption := '0,00';
    lblTotProd.Caption       := '0,00';
  End;

End;

procedure TfrmFatExpedicao.pDisableControlsInterna;
begin
  intPosicaoCds := cdsPedidos.RecNo;
  cdsPedidos.DisableControls;
end;

procedure TfrmFatExpedicao.pEnableControlsInterna;
begin
  If (intPosicaoCds > 0) And (intPosicaoCds <= cdsPedidos.RecordCount) Then
    cdsPedidos.RecNo := intPosicaoCds;
  cdsPedidos.EnableControls;
end;

procedure TfrmFatExpedicao.pEncerraThreadNotificacao;
begin
  If (Assigned(thrNotificacao)) Then
  Begin
    tmrTmpIan.Enabled := False;
    Sleep(500);

    If (thrNotificacao.Started) Then Begin
      thrNotificacao.Terminate();
    End;

    thrNotificacao.Free();
  End;
end;

procedure TfrmFatExpedicao.pEscolherViaConferencia;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  strViaConferenciaSeparacao := 'A';

  If (fCfgSis('TIPCNS', varBoolean)) Then
  Begin
    If fMensagem('','Conferência Via:',['&AUTCOM','&COLETOR'], 1) = 2 Then
     strViaConferenciaSeparacao := 'C';
  End;
end;

function TfrmFatExpedicao.fEhMarketPlace: Boolean;
begin
  Result := fField('ORIPED').AsString = 'P';
end;

function TfrmFatExpedicao.fEhPedidoGarantiaEnvioParaOCliente: Boolean;
  var
    strSeqGerPedidos : String;
Begin
  strSeqGerPedidos := fCommaText(stlPedidos, True);

  if (fEmptyStr(strSeqGerPedidos)) then
    Exit(False);

  Result := TGarantiaPropriaEmpresaCancelamento.fEhPedidoReposicaoGarantia(strSeqGerPedidos);
End;

function TfrmFatExpedicao.fPedidoGarantiaEnvioParaOClienteTotalmenteFaturado: Boolean;
  var
    strSeqGerPedidos : String;
   qryResumo : TUniQuery;
Begin
  strSeqGerPedidos := fCommaText(stlPedidos, True);
  if (fEmptyStr(strSeqGerPedidos)) then
    Exit(True);
  qryResumo := fCriaQuery;
  Result := True;
  Try
    qryResumo := fCriaQuery(Self);
    With qryResumo, SQL Do
    Begin
      Add(' SELECT FATDOR.AUTOINCREM, FDO_CODITE, FDO_REPGAR, ((FDO_QTDITE - FDO_QTDBAI - FDO_QTDEXP) * FDO_UNITAR) AS NAOEXP ');
      Add(' FROM FATDOR                                                   ');
      Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM           ');
      Add(' WHERE FDO_SEQGER IN (' + strSeqGerPedidos + ')'    );
      Open;
    End;

    QryResumo.First;
    While Not QryResumo.Eof do
    begin
      if (QryResumo.FieldByName('FDO_REPGAR').AsString = '2') Then
      begin
        if qryResumo.FieldByName('NAOEXP').AsFloat <> 0 then
        begin
          Result := False;
          pMensagemOk(Format('Pedido de Garantia: o Item %s foi reprovado e deve ser totalmente expedido.',
                             [QryResumo.FieldByName('FDO_CODITE').AsString]));
          Exit;
        end;
      end;
      QryResumo.next;
    end;

  Finally
    FreeAndNil(qryResumo);
  End;
End;

procedure TfrmFatExpedicao.pExibeResumo;
  Var
    qryResumo : TUniQuery;
    strSeqGerPedidos : String;
Begin
  if not Assigned(stlPedidos) then
    Exit;

  strSeqGerPedidos := fCommaText(stlPedidos, True);

  if (fEmptyStr(strSeqGerPedidos)) then
    Exit;

  qryResumo := fCriaQuery(Self);
  Try
    With qryResumo, SQL Do
    Begin
      Add(' SELECT SUM((FDO_QTDITE - FDO_QTDBAI) * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS VLRTOT, ');
      Add('        SUM(FDO_QTDEXP * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS VLREXP,                ');
      Add('        SUM((FDO_QTDITE - FDO_QTDBAI - FDO_QTDEXP) * ((FDO_TOTITE - FDO_DESESP)/FDO_QTDITE)) AS NAOEXP ');
      Add(' FROM FATDOR                                                   ');
      Add(' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM           ');
      Add(' WHERE FDO_SEQGER IN (' + strSeqGerPedidos + ')'    );

      Open;

      fMensagem('RESUMO', 'Total de Produtos Expedidos: ' + FormatFloat('#,##0.00', FieldByName('VLREXP').AsFloat) + #13#10 +
                          'Total de Produtos NÃO Expedidos: ' + FormatFloat('#,##0.00', FieldByName('NAOEXP').AsFloat) + #13#10 +
                          'Total de Produtos do Pedido: ' + FormatFloat('#,##0.00', FieldByName('VLRTOT').AsFloat), ['&OK']);

      blnExpedicaoParcial := (FieldByName('VLREXP').AsFloat < FieldByName('VLRTOT').AsFloat);

      Close;
    End;
  Finally
    FreeAndNil(qryResumo);
  End;
End;

procedure TfrmFatExpedicao.pExpedirFaturarTodosPedidosAutomaticamente;
var
  arrPedidos: TArray<String>;
  strAutIncPed: String;
begin
  If cdsPedidos.IsEmpty Then
    Exit;

  If Not fPergunta('Confirma faturar todos os pedidos?') Then
    Exit;

  If (Length(arrTransportadora) = 0) Then
    If Not fPergunta('Não foi informado nenhum filtro de transportadora. '+
      'Deseja continuar com o faturamento dos pedidos?') Then
      Exit;

  Try
    pLimparSelecaoELocks;
    dbgPedidos.SelectedRows.Clear;

    SetLength(arrPedidos, 0);

    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      pAddDados(arrPedidos, dtsPedidos.DataSet.FieldByName('AUTINC').AsString);
      cdsPedidos.Next;
    End;

    For strAutIncPed In arrPedidos Do
    Begin
      blnFaturandoTodosAutomaticamente := True;
      Try
        If Not cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
          Continue;

        pSelecionaVariosPedidos();

        If fSelecionado(cdsPedidos) Then
          btnConfirma.Click;
      Finally
        blnFaturandoTodosAutomaticamente := False;
        pLimparSelecaoELocks;
        pLimpaVariaveisSelecaoPedidos;
      End;
    End;

  Finally
    TFrmGravando.fExecutarModal( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');
  End;

end;

function TfrmFatExpedicao.fDeveLimparOsCamposDeCapaDaBaixaDeSeparacao: Boolean;
begin
  Result := True;

  If ((fCfgSis('LMCBSE', varBoolean)) And (fCfgSis('BAISEP', varBoolean))) Then
    Exit;

  If (fDeveLimparOsCamposDaBaixaDeSeparacao) Then
    Exit;

  Result := False;
end;

function TfrmFatExpedicao.fDeveLimparOsCamposDaBaixaDeSeparacao: Boolean;
begin
  Result := True;

  If ((fCfgSis('LMCBTO', varBoolean)) And (fCfgSis('LMCBSE', varBoolean)) And (fCfgSis('BAISEP', varBoolean))) Then
    Exit;

  If (fUsaExpedicaoPedidoSemUsarBaixaSeparacao) Then
    Exit;

  Result := False;
end;

function TfrmFatExpedicao.fUsaExpedicaoPedidoSemUsarBaixaSeparacao: Boolean;
begin
  Result := (fUsaRotinaWMS) And ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And (fCfgExpedicaoParcialHabilitada) And (Not fCfgSis('BAISEP', varBoolean));
end;

function TfrmFatExpedicao.fValidaClientesPedidos(blnMostraMsg: Boolean = True):Boolean;
var
  intIndex: Integer;
  strCodCliAux: String;
begin
  Result := True;

  If (stlPedidos.Count <= 0) Then
    Exit;

  If (Not (Pos(VS_strTipExp, '3_4_') > 0)) Then
    Exit;

  strCodCliAux := TPedidoVenda(stlPedidos.Objects[0]).strCodCli;
  For intIndex := 0 To PRed(stlPedidos.Count) Do
  Begin
    If (strCodCliAux <> TPedidoVenda(stlPedidos.Objects[intIndex]).strCodCli) And (not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
    Begin
      fMensagem('ATENÇÃO!', 'Inconsistência de cliente na expedição! ' + #10+#13 +
                            'Atualize os documentos a serem expedidos e informe a Citel sobre essa notificação!', ['&Ok']);
      Exit(False);
    End;
  End;
end;

procedure TfrmFatExpedicao.pExpedirPedidos(const strTipExpPar: String; blnExpAut : Boolean = False; strCodBarrasExp: String = ''; blnPermiteExpParcial: Boolean = False; blnFaturarExpedidos: Boolean = False);
  Var
    intContador: Integer;

    strCtrNumDup: String;
    strCtrEspDoc: String;
    strCtrCodEmp: String;
    strCtrCodCli: String;
    blnTemRec   : Boolean;
    blnTemAdt   : Boolean;
    blnBolAdt   : Boolean;
    blnConfirmou: Boolean;
    strPedido   : String;
    strCliente  : String;
    strCodClie  : String;
    strBookMa : TBookmark;
    strNumDocSel: String;
    strCodVen   : String;
    strNomTra   : String;

    strFdoSeqGerExpPar: String;
    strFdoAutIncExpPar: String;
    strFdoSeqGerComExp: String;
    strFdoAutIncComExp: String;

    LstrSeparador : String;
    blnBenFutTmp : Boolean;
    strCfgENFUOPtmp : String;
    blnLimpouSelecaoELocks : Boolean;
    fltPesoPDSelecionado : Double;
    frmFatExpedicaoItens : TfrmFatExpedicaoItens;

    procedure pRearmaTravasVendaPerdidaAutomatica();
    Var
      objPedido: TPedidoVenda;
      intIndex: Integer;
      strChaLck: String;
    begin
      If (blnLimpouSelecaoELocks) And (blnVendaPerdidaAutomatica) And Assigned(stlPedidos) Then
      Begin
        For intIndex := 0 To PRed(stlPedidos.Count) Do
        Begin
          objPedido := TPedidoVenda(stlPedidos.Objects[intIndex]);

          strChaLck := 'FATGOR' + objPedido.strNumDoc + objPedido.strEspDoc + objPedido.strCodEmp;
          objLock.fLock_Unlock(strChaLck, True, False);

          strChaLck := 'CADREC' + objPedido.strNumDoc + objPedido.strEspDoc + objPedido.strCodEmp + objPedido.strCodCli;
          objLock.fLock_Unlock(strChaLck, True, False);
        End;
      End;
    end;

    function fGetWhereItensSeparadosUtilizandoLocTransitoria(const AAlias: String): String;
    begin
      Result := '';

      if (not fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO) then
        Exit;

      Result := Result + '  AND NOT EXISTS ( ';
      Result := Result + '    SELECT LD.LDO_SEQFDO FROM LOTDOR LD ';
      Result := Result + '    INNER JOIN FATDOR FD ON LD.LDO_SEQFDO = FD.AUTOINCREM ';
      Result := Result + '    WHERE FD.FDO_SEQGER = ' + AAlias + '.FDO_SEQGER) ';
    end;

    procedure pCompletaListaExpedicaoParcialComPedidosSeparadosComDivergenciaPeloColetor(AAutoincremFATGOR : String);
      var
        LQryAux : TUniQuery;
    begin

      If AAutoincremFATGOR.IsEmpty Then
        Exit;

      LQryAux := fCriaQuery();

      Try

        LQryAux.SQL.Add('SELECT ');
        LQryAux.SQL.Add('  F.FDO_SEQGER AS SEQGER, ');
        LQryAux.SQL.Add('  L.LDO_SEQFDO AS SEQFDO ');
        LQryAux.SQL.Add('FROM ');
        LQryAux.SQL.Add('  FATDOR F ');
        LQryAux.SQL.Add('  INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = F.AUTOINCREM) ');
        LQryAux.SQL.Add('  INNER JOIN EXTDOR E ON (E.FDO_SEQFDO = F.AUTOINCREM) ');
        LQryAux.SQL.Add('WHERE ');
        LQryAux.SQL.Add('  F.FDO_SEQGER IN ('+AAutoincremFATGOR+') AND ');
        LQryAux.SQL.Add('  L.LDO_SEPCOL = "S" AND ');
        LQryAux.SQL.Add('  (IFNULL(L.LDO_QTDSEP, 0) = 0) AND ');
        LQryAux.SQL.Add('  (IFNULL(E.FDO_QTDSEP, 0) = 0) ');

        LQryAux.SQL.Add(fGetWhereItensSeparadosUtilizandoLocTransitoria('F'));
        LQryAux.Open;

        If Not LQryAux.IsEmpty Then
        Begin
          LQryAux.First;
          While Not LQryAux.Eof Do
          Begin
            pIncrementaListaStr(LQryAux.FieldByName('SEQGER').AsString, strFdoSeqGerExpPar, True);
            pIncrementaListaStr(LQryAux.FieldByName('SEQFDO').AsString, strFdoAutIncExpPar, True);
            LQryAux.Next;
          End;
        End;

      Finally
        FreeAndNil(LQryAux);
      End;

    end;

    procedure pCompletaListaExpedicaoParcialComPedidosExpedidosPoremAindaAbertos(strFdoSeqGer: String);
      Var
        qryAux : TUniQuery;
    Begin
      If (fDeveLimparOsCamposDaBaixaDeSeparacao) Then
      Begin
        If Not fEmptyStr(strFdoSeqGer) Then
        Begin
          qryAux := fCriaQuery(Nil);
          Try
            With qryAux Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add('SELECT'); 
              SQL.Add('  FATGOR.AUTOINCREM AS AUTINC,'); 
              SQL.Add('  IF((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) = SUM(EXTDOR.FDO_QTDEXP), "S", "N") AS EXPTOT'); 
              SQL.Add('FROM'); 
              SQL.Add('  FATGOR'); 
              SQL.Add('  INNER JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO'); 
              SQL.Add('  INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER AND FDO_JAFATU = 0'); 
              SQL.Add('  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO'); 
              SQL.Add('WHERE FATGOR.FGO_JAFATU = 0');
              SQL.Add('  AND FATGOR.AUTOINCREM IN ('+strFdoSeqGer+')');
              SQL.Add('  AND (SELECT COUNT(*) FROM LOTDOR WHERE LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM) = 0');

              SQL.Add(fGetWhereItensSeparadosUtilizandoLocTransitoria('FATDOR'));

              SQL.Add('GROUP BY FATGOR.AUTOINCREM');
              Open;
              First;

              While Not qryAux.Eof Do
              Begin
                If (qryAux.FieldByName('EXPTOT').AsString = 'N') Then
                  pIncrementaListaStr(qryAux.FieldByName('AUTINC').AsString, strFdoSeqGerExpPar, True);
                
                qryAux.Next;
              End;

              Close;
              SQL.Clear;
              SQL.Add('SELECT'); 
              SQL.Add('  FATDOR.AUTOINCREM AS AUTINC,'); 
              SQL.Add('  IF((FDO_QTDITE - FDO_QTDBAI) = (EXTDOR.FDO_QTDEXP), "S", "N") AS EXPTOT'); 
              SQL.Add('FROM'); 
              SQL.Add('  FATDOR');
              SQL.Add('  INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO');
              SQL.Add('WHERE FATDOR.FDO_JAFATU = 0');
              SQL.Add('  AND FATDOR.FDO_SEQGER IN ('+strFdoSeqGer+')');
              SQL.Add('  AND (SELECT COUNT(*) FROM LOTDOR WHERE LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM) = 0');

              SQL.Add(fGetWhereItensSeparadosUtilizandoLocTransitoria('FATDOR'));

              Open;
              First;

              While Not qryAux.Eof Do
              Begin
                If (qryAux.FieldByName('EXPTOT').AsString = 'N') Then
                  pIncrementaListaStr(qryAux.FieldByName('AUTINC').AsString, strFdoAutIncExpPar, True);
                
                qryAux.Next;
              End;
            End;
          Finally
            FreeAndNil(qryAux);
          End;
        End;

        pCompletaListaExpedicaoParcialComPedidosSeparadosComDivergenciaPeloColetor(strFdoSeqGer);

      End;
    End;

    procedure pDesmarcaSepImp(strFdoSeqGer: String; strFdoAutInc: String);
      Var
        qryAux : TUniQuery;
        objSeparacaoFina : TSeparacaoFina;
    Begin
      If Not fEmptyStr(strFdoSeqGer + strFdoAutInc) Then
      Begin
        qryAux := fCriaQuery(Nil);
        Try
          With qryAux Do
          Begin
            Close;
            SQL.Clear;

            SQL.Add('UPDATE    ');
            SQL.Add('  FATGOR, ');
            SQL.Add('  EXTGOR  ');
            SQL.Add('SET  ');

            If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) And (fUsaExpedicaoPedidoSemUsarBaixaSeparacao) Then
              SQL.Add(' FGO_OPEEXP = NULL, ');

            SQL.Add('  FGO_SEPIMP = "0",  ');
            SQL.Add('  FGO_DTIMSE = NULL, ');
            SQL.Add('  FGO_HRIMSE = NULL, ');
            SQL.Add('  FGO_SEPEXP = NULL, ');
            SQL.Add('  FGO_PEDIMP = "N",  ');

            {Remessa de Separação}
            SQL.Add('  FGO_SEQOND = NULL, ');
            SQL.Add('  FGO_DTAOND = NULL, ');
            SQL.Add('  FGO_ONDUNI = "N",  ');
            SQL.Add('  FGO_ONDKIT = NULL, ');

            {Remessa de Pedido/Onda de Separação}
            SQL.Add('  FGO_SEQSEP = NULL, ');
            SQL.Add('  FGO_ONDAOP = NULL, ');
            SQL.Add('  FGO_ONDADT = NULL, ');
            SQL.Add('  FGO_ONDAHR = NULL  ');

            If (fDeveLimparOsCamposDeCapaDaBaixaDeSeparacao) Then
              SQL.Add(', FGO_OPBXSE = NULL, FGO_DTBXSE = NULL, FGO_HRBXSE = NULL ');

            SQL.Add('WHERE ');
            SQL.Add('  FATGOR.AUTOINCREM IN ('+strFdoSeqGer+') AND ');
            SQL.Add('  FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO       ');

            ExecSQL;

            If (fDeveLimparOsCamposDaBaixaDeSeparacao) Then
            Begin
              If Not fEmptyStr(strFdoAutInc) Then
              Begin
                Close;
                SQL.Clear;

                SQL.Add('UPDATE    ');
                SQL.Add('  EXTDOR, ');
                SQL.Add('  FATDOR  ');
                SQL.Add('SET  ');
                SQL.Add('  FDO_QTDSEP = FDO_QTDBAI, ');
                SQL.Add('  FDO_OPBXSE = NULL, ');
                SQL.Add('  FDO_DTBXSE = NULL, ');
                SQL.Add('  FDO_HRBXSE = NULL  ');
                SQL.Add('WHERE '); 
                SQL.Add('  FATDOR.AUTOINCREM  IN ('+strFdoAutInc+') AND ');
                SQL.Add('  FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO        ');
                ExecSQL;
              End;

              If Not fEmptyStr(strFdoSeqGer) Then
              Begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT FGO_NUMDOC, FGO_CODEMP ');
                SQL.Add('  FROM FATGOR ');
                SQL.Add(' WHERE AUTOINCREM IN ('+strFdoSeqGer+') ');
                Open;
                First;

                While Not qryAux.Eof Do
                Begin
                  objSeparacaoFina := TSeparacaoFina.Create(tdsPedido, qryAux.FieldByName('FGO_CODEMP').AsString);
                  try
                    objSeparacaoFina.strNumeroDocumento := qryAux.FieldByName('FGO_NUMDOC').AsString;
                    objSeparacaoFina.pLimpaSeparacaoEConferenciaStatus;
                  finally
                    FreeAndNil(objSeparacaoFina);
                  end;

                  qryAux.Next;
                End;
              End;
            End;
          End;
        Finally
          FreeAndNil(qryAux);
        End;
      End;
    End;

begin
  inherited;

  If Not btnConfirma.Visible Then
  Begin
    Exit;
  End;

  If (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And fOndaSeparacao Then
  Begin
    If (dbgPedidos.SelectedRows.Count = 0) Then
      dbgPedidos.SelectedRows.CurrentRowSelected := True;

    For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
    Begin
      dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);
      pAdicionaListaSelecao;
    End;
  End;

  If (stlPedidos.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um pedido.', ['&Ok']);
    Exit;
  End;

  If (Not fValidaClientesPedidos) Then
    Exit;

  If (fTravaAliquota) Then
    Exit;

  If (THorOpe.fExisteRestricoesDeAcesso(resVenda, True)) Then
    Exit;

  blnLimpouSelecaoELocks := False;

  if blnFaturarExpedidos and
     btnDesmExpedidos.Visible and
     (not fVerificaDesmembramento(blnLimpouSelecaoELocks)) then
    Exit;

  If (blnLimpouSelecaoELocks) And (Not blnVendaPerdidaAutomatica) Then
    Exit;

  If (blnVendaPerdidaAutomatica) and Assigned(stlPedidos) and Assigned(stlPedidosBkp) then
  begin
    stlPedidos.Clear;
    {*********************************************************************************}
    {* Ao atribuir diretamente uma stringlist à outra (stlPedidos := stlPedidosBkp), *}
    {* ao limpar a stringlist auxiliar (stlPedidosBkp.Clear), a stringlist principal *}
    {* também é afetada. Usando "Assign", não ocorre esse problema.                  *}
    {*REQ.245001*******************************************************************RP*}
    stlPedidos.Assign(stlPedidosBkp);
  end;

  if ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) and
     (strBotaoAcionado = 'F10') and
     (not fDebitoCliente()) then
    Exit;

  If ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And (fField('ESPDOC').AsString = 'PD') Then
  Begin
    If Not fPermiteFaturamentoPedidoComItemEstruturaSemOrdemProducao(fField('NUMDOC').AsString, fField('CODEMP').AsString, objLiberacao) Then
      Exit;
  End;

  pRearmaTravasVendaPerdidaAutomatica();

  strCtrNumDup := '';
  strCtrEspDoc := '';
  strCtrCodEmp := '';
  strCtrCodCli := '';
  LstrSeparador := '';
  strFdoSeqGerExpPar := '';
  strFdoAutIncExpPar := '';
  strFdoSeqGerComExp := '';
  strFdoAutIncComExp := '';
  blnConfirmou := False;
  strNumDocSel := '';

  blnTemAdt := False;
  blnBolAdt := False;
  blnTemRec := False;
  blnBenFutTmp := False;
  strCfgENFUOPtmp := '';

  If (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Then
    If Not fOndaSeparacao And Not blnFaturandoTodosAutomaticamente Then
      pExibeResumo;

  If fCfgSis('CDTCLV', varBoolean) Then
  Begin
    If (Not fTodosOsFaturamentosIguais(stlPedidos)) Then
      Exit;

    If (fExistePedidoNormalComCilindroVasilhameNaoFaturado(stlPedidos)) Then
      Exit;
  End;

  pCriarFormularios(TfrmFatExpedicaoItens, frmFatExpedicaoItens);
  Try
    If Not Assigned(frmFatExpedicaoItens) Then
      Exit;

    blnEmExpedicaoItens := True;
    pSuspenderTimersRecarga;

    frmFatExpedicaoItens.Params.blnSolicitaTelaDeVolume := blnSolicitaTelaDeVolume;
    frmFatExpedicaoItens.Params.blnPermiteExpedirPedidoAVistaCaixaFechado := blnPermiteExpedirPedidoAVistaCaixaFechado;

    Try

      With cdsPedidos Do
      Begin
        strPedido := '';
        strCliente := '';
        strCodClie := '';
        strCodVen  := '';
        strNomTra  := '';
        fltPesoPDSelecionado := 0;
        strBookMa := Bookmark;
        DisableControls;
        First;
        blnScrollPedidos := False;
        Filtered := False;
        While Not Eof Do
        Begin
          If fSelecionado(cdsPedidos) Then
          Begin

            if (TYapayFacade.fPedidoPossuiCobrancaAtiva(fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString)) and
               (not TYapayFacade.fPedidoFoiPago(fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString)) then
            begin
              fMensagem('Yapay',
                        'Pedido ' +
                        fField('NUMDOC').AsString + '-' +
                        fField('ESPDOC').AsString + '-' +
                        fField('CODEMP').AsString +
                        ' possuí Cobrança Yapay ativa!',
                        ['&OK']);
              blnConfirmou := False;
              blnScrollPedidos := True;
              Bookmark := strBookMa;
              EnableControls;
              Exit;
            end;

            if MatchStr(TPixDao.RetornaStatusSePedidoPossuirPix(fField('EMPPIX').AsString, fField('TX_PIX').AsString), STATUS_PIX_ATIVO) Then
            begin
              If MatchStr(strTipExpPar, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO]) Then
              Begin
                fMensagem('PIX',
                          'Pedido ' +
                          fField('NUMDOC').AsString + '-' +
                          fField('ESPDOC').AsString + '-' +
                          fField('CODEMP').AsString +
                          ' possuí cobrança Pix ativa!' + #13 +
                          'Realize o recebimento do Pix antes de continuar.',
                          ['&OK']);
                blnConfirmou := False;
                blnScrollPedidos := True;
                Bookmark := strBookMa;
                EnableControls;
                Exit;
              End;
            end;

          If fCampoTabela('CND_RECPIX', 'CADCND', ['CND_CODIGO'], [fField('CODCND').AsString]) = 'S' Then
          Begin
            If TPixDao.RetornaStatusSePedidoPossuirPix(fField('EMPPIX').AsString, fField('TX_PIX').AsString).IsEmpty THen
            Begin
              If fFormataFloat(fField('VALADT').AsFloat + fField('VALREC').AsFloat, 2) = 0 Then
              Begin
                If MatchStr(strTipExpPar, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO]) Then
                Begin
                  fMensagem('PIX',
                            'Pedido ' +
                            fField('NUMDOC').AsString + '-' +
                            fField('ESPDOC').AsString + '-' +
                            fField('CODEMP').AsString +
                            ' possui uma condição de pagamento Pix e esse foi removido ou expirado!' + #13 +
                            'Para continuar, gere um novo Pix e faça o recebimento ou altere sua condição de pagamento.',
                            ['&OK']);
                  blnConfirmou := False;
                  blnScrollPedidos := True;
                  Bookmark := strBookMa;
                  EnableControls;
                  Exit;
                End;
              End;
            End;
          End;

          strPedido := strPedido + IIF(fEmptyStr(strPedido), '', ' / ') +
                       fField('NUMDOC').AsString + '-' +
                       fField('ESPDOC').AsString + '-' +
                         fField('CODEMP').AsString;


            If (strCodClie <> fField('CODCLI').AsString) And (fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao)  Then
              strCliente := strCliente + IIF(fEmptyStr(strCliente), '', ' / ') + fField('CODCLI').AsString + ' - ' + fField('NOMCLI').AsString
            Else
              strCliente := fField('CODCLI').AsString + ' - ' + fField('NOMCLI').AsString;

            strCodClie   := fField('CODCLI').AsString;
            strNumDocSel := fField('NUMDOC').AsString;
            strCodVen    := fField('CODVEN').AsString;
            strNomTra    := fField('NOMTRA').AsString;

            fltPesoPDSelecionado := fltPesoPDSelecionado + fField('PESBRU').AsFloat;

            If fEmptyStr(LstrSeparador) Then
              LstrSeparador := fField('CODSEP').AsString;

            If (Not blnBenFutTmp) Then
              blnBenFutTmp := (fField('BENFUT').AsString = 'S');

            strCfgENFUOPtmp := fField('ENFUOP').AsString;

            If (stlPedidos.IndexOf(fField('AUTINC').AsString) = 0) Then
            Begin
              blnTemAdt := fFormataFloat(fField('VALADT').AsFloat, 2) > 0;
              blnBolAdt := fFormataFloat(fField('BOLADT').AsFloat, 2) > 0;
              blnTemRec := fFormataFloat(fField('VALREC').AsFloat, 2) > 0;

              If (blnTemAdt Or blnBolAdt Or blnTemRec) Then
              Begin
                strCtrNumDup := fField('NUMDOC').AsString;
                strCtrEspDoc := fField('ESPDOC').AsString;
                strCtrCodEmp := fField('CODEMP').AsString;
                strCtrCodCli := fField('CODCLI').AsString;
              End;
            End;
          End;

          Next;
        End;

        blnScrollPedidos := True;

        pFiltrarPedidos;
        pCalculaResumoTotalDocumentos();
        Bookmark := strBookMa;
        EnableControls;
      End;

      frmFatExpedicaoItens.Params.blnApenasConferenciaProdutosRetiraCaixa := blnApenasConferenciaProdutosRetiraCaixa;
      frmFatExpedicaoItens.Params.TipoItemDoPedidoOndaSeparacao := Self.FTipoItemDoPedidoOndaSeparacao;
      frmFatExpedicaoItens.Params.blnOndaSeparacao := fOndaSeparacao;
      frmFatExpedicaoItens.Params.blnFaturandoTodosAutomaticamente := blnFaturandoTodosAutomaticamente;
      frmFatExpedicaoItens.Params.strCodBarrasExp  := strCodBarrasExp;
      frmFatExpedicaoItens.btnEditarMensagem.Visible := btnMensagemExpedicao.Visible;
      frmFatExpedicaoItens.Params.cdsExpedicao := cdsPedidos;
      frmFatExpedicaoItens.Params.blnVendaPerdidaAutomatica := (fDesmembrarAutomaticamenteSemPerguntarGerandoVendasPerdidas and (blnFaturarExpedidos));
      frmFatExpedicaoItens.Params.blnFaturarExpedidos := blnFaturarExpedidos;

      If fEmptyStr(strCodBarrasExp) Then
        pLimparVariaveisSeparadorConferenteOndaSeparacao;

      frmFatExpedicaoItens.Params.strSeparador := LstrSeparador;

      If stlSeqFgo.Count > 0 Then
        frmFatExpedicaoItens.Params.cdsFilEst := cdsFilEst;

      frmFatExpedicaoItens.Params.blnExiPedRetiraExpAntFat := objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat;

      frmFatExpedicaoItens.Params.VS_strTipExpInterna := strTipExpPar;
      frmFatExpedicaoItens.Params.blnPermiteExpParcial := blnPermiteExpParcial;

      frmFatExpedicaoItens.Params.blnUsaImpressaoSeparacaoPorLocal := blnUsaImpressaoSeparacaoPorLocal;
      frmFatExpedicaoItens.Params.blnSepPorArmazem := (tfFiltroLocSepArmz = tfArmazem);

      frmFatExpedicaoItens.Params.blnCarregarQtdExpedida := (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Or
        ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO));

      frmFatExpedicaoItens.Params.blnAutSer := blnAutSer;

      frmFatExpedicaoItens.Caption := frmFatExpedicaoItens.Caption +
        ' - Pedido: ' + strPedido + ' - ' + strCliente + ' - ' +
        strCodVen + ' - ' + fRetNomVendRep(strCodVen) +
        IIF(Not fEmptyStr(strNomTra), ' - Transportadora: ' + strNomTra, '');

      frmFatExpedicaoItens.Params.blnTemRec   := blnTemRec;
      frmFatExpedicaoItens.Params.blnTemAdt   := blnTemAdt;
      frmFatExpedicaoItens.Params.blnBolAdt   := blnBolAdt;

      frmFatExpedicaoItens.Params.stlPedidos := stlPedidos;
      frmFatExpedicaoItens.Params.strCtrNumDup  := strCtrNumDup;
      frmFatExpedicaoItens.Params.strCtrEspDoc  := strCtrEspDoc;
      frmFatExpedicaoItens.Params.strCtrCodEmp  := strCtrCodEmp;
      frmFatExpedicaoItens.Params.strCtrCodCli  := strCtrCodCli;
      frmFatExpedicaoItens.Params.blnColetor    := blnColetor;
      frmFatExpedicaoItens.Params.blnExpParcialTipExp4 := blnExpedicaoParcial;
      frmFatExpedicaoItens.Params.strCodCli := strCodClie;
      frmFatExpedicaoItens.Params.blnExpAut := blnExpAut;
      frmFatExpedicaoItens.Params.blnBaiEntFut := blnBenFutTmp;
      frmFatExpedicaoItens.Params.strCfgENFUOP := strCfgENFUOPtmp;
      frmFatExpedicaoItens.Params.blnExpedicaoDePedidoDeConsignacao := FblnTemPedidoDeConsignacao;
      frmFatExpedicaoItens.Params.blnFreteRateado := blnFreRatSel;
      frmFatExpedicaoItens.Params.blnDescontoComercialZonaFranca := blnDecZfmSel;
      frmFatExpedicaoItens.Params.strRegimeEspecial := IIF(strRegEspSel = 'S', 'S', 'N');
      frmFatExpedicaoItens.Params.blnDesmembraPedRegEsp := IIF(strUtiResSel = 'S', True, False);
      frmFatExpedicaoItens.Params.strEmpresaSolicitanteAbastecimentoDeposito := strSolAbaSel;
      frmFatExpedicaoItens.Params.strPesoPedido := FormatFloat('#,##0.00 KG', fltPesoPDSelecionado);
      frmFatExpedicaoItens.Params.strBotaoAcionado := strBotaoAcionado;
      frmFatExpedicaoItens.Params.strNumDoc := fField('NUMDOC').AsString;
      frmFatExpedicaoItens.Params.strEspDoc := fField('ESPDOC').AsString;
      frmFatExpedicaoItens.Params.strCodEmp := fField('CODEMP').AsString;
      frmFatExpedicaoItens.Params.strEmpExp := fField('EMPEXP').AsString;
      frmFatExpedicaoItens.Params.strSerie_ := fField('SERIE_').AsString;
      frmFatExpedicaoItens.Params.blnExibirRetiraEntregaPedidosTransfFaturamentoAntExp := tipFiltroPedidoTransf = tfRetiraEEntrega;

      frmFatExpedicaoItens.ShowModal;

      blnConfirmou := frmFatExpedicaoItens.blnConfirmou;
      If blnConfirmou Then
      Begin
        strFdoSeqGerExpPar := frmFatExpedicaoItens.strFdoSeqGerExpPar;
        strFdoSeqGerComExp := frmFatExpedicaoItens.strFdoSeqGerComExp;
        strFdoAutIncComExp := frmFatExpedicaoItens.strFdoAutIncComExp;
      End
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pSelecionaPedido]');
    End;
  Finally
    blnEmExpedicaoItens := False;
    pRestaurarTimersRecarga;
    pFreeAndNil(frmFatExpedicaoItens);
    blnScrollPedidos := True;
  End;

  If blnConfirmou Then
  Begin
    If (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or fVoltarPDSepNaoImpressaEmExpedicaoParcial Then
    Begin
      pCompletaListaExpedicaoParcialComPedidosExpedidosPoremAindaAbertos(strFdoSeqGerComExp);
      pDesmarcaSepImp(strFdoSeqGerExpPar, strFdoAutIncExpPar);
    End;  

    if (blnApenasConferenciaProdutosRetiraCaixa) and (stlPedidos.Count > 0) then
      strUltimoPedidoRetiradaCaixa := fField('NUMDOC').AsString;

    Try
      pLimparSelecaoELocks;
      If Not blnFaturandoTodosAutomaticamente Then
        TFrmGravando.fExecutarModal( pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[pSelecionaPedido_1]');
      End;
    End;
  End;

  If (strTipExpPar = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And fOndaSeparacao Then
    pLimparSelecaoELocks;

  If blnFaturandoTodosAutomaticamente Then
    pLimparSelecaoELocks;

  If blnVendaPerdidaAutomatica Then
  Begin
    blnVendaPerdidaAutomatica := False;
    stlPedidosBkp.Clear;
  End;

End;

procedure TfrmFatExpedicao.pLiberaTravaVerificandoRomaneioEmAndamento(strChaLck: String);
Var
  blnLiberar: Boolean;
begin
  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    blnLiberar := (Not fVerificaLockAtivo(strChaLck + STR_TRAVA_ROMANEIO))
  Else
    blnLiberar := True;

  If blnLiberar Then
    objLock.fLock_Unlock(strChaLck, False, False, False, '', True, '', True, True, False, True);

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    objLock.fLock_Unlock(strChaLck + STR_TRAVA_CONFERENCIA, False, False, False, '', True, '', True, True, False, True);
end;

procedure TfrmFatExpedicao.pLimpaOndaSeparacao;
var
  LQry: TUniQuery;
begin
  If strNumeroOnda.IsEmpty Then
    Exit;

  LQry := fCriaQuery;

  Try
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('SELECT FGO_SEQFGO ');
    LQry.SQL.Add('FROM EXTGOR ');
    LQry.SQL.Add('WHERE FGO_SEQSEP = ' + QuotedStr(strNumeroOnda));
    LQry.ExecSQL;

    strNumeroOnda := '';

    while not LQry.Eof do
    begin
      if (not untFatGor.fLimpaExpedicaoPedido(LQry.FieldByName('FGO_SEQFGO').AsString, False, eeloExcluir)) then
        Exit;

      LQry.Next;
    end;
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TfrmFatExpedicao.pLimparSelecaoELocks;
Var
  intIndex: Integer;
begin
  pLimparSelecaoTotalmente;

  If (VS_strTipExp = '4') Then
  Begin
    For intIndex := Pred(objLock.fRetornaTravas.Count) DownTo 0 Do
      pLiberaTravaVerificandoRomaneioEmAndamento(objLock.fRetornaTravas[intIndex]);

    objLock.fRetornaTravas.Clear;
  End
  Else
    objLock.pDestravarTodos;
end;

procedure TfrmFatExpedicao.pLimparSelecaoTotalmente;
  Var
    objPedido: TObject;
    intContador: Integer;
begin
  fEmExpedicaoItens;//SOMENTE PARA REGISTRAR CASO SEJA CHAMADO COM frmFatExpedicaoItens ABERTO

  For intContador := 0 To stlPedidos.Count-1 Do
  Begin
    If Assigned(stlPedidos.Objects[intContador]) Then
    Begin
      objPedido := stlPedidos.Objects[intContador];
      FreeAndNil(objPedido);
    End;
  End;

  stlPedidos.Clear;
  blnPermiteExpedirPedidoAVistaCaixaFechado := False;
end;

procedure TfrmFatExpedicao.pLimparSeparacaoParaColetor(const strNumDoc,
  strEspDoc, strCodEmp: String);
var
  qryDados : TUniQuery;
begin
  If Not fAtivadoMontagemCaixaConferenciaAUTCOMColetor Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'UPDATE EXTGOR '
                       + '   SET FGO_TIPCNS = NULL '
                       + ' WHERE FGO_SEQFGO = (SELECT AUTOINCREM FROM FATGOR '
                       + '                      WHERE FGO_NUMDOC = :NUMDOC '
                       + '                        AND FGO_ESPDOC = :ESPDOC '
                       + '                        AND FGO_CODEMP = :CODEMP) ';

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.ExecSQL;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TfrmFatExpedicao.fLiberaLimparPedidoOndaSeparacao: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir limpar o pedido que pertence a uma onda de separação.');

  objLiberacao.strDirAce := 'LSEPON';
  objLiberacao.strMsgSen := 'Expedição - Limpar Separação de Pedido';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

function TfrmFatExpedicao.fLiberouLimparSeparacaoItensExpedidos: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Limpar separação de pedidos com produtos já expedidos');

  objLiberacao.strDirAce := 'LISEEX';
  objLiberacao.strMsgSen := 'Limpar separação de pedidos com produtos já expedidos';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

function TfrmFatExpedicao.fLimpaExpedicaoParcialPedido(strAutInc: String; blnFatAut: Boolean = False; ASeqsFDO: String = ''): Boolean;
  Var
    LNumDoc, LEspDoc, LCodEmp: String;
    LQtdSep, LSeqSep: Integer;
    objCampoTabela: IMyCampoTabela;
begin
  Result := False;

  objCampoTabela := fCampoTabela(['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], 'FATGOR', ['AUTOINCREM'], [strAutInc]);

  LNumDoc := objCampoTabela.FieldByName('FGO_NUMDOC').AsString;
  LEspDoc := objCampoTabela.FieldByName('FGO_ESPDOC').AsString;
  LCodEmp := objCampoTabela.FieldByName('FGO_CODEMP').AsString;

  LQtdSep := GetQuantSeparacaoJaImpressa(LNumDoc, LEspDoc, LCodEmp);

  If (LQtdSep > 0) Then
  Begin
    If SelecionaSeparacaoParcial(LNumDoc, LEspDoc, LCodEmp, LSeqSep, True) Then
    Begin
      //se tem somente uma separação parcial, ou se marcou pra
      //limpar todas, limpa a separação pelo processo normal
      If (LQtdSep = 1) Or (LSeqSep = -1) Then
        Result := untFatGor.fLimpaExpedicaoPedido(strAutInc, blnFatAut, IIF(FExcluirExtLar, eeloExcluir, eeloNaoExcluir), True, ASeqsFDO)
      Else
        Result := LimpaSeparacaoParcialPedido(LNumDoc, LEspDoc, LCodEmp, LSeqSep);
    End;

    Exit;
  End;

  Result := untFatGor.fLimpaExpedicaoPedido(strAutInc, blnFatAut, IIF(FExcluirExtLar, eeloExcluir, eeloNaoExcluir));
end;

function TfrmFatExpedicao.fLimpaExpedicaoPedido(strAutInc: String; blnFatAut: Boolean = False; ASeqsFDO: String = ''): Boolean;
begin
  If fImpressaoParcialConsiderandoJaImpresso Then
    Result := fLimpaExpedicaoParcialPedido(strAutInc, blnFatAut, ASeqsFDO)
  Else
    Result := untFatGor.fLimpaExpedicaoPedido(strAutInc, blnFatAut, IIF(FExcluirExtLar, eeloExcluir, eeloNaoExcluir), True, ASeqsFDO);
end;

function TfrmFatExpedicao.fLimparSeparacaoDosPedidosSelecionados(pgbStatus: TcxProgressBar = Nil) : Boolean;
var
  strAutIncPed : String;
  intEtapa     : Integer;
  arrSeqOnd    : Array of String;
  strSeqOnd    : String;
begin

  Result := True;

  Try

    intEtapa  := 0;
    SetLength(arrSeqOnd, 0);
    strSeqOnd := '';
    pInformacao('Aguarde... Limpando separação dos pedidos selecionados!', pgbStatus);

    For strAutIncPed In stlPedidos Do
    Begin

      If (Not strAutIncPed.IsEmpty) Then
        If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
        begin
          if fPodeGuardarItensSeparados then
          begin
            fGuardarItensSeparados;
            Continue;
          end;

          if (not fEmptyStr(fField('SEQOND').AsString)) and (strSeqOnd <> fField('SEQOND').AsString) then
          begin
            strSeqOnd := fField('SEQOND').AsString;

            SetLength(arrSeqOnd, Length(arrSeqOnd) + 1);
            arrSeqOnd[Pred(Length(arrSeqOnd))] := strSeqOnd;
          end;

          If (fField('SEPIMP').AsString = '1') Or fPedidoJahImpresso(fField('AUTINC').AsString) Then
            Self.fLimpaExpedicaoPedido(strAutIncPed, fField('FATAUT').AsString.Equals('S'));

          if cdsDocsExcluirLoteSep.Active and (not cdsDocsExcluirLoteSep.IsEmpty) and
             cdsDocsExcluirLoteSep.Locate('AUTINC', fField('AUTINC').AsString, []) then
            if cdsDocsExcluirLoteSep.FieldByName('SELECI').AsBoolean then
            begin
              fExcluiDocumentoLoteSeparacao(
                cdsDocsExcluirLoteSep.FieldByName('AUTINCLOTSEP').AsString,
                cdsDocsExcluirLoteSep.FieldByName('NUMDOC').AsString,
                cdsDocsExcluirLoteSep.FieldByName('ESPDOC').AsString,
                cdsDocsExcluirLoteSep.FieldByName('CODEMP').AsString);
            end;

          pDeletaSepDor(strAutIncPed);
        end;

      pProgresso(fInc(intEtapa), stlPedidos.Count, pgbStatus);
    End;

  Except
    Result := False;
  End;
end;

procedure TfrmFatExpedicao.pLimparVariaveisSeparadorConferenteOndaSeparacao;
begin
  TfrmFatExpedicaoItens.strCodSepOnda := '';
  TfrmFatExpedicaoItens.strCodConOnda := '';
  TfrmFatExpedicaoItens.strObsExpOnda := '';
end;

procedure TfrmFatExpedicao.pLimpaSeparacaoPedido(const AExcluiDocumentoLoteSeparacao: Boolean; const AAutIncLotSep: String);
begin
  fStartTransaction;

  try
    if fPodeGuardarItensSeparados then
    begin
      fGuardarItensSeparados;
      fCommit();
    end
    else
    begin
      if Self.fLimpaExpedicaoPedido(fField('AUTINC').AsString, fField('FATAUT').AsString.Equals('S')) then
      begin
        if AExcluiDocumentoLoteSeparacao then
          fExcluiDocumentoLoteSeparacao(
            AAutIncLotSep,
            fField('NUMDOC').AsString,
            fField('ESPDOC').AsString,
            fField('CODEMP').AsString);

        pLimparSeparacaoParaColetor(
            fField('NUMDOC').AsString,
            fField('ESPDOC').AsString,
            fField('CODEMP').AsString);

        fCommit();
        pDeletaSepDor(fField('AUTINC').AsString);

        If (fExisteTransferenciaArmazemOuLoteVendaComTinta(fField('NUMDOC').AsString,
                                                           fField('ESPDOC').AsString,
                                                           fField('CODEMP').AsString)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O documento selecionado já teve a fórmula separada no coletor, '
                              + 'o que gerou uma movimentação de estoque entre o lote picking '
                              + '(saída) e o lote principal para tinta de máquina (entrada), que '
                              + 'é do laboratório. Após limpar a separação, o saldo não vai retornar '
                              + 'ao lote de origem. Favor verificar a necessidade e realizar a '
                              + 'transferência do saldo do lote do laboratório para o endereço/lote '
                              + 'de origem.', ['&Ok']);
        End;
      end
      Else
        fRollBack();
    end;

    pAtivaDesativaTimersNotificaoAndRecarga(True);
  except
    on E: Exception do
    begin
      fRollBack;
      pAtivaDesativaTimersNotificaoAndRecarga(True);

      if E.Message.ToUpper.Contains('LTTAPC')  then
        pMensagemOk(E.Message)
      else
        pMensagensErro(E.message, 'TfrmFatExpedicao.pLimpaSeparacaoPedido');
    end;
  end;
end;

procedure TfrmFatExpedicao.pTotalizadoresLinhasSelecionadas;
var
  intContSel: Integer;
  cdsClone: TZClient;
  fltPesoTotal: Double;
  fltVolumeTotal: Double;
  intQtdOnda: Integer;
begin
  if (not Assigned(cdsPedidos)) and (not cdsPedidos.Active) then
    Exit;

  lblPesoTotal.Visible    := (dbgPedidos.SelectedRows.Count > 1) and fVerificaAcessoSistema('EXPSPD');
  lblPesoTotalV.Visible   := lblPesoTotal.Visible;

  lblVolumeTotal.Visible  := (dbgPedidos.SelectedRows.Count > 1) and fVerificaAcessoSistema('EXVLPD');
  lblVolumeTotalV.Visible := lblVolumeTotal.Visible;

  if (not lblPesoTotal.Visible) and (not lblVolumeTotal.Visible) then
    Exit;

  If fOndaSeparacao Then
  Begin
    intQtdOnda := IIF(intQtdPedOnda > 0, intQtdPedOnda, fCfgSis('ONDMAX', varInteger));

    If dbgPedidos.SelectedRows.Count > intQtdOnda Then
    Begin
      fMensagem('Informação', 'Não pode ser ultrapassado o limite máximo de pedidos para geração da onda de separação, máximo permitido: ' + intQtdOnda.ToString, ['&Ok']);
      dbgPedidos.SelectedRows.CurrentRowSelected := False;
      Exit;
    End;
  End;

  fltPesoTotal := 0;
  fltVolumeTotal := 0;
  cdsClone := TZClient.Create(nil);
  try
    pCloneDataSet(cdsClone, cdsPedidos, False, True);
    for intContSel := 1 to dbgPedidos.SelectedRows.Count do
    begin
      cdsClone.GotoBookmark(Pointer(dbgPedidos.SelectedRows.Items[intContSel - 1]));

      fltPesoTotal := fltPesoTotal + cdsClone.FieldByName('PESBRU').AsFloat;
      fltVolumeTotal := fltVolumeTotal + cdsClone.FieldByName('VOLUME').AsFloat;
    end;
    lblPesoTotalV.Caption := FormatFloat('#,##0.000', fltPesoTotal);
    lblVolumeTotalV.Caption := FormatFloat('#,##0.0000', fltVolumeTotal);
  finally
    FreeAndNil(cdsClone);
  end;
end;

procedure TfrmFatExpedicao.pTotalizaValoresPedidosSelecionados;
Var
  intIndex: Integer;
  intRecNo: Integer;
  fltValorTotal: Double;
  fltValorContabilTotal: Double;
  fltPesoTotal: Double;
  fltVolumeTotal: Double;
  fltCubagemTotal: Double;
begin
  If (Not Assigned(cdsPedidos)) And (Not cdsPedidos.Active) Then
    Exit;

  pCarregarInformacoesPnlDocumentoSelecionados;

  If (dbgPedidos.SelectedRows.Count <= 1) Then
    Exit;

  fltValorTotal         := 0;
  fltValorContabilTotal := 0;
  fltPesoTotal          := 0;
  fltVolumeTotal        := 0;
  fltCubagemTotal       := 0;

  intRecNo := cdsPedidos.RecNo;
  cdsPedidos.DisableControls;

  Try
    For intIndex := 1 To dbgPedidos.SelectedRows.Count Do
    Begin
      cdsPedidos.GotoBookmark(Pointer(dbgPedidos.SelectedRows.Items[intIndex - 1]));
      fltValorTotal         := fltValorTotal         + fField('VALDOC').AsFloat;
      fltValorContabilTotal := fltValorContabilTotal + fField('VLRCON').AsFloat;
      fltPesoTotal          := fltPesoTotal          + fField('PESBRU').AsFloat;
      fltVolumeTotal        := fltVolumeTotal        + fField('VOLUME').AsFloat;
      fltCubagemTotal       := fltCubagemTotal       + fField('CUBAGEM').AsFloat;
    End;
  Finally
    cdsPedidos.RecNo := intRecNo;
    cdsPedidos.EnableControls;
  End;

  pnlDocumentosSelecionados.Visible         := True;
  lblDocsSelecionados.Caption               := FormatFloat('00000', dbgPedidos.SelectedRows.Count);
  lblValorTotalSelecionado.Caption          := FormatFloat('#,##0.00', fltValorTotal);
  lblValorContabilTotalSelecionados.Caption := FormatFloat('#,##0.00', fltValorContabilTotal);
  lblPesoTotalSelecionados.Caption          := FormatFloat('#,##0.00', fltPesoTotal);
  lblVolumeTotalSelecionados.Caption        := FormatFloat('#,##0.00', fltVolumeTotal);

  If (fCfgSis('MOEXSI', VarInteger) <> 0) Then
  Begin
    lblCubTotal.Visible           := True;
    lblVlrCubSelecionados.Visible := True;
    lblVlrCubSelecionados.Caption := FormatFloat(fMskDigitos(intDecCub), fltCubagemTotal);
  End;
end;

function TfrmFatExpedicao.fTravaConferenciaPedidosSelecionados(blnBloqueia:Boolean):Boolean;
Var
  intIndex: Integer;
  objPedido: TPedidoVenda;
  strChaLck: String;
begin
  Result := True;

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    Result := False;

    If (Not blnBloqueia) Then
      If (Not fVerificaTravaRomaneioPedidosSelecionados) Then
        Exit;

    For intIndex := 0 To Pred(stlPedidos.Count) Do
    Begin
      objPedido := TPedidoVenda(stlPedidos.Objects[intIndex]);

      strChaLck := 'FATGOR' + objPedido.strNumDoc + objPedido.strEspDoc + objPedido.strCodEmp + STR_TRAVA_CONFERENCIA;
      objLock.fLock_Unlock(strChaLck, blnBloqueia, False);
    End;

    Result := True;
  End;
end;

procedure TfrmFatExpedicao.pTravaDadosGerais(stlMsg: TStringList);
  Var
    strCliConGrid,
    strCliConSele: String;
    LstrDoc, LstrEsp, LstrEmp: string ;
begin
  If fCfgSis('USOREV', varBoolean) Then
  Begin
    strCliConGrid := fRetPrimeiroCliConEntreOsDocsInseridos;
    strCliConSele := fRetCliConPeloAutInc('FATGOR', fField('AUTINC').AsString);

    If (Not fEmptyStr(strCliConGrid)) And (Not fEmptyStr(strCliConSele)) And (strCliConGrid <> strCliConSele) Then
    Begin
      If (strCliConGrid = 'S') Then
        stlMsg.Add('Não é possível expedir em uma mesma operação um documento gravado como Revenda.' + #13#10 +
                     'Já foram selecionados documentos gravados como Uso/Consumo!')
      Else
        stlMsg.Add('Não é possível expedir em uma mesma operação um documento gravado como Uso/Consumo.' + #13#10 +
                   'Já foram selecionados documentos gravados como Revenda!');
    End;
  End;

  If (Not fEmptyStr(strOriSel)) Then
  Begin
    If (Trim(strOriSel) <> Trim(fField('ORIGOR').AsString)) Then
    Begin
      stlMsg.Add('Documentos com origens diferentes: (' + strOriSel + ') e (' + fField('ORIGOR').AsString + ')');
    End;
  End;

  If (fCfgSis('USALAL', varString) = 'S') And (stlPedidos.Count > 0) Then
  Begin
    If ((fEmptyStr(strCotLal)) And (Not fEmptyStr(fField('COTLAL').AsString))) Or ((Not fEmptyStr(strCotLal)) And (fEmptyStr(fField('COTLAL').AsString))) Then
    Begin
      stlMsg.Add('Não é permitido selecionar um pedido de entrega LALAMOVE com um pedido de entrega diferente!');
    End;
  End;

  If (Not fEmptyStr(strFatSel)) And blnExibirPedidosFaturamentoAutomatico Then
  Begin
    If (Trim(strFatSel) <> Trim(fField('FATAUT').AsString)) Then
    Begin
      If (strFatSel = 'S') Then
        stlMsg.Add('Não é possível expedir documentos de faturamento automático com documentos não faturados.' + #13#10 +
                   'Já foram selecionados documentos de faturamento automático!')
      Else
        stlMsg.Add('Não é possível expedir documentos de faturamento automático com documentos não faturados.' + #13#10 +
                   'Já foram selecionados documentos não faturados!');
    End;
  End;

  If (Not fEmptyStr(strCliSel)) Then
  Begin
    If (strCliSel <> fField('CODCLI').AsString) And (not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
    Begin
      stlMsg.Add('Clientes diferentes: (' + strCliSel + ') e (' + fField('CODCLI').AsString + ')');
    End
    Else If (strFazSel <> fField('CODFAZ').AsString) And (not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao)  Then
    Begin
      stlMsg.Add('Fazendas diferentes: (' + strFazSel + ') e (' + fField('CODFAZ').AsString + ')');
    End
    Else If (fField('CODEMB') <> Nil) Then
    Begin
      If (strEmbSel <> fField('CODEMB').AsString) And (not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao)  Then
        stlMsg.Add('Embarcações diferentes: (' + fRedCodEmb(strEmbSel) + ') e (' + fRedCodEmb(fField('CODEMB').AsString) + ')');
    End
    Else If (Not fValidouConsultaSituacaoCadastral(strCliSel)) Then
      stlMsg.Add(Format(MSG_PAINEL_FECHADO_CONSULTA_CADASTRAL, [VS_strCodEmp]));
  End;

  If (Not fEmptyStr(strEmpSel)) Then
  Begin
    if fCfgSis('EXOULJ', varBoolean) and (strEmpSel <> fField('CODEMP').AsString) Then
      stlMsg.Add('Empresas diferentes: (' + strEmpSel + ') e (' + fField('CODEMP').AsString + ')');
  End;

  If Not blnPedTra Then
  Begin
    If (Not fEmptyStr(strFpgSel)) And
       (strFpgSel <> fField('CODFPG').AsString) Then
    Begin
      If (fExpedicaoPorPedido) And (fCfgSis('CNEXCP') = 'S' {Pedir senha}) Then
      Begin
        If Not fPergunta('Este pedido tem formas de pagamento diferente da forma de pagamento dos pedidos selecionados.' + sLineBreak +
                         'No final, ao faturar, será solicitado senha de liberação, para realização deste procedimento. Confirma?') Then
          stlMsg.Add('Formas de pagamento diferentes: (' + strFpgSel + ') e (' + fField('CODFPG').AsString + ')');
      End
      Else If (fExpedicaoPorPedido) And (fCfgSis('CNEXCP') = 'N' {Não permitir}) Then
        stlMsg.Add('Formas de pagamento diferentes: (' + strFpgSel + ') e (' + fField('CODFPG').AsString + ')');
    End;
  End;

  If (strFpgSel = '016') Or
     ((Not fEmptyStr(strFpgSel)) And (fField('CODFPG').AsString = '016')) Then
  Begin
    stlMsg.Add('Pedidos com Financiamento dever ser expedidos isoladamente!');
  End;

  If (Not blnPedTra) And (Not fPermiteSelecionarPedidoComCondicaoPagamentoDiferenteNaExpedicao) Then
  Begin
    If (Not fEmptyStr(strCndSel)) And
       (strCndSel <> fField('CONPAG').AsString) Then
    Begin
      If fRetConPagCalculado(strCliSel, strCndSel, strCodSel) <>
         fRetConPagCalculado(fField('CODCLI').AsString, fField('CONPAG').AsString, fField('CODCND').AsString) Then
      Begin
        If (fExpedicaoPorPedido) And (fCfgSis('CNEXCP') = 'S' {Pedir senha}) Then
        Begin
          If Not fPergunta('Este pedido tem condição de pagamento diferente da condição dos pedidos selecionados.' + sLineBreak +
                           'No final, ao faturar, será solicitado senha de liberação, para realização deste procedimento. Confirma?') Then
            stlMsg.Add('Condições de pagamento diferentes: (' + strCndSel + ') e (' + fField('CONPAG').AsString + ')');
        End
        Else If (fExpedicaoPorPedido) And (fCfgSis('CNEXCP') = 'N' {Não permitir}) Then
          stlMsg.Add('Condições de pagamento diferentes: (' + strCndSel + ') e (' + fField('CONPAG').AsString + ')');
      End;
    End;
  End;

  {***************************************************************************************}
  {* UTILIZA A DATA DA EMISSÃO DO PEDIDO COMO BASE PARA CALCULO DA CONDIÇÃO DE PAGAMENTO *}
  {************************************************************************************PZ*}
  LstrDoc := fField('NUMDOC').AsString ;
  LstrEsp := fField('ESPDOC').AsString ;
  LstrEmp := fField('CODEMP').AsString ;
  If (fUtilizarComoDataBaseCtrDataEmissaoPedido(True, TFatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(LstrDoc, LstrEsp, LstrEmp))) Then
  Begin
    If (fUtilizarComoDataBaseCtrDataPrevisaoPedido(True)) Then
    Begin
      If (dtaPrevSel <> 0) And
         (dtaPrevSel <> fField('PREVIS').AsDateTime) Then
      Begin
        stlMsg.Add('Não é permitido selecionar dois pedidos com datas de previsões diferentes, pois o sistema está configurado para utilizar esta ' +
                   'data para calcular os vencimentos das duplicatas (CFG_CNDPRV): (' + formatDateTime('DD/MM/YYYY', dtaPrevSel) + ') e (' + formatDateTime('DD/MM/YYYY', fField('PREVIS').AsDateTime) + ')');
      End;
    End
    Else
    Begin
      If (dtaEmiSel <> 0) And
         (dtaEmiSel <> fField('DTAENT').AsDateTime) Then
      Begin
        stlMsg.Add('Não é permitido selecionar dois pedidos com datas de emissões diferentes, pois o sistema está configurado para utilizar esta ' +
                   'data para calcular os vencimentos das duplicatas (CFG_DTPDCR): (' + formatDateTime('DD/MM/YYYY', dtaEmiSel) + ') e (' + formatDateTime('DD/MM/YYYY', fField('DTAENT').AsDateTime) + ')');
      End;
    End;
  End;

  If Not fCfgSis('VNDSPD', varBoolean) Then
  Begin

    If (Not blnGarSel) And (Not blnPedTra) Then
    Begin
      If (Not fEmptyStr(strVenSel)) And
         (strVenSel <> fField('CODVEN').AsString) Then
      Begin
        stlMsg.Add('Vendedores diferentes: (' + strVenSel + ') e (' + fField('CODVEN').AsString + ')');
      End;

      If (Not fEmptyStr(strVe2Sel)) And
         (strVe2Sel <> fField('CODVE2').AsString) Then
      Begin
        stlMsg.Add('Vendedores (2) diferentes: (' + strVe2Sel + ') e (' + fField('CODVE2').AsString + ')');
      End;
    End;

  End;

  If (Not fEmptyStr(strOprFlj)) And
     (strOprFlj <> fField('OPRFLJ').AsString) Then
  Begin
    stlMsg.Add('Gerar produção fora da loja: (' + strOprFlj + ') e (' + fField('OPRFLJ').AsString + ')');
  End;

  If Not blnPedTra Then
  Begin
    If (Not fEmptyStr(strTraSel)) And
       (strTraSel <> fField('CODTRA').AsString) Then
    Begin
      If (fExpedicaoPorPedido) And (fCfgSis('TREXCP') = 'S' {Pedir senha}) Then
      Begin
        If Not fPergunta('Este pedido tem transportadora diferente da transportadora dos pedidos selecionados.' + sLineBreak +
                         'No final, ao faturar, será solicitado senha de liberação, para realização deste procedimento. Confirma?') Then
          stlMsg.Add('Transportadoras diferentes : (' + strTraSel + ') e (' + fField('CODTRA').AsString + ')');
      End
      Else If (fExpedicaoPorPedido) And (fCfgSis('TREXCP') = 'N' {Não permitir}) Then
        stlMsg.Add('Transportadoras diferentes : (' + strTraSel + ') e (' + fField('CODTRA').AsString + ')');
    End;
  End;

  If (Not fEmptyStr(strIndSel)) And fCfgSis('INDCOM', varBoolean) And
     (strIndSel <> fField('INDCOM').AsString) Then
  Begin
    stlMsg.Add('Tipos diferentes : (' + strIndSel + ') e (' + fField('INDCOM').AsString + ')');
  End;

  If fCfgSis('PORPED', VarBoolean) And (Not fEmptyStr(strPorSel)) And
     (strPorSel <> fField('CODPOR').AsString) Then
  Begin
    stlMsg.Add('Portadores diferentes : (' + strPorSel + ') e (' + fField('CODPOR').AsString + ')');
  End;

  If (Not fEmptyStr(strCCrSel)) And (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
  Begin
    If (strCcrSel = 'S') Then
      stlMsg.Add('Já foi selecionado um pedido com item concreto, portanto não é possível selecionar nenhum outro pedido.')

    Else If (strCcrSel = 'N') And fDocumentoPossuiItemConcreto(fField('NUMDOC').AsString,
                                                               fField('ESPDOC').AsString,
                                                               fField('CODEMP').AsString) Then
    Begin
      stlMsg.Add('Já foram selecionados outros pedidos, portanto não é permitido selecionar um pedido que possui item de concreto.');
    End;
  End;

  If (fCfgSis('SOLFNE', VarBoolean)) Then
  Begin
    If (Not fEmptyStr(strTppSel)) And
       (strTppSel <> fField('TIPPED').AsString) Then
    Begin
      stlMsg.Add('Tipos de Pedidos diferentes: (' + strTppSel + ') e (' + fField('TIPPED').AsString + ')');
    End;
  End;

  If (Not fEmptyStr(strTipSel))                               And
     (strTipSel <> fField('TIPOPE').AsString) Then
  Begin
    stlMsg.Add('Tipo de operações diferentes: ("' + strTipSel + '") e ("' + fField('TIPOPE').AsString + '")');
  End;

  If (Not fEmptyStr(strBeFSel)) And
     (strBeFSel <> fField('BENFUT').AsString) Then
  Begin
    stlMsg.Add('Não é permitido selecionar pedido de baixa de entrega futura com pedidos sem baixa de entrega futura: ("' + strBeFSel + '") e ("' + fField('BENFUT').AsString + '")');
  End;

  If (Not fEmptyStr(strTemAdt)) And (Not fPermitirMarcarPedidosDeClientesDiferentesNaExpedicao) Then
  Begin
    If (strTemAdt = 'S') And (fFormataFloat(fField('VALADT').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar mais de um pedido com adiantamento.')

    Else If (strTemAdt = 'S') And (fFormataFloat(fField('VALADT').AsFloat, 2) = 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos sem adiantamento com pedidos com adiantamento!')

    Else If (strTemAdt <> 'S') And (fFormataFloat(fField('VALADT').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos com adiantamento com pedidos sem adiantamento!');
  End;

  If (Not fEmptyStr(strBolAdt)) Then
  Begin
    If (strBolAdt = 'S') And (fFormataFloat(fField('BOLADT').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar mais de um pedido com boleto de adiantamento.')

    Else If (strBolAdt = 'S') And (fFormataFloat(fField('BOLADT').AsFloat, 2) = 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos sem boleto de adiantamento com pedidos com boleto de adiantamento!')

    Else If (strBolAdt <> 'S') And (fFormataFloat(fField('BOLADT').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos com boleto de adiantamento com pedidos sem boleto de adiantamento!');
  End;

  If (Not fEmptyStr(strTemRec)) Then
  Begin
    If (strTemRec = 'S') And (fFormataFloat(fField('VALREC').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar mais de um pedido com duplicatas recebidas.')

    Else If (strTemRec = 'S') And (fFormataFloat(fField('VALREC').AsFloat, 2) = 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos sem recebimentos com pedidos com duplicatas recebidas!')

    Else If (strTemRec <> 'S') And (fFormataFloat(fField('VALREC').AsFloat, 2) > 0.00) Then
      stlMsg.Add('Não é permitido selecionar pedidos com duplicatas recebidas com pedidos sem recebimentos!');
  End;

  If (Not fEmptyStr(strCfgENFUOPSel)) Then
  Begin
    If strCfgENFUOPSel <> fField('ENFUOP').AsString Then
      stlMsg.Add('Não é permitido selecionar pedidos realizados com a configuração "CFG_ENFUOP" diferente.');
  End;

  If (Not fEmptyStr(strSolAbaSel)) Then
  Begin
    If strSolAbaSel <> fField('SOLABA').AsString Then
    Begin
      stlMsg.Add('Não é permitido selecionar pedidos com origem de solicitação de abastecimento por depósito diferentes.');
      stlMsg.Add('Já Selecionado(s):' + IIF(fEmptyStr(strSolAbaSel), ': PEDIDO COMUM', 'PEDIDO DE ABASTECIMENTO POR DEPÓSITO EMP.ORI.: ' + strSolAbaSel));
      stlMsg.Add('Seleção atual....:' + IIF(fEmptyStr(fField('SOLABA').AsString), ': PEDIDO COMUM', 'PEDIDO DE ABASTECIMENTO POR DEPÓSITO EMP.ORI.: ' + fField('SOLABA').AsString));
    End;
  End;

  If FblnTemPedidoDeConsignacao Then
  Begin
    If fField('ENVCON').AsString = 'N' Then
      stlMsg.Add('Não é permitido selecionar pedido que não foi originado pela rotina de envio de consignação com pedidos oriundos desta rotina.');
  End
  Else
  Begin
    If (stlPedidos.Count > 0) and (fField('ENVCON').AsString = 'S') Then
      stlMsg.Add('Não é permitido selecionar pedido de envio de consignação com pedidos que não foram oriundos desta rotina.');
  End;

  If stlPedidos.Count > 0 Then
  Begin
    If (fField('BENFUT').AsString = 'S') And (blnFreRatSel <> (fField('FRERAT').AsFloat > 0)) Then
      stlMsg.Add('Não é permitido selecionar pedidos de frete rateado juntamente com pedidos de frete destacado!');

    If (blnDecZfmSel) And (fField('DECZFM').AsFloat > 0) Then
      stlMsg.Add('Não é permitido selecionar mais de um pedido com Desconto Comercial para Zona Franca!')
    Else If (blnDecZfmSel) <> (fField('DECZFM').AsFloat > 0) Then
      stlMsg.Add('Não é permitido selecionar um pedido com Desconto Comercial para Zona Franca com outro sem!');
  End;

  If (Not fEmptyStr(strRegEspSel)) And (fCfgSis('UTI_RE', varString) = 'S') And (strRegEspSel <> fField('REGESP').AsString ) Then
    stlMsg.Add('Não é permitido selecionar pedidos de Regime Especial com pedidos fora do Regime Especial!');

  If (Not fEmptyStr(strUtiResSel)) And (fCfgSis('UTI_RE', varString) = 'S') And (strUtiResSel <> fField('UTIRES').AsString ) Then
    stlMsg.Add('Não é permitido selecionar pedidos oriundos de desmembramento de Regime Especial com pedidos comuns!');

  If (Not fEmptyStr(strTaxJurSel)) And (strTaxJurSel <> fRetTaxaJurosSelAtu) Then
  Begin
    stlMsg.Add('Não é permitido selecionar pedidos com TAXA DE JUROS diferentes:');
    stlMsg.Add(fPadR('Taxa de Juros de pedidos já selecionados', 40) + ': ' + strTaxJurSel + '%');
    stlMsg.Add(fPadR('Taxa de Juros de ' + LstrDoc+'-'+LstrEsp+'-'+LstrEmp, 40) + ': ' + fRetTaxaJurosSelAtu + '%');
  End;

end;

procedure TfrmFatExpedicao.pVerificaExpPen(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String);
  var
    TipoAvisoNaExpedicao : TTipoAvisoNaExpedicaoDePedidosPendentesParaOMesmoCliente;

  function fClienteJaEmBusca : Boolean;
  var
    i : Integer;
  begin
    Result := False;
    For i := 0 To Length(arrCliente) -1 Do
    Begin
      If arrCliente[i].strCodigo.Equals(strCodCli) Then
        Exit(True);
    End;
  end;

begin

  If (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
    Exit;

  TipoAvisoNaExpedicao.SetValue(fCfgSis('EXPPEN', varString));

  If (TipoAvisoNaExpedicao = taeNaoExibirAviso) Then
    Exit;

  If (fClienteJaEmBusca) Then
    Exit;

  If (TipoAvisoNaExpedicao = taeSimConsiderandoSomentePedidosQueEstejamNaExpedicao) Then
    pCarregarEmAvisoPedidosDoMesmoClienteNaExpedicao(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp)

  Else If (TipoAvisoNaExpedicao = taeSimConsiderandoTodosOsPedidosAbertosParaOCliente) Then
    pCarregarEmAvisoTodosOsPedidosAbertosParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp);

end;

function TfrmFatExpedicao.fField(strFieldName: String): TField;
begin
  Result := cdsPedidos.FindField(strFieldName);
end;

{Casa das correias}
function TfrmFatExpedicao.fFiltrarLocalSeparacaoItensWMS: Boolean;
begin
  Result := fUsaRotinaWMS() And (tfFiltroLocSepArmz <> tfArmazem) And
    (Not fEmptyStr(fGetCodigoLocSep())) And (fCfgSis('LSEWMS', varString) = 'N') And
    (fCfgSis('EXBXTO', varString) = 'S');
end;

function TfrmFatExpedicao.fSituacaoFinanceiraPedidoOk(var strPenFin: String): Boolean;
  Var
   blnJaUsouCreditoDeAdiantamento: Boolean;
   fltValRec: Double;
   strConPag: String;
begin
  {************************************************************************}
  {* TELA DE FORMULAÇÃO DE TINTA DE MÁQUINA POSSUI A MESMA REGRA ABAIXO,  *}
  {* SE ALTERAR, VERIFICAR A NECESSIDADE DE ALTERAR LÁ TAMBÉM!            *}
  {*********************************************************************RN*}
  If blnExibirPedidosFaturamentoAutomatico And (cdsPedidos.FieldByName('FATAUT').AsString = 'S') Then
    Exit(True);

  blnJaUsouCreditoDeAdiantamento:= False;

  fltValRec := fFormataFloat(fField('VALADT').AsFloat + fField('VALREC').AsFloat, 2);
  strConPag := fField('CONPAG').AsString;

  If ((strConPag = '01000') And (fltValRec > 0) And (fltValRec < fField('VLRCON').AsFloat))
     Or
     ((fltValRec <= 0) And (strConPag <> '01000') And (fConPagComEntrada(strConPag))) Then
  Begin
    blnJaUsouCreditoDeAdiantamento := fJaUsouCreditoDeAdiantamento(fField('NUMDOC').AsString,
                                                                   fField('ESPDOC').AsString,
                                                                   fField('CODEMP').AsString);
  End;

  if fField('TEMMOVGPV').AsInteger = 1 then
    Result := True
  Else
    Result := fValidaSituacaoFinanceiraPedido(fField('CODCLI').AsString,
                                              fField('ESPDOC').AsString,
                                              fField('CODFPG').AsString,
                                              strConPag,
                                              fField('FPGNEG').AsString,
                                              fField('AUTINC').AsString,
                                              fField('TIPOPE').AsString,
                                              fField('ORIF11').AsString = 'S',
                                              fField('VLRCON').AsFloat - fField('TOTBRI').AsFloat,
                                              fltValRec,
                                              fField('BOLADT').AsFloat,
                                              fField('BOLVEN').AsString = 'S',
                                              fField('BENFUT').AsString = 'S',
                                              strPenFin,
                                              blnJaUsouCreditoDeAdiantamento,
                                              fField('ENVCON').AsString = 'S');
end;

procedure TfrmFatExpedicao.rdgTipoConferenciaClick(Sender: TObject);
begin
  inherited;
  pCarregaGrid;
end;

procedure TfrmFatExpedicao.rdgTipoDocumentoClick(Sender: TObject);
begin
  inherited;
  pCarregaGrid;
end;

procedure TfrmFatExpedicao.rdgTipoMovClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If (blnExecutandoFormShow Or blnAtualizandoGrid) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if (Sender = rdgTipoMov) then
    grbLocRet.Visible := (rdgTipoMov.ItemIndex <> 1);

  Try
    Screen.Cursor := crHourGlass;

    btnRecarrPed.Click;

    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
  Finally
    Screen.Cursor := crDefault;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.rdgFiltroDataColetaClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  Try
    If (blnExecutandoFormShow Or blnAtualizandoGrid) Then
      Exit;

    Screen.Cursor := crHourGlass;
    Try
      pFiltrarPedidos;
      pCalculaResumoTotalDocumentos();
    Finally
      Screen.Cursor := crDefault;
    End;
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
  End;
end;

function TfrmFatExpedicao.RemesseDePedidoPertenceARemessaDeSeparacao(ARemessaDePedido: String): Boolean;
  const
    SQL = 'SELECT COUNT(*) AS TOT FROM EXTGOR WHERE (FGO_SEQSEP = :SEQSEP) AND (FGO_SEQOND <> "")';
  var
    LQry : TUniQuery;
begin

  Result := False;

  If ARemessaDePedido.IsEmpty Then
    Exit;

  LQry := fCriaQuery;

  Try

    LQry.Close;
    LQry.SQL.Add(SQL);
    LQry.ParamByName('SEQSEP').AsString := ARemessaDePedido;
    LQry.Open;

    Result := (Not LQry.IsEmpty) And (LQry.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LQry);
  End;

end;

procedure TfrmFatExpedicao.mnuRemanejarSeparadorClick(Sender: TObject);
var
  form: TTfrmManutencaoSeparadoresPorLocalView;
begin
  pCriarFormularios(TTfrmManutencaoSeparadoresPorLocalView, form);
  Try
    form.strAutoincremFATGOR := fField('AUTINC').AsString;
    form.ShowModal;
  Finally
    pFreeAndNil(form);
  End;
end;

procedure TfrmFatExpedicao.tmrBuscarTimer(Sender: TObject);
begin
  inherited;
  Try
    tmrBuscar.Enabled := False;
  Finally
    btnBuscarClick(Self);
  End;
end;

procedure TfrmFatExpedicao.tmrTmpIanTimer(Sender: TObject);
begin
  inherited;
  pDisparaThreadNotificacao();
end;

procedure TfrmFatExpedicao.tmrTmpRteTimer(Sender: TObject);
  Var
    intQtdRegAnt: Integer;
begin
  inherited;
  If (Not btnRecarrPed.Enabled) Then
    Exit;

  If (Not btnRecarrPed.Visible) Then
    Exit;

  If (Not fPermiteExecutarRotinaAtualizacaoTela) Then
    Exit;

  intQtdRegAnt := cdsPedidos.RecordCount;
  tmrTmpIan.Enabled := False;
  tmrTmpRte.Enabled := False;
  Screen.Cursor     := crHourGlass;
  Try
    btnRecarrPed.Click;
  Finally
    If (blnSOMNSP) Then
    Begin
      If ((tmrTmpIan.Interval > 0) And (tmrTmpRte.Interval > 0) And (tmrTmpIan.Interval >= tmrTmpRte.Interval)) Or
         (cdsPedidos.RecordCount > intQtdRegAnt) Then
        pDisparaThreadNotificacao;

      tmrTmpIan.Enabled := True;
    End;
    tmrTmpRte.Enabled := True;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmFatExpedicao.cdsFeriadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TDateField(cdsFeriados.FieldByName('FCI_DTAFER')).DisplayFormat := 'dd/mm/yyyy';
end;

procedure TfrmFatExpedicao.cdsPedidosAfterScroll(DataSet: TDataSet);
  Var
    strTpaDes : String;
begin
  inherited;
  HintControler.HideHint;

  strBarDocLocalizar := '';

  If (blnExecutandoFormShow) Then
    Exit;

  If (Not blnScrollPedidos) Then
    Exit;

  If (DataSet.ControlsDisabled) Then
    Exit;

  pExibirBotoesLabels;

  If (fField('CODFPG') <> Nil) Then
  Begin
    lblCODFPG.DataField := 'CODFPG';
    lblDESFPG.Caption   := fRetDesFpg(fField('CODFPG').AsString);
  End;
  If (fField('CODTPA') <> Nil) Then
  Begin
    strTpaDes := fRetNomTipoAtend(fField('CODTPA').AsString);
    If (Not fEmptyStr(strTpaDes)) Then
    Begin
      lblTipoAtendimentoC.Caption := 'TIPO DE ATENDIMENTO: ';
      lblTipoAtendimentoD.Caption := fField('CODTPA').AsString + ' - ' + strTpaDes;
    End
    Else
    Begin
      lblTipoAtendimentoC.Caption := '';
      lblTipoAtendimentoD.Caption := '';
    End;
  End;
  If (fField('CODVEN') <> Nil) Then
  Begin
    lblVendedor.Caption := fField('CODVEN').AsString + ' - ' + fRetNomVendRep(fField('CODVEN').AsString);
  End;

  If (fField('OPEEXP') <> Nil) Then
    lblConferente.Caption := fField('OPEEXP').AsString + ' - ' + fRetNomVendRep(fField('OPEEXP').AsString);

  If lblLocArm.Visible Then
    lblLocArm.Caption := fField('LCLAMZ').AsString;

  If Not cdsPedidos.ControlsDisabled Then
  Begin
    tbsDuplicatas.TabVisible        := (fField('VALREC').AsFloat > 0);
    tbsAdiantamentos.TabVisible     := (fField('VALADT').AsFloat > 0);
    tbsPedidosVinculados.TabVisible := (Not fEmptyStr(fField('SEQDMP').AsString));

    pCarregaItensPageControls;
  End;

  btnOpeDes.Visible := fCfgSis('OPEDES', varBoolean) And
                       ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And
                       (cdsPedidos.FieldByName('ESPDOC').AsString = 'PD');

  If blnUsaPTF Then
    btnFaturarExpedidos.Visible := (Pos(cdsPedidos.FieldByName('CODCLI').AsString , VS_strCliFil) > 0) And
                                   (fEmpresaUsaTransferenciaOuVenda(VS_strCodEmp,fRetCodEmpClienteFilial(cdsPedidos.FieldByName('CODCLI').AsString )));

  If (Not cdsPedidos.IsEmpty) And (fVisualizarGuiche()) And (Not fEmptyStr(cdsPedidos.FieldByName('GUICHE').AsString)) And
     (StrToIntDef(cdsPedidos.FieldByName('GUICHE').AsString, 0) > 0) Then
  Begin
    lblGuiche.Visible    := True;
    lblNumGuiche.Visible := True;

    lblNumGuiche.Caption := cdsPedidos.FieldByName('GUICHE').AsString;
  End
  Else
  Begin
    lblGuiche.Visible    := False;
    lblNumGuiche.Visible := False;
  End;

  {Separação}
  If (((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO))) And ((StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) > 0) Or fPedidoJahImpresso(fField('AUTINC').AsString)) Then
    mnuLimparSeparacao.Visible := (Not fUsaOndaSeparacaoAgrupamento())
  Else
    mnuLimparSeparacao.Visible := False;

  If Not(mnuLimparSeparacao.Visible) And
     Not(mnuRemanejarSeparador.Visible) And
     Not(mnuLimparSeparacaoRomaneio.Visible) And
     Not(mnuGuardarItensSep.Visible) And
     Not(mnuVerSeparacoes.Visible) Then
    btnSeparacao.Enabled := False
  Else
    btnSeparacao.Enabled := (Not FApenasGeracaoDeRemessaDePedido);

  btnAlterarDataEntrega.Visible := blnPermitirAlterarDataEntregaPedido and (cdsPedidos.FieldByName('ESPDOC').AsString = 'PD');
  if btnAlterarDataEntrega.Visible then
    btnAlterarDataEntrega.Enabled := cdsPedidos.FieldByName('ENTRET').AsString.Contains('E') And (Not FApenasGeracaoDeRemessaDePedido);

  btnExibirProdutos.Visible := (Pos(cdsPedidos.FieldByName('ESPDOC').AsString, 'PD_OR_') > 0);

  if btnConsultaPed.Visible then
    btnConsultaPed.Enabled := ((cdsPedidos.RecordCount > 0) and (cdsPedidos.RecNo > 0));

  pAjustaAlturaPanelBotoes;
end;

procedure TfrmFatExpedicao.cmbCliLojClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If blnAtualizandoGrid Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pFiltrarPedidos;
  pCalculaResumoTotalDocumentos();
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.cmbSitFinClick(Sender: TObject);
begin
  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If blnAtualizandoGrid Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if (not (Assigned(cdsPedidos))) then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if (not cdsPedidos.Active) then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pFiltrarPedidos;
  pCalculaResumoTotalDocumentos();
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnImpSepClick(Sender: TObject);
  Var
    intCont: integer;
Begin

  If fUsaOndaSeparacaoAgrupamento Then
  Begin
    If Not fOndaSeparacao Then
    Begin
      fMensagem('', 'Para gerar a Remessa de Pedido(s) é necessário em ([F3] Buscar) marcar a opção (Seleção de pedidos para geração de onda)!', ['&OK']);
      Exit;
    End;
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not fValidarAbastecimentoEstoquePedido Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if fPedidoGuardado then
  begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  end;

  Try
    blnAtualizouGridNaImpressaoSeparacao := False;
    blnScrollPedidos := False;

    If fOndaSeparacao And (dbgPedidos.SelectedRows.Count = 0) Then
      dbgPedidos.SelectedRows.CurrentRowSelected := True;

    If Not fSelecionado(dtsPedidos.DataSet) Then
    Begin
      If dbgPedidos.SelectedRows.Count > 0 Then
      Begin
        For intCont := 0 to dbgPedidos.SelectedRows.Count - 1 Do
        Begin
          dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intCont]);

          If Not fValidaTravaDoc Then
            Exit;

          pAdicionaListaSelecao;
        End;
      End
      Else
      Begin
        If Not fValidaTravaDoc Then
          Exit;
      End;
    End;

    pArmazenaPedidoInicialDoProcesso;

    if fAjustaDadosParaImpressaoDeSeparacao Then
      fImprimirSeparacao(tisNormal);
  Finally
    blnScrollPedidos := True;
    pRetornaParaPedidoDoInicioDoProcesso;
    pLimparSelecaoELocks;
    pLimpaVariaveisSelecaoPedidos;
    pAtivaDesativaTimersNotificaoAndRecarga(True);

    If Not blnAtualizouGridNaImpressaoSeparacao Then
      pAtualizarGrid;
  End;
End;

procedure TfrmFatExpedicao.fImprimirSeparacao(tisTipoImp : TTipoImpressaoSeparacao);
  Var
    strAutIncPed ,
    LAutInc      ,
    LNumDoc      ,
    LEspDoc      ,
    LCodEmp      : String;
    prmDllEtq    : TParamDllEtiquetas;
    intQtdImp    : Integer;
    LPedidos     : TStringList;
    blnImprime   : Boolean;
    blnSelecionouOndaJaGerada : Boolean;
    LPedidosNaoImpressos : TStringList;
    stlPedidosCorpem: TStringList;

    objSepDor : TSepDor;
    strPenFin : String;
  procedure pImprimindoSeparacao;
    Var
      LfrmGravando: TfrmGravando;
      LMensagem: String;
  begin
    pEscolherViaConferencia;

    Try
      If fOndaSeparacao Then
        LMensagem := 'Aguarde... Sintetizando produtos'
      Else
        LMensagem := 'Aguarde... Imprimindo separação';

      LMensagem := LMensagem + ' (' +
        cdsPedidos.FieldByName('NUMDOC').AsString + '-' +
        cdsPedidos.FieldByName('ESPDOC').AsString + '-' +
        cdsPedidos.FieldByName('CODEMP').AsString + ') ';

      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.fExecutarModal(pImprimirSeparacao, LMensagem, '');

      if (blnImprimiuSeparacao) and (fCfgSis('USAEDI', varBoolean)) then
        stlPedidosCorpem.Add(cdsPedidos.FieldByName('AUTINC').AsString);
    Finally
      pFreeAndNil(LfrmGravando);
    End;
  end;

  procedure pDisparaEmail;
  Begin
    If (Self.blnImprimiuSeparacao) Or (Self.blnImprimiuSeparacaoWmsOnda) Then
    Begin
      If (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Then
      Begin
        fDisparaWhatsappAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString,
	                               'E3',
	                               cdsPedidos.FieldByName('ESPDOC').AsString,
	                               '',
	                               'SE',
	                               '',
	                               cdsPedidos.FieldByName('CODCLI').AsString,
	                               '',
	                               True,
	                               '',
	                               TGeraArquivoAnexoEmailAutomatico.New(cdsPedidos.FieldByName('NUMDOC').AsString,
	                                                                    cdsPedidos.FieldByName('ESPDOC').AsString,
	                                                                    cdsPedidos.FieldByName('CODEMP').AsString,
	                                                                    cdsPedidos.FieldByName('CODCLI').AsString),
                                 '',
                                 '',
                                 '',
                                 Self.UnitName);

        fDisparaEmailAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString,
                                'E3',
                                cdsPedidos.FieldByName('ESPDOC').AsString,
                                '',
                                'SE',
                                '',
                                cdsPedidos.FieldByName('CODCLI').AsString,
                                '',
                                '',
                                TGeraArquivoAnexoEmailAutomatico.New(cdsPedidos.FieldByName('NUMDOC').AsString,
                                                                     cdsPedidos.FieldByName('ESPDOC').AsString,
                                                                     cdsPedidos.FieldByName('CODEMP').AsString,
                                                                     cdsPedidos.FieldByName('CODCLI').AsString));

        fDisparaSMSAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString, 'E3', cdsPedidos.FieldByName('ESPDOC').AsString, '', 'SE', '', cdsPedidos.FieldByName('CODCLI').AsString);
      End
      Else If (fCfgSis('TIPEXP', varString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
      Begin
        fDisparaWhatsappAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString,
                                   'E4',
                                   cdsPedidos.FieldByName('ESPDOC').AsString,
                                   '',
                                   'SE',
                                   '',
                                   cdsPedidos.FieldByName('CODCLI').AsString,
                                   '',
                                   True,
                                   '',
                                   TGeraArquivoAnexoEmailAutomatico.New(cdsPedidos.FieldByName('NUMDOC').AsString,
                                                                        cdsPedidos.FieldByName('ESPDOC').AsString,
                                                                        cdsPedidos.FieldByName('CODEMP').AsString,
                                                                        cdsPedidos.FieldByName('CODCLI').AsString),
                                   '',
                                   '',
                                   '',
                                   Self.UnitName);

        fDisparaEmailAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString,
                                'E4',
                                cdsPedidos.FieldByName('ESPDOC').AsString,
                                '',
                                'SE',
                                '',
                                cdsPedidos.FieldByName('CODCLI').AsString,
                                '',
                                '',
                                TGeraArquivoAnexoEmailAutomatico.New(cdsPedidos.FieldByName('NUMDOC').AsString,
                                                                     cdsPedidos.FieldByName('ESPDOC').AsString,
                                                                     cdsPedidos.FieldByName('CODEMP').AsString,
                                                                     cdsPedidos.FieldByName('CODCLI').AsString));

        fDisparaSMSAutomatico(cdsPedidos.FieldByName('NUMDOC').AsString, 'E4', cdsPedidos.FieldByName('ESPDOC').AsString, '', 'SE', '', cdsPedidos.FieldByName('CODCLI').AsString);
      End;
    End;
  End;

begin

  If Not btnImpSep.Visible Then
    Exit;

  If cdsPedidos.IsEmpty Then
    Exit;

  If fTemPedidoSelecionadoLibSep Then
    Exit;

  if (not fPermiteReimprimirSeparacao) then
    Exit;

  Self.strSeparador := '';
  strSeqSep := '';
  LPedidos := TStringList.Create();
  LPedidosNaoImpressos := TStringList.Create();
  stlPedidosCorpem := TStringList.Create();

  Self.strTipImpSeparacao   := '';
  Self.blnSeparacaoDireto   := False;
  Self.blnImprimiuSeparacao := False;
  Self.blnImprimiuSeparacaoWmsOnda := False;
  blnAtualizouGridNaImpressaoSeparacao := False;

  objSepDor := TSepDor.Create;
  objSepDor.pIniciou;

  FPedidosCortados := TStringList.Create;
  FListaPDMarketPlace := TStringList.Create;

  FItensSemSaldoDispParaAtenderPDOnda := TStringList.Create;

  Try
    //Pede senha para identificar o separador, logo abaixo sera gravado no pedido caso tenha sido impressa a separacao
    If fUtilizaSolicitacaoSeparador Then
    Begin
      Self.strSeparador := fPedeSeparador(tisTipoImp);

      If fEmptyStr(Self.strSeparador) Then
        Exit;
    End;

    If (fOndaSeparacao And (Not fUsaOndaSeparacaoExpedicaoWMS)) Then
      strSeqSep := fGerarSeqSep;

    If (tisTipoImp = tisWMSTodos) Then
    Begin
      Try
        intQtdImp := 0;
        cdsPedidos.DisableControls;
        cdsPedidos.First;
        FTipoImpSep := tisTipoImp;
        While not cdsPedidos.Eof Do
        Begin
          If StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) = 0 Then
          Begin
            If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
               Not fValidaLocalRetiraAoSelecionarPedido(fField('NUMDOC').AsString,
                                                        fField('ESPDOC').AsString,
                                                        fField('CODEMP').AsString,
                                                        False) Then
            Begin
              LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                  fField('ESPDOC').AsString, '-',
                                  fField('CODEMP').AsString, ' -> Local de Retira Caixa'));

              cdsPedidos.Next;
              Continue;
            End;

            If fCfgSis('EXISTA', varBoolean) Then
            Begin
              If (fPedidoBaixado(fField('NUMDOC').AsString,
                                 fField('ESPDOC').AsString,
                                 fField('CODEMP').AsString)) Then
              Begin
                LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                    fField('ESPDOC').AsString, '-',
                                    fField('CODEMP').AsString, ' -> Baixado'));

                cdsPedidos.Next;
                Continue;
              End;

              If (fPedidoFaturado(fField('NUMDOC').AsString,
                                  fField('ESPDOC').AsString,
                                  fField('CODEMP').AsString)) And (fField('FATAUT').AsString <> 'S') Then
              Begin
                LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                    fField('ESPDOC').AsString, '-',
                                    fField('CODEMP').AsString, ' -> Faturado'));

                cdsPedidos.Next;
                Continue;
              End;
            End;

            pImprimindoSeparacao;
            pDisparaEmail;

            objSepDor.pSetNumDoc(fField('NUMDOC').AsString);
            objSepDor.pSetEspDoc(fField('ESPDOC').AsString);
            objSepDor.pSetEmpDoc(fField('CODEMP').AsString);

            If fUtilizaSolicitacaoSeparador() And (Not fEmptyStr(strSeparador)) Then
              objSepDor.pSetOpeCon(strSeparador);

            objSepDor.pGravar;

            TUpdateStatus.New(TParamStatus.New()
                                .NumDoc(fField('NUMDOC').AsString)
                                .EspDoc(fField('ESPDOC').AsString)
                                .CodEmp(fField('CODEMP').AsString)).pExecute();

            pReprocessarPedidoFaturamentoAutomatico(fField('NUMDOC').AsString,
                                                    fField('ESPDOC').AsString,
                                                    fField('CODEMP').AsString);
          End;

          If (intQtdImpSepWMS > 1) Then
          Begin
            inc(intQtdImp);
            If (intQtdImp = intQtdImpSepWMS) Then
              Break;
          End;

          cdsPedidos.Next;
        End;

        //Imprime etiqueta do sequencial de separação (Onda/Wave)
        prmDllEtq := TParamDllEtiquetas.Create;
        prmDllEtq.strAutInc := ShortString(strSeqSep);

        If fCfgSis('SEQSEP', varString) = 'L' Then
          prmDllEtq.tpeTipEtq := tpeSeqSeparacaoWMSLaser
        Else If fCfgSis('PLAREC', varString) = 'A' Then
          prmDllEtq.tpeTipEtq := tpeSeqSeparacaoWMSArgox;

        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

        FreeAndNil(prmDllEtq);

      Finally
        cdsPedidos.EnableControls;
        pAtualizarGrid;
        blnAtualizouGridNaImpressaoSeparacao := True;
      End;
      Exit;

    End
    Else
    If (tisTipoImp = tisReimpressaoSeqSeparacaoWMS) Then
    Begin
      Try
        blnSenhaReimpressao := False;
        strSeqSep   := cdsPedidos.FieldByName('SEQSEP').AsString;

        cdsPedidos.DisableControls;
        cdsPedidos.First;
        FTipoImpSep := tisTipoImp;
        While (not cdsPedidos.Eof) Do
        Begin
          If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
             Not fValidaLocalRetiraAoSelecionarPedido(fField('NUMDOC').AsString,
                                                      fField('ESPDOC').AsString,
                                                      fField('CODEMP').AsString,
                                                      False) Then
          Begin
            LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                fField('ESPDOC').AsString, '-',
                                fField('CODEMP').AsString, ' -> Local de Retira Caixa'));

            cdsPedidos.Next;
            Continue;
          End;

          If SameStr(cdsPedidos.FieldByName('SEQSEP').AsString, strSeqSep)  Then
          Begin

            pImprimindoSeparacao;
            pDisparaEmail;

            objSepDor.pSetNumDoc(fField('NUMDOC').AsString);
            objSepDor.pSetEspDoc(fField('ESPDOC').AsString);
            objSepDor.pSetEmpDoc(fField('CODEMP').AsString);

            If fUtilizaSolicitacaoSeparador() And (Not fEmptyStr(strSeparador)) Then
              objSepDor.pSetOpeCon(strSeparador);

            objSepDor.pGravar;

          End;
          cdsPedidos.Next;
        End;

        //Imprime etiqueta do sequencial de separação (Onda/Wave)
        prmDllEtq := TParamDllEtiquetas.Create;
        prmDllEtq.strAutInc := ShortString(strSeqSep);

        If fCfgSis('SEQSEP', varString) = 'L' Then
          prmDllEtq.tpeTipEtq := tpeSeqSeparacaoWMSLaser
        Else If fCfgSis('PLAREC', varString) = 'A' Then
          prmDllEtq.tpeTipEtq := tpeSeqSeparacaoWMSArgox;

        fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetas');

        FreeAndNil(prmDllEtq);

      Finally
        cdsPedidos.EnableControls;
        pAtualizarGrid;
        blnAtualizouGridNaImpressaoSeparacao := True;
      End;

    End;

    {*** Onda de separação ***}
    If Not fValida_SelecaoDePedidosOndaWMS(blnSelecionouOndaJaGerada) Then
      Exit;

    If (fOndaSeparacao) And (dbgPedidos.SelectedRows.Count >= 1) Then
    Begin
      if (not fPermiteGerarOndaComClientesFilialDiferentes) then
        Exit;

      blnImprime := True;

      {Onda + WMS (Ligado)}
      If (fUsaOndaSeparacaoExpedicaoWMS) Then
      Begin

        {Gera senquencial da onda, define lotes e imprime!}
        If (FiltroOnda = fosSelecaoPedidosGeracaoOnda) Then
        Begin

          {Se selecionou onda, não precisa gerar de novo!}
          If Not blnSelecionouOndaJaGerada Then
          Begin

            If (dbgPedidos.SelectedRows.Count <= 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não foram selecionados os pedidos para geração da onda de separação.', ['&Ok']);
              Exit;
            End;

            TFrmGravando.fExecutarModal(pGerarOndaSeparacao, 'Aguarde, Gerando sequencial de onda de separação!', '');

            If Not fEmptyStr(strSeqSep) Then
            Begin
              fMensagem('', IIF(fUsaOndaSeparacaoAgrupamento, 'Remessa de Pedido', 'Onda de Separação') + ' gerada com sucesso: ' + strSeqSep, ['&OK']);
              strNumeroOnda := strSeqSep;
            End Else
              Exit;
          End;

          If (fDigitaLotesPedidoWMSOndaDeSeparacao(Self.strSeparador)) Then
          Begin
            pSintetizaItensImpressaoOndaSeparacao(strNumeroOnda); {<<-- Imprimiu aqui!}
            Self.blnImprimiuSeparacaoWmsOnda := True;
          End
          Else
            pLimpaOndaSeparacao;

          For strAutIncPed In stlPedidos Do
          Begin
            If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
            Begin
              If Self.blnImprimiuSeparacaoWmsOnda Then
              Begin
                pLimpaEstornoSeparacao(fField('AUTINC').AsString);
                pDisparaEmail;
              End;

              TUpdateStatus.New(TParamStatus.New()
                                  .NumDoc(fField('NUMDOC').AsString)
                                  .EspDoc(fField('ESPDOC').AsString)
                                  .CodEmp(fField('CODEMP').AsString)).pExecute();
            End;
          End;

          blnImprime := False;

        End;

      End Else

      {Onda + WMS (Desligado)}
      Begin

        If (Not fPermiteReimpressaoDeSeparacao(stlPedidos)) Then
          Exit;

        if (not fCortePedidosMarketplaceSemSaldo) then
          Exit;

        For strAutIncPed In stlPedidos Do
        Begin
          If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
          Begin
            LAutInc := fField('AUTINC').AsString;
            LNumDoc := fField('NUMDOC').AsString;
            LEspDoc := fField('ESPDOC').AsString;
            LCodEmp := fField('CODEMP').AsString;

            pImprimindoSeparacao;
            Self.blnSeparacaoDireto := True;//Apos a primeira impressao nao deve mais perguntar

            If Not Self.blnImprimiuSeparacao Then
              Break
            Else
            Begin
              pLimpaEstornoSeparacao(LAutInc);
              pDisparaEmail;

              objSepDor.pSetNumDoc(LNumDoc);
              objSepDor.pSetEspDoc(LEspDoc);
              objSepDor.pSetEmpDoc(LCodEmp);

              If fUtilizaSolicitacaoSeparador() And (Not fEmptyStr(strSeparador)) Then
                objSepDor.pSetOpeCon(strSeparador);

              objSepDor.pGravar;

              TUpdateStatus.New(TParamStatus.New()
                                  .NumDoc(LNumDoc)
                                  .EspDoc(LEspDoc)
                                  .CodEmp(LCodEmp)).pExecute();
            End;

          End;

        End;

      End;

      If (blnImprime) Then
        pImprimeOndaSeparacaoItensSintetizados;

      pAtualizarGrid;
      blnAtualizouGridNaImpressaoSeparacao := True;
      dbgPedidos.SelectedRows.Clear;

    End

    Else

    {Não possui pedidos selecionados entao deve imprimir somente do pedido posicionado}

    If ( (stlPedidos.Count = 0) Or (Not MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO])) Or
         (fGetMenu('Imprimir Separação', [''+strDescDoc+'s selecionados', ''+strDescDoc+' posicionado'], 1) = 2) ) Then
    Begin
      If (fSelecionado(cdsPedidos) Or fPermiteSelecionarPedidoAtual(True)) And
         (fPermiteReimpressaoDeSeparacao(Nil)) Then
      Begin
        FTipoImpSep := tisTipoImp;

        If fValidarSitFinParaImpressaoSeparacao Then
        Begin
          If (Not fSituacaoFinanceiraPedidoOk(strPenFin)) Then
          Begin
            pMensagemOk(strPenFin + '!');
            Exit;
          End;
        End;

        If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
           Not fValidaLocalRetiraAoSelecionarPedido(fField('NUMDOC').AsString,
                                                    fField('ESPDOC').AsString,
                                                    fField('CODEMP').AsString) Then
        Begin
          LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                              fField('ESPDOC').AsString, '-',
                              fField('CODEMP').AsString, ' -> Local de Retira Caixa'));

          Exit;
        End;

        If fCfgSis('EXISTA', varBoolean) Then
        Begin
          If (fPedidoBaixado(fField('NUMDOC').AsString,
                             fField('ESPDOC').AsString,
                             fField('CODEMP').AsString)) Then
          Begin
            LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                fField('ESPDOC').AsString, '-',
                                fField('CODEMP').AsString, ' -> Baixado'));
            Exit;
          End;

          If (fPedidoFaturado(fField('NUMDOC').AsString,
                              fField('ESPDOC').AsString,
                              fField('CODEMP').AsString)) Then
          Begin
            LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                fField('ESPDOC').AsString, '-',
                                fField('CODEMP').AsString, ' -> Faturado'));
            Exit;
          End;
        End;

        If (Not fImprimeSeparacaoDePedido(fField('EXPTOT').AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'CFG_IMSEPO configurada apenas para imprimir separação de pedidos que não estão conferidos/expedidos',['&OK']);
          Exit;
        End;

        if (not fImprimirSeparacaoParcial) then
          Exit;

        if (not fCortePedidosMarketplaceSemSaldo(False)) then
        begin
          pAtualizarGrid;
          Exit;
        end;

        pImprimindoSeparacao;
        pDisparaEmail;

        objSepDor.pSetNumDoc(fField('NUMDOC').AsString);
        objSepDor.pSetEspDoc(fField('ESPDOC').AsString);
        objSepDor.pSetEmpDoc(fField('CODEMP').AsString);

        If fUtilizaSolicitacaoSeparador() And (Not fEmptyStr(strSeparador)) Then
          objSepDor.pSetOpeCon(strSeparador);

        objSepDor.pGravar;

        TUpdateStatus.New(TParamStatus.New()
                            .NumDoc(fField('NUMDOC').AsString)
                            .EspDoc(fField('ESPDOC').AsString)
                            .CodEmp(fField('CODEMP').AsString)).pExecute();

        pReprocessarPedidoFaturamentoAutomatico(fField('NUMDOC').AsString,
                                                fField('ESPDOC').AsString,
                                                fField('CODEMP').AsString);

        If fCfgSis('EXISTA', varBoolean) Or fCfgSis('ATUSEP', varBoolean) Then
        Begin
          pAtualizarGrid;
          blnAtualizouGridNaImpressaoSeparacao := True;
        End;

      End;
    End Else
    Begin
      If (Not fPermiteReimpressaoDeSeparacao(stlPedidos)) Then
        Exit;

      if (not fCortePedidosMarketplaceSemSaldo(False)) then
      begin
        pAtualizarGrid;
        Exit;
      end;

      For strAutIncPed In stlPedidos Do
      Begin

        If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
        Begin

          If fValidarSitFinParaImpressaoSeparacao Then
          Begin
            If (Not fSituacaoFinanceiraPedidoOk(strPenFin)) Then
            Begin
              pMensagemOk(strPenFin + '!');
              Continue;
            End;
          End;

          If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
             Not fValidaLocalRetiraAoSelecionarPedido(fField('NUMDOC').AsString,
                                                      fField('ESPDOC').AsString,
                                                      fField('CODEMP').AsString,
                                                      False) Then
          Begin
            LPedidos.Add(Concat(fField('NUMDOC').AsString, '-',
                                fField('ESPDOC').AsString, '-',
                                fField('CODEMP').AsString, ' -> Local de Retira Caixa'));
            Continue;
          End;

          If (Not fImprimeSeparacaoDePedido(fField('EXPTOT').AsString)) Then
          Begin
            LPedidosNaoImpressos.Add(Concat(fField('NUMDOC').AsString, '-',
                                            fField('ESPDOC').AsString, '-',
                                            fField('CODEMP').AsString));
            Continue;

          End;

          if (not fImprimirSeparacaoParcial) then
            Continue;

          pImprimindoSeparacao;
          Self.blnSeparacaoDireto := True;//Apos a primeira impressao nao deve mais perguntar

          If Not Self.blnImprimiuSeparacao Then
            Break
          Else
            pDisparaEmail;

          objSepDor.pSetNumDoc(fField('NUMDOC').AsString);
          objSepDor.pSetEspDoc(fField('ESPDOC').AsString);
          objSepDor.pSetEmpDoc(fField('CODEMP').AsString);

          If fUtilizaSolicitacaoSeparador() And (Not fEmptyStr(strSeparador)) Then
            objSepDor.pSetOpeCon(strSeparador);

          objSepDor.pGravar;

          TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(fField('NUMDOC').AsString)
                              .EspDoc(fField('ESPDOC').AsString)
                              .CodEmp(fField('CODEMP').AsString)).pExecute();

          pReprocessarPedidoFaturamentoAutomatico(fField('NUMDOC').AsString,
                                                  fField('ESPDOC').AsString,
                                                  fField('CODEMP').AsString);
        End;
      End;

      If fCfgSis('EXISTA', varBoolean) Or fCfgSis('ATUSEP', varBoolean) Or fOndaSeparacao Then
      Begin
        pAtualizarGrid;
        blnAtualizouGridNaImpressaoSeparacao := True;
      End;

    End;

    If fCfgSis('USAEDI', varBoolean) Then
    Begin
      fExecutarModal(procedure
        begin
          pGeraArquivoEdiCorpemSistemas(stlPedidosCorpem);
        end, 'Aguarde, Gerando arquivos EDI-TXT ...', '');
    End;

  Finally
    If (LPedidos.Count > 0) Then
    Begin
      Try
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Pedidos que não foram impressos';
        frmMensagemExplicativa.Width   := 450;
        frmMensagemExplicativa.Height  := 300;
        frmMensagemExplicativa.mmoInstru.Lines.Add('Os seguintes pedidos não foram impressos:');
        frmMensagemExplicativa.mmoInstru.Lines.Add('-----------------------------------------');
        frmMensagemExplicativa.mmoInstru.Lines.Add(LPedidos.Text);
        frmMensagemExplicativa.ShowModal;

        pAtualizarGrid;
        blnAtualizouGridNaImpressaoSeparacao := True;
      Finally
        FreeAndNil(frmMensagemExplicativa);
      End;
    End;

    pMostraMensagemNaoImpressos(LPedidosNaoImpressos);

    FiltroOnda := fosNaoUtilizarOnda;

    FreeAndNil(LPedidosNaoImpressos);
    FreeAndNil(stlPedidosCorpem);

    LPedidos.Free();

    If Assigned(objSepDor) Then
      FreeAndNil(objSepDor);

    If Assigned(FPedidosCortados) Then
      FreeAndNil(FPedidosCortados);

    If Assigned(FListaPDMarketPlace) Then
      FreeAndNil(FListaPDMarketPlace);

    FreeAndNil(FItensSemSaldoDispParaAtenderPDOnda);
  End;
end;

function TfrmFatExpedicao.fImprimirSeparacaoParcial: Boolean;
var
  LChaLck,
  LNumDoc,
  LEspDoc,
  LCodEmp,
  LCodCLi: String;
  LQry: TUniQuery;
  LSelItensImpSep: TfrmSelItensImprimirSeparacao;
  LUsaLck: Boolean;
  LConsiderarJaSeparado: Boolean;
begin
  Result := True;

  if (not fPermiteImprimirSeparacaoParcial) then
    Exit;

  LConsiderarJaSeparado := fCfgSis('SPCIMP', varBoolean);

  FSeqSeparacaoParcial := 0;

  LNumDoc := fField('NUMDOC').AsString;
  LEspDoc := fField('ESPDOC').AsString;
  LCodEmp := fField('CODEMP').AsString;
  LCodCLi := fField('CODCLI').AsString;

  LChaLck := 'FATGOR' + LNumDoc + LEspDoc + LCodEmp;
  LUsaLck := (Not objLock.fLocalizaTrava(LChaLck));

  If LUsaLck Then
  Begin
    if (not objLock.fLock_Unlock(LChaLck, True, False)) then
    begin
      Screen.Cursor := crDefault;
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(LChaLck)  + '!', ['&Ok']);
      Exit(False);
    end;

    If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
      objLock.fLock_Unlock(LChaLck + STR_TRAVA_CONFERENCIA, True, False);

    LChaLck := 'CADREC' + LNumDoc + LEspDoc + LCodEmp + LCodCli;

    if (not objLock.fLock_Unlock(LChaLck, True, False)) then
    begin
      Screen.Cursor := crDefault;
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(LChaLck)  + '!', ['&Ok']);
      Exit(False);
    end;
  End;

  LQry := fCriaQuery;
  pCriarFormularios(TfrmSelItensImprimirSeparacao, LSelItensImpSep);

  try
    LSelItensImpSep.strNumDoc := fField('NUMDOC').AsString;
    LSelItensImpSep.strEspDoc := fField('ESPDOC').AsString;
    LSelItensImpSep.strCodEmp := fField('CODEMP').AsString;
    LSelItensImpSep.strCodCli := fField('CODCLI').AsString;
    LSelItensImpSep.strCodVen := fField('CODVEN').AsString;

    LQry.SQL.Add('SELECT F.AUTOINCREM AUTINC, FDO_CODITE CODITE, FDO_DESCRI DESITE, ');
    LQry.SQL.Add('  (IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0)) AS QTDITE, ');
    LQry.SQL.Add('  IF((IFNULL(FDO_QTDSEP, 0) > 0), FDO_QTDSEP - IFNULL(FDO_QTDBAI, 0), FDO_QTDITE) QTDSEP, ');
    LQry.SQL.Add('  (IFNULL(FDO_QTDSEP, 0) - IFNULL(FDO_QTDBAI, 0)) QTDANT, ');
    LQry.SQL.Add('  IFNULL((FDO_QTDSEP - IFNULL(FDO_QTDBAI, 0)), 0) SEPARA ');
    LQry.SQL.Add('FROM FATDOR F ');
    LQry.SQL.Add('INNER JOIN EXTDOR E ON F.AUTOINCREM = FDO_SEQFDO ');
    LQry.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC ');
    LQry.SQL.Add('  AND FDO_ESPDOC = :ESPDOC ');
    LQry.SQL.Add('  AND FDO_CODEMP = :CODEMP ');
    LQry.SQL.Add('  AND FDO_CODCLI = :CODCLI ');
    LQry.SQL.Add('  AND (IFNULL(FDO_QTDITE, 0) - IFNULL(FDO_QTDBAI, 0)) > 0 ');
    LQry.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
    LQry.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
    LQry.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;
    LQry.ParamByName('CODCLI').AsString := fField('CODCLI').AsString;
    LQry.Open;

    LQry.First;

    while not LQry.Eof do
    begin
      LSelItensImpSep.FItens.Append;
      LSelItensImpSep.FItens.FieldByName('AUTINC').AsString := LQry.FieldByName('AUTINC').AsString;
      LSelItensImpSep.FItens.FieldByName('CODITE').AsString := LQry.FieldByName('CODITE').AsString;
      LSelItensImpSep.FItens.FieldByName('DESITE').AsString := LQry.FieldByName('DESITE').AsString;
      LSelItensImpSep.FItens.FieldByName('QTDITE').AsFloat  := LQry.FieldByName('QTDITE').AsFloat;
      LSelItensImpSep.FItens.FieldByName('QTDSEP').AsFloat  := IIF(LConsiderarJaSeparado, 0, LQry.FieldByName('QTDSEP').AsFloat);
      LSelItensImpSep.FItens.FieldByName('QTDANT').AsFloat  := LQry.FieldByName('QTDANT').AsFloat;
      LSelItensImpSep.FItens.FieldByName('SEPARA').AsFloat  := LQry.FieldByName('SEPARA').AsFloat;
      LSelItensImpSep.FItens.Post;

      LQry.Next;
    end;

    Result := (LSelItensImpSep.ShowModal = mrOk);

    If Result Then
      FSeqSeparacaoParcial := LSelItensImpSep.intSeqSep;

  finally
    FreeAndNil(LQry);
    pFreeAndNil(LSelItensImpSep);

    If LUsaLck Then
    Begin
      LChaLck := 'FATGOR' + LNumDoc + LEspDoc + LCodEmp;
      objLock.fLock_Unlock(LChaLck, False, False);

      LChaLck := 'CADREC' + LNumDoc + LEspDoc + LCodEmp + LCodCli;
      objLock.fLock_Unlock(LChaLck, False, False);
    End;
  end;
end;

procedure TfrmFatExpedicao.pMostraMensagemNaoImpressos(const lPedidosNaoImpressos: TStringList);
  Var
    frmMensagemExplicativa : TfrmMensagemExplicativa;
begin
  If (LPedidosNaoImpressos.Count > 0) Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    Try

      frmMensagemExplicativa.Caption := 'Pedidos que não foram impressos';
      frmMensagemExplicativa.Width   := 450;
      frmMensagemExplicativa.Height  := 300;
      frmMensagemExplicativa.mmoInstru.Lines.Add('CFG_IMSEPO configurada apenas para imprimir separação de pedidos que não estão conferidos/expedidos.');
      frmMensagemExplicativa.mmoInstru.Lines.Add('Os seguintes pedidos não foram impressos:');
      frmMensagemExplicativa.mmoInstru.Lines.Add('-----------------------------------------');
      frmMensagemExplicativa.mmoInstru.Lines.Add(LPedidosNaoImpressos.Text);
      frmMensagemExplicativa.ShowModal;

    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;
  End;

end;

function TfrmFatExpedicao.fInformacaoFatParcial: String;
begin
  Result := 'PERMITE FATURAMENTO PARCIAL';
end;

function TfrmFatExpedicao.fInformacaoFatTotal: String;
begin
  Result := 'OBRIGATÓRIO FATURAMENTO TOTAL';
end;

function TfrmFatExpedicao.fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem: String): Boolean;
Var
  LTipoItemDoPedido: TTipoItemDoPedidoExp;
  LTipoPedidoPorQuantidadeDeProdutos: TTipoPedidoPorQuantidadeDeProdutosExp;
  LTipoQuantidadeDoItemNoPedido: TTipoQuantidadeDoItemNoPedidoExp;
begin
  Result := False;

  If fCfgSis('BAREXP', varBoolean) and (fCampoTabela('ITE_BAREXP', 'CADITE', ['ITE_CODITE'], [strCodigoItem]) = 'S') Then
  Begin
    pMensagemSonora('Para expedir o produto ' + strCodigoItem + ' é necessário '+
      'informar o código de barras. Esta informação é obrigatória para este item. '+
      'Verifique o cadastro de produtos - Aba "Dados de Saída" - Campo "Obrig. Cód. Barras Expedição"');
    Exit;
  End;

  For LTipoItemDoPedido := Low(TTipoItemDoPedidoExp) To High(TTipoItemDoPedidoExp) Do
    For LTipoPedidoPorQuantidadeDeProdutos := Low(TTipoPedidoPorQuantidadeDeProdutosExp) To High(TTipoPedidoPorQuantidadeDeProdutosExp) Do
      For LTipoQuantidadeDoItemNoPedido := Low(TTipoQuantidadeDoItemNoPedidoExp) To High(TTipoQuantidadeDoItemNoPedidoExp) Do
      Begin
        If fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem,
          LTipoItemDoPedido, LTipoPedidoPorQuantidadeDeProdutos, LTipoQuantidadeDoItemNoPedido) Then
        Begin
          Self.FTipoItemDoPedidoOndaSeparacao := LTipoItemDoPedido;
          Exit(True);
        End;
      End;

  pMensagemOk('Não foi localizado nenhum '+strDescDoc+' com este produto pendente de expedição. Verifique!');
end;

function TfrmFatExpedicao.fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem: String;
                                                            ATipoItemDoPedido: TTipoItemDoPedidoExp;
                                                            ATipoPedidoPorQuantidadeDeProdutos: TTipoPedidoPorQuantidadeDeProdutosExp;
                                                            ATipoQuantidadeDoItemNoPedido: TTipoQuantidadeDoItemNoPedidoExp): Boolean;
Var
  qryPedidos: TUniQuery;

  function fCarregarPedidos(strFiltroItem: String): Boolean;
  Var
    strSQL: String;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT DISTINCT ';
          strSQL := strSQL + '   FATGOR.AUTOINCREM, ';
          strSQL := strSQL + '   (FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) AS QTDITE ';
          strSQL := strSQL + ' FROM FATDOR ';
          strSQL := strSQL + '   INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + '   LEFT  JOIN ITEBAR ON ITEBAR.BAR_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + ' WHERE FGO_SEQSEP = "'+strNumeroOnda+'" ';
          strSQL := strSQL + '   AND ' + strFiltroItem;
          strSQL := strSQL + '   AND IFNULL(FDO_QTDEXP, 0) = 0 ';
          strSQL := strSQL + fFiltroProdutosExpedicaoItens(False,
                                                           blnUsaImpressaoSeparacaoPorLocal,
                                                           objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat,
                                                           False);
          strSQL := strSQL + ' ORDER BY FGO_PREVIS ';
        End;

      opSubItemDeItemInseridoNoPedido:
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT DISTINCT ';
          strSQL := strSQL + '   FATGOR.AUTOINCREM, ';
          strSQL := strSQL + '   FDO_CODITE AS ITEEST, ';
          strSQL := strSQL + '   DMT_ITESUB AS ITESUB, ';
          strSQL := strSQL + '   (FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) AS QTDITE ';
          strSQL := strSQL + ' FROM FATDOR ';
          strSQL := strSQL + '   INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN GERMAT ON GERMAT.GMT_CODITE = FATDOR.FDO_CODITE ';
          strSQL := strSQL + '   INNER JOIN DETMAT ON DETMAT.DMT_SEQGER = GERMAT.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN CADITE ON CADITE.ITE_CODITE = DETMAT.DMT_ITESUB ';
          strSQL := strSQL + '   LEFT  JOIN ITEBAR ON ITEBAR.BAR_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + ' WHERE FGO_SEQSEP = "'+strNumeroOnda+'" ';
          strSQL := strSQL + '   AND ' + strFiltroItem;
          strSQL := strSQL + '   AND IFNULL(FDO_QTDEXP, 0) = 0 ';
          strSQL := strSQL + '   AND FDO_BXSBIT = "S" ';//Baixa os sub-itens da estrutura
          strSQL := strSQL + fFiltroProdutosExpedicaoItens(False,
                                                           blnUsaImpressaoSeparacaoPorLocal,
                                                           objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat,
                                                           False);
          strSQL := strSQL + ' ORDER BY FGO_PREVIS ';
        End;
    End;

    qryPedidos.Close;
    qryPedidos.SQL.Text := strSQL;
    qryPedidos.Open;

    Result := False;

    qryPedidos.First;
    While Not qryPedidos.Eof Do
    Begin
      If (cdsPedidos.Locate('AUTINC', qryPedidos.FieldByName('AUTOINCREM').AsString, [])) Then
      Begin
        Result := True;

        Case ATipoPedidoPorQuantidadeDeProdutos Of
          opPedidosDeUnicoItem:
            Result := Result And
              SameValue(cdsPedidos.FieldByName('QTDPRO').AsInteger, 1);

          opPedidosDeVariosItens:
            Result := Result And
              Not SameValue(cdsPedidos.FieldByName('QTDPRO').AsInteger, 1);
        End;

        Case ATipoQuantidadeDoItemNoPedido Of
          opQuantidadeUmItem:
            Result := Result And
              SameValue(fFormataFloat(qryPedidos.FieldByName('QTDITE').AsFloat, 4), 1.000);

          opQuantidadeDiferenteDeUmItem:
            Result := Result And
              Not SameValue(fFormataFloat(qryPedidos.FieldByName('QTDITE').AsFloat, 4), 1.000);
        End;

        If Result Then
          Exit;
      End;
      qryPedidos.Next;
    End;
  end;

  function fCarregarPedidosFaturamentoAutomatico(strFiltroItem: String): Boolean;
  Var
    strSQL: String;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT DISTINCT ';
          strSQL := strSQL + '   FATGOR.AUTOINCREM, ';
          strSQL := strSQL + '   FDO_QTDITE AS QTDITE ';
          strSQL := strSQL + ' FROM FATDOR ';
          strSQL := strSQL + '   INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
          strSQL := strSQL + '   INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATAUT ON FATGOR.FGO_NUMDOC = FATAUT.FAT_NUMDOC AND FATGOR.FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FATGOR.FGO_CODEMP = FATAUT.FAT_EMPDOC ';
          strSQL := strSQL + '   INNER JOIN MOVGER ON FATAUT.FAT_SEQGER = MOVGER.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN LOGNFE ON NFE_NUMDOC = GER_NUMDOC ';
          strSQL := strSQL + '                    AND NFE_ESPDOC = GER_ESPDOC ';
          strSQL := strSQL + '                    AND NFE_CODEMP = GER_CODEMP ';
          strSQL := strSQL + '                    AND NFE_CODCLI = GER_CODCLI ';
          strSQL := strSQL + '                    AND IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ';
          strSQL := strSQL + '   INNER JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + '   LEFT  JOIN ITEBAR ON ITEBAR.BAR_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + ' WHERE FGO_SEQSEP = "'+strNumeroOnda+'" ';
          strSQL := strSQL + '   AND ' + strFiltroItem;
          strSQL := strSQL + '   AND FGO_JAFATU = 1 ';
          strSQL := strSQL + '   AND GER_DTLBEX IS NULL ';
          If fCfgSis('EXPNFA', varBoolean) Then
            strSQL := strSQL + '  AND NFE_STATUS = "AT" ';
          strSQL := strSQL + fFiltroProdutosExpedicaoItens(False, blnUsaImpressaoSeparacaoPorLocal,
            objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat, False, False, '0', '1');
          strSQL := strSQL + ' ORDER BY FGO_PREVIS ';
        End;

      opSubItemDeItemInseridoNoPedido:
        Begin
          strSQL := '';
          strSQL := strSQL + ' SELECT DISTINCT ';
          strSQL := strSQL + '   FATGOR.AUTOINCREM, ';
          strSQL := strSQL + '   FDO_CODITE AS ITEEST, ';
          strSQL := strSQL + '   DMT_ITESUB AS ITESUB, ';
          strSQL := strSQL + '   FDO_QTDITE AS QTDITE  ';
          strSQL := strSQL + ' FROM FATDOR ';
          strSQL := strSQL + '   INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI ';
          strSQL := strSQL + '   INNER JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN FATAUT ON FATGOR.FGO_NUMDOC = FATAUT.FAT_NUMDOC AND FATGOR.FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FATGOR.FGO_CODEMP = FATAUT.FAT_EMPDOC ';
          strSQL := strSQL + '   INNER JOIN MOVGER ON FATAUT.FAT_SEQGER = MOVGER.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN LOGNFE ON NFE_NUMDOC = GER_NUMDOC ';
          strSQL := strSQL + '                    AND NFE_ESPDOC = GER_ESPDOC ';
          strSQL := strSQL + '                    AND NFE_CODEMP = GER_CODEMP ';
          strSQL := strSQL + '                    AND NFE_CODCLI = GER_CODCLI ';
          strSQL := strSQL + '                    AND IFNULL(NFE_SERIE_, "") = IFNULL(GER_SERIE_, "") ';
          strSQL := strSQL + '   INNER JOIN GERMAT ON GERMAT.GMT_CODITE = FATDOR.FDO_CODITE ';
          strSQL := strSQL + '   INNER JOIN DETMAT ON DETMAT.DMT_SEQGER = GERMAT.AUTOINCREM ';
          strSQL := strSQL + '   INNER JOIN CADITE ON CADITE.ITE_CODITE = DETMAT.DMT_ITESUB ';
          strSQL := strSQL + '   LEFT  JOIN ITEBAR ON ITEBAR.BAR_CODITE = CADITE.ITE_CODITE ';
          strSQL := strSQL + ' WHERE FGO_SEQSEP = "'+strNumeroOnda+'" ';
          strSQL := strSQL + '   AND ' + strFiltroItem;
          strSQL := strSQL + '   AND FGO_JAFATU = 1 ';
          strSQL := strSQL + '   AND GER_DTLBEX IS NULL ';
          If fCfgSis('EXPNFA', varBoolean) Then
            strSQL := strSQL + '  AND NFE_STATUS = "AT" ';
          strSQL := strSQL + '   AND FDO_BXSBIT = "S" ';//Baixa os sub-itens da estrutura
          strSQL := strSQL + fFiltroProdutosExpedicaoItens(False, blnUsaImpressaoSeparacaoPorLocal,
            objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat, False, False, '0', '1');
          strSQL := strSQL + ' ORDER BY FGO_PREVIS ';
        End;
    End;

    qryPedidos.Close;
    qryPedidos.SQL.Text := strSQL;
    qryPedidos.Open;

    Result := False;

    qryPedidos.First;
    While Not qryPedidos.Eof Do
    Begin
      If (cdsPedidos.Locate('AUTINC', qryPedidos.FieldByName('AUTOINCREM').AsString, [])) Then
      Begin
        Result := True;

        Case ATipoPedidoPorQuantidadeDeProdutos Of
          opPedidosDeUnicoItem:
            Result := Result And
              SameValue(cdsPedidos.FieldByName('QTDPRO').AsInteger, 1);

          opPedidosDeVariosItens:
            Result := Result And
              Not SameValue(cdsPedidos.FieldByName('QTDPRO').AsInteger, 1);
        End;

        Case ATipoQuantidadeDoItemNoPedido Of
          opQuantidadeUmItem:
            Result := Result And
              SameValue(fFormataFloat(qryPedidos.FieldByName('QTDITE').AsFloat, 4), 1.000);

          opQuantidadeDiferenteDeUmItem:
            Result := Result And
              Not SameValue(fFormataFloat(qryPedidos.FieldByName('QTDITE').AsFloat, 4), 1.000);
        End;

        If Result Then
          Exit;
      End;
      qryPedidos.Next;
    End;
  end;

  function fLocalizarPorCodigoItem(): Boolean;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Result := fCarregarPedidos('FATDOR.FDO_CODITE = ' + strCodigoItem.QuotedString());

      opSubItemDeItemInseridoNoPedido:
        Result := fCarregarPedidos('DETMAT.DMT_ITESUB = ' + strCodigoItem.QuotedString());

      Else
        Result := False;
    End;
  end;

  function fLocalizarPorCodigoItemFaturamentoAutomatico(): Boolean;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Result := fCarregarPedidosFaturamentoAutomatico('FATDOR.FDO_CODITE = ' + strCodigoItem.QuotedString());

      opSubItemDeItemInseridoNoPedido:
        Result := fCarregarPedidosFaturamentoAutomatico('DETMAT.DMT_ITESUB = ' + strCodigoItem.QuotedString());

      Else
        Result := False;
    End;
  end;

  function fLocalizarPorCodigoBarras(): Boolean;
  begin
    Result := fCarregarPedidos('CADITE.ITE_CODBAR = ' + strCodigoItem.QuotedString());
  end;

  function fLocalizarPorCodigoBarrasFaturamentoAutomatico(): Boolean;
  begin
    Result := fCarregarPedidosFaturamentoAutomatico('CADITE.ITE_CODBAR = ' + strCodigoItem.QuotedString());
  end;

  function fLocalizarPorCodigoBarrasEmbalagem(): Boolean;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Result := fCarregarPedidos('ITEBAR.BAR_CODBAR = ' + strCodigoItem.QuotedString() +
          ' AND (FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) >= BAR_EMBALA ');

      opSubItemDeItemInseridoNoPedido:
        Result := fCarregarPedidos('ITEBAR.BAR_CODBAR = ' + strCodigoItem.QuotedString() +
          ' AND ((FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)) * DETMAT.DMT_QTDITE) >= BAR_EMBALA ');

      Else
        Result := False;
    End;
  end;

  function fLocalizarPorCodigoBarrasEmbalagemFaturamentoAutomatico(): Boolean;
  begin
    Case ATipoItemDoPedido Of
      opItemInseridoNoPedido:
        Result := fCarregarPedidosFaturamentoAutomatico('ITEBAR.BAR_CODBAR = ' + strCodigoItem.QuotedString() +
          ' AND (IFNULL(FDO_QTDBAI, FDO_QTDITE)) >= BAR_EMBALA ');

      opSubItemDeItemInseridoNoPedido:
        Result := fCarregarPedidosFaturamentoAutomatico('ITEBAR.BAR_CODBAR = ' + strCodigoItem.QuotedString() +
          ' AND ((IFNULL(FDO_QTDBAI, FDO_QTDITE)) * DETMAT.DMT_QTDITE) >= BAR_EMBALA ');

      Else
        Result := False;
    End;
  end;

begin

  If Not fOndaSeparacao Then
    Exit(False);

  If fEmptyStr(strNumeroOnda) Then
    Exit(False);

  If ATipoItemDoPedido = opSubItemDeItemInseridoNoPedido Then
    If fCfgSis('EMOPPD', VarBoolean) Then
      Exit(False);

  qryPedidos := fCriaQuery;
  Try
    If fLocalizarPorCodigoItem Then
      Exit(True);

    If fLocalizarPorCodigoBarras Then
      Exit(True);

    If fLocalizarPorCodigoBarrasEmbalagem Then
      Exit(True);

    If blnExibirPedidosFaturamentoAutomatico Then
      If fLocalizarPorCodigoItemFaturamentoAutomatico Then
        Exit(True);

    If blnExibirPedidosFaturamentoAutomatico Then
      If fLocalizarPorCodigoBarrasFaturamentoAutomatico Then
        Exit(True);

    If blnExibirPedidosFaturamentoAutomatico Then
      If fLocalizarPorCodigoBarrasEmbalagemFaturamentoAutomatico Then
        Exit(True);

    Result := False;
  Finally
    FreeAndNil(qryPedidos);
  End;
end;

function TfrmFatExpedicao.fUtilizaSolicitacaoSeparador: Boolean;
begin
  //Só pede o separador quando o separado não é por local de separaçao WMS, nesse caso será solicitado na FatDefineLotesPedidoWms,
  //pois a qtde de separadores vai depender das localizações fisicas.
  Result := ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) And fUtilizaImpressaoSeparacao And
    (strSenSep <> 'N') And (fCfgSis('LSEWMS', varString) = 'N') And
    (Not fFiltrarLocalSeparacaoItensWMS);
end;

function TfrmFatExpedicao.fPermiteDesmembrarPedidoGeradoDeOutraLoja(const blnExibeMensagem: Boolean): Boolean;
begin
  Result := True;
  If (fField('CODEMP').AsString <> VS_strCodEmp) And (Not fPedidoRegimeEspecial) Then
  Begin
    If fPermitirDesmembrarVendaTipoExpedicaoPedidoEGerarVendaPerdida Then
      Exit;

    Result := False;

    If (blnExibeMensagem) Then
      fMensagem('PEDIDO: ' + fField('NUMDOC').AsString + '-' + fField('CODEMP').AsString,
                'Este pedido foi gerado por outra Empresa, não é possível ser alterado! ' +
                'Favor entrar em contato com a Empresa que originou o pedido e solicitar '+
                'alteração.', ['&Ok']);
    Exit;
  End;
end;

function TfrmFatExpedicao.fPermiteGerarOndaComClientesFilialDiferentes: Boolean;
var
  LCont: Integer;
  LCliFilAnt: String;
  LComCliFil,
  LSemCliFil: Boolean;
begin
  Result := True;

  if (not fUsaRotinaWMS) then
    Exit;

  if (not fCfgSis('SOLOLA', varBoolean)) then
    Exit;

  if (not fCfgSis('FAGFIL', varBoolean)) then
    Exit;

  LCliFilAnt := '';
  LComCliFil := False;
  LSemCliFil := False;

  for LCont := 0 to dbgPedidos.SelectedRows.Count - 1 Do
  begin
    dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[LCont]);

    if (Pos(dtsPedidos.DataSet.FieldByName('CODCLI').AsString, VS_strCliFil) > 0) then
    begin
      LComCliFil := True;

      if (not fEmptyStr(LCliFilAnt)) and (LCliFilAnt <> dtsPedidos.DataSet.FieldByName('CODCLI').AsString) then
      begin
        Result := False;
        fMensagem('Atenção!', 'Não é permitido gerar onda com pedidos de cliente filial diferentes.', ['&Ok']);
        Exit;
      end;

      LCliFilAnt := dtsPedidos.DataSet.FieldByName('CODCLI').AsString;
    end
    else
      LSemCliFil := True;
  end;

  if LComCliFil and LSemCliFil then
  begin
    Result := False;
    fMensagem('Atenção!', 'Não é permitido gerar onda com pedidos de cliente filial junto com pedidos de clientes não filial.', ['&Ok']);
  end;
end;

function TfrmFatExpedicao.fPermiteNotificacaoSonoraNovosPedidos(const cdsNovosPedidos: TUniClientDataSet): Boolean;
  Var
    strTipEntSom: String;
begin
  Result := True;

  strTipEntSom := fCfgSis('SOMTSP', varString);

  If (blnSOMNSP) And (Pos(strTipEntSom, 'R_E_') > 0) Then
  Begin
    Result := False;

    cdsNovosPedidos.First;
    While Not cdsNovosPedidos.Eof Do
    Begin
      If (Pos(cdsNovosPedidos.FieldByName('ENTRET').AsString, strTipEntSom) > 0) Then
      Begin
        Result := True;
        Break;
      End;

      cdsNovosPedidos.Next;
    End;
  End;
end;

function TfrmFatExpedicao.fPermiteReimpressaoDeSeparacao(stlPedSel: TStringList): Boolean;
  Var
    arrPedido : TStringArray;
    strAutIncPed : String;
    intCnt : Integer;
begin
  Result := True;
  SetLength(arrPedido, 0);
  If (Not fUsaRotinaWMS) And (fCfgSis('RESPEX', varBoolean)) And (Not fPermiteImprimirSeparacaoParcial) Then
  Begin
    If (Not Assigned(stlPedSel)) Then
    Begin
      If (StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) > 0) Then
        pAddDados(arrPedido, fField('NUMDOC').AsString + '-' + fField('ESPDOC').AsString + '-' + fField('CODEMP').AsString + '-' + fField('CODCLI').AsString);
    End
    Else
    Begin
      For strAutIncPed In stlPedidos Do
      Begin
        If (cdsPedidos.Locate('AUTINC', strAutIncPed, [])) And
           (StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) > 0) Then
        Begin
          pAddDados(arrPedido, fField('NUMDOC').AsString + '-' + fField('ESPDOC').AsString + '-' + fField('CODEMP').AsString + '-' + fField('CODCLI').AsString);
        End;
      End;
    End;

    If (Length(arrPedido) > 0) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Expedição - Reimprimir Separação de Produtos');
      objLiberacao.objMsgLibera.pAddTexto('Documentos que já tiveram a separação impressa:');

      For intCnt := Low(arrPedido) To High(arrPedido) Do
        objLiberacao.objMsgLibera.pAddTexto(arrPedido[intCnt]);

      objLiberacao.strDirAce := 'RIMPSE';
      objLiberacao.strMsgSen := 'Expedição - Reimprimir Separação de Produtos';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;


      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
      End;
    End;
  End;
end;

function TfrmFatExpedicao.fPermiteReimprimirSeparacao: Boolean;
const
  SEPIMP = 'IF(FGO_SEPIMP = "N" OR IFNULL(FGO_SEPIMP,"") = "", "0", IF(FGO_SEPIMP = "S", "1", FGO_SEPIMP))';
var
  LCds: TUniClientDataSet;
  LPDCortados: TStringList;

  procedure pDesmarcaPedido;
  var
    LIndex: Integer;
  begin
    LIndex := stlPedidos.IndexOf(LCds.FieldByName('AUTINC').AsString);

    if (LIndex >= 0) then
      stlPedidos.Delete(LIndex);

    if dtsPedidos.DataSet.Locate('AUTINC', LCds.FieldByName('AUTINC').AsString, []) then
      dbgPedidos.SelectedRows.CurrentRowSelected := False;
  end;
begin
  Result := True;

  if (not fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO) and (not fUsaOndaSeparacaoAgrupamento) then
    Exit;

  LPDCortados := TStringList.Create;

  try
    if (stlPedidos.Count = 0) then
      Result := (fCampoTabela(SEPIMP, 'FATGOR', ['AUTOINCREM'], [fField('AUTINC').AsString]) = '0')
    else
    begin
      LCds := TUniClientDataSet.Create(nil);

      try
        pCloneDataSet(LCds, cdsPedidos);
        LCds.First;

        while not LCds.Eof do
        begin
          if (fSelecionado(LCds)) and (fCampoTabela(SEPIMP, 'FATGOR', ['AUTOINCREM'], [LCds.FieldByName('AUTINC').AsString]) > '0') then
          begin
            LPDCortados.Add(LCds.FieldByName('NUMDOC').AsString + '-' +
                            LCds.FieldByName('ESPDOC').AsString + '-' +
                            LCds.FieldByName('CODEMP').AsString);

            pDesmarcaPedido;
          end;

          LCds.Next;
        End;
      finally
        FreeAndNil(LCds);
      end;

      Result := (dbgPedidos.SelectedRows.Count > 0);
    end;

    if Result and (LPDCortados.Count = 0) then
      Exit;

    if fUsaOndaSeparacaoAgrupamento then
    begin
      fMensagem('', 'Não é permitido reimprimir a separação. Você pode limpar a separação em "[ALT + F2] Limpar Separação" e imprimi-la novamente.', ['&OK']);
      Exit(False);
    end
    else
    begin
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

      try
        frmMensagemExplicativa.Caption := 'Reimpressão da Separação';
        frmMensagemExplicativa.Width   := 550;
        frmMensagemExplicativa.Height  := 250;
        frmMensagemExplicativa.mmoInstru.Lines.Add(IIF((not Result),
                                                       'Não é permitido reimprimir a separação. ',
                                                       'Há documentos selecionados que já possuem a separação impressa e serão desmarcados. ') +
                                                       'Você pode limpar a separação em "[ALT + F2] Limpar Separação" e imprimi-la novamente.');
        frmMensagemExplicativa.mmoInstru.Lines.Add('');
        frmMensagemExplicativa.mmoInstru.Lines.Add('Observação: Para isso é preciso que todos os itens cheguem na "Conferência", caso algum item esteja em "Vagão", não será possível limpar a separação!');

        if (LPDCortados.Count > 0) then
        begin
          frmMensagemExplicativa.Height  := 300;
          frmMensagemExplicativa.mmoInstru.Lines.Add('');
          frmMensagemExplicativa.mmoInstru.Lines.Add('Relação de documentos com a separação já impressa:');
          frmMensagemExplicativa.mmoInstru.Lines.Add(LPDCortados.Text);
        end;

        frmMensagemExplicativa.ShowModal;

        pAtualizarGrid;
        blnAtualizouGridNaImpressaoSeparacao := True;
      finally
        FreeAndNil(frmMensagemExplicativa);
      end;
    end;
  finally
    FreeAndNil(LPDCortados);
  end;
end;

function TfrmFatExpedicao.fAjustaDadosParaImpressaoDeSeparacao(blnAlteraLote: Boolean = False): Boolean;
var
  frmFatDefineLoteSeparacao: TfrmFatDefineLoteSeparacao;
  objPedido: TPedidoVenda;
  qryFatDor: TUniQuery;
  intIndex: Integer;
begin
  Result := True;

  if not fUtilizaDefinicaoLoteSemWMS then
    Exit;

  if stlPedidos.Count <= 0 then
    Exit;

  qryFatDor := fCriaQuery;
  pCriarFormularios(TfrmFatDefineLoteSeparacao, frmFatDefineLoteSeparacao);

  try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;
    qryFatDor.SQL.Add('SELECT AUTOINCREM, FDO_CODITE, FDO_DESCRI, FDO_QTDITE, FDO_NUMLOT, FDO_CODEMP, FDO_EMPITE');
    qryFatDor.SQL.Add('FROM FATDOR');
    qryFatDor.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qryFatDor.SQL.Add('AND FDO_ESPDOC = :ESPDOC');
    qryFatDor.SQL.Add('AND FDO_CODEMP = :CODEMP');
    qryFatDor.SQL.Add('AND FDO_CODCLI = :CODCLI');

    for intIndex := 0 to stlPedidos.Count - 1 do
    begin
      objPedido := TPedidoVenda(stlPedidos.Objects[intIndex]);

      qryFatDor.Close;
      qryFatDor.ParamByName('NUMDOC').AsString := objPedido.strNumDoc;
      qryFatDor.ParamByName('ESPDOC').AsString := objPedido.strEspDoc;
      qryFatDor.ParamByName('CODEMP').AsString := objPedido.strCodEmp;
      qryFatDor.ParamByName('CODCLI').AsString := objPedido.strCodCli;
      qryFatDor.Open;

      if qryFatDor.IsEmpty then
        Continue;

      while not qryFatDor.Eof do
      begin
        if blnAlteraLote then
        begin
          if qryFatDor.FieldByName('FDO_NUMLOT').AsString = 'A DEFINIR' then
          begin
            qryFatDor.Next;
            Continue;
          end;
        end
        else
        begin
          if qryFatDor.FieldByName('FDO_NUMLOT').AsString <> 'A DEFINIR' then
          begin
            qryFatDor.Next;
            Continue;
          end;
        end;

        frmFatDefineLoteSeparacao.cdsItens.Append;
        frmFatDefineLoteSeparacao.cdsItensAUTINC.AsString := qryFatDor.FieldByName('AUTOINCREM').AsString;
        frmFatDefineLoteSeparacao.cdsItensCODITE.AsString := qryFatDor.FieldByName('FDO_CODITE').AsString;
        frmFatDefineLoteSeparacao.cdsItensDESITE.AsString := qryFatDor.FieldByName('FDO_DESCRI').AsString;
        frmFatDefineLoteSeparacao.cdsItensNUMLOT.AsString := qryFatDor.FieldByName('FDO_NUMLOT').AsString;
        frmFatDefineLoteSeparacao.cdsItensQTDITE.AsFloat := qryFatDor.FieldByName('FDO_QTDITE').AsFloat;
        frmFatDefineLoteSeparacao.cdsItensNUMDOC.AsString := objPedido.strNumDoc;
        frmFatDefineLoteSeparacao.cdsItensLOCFIS.AsString := fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_NUMLOT','LOT_CODEMP','LOT_CODITE'], [qryFatDor.FieldByName('FDO_NUMLOT').AsString,qryFatDor.FieldByName('FDO_CODEMP').AsString,qryFatDor.FieldByName('FDO_CODITE').AsString], False);
        frmFatDefineLoteSeparacao.cdsItensEMPITE.AsString := qryFatDor.FieldByName('FDO_EMPITE').AsString;
        frmFatDefineLoteSeparacao.cdsItens.Post;

        qryFatDor.Next;
      end;
    end;

    if frmFatDefineLoteSeparacao.cdsItens.RecordCount <= 0 then
      Exit;

    frmFatDefineLoteSeparacao.ShowModal;

    if frmFatDefineLoteSeparacao.ModalResult = mrOk then
    begin
      frmFatDefineLoteSeparacao.cdsItens.First;

      qryFatDor.Close;
      qryFatDor.SQL.Clear;
      qryFatDor.SQL.Add('UPDATE FATDOR');
      qryFatDor.SQL.Add('SET FDO_NUMLOT = :NUMLOT');
      qryFatDor.SQL.Add('WHERE AUTOINCREM = :AUTINC');

      while not frmFatDefineLoteSeparacao.cdsItens.Eof do
      begin
        if frmFatDefineLoteSeparacao.cdsItensNUMLOT.AsString <> 'A DEFINIR' then
        begin
          qryFatDor.Close;
          qryFatDor.ParamByName('NUMLOT').AsString := frmFatDefineLoteSeparacao.cdsItensNUMLOT.AsString;
          qryFatDor.ParamByName('AUTINC').AsString := frmFatDefineLoteSeparacao.cdsItensAUTINC.AsString;
          qryFatDor.ExecSQL;

          ReprocessarItem(frmFatDefineLoteSeparacao.cdsItensCODITE.AsString, frmFatDefineLoteSeparacao.cdsItensEMPITE.AsString);
        end;

        frmFatDefineLoteSeparacao.cdsItens.Next;
      end;

      pAtualizarGrid;

    end
    else
      Result := False;
  finally
    pFreeAndNil(frmFatDefineLoteSeparacao);
    FreeAndNil(qryFatDor);
  end;
end;

function TfrmFatExpedicao.fUtilizaDefinicaoLoteSemWMS: Boolean;
begin
  Result := False;

  if not fCfgSis('DLSWMS', varBoolean) then
    Exit;

  if fUsaRotinaWMS then
    Exit;

  if pos(fCfgSis('TIPEXP'), '3_4_') <= 0 then
    Exit;

  Result := True;
end;

function TfrmFatExpedicao.fUtilizaImpressaoSeparacao: Boolean;
begin
  If blnApenasConferenciaProdutosRetiraCaixa Then
    Exit(False);

  Result := (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Or (fCfgSis('SEPEXP') = 'E') Or blnApenasImprimirBaixarSeparacao;
end;

procedure TfrmFatExpedicao.pImprimeOndaSeparacaoItensSintetizados;
var
  strAutIncPed,
  strSeqSepSel : string;
  blnFiltered  : Boolean;
begin

  If (Not fOndaSeparacao) Then
    Exit;

  strSeqSepSel := EmptyStr;
  cdsPedidos.DisableControls;

  blnFiltered := cdsPedidos.Filtered;
  cdsPedidos.Filtered := False;
  For strAutIncPed In stlPedidos Do
  Begin
    If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
    Begin
      if (Pos(fField('SEQSEP').AsString, strSeqSepSel) <= 0) Then
        strSeqSepSel := strSeqSepSel + ',' + QuotedStr(fField('SEQSEP').AsString);
    End;
  End;
  cdsPedidos.Filtered := blnFiltered;
  cdsPedidos.EnableControls;

  Delete(strSeqSepSel,1,1);

  If Not fEmptyStr(strSeqSepSel) Then
    pSintetizaItensImpressaoOndaSeparacao(strSeqSepSel);
End;

procedure TfrmFatExpedicao.pImprimirSeparacao;
  Var
    objImpSep: TReimpressao;
    oprOdemProducao: TFatOrdProTintaMaquina;
    strSeparadorAnt: String;
    strOps : String;
    strMsgOpr: String;

begin
  inherited;

  If fCfgSis('SEPOPI', varBoolean) Then
  Begin

    strOps := '';
    strOps := TFatVendaImp.fGetOPs_PD(fField('NUMDOC').AsString,
                                      fField('ESPDOC').AsString,
                                      fField('CODEMP').AsString);

    If Not fEmptyStr(strOps) Then
    Begin

      fMensagem('Atenção', 'Este pedido ' + fField('NUMDOC').AsString + '-' + fField('ESPDOC').AsString + '-' + fField('CODEMP').AsString + ' ' +
                           'de venda possui item estrutura com ordem de produção. ' +
                           'A separação somente poderá ser impressa depois da baixa da ordem de produção. ' +
                           'OP(s): ' + strOps + '.', ['&Ok']);
      Exit;

    End;

  End;

  {***********************************}
  {* VALIDA SE HÁ PEDIDOS ANTERIORES *}
  {* PENDENTES DE SEPARAÇÃO          *}
  {********************************FS*}
  If (Not fVerificaItensPendentesSeparacao(fField('NUMDOC').AsString,
                                           fField('ESPDOC').AsString,
                                           fField('CODEMP').AsString)) Then
    Exit;

  strSeparadorAnt := '';
  //Atualiza o separador do pedido
  If fUtilizaSolicitacaoSeparador And (Not fOndaSeparacao) Then
  Begin
    strSeparadorAnt := fField('CODSEP').AsString;
    pAtualizaSeparadorPedido(Self.strSeparador);
  End;

  Try
    With cdsPedidos Do
    Begin
      //Caso nao usa a separacao WMS (JD Tintas), entao realiza a impressao normal do documento
      If (fOndaSeparacao) Then
      Begin
        Self.blnImprimiuSeparacao := True;
      End
      Else If Not fUsaRotinaWMS Then
      Begin
        //Imprimir separação por filas configuradas (MENIL)
        //Ou
        //imprimir separação por setor (DIPRONTO)
        If (fUtilizaFilasImpressaoSeparacaoConfiguradas(fField('ESPDOC').AsString)) Or
           (fImpressaoSeparacaoPorSetor) Then
          Self.blnImprimiuSeparacao := fImprimeSeparacaoFaturamento(fField('NUMDOC').AsString,
                                                                    fField('ESPDOC').AsString,
                                                                    fField('CODEMP').AsString,
                                                                    fField('CODCLI').AsString,
                                                                    fGetCodigoLocSep,
                                                                    (fField('FATAUT').AsString='S'))
        Else
        Begin
          //Cria objeto para imprimir o documento
          objImpSep := TReimpressao.Create(fField('NUMDOC').AsString,  //strNumDoc
                                           fField('ESPDOC').AsString,  //strEspDoc
                                           0,                               //dtaDtaIni
                                           0,                               //dtaDtaFin
                                           fField('CODCLI').AsString,  //strCodCli
                                           fField('CODEMP').AsString,  //strCodEmp
                                           fField('CODVEN').AsString,  //strCodVen
                                           VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,  //blnFaturamento
                                           '',                              //strTip_Fc
                                           fUtilizaImpressaoSeparacao,      //blnPergSep
                                           False,                           //blnFatVenda
                                           False,                           //blnCancelamento
                                           '',                              //strEspSel
                                           '',                              //strSerie
                                           False,                           //blnFiltrarNE
                                           0,                               //intFilCla
                                           False,                           //blnExiDocsCanc
                                           '');                             //strOriDoc

          objImpSep.blnExpedicao        := True;
          objImpSep.blnImpressaoColetor := False;

          If fImpressaoParcialConsiderandoJaImpresso Then
            objImpSep.blnReimpressaoDaSeparacaoPedido := False
          Else
            objImpSep.blnReimpressaoDaSeparacaoPedido := fField('SEPIMP').AsInteger = 1;

          //Caso utilize impressao de separacao
          If fUtilizaImpressaoSeparacao Then
          Begin
            objImpSep.blnSeparacaoDireto := Self.blnSeparacaoDireto;
            objImpSep.strTipImp          := Self.strTipImpSeparacao;

            If blnExibirPedidosFaturamentoAutomatico And (cdsPedidos.FieldByName('FATAUT').AsString = 'S') Then
            Begin
              Self.blnImprimiuSeparacao := objImpSep.fImprimeSeparacao('', True {blnQtdOri}, False, False, (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA),
                                                       False, opcTodos, False, IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,VS_strExpRetiraEntregaDocFat,VS_strExpRetiraEntrega),
                                                       blnApenasImprimirBaixarSeparacao, FSeqSeparacaoParcial);
              objImpSep.blnSeparacaoDireto := True;
            End
            Else If (fTemAbastecimento(fField('NUMDOC').AsString,
                                  fField('ESPDOC').AsString,
                                  fField('CODEMP').AsString,
                                  opcSolicitado, True)) Then
            Begin
              Self.blnImprimiuSeparacao := objImpSep.fImprimeSeparacao('', False, False, False, (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA),
                                                       False, opcSolicitado, False, IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,VS_strExpRetiraEntregaDocFat,VS_strExpRetiraEntrega),
                                                       blnApenasImprimirBaixarSeparacao, FSeqSeparacaoParcial);
              objImpSep.blnSeparacaoDireto := True;
            End
            Else
            Begin
              Self.blnImprimiuSeparacao := True;
            End;

            If Self.blnImprimiuSeparacao Then
            Begin
              If (fTemAbastecimento(fField('NUMDOC').AsString,
                                    fField('ESPDOC').AsString,
                                    fField('CODEMP').AsString,
                                    opcNaoSolicitado, True)) Then
              Begin
                objImpSep.blnImpressaoColetor := False;

                If (fAtivadoMontagemCaixaConferenciaAUTCOMColetor) And
                   (strViaConferenciaSeparacao = 'C') Then
                  objImpSep.blnImpressaoColetor := True;

                Self.blnImprimiuSeparacao := objImpSep.fImprimeSeparacao('', False, False, False, (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA), False,
                                                                         opcNaoSolicitado, False, IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA,
                                                                         VS_strExpRetiraEntregaDocFat,VS_strExpRetiraEntrega),
                                                                         blnApenasImprimirBaixarSeparacao, FSeqSeparacaoParcial);
              End;
            End;

            Self.strTipImpSeparacao := objImpSep.strTipImp;
          End
          //Caso nao utilize impressao de separacao apenas reimprime o documento
          Else
          Begin
            objImpSep.pReimprimeDocumento(False, False, False);
            Self.blnImprimiuSeparacao := True;
          End;
        End;
      End
      //Caso utilize rotina WMS(JD Tintas) entao define os lotes e imprime a separacao
      Else
        Self.blnImprimiuSeparacao := fDigitaLotesPedidoWMS(Self.strSeparador);

      //Imprime a ordem de producao de tinta de maquina
      If Self.blnImprimiuSeparacao And fUtilizaImpressaoSeparacao Then
      Begin
        If (fCfgSis('IMPOPM', varBoolean)) And (fVerificaAcessoSistema('IMPORD')) Then
        Begin
          If Pos(fField('ESPDOC').AsString, 'OR_PD_') > 0 Then
            strMsgOpr := 'Imprimir ordem de produção preliminar?'
          Else
            strMsgOpr := 'Imprimir ordem de produção?';

          oprOdemProducao := TFatOrdProTintaMaquina.Create;
          oprOdemProducao.pSetaDocumento(fField('NUMDOC').AsString,
                                         fField('ESPDOC').AsString,
                                         fField('CODEMP').AsString,
                                         fField('CODCLI').AsString,
                                         VS_strCodEmp,
                                         '',  //codaca
                                         ''); //empaca
          Try
            If (oprOdemProducao.blnTemFormula) Then
            Begin
              If (fMensagem('ATENÇÃO!', strMsgOpr, ['&Sim', '&Não']) = 1) Then
              Begin
                If Not Assigned(objImpSep) Then
                  oprOdemProducao.pImprimeOrdProdTmp
                Else
                  oprOdemProducao.pImprimeOrdProdTmp(objImpSep.strTipImp = 'V');
              End;
            End;
          Finally
            FreeAndNil(oprOdemProducao);
          End;
        End;
      End;

      //Destroi o objeto utilizado na impessao
      If Assigned(objImpSep) Then
        FreeAndNil(objImpSep);

      //Imprime as ordens de producao de produtos estrutura
      If fImprimeOrdemProducaoItemEstrutura Or ((VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And (blnApenasImprimirBaixarSeparacao) And (Not fIgnoraImpOrdemProdItemEstrutura)) Then
      Begin
        pImpOrdemProdItemEstrutura;
      End;

      If Self.blnImprimiuSeparacao Then
      Begin

        cdsPedidos.Edit;

        //altera o sequencial de impressão.
        If (fUsaRotinaWMS And fConferenciaDepoisDaEntrada) Or (fOndaSeparacao And (Not fUsaOndaSeparacaoExpedicaoWMS)) Then
        Begin

          pAtualizaSeqSep;

          If (cdsPedidos.FieldByName('SEQSEP').AsString = '') Then
            cdsPedidos.FieldByName('SEQSEP').AsString := strSeqSep;

        End;

        //Marca o documento como impresso
        fField('SEPIMP').AsString   := fSepImpAtualizado;
        fField('DTIMSE').AsDateTime := fDataImpressao;
        fField('HRIMSE').AsDateTime := fHoraImpressao;

        cdsPedidos.Post;

        pLimpaEstornoSeparacao(fField('AUTINC').AsString);
        pGravarViaConferenciaSeperacao(fField('AUTINC').AsString);
      End;

    End;
  Finally
    If (Not Self.blnImprimiuSeparacao) And (fUtilizaSolicitacaoSeparador) And (Not fOndaSeparacao) Then
    Begin
      pAtualizaSeparadorPedido(strSeparadorAnt);
    End;
  End;
end;

procedure TfrmFatExpedicao.pLimpaEstornoSeparacao(strAutInc: String);
 var
   qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE   ');
      SQL.Add('  EXTGOR ');
      SQL.Add('SET      ');
      SQL.Add('  FGO_EXTSEP = "N" ');
      SQL.Add('WHERE ');
      SQL.Add('  FGO_SEQFGO = ' + QuotedStr(strAutInc));
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmFatExpedicao.pInicializarFiltroLocSep(blnEstaNaRotinaBaixaSeparacao: Boolean);
  Var
    qryTemp: TUniQuery;
    intAux: Integer;
begin
  grbLocSep.Visible := False;
  
  blnUsaImpressaoSeparacaoPorLocal := ((fCfgSis('BXLCSP', varBoolean)) And (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]))) or (fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica);
  
  If blnUsaImpressaoSeparacaoPorLocal And blnEstaNaRotinaBaixaSeparacao Then
  Begin
    grbLocSep.Visible := True;
    grbLocSep.Caption := 'Local de Separação:';
    qryTemp := fCriaQuery(Nil);
    Try
      Try
        cmbLocSep.Clear();

        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := 'SELECT LSE_CODIGO, LSE_DESCRI FROM CADLSE '+
        iif(fEmptyStr(VS_strTipExpLocal), '', ' WHERE LSE_CODIGO = "'+VS_strTipExpLocal+'" ')+
        ' ORDER BY LSE_DESCRI';
        qryTemp.Open();

        qryTemp.First();

        SetLength(arrLocSep, qryTemp.RecordCount);

        intAux := 1;
        If fEmptyStr(VS_strTipExpLocal) Then
        Begin
          cmbLocSep.Items.Add('Todos');
          intAux := 2;
        End;

        While (Not qryTemp.Eof) Do
        Begin
          cmbLocSep.Items.Add(qryTemp.FieldByName('LSE_DESCRI').AsString);

          arrLocSep[cmbLocSep.Items.Count - intAux].strCodigo := qryTemp.FieldByName('LSE_CODIGO').AsString;
          arrLocSep[cmbLocSep.Items.Count - intAux].strDescri := qryTemp.FieldByName('LSE_DESCRI').AsString;

          qryTemp.Next();
        End;

        If cmbLocSep.Items.Count > 0 Then
          cmbLocSep.ItemIndex := 0;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmFatExpedicao.pInicializarFiltroLocSep]');
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  End;
end;

procedure TfrmFatExpedicao.pInicializarFiltroArmazem(blnEstaNaRotinaBaixaSeparacao: Boolean);
  Var
    qryTemp: TUniQuery;
begin
  grbLocSep.Visible := False;
  
  blnUsaImpressaoSeparacaoPorLocal := (fCfgSis('CTLEST', varInteger) = 2) And (fCfgSis('BXAZSP', varBoolean)) And (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]));
  
  If blnUsaImpressaoSeparacaoPorLocal And blnEstaNaRotinaBaixaSeparacao Then
  Begin
    grbLocSep.Visible := True;
    grbLocSep.Caption := 'Armazém:';
    qryTemp := fCriaQuery(Nil);
    Try
      Try
        cmbLocSep.Clear();

        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := 'SELECT AMZ_CODAMZ, AMZ_DESCRI FROM CADAMZ WHERE AMZ_CODEMP = :CODEMP ORDER BY AMZ_DESCRI';
        qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryTemp.Open();

        qryTemp.First();

        SetLength(arrLocSep, qryTemp.RecordCount);

        cmbLocSep.Items.Add('Todos');

        While (Not qryTemp.Eof) Do 
        Begin
          cmbLocSep.Items.Add(qryTemp.FieldByName('AMZ_DESCRI').AsString);

          arrLocSep[cmbLocSep.Items.Count - 2].strCodigo := qryTemp.FieldByName('AMZ_CODAMZ').AsString;
          arrLocSep[cmbLocSep.Items.Count - 2].strDescri := qryTemp.FieldByName('AMZ_DESCRI').AsString;

          qryTemp.Next();
        End;

        cmbLocSep.ItemIndex := 0;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmFatExpedicao.pInicializarFiltroArmazem]');
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  End;
end;

procedure TfrmFatExpedicao.pInicializarFiltroLocSepArmazem(blnEstaNaRotinaBaixaSeparacao: Boolean);
begin
  If blnApenasConferenciaProdutosRetiraCaixa Then
  Begin
    tfFiltroLocSepArmz := tfNenhum;
  End
  Else If (fCfgSis('BXLCSP', varBoolean)) And (Not fCfgSis('BXAZSP', varBoolean)) Then
  Begin
    pInicializarFiltroLocSep(blnEstaNaRotinaBaixaSeparacao);
    tfFiltroLocSepArmz := tfLocSep;
  End 
  Else If (Not fCfgSis('BXLCSP', varBoolean)) And (fCfgSis('BXAZSP', varBoolean)) Then 
  Begin
    pInicializarFiltroArmazem(blnEstaNaRotinaBaixaSeparacao);
    tfFiltroLocSepArmz := tfArmazem;
  End 
  Else
    tfFiltroLocSepArmz := tfNenhum;
end;

procedure TfrmFatExpedicao.pInicializarFiltroStatusPedido;
var
  strKey: String;
  item: TcxCheckListBoxItem;
begin
  pnlStatusPedido.Visible := fCfgSis('EXISTA', varBoolean);

  If Not pnlStatusPedido.Visible Then
  Begin
    lstStatusPedido.Visible := False;
    Exit;
  End;

  lstStatusPedido.Items.Clear();
  lstStatusPedido.Images := frmModuloLegenda.imglLegenda;
  For strKey In TSituacaoPedidoVenda.fRetornaLegenda.Keys Do
  begin
    item := lstStatusPedido.Items.Add;
    item.ImageIndex := TSituacaoPedidoVenda.fRetornaLegenda.Items[strKey];
    item.Text := strKey;
  End;
end;

procedure TfrmFatExpedicao.pInicializarNotificacoes;
  Var
    intTMPRTE: Integer;
    intTMPIAN: Integer;
begin
  blnSOMNSP := fCfgSis('SOMNSP', varBoolean);
  intTMPRTE := fCfgSis('TMPRTE', varInteger); //TEMPO PARA RECARREGAR TELA
  intTMPIAN := fCfgSis('TMPIAN', varInteger); //TEMPO PARA BIPE POR INATIVIDADE
  intTMPDNS := fCfgSis('TMPDNS', varInteger); //DURAÇÃO DO BIPE DE INATIVIDADE

  If (blnSOMNSP) Then
  Begin
    tmrTmpRte.Interval := intTMPRTE * 1000;
    tmrTmpIan.Interval := intTMPIAN * 1000;
    tmrTmpRte.Enabled  := True;
    tmrTmpIan.Enabled  := True;
  End
  Else
  Begin
    thrNotificacao := Nil;
  End;
end;

function TfrmFatExpedicao.fPedeSenhaOperador(strInfo: String): String;
  Var
    strSenha: String;
begin
  If ffrmSenha(strSenha, strInfo) Then
    Result := fRetCodVendedor(strSenha);
end;

procedure TfrmFatExpedicao.pLimparIndices;
begin
  cdsPedidos.IndexDefs.Clear;
  cdsPedidos.IndexFieldNames := '';
  cdsPedidos.IndexName := '';

  cdsPedidos.Filtered := False;
  cdsPedidos.Filter := '';
  cdsPedidos.First;
end;

procedure TfrmFatExpedicao.pAtualizarRegistrosCanceladosPeloHUB;
var
  intRegistro  : Integer;
  strStatusHub : String;

  function fRetornaStatusQuebraDePacote(const strNumPok: String): String;
  var
    qryConsulta: TUniQuery;
  begin
    qryConsulta := fCriaQuery;
    Try
      Result := EmptyStr;

      qryConsulta.Close;
      qryConsulta.SQL.Text := 'SELECT AUTOINCREM FROM FATGOR F '
                            + ' WHERE IFNULL(F.FGO_MOTBAI,"") = "" '
                            + '   AND F.FGO_ESPDOC = "PD" '
                            + '   AND F.FGO_NUMPOK = :NUMPOK '
                            + '   AND (SELECT COUNT(*) FROM FATGOR G '
                            + '         WHERE F.FGO_NUMPOK = G.FGO_NUMPOK '
                            + '           AND IFNULL(G.FGO_MOTBAI,"") = "" '
                            + '           AND G.FGO_NUMDOC <> F.FGO_NUMDOC '
                            + '           AND G.FGO_ESPDOC = "PD" '
                            + '           AND G.FGO_CODEMP = F.FGO_CODEMP) > 1 ';
      qryConsulta.ParamByName('NUMPOK').AsString := strNumPok;
      qryConsulta.Open;

      If Not qryConsulta.IsEmpty Then
        Result := 'QuebraDePacote';
    Finally
      FreeAndNil(qryConsulta);
    End;
  end;

  procedure pAtualizaInfoHub_EXTGOR(const strAutInc, strStaHub, strCanHub: String);
  var
    qryGravar : TUniQuery;
  begin
    qryGravar := fCriaQuery;
    Try
      qryGravar.Close;
      qryGravar.SQL.Text := 'UPDATE EXTGOR '
                          + '   SET FGO_CANHUB = :CANHUB '
                          + '     , FGO_STAHUB = :STAHUB '
                          + ' WHERE FGO_SEQFGO = :AUTINC ';
      qryGravar.ParamByName('AUTINC').AsString := strAutInc;
      qryGravar.ParamByName('STAHUB').AsString := strStaHub;
      qryGravar.ParamByName('CANHUB').AsString := strCanHub;
      qryGravar.ExecSQL;
    Finally
      FreeAndNil(qryGravar);
    End;
  end;

begin
  If (Not blnOndaSeparacaoApenasPedidoFaturadorAutomatico) Then
    Exit;

  intRegistro := cdsPedidos.Recno;
  cdsPedidos.DisableControls;
  Try
    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      strStatusHub := EmptyStr;
      If (cdsPedidos.FieldByName('ESPDOC').AsString = 'PD') And
         (cdsPedidos.FieldByName('CANHUB').AsString = 'N') And
         (cdsPedidos.FieldByName('STAHUB').AsString = EmptyStr) Then
      Begin
        strStatusHub := fRetornaStatusPedidoNoHub(cdsPedidos.FieldByName('NUMPOK').AsString);

        If fEmptyStr(strStatusHub) Then
          strStatusHub := fRetornaStatusQuebraDePacote(cdsPedidos.FieldByName('NUMPOK').AsString);
      End;

      If (Not fEmptyStr(strStatusHub)) Then
      Begin
        strStatusHub := fStatusPedidoNoHub(strStatusHub);
        If (Not fEmptyStr(strStatusHub)) Then
        Begin
          cdsPedidos.Edit;
          cdsPedidos.FieldByName('STAHUB').AsString := strStatusHub;
          cdsPedidos.FieldByName('CANHUB').AsString := 'N';

          If strStatusHub = 'C' Then
            cdsPedidos.FieldByName('CANHUB').AsString := 'S';

          cdsPedidos.Post;

          pAtualizaInfoHub_EXTGOR(cdsPedidos.FieldByName('AUTINC').AsString,
                                  cdsPedidos.FieldByName('STAHUB').AsString,
                                  cdsPedidos.FieldByName('CANHUB').AsString);

        End;
      End;

      cdsPedidos.Next;
    End;
  Finally
    cdsPedidos.Recno := intRegistro;
    cdsPedidos.EnableControls;
  End;
end;

procedure TfrmFatExpedicao.pAtualizarGrid;

  Const
    // Sleep aplicado no caller quando o detector esta em modo de mitigacao.
    // Serializa a fila de WM_KEYDOWN da auto-repeat e reduz cadencia efetiva,
    // bloqueando o message pump durante o Sleep (efeito esperado).
    // No caminho F7 -> fExecutarModal -> pAtualizarGrid, o frmGravando
    // "Aguarde..." esta visivel envelopando o Sleep, dando afordancia visual
    // de "processando". Em call sites DIRETOS (sem fExecutarModal envelope),
    // a UI fica simplesmente travada por este intervalo -- consequencia aceita
    // do design de latch unificado (uma vez em mitigacao, qualquer caller
    // que toque pAtualizarGrid eh penalizado ate o gap real).
    cstAtualizarGridThrottleMs = 1500;

  Var
    strTmpPedidosPendentes : String;

  procedure pFormataCampos;
  Begin
    If (fField('CONPAG') <> Nil) Then
    Begin
      lblCONPAG.DataField := 'CONPAG';
      fField('CONPAG').EditMask := MASK_CONPAG;
    End;
  End;

begin
  If Assigned(FAtualizarGridDetector) And (Not FAtualizarGridDetector.fRegisterCall) Then
    Sleep(cstAtualizarGridThrottleMs);

  blnAtualizandoGrid := True;
  Try
    If InterlockedIncrement(intSemaforoAtualizar) = 0 Then
    Begin
      Try
        Try
          blnScrollPedidos := False;
          HintControler.HideHint;

          If Assigned(cdsPedidos) Then
          Begin
            cdsPedidos.DisableControls;
            cdsPedidos.AfterScroll  := Nil;
            dtsPedidos.OnDataChange := Nil;
          End;

          pGeraTransferencias;
          pGeraRequisicoesCompra;

          strTmpPedidosPendentes := fRetornaTemporariaPedidosPendentes;

          If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
            pCarregaDocumentos(strTmpPedidosPendentes)
          Else
            pCarregaPedidos(strTmpPedidosPendentes);

          TCfgColExp.pCarregarDadosSalvos(dbgPedidos);
          pFiltrarPedidos();
          pCalculaResumoTotalDocumentos();
          pAlteraNomeColumaSEQSEP;
        Finally
          If Assigned(cdsPedidos) Then
          Begin
            blnScrollPedidos := True;

            If cdsPedidos.ControlsDisabled Then
            Begin
              cdsPedidos.AfterScroll  := cdsPedidosAfterScroll;
              dtsPedidos.OnDataChange := pDataChange;
              cdsPedidos.EnableControls;
            End;

            cdsPedidosAfterScroll(cdsPedidos);
            pDataChange(Nil, Nil);

            pFormataCampos;
          End;
        End;

        pSetFocus(dbgPedidos);

        InterlockedDecrement(intSemaforoAtualizar);
      Except
        InterlockedDecrement(intSemaforoAtualizar);
        Raise;
      End;
    End
    Else
     InterlockedDecrement(intSemaforoAtualizar);
  Finally
    blnAtualizandoGrid := False;
  End;
end;

procedure TfrmFatExpedicao.pAtualizaCADVAL;
var
  qryAtualiza: TUniQuery;
  strCaminho: String;
begin
  strCaminho := fCfgSis('CAMEDI', varString);

  if fEmptyStr(strCaminho) then
    Exit;

  strCaminho := AnsiReplaceStr(strCaminho,'\','\\');

  qryAtualiza := fCriaQuery;

  try
    qryAtualiza.Close;
    qryAtualiza.SQL.Clear;
    qryAtualiza.SQL.Add('REPLACE INTO CADVAL (VAL_CODOPE, VAL_ULTVAL, VAL_MULSEL, VAL_NOMPAR, VAL_SEQGER)');
    qryAtualiza.SQL.Add('VALUES ('+QuotedStr(strLoginUsuarioLogado)+', '+QuotedStr(strCaminho)+', "N", "PASTA_REL", (SELECT AUTOINCREM FROM CADREL WHERE REL_CHAVE_ = "24031"))');
    qryAtualiza.ExecSQL;
  finally
    FreeAndNil(qryAtualiza);
  end;
end;

procedure TfrmFatExpedicao.pAtualizaDadosDocumentos(blnCalculaTempoExpedicao: Boolean=False);
  Var
    qryPedAbaDep: TUniQuery;
    qryInfDocFat: TUniQuery;
    qryValConRot: TUniQuery;
    blnPreencheValorRota: Boolean;
begin
  strBarDocLocalizar := '';
  stlBarDocLocalizar.Clear;

  blnPreencheValorRota := fRotasPorRegiaoExpedicaoPedido4 And
                          Assigned(cdsPedidos.FindField('VRROTA')) And
                          Assigned(cdsPedidos.FindField('CODROT'));

  pLimparIndices;
  Try
    qryPedAbaDep := fRetPedidosAbaDep;
    qryInfDocFat := fRetDetalheDocFat;

    If blnExisteAlgumFeriadoCadastrado Then
      pFeriadosPorCodCid(qryFerCid, FLisCodCid);

    If blnPreencheValorRota Then
      TRotReg.pValorContabilPorCodRot(qryValConRot, FLisCodRot);
    Try
      While Not cdsPedidos.Eof Do
      begin
        //1
        stlBarDocLocalizar.Add(cdsPedidos.FieldByName('BARDOC').AsString);

        //2
        If blnCalculaTempoExpedicao Then
        Begin
          cdsPedidos.Edit;

          If (fExpedicaoAtrasada()) Then
            cdsPedidos.FieldByName('EXPTOL').AsString := 'SIM'
          Else
            cdsPedidos.FieldByName('EXPTOL').AsString := 'NÃO';

          cdsPedidos.FieldByName('TMPEXP').AsString := fSegToTimeStr(fField('TMPEXP').AsFloat);
          cdsPedidos.FieldByName('TMPEXP').AsString := Copy(cdsPedidos.FieldByName('TMPEXP').AsString, 1, Length(cdsPedidos.FieldByName('TMPEXP').AsString) - 3);

          cdsPedidos.Post;
        End;

        If cdsPedidos.FieldByName('TABELA').AsString = 'MOVGER' Then
        Begin
          //3
          If (Not qryInfDocFat.IsEmpty) Then
          Begin
            If qryInfDocFat.Locate('AUTINC', cdsPedidos.FieldByName('AUTINC').AsString, []) Then
            Begin
              cdsPedidos.Edit;
              cdsPedidos.FieldByName('TURENT').AsString := qryInfDocFat.FieldByName('TURENT').AsString;
              cdsPedidos.FieldByName('SEPIMP').AsString := qryInfDocFat.FieldByName('SEPIMP').AsString;
              cdsPedidos.FieldByName('QTDPRO').AsString := qryInfDocFat.FieldByName('QTDPRO').AsString;
              cdsPedidos.Post;
            End;
          End;
        End;

        If cdsPedidos.FieldByName('TABELA').AsString = 'FATGOR' Then
        Begin
          //4
          If (Not qryPedAbaDep.IsEmpty) Then
          Begin
            If qryPedAbaDep.Locate('INCGOR', cdsPedidos.FieldByName('AUTINC').AsString, []) Then
            Begin
              cdsPedidos.Edit;
              cdsPedidos.FieldByName('SOLABA').AsString := qryPedAbaDep.FieldByName('FGO_CODEMP').AsString;
              cdsPedidos.Post;
            End;
          End;

          //5
          If cdsPedidos.FieldByName('UTIRES').AsString = 'S' Then
          Begin
            cdsPedidos.Edit;
            cdsPedidos.FieldByName('EPFTGE').AsString := fCfgSis(IIF(cdsPedidos.FieldByName('REGESP').AsString = 'S', 'EMPRES', 'EMPREN'), varString);
            cdsPedidos.Post;
          End;

          //6
          If (fCfgSis('CLIDMP') = '2') Then
          Begin
            If (cdsPedidos.FieldByName('CORTE_').AsString = 'S') And
               (cdsPedidos.FieldByName('CODCLI').AsString = fRetornaClienteFilial(cdsPedidos.FieldByName('CODEMP').AsString)) Then
            Begin
              cdsPedidos.Edit;
              cdsPedidos.FieldByName('CRTFIL').AsString := 'S';
              cdsPedidos.Post;
            End;
          End;
        End;

        //7
        If lblLocArm.Visible Then
        Begin
          cdsPedidos.Edit;
          cdsPedidos.FieldByName('LCLAMZ').AsString := cdsPedidos.FieldByName('DESLAR').AsString;
          cdsPedidos.Post;
        End;

        //8
        If blnExisteAlgumFeriadoCadastrado Then
        Begin
          If qryFerCid.Locate('CODCID', cdsPedidos.FieldByName('CODCLI').AsString, []) Then
          Begin
            cdsPedidos.Edit;
            cdsPedidos.FieldByName('ENDDOC').AsString := cdsPedidos.FieldByName('CODCID').AsString + '-' +
                                                         cdsPedidos.FieldByName('NOMCID').AsString + '/' +
                                                         cdsPedidos.FieldByName('ESTADO').AsString;
            cdsPedidos.Post;
          End;
        End;

        //9
        If blnPreencheValorRota Then
        Begin
          If qryValConRot.Locate('CODROT', cdsPedidos.FieldByName('CODROT').AsString, []) Then
          Begin
            cdsPedidos.Edit;
            cdsPedidos.FieldByName('VRROTA').AsFloat := qryValConRot.FieldByName('VLRCON').AsFloat;
            cdsPedidos.Post;
          End;
        End;

        cdsPedidos.Next;
      End;
    Finally
      FreeAndNil(qryPedAbaDep);
      FreeAndNil(qryInfDocFat);

      If Assigned(qryValConRot) Then
        FreeAndNil(qryValConRot);
    End;
  Finally
    pLimparIndices;
  End;
end;

procedure TfrmFatExpedicao.pCarregaListaCodigos;
begin
  FLisCodCid := '';
  FLisCodRot := '';
  FLisAutIncFgo := '';
  FLisAutIncGer := '';;

  pLimparIndices;
  While Not cdsPedidos.Eof Do
  Begin
    If (cdsPedidos.FieldByName('TABELA').AsString = 'FATGOR') Then
      pIncrementaListaStr(cdsPedidos.FieldByName('AUTINC').AsString, FLisAutIncFgo, True, True, ',', False, False)
    Else
      pIncrementaListaStr(cdsPedidos.FieldByName('AUTINC').AsString, FLisAutIncGer, True, True, ',', False, False);

    pIncrementaListaStr(cdsPedidos.FieldByName('CODROT').AsString, FLisCodRot, True, True, ',', False, True);
    pIncrementaListaStr(cdsPedidos.FieldByName('CODCID').AsString, FLisCodCid, True, True, ',', False, True);

    cdsPedidos.Next;
  End;
end;

procedure TfrmFatExpedicao.pAtualizaNumeroRomaneio;
  Var
    qryGen : TUniQuery;
begin
  If (FLisAutIncFgo = '') And (FLisAutIncGer = '') Then
    Exit;

  qryGen := fCriaQuery(Nil);
  qryGen.Close;
  qryGen.SQL.Clear;

  If (FLisAutIncFgo <> '') Then
  Begin
    qryGen.SQL.Add(' SELECT DISTINCT ');
    qryGen.SQL.Add('        ROMGERX.GER_AUTINC AS AUTINC, ');
    qryGen.SQL.Add('        ROMGERX.GER_NOMTAB AS TABELA, ');
    qryGen.SQL.Add('        ROMGERX.GER_NUMROM AS NUMROM, ');
    qryGen.SQL.Add('        ROMGERX.GER_EMPROM AS EMPROM  ');
    qryGen.SQL.Add('   FROM ROMGERX ');
    qryGen.SQL.Add('   WHERE ROMGERX.GER_AUTINC IN ('+FLisAutIncFgo+') ');
    qryGen.SQL.Add('     AND ROMGERX.GER_NOMTAB = "FATGOR"  ');

    If (FLisAutIncGer <> '') Then
      qryGen.SQL.Add(' UNION ALL ');
  End;

  If (FLisAutIncGer <> '') Then
  Begin
    qryGen.SQL.Add(' SELECT DISTINCT ');
    qryGen.SQL.Add('        ROMGERX.GER_AUTINC AS AUTINC, ');
    qryGen.SQL.Add('        ROMGERX.GER_NOMTAB AS TABELA, ');
    qryGen.SQL.Add('        ROMGERX.GER_NUMROM AS NUMROM, ');
    qryGen.SQL.Add('        ROMGERX.GER_EMPROM AS EMPROM  ');
    qryGen.SQL.Add('   FROM ROMGERX ');
    qryGen.SQL.Add('   WHERE ROMGERX.GER_AUTINC IN ('+FLisAutIncGer+') ');
    qryGen.SQL.Add('     AND ROMGERX.GER_NOMTAB = "MOVGER"  ');
  End;
  qryGen.Open;
  qryGen.First;

  pLimparIndices;
  Try
    If (Not qryGen.IsEmpty) Then
    Begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter := '(TABELA = ' + QuotedStr('FATGOR')+') OR (TABELA = ' + QuotedStr('MOVGER')+')';
      cdsPedidos.Filtered := True;

      cdsPedidos.IndexFieldNames := 'AUTINC;TABELA';
    End;

    While Not qryGen.Eof Do
    Begin
      If cdsPedidos.FindKey([qryGen.FieldByName('AUTINC').AsString, qryGen.FieldByName('TABELA').AsString]) Then
      Begin
        cdsPedidos.Edit;
        cdsPedidos.FieldByName('NUMROM').AsString := qryGen.FieldByName('NUMROM').AsString;
        cdsPedidos.FieldByName('EMPROM').AsString := qryGen.FieldByName('EMPROM').AsString;
        cdsPedidos.Post;
      End;
      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatExpedicao.pAtualizaLocaisSeparacao;
  Var
   qryGen: TUniQuery;

  procedure pRetornaLocaisSeparacao(const strLisAutInc, strEspDoc: String);
  begin
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT AUTINC, ');
      SQL.Add('       GROUP_CONCAT(DISTINCT CODLSE) AS CODLSE, ');
      SQL.Add('       GROUP_CONCAT(DISTINCT LSEPEN) AS LSEPEN, ');
      SQL.Add('       GROUP_CONCAT(DISTINCT LSEPAR) AS LSEPAR, ');
      SQL.Add('       GROUP_CONCAT(DISTINCT LSELIB) AS LSELIB  ');
      SQL.Add('FROM ');
      SQL.Add('    (SELECT ');
      SQL.Add('          FD.FDO_SEQGER AS AUTINC, ');
      if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      begin
        SQL.Add('        IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE) AS CODLSE, ');
        SQL.Add('        IF(((SUM(IFNULL(FD.FDO_QTDITE,0)) - SUM(IFNULL(ED.FDO_QTDSEP,0)))<>0),IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE), NULL) AS LSEPEN, ');
        SQL.Add('        IF((SUM(IFNULL(ED.FDO_QTDSEP,0))>0) AND (SUM(IFNULL(ED.FDO_QTDSEP,0)) < SUM(IFNULL(FD.FDO_QTDITE,0))),IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE), NULL) AS LSEPAR,');
        SQL.Add('        IF((SUM(IFNULL(ED.FDO_QTDSEP,0))>0) AND (SUM(IFNULL(ED.FDO_QTDSEP,0)) = SUM(IFNULL(FD.FDO_QTDITE,0))),IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE), NULL) AS LSELIB ');
      end
      else
      begin
        SQL.Add('        IG.ITE_CODLSE AS CODLSE, ');
        SQL.Add('        IF(((SUM(IFNULL(FD.FDO_QTDITE,0)) - SUM(IFNULL(ED.FDO_QTDSEP,0)))<>0),IG.ITE_CODLSE, NULL) AS LSEPEN, ');
        SQL.Add('        IF((SUM(IFNULL(ED.FDO_QTDSEP,0))>0) AND (SUM(IFNULL(ED.FDO_QTDSEP,0)) < SUM(IFNULL(FD.FDO_QTDITE,0))),IG.ITE_CODLSE, NULL) AS LSEPAR,');
        SQL.Add('        IF((SUM(IFNULL(ED.FDO_QTDSEP,0))>0) AND (SUM(IFNULL(ED.FDO_QTDSEP,0)) = SUM(IFNULL(FD.FDO_QTDITE,0))),IG.ITE_CODLSE, NULL) AS LSELIB ');
      end;
      SQL.Add('      FROM');
      SQL.Add('      FATDOR FD ');
      SQL.Add('        INNER JOIN EXTDOR ED ON ED.FDO_SEQFDO = FD.AUTOINCREM ');

      If (strEspDoc <> 'PD') Then
      Begin
        SQL.Add('       LEFT JOIN ITEGER IG ON IG.ITE_CODITE = FD.FDO_CODITE AND IG.ITE_CODEMP = FD.FDO_CODEMP ');
      End
      Else
      Begin
        SQL.Add('       LEFT JOIN EXTGOR EG ON EG.FGO_SEQFGO = FD.FDO_SEQGER ');
        SQL.Add('      INNER JOIN ITEGER IG ON IG.ITE_CODITE = FD.FDO_CODITE ');
        SQL.Add('                          AND IG.ITE_CODEMP = IF(TRIM(IFNULL(EG.FGO_EMPEXP, "")) <> "", EG.FGO_EMPEXP, FD.FDO_CODEMP) ');
      End;

      if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
      begin
        SQL.Add('         LEFT JOIN CADLOT LT ON LT.LOT_CODITE = FD.FDO_CODITE AND LT.LOT_CODEMP = FD.FDO_CODEMP AND LT.LOT_NUMLOT = FD.FDO_NUMLOT');
        SQL.Add('         LEFT JOIN CADLOC CL1 ON CL1.LOC_CODLOC = LT.LOT_LOCFIS AND CL1.LOC_CODEMP = LT.LOT_CODEMP ');
        SQL.Add('         LEFT JOIN CADLOC CL2 ON CL2.LOC_CODLOC = IG.ITE_LOCFIS AND CL2.LOC_CODEMP = IG.ITE_CODEMP ');
      end;

      SQL.Add('      WHERE FD.FDO_SEQGER IN ('+strLisAutInc+')');

      If (strEspDoc = 'PD') And fCfgSis('BAISEP', varBoolean) And blnApenasImprimirBaixarSeparacao And fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
      Begin
        SQL.Add('   AND ED.FDO_EXIBSE = "S" ');
        //Req 151661, se ja pegou entao ja definiu o lote no pedido nao precisa separar
        SQL.Add('  AND ( ');
        SQL.Add('    IFNULL(ED.FDO_PEGOU_, "N") <> "S" ');
        SQL.Add('    OR IFNULL(FD.FDO_NUMLOT, "A DEFINIR") = "A DEFINIR" ');
        SQL.Add('  ) ');
      End;

      If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
        If fCfgSis('EMPFAT', VarBoolean) And (strEspDoc = 'PD') Then
          SQL.Add('  AND FD.FDO_EMPITE = "' + VS_strCodEmp + '" ');

      if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
        SQL.Add('      GROUP BY FD.FDO_SEQGER, IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE)) AS VW ')
      else
        SQL.Add('      GROUP BY FD.FDO_SEQGER, IG.ITE_CODLSE) AS VW ');

      SQL.Add(' GROUP BY AUTINC ');

      If tfFiltroLocSepArmz = tfArmazem Then
        if fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica then
          SQL.Text := AnsiReplaceStr(SQL.Text, 'IF(IFNULL(FD.FDO_NUMLOT, "") = "", CL2.LOC_CODLSE, CL1.LOC_CODLSE)', 'FD.FDO_NUMLOT')
        else
          SQL.Text := AnsiReplaceStr(SQL.Text, 'IG.ITE_CODLSE', 'FD.FDO_NUMLOT');

      If (strEspDoc <> 'PD') Then
      Begin
        SQL.Text := AnsiReplaceStr(SQL.Text, 'FATDOR', 'MOVDET');
        SQL.Text := AnsiReplaceStr(SQL.Text, 'EXTDOR', 'MOVTRI');
        SQL.Text := AnsiReplaceStr(SQL.Text, 'FDO_SEQFDO', 'DET_SEQGER');
        SQL.Text := AnsiReplaceStr(SQL.Text, 'FDO_', 'DET_');
      End;

      Open;
    End;
  end;

  procedure pPreencheLocaisSeparacao;
  begin
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      If cdsPedidos.FindKey([qryGen.FieldByName('AUTINC').AsString]) Then
      Begin
        cdsPedidos.Edit;

        cdsPedidos.FieldByName('CODLSE').AsString := qryGen.FieldByName('CODLSE').AsString;
        cdsPedidos.FieldByName('LSEPEN').AsString := qryGen.FieldByName('LSEPEN').AsString;
        cdsPedidos.FieldByName('LSEPAR').AsString := qryGen.FieldByName('LSEPAR').AsString;
        cdsPedidos.FieldByName('LSELIB').AsString := qryGen.FieldByName('LSELIB').AsString;

        cdsPedidos.Post;
      End;
      qryGen.Next;
    End;
  end;

begin
  If (FLisAutIncFgo = '') And (FLisAutIncGer = '') Then
    Exit;

  If (Not grbLocSep.Visible) Then
    Exit;

  qryGen := fCriaQuery;

  pLimparIndices;
  cdsPedidos.IndexFieldNames := 'AUTINC';
  Try
    If (FLisAutIncFgo <> '') Then
    Begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter := 'ESPDOC = ' + QuotedStr('PD');
      cdsPedidos.Filtered := True;

      pRetornaLocaisSeparacao(FLisAutIncFgo, cdsPedidos.FieldByName('ESPDOC').AsString);
      pPreencheLocaisSeparacao;
    End;

    If (FLisAutIncGer <> '') Then
    Begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter := 'ESPDOC <> ' + QuotedStr('PD');
      cdsPedidos.Filtered := True;

      pRetornaLocaisSeparacao(FLisAutIncGer, cdsPedidos.FieldByName('ESPDOC').AsString);
      pPreencheLocaisSeparacao;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatExpedicao.pAtualizaPedidosCampoKIT;
  Var
    qryGen : TUniQuery;
    intQtdIte,
    intQtdEst: Integer;
begin
  If (Not fCfgSis('EXPKIT', varBoolean)) Then
    Exit;

  If (FLisAutIncFgo = '') Then
    Exit;

  qryGen := fCriaQuery;

  qryGen.SQL.Text :=
    ' SELECT '+
    '   FATGOR.AUTOINCREM AS AUTINC, '+
    '   (SELECT COUNT(*) FROM FATDOR '+
    '     WHERE FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM) AS QTDITE, '+
    '   (SELECT COUNT(*) FROM FATDOR '+
    '               LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO '+
    '     WHERE FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '+
    '       AND ((FDO_ITEEST IS NOT NULL) OR (SELECT COUNT(*) FROM GERMAT WHERE GERMAT.GMT_CODITE = FATDOR.FDO_CODITE) > 0)) AS QTDEST '+
    ' FROM FATGOR '+
    ' WHERE FATGOR.AUTOINCREM IN ('+FLisAutIncFgo+')';
  qryGen.Open;
  qryGen.First;

  pLimparIndices;
  Try
    If (Not qryGen.IsEmpty) Then
    Begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter := 'TABELA = ' + QuotedStr('FATGOR');
      cdsPedidos.Filtered := True;

      cdsPedidos.IndexFieldNames := 'AUTINC';
    End;

    While Not qryGen.Eof Do
    Begin
      If cdsPedidos.FindKey([qryGen.FieldByName('AUTINC').AsString]) Then
      Begin
        cdsPedidos.Edit;

        intQtdIte := qryGen.FieldByName('QTDITE').AsInteger;
        intQtdEst := qryGen.FieldByName('QTDEST').AsInteger;

        cdsPedidos.FieldByName('KIT').AsString    := IIF((intQtdEst > 0) And (intQtdIte=intQtdEst), 'S', 'N');//POSSUI EXCLUSIVAMENTE KIT
        cdsPedidos.FieldByName('KITEST').AsString := IIF((intQtdEst > 0), 'SIM', ''); //POSSUI KIT

        cdsPedidos.Post;
      End;
      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatExpedicao.pAtualizaSituacaoFinanceiraPedidos;
  Var
    strPenFin: String;
begin
  pLimparIndices;

  While Not cdsPedidos.Eof Do
  Begin
    cdsPedidos.Edit;

    If fSituacaoFinanceiraPedidoOk(strPenFin) Then
      cdsPedidos.FieldByName('SITFIN').AsString := 'OK'
    Else
      cdsPedidos.FieldByName('SITFIN').AsString := '';

    cdsPedidos.Post;

    cdsPedidos.Next;
  End;
end;

function TfrmFatExpedicao.fRetPedidosAbaDep: TUniQuery;
begin
  Result := fCriaQuery;

  If (FLisAutIncFgo = '') Then
    Exit;

  //PEDIDO DE ABASTECIMENTO POR DEPÓSITO ENTREGA FUTURA
  Result.SQL.Add(' SELECT X.FDO_SEQGER AS INCGOR, G.FGO_CODEMP ');
  Result.SQL.Add('   FROM FATDOR X ');
  Result.SQL.Add('  INNER JOIN EXTDOR Y ON Y.FDO_SEQFDO = X.AUTOINCREM ');
  Result.SQL.Add('  INNER JOIN MOVDET D ON D.AUTOINCREM = Y.FDO_INCFUT ');
  Result.SQL.Add('  INNER JOIN MOVAUX A ON D.AUTOINCREM = A.DET_SEQGER ');
  Result.SQL.Add('  INNER JOIN FATDOR F ON F.AUTOINCREM = A.DET_INC_PD ');
  Result.SQL.Add('  INNER JOIN FATGOR G ON F.FDO_SEQGER = G.AUTOINCREM ');
  Result.SQL.Add('  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM ');
  Result.SQL.Add('  WHERE X.FDO_SEQGER IN ('+FLisAutIncFgo+') ');
  Result.SQL.Add('    AND E.FGO_ABADEP = "S" ');
  Result.SQL.Add(' GROUP BY X.FDO_SEQGER, G.FGO_CODEMP   ');
  Result.SQL.Add(' UNION ALL ');
  //PEDIDO DE ABASTECIMENTO POR DEPÓSITO ENTREGA IMEDIATA/RETIRA
  Result.SQL.Add(' SELECT G.AUTOINCREM AS INCGOR, G.FGO_CODEMP ');
  Result.SQL.Add('   FROM FATGOR G ');
  Result.SQL.Add('  INNER JOIN EXTGOR E ON E.FGO_SEQFGO = G.AUTOINCREM ');
  Result.SQL.Add('  WHERE G.AUTOINCREM IN ('+FLisAutIncFgo+') ');
  Result.SQL.Add('    AND E.FGO_ABADEP = "S" ');
  Result.SQL.Add(' GROUP BY G.AUTOINCREM, G.FGO_CODEMP ');
  Result.SQL.Add(' ORDER BY 1, 2 ');

  Result.Open;
end;

function TfrmFatExpedicao.fRetDetalheDocFat: TUniQuery;
begin
  Result := fCriaQuery;

  If (FLisAutIncGer = '') Then
    Exit;

  Result.SQL.Text :=
    'SELECT '+
    '  MOVDET.DET_SEQGER AS AUTINC, '+
    '  COUNT(0) AS QTDPRO, '+
    '  IF(    '+
    '    AUX_SEPIMP = "N"  '+
    '    AND COALESCE(  '+
    '      (SUM(COALESCE(MOVTRI.DET_QTDEXP, 0))), '+
    '      0  '+
    '    ) = 0,  '+
    '    "0",  '+
    '    IF(   '+
    '      AUX_SEPIMP = "S"  '+
    '      AND COALESCE(   '+
    '        (SUM(COALESCE(MOVTRI.DET_QTDEXP, 0))), '+
    '        0  '+
    '      ) = 0,  '+
    '      "1", '+
    '      IF(   '+
    '        AUX_SEPIMP = "N"   '+
    '        AND COALESCE(  '+
    '          (SUM(COALESCE(MOVTRI.DET_QTDEXP, 0))), '+
    '          0   '+
    '        ) < COALESCE(   '+
    '          (SUM(COALESCE(MOVDET.DET_QTDITE, 0))), '+
    '          0  '+
    '        ),  '+
    '        "2",  '+
    '        "3"   '+
    '      )  '+
    '    )  '+
    '  ) AS SEPIMP, '+
    '  CONCAT(  '+
    '    IF(   '+
    '      LOCATE( '+
    '        "MANHÃ",  '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '      ) > 0, '+
    '      "MANHÃ",  '+
    '      ""  '+
    '    ),   '+
    '    IF(  '+
    '      LOCATE(  '+
    '        "MANHÃ",  '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '      ) > 0   '+
    '      AND (  '+
    '        LOCATE(   '+
    '          "TARDE",  '+
    '          GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '        ) > 0  '+
    '        OR LOCATE(   '+
    '          "NOITE",  '+
    '          GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '        ) > 0  '+
    '      ),   '+
    '      " / ",  '+
    '      ""  '+
    '    ),  '+
    '    IF(   '+
    '      LOCATE(      '+
    '        "TARDE",   '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '       ) > 0, '+
    '      "TARDE", '+
    '      "" '+
    '    ),  '+
    '    "", '+
    '    IF(  '+
    '      LOCATE(  '+
    '        "TARDE", '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '      ) > 0 '+
    '      AND LOCATE(   '+
    '        "NOITE",  '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '      ) > 0,  '+
    '      " / ",  '+
    '      ""  '+
    '    ),   '+
    '    IF(  '+
    '      LOCATE(  '+
    '        "NOITE", '+
    '        GROUP_CONCAT(DISTINCT DET_TURENT) '+
    '      ) > 0, '+
    '      "NOITE", '+
    '      ""  '+
    '    )  '+
    '  ) AS TURENT '+
    'FROM MOVDET   '+
    '    LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM '+
    '    LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVDET.DET_SEQGER '+
    'WHERE MOVDET.DET_SEQGER IN ('+FLisAutIncGer+') '+
    'GROUP BY MOVDET.DET_SEQGER';
  Result.Open;
end;

procedure TfrmFatExpedicao.pAtualizaSeparadorPedido(strCodSep: String);
  Var
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    With fCriaQuery, SQL Do
    Begin
      Clear;

      Add('UPDATE');
      Add('  EXTGOR,');
      Add('  FATGOR ');
      Add('SET FGO_SEPEXP = :CODSEP');
      Add('WHERE FGO_SEQFGO = AUTOINCREM');
      Add('    AND AUTOINCREM = :AUTINC');

      If fEmptyStr(strCodSep) Then
        ParamByName('CODSEP').Value := Null
      Else
        ParamByName('CODSEP').AsString := strCodSep;

      ParamByName('AUTINC').AsString := fField('AUTINC').AsString;

      ExecSQL;

      Destroy;
    End;

    cdsPedidos.Edit;
    fField('CODSEP').AsString := strCodSep;
    fField('NOMSEP').AsString := strCodSep + '-' + fRetNomVendRep(strCodSep);
    cdsPedidos.Post;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatExpedicao.fVerificaItensPendentesSeparacao(strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    blnPossuiSaldoDisponivel: Boolean;
    strCodIteAtual: String;
begin
  Result := True;

  If Not fCfgSis('BLQSEP', VarBoolean) Then
    Exit;

  qryGen := fCriaQuery(nil);
  strCodIteAtual := '';
  blnPossuiSaldoDisponivel := False;
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add(sqlItensPendentesSeparacao);
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
    Begin
      objLiberacao.objMsgLibera.pAddTexto('Existe pedido de venda anterior com mesmo ítem cuja separação ainda está pendente.');
      objLiberacao.objMsgLibera.pAddTexto('Será necessário solicitar senha de liberação da gerência para prosseguir.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido', strNumDoc + '-' + strEspDoc + '-' + strCodEmp);

      objTabela := TRegistroMsgLiberaTabela.Create;


      While Not qryGen.Eof Do
      Begin
        If strCodIteAtual <> qryGen.FieldByName('FDO_CODITE').AsString Then
        Begin
          blnPossuiSaldoDisponivel := (fRetornaSaldoDisponivel(qryGen.FieldByName('FDO_CODITE').AsString,
                                                               False,
                                                               True,
                                                               '',
                                                               True,
                                                               qryGen.FieldByName('FDO_CODEMP').AsString) >= 0);
          strCodIteAtual := qryGen.FieldByName('FDO_CODITE').AsString;
        End;

        If Not blnPossuiSaldoDisponivel Then
        begin

          if objTabela.isEmpty Then
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'DT.EMISSAO' , 10 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'HORA'       , 8  , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'PEDIDO'     , 19 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'CLIENTE'    , 26 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'VEN'        , 3  , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'PRODUTO'    , 26 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'UN'         , 2  , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'QUANTIDADE' , 15 , alEsquerda , teAutcom);
            objTabela.lstLinhas.Add(objLinha);
          end;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('DT.EMISSAO' , qryGen.FieldByName('FDO_DTAENT').AsString                             , 10 , alEsquerda );
          objLinha.pAddColuna('HORA'       , qryGen.FieldByName('FDO_HORENT').AsString                             , 8  , alEsquerda );
          objLinha.pAddColuna('PEDIDO'     , qryGen.FieldByName('NUMPED').AsString                                 , 19 , alEsquerda );
          objLinha.pAddColuna('CLIENTE'    , qryGen.FieldByName('CLIENTE').AsString                                , 26 , alEsquerda );
          objLinha.pAddColuna('VEN'        , qryGen.FieldByName('FGO_CODVEN').AsString                             , 3  , alEsquerda );
          objLinha.pAddColuna('PRODUTO'    , qryGen.FieldByName('PRODUTO').AsString                                , 26 , alEsquerda );
          objLinha.pAddColuna('UN'         , qryGen.FieldByName('UNI_SIGUNI').AsString                             , 2  , alCentro   );
          objLinha.pAddColuna('QUANTIDADE' , FloatToStrF(qryGen.FieldByName('FDO_QTDITE').AsFloat, ffFixed, 15, 2) , 15 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        end;

        qryGen.Next;
      End;

      if objTabela.isEmpty Then
        FreeAndNil(objTabela)
      else
      begin
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'IBLSEP';
        objLiberacao.strMsgSen := 'Pedidos anteriores pendente de separação';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      end;

      objLiberacao.Clear;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatExpedicao.fVerificaOrdProdEstruturaEstaoBaixadas: Boolean;
  Var
    stlIte_OP: TStringList;
    objOrdPro: TOrdPro;
    intIndex : Integer;
begin
  Result := False;

  If (fField('ORDPRO').AsString <> 'EMITIDA') Then
    Exit;

  stlIte_OP := TStringList.Create;

  stlIte_OP.CommaText := fField('ITE_OP').AsString;

  objOrdPro := TOrdPro.Create(Nil, True);

  For intIndex := 0 To stlIte_OP.Count -1 Do
  Begin
    objOrdPro.fCarregaOrdPro(RightStr(stlIte_OP[intIndex], 12), True);
    Result := objOrdPro.strDtaBai <> '';
    If Not Result Then
      Break;
  End;

  FreeAndNil(objOrdPro);
  FreeAndNil(stlIte_OP);
end;

function TfrmFatExpedicao.fVisualizarGuiche: Boolean;
begin
  Result := (Not blnApenasImprimirBaixarSeparacao) And //TELA DE EXPEDIÇÃO
            (Not blnApenasConferenciaProdutosRetiraCaixa) And
            (
              (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or
              (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)
            ) And  //TIPO DE EXPEDIÇÃO
            (
              (fCfgSis('USGURE', varString) = 'S') Or
              (fCfgSis('USAGUI', varString) = 'S')  //UTILIZA ALGUM TIPO DE CONTROLE DE GUICHÊ
            );
end;

procedure TfrmFatExpedicao.gpbTipoExpedicaoClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If (blnExecutandoFormShow Or
      blnExecutandoFormCreate Or
      blnAtualizandoGrid) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  Try
    Screen.Cursor := crHourGlass;
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();
    dbgPedidos.SelectedRows.Clear;
  Finally
    Screen.Cursor := crDefault;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.grdPedidosVinculadosDBTableViewCitel1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strTexto: String;
  TextRect: TRect;
begin
  If TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).FieldName = 'ENTRET' Then
  Begin
    ACanvas.FillRect(AViewInfo.Bounds, ACanvas.Brush.Color);
    strTexto := AViewInfo.Text;

    TextRect := TcxCUstomTextEditViewInfo(AViewInfo.EditViewInfo).TextRect;

    strTexto := fGetDescricaoEntRet(strTexto);

    ACanvas.DrawTexT(strTexto, TextRect, TAlignment.taLeftJustify, TcxAlignmentVert.vaCenter, False, False);

    ADone := True;
  End;

end;

procedure TfrmFatExpedicao.lblExibirFiltroStatusPedidosClick(Sender: TObject);
begin
  inherited;
  If lblExibirFiltroStatusPedidos.Caption = STR_FILTRO_STATUS_PEDIDO_OCULTAR Then
  Begin
    lblExibirFiltroStatusPedidos.Caption := STR_FILTRO_STATUS_PEDIDO_EXIBIR;
    If grbStatusPedido.Visible Then
    Begin
      grbStatusPedido.Visible := False;
      pnlFiltros.Height       := pnlFiltros.Height - intStatusPedidoHeight;
      pnlStatusPedido.Height  := pnlStatusPedido.Height - intStatusPedidoHeight;
    End;
  End
  Else
  Begin
    lblExibirFiltroStatusPedidos.Caption := STR_FILTRO_STATUS_PEDIDO_OCULTAR;
    If Not grbStatusPedido.Visible Then
    Begin
      grbStatusPedido.Visible := True;
      pnlFiltros.Height       := pnlFiltros.Height + intStatusPedidoHeight;
      pnlStatusPedido.Height  := pnlStatusPedido.Height + intStatusPedidoHeight;
    End;
  End;
end;

procedure TfrmFatExpedicao.lblOcultarExibirPainelInformacoesClick(Sender: TObject);
const
  STR_PAINEL_INFORMACOES_EXIBIR = 'Clique aqui para exibir o Painel de Informações';
  STR_PAINEL_INFORMACOES_OCULTAR = 'Clique aqui para ocultar o Painel de Informações';
begin
  inherited;
  pgcExpedicao.Visible := (lblOcultarExibirPainelInformacoes.Caption = STR_PAINEL_INFORMACOES_EXIBIR);
  if pgcExpedicao.Visible then
    lblOcultarExibirPainelInformacoes.Caption := STR_PAINEL_INFORMACOES_OCULTAR
  else
    lblOcultarExibirPainelInformacoes.Caption := STR_PAINEL_INFORMACOES_EXIBIR;
end;

procedure TfrmFatExpedicao.lstLocRetClickCheck(Sender: TObject; AIndex: Integer;
  APrevState, ANewState: TcxCheckBoxState);
begin
  inherited;
  rdgTipoMovClick(Sender);
end;

procedure TfrmFatExpedicao.lstStatusPedidoClickCheck(Sender: TObject;
  AIndex: Integer; APrevState, ANewState: TcxCheckBoxState);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  pFiltrarPedidos();
  pCalculaResumoTotalDocumentos();
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

{function TfrmFatExpedicao.fValidaSeparacaoEmLocalizacaoTransitoria(strAutInc : String) : boolean;
var
  qryTransitoria : TUniQuery;
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
begin
  qryTransitoria := fCriaQuery(nil);
  try
    qryTransitoria.SQL.Add('SELECT                                                          ');
    qryTransitoria.SQL.Add('  FDO_CODITE,                                                   ');
    qryTransitoria.SQL.Add('  LOT_NUMLOT,                                                   ');
    qryTransitoria.SQL.Add('  LOC_CODLOC,                                                   ');
    qryTransitoria.SQL.Add('  LDO_QTDITE                                                    ');
    qryTransitoria.SQL.Add('FROM                                                            ');
    qryTransitoria.SQL.Add('  FATDOR                                                        ');
    qryTransitoria.SQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM           ');
    qryTransitoria.SQL.Add('  INNER JOIN CADLOT ON LOT_CODITE = FDO_CODITE                  ');
    qryTransitoria.SQL.Add('                   AND LOT_NUMLOT = LDO_NUMLOT                  ');
    qryTransitoria.SQL.Add('                   AND LOT_CODEMP = ' + QuotedStr(VS_strCodEmp)  );
    qryTransitoria.SQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS                  ');
    qryTransitoria.SQL.Add('                   AND LOC_CODEMP = LOT_CODEMP                  ');
    qryTransitoria.SQL.Add('WHERE FDO_SEQGER = :AUTINC                                      ');
    qryTransitoria.SQL.Add('  AND LOC_TRANSI = "S"                                          ');

    qryTransitoria.ParamByName('AUTINC').AsString := strAutInc;

    qryTransitoria.Open;

    Result := qryTransitoria.isEmpty;

    if not Result then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Existem produtos já separados e transferidos para a localização transitória, deseja limpar a separação mesmo assim?');
      objLiberacao.objMsgLibera.pAddQuebra();

      objTabela := TRegistroMsgLiberaTabela.Create();

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'PRODUTO'      , 07 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'LOCALIZAÇÃO'  , 30 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'LOTE'         , 20 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'QUANTIDADE'   , 10 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);

      qryTransitoria.First;
      while not qryTransitoria.eof do
      begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('PRODUTO'     , qryTransitoria.FieldByName('FDO_CODITE').AsString                           , 07 , alEsquerda , teAutcom);
        objLinha.pAddColuna('LOCALIZAÇÃO' , qryTransitoria.FieldByName('LOC_CODLOC').AsString                           , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('LOTE'        , qryTransitoria.FieldByName('LOT_NUMLOT').AsString                           , 30 , alEsquerda , teAutcom);
        objLinha.pAddColuna('QUANTIDADE'  , FormatFloat('#,###0.000', qryTransitoria.FieldByName('LDO_QTDITE').AsFloat) , 10 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        qryTransitoria.Next;
      end;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LIMPSETRA';
      objLiberacao.strMsgSen := 'Expedição - Limpar Separação com Transitória';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    end;

  finally
    FreeAndNil(qryTransitoria);
  end;

end;}

procedure TfrmFatExpedicao.mnuDesfazerExpedicaoDeDocumentoJaBaixadoTotalmenteClick(Sender: TObject);
var
  frmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente : TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente;
begin

  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not fVerificaAcessoSistema('DESEXP') Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem permissão para acessar essa funcionalidade!', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pCriarFormularios(TfrmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente, frmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente);

  Try

    If (frmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente.ShowModal = mrOk) Then
      btnRecarrPed.Click;

  Finally
    FreeAndNil(frmDesfazerExpedicaoDeDocumentoJaBaixadoTotalmente);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
  End;

end;

procedure TfrmFatExpedicao.mnuDesfazerExpedicaoDesteDocumentoClick(Sender: TObject);
var
  frmDesfazerExpedicaoDesteDocumento : TfrmDesfazerExpedicaoDesteDocumento;
begin

  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Not fVerificaAcessoSistema('DESEXP') Then
  Begin
    fMensagem('ATENÇÃO!', 'Você não tem permissão para acessar essa funcionalidade!', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pCriarFormularios(TfrmDesfazerExpedicaoDesteDocumento, frmDesfazerExpedicaoDesteDocumento);

  Try

    frmDesfazerExpedicaoDesteDocumento.strNumdoc := fField('NUMDOC').AsString;
    frmDesfazerExpedicaoDesteDocumento.strEspDoc := fField('ESPDOC').AsString;
    frmDesfazerExpedicaoDesteDocumento.strEmpDoc := fField('CODEMP').AsString;
    frmDesfazerExpedicaoDesteDocumento.strCodCli := fField('CODCLI').AsString;

    If Not frmDesfazerExpedicaoDesteDocumento.fCarregouDocumento Then
      fMensagem('', 'Este documento não tem itens expedidos!', ['&OK'])
    Else If (frmDesfazerExpedicaoDesteDocumento.ShowModal = mrOk) Then
      btnRecarrPed.Click;

  Finally
    FreeAndNil(frmDesfazerExpedicaoDesteDocumento);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
  End;

end;

procedure TfrmFatExpedicao.mnuGuardarItensSepClick(Sender: TObject);
var
  strAutIncPed: String;
  LComitar: Boolean;
begin
  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If (stlPedidos.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um '+strDescDoc+'.', ['&Ok']);
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if (not fValidaRemessaSeparacao) then
    Exit;

  If (fMensagem('', 'Deseja guardar os produtos já separados do(s) pedido(s) selecionado(s) ?', ['&Sim', '&Não'], 2) = 2) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  if fUsaOndaSeparacaoAgrupamento() and (not fLiberaLimparPedidoOndaSeparacao) then
    Exit;

  try
    try
      FExcluirExtLar := fValidaExcluiEXTLAR;

      fStartTransaction();
      LComitar := True;

      For strAutIncPed In stlPedidos Do
      Begin
        If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
          LComitar := fGuardarItensSeparados;

        if (not LComitar) then
          break;
      End;

      if LComitar then
        fCommit()
      else
        fRollback;

      pLimparSelecaoELocks;
      fMensagem('AVISO!', 'Produtos guardados com sucesso!', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        if E.Message.ToUpper.Contains('LTTAPC')  then
          pMensagemOk(E.Message)
        else
          pMensagensErro(E.message, 'TfrmFatExpedicao.mnuGuardarItensSepClick');
        pAtivaDesativaTimersNotificaoAndRecarga(True);
      End;
    End;
  finally
    TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
  end;

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.mnuLimparSeparacaoClick(Sender: TObject);
  const
    MSG_CONFIRMACAO = 'Deseja limpar as informações de separação do(s) pedido(s) selecionado(s)?';

  var
  strAutIncPed : String;
  strSeqSepPed : String;
  strNumPedSel : String;
  intCont      : Integer;
  cdsClone     : TZClient;
  frmGravando  : TfrmGravando;
  blnExcluiDocumentoLoteSeparacao: Boolean;
  strAutIncLotSep: String;
  strNumLote: String;
  blnSelecionouAlgumPedido : Boolean;
  stlLckAtc    : TStringList;
  strChaLck    : String;
  intLck       : Integer;
  objPedido    : TPedidoVenda;

  procedure pMSGGuardarItensSeparados(ASeqs: String);
  begin
    if fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO and
      fPossuiItensSeparados(ASeqs) then
    begin
      fMensagem('AVISO!', 'Há itens no(s) documento(s) selecionado(s) que já tiveram a separação iniciada ' +
                          'e deverão ser guardados!', ['&Ok']);
    end;
  end;

  procedure pLimparSeparacaoApenasDoPedidoSelecionado;
  begin
    Try
      pArmazenaPedidoInicialDoProcesso;
      pMSGGuardarItensSeparados(fQuotedStr(fField('AUTINC').AsString));

      FExcluirExtLar := fValidaExcluiEXTLAR;

      fStartTransaction;

      Try
        if Self.fLimpaExpedicaoPedido(fField('AUTINC').AsString) then
          fCommit()
        Else
          fRollBack();

        pAtivaDesativaTimersNotificaoAndRecarga(True);
      Finally
        TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
        pRetornaParaPedidoDoInicioDoProcesso;
      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.message, 'TfrmFatExpedicao.mnuLimparSeparacaoClick');
      End;
    End;

  end;

  procedure pLimparSeparacaoDosPedidosSelecionados;
  begin
    If (stlPedidos.Count > 0) And (fItensConferidosNaoFaturados(fCommaText(stlPedidos, True))) Then
    Begin
      If (fMensagem('', 'O(s) documento(s) selecionado(s) possui itens que já '+
                        'foram conferidos. Ao limpar a separação, a conferência '+
                        'também será zerada. '+ sLineBreak +
                        'Deseja realmente limpar as informações de separação e '+
                        'conferência do(s) pedido(s) selecionado(s)?', ['&Sim', '&Não']) = 2) Then
      Begin
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;
    End;

    Try
      pMSGGuardarItensSeparados(fCommaText(stlPedidos, True));
      pArmazenaPedidoInicialDoProcesso;

      FExcluirExtLar := fValidaExcluiEXTLAR;
      fStartTransaction;

      Try
        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fLimparSeparacaoDosPedidosSelecionados;
          frmGravando.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;

        If frmGravando.blnConfirma Then
          fCommit();

        pAtivaDesativaTimersNotificaoAndRecarga(True);
      Finally
        If Assigned(frmGravando) Then
          pFreeAndNil(frmGravando);

        Screen.Cursor := crDefault;
        TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
        pRetornaParaPedidoDoInicioDoProcesso;

      End;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        if E.Message.ToUpper.Contains('LTTAPC')  then
          pMensagemOk(E.Message)
        else
          pMensagensErro(E.message, 'TfrmFatExpedicao.mnuLimparSeparacaoClick');
      End;
    End;

  end;

  function fMSGNaoEhPermitidoLimparSeparacaoDeOndaDeFormaParcial(ASeqSep, APedSel: String): Boolean;
    const
      OPC1 = 'Sim, TODOS';
      OPC2 = 'Não, APENAS o selecionado';
  begin
    Result := False;

    If (fUsaOndaSeparacaoExpedicao) Then
    Begin
      If fMensagem('Atenção!', 'O pedido ' + APedSel + ' pertence a uma onda de separação e pode ter outros '+
                               'itens que já foram separados, limpar a separação do mesmo pode '+
                               'gerar divergência na separação atual.'+#13+#10+
                               'Deseja continuar?', ['&SIM','&NÃO']) = 1 Then
      Begin
        If (Not fLiberaLimparPedidoOndaSeparacao) Then
        Begin
          pAtivaDesativaTimersNotificaoAndRecarga(True);
          Exit;
        End;
      End
      Else
      Begin
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;
    End;

    Result := True;

    If (fMensagem('Atenção!',
                  'O pedido selecionado "' + APedSel + '" faz parte do sequencial de separação ' + ASeqSep + '.' + #13 +
                  'O que deseja fazer, limpar a separação de TODOS os pedidos do sequencial?',
                  [OPC1, OPC2],
                  2,
                  False,
                  1,
                  250,
                  False,
                  0,
                  False,
                  False,
                  True,
                  0,
                  600) = 1) Then
    Begin
      if (not fUsaOndaSeparacaoAgrupamento()) then
        pLimparSelecaoTotalmente;

      cdsClone.First;

      While Not cdsClone.Eof Do
      Begin

        If (ASeqSep.Equals(cdsClone.FieldByName('SEQSEP').AsString)) Then
        Begin
          If Not fSelecionado(cdsClone) Then
          Begin
            If (cdsPedidos.Locate('AUTINC', cdsClone.FieldByName('AUTINC').AsString, [])) Then
            Begin
              pAdicionaListaSelecao;
            End;
          End;
        End;

        cdsClone.Next;
      End;

      if (not fUsaOndaSeparacaoAgrupamento()) then
      begin
        pLimparSeparacaoDosPedidosSelecionados;
        Exit;
      end;
    End
    Else if (not fUsaOndaSeparacaoAgrupamento()) then
      pLimparSeparacaoApenasDoPedidoSelecionado;
  end;

begin
  inherited;

  if (InterlockedIncrement(FSemaforoLimparSeparacao) <> 0) then
  begin
    InterlockedDecrement(FSemaforoLimparSeparacao);
    Exit;
  end;

  try
    SetLength(FRemoverPedidoLista, 0);
    SetLength(FGuardarItens, 0);
    FExcluirExtLar := False;

    pAtivaDesativaTimersNotificaoAndRecarga(False);

    If (Not mnuLimparSeparacao.Visible) Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Exit;
    End;

    If Not cdsPedidos.Active Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Exit;
    End;

    If cdsPedidos.IsEmpty Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Exit;
    End;

    If (Not fValidaDireitoDeAcessoParaLimparSeparacao) Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Exit;
    End;

    If FoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível limpar a separação de pedidos pertencentes a Remessa de Pedido/Separação!', ['&Ok']);
      Exit;
    End;

    If FoiSelecionadoPedidoComSeparacaoTotalmenteConcluida Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível limpar a separação, pois a mesma já foi concluída. Utilize a rotina "Guardar Itens Separados".', ['&Ok']);
      Exit;
    End;

    {Verifica se selecionou algum pedido de onda de separação,
     caso selecionou, valida se todos da onda foram selecionados!}

    If (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And ((fField('EXPTOT').AsString = 'S') Or (fField('TEMEXP').AsString = 'S')) Then
    Begin
      If Not fLiberouLimparSeparacaoItensExpedidos Then
      Begin
        pAtivaDesativaTimersNotificaoAndRecarga(True);
        Exit;
      End;
    End;

    cdsPedidos.DisableControls;
    stlLckAtc := TStringList.Create;
    Try

      {Clona os dados}
      cdsClone := TZClient.Create(nil);
      pCloneDataSet(cdsClone, cdsPedidos);
      cdsClone.Filtered := False;

      blnSelecionouAlgumPedido := (dbgPedidos.SelectedRows.Count > 0);

      {Valida SELECIONADOS}
      If blnSelecionouAlgumPedido Then
      Begin

        For intCont := 0 to dbgPedidos.SelectedRows.Count - 1 Do
        Begin
          dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intCont]);
          pAdicionaListaSelecao;
        End;

        For strAutIncPed In stlPedidos Do
        Begin

          If cdsClone.Locate('AUTINC', strAutIncPed, []) Then
          Begin
            strSeqSepPed := cdsClone.FieldByName('SEQSEP').AsString;
            strNumPedSel := cdsClone.FieldByName('DOCUME').AsString;

            If Not strSeqSepPed.IsEmpty Then
            Begin
              if (fUsaOndaSeparacaoAgrupamento()) and RemesseDePedidoPertenceARemessaDeSeparacao(cdsClone.FieldByName('SEQSEP').AsString) then
                pValidaPedidosRemessaSeparacao(cdsClone)
              else
              begin
                cdsClone.First;
                While Not cdsClone.Eof Do
                Begin
                  If (strSeqSepPed = cdsClone.FieldByName('SEQSEP').AsString) Then
                  Begin
                    If Not fSelecionado(cdsClone) Then
                    Begin
                      if (not fMSGNaoEhPermitidoLimparSeparacaoDeOndaDeFormaParcial(strSeqSepPed, strNumPedSel)) then
                        if (fUsaOndaSeparacaoAgrupamento()) then
                        begin
                          SetLength(FRemoverPedidoLista, Length(FRemoverPedidoLista) + 1);
                          FRemoverPedidoLista[Pred(Length(FRemoverPedidoLista))] := strAutIncPed;
                        end;

                      cdsClone.Last;

                      if (not fUsaOndaSeparacaoAgrupamento()) then
                        Exit;
                    End;
                  End;

                  cdsClone.Next;
                End;
              end;
            End;
          End;
        End;

        for strAutIncPed in FRemoverPedidoLista do
        begin
          if cdsPedidos.Locate('AUTINC', strAutIncPed, []) then
            pRemoveListaSelecao;
        end;

        if (stlPedidos.Count = 0) then
        begin
          pAtivaDesativaTimersNotificaoAndRecarga(True);
          Exit;
        end;
      End
      Else
      {Valida POSICIONADO}
      Begin
        strSeqSepPed := cdsClone.FieldByName('SEQSEP').AsString;
        strNumPedSel := cdsClone.FieldByName('DOCUME').AsString;

        if (fUsaOndaSeparacaoAgrupamento()) and RemesseDePedidoPertenceARemessaDeSeparacao(strSeqSepPed) then
        begin
          if (cdsPedidos.FieldByName('TEMSEPDOR').AsString = 'S') then
          begin
            if fCfgSis('GDPDCN', varBoolean) then
            begin
              if (fMensagem('Atenção', 'Pedido ' + cdsPedidos.FieldByName('DOCUME').AsString + ' pertence a uma Remessa de Separação já separada, limpar a separação do mesmo pode gerar divergência na separação atual. ' +
                'Deseja guardar itens separados antes de limpar a separação?', ['&Sim', '&Não'], 2) = 1) then
              begin
                SetLength(FGuardarItens, Length(FGuardarItens) + 1);
                FGuardarItens[Pred(Length(FGuardarItens))] := cdsPedidos.FieldByName('AUTINC').AsString;
              end
              else if (not fLiberaLimparPedidoOndaSeparacao) then
                Exit;
            end
            else if (fMensagem('Atenção', 'Pedido ' + cdsPedidos.FieldByName('DOCUME').AsString + ' pertence a uma Remessa de Separação já separada, limpar a separação do mesmo pode gerar divergência na separação atual. ' +
              'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) or (not fLiberaLimparPedidoOndaSeparacao) then
              Exit;
          end
          else if (fMensagem('Atenção', 'Pedido pertence a uma Remessa de Separação, limpar a separação do mesmo pode gerar divergência na separação atual. Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2)
            or (not fLiberaLimparPedidoOndaSeparacao) then
              Exit;
        end
        else
        begin
          cdsClone.Filtered := False;
          cdsClone.Filter   := 'SEQSEP = ' + strSeqSepPed.QuotedString;
          cdsClone.Filtered := True;

          If (cdsClone.RecordCount > 1) Then
          Begin
            if (not fMSGNaoEhPermitidoLimparSeparacaoDeOndaDeFormaParcial(strSeqSepPed, strNumPedSel)) then
              Exit;

            if (not fUsaOndaSeparacaoAgrupamento()) then
              Exit;
          End;
        end;
      End;

      For intCont := 0 to Pred(stlPedidos.Count) Do
      Begin
        objPedido := TPedidoVenda(stlPedidos.Objects[intCont]);

        strChaLck := 'FATGOR'
                   + objPedido.strNumDoc
                   + objPedido.strEspDoc
                   + objPedido.strCodEmp;

        If (Not objLock.fLocalizaTrava(strChaLck)) Then
        Begin
          If (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
          Begin
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck)  + '!', ['&Ok']);
            Exit;
          End;

          stlLckAtc.Add(strChaLck);
        End;
      End;

      {Mais de 1 selecionado...}
      If (stlPedidos.Count > 1) Then
      Begin

        If (fMensagem('', MSG_CONFIRMACAO, ['&Sim', '&Não'], 2) = 2) Then
        Begin
          pAtivaDesativaTimersNotificaoAndRecarga(True);
          Exit;
        End;

        pVerificaExcluirDocumentoLoteSeparacao;
        pLimparSeparacaoDosPedidosSelecionados;

      End
      Else
      Begin
        If fUsaOndaSeparacaoAgrupamento() and (stlPedidos.Count = 1) Then
          cdsPedidos.Locate('AUTINC', stlPedidos[0], []);

        If fField('AUTINC').IsNull Then
        Begin
          pAtivaDesativaTimersNotificaoAndRecarga(True);
          Exit;
        End;

        If (fMensagem('', MSG_CONFIRMACAO, ['&Sim', '&Não'], 2) = 2) Then
        Begin
          pAtivaDesativaTimersNotificaoAndRecarga(True);
          Exit;
        End;

        blnExcluiDocumentoLoteSeparacao := False;
        if (fCfgSis('MULSEP', varBoolean)) And fUsaRotinaWms then
        begin
          strAutIncLotSep := fRetLoteSeparacao(
            fField('NUMDOC').AsString,
            fField('ESPDOC').AsString,
            fField('CODEMP').AsString);

          if not fEmptyStr(strAutIncLotSep) then
          begin
            strNumLote := fCampoTabela('RLG_NUMLOT', 'ROMLGE', ['AUTOINCREM'], [strAutIncLotSep], False);

            If (fMensagem('', 'O pedido selecionado encontra-se vínculado ao lote de separação de romaneio ' + strNumLote + sLineBreak +
                              'Deseja excluir o pedido do lote de separação de romaneio?', ['&Sim', '&Não'], 2) = 1) Then
            begin
              if fVerificaAcessoSistema('PERMITEEXCPDLOTSEP') then
                 blnExcluiDocumentoLoteSeparacao := True
              else
                fMensagem('ATENÇÃO!', 'Você não tem direitos para acessar para excluir um pedido de um lote de separação de romaneio!', ['&Ok']);
            end;
          end;
        end;

        If (fItensConferidosNaoFaturados(fQuotedStr(fField('AUTINC').AsString))) Then
        Begin
          If (fMensagem('', 'O documento selecionado possui itens que já '+
                            'foram conferidos. Ao limpar a separação, a conferência '+
                            'também será zerada. '+ sLineBreak +
                            'Deseja realmente limpar as informações de separação e '+
                            'conferência do pedido selecionado?', ['&Sim', '&Não']) = 2) Then
          Begin
            pAtivaDesativaTimersNotificaoAndRecarga(True);
            Exit;
          End;
        End;

        try
          try
            pMSGGuardarItensSeparados(fQuotedStr(fField('AUTINC').AsString));
            pArmazenaPedidoInicialDoProcesso;

            FExcluirExtLar := fValidaExcluiEXTLAR;

            fExecutarModal(procedure
              begin
                pLimpaSeparacaoPedido(blnExcluiDocumentoLoteSeparacao, strAutIncLotSep);
              end, 'Aguarde, Limpando Separação do Pedido!', '');
          except
            on E: Exception do
              pMensagensErro(E.message, 'TfrmFatExpedicao.mnuLimparSeparacaoClick');
          end;
          pAtivaDesativaTimersNotificaoAndRecarga(True);
        Finally
          TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
          pRetornaParaPedidoDoInicioDoProcesso;
        End;
      End;

    Finally

      For intLck := 0 To Pred(stlLckAtc.Count) Do
        objLock.fLock_Unlock(stlLckAtc[intLck], False, False);

      FreeAndNil(stlLckAtc);

      cdsPedidos.EnableControls;
      pLimparSelecaoELocks;
      pLimpaVariaveisSelecaoPedidos;

      If Assigned(cdsClone) Then
        FreeAndNil(cdsClone);

      SetLength(FRemoverPedidoLista, 0);
      SetLength(FGuardarItens, 0);
    End;
  finally
    InterlockedDecrement(FSemaforoLimparSeparacao);
  end;
end;

procedure TfrmFatExpedicao.mnuLimparSeparacaoRomaneioClick(Sender: TObject);
var
  frmFatDigRomaneioLoteSeparacao: TfrmFatDigRomaneioLoteSeparacao;
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  Try
    pCriarFormularios(TfrmFatDigRomaneioLoteSeparacao, frmFatDigRomaneioLoteSeparacao);
    Try
      if frmFatDigRomaneioLoteSeparacao.ShowModal = MrOK then
      begin
        strNumLotSepLimpa := frmFatDigRomaneioLoteSeparacao.edtNumLot.Text;
        fChamaTelaGravando(fLimpaSeparacaoLoteSep, 'Aguarde... Limpando separação do Lote de Romaneio!')
      end;
    Finally
      pFreeAndNil(frmFatDigRomaneioLoteSeparacao);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.message, 'TfrmFatExpedicao.mnuLimparSeparacaoClick');
      pAtivaDesativaTimersNotificaoAndRecarga(True);
    End;
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.mnuVerSeparacoesClick(Sender: TObject);
begin

  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If Assigned(prcExecutaRelatorio) Then
  Begin
    prcExecutaRelatorio(190, 7474, [],
                        ['NUMDOC','ESPDOC','CODCLI','CODEMP','USAARM','EXBXTO'],
                        [fField('NUMDOC').AsString,
                        fField('ESPDOC').AsString,
                        fField('CODCLI').AsString,
                        fField('CODEMP').AsString,
                        IfThen((tfFiltroLocSepArmz = tfArmazem),'S','N'),
                        IfThen(fCfgSis('EXBXTO', varBoolean),'S','N')],
                        Sender,
                        nil,
                        True);
  End;

  pAtivaDesativaTimersNotificaoAndRecarga(True);

end;

procedure TfrmFatExpedicao.pImpOrdemProdItemEstrutura;
  Var
    stlIte_OP: TStringList;
    objOrdPro: TOrdPro;
    intIndex, intUltimaLinha : Integer;
    blnImprim: Boolean;
begin

  If (fField('ORDPRO').AsString = 'PENDENTE') And
     (Not fPergunta('Este pedido possui itens com ordem de produção não emitida.'+#13+'Deseja emitir a ordem de produção?')) Then
    Exit;

  If (fField('ORDPRO').AsString = 'EMITIDA') And
     (Not fPergunta('Este pedido possui itens com ordem de produção emitida.'+#13+'Deseja imprimir a ordem de produção?')) Then
    Exit;

  If (fField('ORDPRO').AsString = EmptyStr) Then
    Exit;

  Try
    dbgPedidos.Enabled := False;
    Screen.Cursor := crHourGlass;

    stlIte_OP := TStringList.Create;
    blnImprim := True;

    If fField('ORDPRO').AsString = 'PENDENTE' Then
    Begin
      Try
        pCriarFormularios(TfrmGravando, frmGravando);
        frmGravando.fExecutarAcao := fGerarOrdemProdItemEstrutura;
        frmGravando.ShowModal;
        blnImprim := frmGravando.blnConfirma;
      Except
        On E: Exception Do
        Begin
          blnImprim := False;
          pMensagensErro(E.Message, '');
        End;
      End;
    End;

    If blnImprim Then
    Begin
      stlIte_OP.CommaText := fField('ITE_OP').AsString;

      objOrdPro := TOrdPro.Create(Nil, True);

      intUltimaLinha := 0;
      For intIndex := 0 To stlIte_OP.Count -1 Do
        objOrdPro.pImprimeOrdPro(RightStr(stlIte_OP[intIndex], 12),
                                 intUltimaLinha,
                                 False,
                                 '',
                                 True,
                                 (intIndex = stlIte_OP.Count -1));

    End;

    FreeAndNil(objOrdPro);
    FreeAndNil(stlIte_OP);

  Finally
    dbgPedidos.Enabled := True;
    Screen.Cursor := crDefault;
  End;

end;

function TfrmFatExpedicao.fGerarOrdemProdItemEstrutura(pgbStatus: TcxProgressBar = nil): Boolean;
  Var
    stlIte_OP: TStringList;
    objOrdPro: TOrdPro;
    intIndex : Integer;
    qryItemPD: TUniQuery;

  procedure pCarregaItemPD(strAutInc, strSeqGer: String);
  begin
    With qryItemPD, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT SQL_NO_CACHE ');
      Add('  FDO_NUMDOC, ');
      Add('  FDO_ESPDOC, ');
      Add('  FDO_CODITE, ');
      Add('  FDO_ORDPRO, ');
      Add('  FDO_QTDITE - FDO_QTDBAI AS FDO_QTDITE ');
      Add('FROM ');
      Add('  FATDOR ');
      Add('WHERE ');
      Add('  AUTOINCREM = :AUTINC AND ');
      Add('  FDO_SEQGER = :SEQGER ');
      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;
    End;
  end;

  procedure pMarcaNumOrdPro(strAutInc, strSeqGer, strOrdPro: String);
    Var
      qryUpd : TUniQuery;
  begin

    qryUpd := fCriaQuery(Nil);

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('UPDATE ');
      SQL.Add('	FATDOR ');
      SQL.Add('SET ');
      SQL.Add('	FDO_ORDPRO = :ORDPRO ');
      SQL.Add('WHERE ');
      SQL.Add('	AUTOINCREM = :AUTINC AND ');
      SQL.Add('	FDO_SEQGER = :SEQGER ');

      ParamByName('ORDPRO').AsString := strOrdPro;
      ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('SEQGER').AsString := strSeqGer;

      ExecSQL;

    End;

    FreeAndNil(qryUpd);

  end;

  procedure pProgresso(strInf: String; intPos, intMax: Integer);
  Begin
    If Assigned(pgbStatus) Then  
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := intPos;

      If (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInf;

      Application.ProcessMessages;
    End;
  End;

begin
  Result := True;
  
  stlIte_OP := TStringList.Create;
  qryItemPD := fCriaQuery(nil);

  stlIte_OP.CommaText := fField('ITE_OP').AsString;

  If fField('ORDPRO').AsString = 'PENDENTE' Then
  Begin
    For intIndex := 0 To stlIte_OP.Count -1 Do
    Begin
      pProgresso('Aguarde, Gerando Ordem de Produção...', Succ(IntIndex), stlIte_OP.Count);

      If Pos('PENDENTE', stlIte_OP[intIndex]) > 0 Then
      Begin
        { CARREGA O PRODUTO ESTRUTURA QUE AINDA NAO EMITIU A ORDEM DE PRODUCAO }
        pCarregaItemPD(LeftStr(stlIte_OP[intIndex], 20),           //Autinc Ex: 00100000000000001001-PENDENTE
                       fField('AUTINC').AsString); //SeqGer

        {CASO NAO TENHA GERADO A ORDEM DE PRODUCAO }
        If fEmptyStr(qryItemPD.FieldByName('FDO_ORDPRO').AsString) Then
        Begin
          {CRIA A CLASSE DE ORDEM DE PRODUCAO}
          objOrdPro := TOrdPro.Create(Nil, True);

          {ATRIBUI AS VARIAVEIS}
          objOrdPro.strNumDoc := fField('NUMDOC').AsString;
          objOrdPro.strEspDoc := fField('ESPDOC').AsString;
          objOrdPro.strCodEmp := fField('CODEMP').AsString;

          If (fCfgSis('ENT_CD', varBoolean)) And
             (VS_strCodEmp = fCfgSis('EMP_CD')) And
              fPedidoEntregaCD(fField('NUMDOC').AsString,
                               fField('ESPDOC').AsString,
                               fField('CODEMP').AsString,
                               fField('CODCLI').AsString) Then
          Begin
            objOrdPro.strCodEmp := VS_strCodEmp;
          End;

          objOrdPro.strCodCli := fField('CODCLI').AsString;
          objOrdPro.strCodIte := qryItemPD.FieldByName('FDO_CODITE').AsString;
          objOrdPro.strQtdApr := FloatToStrF(qryItemPD.FieldByName('FDO_QTDITE').AsFloat, ffFixed, 12, 4);
          objOrdPro.strQtdPro := '0.0';
          objOrdPro.strConfer := fRetNomVendRep(strLoginUsuarioLogado);

          objOrdPro.strDtaPro := fField('PREVIS').AsString;

          objOrdPro.strDtaCad := DateToStr(VS_Date);
          objOrdPro.strObs001 := 'GERADO PELA ' + Self.Caption;
          objOrdPro.strObs002 := 'DOCUMENTO: ' + objOrdPro.strNumDoc + '-' + objOrdPro.strEspDoc;

          objOrdPro.strNumPed := fField('NUMDOC').AsString;
          objOrdPro.strEspPed := fField('ESPDOC').AsString;
          objOrdPro.strEmpPed := fField('CODEMP').AsString;

          {GERA A ORDEM DE PRODUCAO}
          Result := objOrdPro.fInsereOrdemProducao;

          If Result Then
          Begin
            stlIte_OP[intIndex] := AnsiReplaceStr(stlIte_OP[intIndex], 'PENDENTE', objOrdPro.strCodPro);

            pMarcaNumOrdPro( LeftStr(stlIte_OP[intIndex], 20),          //AUTOINCREM
                             fField('AUTINC').AsString, //FDO_SEQGER
                             objOrdPro.strCodPro );                     //FDO_ORDPRO
          End;

          {DESTROI A CLASSE ORDEM DE PRODUCAO}
          FreeAndNil(objOrdPro);

          If Not Result Then
            Break;
        End
        Else
          stlIte_OP[intIndex] := AnsiReplaceStr(stlIte_OP[intIndex], 'PENDENTE', qryItemPD.FieldByName('FDO_ORDPRO').AsString);
      End;
    End;
  End;

  cdsPedidos.Edit;
  fField('ITE_OP').AsString := stlIte_OP.CommaText;
  fField('ORDPRO').AsString := 'EMITIDA';
  cdsPedidos.Post;

  FreeAndNil(stlIte_OP);
  FreeAndNil(qryItemPD);
end;

function TfrmFatExpedicao.fGerarSeqSep: String;
begin
  Result := fAtualizaProCod('EXTGOR', 'FGO_SEQSEP', '', 1, Nil,
    function (const AValue: String) : String
    begin
      Result := VS_strCodEmp + fPadL(AValue, 9, '0');
    end
  );
end;

function TfrmFatExpedicao.fUsaFiltroLocSepTodos: Boolean;
begin
  //UTILIZA O FILTRO POR LOCAL, ESTÁ REALIZANDO FILTRO TODOS
  Result := (grbLocSep.Visible) And (cmbLocSep.ItemIndex = 0);
end;

function TfrmFatExpedicao.fUsaFiltroLocSep: Boolean; 
begin
  //UTILIZA O FILTRO POR LOCAL E ESTÁ REALIZANDO FILTRO DIFERENTE DE TODOS
  Result := (grbLocSep.Visible) And (cmbLocSep.ItemIndex > 0);
end;

function TfrmFatExpedicao.fNaoUsaFiltroLocSep: Boolean; 
begin
  Result := (Not grbLocSep.Visible);
end;

function TfrmFatExpedicao.FoiSelecionadoPedidoComSeparacaoTotalmenteConcluida: Boolean;
  var
    strAutIncPed : String;
    intCont      : Integer;
    cdsClone     : TZClient;
    blnSelecionouAlgumPedido : Boolean;
begin

  Result := False;

  If Not fCfgSis('SOLOLA', varBoolean) Then
    Exit;

  If Not fCfgSis('GDPDCN', varBoolean) Then
    Exit;

  if fCfgSis('BXSLSE', varBoolean) Then
    Exit;

  cdsPedidos.DisableControls;

  Try

    {Clona os dados}
    cdsClone := TZClient.Create(nil);
    pCloneDataSet(cdsClone, cdsPedidos);
    cdsClone.Filtered := False;

    blnSelecionouAlgumPedido := (dbgPedidos.SelectedRows.Count > 0);

    {Valida SELECIONADOS}
    If blnSelecionouAlgumPedido Then
    Begin

      For intCont := 0 to dbgPedidos.SelectedRows.Count - 1 Do
      Begin
        dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intCont]);
        pAdicionaListaSelecao;
      End;

      For strAutIncPed In stlPedidos Do
      Begin
        If cdsClone.Locate('AUTINC', strAutIncPed, []) Then
        Begin
          If (Not cdsClone.FieldByName('DTBXSE').IsNull) And
             (Not cdsClone.FieldByName('HRBXSE').IsNull) And
             (Not fEmptyStr(cdsClone.FieldByName('OPBXSE').AsString)) Then
          Begin
            Exit(True);
          End;
        End;
      End;

    End
    Else
    {Valida POSICIONADO}
    Begin

      If (Not cdsClone.FieldByName('DTBXSE').IsNull) And
         (Not cdsClone.FieldByName('HRBXSE').IsNull) And
         (Not fEmptyStr(cdsClone.FieldByName('OPBXSE').AsString)) Then
      Begin
        Exit(True);
      End;

    End;

  Finally

    cdsPedidos.EnableControls;
    pLimparSelecaoTotalmente;

    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);

  End;

end;

function TfrmFatExpedicao.FoiSelecionadoPedidoDeRemessaDePedidoComRemessaDeSeparacaoJaGerada: Boolean;
  var
    strAutIncPed : String;
    intCont      : Integer;
    cdsClone     : TZClient;
    blnSelecionouAlgumPedido : Boolean;
begin

  Result := False;

  If Not fUsaOndaSeparacaoAgrupamento() Then
    Exit;

  cdsPedidos.DisableControls;

  Try

    {Clona os dados}
    cdsClone := TZClient.Create(nil);
    pCloneDataSet(cdsClone, cdsPedidos);
    cdsClone.Filtered := False;

    blnSelecionouAlgumPedido := (dbgPedidos.SelectedRows.Count > 0);

    {Valida SELECIONADOS}
    If blnSelecionouAlgumPedido Then
    Begin

      For intCont := 0 to dbgPedidos.SelectedRows.Count - 1 Do
      Begin
        dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intCont]);
        pAdicionaListaSelecao;
      End;

      For strAutIncPed In stlPedidos Do
      Begin
        If cdsClone.Locate('AUTINC', strAutIncPed, []) Then
        Begin
          If Not fEmptyStr(cdsClone.FieldByName('SEQSEP').AsString) Then
          Begin
            If RemesseDePedidoPertenceARemessaDeSeparacao(cdsClone.FieldByName('SEQSEP').AsString) Then
              Exit(True);
          End;
        End;
      End;

    End
    Else
    {Valida POSICIONADO}
    Begin

      If Not fEmptyStr(cdsClone.FieldByName('SEQSEP').AsString) Then
      Begin
        If RemesseDePedidoPertenceARemessaDeSeparacao(cdsClone.FieldByName('SEQSEP').AsString) Then
          Exit(True);
      End;

    End;

  Finally

    cdsPedidos.EnableControls;
    pLimparSelecaoTotalmente;

    If Assigned(cdsClone) Then
      FreeAndNil(cdsClone);

  End;

end;

function TfrmFatExpedicao.fOndaSeparacao: Boolean;
begin

  If (FiltroOnda = fosNaoUtilizarOnda) Then
    Exit(False);

  Result := True;

end;

function TfrmFatExpedicao.fPodeBaixarSeparacaoPedidoUtilizandoLocTransitoria: Boolean;
var
  LQry: TUniQuery;
begin
  Result := True;

  if (not fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO) then
    Exit;

  if fExistemItensSeparadosLocTransitoriaVAGAO(fField('AUTINC').AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Este Pedido de Venda possui item(ns) separado(s) na localização transitória (VAGÃO).', ['&OK']);
    Exit(False);
  end;

  LQry := fCriaQuery;

  try
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Text :=
      ' SELECT COUNT(1) QTD ' +
      ' FROM FATDOR D ' +
      ' INNER JOIN LOTDOR L ON D.AUTOINCREM = L.LDO_SEQFDO ' +
      ' WHERE IFNULL(L.LDO_QTDSEP, 0) = 0 ' +
      '   AND D.FDO_SEQGER = :SEQGER ';
    LQry.ParamByName('SEQGER').AsString := fField('AUTINC').AsString;
    LQry.Open;

    if (LQry.FieldByName('QTD').AsInteger > 0) then
    begin
      fMensagem('ATENÇÃO!', 'Este Pedido de Venda possui itens que ainda não foram separados pelo Coletor.', ['&OK']);
      Exit(False);
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatExpedicao.fPodeFaturarOndaPedidosTotalmenteExpedidos: Boolean;
const
  Totalmente_Conferidos = 0;
begin
  Result := (strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And fOndaSeparacao And (dbgPedidos.SelectedRows.Count > 1) And
            (rdgTipoConferencia.ItemIndex = Totalmente_Conferidos);
end;

function TfrmFatExpedicao.fPossuiItensSeparados(ASeqsFGO: String): Boolean;
var
  LQry: TUniQuery;
begin
  Result := False;

  If fEmptyStr(ASeqsFGO) Then
    Exit;

  LQry := fCriaQuery;

  try
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Text :=
      ' SELECT COUNT(1) QTD ' +
      ' FROM FATDOR D ' +
      ' INNER JOIN LOTDOR L ON D.AUTOINCREM = L.LDO_SEQFDO ' +
      ' WHERE L.LDO_QTDSEP > 0 ' +
      '   AND D.FDO_SEQGER IN (' + ASeqsFGO + ') ';
    LQry.Open;

    Result := LQry.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmFatExpedicao.fPossuiLocSepPendente: Boolean;
begin
  //POSSUI ITENS COM LOCAL DE SEPARAÇÃO AINDA NÃO LIBERADOS
  Result := (Not fEmptyStr(fField('LSEPEN').AsString));
end;

procedure TfrmFatExpedicao.pBaixarSeparacaoPedido;
  Var
    strOpeBai             : String;
    cdsItensSep           : TUniClientDataSet;
    blnCondicaoAviso      : Boolean;
    blnChamaExpSepItens   : Boolean;
    blnBaixaParaExpedicao : Boolean;

    blnBaixouOnda         : Boolean;
    blnCancelou           : Boolean;

    frmSolicitaLocalizacaoFisicaTransitoria : TfrmSolicitaLocalizacaoFisicaTransitoria;
    strCodigoLocalizacaoFisicaTransitoria   : String;
    objTransferenciaLotesTransitoria        : TTransferenciaLotesTransitoria;

  function fTemItensComSetorNaoCadastrado(strAutIncGer: String): Boolean;
    Var
      qryAux  : TUniQuery;
  Begin
    Result := False;

    If fCfgSis('GRUSEP', varBoolean) And grbLocSep.Visible And blnApenasImprimirBaixarSeparacao Then
    Begin
      qryAux := fCriaQuery;
      Try
        With qryAux Do
        Begin
          SQL.Clear;
          SQL.Add('SELECT ');
          SQL.Add('  GROUP_CONCAT(DISTINCT  " ", ITE_CODITE) AS CODITE ');
          SQL.Add('FROM ');
          SQL.Add('  FATDOR ');
          SQL.Add('     LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATDOR.FDO_SEQGER ');
          SQL.Add('    INNER JOIN ITEGER ON ITEGER.ITE_CODITE = FATDOR.FDO_CODITE ');
          SQL.Add('                     AND ITEGER.ITE_CODEMP = IF(TRIM(IFNULL(EXTGOR.FGO_EMPEXP, "")) <> "", EXTGOR.FGO_EMPEXP, FATDOR.FDO_CODEMP) ');
          If tfFiltroLocSepArmz = tfArmazem Then
            SQL.Add('  LEFT JOIN CADAMZ ON  AMZ_CODAMZ = FDO_NUMLOT AND AMZ_CODEMP = FDO_CODEMP')
          Else  
            SQL.Add('  LEFT JOIN CADLSE ON ITEGER.ITE_CODLSE = CADLSE.LSE_CODIGO ');
            
          SQL.Add('WHERE');

          If tfFiltroLocSepArmz = tfArmazem Then          
            SQL.Add('IFNULL(AMZ_DESCRI,"") = "" ')
          Else  
            SQL.Add('IFNULL(LSE_DESCRI,"") = "" '); 

          SQL.Add('  AND FATDOR.FDO_SEQGER = :AUTINC ');
          
          If (fCfgSis('USASER', varBoolean)) Then
          Begin
            SQL.Add('  AND FATDOR.FDO_CODITE <> :ITESER ');

            If (fCfgSis('AUTCEN', varBoolean)) Then
              SQL.Add('  AND FATDOR.FDO_CODITE <> :SERTER ');
          End;

          SQL.Add('ORDER BY ITEGER.ITE_CODITE ');

          ParamByName('AUTINC').AsString := strAutIncGer;

          If (fCfgSis('USASER', varBoolean)) Then 
          Begin
            ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);

            If (fCfgSis('AUTCEN', varBoolean)) Then
              ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
          End;

          Open;

          If Not IsEmpty Then 
          Begin
            If Not FieldByName('CODITE').AsString.IsEmpty Then
            Begin
              fMensagem('', 'Há produto(s) com '+IIF(tfFiltroLocSepArmz = tfArmazem,'Armazém','Local da Separação')+' não preenchido' + #13#10 +
                            'Atualize o(s) item(s) ' + FieldByName('CODITE').AsString + ' antes de imprimir!', ['&Ok']);
              Result := True;
            End;
          End;
        End;
      Finally
        FreeAndNil(qryAux);
      End;
    End;
  end;

  function fQtdSepAtu(strIncDet, strEspDoc: String): Double;
   Var
     qryGen: TUniQuery;
  begin
    Result := 0;

    qryGen := fCriaQuery(Nil);
    Try
      qryGen.SQL.Text := ' SELECT IFNULL(FDO_QTDSEP, 0) AS QTDSEP FROM FATDOR          '+
                         '   LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM '+
                         '  WHERE FATDOR.AUTOINCREM = :INCDET                          ';

      If (strEspDoc <> 'PD') Then
      Begin
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FATDOR', 'MOVDET');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'EXTDOR', 'MOVTRI');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FDO_SEQFDO', 'DET_SEQGER');
        qryGen.SQL.Text := AnsiReplaceStr(qryGen.SQL.Text, 'FDO_', 'DET_');
      End;

      qryGen.ParamByName('INCDET').AsString := strIncDet;
      qryGen.Open;
      If Not qryGen.IsEmpty Then
        Result := qryGen.FieldByName('QTDSEP').AsFloat
    Finally
      FreeAndNil(qryGen);
    End;
  end;

  function f_SQL_FATDOR_para_MOVDET(Const strSQL : String) : String;
  begin
    Result := strSQL;
    If (fField('ESPDOC').AsString <> 'PD') Then
    Begin
      Result := AnsiReplaceStr(Result, 'FATDOR'    , 'MOVDET');
      Result := AnsiReplaceStr(Result, 'EXTDOR'    , 'MOVTRI');
      Result := AnsiReplaceStr(Result, 'FDO_SEQFDO', 'DET_SEQGER');
      Result := AnsiReplaceStr(Result, 'FDO_'      , 'DET_');
    End;
  end;

begin

  If Not cdsPedidos.Active Or cdsPedidos.IsEmpty Then
    Exit;

  If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa And
     Not fValidaLocalRetiraAoSelecionarPedido(fField('NUMDOC').AsString,
                                              fField('ESPDOC').AsString,
                                              fField('CODEMP').AsString) Then
    Exit;

  If Not fValidarAbastecimentoEstoquePedido Then
    Exit;

  If (fField('ORDPRO').AsString = 'PENDENTE') And (Not fIgnoraImpOrdemProdItemEstrutura) Then
  Begin
    pImpOrdemProdItemEstrutura;
    Exit;  
  End;

  If (fField('ORDPRO').AsString = 'EMITIDA') And
     (Not fVerificaOrdProdEstruturaEstaoBaixadas) And
     (Not fBaixaOrdemProducaoAutomaticamente) Then
  Begin
    pMensagemOk('As Ordens de Produção emitidas para este pedido ainda não foram baixadas!');
    Exit;  
  End;

  If fUsaRotinaWMS and (not fUsaOndaSeparacaoAgrupamento) Then
  Begin
    If (strToIntDef(fField('SEPIMP').AsString, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A separação deste pedido ainda não foi impressa!', ['&O k']);
      Exit;
    End
    Else If fFiltrarLocalSeparacaoItensWMS And
            Not fRealizouDefinicaoLotesNoLocalSeparacaoSelecionado(fField('NUMDOC').AsString,
                                                                   fField('ESPDOC').AsString,
                                                                   fField('CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'A separação no Local de Separação [' + fGetDescricaoLocSep() + '] ainda não foi impressa!', ['&O k']);
      Exit;
    End;
  End;

  If (fUsaFiltroLocSep()) And (Pos(fGetCodigoLocSep(), fField('CODLSE').AsString) <= 0) Then Begin
    fMensagem('ATENÇÃO!', 'Não existem produtos para o local de separação selecionado!', ['&OK']);
    Exit;
  End;

  if fUsaRotinaWMS And fCfgSis('TINWMS', varBoolean) And fPedidoComTintaImobiliaria And fUtilizandoImpressaoBaixaSeparacaoPassandoPeloColetorOuRobo Then
  Begin
    fMensagem('', 'O pedido atual possui tinta imobiliaria, a separação deve ser feita via coletor para movimentar o estoque da base do picking para o lote principal de tinta de máquina!', ['&OK']);
    Exit;
  End;

  If (fField('TABELA').AsString = 'FATGOR') And fTemItensComSetorNaoCadastrado(fField('AUTINC').AsString) Then
  Begin
    Exit;
  End;

  If (fUsaRotinaWMS And fUsaOndaSeparacaoAgrupamento) Then
    Exit;

  if (not fPodeBaixarSeparacaoPedidoUtilizandoLocTransitoria) then
    Exit;

  If fCfgSis('EXBXTO', varBoolean) Then
    blnCondicaoAviso := fNaoUsaFiltroLocSep()
  Else
    blnCondicaoAviso := fNaoUsaFiltroLocSep() Or fUsaFiltroLocSepTodos();

  {** Onda **}
  blnBaixouOnda := False;
  blnCancelou   := False;

  If (fUsaOndaSeparacaoExpedicaoWMS Or fUsaOndaSeparacaoExpedicao) And (fTemPedidoDeOndaSelecionado) Then
  Begin

    If (fValida_SelecaoDePedidosOnda_Baixa(blnCancelou)) Then
    Begin

      Try

        Screen.Cursor := crHourGlass;
        Application.ProcessMessages;

        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fBaixarOndaSeparacao;
          frmGravando.ShowModal;
        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '');
          End;
        End;

        blnBaixouOnda := frmGravando.blnConfirma;

        If (blnBaixouOnda) Then
          TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');

      Finally

        Screen.Cursor := crDefault;

        If Assigned(frmGravando) Then
          pFreeAndNil(frmGravando);

      End;

    End;

    If (blnBaixouOnda) Or (blnCancelou) Then
      Exit;

  End;

  If (blnUsaImpressaoSeparacaoPorLocal) And
     (Not fUsaFiltroLocSep()) And
     (fUsaFiltroLocSepTodos()) And
     (Not fPossuiLocSepPendente()) Then
  Begin
    fMensagem('ATENÇÃO', 'O local de separação do(s) item(ns) do documento '+
                          fField('NUMDOC').AsString+'-'+fField('ESPDOC').AsString+'-'+fField('CODEMP').AsString+
                         ' deve(m) ser preenchido(s).', ['&OK']);
    Exit;
  End;

  If fPergunta('Confirma a baixa da separação do Pedido ' + fField('NUMDOC').AsString + '?' +
               IIF(blnCondicaoAviso, #13#10 + '(O pedido será liberado para expedição)', '')) Then
  Begin
    strOpeBai := fPedeSenhaOperador('Senha do Operador da Baixa');

    If fEmptyStr(strOpeBai) Then
      Exit;

    //realiza a transferência para a Localização Transitória e altera a lotdor do pedido
    if fCfgSis('ESTTRA', varBoolean) then
    begin

      pCriarFormularios(TfrmSolicitaLocalizacaoFisicaTransitoria, frmSolicitaLocalizacaoFisicaTransitoria);
      try
        strCodigoLocalizacaoFisicaTransitoria := '';
        if frmSolicitaLocalizacaoFisicaTransitoria.ShowModal = mrOk then
          strCodigoLocalizacaoFisicaTransitoria := frmSolicitaLocalizacaoFisicaTransitoria.edtCodigoLocalizacaoFisica.Text
        else
          exit;

      finally
        pFreeAndNil(frmSolicitaLocalizacaoFisicaTransitoria);
      end;
    end;

    {***PRIMEIRO SERÁ REALIZADA A BAIXA DOS ITENS POR LOCAL DE SEPARAÇÃO***}
    {***CASO O FILTRO DE LOCAL DE SEPARAÇÃO 'cmbLocSep' ESTIVER EM USO  ***}
    If (fUsaFiltroLocSep()) Or
       ((fUsaFiltroLocSepTodos()) And (fPossuiLocSepPendente())) Then
    Begin
      If fCfgSis('EXBXTO', varBoolean) Then
        blnChamaExpSepItens := True
      else
        blnChamaExpSepItens := (fUsaFiltroLocSep());

      if (blnChamaExpSepItens) then
      begin
        pCriarFormularios(TfrmFatExpSeparacaoItens, frmFatExpSeparacaoItens);
        Try
          frmFatExpSeparacaoItens.strNumDoc := fField('NUMDOC').AsString;
          frmFatExpSeparacaoItens.strEspDoc := fField('ESPDOC').AsString;
          frmFatExpSeparacaoItens.strCodCli := fField('CODCLI').AsString;
          frmFatExpSeparacaoItens.strCodLse := fGetCodigoLocSep();
          frmFatExpSeparacaoItens.strCodEmp := fField('CODEMP').AsString;
          frmFatExpSeparacaoItens.blnSepPorArmazem := (tfFiltroLocSepArmz = tfArmazem);
          frmFatExpSeparacaoItens.ShowModal();

          If (frmFatExpSeparacaoItens.blnConfir) Then
          Begin
            cdsItensSep := TUniClientDataSet.Create(Nil);
            pCloneDataSet(cdsItensSep, frmFatExpSeparacaoItens.cdsItens);
          End Else
          Begin
            Exit;
          End;
        Finally
          FreeAndNil(frmFatExpSeparacaoItens);
        End;
      end;

      If (Not ((fUsaFiltroLocSepTodos()) And (fPossuiLocSepPendente()))) And
         (Not fPergunta('Somente serão baixados os itens do '+IIF(tfFiltroLocSepArmz = tfLocSep,'local de separação','armazém')+' selecionado no filtro ['+ fGetDescricaoLocSep() + ']. Deseja continuar?')) Then
      Begin
        FreeAndNil(cdsItensSep);
        Exit;
      End;


      With fCriaQuery, SQL Do
      Begin
        Clear;

        If fCfgSis('EXBXTO', varBoolean) Then
        begin
          Text := 'UPDATE EXTDOR, FATDOR ' +
                  '   SET FDO_OPBXSE = :OPBXSE, '  +
                  '       FDO_DTBXSE = :DTBXSE, '  +
                  '       FDO_HRBXSE = :HRBXSE, '  +
                  '       FDO_QTDSEP = :QTDSEP  '  +
                  ' WHERE EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
                  '   AND FATDOR.AUTOINCREM = :INCDET ' ;

          Text := f_SQL_FATDOR_para_MOVDET(Text);

          cdsItensSep.First;
          While (Not cdsItensSep.Eof) Do
          Begin
            ParamByName('INCDET').AsString := cdsItensSep.FieldByName('AUTOINCREM').AsString;

            If (cdsItensSep.FieldByName('QTDSEP').AsFloat = 0) Then
            Begin
              ParamByName('QTDSEP').Value := Null;
              ParamByName('OPBXSE').Value := Null;
              ParamByName('DTBXSE').Value := Null;
              ParamByName('HRBXSE').Value := Null;
              ExecSQL;
            End
            Else If (fQtdSepAtu(cdsItensSep.FieldByName('AUTOINCREM').AsString, fField('ESPDOC').AsString) <> (cdsItensSep.FieldByName('QTDSEP').AsFloat)) Then
            Begin
              ParamByName('QTDSEP').AsFloat    := cdsItensSep.FieldByName('QTDSEP').AsFloat;
              ParamByName('OPBXSE').AsString   := strOpeBai;
              ParamByName('DTBXSE').AsDateTime := VS_Date;
              ParamByName('HRBXSE').AsDateTime := fTime();
              ExecSQL;
            End;

            cdsItensSep.Next();
          End;

          Destroy;
          FreeAndNil(cdsItensSep);
        End
        Else
        Begin
          Text := 'UPDATE EXTDOR, FATDOR, ITEGER ' +
                      ' SET FDO_OPBXSE = :OPBXSE, '  +
                      '     FDO_DTBXSE = :DTBXSE, '  +
                      '     FDO_HRBXSE = :HRBXSE, '  +
                      '     FDO_QTDSEP = <<QTDSEP>>  '  +
                      ' WHERE EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
                      '   AND FATDOR.FDO_SEQGER = :AUTINC    ' +
                      '   AND ITE_CODITE = FDO_CODITE ' +
                      '   AND ITE_CODEMP = FDO_CODEMP ';

          If (Not ((fUsaFiltroLocSepTodos()) And (fPossuiLocSepPendente()))) Then
          Begin
            Text := StringReplace(Text, '<<QTDSEP>>', ':QTDSEP', [rfReplaceAll]);

            While (Not cdsItensSep.Eof) Do
            Begin
              If tfFiltroLocSepArmz = tfArmazem Then
                Text := Text + ' AND FDO_NUMLOT = :CODLSE '
              Else
                Text := Text + ' AND ITE_CODLSE = :CODLSE ';

              Text := Text + ' AND FATDOR.AUTOINCREM = :SEQFDO ';

              ParamByName('CODLSE').AsString := fGetCodigoLocSep();
              ParamByName('SEQFDO').AsString := cdsItensSep.FieldByName('AUTOINCREM').AsString;
              ParamByName('AUTINC').AsString := fField('AUTINC').AsString;

              If (cdsItensSep.FieldByName('QTDSEP').AsFloat = 0) Then
              Begin
                ParamByName('QTDSEP').Value := Null;
                ParamByName('OPBXSE').Value := Null;
                ParamByName('DTBXSE').Value := Null;
                ParamByName('HRBXSE').Value := Null;
              End
              Else
              Begin
                ParamByName('QTDSEP').AsFloat    := cdsItensSep.FieldByName('QTDSEP').AsFloat;
                ParamByName('OPBXSE').AsString   := strOpeBai;
                ParamByName('DTBXSE').AsDateTime := VS_Date;
                ParamByName('HRBXSE').AsDateTime := fTime();
              End;

              cdsItensSep.Next();

              Text := f_SQL_FATDOR_para_MOVDET(Text);
              ExecSQL;
            End;
          End
          Else
          Begin
            Text := Text + ' AND ((FDO_DTBXSE IS NULL) OR (FDO_QTDSEP IS NULL) OR (FDO_QTDSEP < FDO_QTDITE)) ';

            Text := StringReplace(Text, '<<QTDSEP>>', 'FDO_QTDITE', [rfReplaceAll]);

            ParamByName('AUTINC').AsString   := fField('AUTINC').AsString;
            ParamByName('OPBXSE').AsString   := strOpeBai;
            ParamByName('DTBXSE').AsDateTime := VS_Date;
            ParamByName('HRBXSE').AsDateTime := fTime();

            Text := f_SQL_FATDOR_para_MOVDET(Text);
            ExecSQL;
          End;

          Destroy;
          FreeAndNil(cdsItensSep);
        End;
      End;
    End;


    //realiza a transferência para a Localização Transitória e altera a lotdor do pedido
    if fCfgSis('ESTTRA', varBoolean) then
    begin

      objTransferenciaLotesTransitoria := TTransferenciaLotesTransitoria.Create;
      try

        objTransferenciaLotesTransitoria.strAutoincremFATGOR       := fField('AUTINC').AsString;
        objTransferenciaLotesTransitoria.strCodigoLocalSeparacao   := fGetCodigoLocSep();

        if not objTransferenciaLotesTransitoria.fTransfereLotes(strCodigoLocalizacaoFisicaTransitoria) then
        begin
          pMensagemOK('Não foi possível processar a localização física transitória, tente novamente!');
          exit();
        end;

      finally
        FreeAndNil(objTransferenciaLotesTransitoria);
      end;
    end;


    {***POR FIM, SERÁ REALIZADA A BAIXA DO PEDIDO PARA SEGUIR PARA EXPEDIÇÃO   ***}
    {***CASO UTILIZE O FILTRO POR LOCAL DE SEPARAÇÃO, SOMENTE REALIZARÁ A BAIXA***}
    {***DO PEDIDO, SE TODOS OS ITENS ESTIVEREM LIBERADOS PARA SEUS RESPECTIVOS ***}
    {***LOCAIS                                                                 ***}

    If (fCfgSis('EXBXTO', varBoolean)) Then
    begin
      blnBaixaParaExpedicao := (fNaoUsaFiltroLocSep()) Or
                               (
                                (fUsaFiltroLocSep() Or ((fUsaFiltroLocSepTodos()) And (fPossuiLocSepPendente()))) And
                                (fTodosLocSepLiberados(fField('AUTINC').AsString, fField('ESPDOC').AsString))
                               );
    end
    else
      blnBaixaParaExpedicao := (fNaoUsaFiltroLocSep()) Or (fUsaFiltroLocSepTodos) Or ((fUsaFiltroLocSep()) And (fTodosLocSepLiberados(fField('AUTINC').AsString, fField('ESPDOC').AsString)));

    If blnBaixaParaExpedicao Then
    Begin
      With fCriaQuery, SQL Do 
      Begin
        Clear;

        Text := ' UPDATE EXTGOR, FATGOR         ' +
                '   SET FGO_OPBXSE = :OPBXSE,   ' +
                '       FGO_DTBXSE = :DTBXSE,   ' +
                '       FGO_HRBXSE = :HRBXSE    ' +
                ' WHERE FGO_SEQFGO = AUTOINCREM ' +
                '   AND AUTOINCREM = :INCGER    ';  

        If (fField('ESPDOC').AsString <> 'PD') Then
        Begin
          Text := AnsiReplaceStr(Text, 'FATGOR', 'MOVGER');
          Text := AnsiReplaceStr(Text, 'EXTGOR', 'AUXMOV');
          Text := AnsiReplaceStr(Text, 'FGO_SEQFGO', 'AUX_SEQGER');
          Text := AnsiReplaceStr(Text, 'FGO_', 'AUX_');
        End;

        ParamByName('INCGER').AsString   := fField('AUTINC').AsString;
        ParamByName('OPBXSE').AsString   := strOpeBai;
        ParamByName('DTBXSE').AsDateTime := VS_Date;
        ParamByName('HRBXSE').AsDateTime := fRetHoraServidor;

        ExecSQL;

        Destroy;
      End;

      if (fCfgSis('EXBXTO', varBoolean)) and (fNaoUsaFiltroLocSep()) Then
        pBaixaSeparacaoDosItens(fField('ESPDOC').AsString, fField('AUTINC').AsString, strOpeBai);

      pGravarHistoricoOcorrenciaBaixaSeparacao(fField('CODCLI').AsString,
                                                strOpeBai,
                                                fField('NUMDOC').AsString,
                                                fField('ESPDOC').AsString,
                                                fField('CODEMP').AsString);
    End;


    TUpdateStatus.New(TParamStatus.New()
                        .NumDoc(fField('NUMDOC').AsString)
                        .EspDoc(fField('ESPDOC').AsString)
                        .CodEmp(fField('CODEMP').AsString)).pExecute();

    pReprocessarPedidoFaturamentoAutomatico(fField('NUMDOC').AsString,
                                            fField('ESPDOC').AsString,
                                            fField('CODEMP').AsString);

    TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');
  End;

end;

procedure TfrmFatExpedicao.btnRecarrPedClick(Sender: TObject);
begin
  inherited;

  If fEmExpedicaoItens Then
    Exit;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  blnAtualizandoGrid := True;
  Try
    pLimparSelecaoELocks;
    TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos !', '');
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    blnAtualizandoGrid := False;
  End;
end;

procedure TfrmFatExpedicao.btnReimprimeDocumentoClick(Sender: TObject);
Var
    reiReimpressao: TReimpressao;
begin
  inherited;

  TEditorFastImpressao.strEmpresaLayout := cdsPedidos.FieldByName('CODEMP').AsString;
      try
        reiReimpressao := TReimpressao.Create(cdsPedidos.FieldByName('NUMDOC').AsString,
                                              cdsPedidos.FieldByName('ESPDOC').AsString,
                                              0,
                                              0,
                                              cdsPedidos.FieldByName('CODCLI').AsString,
                                              cdsPedidos.FieldByName('CODEMP').AsString,
                                              '',
                                              True,
                                              'C',
                                              True,
                                              False,
                                              False,
                                              '',
                                              '',
                                              False,
                                              0,
                                              False,
                                              cdsPedidos.FieldByName('ORIPED').AsString,
                                              False,
                                              False,
                                              '',
                                              '',
                                              True);
        reiReimpressao.pReimprimeDocumento;
      finally
        TEditorFastImpressao.strEmpresaLayout := '';
        FreeAndNil(reiReimpressao);
      end;

end;

procedure TfrmFatExpedicao.btnRevEmpFatClick(Sender: TObject);
begin
  inherited;
  If Not btnRevEmpFat.Visible Then
    Exit;

  If TFatReverterEmpresaFaturamentoPedido.New(VS_strCodEmp)
    .fReverterEmpresaFaturamentoPedido Then
  Begin
    pMensagemOk('Empresa de Faturamento do pedido foi revertida com sucesso!');
    btnRecarrPed.Click;
  End;
end;

procedure TfrmFatExpedicao.btnRobSepClick(Sender: TObject);
var
  strLockMonitorLotWMS: String;
begin
  inherited;

  pAtivaDesativaTimersNotificaoAndRecarga(False);

  Try
    If (Pos('suspender', LowerCase(btnRobSep.Caption)) > 0) Then
    Begin
      If Not fVerificaAcessoSistema('SUSROBSEP', strLoginUsuarioLogado) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Suspender Robô de Separação');

        objLiberacao.strDirAce := 'SUSROBSEP';
        objLiberacao.strMsgSen := 'Suspender Robô de Separação';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;

        If (Not objLiberacao.fLibera) Then
        Begin
          Exit;
        End;
      End;

      If TUtilMonitor.fLockMonitor(spIdMonitorLotWMS, strLockMonitorLotWMS, True) Then
      Begin
        btnRobSep.Caption := 'Habilitar Robô de Separação';
        lblRobSep.Visible := True;
      End;
    End
    Else
    Begin
      If TUtilMonitor.fRemoveLockMonitor(spIdMonitorLotWMS, True, True) Then
      Begin
        btnRobSep.Caption := 'Suspender Robô de Separação';
        lblRobSep.Visible := False;
      End;
    End;
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
  End;
end;

procedure TfrmFatExpedicao.btnSeparacaoClick(Sender: TObject);
begin
  inherited;
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
    popSeparacao.Popup(X, Y);

  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.btnSituacaoItensClick(Sender: TObject);
begin
  inherited;
  TFrmGravando.fExecutarModalA( pMostraSituacaoItens, 'Aguarde... Buscando situações dos itens !', '');
end;

procedure TfrmFatExpedicao.pDataChange(Sender: TObject; Field: TField);
begin
  If (Not blnScrollPedidos) Then
    Exit;

  If (cdsPedidos.ControlsDisabled) Then
    Exit;

  lblTotDocs.Caption := '0';

  If (cdsPedidos.Active) And (Not cdsPedidos.IsEmpty) Then
    lblTotDocs.Caption := cdsPedidos.RecordCount.ToString;
end;

procedure TfrmFatExpedicao.pDestruirClientDataSetPedidos;
begin
  If Assigned(cdsPedidos) Then
  Begin
    lblTotDocs.Caption := '0';
    dtsPedidos.DataSet := NIL;
    FreeAndNil(cdsPedidos);
  End;
end;

procedure TfrmFatExpedicao.pDrawColumnCell(dbgDados: TDBGridCitel; Column: TColumn; const Rect: TRect);
  Var
    strEntRet: String;
    idxLegenda: Integer;
begin
  If Column.FieldName = 'ENTRET' Then
  Begin
    With dbgDados.Canvas, Rect Do
    Begin
      strEntRet := fGetDescricaoEntRet(dbgDados.DataSource.DataSet.FieldByName('ENTRET').AsString, dbgDados.DataSource.DataSet.FieldByName('ESPDOC').AsString );
      FillRect(Rect);
      TextOut(Left + (Right - Left) div 2 - TextWidth(strEntRet) div 2, Top + 2, strEntRet);
    End;
  End;

  If Column.FieldName = 'SITFIN' Then
  Begin
    dbgDados.Canvas.FillRect(Rect);
    If dbgDados.DataSource.DataSet.FieldByName('SITFIN').AsString <> 'OK' Then
      imglSitFin.Draw(dbgDados.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 1)
    Else
      imglSitFin.Draw(dbgDados.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, 2);
  End;

  If Column.FieldName = 'SEQDMP' Then
  Begin
    dbgDados.Canvas.FillRect(Rect);
    If fEmptyStr(dbgDados.DataSource.DataSet.FieldByName('SEQDMP').AsString) Then
      imglSeqDmp.Draw(dbgDados.Canvas, Rect.Left + ((Column.Width - imglSeqDmp.Width) div 2), Rect.Top+1, 2)
    else
      imglSeqDmp.Draw(dbgDados.Canvas, Rect.Left + ((Column.Width - imglSeqDmp.Width) div 2), Rect.Top+1, 1);
  End;

  If Column.FieldName = 'STATUS' Then
  Begin
    dbgDados.Canvas.FillRect(Rect);
    Try
      If TSituacaoPedidoVenda.fRetornaLegenda.TryGetValue(dbgDados.DataSource.DataSet.FieldByName('FGO_STATUS').AsString, idxLegenda) Then
        frmModuloLegenda.imglLegenda.Draw(dbgDados.Canvas, Rect.Left + ((Column.Width - imglSitFin.Width) div 2), Rect.Top+1, idxLegenda);
    Except
      //
    End;
  End;

  If (Column.FieldName = 'EXPTOL') And (fExibirTempoExpedicao()) Then
  Begin
    dbgDados.Canvas.Brush.Color := fGetCorTempoAtrasoExpedicao();

    If (dbgDados.Canvas.Brush.Color = clLime) Then
      dbgDados.Canvas.Font.Color := clBlack;

    dbgDados.Canvas.FillRect(Rect);
    dbgDados.Canvas.TextOut(Rect.Left + 5, Rect.Top + 1, dbgDados.DataSource.DataSet.FieldByName('EXPTOL').AsString);
  End;

  If Column.FieldName = 'SITADT' Then
  Begin
    dbgDados.Canvas.FillRect(Rect);
    frmModuloLegenda.imglSitAdt.Draw(dbgDados.Canvas, Rect.Left +1, Rect.Top +1,
                                     AnsiIndexStr(fField('SITADT').AsString, ['Pendente', 'Parcialmente', 'Realizado']));
    dbgDados.Canvas.TextOut(Rect.Left + frmModuloLegenda.imglSitAdt.Width +5, Rect.Top +1, fField('SITADT').AsString);
  End;

  If Column.FieldName.Equals('DOCFAT') And blnExibirPedidosFaturamentoAutomatico Then
  Begin
    If fField('FATAUT').AsString.Equals('S') And (fGetNFeStatusImageIndex(fField('NFESTA').AsString) >= 0) Then
    Begin
      dbgDados.Canvas.FillRect(Rect);
      imglNFeSta.Draw(dbgDados.Canvas, Rect.Left +1, Rect.Top +1,
                      fGetNFeStatusImageIndex(fField('NFESTA').AsString));
      dbgDados.Canvas.TextOut(Rect.Left + imglNFeSta.Width +5, Rect.Top +1, fField('DOCFAT').AsString);
    End;
  End;
end;

function TfrmFatExpedicao.fGetNFeStatusImageIndex(AStatus: String): Integer;
begin
  If AStatus = 'AT' Then
    Exit(0);

  If AStatus = 'CN' Then
    Exit(1);

  If AStatus = 'GE' Then
    Exit(2);

  If AStatus = 'GC' Then
    Exit(5);

  If AStatus = 'EE' Then
    Exit(4);

  If AStatus = 'EC' Then
    Exit(3);

  If AStatus = 'DN' Then
    Exit(6);

  If AStatus = 'IN' Then
    Exit(7);

  If AStatus = 'DC' Then
    Exit(8);

  If AStatus = 'GM' Then
    Exit(10);

  If AStatus = 'AM' Then
    Exit(11);

  If AStatus = 'EM' Then
    Exit(9);

  If AStatus = 'CM' Then
    Exit(3);

  If AStatus = 'DP' Then
    Exit(12);

  If AStatus = 'AE' Then
    Exit(2);

  If AStatus = 'AC' Then
    Exit(11);

  If AStatus = 'CE' Then
    Exit(9);

  If AStatus = 'CG' Then
    Exit(10);

  If AStatus = 'CC' Then
    Exit(3);

  Result := -1;
end;

function TfrmFatExpedicao.fBaixaOrdemProducaoAutomaticamente: Boolean;
var
  blnEmitirOrdemProdSubItensNoPedido: boolean;
begin
  blnEmitirOrdemProdSubItensNoPedido := fCfgSis('EMOPPD',varBoolean);

  Result := (Not blnEmitirOrdemProdSubItensNoPedido) Or
            ((blnEmitirOrdemProdSubItensNoPedido) And (fCfgSis('BXOPAT', varBoolean)) And
            ((fCfgSis('BXSBIT', varString) = '2') Or ((fCfgSis('BXSBIT', varString) = '3') And fEhMarketPlace)));
end;

function TfrmFatExpedicao.fBaixarOndaSeparacao(pgbStatus: TcxProgressBar): Boolean;
var
  strOpeBai   : String;
  strSQLUpd   : String;
  intContador : Integer;
  intEtapa    : Integer;
  qryOnda     : TUniQuery;
begin

  Result    := False;
  strOpeBai := fPedeSenhaOperador('Senha do operador da baixa');

  If Not fEmptyStr(strOpeBai) Then
  Begin

    strSQLUpd := ' UPDATE EXTGOR, FATGOR         ' +
                 '   SET FGO_OPBXSE = :OPBXSE,   ' +
                 '       FGO_DTBXSE = :DTBXSE,   ' +
                 '       FGO_HRBXSE = :HRBXSE    ' +
                 ' WHERE FGO_SEQFGO = AUTOINCREM ' +
                 '   AND AUTOINCREM = :INCGER    ';

    qryOnda := fCriaQuery;

    Try

      fStartTransaction;

      Try

        intEtapa  := 0;
        pInformacao('Aguarde... Baixando pedidos da onda de separação!', pgbStatus);

        For intContador := 0 to dbgPedidos.SelectedRows.Count - 1 Do
        Begin

          dtsPedidos.DataSet.GotoBookmark(dbgPedidos.SelectedRows.Items[intContador]);

          qryOnda.Close;
          qryOnda.SQL.Clear;

          If (fField('ESPDOC').AsString <> 'PD') Then
          Begin
            strSQLUpd := AnsiReplaceStr(strSQLUpd, 'FATGOR'     , 'MOVGER');
            strSQLUpd := AnsiReplaceStr(strSQLUpd, 'EXTGOR'     , 'AUXMOV');
            strSQLUpd := AnsiReplaceStr(strSQLUpd, 'FGO_SEQFGO' , 'AUX_SEQGER');
            strSQLUpd := AnsiReplaceStr(strSQLUpd, 'FGO_'       , 'AUX_');
          End;

          qryOnda.SQL.Add(strSQLUpd);
          qryOnda.ParamByName('INCGER').AsString   := fField('AUTINC').AsString;
          qryOnda.ParamByName('OPBXSE').AsString   := strOpeBai;
          qryOnda.ParamByName('DTBXSE').AsDateTime := VS_Date;
          qryOnda.ParamByName('HRBXSE').AsDateTime := fRetHoraServidor;

          qryOnda.ExecSQL;

          TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(fField('NUMDOC').AsString)
                              .EspDoc(fField('ESPDOC').AsString)
                              .CodEmp(fField('CODEMP').AsString)).pExecute();

          pReprocessarPedidoFaturamentoAutomatico(fField('NUMDOC').AsString,
                                                  fField('ESPDOC').AsString,
                                                  fField('CODEMP').AsString);

          pProgresso(fInc(intEtapa), dbgPedidos.SelectedRows.Count, pgbStatus);

        End;

        fCommit;
        Result := True;

      Except

        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.message, 'TfrmFatExpedicao.fBaixarOndaSeparacao');
        End;

      End;

    Finally
      FreeAndNil(qryOnda);
    End;

  End;

end;

procedure TfrmFatExpedicao.pCarregaItensParaGerarTL(var AQry: TUniQuery);
const
  SQL_LOTDOR = 'SELECT FDO_NUMDOC NUMDOC, FDO_ESPDOC ESPDOC, FDO_CODEMP CODEMP, FDO_CODCLI CODCLI, FDO_CODITE CODITE, ' +
               '  LDO_QTDSEP QTDITE, LDO_NUMLOT NUMLOT, FDO_NUMFAT NUMFAT, FDO_TIPFAT TIPFAT, FDO_EMPFAT EMPFAT ' +
               'FROM FATDOR F ' +
               'INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = F.AUTOINCREM) ' +
               'WHERE FDO_SEQGER = :SEQGER ';

  SQL_MOVDET = 'SELECT FGO_NUMDOC NUMDOC, FGO_ESPDOC ESPDOC, FGO_CODEMP CODEMP, FGO_CODCLI CODCLI, DET_CODITE CODITE, ' +
               '  DET_QTDITE QTDITE, DET_NUMLOT NUMLOT, FGO_NUMFAT NUMFAT, FGO_TIPFAT TIPFAT, FGO_EMPFAT EMPFAT ' +
               'FROM MOVDET D ' +
               'INNER JOIN FATGOR F ON (DET_NUM_PD = FGO_NUMDOC AND DET_ESP_PD = FGO_ESPDOC AND DET_EMP_PD = FGO_CODEMP) ' +
               'WHERE IFNULL(DET_NUMLOT, "") <> "" ' +
               '  AND DET_NUMLOT <> "A DEFINIR" ' +
               '  AND F.AUTOINCREM = :SEQGER ';

  SQL_DET_TL = 'SELECT FGO_NUMDOC NUMDOC, FGO_ESPDOC ESPDOC, FGO_CODEMP CODEMP, FGO_CODCLI CODCLI, T.DET_CODITE CODITE, ' +
               '  T.DET_QTDITE QTDITE, T.DET_NUMLOT NUMLOT, FGO_NUMFAT NUMFAT, FGO_TIPFAT TIPFAT, FGO_EMPFAT EMPFAT ' +
               'FROM MOVDET D ' +
               'INNER JOIN FATGOR F ON (D.DET_NUM_PD = FGO_NUMDOC AND D.DET_ESP_PD = FGO_ESPDOC AND D.DET_EMP_PD = FGO_CODEMP) ' +
               'INNER JOIN MOVDET T ON (D.DET_NUMDOC = T.DET_NUMFAT AND D.DET_ESPDOC = T.DET_TIPFAT AND D.DET_CODEMP = T.DET_EMPFAT) ' +
               'WHERE T.DET_CLAFIS = "5999" ' +
               '  AND F.AUTOINCREM = :SEQGER ' +
               'GROUP BY T.AUTOINCREM ';
begin
  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Text := SQL_LOTDOR;
  AQry.ParamByName('SEQGER').AsString := fField('AUTINC').AsString;
  AQry.Open;

  if (not AQry.IsEmpty) then
    Exit;

  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Text := SQL_MOVDET;
  AQry.ParamByName('SEQGER').AsString := fField('AUTINC').AsString;
  AQry.Open;

  if (not AQry.IsEmpty) then
    Exit;

  AQry.Close;
  AQry.SQL.Clear;
  AQry.SQL.Text := SQL_DET_TL;
  AQry.ParamByName('SEQGER').AsString := fField('AUTINC').AsString;
  AQry.Open;
end;

function TfrmFatExpedicao.fCortePedidosMarketplaceSemSaldo(AEhOndaSeparacao: Boolean = True): Boolean;
var
  LMotCorte, LItem: String;
  LLibExt: TLibExt;
  FQryIte,
  FQryQTD,
  FLastPD: TUniQuery;
  LSalDis: TRecSalDis;
  LVlrSalDis: Double;
  LSomenteMarketPlace: Boolean;

  procedure pAbreQueryItensQtd;
  begin
    FQryQTD.Close;
    FQryQTD.SQL.Clear;
    FQryQTD.SQL.Add('SELECT SUM(FDO_QTDITE - FDO_QTDBAI) AS QTDITE ');
    FQryQTD.SQL.Add('FROM FATDOR ');
    FQryQTD.SQL.Add('WHERE FDO_SEQGER IN (' + FListaPDMarketPlace.CommaText + ') ');
    FQryQTD.SQL.Add('  AND FDO_CODITE = :CODITE ');
    FQryQTD.SQL.Add('GROUP BY FDO_CODITE ');
    FQryQTD.ParamByName('CODITE').AsString := FQryIte.FieldByName('CODITE').AsString;
    FQryQTD.Open;
  end;

  procedure pDesmarcaPedido;
  var
    LIndex: Integer;
  begin
    LIndex := stlPedidos.IndexOf(FLastPD.FieldByName('AUTOINCREM').AsString);
    if (LIndex >= 0) then
      stlPedidos.Delete(LIndex);

    LIndex := FListaPDMarketPlace.IndexOf(FLastPD.FieldByName('AUTOINCREM').AsString);
    if (LIndex >= 0) then
      FListaPDMarketPlace.Delete(LIndex);

    if dtsPedidos.DataSet.Locate('AUTINC', FLastPD.FieldByName('AUTOINCREM').AsString, []) then
      dbgPedidos.SelectedRows.CurrentRowSelected := False;
  end;
begin
  Result := True;

  if (not fCfgSis('OSEVSL', varBoolean)) then
    Exit;

  FQryIte := fCriaQuery;
  FQryQTD := fCriaQuery;
  FLastPD := fCriaQuery;

  try
    if (not fValidaTemPedidosIntegracao(LSomenteMarketPlace)) then
      Exit;

    if (not LSomenteMarketPlace) then
    begin
      pMensagemOk('Não é possível prosseguir pois há pedidos que não são marketplace selecionados junto com pedidos de marketplace!');
      Exit(False);
    end;

    FQryIte.SQL.Add('SELECT FDO_CODITE CODITE ');
    FQryIte.SQL.Add('FROM FATDOR ');
    FQryIte.SQL.Add('WHERE FDO_SEQGER IN (' + FListaPDMarketPlace.CommaText + ') ');
    FQryIte.SQL.Add('GROUP BY FDO_CODITE ');
    FQryIte.Open;

    FQryIte.First;

    while not FQryIte.Eof do
    begin
      if (FListaPDMarketPlace.Count = 0) then
        Break;

      pAbreQueryItensQtd;

      if FQryQTD.IsEmpty then
      begin
        FQryIte.Next;
        Continue;
      end;

      while (not TemSaldoDisponivel(FQryIte.FieldByName('CODITE').AsString,
                                    FQryQTD.FieldByName('QTDITE').AsFloat,
                                    LSalDis)) do
      begin
        try
          LVlrSalDis := (LSalDis.fltSalDis - LSalDis.fltQtdOnd);
          LItem := FQryIte.FieldByName('CODITE').AsString + ' - ' + fRetNomProduto(FQryIte.FieldByName('CODITE').AsString);

          if (not FItensSemSaldoDispParaAtenderPDOnda.Text.Contains(LItem)) then
            FItensSemSaldoDispParaAtenderPDOnda.Add(LItem +
              ' - Qtd. Necessária: '+ FormatFloat(fMskDigitos(FDecQtd), FQryQTD.FieldByName('QTDITE').AsFloat) +
              ' - Qtd. Disponível: '+ FormatFloat(fMskDigitos(FDecQtd), LVlrSalDis));

          FLastPD.Close;
          FLastPD.SQL.Clear;
          FLastPD.SQL.Add('SELECT FDO_SEQGER AUTOINCREM, FDO_NUMDOC, FDO_ESPDOC, FDO_CODEMP ');
          FLastPD.SQL.Add('FROM FATDOR ');
          FLastPD.SQL.Add('WHERE FDO_SEQGER IN (' + FListaPDMarketPlace.CommaText + ') ');
          FLastPD.SQL.Add('  AND FDO_CODITE = :CODITE ');
          FLastPD.SQL.Add('ORDER BY FDO_DTAENT, FDO_HORENT ');
          FLastPD.SQL.Add('LIMIT 1 ');
          FLastPD.ParamByName('CODITE').AsString := FQryIte.FieldByName('CODITE').AsString;
          FLastPD.Open;

          FPedidosCortados.Add(FLastPD.FieldByName('FDO_NUMDOC').AsString +'-'+
                               FLastPD.FieldByName('FDO_ESPDOC').AsString +'-'+
                               FLastPD.FieldByName('FDO_CODEMP').AsString);

          LMotCorte := 'Qtde necessária PD...: '+ FormatFloat(fMskDigitos(FDecQtd), FQryQTD.FieldByName('QTDITE').AsFloat) + sLineBreak +
                       'Saldo disponível item: '+ FormatFloat(fMskDigitos(FDecQtd), LSalDis.fltSalDis) + sLineBreak +
                       IIF(fUsaOndaSeparacaoAgrupamento,
                       'Remessas em aberto...: '+ FormatFloat(fMskDigitos(FDecQtd), LSalDis.fltQtdOnd) +
                                                  IIF(not LSalDis.strSeqOnd.IsEmpty, ' (' + LSalDis.strSeqOnd + ')', '') + sLineBreak, '') +
                       '---------------------- '+ sLineBreak +
                       'Total disponível.....: '+ FormatFloat(fMskDigitos(FDecQtd), LVlrSalDis) +
                                              ' (Saldo disponível item - Remessas em aberto)';

          pDesmarcaPedido;

          fStartTransaction;

          if fCfgSis('LIBEXT', varBoolean) then
          begin
            //volta para a liberação de pedidos externos, com motivo de bloqueio
            LLibExt := TLibExt.Create(nil,
                                      FLastPD.FieldByName('FDO_NUMDOC').AsString,
                                      FLastPD.FieldByName('FDO_ESPDOC').AsString,
                                      FLastPD.FieldByName('FDO_CODEMP').AsString);
            try
              if not fEmptyStr(LLibExt.strOpeLib) then
                LLibExt.pLimparLiberacao;

              LLibExt.blnOndBlo := True;
              LLibExt.strOpeBlo := strLoginUsuarioLogado;
              LLibExt.strMotBlo := RetMotivoBloqueio(FQryIte.FieldByName('CODITE').AsString,
                                                     FLastPD.FieldByName('FDO_CODEMP').AsString) + sLineBreak + LMotCorte;
              LLibExt.pBloquear;
            finally
              FreeAndNil(LLibExt);
            end;
          end
          else if fCfgSis('LIBPED', varBoolean) then
            pRemoveLiberacaoPD(FLastPD.FieldByName('AUTOINCREM').AsString, LMotCorte);

          fCommit;
        except
          on E: Exception do
          begin
            fRollback;
            pMensagensErro('Não foi possível desmarcar o pedido ' + FLastPD.FieldByName('FDO_NUMDOC').AsString + '.' + E.Message,
              '[frmFatExpedicao.fCortePedidosMarketplaceSemSaldo');
            Exit(False);
          end;
        end;

        if (FListaPDMarketPlace.Count = 0) then
          Break;

        pAbreQueryItensQtd;

        if FQryQTD.IsEmpty then
          Break;
      end;

      FQryIte.Next;
    end;

    Result := (dbgPedidos.SelectedRows.Count > 0);

    if (FPedidosCortados.Count > 0) then
      pExibePedidosIntegracaoSemSaldoDisp(AEhOndaSeparacao);
  finally
    FreeAndNil(FQryIte);
    FreeAndNil(FQryQTD);
    FreeAndNil(FLastPD);
  end;
end;

function TfrmFatExpedicao.fCriarArrItensExpedidosPedido(strSeqGer: String;
  blnPreencheQtdDesmembramento: Boolean = True): TItensExpedidosPedido;
  Var
    qryItens : TUniQuery;
    arrItensExpedidosPedido: TItensExpedidosPedido;

  Const
    SQL_ITENS = 'SELECT ' +
                '  FATDOR.AUTOINCREM AS AUTINC, ' +
                '  FDO_CODITE AS CODITE, ' +
                '  FDO_QTDITE AS QTDITE, ' +
                '  FDO_QTDEXP AS QTDEXP, ' +
                '  (FDO_QTDITE - FDO_QTDEXP) AS QTDDES ' +
                'FROM ' +
                '  FATGOR ' +
                '  INNER JOIN FATDOR ' +
                '    ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ' +
                '  INNER JOIN EXTDOR ' +
                '    ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ' +
                'WHERE FATGOR.AUTOINCREM = :SEQGER ';

  function fIdx: Integer; begin
    Result := Length(arrItensExpedidosPedido) - 1;
  end;
begin
  Try
    SetLength(arrItensExpedidosPedido, 0);
    qryItens := fCriaQuery(Self);

    Try
      qryItens.Close();
      qryItens.SQL.Clear();
      qryItens.SQL.Add(SQL_ITENS);
      qryItens.ParamByName('SEQGER').AsString := strSeqGer;
      qryItens.Open();

      If (Not qryItens.IsEmpty) Then Begin
        qryItens.Filtered := False;
        qryItens.Filter   := '(QTDEXP < QTDITE) AND (QTDDES > 0)';
        qryItens.Filtered := True;

        If (Not qryItens.IsEmpty) Then Begin
          qryItens.First();

          While (Not qryItens.Eof) Do Begin
            SetLength(arrItensExpedidosPedido, Length(arrItensExpedidosPedido) + 1);

            arrItensExpedidosPedido[fIdx()].strSeqIte := qryItens.FieldByName('AUTINC').AsString;
            arrItensExpedidosPedido[fIdx()].strCodIte := qryItens.FieldByName('CODITE').AsString;
            arrItensExpedidosPedido[fIdx()].fltQtdIte := qryItens.FieldByName('QTDITE').AsFloat;
            arrItensExpedidosPedido[fIdx()].fltQtdExp := qryItens.FieldByName('QTDEXP').AsFloat;

            If (blnPreencheQtdDesmembramento) Then
              arrItensExpedidosPedido[fIdx()].fltQtdDes := qryItens.FieldByName('QTDDES').AsFloat
            Else
              arrItensExpedidosPedido[fIdx()].fltQtdDes := 0;

            qryItens.Next();
          End;
        End;

        qryItens.Filter   := '';
        qryItens.Filtered := False;
      End;

      Result := arrItensExpedidosPedido;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmFatExpedicao.pCriarArrItensExpedidosPedido]');
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

procedure TfrmFatExpedicao.pCriaBackUpPedidosSelecionados;
var
  objPedido: TObject;
  objPedidoVenda: TPedidoVenda;
  intContador: Integer;
  strAutInc: string;
begin
  if not Assigned(stlPedidosBkp) then
    Exit;

  stlPedidosBkp.Clear;

  For intContador := 0 To stlPedidos.Count-1 Do
  Begin
    If Assigned(stlPedidos.Objects[intContador]) Then
    Begin
      objPedido := stlPedidos.Objects[intContador];

      objPedidoVenda := TPedidoVenda.Create;
      objPedidoVenda.strNumDoc := TPedidoVenda(objPedido).strNumDoc;
      objPedidoVenda.strEspDoc := TPedidoVenda(objPedido).strEspDoc;
      objPedidoVenda.strCodEmp := TPedidoVenda(objPedido).strCodEmp;
      objPedidoVenda.strCodCli := TPedidoVenda(objPedido).strCodCli;
      objPedidoVenda.strEmpExp := TPedidoVenda(objPedido).strEmpExp;
      objPedidoVenda.strCodFaz := TPedidoVenda(objPedido).strCodFaz;
      objPedidoVenda.strCodEmb :=  TPedidoVenda(objPedido).strCodEmb;

      strAutInc := fCampoTabela('AUTOINCREM','FATGOR',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP','FGO_CODCLI'],[objPedidoVenda.strNumDoc,objPedidoVenda.strEspDoc,objPedidoVenda.strCodEmp,objPedidoVenda.strCodCli],False);

      objPedidoVenda.strSeqGer := strAutInc;
      stlPedidosBkp.AddObject(strAutInc, objPedidoVenda);
    End;
  End;

end;

procedure TfrmFatExpedicao.pCriarClientDataSetPedidos(const qryPedidos: TUniQuery);
begin
  pDestruirClientDataSetPedidos;
  cdsPedidos := fCriaClientDatset(qryPedidos);
  cdsPedidos.AfterScroll  := cdsPedidosAfterScroll;
  dtsPedidos.DataSet      := cdsPedidos;
  dtsPedidos.OnDataChange := pDataChange;
end;

procedure TfrmFatExpedicao.pCriarColunasGridExpedicao;
begin
  With dbgPedidos.Columns.Add Do
  Begin
    Expanded      := False;
    FieldName     := 'DTENTR';
    Title.Caption := 'Data Entrega';
    Visible       := True;
    Width         := 69;
  End;
  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    If (fCfgSis('EXITUR', VarString) = 'S') Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'TURENT';
        Title.Caption := 'Turno';
        Visible       := True;
        Width         := 64;
      End;
    End;

    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'FRECOT';
      Title.Caption := 'Frete Sugerido';
      Visible       := True;
      Width         := 80;
    End;

    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'FRESUG';
      Title.Caption := 'Frete Cotado';
      Visible       := True;
      Width         := 80;
    End;

  End
  Else
  Begin
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'PEDPAR';
      Title.Caption := 'Fat.';
      Visible       := True;
      Width         := 21;
    End;
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'SITFIN';
      Title.Caption := 'Sit.Financ.';
      Visible       := True;
      Width         := 52;
    End;
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'SEQDMP';
      Title.Caption := 'Pedido Vinculado?';
      Visible       := True;
      Width         := 52;
    End;
    If fCfgSis('CLILOJ', varBoolean) Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Alignment       := taCenter;
        Expanded        := False;
        FieldName       := 'CLILOJ';
        Title.Caption   := 'Cliente está na loja?';
        Title.Alignment := taCenter;
        Visible         := True;
        Width           := 110;
      End;
    End;
    With dbgPedidos.Columns.Add Do
    Begin
      Alignment     := taCenter;
      Expanded      := False;
      FieldName     := 'ENTURG';
      Title.Caption := 'Urgente';
      Title.Alignment := taCenter;
      Visible       := True;
      Width         := 42;
    End;
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'ORDPRO';
      Title.Caption := 'O.P.';
      Title.Alignment := taCenter;
      Visible       := True;
      Width         := 56;
    End;
    If (fCfgSis('TIPATE', varBoolean)) And (fCfgSis('PEDTPA', varBoolean)) Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'DESTPA';
        Title.Caption := 'Tipo Atendimento';
        Visible       := True;
        Width         := 90;
      End;
    End;
  End;

  If ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) Then
  Begin
    If fCfgSis('OPEDES', varBoolean) Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'OPEDES';
        Title.Caption := 'Ope. Desig.';
        Visible       := True;
        Width         := 60;
      End;
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'OPDENO';
        Title.Caption := 'Operador Designado';
        Visible       := True;
        Width         := 135;
      End;
    End;
    If (fCfgSis('TPDCEX') = '1')  Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'FTIPPED';
        Title.Caption := 'Tipo Faturamento';
        Visible       := False;
        Width         := 135;
      End;
    End;

    If fUtilizaSolicitacaoSeparador Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'CODSEP';
        Title.Caption := 'Sep.';
        Title.Alignment := taCenter;
        Visible       := True;
        Width         := 25;
      End;
    End;

    If (fCfgSis('BXLCSP', varString) = 'S') Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'TMPEXP';
        Title.Caption := 'Tempo Exp.';
        Visible       := True;
        Width         := 60;
      End;

      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'EXPTOL';
        Title.Caption := 'Atraso';
        Title.Alignment := taCenter;
        Visible       := True;
        Width         := 37;
      End;
    End;

    With dbgPedidos.Columns.Add Do
    Begin
      Alignment     := taCenter;
      Expanded      := False;
      FieldName     := 'PREVIS';
      Title.Caption := 'Data Previsão';
      Visible       := True;
      Width         := 154;
    End;

    if fCfgSis('BOXWMS', varBoolean) Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'CODBOX';
        Title.Caption := 'Box';
        Visible       := True;
        Width         := 54;
      End;
    End;

    If fCfgSis('EXISTA', varBoolean) Then
    Begin
      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'STATUS';
        Title.Caption := 'Status';
        Visible       := True;
        Width         := 52;
      End;

      With dbgPedidos.Columns.Add Do
      Begin
        Expanded      := False;
        FieldName     := 'FGO_STATUS';
        Title.Caption := 'Status do Pedido';
        Visible       := True;
        Width         := 150;
      End;

      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'AGSEPA';
        Title.Caption := 'Liberado para Expedição';
        Visible       := True;
        Width         := 78;
      End;

      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'INISEP';
        Title.Caption := 'Início da Separação';
        Visible       := True;
        Width         := 78;
      End;

      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'AGFATU';
        Title.Caption := 'Baixa da Separação';
        Visible       := True;
        Width         := 78;
      End;
    End;

    if (fCfgSis('CONEQU') = 'S') then
    begin
      With dbgPedidos.Columns.Add Do
      Begin
        Alignment     := taCenter;
        Expanded      := False;
        FieldName     := 'NUMOSE';
        Title.Caption := 'Número da OS';
        Visible       := False;
        Width         := 78;
      End;
    end;

    With dbgPedidos.Columns.Add Do
    Begin
      Alignment     := taCenter;
      Expanded      := False;
      FieldName     := 'DTDIEN';
      Title.Caption := 'Data Disponível Envio';
      Visible       := False;
      Width         := 70;
    End;

    With dbgPedidos.Columns.Add Do
    Begin
      Alignment     := taCenter;
      Expanded      := False;
      FieldName     := 'DTLIEN';
      Title.Caption := 'Data Limite Envio';
      Visible       := False;
      Width         := 70;
    End;

    With dbgPedidos.Columns.Add Do
    Begin
      Alignment     := taCenter;
      Expanded      := False;
      FieldName     := 'DTCOAG';
      Title.Caption := 'Data Coleta Agendada';
      Visible       := False;
      Width         := 70;
    End;
  End;

  With dbgPedidos.Columns.Add Do
  Begin
    Expanded      := False;
    FieldName     := 'ORDCOR';
    Title.Caption := 'Seq. da Cor';
    Visible       := True;
    Width         := 0;
  End;

  If (fCfgSis('UTTRDP', varBoolean)) Then
  Begin
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'TRARDP';
      Title.Caption := 'Transp. Redespacho';
      Visible       := False;
      Width         := 78;
    End;
  End;

  if fUsaOndaSeparacaoAgrupamento then
  begin
    with dbgPedidos.Columns.Add do
    begin
      Expanded      := False;
      FieldName     := 'SEQOND';
      Title.Caption := 'Remessa de Separação';
      Visible       := False;
      Width         := 78;
    end;
  end;

  If (fCfgSis('EXQTIT', VarString) = 'S') Then
  Begin
    With dbgPedidos.Columns.Add Do
    Begin
      Expanded      := False;
      FieldName     := 'QTDSKU';
      Title.Caption := 'Qtde. SKU';
      Visible       := True;
      Width         := 80;
    End;
  End;
end;

procedure TfrmFatExpedicao.FormCreate(Sender: TObject);
begin
  inherited;

  intDecCub := fCfgSis('DECCUB', varInteger);
  FDecQtd := fCfgSis('DECQTD', varInteger);

  FApenasGeracaoDeRemessaDePedido := False;

  blnSolicitaTelaDeVolume := False;
  strBotaoAcionado := '';

  stlBarDocLocalizar := TStringList.Create;
  stlBarDocLocalizar.Sorted := True;
  stlBarDocLocalizar.Duplicates := dupIgnore;

  FDicBaiEntFut := TDictionary<String,String>.Create;
  objTemporariaPedidosExpedicao := TTemporariaPedidosExpedicao.Create;

  pCarregarCores();
  blnSomenteCliFil := False;
  blnEmExpedicaoItens := False;
  intSuspensaoTimersRecarga := 0;
  blnSenhaReimpressao := False;
  strFiltroLocFisAnterior := '';
  intQtdPro := 0;
  intPosicaoCds := 0;

  FiltroOnda       := fosNaoUtilizarOnda;
  blnPDExclusivamenteDeKits := False;
  strNumeroOnda    := '';
  intQtdPedOnda    := 0;
  intQtdProOndaDe  := 0;
  intQtdProOnda    := 0;
  fltPesoOndaDe    := 0;
  fltPesoOndaAte   := 0;
  blnSelPedOndaAut := False;
  blnOndaSeparacaoUnicoProduto   := False;
  blnOndaSeparacaoVariosProdutos := False;
  blnOndaSeparacaoPorPeso        := False;
  blnSemSeqSep     := False;
  blnPermiteExpedirPedidoAVistaCaixaFechado := False;

  FTipoImpSep  :=  tisNormal;

  intStatusPedidoHeight := grbStatusPedido.Height;

  lblExibirFiltroStatusPedidos.Caption := STR_FILTRO_STATUS_PEDIDO_OCULTAR;

  If (fUsaRotinaWMS And fConferenciaDepoisDaEntrada) Then
  Begin

    If Not(fUsaOndaSeparacaoExpedicao) Then
    Begin
      btnImpSep.ShowHint := True;
      btnImpSep.Hint := '[Ctrl + F6] para imprimir apenas o item selecionado sem escolher lotes' + #13 +
                        '[Shift + F6] para imprimir todos os registros não impressos do grid' + #13 +
                        '[Ctrl + Shift + F6] para reimprimir todo o sequencial de separação';
    End;

  End;

  pCriarModuloLegenda;

  pHabilitarBotaoFaturarOndaSeparacao;
  pHabilitarBotaoFaturarTodos;

  blnExecutandoFormCreate := True;
  blnAtualizandoGrid := False;
  objLock := TLock.Create;

  objTipoEntregaRetiraExpedicao := TTipoEntregaRetiraExpedicao.Create;

  Try

    // [DEFESA pAtualizarGrid] Detector com throttle silencioso (sem log):
    // 10 chamadas em <=10s ativam latch; gap de 30s sem chamadas libera.
    // Caller (pAtualizarGrid) aplica Sleep+continua para throttle com refresh.
    FAtualizarGridDetector := TMethodLoopDetector.Create(
      'TfrmFatExpedicao.pAtualizarGrid',
      10,        // ACallsThreshold
      10000,     // AWindowMs
      60000,     // ACooldownMs (irrelevante com ALogTrace=False)
      5,         // AMaxTracesPerSession (irrelevante com ALogTrace=False)
      30000,     // AGapToExitMitigationMs
      False);    // ALogTrace (sem log, mitigacao silenciosa imediata)

    pFiltrosEstoqueDefault;

    //S- Senha do separador / C- Código do separador / N - não solicitar separador
    strSenSep := fCfgSis('SENSEP', varString);

    If fEmptyStr(strSenSep) Then
      strSenSep := 'N';

    stlSeqFgo := TStringList.Create;
    cdsFilEst := TUniClientDataSet.Create(Self);

    objLiberacao := TLiberacao.Create;

    blnScrollPedidos := True;
    blnExecutandoFormShow := False;
    blnExpedicaoParcial := False;
    blnUsaImpressaoSeparacaoPorLocal := False;

    qryAdiantamentos := fCriaQuery;

    qryPedidosVinculados := fCriaQuery;
    qryPedidosVinculados.SQL.Text := fSqlPedidosVinculados;
    dtsPedidosVinculados.DataSet := qryPedidosVinculados;

    blnAutSer := FALSE;
    blnFecharForm := False;

    blnApenasImprimirBaixarSeparacao := False;
    blnApenasConferenciaProdutosRetiraCaixa := False;

    intSemaforoSelecionar := -1;
    intSemaforoAtualizar  := -1;
    FSemaforoLimparSeparacao := -1;

    qryDuplic          := fCriaQuery(Self);
    dtsDuplic.DataSet  := qryDuplic;
    qrySeqCon          := fCriaQuery(Self);
    qrySeqCon.SQL.Text := fSQLSeqCon;

    tipFiltroPedidoTransf := tfNao;
    If objTipoEntregaRetiraExpedicao.blnExiPedRetiraExpAntFat Then
    Begin
      If fCfgSis('SOPDTR', varString) = 'S' Then
        tipFiltroPedidoTransf := tfRetira
      Else If fCfgSis('SOPDTR', varString) = 'E' Then
        tipFiltroPedidoTransf := tfRetiraEEntrega;
    End;

    blnSepExp := fCfgSis('SEPEXF', varBoolean);

    lblDtaImpSep.Visible := fHabilitaImpSep;
    dbtxtDtImSe.Visible  := lblDtaImpSep.Visible;
    dbtxtHrImSe.Visible  := lblDtaImpSep.Visible;

    lblDtaBaiSep.Visible := fCfgSis('BAISEP', varBoolean);
    dbtxtDtBxSe.Visible  := lblDtaBaiSep.Visible;
    dbtxtHrBxSe.Visible  := lblDtaBaiSep.Visible;

    pCriarColunasGridExpedicao;
    TCfgColExp.pCarregarDadosSalvos(dbgPedidos);

    pInicializarFiltroStatusPedido();

    grbLocRet.Visible := (fCfgSis('LOCRET', varString) = 'S') and (MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]));
    pMontaFiltroLocalRetira;

    If fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO Then
      btnCliObs.Visible := True
    Else
      btnCliObs.Visible := False;

    btnConfirmaCupons.Visible := False;

    If (fCfgSis('LOCRET', varString) = 'S') And (fCfgSis('TFARET', varString) = 'C') And
       (fCfgSis('USACUP', varString) = 'S') And (fCfgSis('USNFCE', varString) = 'N') And
       (fCfgSis('PAFECF', varString) = 'N') And (Not fUsaSat) And (fCfgSis('TIPEXP') <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And
       (Not blnApenasImprimirBaixarSeparacao) And
       (Not blnApenasConferenciaProdutosRetiraCaixa) Then
    Begin
      btnConfirmaCupons.Visible := True;
    End;

    blnAltEmpFat := (fCfgSis('ENT_CD', varString) = 'S') And (fCfgSis('LOCRET', varString) = 'S') And
                    (fCfgSis('ALTEEX', varString) = 'S') And (fCfgSis('TIPEXP', varString) <> TIPEXP_POR_DOCUMENTO_DE_VENDA) And
                    (Not blnApenasImprimirBaixarSeparacao) And
                    (Not blnApenasConferenciaProdutosRetiraCaixa);

    blnF3 := False;

    shpGarantia.Visible := fCfgSis('GARMAT', varBoolean);
    lblGarantia.Visible := fCfgSis('GARMAT', varBoolean);
    blnUsaPafEcf        := fCfgSis('PAFECF', varBoolean);

    SetLength(arrLocSep, 0);

    rdgTipoDocumento.Visible   := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)
                                Or (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA)
                                Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);

    rdgTipoConferencia.Visible := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);

    pnlFilSitFin.Visible := (VS_strTipExp <> TIPEXP_POR_DOCUMENTO_DE_VENDA);
    pnlCliLoj.Visible    := fCfgSis('CLILOJ', varBoolean);
    gpbTipoExpedicao.Visible := (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO);
    pMontarOpcoesFiltro;

    btnImpOrdemProducao.Visible := fImprimeOrdemProducaoItemEstrutura;

    strEntRet := 'T';

    dbgPedidos.Font.Size := TCfgSugExp.fCarregaTAmanhoFonte('speTamanhoFonteConfigExpedicao');

    tfFiltroLocSepArmz := tfNenhum;

    if sender <>  frmFatExpedicao then
    begin
      blnApenasImprimirBaixarSeparacao := True;
      pInicializarFiltroLocSepArmazem(blnApenasImprimirBaixarSeparacao);
    end;

    fFindColumnByName(dbgPedidos,'NOMOPE').Visible := False;
    strUltimoPedidoRetiradaCaixa := '';
    btnMulSep.Visible := (fCfgSis('MULSEP', varString) = 'S') And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);

    strDescDoc := IIF(VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA, 'documento de venda', 'pedido');

    mnuLimparSeparacaoRomaneio.Visible := (fCfgSis('MULSEP', varString) = 'S') And fUsaRotinaWms;

    SetLength(arrLogLib, 0);

    blnExibeResumoExpedicao := ((fCfgSis('RESEXP', varString) = 'S') And (fCfgSis('TIPEXP', VarString) = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO));

    pnlResumoExpedicao.Visible := blnExibeResumoExpedicao;
    pCarrecaOpcaoOcultarInformacoes;

    btnAltSitPed.Visible := ((fCfgSis('FTEXPC', varString) = 'S') And (fCfgSis('EXPPAR', varString) = 'S'));

    FUtilizaOndaSeparacaoAgrupamento := False;
  Finally
    blnExecutandoFormCreate := False;
  End;

  blnVendaPerdidaAutomatica := False;
  blnTravarFiltroVendedor := False;
  FSeqSeparacaoParcial := 0;

  blnAtualizouGridNaImpressaoSeparacao := False;
  blnExisteAlgumFeriadoCadastrado := fExisteAlgumFeriadoCadastrado;

  btnConsProduto.Visible := fVerificaAcessoSistema('EXF5EXPED');
  pBuscaParametrosAutcom;

  rdgFiltroDataColeta.Visible := fCfgSis('FTDTCL', varBoolean) And
                                 MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO,
                                                         TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]);
end;

function TfrmFatExpedicao.fHabilitaImpSep : Boolean;
begin
  Result := False;

  If (fUsaRotinaWMS) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    Result := True;
    Exit;
  End;

  If (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Then
  Begin
    Result := True;
    Exit;
  End;

end;
procedure TfrmFatExpedicao.FormDestroy(Sender: TObject);
begin
  objTemporariaPedidosExpedicao.pApagarTemporaria(strUltimaTemporariaPedidosAbertoExpedicao);

  FreeAndNil(objLock);
  FreeAndNil(stlSeqFgo);
  FreeAndNil(cdsFilEst);
  FreeAndNil(objTipoEntregaRetiraExpedicao);

  FreeAndNil(objTemporariaPedidosExpedicao);

  FreeAndNil(FAtualizarGridDetector);

  If Assigned(qryAdiantamentos) Then
    FreeAndNil(qryAdiantamentos);

  If Assigned(qryPedidosVinculados) Then
    FreeAndNil(qryPedidosVinculados);

  inherited;
end;

procedure TfrmFatExpedicao.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmFatExpedicao.FormResize(Sender: TObject);
begin
  inherited;

  If (ParamCount > 0) And SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') Then
  Begin
    blnColetor             := True;
    pgcExpedicao.Visible   := False;
    btnConsProduto.Visible := False;
    btnImpSep.Visible      := False;
    btnFeriados.Visible    := False;
    btnRecarrPed.Visible   := False;
    btnCliObs.Visible      := False;
    btnFaturarExpedidos.Visible := False;

    dbgPedidos.OnDblClick := Nil;
  End;

  pAjustaAlturaPanelBotoes;

end;

function TfrmFatExpedicao.fValidaItemEspecial(const strEspDoc: String; const strTemItemEspecial : String): Boolean;
begin
  Result := False;
  If (Pos(strEspDoc, 'OR_PD_') > 0) And (Not fPermiteItemEspecial('VN')) Then
  Begin
    Result := (strTemItemEspecial = 'S');
    if (Result) then
      fMensagem('', 'Existem Itens Especiais no Orçamento/Pedido. Verifique!', ['&O k']);
    pnlInfo.Caption := '';
  End;
End;

function TfrmFatExpedicao.fValidaLocalRetiraAoSelecionarPedido(strNumDoc,
  strEspDoc, strCodEmp: String; blnExibirMensagem: Boolean = True): Boolean;
begin
  Result := True;
  If (strEspDoc = 'PD') And (fCfgSis('LOCRET', varString) = 'S') And (Not blnApenasConferenciaProdutosRetiraCaixa) Then
  Begin
    If fPedidoPossuiItensRetira(strNumDoc, strEspDoc, strCodEmp, 'C' {Local de Retira caixa}) And
       fPedidoPossuiItensRetira(strNumDoc, strEspDoc, strCodEmp, 'E' {Local de Retira Expedicao}) Then
    Begin
      If blnExibirMensagem Then
        pMensagemOk('Não é possível selecionar este pedido, ' +
                    'pois o mesmo possui itens de retira no caixa e expedição. ' +
                    'Será necessário passar no caixa para desmembrar este pedido!');
      Result := False;
    End
    Else If fPedidoPossuiItensRetira(strNumDoc, strEspDoc, strCodEmp, 'C' {Local de Retira caixa}) Then
    Begin
      If blnExibirMensagem Then
        pMensagemOk('Não é possível selecionar este pedido, ' +
                    'pois o mesmo possui itens de retira no caixa. ' +
                    'Será necessário passar no caixa para faturar e '+
                    'retirar os produtos deste pedido!');
      Result := False;
    End;
  End;
end;

function TfrmFatExpedicao.fValidarAbastecimentoEstoquePedido: Boolean;
  Var
    objValidarAbastecimento: TValidarAbastecimentoEstoqueDoPedido;
begin
  Result := True;
  If (fField('ESPDOC').AsString = 'PD') And (fCfgSis('OPSOAB') = '1') And (fCfgSis('SLTFRC', varString) = 'S') Then
  Begin
    Try
      objValidarAbastecimento := TValidarAbastecimentoEstoqueDoPedido.Create(
        fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString);

      If Not objValidarAbastecimento.fValidarTransferenciasDeEstoque Then
      Begin
        pMensagemOk(objValidarAbastecimento.strInconsistencia);
        Exit(False);
      End;

      If Not objValidarAbastecimento.fValidarRequisicoesDeCompra Then
      Begin
        if not fEmptyStr(objValidarAbastecimento.strInconsistencia) then
          pMensagemOk(objValidarAbastecimento.strInconsistencia);
        Exit(False);
      End;
    Finally
      FreeAndNil(objValidarAbastecimento);
    End;
  End;
end;

function TfrmFatExpedicao.fValidaRemessaSeparacao: Boolean;
var
  strAutIncPed: String;
  cdsClone: TZClient;
begin
  Result := True;

  if (not fUsaOndaSeparacaoAgrupamento()) then
    Exit;

  if fEmptyStr(fField('SEQSEP').AsString) then
    Exit;

  {Clona os dados}
  cdsClone := TZClient.Create(nil);
  pCloneDataSet(cdsClone, cdsPedidos);
  cdsClone.Filtered := False;

  try
    for strAutIncPed in stlPedidos do
    begin
      if cdsClone.Locate('AUTINC', strAutIncPed, []) then
      begin
        if (not RemesseDePedidoPertenceARemessaDeSeparacao(cdsClone.FieldByName('SEQSEP').AsString)) then
        begin
          Result := False;
          fMensagem('ATENÇÃO!', 'A Remessa de Separação do pedido ' + cdsClone.FieldByName('DOCUME').AsString + ' não foi gerada, não é possível utilizar rotina.', ['&Ok']);
          Exit;
        end
        else if (fField('TEMSEPDOR').AsString = 'N') then
        begin
          fMensagem('ATENÇÃO!', 'A Remessa de Separação do pedido ' + cdsClone.FieldByName('DOCUME').AsString + ' não foi finalizada, não é possível utilizar rotina.', ['&Ok']);
          Result := False;
          Exit;
        end;
      end;
    end;
  finally
    FreeAndNil(cdsClone);
  end;
end;

function TfrmFatExpedicao.fPedidoComFinanceiroOkComCaixaFechado: Boolean;
 Var
   fltValRec: Double;
   fltVlrCon: Double;
begin
  Result := True;

  If fField('FATAUT').AsString = 'S' Then
    fltValRec := fFormataFloat(fField('VALADT_FATAUT').AsFloat + fField('VALREC').AsFloat, 2)
  Else
    fltValRec := fFormataFloat(fField('VALADT').AsFloat + fField('VALREC').AsFloat, 2);


  fltVlrCon := fFormataFloat(fField('VLRCON').AsFloat - fField('TOTBRI').AsFloat, 2);

  If (fltValRec < fltVlrCon) Then
  Begin
    If (fltValRec = 0) Then
    Begin
      Result := False;
    End
    Else
    Begin
      If Abs(fltValRec - fltVlrCon) > TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL Then
      Begin
        Result := False;
      End;
    End;
  End;
end;

function TfrmFatExpedicao.fValidarPedidosClienteEstoqueExterno: Boolean;
Var
  strPedidos: String;
  strEstoqueExterno: String;
begin
  Result := True;
  strPedidos := '';

  If Not fCfgSis('ESTEXT', VarBoolean) Then
    Exit;

  pDisableControlsInterna;

  cdsPedidos.First;
  cdsPedidos.Filtered := False;

  While Not cdsPedidos.Eof Do
  Begin
    If fSelecionado(cdsPedidos) And
       Not TfatVenda.fValidarSeClienteEstoqueExternoPermiteFaturamento(fField('CODCLI').AsString, strEstoqueExterno) Then
    Begin
      pMensagemOk(Format('O pedido "%s-%s-%s" é do cliente do estoque externo "%s" e não pode ser faturado pelo Autcom!',
        [fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString, strEstoqueExterno]));
      Result := False;
      Break;
    End;
    cdsPedidos.Next;
  End;

  pFiltrarPedidos;
  pCalculaResumoTotalDocumentos();
  pEnableControlsInterna;
end;

function TfrmFatExpedicao.fValidarSitFinParaImpressaoSeparacao: Boolean;
begin
  Result := (MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]));

  If Result Then
  Begin
    //REQ.: 52325
    If (Not fCfgSis('EXPPAR', varBoolean)) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
      Exit(False);

    //REQ.: 82861
    If fCfgSis('SEPVIS', varBoolean) Then
      Exit(False);
  End;
end;

function TfrmFatExpedicao.fMostraDuplicatasPedidoExp: Boolean;
Begin
  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := fMostraDuplicatasPedido(qrySeqCon,
                                    qryDuplic,
                                    fField('NUMDOC').AsString,
                                    fField('ESPDOC').AsString,
                                    fField('CODEMP').AsString,
                                    fField('CODCLI').AsString);
End;

function TfrmFatExpedicao.fMostraAdiantamentosPedidoExp: Boolean;
  Var
    intField: Integer;
begin
  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := TAdiantamento.fCarregarAdiantamentos(fField('NUMDOC').AsString,
                                                 fField('ESPDOC').AsString,
                                                 fField('CODEMP').AsString,
                                                 fField('CODCLI').AsString,
                                                 qryAdiantamentos);

  If Result And Not qryAdiantamentos.IsEmpty Then
  Begin
    If Assigned(cdsAdiantamentos) Then FreeAndNil(cdsAdiantamentos);

    cdsAdiantamentos := fCriaClientDatSet(qryAdiantamentos);
    dtsAdiantamentos.DataSet := cdsAdiantamentos;

    With cdsAdiantamentos,
         TAdiantamento.fGetTotaisAdiantamento(FieldByName('NUMDOC').AsString,
                                              FieldByName('ESPDOC').AsString,
                                              FieldByName('CODEMP').AsString) Do
    Begin
      Append;
      FieldByName('DESCRI').AsString := TOTALIZACAO;
      FieldByName('VALDIN').AsFloat  := fltValDin;
      FieldByName('VALCHV').AsFloat  := fltValChV;
      FieldByName('VALCHP').AsFloat  := fltValChP;
      FieldByName('VALCAR').AsFloat  := fltValCar;
      FieldByName('VALORD').AsFloat  := fltValOrd;
      FieldByName('VALFIN').AsFloat  := fltValFin;
      FieldByName('VALCRE').AsFloat  := fltValCre;
      FieldByName('VALLAN').AsFloat  := fltValLan;
      Post;

      For intField := 0 To Fields.Count -1 Do
      Begin
        If Fields[intField].DataType = ftFloat Then
          TFloatField(Fields[intField]).DisplayFormat := '#,##0.00';
      End;

    End;
  End;

end;

function TfrmFatExpedicao.fPedidoLiberado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Add('SELECT SQL_NO_CACHE ');
    Add('  FGO_LIBERA, ');
    Add('  FGO_LIBCOM  ');
    Add('FROM ');
    Add('  FATGOR ');
    Add('WHERE ');
    Add('  FGO_NUMDOC = :NUMDOC AND ');
    Add('  FGO_ESPDOC = :ESPDOC AND ');
    Add('  FGO_CODEMP = :CODEMP ');

    ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
    ParamByName('CODEMP').AsString := fField('CODEMP').AsString;

    Open;

    Result := (FieldByName('FGO_LIBERA').AsInteger > 0) And
              (FieldByName('FGO_LIBCOM').AsInteger > 0);
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmFatExpedicao.pLimpaVariaveisSelecaoPedidos;
begin
  FTipoItemDoPedidoOndaSeparacao := TTipoItemDoPedidoExp.opItemInseridoNoPedido;
  strEmpSel := '';
  strCliSel := '';
  strFazSel := '';
  strEmbSel := '';
  strFpgSel := '';
  strCndSel := '';
  strCodSel := '';
  strVenSel := '';
  strVe2Sel := '';
  strCcrSel := '';
  strOprFlj := '';
  strTraSel := '';
  strIndSel := '';
  strTppSel := '';
  strPorSel := '';
  strTipSel := '';
  strBeFSel := '';
  strTemAdt := '';
  strBolAdt := '';
  strTemRec := '';
  blnGarSel := False;
  blnPedTra := False;
  dtaEmiSel := 0;
  strOriSel := '';
  strFatSel := '';
  strCfgENFUOPSel := '';
  strSolAbaSel := '';
  FblnTemPedidoDeConsignacao := False;
  blnFreRatSel := False;
  blnDecZfmSel := False;
  strRegEspSel := '';
  strUtiResSel := '';
  strTaxJurSel := '';
  strCotLal := '';

  pCarregarInformacoesPnlDocumentoSelecionados;
end;

procedure TfrmFatExpedicao.pFaturarPedidoOndaSeparacaoPeloProduto;
Var
  strCodigoItem: String;
  VS_strTipExpBkp: String;
begin
  Repeat

    If Not fOndaSeparacao Then
      Exit;

    If fEmptyStr(strNumeroOnda) Then
      Exit;

    If cdsPedidos.IsEmpty Then
      Exit;

    dbgPedidos.SelectedRows.Clear;

    pLimparSelecaoELocks;
    pLimpaVariaveisSelecaoPedidos;

    strCodigoItem := TfrmFatDigCodBarrasProduto.fDigCodBarrasProduto();

    If fEmptyStr(strCodigoItem) Then
      Exit;

    If Length(strCodigoItem) < fTamCodIte Then
      strCodigoItem := fStrZero(strCodigoItem, fTamCodIte);

    If Not fLocalizarPedidoOndaSeparacaoPeloCodigoDoProduto(strCodigoItem) Then
      Continue;

    VS_strTipExpBkp := VS_strTipExp;
    Try
      VS_strTipExp := TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO;

      If fField('FATAUT').AsString = 'S' Then
      Begin
        pSelecionaPedido(strCodigoItem);
      End
      Else
      Begin
        pSelecionaVariosPedidos();

        If fSelecionado(cdsPedidos) Then
          pExpedirPedidos(VS_strTipExp, False, strCodigoItem);
      End;

    Finally
      VS_strTipExp := VS_strTipExpBkp;
      pLimparSelecaoELocks;
      pLimpaVariaveisSelecaoPedidos;
    End;

  Until False;
end;

procedure TfrmFatExpedicao.pRetornaParaPedidoDoInicioDoProcesso;
begin
  cdsPedidos.DisableControls;
  cdsPedidos.Locate('CODEMP;NUMDOC;ESPDOC',VarArrayOf([strEmpresaDoPedido,strPedidoInicialDoProcesso,strEspecieDoPedido]), []);
  cdsPedidos.EnableControls;
end;

function TfrmFatExpedicao.fColunaVisivel(const strColuna: String): Boolean;
  Var
    Coluna : TColumn;
begin
  Result := True;

  Coluna := fFindColumnByName(dbgPedidos, strColuna);
  If (Coluna <> Nil) Then
    Result := Coluna.Visible;
end;

procedure TfrmFatExpedicao.pSintetizaItensImpressaoOndaSeparacao(strAutInc : String);
const
  FILTRO_FILA_SEP = '<<FILTRO_FILA_SEPARACAO>>';
var
  strDestino,
  strSQL: string;
  frmQckSintetizaItensSep : TfrmQckSintetizaItensSep;
  qryFilSep: TUniQuery;
begin

  strSQL := '';

  strAutInc := Trim(strAutInc);
  If (Pos(LeftStr(strAutInc, 1), '"_''''_') = 0) And (Pos(RightStr(strAutInc, 1), '"_''''_') = 0) Then
    strAutInc := QuotedStr(strAutInc);

  If (fUsaOndaSeparacaoExpedicaoWMS) And (fUsaRotinaWMS) Then
  Begin

    {Onda + WMS}
    strSQL := strSQL + 'SELECT FGO_SEQSEP, ';
    strSQL := strSQL + '       FDO_CODITE, ';
    strSQL := strSQL + '       FDO_DESCRI, ';
    strSQL := strSQL + '       FDO_UNIDAD, ';
    strSQL := strSQL + '       SUM(LDO_QTDITE) FDO_QTDITE, ';
    strSQL := strSQL + '       ITE_CODFAB, ';
    strSQL := strSQL + '       ITE_LOCFIS, ';
    strSQL := strSQL + '       OPE_NOMOPE, ';
    strSQL := strSQL + '       GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) SEPARATOR ", ") AS DOCUMENTOS, ';
    strSQL := strSQL + '       NSEPEX, ';
    strSQL := strSQL + '       LOCSUP, ';
    strSQL := strSQL + '       SALDOS, ';
    strSQL := strSQL + '       CURRENT_DATE AS DTAIMP, ';
    strSQL := strSQL + '       CURRENT_TIME AS HORIMP, ';
    strSQL := strSQL + '      (SELECT LPAD(COUNT(FGO_SEQSEP),4,''0'') ';
    strSQL := strSQL + '       FROM EXTGOR ';
    strSQL := strSQL + '       WHERE FGO_SEQSEP IN('+strAutInc+')) AS TOTPED, ';
    strSQL := strSQL + '       LDO_NUMLOT, ';
    strSQL := strSQL + '       LOT_LOCFIS, ';
    strSQL := strSQL + '       LOT_LOCSEP, ';
    strSQL := strSQL + '       BAR_CODBAR, ';
    strSQL := strSQL + '       ORI_DESORI, ';
    strSQL := strSQL + '       NUMPOK, ';
    strSQL := strSQL + '       TRA_NOMTRA AS TRANSPORTADORA ';
    strSQL := strSQL + '    , GROUP_CONCAT(DISTINCT CONS.CLI_NOMCLI SEPARATOR ", ") AS CLIENTE ';

    strSQL := strSQL + 'FROM( ';

    strSQL := strSQL + ' SELECT FGO_SEQSEP,   ';
    strSQL := strSQL + '        F.FDO_CODITE, ';
    strSQL := strSQL + '        F.FDO_DESCRI, ';
    strSQL := strSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
    strSQL := strSQL + '        F.FDO_QTDITE, ';
    strSQL := strSQL + '        C.ITE_CODFAB, ';
    strSQL := strSQL + '        I.ITE_LOCFIS, ';
    strSQL := strSQL + '        OP.OPE_NOMOPE, ';
    strSQL := strSQL + '        CONCAT('+QuotedStr(Self.strSeparador)+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
    strSQL := strSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
    strSQL := strSQL + '        I.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '        FDO_NUMDOC, ';
    strSQL := strSQL + '        FDO_ESPDOC, ';
    strSQL := strSQL + '        FDO_CODEMP, ';
    strSQL := strSQL + '        LDO_NUMLOT, ';
    strSQL := strSQL + '        CL.LOT_LOCFIS, ';
    strSQL := strSQL + '        CL.LOT_LOCSEP, ';
    strSQL := strSQL + '        LT.LDO_QTDITE, ';
    strSQL := strSQL + '        ORIFGO.ORI_DESORI,  ';

    strSQL := strSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
    strSQL := strSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
    strSQL := strSQL + '             ELSE ITE_CODBAR ';
    strSQL := strSQL + '        END AS BAR_CODBAR, ';
    strSQL := strSQL + '        G.FGO_NUMPOK AS NUMPOK, ';
    strSQL := strSQL + '        TRA_NOMTRA ';
    strSQL := strSQL + '     , CLI.CLI_NOMCLI  ';

    strSQL := strSQL + ' FROM FATDOR F ';
    strSQL := strSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
    strSQL := strSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
    strSQL := strSQL + '                          CL.LOT_CODEMP = F.FDO_CODEMP  AND ';
    strSQL := strSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
    strSQL := strSQL + ' INNER JOIN EXTGOR     ON FGO_SEQFGO    = F.FDO_SEQGER ';
    strSQL := strSQL + ' INNER JOIN CADITE C   ON F.FDO_CODITE  = C.ITE_CODITE ';
    strSQL := strSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE OP ON OPE_CODOPE     = G.FGO_CODVEN ';
    strSQL := strSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE  ';
    strSQL := strSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + Self.strSeparador + '" ';
    strSQL := strSQL + ' LEFT  JOIN ORIFGO     ON ORIFGO.ORI_CODORI = EXTGOR.FGO_CODORI  ';
    strSQL := strSQL + ' LEFT  JOIN EXTDOR     ON FDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' LEFT  JOIN CADTRA     ON TRA_CODTRA = G.FGO_CODTRA ';
    strSQL := strSQL + ' LEFT  JOIN CADCLI CLI  ON CLI.CLI_CODCLI = G.FGO_CODCLI ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

    strSQL := strSQL + ' WHERE FGO_SEQSEP IN('+strAutInc+') ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + '   AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) '
    Else
      strSQL := strSQL + '   AND FDO_JAFATU = 0 ';

    strSQL := strSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "N" ';

    strSQL := strSQL + ' ' + FILTRO_FILA_SEP + ' ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT FGO_SEQSEP,   ';
    strSQL := strSQL + '        C.ITE_CODITE AS FDO_CODITE, ';

    If fCfgSis('IMPREF', varBoolean) Then
    Begin
      If fCfgSis('MONDES', varInteger) = 1 Then
        strSQL := strSQL + '      TRIM(CONCAT(ITE_DESITE, " ", IFNULL(ITE_REFERE,""))) AS FDO_DESCRI, '
      Else
        strSQL := strSQL + '      TRIM(CONCAT(IFNULL(ITE_REFERE,""), " ", ITE_DESITE)) AS FDO_DESCRI, ';
    End
    Else
      strSQL := strSQL + '        ITE_DESITE AS FDO_DESCRI, ';

    strSQL := strSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
    strSQL := strSQL + '        (F.FDO_QTDITE * DMT_QTDITE) AS FDO_QTDITE, ';
    strSQL := strSQL + '        C.ITE_CODFAB, ';
    strSQL := strSQL + '        I.ITE_LOCFIS, ';
    strSQL := strSQL + '        OP.OPE_NOMOPE, ';
    strSQL := strSQL + '        CONCAT('+QuotedStr(Self.strSeparador)+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
    strSQL := strSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
    strSQL := strSQL + '        I.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '        FDO_NUMDOC, ';
    strSQL := strSQL + '        FDO_ESPDOC, ';
    strSQL := strSQL + '        FDO_CODEMP, ';
    strSQL := strSQL + '        LDO_NUMLOT, ';
    strSQL := strSQL + '        CL.LOT_LOCFIS, ';
    strSQL := strSQL + '        CL.LOT_LOCSEP, ';
    strSQL := strSQL + '        LT.LDO_QTDITE,  ';
    strSQL := strSQL + '        ORIFGO.ORI_DESORI,  ';

    strSQL := strSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
    strSQL := strSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
    strSQL := strSQL + '             ELSE ITE_CODBAR ';
    strSQL := strSQL + '        END AS BAR_CODBAR, ';
    strSQL := strSQL + '        G.FGO_NUMPOK AS NUMPOK, ';
    strSQL := strSQL + '        TRA_NOMTRA ';
    strSQL := strSQL + '     , CLI.CLI_NOMCLI ';

    strSQL := strSQL + ' FROM FATDOR F ';
    strSQL := strSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
    strSQL := strSQL + ' LEFT  JOIN LOTDOR LT  ON LT.LDO_SEQFDO = F.AUTOINCREM      ';
    strSQL := strSQL + ' LEFT  JOIN CADLOT CL  ON CL.LOT_NUMLOT = LT.LDO_NUMLOT AND ';
    strSQL := strSQL + '                          CL.LOT_CODEMP = F.FDO_CODEMP  AND ';
    strSQL := strSQL + '                          CL.LOT_CODITE = F.FDO_CODITE      ';
    strSQL := strSQL + ' INNER JOIN EXTGOR     ON FGO_SEQFGO    = F.FDO_SEQGER  ';
    strSQL := strSQL + ' INNER JOIN GERMAT GM  ON GMT_CODITE    = F.FDO_CODITE  ';
    strSQL := strSQL + ' INNER JOIN DETMAT DM  ON DMT_SEQGER    = GM.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN CADITE C   ON DMT_ITESUB    = C.ITE_CODITE  ';
    strSQL := strSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI  ';
    strSQL := strSQL + ' LEFT JOIN CADOPE OP   ON OPE_CODOPE    = G.FGO_CODVEN  ';
    strSQL := strSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE ';
    strSQL := strSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + Self.strSeparador + '" ';
    strSQL := strSQL + ' LEFT  JOIN ORIFGO     ON ORIFGO.ORI_CODORI = EXTGOR.FGO_CODORI  ';
    strSQL := strSQL + ' LEFT  JOIN EXTDOR     ON FDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' LEFT  JOIN CADTRA     ON TRA_CODTRA = G.FGO_CODTRA ';
    strSQL := strSQL + ' LEFT  JOIN CADCLI CLI  ON CLI.CLI_CODCLI = G.FGO_CODCLI ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

    strSQL := strSQL + ' WHERE FGO_SEQSEP IN('+strAutInc+') ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + '   AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) '
    Else
      strSQL := strSQL + '   AND FDO_JAFATU = 0 ';

    strSQL := strSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "S" ';

    strSQL := strSQL + ' ' + FILTRO_FILA_SEP + ' ';

    strSQL := strSQL + ') CONS ';
    strSQL := strSQL + ' GROUP BY FGO_SEQSEP, FDO_CODITE, FDO_DESCRI, FDO_UNIDAD, ITE_CODFAB, LDO_NUMLOT, LOT_LOCFIS';
    strSQL := strSQL + ' ORDER BY FGO_SEQSEP, LDO_NUMLOT, LOT_LOCFIS ';

  End
  Else
  Begin

    strSQL := strSQL + 'SELECT FGO_SEQSEP, ';
    strSQL := strSQL + '       FDO_CODITE, ';
    strSQL := strSQL + '       FDO_DESCRI, ';
    strSQL := strSQL + '       FDO_UNIDAD, ';
    strSQL := strSQL + '       SUM(FDO_QTDITE) FDO_QTDITE, ';
    strSQL := strSQL + '       ITE_CODFAB, ';
    strSQL := strSQL + '       ITE_LOCFIS, ';
    strSQL := strSQL + '       LSE_DESCRI, ';
    strSQL := strSQL + '       GROUP_CONCAT(DISTINCT CONCAT(FDO_NUMDOC, "-", FDO_ESPDOC, "-", FDO_CODEMP) SEPARATOR ", ") AS DOCUMENTOS, ';
    strSQL := strSQL + '       NSEPEX, ';
    strSQL := strSQL + '       LOCSUP, ';
    strSQL := strSQL + '       SALDOS, ';
    strSQL := strSQL + '       OPESEP, ';
    strSQL := strSQL + '       CURRENT_DATE AS DTAIMP, ';
    strSQL := strSQL + '       CURRENT_TIME AS HORIMP, ';
    strSQL := strSQL + '      (SELECT LPAD(COUNT(FGO_SEQSEP),4,''0'') ';
    strSQL := strSQL + '       FROM EXTGOR ';
    strSQL := strSQL + '       WHERE FGO_SEQSEP IN('+strAutInc+')) AS TOTPED,  ';
    strSQL := strSQL + '       FDO_CODMAR, ';
    strSQL := strSQL + '       MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '       0.00 AS SALDIS,  ';
    strSQL := strSQL + '       SALFIS,  ';
    strSQL := strSQL + '       BAR_CODBAR,';
    strSQL := strSQL + '       GROUP_CONCAT(DISTINCT CONCAT(FDO_CODCLI, "-", CLI_NOMCLI) SEPARATOR "\n") AS CLIENTES, ';
    strSQL := strSQL + '       NUMPOK, ';
    strSQL := strSQL + '       TRA_NOMTRA AS TRANSPORTADORA, ';

    strSQL := strSQL + '     (SELECT GROUP_CONCAT(DISTINCT CONCAT(FGO_CODVEN, "-", OPE_NOMOPE) SEPARATOR "|") ';
    strSQL := strSQL + '        FROM FATGOR FG ';
    strSQL := strSQL + '       INNER JOIN EXTGOR EX ON EX.FGO_SEQFGO = FG.AUTOINCREM ';
    strSQL := strSQL + '        LEFT JOIN CADOPE OP ON OP.OPE_CODOPE = FG.FGO_CODVEN ';
    strSQL := strSQL + '       WHERE FGO_SEQSEP IN ('+ strAutInc +')) AS VENDEDOR, ';

    strSQL := strSQL + '     IFNULL((SELECT LSE_DESCRI FROM ITEGER IG ';
    strSQL := strSQL + '              INNER JOIN CADLSE LS ON LS.LSE_CODIGO = IG.ITE_CODLSE ';
    strSQL := strSQL + '              WHERE IG.ITE_CODITE = FDO_CODITE ';
    strSQL := strSQL + '                AND IG.ITE_CODEMP = IFNULL(NULLIF(FDO_EMPITE,""), FDO_CODEMP) ';
    strSQL := strSQL + '              ORDER BY LS.LSE_CODIGO ';
    strSQL := strSQL + '              LIMIT 1) ';
    strSQL := strSQL + '            , "") AS LOC_SEPARACAO ';
    strSQL := strSQL + '     , GROUP_CONCAT(DISTINCT CADCLI.CLI_NOMCLI SEPARATOR ", ") AS CLIENTE ';

    strSQL := strSQL + 'FROM( ';

    strSQL := strSQL + ' SELECT FGO_SEQSEP,   ';
    strSQL := strSQL + '        F.FDO_CODITE, ';
    strSQL := strSQL + '        F.FDO_DESCRI, ';
    strSQL := strSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
    strSQL := strSQL + '        F.FDO_EMPITE, ';
    strSQL := strSQL + '        F.FDO_QTDITE, ';
    strSQL := strSQL + '        C.ITE_CODFAB, ';
    strSQL := strSQL + '        I.ITE_LOCFIS, ';
    strSQL := strSQL + '        CL.LSE_DESCRI, ';
    strSQL := strSQL + '        CONCAT('+QuotedStr(Self.strSeparador)+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
    strSQL := strSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
    strSQL := strSQL + '        I.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '  "' + StrLoginUsuarioLogado + '" "-" "' + StrDescriUsuarioLogado +'" AS OPESEP, ';
    strSQL := strSQL + '        FDO_NUMDOC, ';
    strSQL := strSQL + '        FDO_ESPDOC, ';
    strSQL := strSQL + '        FDO_CODEMP,  ';
    strSQL := strSQL + '        F.FDO_CODMAR, ';
    strSQL := strSQL + '       (IFNULL(ITE_SALDOS, 0) + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(I.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' +
                               IIf((Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura, fGetSQLSomaCamposEntregaFutura('I'), '0')+') AS SALFIS,';

    strSQL := strSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
    strSQL := strSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
    strSQL := strSQL + '             ELSE ITE_CODBAR ';
    strSQL := strSQL + '        END AS BAR_CODBAR, ';
    strSQL := strSQL + '        FDO_CODCLI, ';
    strSQL := strSQL + '        G.FGO_NUMPOK AS NUMPOK, ';
    strSQL := strSQL + '        TRA_NOMTRA ';

    strSQL := strSQL + ' FROM FATDOR F ';
    strSQL := strSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
    strSQL := strSQL + ' INNER JOIN EXTGOR     ON FGO_SEQFGO    = F.FDO_SEQGER ';
    strSQL := strSQL + ' INNER JOIN CADITE C   ON F.FDO_CODITE  = C.ITE_CODITE ';
    strSQL := strSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI ';
    strSQL := strSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE ';
    strSQL := strSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + Self.strSeparador + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADLSE CL  ON CL.LSE_CODIGO = I.ITE_CODLSE ';
    strSQL := strSQL + ' LEFT  JOIN EXTDOR     ON FDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' LEFT  JOIN CADTRA     ON TRA_CODTRA = G.FGO_CODTRA ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

    strSQL := strSQL + ' WHERE FGO_SEQSEP IN('+strAutInc+') ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + '   AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) '
    Else
      strSQL := strSQL + '   AND FDO_JAFATU = 0 ';

    strSQL := strSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "N" ';

    strSQL := strSQL + ' ' + FILTRO_FILA_SEP + ' ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT FGO_SEQSEP,   ';
    strSQL := strSQL + '        C.ITE_CODITE AS FDO_CODITE, ';

    If fCfgSis('IMPREF', varBoolean) Then
    Begin
      If fCfgSis('MONDES', varInteger) = 1 Then
        strSQL := strSQL + '      TRIM(CONCAT(ITE_DESITE, " ", IFNULL(ITE_REFERE,""))) AS FDO_DESCRI, '
      Else
        strSQL := strSQL + '      TRIM(CONCAT(IFNULL(ITE_REFERE,""), " ", ITE_DESITE)) AS FDO_DESCRI, ';
    End
    Else
      strSQL := strSQL + '        ITE_DESITE AS FDO_DESCRI, ';

    strSQL := strSQL + '        UNI_SIGUNI AS "FDO_UNIDAD", ';
    strSQL := strSQL + '        (F.FDO_QTDITE * DMT_QTDITE) AS FDO_QTDITE, ';
    strSQL := strSQL + '        F.FDO_EMPITE, ';
    strSQL := strSQL + '        C.ITE_CODFAB, ';
    strSQL := strSQL + '        I.ITE_LOCFIS, ';
    strSQL := strSQL + '        CL.LSE_DESCRI, ';
    strSQL := strSQL + '        CONCAT('+QuotedStr(Self.strSeparador)+',''-'',OS.OPE_NOMOPE) AS NSEPEX, ';
    strSQL := strSQL + '        I.ITE_LOCSUP AS LOCSUP, ';
    strSQL := strSQL + '        I.ITE_SALDOS AS SALDOS, ';
    strSQL := strSQL + '  "' + StrLoginUsuarioLogado + '" "-" "' + StrDescriUsuarioLogado +'" AS OPESEP, ';
    strSQL := strSQL + '        FDO_NUMDOC, ';
    strSQL := strSQL + '        FDO_ESPDOC, ';
    strSQL := strSQL + '        FDO_CODEMP,  ';
    strSQL := strSQL + '        F.FDO_CODMAR, ';
    strSQL := strSQL + '       (IFNULL(ITE_SALDOS, 0) + IF(IFNULL(C.ITE_CNV_ML, 0) > 0, IFNULL(I.ITE_SAL_ML, 0) / C.ITE_CNV_ML, 0) + ' +
                               IIf((Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura, fGetSQLSomaCamposEntregaFutura('I'), '0')+') AS SALFIS, ';

    strSQL := strSQL + '        CASE WHEN COALESCE(C.ITE_CODBAR, "") = "" ';
    strSQL := strSQL + '             THEN (SELECT BAR_CODBAR FROM ITEBAR WHERE BAR_CODITE = C.ITE_CODITE AND BAR_CODEMP ="' + VS_strCodEmp + '" AND BAR_PRINCI = 1) ';
    strSQL := strSQL + '             ELSE ITE_CODBAR ';
    strSQL := strSQL + '        END AS BAR_CODBAR, ';
    strSQL := strSQL + '        FDO_CODCLI, ';
    strSQL := strSQL + '        G.FGO_NUMPOK AS NUMPOK, ';
    strSQL := strSQL + '        TRA_NOMTRA ';

    strSQL := strSQL + ' FROM FATDOR F ';
    strSQL := strSQL + ' INNER JOIN FATGOR G   ON G.AUTOINCREM  = F.FDO_SEQGER ';
    strSQL := strSQL + ' INNER JOIN EXTGOR     ON FGO_SEQFGO    = F.FDO_SEQGER ';
    strSQL := strSQL + ' INNER JOIN GERMAT GM  ON GMT_CODITE    = F.FDO_CODITE ';
    strSQL := strSQL + ' INNER JOIN DETMAT DM  ON DMT_SEQGER    = GM.AUTOINCREM ';
    strSQL := strSQL + ' INNER JOIN CADITE C   ON DMT_ITESUB    = C.ITE_CODITE ';
    strSQL := strSQL + ' LEFT  JOIN CADUNI U   ON UNI_CODUNI    = C.ITE_CODUNI     ';
    strSQL := strSQL + ' INNER JOIN ITEGER I   ON C.ITE_CODITE  = I.ITE_CODITE ';
    strSQL := strSQL + '                      AND I.ITE_CODEMP  = "' + VS_strCodEmp + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADOPE OS  ON OS.OPE_CODOPE = "' + Self.strSeparador + '" ';
    strSQL := strSQL + ' LEFT  JOIN CADLSE CL  ON CL.LSE_CODIGO = I.ITE_CODLSE ';
    strSQL := strSQL + ' LEFT  JOIN EXTDOR     ON FDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' LEFT  JOIN CADTRA     ON TRA_CODTRA = G.FGO_CODTRA ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + ' LEFT JOIN FATAUT ON FGO_NUMDOC = FATAUT.FAT_NUMDOC  AND FGO_ESPDOC = FATAUT.FAT_ESPDOC AND FGO_CODEMP = FATAUT.FAT_EMPDOC ';

    strSQL := strSQL + ' WHERE FGO_SEQSEP IN('+strAutInc+') ';

    If fCfgSis('FATAUT', VarBoolean) Then
      strSQL := strSQL + '   AND ((FDO_JAFATU = 0) OR (FAT_NUMFAT IS NOT NULL AND FAT_DTLBEX IS NULL)) '
    Else
      strSQL := strSQL + '   AND FDO_JAFATU = 0 ';

    strSQL := strSQL + '   AND IFNULL(FDO_BXSBIT,"N") = "S" ';

    strSQL := strSQL + ' ' + FILTRO_FILA_SEP + ' ';

    strSQL := strSQL + ') CONS ';
    strSQL := strSQL + ' LEFT JOIN CADCLI ON CLI_CODCLI = FDO_CODCLI ';
    strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = FDO_CODMAR ';
    strSQL := strSQL + ' GROUP BY FGO_SEQSEP, FDO_CODITE, FDO_DESCRI, FDO_UNIDAD, ITE_CODFAB, ITE_LOCFIS, FDO_EMPITE ';
    strSQL := strSQL + ' ORDER BY ';

    Case StrToIntDef(fCfgSis('ORSISP'), 0) Of
      7: strSQL := strSQL + ' DESMAR, FDO_DESCRI                    ' ;
      Else
         strSQL := strSQL + ' FGO_SEQSEP, LOC_SEPARACAO, ITE_LOCFIS ' ;
    End;

  End;

  strDestino := 'V';

  If Not fUsaOndaSeparacaoAgrupamento Then
  Begin
    If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
      strDestino := 'V'
    Else
      strDestino := 'I';
  End;

  pCriarFormularios(TfrmQckSintetizaItensSep, frmQckSintetizaItensSep);

  qryFilSep := nil;
  Try
    If fCfgSis('ONDASE', varBoolean) Then
    Begin
      qryFilSep := fCriaQuery;

      qryFilSep.SQL.Add('SELECT * FROM FILSEP');
      qryFilSep.SQL.Add('WHERE FIL_CODEMP = :CODEMP');
      qryFilSep.SQL.Add('  AND FIL_SPOIMP = :SPOIMP');
      qryFilSep.SQL.Add('  AND FIL_NOMMAQ = :NOMMAQ');
      qryFilSep.SQL.Add('  AND FIL_TIPDOC = "O"');

      qryFilSep.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryFilSep.ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
      qryFilSep.ParamByName('NOMMAQ').AsString := VS_WorkstationID;
      qryFilSep.Open;

      If qryFilSep.IsEmpty Then
      Begin
        qryFilSep.Close;
        qryFilSep.SQL.Clear;
        qryFilSep.SQL.Add('SELECT * FROM FILSEP');
        qryFilSep.SQL.Add('WHERE FIL_CODEMP = :CODEMP');
        qryFilSep.SQL.Add('  AND FIL_SPOIMP = :SPOIMP');
        qryFilSep.SQL.Add('  AND FIL_TIPDOC = "O"');

        qryFilSep.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryFilSep.ParamByName('SPOIMP').AsString := IIF(VS_SpoolImpressaoCitel, 'S', 'N');
        qryFilSep.Open;
      End;

      If (Not qryFilSep.IsEmpty) Then
      Begin
        qryFilSep.First;
        While Not qryFilSep.Eof Do
        Begin
          frmQckSintetizaItensSep.pImprimir(strSQL.Replace(FILTRO_FILA_SEP, qryFilSep.FieldByName('FIL_WHERE_').AsString),
                                            Self.Name,
                                            strDestino,
                                            Self.strSeparador,
                                            strAutInc,
                                            False,
                                            False,
                                            qryFilSep.FieldByName('FIL_NOMIMP').AsString,
                                            False,
                                            qryFilSep.FieldByName('FIL_SOLIMP').AsInteger = 1);

          qryFilSep.Next;
        End;

        Exit;
      End;
    End;

    frmQckSintetizaItensSep.pImprimir(strSQL.Replace(FILTRO_FILA_SEP, EmptyStr),
                                      Self.Name,
                                      strDestino,
                                      Self.strSeparador,
                                      strAutInc);

  Finally
    FreeAndNil(qryFilSep);
    pFreeAndNil(frmQckSintetizaItensSep);
  End;

end;

procedure TfrmFatExpedicao.pMarcaFiltroLocalRetiraConformeArquivoIniLocal;
var
  strOPLORE: string;
  intCnt, intTamCfg, intIndex: integer;
begin
  if (not grbLocRet.Visible) then
    Exit;

  strOPLORE := fCfgSis('OPLORE', varString);
  intTamCfg := Length(strOPLORE);

  for intCnt := 1 to intTamCfg do
  begin
    intIndex := lstLocRet.Items.IndexOf(fPrimeiraLetraMaiuscula('RETIRA ' + fVerificaDescAdicionalLocRet(ARR_LOC_RET_DESC[intCnt-1], intCnt)));

    if intIndex = -1 then
      Continue;

    Case AnsiIndexStr(UpperCase(ARR_LOC_RET_DESC[intCnt-1]), ['EXPEDIÇÃO', 'BALCÃO', 'BALCÃO 2']) of
      0: if not fEmptyStr(VS_strTipExpRetiraExpedicao) then
         begin
           lstLocRet.Items.Items[intIndex].State := IIF(VS_strTipExpRetiraExpedicao = 'S', cbsChecked, cbsUnchecked);
         end;

      1: if not fEmptyStr(VS_strTipExpRetiraBalcao) then
         begin
           lstLocRet.Items.Items[intIndex].State := IIF(VS_strTipExpRetiraBalcao = 'S', cbsChecked, cbsUnchecked);
         end;

      2: if not fEmptyStr(VS_strTipExpRetiraBalcao2) then
         begin
           lstLocRet.Items.Items[intIndex].State := IIF(VS_strTipExpRetiraBalcao2 = 'S', cbsChecked, cbsUnchecked);
         end;
    end;
  end;
end;

procedure TfrmFatExpedicao.pMarcaPedidosLotes;
begin

  dbgPedidos.SelectedRows.Clear;
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  Try
    cdsPedidos.First;
    While Not cdsPedidos.Eof Do
    Begin
      pSelecionaVariosPedidos;
      cdsPedidos.Next;
    End;
  Finally
    pAtivaDesativaTimersNotificaoAndRecarga(True);
  End;
end;

procedure TfrmFatExpedicao.pMontaFiltroLocalRetira;
var
  strOPLORE: string;
  intCnt, intTamCfg, intIndex: integer;
  blnTemSug: Boolean;
begin
  if (not grbLocRet.Visible) then
    Exit;

  blnTemSug := fCampoTabela('COUNT(*)', 'SUGEXP', ['EXP_NAMOBJ', 'EXP_CODEMP', 'EXP_TIPEXP'], ['lstLocRet', VS_strCodEmp, VS_strTipExp]);

  strOPLORE := fCfgSis('OPLORE', varString);
  intTamCfg := Length(strOPLORE);

  for intCnt := 1 to intTamCfg do
  begin
    intIndex := lstLocRet.Items.IndexOf(fPrimeiraLetraMaiuscula('RETIRA ' + ARR_LOC_RET_DESC[intCnt-1]));

    if intIndex = -1 then
      Continue;

    if strOPLORE[intCnt] = 'S' then
    begin
      lstLocRet.Items.Items[intIndex].Text := fPrimeiraLetraMaiuscula('RETIRA ' + fVerificaDescAdicionalLocRet(ARR_LOC_RET_DESC[intCnt-1], intCnt));

      if (not blnTemSug) and ((ARR_LOC_RET_DESC[intCnt-1] = 'EXPEDIÇÃO') or (ARR_LOC_RET_DESC[intCnt-1] = 'BALCÃO')) then
        lstLocRet.Items.Items[intIndex].State := cbsChecked;
    end
    else
      lstLocRet.Items.Delete(intIndex);
  end;

  grbLocRet.Width := grbLocRet.Constraints.MaxWidth;
end;

procedure TfrmFatExpedicao.pMontarOpcoesFiltro;
begin
  rdgTipoDocumento.Items.Clear;
  shpDocDev.Visible := False;
  lblSepDocumentoDevolucao.Visible := False;

  rdgTipoDocumento.Items.Add(VENDAS);
  rdgTipoDocumento.Items.Add(TRANSFERENCIA);

  If VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA Then
  Begin
    rdgTipoDocumento.Items.Add(DEVOLUCAO);
    shpDocDev.Visible := True;
    lblSepDocumentoDevolucao.Visible := True;
    If blnNfeXdf Then
      rdgTipoDocumento.Items.Add(GARANTIA);
  End;

  If (blnNfeXdf And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO)) Or
     (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)  Then
    rdgTipoDocumento.Items.Add(GARANTIA);

  If (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or
     (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)  Then
  Begin
    rdgTipoDocumento.Items.Add(ECOMMERCE);
  End;
  rdgTipoDocumento.Items.Add(TODOS);

  rdgTipoDocumento.Columns := (rdgTipoDocumento.Items.Count + 1) div 2;

  rdgTipoDocumento.ItemIndex := rdgTipoDocumento.Items.Count - 1;

  rdgTipoConferencia.Items.Clear;
  rdgTipoConferencia.Items.Add('Totalmente Conferidos');
  rdgTipoConferencia.Items.Add('Parc. Conferidos e Não Conferidos');
  rdgTipoConferencia.Items.Add('Parcialmente Conferidos');
  rdgTipoConferencia.Items.Add('Não Conferidos');
  rdgTipoConferencia.Items.Add('Todos');
  rdgTipoConferencia.Width := rdgTipoConferencia.Constraints.MaxWidth;
  rdgTipoConferencia.Columns := 3;
  rdgTipoConferencia.ItemIndex := 4;
end;

procedure TfrmFatExpedicao.pMostraSituacaoItens;
var
  frmSituacaoItensPedidoLocal: TfrmSituacaoItensPedido;
begin
  inherited;
  try
    pCriarFormularios(TfrmSituacaoItensPedido, frmSituacaoItensPedidoLocal);
    frmSituacaoItensPedidoLocal.strNumDoc := fField('NUMDOC').AsString;
    frmSituacaoItensPedidoLocal.strEspDoc := fField('ESPDOC').AsString;
    frmSituacaoItensPedidoLocal.strCodEmp := fField('CODEMP').AsString;
    frmSituacaoItensPedidoLocal.ShowModal;
  finally
    pFreeAndNil(frmSituacaoItensPedidoLocal);
  end;
end;

procedure TfrmFatExpedicao.pNotificaOperadorExpedicao(strCliTra: String);
var
  cdsExpedicao: TZClient;
  strNomCli: String;
begin
  If fCfgSis('AVSCLI', VarBoolean) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
  begin
    strNomCli := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCliTra]);
    if (Not fClienteConsumidor(strNomCli, False, True)) Then
    Begin
      try
        cdsExpedicao := TZClient.Create(nil);
        pCloneDataSet(cdsExpedicao, cdsPedidos);

        cdsExpedicao.Filtered := False;
        cdsExpedicao.Filter   := 'CODCLI = ' + strCliTra;
        cdsExpedicao.Filtered := True;

        if cdsExpedicao.RecordCount > 1 then
          pMensagemOk('Existe outro pedido do mesmo cliente. '+
                      'Verifique se será separado/faturado junto.');
      finally
        FreeAndNil(cdsExpedicao);
      end;
    end;
  end;
end;

function TfrmFatExpedicao.fAvisaOperadorDestinoDiferente(strEntRet: String): Boolean;
  Var
    cdsExpedicao: TUniClientDataSet;
    intContador : Integer;

begin
  Result := True;

  If fCfgSis('AVEXED', VarBoolean) and ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) then
  begin
    try
      cdsExpedicao := TUniClientDataSet.Create(nil);
      pCloneDataSet(cdsExpedicao, cdsPedidos);

      For intContador := 0 to stlPedidos.Count - 1 do
      Begin
        cdsExpedicao.Locate('AUTINC', stlPedidos.Strings[intContador], []);

        If (cdsExpedicao.FieldByName('ENTRET').AsString <> strEntRet) Then
        Begin
          if (fMensagem('Atenção', 'Ao faturar pedidos de venda do mesmo cliente, com tipo de movimento diferente ( Retira/Entrega ), '+
                                   'serão gerados documentos de venda e financeiros separados por tipo de movimento.'+#13+
                                   'Tem certeza que deseja continuar com a operação ?', ['&Sim', '&Não'], 2) = 2) then
            Result := False;
            Exit;
        End;
      End;
    finally
      FreeAndNil(cdsExpedicao);
    end;
  end;

end;

procedure TfrmFatExpedicao.pExibirBotoesLabels;
begin
  If (VS_strTipExp = TIPEXP_POR_DOCUMENTO_DE_VENDA) And (fField('ESPDOC').AsString <> 'PD') Then
  Begin
    lblSepImpNaoImp.Caption    := 'Separação não impressa';
    lblSepImpJaImp.Caption     := 'Separação já impressa';
    lblSepImpExpNaoImp.Caption := 'Expedido parcialmente e Separação não impressa';
    lblSepImpExpJaImp.Caption  := 'Expedido parcialmente e Separação já impressa';
  End
  Else
  Begin
    lblSepImpNaoImp.Caption    := 'Separação não impressa';
    lblSepImpJaImp.Caption     := 'Separação já impressa';
    lblSepImpExpNaoImp.Caption := 'Alterado com Separação já impressa';
    lblSepImpExpJaImp.Caption  := 'Separação já reimpressa após alteração do pedido';
  End;

  //Somente habilitar se o documento teve origem na empresa logada na expedicao
  btnAltEmpFat.Visible := blnAltEmpFat And (fField('CODEMP').AsString = VS_strCodEmp);
  btnRevEmpFat.Visible := blnAltEmpFat;

  if not blnApenasImprimirBaixarSeparacao then
  begin
    btnConfirma.Visible := True;

    if MatchStr(VS_strTipExp, [TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO, TIPEXP_POR_ROMANEIO_E_PEDIDO_NAO_SERA_FATURADO]) then
      btnConfirma.Enabled := fVerificaAcessoSistema('EXF10P');
  end;

  pnlSepImp.Visible   := True;
  lblPrevis.Visible   := True;
  dbtxtPrevis.Visible := True;

  If (Not fEmptyStr(fField('PREVIS').AsString)) Then
    lblFeriado.Visible := fEhFeriado(fField('PREVIS').AsDateTime,
                                     fField('CODCID').AsString)
  Else
    lblFeriado.Visible := False;

  pAjustaComponentesFeriado;
  pAjustaComponentesDeOrientacaoParaEntrega;

  { VERIFICA CONFIGURAÇÕES ANTES DE EXIBIR O BOTÃO }
  If (fExibirFiltroPorEstoque) Then
  Begin
    btnBuscaNFe_Estoque.Caption := '[F9] Carregar Pedidos por estoque';
    btnBuscaNFe_Estoque.Visible := fVerificaAcessoSistema('EXF9PD');
  End
  Else If (fCfgSis('TIPEXP') = 2) And (fCfgSis('NFEUSA', varBoolean)) Then
  Begin
    btnBuscaNFe_Estoque.Caption := '[F9] Buscar NFe pela chave de acesso';
    btnBuscaNFe_Estoque.Visible := True;
  End
  Else
    btnBuscaNFe_Estoque.Visible := False;
end;

function TfrmFatExpedicao.fPermiteSelecionarPedidoAtual(blnImpSep: Boolean = False): Boolean;
  Var
    strDocTra: String;
    strEspTra: String;
    strEmpTra: String;
    strCliTra: String;
    strPenFin: String;
    strNumOse: String;
    strEquip: String;

    strOps     : String;
    LblnUtilizarDataEmissaoCalcularDiaVencimento: boolean ;
begin
  strDocTra := fField('NUMDOC').AsString;
  strEspTra := fField('ESPDOC').AsString;
  strEmpTra := fField('CODEMP').AsString;
  strCliTra := fField('CODCLI').AsString;

  Result := True;

  If cdsPedidos.IsEmpty Then
  Begin
    pMensagemOk('Não há documentos para serem expedidos!');
    Result := False;
    Exit;
  End;

  If (fField('PEDPAR').AsString = 'R') and (stlPedidos.Count > 0) then
  begin
    pMensagemOk('Não é permitido selecionar um documento de reposição junto com outros pedidos!');
    Result := False;
    Exit;
  end;

  If blnExibirPedidosFaturamentoAutomatico And (fField('FATAUT').AsString = 'S') and (stlPedidos.Count > 0) then
  begin
    pMensagemOk('Não é permitido selecionar um documento de faturamento automático junto com outros pedidos!');
    Result := False;
    Exit;
  end;

  If (fField('TIPOPE').AsString = 'U') and (stlPedidos.Count > 0) then
  begin
    pMensagemOk('Não é permitido selecionar um documento do Tipo Operação: Uso/Consumo junto com outros pedidos!');
    Result := False;
    Exit;
  end;

  If blnExibirPedidosFaturamentoAutomatico And (fField('FATAUT').AsString = 'S') And (fField('NFESTA').AsString <> 'AT') Then
  begin
    pMensagemOk('Nota fiscal "' + fField('DOCFAT').AsString + '" não foi autorizada.' + sLineBreak +
      fField('NFESTA').AsString +  ' - ' + fField('NFEOBS').AsString);
    Result := False;
    Exit;
  end;

  If blnExibirPedidosFaturamentoAutomatico And (fField('FATAUT').AsString <> 'S') And (fRetornaInformacaoVenda(strDocTra, strEspTra, strEmpTra, 'JAFATU') = '1') Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse pedido já foi faturado!', ['&OK']);
    Result := False;
    Exit;
  End;

  If Not fValidarAbastecimentoEstoquePedido Then
  begin
    Result := False;
    Exit;
  end;

  If (strEspTra = 'PD') And fCfgSis('LIBPED', varBoolean) Then
  Begin
    If Not fPedidoLiberado Then
    Begin
      pMensagemOk('Este pedido ainda não foi liberado!');
      Result := False;
      Exit;
    End;
  End;

  if not fValidaFormaNegociada(strDocTra, strEspTra, strEmpTra, fField('CODFPG').AsString, fField('VALADT_FATAUT').AsFloat, False) then
  begin
    fMensagem('','Este pedido possui formas de pagamento negociadas e deve ser faturado pelo F11 do Resumo de Caixa!',['&OK']);
    Exit(False);
  end;

  LblnUtilizarDataEmissaoCalcularDiaVencimento := TfatVenda.fUtilizarDataEmissaoCalcularDiaVencimento(fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString) ;
  If (Not fPermiteClienteDiaFixoOuDiaSemana(fField('CODCLI').AsString, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
  Begin
    Result := False;
    Exit;
  End;

  If (Not fPermiteUtilizarEstaCondPagamento(fField('CODCND').AsString, LblnUtilizarDataEmissaoCalcularDiaVencimento)) Then
  Begin
    Result := False;
    Exit;
  End;

  If blnApenasPrazo And (Copy(fField('CONPAG').AsString,3,3) = '000') Then
  Begin
    //Se tiver adiantamento no valor do documento o sistema não deve travar a expedição devido ao caixa estar fechado.
    if (Not fPedidoComFinanceiroOkComCaixaFechado) then
    begin
      pMensagemOk(MSG_SELECAO_SOMENTE_A_PRAZO);
      Result := False;
      Exit;
    end;
  End;

  {*****************************************************************************}
  {* SE FOR IGUAL A 4 (O PEDIDO NÃO SERÁ EXPEDIDO) O PEDIDO COM DAV PODERÁ SER *}
  {* SER SELECIONADO PARA EXPEDIÇÃO, MAS NÃO PODERÁ SER FATURADO               *}
  {**************************************************************************VA*}
  If (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    If (fField('TEMDAV').AsString = 'S') Then
    Begin
      pMensagemOk('Não é permitido faturar este documento pois o mesmo possui um DAV associado. Use o PDVCitel.');
      Result := False;
      Exit;
    End;
  End;

  If (btnFaturarExpedidos.Visible) Or (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    If fTemEntFut(strDocTra, strEspTra, strEmpTra) Then
    Begin
      fMensagem('','Documento com entrega futura deve ser faturado pela venda normal!',['&OK']);
      Result := False;
      Exit;
    End;
  End;

  If (Not btnFaturarExpedidos.Visible) And fTemServico(strDocTra, strEspTra, strEmpTra, strCliTra) And (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    fMensagem('','Documento com serviços deve ser faturado pela venda normal!',['&OK']);
    Result := False;
    Exit;
  End;

  If (Not btnFaturarExpedidos.Visible) And fTemVidro(strDocTra, strEspTra, strEmpTra) Then
  Begin
    fMensagem('','Documento com vidros deve ser faturado pela venda normal!',['&OK']);
    Result := False;
    Exit;
  End;

  If (VS_strExpRetiraEntrega = 'E') And fTemRetira(strDocTra, strEspTra, strEmpTra, cdsPedidos.FieldByName('AUTINC').AsString) Then
  Begin
    If Not blnApenasConferenciaProdutosRetiraCaixa Then
    Begin
      fMensagem('','Não é permitido pedido com itens de Retira, pois sistema configurado ' +
                   'para expedir somente itens de Entrega. Favor dirigir-se ao caixa ' +
                   'para desmembrar este pedido!',['&OK']);
      Result := False;
      Exit;
    End;
  End;

  If (strEspTra = 'PD') And (fCfgSis('OPCROM') = '1') And (Not blnApenasConferenciaProdutosRetiraCaixa) Then
  Begin
    If fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra) And
       fPedidoPossuiItensEntregaImediata(strDocTra, strEspTra, strEmpTra) Then
    Begin
      If Not (fUsaRotinaExpedicaoConferenciaRetiraCaixa And blnApenasImprimirBaixarSeparacao) Then
      Begin
        pMensagemOk('Não é possível selecionar este pedido para expedição, ' +
                     'pois o mesmo possui itens de entrega e retira. ' +
                     'Será necessário passar no caixa para desmembrar este pedido!');
        Result := False;
        Exit;
      End;
    End;
  End;

  If Not (fUsaRotinaExpedicaoConferenciaRetiraCaixa And blnApenasImprimirBaixarSeparacao) Then
    If Not fValidaLocalRetiraAoSelecionarPedido(strDocTra, strEspTra, strEmpTra) Then
      Exit(False);

  If fValidaItemEspecial(strEspTra, fField('TEMITEESP').AsString) Then
  Begin
    Result := False;
    Exit;
  End;

  If fDocumentoPossuiItemConcreto(fField('NUMDOC').AsString,
                                  fField('ESPDOC').AsString,
                                  fField('CODEMP').AsString) And
     (fCfgSis('TPNFCR') <> J_A_MASSA_CONCRETO) Then
  Begin
    If Not (fCfgSis('USACCR', varBoolean) And MatchStr(fCfgSis('TPNFCR'),[SECOL])) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento possui itens concreto, ' +
                            'somente é permitido faturar o mesmo pela Venda Normal!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  If (fCfgSis('EMPFAT', varString) = 'S') And
     (Not blnApenasConferenciaProdutosRetiraCaixa) And
     (Not (fUsaRotinaExpedicaoConferenciaRetiraCaixa And blnApenasImprimirBaixarSeparacao)) Then
  Begin
    If fEhPedOrcMultiloja(fField('NUMDOC').AsString,
                          fField('ESPDOC').AsString,
                          fField('CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Pedido Multiloja. Desmembre-o antes de faturar!', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  {*****************************************}
  {* SE NÃO FOR ACEITO MI FORA DO ESTADO   *}
  {**************************************MV*}
  If (fCfgSis('MIFEST', varString) = 'N') And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Then
  Begin
    If (Not fEmptyStr(fField('TIPPED').AsString))   And
       (Pos(fField('TIPPED').AsString, 'B_D_') > 0) And
       (Pos('GARANTIA', fField('MEN001').AsString ) = 0 ) Then
    Begin
      If (fField('ESTADO').AsString <> fCadEmp('ESTADO')) And
         (fField('TEMSUB').AsInteger = 1)                 And
         (fField('VENPRE').AsString = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é permitido confirmar FF com produto que ' +
                              'tenha substituição tributária para cliente fora do estado!', ['&O k']);
        Result := False;
        Exit;
      End;
    End;
  End;

  If fTravaExpedicaoClienteInativo() Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Esse cliente está com atividade suspensa!');

    objLiberacao.strDirAce := 'ATISUS';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Esse cliente está com atividade suspensa';
    objLiberacao.strOperador := strLoginUsuarioLogado;
    objLiberacao.strCliente := fField('CODCLI').AsString;

    If (Not objLiberacao.fLibera) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  If (fField('TIPOPE').AsString = 'B') And
     (TFatVenda.fTravaDocumentoBonificado(fField('NUMDOC').AsString,
                                          fField('ESPDOC').AsString,
                                          fField('CODEMP').AsString)) Then
  Begin
    Result := False;
    Exit;
  End;

  If fUsaRotinaWMS And (Not blnImpSep) and (not fUsaOndaSeparacaoAgrupamento) Then
  Begin
    If (strToIntDef(fField('SEPIMP').AsString, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A separação deste pedido ainda não foi impressa!', ['&O k']);
      Result := False;
      Exit;
    End;
  End;

  //REQUISITO: 52325 (CECON TINTAS)
  // TRAVA ALTERADA POR SOLICITAÇÃO DA ARARENSE
  If ((Not blnImpSep) And (Not SameText(VS_strTipExp, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO))) Or
     (blnImpSep And fValidarSitFinParaImpressaoSeparacao) Then
  Begin
    If (Not fSituacaoFinanceiraPedidoOk(strPenFin)) Then
    Begin
      pMensagemOk(strPenFin + '!');
      Result := False;
      Exit;
    End;
  End;

  If (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And
    (fCfgSis('EQUEXP', varString) = 'S') And
    (fCfgSis('FTPDOS', varString) = 'N') And
    (Not fOSFinalizada(fField('NUMDOC').AsString,
                       fField('ESPDOC').AsString,
                       fField('CODEMP').AsString,
                       strNumOse)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este Pedido de Venda é oriundo da Ordem de Serviço ' + strNumOse + #13 +
                          'e a mesma ainda não foi finalizada. Procure o responsável' + #13 +
                          'pela rotina de Conserto de Equipamentos para realizar' + #13 +
                          'este procedimento e liberar o faturamento deste Pedido.', ['&OK']);
    Result := False;
    Exit;
  End;

  if ((VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO)) and
    (fCfgSis('EQUEXP', varString) = 'S') and
    (not fOSFinalizadaArmazenada(fField('NUMDOC').AsString,
                                 fField('ESPDOC').AsString,
                                 fField('CODEMP').AsString,
                                 strNumOse, strEquip)) then
  begin
    fMensagem('ATENÇÃO!', 'Este pedido de venda é oriundo de Conserto de Equipamento através da Ordem de Serviço ' + strNumOse + '.' + #13 +
                          'Para permitir seu faturamento, é necessário que o Armazenamento do Equipamento tenha ' +
                          'sido realizado e esteja pronto pra ser retirado, porém isso ainda não ocorreu.' + #13 +
                          'Entre em contato com o departamento de Assitência Técnica para solicitar que isso seja feito.' + #13 +
                          'Equipamento: ' + strEquip, ['&OK'], 1, False, 1, 0, False, 0, False, False, False, 230, 560);
    Result := False;
    Exit;
  end;

  If fCfgSis('SEPOPI', varBoolean) Then
  Begin

    strOps := '';
    strOps := TFatVendaImp.fGetOPs_PD(strDocTra,
                                      strEspTra,
                                      strEmpTra);

    If Not fEmptyStr(strOps) Then
    Begin

      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('Permitir faturar pedido com ordem de produção em aberto');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + strDocTra + '-' + strEspTra + '-' + strEmpTra);
      objLiberacao.objMsgLibera.pAddTexto('possui item estrutura com ordem de produção.');
      objLiberacao.objMsgLibera.pAddTexto('O pedido somente poderá ser selecionado para faturamento após baixa da ordem de produção.');
      objLiberacao.objMsgLibera.pAddTextoCaption('OP(s)', strOps + '.');

      objLiberacao.strDirAce := 'PFPOPA';
      objLiberacao.strMsgSen := 'Permitir faturar pedido com ordem de produção em aberto';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
        Exit;
      End;

    End;

  End;

end;

function TfrmFatExpedicao.fPermitirDesmembrarVendaTipoExpedicaoPedidoEGerarVendaPerdida: Boolean;
begin
  Result := (fCfgSis('EXPDEM') <> 'N') And (fCfgSis('TIPEXP') = '4') And
            (Copy(fCfgSis('DMPOPC', varString), 2, 1) = 'S');
end;

function TfrmFatExpedicao.fPermitirFaturarContaOrdem: Boolean;
begin
  Result := True;

  If (fField('TIPOPE').AsString = 'C') Then
  Begin
    If (fExisteDocumentoContaOrdemComRemessaNaoFaturada(
                    fField('AUTINC').AsString)) Then
    Begin
      pAtivaDesativaTimersNotificaoAndRecarga(True);
      Result := False;
    End;
  End;
end;

function TfrmFatExpedicao.fRetConPagCalculado(strCodCli, strConPag, strCodCnd: String): String;
  Var
    strConAux,
    strTipFor: String;
begin
  strTipFor := fRetTipoForaConPag(strCodCnd);

  strConAux := '';

  If (fConPagFora(strTipFor)) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(strCodCnd)) Then
  Begin
    strConAux := fRetConPagCodCnd(strCodCnd);
    strConPag := fRetCondicao('', 0, strCodCnd, strTipFor, strConAux);
  End;

  If (fEmptyStr(strConAux)) And (Pos(strTipFor, 'OUTROS_DIA FIXO_') <= 0) And fCfgSis('USACND', VarBoolean) And (Not fEmptyStr(strCodCnd)) Then
    strConAux := fRetConPagCodCnd(strCodCnd)
  Else
    strConAux := strConPag;

  strConPag := fRetCondicaoDiaFixoCliente('', 0, strCodCli, strConAux);

  Result := strConPag;
end;

function TfrmFatExpedicao.fRetornaCampoTurno(sCampo: String): String;
begin
  Result := ' CONCAT( ';
  Result := Result + '    IF(LOCATE("MANHÃ", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0, "MANHÃ", ""), ';
  Result := Result + '      IF(LOCATE("MANHÃ", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0 ';
  Result := Result + '        AND (LOCATE("TARDE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0 ';
  Result := Result + '          OR LOCATE("NOITE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0), " / ", ""), ';
  Result := Result + '    IF(LOCATE("TARDE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0, "TARDE", ""), "", ';
  Result := Result + '      IF(LOCATE("TARDE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0 ';
  Result := Result + '        AND LOCATE("NOITE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0, " / ", ""), ';
  Result := Result + '    IF(LOCATE("NOITE", GROUP_CONCAT(DISTINCT ' + sCampo + ')) > 0, "NOITE", "") ';
  Result := Result + '  ) AS TURENT ';
end;

function TfrmFatExpedicao.fRetPrimeiroCliConEntreOsDocsInseridos: String;
begin
  Result := '';
  If (fVerificaSelecionado(cdsPedidos)) Then
  Begin
    If (stlPedidos.Count > 0) Then
    Begin
      Result := fRetCliConPeloAutInc('FATGOR', stlPedidos.Strings[0]);
      End;

    End;
end;

function TfrmFatExpedicao.fRetSQLPedReqCompra: String;
begin
  Result := ' SELECT CAST(IFNULL(GROUP_CONCAT(DISTINCT RCD_CODIGO), " ") AS CHAR(512)) ' +
            '   FROM MOVRCD R ' +
            '  WHERE IFNULL(R.RCD_DOCPDV, "") <> "" ' +
            '    AND R.RCD_DOCPDV = FGO_NUMDOC ' +
            '    AND R.RCD_EMPPDV = FGO_CODEMP ' +
            '    AND R.RCD_ESPPDV = FGO_ESPDOC ' +
            '  GROUP BY R.RCD_DOCPDV, R.RCD_ESPPDV, R.RCD_EMPPDV ';
end;

function TfrmFatExpedicao.fRetSQLPedSolicTransf: String;
begin
  Result := ' SELECT CAST(IFNULL(GROUP_CONCAT(CONCAT_WS("-", F.FGO_NUMDOC)), " ") AS CHAR(512)) ' +
            '   FROM FATGOR F INNER JOIN EXTGOR E ON F.AUTOINCREM = E.FGO_SEQFGO ' +
            '  WHERE E.FGO_NMPDAB = FATGOR.FGO_NUMDOC ' +
            '    AND E.FGO_EMPDAB = FATGOR.FGO_CODEMP ' +
            '    AND E.FGO_ESPDAB = FATGOR.FGO_ESPDOC ';
end;

function TfrmFatExpedicao.fRetSQLTemAoMenosUmItemNormal(strTabela: String): String;
  Var
    strCfgITESER,
    strCfgSERTER: String;
    strSigTab: String;
    strTabDet: String;
begin
  Result := '';

  strSigTab := 'D.DET_';
  strTabDet := 'MOVDET';

  If (SameText(strTabela, 'FATGOR')) Then
  Begin
    strSigTab := 'D.FDO_';
    strTabDet := 'FATDOR';
  End;

  strCfgITESER := fCfgSis('ITESER');
  strCfgSERTER := fCfgSis('SERTER');

  If (Not fEmptyStr(strCfgITESER + strCfgSERTER)) Or (Not SameText(strTabela, 'FATGOR')) Then
  Begin
    Result := Result + ' ((SELECT ';
    Result := Result + '     COUNT(' + strSigTab + 'CODITE) ';
    Result := Result + '   FROM    ' + strTabDet + ' D ';
    Result := Result + '   WHERE   ' + strSigTab + 'SEQGER = ' + strTabela + '.AUTOINCREM AND ';
    Result := Result + '           ' + strSigTab + 'PROEMB <> "S"  ';

    If (Not fEmptyStr(strCfgITESER)) Then
      Result := Result + ' AND     ' + strSigTab + 'CODITE <> ' + QuotedStr(strCfgITESER) + ' ';

    If (Not fEmptyStr(strCfgSERTER)) Then
      Result := Result + ' AND     ' + strSigTab + 'CODITE <> ' + QuotedStr(strCfgSERTER) + ' ';

    If (Not SameText(strTabela, 'FATGOR')) Then
      Result := Result   + ' AND   ' + strSigTab + 'TIP_FC = "C" ';

    Result := Result   + ') >= 1) AND ';
  End;
end;

function TfrmFatExpedicao.fRotasPorRegiaoExpedicaoPedido4: boolean;
begin
  Result := (blnRegCid) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO);
end;

function TfrmFatExpedicao.fDataImpressao: TDateTime;
begin
  Result := fCampoTabela('FGO_DTIMSE', 'EXTGOR', ['FGO_SEQFGO'], [fField('AUTINC').AsString]);
end;

function TfrmFatExpedicao.fDebitoCliente: Boolean;
var
  fatVendaTrava: TFatVenda;
  blnDisabledControl: Boolean;
  intRecNo: Integer;
begin
  Result := True;
  if (fCfgSis('AMPVEX') = 'N') then
    Exit;

  if FblnTemPedidoDeConsignacao then
    fatVendaTrava := TFatVenda.CreateInstance('CS')
  else
    fatVendaTrava := TFatVenda.CreateInstance('CP');

  try
    intRecNo := cdsPedidos.RecNo;
    blnDisabledControl := cdsPedidos.ControlsDisabled;
    if not blnDisabledControl then
      cdsPedidos.DisableControls;

    cdsPedidos.First;
    while not cdsPedidos.Eof do
    begin
      if fSelecionado(cdsPedidos) then
      begin
        fatVendaTrava.strCodFpg := cdsPedidos.FieldByName('CODFPG').AsString;
        fatVendaTrava.strConPag := cdsPedidos.FieldByName('CONPAG').AsString;
        fatVendaTrava.strCodCnd := cdsPedidos.FieldByName('CODCND').AsString;
        fatVendaTrava.strCodCli := cdsPedidos.FieldByName('CODCLI').AsString;
        fatVendaTrava.strCodVen := cdsPedidos.FieldByName('CODVEN').AsString;
        fatVendaTrava.strCodDig := cdsPedidos.FieldByName('CODDIG').AsString;
        fatVendaTrava.strCliOri := cdsPedidos.FieldByName('NOMCLI').AsString;
        fatVendaTrava.strCliCgc := cdsPedidos.FieldByName('CLICGC').AsString;
        fatVendaTrava.strNumDoc := cdsPedidos.FieldByName('NUMDOC').AsString;
        fatVendaTrava.strEspDoc := cdsPedidos.FieldByName('ESPDOC').AsString;
        fatVendaTrava.strCodEmpTe := cdsPedidos.FieldByName('CODEMP').AsString;
        Break;
      end;

      cdsPedidos.Next;
    end;

    cdsPedidos.RecNo := intRecNo;
    if not blnDisabledControl then
      cdsPedidos.EnableControls;

    Result := fatVendaTrava.fDebitoCliente(fatVendaTrava.strCodFpg, fatVendaTrava.strConPag, 2, 'EXP');
  finally
    FreeAndNil(fatVendaTrava);
  end;

end;

function TfrmFatExpedicao.fDesmembrarAutomaticamenteSemPerguntarGerandoVendasPerdidas: Boolean;
begin
  Result :=  ((fCfgSis('EXPDEM', varString) = 'A') and (Copy(fCfgSis('DMPOPC', varString), 2, 1) = 'S'))
end;

function TfrmFatExpedicao.fDigitaLotesPedidoWMS(strCodSep: String): Boolean;
  Var
    strDocTra: String;
    strEspTra: String;
    strEmpTra: String;
    strCliTra: String;
    strChaLck: String;
    blnSepImpressa: Boolean;
    LfrmFatDefineLotesPedidoWMS: TfrmFatDefineLotesPedidoWMS;
begin
  Result := True;

  If fUsaRotinaWMS Then
  Begin
    strDocTra := fField('NUMDOC').AsString;
    strEspTra := fField('ESPDOC').AsString;
    strEmpTra := fField('CODEMP').AsString;
    strCliTra := fField('CODCLI').AsString;

    strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;

    If Result And (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
    Begin
      Result := False;
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck) + '!', ['&Ok']);
    End;

    If Result And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
      objLock.fLock_Unlock(strChaLck + STR_TRAVA_CONFERENCIA, True, False);

    strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;

    If Result And (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
    Begin
      Result := False;
      fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck) + '!', ['&Ok']);
    End;

    If Result And (fField('ORDPRO').AsString = 'PENDENTE') Then
    Begin
      Result := False;
      If Not blnApenasImprimirBaixarSeparacao Then
        pMensagemOk('Este pedido possui itens com ordem de produção não emitida!');
    End;

    If Result And (fField('ORDPRO').AsString = 'EMITIDA') And
                  (Not fVerificaOrdProdEstruturaEstaoBaixadas) And
                  (Not fBaixaOrdemProducaoAutomaticamente) Then
    Begin
      Result := False;
      pMensagemOk('As Ordens de Produção emitidas para este pedido ainda não foram baixadas!');
    End;

    If fFiltrarLocalSeparacaoItensWMS Then
      blnSepImpressa := fRealizouDefinicaoLotesNoLocalSeparacaoSelecionado(fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString)
    Else
      blnSepImpressa := StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) > 0;

    If Result And blnSepImpressa And
       (((FTipoImpSep = tisReimpressaoSeqSeparacaoWMS) And (not blnSenhaReimpressao)) Or
        (FTipoImpSep <> tisReimpressaoSeqSeparacaoWMS))Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Expedição - Reimprimir Separação de Produtos WMS');

      objLiberacao.strDirAce := 'RIMPSEWMS';
      objLiberacao.strMsgSen := 'Expedição - Reimprimir Separação de Produtos WMS';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
      Begin
        Result := False;
      End;

      blnSenhaReimpressao := Result;
    End;

    If Result Then
    Begin
      Try

        Try

          pCriarFormularios(TfrmFatDefineLotesPedidoWMS, LfrmFatDefineLotesPedidoWMS);
          LfrmFatDefineLotesPedidoWMS.TipoDefinicoesLotes := tdlPedido;

          LfrmFatDefineLotesPedidoWMS.strNumPed := fField('NUMDOC').AsString;
          LfrmFatDefineLotesPedidoWMS.strEmpPed := fField('CODEMP').AsString;
          LfrmFatDefineLotesPedidoWMS.strCodSep := strCodSep;
          LfrmFatDefineLotesPedidoWMS.strCodCli := cdsPedidos.FieldByName('CODCLI').AsString;
          //frmFatDefineLotesPedidoWMS.blnReimpr := (StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString,0) > 0);
          LfrmFatDefineLotesPedidoWMS.pAtuSepPed:= pAtualizaSeparadorPedido;
          LfrmFatDefineLotesPedidoWMS.blnApenasImpressao := not (FTipoImpSep = tisNormal);
          LfrmFatDefineLotesPedidoWMS.blnExpedicao := True;

          If fFiltrarLocalSeparacaoItensWMS Then
            LfrmFatDefineLotesPedidoWMS.strCodLseItens := fGetCodigoLocSep();

          If LfrmFatDefineLotesPedidoWMS.blnApenasImpressao Then
          Begin
            LfrmFatDefineLotesPedidoWMS.fCriarObjetos;
            LfrmFatDefineLotesPedidoWMS.btnConfirma.Click;
          End
          Else
            LfrmFatDefineLotesPedidoWMS.ShowModal;

          Result := LfrmFatDefineLotesPedidoWMS.blnConfirma And
                    LfrmFatDefineLotesPedidoWMS.blnSepImp;

          RealizarMovimentacaoProgramadaPedido(fField('AUTINC').AsString, LfrmFatDefineLotesPedidoWMS.blnConfirma, True);
        Finally
          pFreeAndNil(LfrmFatDefineLotesPedidoWMS);
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '');
        End;
      End;
    End;

    //libera o documento
    objLock.fLock_Unlock('FATGOR' + strDocTra + strEspTra + strEmpTra, False, False);
    objLock.fLock_Unlock('CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra, False, False);
  End;
end;

function TfrmFatExpedicao.fDigitaLotesPedidoWMSOndaDeSeparacao(strCodSep: String): Boolean;
Var
  strDocTra       : String;
  strEspTra       : String;
  strEmpTra       : String;
  strCliTra       : String;
  strChaLck       : String;
  LfrmFatDefineLotesPedidoWMS: TfrmFatDefineLotesPedidoWMS;
  blnJaSolicitouSenhaReimpressao : Boolean;
begin

  blnJaSolicitouSenhaReimpressao := False;
  Result := True;

  {** Quando usar o "Painel de Remessa de Separação" não será mais definido os lotes aqui!!! **}
  If fUsaOndaSeparacaoAgrupamento Then
    Exit;

  If fUsaRotinaWMS Then
  Begin
    cdsPedidos.DisableControls;

    Try
      //bloqueia o(s) documento(s)
      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin
        if fSelecionado(cdsPedidos) then
        Begin
          strDocTra := fField('NUMDOC').AsString;
          strEspTra := fField('ESPDOC').AsString;
          strEmpTra := fField('CODEMP').AsString;
          strCliTra := fField('CODCLI').AsString;

          strChaLck := 'FATGOR' + strDocTra + strEspTra + strEmpTra;

          If Result And (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
          Begin
            Result := False;
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck) + '!', ['&Ok']);
            Break;
          End;

          If Result And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
            objLock.fLock_Unlock(strChaLck + STR_TRAVA_CONFERENCIA, True, False);

          strChaLck := 'CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra;

          If Result And (Not objLock.fLock_Unlock(strChaLck, True, False)) Then
          Begin
            Result := False;
            fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' + fGetHostLock(strChaLck) + '!', ['&Ok']);
            Break;
          End;
        End;

        If Result And (fField('ORDPRO').AsString = 'PENDENTE') Then
        Begin
          Result := False;
          If Not blnApenasImprimirBaixarSeparacao Then
            pMensagemOk('Este pedido possui itens com ordem de produção não emitida!');
          Break;
        End;

        If Result And (fField('ORDPRO').AsString = 'EMITIDA') And
                      (Not fVerificaOrdProdEstruturaEstaoBaixadas) And
                      (Not fBaixaOrdemProducaoAutomaticamente) Then
        Begin
          Result := False;
          pMensagemOk('As Ordens de Produção emitidas para este pedido ainda não foram baixadas!');
          Break;
        End;

        If Not blnJaSolicitouSenhaReimpressao Then
          If Result And (StrToIntDef(cdsPedidos.FieldByName('SEPIMP').AsString, 0) > 0) And
             (((FTipoImpSep = tisReimpressaoSeqSeparacaoWMS) And (not blnSenhaReimpressao)) Or
              (FTipoImpSep <> tisReimpressaoSeqSeparacaoWMS))Then
          Begin
            objLiberacao.Clear;
            objLiberacao.objMsgLibera.pAddTexto('Expedição - Reimprimir Separação de Produtos WMS');

            objLiberacao.strDirAce := 'RIMPSEWMS';
            objLiberacao.strMsgSen := 'Expedição - Reimprimir Separação de Produtos WMS';
            objLiberacao.blnMosMen := True;
            objLiberacao.strCodOpe := strLoginUsuarioLogado;

            If (Not objLiberacao.fLibera) Then
              Result := False;

            blnSenhaReimpressao := Result;

            If Not Result Then
              Break
            Else
              blnJaSolicitouSenhaReimpressao := True;

          End;

        cdsPedidos.Next;

      End;

      If (Result) Then
      Begin

        Try

          Try

            pCriarFormularios(TfrmFatDefineLotesPedidoWMS, LfrmFatDefineLotesPedidoWMS);
            LfrmFatDefineLotesPedidoWMS.TipoDefinicoesLotes := tdlOndaDeSeparacao;
            LfrmFatDefineLotesPedidoWMS.strOndaDeSeparacao  := strNumeroOnda;

            LfrmFatDefineLotesPedidoWMS.strCodSep  := strCodSep;
            LfrmFatDefineLotesPedidoWMS.strCodCli  := cdsPedidos.FieldByName('CODCLI').AsString;
            LfrmFatDefineLotesPedidoWMS.pAtuSepPed := pAtualizaSeparadorPedido;
            LfrmFatDefineLotesPedidoWMS.blnApenasImpressao := not (FTipoImpSep = tisNormal);
            LfrmFatDefineLotesPedidoWMS.blnExpedicao := True;

            If LfrmFatDefineLotesPedidoWMS.blnApenasImpressao Then
            Begin
              LfrmFatDefineLotesPedidoWMS.fCriarObjetos;
              LfrmFatDefineLotesPedidoWMS.btnConfirma.Click;
            End
            Else
              LfrmFatDefineLotesPedidoWMS.ShowModal;

            Result := LfrmFatDefineLotesPedidoWMS.blnConfirma And
                      LfrmFatDefineLotesPedidoWMS.blnSepImp;

            If fCfgSis('WMSMOV', varBoolean) Then
            begin
              cdsPedidos.First;

              While Not cdsPedidos.Eof Do
              Begin
                if fSelecionado(cdsPedidos) then
                  RealizarMovimentacaoProgramadaPedido(fField('AUTINC').AsString, LfrmFatDefineLotesPedidoWMS.blnConfirma, True);

                cdsPedidos.Next;
              End;
            end;
          Finally
            pFreeAndNil(LfrmFatDefineLotesPedidoWMS);
          End;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '');
          End;
        End;
      End;

      //libera o(s) documento(s)
      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin
        if fSelecionado(cdsPedidos) then
        begin
          strDocTra := fField('NUMDOC').AsString;
          strEspTra := fField('ESPDOC').AsString;
          strEmpTra := fField('CODEMP').AsString;
          strCliTra := fField('CODCLI').AsString;

          objLock.fLock_Unlock('FATGOR' + strDocTra + strEspTra + strEmpTra, False, False);
          objLock.fLock_Unlock('CADREC' + strDocTra + strEspTra + strEmpTra + strCliTra, False, False);
        end;

        cdsPedidos.Next;
      End;
    Finally
      cdsPedidos.EnableControls;
    End;

  End;

end;

function TfrmFatExpedicao.fEDocumentoDeDevolucao: Boolean;
begin
  Result := ((fField('ESPDOC').AsString = 'DV') Or
             (fField('ESPDOC').AsString = 'NF')) And
             (Pos(fField('CLAFIS').asString, VS_strClaDev) > 0);
end;

function TfrmFatExpedicao.fExibirDadosTransReqCompraPedido: Boolean;
begin
  Result := (fCfgSis('SLTFRC', varString) = 'S') And (Not blnApenasConferenciaProdutosRetiraCaixa) And
    (Not blnApenasImprimirBaixarSeparacao) And ( (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO) Or (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) ) ;
end;

function TfrmFatExpedicao.fExibirFiltroPorEstoque: Boolean;
begin
  If blnApenasConferenciaProdutosRetiraCaixa Then
    Exit(False);
  Result := (fCfgSis('TIPEXP') = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (VS_strUsaTmq <> 'S') And (fCfgSis('EXPATE') = 'S');
end;

function TfrmFatExpedicao.fExibirInformacaoFaturamentoParcial: Boolean;
begin
  Result := (Not blnApenasConferenciaProdutosRetiraCaixa) And
    (Not blnApenasImprimirBaixarSeparacao) And (fCfgExpedicaoParcialHabilitada) And (fCfgSis('FTEXPC', varString) = 'S');
end;

function TfrmFatExpedicao.fExibirTempoExpedicao: Boolean;
begin
  Result := (Not blnApenasConferenciaProdutosRetiraCaixa) And
    (Not blnApenasImprimirBaixarSeparacao) And (fCfgSis('BXLCSP', varString) = 'S') And (MatchStr(VS_strTipExp, [TIPEXP_POR_DOCUMENTO_DE_VENDA, TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO, TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO]));
end;

function TfrmFatExpedicao.fExisteTransferenciaArmazemOuLoteVendaComTinta(
  const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
var
  qryDados: TUniQuery;
begin
  Result := False;

  If (Not fUsaRotinaWMS) or
     (strEspDoc <> 'PD') Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'SELECT MD.AUTOINCREM '
                       + '  FROM MOVDET MD '
                       + ' INNER JOIN FATDOR FD ON FD.FDO_NUMDOC = MD.DET_NUMFAT '
                       + '                     AND FD.FDO_ESPDOC = MD.DET_TIPFAT '
                       + '                     AND FD.FDO_CODEMP = MD.DET_EMPFAT '
                       + '                     AND FD.FDO_CODITE = MD.DET_CODITE '
                       + ' WHERE MD.DET_ESPDOC IN ("TA","TL") '
                       + '   AND FD.FDO_IDEPRO <> "NOR" '
                       + '   AND FD.FDO_NUMDOC = :NUMDOC '
                       + '   AND FD.FDO_ESPDOC = :ESPDOC '
                       + '   AND FD.FDO_CODEMP = :CODEMP ';

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.Open;

    Result := (Not qryDados.IsEmpty);
  Finally
    FreeAndNil(qryDados);
  End;
end;

function TfrmFatExpedicao.fExpedicaoAtrasada: Boolean;
  Var
    fltTempo: Double;
    fltTolerancia: Double;
begin
  Result := False;

  If (Not fExibirTempoExpedicao()) Then Exit;

  fltTempo      := fField('TMPEXP').AsFloat;
  fltTolerancia := (fCfgSis('TMPEXP', varDouble));

  If ((fltTempo / 60) >= fltTolerancia) Then
    Result := True;   //$00CCFFFF
end;

procedure TfrmFatExpedicao.pAtualizaSeqSep(blnGerarOndaManual : Boolean = False);
  Var
    qryGen: TUniQuery;
begin

  qryGen := fCriaQuery;

  Try

    qryGen.SQL.Clear;

    qryGen.SQL.Add('UPDATE                  ');
    qryGen.SQL.Add('  EXTGOR                ');
    qryGen.SQL.Add('SET                     ');
    qryGen.SQL.Add('  FGO_ONDKIT = :ONDKIT, ');
    qryGen.SQL.Add('  FGO_ONDUNI = :ONDUNI, ');

    qryGen.SQL.Add('  FGO_SEQSEP = ' + IIF(fEmptyStr(strSeqSep), ' NULL ', ':SEQSEP ') + IIF(fOndaSeparacao Or blnGerarOndaManual, ',', ''));

    If (fOndaSeparacao Or blnGerarOndaManual) Then
    Begin
      qryGen.SQL.Add('  FGO_ONDAOP = :ONDAOP,      ');
      qryGen.SQL.Add('  FGO_ONDADT = CURRENT_DATE, ');
      qryGen.SQL.Add('  FGO_ONDAHR = CURRENT_TIME  ');
    End;

    qryGen.SQL.Add('WHERE                      ');
    qryGen.SQL.Add('  FGO_SEQFGO = :AUTINC     ');

    If (blnGerarOndaManual) Then
      qryGen.SQL.Add('  AND ((FGO_SEQSEP IS NULL) Or (FGO_SEQSEP = ""))   ')
    Else
      qryGen.SQL.Add('  AND FGO_SEQSEP IS NULL   ');

    If (qryGen.Params.FindParam('SEQSEP') <> Nil) Then
      qryGen.ParamByName('SEQSEP').AsString := strSeqSep;

    qryGen.ParamByName('ONDKIT').AsString := IIF(blnPDExclusivamenteDeKits, 'S', 'N');
    qryGen.ParamByName('ONDUNI').AsString := IIF(blnOndaSeparacaoUnicoProduto, 'S', 'N');

    If (fOndaSeparacao Or blnGerarOndaManual) Then
      qryGen.ParamByName('ONDAOP').AsString := strLoginUsuarioLogado;

    qryGen.ParamByName('AUTINC').AsString := fField('AUTINC').AsString;

    qryGen.ExecSQL;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmFatExpedicao.fPedeSeparador(tisTipoImp : TTipoImpressaoSeparacao): String;
begin
  If strSenSep = 'S' Then
    Result := fPedeSenhaOperador('Senha do separador')
  Else
    Result := TfrmDigOperador.fGetCodOperador( IfThen(tisTipoImp <> tisWMSTodos, fField('CODSEP').AsString, '') );
end;

function TfrmFatExpedicao.fUtilizandoImpressaoBaixaSeparacaoPassandoPeloColetorOuRobo: Boolean;
begin
  Result := (fCfgSis('DESECO', varBoolean)) Or (fCfgSis('WMSROB', varBoolean));
end;

function TfrmFatExpedicao.fPedidoComTintaImobiliaria : Boolean;
  Var
    qryFatDor : TUniQuery;
Begin
  Try
    qryFatDor := fCriaQuery;
    With qryFatDor, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT FDO_IDEPRO          ');
      Add('FROM FATDOR                ');
      Add('WHERE FDO_NUMDOC = :NUMDOC ');
      Add('  AND FDO_ESPDOC = :ESPDOC ');
      Add('  AND FDO_CODCLI = :CODCLI ');
      Add('  AND FDO_CODEMP = :CODEMP ');
      Add('  AND FDO_IDEPRO <> "NOR"  ');

      ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
      ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
      ParamByName('CODCLI').AsString := fField('CODCLI').AsString;
      ParamByName('CODEMP').AsString := fField('CODEMP').AsString;

      Open;

      If IsEmpty Then
        Exit(False)
      Else
      Begin
        First;
        While Not Eof Do
        Begin
          If (fTipoTinta(FieldByName('FDO_IDEPRO').AsString) In [ttImobiliaria]) Then
            Exit(True);

          Next;
        End;
        Exit(False);
      End;
    End;
  Finally

    FreeAndNil(qryFatDor);
  End;
End;

procedure TfrmFatExpedicao.pCalculaResumoTotalDocumentos;
Var
  intRecNo     : Integer;
  intQtdTotal  : Integer;
  intQtdNaoSep : Integer;
  intQtdSep    : Integer;
  intQtdFat    : Integer;
  fltVlTotal   : Double;
  fltVlNaoSep  : Double;
  fltVlSep     : Double;
  fltVlFat     : Double;
begin
  intRecNo     := 0;
  intQtdTotal  := 0;
  intQtdNaoSep := 0;
  intQtdSep    := 0;
  intQtdFat    := 0;
  fltVlTotal   := 0;
  fltVlNaoSep  := 0;
  fltVlSep     := 0;
  fltVlFat     := 0;

  If (Not blnExibeResumoExpedicao) Then
    Exit;

  Try
    intRecNo := cdsPedidos.RecNo;
    cdsPedidos.DisableControls;

    cdsPedidos.First;
    While (Not cdsPedidos.Eof) Do
    Begin
      //Total
      Inc(intQtdTotal, 1);
      fltVlTotal := fltVlTotal + cdsPedidos.FieldByName('VALDOC').AsFloat;

      If (cdsPedidos.FieldByName('TEMEXP').AsString = 'S') Or (cdsPedidos.FieldByName('EXPTOT').AsString = 'S') Then // A Faturar
      Begin
        Inc(intQtdFat, 1);
        fltVlFat := fltVlFat + cdsPedidos.FieldByName('VALDOC').AsFloat;
      End
      Else If (cdsPedidos.FieldByName('SEPIMP').AsString = '0') Or (fEmptyStr(cdsPedidos.FieldByName('SEPIMP').AsString))  Then // Não separado
      Begin
        Inc(intQtdNaoSep, 1);
        fltVlNaoSep := fltVlNaoSep + cdsPedidos.FieldByName('VALDOC').AsFloat;
      End
      Else // Em Separação
      Begin
        Inc(intQtdSep, 1);
        fltVlSep := fltVlSep + cdsPedidos.FieldByName('VALDOC').AsFloat;
      End;

      cdsPedidos.Next;
    End;
  Finally
    cdsPedidos.RecNo := intRecNo;
    cdsPedidos.EnableControls;

    lblResumoQtdTotal.Caption  := FormatFloat('##00', intQtdTotal);
    lblResumoVlTotal.Caption   := 'R$ ' + FormatFloat('###,###,###,##0.00', fltVlTotal);

    lblResumoQtdNaoSep.Caption := FormatFloat('##00', intQtdNaoSep);
    lblResumoVlNaoSep.Caption  := 'R$ ' + FormatFloat('###,###,###,##0.00', fltVlNaoSep);

    lblResumoQtdSep.Caption    := FormatFloat('##00', intQtdSep);
    lblResumoVlSep.Caption     := 'R$ ' + FormatFloat('###,###,###,##0.00', fltVlSep);

    lblResumoQtdFat.Caption    := FormatFloat('##00', intQtdFat);
    lblResumoVlFat.Caption     := 'R$ ' + FormatFloat('###,###,###,##0.00', fltVlFat);
  End;
end;

function TfrmFatExpedicao.fSelecionaDocumentosLote : String;
  Var
    qryDocs : TUniQuery;
Begin
  qryDocs := fCriaQuery;
  With qryDocs, SQL Do
  Begin
    Try
      Close;
      Clear;

      Add(' SELECT RLD_NUMDOC,                                  ');
      Add('        RLD_ESPDOC,                                  ');
      Add('        RLD_SERIE_,                                  ');
      Add('        RLD_CODEMP                                   ');
      Add(' FROM ROMLGE                                         ');
      Add(' INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM ');
      Add(' WHERE RLG_NUMLOT = :NUMLOT                          ');
      Add('   AND RLG_CODEMP = :CODEMP                          ');
      Add(' ORDER BY RLD_SEQUEN                                 ');

      ParamByName('NUMLOT').AsString := strNumLotSep;
      ParamByName('CODEMP').AsString := strCodEmpLot;

      Open;

      Result := '';

      While Not Eof Do
      Begin
        Result := Result + FieldByName('RLD_NUMDOC').AsString + '-' +
                           FieldByName('RLD_ESPDOC').AsString + '-' +
                           FieldByName('RLD_CODEMP').AsString + '_';
        Next;
      End;

    Finally
      FreeAndNil(qryDocs);
    End;
  End;

End;

procedure TfrmFatExpedicao.pAjustaAlturaPanelBotoes;
Var
  LHeight: Integer;
begin
  FlwBotoes.AutoSize := True;
  FlwBotoes.AutoSize := False;

  LHeight := pnlBotoes.Height;
  pnlBotoes.Height := FlwBotoes.Height + 7;

  If LHeight = pnlBotoes.Height Then
    Exit;

  pnlStatus.Align := AlTop;
  pnlStatus.Align := alBottom;

  pnlBotoes.Align := AlTop;
  pnlBotoes.Align := alBottom;

  pgcExpedicao.Align := AlTop;
  pgcExpedicao.Align := alBottom;

  pnlTotDocs.Align := AlTop;
  pnlTotDocs.Align := alBottom;
end;

procedure TfrmFatExpedicao.pAlteraNomeColumaSEQSEP;
begin
  fGetCol('SEQSEP').Title.Caption := IIF(FUtilizaOndaSeparacaoAgrupamento, 'Remessa de Pedido', 'Seq. Separação');
end;

procedure TfrmFatExpedicao.pAlteraSituacaoFaturamentoTotalPedido(
  strAutInc: String; blnFaturaTotal: Boolean);
var
  qryPedido: TUniQuery;
begin
  qryPedido := fCriaQuery;

  try
    qryPedido.Close;
    qryPedido.SQL.Clear;
    qryPedido.SQL.Add('UPDATE EXTGOR SET FGO_FATTOT = :FATTOT WHERE FGO_SEQFGO = :SEQGER');
    qryPedido.ParamByName('FATTOT').AsString := IIF(blnFaturaTotal, 'S', 'N');
    qryPedido.ParamByName('SEQGER').AsString := strAutInc;
    qryPedido.ExecSQL;
  finally
    FreeAndNil(qryPedido);
  end;
end;

function TfrmFatExpedicao.fRealizouDefinicaoLotesNoLocalSeparacaoSelecionado(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
begin
  Result :=
    fCampoTabela(
      ' SUM(IFNULL(LDO_QTDITE, 0)) ',
      ' FATDOR ' +
      ' INNER JOIN ITEGER ON ITE_CODEMP = FDO_CODEMP AND ITE_CODITE = FDO_CODITE ' +
      ' INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ' +
      ' LEFT  JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ',
      ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP', 'FDO_JAFATU',
      'IF(FDO_QTDITE - FDO_QTDBAI > 0, "S", "N")', 'ITE_CODLSE'],
      [strNumDoc, strEspDoc, strCodEmp, 0, 'S', fGetCodigoLocSep()]) > 0;
end;

function TfrmFatExpedicao.fSepImpAtualizado: String;
begin
  Result := IIF((fField('SEPIMP').AsString = '0') Or
                (fField('SEPIMP').AsString = 'N'), '1',
            IIF((fField('SEPIMP').AsString = '2'), '3',
                 fField('SEPIMP').AsString));
end;

function TfrmFatExpedicao.fVerificaDesmembramento(var blnLimpouSelecaoELocks: Boolean): Boolean;
var
  strBookMa: TBookmark;
  blnFiltered: Boolean;
  blnMostrouMensagem: Boolean;
  strAutIncPed: String;
  frmFatDesmembrarPedido : TfrmFatDesmembrarPedido;
  intQtdDesmebrado: integer;
  intQtdNaoDesmebrado: integer;
  strRegEsp : String;
begin
  blnLimpouSelecaoELocks := False;
  blnVendaPerdidaAutomatica := False;

  Result := True;

  if fCfgSis('EXPDEM', varString) = 'N' then
    Exit;

  blnMostrouMensagem := False;
  intQtdDesmebrado := 0;
  intQtdNaoDesmebrado := 0;

  strBookMa := cdsPedidos.Bookmark;
  cdsPedidos.DisableControls;

  blnFiltered := cdsPedidos.Filtered;
  cdsPedidos.Filtered := False;
  try
    For strAutIncPed In stlPedidos Do
    Begin
      If cdsPedidos.Locate('AUTINC', strAutIncPed, []) Then
      Begin
        If (fField('TEMEXP').AsString = 'S') And (fField('EXPTOT').AsString = 'N') Then
        Begin

          Result := False;

          blnVendaPerdidaAutomatica := (fDesmembrarAutomaticamenteSemPerguntarGerandoVendasPerdidas and (not fPedidoGeraPedencia(strAutIncPed)));

          if (not blnMostrouMensagem) and (not blnVendaPerdidaAutomatica) then
          begin
            strRegEsp := '';
            If Assigned(fField('REGESP')) Then
              strRegEsp := fField('REGESP').AsString;

            If (Not fPedidoTemEnvolvimentoComRegimeEspecial(strRegEsp)) Then
            Begin
              If (Not fPermiteDesmembrarPedidoGeradoDeOutraLoja(False)) Then
                Exit(True);
            End;

            blnMostrouMensagem := True;
            If not (fMensagem('Atenção!', 'Há itens que foram expedidos parcialmente no(s) pedido(s). ' +
                                          'Deseja abrir a tela para realizar o desmembramento?', ['&Sim', '&Não'], 2) = 1) Then
              Exit(True);
          end;

          pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedido);
          Try
            frmFatDesmembrarPedido.strNumPed    := fField('NUMDOC').AsString;
            frmFatDesmembrarPedido.strEspPed    := fField('ESPDOC').AsString;
            frmFatDesmembrarPedido.strEmpPed    := fField('CODEMP').AsString;
            frmFatDesmembrarPedido.blnPedidoRegimeEspecial := fPedidoRegimeEspecial();
            frmFatDesmembrarPedido.arrIteExpPed := fCriarArrItensExpedidosPedido(strAutIncPed);
            frmFatDesmembrarPedido.blnExpedicao := True;
            frmFatDesmembrarPedido.blnDesmembramentoAutomaticoPelaExpedicao := True;

            If (Length(frmFatDesmembrarPedido.arrIteExpPed) > 0) Then
            Begin
              if blnVendaPerdidaAutomatica then
              begin
                frmFatDesmembrarPedido.blnVendaPerdidaAutomatica := True;
                frmFatDesmembrarPedido.cmbOpcFinalizacao.ItemIndex := frmFatDesmembrarPedido.cmbOpcFinalizacao.Items.IndexOf('Gerar vendas perdidas');
                frmFatDesmembrarPedido.pOnShow;
                frmFatDesmembrarPedido.btnConfirma.Click;
              end
              else
                frmFatDesmembrarPedido.ShowModal();

              If frmFatDesmembrarPedido.blnDesmembrou Then
                Inc(intQtdDesmebrado)
              Else
                Inc(intQtdNaoDesmebrado);
            End;
          Finally
            pFreeAndNil(frmFatDesmembrarPedido);
          End;
        End;

      End;
    End;

    if (intQtdDesmebrado > 0) or (intQtdNaoDesmebrado > 0) then
    begin
      blnLimpouSelecaoELocks := True;

      if not blnVendaPerdidaAutomatica then
      begin

        fMensagem(
          'AVISO!',
          IIF(intQtdDesmebrado > 0, intQtdDesmebrado.ToString + ' Desmembramento(s) realizado com sucesso! ', '') +
          IIF(intQtdNaoDesmebrado > 0, intQtdNaoDesmebrado.ToString + ' Desmembramento(s) não foi(ram) concluído(s)!', '')
          , ['&Ok']);

      end
      else
      begin
        pCriaBackUpPedidosSelecionados;
        If (intQtdNaoDesmebrado > 0) Then
          Result := False
        Else
          Result := True;
      end;

      pLimparSelecaoELocks;
      TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
    end;
  finally
    cdsPedidos.Filtered := blnFiltered;
    if cdsPedidos.BookmarkValid(strBookMa) then
      cdsPedidos.Bookmark := strBookMa;
    cdsPedidos.EnableControls;
  end;
end;

function TfrmFatExpedicao.fValidaFormaNegociada(strDocTra, strEspTra, strEmpTra, strCodFpg: String; fltValAdt: Double; blnFaturarExpedidos: Boolean): Boolean;
var
  blnFpgNegAviPendente: Boolean;
begin
  Result := True;
  If (btnFaturarExpedidos.Visible) And (VS_strTipExp = TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) And (not blnFaturarExpedidos) then
    Exit(True);

  blnFpgNegAviPendente := (strCodFpg = '009') And (fltValAdt < fRetornaValorFpgNegAVista(fRetAutIncPedido(strDocTra, strEspTra, strEmpTra)));

  If (btnFaturarExpedidos.Visible) Or (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    {*********************************************************************************************************************}
    {* SE CONFIGURADO QUE TRAVA AS FORMAS DE PAGAMENTO NEGOCIADAS NO CAIXA E FOI INFORMADO VARIAS MODALIDADES E          *}
    {* SE CONFIGURADO QUE GERA UM NOVO PEDIDO DE ENTREGA IMEDIATA NO F11 E O PEDIDO POSSUI ITENS DE ENTREGA IMEDIATA E   *}
    {* SE O PEDIDO NAO FOI ORIGINADO PELO F11 DO RESUMO DE CAIXA, NAO PERMITE FATURAR O MESMO ANTES DE PASSAR PELO CAIXA *}
    {*********************************************************************************************************************}
    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('NPDF11', VarBoolean) And (fPedidoPossuiItensEntregaImediata(strDocTra, strEspTra, strEmpTra)) And
       (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) Then
      Exit(false);

    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('NPRF11', VarBoolean) And (fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra)) And
       (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) Then
      Exit(false);

    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente)  And
       fCfgSis('NPLF11', VarBoolean) And (fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra)) And
       (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) Then
      Exit(false);

    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('LOCRET', VarBoolean) And (fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra)) And
       (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) Then
      Exit(false);
  End;

  If (strEspTra = 'PD') And fCfgSis('LIBPED', varBoolean) Then
  Begin
    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('NPRF11', VarBoolean) And (fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra)) And
      (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) And
      (Not blnApenasConferenciaProdutosRetiraCaixa) Then
      Exit(false);

    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('LOCRET', VarBoolean) And (fPedidoPossuiItensRetira(strDocTra, strEspTra, strEmpTra)) And
      (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) And
      (Not blnApenasConferenciaProdutosRetiraCaixa) Then
      Exit(false);
  End;

  If (btnFaturarExpedidos.Visible) Or (VS_strTipExp <> TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO) Then
  Begin
    {*********************************************************************************************************************}
    {* SE CONFIGURADO QUE TRAVA AS FORMAS DE PAGAMENTO NEGOCIADAS NO CAIXA E FOI INFORMADO VARIAS MODALIDADES E          *}
    {* SE CONFIGURADO QUE GERA UM NOVO PEDIDO DE ENTREGA IMEDIATA NO F11 E O PEDIDO POSSUI ITENS DE ENTREGA IMEDIATA E   *}
    {* SE O PEDIDO NAO FOI ORIGINADO PELO F11 DO RESUMO DE CAIXA, NAO PERMITE FATURAR O MESMO ANTES DE PASSAR PELO CAIXA *}
    {*********************************************************************************************************************}
    If fCfgSis('TFPF11', VarBoolean) And (blnFpgNegAviPendente) And
       fCfgSis('NPDF11', VarBoolean) And (fPedidoPossuiItensEntregaImediata(strDocTra, strEspTra, strEmpTra)) And
      (Not fPedidoOriginadoOutroPedidoPeloF11Caixa(strDocTra, strEmpTra)) And
      (Not blnApenasConferenciaProdutosRetiraCaixa) Then
      Exit(false);
  End;
end;

procedure TfrmFatExpedicao.pVerificaExcluirDocumentoLoteSeparacao;
var
  frmFatDocumentosLoteSep: TfrmFatDocumentosLoteSep;
begin
  if cdsDocsExcluirLoteSep.Active then
    cdsDocsExcluirLoteSep.EmptyDataSet;

  if (fCfgSis('MULSEP', varBoolean)) And fUsaRotinaWms And fVerificaAcessoSistema('PERMITEEXCPDLOTSEP') then
  begin
    pCriarFormularios(TfrmFatDocumentosLoteSep, frmFatDocumentosLoteSep);
    Try
      if frmFatDocumentosLoteSep.fMontaTela(cdsPedidos, stlPedidos) then
      begin
        if frmFatDocumentosLoteSep.ShowModal = mrOk then
        begin
          pCloneDataSet(cdsDocsExcluirLoteSep, frmFatDocumentosLoteSep.cdsDados);

          cdsDocsExcluirLoteSep.Filtered := False;
          cdsDocsExcluirLoteSep.Filter := 'SELECI = True';
          cdsDocsExcluirLoteSep.Filtered := True;
        end;
      end;
    Finally
      pFreeAndNil(frmFatDocumentosLoteSep);
    End;
  end;

end;

function TfrmFatExpedicao.fPedidoGuardado: Boolean;
var
  qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;
  try

    qryDados.SQL.Add('SELECT LOTDOR.AUTOINCREM');
    qryDados.SQL.Add('FROM LOTDOR');
    qryDados.SQL.Add('INNER JOIN FATDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM ');
    qryDados.SQL.Add('WHERE FDO_NUMDOC = :NUMDOC');
    qryDados.SQL.Add('  AND FDO_ESPDOC = :ESPDOC');
    qryDados.SQL.Add('  AND FDO_CODEMP = :CODEMP');
    qryDados.SQL.Add('  AND LDO_PEDCAN = "S"');

    qryDados.ParamByName('NUMDOC').AsString := fField('NUMDOC').AsString;
    qryDados.ParamByName('ESPDOC').AsString := fField('ESPDOC').AsString;
    qryDados.ParamByName('CODEMP').AsString := fField('CODEMP').AsString;

    qryDados.Open;

    Result := not qryDados.IsEmpty;

    if Result then
      fMensagem('', 'Este Pedido de Venda foi marcado para GUARDAR OS ITENS JÁ SEPARADOS. ' +
                    'A reimpressão da separação não poderá ser realizada.', ['&OK']);
  finally
    FreeAndNil(qryDados);
  end;
end;

function TfrmFatExpedicao.fLimpaSeparacaoLoteSep(pgbProgresso: TcxProgressBar): Boolean;
var
  QryFatGor: TUniQuery;
begin
  Result := True;
  QryFatGor := fCriaQuery;
  try
    QryFatGor.SQL.Add('SELECT FATGOR.AUTOINCREM ');
    QryFatGor.SQL.Add('FROM ROMLGE');
    QryFatGor.SQL.Add('INNER JOIN ROMLDE ON RLD_SEQRLG = ROMLGE.AUTOINCREM');
    QryFatGor.SQL.Add('INNER JOIN FATGOR ON RLD_NUMDOC = FGO_NUMDOC AND RLD_ESPDOC = FGO_ESPDOC AND RLD_CODEMP = FGO_CODEMP');
    QryFatGor.SQL.Add('WHERE RLG_NUMLOT = :NUMLOT');
    QryFatGor.SQL.Add('  AND RLG_CODEMP = :CODEMP');
    QryFatGor.SQL.Add('  AND FGO_JAFATU = 0');

    QryFatGor.ParamByName('NUMLOT').AsString := strNumLotSepLimpa;
    QryFatGor.ParamByName('CODEMP').AsString := VS_strCodEmp;
    QryFatGor.Open;

    if QryFatGor.IsEmpty Then
    begin
      fMensagem('', 'Não foram encontrados documentos em aberto para o lote de separação informado!', ['&OK']);
      Exit;
    end;

    QryFatGor.First;
    While Not QryFatGor.Eof Do
    Begin
      If (fItensConferidosNaoFaturados(fQuotedStr(QryFatGor.FieldByName('AUTOINCREM').AsString))) Then
      Begin
        If (fMensagem('', 'O lote possui documentos com itens que já '+
                          'foram conferidos. Ao limpar a separação, a conferência '+
                          'também será zerada. '+ sLineBreak +
                          'Deseja realmente limpar a separação de todos os '+
                          'pedidos do lote de separação de romaneio ' + strNumLotSepLimpa + '?', ['&Sim', '&Não']) = 2) Then
        Begin
          Exit;
        End
        Else
          Break;
      End;

      QryFatGor.Next;
    End;

    FExcluirExtLar := fValidaExcluiEXTLAR;

    QryFatGor.First;
    while not QryFatGor.Eof do
    begin
      Self.fLimpaExpedicaoPedido(QryFatGor.FieldByName('AUTOINCREM').AsString);
      QryFatGor.Next;

      pProgresso(QryFatGor.RecNo, QryFatGor.RecordCount, pgbProgresso);
    end;

    fMensagem('', 'Separação do Lote de Romaneio Limpa com Sucesso!', ['&OK']);
    TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
  finally
    FreeAndNil(QryFatGor);
  end;
end;

procedure TfrmFatExpedicao.pBuscaParametrosAutcom;
const
  S_VENDEDOR = 'SOMENTE_VENDEDOR';
  E_VENDEDOR = 'EXCETO_VENDEDOR';
var
  intParam: Integer;
  intSoVend: Integer;
  intExVend: Integer;
begin
  intSoVend := 0;
  intExVend := 0;

  For intParam := 1 To ParamCount Do
  begin
    if Pos(S_VENDEDOR, ParamStr(intParam)) > 0 then
      intSoVend := intParam
    else if Pos(E_VENDEDOR, ParamStr(intParam)) > 0  then
      intExVend := intParam;
  end;

  if (intSoVend > 0) and (intExVend > 0) then
    fMensagem('', 'Parametros ' + S_VENDEDOR + ' e ' +  E_VENDEDOR + ' não podem ser utilizados juntos!', ['&OK'])
  else if (intSoVend > 0) then
    arrVendedor := fRetVendedores(Copy(ParamStr(intSoVend), Pos('=',ParamStr(intSoVend))+1, Length(ParamStr(intSoVend))))
  else if (intExVend > 0) then
    arrVendedor := fRetVendedoresExceto(Copy(ParamStr(intExVend), Pos('=',ParamStr(intExVend))+1, Length(ParamStr(intExVend))));

  blnTravarFiltroVendedor := (intSoVend > 0) or (intExVend > 0);
end;

function TfrmFatExpedicao.fRetVendedores(strValores: String): TConsultasArray;
Var
  stlVend: TStringList;
  intCont: Integer;
Begin
  stlVend := TStringList.Create;
  try
    stlVend.Delimiter := '_';
    stlVend.DelimitedText := strValores;

    if fEmptyStr(stlVend.Strings[Pred(stlVend.Count)]) then
      stlVend.Delete(Pred(stlVend.Count));

    SetLength(Result, stlVend.Count);
    For intCont := 0 To stlVend.Count -1 Do
    Begin
      Result[intCont].strCodigo := stlVend.Strings[intCont];
    End;

    if Length(Result) = 1 then
      Result[0].strDescri := fRetNomVendRep(Result[0].strCodigo);
  finally
    FreeAndNil(stlVend);
  end;
End;


function TfrmFatExpedicao.fRetVendedoresExceto(strValores: String): TConsultasArray;
Var
  stlVend: TStringList;
  intCont: Integer;
  qryVend: TUniQuery;
Begin
  stlVend := TStringList.Create;
  try
    stlVend.Delimiter := '_';
    stlVend.DelimitedText := strValores;

    if fEmptyStr(stlVend.Strings[Pred(stlVend.Count)]) then
      stlVend.Delete(Pred(stlVend.Count));

    qryVend := fCriaQuery;
    try
      qryVend.SQL.Add('SELECT OPE_CODOPE FROM CADOPE');
      qryVend.Open;

      while not qryVend.Eof do
      begin
        if stlVend.IndexOf(qryVend.FieldByName('OPE_CODOPE').AsString) = -1 then
        begin
          intCont := Length(Result);
          SetLength(Result, intCont + 1);
          Result[intCont].strCodigo := qryVend.FieldByName('OPE_CODOPE').AsString;
        end;

        qryVend.Next;
      end;

      if Length(Result) = 1 then
        Result[0].strDescri := fRetNomVendRep(Result[0].strCodigo);
    finally
      FreeAndNil(qryVend);
    end;
  finally
    FreeAndNil(stlVend);
  end;
End;

function TfrmFatExpedicao.fValidaDireitoDeAcessoParaLimparSeparacao: Boolean;
var
  objLiberacao: TLiberacao;
begin
  Result := True;

  if not fVerificaAcessoSistema('EXPLIMPSEP', strLoginUsuarioLogado) then
  begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgRemota.strDirAce := 'EXPLIMPSEP';
      objLiberacao.objMsgRemota.pAddTexto('Solicitação de liberação para Limpar Separação na expedição');

      objLiberacao.objMsgLibera.pAddTexto('Operador sem permissão para Limpar Separação');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTexto('Documento: '+fField('NUMDOC').AsString + ' - ' + fField('ESPDOC').AsString);
      objLiberacao.objMsgLibera.pAddTexto('Destino: '+fGetDescricaoEntRet(fField('ENTRET').AsString));
      objLiberacao.objMsgLibera.pAddTexto('Transportadora: '+fField('CODTRA').AsString + ' - ' + fField('NOMTRA').AsString);
      objLiberacao.objMsgLibera.pAddQuebra;

      objLiberacao.strDirAce  := 'EXPLIMPSEP';
      objLiberacao.strSenLib  := fCfgSis('SENLBD');
      objLiberacao.strMsgSen  := 'Limpar Separação na expedição';
      objLiberacao.strCodOpe  := strLoginUsuarioLogado;
      objLiberacao.strCliente := fField('CODCLI').AsString + ' - ' + fField('NOMCLI').AsString;
      objLiberacao.pInformaNumDocEspDocCodEmp(fField('NUMDOC').AsString, fField('ESPDOC').AsString, fField('CODEMP').AsString);

      Result := objLiberacao.fLibera;
    finally
      FreeAndNil(objLiberacao);
    end;
  end;
end;

function TfrmFatExpedicao.fImprimeOrdemProducaoItemEstrutura: Boolean;
begin
  Result := False;

  If Not (Pos(VS_strTipExp, '3_4_') > 0) Then
    Exit;

  If Not fCfgSis('ORDPRO', varBoolean) Then
    Exit;

  If Not fCfgSis('IOPEXP', varBoolean) Then
    Exit;

  Result := True;
end;

procedure TfrmFatExpedicao.btnImpOrdemProducaoClick(Sender: TObject);
begin
  If not fImprimeOrdemProducaoItemEstrutura Then
    Exit;

  If fEmptyStr(fField('ORDPRO').AsString) Then
  Begin
    fMensagem('', 'Este Pedido não possui ordem de produção!', ['&OK']);
    Exit;
  End;

  pImpOrdemProdItemEstrutura;
end;

function TfrmFatExpedicao.fValidaPedidoParaDesmembramento(blnValidarAdiantamento: Boolean): Boolean;
begin
  Result := False;

  If (Not cdsPedidos.Active) Or (cdsPedidos.IsEmpty) Then
    Exit;

  If (stlPedidos.Count <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um '+strDescDoc+'.', ['&Ok']);
    Exit;
  End;

  If (stlPedidos.Count > 1) Then
  Begin
    fMensagem('ATENÇÃO!', 'Somente um '+strDescDoc+' pode ser desmembrado por vez.', ['&Ok']);
    Exit;
  End;

  If (Not fPermiteDesmembrarPedidoGeradoDeOutraLoja(True)) Then
    Exit;

  cdsPedidos.Locate('AUTINC', stlPedidos.Strings[0], []);

  If fPedidoFaturadoParcialmente(fField('NUMDOC').AsString, fField('ESPDOC').AsString,
                                 fField('CODEMP').AsString) Then
  Begin
    fMensagem('ATENÇÃO!', 'Documento faturado parcialmente não pode ser alterado!', ['&Ok']);
    Exit;
  End;

  If (blnValidarAdiantamento) Then
  Begin
    If (fField('VALADT').AsFloat > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido desmembrar um pedido que possua adiantamento de cliente.', ['&Ok']);
      Exit;
    End;

    If (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(fField('NUMDOC').AsString,
      fField('ESPDOC').AsString, fField('CODEMP').AsString, fField('CODCLI').AsString) > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido desmembrar um pedido com boleto de adiantamento '+
                            'que ainda não foi baixado pela remessa bancária!', ['&OK']);
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmFatExpedicao.fRetornaTemporariaPedidosPendentes: String;
begin
  Result := EmptyStr;
  If (fCfgSis('UTTEXP', varBoolean)) Then
  Begin
    objTemporariaPedidosExpedicao.pApagarTemporaria(strUltimaTemporariaPedidosAbertoExpedicao);
    Result := objTemporariaPedidosExpedicao.fGerarNovaTemporaria;
    strUltimaTemporariaPedidosAbertoExpedicao := Result;
  End;
end;

function TfrmFatExpedicao.fRetornaTotalProdutosPedidos(
  strListaAutInc: String): Double;
var
  qryProdutos: TUniQuery;
begin
  qryProdutos := fCriaQuery;

  try
    qryProdutos.Close;
    qryProdutos.SQL.Clear;
    qryProdutos.SQL.Add('SELECT COUNT(FDO_QTDITE) AS QTDITE ');
    qryProdutos.SQL.Add('FROM FATDOR');
    qryProdutos.SQL.Add('WHERE FDO_SEQGER IN ('+strListaAutInc+')');
    qryProdutos.Open;

    Result := qryProdutos.FieldByName('QTDITE').AsFloat;
  finally
    FreeAndNil(qryProdutos);
  end;
end;

procedure TfrmFatExpedicao.pSetarFromFatgor(var strResult: String; const strTmpPedidosPendentes: String);
begin
  If (Not fEmptyStr(strTmpPedidosPendentes)) Then
  Begin
    strResult := strResult + ' FROM ' + strTmpPedidosPendentes + ' AS TPDEXP ';
    strResult := strResult + ' JOIN FATGOR ON FATGOR.AUTOINCREM = TPDEXP.TMP_AUTINC ';
  End
  Else
    strResult := strResult + ' FROM FATGOR ';
end;

function TfrmFatExpedicao.fPedidoRegimeEspecial: Boolean;
begin
  Result := (fField('UTIRES').AsString = 'S') And (fCfgSis('UTI_RE', varBoolean));
end;

function TfrmFatExpedicao.fPedidoTemEnvolvimentoComRegimeEspecial(const strRegimeEspecial: String): Boolean;
begin
  Result := False;

  If (Not fAlgumaEmpresaUtilizaRegimeEspecial) Then
    Exit;

  If (Pos('S', strRegimeEspecial) <= 0) Then
    Exit;

  Result := True;
end;

procedure TfrmFatExpedicao.pDesmembrarPedido;
begin
  pAtivaDesativaTimersNotificaoAndRecarga(False);

  If (Not fValidaPedidoParaDesmembramento(True)) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  pAbreTelaDesmembramentoDePedido;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.pAbreTelaDesmembramentoDePedido;
  Var
    frmFatDesmembrarPedido: TfrmFatDesmembrarPedido;
    strMensagem: String;
begin
  pCriarFormularios(TfrmFatDesmembrarPedido, frmFatDesmembrarPedido);
  strMensagem := '';

  Try
    Try
      frmFatDesmembrarPedido.strNumPed    := fField('NUMDOC').AsString;
      frmFatDesmembrarPedido.strEspPed    := fField('ESPDOC').AsString;
      frmFatDesmembrarPedido.strEmpPed    := fField('CODEMP').AsString;
      frmFatDesmembrarPedido.arrIteExpPed := fCriarArrItensExpedidosPedido(stlPedidos.Strings[0], False);
      frmFatDesmembrarPedido.blnExpedicao := False;

      frmFatDesmembrarPedido.cmbOpcFinalizacao.Items.Clear;
      frmFatDesmembrarPedido.cmbOpcFinalizacao.Sorted := False;
      frmFatDesmembrarPedido.cmbOpcFinalizacao.Items.Add('Gerar novo pedido');
      frmFatDesmembrarPedido.cmbOpcFinalizacao.ItemIndex := 0;

      If (Length(frmFatDesmembrarPedido.arrIteExpPed) > 0) Then
      Begin
        frmFatDesmembrarPedido.ShowModal();

        If (frmFatDesmembrarPedido.blnDesmembrou) Then
          strMensagem := 'Desmembramento realizado com sucesso!'
        Else
          strMensagem := 'Desmembramento não foi concluído!';
      End
      Else
        strMensagem := 'Nenhum item para desmembramento foi encontrado. Operação cancelada!';

      pAtualizarSelecao();
      fMensagem('AVISO!', strMensagem, ['&Ok']);
      TFrmGravando.fExecutarModal(pAtualizarGrid, 'Aguarde... Atualizando Documentos!', '');
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmFatExpedicao.pAbreTelaDesmembramentoDePedido]');
        pAtivaDesativaTimersNotificaoAndRecarga(True);
      End;
    End;
  Finally
    pFreeAndNil(frmFatDesmembrarPedido);
  End;
end;

function TfrmFatExpedicao.fTemPedidoDeAbastecimentoPorDepositoComProducaoForaDaLoja: Boolean;
var
  strSeqGerPedidos : String;
  qryAux : TUniQuery;
Begin
  Result := False;

  If fCfgSis('GTEPFL', varBoolean) Then
    Exit;

  strSeqGerPedidos := fCommaText(stlPedidos, True);

  if (fEmptyStr(strSeqGerPedidos)) then
    Exit;

  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Text := 'SELECT COUNT(*) AS QTDE FROM FATGOR '+
                       'LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM '+
                       'WHERE EXTGOR.FGO_ABADEP = "S" '+
                       '  AND FATGOR.FGO_OPRFLJ = "S" '+
                       '  AND FATGOR.AUTOINCREM IN (' + strSeqGerPedidos + ') ';

    qryAux.Open;

    Result := (qryAux.FieldByName('QTDE').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;
End;

function TfrmFatExpedicao.fPedidoComFormulacaoEmAberto: Boolean;
var
  strSeqGerPedidos : String;
  qryAux : TUniQuery;
Begin
  Result := False;

  If not fTemPedidoDeAbastecimentoPorDepositoComProducaoForaDaLoja Then
    Exit;

  strSeqGerPedidos := fCommaText(stlPedidos, True);

  if (fEmptyStr(strSeqGerPedidos)) then
    Exit;

  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Text := 'SELECT COUNT(*) AS QTDE FROM TINDOR '+
                       'WHERE FDO_BAIXAD <> "1" '+
                       '  AND FDO_SEQGER IN (' + strSeqGerPedidos + ') ';

    qryAux.Open;

    Result := (qryAux.FieldByName('QTDE').AsInteger > 0);

  Finally
    FreeAndNil(qryAux);
  End;
End;

procedure TfrmFatExpedicao.pValidaPedidosRemessaSeparacao(ACds: TDataSet);
begin
  if (ACds.FieldByName('TEMSEPDOR').AsString = 'S') then
  begin
    if fCfgSis('GDPDCN', varBoolean) then
    begin
      if (fMensagem('Atenção', 'Pedido ' + ACds.FieldByName('DOCUME').AsString + ' pertence a uma Remessa de Separação já separada, limpar a separação do mesmo pode gerar divergência na separação atual. ' +
        'Deseja guardar itens separados antes de limpar a separação?', ['&Sim', '&Não'], 2) = 1) then
      begin
        SetLength(FGuardarItens, Length(FGuardarItens) + 1);
        FGuardarItens[Pred(Length(FGuardarItens))] := ACds.FieldByName('AUTINC').AsString;
      end
      else if (not fLiberaLimparPedidoOndaSeparacao) then
      begin
        SetLength(FRemoverPedidoLista, Length(FRemoverPedidoLista) + 1);
        FRemoverPedidoLista[Pred(Length(FRemoverPedidoLista))] := ACds.FieldByName('AUTINC').AsString;
      end;
    end
    else if (fMensagem('Atenção', 'Pedido ' + ACds.FieldByName('DOCUME').AsString + ' pertence a uma Remessa de Separação já separada, limpar a separação do mesmo pode gerar divergência na separação atual. ' +
      'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) or (not fLiberaLimparPedidoOndaSeparacao) then
    begin
      SetLength(FRemoverPedidoLista, Length(FRemoverPedidoLista) + 1);
      FRemoverPedidoLista[Pred(Length(FRemoverPedidoLista))] := ACds.FieldByName('AUTINC').AsString;
    end;
  end
  else if (fMensagem('Atenção', 'Pedido ' + ACds.FieldByName('DOCUME').AsString + ' pertence a uma Remessa de Separação, limpar a separação do mesmo pode gerar divergência na separação atual. ' +
    'Deseja realmente continuar?', ['&Sim', '&Não'], 2) = 2) or (not fLiberaLimparPedidoOndaSeparacao) then
  begin
    SetLength(FRemoverPedidoLista, Length(FRemoverPedidoLista) + 1);
    FRemoverPedidoLista[Pred(Length(FRemoverPedidoLista))] := ACds.FieldByName('AUTINC').AsString;
  end;
end;

procedure TfrmFatExpedicao.pAjustaComponentesFeriado;
  Var
    blnExibir: Boolean;
begin
  blnExibir := blnExisteAlgumFeriadoCadastrado;
  If blnExibir Then
  Begin
    blnExibir := (Assigned(qryFerCid)) And (Not qryFerCid.IsEmpty) And
                 (qryFerCid.Locate('CODCID', cdsPedidos.FieldByName('CODCLI').AsString, []));
  End;

  pExibeCamposFeriado(blnExibir);

  If (blnExibir) Then
    pCarregaFeriados;
end;

procedure TfrmFatExpedicao.pExibeCamposFeriado(blnExibir: Boolean);
begin
  lblFeriados.Visible := blnExibir;
  dbgFeriados.Visible := blnExibir;
  dbtCidFer.Visible   := blnExibir;
end;

procedure TfrmFatExpedicao.pCarregaFeriados;
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriaQuery;
  cdsFeriados.EmptyDataSet;

  Try
    pCarregaFeriadosCidade(qryDados, cdsPedidos.FieldByName('CODCID').AsString);

    While (Not qryDados.Eof) Do
    Begin
      cdsFeriados.Append;
      cdsFeriados.FieldByName('FCI_DTAFER').AsDateTime := qryDados.FieldByName('FCI_DTAFER').AsDateTime;
      cdsFeriados.FieldByName('FCI_DESCRI').AsString := qryDados.FieldByName('FCI_DESCRI').AsString;
      cdsFeriados.Post;
      qryDados.Next;
    End;

    cdsFeriados.First;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure TfrmFatExpedicao.pFeriadosPorCodCid(var qryFerCid: TUniQuery; const strLisCodCid: String);
begin
  If (Not Assigned(qryFerCid)) Then
    qryFerCid := fCriaQuery;

  qryFerCid.Close;

  If (strLisCodCid = '') Then
    Exit;

  qryFerCid.SQL.Text :=
      'SELECT FCI_CODCID AS CODCID, COUNT(*) AS QTDFER FROM FERCID '+
      ' WHERE '+
      '  FCI_CODCID IN ('+strLisCodCid+') AND '+
      '  FCI_DTAFER BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 15 DAY) '+
      'GROUP BY FCI_CODCID ';
  qryFerCid.Open;
end;

procedure TfrmFatExpedicao.pCarregaGrid;
begin
  pAtivaDesativaTimersNotificaoAndRecarga(False);
  If (blnExecutandoFormShow Or
      blnExecutandoFormCreate Or
      blnAtualizandoGrid) Then
  Begin
    pAtivaDesativaTimersNotificaoAndRecarga(True);
    Exit;
  End;

  Try
    Screen.Cursor := crHourGlass;

    btnRecarrPed.Click;
    pFiltrarPedidos;
    pCalculaResumoTotalDocumentos();

    dbgPedidos.SelectedRows.Clear;
  Finally
    Screen.Cursor := crDefault;
  End;
  pAtivaDesativaTimersNotificaoAndRecarga(True);
end;

procedure TfrmFatExpedicao.pExibePedidosIntegracaoSemSaldoDisp(AEhOndaSeparacao: Boolean = True);
var
  LMenExp: TfrmMensagemExplicativa_ComConsultaProdutos;
begin
  if (FItensSemSaldoDispParaAtenderPDOnda.Count = 0) then
    Exit;

  pCriarFormularios(TfrmMensagemExplicativa_ComConsultaProdutos, LMenExp);

  try
    LMenExp.Caption := 'Itens SEM Saldo Disponível';
    LMenExp.btnConsultaProdutos.Visible := True;

    LMenExp.Width   := 700;
    LMenExp.Height  := 400;
    LMenExp.Font.Size := 9;
    LMenExp.mmoInstru.Lines.Add('Os pedidos que contém os itens sem saldo suficiente serão desmarcados '+
                                IIF(AEhOndaSeparacao, 'e não entrarão na remessa', 'e não terão a separação impressa') +
                                ', segue relação de item(ns) e pedido(s):');
    LMenExp.mmoInstru.Lines.Add('');
    LMenExp.mmoInstru.Lines.Add(FItensSemSaldoDispParaAtenderPDOnda.Text.Trim);
    LMenExp.mmoInstru.Lines.Add('');
    LMenExp.mmoInstru.Lines.Add(FPedidosCortados.Text.Trim);
    LMenExp.btnSair.Caption := 'Prosseguir';
    LMenExp.ShowModal;
  finally
    pFreeAndNil(LMenExp);
  end;
end;

procedure TfrmFatExpedicao.pAjustaComponentesDeOrientacaoParaEntrega;
begin
  pnlOriEnt.Visible := (Not fEmptyStr(cdsPedidos.FieldByName('ORIENT').AsString));

  If (pnlOriEnt.Visible) Then
    lblOriEnt.Caption := AnsiReplaceStr(cdsPedidos.FieldByName('ORIENT').AsString, '<<csq>>', #13#10);
end;

procedure TfrmFatExpedicao.pAtualizaPercentualDeSeparacao;
  Var
    qryGen : TUniQuery;
begin
  If (Not fUsaRotinaWMS) Then
    Exit;

  If (Not fColunaVisivel('PERSEP')) Then
    Exit;

  If (FLisAutIncFgo = '') Then
    Exit;

  qryGen := fCriaQuery;
  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT D.FDO_SEQGER AS AUTINC, ROUND(IFNULL(((SUM(IFNULL(L.LDO_QTDITE, 0)) * 100) / (SUM(D.FDO_QTDITE) - SUM(D.FDO_QTDBAI))), 0), 2) AS PERSEP ');
  qryGen.SQL.Add('  FROM LOTDOR L ');
  qryGen.SQL.Add('  JOIN FATDOR D ON D.AUTOINCREM = L.LDO_SEQFDO ');
  qryGen.SQL.Add(' WHERE D.FDO_SEQGER IN ('+FLisAutIncFgo+') ');
  qryGen.SQL.Add('GROUP BY D.FDO_SEQGER ');
  qryGen.SQL.Add('HAVING PERSEP > 0 ');
  qryGen.Open;
  qryGen.First;

  pLimparIndices;
  Try
    If (Not qryGen.IsEmpty) Then
    Begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter := 'TABELA = ' + QuotedStr('FATGOR');
      cdsPedidos.Filtered := True;

      cdsPedidos.IndexFieldNames := 'AUTINC';
    End;

    While Not qryGen.Eof Do
    Begin
      If cdsPedidos.FindKey([qryGen.FieldByName('AUTINC').AsString]) Then
      Begin
        cdsPedidos.Edit;
        cdsPedidos.FieldByName('PERSEP').AsString :=  FormatFloat('#,##0.00', qryGen.FieldByName('PERSEP').AsFloat);
        cdsPedidos.Post;
      End;

      qryGen.Next;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmFatExpedicao.pSuspenderTimersRecarga;
begin
  Inc(intSuspensaoTimersRecarga);

  If (intSuspensaoTimersRecarga = 1) Then
  Begin
    blnTmrTmpRteAntSuspensao := tmrTmpRte.Enabled;
    blnTmrTmpIanAntSuspensao := tmrTmpIan.Enabled;
  End;

  tmrTmpRte.Enabled := False;
  tmrTmpIan.Enabled := False;
end;

procedure TfrmFatExpedicao.pRestaurarTimersRecarga;
begin
  If (intSuspensaoTimersRecarga <= 0) Then
    Exit;

  Dec(intSuspensaoTimersRecarga);

  If (intSuspensaoTimersRecarga > 0) Then
    Exit;

  tmrTmpRte.Enabled := blnTmrTmpRteAntSuspensao;
  tmrTmpIan.Enabled := blnTmrTmpIanAntSuspensao;
end;

function TfrmFatExpedicao.fPermiteExecutarRotinaAtualizacaoTela : Boolean;
begin
  Result := True;
  If fFormAtivo('frmFatExpedicaoItens') Then
    Exit(False);
  If fFormAtivo('frmFatLiberacaoCliente') Then
    Exit(False);
end;

end.
