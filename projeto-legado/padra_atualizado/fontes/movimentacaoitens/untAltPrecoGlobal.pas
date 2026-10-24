unit untAltPrecoGlobal;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, Uni, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus, Menus, StrUtils, DB, AppEvnts,
  QColorLabel, UniDataSetProvider, UniClientDataSet, untFuncoesSimples, ComboBoxFocus,
  untFatorPreco, BitBtnLockedIncrem, Math, MemoFocus, untSalvaDadosInterface,
  Datasnap.Provider, frxClass, frxExportCSVTestabilidade, untZClient,
  cxProgressBar, untGravando, Datasnap.DBClient, untTypesSistema, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDropDownEdit, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxVGrid, cxDBVGrid, cxInplaceContainer, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxEditRepositoryItems, cxDBEditRepository, cxCheckBox, untTEditFocusWithTConsultasArray,
  System.IOUtils, untTGerenciaItegerPermiteEdicao, untTGravaDadosFormulario, untTGerenciaExprAltGlobal;

Type
  TTipoCalculo = (tcNenhum, tcFator, tcSomar);

  TRecTabelaPrecos = Record
    fltPreVenNov: Double;
    fltMarBruNov: Double;
    fltComTblNov: Double;
    blnAltPreven: Boolean;
    blnAltMarBru: Boolean;
    blnAltComTbl: Boolean;
  End;

type
  TfrmAltPrecoGlobal = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    pnlBotoesEnt: TPanel;
    pgbProgresso: TProgressBar;
    cdsAltGlo: TUniClientDataSet;
    cdsAltGloITE_DESCAM: TStringField;
    cdsAltGloITE_VALCAM: TStringField;
    cdsAltGloITE_MASCAM: TStringField;
    cdsAltGloITE_NOMCAM: TStringField;
    cdsAltGloITE_DESABR: TStringField;
    cdsAltGloITE_LIMCAM: TIntegerField;
    cdsAltGloITE_TIPCAM: TStringField;
    cdsAltGloITE_ALTERA: TStringField;
    dtsAltGlo: TDataSource;
    dspIteGlo: TUniDataSetProvider;
    cdsIteGlo: TUniClientDataSet;
    pnlFiltro1: TPanel;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label2: TLabel;
    edtDesIte: TEditFocus;
    Label3: TLabel;
    edtRefere: TEditFocus;
    Label4: TLabel;
    edtCodUni: TEditFocus;
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    rdgTipAlt: TRadioGroup;
    rdgTipAltFor: TRadioGroup;
    pnlFiltro2: TPanel;
    Label8: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    chkArrMai: TCheckBox;
    Label5: TLabel;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    Label7: TLabel;
    edtClaIPI: TEditFocus;
    edtStatus: TEditFocus;
    ColorLabel1: TColorLabel;
    pnlTabPre: TPanel;
    Label11: TLabel;
    edtTabPre: TEditFocus;
    edtNomTab: TEditFocus;
    pnlCadMon: TPanel;
    lbl1: TLabel;
    edtCodMon: TEditFocus;
    edtDesMon: TEditFocus;
    pnlNotEnt: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairAlt: TBitBtnLocked;
    Label13: TLabel;
    Label167: TLabel;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    Label14: TLabel;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    edtDecUni: TEditFocus;
    Label50: TLabel;
    edtIncPis: TEditFocus;
    ColorLabel2: TColorLabel;
    rdgEstMin: TRadioGroup;
    Label31: TLabel;
    cmbGiroEstoque: TComboBoxFocus;
    edtExcIpi: TEditFocus;
    lbl50: TLabel;
    lblMarIde: TLabel;
    cbxMarIde: TComboBoxFocus;
    lblTabPrc: TLabel;
    cbxTabPrc: TComboBoxFocus;
    Label9: TLabel;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    chkPenRec: TCheckBox;
    chkExiSal: TCheckBox;
    lblCodGpr: TLabel;
    edtCodGpr: TEditFocus;
    edtDesGpr: TEditFocus;
    shpMultSel: TShape;
    cxStyleRepository: TcxStyleRepository;
    cxsCorAzul: TcxStyle;
    cxEditRepository: TcxEditRepository;
    cxeString16: TcxEditRepositoryTextItem;
    cxeString20: TcxEditRepositoryTextItem;
    cdsAltGloITE_PROPER: TStringField;
    cxeString02: TcxEditRepositoryTextItem;
    cxeString03: TcxEditRepositoryTextItem;
    cxeString05: TcxEditRepositoryTextItem;
    cxeString06: TcxEditRepositoryTextItem;
    cxeString07: TcxEditRepositoryTextItem;
    cxeString08: TcxEditRepositoryTextItem;
    cxeString10: TcxEditRepositoryTextItem;
    cxeString25: TcxEditRepositoryTextItem;
    cxeString30: TcxEditRepositoryTextItem;
    cxeString50: TcxEditRepositoryTextItem;
    cxeString70: TcxEditRepositoryTextItem;
    cxeString80: TcxEditRepositoryTextItem;
    cxeString150: TcxEditRepositoryTextItem;
    cxeString255: TcxEditRepositoryTextItem;
    cxeLocFis: TcxEditRepositoryTextItem;
    cxeLocSup: TcxEditRepositoryTextItem;
    cxeTamLcf: TcxEditRepositoryTextItem;
    cxeLocSep: TcxEditRepositoryTextItem;
    cxeDate: TcxEditRepositoryDateItem;
    cxeInt03: TcxEditRepositoryCurrencyItem;
    cxeInt11: TcxEditRepositoryCurrencyItem;
    cmbSimNao: TcxEditRepositoryLookupComboBoxItem;
    cmbIndRev: TcxEditRepositoryLookupComboBoxItem;

    cmbClaCRM: TcxEditRepositoryLookupComboBoxItem;
    cmbNivGir: TcxEditRepositoryComboBoxItem;
    cmbNivCri: TcxEditRepositoryComboBoxItem;
    cmbRspGar: TcxEditRepositoryComboBoxItem;
    cmbFrePFU: TcxEditRepositoryLookupComboBoxItem;
    cmbEsMiDg: TcxEditRepositoryLookupComboBoxItem;
    cxeMemo: TcxEditRepositoryMemoItem;
    cxsCombo: TcxStyle;
    cxsAltera: TcxStyle;
    cxeMasFat: TcxEditRepositoryTextItem;
    cxeDecUni: TcxEditRepositoryTextItem;
    cxeDec05: TcxEditRepositoryTextItem;
    cxeDec06: TcxEditRepositoryTextItem;
    cxeMasVal: TcxEditRepositoryTextItem;
    cxeMasPer: TcxEditRepositoryTextItem;
    cxeMasMar: TcxEditRepositoryTextItem;
    cxeMasMBr: TcxEditRepositoryTextItem;
    cxeMasInt: TcxEditRepositoryTextItem;
    cmbTipPro: TcxEditRepositoryLookupComboBoxItem;
    cxsConsulta: TcxStyle;
    cdsAltGloITE_DESCRI: TStringField;
    cxeConsTam8: TcxEditRepositoryTextItem;
    cxeConsTam6: TcxEditRepositoryTextItem;
    cxeConsTam5: TcxEditRepositoryTextItem;
    cxeConsTam3: TcxEditRepositoryTextItem;
    cxeConsTamLse: TcxEditRepositoryTextItem;
    cxeConsTam4: TcxEditRepositoryTextItem;
    cxeConsTam2: TcxEditRepositoryTextItem;
    cxeClassfIPI: TcxEditRepositoryTextItem;
    pnlDadosAlt: TPanel;
    cxgTiposAlt: TcxGrid;
    cxvTiposAlt: TcxGridDBTableView;
    cxvTiposAltALTERA: TcxGridDBColumn;
    cxvTiposAltDESCAM: TcxGridDBColumn;
    cxvTiposAltVALCAM: TcxGridDBColumn;
    cxvTiposAltPROPER: TcxGridDBColumn;
    cxvTiposAltNOMCAM: TcxGridDBColumn;
    cxvTiposAltDESCRI: TcxGridDBColumn;
    cxgTiposAltLevel1: TcxGridLevel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    shpConsulta: TShape;
    Label15: TLabel;
    shpLista: TShape;
    Label16: TLabel;
    Shape3: TShape;
    Label17: TLabel;
    cxeConsTam7: TcxEditRepositoryTextItem;
    Label18: TLabel;
    edtAbfPis: TEditFocus;
    edtDesPis: TEditFocus;
    Label19: TLabel;
    edtAbfCof: TEditFocus;
    edtDesCof: TEditFocus;
    cmbSimNaoFornecedor: TcxEditRepositoryLookupComboBoxItem;
    dtsPermissaoVenda: TDataSource;
    cmbPerVda: TcxEditRepositoryLookupComboBoxItem;
    cmbCarEst: TcxEditRepositoryComboBoxItem;
    edtCodCom: TEditFocus;
    edtDesComp: TEditFocus;
    GroupBox2: TGroupBox;
    Label21: TLabel;
    MskDataFim: TMaskEditFocus;
    MskDataIni: TMaskEditFocus;
    Label20: TLabel;
    lblCest: TLabel;
    edtCest: TEditFocus;
    edtCestDesc: TEditFocus;
    cbxAtoDF: TCheckBox;
    Label22: TLabel;
    edtStatusCompra: TEditFocus;
    cxBtnMontadora: TcxEditRepositoryButtonItem;
    ColorLabel3: TColorLabel;
    lblGiroEstoqueFornecedor: TLabel;
    cmbGiroEstoqueFornecedor: TComboBoxFocus;
    Label12: TLabel;
    grpDadosNE: TGroupBox;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresa: TLabel;
    lblForNot: TLabel;
    lblDtaFin: TLabel;
    lblDtaIni: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkNotEnt: TCheckBox;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    mskDtaEntIni: TMaskEditFocus;
    pnlTipAltNota: TPanel;
    Label35: TLabel;
    Label42: TLabel;
    rdgTipAltNot: TRadioGroup;
    edtPerAcr: TEditFocus;
    pnlMovmentacaoEstoque: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    rdgTipoMovimentacaoEstoque: TRadioGroup;
    edtDiasMovimentacao: TEditFocus;
    rdgEmpresaMovimentacaoEstoque: TRadioGroup;
    chkManterUltAlt: TCheckBox;
    cmbTpEstM: TcxEditRepositoryComboBoxItem;
    cxeInt06: TcxEditRepositoryCurrencyItem;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    edtDesLocFis: TEditFocus;
    cxeDecQtd: TcxEditRepositoryTextItem;
    cmbMltRca: TcxEditRepositoryComboBoxItem;
    cxeMmoAPE: TcxEditRepositoryMemoItem;
    cmbTipRet: TcxEditRepositoryLookupComboBoxItem;
    lblCSTORI: TLabel;
    cmbCSTORI: TComboBoxFocus;
    cmbCSTOriSel: TcxEditRepositoryComboBoxItem;
    cdsPrecoPautaFiscal: TClientDataSet;
    cdsPrecoPautaFiscalPPF_CODITE: TStringField;
    cdsPrecoPautaFiscalPPF_ESTADO: TStringField;
    cdsPrecoPautaFiscalPPF_VLRPPF: TFloatField;
    cdsPrecoPautaFiscalPPF_DTAINI: TDateField;
    cdsPrecoPautaFiscalPPF_DTAFIN: TDateField;
    btnPrecoPautaFiscal: TBitBtnLocked;
    pnlExpressao: TPanel;
    btnAddExpr: TBitBtnLocked;
    btnVisualizarExpr: TBitBtnLocked;
    lblEstUFIcms: TLabel;
    edtEstadoAbfICMS: TEditFocus;
    procedure edtAbfCofExit(Sender: TObject);
    procedure edtAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure edtAbfPisExit(Sender: TObject);
    procedure edtAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairAltClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgTipAltClick(Sender: TObject);
    procedure edtClaIPIKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkNotEntClick(Sender: TObject);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure rdgTipAltForClick(Sender: TObject);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMonKeyPress(Sender: TObject; var Key: Char);
    procedure rdgTipAltNotClick(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure chkArrMaiClick(Sender: TObject);
    procedure edtIncPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtRefereKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtExcIpiExit(Sender: TObject);
    procedure cbxMarIdeChange(Sender: TObject);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodGprExit(Sender: TObject);
    procedure edtCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtCodMonExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodAbrExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure cxvTiposAltVALCAMGetProperties(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AProperties: TcxCustomEditProperties);
    procedure cxvTiposAltVALCAMStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxvTiposAltDESCAMStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure cxvTiposAltALTERAPropertiesChange(Sender: TObject);
    procedure cdsAltGloBeforePost(DataSet: TDataSet);
    procedure cxeMasFatPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltVALCAMGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure cxeMasIntPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxeMasPerPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeDatePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeConsTam2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeString03PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxeClassfIPIPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvTiposAltDataControllerFilterChanged(Sender: TObject);
    function RemoveAcento(const pText: string): string;
    procedure cxvTiposAltDESCAMGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure edtCodComExit(Sender: TObject);
    procedure edtCodComKeyPress(Sender: TObject; var Key: Char);
    procedure edtCestKeyPress(Sender: TObject; var Key: Char);
    procedure cxBtnMontadoraPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure cxvTiposAltKeyPress(Sender: TObject; var Key: Char);
    procedure edtClaIPIExit(Sender: TObject);
    procedure dtsAltGloDataChange(Sender: TObject; Field: TField);
    procedure btnPrecoPautaFiscalClick(Sender: TObject);
    procedure btnAddExprClick(Sender: TObject);
    procedure btnVisualizarExprClick(Sender: TObject);

  private
    { Private declarations }
    objFatPre: TFatorPreco;
    blnSuframa,
    blnVidroInteiro: Boolean;

    cdsSimNao,
    cdsIndRev,
    cdsSimNaoFornecedor,
    cdsClaCrm,
    cdsFrePFU,
    cdsEsMiDg,
    cdsTipPro,
    cdsTipRet: TZClient;

    intPosMatPreMatInicial,
    intPosMatPreMatFinal: Integer;

    intDecUni: Integer;
    intDecQtd: Integer;

    blnBloPre,
    blnValFor: Boolean;
    fltPMarLq : Double;

    blnSUFRAM: Boolean;

    strFrmCus,
    strMarMkp,
    strPcmPro,
    strMasVal: String;
    strMasVal2: String;
    strMasFat: String;
    strMasPer: String;
    strMasInt: String;
    strMasMar: String;
    strMasMBr: String;
    strMasDecUni: String;
    strMasDecQtd: String;
    strMasDec06: String;
    strMasDec05: String;

    qryConFor: TUniQuery;
    qryConAbf: TUniQuery;
    qryAbfIcm: TUniQuery;

    blnLiqNeg: Boolean;

    qryConGru: TUniQuery;
    arrCamposGlobal: Array Of TCampoGlobal;
    arrCamposTabela: Array Of TCampoGlobal;
    arrCamposGrid: TArrCampoGlobal;

    blnPreMat: Boolean;
    blnFilSai: Boolean;

    qryGenIte: TUniQuery;

    arrRecTabelasPreco: Array [1..7] Of TRecTabelaPrecos;

    blnAvisoAtivo: Boolean;
    blnSergipe   : Boolean;
    blnIteTbp    : Boolean;
    blnURapel    : Boolean;
    blnMarIde    : Boolean;
    blnCadLoc    : Boolean;
    blnPermiteManutencaoLocFis : Boolean;

    strEstEmp : String;

    strLinGru,
    strMarca ,
    strFornec,
    strPrdGru,
    strGruCmp,
    strCodGpr,
    strCodDep,
    strCodMon,
    strCodAbr,
    strCodUni,
    strCodCom,
    strClaIPI : String;

    arrAbfPis,
    arrAbfCof,
    arrLinhaGrupo,
    arrMarca,
    arrFornec,
    arrGrupoPro,
    arrGruCmp,
    arrCodGpr,
    arrCodDep,
    arrCodMon,
    arrCodAbr,
    arrCodUni,
    arrCodCom,
    arrClaIPI : TConsultasArray;

    intLocFis,
    intLocSup,
    intTamLcf,
    intLocSep : Integer;

    objSalInt: TSalvaInterface;

    fltDESMAX,
    fltDESMVM,
    fltDESMSU,
    fltDESMSM,
    fltDESMGE,
    fltDESMGM,
    fltMARMIN,
    fltMARMMV,
    fltMARMSG,
    fltMARMMS,
    fltMARMGE,
    fltMARMMG : Double;

    blnUtilizaChecklistGarantia: Boolean;
    blnTABPRD: Boolean;

    blnCarregandoCadInt: Boolean;
    FPermVendaIgualTodasEmp: Boolean;
    blnUsaBef : Boolean;

    objGerenciaExpr: TGerenciaExprAltGlobal;

    procedure pVerificaDireitoAcesso;
    function fExibe_ICMSAI_mesmo_nao_atualizaPreco: Boolean;
    procedure pLimparTela;
    procedure pHabilitaNotaEntrada(blnHabilitar: Boolean = False);

    procedure pAjustaOpcaoFornecedor;
    procedure pGeraClient;

    Function fGeraClient(cxProgresso: TcxProgressBar): Boolean;

    procedure pCarregaSelecao;
    procedure pSalvaSelecao;
    function fVerificaClaIpi: Boolean;

    function VerificarRefere: Boolean;

//    procedure pSalvaDados(strValCam, strDescri: String);

    Procedure pBeforePostMargem(dtsDtaSet: TDataSet);
    Function fCorrigeMargensNegativas: Boolean;

    function fTemConsultaTabela(strNomCam: String): Boolean;

    Function fValidaValor(strValor: String): Boolean;

    function fRetCamposIteFor: String;
    function fGeraVetorCampos: Boolean;
    function fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCriaTabelaItens;
    function  fGeraTabelaItens: Boolean;
    function fGeraTabelaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
    function fProdutoComSaldo(strCodIte: String): Boolean;

    procedure pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);

    procedure pAlteraValorTabelaItens(strCodIte: String; Var arrCampos: Array Of TCampoGlobal;
                                      fltCnvMl, fltSalMl, fltSaldoNumerico: Double);
    procedure pAtribuiTabelas;

    procedure pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String; varValor: Variant; strCodIte: String = '');

    function fArredonda(fltVlrOri: Double; intTabela: Integer; Var fltNovMarBru: Double): Double;
    function fRetornaNumeric(strMascara: String): String;
    function fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
      strNomeCampo: String): TCampoGlobal;
    procedure pMontaGrid;
    function fCalculaFatorNota: Double;

    Function fRetDescricaoCadastro(strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;

    function fRetDesAbfPisCofIpi(strTabela, strCod: String): String;

    procedure pAplicaConversorFornecedor(Var fltValor: Variant; fltCnvCus: Double);
    procedure pAjustaAlteracaoPorNota;

    Procedure pRetProperties(strNomProp: String; var AProperties: TcxCustomEditProperties);

    procedure pHabilitaCamposMargemIdeal;

    Procedure pCriaCdsSimNao;
    Procedure pCriaCdsIndRev;

    Procedure pCriaCdsClaCRM;
    Procedure pCriaCdsFrePFU;
    Procedure pCriaCdsEsMiDg;
    Procedure pCriaCdsTipPro;
    Procedure pCriaCdsTipRet;
    Procedure pCriaCdsSimNaoFornecedor;

    Procedure pLimpaListas;

    function fValidaAlteracaoAbreviacaoFiscal: Boolean;
    procedure pAtualizaSaldoDisponivel;
    function fAtualizaSaldoDisponivel(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fValidaDescontoMaximoOperador(Dataset : TDataset) : Boolean;
    function fValidaMargemMinimaOperador(Dataset : TDataset) : Boolean;
    function fRetornaValorCampo(strNomCampo : String) : Double;
    procedure pAlimentarVariaveisDescontoMax;
    procedure pAlimentarVariaveisMargemMin;
    function fCalcularValor(varValAtu, varValorRegAtual: Variant): Currency;
    procedure pSalvarClientDataSet;
    procedure pExcluirClientDataSet;
    function fCarregarClientDataSetAux(pgbProgresso: TCxProgressBar): Boolean;
    function fHaAlteracoesSalvas: Boolean;
    function fValidaLocalizacaoFisica(AStrFieldName: String): Boolean;
    procedure pCarregaPrecoPautaFiscal;
    function fCampoTipoNumero(arrCampos: Array Of TCampoGlobal; strNomeCampo: String): Boolean;

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pGetConteudo(var AStringList: TStringList);
  public
    { Public declarations }
    blnAltPorFator: Boolean;
    blnAltFornecedor: Boolean;
    blnAltPorNota : Boolean;
    strFiltro: string;
    enuCalculo: TTipoCalculo;
  end;

var
  frmAltPrecoGlobal: TfrmAltPrecoGlobal;

implementation

uses untPesqAux, untController.CheckListGarantia, untAltPrecoGlobalItens, untConsultas, untFuncoesConsulta,
     untConstantes, untParCalculaPrecoCusto, untTConfiguracao, cxCurrencyEdit,
     cxTextEdit, cxDBLookupComboBox, untAltPrecoGlobalMargemNeg, untAltPrecoGlobalPrecoPautaFiscal,
     untIcmsSTParteVenda, untIFatReservaSaldo, untTFatReservaSaldo,
     untTipoPermissaoVenda, untValidaHierarquia, untSelMontadoras, untCadLote, untLocFisAdicionais;

{$R *.dfm}

Procedure TfrmAltPrecoGlobal.pLimpaListas;
Begin
  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbIndRev.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbSimNaoFornecedor.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbTipPro.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbClaCRM.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbFrePFU.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := Nil;
  TcxLookupComboBoxProperties(cmbTipRet.Properties).ListSource := Nil;
End;

Procedure TfrmAltPrecoGlobal.pCriaCdsIndRev;
Begin
  cdsIndRev := TZClient.Create(Self, 'SELECT "I" AS VALCAM, "Industria" AS DESCAM UNION SELECT "R" AS VALCAM, "Revenda" AS DESCAM');
  cdsIndRev.fLeDados('TfrmAltPrecoGlobal.pCriaCdsIndRev');

  TcxLookupComboBoxProperties(cmbIndRev.Properties).ListSource := cdsIndRev.dtsSource;
End;

Procedure TfrmAltPrecoGlobal.pCriaCdsSimNao;
Begin
  cdsSimNao := TZClient.Create(Self, 'SELECT "S" AS VALCAM, "Sim" AS DESCAM UNION SELECT "N" AS VALCAM, "Não" AS DESCAM');
  cdsSimNao.fLeDados('TfrmAltPrecoGlobal.pCriaCdsSimNao');

  TcxLookupComboBoxProperties(cmbSimNao.Properties).ListSource := cdsSimNao.dtsSource;
End;


procedure TfrmAltPrecoGlobal.pCriaCdsSimNaoFornecedor;
begin
  cdsSimNaoFornecedor := TZClient.Create(Self, 'SELECT "S" AS VALCAM, "Sim" AS DESCAM UNION SELECT "N" AS VALCAM, "Não" AS DESCAM UNION SELECT "F" AS VALCAM, "Fornecedor" AS DESCAM');
  cdsSimNaoFornecedor.fLeDados('TfrmAltPrecoGlobal.pCriaCdsSimNaoFornecedor');

  TcxLookupComboBoxProperties(cmbSimNaoFornecedor.Properties).ListSource := cdsSimNaoFornecedor.dtsSource;

end;

Procedure TfrmAltPrecoGlobal.pCriaCdsTipPro;
  Var
    intContador: Integer;
Begin
  cdsTipPro := TZClient.Create(Self, 'SELECT "00" AS VALCAM, CAST("" AS CHAR(40)) AS DESCAM');
  cdsTipPro.fLeDados('TfrmAltPrecoGlobal.pCriaCdSTipPro');
  cdsTipPro.EmptyDataSet;

  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    cdsTipPro.Append;
    cdsTipPro.FieldByName('VALCAM').AsString := TIPO_PRODUTO_SPED[intContador][0];
    cdsTipPro.FieldByName('DESCAM').AsString := TIPO_PRODUTO_SPED[intContador][0] + ' - ' + TIPO_PRODUTO_SPED[intContador][1];
    cdsTipPro.Post;
  End;

  TcxLookupComboBoxProperties(cmbTipPro.Properties).ListSource := cdsTipPro.dtsSource;

End;

procedure TfrmAltPrecoGlobal.pCriaCdsTipRet;
var
  intCnt: Integer;
  lstLocRet: TStrings;
begin
  cdsTipRet := TZClient.Create(Self, 'SELECT "00" AS VALCAM, CAST("" AS CHAR(40)) AS DESCAM');
  cdsTipRet.fLeDados('TfrmAltPrecoGlobal.pCriaCdsTipRet');
  cdsTipRet.EmptyDataSet;

  lstLocRet := TStringList.Create;
  try
      pCarregaLocalRetira(lstLocRet);
      for intCnt := 0 to lstLocRet.Count - 1 do
      begin
          cdsTipRet.Append;
          cdsTipRet.FieldByName('VALCAM').AsString := fRetSiglaLocalRetira(lstLocRet.Strings[intCnt]);
          cdsTipRet.FieldByName('DESCAM').AsString := lstLocRet.Strings[intCnt];
          cdsTipRet.Post;
      end;
      TcxLookupComboBoxProperties(cmbTipRet.Properties).ListSource := cdsTipRet.dtsSource;
  finally
    FreeAndNil(lstLocRet);
  end;

    {
  strOPLORE := fCfgSis('OPLORE', varString);
  intTamCfg := Length(strOPLORE);

  For intCnt := 1 to intTamCfg Do
  Begin
    If strOPLORE[intCnt] = 'S' Then
    begin
      cdsTipRet.Append;
      cdsTipRet.FieldByName('VALCAM').AsString := IntToStr(intCnt);
      cdsTipRet.FieldByName('DESCAM').AsString := fVerificaDescAdicionalLocRet(ARR_LOC_RET_DESC[intCnt-1], intCnt);
      cdsTipRet.Post;
    end;
  End;  }




  {
  If not blnPermiteBalcao Then
  Begin
    intCnt := Items.IndexOf(fVerificaDescAdicionalLocRet('BALCÃO', IndexText('BALCÃO', ARR_LOC_RET_DESC) + 1));
    If intCnt > -1 then
      Items.Delete(intCnt);

    intCnt := Items.IndexOf(fVerificaDescAdicionalLocRet('BALCÃO 2', IndexText('BALCÃO 2', ARR_LOC_RET_DESC) + 1));
    If intCnt > -1 then
      Items.Delete(intCnt);
  End;    }

{  cdsTipRet := TZClient.Create(Self, 'SELECT DLR_LOCRET AS VALCAM, DLR_DESCRI AS DESCAM FROM CADDLR');
  cdsTipRet.fLeDados('TfrmAltPrecoGlobal.pCriaCdsTipRet');
  TcxLookupComboBoxProperties(cmbTipRet.Properties).ListSource := cdsTipRet.dtsSource;}
end;

Procedure TfrmAltPrecoGlobal.pCriaCdsClaCRM;
Begin
  cdsClaCrm := TZClient.Create(Self, 'SELECT "C" AS VALCAM, "Consumível" AS DESCAM UNION ' +
                                     'SELECT "P" AS VALCAM, "Principal"  AS DESCAM UNION ' +
                                     'SELECT "A" AS VALCAM, "Acessório"  AS DESCAM');

  cdsClaCrm.fLeDados('TfrmAltPrecoGlobal.pCriaCdsClaCrm');

  TcxLookupComboBoxProperties(cmbClaCRM.Properties).ListSource := cdsClaCRM.dtsSource;
End;

Procedure TfrmAltPrecoGlobal.pCriaCdsFrePFU;
Begin
  cdsFrePFU := TZClient.Create(Self, 'SELECT "P" AS VALCAM, "Percentual" AS DESCAM UNION ' +
                                     'SELECT "F" AS VALCAM, "Fixo"       AS DESCAM UNION ' +
                                     'SELECT "U" AS VALCAM, "Unitário"   AS DESCAM');

  cdsFrePFU.fLeDados('TfrmAltPrecoGlobal.pCriaCdsFrePFU');

  TcxLookupComboBoxProperties(cmbFrePFU.Properties).ListSource := cdsFrePFU.dtsSource;
End;

Procedure TfrmAltPrecoGlobal.pCriaCdsEsMiDg;
Begin
  cdsEsMiDg := TZClient.Create(Self, 'SELECT "G" AS VALCAM, "Gerado"   AS DESCAM UNION ' +
                                     'SELECT "D" AS VALCAM, "Digitado" AS DESCAM');

  cdsEsMiDg.fLeDados('TfrmAltPrecoGlobal.pCriaCdsEsMiDg');

  TcxLookupComboBoxProperties(cmbEsMiDg.Properties).ListSource := cdsEsMiDg.dtsSource;
End;

function TfrmAltPrecoGlobal.fValidaAlteracaoAbreviacaoFiscal: Boolean;
  Var
    strFilter : String;
    intRecNo : Integer;
    blnFiltered : Boolean;
begin
  Result := True;

  If chkPenRec.Checked Then
    Exit;

  If (fCfgSis('CLPVDI', varBoolean)) Then
  Begin
    strFilter := cdsAltGlo.Filter;
    blnFiltered := cdsAltGlo.Filtered;
    intRecNo := cdsAltGlo.RecNo;
    Try
      cdsAltGlo.Filtered := False;
      cdsAltGlo.Filter := 'ITE_NOMCAM = ' + QuotedStr('ITE_CODABF');
      cdsAltGlo.Filtered := True;

      If ((Not cdsAltGlo.IsEmpty) And (cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S')) Then
      Begin
        If fMensagem('', MSG_ALTERACAO_PRECO_VENDA_DINAMICA, ['&Sim', '&Não'], 1) = 2 Then
          Result := False;
      End;
    Finally
      cdsAltGlo.Filter := strFilter;
      cdsAltGlo.Filtered := blnFiltered;
      cdsAltGlo.RecNo := intRecNo;
    End;
  End;
end;

function TfrmAltPrecoGlobal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNomCam: String;
    strMasCam: String;
begin
  strNomCam := '';
  strMasCam := '';
  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtDesIte) Then
    Begin
    End

    Else If (Sender = edtRefere) Then
    Begin
    End

    Else If (Sender = edtTabPre) And pnlTabPre.Visible Then
    Begin
      If fEmptyStr(edtTabPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Tabela de Preço!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomTab.Text    := fRetNomeTabelaPreco(edtTabPre.Text);
        edtCodFor.Text    := fRetCodFornecedorTabelaPreco(edtTabPre.Text);
        edtNomFor.Text    := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomTab.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Tabela de Preço não econtrada!', ['&O k']);
          Result := False;
        End;
      End;
    End

  Else If (Sender = edtCest) Then
    Begin
      If Not fEmptyStr(edtCest.Text) Then
      Begin
        edtCestDesc.Text := fRetDesCDCEST(edtCest.Text);
        If fEmptyStr(edtCest.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação CEST não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtCest.Clear;
    End

    Else If (Sender = edtCodFor) And (Not blnAltFornecedor) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin

        If blnAltFornecedor Then
        Begin
          pMensagemOk('Informe o código do fornecedor para ativação dos preços!');
          Result := False;
        End Else
        Begin
          edtNomFor.Text := 'TODOS';
        End;

      End

    End

    Else If (Sender = edtDocumento) Then
    Begin

      If chkNotEnt.Checked Then
      Begin
        mskDtaEntFin.Enabled := fEmptyStr(edtDocumento.Text);
        mskDtaEntIni.Enabled := fEmptyStr(edtDocumento.Text);
        lblDtaFin.Enabled := fEmptyStr(edtDocumento.Text);
        lblDtaIni.Enabled := fEmptyStr(edtDocumento.Text);
        If Not mskDtaEntFin.Enabled Then
        Begin
          mskDtaEntFin.Text := '';
          mskDtaEntIni.Text := '';
        End;
      End;

    End

    Else If (Sender = edtCodEmpresa) Then
    Begin

      If chkNotEnt.Checked Then
      Begin
        If fEmptyStr(edtCodEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O código da empresa deve ser informado!', ['&O k']);
          Result := False;
        End
        else
        Begin

          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

          If fEmptyStr(edtDesEmpresa.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Código da empresa não encontrado!', ['&O K']);
            Result := False;
          End
        End;
      End;
    End

    Else If (Sender = edtExcIpi) Then
    Begin
      If Not fEmptyStr(edtExcIpi.Text) Then
        edtExcIpi.Text := fStrZero(edtExcIpi.Text, 3);
    End

    Else If (Sender = edtForNot) Then
    Begin
    
      If fEmptyStr(edtForNot.Text) And blnAltPorNota Then
      Begin
        fMensagem('', 'Informe o código do Fornecedor!', ['&O K']);
        Result := False;
      End

      Else If Not fEmptyStr(edtForNot.Text) Then
      Begin

        edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

        If fEmptyStr(edtDesForNot.Text) Then
        Begin
          fMensagem('','Fornecedor não encontrado!', ['&O K']);
          Result := False;
        End;

      End

      Else edtDesForNot.Clear;

    End

    Else If (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      If StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial Inválida!');
        Result := False;
      End;


    End
    Else
    If (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final Inválida!');
        Result := False;
      End;

      If Result Then
      Begin
        If StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
          Result := False;
        End;
      End;
    End
    //Se estiver marcado para informar nota fiscal deve ser informado o documento ou um periodo
    Else
    If (Sender = mskDtaEntFin) And (chkNotEnt.Checked) And (fEmptyStr(edtDocumento.Text)) And (fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O número do documento deve ser informado ou um periodo de entrada de nota.', ['&O k']);
      Result := False;
    End

    Else If Sender = edtStatus Then
    Begin

      If Pos(edtStatus.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;
    End

    Else If Sender = edtStatusCompra Then
    Begin

      If Pos(edtStatusCompra.Text, 'S_N_T_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Ativo para compra deve ser S, N ou T!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtDecUni) Then
    Begin
      if chkArrMai.Checked then
      Begin
        if ( StrToIntDef(edtDecUni.Text,0) < 0 ) Or
           ( StrToIntDef(edtDecUni.Text,0) > fCfgSis('DECUNI', varInteger) ) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'Valor indicado para arredondamento das casas decimais deve ser entre 0 e ' + fCfgSis('DECUNI', varString) + ' !', ['&OK']);
        End;

      End;

    End

    Else If Sender = edtPerAcr Then
    Begin

      If pnlTipAltNota.Visible Then
      Begin

        If fStrToFloat(edtPerAcr.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Percentual de Acréscimo do Preço de Compra deve ser maior que zero!', ['&Ok']);
          Result := False;
        End;

      End;

    End
    Else
    If ((Sender = MskDataIni) And (not fEmptyDate(MskDataIni.Text))) Then
    Begin
      If StrToDateDef(MskDataIni.Text, 0) <=0 Then
      Begin
        pMensagemOk('A Data Inicial Inválida!');
        Result := False;
      End;
    End
    Else
    If ((Sender = MskDataFim) And ((not fEmptyDate(MskDataFim.Text)) Or (not fEmptyDate(MskDataIni.Text))) )Then
    Begin
      If StrToDateDef(MskDataFim.Text, 0) <= 0 Then
      Begin
        pMensagemOk('A Data Final Inválida!');
        Result := False;
      End;

      If Result Then
      Begin
        If StrToDateDef(MskDataFim.Text, 0) < StrToDateDef(MskDataIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Data Inicial!');
          Result := False;
        End;
      End;
    End Else If (Sender = edtLocFis) Then
    Begin
      If blnCadLoc Then
      Begin
        edtDesLocFis.Text := fRetNomLocFisica(edtLocFis.Text);

        If fEmptyStr(edtDesLocFis.Text) Then
          edtDesLocFis.Text := 'TODOS';
      End
      Else if fEmptyStr(edtLocFis.Text) Then
        edtDesLocFis.Text := ''
      Else
        edtDesLocFis.Text := edtLocFis.Text;

    End
    Else If (Sender = edtEstadoAbfICMS) And (Assigned(objGerenciaExpr)) Then
    Begin
      If (Pos('ABF_IVA_ST_SAI_CCO', objGerenciaExpr.stlCamposUsados.CommaText) > 0) And (Not fEmptyStr(edtEstadoAbfICMS.Text)) Then
      Begin
        If (Not fValidaEstado(edtEstadoAbfICMS.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'O campo estado da abreviação ICMS não é valido!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If Assigned(objGerenciaExpr) Then
      Result := objGerenciaExpr.fValidaCamposFrames(Sender, blnBuscaPorChave);

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAltPrecoGlobal.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinhaGrupo, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmAltPrecoGlobal.mskLinGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, qryConGru, Key, arrLinhaGrupo, False) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pEscapePressed;
begin
  inherited;
end;

procedure TfrmAltPrecoGlobal.pExcluirClientDataSet;
var
  qryDel: TUniQuery;
begin
  Try
    qryDel := fCriaQuery;
    qryDel.SQL.Add('DELETE FROM ALTGLO WHERE ALT_CODEMP = :CODEMP AND ALT_CODOPE = :CODOPE');

    qryDel.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryDel.ParamByName('CODEMP').AsString := VS_strCodEmp;
    Try
      fStartTransaction;
      qryDel.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmAltPrecoGlobal.pExcluirClientDataSet]');
      End;
    End;
  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure TfrmAltPrecoGlobal.pGeraClient;
  Var
    frmGravando: TfrmGravando;
Begin
  TfrmGravando.fExecuta(fGeraClient, frmGravando, 'Criando dados para alteração...', True, True);
End;

procedure TfrmAltPrecoGlobal.pGetConteudo(var AStringList: TStringList);
begin
  AStringList.Add('Variaveis: blnAltPorFator = ' + IIf(blnAltPorFator, 'Sim', 'Nao'));
  AStringList.Add('Variaveis: blnAltFornecedor = ' + IIf(blnAltFornecedor, 'Sim', 'Nao'));
  AStringList.Add('Variaveis: blnAltPorNota = ' + IIf(blnAltPorNota, 'Sim', 'Nao'));

  cdsAltGlo.First;

  AStringList.Add('cdsAltGlo= [');
  while not cdsAltGlo.Eof Do
  Begin
    If cdsAltGloITE_ALTERA.AsString = 'S' Then
      AStringList.Add(cdsAltGloITE_NOMCAM.AsString + '=' +cdsAltGloITE_VALCAM.AsString);
    cdsAltGlo.Next;
  End;
  AStringList.Add(']');
end;

Function TfrmAltPrecoGlobal.fGeraClient(cxProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    intTabela: Integer;
    strCampoVisivel: String;
begin
  Result := True;

  cdsAltGlo.DisableControls;

  If cdsAltGlo.Active Then
    cdsAltGlo.EmptyDataSet;

  cdsAltGlo.Open;
  pSetaClient(cdsAltGlo);

  cxProgresso.Properties.Max := Length(arrCamposGlobal);

  If Assigned(objFatPre) Then
    for intTabela := 2 to 7 do
      If objFatPre.fTabelaAtiva(intTabela) Then
        strCampoVisivel := strCampoVisivel + '_ITE_PREVE' + intTabela.ToString  +
          '_ITE_MARBR' + intTabela.ToString +
          '_ITE_COMTB' + intTabela.ToString;

  With cdsAltGlo Do
  For intContador := 0 To Length(arrCamposGlobal) -1 Do
  Begin
    cxProgresso.Position := cxProgresso.Position  + 1;
    Application.ProcessMessages;

    If blnFilSai Then
    Begin

      If blnPreMat And (intContador In [intPosMatPreMatInicial..intPosMatPreMatFinal]) And
         (Pos('ITE_ICMSAI', arrCamposGlobal[intContador].strNomCam) = 0) And
         (Pos('ITE_DESOPE', arrCamposGlobal[intContador].strNomCam) = 0) And
         (Pos('ITE_IMPFED', arrCamposGlobal[intContador].strNomCam) = 0) Then
        Continue;

    End;

    If ((Pos('ITE_COMTB', arrCamposGlobal[intContador].strNomCam) > 0) Or
        (Pos('ITE_MINTB', arrCamposGlobal[intContador].strNomCam) > 0)) And
       (VS_strTabPrc[StrToIntDef(RightStr(arrCamposGlobal[intContador].strNomCam, 1), 0)] <> 'S') Then
    Begin
      Continue;
    End;

    If ((Pos('ITE_PREVE', arrCamposGlobal[intContador].strNomCam) > 0) Or
        (Pos('ITE_MARBR', arrCamposGlobal[intContador].strNomCam) > 0)) And
       blnBloPre Then
    Begin
      Continue;
    End;

    If (rdgTipAlt.ItemIndex = 0)                                      And
       (Pos('ITE_PREVE', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    If (rdgTipAlt.ItemIndex In [1,2])                                 And
       (Pos('ITE_MARBR', arrCamposGlobal[intContador].strNomCam) > 0) Then
    Begin
      Continue;
    End;

    If (Pos('ITE_QTPPRO', arrCamposGlobal[intContador].strNomCam) > 0) And
       (Pos(fCfgSis('TCOPRO'), '3_4_') <= 0) Then
      Continue;

    If (Pos(arrCamposGlobal[intContador].strNomCam, 'ITE_MARLQ1_ITE_MARLQ2_ITE_MARLQ3_ITE_MARLQ4_ITE_MARLQ5_ITE_MARLQ6_ITE_MARLQ7_') > 0) Then
      Continue;

    If (Not Assigned(objFatPre)) Or
       (Pos(arrCamposGlobal[intContador].strNomCam,strCampoVisivel) <= 0) Then
    Begin
      Append;
      FieldByName('ITE_DESCAM').AsString  := arrCamposGlobal[intContador].strDesCam + '|' +
                                             RemoveAcento(arrCamposGlobal[intContador].strDesCam);
      FieldByName('ITE_PROPER').AsString  := arrCamposGlobal[intContador].strProper;
//      FieldByName('ITE_VALCAM').Value     := arrCamposGlobal[intContador].varValCam;
      FieldByName('ITE_VALCAM').Value     := Null;
      FieldByName('ITE_MASCAM').AsString  := arrCamposGlobal[intContador].strMasCam;
      FieldByName('ITE_NOMCAM').AsString  := arrCamposGlobal[intContador].strNomCam;
      FieldByName('ITE_DESABR').AsString  := arrCamposGlobal[intContador].strDesAbr;
      FieldByName('ITE_LIMCAM').AsInteger := arrCamposGlobal[intContador].intLimCam;
      FieldByName('ITE_TIPCAM').AsString  := arrCamposGlobal[intContador].strTipCam;
      FieldByName('ITE_ALTERA').AsString  := 'N';
      Post;
    End;

  End;

  cdsAltGlo.First;

  cdsAltGlo.EnableControls;
end;

procedure TfrmAltPrecoGlobal.pAtribuiTabelas;
begin
  qryAbfIcm := fCriaQuery(Self);
  
  qryConGru := fCriarQuery('SELECT * FROM CADGRU WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConAbf := qryAbfIcm;
end;

procedure TfrmAltPrecoGlobal.btnSairAltClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAltPrecoGlobal.btnVisualizarExprClick(Sender: TObject);
begin
  inherited;
  objGerenciaExpr.pVisualizar;
end;

procedure TfrmAltPrecoGlobal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pLimpaListas;

  pSalvaSelecao;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryAbfIcm);

  FreeAndNil(cdsAltGlo);
  FreeAndNil(cdsIteGlo);

  If Assigned(cdsPrecoPautaFiscal) Then
    FreeAndNil(cdsPrecoPautaFiscal);
end;

Procedure TfrmAltPrecoGlobal.pBeforePostMargem(dtsDtaSet: TDataSet);

  function fPrecoVenda(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
    Var
      fltIcmsST : Double;
      blnCalcSt : Boolean;
      strCodSit : String;
      fltPreComLiq : Double;
  begin
    With dtsDtaSet Do
    Begin
      fltPreComLiq := fCalculaPrecoCompraLiq(FieldByName('ITE_PRECOM_NOV').AsFloat,
                                             FieldByName('ITE_DESF01_NOV').AsFloat,
                                             FieldByName('ITE_DESF02_NOV').AsFloat,
                                             FieldByName('ITE_DESF03_NOV').AsFloat,
                                             FieldByName('ITE_DESF04_NOV').AsFloat,
                                             FieldByName('ITE_DESF05_NOV').AsFloat,
                                             FieldByName('ITE_DESF06_NOV').AsFloat,
                                             intDecUni,
                                             (FieldByName('ITE_PREDOL_NOV').AsString = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [FieldByName('ITE_CODABF_NOV').AsString, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(FieldByName('ITE_CODABF_NOV').AsString,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, FieldByName('ITE_IPIENT_NOV').AsFloat,
                                        FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                        strEstEmp, blnCalcSt);

      Result := fCalculaPrecoVenda(intOpc, FieldByName('ITE_PRECUS_NOV').AsFloat +
                                           FieldByName('ITE_OUTVAL_NOV').AsFloat,
                                           FieldByName('ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').AsFloat * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                           FieldByName('ITE_MARBR' + IntToStr(intTabPrc) + '_NOV').AsFloat,
                                           FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                           FieldByName('ITE_IMPFED_NOV').AsFloat,
                                           FieldByName('ITE_DESOPE_NOV').AsFloat,
                                           FieldByName('ITE_COMTB' + IntToStr(intTabPrc) + '_NOV').AsFloat,
                                           strMarMkp,
                                           strPcmPro,
                                           intDecUni,
                                           fltIcmsST,
                                           blnCalcSt);
    End;
  end;

  Var
    intTabPrc: Integer;
Begin
  For intTabPrc := 1 To 7 Do
  With dtsDtaSet Do
  Begin
    FieldByName('ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').AsFloat := fPrecoVenda(1, intTabPrc, False);
    FieldByName('ITE_MARLQ' + IntToStr(intTabPrc) + '_NOV').AsFloat := fPrecoVenda(2, intTabPrc, True);
  End;

End;

Function TfrmAltPrecoGlobal.fCorrigeMargensNegativas: Boolean;

  Function fRetFiltroNegativos: String;
    Var
      intContador: Integer;
  Begin
    Result := '';

    For intContador := 1 To 7 Do
      if VS_strTabPrc[intContador] = 'S' Then
      Begin
        If Not fEmptyStr(Result) Then
          Result := Result + ' OR ';

        Result := Result + ' (ITE_MARLQ' + IntToStr(intContador) + '_NOV < 0) ';
      End
  End;

  Procedure pMarcaNegativos;
  Begin
    With cdsIteGlo Do
    Begin
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('MARNEG').AsInteger := 1;
        Post;

        Next;
      End;

      Filter   := 'MARNEG = 1';
      Filtered := True;

      First;
    End;
  End;

Begin
  If Not blnLiqNeg Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    With cdsIteGlo Do
    Begin
      DisableControls;

      Filter   := fRetFiltroNegativos;
      Filtered := True;

      If IsEmpty  Then
      Begin
        Result   := True;
        Filter   := '';
        Filtered := False;
      End Else
      Begin

        pMarcaNegativos;

        BeforePost := pBeforePostMargem;

        EnableControls;

        pCriarFormularios(TfrmAltPrecoGlobalMargemNeg, frmAltPrecoGlobalMargemNeg);

        frmAltPrecoGlobalMargemNeg.cdsIteGlo := cdsIteGlo;

        frmAltPrecoGlobalMargemNeg.strFilter := fRetFiltroNegativos;

        Result := frmAltPrecoGlobalMargemNeg.ShowModal = mrOk;

        FreeAndNil(frmAltPrecoGlobalMargemNeg);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoGlobal.fCorrigeMargensNegativas]');
      Result := False;
    End;
  End;

  With cdsIteGlo Do
  Begin
    EnableControls;
    Filter   := '';
    Filtered := False;
    BeforePost := Nil;
  End;

End;

function TfrmAltPrecoGlobal.fExibe_ICMSAI_mesmo_nao_atualizaPreco: Boolean;
var
  usaMkp: Boolean;
  cfgMARMKP: Integer;
begin
  cfgMARMKP := fCfgSis('MARMKP', varInteger);
  Result := ((not blnPreMat) Or blnFilSai) and (not blnTABPRD) And (not blnAltFornecedor);

  If not Result Then
  Begin
    usaMkp := cfgMARMKP in [1,2,3];
    Result :=  (Not blnTABPRD) And (not blnAltFornecedor) And
               ((fCfgSis('TIPABF',varString) = '2') and fCfgSis('ABICMS',varBoolean) and usaMkp);
  End;
end;

procedure TfrmAltPrecoGlobal.btnAddExprClick(Sender: TObject);
begin
  inherited;
  objGerenciaExpr.pAdicionar;
end;

procedure TfrmAltPrecoGlobal.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
    blnBlockMarLq : Boolean;
begin
  If fOperadorLimitado(Trim(strLoginUsuarioLogado)) Then
    Exit;

  inherited;

  If (Not btnConfirma.Enabled) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  blnConfirma := False;

  pAlimentarVariaveisDescontoMax;
  pAlimentarVariaveisMargemMin;

  If not fValidaDescontoMaximoOperador(cdsAltGlo) Then
    Exit;

  If not fValidaMargemMinimaOperador(cdsAltGlo) Then
    Exit;

  If (Not blnAltFornecedor) And (Not fVerificaClaIpi) Then
    Exit;

  If Not fValidaLocalizacaoFisica('ITE_LOCFIS') Then
    Exit;

  If Not fValidaLocalizacaoFisica('ITE_LOCSUP') Then
      Exit;

  If Not VerificarRefere Then
    Exit;

  Screen.Cursor := crHourGlass;

  btnConfirma.Enabled    := False;
  btnSairAlt.Enabled     := False;

  If cdsIteGlo.Active Then
    cdsIteGlo.EmptyDataSet;

  If Not fValidaAlteracaoAbreviacaoFiscal Then
    Exit;

  If (Not fGeraVetorCampos) aND (Not blnAltFornecedor) Then
  Begin
    fMensagem('', 'É necessário marcar pelo menos um campo para alteração!', ['&O k']);
    btnConfirma.Enabled    := True;
    btnSairAlt.Enabled     := True;
    Screen.Cursor          := crDefault;
    Exit;
  End;

  pCriaTabelaItens;

  If chkManterUltAlt.Checked Then
    pSalvarClientDataSet
  Else
    pExcluirClientDataSet;

  blnBlockMarLq := False;
  If fGeraTabelaItens And fCorrigeMargensNegativas Then
  Begin

    Try
      pCriarFormularios(TfrmAltPrecoGlobalItens, frmAltPrecoGlobalItens);
      frmAltPrecoGlobalItens.blnTabPrd := blnTabPrd;
      frmAltPrecoGlobalItens.blnExiSal := chkExiSal.Checked;
      frmAltPrecoGlobalItens.strCodTab := edtTabPre.Text;

      frmAltPrecoGlobalItens.blnAltFornecedor := blnAltFornecedor;

      if blnBlockMarLq Then
      Begin
        frmAltPrecoGlobalItens.btnConfirma.Enabled := False;
        fMensagem('', 'Não será possível atualizar os itens devido a Margem Líquida Negativa!', ['&OK'])
      End;

      frmAltPrecoGlobalItens.cdsPrecoPautaFiscal := cdsPrecoPautaFiscal;
      frmAltPrecoGlobalItens.dtsItens.DataSet := cdsIteGlo;
      frmAltPrecoGlobalItens.arrCamposGrid := arrCamposGrid;
      frmAltPrecoGlobalItens.lblAvisoAtivo.Visible := blnAvisoAtivo;
      frmAltPrecoGlobalItens.showModal;

      blnConfirma := frmAltPrecoGlobalItens.blnConfirma;

    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro(E.Message, '[frmAltPrecoGlobal.btnConfirmaClick]');
      End;
    End;

    pFreeAndNil(frmAltPrecoGlobalItens);

  End;

  btnConfirma.Enabled    := True;
  btnSairAlt.Enabled     := True;
  Screen.Cursor          := crDefault;

  If blnConfirma Then
  Begin
    TGravaDadosFormulario.pExecutaGravacao(Self, pGetConteudo);
    pLimparTela;
  End;
end;

procedure TfrmAltPrecoGlobal.pCriaTabelaItens;
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intCorre : Integer;
    intContador: Integer;
begin

  {***************************************************************************************************}
  { AO ALTERAR O SELECT, VALIDAR A UNIT untAltPrecoGlobalTPO - TfrmAltPrecoGlobalTPO.pCriaTabelaItens }
  { PARA NÃO GERAR ERRO DE FALTA DE CAMPO.                                                            }
  {***************************************************************************************************}

  strSQL := '';
  strSQL := strSQL + 'SELECT ';

  If blnAltFornecedor Then
    strSQL := strSQL + fRetCamposIteFor;

  strSQL := strSQL + '  0 AS MARNEG, ';

  strSQL := strSQL + '  I.ITE_CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE, ';

  strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
  strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '      AND ITB_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
  strSQL := strSQL + ' AS ITE_POSEMB, ';

  strSQL := strSQL + '  I.ITE_CODLUB, ';
  strSQL := strSQL + '  I.ITE_CODLUB AS "ITE_CODLUB_NOV", ';
  strSQL := strSQL + '  I.ITE_DESANP, ';
  strSQL := strSQL + '  I.ITE_DESANP AS "ITE_DESANP_NOV", ';

  strSQL := strSQL + '  0.00 AS ITE_SALDOS, ';

  strSQL := strSQL + '  G.ITE_SAL_ML, ';
  strSQL := strSQL + '  I.ITE_CNV_ML, ';

  If fCfgSis('ENTFUT', varBoolean) And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']) Then
    strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)) + G.ITE_QTEF_A + G.ITE_QTEF_F + G.ITE_QTEF_P, 3) AS "SaldoNumerico", '
  Else
    strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)), 3) AS "SaldoNumerico", ';

  strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL, ';
  strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL_NOV, ';
  strSQL := strSQL + '  I.ITE_CODGRU, ';
  strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU_NOV", ';
  strSQL := strSQL + '  I.ITE_REFERE, ';
  strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE_NOV", ';
  strSQL := strSQL + '  I.ITE_ACOOBJ, ';
  strSQL := strSQL + '  I.ITE_ACOOBJ AS "ITE_ACOOBJ_NOV", ';
  strSQL := strSQL + '  I.ITE_USAPFD, ';
  strSQL := strSQL + '  I.ITE_USAPFD AS "ITE_USAPFD_NOV", ';
  strSQL := strSQL + '  I.ITE_USAPCV, ';
  strSQL := strSQL + '  I.ITE_USAPCV AS "ITE_USAPCV_NOV", ';

  If fCfgSis('TRITTE', varBoolean) Then
  Begin
    strSQL := strSQL + '  I.ITE_TRITTE, ';
    strSQL := strSQL + '  I.ITE_TRITTE AS "ITE_TRITTE_NOV", ';
  End;

  if fCfgSis('NFEPEP', varBoolean) then
  begin
    strSQL := strSQL + '  G.ITE_OBRNFE, ';
    strSQL := strSQL + '  G.ITE_OBRNFE AS "ITE_OBRNFE_NOV", ';
  end
  else
  begin
    strSQL := strSQL + '  I.ITE_OBRNFE, ';
    strSQL := strSQL + '  I.ITE_OBRNFE AS "ITE_OBRNFE_NOV", ';
  end;

  strSQL := strSQL + '  I.ITE_FATCMP, ';
  strSQL := strSQL + '  I.ITE_FATCMP AS ITE_FATCMP_NOV , ';

  strSQL := strSQL + '  I.ITE_FATPM3, ';
  strSQL := strSQL + '  I.ITE_FATPM3 AS ITE_FATPM3_NOV, ';

  strSQL := strSQL + '  I.ITE_CODCOM, ';
  strSQL := strSQL + '  I.ITE_CODCOM AS "ITE_CODCOM_NOV", ';


  If fCfgSIs('IMPDIG') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_IMPDIR, ';
    strSQL := strSQL + '  I.ITE_IMPDIR AS "ITE_IMPDIR_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_IMPDIR, ';
    strSQL := strSQL + '  G.ITE_IMPDIR AS "ITE_IMPDIR_NOV", ';
  End;

  If fCfgSIs('TIPABF') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_USAPPF, ';
    strSQL := strSQL + '  I.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_USAPPF, ';
    strSQL := strSQL + '  G.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
  End;

  If fCfgSIs('INDREV') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_INDREV, ';
    strSQL := strSQL + '  I.ITE_INDREV AS "ITE_INDREV_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_INDREV, ';
    strSQL := strSQL + '  G.ITE_INDREV AS "ITE_INDREV_NOV", ';
  End;


  If fCfgSIs('TIPABF') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_CODABF, ';
    strSQL := strSQL + '  I.ITE_CODABF AS "ITE_CODABF_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_CODABF, ';
    strSQL := strSQL + '  G.ITE_CODABF AS "ITE_CODABF_NOV", ';
  End;

  If fCfgSis('TPABPC') = '1' Then
  Begin
    strSQL := strSQL + '  I.ITE_ABFPIS, ';
    strSQL := strSQL + '  I.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
    strSQL := strSQL + '  I.ITE_ABFCOF, ';
    strSQL := strSQL + '  I.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
    strSQL := strSQL + '  I.ITE_ABFIPI, ';
    strSQL := strSQL + '  I.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
  End
  Else
  Begin
    strSQL := strSQL + '  G.ITE_ABFPIS, ';
    strSQL := strSQL + '  G.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
    strSQL := strSQL + '  G.ITE_ABFCOF, ';
    strSQL := strSQL + '  G.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
    strSQL := strSQL + '  G.ITE_ABFIPI, ';
    strSQL := strSQL + '  G.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
  End;

  strSQL := strSQL + '  G.ITE_PRAMIN, ';
  strSQL := strSQL + '  G.ITE_PRAMIN AS "ITE_PRAMIN_NOV", ';

  strSQL := strSQL + '  I.ITE_REAEND, ';
  strSQL := strSQL + '  I.ITE_REAEND AS "ITE_REAEND_NOV", ';

  strSQL := strSQL + '  I.ITE_OBRBAR, ';
  strSQL := strSQL + '  I.ITE_OBRBAR AS "ITE_OBRBAR_NOV", ';

  strSQL := strSQL + '  I.ITE_FATCOM, ';
  strSQL := strSQL + '  I.ITE_FATCOM AS "ITE_FATCOM_NOV", ';

  strSQL := strSQL + '  I.ITE_DIAFOR, ';
  strSQL := strSQL + '  I.ITE_DIAFOR AS "ITE_DIAFOR_NOV", ';

  strSQL := strSQL + '  I.ITE_MLTSPO, ';
  strSQL := strSQL + '  I.ITE_MLTSPO AS "ITE_MLTSPO_NOV", ';

  strSQL := strSQL + '  I.ITE_GRUCMP, ';
  strSQL := strSQL + '  I.ITE_GRUCMP AS "ITE_GRUCMP_NOV", ';
  
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODFAB AS "ITE_CODFAB_NOV", ';

  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_DESFAB AS "ITE_DESFAB_NOV", ';

  strSQL := strSQL + '  I.ITE_INCPIS, ';
  strSQL := strSQL + '  I.ITE_INCPIS AS "ITE_INCPIS_NOV", ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_COMLUB AS "ITE_COMLUB_NOV", ';
  strSQL := strSQL + '  G.ITE_IMPLIS, ';
  strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", ';
  strSQL := strSQL + '  I.ITE_ITEATI, ';
  strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI_NOV", ';
  strSQL := strSQL + '  I.ITE_GRAMAR, ';
  strSQL := strSQL + '  I.ITE_GRAMAR AS "ITE_GRAMAR_NOV", ';
  strSQL := strSQL + '  I.ITE_CODUNI, ';
  strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", ';
  strSQL := strSQL + '  I.ITE_UNICOM, ';
  strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", ';
  strSQL := strSQL + '  I.ITE_CSTORI, ';
  strSQL := strSQL + '  I.ITE_CSTORI AS "ITE_CSTORI_NOV", ';


  If fCfgSis('UNITRI') = 'S' Then
  Begin
    strSQL := strSQL + '  I.ITE_UNITRI, ';
    strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", ';

    strSQL := strSQL + '  I.ITE_FATUTR, ';
    strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", ';
  End;

  strSQL := strSQL + '  I.ITE_CODMAR, ';
  strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR_NOV", ';

  strSQL := strSQL + '  G.ITE_SITPRO, ';
  strSQL := strSQL + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", ';

  If blnValFor Then
  Begin
    strSQL := strSQL + '  G.ITE_DTAVAL, ';
    strSQL := strSQL + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", ';
  End;

  strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS ITE_CODMON, ';
  strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS "ITE_CODMON_NOV", '; //Montadora
  strSQL := strSQL + '  I.ITE_ITEBAS, ';
  strSQL := strSQL + '  I.ITE_ITEBAS AS "ITE_ITEBAS_NOV", ';
  strSQL := strSQL + '  I.ITE_PROEMB, ';
  strSQL := strSQL + '  I.ITE_PROEMB AS "ITE_PROEMB_NOV", ';
  strSQL := strSQL + '  I.ITE_EMBALA, ';
  strSQL := strSQL + '  I.ITE_EMBALA AS "ITE_EMBALA_NOV", ';
  strSQL := strSQL + '  I.ITE_MESGIR, ';
  strSQL := strSQL + '  I.ITE_MESGIR AS "ITE_MESGIR_NOV", ';
  strSQL := strSQL + '  I.ITE_TMPGAR, ';
  strSQL := strSQL + '  I.ITE_TMPGAR AS "ITE_TMPGAR_NOV", ';
  strSQL := strSQL + '  I.ITE_INFGAR, ';
  strSQL := strSQL + '  I.ITE_INFGAR AS "ITE_INFGAR_NOV", ';
  strSQL := strSQL + '  I.ITE_RSPGAR, ';
  strSQL := strSQL + '  I.ITE_RSPGAR AS "ITE_RSPGAR_NOV", ';
  strSQL := strSQL + '  I.ITE_MLTCOM, ';
  strSQL := strSQL + '  I.ITE_MLTCOM AS "ITE_MLTCOM_NOV", ';
  strSQL := strSQL + '  I.ITE_MLTVEN, ';
  strSQL := strSQL + '  I.ITE_MLTVEN AS "ITE_MLTVEN_NOV", ';

  strSQL := strSQL + '  I.ITE_DIFICM, ';
  strSQL := strSQL + '  I.ITE_DIFICM AS "ITE_DIFICM_NOV", ';

  strSQL := strSQL + '  I.ITE_MSGLV1, ';
  strSQL := strSQL + '  I.ITE_MSGLV1 AS "ITE_MSGLV1_NOV", ';
  strSQL := strSQL + '  I.ITE_MSGLV2, ';
  strSQL := strSQL + '  I.ITE_MSGLV2 AS "ITE_MSGLV2_NOV", ';
  strSQL := strSQL + '  I.ITE_ITEPIG, ';
  strSQL := strSQL + '  I.ITE_ITEPIG AS "ITE_ITEPIG_NOV", ';
  strSQL := strSQL + '  I.ITE_FATCNV, ';
  strSQL := strSQL + '  I.ITE_FATCNV AS "ITE_FATCNV_NOV", ';
  strSQL := strSQL + '  I.ITE_PESOIT, ';
  strSQL := strSQL + '  I.ITE_PESOIT AS "ITE_PESOIT_NOV", ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_PESLIQ AS "ITE_PESLIQ_NOV", ';
  strSQL := strSQL + '  G.ITE_CPRCEN, ';
  strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
  strSQL := strSQL + '  G.ITE_ABAMLT, ';
  strSQL := strSQL + '  G.ITE_ABAMLT AS "ITE_ABAMLT_NOV", ';
  strSQL := strSQL + '  I.ITE_BAREXP, ';
  strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP_NOV", ';
  strSQL := strSQL + '  I.ITE_SEPBAR, ';
  strSQL := strSQL + '  I.ITE_SEPBAR AS "ITE_SEPBAR_NOV", ';
  strSQL := strSQL + '  G.ITE_DESCHK, ';
  strSQL := strSQL + '  G.ITE_DESCHK AS "ITE_DESCHK_NOV", ';


  strSQL := strSQL + '  G.ITE_CICMDE, ';
  strSQL := strSQL + '  G.ITE_CICMDE AS "ITE_CICMDE_NOV", ';
  strSQL := strSQL + '  G.ITE_CDPIOP, ';
  strSQL := strSQL + '  G.ITE_CDPIOP AS "ITE_CDPIOP_NOV", ';
  strSQL := strSQL + '  G.ITE_DIDIOP, ';
  strSQL := strSQL + '  G.ITE_DIDIOP AS "ITE_DIDIOP_NOV", ';

  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  I.ITE_OBRCPF AS "ITE_OBRCPF_NOV", ';
  strSQL := strSQL + '  I.ITE_OBRIBA, ';
  strSQL := strSQL + '  I.ITE_OBRIBA AS "ITE_OBRIBA_NOV", ';

  strSQL := strSQL + '  G.ITE_PONEXP, ';
  strSQL := strSQL + '  G.ITE_PONEXP AS "ITE_PONEXP_NOV", ';

  strSQL := strSQL + '  G.ITE_PRECOM, ';
  strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR1", ';

  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR2", ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR3", ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR4", ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR5", ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR6", ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';
  strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_VENVAR7", ';
  strSQL := strSQL + '  G.ITE_DESF01, ';
  strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF02, ';
  strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF03, ';
  strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF04, ';
  strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF05, ';
  strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
  strSQL := strSQL + '  G.ITE_DESF06, ';
  strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMENT, ';
  strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBFED, ';
  strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_IPISAI AS "ITE_IPISAI_NOV", ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
  strSQL := strSQL + '  G.ITE_VALFRE, ';
  strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
  strSQL := strSQL + '  G.ITE_ACRFIN, ';
  strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
  strSQL := strSQL + '  G.ITE_SUBSTI, ';
  strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
  strSQL := strSQL + '  G.ITE_DESADB, ';
  strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
  strSQL := strSQL + '  G.ITE_TCIFCU, ';
  strSQL := strSQL + '  G.ITE_TCIFCU AS "ITE_TCIFCU_NOV", ';
  strSQL := strSQL + '  G.ITE_TSCUST, ';
  strSQL := strSQL + '  G.ITE_TSCUST AS "ITE_TSCUST_NOV", ';
  strSQL := strSQL + '  G.ITE_DEPICO, ';
  strSQL := strSQL + '  G.ITE_DEPICO AS "ITE_DEPICO_NOV", ';
  strSQL := strSQL + '  G.ITE_DEICMS, ';
  strSQL := strSQL + '  G.ITE_DEICMS AS "ITE_DEICMS_NOV", ';
  strSQL := strSQL + '  G.ITE_FATREG, ';
  strSQL := strSQL + '  G.ITE_FATREG AS "ITE_FATREG_NOV", ';


  If blnTABPRD and (not blnAltFornecedor) then
  Begin

    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")  AS ITE_PREDOL' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")  AS ITE_CODABF' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM)  AS ITE_PRECOM' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01)  AS ITE_DESF01' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02)  AS ITE_DESF02' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03)  AS ITE_DESF03' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04)  AS ITE_DESF04' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05)  AS ITE_DESF05' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06)  AS ITE_DESF06' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT)  AS ITE_ICMENT' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED)  AS ITE_SUBFED' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT)  AS ITE_IPIENT' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT)  AS ITE_FREENT' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE)  AS ITE_VALFRE' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN)  AS ITE_ACRFIN' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB)  AS ITE_DESADB' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS)  AS ITE_PRECUS' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL)  AS ITE_OUTVAL' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI)  AS ITE_ICMSAI' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED)  AS ITE_IMPFED' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE)  AS ITE_DESOPE' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU)  AS ITE_TCIFCU' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST)  AS ITE_TSCUST' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO)  AS ITE_DEPICO' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS)  AS ITE_DEICMS' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG)  AS ITE_FATREG' + IntToStr(intContador) + ',';
      strSQL := strSQL + '  IF(IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1))AS ITE_CNVCUS'+ IntToStr(intContador)+' ,';
      strSQL := strSQL + '  DC' + IntToStr(intContador) + '.DET_SEQDET AS  DETCUS_AUTOINCREM_' + IntToStr(intContador) + ',';

    End;
  End;

  If Not blnIteTbp Then
  Begin
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMGE, ';
    strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMSU, ';
    strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMVM AS "ITE_DESMVM_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';
    strSQL := strSQL + '  G.ITE_DESMGM AS "ITE_DESMGM_NOV", ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMSM AS "ITE_DESMSM_NOV", ';
  End
  Else
  Begin
    For intCorre := 1 To Length(VS_strTabPrc) Do
      strSQL := strSQL + fAddIteTbp(intCorre);
  End;

  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
  strSQL := strSQL + '  0.0 AS "ITE_CUSVAR", ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR1, ';
  strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR2, ';
  strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR3, ';
  strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR4, ';
  strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR5, ';
  strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR6, ';
  strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
  strSQL := strSQL + '  G.ITE_MARBR7, ';
  strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';

  strSQL := strSQL + ' 0.00 AS ITE_MARLQ1, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ1_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ2, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ2_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ3, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ3_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ4, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ4_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ5, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ5_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ6, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ6_NOV", ';
  strSQL := strSQL + ' 0.00 AS ITE_MARLQ7, ';
  strSQL := strSQL + ' 0.00 AS "ITE_MARLQ7_NOV", ';

  If fCfgSis('MARIDE', VarBoolean) Then
  Begin
    strSQL := strSQL + '  G.ITE_MARID1, ';
    strSQL := strSQL + '  G.ITE_MARID1 AS "ITE_MARID1_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID2, ';
    strSQL := strSQL + '  G.ITE_MARID2 AS "ITE_MARID2_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID3, ';
    strSQL := strSQL + '  G.ITE_MARID3 AS "ITE_MARID3_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID4, ';
    strSQL := strSQL + '  G.ITE_MARID4 AS "ITE_MARID4_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID5, ';
    strSQL := strSQL + '  G.ITE_MARID5 AS "ITE_MARID5_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID6, ';
    strSQL := strSQL + '  G.ITE_MARID6 AS "ITE_MARID6_NOV", ';
    strSQL := strSQL + '  G.ITE_MARID7, ';
    strSQL := strSQL + '  G.ITE_MARID7 AS "ITE_MARID7_NOV", ';
  End;

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';
  strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMATA AS "ITE_COMATA_NOV", ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", ';
  strSQL := strSQL + '  G.ITE_COMDIG, ';
  strSQL := strSQL + '  G.ITE_COMDIG AS "ITE_COMDIG_NOV", ';
  strSQL := strSQL + '  G.ITE_COMMEC, ';
  strSQL := strSQL + '  G.ITE_COMMEC AS "ITE_COMMEC_NOV", ';
  strSQL := strSQL + '  G.ITE_COMPRO, ';
  strSQL := strSQL + '  G.ITE_COMPRO AS "ITE_COMPRO_NOV", ';
  strSQL := strSQL + '  G.ITE_QTPPRO, ';
  strSQL := strSQL + '  G.ITE_QTPPRO AS "ITE_QTPPRO_NOV", ';
  strSQL := strSQL + '  I.ITE_UNICOM, ';
  strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", ';

  If fCfgSis('UNITRI') = 'S' Then
  Begin
    strSQL := strSQL + '  I.ITE_UNITRI, ';
    strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", ';

    strSQL := strSQL + '  I.ITE_FATUTR, ';
    strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", ';
  End;

  strSQL := strSQL + '  I.ITE_ATICOM, ';
  strSQL := strSQL + '  I.ITE_ATICOM AS "ITE_ATICOM_NOV", ';
  strSQL := strSQL + '  I.ITE_PEEFUT, ';
  strSQL := strSQL + '  I.ITE_PEEFUT AS "ITE_PEEFUT_NOV", ';
  strSQL := strSQL + '  I.ITE_PEFUTP, ';
  strSQL := strSQL + '  I.ITE_PEFUTP AS "ITE_PEFUTP_NOV", ';
  strSQL := strSQL + '  I.ITE_PEFFPR, ';
  strSQL := strSQL + '  I.ITE_PEFFPR AS "ITE_PEFFPR_NOV", ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", ';
  strSQL := strSQL + '  G.ITE_TAMLCF, ';
  strSQL := strSQL + '  G.ITE_TAMLCF AS "ITE_TAMLCF_NOV", ';
  strSQL := strSQL + '  G.ITE_LOCSUP, ';
  strSQL := strSQL + '  G.ITE_LOCSUP AS "ITE_LOCSUP_NOV", ';
  strSQL := strSQL + '  G.ITE_TAMLCS, ';
  strSQL := strSQL + '  G.ITE_TAMLCS AS "ITE_TAMLCS_NOV", ';
  strSQL := strSQL + '  G.ITE_CODLSE, ';
  strSQL := strSQL + '  G.ITE_CODLSE AS "ITE_CODLSE_NOV", ';

  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMSG AS "ITE_MARMSG_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';
  strSQL := strSQL + '  G.ITE_MARMGE AS "ITE_MARMGE_NOV", ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMV AS "ITE_MARMMV_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';
  strSQL := strSQL + '  G.ITE_MARMMG AS "ITE_MARMMG_NOV", ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMS AS "ITE_MARMMS_NOV", ';

  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI AS "ITE_EXCIPI_NOV", ';
  strSQL := strSQL + '  I.ITE_CDCEST, ';
  strSQL := strSQL + '  I.ITE_CDCEST AS "ITE_CDCEST_NOV", ';
  strSQL := strSQL + '  I.ITE_CLACRM, ';
  strSQL := strSQL + '  I.ITE_CLACRM AS "ITE_CLACRM_NOV", ';
  strSQL := strSQL + '  I.ITE_UTIAMP, ';
  strSQL := strSQL + '  I.ITE_UTIAMP AS "ITE_UTIAMP_NOV", ';
  strSQL := strSQL + '  I.ITE_CODGPC, ';
  strSQL := strSQL + '  I.ITE_CODGPC AS "ITE_CODGPC_NOV", ';
  strSQL := strSQL + '  G.ITE_ESMIDG, ';
  strSQL := strSQL + '  G.ITE_ESMIDG AS "ITE_ESMIDG_NOV", ';
  strSQL := strSQL + '  G.ITE_TPESTM, ';
  strSQL := strSQL + '  G.ITE_TPESTM AS "ITE_TPESTM_NOV", ';

  strSQL := strSQL + '  I.ITE_ORDSER, ';
  strSQL := strSQL + '  I.ITE_ORDSER AS "ITE_ORDSER_NOV", ';

  strSQL := strSQL + '  G.ITE_CPESOB, ';
  strSQL := strSQL + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV", ';

  strSQL := strSQL + '  I.ITE_DESCND, ';
  strSQL := strSQL + '  I.ITE_DESCND AS "ITE_DESCND_NOV", ';

  if FPermVendaIgualTodasEmp then
  begin
    strSQL := strSQL + '  I.ITE_PERVDA, ';
    strSQL := strSQL + '  I.ITE_PERVDA AS "ITE_PERVDA_NOV", ';
  end
  else
  begin
    strSQL := strSQL + '  G.ITE_PEVNDA AS ITE_PERVDA, ';
    strSQL := strSQL + '  G.ITE_PEVNDA AS "ITE_PERVDA_NOV", ';
  end;

  strSQL := strSQL + '  G.ITE_RECDEV, ';
  strSQL := strSQL + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", ';

  strSQL := strSQL + '  I.ITE_CODFOR, ';
  strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", ';
  strSQL := strSQL + '  I.ITE_INFLAM, ';
  strSQL := strSQL + '  I.ITE_INFLAM AS "ITE_INFLAM_NOV", ';
  strSQL := strSQL + '  I.ITE_NVLGIR, ';
  strSQL := strSQL + '  I.ITE_NVLGIR AS "ITE_NVLGIR_NOV", ';

  strSQL := strSQL + '  I.ITE_NVLCRI, ';
  strSQL := strSQL + '  I.ITE_NVLCRI AS "ITE_NVLCRI_NOV", ';

  strSQL := strSQL + '  G.ITE_NIVCRI, ';
  strSQL := strSQL + '  G.ITE_NIVCRI AS "ITE_NIVCRI_NOV", ';

  strSQL := strSQL + '  I.ITE_CODGPR, ';
  strSQL := strSQL + '  I.ITE_CODGPR AS "ITE_CODGPR_NOV", ';
  strSQL := strSQL + '  I.ITE_PRDGRU, ';
  strSQL := strSQL + '  I.ITE_PRDGRU AS "ITE_PRDGRU_NOV", ';
  strSQL := strSQL + '  I.ITE_MENFIS, ';
  strSQL := strSQL + '  I.ITE_MENFIS AS "ITE_MENFIS_NOV", ';
  strSQL := strSQL + '  I.ITE_PER_CI, ';
  strSQL := strSQL + '  I.ITE_PER_CI AS "ITE_PER_CI_NOV", ';

  strSQL := strSQL + '  I.ITE_PIMPTC, ';
  strSQL := strSQL + '  I.ITE_PIMPTC AS "ITE_PIMPTC_NOV", ';

  strSQL := strSQL + '  I.ITE_NUMFCI, ';
  strSQL := strSQL + '  I.ITE_NUMFCI AS "ITE_NUMFCI_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPSIT, ';
  strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPPOK, ';
  strSQL := strSQL + '  I.ITE_EXPPOK AS "ITE_EXPPOK_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPAPP, ';
  strSQL := strSQL + '  I.ITE_EXPAPP AS "ITE_EXPAPP_NOV", ';
  strSQL := strSQL + '  I.ITE_EXPB2B, ';
  strSQL := strSQL + '  I.ITE_EXPB2B AS "ITE_EXPB2B_NOV", ';

  strSQL := strSQL + '  DE.ITE_DESSIT, ';
  strSQL := strSQL + '  DE.ITE_DESSIT AS "ITE_DESSIT_NOV", ';

  strSQL := strSQL + '  DE.ITE_CRODOC, ';
  strSQL := strSQL + '  DE.ITE_CRODOC AS "ITE_CRODOC_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPALT, ';
  strSQL := strSQL + '  DE.ITE_EXPALT AS "ITE_EXPALT_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPLAR, ';
  strSQL := strSQL + '  DE.ITE_EXPLAR AS "ITE_EXPLAR_NOV", ';

  strSQL := strSQL + '  DE.ITE_EXPPRO, ';
  strSQL := strSQL + '  DE.ITE_EXPPRO AS "ITE_EXPPRO_NOV", ';

  strSQL := strSQL + '  DE.ITE_DESTAQ, ';
  strSQL := strSQL + '  DE.ITE_DESTAQ AS "ITE_DESTAQ_NOV", ';

  strSQL := strSQL + '  DE.ITE_APLITE, ';
  strSQL := strSQL + '  DE.ITE_APLITE AS "ITE_APLITE_NOV", ';

  strSQL := strSQL + '  DE.ITE_DESITE AS EC_ITE_DESITE, ';
  strSQL := strSQL + '  DE.ITE_DESITE AS "EC_ITE_DESITE_NOV", ';

  strSQL := strSQL + '  I.ITE_TIPFRE, ';
  strSQL := strSQL + '  I.ITE_TIPFRE AS "ITE_TIPFRE_NOV", ';
  strSQL := strSQL + '  I.ITE_VLCFRE, ';
  strSQL := strSQL + '  I.ITE_VLCFRE AS "ITE_VLCFRE_NOV", ';
  strSQL := strSQL + '  I.ITE_CODDEP, ';
  strSQL := strSQL + '  I.ITE_CODDEP AS "ITE_CODDEP_NOV", ';
  strSQL := strSQL + '  I.ITE_USABON, ';
  strSQL := strSQL + '  I.ITE_USABON AS "ITE_USABON_NOV", ';
  strSQL := strSQL + '  I.ITE_USAFLE, ';
  strSQL := strSQL + '  I.ITE_USAFLE AS "ITE_USAFLE_NOV", ';

  strSQL := strSQL + '  IF(ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS ITE_CAREST, ';
  strSQL := strSQL + '  IF(ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS "ITE_CAREST_NOV", ';



  If fCfgSis('UTIWMS', VarBoolean) Then
  Begin
    If fCfgSis('WMSLOT', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_LOTEPD, ';
      strSQL := strSQL + '  I.ITE_LOTEPD AS "ITE_LOTEPD_NOV", ';
    End;
  End;

  strSQL := strSQL + '  I.ITE_VALOBR, ';
  strSQL := strSQL + '  I.ITE_VALOBR AS "ITE_VALOBR_NOV", ';
  strSQL := strSQL + '  I.ITE_NOTESP, ';
  strSQL := strSQL + '  I.ITE_NOTESP AS "ITE_NOTESP_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB1, ';
  strSQL := strSQL + '  G.ITE_MINTB1 AS "ITE_MINTB1_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB2, ';
  strSQL := strSQL + '  G.ITE_MINTB2 AS "ITE_MINTB2_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB3, ';
  strSQL := strSQL + '  G.ITE_MINTB3 AS "ITE_MINTB3_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB4, ';
  strSQL := strSQL + '  G.ITE_MINTB4 AS "ITE_MINTB4_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB5, ';
  strSQL := strSQL + '  G.ITE_MINTB5 AS "ITE_MINTB5_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB6, ';
  strSQL := strSQL + '  G.ITE_MINTB6 AS "ITE_MINTB6_NOV", ';
  strSQL := strSQL + '  G.ITE_MINTB7, ';
  strSQL := strSQL + '  G.ITE_MINTB7 AS "ITE_MINTB7_NOV", ';

  {******************}
  {* ESTOQUE MÍNIMO *}
  {***************RV*}
  strSQL := strSQL + '  G.ITE_ESTMIN, ';
  strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", ';
  {******************}
  {* ESTOQUE MÁXIMO *}
  {***************RV*}
  strSQL := strSQL + '  G.ITE_ESTMAX, ';
  strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV", ';
  strSQL := strSQL + '  I.ITE_ATICOM, ';
  strSQL := strSQL + '  I.ITE_ATICOM AS "ITE_ATICOM_NOV", ';
  strSQL := strSQL + '  I.ITE_RPRENT, ';
  strSQL := strSQL + '  I.ITE_RPRENT AS "ITE_RPRENT_NOV", ';


  If fCfgSis('OPCCOM', varString) = 'VT' Then
  Begin
    For intCorre := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intCorre] = 'S' Then
      Begin
        strSQL := strSQL + ' (SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ) AS COM_VENINT' + intToStr(intCorre) + ', ';
        strSQL := strSQL + ' (SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ) AS COM_VENINT' + intToStr(intCorre) + '_NOV, ';

        strSQL := strSQL + ' (SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ) AS COM_VENEXT' + intToStr(intCorre) + ', ';
        strSQL := strSQL + ' (SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intCorre)) + ' ) AS COM_VENEXT' + intToStr(intCorre) + '_NOV, ';

      End;

    End;

  End;

  if fCfgSis('CLAONU', varBoolean) Then
  Begin
    strSQL := strSQL + '  I.ITE_CODONU, ';
    strSQL := strSQL + '  I.ITE_CODONU AS "ITE_CODONU_NOV",  ';
  End;

  strSQL := strSQL + '  I.ITE_PRAVAL, ';
  strSQL := strSQL + '  I.ITE_PRAVAL AS "ITE_PRAVAL_NOV",  ';

  if blnSergipe then
  Begin
    strSQL := strSQL + '  I.ITE_CODDIC, ';
    strSQL := strSQL + '  I.ITE_CODDIC AS "ITE_CODDIC_NOV",  ';
  End;

  If blnURapel Then
  Begin
    strSQL := strSQL + '  I.ITE_PRAPEL, ';
    strSQL := strSQL + '  I.ITE_PRAPEL AS "ITE_PRAPEL_NOV",  ';
  End;
  
  strSQL := strSQL + '  G.ITE_TIPPRO, ';
  strSQL := strSQL + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV",  ';

  strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS ITE_APLICA, ';
  strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS "ITE_APLICA_NOV",  ';

  strSQL := strSQL + '  I.ITE_IMPETI, ';
  strSQL := strSQL + '  I.ITE_IMPETI AS "ITE_IMPETI_NOV",  ';

  strSQL := strSQL + '  I.ITE_DENSID, ';
  strSQL := strSQL + '  I.ITE_DENSID AS "ITE_DENSID_NOV",  ';

  strSQL := strSQL + '  I.ITE_RASTRE, ';
  strSQL := strSQL + '  I.ITE_RASTRE AS "ITE_RASTRE_NOV",  ';

  strSQL := strSQL + '  G.ITE_PESOBR, ';
  strSQL := strSQL + '  G.ITE_PESOBR AS "ITE_PESOBR_NOV",  ';

  strSQL := strSQL + '  I.ITE_LARVID, ';
  strSQL := strSQL + '  I.ITE_LARVID AS "ITE_LARVID_NOV", ';
  strSQL := strSQL + '  I.ITE_ALTVID, ';
  strSQL := strSQL + '  I.ITE_ALTVID AS "ITE_ALTVID_NOV", ';
  strSQL := strSQL + '  I.ITE_LAMAVI, ';
  strSQL := strSQL + '  I.ITE_LAMAVI AS "ITE_LAMAVI_NOV", ';
  strSQL := strSQL + '  I.ITE_ALMAVI, ';
  strSQL := strSQL + '  I.ITE_ALMAVI AS "ITE_ALMAVI_NOV", ';

  strSQL := strSQL + '  I.ITE_ETIQRE, ';
  strSQL := strSQL + '  I.ITE_ETIQRE AS "ITE_ETIQRE_NOV", ';

  strSQL := strSQL + '  I.ITE_DIACRI, ';
  strSQL := strSQL + '  I.ITE_DIACRI AS "ITE_DIACRI_NOV", ';

  strSQL := strSQL + '  G.ITE_USASER ';
  strSQL := strSQL + ', G.ITE_USASER  AS "ITE_USASER_NOV", ';
  strSQL := strSQL + '  G.ITE_APERET, ';
  strSQL := strSQL + '  G.ITE_APERET AS "ITE_APERET_NOV", ';
  strSQL := strSQL + '  G.ITE_APEENT, ';
  strSQL := strSQL + '  G.ITE_APEENT AS "ITE_APEENT_NOV", ';

  If fCfgSis('MARPAD') = 'S' Then
  Begin
    strSQL := strSQL + '  G.ITE_MARPAD, ';
    strSQL := strSQL + '  G.ITE_MARPAD AS "ITE_MARPAD_NOV",  ';
  End;

  If fCfgSis('EMPCAR', varBoolean) Then
  Begin
    strSQL := strSQL + '  I.ITE_EMPCAR, ';
    strSQL := strSQL + '  I.ITE_EMPCAR AS "ITE_EMPCAR_NOV", ';
  End;

  if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
  begin
    strSQL := strSQL + '  I.ITE_EMPSUG, ';
    strSQL := strSQL + '  I.ITE_EMPSUG AS "ITE_EMPSUG_NOV", ';
  end;

  If fCfgSis('OPCROM') = '5' Then
  Begin
    strSQL := strSQL + '  I.ITE_ENTESP, ';
    strSQL := strSQL + '  I.ITE_ENTESP AS "ITE_ENTESP_NOV", ';
  End;

  If fCfgSis('SEPEXC', varBoolean) Then
  Begin
    strSQL := strSQL + '  I.ITE_SEPEXC, ';
    strSQL := strSQL + '  I.ITE_SEPEXC AS "ITE_SEPEXC_NOV", ';
  End;

  strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI,             ';
  strSQL := strSQL + '  "M" AS ITE_MARDES                 ';

  If blnAltPorFator Then
    strSQL := strSQL + ',  CAST("" AS CHAR(01)) AS SEM_REAJUSTE_CUSTO ';

  if blnUtilizaChecklistGarantia then
  begin
    strSQL := strSQL + ',  G.ITE_CODATC, ';
    strSQL := strSQL + 'G.ITE_CODATC AS "ITE_CODATC_NOV" ';
  end;

  strSQL := strSQL + ', G.ITE_SOBENC, ';
  strSQL := strSQL + 'G.ITE_SOBENC AS "ITE_SOBENC_NOV" ';

  If fCfgSis('UTPEST', varBoolean) Then
  Begin
    strSQL := strSQL + ', I.ITE_QTDPES, ';
    strSQL := strSQL + '  I.ITE_QTDPES AS "ITE_QTDPES_NOV", ';
    strSQL := strSQL + '  I.ITE_PORPES, ';
    strSQL := strSQL + '  I.ITE_PORPES AS "ITE_PORPES_NOV"  ';
  End;

  If fCfgSis('UTIABA', varBoolean) Then
  Begin
    strSQL := strSQL + ', IF(G.ITE_MLTRCA = "C", "COMPRA", "VENDA") AS ITE_MLTRCA, ';
    strSQL := strSQL + 'IF(G.ITE_MLTRCA = "C", "COMPRA", "VENDA") AS "ITE_MLTRCA_NOV" ';
  End;

  If fCfgSis('ETIDCE', varBoolean) Then
  Begin
    strSQL := strSQL + ',  I.ITE_NECEXP, ';
    strSQL := strSQL + '   I.ITE_NECEXP AS "ITE_NECEXP_NOV" ';
  End;

  If fCfgSis('LOCRET', varBoolean) Then
  Begin
    strSQL := strSQL + ',  G.ITE_TIPRET, ';
    strSQL := strSQL + '   G.ITE_TIPRET AS "ITE_TIPRET_NOV" ';
  End;

  If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
  Begin
    strSQL := strSQL + ',  I.ITE_NFEIDP, ';
    strSQL := strSQL + '   I.ITE_NFEIDP AS "ITE_NFEIDP_NOV" ';

    strSQL := strSQL + ',  I.ITE_NFCIDP, ';
    strSQL := strSQL + '   I.ITE_NFCIDP AS "ITE_NFCIDP_NOV" ';
  End;

  If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
  Begin
    strSQL := strSQL + ',  I.ITE_LOTRAP, ';
    strSQL := strSQL + '   I.ITE_LOTRAP AS "ITE_LOTRAP_NOV" ';
  End;

  If fCfgSis('CDPHAB', varBoolean) Then
  Begin
    strSQL := strSQL + ' ,I.ITE_CLBPIN, ';
    strSQL := strSQL + '  I.ITE_CLBPIN AS "ITE_CLBPIN_NOV" ';
  End;

  If blnUsaBef Then
  Begin
    strSQL := strSQL + ' ,I.ITE_USABEF, ';
    strSQL := strSQL + '  I.ITE_USABEF AS "ITE_USABEF_NOV"  ';
  End;

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + '  JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ' +
                     '               AND G.ITE_CODEMP IS NULL ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '  LEFT JOIN DESSIT DE ON I.ITE_CODITE = DE.ITE_CODITE ';
  If blnTABPRD and (not blnAltFornecedor) then
  Begin
    For intContador := 1 To Length(VS_strTabPrc) Do
    Begin
      strSQL := strSQL + ' LEFT JOIN TABDET D' + IntToStr(intContador) + ' ON D' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
      strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';
      strSQL := strSQL + ' LEFT JOIN DETCUS DC' + IntToStr(intContador) + ' ON DC' + IntToStr(intContador) + '.DET_SEQDET = D' + IntToStr(intContador) + '.AUTOINCREM ';
      strSQL := strSQL + '                                                AND DC' + IntToStr(intContador) + '.DET_TABELA = "' + IntToStr(intContador) + '" ';
      strSQL := strSQL + ' LEFT JOIN ITEFOR F' + IntToStr(intContador) + ' ON F' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
      strSQL := strSQL + '                                                 AND F' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';

    End;
  end
  Else
  If blnAltFornecedor Then
  Begin
    strSQL := strSQL + ' INNER JOIN ITEFOR F ON I.ITE_CODITE = F.ITE_CODITE ';

    strSQL := strSQL + ' INNER JOIN TABPRE T ON T.TAB_CODTAB = F.ITE_CODTAB ';

    strSQL := strSQL + ' INNER JOIN TABDET A ON A.ITE_CODTAB = F.ITE_CODTAB ';
    strSQL := strSQL + '                    AND A.ITE_CODITE = F.ITE_CODITE ';
    strSQL := strSQL + '                    AND A.ITE_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '                    AND A.ITE_PRECOM > 0            ';

  End;

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE IS NULL ';

  if (fCfgSis('USASAN', VarString) = 'S') and (cmbCSTORI.Text<>'') then
    strSQL := strSQL + '  AND I.ITE_CSTORI = '+QuotedStr(cmbCSTORI.Text);

  qryGen := fCriarQuery(strSQL, Self);
  qryGen.Open;
  pSetaClient(qryGen);
  dspIteGlo.DataSet := qryGen;

  cdsIteGlo.Close;
  cdsIteGlo.Open;
  pSetaClient(cdsIteGlo);

  TFloatField(cdsIteGlo.FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';


  FreeAndNil(qryGen);
end;

function TfrmAltPrecoGlobal.fRetornaNumeric(strMascara: String): String;
  Var
    intPrecisao: Integer;
begin
  strMascara := AnsiReplaceStr(strMascara, '#', '');
  strMascara := AnsiReplaceStr(strMascara, ',', '');

  intPrecisao := Length(Copy(strMascara, Pos('.', strMascara)+1, Length(strMascara)));

  Result := 'NUMERIC(12, ' + IntToStr(intPrecisao) + ')';
end;

function TfrmAltPrecoGlobal.fCampoPorNome(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String): TCampoGlobal;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  Fillchar(Result, SizeOf(Result), #0);
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      Result := arrCampos[intContador];
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltPrecoGlobal.fCampoTipoNumero(arrCampos: array of TCampoGlobal;
  strNomeCampo: String): Boolean;
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  Result := False;
  intContador := 0;
  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      If arrCampos[intContador].strTipCam = 'NUMERIC' Then
        Result := True;
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltPrecoGlobal.fCarregarClientDataSetAux(
  pgbProgresso: TCxProgressBar): Boolean;
var
  qryAux: TUniQuery;
  cdsAux: TUniClientDataSet;
begin
  Try
    Result := True;
    qryAux := fCriarQuery('SELECT ALT_DTASET FROM ALTGLO WHERE ALT_CODOPE = :CODOPE AND ALT_CODEMP = :CODEMP');
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    cdsAux := TUniClientDataSet.Create(Nil);

    TBlobField(qryAux.FieldByName('ALT_DTASET')).SaveToFile(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml');
    cdsAux.LoadFromFile(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml');
    TFile.Delete(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml');

    cdsAux.Filter := 'ITE_VALCAM <> NULL';
    cdsAux.Filtered := True;
    While not cdsAux.Eof Do
    Begin
      If cdsAltGlo.Locate('ITE_NOMCAM', cdsAux.FieldByName('ITE_NOMCAM').AsString, []) Then
      Begin
        cdsAltGlo.Edit;
        cdsAltGlo.FieldByName('ITE_VALCAM').AsString := cdsAux.FieldByName('ITE_VALCAM').AsString;
        cdsAltGlo.Post;
      End;
      cdsAux.Next;
    End;
  Finally
    blnCarregandoCadInt := True;
    If Assigned(objGerenciaExpr) Then
      objGerenciaExpr.pSetCarregandoCadInt(blnCarregandoCadInt);
    FreeAndNil(qryAux);
    FreeAndNil(cdsAux);
  End;

end;

function TfrmAltPrecoGlobal.fRetCamposIteFor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' F.ITE_CODFOR AS FOR_ITE_CODFOR, ';
  strSQL := strSQL + ' F.ITE_UNICOM AS FOR_ITE_UNICOM, ';
  strSQL := strSQL + ' F.ITE_MLTCOM AS FOR_ITE_MLTCOM, ';
  strSQL := strSQL + ' F.ITE_DIAFOR AS FOR_ITE_DIAFOR, ';
  strSQL := strSQL + ' F.ITE_CLAIPI AS FOR_ITE_CLAIPI, ';
  strSQL := strSQL + ' F.ITE_DESFAB AS FOR_ITE_DESFAB, ';
  strSQL := strSQL + ' F.ITE_CODFAB AS FOR_ITE_CODFAB, ';
  strSQL := strSQL + ' F.ITE_CNVCUS AS FOR_ITE_CNVCUS, ';
  strSQL := strSQL + ' F.ITE_CODCNA AS FOR_ITE_CODCNA, ';
  strSQL := strSQL + ' F.ITE_ANTEST AS FOR_ITE_ANTEST, ';
  strSQL := strSQL + ' F.TFO_EMBALA AS FOR_ITE_EMBALA, ';
  strSQL := strSQL + ' F.TFO_BAREMB AS FOR_ITE_BAREMB, ';
  strSQL := strSQL + ' F.TFO_REFERE AS FOR_ITE_REFERE, ';
  strSQL := strSQL + ' F.TFO_CODBAR AS FOR_ITE_CODBAR, ';
  strSQL := strSQL + ' F.TFO_PESOIT AS FOR_ITE_PESOIT, ';
  strSQL := strSQL + ' F.TFO_SITPRO AS FOR_ITE_SITPRO, ';
  strSQL := strSQL + ' F.TFO_NOTESP AS FOR_ITE_NOTESP, ';

  If fCfgSis('TIPABF') = '2' Then
    strSQL := strSQL + ' A.ITE_CODABF AS FOR_ITE_CODABF, '
  Else
    strSQL := strSQL + ' F.ITE_CODABF AS FOR_ITE_CODABF, ';

  If fCfgSis('TPABPC') = '2' Then
  Begin
    strSQL := strSQL + ' A.ITE_ABFIPI AS FOR_ITE_ABFIPI, ';
    strSQL := strSQL + ' A.ITE_ABFCOF AS FOR_ITE_ABFCOF, ';
    strSQL := strSQL + ' A.ITE_ABFPIS AS FOR_ITE_ABFPIS, ';
  End Else
  Begin
    strSQL := strSQL + ' F.ITE_ABFIPI AS FOR_ITE_ABFIPI, ';
    strSQL := strSQL + ' F.ITE_ABFCOF AS FOR_ITE_ABFCOF, ';
    strSQL := strSQL + ' F.ITE_ABFPIS AS FOR_ITE_ABFPIS, ';
  End;

  strSQL := strSQL + ' A.ITE_DESF01 AS FOR_ITE_DESF01, ';
  strSQL := strSQL + ' A.ITE_DESF02 AS FOR_ITE_DESF02, ';
  strSQL := strSQL + ' A.ITE_DESF03 AS FOR_ITE_DESF03, ';
  strSQL := strSQL + ' A.ITE_DESF04 AS FOR_ITE_DESF04, ';
  strSQL := strSQL + ' A.ITE_DESF05 AS FOR_ITE_DESF05, ';
  strSQL := strSQL + ' A.ITE_DESF06 AS FOR_ITE_DESF06, ';
  strSQL := strSQL + ' A.ITE_PRECOM AS FOR_ITE_PRECOM, ';
  strSQL := strSQL + ' A.ITE_ICMENT AS FOR_ITE_ICMENT, ';
  strSQL := strSQL + ' A.ITE_SUBFED AS FOR_ITE_SUBFED, ';
  strSQL := strSQL + ' A.ITE_IPIENT AS FOR_ITE_IPIENT, ';
  strSQL := strSQL + ' A.ITE_FREENT AS FOR_ITE_FREENT, ';
  strSQL := strSQL + ' A.ITE_VALFRE AS FOR_ITE_VALFRE, ';
  strSQL := strSQL + ' A.ITE_ACRFIN AS FOR_ITE_ACRFIN, ';
  strSQL := strSQL + ' A.ITE_SUBSTI AS FOR_ITE_SUBSTI, ';
  strSQL := strSQL + ' A.ITE_DESADB AS FOR_ITE_DESADB, ';
  strSQL := strSQL + ' A.ITE_PRECUS AS FOR_ITE_PRECUS, ';
  strSQL := strSQL + ' A.ITE_OUTVAL AS FOR_ITE_OUTVAL, ';
  strSQL := strSQL + ' A.ITE_ICMSAI AS FOR_ITE_ICMSAI, ';
  strSQL := strSQL + ' A.ITE_IMPFED AS FOR_ITE_IMPFED, ';
  strSQL := strSQL + ' A.ITE_DESOPE AS FOR_ITE_DESOPE, ';
  strSQL := strSQL + ' A.ITE_DESGER AS FOR_ITE_DESGER, ';
  strSQL := strSQL + ' A.ITE_PROGER AS FOR_ITE_PROGER, ';

  strSQL := strSQL + ' A.ITE_MARBRU AS FOR_ITE_MARBRU, ';
  strSQL := strSQL + ' A.ITE_PREVEN AS FOR_ITE_PREVEN, ';
  strSQL := strSQL + ' A.ITE_PREREV AS FOR_ITE_PREREV, ';
  strSQL := strSQL + ' A.ITE_MARFEC AS FOR_ITE_MARFEC, ';
  strSQL := strSQL + ' A.ITE_TCIFCU AS FOR_ITE_TCIFCU, ';
  strSQL := strSQL + ' A.ITE_TSCUST AS FOR_ITE_TSCUST, ';
  strSQL := strSQL + ' A.ITE_DEPICO AS FOR_ITE_DEPICO, ';
  strSQL := strSQL + ' A.ITE_DEICMS AS FOR_ITE_DEICMS, ';
  strSQL := strSQL + ' A.ITE_FATREG AS FOR_ITE_FATREG, ';
  strSQL := strSQL + ' A.ITE_EXCIPI AS FOR_ITE_EXCIPI, ';
  strSQL := strSQL + ' A.ITE_PREDOL AS FOR_ITE_PREDOL, ';

  Result := strSQL;
End;

function TfrmAltPrecoGlobal.fCalculaFatorNota: Double;
  Var
    fltPercentual: Double;
Begin
  fltPercentual := fStrToFloat(edtPerAcr.Text);

  Result := 1 + (fltPercentual / 100);
End;

function TfrmAltPrecoGlobal.fGeraTabelaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      frmGravando.blnTempoRestante := True;
      fExecutarAcao := fGeraTabelaItensAux;
      lblGravando.Caption := 'Aguarde, selecionando itens...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGeraTabelaItens]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

{******************************************}
{* GERA A TABELA TEMPORARIA COM OS CAMPOS *}
{* ALTERADOS E SEUS NOVOS VALORES         *}
{***************************************MV*}
function TfrmAltPrecoGlobal.fGeraTabelaItensAux(pgbProgresso2: TcxProgressBar): Boolean;
  Var
    strAbfPis,
    strAbfCof,
    strSQL   : String;
    strTabPrc: String;
    intTamMat: Integer;

    intContador     : Integer;
    strCamAtu       : String;
    strCampoExp     : String;

    varValAtu       : Variant;
    varValorRegAtual: Variant;

    fltNovPreVen: Double;
    fltVarPre: Double;
    fltVarCus: Double;
    fltPctPrc: Double;
    fltPreCusNov: Double;

    fltCnvCusFor: Double;

    blnAltPrecus: Boolean;

    arrRegistroAtual: Array Of TCampoGlobal;

    intTblPrc : Integer;

    cpcParams : TParCalculaPrecoCusto;

    intCorre : Integer;
    blnUtilizarConversorDeMoedas : Boolean;

    strEmpresas  : String;
    
    procedure pAdicionaCampoGrid(strNomeCampo: String);
      Var
        intTamMatCampos: Integer;
        intContadorLocal: integer;
        recGlobal: TCampoGlobal;
    begin
      recGlobal := fCampoPorNome(arrCamposGlobal, strNomeCampo);

      If Not recGlobal.strNomCam.IsEmpty Then
      Begin
        intTamMatCampos := Length(arrCamposGrid);

        For intContadorLocal := 0 To intTamMatCampos -1 Do
          If arrCamposGrid[intContadorLocal].strNomCam = strNomeCampo Then
            Exit;

        SetLength(arrCamposGrid, intTamMatCampos+1);
        arrCamposGrid[intTamMatCampos] := recGlobal;
      End;
    end;

    function fPrecoVenda(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
      Var
        fltPreComLiq : Double;
        strCodSit : String;
        fltIcmsST : Double;
        blnCalcSt : Boolean;
        strTabPrc: String;
    begin
      strTabPrc :=  intToStr(intTabPrc);
      If blnTABPRD and (not blnAltFornecedor) then
      Begin
        fltPreComLiq := fCalculaPrecoCompraLiq(fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM' + strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF01' + strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF02' + strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF03' + strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF04'+ strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF05'+ strTabPrc).varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF06'+ strTabPrc).varValCam,
                                               intDecUni,
                                               (fCampoPorNome(arrRegistroAtual, 'ITE_PREDOL'+ strTabPrc).varValCam = 'S'));

        strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fCampoPorNome(arrRegistroAtual, 'ITE_CODABF'+ strTabPrc).varValCam, strEstEmp]);
        fltIcmsST := fGetIcmsSTParteVenda(fCampoPorNome(arrRegistroAtual, 'ITE_CODABF'+ strTabPrc).varValCam,
                                          '_SAI_CCO', strCodSit, strEstEmp,
                                          fltPreComLiq, fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT'+ strTabPrc).varValCam,
                                          fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+ strTabPrc).varValCam,
                                          strEstEmp, blnCalcSt);

        Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS'+ strTabPrc).varValCam/fCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+ strTabPrc).varValCam +
                                             fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL'+ strTabPrc).varValCam/fCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+ strTabPrc).varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').varValCam * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                             fCampoPorNome(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI'+ strTabPrc).varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED'+ strTabPrc).varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE'+ strTabPrc).varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_COMTB' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                             strMarMkp,
                                             strPcmPro,
                                             intDecUni,
                                             fltIcmsST,
                                             blnCalcSt);
        {If intOpc = 1 then
          Result :=  Result / fCampoPorNome(arrRegistroAtual, 'ITE_CNVCUS'+ strTabPrc).varValCam;}

      end
      Else
      begin
        fltPreComLiq := fCalculaPrecoCompraLiq(fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF01_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF02_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF03_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF04_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF05_NOV').varValCam,
                                               fCampoPorNome(arrRegistroAtual, 'ITE_DESF06_NOV').varValCam,
                                               intDecUni,
                                               (fCampoPorNome(arrRegistroAtual, 'ITE_PREDOL_NOV').varValCam = 'S'));

        strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fCampoPorNome(arrRegistroAtual, 'ITE_CODABF_NOV').varValCam, strEstEmp]);
        fltIcmsST := fGetIcmsSTParteVenda(fCampoPorNome(arrRegistroAtual, 'ITE_CODABF_NOV').varValCam,
                                          '_SAI_CCO', strCodSit, strEstEmp,
                                          fltPreComLiq, fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT_NOV').varValCam,
                                          fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam,
                                          strEstEmp, blnCalcSt);

        Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS_NOV').varValCam +
                                             fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intTabPrc) + '_NOV').varValCam * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                             fCampoPorNome(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE_NOV').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_COMTB' + IntToStr(intTabPrc) + '_NOV').varValCam,
                                             strMarMkp,
                                             strPcmPro,
                                             intDecUni,
                                             fltIcmsST,
                                             blnCalcSt);
      end;
    end;

    function fPrecoVendaOld(intOpc, intTabPrc: Integer; blnAplicaPerPreVen : Boolean = False): Double;
      Var
        fltPreComLiq : Double;
        strCodSit : String;
        fltIcmsST : Double;
        blnCalcSt : Boolean;
    begin
      fltPreComLiq := fCalculaPrecoCompraLiq(fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF01').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF02').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF03').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF04').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF05').varValCam,
                                             fCampoPorNome(arrRegistroAtual, 'ITE_DESF06').varValCam,
                                             intDecUni,
                                             (fCampoPorNome(arrRegistroAtual, 'ITE_PREDOL').varValCam = 'S'));

      strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [fCampoPorNome(arrRegistroAtual, 'ITE_CODABF').varValCam, strEstEmp]);
      fltIcmsST := fGetIcmsSTParteVenda(fCampoPorNome(arrRegistroAtual, 'ITE_CODABF').varValCam,
                                        '_SAI_CCO', strCodSit, strEstEmp,
                                        fltPreComLiq, fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT').varValCam,
                                        fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI').varValCam,
                                        strEstEmp, blnCalcSt);

      Result := fCalculaPrecoVenda(intOpc, fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS').varValCam +
                                           fCampoPorNome(arrRegistroAtual, 'ITE_OUTVAL').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intTabPrc)).varValCam * IIF(blnAplicaPerPreVen, fltPMarLq, 1),
                                           fCampoPorNome(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTabPrc)).varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_ICMSAI').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_IMPFED').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_DESOPE').varValCam,
                                           fCampoPorNome(arrRegistroAtual, 'ITE_COMTB' + IntToStr(intTabPrc)).varValCam,
                                           strMarMkp,
                                           strPcmPro,
                                           intDecUni,
                                           fltIcmsST,
                                           blnCalcSt);
    end;

    Procedure pAtualizaPrecosFator(fltNovPreVen: Double; intTabela: Integer = 1);
      Var
        intIndice: Integer;
    Begin
      If Not Assigned(objFatPre) Then
        Exit;
      If intTabela <> 1 Then
        Exit;
      For intIndice := 2 To 7 Do
      Begin
        If objFatPre.fTabelaAtiva(intIndice) Then
        Begin
          arrRecTabelasPreco[intIndice].fltPreVenNov := objFatPre.fCalculaPrecoVendaFator(fltNovPreVen, intIndice);

          pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intIndice) + '_NOV', arrRecTabelasPreco[intIndice].fltPreVenNov);

          arrRecTabelasPreco[intIndice].fltMarBruNov := fPrecoVenda(2, intIndice);

          pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intIndice) + '_NOV', arrRecTabelasPreco[intIndice].fltMarBruNov);

          pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intIndice));
          pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intIndice));
        End;
      End;

    End;

    procedure pAtualizaMargemLiquida(intTabPre : Integer);
    Begin
      if VS_strTabPrc[intTabPre] <> 'S' Then
        Exit;

      If Not blnLiqNeg Then
        Exit;

      pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARLQ' + IntToStr(intTblPrc) + '_NOV', fPrecoVenda(2, intTabPre, True) );
      pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARLQ' + IntToStr(intTblPrc), fPrecoVendaOld(2, intTabPre, True) );

      pAdicionaCampoGrid('ITE_MARLQ' + IntToStr(intTblPrc));
    End;

begin
  Try
    pgbProgresso2.Position       := 0;
    pgbProgresso2.Properties.Max := 0;
    Application.ProcessMessages;

    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);
    strEmpresas := fRetEmpresasUsamPrecoMatriz(Nil {stlEmpFilial}, ''{strCodEmp}, ''{strEmpPar}, True{blnSomenteAtivas});

    Result := True;

    fltPctPrc := fCfgSis('PCTPRC', varDouble);
    fltVarPre:= 0;
    fltVarCus:= 0;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    If blnAltFornecedor Then
      strSQL := strSQL + fRetCamposIteFor;

    If blnTABPRD and (not blnAltFornecedor) then
    Begin

      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PREDOL, "")  AS ITE_PREDOL' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_CODABF, "")  AS ITE_CODABF' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECOM, G.ITE_PRECOM)  AS ITE_PRECOM' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF01, G.ITE_DESF01)  AS ITE_DESF01' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF02, G.ITE_DESF02)  AS ITE_DESF02' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF03, G.ITE_DESF03)  AS ITE_DESF03' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF04, G.ITE_DESF04)  AS ITE_DESF04' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF05, G.ITE_DESF05)  AS ITE_DESF05' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESF06, G.ITE_DESF06)  AS ITE_DESF06' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ICMENT, G.ITE_ICMENT)  AS ITE_ICMENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_SUBFED, G.ITE_SUBFED)  AS ITE_SUBFED' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IPIENT, G.ITE_IPIENT)  AS ITE_IPIENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FREENT, G.ITE_FREENT)  AS ITE_FREENT' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_VALFRE, G.ITE_VALFRE)  AS ITE_VALFRE' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_ACRFIN, G.ITE_ACRFIN)  AS ITE_ACRFIN' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DESADB, G.ITE_DESADB)  AS ITE_DESADB' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_PRECUS, G.ITE_PRECUS)  AS ITE_PRECUS' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_OUTVAL, G.ITE_OUTVAL)  AS ITE_OUTVAL' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_ICMSAI, G.ITE_ICMSAI)  AS ITE_ICMSAI' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_IMPFED, G.ITE_IMPFED)  AS ITE_IMPFED' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(DC' + IntToStr(intContador) + '.DET_DESOPE, G.ITE_DESOPE)  AS ITE_DESOPE' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TCIFCU, G.ITE_TCIFCU)  AS ITE_TCIFCU' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_TSCUST, G.ITE_TSCUST)  AS ITE_TSCUST' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEPICO, G.ITE_DEPICO)  AS ITE_DEPICO' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_DEICMS, G.ITE_DEICMS)  AS ITE_DEICMS' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IFNULL(D' + IntToStr(intContador) + '.ITE_FATREG, G.ITE_FATREG)  AS ITE_FATREG' + IntToStr(intContador) + ',';
        strSQL := strSQL + '  IF(IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1) <=0 , 1, IFNULL(F' + IntToStr(intContador) + '.ITE_CNVCUS, 1))AS ITE_CNVCUS'+ IntToStr(intContador)+' ,';
        strSQL := strSQL + '  DC' + IntToStr(intContador) + '.DET_SEQDET AS  DETCUS_AUTOINCREM_' + IntToStr(intContador) + ',';

      End;
    End;


    strSQL := strSQL + '  0 AS "ITE_CUSVAR", ';
    strSQL := strSQL + '  0 AS MARNEG, ';

    strSQL := strSQL + '  I.ITE_CODITE, ';
    strSQL := strSQL + '  I.ITE_DESITE AS ITE_DESITE, ';

    strSQL := strSQL + ' IF((SELECT COUNT(1) FROM ITEEMB ';
    strSQL := strSQL + '      WHERE ITB_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '      AND ITB_CODEMP = G.ITE_CODEMP) > 0,"Sim","Não") ';
    strSQL := strSQL + ' AS ITE_POSEMB, ';

    strSQL := strSQL + '  I.ITE_CODLUB, ';
    strSQL := strSQL + '  I.ITE_CODLUB AS "ITE_CODLUB_NOV", ';
    strSQL := strSQL + '  I.ITE_DESANP, ';
    strSQL := strSQL + '  I.ITE_DESANP AS "ITE_DESANP_NOV", ';

    strSQL := strSQL + '  0.00 AS ITE_SALDOS, ';

    strSQL := strSQL + '  G.ITE_SAL_ML, ';
    strSQL := strSQL + '  I.ITE_CNV_ML, ';

    If fCfgSis('ENTFUT', varBoolean) And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']) Then
      strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)) + ' + fGetSQLSomaCamposEntregaFutura() + ', 3) AS "SaldoNumerico", '
    Else
      strSQL := strSQL + '  ROUND((G.ITE_SALDOS * IF(IFNULL(ITE_CNV_ML,0) <= 0, 1, ITE_CNV_ML)), 3) AS "SaldoNumerico", ';

    strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL, ';
    strSQL := strSQL + '  IFNULL(G.ITE_PREDOL, "N") AS ITE_PREDOL_NOV, ';
    strSQL := strSQL + '  I.ITE_CODGRU, ';
    strSQL := strSQL + '  I.ITE_CODGRU AS "ITE_CODGRU_NOV", ';
    strSQL := strSQL + '  I.ITE_REFERE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS "ITE_REFERE_NOV", ';
    strSQL := strSQL + '  I.ITE_ACOOBJ, ';
    strSQL := strSQL + '  I.ITE_ACOOBJ AS "ITE_ACOOBJ_NOV", ';
    strSQL := strSQL + '  I.ITE_CODCOM, ';
    strSQL := strSQL + '  I.ITE_CODCOM AS "ITE_CODCOM_NOV", ';
    strSQL := strSQL + '  I.ITE_USAPFD, ';
    strSQL := strSQL + '  I.ITE_USAPFD AS "ITE_USAPFD_NOV", ';
    strSQL := strSQL + '  I.ITE_USAPCV, ';
    strSQL := strSQL + '  I.ITE_USAPCV AS "ITE_USAPCV_NOV", ';

    If fCfgSis('TRITTE', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_TRITTE, ';
      strSQL := strSQL + '  I.ITE_TRITTE AS "ITE_TRITTE_NOV", ';
    End;

    if fCfgSis('NFEPEP', varBoolean) then
    begin
      strSQL := strSQL + '  G.ITE_OBRNFE, ';
      strSQL := strSQL + '  G.ITE_OBRNFE AS "ITE_OBRNFE_NOV", ';
    end
    else
    begin
      strSQL := strSQL + '  I.ITE_OBRNFE, ';
      strSQL := strSQL + '  I.ITE_OBRNFE AS "ITE_OBRNFE_NOV", ';
    end;

    strSQL := strSQL + '  I.ITE_FATCMP, ';
    strSQL := strSQL + '  I.ITE_FATCMP AS ITE_FATCMP_NOV , ';

    strSQL := strSQL + '  I.ITE_FATPM3, ';
    strSQL := strSQL + '  I.ITE_FATPM3 AS ITE_FATPM3_NOV , ';


    If fCfgSIs('IMPDIG') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_IMPDIR, ';
      strSQL := strSQL + '  I.ITE_IMPDIR AS "ITE_IMPDIR_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_IMPDIR, ';
      strSQL := strSQL + '  G.ITE_IMPDIR AS "ITE_IMPDIR_NOV", ';
    End;

    If fCfgSIs('TIPABF') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_USAPPF, ';
      strSQL := strSQL + '  I.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_USAPPF, ';
      strSQL := strSQL + '  G.ITE_USAPPF AS "ITE_USAPPF_NOV", ';
    End;

    If fCfgSIs('INDREV') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_INDREV, ';
      strSQL := strSQL + '  I.ITE_INDREV AS "ITE_INDREV_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_INDREV, ';
      strSQL := strSQL + '  G.ITE_INDREV AS "ITE_INDREV_NOV", ';
    End;


    If fCfgSIs('TIPABF') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_CODABF, ';
      strSQL := strSQL + '  I.ITE_CODABF AS "ITE_CODABF_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_CODABF, ';
      strSQL := strSQL + '  G.ITE_CODABF AS "ITE_CODABF_NOV", ';
    End;

    If fCfgSis('TPABPC') = '1' Then
    Begin
      strSQL := strSQL + '  I.ITE_ABFPIS, ';
      strSQL := strSQL + '  I.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
      strSQL := strSQL + '  I.ITE_ABFCOF, ';
      strSQL := strSQL + '  I.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
      strSQL := strSQL + '  I.ITE_ABFIPI, ';
      strSQL := strSQL + '  I.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_ABFPIS, ';
      strSQL := strSQL + '  G.ITE_ABFPIS AS "ITE_ABFPIS_NOV", ';
      strSQL := strSQL + '  G.ITE_ABFCOF, ';
      strSQL := strSQL + '  G.ITE_ABFCOF AS "ITE_ABFCOF_NOV", ';
      strSQL := strSQL + '  G.ITE_ABFIPI, ';
      strSQL := strSQL + '  G.ITE_ABFIPI AS "ITE_ABFIPI_NOV", ';
    End;

    strSQL := strSQL + '  G.ITE_PRAMIN, ';
    strSQL := strSQL + '  G.ITE_PRAMIN AS "ITE_PRAMIN_NOV", ';

    strSQL := strSQL + '  I.ITE_REAEND, ';
    strSQL := strSQL + '  I.ITE_REAEND AS "ITE_REAEND_NOV", ';

    strSQL := strSQL + '  I.ITE_OBRBAR, ';
    strSQL := strSQL + '  I.ITE_OBRBAR AS "ITE_OBRBAR_NOV", ';

    strSQL := strSQL + '  I.ITE_FATCOM, ';
    strSQL := strSQL + '  I.ITE_FATCOM AS "ITE_FATCOM_NOV", ';

    strSQL := strSQL + '  I.ITE_DIAFOR, ';
    strSQL := strSQL + '  I.ITE_DIAFOR AS "ITE_DIAFOR_NOV", ';

    strSQL := strSQL + '  I.ITE_MLTSPO, ';
    strSQL := strSQL + '  I.ITE_MLTSPO AS "ITE_MLTSPO_NOV", ';

    strSQL := strSQL + '  I.ITE_GRUCMP, ';
    strSQL := strSQL + '  I.ITE_GRUCMP AS "ITE_GRUCMP_NOV", ';

    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODFAB AS "ITE_CODFAB_NOV", ';

    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_DESFAB AS "ITE_DESFAB_NOV", ';

    strSQL := strSQL + '  I.ITE_INCPIS, ';
    strSQL := strSQL + '  I.ITE_INCPIS AS "ITE_INCPIS_NOV", ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_COMLUB AS "ITE_COMLUB_NOV", ';
    strSQL := strSQL + '  G.ITE_IMPLIS, ';
    strSQL := strSQL + '  G.ITE_IMPLIS AS "ITE_IMPLIS_NOV", ';
    strSQL := strSQL + '  I.ITE_ITEATI, ';
    strSQL := strSQL + '  I.ITE_ITEATI AS "ITE_ITEATI_NOV", ';
    strSQL := strSQL + '  I.ITE_GRAMAR, ';
    strSQL := strSQL + '  I.ITE_GRAMAR AS "ITE_GRAMAR_NOV", ';
    strSQL := strSQL + '  I.ITE_CODUNI, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS "ITE_CODUNI_NOV", ';
    strSQL := strSQL + '  I.ITE_UNICOM, ';
    strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", ';
    strSQL := strSQL + '  I.ITE_CSTORI, ';
    strSQL := strSQL + '  I.ITE_CSTORI AS "ITE_CSTORI_NOV", ';

    If fCfgSis('UNITRI') = 'S' Then
    Begin
      strSQL := strSQL + '  I.ITE_UNITRI, ';
      strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", ';

      strSQL := strSQL + '  I.ITE_FATUTR, ';
      strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", ';
    End;

    strSQL := strSQL + '  I.ITE_CODMAR, ';
    strSQL := strSQL + '  I.ITE_CODMAR AS "ITE_CODMAR_NOV", ';

    strSQL := strSQL + '  G.ITE_SITPRO, ';
    strSQL := strSQL + '  G.ITE_SITPRO AS "ITE_SITPRO_NOV", ';

    strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS ITE_CODMON, ';
    strSQL := strSQL + '  (SELECT GROUP_CONCAT(ITM_CODMON) FROM ITEMON WHERE ITM_CODITE = I.ITE_CODITE) AS "ITE_CODMON_NOV", '; //Montadora

    If blnValFor Then
    Begin
      strSQL := strSQL + '  G.ITE_DTAVAL, ';
      strSQL := strSQL + '  G.ITE_DTAVAL AS "ITE_DTAVAL_NOV", ';
    End;

    strSQL := strSQL + '  I.ITE_ITEBAS, ';
    strSQL := strSQL + '  I.ITE_ITEBAS AS "ITE_ITEBAS_NOV", ';
    strSQL := strSQL + '  I.ITE_PROEMB, ';
    strSQL := strSQL + '  I.ITE_PROEMB AS "ITE_PROEMB_NOV", ';
    strSQL := strSQL + '  I.ITE_EMBALA, ';
    strSQL := strSQL + '  I.ITE_EMBALA AS "ITE_EMBALA_NOV", ';
    strSQL := strSQL + '  I.ITE_MESGIR, ';
    strSQL := strSQL + '  I.ITE_MESGIR AS "ITE_MESGIR_NOV", ';
    strSQL := strSQL + '  I.ITE_TMPGAR, ';
    strSQL := strSQL + '  I.ITE_TMPGAR AS "ITE_TMPGAR_NOV", ';
    strSQL := strSQL + '  I.ITE_INFGAR, ';
    strSQL := strSQL + '  I.ITE_INFGAR AS "ITE_INFGAR_NOV", ';
    strSQL := strSQL + '  I.ITE_RSPGAR, ';
    strSQL := strSQL + '  I.ITE_RSPGAR AS "ITE_RSPGAR_NOV", ';
    strSQL := strSQL + '  I.ITE_MLTCOM, ';
    strSQL := strSQL + '  I.ITE_MLTCOM AS "ITE_MLTCOM_NOV", ';
    strSQL := strSQL + '  I.ITE_MLTVEN, ';
    strSQL := strSQL + '  I.ITE_MLTVEN AS "ITE_MLTVEN_NOV", ';

    strSQL := strSQL + '  I.ITE_DIFICM, ';
    strSQL := strSQL + '  I.ITE_DIFICM AS "ITE_DIFICM_NOV", ';

    strSQL := strSQL + '  I.ITE_MSGLV1, ';
    strSQL := strSQL + '  I.ITE_MSGLV1 AS "ITE_MSGLV1_NOV", ';
    strSQL := strSQL + '  I.ITE_MSGLV2, ';
    strSQL := strSQL + '  I.ITE_MSGLV2 AS "ITE_MSGLV2_NOV", ';
    strSQL := strSQL + '  I.ITE_ITEPIG, ';
    strSQL := strSQL + '  I.ITE_ITEPIG AS "ITE_ITEPIG_NOV", ';
    strSQL := strSQL + '  I.ITE_FATCNV, ';
    strSQL := strSQL + '  I.ITE_FATCNV AS "ITE_FATCNV_NOV", ';
    strSQL := strSQL + '  I.ITE_PESOIT, ';
    strSQL := strSQL + '  I.ITE_PESOIT AS "ITE_PESOIT_NOV", ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_PESLIQ AS "ITE_PESLIQ_NOV", ';
    strSQL := strSQL + '  G.ITE_CPRCEN, ';
    strSQL := strSQL + '  G.ITE_CPRCEN AS "ITE_CPRCEN_NOV", ';
    strSQL := strSQL + '  G.ITE_ABAMLT, ';
    strSQL := strSQL + '  G.ITE_ABAMLT AS "ITE_ABAMLT_NOV", ';
    strSQL := strSQL + '  I.ITE_BAREXP, ';
    strSQL := strSQL + '  I.ITE_BAREXP AS "ITE_BAREXP_NOV", ';
    strSQL := strSQL + '  I.ITE_SEPBAR, ';
    strSQL := strSQL + '  I.ITE_SEPBAR AS "ITE_SEPBAR_NOV", ';
    strSQL := strSQL + '  G.ITE_DESCHK, ';
    strSQL := strSQL + '  G.ITE_DESCHK AS "ITE_DESCHK_NOV", ';

    strSQL := strSQL + '  G.ITE_CICMDE, ';
    strSQL := strSQL + '  G.ITE_CICMDE AS "ITE_CICMDE_NOV", ';
    strSQL := strSQL + '  G.ITE_CDPIOP, ';
    strSQL := strSQL + '  G.ITE_CDPIOP AS "ITE_CDPIOP_NOV", ';
    strSQL := strSQL + '  G.ITE_DIDIOP, ';
    strSQL := strSQL + '  G.ITE_DIDIOP AS "ITE_DIDIOP_NOV", ';

    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  I.ITE_OBRCPF AS "ITE_OBRCPF_NOV", ';
    strSQL := strSQL + '  I.ITE_OBRIBA, ';
    strSQL := strSQL + '  I.ITE_OBRIBA AS "ITE_OBRIBA_NOV", ';
    strSQL := strSQL + '  G.ITE_PONEXP, ';
    strSQL := strSQL + '  G.ITE_PONEXP AS "ITE_PONEXP_NOV", ';

    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE1 AS "ITE_PREVE1_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR1", ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE2 AS "ITE_PREVE2_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR2", ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE3 AS "ITE_PREVE3_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR3", ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE4 AS "ITE_PREVE4_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR4", ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE5 AS "ITE_PREVE5_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR5", ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE6 AS "ITE_PREVE6_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR6", ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';
    strSQL := strSQL + '  G.ITE_PREVE7 AS "ITE_PREVE7_NOV", ';
    strSQL := strSQL + '  0 AS "ITE_VENVAR7", ';


    If blnAltFornecedor And (Not blnTABPRD) Then
    Begin
      strSQL := strSQL + '  G.ITE_PRECOM, ';
      strSQL := strSQL + '  A.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF01, ';
      strSQL := strSQL + '  A.ITE_DESF01 AS "ITE_DESF01_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF02, ';
      strSQL := strSQL + '  A.ITE_DESF02 AS "ITE_DESF02_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF03, ';
      strSQL := strSQL + '  A.ITE_DESF03 AS "ITE_DESF03_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF04, ';
      strSQL := strSQL + '  A.ITE_DESF04 AS "ITE_DESF04_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF05, ';
      strSQL := strSQL + '  A.ITE_DESF05 AS "ITE_DESF05_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF06, ';
      strSQL := strSQL + '  A.ITE_DESF06 AS "ITE_DESF06_NOV", ';
      strSQL := strSQL + '  G.ITE_ICMENT, ';
      strSQL := strSQL + '  A.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
      strSQL := strSQL + '  G.ITE_SUBFED, ';
      strSQL := strSQL + '  A.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
      strSQL := strSQL + '  G.ITE_IPIENT, ';
      strSQL := strSQL + '  A.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
      strSQL := strSQL + '  G.ITE_FREENT, ';
      strSQL := strSQL + '  A.ITE_FREENT AS "ITE_FREENT_NOV", ';
      strSQL := strSQL + '  G.ITE_VALFRE, ';
      strSQL := strSQL + '  A.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
      strSQL := strSQL + '  G.ITE_ACRFIN, ';
      strSQL := strSQL + '  A.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
      strSQL := strSQL + '  G.ITE_SUBSTI, ';
      strSQL := strSQL + '  A.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
      strSQL := strSQL + '  G.ITE_DESADB, ';
      strSQL := strSQL + '  A.ITE_DESADB AS "ITE_DESADB_NOV", ';
      strSQL := strSQL + '  G.ITE_IMPFED, ';
      strSQL := strSQL + '  A.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
      strSQL := strSQL + '  G.ITE_DESOPE, ';
      strSQL := strSQL + '  A.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
      strSQL := strSQL + '  G.ITE_ICMSAI, ';
      strSQL := strSQL + '  A.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
      strSQL := strSQL + '  G.ITE_TCIFCU, ';
      strSQL := strSQL + '  A.ITE_TCIFCU AS "ITE_TCIFCU_NOV", ';
      strSQL := strSQL + '  G.ITE_TSCUST, ';
      strSQL := strSQL + '  A.ITE_TSCUST AS "ITE_TSCUST_NOV", ';
      strSQL := strSQL + '  G.ITE_DEPICO, ';
      strSQL := strSQL + '  A.ITE_DEPICO AS "ITE_DEPICO_NOV", ';
      strSQL := strSQL + '  G.ITE_DEICMS, ';
      strSQL := strSQL + '  A.ITE_DEICMS AS "ITE_DEICMS_NOV", ';
      strSQL := strSQL + '  G.ITE_FATREG, ';
      strSQL := strSQL + '  A.ITE_FATREG AS "ITE_FATREG_NOV", ';
      strSQL := strSQL + '  G.ITE_PRECUS, ';
      strSQL := strSQL + '  A.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
      strSQL := strSQL + '  G.ITE_OUTVAL, ';
      strSQL := strSQL + '  A.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
    End
    Else
    Begin
      strSQL := strSQL + '  G.ITE_PRECOM, ';
      strSQL := strSQL + '  G.ITE_PRECOM AS "ITE_PRECOM_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF01, ';
      strSQL := strSQL + '  G.ITE_DESF01 AS "ITE_DESF01_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF02, ';
      strSQL := strSQL + '  G.ITE_DESF02 AS "ITE_DESF02_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF03, ';
      strSQL := strSQL + '  G.ITE_DESF03 AS "ITE_DESF03_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF04, ';
      strSQL := strSQL + '  G.ITE_DESF04 AS "ITE_DESF04_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF05, ';
      strSQL := strSQL + '  G.ITE_DESF05 AS "ITE_DESF05_NOV", ';
      strSQL := strSQL + '  G.ITE_DESF06, ';
      strSQL := strSQL + '  G.ITE_DESF06 AS "ITE_DESF06_NOV", ';
      strSQL := strSQL + '  G.ITE_ICMENT, ';
      strSQL := strSQL + '  G.ITE_ICMENT AS "ITE_ICMENT_NOV", ';
      strSQL := strSQL + '  G.ITE_SUBFED, ';
      strSQL := strSQL + '  G.ITE_SUBFED AS "ITE_SUBFED_NOV", ';
      strSQL := strSQL + '  G.ITE_IPIENT, ';
      strSQL := strSQL + '  G.ITE_IPIENT AS "ITE_IPIENT_NOV", ';
      strSQL := strSQL + '  G.ITE_FREENT, ';
      strSQL := strSQL + '  G.ITE_FREENT AS "ITE_FREENT_NOV", ';
      strSQL := strSQL + '  G.ITE_VALFRE, ';
      strSQL := strSQL + '  G.ITE_VALFRE AS "ITE_VALFRE_NOV", ';
      strSQL := strSQL + '  G.ITE_ACRFIN, ';
      strSQL := strSQL + '  G.ITE_ACRFIN AS "ITE_ACRFIN_NOV", ';
      strSQL := strSQL + '  G.ITE_SUBSTI, ';
      strSQL := strSQL + '  G.ITE_SUBSTI AS "ITE_SUBSTI_NOV", ';
      strSQL := strSQL + '  G.ITE_DESADB, ';
      strSQL := strSQL + '  G.ITE_DESADB AS "ITE_DESADB_NOV", ';
      strSQL := strSQL + '  G.ITE_IMPFED, ';
      strSQL := strSQL + '  G.ITE_IMPFED AS "ITE_IMPFED_NOV", ';
      strSQL := strSQL + '  G.ITE_DESOPE, ';
      strSQL := strSQL + '  G.ITE_DESOPE AS "ITE_DESOPE_NOV", ';
      strSQL := strSQL + '  G.ITE_ICMSAI, ';
      strSQL := strSQL + '  G.ITE_ICMSAI AS "ITE_ICMSAI_NOV", ';
      strSQL := strSQL + '  G.ITE_TCIFCU, ';
      strSQL := strSQL + '  G.ITE_TCIFCU AS "ITE_TCIFCU_NOV", ';
      strSQL := strSQL + '  G.ITE_TSCUST, ';
      strSQL := strSQL + '  G.ITE_TSCUST AS "ITE_TSCUST_NOV", ';
      strSQL := strSQL + '  G.ITE_DEPICO, ';
      strSQL := strSQL + '  G.ITE_DEPICO AS "ITE_DEPICO_NOV", ';
      strSQL := strSQL + '  G.ITE_DEICMS, ';
      strSQL := strSQL + '  G.ITE_DEICMS AS "ITE_DEICMS_NOV", ';
      strSQL := strSQL + '  G.ITE_FATREG, ';
      strSQL := strSQL + '  G.ITE_FATREG AS "ITE_FATREG_NOV", ';
      strSQL := strSQL + '  G.ITE_PRECUS, ';
      strSQL := strSQL + '  G.ITE_PRECUS AS "ITE_PRECUS_NOV", ';
      strSQL := strSQL + '  G.ITE_OUTVAL, ';
      strSQL := strSQL + '  G.ITE_OUTVAL AS "ITE_OUTVAL_NOV", ';
    End;

    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_IPISAI AS "ITE_IPISAI_NOV", ';

    if not blnIteTbp Then
    Begin
      strSQL := strSQL + '  G.ITE_DESMAX, ';
      strSQL := strSQL + '  G.ITE_DESMAX AS "ITE_DESMAX_NOV", ';
      strSQL := strSQL + '  G.ITE_DESMGE, ';
      strSQL := strSQL + '  G.ITE_DESMGE AS "ITE_DESMGE_NOV", ';
      strSQL := strSQL + '  G.ITE_DESMSU, ';
      strSQL := strSQL + '  G.ITE_DESMSU AS "ITE_DESMSU_NOV", ';

      strSQL := strSQL + '  G.ITE_DESMVM, ';
      strSQL := strSQL + '  G.ITE_DESMVM AS "ITE_DESMVM_NOV", ';
      strSQL := strSQL + '  G.ITE_DESMGM, ';
      strSQL := strSQL + '  G.ITE_DESMGM AS "ITE_DESMGM_NOV", ';
      strSQL := strSQL + '  G.ITE_DESMSM, ';
      strSQL := strSQL + '  G.ITE_DESMSM AS "ITE_DESMSM_NOV", ';
    End
    Else
    Begin
      For intCorre := 1 To Length(VS_strTabPrc) Do
            strSQL := strSQL + fAddIteTbp(intCorre);
    End;



    strSQL := strSQL + '  G.ITE_MARBR1, ';
    strSQL := strSQL + '  G.ITE_MARBR1 AS "ITE_MARBR1_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR2, ';
    strSQL := strSQL + '  G.ITE_MARBR2 AS "ITE_MARBR2_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR3, ';
    strSQL := strSQL + '  G.ITE_MARBR3 AS "ITE_MARBR3_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR4, ';
    strSQL := strSQL + '  G.ITE_MARBR4 AS "ITE_MARBR4_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR5, ';
    strSQL := strSQL + '  G.ITE_MARBR5 AS "ITE_MARBR5_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR6, ';
    strSQL := strSQL + '  G.ITE_MARBR6 AS "ITE_MARBR6_NOV", ';
    strSQL := strSQL + '  G.ITE_MARBR7, ';
    strSQL := strSQL + '  G.ITE_MARBR7 AS "ITE_MARBR7_NOV", ';

    strSQL := strSQL + ' 0.00 AS ITE_MARLQ1, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ1_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ2, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ2_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ3, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ3_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ4, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ4_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ5, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ5_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ6, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ6_NOV", ';
    strSQL := strSQL + ' 0.00 AS ITE_MARLQ7, ';
    strSQL := strSQL + ' 0.00 AS "ITE_MARLQ7_NOV", ';

    If fCfgSis('MARIDE', VarBoolean) Then
    Begin
      strSQL := strSQL + '  G.ITE_MARID1, ';
      strSQL := strSQL + '  G.ITE_MARID1 AS "ITE_MARID1_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID2, ';
      strSQL := strSQL + '  G.ITE_MARID2 AS "ITE_MARID2_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID3, ';
      strSQL := strSQL + '  G.ITE_MARID3 AS "ITE_MARID3_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID4, ';
      strSQL := strSQL + '  G.ITE_MARID4 AS "ITE_MARID4_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID5, ';
      strSQL := strSQL + '  G.ITE_MARID5 AS "ITE_MARID5_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID6, ';
      strSQL := strSQL + '  G.ITE_MARID6 AS "ITE_MARID6_NOV", ';
      strSQL := strSQL + '  G.ITE_MARID7, ';
      strSQL := strSQL + '  G.ITE_MARID7 AS "ITE_MARID7_NOV", ';
    End;

    strSQL := strSQL + '  G.ITE_COMTB1, ';
    strSQL := strSQL + '  G.ITE_COMTB1 AS "ITE_COMTB1_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB2, ';
    strSQL := strSQL + '  G.ITE_COMTB2 AS "ITE_COMTB2_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB3, ';
    strSQL := strSQL + '  G.ITE_COMTB3 AS "ITE_COMTB3_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB4, ';
    strSQL := strSQL + '  G.ITE_COMTB4 AS "ITE_COMTB4_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB5, ';
    strSQL := strSQL + '  G.ITE_COMTB5 AS "ITE_COMTB5_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB6, ';
    strSQL := strSQL + '  G.ITE_COMTB6 AS "ITE_COMTB6_NOV", ';
    strSQL := strSQL + '  G.ITE_COMTB7, ';
    strSQL := strSQL + '  G.ITE_COMTB7 AS "ITE_COMTB7_NOV", ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMVAR AS "ITE_COMVAR_NOV", ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMATA AS "ITE_COMATA_NOV", ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_COMDIS AS "ITE_COMDIS_NOV", ';
    strSQL := strSQL + '  G.ITE_COMDIG, ';
    strSQL := strSQL + '  G.ITE_COMDIG AS "ITE_COMDIG_NOV", ';
    strSQL := strSQL + '  G.ITE_COMMEC, ';
    strSQL := strSQL + '  G.ITE_COMMEC AS "ITE_COMMEC_NOV", ';
    strSQL := strSQL + '  G.ITE_COMPRO, ';
    strSQL := strSQL + '  G.ITE_COMPRO AS "ITE_COMPRO_NOV", ';
    strSQL := strSQL + '  G.ITE_QTPPRO, ';
    strSQL := strSQL + '  G.ITE_QTPPRO AS "ITE_QTPPRO_NOV", ';
    strSQL := strSQL + '  I.ITE_UNICOM, ';
    strSQL := strSQL + '  I.ITE_UNICOM AS "ITE_UNICOM_NOV", ';

    If fCfgSis('UNITRI') = 'S' Then
    Begin
      strSQL := strSQL + '  I.ITE_UNITRI, ';
      strSQL := strSQL + '  I.ITE_UNITRI AS "ITE_UNITRI_NOV", ';

      strSQL := strSQL + '  I.ITE_FATUTR, ';
      strSQL := strSQL + '  I.ITE_FATUTR AS "ITE_FATUTR_NOV", ';
    End;

    strSQL := strSQL + '  I.ITE_ATICOM, ';
    strSQL := strSQL + '  I.ITE_ATICOM AS "ITE_ATICOM_NOV", ';
    strSQL := strSQL + '  I.ITE_PEEFUT, ';
    strSQL := strSQL + '  I.ITE_PEEFUT AS "ITE_PEEFUT_NOV", ';
    strSQL := strSQL + '  I.ITE_PEFUTP, ';
    strSQL := strSQL + '  I.ITE_PEFUTP AS "ITE_PEFUTP_NOV", ';
    strSQL := strSQL + '  I.ITE_PEFFPR, ';
    strSQL := strSQL + '  I.ITE_PEFFPR AS "ITE_PEFFPR_NOV", ';
    strSQL := strSQL + '  G.ITE_LOCFIS, ';
    strSQL := strSQL + '  G.ITE_LOCFIS AS "ITE_LOCFIS_NOV", ';
    strSQL := strSQL + '  G.ITE_TAMLCF, ';
    strSQL := strSQL + '  G.ITE_TAMLCF AS "ITE_TAMLCF_NOV", ';
    strSQL := strSQL + '  G.ITE_LOCSUP, ';
    strSQL := strSQL + '  G.ITE_LOCSUP AS "ITE_LOCSUP_NOV", ';
    strSQL := strSQL + '  G.ITE_TAMLCS, ';
    strSQL := strSQL + '  G.ITE_TAMLCS AS "ITE_TAMLCS_NOV", ';
    strSQL := strSQL + '  G.ITE_CODLSE, ';
    strSQL := strSQL + '  G.ITE_CODLSE AS "ITE_CODLSE_NOV", ';

    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMIN AS "ITE_MARMIN_NOV", ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMSG AS "ITE_MARMSG_NOV", ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';
    strSQL := strSQL + '  G.ITE_MARMGE AS "ITE_MARMGE_NOV", ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMV AS "ITE_MARMMV_NOV", ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';
    strSQL := strSQL + '  G.ITE_MARMMG AS "ITE_MARMMG_NOV", ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMS AS "ITE_MARMMS_NOV", ';

    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_CLAIPI AS "ITE_CLAIPI_NOV", ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI AS "ITE_EXCIPI_NOV", ';
    strSQL := strSQL + '  I.ITE_CDCEST, ';
    strSQL := strSQL + '  I.ITE_CDCEST AS "ITE_CDCEST_NOV", ';
    strSQL := strSQL + '  I.ITE_CLACRM, ';
    strSQL := strSQL + '  I.ITE_CLACRM AS "ITE_CLACRM_NOV", ';
    strSQL := strSQL + '  I.ITE_UTIAMP, ';
    strSQL := strSQL + '  I.ITE_UTIAMP AS "ITE_UTIAMP_NOV", ';
    strSQL := strSQL + '  I.ITE_CODGPC, ';
    strSQL := strSQL + '  I.ITE_CODGPC AS "ITE_CODGPC_NOV", ';
    strSQL := strSQL + '  G.ITE_ESMIDG, ';
    strSQL := strSQL + '  G.ITE_ESMIDG AS "ITE_ESMIDG_NOV", ';
    strSQL := strSQL + '  G.ITE_TPESTM, ';
    strSQL := strSQL + '  G.ITE_TPESTM AS "ITE_TPESTM_NOV", ';
    strSQL := strSQL + '  I.ITE_ORDSER, ';
    strSQL := strSQL + '  I.ITE_ORDSER AS "ITE_ORDSER_NOV", ';

    strSQL := strSQL + '  G.ITE_CPESOB, ';
    strSQL := strSQL + '  G.ITE_CPESOB AS "ITE_CPESOB_NOV", ';

    strSQL := strSQL + '  I.ITE_DESCND, ';
    strSQL := strSQL + '  I.ITE_DESCND AS "ITE_DESCND_NOV", ';

    if FPermVendaIgualTodasEmp then
    begin
      strSQL := strSQL + '  I.ITE_PERVDA, ';
      strSQL := strSQL + '  I.ITE_PERVDA AS "ITE_PERVDA_NOV", ';
    end
    else
    begin
      strSQL := strSQL + '  G.ITE_PEVNDA AS ITE_PERVDA, ';
      strSQL := strSQL + '  G.ITE_PEVNDA AS "ITE_PERVDA_NOV", ';
    end;

    strSQL := strSQL + '  G.ITE_RECDEV, ';
    strSQL := strSQL + '  G.ITE_RECDEV AS "ITE_RECDEV_NOV", ';

    strSQL := strSQL + '  I.ITE_CODFOR, ';
    strSQL := strSQL + '  I.ITE_CODFOR AS "ITE_CODFOR_NOV", ';
    strSQL := strSQL + '  I.ITE_INFLAM, ';
    strSQL := strSQL + '  I.ITE_INFLAM AS "ITE_INFLAM_NOV", ';
    strSQL := strSQL + '  I.ITE_NVLGIR, ';
    strSQL := strSQL + '  I.ITE_NVLGIR AS "ITE_NVLGIR_NOV", ';

    strSQL := strSQL + '  I.ITE_NVLCRI, ';
    strSQL := strSQL + '  I.ITE_NVLCRI AS "ITE_NVLCRI_NOV", ';

    strSQL := strSQL + '  G.ITE_NIVCRI, ';
    strSQL := strSQL + '  G.ITE_NIVCRI AS "ITE_NIVCRI_NOV", ';

    strSQL := strSQL + '  I.ITE_CODGPR, ';
    strSQL := strSQL + '  I.ITE_CODGPR AS "ITE_CODGPR_NOV", ';
    strSQL := strSQL + '  I.ITE_PRDGRU, ';
    strSQL := strSQL + '  I.ITE_PRDGRU AS "ITE_PRDGRU_NOV", ';
    strSQL := strSQL + '  I.ITE_MENFIS, ';
    strSQL := strSQL + '  I.ITE_MENFIS AS "ITE_MENFIS_NOV", ';
    strSQL := strSQL + '  I.ITE_PER_CI, ';
    strSQL := strSQL + '  I.ITE_PER_CI AS "ITE_PER_CI_NOV", ';

    strSQL := strSQL + '  I.ITE_PIMPTC, ';
    strSQL := strSQL + '  I.ITE_PIMPTC AS "ITE_PIMPTC_NOV", ';

    strSQL := strSQL + '  I.ITE_NUMFCI, ';
    strSQL := strSQL + '  I.ITE_NUMFCI AS "ITE_NUMFCI_NOV", ';
    strSQL := strSQL + '  I.ITE_EXPSIT, ';
    strSQL := strSQL + '  I.ITE_EXPSIT AS "ITE_EXPSIT_NOV",  ';
    strSQL := strSQL + '  I.ITE_EXPPOK, ';
    strSQL := strSQL + '  I.ITE_EXPPOK AS "ITE_EXPPOK_NOV",  ';
    strSQL := strSQL + '  I.ITE_EXPAPP, ';
    strSQL := strSQL + '  I.ITE_EXPAPP AS "ITE_EXPAPP_NOV",  ';
    strSQL := strSQL + '  I.ITE_EXPB2B, ';
    strSQL := strSQL + '  I.ITE_EXPB2B AS "ITE_EXPB2B_NOV",  ';

    strSQL := strSQL + '  DE.ITE_DESSIT, ';
    strSQL := strSQL + '  DE.ITE_DESSIT AS "ITE_DESSIT_NOV", ';

    strSQL := strSQL + '  DE.ITE_CRODOC, ';
    strSQL := strSQL + '  DE.ITE_CRODOC AS "ITE_CRODOC_NOV",  ';

    strSQL := strSQL + '  DE.ITE_EXPALT, ';
    strSQL := strSQL + '  DE.ITE_EXPALT AS "ITE_EXPALT_NOV", ';

    strSQL := strSQL + '  DE.ITE_EXPLAR, ';
    strSQL := strSQL + '  DE.ITE_EXPLAR AS "ITE_EXPLAR_NOV", ';

    strSQL := strSQL + '  DE.ITE_EXPPRO, ';
    strSQL := strSQL + '  DE.ITE_EXPPRO AS "ITE_EXPPRO_NOV", ';

    strSQL := strSQL + '  DE.ITE_DESTAQ, ';
    strSQL := strSQL + '  DE.ITE_DESTAQ AS "ITE_DESTAQ_NOV", ';

    strSQL := strSQL + '  DE.ITE_APLITE, ';
    strSQL := strSQL + '  DE.ITE_APLITE AS "ITE_APLITE_NOV", ';

    strSQL := strSQL + '  DE.ITE_DESITE AS EC_ITE_DESITE, ';
    strSQL := strSQL + '  DE.ITE_DESITE AS "EC_ITE_DESITE_NOV", ';

    strSQL := strSQL + '  I.ITE_TIPFRE, ';
    strSQL := strSQL + '  I.ITE_TIPFRE AS "ITE_TIPFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_VLCFRE, ';
    strSQL := strSQL + '  I.ITE_VLCFRE AS "ITE_VLCFRE_NOV", ';
    strSQL := strSQL + '  I.ITE_CODDEP, ';
    strSQL := strSQL + '  I.ITE_CODDEP AS "ITE_CODDEP_NOV", ';
    strSQL := strSQL + '  I.ITE_USABON, ';
    strSQL := strSQL + '  I.ITE_USABON AS "ITE_USABON_NOV", ';
    strSQL := strSQL + '  I.ITE_USAFLE, ';
    strSQL := strSQL + '  I.ITE_USAFLE AS "ITE_USAFLE_NOV", ';

    strSQL := strSQL + '  IF(ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS ITE_CAREST, ';
    strSQL := strSQL + '  IF(ITE_CAREST = "I", "ITEM ESTRUTURA", "SUB-PRODUTOS") AS "ITE_CAREST_NOV", ';

    If fCfgSis('UTIWMS', VarBoolean) Then
    Begin
      If fCfgSis('WMSLOT', varBoolean) Then
      Begin
        strSQL := strSQL + '  I.ITE_LOTEPD, ';
        strSQL := strSQL + '  I.ITE_LOTEPD AS "ITE_LOTEPD_NOV", ';
      End;
    End;

    strSQL := strSQL + '  I.ITE_VALOBR, ';
    strSQL := strSQL + '  I.ITE_VALOBR AS "ITE_VALOBR_NOV", ';
    strSQL := strSQL + '  I.ITE_NOTESP, ';
    strSQL := strSQL + '  I.ITE_NOTESP AS "ITE_NOTESP_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB1, ';
    strSQL := strSQL + '  G.ITE_MINTB1 AS "ITE_MINTB1_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB2, ';
    strSQL := strSQL + '  G.ITE_MINTB2 AS "ITE_MINTB2_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB3, ';
    strSQL := strSQL + '  G.ITE_MINTB3 AS "ITE_MINTB3_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB4, ';
    strSQL := strSQL + '  G.ITE_MINTB4 AS "ITE_MINTB4_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB5, ';
    strSQL := strSQL + '  G.ITE_MINTB5 AS "ITE_MINTB5_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB6, ';
    strSQL := strSQL + '  G.ITE_MINTB6 AS "ITE_MINTB6_NOV", ';
    strSQL := strSQL + '  G.ITE_MINTB7, ';
    strSQL := strSQL + '  G.ITE_MINTB7 AS "ITE_MINTB7_NOV", ';

    {******************}
    {* ESTOQUE MÍNIMO *}
    {***************RV*}
    strSQL := strSQL + '  G.ITE_ESTMIN, ';
    strSQL := strSQL + '  G.ITE_ESTMIN AS "ITE_ESTMIN_NOV", ';
    {******************}
    {* ESTOQUE MÁXIMO *}
    {***************RV*}
    strSQL := strSQL + '  G.ITE_ESTMAX, ';
    strSQL := strSQL + '  G.ITE_ESTMAX AS "ITE_ESTMAX_NOV",  ';
    strSQL := strSQL + '  I.ITE_ATICOM, ';
    strSQL := strSQL + '  I.ITE_ATICOM AS "ITE_ATICOM_NOV", ';
    strSQL := strSQL + '  I.ITE_RPRENT, ';
    strSQL := strSQL + '  I.ITE_RPRENT AS "ITE_RPRENT_NOV", ';


    If fCfgSis('OPCCOM', varString) = 'VT' Then
    Begin
      For intTblPrc := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intTblPrc] = 'S' Then
        Begin
          strSQL := strSQL + ' (SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intTblPrc)) + ' ) AS COM_VENINT' + intToStr(intTblPrc) + ', ';
          strSQL := strSQL + ' (SELECT COM_VENINT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intTblPrc)) + ' ) AS COM_VENINT' + intToStr(intTblPrc) + '_NOV, ';

          strSQL := strSQL + ' (SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intTblPrc)) + ' ) AS COM_VENEXT' + intToStr(intTblPrc) + ', ';
          strSQL := strSQL + ' (SELECT COM_VENEXT FROM COMITE WHERE COM_CODITE = I.ITE_CODITE AND COM_TABPRE = ' + QuotedStr(intToStr(intTblPrc)) + ' ) AS COM_VENEXT' + intToStr(intTblPrc) + '_NOV, ';

        End;

      End;

    End;

    if fCfgSis('CLAONU', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_CODONU, ';
      strSQL := strSQL + '  I.ITE_CODONU AS "ITE_CODONU_NOV",  ';
    End;

    strSQL := strSQL + '  I.ITE_PRAVAL, ';
    strSQL := strSQL + '  I.ITE_PRAVAL AS "ITE_PRAVAL_NOV"  ';

    if blnSergipe then
    Begin
      strSQL := strSQL + ' , ';
      strSQL := strSQL + '  I.ITE_CODDIC, ';
      strSQL := strSQL + '  I.ITE_CODDIC AS "ITE_CODDIC_NOV"  ';
    End;

    If blnURapel Then
    Begin
      strSQL := strSQL + '  , ';
      strSQL := strSQL + '  I.ITE_PRAPEL, ';
      strSQL := strSQL + '  I.ITE_PRAPEL AS "ITE_PRAPEL_NOV"  ';
    End;

    strSQL := strSQL + ' , ';
    strSQL := strSQL + '  G.ITE_TIPPRO, ';
    strSQL := strSQL + '  G.ITE_TIPPRO AS "ITE_TIPPRO_NOV",  ';

    strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS ITE_APLICA, ';
    strSQL := strSQL + '  REPLACE(I.ITE_APLICA, "<<csq>>", "\n") AS "ITE_APLICA_NOV",  ';

    strSQL := strSQL + '  I.ITE_IMPETI, ';
    strSQL := strSQL + '  I.ITE_IMPETI AS "ITE_IMPETI_NOV",  ';

    strSQL := strSQL + '  I.ITE_DENSID, ';
    strSQL := strSQL + '  I.ITE_DENSID AS "ITE_DENSID_NOV",  ';

    strSQL := strSQL + '  I.ITE_LARVID, ';
    strSQL := strSQL + '  I.ITE_LARVID AS "ITE_LARVID_NOV", ';
    strSQL := strSQL + '  I.ITE_ALTVID, ';
    strSQL := strSQL + '  I.ITE_ALTVID AS "ITE_ALTVID_NOV", ';
    strSQL := strSQL + '  I.ITE_LAMAVI, ';
    strSQL := strSQL + '  I.ITE_LAMAVI AS "ITE_LAMAVI_NOV", ';
    strSQL := strSQL + '  I.ITE_ALMAVI, ';
    strSQL := strSQL + '  I.ITE_ALMAVI AS "ITE_ALMAVI_NOV", ';

    strSQL := strSQL + '  I.ITE_RASTRE, ';
    strSQL := strSQL + '  I.ITE_RASTRE AS "ITE_RASTRE_NOV",  ';

    strSQL := strSQL + '  G.ITE_PESOBR, ';
    strSQL := strSQL + '  G.ITE_PESOBR AS "ITE_PESOBR_NOV",   ';

    If fCfgSis('EMPCAR', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_EMPCAR, ';
      strSQL := strSQL + '  I.ITE_EMPCAR AS "ITE_EMPCAR_NOV", ';
    End;

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    begin
      strSQL := strSQL + '  I.ITE_EMPSUG, ';
      strSQL := strSQL + '  I.ITE_EMPSUG AS "ITE_EMPSUG_NOV", ';
    end;

    strSQL := strSQL + '  I.ITE_ETIQRE, ';
    strSQL := strSQL + '  I.ITE_ETIQRE AS "ITE_ETIQRE_NOV",   ';

    strSQL := strSQL + '  I.ITE_DIACRI, ';
    strSQL := strSQL + '  I.ITE_DIACRI AS "ITE_DIACRI_NOV", ';

    if fCfgSis('MARPAD') = 'S' Then
    Begin
      strSQL := strSQL + '  G.ITE_MARPAD, ';
      strSQL := strSQL + '  G.ITE_MARPAD AS "ITE_MARPAD_NOV",  ';
    End;

    strSQL := strSQL + '  G.ITE_USASER, ';
    strSQL := strSQL + '  G.ITE_USASER AS "ITE_USASER_NOV", ';

    strSQL := strSQL + '  G.ITE_APERET, ';
    strSQL := strSQL + '  G.ITE_APERET AS "ITE_APERET_NOV", ';
    strSQL := strSQL + '  G.ITE_APEENT, ';
    strSQL := strSQL + '  G.ITE_APEENT AS "ITE_APEENT_NOV",  ';

    If fCfgSis('OPCROM') = '5' Then
    Begin
      strSQL := strSQL + '  I.ITE_ENTESP, ';
      strSQL := strSQL + '  I.ITE_ENTESP AS "ITE_ENTESP_NOV", ';
    End;

    If fCfgSis('SEPEXC', varBoolean) Then
    Begin
      strSQL := strSQL + '  I.ITE_SEPEXC, ';
      strSQL := strSQL + '  I.ITE_SEPEXC AS "ITE_SEPEXC_NOV", ';
    End;

    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI               ';

    if blnUtilizaChecklistGarantia then
    begin
      strSQL := strSQL + ', G.ITE_CODATC, ';
      strSQL := strSQL + 'G.ITE_CODATC AS "ITE_CODATC_NOV" ';
    end;

    strSQL := strSQL + ', G.ITE_SOBENC, ';
    strSQL := strSQL + 'G.ITE_SOBENC AS "ITE_SOBENC_NOV" ';

    If fCfgSis('UTPEST', varBoolean) Then
    Begin
      strSQL := strSQL + ', I.ITE_QTDPES, ';
      strSQL := strSQL + '  I.ITE_QTDPES AS "ITE_QTDPES_NOV", ';
      strSQL := strSQL + '  I.ITE_PORPES, ';
      strSQL := strSQL + '  I.ITE_PORPES AS "ITE_PORPES_NOV"  ';
    End;

    If fCfgSis('UTIABA', varBoolean) Then
    Begin
      strSQL := strSQL + ', IF(G.ITE_MLTRCA = "C", "COMPRA", "VENDA") AS ITE_MLTRCA, ';
      strSQL := strSQL + 'IF(G.ITE_MLTRCA = "C", "COMPRA", "VENDA") AS "ITE_MLTRCA_NOV" ';
    End;

    If fCfgSis('ETIDCE', varBoolean) Then
    Begin
      strSQL := strSQL + ', I.ITE_NECEXP AS ITE_NECEXP, ';
      strSQL := strSQL + 'ITE_NECEXP AS "ITE_NECEXP_NOV" ';
    End;

    If fCfgSis('LOCRET', varBoolean) Then
    Begin
      strSQL := strSQL + ',  G.ITE_TIPRET AS ITE_TIPRET, ';
      strSQL := strSQL + '   ITE_TIPRET AS "ITE_TIPRET_NOV" ';
    End;

    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      strSQL := strSQL + ',  I.ITE_NFEIDP AS ITE_NFEIDP, ';
      strSQL := strSQL + '   ITE_NFEIDP AS "ITE_NFEIDP_NOV" ';

      strSQL := strSQL + ',  I.ITE_NFCIDP AS ITE_NFCIDP, ';
      strSQL := strSQL + '   ITE_NFCIDP AS "ITE_NFCIDP_NOV" ';
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    Begin
      strSQL := strSQL + ',  I.ITE_LOTRAP AS ITE_LOTRAP, ';
      strSQL := strSQL + '   ITE_LOTRAP AS "ITE_LOTRAP_NOV" ';
    End;

    If fCfgSis('CDPHAB', varBoolean) Then
    Begin
      strSQL := strSQL + ' ,I.ITE_CLBPIN, ';
      strSQL := strSQL + '  I.ITE_CLBPIN AS "ITE_CLBPIN_NOV"  ';
    End;

    If blnUsaBef Then
    Begin
      strSQL := strSQL + ' ,I.ITE_USABEF, ';
      strSQL := strSQL + '  I.ITE_USABEF AS "ITE_USABEF_NOV"  ';
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '               AND G.ITE_CODEMP = :CODEMP ';

    strSQL := strSQL + '  LEFT JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';

    strSQL := strSQL + '  LEFT JOIN DESSIT DE ON G.ITE_CODITE = DE.ITE_CODITE ';

    If chkNotEnt.Checked Then
    Begin
      strSQL := strSQL + ' JOIN MOVDET D ON D.DET_CODITE = I.ITE_CODITE ';
      If (Not fEmptyStr(edtDocumento.Text)) Then
        strSQL := strSQL + '              AND D.DET_NUMDOC = :NUMDOC      '
      Else
        strSQL := strSQL + '              AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  ';

      If Not fEmptyStr(edtSerie.Text) Then
        strSQL := strSQL + '              AND D.DET_SERIE_ = :SERDOC      ';
      If Not fEmptyStr(edtCodEmpresa.Text) Then
        strSQL := strSQL + '              AND D.DET_CODEMP = :EMPDOC      ';
      If Not fEmptyStr(edtEspecie.Text) Then
        strSQL := strSQL + '              AND D.DET_ESPDOC = :ESPDOC      ';


      If Not fEmptyStr(edtForNot.Text) Then
        strSQL := strSQL + ' AND D.DET_CODFOR = :FORNOT ';
      strSQL := strSQL + '              AND IFNULL(DET_ORIDOC, "") = "" ';

    End;
    If blnTABPRD and (not blnAltFornecedor) then
    Begin
      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        strSQL := strSQL + ' LEFT JOIN TABDET D' + IntToStr(intContador) + ' ON D' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
        strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODEMP = G.ITE_CODEMP';
        strSQL := strSQL + '                                                AND D' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE ';

        strSQL := strSQL + 'LEFT JOIN DETCUS DC' + IntToStr(intContador) + ' ON DC' + IntToStr(intContador) + '.DET_SEQDET = D' + IntToStr(intContador) + '.AUTOINCREM ';
        strSQL := strSQL + '                                                AND DC' + IntToStr(intContador) + '.DET_TABELA = "' + IntToStr(intContador) + '" ';

         strSQL := strSQL + ' LEFT JOIN ITEFOR F' + IntToStr(intContador) + ' ON F' + IntToStr(intContador) + '.ITE_CODTAB = G.ITE_TABPR' + IntToStr(intContador);
        strSQL := strSQL + '                                                  AND F' + IntToStr(intContador) + '.ITE_CODITE = G.ITE_CODITE';


      End;


    end
    Else If blnAltFornecedor Then
    Begin
      strSQL := strSQL + ' INNER JOIN ITEFOR F ON I.ITE_CODITE = F.ITE_CODITE ';

      strSQL := strSQL + ' INNER JOIN TABPRE T ON T.TAB_CODTAB = F.ITE_CODTAB ';

      strSQL := strSQL + ' INNER JOIN TABDET A ON A.ITE_CODTAB = F.ITE_CODTAB ';
      strSQL := strSQL + '                    AND A.ITE_CODITE = F.ITE_CODITE ';
      strSQL := strSQL + '                    AND A.ITE_CODEMP = G.ITE_CODEMP ';
      strSQL := strSQL + '                    AND A.ITE_PRECOM > 0            ';

    End;

    If Pos('ABF_IVA_ST_SAI_CCO', objGerenciaExpr.stlCamposUsados.CommaText) > 0 Then
      strSQL := strSQL + ' LEFT JOIN ABFICM C ON I.ITE_CODABF = C.ABF_CODABF ' + IIF(Not fEmptyStr(edtEstadoAbfICMS.Text), 'AND C.ABF_ESTADO = ' + QuotedStr(edtEstadoAbfICMS.Text), '');

    strSQL := strSQL + ' WHERE TRUE ';

    If (not fEmptyDate(MskDataIni.Text)) And (not fEmptyDate(MskDataFim.Text)) Then
    Begin
      strSQL := strSQL + ' AND I.ITE_CODITE NOT IN (SELECT ALT_CODITE FROM PREALT ';
      strSQL := strSQL + '                           WHERE ALT_DTAALT BETWEEN "'+FormatDateTime('yyyy-mm-dd',StrToDate(MskDataIni.Text))+'" AND ';
      strSQL := strSQL + '                                                    "'+FormatDateTime('yyyy-mm-dd',StrToDate(MskDataFim.Text))+'" ';
      strSQL := strSQL + '                             AND ALT_CODITE = I.ITE_CODITE AND LOCATE(ALT_CODEMP, "'+strEmpresas+'") > 0)';
    End;

    strSQL := strSQL + fStrLocateLinGru(mskLinGru, arrLinhaGrupo, 'ITE_CODGRU','CODGRU');

    If Not fEmptyStr(cmbGiroEstoque.Text) then
        strSQL := strSQL + ' AND I.ITE_NVLGIR = :NVLGIR ';

    If Not fEmptyStr(cmbGiroEstoqueFornecedor.Text) then
        strSQL := strSQL + ' AND LEFT(I.ITE_NVLFOR, 1) = :NVLFOR ';

    If Not fEmptyStr(edtDesIte.Text) Then
    Begin
      strSQL := strSQL + ' AND I.ITE_DESITE LIKE :DESITE ';
    End;

    If Not fEmptyStr(edtCest.Text) Then
    Begin
        strSQL := strSQL + ' AND I.ITE_CDCEST = :CDCEST ';
    End;

    If Not fEmptyStr(edtRefere.Text) Then
    Begin
      strSQL := strSQL + ' AND I.ITE_REFERE LIKE :REFERE ';
    End;

    strSQL := strSQL + objGerenciaExpr.fGetSQLExpressoes(edtDiasMovimentacao.Text, rdgEmpresaMovimentacaoEstoque.ItemIndex, rdgTipoMovimentacaoEstoque.ItemIndex);

    strSQL := strSQL + fStrLocate(edtCodUni , arrCodUni  , 'I.ITE_CODUNI', 'CODUNI');
    strSQL := strSQL + fStrLocate(edtCodMar , arrMarca   , 'I.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtPrdGru , arrGrupoPro, 'I.ITE_PRDGRU', 'PRDGRU');
    strSQL := strSQL + fStrLocate(edtCodGpr , arrCodGpr  , 'I.ITE_CODGPR', 'CODGPR');
    strSQL := strSQL + fStrLocate(edtGruCmp , arrGruCmp  , 'I.ITE_GRUCMP', 'GRUCMP');
    strSQL := strSQL + fStrLocate(edtCodDep , arrCodDep  , 'I.ITE_CODDEP', 'CODDEP');
    strSQL := strSQL + fStrLocate(edtCodCom , arrCodCom  , 'I.ITE_CODCOM', 'CODCOM');

    If (Pos(edtIncPis.Text, 'SN') > 0) Then
      strSQL := strSQL + ' AND I.ITE_INCPIS = :INCPIS ';

    If Not fEmptyStr(edtCodMon.Text) Then
    Begin
     strSQL := strSQL + '  AND (SELECT COUNT(1) FROM ITEMON ';
     strSQL := strSQL + '        WHERE TRUE ';
     strSQL := strSQL + fStrLocate(edtCodMon , arrCodMon, 'ITM_CODMON', 'CODMON');
     strSQL := strSQL + '        AND  ITM_CODITE = I.ITE_CODITE) > 0 ';
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin
      If blnAltFornecedor Then
        strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'F.ITE_CODFOR', 'CODFOR')
      Else
        strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR');
    End;

    If blnAltFornecedor Then
      strSQL := strSQL + ' AND T.TAB_CODTAB = :CODTAB ';

    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + fStrLocate(edtCodAbr , arrCodAbr , 'I.ITE_CODABF', 'CODABF')
    Else
      strSQL := strSQL + fStrLocate(edtCodAbr , arrCodAbr , 'G.ITE_CODABF', 'CODABF');

    If fCfgSIs('TPABPC') = '1' Then
      strSQL := strSQL + fStrLocate(edtAbfPis, arrAbfPis, 'I.ITE_ABFPIS', 'ABFPIS')
    Else
      strSQL := strSQL + fStrLocate(edtAbfPis, arrAbfPis, 'G.ITE_ABFPIS', 'ABFPIS');

    If fCfgSIs('TPABPC') = '1' Then
      strSQL := strSQL + fStrLocate(edtAbfCof, arrAbfCof, 'I.ITE_ABFCOF', 'ABFCOF')
    Else
      strSQL := strSQL + fStrLocate(edtAbfCof, arrAbfCof, 'G.ITE_ABFCOF', 'ABFCOF');

    If (chkPenRec.Checked) Then
      strSQL := strSQL + ' AND G.ITE_PEFAVE = "N" ';

    strSQL := strSQL + fStrLocate(edtClaIPI , arrClaIPI  , 'I.ITE_CLAIPI', 'CLAIPI');

    If Not fEmptyStr(edtExcIpi.Text) Then
    Begin
      strSQL := strSQL + ' AND I.ITE_EXCIPI = :EXCIPI ';
    End;

    If (Pos(edtStatus.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ITEATI = :ITEATI ';

    If (Pos(edtStatusCompra.Text, 'SN') > 0) Then
      strSQL := strSQL + '  AND I.ITE_ATICOM = :ATICOM ';

    Case rdgEstMin.ItemIndex Of
      0 : strSQL := strSQL + ' AND ITE_ESMIDG = "G" ';
      1 : strSQL := strSQL + ' AND ITE_ESMIDG = "D" ';
    End;

    If fCfgSis('MARIDE', VarBoolean) Then
    Begin
      strTabPrc := cbxTabPrc.Text;

      Case cbxMarIde.ItemIndex Of
        1 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' >= G.ITE_MARBR' + strTabPrc;
        2 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' <= G.ITE_MARBR' + strTabPrc;
        3 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' >  G.ITE_MARBR' + strTabPrc;
        4 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' <  G.ITE_MARBR' + strTabPrc;
        5 : strSQL := strSQL + '  AND G.ITE_MARID' + strTabPrc + ' =  G.ITE_MARBR' + strTabPrc;
      End;
    End;

    if cbxAtoDF.Checked then
      strSQL := strSQL + ' AND G.ITE_ATODDF  = "S" ';

    If Not fEmptyStr(edtLocFis.Text) Then
    Begin
      If Not blnCadLoc Then
        strSQL := strSQL + ' AND G.ITE_LOCFIS LIKE :LOCFIS ';
    End;

    if (fCfgSis('USASAN', VarString) = 'S') and (cmbCSTORI.Text<>'') then
        strSQL := strSQL + '  AND I.ITE_CSTORI = '+QuotedStr(cmbCSTORI.Text);

    strSQL := strSQL + ' GROUP BY G.ITE_CODITE ';

    strSQL := strSQL + objGerenciaExpr.fGetSQLHavingExpressoes(edtDiasMovimentacao.Text, rdgEmpresaMovimentacaoEstoque.ItemIndex, rdgTipoMovimentacaoEstoque.ItemIndex);

    With qryGenIte Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      pSetaParam(mskLinGru.Text   , arrLinhaGrupo, strLinGru, 'CODGRU', qryGenIte);

      If Not fEmptyStr(cmbGiroEstoque.Text) Then
         ParamByName('NVLGIR').AsString := Trim(cmbGiroEstoque.Text);

      If Not fEmptyStr(cmbGiroEstoqueFornecedor.Text) Then
         ParamByName('NVLFOR').AsString := Trim(cmbGiroEstoqueFornecedor.Text);

      If Not fEmptyStr(edtDesIte.Text) Then
      Begin
        ParamByName('DESITE').AsString := edtDesIte.Text + '%';
      End;

      If Not fEmptyStr(edtRefere.Text) Then
      Begin
        ParamByName('REFERE').AsString := edtRefere.Text + '%';
      End;

      pSetaParam(edtCodUni.Text   , arrCodUni,     strCodUni, 'CODUNI', qryGenIte);
      pSetaParam(edtCodMar.Text   , arrMarca,      strMarca , 'CODMAR', qryGenIte);
      pSetaParam(edtPrdGru.Text   , arrGrupoPro,   strPrdGru, 'PRDGRU', qryGenIte);
      pSetaParam(edtCodDep.Text   , arrCodDep,     strCodDep, 'CODDEP', qryGenIte);
      pSetaParam(edtGruCmp.Text   , arrGruCmp,     strGruCmp, 'GRUCMP', qryGenIte);
      pSetaParam(edtCodGpr.Text   , arrCodGpr,     strCodGpr, 'CODGPR', qryGenIte);
      pSetaParam(edtAbfPis.Text   , arrAbfPis,     strAbfPis, 'ABFPIS', qryGenIte);
      pSetaParam(edtAbfCof.Text   , arrAbfCof,     strAbfCof, 'ABFCOF', qryGenIte);
      pSetaParam(edtCodCom.Text   , arrCodCom,     strCodCom, 'CODCOM', qryGenIte);

      If (Pos(edtIncPis.Text, 'SN') > 0) Then
        ParamByName('INCPIS').AsString := edtIncPis.Text;

      pSetaParam(edtCodMon.Text   , arrCodMon,     strCodMon, 'CODMON', qryGenIte);

      If Not fEmptyStr(edtCodFor.Text) Then
      Begin
        pSetaParam(edtCodFor.Text   , arrFornec,     strFornec, 'CODFOR', qryGenIte);
      End;

      If blnAltFornecedor Then
        ParamByName('CODTAB').AsString := edtTabPre.Text;

      pSetaParam(edtCodAbr.Text   , arrCodAbr,     strCodAbr, 'CODABF', qryGenIte);
      pSetaParam(edtClaIPI.Text   , arrClaIPI,     strClaIPI, 'CLAIPI', qryGenIte);

      If Not fEmptyStr(edtExcIPI.Text) Then
      Begin
        ParamByName('EXCIPI').AsString := edtExcIPI.Text;
      End;

      objGerenciaExpr.pParametrizaQuery(qryGenIte);

      If chkNotEnt.Checked Then
      Begin
        If (Not fEmptyStr(edtDocumento.Text)) Then
          ParamByName('NUMDOC').AsString := edtDocumento.Text
        Else
        Begin
          ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
          ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
        End;
        If Not fEmptyStr(edtSerie.Text) Then
          ParamByName('SERDOC').AsString := edtSerie.Text;
        If Not fEmptyStr(edtCodEmpresa.Text) Then
          ParamByName('EMPDOC').AsString := edtCodEmpresa.Text;
        If Not fEmptyStr(edtEspecie.Text) Then
          ParamByName('ESPDOC').AsString := edtEspecie.Text;
        If Not fEmptyStr(edtForNot.Text) Then
          ParamByName('FORNOT').AsString := edtForNot.Text;
      End;

      ParamByName('CODEMP').AsString := VS_strCodEmp;

      If Not fEmptyStr(edtCest.Text) Then
        ParamByName('CDCEST').AsString := edtCest.Text;


      If (Pos(edtStatus.Text, 'SN') > 0) Then
        ParamByName('ITEATI').AsString := edtStatus.Text;

      If (Pos(edtStatusCompra.Text, 'SN') > 0) Then
        ParamByName('ATICOM').AsString := edtStatusCompra.Text;

      If Not fEmptyStr(edtLocFis.Text) Then
      Begin
        If Not blnCadLoc Then
          ParamByName('LOCFIS').AsString := edtLocFis.Text + '%';
      End;

      Open;



      TFloatField(FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';

      pSetaClient(qryGenIte);

      {*****************************************}
      {* CASO NÃO HAJA ITENS COM O FILTRO      *}
      {**************************************MV*}
      If IsEmpty Then
      Begin
        Result := False;
        fMensagem('', 'Não há itens para serem alterados!', ['&O k']);
        Exit;
      End;

    //  pgbProgresso.Visible := True;
    //  pgbProgresso.Max     := (RecordCount * Length(arrCamposTabela));

      fltCnvCusFor := 0;
      First;


      pgbProgresso2.Position       := 0;
      pgbProgresso2.Properties.Max := RecordCount;
      Application.ProcessMessages;

      While Not Eof Do
      Begin

        If (blnAltFornecedor) Then
          fltCnvCusFor := FieldByName('FOR_ITE_CNVCUS').AsFloat;

        SetLength(arrRegistroAtual, 0);

        For intContador := 0 To FieldCount -1 Do
        Begin

          intTamMat := Length(arrRegistroAtual);
          SetLength(arrRegistroAtual, intTamMat+1);
          arrRegistroAtual[intTamMat].strNomCam := Fields[intContador].FieldName;
          arrRegistroAtual[intTamMat].varValCam := Fields[intContador].Value;

          If (Fields[intContador].DataType in [ftString, ftMemo]) Then
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'VARCHAR';
          End
          Else If (Fields[intContador].DataType in [ftDate, ftDateTime]) Then
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'DATE';
          End
          Else
          Begin
            arrRegistroAtual[intTamMat].strTipCam := 'NUMERIC';
          End;

          If arrRegistroAtual[intTamMat].varValCam = Null Then
          Begin
            If (Fields[intContador].DataType in [ftString, ftMemo]) Then
            Begin
              arrRegistroAtual[intTamMat].varValCam := ''
            End
            Else If (Fields[intContador].DataType in [ftDate, ftDateTime]) Then
            Begin
              arrRegistroAtual[intTamMat].varValCam := 0;
            End
            Else
            Begin
              arrRegistroAtual[intTamMat].varValCam := 0.0;
            End;
          End;

        End;

        intTamMat := Length(arrCamposTabela);

        intContador := 0;

        While intContador < intTamMat Do
        Begin

          blnAltPrecus := False;

          For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
          Begin
            arrRecTabelasPreco[intTblPrc].blnAltPreven := False;
            arrRecTabelasPreco[intTblPrc].blnAltMarBru := False;
            arrRecTabelasPreco[intTblPrc].blnAltComTbl := False;
            arrRecTabelasPreco[intTblPrc].fltPreVenNov := 0.000;
            arrRecTabelasPreco[intTblPrc].fltMarBruNov := 0.000;
            arrRecTabelasPreco[intTblPrc].fltComTblNov := 0.000;
          End;

          strCamAtu := arrCamposTabela[intContador].strNomCam;

          If blnAltFornecedor Then
          Begin

            If FieldByName('FOR_' + strCamAtu).IsNull Then
            Begin
              If FieldByName('FOR_' + strCamAtu).DataType = ftString Then
                varValAtu := ''
              Else
                varValAtu := 0;
            End
            Else
              varValAtu := FieldByName('FOR_' + strCamAtu).Value // OBTEM O NOVO VALOR DA TABELA ITEFOR
          End

          Else If blnAltPorNota And (strCamAtu = 'ITE_PRECOM') Then
            varValAtu := fCalculaFatorNota

          Else varValAtu := arrCamposTabela[intContador].varValCam;

          pAdicionaCampoGrid(strCamAtu);

          varValorRegAtual := fCampoPorNome(arrRegistroAtual, strCamAtu + '_NOV').varValCam;
          {*****************************************}
          {* RECALCULA PREÇO DE COMPRA             *}
          {**************************************MV*}
          If strCamAtu = 'ITE_PRECOM' Then
          Begin

            If blnAltPorFator Then
            Begin
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECOM_NOV',
                fCalcularValor(varValorRegAtual, varValAtu));
            End
            Else
            Begin
              If (blnAltFornecedor) Then
                pAplicaConversorFornecedor(varValAtu, fltCnvCusFor);

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECOM_NOV', varValAtu);
            End;

            blnAltPrecus := True;

            If (rdgTipAlt.ItemIndex In [0,2]) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
            End
            Else If (rdgTipAlt.ItemIndex = 1) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;
            End;

          End

          {*****************************************}
          {* RECALCULA O PREÇO DE VENDA 1          *}
          {**************************************MV*}
          Else If (Pos('ITE_PREVE', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin

            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If blnAltPorFator Then
              fltNovPreVen := fCalcularValor(varValorRegAtual, varValAtu)
            Else
              fltNovPreVen := varValAtu;

            fltNovPreVen := fArredonda(fltNovPreVen, intTblPrc, arrRecTabelasPreco[intTblPrc].fltMarBruNov);

            pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fltNovPreVen);

            If fCampoPorNome(arrRegistroAtual, 'ITE_PREVE'+ IntToStr(intTblPrc)).varValCam > 0 Then
              fltVarPre := ABS(((fltNovPreVen / fCampoPorNome(arrRegistroAtual, 'ITE_PREVE'+ IntToStr(intTblPrc)).varValCam) -1) * 100.00);

            If fltVarPre > 0 Then
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_VENVAR'+IntToStr(intTblPrc), fltVarPre);

            arrRecTabelasPreco[intTblPrc].fltMarBruNov := fPrecoVenda(2, intTblPrc);
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltMarBruNov);
            pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intTblPrc));

            pAtualizaPrecosFator(fltNovPreVen, intTblPrc);

            pAtualizaMargemLiquida(intTblPrc);
          End

          {*****************************************}
          {* RECALCULA VALOR FRETE                 *}
          {*****************************************}
          Else If (Pos('ITE_VALFRE', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin
            If blnAltPorFator Then
            Begin
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fCalcularValor(varValorRegAtual, varValAtu))
            End
            Else
            Begin
              If (blnAltFornecedor) Then
                pAplicaConversorFornecedor(varValAtu, fltCnvCusFor);
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);
            End;
            blnAltPrecus := True;
            If (rdgTipAlt.ItemIndex In [0,2]) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
            End
            Else If (rdgTipAlt.ItemIndex = 1) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;
            End;
          End

          {*****************************************}
          {* ALTERA CAMPOS QUE INFLUENCIAM DIRETA- *}
          {* MENTE NO PRECO DE CUSTO               *}
          {**************************************MV*}
          Else If (Pos('ITE_DESF', strCamAtu) > 0) Or
                  (strCamAtu = 'ITE_ICMENT')       Or
                  (strCamAtu = 'ITE_SUBFED')       Or
                  (strCamAtu = 'ITE_IPIENT')       Or
                  (strCamAtu = 'ITE_FREENT')       Or
                  (strCamAtu = 'ITE_VALFRE')       Or
                  (strCamAtu = 'ITE_ACRFIN')       Or
                  (strCamAtu = 'ITE_SUBSTI')       Or
                  (strCamAtu = 'ITE_DESADB')       Or
                  (strCamAtu = 'ITE_TCIFCU')       Or
                  (strCamAtu = 'ITE_TSCUST')       Or
                  (strCamAtu = 'ITE_DEPICO')       Or
                  (strCamAtu = 'ITE_DEICMS')       Or
                  (strCamAtu = 'ITE_FATREG')       Then
          Begin

            If (blnAltFornecedor) And (strCamAtu = 'ITE_VALFRE') Then
              pAplicaConversorFornecedor(varValAtu, fltCnvCusFor);

            If blnAltPorFator And (strCamAtu <> 'ITE_VALFRE') Then
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fCalcularValor(varValorRegAtual, varValAtu))
            Else
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);

            blnAltPrecus := True;
            If (rdgTipAlt.ItemIndex In [0,2]) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
            End
            Else
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;
            End;

          End

          {*****************************************}
          {* ALTERA O ICMS DE SAIDA                *}
          {**************************************MV*}
          Else If (strCamAtu = 'ITE_ICMSAI') Or
                  (strCamAtu = 'ITE_IMPFED') Or
                  (strCamAtu = 'ITE_DESOPE') Or
                  (strCamAtu = 'ITE_OUTVAL') Then
          Begin

            If (blnAltFornecedor) And (strCamAtu = 'ITE_OUTVAL') Then
                pAplicaConversorFornecedor(varValAtu, fltCnvCusFor);
            If blnAltPorFator And   (strCamAtu = 'ITE_DESOPE') Then
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fCalcularValor(varValorRegAtual, varValAtu))
            Else
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);

            If (rdgTipAlt.ItemIndex In [0,2]) Then
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
            End
            Else
            Begin
              For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
                arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;
            End;
          End

          Else If (Pos('ITE_COMTB', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin
            If blnAltPorFator Then
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', fCalcularValor(varValorRegAtual, varValAtu))
            Else
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu);

            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If (rdgTipAlt.ItemIndex = 0)      Then
              arrRecTabelasPreco[intTblPrc].blnAltPreven := True;
            If (rdgTipAlt.ItemIndex In [1,2]) Then
              arrRecTabelasPreco[intTblPrc].blnAltMarBru := True;

          End

          {*****************************************}
          {* ALTERA A MARGEM BRUTA 1               *}
          {**************************************MV*}
          Else If (Pos('ITE_MARBR', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin

            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If blnAltPorFator Then
            Begin
              If (fCfgSis('MARMKP') =  '2') Then
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF(( fMarkupToMargem(fCalcularValor(varValorRegAtual, varValAtu)) > 99.99), 99.99, fCalcularValor(varValorRegAtual, varValAtu)))
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF(( fCalcularValor(varValorRegAtual, varValAtu) > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, fCalcularValor(varValorRegAtual, varValAtu)))
            End
            Else
            begin
              If (fCfgSis('MARMKP') = '2') Then
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF(fMarkupToMargem(varValAtu) > 99.99 , 99.99, varValAtu))
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', IIF((varValAtu > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, varValAtu));
            End;

            pAtualizaMargemLiquida(intTblPrc);

            arrRecTabelasPreco[intTblPrc].blnAltPreven := True;

          End

          Else If (Pos('ITE_MARID', strCamAtu) > 0) And (Length(strCamAtu) = 10) Then // ver (not blnAltPreve1)
          Begin

            intTblPrc := StrToInt(RightStr(strCamAtu, 1));

            If blnAltPorFator Then
            begin
              If (fCfgSis('MARMKP') = '2') Then
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARID' + IntToStr(intTblPrc) + '_NOV', IIF(( fMarkupToMargem(fCalcularValor(varValorRegAtual, varValAtu)) > 99.99), 99.99, (fCalcularValor(varValorRegAtual, varValAtu))))
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARID' + IntToStr(intTblPrc) + '_NOV', IIF(( fCalcularValor(varValorRegAtual, varValAtu) > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, fCalcularValor(varValorRegAtual, varValAtu)));
            End
            Else
            begin
              If (fCfgSis('MARMKP') = '2') Then
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARID' + IntToStr(intTblPrc) + '_NOV', IIF(fMarkupToMargem(varValAtu)> 99.99, 99.99, varValAtu))
              Else
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARID' + IntToStr(intTblPrc) + '_NOV', IIF((varValAtu > 99.99) And (Pos(fCfgSis('MARMKP'), '1_5_') > 0), 99.99, varValAtu));
            End;

            arrRecTabelasPreco[intTblPrc].blnAltPreven := True;

          End

          Else If strCamAtu = 'ITE_FATCMP' Then
          Begin
            If fMostrarFatorConversaoMadeira(FieldByName('ITE_CODITE').AsString) And (fCfgSis('M3PPCA') = 'S') Then
               pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu, FieldByName('ITE_CODITE').AsString);
          End

          Else If strCamAtu = 'ITE_FATPM3' Then
          Begin
            If fMostrarFatorConversaoMadeira(FieldByName('ITE_CODITE').AsString) And (fCfgSis('PCAPM3') = 'S') Then
               pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu, FieldByName('ITE_CODITE').AsString);
          End


          Else If strCamAtu = 'ITE_COMVAR' Then
          Begin

            If blnAltPorFator Then
            Begin
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMVAR_NOV', fCalcularValor(varValorRegAtual, varValAtu));
            End
            Else
            Begin
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMVAR_NOV', varValAtu);
            End;

          End

          Else If strCamAtu = 'ITE_COMATA' Then
          Begin

            If blnAltPorFator Then
            Begin
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMATA_NOV', fCalcularValor(varValorRegAtual, varValAtu));
            End
            Else
            Begin

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMATA_NOV', varValAtu);
            End;

          End

          Else If strCamAtu = 'ITE_COMDIS' Then
          Begin

            If blnAltPorFator Then
            Begin

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMDIS_NOV', fCalcularValor(varValorRegAtual, varValAtu));
            End
            Else
            Begin

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMDIS_NOV', varValAtu);
            End;

          End

          Else If strCamAtu = 'ITE_COMDIG' Then
          Begin

            If blnAltPorFator Then
            Begin

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMDIG_NOV', fCalcularValor(varValorRegAtual, varValAtu));
            End
            Else
            Begin

              pAtualizaValorCampo(arrRegistroAtual, 'ITE_COMDIG_NOV', varValAtu);
            End;

          End

          {*****************************************}
          {* ALTERA O RESTANTE DOS CAMPOS          *}
          {**************************************MV*}
          Else
          Begin

            If blnAltPorFator And fCampoTipoNumero(arrRegistroAtual, strCamAtu) Then
            Begin
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV',
                fCalcularValor(varValorRegAtual, varValAtu), FieldByName('ITE_CODITE').AsString);
            End
            Else
              pAtualizaValorCampo(arrRegistroAtual, strCamAtu + '_NOV', varValAtu, FieldByName('ITE_CODITE').AsString);

          End;

          {*****************************************}
          {* ALTERA O PREÇO DE CUSTO SE NECESSÁRIO *}
          {**************************************MV*}
          If blnAltPrecus Then
          Begin

            pAdicionaCampoGrid('ITE_PRECUS');

            {**********************************}
            {* CALCULA PREÇOS DE CUSTO        *}
            {*******************************JB*}
            With cpcParams Do
            Begin
              curPreCom := fCampoPorNome(arrRegistroAtual, 'ITE_PRECOM_NOV').varValCam;
              curDesF01 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF01_NOV').varValCam;
              curDesF02 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF02_NOV').varValCam;
              curDesF03 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF03_NOV').varValCam;
              curDesF04 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF04_NOV').varValCam;
              curDesF05 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF05_NOV').varValCam;
              curDesF06 := fCampoPorNome(arrRegistroAtual, 'ITE_DESF06_NOV').varValCam;
              curICMSEnt:= fCampoPorNome(arrRegistroAtual, 'ITE_ICMENT_NOV').varValCam;
              curIPIEnt := fCampoPorNome(arrRegistroAtual, 'ITE_IPIENT_NOV').varValCam;
              curFrete  := fCampoPorNome(arrRegistroAtual, 'ITE_FREENT_NOV').varValCam;
              curAcrFin := fCampoPorNome(arrRegistroAtual, 'ITE_ACRFIN_NOV').varValCam;
              curSubsti := fCampoPorNome(arrRegistroAtual, 'ITE_SUBSTI_NOV').varValCam;
              curValFre := fCampoPorNome(arrRegistroAtual, 'ITE_VALFRE_NOV').varValCam;
              curDesAdb := fCampoPorNome(arrRegistroAtual, 'ITE_DESADB_NOV').varValCam;
              curSubFed := fCampoPorNome(arrRegistroAtual, 'ITE_SUBFED_NOV').varValCam;

              if blnSufram and (strFrmCus = '4') then
              begin
                curTCIFCu := fCampoPorNome(arrRegistroAtual, 'ITE_TCIFCU_NOV').varValCam;
                curTSCust := fCampoPorNome(arrRegistroAtual, 'ITE_TSCUST_NOV').varValCam;
                curDePiCo := fCampoPorNome(arrRegistroAtual, 'ITE_DEPICO_NOV').varValCam;
                curDeICMS := fCampoPorNome(arrRegistroAtual, 'ITE_DEICMS_NOV').varValCam;
                curFatReg := fCampoPorNome(arrRegistroAtual, 'ITE_FATREG_NOV').varValCam;
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

            blnUtilizarConversorDeMoedas := (fCampoPorNome(arrRegistroAtual, IIF(blnAltFornecedor, 'FOR_', '') + 'ITE_PREDOL').varValCam = 'S');

            fltPreCusNov := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoedas);
            pAtualizaValorCampo(arrRegistroAtual, 'ITE_PRECUS_NOV', fltPreCusNov);

            If fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS').varValCam > 0 Then
              fltVarCus := ABS(((fltPreCusNov / fCampoPorNome(arrRegistroAtual, 'ITE_PRECUS').varValCam) -1) * 100.00);

            If fltVarCus > 0 Then
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_CUSVAR', fltVarCus);

          End;

          {************************************************}
          {* ALTERA O PREÇO DE VENDA, MARGEM SE NECESSÁRIO*}
          {*********************************************MV*}
          For intTblPrc := 1 To Length(arrRecTabelasPreco) Do
          Begin
            If arrRecTabelasPreco[intTblPrc].blnAltPreven Then
            Begin
              pAdicionaCampoGrid('ITE_PREVE' + IntToStr(intTblPrc));
              If ((Not Assigned(objFatPre)) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTblPrc)))) Or (intTblPrc = 1) Then
              Begin
                arrRecTabelasPreco[intTblPrc].fltPreVenNov := fPrecoVenda(1, intTblPrc);

                If Assigned(objFatPre) Then
                  pAtualizaPrecosFator(arrRecTabelasPreco[intTblPrc].fltPreVenNov, intTblPrc);

              End Else
              Begin
                arrRecTabelasPreco[intTblPrc].fltPreVenNov :=
                  objFatPre.fCalculaPrecoVendaFator(arrRecTabelasPreco[1].fltPreVenNov, intTblPrc);

                pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intTblPrc));
                arrRecTabelasPreco[intTblPrc].fltMarBruNov := fPrecoVenda(2, intTblPrc);
                pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltMarBruNov);
              End;

              arrRecTabelasPreco[intTblPrc].fltPreVenNov := fArredonda(arrRecTabelasPreco[intTblPrc].fltPreVenNov, intTblPrc,
                                                                       arrRecTabelasPreco[intTblPrc].fltMarBruNov);
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_PREVE' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltPreVenNov);

            End;

            If arrRecTabelasPreco[intTblPrc].blnAltMarBru Then
            Begin
              pAdicionaCampoGrid('ITE_MARBR' + IntToStr(intTblPrc));
              arrRecTabelasPreco[intTblPrc].fltMarBruNov := fPrecoVenda(2, intTblPrc);
              pAtualizaValorCampo(arrRegistroAtual, 'ITE_MARBR' + IntToStr(intTblPrc) + '_NOV', arrRecTabelasPreco[intTblPrc].fltMarBruNov);
            End;

            pAtualizaMargemLiquida(intTblPrc);
          End;

        //  pgbProgresso.StepBy(1);
          Inc(intContador);
          Application.ProcessMessages;

        End;

        pAlteraValorTabelaItens(FieldByName('ITE_CODITE').AsString,
                                arrRegistroAtual,
                                FieldByName('ITE_CNV_ML').AsFloat,
                                FieldByName('ITE_SAL_ML').AsFloat,
                                FieldByName('SaldoNumerico').AsFloat);

        Next;

        pgbProgresso2.Position := pgbProgresso2.Position + 1;
        Application.ProcessMessages;
      End;
      Close;

    End;

   // pgbProgresso.Position := 0;
   // pgbProgresso.Visible  := False;
    If chkExiSal.Checked Then
      pAtualizaSaldoDisponivel;


  Finally
    FreeAndNil(cpcParams);
  End;
end;

procedure TfrmAltPrecoGlobal.pAtualizaSaldoDisponivel;
  Var
    frmAguarde: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fAtualizaSaldoDisponivel;
    frmAguarde.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmAguarde);
end;

function TfrmAltPrecoGlobal.fProdutoComSaldo(strCodIte: String): Boolean;
  Var
    qryTmpIteger: TUniQuery;
    strSQL      : String;
begin
  qryTmpIteger := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + ' ITE_CODEMP, ITE_SALDOS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  (IFNULL(ITE_SALDOS,0) + IFNULL(ITE_SAL_ML,0)) <> 0 ';
  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  ITE_CODEMP ';

  With qryTmpIteger Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := Not IsEmpty;

    Close;
    FreeAndNil(qryTmpIteger);

  End;

end;

procedure TfrmAltPrecoGlobal.pAtualizaValorCampo(Var arrCampos: Array Of TCampoGlobal;
  strNomeCampo: String; varValor: Variant; strCodIte: String = '');
  Var
    intContador: Integer;
    intTamMat: Integer;
begin
  intContador := 0;

  intTamMat := Length(arrCampos);

  While intContador < intTamMat Do
  Begin
    If arrCampos[intContador].strNomCam = strNomeCampo Then
    Begin
      If SameText(strNomeCampo, 'ITE_ITEATI_NOV') And (Not fEmptyStr(strCodIte)) And
         fProdutoComSaldo(strCodIte) Then
      Begin
        varValor := 'S';
        blnAvisoAtivo := True;
      End;

      arrCampos[intContador].varValCam := varValor;
      Break;
    End;
    Inc(intContador);
  End;
end;

function TfrmAltPrecoGlobal.fGeraVetorCampos: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    With frmGravando Do
    Begin
      blnTempoRestante := True;
      fExecutarAcao := fGeraVetorCamposAux;
      lblGravando.Caption := 'Aguarde, carregando dados...';
      ShowModal;
      Result := blnConfirma;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmAltPrecoIndividual.fGeraVetorCamposAux]');
      Result := False;
    End;
  End;

  FreeAndNil(frmGravando);
End;

function TfrmAltPrecoGlobal.fGeraVetorCamposAux(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intTamMat: Integer;
begin
  SetLength(arrCamposTabela, 0);
  SetLength(arrCamposGrid,   0);

  With cdsAltGlo Do
  Begin
    DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    First;

    While Not Eof Do
    Begin

      If blnAltPorNota And (FieldByName('ITE_NOMCAM').AsString = 'ITE_PRECOM') Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;

      If blnAltFornecedor And
         (Pos(FieldByName('ITE_NOMCAM').AsString,
              'ITE_PRECOM_ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_' +
              'ITE_DESF05_ITE_DESF06_ITE_ICMENT_ITE_SUBFED_ITE_IPIENT_' +
              'ITE_FREENT_ITE_VALFRE_ITE_ACRFIN_ITE_SUBSTI_ITE_DESADB_' +
              'ITE_OUTVAL_ITE_ICMSAI_ITE_IMPFED_ITE_DESOPE_ITE_PREDOL_' +
              'ITE_UNICOM_ITE_MLTCOM_ITE_CODABF_' +
              'ITE_TCIFCU_ITE_TSCUST_ITE_DEPICO_ITE_DEICMS_ITE_FATREG_' +
              'ITE_DIAFOR_ITE_CLAIPI_ITE_CODFAB_ITE_DESFAB_ITE_CODFOR') > 0) Then
      Begin
        Edit;
        FieldByName('ITE_ALTERA').AsString :=  'S';
        Post;
      End;

      If (cdsAltGlo.FieldByName('ITE_ALTERA').AsString <> 'S') Then
      Begin
        Next;
        Continue;
      End;

      pAtualizaValorCampo(arrCamposGlobal, FieldByName('ITE_NOMCAM').AsString, FieldByName('ITE_VALCAM').Value);

      intTamMat := Length(arrCamposTabela);
      SetLength(arrCamposTabela, intTamMat+1);

      arrCamposTabela[intTamMat].strDesCam := FieldByName('ITE_DESCAM').AsString;
      arrCamposTabela[intTamMat].strProper := FieldByName('ITE_PROPER').AsString;
      arrCamposTabela[intTamMat].varValCam := FieldByName('ITE_VALCAM').Value;
      arrCamposTabela[intTamMat].strMasCam := FieldByName('ITE_MASCAM').AsString;
      arrCamposTabela[intTamMat].strNomCam := FieldByName('ITE_NOMCAM').AsString;
      arrCamposTabela[intTamMat].strDesAbr := FieldByName('ITE_DESABR').AsString;
      arrCamposTabela[intTamMat].intLimCam := FieldByName('ITE_LIMCAM').AsInteger;
      arrCamposTabela[intTamMat].strTipCam := FieldByName('ITE_TIPCAM').AsString;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    EnableControls;
  End;

  Result := (Length(arrCamposTabela) > 0);
end;

function TfrmAltPrecoGlobal.fHaAlteracoesSalvas: Boolean;
var
  qryAux: TUniQuery;
begin
  Try
    qryAux := fCriarQuery('SELECT * FROM ALTGLO WHERE ALT_CODOPE = :CODOPE AND ALT_CODEMP = :CODEMP LIMIT 1');
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    Result := Not qryAux.isEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmAltPrecoGlobal.pAlteraValorTabelaItens(strCodIte: String;
  Var arrCampos: Array Of TCampoGlobal; fltCnvMl, fltSalMl, fltSaldoNumerico: Double);
  Var
    intContador: Integer;
    intTamMat  : Integer;
begin
  intTamMat := Length(arrCampos);
  intContador := 0;

  With cdsIteGlo Do
  Begin
    Append;
    FieldByName('ITE_MARDES').AsString := 'M';
    FieldByName('ITE_CNV_ML').AsFloat    := fltCnvMl;
    FieldByName('ITE_SAL_ML').AsFloat    := fltSalMl;
    FieldByName('SaldoNumerico').AsFloat := fltSaldoNumerico;


    While intContador < intTamMat Do
    Begin

      if (arrCampos[intContador].strNomCam = 'ITE_DESSIT_NOV') and (FieldByName('ITE_EXPSIT').AsString = 'N') then
      begin
        FieldByName(arrCampos[intContador].strNomCam).AsFloat := FieldByName('ITE_DESSIT').AsFloat
      end
      else
      begin

        If Pos('CHAR', arrCampos[intContador].strTipCam) > 0 Then
          FieldByName(arrCampos[intContador].strNomCam).AsString := arrCampos[intContador].varValCam

        Else If FieldByName(arrCampos[intContador].strNomCam).DataType = ftFloat Then
          FieldByName(arrCampos[intContador].strNomCam).AsFloat := fStrToFloat(arrCampos[intContador].varValCam)

        Else If FieldByName(arrCampos[intContador].strNomCam).DataType In [ftInteger, ftSmallint, ftWord] Then
          FieldByName(arrCampos[intContador].strNomCam).AsInteger := Trunc(fStrToFloat(arrCampos[intContador].varValCam))
        Else If FieldByName(arrCampos[intContador].strNomCam).DataType In [ftDate, ftDateTime] Then
        Begin
          Try
            FieldByName(arrCampos[intContador].strNomCam).AsDateTime := StrToDate(arrCampos[intContador].varValCam);
          Except
            FieldByName(arrCampos[intContador].strNomCam).AsString   := '';
          End;
        End;
      end;

      Inc(intContador);
    End;

    Post;
  End;
end;

procedure TfrmAltPrecoGlobal.pAplicaConversorFornecedor(Var fltValor: Variant; fltCnvCus: Double);
begin
  If fltCnvCus <= 0 Then
    fltCnvCus := 1;
  fltValor := (fltValor / fltCnvCus);
end;

procedure TfrmAltPrecoGlobal.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, nil, arrCodUni ,fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmAltPrecoGlobal.edtCodUniKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrCodUni, False) Then
  Begin
    if fValidaCampos(edtCodUni, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrMarca, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmAltPrecoGlobal.edtCodMarKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca, False) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtCodMonExit(Sender: TObject);
Begin
  inherited;
  pEdtCodSelectExit(edtCodMon, edtDesMon, arrCodMon, fRetNomMontadora, nil, 'da Montadora');
End;

procedure TfrmAltPrecoGlobal.edtCodMonKeyPress(Sender: TObject; var Key: Char);
  Begin
  If fPesqMontadora(Self, edtCodMon, edtDesMon, Nil, Key, arrCodMon, False) Then
  Begin
    If fValidaCampos(edtCodMon, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmAltPrecoGlobal.pedtCodForKeyPre(edtCodFor: TEditFocus; var Key: Char; blnNomFor: Boolean);
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, qryConFor, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmAltPrecoGlobal.edtCodForKeyPress(Sender: TObject;  var Key: Char);
begin
  inherited;
  If Not edtCodFor.ReadOnly Then
    pedtCodForKeyPre(edtCodFor,key,TRUE);
end;

procedure TfrmAltPrecoGlobal.edtCodGprExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodGpr, edtDesGpr,    arrCodGpr, fRetNomeGrupoPrecos, Nil, 'do Grupo de Preço');
end;

procedure TfrmAltPrecoGlobal.edtCodGprKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoPrecos(Self, edtCodGpr, edtDesGpr, Nil, Key, arrCodGpr, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

(*
procedure TfrmAltPrecoGlobal.pCodGprKeyPress;
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoPrecos(Self, edtCamAlt, Nil, Nil, chrKey, arrGrupo) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pCodPrdGruKeyPress;
  Var
    chrKey: Char;
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  chrKey := '/';
  If fPesqGrupoProduto(Self, edtCamAlt, Nil, Nil, chrKey, arrGrupo) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmAltPrecoGlobal.pCodGrupoCompraKeyPress;
  Var
    chrKey: Char;
    arrGru: TConsultasArray;
begin
  chrKey := '/';
  If fPesqGrupoCompra(Self, edtCamAlt, Nil, Nil, chrKey, arrGru) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmAltPrecoGlobal.pCodDepKeyPress;
  Var
    chrKey: Char;
    arrDep: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDepartamento(Self, edtCamAlt, Nil, Nil, chrKey, arrDep) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pCodAbfKeyPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;

begin
  inherited;

  chrKey := '/';

  If fPesqAbrevFiscal(Self, edtCamAlt, nil, qryConAbf, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodAbfPisPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqPISSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodAbfCofPressf;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqCOFSAI(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodAbfIPIPress;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
begin
  inherited;

  chrKey := '/';

  If fPesqIPISAI(Self, edtCamAlt, Nil, chrKey, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmAltPrecoGlobal.pCodMarcaKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqMarcas(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodSituacaoKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqSituacaoProduto(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodMontadoraKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;
begin
  inherited;
  chrKey := '/';

  If fPesqMontadora(Self, edtCamAlt, nil, nil, chrKey, arrSel)  Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodOnuKeyPress;
  Var
    chrKey: Char;
    arrOnu: TConsultasArray;
begin
  chrKey := '/';
  If fPesqClassificacaoOnu(Self, edtCamAlt, Nil, Nil, chrKey, arrOnu) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pCodDicKeyPress;
  Var
    chrKey: Char;
    arrDic: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDic(Self, edtCamAlt, Nil, Nil, chrKey, arrDic) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pCodUnidadeKeyPress;
 var
   chrKey: Char;
   arrSel: TConsultasArray;

begin
  inherited;
  chrKey := '/';

  If fPesqUnidade(Self, edtCamAlt, nil, nil, nil, chrKey, arrSel) Then
  Begin
    if fvalidaCampos(edtCamAlt,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodGrupoKeyPress(var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqGrupo(Self, edtCamAlt, nil, nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAltPrecoGlobal.pCodLseKeyPress;
  Var
    chrKey: Char;
    arrLse: TConsultasArray;
begin
  chrKey := '/';
  If fPesqLocSep(Self, edtCamAlt, Nil, Nil, chrKey, arrLse) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
*)

procedure TfrmAltPrecoGlobal.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrGrupoPro, fRetNomeGrupoProduto, nil, 'do Grupo de Produtos', edtPrdGru.MaxLength);
end;

procedure TfrmAltPrecoGlobal.edtPrdGruKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrGrupoPro, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtRefereKeyPress(Sender: TObject; var Key: Char);
  Var
    qryTabela : TUniQuery;
    arrProduto: TConsultasArray;
begin
  inherited;

  qryTabela := fCriaQuery(Self);

  If fPesqItem(conIteSimples, Self, Nil, Nil, qryTabela, Key, arrProduto, True, nil, 'Consulta de Itens', '1') Then
  Begin
    edtRefere.Text := qryTabela.FieldByName('ITE_REFERE').AsString;
    self.SelectNext(ActiveControl, True, True);
  End;

  FreeAndNil(qryTabela)
end;

procedure TfrmAltPrecoGlobal.FormShow(Sender: TObject);
var
  intCont : Integer;
begin
  inherited;

  blnPreMat := fCampoTabela('EMP_PREMAT','CADEMP',['EMP_CODEMP'],[VS_strCodEmp]) = 'S';

  If VS_strCodEmp = fCfgSis('EMPMAT') Then
    blnPreMat := False;

  pAtribuiTabelas;

  pMontaGrid;

  qryGenIte := fCriaQuery(Self);

  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

  pAjustaOpcaoFornecedor;
  pAjustaAlteracaoPorNota;

  pVerificaDireitoAcesso;

  pSetFocus(mskLinGru);

  if (blnMarIde) and
     (not blnAltFornecedor) and
     (not blnAltPorNota) then
  begin
    for intCont := 1 to Length(VS_strTabPrc) do
    begin
      if VS_strTabPrc[intCont] = 'S' then
      begin
        cbxTabPrc.Items.Add(IntToStr(intCont));
      end;
    end;

    pHabilitaCamposMargemIdeal;
  end
  else
  begin
    lblMarIde.Visible  := False;
    cbxMarIde.Visible  := False;
    lblTabPrc.Visible  := False;
    cbxTabPrc.Visible  := False;

//    edtDesmar.Width    := 370;
//    edtDesPrdPro.Width := 370;
  end;

  chkPenRec.Visible := fCfgSis('CLPVDI', varBoolean);

  pCarregaSelecao;

  pHabilitaNotaEntrada(chkNotEnt.Checked);

  cxvTiposAlt.NavigatorButtons.First.Click;

  cbxAtoDF.Visible  := fRetUFEmpresa = 'DF';

  objGerenciaExpr := TGerenciaExprAltGlobal.Create(pnlExpressao,
                                                   edtDiasMovimentacao,
                                                   blnCarregandoCadInt,
                                                   TArrCampoGlobal(arrCamposGlobal),
                                                   blnAltPorFator,
                                                   Self,
                                                   btnVisualizarExpr,
                                                   btnAddExpr,
                                                   pSetaEventos);

  If (fHaAlteracoesSalvas) And (fMensagem('', 'Deseja carregar as últimas alterações?', ['&Sim', '&Não']) = 1) Then
	  TfrmGravando.fExecuta(fCarregarClientDataSetAux, frmGravando, 'Carregando alterações salvas...', False);

  objGerenciaExpr.pAdicionar;
  edtEstadoAbfICMS.Clear;
end;

procedure TfrmAltPrecoGlobal.pAjustaAlteracaoPorNota;
Begin
  pnlTipAltNota.Visible := blnAltPorNota;

  If blnAltPorNota  Then
  Begin
    pnlFiltro1.Visible        := False;
    pnlFiltro2.Visible        := False;
    pnlCadMon.Visible         := False;
    pnlMovmentacaoEstoque.Visible := False;
    pnlCabecalho.ClientHeight := pnlNotEnt.Height + 5;

    pnlDadosAlt.Visible       := False;

    Self.WindowState          := wsNormal;
    Self.ClientHeight         := pnlCabecalho.Height + pnlBotoesEnt.Height + pnlStatus.Height;

    chkNotEnt.Checked := True;
    chkNotEnt.Visible := False;
    pHabilitaNotaEntrada(True);

    pSetFocus(edtDocumento);

    blnAltPorFator := True;
  End;

End;

procedure TfrmAltPrecoGlobal.pAjustaOpcaoFornecedor;
Begin
  If blnAltFornecedor Then
  Begin
    cxgTiposAlt.Visible := False;
    pnlTabPre.Visible   := True;
    pnlCabecalho.Align  := alClient;
    Self.Caption        := 'ATIVAÇÃO DE CUSTOS DOS PRODUTOS';
    rdgTipAlt.Visible   := False;
    rdgTipAltFor.Top    := rdgTipAlt.Top;
    rdgTipAltFor.Visible:= True;
    Self.Height         := Self.Height - cxgTiposAlt.Height;

    edtCodFor.ReadOnly  := True;
    edtCodFor.TabStop   := False;
    edtCodFor.Color     := $00FFDFB8;
    pnlDadosAlt.Visible := False;
  End Else
  Begin
    pnlTabPre.Visible   := False;
    pnlCabecalho.Height := pnlCabecalho.Height - pnlTabPre.Height;
  End;
End;

procedure TfrmAltPrecoGlobal.edtDesIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

    If fPesqItem(conIteSimples, Self, nil, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
    Begin
      pSetFocus(edtRefere);
    End;

end;

procedure TfrmAltPrecoGlobal.edtExcIpiExit(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(edtExcIpi.Text) Then
    edtExcIpi.Text := fStrZero(edtExcIpi.Text, 3);
end;

procedure TfrmAltPrecoGlobal.edtForNotExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtForNot.Text) Then
    edtDesForNot.Clear
  Else
  Begin
    edtDesForNot.Text := fRetNomFornecedor(edtForNot.Text);

    If fEmptyStr(edtDesForNot.Text) Then
    Begin
      fMensagem('AVISO','Código do Fornecedor não encontrado.', ['&O K']);
      edtForNot.Clear;
      pSetFocus(edtForNot);
    End;
  End;

end;

procedure TfrmAltPrecoGlobal.edtForNotKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmAltPrecoGlobal.edtGruCmpKeyPress(Sender: TObject; var Key: Char);
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmAltPrecoGlobal.edtIncPisKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Not CharInSet(UpperCase(Key)[1],['S', 'N', 'T'])) Then
    Key := #0;

end;

procedure TfrmAltPrecoGlobal.edtLocFisKeyPress(Sender: TObject; var Key: Char);
Var arrSel : TConsultasArray;
begin
  inherited;
  If blnCadLoc And fPesqLocFisica(Self, edtLocFis, edtDesLocFis, Nil, Key, arrSel) And
     fValidaCampos(edtLocFis, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltPrecoGlobal.edtTabPreKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtCodAbrExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmAltPrecoGlobal.edtCodAbrKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, qryAbfIcm, Key, arrCodAbr, False) Then
    Begin
      If fValidaCampos(edtCodAbr, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
end;

procedure TfrmAltPrecoGlobal.edtCodComExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCom, edtDesComp, arrCodCom, fRetDescricaoComposicao, nil, 'da Composição');
end;

procedure TfrmAltPrecoGlobal.edtCodComKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqComposicao(Self,edtCodCom, edtDesComp, Nil, Key, arrCodCom) then
  begin
    if fValidaCampos(edtCodCom, True) then
    begin
      SelectNext(ActiveControl, True, True);
    end;
  end;
end;

procedure TfrmAltPrecoGlobal.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmAltPrecoGlobal.edtCodDepKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrCodDep, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtCodEmpresaExit(Sender: TObject);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmAltPrecoGlobal.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresa, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pMontaGrid;
  Var
    intPosMat: Integer;
    intTabPre: Integer;
    intContador: Integer;
    strTCOMTB : String;

    TipoOpcaoDeTrava : TTipoOpcaoDeTrava;
    GerenciaItegerPermiteEdicao : TGerenciaItegerPermiteEdicao;
  function fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
  Begin
    intVal := intVal + intSoma;
    Result := intVal + 1;
  End;

begin
  GerenciaItegerPermiteEdicao := TGerenciaItegerPermiteEdicao.Create;
  Try
    GerenciaItegerPermiteEdicao.pSetaEmpresa(VS_StrCodEmp, '');

    TipoOpcaoDeTrava := fCfgSis('TRADES', varInteger);

    blnAvisoAtivo := False;
    strMasVal := '#,##0.0000';
    strMasVal2 := '#,##0.000000';
    strMasFat := '#,##0.0000';
    strMasMar := '#,##0.000';
    strMasMBr := '#,##0.000';
    strMasPer := '#,##0.00';
    strMasInt := '#,##0';

    If fRetPrecisaoMargemItem > 2 Then
      strMasMBr := fMskDigitos(fRetPrecisaoMargemItem);

    strMasDecUni := fMskDigitos(fCfgSis('DECUNI', VarInteger));
    strMasDecQtd := fMskDigitos(fCfgSis('DECQTD', VarInteger));
    strMasDec06  := fMskDigitos(6);
    strMasDec05  := fMskDigitos(5);

    {******************************************}
    {* CARREGA MATRIZ COM OS CAMPOS QUE PODEM *}
    {* SER ALTERADOS                          *}
    {***************************************JB*}
    intPosMat := 0;
    SetLength(arrCamposGlobal, 1);

    arrCamposGlobal[intPosMat].strDesCam := 'Referência';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_REFERE';
    arrCamposGlobal[intPosMat].strDesAbr := 'Referência';
    arrCamposGlobal[intPosMat].intLimCam := fTamRefere;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR('+fTamRefere.ToString+')';
    arrCamposGlobal[intPosMat].strProper := 'cxeString'+fTamRefere.ToString;
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Acordo de Objetivos';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ACOOBJ';
    arrCamposGlobal[intPosMat].strDesAbr := 'Acordo Obj.';
    arrCamposGlobal[intPosMat].intLimCam := 20;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(20)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString20';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Código ANP';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODLUB';
    arrCamposGlobal[intPosMat].strDesAbr := 'Código ANP';
    arrCamposGlobal[intPosMat].intLimCam := 10;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(10)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString10';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Descrição ANP';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESANP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Descrição ANP';
    arrCamposGlobal[intPosMat].intLimCam := 80;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(80)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam80';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Destaque';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESTAQ';
    arrCamposGlobal[intPosMat].strDesAbr := 'Destaque';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    {*******************************************}
    {* DESCONTOS / OUTRAS COLUNAS              *}
    {****************************************MV*}
    arrCamposGlobal[intPosMat].strDesCam := 'Código do Fornecedor';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODFOR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Fornecedor';
    arrCamposGlobal[intPosMat].intLimCam := 8;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(08)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam8';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    {*******************************************}
    {* DESCONTOS / OUTRAS COLUNAS              *}
    {****************************************MV*}
    arrCamposGlobal[intPosMat].strDesCam := 'Código Grupo Preços';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODGPR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Grupo Preços';
    arrCamposGlobal[intPosMat].intLimCam := 6;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(06)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam6';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Código Grupo Produto';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRDGRU';
    arrCamposGlobal[intPosMat].strDesAbr := 'Grupo Produto';
    arrCamposGlobal[intPosMat].intLimCam := 5;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(05)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam5';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    If fExibe_ICMSAI_mesmo_nao_atualizaPreco Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Abreviação ICMS';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODABF';
      arrCamposGlobal[intPosMat].strDesAbr := 'Abrev. ICMS';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    end;

    If (Not blnPreMat) Or blnFilSai Then
    Begin
      If (Not blnTABPRD)  Then
      Begin
        intPosMatPreMatInicial := intPosMat;
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PRECOM') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := 'Preço de Compra';
      //    arrCamposGlobal[intPosMat].varValCam := 0.0;

          If blnAltPorFator Then
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasFat;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
          End
          Else
          Begin
            arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
            arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          End;

          arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECOM';
          arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Compra';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        {*******************************************}
      {* DESCONTOS / OUTRAS COLUNAS              *}
      {****************************************MV*}
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF01') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 01';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF01';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 01';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF02') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 02';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF02';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 02';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF03') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 03';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF03';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 03';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF04') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 04';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF04';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 04';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF05') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 05';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF05';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 05';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESF06') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Desc. de Fornecedor 06';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESF06';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Fornec. 06';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMENT') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% ICMS Entrada';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMENT';
          arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Entrada';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBFED') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais (-)';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBFED';
          arrCamposGlobal[intPosMat].strDesAbr := '% Imp. Federais (-)';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPIENT') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% IPI de Entrada';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPIENT';
          arrCamposGlobal[intPosMat].strDesAbr := '% IPI Entrada';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IPISAI') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% IPI de Saída';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_IPISAI';
          arrCamposGlobal[intPosMat].strDesAbr := '% IPI Saída';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_FREENT') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Frete de Entrada';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_FREENT';
          arrCamposGlobal[intPosMat].strDesAbr := '% Frete Entrada';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_VALFRE') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DESVFR');
          If blnAltPorFator Then
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasFat;
              arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
              arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
          End
          Else
          Begin
            arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
            arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          End;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_VALFRE';
          arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DESVFR');
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ACRFIN') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Acréscimo Financeiro';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_ACRFIN';
          arrCamposGlobal[intPosMat].strDesAbr := '% Acresc.Financ.';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_SUBSTI') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Substituição Tributária';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_SUBSTI';
          arrCamposGlobal[intPosMat].strDesAbr := '% Subst. Tributária';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESADB') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESADB';
          arrCamposGlobal[intPosMat].strDesAbr := '% ' + fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_IMPFED') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Impostos Federais';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPFED';
          arrCamposGlobal[intPosMat].strDesAbr := '% Impostos Fed.';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_DESOPE') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Despesas Operacionais';
          arrCamposGlobal[intPosMat].strDesAbr := '% Despesas Oper.';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESOPE';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_ICMSAI') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% ICMS de Saída';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_ICMSAI';
          arrCamposGlobal[intPosMat].strDesAbr := '% ICMS Saída';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

          {*************************************************************}
          {* OUTROS VALORES                                            *}
          {**********************************************************JC*}
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_OUTVAL') Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := fCfgSis('DOVCPP') + ' (+)';
          arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
          arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_OUTVAL';
          arrCamposGlobal[intPosMat].strDesAbr := fCfgSis('DOVCPP') + ' (+)';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If fCfgSis('IMPDIR') = 'S' Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := 'Importação Direta';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPDIR';
          arrCamposGlobal[intPosMat].strNomArq := IIf(fCfgSIs('IMPDIG') = '1', 'CADITE', 'ITEGER');
          arrCamposGlobal[intPosMat].strDesAbr := 'Importação Direta';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
          arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If fCfgSis('USA_PF') = 'S' Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := 'Utiliza Pauta Fiscal?';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_USAPPF';
          arrCamposGlobal[intPosMat].strNomArq := IIf(fCfgSIs('TIPABF') = '1', 'CADITE', 'ITEGER');
          arrCamposGlobal[intPosMat].strDesAbr := 'Utiliza Pauta Fiscal?';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
          arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If fCfgSis('CONIPI') = 'S' Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := 'Industrialização ou revenda';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomArq := IIf(fCfgSIs('INDREV') = '1', 'CADITE', 'ITEGER');
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_INDREV';
          arrCamposGlobal[intPosMat].strDesAbr := 'Industrialização ou revenda';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
          arrCamposGlobal[intPosMat].strProper := 'cmbIndRev';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If blnSuframa Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := 'Calcular ICMS Desonerado?';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_CICMDE';
          arrCamposGlobal[intPosMat].strDesAbr := 'Calcular ICMS Desonerado?';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
          arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := 'Considerar Desc. PIS/COFINS no ICMS Op. Próprias?';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_CDPIOP';
          arrCamposGlobal[intPosMat].strDesAbr := 'Considerar Desc. PIS/COFINS no ICMS Op. Próprias?';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
          arrCamposGlobal[intPosMat].strProper := 'cmbSimNaoFornecedor';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));


    {    SetLength(arrCamposGlobal, fSoma(intPosMat));
        arrCamposGlobal[intPosMat].strDesCam := 'Considerar desconto de ICMS Desonerado na base de cálculo do ICMS Operações Próprias?';
          arrCamposGlobal[intPosMat].varValCam := '';
          arrCamposGlobal[intPosMat].strMasCam := '';
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DIDIOP';
          arrCamposGlobal[intPosMat].strDesAbr := 'Considerar desconto de ICMS Desonerado na base de cálculo do ICMS Operações Próprias?';
          arrCamposGlobal[intPosMat].intLimCam := 1;
          arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNaoFornecedor';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';}

        End; {If blnSuframa Then}

        arrCamposGlobal[intPosMat].strDesCam := 'Incide PIS?';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_INCPIS';
        arrCamposGlobal[intPosMat].strDesAbr := 'Incide PIS?';
        arrCamposGlobal[intPosMat].intLimCam := 1;
        arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

      End; {If (Not blnTABPRD) And (not blnAltFornecedor)Then}

      If (fCfgSis('ETIDIF', varBoolean)) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Imprimir etiqueta de quantidade restante ?';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_ETIQRE';
        arrCamposGlobal[intPosMat].strDesAbr := 'Imp. etiq. de qtde restante ?';
        arrCamposGlobal[intPosMat].intLimCam := 1;
        arrCamposGlobal[intPosMat].strTipCam := 'CHAR(01)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      If fCfgSis('OPCROM') = '5' Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Entrega Especial?';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_ENTESP';
        arrCamposGlobal[intPosMat].strDesAbr := 'Entrega Especial?';
        arrCamposGlobal[intPosMat].intLimCam := 1;
        arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      If fCfgSis('SEPEXC', varBoolean) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Item de Separação Exclusiva?';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_SEPEXC';
        arrCamposGlobal[intPosMat].strDesAbr := 'Separação Exclusiva?';
        arrCamposGlobal[intPosMat].intLimCam := 1;
        arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      If fCfgSis('UTPEST', varBoolean) Then
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Qtde mín. estoque para ponta de estoque';
        arrCamposGlobal[intPosMat].strMasCam := strMasDecQtd;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_QTDPES';
        arrCamposGlobal[intPosMat].strDesAbr := 'Qtde mín. estoque para ponta de estoque';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasDecQtd);
        arrCamposGlobal[intPosMat].strProper := 'cxeDecQtd';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% de desconto aplicado para ponta de estoque';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_PORPES';
        arrCamposGlobal[intPosMat].strDesAbr := '% de desconto aplicado para ponta de estoque';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      {*******************************************}
      {* MARGEM BRUTA PARA TABELAS DE PRECO      *}
      {****************************************JB*}
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_MARBR' + IntToStr(intTabPre)) Then
        Begin

          arrCamposGlobal[intPosMat].strDesCam := '% Margem Bruta ' + IntToStr(intTabPre);

          If blnAltPorFator Then
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasMar;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
          End
          Else
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasMBr;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMBr);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasMBr';
          End;

          arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARBR' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].strDesAbr := '% Margem Bruta ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;

        If blnLiqNeg Then
        Begin
          arrCamposGlobal[intPosMat].strDesCam := '% Margem Líquida ' + IntToStr(intTabPre);

          If blnAltPorFator Then
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasMar;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
          End
          Else
          Begin
            arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
            arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          End;

          arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARLQ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].strDesAbr := '% Margem Liq. ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := '';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;
      End;

      If fCfgSis('MARIDE', VarBoolean) Then
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        arrCamposGlobal[intPosMat].strDesCam := '% Margem Ideal ' + IntToStr(intTabPre);

        If blnAltPorFator Then
        Begin
          arrCamposGlobal[intPosMat].strMasCam := strMasMar;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
        End
        Else
        Begin
          arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasMar);
          arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
        End;

        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARID' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Ideal ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      {*************************************************************}
      {* COMISSAO DO PRODUTO GERAL OU INDIVIDUAL POR TABELA PRECO  *}
      {**********************************************************JC*}
      If fCfgSis('PCMPRO') <> '1' Then
      Begin
        For intTabPre := 1 To Length(VS_strTabPrc) Do
        Begin
          If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_COMTB' + IntToStr(intTabPre)) Then
          Begin

            If fCfgSis('PCMPRO') = '2' Then
              strTCOMTB := '% Comissão '
            else  If fCfgSis('PCMPRO') = '3' Then
              strTCOMTB := '% ' + fCfgSis('TCOMTB');

            arrCamposGlobal[intPosMat].strDesCam := strTCOMTB + ' ' + IntToStr(intTabPre);

            If blnAltPorFator Then
            Begin
              arrCamposGlobal[intPosMat].strMasCam := strMasPer;
              arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
              arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            End
            Else
            Begin
              arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
              arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
              arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
            End;

            arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMTB' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := strTCOMTB + ' ' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

          End;
        End;
      End;

      {*******************************************}
      {* PREÇO 1 - CASO ESTEJA NA CONFIGURAÇÃO   *}
      {****************************************JB*}
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        If GerenciaItegerPermiteEdicao.fCampoPermiteEdicao('ITE_PREVE' + IntToStr(intTabPre)) Then
        Begin

          arrCamposGlobal[intPosMat].strDesCam := 'Preço de Venda ' + IntToStr(intTabPre);

          If blnAltPorFator Then
          Begin
            arrCamposGlobal[intPosMat].strMasCam := strMasFat;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
          End
          Else
          Begin
            arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
            arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
          End;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREVE' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].strDesAbr := 'Preço de Venda ' + IntToStr(intTabPre);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));
        End;
      End;

      {*************************************}
      {* QTDE MÍNIMA POR TABELA DE PREÇOS  *}
      {**********************************JB*}
      For intTabPre := 1 To Length(VS_strTabPrc) Do
      Begin
        arrCamposGlobal[intPosMat].strDesCam := 'Qtde Mínima Tabela ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strMasCam := '#,##0.0000';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MINTB' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].strDesAbr := 'Qtde Mínima Tabela ' + IntToStr(intTabPre);
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric('#,##0.0000');
        arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));
      End;

      intPosMatPreMatFinal := Pred(intPosMat);

      If Not blnIteTbp then
      Begin

        If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
        Begin

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor Júnior';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMAX';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor Júnior';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor Master';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMVM';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor Master';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente Júnior';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMGE';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger. Júnior';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente Master';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMGM';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger. Master';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente Júnior';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMSU';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger. Júnior';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

          arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente Master';
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMSM';
          arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger. Master';
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
          SetLength(arrCamposGlobal, fSoma(intPosMat));

        End;

      End
      Else
      Begin

        If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
        Begin

          For intTabPre := 1 To Length(VS_strTabPrc) Do
          Begin

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMA' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Vendedor Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESVM' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Vendedor Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMG' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger. Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Gerente Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESGM' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Ger. Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESMS' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger. Júnior Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

            arrCamposGlobal[intPosMat].strDesCam := '% Desconto Máximo Sub-Gerente Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].strMasCam := strMasPer;
            arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESSM' + IntToStr(intTabPre);
            arrCamposGlobal[intPosMat].strDesAbr := '% Desc.Maximo Sub-Ger. Master Tab. ' + IntToStr(intTabPre) ;
            arrCamposGlobal[intPosMat].intLimCam := 12;
            arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
            arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
            arrCamposGlobal[intPosMat].strNomArq := 'ITETBP';
            SetLength(arrCamposGlobal, fSoma(intPosMat));

          End;

        End;

      End;

      If Not TipoOpcaoDeTrava.fOpcaoDeTravaEhPorAtividade Then
      Begin

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Vendedor Júnior';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMIN';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Vend. Júnior';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Vendedor Master';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMMV';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Vend. Master';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Sub Gerente Júnior';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMSG';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Sub Gerente Júnior';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Sub Gerente Master';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMMS';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Sub Gerente Master';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Gerente Júnior';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMGE';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Gerente Júnior';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

        arrCamposGlobal[intPosMat].strDesCam := '% Margem Mínima Gerente Master';
        arrCamposGlobal[intPosMat].strMasCam := strMasPer;
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARMMG';
        arrCamposGlobal[intPosMat].strDesAbr := '% Margem Mín. Gerente Master';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
        arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
        SetLength(arrCamposGlobal, fSoma(intPosMat));

      End;

    End;

    if (fCfgSis('OPCCOM') <> 'PPT') then
    begin
    arrCamposGlobal[intPosMat].strDesCam := '% Comissão Vendedor Interno';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMVAR';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Vend.Int.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := '% Comissão Repres. Ext.  Loja';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMATA';
    arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Repr.Ext.Loja';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := '% Comissão Repres. Ext. Distrib.';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMDIS';
    arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Repr.Ext.Distrib.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    end;

    If (fCfgSis('USADIG', varBoolean)) Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Comissão Digitador';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMDIG';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Digitador';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;


    If (fCfgSis('AUTCEN', VarBoolean)) And
       (fCfgSis('OPCMEC', VarString ) = 'CPS') Then //Opcao de Comissao Mecanico: (C)adastro de (P)rodutos/(S)ervicos
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Comissão Mecânico (R$ ou %)';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMMEC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Com.Mec. (R$ ou %)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If (fCfgSis('ORIPRO') = '2') Or (fCfgSis('TCOPRO') = '4') Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := '% Comissão do Profissional';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMPRO';
      arrCamposGlobal[intPosMat].strDesAbr := '% Comis.Vend.Profiss.';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    If (Pos(fCfgSis('TCOPRO'), '3_4_') > 0) Then
    Begin
      If fCfgSis('TCOPRO') = '4' Then
        arrCamposGlobal[intPosMat].strDesCam := 'Pontos Por Valor'
      Else
        arrCamposGlobal[intPosMat].strDesCam := 'Quantidade de Pontos para Profissional';

      arrCamposGlobal[intPosMat].strMasCam := '#0.00';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_QTPPRO';

      If fCfgSis('TCOPRO') = '4' Then
        arrCamposGlobal[intPosMat].strDesAbr := 'Pontos Por Valor'
      Else
        arrCamposGlobal[intPosMat].strDesAbr := 'Qtd.Pont.Profiss.';

      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;



    If fCfgSIs('TIPABF') = '1' Then
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE'
    Else
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Abreviação PIS';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABFPIS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Abrev. PIS';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';

    If fCfgSis('TPABPC') = '1' Then
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE'
    Else
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));

    arrCamposGlobal[intPosMat].strDesCam := 'Abreviação COFINS';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABFCOF';
    arrCamposGlobal[intPosMat].strDesAbr := 'Abrev. COFINS';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';

    If fCfgSis('TPABPC') = '1' Then
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE'
    Else
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Abreviação IPI';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABFIPI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Abrev. IPI';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(03)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';

    If fCfgSis('TPABPC') = '1' Then
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE'
    Else
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

  SetLength(arrCamposGlobal, fSoma(intPosMat));
  arrCamposGlobal[intPosMat].strDesCam := 'Combustivel/Lubrificante?';
  arrCamposGlobal[intPosMat].varValCam := '';
  arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_COMLUB';
    arrCamposGlobal[intPosMat].strDesAbr := 'Combustível/Lubrificante?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Imprime Lista?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPLIS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Imp. Lista?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Ativo?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ITEATI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ativo?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('MARMOR', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Produto mármore / granito?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_GRAMAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Produto mármore / granito?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('USASAN', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'CST de Origem';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CSTORI';
      arrCamposGlobal[intPosMat].strDesAbr := 'CST de Origem';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbCSTOriSel';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If blnPermiteManutencaoLocFis Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Localização Física';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOCFIS';
      arrCamposGlobal[intPosMat].strDesAbr := 'Local. Fisica';
      arrCamposGlobal[intPosMat].intLimCam := intLocFis;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR('+IntToStr(intLocFis)+')';
      arrCamposGlobal[intPosMat].strProper := 'cxeLocFis';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Capacidade da Localização Física';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TAMLCF';
      arrCamposGlobal[intPosMat].strDesAbr := 'Capacidade Loc. Fisica';
      arrCamposGlobal[intPosMat].intLimCam := 30;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(30)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString30';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Localização Super Estoque';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOCSUP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Loc. Sup. Estoque';
      arrCamposGlobal[intPosMat].intLimCam := 10;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(10)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString10';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

      If ((fCfgSis('GRUSEP', VarString) = 'S') Or (fCfgSis('TPLREC', VarString) = 'L')) and (not fCfgSis('UTLSLF', varBoolean)) Then
      Begin
        SetLength(arrCamposGlobal, fSoma(intPosMat));
        arrCamposGlobal[intPosMat].strDesCam := 'Localização de Separação';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODLSE';
        arrCamposGlobal[intPosMat].strDesAbr := 'Localização de Separação';
        arrCamposGlobal[intPosMat].intLimCam := fTamCodLse;
        arrCamposGlobal[intPosMat].strTipCam := 'CHAR(' + IntToStr(fTamCodLse) + ')';
        arrCamposGlobal[intPosMat].strProper := 'cxeConsTamLse';
        arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
      End;

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Capacidade da Localização Super Estoque';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TAMLCS';
      arrCamposGlobal[intPosMat].strDesAbr := 'Capacidade Loc. Sup. Estoque';
      arrCamposGlobal[intPosMat].intLimCam := 30;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(30)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString30';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Unidade de Venda';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODUNI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Un(Venda)';
    arrCamposGlobal[intPosMat].intLimCam := 2;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(02)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam2';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Unidade de Compra';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_UNICOM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Un(Compra)';
    arrCamposGlobal[intPosMat].intLimCam := 2;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(02)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam2';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('UNITRI') = 'S' Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Unidade Tribut.';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_UNITRI';
      arrCamposGlobal[intPosMat].strDesAbr := 'Un(Tribut.)';
      arrCamposGlobal[intPosMat].intLimCam := 2;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(02)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam2';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Fator Unid. Tribut.';
      arrCamposGlobal[intPosMat].strMasCam := '#0.000000';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATUTR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Fator Unid. Tribut.';
      arrCamposGlobal[intPosMat].intLimCam := 16;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(16,6)';
      arrCamposGlobal[intPosMat].strProper := 'cxeDec06';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Marca';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODMAR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Marca';
    arrCamposGlobal[intPosMat].intLimCam := 6;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(06)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam6';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Situação do Produto';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_SITPRO';
    arrCamposGlobal[intPosMat].strDesAbr := 'Situação';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(03)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If blnValFor Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Data Validade Preço';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DTAVAL';
      arrCamposGlobal[intPosMat].strDesAbr := 'Dt. Validade Preço';
      arrCamposGlobal[intPosMat].intLimCam := 10;
      arrCamposGlobal[intPosMat].strTipCam := 'DATE';
      arrCamposGlobal[intPosMat].strProper := 'cxeDate';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('CADMON', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Montadora';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODMON';
      arrCamposGlobal[intPosMat].strDesAbr := 'Montadora';
      arrCamposGlobal[intPosMat].intLimCam := 255;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(255)';
      arrCamposGlobal[intPosMat].strProper := 'cxBtnMontadora';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEMON';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Base?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ITEBAS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Base?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('TREMTA', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Produto embalagem?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PROEMB';
      arrCamposGlobal[intPosMat].strDesAbr := 'Produto embalagem?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('ATICOM', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Qtde. Meses para Inativação de Compras';
      arrCamposGlobal[intPosMat].strMasCam := strMasInt;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_MESGIR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Qtde. Meses para Inativação';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasInt);
      arrCamposGlobal[intPosMat].strProper := 'cxeInt03';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('GARANT', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Tempo de Garantia';
      arrCamposGlobal[intPosMat].strMasCam := strMasInt;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TMPGAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Tempo Garantia';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasInt);
      arrCamposGlobal[intPosMat].strProper := 'cxeInt03';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Informações de Garantia';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_INFGAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Info Garantia';
      arrCamposGlobal[intPosMat].intLimCam := 50;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(50)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString50';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Responsável pela Garantia';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_RSPGAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Responsável pela Garantia';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbRspGar';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'NCM / Classificação de Ipi';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CLAIPI';
    arrCamposGlobal[intPosMat].strDesAbr := 'NCM / Classif. IPI';
    arrCamposGlobal[intPosMat].intLimCam := 10;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(10)';
    arrCamposGlobal[intPosMat].strProper := 'cxeClassfIPI';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Código EX IPI';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXCIPI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Código EX IPI';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString03';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Multiplo para Compra';
    arrCamposGlobal[intPosMat].strMasCam := '#0.00';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MLTCOM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Multiplo Compra';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Multiplo para Venda';
    arrCamposGlobal[intPosMat].strMasCam := '#0.0000';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MLTVEN';
    arrCamposGlobal[intPosMat].strDesAbr := 'Multiplo Venda';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,4)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Diferimento de ICMS na Entrada';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DIFICM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Diferimento de ICMS na Entrada';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';


    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Mensagem Livre 1';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MSGLV1';
    arrCamposGlobal[intPosMat].strDesAbr := 'Mensagem Livre 1';
    arrCamposGlobal[intPosMat].intLimCam := 50;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(50)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString50';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Mensagem Livre 2';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MSGLV2';
    arrCamposGlobal[intPosMat].strDesAbr := 'Mensagem Livre 2';
    arrCamposGlobal[intPosMat].intLimCam := 50;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(50)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString50';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Produto Pigmento?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ITEPIG';
    arrCamposGlobal[intPosMat].strDesAbr := 'Produto Pigmento?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Fator de Conversão';
    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.0000';
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
    End;

    arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATCNV';
    arrCamposGlobal[intPosMat].strDesAbr := 'Fator Conversão';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Peso Bruto';
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.0000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(15,4)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PESOIT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Peso Bruto';
    arrCamposGlobal[intPosMat].intLimCam := 20;
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    If fCfgSis('PESLIQ') = 'SOMA' Then
    Begin
      arrCamposGlobal[intPosMat].strDesCam := 'Peso Liq.';
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.0000';
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,4)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PESLIQ';
      arrCamposGlobal[intPosMat].strDesAbr := 'Peso Liq.';
      arrCamposGlobal[intPosMat].intLimCam := 15;
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
      SetLength(arrCamposGlobal, fSoma(intPosMat));
    End;

    arrCamposGlobal[intPosMat].strDesCam := 'Produto com compra centralizada?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CPRCEN';
    arrCamposGlobal[intPosMat].strDesAbr := 'Compra centralizada?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Abast.Filiais, Abastece com Múlt.Compras?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ABAMLT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Abast. Múlt. Compras?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Venda com obrigatoriedade de CPF/CNPJ?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OBRCPF';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ven. obrigator. CPF/CNPJ?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Venda com obrigatoriedade de código IBAMA no cliente?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OBRIBA';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ven. obrigator. Cód. IBAMA?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Obrigar cód. barras na expedição?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_BAREXP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Obrigar cód. barras na expedição?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Obrigar cód. barras sep. coletor?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_SEPBAR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Obrigar cód. barras sep. coletor?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Ativo para Compras?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ATICOM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ativo Compras?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite Venda Ent.Fut. "Aguar.Cliente"?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PEEFUT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ent.Fut.Aguar.Cliente?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite Venda Ent.Fut. "Falta Produto"?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PEFFPR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ent.Fut.Falta Produto?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite Venda Ent.Fut. "Previs.Entrega"?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PEFUTP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Ent.Fut.Prev.Entrega?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Mensagem Fiscal';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MENFIS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Mensagem Fiscal';
    arrCamposGlobal[intPosMat].intLimCam := 150;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(150)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString150';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Percentual (CI)';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PER_CI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Percentual (CI)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Percentual Imposto de Importação';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PIMPTC';
    arrCamposGlobal[intPosMat].strDesAbr := 'Percentual Imposto de Importação';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
    arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Nº Ficha (FCI)';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_NUMFCI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Nº Ficha (FCI)';
    arrCamposGlobal[intPosMat].intLimCam := 50;
    arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(50)';
    arrCamposGlobal[intPosMat].strProper := 'cxeString50';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Linha/Grupo';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODGRU';
    arrCamposGlobal[intPosMat].strDesAbr := 'Linha/Grupo';
    arrCamposGlobal[intPosMat].intLimCam := 6;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(6)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam6';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Produto Inflamável?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_INFLAM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Produto Inflamável?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Nível Giro Estoque Geral';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_NVLGIR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Niv.Gir.Est.Geral';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbNivGir';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Nível Criticidade Estoque Geral';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_NVLCRI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Niv.Crit.Est.Geral';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbNivCri';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Nível Criticidade Estoque';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_NIVCRI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Niv.Crit.Estoque';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbNivCri';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Item estrutura em OR/PD/VN, carregar os itens da estrutura da seguinte forma?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CAREST';
    arrCamposGlobal[intPosMat].strDesAbr := 'carregar os itens da estrutura da seguinte forma?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(14)';
    arrCamposGlobal[intPosMat].strProper := 'cmbCarEst';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    {******************}
    {* ESTOQUE MÍNIMO *}
    {***************RV*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Estoque Mínimo';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESTMIN';
    arrCamposGlobal[intPosMat].strDesAbr := 'Estoque Mínimo';
    arrCamposGlobal[intPosMat].intLimCam := 14;
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    {******************}
    {* ESTOQUE MÁXIMO *}
    {***************RV*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Estoque Máximo';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESTMAX';
    arrCamposGlobal[intPosMat].strDesAbr := 'Estoque Máximo';
    arrCamposGlobal[intPosMat].intLimCam := 14;
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    {***************************}
    {* EXPORTAÇÃO PARA OS SITE *}
    {************************PE*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Exportação para o Site';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPSIT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Exportação';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    {*****************************}
    {* EXPORTAÇÃO PARA OS TABLET *}
    {**************************CG*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Exportação para Tablet';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPPOK';
    arrCamposGlobal[intPosMat].strDesAbr := 'Exportação Tablet';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    {***************************************}
    {* EXPORTAÇÃO PARA APP VENDA ASSISTIDA *}
    {************************************PA*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Exportação para App Venda Assistida';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPAPP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Exportação App Venda Assistida';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    {***************************************}
    {* EXPORTAÇÃO PARA B2B *}
    {************************************PA*}
    If fCfgSis('MOEXSI') <> '0' then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Exporta para o B2B';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPB2B';
      arrCamposGlobal[intPosMat].strDesAbr := 'Exporta para o B2B?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    {*******************************}
    {* PERMITIR USO DE BONIFICAÇÃO *}
    {****************************MM*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Utilizar este item em bonificação?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_USABON';
    arrCamposGlobal[intPosMat].strDesAbr := 'Utiliza Bonificação';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('USAFLE', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Gerar Flex?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_USAFLE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Gerar Flex?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('UTIWMS', VarBoolean) Then
    Begin
      If fCfgSis('WMSLOT', varBoolean) Then
      Begin
        SetLength(arrCamposGlobal, fSoma(intPosMat));
        arrCamposGlobal[intPosMat].strDesCam := 'Obrigar definir lote (WMS) em Pedido de Venda?';
        arrCamposGlobal[intPosMat].varValCam := '';
        arrCamposGlobal[intPosMat].strMasCam := '';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOTEPD';
        arrCamposGlobal[intPosMat].strDesAbr := 'Obrigar definir lote (WMS) em Pedido de Venda?';
        arrCamposGlobal[intPosMat].intLimCam := 1;
        arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
        arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
      End;
    End;

    {************************************}
    {* CONTROLE DE VALIDADE OBRIGATÓRIA *}
    {*********************************MM*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Este item tem Validade Obrigatória?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_VALOBR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Validade Obrigatória';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Departamento';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODDEP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Departamento';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('PRAMIN', VarBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Prazo médio mínimo para cálculo de juros';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRAMIN';
      arrCamposGlobal[intPosMat].strDesAbr := 'Prazo médio mínimo para cálculo de juros';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'INTEGER';
      arrCamposGlobal[intPosMat].strProper := 'cxeInt03';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Dias para entrega do Fornecedor';
    arrCamposGlobal[intPosMat].strMasCam := strMasPer;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DIAFOR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Dias para entrega do Fornecedor';
    arrCamposGlobal[intPosMat].intLimCam := 11;
    arrCamposGlobal[intPosMat].strTipCam := 'INTEGER';
    arrCamposGlobal[intPosMat].strProper := 'cxeInt11';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If fCfgSis('USACON', VarBoolean) And (fCfgSis('CONFME') = '1') Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Realizar endereçamento do Produto';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_REAEND';
      arrCamposGlobal[intPosMat].strDesAbr := 'Realizar endereçamento do Produto';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Obrigatório o Código de Barras na Entrada Simplificada';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OBRBAR';
    arrCamposGlobal[intPosMat].strDesAbr := 'Obrigatório o Código de Barras na Entrada Simplificada';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permitir spool de tranferência fora do multiplo de compra?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_MLTSPO';
    arrCamposGlobal[intPosMat].strDesAbr := 'Permitir spool de tranferência fora do multiplo de compra?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Digitar complemento do produto';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATCOM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Digitar complemento do produto';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Grupo de Compra';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_GRUCMP';
    arrCamposGlobal[intPosMat].strDesAbr := 'Grupo de Compra';
    arrCamposGlobal[intPosMat].intLimCam := 3;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    if fCfgSis('MOEXSI') <> '0' then
    begin
      {************************************}
      {* DESCONTO PARA SITE               *}
      {*********************************LS*}
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% Desconto para Site';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESSIT';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desconto para Site';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Altura/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPALT';
      arrCamposGlobal[intPosMat].strDesAbr := 'Altura (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Largura/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPLAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Largura (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Profundidade/Cm (Site)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := strMasPer;
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EXPPRO';
      arrCamposGlobal[intPosMat].strDesAbr := 'Profundidade (Site)';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

      {************************************}
      {* PRODUTO EM CROSS DOKING          *}
      {*********************************LS*}
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Produto em Cross Doking';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CRODOC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Produto em Cross Doking';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';
    end;

    {************************************}
    {* TIPO DO FRETE - SAIDA            *}
    {*********************************LS*}
    if fCfgSis('FRETRA', varString) = '3' then
    begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Tipo de Frete';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TIPFRE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Tipo de Frete';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbFrePFU';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Frete de Saída';
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_VLCFRE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Frete de Saída';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    end;

    If Pos(fCfgSis('TIPEXP'), '3_4_') > 0 Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Divisível?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_NOTESP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Divisível?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If blnAltFornecedor Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Código de Fábrica';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODFAB';
      arrCamposGlobal[intPosMat].strDesAbr := 'Cód.Fábrica';
      arrCamposGlobal[intPosMat].intLimCam := 25;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(25)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString25';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Descrição do Fabricante';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESFAB';
      arrCamposGlobal[intPosMat].strDesAbr := 'Descrição Fabricante';
      arrCamposGlobal[intPosMat].intLimCam := 70;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(70)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString70';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Preço em Dólar';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PREDOL';
      arrCamposGlobal[intPosMat].strDesAbr := 'Em Dólar';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Venda com obrigatoriedade de NFe';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_OBRNFE';
    arrCamposGlobal[intPosMat].strDesAbr := 'Venda com obrigatoriedade de NFe';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';

    if fCfgSis('NFEPEP', varBoolean) then
    begin
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    end
    else
    begin
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    end;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite redução de preços na entrada?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_RPRENT';
    arrCamposGlobal[intPosMat].strDesAbr := 'Redução de preços';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    if fCfgSis('CLAONU', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Código de Classificação ONU?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODONU';
      arrCamposGlobal[intPosMat].strDesAbr := 'Classificação ONU';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Prazo de Validade(Meses)';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '#0';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRAVAL';
    arrCamposGlobal[intPosMat].strDesAbr := 'Validade';
    arrCamposGlobal[intPosMat].intLimCam := 11;
    arrCamposGlobal[intPosMat].strTipCam := 'INTEGER';
    arrCamposGlobal[intPosMat].strProper := 'cxeInt11';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    if blnSergipe Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Código DIC';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODDIC';
      arrCamposGlobal[intPosMat].strDesAbr := 'DIC';
      arrCamposGlobal[intPosMat].intLimCam := 7;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(7)';
      arrCamposGlobal[intPosMat].strProper := 'cxeString07';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Tipo de produto (SPED)';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_TIPPRO';
    arrCamposGlobal[intPosMat].strDesAbr := 'Tipo de produto';
    arrCamposGlobal[intPosMat].intLimCam := 7;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(2)';
    arrCamposGlobal[intPosMat].strProper := 'cmbTipPro';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    if blnURapel then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% Desconto Referênte Rapel:';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRAPEL';
      arrCamposGlobal[intPosMat].strDesAbr := '% Desc. Ref. Rapel';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Aplicação';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_APLICA';
    arrCamposGlobal[intPosMat].strDesAbr := 'Aplicação';
    arrCamposGlobal[intPosMat].intLimCam := 255;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(255)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMemo';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    if fCfgSis('ENTETI', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Imprime Etiqueta na Entrada de Mercadorias';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_IMPETI';
      arrCamposGlobal[intPosMat].strDesAbr := 'Imp. Etiq. Ent. Mer.';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('UTIIND', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Densidade';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DENSID';
      arrCamposGlobal[intPosMat].strDesAbr := 'Densidade';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.0000';
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,4)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fUsaRotinaWMS Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Controle de Rastreabilidade';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_RASTRE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Rastreabilidade';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;
    If fCfgSis('VENMAD', varBoolean) Then
    Begin
      If fCfgSis('M3PPCA', varBoolean) Then
      Begin
        SetLength(arrCamposGlobal, fSoma(intPosMat));
        arrCamposGlobal[intPosMat].strDesCam := 'Fator de conversão madeira de M3 para Peças';
        arrCamposGlobal[intPosMat].strMasCam := strMasVal;
        arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATCMP';
        arrCamposGlobal[intPosMat].strDesAbr := 'Fator Madeira(m³ x Peças)';
        arrCamposGlobal[intPosMat].intLimCam := 12;
        arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,4)';
        arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
      End;

      If fCfgSis('PCAPM3', varBoolean) Then
      Begin
        SetLength(arrCamposGlobal, fSoma(intPosMat));
        arrCamposGlobal[intPosMat].strDesCam := 'Fator de conversão madeira de Peças para M³';
        arrCamposGlobal[intPosMat].strMasCam := strMasVal2;
        arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
        arrCamposGlobal[intPosMat].strNomCam := 'ITE_FATPM3';
        arrCamposGlobal[intPosMat].strDesAbr := 'Fator Madeira(Peças x m³)';
        arrCamposGlobal[intPosMat].intLimCam := 14;
        arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(14,6)';
        arrCamposGlobal[intPosMat].strProper := 'cxeMasVal';
        arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
      End;
    End;

    If fCfgSis('VENVID', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Largura';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LARVID';
      arrCamposGlobal[intPosMat].strDesAbr := 'Largura';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := fFormataCasaDecimalVIDRO('###,#0.00000');
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,5)';
      arrCamposGlobal[intPosMat].strProper := 'cxeDec05';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := fRetornaInfMedVIDRO;
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ALTVID';
      arrCamposGlobal[intPosMat].strDesAbr := fRetornaInfMedVIDRO;
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := fFormataCasaDecimalVIDRO('###,#0.00000');
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,5)';
      arrCamposGlobal[intPosMat].strProper := 'cxeDec05';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Largura Máxima (Venda Parcial)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LAMAVI';
      arrCamposGlobal[intPosMat].strDesAbr := 'Largura Máxima';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := fFormataCasaDecimalVIDRO('###,#0.00000');
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,5)';
      arrCamposGlobal[intPosMat].strProper := 'cxeDec05';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := fRetornaInfMedVIDRO(False,False,True,False) +' (Venda Parcial)';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ALMAVI';
      arrCamposGlobal[intPosMat].strDesAbr := fRetornaInfMedVIDRO(False,False,True,False);
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strMasCam := fFormataCasaDecimalVIDRO('###,#0.00000');
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,5)';
      arrCamposGlobal[intPosMat].strProper := 'cxeDec05';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('UTIAMP', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Aplica legislação AMPARA';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_UTIAMP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Legislação AMPARA';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('GS1CNP', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Classificação Global do Produto - GPC';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODGPC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Classificação Global do Produto - GPC';
      arrCamposGlobal[intPosMat].intLimCam := 8;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(8)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam8';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('OSPDVN', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Ordem de Serviço';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_ORDSER';
      arrCamposGlobal[intPosMat].strDesAbr := 'Ordem de Serviço';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Classificação CEST';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CDCEST';
    arrCamposGlobal[intPosMat].strDesAbr := 'Classificação CEST';
    arrCamposGlobal[intPosMat].intLimCam := 7;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(7)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam7';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Classificação Oferta de Consumíveis';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CLACRM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Classificação Oferta de Consumíveis';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbClaCRM';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Opção para o Estoque Mínimo';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_ESMIDG';
    arrCamposGlobal[intPosMat].strDesAbr := 'Opção para o Estoque Mínimo';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbEsMiDg';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';


    if fCfgSis('MINPRO', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Tipo do Estoque Mínimo';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TPESTM';
      arrCamposGlobal[intPosMat].strDesAbr := 'Tipo do Estoque Mínimo';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbTpEstM';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permite Receber Devolução';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_RECDEV';
    arrCamposGlobal[intPosMat].strDesAbr := 'Permite Receber Devolução';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Composição';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODCOM';
    arrCamposGlobal[intPosMat].strDesAbr := 'Composição';
    arrCamposGlobal[intPosMat].intLimCam := 5;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(05)';
    arrCamposGlobal[intPosMat].strProper := 'cxeConsTam5';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    If (fCfgSis('PESOBR', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Controlar pesagem obrigatória ( Saída ) ?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PESOBR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Controlar pesagem obrigatória ( Saída )';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If (fCfgSis('CPESOB', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Controlar pesagem obrigatória ( Entrada ) ?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CPESOB';
      arrCamposGlobal[intPosMat].strDesAbr := 'Controlar pesagem obrigatória ( Entrada ) ?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If (fCfgSis('DESCND', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Aplicar desconto da condição de pagamento neste produto ?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESCND';
      arrCamposGlobal[intPosMat].strDesAbr := 'Aplicar desconto da condição de pagamento neste produto ?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('ITECFO', varBoolean) And fCfgSis('DESCHK', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Desobrigar conferência no check-out?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_DESCHK';
      arrCamposGlobal[intPosMat].strDesAbr := 'Desobrigar conferência no check-out?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Permitir venda para';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PERVDA';
    arrCamposGlobal[intPosMat].strDesAbr := 'Perm. venda';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbPerVda';
    arrCamposGlobal[intPosMat].strNomArq := IIF(FPermVendaIgualTodasEmp, 'CADITE', 'ITEGER');

    If fCfgSis('EMPCAR', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Empresa responsável pelo carregamento e entrega do item';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EMPCAR';
      arrCamposGlobal[intPosMat].strDesAbr := 'Emp. carregamento e entrega item';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    if (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean)) then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Sugestão para empresa multi-loja no faturamento';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_EMPSUG';
      arrCamposGlobal[intPosMat].strDesAbr := 'Empresa Sug. multi-loja no fat.';
      arrCamposGlobal[intPosMat].intLimCam := 3;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(3)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam3';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'UTILIZA CONTROLE DE NÚMERO SERIE';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_USASER';
    arrCamposGlobal[intPosMat].strDesAbr := 'UTILIZA CONTROLE DE NÚMERO SERIE';
    arrCamposGlobal[intPosMat].intLimCam := fTamRefere;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If fCfgSis('APERET', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Apenas Retira';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_APERET';
      arrCamposGlobal[intPosMat].strDesAbr := 'Apenas Retira';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Apenas Entrega';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_APEENT';
      arrCamposGlobal[intPosMat].strDesAbr := 'Apenas Entrega';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('MARPAD') = 'S' Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := '% Margem Padrão';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_MARPAD';
      arrCamposGlobal[intPosMat].strDesAbr := '% Margem Padrão';
      arrCamposGlobal[intPosMat].intLimCam := 5;
      arrCamposGlobal[intPosMat].strMasCam := '###,#0.000';
      arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,2)';
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('OPCCOM', varString) = 'VT' Then
    Begin
      For intContador := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intContador] = 'S' Then
        Begin
          SetLength(arrCamposGlobal, fSoma(intPosMat));
          arrCamposGlobal[intPosMat].strDesCam := '% Comissão Ven. Int. Tab. ' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].varValCam := 0.00;
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'COM_VENINT' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].strDesAbr := 'Com. Ven. Int. T. ' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'COMITE';

          SetLength(arrCamposGlobal, fSoma(intPosMat));
          arrCamposGlobal[intPosMat].strDesCam := '% Comissão Ven. Ext. Tab. ' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].varValCam := 0.00;
          arrCamposGlobal[intPosMat].strMasCam := strMasPer;
          arrCamposGlobal[intPosMat].strNomCam := 'COM_VENEXT' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].strDesAbr := 'Com. Ven. Ext. T. ' + IntToStr(intContador);
          arrCamposGlobal[intPosMat].intLimCam := 12;
          arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasPer);
          arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
          arrCamposGlobal[intPosMat].strNomArq := 'COMITE';


        End;

      End;

    End;

    If fCfgSis('PONEXP', varBoolean) Then
    Begin

      SetLength(arrCamposGlobal, fSoma(intPosMat));

      arrCamposGlobal[intPosMat].strDesCam := 'Ponto de Exposição';

      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(2);
      arrCamposGlobal[intPosMat].strTipCam := 'NUMERIC(12, 2)' ;
      arrCamposGlobal[intPosMat].strProper := 'cxeMasPer';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_PONEXP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Ponto de Exposição';
      arrCamposGlobal[intPosMat].intLimCam := 12;
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Produto controlado pela polícia federal';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_USAPFD';
    arrCamposGlobal[intPosMat].strDesAbr := 'Produto controlado pela polícia federal';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Produto controlado pela polícia civil';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_USAPCV';
    arrCamposGlobal[intPosMat].strDesAbr := 'Produto controlado pela polícia civil';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Aplicação - E-Commerce';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_APLITE';
    arrCamposGlobal[intPosMat].strDesAbr := 'Aplicação E-commerce';
    arrCamposGlobal[intPosMat].intLimCam := 255;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(255)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMmoAPE';
    arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Descrição do Produto - E-Commerce';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'EC_ITE_DESITE';
    arrCamposGlobal[intPosMat].strDesAbr := 'Descrição E-commerce';
    arrCamposGlobal[intPosMat].intLimCam := 200;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(200)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMmoAPE';
    arrCamposGlobal[intPosMat].strNomArq := 'DESSIT';

    if blnUtilizaChecklistGarantia then
    begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Código da Assistência Técnica';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CODATC';
      arrCamposGlobal[intPosMat].strDesAbr := 'Assistência Técnica';
      arrCamposGlobal[intPosMat].intLimCam := 5;
      arrCamposGlobal[intPosMat].strTipCam := 'VARCHAR(5)';
      arrCamposGlobal[intPosMat].strProper := 'cxeConsTam5';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    end;

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Dias antes do vencimento para transferir ao crítico';
    arrCamposGlobal[intPosMat].strMasCam := strMasInt;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_DIACRI';
    arrCamposGlobal[intPosMat].strDesAbr := 'Dias antes do vencimento para transferir ao crítico';
    arrCamposGlobal[intPosMat].intLimCam := 6;
    arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasInt);
    arrCamposGlobal[intPosMat].strProper := 'cxeInt06';
    arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Sob encomenda?';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_SOBENC';
    arrCamposGlobal[intPosMat].strDesAbr := 'Sob encomenda?';
    arrCamposGlobal[intPosMat].intLimCam := 1;
    arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
    arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    If fCfgSis('UTIABA', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Múltiplo na rotina Citel Abastece?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_MLTRCA';
      arrCamposGlobal[intPosMat].strDesAbr := 'Múltiplo na rotina Citel Abastece?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbMltRca';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If fCfgSis('ETIDCE', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Sem necessidade de expedição';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_NECEXP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Sem necessidade de expedição';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('LOCRET', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Tipo de Retirada';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TIPRET';
      arrCamposGlobal[intPosMat].strDesAbr := 'Tipo de Retirada';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(2)';
      arrCamposGlobal[intPosMat].strProper := 'cmbTipRet';
      arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';
    End;

    If ((fCfgSis('NFELOT', varBoolean) Or fCfgSis('NFCLOT', varBoolean)) And (fCfgSis('LIDPRO', varBoolean))) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'NFe, Imprimir o lote na descrição do produto?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_NFEIDP';
      arrCamposGlobal[intPosMat].strDesAbr := 'NFe, Imprimir o lote na descrição do produto?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';

      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'NFCe, Imprimir o lote na descrição do produto?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_NFCIDP';
      arrCamposGlobal[intPosMat].strDesAbr := 'NFCe, Imprimir o lote na descrição do produto?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If (fCfgSis('UTIWMS', varBoolean) And fCfgSis('OBRLOT', varBoolean)) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Obrigar a digitar o número do lote no Cadastro Rápido?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_LOTRAP';
      arrCamposGlobal[intPosMat].strDesAbr := 'Obrigar a digitar o número do lote no Cadastro Rápido?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('TRITTE', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Permitir utilizar em Transferência de Estoque?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_TRITTE';
      arrCamposGlobal[intPosMat].strDesAbr := 'Permitir utilizar em Transferência de Estoque?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If fCfgSis('CDPHAB', varBoolean) Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Permite pontuar no Clube do Pintor';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_CLBPIN';
      arrCamposGlobal[intPosMat].strDesAbr := 'Permite pontuar no Clube do Pintor';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(1)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    If blnUsaBef Then
    Begin
      SetLength(arrCamposGlobal, fSoma(intPosMat));
      arrCamposGlobal[intPosMat].strDesCam := 'Possui Benefício Fiscal?';
      arrCamposGlobal[intPosMat].varValCam := '';
      arrCamposGlobal[intPosMat].strMasCam := '';
      arrCamposGlobal[intPosMat].strNomCam := 'ITE_USABEF';
      arrCamposGlobal[intPosMat].strDesAbr := 'Possui Benefício Fiscal?';
      arrCamposGlobal[intPosMat].intLimCam := 1;
      arrCamposGlobal[intPosMat].strTipCam := 'CHAR(01)';
      arrCamposGlobal[intPosMat].strProper := 'cmbSimNao';
      arrCamposGlobal[intPosMat].strNomArq := 'CADITE';
    End;

    pGeraClient;

    {***********************************************************************************}
    {* PREÇO DE CUSTO                                                                  *}
    {* ESTE CAMPO DEVE SER CRIADO APÓS AS ATUALIZAÇÕES ACIMA PARA NÃO APARECER NO GRID *}
    {********************************************************************************LU*}
    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := 'Preço de Custo';
    If blnAltPorFator Then
    Begin
      arrCamposGlobal[intPosMat].strMasCam := strMasFat;
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasFat);
      arrCamposGlobal[intPosMat].strProper := 'cxeMasFat';
    End
    Else
    Begin
      arrCamposGlobal[intPosMat].strMasCam := fMskDigitos(fCfgSis('DECUNI', varInteger));
      arrCamposGlobal[intPosMat].strTipCam := fRetornaNumeric(strMasVal);
      arrCamposGlobal[intPosMat].strProper := 'cxeDecUni';
    End;
    arrCamposGlobal[intPosMat].strNomCam := 'ITE_PRECUS';
    arrCamposGlobal[intPosMat].strDesAbr := 'Preço Custo';
    arrCamposGlobal[intPosMat].intLimCam := -1;
    arrCamposGlobal[intPosMat].strNomArq := 'ITEGER';

    SetLength(arrCamposGlobal, fSoma(intPosMat));
    arrCamposGlobal[intPosMat].strDesCam := '% IVA (Cadastro do produto)';
    arrCamposGlobal[intPosMat].varValCam := '';
    arrCamposGlobal[intPosMat].strMasCam := '';
    arrCamposGlobal[intPosMat].strNomCam := 'ABF_IVA_ST_SAI_CCO';
    arrCamposGlobal[intPosMat].strDesAbr := '%IVA (Cadastro do produto)';
    arrCamposGlobal[intPosMat].intLimCam := 12;
    arrCamposGlobal[intPosMat].strMasCam := '###,#0.0000';
    arrCamposGlobal[intPosMat].strTipCam := 'DECIMAL(12,4)';
    arrCamposGlobal[intPosMat].strProper := 'cxeMasMar';
    arrCamposGlobal[intPosMat].strNomArq := 'ABFICM';
  Finally
    FreeAndNil(GerenciaItegerPermiteEdicao);
  End;
end;

procedure TfrmAltPrecoGlobal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

 Case Key Of
    VK_ESCAPE : If Not mskLinGru.Focused Then
                  pSetFocus(mskLinGru)
                Else
                  Close;

    VK_RETURN: If fCheckParent(ActiveControl, cxgTiposAlt) And (cdsAltGlo.State = dsEdit) And
                  (Not SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_APLICA')) Then
               Begin
                 cdsAltGlo.Post;
                 cxvTiposAlt.NavigatorButtons.Next.Click;
               End;

     VK_F3 : If btnPrecoPautaFiscal.Visible Then
             Begin
               btnPrecoPautaFiscal.Click;
               Key := 0;
             End;

    VK_F10 : Begin
               btnConfirma.Click;
               Key := 0;
             End;

  End;

end;

procedure TfrmAltPrecoGlobal.rdgTipAltClick(Sender: TObject);
begin
  inherited;
  pMontaGrid;
end;

procedure TfrmAltPrecoGlobal.rdgTipAltForClick(Sender: TObject);
begin
  inherited;
  rdgTipAlt.ItemIndex := rdgTipAltFor.ItemIndex;
end;

procedure TfrmAltPrecoGlobal.rdgTipAltNotClick(Sender: TObject);
begin
  inherited;

  rdgTipAlt.ItemIndex := rdgTipAltNot.ItemIndex;
end;

function TfrmAltPrecoGlobal.RemoveAcento(const pText: string): string;
  type
    USAscii20127 = type AnsiString(20127);
begin
  Result := string(USAscii20127(pText));
end;

function TfrmAltPrecoGlobal.VerificarRefere: Boolean;
var
  strFilter: String;
  blnFiltered: boolean;
begin
  Result := True;

  strFilter := '';
  blnFiltered := False;

  strFilter := cdsAltGlo.Filter;

  If cdsAltGlo.Filtered Then
    blnFiltered := True;

  Try
    cdsAltGlo.DisableControls;
    cdsAltGlo.Filter := 'ITE_ALTERA = ' + QuotedStr('S') + ' AND ITE_NOMCAM = ' + QuotedStr('ITE_REFERE');
    cdsAltGlo.Filtered := True;

    If cdsAltGlo.IsEmpty Then
      Exit;

    If Pos('|', cdsAltGlo.FieldByName('ITE_VALCAM').AsString) > 0 Then
    Begin
      Result := false;
      fMensagem('ATENÇÃO!', 'Caractere inválido "|" encontrado na Referência!', ['&Ok']);
    End;
  Finally
    cdsAltGlo.Filtered := False;
    cdsAltGlo.Filter := strFilter;

    If blnFiltered Then
      cdsAltGlo.Filtered := True;

    cdsAltGlo.EnableControls;
  End;
end;

procedure TfrmAltPrecoGlobal.edtCestKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  If Not fEntraCons(Key) Then
    Exit;

    If fPesqCest(Self,  edtCest,  edtCestDesc,  nil, Key, arrSel, True) Then
      If fValidaCampos(edtCest) Then
        SelectNext(ActiveControl, True, True);
end;

procedure TfrmAltPrecoGlobal.edtClaIPIExit(Sender: TObject);
begin
  inherited;
  {para corrigir o array arrClaIPI}
  pEdtCodSelectExit(edtClaIPI, nil, arrClaIPI, nil, nil, 'da Classificação de IPI');
end;

procedure TfrmAltPrecoGlobal.edtClaIPIKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqClaIPI(Self, edtClaIPI, nil, Key, arrClaIPI,False) Then
  Begin
    if fValidaCampos(edtClaIPI, True) then
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.pHabilitaCamposMargemIdeal;
begin
  if cbxMarIde.ItemIndex = 0 then
  begin
    cbxTabPrc.ItemIndex := -1;
    lblTabPrc.Enabled   := False;
    cbxTabPrc.Enabled   := False;
  end
  else
  begin
    if cbxTabPrc.ItemIndex = -1 then
      cbxTabPrc.ItemIndex := 0;

    lblTabPrc.Enabled   := True;
    cbxTabPrc.Enabled   := True;
  end;
end;

procedure TfrmAltPrecoGlobal.pHabilitaNotaEntrada(blnHabilitar: Boolean);
Begin
  If blnHabilitar Then
  Begin
    lblDocumento.Enabled  := True;
    lblEspecie.Enabled    := True;
    lblSerie.Enabled      := True;
    lblForNot.Enabled     := True;
    lblEmpresa.Enabled    := True;

    edtDocumento.Enabled  := True;
    edtEspecie.Enabled    := True;
    edtSerie.Enabled      := True;
    edtForNot.Enabled     := True;
    edtCodEmpresa.Enabled := True;
  End
  Else
  Begin
    edtDocumento.Clear;
    edtEspecie.Text := 'NF';
    edtSerie.Clear;
    edtForNot.Clear;
    edtDesForNot.Clear;
    edtCodEmpresa.Text := VS_strCodEmp;
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);

    lblDocumento.Enabled  := False;
    lblEspecie.Enabled    := False;
    lblSerie.Enabled      := False;
    lblForNot.Enabled     := False;
    lblEmpresa.Enabled    := False;

    edtDocumento.Enabled  := False;
    edtEspecie.Enabled    := False;
    edtSerie.Enabled      := False;
    edtForNot.Enabled     := False;
    edtCodEmpresa.Enabled := False;

  End;

  mskDtaEntFin.Enabled := blnHabilitar And fEmptyStr(edtDocumento.Text);
  mskDtaEntIni.Enabled := blnHabilitar And fEmptyStr(edtDocumento.Text);
  lblDtaFin.Enabled    := blnHabilitar And fEmptyStr(edtDocumento.Text);
  lblDtaIni.Enabled    := blnHabilitar And fEmptyStr(edtDocumento.Text);

  If Not blnHabilitar Then
  Begin
    mskDtaEntFin.Text := '';
    mskDtaEntIni.Text := '';
  End;

End;

procedure TfrmAltPrecoGlobal.pLimparTela;
//  Var
//    IntCont: Integer;
begin
 (*
  For IntCont := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[IntCont] Is TEditFocus Then
      (Self.Components[IntCont] As TEditFocus).Clear;
  End;

  mskLinGru.Clear;
  edtStatus.Text    := 'T';
  edtIncPis.Text    := 'T';

  If Not blnAltPorNota Then
  Begin
    chkNotEnt.Checked := False;
    pHabilitaNotaEntrada(chkNotEnt.Checked);
  End;
*)

  pGeraClient;

  cdsPrecoPautaFiscal.EmptyDataSet;

//  rdgTipAlt.ItemIndex := 0;

  pVerificaDireitoAcesso;
  pMontaGrid;

  pSetFocus(mskLinGru);
end;

procedure TfrmAltPrecoGlobal.pVerificaDireitoAcesso;
Begin
  TRadioButton(rdgTipAlt.Components[0]).Enabled := fVerificaAcessoSistema('ALTGCUSVEN', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[1]).Enabled := fVerificaAcessoSistema('ALTGCUSMAR', strLoginUsuarioLogado);
  TRadioButton(rdgTipAlt.Components[2]).Enabled := fVerificaAcessoSistema('ALTGVENMAR', strLoginUsuarioLogado);

  If TRadioButton(rdgTipAlt.Components[0]).Enabled Then
    TRadioButton(rdgTipAlt.Components[0]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[1]).Enabled Then
    TRadioButton(rdgTipAlt.Components[1]).Checked := True

  Else If TRadioButton(rdgTipAlt.Components[2]).Enabled Then
    TRadioButton(rdgTipAlt.Components[2]).Checked := True;

  blnBloPre := fCfgSis('BLOPRE', varBoolean);

  If blnBloPre Then
  Begin
    rdgTipAlt.Controls[0].Enabled := False;
    rdgTipAlt.Controls[2].Enabled := False;

    If rdgTipAlt.Controls[1].Enabled Then
      rdgTipAlt.ItemIndex := 1;

    If rdgTipAltFor.Visible Then
    Begin
      rdgTipAltFor.ItemIndex := 1;
      rdgTipAltFor.Controls[0].Enabled := False;
    End;

    rdgTipAltNot.ItemIndex := 1;
    rdgTipAltNot.Controls[0].Enabled := False;
  End;

End;

procedure TfrmAltPrecoGlobal.FormCreate(Sender: TObject);
begin
  inherited;
  blnUtilizaChecklistGarantia := TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia;
  edtCodAbr.MaxLength := IIf(fCfgSis('USASAN') = 'S', 7, 3);
  cxeConsTamLse.Properties.MaxLength := fTamCodLse;

  enuCalculo := tcNenhum;
  blnTABPRD :=  fCfgSis('TABPRD', varBoolean);
  FPermVendaIgualTodasEmp := (fCfgSis('PERVDA', varString) = '1');
  cmbGiroEstoqueFornecedor.Visible := blnTABPRD;
  lblGiroEstoqueFornecedor.Visible := blnTABPRD;

  dtsPermissaoVenda.DataSet := TTipoPermissaoVenda.Dataset;
  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);
  strMarMkp := fCfgSis('MARMKP', varString);
  strPcmPro := fCfgSis('PCMPRO', varString);

  blnSUFRAM := fCfgSis('SUFRAM', varBoolean);
  strFrmCus := fCfgSis('FRMCUS', varString);

  pCriaCdsSimNao;
  pCriaCdsIndRev;

  pCriaCdsSimNaoFornecedor;
  pCriaCdsClaCRM;
  pCriaCdsFrePFU;
  pCriaCdsEsMiDg;
  pCriaCdsTipPro;
  pCriaCdsTipRet;

  blnVidroInteiro := (fCfgSis('VENVID', varBoolean)) And (Not fCfgSis('DECVID', varBoolean));

  blnFilSai := fCfgSis('FILSAI', VarBoolean);

  blnLiqNeg := fCfgSis('LIQNEG', varBoolean);

  If blnLiqNeg Then
    fltPMarLq := fCfgSis('PMARLQ', varDouble)
  Else
    fltPMarLq := 1;

  blnAltPorNota    := False;
  blnAltPorFator   := False;
  blnAltFornecedor := False;
  blnSergipe       := (fCadEmp('ESTADO') = 'SE');
  blnSuframa       := Pos(fCadEmp('ESTADO'), ESTADOS_REGRA_ZONA_FRANCA) > 0;
  blnURapel        := fCfgSis('URAPEL', varBoolean);
  blnIteTbp        := fCfgSis('ITETBP', varBoolean);
  blnCadLoc        := fCfgSis('CADLOC', varBoolean);

  blnPermiteManutencaoLocFis :=  (fCfgSis('CTLEST', varInteger) = 1) or fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica;

  cdsAltGlo.CreateDataSet;

  cdsPrecoPautaFiscal.CreateDataSet;

  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  If Not fCfgSis('CADMON', varBoolean) Then
  Begin
    pnlCadMon.Visible   := False;
    pnlCabecalho.Height := pnlCabecalho.Height - pnlCadMon.Height;
  End;

  lblLocFis.Visible     := (Not blnCadLoc);
  edtLocFis.Visible     := (Not blnCadLoc);
  edtDesLocFis.Visible  := (Not blnCadLoc);

  btnPrecoPautaFiscal.Visible := False;

  edtDocumento.MaxLength := fTamNumDoc();
  edtDocumento.TamCampo  := edtDocumento.MaxLength;

  blnValFor := fCfgSis('VALFOR', VarBoolean);
  blnMarIde := fCfgSis('MARIDE', VarBoolean);

  strEstEmp := fCadEmp('ESTADO');

  objSalInt := TSalvaInterface.Create(Self);
  objSalInt.blnDeleteNaoEncontrados := False;

  pTamanhoCamposLocFis(intLocFis, intLocSup, intTamLcf, intLocSep);

  TcxTextEditProperties(cxeLocFis.Properties).MaxLength := intLocFis;
  TcxTextEditProperties(cxeLocSup.Properties).MaxLength := intLocSup;
  TcxTextEditProperties(cxeLocSep.Properties).MaxLength := intLocSep;
  TcxTextEditProperties(cxeTamLcf.Properties).MaxLength := intTamLcf;

  TcxTextEditProperties(cxeClassfIPI.Properties).MaxLength := MAX_CLAIPI;
  edtDesGru.Width := 408;
  if not (fCfgSis('USASAN', VarString) = 'S') then
  begin
    lblCSTORI.Visible := False;
    cmbCSTORI.Visible := False;
    edtDesGru.Width := 543;
  end;

  blnUsaBef := fCfgSis('USABEF', VarString) = 'S';
end;

procedure TfrmAltPrecoGlobal.pCarregaSelecao;
Begin
  blnCarregandoCadInt := objSalInt.fCarregaDados('', Self, Self.Name + IIF(blnAltPorNota, '_Nota', ''), strLoginUsuarioLogado);
  If Assigned(objGerenciaExpr) Then
      objGerenciaExpr.pSetCarregandoCadInt(blnCarregandoCadInt);
  objSalInt.pCarregaMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pCarregaMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pCarregaMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pCarregaMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pCarregaMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pCarregaMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pCarregaMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pCarregaMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pCarregaMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pCarregaMultiSelecao(arrCodUni,     'CODUNI');
  objSalInt.pCarregaMultiSelecao(arrClaIPI,     'CLAIPI');
End;

procedure TfrmAltPrecoGlobal.pSalvarClientDataSet;
var
  qryIns: TUniQuery;
begin
  Try
    qryIns := fCriaQuery;
    qryIns.SQL.Add('DELETE FROM ALTGLO WHERE ALT_CODEMP = :CODEMP AND ALT_CODOPE = :CODOPE;');
    qryIns.SQL.Add('INSERT INTO ALTGLO (AUTOINCREM, ALT_CODOPE, ALT_CODEMP, ALT_DTASET) VALUES (:AUTINC, :CODOPE, :CODEMP, :DTASET)');

    qryIns.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryIns.ParamByName('AUTINC').AsString := fRetAutoIncrem('ALTGLO', VS_strCodEmp);

    cdsAltGlo.SaveToFile(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml');
    qryIns.ParamByName('DTASET').LoadFromFile(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml', ftBlob);
    TFile.Delete(ExtractFilePath(ParamStr(0))+'cdsAltGlo.xml');
    Try
      fStartTransaction;
      qryIns.ExecSQL;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmAltPrecoGlobal.pSalvarClientDataSet]');
      End;
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmAltPrecoGlobal.pSalvaSelecao;
Begin
  objSalInt.pAddMultiSelecao(arrLinhaGrupo, 'CODGRU');
  objSalInt.pAddMultiSelecao(arrMarca,      'CODMAR');
  objSalInt.pAddMultiSelecao(arrFornec,     'CODFOR');
  objSalInt.pAddMultiSelecao(arrGrupoPro,   'PRDGRU');
  objSalInt.pAddMultiSelecao(arrGruCmp,     'GRUCMP');
  objSalInt.pAddMultiSelecao(arrCodGpr,     'CODGPR');
  objSalInt.pAddMultiSelecao(arrCodDep,     'CODDEP');
  objSalInt.pAddMultiSelecao(arrCodMon,     'CODMON');
  objSalInt.pAddMultiSelecao(arrCodAbr,     'CODABF');
  objSalInt.pAddMultiSelecao(arrCodUni,     'CODUNI');
  objSalInt.pAddMultiSelecao(arrClaIPI,     'CLAIPI');

  objSalInt.fSalvaDados('', Self.Name + IIF(blnAltPorNota, '_Nota', ''), strLoginUsuarioLogado, True);
End;

procedure TfrmAltPrecoGlobal.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

  FreeAndNil(objGerenciaExpr);
end;

function TfrmAltPrecoGlobal.fArredonda(fltVlrOri: Double; intTabela: Integer; Var fltNovMarBru: Double): Double;
  Var
    fltPreComLiq : Double;
    strCodSit : String;
    fltIcmsST : Double;
    blnCalcSt : Boolean;
begin
  Result := fltVlrOri;

  //*************************************************//
  // SE ESTIVER SELECIONADO ARREDONDA O VALOR A MAIS //
  //**********************************************ED*//
  If chkArrMai.Checked Then
  Begin
//    Result := fArredondaMais(fltVlrOri, True);
    Result := RoundTo(fltVlrOri, StrToIntDef(edtDecUni.Text,0) * -1 );

    With qryGenIte Do
    Begin
      //*************************************************************//
      //* recalcula a margem caso seja opcao de alteracao de margem *//
      //**********************************************************JC*//
      If (intTabela In [1..7]) And (rdgTipAlt.ItemIndex In [1,2]) Then
      Begin
        //***********************************//
        //* RECALCULA A MARGEM BRUTA        *//
        //********************************ED*//
        arrRecTabelasPreco[intTabela].fltMarBruNov := FieldByName('ITE_MARBR' + IntToStr(intTabela)).AsFloat;

        fltPreComLiq := fCalculaPrecoCompraLiq(FieldByName('ITE_PRECOM_NOV').AsFloat,
                                               FieldByName('ITE_DESF01_NOV').AsFloat,
                                               FieldByName('ITE_DESF02_NOV').AsFloat,
                                               FieldByName('ITE_DESF03_NOV').AsFloat,
                                               FieldByName('ITE_DESF04_NOV').AsFloat,
                                               FieldByName('ITE_DESF05_NOV').AsFloat,
                                               FieldByName('ITE_DESF06_NOV').AsFloat,
                                               intDecUni,
                                               (FieldByName('ITE_PREDOL_NOV').AsString = 'S'));

        strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'], [FieldByName('ITE_CODABF_NOV').AsString, strEstEmp]);
        fltIcmsST := fGetIcmsSTParteVenda(FieldByName('ITE_CODABF_NOV').AsString,
                                          '_SAI_CCO', strCodSit, strEstEmp,
                                          fltPreComLiq, FieldByName('ITE_IPIENT_NOV').AsFloat,
                                          FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                          strEstEmp, blnCalcSt);

        fltNovMarBru := fCalculaPrecoVenda(2,
                                           FieldByName('ITE_PRECUS_NOV').AsFloat + FieldByName('ITE_OUTVAL_NOV').AsFloat,
                                           Result,
                                           0,
                                           FieldByName('ITE_ICMSAI_NOV').AsFloat,
                                           FieldByName('ITE_IMPFED_NOV').AsFloat,
                                           FieldByName('ITE_DESOPE_NOV').AsFloat,
                                           FieldByName('ITE_COMTB' + IntToStr(intTabela) + '_NOV').AsFloat,
                                           strMarMkp,
                                           strPcmPro,
                                           intDecUni,
                                           fltIcmsST,
                                           blnCalcSt);

        arrRecTabelasPreco[intTabela].blnAltMarBru := arrRecTabelasPreco[intTabela].fltMarBruNov <> FieldByName('ITE_MARBR' + IntToStr(intTabela) + '_NOV').AsFloat;
      End;
    End;
  End;
end;

procedure TfrmAltPrecoGlobal.cbxMarIdeChange(Sender: TObject);
begin
  inherited;

  pHabilitaCamposMargemIdeal;
end;

Function TfrmAltPrecoGlobal.fRetDescricaoCadastro(strCodCad: String; blnValidar: Boolean; Var blnErro: Boolean): String;
Begin
  With cdsAltGlo Do
  Begin
    Result  := '';
    blnErro := False;

    If fEmptyStr(strCodCad) Then
      Exit;

    If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODFOR') Then
    Begin
      Result := fRetNomFornecedor(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPR') Then
    Begin
      Result := fRetNomeGrupoPrecos(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_PRDGRU') Then
    Begin
      Result := fRetNomeGrupoProduto(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODABF') Then
    Begin
      Result := fRetDesAbfIcm(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFPIS') Then
    Begin
      Result := fRetDesAbfPisCofIpi('PISSAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFCOF') Then
    Begin
      Result := fRetDesAbfPisCofIpi('COFSAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFIPI') Then
    Begin
      Result := fRetDesAbfPisCofIpi('IPISAI', strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMAR') Then
    Begin
      Result := fRetNomMarca(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMON') Then
    Begin
      Result := fRetNomMontadora(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODUNI') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODCOM') Then
    Begin
      Result := fRetDescricaoComposicao(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_UNICOM') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_UNITRI') Then
    Begin
      Result := fRetNomUnidade(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGRU') Then
    Begin

      If blnValidar And (RightStr(strCodCad, 3) = '000') Then
      Begin
        pMensagemOk('Linha não permitida!');
        Result := '';
      End
      Else
        Result := fRetNomeSoGrupo(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDEP') Then
    Begin
      Result := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'], [strCodCad]);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_GRUCMP') Then
    Begin
      Result := fRetDescGrupoCompra(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODONU') Then
    Begin
      Result := fRetDescClassificacaoOnu(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDIC') Then
    Begin
      Result := fRetDesDic(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODLSE') Then
    Begin
      Result := fRetLocSep(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CDCEST') Then
    Begin
      Result := fCampoTabela('CES_DESCRI','CDCEST',['CES_CDCEST'], [strCodCad]);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') Then
    Begin
      Result := fRetNomSituacaoProduto(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPC') Then
    Begin
      Result := fCampoTabela('GPC_DESGPC','CADGPC',['GPC_CODGPC'], [strCodCad]);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_EMPCAR') Then
    Begin
      Result := fRetNomeEmpresaSelec(strCodCad);
    End

    Else If SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_EMPSUG') Then
    Begin
      Result := fRetNomeEmpresaSelec(strCodCad);
    End

    Else if SameText(FieldByName('ITE_NOMCAM').AsString, 'ITE_CODATC') Then
    begin
      Result := TCheckListGarantiaController.fRetornaNomeAssistenciaTecnica(strCodCad);

      If (Not fEmptyStr(Result)) Then
      Begin
        if (Not  TCheckListGarantiaController.fCadAssistenciaAtivo(strCodCad)) then
        begin
          fMensagem('', 'Assistência técnica inativa, informe um cadastro ativo!', ['&Ok']);
          Result := EmptyStr;
          blnErro:= True;
          blnValidar := False;
        end;
      End;
    end

    Else If Pos(FieldByName('ITE_NOMCAM').AsString, 'ITE_LOCFIS_ITE_LOCSUP') > 0 Then
    Begin
      Result := fRetNomLocFisica(strCodCad);
    End;

    If blnValidar And fEmptyStr(Result) Then
    Begin
      pMensagemOk('Código não encontrado!');
      blnErro := True;
    End;

  End;

End;

procedure TfrmAltPrecoGlobal.cdsAltGloBeforePost(DataSet: TDataSet);
  Var
    strDescri: String;
    blnErro: Boolean;
begin
  inherited;

  With DataSet Do
  Begin
    If (Not FieldByName('ITE_VALCAM').IsNull) And
       (FieldByName('ITE_ALTERA').AsString = 'N') And
       (((Not AnsiStartsText('cxeMemo', FieldByName('ITE_PROPER').AsString)) And
         (Not AnsiStartsText('cxeString', FieldByName('ITE_PROPER').AsString))) Or
        (Not fEmptyStr(FieldByName('ITE_VALCAM').AsString)) ) Then
    Begin
      FieldByName('ITE_ALTERA').AsString := 'S';
    End;

    If (FieldByName('ITE_VALCAM').IsNull) And
       (FieldByName('ITE_ALTERA').AsString = 'S') And
       (Not AnsiStartsText('cmb', FieldByName('ITE_PROPER').AsString)) Then
    Begin

    End;

    If blnAltFornecedor And
       (Pos(FieldByName('ITE_NOMCAM').AsString,
              'ITE_PRECOM_ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_' +
              'ITE_DESF05_ITE_DESF06_ITE_ICMENT_ITE_SUBFED_ITE_IPIENT_' +
              'ITE_FREENT_ITE_VALFRE_ITE_ACRFIN_ITE_SUBSTI_ITE_DESADB_' +
              'ITE_OUTVAL_ITE_ICMSAI_ITE_IMPFED_ITE_DESOPE_ITE_PREDOL_' +
              'ITE_UNICOM_ITE_MLTCOM_ITE_CODABF_' +
              'ITE_TCIFCU_ITE_TSCUST_ITE_DEPICO_ITE_DEICMS_ITE_FATREG_' +
              'ITE_DIAFOR_ITE_CLAIPI_ITE_CODFAB_ITE_DESFAB_ITE_CODFOR') > 0) Then
    Begin
      FieldByName('ITE_ALTERA').AsString := 'S';
      Exit;
    End;

    If FieldByName('ITE_VALCAM').IsNull And (Not blnAltPorNota) Then
      FieldByName('ITE_ALTERA').AsString := 'N';

    If FieldByName('ITE_VALCAM').IsNull Or fEmptyStr(FieldByName('ITE_VALCAM').AsString) Then
    Begin

      FieldByName('ITE_DESCRI').Clear;

      If (Not blnAltPorNota) And (fTemConsultaTabela(FieldByName('ITE_NOMCAM').AsString) Or
         (Pos('CHAR', FieldByName('ITE_TIPCAM').AsString) = 0)) Then
      Begin
        FieldByName('ITE_ALTERA').AsString := 'N';
        FieldByName('ITE_VALCAM').Clear;
      End;

    End

    Else If (Pos(FieldByName('ITE_NOMCAM').AsString, 'ITE_LOCFIS_ITE_LOCSUP') > 0) And
       (Not fEmptyStr(FieldByName('ITE_VALCAM').AsString)) Then
    Begin
      If blnCadLoc Then
      Begin
        strDescri := fRetDescricaoCadastro(FieldByName('ITE_VALCAM').AsString, False, blnErro);

        If fEmptyStr(strDescri) Then
        Begin

          FieldByName('ITE_VALCAM').Clear;
          FieldByName('ITE_DESCRI').Clear;
          FieldByName('ITE_ALTERA').AsString := 'N';

        End;
        FieldByName('ITE_DESCRI').AsString := strDescri;
      End;
    End

    Else If fTemConsultaTabela(FieldByName('ITE_NOMCAM').AsString) Then
    Begin
      If Not (Pos(FieldByName('ITE_NOMCAM').AsString, 'ITE_LOCFIS_ITE_LOCSUP') > 0 ) Then
        FieldByName('ITE_VALCAM').AsString := fStrZero(FieldByName('ITE_VALCAM').AsString, FieldByName('ITE_LIMCAM').AsInteger);

      strDescri := fRetDescricaoCadastro(FieldByName('ITE_VALCAM').AsString, False, blnErro);

      If fEmptyStr(strDescri) Then
      Begin

        FieldByName('ITE_VALCAM').Clear;
        FieldByName('ITE_DESCRI').Clear;

      End

      Else FieldByName('ITE_DESCRI').AsString := strDescri;

    End;

    If (Pos(FieldByName('ITE_NOMCAM').AsString, 'ITE_EXCIPI_') > 0) And
       (Not fEmptyStr(FieldByName('ITE_VALCAM').AsString)) Then
    Begin
      FieldByName('ITE_VALCAM').AsString :=  AnsiReplaceStr(FieldByName('ITE_VALCAM').AsString, ',', '');
      FieldByName('ITE_VALCAM').AsString := fStrZero(FieldByName('ITE_VALCAM').AsString, FieldByName('ITE_LIMCAM').AsInteger);
    End;
  End;
end;

procedure TfrmAltPrecoGlobal.chkArrMaiClick(Sender: TObject);
begin
  inherited;
  edtDecUni.Enabled := chkArrMai.Checked;

  If Not edtDecUni.Enabled Then
    edtDecUni.Text := '0';

end;

procedure TfrmAltPrecoGlobal.chkNotEntClick(Sender: TObject);
begin
  inherited;

  pHabilitaNotaEntrada(chkNotEnt.Checked);

end;

procedure TfrmAltPrecoGlobal.cxBtnMontadoraPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  inherited;
  cxvTiposAlt.DataController.DataSet.Edit;
  cxvTiposAlt.DataController.DataSet.FieldByName('ITE_VALCAM').AsString :=
     TfrmSelMontadoras.fSelecionaMontadoras('',
                                            cxvTiposAlt.DataController.DataSet.FieldByName('ITE_VALCAM').AsString);
  cxvTiposAlt.DataController.DataSet.Post;

end;

procedure TfrmAltPrecoGlobal.cxeClassfIPIPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If Length(DisplayValue) <> MAX_CLAIPI Then
    Begin
      Error := True;
      ErrorText := '';
      fMensagem('', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&OK']);
    End;

  End;

end;

procedure TfrmAltPrecoGlobal.cxeConsTam2PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodigo: String;
begin
  inherited;

  strCodigo := DisplayValue;

  If (Not fEmptyStr(strCodigo)) And (TcxTextEdit(Sender).Properties.MaxLength > 0) Then
    DisplayValue := fStrZero(strCodigo, TcxTextEdit(Sender).Properties.MaxLength);

  fRetDescricaoCadastro(DisplayValue, True, Error);

  If Error Then
    ErrorText := '';
end;

procedure TfrmAltPrecoGlobal.cxeDatePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_DTAVAL') > 0) And
       (StrToDate(DisplayValue) < VS_DATE) Then
    Begin
      Error := True;
      ErrorText := '';
      fMensagem('','Data da Validade de Preço precisa ser maior ou igual a data atual!',['&OK']);
    End;

  End;

end;

procedure TfrmAltPrecoGlobal.cxeMasFatPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    blnfStrToFloat: Boolean;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  try
    blnfStrToFloat := true;
    fStrToFloat(DisplayValue);
  except
    on EConvertError do
      blnfStrToFloat := false;
  end;

  If not blnfStrToFloat Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
           'ITE_PRECOM_ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7_' +
           'ITE_MINTB1_ITE_MINTB2_ITE_MINTB3_ITE_MINTB4_ITE_MINTB5_ITE_MINTB6_ITE_MINTB7_ITE_EMBALA_') > 0 Then
    Begin

      If (enuCalculo = tcFator) Then
      Begin
        If (Int(fStrToFloat(DisplayValue)) > 1) Then
        Begin
          Error := True;
          ErrorText := '';
        End;
      End;

    End;

  End;

end;

procedure TfrmAltPrecoGlobal.cxeMasIntPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    intValor: Integer;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  If Not TryStrToInt(DisplayValue, intValor) Then
  Begin
    Error := True;
    ErrorText := '';
  End

  Else If Not fValidaValor(DisplayValue) Then
  Begin
    Error := True;
    ErrorText := '';
  End;

end;

Function TfrmAltPrecoGlobal.fValidaValor(strValor: String): Boolean;
Begin

  Result := True;

  If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_FATUTR') > 0) And
     (fStrToFloat(strValor) <= 0) Then
  Begin
    Result := False;
    pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve se maior que zero!');
  End

 (* Else If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
          'ITE_IPISAI-ITE_FATCMP-ITE_DIAFOR-ITE_PRAMIN-ITE_TMPGAR-ITE_MESGIR-ITE_PRAVAL_' +
          'ITE_VLCFRE-ITE_DENSID-ITE_LARVID-ITE_ALTVID-ITE_LAMAVI-ITE_ALMAVI') > 0) And
          (fStrToFloat(strValor) < 0) Then *)

  Else If (Pos('MARBR', cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) = 0) And
          (fStrToFloat(strValor) < 0) Then
  Begin
    Result := False;

    pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve se maior ou igual a zero!');
  End;

End;

function TfrmAltPrecoGlobal.fVerificaClaIpi: Boolean;
var strFilter: String;
    blnFiltered: boolean;
begin
  Result := True;
  strFilter := '';
  blnFiltered := False;
  strFilter := cdsAltGlo.Filter;
  If cdsAltGlo.Filtered Then
    blnFiltered := True;

  Try
    cdsAltGlo.DisableControls;
    cdsAltGlo.Filter := 'ITE_ALTERA = ' + QuotedStr('S') + ' AND ITE_NOMCAM = ' + QuotedStr('ITE_CLAIPI');
    cdsAltGlo.Filtered := True;
    If cdsAltGlo.IsEmpty Then
      Exit;

    If cdsAltGlo.FieldByName('ITE_VALCAM').AsString = ''  Then
    Begin
      Result := false;
      fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ser informado!', ['&Ok']);
    End;
  Finally
    cdsAltGlo.Filtered := False;
    cdsAltGlo.Filter := strFilter;
    If blnFiltered Then
      cdsAltGlo.Filtered := True;
    cdsAltGlo.EnableControls;
  End;

end;

procedure TfrmAltPrecoGlobal.cxeMasPerPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    blnfStrToFloat: Boolean;
begin
  inherited;

  If fEmptyStr(DisplayValue) Then
    Exit;

  try
    blnfStrToFloat := true;
    fStrToFloat(DisplayValue);
  except
    on EConvertError do
      blnfStrToFloat := false;
  end;

  If Not blnfStrToFloat Then
  Begin
    Error := True;
    ErrorText := '';
  End Else
  Begin

    If Not fValidaValor(DisplayValue) Then
    Begin
      Error := True;
      ErrorText := '';
    End

    Else If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString,
            'ITE_PER_CI-ITE_PIMPTC-ITE_COMDIG-ITE_IMPFED-ITE_DESSIT-ITE_DESOPE-ITE_PORPES') > 0) And
            (Not fValidaEscala(DisplayValue, 0, 100)) Then
    Begin
      Error := True;
      ErrorText := '';

      pMensagemOk('O ' + cdsAltGlo.FieldByName('ITE_DESCAM').AsString + ' deve estar entre 0 e 100!');
    End;

  End;

end;

procedure TfrmAltPrecoGlobal.cxeString03PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fEmptyStr(DisplayValue) Then
  Begin

    If (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_EXCIPI') > 0) And
       (StrToIntDef(DisplayValue, -1) <= 0) Or
       (StrToIntDef(DisplayValue, -1) > 11) Then
    Begin
      fMensagem('', 'O campo EX IPI deve ser (vazio) ou estar na faixa de 1 até 11!', ['&OK']);
      Error := True;
      ErrorText := '';
    End;

 End;

end;

procedure TfrmAltPrecoGlobal.cxvTiposAltALTERAPropertiesChange(Sender: TObject);
begin
  inherited;

  If cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'N' Then
  Begin
    If cdsAltGlo.State <> dsEdit Then
      cdsAltGlo.Edit;

    cdsAltGlo.FieldByName('ITE_VALCAM').Clear;

    cdsAltGlo.Post;

  End Else
  Begin

    cxvTiposAltVALCAM.Focused := True;

  End;

end;

procedure TfrmAltPrecoGlobal.cxvTiposAltDataControllerFilterChanged(
  Sender: TObject);
  var
  I: Integer;
  S: string;
begin
  inherited;

  If cxvTiposAlt.ViewData.FilterRow.Focused then
  begin
    for I := 0 to cxvTiposAlt.ColumnCount - 1 do
    begin
      S := VarToStr(cxvTiposAlt.ViewData.FilterRow.Values[I]);
      if (Length(S)> 0) and (S[1] <> '%') then
        cxvTiposAlt.ViewData.FilterRow.Values[I] := '%' + S;
    end;
  end;
  strFiltro := cxvTiposAlt.DataController.Filter.FilterText;
end;


procedure TfrmAltPrecoGlobal.cxvTiposAltDESCAMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := Copy(AText, 1, pos('|', AText) -1);
end;

procedure TfrmAltPrecoGlobal.cxvTiposAltDESCAMStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If (ARecord.Values[cxvTiposAltALTERA.Index] <> Null) And
      (VarToString(ARecord.Values[cxvTiposAltALTERA.Index]) = 'S') Then
    AStyle := cxsAltera;

end;

(*
procedure TfrmAltPrecoGlobal.pSalvaDados(strValCam, strDescri: String);
Begin
  If cdsAltGlo.State <> dsEdit Then
     cdsAltGlo.Edit;

  cdsAltGlo.FieldByName('ITE_ALTERA').AsString := 'S';
  cdsAltGlo.FieldByName('ITE_VALCAM').AsString := strValCam;
  cdsAltGlo.FieldByName('ITE_DESCRI').AsString := strDescri;

  cdsAltGlo.Post;
End;
*)

procedure TfrmAltPrecoGlobal.cxvTiposAltEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  cxvTiposAltKeyPress(Sender, Key);
end;

procedure TfrmAltPrecoGlobal.cxvTiposAltKeyPress(Sender: TObject;
  var Key: Char);
 Var
    arrSelecao: TConsultasArray;
    qryDados: TUniQuery;

  Procedure pSalva(strDado: String);
  Begin
    Key := #0;
    cdsAltGlo.Edit;
    cdsAltGlo.FieldByName('ITE_VALCAM').AsString := strDado;
    //AEdit.EditValue := strDado;
    //AEdit.PostEditValue;
    Key := #0;

    Keybd_Event(VK_RETURN, 0, 0, 0);
  End;

begin
  inherited;

  If blnVidroInteiro And
     (Pos(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_LARVID_ITE_ALTVID_ITE_LAMAVI_ITE_ALMAVI') > 0) And
     CharInSet(Key, [',','.','-']) Then
  Begin
    Key := #0;
    Exit;
  End;

  If fEntraCons(Key) And
     fTemConsultaTabela(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString) Then
  Begin

    qryDados := fCriaQuery;

    If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODFOR') And
       fPesqFornecedor(conForSimples, Self, Nil, Nil, qryDados, Key, arrSelecao, True) And
       (Not fEmptyStr(qryDados.FieldByName('FOR_CODFOR').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('FOR_CODFOR').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPR') And
            fPesqGrupoPrecos(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GPR_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GPR_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_PRDGRU') And
            fPesqGrupoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('PRD_CODGRU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('PRD_CODGRU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODABF') And
            fPesqAbrevFiscal(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('ABF_CODABF').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('ABF_CODABF').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFPIS') And
            fPesqPISSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFCOF') And
            fPesqCOFSAI(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End


    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_ABFIPI') And
            fPesqIPISAI(Self, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('APC_CODAPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('APC_CODAPC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMAR') And
            fPesqMarcas(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('MAR_CODMAR').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('MAR_CODMAR').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') And
            fPesqSituacaoProduto(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('SIT_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODMON') And
            fPesqMontadora(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('MON_CODMON').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('MON_CODMON').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODUNI') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODCOM') And
            fPesqComposicao(Self, Nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GCO_CODCOM').AsString)) Then
    Begin
      pSalva(qryDados.FieldByName('GCO_CODCOM').AsString);
    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_UNICOM') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_UNITRI') And
            fPesqUnidade(Self, Nil, nil, nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('UNI_CODUNI').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('UNI_CODUNI').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGRU') And
            fPesqGrupo(Self, Nil, nil, qryDados, Key, arrSelecao, False, False, True) And
            (Not fEmptyStr(qryDados.FieldByName('GRU_CODGRU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GRU_CODGRU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDEP') And
            fPesqDepartamento(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('DEP_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('DEP_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_GRUCMP') And
            fPesqGrupoCompra(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GRU_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GRU_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODONU') And
            fPesqClassificacaoOnu(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('ONU_CODONU').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('ONU_CODONU').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODDIC') And
            fPesqDic(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('DIC_CODDIC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('DIC_CODDIC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODLSE') And
            fPesqLocSep(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('LSE_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('LSE_CODIGO').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CDCEST') And
            fPesqCest(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('CES_CDCEST').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_SITPRO') And
            fPesqSituacaoProduto(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('SIT_CODIGO').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('CES_CDCEST').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODGPC') And
            fPesqGPC(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('GPC_CODGPC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('GPC_CODGPC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_EMPCAR') And
            fPesqEmpresa(conEmpSimples, Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('EMP_CODEMP').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('EMP_CODEMP').AsString);

    End

    Else if SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_CODATC') Then
    begin
      if fPesqAssistenciaTecnica(Self,  Nil, Nil, Nil, QryDados, Key, arrSelecao) then
      begin
        if Assigned(qryDados.FindField('ATC_CODIGO')) then
          pSalva(qryDados.FieldByName('ATC_CODIGO').AsString);
      end;
    end

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_EMPSUG') And
            fPesqEmpresa(conEmpSimples, Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('EMP_CODEMP').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('EMP_CODEMP').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_LOCFIS') And
            fPesqLocFisica(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('LOC_CODLOC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('LOC_CODLOC').AsString);

    End

    Else If SameText(cdsAltGlo.FieldByName('ITE_NOMCAM').AsString, 'ITE_LOCSUP') And
            fPesqLocFisica(Self, Nil, Nil, qryDados, Key, arrSelecao) And
            (Not fEmptyStr(qryDados.FieldByName('LOC_CODLOC').AsString)) Then
    Begin

      pSalva(qryDados.FieldByName('LOC_CODLOC').AsString);

    End;

    FreeAndNil(qryDados);
  End;
end;

function TfrmAltPrecoGlobal.fTemConsultaTabela(strNomCam: String): Boolean;
var
  strFields: String;
Begin
  strFields := 'ITE_CODFOR_ITE_CODGPR_ITE_PRDGRU_ITE_CODABF_ITE_ABFPIS_ITE_ABFCOF_ITE_ABFIPI_' +
               'ITE_CODMAR_ITE_NOMCAM_ITE_CODUNI_ITE_UNICOM_ITE_UNITRI_ITE_CODGRU_' +
               'ITE_CODDEP_ITE_GRUCMP_ITE_CODONU_ITE_CODDIC_ITE_CODLSE_ITE_CDCEST_ITE_SITPRO_' +
               'ITE_CODGPC_ITE_EMPCAR_ITE_CODCOM_ITE_EMPSUG_ITE_CODATC_';

  If blnCadLoc Then
    strFields := strFields + 'ITE_LOCFIS_ITE_LOCSUP';

  Result := Pos(strNomCam, strFields) > 0;
End;

procedure TfrmAltPrecoGlobal.cxvTiposAltVALCAMGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;

  If Not (Assigned(ARecord)) Then
    Exit;

  If fEmptyStr(AText) Then
    Exit;

  If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasFat') Then
    AText := FormatFloat(strMasFat, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDecUni') Then
    AText := FormatFloat(strMasDecUni, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDec05') Then
    AText := FormatFloat(strMasDec05, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDec06') Then
    AText := FormatFloat(strMasDec06, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasPer') Then
    AText := FormatFloat(strMasPer, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasMar') Then
    AText := FormatFloat(strMasMar, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasMBr') Then
    AText := FormatFloat(strMasMBr, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasVal') Then
    AText := FormatFloat(strMasVal, fStrToFloat(AText))

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeMasInt') Then
    AText := FormatFloat(strMasInt, fStrToFloat(AText))

  Else If fTemConsultaTabela(VarToString(ARecord.Values[cxvTiposAltNOMCAM.Index])) And
          (Not fEmptyStr(AText)) Then
    AText := AText + ' - ' + VarToString(ARecord.Values[cxvTiposAltDESCRI.Index])

  Else If SameText(VarToString(ARecord.Values[cxvTiposAltPROPER.Index]), 'cxeDecQtd') Then
    AText := FormatFloat(strMasDecQtd, fStrToFloat(AText));

end;

procedure TfrmAltPrecoGlobal.cxvTiposAltVALCAMGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    intIdx: Integer;
begin
  inherited;


  If Not (Assigned(ARecord)) Then
    Exit;

  intIdx := cxvTiposAltPROPER.Index;

  If (ARecord.Values[intIdx] <> Null) Then
    pRetProperties(VarToString(ARecord.Values[intIdx]), AProperties);

end;

procedure TfrmAltPrecoGlobal.cxvTiposAltVALCAMStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;


  If Not (Assigned(ARecord)) Then
    Exit;

  If (ARecord.Values[cxvTiposAltPROPER.Index] <> Null) And
     AnsiStartsStr ('cmb', VarToString(ARecord.Values[cxvTiposAltPROPER.Index])) Then
    AStyle := cxsCombo

  Else If fTemConsultaTabela(VarToString(ARecord.Values[cxvTiposAltNOMCAM.Index])) Then
    AStyle := cxsConsulta;

end;

procedure TfrmAltPrecoGlobal.dtsAltGloDataChange(Sender: TObject; Field: TField);
begin

  If not fCfgSis('USA_PF', varBoolean) Then
    Exit;

  If Assigned(cdsAltGlo.FindField('ITE_NOMCAM')) And (cdsAltGlo.FieldByName('ITE_NOMCAM').AsString = 'ITE_USAPPF') Then
    btnPrecoPautaFiscal.Visible := (cdsAltGlo.FieldByName('ITE_VALCAM').AsString = 'S');

  inherited;
end;

procedure TfrmAltPrecoGlobal.pCarregaPrecoPautaFiscal;
var
  intEstado: Integer;
begin
  cdsPrecoPautaFiscal.EmptyDataSet;

  Try
    For intEstado := Low(ESTADOS) To High(ESTADOS) Do
    Begin
      If (ESTADOS[intEstado] = 'PY') Or (ESTADOS[intEstado] = 'EX') Then
        Continue;

      cdsPrecoPautaFiscal.Append;
      cdsPrecoPautaFiscal.FieldByName('PPF_ESTADO').AsString := String(ESTADOS[intEstado]);
      cdsPrecoPautaFiscal.FieldByName('PPF_VLRPPF').AsFloat  := 0;
      cdsPrecoPautaFiscal.FieldByName('PPF_DTAINI').Clear;
      cdsPrecoPautaFiscal.FieldByName('PPF_DTAFIN').Clear;
      cdsPrecoPautaFiscal.Post;
    End;

  Finally
    cdsPrecoPautaFiscal.First;
  End;
end;

procedure TfrmAltPrecoGlobal.btnPrecoPautaFiscalClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin
  If cdsPrecoPautaFiscal.IsEmpty Then
    pCarregaPrecoPautaFiscal;

  pCriarFormularios(TfrmAltPrecoGlobalPrecoPautaFiscal, frmAltPrecoGlobalPrecoPautaFiscal);

  Try
    frmAltPrecoGlobalPrecoPautaFiscal.dtsPrecoPautaFiscal.DataSet := cdsPrecoPautaFiscal;
    frmAltPrecoGlobalPrecoPautaFiscal.ShowModal;

    blnConfirma := frmAltPrecoGlobalPrecoPautaFiscal.ModalResult = mrOk;

    If not blnConfirma Then
      cdsPrecoPautaFiscal.EmptyDataSet;

  Finally
    FreeAndNil(frmAltPrecoGlobalPrecoPautaFiscal);
  End;
end;

procedure TfrmAltPrecoGlobal.pRetProperties(strNomProp: String; var AProperties: TcxCustomEditProperties);
Begin
  If Assigned(FindComponent(strNomProp)) Then
    AProperties := TcxEditRepositoryItem(FindComponent(strNomProp)).Properties;
End;

function TfrmAltPrecoGlobal.fRetDesAbfPisCofIpi(strTabela, strCod: String): String;
  Var
    qryAbf: TUniQuery;
begin
  qryAbf := fCriaQuery(Self);
  qryAbf.SQL.Add('SELECT APC_DESCRI FROM ' + strTabela +  ' WHERE APC_CODAPC = :CODAPC');
  qryAbf.ParamByName('CODAPC').AsString := strCod;
  qryAbf.Open;

  Result := qryAbf.FieldByName('APC_DESCRI').AsString;

  FreeAndNil(qryAbf);
end;

(*
procedure TfrmAltPrecoGlobal.pCDCESTKeyPress;
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqCest(Self, edtCamAlt, Nil, Nil, chrKey, arrSel) Then
  Begin
    If fValidaCampos(edtCamAlt, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;
*)


function TfrmAltPrecoGlobal.fAtualizaSaldoDisponivel(pgbStatus: TcxProgressBar = Nil): Boolean;
  procedure pInformacao(strMsg: String);
  begin
    If Assigned(pgbStatus) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMsg;
    Application.ProcessMessages;
  end;

  procedure pProgress(intPos, intMax: Integer);
  Begin
    If Assigned(pgbStatus) Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := intPos;
      Application.ProcessMessages;
    End;
  End;

  function fGetSaldoDisponivel(strCodIte: String): Double;
    Var
      blnPedCorte: Boolean;
      fltSalRes,
      fltSalReG,
      fltSalExt,
      fltSalReOP,
      fltCnv_Ml: Double;
  Begin
    Result := 0;
    blnPedCorte := False;

    If (cdsIteGlo.FindField('ITE_CNV_ML') <> Nil) And (cdsIteGlo.FindField('ITE_SAL_ML') <> Nil) Then
    Begin
      fltCnv_Ml  := IIF(cdsIteGlo.FindField('ITE_CNV_ML').AsFloat <= 0, 1, cdsIteGlo.FindField('ITE_CNV_ML').AsFloat);
      fltSalRes  := TSaldoReservado.New(
                      TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(strCodIte)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsPedidoVenda)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(Not blnPedCorte)
                      ).fGetQuantidade();

      fltSalReG  := TSaldoReservado.New(
                      TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(strCodIte)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsGarantia)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(Not blnPedCorte)
                      ).fGetQuantidade();

      fltSalExt  := TSaldoReservado.New(
                      TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(strCodIte)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsExterno)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(Not blnPedCorte)
                      ).fGetQuantidade();

      If (fCfgSis('MOVFUL', varString) = '2') Then
        fltSalExt := 0;

      fltSalReOP := TSaldoReservado.New(
                      TReservaParametros.New()
                        .EmpresaItem(VS_strCodEmp)
                        .CodigoItem(strCodIte)
                        .CodEmpresa(VS_strCodEmp)
                        .TipoReserva(trsOrdemProducao)
                        .ConverterML(True)
                        .DesconsideraPedidosCorte(Not blnPedCorte)
                      ).fGetQuantidade();

      If fltCnv_Ml > 0 Then
        Result := (cdsIteGlo.FieldByName('SaldoNumerico').AsFloat) +
                   cdsIteGlo.FieldByName('ITE_SAL_ML').AsFloat - fltSalRes - fltSalReG - fltSalReOP - fltSalExt
      Else
        Result := cdsIteGlo.FieldByName('SaldoNumerico').AsFloat - fltSalRes - fltSalReG - fltSalReOP - fltSalExt;
    End
  End;
Begin
  Result := True;

  With cdsIteGlo Do
  Begin
    pInformacao('Calculando Saldo Disponível, Aguarde...');
    pProgress(0, RecordCount);

    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('ITE_SALDOS').AsFloat := fGetSaldoDisponivel(FieldByName('ITE_CODITE').AsString);
        Post;

        pProgress(RecNo, RecordCount);
        Next;
      End;
    End;
  End;
End;

procedure TfrmAltPrecoGlobal.edtAbfCofExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfCof, edtDesCof, arrAbfCof, fRetDesAbfCof, Nil, 'da abreviação de COFINS');
end;

procedure TfrmAltPrecoGlobal.edtAbfCofKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCofSai(Self, edtAbfCof, edtDesCof, Nil, Key, arrAbfCof, False) Then
  Begin
    If fValidaCampos(edtAbfCof, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAltPrecoGlobal.edtAbfPisExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtAbfPis, edtDesPis, arrAbfPis, fRetDesAbfPis, Nil, 'da abreviação de PIS');
end;

procedure TfrmAltPrecoGlobal.edtAbfPisKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPisSai(Self, edtAbfPis, edtDesPis, Nil, Key, arrAbfPis, False) Then
  Begin
    If fValidaCampos(edtCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAltPrecoGlobal.fValidaDescontoMaximoOperador(Dataset : TDataset) : Boolean;
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  Result := True;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(fltDESMAX);
    objValidaHierarquia.pSetVendedorMaster(fltDESMVM);
    objValidaHierarquia.pSetSubGerenJunior(fltDESMSU);
    objValidaHierarquia.pSetSubGerenMaster(fltDESMSM);
    objValidaHierarquia.pSetGerente_Junior(fltDESMGE);
    objValidaHierarquia.pSetGerente_Master(fltDESMGM);

    recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Result := False;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

End;

function TfrmAltPrecoGlobal.fValidaMargemMinimaOperador(Dataset : TDataset) : Boolean;
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  Result := True;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(fltMARMIN);
    objValidaHierarquia.pSetVendedorMaster(fltMARMMV);
    objValidaHierarquia.pSetSubGerenJunior(fltMARMSG);
    objValidaHierarquia.pSetSubGerenMaster(fltMARMMS);
    objValidaHierarquia.pSetGerente_Junior(fltMARMGE);
    objValidaHierarquia.pSetGerente_Master(fltMARMMG);

    recResultado := objValidaHierarquia.fValidarMargemMinimaOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Result := False;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

End;

function TfrmAltPrecoGlobal.fRetornaValorCampo(strNomCampo : String) : Double;
Begin
  If cdsAltGlo.Locate('ITE_NOMCAM',strNomCampo,[]) Then
  Begin
    If cdsAltGlo.FieldByName('ITE_VALCAM').Value <> null Then
      Result := cdsAltGlo.FieldByName('ITE_VALCAM').Value
    Else
      Result := 0.00;
  End
  Else
    Result := 0.00;
End;

procedure TfrmAltPrecoGlobal.pAlimentarVariaveisDescontoMax;
Begin
  fltDESMAX := fRetornaValorCampo('ITE_DESMAX');
  fltDESMVM := fRetornaValorCampo('ITE_DESMVM');
  fltDESMSU := fRetornaValorCampo('ITE_DESMSU');
  fltDESMSM := fRetornaValorCampo('ITE_DESMSM');
  fltDESMGE := fRetornaValorCampo('ITE_DESMGE');
  fltDESMGM := fRetornaValorCampo('ITE_DESMGM');
End;

procedure TfrmAltPrecoGlobal.pAlimentarVariaveisMargemMin;
Begin
  fltMARMIN := fRetornaValorCampo('ITE_MARMIN');
  fltMARMMV := fRetornaValorCampo('ITE_MARMMV');
  fltMARMSG := fRetornaValorCampo('ITE_MARMSG');
  fltMARMMS := fRetornaValorCampo('ITE_MARMMS');
  fltMARMGE := fRetornaValorCampo('ITE_MARMGE');
  fltMARMMG := fRetornaValorCampo('ITE_MARMMG');
End;

function TfrmAltPrecoGlobal.fCalcularValor(varValAtu, varValorRegAtual: Variant): Currency;
Var
  curValor1,
  curValor2: Currency;
Begin
  Result := 0;
  curValor1 := VarToStrDef(varValAtu,'0').ToDouble;
  curValor2 := VarToStrDef(varValorRegAtual,'0').ToDouble;
  case enuCalculo of
    tcFator: Result := curValor1 * curValor2;
    tcSomar: Result := curValor1 + curValor2;
  end;
End;

function TfrmAltPrecoGlobal.fValidaLocalizacaoFisica(AStrFieldName: String): Boolean;
var
  strLocFis,
  strTraLoc,
  strItem,
  strCodIte,
  strLote,
  strDesIte,
  strFilterBkp,
  strDesCam: String;
  fltSalLot,
  fltSalLotML:Double;
  objCadLot: TCadLot;
  objLocFis: TLocFisAdicionais;
  blnFiltered: Boolean;
begin
  Result := True;

  blnFiltered := cdsAltGlo.Filtered;
  If blnFiltered Then
    strFilterBkp := cdsAltGlo.Filter;

  cdsAltGlo.Filtered := False;
  cdsAltGlo.Filter := 'ITE_NOMCAM = ' + QuotedStr(AStrFieldName);
  cdsAltGlo.Filtered := True;

  Try
    If ((Not cdsAltGlo.IsEmpty) And (cdsAltGlo.FieldByName('ITE_ALTERA').AsString = 'S')) Then
    Begin
      strLocFis := cdsAltGlo.FieldByName('ITE_VALCAM').AsString;
      strTraLoc := fCfgSis('TRALOC');
      strDesCam := IIF(AStrFieldName = 'ITE_LOCFIS', 'Localização Física', 'Localização Física Super Estoque');
      objCadLot := TCadLot.Create(Self);
      objLocFis := TLocFisAdicionais.Create(Self);
      objLocFis.fCarregaLocalizacoes('', '');

      If Not blnCadLoc Then
        Exit(True);

      If (Not fEmptyStr(strLocFis)) Then
      Begin
        If fEmptyStr(fRetNomLocFisica(strLocFis)) Then
        Begin
          pMensagemOk('Localização Física não encontrada!');
          Result := False;
        End;

        If (strTraLoc <> 'N') And (Result) Then
        Begin

          If objCadLot.fTemProdutoComLocFisica(strLocFis, strItem, fltSalLot, fltSalLotML, strCodIte) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa ' +strDesCam + '!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemProdutoComLocAdicional(strLocFis, strItem, fltSalLot, fltSalLotML, strCodIte) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' já está cadastrado com essa '+ strDesCam +' adicional!');
            If (strTraLoc = 'T') Then
              Result := False;
          End

          Else If objCadLot.fTemLoteComLocFisica(strLocFis, strItem, strLote, fltSalLot, fltSalLotML) Then
          Begin
            pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                        ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa ' + strDesCam + '!');
            If (strTraLoc = 'T') Then
              Result := False;
          End;

        End;
      End;

      If Not fEmptyStr(strLocFis) Then
      Begin

        strDesIte := fLocFisUtilizadaEmAlgumItem(strLocFis);

        If (Not fEmptyStr(strDesIte)) And (strTraLoc <> 'N') And (AStrFieldName = 'ITE_LOCFIS') Then
        Begin
          fMensagem('ATENÇÃO!', 'Localização física utilizada no produto: ' + #13 + strDesIte, ['&Ok']);
          If (strTraLoc = 'T') Then
            Result := False;
        End;

      End;

      If Result And (Not fEmptyStr(strLocFis)) And (AStrFieldName = 'ITE_LOCFIS') And
       objLocFis.fTemLocalizacaoAdicional(strLocFis) Then
      Begin
        pMensagemOk('A Localização Física ' + strLocFis + ' já está cadastrada em Localizações Físicas Adicionais!');
        Result := False;
      End;
    End;
  Finally
    If Assigned(objCadLot) Then
      FreeAndNil(objCadLot);
    If Assigned(objLocFis) Then
      FreeAndNil(objLocFis);

    cdsAltGlo.Filter := '';
    cdsAltGlo.Filtered := False;
    If blnFiltered Then
    Begin
      cdsAltGlo.Filter := strFilterBkp;
      cdsAltGlo.Filtered := True;
    End;
  End;
end;

end.



