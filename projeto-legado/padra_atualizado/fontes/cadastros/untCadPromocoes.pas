{***********************}
{* qryConIte -> CADITE *}
{********************JB*}

unit untCadPromocoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls, DBEditFocus, DB,
  CheckLst, Uni, StrUtils, untSeqTmp, AppEvnts, UniClientDataSet, Provider,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxClasses, cxControls, cxGridCitel, untParCalculaPrecoCusto, untMemo,
  untModulo, MaskUtils, BitBtnLockedIncrem, cxProgressBar, untTConfiguracao, untExcel,
  ComboBoxFocus, DBComboBoxFocus, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator,
  UniDataSetProvider, MemDS, DBAccess, untGravando, frxClass, frxExportCSVTestabilidade,
  untTypesSistema, Datasnap.DBClient, cxGridLevel, cxGridCustomTableView, untCadPro,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGrid, cxButtons,
  untConstantes, cxGridBandedTableView, cxGridDBBandedTableView, ComObj,
  cxDataControllerConditionalFormattingRulesManagerDialog, Math, cxContainer,
  cxGroupBox, cxRadioGroup, cxDBEdit, QColorLabel, KitPromocao.Classes,
  cxCheckBox, untCustoItemFaturamento, cxInplaceContainer, cxVGrid, cxTextEdit,
  cxDropDownEdit;

resourcestring
  sqlInformacoesCustoITEGER = 'SELECT                                         '+
                              '  I.*,                                         '+
                              '  IF(:TIPABF = "1", C.ITE_CODABF , I.ITE_CODABF)'+
                              '  AS CODABF                                    '+
                              '  FROM ITEGER I                                '+
                              '  JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE '+
                              ' WHERE I.ITE_CODITE = :CODITE                  '+
                              '   AND I.ITE_CODEMP = :CODEMP                  ';

  sqlInformacoesCustoPCMDET = 'SELECT                                         '+
                              '  D.PCD_CODITE AS ITE_CODITE,                  '+
                              '  AVG(D.PCD_UNITAR * (1 - IFNULL(D.PCD_DESUNI, 0) / 100) '+
                              '                   * (1 - IFNULL(D.PCD_DESUN2, 0) / 100) '+
                              '                   * (1 - IFNULL(D.PCD_DESUN3, 0) / 100) '+
                              '                   * (1 - IFNULL(D.PCD_DESUN4, 0) / 100) '+
                              '                   * (1 - IFNULL(D.PCD_DESUN5, 0) / 100) '+
                              '                   * (1 - IFNULL(D.PCD_DESUN6, 0) / 100) '+
                              '  ) AS ITE_PRECOM,                             '+
                              '  0.00 AS ITE_DESF01,                          '+
                              '  0.00 AS ITE_DESF02,                          '+
                              '  0.00 AS ITE_DESF03,                          '+
                              '  0.00 AS ITE_DESF04,                          '+
                              '  0.00 AS ITE_DESF05,                          '+
                              '  0.00 AS ITE_DESF06,                          '+
                              '  0.00 AS ITE_VALFRE,                          '+
                              '  I.ITE_SUBSTI,                                '+
                              '  I.ITE_ICMENT,                                '+
                              '  I.ITE_IPIENT,                                '+
                              '  I.ITE_ACRFIN,                                '+
                              '  I.ITE_FREENT,                                '+
                              '  I.ITE_DESADB,                                '+
                              '  I.ITE_SUBFED,                                '+
                              '  I.ITE_PREDOL,                                '+
                              '  I.ITE_MARBR1,                                '+
                              '  I.ITE_MARBR2,                                '+
                              '  I.ITE_MARBR3,                                '+
                              '  I.ITE_MARBR4,                                '+
                              '  I.ITE_MARBR5,                                '+
                              '  I.ITE_MARBR6,                                '+
                              '  I.ITE_MARBR7,                                '+
                              '  I.ITE_ICMSAI,                                '+
                              '  I.ITE_OUTVAL,                                '+
                              '  I.ITE_DESOPE,                                '+
                              '  I.ITE_IMPFED,                                '+
                              '  I.ITE_TCIFCU,                                '+
                              '  I.ITE_TSCUST,                                '+
                              '  I.ITE_DEPICO,                                '+
                              '  I.ITE_DEICMS,                                '+
                              '  I.ITE_FATREG,                                '+
                              '  IF(:TIPABF = "1", C.ITE_CODABF, I.ITE_CODABF)'+
                              '  AS ITE_CODABF                                '+
                              '  FROM PCMDET D                                '+
                              '  INNER JOIN CADITE C                          '+
                              '          ON C.ITE_CODITE = D.PCD_CODITE       '+
                              '  INNER JOIN ITEGER I                          '+
                              '     ON I.ITE_CODITE = C.ITE_CODITE            '+
                              ' WHERE D.PCD_CODITE = :CODITE                  '+
                              '   AND I.ITE_CODEMP = :CODEMP                  '+
                              '   AND ( FALSE %s )                            '+
                              ' GROUP BY D.PCD_CODITE                         ';

  sqlQtdLimitePedidoCompra  = 'SELECT                                         '+
                              '  SUM(D.PCD_QTDITE) AS QTDLIM                  '+
                              '  FROM PCMDET D                                '+
                              ' WHERE D.PCD_CODITE = :CODITE                  '+
                              '   AND (FALSE %s)                              ';

  sqlInsertPCMPRO           = 'INSERT INTO PCMPRO (AUTOINCREM, PRO_SEQGER,    '+
                              '  PRO_NUMPED, PRO_ESPDOC, PRO_CODEMP,          '+
                              '  PRO_NUMCTN ) VALUES (:AUTINC, :SEQGER,       '+
                              '  :NUMPED, :ESPDOC, :CODEMP, :NUMCTN )         ';

  sqlLoadPCMPRO             = 'SELECT * FROM PCMPRO WHERE PRO_SEQGER = :SEQGER';

  sqlExistsPCMPRO           = 'SELECT                                         '+
                              '  AUTOINCREM                                   '+
                              '  FROM PCMPRO                                  '+
                              ' WHERE PRO_NUMPED = :NUMPED                    '+
                              '   AND PRO_CODEMP = :CODEMP                    '+
                              '   AND PRO_ESPDOC = :ESPDOC                    '+
                              '   AND PRO_NUMCTN = :NUMCTN                    '+
                              '   AND PRO_SEQGER = :SEQGER                    ';

type
  TMontaPrecoCustoVenda = record
    fltDesAdi: Double;
    strTabPre: String;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    intPrzMed: Integer;
  End;

type
  TLogIpr = record
    IPR_DTALOG: TDateTime;
    IPR_HORLOG: TDateTime;
    IPR_CODVEN: String;
    IPR_STATUS: String;
    IPR_CODEMP: String;
    IPR_TABPRE: String;
    IPR_CODITE: String;
    IPR_PRECUS: Double;
    IPR_PREVEN: Double;
    IPR_COMVAR: Double;
    IPR_PRZMED: Integer;
    IPR_COMATA: Double;
    IPR_COMDIS: Double;
    IPR_QTDLIM: Double;
    IPR_PERDES: Double;
    IPR_QTDMIN: Double;
    IPR_PREVE2: Double;
    IPR_PREVE3: Double;
    IPR_PREVE4: Double;
    IPR_PREVE5: Double;
    IPR_PREVE6: Double;
    IPR_PREVE7: Double;
    IPR_PEREST: Double;
    IPR_DESPRO: String;
    IPR_DTAINI: TDateTime;
    IPR_DTAFIN: TDateTime;
    IPR_COMPRO: String;
    IPR_IDXQTD: Integer;
    IPR_ENTIME: String;
    IPR_ENTFUT: String;
    IPR_TABLOI: String;
  end;

  TParametroProduto = record
    strCodIte: String;
    strDesIte: String;
    strCodFab: String;
    strUnidad: String;
    strDesmar: String;
    strSalFis: String;
    strSalDis: String;
    fltQtdMin: Double;
    fltQtdLim: Double;
    fltDesAdi: Double;
    intTabPre: Integer;
    fltComVarIte: Double;
    fltComVarEdt: Double;
    fltPerEst: Double;
    fltComAtaIte: Double;
    fltComAtaEdt: Double;
    fltComDisIte: Double;
    fltComDisEdt: Double;
    intPrzMed: Integer;
    fltPreCusEdt: Double;
    fltPreVenEdt: Double;
    fltPerDes: Double;
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
    fltPreCusIte: Double;
    fltOutVal: Double;
    fltIcmSai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltComTb1: Double;
    fltComTb2: Double;
    fltComTb3: Double;
    fltComTb4: Double;
    fltComTb5: Double;
    fltComTb6: Double;
    fltComTb7: Double;
    fltMarBr1: Double;
    fltMarBr2: Double;
    fltMarBr3: Double;
    fltMarBr4: Double;
    fltMarBr5: Double;
    fltMarBr6: Double;
    fltMarBr7: Double;
    fltPreMed: Double;
    fltPreUlt: Double;
    fltImpUlt: Double;
    fltIpiEnt: Double;
    fltPreCom: Double;
    fltDesF01: Double;
    fltDesF02: Double;
    fltDesF03: Double;
    fltDesF04: Double;
    fltDesF05: Double;
    fltDesF06: Double;
    strPreDol: String;
    strCodAbf: String;
    strCodCli: String;
    strEmpresasSelecionadas: String;
    strTabelasPrecoSelecionadas: String;
    strCndPag: String;
    fltCliVen: Double;
    fltMarBruEst: Double;
    blnPrecoFixoTintaDeMaquinaImobiliaria : Boolean;
  end;

type
  TfrmCadPromocoes = class(TfrmPaiCad)
    dtsCadPro: TDataSource;
    dtsCadPromocoes: TDataSource;
    cdsCndPag: TUniClientDataSet;
    cdsCndPagCODCND: TStringField;
    cdsCndPagCNDPAG: TStringField;
    cdsCndPagDESCND: TStringField;
    tbsClientes: TTabSheet;
    qryProCli: TUniQuery;
    dspProCli: TUniDataSetProvider;
    cdsProCli: TUniClientDataSet;
    cdsProCliPRO_CODCLI: TStringField;
    cdsProCliPRO_SEQGER: TStringField;
    cdsProCliPRO_NOMCLI: TStringField;
    dtsProCli: TDataSource;
    cxgClientes: TcxGridCitel;
    cxgClientesDBTableView1: TcxGridDBTableViewCitel;
    cxgClientesDBTableView1Column1: TcxGridDBColumn;
    cxgClientesDBTableView1Column2: TcxGridDBColumn;
    cxgClientesLevel1: TcxGridLevel;
    pnlPesqCli: TPanel;
    lbl3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lbl4: TLabel;
    edtCodAti: TEditFocus;
    edtDesAti: TEditFocus;
    lbl5: TLabel;
    edtCodCid: TEditFocus;
    edtDesCid: TEditFocus;
    lbl6: TLabel;
    edtEstado: TEditFocus;
    lbl7: TLabel;
    edtCgcCpf: TEditFocus;
    edtNuCnPj: TMaskEditFocus;
    cdsProCliPRO_ATIVID: TStringField;
    cdsProCliPRO_CIDEST: TStringField;
    cdsProCliPRO_CGCCPF: TStringField;
    cxgClientesDBTableView1Column3: TcxGridDBColumn;
    cxgClientesDBTableView1Column4: TcxGridDBColumn;
    cxgClientesDBTableView1Column5: TcxGridDBColumn;
    cdsProCliPRO_CPFMAS: TStringField;
    btnHeranca: TBitBtnLocked;
    btnIncCli: TBitBtnLocked;
    btnCancelCli: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    chkPromocaoRestritaClientesNaoConsumidor: TDBCheckBox;
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodPro: TDBEditFocus;
    dbeDesPro: TDBEditFocus;
    dbeDtaIni: TDBEditFocus;
    dbeDtaFin: TDBEditFocus;
    rdgPreDes: TRadioGroup;
    chkEntFut: TCheckBox;
    btnEstrutura: TBitBtnLocked;
    btnHlpPro: TBitBtnLocked;
    lblQtdLimPro: TLabel;
    lblQtdMinPro: TLabel;
    dbeQtdLim: TDBEditFocus;
    dbeQtdMin: TDBEditFocus;
    lblCategoria: TLabel;
    cbxCategoria: TComboBox;
    cdsProCliPRO_CATEGO: TStringField;
    cxgClientesDBTableView1Column6: TcxGridDBColumn;
    cxStyleTitulosColunas: TcxStyle;
    btnComposicaoPrecoCusto: TBitBtnLocked;
    chkEntIme: TCheckBox;
    rdgComPro: TRadioGroup;
    btnHlpCom: TBitBtnLocked;
    chkSomaCompraPend: TDBCheckBox;
    rdgQtdLim: TRadioGroup;
    btnHlpQtdLim: TBitBtnLocked;
    tbsItens: TTabSheet;
    pnlBotoesExtra: TFlowPanel;
    btnImportarItensPedidoCompra: TBitBtnLocked;
    pnlInformacoesItens: TPanel;
    pnlDadosItem: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lblDescricao: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    lbl1: TLabel;
    Label17: TLabel;
    lbl2: TLabel;
    lbl8: TLabel;
    Bevel1: TBevel;
    shpPreCus: TShape;
    lblPeriodoVig: TLabel;
    lblAte: TLabel;
    Label21: TLabel;
    lblTipoPeriodo: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    edtPreVen: TEditFocus;
    edtPreCus: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDescriIni: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtDescriFin: TEditFocus;
    edtComVar: TEditFocus;
    edtComAta: TEditFocus;
    edtQtdLim: TEditFocus;
    edtPrzMed: TEditFocus;
    edtPerDes: TEditFocus;
    edtQtdMin: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    edtComDis: TEditFocus;
    btnAtuCom: TBitBtnLocked;
    btnDigAtu: TBitBtnLocked;
    btnAtuPerVrl: TBitBtnLocked;
    gpbDesAdi: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    edtDesAdi: TEditFocus;
    cmbTabPre: TComboBoxFocus;
    dbeDtaInicial: TMaskEditFocus;
    dbeDtaFinal: TMaskEditFocus;
    edtPerEst: TEditFocus;
    pnlTabelas: TPanel;
    lblTabPreco: TLabel;
    lblLegCondicoes: TLabel;
    clbTabPre: TCheckListBox;
    pnlRight: TPanel;
    pnlPrecos: TPanel;
    Label18: TLabel;
    edtCusRea: TEditFocus;
    lblMarg04: TLabel;
    edtMarg04: TEditFocus;
    lblMarg01: TLabel;
    edtMarg01: TEditFocus;
    lblMarg05: TLabel;
    edtMarg05: TEditFocus;
    lblMarg02: TLabel;
    edtMarg02: TEditFocus;
    lblMarg06: TLabel;
    edtMarg06: TEditFocus;
    lblMarg03: TLabel;
    edtMarg03: TEditFocus;
    lblMarg07: TLabel;
    edtMarg07: TEditFocus;
    btnInsPla: TBitBtnLocked;
    gpbTabloid: TGroupBox;
    chkTabloid: TDBCheckBox;
    lblTabloid: TLabel;
    btnInsPlaHelp: TBitBtnLocked;
    OpenFile: TOpenDialog;
    Label22: TLabel;
    edtPreCusCad: TEditFocus;
    Label23: TLabel;
    pnlEmpresa: TPanel;
    Label16: TLabel;
    clbEmpresa: TCheckListBox;
    chkEcommerce: TCheckBox;
    pnlTrazerPrecoSugestao: TPanel;
    rdgProPre: TcxDBRadioGroup;
    tbsCondPagto: TTabSheet;
    dtsCndPag: TDataSource;
    pnlCndPag: TPanel;
    lblCndPag: TLabel;
    edtCodCnd: TEditFocus;
    btnIncCndPag: TBitBtnLocked;
    btnCancelCndPag: TBitBtnLocked;
    edtDesCnd: TEditFocus;
    cdsCndPagJURREM: TStringField;
    Label26: TLabel;
    ColorLabel2: TColorLabel;
    edtJurRem: TEditFocus;
    Label24: TLabel;
    FlowPanel1: TFlowPanel;
    btnIncluirTodasCndPag: TBitBtnLocked;
    btnExcluirTodasCndPag: TBitBtnLocked;
    tsKitParaPromocao: TTabSheet;
    dtsProdutoGatilho: TDataSource;
    dtsKits: TDataSource;
    Panel1: TPanel;
    edtGrupoGatilhoParaKit: TMaskEditFocus;
    edtGrupoGatilhoDescParaKit: TEditFocus;
    Label25: TLabel;
    edtUnidadeGatilhoParaKit: TEditFocus;
    edtQuantidadeGatilhoParaKit: TEditFocus;
    Label27: TLabel;
    edtPercentualDescontoGatilhoParaKit: TEditFocus;
    btnAdicionarGatilho: TBitBtnLocked;
    Label28: TLabel;
    edtGrupoBeneficiadoParaKit: TMaskEditFocus;
    edtGrupoBeneficiadoDescParaKit: TEditFocus;
    Label29: TLabel;
    edtUnidadeBeneficiadoParaKit: TEditFocus;
    Label31: TLabel;
    edtPercentualDescontoBeneficiadoParaKit: TEditFocus;
    grdKitProdutoGatilho: TcxGridCitel;
    grdDBKitProdutoGatilho: TcxGridDBBandedTableViewCitel;
    DET_DESGRU: TcxGridDBBandedColumn;
    DET_CODUNI: TcxGridDBBandedColumn;
    DET_QTDGRU: TcxGridDBBandedColumn;
    DET_PERDES: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    Panel2: TPanel;
    Label30: TLabel;
    edtDescricaoKit: TEditFocus;
    btnAdicionarKit: TBitBtnLocked;
    grdKit: TcxGridCitel;
    grdDBKit: TcxGridDBBandedTableViewCitel;
    KIT_DESCRI: TcxGridDBBandedColumn;
    cxGridLevel3: TcxGridLevel;
    Label32: TLabel;
    edtBrindeParaKit: TEditFocus;
    edtBrindeDescParaKit: TEditFocus;
    Label33: TLabel;
    edtQuantidadeBrindeParaKit: TEditFocus;
    dtsProdutoBeneficiado: TDataSource;
    grdKitBrinde: TcxGridCitel;
    grdDBKitBrinde: TcxGridDBBandedTableViewCitel;
    cxGridDBBandedColumn1: TcxGridDBBandedColumn;
    cxGridDBBandedColumn2: TcxGridDBBandedColumn;
    cxGridLevel2: TcxGridLevel;
    dtsBrinde: TDataSource;
    cxGridCitel2: TcxGridCitel;
    cxGridDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel;
    cxGridDBBandedColumn3: TcxGridDBBandedColumn;
    cxGridDBBandedColumn5: TcxGridDBBandedColumn;
    cxGridDBBandedColumn6: TcxGridDBBandedColumn;
    cxGridLevel4: TcxGridLevel;
    lblJurRem: TLabel;
    Label34: TLabel;
    edtQuantidadeBeneficiadoParaKit: TEditFocus;
    cxGridDBBandedTableViewCitel2Column1: TcxGridDBBandedColumn;
    cxgCndPagTableView: TcxGridDBTableViewCitel;
    cxgCndPagLevel: TcxGridLevel;
    cxgCndPag: TcxGridCitel;
    cxgCndPagTableViewCODCND: TcxGridDBColumn;
    cxgCndPagTableViewCNDPAG: TcxGridDBColumn;
    cxgCndPagTableViewDESCND: TcxGridDBColumn;
    cxgCndPagTableViewJURREM: TcxGridDBColumn;
    chkTraPro: TDBCheckBox;
    lblDepart: TLabel;
    cbxProdAtv: TComboBox;
    Label35: TLabel;
    cbxSldZero: TComboBox;
    Label36: TLabel;
    cbxProAtvComp: TComboBox;
    Label37: TLabel;
    cbxImpList: TComboBox;
    Label39: TLabel;
    ckbSaldoZero: TCheckBox;
    Panel3: TPanel;
    rdgGiroEstoq: TRadioGroup;
    Label38: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    mskDtaGiroIni: TMaskEditFocus;
    mskDtaGiroFim: TMaskEditFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesCmp: TEditFocus;
    gpbEntFut: TGroupBox;
    chkAguCli: TCheckBox;
    chkPrevis: TCheckBox;
    chkFalPro: TCheckBox;
    Label42: TLabel;
    edtDesPro: TEditFocus;
    lbl9: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    lbl10: TLabel;
    edtCodSub: TEditFocus;
    edtDesSub: TEditFocus;
    lbl11: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    lbl12: TLabel;
    edtCodCac: TEditFocus;
    edtDesCac: TEditFocus;
    pnlImportarClientesDaPromocao: TPanel;
    btnImportarClientesDaPromocao: TBitBtnLocked;
    rdgUtilizarLimitePorClienteOuVenda: TRadioGroup;
    chkUtilizarLimitePorClienteOuVenda: TCheckBox;
    lblCliVen: TLabel;
    edtCliVen: TEditFocus;
    Label43: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    rdgTipoCliente: TRadioGroup;
    ckbTipoCliente: TCheckBox;
    lblMarBru: TLabel;
    edtMarBru: TEditFocus;
    btnMargemProdutos: TBitBtnLocked;
    pnlSelecao: TPanel;
    lblOpSele: TLabel;
    popOpSele: TPopupMenu;
    mnuMarcaTodos: TMenuItem;
    mnuDesmarcaTodos: TMenuItem;
    N1: TMenuItem;
    mnuInverterSelecao: TMenuItem;
    chkQtdLimiteSalDis: TCheckBox;
    chkQtdMinimaSalDis: TCheckBox;
    lblProm01: TLabel;
    edtProm01: TEditFocus;
    lblProm02: TLabel;
    edtProm02: TEditFocus;
    lblProm03: TLabel;
    edtProm03: TEditFocus;
    lblProm04: TLabel;
    edtProm04: TEditFocus;
    lblProm05: TLabel;
    edtProm05: TEditFocus;
    lblProm06: TLabel;
    edtProm06: TEditFocus;
    lblProm07: TLabel;
    edtProm07: TEditFocus;
    lblValorMinimoProdutos: TLabel;
    dbeVlrMinProd: TDBEditFocus;
    rdgConsideraVlrMin: TRadioGroup;
    cxgItens: TcxGridCitel;
    cxgItensTableView: TcxGridDBBandedTableViewCitel;
    cxgItensIPR_CODITE: TcxGridDBBandedColumn;
    cxgItensITE_CODFAB: TcxGridDBBandedColumn;
    cxgItensITE_DESITE: TcxGridDBBandedColumn;
    cxgItensUNI_SIGUNI: TcxGridDBBandedColumn;
    cxgItensMAR_DESMAR: TcxGridDBBandedColumn;
    cxgItensITE_SALDOS: TcxGridDBBandedColumn;
    cxgItensITE_SALDIS: TcxGridDBBandedColumn;
    cxgItensIPR_QTDLIM: TcxGridDBBandedColumn;
    cxgItensIPR_QTDMIN: TcxGridDBBandedColumn;
    cxgItensIPR_PRZMED: TcxGridDBBandedColumn;
    cxgItensIPR_PERDES: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS: TcxGridDBBandedColumn;
    cxgItensIPR_CUSREA: TcxGridDBBandedColumn;
    cxgItensIPR_MARBRU: TcxGridDBBandedColumn;
    cxgItensIPR_MARLIQ: TcxGridDBBandedColumn;
    cxgItensIPR_PREVEN: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS1: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE1: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR1: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ1: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE1: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS2: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE2: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR2: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ2: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE2: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS3: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE3: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR3: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ3: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE3: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS4: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE4: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR4: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ4: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE4: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS5: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE5: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR5: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ5: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE5: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS6: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE6: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR6: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ6: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE6: TcxGridDBBandedColumn;
    cxgItensIPR_PRECUS7: TcxGridDBBandedColumn;
    cxgItensIPR_CUSRE7: TcxGridDBBandedColumn;
    cxgItensIPR_MARBR7: TcxGridDBBandedColumn;
    cxgItensIPR_MARLQ7: TcxGridDBBandedColumn;
    cxgItensIPR_PREVE7: TcxGridDBBandedColumn;
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
    cxgItensIPR_COMVAR: TcxGridDBBandedColumn;
    cxgItensIPR_COMATA: TcxGridDBBandedColumn;
    cxgItensIPR_COMDIS: TcxGridDBBandedColumn;
    cxgItenslevel: TcxGridLevel;
    pnlPrecoVendaReal: TPanel;
    Panel4: TPanel;
    cxvFiltros: TcxVerticalGrid;
    cxvFiltrosCabecalho: TcxCategoryRow;
    cxvFiltrosCodAbf: TcxEditorRow;
    cxvFiltrosPerAbf: TcxEditorRow;
    cxvFiltrosEstado: TcxEditorRow;
    Panel5: TPanel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    lblValorST: TLabel;
    lblValorIPI: TLabel;
    lblValorTotalVenda: TLabel;
    cxgItensIPR_VENIMP: TcxGridDBBandedColumn;
    cxgItensIPR_BOCCAI: TcxGridDBBandedColumn;
    cxgItensIPR_ICMSAI: TcxGridDBBandedColumn;
    cxgItensIPR_IMPFED: TcxGridDBBandedColumn;
    cxgItensIPR_DESOPE: TcxGridDBBandedColumn;
    btnSimular: TBitBtnLocked;
    ckbPrecoFixoParaTmqImo: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure clbEmpresaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtCodIteEnter(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure dbeDtaIniEnter(Sender: TObject);
    procedure dbeDtaFinEnter(Sender: TObject);
    procedure btnIncCliClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelCliClick(Sender: TObject);
    procedure edtNuCnPjEnter(Sender: TObject);
    procedure cdsProCliCalcFields(DataSet: TDataSet);
    procedure edtCgcCpfChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnDigAtuClick(Sender: TObject);
    procedure btnAtuComClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cxgClientesDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbTabPreExit(Sender: TObject);
    procedure clbEmpresaExit(Sender: TObject);
    procedure clbTabPreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure clbTabPreDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure clbTabPreClickCheck(Sender: TObject);
    procedure btnAtuPerVrlClick(Sender: TObject);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodAtiExit(Sender: TObject);
    procedure edtCodCidExit(Sender: TObject);
    procedure dtsCadPromocoesStateChange(Sender: TObject);
    procedure btnEstruturaClick(Sender: TObject);
    procedure cmbTabPreEnter(Sender: TObject);
    procedure btnHlpProClick(Sender: TObject);
    procedure cbxCategoriaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgItensTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHlpComClick(Sender: TObject);
    procedure rdgComProClick(Sender: TObject);
    procedure btnComposicaoPrecoCustoClick(Sender: TObject);
    procedure btnHlpQtdLimClick(Sender: TObject);
    procedure btnImportarItensPedidoCompraClick(Sender: TObject);
    procedure chkTabloidClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pgcDadosChange(Sender: TObject);
    procedure rdgPreDesClick(Sender: TObject);
    procedure btnInsPlaClick(Sender: TObject);
    procedure btnInsPlaHelpClick(Sender: TObject);
    procedure chkEcommerceClick(Sender: TObject);
    procedure pInsereDEL_ITEPRO;
    procedure pInsereDEL_PROEMP;
    procedure pInsereDEL_CNDPRO;
    procedure pInsereDEL_PROCLI;
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncCndPagClick(Sender: TObject);
    procedure btnCancelCndPagClick(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure btnIncluirTodasCndPagClick(Sender: TObject);
    procedure btnExcluirTodasCndPagClick(Sender: TObject);
    procedure edtGrupoGatilhoParaKitExit(Sender: TObject);
    procedure edtGrupoGatilhoParaKitKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeGatilhoParaKitKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarGatilhoClick(Sender: TObject);
    procedure btnAdicionarKitClick(Sender: TObject);
    procedure grdDBKitProdutoGatilhoKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure grdDBKitKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edtBrindeParaKitExit(Sender: TObject);
    procedure edtBrindeParaKitKeyPress(Sender: TObject; var Key: Char);
    procedure grdDBKitProdutoBeneficiadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdDBKitBrindeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgCndPagTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgCndPagTableViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure rdgGiroEstoqClick(Sender: TObject);
    procedure ckbSaldoZeroClick(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure dtsCadPromocoesDataChange(Sender: TObject; Field: TField);
    procedure chkEntFutClick(Sender: TObject);
    procedure chkAguCliClick(Sender: TObject);
    procedure edtCodRegExit(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubExit(Sender: TObject);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCacExit(Sender: TObject);
    procedure edtCodCacKeyPress(Sender: TObject; var Key: Char);
    procedure btnImportarClientesDaPromocaoClick(Sender: TObject);
    procedure chkUtilizarLimitePorClienteOuVendaClick(Sender: TObject);
    procedure edtCodVenExit(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure ckbTipoClienteClick(Sender: TObject);
    procedure btnMargemProdutosClick(Sender: TObject);
    procedure lblOpSeleClick(Sender: TObject);
    procedure mnuMarcaTodosClick(Sender: TObject);
    procedure mnuDesmarcaTodosClick(Sender: TObject);
    procedure mnuInverterSelecaoClick(Sender: TObject);
    procedure edtPerDesExit(Sender: TObject);
    procedure cxvFiltrosCodAbfEditPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnSimularClick(Sender: TObject);

  strict private
    procedure pMontarRegraPrecoSugestao;
  private
    const
      MSG_DIVERGENCIA_QTDMIN = 'O(s) produto(s) relacionado(s) abaixo já esta(ão) inserido(s) na promoção com a quantidade mínima informada: ';
  private

    FAutoincremPromocao: String;
    FProLog: IProLog;

    FArquivoExcel: String;
    FLockExcel   : Integer;
    FInseriuItem : Boolean;

    blnPreAlt : Boolean;
    blnCusLib : Boolean;
    blnMovPnl : Boolean;
    blnEcomme : Boolean;

    FArrLogIpr: Array Of TLogIpr;

    qryConIte: TUniQuery;
    cdsCadPro: TUniClientDataSet;
    qryCadPro: TUniQuery;
    qryCadUni: TUniQuery;
    intDecUni: Integer;
    blnComPro: Boolean;
    cdsAuxItePro: TUniClientDataSet;
    opcTipDes: TTipDescPro;

    strAltGrd: string;
    strIteAtu: string;
    strEmpSelAnt: String;
    strTabSelAnt: String;

    strCodProAtual: String;

    strCodProExc,
    strCodEmpExc,
    strTabSelExc: String;

    strIndicePromocao: String;

    arrClientes,
    arrAtiv,
    arrCidade,
    arrCndPag,
    arrRegiao,
    arrSubReg,
    arrRede,
    arrCanal,
    arrVended: TConsultasArray;

    stlPromoAltLck: TStringList; //ARMAZENA PROMOCOES QUE ESTÁ SENDO ALTERADA
    blnUsaComissaoCadastroProduto: Boolean;
    stlPedidosCompra: TStringList;
    blnImpPC: Boolean;
    strWherePedidoCompra: String;
    cdsPCMPRO: TUniClientDataSet;
    intPrecisaoDescontoItem: Integer;

    FObjGravaItePro: TGravaItePro;

    FObjKitPromocaoBuilder  : TKitPromocaoBuilder;
    FProdutoAdicionado      : ttipoProduto;
    FblnProdutosAdicionados : Boolean;
    FstrUltimoIDKitGerado   : String;

    FcfgSUGVLE: Integer;
    FcfgCAREST: String;
    FcfgRATEST: Boolean;

    fltValorVendaBKP: Double;
    fltPreVenBKP: Double;
    fltMarBruBKP: Double;

    objCustoItem : ICustoItemFaturamento;
    recCustoItem : TRecResulCusto;

    qryClientesDaPromocao : TUniQuery;

    stlItensQuantidadeMinimaDuplicado : TStringList;

    PromocaoUtilizaLimite : TPromocaoUtilizaLimite;
    blnCalcMargemLiquida: Boolean;
    blnSimuladorPrecoVendaReal: Boolean;
    qryConAbf: TUniQuery;

    FfltBocCai,
    FfltIcmSai,
    FfltImpFed,
    FfltDesOpe,
    FfltPreCus : Double;

    procedure pValidarOpcLimitePorClienteOuVenda;

    procedure pAjustarAbasAoConsiderarCndPag;

    function fEhPromocaoPorQuantidadeMinimaEscalonada : Boolean;

    procedure pCarregaValoresCusto(strCodIte, strCodEmp, strTabPre : String);

    procedure pCriarProLog;

    procedure pMostraComposicaoPrecoCusto(strCodIte: String);

    Procedure pVisiblePanelValores(blnVisible : Boolean);

    procedure pGravaClientesPromocao(strSeqGer: String; pgbStatus: TcxProgressBar = Nil);

    procedure pInsereCliente;
    Function fInsereCliente(pgbStatus: TcxProgressBar): Boolean;

    function fGetSQLClientes : String;
    function fGetClientes : TUniQuery;
    function fAlgumFiltroDeClienteFoiInformado : Boolean;

    procedure pCarregaClientesPromocao(strSeqGer: String);
    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;

    Function  fVerificaPromocoes(Var strMensagem: String; strCodCli, strProAut: String; blnPromoc,
      blnExibeMsg: Boolean; strCodIte, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String): Boolean;
    Function  fCodCli: String;

    function fSqlGiroEstoq:String;

    function fSqlCamposEdits: String;

    procedure pAjustaValoresPromocao;
    function fAjustaValoresPromocao(pgbStatus: TcxProgressBar): Boolean;

    procedure pAtualizaValoresConformeCadIte(strCodPro: String);
    function fAtualizaValoresConformeCadIte(pgbStatus: TcxProgressBar): Boolean;

    procedure pAdicionaItem;
    function fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pCarregaItemAlteracao;

    procedure pCarregaCadIte(blnAtualizaTela: Boolean);

    function  fItemJaCadastrado(strCodIte: String): Boolean;
    procedure pValidaSeItemJaCadastradoQtdMin(strCodIte: String; fltQtdMin : Double; blnValidaExistencia : Boolean = False);

    function fValidaConsulta: boolean;

    procedure pAlteraStatusTemp(strStatus: String);
    procedure pAfterOpen(DataSet: TDataSet);

    procedure pGravarCondicoes(strAutIncPro: String; pgbStatus: TcxProgressBar);
    procedure pCarregaCondicoes(strAutIncPro: String);

    procedure pGravarEmpresas(strAutIncPro: String; pgbStatus: TcxProgressBar = Nil);

    procedure pControlaPrecoDesconto(opcPreDes: TTipDescPro);

    procedure pBuscaDadosCliente;

    procedure pInsereLog(strCodIte, strEmpSel, strTabSel: String; pgbStatus: TcxProgressBar = nil);
    procedure pGravaLog(ACodPro: String; pgbStatus: TcxProgressBar = nil);

    function  fCarregaPromocao(strCodPro: String; blnViaHer: Boolean = False): Boolean;

    procedure pOpenQueryCadPro;

    procedure pCarregaProdutoPromocao(strCodIte: String);

    function fGravarPromocao(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pSetEnabledComissao;
    procedure pStatusLegendaCondicoes(blnValor: Boolean);
    procedure pEscondeColunasTab(intTabPre: Integer);
    procedure pEnableDisableBtnAtuEmLote(blnHabil: Boolean);
    function fAtualizaComissaoCadPro(pgbStatus: TcxProgressBar): Boolean;
    function fDigitaComissaoTodosProdutos(pgbStatus: TcxProgressBar): Boolean;
    function fExibeMsgVerificacaoPromocao(blnPromoc: Boolean; strMsgPro: String; strMsgCli: String): Boolean;
    procedure pAtivaCamposCliente;
    function fExcluirPromocao(pgbStatus: TcxProgressBar): Boolean;

    function fVerificaProdutoTintaMaquina: Boolean;
    function fTemProdutosRelacionadosATinta : Boolean;
    procedure pRetCustoMargemVenda(strCodIte, strTabPre: String; fltDesF07: Double; var fltCusto, fltMargem, fltVenda, fltPreRea: Double);
    procedure pCarregaTabelasDesAdi(strTabPre: String);
    procedure pEnabledEdit(Edit: TCustomEdit);
    procedure pDisableEdit(Edit: TCustomEdit; blnTexto: Boolean = False; blnManterValor: Boolean = False; intQtdDec: Integer = 2);
    function fValidaLimiteMinima(edtLim, edtMin: TCustomEdit; Sender: TObject): Boolean;

    procedure pDestravaELimpaStlPromocLck;
    function  fTravaERegistraStlPromocLck: Boolean;
    function  fRetornaChaveLckPromo : String;
    procedure pSetEnabledCliente;
    function fCalculaCustoEMargem(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pCalculaCustoEMargem();
    procedure pZeraComissao;
    function fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
    function fPreComLiq(DataSet: TDataSet; fltDesF07: Double): Double;
    procedure pGravarQtdDisponivel(strAutIncPro: String; pgbStatus: TcxProgressBar = Nil);
    procedure pAtualizarQtdDisponivelPromocao(strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar = Nil);
    procedure pAtualizarQtdDisponivelPromocaoTodasEmpresas(strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar = Nil);
    procedure pAtualizarQtdDisponivelPromocaoPadrao(strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar = Nil);
    function fGetQtdLimiteEstoqueRemanescente(strCodIte: String): Double;
    function fGetQtdeEmpresasSelecionadas: Integer;
    function fGetEmpresasSelecionada: String;
    procedure pTrataCheckboxEstoqueRemanescente(const opcPreDes: TTipDescPro; const blnEnabled: Boolean = True);
    procedure pTratarBotoes;
    procedure pCarregaPedidosCompraImportados(Const strAutInc: String);
    procedure pGravarPedidosCompraImportados(Const strAutInc: String);
    function fInsereItensExcel(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fGetQtdLimitePedidoCompra(Const strCodIte: String): Double;
    function fCriaCdsPCMPRO: TUniClientDataSet;
    procedure pAddPedidoCompra(const strNumPed, strEspDoc, strCodEmp, strNumCtn: String);
    function fGetWherePedidosImportados: String;
    procedure pEnableDisablePanel(Panel: TPanel; blnEnabled: Boolean = True);
    function fEnabledRdgQtdLim(const opcPreDes: TTipDescPro): Boolean;
    function fPossuiLimite: Boolean;
    function fGetEmpresaPreAlt: String;
    procedure pAdicionaCondicao;
    function fValidaCndPag: Boolean;
    procedure pCarregaCndPag;
    procedure pLimpaInputsDadosItem;
    procedure pLimpaDadosItem;
    function fValidaArrPromocaoRestritaClientesNaoConsumidor:boolean ;
    function fValidaCodCli(strNomCli: String): Boolean;
    function fIncluirClienteCds(var strMsgTmp: String; const strCodCli, strNomCli, srtAtivid, strCidEst, strCfcCpf, strCatego, strCodIte, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String): Boolean;
    procedure pMostraObservacaoCliente(const strMsgCliente: String; blnMSGInexistentes : Boolean = False);

    function fIncluirProdutoCds(var strMsgProJaInc, strMsgProIncOu, strMsgItemEstr01,
      strMsgItemEstr02, strMsgProSemEstoque: String; Parametros: TParametroProduto): Boolean;
    function fGetCndPag: String;

    function fValidarItensIncluidos(qryItens: TUniQuery): Boolean;
    function fPermiteAlterarExcluirTabloid: Boolean;
    procedure pExcluirTodosClientes;
    function fInformouMargemBruta: Boolean;

    procedure pFormataCampos;
    procedure pOpcaoSelecao(strOpcao: Char);
    function fPermiteQtdeLimite: Boolean;
    procedure pCalculaPrecoVenda;
    function fPrecoDeVendaEhObrigatorio: Boolean;
    function fPreenchePrecoDeVenda(fltPreco, fltMargem: Double): Boolean;
    function fRetornaValorCalculoMargem: Double;
    function fValidaInclusaoProdutosMargemLiquida(fltPrecoVenda, fltMargemLiq: Double): Boolean;
    procedure pExibeCampoDePrecoPromocional(qryRetPre: TUniQuery; intIndex: Integer);
    procedure pExibeCamposDePrecoPromocao(blnExibir: Boolean);
    procedure pAjustaCamposOpcaoPromocaoValorMinimo;
    function fValidaCamposPromocaoValorMinimo: Boolean;
    function fValidaQuantidadeMinima(strCodIte: String; fltQtdMin: Double): Boolean;
    procedure pCarregaQueryDadosItem(var qryDados: TUniQuery);
    function fInserirItem: Boolean;
    procedure pCalcularPrecoVendaReal;
    procedure pCarregaInformacoesFiltrosSimuladorPrecoVendaReal;
    procedure pLimparFiltrosPrecoVendaReal;
    procedure pInformacoesComissao(var fltPercComissao: Double;
      var strNomeCampoComissao: String);
    procedure pSetaVisibilidadePrecoFixoTmqImo(const blnProdutoBase : Boolean);
    procedure pDesmarcaPrecoFixoTmqImoQuandoInvisivel;
    function fTipoDePromocaoSuportaPrecoFixoParaTmqImo : Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;
    function fRetornarWherePedidoCompra : String;
    function ValidarListaPedidosCompra : Boolean;

  public
    { Public declarations }
    strCodIte: String;

    FblnAutomatizada: Boolean;

    procedure pMarcarEmpresas(strEmpresas: String);
    procedure pMarcarTabelasPreco(strTabelas: String);

    procedure pCarregaDados;
    function fMsgTabloid(): String;

    function fVerificaProdutos(pgbStatus: TcxProgressBar): String;
    function fVerificaEmpresas: Boolean;
    function fVerificaCamposTela: Boolean;

    procedure pIncluirClienteAutomatizada(const strCodCli, strNomCli, strItens, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String; var strMsgCliente: String);
    procedure pIncluirProdutoAutomatizada(var strMsgProJaInc, strMsgProIncOu, strMsgItemEstr01,
      strMsgItemEstr02, strMsgProSemEstoque: String; Parametros: TParametroProduto);

    function fGetEmpresasSelecionadas: String;
    function fGetTabelasPrecoSelecionadas: String;
    function fGetTabPre : String;
    function fRetPreCus(const fltPreCusOriginal: Double): Double;
    function fRetIcmSai(const fltIcmSaiOriginal: Double): Double;
    function fRetImpFed(const fltImpFedOriginal: Double): Double;
    function fRetDesOpe(const fltDesOpeOriginal: Double): Double;
    function fRetOutVal(const fltOutValOriginal: Double): Double;
    function fRetOutValComDespesa(AOutVal: Double; ACampoVenda: String; ACampoComissao: String): Double; overload;
    function fRetOutValComDespesa(AOutVal: Double; AVlrVenda: Double; APerComissao: Double): Double; overload;
  end;


implementation

uses untPai, untFuncoes, untFuncoesSimples, untConsultas,
  untObservacao, untHerancaPromocao, untFuncoesConsulta,
  untFuncoesGenerica, untCadDadosComPromocao,
  untAltFatorDescItemPromocao, untFuncoesAuxiliares, untMostraEstruturas,
  untAjudaPorAbas, untCustosVariaveis, untCadProdutosCompCusto,
  untIcmsSTParteVenda, untDigPedCompraPromocao, Promocao.Regra.Preco.Sugestao,
  untCadPromocoesItensAdd, untImportacaoClientesDaPromocao, untPesqAux,
  untSimulaLancamentoItemVenda;

{$R *.dfm}

procedure TfrmCadPromocoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadPromocoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (Action <> CaNone) Then
  Begin
    pDeletaTemporaria;
    qryTabela.AfterScroll := nil;
    qryTabela.AfterOpen := nil;
    FreeAndNil(qryCadUni);
    FreeAndNil(cdsAuxItePro);

    cdsPCMPRO.EmptyDataSet();
    FreeAndNil(cdsPCMPRO);

    If Assigned(stlPromoAltLck) Then
    Begin
      pDestravaELimpaStlPromocLck;
      FreeAndNil(stlPromoAltLck);
    End;

    If Assigned(FObjGravaItePro) Then
      FreeAndNil(FObjGravaItePro);

    if Assigned(FObjKitPromocaoBuilder) then
      FreeAndNil(FObjKitPromocaoBuilder);

    stlPedidosCompra.Free;

    If Assigned(stlItensQuantidadeMinimaDuplicado) Then
      FreeAndNil(stlItensQuantidadeMinimaDuplicado);

  End;

end;

procedure TfrmCadPromocoes.FormCreate(Sender: TObject);
begin
  inherited;

  stlItensQuantidadeMinimaDuplicado := TStringList.Create;

  pMontarRegraPrecoSugestao;
  FArquivoExcel := '';
  FLockExcel    := -1;
  FInseriuItem  := False;

  SetLength(FArrLogIpr, 0);

  {Se resolução disponível for inferior ou igual à (1024 x 768), maximiza tela!}
  If (Screen.Width <= 1024) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.WindowState := wsMaximized;

  blnCusLib := fVerificaAcessoSistema('CUSPRO');

  If (Not blnCusLib) Then
    shpPreCus.Brush.Color := clRed;

  blnMovPnl := True;

  cdsAuxItePro := TUniClientDataSet.Create(Self);
  cdsCndPag.CreateDataSet;
  strNomeTabela           := 'CADPRO';
  strNomeCampo            := 'PRO_CODPRO';

  qryTabela               := fCriarQuery('SELECT * FROM CADPRO WHERE FALSE', Self);
  qryTabela.AfterOpen     := pAfterOpen;
  qryTabela.AfterScroll   := pAfterScroll;
  dtsCadPromocoes.DataSet := qryTabela;

  qryConIte               := fCriaQuery(Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodPro;

  pCriaTemporaria;

  tbsCondPagto.TabVisible := (fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S');

  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > fTamPrecoItepro Then
    intDecUni := 4;

  edtQtdLim.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtQtdMin.EditFormat := edtQtdLim.EditFormat;
  edtCliVen.EditFormat := edtQtdLim.EditFormat;

  pVisiblePanelValores(False);
  chkTabloidClick(nil);

  stlPromoAltLck := TStringList.Create;
  stlPedidosCompra := TStringList.Create;
  pPreencheCombo(TCustomComboBox(cbxCategoria),  arrCtgCli);
  cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(' ');
  strWherePedidoCompra := '';

  FObjKitPromocaoBuilder        := TKitPromocaoBuilder.Create;
  dtsProdutoGatilho.DataSet     := FObjKitPromocaoBuilder.CdsProdutoGatilho;
  dtsProdutoBeneficiado.DataSet := FObjKitPromocaoBuilder.CdsProdutoBeneficiado;
  dtsBrinde.DataSet             := FObjKitPromocaoBuilder.CdsBrinde;
  dtsKits.DataSet               := FObjKitPromocaoBuilder.CdsKit;

  pFormataCampos;

  FblnAutomatizada := False;
  fltValorVendaBKP := 0;
  fltPreVenBKP := 0;
  fltMarBruBKP := 0;

  FcfgSUGVLE := fCfgSis('SUGVLE', varInteger);
  FcfgCAREST := fCfgSis('CAREST', varString);
  FcfgRATEST := fCfgSis('RATEST', varString) = 'S';

  If fCfgSis('TABPRD', varBoolean) Then
    objCustoItem := TCustoItemFaturamento.New;


  lblValorMinimoProdutos.Visible := False;
  dbeVlrMinProd.Visible := False;
  If fCfgSis('UTIVMP', varBoolean) Then
  Begin
    rdgPreDes.Items.Add('Preço por valor mínimo do total dos produtos');
    rdgPreDes.Items.Add('% Desconto por valor mínimo do total dos produtos');

    lblValorMinimoProdutos.Visible := True;
    dbeVlrMinProd.Visible := True;
  End;
  rdgConsideraVlrMin.Enabled := False;

  blnSimuladorPrecoVendaReal := (fCfgSis('SIMPVR', varBoolean)) And
                                (Not fEmptyStr(fCfgSis('CLISIM')));
  pnlPrecoVendaReal.Visible  :=  blnSimuladorPrecoVendaReal;

  If blnSimuladorPrecoVendaReal Then
    pCarregaInformacoesFiltrosSimuladorPrecoVendaReal;

  qryConAbf := fCriaQuery(Nil);
end;

procedure TfrmCadPromocoes.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConAbf);
  inherited;
end;

procedure TfrmCadPromocoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F3:
      Begin
        If pgcDados.ActivePage = tbsItens Then
          btnImportarItensPedidoCompra.Click();
      End;
  End;
end;

procedure TfrmCadPromocoes.btnComposicaoPrecoCustoClick(Sender: TObject);
begin
  inherited;

  If fVerificaAcessoSistema('VISCUS', strLoginUsuarioLogado) Then
    pMostraComposicaoPrecoCusto(cdsCadPro.FieldByName('IPR_CODITE').AsString)
  Else
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok']);

end;

procedure TfrmCadPromocoes.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  FInseriuItem := False;
  If (fVerificaEmpresas()) And (fVerificaCampos()) And (fValidaConsulta) Then
  Begin
    if fInserirItem then
    begin
      pAdicionaItem;
      strAltGrd := 'N';
      edtCodIte.Enabled := True;
      cxgItens.Enabled := True;
      FInseriuItem := True;
      fltValorVendaBKP := 0;
      fltPreVenBKP := 0;
      fltMarBruBKP := 0;
    end;
  End;

  pTratarBotoes();
end;

procedure TfrmCadPromocoes.btnDigAtuClick(Sender: TObject);
begin
  inherited;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fDigitaComissaoTodosProdutos;
    frmGravando.ShowModal;
  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[Digitar Comissão para Todos os Produtos da Promoção]');
  End;

  pFreeAndNil(frmGravando);
end;

procedure TfrmCadPromocoes.btnAtuComClick(Sender: TObject);
begin
  inherited;

  If (fMensagem('', 'Este procedimento irá carregar os percentuais de ' + #13 +
                    'comissão de vendedor interno, representante externo loja e' + #13 +
                    'representante externo distribuição que estão no' + #13 +
                    'cadastro de produtos em todos os itens desta promoção. Confirma?', ['&Sim', '&Não']) = 1) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fAtualizaComissaoCadPro;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCadPromocoes.btnAtuPerVrlClick(Sender: TObject);
  Var
    frmAltFatorDescItemPromocao : TfrmAltFatorDescItemPromocao;
begin
  inherited;

  Try
    pCriarFormularios(TfrmAltFatorDescItemPromocao, frmAltFatorDescItemPromocao);

    With frmAltFatorDescItemPromocao Do
    Begin
      opcTipDes := Self.opcTipDes;
      strSelect := AnsiReplaceStr(qryCadPro.SQL.Text, ':CODPRO', QuotedStr(qryCadPro.ParamByName('CODPRO').Text));
      ShowModal;
      If ModalResult = mrOk Then
      Begin
        pCloneDataSet(cdsAuxItePro, frmAltFatorDescItemPromocao.cdsCadPro);
        pAjustaValoresPromocao;
      End;
    End;
  Finally
    pFreeAndNil(frmAltFatorDescItemPromocao);
  End;

end;

procedure TfrmCadPromocoes.btnCancelaClick(Sender: TObject);
Var
  intContador : Integer;
begin
  strAltGrd := 'N';

  inherited;
  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
  pDeletaTemporaria;

  fCarregaPromocao(dbeCodPro.Text);
  pCarregaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);

  For intContador := 0 To Self.ComponentCount - 1 Do
  Begin
    If Components[intContador] is TMaskEdit Then
      TMaskEdit(Self.Components[intContador]).Clear;
    If Components[intContador] is TEditFocus Then
      TEditFocus(Self.Components[intContador]).Clear;
  End;

  pAfterScroll(Nil);

  btnCancelCli.Click;
  btnHeranca.Enabled   := False;

  btnAtuCom.Visible    := False;
  btnDigAtu.Visible    := False;

  pEnableDisableBtnAtuEmLote(False);
  cdsPCMPRO.EmptyDataSet();

  If stlPromoAltLck.Count > 0  Then
    pDestravaELimpaStlPromocLck;

  pgcDados.ActivePageIndex := 0;
  pVisiblePanelValores(False);
  chkTabloidClick(nil);
  pSetEnabledCliente;
  pTratarBotoes();
end;

procedure TfrmCadPromocoes.pCarregaGrupo(Var qryCadGru: TUniQuery);
Begin
  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';
End;

procedure TfrmCadPromocoes.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If edtCodIte.ReadOnly Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadPromocoes.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed, edtDesRed, arrRede, nil, fRetNomeRedeLoja, 'da rede', 5);
end;

procedure TfrmCadPromocoes.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodRegExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodReg, edtDesReg, arrRegiao, nil, fRetNomRegiao, 'da Região');
end;

procedure TfrmCadPromocoes.edtCodRegKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao, False) Then
  Begin
    If fValidaCampos(edtCodReg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodSubExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSub, edtDesSub, arrSubReg, nil, fRetNomSubRegiao, 'da Sub-Região');
end;

procedure TfrmCadPromocoes.edtCodSubKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqSubRegiao(Self, edtCodSub, edtDesSub, Nil, Key, arrSubReg, False) Then
  Begin
    If fValidaCampos(edtCodSub, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVended, fRetNomeOperador, Nil, 'do Vendedor');
end;

procedure TfrmCadPromocoes.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVended, False) then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodDepExit(Sender: TObject);
var
  arrDepartamento: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepartamento, fRetDescDepartamento, nil, 'do departamento');
end;

procedure TfrmCadPromocoes.edtCodDepKeyPress(Sender: TObject; var Key: Char);
var
  arrDepartamento: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepartamento, False) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.dtsCadPromocoesDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  If not qryTabela.IsEmpty Then
    FAutoincremPromocao := qryTabela.FieldByName('AUTOINCREM').AsString;
end;

procedure TfrmCadPromocoes.dtsCadPromocoesStateChange(Sender: TObject);
begin
  inherited;
  pnlPesqCli.Enabled  := qryTabela.State In [dsInsert, dsEdit];
  cxgClientes.Enabled := qryTabela.State In [dsInsert, dsEdit];
  pEnableDisablePanel(pnlCabecalho, qryTabela.State In [dsInsert, dsEdit]);
  pEnableDisablePanel(pnlDadosItem, qryTabela.State In [dsInsert, dsEdit]);
end;

procedure TfrmCadPromocoes.edtGruCmpExit(Sender: TObject);
var
  arrGruCmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesCmp, arrGruCmp, nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmCadPromocoes.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
var
  arrGruCmp: TConsultasArray;
begin
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.pGravarEmpresas(strAutIncPro: String; pgbStatus: TcxProgressBar = Nil);
  Var
    qryGen: TUniQuery;
    intContador: Integer;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM PROEMP WHERE PRO_SEQGER = :SEQGER');
    qryGen.ParamByName('SEQGER').AsString := strAutIncPro;
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('INSERT INTO PROEMP (PRO_SEQGER, PRO_CODEMP) VALUES (:SEQGER, :CODEMP) ');

    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If clbEmpresa.Checked[intContador] Then
      Begin
        qryGen.Close;
        qryGen.ParamByName('SEQGER').AsString := strAutIncPro;
        qryGen.ParamByName('CODEMP').AsString := LeftStr(clbEmpresa.Items[intContador],3);
        qryGen.ExecSQL;
      End;
    End;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadPromocoes.pGravarQtdDisponivel(strAutIncPro: String;
  pgbStatus: TcxProgressBar);
  Var
    qryIprEmp: TUniQuery;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Quantidade Disponível...', 1);

  qryIprEmp := fCriaQuery(Self);

  Try
    qryIprEmp.SQL.Add('INSERT INTO IPREMP (IPR_SEQGER, IPR_CODEMP, IPR_QTDDIS)  ');
    qryIprEmp.SQL.Add('SELECT I.AUTOINCREM, E.PRO_CODEMP, I.IPR_QTDLIM          ');
    qryIprEmp.SQL.Add('  FROM CADPRO C                                          ');
    qryIprEmp.SQL.Add('INNER JOIN ITEPRO I                                      ');
    qryIprEmp.SQL.Add('        ON I.IPR_SEQGER = C.AUTOINCREM                   ');
    qryIprEmp.SQL.Add('INNER JOIN PROEMP E                                      ');
    qryIprEmp.SQL.Add('        ON E.PRO_SEQGER = C.AUTOINCREM                   ');
    qryIprEmp.SQL.Add(' WHERE C.AUTOINCREM = :AUTINC;                           ');
    qryIprEmp.ParamByName('AUTINC').AsString := strAutIncPro;
    Try
      qryIprEmp.ExecSQL;
      pStepStatusGravacao(pgbStatus);
    Except
      On E:Exception Do
        pMensagensErro(E.Message,'[TfrmCadPromocoes.pGravarQtdDisponivel]');
    End;
  Finally
    FreeAndNil(qryIprEmp);
  End;
end;

procedure TfrmCadPromocoes.pTratarBotoes;
begin
  btnComposicaoPrecoCusto.Enabled := (cdsCadPro.State = dsBrowse) And
    (Not cdsCadPro.IsEmpty);
  btnImportarItensPedidoCompra.Enabled := (dtsCadPromocoes.DataSet.State = dsInsert) And
    (TTipDescPro(rdgPreDes.ItemIndex) = tdpNegociacaoEspecialFornecedorPC);
  btnIncluirTodasCndPag.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
  btnExcluirTodasCndPag.Enabled := (qryTabela.State In [dsEdit, dsInsert]);

  btnImportarClientesDaPromocao.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
end;

procedure TfrmCadPromocoes.rdgPreDesClick(Sender: TObject);
begin
  inherited;
  if (rdgPreDes.ItemIndex > 1) and (blnEcomme) then
  begin
    rdgPreDes.ItemIndex := StrToIntDef(strIndicePromocao,0);
    fMensagem('','Opção não habilitada para e-commerce.', ['&Ok']);
    pSetFocus(chkEcommerce);
    exit;
  end
  else if blnEcomme then
    strIndicePromocao := inttostr(rdgPreDes.ItemIndex);
  opcTipDes := TTipDescPro(rdgPreDes.ItemIndex);
  blnImpPC  := (opcTipDes = tdpNegociacaoEspecialFornecedorPC);
  blnPreAlt := (opcTipDes = tdpEstoqueRemanescente);
  pControlaPrecoDesconto(opcTipDes);
  pTrataCheckboxEstoqueRemanescente(opcTipDes);
  pTratarBotoes();

  edtMarBru.Visible := (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos]);
  lblMarBru.Visible := edtMarBru.Visible;

  If (opcTipDes = tdpPromocaoCompostaPorKit) Then
  Begin
    tsKitParaPromocao.TabVisible := True;
    tbsItens.TabVisible          := False;
    chkTabloid.Checked           := True;
    If (chkTabloid.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
      chkTabloid.Field.AsString  := 'S';
    gpbTabloid.Enabled           := False;
  End
  Else
  Begin
    tsKitParaPromocao.TabVisible := False;
    tbsItens.TabVisible          := True;
    gpbTabloid.Enabled           := True;
  End;

  If opcTipDes in [tdpPrecoPorVlrMinProd, tdpDescPorVlrMinProd] Then
  Begin
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);
    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);
  End;

  pValidarOpcLimitePorClienteOuVenda;

  pAjustaCamposOpcaoPromocaoValorMinimo;

end;

function TfrmCadPromocoes.ValidarListaPedidosCompra: Boolean;
begin
  Result := false;

  if stlPedidosCompra = Nil then
    Exit;

  if stlPedidosCompra.Count = 0 then
    Exit;

  Result := true;
end;

procedure TfrmCadPromocoes.pGravarCondicoes(strAutIncPro: String; pgbStatus: TcxProgressBar);
  Var
    qryCndPro: TUniQuery;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Condições Pagamento...');

  qryCndPro := fCriaQuery(Self);
  qryCndPro.SQL.Add('DELETE FROM CNDPRO WHERE CPR_SEQGER = :SEQGER');
  qryCndPro.ParamByName('SEQGER').AsString := strAutIncPro;
  qryCndPro.ExecSQL;

  qryCndPro.SQL.Clear;
  qryCndPro.SQL.Add('INSERT INTO CNDPRO (CPR_SEQGER, CPR_CODCND, CPR_JURREM) VALUES (:SEQGER, :CODCND, :JURREM) ');

  cdsCndPag.DisableControls;
  cdsCndPag.First;
  While (Not cdsCndPag.Eof) Do
  Begin
    pStepStatusGravacao(pgbStatus);

    qryCndPro.Close;
    qryCndPro.ParamByName('SEQGER').AsString := strAutIncPro;
    qryCndPro.ParamByName('CODCND').AsString := cdsCndPag.FieldByName('CODCND').AsString;
    qryCndPro.ParamByName('JURREM').AsString := cdsCndPag.FieldByName('JURREM').AsString;
    qryCndPro.ExecSQL;

    cdsCndPag.Next;
  End;

  cdsCndPag.EnableControls;
  FreeAndNil(qryCndPro);
end;

procedure TfrmCadPromocoes.pCarregaCondicoes(strAutIncPro: String);
  Var
    qryCndPro: TUniQuery;
begin
  qryCndPro := fCriaQuery(Self);
  qryCndPro.SQL.Add('SELECT * FROM CNDPRO JOIN CADCND ON CND_CODIGO = CPR_CODCND WHERE CPR_SEQGER = :SEQGER');
  qryCndPro.ParamByName('SEQGER').AsString := strAutIncPro;
  qryCndPro.Open;

  cdsCndPag.DisableControls;
  cdsCndPag.EmptyDataSet;
  pStatusLegendaCondicoes(False);

  While (Not qryCndPro.Eof) Do
  Begin
    pStatusLegendaCondicoes(True);
    cdsCndPag.Append;
    cdsCndPag.FieldByName('CODCND').AsString := qryCndPro.FieldByName('CND_CODIGO').AsString;
    cdsCndPag.FieldByName('DESCND').AsString := qryCndPro.FieldByName('CND_DESCRI').AsString;
    cdsCndPag.FieldByName('CNDPAG').AsString := fFormataCondPag(qryCndPro.FieldByName('CND_CNDPAG').AsString);
    cdsCndPag.FieldByName('JURREM').AsString := qryCndPro.FieldByName('CPR_JURREM').AsString;
    cdsCndPag.Post;

    qryCndPro.Next;
  End;

  cdsCndPag.EnableControls;
  FreeAndNil(qryCndPro);
end;

procedure TfrmCadPromocoes.pCarregaDados;
begin
  If (TTipDescPro(qryTabela.FieldByName('PRO_IDXPRO').AsInteger) = tdpDescon) Or
     (TTipDescPro(qryTabela.FieldByName('PRO_IDXPRO').AsInteger) = tdpPercentualPorQuantidadeMinimaEscalonada) Or
     (TTipDescPro(qryTabela.FieldByName('PRO_IDXPRO').AsInteger) = tdpPorcentoDescontoQuantidadeColetiva) Then
  Begin
    pAtualizaValoresConformeCadIte(qryTabela.FieldByName('PRO_CODPRO').AsString);
  End;
  if cdsProCli.active then
    cdsProCli.emptyDataSet;
  fCarregaPromocao(dbeCodPro.Text);
  pAfterScroll(Nil);
  rdgPreDes.Enabled  := False;
  rdgComPro.Enabled  := False;
  rdgQtdLim.Enabled  := False;

  If (btnAlterar.Enabled) Then
    pSetFocus(btnAlterar);

  chkTabloidClick(nil);

  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
  pCarregaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);
  pCarregaPedidosCompraImportados(qryTabela.FieldByName('AUTOINCREM').AsString);
  pControlaPrecoDesconto(TTipDescPro(rdgPreDes.ItemIndex));
  pTrataCheckboxEstoqueRemanescente(TTipDescPro(rdgPreDes.ItemIndex));
  rdgConsideraVlrMin.Enabled := False;
end;

procedure TfrmCadPromocoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrPromocoes: TConsultasArray;

begin
  pgcDados.ActivePageIndex := 0;

  {*******************************}
  {* NOVA CONSULTA DE PROMOÇOES *}
  {****************************AC*}

  chrKey := '/';
  pDeletaTemporaria;
  If fPesqPromocoes(Self, Nil, Nil, qryTabela, chrKey, arrPromocoes) Then
  Begin
    pCarregaDados;
  End;
  pTratarBotoes();

  btnAlterar.Enabled := fPermiteAlterarExcluirTabloid;
  btnExcluir.Enabled := fPermiteAlterarExcluirTabloid;
end;

function TfrmCadPromocoes.fCalculaCustoEMargem(pgbStatus: TcxProgressBar): Boolean;
begin
  pInformacao('Aguarde, Calculando custo e margem dos produtos...', pgbStatus);

  With cdsCadPro Do
  Begin
    First;
    While Not Eof Do
    Begin
      pProgresso(RecNo, Recordcount, pgbStatus);
      Edit;
      pCalculaCustoEMargem();
      Post;
      Next;
    End;
    First;
  End;
  Result := True;
end;

procedure TfrmCadPromocoes.pOpenQueryCadPro;
begin
  qryCadPro.Open;
end;

function TfrmCadPromocoes.fCarregaPromocao(strCodPro: String; blnViaHer: Boolean): Boolean;
  Var
    strSQL: String;
    frmAguarde: TfrmGravando;
begin
  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PRO_IDXPRO, ';
  strSQL := strSQL + '  PRO_PREDES, ';
  strSQL := strSQL + '  PRO_DESADI, ';
  strSQL := strSQL + '  PRO_ENTIME, ';
  strSQL := strSQL + '  PRO_ECOMME, ';
  strSQL := strSQL + '  PRO_ENTFUT, ';
  strSQL := strSQL + '  PRO_AGUCLI, ';
  strSQL := strSQL + '  PRO_PREVIS, ';
  strSQL := strSQL + '  PRO_FALPRO, ';
  strSQL := strSQL + '  PRO_QTDLIM, ';
  strSQL := strSQL + '  PRO_QTDMIN, ';
  strSQL := strSQL + '  PRO_COMPRO, ';
  strSQL := strSQL + '  PRO_IDXQTD, ';
  strSQL := strSQL + '  PRO_TIPCLI, ';
  strSQL := strSQL + IIF(blnViaHer, '  "A" AS IPR_STATUS, ', '  "N" AS IPR_STATUS, ');
  strSQL := strSQL + '  " " AS IPR_STALOG, ';
  strSQL := strSQL + '  IPR_CODITE, ';
  strSQL := strSQL + '  ITE_CODFAB, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE_REFERE, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + '  (IFNULL(ITE_SALDOS, 0) + IFNULL(ITE_QTEF_A, 0) + IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) ';
  strSQL := strSQL + '      + IFNULL(ITE_QTPDBF, 0)) AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel('', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL + '  IPR_QTDLIM, ';
  strSQL := strSQL + '  IPR_QTDMIN, ';
  strSQL := strSQL + '  IPR_VLDSAD, ';
  strSQL := strSQL + '  IPR_TBDSAD, ';
  strSQL := strSQL + '  IFNULL(IPR_PRZMED, 0) AS IPR_PRZMED, ';
  strSQL := strSQL + '  IFNULL(IPR_PEREST, 0) AS IPR_PEREST, ';
  // VALORES DA PROMOÇÃO POR PRECO
  strSQL := strSQL + '  IFNULL(IPR_PRECUS, 0.00) AS IPR_PRECUS, ';

  strSQL := strSQL + '  0.00 AS IPR_PRECUS1, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS2, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS3, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS4, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS5, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS6, ';
  strSQL := strSQL + '  0.00 AS IPR_PRECUS7, ';

  strSQL := strSQL + '  0.00 AS IPR_CUSREA, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBRU, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLIQ, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVEN, 0.00) AS IPR_PREVEN, ';
  strSQL := strSQL + '  0.00 AS IPR_VENIMP, ';
  strSQL := strSQL + '  0.00 AS IPR_BOCCAI, ';
  strSQL := strSQL + '  0.00 AS IPR_ICMSAI, ';
  strSQL := strSQL + '  0.00 AS IPR_IMPFED, ';
  strSQL := strSQL + '  0.00 AS IPR_DESOPE, ';

  // VALORES DA PROMOCAO POR PERCENTUAL
  strSQL := strSQL + '  IFNULL(IPR_PERDES, ' + fFloatToStrPonto(0, 12, intPrecisaoDescontoItem) + ') AS IPR_PERDES, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE1, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR1, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ1, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVEN, 0.00) AS IPR_PREVE1, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE2, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR2, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ2, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE2, 0.00) AS IPR_PREVE2, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE3, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR3, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ3, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE3, 0.00) AS IPR_PREVE3, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE4, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR4, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ4, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE4, 0.00) AS IPR_PREVE4, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE5, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR5, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ5, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE5, 0.00) AS IPR_PREVE5, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE6, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR6, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ6, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE6, 0.00) AS IPR_PREVE6, ';
  strSQL := strSQL + '  0.00 AS IPR_CUSRE7, ';
  strSQL := strSQL + '  0.00 AS IPR_MARBR7, ';
  strSQL := strSQL + '  0.00 AS IPR_MARLQ7, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVE7, 0.00) AS IPR_PREVE7, ';
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
  strSQL := strSQL + '  IFNULL(IPR_COMVAR, 0.00) AS IPR_COMVAR, ';
  strSQL := strSQL + '  IFNULL(IPR_COMATA, 0.00) AS IPR_COMATA, ';
  strSQL := strSQL + '  IFNULL(IPR_COMDIS, 0.00) AS IPR_COMDIS, ';
  strSQL := strSQL + '  " " AS AUX_MODIFI, ';
  strSQL := strSQL + '  0.00 AS AUX_VALATU, ';

  strSQL := strSQL + '  ITE_IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM, ';
  strSQL := strSQL + '  ITE_DESF01, ';
  strSQL := strSQL + '  ITE_DESF02, ';
  strSQL := strSQL + '  ITE_DESF03, ';
  strSQL := strSQL + '  ITE_DESF04, ';
  strSQL := strSQL + '  ITE_DESF05, ';
  strSQL := strSQL + '  ITE_DESF06, ';
  strSQL := strSQL + '  ITE_PREDOL, ';
  strSQL := strSQL + '  ITEPRO.IPR_SEQGER, ';
  strSQL := strSQL + '  ITEPRO.AUTOINCREM, ';
  strSQL := strSQL + '  ITEPRO.IPR_CODEMP, ';
  strSQL := strSQL + '  ITEPRO.IPR_ULTALT, ';

  If (fCfgSis('TIPABF') = '1') Then
    strSQL := strSQL + ' CADITE.ITE_CODABF AS ITE_CODABF '
  Else
    strSQL := strSQL + ' ITEGER.ITE_CODABF AS ITE_CODABF ';

  strSQL := strSQL + '  ,CADPRO.AUTOINCREM AUTINC_PROMOCAO';
  strSQL := strSQL + '  ,IPR_SEQKIT ';

  strSQL := strSQL + '  ,PRO_UTILIM ';
  strSQL := strSQL + '  ,PRO_LIMCLI ';
  strSQL := strSQL + '  ,PRO_LIMVEN ';
  strSQL := strSQL + '  ,IPR_CLIVEN ';
  strSQL := strSQL + '  ,PRO_UTILIM ';
  strSQL := strSQL + '  ,IFNULL(PRO_VLRMIN, 0.00) AS PRO_VLRMIN ';
  strSQL := strSQL + '  ,IFNULL(PRO_TIPPVM, -1) AS PRO_TIPPVM ';
  strSQL := strSQL + '  ,CADITE.ITE_ITEBAS ';
  strSQL := strSQL + '  ,CADITE.ITE_ITEPIG ';
  strSQL := strSQL + '  ,CADITE.ITE_PROEMB ';
  strSQL := strSQL + '  ,CADITE.ITE_CNV_ML ';
  strSQL := strSQL + '  ,IPR_PFTMIM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPRO, ';
  strSQL := strSQL + '  ITEPRO, ';
  strSQL := strSQL + '  CADITE, ';
  strSQL := strSQL + '  ITEGER, ';
  strSQL := strSQL + '  CADUNI, ';
  strSQL := strSQL + '  CADMAR  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEPRO.IPR_CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI AND ';
  strSQL := strSQL + '  CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR AND ';
  strSQL := strSQL + '  ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM AND ';
  strSQL := strSQL + '  ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  strSQL := strSQL + '  CADPRO.PRO_CODPRO = :CODPRO ';

  With qryCadPro Do
  Begin
    Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODPRO').AsString := strCodPro;

    TfrmGravando.fExecutarModalA(pOpenQueryCadPro, 'Aguarde, Carregando itens da promoção ...', '');
  End;

  dtsCadPro.DataSet := nil;

  If Assigned(cdsCadPro) Then
    FreeAndNil(cdsCadPro);

  cdsCadPro := fCriaClientDatset(qryCadPro, False, Self);
  cdsCadPro.Filter := 'IPR_STATUS <> ' + QuotedStr('D');
  cdsCadPro.Filtered := True;

  With cdsCadPro do
  Begin
    TFloatField(FieldByName('PRO_QTDLIM')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('PRO_QTDMIN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('IPR_QTDLIM')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('IPR_QTDMIN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(FieldByName('PRO_VLRMIN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PEREST')).DisplayFormat := '#,##0.00';

    // VALORES DA PROMOÇÃO POR PRECO
    TFloatField(FieldByName('IPR_PRECUS')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('IPR_PRECUS1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PRECUS7')).DisplayFormat := '#,##0.00';

    TFloatField(FieldByName('IPR_CUSREA')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBRU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLIQ')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_VENIMP')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_BOCCAI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_ICMSAI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_IMPFED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_DESOPE')).DisplayFormat := '#,##0.00';

    // VALORES DA PROMOCAO POR PERCENTUAL
    TFloatField(FieldByName('IPR_PERDES')).DisplayFormat := fMskDigitos(intPrecisaoDescontoItem);
    TFloatField(FieldByName('IPR_CUSRE1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE1')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE2')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE3')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE4')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE5')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE6')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('IPR_CUSRE7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARBR7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_MARLQ7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_PREVE7')).DisplayFormat := fMskDigitos(intDecUni);

    // VALORES DO CADASTRO DE PRODUTOS
    TFloatField(FieldByName('ITE_PRECUS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_CUSREA')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARBR1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ1')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE1')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ2')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE2')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ3')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE3')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ4')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE4')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ5')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE5')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ6')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE6')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_MARBR7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARLQ7')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREVE7')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_PREMED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREULT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IMPULT')).DisplayFormat := '#,##0.00';

    // COMISSÃO
    TFloatField(FieldByName('IPR_COMVAR')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_COMATA')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('IPR_COMDIS')).DisplayFormat := '#,##0.00';

    //SALDO
    TFloatField(FieldByName('ITE_SALFIS')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_SALDIS')).DisplayFormat := '#,##0.000';

    If Not FieldByName('PRO_IDXPRO').IsNull Then
      rdgPreDes.ItemIndex := FieldByName('PRO_IDXPRO').AsInteger
    Else If (FieldByName('PRO_PREDES').AsString = 'D') Then
      rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon]
    Else If (FieldByName('PRO_DESADI').AsString = 'S') Then
      rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional]
    Else If (FieldByName('PRO_PREDES').AsString = 'P') Then
      rdgPreDes.ItemIndex := IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos];

    If (FieldByName('PRO_COMPRO').AsString = 'P') Then
      rdgComPro.ItemIndex := 0
    Else
      rdgComPro.ItemIndex := 1;

    rdgQtdLim.ItemIndex := FieldByName('PRO_IDXQTD').AsInteger;

    chkEntIme.Checked := FieldByName('PRO_ENTIME').AsString = 'S';
    chkEntFut.Checked := FieldByName('PRO_ENTFUT').AsString = 'S';
    chkAguCli.Checked := FieldByName('PRO_AGUCLI').AsString = 'S';
    chkPrevis.Checked := FieldByName('PRO_PREVIS').AsString = 'S';
    chkFalPro.Checked := FieldByName('PRO_FALPRO').AsString = 'S';
    chkEcommerce.Checked := FieldByName('PRO_ECOMME').AsString = 'S';

    PromocaoUtilizaLimite := IIF(FieldByName('PRO_LIMCLI').AsString.Equals('S'), pulLimitarPorCliente,
                             IIF(FieldByName('PRO_LIMVEN').AsString.Equals('S'), pulLimitarPorVenda, -1));

    chkUtilizarLimitePorClienteOuVenda.Checked := FieldByName('PRO_UTILIM').AsString.Equals('S');
    chkUtilizarLimitePorClienteOuVendaClick(chkUtilizarLimitePorClienteOuVenda);

    rdgConsideraVlrMin.ItemIndex := FieldByName('PRO_TIPPVM').AsInteger;

    If fEmptyStr(FieldByName('PRO_TIPCLI').AsString) then
    Begin
      ckbTipoCliente.Checked := False;
      rdgTipoCliente.Enabled := False;
      rdgTipoCliente.ItemIndex := -1;
      btnIncCli.Enabled := True;
    End
    Else
    Begin
      ckbTipoCliente.Checked := True;
      rdgTipoCliente.Enabled := True;
      rdgTipoCliente.ItemIndex := IIF(FieldByName('PRO_TIPCLI').AsString = 'J', 0, 1);;
      btnIncCli.Enabled := False;
    End;

    rdgUtilizarLimitePorClienteOuVenda.ItemIndex := -1;

    If chkUtilizarLimitePorClienteOuVenda.Checked Then
      rdgUtilizarLimitePorClienteOuVenda.ItemIndex := IIF(PromocaoUtilizaLimite = pulLimitarPorCliente, pulLimitarPorCliente, pulLimitarPorVenda);

    pValidarOpcLimitePorClienteOuVenda;

    If rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
      FObjKitPromocaoBuilder.fCarregarPromocao(FieldByName('AUTINC_PROMOCAO').AsString)
    Else
      FObjKitPromocaoBuilder.pLimparClients;

    pAjustaCamposOpcaoPromocaoValorMinimo;

    If Not IsEmpty Then
    Begin
      Try
        pCriarFormularios(TfrmGravando, frmAguarde);
        frmAguarde.fExecutarAcao := fCalculaCustoEMargem;
        frmAguarde.ShowModal;
        pControlaPrecoDesconto(TTipDescPro(rdgPreDes.ItemIndex));
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;
      pFreeAndNil(frmAguarde);
    End;

  End;

  dtsCadPro.DataSet := cdsCadPro;

  Result := True;
end;

function TfrmCadPromocoes.fIncluirClienteCds(var strMsgTmp: String;
  const strCodCli, strNomCli, srtAtivid, strCidEst, strCfcCpf,
  strCatego, strCodIte, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String): Boolean;
begin
  Result := True;
  strMsgTmp := '';

  if not FblnAutomatizada then
  begin
    if cdsProCli.Locate('PRO_CODCLI', strCodCli, []) then
      Exit;
  end;

  if not fCfgSis('VCPPRO', varBoolean) then
    If not fVerificaPromocoes(strMsgTmp,
                              strCodCli,
                              dbeCodPro.Text,
                              True,
                              False,
                              strCodIte,
                              strEmpresasSelecionadas,
                              strTabelasPrecoSelecionadas) Then
      Exit(False);

  cdsProCli.Insert;
  cdsProCli.FieldByName('PRO_CODCLI').AsString := strCodCli;
  cdsProCli.FieldByName('PRO_NOMCLI').AsString := strNomCli;
  cdsProCli.FieldByName('PRO_ATIVID').AsString := srtAtivid;
  cdsProCli.FieldByName('PRO_CIDEST').AsString := strCidEst;
  cdsProCli.FieldByName('PRO_CGCCPF').AsString := strCfcCpf;
  cdsProCli.FieldByName('PRO_CATEGO').AsString := strCatego;
  cdsProCli.Post;
end;

function TfrmCadPromocoes.fIncluirProdutoCds(var strMsgProJaInc, strMsgProIncOu, strMsgItemEstr01,
  strMsgItemEstr02, strMsgProSemEstoque: String; Parametros: TParametroProduto): Boolean;
var
  recIteEst: TItemEstru;
  fltEstPro: Double;
  fltCusto: Double;
  fltMargem: Double;
  fltVenda: Double;
  fltPreRea: Double;
  intCnt : Integer;
  strMsgCli: String;
  strMsgPro: String;
  strMsgCnd: String;

  procedure pZerarCustoPorTabelas;
  var
    intCnt : Integer;
  begin
    For intCnt := 1 To 7 Do
      cdsCadPro.FieldByName('IPR_PRECUS' + intCnt.ToString).AsFloat := 0;
  end;

  procedure pCarregarCustoPorTabelas;
  var
    intCnt : Integer;
  begin
    If Assigned(objCustoItem) Then
    Begin
      For intCnt := 1 To clbTabPre.Items.Count Do
      Begin
        If clbTabPre.Checked[intCnt-1] Then
          cdsCadPro.FieldByName('IPR_PRECUS' + intCnt.ToString).AsFloat := objCustoItem.Get(cdsCadPro.FieldByName('IPR_CODITE').AsString, VS_strCodEmp, intCnt.ToString).fltPreCus;
      End;
    End;
  end;

begin

  recIteEst := fEhOuCompoeEstrutura(Parametros.strCodIte);
  fltEstPro := 0;

  If (TTipDescPro(rdgPreDes.ItemIndex) = tdpEstoqueRemanescente) Then
    fltEstPro := IIF((btnConfirmar.Tag = 0), fGetQtdLimiteEstoqueRemanescente(Parametros.strCodIte), cdsCadPro.FieldByName('IPR_QTDLIM').AsFloat)
  Else If (blnImpPC) Then
    fltEstPro := fGetQtdLimitePedidoCompra(Parametros.strCodIte);

  //SUGVLE - SUSGESTÃO DO PREÇO DE VENDA: [1=DO ITEM PRINCIPAL] [2=SOMANDO ITENS ESTRUTURA]
  //CAREST - PERGUNTA SE CARREGA ESTRUTURA: ['S'=PERGUNTA] ['N'=SEMPRE CARREGA ITEM PRINCIPAL] ['P'=SEMPRE CARREGA ITENS ESTRUTURA]
  //RATEST - RATEIA O VALOR DA VENDA ENTRE OS ITENS ESTRUTURA;

  //COMEÇA A VERIFICAR AS EXCESSÕES
  If (recIteEst.blnEstrutura) And (recIteEst.blnPrincipal) And
     (FcfgSUGVLE = 1) And (CharInSet(FcfgCAREST[1], ['P'])) And (Not FcfgRATEST) Then
  Begin
    //DEVERIA CADASTRAR OS SUB-PRODUTOS, MAS ESTÁ TENTANDO CADASTRAR ITEM PRINCIPAL
    strMsgItemEstr01 := strMsgItemEstr01 + IIF(fEmptyStr(strMsgItemEstr01),'',', ') + Parametros.strCodIte;
  End

  Else If (recIteEst.blnEstrutura) And (recIteEst.blnPrincipal) And
          (FcfgSUGVLE = 2) Then
  Begin
    //DEVERIA CADASTRAR OS SUB-PRODUTOS, MAS ESTÁ TENTANDO CADASTRAR ITEM PRINCIPAL
    strMsgItemEstr02 := strMsgItemEstr02 + IIF(fEmptyStr(strMsgItemEstr02),'',', ') + Parametros.strCodIte;
  End

  //SE EM OUTRA PROMOÇÃO, PULA
  Else If (strAltGrd = 'N') And (fItemCadastradoPromocao(IIF(dbeCodPro.Text <> '', dbeCodPro.Text, ''),
                                                         Parametros.strCodIte,
                                                         Parametros.strEmpresasSelecionadas,
                                                         Parametros.strCodCli,
                                                         Parametros.strTabelasPrecoSelecionadas,
                                                         Parametros.strCndPag,
                                                         StrToDate(dbeDtaIni.Text),
                                                         StrToDate(dbeDtaFin.Text),
                                                         strMsgCli,
                                                         strMsgPro,
                                                         strMsgCnd,
                                                         chkTabloid.Checked)) Then
  Begin
    strMsgProIncOu := strMsgProIncOu + strMsgPro + #13#10;
  End

  //SE JÁ NESTA PROMOÇÃO, PULA
  Else If (strAltGrd = 'N') And (fItemJaCadastrado(Parametros.strCodIte)) Then
  Begin
    strMsgProJaInc := strMsgProJaInc + Parametros.strCodIte + '  -  ' + Parametros.strDesIte + #13#10;
  End

  //SE NÃO TIVER ESTOQUE REMANESCENTE, PULA
  Else If (strAltGrd = 'N') And (fltEstPro <= 0) And (TTipDescPro(rdgPreDes.ItemIndex) = tdpEstoqueRemanescente) Then
  Begin
    strMsgProSemEstoque := strMsgProSemEstoque + Parametros.strCodIte + '  -  ' + Parametros.strDesIte + #13#10;
  End

  Else
  Begin
    {***************************}
    {* INCLUI OU ALTERA O ITEM *}
    {************************JB*}
    With cdsCadPro Do
    Begin

      If (btnConfirmar.Tag > 0) Then
      Begin
        Edit;
        If (strAltGrd = 'N') Then
          FieldByName('IPR_STATUS').AsString := 'E';

        FieldByName('IPR_STALOG').AsString := 'A';
      End
      Else
      Begin
        Insert;
        FieldByName('IPR_STATUS').AsString := 'A';
        FieldByName('IPR_STALOG').AsString := 'I';
      End;

      If (Parametros.blnPrecoFixoTintaDeMaquinaImobiliaria) Then
        cdsCadPro.FieldByName('IPR_PFTMIM').AsString  := 'S'
      Else
        cdsCadPro.FieldByName('IPR_PFTMIM').AsString  := 'N';

      FieldByName('IPR_CODITE').AsString  := Parametros.strCodIte;
      FieldByName('ITE_CODFAB').AsString  := Parametros.strCodFab;
      FieldByName('ITE_DESITE').AsString  := Parametros.strDesIte;
      FieldByName('UNI_SIGUNI').AsString  := Parametros.strUnidad;
      FieldByName('MAR_DESMAR').AsString  := Parametros.strDesMar;

      FieldByName('ITE_SALFIS').AsString  := Parametros.strSalFis;
      FieldByName('ITE_SALDIS').AsString  := Parametros.strSalDis;

      If (TTipDescPro(rdgPreDes.ItemIndex)
            In [tdpEstoqueRemanescente, tdpNegociacaoEspecialFornecedorPC]) And
         ((strAltGrd = 'N') Or (qryTabela.State = dsInsert)) Then
      Begin
        If (TTipDescPro(rdgPreDes.ItemIndex) In [tdpNegociacaoEspecialFornecedorPC])Then
        begin
          if Parametros.fltQtdMin > 0 then
            FieldByName('IPR_QTDMIN').AsFloat   := Parametros.fltQtdMin
          else
            FieldByName('IPR_QTDMIN').AsFloat   := 1;

          if Parametros.fltQtdLim > 0 then
            FieldByName('IPR_QTDLIM').AsFloat   := Parametros.fltQtdLim
          else
            FieldByName('IPR_QTDLIM').AsFloat   := fltEstPro;
        end
        else
        begin
          FieldByName('IPR_QTDMIN').AsFloat   := 1;
          FieldByName('IPR_QTDLIM').AsFloat   := fltEstPro;
        end;
      End
      Else
      Begin
        FieldByName('IPR_QTDMIN').AsFloat   := Parametros.fltQtdMin;
        FieldByName('IPR_QTDLIM').AsFloat   := Parametros.fltQtdLim;
      end;

      If gpbDesAdi.Enabled Then
        FieldByName('IPR_VLDSAD').AsFloat   := Parametros.fltDesAdi;

      If cmbTabPre.Enabled Then
        FieldByName('IPR_TBDSAD').AsInteger := Parametros.intTabPre;

      If blnUsaComissaoCadastroProduto And (Parametros.fltComVarEdt <= 0) Then
        FieldByName('IPR_COMVAR').AsFloat   := Parametros.fltComVarIte
      Else
        FieldByName('IPR_COMVAR').AsFloat   := Parametros.fltComVarEdt;

      FieldByName('IPR_PEREST').AsFloat  := Parametros.fltPerEst;

      If blnUsaComissaoCadastroProduto And (Parametros.fltComAtaEdt <= 0) Then
        FieldByName('IPR_COMATA').AsFloat   := Parametros.fltComAtaIte
      Else
        FieldByName('IPR_COMATA').AsFloat   := Parametros.fltComAtaEdt;

      If blnUsaComissaoCadastroProduto And (Parametros.fltComDisEdt <= 0) Then
        FieldByName('IPR_COMDIS').AsFloat   := Parametros.fltComDisIte
      Else
        FieldByName('IPR_COMDIS').AsFloat   := Parametros.fltComDisEdt;

      FieldByName('IPR_PRZMED').AsInteger := Parametros.intPrzMed;

      Case TTipDescPro(rdgPreDes.ItemIndex) Of
        tdpPrecos,
        tdpPrecoPorQuantidadeMinimaEscalonada,
        tdpPrecoQuantidadeColetiva,
        tdpPrecoPorVlrMinProd:
        Begin
          FieldByName('IPR_PRECUS').AsFloat := Parametros.fltPreCusEdt;

          if (TTipDescPro(rdgPreDes.ItemIndex) = tdpPrecos) and (Parametros.fltMarBruEst > 0) and (Parametros.fltPreVenEdt = 0) then
          begin
            if FieldByName('IPR_PRECUS').AsFloat = 0 then
              FieldByName('IPR_PRECUS').AsFloat := fCampoTabela('ITE_PRECUS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [FieldByName('IPR_CODITE').AsString, VS_strCodEmp], False);


            FieldByName('IPR_PREVEN').AsFloat := fCalculaPrecoVenda(1,
                                                          FieldByName('IPR_PRECUS').AsFloat,
                                                          0,
                                                          Parametros.fltMarBruEst,
                                                          0,0,0,0);
          end
          else
          begin
            FieldByName('IPR_PREVEN').AsFloat := Parametros.fltPreVenEdt;
          end;

          FieldByName('IPR_PERDES').AsFloat := 0.00;
          For intCnt := 1 To 7 Do
            FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat := 0;
        End;

        tdpPrecosDescAdicional:
        Begin
          pRetCustoMargemVenda(FieldByName('IPR_CODITE').AsString,
                               IntToStr(Parametros.intTabPre),
                               Parametros.fltDesAdi,
                               fltCusto,
                               fltMargem,
                               fltVenda,
                               fltPreRea);

          FieldByName('IPR_PRECUS').AsFloat := fltCusto;
          FieldByName('IPR_PREVEN').AsFloat := fltVenda;
          FieldByName('IPR_PERDES').AsFloat := 0.00;

          For intCnt := 1 To 7 Do
            FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat := 0;
        End;

        tdpPorcentoDescontoComDescontoAdicional:
        Begin
          For intCnt := 1 To 7 Do
          Begin
            pRetCustoMargemVenda(FieldByName('IPR_CODITE').AsString,
                                 IntToStr(intCnt),
                                 Parametros.fltDesAdi,
                                 fltCusto,
                                 fltMargem,
                                 fltVenda,
                                 fltPreRea);

            If (intCnt = 1) Then
            Begin
              FieldByName('IPR_PRECUS').AsFloat := fltCusto;
              FieldByName('IPR_PREVEN').AsFloat := fltVenda;
              FieldByName('IPR_PERDES').AsFloat := 0.00;
            End;
            FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat := fltVenda;
          End;
        End;

        tdpDescon,
        tdpPercentualPorQuantidadeMinimaEscalonada,
        tdpPorcentoDescontoQuantidadeColetiva,
        tdpDescPorVlrMinProd,
        tdpPromocaoCompostaPorKit:
        Begin

          FieldByName('IPR_PRECUS').AsFloat := 0;
          pZerarCustoPorTabelas;

          FieldByName('IPR_PERDES').AsFloat := Parametros.fltPerDes;
          FieldByName('IPR_PREVE1').AsFloat := Parametros.fltPreVe1 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE2').AsFloat := Parametros.fltPreVe2 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE3').AsFloat := Parametros.fltPreVe3 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE4').AsFloat := Parametros.fltPreVe4 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE5').AsFloat := Parametros.fltPreVe5 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE6').AsFloat := Parametros.fltPreVe6 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));
          FieldByName('IPR_PREVE7').AsFloat := Parametros.fltPreVe7 * (1 - (FieldByName('IPR_PERDES').AsFloat / 100));

          FieldByName('IPR_PREVEN').AsFloat := FieldByName('IPR_PREVE1').AsFloat;
        End;

        tdpEstoqueRemanescente:
        Begin
          FieldByName('IPR_PRECUS').AsFloat := Parametros.fltPreCusIte;
          FieldByName('IPR_PERDES').AsFloat := 0.00;
          FieldByName('IPR_PREVE1').AsFloat := Parametros.fltPreVe1;
          FieldByName('IPR_PREVE2').AsFloat := Parametros.fltPreVe2;
          FieldByName('IPR_PREVE3').AsFloat := Parametros.fltPreVe3;
          FieldByName('IPR_PREVE4').AsFloat := Parametros.fltPreVe4;
          FieldByName('IPR_PREVE5').AsFloat := Parametros.fltPreVe5;
          FieldByName('IPR_PREVE6').AsFloat := Parametros.fltPreVe6;
          FieldByName('IPR_PREVE7').AsFloat := Parametros.fltPreVe7;

          For intCnt := 1 To 7 Do
            If (FieldByName('IPR_PREVEN').AsFloat = 0) Then
              FieldByName('IPR_PREVEN').AsFloat := FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat;
        End;

        tdpNegociacaoEspecialFornecedorPC:
        Begin
          If strAltGrd = 'N' Then
          Begin
            For intCnt := 1 To 7 Do
            Begin
              pRetCustoMargemVenda(FieldByName('IPR_CODITE').AsString,
                                   IntToStr(intCnt),
                                   Parametros.fltDesAdi,
                                   fltCusto,
                                   fltMargem,
                                   fltVenda,
                                   fltPreRea);

              If (intCnt = 1) Then
              Begin
                FieldByName('IPR_PRECUS').AsFloat := fltCusto;
                FieldByName('IPR_PREVEN').AsFloat := fltVenda;
                FieldByName('IPR_PERDES').AsFloat := 0.00;
              End;
              FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat := fltVenda;
              FieldByName('IPR_PREVE' + IntToStr(intCnt)).AsFloat := fltVenda;
              FieldByName('IPR_MARBR' + IntToStr(intCnt)).AsFloat := fltMargem;
            End;
          End;
        End;

      End;

      FieldByName('ITE_PRECUS').AsFloat   := Parametros.fltPreCusIte;
      pCarregarCustoPorTabelas;

      FieldByName('ITE_OUTVAL').AsFloat   := Parametros.fltOutVal;
      FieldByName('ITE_ICMSAI').AsFloat   := Parametros.fltIcmSai;
      FieldByName('ITE_IMPFED').AsFloat   := Parametros.fltImpFed;
      FieldByName('ITE_DESOPE').AsFloat   := Parametros.fltDesOpe;
      FieldByName('ITE_COMTB1').AsFloat   := Parametros.fltComTb1;
      FieldByName('ITE_COMTB2').AsFloat   := Parametros.fltComTb2;
      FieldByName('ITE_COMTB3').AsFloat   := Parametros.fltComTb3;
      FieldByName('ITE_COMTB4').AsFloat   := Parametros.fltComTb4;
      FieldByName('ITE_COMTB5').AsFloat   := Parametros.fltComTb5;
      FieldByName('ITE_COMTB6').AsFloat   := Parametros.fltComTb6;
      FieldByName('ITE_COMTB7').AsFloat   := Parametros.fltComTb7;

      FieldByName('ITE_MARLQ1').AsFloat   := Parametros.fltMarBr1;
      FieldByName('ITE_PREVE1').AsFloat   := Parametros.fltPreVe1;
      FieldByName('ITE_MARLQ2').AsFloat   := Parametros.fltMarBr2;
      FieldByName('ITE_PREVE2').AsFloat   := Parametros.fltPreVe2;
      FieldByName('ITE_MARLQ3').AsFloat   := Parametros.fltMarBr3;
      FieldByName('ITE_PREVE3').AsFloat   := Parametros.fltPreVe3;
      FieldByName('ITE_MARLQ4').AsFloat   := Parametros.fltMarBr4;
      FieldByName('ITE_PREVE4').AsFloat   := Parametros.fltPreVe4;
      FieldByName('ITE_MARLQ5').AsFloat   := Parametros.fltMarBr5;
      FieldByName('ITE_PREVE5').AsFloat   := Parametros.fltPreVe5;
      FieldByName('ITE_MARLQ6').AsFloat   := Parametros.fltMarBr6;
      FieldByName('ITE_PREVE6').AsFloat   := Parametros.fltPreVe6;
      FieldByName('ITE_MARLQ7').AsFloat   := Parametros.fltMarBr7;
      FieldByName('ITE_PREVE7').AsFloat   := Parametros.fltPreVe7;

      if Parametros.fltPreMed > 0 then
        FieldByName('ITE_PREMED').AsFloat   := Parametros.fltPreMed;

      if Parametros.fltPreUlt > 0 then
        FieldByName('ITE_PREULT').AsFloat   := Parametros.fltPreUlt;

      if Parametros.fltImpUlt > 0 then
        FieldByName('ITE_IMPULT').AsFloat   := Parametros.fltImpUlt;

      FieldByName('ITE_IPIENT').AsFloat   := Parametros.fltIpiEnt;
      FieldByName('ITE_PRECOM').AsFloat   := Parametros.fltPreCom;
      FieldByName('ITE_DESF01').AsFloat   := Parametros.fltDesF01;
      FieldByName('ITE_DESF02').AsFloat   := Parametros.fltDesF02;
      FieldByName('ITE_DESF03').AsFloat   := Parametros.fltDesF03;
      FieldByName('ITE_DESF04').AsFloat   := Parametros.fltDesF04;
      FieldByName('ITE_DESF05').AsFloat   := Parametros.fltDesF05;
      FieldByName('ITE_DESF06').AsFloat   := Parametros.fltDesF06;
      FieldByName('ITE_PREDOL').AsString  := Parametros.strPreDol;
      FieldByName('ITE_CODABF').AsString  := Parametros.strCodAbf;
      FieldByName('IPR_CLIVEN').AsFloat   := Parametros.fltCliVen;

      pCalcularPrecoVendaReal;

      FieldByName('IPR_VENIMP').AsFloat   := fStrToFloat(lblValorTotalVenda.Caption ,0);
      FieldByName('IPR_BOCCAI').AsFloat   := FfltBocCai;
      FieldByName('IPR_ICMSAI').AsFloat   := FfltIcmSai;
      FieldByName('IPR_IMPFED').AsFloat   := FfltImpFed;
      FieldByName('IPR_DESOPE').AsFloat   := FfltDesOpe;
      FieldByName('ITE_CUSREA').AsFloat   := FfltPreCus;

      if rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
      Begin
        FblnProdutosAdicionados            := True;
        FieldByName('IPR_SEQKIT').AsString := FstrUltimoIDKitGerado;
      End;

      pCalculaCustoEMargem();

      Post;
    End;
  End;

  Result := fEmptyStr(strMsgProJaInc + strMsgProIncOu + strMsgItemEstr01 + strMsgItemEstr02 + strMsgProSemEstoque);
end;

function TfrmCadPromocoes.fInformouMargemBruta: Boolean;
begin
  Result := False;

  if not edtMarBru.Visible then
    Exit;

  if fStrToFloat(edtMarBru.Text) > 0 then
    Result := True;
end;

function TfrmCadPromocoes.fInsereCliente(pgbStatus: TcxProgressBar): Boolean;
  Var
    prcScroll : TprcScroll;
    blnOk     : Boolean;
    strCodIte,
    strMsgTmp,
    strMsgCliente,
    strEmpresasSelecionadas,
    strTabelasPrecoSelecionadas : String;
begin

  Try

    pDisableControls(cdsProCli, prcScroll);

    Try

      pInfoStatusGravacao(pgbStatus, 'Aguarde, carregando clientes...');

      strCodIte := fVerificaProdutos(pgbStatus);
      strEmpresasSelecionadas     := fGetEmpresasSelecionadas;
      strTabelasPrecoSelecionadas := fGetTabelasPrecoSelecionadas;

      strMsgTmp     := '';
      strMsgCliente := '';
      pInfoStatusGravacao(pgbStatus, 'Aguarde, inserindo cliente...', qryClientesDaPromocao.RecordCount);

      qryClientesDaPromocao.First;
      While Not qryClientesDaPromocao.Eof Do
      Begin

        pStepStatusGravacao(pgbStatus);

        If chkPromocaoRestritaClientesNaoConsumidor.Checked And fClienteConsumidor(qryClientesDaPromocao.FieldByName('NOMCLI').AsString, True, True) Then
        Begin
          qryClientesDaPromocao.Next;
          Continue;
        End;

        blnOk := fIncluirClienteCds(strMsgTmp,
                                    qryClientesDaPromocao.FieldByName('CODCLI').AsString,
                                    qryClientesDaPromocao.FieldByName('NOMCLI').AsString,
                                    qryClientesDaPromocao.FieldByName('ATIVID').AsString,
                                    qryClientesDaPromocao.FieldByName('CIDEST').AsString,
                                    qryClientesDaPromocao.FieldByName('CGCCPF').AsString,
                                    qryClientesDaPromocao.FieldByName('CATEGO').AsString,
                                    strCodIte,
                                    strEmpresasSelecionadas,
                                    strTabelasPrecoSelecionadas);

        If (Not blnOk) and (Not fEmptyStr(strMsgTmp)) Then
          strMsgCliente := strMsgCliente + strMsgTmp;

        qryClientesDaPromocao.Next;

      End;

      Result := True;

      cxgClientes.Enabled := True;
      cxgClientes.Refresh;
      btnCancelCli.Click;

      pMostraObservacaoCliente(strMsgCliente);

    Finally
      pEnableControls(cdsProCli, prcScroll);
    End;

  Except
    Result := False;
  End;

end;

function TfrmCadPromocoes.fItemJaCadastrado(strCodIte: String): Boolean;
  Var
    prcScroll: TprcScroll;
begin

  If fEhPromocaoPorQuantidadeMinimaEscalonada Then
    Exit(False);

  If rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
    Exit(False);

  Try

    pDisableControls(cdsCadPro, prcScroll);

    Result := cdsCadPro.Locate('IPR_CODITE', strCodIte, []);

  Finally
    pEnableControls(cdsCadPro, prcScroll);
  End;

end;

procedure TfrmCadPromocoes.pValidarOpcLimitePorClienteOuVenda;
begin

  chkUtilizarLimitePorClienteOuVenda.Enabled := True;
  rdgUtilizarLimitePorClienteOuVenda.Enabled := True;

  If (opcTipDes = tdpPorcentoDescontoQuantidadeColetiva) Or
     (opcTipDes = tdpPrecoQuantidadeColetiva) Or
     (opcTipDes = tdpPromocaoCompostaPorKit) Then
  Begin

    chkUtilizarLimitePorClienteOuVenda.Enabled := False;
    chkUtilizarLimitePorClienteOuVenda.Checked := False;
    chkUtilizarLimitePorClienteOuVendaClick(chkUtilizarLimitePorClienteOuVenda);

    rdgUtilizarLimitePorClienteOuVenda.ItemIndex := -1;
    rdgUtilizarLimitePorClienteOuVenda.Enabled   := False;

  End;

end;

procedure TfrmCadPromocoes.pValidaSeItemJaCadastradoQtdMin(strCodIte: String; fltQtdMin: Double; blnValidaExistencia : Boolean = False);
  Var
    cdsDados     : TUniClientDataSet;
    blnDuplicado : Boolean;
begin

  If Not fEhPromocaoPorQuantidadeMinimaEscalonada Then
    Exit;

  cdsDados := TUniClientDataSet.Create(Nil);

  Try

    pCloneDataSet(cdsDados, cdsCadPro);

    cdsDados.Filtered := False;
    cdsDados.Filter   := 'IPR_CODITE = ' + QuotedStr(strCodIte) + ' AND ' +
                         'IPR_QTDMIN = ' + fltQtdMin.ToString   + ' AND ' +
                         'IPR_STATUS <> ' + QuotedStr('D');
    cdsDados.Filtered := True;

    blnDuplicado := (blnValidaExistencia And (Not cdsDados.IsEmpty)) Or (cdsDados.RecordCount > 1);

    If blnDuplicado Then
    Begin
      If Not stlItensQuantidadeMinimaDuplicado.Text.Contains(strCodIte) Then
        stlItensQuantidadeMinimaDuplicado.Add('Produto: '+strCodIte+' - Quantidade mínima: '+fltQtdMin.ToString);
    End;

  Finally
    FreeAndNil(cdsDados);
  End;

end;

function TfrmCadPromocoes.fMsgTabloid: String;
begin
  Result := '';
  If fCfgSis('TABLOI', VarBoolean) Then
    If chkTabloid.Checked Then
      Result := ' (Tabloid)';
end;

procedure TfrmCadPromocoes.pAdicionaItem;
Begin
  Try
    If (Not strAltGrd.Equals('S')) And (fEhPromocaoPorQuantidadeMinimaEscalonada) And
      (Not fValidaQuantidadeMinima(edtCodIte.Text, fStrToFloat(edtQtdMin.Text))) Then
    Begin
      fMensagem('Atenção!', MSG_DIVERGENCIA_QTDMIN + #13 + stlItensQuantidadeMinimaDuplicado.Text, ['&Ok']);
      Exit;
    End;

    If rdgPreDes.ItemIndex <> IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
    Begin
      blnUsaComissaoCadastroProduto := False;
      If (FLockExcel = -1) and (not FblnAutomatizada) Then
        If (fStrToFloat(edtComVar.Text) <= 0) Or
           (fStrToFloat(edtComAta.Text) <= 0) Or
           (fStrToFloat(edtComDis.Text) <= 0) Then
        Begin
          blnUsaComissaoCadastroProduto := (fMensagem('', 'Existem percentuais de comissão não informados. Deseja utilizar os percentuais de comissão do cadastro de produtos?', ['&Sim', '&Não']) = 1);
        End;
    End
    Else
      blnUsaComissaoCadastroProduto := True;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fAdicionaItem;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);
End;

procedure TfrmCadPromocoes.pAddPedidoCompra(const strNumPed, strEspDoc,
  strCodEmp, strNumCtn: String);
begin

  If cdsPCMPRO.Locate('PRO_NUMPED;PRO_CODEMP;PRO_ESPDOC;PRO_NUMCTN',
                      VarArrayOf([strNumPed, strCodEmp, strEspDoc, strNumCtn]),
                      []) Then
    Exit;

  cdsPCMPRO.AppendRecord([strNumPed, strCodEmp, strEspDoc, StrToIntDef(strNumCtn, 0)]);
end;

function TfrmCadPromocoes.fValidaConsulta: boolean;
begin
  result := true;

  if (rdgGiroEstoq.ItemIndex <> 0) then
  begin
    if (not ckbSaldoZero.Checked)then
    begin
      if fEmptyDate(mskDtaGiroIni.text) or fEmptyDate(mskDtaGiroFim.text) then
      begin
        fMensagem('ATENÇÃO!', 'Para considerar o giro no filtro, é obrigatório informar o período.', ['&Ok']);
        pSetFocus(mskDtaGiroIni);
        result := false;
        exit;
      end;

      if (StrToDate(mskDtaGiroIni.Text) > StrToDate(mskDtaGiroFim.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O período inicial deve ser menor que o período final.', ['&Ok']);
        pSetFocus(mskDtaGiroIni);
        result := false;
        exit;
      end;
    end;
  end;
end;

function TfrmCadPromocoes.fValidaInclusaoProdutosMargemLiquida(fltPrecoVenda, fltMargemLiq: Double): Boolean;
begin
  Result := False;

  If Not fPrecoDeVendaEhObrigatorio Then
    Exit;

  If Not blnCalcMargemLiquida Then
    Exit;

  Result := (fltPrecoVenda > 0) And (fltMargemLiq > 0);
end;

function TfrmCadPromocoes.fSqlCamposEdits: String;
begin
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtPreCus.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_PRECUS, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtPreVen.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_PREVEN, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtComVar.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_COMVAR, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtComAta.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_COMATA, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtComDis.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_COMDIS, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtPrzMed.Text)).Replace(',', '.') + ' AS DECIMAL(12,0)) AS X_PRZMED, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtQtdMin.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_QTDMIN, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtQtdLim.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_QTDLIM, ';
  Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtCliVen.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_CLIVEN, ';

  if edtMarBru.Visible then
    Result := Result + 'CAST(' + FloatToStr(fStrToFloat(edtMarBru.Text)).Replace(',', '.') + ' AS DECIMAL(12,4)) AS X_MARBRU, ';
end;

function TfrmCadPromocoes.fSqlGiroEstoq: String;
begin
  result := '';
  result := '(';
  result := result + ' SELECT  COUNT(*) FROM MOVDET ';
  result := result + ' WHERE TRUE ';
  result := result + ' AND MOVDET.DET_CODITE = CADITE.ITE_CODITE ';
  result := result + ' AND MOVDET.DET_CODEMP = ' + QuotedStr(fGetEmpresaPreAlt()) + ' ';
  result := result + ' AND IFNULL(MOVDET.DET_PROEMB, "N") <> "S"' ;

  if(not ckbSaldoZero.checked) then
    result := result + 'AND MOVDET.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  case rdgGiroEstoq.ItemIndex of
    1:
    begin
      result := result + ' AND  MOVDET.DET_TIP_FC = "F" ';
      result := result + ' AND LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaCom +'")';
    end;
    2:
    begin
      result := result + ' AND MOVDET.DET_TIP_FC = "C" ';
      result := result + ' AND MOVDET.DET_CODCLI NOT IN (' + VS_strCliFil + ') ';
      result := result + ' AND (( LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaVen +'")) ';
      result := result + ' OR ( LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaDev +'"))  ';
      if fCfgSis('ENTBRF', varBoolean) then
        result := result + ' OR (MOVDET.DET_ESPDOC = "BR") OR (LOCATE(MOVDET.DET_CLAFIS, '+ CLAFIS_BR +'))) '
      else
        result := result + ' ) ';
    end;
    3:
    begin
      result := result + ' AND MOVDET.DET_TIP_FC IN ("C", "F") ';
      result := result + ' AND IF(MOVDET.DET_TIP_FC = "C", ';
      result := result + '        MOVDET.DET_CODCLI NOT IN (' + VS_strCliFil + '), TRUE) ';

      result := result + ' AND IF(MOVDET.DET_TIP_FC = "F", ';
      result := result + '         LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaCom +'")  , ';
      result := result + '        (LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaVen +'")  ';
      result := result + '        OR  LOCATE(MOVDET.DET_CLAFIS, "'+ VS_strClaDev +'") )  ';
      if fCfgSis('ENTBRF', varBoolean) then
        result := result + ' OR (MOVDET.DET_ESPDOC = "BR") OR (LOCATE(MOVDET.DET_CLAFIS, '+ CLAFIS_BR +'))) '
      else
        result := result + ') ';
    end;
  end;
  result := result + ' ) AS DET_MOVIME, ';
end;


function TfrmCadPromocoes.fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
Var
  qryGen   : TUniQuery;
  strSQL,
  strCodCli: String;
  strMsgProJaInc: String;   //ARMAZENA OS ITENS JÁ INCLUSOS NESTA PROMOÇÃO
  strMsgProIncOu: String;   //ARMAZENA OS ITENS JÁ INCLUSOS OUTRA PROMOÇÃO
  strMsgProSemEstoque: String;
  strMsgItemEstr01: String;
  strMsgItemEstr02: String;
  prcScroll: TprcScroll;
  intObs: Integer;
  strPedidos: String;

  Parametro: TParametroProduto;
  strEmpresasSelecionadas: String;
  strTabelasPrecoSelecionadas: String;

  function fSqlPedComp: String;
  var
    i: Integer;
    strAux: TStrings;
    intTabela: Integer;
  Begin
    strSQL := '';
    strPedidos := '';
    strWherePedidoCompra := '';
    strAux := TStringList.Create;

    Try
      strSQL := strSQL + 'SELECT                                              ';
      strSQL := strSQL + fSqlCamposEdits;
      strSQL := strSQL + '  D.PCD_CODITE AS CODITE,                           ';
      strSQL := strSQL + '  C.ITE_CODFAB AS CODFAB,                           ';
      strSQL := strSQL + '  D.PCD_DESITE AS DESITE,                           ';
      strSQL := strSQL + '  C.ITE_CODGRU AS CODGRU,                           ';
      strSQL := strSQL + '  U.UNI_SIGUNI AS UNIDAD,                           ';
      strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR,                           ';
      strSQL := strSQL + '  (IFNULL(I.ITE_SALDOS, 0) + IFNULL(I.ITE_QTEF_A, 0) + IFNULL(I.ITE_QTEF_F, 0) ';
      strSQL := strSQL + '      + IFNULL(I.ITE_QTEF_P, 0) + IFNULL(ITE_QTPDBF,0)) AS ITE_SALFIS, ';
      strSQL := strSQL + fSQLSaldoDisponivel('I', True) + ' AS ITE_SALDIS, ';
      strSQL := strSQL + '  I.ITE_PRECUS AS PRECUS,                           ';

      For intTabela := 1 To 7 Do
      Begin
        strSQL := strSQL + '  I.ITE_MARBR' + IntToStr(intTabela) + ' AS MARBR' + IntToStr(intTabela) + ',';
        strSQL := strSQL + '  I.ITE_PREVE' + IntToStr(intTabela) + ' AS PREVE' + IntToStr(intTabela) + ',';
        strSQL := strSQL + '  I.ITE_COMTB' + IntToStr(intTabela) + ' AS COMTB' + IntToStr(intTabela) + ',';

        If intTabela < 7 Then
          strSQL := strSQL + ' I.ITE_DESF0' + IntToStr(intTabela) + ' AS DESF0' + IntToStr(intTabela) + ',';
      End;

      strSQL := strSQL + '  I.ITE_OUTVAL AS OUTVAL,                           ';
      strSQL := strSQL + '  I.ITE_ICMSAI AS ICMSAI,                           ';
      strSQL := strSQL + '  I.ITE_IMPFED AS IMPFED,                           ';
      strSQL := strSQL + '  I.ITE_DESOPE AS DESOPE,                           ';
      strSQL := strSQL + '  I.ITE_COMVAR AS COMVAR,                           ';
      strSQL := strSQL + '  I.ITE_COMATA AS COMATA,                           ';
      strSQL := strSQL + '  I.ITE_COMDIS AS COMDIS,                           ';
      strSQL := strSQL + '  AVG(D.PCD_PERIPI) AS IPIENT,                      ';
      strSQL := strSQL + '  AVG(D.PCD_UNITAR) AS PRECOM,                      ';
      strSQL := strSQL + '  I.ITE_PREDOL AS PREDOL,                           ';

      If (fCfgSis('TIPABF') = '1') Then
        strSQL := strSQL + ' C.ITE_CODABF AS CODABF '
      Else
        strSQL := strSQL + ' I.ITE_CODABF AS CODABF ';

      strSQL := strSQL + ' FROM PCMDET D                                      ';
      strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = D.PCD_CODITE ';
      strSQL := strSQL + ' INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE ';
      strSQL := strSQL + '                    AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
      strSQL := strSQL + ' INNER JOIN CADMAR M ON C.ITE_CODMAR = M.MAR_CODMAR ';
      strSQL := strSQL + ' INNER JOIN CADUNI U ON C.ITE_CODUNI = U.UNI_CODUNI ';
      strSQL := strSQL + ' WHERE C.ITE_ITEATI = "S"                           ';

      If (strAltGrd = 'N') Then
      Begin
        For i := 0 To Pred(stlPedidosCompra.Count) Do
        Begin
          strAux.Clear();
          ExtractStrings([';'], [' '], PChar(stlPedidosCompra[i]), strAux);

          pAddPedidoCompra(strAux[0], 'PD', strAux[1], strAux[2]);


          strWherePedidoCompra := strWherePedidoCompra + ' OR( D.PCD_NUMPED = ' + QuotedStr(strAux[0]);
          strWherePedidoCompra := strWherePedidoCompra + '     AND D.PCD_ESPDOC = "PD" ';
          strWherePedidoCompra := strWherePedidoCompra + '     AND D.PCD_CODEMP = ' + QuotedStr(strAux[1]);
          strWherePedidoCompra := strWherePedidoCompra + ' )                           ';

          strPedidos := Concat(strPedidos, strAux[0], '-PD-', strAux[1], IIF(i < Pred(stlPedidosCompra.Count), ', ', ''));
        End;

        stlPedidosCompra.Clear();

        strSQL := strSQL + ' AND ( FALSE ' + strWherePedidoCompra + ')';
      End
      Else
      Begin
        If (Not fEmptyStr(edtCodIte.Text)) Then
          strSQL := strSQL + ' AND D.PCD_CODITE = :CODITE  ';

        strSQL := strSQL + ' AND ( FALSE ' + fGetWherePedidosImportados() + ')';
      End;

      strSQL := strSQL + ' GROUP BY D.PCD_CODITE       ';
    Finally
      strAux.Free;
    End;

    Result := strSQL;
  End;

  function fSqlDefault : String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    if (rdgGiroEstoq.ItemIndex <> 0) or (ckbSaldoZero.Checked )then
      strSQL := strSQL + fSqlGiroEstoq;

    strSQL := strSQL + fSqlCamposEdits;
    strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '  (IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_QTEF_A, 0) + IFNULL(ITEGER.ITE_QTEF_F, 0) ';
    strSQL := strSQL + '      + IFNULL(ITEGER.ITE_QTEF_P, 0) + IFNULL(ITEGER.ITE_QTPDBF, 0)) AS ITE_SALFIS, ';
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

    strSQL := strSQL + ' WHERE TRUE ';

    If cbxProdAtv.ItemIndex <> 2 then
      strSQL := strSQL + ' AND CADITE.ITE_ITEATI = :PRODATV ';

    If cbxProAtvComp.ItemIndex <> 2 then
      strSQL := strSQL + ' AND CADITE.ITE_ATICOM = :ATICOM ';

    If cbxImpList.ItemIndex <> 2 then
      strSQL := strSQL + ' AND ITEGER.ITE_IMPLIS = :IMPLIS ';

    If cbxSldZero.ItemIndex = 1 then
    begin
      strSQL := strSQL + ' AND (IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_QTEF_A, 0) + IFNULL(ITEGER.ITE_QTEF_F, 0) ';
      strSQL := strSQL + '    + IFNULL(ITEGER.ITE_QTEF_P, 0) + IFNULL(ITEGER.ITE_QTPDBF, 0)) > 0 ';
    end;

    If Not fEmptyStr(edtCodDep.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_CODDEP = :CODDEP ';

    If Not fEmptyStr(edtGruCmp.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

    If (Not fEmptyStr(edtCodIte.Text)) Then
      strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE  ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If RightStr(mskLinhaGrupo.Text,3) = '000' Then
        strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    End;

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

    If Not fEmptyStr(edtDesPro.Text) Then
      strSQL := strSQL + '  AND ITE_DESITE LIKE :DESPRO ';

    If (Not fEmptyStr(edtDescriIni.Text)) and (Not fEmptyStr(edtDescriFin.Text)) Then
      strSQL := strSQL + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  AND ITE_REFERE = :REFERE ';

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + '  AND ITE_CODUNI = :CODUNI ';

    strSQL := strSQL + ' GROUP BY CADITE.ITE_CODITE ';

    strSQL := strSQL + ' HAVING TRUE ';

    if (rdgGiroEstoq.ItemIndex <> 0) or (ckbSaldoZero.Checked )then
      strSQL := strSQL + ' AND DET_MOVIME = 0  ';

    If ckbSaldoZero.Checked  then
      strSQL := strSQL + ' AND ITE_SALFIS > 0 ';

    strSQL := strSQL + ' ORDER BY CADITE.ITE_DESITE ';

    Result := strSQL;
  End;

  function fSqlPreAlt : String;
  var intTabela: Integer;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    if (rdgGiroEstoq.ItemIndex <> 0) or (ckbSaldoZero.Checked )then
      strSQL := strSQL + fSqlGiroEstoq;

    strSQL := strSQL + fSqlCamposEdits;
    strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
    strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
    strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
    strSQL := strSQL + '  (IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_QTEF_A, 0) + IFNULL(ITEGER.ITE_QTEF_F, 0) ';
    strSQL := strSQL + '      + IFNULL(ITEGER.ITE_QTEF_P, 0) + IFNULL(ITEGER.ITE_QTPDBF, 0)) AS ITE_SALFIS, ';
    strSQL := strSQL + fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS, ';

    strSQL := strSQL + '  PREALT.ALT_CUSANT AS PRECUS, ';

    For intTabela := 1 To 7 Do
    Begin
      strSQL := strSQL + '  PREALT.ALT_VE'+IntToStr(intTabela)+'ANT AS PREVE'+IntToStr(intTabela)+',';
      strSQL := strSQL + '  PREALT.ALT_MA'+IntToStr(intTabela)+'ANT AS MARBR'+IntToStr(intTabela)+',';
    End;

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

    strSQL := strSQL + '  ITEGER.ITE_PREMED AS PREMED, ';
    strSQL := strSQL + '  ITEGER.ITE_PREULT AS PREULT, ';
    strSQL := strSQL + '  ITEGER.ITE_IMPULT AS IMPULT, ';

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
    strSQL := strSQL + '                  AND ITEGER.ITE_CODEMP = ' + QuotedStr(fGetEmpresaPreAlt()) + ' ';
    strSQL := strSQL + ' INNER JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
    strSQL := strSQL + ' INNER JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
    strSQL := strSQL + ' INNER JOIN PREALT ON PREALT.ALT_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                  AND PREALT.ALT_CODEMP = ' + QuotedStr(fGetEmpresaPreAlt()) + ' ';
    strSQL := strSQL + ' WHERE TRUE ';

    If cbxProdAtv.ItemIndex <> 2 then
      strSQL := strSQL + ' AND CADITE.ITE_ITEATI = :PRODATV ';

    If cbxProAtvComp.ItemIndex <> 2 then
      strSQL := strSQL + ' AND CADITE.ITE_ATICOM = :ATICOM ';

    If cbxImpList.ItemIndex <> 2 then
      strSQL := strSQL + ' AND ITEGER.ITE_IMPLIS = :IMPLIS ';

    If cbxSldZero.ItemIndex = 1 then
    begin
      strSQL := strSQL + ' AND (IFNULL(ITEGER.ITE_SALDOS, 0) + IFNULL(ITEGER.ITE_QTEF_A, 0) ';
      strSQL := strSQL + '    + IFNULL(ITEGER.ITE_QTEF_F, 0) + IFNULL(ITEGER.ITE_QTEF_P, 0) + IFNULL(ITEGER.ITE_QTPDBF, 0)) > 0 ';
    end;

    If Not fEmptyStr(edtCodDep.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_CODDEP = :CODDEP ';

    If Not fEmptyStr(edtGruCmp.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_GRUCMP = :GRUCMP ';

    If (blnPreAlt) and (not ckbSaldoZero.checked) Then
    Begin
      If (Not fEmptyDate(dbeDtaInicial.Text)) and (Not fEmptyDate(dbeDtaFinal.Text)) Then
      begin
        strSQL := strSQL + ' AND ALT_DTAALT BETWEEN :DTI AND :DTF ';
      end;
    End;

    If (Not fEmptyStr(edtCodIte.Text)) Then
      strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE  ';

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
    Begin
      If RightStr(mskLinhaGrupo.Text, 3) = '000' Then
        strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    End;

    If Not fEmptyStr(edtFornecedor.Text) Then
      strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

    If Not fEmptyStr(edtMarca.Text) Then
      strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

    If Not fEmptyStr(edtDesPro.Text) Then
      strSQL := strSQL + '  AND ITE_DESITE LIKE :DESPRO ';

    If (Not fEmptyStr(edtDescriIni.Text)) and (Not fEmptyStr(edtDescriFin.Text)) Then
      strSQL := strSQL + '  AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESITE AND :DESITE1 ';

    If Not fEmptyStr(edtRefere.Text) Then
      strSQL := strSQL + '  AND ITE_REFERE = :REFERE ';

    If Not fEmptyStr(edtUnidade.Text) Then
      strSQL := strSQL + '  AND ITE_CODUNI = :CODUNI ';

    If Not fEmptyStr(edtCodDep.Text) Then
      strSQL := strSQL + '  AND CADITE.ITE_CODDEP = :CODDEP ';

    strSQL := strSQL + '  AND CONCAT(PREALT.ALT_DTAALT,PREALT.ALT_HORALT) = ';
    strSQL := strSQL + '                          (SELECT MAX(CONCAT(A.ALT_DTAALT, A.ALT_HORALT)) FROM PREALT A ';
    strSQL := strSQL + '                           WHERE A.ALT_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                             AND A.ALT_CODEMP = ' + QuotedStr(fGetEmpresaPreAlt()) + ' ';
    strSQL := strSQL + '                             AND ALT_DTAALT BETWEEN :DTI AND :DTF) ';

    strSQL := strSQL + ' GROUP BY CADITE.ITE_CODITE ';

    strSQL := strSQL + ' HAVING TRUE ';

    if (rdgGiroEstoq.ItemIndex <> 0) or (ckbSaldoZero.Checked )then
      strSQL := strSQL + ' AND DET_MOVIME = 0  ';

    If ckbSaldoZero.Checked  then
      strSQL := strSQL + ' AND ITE_SALFIS > 0 ';

    strSQL := strSQL + ' ORDER BY CADITE.ITE_DESITE ';

    Result := strSQL;
  End;

begin
  Result := False;
  intObs := 0;

  If FLockExcel < 0  Then
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...');

  qryGen   := fCriaQuery;
  qryGen.Options.SetFieldsReadOnly := False;
  qryGen.CachedUpdates := True;

  If FLockExcel < 0  Then
    pDisableControls(cdsCadPro, prcScroll);

  With qryGen Do
  Begin
    Close;
    SQL.Clear;

    If blnPreAlt Then
      SQL.Add(fSqlPreAlt)
    Else If blnImpPC Then
      SQL.Add(fSqlPedComp)
    Else
      SQL.Add(fSqlDefault);

    if (Params.FindParam('PRODATV') <> Nil) Then
    begin
      case cbxProdAtv.ItemIndex of
        0: ParamByName('PRODATV').AsString := 'S';
        1: ParamByName('PRODATV').AsString := 'N';
      end;
    end;

    if (Params.FindParam('ATICOM') <> Nil) Then
    begin
      case cbxProAtvComp.ItemIndex of
        0: ParamByName('ATICOM').AsString := 'S';
        1: ParamByName('ATICOM').AsString := 'N';
      end;
    end;

    if (Params.FindParam('IMPLIS') <> Nil) Then
    begin
      case cbxImpList.ItemIndex of
        0: ParamByName('IMPLIS').AsString := 'S';
        1: ParamByName('IMPLIS').AsString := 'N';
      end;
    end;

    if (Params.FindParam('CODITE') <> Nil) Then
      ParamByName('CODITE').AsString := edtCodIte.Text;

    if (Params.FindParam('CODGRU') <> Nil) Then
     ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

    if (Params.FindParam('CODFOR') <> Nil) Then
        ParamByName('CODFOR').AsString := edtFornecedor.Text;

    if (Params.FindParam('CODMAR') <> Nil) Then
        ParamByName('CODMAR').AsString := edtMarca.Text;

      If Not fEmptyStr(edtDesPro.Text) Then
      if (Params.FindParam('DESPRO') <> Nil) then
        ParamByName('DESPRO').AsString := edtDesPro.Text + '%';

    If (Not fEmptyStr(edtDescriIni.Text)) and (Not fEmptyStr(edtDescriFin.Text)) Then
    Begin
      if (Params.FindParam('MAIOR') <> Nil) then
        ParamByName('MAIOR').AsString := edtDescriIni.Text;
      if (Params.FindParam('DESITE') <> Nil) then
        ParamByName('DESITE').AsString := edtDescriIni.Text;
      if (Params.FindParam('DESITE1') <> Nil) then
        ParamByName('DESITE1').AsString := edtDescriFin.Text;
    End;

    if (Params.FindParam('REFERE') <> Nil) Then
      ParamByName('REFERE').AsString := edtRefere.Text;

    if (Params.FindParam('CODUNI') <> Nil) Then
      ParamByName('CODUNI').AsString := edtUnidade.Text;

    if (Params.FindParam('CODDEP') <> Nil) Then
      ParamByName('CODDEP').AsString := edtCodDep.Text;

    if (Params.FindParam('GRUCMP') <> Nil) Then
        ParamByName('GRUCMP').AsString := edtGruCmp.Text;

    if (Params.FindParam('DTAINI') <> Nil) and (Params.FindParam('DTAFIN') <> Nil)Then
    begin
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaGiroIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaGiroFim.Text);
    end;

    If blnPreAlt Then
    Begin
      if (Params.FindParam('DTI') <> Nil)  and (Params.FindParam('DTF') <> Nil) Then
      begin
        ParamByName('DTI').AsDateTime := StrToDate(dbeDtaInicial.Text);
        ParamByName('DTF').AsDateTime := StrToDate(dbeDtaFinal.Text);
      end;
    End;

    Open;
  End;

  If qryGen.RecordCount = 0 Then
  Begin
    If blnPreAlt Then
      fMensagem('','Nenhum produto com atualização de preço no período informado!',['&OK'], 0)
    Else If blnImpPC Then
      fMensagem('','Nenhum produto encontrado para o(s) pedido(s) de compra selecionado(s)!', ['&OK'], 0)
    Else
      fMensagem('','Nenhum Produto foi encontrado para essas condições!',['&OK'], 0);
  End
  Else
  Begin
    If (qryGen.RecordCount > 1) And (fEmptyStr(edtCodIte.Text)) And (edtMarBru.Visible) And (fStrToFloat(edtMarBru.Text) > 0) And (fStrToFloat(edtPreVen.Text) > 0) Then
    Begin
      If fMensagem('','Serão inseridos múltiplos produtos, porém foi informado "PREÇO VENDA" e "MARGEM BRUTA", irá prevalecer o "PREÇO VENDA". Deseja continuar?',['&Sim', '&Não'], 0) = 2 Then
        Exit;
    End;

    strCodCli := fCodCli;
    strEmpresasSelecionadas := fGetEmpresasSelecionadas;
    strTabelasPrecoSelecionadas := fGetTabelasPrecoSelecionadas;

    strMsgProJaInc      := '';
    strMsgProIncOu      := '';
    strMsgItemEstr01    := '';
    strMsgItemEstr02    := '';
    strMsgProSemEstoque := '';

    if not fValidarItensIncluidos(qryGen) then
      Exit;

    If FLockExcel < 0  Then
      pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...', qryGen.RecordCount);

    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      pCarregaValoresCusto(qryGen.FieldByName('CODITE').AsString, VS_strCodEmp, fGetTabPre);

      Parametro.blnPrecoFixoTintaDeMaquinaImobiliaria := False;
      If (Not fEmptyStr(edtCodIte.Text)) And (ckbPrecoFixoParaTmqImo.Visible) Then
        Parametro.blnPrecoFixoTintaDeMaquinaImobiliaria := ckbPrecoFixoParaTmqImo.Visible And ckbPrecoFixoParaTmqImo.Checked;
      Parametro.strCodIte    := qryGen.FieldByName('CODITE').AsString;
      Parametro.strDesIte    := qryGen.fieldbyname('DESITE').AsString;
      Parametro.strCodFab    := qryGen.fieldbyname('CODFAB').AsString;
      Parametro.strUnidad    := qryGen.fieldbyname('UNIDAD').AsString;
      Parametro.strDesmar    := qryGen.fieldbyname('DESMAR').AsString;
      Parametro.strSalFis    := qryGen.fieldbyname('ITE_SALFIS').AsString;
      Parametro.strSalDis    := qryGen.fieldbyname('ITE_SALDIS').AsString;
      Parametro.fltQtdMin    := qryGen.fieldbyname('X_QTDMIN').AsFloat;
      Parametro.fltQtdLim    := qryGen.fieldbyname('X_QTDLIM').AsFloat;
      Parametro.fltDesAdi    := fStrToFloat(edtDesAdi.Text);
      Parametro.intTabPre    := StrToIntDef(cmbTabPre.Text, fGetTabPre.ToInteger);
      Parametro.fltComVarIte := qryGen.fieldbyname('COMVAR').AsFloat;
      Parametro.fltComVarEdt := qryGen.fieldbyname('X_COMVAR').AsFloat;
      Parametro.fltPerEst    := fStrToFloat(edtPerEst.Text);
      Parametro.fltComAtaIte := qryGen.fieldbyname('COMATA').AsFloat;
      Parametro.fltComAtaEdt := qryGen.fieldbyname('X_COMATA').AsFloat;
      Parametro.fltComDisIte := qryGen.fieldbyname('COMDIS').AsFloat;
      Parametro.fltComDisEdt := qryGen.fieldbyname('X_COMDIS').AsFloat;
      Parametro.intPrzMed    := qryGen.fieldbyname('X_PRZMED').AsInteger;
      Parametro.fltPreCusEdt := qryGen.fieldbyname('X_PRECUS').AsFloat;
      Parametro.fltPreVenEdt := qryGen.fieldbyname('X_PREVEN').AsFloat;

      if edtMarBru.Visible then
        Parametro.fltMarBruEst := qryGen.fieldbyname('X_MARBRU').AsFloat;

      Parametro.fltPerDes    := fStrToFloat(edtPerDes.Text);
      Parametro.fltPreVe1    := qryGen.fieldbyname('PREVE1').AsFloat;
      Parametro.fltPreVe2    := qryGen.fieldbyname('PREVE2').AsFloat;
      Parametro.fltPreVe3    := qryGen.fieldbyname('PREVE3').AsFloat;
      Parametro.fltPreVe4    := qryGen.fieldbyname('PREVE4').AsFloat;
      Parametro.fltPreVe5    := qryGen.fieldbyname('PREVE5').AsFloat;
      Parametro.fltPreVe6    := qryGen.fieldbyname('PREVE6').AsFloat;
      Parametro.fltPreVe7    := qryGen.fieldbyname('PREVE7').AsFloat;

      Parametro.fltPreCusIte := fRetPreCus(qryGen.fieldbyname('PRECUS').AsFloat);
      Parametro.fltOutVal    := fRetOutVal(qryGen.fieldbyname('OUTVAL').AsFloat);
      Parametro.fltIcmSai    := fRetIcmSai(qryGen.fieldbyname('ICMSAI').AsFloat);
      Parametro.fltImpFed    := fRetImpFed(qryGen.fieldbyname('IMPFED').AsFloat);
      Parametro.fltDesOpe    := fRetDesOpe(qryGen.fieldbyname('DESOPE').AsFloat);

      Parametro.fltComTb1    := qryGen.fieldbyname('COMTB1').AsFloat;
      Parametro.fltComTb2    := qryGen.fieldbyname('COMTB2').AsFloat;
      Parametro.fltComTb3    := qryGen.fieldbyname('COMTB3').AsFloat;
      Parametro.fltComTb4    := qryGen.fieldbyname('COMTB4').AsFloat;
      Parametro.fltComTb5    := qryGen.fieldbyname('COMTB5').AsFloat;
      Parametro.fltComTb6    := qryGen.fieldbyname('COMTB6').AsFloat;
      Parametro.fltComTb7    := qryGen.fieldbyname('COMTB7').AsFloat;
      Parametro.fltMarBr1    := qryGen.fieldbyname('MARBR1').AsFloat;
      Parametro.fltMarBr2    := qryGen.fieldbyname('MARBR2').AsFloat;
      Parametro.fltMarBr3    := qryGen.fieldbyname('MARBR3').AsFloat;
      Parametro.fltMarBr4    := qryGen.fieldbyname('MARBR4').AsFloat;
      Parametro.fltMarBr5    := qryGen.fieldbyname('MARBR5').AsFloat;
      Parametro.fltMarBr6    := qryGen.fieldbyname('MARBR6').AsFloat;
      Parametro.fltMarBr7    := qryGen.fieldbyname('MARBR7').AsFloat;

      If qryGen.FindField('PREMED') <> nil Then
        Parametro.fltPreMed := qryGen.fieldbyname('PREMED').AsFloat;

      If qryGen.FindField('PREULT') <> nil Then
        Parametro.fltPreUlt := qryGen.fieldbyname('PREULT').AsFloat;

      If qryGen.FindField('IMPULT') <> nil Then
        Parametro.fltImpUlt := qryGen.fieldbyname('IMPULT').AsFloat;

      Parametro.fltIpiEnt := qryGen.fieldbyname('IPIENT').AsFloat;
      Parametro.fltPreCom := qryGen.fieldbyname('PRECOM').AsFloat;
      Parametro.fltDesF01 := qryGen.fieldbyname('DESF01').AsFloat;
      Parametro.fltDesF02 := qryGen.fieldbyname('DESF02').AsFloat;
      Parametro.fltDesF03 := qryGen.fieldbyname('DESF03').AsFloat;
      Parametro.fltDesF04 := qryGen.fieldbyname('DESF04').AsFloat;
      Parametro.fltDesF05 := qryGen.fieldbyname('DESF05').AsFloat;
      Parametro.fltDesF06 := qryGen.fieldbyname('DESF06').AsFloat;
      Parametro.strPreDol := qryGen.fieldbyname('PREDOL').AsString;
      Parametro.strCodAbf := qryGen.fieldbyname('CODABF').AsString;
      Parametro.strCodCli := strCodCli;
      Parametro.strEmpresasSelecionadas := strEmpresasSelecionadas;
      Parametro.strTabelasPrecoSelecionadas := strTabelasPrecoSelecionadas;
      Parametro.strCndPag := fGetCndPag;
      Parametro.fltCliVen := fStrToFloat(edtCliVen.Text, 0);

      fIncluirProdutoCds(
        strMsgProJaInc,
        strMsgProIncOu,
        strMsgItemEstr01,
        strMsgItemEstr02,
        strMsgProSemEstoque,
        Parametro);

      qryGen.Next;
    End;

    Result := True;
  End;

  If (Not fEmptyStr(strMsgProJaInc + strMsgProIncOu + strMsgItemEstr01 + strMsgItemEstr02 + strMsgProSemEstoque)) Then
  Begin
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.lblMensagem.Caption := 'O(s) item(s) abaixo possuem as seguintes observações:';

      If Not fEmptyStr(strMsgProIncOu) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs)+' - '+'Produtos que estão vigentes em outras promoções' + fMsgTabloid() + ': ' + #13#10 + strMsgProIncOu + #13#10);
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

    pFreeAndNil(frmObservacao);
  End;

  If (Result And blnImpPC) And (cdsCadPro.RecordCount > 0) Then
    dbeDesPro.Text := Concat(dbeDesPro.Text, ' ', strPedidos);

  If FLockExcel < 0  Then
  Begin
    pEnableControls(cdsCadPro, prcScroll);

    cxgItens.Refresh;
  End;
  pLimpaDadosItem;
  FreeAndNil(qryGen);
end;

procedure TfrmCadPromocoes.pAfterOpen(DataSet: TDataSet);
begin
  with DataSet do
  begin
    if Active then
    begin
      if FindField('PRO_DTAINI') <> nil then
        TDateField(FieldByName('PRO_DTAINI')).EditMask := '99/99/9999';

      if FindField('PRO_DTAFIN') <> nil then
        TDateField(FieldByName('PRO_DTAFIN')).EditMask := '99/99/9999';

      If FindField('PRO_QTDLIM') <> Nil Then
        TFloatField(FieldByName('PRO_QTDLIM')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

      If FindField('PRO_QTDMIN') <> Nil Then
        TFloatField(FieldByName('PRO_QTDMIN')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

      If FindField('PRO_VLRMIN') <> Nil Then
        TFloatField(FieldByName('PRO_VLRMIN')).DisplayFormat := '#,##0.00';
    end;
  end;
end;

procedure TfrmCadPromocoes.pCalculaCustoEMargem;
var
  intIndex : Integer;
  strNomeCampoComissaoPadrao: String;
  strNomeCampoComissao: String;
  fltMaiorPercentualComissao: Double;

  function fMargemBruta(strCampoCusto, strCampoVenda : String; strTabPrePar : String = ''): Double;
  Begin
    pCarregaValoresCusto(cdsCadPro.FieldByName('IPR_CODITE').AsString, VS_strCodEmp, strTabPrePar);
    Result := fCalculaPrecoVenda(2,
                                 IIF(strCampoCusto = 'ITE_PRECUS', fRetPreCus(cdsCadPro.FieldByName(strCampoCusto).AsFloat), cdsCadPro.FieldByName(strCampoCusto).AsFloat),
                                 cdsCadPro.FieldByName(strCampoVenda).AsFloat,
                                 0, 0, 0, 0, 0);
  End;

  function fMargemLiquida(strCampoCusto, strCampoVenda, strCampoComissao: String; strTabPrePar : String = ''): Double;
    Var
      fltIcmsST   : Double;
      blnCalcSt   : Boolean;
      strCodAbf   : String;
  Begin

    if (cdsCadPro.FindField('CODABF') <> Nil) then
      strCodAbf := cdsCadPro.FieldByName('CODABF').AsString
    else
      strCodAbf := cdsCadPro.FieldByName('ITE_CODABF').AsString;

    pCarregaValoresCusto(cdsCadPro.FieldByName('IPR_CODITE').AsString, VS_strCodEmp, strTabPrePar);

    fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                      strCodAbf,
                                      fPreComLiq(cdsCadPro, cdsCadPro.FieldByName('IPR_VLDSAD').AsFloat),
                                      cdsCadPro.FieldByName('ITE_IPIENT').AsFloat,
                                      fRetIcmSai(cdsCadPro.FieldByName('ITE_ICMSAI').AsFloat));

    Result := fCalculaPrecoVenda(2,
                                 IIF(strCampoCusto = 'ITE_PRECUS', fRetPreCus(cdsCadPro.FieldByName(strCampoCusto).AsFloat), cdsCadPro.FieldByName(strCampoCusto).AsFloat) +
                                 fRetOutVal(cdsCadPro.FieldByName('ITE_OUTVAL').AsFloat),
                                 cdsCadPro.FieldByName(strCampoVenda).AsFloat,
                                 0,
                                 fRetIcmSai(cdsCadPro.FieldByName('ITE_ICMSAI').AsFloat),
                                 fRetImpFed(cdsCadPro.FieldByName('ITE_IMPFED').AsFloat),
                                 fRetDesOpe(cdsCadPro.FieldByName('ITE_DESOPE').AsFloat),
                                 cdsCadPro.FieldByName(strCampoComissao).AsFloat,
                                 '',
                                 '',
                                 -1,
                                 fltIcmsST,
                                 blnCalcSt);
  End;

  function fCustoReal(strCampoCusto, strCampoVenda: String; strCampoComissao: String = ''; strTabPrePar : String = ''): Double;
  var
    LOutVal: Double;
  Begin
    LOutVal := fRetOutValComDespesa(cdsCadPro.FieldByName('ITE_OUTVAL').AsFloat, strCampoVenda, strCampoComissao);

    pCarregaValoresCusto(cdsCadPro.FieldByName('IPR_CODITE').AsString, VS_strCodEmp, strTabPrePar);

    If fEmptyStr(strCampoVenda) Then
      Result := fCalculaCustoReal(IIF(strCampoCusto = 'ITE_PRECUS', fRetPreCus(cdsCadPro.FieldByName(strCampoCusto).AsFloat), cdsCadPro.FieldByName(strCampoCusto).AsFloat),
                                  fRetIcmSai(cdsCadPro.FieldByName('ITE_ICMSAI').AsFloat),
                                  fRetImpFed(cdsCadPro.FieldByName('ITE_IMPFED').AsFloat),
                                  fRetDesOpe(cdsCadPro.FieldByName('ITE_DESOPE').AsFloat),
                                  fRetOutVal(LOutVal))
    Else
      Result := fCalculaPrecoCustoRealVenda(cdsCadPro.FieldByName(strCampoVenda).AsFloat,
                                            IIF(strCampoCusto = 'ITE_PRECUS', fRetPreCus(cdsCadPro.FieldByName(strCampoCusto).AsFloat), cdsCadPro.FieldByName(strCampoCusto).AsFloat),
                                            fRetOutVal(LOutVal),
                                            fRetIcmSai(cdsCadPro.FieldByName('ITE_ICMSAI').AsFloat),
                                            fRetImpFed(cdsCadPro.FieldByName('ITE_IMPFED').AsFloat),
                                            fRetDesOpe(cdsCadPro.FieldByName('ITE_DESOPE').AsFloat),
                                            0,
                                            0);
  End;

begin
  pInformacoesComissao(fltMaiorPercentualComissao, strNomeCampoComissao);

  strNomeCampoComissaoPadrao := strNomeCampoComissao;

  If (opcTipDes In [tdpDescon,
                    tdpPercentualPorQuantidadeMinimaEscalonada,
                    tdpPorcentoDescontoComDescontoAdicional,
                    tdpPorcentoDescontoQuantidadeColetiva,
                    tdpEstoqueRemanescente,
                    tdpNegociacaoEspecialFornecedorPC]) Then
  Begin
    If cdsCadPro.FieldByName('IPR_PRECUS').AsFloat <> 0 Then
    Begin
      For intIndex := 1 To clbTabPre.Items.Count Do
      Begin
        strNomeCampoComissao := strNomeCampoComissaoPadrao;
        If clbTabPre.Checked[intIndex-1] Then
        Begin
          If fCfgSis('SIMPVR', varBoolean) And (fltMaiorPercentualComissao <= cdsCadPro.FieldByName('ITE_COMTB' + intIndex.ToString).AsFloat) Then
            strNomeCampoComissao := 'ITE_COMTB' + intIndex.ToString;

          cdsCadPro.FieldByName('IPR_CUSRE' + intIndex.ToString).AsFloat := fCustoReal    ('IPR_PRECUS', 'IPR_PREVE' + intIndex.ToString, strNomeCampoComissao, intIndex.ToString);
          cdsCadPro.FieldByName('IPR_MARBR' + intIndex.ToString).AsFloat := fMargemBruta  ('IPR_PRECUS', 'IPR_PREVE' + intIndex.ToString,                       intIndex.ToString);
          cdsCadPro.FieldByName('IPR_MARLQ' + intIndex.ToString).AsFloat := fMargemLiquida('IPR_PRECUS', 'IPR_PREVE' + intIndex.ToString, strNomeCampoComissao, intIndex.ToString);
        End;
      End;

    End
    Else
    Begin

      For intIndex := 1 To clbTabPre.Items.Count Do
      Begin
        strNomeCampoComissao := strNomeCampoComissaoPadrao;
        If clbTabPre.Checked[intIndex-1] Then
        Begin
          If fCfgSis('SIMPVR', varBoolean) And (fltMaiorPercentualComissao <= cdsCadPro.FieldByName('ITE_COMTB' + intIndex.ToString).AsFloat) Then
            strNomeCampoComissao := 'ITE_COMTB' + intIndex.ToString;

          cdsCadPro.FieldByName('IPR_CUSRE' + intIndex.ToString).AsFloat := fCustoReal    ('ITE_PRECUS', 'IPR_PREVE' + intIndex.ToString, strNomeCampoComissao, intIndex.ToString);
          cdsCadPro.FieldByName('IPR_MARBR' + intIndex.ToString).AsFloat := fMargemBruta  ('ITE_PRECUS', 'IPR_PREVE' + intIndex.ToString,                       intIndex.ToString);
          cdsCadPro.FieldByName('IPR_MARLQ' + intIndex.ToString).AsFloat := fMargemLiquida('ITE_PRECUS', 'IPR_PREVE' + intIndex.ToString, strNomeCampoComissao, intIndex.ToString);
        End;
      End;

    End;
  End
  Else
  Begin
    If cdsCadPro.FieldByName('IPR_PRECUS').AsFloat <> 0 Then
    Begin
      cdsCadPro.FieldByName('IPR_CUSREA').AsFloat := fCustoReal('IPR_PRECUS', 'IPR_PREVEN', 'ITE_COMTB' + fGetTabPre);
      cdsCadPro.FieldByName('IPR_MARBRU').AsFloat := fMargemBruta('IPR_PRECUS', 'IPR_PREVEN');
      cdsCadPro.FieldByName('IPR_MARLIQ').AsFloat := fMargemLiquida('IPR_PRECUS', 'IPR_PREVEN', strNomeCampoComissao);
    End
    Else
    Begin
      cdsCadPro.FieldByName('IPR_CUSREA').AsFloat := fCustoReal    ('ITE_PRECUS', 'IPR_PREVEN', 'ITE_COMTB' + fGetTabPre, fGetTabPre);
      cdsCadPro.FieldByName('IPR_MARBRU').AsFloat := fMargemBruta  ('ITE_PRECUS', 'IPR_PREVEN',                           fGetTabPre);
      cdsCadPro.FieldByName('IPR_MARLIQ').AsFloat := fMargemLiquida('ITE_PRECUS', 'IPR_PREVEN', strNomeCampoComissao    , fGetTabPre);
    End;

    For intIndex := 1 To clbTabPre.Items.Count Do
    Begin
      If clbTabPre.Checked[intIndex-1] Then
      Begin
        cdsCadPro.FieldByName('IPR_MARBR' + intIndex.ToString).AsFloat := fMargemBruta('ITE_PRECUS', 'ITE_PREVE' + intIndex.ToString, intIndex.ToString);
        cdsCadPro.FieldByName('IPR_MARLQ' + intIndex.ToString).AsFloat := fMargemLiquida('ITE_PRECUS', 'ITE_PREVE' + intIndex.ToString, strNomeCampoComissao);
      End;
    End;
  End;

end;

procedure TfrmCadPromocoes.pCalculaPrecoVenda;
  Var
    fltPrecoCalcMargem: Double;
    qryDadosItem: TUniQuery;
    blnCalcSt: Boolean;
    fltIcmsST: Double;
begin
  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If (fInformouMargemBruta) And (fStrToFloat(edtMarBru.Text) <> fltMarBruBKP) Then
  Begin
    qryDadosItem := fCriaQuery;

    Try
      fltPrecoCalcMargem := fRetornaValorCalculoMargem;
      pCarregaQueryDadosItem(qryDadosItem);

      If (blnCalcMargemLiquida) And (Not qryDadosItem.IsEmpty) Then
      Begin
        fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                          qryDadosItem.FieldByName('ITE_CODABF').AsString,
                                          fPreComLiq(qryDadosItem, fStrToFloat(edtDesAdi.Text)),
                                          qryDadosItem.FieldByName('ITE_IPIENT').AsFloat,
                                          fRetIcmSai(qryDadosItem.FieldByName('ITE_ICMSAI').AsFloat));

        edtPreVen.Text := FormatFloat(fMskDigitos(intDecUni),
                                      fCalculaPrecoVenda(1,
                                                         fltPrecoCalcMargem,
                                                         0,
                                                         fStrToFloat(edtMarBru.Text),
                                                         fRetIcmSai(qryDadosItem.FieldByName('ITE_ICMSAI').AsFloat),
                                                         fRetImpFed(qryDadosItem.FieldByName('ITE_IMPFED').AsFloat),
                                                         fRetDesOpe(qryDadosItem.FieldByName('ITE_DESOPE').AsFloat),
                                                         qryDadosItem.FieldByName('ITE_COMTB' + fGetTabPre).AsFloat,
                                                         '',
                                                         '',
                                                         -1,
                                                         fltIcmsST,
                                                         blnCalcSt));

      End
      Else
        edtPreVen.Text := FormatFloat(fMskDigitos(intDecUni),
                                      fCalculaPrecoVenda(1,
                                                         fltPrecoCalcMargem,
                                                         0,
                                                         fStrToFloat(edtMarBru.Text),
                                                         0,0,0,0));
      fltPreVenBKP := fStrToFloat(edtPreVen.Text);
    Finally
      FreeAndNil(qryDadosItem);
    End;
  End
  Else If (fStrToFloat(edtMarBru.Text) <= 0) And
          (fltValorVendaBKP > 0) And
          (fltMarBruBKP <> fStrToFloat(edtMarBru.Text)) Then
    edtPreVen.Text := FormatFloat(fMskDigitos(intDecUni), fltValorVendaBKP);
end;

procedure TfrmCadPromocoes.pCalcularPrecoVendaReal;
var
  fltValorSTSimulador,
  fltValorIPISimulador,
  fltValorTotalSimulador : Double;
  objSimularLancamento   : TSimulaLancamentoItemVenda;
  fltPercComissao        : Double;
  strNomeCampoComissao   : String;
begin
  fltValorSTSimulador    := 0;
  fltValorIPISimulador   := 0;
  fltValorTotalSimulador := 0;

  FfltBocCai             := 0;
  FfltIcmSai             := 0;
  FfltImpFed             := 0;
  FfltDesOpe             := 0;
  FfltPreCus             := 0;

  Try
    If Not blnSimuladorPrecoVendaReal Then
      Exit;

    If fEmptyStr(edtCodIte.Text) Then
      Exit;

    If (fStrToFloat(edtPreVen.Text, 0) = 0) Then
      Exit;

    If (cxvFiltrosCodAbf.Properties.Value = Null) Then
      Exit;

    If (cxvFiltrosPerAbf.Properties.Value = Null) Then
      Exit;

    If (cxvFiltrosEstado.Properties.Value = Null) Then
      Exit;

    If fEmptyStr(cxvFiltrosCodAbf.Properties.Value) Then
      Exit;

    If fEmptyStr(cxvFiltrosPerAbf.Properties.Value) Then
      Exit;

    If fEmptyStr(cxvFiltrosEstado.Properties.Value) Then
      Exit;

    fltPercComissao      := 0;
    objSimularLancamento := TSimulaLancamentoItemVenda.Create;
    Try
      If cdsCadPro.State In [dsInsert, dsEdit] Then
        pInformacoesComissao(fltPercComissao, strNomeCampoComissao);

      objSimularLancamento.SimularLancamento(EmptyStr,
                                             edtCodIte.Text,
                                             1,
                                             fStrToFloat(edtPreVen.Text, 0),
                                             fStrToFloat(edtPreCus.Text, 0),
                                             fStrToFloat(edtPerDes.Text, 0),
                                             fltPercComissao,
                                             cxvFiltrosCodAbf.Properties.Value,
                                             cxvFiltrosPerAbf.Properties.Value,
                                             cxvFiltrosEstado.Properties.Value);

      fltValorSTSimulador    := objSimularLancamento.ValorST;
      fltValorIPISimulador   := objSimularLancamento.ValorIpi;
      fltValorTotalSimulador := fltValorSTSimulador
                              + fltValorIPISimulador
                              + fStrToFloat(edtPreVen.Text, 0);

      FfltBocCai := objSimularLancamento.OutrosValores;
      FfltIcmSai := objSimularLancamento.ValorIcms;
      FfltImpFed := objSimularLancamento.ImpostosFederais;
      FfltDesOpe := objSimularLancamento.DespesasOperacionais;
      FfltPreCus := objSimularLancamento.CustoReal;
    Finally
      FreeAndNil(objSimularLancamento);
    End;
  Finally
    lblValorST.Caption         := FormatFloat(',0.00', fFormataFloat(fltValorSTSimulador, 2));
    lblValorIPI.Caption        := FormatFloat(',0.00', fFormataFloat(fltValorIPISimulador, 2));
    lblValorTotalVenda.Caption := FormatFloat(',0.00', fFormataFloat(fltValorTotalSimulador, 2));
  End;
end;

procedure TfrmCadPromocoes.pCarregaCadIte(blnAtualizaTela: Boolean);
  Var
    strSQL: String;
    strTabPre: String;
    fltCusto: Double;
    fltMargem: Double;
    fltVenda: Double;
    fltPreRea: Double;
    intTabPre : Integer;
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

  With qryConIte Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := edtCodIte.Text;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If (blnAtualizaTela) Then
    Begin
      pSetaVisibilidadePrecoFixoTmqImo(qryConIte.FieldByName('ITE_ITEBAS').AsString = 'S');
      pDesmarcaPrecoFixoTmqImoQuandoInvisivel;

      edtDesIte.Text := FieldByName('ITE_DESITE').AsString;

      If (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos],
                                  IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoPorQuantidadeMinimaEscalonada],
                                  IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional],
                                  IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva],
                                  IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional],
                                  IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoPorVlrMinProd]
                                  ]) Then
      Begin

        strTabPre := fGetTabPre;

        pCarregaValoresCusto(edtCodIte.Text, VS_strCodEmp, strTabPre);

        edtPreCusCad.Text := FloatToStrF(fRetPreCus(FieldByName('ITE_PRECUS').AsFloat), ffFixed, 12, 2);

        If (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional],
                                    IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]]) Then
          edtPreCus.Text := FloatToStrF(fRetPreCus(FieldByName('ITE_PRECUS').AsFloat), ffFixed, 12, 2)
        Else
          edtPreCus.Text := FloatToStrF(0, ffFixed, 12, 2);

        edtPreVen.Text := FloatToStrF(FieldByName('ITE_PREVE' + strTabPre).AsFloat, ffFixed, 12, intDecUni);
        edtPerDes.Text := fFloatToStrVirgula(0, 12, intPrecisaoDescontoItem);
        edtMarBru.Text := FloatToStrF(0, ffFixed, 12, intDecUni);

        if edtMarBru.Visible then
          fltValorVendaBKP := fStrToFloat(edtPreVen.Text);

        If (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional],
                                    IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]]) And
           (Not fEmptyStr(edtCodIte.Text)) And
           (fStrToFloat(edtDesAdi.Text) > 0) Then
        Begin
          If (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional]) Then
            intTabPre := StrToIntDef(cmbTabPre.Text, 0)
          Else
            intTabPre := 1;

          If (intTabPre In [1..7]) Then
            pRetCustoMargemVenda(edtCodIte.Text,
                                 IntToStr(intTabPre),
                                 fStrToFloat(edtDesAdi.Text),
                                 fltCusto,
                                 fltMargem,
                                 fltVenda,
                                 fltPreRea);

          edtPreCus.Text := FloatToStrF(fltCusto, ffFixed, 12, 2);
          edtPreVen.Text := FloatToStrF(fltVenda, ffFixed, 12, intDecUni);
        End;
      End
      Else If (TTipDescPro(rdgPreDes.ItemIndex) = tdpEstoqueRemanescente) Then
      Begin
        edtPreCus.Text := '0,00';
        edtPreVen.Text := '0,00';
        edtPerDes.Text := fFloatToStrVirgula(0, 12, intPrecisaoDescontoItem);
      End
      Else
      Begin
        edtPreCus.Text := FloatToStrF(0, ffFixed, 12, 2);
        strTabPre      := fGetTabPre;
        edtPreVen.Text := FloatToStrF(FieldByName('ITE_PREVE' + strTabPre).AsFloat, ffFixed, 12, intDecUni);
      End;

      edtComVar.Text := FloatToStrF(FieldByName('ITE_COMVAR').AsFloat, ffFixed, 12, 2);
      edtComAta.Text := FloatToStrF(FieldByName('ITE_COMATA').AsFloat, ffFixed, 12, 2);
      edtComDis.Text := FloatToStrF(FieldByName('ITE_COMDIS').AsFloat, ffFixed, 12, 2);
      edtPrzMed.Text := '0';
    End;

  End;
end;

procedure TfrmCadPromocoes.pCarregaInformacoesFiltrosSimuladorPrecoVendaReal;
var
  intContador: Integer;
begin

  //Preenche Combo de Estados para Filtro
  TcxComboBoxProperties(cxvFiltrosEstado.Properties.EditProperties)
      .Items.Clear;

  For intContador := 0 To 26 Do
  Begin
    TcxComboBoxProperties(cxvFiltrosEstado.Properties.EditProperties)
        .Items.Add(ESTADOS[intContador]);
  End;
end;

procedure TfrmCadPromocoes.pCarregaItemAlteracao;
begin
  btnConfirmar.Tag := 1;

  With cdsCadPro Do
  Begin
    edtCodIte.Text := FieldByName('IPR_CODITE').AsString;
    pCarregaCadIte(True);

    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
    edtQtdLim.Text := FieldByName('IPR_QTDLIM').AsString;
    edtQtdMin.Text := FieldByName('IPR_QTDMIN').AsString;
    edtPreCus.Text := FloatToStrF(FieldByName('IPR_PRECUS').AsFloat, ffFixed, 12, 2);
    edtPreVen.Text := FloatToStrF(FieldByName('IPR_PREVEN').AsFloat, ffFixed, 12, intDecUni);
    edtPerDes.Text := FloatToStrF(FieldByName('IPR_PERDES').AsFloat, ffFixed, 12, intPrecisaoDescontoItem);
    edtComVar.Text := FloatToStrF(FieldByName('IPR_COMVAR').AsFloat, ffFixed, 12, 2);
    edtComAta.Text := FloatToStrF(FieldByName('IPR_COMATA').AsFloat, ffFixed, 12, 2);
    edtComDis.Text := FloatToStrF(FieldByName('IPR_COMDIS').AsFloat, ffFixed, 12, 2);
    edtPrzMed.Text := IntToStr(FieldByName('IPR_PRZMED').AsInteger);
    edtPerEst.Text := FloatToStrF(FieldByName('IPR_PEREST').AsFloat, ffFixed, 12, 2);

    edtCliVen.Text := FloatToStrF(FieldByName('IPR_CLIVEN').AsFloat, ffFixed, 12, 2);

    If gpbDesAdi.Enabled Then
      edtDesAdi.Text := FloatToStrF(FieldByName('IPR_VLDSAD').AsFloat, ffFixed, 12, 2);
    If cmbTabPre.Enabled And (FieldByName('IPR_TBDSAD').AsInteger > 0) Then
      cmbTabPre.ItemIndex := cmbTabPre.Items.IndexOf(FieldByName('IPR_TBDSAD').AsString);

    If (qryTabela.State = dsEdit) Then
      pDisableEdit(edtPerEst, False, True);

    pSetEnabledComissao;
    pVisiblePanelValores(True);

    If (blnCalcMargemLiquida) Then
      edtMarBru.Text := edtMarg01.Text
    Else
      edtMarBru.Text := FloatToStrF(FieldByName('IPR_MARBRU').AsFloat, ffFixed, 12, intDecUni);

    ckbPrecoFixoParaTmqImo.Checked := (ckbPrecoFixoParaTmqImo.Visible) And (cdsCadPro.FieldByName('IPR_PFTMIM').AsString = 'S');
  End;
  SelectNext(edtCodIte, True, True);
  edtCodIte.Enabled := False;
  cxgItens.Enabled := False;
end;

procedure TfrmCadPromocoes.pControlaPrecoDesconto(opcPreDes: TTipDescPro);
Var
  blnDesc: Boolean;
  intContador: Integer;
begin
  blnDesc := (opcPreDes In [tdpDescon,
                            tdpPercentualPorQuantidadeMinimaEscalonada,
                            tdpPorcentoDescontoComDescontoAdicional,
                            tdpPorcentoDescontoQuantidadeColetiva]);

  cxgItensIPR_PERDES.Visible := blnDesc;

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

  pDisableEdit(dbeDtaInicial);
  pDisableEdit(dbeDtaFinal);
  pDisableEdit(edtPerEst);

  pEnabledEdit(mskLinhaGrupo);
  pEnabledEdit(edtCodIte);
  pEnabledEdit(edtMarca);
  pEnabledEdit(edtFornecedor);
  pEnabledEdit(edtDescriIni);
  pEnabledEdit(edtDescriFin);
  pEnabledEdit(edtRefere);
  pEnabledEdit(edtUnidade);

  chkTabloid.Enabled := (Not blnEcomme) or fCfgSis('PMPEPT', varBoolean);

  If Not chkTabloid.Enabled Then
  Begin
    chkTabloid.Checked := False;
    If (chkTabloid.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
      chkTabloid.Field.AsString := 'N';
  End;

  If Not fVerificaAcessoSistema('PERIAE', strLoginUsuarioLogado) then
  Begin
    chkTabloid.Enabled := False;
  End;

  If (opcPreDes = tdpPrecos) Or
     (opcPreDes = tdpPrecoPorQuantidadeMinimaEscalonada) Or
     (opcPreDes = tdpPrecoPorVlrMinProd) Then
  Begin
    pEnabledEdit(edtPreVen);

    If (opcPreDes = tdpPrecos) Then
      pEnabledEdit(edtMarBru);

    If (blnCusLib) Then
      pEnabledEdit(edtPreCus)
    Else
      pDisableEdit(edtPreCus);

    If (opcPreDes = tdpPrecoPorVlrMinProd) Then
    Begin
      pDisableEdit(edtQtdLim);
      pDisableEdit(edtQtdMin);
    End
    Else
    Begin
      If fPermiteQtdeLimite Then
        pEnabledEdit(edtQtdLim)
      Else
        pDisableEdit(edtQtdLim);

      if not blnEcomme then
        pEnabledEdit(edtQtdMin)
      else
        pDisableEdit(edtQtdMin);
    End;

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpPrecosDescAdicional) Then
  Begin
    pEnabledEdit(edtQtdLim);
    pEnabledEdit(edtQtdMin);

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpPrecoQuantidadeColetiva) Then
  Begin
    pEnabledEdit(edtPreVen);

    If (blnCusLib) Then
      pEnabledEdit(edtPreCus)
    Else
      pDisableEdit(edtPreCus);

    pEnabledEdit(dbeQtdLim);
    pEnabledEdit(dbeQtdMin);

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpPorcentoDescontoQuantidadeColetiva) Then
  Begin
    pEnabledEdit(dbeQtdLim);
    pEnabledEdit(dbeQtdMin);
    pEnabledEdit(edtPerDes);

    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);
    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpDescPorVlrMinProd) Then
  Begin
    pEnabledEdit(edtPerDes);

    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpPorcentoDescontoComDescontoAdicional) Then
  Begin
    pEnabledEdit(edtQtdLim);
    pEnabledEdit(edtQtdMin);

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';
  End
  Else If (opcPreDes = tdpEstoqueRemanescente) Then
  Begin
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);

    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);

    pEnabledEdit(dbeDtaInicial);
    pEnabledEdit(dbeDtaFinal);

    pEnabledEdit(edtPerEst);
    edtPerEst.Text := '100,00';

    dbeDtaInicial.Text := DateToStr(VS_Date - 30);
    dbeDtaFinal.Text   := DateToStr(VS_Date);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    cxgItensTableView.Bands[3].Visible  := False;
    cxgItensTableView.Bands[4].Visible  := clbTabPre.Checked[0];
    cxgItensTableView.Bands[5].Visible  := clbTabPre.Checked[1];
    cxgItensTableView.Bands[6].Visible  := clbTabPre.Checked[2];
    cxgItensTableView.Bands[7].Visible  := clbTabPre.Checked[3];
    cxgItensTableView.Bands[8].Visible  := clbTabPre.Checked[4];
    cxgItensTableView.Bands[9].Visible  := clbTabPre.Checked[5];
    cxgItensTableView.Bands[10].Visible := clbTabPre.Checked[6];

    If (qryTabela.State = dsInsert) Then
      For intContador := 0 To clbEmpresa.Items.Count -1 Do
        clbEmpresa.Checked[intContador] := False;
  End
  Else If (opcPreDes = tdpNegociacaoEspecialFornecedorPC) Then
  Begin
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);

    pDisableEdit(mskLinhaGrupo);
    pDisableEdit(edtCodIte, True);
    pDisableEdit(edtMarca, True);
    pDisableEdit(edtFornecedor, True);
    pDisableEdit(edtDescriIni, True);
    pDisableEdit(edtDescriFin, True);
    pDisableEdit(edtRefere, True);
    pDisableEdit(edtUnidade, True);

    pDisableEdit(edtPerDes, False, False, intPrecisaoDescontoItem);
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;

    dbeDtaInicial.Clear;
    dbeDtaFinal.Clear;
    edtPerEst.Text := '0,00';

    cxgItensTableView.Bands[3].Visible  := False;
    cxgItensTableView.Bands[4].Visible  := clbTabPre.Checked[0];
    cxgItensTableView.Bands[5].Visible  := clbTabPre.Checked[1];
    cxgItensTableView.Bands[6].Visible  := clbTabPre.Checked[2];
    cxgItensTableView.Bands[7].Visible  := clbTabPre.Checked[3];
    cxgItensTableView.Bands[8].Visible  := clbTabPre.Checked[4];
    cxgItensTableView.Bands[9].Visible  := clbTabPre.Checked[5];
    cxgItensTableView.Bands[10].Visible := clbTabPre.Checked[6];
  End
  Else If (opcPreDes = tdpPrecoPorVlrMinProd) Or
          (opcPreDes = tdpDescPorVlrMinProd) Then
  Begin
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);
    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);
  End
  Else
  Begin
    pEnabledEdit(edtPerDes);
    pEnabledEdit(edtQtdLim);
    pEnabledEdit(edtQtdMin);

    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);
    pDisableEdit(edtPreVen);
    pDisableEdit(edtPreCus);

    edtDesAdi.Text := '0,00';
    cmbTabPre.ItemIndex := -1;
  End;

  rdgQtdLim.Enabled := fEnabledRdgQtdLim(opcPreDes) And pnlCabecalho.Enabled;
  gpbDesAdi.Enabled := (opcPreDes In [tdpPrecosDescAdicional, tdpPorcentoDescontoComDescontoAdicional]) And pnlDadosItem.Enabled;
  gpbDesAdi.Visible := gpbDesAdi.Enabled;
  cmbTabPre.Enabled := (gpbDesAdi.Enabled) And (opcPreDes = tdpPrecosDescAdicional);

  edtPerDes.Enabled := pnlDadosItem.Enabled;
  edtPreCus.Enabled := blnCusLib And pnlDadosItem.Enabled;
  edtPreVen.Enabled := pnlDadosItem.Enabled;
  edtMarBru.Enabled := pnlDadosItem.Enabled;
end;

procedure TfrmCadPromocoes.pCriarProLog;
Var
  LCampo: TProLogCampo;
  I: Integer;
begin
  FProLog := TProLog.New(dbeCodPro.Text);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_DESPRO';
  LCampo.DescricaoCampo := 'Descrição da promoção';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_ECOMME';
  LCampo.DescricaoCampo := 'Promoção para e-commerce';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_IDXPRO';
  LCampo.DescricaoCampo := 'Promoção por';
  For I := 0 To rdgPreDes.Items.Count -1 Do
  Begin
    pAddDados(LCampo.Valores, I.ToString);
    pAddDados(LCampo.DescricaoValores, rdgPreDes.Items[I]);
  End;
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_COMPRO';
  LCampo.DescricaoCampo := 'Considerar Comissão';
  pAddDados(LCampo.Valores, 'P');
  pAddDados(LCampo.DescricaoValores, rdgComPro.Items[0]);
  pAddDados(LCampo.Valores, 'V');
  pAddDados(LCampo.DescricaoValores, rdgComPro.Items[1]);
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_IDXQTD';
  LCampo.DescricaoCampo := 'Aplicar quantidade limite desta promoção';
  For I := 0 To rdgQtdLim.Items.Count -1 Do
  Begin
    pAddDados(LCampo.Valores, I.ToString);
    pAddDados(LCampo.DescricaoValores, rdgQtdLim.Items[I]);
  End;
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_ENTIME';
  LCampo.DescricaoCampo := 'Permite entrega imediata';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_ENTFUT';
  LCampo.DescricaoCampo := 'Permite entrega futura';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_AGUCLI';
  LCampo.DescricaoCampo := 'Permite entrega futura - Aguardando cliente';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_PREVIS';
  LCampo.DescricaoCampo := 'Permite entrega futura - Previsão';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_FALPRO';
  LCampo.DescricaoCampo := 'Permite entrega futura - Falta de produto';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_COMSAL';
  LCampo.DescricaoCampo := 'Somar Pedidos de Compra em aberto no saldo disponível para calcular o estoque remanescente';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_RESNCO';
  LCampo.DescricaoCampo := 'Promoção restrita a clientes não consumidor';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_QTDLIM';
  LCampo.DescricaoCampo := 'Qtde.Limite';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_QTDMIN';
  LCampo.DescricaoCampo := 'Qtd.Mínima';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_TABLOI';
  LCampo.DescricaoCampo := 'Promoção em Tabloid';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_DTAINI';
  LCampo.DescricaoCampo := 'Validade inicial';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_DTAFIN';
  LCampo.DescricaoCampo := 'Validade final';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_TABPRE';
  LCampo.DescricaoCampo := 'Tabelas de preço selecionadas';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'PROEMP';
  LCampo.NomeCampo  := 'PRO_CODEMP';
  LCampo.DescricaoCampo := 'Empresa(s) promoção';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'PROCLI';
  LCampo.NomeCampo  := 'PRO_CODCLI';
  LCampo.DescricaoCampo := 'Cliente(s) promoção';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CNDPRO';
  LCampo.NomeCampo  := 'CPR_CODCND';
  LCampo.DescricaoCampo := 'Condições pagamento promoção';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_QTDMIN';
  LCampo.DescricaoCampo := 'Qtd. Mínima Produto';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_QTDLIM';
  LCampo.DescricaoCampo := 'Qtd. Limite Produto';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_VLDSAD';
  LCampo.DescricaoCampo := 'Desconto adicional sobre preço de compra';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_TBDSAD';
  LCampo.DescricaoCampo := 'Gerar preço de venda com base na tabela';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_COMVAR';
  LCampo.DescricaoCampo := '% Comiss. Vend. Interno';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_COMATA';
  LCampo.DescricaoCampo := '% Comiss. Repres. Ext. Loja';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_COMDIS';
  LCampo.DescricaoCampo := '% Comiss. Repres. Ext. Distrib.';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_PRZMED';
  LCampo.DescricaoCampo := 'Prz Méd. Cond. Pagto.';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_PRECUS';
  LCampo.DescricaoCampo := 'Preço Custo';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_PREVEN';
  LCampo.DescricaoCampo := 'Preço Venda';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_PERDES';
  LCampo.DescricaoCampo := '% Desconto';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'ITEPRO';
  LCampo.NomeCampo  := 'IPR_PEREST';
  LCampo.DescricaoCampo := '% Estoque Disponível que será colocado em promoção';
  FProLog.AddCampoLog(LCampo);

  FillChar(LCampo, SizeOf(LCampo), #0);
  LCampo.NomeTabela := 'CADPRO';
  LCampo.NomeCampo  := 'PRO_VLRMIN';
  LCampo.DescricaoCampo := 'Valor mínimo do total dos produtos';
  FProLog.AddCampoLog(LCampo);
end;

procedure TfrmCadPromocoes.pCriaTemporaria;
begin
  cdsCadPro := TUniClientDataSet.Create(Self);
  qryCadPro := fCriaQuery(Self);
  qryCadUni := fCriaQuery(Self);
  cdsPCMPRO := fCriaCdsPCMPRO();
end;

procedure TfrmCadPromocoes.pDeletaTemporaria;
begin
  If cdsCadPro.Active Then
    cdsCadPro.EmptyDataSet;
end;

procedure TfrmCadPromocoes.pDisableEdit(Edit: TCustomEdit;
  blnTexto: Boolean = False; blnManterValor: Boolean = False;
  intQtdDec: Integer = 2);
begin
  If (Edit Is TEditFocus) Then
  Begin
    TEditFocus(Edit).ReadOnly := True;
    TEditFocus(Edit).TabStop := False;
    If (Not blnManterValor) Then
      TEditFocus(Edit).Text := IIF(blnTexto, '', fFloatToStrVirgula(0, 12, intQtdDec));
    TEditFocus(Edit).Color := $00FFE4D5;
  End
  Else If (Edit Is TMaskEditFocus) Then
  Begin
    TMaskEditFocus(Edit).ReadOnly := True;
    TMaskEditFocus(Edit).TabStop := False;
    TMaskEditFocus(Edit).Color := $00FFE4D5;
  End
  Else If (Edit Is TDBEditFocus) Then
  Begin
    TDBEditFocus(Edit).ReadOnly := True;
    TDBEditFocus(Edit).TabStop := False;
    TDBEditFocus(Edit).Color := $00FFE4D5;
    If (TDBEditFocus(Edit).DataSource.DataSet.State In [dsInsert, dsEdit]) Then
    Begin
      If (Not blnManterValor) Then
        TDBEditFocus(Edit).DataSource.DataSet.FieldByName(TDBEditFocus(Edit).DataField).Value := 0;
    End;
  End;
end;

procedure TfrmCadPromocoes.pEnableDisablePanel(Panel: TPanel; blnEnabled: Boolean = True);
begin
  Panel.Enabled := blnEnabled;

  If (Panel = pnlCabecalho) Then
  Begin

    rdgUtilizarLimitePorClienteOuVenda.Enabled := blnEnabled;

    dbeDesPro.Enabled := blnEnabled;
    chkEntIme.Enabled := blnEnabled;
    chkEntFut.Enabled := blnEnabled;
    chkAguCli.Enabled := blnEnabled;
    chkPrevis.Enabled := blnEnabled;
    chkFalPro.Enabled := blnEnabled;
    chkEcommerce.Enabled := blnEnabled;
    rdgPreDes.Enabled := blnEnabled And (qryTabela.State = dsInsert);
    rdgComPro.Enabled := blnEnabled;
    rdgQtdLim.Enabled := blnEnabled And fEnabledRdgQtdLim(TTipDescPro(rdgPreDes.ItemIndex));

    pTrataCheckboxEstoqueRemanescente(TTipDescPro(rdgPreDes.ItemIndex), blnEnabled);

    dbeQtdLim.Enabled := blnEnabled;
    dbeQtdMin.Enabled := blnEnabled;
    dbeDtaIni.Enabled := blnEnabled;
    dbeDtaFin.Enabled := blnEnabled;
  End
  Else If (Panel = pnlDadosItem) Then
  Begin
    dbeDtaInicial.Enabled := blnEnabled;
    dbeDtaFinal.Enabled := blnEnabled;
    mskLinhaGrupo.Enabled := blnEnabled;
    edtCodIte.Enabled := blnEnabled And (strAltGrd = 'N');
    edtMarca.Enabled := blnEnabled;
    edtFornecedor.Enabled := blnEnabled;
    edtDescriIni.Enabled := blnEnabled;
    edtDescriFin.Enabled := blnEnabled And (Not fEmptyStr(edtDescriIni.Text));
    edtRefere.Enabled := blnEnabled;
    edtUnidade.Enabled := blnEnabled;
    edtQtdLim.Enabled := blnEnabled And fPermiteQtdeLimite;
    edtQtdMin.Enabled := blnEnabled And Not blnEcomme;
    edtPerEst.Enabled := blnEnabled;
    edtDesAdi.Enabled := blnEnabled;
    cmbTabPre.Enabled := blnEnabled;
    edtPreCus.Enabled := blnEnabled And blnCusLib;
    edtComVar.Enabled := blnEnabled And blnComPro;
    edtComAta.Enabled := blnEnabled And blnComPro;
    edtComDis.Enabled := blnEnabled And blnComPro;
    edtPrzMed.Enabled := blnEnabled;

    gpbDesAdi.Enabled := (TTipDescPro(rdgPreDes.ItemIndex) In [tdpPrecosDescAdicional, tdpPorcentoDescontoComDescontoAdicional]) And blnEnabled;
    gpbDesAdi.Visible := gpbDesAdi.Enabled;
    cmbTabPre.Enabled := (gpbDesAdi.Enabled) And (TTipDescPro(rdgPreDes.ItemIndex) = tdpPrecosDescAdicional);

    edtPerDes.Enabled := blnEnabled;
    edtPreVen.Enabled := blnEnabled;
    edtMarBru.Enabled := blnEnabled;

    btnConfirmar.Enabled := blnEnabled;
    btnCancelaItem.Enabled := blnEnabled;

    cxgItens.Enabled := blnEnabled And (strAltGrd = 'N');
  End;
end;

procedure TfrmCadPromocoes.pAfterScroll(Dataset: TDataset);
  Var
    strEmpresas: string;
begin
  strEmpresas := fCampoTabela('GROUP_CONCAT(PRO_CODEMP)', 'PROEMP', ['PRO_SEQGER'], [qryTabela.FieldByName('AUTOINCREM').AsString]);

  pMarcarEmpresas(strEmpresas);
  pMarcarTabelasPreco(qryTabela.FieldByName('PRO_TABPRE').AsString);

  strEmpSelAnt := fGetEmpresasSelecionadas;
  strTabSelAnt := fGetTabelasPrecoSelecionadas;

  pnlTabelas.Enabled := (qryTabela.State In [dsInsert, dsEdit]);
  pnlEmpresa.Enabled := (qryTabela.State In [dsInsert, dsEdit]);
end;

procedure TfrmCadPromocoes.pAjustaCamposOpcaoPromocaoValorMinimo;
begin
  rdgConsideraVlrMin.Enabled := False;
  If Not fCfgSis('UTIVMP', varBoolean) Then
  Begin
    rdgConsideraVlrMin.Visible := False;
    Exit;
  End;

  If opcTipDes in [tdpPrecoPorVlrMinProd, tdpDescPorVlrMinProd] Then
  Begin
    pDisableEdit(dbeQtdLim);
    pDisableEdit(dbeQtdMin);
    pDisableEdit(edtQtdLim);
    pDisableEdit(edtQtdMin);

    If (qryTabela.State In [dsInsert, dsEdit]) Then
      rdgConsideraVlrMin.Enabled := True;
  End
  Else
  Begin
    rdgConsideraVlrMin.Enabled := False;
    rdgConsideraVlrMin.ItemIndex := -1;
  End;
end;

procedure TfrmCadPromocoes.pAjustarAbasAoConsiderarCndPag;
  var
    intPosicoes : Integer;

  procedure pReordenar(var tbsAux : TTabSheet; strCap : String; blnInc : Boolean);
  begin
    tbsAux.PageIndex := intPosicoes;
    intPosicoes      := IIF(blnInc, Succ(intPosicoes), intPosicoes);
    tbsAux.Caption   := strCap.Replace('[X]', intPosicoes.ToString);
  end;

begin

  If Not fCfgSis('VCPPRO', varBoolean) Then
    Exit;

  intPosicoes := 0;

  pReordenar(tbsGeral          , '&[X] - Geral'               , True );
  pReordenar(tbsCondPagto      , '&[X] - Condições de Pagto.' , True );
  pReordenar(tbsItens          , '&[X] - Itens da Promoção'   , True );
  pReordenar(tsKitParaPromocao , '&[X] - Kits Para Promoção'  , False); {<< Usa mesmo índice de "Itens da Promoção" >>}
  pReordenar(tbsClientes       , '&[X] - Clientes da Promoção', True );

end;

procedure TfrmCadPromocoes.pAjustaValoresPromocao;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.fExecutarAcao := fAjustaValoresPromocao;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

function TfrmCadPromocoes.fAjustaValoresPromocao(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    prcScroll: TprcScroll;
begin
  pDisableControls(cdsAuxItePro, prcScroll);
  Try
    cdsAuxItePro.Filter:='AUX_MODIFI = ''S''';
    cdsAuxItePro.Last;
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Atualizando Itens...', cdsAuxItePro.RecordCount);
    cdsAuxItePro.First;

    With cdsAuxItePro Do
    Begin
      While Not Eof Do
      Begin

        If cdsCadPro.Locate('IPR_CODITE', FieldByName('IPR_CODITE').AsString, []) Then
        Begin
          cdsCadPro.Edit;
          pStepStatusGravacao(pgbStatus, Format('Atualizando [%s]',
                             [LeftStr(FieldByName('ITE_DESITE').AsString, 25) + '...']));

          If (opcTipDes In [tdpDescon,
                            tdpPercentualPorQuantidadeMinimaEscalonada,
                            tdpPorcentoDescontoQuantidadeColetiva]) Then
            cdsCadPro.FieldByName('IPR_PERDES').AsFloat:=FieldByName('AUX_VALATU').AsFloat
          Else
            cdsCadPro.FieldByName('IPR_PREVEN').AsFloat:=FieldByName('AUX_VALATU').AsFloat;

          cdsCadPro.Post;
        End;

        Next;
      End;
    End;

  Finally
    Result := True;
    pEnableControls(cdsAuxItePro, prcScroll);
  End
end;

function TfrmCadPromocoes.fAlgumFiltroDeClienteFoiInformado: Boolean;
begin

  Result := True;

  If (Not fEmptyStr(edtCodCli.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodAti.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodCid.Text)) Then
    Exit;

  If (Not fEmptyStr(edtEstado.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodReg.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodSub.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodRed.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodCac.Text)) Then
    Exit;

  If (Not fEmptyStr(fTiraCaracEspeciais(edtNuCnpj.Text))) Then
    Exit;

  If (Not fEmptyStr(cbxCategoria.Text)) Then
    Exit;

  If (Not fEmptyStr(edtCodVen.Text)) Then
    Exit;

  Result := False;

end;

function TfrmCadPromocoes.fAtualizaComissaoCadPro(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryConIte : TUniQuery;
Begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Atualizando Comissões...', cdsCadPro.RecordCount);
  qryConIte := fCriaQuery(Self);

  With cdsCadPro Do
  Begin
    First;

    While Not Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      qryConIte.SQL.Clear;
      qryConIte.SQL.Add('SELECT SQL_NO_CACHE ');
      qryConIte.SQL.Add('  ITE_COMVAR, ');
      qryConIte.SQL.Add('  ITE_COMATA, ');
      qryConIte.SQL.Add('  ITE_COMDIS  ');
      qryConIte.SQL.Add('FROM ');
      qryConIte.SQL.Add('  ITEGER ');
      qryConIte.SQL.Add('WHERE TRUE ');
      qryConIte.SQL.Add('  AND ITE_CODITE = :CODITE ');
      qryConIte.SQL.Add('  AND ITE_CODEMP = :CODEMP ');
      qryConIte.ParamByName('CODITE').AsString := FieldByName('IPR_CODITE').AsString;
      qryConIte.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryConIte.Open;

      If Not (qryConIte.IsEmpty) Then
      Begin
        Edit;
        FieldByName('IPR_COMVAR').AsFloat := qryConIte.FieldByName('ITE_COMVAR').AsFloat;
        FieldByName('IPR_COMATA').AsFloat := qryConIte.FieldByName('ITE_COMATA').AsFloat;
        FieldByName('IPR_COMDIS').AsFloat := qryConIte.FieldByName('ITE_COMDIS').AsFloat;
        Post;
      End;

      Next;
    End;

    Result := True;
  End;

  FreeAndNil(qryConIte);

  cxgItens.Refresh;
end;

function TfrmCadPromocoes.fAtualizaValoresConformeCadIte(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryGen,
    qryUpd: TUniQuery;
    intCnt: Integer;
begin
  Result := True;

  pInfoStatusGravacao(pgbStatus, 'Aguarde, Verificando preços atuais de venda...');
  qryGen := fCriaQuery;
  qryUpd := fCriaQuery;
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE1 AS PREVE1, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE2 AS PREVE2, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE3 AS PREVE3, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE4 AS PREVE4, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE5 AS PREVE5, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE6 AS PREVE6, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE7 AS PREVE7, ');
    qryGen.SQL.Add('   ITEGER.ITE_PREVE7 AS PREVE7, ');
    qryGen.SQL.Add('   ITEPRO.IPR_PERDES AS PERDES, ');
    qryGen.SQL.Add('   ITEPRO.AUTOINCREM AS AUTINC  ');
    qryGen.SQL.Add('FROM CADPRO');
    qryGen.SQL.Add('   INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM');
    qryGen.SQL.Add('   INNER JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE AND ITEGER.ITE_CODEMP = '+QuotedStr(Vs_StrCodEmp));
    qryGen.SQL.Add('WHERE PRO_CODPRO = '+QuotedStr(strCodProAtual));
    qryGen.SQL.Add('  AND ((ROUND(IPR_PREVEN+(ITE_PREVE1*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE1,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE2+(ITE_PREVE2*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE2,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE3+(ITE_PREVE3*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE3,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE4+(ITE_PREVE4*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE4,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE5+(ITE_PREVE5*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE5,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE6+(ITE_PREVE6*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE6,4)) OR');
    qryGen.SQL.Add('       (ROUND(IPR_PREVE7+(ITE_PREVE7*(IPR_PERDES/100)),4) <> ROUND(ITE_PREVE7,4)))');
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
    Begin
      qryUpd.SQL.Text:='UPDATE ITEPRO SET IPR_PREVEN = :PREVE1, '+
                                         'IPR_PREVE2 = :PREVE2, '+
                                         'IPR_PREVE3 = :PREVE3, '+
                                         'IPR_PREVE4 = :PREVE4, '+
                                         'IPR_PREVE5 = :PREVE5, '+
                                         'IPR_PREVE6 = :PREVE6, '+
                                         'IPR_PREVE7 = :PREVE7  '+
                       'WHERE AUTOINCREM = :AUTINC              ';

      pInfoStatusGravacao(pgbStatus, 'Aguarde, Autalizando novos preços de venda...', qryGen.RecordCount);
      While Not qryGen.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        qryUpd.ParamByName('AUTINC').AsString := qryGen.FieldByName('AUTINC').AsString;

        For intCnt := 1 To 7 Do
        Begin
          qryUpd.ParamByName('PREVE' + IntToStr(intCnt)).AsFloat := qryGen.FieldByName('PREVE' + IntToStr(intCnt)).AsFloat *
                                                                    (1 - (qryGen.FieldByName('PERDES').AsFloat / 100));
        End;
        qryUpd.Execute;

        qryGen.Next;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryUpd);
  End;
end;

procedure TfrmCadPromocoes.pBuscaDadosCliente;
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
        cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(FieldByName('CLI_CATEGO').AsString);
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
      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

end;

function TfrmCadPromocoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMsgCli: String;
    strMsgPro: String;
    strMsgCnd: String;
    fltPrecoCalcMargem: Double;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDesPro) Then
    Begin

      If (fEmptyStr(dbeDesPro.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da promoção deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else If (Not dbeDtaIni.Enabled) Then
        pTratarBotoes();
    End
    Else If (Sender = dbeDtaInicial) And (not dbeDtaInicial.ReadOnly) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaInicial.Text)) Then
      Begin
        fMensagem('ATENÇÃO','O período inicial deve ser preenchido!',['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDtaFinal) And (not dbeDtaFinal.ReadOnly) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaFinal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O período final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(dbeDtaInicial.Text, dbeDtaFinal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O período final deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDtaIni) Then
    Begin

      If (dbeDtaIni.Enabled) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO','A data inicial deve ser preenchida!',['&OK']);
          Result := False;
        End
        Else If (qryTabela.State = dsInsert) And (StrToDate(dbeDtaIni.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO','A data inicial deve ser maior ou igual à data atual!',['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeDtaFin) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(dbeDtaIni.Text, dbeDtaFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaCampos(dbeQtdLim, True) Then
      Begin
        Result := False
      End
      Else
        pTratarBotoes();
    End

    Else If (Sender = edtCodCli) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodCli.Text)) and (Length(arrClientes) <= 1) Then
      Begin
        pBuscaDadosCliente;

        Result := fValidaCodCli(edtNomCli.Text);
      End
      else if Length(arrClientes) > 1 then
      begin
        if not fValidaArrPromocaoRestritaClientesNaoConsumidor then
        begin
          fMensagem('ATENÇÃO','Promoção restrita a clientes não consumidor!',['&O K']);
          edtCodCli.Clear ;
          edtNomCli.Clear ;
          pDesmarcaLista(edtCodCli, arrClientes);
          Result := False;
        end;
      end
      else
      begin
        pDesmarcaLista(edtCodCli, arrClientes);
      end;

      pAtivaCamposCliente;
    End

    Else If (Sender = edtCodAti) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodAti.Text)) and (Length(arrAtiv) <= 1) Then
      Begin
        edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);

        If (fEmptyStr(edtDesAti.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Esta atividade não está cadastrada!',['&O K']);
          Result := False;
        End

      End
      else
      begin
        pDesmarcaLista(edtCodAti, arrAtiv);
      end;

    End

    Else If (Sender = edtCodCid) Then
    Begin

      If blnBuscaPorChave And (Not fEmptyStr(edtCodCid.Text)) and (Length(arrCidade) <= 1) Then
      Begin
        edtDesCid.Text := fRetNomCidade(edtCodCid.Text);
        edtEstado.Text := fRetNomCidade(edtCodCid.Text,1);

        If (fEmptyStr(edtDesCid.Text)) Then
        Begin
          fMensagem('ATENÇÃO','Esta cidade não está cadastrada!',['&O K']);
          Result := False;
        End

      End
      else
      begin
        pDesmarcaLista(edtCodCid, arrCidade);
      end;

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

      If (fEmptyStr(edtCodIte.Text)) Then  // se for branco carrega todos na descricao
        edtDesIte.Text := 'TODOS'
      Else
      Begin
        If edtCodIte.Text <> strIteAtu then
          pCarregaCadIte(blnBuscaPorChave); // localiza o item

        If (qryConIte.FieldByName('ITE_CODITE').IsNull) Then // caso nao seja encontrado
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (strAltGrd = 'N') Then
        Begin
          If blnSimuladorPrecoVendaReal Then
            cxvFiltrosCodAbf.Properties.Value := qryConIte.FieldByName('ITE_CODABF').AsString;

          If (fItemCadastradoPromocao(dbeCodPro.Text,
                                      edtCodIte.Text,
                                      fGetEmpresasSelecionadas,
                                      fCodCli,
                                      fGetTabelasPrecoSelecionadas,
                                      fGetCndPag,
                                      StrToDate(dbeDtaIni.Text),
                                      StrToDate(dbeDtaFin.Text),
                                      strMsgCli,
                                      strMsgPro,
                                      strMsgCnd,
                                      chkTabloid.Checked)) Then   // verifica se já está cadastrado em outra promocao
          Begin
            Try
              pCriarFormularios(TfrmObservacao, frmObservacao);
              frmObservacao.lblMensagem.Caption := 'ATENÇÃO';

              If Not fEmptyStr(strMsgCnd) then
                frmObservacao.memObs.Texto := 'Esse item já foi incluido para o cliente e condição de pagamento: ' + Chr(13) +
                                              strMsgCli + Chr(13) +
                                              strMsgCnd + Chr(13) + Chr(13) +
                                              strEmpPro
              Else
              If Not fEmptyStr(strMsgCli) Then
                frmObservacao.memObs.Texto := 'Esse item já foi incluido para o cliente: ' + Chr(13) +
                                              strMsgCli + ' nas promoções' + fMsgTabloid() + ': ' + Chr(13) +
                                              strEmpPro
              Else
                frmObservacao.memObs.Texto := 'Esse item já está em outra promoção' + fMsgTabloid() + '!' + #10#13 + strMsgPro;

              frmObservacao.ShowModal;
            Except
              On E: Exception Do
              Begin
                pMensagensErro(E.Message, '[frmCadPromocoes.pAdicionaItem]');
              End;
            End;

            pFreeAndNil(frmObservacao);
            Result := False;
          End
          Else
          Begin

            If fItemJaCadastrado(edtCodIte.Text) Then
            Begin
              If (blnBuscaPorChave) Then
              Begin
                fMensagem('ATENÇÃO!', 'Esse item já está na promoção!', ['&Ok']);
                Result := False;
              End;
            End;

          End;

        End;

      End;

      pVisiblePanelValores(blnBuscaPorChave And Result And (not fEmptyStr(edtCodIte.Text)));
      If (Result) And (fEmptyStr(edtQtdMin.Text)) And
         (Not (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva], IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva]])) Then
        edtQtdMin.Text := '1,00';

      If (blnCalcMargemLiquida) Then
        edtMarBru.Text := edtMarg01.Text;
    End

    Else If ((Sender = edtQtdLim) Or (Sender = edtQtdMin)) And
            ((Not edtQtdLim.ReadOnly) And (Not edtQtdMin.ReadOnly)) Then
    Begin
      If (Sender = edtQtdLim) Then
      begin
        if (TTipDescPro(rdgPreDes.ItemIndex) = tdpNegociacaoEspecialFornecedorPC) then
        begin
          if Not fEmptyStr(edtCodIte.Text) then
          begin
            if fEmptyStr(strWherePedidoCompra) then
              strWherePedidoCompra := fRetornarWherePedidoCompra;

            If strToFloat(edtQtdLim.Text) >  fGetQtdLimitePedidoCompra(edtCodIte.Text) Then
            begin
              fMensagem('ATENÇÃO!', 'Quantidade limite não pode ser superior à quantidade do pedido de compra!', ['&Ok']);
              Result := False;
            end
            else
              Result := true;
          end;
        end
      end
      else
      begin
        Result := fValidaLimiteMinima(edtQtdLim, edtQtdMin, Sender);
      end;
    End

    Else If (Sender = edtCliVen) And (edtCliVen.Visible) Then
    Begin

      If (chkUtilizarLimitePorClienteOuVenda.Checked) Then
      Begin

        PromocaoUtilizaLimite := TPromocaoUtilizaLimite(rdgUtilizarLimitePorClienteOuVenda.ItemIndex);

        If (PromocaoUtilizaLimite = pulLimitarPorCliente) Then
        Begin
          If (fStrToFloat(edtCliVen.Text, 0) <= 0) Then
          Begin
            fMensagem('','Para utilizar limite por cliente, você deve informar o campo "Qtde. Limite Cliente/Venda:" com um valor positivo.',['&Ok']);
            Exit(False);
          End;
        End;

        If (qryTabela.FieldByName('PRO_QTDLIM').AsFloat > 0) Then
        Begin
          If (fStrToFloat(edtCliVen.Text, 0) > qryTabela.FieldByName('PRO_QTDLIM').AsFloat) Then
          Begin
            fMensagem('','O campo "Qtde. Limite Cliente/Venda:" não pode ser maior que o campo "Qtde.Limite:".',['&Ok']);
            Exit(False);
          End;
        End;

        If (fStrToFloat(edtQtdLim.Text) > 0 ) Then
        Begin
          If (fStrToFloat(edtCliVen.Text, 0) > fStrToFloat(edtQtdLim.Text)) Then
          Begin
            fMensagem('','O campo "Qtde. Limite Cliente/Venda:" não pode ser maior que o campo "Qtde.Limite:".',['&Ok']);
            Exit(False);
          End;
        End;

      End;

    End

    Else If (Sender = edtPreCus) And (Not edtPreCus.ReadOnly) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(edtPreCus.Text)) Then
      Begin
        If (cdsCadPro.RecordCount > 0) and
           (edtDesGrupo.Text = 'TODOS') and
           (edtDesIte.Text = 'TODOS') and
           (edtDesMarca.Text = 'TODOS') and
           (edtDesFornecedor.Text = 'TODOS') and
           (fEmptyStr(edtDescriIni.Text)) and
           (fEmptyStr(edtDescriFin.Text)) and
           (fEmptyStr(edtRefere.Text)) and
           (fEmptyStr(edtUnidade.Text)) Then
        Begin
          pTratarBotoes();
          btnCancelaItem.Click;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (fStrToFloat(edtPreCus.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de custo deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;

      pVisiblePanelValores(blnBuscaPorChave And Result And (not fEmptyStr(edtCodIte.Text)));

      If (blnCalcMargemLiquida) Then
        edtMarBru.Text := edtMarg01.Text;
    End

    Else If (Sender = edtPreVen) And (Not edtPreVen.ReadOnly) And (FLockExcel < 0) Then
    Begin
      If (fEmptyStr(edtPreVen.Text)) or (edtPreVen.Text = '0') or (edtPreVen.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtPreVen.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de venda deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(edtPreCus.Text) > fStrToFloat(edtPreVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de custo deve ser menor ou igual o preço de venda!', ['&Ok']);
        Result := False;
      End;

      pVisiblePanelValores(blnBuscaPorChave And Result And (not fEmptyStr(edtCodIte.Text)));

      If (edtMarBru.Visible) And (fStrToFloat(edtPreVen.Text) > 0) Then
      Begin
        If Not fEmptyStr(edtCodIte.Text) And (fStrToFloat(edtPreVen.Text) <> fltPreVenBKP) Then
        Begin
          If (blnCalcMargemLiquida) Then
          Begin
            edtMarBru.Text := edtMarg01.Text;
          End
          Else
          Begin
            fltPrecoCalcMargem := fRetornaValorCalculoMargem;

            edtMarBru.Text := FormatFloat(fMskDigitos(intDecUni),
                                          fCalculaPrecoVenda(2,
                                                             fltPrecoCalcMargem,
                                                             fStrToFloat(edtPreVen.Text),
                                                             0,0,0,0,0));
          End;
        End;
      End;

      fltMarBruBKP := fStrToFloat(edtMarBru.Text);

      If Result And
         blnSimuladorPrecoVendaReal Then
        pCalcularPrecoVendaReal;
    End

    Else If (Sender = edtMarBru) And (edtMarBru.Visible) And (blnBuscaPorChave) Then
    Begin
      If (blnCalcMargemLiquida) Then
        edtMarg01.Text := FormatFloat(fMskDigitos(intDecUni), fStrToFloat(edtMarBru.Text));

      pCalculaPrecoVenda;
    End

    Else If (Sender = edtPerDes) And (Not edtPerDes.ReadOnly) And (blnBuscaPorChave) Then
    Begin

      If (fEmptyStr(edtPerDes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de desconto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

      pVisiblePanelValores(blnBuscaPorChave And Result And (not fEmptyStr(edtCodIte.Text)));

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

    Else If (Sender = mskLinhaGrupo) And (fEmptyStr(edtQtdMin.Text)) And
            (Not (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva], IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva]])) Then
      edtQtdMin.Text := '1,00'

    Else If (Sender = edtUnidade) Then
    Begin
      If Not fEmptyStr(edtUnidade.Text) Then
      Begin
        If fEmptyStr(fRetNomUnidade(edtUnidade.Text)) Then
        Begin
          fMensagem('', 'Unidade Inválida!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDesAdi) And (gpbDesAdi.Enabled) Then
    Begin
      If fEmptyStr(edtDesAdi.Text) Then
        edtDesAdi.Text := '0,00';

      If fStrToFloat(edtDesAdi.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Desconto adicional sobre preço de compra" deve ser maior que zero!', ['&OK']);
        Result := False;
      End
      Else
        pCarregaCadIte(blnBuscaPorChave);
    End

    Else If (Sender = cmbTabPre) And (gpbDesAdi.Enabled) And (cmbTabPre.Enabled) Then
    Begin
      If fEmptyStr(cmbTabPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Gerar preço de venda com base na tabela" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
        pCarregaCadIte(blnBuscaPorChave);
    End

    Else If (Sender = edtPerEst) And (Not edtPerEst.ReadOnly) Then
    Begin
      If (fStrToFloat(edtPerEst.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "% Estoque Disponível que será colocado em promoção:" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (fStrToFloat(edtPerEst.Text) > 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "% Estoque Disponível que será colocado em promoção:" não pode ser maior que 100!', ['&OK']);
        Result := False;
      End

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

    Else If (Sender = edtGrupoGatilhoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If Not fEmptyStr(edtGrupoGatilhoParaKit.Text) Then
        Begin
          If fEmptyStr(fRetNomeLinhaGrupo(edtGrupoGatilhoParaKit.Text)) Then
          Begin
            fMensagem('', 'Linha/Grupo Gatilho Inválida!', ['&OK']);
            Result := False;
          End;
      End
    End

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
    End

    Else If (Sender = edtGrupoBeneficiadoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If Not fEmptyStr(edtGrupoBeneficiadoParaKit.Text) Then
        Begin
          If fEmptyStr(fRetNomeLinhaGrupo(edtGrupoBeneficiadoParaKit.Text)) Then
          Begin
            fMensagem('', 'Linha/Grupo Gatilho Inválida!', ['&OK']);
            Result := False;
          End;
        End;
    End

    Else If (Sender = edtUnidadeGatilhoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If Not fEmptyStr(edtUnidadeGatilhoParaKit.Text) Then
        Begin
          If fEmptyStr(fRetNomUnidade(edtUnidadeGatilhoParaKit.Text)) Then
          Begin
            fMensagem('', 'Unidade Gatilho Inválida!', ['&OK']);
            Result := False;
          End;
        End;
    End

    Else If (Sender = edtUnidadeBeneficiadoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If Not fEmptyStr(edtUnidadeBeneficiadoParaKit.Text) Then
        Begin
          If fEmptyStr(fRetNomUnidade(edtUnidadeBeneficiadoParaKit.Text)) Then
          Begin
            fMensagem('', 'Unidade Gatilho Inválida!', ['&OK']);
            Result := False;
          End;
        End;
    End

    Else If (Sender = edtQuantidadeGatilhoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If (fStrToFloat(edtQuantidadeGatilhoParaKit.Text) <= 0) and not(fEmptyStr(edtGrupoGatilhoParaKit.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Qtd.Mínima" do Gatilho deve ser maior que zero!', ['&OK']);
          Result := False;
        End;
    End

    Else If (Sender = edtQuantidadeBeneficiadoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If (fStrToFloat(edtQuantidadeBeneficiadoParaKit.Text) <= 0) and not(fEmptyStr(edtGrupoBeneficiadoParaKit.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Qtd.Mínima" do Beneficiado deve ser maior que zero!', ['&OK']);
          Result := False;
        End;
    End

    Else If (Sender = edtQuantidadeBrindeParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If (fStrToFloat(edtQuantidadeBrindeParaKit.Text) <= 0) and not(fEmptyStr(edtBrindeParaKit.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Quantidade" do brinde deve ser maior que zero!', ['&OK']);
          Result := False;
        End;
    End

    Else If (Sender = edtPercentualDescontoGatilhoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If (fStrToFloat(edtPercentualDescontoGatilhoParaKit.Text) > 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "% Desconto" do Gatilho não pode ser maior que 100!', ['&OK']);
          Result := False;
        End;
    End

    Else If (Sender = edtPercentualDescontoBeneficiadoParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If (fStrToFloat(edtPercentualDescontoBeneficiadoParaKit.Text) > 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "% Desconto" do Gatilho não pode ser maior que 100!', ['&OK']);
          Result := False;
        End;
    End

    Else If (Sender = edtBrindeParaKit) Then
    Begin
      if (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) then
        If Not fEmptyStr(edtBrindeParaKit.Text) Then
        Begin
          If fEmptyStr(fRetNomProduto(edtBrindeParaKit.Text)) Then
          Begin
            fMensagem('', 'Brinde Inválido!', ['&OK']);
            Result := False;
          End;
        End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadPromocoes.fValidaCamposPromocaoValorMinimo: Boolean;
begin
  If (fCfgSis('UTIVMP', varBoolean)) And
     (opcTipDes in [tdpPrecoPorVlrMinProd, tdpDescPorVlrMinProd]) Then
  Begin
    If rdgConsideraVlrMin.ItemIndex < 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Selecione uma opção para a ativação da promoção', ['&OK']);
      pSetFocus(rdgConsideraVlrMin);
      Result := False;
    End
    Else
      Exit(True);
  End
  Else
    Exit(True);
end;

function TfrmCadPromocoes.fValidaCndPag: Boolean;
begin
  Result := False;

  if (Not fValidaCampos(edtCodCnd, True)) then
    Exit;
  if (Not fValidaCampos(edtJurRem, True)) then
    Exit;

  Result := True;
end;

function TfrmCadPromocoes.fValidaCodCli(strNomCli: String): Boolean;
begin
  Result := True;
  If (fEmptyStr(strNomCli)) Then
  Begin
    fMensagem('ATENÇÃO','Este cliente não está cadastrado!',['&O K']);
    Result := False;
  End
  Else If chkPromocaoRestritaClientesNaoConsumidor.Checked And
     fClienteConsumidor(strNomCli, True, True) Then
  Begin
    fMensagem('ATENÇÃO','Promoção restrita a clientes não consumidor!',['&O K']);
    Result := False;
  End;
end;

function TfrmCadPromocoes.fValidaLimiteMinima(edtLim,
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
end;

procedure TfrmCadPromocoes.pEnabledEdit(Edit: TCustomEdit);
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

procedure TfrmCadPromocoes.pEnableDisableBtnAtuEmLote(blnHabil: Boolean);
begin
  btnAtuPerVrl.Caption:='Digitar '+IfThen(opcTipDes=tdpPrecos,'Pr. Venda','%Desconto')+' para Todos os Produtos';
  btnAtuCom.Visible    := blnHabil;
  btnDigAtu.Visible    := blnHabil;
  btnMargemProdutos.Visible := (blnHabil)And (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos]);
  btnAtuPerVrl.Visible := blnHabil And
                            (Not fEhPromocaoPorQuantidadeMinimaEscalonada) And
                            (Not (edtPreVen.ReadOnly And edtPerDes.ReadOnly));
end;

procedure TfrmCadPromocoes.pEscapePressed;
begin
  If (pgcDados.ActivePage = tbsItens) And (btnConfirmar.Tag > 0) Then
    btnCancelaItem.Click()
  Else
    inherited;
end;

procedure TfrmCadPromocoes.pEscondeColunasTab(intTabPre: Integer);
  Var
    blnDesc: Boolean;
begin

  blnDesc := (opcTipDes In [tdpDescon,
                            tdpPercentualPorQuantidadeMinimaEscalonada,
                            tdpPorcentoDescontoComDescontoAdicional,
                            tdpPorcentoDescontoQuantidadeColetiva,
                            tdpNegociacaoEspecialFornecedorPC]);

  cxgItensIPR_PERDES.Visible := blnDesc And (Not (opcTipDes = tdpNegociacaoEspecialFornecedorPC));

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

procedure TfrmCadPromocoes.pExcluirTodosClientes;
begin
  If Not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If cdsProCli.IsEmpty Then
    Exit;

  If Not fPergunta('Esse procedimento irá remover todos os clientes da promoção hoje cadastrado. Deseja continuar?') Then
  Begin
    ckbTipoCliente.Checked := False;
    rdgTipoCliente.Enabled := False;
    rdgTipoCliente.ItemIndex := -1;
    btnIncCli.Enabled := True;
    Exit;
  End;

  cdsProCli.EmptyDataSet;
end;

procedure TfrmCadPromocoes.pFormataCampos;
begin

  With FObjKitPromocaoBuilder.CdsProdutoGatilho Do
  Begin
    TFloatField(FieldByName('DET_QTDGRU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('DET_PERDES')).DisplayFormat := '#,##0.00';
  End;

  With FObjKitPromocaoBuilder.CdsProdutoBeneficiado Do
  Begin
    TFloatField(FieldByName('DET_QTDGRU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('DET_PERDES')).DisplayFormat := '#,##0.00';
  End;

  With FObjKitPromocaoBuilder.CdsBrinde Do
  Begin
    TFloatField(FieldByName('BRI_QTDBRI')).DisplayFormat := '#,##0.00';
  End;

end;

procedure TfrmCadPromocoes.pgcDadosChange(Sender: TObject);
begin
  inherited;
  If pgcDados.ActivePageIndex = 1 Then
  Begin

    btnInsPla.Visible := opcTipDes In [tdpPrecos,
                                       tdpDescon,
                                       tdpPorcentoDescontoComDescontoAdicional,
                                       tdpPrecoPorQuantidadeMinimaEscalonada,
                                       tdpPercentualPorQuantidadeMinimaEscalonada,
                                       tdpPrecoPorVlrMinProd];

    btnInsPlaHelp.Visible := btnInsPla.Visible;
    If blnImpPC Then
      pSetFocus(edtComVar)
    Else If blnPreAlt Then
      pSetFocus(dbeDtaInicial)
    Else
      pSetFocus(mskLinhaGrupo);
  End;
  If (pgcDados.ActivePageIndex = 2) And (blnEcomme) And (qryTabela.state in [dsEdit,dsInsert]) Then
  Begin
     fMensagem('','Opção não habilitada para e-commerce.', ['&Ok']);
  End;
end;

procedure TfrmCadPromocoes.btnImportarClientesDaPromocaoClick(Sender: TObject);
  var
    frmImportacaoClientesDaPromocao: TfrmImportacaoClientesDaPromocao;

  procedure pCarregaImportadosParaArray;
  begin

    FillChar(arrClientes, SizeOf(arrClientes), #0);

    frmImportacaoClientesDaPromocao.cdsCliTmp.First;
    While Not frmImportacaoClientesDaPromocao.cdsCliTmp.Eof Do
    Begin
      SetLength(arrClientes, Length(arrClientes) +1);
      arrClientes[High(arrClientes)].strCodigo := frmImportacaoClientesDaPromocao.cdsCliTmpCODCLI.AsString;
      arrClientes[High(arrClientes)].strDescri := frmImportacaoClientesDaPromocao.cdsCliTmpNOMCLI.AsString;;
      frmImportacaoClientesDaPromocao.cdsCliTmp.Next;
    End;

    edtCodCli.Text := '+1';

  end;

begin

  inherited;

  If Not fValidaCampos(edtCodCli, True) then
  Begin
    btnCancelCli.Click;
    Exit;
  End;

  pCriarFormularios(TfrmImportacaoClientesDaPromocao, frmImportacaoClientesDaPromocao);

  Try

    If (frmImportacaoClientesDaPromocao.ShowModal <> mrOk) Then
      Exit;

    If (frmImportacaoClientesDaPromocao.stlClientesInexistentes.Count > 0) Then
    Begin
      pMostraObservacaoCliente(frmImportacaoClientesDaPromocao.stlClientesInexistentes.CommaText, True);
      If frmImportacaoClientesDaPromocao.cdsCliTmp.IsEmpty Then
        Exit;
    End;

    If frmImportacaoClientesDaPromocao.cdsCliTmp.IsEmpty Then
    Begin
      fMensagem('','Nenhum cliente foi importado!',['&Ok'],0);
      Exit;
    End;

    pCarregaImportadosParaArray;
    qryClientesDaPromocao := fGetClientes;

    Try
      pInsereCliente;
    Finally
      FreeAndNil(qryClientesDaPromocao);
      edtCodCli.Clear;
    End;

  Finally
    pFreeAndNil(frmImportacaoClientesDaPromocao);
  End;

end;

procedure TfrmCadPromocoes.btnImportarItensPedidoCompraClick(Sender: TObject);
  Var
    frmDigPedCompraPromocao: TfrmDigPedCompraPromocao;
begin
  inherited;

  If (Not btnImportarItensPedidoCompra.Enabled) Then
    Exit;

  pCriarFormularios(TfrmDigPedCompraPromocao, frmDigPedCompraPromocao);

  Try
    frmDigPedCompraPromocao.stlPedidos := stlPedidosCompra;
    stlPedidosCompra.Clear();

    frmDigPedCompraPromocao.ShowModal;
    If frmDigPedCompraPromocao.blnConfirma Then
    Begin
      stlPedidosCompra.Text := frmDigPedCompraPromocao.stlPedidos.Text;
      btnConfirmar.Click();
    End;
  Finally
    FreeAndNil(frmDigPedCompraPromocao);
  End;
end;

procedure TfrmCadPromocoes.btnIncCliClick(Sender: TObject);
begin

  inherited;

  If Not fValidaCampos(edtCodCli, True) then
  Begin
    btnCancelCli.Click;
    Exit;
  End;

  If Not fAlgumFiltroDeClienteFoiInformado Then
  Begin
    fMensagem('ATENÇÃO', 'Defina pelo menos uma pesquisa para inserir os clientes que irão fazer parte desta promoção!', ['&Ok']);
    Exit;
  End;

  qryClientesDaPromocao := fGetClientes;

  Try

    If qryClientesDaPromocao.IsEmpty Then
    Begin
      fMensagem('','Nenhum cliente foi encontrado!',['&Ok'],0);
      Exit;
    End;

    pInsereCliente;

  Finally
    FreeAndNil(qryClientesDaPromocao);
  End;

end;

procedure TfrmCadPromocoes.btnIncCndPagClick(Sender: TObject);
begin
  inherited;
  pAdicionaCondicao;
end;

procedure TfrmCadPromocoes.btnIncluirClick(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;

  if not(fCfgSis('PROKIT', VarBoolean)) then
    rdgPreDes.Controls[IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]].Enabled := False;

  pCriarProLog;

  pControlaPrecoDesconto(tdpPrecos);

  pgcDados.ActivePageIndex := 0;

  cdsCndPag.EmptyDataSet;
  cdsPCMPRO.EmptyDataSet();

  fCarregaPromocao('');
  pCarregaClientesPromocao('');

  pHabilitaCodigo(dbeCodPro, dbeDesPro, False);

  rdgProPre.DataBinding.Field.AsString := fCfgSis('PROPRE');

  pDeletaTemporaria;

  edtNomCli.Clear;

  rdgPreDes.Enabled  := True;
  rdgPreDes.ItemIndex := 0;
  pTrataCheckboxEstoqueRemanescente(TTipDescPro(rdgPreDes.ItemIndex));

  rdgComPro.Enabled  := True;
  rdgComPro.ItemIndex := 0;
  rdgQtdLim.Enabled   := True;
  rdgQtdLim.ItemIndex := 0;

  edtJurRem.Text := 'S';

  chkEntIme.Checked  := True;
  chkEntFut.Checked  := True;
  chkAguCli.Checked  := True;
  chkPrevis.Checked  := True;
  chkFalPro.Checked  := True;
  chkEcommerce.Checked := False;

  chkUtilizarLimitePorClienteOuVenda.Checked   := False;
  chkUtilizarLimitePorClienteOuVendaClick(chkUtilizarLimitePorClienteOuVenda);
  rdgUtilizarLimitePorClienteOuVenda.ItemIndex := -1;

  chkPromocaoRestritaClientesNaoConsumidor.Field.AsString := 'N';
  chkTabloid.Field.AsString := 'N';
  chkTraPro.Field.AsString := 'S';

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

  edtMarBru.Text := FloatToStrF(0, ffFixed, 12, intDecUni);
  ckbPrecoFixoParaTmqImo.Checked := False;
  btnHeranca.Enabled := True;
  pEnableDisableBtnAtuEmLote(False);
  pVisiblePanelValores(False);
  chkTabloidClick(nil);
  pSetEnabledCliente;
  pTratarBotoes();

  pLimparFiltrosPrecoVendaReal;
end;

procedure TfrmCadPromocoes.btnIncluirTodasCndPagClick(Sender: TObject);
var
  qryGen: TUniQuery;
begin
  inherited;
  if not fPergunta('Deseja incluir todas as condições de pagamento na promoção?') then
    Exit;

  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('SELECT CND_CODIGO, CND_CNDPAG, CND_DESCRI FROM CADCND');
    qryGen.Open;
    cdsCndPag.DisableControls;
    try
      while not qryGen.Eof do
      begin
        if not cdsCndPag.Locate('CODCND', qryGen.FieldByName('CND_CODIGO').AsString, []) then
        begin
          cdsCndPag.Append;
          cdsCndPag.FieldByName('CODCND').AsString := qryGen.FieldByName('CND_CODIGO').AsString;
          cdsCndPag.FieldByName('DESCND').AsString := qryGen.FieldByName('CND_DESCRI').AsString;
          cdsCndPag.FieldByName('CNDPAG').AsString := fFormataCondPag(qryGen.FieldByName('CND_CNDPAG').AsString);
          cdsCndPag.FieldByName('JURREM').AsString := 'S';
          cdsCndPag.Post;
        end;

        qryGen.Next;
      end;
    finally
      cdsCndPag.EnableControls;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

{*
  12/10/2019 Req: 145933

 - O ARQUIVO TERA SEGUINTE LAYOUT:
   ------------------------------------------------------------------------------------------------------------------------------
   --> COLUNA A: CODITE                                               (OBRIGATORIO)
   --> COLUNA B: DESITE
   --> COLUNA C: TIPO TRAVA QUANTIDADE (L-QTD LIMITE // M-QTD MINIMA) (OBRIGATORIO)
   --> COLUNA D: QUANTIDADE PARA TRAVA                                (OBRIGATORIO)
   --> COLUNA E: PRECO CUSTO                                          (>= 0)
   --> COLUNA F: PRECO DE VENDA                                       (OBRIGATORIO CASO OPCAO DE PROMOCAO POR "PRECO")
   --> COLUNA G: % DE DESCONTO                                        (OBRIGATORIO CASO OPCAO DE PROMOCAO POR "%DESCONTO")
   --> COLUNA H: %COMISS.VEND.INTERNO                                 (CASO BRANCO/ZERO SEGUIR CONFORME OPCAO DEFINIDA PELO OPERADOR NA PERGUNTA APRESENTADA)
   --> COLUNA I: %COMISS.REPRES.EXT.LOJA                              (CASO BRANCO/ZERO SEGUIR CONFORME OPCAO DEFINIDA PELO OPERADOR NA PERGUNTA APRESENTADA)
   --> COLUNA J: %COMISS.REPRES.EXT.DISTRIB                           (CASO BRANCO/ZERO SEGUIR CONFORME OPCAO DEFINIDA PELO OPERADOR NA PERGUNTA APRESENTADA)
   --> COLUNA K: PRAZO MEDIO                                          (CASO BRANCO CONSIDERAR 0)
   ------------------------------------------------------------------------------------------------------------------------------
*}
function TfrmCadPromocoes.fInsereItensExcel(pgbStatus: TcxProgressBar = Nil): Boolean;
Var
  stlLog     : TStringList;
  Excel      : TExcel;
  intCont    : Integer;
  intUltLinha: Integer;
  blnComissaoCadastro: Boolean;
  blnValidouMargemLiq: Boolean;
  strCodItePro: String;
  fltPrecoVenda: Double;
  fltMargemLiq_: Double;
  blnQtdMinEscalonada: Boolean;
  strCelQtdMin: String;
  LQuantidadeItensSemCodigo: Integer;
  LPodeInterromperProcesso: Boolean;
  prcScroll: TprcScroll;

  function fTrataValor(strValor: String): String;
  begin
    Result := AnsiReplaceStr(strValor, '.', ',');
  end;

  function fRemoveAspas(strValor: String): String;
  begin
    Result := AnsiReplaceStr(strValor, '''', '');
  end;

  function fCapturaValor(strCelula: String; intCont: Integer): Double;
  begin
    Result := StrToFloatDef(fTrataValor(Excel.Ler_Celula(strCelula + IntToStr(intCont))), -1);
  end;

begin
  Result := False;

  LQuantidadeItensSemCodigo := 0;
  LPodeInterromperProcesso := True;

  If InterlockedIncrement(FLockExcel) <> 0 Then
  Begin
    InterlockedDecrement(FLockExcel);
    Exit;
  End;

  blnValidouMargemLiq := False;

  blnComissaoCadastro := fPergunta('Caso na planilha os produtos estejam '+
    'com o percentual de comissão zerados, considerar a comissão do cadastro '+
    'de produtos?');

  pDisableControls(cdsCadPro, prcScroll);

  Try
    pInformacao('Aguarde... Inserindo Produtos.', pgbStatus);

    stlLog := TStringList.Create;
    Excel  := TExcel.fCriarExcel(Nil);
    Excel.AbrirArquivo(FArquivoExcel);
    intUltLinha := Excel.MaximodeLinhas;

    For intCont := 1 To intUltLinha Do
    Begin
      Application.ProcessMessages;

      pProgresso(intCont, intUltLinha, pgbStatus);

      btnCancelaItem.Click;

      If fEmptyStr(Excel.Ler_Celula('A' + IntToStr(intCont))) Then
      Begin
        stlLog.Add('Célula [A' + intCont.ToString() + ']: Código do produto é obrigatório.');
        Inc(LQuantidadeItensSemCodigo);

        If (LQuantidadeItensSemCodigo >= 30) And (LPodeInterromperProcesso) Then
        Begin
          If fMensagem('','Existem muitos registros sem código de produto, deseja interromper o processo e revisar o arquivo?', ['','']) = 1 Then
          Begin
            btnCancelaItem.Click;
            Break;
          End
          Else
            LPodeInterromperProcesso := False;
        End;

        Continue;
      End;

      strCodItePro := fStrZero(fRemoveAspas(Excel.Ler_Celula('A' + IntToStr(intCont))), fTamCodIte);
      strAltGrd := 'N';
      blnQtdMinEscalonada := fEhPromocaoPorQuantidadeMinimaEscalonada;
      strCelQtdMin := fRemoveAspas(Excel.Ler_Celula('D' + IntToStr(intCont)));

      If (blnQtdMinEscalonada) Then
      Begin
        If (Not fValidaQuantidadeMinima(strCodItePro, StrToFloatDef(strCelQtdMin, -1))) Then
        Begin
          stlLog.Add('Célula [D' + intCont.ToString() + ']: Produto já inserido na promoção com a '+
                     'quantidade mínima informada. ' + stlItensQuantidadeMinimaDuplicado.Text + '".');
          Continue;
        End;
      End;

      If (Not blnQtdMinEscalonada) And (cdsCadPro.Locate('IPR_CODITE', strCodItePro, [])) Then
      Begin
        btnCancelaItem.Click;
        pCarregaItemAlteracao;
        strAltGrd := 'S';
      End
      Else
      Begin
        edtCodIte.Text := strCodItePro;
        pCarregaCadIte(True);
      End;

      If fEmptyStr(edtDesIte.Text) Then
      Begin
        stlLog.Add('Célula [A' + intCont.ToString() + ']: Produto não encontrado com o código "' + edtCodIte.Text + '".');
        Continue;
      End;

      If (StrToFloatDef(fTrataValor(Excel.Ler_Celula('C' + IntToStr(intCont))), -1) = 0) and
         (StrToFloatDef(fTrataValor(Excel.Ler_Celula('D' + IntToStr(intCont))), -1) = 0) Then
      Begin
         stlLog.Add('Célula [C' + intCont.ToString() + '] e Célula [D' + intCont.ToString() + ']: Informe a quantidade limite (célula C) e/ou quantidade minima (coluna D) da promoção.');
         Continue;
      End;

      If StrToFloatDef(fTrataValor(fRemoveAspas(Excel.Ler_Celula('C' + IntToStr(intCont)))), -1) > 0 Then
          edtQtdLim.Text := fTrataValor(fRemoveAspas(Excel.Ler_Celula('C' + IntToStr(intCont))));

      If StrToFloatDef(fTrataValor(strCelQtdMin), -1) > 0 Then
          edtQtdMin.Text := fTrataValor(strCelQtdMin);

      If StrToFloatDef(fTrataValor(Excel.Ler_Celula('E' + IntToStr(intCont))), -1) > 0 Then
        edtPreCus.Text := fTrataValor(Excel.Ler_Celula('E' + IntToStr(intCont)))
      Else
        edtPreCus.Text := '0,00';

      fltPrecoVenda := fCapturaValor('F', intCont);
      fltMargemLiq_ := fCapturaValor('L', intCont);

      blnCalcMargemLiquida := (fltMargemLiq_ > 0);

      If (Not fPreenchePrecoDeVenda(fltPrecoVenda, fltMargemLiq_)) Then
      Begin
        stlLog.Add('Célula F (Preço de Venda) ou Célula L (Margem Líquida) '+
                   'devem ser informadas para este tipo de promoção.');
        Continue;
      End;

      If (Not blnValidouMargemLiq) And (fValidaInclusaoProdutosMargemLiquida(fltPrecoVenda, fltMargemLiq_)) Then
      Begin
        blnValidouMargemLiq := True;
        If fMensagem('ATENÇÃO', 'Serão inseridos múltiplos produtos, porém foi informado ''PREÇO VENDA'' e ''MARGEM LÍQUIDA'', '+
                                'irá prevalecer o ''PREÇO VENDA''. Deseja continuar?', ['&Sim', '&Não']) = 2 Then
        Begin
          btnCancelaItem.Click;
          Break;
        End;
      End;

      If opcTipDes In [tdpDescon,
                       tdpPorcentoDescontoComDescontoAdicional,
                       tdpPercentualPorQuantidadeMinimaEscalonada] Then
      Begin
        If StrToFloatDef(fTrataValor(Excel.Ler_Celula('G' + IntToStr(intCont))), -1) > 0 Then
        Begin
          If (opcTipDes = tdpDescon) Or (opcTipDes = tdpPercentualPorQuantidadeMinimaEscalonada) Then
            edtPerDes.Text := fTrataValor(Excel.Ler_Celula('G' + IntToStr(intCont)))
          Else If gpbDesAdi.Enabled Then
            edtDesAdi.Text := fTrataValor(Excel.Ler_Celula('G' + IntToStr(intCont)))
        End
        Else
        Begin
          stlLog.Add('Célula [G' + intCont.ToString() + ']: % de Desconto é obrigatório neste tipo de promoção.');
          Continue;
        End;
      End;

      If StrToFloatDef(fTrataValor(Excel.Ler_Celula('H' + IntToStr(intCont))), -1) > 0 Then
        edtComVar.Text := fTrataValor(Excel.Ler_Celula('H' + IntToStr(intCont)))
      Else If Not blnComissaoCadastro Then
        edtComVar.Text := '0,00';

      If StrToFloatDef(fTrataValor(Excel.Ler_Celula('I' + IntToStr(intCont))), -1) > 0 Then
        edtComAta.Text := fTrataValor(Excel.Ler_Celula('I' + IntToStr(intCont)))
      Else If Not blnComissaoCadastro Then
        edtComAta.Text := '0,00';

      If StrToFloatDef(fTrataValor(Excel.Ler_Celula('J' + IntToStr(intCont))), -1) > 0 Then
        edtComDis.Text := fTrataValor(Excel.Ler_Celula('J' + IntToStr(intCont)))
      Else If Not blnComissaoCadastro Then
        edtComDis.Text := '0,00';

      If StrToFloatDef(fTrataValor(Excel.Ler_Celula('K' + IntToStr(intCont))), 0) >= 0 Then
        edtPrzMed.Text := fTrataValor(Excel.Ler_Celula('K' + IntToStr(intCont)));

      btnConfirmar.Click;

      If Not FInseriuItem Then
      Begin
        If fMensagem('','O item anterior não foi inserido, deseja continuar?', ['','']) = 2 Then
        Begin
          btnCancelaItem.Click;
          Break;
        End;
      End;

      Application.ProcessMessages;


    End;

    Excel.FecharArquivo;

    If stlLog.Count > 0 Then
      TfrmMemo.pShowMessage(stlLog.Text);

    Result := True;

    pEnableControls(cdsCadPro, prcScroll);
    cxgItens.Refresh;

  Finally
    InterlockedDecrement(FLockExcel);

    If Assigned(Excel) Then
      FreeAndNil(Excel);

    If Assigned(stlLog) Then
      FreeAndNil(stlLog);
  End;

end;

function TfrmCadPromocoes.fInserirItem: Boolean;
begin
  Result := True;

  if (not fEmptyStr(edtCodIte.Text)) then
    Exit;

  if (qryTabela.State <> dsEdit) then
    Exit;

  Result := (fMensagem('','Não foi selecionado nenhum item para alteração de valores, será ' +
                          'carregado todos os itens. Deseja continuar?',['&Sim', '&Não'], 2) = 1);
end;

procedure TfrmCadPromocoes.btnInsPlaClick(Sender: TObject);
begin
  inherited;
  If Not btnInsPla.Visible Then
    Exit;

  If Not OpenFile.Execute Then
    Exit;

  FArquivoExcel := OpenFile.FileName;

  If Not fEmptyStr(FArquivoExcel) Then
    fChamaTelaGravando(fInsereItensExcel);
end;

procedure TfrmCadPromocoes.btnInsPlaHelpClick(Sender: TObject);
  Var
    frmAjudaPorAbas : TfrmAjudaPorAbas;
begin
  inherited;

  If Not btnInsPlaHelp.Visible Then
    Exit;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Ajuda';
    frmAjudaPorAbas.fAddPagina().
      fSetaFonteLinhas('Courier new', 8).
      fSetaTituloGuia('Layout de Arquivo').
      fSetaTituloPagina('Importar de Planilha (*.xls | *.xlsx)').
      fAddLinhaTexto('COLUNA A: Código do produto                                    (Obrigatório)').
      fAddLinhaTexto('COLUNA B: Descrição do produto').
      fAddLinhaTexto('COLUNA C: Quantidade Limite').
      fAddLinhaTexto('COLUNA D: Quantidade Mínima                                    (Obrigatório se não informado a quantidade limite)').
      fAddLinhaTexto('COLUNA E: Preço de custo                                       (Obrigatório '+
                     'caso opção de promoção por "preço" - caso 0, irá considerar preço de custo do cadastro de produtos)').
      fAddLinhaTexto('COLUNA F: Preço de venda                                       (Obrigatório '+
                     'caso opção de promoção seja por "preço" e coluna L - "Margem Líquida" esteja em branco, ou por "% desconto")').
      fAddLinhaTexto('COLUNA G: % de desconto                                        (Obrigatório '+
                     'caso opção de promoção por "% desconto")').
      fAddLinhaTexto('COLUNA H: % Comiss.Venda.Interno                               (caso branco/'+
                     'zero seguir conforme opção definida pelo operador na pergunta apresentada)').
      fAddLinhaTexto('COLUNA I: % Comiss.Repre.Ext.Loja                              (caso branco/'+
                     'zero seguir conforme opção definida pelo operador na pergunta apresentada)').
      fAddLinhaTexto('COLUNA J: % Comiss.Repre.Ext.Distrib.                          (caso branco/'+
                     'zero seguir conforme opção definida pelo operador na pergunta apresentada)').
      fAddLinhaTexto('COLUNA K: Prazo médio                                          (caso branco '+
                     'considerar 0)').
      fAddLinhaTexto('COLUNA L: Margem Líquida                                       (Obrigatório '+
                     'caso opção de promoção seja por "preço" e coluna F - "Preço de venda" esteja em branco)');

    frmAjudaPorAbas.ShowModal;
  Finally
    FreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadPromocoes.btnMargemProdutosClick(Sender: TObject);
  Var
    frmAltFatorDescItemPromocao : TfrmAltFatorDescItemPromocao;
begin
  inherited;

  Try
    pCriarFormularios(TfrmAltFatorDescItemPromocao, frmAltFatorDescItemPromocao);

    frmAltFatorDescItemPromocao.opcTipDes := Self.opcTipDes;
    frmAltFatorDescItemPromocao.blnAlteraPelaMargemBruta := True;
    frmAltFatorDescItemPromocao.blnCalcMargemLiquida := blnCalcMargemLiquida;
    frmAltFatorDescItemPromocao.strSelect := AnsiReplaceStr(qryCadPro.SQL.Text, ':CODPRO', QuotedStr(qryCadPro.ParamByName('CODPRO').Text));
    If blnCalcMargemLiquida Then
      frmAltFatorDescItemPromocao.frmCadPromocoes := Self;
    frmAltFatorDescItemPromocao.ShowModal;
    If frmAltFatorDescItemPromocao.ModalResult = mrOk Then
    Begin
      pCloneDataSet(cdsAuxItePro, frmAltFatorDescItemPromocao.cdsCadPro);
      pAjustaValoresPromocao;
    End;

  Finally
    pFreeAndNil(frmAltFatorDescItemPromocao);
  End;

end;

procedure TfrmCadPromocoes.btnCancelCliClick(Sender: TObject);
Var
  intContador : Integer;
begin
  inherited;

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

  pAtivaCamposCliente;
  cbxCategoria.ItemIndex := cbxCategoria.Items.IndexOf(' ');
end;

procedure TfrmCadPromocoes.btnCancelCndPagClick(Sender: TObject);
begin
  inherited;
  btnIncCndPag.Tag := 0;
  edtCodCnd.Enabled := True;
  edtCodCnd.Clear;
  edtDesCnd.Clear;
  edtJurRem.Text := 'S';
  pSetFocus(edtCodCnd);
end;

procedure TfrmCadPromocoes.btnAdicionarKitClick(Sender: TObject);
  var
    LMensagem : String;
begin
  inherited;

  if fEmptystr(edtDescricaoKit.Text) then
  Begin
    fMensagem('Atenção', 'Favor preencher a descrição do Kit!', ['&Ok']);
    Exit;
  End;

  FObjKitPromocaoBuilder.DescricaoKit := edtDescricaoKit.Text;
  if not FObjKitPromocaoBuilder.fAdicionarKit(LMensagem) then
  Begin
    fMensagem('Atenção', LMensagem, ['&Ok']);
    Exit;
  End;

  edtDescricaoKit.Text := '';
end;

procedure TfrmCadPromocoes.btnSimularClick(Sender: TObject);
begin
  inherited;
  pCalcularPrecoVendaReal;
end;

procedure TfrmCadPromocoes.btnAdicionarGatilhoClick(Sender: TObject);
  var
    LMensagem : String;
    LIdx      : Integer;
begin
  inherited;

  for LIdx := 1 to 2 do
  Begin
    FblnProdutosAdicionados := False;

    if LIdx = 1 then
    Begin
      If fEmptyStr(edtGrupoGatilhoParaKit.Text) then
        Continue
      Else
      Begin
        If fEmptyStr(edtUnidadeGatilhoParaKit.Text) then
        Begin
          fMensagem('Atenção', 'Favor informar a unidade do produto gatilho', ['&Ok']);
          Exit;
        End
        Else
        If fStrToFloat(edtQuantidadeGatilhoParaKit.Text, 0) = 0 then
        Begin
          fMensagem('Atenção', 'Favor informar a quantidade do produto gatilho', ['&Ok']);
          Exit;
        End;
      End
    End
    Else
    Begin
      If fEmptyStr(edtGrupoBeneficiadoParaKit.Text) then
        Continue
      Else
      If fEmptyStr(edtUnidadeBeneficiadoParaKit.Text) then
      Begin
        fMensagem('Atenção', 'Favor informar a unidade do produto beneficiado', ['&Ok']);
        Exit;
      End
      Else
      If fStrToFloat(edtQuantidadeBeneficiadoParaKit.Text, 0) = 0 then
      Begin
        fMensagem('Atenção', 'Favor informar a quantidade do produto beneficiado', ['&Ok']);
        Exit;
      End;
    End;

    FObjKitPromocaoBuilder.Grupo          := IIF(LIdx = 1, edtGrupoGatilhoParaKit.Text,
                                                           edtGrupoBeneficiadoParaKit.Text);
    FObjKitPromocaoBuilder.UnidadeMedida  := IIF(LIdx = 1, edtUnidadeGatilhoParaKit.Text,
                                                           edtUnidadeBeneficiadoParaKit.Text);
    FObjKitPromocaoBuilder.Quantidade     := IIF(LIdx = 1, fStrToFloat(edtQuantidadeGatilhoParaKit.Text),
                                                           fStrToFloat(edtQuantidadeBeneficiadoParaKit.Text));
    FObjKitPromocaoBuilder.Desconto       := IIF(LIdx = 1, fStrToFloat(edtPercentualDescontoGatilhoParaKit.Text),
                                                           fStrToFloat(edtPercentualDescontoBeneficiadoParaKit.Text));
    FObjKitPromocaoBuilder.TipoProduto    := IIF(LIdx = 1, ttpGatilho, ttpBeneficiado);
    FObjKitPromocaoBuilder.DescricaoGrupo := IIF(LIdx = 1, edtGrupoGatilhoDescParaKit.Text,
                                                           edtGrupoBeneficiadoDescParaKit.Text);
    if not FObjKitPromocaoBuilder.fAdicionarProdutos(FstrUltimoIDKitGerado, LMensagem) then
    Begin
      fMensagem('Atenção', LMensagem, ['&Ok']);
      Continue;
    End;

    Try
      FProdutoAdicionado := FObjKitPromocaoBuilder.TipoProduto;
      mskLinhaGrupo.Text := FObjKitPromocaoBuilder.Grupo;
      edtUnidade.Text    := FObjKitPromocaoBuilder.UnidadeMedida;
      edtPerDes.Text     := FloatToStr(FObjKitPromocaoBuilder.Desconto);
      edtQtdMin.Text     := FloatToStr(FObjKitPromocaoBuilder.Quantidade);
      if fStrToFloat(edtQtdMin.Text, 0) = 0 then
        edtQtdMin.Text := '1';

      btnConfirmarClick(btnConfirmar);
      If (FInseriuItem) and (FblnProdutosAdicionados) Then
      Begin
        if LIdx = 1 then
        Begin
          edtGrupoGatilhoParaKit.Text                  := '';
          edtUnidadeGatilhoParaKit.Text                := '';
          edtQuantidadeGatilhoParaKit.Text             := '';
          edtPercentualDescontoGatilhoParaKit.Text     := '';
          edtGrupoGatilhoDescParaKit.Text              := '';
        End
        Else
        Begin
          edtGrupoBeneficiadoParaKit.Text              := '';
          edtUnidadeBeneficiadoParaKit.Text            := '';
          edtPercentualDescontoBeneficiadoParaKit.Text := '';
          edtQuantidadeBeneficiadoParaKit.Text         := '';
          edtGrupoBeneficiadoDescParaKit.Text          := '';
        End;
      End
      Else
      Begin
        fMensagem('Atenção', 'Ocorreu problemas ao adicionar os itens pertinentes aos filtros de linha/grupo '+
        IIF(LIdx = 1,'Gatilho','Beneficiado')+'.', ['&Ok']);
        FObjKitPromocaoBuilder.pApagarKitDetalhes(FstrUltimoIDKitGerado, IIF(LIdx = 1, ttpGatilho, ttpBeneficiado), cdsCadPro);
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  End;

  if not fEmptyStr(edtBrindeParaKit.Text) then
  Begin
    if not fCfgSis('USABRI', varBoolean) then
    Begin
      fMensagem('Atenção', 'Não é permitido informar brindes nesta promoção porque a configuração '+
      '"CFG_USABRI - Permitir informar produtos Brinde nos Pedidos de Venda ?" está desativada. '+
      'Ative para conseguir incluir brindes no Kit.', ['&Ok']);
    End
    Else
    Begin
      FObjKitPromocaoBuilder.CodigoBrinde     := edtBrindeParaKit.Text;
      FObjKitPromocaoBuilder.DescricaoBrinde  := edtBrindeDescParaKit.Text;
      FObjKitPromocaoBuilder.QuantidadeBrinde := fStrToFloat(edtQuantidadeBrindeParaKit.Text, 0);
      if not FObjKitPromocaoBuilder.fAdicionarBrinde(LMensagem) then
      Begin
        fMensagem('Atenção', LMensagem, ['&Ok']);
      End
      Else
      Begin
        edtBrindeParaKit.Text           := '';
        edtBrindeDescParaKit.Text       := '';
        edtQuantidadeBrindeParaKit.Text := '';
      End;
    End;
  End;

  FObjKitPromocaoBuilder.pLimparBuilder;
  pSetFocus(edtGrupoGatilhoParaKit);
end;

procedure TfrmCadPromocoes.btnAlterarClick(Sender: TObject);
begin
  If (Not cdsCadPro.IsEmpty) Then
    If(fTravaERegistraStlPromocLck) Then
       Exit;
  inherited;

  if not(fCfgSis('PROKIT', VarBoolean)) then
    rdgPreDes.Controls[IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]].Enabled := False;

  pCriarProLog;

  {************************************************}
  {* POR CAUSA DA TRAVA DE REDEATUALIZO IMAGINANDO*}
  {* QUE OUTRO USUARIO ALTEROU EM OUTRA ESTAÇÃO   *}
  {**********************************************LE}
  fCarregaPromocao(dbeCodPro.Text);
  pAfterScroll(Nil);
  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
  pCarregaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);

  If (blnAlterou) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    pHabilitaCodigo(dbeCodPro, dbeDesPro, False);
    rdgPreDes.Enabled  := False;
    rdgComPro.Enabled  := True;
    rdgQtdLim.Enabled  := True;

    pTratarBotoes();
    cxgItens.Refresh;

    pEnableDisableBtnAtuEmLote(True);
    pTrataCheckboxEstoqueRemanescente(TTipDescPro(rdgPreDes.ItemIndex));
    pControlaPrecoDesconto(opcTipDes);

    pAfterScroll(Nil);

    pVisiblePanelValores(False);
    chkTabloidClick(nil);
    pSetEnabledComissao;
  End;

  pSetEnabledCliente;
  pTratarBotoes();

  rdgGiroEstoqClick(Self);

  pLimparFiltrosPrecoVendaReal;
end;

procedure TfrmCadPromocoes.btnEstruturaClick(Sender: TObject);
begin
  inherited;
  pMostraEstrutura('');
end;

procedure TfrmCadPromocoes.btnExcluirClick(Sender: TObject);
  Var
    strGetHost: String;
begin
  strGetHost := '';
  strGetHost := fGetHostLock(fRetornaChaveLckPromo);
  If Not fEmptyStr(strGetHost) Then
  Begin
    fMensagem('Atenção', 'Esta promoção está sendo alterada em outra estação - ' + strGetHost +'.' +
    #13+'Aguarde a liberação da promoção para dar continuidade.', ['&Ok']);
    Exit;
  End;

  strCodProExc := qryTabela.FieldByName('PRO_CODPRO').AsString;
  strCodEmpExc := fGetEmpresasSelecionadas;
  strTabSelExc := fGetTabelasPrecoSelecionadas;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    Try

      strMensagemExclusao := 'Deseja realmente excluir o cadastro completo da promoção?';

      pCriarProLog;

      inherited;

      If (blnExcluiu) Then
      Begin
        Try
          pCriarFormularios(TfrmGravando, frmGravando);
          frmGravando.fExecutarAcao := fExcluirPromocao;
          frmGravando.ShowModal;

          if (not FblnAutomatizada) then
            If frmGravando.blnConfirma Then
              fCommit
            Else
              fRollBack;
        Except
          On E:Exception Do
          Begin
            if (not FblnAutomatizada) then
              fRollBack;
            pMensagensErro(E.Message,'[TfrmCadPromocoes.btnExcluirClick]');
          End;
        End;

        pFreeAndNil(frmGravando);
      End
      Else
      begin
        if (not FblnAutomatizada) then
          fRollBack;
      end;
    Finally
      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := False;
    End;

    If rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
      FObjKitPromocaoBuilder.pLimparClients;

    pgcDados.ActivePageIndex := 0;
    pTratarBotoes();
  Except
    On E: Exception Do
    Begin
      if (not FblnAutomatizada) then
        fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadPromocoes.btnExcluirTodasCndPagClick(Sender: TObject);
begin
  inherited;
  if fPergunta('Deseja remover todas as condições de pagamento da promoção?') then
    cdsCndPag.EmptyDataSet;
end;

procedure TfrmCadPromocoes.btnGravarClick(Sender: TObject);
begin
  pgcDados.ActivePage := tbsGeral;

  If Not fVerificaEmpresas() Then
    Exit;

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

  If (Not fValidaCampos(dbeDesPro, True)) Or
     (Not fValidaCampos(dbeDtaIni, True)) Or
     (Not fValidaCampos(dbeDtaFin, True)) Then
    Exit;

  If ((Not cdsCadPro.Active) Or
      (cdsCadPro.IsEmpty)) Then
  Begin
    fMensagem('','Inclua os itens da promoção!',['&OK']);
    Exit;
  End;

  If (not FblnAutomatizada) and (rdgPreDes.ItemIndex <> IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) And (fVerificaProdutoTintaMaquina) Then
    fMensagem('Atenção','As opções quantidade limite e quantidade mínima,' + #13#10 +
                        ' não são utilizadas para tinta formulada (F8 - Tinta de Máquina).' + #13#10 +
                        'A quantidade considerada é a partir de uma unidade da fórmula escolhida.',['&OK']);

  If (chkUtilizarLimitePorClienteOuVenda.Checked) Then
  Begin
    PromocaoUtilizaLimite := TPromocaoUtilizaLimite(rdgUtilizarLimitePorClienteOuVenda.ItemIndex);
    If (PromocaoUtilizaLimite = pulLimitarPorCliente) Then
      If (Not chkPromocaoRestritaClientesNaoConsumidor.Checked) Then
      Begin
        fMensagem('','Para utilizar limite por cliente, você deve marcar a opção "Promoção restrita a clientes não consumidor".',['&Ok']);
        Exit;
      End;
  End;

  If Not fValidaCamposPromocaoValorMinimo Then
    Exit;

  If (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 2) Then
    Exit;

  btnCancelCli.Click;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravarPromocao;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmGravando);

  strAltGrd := 'N';

  If stlPromoAltLck.Count > 0  Then
    pDestravaELimpaStlPromocLck;

  pSetEnabledCliente;
  pTratarBotoes();
  cdsPCMPRO.EmptyDataSet();
end;

procedure TfrmCadPromocoes.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
end;

procedure TfrmCadPromocoes.pIncluirClienteAutomatizada(const strCodCli, strNomCli, strItens, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String; var strMsgCliente: String);
begin
  if not fValidaCodCli(strNomCli) then
    Exit;

  fIncluirClienteCds(
    strMsgCliente,
    strCodCli,
    strNomCli,
    'X',
    'X',
    'X',
    'X',
    strItens,
    strEmpresasSelecionadas,
    strTabelasPrecoSelecionadas);
end;

procedure TfrmCadPromocoes.pIncluirProdutoAutomatizada(var strMsgProJaInc,
  strMsgProIncOu, strMsgItemEstr01, strMsgItemEstr02,
  strMsgProSemEstoque: String; Parametros: TParametroProduto);
begin
  fIncluirProdutoCds(
    strMsgProJaInc,
    strMsgProIncOu,
    strMsgItemEstr01,
    strMsgItemEstr02,
    strMsgProSemEstoque,
    Parametros);
end;

procedure TfrmCadPromocoes.pInformacoesComissao(var fltPercComissao: Double;
  var strNomeCampoComissao: String);
var
  fltMaiorPercentualComissao : Double;
begin
  If Not fCfgSis('SIMPVR', varBoolean) Then
  Begin
    fltPercComissao := 0;
    strNomeCampoComissao := 'ITE_COMTB' + fGetTabPre;
    Exit;
  End;

  fltMaiorPercentualComissao := cdsCadPro.FieldByName('IPR_COMVAR').AsFloat;
  strNomeCampoComissao       := 'IPR_COMVAR';

  If fltMaiorPercentualComissao < cdsCadPro.FieldByName('IPR_COMATA').AsFloat Then
  Begin
    fltMaiorPercentualComissao := cdsCadPro.FieldByName('IPR_COMATA').AsFloat;
    strNomeCampoComissao       := 'IPR_COMATA';
  End;

  If fltMaiorPercentualComissao < cdsCadPro.FieldByName('IPR_COMDIS').AsFloat Then
  Begin
    fltMaiorPercentualComissao := cdsCadPro.FieldByName('IPR_COMDIS').AsFloat;
    strNomeCampoComissao       := 'IPR_COMDIS';
  End;

  If fltMaiorPercentualComissao <= 0 Then
    strNomeCampoComissao := 'ITE_COMTB' + fGetTabPre;

  fltPercComissao := fltMaiorPercentualComissao;
end;

procedure TfrmCadPromocoes.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('PRO_CODPRO');
  stlCamInd.Add('PRO_DESPRO');
  stlCamInd.Add('PRO_DTAINI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Data Inicial');
end;

procedure TfrmCadPromocoes.FormShow(Sender: TObject);
begin
  inherited;
  TCadPro.pCarregaEmpresa(clbEmpresa);
  edtCodIte.Enabled  := True;
  rdgPreDes.Enabled  := False;
  rdgComPro.Enabled  := False;
  rdgQtdLim.Enabled  := False;
  cxgItens.Enabled   := True;

  pnlTrazerPrecoSugestao.Visible := fCfgSis('PROSUG', varBoolean);

  chkEcommerce.visible := fCfgSis('PROECO', varBoolean);
  strIndicePromocao := '';

  gpbTabloid.Visible := fCfgSis('TABLOI', VarBoolean);

  strAltGrd := 'N';

  pgcDados.ActivePageIndex := 0;

  pEnableDisableBtnAtuEmLote(False);

  if Not fEmptyStr(strCodIte) Then
    pCarregaProdutoPromocao(strCodIte);

  edtPreVen.EditFormat := fMskDigitos(intDecUni);
  edtDesAdi.EditFormat := edtPreVen.EditFormat;
  edtMarBru.EditFormat := edtPreVen.EditFormat;
  intPrecisaoDescontoItem := fRetPrecisaoDescontoItem;
  edtPerDes.EditFormat := fMskDigitos(intPrecisaoDescontoItem);

  blnComPro := fVerificaAcessoSistema('COMPRO');
  pSetEnabledComissao;
  pAfterScroll(Nil);

  pSetaCodIte( dbeCodPro );
  pSetaCodIte( edtCodIte );

  tsKitParaPromocao.TabVisible := False;

  cxgItensITE_PREMED.Visible := fCfgSis('PREPRO', VarBoolean);
  cxgItensITE_PREULT.Visible := fCfgSis('PREPRO', VarBoolean);
  cxgItensITE_IMPULT.Visible := fCfgSis('PREPRO', VarBoolean);

  chkTraPro.Visible := fCfgSis('TRAPRO', varString) = 'C';

  pAjustarAbasAoConsiderarCndPag;

  blnCalcMargemLiquida := fCfgSis('MARPRO', varString) = 'L';
  If blnCalcMargemLiquida Then
    lblMarBru.Caption := 'Margem Líquida:'
end;

procedure TfrmCadPromocoes.clbEmpresaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN:
      Begin
        If (qryTabela.State = dsInsert) Then
        Begin
          If tbsItens.TabVisible then
            pgcDados.ActivePage := tbsItens
          Else
            pgcDados.ActivePage := tsKitParaPromocao;

          If blnImpPC Then
            pSetFocus(edtComVar)
          Else If blnPreAlt Then
            pSetFocus(dbeDtaInicial)
          Else
            pSetFocus(mskLinhaGrupo);
        End
        Else
          SelectNext(ActiveControl, True, True);
      End;
    VK_ESCAPE:
      pEscapePressed();
  End;
end;

procedure TfrmCadPromocoes.clbTabPreClickCheck(Sender: TObject);
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

procedure TfrmCadPromocoes.clbTabPreDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
  Var
    Flags: Longint;
begin
  With TCheckListBox(Control) Do
  Begin
    If VS_strTabVen[Succ(Index)] <> 'S' Then
      Canvas.Font.Color  := clSilver;

//  Canvas.Brush.Color := clWhite;
    Canvas.FillRect(Rect);

    Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);

    If Not UseRightToLeftAlignment then
      Inc(Rect.Left, 2)
    Else
      Dec(Rect.Right, 2);

    DrawText(Canvas.Handle, pWideChar(Items[Index]), Length(Items[Index]), Rect, Flags);
  End;
end;

procedure TfrmCadPromocoes.clbTabPreExit(Sender: TObject);
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

procedure TfrmCadPromocoes.clbTabPreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl,True,True);
  End;
end;

procedure TfrmCadPromocoes.cmbTabPreEnter(Sender: TObject);
begin
  inherited;
  pCarregaTabelasDesAdi(cmbTabPre.Text);
end;

procedure TfrmCadPromocoes.cxgClientesDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      If (qryTabela.State In [dsEdit, dsInsert]) And Not cdsProCli.IsEmpty then
      Begin
        If fPergunta('Deseja remover o cliente ' + cdsProCli.FieldByName('PRO_CODCLI').AsString + ' da promoção?') then
          cdsProCli.Delete;
      End;
  end;
end;

procedure TfrmCadPromocoes.cxgCndPagTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (cdsCndPag.RecordCount > 0) And (dtsCadPromocoes.State In dsEditModes) Then
  Begin
    btnCancelCndPag.Click;
    pCarregaCndPag;
    strAltGrd := 'S';
  End;
end;

procedure TfrmCadPromocoes.cxgCndPagTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_DELETE:
      Begin
        If (qryTabela.State In [dsEdit, dsInsert]) And (Not cdsCndPag.IsEmpty) Then
          If fPergunta('Deseja remover a condição de pagamento ' + cdsCndPag.FieldByName('DESCND').AsString + ' da promoção?') Then
            cdsCndPag.Delete;
      End;
    VK_ESCAPE: pSetFocus(edtCodCnd);
  end;
end;

procedure TfrmCadPromocoes.cxgItensTableViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If (cdsCadPro.RecordCount > 0) And (dtsCadPromocoes.State In dsEditModes) Then
  Begin
    blnMovPnl := Not pnlRight.Visible;
    Try
      pTratarBotoes();
      btnCancelaItem.Click;
      pCarregaItemAlteracao;
      strAltGrd := 'S';
    Finally
      blnMovPnl := True;
    End;
  End;
end;

procedure TfrmCadPromocoes.cxgItensTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (dtsCadPromocoes.State In dsEditModes) Then
  Begin
    blnMovPnl := Not pnlRight.Visible;
    Try
      pTratarBotoes();
      btnCancelaItem.Click;
      pCarregaItemAlteracao;
      strAltGrd := 'S';
    Finally
      blnMovPnl := True;
    End;
  End
  Else If (Key = VK_DELETE) And (dtsCadPromocoes.State In dsEditModes) Then
  Begin
    If (cdsCadPro.Active) And (Not cdsCadPro.IsEmpty) Then
      pAlteraStatusTemp('D');
  End;
end;

procedure TfrmCadPromocoes.cxvFiltrosCodAbfEditPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  pPesquisaAbfIcm(qryConAbf, qryConAbf, DisplayValue);
  If qryConAbf.IsEmpty Then
  Begin
    Error     := True;
    ErrorText := 'Abreviação Fiscal inválida';
  End;
end;

procedure TfrmCadPromocoes.grdDBKitBrindeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
    FObjKitPromocaoBuilder.CdsBrinde.Delete;
end;

procedure TfrmCadPromocoes.grdDBKitProdutoBeneficiadoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
    FObjKitPromocaoBuilder.pApagarKitDetalhes(FObjKitPromocaoBuilder.CdsProdutoBeneficiado.FieldByName('AUTOINCREM').AsString,
                                              ttpBeneficiado,
                                              cdsCadPro);
end;

procedure TfrmCadPromocoes.grdDBKitProdutoGatilhoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
    FObjKitPromocaoBuilder.pApagarKitDetalhes(FObjKitPromocaoBuilder.CdsProdutoGatilho.FieldByName('AUTOINCREM').AsString,
                                              ttpGatilho,
                                              cdsCadPro);
end;

procedure TfrmCadPromocoes.mnuInverterSelecaoClick(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('I');
end;

procedure TfrmCadPromocoes.lblOpSeleClick(Sender: TObject);
  Var
    intQtdSel : Integer;
    curPos    : TPoint;
    intIndex  : Integer;

begin
  inherited;

  intQtdSel := 0;

  If (Not btnGravar.Enabled) Then
    Exit;

  For intIndex := 0 To clbEmpresa.Count -1 Do
  Begin
    If clbEmpresa.Checked[intIndex] Then
    Begin
      intQtdSel :=  intQtdSel + 1;
    End;
  End;

  mnuMarcaTodos.Enabled    := (intQtdSel < clbEmpresa.Count);
  mnuDesmarcaTodos.Enabled := (intQtdSel > 0);

  GetCursorPos(curPos);
  popOpSele.Popup(curPos.X + 2, curPos.Y + 2);

end;

procedure TfrmCadPromocoes.mnuMarcaTodosClick(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('S');
end;

procedure TfrmCadPromocoes.grdDBKitKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  var
    LIdx : Integer;
    LCds : TUniClientDataSet;
    LtipoProduto : ttipoProduto;
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    for LIdx := 1 to 2 do
    Begin
      If LIdx = 1 then
      Begin
        LCds         := FObjKitPromocaoBuilder.CdsProdutoGatilho;
        LtipoProduto := ttpGatilho;
      End
      Else
      Begin
        LCds         := FObjKitPromocaoBuilder.CdsProdutoBeneficiado;
        LtipoProduto := ttpBeneficiado;
      End;

      LCds.DisableControls;
      LCds.Last;
      while not LCds.Bof do
      Begin
        if LCds.FieldByName('DET_SEQKIT').AsString = FObjKitPromocaoBuilder.CdsKit.FieldByName('AUTOINCREM').AsString then
        Begin
          FObjKitPromocaoBuilder.pApagarKitDetalhes(LCds.FieldByName('AUTOINCREM').AsString,
                                                    LtipoProduto,
                                                    cdsCadPro);
        End
        else
          LCds.Prior;
      End;
      LCds.EnableControls;
    End;

    FObjKitPromocaoBuilder.CdsKit.Delete;
  End;
end;

procedure TfrmCadPromocoes.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;

  If mskLinhaGrupo.ReadOnly Then
    Exit;

  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;

  If edtFornecedor.ReadOnly Then
    Exit;

  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtGrupoGatilhoParaKitExit(Sender: TObject);
  var
    LEditCodigo    : TMaskEditFocus;
    LEditDescricao : TEditFocus;
begin
  If Sender = edtGrupoGatilhoParaKit Then
  Begin
    LEditCodigo    := edtGrupoGatilhoParaKit;
    LEditDescricao := edtGrupoGatilhoDescParaKit;
  End
  Else
  Begin
    LEditCodigo    := edtGrupoBeneficiadoParaKit;
    LEditDescricao := edtGrupoBeneficiadoDescParaKit;
  End;

  If fEmptyStr(LEditCodigo.Text) Then
    LEditDescricao.Text := ''
  Else
    LEditDescricao.Text := fRetNomeLinhaGrupo(LEditCodigo.Text);

  LEditDescricao.Enabled := False;

  If fEmptyStr(LEditDescricao.Text) And (Not fEmptyStr(LEditCodigo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    LEditCodigo.Clear;
    pSetFocus(LEditCodigo);
  End;
end;

procedure TfrmCadPromocoes.edtGrupoGatilhoParaKitKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupos: TConsultasArray;
    LEditCodigo    : TMaskEditFocus;
    LEditDescricao : TEditFocus;
begin
  inherited;

  If Sender = edtGrupoGatilhoParaKit Then
  Begin
    LEditCodigo    := edtGrupoGatilhoParaKit;
    LEditDescricao := edtGrupoGatilhoDescParaKit;
  End
  Else
  Begin
    LEditCodigo    := edtGrupoBeneficiadoParaKit;
    LEditDescricao := edtGrupoBeneficiadoDescParaKit;
  End;

  If fPesqGrupo(Self, LEditCodigo, LEditDescricao, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(LEditCodigo, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;

  If edtMarca.ReadOnly Then
    Exit;

  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtNuCnPjEnter(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Or (edtCgcCpf.Text = '2') Then
    edtNuCnPj.ReadOnly := False
  Else
    edtNuCnPj.ReadOnly := True;
end;

procedure TfrmCadPromocoes.edtPerDesExit(Sender: TObject);
begin
  inherited;

  If edtPerDes.ReadOnly Then
    Exit;

  If (fEmptyStr(edtPerDes.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O percentual de desconto deve ser preenchido!', ['&Ok']);
    pSetFocus(edtPerDes);
  End;

end;

procedure TfrmCadPromocoes.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
  inherited;

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := Key;
  if fPesqUnidade(Self, edtUnidade, Nil, Nil, qryCadUni, chrKey, arrUnidades) then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadPromocoes.edtUnidadeGatilhoParaKitKeyPress(Sender: TObject; var Key: Char);
  var
    arrUnidades: TConsultasArray;
    LEditDescricao : TEditFocus;
begin
  inherited;

  If Sender = edtUnidadeGatilhoParaKit then
    LEditDescricao := edtUnidadeGatilhoParaKit
  Else
    LEditDescricao := edtUnidadeBeneficiadoParaKit;

  if fPesqUnidade(Self, LEditDescricao, Nil, Nil, qryCadUni, Key, arrUnidades) then
  begin
    If fValidaCampos(LEditDescricao, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadPromocoes.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  If mskLinhaGrupo.ReadOnly Then
    Exit;

  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);

  edtDesGrupo.Enabled := False;

  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text))  Then
  Begin
    fMensagem('AVISO','Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;

end;

procedure TfrmCadPromocoes.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If fEmptyStr(edtCodIte.Text) Then
    pLimpaInputsDadosItem
  Else
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    edtUnidade.Text := fRetUnidadeItem(edtCodIte.Text);
  End;

  edtDesIte.Enabled := False;

  If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;

end;

procedure TfrmCadPromocoes.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If edtFornecedor.ReadOnly Then
    Exit;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  edtDesFornecedor.Enabled := False;

  If fEmptyStr(edtDesFornecedor.Text) And (Not fEmptyStr(edtFornecedor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmCadPromocoes.pOpcaoSelecao(strOpcao: Char);
  Var
    intIndex  : Integer;

begin

  If (strOpcao = 'S') Then
  Begin
    For intIndex := 0 to clbEmpresa.Count -1 do
      clbEmpresa.Checked[intIndex] := true;
  End
  Else If (strOpcao = 'N') Then
  Begin
    For intIndex := 0 To clbEmpresa.Count -1 Do
      clbEmpresa.Checked[intIndex] := false;
  End
  Else If (strOpcao = 'I') Then
  begin
    For intIndex := 0 To clbEmpresa.Count -1 Do
      clbEmpresa.Checked[intIndex] := Not clbEmpresa.Checked[intIndex];
  End;

end;

procedure TfrmCadPromocoes.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If edtMarca.ReadOnly Then
    Exit;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

  edtDesMarca.Enabled := False;

  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text))  Then
  Begin
    fMensagem('AVISO','Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;

end;

procedure TfrmCadPromocoes.cbxCategoriaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   If (Key = VK_RETURN) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadPromocoes.cdsProCliCalcFields(DataSet: TDataSet);
begin
  inherited;
  If (Length(cdsProCliPRO_CGCCPF.AsString) > 12) Then
    cdsProCliPRO_CPFMAS.AsString := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_G_C_), cdsProCliPRO_CGCCPF.AsString)
  Else
    cdsProCliPRO_CPFMAS.AsString := FormatMaskText(fRetMascaraC_G_C_(fSetaPais, C_P_F_), cdsProCliPRO_CGCCPF.AsString);
end;

procedure TfrmCadPromocoes.chkAguCliClick(Sender: TObject);
begin
  inherited;
  if (not chkAguCli.Checked) and (not chkPrevis.Checked) and (not chkFalPro.Checked) then
    chkEntFut.Checked := False;
end;

procedure TfrmCadPromocoes.chkEcommerceClick(Sender: TObject);
begin
  inherited;
  if chkEcommerce.Checked then
  begin
    if not cdsProCli.isEmpty then
    begin
      fMensagem('ATENÇÃO!','Promoção para e-commerce não pode conter clientes vinculados. '+#13+
                            'Apague os clientes da aba "Clientes da Promoção" e depois tente marcar novamente essa opção!', ['&OK']);
      chkEcommerce.Checked := false;
      exit;
    end;
    if fPossuiLimite and (not fCfgSis('PROEQL', varBoolean)) then
    begin
      fMensagem('','Uma Promoção para e-commerce não permite "Quantidade Limite" de itens.', ['&OK']);
      chkEcommerce.Checked := false;
      exit;
    end;
    edtQtdMin.Text := '1,00';

    If ((Not cdsCndPag.IsEmpty) And (Not fCfgSis('CPPECO', varBoolean))) Then
    Begin
      fMensagem('ATENÇÃO!','Promoção para e-commerce não pode conter condição de pagamento vinculada.'+#13+
                           'Apague as condições da aba "Condições de Pagto" e depois tente marcar novamente essa opção!', ['&OK']);
      chkEcommerce.Checked := false;
      Exit;
    End;
  end;
  blnEcomme := chkEcommerce.Checked;
  tbsClientes.Enabled := Not blnEcomme;
  tbsCondPagto.Enabled := Not blnEcomme;
  rdgPreDes.ItemIndex  := IIF((blnEcomme and (rdgPreDes.ItemIndex > 1)), 0, rdgPreDes.ItemIndex);
  strIndicePromocao    := inttostr(rdgPreDes.ItemIndex);
  chkSomaCompraPend.Checked := false;
  chkSomaCompraPend.Enabled := Not blnEcomme;

  If blnEcomme Then
    chkPromocaoRestritaClientesNaoConsumidor.Checked := false;

  chkPromocaoRestritaClientesNaoConsumidor.Enabled := Not blnEcomme;

  chkTabloid.Enabled := (Not blnEcomme) or fCfgSis('PMPEPT', varBoolean);

  If Not chkTabloid.Enabled Then
  Begin
    chkTabloid.Checked := False;
    If (chkTabloid.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
      chkTabloid.Field.AsString := 'N';
  End;

  If Not fVerificaAcessoSistema('PERIAE', strLoginUsuarioLogado) then
  Begin
    chkTabloid.Enabled := False;
  End;

  If fPermiteQtdeLimite Then
    pEnabledEdit(edtQtdLim)
  Else
    pDisableEdit(edtQtdLim);

  if Not blnEcomme then
    pEnabledEdit(edtQtdMin)
  else
    pDisableEdit(edtQtdMin);

  edtQtdLim.enabled := fPermiteQtdeLimite;
  edtQtdMin.enabled := Not blnEcomme;
end;

procedure TfrmCadPromocoes.chkEntFutClick(Sender: TObject);
begin
  inherited;
  gpbEntFut.Enabled := chkEntFut.Checked;
  chkAguCli.Checked := chkEntFut.Checked;
  chkPrevis.Checked := chkEntFut.Checked;
  chkFalPro.Checked := chkEntFut.Checked;
end;

procedure TfrmCadPromocoes.chkTabloidClick(Sender: TObject);
begin
  inherited;
  If chkTabloid.Checked Then
    lblTabloid.Font.Color := clRed
  Else
    lblTabloid.Font.Color := cl3DDkShadow;
end;

procedure TfrmCadPromocoes.chkUtilizarLimitePorClienteOuVendaClick(Sender: TObject);
begin
  inherited;

  If (qryTabela.State In [dsInsert, dsEdit]) Then
    rdgUtilizarLimitePorClienteOuVenda.Enabled := TCheckBox(Sender).Checked;

  edtCliVen.Visible := TCheckBox(Sender).Checked;
  lblCliVen.Visible := TCheckBox(Sender).Checked;

end;

procedure TfrmCadPromocoes.ckbSaldoZeroClick(Sender: TObject);
begin
  inherited;
   if ckbSaldoZero.checked then
     rdgGiroEstoq.ItemIndex := 2;
end;

procedure TfrmCadPromocoes.ckbTipoClienteClick(Sender: TObject);
begin
  inherited;

  if ckbTipoCliente.Checked then
  begin
    rdgTipoCliente.Enabled := True;
    rdgTipoCliente.ItemIndex := 1;
    btnIncCli.Enabled := False;
    pExcluirTodosClientes;
  end
  else
  begin
    rdgTipoCliente.Enabled := False;
    rdgTipoCliente.ItemIndex := -1;
    btnIncCli.Enabled := True;
  end;
end;

procedure TfrmCadPromocoes.clbEmpresaExit(Sender: TObject);
begin
  inherited;
  If (qryTabela.State In [dsInsert, dsEdit]) Then
    fVerificaEmpresas();
end;

procedure TfrmCadPromocoes.edtBrindeParaKitExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtBrindeParaKit.text) Then
    edtBrindeDescParaKit.Text := ''
  Else
    edtBrindeDescParaKit.Text := fRetNomProduto(edtBrindeParaKit.Text);

  If fEmptyStr(edtBrindeDescParaKit.Text) And (Not fEmptyStr(edtBrindeParaKit.Text))  Then
  Begin
    fMensagem('AVISO', 'Código do Produto (Brinde) não encontrado.', ['&O K']);
    edtBrindeParaKit.Clear;
    pSetFocus(edtBrindeParaKit);
  End;
end;

procedure TfrmCadPromocoes.edtBrindeParaKitKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtBrindeParaKit, edtBrindeDescParaKit, qryConIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtBrindeParaKit, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadPromocoes.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    edtNuCnpj.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else If (edtCgcCpf.Text = '2') Then
    edtNuCnpj.EditMask := '999.999.999-99;0;'
  Else
    edtNuCnpj.EditMask := '';
end;

procedure TfrmCadPromocoes.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAti, edtDesAti, arrAtiv, nil, fRetNomAtividade, 'da atividade', 3);
end;

procedure TfrmCadPromocoes.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv, False) Then
  Begin
    if fValidaCampos(edtCodAti, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodCacExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCac, edtDesCac, arrCanal, nil, fRetNomCanalAcesso, 'do Canal');
end;

procedure TfrmCadPromocoes.edtCodCacKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqCanalAcesso(Self, edtCodCac, edtDesCac, Nil, Key, arrCanal, False) Then
  Begin
    fValidaCampos(edtCodCac, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodCidExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCid, edtDesCid, arrCidade, fRetNomCidadeSemOpc, Nil, 'da cidade', 5);
end;

procedure TfrmCadPromocoes.edtCodCidKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtDesCid, edtEstado, Nil, Key, arrCidade, False) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadPromocoes.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, nil, fRetNomCliente, 'do cliente', 8);
end;

procedure TfrmCadPromocoes.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadPromocoes.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd, edtDesCnd, arrCndPag, fRetDesConPag, Nil, 'da Condição de Pagamento');
end;

procedure TfrmCadPromocoes.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, nil, Key, arrCndPag) Then
  Begin
    If fValidaCampos(edtCodCnd, True) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadPromocoes.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  strIteAtu := edtCodIte.Text;
end;

procedure TfrmCadPromocoes.btnHerancaClick(Sender: TObject);
  Var
    qryGenPro: TUniQuery;
    strEmpresas: String;
begin
  qryGenPro := fCriaQuery(Self);

  inherited;

  Try
    pCriarFormularios(TfrmHerancaPromocao, frmHerancaPromocao);
    frmHerancaPromocao.qryGenPro := qryGenPro;
    frmHerancaPromocao.ShowModal;

    If frmHerancaPromocao.blnConfirma Then
    Begin
      fCarregaPromocao(qryGenPro.FieldByName('PRO_CODPRO').AsString, True);
      pCarregaClientesPromocao(qryGenPro.FieldByName('AUTOINCREM').AsString);
      pCarregaCondicoes(qryGenPro.FieldByName('AUTOINCREM').AsString);

      qryTabela.FieldByName('PRO_DESPRO').AsString  := qryGenPro.FieldByName('PRO_DESPRO').AsString;
      qryTabela.FieldByName('PRO_PREDES').AsString  := qryGenPro.FieldByName('PRO_PREDES').AsString;
      qryTabela.FieldByName('PRO_TABPRE').AsString  := qryGenPro.FieldByName('PRO_TABPRE').AsString;
      qryTabela.FieldByName('PRO_DTAINI').AsString  := qryGenPro.FieldByName('PRO_DTAINI').AsString;
      qryTabela.FieldByName('PRO_DTAFIN').AsString  := qryGenPro.FieldByName('PRO_DTAFIN').AsString;
      qryTabela.FieldByName('PRO_DESADI').AsString  := qryGenPro.FieldByName('PRO_DESADI').AsString;
      qryTabela.FieldByName('PRO_IDXPRO').AsInteger := qryGenPro.FieldByName('PRO_IDXPRO').AsInteger;
      qryTabela.FieldByName('PRO_QTDLIM').AsString  := qryGenPro.FieldByName('PRO_QTDLIM').AsString;
      qryTabela.FieldByName('PRO_QTDMIN').AsString  := qryGenPro.FieldByName('PRO_QTDMIN').AsString;

      pAfterScroll(Nil);

      strEmpresas := fCampoTabela('GROUP_CONCAT(PRO_CODEMP)', 'PROEMP', ['PRO_SEQGER'], [qryGenPro.FieldByName('AUTOINCREM').AsString]);

      pMarcarEmpresas(strEmpresas);

      pMarcarTabelasPreco(qryTabela.FieldByName('PRO_TABPRE').AsString);

      If pnlCabecalho.Enabled And dbeDesPro.CanFocus Then
      Begin
        pSetFocus(dbeDesPro);
      End;

      if TTipDescPro(rdgPreDes.ItemIndex) = tdpPromocaoCompostaPorKit then
        FObjKitPromocaoBuilder.pRefazerIds;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadPromocoes.btnHerancaClick]');
    End;
  End;

  pFreeAndNil(frmHerancaPromocao);
  FreeAndNil(qryGenPro);

end;

procedure TfrmCadPromocoes.btnHlpComClick(Sender: TObject);
  Var
    frmAjudaPorAbas : TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Ajuda - Considerar Comissão';
    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Comissão da promoção').
      fSetaTituloPagina('Comissão informada nesta promoção').
      fAddLinhaTexto('   Os percentuais de comissão cadastrados nesta promoção serão sempre utilizados '+
                     'no faturamento, mesmo que estejam zerados.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Comissão do sistema').
      fSetaTituloPagina('Comissão definida nas configurações do sistema').
      fAddLinhaTexto('   Os percentuais de comissão praticados no faturamento virão da comissão cadastrada '+
                     'na configuração [CFG_OPCCOM] Opção de Comissão para Vendedores.');

    frmAjudaPorAbas.ShowModal;
  Finally
    FreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadPromocoes.btnHlpProClick(Sender: TObject);
 Var
    frmAjudaPorAbas : TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Ajuda - Promoção por';
    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Preço').
      fSetaTituloPagina('Promoção por preço').
      fAddLinhaTexto('   Este tipo define um preço de venda fixo para a promoção do produto, ativado quando uma das tabelas' +
                     ' de preço cadastradas na promoção for utilizada pelo vendedor no faturamento.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do produto informada pelo vendedor deve ser igual ou' +
                     ' superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   Quando o preço de custo for informado, ele será utilizado no faturamento para cálculo de margem e' +
                     ' para relatórios de faturamento.').
      fAddLinhaTexto('   Quando o preço de custo estiver zero, será utilizado o preço de custo do cadastro de produtos no' +
                     ' faturamento para cálculo de margem e para relatórios de faturamento.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('% Desconto').
      fSetaTituloPagina('Promoção por percentual de desconto').
      fAddLinhaTexto('   Este tipo define um preço de venda calculado, aplicando o percentual de desconto da promoção, sobre' +
                     ' o preço de venda do produto, conforme a tabela de preço utilizada no faturamento, ativado quando uma' +
                     ' das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do produto informada pelo vendedor deve ser igual ou' +
                     ' superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   Será utilizado sempre o preço de custo do cadastro de produtos no faturamento para cálculo de margem' +
                     ' e para relatórios de faturamento.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Desconto adicional').
      fSetaTituloPagina('Promoção por preço com desconto adicional sobre o preço de compra').
      fAddLinhaTexto('   Este tipo define um preço de venda fixo para a promoção do produto, gerado automaticamente conforme' +
                     ' o desconto adicional sobre o preço de compra e a margem da tabela de preço base informada na' +
                     ' promoção, ativado quando uma das tabelas de preço cadastradas na promoção for utilizada pelo' +
                     ' vendedor no faturamento.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do produto informada pelo vendedor deve ser igual ou' +
                     ' superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   O preço de custo do produto será calculado considerando o desconto adicional sobre o preço de compra,' +
                     ' informado como 7º desconto na cadeia do preço de compra líquido, da formação do custo do cadastro de' +
                     ' produtos.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Quantidade coletiva').
      fSetaTituloPagina('Promoção por preço por quantidade coletiva').
      fAddLinhaTexto('   Este tipo define um preço de venda fixo para os produtos cadastrados na promoção, ativado quando uma' +
                     ' das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento e a' +
                     ' quantidade dos produtos informados pelo vendedor for igual ou superior à quantidade coletiva' +
                     ' informada na promoção. Mais de um produto pode ser utilizado pelo vendedor para compor a quantidade' +
                     ' necessária para ativar a promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do(s) produto(s) informada pelo vendedor deve ser igual' +
                     ' ou superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   Quando o preço de custo for informado, ele será utilizado no faturamento para cálculo de margem e' +
                     ' para relatórios de faturamento.').
      fAddLinhaTexto('   Quando o preço de custo estiver zero, será utilizado o preço de custo do cadastro de produtos no' +
                     ' faturamento para cálculo de margem e para relatórios de faturamento.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('% Desconto adicional').
      fSetaTituloPagina('Promoção por percentual de desconto com desconto adicional sobre preço de compra').
      fAddLinhaTexto('   Este tipo define um preço de venda calculado para cada tabela de preço, gerado automaticamente' +
                     ' conforme o desconto adicional sobre o preço de compra e a margem de cada tabela de preço, ativado' +
                     ' quando uma das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do produto informada pelo vendedor deve ser igual ou' +
                     ' superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   O preço de custo do produto será calculado considerando o desconto adicional sobre o preço de compra,' +
                     ' informado como 7º desconto na cadeia do preço de compra líquido, da formação do custo do cadastro de' +
                     ' produtos.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('% Desconto qtd. coletiva').
      fSetaTituloPagina('Promoção por percentual de desconto por quantidade coletiva').
      fAddLinhaTexto('   Este tipo define um percentual de desconto para os produtos cadastrados na promoção, ativado quando' +
                     ' uma das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento e a' +
                     ' quantidade dos produtos informados pelo vendedor for igual ou superior à quantidade coletiva' +
                     ' informada na promoção. Mais de um produto pode ser utilizado pelo vendedor para compor a quantidade' +
                     ' necessária para ativar a promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, a quantidade do(s) produto(s) informada pelo vendedor deve ser igual' +
                     ' ou superior à quantidade mínima cadastrada nesta promoção, para o produto.').
      fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve' +
                     ' ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   Quando o preço de custo for informado, ele será utilizado no faturamento para cálculo de margem e' +
                     ' para relatórios de faturamento.').
      fAddLinhaTexto('   Quando o preço de custo estiver zero, será utilizado o preço de custo do cadastro de produtos no' +
                     ' faturamento para cálculo de margem e para relatórios de faturamento.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Estoque remanescente').
      fSetaTituloPagina('Estoque remanescente dos produtos com atualização de preços').
      fAddLinhaTexto('   Este tipo coloca o preço de venda atual, de cada tabela, para os produtos com atualização de preço no período informado'+
                     ' na tela de filtros, ativado quando uma das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no'+
                     ' faturamento.').
      fAddLinhaTexto('   É possível definir um percentual do estoque atual disponivel que será colocado em promoção, gerando sempre uma promoção'+
                     ' com quantidade limite.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve ser igual ou'+
                     ' inferior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   Quando o preço de custo for informado, ele será utilizado no faturamento para cálculo de margem e para relatórios'+
                     ' de faturamento.').
      fAddLinhaTexto('   Quando o preço de custo estiver zero, será utilizado o preço de custo do cadastro de produtos no faturamento para cálculo'+
                     ' de margem e para relatórios de faturamento.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Negociação especial').
      fSetaTituloPagina('Negociação especial com fornecedor através de pedido de compra').
      fAddLinhaTexto('   Este tipo de promoção parte do preço de compra digitado nos pedidos de compra informados na tela de filtros,'+
                     ' e calcula um novo preço de custo e novo preço de venda, de cada tabela, mantendo a respectiva margem de lucro.').
      fAddLinhaTexto('   É possível carregar mais de um pedido de compra para cadastrar esta promoção, gerando sempre uma promoção com'+
                     ' quantidade limite, de acordo com a quantidade informada no pedido de compra.').
      fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve ser igual ou'+
                     ' superior ao prazo médio cadastrado nesta promoção.').
      fAddLinhaTexto('   O preço de custo estará sempre informado, e será utilizado no faturamento para cálculo de margem e para'+
                     ' relatórios de faturamento.');

    If fCfgSis('UTIVMP', varBoolean) Then
    Begin

      frmAjudaPorAbas.fAddPagina().
        fSetaTituloGuia('Preço por valor mínimo do total dos produtos').
        fSetaTituloPagina('Preço por valor mínimo do total dos produtos').
        fAddLinhaTexto('   Este tipo define um preço de venda calculado, aplicando o percentual de desconto da promoção, ' +
                       'sobre o preço de venda do produto, conforme a tabela de preço utilizada no faturamento, ativado quando ' +
                       'uma das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento.').
        fAddLinhaTexto('   Para ativá-la no faturamento, o Valor Total dos Produtos na Venda deve ser igual ou superior ao cadstrado nesta promoção.').
        fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
        fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
        fAddLinhaTexto('   Será utilizado sempre o preço de custo do cadastro de produtos no faturamento para cálculo de margem e para relatórios de faturamento.');

      frmAjudaPorAbas.fAddPagina().
        fSetaTituloGuia('% Desconto por valor mínimo do total dos produtos').
        fSetaTituloPagina('% Desconto por valor mínimo do total dos produtos').
        fAddLinhaTexto('   Este tipo define um preço de venda calculado, aplicando o percentual de desconto da promoção, ' +
                       'sobre o preço de venda do produto, conforme a tabela de preço utilizada no faturamento, ativado ' +
                       'quando uma das tabelas de preço cadastradas na promoção for utilizada pelo vendedor no faturamento.').
        fAddLinhaTexto('   Para ativá-la no faturamento, o Valor Total dos Produtos na Venda deve ser igual ou superior ao cadstrado nesta promoção.').
        fAddLinhaTexto('   Caso tenha quantidade limite, somente esta quantidade ficará disponível em promoção.').
        fAddLinhaTexto('   Para ativá-la no faturamento, o prazo médio da condição de pagamento utilizada pelo vendedor deve ser igual ou inferior ao prazo médio cadastrado nesta promoção.').
        fAddLinhaTexto('   Será utilizado sempre o preço de custo do cadastro de produtos no faturamento para cálculo de margem e para relatórios de faturamento.');

    End;

    frmAjudaPorAbas.ShowModal;
  Finally
    FreeAndNil(frmAjudaPorAbas);
  End;

end;

procedure TfrmCadPromocoes.btnHlpQtdLimClick(Sender: TObject);
  Var
    frmAjudaPorAbas : TfrmAjudaPorAbas;
begin
  inherited;
  pCriarFormularios(TfrmAjudaPorAbas, frmAjudaPorAbas);
  Try
    frmAjudaPorAbas.Caption := 'Ajuda - Aplicar quantidade limite desta promoção';
    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Individual').
      fSetaTituloPagina('Quantidade limite aplicada individualmente para cada empresa participante da promoção').
      fAddLinhaTexto('   A quantidade limite informada será controlada a partir dos pedidos e vendas '+
                     'efetuadas de cada empresa participante invidualmente.');

    frmAjudaPorAbas.fAddPagina().
      fSetaTituloGuia('Coletiva').
      fSetaTituloPagina('Quantidade limite aplicada coletivamente para todas empresas participantes da promoção').
      fAddLinhaTexto('   A quantidade limite informada será controlada a partir dos pedidos e vendas '+
                     'efetuadas de todas empresas participantes.');

    frmAjudaPorAbas.ShowModal;
  Finally
    FreeAndNil(frmAjudaPorAbas);
  End;
end;

procedure TfrmCadPromocoes.dbeDtaIniEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaIni.Text := DateToStr(VS_Date);
end;

procedure TfrmCadPromocoes.mnuDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  pOpcaoSelecao('N');
end;

procedure TfrmCadPromocoes.dbeDtaFinEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaFin.Text := DateToStr(VS_Date);
end;

procedure TfrmCadPromocoes.pAlteraStatusTemp(strStatus: String);
  Var
    intFoco, intTop: Integer;
begin
  intFoco := cxgItensTableView.Controller.FocusedRowIndex;
  intTop  := cxgItensTableView.Controller.TopRecordIndex;

  Try
    cdsCadPro.Edit;
    cdsCadPro.FieldByName('IPR_STATUS').AsString := strStatus;
    cdsCadPro.FieldByName('IPR_STALOG').AsString := IIF(strStatus = 'D', 'E',
                                                    IIF(strStatus = 'A', 'I',
                                                    IIF(strStatus = 'E', 'A','')));
    cdsCadPro.Post;
  Finally
    pTratarBotoes;

    If (cxgItensTableView.DataController.DataRowCount > 0) Then
    Begin
      cxgItensTableView.Controller.FocusedRowIndex := intFoco;
      cxgItensTableView.Controller.TopRecordIndex  := intTop;
    End;
  End;
end;

procedure TfrmCadPromocoes.pAtivaCamposCliente;
begin
  edtCodAti.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
  edtCodCid.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
  edtCodAti.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
  edtCgcCpf.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
  edtEstado.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
  edtNuCnpj.Enabled := fEmptyStr(edtCodCli.Text) or (Length(arrClientes) > 1);
end;

procedure TfrmCadPromocoes.pAtualizarQtdDisponivelPromocao(strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar = Nil);
begin
  If blnTodasEmpresas Then
    pAtualizarQtdDisponivelPromocaoTodasEmpresas(strAutIncPro, blnTodasEmpresas, pgbStatus)
  Else
    pAtualizarQtdDisponivelPromocaoPadrao(strAutIncPro, blnTodasEmpresas, pgbStatus);
end;

procedure TfrmCadPromocoes.pAtualizarQtdDisponivelPromocaoPadrao(
  strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar);
Var
  qryGen: TUniQuery;
  strCodIte: String;
  objInvokerUpdatePromo: IInvokerUpdatePromo;
begin
  qryGen := fCriaQuery(Self);
  strCodIte := '';

  pInfoStatusGravacao(pgbStatus, 'Aguarde... iniciando atualização de quantidade disponível ...', qryGen.RecordCount);
  Application.ProcessMessages;

  Try
    pInfoStatusGravacao(pgbStatus, 'Aguarde... Consultando quantidade disponível ...', qryGen.RecordCount);
    Application.ProcessMessages;

    objInvokerUpdatePromo := TInvokerUpdatePromo.New();
    objInvokerUpdatePromo.fConsultaQtdDispTabelaProm(strAutIncPro, fGetEmpresasSelecionadas, blnTodasEmpresas);

    qryGen.IndexFieldNames := 'IPR_CODITE; IPR_CODEMP';

    qryGen.SQL.Add('SELECT I.IPR_CODITE, IPR.IPR_CODEMP                      ');
    qryGen.SQL.Add('  FROM ITEPRO I                                          ');
    qryGen.SQL.Add('INNER JOIN IPREMP IPR                                    ');
    qryGen.SQL.Add('        ON IPR.IPR_SEQGER = I.AUTOINCREM                 ');
    qryGen.SQL.Add(' WHERE I.IPR_SEQGER = :AUTINC AND IPR_QTDLIM > 0         ');
    qryGen.ParamByName('AUTINC').AsString := strAutIncPro;
    qryGen.Open;
    If Not qryGen.IsEmpty Then
    Begin
      pInfoStatusGravacao(pgbStatus, 'Aguarde... Preparando Dados ...', qryGen.RecordCount);
      Application.ProcessMessages;

      While Not qryGen.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        If (strCodIte <> qryGen.Fields[0].AsString) Then
        Begin
          objInvokerUpdatePromo.pAdd(

            TUpdatePromo.New(
               TParametrosPromocao.New()
                 .CodIte(qryGen.Fields[0].AsString)
                 .CodEmp(qryGen.Fields[1].AsString)
                 .strAutIncProm(strAutIncPro)
                 .blnTodasEmpresas(blnTodasEmpresas)
                 .BlnArrayPreenchido(True)
                 .LevantarExcecao(False)
               )
          );

          If blnTodasEmpresas Then
            strCodIte := qryGen.Fields[0].AsString;
        End;

        qryGen.Next;
      End;

      objInvokerUpdatePromo.fAtualizaQtdDisponivelTabTmp(pgbStatus);
    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadPromocoes.pAtualizarQtdDisponivelPromocaoTodasEmpresas(
  strAutIncPro: String; blnTodasEmpresas: Boolean; pgbStatus: TcxProgressBar);
Var
    qryGen: TUniQuery;
    strCodIte: String;
    objInvokerUpdatePromo: IInvokerUpdatePromo;
begin
  qryGen := fCriaQuery(Self);
  strCodIte := '';

  Try
    qryGen.SQL.Add('SELECT I.IPR_CODITE, IPR.IPR_CODEMP                      ');
    qryGen.SQL.Add('  FROM ITEPRO I                                          ');
    qryGen.SQL.Add('INNER JOIN IPREMP IPR                                    ');
    qryGen.SQL.Add('        ON IPR.IPR_SEQGER = I.AUTOINCREM                 ');
    qryGen.SQL.Add(' WHERE I.IPR_SEQGER = :AUTINC AND IPR_QTDLIM > 0         ');
    qryGen.ParamByName('AUTINC').AsString := strAutIncPro;
    qryGen.Open;
    If Not qryGen.IsEmpty Then
    Begin
      pInfoStatusGravacao(pgbStatus, 'Aguarde... Atualizando Dados ...', qryGen.RecordCount);

      objInvokerUpdatePromo := TInvokerUpdatePromo.New();

      While Not qryGen.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        If (strCodIte <> qryGen.Fields[0].AsString) Then
        Begin
          objInvokerUpdatePromo.pAdd(

            TUpdatePromo.New(
               TParametrosPromocao.New()
                 .CodIte(qryGen.Fields[0].AsString)
                 .CodEmp(qryGen.Fields[1].AsString)
                 .LevantarExcecao(True)
               )
          );

          If blnTodasEmpresas Then
            strCodIte := qryGen.Fields[0].AsString;
        End;

        qryGen.Next;
      End;

      objInvokerUpdatePromo.fAtualizaQtdDisponivel(pgbStatus);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadPromocoes.pAtualizaValoresConformeCadIte(strCodPro: String);
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    strCodProAtual := strCodPro;
    frmGravando.fExecutarAcao := fAtualizaValoresConformeCadIte;
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmCadPromocoes.pCarregaPedidosCompraImportados(
  const strAutInc: String);
  var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  Try
    qryGen.SQL.Clear();
    qryGen.SQL.Add(sqlLoadPCMPRO);
    qryGen.ParamByName('SEQGER').AsString := strAutInc;
    qryGen.Open();

    cdsPCMPRO.EmptyDataSet();

    While (Not qryGen.Eof) Do
    Begin
      cdsPCMPRO.AppendRecord([qryGen.FieldByName('PRO_NUMPED').AsString,
                              qryGen.FieldByName('PRO_CODEMP').AsString,
                              qryGen.FieldByName('PRO_ESPDOC').AsString,
                              qryGen.FieldByName('PRO_NUMCTN').AsString]);

      qryGen.Next();
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadPromocoes.pCarregaProdutoPromocao(strCodIte: String);
  Var
    strCodPro : String;

begin
  strCodPro := fRetornaCodPro(strCodIte, VS_strCodEmp, vs_Date, qryTabela );

  If Not fEmptyStr(strCodPro) Then
  Begin
    fCarregaPromocao(strCodPro);
    pAfterScroll(Nil);
    rdgPreDes.Enabled  := False;
    rdgComPro.Enabled  := False;
    rdgQtdLim.Enabled  := False;
    pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
    pCarregaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);

    pSetFocus(btnAlterar);
  End;

end;

procedure TfrmCadPromocoes.pCarregaTabelasDesAdi(strTabPre: String);
  Var
    strTabPrePro : String;
    intCnt : Integer;
begin
  strTabPrePro := fGetTabelasPrecoSelecionadas;

  cmbTabPre.Items.Clear;

  For intCnt := 1 To Length(strTabPrePro) Do
  Begin
    If strTabPrePro[intCnt] = 'S' Then
      cmbTabPre.Items.Add(IntToStr(intCnt));
  End;

  If (Not fEmptyStr(strTabPre)) And
     (cmbTabPre.Items.IndexOf(strTabPre) >=0) Then
    cmbTabPre.ItemIndex := cmbTabPre.Items.IndexOf(strTabPre)
  Else
    cmbTabPre.ItemIndex := -1
end;

procedure TfrmCadPromocoes.pCarregaValoresCusto(strCodIte, strCodEmp, strTabPre: String);
begin

  FillChar(recCustoItem, SizeOf(recCustoItem), #0);

  If Not Assigned(objCustoItem) Then
    Exit;

  recCustoItem := objCustoItem.Get(strCodIte, strCodEmp, strTabPre);

end;

Function TfrmCadPromocoes.fCodCli: String;
  Var
    intRecNo: Integer;
Begin
  Result := '';

  With cdsProCli Do
  Begin
    DisableControls;
    intRecNo := RecNo;

    First;
    While Not Eof Do
    Begin
      Result := Result + '_' + FieldByName('PRO_CODCLI').AsString;
      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
End;

function TfrmCadPromocoes.fCriaCdsPCMPRO: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRO_NUMPED';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRO_CODEMP';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRO_ESPDOC';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PRO_NUMCTN';
    DataType := ftInteger;
  End;

  Result.CreateDataSet();
end;

function TfrmCadPromocoes.fDigitaComissaoTodosProdutos(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    frmCadDadosComPromocao : TfrmCadDadosComPromocao;
begin
  Try
    Result := False;

    pCriarFormularios(TfrmCadDadosComPromocao, frmCadDadosComPromocao);
    frmCadDadosComPromocao.edtComVar.Text := '0,00';
    frmCadDadosComPromocao.edtComAta.Text := '0,00';
    frmCadDadosComPromocao.edtComDis.Text := '0,00';
    pSetFocus(frmCadDadosComPromocao.edtComVar);
    frmCadDadosComPromocao.ShowModal;

    If frmCadDadosComPromocao.blnConfirma Then
    Begin
      pInfoStatusGravacao(pgbStatus, 'Aguarde, Atualizando Comissões...', cdsCadPro.RecordCount);

      With cdsCadPro Do
      Begin
        First;
        While Not Eof Do
        Begin
          pStepStatusGravacao(pgbStatus);

          Edit;
          FieldByName('IPR_COMVAR').AsFloat := fStrToFloat(frmCadDadosComPromocao.edtComVar.Text);
          FieldByName('IPR_COMATA').AsFloat := fStrToFloat(frmCadDadosComPromocao.edtComAta.Text);
          FieldByName('IPR_COMDIS').AsFloat := fStrToFloat(frmCadDadosComPromocao.edtComDis.Text);
          Post;

          Next;
        End;
      End;

      cxgItens.Refresh;
      Result := True;
    End;
  Finally
    pFreeAndNil(frmCadDadosComPromocao);
  End;
end;

function TfrmCadPromocoes.fEhPromocaoPorQuantidadeMinimaEscalonada: Boolean;
begin

  Result := True;

  If (TTipDescPro(rdgPreDes.ItemIndex) = tdpPrecoPorQuantidadeMinimaEscalonada) Then
    Exit;

  If (TTipDescPro(rdgPreDes.ItemIndex) = tdpPercentualPorQuantidadeMinimaEscalonada) Then
    Exit;

  Result := False;

end;

function TfrmCadPromocoes.fEnabledRdgQtdLim(
  const opcPreDes: TTipDescPro): Boolean;
begin
  Result := ((Not edtQtdLim.ReadOnly) And edtQtdLim.Enabled) Or
      (opcPreDes In [tdpEstoqueRemanescente, tdpNegociacaoEspecialFornecedorPC]);
end;

function TfrmCadPromocoes.fExcluirPromocao(pgbStatus: TcxProgressBar): Boolean;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Excluindo Itens Promoção...', cdsCadPro.RecordCount);

  SetLength(FArrLogIpr, 0);

  While Not cdsCadPro.Eof Do
  Begin
    pStepStatusGravacao(pgbStatus);
    pAlteraStatusTemp('D');
   // Next não é necessário aqui.
  End;

  pInsereDEL_ITEPRO;
  pInsereDEL_PROEMP;
  pInsereDEL_CNDPRO;
  pInsereDEL_PROCLI;

  pInsereLog('', strCodEmpExc, strTabSelExc);
  pGravaLog(strCodProExc);
  pDeletaTemporaria;

  edtNomCli.Clear;
  blnExcluiu := False;
  cdsProCli.EmptyDataSet;
  cdsPCMPRO.EmptyDataSet();

  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
  pAfterScroll(Nil);

  FProLog.ExecutarLogPromocao(strCodProExc);

  Result := True;
end;

function TfrmCadPromocoes.fExibeMsgVerificacaoPromocao(blnPromoc: Boolean;
  strMsgPro, strMsgCli: String): Boolean;
begin
  Result := True;

  If Not fEmptyStr(strMsgPro) Then
  Begin
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);

      If Not fEmptyStr(strMsgCli) Then
      Begin
        frmObservacao.lblMensagem.Caption := 'Os itens abaixo já estão incluidos para esse cliente em outras promoções' + fMsgTabloid() + ' vigentes:';
        frmObservacao.memObs.Texto := 'Cliente: ' + Chr(13) + strMsgCli + Chr(13) + Chr(13) + 'Produtos: ' + Chr(13) + strMsgPro;
      End
      Else
      Begin
        If blnPromoc Then
          frmObservacao.lblMensagem.Caption := 'Promoção não incluida! '
        Else
          frmObservacao.lblMensagem.Caption := 'Cliente não incluído! ';

        frmObservacao.lblMensagem.Caption := frmObservacao.lblMensagem.Caption + 'O(s) item(s) abaixo já estão em outras promoções' + fMsgTabloid() + ' vigentes:';
        frmObservacao.memObs.Texto := strMsgPro;
      End;

      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadPromocoes.btnGravarClick]');
      End;
    End;

    pFreeAndNil(frmObservacao);

    Result := False;
  End;
end;

function TfrmCadPromocoes.fGravarPromocao(pgbStatus: TcxProgressBar): Boolean;
 Var
    strDesPro: String;
    strCodCli: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
    strMsgCli: String;
    strMsgPro: String;
    strMsgCliFinal: String;
    strMsgProFInal: String;
    prcScroll: TprcScroll;
    strEmpresasSelecionadas: String;
    strTabelasPrecoSelecionadas: String;
    strMsgCnd: String;
    strMsgCndFinal: String;
    LarrItens     : TArrTipoMatrizItensPromo;
    LGravouItePro : Boolean;
    blnPrecoFixoTintaDeMaquinaImobiliaria : Boolean;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

  SetLength(FArrLogIpr, 0);

  {**********************************************}
  {* VERIFICA SE ALGUMA EMPRESA FOI SELECIONADA *}
  {*******************************************LU*}
  Result := False;

  strDesPro := dbeDesPro.Text;
  dtaDtaIni := StrToDate(dbeDtaIni.Text);
  dtaDtaFin := StrToDate(dbeDtaFin.Text);

  pnlInfo.Caption := 'Gerando Registros!!!';

  Try

    pDisableControls(cdsCadPro, prcScroll);

    {***************************************************************************}
    {* ANTES DE GRAVAR OS ITENS VERIFICA NOVAMENTE SE ELES NÃO ESTAO EM OUTRAS *}
    {* PROMOÇÕES VIGENTES - FOI NECESSÁRIO VERIFICAR AQUI NOVAMENTE POR CAUSA  *}
    {* DA INCLUSAO DA OPÇÃO DE HERANÇA DE PROMOÇÃO                             *}
    {************************************************************************LU*}
    strMsgCliFinal := '';
    strMsgProFinal := '';

    strCodCli := fCodCli;
    pInfoStatusGravacao(pgbStatus, 'Aguarde... Validando Itens...', cdsCadPro.RecordCount);

    If Assigned(FObjGravaItePro) Then
      FreeAndNil(FObjGravaItePro);

    cdsCadPro.LogChanges := False;

    FObjGravaItePro := TGravaItePro.Create;

    cdsCadPro.First;

    strEmpresasSelecionadas := fGetEmpresasSelecionadas;
    strTabelasPrecoSelecionadas := fGetTabelasPrecoSelecionadas;

    If fEhPromocaoPorQuantidadeMinimaEscalonada Then
      stlItensQuantidadeMinimaDuplicado.Clear;

    While Not cdsCadPro.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);

      blnPrecoFixoTintaDeMaquinaImobiliaria := False;
      If (fTipoDePromocaoSuportaPrecoFixoParaTmqImo) Then
        blnPrecoFixoTintaDeMaquinaImobiliaria := (cdsCadPro.FieldByName('IPR_PFTMIM').AsString = 'S');

      If (Pos(cdsCadPro.FieldByName('IPR_STATUS').AsString, 'A_E_N_') > 0) Then
         (fItemCadastradoPromocao(dbeCodPro.Text,
                                  cdsCadPro.FieldByName('IPR_CODITE').AsString,
                                  strEmpresasSelecionadas,
                                  strCodCli,
                                  strTabelasPrecoSelecionadas,
                                  fGetCndPag,
                                  dtaDtaIni,
                                  dtaDtaFin,
                                  strMsgCli,
                                  strMsgPro,
                                  strMsgCnd,
                                  chkTabloid.Checked));

      If Not fEmptyStr(strMsgCnd) Then
        strMsgCndFinal := strMsgCndFinal + strMsgCnd + #13#10;

      If Not fEmptyStr(strMsgCli) Then
        strMsgCliFinal := strMsgCliFinal + strMsgCli + #13#10;

      If Not fEmptyStr(strMsgPro) Then
        strMsgProFinal := strMsgProFinal + strMsgPro + #13#10;

      If fEmptyStr(strMsgProFinal) Then
        FObjGravaItePro.AddItem(cdsCadPro.FieldByName('IPR_CODITE').AsString,
                                cdsCadPro.FieldByName('IPR_QTDLIM').AsString,
                                cdsCadPro.FieldByName('IPR_QTDMIN').AsString,
                                cdsCadPro.FieldByName('IPR_PRECUS').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVEN').AsFloat,
                                cdsCadPro.FieldByName('IPR_PERDES').AsFloat,
                                cdsCadPro.FieldByName('IPR_PRZMED').AsInteger,
                                cdsCadPro.FieldByName('IPR_COMVAR').AsFloat,
                                cdsCadPro.FieldByName('IPR_COMATA').AsFloat,
                                cdsCadPro.FieldByName('IPR_COMDIS').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE2').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE3').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE4').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE5').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE6').AsFloat,
                                cdsCadPro.FieldByName('IPR_PREVE7').AsFloat,
                                cdsCadPro.FieldByName('IPR_VLDSAD').AsFloat,
                                cdsCadPro.FieldByName('IPR_TBDSAD').AsInteger,
                                cdsCadPro.FieldByName('IPR_PEREST').AsFloat,
                                cdsCadPro.FieldByName('IPR_SEQKIT').AsString,
                                cdsCadPro.FieldByName('IPR_CLIVEN').AsFloat,
                                blnPrecoFixoTintaDeMaquinaImobiliaria);

      If (Not fEmptyStr(cdsCadPro.FieldByName('IPR_STALOG').AsString)) Or
         (strEmpSelAnt <> strEmpresasSelecionadas) Or
         (strTabSelAnt <> strTabelasPrecoSelecionadas) Then
      Begin
        If fEmptyStr(strMsgProFinal) Then
          pInsereLog(cdsCadPro.FieldByName('IPR_CODITE').AsString,
                     strEmpresasSelecionadas,
                     strTabelasPrecoSelecionadas);
      End;

      If fEhPromocaoPorQuantidadeMinimaEscalonada Then
        If (Not cdsCadPro.FieldByName('IPR_CODITE').AsString.IsEmpty) And (Not cdsCadPro.FieldByName('IPR_QTDMIN').AsString.IsEmpty) Then
          pValidaSeItemJaCadastradoQtdMin(cdsCadPro.FieldByName('IPR_CODITE').AsString, cdsCadPro.FieldByName('IPR_QTDMIN').AsFloat);

      cdsCadPro.Next;
    End;

    If fEhPromocaoPorQuantidadeMinimaEscalonada Then
    Begin
      If (stlItensQuantidadeMinimaDuplicado.Count > 0) Then
      Begin
        fMensagem('Atenção!', MSG_DIVERGENCIA_QTDMIN + #13 + stlItensQuantidadeMinimaDuplicado.Text, ['&Ok']);
        pEnableControls(cdsCadPro, prcScroll);
        Exit(False);
      End;
    End;

    If fEmptyStr(strMsgProFinal) Then
      pInsereLog('', strEmpresasSelecionadas, strTabelasPrecoSelecionadas, pgbStatus);

    cdsCadPro.First;

    If Not fEmptyStr(strMsgProFinal) Then
    Begin
      Result := False;

      Try
        pCriarFormularios(TfrmObservacao, frmObservacao);

        If Not fEmptyStr(strMsgCndFinal) then
        Begin
          frmObservacao.lblMensagem.Caption := 'Os itens abaixo já estão incluidos para esse cliente e condição de pagamento em outras promoções' + fMsgTabloid() + ' vigentes:';
          frmObservacao.memObs.Texto := 'Cliente: ' + Chr(13) + strMsgCliFinal + Chr(13) + Chr(13) + 'Condição de Pagamento: ' + Chr(13) + strMsgCndFinal + Chr(13) + Chr(13) + 'Produtos: ' + Chr(13) + strMsgProFinal;
        End
        Else
        If Not fEmptyStr(strMsgCliFinal) Then
        Begin
          frmObservacao.lblMensagem.Caption := 'Os itens abaixo já estão incluidos para esse cliente em outras promoções' + fMsgTabloid() + ' vigentes:';
          frmObservacao.memObs.Texto := 'Cliente: ' + Chr(13) + strMsgCliFinal + Chr(13) + Chr(13) + 'Produtos: ' + Chr(13) + strMsgProFinal;
        End
        Else
        Begin
          frmObservacao.lblMensagem.Caption := 'Promoção não incluída! O(s) item(s) abaixo já estão em outras promoções' + fMsgTabloid() + ' vigentes:';
          frmObservacao.memObs.Texto := strMsgProFinal;
        End;

        frmObservacao.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmCadPromocoes.btnGravarClick]');
        End;
      End;

      pFreeAndNil(frmObservacao);

      pnlInfo.Caption := '';
      pEnableControls(cdsCadPro, prcScroll);

      Exit;
    End;

    {********************************}
    {* COMEÇA A GRAVAR AS PROMOÇÕES *}
    {*****************************LU*}
    if (not FblnAutomatizada) then
      fStartTransaction;
    pDeletaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Promoção...');

    pInsereDEL_ITEPRO;

    If qryTabela.State = dsBrowse Then
      qryTabela.Insert;

    If qryTabela.State = dsInsert Then
    Begin
      qryTabela.FieldByName('PRO_CODPRO').AsString := fAtualizaProCod('CADPRO', 'PRO_CODPRO', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := Concat(VS_strCodEmp, AValue);
        end
      );
      qryTabela.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADPRO', VS_strCodEmp);
    End;

    If qryTabela.FindField('PRO_CODEMP') <> Nil Then
      qryTabela.FieldByName('PRO_CODEMP').AsString := VS_strCodEmp;

    qryTabela.FieldByName('PRO_DESPRO').AsString   := strDesPro;
    qryTabela.FieldByName('PRO_DTAINI').AsDateTime := dtaDtaIni;
    qryTabela.FieldByName('PRO_DTAFIN').AsDateTime := dtaDtaFin;

    Case TTipDescPro(rdgPreDes.ItemIndex) Of
      tdpPrecos,
      tdpPrecoPorQuantidadeMinimaEscalonada,
      tdpPrecosDescAdicional,
      tdpPrecoQuantidadeColetiva,
      tdpPrecoPorVlrMinProd: qryTabela.FieldByName('PRO_PREDES').AsString := 'P';
      tdpDescon,
      tdpPercentualPorQuantidadeMinimaEscalonada,
      tdpPorcentoDescontoComDescontoAdicional,
      tdpPorcentoDescontoQuantidadeColetiva,
      tdpPromocaoCompostaPorKit,
      tdpDescPorVlrMinProd: qryTabela.FieldByName('PRO_PREDES').AsString := 'D';
    End;

    If (rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecosDescAdicional]) Then
      qryTabela.FieldByName('PRO_DESADI').AsString := 'S'
    Else
      qryTabela.FieldByName('PRO_DESADI').AsString := 'N';

    qryTabela.FieldByName('PRO_IDXPRO').AsInteger := rdgPreDes.ItemIndex;

    qryTabela.FieldByName('PRO_ENTIME').AsString   := IIF(chkEntIme.Checked,       'S', 'N');
    qryTabela.FieldByName('PRO_ENTFUT').AsString   := IIF(chkEntFut.Checked,       'S', 'N');
    qryTabela.FieldByName('PRO_AGUCLI').AsString   := IIF(chkAguCli.Checked,       'S', 'N');
    qryTabela.FieldByName('PRO_PREVIS').AsString   := IIF(chkPrevis.Checked,       'S', 'N');
    qryTabela.FieldByName('PRO_FALPRO').AsString   := IIF(chkFalPro.Checked,       'S', 'N');
    qryTabela.FieldByName('PRO_ECOMME').AsString   := IIF(chkEcommerce.Checked,    'S', 'N');
    qryTabela.FieldByName('PRO_TABPRE').AsString   := fGetTabelasPrecoSelecionadas;
    qryTabela.FieldByName('PRO_COMPRO').AsString   := IIF(rdgComPro.ItemIndex = 0, 'P', 'V');
    qryTabela.FieldByName('PRO_IDXQTD').AsInteger  := rdgQtdLim.ItemIndex;

    PromocaoUtilizaLimite := TPromocaoUtilizaLimite(rdgUtilizarLimitePorClienteOuVenda.ItemIndex);

    qryTabela.FieldByName('PRO_UTILIM').AsString   := IIF(chkUtilizarLimitePorClienteOuVenda.Checked,   'S', 'N');
    qryTabela.FieldByName('PRO_LIMCLI').AsString   := IIF(PromocaoUtilizaLimite = pulLimitarPorCliente, 'S', 'N');
    qryTabela.FieldByName('PRO_LIMVEN').AsString   := IIF(PromocaoUtilizaLimite = pulLimitarPorVenda,   'S', 'N');

    If ckbTipoCliente.Checked Then
      qryTabela.FieldByName('PRO_TIPCLI').AsString := IIF(rdgTipoCliente.ItemIndex = 0, 'J', 'F')
    Else
      qryTabela.FieldByName('PRO_TIPCLI').Clear;

    qryTabela.FieldByName('PRO_TIPPVM').AsInteger  := rdgConsideraVlrMin.ItemIndex;

    qryTabela.Post;

    If blnImpPC Then
      pGravarPedidosCompraImportados(qryTabela.FieldByName('AUTOINCREM').AsString);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Clientes...', cdsProCli.RecordCount);
    pGravaClientesPromocao(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Deletando Itens Promoção...');
    pDeletaItensPromocao(qryTabela.FieldByName('AUTOINCREM').AsString, LarrItens);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Log Itens Promoção...');

    pGravaLog(qryTabela.FieldByName('PRO_CODPRO').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Itens Promoção...', cdsCadPro.RecordCount);

    FObjGravaItePro.SequencialPromocao := qryTabela.FieldByName('AUTOINCREM').AsString;

    PromocaoUtilizaLimite := TPromocaoUtilizaLimite(rdgUtilizarLimitePorClienteOuVenda.ItemIndex);

    If (PromocaoUtilizaLimite = pulLimitarPorCliente) And (LarrItens <> Nil) Then
      LGravouItePro := FObjGravaItePro.Gravar(pgbStatus, LarrItens)
    Else
      LGravouItePro := FObjGravaItePro.Gravar(pgbStatus, Nil);

    If (Not LGravouItePro) Then
    Begin
      if (not FblnAutomatizada) then
        fRollBack;
      fMensagem('','Ocorreu um erro na gravação da ITEPRO!', ['&OK']);
      pEnableControls(cdsCadPro, prcScroll);
      Exit;
    End;

    pGravarCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Empresas...', clbEmpresa.Items.Count);
    pGravarEmpresas(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pGravarQtdDisponivel(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pAtualizarQtdDisponivelPromocao(qryTabela.FieldByName('AUTOINCREM').AsString,
                                    qryTabela.FieldByName('PRO_IDXQTD').AsString = '1', pgbStatus);

    pEnableControls(cdsCadPro, prcScroll);

    pnlInfo.Caption := '';

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Log Promoção...');
    FProLog.ExecutarLogPromocao(qryTabela.FieldByName('PRO_CODPRO').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Gravação da Promoção Concluída... Carregando Dados.');

    If rdgPreDes.ItemIndex = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] then
    Begin
      if not FObjKitPromocaoBuilder.fSalvar(qryTabela.FieldByName('AUTOINCREM').AsString) then
      Begin
        if (not FblnAutomatizada) then
          fRollBack;
        fMensagem('','Ocorreu um erro na gravação dos kits da promoção!', ['&OK']);
        Exit;
      End;
    End;

    if (not FblnAutomatizada) then
      fCommit;

    pDeletaTemporaria;
    fCarregaPromocao(dbeCodPro.Text);
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela, btnAlterar, btnPesquisa, btnSair);
    pEnabled(Self, False);
    pSetFocus(btnIncluir);
    pAfterScroll(Nil);
    rdgPreDes.Enabled  := False;
    rdgComPro.Enabled  := False;
    rdgQtdLim.Enabled  := False;

    pEnableDisableBtnAtuEmLote(False);

    pgcDados.ActivePageIndex := 0;
  Except
    On E: Exception Do
    Begin
      if (not FblnAutomatizada) then
        fRollBack;
      pEnableControls(cdsCadPro, prcScroll);
      pnlInfo.Caption := '';
      pMensagensErro(E.Message, '[TfrmCadPromocoes.btnGravarClick]');
    End;
  End;

  btnHeranca.Enabled := False;
  pTratarBotoes();
end;

function TfrmCadPromocoes.fVerificaCamposTela: Boolean;
begin
  Result := Self.fVerificaCampos();
end;

function TfrmCadPromocoes.fVerificaEmpresas: Boolean;
begin
  Result := True;

  If (TTipDescPro(rdgPreDes.ItemIndex) In [tdpEstoqueRemanescente, tdpNegociacaoEspecialFornecedorPC]) Then
  Begin
    If fGetEmpresasSelecionadas = EmptyStr Then
    Begin
      fMensagem('AVISO','Selecione a(s) empresa(s) para a promoção.', ['&OK']);
      pSetFocus(clbEmpresa);
      Result := False;
    End;

    If (rdgQtdLim.ItemIndex = 0) Then
    Begin
      If fGetQtdeEmpresasSelecionadas > 1 Then
      Begin
        fMensagem('AVISO', 'Quando a promoção for por ' + rdgPreDes.Items[rdgPreDes.ItemIndex] +
                           ', ao utilizar "Aplicar quantidade disponível desta promoção '+
                           ' para cada empresa participante da promoção", deve ser '+
                           ' selecionada apenas uma empresa por promoção. ', ['&OK']);
        pSetFocus(clbEmpresa);
        Result := False;
      End;
    End;
  End;
end;

function TfrmCadPromocoes.fVerificaProdutos(pgbStatus: TcxProgressBar): String;
var
  strCodIte: String;
begin
  if Assigned(pgbStatus) then
    pInfoStatusGravacao(pgbStatus, 'Aguarde, Verificando produto(s)...', cdsCadPro.RecordCount);

  strCodIte := '';
  cdsCadPro.DisableControls;
  try
    cdsCadPro.First;

    While Not cdsCadPro.Eof Do
    Begin
      if Assigned(pgbStatus) then
        pStepStatusGravacao(pgbStatus);

      strCodIte := strCodIte + QuotedStr(cdsCadPro.FieldByName('IPR_CODITE').AsString) + ',';
      cdsCadPro.Next;
    End;
  finally
    cdsCadPro.EnableControls;
  end;

  If Not fEmptyStr(strCodIte) Then
  Begin
    If strCodIte[Length(strCodIte)] = ',' Then
    Begin
      strCodIte[Length(strCodIte)] := ' ';
      strCodIte := Trim(strCodIte);
    End;
  End;

  Result := strCodIte;
end;

function TfrmCadPromocoes.fTemProdutosRelacionadosATinta;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    pCloneDataSet(cdsClone, cdsCadPro);
    cdsClone.Filter := '(ITE_ITEBAS = ' + QuotedStr('S') + ') OR (ITE_ITEPIG = ' + QuotedStr('S') + ') OR (ITE_PROEMB = ' + QuotedStr('S') + ') OR (ITE_CNV_ML > 0)';
    cdsClone.Filtered := True;
    Result := (Not cdsClone.IsEmpty);
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCadPromocoes.fVerificaProdutoTintaMaquina: Boolean;
  Var
    blnTemProdutosTinta : Boolean;
begin
  blnTemProdutosTinta := False;
  fExecutarModal(procedure
  begin
    blnTemProdutosTinta := fTemProdutosRelacionadosATinta;
  end, 'Aguarde, Verificando produtos tinta de máquina...', '');
  Result := blnTemProdutosTinta;
end;

Function TfrmCadPromocoes.fVerificaPromocoes(Var strMensagem: String; strCodCli, strProAut: String; blnPromoc,
  blnExibeMsg: Boolean; strCodIte, strEmpresasSelecionadas, strTabelasPrecoSelecionadas: String): Boolean;
  Var
    dtaDtaIni,
    dtaDtaFin: TDate;
    strMsgPro: String;
    strMsgCli: String;
    strMsgCnd: String;
Begin
  dtaDtaIni := StrToDateDef(dbeDtaIni.Text, 0);
  dtaDtaFin := StrToDateDef(dbeDtaFin.Text, 0);
  strMensagem := '';

  fItemCadastradoPromocao(strProAut,
                          strCodIte,
                          strEmpresasSelecionadas,
                          strCodCli,
                          strTabelasPrecoSelecionadas,
                          fGetCndPag,
                          dtaDtaIni,
                          dtaDtaFin,
                          strMsgCli,
                          strMsgPro,
                          strMsgCnd,
                          chkTabloid.Checked);

  If blnExibeMsg Then
    Result := fExibeMsgVerificacaoPromocao(blnPromoc, strMsgPro, strMsgCli)
  Else
  Begin
    Result := fEmptyStr(strMsgCli);
    strMensagem := strMsgCli + #13#10;
  End;
End;

procedure TfrmCadPromocoes.pInsereCliente;
begin

  pCriarFormularios(TfrmGravando, frmGravando);

  Try

    Try
      frmGravando.fExecutarAcao := fInsereCliente;
      frmGravando.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;

  Finally
    pFreeAndNil(frmGravando);
  End;

End;

procedure TfrmCadPromocoes.rdgGiroEstoqClick(Sender: TObject);
begin

  inherited;

  case TRadioGroup(Sender).ItemIndex of

    0: begin
         if ckbSaldoZero.checked then
           ckbSaldoZero.checked := false;
       end;
    1: begin
         if ckbSaldoZero.checked then
           ckbSaldoZero.checked := false;
       end;
    2: begin
         if ckbSaldoZero.checked then
           ckbSaldoZero.checked := true;
       end;
    3: begin
         if ckbSaldoZero.checked then
           ckbSaldoZero.checked := false;
       end;

  end;

  chkQtdLimiteSalDis.Enabled := (TRadioGroup(Sender).ItemIndex <> 0);
  chkQtdMinimaSalDis.Enabled := (TRadioGroup(Sender).ItemIndex <> 0);

  mskDtaGiroIni.Enabled := (TRadioGroup(Sender).ItemIndex <> 0);
  mskDtaGiroFim.Enabled := (TRadioGroup(Sender).ItemIndex <> 0);

end;

procedure TfrmCadPromocoes.rdgComProClick(Sender: TObject);
begin
  inherited;
  If (rdgComPro.ItemIndex = 1) then
  begin
    pDisableEdit(edtComVar);
    pDisableEdit(edtComAta);
    pDisableEdit(edtComDis);
  end
  else
  begin
    pEnabledEdit(edtComVar);
    pEnabledEdit(edtComAta);
    pEnabledEdit(edtComDis);
  end;

  If (not btnAlterar.Enabled) And ( not cdsCadPro.isEmpty) And (rdgComPro.ItemIndex = 1) then
    If fMensagem('ATENÇÃO!', 'A opção "Considerar comissão definida nas configurações do sistema",'+
                             ' vai zerar as comissões de todos os itens dessa promoção.'+#13+
                             'Deseja continuar?', ['&Sim', '&Não']) = 1 Then
      pZeraComissao
    Else
      rdgComPro.ItemIndex := 0;

end;

procedure TfrmCadPromocoes.pInsereLog(strCodIte, strEmpSel, strTabSel: String; pgbStatus: TcxProgressBar = nil);
  Var
    cdsProAux: TUniClientDataSet;

  procedure pInsert(cdsCadPro : TUniClientDataSet);
    Var
      LLogIpr: TLogIpr;
  Begin
    With cdsCadPro do
    Begin
      LLogIpr.IPR_DTALOG := Date;
      LLogIpr.IPR_HORLOG := fTime();
      LLogIpr.IPR_CODVEN := strLoginUsuarioLogado;
      LLogIpr.IPR_STATUS := IIF(fEmptyStr(FieldByName('IPR_STALOG').AsString), 'A', FieldByName('IPR_STALOG').AsString);
      LLogIpr.IPR_CODEMP := strEmpSel;
      LLogIpr.IPR_TABPRE := strTabSel;
      LLogIpr.IPR_CODITE := FieldByName('IPR_CODITE').AsString;
      LLogIpr.IPR_PRECUS := FieldByName('IPR_PRECUS').AsFloat;
      LLogIpr.IPR_PREVEN := FieldByName('IPR_PREVEN').AsFloat;
      LLogIpr.IPR_COMVAR := FieldByName('IPR_COMVAR').AsFloat;
      LLogIpr.IPR_PRZMED := FieldByName('IPR_PRZMED').AsInteger;
      LLogIpr.IPR_COMATA := FieldByName('IPR_COMATA').AsFloat;
      LLogIpr.IPR_COMDIS := FieldByName('IPR_COMDIS').AsFloat;
      LLogIpr.IPR_QTDLIM := FieldByName('IPR_QTDLIM').AsFloat;
      LLogIpr.IPR_PERDES := FieldByName('IPR_PERDES').AsFloat;
      LLogIpr.IPR_QTDMIN := FieldByName('IPR_QTDMIN').AsFloat;
      LLogIpr.IPR_PREVE2 := FieldByName('IPR_PREVE2').AsFloat;
      LLogIpr.IPR_PREVE3 := FieldByName('IPR_PREVE3').AsFloat;
      LLogIpr.IPR_PREVE4 := FieldByName('IPR_PREVE4').AsFloat;
      LLogIpr.IPR_PREVE5 := FieldByName('IPR_PREVE5').AsFloat;
      LLogIpr.IPR_PREVE6 := FieldByName('IPR_PREVE6').AsFloat;
      LLogIpr.IPR_PREVE7 := FieldByName('IPR_PREVE7').AsFloat;
      LLogIpr.IPR_PEREST := FieldByName('IPR_PEREST').AsFloat;
      LLogIpr.IPR_DESPRO := qryTabela.FieldByName('PRO_DESPRO').AsString;
      LLogIpr.IPR_DTAINI := qryTabela.FieldByName('PRO_DTAINI').AsDateTime;
      LLogIpr.IPR_DTAFIN := qryTabela.FieldByName('PRO_DTAFIN').AsDateTime;
      LLogIpr.IPR_COMPRO := qryTabela.FieldByName('PRO_COMPRO').AsString;
      LLogIpr.IPR_IDXQTD := qryTabela.FieldByName('PRO_IDXQTD').AsInteger;
      LLogIpr.IPR_ENTIME := qryTabela.FieldByName('PRO_ENTIME').AsString;
      LLogIpr.IPR_ENTFUT := qryTabela.FieldByName('PRO_ENTFUT').AsString;
      LLogIpr.IPR_TABLOI := qryTabela.FieldByName('PRO_TABLOI').AsString;
      SetLength(FArrLogIpr, Length(FArrLogIpr) + 1);
      FArrLogIpr[Length(FArrLogIpr)-1] := LLogIpr;
    End;
  End;

Begin

  If (fEmptyStr(strCodIte)) then
  Begin
    cdsProAux      := TUniClientDataSet.Create(Self);
    cdsProAux.Data := cdsCadPro.Data;

    With cdsProAux do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := ' IPR_STATUS = ' + QuotedStr('D');
      Filtered := True;

      pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Log Itens...', RecordCount);

      First;

      While Not Eof Do
      Begin
        If pgbStatus <> Nil Then
          pStepStatusGravacao(pgbStatus);

        pInsert(cdsProAux);
        Next;
      End;

      EnableControls;
    End;

    If Assigned(cdsProAux) Then
      FreeAndNil(cdsProAux);
  End
  Else
    pInsert(cdsCadPro);
end;

procedure TfrmCadPromocoes.pInsereDEL_ITEPRO;
  Var
    qryInsert: TUniQuery;
    cdsProAux: TUniClientDataSet;

Begin

  Try

    cdsProAux      := TUniClientDataSet.Create(Self);
    cdsProAux.Data := cdsCadPro.Data;

    With cdsProAux do
    Begin
      DisableControls;
      Filtered := False;
      Filter   := ' IPR_STATUS = ' + QuotedStr('D');
      Filtered := True;
      First;

      qryInsert := fCriaQuery(Self);

      While Not Eof Do
      Begin
        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        Begin
          Next;
          Continue;
        End;

        qryInsert.SQL.Clear;
        qryInsert.SQL.Add ( 'REPLACE INTO DEL_ITEPRO ( ' );
        qryInsert.SQL.Add ( '  IPR_SEQGER, ');
        qryInsert.SQL.Add ( '  AUTOINCREM, ');
        qryInsert.SQL.Add ( '  IPR_CODITE, ');
        qryInsert.SQL.Add ( '  IPR_PRECUS, ');
        qryInsert.SQL.Add ( '  IPR_PREVEN, ');
        qryInsert.SQL.Add ( '  IPR_COMVAR, ');
        qryInsert.SQL.Add ( '  IPR_PRZMED, ');
        qryInsert.SQL.Add ( '  IPR_CODEMP, ');
        qryInsert.SQL.Add ( '  IPR_COMATA, ');
        qryInsert.SQL.Add ( '  IPR_QTDLIM, ');
        qryInsert.SQL.Add ( '  IPR_QTDMIN, ');
        qryInsert.SQL.Add ( '  IPR_PERDES, ');
        qryInsert.SQL.Add ( '  IPR_COMDIS, ');
        qryInsert.SQL.Add ( '  OPEDEL    , ');
        qryInsert.SQL.Add ( '  DTADEL    , ');
        qryInsert.SQL.Add ( '  HORDEL    , ');
        qryInsert.SQL.Add ( '  IPR_PREVE2, ');
        qryInsert.SQL.Add ( '  IPR_PREVE3, ');
        qryInsert.SQL.Add ( '  IPR_PREVE4, ');
        qryInsert.SQL.Add ( '  IPR_PREVE5, ');
        qryInsert.SQL.Add ( '  IPR_PREVE6, ');
        qryInsert.SQL.Add ( '  IPR_PREVE7, ');
        qryInsert.SQL.Add ( '  IPR_VLDSAD, ');
        qryInsert.SQL.Add ( '  IPR_TBDSAD, ');
        qryInsert.SQL.Add ( '  IPR_ULTALT, ');
        qryInsert.SQL.Add ( '  IPR_PEREST) ');

        qryInsert.SQL.Add ( '  VALUES ( ');

        qryInsert.SQL.Add ( '  :SEQGER, ');
        qryInsert.SQL.Add ( '  :AUTOIN, ');
        qryInsert.SQL.Add ( '  :CODITE, ');
        qryInsert.SQL.Add ( '  :PRECUS, ');
        qryInsert.SQL.Add ( '  :PREVEN, ');
        qryInsert.SQL.Add ( '  :COMVAR, ');
        qryInsert.SQL.Add ( '  :PRZMED, ');
        qryInsert.SQL.Add ( '  :CODEMP, ');
        qryInsert.SQL.Add ( '  :COMATA, ');
        qryInsert.SQL.Add ( '  :QTDLIM, ');
        qryInsert.SQL.Add ( '  :QTDMIN, ');
        qryInsert.SQL.Add ( '  :PERDES, ');
        qryInsert.SQL.Add ( '  :COMDIS, ');
        qryInsert.SQL.Add ( '  :OPEDEL, ');
        qryInsert.SQL.Add ( '  :DTADEL, ');
        qryInsert.SQL.Add ( '  :HORDEL, ');
        qryInsert.SQL.Add ( '  :PREVE2, ');
        qryInsert.SQL.Add ( '  :PREVE3, ');
        qryInsert.SQL.Add ( '  :PREVE4, ');
        qryInsert.SQL.Add ( '  :PREVE5, ');
        qryInsert.SQL.Add ( '  :PREVE6, ');
        qryInsert.SQL.Add ( '  :PREVE7, ');
        qryInsert.SQL.Add ( '  :VLDSAD, ');
        qryInsert.SQL.Add ( '  :TBDSAD, ');
        qryInsert.SQL.Add ( '  :ULTALT, ');
        qryInsert.SQL.Add ( '  :PEREST )');

        qryInsert.ParambyName('SEQGER').asString := FieldbyName('IPR_SEQGER').asString;
        qryInsert.ParambyName('AUTOIN').asString := FieldbyName('AUTOINCREM').asString;
        qryInsert.ParambyName('CODITE').asString := FieldbyName('IPR_CODITE').asString;
        qryInsert.ParambyName('PRECUS').asFloat := FieldbyName('IPR_PRECUS').asFloat;
        qryInsert.ParambyName('PREVEN').asFloat := FieldbyName('IPR_PREVEN').asFloat;
        qryInsert.ParambyName('COMVAR').asFloat := FieldbyName('IPR_COMVAR').asFloat;
        qryInsert.ParambyName('PRZMED').asInteger := FieldbyName('IPR_PRZMED').asInteger;
        qryInsert.ParambyName('CODEMP').asString := FieldbyName('IPR_CODEMP').asString;
        qryInsert.ParambyName('COMATA').asFloat := FieldbyName('IPR_COMATA').asFloat;
        qryInsert.ParambyName('QTDLIM').asFloat := FieldbyName('IPR_QTDLIM').asFloat;
        qryInsert.ParambyName('QTDMIN').asFloat := FieldbyName('IPR_QTDMIN').asFloat;
        qryInsert.ParambyName('PERDES').asFloat := FieldbyName('IPR_PERDES').asFloat;
        qryInsert.ParambyName('COMDIS').asFloat := FieldbyName('IPR_COMDIS').asFloat;
        qryInsert.ParambyName('PREVE2').asFloat := FieldbyName('IPR_PREVE2').asFloat;
        qryInsert.ParambyName('PREVE3').asFloat := FieldbyName('IPR_PREVE3').asFloat;
        qryInsert.ParambyName('PREVE4').asFloat := FieldbyName('IPR_PREVE4').asFloat;
        qryInsert.ParambyName('PREVE5').asFloat := FieldbyName('IPR_PREVE5').asFloat;
        qryInsert.ParambyName('PREVE6').asFloat := FieldbyName('IPR_PREVE6').asFloat;
        qryInsert.ParambyName('PREVE7').asFloat := FieldbyName('IPR_PREVE7').asFloat;
        qryInsert.ParambyName('VLDSAD').asFloat := FieldbyName('IPR_VLDSAD').asFloat;
        qryInsert.ParambyName('TBDSAD').asInteger := FieldbyName('IPR_TBDSAD').asInteger;
        qryInsert.ParambyName('ULTALT').asDateTime := FieldbyName('IPR_ULTALT').asDateTime;
        qryInsert.ParambyName('PEREST').asFloat := FieldbyName('IPR_PEREST').asFloat;

        qryInsert.ParambyName('OPEDEL').asString := strLoginUsuarioLogado;
        qryInsert.ParambyName('DTADEL').asDate := fRetDataServidor;
        qryInsert.ParambyName('HORDEL').asTime := fRetHoraServidor;

        qryInsert.ExecSQL;

        Next;
      End;

      EnableControls;
    End;

    If Assigned(cdsProAux) Then
      FreeAndNil(cdsProAux);

  Finally

    If Assigned(qryInsert) Then
      FreeAndNil(qryInsert);

  End;

end;

procedure TfrmCadPromocoes.pInsereDEL_PROEMP;
  Var
    qryInsert: TUniQuery;
    intContador: Integer;

Begin

  pMarcarEmpresas(strCodEmpExc);

  qryInsert := fCriaQuery(Self);

  Try

    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin

      If clbEmpresa.Checked[intContador] Then
      Begin
        qryInsert.SQL.Clear;
        qryInsert.SQL.Add ( 'INSERT INTO DEL_PROEMP (');
        qryInsert.SQL.Add ( '  PRO_SEQGER, ');
        qryInsert.SQL.Add ( '  PRO_CODEMP, ');
        qryInsert.SQL.Add ( '  OPEDEL    , ');
        qryInsert.SQL.Add ( '  DTADEL    , ');
        qryInsert.SQL.Add ( '  HORDEL    ) ');

        qryInsert.SQL.Add ( '  VALUES ( ');

        qryInsert.SQL.Add ( '  :SEQGER, ');
        qryInsert.SQL.Add ( '  :CODEMP, ');
        qryInsert.SQL.Add ( '  :OPEDEL, ');
        qryInsert.SQL.Add ( '  :DTADEL, ');
        qryInsert.SQL.Add ( '  :HORDEL )');

        qryInsert.ParambyName('SEQGER').asString := FAutoincremPromocao;
        qryInsert.ParambyName('CODEMP').asString := LeftStr(clbEmpresa.Items[intContador],3);
        qryInsert.ParambyName('OPEDEL').asString := strLoginUsuarioLogado;
        qryInsert.ParambyName('DTADEL').asDate   := fRetDataServidor;
        qryInsert.ParambyName('HORDEL').asTime   := fRetHoraServidor;

        qryInsert.ExecSQL;
      End;
    End;

  Finally
    FreeAndNil(qryInsert);
    pMarcarEmpresas('');
  End;

end;

procedure TfrmCadPromocoes.pInsereDEL_CNDPRO;
  Var
    qryInsert: TUniQuery;

Begin

  qryInsert := fCriaQuery(Self);

  Try

    cdsCndPag.First;

    While Not cdsCndPag.Eof Do
    Begin

      qryInsert.SQL.Clear;
      qryInsert.SQL.Add ( 'INSERT INTO DEL_CNDPRO (');
      qryInsert.SQL.Add ( '  CPR_SEQGER, ');
      qryInsert.SQL.Add ( '  CPR_CODCND, ');
      qryInsert.SQL.Add ( '  OPEDEL    , ');
      qryInsert.SQL.Add ( '  DTADEL    , ');
      qryInsert.SQL.Add ( '  HORDEL    ) ');

      qryInsert.SQL.Add ( '  VALUES    ( ');

      qryInsert.SQL.Add ( '  :SEQGER, ');
      qryInsert.SQL.Add ( '  :CODCND, ');
      qryInsert.SQL.Add ( '  :OPEDEL, ');
      qryInsert.SQL.Add ( '  :DTADEL, ');
      qryInsert.SQL.Add ( '  :HORDEL  )');

      qryInsert.ParambyName('SEQGER').asString := FAutoincremPromocao;
      qryInsert.ParambyName('CODCND').asString := cdsCndPag.FieldbyName('CODCND').asString;
      qryInsert.ParambyName('OPEDEL').asString := strLoginUsuarioLogado;
      qryInsert.ParambyName('DTADEL').asDate   := fRetDataServidor;
      qryInsert.ParambyName('HORDEL').asTime   := fRetHoraServidor;

      qryInsert.ExecSQL;

      cdsCndPag.Next;
    End;

  Finally
    FreeAndNil(qryInsert);
  End;

end;

procedure TfrmCadPromocoes.pInsereDEL_PROCLI;
  Var
    qryInsert: TUniQuery;

Begin

  qryInsert := fCriaQuery(Self);

  Try

    cdsProCli.First;

    While Not cdsProCli.Eof Do
    Begin

      qryInsert.SQL.Clear;
      qryInsert.SQL.Add ( 'INSERT INTO DEL_PROCLI (');
      qryInsert.SQL.Add ( '  PRO_SEQGER, ');
      qryInsert.SQL.Add ( '  PRO_CODCLI, ');
      qryInsert.SQL.Add ( '  OPEDEL    , ');
      qryInsert.SQL.Add ( '  DTADEL    , ');
      qryInsert.SQL.Add ( '  HORDEL    ) ');

      qryInsert.SQL.Add ( '  VALUES    ( ');

      qryInsert.SQL.Add ( '  :SEQGER, ');
      qryInsert.SQL.Add ( '  :CODCLI, ');
      qryInsert.SQL.Add ( '  :OPEDEL, ');
      qryInsert.SQL.Add ( '  :DTADEL, ');
      qryInsert.SQL.Add ( '  :HORDEL )');

      qryInsert.ParambyName('SEQGER').asString := FAutoincremPromocao;
      qryInsert.ParambyName('CODCLI').asString := cdsProCli.FieldbyName('PRO_CODCLI').asString;
      qryInsert.ParambyName('OPEDEL').asString := strLoginUsuarioLogado;
      qryInsert.ParambyName('DTADEL').asDate   := fRetDataServidor;
      qryInsert.ParambyName('HORDEL').asTime   := fRetHoraServidor;

      qryInsert.ExecSQL;

      cdsProCli.Next;
    End;

  Finally
    FreeAndNil(qryInsert);
  End;

end;

function TfrmCadPromocoes.fValidarItensIncluidos(qryItens: TUniQuery): Boolean;
var
  frmCadPromocoesItensAdd: TfrmCadPromocoesItensAdd;
begin
  Result := False;

  if (rdgGiroEstoq.ItemIndex = 0) then
    Exit(True);

  qryItens.First;
  while not qryItens.Eof do
  begin
    qryItens.Edit;
    qryItens.FieldByName('X_QTDMIN').AsFloat := IIF(Not chkQtdMinimaSalDis.Checked, 1, qryItens.FieldByName('ITE_SALDIS').AsFloat);
    qryItens.FieldByName('X_QTDLIM').AsFloat := IIF(Not chkQtdLimiteSalDis.Checked, 0, qryItens.FieldByName('ITE_SALDIS').AsFloat);
    qryItens.Post;

    qryItens.Next;
  end;
  qryItens.First;

  Try
    Try
      pCriarFormularios(TfrmCadPromocoesItensAdd, frmCadPromocoesItensAdd);
      frmCadPromocoesItensAdd.pSetDados(qryItens);
      Result := frmCadPromocoesItensAdd.ShowModal = MrOk;
    Finally
      pFreeAndNil(frmCadPromocoesItensAdd);
    End;
  Except
    On E:Exception Do
      pMensagensErro(E.Message,'[TfrmCadPromocoes.pValidarItensIncluidos]');
  End;

end;

procedure TfrmCadPromocoes.pVisiblePanelValores(blnVisible: Boolean);
  Var
    qryRetPre : TUniQuery;
    fltIcmsST : Double;
    blnCalcSt : Boolean;
    strTabPre : String;

  Procedure pCalculaPrecosVenda;
    Var
      intIndex : Integer;
  Begin
    For intIndex := 1 To clbTabPre.Items.Count Do
    Begin
      TLabel(FindComponent('lblMarg0'+IntToStr(intIndex))).Caption := '% Mar.Liq ' + IntToStr(intIndex)+ ':';

      pExibeCampoDePrecoPromocional(qryRetPre, intIndex);

      If Not clbTabPre.Checked[intIndex-1] Then
      Begin
        TLabel(FindComponent('lblMarg0'+IntToStr(intIndex))).Visible     := False;
        TEditFocus(FindComponent('edtMarg0'+IntToStr(intIndex))).Visible := False;
      End
      Else
      Begin

        pCarregaValoresCusto(edtCodIte.Text, VS_strCodEmp, IntToStr(intIndex));

        fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                          qryRetPre.FieldByName('ITE_CODABF').AsString,
                                          fPreComLiq(qryRetPre, fStrToFloat(edtDesAdi.Text)),
                                          qryRetPre.FieldByName('ITE_IPIENT').AsFloat,
                                          fRetIcmSai(qryRetPre.FieldByName('ITE_ICMSAI').AsFloat));

        TLabel(FindComponent('lblMarg0'+IntToStr(intIndex))).Visible     := True;
        TEditFocus(FindComponent('edtMarg0'+IntToStr(intIndex))).Visible := True;
        TEditFocus(FindComponent('edtMarg0'+IntToStr(intIndex))).Text := FormatFloat(fMskDigitos(intDecUni),
                                                                         fCalculaPrecoVenda(2,
                                                                                            fRetPreCus(qryRetPre.FieldByName('ITE_PRECUS').AsFloat) + fRetOutValComDespesa(qryRetPre.FieldByName('ITE_OUTVAL').AsFloat,
                                                                                                                                                                           'IPR_PREVE' + intIndex.ToString,
                                                                                                                                                                           'ITE_COMTB' + intIndex.ToString),
                                                                                            qryRetPre.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat * (100 - fStrToFloat(edtPerDes.Text)) / 100,
                                                                                            0,
                                                                                            fRetIcmSai(qryRetPre.FieldByName('ITE_ICMSAI').AsFloat),
                                                                                            fRetImpFed(qryRetPre.FieldByName('ITE_IMPFED').AsFloat),
                                                                                            fRetDesOpe(qryRetPre.FieldByName('ITE_DESOPE').AsFloat),
                                                                                            qryRetPre.FieldByName('ITE_COMTB' + IntToStr(intIndex)).AsFloat,
                                                                                            '',
                                                                                            '',
                                                                                            -1,
                                                                                            fltIcmsST,
                                                                                            blnCalcSt));

      End;
    End;
  End;

begin
  If (blnMovPnl) Then
    pnlRight.Visible := blnVisible;

  If pnlRight.Visible Then
  Begin
    Try
      qryRetPre := fCriaQuery(Self);
      pCarregaQueryDadosItem(qryRetPre);

      With qryRetPre, SQL Do
      Begin
        pCarregaValoresCusto(edtCodIte.Text, VS_strCodEmp, fGetTabPre);

        edtCusRea.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaCustoReal( fRetPreCus(FieldByName('ITE_PRECUS').AsFloat),
                                                                                 fRetIcmSai(FieldByName('ITE_ICMSAI').AsFloat),
                                                                                 fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                                                 fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                                                                 fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat)));

        Case TTipDescPro(rdgPreDes.ItemIndex) Of
          tdpDescon,
          tdpPercentualPorQuantidadeMinimaEscalonada,
          tdpPorcentoDescontoQuantidadeColetiva,
          tdpPromocaoCompostaPorKit,
          tdpNegociacaoEspecialFornecedorPC,
          tdpPrecoPorVlrMinProd : pCalculaPrecosVenda;

          tdpPrecos,
          tdpPrecoPorQuantidadeMinimaEscalonada,
          tdpPrecosDescAdicional,
          tdpPrecoQuantidadeColetiva,
          tdpPorcentoDescontoComDescontoAdicional,
          tdpDescPorVlrMinProd:
          Begin
            lblMarg02.Visible := False;
            edtMarg02.Visible := False;

            lblMarg03.Visible := False;
            edtMarg03.Visible := False;

            lblMarg04.Visible := False;
            edtMarg04.Visible := False;

            lblMarg05.Visible := False;
            edtMarg05.Visible := False;

            lblMarg06.Visible := False;
            edtMarg06.Visible := False;

            lblMarg07.Visible := False;
            edtMarg07.Visible := False;

            pExibeCamposDePrecoPromocao(False);

            lblMarg01.Caption := '% Mar.Liq:';

            fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                              qryRetPre.FieldByName('ITE_CODABF').AsString,
                                              fPreComLiq(qryRetPre, fStrToFloat(edtDesAdi.Text)),
                                              qryRetPre.FieldByName('ITE_IPIENT').AsFloat,
                                              fRetIcmSai(qryRetPre.FieldByName('ITE_ICMSAI').AsFloat));

            strTabPre := fGetTabPre;

            edtMarg01.Text := FormatFloat(fMskDigitos(intDecUni),
                              fCalculaPrecoVenda(2,
                                                 IIF((fStrToFloat(edtPreCus.Text) <> 0), fStrToFloat(edtPreCus.Text), fStrToFloat(edtPreCusCad.Text)) +
                                                 fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat),
                                                 fStrToFloat(edtPreVen.Text),
                                                 0,
                                                 fRetIcmSai(FieldByName('ITE_ICMSAI').AsFloat),
                                                 fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                                 fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                                 FieldByName('ITE_COMTB' + fGetTabPre).AsFloat,
                                                 '',
                                                 '',
                                                 -1,
                                                 fltIcmsST,
                                                 blnCalcSt
                                                 ));

            edtCusRea.Text := FormatFloat(fMskDigitos(intDecUni),
                                fCalculaPrecoCustoRealVenda(fStrToFloat(edtPreVen.Text),
                                            IIF((fStrToFloat(edtPreCus.Text) <> 0), fStrToFloat(edtPreCus.Text), fStrToFloat(edtPreCusCad.Text)),
                                            fRetOutValComDespesa(FieldByName('ITE_OUTVAL').AsFloat,
                                                                       fStrToFloat(edtPreVen.Text),
                                                                       FieldByName('ITE_COMTB' + strTabPre).AsFloat),
                                            fRetIcmSai(FieldByName('ITE_ICMSAI').AsFloat),
                                            fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                            fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                            0,
                                            0));
          End;
        End;
      End;
    Finally
      FreeAndNil(qryRetPre);
    End;
  End;
end;

procedure TfrmCadPromocoes.pOnStateChange;
begin
  inherited;
  pSetEnabledComissao;
  pStatusLegendaCondicoes((Assigned(cdsCndPag)) And (cdsCndPag.Active) And (Not cdsCndPag.IsEmpty));
end;

procedure TfrmCadPromocoes.pSetEnabledComissao;
begin
  edtComVar.Enabled := blnComPro And pnlDadosItem.Enabled;
  edtComAta.Enabled := blnComPro And pnlDadosItem.Enabled;
  edtComDis.Enabled := blnComPro And pnlDadosItem.Enabled;
end;

procedure TfrmCadPromocoes.pGravaClientesPromocao(strSeqGer: String; pgbStatus: TcxProgressBar = Nil);
Var
  LInsert: String;
  LValues: String;
begin
  Try
    LInsert := '';
    LInsert := LInsert + 'INSERT INTO PROCLI ( ';
    LInsert := LInsert + '  PRO_SEQGER, ';
    LInsert := LInsert + '  PRO_CODCLI) VALUES ';

    LValues := '';

    If Assigned(pgbStatus) Then
      pgbStatus.Properties.Max := cdsProCli.RecordCount;

    cdsProCli.DisableControls;
    cdsProCli.First;

    While Not cdsProCli.Eof Do
    Begin
      If LValues <> '' Then
        LValues := LValues + ', ';

      LValues := LValues + '( ' + strSeqGer.QuotedString;
      LValues := LValues + ', ' + cdsProCli.FieldByName('PRO_CODCLI').AsString.QuotedString + ') ';

      If (cdsProCli.RecNo Mod 100 = 0) Or (cdsProCli.RecNo = cdsProCli.RecordCount) Then
      Begin
        If Not fExecutaSQL(LInsert + LValues) Then
          Raise Exception.Create('Não foi possível gravar a tabela PROCLI!');

        If Assigned(pgbStatus) Then
          pgbStatus.Position := cdsProCli.RecNo;

        Application.ProcessMessages;
        LValues := '';
      End;

      cdsProCli.Next;
    End;
  Finally
    cdsProCli.EnableControls;
  End;
End;

procedure TfrmCadPromocoes.pGravaLog(ACodPro: String; pgbStatus: TcxProgressBar);
Var
  LIndex: Integer;
  LInsert: String;
  LValues: String;
  LLogIpr: TLogIpr;
  LAutoincrem: String;
begin
  Application.ProcessMessages;

  Try
    LAutoincrem := fRetAutoIncrem('LOGIPR', VS_strCodEmp, Length(FArrLogIpr));

    LInsert := '';
    LInsert := LInsert + 'INSERT INTO LOGIPR ( ';
    LInsert := LInsert + '  AUTOINCREM, ';
    LInsert := LInsert + '  IPR_CODPRO, ';
    LInsert := LInsert + '  IPR_DTALOG, ';
    LInsert := LInsert + '  IPR_HORLOG, ';
    LInsert := LInsert + '  IPR_CODVEN, ';
    LInsert := LInsert + '  IPR_STATUS, ';
    LInsert := LInsert + '  IPR_CODEMP, ';
    LInsert := LInsert + '  IPR_TABPRE, ';
    LInsert := LInsert + '  IPR_CODITE, ';
    LInsert := LInsert + '  IPR_PRECUS, ';
    LInsert := LInsert + '  IPR_PREVEN, ';
    LInsert := LInsert + '  IPR_COMVAR, ';
    LInsert := LInsert + '  IPR_PRZMED, ';
    LInsert := LInsert + '  IPR_COMATA, ';
    LInsert := LInsert + '  IPR_COMDIS, ';
    LInsert := LInsert + '  IPR_QTDLIM, ';
    LInsert := LInsert + '  IPR_PERDES, ';
    LInsert := LInsert + '  IPR_QTDMIN, ';
    LInsert := LInsert + '  IPR_PREVE2, ';
    LInsert := LInsert + '  IPR_PREVE3, ';
    LInsert := LInsert + '  IPR_PREVE4, ';
    LInsert := LInsert + '  IPR_PREVE5, ';
    LInsert := LInsert + '  IPR_PREVE6, ';
    LInsert := LInsert + '  IPR_PREVE7, ';
    LInsert := LInsert + '  IPR_PEREST, ';
    LInsert := LInsert + '  IPR_DESPRO, ';
    LInsert := LInsert + '  IPR_DTAINI, ';
    LInsert := LInsert + '  IPR_DTAFIN, ';
    LInsert := LInsert + '  IPR_COMPRO, ';
    LInsert := LInsert + '  IPR_IDXQTD, ';
    LInsert := LInsert + '  IPR_ENTIME, ';
    LInsert := LInsert + '  IPR_ENTFUT, ';
    LInsert := LInsert + '  IPR_TABLOI) VALUES ';

    LValues := '';

    If Assigned(pgbStatus) Then
      pgbStatus.Properties.Max := Length(FArrLogIpr);

    For LIndex := Low(FArrLogIpr) To High(FArrLogIpr) Do
    Begin
      LLogIpr := FArrLogIpr[LIndex];

      If LValues <> '' Then
        LValues := LValues + ', ';

      LValues := LValues + '( ' + LAutoincrem.QuotedString;
      LValues := LValues + ', ' + ACodPro.QuotedString;
      LValues := LValues + ', ' + FormatDateTime('yyyy-MM-dd', LLogIpr.IPR_DTALOG).QuotedString;
      LValues := LValues + ', ' + FormatDateTime('hh:mm:ss', LLogIpr.IPR_HORLOG).QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_CODVEN.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_STATUS.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_CODEMP.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_TABPRE.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_CODITE.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_PRECUS.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVEN.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_COMVAR.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PRZMED.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_COMATA.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_COMDIS.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_QTDLIM.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PERDES.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_QTDMIN.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE2.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE3.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE4.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE5.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE6.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PREVE7.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_PEREST.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_DESPRO.QuotedString;
      LValues := LValues + ', ' + FormatDateTime('yyyy-MM-dd', LLogIpr.IPR_DTAINI).QuotedString;
      LValues := LValues + ', ' + FormatDateTime('yyyy-MM-dd', LLogIpr.IPR_DTAFIN).QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_COMPRO.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_IDXQTD.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LLogIpr.IPR_ENTIME.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_ENTFUT.QuotedString;
      LValues := LValues + ', ' + LLogIpr.IPR_TABLOI.QuotedString +  ') ';

      LAutoincrem := fNextAutoIncrem(LAutoincrem);

      If ((LIndex > 0) And (LIndex Mod 100 = 0)) Or (LIndex = High(FArrLogIpr)) Then
      Begin
        If Not fExecutaSQL(LInsert + LValues) Then
          Raise Exception.Create('Não foi possível gravar a tabela LOGIPR!');

        If Assigned(pgbStatus) Then
          pgbStatus.Position := LIndex;

        Application.ProcessMessages;
        LValues := '';
      End;

    End;

    SetLength(FArrLogIpr, 0);

  Finally
    //do something
  End;
end;

procedure TfrmCadPromocoes.pCarregaClientesPromocao(strSeqGer: String);
Begin
  With qryProCli, SQL Do
  Begin
    Close;
    cdsProCli.Close;

    Clear;
    Add('SELECT ');
    Add('  P.*, ');
    Add('  C.CLI_NOMCLI AS PRO_NOMCLI, ');
    Add('  A.ATI_DESATI AS PRO_ATIVID, ');
    Add('  CONCAT(D.CID_NOMCID," - ",D.CID_ESTADO) AS PRO_CIDEST, ');
    Add('  C.CLI_C_G_C_ AS PRO_CGCCPF, ');
    Add('  C.CLI_CATEGO AS PRO_CATEGO  ');
    Add('FROM ');
    Add('  PROCLI P, ');
    Add('  CADCLI C, ');
    Add('  CADATI A, ');
    Add('  CADCID D ');
    Add('WHERE ');
    Add('  P.PRO_CODCLI = C.CLI_CODCLI AND ');
    Add('  C.CLI_CODATI = A.ATI_CODATI AND ');
    Add('  C.CLI_CODCID = D.CID_CODCID AND ');
    Add('  PRO_SEQGER = :SEQGER ');

    ParamByName('SEQGER').AsString := strSeqGer;
    cdsProCli.Open;

  End;
End;

procedure TfrmCadPromocoes.pCarregaCndPag;
begin
  btnIncCndPag.Tag := cdsCndPag.RecNo;
  edtCodCnd.Text := cdsCndPag.FieldByName('CODCND').AsString;
  edtDesCnd.Text := cdsCndPag.FieldByName('DESCND').AsString;
  edtJurRem.Text := cdsCndPag.FieldByName('JURREM').AsString;
  edtCodCnd.Enabled := False;

  fValidaCndPag();
end;

procedure TfrmCadPromocoes.pMarcarEmpresas(strEmpresas: String);
  Var
    intContador: Integer;
begin
  {**********************************************}
  {* SELECIONA A EMPRESA CADASTRADA NA PROMOCAO *}
  {*******************************************LU*}
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If Pos(LeftStr(clbEmpresa.Items[intContador],3), strEmpresas) > 0 Then
      clbEmpresa.Checked[intContador] := True
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
end;

function TfrmCadPromocoes.fGetEmpresasSelecionadas: String;
  Var
    intContador: Integer;
begin
  Result := '';
  clbEmpresa.Items.BeginUpdate;
  try
    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      If clbEmpresa.Checked[intContador] Then
        Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
    End;
  finally
    clbEmpresa.Items.EndUpdate;
  end;
end;

function TfrmCadPromocoes.fGetClientes: TUniQuery;
  var
    strCliente,
    strAtividade,
    strCidade,
    strRegiao,
    strSubRegiao,
    strRede,
    strCanal,
    strVendedor : String;
begin

  Result := fCriaQuery;

  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(fGetSQLClientes);

  pSetaParam(edtCodCli.Text, arrClientes, strCliente,   'CODCLI', Result);
  pSetaParam(edtCodAti.Text, arrAtiv,     strAtividade, 'CODATI', Result);
  pSetaParam(edtCodCid.Text, arrCidade,   strCidade,    'CODCID', Result);

  If Not fEmptyStr(edtEstado.Text) Then
    Result.ParamByName('ESTADO').AsString := edtEstado.Text;

  pSetaParam(edtCodReg.Text, arrRegiao, strRegiao,    'CODREG', Result);
  pSetaParam(edtCodSub.Text, arrSubReg, strSubRegiao, 'CODSUB', Result);
  pSetaParam(edtCodRed.Text, arrRede,   strRede,      'CODRED', Result);
  pSetaParam(edtCodCac.Text, arrCanal,  strCanal,     'CODCAC', Result);
  pSetaParam(edtCodVen.Text, arrVended, strVendedor,  'CODVEN', Result);

  If Not fEmptyStr(fTiraCaracEspeciais(edtNuCnpj.Text)) Then
    Result.ParamByName('CGCCPF').AsString := fTiraCaracEspeciais(edtNuCnpj.Text);

  If Not fEmptyStr(cbxCategoria.Text) Then
    Result.ParamByName('CATEGO').AsString := cbxCategoria.Text;

  Result.Open;

end;

function TfrmCadPromocoes.fGetCndPag: String;
Var
  intRecNo: Integer;
begin
  Result := '';

  if not fValidarCondicaoEPrazoDePagamentoNasPromocoes then
    Exit;

  cdsCndPag.DisableControls;
  intRecNo := cdsCndPag.RecNo;
  cdsCndPag.First;
  try
    while not cdsCndPag.Eof do
    begin
      Result := Result + cdsCndPag.FieldByName('CODCND').AsString + '_';

      cdsCndPag.Next;
    end;
  finally
    cdsCndPag.EnableControls;
    cdsCndPag.RecNo := intRecNo;
  end;
end;

procedure TfrmCadPromocoes.pMarcarTabelasPreco(strTabelas: String);
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

procedure TfrmCadPromocoes.pMostraComposicaoPrecoCusto(strCodIte: String);
  Var
    frmCadProdutosCompCusto : TfrmCadProdutosCompCusto;
begin

  Try
    pCriarFormularios(TfrmCadProdutosCompCusto, frmCadProdutosCompCusto);
    frmCadprodutosCompCusto.strCodIte := strCodIte;
    frmCadprodutosCompCusto.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadPromocoes.pMostraComposicaoPrecoCusto]');
    End;
  End;

  pFreeAndNil(frmCadprodutosCompCusto);

end;

procedure TfrmCadPromocoes.pMostraObservacaoCliente(const strMsgCliente: String; blnMSGInexistentes : Boolean = False);
  const
    TITULO = 'Cliente(s) não incluído(s)!';
  var
    strSubTitulo : String;
begin

  If fEmptyStr(strMsgCliente) Then
    Exit;

  strSubTitulo := 'O(s) cliente(s) abaixo já estão em outras promoções' + fMsgTabloid() + ' vigentes:';

  If blnMSGInexistentes Then
    strSubTitulo := 'O(s) códigos de cliente(s) abaixo não foram identificados.';

  pCriarFormularios(TfrmObservacao, frmObservacao);
  try

    Try
      frmObservacao.lblMensagem.Caption := TITULO + ' ' + strSubTitulo;
      frmObservacao.memObs.Texto        := 'Cliente(s): ' + #13#10 + strMsgCliente;
      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadPromocoes.pMostraObservacaoCliente]');
      End;
    End;

  finally
    pFreeAndNil(frmObservacao);
  end;

end;

function TfrmCadPromocoes.fGetTabelasPrecoSelecionadas: String;
  Var
    intTabPre: Integer;
begin
  Result := '';
  clbTabPre.Items.BeginUpdate;
  try
    For intTabPre := 1 To clbTabPre.Items.Count Do
      Result := Result + IIF(clbTabPre.Checked[intTabPre -1], 'S', 'N');
  finally
    clbTabPre.Items.EndUpdate;
  end;
end;

function TfrmCadPromocoes.fGetTabPre: String;
begin

  Result := '1';

  If Pos('S', fGetTabelasPrecoSelecionadas) > 0 Then
    Exit(IntToStr(Pos('S', fGetTabelasPrecoSelecionadas)));

  If Pos('S', VS_strTabVen) > 0 Then
    Exit(IntToStr(Pos('S', VS_strTabVen)));

end;

function TfrmCadPromocoes.fGetWherePedidosImportados: String;
begin
  Result := '';

  cdsPCMPRO.First();

  While (Not cdsPCMPRO.Eof) Do
  Begin
    Result := Result + ' OR( D.PCD_NUMPED = ' + QuotedStr(cdsPCMPRO.FieldByName('PRO_NUMPED').AsString);
    Result := Result + '     AND D.PCD_ESPDOC = ' + QuotedStr(cdsPCMPRO.FieldByName('PRO_ESPDOC').AsString);
    Result := Result + '     AND D.PCD_CODEMP = ' + QuotedStr(cdsPCMPRO.FieldByName('PRO_CODEMP').AsString);
    Result := Result + ' ) ';

    cdsPCMPRO.Next();
  End;
end;

procedure TfrmCadPromocoes.pStatusLegendaCondicoes(blnValor: Boolean);
begin
  lblLegCondicoes.Visible := blnValor;
end;

procedure TfrmCadPromocoes.pTrataCheckboxEstoqueRemanescente(
  const opcPreDes: TTipDescPro; const blnEnabled: Boolean = True);
begin
  lblTipoPeriodo.Visible := (opcPreDes = tdpEstoqueRemanescente);
  chkSomaCompraPend.Enabled := (opcPreDes = tdpEstoqueRemanescente) And
    (dtsCadPromocoes.DataSet.State = dsInsert) And blnEnabled And (Not blnEcomme);

  If chkSomaCompraPend.Enabled Then
    chkSomaCompraPend.Field.AsString := 'S'
  Else If (dtsCadPromocoes.DataSet.State = dsInsert) And blnEnabled Then
    chkSomaCompraPend.Field.Clear;
end;

procedure TfrmCadPromocoes.pRetCustoMargemVenda(strCodIte, strTabPre: String;
  fltDesF07: Double; var fltCusto, fltMargem, fltVenda, fltPreRea: Double);
  Var
    cpcParams: TParCalculaPrecoCusto;
    blnUtilizarConversorDeMoedas : Boolean;
    qryIteGer: TUniQuery;
    fltIcmsST : Double;
    blnCalcSt : Boolean;
    strCodAbf : String;
begin
  qryIteGer := fCriaQuery(Self);
  Try
    With qryIteGer Do
    Begin
      Close;
      SQL.Clear;

      If blnImpPC Then
      Begin
        If (strAltGrd = 'N') Then
          SQL.Add(Format(sqlInformacoesCustoPCMDET, [strWherePedidoCompra]))
        Else
          SQL.Add(Format(sqlInformacoesCustoPCMDET, [fGetWherePedidosImportados()]));
      End
      Else
        SQL.Add(sqlInformacoesCustoITEGER);


      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('TIPABF').AsString := fCfgSis('TIPABF');
      Open;
    End;

    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

    With cpcParams, qryIteGer Do
    Begin
      curPreCom := FieldByName('ITE_PRECOM').AsFloat;
      curDesF01 := FieldByName('ITE_DESF01').AsFloat;
      curDesF02 := FieldByName('ITE_DESF02').AsFloat;
      curDesF03 := FieldByName('ITE_DESF03').AsFloat;
      curDesF04 := FieldByName('ITE_DESF04').AsFloat;
      curDesF05 := FieldByName('ITE_DESF05').AsFloat;
      curDesF06 := FieldByName('ITE_DESF06').AsFloat;
      curDesF07 := fltDesF07;
      curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
      curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
      curFrete  := FieldByName('ITE_FREENT').AsFloat;
      curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
      curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
      curValFre := FieldByName('ITE_VALFRE').AsFloat;
      curDesAdb := FieldByName('ITE_DESADB').AsFloat;
      curSubFed := FieldByName('ITE_SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
        curTSCust := FieldByName('ITE_TSCUST').AsFloat;
        curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
        curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
        curFatReg := FieldByName('ITE_FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;
    End;

    blnUtilizarConversorDeMoedas := (qryIteGer.FieldByName('ITE_PREDOL').AsString = 'S');

    fltCusto := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);

    fltMargem := qryIteGer.FieldByName('ITE_MARBR' + strTabPre).AsFloat;


    If(qryIteGer.FindField('CODABF') <> Nil) Then
      strCodAbf := qryIteGer.FieldByName('CODABF').AsString
    else
      strCodAbf := qryIteGer.FieldByName('ITE_CODABF').AsString;

    pCarregaValoresCusto(strCodIte, VS_strCodEmp, strTabPre);

    fltIcmsST := fGetIcmsSTParteVenda(blnCalcSt,
                                      strCodAbf,
                                      fPreComLiq(qryIteGer, fltDesF07),
                                      qryIteGer.FieldByName('ITE_IPIENT').AsFloat,
                                      fRetIcmSai(qryIteGer.FieldByName('ITE_ICMSAI').AsFloat));

    fltVenda := fCalculaPrecoVenda(1,
                                   fltCusto + fRetOutVal(qryIteGer.FieldByName('ITE_OUTVAL').AsFloat),
                                   0,
                                   fltMargem,
                                   fRetIcmSai(qryIteGer.FieldByName('ITE_ICMSAI').AsFloat),
                                   fRetImpFed(qryIteGer.FieldByName('ITE_IMPFED').AsFloat),
                                   fRetDesOpe(qryIteGer.FieldByName('ITE_DESOPE').AsFloat),
                                   0,
                                   fCfgSis('MARMKP',varString),
                                   '',
                                   -1,
                                   fltIcmsST,
                                   blnCalcSt
                                   );

    fltPreRea := fCalculaCustoReal(fltCusto,
                                   fRetIcmSai(qryIteGer.FieldByName('ITE_ICMSAI').AsFloat),
                                   fRetImpFed(qryIteGer.FieldByName('ITE_IMPFED').AsFloat),
                                   fRetDesOpe(qryIteGer.FieldByName('ITE_DESOPE').AsFloat),
                                   fRetOutVal(qryIteGer.FieldByName('ITE_OUTVAL').AsFloat));
  Finally
    If Assigned(cpcParams) Then
      FreeAndNil(cpcParams);

    FreeAndNil(qryIteGer);
  End;
end;

function TfrmCadPromocoes.fTravaERegistraStlPromocLck : Boolean;
  Var
    strAux: String;
begin
  Result := False;
  strAux := fRetornaChaveLckPromo;
  If Not fLock_Unlock(strAux, True, False) Then
  Begin
    fMensagem('Atenção', 'Esta promoção está sendo alterada em outra estação - ' + fGetHostLock(strAux) +'.' +
    #13+'Aguarde a liberação da promoção para dar continuidade !', ['&Ok']);
    Result := True;
  End
  Else
    stlPromoAltLck.Add(strAux);
end;

procedure TfrmCadPromocoes.pDestravaELimpaStlPromocLck;
  Var
  intAux: Integer;
Begin
  For intAux:=0 To stlPromoAltLck.Count-1 Do
    fLock_Unlock(stlPromoAltLck[intAux], False, False);

  stlPromoAltLck.Clear;
End;

function TfrmCadPromocoes.fRetDesOpe(const fltDesOpeOriginal: Double): Double;
begin

  Result := fltDesOpeOriginal;

  If Not Assigned(objCustoItem) Then
    Exit;

  Result := recCustoItem.fltDesOpe;

end;

function TfrmCadPromocoes.fRetIcmSai(const fltIcmSaiOriginal: Double): Double;
begin

  Result := fltIcmSaiOriginal;

  If Not Assigned(objCustoItem) Then
    Exit;

  If fCfgSis('IMPCF4') = 'S' Then
    Exit;

  Result := recCustoItem.fltIcmSai;

end;

function TfrmCadPromocoes.fRetImpFed(const fltImpFedOriginal: Double): Double;
begin

  Result := fltImpFedOriginal;

  If Not Assigned(objCustoItem) Then
    Exit;

  Result := recCustoItem.fltImpFed;

end;

function TfrmCadPromocoes.fRetornaChaveLckPromo : String;
begin
  Result := 'PROMO_' +  qryTabela.FieldByName('PRO_CODPRO').AsString +'_'+qryTabela.FieldByName('PRO_CODEMP').AsString;
end;


function TfrmCadPromocoes.fRetornarWherePedidoCompra: String;
Var
  strAux      : TStringList;
  intContador : Integer;
begin
  if ValidarListaPedidosCompra then
  begin
    Result := '';

    Try
      strAux := TStringList.Create;

      For intContador := 0 To Pred(stlPedidosCompra.Count) Do
      Begin
        strAux.Clear();
        ExtractStrings([';'], [' '], PChar(stlPedidosCompra[intContador]), strAux);

        Result:= Result + ' OR( D.PCD_NUMPED = ' + QuotedStr(strAux[0]);
        Result:= Result + '     AND D.PCD_ESPDOC = "PD" ';
        Result:= Result + '     AND D.PCD_CODEMP = ' + QuotedStr(strAux[1]);
        Result:= Result + ' )                           ';
      End;
    Finally
      FreeAndNil(strAux);
    End;
  end
  else
  begin
    Result := '';
    Result:= Result+ ' OR( D.PCD_NUMPED = ' + QuotedStr(cdsPCMPRO.fieldByName('PRO_NUMPED').AsString);
    Result:= Result+ '     AND D.PCD_ESPDOC = "PD" ';
    Result:= Result+ '     AND D.PCD_CODEMP = ' +  QuotedStr(cdsPCMPRO.fieldByName('PRO_CODEMP').AsString) ;
    Result:= Result+ ' )';
  end;

end;

function TfrmCadPromocoes.fRetornaValorCalculoMargem: Double;
begin
  Result := IIF((fStrToFloat(edtPreCus.Text) <> 0), fStrToFloat(edtPreCus.Text), fStrToFloat(edtPreCusCad.Text));
end;

function TfrmCadPromocoes.fRetOutVal(const fltOutValOriginal: Double): Double;
begin

  Result := fltOutValOriginal;

  If Not Assigned(objCustoItem) Then
    Exit;

  Result := recCustoItem.fltOutVal;

end;

function TfrmCadPromocoes.fRetOutValComDespesa(AOutVal, AVlrVenda,
  APerComissao: Double): Double;
var
  LOutVal: Double;
begin
  LOutVal := AOutVal;

  If (fCfgSis('PCMPRO') = 3) and (fCfgSis('MARIDE', varString) = 'N') and (AVlrVenda > 0) Then
    LOutVal := AVlrVenda * (APerComissao / 100);

  Result := LOutVal;
end;

function TfrmCadPromocoes.fRetOutValComDespesa(AOutVal: Double; ACampoVenda: String; ACampoComissao: String): Double;
var
  LOutVal: Double;
begin
  LOutVal := AOutVal;

  If (fCfgSis('PCMPRO') = 3) and (fCfgSis('MARIDE', varString) = 'N') and (not fEmptyStr(ACampoVenda)) and (not fEmptyStr(ACampoComissao)) And (Length(ACampoComissao) > 1) Then
    LOutVal := cdsCadPro.FieldByName(ACampoVenda).AsFloat * (cdsCadPro.FieldByName(ACampoComissao).AsFloat / 100);

  Result := LOutVal;
end;


function TfrmCadPromocoes.fRetPreCus(const fltPreCusOriginal: Double): Double;
begin

  Result := fltPreCusOriginal;

  If Not Assigned(objCustoItem) Then
    Exit;

  Result := recCustoItem.fltPreCus;

end;

procedure TfrmCadPromocoes.pGravarPedidosCompraImportados(Const strAutInc: String);
  var
    qryGen: TUniQuery;
    qryPro: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryPro := fCriaQuery(Self);

  Try
    qryPro.SQL.Clear();
    qryPro.SQL.Add(sqlExistsPCMPRO);

    cdsPCMPRO.First();

    While (Not cdsPCMPRO.Eof) Do
    Begin
      qryPro.Close();
      qryPro.ParamByName('NUMPED').AsString := cdsPCMPRO.FieldByName('PRO_NUMPED').AsString;
      qryPro.ParamByName('CODEMP').AsString := cdsPCMPRO.FieldByName('PRO_CODEMP').AsString;
      qryPro.ParamByName('ESPDOC').AsString := cdsPCMPRO.FieldByName('PRO_ESPDOC').AsString;
      qryPro.ParamByName('NUMCTN').AsInteger := cdsPCMPRO.FieldByName('PRO_NUMCTN').AsInteger;
      qryPro.ParamByName('SEQGER').AsString := strAutInc;
      qryPro.Open();

      If qryPro.IsEmpty Then
      Begin
        qryGen.SQL.Clear();
        qryGen.SQL.Add(sqlInsertPCMPRO);

        qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('PCMPRO', VS_strCodEmp);
        qryGen.ParamByName('NUMPED').AsString := cdsPCMPRO.FieldByName('PRO_NUMPED').AsString;
        qryGen.ParamByName('CODEMP').AsString := cdsPCMPRO.FieldByName('PRO_CODEMP').AsString;
        qryGen.ParamByName('ESPDOC').AsString := cdsPCMPRO.FieldByName('PRO_ESPDOC').AsString;
        qryGen.ParamByName('NUMCTN').AsInteger := cdsPCMPRO.FieldByName('PRO_NUMCTN').AsInteger;
        qryGen.ParamByName('SEQGER').AsString := strAutInc;

        qryGen.ExecSQL();
      End;

      cdsPCMPRO.Next();
    End;
  Finally
    FreeAndNil(qryPro);
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadPromocoes.pSetEnabledCliente;
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

procedure TfrmCadPromocoes.pZeraComissao;
begin
  with cdsCadPro do
  begin
    DisableControls;
    First;
    While not eof do
    begin
      Edit;
      FieldByName('IPR_COMVAR').AsFloat := 0;
      FieldByName('IPR_COMATA').AsFloat := 0;
      FieldByName('IPR_COMDIS').AsFloat := 0;
      Post;

      Next;
    end;
    EnableControls;

  end;

end;

function TfrmCadPromocoes.fGetIcmsSTParteVenda(var blnST: Boolean; strCodAbf: String; fltPreComLiq, fltIpiEnt, fltImcSai: Double): Double;
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

function TfrmCadPromocoes.fPermiteAlterarExcluirTabloid: Boolean;
begin
  Result := True;

  If fVerificaAcessoSistema('PERIAE', strLoginUsuarioLogado) Then
    Exit;

  If Not Assigned(qryTabela) Then
    Exit;

  If Not qryTabela.Active Then
    Exit;

  If qryTabela.RecordCount <= 0 Then
    Exit;

  If qryTabela.RecNo <= 0 Then
    Exit;

  If qryTabela.FieldByName('PRO_TABLOI').AsString = 'S' Then
    Result := False;
end;

function TfrmCadPromocoes.fPermiteQtdeLimite: Boolean;
begin
  Result := True;

  If Not blnEcomme Then
    Exit;

  If fCfgSis('PROEQL', varBoolean) Then
    Exit;

  Result := False;
end;

function TfrmCadPromocoes.fPossuiLimite: Boolean;
begin
  result := false;
  if not cdsCadPro.isEmpty then
  begin
     cdsCadPro.DisableControls;
     try
       cdsCadPro.first;
       while not cdsCadPro.eof do
       begin
         result := cdsCadPro.fieldbyname('IPR_QTDLIM').asfloat > 0;
         if result then break;
         cdsCadPro.next;
       end;
     finally
       cdsCadPro.EnableControls;
     end;
  end;
end;

function TfrmCadPromocoes.fPreComLiq(DataSet: TDataSet; fltDesF07: Double): Double;
begin
  Result := untfuncoesSimples.fCalculaPrecoCompraLiq(DataSet.FieldByName('ITE_PRECOM').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF01').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF02').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF03').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF04').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF05').AsFloat,
                                                     DataSet.FieldByName('ITE_DESF06').AsFloat,
                                                     intDecUni,
                                                     (DataSet.FieldByName('ITE_PREDOL').AsString = 'S'),
                                                     fltDesF07);
end;

function TfrmCadPromocoes.fGetQtdeEmpresasSelecionadas: Integer;
Var
  intContador: Integer;
begin
  Result := 0;
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
    If clbEmpresa.Checked[intContador] Then
      Inc(Result);
end;

function TfrmCadPromocoes.fGetEmpresaPreAlt: String;
begin
  If fGetQtdeEmpresasSelecionadas = 1 Then
    Result := fGetEmpresasSelecionada()
  Else
    Result := VS_strCodEmp;
end;

function TfrmCadPromocoes.fGetEmpresasSelecionada: String;
Var
  intContador: Integer;
begin
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
    If clbEmpresa.Checked[intContador] Then
    Begin
      Result := LeftStr(clbEmpresa.Items[intContador],3);
      Break;
    End;
end;

function TfrmCadPromocoes.fGetQtdLimiteEstoqueRemanescente(strCodIte: String): Double;
var
  fltSaldoItem: Double;
  intContador: Integer;
Begin
  fltSaldoItem := 0;
  Try
    For intContador := 0 To clbEmpresa.Items.Count -1 Do
    Begin
      If clbEmpresa.Checked[intContador] Then
      Begin
        fltSaldoItem := fltSaldoItem + fRetornaSaldoDisponivel(strCodIte,
                                                           False,
                                                           True,
                                                           '',
                                                           True,
                                                           LeftStr(clbEmpresa.Items[intContador],3),
                                                           '',
                                                           chkSomaCompraPend.Checked);
      End;
    End;
  Finally
    If fUnidadeDoProdutoEhFracionaria(strCodIte) Then
      Result := (fltSaldoItem * StringToFloat(edtPerEst.Text)) / 100
    Else
      Result := Trunc((fltSaldoItem * StringToFloat(edtPerEst.Text)) / 100)
  End;

End;

function TfrmCadPromocoes.fGetQtdLimitePedidoCompra(Const strCodIte: String): Double;
  var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  Try
    qryGen.SQL.Clear();
    qryGen.SQL.Add(Format(sqlQtdLimitePedidoCompra, [strWherePedidoCompra]));
    qryGen.ParamByName('CODITE').AsString := strCodIte;

    qryGen.Open();

    Result := qryGen.FieldByName('QTDLIM').AsFloat;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadPromocoes.fGetSQLClientes: String;
begin

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CLI_CODCLI AS CODCLI, ';
  Result := Result + '  CLI_NOMCLI AS NOMCLI, ';
  Result := Result + '  CONCAT(CID_NOMCID," - ",CID_ESTADO) AS CIDEST, ';
  Result := Result + '  ATI_DESATI AS ATIVID, ';
  Result := Result + '  CLI_C_G_C_ AS CGCCPF, ';
  Result := Result + '  CLI_CATEGO AS CATEGO  ';
  Result := Result + 'FROM ';
  Result := Result + '  CADCLI, ';
  Result := Result + '  CADCID, ';
  Result := Result + '  CADATI  ';
  Result := Result + 'WHERE ';
  Result := Result + '  CLI_CODATI = ATI_CODATI AND ';
  Result := Result + '  CLI_CODCID = CID_CODCID ';

  Result := Result + fStrLocate(edtCodCli, arrClientes, 'CLI_CODCLI', 'CODCLI');
  Result := Result + fStrLocate(edtCodAti, arrAtiv,     'CLI_CODATI', 'CODATI');
  Result := Result + fStrLocate(edtCodCid, arrCidade,   'CLI_CODCID', 'CODCID');

  If Not fEmptyStr(edtEstado.Text) Then
    Result := Result + '  AND CID_ESTADO = :ESTADO ';

  Result := Result + fStrLocate(edtCodReg, arrRegiao, 'CLI_CODREG', 'CODREG');
  Result := Result + fStrLocate(edtCodSub, arrSubReg, 'CLI_CODSUB', 'CODSUB');
  Result := Result + fStrLocate(edtCodRed, arrRede,   'CLI_CODRED', 'CODRED');
  Result := Result + fStrLocate(edtCodCac, arrCanal,  'CLI_CODCAC', 'CODCAC');
  Result := Result + fStrLocate(edtCodVen, arrVended, 'CLI_CODVEN', 'CODVEN');

  If Not fEmptyStr(edtNuCnpj.Text) Then
    Result := Result + '  AND CLI_C_G_C_ = :CGCCPF ';

  If Not fEmptyStr(cbxCategoria.Text) Then
    Result := Result + '  AND CLI_CATEGO = :CATEGO ';

  Result := Result + 'ORDER BY CLI_CODCLI ';

end;

procedure TfrmCadPromocoes.pMontarRegraPrecoSugestao;
begin
  TRegraPrecoSugestao.MontarRegraRadioGroupItems(rdgProPre.Properties.Items);
end;

procedure TfrmCadPromocoes.pAdicionaCondicao;
begin
  if not fValidaCndPag then
    Exit;

  If (btnIncCndPag.Tag = 0) and cdsCndPag.Locate('CODCND', edtCodCnd.Text, []) tHEN
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento já foi escolhida!', ['&Ok']);
    pSetFocus(edtCodCnd);
    Exit;
  end;


  if btnIncCndPag.Tag = 0 then
  begin
    cdsCndPag.Append;
    cdsCndPag.FieldByName('CODCND').AsString := edtCodCnd.Text;
    cdsCndPag.FieldByName('DESCND').AsString := fCampoTabela('CND_DESCRI', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False);
    cdsCndPag.FieldByName('CNDPAG').AsString := fFormataCondPag(fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [edtCodCnd.Text], False));
  end
  else
  begin
    cdsCndPag.RecNo := btnIncCndPag.Tag;
    cdsCndPag.Edit;
  end;

  cdsCndPag.FieldByName('JURREM').AsString := edtJurRem.Text;
  cdsCndPag.Post;

  btnCancelCndPag.Click;
end;

procedure TfrmCadPromocoes.pLimpaInputsDadosItem;
begin
  edtDesIte.Text := 'TODOS';
  edtPreVen.Text := '0,00';
  edtPreCus.Text := '0,00';
  edtComVar.Text := '0,00';
  edtComAta.Text := '0,00';
  edtComDis.Text := '0,00';
  edtPrzMed.Text := '0';
  edtUnidade.Text := '';
  edtPerDes.Text := '0,00';
  edtQtdLim.Text := '';
  edtQtdMin.Text := '';
  edtCliVen.Text := '';
  edtMarBru.Text := '0,00';
  ckbPrecoFixoParaTmqImo.Checked := False;
end;

procedure TfrmCadPromocoes.pLimparFiltrosPrecoVendaReal;
begin
  cxvFiltrosCodAbf.Properties.Value := EmptyStr;
  cxvFiltrosPerAbf.Properties.Value := Null;
  cxvFiltrosEstado.Properties.Value := Null;
end;

procedure TfrmCadPromocoes.pLimpaDadosItem;
Var
  intContador : Integer;
begin
  FfltBocCai := 0;
  FfltIcmSai := 0;
  FfltImpFed := 0;
  FfltDesOpe := 0;
  FfltPreCus := 0;

  If rdgPreDes.ItemIndex <> IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit] Then
  Begin
    For intContador := 0 To pnlInformacoesItens.ComponentCount - 1 Do
    Begin
      If pnlDadosItem.Enabled Then
      Begin
        If Components[intContador] is TMaskEdit Then
          TMaskEdit(pnlInformacoesItens.Components[intContador]).Clear;
        If Components[intContador] is TEditFocus Then
          TEditFocus(pnlInformacoesItens.Components[intContador]).Clear;
      End;
    End;
  End;

  If (TTipDescPro(rdgPreDes.ItemIndex) = tdpEstoqueRemanescente) Then
  Begin
    dbeDtaInicial.Text := DateToStr(VS_Date - 30);
    dbeDtaFinal.Text   := DateToStr(VS_Date);
    edtPerEst.Text     := '100,00';
    pEnabledEdit(edtPerEst);
  End;

  If blnImpPC Then
    pSetFocus(edtComVar)
  Else If blnPreAlt Then
    pSetFocus(dbeDtaInicial)
  Else
    pSetFocus(mskLinhaGrupo);

  strAltGrd := 'N';
  btnConfirmar.Tag := 0;
  edtCodIte.Enabled := True;
  cxgItens.Enabled  := True;
  pVisiblePanelValores(False);
  chkTabloidClick(nil);
  edtCodIte.Clear;
  pLimpaInputsDadosItem;

  pLimparFiltrosPrecoVendaReal;
end;

function TfrmCadPromocoes.fValidaArrPromocaoRestritaClientesNaoConsumidor: boolean;
var
  intCnt: integer ;
  strNomeCliente: string ;
begin
  result := False ;
  if not chkPromocaoRestritaClientesNaoConsumidor.Checked then
  begin
    result := True ;
    exit ;
  end;

  for intCnt := Low(arrClientes) to High(arrClientes) do
  begin
    strNomeCliente := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [arrClientes[intCnt].strCodigo]) ;
    if fClienteConsumidor(strNomeCliente, True, True) then
    begin
      exit ;
    end;
  end;
  result := True ;
end;

function TfrmCadPromocoes.fPreenchePrecoDeVenda(fltPreco, fltMargem: Double): Boolean;
  Var
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    qryRetPre: TUniQuery;
    LCalculouPrecoPelaMargem: Boolean;
begin
  Result := False;

  LCalculouPrecoPelaMargem := False;

  If (fPrecoDeVendaEhObrigatorio) And ((fltPreco <= 0) And (fltMargem <= 0)) Then
    Exit;

  fltPrecoCusto := IIF((fStrToFloat(edtPreCus.Text) <> 0), fStrToFloat(edtPreCus.Text), fStrToFloat(edtPreCusCad.Text));

  qryRetPre := fCriaQuery(Self);
  Try
    With qryRetPre, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT G.ITE_PRECUS,         ');
      Add('        G.ITE_ICMSAI,         ');
      Add('        G.ITE_IMPFED,         ');
      Add('        G.ITE_DESOPE,         ');
      Add('        G.ITE_OUTVAL,         ');
      Add('        G.ITE_PREVE1,         ');
      Add('        G.ITE_PREVE2,         ');
      Add('        G.ITE_PREVE3,         ');
      Add('        G.ITE_PREVE4,         ');
      Add('        G.ITE_PREVE5,         ');
      Add('        G.ITE_PREVE6,         ');
      Add('        G.ITE_PREVE7,         ');
      Add('        G.ITE_COMTB1,         ');
      Add('        G.ITE_COMTB2,         ');
      Add('        G.ITE_COMTB3,         ');
      Add('        G.ITE_COMTB4,         ');
      Add('        G.ITE_COMTB5,         ');
      Add('        G.ITE_COMTB6,         ');
      Add('        G.ITE_COMTB7,         ');
      Add('        G.ITE_IPIENT,         ');
      Add('        G.ITE_PRECOM,         ');
      Add('        G.ITE_DESF01,         ');
      Add('        G.ITE_DESF02,         ');
      Add('        G.ITE_DESF03,         ');
      Add('        G.ITE_DESF04,         ');
      Add('        G.ITE_DESF05,         ');
      Add('        G.ITE_DESF06,         ');
      Add('        G.ITE_PREDOL,         ');

      If (fCfgSis('TIPABF') = '1') Then
        Add(' I.ITE_CODABF AS ITE_CODABF ')
      Else
        Add(' G.ITE_CODABF AS ITE_CODABF ');

      Add('  FROM ITEGER G              ');
      Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
      Add(' WHERE G.ITE_CODITE = :CODITE ');
      Add('   AND G.ITE_CODEMP = :CODEMP ');

      ParamByName('CODITE').AsString := edtCodIte.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      pCarregaValoresCusto(edtCodIte.Text, VS_strCodEmp, fGetTabPre);

      fltPrecoCustoReal := fCalculaCustoReal(fltPrecoCusto,
                                             fRetIcmSai(FieldByName('ITE_ICMSAI').AsFloat),
                                             fRetImpFed(FieldByName('ITE_IMPFED').AsFloat),
                                             fRetDesOpe(FieldByName('ITE_DESOPE').AsFloat),
                                             fRetOutVal(FieldByName('ITE_OUTVAL').AsFloat));
    End;
  Finally
    FreeAndNil(qryRetPre)
  End;

  If ((fltMargem > 0) And (fltPreco <= 0)) Then
  Begin
    If blnCalcMargemLiquida Then
    Begin
      edtMarBru.Text := FormatFloat(fMskDigitos(intDecUni), fltMargem);
      edtMarg01.Text := FormatFloat(fMskDigitos(intDecUni), fltMargem);

      pCalculaPrecoVenda;
      LCalculouPrecoPelaMargem := True;
    End
    Else
    Begin
      fltPreco := fCalculaPrecoVenda(1,
                                     fltPrecoCustoReal,
                                     0,
                                     fltMargem,
                                     0,0,0,0);


    End;
  End;

  If (fltPreco > 0) And (Not LCalculouPrecoPelaMargem) Then
  Begin
    edtPreVen.Text := FormatFloat(fMskDigitos(intDecUni), fltPreco);
  End;

  Result := True;
end;

function TfrmCadPromocoes.fPrecoDeVendaEhObrigatorio: Boolean;
begin
  Result := (opcTipDes = tdpPrecos) Or
            (opcTipDes = tdpPrecoPorQuantidadeMinimaEscalonada) Or
            (opcTipDes = tdpPrecoPorVlrMinProd);
end;

procedure TfrmCadPromocoes.pExibeCampoDePrecoPromocional(qryRetPre: TUniQuery; intIndex: Integer);
begin
  TLabel(FindComponent('lblProm0'+IntToStr(intIndex))).Visible     := clbTabPre.Checked[intIndex-1];
  TEditFocus(FindComponent('edtProm0'+IntToStr(intIndex))).Visible := clbTabPre.Checked[intIndex-1];

  TEditFocus(FindComponent('edtProm0'+IntToStr(intIndex))).Text := FormatFloat(fMskDigitos(intDecUni),
    qryRetPre.FieldByName('ITE_PREVE' + IntToStr(intIndex)).AsFloat *
    (1 - (fStrToFloat(edtPerDes.Text) / 100)));
end;

procedure TfrmCadPromocoes.pExibeCamposDePrecoPromocao(blnExibir: Boolean);
  Var
    intIndex: Integer;
begin
  For intIndex := 1 To clbTabPre.Items.Count Do
  Begin
    TLabel(FindComponent('lblProm0'+IntToStr(intIndex))).Visible     := blnExibir;
    TEditFocus(FindComponent('edtProm0'+IntToStr(intIndex))).Visible := blnExibir;
  End;
end;

procedure TfrmCadPromocoes.pCarregaQueryDadosItem(Var qryDados: TUniQuery);
begin
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(' SELECT G.ITE_PRECUS,         ');
  qryDados.SQL.Add('        G.ITE_ICMSAI,         ');
  qryDados.SQL.Add('        G.ITE_IMPFED,         ');
  qryDados.SQL.Add('        G.ITE_DESOPE,         ');
  qryDados.SQL.Add('        G.ITE_OUTVAL,         ');
  qryDados.SQL.Add('        G.ITE_PREVE1,         ');
  qryDados.SQL.Add('        G.ITE_PREVE2,         ');
  qryDados.SQL.Add('        G.ITE_PREVE3,         ');
  qryDados.SQL.Add('        G.ITE_PREVE4,         ');
  qryDados.SQL.Add('        G.ITE_PREVE5,         ');
  qryDados.SQL.Add('        G.ITE_PREVE6,         ');
  qryDados.SQL.Add('        G.ITE_PREVE7,         ');
  qryDados.SQL.Add('        G.ITE_COMTB1,         ');
  qryDados.SQL.Add('        G.ITE_COMTB2,         ');
  qryDados.SQL.Add('        G.ITE_COMTB3,         ');
  qryDados.SQL.Add('        G.ITE_COMTB4,         ');
  qryDados.SQL.Add('        G.ITE_COMTB5,         ');
  qryDados.SQL.Add('        G.ITE_COMTB6,         ');
  qryDados.SQL.Add('        G.ITE_COMTB7,         ');
  qryDados.SQL.Add('        G.ITE_IPIENT,         ');
  qryDados.SQL.Add('        G.ITE_PRECOM,         ');
  qryDados.SQL.Add('        G.ITE_DESF01,         ');
  qryDados.SQL.Add('        G.ITE_DESF02,         ');
  qryDados.SQL.Add('        G.ITE_DESF03,         ');
  qryDados.SQL.Add('        G.ITE_DESF04,         ');
  qryDados.SQL.Add('        G.ITE_DESF05,         ');
  qryDados.SQL.Add('        G.ITE_DESF06,         ');
  qryDados.SQL.Add('        G.ITE_PREDOL,         ');

  If (fCfgSis('TIPABF') = '1') Then
    qryDados.SQL.Add(' I.ITE_CODABF AS ITE_CODABF ')
  Else
    qryDados.SQL.Add(' G.ITE_CODABF AS ITE_CODABF ');

  qryDados.SQL.Add('  FROM ITEGER G              ');
  qryDados.SQL.Add('  JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ');
  qryDados.SQL.Add(' WHERE G.ITE_CODITE = :CODITE ');
  qryDados.SQL.Add('   AND G.ITE_CODEMP = :CODEMP ');

  qryDados.ParamByName('CODITE').AsString := edtCodIte.Text;
  qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDados.Open;
end;

function TfrmCadPromocoes.fValidaQuantidadeMinima(strCodIte: String; fltQtdMin: Double): Boolean;
begin
  Result := False;

  stlItensQuantidadeMinimaDuplicado.Clear;

  If (Not fEmptyStr(strCodIte)) And (fltQtdMin > 0) Then
    pValidaSeItemJaCadastradoQtdMin(strCodIte, fltQtdMin, True);

  If (stlItensQuantidadeMinimaDuplicado.Count > 0) Then
    Exit;

  Result := True;
end;

procedure TfrmCadPromocoes.pSetaVisibilidadePrecoFixoTmqImo(const blnProdutoBase : Boolean);
begin
  ckbPrecoFixoParaTmqImo.Visible := False;
  If (Not blnProdutoBase) Then
    Exit;
  If (Not fTipoDePromocaoSuportaPrecoFixoParaTmqImo) Then
    Exit;
  ckbPrecoFixoParaTmqImo.Visible := True;
end;

procedure TfrmCadPromocoes.pDesmarcaPrecoFixoTmqImoQuandoInvisivel;
begin
  If ckbPrecoFixoParaTmqImo.Visible Then
    Exit;
  ckbPrecoFixoParaTmqImo.Checked := False;
end;

function TfrmCadPromocoes.fTipoDePromocaoSuportaPrecoFixoParaTmqImo : Boolean;
begin
  Result := (fCfgSis('PEPFIM', varString) = 'S') And (rdgPreDes.ItemIndex In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecos], IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon]]);
end;

end.

