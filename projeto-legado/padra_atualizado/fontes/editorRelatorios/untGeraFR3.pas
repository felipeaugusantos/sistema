unit untGeraFR3;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, Printers, Graphics,
  frxClass, frxDBSet, frxDesgn, frxDMPExport,
  Uni, DB, untFuncoesSimples, untRelFrx, frxDMPClass,
  frxBarCod, frxBarCode, frxBarCode2D,
  cxGridDBChartView, CxGrid, ExtCtrls,
  untConsultasRel, fs_iinterpreter,
  untFuncoesGenerica, untGravando,
  untFuncEditorRel, untZClient, Math, Dialogs,
  UniClientDataSet, untSpoolImpressao, cxProgressBar;

type
  TPaginaMatricial = (pag51, pag80, pag96, pag137, pag160);

  TTitulosRelatorio    = Array Of String;
  TSubTitulosRelatorio    = Array Of String;

  TArrTotaisRodape = Array Of Double;

  TArrEnvioPDFGatilho = Array of Record
    strNumWpp,
    strEmail,
    strAssunto,
    strCorpo,
    strJSonWhatsApp: String;
  End;

Const
  FOLHA_CUSTOM = 256;

  COLUNAS_MAT:   Array[pag51..pag160] Of Integer = (50, 79, 95, 136, 159);
  WIDTH_MAT    : Array[pag51..pag160] Of Double  = (126.99991797922, 203.199868766751, 256.539834318024, 347.979775263062, 406.399737533503);
  FORMATO_MAT  : Array[pag51..pag160] Of String  = ('#27#64#18#27#80#15#27#80',
                                                    '#27#64#18#27#80#18#27#80',
                                                    '#27#64#18#27#80#18#27#77',
                                                    '#27#64#18#27#80#15#27#80',
                                                    '#27#64#18#27#80#15#27#77');
  FORMATO_MAT_MEIA  : Array[pag51..pag160] Of String  = ('#27#64#18#27#80#27#15#27#48#27#67#44',
                                                         '#27#64#18#27#80#27#48#27#67#44',
                                                         '#27#64#18#27#80#27#77#27#48#27#67#44',
                                                         '#27#64#18#27#80#27#15#27#48#27#67#44',
                                                         '#27#64#18#27#80#27#77#27#15#27#48#27#67#44');
type
  TGeraFR3 = class(TComponent)
    private
      FPais: TPais;

      dlgOpen: TOpenDialog;

      FTitulosRelatorio: TTitulosRelatorio;
      FSubTitulosRelatorio: TSubTitulosRelatorio;

      FarrLeftsFolhas: Array of Record
        intEsquerda,
        intDireita: Integer;
      End;

      FMaxCol: Integer;

      FPaperWidthOriginal: Double;

      FCadMod: TUniQuery;

      FCurrentTop: Double;

      FQtdQueBras: Integer;

      FSavArq: TSaveDialog;

      FstrSQL: String;

      FCarregouPagina: Boolean;

      FComple,
      FParams,
      FParamsAut,
      FCampos,
      FCamposExp: TZClient;

      FQuebras: TZClient;

      FCodMod: String;
      FPaper: Integer;

      FFatorScale: Double;

      FSplit: Boolean;

      FColunasMatricial: Integer;

      FOrientationOriginal,
      FOrientation : TPrinterOrientation;

      FConsulta: TConsultasRel;

      FArquivoSaidaDiretoPDF: string;

      FlistaArquivos,
      FListaPaginas: TStringList;

      FComplementoCabec: TStringList;

      FLeuDados,
      FJato: Boolean;
      FTituloRelatorio,
      FSubTituloRelatorio,
      FTipImp: String;

      FBase: TdtmRelFrx;

      FTotalGeral: TfrxCustomMemoView;

      FFrxModelo    : TfrxReport;
      FFrxReport    : TfrxReport;
      FFrxDotMatrix : TfrxDotMatrixExport;
      FFrxDataSet   : Array Of TFrxDBDataSet;
      FFrxDesign    : TfrxDesigner;

      frxPage       : TfrxReportPage;
      frxPageHeader : TfrxPageHeader;

      frxChildEmpresa,
      frxChildCodBar,
      frxChildPageHeader,
      frxChildComplementoCabec: TfrxChild;

      frxPaiTitulosColunas : TfrxComponent;

      frxHeader     : TfrxHeader;
      frxChildHeader: TfrxChild;

      frxMasterData : TfrxMasterData;
      frxFooter     : TfrxFooter;
      frxChildFooter: TfrxChild;
      frxPageFooter : TfrxPageFooter;

      FListaParFiltros,
      FTituloFiltros: TStringList;
      FCodRels: TStringList;

      FCadRel: TArrQuery;

      FControleRel: TArrControleRel;

      FDadosOrig,
      FDados,
      FDadosPersonalizado: TArrDataSet;

      FFiltros: TArrQuery;

      stlScriptInitialization: TStringList;

      fscScript: TfsScript;

      FDestino: TDestinoRel;

      class var FSeqMemo: Integer;

      procedure pOpenDialogShow(Sender: TObject);

      Procedure pLiberaComplementos;

      Function fPegaValorParametro(strNomPar: String; Var blnAchou: Boolean; blnTiraMascara: Boolean = True): String;

      Function fGetOrderBy(strSQL: String): String;
      Function fGetFontHeader: TFont;
      Function fAjustaCamposExpressao(strExpressao: String; blnTotGeral: Boolean; strNomCam: string; strQuebra: String): String;
      Function fPageName(intQuerie: Integer): String;
      Function fMasterDataName(intQuerie: Integer; strNomCam: string): String;
      Function fDataSetName(intQuerie: Integer): String;
      Function fColunasToPagMat(intColunas: Integer): TPaginaMatricial;
      Function fRetCampoRel(cdsCampo: TZClient; Var strFormatStr: String; blnTotal, blnFormataTitulo: Boolean): String;
      Function fAjutaFormatoCampo(strCampo: String): String;
      Function fMontaFuncaoAutCom(funFuncao: TFuncaoAutCom; cdsCampo: TZClient): String;
      Function fSQLQuebras: String;
      Function fCarregaModelo: Boolean;
      function fLoadModelo(qryCadMod: TUniQuery): Boolean;
      function fLoadRelatorio: Boolean;
      Function fCriaPagina: Boolean;
      Function fAjustaFolhaSemFim: Boolean;
      Function fCriaPageHeader(strNomCam: string): Boolean;
      Function fCriaChildEmpresa(strNomCam: string): Boolean;
      Function fCriaChildCodBar: Boolean;

      Procedure pCriaCodBarCabecalho;
      Function fTemCodBarCabecalho: Boolean;

      Procedure pCriaImagemCabecalho;

      Function pCriaDataSetVazio : TUniClientDataSet;

      Procedure pScriptTextPageHeaderEmpresa(frxComponent: TfrxComponent);
      Function fCriaChildPageHeader(strNomCam: string): Boolean;
      Function fCriaChildComplementoCabec(strNomCam: string): Boolean;
      Function fCriaHeader(strNomCam: string): Boolean;
      Function fCriaMasterData(strNomCam: string): Boolean;
      Function fCriaMasterDataVazio: Boolean;
      Procedure pBeforePrintQuebraPaginaSemFim(strNomComp: String);
      function fCriaGroupHeaders(strNomCam: string): Boolean;
      Function fCriaGroupFooters(strNomCam: string; blnApenasPrincipal: Boolean = False): Boolean;
      Function fCriaFooter(strNomCam: string): Boolean;
      Function fCriaChildFooter(strNomCam: string): Boolean;
      Function fCriaChildGroupFooter(frxGroupFooter: TfrxGroupFooter; frxUltimoChild: TfrxChild; strMensagem, strNomCam: String): Boolean;
      Function fCriaChildDadosGroupFooter(frxGroupFooter: TfrxGroupFooter; strNomCam: String): TfrxChild;
      Function fAlimentaSubreport(intContRel: Integer; strCodRel, strNomCam: string): TfrxReportPage;
      Function fCriaPageFooter(strNomCam: string): Boolean;
      Function fBuscaControleRel(intIndice: Integer; strCodRel, strNomCam: string; blnChild: Boolean): Integer;
      Function fAdicionaComplementos(blnApenasPrincipal: Boolean = False): Boolean;
      Function fIncTop: Double;
      Function fColunasToCommand(intColunas: Integer): String;
      Function fRetReportPage(frxReport: TfrxReport): TfrxReportPage;
      Function fRetPageHeader(frxReport: TfrxReport): TfrxPageHeader;
      Function fRetHeader(frxReport: TfrxReport): TfrxHeader;
      Function fRetMasterData(frxReport: TfrxReport; strNomMas: String = ''): TfrxMasterData;
      Function fRetGroupHeader(frxReport: TfrxReport): TfrxGroupHeader;
      Function fRetGroupFooter(frxReport: TfrxReport): TfrxGroupFooter;
      Function fRetFooter(frxReport: TfrxReport): TfrxFooter;
      Function fRetPageFooter(frxReport: TfrxReport): TfrxPageFooter;
      Function fCriaMemoView(Owner: TComponent): TfrxCustomMemoView;
      Function fCriaPictureView(Owner: TComponent): TfrxPictureView;
      Function fCriaCodeBar(Owner: TComponent): TfrxBarCodeView;
      Function fRetBarCode(strBarCod: String): TfrxBarcodeType;
      Procedure pMontaCodeBar(barDestino: TfrxBarCodeView; blnTestarAprove: Boolean; strNomeBanda: string = '');
      Function fCopiaMemoView(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; blnMinima: Boolean = True; strNomCam: string = ''): TfrxCustomMemoView;
      Function fCopiaShape(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; strNomCam: string): TfrxShapeView;
      Function fCopiaLine(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; strNomCam: string): TfrxCustomLineView;
      Function fNomeEmpresa: String;
      Function fSetaVariaveis: Boolean;
      Procedure pSetaVariaveisFR3Personalizado;
      Function fTemCampoTotal: Boolean;
      Function fRetEspacametoColunas: Double;
      Function fCriaBase(Var Base: TdtmRelFrx): TfrxReport;
      function fLoadReportComp(qryTabela: TUniQuery; {frxReport: TFrxReport;} intRelat: Integer; Var objRel: Pointer; blnChild, blnLeuDados: Boolean; strNomCam: string): Boolean;
      Function fDesVisibilidadeToTipo(strVisibilidade: String): TVisibilidade;
      Function fRetNomeParametro(strDesCam: String): String;
      Function fImprimeComplementosCabecalho: Boolean;

      Function fCallIIF(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;

      Function fGetComplemento(strNomVar: String): String;

      Procedure pMontaSeries(cxvGrafico: TcxGridDBChartView; cdsCampos: TZClient; intRelatorio: Integer);
      Procedure pMontaGraficoColunas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoColunasEmpilhadas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoBarras(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoBarrasEmpilhadas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoLinha(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoArea(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoAreaEmpilhada(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
      Procedure pMontaGraficoPie(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);

      Function fMontaGrafico: Boolean;

      Function fMontaGraficoDashboard: Boolean;

      Procedure pSetaComplementos;

      Procedure pSetaLimits;

      Procedure pScriptTextPageHeader;
      Procedure pScriptTextNroPag(strNomeComponente: string; strTipoRCPE: string);

      Procedure pCriaParametros(strNomCam: string);
      Procedure pCriaComplementos(strNomCam: string);
      Procedure pCarregaComplementos;

      Procedure pAjustaLeft(Var fltLeft: Double);

      Procedure pMontaTitulos(frxPai: TfrxComponent; blnQuebra: Boolean; strNomCam: string; blnHeader: Boolean);
      Procedure pMontaCampos(strNomeBanda: string = ''; strNomCam: string = '');
      Procedure pMontaCampo(mmoDestino: TfrxCustomMemoView; blnTestarAprove: Boolean; strNomeBanda: string = '');
      Procedure pMontaCampoPicture(mmoDestino: TfrxPictureView; blnTestarAprove: Boolean; strNomeBanda: string = '');
      Procedure pEliminaCamposVazios(arrCampos, arrFields, arrStretc: Array of string; arrAltura: Array of Double);
      Procedure pMontaTotais(frxPai: TfrxComponent; frxTotal: TfrxCustomMemoView; Var fltMenorLeft: Double; blnTotGeral: Boolean; strNomCam: string; strQuebra: String);
      Procedure pSetCampos(Value: TZClient);
      Procedure pAddFunction(frxReport: TfrxReport);
      Procedure pSetCodMod(Value: String);
      Procedure pSetOrientation(Value: TPrinterOrientation);
      Procedure pCopyComand(strNomeFonte: String; strComando: String; frxPai: TfrxComponent);
      Procedure pCopyMemoView(mmofonte, mmodestino: TfrxCustomMemoView; strName, strText, strNomCam: String);
      Procedure pCopyShape(mmofonte, mmodestino: TfrxShapeView; strName, strNomCam: String);
      Procedure pCopyLine(mmofonte, mmodestino: TfrxCustomLineView; strName, strNomCam: String);
      Procedure pSetaAlturaComponente(frxComp: TfrxComponent; fltAltura: Double; blnMinima: Boolean);
      Procedure pFormataDecimais(mmoCampo: TfrxCustomMemoView; strFormat: String);
      Procedure pFormataContabil(mmoCampo: TfrxCustomMemoView; intCasas: Integer; blnTotalizador: Boolean);

      Procedure pInicializaFastScript;

      Procedure pAjustaParamsComplmento;

      Procedure pIniciaLeftFolhas;

      procedure pDataGroupGetValueDisplayTextMes(Sender: TObject;
        const AValue: Variant; var ADisplayText: string);

      Procedure pMontaCabecalhosGrid(Var arrCabec: TArrCabecalhoGrid);

      Function fConfirmaExecucao: Boolean;
      Function fRetPerguntaEnviarGatilho(strTipo, strMensagem : String): Boolean;

      Function fRetGerarVideoVazio: Boolean;
      Function fEnviaPontosImpressao: Boolean;
      Function fValidaPontosImpressao: Boolean;

    public

      strPatImgCab: String;

      arrSalvaComplementos: Array Of Pointer;

      stlAlturaLinhas: TStringList;

      intAlturaGrafico,
      intLarguraGrafico: Integer;
      blnMaximizado: Boolean;

      frmProgresso: TfrmGravando;

      intRelatPos: Integer;

      blnTemArquivoSaida,
      blnEhComplemento: Boolean;

      blnTemNumWppGat,
      blnTemEmailGat,
      blnTemAssuntoGat,
      blnTemCorpoGat: Boolean;

      objInterfaceGera: Pointer;
      objInterfaceGeraPrincipal: Pointer;

      stlScriptImplementation: TStringList;

      FExprValida: TArrExprValida;

      FFontInicialMasterData: String;

      ArrTotaisRodape: TArrTotaisRodape;

      blnEnviarGatWpp,
      blnEnviarGatEma: Boolean;

      FListaEnvioPDFGatilho: TArrEnvioPDFGatilho;

      constructor Create(AOwner: TComponent);  Reintroduce;
      destructor Destroy; override;

      Function fGetInterface: Pointer;

      Function fMontaGrid(intIndiceRelatorio: Integer = -1;
                          mntMontagemGrid: TMontagemGrid = mntGrid): Boolean;

      Function fEstaQuebrandoPeloCampo(strNomCam: String): Boolean;
      Function fRetornaLarguraCampo(cdsCampos: TZClient): Double;

      Function fGetNomeEmpresaBasico: String;
      Function fGetNomeEmpresa: String;
      Function fGetNomeEmpresaRels(intQuerie: Integer): String;

      Function fGetTituloRelatorio: String;
      Function fGetTituloRelatorios(intQuerie: Integer): String;
      Function fGetSubTituloRelatorio: String;
      Function fGetSubTituloRelatorios(intQuerie: Integer): String;
      Function fGetPathImagemCabecalho: String;

      Procedure pCarregaQuebras;
      Procedure pSetaTamanhoDados(intQueries: Integer);
      Procedure pSetaTamanhoDadosPersonalizado(intQueries: Integer);

      Procedure pIniciaScript;
      Procedure pFinalizaScript;

      Procedure pCarregaTitulosRelatorio;
      Procedure pCarregaSubTitulosRelatorio;

      Function fTemDestinoGrafico: Boolean;

      Function fTemDestinoGraficoDashboard: Boolean;

      Function fGetNomeRelatorio(qryCadRel: TUniQuery): String;
      Function fGetSubNomeRelatorio(qryCadRel: TUniQuery): String;
      Function fGetPathSaidaSQL: String;
      Function fGetArqSaidaPDF: String;
      Function fGetVariavelBanco(strVariavel: String): String;

      Class Function fRetColunasMatricial: String;

      Function fColocaValoresExpressao(strExpressao: String; Var blnErro: Boolean): String;

      Function fJSonWhatsApp(intRelatPos: Integer): String;

      Function fPegaInformacaoTemplate(intRelatPos: Integer; Campos: TArray<string>): Boolean;

      Function fAdicionaPaginaQuebra(intNroPag: Integer; strArquivoSaida: String; strNumWpp: String; strEmail: String;
              strAssunto: String; strCorpo: String; intRelatPos: Integer): Boolean;

      Function fRetNomeGrupo(strCodGru: String): String; overload;

      Function fRetNomeGrupo(strCodGru: String; Var intTipBan: Integer): String; overload;

      Function fRetIndiceTotal(strNomTot: String): Integer;
      Function fTrataAcento(strInfo: String): String;
      Function fCarregaReport(qryCadRel: TUniQuery): Boolean;
      Function fAtualizaPapel(qryCadRel: TUniQuery): Boolean;
      Function fDescricaoCampo(strDesCam: String): String;

      Function fMargemEsquerda: Integer;
      Function fMargemDireita: Integer;
      Function fLarguraPaginaOriginal: Integer;

      Function fGerarFr3(strCodRels: String; objConsulta: TConsultasRel; blnLeuDados: Boolean; intMaxCol: Integer; strNomCam: string = ''; blnApenasPrincipal: Boolean = False): Boolean;
      Function fSaveReport(qryTabela: TUniQuery): Boolean;
      function fLoadReport(qryTabela: TUniQuery; frxReport: TFrxReport): Boolean;
      Function fExecutaRelatorio(strIdent, strPasta: String; desDestino: TDestinoRel; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): Boolean;
      Function fGetMaxLarCam(intQtdCam: Integer): Double;

      Function fGetLarguraPaginaPix: Integer;

      Function fLarguraPagina: Integer;
      Function fMudouDataSet: Boolean;

      Function fGetLarguraEspacamentoUsada(intQtdCam: Integer): Double;

      Function fValidaVisibilidade(cdsCampos: TZClient; blnExprValida: Boolean = False): Boolean;

      Function fTrocaConstantesExpressao(strExpressao: String): String;

      Function fExecutaExpressao(strExpressao: String; blnExprValida: Boolean = False): Boolean;
      Function fExecutaExpressaoString(strExpressao: String; blnExprValida: Boolean = False): String;

      Function fRetornaExpressaoString(strExpressao: String; blnExprValida: Boolean = False; blnDescrCampo: Boolean = False): String;
      Function fRetornaExpressaBoolean(strExpressao: String; blnExprValida: Boolean = False): Boolean;

      function fFormataCpfCgcRel(strCPF: String): String;
      function fFormataContabilRel(dblValor: Double; intCasas: Integer; blnTotalizador: Boolean): String;

      function fFiltraDadosChild(intContRel: Integer; strCodRel: String; strNomCam: String; strCamLig: String; strValores: String): Boolean;

      function fFiltraDadosFr3Child(strNomeTmp: String; strCamLig: String; strValores: String): Boolean;

      function fRetQtdRegFr3Child(strNomeTmp: String): Integer;

      function fRetornaValorTemporariaFr3(strNomeTmp, strNomeCampo: String): String;

      Class function fFormataFoneRel(strTelefo: String): String;

      function fExportaArquivoTXT(strPasta: String; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): String;

      function fExportaArquivoXML(strPasta: String; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): String;

      function fExportaArquivoSaida(strPasta: String; blnExibirMensagem: Boolean = True): String;

      Procedure pMontaGrafico(cxgGrafico: TCxGrid;
                              cxvGrafico: TcxGridDBChartView;
                              AOwner: TComponent;
                              cdsCampos: TZClient;
                              intRelatorio: Integer;
                              dtsGrafigo: TDataSource;
                              shpGrafico: TShape);

      procedure pGravaLogPaf(strSucesso, strResultado: String);
      procedure pGravaLogExecucao(strResultado: String);

      Function fGetDestinoRelatorio: TDestinoRel;
      Function fValidaExpImp(FParametros: TZClient): Boolean;

      Procedure pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp: String);

    published

      Property frxReport: TfrxReport Read FFrxReport Write FFrxReport;
      Property strCodMod: String Read FCodMod Write pSetCodMod;
      Property blnJato: Boolean Read FJato  Write FJato;
      Property intPaper : Integer Read FPaper Write FPaper;

      Property fltFatorScale: Double Read FFatorScale Write FFatorScale;

      Property intColunasMatricial: Integer Read FColunasMatricial Write FColunasMatricial;

      Property cdsParams: TZClient  Read FParams Write FParams;
      Property cdsParamsAut: TZClient  Read FParamsAut Write FParamsAut;

      Property cdsCamposG: TZClient Read FCampos Write pSetCampos;
      Property cdsComple: TZClient  Read FComple Write FComple;
      Property cdsQuebras: TZClient Read FQuebras;

      Property arrCadRel: TArrQuery Read FCadRel Write FCadRel;
      Property arrControleRel: TArrControleRel Read FControleRel Write FControleRel;

      Property proOrientation: TPrinterOrientation Read FOrientation Write pSetOrientation;

      Property qryDados:     TArrDataSet Read FDados   Write FDados;
      Property qryDadosOrig: TArrDataSet Read FDadosOrig   Write FDadosOrig;
      Property qryDadosPersonalizado:     TArrDataSet Read FDadosPersonalizado   Write FDadosPersonalizado;
      Property qryFiltros: TArrQuery   Read FFiltros Write FFiltros;

      Property stlTituloFiltros:   TStringList Read FTituloFiltros Write FTituloFiltros;
      Property sltListaParFiltros: TStringList Read FListaParFiltros Write FListaParFiltros;

      Property strTituloRelatorio: String Read FTituloRelatorio Write FTituloRelatorio;
      Property strSubTituloRelatorio: String Read FSubTituloRelatorio Write FSubTituloRelatorio;

      Property strArquivoSaidaDiretoPDF: String Read FArquivoSaidaDiretoPDF Write FArquivoSaidaDiretoPDF;

      Property strSQL: String Read FstrSQL Write FstrSQL;
      Property strTipImp: String Read FTipImp Write FTipImp;

      Property blnCarregouPagina: Boolean Read FCarregouPagina Write FCarregouPagina;

      Property stlCodRels: TStringList Read FCodRels Write FCodRels;

      Property fonFontHeader: TFont Read fGetFontHeader;

      Property desDestinoFr3: TDestinoRel Read fGetDestinoRelatorio Write FDestino;

      Property intMaxColunas: Integer Read FMaxCol;
  end;

implementation

Uses
  dxCore,
  Windows,
  Forms, untFuncoesEditorFast, untCfgRel, untGeraCSV, untGeraTXT, untGeraXML, untGeraArquivoSaida, FileCtrl,
  untInterfaceRelatorio, CRParser, MyParserUni, untTEnvioEmail, untRelatorio,
  untConstantes,
  untGridRelatorio,
  cxGridChartView, cxStyles, cxControls,
  untModuloGrid,
  untChartRelatorioFrame,
  untDefinePosicaoGrafico,
  untMensagemValidacao,
  untDadosEnviaWhatsapp,
  untGraficosDashboard;

Const
  STR_CODEMP = 'VS_STRCODEMP';
  STR_MESATU = 'VS_STRMESATU';
  STR_DESTINO = 'VS_STRDESTINO';
  STR_TIPO_TOT = 'VS_STRTIPOTOT';

constructor TGeraFR3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  strPatImgCab := '';

  frxPage := Nil;

  stlAlturaLinhas := TStringList.Create;

  intAlturaGrafico  := 0;
  intLarguraGrafico := 0;
  blnMaximizado     := False;

  frmProgresso := Nil;

  SetLength(ArrTotaisRodape, 0);
  SetLength(FarrLeftsFolhas, 0);
  SetLength(FExprValida, 0);

  blnEhComplemento := False;

  intRelatPos := 0;

  FPais := fSetaPais;

  SetLength(arrSalvaComplementos, 0);

  stlScriptImplementation := TStringList.Create;
  stlScriptInitialization := TStringList.Create;

  FArquivoSaidaDiretoPDF := EmptyStr;

  FlistaArquivos := TStringList.Create;
  FListaPaginas  := TStringList.Create;
  SetLength(FListaEnvioPDFGatilho, 0);

  FComplementoCabec := TStringList.Create;

  SetLength(FTitulosRelatorio, 0);
  SetLength(FSubTitulosRelatorio, 0);

  FCurrentTop := 0;

  FConsulta := Nil;

  objInterfaceGera := Nil;
  objInterfaceGeraPrincipal := Nil;

  FCodRels := TStringList.Create;

  frxMasterData := Nil;

  FQtdQueBras := 0;
  FCarregouPagina := False;
  FCodMod := '';
  FOrientation := poPortrait;
  FOrientationOriginal := poPortrait;

  FColunasMatricial := COLUNAS_MAT[pag137];

  FFrxModelo := TfrxReport.Create(Self);

  FFrxDotMatrix := TfrxDotMatrixExport.Create(Self);
  FFrxDotMatrix.PageBreaks := True;

  SetLength(FFrxDataSet, 0);

  FBase := Nil;

  FQuebras := TZClient.Create(Self, fSQLQuebras);

  FQuebras.fAbreClient(True, 'FQuebras.fAbreClient');

  FSavArq := TSaveDialog.Create(Self);

  FCampos    := TZClient.Create(Self);
  FCamposExp := TZClient.Create(Self);

  FCadMod := fCriaQuery(Self);

  pInicializaFastScript;

  blnEnviarGatWpp := False;
  blnEnviarGatEma := False;
end;

destructor TGeraFR3.Destroy;
begin
  inherited;

  pLiberaComplementos;

  FCodRels.Clear;
  FreeAndNil(FCodRels);

  FreeAndNil(stlAlturaLinhas);
  FreeAndNil(stlScriptImplementation);
  FreeAndNil(stlScriptInitialization);

  FComplementoCabec.Clear;
  FreeAndNil(FComplementoCabec);

  FListaPaginas.Clear;
  FreeAndNil(FListaPaginas);

  FlistaArquivos.Clear;
  FreeAndNil(FlistaArquivos);

  SetLength(FListaEnvioPDFGatilho, 0);
  FreeAndNil(FListaEnvioPDFGatilho);

  FreeAndNil(fscScript);
end;

Function TGeraFR3.fRetNomeParametro(strDesCam: String): String;
  Var
    intPos: Integer;
Begin
  Result := '';

  intPos := Pos(':', strDesCam);

  If intPos > 0 Then
  Begin

    Inc(intPos);

    While (intPos <= Length(strDesCam)) Do
    Begin
      If CharInSet(strDesCam[intPos],  [' ', '/', '\', '-', '+']) Then
        Break;

      Result := Result + strDesCam[intPos];

      Inc(intPos);
    End;

  End;

End;

Function TGeraFR3.fRetNomeGrupo(strCodGru: String): String;
   Var strNomGru: String;
Begin
  Result := '';

  If Assigned(objInterfaceGera) And TInterfaceRelatorio(objInterfaceGera).fRetornaNomeGrupo(strCodGru, '1', strNomGru) Then
    Result := strNomGru;
End;

Function TGeraFR3.fRetNomeGrupo(strCodGru: String; Var intTipBan: Integer): String;
   Var strNomGru: String;
Begin
  Result := '';
  intTipBan := 0;

  If Assigned(objInterfaceGera) And
     TInterfaceRelatorio(objInterfaceGera).fRetornaNomeGrupo(strCodGru, '1', strNomGru, intTipBan) Then
    Result := strNomGru;
End;

Function TGeraFR3.fPegaValorParametro(strNomPar: String; Var blnAchou: Boolean; blnTiraMascara: Boolean = True): String;
Begin
  If Assigned(objInterfaceGeraPrincipal) Then
    Result := TInterfaceRelatorio(objInterfaceGeraPrincipal).fGetValorParametro(strNomPar, blnAchou, False)
  Else
    Result := TInterfaceRelatorio(objInterfaceGera).fGetValorParametro(strNomPar, blnAchou, False);
End;

Function TGeraFR3.fGetInterface: Pointer;
Begin
  If Assigned(objInterfaceGeraPrincipal) Then
    Result := objInterfaceGeraPrincipal
  Else
    Result := objInterfaceGera;
End;

function TGeraFR3.fTrocaConstantesExpressao(strExpressao: string): string;
begin
  Result := strExpressao;

  Result := AnsiReplaceStr(Result, STR_CODEMP, QuotedStr(VS_STRCODEMP));
  Result := AnsiReplaceStr(Result, 'MÊS ATUAL', QuotedStr(FormatDateTime('MM/YYYY', VS_Date)));
  Result := AnsiReplaceStr(Result, STR_MESATU, QuotedStr(FormatDateTime('MM/YYYY', VS_Date)));

  If Assigned(objInterfaceGeraPrincipal) Then
    Result := AnsiReplaceStr(Result, STR_DESTINO, QuotedStr(string(ArrDestino[TInterfaceRelatorio(objInterfaceGeraPrincipal).fRetDestino])))
  Else
    Result := AnsiReplaceStr(Result, STR_DESTINO, QuotedStr(string(ArrDestino[TInterfaceRelatorio(objInterfaceGera).fRetDestino])));

  Result := TInterfaceRelatorio(objInterfaceGera).fValidaCfgSis(Result);
end;

Function TGeraFR3.fDescricaoCampo(strDesCam: String): String;
  Var
    strNomPar,
    strValPar: String;
    blnAchou: Boolean;
    intPosicao: Integer;
Begin
  strDesCam := Trim(AnsiReplaceStr(strDesCam, '<<csq>>', ' '));

  Result := TInterfaceRelatorio.fTrataDesCam(strDesCam);

  If Assigned(objInterfaceGeraPrincipal) Then
    Result := TInterfaceRelatorio(objInterfaceGeraPrincipal).fGetNomeColunaCheckList(Result);

  If SameText(Result, strDesCam) Then
    Result := TInterfaceRelatorio(objInterfaceGera).fGetNomeColunaCheckList(Result);

  If AnsiStartsStr('@(', strDesCam) Then
  Begin
    strDesCam := Copy(strDesCam, 3, Length(strDesCam) - 3);
    Result := fRetornaExpressaoString(strDesCam, False, True);
  End

  Else If SameText(strDesCam, STR_CODEMP) Then
    Result := VS_STRCODEMP

  Else If SameText(strDesCam, 'MÊS ATUAL') Then
    Result := FormatDateTime('MM/YYYY', VS_Date)

  Else If SameText(strDesCam, STR_MESATU) Then
    Result := FormatDateTime('MM/YYYY', VS_Date)

  Else If SameText(strDesCam, STR_DESTINO) Then
  Begin
    If Assigned(objInterfaceGeraPrincipal) Then
      Result := string(ArrDestino[TInterfaceRelatorio(objInterfaceGeraPrincipal).fRetDestino])
    Else
      Result := string(ArrDestino[TInterfaceRelatorio(objInterfaceGera).fRetDestino]);
  End

  Else If Assigned(objInterfaceGera) And (Pos(':', strDesCam) > 0) Then
  Begin

    strNomPar := fRetNomeParametro(strDesCam);

    strValPar := fPegaValorParametro(strNomPar, blnAchou, False);

    If blnAchou Then
      Result := AnsiReplaceStr(strDesCam, ':' + strNomPar, strValPar);
  End;

  If (FCadRel[intRelatPos].FieldByName('REL_HORIZO').AsString = 'I') And
     AnsiStartsStr('VALOR', Result) Then
  Begin
    intPosicao := StrToIntDef(RightStr(Result, Length(strDesCam) - Length('VALOR')) , -1);

    If intPosicao > 0 Then
      Dec(intPosicao);

    If Assigned(objInterfaceGeraPrincipal) And
       (TInterfaceRelatorio(objInterfaceGeraPrincipal).stlNomeColunaHorizo.Count > 0) And
       (TInterfaceRelatorio(objInterfaceGeraPrincipal).stlNomeColunaHorizo.Count > intPosicao) Then
    Begin
      Result := TInterfaceRelatorio(objInterfaceGeraPrincipal).stlNomeColunaHorizo[intPosicao];
      Exit;
    End;

    If Assigned(objInterfaceGera) And
       (TInterfaceRelatorio(objInterfaceGera).stlNomeColunaHorizo.Count > 0) And
       (TInterfaceRelatorio(objInterfaceGera).stlNomeColunaHorizo.Count > intPosicao) Then
    Begin
      Result := TInterfaceRelatorio(objInterfaceGera).stlNomeColunaHorizo[intPosicao];
      Exit;
    End;

  End;

End;

Function TGeraFR3.fSQLQuebras: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL  + ' SELECT ';
  strSQL := strSQL  + '   CAM_NOMCAM, ';
  strSQL := strSQL  + '   CAM_DESCAM, ';
  strSQL := strSQL  + '   CAM_TIPCAM, ';
  strSQL := strSQL  + '   CAM_MASCAR, ';
  strSQL := strSQL  + '   CAM_FUNCAO, ';
  strSQL := strSQL  + '   CAM_PARAME, ';
  strSQL := strSQL  + '   CAM_NRODEC, ';
  strSQL := strSQL  + '   CAM_NEWPAG, ';
  strSQL := strSQL  + '   CAM_REPRIN, ';
  strSQL := strSQL  + '   CAM_STAPAG, ';
  strSQL := strSQL  + '   CAM_SEPARQ, ';
  strSQL := strSQL  + '   CAM_MSGGRU, ';
  strSQL := strSQL  + '   CAM_REATOT, ';
  strSQL := strSQL  + '   CAM_KEEPTG, ';
  strSQL := strSQL  + '   CAM_KEEPCH, ';
  strSQL := strSQL  + '   CAM_REMLIN, ';
  strSQL := strSQL  + '   CAM_LINQUE, ';
  strSQL := strSQL  + '   CAM_QUAQUE, ';
  strSQL := strSQL  + '   CAM_TAGLIN, ';
  strSQL := strSQL  + '   CAM_TAGANT, ';
  strSQL := strSQL  + '   CAM_TAGPOS, ';
  strSQL := strSQL  + '   CAM_DESLIN, ';
  strSQL := strSQL  + '   CAST("" AS CHAR(2000)) AS CAMLIS, ';
  strSQL := strSQL  + '   CAST("" AS CHAR(2000)) AS VALQUE, ';
  strSQL := strSQL  + '   CAST("" AS CHAR(01))   AS EMPANT, ';
  strSQL := strSQL  + '   CAST("" AS CHAR(01))   AS EMPPOS, ';
  strSQL := strSQL  + '   0 AS POSCAM ';
  strSQL := strSQL  + ' FROM ';
  strSQL := strSQL  + '   CADCAM ';
  strSQL := strSQL  + ' WHERE FALSE ';

  Result := strSQL;
End;

Function TGeraFR3.fIncTop: Double;
Begin
  If FTipImp = 'J' Then
    Result := 1
  Else
    Result := 0;
End;

Function TGeraFR3.fGetOrderBy(strSQL: String): String;
  Var
    stlSQL: TStringList;
    intOrder,
    intContador: Integer;
Begin
  stlSQL := TStringList.Create;
  stlSQL.Text := strSQL;

  intOrder := -1;

  For intContador := stlSQL.Count - 1 DownTo 0 Do
  If Pos('ORDER', stlSQL[intContador]) > 0 Then
  Begin
    intOrder := intContador;
    Break;
  End;

  If intOrder <> -1 Then
  Begin

    For intContador := 0 To intOrder -1 Do
      stlSQL.Delete(0);

    Result := stlSQL.Text;
  End

  Else Result := '';

  stlSQL.Clear;
  FreeAndNil(stlSQL);
End;

Procedure TGeraFR3.pCarregaQuebras;
  Var
    strOrderBy: String;
    stlCamLis: TStringList;
Begin
  stlCamLis := TStringList.Create;

  FQuebras.EmptyDataSet;
  FQuebras.IndexFieldNames := 'POSCAM';

  strOrderBy := fGetOrderBy(FstrSQL);

  FCampos.First;
  While Not FCampos.Eof Do
  Begin
    stlCamLis.Add(FCampos.FieldByName('CAM_NOMCAM').AsString);

    If (FCampos.FieldByName('CAM_QUEBRA').AsString = 'S') And
       (fEmptyStr(FCampos.FieldByName('CAM_QUAQUE').AsString) Or
        fRetornaExpressaBoolean(FCampos.FieldByName('CAM_QUAQUE').AsString)) Then
    Begin
      FQuebras.Insert;
      FQuebras.FieldByName('CAM_NOMCAM').AsString  := FCampos.FieldByName('CAM_NOMCAM').AsString;
      FQuebras.FieldByName('CAM_DESCAM').AsString  := FCampos.FieldByName('CAM_DESCAM').AsString;
      FQuebras.FieldByName('CAM_MASCAR').AsString  := FCampos.FieldByName('CAM_MASCAR').AsString;
      FQuebras.FieldByName('CAM_FUNCAO').AsString  := FCampos.FieldByName('CAM_FUNCAO').AsString;
      FQuebras.FieldByName('CAM_PARAME').AsString  := FCampos.FieldByName('CAM_PARAME').AsString;
      FQuebras.FieldByName('CAM_TIPCAM').AsString  := FCampos.FieldByName('CAM_TIPCAM').AsString;
      FQuebras.FieldByName('CAM_NEWPAG').AsString  := FCampos.FieldByName('CAM_NEWPAG').AsString;
      FQuebras.FieldByName('CAM_REPRIN').AsString  := FCampos.FieldByName('CAM_REPRIN').AsString;
      FQuebras.FieldByName('CAM_STAPAG').AsString  := FCampos.FieldByName('CAM_STAPAG').AsString;
      FQuebras.FieldByName('CAM_SEPARQ').AsString  := FCampos.FieldByName('CAM_SEPARQ').AsString;
      FQuebras.FieldByName('CAM_MSGGRU').AsString  := FCampos.FieldByName('CAM_MSGGRU').AsString;
      FQuebras.FieldByName('CAM_REATOT').AsString  := FCampos.FieldByName('CAM_REATOT').AsString;
      FQuebras.FieldByName('CAM_KEEPTG').AsString  := FCampos.FieldByName('CAM_KEEPTG').AsString;
      FQuebras.FieldByName('CAM_QUAQUE').AsString  := FCampos.FieldByName('CAM_QUAQUE').AsString;
      FQuebras.FieldByName('CAM_TAGLIN').AsString  := FCampos.FieldByName('CAM_TAGLIN').AsString;
      FQuebras.FieldByName('CAM_TAGANT').AsString  := FCampos.FieldByName('CAM_TAGANT').AsString;
      FQuebras.FieldByName('CAM_TAGPOS').AsString  := FCampos.FieldByName('CAM_TAGPOS').AsString;
      FQuebras.FieldByName('CAM_NRODEC').AsInteger := FCampos.FieldByName('CAM_NRODEC').AsInteger;
      FQuebras.FieldByName('CAM_DESLIN').AsString  := FCampos.FieldByName('CAM_DESLIN').AsString;
      FQuebras.FieldByName('EMPANT').AsString      := 'N';
      FQuebras.FieldByName('EMPPOS').AsString      := 'N';
      FQuebras.FieldByName('CAMLIS').AsString      := stlCamLis.Text;
      FQuebras.FieldByName('POSCAM').AsInteger     := Pos(FQuebras.FieldByName('CAM_NOMCAM').AsString, strOrderBy);
      FQuebras.Post;

      stlCamLis.Clear;
    End;

    FCampos.Next;
  End;

  FQtdQueBras := FQuebras.RecordCount;

  FreeAndNil(stlCamLis);
End;

Procedure TGeraFR3.pFormataDecimais(mmoCampo: TfrxCustomMemoView; strFormat: String);
Begin
  If Not fEmptyStr(strFormat) Then
  Begin
    mmoCampo.DisplayFormat.Kind      := fkNumeric;
    mmoCampo.DisplayFormat.FormatStr := strFormat;
  End;
End;

Procedure TGeraFR3.pFormataContabil(mmoCampo: TfrxCustomMemoView; intCasas: Integer; blnTotalizador: Boolean);
Begin
  mmoCampo.Text := '[fFormataContabilRel(' + AnsiReplaceStr(AnsiReplaceStr(mmoCampo.Text, '[', ''), ']', '') + ', ' + IntToStr(intCasas) + ', ' + IIF(blnTotalizador, 'True', 'False') + ')]';
End;

Function TGeraFR3.fPegaInformacaoTemplate(intRelatPos: Integer; Campos: TArray<string>): Boolean;
  Var
    I: Integer;
Begin
  Result := True;

  If intRelatPos > High(FDados) Then
  Begin
    Result := False;
    Exit;
  End;

  for I := Low(Campos) to High(Campos) do
  begin
    If Campos[I] = 'URL_DASHBOARD' then
      Continue;

    If Assigned(FDados[intRelatPos].FindField(Campos[I])) Then
    Begin
      Campos[I] := FDados[intRelatPos].FieldByName(Campos[I]).AsString;
    End Else
    Begin
      Result := False;
      Break;
    End;
  end;
End;

Function TGeraFR3.fJSonWhatsApp(intRelatPos: Integer): String;
  Var
    DadosEnviaWhatsapp: TDadosEnviaWhatsapp;
    Campos: TArray<string>;
    IdFila: String;
    IdTemplate: String;
Begin
  Result := '';

  If intRelatPos > High(FCadRel) Then
    Exit;

  If fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_WIDTEM').AsString) And
     fEmptyStr(fCfgSis('GATFIP'))                                        And
     fEmptyStr(fCfgSis('GATFID'))                                        And
     fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_WIDDIS').AsString)  And
     fEmptyStr(fCfgSis('GATOPE'))                                        Then
    Exit;

  DadosEnviaWhatsapp := TDadosEnviaWhatsapp.Create;
  Try
    IdFila := TInterfaceRelatorio(fGetInterface).fRetornaFilaMeta;

    IdTemplate := FCadRel[intRelatPos].FieldByName('REL_WIDTEM').AsString;
    If fEmptyStr(IdTemplate) then
    Begin
      if (FCadRel[intRelatPos].FieldByName('REL_DESTIN').AsString.Contains('PDF')) then
        IdTemplate := fCfgSis('GATFIP')

      else if (FCadRel[intRelatPos].FieldByName('REL_DESTIN').AsString.Contains('Dashboard')) then
        IdTemplate := fCfgSis('GATFID');
    End;

    If Not fEmptyStr(IdTemplate) Then
    Begin
      If Not TInterfaceRelatorio(fGetInterface).fExtraiCamposTemplate(FCadRel[intRelatPos].FieldByName('REL_CAMIDT').AsString, Campos) Then
        Exit;

      If Not fPegaInformacaoTemplate(intRelatPos, Campos) Then
        Exit;

      DadosEnviaWhatsapp.template.varsdata := Campos;

      DadosEnviaWhatsapp.template.id := IdTemplate;
    End;

    DadosEnviaWhatsapp.fila.id := IdFila;

    Result := DadosEnviaWhatsapp.ToJsonString;

  Finally
    SetLength(Campos, 0);
    FreeAndNil(DadosEnviaWhatsapp);
  End;
End;

Function TGeraFR3.fAdicionaPaginaQuebra(intNroPag: Integer; strArquivoSaida: String; strNumWpp: String;
               strEmail: String; strAssunto: String; strCorpo: String; intRelatPos: Integer): Boolean;
Begin
  FListaPaginas.Add(IntToStr(intNroPag));
  FlistaArquivos.Add(strArquivoSaida);

  SetLength(FListaEnvioPDFGatilho, Succ(Length(FListaEnvioPDFGatilho)));
  FListaEnvioPDFGatilho[High(FListaEnvioPDFGatilho)].strNumWpp   := strNumWpp;
  FListaEnvioPDFGatilho[High(FListaEnvioPDFGatilho)].strEmail    := strEmail;
  FListaEnvioPDFGatilho[High(FListaEnvioPDFGatilho)].strAssunto  := strAssunto;
  FListaEnvioPDFGatilho[High(FListaEnvioPDFGatilho)].strCorpo    := strCorpo;

  If blnTemNumWppGat Then
    FListaEnvioPDFGatilho[High(FListaEnvioPDFGatilho)].strJSonWhatsApp := fJSonWhatsApp(intRelatPos);

  Result := True;
End;

function TGeraFR3.fCriaGroupHeaders(strNomCam: string): Boolean;
  Var
    frxGroupHeaderAnt,
    frxGroupHeaderUlt,
    frxGroupHeader,
    frxGroupHeaderModelo: TfrxGroupHeader;
    mmoTitulo: TfrxCustomMemoView;
    fr3ObjetoChild: TObject;
    fltLeft,
    fltTop,
    // ESPACAMENTO INICIAL DO TÍTULO DA QUEBRA
    fltInc: Double;

    intContaQuebras,
    intLinhaQuebra: Integer;
    strDesCam: String;
    strFonteAntiga: string;
    strNomeTitulo: string;
    intScripts: Integer;

    stlScriptGroupHeader: TStringList;

    blnMudouALinha: Boolean;

    strFormat: String;

    frxChild,
    frxChildGroupHeaderUlt: TfrxChild;

    frxHeaderModelo,
    frxHeaderPrincipal: TfrxHeader;
    strArquivoSaida,
    strNumWpp,
    strEmail,
    strAssuntoGat,
    strCorpoGat: String;

  function fFormataFntCnd(strFntCnd: string): string;
  var
    intPosicao: Integer;
  begin
    with FCampos do
    begin
      intPosicao := RecNo;
      First;
      while not Eof do
      begin
        if Pos('<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">', strFntCnd) <= 0 then
          strFntCnd := AnsiReplaceStr(strFntCnd, FieldByName('CAM_NOMCAM').AsString, '<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">');
        Next;
      end;
      RecNo := intPosicao;
    end;
    Result := strFntCnd;
  end;

Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := True;

  stlScriptGroupHeader := TStringList.Create;
  strNomeTitulo := '';

  frxGroupHeaderModelo := fRetGroupHeader(FfrxModelo);

  frxGroupHeader         := Nil;
  frxGroupHeaderAnt      := Nil;

  mmoTitulo      := Nil;

  intContaQuebras := 0;

  If Assigned(frxGroupHeaderModelo) Then
  With FQuebras Do
  Begin
    First;

    fltInc := 0;

    While Not Eof Do
    Begin
      Inc(intContaQuebras);

      frxGroupHeader := TfrxGroupHeader.Create(frxPage);
      frxGroupHeader.Stretched := True;
      frxGroupHeader.Name := 'frxGroupHeader' + IntToStr(intRelatPos) + strNomCam + FieldByName('CAM_NOMCAM').AsString;

      frxGroupHeader.Height := frxGroupHeaderModelo.Height;
      frxGroupHeader.Font   := frxGroupHeaderModelo.Font;

      If (SameText(FieldByName('CAM_DESLIN').AsString, 'S')) Then
        frxGroupHeader.Frame.Typ := frxGroupHeaderModelo.Frame.Typ;

      frxGroupHeader.StartNewPage     := SameText(FieldByName('CAM_NEWPAG').AsString, 'S');
      frxGroupHeader.ReprintOnNewPage := SameText(FieldByName('CAM_REPRIN').AsString, 'S');
      frxGroupHeader.ResetPageNumbers := SameText(FieldByName('CAM_STAPAG').AsString, 'S');
      frxGroupHeader.KeepTogether     := SameText(FieldByName('CAM_KEEPTG').AsString, 'S');

      If frxGroupHeader.StartNewPage And frxGroupHeader.ResetPageNumbers And
         SameText(FieldByName('CAM_SEPARQ').AsString, 'S') Then
      Begin
        frxGroupHeader.OnAfterPrint := 'p' + frxGroupHeader.Name + 'AfterPrint';

                strArquivoSaida := QuotedStr('');
        strNumWpp := QuotedStr('');
        strEmail := QuotedStr('');
        strAssuntoGat := QuotedStr('');
        strCorpoGat := QuotedStr('');

        if blnTemArquivoSaida then
          strArquivoSaida := '<' + fDataSetName(intRelatPos) + '."ARQUIVO_SAIDA">';

        if (blnTemCorpoGat) Or
           (Not fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_WIDTEM').AsString)) then
        Begin
          if blnTemNumWppGat then
            strNumWpp := '<' + fDataSetName(intRelatPos) + '."GATILHO_WHATSAPP">';

          if blnTemEmailGat then
            strEmail := '<' + fDataSetName(intRelatPos) + '."GATILHO_EMAIL">';

          if blnTemAssuntoGat then
            strAssuntoGat := '<' + fDataSetName(intRelatPos) + '."GATILHO_ASSUNTO">';

          if (blnTemCorpoGat) then
            strCorpoGat := '<' + fDataSetName(intRelatPos) + '."GATILHO_CORPO">';
        End;

        With stlScriptImplementation Do
        Begin
          Add('');
          Add('procedure ' + frxGroupHeader.OnAfterPrint + '(Sender: TfrxComponent);');
          Add('begin');
          Add('  If <page> = 1 Then fAdicionaPaginaQuebra(<page#>, ' + strArquivoSaida + ', ' + strNumWpp + ', ' + strEmail + ', ' +
                          strAssuntoGat + ', ' + strCorpoGat  + ', ' + intRelatPos.ToString + ');');
          Add('end;');
        End
      End;

      If Not Assigned(frxGroupHeaderAnt) Then
      Begin
        If Assigned(frxPaiTitulosColunas) Then
        Begin
          If FTipImp = 'J' Then
            frxGroupHeader.Top := frxPaiTitulosColunas.Top + 1
          Else
            frxGroupHeader.Top := frxPaiTitulosColunas.Top + 17;
        End
        Else
        Begin
          If FTipImp = 'J' Then
            frxGroupHeader.Top := FCurrentTop + 1
          Else
            frxGroupHeader.Top := FCurrentTop + 17;
        End;
      End Else
      Begin
        If FTipImp = 'J' Then
          frxGroupHeader.Top := frxGroupHeaderAnt.Top + 1
        Else
          frxGroupHeader.Top := frxGroupHeaderAnt.Top + 17;
      End;

      frxGroupHeaderAnt := frxGroupHeader;

      frxGroupHeader.Condition := fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '"';

      if FieldByName('CAM_REMLIN').AsString = 'N' then
        fCopiaLine('mmoLinhaGroupHeaderInicial', '', 'mmoLinhaGroupHeaderInicial' + FieldByName('CAM_NOMCAM').AsString, frxGroupHeader, -1, strNomCam);

      fltTop  := -1;
      fltLeft := fltInc;
      intLinhaQuebra := 0;

      FCampos.IndexFieldNames := 'CAM_LINQUE;CAM_POSICA';

      FCampos.First;

      While Not FCampos.Eof Do
      Begin

        If SameText(FCampos.FieldByName('CAM_LISQUE').AsString, FieldByName('CAM_NOMCAM').AsString) And fValidaVisibilidade(FCampos) Then
        Begin
          blnMudouALinha := False;

          If intLinhaQuebra = 0 Then // PRIMEIRA VEZ
          Begin
            blnMudouALinha := True;

            intLinhaQuebra := StrToIntDef(FCampos.FieldByName('CAM_LINQUE').AsString, -1);

          End Else
          Begin

            If intLinhaQuebra <> StrToIntDef(FCampos.FieldByName('CAM_LINQUE').AsString, -1) Then
            Begin
              fltLeft := fltInc;

              If fltTop = -1 Then
                fltTop := mmoTitulo.Top + mmoTitulo.Height + fIncTop
              Else
                fltTop := fltTop + mmoTitulo.Height + fIncTop;

              intLinhaQuebra := StrToIntDef(FCampos.FieldByName('CAM_LINQUE').AsString, -1);

              blnMudouALinha := True;
            End Else
            Begin

              fltLeft := fltLeft + mmoTitulo.Width + fRetEspacametoColunas;

            End;

          End;

          If SameText(FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString, 'S') Then
          Begin
            strDesCam := fDescricaoCampo(FCampos.FieldByName('CAM_DESCAM').AsString);
            If Not fEmptyStr(strDesCam) Then
              strDesCam := strDesCam + ': ';

            If blnMudouALinha Then
            Begin

              if Assigned(mmoTitulo) then
              begin
                for intScripts := 0 to stlScriptGroupHeader.Count -1 do
                  stlScriptImplementation.Add(stlScriptGroupHeader[intScripts]);

                stlScriptGroupHeader.Clear;
              end;

              mmoTitulo := fCopiaMemoView('mmoGroupHeaderTitulo',
                                       fTrataAcento(strDesCam) + fRetCampoRel(FCampos, strFormat, False, True),
                                            FCampos.FieldByName('CAM_NOMCAM').AsString,  frxGroupHeader, fltTop, True, strNomCam);

              mmoTitulo.WordWrap := True;

              If FTipImp = 'M' Then
                TfrxDMPMemoView(mmoTitulo).TruncOutboundText := False;

              mmoTitulo.Width := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False)  - fCmColunaToPixel(1, False, FTipImp, False);

              mmoTitulo.Width := mmoTitulo.Width - fltInc;

              mmoTitulo.StretchMode := smMaxHeight;

            End Else
            Begin
              mmoTitulo.Text := Trim(mmoTitulo.Text) + '  ' + fTrataAcento(strDesCam) + fRetCampoRel(FCampos, strFormat, False, True);
            End;


          End Else
          Begin
            mmoTitulo := fCopiaMemoView('mmoGroupHeaderTitulo', '', FCampos.FieldByName('CAM_NOMCAM').AsString,  frxGroupHeader, fltTop, True, strNomCam);
            mmoTitulo.AutoWidth := False;

            pMontaCampo(mmoTitulo, True);
          End;

          If ((not fEmptyStr(FCampos.FieldByName('CAM_FNTCND').AsString)) And (not fEmptyStr(FCampos.FieldByName('CAM_FNTCAM').AsString))) Then
          Begin

            mmoTitulo.OnBeforePrint := 'p' + mmoTitulo.Name + 'BeforePrint';
            strFonteAntiga := TInterfaceRelatorio.FontToStr(mmoTitulo.Font);

            With stlScriptGroupHeader Do
            Begin
              Clear;
              Add('');
              Add('procedure ' + mmoTitulo.OnBeforePrint + '(Sender: TfrxComponent);');
              Add('begin');
              Add('  If (' + fFormataFntCnd(FCampos.FieldByName('CAM_FNTCND').AsString) + ') Then ');
              Add('  begin');
              Add('    TfrxMemoView(Sender).Font.Name  := ' + QuotedStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FCampos.FieldByName('CAM_FNTCAM').AsString), 'Name')) + '; ');
              Add('    TfrxMemoView(Sender).Font.Color := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FCampos.FieldByName('CAM_FNTCAM').AsString), 'Color') + '; ');
              Add('    TfrxMemoView(Sender).Font.Size  := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FCampos.FieldByName('CAM_FNTCAM').AsString), 'Size') + '; ');
              Add('    TfrxMemoView(Sender).Font.Style := ' + AnsiReplaceStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FCampos.FieldByName('CAM_FNTCAM').AsString), 'Style'), '|', '+') + '; ');
              Add('  end');
              Add('  else');
              Add('  begin');
              Add('    TfrxMemoView(Sender).Font.Name  := ' + QuotedStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Name')) + '; ');
              Add('    TfrxMemoView(Sender).Font.Color := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Color') + '; ');
              Add('    TfrxMemoView(Sender).Font.Size  := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Size') + '; ');
              Add('    TfrxMemoView(Sender).Font.Style := ' + AnsiReplaceStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Style'), '|', '+') + '; ');
              Add('  end;');
              Add('end;');
            End;

          End;

          If Assigned(mmoTitulo) And (blnMudouALinha Or (Not SameText(FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString, 'S'))) Then
            mmoTitulo.Left := fltLeft;
        End;

        FCampos.Next;
      End;

      FCampos.IndexFieldNames := 'CAM_POSICA';

      If Assigned(mmoTitulo) And SameText(FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString, 'S') Then
      Begin
        for intScripts := 0 to stlScriptGroupHeader.Count -1 do
          stlScriptImplementation.Add(stlScriptGroupHeader[intScripts]);

        stlScriptGroupHeader.Clear;

        If ((FCadRel[intRelatPos].FindField('REL_CASQUE') = nil) Or
            ((FCadRel[intRelatPos].FindField('REL_CASQUE') <> nil) And (SameText(FCadRel[intRelatPos].FieldByName('REL_CASQUE').AsString, 'S')))) Then
          fltInc := fltInc + fCmColunaToPixel(1, False, FTipImp, False);
      End;

      fCopiaLine('mmoLinhaGroupHeaderFinal',   '', 'mmoLinhaGroupHeaderFinal'   + FieldByName('CAM_NOMCAM').AsString, frxGroupHeader, frxGroupHeader.Height - 2, strNomCam);

      FCurrentTop := frxGroupHeader.Top + frxGroupHeader.Height;
      Next;
    End;

    If (FCadRel[intRelatPos].FindField('REL_ULTQUE') <> nil) And (SameText(FCadRel[intRelatPos].FieldByName('REL_ULTQUE').AsString, 'S')) Then
    Begin
      If RecordCount > 0 Then
      Begin
        Last;
        frxGroupHeaderUlt := TfrxGroupHeader(frxPage.FindObject('frxGroupHeader' + IntToStr(intRelatPos) + strNomCam + FieldByName('CAM_NOMCAM').AsString));
        If Assigned(frxGroupHeaderUlt) Then
        Begin
          frxHeaderPrincipal := TfrxHeader(frxPage.FindObject('frxHeader' + IntToStr(intRelatPos) + strNomCam));
          If Assigned(frxHeaderPrincipal) Then
          Begin
            frxChildGroupHeaderUlt := TfrxChild.Create(frxPage);
            frxChildGroupHeaderUlt.Name := 'frxChildGroupHeader' + IntToStr(intRelatPos) + strNomCam + FieldByName('CAM_NOMCAM').AsString;
            frxChildGroupHeaderUlt.Assign(frxHeaderPrincipal);
            While frxHeaderPrincipal.Objects.Count > 0 Do
            Begin
              fr3ObjetoChild := frxHeaderPrincipal.Objects[0];
              If Assigned(fr3ObjetoChild) Then
              Begin
                If (fr3ObjetoChild is TfrxShapeView) Then
                  TfrxShapeView(fr3ObjetoChild).Parent := frxChildGroupHeaderUlt
                Else If (fr3ObjetoChild is TfrxCustomMemoView) Then
                  TfrxCustomMemoView(fr3ObjetoChild).Parent := frxChildGroupHeaderUlt
                Else If (fr3ObjetoChild is TfrxLineView) Then
                  TfrxLineView(fr3ObjetoChild).Parent := frxChildGroupHeaderUlt
                Else
                  frxHeaderPrincipal.Objects.Delete(0);
              End;
            End;
            frxGroupHeaderUlt.Child := frxChildGroupHeaderUlt;
            frxHeaderPrincipal.Visible := False;
          End;
        End;
      End;
    End;

    { SE FOR COLOCAR TITULO APÓS AS QUEBRAS }
    If Assigned(frxGroupHeader) And (Pos(FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString, 'D-3') > 0) And (intContaQuebras = 1) Then
    Begin
      frxChild := TfrxChild.Create(frxPage);
      frxChild.Name := 'frxChildHeaderTitulo' + IntToStr(intRelatPos) + strNomCam;
      frxGroupHeader.Child := frxChild;
      frxChild.Top := FCurrentTop + 1;

      frxHeaderModelo := fRetHeader(FfrxModelo);

      If Assigned(frxHeaderModelo) Then
      Begin
        frxChild.Height := frxHeaderModelo.Height;
        frxChild.Font   := frxHeaderModelo.Font;
      End;

      pMontaTitulos(frxChild, False, strNomCam, False);

      FCurrentTop := frxChild.Top + frxChild.Height;
    End;

  End;

  FreeAndNil(stlScriptGroupHeader);
End;

function TGeraFR3.fCriaGroupFooters(strNomCam: string; blnApenasPrincipal: Boolean = False): Boolean;
  Var
    frxGroupFooter,
    frxGroupFooterModelo: TfrxGroupFooter;
    frxTotalGrupo: TfrxCustomMemoView;
    intContador: Integer;
    fltMenorLeft: Double;
    strFormat: String;
    blnTemCampoTotal,
    blnTemChild: Boolean;
    frxUltimoChild: TfrxChild;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := True;

  If SameText(FCadRel[intRelatPos].FieldByName('REL_OMIPAR').AsString, 'S') Then
    Exit;

  frxGroupFooterModelo := fRetGroupFooter(FfrxModelo);

  blnTemCampoTotal := fTemCampoTotal;

  If Assigned(frxGroupFooterModelo) Then
  With FQuebras Do
  Begin
    Last;

    For intContador := 1 To RecordCount Do
    Begin

      //blnTemChild := False;
      //if not TInterfaceRelatorio(objInterfaceGera).cdsChilds.IsEmpty then
      //  blnTemChild := TInterfaceRelatorio(objInterfaceGera).cdsChilds.Locate('REL_NOMCAM', FieldByName('CAM_NOMCAM').AsString, []);

      blnTemChild := not TInterfaceRelatorio(objInterfaceGera).cdsChilds.IsEmpty;

      If blnTemCampoTotal Or (Not fEmptyStr(FieldByName('CAM_MSGGRU').AsString)) Or (blnTemChild) Then
      Begin
        frxGroupFooter := TfrxGroupFooter.Create(frxPage);
        frxGroupFooter.PrintChildIfInvisible := True;
        frxGroupFooter.Name := 'frxGroupFooter' + IntToStr(intRelatPos) + strNomCam + FieldByName('CAM_NOMCAM').AsString;

        frxGroupFooter.Visible := (FieldByName('CAM_REATOT').AsString <> 'N') or blnTemChild;

        if (blnTemCampoTotal and (FieldByName('CAM_REATOT').AsString <> 'N')) or (not fEmptyStr(FieldByName('CAM_MSGGRU').AsString)) then
        begin
          frxGroupFooter.Height := frxGroupFooterModelo.Height;
          frxGroupFooter.Font   := frxGroupFooterModelo.Font;
        end;

        frxGroupFooter.Top := FCurrentTop + 1;

        If blnTemCampoTotal And (FieldByName('CAM_REATOT').AsString <> 'N') Then
        Begin

          fCopiaLine('mmoLinhaGroupFooterInicial', '', 'mmoLinhaGroupFooterInicial' + FieldByName('CAM_NOMCAM').AsString, frxGroupFooter, -1, strNomCam);
          fCopiaLine('mmoLinhaGroupFooterFinal',   '', 'mmoLinhaGroupFooterFinal'   + FieldByName('CAM_NOMCAM').AsString, frxGroupFooter, -1, strNomCam);

          frxTotalGrupo := fCopiaMemoView('mmoTotalGrupo', FCadRel[intRelatPos].FieldByName('REL_TEXTOT').AsString + ' ' + fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString)), 'mmoTotalGrupo' + FieldByName('CAM_NOMCAM').AsString, frxGroupFooter, -1, True, strNomCam);

          If Assigned(frxTotalGrupo) Then
          Begin
            frxTotalGrupo.AutoWidth := True;

            Case FCadRel[intRelatPos].FieldByName('REL_TIPTOT').AsInteger Of
              0: frxTotalGrupo.Text := FCadRel[intRelatPos].FieldByName('REL_TEXTOT').AsString + ' ' + fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString)) + ': ' + fRetCampoRel(FQuebras, strFormat, False, True);
              1: frxTotalGrupo.Text := FCadRel[intRelatPos].FieldByName('REL_TEXTOT').AsString + ' ' + fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString));
              2: frxTotalGrupo.Text := FCadRel[intRelatPos].FieldByName('REL_TEXTOT').AsString + ' ';
              3: frxTotalGrupo.Text := '';
            End;

          End;

          pMontaTotais(frxGroupFooter, frxTotalGrupo, fltMenorLeft, False, strNomCam, FieldByName('CAM_NOMCAM').AsString);

          If (fltMenorLeft > 0) And Assigned(frxTotalGrupo) Then
          Begin
            frxTotalGrupo.AutoWidth := False;
            frxTotalGrupo.Left      := 0;
            frxTotalGrupo.Width     := fltMenorLeft - fRetEspacametoColunas;
          End;

        End
        Else
        Begin
          If fEmptyStr(FieldByName('CAM_MSGGRU').AsString) Then
            frxGroupFooter.Height := 0;
        End;

        FCurrentTop := frxGroupFooter.Top + frxGroupFooter.Height;

        frxUltimoChild := nil;

        if not blnApenasPrincipal then
          if not TInterfaceRelatorio(objInterfaceGera).cdsChilds.IsEmpty then
            if TInterfaceRelatorio(objInterfaceGera).cdsChilds.Locate('REL_NOMCAM', FieldByName('CAM_NOMCAM').AsString, []) then
              frxUltimoChild := fCriaChildDadosGroupFooter(frxGroupFooter, TInterfaceRelatorio(objInterfaceGera).cdsChilds.FieldByName('REL_NOMCAM').AsString);

        If Not fEmptyStr(FieldByName('CAM_MSGGRU').AsString) Then
          Result := fCriaChildGroupFooter(frxGroupFooter, frxUltimoChild, FieldByName('CAM_MSGGRU').AsString, strNomCam);

      End;

      Prior;
    End;

  End;
End;

Function TGeraFR3.fCriaChildGroupFooter(frxGroupFooter: TfrxGroupFooter; frxUltimoChild: TfrxChild; strMensagem, strNomCam: String): Boolean;
  Var
    objFrx: TfrxComponent;
    sltRodape: TStringList;
    frxChildFooter,
    frxChildFooterModelo: TfrxChild;
    mmoMsgRod: TfrxCustomMemoView;
Begin
  frxChildFooterModelo := TfrxChild(FfrxModelo.FindObject('childGroupFooter'));

  If Assigned(frxChildFooterModelo) And Assigned(frxGroupFooter) Then
  Begin
    frxChildFooter := TfrxChild.Create(frxPage);
    frxChildFooter.Stretched := True;
    frxChildFooter.Name := frxGroupFooter.Name + 'Child';
    if frxUltimoChild <> nil then
      frxUltimoChild.Child := frxChildFooter
    else
      frxGroupFooter.Child := frxChildFooter;
    frxChildFooter.Height := frxChildFooterModelo.Height;
    frxChildFooter.Top := FCurrentTop + 1;

    objFrx := FfrxModelo.FindObject('mmoMensagemGroupFooter');

    If Assigned(objFrx) Then
    Begin
      sltRodape := TStringList.Create;
      sltRodape.Text := AnsiReplaceStr(strMensagem, '<<csq>>', #13#10);

      mmoMsgRod := fCopiaMemoView('mmoMensagemGroupFooter', '', frxChildFooter.Name + 'Msg', frxChildFooter, -1, True, strNomCam);
      mmoMsgRod.StretchMode := smMaxHeight;

      If Assigned(mmoMsgRod) Then
        mmoMsgRod.Text := sltRodape.Text;

      sltRodape.Clear;
      FreeAndNil(sltRodape);

      FCurrentTop := frxChildFooter.Top + frxChildFooter.Height;
    End;

  End;

  Result := True;
End;

Function TGeraFR3.fAlimentaSubreport(intContRel: Integer; strCodRel, strNomCam: string): TfrxReportPage;
  Var
    frxReportPage: TfrxReportPage;
    mmsLoadPage: TMemoryStream;
    frxPageComple: TfrxPage;
    intIndice,
    intContChildComp: Integer;
    objRel: Pointer;
    objRelat: TRelatorio;
Begin

  Result := nil; // para evitar warning

  SetLength(FTitulosRelatorio, Length(FCadRel));
  SetLength(FSubTitulosRelatorio, Length(FCadRel));

  with FCadRel[intContRel] Do
  if fLoadReportComp(FCadRel[intContRel], intContRel, objRel, True, True, strNomCam) then
  begin
    FControleRel[intContRel].blnPrint := True;

    objRelat := objRel;

    if FJato then
      frxReportPage := TfrxReportPage.Create(frxReport)
    else
      frxReportPage := TfrxDMPPage.Create(frxReport);

    frxReportPage.PrintIfEmpty := False;

    frxReportPage.Name := 'frxPage' + IntToStr(intContRel) + '_' + strCodRel + strNomCam;

    // criação das páginas que foram relacionadas nos subrelatórios dos childs criados nesse child
    intContChildComp := 0;
    for intIndice := 0 to objRelat.objGeraFr3.frxReport.ComponentCount - 1 do
    begin
      if (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxReportPage) or (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxDMPPage) then
      begin
        // if para criar páginas para os childs criados nesse child
        if intContChildComp > 0 then
        begin
          if FJato then
            TfrxReportPage.Create(frxReport)
          else
            TfrxDMPPage.Create(frxReport);

          frxReport.Pages[frxReport.PagesCount-1].Name := objRelat.objGeraFr3.frxReport.Components[intIndice].Name;
        end;
        Inc(intContChildComp);
      end;
    end;

    // alimentação das páginas criadas pelo rotina da alimentação do child
    intContChildComp := 0;
    for intIndice := objRelat.objGeraFr3.frxReport.ComponentCount - 1 downto 0 do
    begin

      if (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxReportPage) or (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxDMPPage) then
      begin

        frxPageComple := (objRelat.objGeraFr3.frxReport.Components[intIndice] As TfrxReportPage);
        mmsLoadPage := TMemoryStream.Create;
        frxPageComple.SaveToStream(mmsLoadPage);
        mmsLoadPage.Position := 0;
        frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].LoadFromStream(mmsLoadPage);

        If SameText(FCadRel[intContRel].FieldByName('REL_ORIENT').AsString, 'R') Then
          frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].Tag := 0
        Else
          frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].Tag := 1;

        FreeAndNil(mmsLoadPage);

        Inc(intContChildComp);
      end
    end;

    SetLength(arrSalvaComplementos, Succ(Length(arrSalvaComplementos)));
    arrSalvaComplementos[High(arrSalvaComplementos)] := objRelat;

    Result := frxReportPage;
  end;

End;

function TGeraFR3.fBuscaControleRel(intIndice: Integer; strCodRel, strNomCam: string; blnChild: Boolean): Integer;
var
  intContador: Integer;
  strComple: string;
begin
  Result := 0;

  // essa função tem por objetivo controlar os relatórios, devolvendo o índice correto
  strComple := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [strCodRel]);
  for intContador := Succ(Low(FControleRel)) to High(FControleRel) do
  begin
    if (FControleRel[intContador].strMaster = FCadRel[intRelatPos].FieldByName('AUTOINCREM').AsString) and
       (FControleRel[intContador].strComple = strComple) and
       (FControleRel[intContador].strNomCam = strNomCam) and
       (FControleRel[intContador].blnChild = blnChild) and
       (intContador > intIndice) then
    begin
      Result := intContador;
      Break;
    end;
  end;
end;

Function TGeraFR3.fCriaChildDadosGroupFooter(frxGroupFooter: TfrxGroupFooter; strNomCam: String): TfrxChild;
  Var
    frxSubReport: TfrxSubReport;
    sltCamLig: TStringList;
    frxChildFooter,
    frxUltimoChild,
    frxChildFooterModelo: TfrxChild;
    intContador,
    intContRel,
    intIndice: Integer;
    strCodRel,
    strCamLig,
    strValores: string;
    qryChilds: TUniQuery;
Begin

  frxUltimoChild := nil;
  frxChildFooterModelo := TfrxChild(FfrxModelo.FindObject('childGroupFooter'));

  If Assigned(frxChildFooterModelo) And Assigned(frxGroupFooter) Then
  Begin

    qryChilds  := fCriaQuery;
    with qryChilds, SQL Do
    begin
      Add(' SELECT R.REL_CODREL AS CODREL, C.REL_CAMLIG AS CAMLIG ');
      Add('   FROM CHIREL C JOIN CADREL R ON C.REL_COMPLE = R.AUTOINCREM ');
      Add(' WHERE TRUE ');
      Add('   AND C.REL_MASTER = ' + QuotedStr(FCadRel[intRelatPos].FieldByName('AUTOINCREM').AsString) + ' ');
      Add('   AND C.REL_NOMCAM = ' + QuotedStr(strNomCam) + ' ');
      Add(' ORDER BY C.REL_ORDENA ');
      Open;

      intIndice := intRelatPos;

      while not Eof do
      begin
        strCodRel  := FieldByName('CODREL').AsString;
        strCamLig  := FieldByName('CAMLIG').AsString;
        intContRel := fBuscaControleRel(intIndice, strCodRel, strNomCam, True);
        intIndice  := intContRel;

        frxChildFooter := TfrxChild.Create(frxPage);
        frxChildFooter.Stretched := True;
        frxChildFooter.Name := frxGroupFooter.Name + 'ChildDados' + strCodRel + '_' + strNomCam;
        if frxUltimoChild <> nil then
          frxUltimoChild.Child := frxChildFooter
        else
          frxGroupFooter.Child := frxChildFooter;
        frxChildFooter.Height := frxChildFooterModelo.Height;
        frxChildFooter.Top := FCurrentTop + 1;

        // definindo evento BeforePrint da child
        frxChildFooter.OnBeforePrint := 'p' + frxChildFooter.Name + 'BeforePrint';

        try
          strValores := '';
          sltCamLig := Split(strCamLig, ',');
          for intContador := 0 to sltCamLig.Count - 1 do
            strValores := strValores + IIF(fEmptyStr(strValores), '', ' + '';'' + ') + '<' + fDataSetName(intRelatPos) + '."' + sltCamLig[intContador] + '">';
        finally
          FreeAndNil(sltCamLig);
        end;

        // escrevendo evento BeforePrint
        with stlScriptImplementation do
        begin
          Add('');
          Add('procedure ' + frxChildFooter.OnBeforePrint + '(Sender: TfrxComponent);');
          Add('begin');
          Add('  fFiltraDadosChild(' + IntToStr(intContRel) + ', ' + QuotedStr(strCodRel) + ', ' + QuotedStr(strNomCam) + ', ' + QuotedStr(AnsiReplaceStr(strCamLig, ',', ';')) + ', ' + strValores + '); ');
          Add('end;')
        end;

        // aqui eu crio um subreport dentro do child e relaciono com a nova página
        frxSubReport := TfrxSubReport.Create(frxChildFooter);
        frxSubReport.Name := 'frxSubReport' + IntToStr(intRelatPos) + '_' + strCodRel + strNomCam;
        frxSubReport.Page := fAlimentaSubreport(intContRel, strCodRel, strNomCam);

        FCurrentTop := frxChildFooter.Top + frxChildFooter.Height;

        frxUltimoChild := frxChildFooter;

        Next;
      end;

    end;
    FreeAndNil(qryChilds);

  End;

  Result := frxUltimoChild;
End;

function TGeraFR3.fLoadModelo(qryCadMod: TUniQuery): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;

  Try
    With qryCadMod Do
    Begin

      If Not FieldByName('MOD_RELFR3').IsNull Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('MOD_RELFR3'), bmRead);
        FFrxModelo.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadModelo]');
    End;
  End;

End;

function TGeraFR3.fLoadRelatorio(): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;

  fCriaPagina;

  Try
    if (FCadRel[intRelatPos].FieldByName('REL_FR3FAS').AsString = '') Then
    Begin
      with FCadRel[intRelatPos] do
      begin
        mmsLoad := CreateBlobStream(FieldByName('REL_RELFR3'), bmRead);
        FFrxReport.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      end;

      Result := True;
    End
    else if (FCadRel[intRelatPos].FieldByName('REL_FR3FAS').AsString <> '') Then
    Begin
      with FCadRel[intRelatPos] do
      begin
        mmsLoad := CreateBlobStream(FieldByName('REL_FR3FAS'), bmRead);
        FFrxReport.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      end;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;

End;

function TGeraFR3.fLoadReport(qryTabela: TUniQuery; frxReport: TFrxReport): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;

  Try
    With qryTabela Do
    Begin

      If Not FieldByName('REL_RELFR3').IsNull Then
      Begin
        Result := True;
        mmsLoad := CreateBlobStream(FieldByName('REL_RELFR3'), bmRead);
        frxReport.LoadFromStream(mmsLoad);
        FreeAndNil(mmsLoad);
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

End;

Procedure TGeraFR3.pSetCodMod(Value: String);
Begin
  FCodMod := Value;
  FCarregouPagina := (Not fEmptyStr(FCodMod)) And fCarregaModelo And fCriaPagina;
End;

Procedure TGeraFR3.pSetOrientation(Value: TPrinterOrientation);
Begin
  If Value <> FOrientation Then
  Begin
    FOrientation := Value;
    FOrientationOriginal := Value;
    FCarregouPagina := fCarregaModelo And fCriaPagina;
  End;
End;

Function TGeraFR3.fLarguraPagina: Integer;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
  Begin
    if (FPaper = FOLHA_CUSTOM) then
      frxPage.PaperWidth := 78;

    Result := Ceil(fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, FTipImp, False));

   {
    If FJato Then
      If FOrientation = poLandscape Then
        Result := Result + 2
      Else
        Result := Result + 3;
        }

  End Else
    Result := 0;
End;

Function TGeraFR3.fMargemEsquerda: Integer;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
    Result := Trunc(fCmColunaToPixel(frxPage.LeftMargin / 10, False, FTipImp, False))
  Else
    Result := 0;
End;

Function TGeraFR3.fMargemDireita: Integer;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
    Result := Trunc(fCmColunaToPixel(frxPage.RightMargin / 10, False, FTipImp, False))
  Else
    Result := 0;
End;

Function TGeraFR3.fLarguraPaginaOriginal: Integer;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
    Result := Trunc(fCmColunaToPixel(FPaperWidthOriginal / 10, False, FTipImp, False))
  Else
    Result := 0;
End;

Function TGeraFR3.fGetMaxLarCam(intQtdCam: Integer): Double;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
  Begin
    if (FPaper = FOLHA_CUSTOM) then
      frxPage.PaperWidth := 78;

    If frxPage.PaperWidth < 1 Then
      frxPage.PaperWidth := 0;

    If FJato Then
      Result := (frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10
    Else
      Result := (FColunasMatricial - (frxPage.LeftMargin / 2.54) - (frxPage.RightMargin / 2.54));

    Result := Result - fGetLarguraEspacamentoUsada(intQtdCam);

    If Result < 1 Then
      Result := 0;
  End

  Else
    Result := 0;
End;

Function TGeraFR3.fGetLarguraPaginaPix: Integer;
Begin
  If FCarregouPagina And Assigned(frxPage) Then
  Begin
    if (FPaper = FOLHA_CUSTOM) then
      frxPage.PaperWidth := 78;

    If frxPage.PaperWidth < 1 Then
      frxPage.PaperWidth := 0;

    Result := Ceil(fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False));

    If Result < 1 Then
      Result := 0;
  End

  Else
    Result := 0;
End;


Function TGeraFR3.fGetLarguraEspacamentoUsada(intQtdCam: Integer): Double;
Begin
  If FJato Then
    Result := fPixelToCmColuna( (intQtdCam - 1) * fRetEspacametoColunas, False, FTipImp)
  Else
    Result := (intQtdCam - 1);
End;

Function TGeraFR3.fCarregaModelo: Boolean;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  With FCadMod, SQL Do
  Begin

    If IsEmpty Or (FCodMod <> FieldByName('MOD_CODMOD').AsString) Then
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CADMOD WHERE MOD_CODMOD = :CODMOD');
      ParamByName('CODMOD').AsString := FCodMod;

      Open;
    End;

    If IsEmpty Then
    Begin
      Result := False;
      pMensagemOk('Modelo de Relatório ' + FCodMod + ' não encontrado!');
    End Else
    Begin
      FJato   := SameText(FieldByName('MOD_TIPIMP').AsString, 'J');
      FTipImp := FieldByName('MOD_TIPIMP').AsString;

      FFrxModelo.DotMatrixReport := Not FJato;

      Result := fLoadModelo(FCadMod);
    End;

  End;
End;

Function TGeraFR3.fCriaBase(Var Base: TdtmRelFrx): TfrxReport;
Begin
  If Assigned(Base) Then
    FreeAndNil(Base);

  try
    Base := TdtmRelFrx.Create(Self);
  except
    Raise Exception.Create('Erro ao Criar os Dados do Relatório');
  end;

  Base.objGeraFr3 := Self;

  If FJato Then
  Begin
    Result := Base.frxReportJ;
  End Else
  Begin
    Result := Base.frxReportM;
  End;

  pAddFunction(Result);
End;

Function TGeraFR3.fCriaPagina: Boolean;
  Var
    frxPageModelo: TfrxReportPage;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  FfrxReport := fCriaBase(FBase);

  frxPage := fRetReportPage(FfrxReport);

  If Assigned(frxPage) Then
  Begin
    frxPage.PrintIfEmpty := False;

    frxPage.Name := fPageName(intRelatPos);

    frxPageModelo := fRetReportPage(FfrxModelo);

    frxPage.PaperSize    := FPaper;
    frxPage.Orientation  := FOrientation;

    FPaperWidthOriginal  := frxPage.PaperWidth;

    If FFatorScale > 1 Then
    Begin
      frxPage.PaperSize   := FOLHA_CUSTOM;
      frxPage.PaperWidth  := FFatorScale * frxPage.PaperWidth;

      If FSplit Then
      Begin
        FfrxReport.PrintOptions.PrintMode := pmSplit;
      End Else
      Begin
        frxPage.PaperHeight := FFatorScale * frxPage.PaperHeight;
        FfrxReport.PrintOptions.PrintMode := pmScale;
      End;

      FfrxReport.PrintOptions.PrintOnSheet := FPaper;
    End;

    // Mexi nos pontos que tratava T40 com escala, que gerava impressão errada.
    // Deixei isso por desencargo de consciência, mas acho que não vai precisar.
    if (FPaper = FOLHA_CUSTOM) then
      FfrxReport.PrintOptions.PrintOnSheet := FPaper;

    If Assigned(frxPageModelo) Then
    Begin

      If FJato Then
      Begin
        frxPage.TopMargin    := frxPageModelo.TopMargin;
        frxPage.LeftMargin   := frxPageModelo.LeftMargin;
        frxPage.BottomMargin := frxPageModelo.BottomMargin;
        frxPage.RightMargin  := frxPageModelo.RightMargin;

        If FSplit Then
        Begin
          If frxPage.LeftMargin < 7.5 Then
            frxPage.LeftMargin := 7.5;

          If frxPage.RightMargin < 7.5 Then
            frxPage.RightMargin := 7.5;
        End;

        If (FFatorScale > 1) And FSplit Then
          frxPage.PaperWidth := frxPage.PaperWidth - (FFatorScale - 1) * IfThen(frxPage.LeftMargin < 12, 12, frxPage.LeftMargin);

        If Assigned(FCadRel) And (Length(FCadRel) > 0) And (FCadRel[intRelatPos].FieldByName('REL_INFHEI').AsString = 'S') Then
        Begin
          frxPage.PaperHeight := FCadRel[intRelatPos].FieldByName('REL_PAPHEI').AsFloat * 10;
        End;

        if (FPaper = FOLHA_CUSTOM) then
        begin
          frxPage.PaperWidth    := 78;
          frxPage.EndlessHeight := True;
        end;

      End Else
      Begin
        frxPage.TopMargin    := 0;
        frxPage.BottomMargin := 0;

        If Assigned(FCadRel) And (Length(FCadRel) > 0) Then
        Begin
          frxPage.LeftMargin  := FCadRel[intRelatPos].FieldByName('REL_MARESQ').AsFloat * 2.54;
          frxPage.RightMargin := FCadRel[intRelatPos].FieldByName('REL_MARDIR').AsFloat * 2.54;
        End
        Else
        Begin
          frxPage.LeftMargin  := 0;
          frxPage.RightMargin := 0;
        End;

        If Assigned(FCadRel) And (Length(FCadRel) > 0) And (FCadRel[intRelatPos].FieldByName('REL_ALTMOD').AsString = 'S') Then
          frxPage.PaperHeight  := frxPageModelo.PaperHeight
        Else
          frxPage.PaperHeight  := 287.866480752898;

        if FColunasMatricial = 50 then
          frxPage.EndlessHeight := True;

        frxPage.PaperWidth  := WIDTH_MAT[fColunasToPagMat(FColunasMatricial)];
      End;

    End;

  End;

  Result := True;

  pIniciaLeftFolhas;
End;

Procedure TGeraFR3.pIniciaLeftFolhas;
  Var
    intPosX,
    intLargura,
    intContador: Integer;
Begin
  SetLength(FarrLeftsFolhas, 0);

  If FSplit Then
  Begin
    SetLength(FarrLeftsFolhas, Ceil(FFatorScale));
    FarrLeftsFolhas[0].intEsquerda := 0;
    FarrLeftsFolhas[0].intDireita := 0;
  End;

  intPosX := (fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita);

  For intContador := 1 To Length(FarrLeftsFolhas) - 1 Do
  Begin
    If intContador = 1 Then
      intLargura := 25              // 0.66 cm
    Else
      intLargura := FMargemEsquerda; // 38  1.00 cm

    FarrLeftsFolhas[intContador].intEsquerda := intPosX;
    FarrLeftsFolhas[intContador].intDireita  := intPosX + intLargura;

    Inc(intPosX, (fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita) + intLargura)
  End;
End;

Procedure TGeraFR3.pCopyMemoView(mmofonte, mmodestino: TfrxCustomMemoView; strName, strText, strNomCam: String);
Begin
  With mmoDestino Do
  Begin
    Color  := mmofonte.Color;
    Top    := mmofonte.Top;
    Left   := mmofonte.Left;
    Width  := mmofonte.Width;
    Height := mmofonte.Height;
    Align  := mmofonte.Align;
    HAlign := mmofonte.HAlign;
    Font   := mmofonte.Font;
    ParentFont := mmofonte.ParentFont;
    Highlight  := mmofonte.Highlight;

    WordBreak := mmofonte.WordBreak;
    WordWrap  := mmofonte.WordWrap;

    DisplayFormat := mmofonte.DisplayFormat;

    AutoWidth := mmofonte.AutoWidth;

    If fEmptyStr(strName) Then
      Name := mmofonte.Name + FCodRels[0] + strNomCam
    Else
      Name := strName + FCodRels[0] + strNomCam;

    If fEmptyStr(strText) Then
      Text := mmofonte.Text
    Else
      Text := strText;
  End;
End;

Procedure TGeraFR3.pCopyComand(strNomeFonte: String; strComando: String; frxPai: TfrxComponent);
  Var
    mmofonte: TfrxDMPCommand;
    mmodestino: TfrxDMPCommand;
Begin
  mmofonte := TfrxDMPCommand(FfrxModelo.FindObject(strNomeFonte));

  If Not Assigned(mmofonte) Then
    Exit;

  mmodestino := TfrxDMPCommand.Create(frxPai);

  With mmoDestino Do
  Begin
    Top    := mmofonte.Top;
    Left   := mmofonte.Left;
    Width  := mmofonte.Width;
    Height := mmofonte.Height;
    Align  := mmofonte.Align;
    Name   := mmofonte.Name + FCodRels[0];

    If fEmptyStr(strComando) Then
      Command := mmofonte.Command
    Else
      Command := strComando;
  End;
End;

Procedure TGeraFR3.pCopyShape(mmofonte, mmodestino: TfrxShapeView; strName, strNomCam: String);
Begin
  With mmoDestino Do
  Begin
    Color  := mmofonte.Color;
    Top    := mmofonte.Top;
    Left   := mmofonte.Left;
    Width  := mmofonte.Width;
    Height := mmofonte.Height;
    Align  := mmofonte.Align;

    If fEmptyStr(strName) Then
      Name := mmofonte.Name + FCodRels[0] + strNomCam
    Else
      Name := strName + FCodRels[0] + strNomCam;
  End;
End;

Procedure TGeraFR3.pCopyLine(mmofonte, mmodestino: TfrxCustomLineView; strName, strNomCam: String);
Begin
  With mmoDestino Do
  Begin
    Color  := mmofonte.Color;
    Top    := mmofonte.Top;
    Left   := mmofonte.Left;
    Width  := mmofonte.Width;
    Height := mmofonte.Height;
    Align  := mmofonte.Align;

    If fEmptyStr(strName) Then
      Name := mmofonte.Name + FCodRels[0] + strNomCam
    Else
      Name := strName + FCodRels[0] + strNomCam;
  End;
End;

Procedure TGeraFR3.pSetaAlturaComponente(frxComp: TfrxComponent; fltAltura: Double; blnMinima: Boolean);
Begin
  If (Not blnMinima) Or (frxComp.Height < fltAltura) Then
    frxComp.Height := fltAltura;
End;

Function TGeraFR3.fCriaMemoView(Owner: TComponent): TfrxCustomMemoView;
Begin
  If FTipImp = 'J' Then
    Result := TfrxMemoView.Create(Owner)
  Else
  Begin
    Result := TfrxDMPMemoView.Create(Owner);
    TfrxDMPMemoView(Result).TruncOutboundText := True;
  End;
  Inc(FSeqMemo);
  Result.Name := 'Memo' + FSeqMemo.ToString;
End;

Function TGeraFR3.fCopiaMemoView(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; blnMinima: Boolean = True; strNomCam: string = ''): TfrxCustomMemoView;
  Var
    objFrx: TfrxComponent;
    mmoOrigem,
    mmoDestino: TfrxCustomMemoView;
    fltTopComp: Double;
Begin
  Result := Nil;

  objFrx := FfrxModelo.FindObject(strNomComp);
  If Assigned(objFrx) Then
  Begin
    mmoOrigem := TfrxCustomMemoView(objfrx);

    If fltTop = -1 Then
      fltTopComp := mmoOrigem.Top
    Else
      fltTopComp := fltTop;

    pSetaAlturaComponente(frxPai, mmoOrigem.Height + fltTopComp, blnMinima);

    mmoDestino := fCriaMemoView(frxPai);

    pCopyMemoView(mmoOrigem, mmoDestino, strNomDestino, strTexto, strNomCam);

    If fltTop <> -1 Then
      mmoDestino.Top := fltTop;

    If FTipImp = 'M' Then
      TfrxDMPMemoView(mmoDestino).TruncOutboundText := True;

    Result := mmoDestino;
  End;
End;

Function TGeraFR3.fCriaPictureView(Owner: TComponent): TfrxPictureView;
Begin
  Result := TfrxPictureView.Create(Owner);
  Inc(FSeqMemo);
  Result.Name := 'Memo' + FSeqMemo.ToString;
End;

Function TGeraFR3.fCopiaLine(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; strNomCam: string): TfrxCustomLineView;
  Var
    objFrx: TfrxComponent;
    mmoOrigem,
    mmoDestino: TfrxCustomLineView;
    fltTopComp: Double;
    fltHeight: Double;
Begin
  Result := Nil;

  objFrx := FfrxModelo.FindObject(strNomComp);
  If Assigned(objFrx) Then
  Begin
    mmoOrigem := TfrxCustomLineView(objfrx);

    If fltTop = -1 Then
    Begin
      fltTopComp := mmoOrigem.Top;

      If FTipImp = 'M' Then
        fltTopComp := (Trunc(fltTopComp) Div 17) * 17;
    End Else
    Begin
      fltTopComp := fltTop;
    End;

    If FTipImp = 'J' Then
      fltHeight := mmoOrigem.Height
    Else
      fltHeight := 17;

    pSetaAlturaComponente(frxPai, fltHeight + fltTopComp, True);

    If FTipImp = 'M' Then
      mmoDestino := TfrxDMPLineView.Create(frxPai)
    Else
      mmoDestino := TfrxLineView.Create(frxPai);

    pCopyLine(mmoOrigem, mmoDestino, strNomDestino, strNomCam);

    If fltTop <> -1 Then
      mmoDestino.Top := fltTop;

    mmoDestino.Frame := mmoOrigem.Frame;

    Result := mmoDestino;
  End;
End;

Function TGeraFR3.fCopiaShape(strNomComp, strTexto, strNomDestino: String; frxPai: TfrxComponent; fltTop: Double; strNomCam: string): TfrxShapeView;
  Var
    objFrx: TfrxComponent;
    mmoOrigem,
    mmoDestino: TfrxShapeView;

    fltTopComp: Double;
Begin
  Result := Nil;

  objFrx := FfrxModelo.FindObject(strNomComp);
  If Assigned(objFrx) Then
  Begin
    mmoOrigem := TfrxShapeView(objfrx);

    If fltTop = -1 Then
      fltTopComp := mmoOrigem.Top
    Else
      fltTopComp := fltTop;

    pSetaAlturaComponente(frxPai, mmoOrigem.Height + fltTopComp, True);

    mmoDestino := TfrxShapeView.Create(frxPai);

    pCopyShape(mmoOrigem, mmoDestino, strNomDestino, strNomCam);

    If fltTop <> -1 Then
      mmoDestino.Top := fltTop;

    Result := mmoDestino;
  End;
End;

function TGeraFR3.fValidaExpImp(FParametros: TZClient): Boolean;
type
  TExpressoesImp = Record
    strExpressao: String;
    intValor: integer;
  End;
var
  intRecNo, intRecNoParams, intValorGravado: Integer;
  blnErro: Boolean;
  strExpressao, strIndexFieldNamesParams: String;
  FArrExpImp: Array Of TExpressoesImp;

  function fTemExpImpGravada(strExpImp: string; var intValorGravado: Integer): Boolean;
  var
    intCont: Integer;
  begin
    Result := False;
    for intCont := 0 to Length(FArrExpImp) - 1 do
    begin
      if FArrExpImp[intCont].strExpressao = strExpImp then
      begin
        Result := True;
        intValorGravado := FArrExpImp[intCont].intValor;
        Break;
      end;
    end;
  end;

begin
  Result := False;
  SetLength(FArrExpImp, 0);
  with FParametros do
  begin
    DisableControls;
    intRecNo := RecNo;
    First;
    while Not Eof do
    begin
      If Not fEmptyStr(FieldByName('PAR_EXPIMP').AsString) Then
      Begin
        strExpressao := FieldByName('PAR_EXPIMP').AsString;
        intValorGravado := 1;
        if not fTemExpImpGravada(strExpressao, intValorGravado) then
        begin
          Result := True;
          SetLength(FArrExpImp, Succ(Length(FArrExpImp)));
          FArrExpImp[High(FArrExpImp)].strExpressao := strExpressao;
          strExpressao := AnsiReplaceStr(strExpressao, STR_DESTINO, QuotedStr(string(ArrDestino[TInterfaceRelatorio(objInterfaceGera).fRetDestino])));
          strExpressao := TInterfaceRelatorio(objInterfaceGera).fValidaCfgSis(strExpressao);
          strExpressao := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(strExpressao);
          intRecNoParams := RecNo;
          strIndexFieldNamesParams := IndexFieldNames;
          strExpressao := fColocaValoresExpressao(strExpressao, blnErro);
          IndexFieldNames := strIndexFieldNamesParams;
          RecNo := intRecNoParams;
          Edit;
          FieldByName('IMPFIL').AsInteger := IIF(Not blnErro, IIF(fExecutaExpressao(strExpressao, True), 1, 0), 1);
          Post;
          FArrExpImp[High(FArrExpImp)].intValor := FieldByName('IMPFIL').AsInteger;
        end
        else
        begin
          Edit;
          FieldByName('IMPFIL').AsInteger := intValorGravado;
          Post;
        end;

      End;
      Next;
    end;
    RecNo := intRecNo;
    EnableControls;
  End;
end;

Procedure TGeraFR3.pCriaParametros(strNomCam: string);
  Var
    intQtdParam,
    intContador: Integer;
    mmoFiltro1,
    mmoFiltro2: TfrxCustomMemoView;
    fltTop: Double;
    blnLadoaLado: Boolean;
    fltLeft,
    fltLeftSplit,
    fltWidth: Double;
    pAfterPost: TDataSetNotifyEvent;

  procedure pCriaParametrosInterno(FParametros: TZClient; blnParamsAut: Boolean = False);
    Var
      strValor: String;
      blnExpImp: Boolean;

  begin

    blnExpImp := fValidaExpImp(FParametros);

    With FParametros Do
    Begin

      If blnExpImp Then
        Filter := Filter + IIF(Not fEmptyStr(Filter), ' AND ', '') + 'IMPFIL = 1';

      if not blnParamsAut then
        IndexFieldNames := 'PAR_ORDENA'
      else
      begin
        Filtered := False;
        Filter := 'PAR_NOMPAR <> ' + QuotedStr('DESTINO_REL') + ' AND PARVIS = 1' + IIF(blnExpImp, ' AND IMPFIL = 1', '');
        Filtered := True;
      end;

      if (intQtdParam = 0) then
      begin
        fltLeft  := 0;
        fltWidth := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False) - 3 * fCmColunaToPixel(1, False, FTipImp, False);

        If FSplit And (Length(FarrLeftsFolhas) > 0) Then
          fltLeftSplit := FarrLeftsFolhas[1].intDireita
        Else
         fltLeftSplit := 0;

        mmoFiltro1 := Nil;
        blnLadoaLado := False;
      end;

      First;

      If (Not Eof) And (RecordCount > 0) And (intQtdParam = 0) Then
      Begin
        If SameText(FieldByName('PAR_NOMPAR').AsString, 'FILTRO_GRID') Then
          strValor := FParams.FieldByName('VALOR').AsString
        Else
          strValor := '[TITULO_' + FieldByName('PAR_NOMPAR').AsString  + ']';

        mmoFiltro1 := fCopiaMemoView('mmoFiltro1', strValor, '',  frxChildPageHeader, -1, True, strNomCam);

        If Assigned(mmoFiltro1) Then
        begin
          Inc(intQtdParam);
          if (FCadRel[intRelatPos].FieldByName('REL_QBRFIL').AsString = 'S') then
          begin
            mmoFiltro1.StretchMode := smMaxHeight;
            mmoFiltro1.WordWrap := True;
          end
          else
            mmoFiltro1.WordWrap := False;
        end;

        Next;
      End;

      If Assigned(mmoFiltro1) And (intQtdParam > 0) Then
      Begin
        If FTipImp = 'M' Then
          mmoFiltro1.Width := fltWidth;

        If (Not Eof) And (((RecordCount > 1) And (Not blnParamsAut)) Or ((Not Assigned(mmoFiltro2)) And (blnParamsAut))) Then
        Begin
          If SameText(FieldByName('PAR_NOMPAR').AsString, 'FILTRO_GRID') Then
            strValor := FParams.FieldByName('VALOR').AsString
          Else
            strValor := '[TITULO_' + FieldByName('PAR_NOMPAR').AsString  + ']';

          mmoFiltro2 := fCopiaMemoView('mmoFiltro2', strValor, '', frxChildPageHeader, -1, True, strNomCam);

          If Assigned(mmoFiltro2) Then
          Begin
            Inc(intQtdParam);
            if (FCadRel[intRelatPos].FieldByName('REL_QBRFIL').AsString = 'S') then
            begin
              mmoFiltro2.StretchMode := smMaxHeight;
              mmoFiltro2.WordWrap := True;
            end
            else
              mmoFiltro2.WordWrap := False;
            blnLadoaLado := Abs(RoundTo(mmoFiltro1.Top, -2) - RoundTo(mmoFiltro2.Top, -2)) < mmoFiltro1.Height;

            If blnLadoaLado Then
              If FSplit Then
                fltWidth := fltLeftSplit - 3 * fRetEspacametoColunas
              Else
                fltWidth := (fltWidth - fCmColunaToPixel(2, False, FTipImp, False)) / 2 - 3 * fRetEspacametoColunas;

            mmoFiltro1.Width := fltWidth;
            mmoFiltro2.Width := fltWidth;

            If blnLadoaLado Then
            Begin
              If FSplit Then
                mmoFiltro2.Left := fltLeftSplit
              Else
              Begin
                mmoFiltro2.Left := mmoFiltro1.Width + 3 * fRetEspacametoColunas;
                If FCadRel[intRelatPos].FieldByName('REL_FILLAT').AsString = 'S' Then
                Begin
                  mmoFiltro2.Align  := baWidth;
                  mmoFiltro2.HAlign := TfrxHAlign.haRight;
                End;
              End;

              fltLeft := mmoFiltro2.Left;

            End;

            mmoFiltro1 := mmoFiltro2;
            Next;
          End;
        End;

        If Assigned(mmoFiltro1) Then
        Begin
          if (intQtdParam = 2) then
          begin
            fltTop :=  mmoFiltro1.Top + mmoFiltro1.Height + fIncTop;
            intContador := 2;
          end;

          While Not Eof Do
          Begin
            If (Not blnLadoaLado) Or (intContador Mod 2 = 0) Then
              fltTop := mmoFiltro1.Top + mmoFiltro1.Height + fIncTop;

            If SameText(FieldByName('PAR_NOMPAR').AsString, 'FILTRO_GRID') Then
              strValor := FParams.FieldByName('VALOR').AsString
            Else
              strValor := '[TITULO_' + FieldByName('PAR_NOMPAR').AsString  + ']';

            mmoFiltro1 := fCopiaMemoView('mmoFiltro' + IntToStr((intContador Mod 2) + 1), strValor,
                                         'mmoFiltro' + IntToStr(intContador + 1), frxChildPageHeader, fltTop, True, strNomCam);
            mmoFiltro1.Width := fltWidth;
            Inc(intQtdParam);
            if (FCadRel[intRelatPos].FieldByName('REL_QBRFIL').AsString = 'S') then
            begin
              mmoFiltro1.StretchMode := smMaxHeight;
              mmoFiltro1.WordWrap := True;
            end
            else
              mmoFiltro1.WordWrap := False;

            If blnLadoaLado And (intContador Mod 2 <> 0) Then
            Begin
              mmoFiltro1.Left := fltLeft;
              If FCadRel[intRelatPos].FieldByName('REL_FILLAT').AsString = 'S' Then
              Begin
                mmoFiltro1.Align  := baWidth;
                mmoFiltro1.HAlign := TfrxHAlign.haRight;
              End;
            End;

            Next;

            Inc(intContador);
          End;

          If blnLadoaLado And (RecordCount Mod 2 <> 0) Then
            mmoFiltro1.Width := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin)/ 10, False, 'J', False) - mmoFiltro1.Left - fCmColunaToPixel(2, False, FTipImp, False);

         End;
      End;

      if blnParamsAut or blnExpImp then
      begin
        Filtered := False;
        Filter := '';
      end;

    End;

  End;

Begin

  intQtdParam := 0;

  If (fGetInterface <> Nil) And
     TInterfaceRelatorio(fGetInterface).blnImpressaoGrid And
     (Not fEmptyStr(TInterfaceRelatorio(fGetInterface).strFiltroGrid)) Then
  Begin
    If Not FParams.locate('PAR_NOMPAR', 'FILTRO_GRID', []) Then
    Begin
      pAfterPost := FParams.AfterPost;
      FParams.AfterPost := Nil;

      FParams.Append;
      FParams.FieldByName('PAR_NOMPAR').AsString := 'FILTRO_GRID';
      FParams.FieldByName('VALOR').AsString := '[FILTRO_GRID]';
      FParams.FieldByName('PARVIS').AsInteger := 1;
      FParams.FieldByName('PARIMP').AsInteger := 1;
      FParams.FieldByName('IMPFIL').AsInteger := 1;
      FParams.Post;

      FParams.AfterPost := pAfterPost;
    End;
  End;

  pCriaParametrosInterno(FParams);
  pCriaParametrosInterno(FParamsAut, True);

  If Assigned(objInterfaceGera) Then
  Begin
    If FParams.locate('PAR_NOMPAR', 'FILTRO_GRID', []) Then
      FParams.Delete;
  End;

End;

Function TGeraFR3.fTemCodBarCabecalho: Boolean;
Begin
  FCampos.DisableControls;
  FCampos.Filter   := 'CAM_CAMBAR <> ' + QuotedStr('') + ' AND CAM_POSBAR > 0';
  FCampos.Filtered := True;

  Result := Not FCampos.IsEmpty;

  FCampos.Filtered := False;
  FCampos.Filter   := '';
  FCampos.EnableControls;
End;

Procedure TGeraFR3.pCriaCodBarCabecalho;
  Var
    barDestino: TfrxBarCodeView;
    strNomeBanda: String;
    blnApenasNaPrimeiraPagina: Boolean;
    frxComponent: TfrxComponent;
Begin
  If Assigned(frxChildCodBar) Then
  Begin
    frxComponent := frxChildCodBar
  End Else
  Begin
    frxComponent := frxPageHeader;

    frxPageHeader.Stretched := True;
    frxPageHeader.PrintChildIfInvisible := True;
  End;

  blnApenasNaPrimeiraPagina := False;

  FCampos.DisableControls;
  FCampos.Filter   := 'CAM_CAMBAR <> ' + QuotedStr('') + ' AND CAM_POSBAR > 0';
  FCampos.Filtered := True;
  FCampos.First;

  While Not FCampos.Eof Do
  Begin
    barDestino := fCriaCodeBar(frxComponent);
    barDestino.Top  := 1;

    Case FCampos.FieldByName('CAM_POSBAR').AsInteger Of
      1, 2: barDestino.Align := baRight;
      3, 4: barDestino.Align := baLeft;
    End;

    If FCampos.FieldByName('CAM_POSBAR').AsInteger In [1, 3] Then
      blnApenasNaPrimeiraPagina := True;

    pMontaCodeBar(barDestino, True, strNomeBanda);

    FCampos.Next;
  End;

  If blnApenasNaPrimeiraPagina Then
  Begin
    If Assigned(frxChildCodBar) Then
      frxChildCodBar.OnAfterPrint := 'p' + frxChildCodBar.Name + 'OnAfterPrint'
    Else
      frxPageHeader.OnAfterPrint := 'p' + frxPageHeader.Name + 'OnAfterPrint';

    pScriptTextPageHeaderEmpresa(frxComponent);
  End;

  FCampos.Filtered := False;
  FCampos.Filter   := '';
  FCampos.EnableControls;
End;

Procedure TGeraFR3.pCriaImagemCabecalho;
  Var
    blnApenasNaPrimeiraPagina: Boolean;
    frxPic: TfrxPictureView;
    stmImagem: TFileStream;
Begin

  strPatImgCab := IIF(fEmptyStr(strPatImgCab), fGetPathImagemCabecalho, strPatImgCab);

  If ((SameText(FCadRel[intRelatPos].FieldByName('REL_PEDIMA').AsString, 'S')) Or (Not fEmptyStr(fGetPathImagemCabecalho))) And
    (Not strPatImgCab.IsEmpty) And (FileExists(strPatImgCab)) Then
  Begin
    frxPageHeader.Stretched := True;
    frxPageHeader.PrintChildIfInvisible := True;

    blnApenasNaPrimeiraPagina := True;

    frxPic := TfrxPictureView.Create(frxPageHeader);
    frxPic.AutoSize := True;

    stmImagem := TFileStream.Create(strPatImgCab, fmOpenRead);
    frxPic.LoadPictureFromStream(stmImagem);
    stmImagem.Free;

    If blnApenasNaPrimeiraPagina Then
    Begin
      frxPageHeader.OnAfterPrint := 'p' + frxPageHeader.Name + 'OnAfterPrint';
      pScriptTextPageHeaderEmpresa(frxPageHeader);
    End;

  End;
End;

Procedure TGeraFR3.pScriptTextPageHeaderEmpresa(frxComponent: TfrxComponent);
Begin
  With stlScriptImplementation Do
  Begin
    Add('');
    Add('procedure p' + frxComponent.Name + 'OnAfterPrint(Sender: TfrxComponent);');
    Add('begin');
    Add('  ' + frxComponent.Name + '.Visible := False;');
    Add('end;');
  End;

  With stlScriptInitialization Do
  Begin
    Add('');
    Add('  ' + frxComponent.Name + '.Visible := True;');
  End;
End;

Function TGeraFR3.pCriaDataSetVazio : TUniClientDataSet;
var
  stMensagem : String;
Begin
  Result := TUniClientDataSet.Create(nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MENSAGEM_DADOS';
    DataType := ftString;
    Size     := 300;
    Required := False;
  End;

  Result.CreateDataSet;

  stMensagem := fGetVariavelBanco('@MENSAGEM_VAZIO');

  If (stMensagem = '') Then
    stMensagem := 'Não há dados para gerar o relatório';

  Result.Append;
  Result.FieldByName('MENSAGEM_DADOS').AsString := stMensagem;
  Result.Post;

End;

Function TGeraFR3.fCriaChildEmpresa(strNomCam: string): Boolean;
Begin
  If fTemCodBarCabecalho Or SameText(FCadRel[intRelatPos].FieldByName('REL_PEDIMA').AsString, 'S') Or (Not fEmptyStr(fGetPathImagemCabecalho)) Then
  Begin
    frxChildEmpresa := TfrxChild.Create(frxPage);
    frxChildEmpresa.PrintChildIfInvisible := True;
    frxChildEmpresa.Name := 'frxChildEmpresa' + IntToStr(intRelatPos) + strNomCam;
    frxPageHeader.Child := frxChildEmpresa;
  End

  Else frxChildEmpresa := Nil;

  Result := True;
End;

Function TGeraFR3.fCriaChildCodBar: Boolean;
Begin
  If fTemCodBarCabecalho And SameText(FCadRel[intRelatPos].FieldByName('REL_PEDIMA').AsString, 'S') Then
  Begin
    frxChildCodBar := TfrxChild.Create(frxPage);
    frxChildCodBar.PrintChildIfInvisible := True;
    frxChildCodBar.Name := 'frxChildCodBar' + IntToStr(intRelatPos);
    frxChildEmpresa.Child := frxChildCodBar;
  End

  Else frxChildCodBar := Nil;

  Result := True;
End;

Function TGeraFR3.fAjustaFolhaSemFim: Boolean;
Begin
  Result := FJato And frxPage.EndlessHeight And (FCadRel[intRelatPos].FieldByName('REL_ALTMAX').AsInteger > 0);
End;

Function TGeraFR3.fCriaPageHeader(strNomCam: string): Boolean;
  Var
    frxPageHeaderModelo: TfrxPageHeader;
    mmoEmpresa,
    mmoTitulo,
    mmoSubTitulo,
    mmoNroPag: TfrxCustomMemoView;
    frxEmpresa: TfrxComponent;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  frxPageHeaderModelo := fRetPageHeader(FfrxModelo);

  If Assigned(frxPageHeaderModelo) Then
  Begin
    frxPageHeader        := TfrxPageHeader.Create(frxPage);
    frxPageHeader.Name   := 'frxPageHeader' + IntToStr(intRelatPos) + strNomCam;
    frxPageHeader.Height := frxPageHeaderModelo.Height;
    frxPageHeader.Top    := frxPageHeaderModelo.Top;

    If fAjustaFolhaSemFim Then
    Begin
      frxPageHeader.OnAfterPrint := 'p' + frxPageHeader.Name + 'AfterPrint';

      With stlScriptImplementation Do
      Begin
        Add('');
        Add('procedure p' + frxPageHeader.Name + 'AfterPrint(Sender: TfrxComponent);');
        Add('begin');

        Add('  ' + frxPageHeader.Name + '.visible := False; ');

        Add('end;');
      End;
    End;

    If (Not blnEhComplemento) or
        (FCadRel[0].FieldByName('REL_COMMAT').AsString = 'S') or
        (FCadRel[intRelatPos].FieldByName('REL_COMMAT').AsString = 'S') Then
    Begin
      If Assigned(TfrxDMPCommand(FfrxModelo.FindObject('comandoColunas')))  And
         Assigned(TfrxDMPCommand(FfrxModelo.FindObject('comandoColunas2'))) And
         Assigned(TfrxDMPCommand(FfrxModelo.FindObject('comandoColunas3'))) Then
        pCopyComand('comandoColunas', '', frxPageHeader)
      Else
        pCopyComand('comandoColunas', fColunasToCommand(intColunasMatricial), frxPageHeader);

      pCopyComand('comandoColunas2', '', frxPageHeader);
      pCopyComand('comandoColunas3', '', frxPageHeader);
    End;

    fCriaChildEmpresa(strNomCam);

    If Assigned(frxChildEmpresa) Then
    Begin
      pCriaImagemCabecalho;

      fCriaChildCodBar;

      pCriaCodBarCabecalho;

      If Assigned(frxChildCodBar) Then
        frxEmpresa := frxChildCodBar
      Else
        frxEmpresa := frxChildEmpresa;

    End Else
    Begin
      frxEmpresa := frxPageHeader;
    End;

    mmoEmpresa := fCopiaMemoView('mmoNomeEmpresa', '[NOME_EMPRESA' + IntToStr(intRelatPos) + ']', '', frxEmpresa, -1, True, strNomCam);

    If FSplit Then
    Begin
      mmoEmpresa.Align  := baNone;
      mmoEmpresa.HAlign := TfrxHAlign.haCenter;
      mmoEmpresa.Left   := frxPage.LeftMargin;
      mmoEmpresa.Width  := fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita - fCmColunaToPixel(1, False, FTipImp, False);
    End;

    If Assigned(FCadRel) And (Length(FCadRel) > 0) And (Pos(FCadRel[intRelatPos].FieldByName('REL_TITPOS').AsString, 'N_A_') > 0) Then
    Begin
      mmoTitulo := fCopiaMemoView('mmoNomeRelatorio', '[NOME_RELATORIO' + IntToStr(intRelatPos) + ']', '', frxEmpresa, -1, True, strNomCam);

      If FSplit Then
      Begin
        mmoTitulo.Align  := baNone;
        mmoTitulo.HAlign := TfrxHAlign.haCenter;
        mmoTitulo.Left   := frxPage.LeftMargin;
        mmoTitulo.Width  := fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita - fCmColunaToPixel(1, False, FTipImp, False);
      End;

      If (Not fEmptyStr(IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False)),
                            fTrataAcento(FCadRel[intRelatPos].FieldByName('REL_SUBTIT').AsString),
                            TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False)))) Then
      Begin
        If Assigned(mmoTitulo) Then
        Begin
          mmoSubTitulo := fCopiaMemoView('mmoNomeRelatorio', '[SUBNOME_RELATORIO' + IntToStr(intRelatPos) + ']', 'mmoSubNomeRelatorio', frxEmpresa, (mmoTitulo.Top + mmoTitulo.Height), True, strNomCam);
          mmoSubTitulo.Font.Size := (mmoTitulo.Font.Size - 1);

          If FSplit Then
          Begin
            mmoSubTitulo.Align  := baNone;
            mmoSubTitulo.HAlign := TfrxHAlign.haCenter;
            mmoSubTitulo.Left   := frxPage.LeftMargin;
            mmoSubTitulo.Width  := fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita - fCmColunaToPixel(1, False, FTipImp, False);
          End;
        End;
      End;

    End;

    If SameText(FCadRel[intRelatPos].FieldByName('REL_EXIPAG').AsString, 'S') then
    Begin
      mmoNroPag := fCopiaMemoView('mmoPagina', '', '', frxEmpresa, -1, True, strNomCam);

      If AnsiMatchStr(FCadRel[intRelatPos].FieldByName('REL_PGRCPE').AsString, ['S', 'D']) Then
      Begin
        mmoNroPag.OnBeforePrint := 'p' + mmoNroPag.Name + 'OnBeforePrint';
        pScriptTextNroPag(mmoNroPag.Name, FCadRel[intRelatPos].FieldByName('REL_PGRCPE').AsString);
      End
      Else If SameText(FCadRel[intRelatPos].FieldByName('REL_PAGINI').AsString, 'S') Then
        mmoNroPag.Text := AnsiReplaceStr(mmoNroPag.Text, 'Page', '<Page>+<' + STR_PAGINA_INICIAL + '>-1');
    End;

    if SameText(FCadRel[intRelatPos].FieldByName('REL_EXDTHR').AsString, 'S') then
    begin
      fCopiaMemoView('mmoData',   '', '', frxEmpresa, -1, True, strNomCam);
      fCopiaMemoView('mmoHora',   '', '', frxEmpresa, -1, True, strNomCam);
    end;

    FCurrentTop := frxEmpresa.Height;
  End;

  Result := True;
End;

Procedure TGeraFR3.pScriptTextNroPag(strNomeComponente: string; strTipoRCPE: string);
Begin
  With stlScriptImplementation Do
  Begin
    Add('');
    Add('procedure p' + strNomeComponente + 'OnBeforePrint(Sender: TfrxComponent);');
    Add('begin');
    if strTipoRCPE = 'S' then
      // paginação RCPE tradicional (2-499 .. 2-499 ..)
      Add('  ' + strNomeComponente + '.Text := IntToStr(IIF((StrToInt(<Page>) Mod 498) = 0, 499, (<Page> Mod 498) + 1));')
    Else
      // paginação RCPE diferenciada (2-499 .. 502-999 ..)
      Add('  ' + strNomeComponente + '.Text := IntToStr(IIF((StrToInt(<Page>) Mod 498) = 0, 499 + (500 * ((StrToInt(<Page>) Div 498) - 1)), ((<Page> Mod 498) + 1) + (500 * (StrToInt(<Page>) Div 498))));');
    Add('end;');
  End;
End;

Procedure TGeraFR3.pScriptTextPageHeader;
Begin
//  If Not blnEhComplemento Then
  Begin
    With stlScriptImplementation Do
    Begin
      Add('');
      Add('procedure p' + frxChildPageHeader.Name + 'OnAfterPrint(Sender: TfrxComponent);');
      Add('begin');
      Add('  ' + frxChildPageHeader.Name + '.Visible := False;');
      Add('end;');
    End;

    With stlScriptInitialization Do
    Begin
      Add('');
      Add('  ' + frxChildPageHeader.Name + '.Visible := True;');
    End;
  End;
End;

Function TGeraFR3.fCriaChildPageHeader(strNomCam: string): Boolean;
  Var
    frxChildPageHeaderModelo: TfrxChild;
    blnImprimeSomentePrimeira: Boolean;
    blnErro: Boolean;
    strExpressao: string;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  frxChildPageHeaderModelo := TfrxChild(FfrxModelo.FindObject('childPageHeader'));

  If Assigned(frxChildPageHeaderModelo) Then
  Begin
    frxChildPageHeader := TfrxChild.Create(frxPage);
    frxChildPageHeader.PrintChildIfInvisible := True;

    frxChildPageHeader.Name := 'frxChildPageHeader' + IntToStr(intRelatPos) + strNomCam;

    If Assigned(frxChildCodBar) Then
      frxChildCodBar.Child := frxChildPageHeader

    Else If Assigned(frxChildEmpresa) Then
      frxChildEmpresa.Child := frxChildPageHeader

    Else
      frxPageHeader.Child := frxChildPageHeader;

    blnImprimeSomentePrimeira := False;

    If SameText(FCadRel[intRelatPos].FieldByName('REL_FILPRI').AsString, 'S') Then
      blnImprimeSomentePrimeira := True
    Else If SameText(FCadRel[intRelatPos].FieldByName('REL_FILPRI').AsString, 'X') Then
      frxChildPageHeader.Visible := False;

    If Not SameText(FCadRel[intRelatPos].FieldByName('REL_FILPRI').AsString, 'X') Then
    Begin
      If Not fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_FILCND').AsString) Then
      Begin
        strExpressao := FCadRel[intRelatPos].FieldByName('REL_FILCND').AsString;
        strExpressao := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(strExpressao);
        strExpressao := fColocaValoresExpressao(strExpressao, blnErro);

        If Not blnErro Then
        Begin
          If Not fExecutaExpressao(strExpressao) then
          Begin
            blnImprimeSomentePrimeira := False;
            frxChildPageHeader.Visible := False;
          End;
        End;
      End;
    End;

    If blnImprimeSomentePrimeira Then
    Begin
      frxChildPageHeader.OnAfterPrint := 'p' + frxChildPageHeader.Name + 'OnAfterPrint';
      pScriptTextPageHeader;
    End;

    pCriaParametros(strNomCam);

    if (FCadRel[intRelatPos].FieldByName('REL_QBRFIL').AsString = 'S') then
      frxChildPageHeader.Stretched := True;

    FCurrentTop := frxChildPageHeader.Top + frxChildPageHeader.Height;
  End;

  Result := True;
End;

Procedure TGeraFR3.pCarregaComplementos;
Begin
  If Assigned(FCadRel[0]) Then
    FComplementoCabec.Text := AnsiReplaceStr(ReplaceStr(FCadRel[0].FieldByName('REL_COMCAB').AsString, '@', ''), '<<csq>>', #13#10);
End;

Procedure TGeraFR3.pCriaComplementos(strNomCam: string);
  Var
    intContador: Integer;
    mmoFiltro1,
    mmoFiltro2: TfrxCustomMemoView;
    fltTop: Double;
    blnLadoaLado: Boolean;
    fltLeft,
    fltWidth: Double;
Begin
  pCarregaComplementos;

  fltLeft  := 0;
  fltWidth := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False);

  mmoFiltro1 := Nil;
  blnLadoaLado := False;

  intContador := 0;

  fCopiaLine('mmoLinhaComplementoInicial', '', '', frxChildComplementoCabec, -1, strNomCam);

  If FComplementoCabec.Count > 0 Then
  Begin
    mmoFiltro1 := fCopiaMemoView('mmoComplementoCabec1',  '[COMPLEMENTO_' + Trim(FComplementoCabec[intContador]) + ']', '',  frxChildComplementoCabec, -1, True, strNomCam);

    If Assigned(mmoFiltro1) Then
    begin
      if (FCadRel[intRelatPos].FieldByName('REL_QBRCOM').AsString = 'S') then
      begin
        mmoFiltro1.StretchMode := smMaxHeight;
        mmoFiltro1.WordWrap := True;
      end
      else
        mmoFiltro1.WordWrap := False;
    end;

    Inc(intContador);
  End;

  If Assigned(mmoFiltro1) Then
  Begin
    If FTipImp = 'M' Then
      mmoFiltro1.Width := fltWidth;

    If FComplementoCabec.Count > 1 Then
    Begin
      mmoFiltro2 := fCopiaMemoView('mmoComplementoCabec2',  '[COMPLEMENTO_' + Trim(FComplementoCabec[intContador])  + ']', '', frxChildComplementoCabec, -1, True, strNomCam);

      If Assigned(mmoFiltro2) Then
      Begin
        if (FCadRel[intRelatPos].FieldByName('REL_QBRCOM').AsString = 'S') then
        begin
          mmoFiltro2.StretchMode := smMaxHeight;
          mmoFiltro2.WordWrap := True;
        end
        else
          mmoFiltro2.WordWrap := False;
        blnLadoaLado := Abs(RoundTo(mmoFiltro1.Top, -2) - RoundTo(mmoFiltro2.Top, -2)) < mmoFiltro1.Height;

        If blnLadoaLado Then
         // fltWidth := (fltWidth - fCmColunaToPixel(2, False, FTipImp, False)) / 2;
          fltWidth := (fltWidth -  3 * fRetEspacametoColunas) / 2;

        mmoFiltro1.Width := fltWidth;
        mmoFiltro2.Width := fltWidth;

        If blnLadoaLado Then
        Begin
          mmoFiltro2.Left := mmoFiltro1.Width + 3 * fRetEspacametoColunas;
          fltLeft := mmoFiltro2.Left;
        End;

        mmoFiltro1 := mmoFiltro2;

        Inc(intContador);
      End;
    End;

    If Assigned(mmoFiltro1) Then
    Begin
      fltTop :=  mmoFiltro1.Top + mmoFiltro1.Height + fIncTop;

      While intContador < FComplementoCabec.Count Do
      Begin
        If (Not blnLadoaLado) Or (intContador Mod 2 = 0) Then
          fltTop := mmoFiltro1.Top + mmoFiltro1.Height + fIncTop;

        mmoFiltro1 := fCopiaMemoView('mmoComplementoCabec' + IntToStr((intContador Mod 2) + 1),  '[COMPLEMENTO_' + Trim(FComplementoCabec[intContador]) + ']', 'mmoComplementoCabec' + IntToStr(intContador + 1), frxChildComplementoCabec, fltTop, True, strNomCam);
        mmoFiltro1.Width := fltWidth;
        if (FCadRel[intRelatPos].FieldByName('REL_QBRCOM').AsString = 'S') then
        begin
          mmoFiltro1.StretchMode := smMaxHeight;
          mmoFiltro1.WordWrap := True;
        end
        else
          mmoFiltro1.WordWrap := False;

        If blnLadoaLado And (intContador Mod 2 <> 0) Then
          mmoFiltro1.Left := fltLeft;

        Inc(intContador);
      End;

      If blnLadoaLado And (FComplementoCabec.Count Mod 2 <> 0) Then
        mmoFiltro1.Width := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False) - mmoFiltro1.Left - fCmColunaToPixel(2, False, FTipImp, False);

     End;
  End;

  fCopiaLine('mmoLinhaComplementoFinal', '', '', frxChildComplementoCabec, frxChildComplementoCabec.Height + 5, strNomCam);
  frxChildComplementoCabec.Height := frxChildComplementoCabec.Height + 5;
End;

Function TGeraFR3.fImprimeComplementosCabecalho: Boolean;
var
  intContador: Integer;
  strValores: string;
begin

  strValores := '';

  if FCadRel[0].FieldByName('REL_COMPVZ').AsString = 'S' then
    Result := True
  else
  begin
    pCarregaComplementos;

    for intContador := 0 to FComplementoCabec.Count - 1 do
      if not fEmptyStr(FComplementoCabec[intContador]) then
        strValores := strValores + Trim(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@' + FComplementoCabec[intContador], False));

    Result := not fEmptyStr(strValores);
  end;

end;

Function TGeraFR3.fCriaChildComplementoCabec(strNomCam: string): Boolean;
  Var
    frxChildModelo: TfrxChild;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  If Not fEmptyStr(FCadRel[0].FieldByName('REL_COMCAB').AsString) Then
  Begin
    If fImprimeComplementosCabecalho Then
    Begin

      frxChildModelo := TfrxChild(FfrxModelo.FindObject('childComplementoCabec'));

      If Assigned(frxChildModelo) Then
      Begin
        frxChildComplementoCabec := TfrxChild.Create(frxPage);
        frxChildComplementoCabec.Font := frxChildModelo.Font;
        frxChildComplementoCabec.Name := 'frxChildComplementoCabec' + IntToStr(intRelatPos) + strNomCam;
        frxChildPageHeader.Child := frxChildComplementoCabec;

        pCriaComplementos(strNomCam);

        if (FCadRel[intRelatPos].FieldByName('REL_QBRCOM').AsString = 'S') then
          frxChildComplementoCabec.Stretched := True;

        FCurrentTop := frxChildComplementoCabec.Top + frxChildComplementoCabec.Height;
      End;

    End;
  End;

  Result := True;
End;

Function TGeraFR3.fCriaPageFooter(strNomCam: string): Boolean;
  Var
    objFrx: TfrxComponent;
    frxPageFooterModelo: TfrxPageFooter;
    mmoMsgRod,
    mmoMsgRodModelo,
    mmoContador: TfrxCustomMemoView;
    mnoRelatorioEspecifico: TfrxCustomMemoView;
    sltRodape: TStringList;
Begin
  If (Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail])) Then
  Begin
    Result := True;
    Exit;
  End;

  frxPageFooterModelo := fRetPageFooter(FfrxModelo);

  If Assigned(frxPageFooterModelo) Then
  Begin
    frxPageFooter        := TfrxPageFooter.Create(frxPage);
    frxPageFooter.Name   := 'frxPageFooter' + IntToStr(intRelatPos) + strNomCam;
    frxPageFooter.Height := frxPageFooterModelo.Height;
    frxPageFooter.Font   := frxPageFooterModelo.Font;
    frxPageFooter.Top    := FCurrentTop + 1;

    If fAjustaFolhaSemFim Then
    Begin
      frxPageFooter.OnBeforePrint := 'p' + frxPageFooter.Name + 'BeforePrint';

      With stlScriptImplementation Do
      Begin
        Add('');
        Add('procedure p' + frxPageFooter.Name + 'BeforePrint(Sender: TfrxComponent);');
        Add('  var  DataSet: TfrxDataSet; ');
        Add('begin');

      //  Add('  If engine.finalpass Then ');
      //  Add('   ' + frxPageFooter.Name + '.visible := (<page#> = <totalpages#>);');

        Add(' DataSet := ' + frxMasterData.Name + '.DataSet;');
        Add('   ' + frxPageFooter.Name + '.visible := DataSet.eof;');

        Add('end;');
      End;
    End;

    fCopiaLine('mmoLinhaFinal',   '', '', frxPageFooter, -1, strNomCam);

    If Assigned(FCadRel) And (Length(FCadRel) > 0) And (Not SameText(FCadRel[intRelatPos].FieldByName('REL_OMIREG').AsString, 'S')) Then
    Begin
      mnoRelatorioEspecifico :=  fCopiaMemoView('mnoRelatorioEspecifico','','mnoRelatorioEspecifico0',frxPageFooter, -1, False, strNomCam);
      If ((FCadRel[intRelatPos].FieldByName('REL_MD5NEW').AsString) <> (FCadRel[intRelatPos].FieldByName('REL_MD5OLD').AsString)) Then
      Begin
        If mnoRelatorioEspecifico <> Nil Then
        begin
          if ((FCadRel[intRelatPos].FieldByName('REL_TIPFOL').AsString = 'T40') or (FCadRel[intRelatPos].FieldByName('REL_QTDCOL').AsInteger = 50)) then
            mnoRelatorioEspecifico.Text := fTrataAcento('REL: ' + FCadRel[intRelatPos].FieldByName('REL_CODREL').AsString + ' * MODIFICADO, SENDO ESPECÍFICO.')
          else
            mnoRelatorioEspecifico.Text := fTrataAcento('REL: ' + FCadRel[intRelatPos].FieldByName('REL_CODREL').AsString + ' *. ESTE RELATÓRIO FOI MODIFICADO, SENDO ESPECÍFICO PARA ESTE CLIENTE.');
        end;
      End
      Else
      Begin
        If mnoRelatorioEspecifico <> Nil Then
          mnoRelatorioEspecifico.Text := 'REL: ' + FCadRel[intRelatPos].FieldByName('REL_CODREL').AsString + '.';
      End;

      If not ((intRelatPos = 0) And (fRetGerarVideoVazio)) then
      begin
        mmoContador := fCopiaMemoView('mmoContaRegistro', '', 'mmoContaRegistro0', frxPageFooter, -1, False, strNomCam);
        If Assigned(mmoContador) Then
        Begin
          mmoContador.Text  := AnsiReplaceStr(mmoContador.Text, 'MasterData1', fMasterDataName(intRelatPos, strNomCam));
          If (FTipImp = 'M') And ((frxPage.LeftMargin <> 0) Or (frxPage.RightMargin <> 0)) Then
            mmoContador.Align := baWidth;
        End;
      end;
    End;

    If Assigned(FCadRel) And (Length(FCadRel) > 0) And (Not fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_MSGROD').AsString)) Then
    Begin
      objFrx := FfrxModelo.FindObject('mmoMensagemRodape');

      If Assigned(objFrx) Then
      Begin
        sltRodape := TStringList.Create;
        sltRodape.Text := AnsiReplaceStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(FCadRel[intRelatPos].FieldByName('REL_MSGROD').AsString, False), '<<csq>>', #13#10);

        mmoMsgRodModelo := TfrxCustomMemoView(objfrx);
        mmoMsgRodModelo.Height := mmoMsgRodModelo.Height * sltRodape.Count;

        mmoMsgRod := fCopiaMemoView('mmoMensagemRodape', '', 'mmoMensagemRodape' + FCodRels[0], frxPageFooter, -1, True, strNomCam);

        If Assigned(mmoMsgRod) Then
          mmoMsgRod.Text := sltRodape.Text;

        sltRodape.Clear;
        FreeAndNil(sltRodape);
      End;

    End;
  End;

  // Criar "colunização" no fim de tudo para não ter problemas com mais de uma página no DesignReport
  If Assigned(FCadRel) And (Length(FCadRel) > 0) And (FCadRel[intRelatPos].FieldByName('REL_NUMCOL').AsInteger > 1) Then
  Begin
    frxPage.Columns := FCadRel[intRelatPos].FieldByName('REL_NUMCOL').AsInteger;
  End;

  Result := True;
End;

Function TGeraFR3.fTemCampoTotal: Boolean;
Begin
  Result := False;
  With FCampos Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Not fEmptyStr(FieldByName('CAM_TOTALI').AsString) Then
      Begin
        Result := True;
        Exit;
      End;

      Next;
    End;
  End;
End;

Function TGeraFR3.fCriaFooter(strNomCam: string): Boolean;
  Var
    frxFooterModelo: TfrxFooter;
    fltMenorLeft: Double;
    blnTemCampoTotal,
    blnTemRodapeDados: Boolean;
Begin
  If (Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]))
    Or ((intRelatPos = 0) And (fRetGerarVideoVazio)) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := True;

  frxFooterModelo   := fRetFooter(FfrxModelo);

  blnTemCampoTotal  := fTemCampoTotal;
  blnTemRodapeDados := Assigned(FCadRel) And (Length(FCadRel) > 0) And (Not fEmptyStr(FCadRel[intRelatPos].FieldByName('REL_MSGDAD').AsString));

  If Assigned(frxFooterModelo) And (blnTemCampoTotal Or blnTemRodapeDados) Then
  Begin
    frxFooter        := TfrxFooter.Create(frxPage);
    frxFooter.Name   := 'frxFooter' + IntToStr(intRelatPos) + strNomCam;
    frxFooter.Height := frxFooterModelo.Height;
    frxFooter.Font   := frxFooterModelo.Font;
    frxFooter.Top    := FCurrentTop + 1;
    frxFooter.PrintChildIfInvisible := True;

    If blnTemCampoTotal And (Not SameText(FCadRel[intRelatPos].FieldByName('REL_OMITOT').AsString, 'S')) Then
    Begin

      fCopiaLine('mmoLinhaFooterInicial',  '', '', frxFooter, -1, strNomCam);
      fCopiaLine('mmoLinhaFooterFinal',   '', '', frxFooter, -1, strNomCam);

      FTotalGeral := fCopiaMemoView('mmoTotalGeral', '', '', frxFooter, -1, True, strNomCam);

      pMontaTotais(frxFooter, FTotalGeral, fltMenorLeft, True, strNomCam, '');

      If Assigned(FTotalGeral) And (fltMenorLeft > -1) And (fltMenorLeft < FTotalGeral.Left + FTotalGeral.Width) Then
        FTotalGeral.Visible := False;

    End Else
    Begin

      frxFooter.Visible := False;

    End;

    FCurrentTop := frxFooter.Top + frxFooter.Height;

    If blnTemRodapeDados Then
    Begin

      Result := fCriaChildFooter(strNomCam);

    End;

  End;

End;

Function TGeraFR3.fCriaChildFooter(strNomCam: string): Boolean;
  Var
    objFrx: TfrxComponent;
    sltRodape: TStringList;
    frxChildFooterModelo: TfrxChild;
    mmoMsgRod: TfrxCustomMemoView;
Begin
  frxChildFooterModelo := TfrxChild(FfrxModelo.FindObject('childFooter'));

  If Assigned(frxChildFooterModelo) And Assigned(frxFooter) Then
  Begin
    frxChildFooter := TfrxChild.Create(frxPage);
    frxChildFooter.Stretched := True;
    frxChildFooter.Name := 'frxChildFooter' + IntToStr(intRelatPos) + strNomCam;
    frxFooter.Child := frxChildFooter;
    frxChildFooter.Top := FCurrentTop + 1;

    objFrx := FfrxModelo.FindObject('mmoMensagemRodapeDados');

    If Assigned(objFrx) Then
    Begin
      sltRodape := TStringList.Create;
      sltRodape.Text := AnsiReplaceStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(FCadRel[intRelatPos].FieldByName('REL_MSGDAD').AsString, False), '<<csq>>', #13#10);

      mmoMsgRod := fCopiaMemoView('mmoMensagemRodapeDados', '', 'mmoMensagemRodapeDados' + FCodRels[0], frxChildFooter, -1, True, strNomCam);
      mmoMsgRod.StretchMode := smMaxHeight;

      If Assigned(mmoMsgRod) Then
        mmoMsgRod.Text := sltRodape.Text;

      sltRodape.Clear;
      FreeAndNil(sltRodape);

      FCurrentTop := frxChildFooter.Top + frxChildFooter.Height;
    End;

  End;

  Result := True;
End;


Function TGeraFR3.fRetIndiceTotal(strNomTot: String): Integer;
  Var
    intContador: Integer;
Begin
  Result := 0;

  For intContador := Low(ArrDesTotal) To High(ArrDesTotal) Do
    If SameText(String(ArrDesTotal[intContador]), strNomTot) Then
    Begin
      Result := intContador;
      Exit;
    End;
End;

Function TGeraFR3.fRetEspacametoColunas: Double;
Begin
  If FTipImp = 'J' Then
    Result := INT_ESPACAMENTO_COLUNAS_JATO
  Else
    Result := INT_ESPACAMENTO_COLUNAS_MATRICIAL;
End;

Function TGeraFR3.fAjustaCamposExpressao(strExpressao: String; blnTotGeral: Boolean; strNomCam: string; strQuebra: String): String;
  Var
    arrTrocas: Array Of Integer;
    intContador: Integer;
    strFormat: String;
Begin
  Result := AnsiReplaceStr(strExpressao, '<<csq>>', #13#10);
  Result := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(Result, False);
  Result := AnsiReplaceStr(Result, STR_TIPO_TOT, QuotedStr(IIF(blnTotGeral, 'TG', 'TP')));
  Result := TInterfaceRelatorio(objInterfaceGera).fValidaStrQuebra(Result, strQuebra);

  With FParams Do
  Begin
    IndexFieldNames := 'PAR_NOMPAR';

    Last;
    While Not Bof Do
    Begin
      Result := AnsiReplaceStr(Result, ':' + FieldByName('PAR_NOMPAR').AsString, '<' + FieldByName('PAR_NOMPAR').AsString + '>');
      Prior;
    End;

  End;

  SetLength(arrTrocas, 0);
  // ACRESCENTA O DATA SET NO NOME DOS CAMPOS
  With FCamposExp Do
  Begin
    // COMEÇA DO MAIOR - PARA FICAR CORRETO SE O NOME DE UM CAMPO CONTIVER O NOME DE OUTRO
    Last;
    While Not Bof Do
    Begin
      If Pos(FieldByName('CAM_NOMCAM').AsString, Result) > 0 Then
      Begin
        Result := AnsiReplaceStr(Result, FieldByName('CAM_NOMCAM').AsString, 'C-A-M-P-O-' + IntToStr(RecNo));

        SetLength(arrTrocas, Succ(Length(arrTrocas)));
        arrTrocas[High(arrTrocas)] := RecNo;
      End;

      Prior;
    End;

    For intContador := Low(arrTrocas) To High(ArrTrocas) Do
    Begin
      RecNo := arrTrocas[intContador];
      Result := AnsiReplaceStr(Result, 'C-A-M-P-O-' + IntToStr(RecNo), fRetCampoRel(FCamposExp, strFormat, True, False));
    End;

  End;

  Result := AnsiReplaceStr(Result, 'COUNT()', 'COUNT(' + fMasterDataName(intRelatPos, strNomCam) + ')');

  SetLength(arrTrocas, 0);
End;

Function TGeraFR3.fRetornaLarguraCampo(cdsCampos: TZClient): Double;
Begin
  With cdsCampos Do
  Begin

    If FieldByName('LARGURA_REAL').AsFloat = -1 Then
    Begin

      Result := FieldByName('CAM_LARGUR').AsFloat;

      FCamposExp.First;
      While Not FCamposExp.Eof Do
      Begin
        If SameText(FCamposExp.FieldByName('CAM_APROVE').AsString, FieldByName('CAM_NOMCAM').AsString) And
           SameText(FCamposExp.FieldByName('CAM_LISTAR').AsString, FieldByName('CAM_LISTAR').AsString) And
           (Not fValidaVisibilidade(FCamposExp)) Then
          Result := Result + FCamposExp.FieldByName('CAM_LARGUR').AsFloat + fPixelToCmColuna(fRetEspacametoColunas, False, FTipImp);

        FCamposExp.Next;
      End;

      Edit;
      FieldByName('LARGURA_REAL').AsFloat := Result;
      Post;

    End

    Else Result := FieldByName('LARGURA_REAL').AsFloat;

  End;
End;

Procedure TGeraFR3.pMontaTotais(frxPai: TfrxComponent; frxTotal: TfrxCustomMemoView; Var fltMenorLeft: Double; blnTotGeral: Boolean; strNomCam: string; strQuebra: String);
  Var
    mmoDestino: TfrxCustomMemoView;
    strLastListarLeft,
    strLastListarTop: String;
    fltHeight,
    fltTop,
    fltLeft,
    fltWidth: Double;
    strFormat: String;

    intColunas: Integer;
Begin
  With FCampos Do
  Begin
    fltMenorLeft := -1;

    mmoDestino := Nil;

    DisableControls;
    IndexFieldNames := 'CAM_LISTAR;CAM_POSICA';

    strLastListarLeft := '';
    strLastListarTop := '';
    fltLeft := 0;

    If Assigned(frxTotal) Then // Melhorar
    Begin
      fltTop    := frxTotal.Top;
      fltHeight := frxTotal.Height;
    End Else
    Begin
      If FTipImp = 'M' Then
      Begin
        fltTop    := 0;
        fltHeight := 17;
      End Else
      Begin
        fltTop    := 3;
        fltHeight := frxMasterData.Height;
      End;
    End;

    intColunas := 0;

    First;

    While (Not Eof) And ((FMaxCol = -1) Or (intColunas < FMaxCol)) Do
    Begin
      Inc(intColunas);

      // SE VAI LISTAR O CAMPO
      If (Not fEmptyStr(FieldByName('CAM_LISTAR').AsString)) And
         fValidaVisibilidade(FCampos) Then
      Begin
        fltWidth := fCmColunaToPixel(fRetornaLarguraCampo(FCampos), False, FTipImp, False);

        strLastListarLeft := FieldByName('CAM_LISTAR').AsString;

        // SE TEM TOTAL
        If (Not fEmptyStr(FieldByName('CAM_TOTALI').AsString)) Then
        Begin
          strLastListarTop := FieldByName('CAM_LISTAR').AsString;

          If fltTop + fltHeight > frxPai.Height Then
            frxPai.Height := fltTop + fltHeight;

          mmoDestino        := fCriaMemoView(frxPai);
          mmoDestino.Top    := fltTop;
          mmoDestino.Height := fltHeight;
          mmoDestino.Left   := fltLeft;
          mmoDestino.Width  := fltWidth;

          If SameText(STR_DEF_FORMULA, FieldByName('CAM_TOTALI').AsString) Then
            mmoDestino.Text := '[' + fAjustaCamposExpressao(FieldByName('CAM_FORTOT').AsString, blnTotGeral, strNomCam, strQuebra) + ']'

          Else If SameText('COUNT', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)])) Then
            mmoDestino.Text := '[COUNT(' + fMasterDataName(intRelatPos, strNomCam) + ')]'

          Else Begin
            mmoDestino.Text  := '[' + String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)]) + '(' + fRetCampoRel(FCampos, strFormat, True, False) + ')]';
            pFormataDecimais(mmoDestino, strFormat);
          End;

          mmoDestino.ParentFont := True;

          If AnsiMatchStr(FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
          Begin
            If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número inteiro') Or
               SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Then
              mmoDestino.HAlign   := TfrxHAlign.haRight;
          End
          Else
          Begin
            Case AnsiIndexStr(FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
              0 : mmoDestino.HAlign := TfrxHAlign.haLeft;
              1 : mmoDestino.HAlign := TfrxHAlign.haCenter;
              2 : mmoDestino.HAlign := TfrxHAlign.haRight;
            End;
          End;

          If (Not SameText('COUNT', String(ArrTipoTotal[fRetIndiceTotal(FieldByName('CAM_TOTALI').AsString)]))) And
             (SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Or
              SameText(FieldByName('CAM_TOTALI').AsString, 'Média')) Then
            Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
              masDecUni       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DECUNI', varString) + 'n');
              masDecQtd       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DECQTD', varString) + 'n');
              masEstDec       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('ESTDEC', varString) + 'n');
              masDeqTpc       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DEQTPC', varString) + 'n');
              masContabil     : pFormataContabil(mmoDestino, StrToIntDef(FieldByName('CAM_NRODEC').AsString, 2), True);
            Else              pFormataDecimais(mmoDestino, '%2.' + IntToStr(FieldByName('CAM_NRODEC').AsInteger) + 'n');
            End;

          If (fltMenorLeft = -1) Then
            fltMenorLeft := mmoDestino.Left;
        End;

        fltLeft := fltLeft + fltWidth + fRetEspacametoColunas;
      End;

      Next;

      If (Not SameText(FieldByName('CAM_LISTAR').AsString, strLastListarLeft)) Then
      Begin
        fltLeft := 0;
      End;

      If (Not SameText(FieldByName('CAM_LISTAR').AsString, strLastListarTop)) And
         (Not fEmptyStr(FieldByName('CAM_TOTALI').AsString)) And Assigned(mmoDestino) Then
      Begin
        fltTop  := fltTop + mmoDestino.Height + fIncTop;
      End;

    End;

    FCampos.IndexFieldNames := 'CAM_POSICA';
    EnableControls;
  End;
End;

Function TGeraFR3.fDesVisibilidadeToTipo(strVisibilidade: String): TVisibilidade;
  Var
    visContador: TVisibilidade;
Begin
  Result := visSempre;

  For visContador := Low(ArrDesVisibilidade) To High(ArrDesVisibilidade) Do
    If SameText(ArrDesVisibilidade[visContador], strVisibilidade) Then
    Begin
      Result := visContador;
      Exit;
    End;
End;

Procedure TGeraFR3.pInicializaFastScript;
Begin
  fscScript := TfsScript.Create(Nil);

  fscScript.SyntaxType := 'PascalScript';

  fscScript.AddType('Integer', fvtInt);
  fscScript.AddType('Boolean', fvtBool);
  fscScript.AddType('Double' , fvtFloat);
  fscScript.AddType('Char',    fvtChar);
  fscScript.AddType('String',  fvtString);
  fscScript.AddType('Variant', fvtVariant);

  fscScript.AddMethod('Function IIF2(lTest:Boolean; vExpr1,vExpr2: Variant):Variant', fCallIIF);
End;

Function TGeraFR3.fExecutaExpressao(strExpressao: String; blnExprValida: Boolean = False): Boolean;

  function fRetornaExprValida(strExpres: string): Boolean;
  var
    intContador: Integer;
    blnValida,
    blnAchouExpressao: Boolean;
  begin
    blnValida := False;
    blnAchouExpressao := False;
    for intContador := Low(FExprValida) To High(FExprValida) do
    begin
      if strExpres = FExprValida[intContador].strExpres then
      begin
        blnAchouExpressao := True;
        blnValida := FExprValida[intContador].blnValida;
        Break;
      end;
    end;
    if not blnAchouExpressao then
    begin
      blnValida := fscScript.Evaluate(strExpres);
      SetLength(FExprValida, Succ(Length(FExprValida)));
      FExprValida[High(FExprValida)].strExpres := strExpres;
      FExprValida[High(FExprValida)].blnValida := blnValida;
    end;
    Result := blnValida;
  end;

Begin
  Try
    strExpressao := AnsiReplaceStr(strExpressao, 'IIF', 'IIF2');

    strExpressao := fTrocaConstantesExpressao(strExpressao);

    if blnExprValida then
      Result := fRetornaExprValida(strExpressao)
    else
      Result := fscScript.Evaluate(strExpressao);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(strExpressao + ' - ' + E.Message, '[TGeraFR3.fExecutaExpressao]');
    End;
  End;
End;

Function TGeraFR3.fRetornaExpressaoString(strExpressao: String; blnExprValida: Boolean = False; blnDescrCampo: Boolean = False): String;
  Var
    blnErro: Boolean;
Begin
  Result := '';

  If Assigned(objInterfaceGera) Then
  Begin

    if blnDescrCampo then
    begin
      strExpressao := TInterfaceRelatorio(objInterfaceGera).fRetornaMesAnoPersonalizado(strExpressao);
      strExpressao := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(strExpressao);
    end;

    strExpressao := fColocaValoresExpressao(strExpressao, blnErro);

    If Not blnErro Then
      Result := fExecutaExpressaoString(strExpressao, blnExprValida);
  End;

End;

Function TGeraFR3.fRetornaExpressaBoolean(strExpressao: String; blnExprValida: Boolean = False): Boolean;
  Var
    blnErro: Boolean;
Begin
  Result := False;

  If Assigned(objInterfaceGera) Then
  Begin
    strExpressao := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(strExpressao);

    strExpressao := fColocaValoresExpressao(strExpressao, blnErro);

    If Not blnErro Then
      Result := fExecutaExpressao(strExpressao, blnExprValida);
  End;

End;

Function TGeraFR3.fCallIIF(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := IIF(Params[0], Params[1], Params[2]);
End;

Function TGeraFR3.fExecutaExpressaoString(strExpressao: String; blnExprValida: Boolean = False): String;

  function fRetornaExprValida(strExpres: string): string;
  var
    intContador: Integer;
    strStrRes: string;
    blnAchouExpressao: Boolean;
  begin
    strStrRes := '';
    blnAchouExpressao := False;
    for intContador := Low(FExprValida) To High(FExprValida) do
    begin
      if strExpres = FExprValida[intContador].strExpres then
      begin
        blnAchouExpressao := True;
        strStrRes := FExprValida[intContador].strStrRes;
        Break;
      end;
    end;
    if not blnAchouExpressao then
    begin
      strStrRes := fscScript.Evaluate(strExpres);
      SetLength(FExprValida, Succ(Length(FExprValida)));
      FExprValida[High(FExprValida)].strExpres := strExpres;
      FExprValida[High(FExprValida)].strStrRes := strStrRes;
    end;
    Result := strStrRes;
  end;

Begin
  Try
    strExpressao := AnsiReplaceStr(strExpressao, 'IIF', 'IIF2');

    strExpressao := fTrocaConstantesExpressao(strExpressao);

    if blnExprValida then
      Result := fRetornaExprValida(strExpressao)
    else
      Result := fscScript.Evaluate(strExpressao);

  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(strExpressao + ' - ' + E.Message, '[TGeraFR3.fExecutaExpressaoString]');
    End;
  End;
End;

Function TGeraFR3.fColocaValoresExpressao(strExpressao: String; Var blnErro: Boolean): String;
  Var
    strFilter,
    strValPar: String;
    blnFiltered,
    blnAchou: Boolean;
Begin
  blnErro := False;

  Result := Trim(AnsiReplaceStr(strExpressao, '<<csq>>', #13#10));

  If Assigned(objInterfaceGeraPrincipal) Then
    Result := TInterfaceRelatorio(objInterfaceGeraPrincipal).fGetNomeColunaCheckList(Result, True);

  If SameText(Result, strExpressao) Then
    Result := TInterfaceRelatorio(objInterfaceGera).fGetNomeColunaCheckList(Result, True);

  With FParams Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;

    Filtered := False;

    IndexFieldNames := 'PAR_NOMPAR';

    Last;
    While (Pos(':', Result) > 0) And (Not Bof) Do
    Begin

      If (Pos(':' + FieldByName('PAR_NOMPAR').AsString, Result) > 0) Then
      Begin

        If fEmptyStr(FieldByName('PAR_TIPPAR').AsString) Then
        Begin
          blnErro := True;
          pMensagemOk('Informe o tipo de interface para o filtro ' + FieldByName('PAR_NOMPAR').AsString + '!');
          Exit;
        End;

        If Assigned(objInterfaceGera) Then
          strValPar := fPegaValorParametro(FieldByName('PAR_NOMPAR').AsString, blnAchou, False)
        Else
          strValPar := '';

        If (Not SameText('Número decimal', FieldByName('PAR_TIPPAR').AsString)) And
           (Not SameText('Número inteiro', FieldByName('PAR_TIPPAR').AsString)) Then
          strValPar := QuotedStr(strValPar);

        If (SameText('Número decimal', FieldByName('PAR_TIPPAR').AsString) Or
            SameText('Número inteiro', FieldByName('PAR_TIPPAR').AsString)) And fEmptyStr(strValPar) Then
          strValPar := '0';

        Result := AnsiReplaceStr(Result, ':' + FieldByName('PAR_NOMPAR').AsString, ' ' + strValPar + ' ');

      End;

      Prior;
    End;

    Filter   := strFilter;
    Filtered := blnFiltered;

  End;

End;

Function TGeraFR3.fValidaVisibilidade(cdsCampos: TZClient; blnExprValida: Boolean = False): Boolean;
  Var
  blnErro: Boolean;
  strVisibilidade,
  strExpVis,
  strExpress: String;
Begin
  With cdsCampos Do
  Begin

    If FieldByName('VISIVEL').AsInteger = -1 Then
    Begin

      strVisibilidade := FieldByName('CAM_VISIBI').AsString;
      strExpVis       := FieldByName('CAM_EXPVIS').AsString;

      Case fDesVisibilidadeToTipo(strVisibilidade) Of
        visTabelaPreco1:    Result := VS_strTabPrc[1] = 'S';
        visTabelaPreco2:    Result := VS_strTabPrc[2] = 'S';
        visTabelaPreco3:    Result := VS_strTabPrc[3] = 'S';
        visTabelaPreco4:    Result := VS_strTabPrc[4] = 'S';
        visTabelaPreco5:    Result := VS_strTabPrc[5] = 'S';
        visTabelaPreco6:    Result := VS_strTabPrc[6] = 'S';
        visTabelaPreco7:    Result := VS_strTabPrc[7] = 'S';
        visUsaTintaMaquina: Result := VS_strUsaTmq = 'S';
        visENTFUT:          Result := fCfgSis('ENTFUT', varString) = 'S';
        visUSAPDV:          Result := fCfgSis('USAPDV', varString) = 'S';
        visPDEOR:           Result := ((fCfgSis('USAPDV', varString) = 'S') And (fCfgSis('ORDPRO', varString) = 'S'));
        visCTLEST:          Result := fCfgSis('CTLEST', varString) = '2';
        visCADLOC:          Result := fCfgSis('CADLOC', varString) = 'S';
        visUTIWMS:          Result := fUsaRotinaWMS;
        visEMBSEPs:          Result := fCfgSis('EMBSEP', varString) = 'S';
        visEMBSEPn:          Result := fCfgSis('EMBSEP', varString) = 'N';
        Else                Result := True;
      End;

      If Result And (Not fEmptyStr(strExpVis)) Then
      Begin
        If Assigned(objInterfaceGera) Then
        Begin
          strExpVis := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel(strExpVis);
          strExpress := fColocaValoresExpressao(strExpVis, blnErro);

          If blnErro Then
            result := False
          Else
            Result := fExecutaExpressao(strExpress, blnExprValida);

        End Else
          Result := True;
      End;

      Edit;

      If Result Then
        FieldByName('VISIVEL').AsInteger := 1
      Else
        FieldByName('VISIVEL').AsInteger := 0;

      Post;

    End

    Else Result := FieldByName('VISIVEL').AsInteger = 1;

  End;
End;

Procedure TGeraFR3.pAjustaLeft(Var fltLeft: Double);
  Var
    intContador: Integer;
Begin

  If Not FSplit Then
    Exit;

  For intContador := 1 To Ceil(FFatorScale) - 1 Do
  Begin
    If (fltLeft >= FarrLeftsFolhas[intContador].intEsquerda) And
       (fltLeft < FarrLeftsFolhas[intContador].intDireita) Then
    Begin
      fltLeft := FarrLeftsFolhas[intContador].intDireita;
      Break;
    End;

  End;
End;

Function TGeraFR3.fEstaQuebrandoPeloCampo(strNomCam: String): Boolean;
Begin
  With FQuebras Do
  Begin
    Last;
    Result := SameText(strNomCam, FieldByName('CAM_NOMCAM').AsString);
  End;
End;

Procedure TGeraFR3.pMontaTitulos(frxPai: TfrxComponent; blnQuebra: Boolean; strNomCam: string; blnHeader: Boolean);
  Var
    frxLine: TfrxLineView;
    mmoLinha: TfrxCustomLineView;
    mmoDestino: TfrxCustomMemoView;
    fltHeight,
    fltLeft,
    fltTop: Double;
    strCampoGuia,
    strLastCodGru,
    strLastTxtGru,
    strLastListar: String;

    blnListou: Boolean;

    Procedure pCriaGrupos(strCamGru: String);
      Var
        blnIncTop: Boolean;
        intColunas: Integer;
        blnSepararGruposVerticalmente: Boolean;
        fltLeftProxGrupo: Double;
        fltTopProxGrupo: Double;
    Begin
      mmoDestino    := Nil;
      strLastListar := '';
      fltLeft       := 0;
      strLastCodGru := '';
      strLastTxtGru := '';

      blnSepararGruposVerticalmente := FCadRel[intRelatPos].FieldByName('REL_GRUVER').AsString = 'S';
      fltLeftProxGrupo := 0;
      fltTopProxGrupo := 0;

      With FCampos Do
      Begin
        blnIncTop := False;

        First;

        intColunas := 0;

        While (Not Eof) And ((FMaxCol = -1) Or (intColunas < FMaxCol)) Do
        Begin
          Inc(intColunas);

          If (Not fEmptyStr(FieldByName(strCampoGuia).AsString)) And
             fValidaVisibilidade(FCampos) Then
          Begin
            strLastListar := FieldByName(strCampoGuia).AsString;

            If (Not fEmptyStr(FieldByName(strCamGru).AsString)) And (Not fEmptyStr(fTrataAcento(fRetNomeGrupo(FieldByName(strCamGru).AsString)))) Then
            Begin

              If (strLastCodGru <> FieldByName(strCamGru).AsString) and (strLastTxtGru <> fTrataAcento(fRetNomeGrupo(FieldByName(strCamGru).AsString))) Then
              Begin
                If blnIncTop Then
                Begin
                  If Assigned(mmoDestino) Then
                    fltTop  := fltTop + mmoDestino.Height + fIncTop;

                  blnIncTop := False;
                End;

                If fltTop + fltHeight > frxPai.Height Then
                  frxPai.Height := fltTop + fltHeight;

                if (not blnSepararGruposVerticalmente) and
                   (FTipImp <> 'M') and
                   (fltTopProxGrupo = fltTop) and
                   (RoundTo((fltLeftProxGrupo + fRetEspacametoColunas), -3) = RoundTo(fltLeft, -3)) then
                begin
                  mmoDestino := fCriaMemoView(frxPai);
                  mmoDestino.Top        := fltTopProxGrupo;
                  mmoDestino.Left       := fltLeftProxGrupo;
                  mmoDestino.Width      := fRetEspacametoColunas;
                  mmoDestino.Text       := '';
                  mmoDestino.ParentFont := True;
                  mmoDestino.Height     := fltHeight;
                  mmoDestino.WordWrap   := False;
                  mmoDestino.HAlign     := TfrxHAlign.haCenter;
                  mmoDestino.Frame.Typ  := [ftTop, ftBottom];
                end;

                mmoDestino := fCriaMemoView(frxPai);
                mmoDestino.Top        := fltTop;

                pAjustaLeft(fltLeft);

                mmoDestino.Left       := fltLeft;

                strLastTxtGru         := fTrataAcento(fRetNomeGrupo(FieldByName(strCamGru).AsString));

                mmoDestino.Width      := fCmColunaToPixel(fRetornaLarguraCampo(FCampos), False, FTipImp, False);
                mmoDestino.Text       := strLastTxtGru;
                mmoDestino.ParentFont := True;
                mmoDestino.Height     := fltHeight;
                mmoDestino.WordWrap   := False;
                mmoDestino.HAlign     := TfrxHAlign.haCenter;

                If FCadRel[intRelatPos].FieldByName('REL_STRHED').AsString = 'S' Then
                Begin
                  mmoDestino.StretchMode := smMaxHeight;
                  mmoDestino.WordWrap    := True;
                End;

                If FTipImp <> 'M' Then
                Begin
                  if blnSepararGruposVerticalmente then
                    mmoDestino.Frame.Typ  := [ftLeft, ftRight, ftTop, ftBottom]
                  else
                  begin
                    mmoDestino.Frame.Typ  := [ftTop, ftBottom];
                    fltLeftProxGrupo := fltLeft;
                  end;
                End;

                strLastCodGru := FieldByName(strCamGru).AsString;

              End Else // SE NÃO MUDOU O GRUPO
              Begin
                // INCREMENTA A LARGURA DO TÍTULO DO GRUPO
                mmoDestino.Width := mmoDestino.Width + fCmColunaToPixel(fRetornaLarguraCampo(FCampos), False, FTipImp, False) + fRetEspacametoColunas;
                if (FTipImp <> 'M') and (not blnSepararGruposVerticalmente) then
                  fltLeftProxGrupo := fltLeftProxGrupo + mmoDestino.Width;
              End;

              if (FTipImp <> 'M') and (not blnSepararGruposVerticalmente) then
                fltTopProxGrupo  := fltTop;

            End;

            fltLeft := fltLeft + fCmColunaToPixel(fRetornaLarguraCampo(FCampos), False, FTipImp, False) + fRetEspacametoColunas;
          End;

          Next;

          If (Not SameText(FieldByName(strCampoGuia).AsString, strLastListar)) And Assigned(mmoDestino) Then
          Begin
            fltLeft := 0;
            blnIncTop := True;
          End;

        End; {While}

        If Assigned(mmoDestino) Then
        Begin
          fltTop  := fltTop + mmoDestino.Height;
        End;

      End;

    End;

    Procedure pCriaTitulos;
      Var
        strCodGruAnt,
        strSubGruAnt: String;
        intColunas: Integer;
        blnNaoListarTitBranco: Boolean;
        blnSepararGruposVerticalmente: Boolean;
    Begin
      mmoDestino    := Nil;
      strLastListar := '';
      fltLeft       := 0;
      strCodGruAnt  := '';
      strSubGruAnt  := '';

      blnSepararGruposVerticalmente := FCadRel[intRelatPos].FieldByName('REL_GRUVER').AsString = 'S';

      blnListou := False;

      With FCampos Do
      Begin
        First;


        intColunas := 0;

        While (Not Eof) And ((FMaxCol = -1) Or (intColunas < FMaxCol)) Do
        Begin
          Inc(intColunas);

          blnNaoListarTitBranco := fEmptyStr(fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString))) and (FCadRel[intRelatPos].FieldByName('REL_NLTITB').AsString = 'S');

          If (Not fEmptyStr(FieldByName(strCampoGuia).AsString)) And
             fValidaVisibilidade(FCampos) And
             ((Not blnQuebra) Or
              (fEstaQuebrandoPeloCampo(FieldByName('CAM_LISQUE').AsString) And
               (FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString <> '3'))) And
               (not blnNaoListarTitBranco) Then
          Begin
            blnListou := True;

            strLastListar := FieldByName(strCampoGuia).AsString;

            If fltTop + fltHeight > frxPai.Height Then
              frxPai.Height := fltTop + fltHeight;

            mmoDestino := fCriaMemoView(frxPai);

            mmoDestino.Top        := fltTop;

            pAjustaLeft(fltLeft);

            mmoDestino.Left       := fltLeft;
            mmoDestino.Width      := fCmColunaToPixel(fRetornaLarguraCampo(FCampos), False, FTipImp, False);
            mmoDestino.Text       := fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString));
            mmoDestino.ParentFont := True;
            mmoDestino.Height     := fltHeight;
            mmoDestino.WordWrap   := False;

            If FCadRel[intRelatPos].FieldByName('REL_STRHED').AsString = 'S' Then
            Begin
              mmoDestino.StretchMode := smMaxHeight;
              mmoDestino.WordWrap    := True;
              mmoDestino.HAlign      := TfrxHAlign.haCenter;
              mmoDestino.VAlign      := TfrxVAlign.vaCenter;
            End;

            If FTipImp <> 'M' Then
            Begin

               If Not fEmptyStr(FieldByName('CAM_CODGRU').AsString) Then

             (*   If (strCodGruAnt = FieldByName('CAM_CODGRU').AsString) And
                   (strSubGruAnt = FieldByName('CAM_SUBGRU').AsString) Then
                Begin
                  if blnSepararGruposVerticalmente then
                    mmoDestino.Frame.Typ  := [ftRight, ftTop, ftBottom]
                  else
                    mmoDestino.Frame.Typ  := [ftTop, ftBottom];
                End
                Else *)
                Begin
                  if blnSepararGruposVerticalmente then
                    mmoDestino.Frame.Typ  := [ftLeft, ftRight, ftTop, ftBottom]
                  else
                    mmoDestino.Frame.Typ  := [ftTop, ftBottom];
                End;
            End;

            If AnsiMatchStr(FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
            Begin
              If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número inteiro') Or
                 SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Then
                mmoDestino.HAlign   := TfrxHAlign.haRight;
            End
            Else
            Begin
              Case AnsiIndexStr(FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
                0 : mmoDestino.HAlign := TfrxHAlign.haLeft;
                1 : mmoDestino.HAlign := TfrxHAlign.haCenter;
                2 : mmoDestino.HAlign := TfrxHAlign.haRight;
              End;
            End;

            fltLeft := fltLeft + mmoDestino.Width + fRetEspacametoColunas;

            strCodGruAnt := FieldByName('CAM_CODGRU').AsString;
            strSubGruAnt := FieldByName('CAM_SUBGRU').AsString;
          End;

          Next;

          blnNaoListarTitBranco := fEmptyStr(fTrataAcento(fDescricaoCampo(FieldByName('CAM_DESCAM').AsString))) and (FCadRel[intRelatPos].FieldByName('REL_NLTITB').AsString = 'S');

          If (Not SameText(FieldByName(strCampoGuia).AsString, strLastListar)) And Assigned(mmoDestino) And blnListou And (not blnNaoListarTitBranco) Then
          Begin
            fltLeft  := 0;
            fltTop   := fltTop + mmoDestino.Height + fIncTop;

            If FTipImp <> 'M' Then
            Begin
              frxLine := TfrxLineView.Create(frxPai);
              frxLine.Top := fltTop - fIncTop;
              frxLine.Left := 0;
              frxLine.Width := fCmColunaToPixel((frxPage.PaperWidth - frxPage.LeftMargin - frxPage.RightMargin) / 10, False, 'J', False);
            End;

            blnListou := False;
          End;

        End; {While}

      End;

    End;

Begin
  With FCampos Do
  Begin

    DisableControls;

    If blnQuebra Then
      strCampoGuia := 'CAM_LINQUE'
    Else
      strCampoGuia := 'CAM_LISTAR';

   IndexFieldNames := strCampoGuia + ';CAM_POSICA';

    If FTipImp = 'M' Then
      fltHeight := 17
    Else
      fltHeight := frxPai.Height;

    fltTop  := 0;

    mmoLinha := fCopiaLine('mmoLinhaHeaderInicial', '', 'mmoLinhaHeaderInicial' + frxPai.Name, frxPai, -1, strNomCam);
    If Assigned(mmoLinha) Then
    Begin
      If FTipImp = 'M' Then
        fltTop := 17
      Else
        fltTop := mmoLinha.Top + mmoLinha.Height + 2;
    End;

    pCriaGrupos('CAM_CODGRU');
    pCriaGrupos('CAM_SUBGRU');

    If (FTipImp <> 'M') And (fltTop = 0) Then
      fltTop := 3;

    pCriaTitulos;

    If FCadRel[intRelatPos].FieldByName('REL_STRHED').AsString = 'S' Then
    Begin
      If (frxPai is TfrxChild) Then
        TfrxChild(frxPai).Stretched := True
      Else
        TfrxHeader(frxPai).Stretched := True;
    End;

    If Assigned(mmoDestino) Then
      fltTop  := fltTop + mmoDestino.Height + fIncTop;

    if (not blnHeader) or (blnHeader and (FCadRel[intRelatPos].FieldByName('REL_SELIHE').AsString = 'S')) then
      fCopiaLine('mmoLinhaHeaderFinal', '', 'mmoLinhaHeaderFinal' + frxPai.Name, frxPai, fltTop, strNomCam);

    FCampos.IndexFieldNames := 'CAM_POSICA';
    EnableControls;
  End;
End;

Function TGeraFR3.fGetFontHeader: TFont;
  Var
    frxHeaderModelo: TfrxHeader;
Begin
  frxHeaderModelo := fRetHeader(FfrxModelo);

  If Assigned(frxHeaderModelo) Then
    Result := frxHeaderModelo.Font
  Else
    Result := Nil;
End;

Function TGeraFR3.fCriaHeader(strNomCam: string): Boolean;
  Var
    frxHeaderModelo: TfrxHeader;
    frxPai: TfrxComponent;
    mmoTitulo,
    mmoSubTitulo: TfrxCustomMemoView;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  frxHeaderModelo := fRetHeader(FfrxModelo);

  If Assigned(frxHeaderModelo) Then
  Begin
    frxHeader        := TfrxHeader.Create(frxPage);
    frxHeader.Name   := 'frxHeader' + IntToStr(intRelatPos) + strNomCam;
    frxHeader.Top    := FCurrentTop + 1;
    frxHeader.Height := frxHeaderModelo.Height;
    frxHeader.Font   := frxHeaderModelo.Font;

    If Assigned(FCadRel) And (Length(FCadRel) > 0) And (FCadRel[intRelatPos].FieldByName('REL_TITPOS').AsString = 'S') Then
    Begin
      frxChildHeader        := TfrxChild.Create(frxPage);
      frxChildHeader.Name   := 'frxChildHeader' + IntToStr(intRelatPos) + strNomCam;
      frxChildHeader.Font   := frxHeader.Font;
      frxChildHeader.Height := frxHeader.Height;

      mmoTitulo := fCopiaMemoView('mmoNomeRelatorio', '[NOME_RELATORIO' + IntToStr(intRelatPos) + ']', '', frxHeader, -1, True, strNomCam);
      If (Not fEmptyStr(IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False)),
                            fTrataAcento(FCadRel[intRelatPos].FieldByName('REL_SUBTIT').AsString),
                            TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False)))) Then
      Begin
        If Assigned(mmoTitulo) Then
        Begin
          mmoSubTitulo := fCopiaMemoView('mmoNomeRelatorio', '[SUBNOME_RELATORIO' + IntToStr(intRelatPos) + ']', 'mmoSubNomeRelatorio', frxHeader, (mmoTitulo.Top + mmoTitulo.Height), True, strNomCam);
          mmoSubTitulo.Font.Size := (mmoTitulo.Font.Size - 1);
        End;
      End;

      frxHeader.Child       := frxChildHeader;
      frxChildHeader.Top    := frxHeader.Top + frxHeader.Height + 1;

      frxPai := frxChildHeader;

      If fAjustaFolhaSemFim Then
      Begin
        frxChildHeader.OnAfterPrint := 'p' + frxChildHeader.Name + 'AfterPrint';

        With stlScriptImplementation Do
        Begin
          Add('');
          Add('procedure p' + frxChildHeader.Name + 'AfterPrint(Sender: TfrxComponent);');
          Add('begin');

          Add('  ' + frxChildHeader.Name + '.visible := False; ');

          Add('end;');
        End;
      End;

    End Else
    Begin
      frxPai := frxHeader;

      If fAjustaFolhaSemFim Then
      Begin
        frxHeader.OnAfterPrint := 'p' + frxHeader.Name + 'AfterPrint';

        With stlScriptImplementation Do
        Begin
          Add('');
          Add('procedure p' + frxHeader.Name + 'AfterPrint(Sender: TfrxComponent);');
          Add('begin');

          Add('  ' + frxHeader.Name + '.visible := False; ');

          Add('end;');
        End;
      End;

    End;


    frxPaiTitulosColunas := frxPai;

    fCopiaShape('mmoFundoTitulo', '',   '', frxPai, -1, strNomCam);

    frxHeader.Parent := frxPage;
    frxHeader.ReprintOnNewPage := True;

    If FCadRel[intRelatPos].FieldByName('REL_STRHED').AsString = 'S' Then
      frxHeader.Stretched := True;

    pMontaTitulos(frxPai, (Pos(FCadRel[intRelatPos].FieldByName('REL_TITQUE').AsString, 'D-3') > 0), strNomCam, True);

    if FCadRel[intRelatPos].FieldByName('REL_SELIHE').AsString = 'N' then
      frxPai.Height := frxPai.Height - 17;

    FCurrentTop := frxPai.Top + frxPai.Height;
  End;

  Result := True;
End;

Procedure TGeraFR3.pMontaCampo(mmoDestino: TfrxCustomMemoView; blnTestarAprove: Boolean; strNomeBanda: string = '');
Var
  strFormat: String;
  fltLargura: Double;
  strFonteAntiga: string;

  function fFormataFntCnd(strFntCnd: string): string;
  var
    intPosicao: Integer;
  begin
    with FCampos do
    begin
      intPosicao := RecNo;
      First;
      while not Eof do
      begin
        if Pos('<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">', strFntCnd) <= 0 then
          strFntCnd := AnsiReplaceStr(strFntCnd, FieldByName('CAM_NOMCAM').AsString, '<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">');
        Next;
      end;
      RecNo := intPosicao;
    end;
    Result := strFntCnd;
  end;

Begin
  With FCampos Do
  Begin
    If blnTestarAprove Then
      fltLargura := fRetornaLarguraCampo(FCampos)
    Else
      fltLargura := FieldByName('CAM_LARGUR').AsFloat;

    mmoDestino.Width      := fCmColunaToPixel(fltLargura, False, FTipImp, False);
    mmoDestino.Text       := fRetCampoRel(FCampos, strFormat, False, False);

    Case AnsiIndexStr(FieldByName('CAM_VALIGN').AsString, ['T', 'C', 'R']) Of
      0 : mmoDestino.VAlign := TfrxVAlign.vaTop;
      1 : mmoDestino.VAlign := TfrxVAlign.vaCenter;
      2 : mmoDestino.VAlign := TfrxVAlign.vaBottom;
    End;

    If AnsiMatchStr(FieldByName('CAM_ALINHA').AsString, ['', 'A']) Then
    Begin
      If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número inteiro') Or
         SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') Then
        mmoDestino.HAlign   := TfrxHAlign.haRight;
    End
    Else
    Begin
      Case AnsiIndexStr(FieldByName('CAM_ALINHA').AsString, ['E', 'C', 'D']) Of
        0 : mmoDestino.HAlign := TfrxHAlign.haLeft;
        1 : mmoDestino.HAlign := TfrxHAlign.haCenter;
        2 : mmoDestino.HAlign := TfrxHAlign.haRight;
      End;
    End;

    If SameText(FieldByName('CAM_NULBRA').AsString, 'S') Or
       (Not fEmptyStr(FieldByName('CAM_DEFFON').AsString)) Or
       ((not fEmptyStr(FieldByName('CAM_FNTCND').AsString)) And (not fEmptyStr(FieldByName('CAM_FNTCAM').AsString))) Or
       ((FieldByName('CAM_DESLIN').AsString = 'S') And (not fEmptyStr(strNomeBanda))) Then
    Begin

      mmoDestino.OnBeforePrint := 'p' + mmoDestino.Name + 'BeforePrint';
      strFonteAntiga := TInterfaceRelatorio.FontToStr(mmoDestino.Font);
      FFontInicialMasterData := strFonteAntiga;

      With stlScriptImplementation Do
      Begin
        Add('');
        Add('procedure ' + mmoDestino.OnBeforePrint + '(Sender: TfrxComponent);');

        Add('var');
        Add('  intColor: TColor; ');

        If Not fEmptyStr(FieldByName('CAM_DEFFON').AsString) Then
        Begin
          Add('  strFontStyles: String;');
          Add('  strFontName: string;');
        End;

        if FieldByName('CAM_DESLIN').AsString = 'S' then
        begin
          Add('  strTexto: string;');
          Add('  blnLineUp: Boolean;');
          Add('  blnLineDown: Boolean;');
          Add('  blnLineLeft: Boolean;');
          Add('  blnLineRight: Boolean;');
          Add('  blnMemoUp: Boolean;');
          Add('  blnMemoDown: Boolean;');
          Add('  blnMemoLeft: Boolean;');
          Add('  blnMemoRight: Boolean;');
          Add('  ');
        end;

        Add('begin');

        if FieldByName('CAM_DESLIN').AsString = 'S' then
        begin
          Add('  blnLineUp := False; ');
          Add('  blnLineDown := False; ');
          Add('  blnLineLeft := False; ');
          Add('  blnLineRight := False; ');
          Add('  blnMemoUp := False; ');
          Add('  blnMemoDown := False; ');
          Add('  blnMemoLeft := False; ');
          Add('  blnMemoRight := False; ');
          Add('  ');
          Add('  strTexto := <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">; ');
          Add('  ');

          Add('  ' + strNomeBanda + '.Frame.Typ := 0; ');

          Add('  if Pos(''<<LINEUP>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnLineUp := True; ');
          Add('    ' + strNomeBanda + '.Frame.Typ := ' + strNomeBanda + '.Frame.Typ + ftTop; ');
          Add('  end; ');
          Add('  if Pos(''<<LINEDOWN>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnLineDown := True; ');
          Add('    ' + strNomeBanda + '.Frame.Typ := ' + strNomeBanda + '.Frame.Typ + ftBottom; ');
          Add('  end; ');
          Add('  if Pos(''<<LINELEFT>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnLineLeft := True; ');
          Add('    ' + strNomeBanda + '.Frame.Typ := ' + strNomeBanda + '.Frame.Typ + ftLeft; ');
          Add('  end; ');
          Add('  if Pos(''<<LINERIGHT>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnLineRight := True; ');
          Add('    ' + strNomeBanda + '.Frame.Typ := ' + strNomeBanda + '.Frame.Typ + ftRight; ');
          Add('  end; ');

          Add('  if (blnLineUp or blnLineDown or blnLineLeft or blnLineRight) then ');
          Add('  begin');
          Add('    Delete(strTexto, Pos(''<<LINEUP>>'', strTexto), Length(''<<LINEUP>>'')); ');
          Add('    Delete(strTexto, Pos(''<<LINEDOWN>>'', strTexto), Length(''<<LINEDOWN>>'')); ');
          Add('    Delete(strTexto, Pos(''<<LINELEFT>>'', strTexto), Length(''<<LINELEFT>>'')); ');
          Add('    Delete(strTexto, Pos(''<<LINERIGHT>>'', strTexto), Length(''<<LINERIGHT>>'')); ');
          Add('  end; ');

          Add('  ' + mmoDestino.Name + '.Frame.Typ := 0; ');

          Add('  if Pos(''<<MEMOUP>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnMemoUp := True; ');
          Add('    ' + mmoDestino.Name + '.Frame.Typ := ' + mmoDestino.Name + '.Frame.Typ + ftTop; ');
          Add('  end; ');
          Add('  if Pos(''<<MEMODOWN>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnMemoDown := True; ');
          Add('    ' + mmoDestino.Name + '.Frame.Typ := ' + mmoDestino.Name + '.Frame.Typ + ftBottom; ');
          Add('  end; ');
          Add('  if Pos(''<<MEMOLEFT>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnMemoLeft := True; ');
          Add('    ' + mmoDestino.Name + '.Frame.Typ := ' + mmoDestino.Name + '.Frame.Typ + ftLeft; ');
          Add('  end; ');
          Add('  if Pos(''<<MEMORIGHT>>'', <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">) > 0 then ');
          Add('  begin ');
          Add('    blnMemoRight := True; ');
          Add('    ' + mmoDestino.Name + '.Frame.Typ := ' + mmoDestino.Name + '.Frame.Typ + ftRight; ');
          Add('  end; ');

          Add('  if (blnMemoUp or blnMemoDown or blnMemoLeft or blnMemoRight) then ');
          Add('  begin');
          Add('    Delete(strTexto, Pos(''<<MEMOUP>>'', strTexto), Length(''<<MEMOUP>>'')); ');
          Add('    Delete(strTexto, Pos(''<<MEMODOWN>>'', strTexto), Length(''<<MEMODOWN>>'')); ');
          Add('    Delete(strTexto, Pos(''<<MEMOLEFT>>'', strTexto), Length(''<<MEMOLEFT>>'')); ');
          Add('    Delete(strTexto, Pos(''<<MEMORIGHT>>'', strTexto), Length(''<<MEMORIGHT>>'')); ');
          Add('  end; ');
          Add('  ');
          Add('  TfrxMemoView(Sender).Text := strTexto; ');
        end;

        If SameText(FieldByName('CAM_NULBRA').AsString, 'S') Then
        Begin
          Add('  If fCampoNulo(''' + FieldByName('CAM_NOMCAM').AsString + ''', ' + intToStr(intRelatPos) + ') Then ');
          Add('    TfrxCustomMemoView(Sender).Text := ''''; ');
        End;

        If Not fEmptyStr(FieldByName('CAM_DEFFON').AsString) Then
        Begin
          Add(Concat('  strFontName := fRetornaFontName(<', fDataSetName(intRelatPos),  '."', FieldByName('CAM_DEFFON').AsString, '">); '));
          Add('  If strFontName <> '''' Then TfrxMemoView(Sender).Font.Name := strFontName ');
          Add(Concat('  Else TfrxMemoView(Sender).Font.Name := ', frxMasterData.Name, '.Font.Name; '));

          Add(Concat('  intColor := fRetornaFontColor(<', fDataSetName(intRelatPos),  '."', FieldByName('CAM_DEFFON').AsString, '">); '));
          Add('  If intColor <> -1 Then TfrxMemoView(Sender).Font.Color := intColor ');
          Add(Concat('  Else TfrxMemoView(Sender).Font.Color := ', frxMasterData.Name, '.Font.Color; '));

          Add(Concat('  intColor := fRetornaBrushColor(<', fDataSetName(intRelatPos),  '."', FieldByName('CAM_DEFFON').AsString, '">); '));
          Add('  If intColor <> -1 Then TfrxMemoView(Sender).Color := intColor ');
          Add(Concat('  Else TfrxMemoView(Sender).Color := clNone; '));

          Add(Concat('  strFontStyles := fRetornaFontStyles(<', fDataSetName(intRelatPos),  '."', FieldByName('CAM_DEFFON').AsString, '">); '));

          Add('  If strFontStyles <> '''' Then ');
          Add('  Begin ');
          Add('    TfrxMemoView(Sender).Font.Style := 0; ');

          Add('    If Pos(''fsBold'', strFontStyles) > 0 Then ');
          Add('      TfrxMemoView(Sender).Font.Style := TfrxMemoView(Sender).Font.Style + fsBold; ');

          Add('    If Pos(''fsItalic'', strFontStyles) > 0 Then ');
          Add('      TfrxMemoView(Sender).Font.Style := TfrxMemoView(Sender).Font.Style+ fsItalic; ');

          Add('    If Pos(''fsUnderline'', strFontStyles) > 0 Then ');
          Add('      TfrxMemoView(Sender).Font.Style := TfrxMemoView(Sender).Font.Style + fsUnderline; ');

          Add('    If Pos(''fsStrikeOut'', strFontStyles) > 0 Then ');
          Add('      TfrxMemoView(Sender).Font.Style := TfrxMemoView(Sender).Font.Style + fsStrikeOut; ');
          Add('  End ');
          Add(Concat('  Else TfrxMemoView(Sender).Font.Style := ', frxMasterData.Name, '.Font.Style; '));
        End

        Else If ((not fEmptyStr(FieldByName('CAM_FNTCND').AsString)) And (not fEmptyStr(FieldByName('CAM_FNTCAM').AsString))) Then
        Begin
          Add('  If (' + fFormataFntCnd(FieldByName('CAM_FNTCND').AsString) + ') Then ');
          Add('  begin');
          Add('    TfrxMemoView(Sender).Font.Name  := ' + QuotedStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FieldByName('CAM_FNTCAM').AsString), 'Name')) + '; ');
          Add('    TfrxMemoView(Sender).Font.Color := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FieldByName('CAM_FNTCAM').AsString), 'Color') + '; ');
          Add('    TfrxMemoView(Sender).Font.Size  := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FieldByName('CAM_FNTCAM').AsString), 'Size') + '; ');
          Add('    TfrxMemoView(Sender).Font.Style := ' + AnsiReplaceStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(FieldByName('CAM_FNTCAM').AsString), 'Style'), '|', '+') + '; ');
          Add('  end');
          Add('  else');
          Add('  begin');
          Add('    TfrxMemoView(Sender).Font.Name  := ' + QuotedStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Name')) + '; ');
          Add('    TfrxMemoView(Sender).Font.Color := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Color') + '; ');
          Add('    TfrxMemoView(Sender).Font.Size  := ' + TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Size') + '; ');
          Add('    TfrxMemoView(Sender).Font.Style := ' + AnsiReplaceStr(TInterfaceRelatorio.fRetornaFontTag(TInterfaceRelatorio.StrToFont(strFonteAntiga), 'Style'), '|', '+') + '; ');
          Add('  end;');
        End;

        Add('end;');
      End;

    End;

    If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') And Not SameText(FieldByName('CAM_MASCAR').AsString, 'Máscara Contábil') Then
      Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
        masDecUni       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DECUNI', varString) + 'n');
        masDecQtd       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DECQTD', varString) + 'n');
        masEstDec       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('ESTDEC', varString) + 'n');
        masDeqTpc       : pFormataDecimais(mmoDestino, '%2.' + fCfgSis('DEQTPC', varString) + 'n');
        Else              pFormataDecimais(mmoDestino, '%2.' + IntToStr(FieldByName('CAM_NRODEC').AsInteger) + 'n');
      End;

    pFormataDecimais(mmoDestino, strFormat);

    If SameText(FieldByName('CAM_STRETC').AsString, 'S') Then
      mmoDestino.StretchMode := smMaxHeight
    Else
      mmoDestino.WordWrap   := False;

  End;
End;

Procedure TGeraFR3.pMontaCampoPicture(mmoDestino: TfrxPictureView; blnTestarAprove: Boolean; strNomeBanda: string = '');
Var
  fltLargura: Double;
  strFonteAntiga: string;

  function fFormataFntCnd(strFntCnd: string): string;
  var
    intPosicao: Integer;
  begin
    with FCampos do
    begin
      intPosicao := RecNo;
      First;
      while not Eof do
      begin
        if Pos('<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">', strFntCnd) <= 0 then
          strFntCnd := AnsiReplaceStr(strFntCnd, FieldByName('CAM_NOMCAM').AsString, '<' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">');
        Next;
      end;
      RecNo := intPosicao;
    end;
    Result := strFntCnd;
  end;

Begin
  With FCampos Do
  Begin
    If blnTestarAprove Then
      fltLargura := fRetornaLarguraCampo(FCampos)
    Else
      fltLargura := FieldByName('CAM_LARGUR').AsFloat;

    mmoDestino.Width      := fCmColunaToPixel(fltLargura, False, FTipImp, False);
	  mmoDestino.Height     := (FieldByName('CAM_ALTIMG').AsFloat * 38);


  	mmoDestino.OnBeforePrint := 'p' + mmoDestino.Name + 'BeforePrint';
    strFonteAntiga := TInterfaceRelatorio.FontToStr(mmoDestino.Font);
    FFontInicialMasterData := strFonteAntiga;

    With stlScriptImplementation Do
    Begin
      Add('');
      Add('procedure ' + mmoDestino.OnBeforePrint + '(Sender: TfrxComponent);');
      Add('var');
      Add('  strPathImg: String;');
      Add('begin');
      Add('  strPathImg := <' + fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '">;');
      Add('');
      Add('  if (strPathImg = '''') then');
      Add('    exit;');
      Add('');
      Add('  if (not fVerificaFileExists(strPathImg)) then');
      Add('    exit;');
      Add('');
  	  Add('  ' + mmoDestino.Name + '.LoadFromFile(strPathImg);');
      Add('end;');
      End;
  End;
End;

Function TGeraFR3.fRetBarCode(strBarCod: String): TfrxBarcodeType;
Begin
  If SameText(strBarCod, 'Code_2_5_interleaved') Then
    Result := bcCode_2_5_interleaved

  Else If SameText(strBarCod, 'Code_2_5_industrial') Then
    Result := bcCode_2_5_industrial

  Else If SameText(strBarCod, 'Code_2_5_matrix') Then
    Result := bcCode_2_5_matrix

  Else If SameText(strBarCod, 'Code39') Then
    Result := bcCode39

  Else If SameText(strBarCod, 'Code39Extended') Then
    Result := bcCode39Extended

  Else If SameText(strBarCod, 'Code128') Then
    Result := bcCode128

  Else If SameText(strBarCod, 'Code128A') Then
    Result := bcCode128A

  Else If SameText(strBarCod, 'Code128B') Then
    Result := bcCode128B

  Else If SameText(strBarCod, 'Code128C') Then
    Result := bcCode128C

  Else If SameText(strBarCod, 'Code93') Then
    Result := bcCode93

  Else If SameText(strBarCod, 'Code93Extended') Then
    Result := bcCode93Extended

  Else If SameText(strBarCod, 'CodeMSI') Then
    Result := bcCodeMSI

  Else If SameText(strBarCod, 'CodePostNet') Then
    Result := bcCodePostNet

  Else If SameText(strBarCod, 'CodeCodabar') Then
    Result := bcCodeCodabar

  Else If SameText(strBarCod, 'CodeEAN8') Then
    Result := bcCodeEAN8

  Else If SameText(strBarCod, 'CodeEAN13') Then
    Result := bcCodeEAN13

  Else If SameText(strBarCod, 'CodeUPC_A') Then
    Result := bcCodeUPC_A

  Else If SameText(strBarCod, 'CodeUPC_E0') Then
    Result := bcCodeUPC_E0

  Else If SameText(strBarCod, 'CodeUPC_E1') Then
    Result := bcCodeUPC_E1

  Else If SameText(strBarCod, 'CodeUPC_Supp2') Then
    Result := bcCodeUPC_Supp2

  Else If SameText(strBarCod, 'CodeUPC_Supp5') Then
    Result := bcCodeUPC_Supp5

  Else If SameText(strBarCod, 'CodeEAN128A') Then
    Result := bcCodeEAN128A

  Else If SameText(strBarCod, 'CodeEAN128B') Then
    Result := bcCodeEAN128B

  Else If SameText(strBarCod, 'CodeEAN128C') Then
    Result := bcCodeEAN128C

  Else
    Result := bcCodeEAN13
End;

Function TGeraFR3.fCriaCodeBar(Owner: TComponent): TfrxBarCodeView;
Begin
  Result := Nil;

  If FTipImp = 'J' Then
  Begin
    Result := TfrxBarCodeView.Create(Owner);
    Result.parent := TfrxComponent(Owner);
    Inc(FSeqMemo);
    Result.Name := 'BarCodeView' + FSeqMemo.ToString;
  End;
End;

Procedure TGeraFR3.pMontaCodeBar(barDestino: TfrxBarCodeView; blnTestarAprove: Boolean; strNomeBanda: string = '');
Var
  fltLargura: Double;

  Function fZoomBarCode(bctBarCod: TfrxBarcodeType; Tamanho: Double): Double;
  Begin
    Case bctBarCod Of
      bcCode_2_5_interleaved: Result := 4.4;
      bcCode_2_5_industrial : Result := 4.4;
      bcCode_2_5_matrix     : Result := 3.1;
      bcCode39              : Result := 5;
      bcCode39Extended      : Result := 5;
      bcCode128             : Result := 3.2;
      bcCode128A            : Result := 4.65;
      bcCode128B            : Result := 4.65;
      bcCode128C            : Result := 4.65;
      bcCode93              : Result := 4;
      bcCode93Extended      : Result := 4;
      bcCodeMSI             : Result := 4.2;
      bcCodePostNet         : Result := 5.2;
      bcCodeCodabar         : Result := 3.9;
      bcCodeEAN8            : Result := 2.72;
      bcCodeEAN13           : Result := 2.72;
      bcCodeUPC_A           : Result := 3.1;
      bcCodeUPC_E0          : Result := 1.8;
      bcCodeUPC_E1          : Result := 1.8;
      bcCodeUPC_Supp2       : Result := 1.3;
      bcCodeUPC_Supp5       : Result := 1.3;
      bcCodeEAN128A         : Result := 5;
      bcCodeEAN128B         : Result := 5;
      bcCodeEAN128C         : Result := 5;
      Else                    Result := 2.72;
    End;
  End;

Begin
  With FCampos Do
  Begin
    barDestino.Height := fCmColunaToPixel(FieldByName('CAM_ALTURA').AsFloat, True, FTipImp, False);
    barDestino.ShowText := SameText(FieldByName('CAM_MOSTXT').AsString, 'S');
    barDestino.Color := FieldByName('CAM_VALCOR').AsInteger;
    barDestino.text := '';
    barDestino.Expression := '';

    barDestino.BarType  := fRetBarCode(FieldByName('CAM_CAMBAR').AsString);

    barDestino.BarCode.Checksum := SameText(FieldByName('CAM_CHKSUM').AsString, 'S');

    TInterfaceRelatorio.StrToFont(FCampos.FieldByName('CAM_FNTCAM').AsString, barDestino.Font);

    If (barDestino.Color = clWhite) Or (barDestino.Color = 0) Then
      barDestino.Color := clNone;

    If blnTestarAprove Then
      fltLargura := fRetornaLarguraCampo(FCampos)
    Else
      fltLargura := FieldByName('CAM_LARGUR').AsFloat;

    barDestino.Width := fCmColunaToPixel(fltLargura, False, FTipImp, False);

    If FieldByName('CAM_BARZOO').AsFloat > 0 Then
      barDestino.Zoom := FieldByName('CAM_BARZOO').AsFloat
    Else
      barDestino.Zoom := RoundTo(fltLargura / fZoomBarCode(barDestino.BarType, FieldByName('CAM_LARGUR').AsFloat), -2);

    barDestino.DataSetName := fDataSetName(intRelatPos);
    barDestino.DataField := FieldByName('CAM_NOMCAM').AsString;

//    barDestino.Expression  := fRetCampoRel(FCampos, strFormat, True, False);


  End;
End;

Procedure TGeraFR3.pMontaCampos(strNomeBanda: string = ''; strNomCam: string = '');
  Var
    mmoDestino: TfrxCustomMemoView;
    pctDestino: TfrxPictureView;

    barDestino: TfrxBarCodeView;

    fltHeight,
    fltLeft,
    fltTopIni,
    fltTop,
    fltImage,
    fltImageLinha: Double;
    strLastListar: String;

    intColunas,
    intLinha: Integer;

    arrCamposLinha: Array of string;
    arrFieldsLinha: Array of string;
    arrStretcCampo: Array of string;
    arrAlturaLinha: Array of Double;

    blnMontouCampo: Boolean;
Begin
  With FCampos Do
  Begin
    blnMontouCampo := False;

    mmoDestino := Nil;
    DisableControls;
    IndexFieldNames := 'CAM_LISTAR;CAM_POSICA';

    intLinha := 1;

    If FTipImp = 'M' Then
    Begin
      fltTopIni  := 0;
      fltHeight := 17;
    End Else
    Begin
      fltTopIni  := 0;
      fltHeight := frxMasterData.Height;
    End;

    fltImageLinha := 0;
    fltImage := 0;

    strLastListar := '';
    fltLeft  := 0;

    First;

    intColunas := 0;

    SetLength(arrCamposLinha, 1);
    SetLength(arrFieldsLinha, 1);
    SetLength(arrStretcCampo, 1);
    SetLength(arrAlturaLinha, 1);

    While (Not Eof) And ((FMaxCol = -1) Or (intColunas < FMaxCol)) Do
    Begin
      Inc(intColunas);

      If (Not fEmptyStr(FieldByName('CAM_LISTAR').AsString)) And
         fValidaVisibilidade(FCampos) Then
      Begin
        If (Not fEmptyStr(strLastListar)) And
           (strLastListar <> FieldByName('CAM_LISTAR').AsString) Then
        Begin
          Inc(intLinha);
          SetLength(arrCamposLinha, Succ(Length(arrCamposLinha)));
          SetLength(arrFieldsLinha, Succ(Length(arrFieldsLinha)));
          SetLength(arrStretcCampo, Succ(Length(arrStretcCampo)));
          SetLength(arrAlturaLinha, Succ(Length(arrAlturaLinha)));
        End;

        strLastListar := FieldByName('CAM_LISTAR').AsString;

        fltTop := (fltTopIni + (intLinha - 1) * fltHeight) + fltImageLinha;

        If fltTop + fltHeight > frxMasterData.Height Then
          frxMasterData.Height := fltTop + fltHeight;

        If Not fEmptyStr(FieldByName('CAM_CAMBAR').AsString) Then
        Begin
          barDestino := fCriaCodeBar(frxMasterData);
          barDestino.Name := 'barcode' + FCodRels[0] + '_' + IntToStr(RecNo) + '_' + fSomenteLetra(fRemoveAcento(FieldByName('CAM_NOMCAM').AsString));
          barDestino.Top  := fltTop + 1;

          arrCamposLinha[High(arrCamposLinha)] := arrCamposLinha[High(arrCamposLinha)] + IIF(fEmptyStr(arrCamposLinha[High(arrCamposLinha)]), '', ',') + barDestino.Name;
          arrFieldsLinha[High(arrFieldsLinha)] := arrFieldsLinha[High(arrFieldsLinha)] + IIF(fEmptyStr(arrFieldsLinha[High(arrFieldsLinha)]), '', ',') + FieldByName('CAM_NOMCAM').AsString;
          arrStretcCampo[High(arrStretcCampo)] := arrStretcCampo[High(arrStretcCampo)] + IIF(fEmptyStr(arrStretcCampo[High(arrStretcCampo)]), '', ',') + FieldByName('CAM_STRETC').AsString;
          arrAlturaLinha[High(arrAlturaLinha)] := fltTop;

          pAjustaLeft(fltLeft);

          barDestino.Left       := fltLeft;
         // barDestino.Height     := fltHeight;

          pMontaCodeBar(barDestino, True, strNomeBanda);

          frxMasterData.Stretched := True;

          fltLeft := fltLeft + barDestino.Width + fRetEspacametoColunas;
        End Else If (FieldByName('CAM_EXBIMG').AsString = 'S') then
        Begin
          pctDestino := fCriaPictureView(frxMasterData);
          pctDestino.Name := 'mmo' + FCodRels[0] + strNomCam + '_' + IntToStr(RecNo) + '_' + fSomenteLetra(fRemoveAcento(FieldByName('CAM_NOMCAM').AsString));

          pctDestino.Top        := fltTop;

          arrCamposLinha[High(arrCamposLinha)] := arrCamposLinha[High(arrCamposLinha)] + IIF(fEmptyStr(arrCamposLinha[High(arrCamposLinha)]), '', ',') + pctDestino.Name;
          arrFieldsLinha[High(arrFieldsLinha)] := arrFieldsLinha[High(arrFieldsLinha)] + IIF(fEmptyStr(arrFieldsLinha[High(arrFieldsLinha)]), '', ',') + FieldByName('CAM_NOMCAM').AsString;
          arrStretcCampo[High(arrStretcCampo)] := arrStretcCampo[High(arrStretcCampo)] + IIF(fEmptyStr(arrStretcCampo[High(arrStretcCampo)]), '', ',') + FieldByName('CAM_STRETC').AsString;
          arrAlturaLinha[High(arrAlturaLinha)] := fltTop;

          pAjustaLeft(fltLeft);

          pctDestino.Left       := fltLeft;
          pctDestino.ParentFont := True;
          pctDestino.Height     := (FieldByName('CAM_ALTIMG').AsFloat * 38);

          pMontaCampoPicture(pctDestino, True, strNomeBanda);

          fltLeft := fltLeft + pctDestino.Width + fRetEspacametoColunas;

          if fltImage < pctDestino.Height then
            fltImage := pctDestino.Height;


        End Else
        Begin
          mmoDestino := fCriaMemoView(frxMasterData);

          mmoDestino.Name := 'mmo' + FCodRels[0] + strNomCam + '_' + IntToStr(RecNo) + '_' + fSomenteLetra(fRemoveAcento(FieldByName('CAM_NOMCAM').AsString));

          If (Not blnMontouCampo) And fAjustaFolhaSemFim Then
          Begin
            mmoDestino.OnBeforePrint := 'p' + mmoDestino.Name + 'BeforePrint';
            pBeforePrintQuebraPaginaSemFim(mmoDestino.Name);
            blnMontouCampo := True;
          End;

          mmoDestino.Top        := fltTop;

          arrCamposLinha[High(arrCamposLinha)] := arrCamposLinha[High(arrCamposLinha)] + IIF(fEmptyStr(arrCamposLinha[High(arrCamposLinha)]), '', ',') + mmoDestino.Name;
          arrFieldsLinha[High(arrFieldsLinha)] := arrFieldsLinha[High(arrFieldsLinha)] + IIF(fEmptyStr(arrFieldsLinha[High(arrFieldsLinha)]), '', ',') + FieldByName('CAM_NOMCAM').AsString;
          arrStretcCampo[High(arrStretcCampo)] := arrStretcCampo[High(arrStretcCampo)] + IIF(fEmptyStr(arrStretcCampo[High(arrStretcCampo)]), '', ',') + FieldByName('CAM_STRETC').AsString;
          arrAlturaLinha[High(arrAlturaLinha)] := fltTop;

          pAjustaLeft(fltLeft);

          mmoDestino.Left       := fltLeft;
          mmoDestino.ParentFont := True;
          mmoDestino.Height     := fltHeight;

          pMontaCampo(mmoDestino, True, strNomeBanda);

          If mmoDestino.StretchMode = smMaxHeight Then
            frxMasterData.Stretched := True;

          fltLeft := fltLeft + mmoDestino.Width + fRetEspacametoColunas;
        End;
      End;

      If SameText(FieldByName('CAM_KEEPCH').AsString, 'S') Then
        If Assigned(frxMasterData) then
        Begin
          frxMasterData.KeepTogether := True;
          frxMasterData.KeepChild := True;
        End;

      Next;

      If (Not SameText(FieldByName('CAM_LISTAR').AsString, strLastListar)) And Assigned(mmoDestino) Then
      Begin
        fltLeft  := 0;
        fltImageLinha := fltImageLinha + fltImage;
        fltImage := 0;
      End;

    End; {While (Not Eof) And ((FMaxCol = -1) Or (intColunas < FMaxCol)) Do}

    if (FCadRel[intRelatPos].FieldByName('REL_EXLIBR').AsString = 'S') then
      pEliminaCamposVazios(arrCamposLinha, arrFieldsLinha, arrStretcCampo, arrAlturaLinha);

    FCampos.IndexFieldNames := 'CAM_POSICA';
    EnableControls;
  End;
End;

Procedure TGeraFR3.pEliminaCamposVazios(arrCampos, arrFields, arrStretc: Array of string; arrAltura: Array of Double);
var
  intContArray,
  intContTermo: Integer;
  blnBeforePrint: Boolean;
  stlTermos,
  stlStretc: TStringList;
  arrCondicoes: Array of string;

  function fRetornaIfTop(intLinha: Integer): string;
  begin
    case intLinha of
      5: Result := 'IIF(intLinhasDec = 4, fltAlturaLinha1, IIF(intLinhasDec = 3, fltAlturaLinha2, IIF(intLinhasDec = 2, fltAlturaLinha3, IIF(intLinhasDec = 1, fltAlturaLinha4, fltAlturaLinha5))))';
      4: Result := 'IIF(intLinhasDec = 3, fltAlturaLinha1, IIF(intLinhasDec = 2, fltAlturaLinha2, IIF(intLinhasDec = 1, fltAlturaLinha3, fltAlturaLinha4)))';
      3: Result := 'IIF(intLinhasDec = 2, fltAlturaLinha1, IIF(intLinhasDec = 1, fltAlturaLinha2, fltAlturaLinha3))';
      2: Result := 'IIF(intLinhasDec = 1, fltAlturaLinha1, fltAlturaLinha2)';
    end;
  end;

begin

  SetLength(arrCondicoes, 0);
  blnBeforePrint := False;

  for intContArray := Low(arrAltura) to High(arrAltura) do
  begin
    blnBeforePrint := (intContArray > 0);
    SetLength(arrCondicoes, Succ(Length(arrCondicoes)));
    stlTermos := TStringList.Create;
    try
      ExtractStrings([','], [], PWideChar(arrFields[intContArray]), stlTermos);
      for intContTermo := 0 to stlTermos.Count - 1 do
        arrCondicoes[High(arrCondicoes)] := arrCondicoes[High(arrCondicoes)] + IIF(fEmptyStr(arrCondicoes[High(arrCondicoes)]), '', ' and ') + 'fCampoVazio(''' + stlTermos[intContTermo] + ''', ' + intToStr(intRelatPos) + ')';
    finally
      FreeAndNil(stlTermos);
    end;
  end;

  If blnBeforePrint Then
  Begin
    frxMasterData.OnBeforePrint := 'p' + FCodRels[0] + frxMasterData.Name + 'BeforePrint';

    With stlScriptImplementation Do
    Begin
      Add('');
      Add('procedure ' + frxMasterData.OnBeforePrint + '(Sender: TfrxComponent);');
      Add('var');
      Add('  intLinhasBranco: Integer;');
      Add('  intLinhasDec: Integer;');
      Add('  fltAlturaMaster: Double;');
      Add('  blnStretched: Boolean;');

      // declarando variáveis de altura
      for intContArray := Low(arrAltura) to High(arrAltura) do
        Add('  fltAlturaLinha' + IntToStr(intContArray + 1) + ': Double;');

      Add('begin');

      // setando altura original e sctretched original
      Add('  fltAlturaMaster := ' + AnsiReplaceStr(FloatToStr(frxMasterData.Height), ',', '.') + ';');
      Add('  blnStretched := ' + IIF(frxMasterData.Stretched, 'True', 'False') + ';');
      Add('  intLinhasBranco := 0;');

      // instanciando variáveis de altura
      for intContArray := Low(arrAltura) to High(arrAltura) do
        Add('  fltAlturaLinha' + IntToStr(intContArray + 1) + ' := ' + AnsiReplaceStr(FloatToStr(arrAltura[intContArray]), ',', '.') + ';');

      // incrementando quantidade de linhas em branco
      for intContArray := Low(arrAltura) to High(arrAltura) do
      begin
        Add('  if (' + arrCondicoes[intContArray] + ') then ');
        Add('    intLinhasBranco := intLinhasBranco + 1;');
      end;

      Add('  intLinhasDec := intLinhasBranco;');

      // só vai entrar caso encontre linhas em branco
      Add('  if (intLinhasBranco > 0) then');
      Add('  begin');

      // setando Stretched como falso para conseguir alterar altura do masterdata
      Add('    ' + frxMasterData.Name + '.Stretched := False; ');

      // definindo altura de uma linha para conseguir aumentar depois
      Add('    ' + frxMasterData.Name + '.Height := (fltAlturaMaster / ' + IntToStr(Length(arrAltura)) + ');');

      for intContArray := High(arrAltura) downto Low(arrAltura) do
      begin
        if intContArray > Low(arrAltura) then
        begin
          Add('    if (' + arrCondicoes[intContArray] + ') then ');
          Add('    begin ');

          // escondendo os campos da atual linha que estão todos em branco
          stlTermos := TStringList.Create;
          try
            ExtractStrings([','], [], PWideChar(arrCampos[intContArray]), stlTermos);
            for intContTermo := 0 to stlTermos.Count - 1 do
            begin
              Add('      ' + stlTermos[intContTermo] + '.Visible := False; ');
            end;
          finally
            FreeAndNil(stlTermos);
          end;
          Add('      intLinhasDec := intLinhasDec - 1;');

          Add('    end ');
          Add('    else ');
          Add('    begin ');

          // reposicionando os campos da atual linha
          stlTermos := TStringList.Create;
          try
            ExtractStrings([','], [], PWideChar(arrCampos[intContArray]), stlTermos);
            for intContTermo := 0 to stlTermos.Count - 1 do
            begin
              Add('      ' + stlTermos[intContTermo] + '.Visible := True; ');
              case (intContArray + 1) of
                2 : Add('      ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(2) + ';');
                3 : Add('      ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(3) + ';');
                4 : Add('      ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(4) + ';');
                5 : Add('      ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(5) + ';');
              end;
            end;
          finally
            FreeAndNil(stlTermos);
          end;
          Add('    end; ');
        end;
      end;

      // aqui eu deixo o masterdata no tamanho reduzido
      Add('    ' + frxMasterData.Name + '.Height := (fltAlturaMaster - (fltAlturaMaster / ' + IntToStr(Length(arrAltura)) + ' * intLinhasBranco));');

      Add('  end ');
      Add('  else ');
      Add('  begin ');

      // aqui eu restauro tudo, pois não tem nenhuma linha oculta
      for intContArray := High(arrAltura) downto Low(arrAltura) do
      begin
        stlTermos := TStringList.Create;
        stlStretc := TStringList.Create;
        try
          ExtractStrings([','], [], PWideChar(arrCampos[intContArray]), stlTermos);
          ExtractStrings([','], [], PWideChar(arrStretc[intContArray]), stlStretc);
          for intContTermo := 0 to stlTermos.Count - 1 do
          begin
            Add('    ' + stlTermos[intContTermo] + '.Visible := True; ');
            case (intContArray + 1) of
              2 : Add('    ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(2) + ';');
              3 : Add('    ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(3) + ';');
              4 : Add('    ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(4) + ';');
              5 : Add('    ' + stlTermos[intContTermo] + '.Top := ' + fRetornaIfTop(5) + ';');
            end;
            Add('    ' + stlTermos[intContTermo] + '.StretchMode := ' + IIF(stlStretc[intContTermo] = 'S', 'smMaxHeight', 'smDontStretch')  + '; ');
            Add('    ' + stlTermos[intContTermo] + '.WordWrap := ' + IIF(stlStretc[intContTermo] = 'S', 'True', 'False')  + '; ');
          end;
        finally
          FreeAndNil(stlTermos);
          FreeAndNil(stlStretc);
        end;
      end;

      // aqui eu deixo o masterdata com o tamanho original
      Add('    ' + frxMasterData.Name + '.Height := fltAlturaMaster; ');
      // aqui eu deixo o masterdata com o stretched original
      Add('    ' + frxMasterData.Name + '.Stretched := blnStretched; ');

      Add('  end; ');
      Add('end;');
    End;

  End;

end;

Procedure TGeraFR3.pBeforePrintQuebraPaginaSemFim(strNomComp: String);
Begin
  stlScriptImplementation.Add('Procedure p' + strNomComp + 'BeforePrint(Sender: TfrxComponent);');
  stlScriptImplementation.Add('Begin');
  stlScriptImplementation.Add(' If Engine.CurY > ' + IntToStr(Trunc(fCmColunaToPixel(FCadRel[intRelatPos].FieldByName('REL_ALTMAX').AsInteger,
                                                                               True, FTipImp, False))) + ' Then ');
  stlScriptImplementation.Add('   Engine.NewPage; ');
  stlScriptImplementation.Add('');
  stlScriptImplementation.Add('End;');
End;

Function TGeraFR3.fCriaMasterData(strNomCam: string): Boolean;
  Var
    frxMasterModelo: TfrxMasterData;
    strNomeBanda: string;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  If (intRelatPos > 0) Or (not fRetGerarVideoVazio) Then
  Begin
    frxMasterModelo := fRetMasterData(FfrxModelo);

    If Assigned(frxMasterModelo) Then
    Begin
      frxMasterData            := TfrxMasterData.Create(frxPage);
      frxMasterData.Name       := fMasterDataName(intRelatPos, strNomCam);
      frxMasterData.Height     := frxMasterModelo.Height;
      frxMasterData.Font       := frxMasterModelo.Font;
      frxMasterData.AllowSplit := frxMasterModelo.AllowSplit;

      frxMasterData.DataSetName := fDataSetName(intRelatPos);

      frxMasterData.Top := FCurrentTop + 1;

      if Assigned(FfrxModelo) then
        if FfrxModelo.FindObject('mmoZebra') <> nil then
        begin
          TfrxMemoView(FfrxModelo.FindObject('mmoZebra')).Highlight.Color     := IIF(FCadRel[intRelatPos].FieldByName('REL_CORZEB').AsInteger = -16777216, fCfgSis('CORZEB', varInteger), FCadRel[intRelatPos].FieldByName('REL_CORZEB').AsInteger);
          if FCadRel[intRelatPos].FieldByName('REL_REIZEB').AsString = 'N' then
            TfrxMemoView(FfrxModelo.FindObject('mmoZebra')).Highlight.Condition := '<Line#> Mod 2 = 0';
        end;

      if FfrxModelo.FindObject('mmoZebra') <> nil then
        strNomeBanda := fCopiaMemoView('mmoZebra', '',   '', frxMasterData, -1, True, strNomCam).Name;

      pMontaCampos(strNomeBanda, strNomCam);

      FCurrentTop := frxMasterData.Top + frxMasterData.Height;
    End;
  End;

  If (intRelatPos = 0) and fRetGerarVideoVazio Then
    fCriaMasterDataVazio;

  Result := True;
End;

Function TGeraFR3.fCriaMasterDataVazio: Boolean;
  Var
    frxMasterModelo: TfrxMasterData;
    mmoDestino: TfrxCustomMemoView;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  frxMasterModelo := fRetMasterData(FfrxModelo);

  If Assigned(frxMasterModelo) Then
  Begin
    frxMasterData            := TfrxMasterData.Create(frxPage);
    frxMasterData.Name       := 'frxMasterDataVazio';
    frxMasterData.Height     := 80;
    frxMasterData.Font       := frxMasterModelo.Font;
    frxMasterData.Font.Size  := frxMasterData.Font.Size + 1;
    frxMasterData.Font.Style := [fsBold];
    frxMasterData.AllowSplit := frxMasterModelo.AllowSplit;

    frxMasterData.DataSetName := 'frxDataSetVazio';

    frxMasterData.Top := FCurrentTop + 1;

    mmoDestino := fCriaMemoView(frxMasterData);

    mmoDestino.Name     := 'mmoMensagemVazio';
    mmoDestino.Align    := baNone;
    mmoDestino.HAlign   := TfrxHAlign.haCenter;
    mmoDestino.Left     := frxPage.LeftMargin;
    mmoDestino.Width    := fLarguraPaginaOriginal - fMargemEsquerda - fMargemDireita - fCmColunaToPixel(1, False, FTipImp, False);
    mmoDestino.WordWrap := True;
    mmoDestino.Height   := 70;
    mmoDestino.Top      := 10;

    mmoDestino.Text     := '[frxDataSetVazio."MENSAGEM_DADOS"]';

    FCurrentTop := frxMasterData.Top + frxMasterData.Height;
  End;

  Result := True;
End;

Function TGeraFr3.fRetReportPage(frxReport: TfrxReport): TfrxReportPage;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxReportPage) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxReportPage);
      Break;
    End

    Else If (frxReport.Components[intIndice] Is TfrxDMPPage) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxReportPage);
      Break;
    End

End;

Function TGeraFr3.fRetPageHeader(frxReport: TfrxReport): TfrxPageHeader;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxPageHeader) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxPageHeader);
      Break;
    End;
End;

Function TGeraFr3.fRetPageFooter(frxReport: TfrxReport): TfrxPageFooter;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxPageFooter) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxPageFooter);
      Break;
    End;
End;

Function TGeraFr3.fRetFooter(frxReport: TfrxReport): TfrxFooter;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxFooter) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxFooter);
      Break;
    End;
End;

Function TGeraFr3.fRetHeader(frxReport: TfrxReport): TfrxHeader;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxHeader) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxHeader);
      Break;
    End;
End;

Function TGeraFr3.fRetGroupHeader(frxReport: TfrxReport): TfrxGroupHeader;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxGroupHeader) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxGroupHeader);
      Break;
    End;
End;

Function TGeraFr3.fRetGroupFooter(frxReport: TfrxReport): TfrxGroupFooter;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  For intIndice := 0 To frxReport.ComponentCount - 1 Do
    If (frxReport.Components[intIndice] Is TfrxGroupFooter) Then
    Begin
      Result := (frxReport.Components[intIndice] As TfrxGroupFooter);
      Break;
    End;
End;

Function TGeraFr3.fRetMasterData(frxReport: TfrxReport; strNomMas: String = ''): TfrxMasterData;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  With frxReport Do
  For intIndice := 0 To ComponentCount - 1 Do
    If (Components[intIndice] Is TfrxMasterData) And
       (fEmptyStr(strNomMas) Or SameText(strNomMas, Components[intIndice].Name)) Then
    Begin
      Result := (Components[intIndice] As TfrxMasterData);
      Break;
    End;
End;

Function TGeraFR3.fSaveReport(qryTabela: TUniQuery): Boolean;
  Var
    mmsReport: TMemoryStream;
Begin
  If Not (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
  Begin
    Result := True;
    Exit;
  End;

  Try

    mmsReport := TMemoryStream.Create;
    FFrxReport.SaveToStream(mmsReport);

    If qryTabela.State In dsEditModes Then
      TBlobField(qryTabela.FieldByName('REL_RELFR3')).LoadFromStream(mmsReport);

    FreeAndNil(mmsReport);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TGeraFr3.fSaveReport');
    End;
  End;

End;

Procedure TGeraFR3.pIniciaScript;
Begin
  stlScriptImplementation.Clear;

  stlScriptInitialization.Clear;
End;

Procedure TGeraFR3.pFinalizaScript;
Begin
  FFrxReport.ScriptText.Clear;
  FFrxReport.ScriptText.Add(stlScriptImplementation.Text);

  FFrxReport.ScriptText.Add('');
  FFrxReport.ScriptText.Add('Begin');
  FFrxReport.ScriptText.Add(stlScriptInitialization.Text);
  FFrxReport.ScriptText.Add('End.');

//  FFrxReport.SaveToFile('C:\Users\LAERCIO.GRATON\Documents\Autpas\379.48\379.48.02.20_COMITADA\TESTE.FR3');
End;

Procedure TGeraFR3.pAjustaParamsComplmento;
  Var
    blnFiltered: Boolean;
Begin

  If blnEhComplemento And Assigned(objInterfaceGeraPrincipal) Then
  Begin
    blnFiltered := TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.Filtered;

    TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.Filtered := False;

    FParams.First;
    While (Not FParams.Eof) Do
    Begin

      If TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.Locate('PAR_NOMPAR', FParams.FieldByName('PAR_NOMPAR').AsString, []) Then
      Begin
        FParams.Edit;
        FParams.FieldByName('PARVIS').AsInteger := TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.FieldByName('PARVIS').AsInteger;
        FParams.FieldByName('PARIMP').AsInteger := TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.FieldByName('PARIMP').AsInteger;
        FParams.FieldByName('IMPFIL').AsInteger := TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.FieldByName('IMPFIL').AsInteger;
        FParams.Post;
      End;

      FParams.Next;
    End;

    TInterfaceRelatorio(objInterfaceGeraPrincipal).cdsParams.Filtered := blnFiltered;

  End;

End;

Function TGeraFR3.fGerarFr3(strCodRels: String; objConsulta: TConsultasRel; blnLeuDados: Boolean; intMaxCol: Integer; strNomCam: string = ''; blnApenasPrincipal: Boolean = False): Boolean;
Begin
  Try
    FMaxCol  := intMaxCol;

    Try
      If (TInterfaceRelatorio(fGetInterface).fMudaParaRetrato) Or (Not FJato) Then
        FOrientation := poPortrait
      Else
        FOrientation := FOrientationOriginal;

      If FCadRel[intRelatPos].FieldByName('REL_FR3PER').AsString = 'N' then
      Begin
        pAjustaParamsComplmento;

        FParams.Filter   := 'PAR_ORIPAR <> 1 AND PARVIS = 1 AND PARIMP = 1';
        FParams.Filtered := True;

        FLeuDados := blnLeuDados;

        If Not blnEhComplemento Then
          pIniciaScript;

        FComplementoCabec.Clear;

        FConsulta := objConsulta;

        FCodRels.Text := strCodRels;

        pSetCampos(TInterfaceRelatorio(objInterfaceGera).cdsCampos);

      If FCadRel[intRelatPos].FieldByName('REL_HORIZO').AsString <> 'I' Then
        FMaxCol := -1;

      If (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) And (Not FCarregouPagina) Then
      Begin
        Result := False;
        Exit;
        End;

        pCarregaQuebras;

        If Not (desDestinoFr3 In [desTxt]) Then
        Begin
          Result  := fCarregaModelo And
                     fCriaPagina And
                     fCriaPageHeader(strNomCam) And
                     fCriaChildPageHeader(strNomCam) And
                     fCriaChildComplementoCabec(strNomCam) And
                     fCriaHeader(strNomCam) And
                     fCriaGroupHeaders(strNomCam) And
                     fCriaMasterData(strNomCam) And
                     fCriaGroupFooters(strNomCam, blnApenasPrincipal) And
                     fCriaFooter(strNomCam) And
                   fCriaPageFooter(strNomCam) And
                   fAdicionaComplementos(blnApenasPrincipal);

        If  (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) And (Not blnEhComplemento) Then
          pFinalizaScript;
      End

        Else Result := True;

        If Assigned(frxPage) Then
          frxPage.Tag := Ord(frxPage.Orientation);


      End
      Else If FCadRel[intRelatPos].FieldByName('REL_FR3PER').AsString = 'S' then
      Begin
        Result := fLoadRelatorio;
      End
      Else Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TGeraFR3.fGerarFr3]');
        Result := False;
      End;
    End;

  Finally
    FParams.Filtered := False;
    FParams.Filter   := '';

    fSaveReport(FCadRel[intRelatPos]);
  End;

End;

function TGeraFR3.fLoadReportComp(qryTabela: TUniQuery; {frxReport: TFrxReport;} intRelat: Integer; Var objRel: Pointer; blnChild, blnLeuDados: Boolean; strNomCam: string): Boolean;
 Var
   blnPrecisaRefazer: Boolean;
   objRelat: TRelatorio;
Begin
  Result := False;

  // FLeuDados será usado no fCriaGroupFooters para criar um subrelatório ou não
  // pois no fCriaGroupFooters, eu chamo o fCriaChildDadosGroupFooter, que chama o fAlimentaSubreport,
  // que chama o fLoadReportComp, que chama o pRefazComplemento, que chama o fGerarFr3
  // Então o fLoadReportComp que é chamado dentro do fAlimentaSubreport, passa true
  FLeuDados := blnLeuDados;

  Try
    With qryTabela Do
    Begin

      If Not FieldByName('REL_RELFR3').IsNull Then
      Begin
        Result := True;

        Edit;

        TRelatorio.pRefazComplemento(TInterfaceRelatorio(objInterfaceGera).blnExecutandoPeloMenu,
                                     TInterfaceRelatorio(objInterfaceGera).blnConexaoIndependente,
                                     qryTabela, TInterfaceRelatorio(objInterfaceGera), intRelat, Self, blnPrecisaRefazer, FLeuDados, objRelat, False, strNomCam,
                                     TInterfaceRelatorio(objInterfaceGera).blnApenasPrincipal,
                                     strPatImgCab);

        If blnPrecisaRefazer And Assigned(TInterfaceRelatorio(objInterfaceGera)) Then
          TInterfaceRelatorio(objInterfaceGera).blnFr3Gerado := False;

        If Assigned(TInterfaceRelatorio(objInterfaceGera)) Then
          stlScriptImplementation.Add(TInterfaceRelatorio(objInterfaceGera).strScriptImplementation);

        Cancel;

        objRel := objRelat;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

End;

Function TGeraFR3.fAdicionaComplementos(blnApenasPrincipal: Boolean = False): Boolean;
  Var
    frxReportPage: TfrxReportPage;
    mmsLoadPage: TMemoryStream;
    frxPageComple: TfrxPage;
    intContador,
    intContComp,
    intIndice,
    intContChildComp: Integer;
    objRel: Pointer;
    objRelat: TRelatorio;
Begin
  Result := True;

  if blnApenasPrincipal then
    Exit;

  pLiberaComplementos;

  SetLength(FTitulosRelatorio, Length(FCadRel));
  SetLength(FSubTitulosRelatorio, Length(FCadRel));

  For intContComp := Succ(Low(FCadRel)) To High(FCadRel) Do
  Begin

    // abaixo eu garanto que só vai imprimir o que for complementar primário ou descendente (exceto quando for grid e child ao mesmo tempo)
    If (desDestinoFr3 In [desGrid]) And (intRelatPos = (intContComp - 1)) And (FControleRel[intContComp].blnChild) Then
      intContador := intContComp
    Else
      intContador := fBuscaControleRel(intRelatPos, FCadRel[intContComp].FieldByName('REL_CODREL').AsString, '', False);

    If intContador > 0 Then
    Begin
      With FCadRel[intContador] Do
      If fLoadReportComp(FCadRel[intContador], intContador, objRel, False, True, '') Then
      Begin
        objRelat := objRel;

        If (desDestinoFr3 In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
        Begin

          If FJato Then
            frxReportPage := TfrxReportPage.Create(frxReport)
          Else
            frxReportPage := TfrxDMPPage.Create(frxReport);

          frxReportPage.PrintIfEmpty := False;

          frxReportPage.Name := fPageName(intContador);

          If Assigned(objInterfaceGera) And
             TInterfaceRelatorio(objInterfaceGera).cdsComplementos.Locate('REL_CODREL', FCadRel[intContador].FieldByName('REL_CODREL').AsString, []) And
             ((Not FLeuDados) Or (Not TInterfaceRelatorio(objInterfaceGera).fGetDataSet(intContador).IsEmpty)) Then
            frxReportPage.PrintOnPreviousPage := TInterfaceRelatorio(objInterfaceGera).cdsComplementos.FieldByName('REL_NOVPAG').AsString <> 'S'
          Else
            frxReportPage.PrintOnPreviousPage := True;

          // criação das páginas que foram relacionadas nos subrelatórios dos childs criados nesse relatório complementar
          intContChildComp := 0;
          for intIndice := 0 to objRelat.objGeraFr3.frxReport.ComponentCount - 1 do
          begin
            if (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxReportPage) or (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxDMPPage) then
            begin
              // if para criar páginas para os childs criados nesse relatório complementar
              if intContChildComp > 0 then
              begin
                if FJato then
                  TfrxReportPage.Create(frxReport)
                else
                  TfrxDMPPage.Create(frxReport);

                frxReport.Pages[frxReport.PagesCount-1].Name := objRelat.objGeraFr3.frxReport.Components[intIndice].Name;
              end;
              Inc(intContChildComp);
            end;
          end;

          // alimentação das páginas criadas pelo rotina de relatório complementar
          intContChildComp := 0;
          for intIndice := objRelat.objGeraFr3.frxReport.ComponentCount - 1 downto 0 do
          begin

            if (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxReportPage) or (objRelat.objGeraFr3.frxReport.Components[intIndice] is TfrxDMPPage) then
            begin

              frxPageComple := (objRelat.objGeraFr3.frxReport.Components[intIndice] As TfrxReportPage);
              mmsLoadPage := TMemoryStream.Create;
              frxPageComple.SaveToStream(mmsLoadPage);
              mmsLoadPage.Position := 0;
              frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].LoadFromStream(mmsLoadPage);

              If SameText(FCadRel[intContador].FieldByName('REL_ORIENT').AsString, 'R') Then
                frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].Tag := 0
              Else
                frxReport.Pages[frxReport.PagesCount-(1+intContChildComp)].Tag := 1;

              FreeAndNil(mmsLoadPage);

              Inc(intContChildComp);
            end
          end;

        End;

        SetLength(arrSalvaComplementos, Succ(Length(arrSalvaComplementos)));
        arrSalvaComplementos[High(arrSalvaComplementos)] := objRelat;
        FControleRel[intContador].intExcel := Length(arrSalvaComplementos);

        If (Assigned(frmProgresso)) and (not VS_AutcomIniciadoModoRobo) Then
        Begin
          frmProgresso.pgbStatus.Position := frmProgresso.pgbStatus.Position + 1;
          Application.ProcessMessages;
        End;
      End;
    End;
  End; {For intContador := Succ(Low(FCadRel)) To High(FCadRel) Do}

End;

Function TGeraFR3.fTrataAcento(strInfo: String): String;
Begin
  If FTipImp = 'J' Then
    Result := strInfo
  Else
    Result := fRemoveAcento(strInfo);
End;

Function TGeraFR3.fNomeEmpresa: String;
Begin
  If fCfgSis('EMPREL', varInteger) = 2 Then
    Result := fRetFantasiaEmpresa
  Else
    Result := fRetNomeEmpresa;
End;

Procedure TGeraFR3.pMontaCabecalhosGrid(Var arrCabec: TArrCabecalhoGrid);
  Var
    intQuerie,
    intContador: Integer;
Begin
  SetLength(arrCabec, 1);
  arrCabec[0].strCabecalho := fNomeEmpresa;
  arrCabec[0].taAlinhamento := taCenter;
  arrCabec[0].caTipo := caEmpresa;

  For intQuerie := Low(FFiltros) To HiGh(FFiltros) Do
  Begin

    With FFiltros[intQuerie] Do
    For intContador := 0 To FListaParFiltros.Count -1 Do
    Begin
      SetLength(arrCabec, Succ(Length(arrCabec)));
      arrCabec[High(arrCabec)].strCabecalho := FTituloFiltros[intContador];
      arrCabec[High(arrCabec)].taAlinhamento := taLeftJustify;
      arrCabec[High(arrCabec)].caTipo := caFiltro;
    End;

  End;

End;

Function TGeraFR3.fGetNomeEmpresaBasico: String;

  function fRetNomEmpFiltro(strNomPar, strDesPar, strDesTod, strRetEmp: string): string;
  var
    intCont: Integer;
    strDesEmp: string;
  begin
    Result := strRetEmp;

    for intCont := 0 To FListaParFiltros.Count -1 do
    begin
      if FListaParFiltros[intCont] = strNomPar then
      begin
        strDesEmp := AnsiReplaceStr(FTituloFiltros[intCont], strDesPar + ' : ', '');
        if UpperCase(strDesEmp) <> UpperCase(strDesTod) then
          Result := Copy(strDesEmp, 5, Length(strDesEmp));
        Break;
      end;
    end;
  end;

Begin
  Result := fNomeEmpresa;

  if FParams.Locate('PAR_DEFEMP', 'S', []) then
    Result := fRetNomEmpFiltro(FParams.FieldByName('PAR_NOMPAR').AsString,
                               FParams.FieldByName('PAR_DESPAR').AsString,
                               FParams.FieldByName('PAR_DESTOD').AsString, Result);
End;

Function TGeraFR3.fGetNomeEmpresa: String;
Begin
  if Assigned(FFiltros) then
    if Pos('@TITULO_EMPRESA', FFiltros[intRelatPos].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_EMPRESA_' + IntToStr(intRelatPos), False)),
                     fTrataAcento(fGetNomeEmpresaBasico), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_EMPRESA_' + IntToStr(intRelatPos), False))
    else
      Result := fTrataAcento(fGetNomeEmpresaBasico);
End;

Function TGeraFR3.fGetNomeEmpresaRels(intQuerie: Integer): String;
Begin
  if Assigned(FFiltros) then
    if Pos('@TITULO_EMPRESA', FFiltros[intQuerie].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_EMPRESA_' + IntToStr(intQuerie), False)),
                   fTrataAcento(fGetNomeEmpresaBasico), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_EMPRESA_' + IntToStr(intQuerie), False))
    else
      Result := fTrataAcento(fGetNomeEmpresaBasico);
End;

Function TGeraFR3.fGetTituloRelatorio: String;
Begin
  if Assigned(FFiltros) then
    if Pos('@TITULO_RELATORIO', FFiltros[intRelatPos].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_RELATORIO_' + IntToStr(intRelatPos), False)),
                     fTrataAcento(FTituloRelatorio), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_RELATORIO_' + IntToStr(intRelatPos), False))
    else
      Result := fTrataAcento(FTituloRelatorio);
End;

Function TGeraFR3.fGetTituloRelatorios(intQuerie: Integer): String;
Begin
  if Assigned(FFiltros) then
    if Pos('@TITULO_RELATORIO', FFiltros[intQuerie].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_RELATORIO_' + IntToStr(intQuerie), False)),
                  fTrataAcento(FTitulosRelatorio[intQuerie]), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@TITULO_RELATORIO_' + IntToStr(intQuerie), False))
    else
      Result := fTrataAcento(FTitulosRelatorio[intQuerie]);
End;

Function TGeraFR3.fGetSubTituloRelatorio: String;
Begin
  if Assigned(FFiltros) then
    if Pos('@SUBTITULO_RELATORIO', FFiltros[intRelatPos].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False)),
                     fTrataAcento(FSubTituloRelatorio), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intRelatPos), False))
    else
      Result := fTrataAcento(FSubTituloRelatorio);
End;

Function TGeraFR3.fGetSubTituloRelatorios(intQuerie: Integer): String;
Begin
  if Assigned(FFiltros) then
    if Pos('@SUBTITULO_RELATORIO', FFiltros[intQuerie].SQL.Text) > 0 then
      Result := IIF(fEmptyStr(TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intQuerie), False)),
                  fTrataAcento(FSubTitulosRelatorio[intQuerie]), TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@SUBTITULO_RELATORIO_' + IntToStr(intQuerie), False))
    else
      Result := fTrataAcento(FSubTitulosRelatorio[intQuerie]);
End;

Function TGeraFR3.fGetPathImagemCabecalho: String;
Begin
  if Assigned(FFiltros) then
    if Pos('@PATH_IMAGEM_CABECALHO', FFiltros[intRelatPos].SQL.Text) > 0 then
      Result := TInterfaceRelatorio(objInterfaceGera).fRetornaValorVariavel('@PATH_IMAGEM_CABECALHO_' + IntToStr(intRelatPos), False)
    else
      Result := '';
End;

Function TGeraFR3.fSetaVariaveis: Boolean;
  Var
    intQuerie,
    intColunas,
    intContador: Integer;
    mmoFiltro: TfrxCustomMemoView;

    qryDados: TUniQuery;
Begin
  pCarregaTitulosRelatorio;
  pCarregaSubTitulosRelatorio;

  FfrxReport.Script.Variables['NOME_EMPRESA' + IntToStr(intRelatPos)] := fGetNomeEmpresa;

  FfrxReport.Script.Variables['NOME_RELATORIO' + IntToStr(intRelatPos)] := fGetTituloRelatorio;

  FfrxReport.Script.Variables['SUBNOME_RELATORIO' + IntToStr(intRelatPos)] := fGetSubTituloRelatorio;

  If Assigned(objInterfaceGera) And SameText(FCadRel[0].FieldByName('REL_PAGINI').AsString, 'S') And (SameText(FCadRel[intRelatPos].FieldByName('REL_PGRCPE').AsString, 'N')) Then
    FfrxReport.Script.Variables[STR_PAGINA_INICIAL] := TInterfaceRelatorio(objInterfaceGera).fPaginaInicial;

  For intQuerie := Low(FFiltros) To HiGh(FFiltros) Do
  Begin
    If (intQuerie > 0) Then
    Begin
      FfrxReport.Script.Variables['NOME_EMPRESA' + IntToStr(intQuerie)] := fGetNomeEmpresaRels(intQuerie);

      FfrxReport.Script.Variables['NOME_RELATORIO' + IntToStr(intQuerie)] := fGetTituloRelatorios(intQuerie);

      FfrxReport.Script.Variables['SUBNOME_RELATORIO' + IntToStr(intQuerie)] := fGetSubTituloRelatorios(intQuerie);
    End;

    With FFiltros[intQuerie] Do
    For intContador := 0 To FListaParFiltros.Count -1 Do
    Begin

      If FTipImp = 'J' Then
      Begin

        FfrxReport.Script.Variables['TITULO_' + FListaParFiltros[intContador]] := fTrataAcento(FTituloFiltros[intContador]);

      End Else
      Begin

        mmoFiltro := TfrxCustomMemoView(FfrxReport.FindObject('mmoFiltro' + intToStr(Succ(intContador))));

        If Assigned(mmoFiltro) Then
        Begin
          intColunas := Trunc(fPixelToCmColuna(mmoFiltro.Width, False, FTipImp));
          FfrxReport.Script.Variables['TITULO_' + FListaParFiltros[intContador]] := LeftStr(fTrataAcento(FTituloFiltros[intContador]), intColunas);
        End Else
          FfrxReport.Script.Variables['TITULO_' + FListaParFiltros[intContador]] := fTrataAcento(FTituloFiltros[intContador]);

      End;

      If FDadosOrig[intQuerie] Is TUniQuery Then
        qryDados := TUniQuery(FDadosOrig[intQuerie])
      Else
        qryDados := TZClient(FDadosOrig[intQuerie]).qryQuery;

      If qryDados.FindParam(FListaParFiltros[intContador]) <> Nil Then
        FfrxReport.Script.Variables[FListaParFiltros[intContador]] := qryDados.Params.ParamByName(FListaParFiltros[intContador]).Value;

    End;
  End;

  If (fGetInterface <> Nil) And
     TInterfaceRelatorio(fGetInterface).blnImpressaoGrid And
     (Not fEmptyStr(TInterfaceRelatorio(fGetInterface).strFiltroGrid)) Then
    FfrxReport.Script.Variables['FILTRO_GRID'] := 'Filtro Adicional: ' + fTrataAcento(TInterfaceRelatorio(fGetInterface).strFiltroGrid);

  pSetaVariaveisFR3Personalizado;

  pSetaComplementos;

  pSetaLimits;

  Result := True;
End;

Procedure TGeraFR3.pSetaVariaveisFR3Personalizado;
var
  strCategoria: String;
  strRodape: String;
begin
  If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
    Exit;

  strCategoria := 'Editor Relatorios';

  FfrxReport.Variables[' ' + strCategoria] := Null;

  FfrxReport.Variables.AddVariable(strCategoria, 'RELATORIO_CODIGO', QuotedStr(FCadRel[0].FieldByName('REL_CODREL').AsString));

  If ((FCadRel[0].FieldByName('REL_MD5NEW').AsString) <> (FCadRel[0].FieldByName('REL_MD5OLD').AsString)) Then
    strRodape := fTrataAcento('REL: ' + FCadRel[0].FieldByName('REL_CODREL').AsString + ' *. ESTE RELATÓRIO FOI MODIFICADO, SENDO ESPECÍFICO PARA ESTE CLIENTE.')
  Else
    strRodape := 'REL: ' + FCadRel[0].FieldByName('REL_CODREL').AsString + '.';

  FfrxReport.Variables.AddVariable(strCategoria, 'RELATORIO_RODAPE', QuotedStr(strRodape));

  FfrxReport.Variables.AddVariable(strCategoria, 'EMPRESA_LOGADA', QuotedStr(VS_strCodEmp));
end;

Function TGeraFR3.fGetComplemento(strNomVar: String): String;
  Var
    qryComplemento: TUniQuery;
Begin
  qryComplemento := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  With qryComplemento, SQL Do
  Begin
    Add('SELECT ' + strNomVar);

    Open;

    Result := Fields[0].AsString;

  End;
  FreeAndNil(qryComplemento);
End;

Procedure TGeraFR3.pSetaComplementos;
  Var
    intContador: Integer;
Begin
  If FComplementoCabec.Count = 0 Then
    pCarregaComplementos;

  For intContador := 0 To FComplementoCabec.Count - 1 Do
    FfrxReport.Script.Variables['COMPLEMENTO_' + FComplementoCabec[intContador]] := fTrataAcento(fGetComplemento('@' + FComplementoCabec[intContador]));
End;

Procedure TGeraFR3.pSetaLimits;
  Var
    intContador: Integer;
    blnAchou: Boolean;
Begin
  If Assigned(objInterfaceGera) And Assigned(TInterfaceRelatorio(objInterfaceGera).stlLimits) Then
  With TInterfaceRelatorio(objInterfaceGera) Do
  For intContador := 0 To stlLimits.Count - 1 Do
    If FParams.Locate('PAR_NOMPAR', stlLimits[intContador], []) Then
      FfrxReport.Script.Variables['TITULO_' + stlLimits[intContador]] :=
        fTrataAcento(FParams.FieldByName('PAR_DESPAR').AsString + ': ' + fPegaValorParametro(stlLimits[intContador], blnAchou));
End;

Function TGeraFR3.fMudouDataSet: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := Low(FDados) To High(FDados) Do
  If (Not Assigned(FFrxDataSet[intContador])) Or
     (Not SameText(FFrxDataSet[intContador].UserName, fDataSetName(intContador))) Then
  Begin
    Result := True;
    Exit;
  End;
End;

function TGeraFR3.fExportaArquivoTXT(strPasta: String; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): String;
  Var
    objGeraTXT: TGeraTXT;
Begin
  Result := '';

  Try
    If (Not strPasta.IsEmpty) And (Not fCriaDiretorio(strPasta)) Then
      Exit;

    objGeraTXT := TGeraTXT.Create(Nil);
    objGeraTXT.objGeraGR3 := Self;

    If Assigned(FCadRel) And (Length(FCadrel) > 0) Then
    Begin
      If (Not strPasta.IsEmpty) And (Not strPasta.EndsWith('\')) Then
        strPasta := Concat(strPasta, '\');

      If objGeraTXT.fGeraTXT(strPasta, FCadRel[0].FieldByName('REL_CSVCAQ').AsString = 'S',
                                       FCadRel[0].FieldByName('REL_CSVCAR').AsString = 'S',
                                       blnApenasPrincipal,
                                       False,
                                       fEnviaPontosImpressao) Then
      Begin
        pGravaLogPaf('S', 'Arquivo gerado com sucesso!');

        If (FCadRel[0].FieldByName('REL_TXTBKP').AsString = 'S') Then
        Begin
          objGeraTXT.fGeraTXT(strPasta, FCadRel[0].FieldByName('REL_CSVCAQ').AsString = 'S',
                                        FCadRel[0].FieldByName('REL_CSVCAR').AsString = 'S',
                                        blnApenasPrincipal,
                                        True);
        End;

        If blnExibirMensagem Then
          pMensagemOk('Arquivo gerado' + IIF(fEnviaPontosImpressao, ' e enviado ao Ponto de Impressão ', ' ') + 'com sucesso!');

        Result := FSavArq.FileName;
      End;
    End
    Else
    begin
      pGravaLogPaf('N', 'Erro interno - Relatório não carregado!');
      pMensagemOk('Erro interno - Relatório não carregado!');
    End;

    FreeAndNil(objGeraTXT);

  Except
    On E: Exception Do
    Begin
      pGravaLogPaf('N', 'Não foi possível gerar o arquivo TXT desejado.');
      pMensagemOk('Não foi possível gerar o arquivo TXT desejado.');
    End;
  End;

end;

function TGeraFR3.fExportaArquivoXML(strPasta: String; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): String;
  Var
    objGeraXML: TGeraXML;
Begin
  Result := '';

  Try

    If (Not strPasta.IsEmpty) And (Not fCriaDiretorio(strPasta)) Then
      Exit;

    objGeraXML := TGeraXML.Create(Nil);
    objGeraXML.objGeraGR3 := Self;

    If Assigned(FCadRel) And (Length(FCadrel) > 0) Then
    Begin
      If (Not strPasta.IsEmpty) And (Not strPasta.EndsWith('\')) Then
        strPasta := Concat(strPasta, '\');

      If objGeraXML.fGeraXML(strPasta, blnApenasPrincipal) Then
      Begin
        If blnExibirMensagem Then
          pMensagemOk('Arquivo gerado com sucesso!');
        Result := FSavArq.FileName;
      End;

    End Else
    begin
      pMensagemOk('Erro interno - Relatório não carregado!');
    End;

    FreeAndNil(objGeraXML);

  Except
    On E: Exception Do
    Begin
      pMensagemOk('Não foi possível gerar o arquivo XML desejado.');
    End;
  End;

end;

function TGeraFR3.fExportaArquivoSaida(strPasta: String; blnExibirMensagem: Boolean = True): String;
  Var
    objGeraArquivoSaida: TGeraArquivoSaida;
    strMsg: String;
Begin
  Result := '';

  Try
    If strPasta.IsEmpty Then
      If Not SelectDirectory('', '', strPasta, [sdNewUI, sdShowEdit], nil) Then
        Exit;

    If (Not strPasta.IsEmpty) And (Not fCriaDiretorio(strPasta)) Then
      Exit;

    objGeraArquivoSaida := TGeraArquivoSaida.Create(Nil);
    Try
      objGeraArquivoSaida.objGeraGR3 := Self;

      If Assigned(FCadRel) And (Length(FCadRel) > 0) Then
      Begin
        If objGeraArquivoSaida.fGeraArquivos(strPasta) Then
        Begin
          If objGeraArquivoSaida.intFalhas > 0 Then
            pGravaLogPaf('N', IntToStr(objGeraArquivoSaida.intFalhas) + ' arquivo(s) com falha na geração.')
          Else
            pGravaLogPaf('S', 'Arquivo gerado com sucesso!');

          If blnExibirMensagem And
             ((objGeraArquivoSaida.intGerados > 0) Or (objGeraArquivoSaida.intFalhas > 0)) Then
          Begin
            strMsg := IntToStr(objGeraArquivoSaida.intGerados) + ' arquivo(s) gerado(s) com sucesso!';

            If objGeraArquivoSaida.intPulados > 0 Then
              strMsg := strMsg + #13#10 + IntToStr(objGeraArquivoSaida.intPulados) + ' registro(s) ignorado(s) por nome vazio.';

            If objGeraArquivoSaida.intFalhas > 0 Then
              strMsg := strMsg + #13#10#13#10 + IntToStr(objGeraArquivoSaida.intFalhas) + ' arquivo(s) com falha:' + #13#10 + objGeraArquivoSaida.fResumoErros;

            pMensagemOk(strMsg);
          End;

          Result := strPasta;
        End;
      End
      Else
      Begin
        pGravaLogPaf('N', 'Erro interno - Relatório não carregado!');
        pMensagemOk('Erro interno - Relatório não carregado!');
      End;
    Finally
      FreeAndNil(objGeraArquivoSaida);
    End;
  Except
    On E: Exception Do
    Begin
      pGravaLogPaf('N', 'Não foi possível gerar os arquivos: ' + E.Message);
      pMensagensErro(E.Message, 'TGeraFR3.fExportaArquivoSaida');
    End;
  End;
End;

Function TGeraFR3.fTemDestinoGrafico: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  If desDestinoFr3 In SET_GRAFICO Then
  Begin
    Result := True;
    Exit;
  End;

  For intContador := Low(arrCadRel) To High(arrCadRel) Do
    If Assigned(arrCadRel[intContador]) And arrCadRel[intContador].Active And
       (TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intContador].FieldByName('REL_DESTIN').AsString) In SET_GRAFICO) Then
    Begin
      Result := True;
      Exit;
    End;
End;

Function TGeraFR3.fTemDestinoGraficoDashboard: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  If desDestinoFr3 In SET_GRAFICO_DASH Then
  Begin
    Result := True;
    Exit;
  End;

  For intContador := Low(arrCadRel) To High(arrCadRel) Do
    If Assigned(arrCadRel[intContador]) And
       arrCadRel[intContador].Active And
       (TInterfaceRelatorio.fDestinoToTipo(arrCadRel[intContador].FieldByName('REL_DESTIN').AsString) In SET_GRAFICO_DASH) Then
    Begin
      Result := True;
      Exit;
    End;
End;

Function TGeraFR3.fGetNomeRelatorio(qryCadRel: TUniQuery): String;
  Var
    qryNome: TUniQuery;
Begin
  qryNome := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  qryNome.SQL.Text := CONCAT('SELECT @NOME_RELATORIO', qryCadRel.FieldByName('REL_CODREL').AsString, ' AS NOMREL');
  qryNome.Open;

  If fEmptyStr(qryNome.FieldByName('NOMREL').AsString) Then
    Result := qryCadRel.FieldByName('REL_DESCRI').AsString
  Else
    Result := qryNome.FieldByName('NOMREL').AsString;

  FreeAndNil(qryNome);
End;

Function TGeraFR3.fGetSubNomeRelatorio(qryCadRel: TUniQuery): String;
  Var
    qryNome: TUniQuery;
Begin
  qryNome := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  qryNome.SQL.Text := CONCAT('SELECT @SUBNOME_RELATORIO', qryCadRel.FieldByName('REL_CODREL').AsString, ' AS SUBNOMREL');
  qryNome.Open;

  If fEmptyStr(qryNome.FieldByName('SUBNOMREL').AsString) Then
    Result := qryCadRel.FieldByName('REL_SUBTIT').AsString
  Else
    Result := qryNome.FieldByName('SUBNOMREL').AsString;

  FreeAndNil(qryNome);
End;

Function TGeraFR3.fGetPathSaidaSQL: String;
  Var
    qryPath: TUniQuery;
Begin
  qryPath := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  qryPath.SQL.Text := CONCAT('SELECT @PATH_SAIDA_PDF AS PASSAI');
  qryPath.Open;

  Result := qryPath.FieldByName('PASSAI').AsString;

  FreeAndNil(qryPath);
End;

Function TGeraFR3.fGetArqSaidaPDF: String;
  Var
    qryPath: TUniQuery;
Begin
  qryPath := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  qryPath.SQL.Text := CONCAT('SELECT @ARQ_SAIDA_PDF AS ARQSAI ');
  qryPath.Open;

  Result := qryPath.FieldByName('ARQSAI').AsString;

  FreeAndNil(qryPath);
End;

Function TGeraFR3.fGetVariavelBanco(strVariavel: String): String;
  Var
    qryVar: TUniQuery;
Begin
  if not strVariavel.StartsWith('@') then
    strVariavel := '@' + strVariavel;

  qryVar := fCriaQuery(Nil, TInterfaceRelatorio(objInterfaceGera).conConexaoRelatorio.objConexao);
  qryVar.SQL.Text := CONCAT('SELECT IFNULL(' + strVariavel + ', "") AS RETORNO ');
  qryVar.Open;

  Result := qryVar.FieldByName('RETORNO').AsString;

  FreeAndNil(qryVar);
End;

Function TGeraFR3.fConfirmaExecucao: Boolean;
  Var
    frmMensagemValidacao: TfrmMensagemValidacao;
    intPosIni,
    intLength: Integer;
Begin
  Result := Not FDados[0].Locate('TIPO', 'E', []);

  pCriarFormularios(TfrmMensagemValidacao, frmMensagemValidacao);

  FDados[0].First;

  While Not FDados[0].Eof Do
  Begin
    frmMensagemValidacao.mmoMensagem.Lines.Add('');

    intPosIni := frmMensagemValidacao.mmoMensagem.SelStart;

    frmMensagemValidacao.mmoMensagem.Lines.Add('  ' + FDados[0].FieldByName('RETORNO').AsString);

    intLength := frmMensagemValidacao.mmoMensagem.SelStart - intPosIni + 1;
    frmMensagemValidacao.mmoMensagem.SelStart  := intPosIni;
    frmMensagemValidacao.mmoMensagem.SelLength := intLength;

    If FDados[0].FieldByName('TIPO').AsString = 'E' Then
      frmMensagemValidacao.mmoMensagem.SelAttributes.Color := clRed
    Else
      frmMensagemValidacao.mmoMensagem.SelAttributes.Color := clBlue;

    FDados[0].Next;
  End;

  frmMensagemValidacao.ClientHeight := frmMensagemValidacao.pnlBotoes.Height + frmMensagemValidacao.pnlInfo.Height +
                                       (frmMensagemValidacao.mmoMensagem.Lines.Count + 1) * 16 + 3;

  If frmMensagemValidacao.Height > 650 Then
    frmMensagemValidacao.Height := 650;

  frmMensagemValidacao.btnContinuar.Visible := Result;

  If Result Then
  Begin
    Result := frmMensagemValidacao.ShowModal = mrOk
  End Else
  Begin
    frmMensagemValidacao.ShowModal;
  End;

  pFreeAndNil(frmMensagemValidacao);

  TInterfaceRelatorio(objInterfaceGera).blnExecutouSemErro := Result;
End;

Function TGeraFR3.fExecutaRelatorio(strIdent, strPasta: String; desDestino: TDestinoRel; blnApenasPrincipal: Boolean = False; blnExibirMensagem: Boolean = True): Boolean;
  Var
    strArquivo,
    strNomImp,
    strTipImp,
    strDesPro,
    strNomArq: String;
    objGeraCSV : TGeraCSV;
    intPagFinal,
    intPageRel,
    intOpcoes  : Integer;
    intContador: Integer;
    blnSetarOrientacao,
    blnUsarDialog,
    blnGerouArq,
    blnGerarVazio: Boolean;

    oriOrientationGeral: TPrinterOrientation;

    mmsReport: TMemoryStream;
    strDiretorioGat: String;

  function fExportaArquivoPDF: String;
    Var
      intContador: Integer;
      blnRotinaGatilhos: Boolean;
  Begin
    Result := '';

    blnRotinaGatilhos := (FCadRel[0].FieldByName('REL_PDFWPP').AsString = 'S')
                            or (FCadRel[0].FieldByName('REL_PDFEMA').AsString = 'S');

    if FCadRel[0].FieldByName('REL_PDFWPP').AsString = 'S' then
    begin

      if fRetFilaEnvioWhatsAppOperador(strLoginUsuarioLogado) = 0 then
      Begin
        fMensagem('ATENÇÃO!', 'Envio por Whatsapp ' + #10#13 +
                              'Usuário não possui uma Fila para Envio cadastrada. ' + #10#13 +
                              'Para habilitar o envio, abra o Cadastro de Operadores e na aba Whatsapp realize o vinculo com a Fila para Envio.',
                              ['&Ok']);

        blnEnviarGatWpp := False;
      End
      else
        blnEnviarGatWpp := fRetPerguntaEnviarGatilho('REL_PDFWPP', 'Gostaria de enviar relatório PDF por whatsapp para o cliente?');
    end;

    if FCadRel[0].FieldByName('REL_PDFEMA').AsString = 'S' then
    Begin
      if not fVerificaOperadorEmailEnvio(strLoginUsuarioLogado) then
      begin
        fMensagem('ATENÇÃO!', 'Envio por Email ' + #10#13 +
                              'Usuário não possui dados de Email cadastrado. ' + #10#13 +
                              'Para habilitar o envio, abra o Cadastro de Operadores e na aba Email preencha os dados.',
                              ['&Ok']);

        blnEnviarGatEma := False;
      end
      else
        blnEnviarGatEma := fRetPerguntaEnviarGatilho('REL_PDFEMA', 'Gostaria de enviar relatório PDF por email para o cliente?');

    end;

    strDiretorioGat := ExtractFilePath(Application.ExeName) +
                       '\RELATORIOS_PDF_GATILHO\' +
                       FCadRel[0].FieldByName('REL_CODREL').AsString + '\' +
                       FormatDateTime('dd.MM.yyyy HH.mm.ss', fNow) + '\';

    If (blnEnviarGatWpp) or (blnEnviarGatEma) Then
    Begin
      strPasta := strDiretorioGat;
    End;

    If (Not strPasta.IsEmpty) And (Not fCriaDiretorio(strPasta)) Then
      Exit;

    FSavArq.Filter     := 'Arquivos PDF|*.pdf';
    FSavArq.DefaultExt := 'pdf';
    FSavArq.Title      := 'Salvar';

    If (FlistaArquivos.Count > 0) And
       (Not fEmptyStr(FlistaArquivos[0])) Then
      strArquivo := FlistaArquivos[0]
    Else
      strArquivo := '';

    If Not StrPasta.IsEmpty Then
    Begin
      FSavArq.InitialDir := strPasta;

      If strArquivo.IsEmpty Then
        FSavArq.FileName := ExtractFileName(FSavArq.FileName)
      Else
        FSavArq.FileName := strArquivo;
    End;

    blnUsarDialog := False;

    If strPasta.IsEmpty Or strArquivo.IsEmpty Or (FListaPaginas.Count = 0) Then
    Begin
      If FArquivoSaidaDiretoPDF.IsEmpty Then
      Begin
        If Not FSavArq.Execute Then
          Exit;

        strArquivo    := FSavArq.FileName;
        strPasta      := ExtractFilePath(FSavArq.FileName);
        blnUsarDialog := True;
      End;
    End;

    If Not Assigned(FBase) Then
    Begin
      FBase := TdtmRelFrx.Create(Self);
      FBase.objGeraFr3 := Self;
    End;

    FBase.frxPDFExport.ShowDialog  := False;
    FBase.frxPDFExport.DefaultPath := ExtractFilePath(FSavArq.FileName);

    if (fCfgSis('EDTPDE', varString) = 'S') then
      FBase.frxPDFExport.EmbeddedFonts := True;

    If (FCadRel[intRelatPos].FieldByName('REL_FR3PER').AsString = 'S') or
        ((FCadRel[0].FieldByName('REL_SEMDAD').AsString = 'S') And (FlistaArquivos.Count = 0))
    Then
      FFrxReport.PrepareReport;

    If Not FArquivoSaidaDiretoPDF.IsEmpty Then
    Begin
      FFrxReport.ShowProgress := False;
      FBase.frxPDFExport.FileName := FArquivoSaidaDiretoPDF;

      FFrxReport.Export(FBase.frxPDFExport);
      Result := FArquivoSaidaDiretoPDF;
    End
    Else If (FListaPaginas.Count > 0) and (not strPasta.IsEmpty) Then
    Begin

      FListaPaginas.Add(IntToStr(Succ(FFrxReport.Engine.PreviewPages.Count)));

      For intContador := 0 To FListaPaginas.Count - 2 Do
      Begin
        FBase.frxPDFExport.PageNumbers := FListaPaginas[intContador] + '-' + IntToStr(StrToIntDef(FListaPaginas[Succ(intContador)], 0) - 1);

        if (not blnRotinaGatilhos) or ((not blnEnviarGatWpp) and (not blnEnviarGatEma)) then
        Begin
          If Not AnsiEndsStr('\', strPasta) Then
            strPasta := strPasta + '\';

          If FlistaArquivos[intContador].IsEmpty Then
          Begin
            If blnUsarDialog Then
              strArquivo := FSavArq.FileName
            Else
              strArquivo := strPasta + 'Rel' + IntToStr(intContador) + '.pdf';
          End Else
          Begin
            strArquivo := strPasta + FlistaArquivos[intContador] + '.pdf';;
          End;


          FBase.frxPDFExport.FileName := strArquivo;
          FFrxReport.Export(FBase.frxPDFExport);
        End;

        If (blnEnviarGatWpp) or (blnEnviarGatEma) Then
        Begin
          if (fValidaTelefone(FListaEnvioPDFGatilho[intContador].strNumWpp)) or
          ((not fEmptyStr(FListaEnvioPDFGatilho[intContador].strEmail)) and (Pos('@', FListaEnvioPDFGatilho[intContador].strEmail) > 0)) Then
          Begin
            If (Not fCriaDiretorio(strDiretorioGat)) Then
              continue;

            strArquivo := strDiretorioGat + FlistaArquivos[intContador] + '.pdf';

            FBase.frxPDFExport.FileName := strArquivo;
            FFrxReport.Export(FBase.frxPDFExport);

            if (not fValidaTelefone(FListaEnvioPDFGatilho[intContador].strNumWpp)) or (not blnEnviarGatWpp) then
              FListaEnvioPDFGatilho[intContador].strNumWpp := '';

            if (fEmptyStr(FListaEnvioPDFGatilho[intContador].strEmail)) or (Pos('@', FListaEnvioPDFGatilho[intContador].strEmail) = 0) Or
             (not blnEnviarGatEma) then
              FListaEnvioPDFGatilho[intContador].strEmail := '';

            pGravaGatilhoRelatorio(
              FListaEnvioPDFGatilho[intContador].strNumWpp,
              FListaEnvioPDFGatilho[intContador].strEmail,
              FListaEnvioPDFGatilho[intContador].strAssunto,
              FListaEnvioPDFGatilho[intContador].strCorpo,
              strArquivo,
              FListaEnvioPDFGatilho[intContador].strJSonWhatsApp);
          End;

        End;
      End;

      pMensagemOk('Arquivos gerados com sucesso!');

      Result := strArquivo;
    End Else
    Begin
      FBase.frxPDFExport.FileName := FSavArq.FileName;

      FFrxReport.Export(FBase.frxPDFExport);

      If (desDestino = desPDF) Then
        pExecArquivo(FSavArq.FileName, 0);

      Result := FSavArq.FileName;
    End;

  end;

  function fExportaArquivoCSV(strPasta: String): String;
  var
    blnNomeArquivo: Boolean;
    strNomArq: String;
  Begin
    Result := '';

    If (Not strPasta.IsEmpty) And (Not fCriaDiretorio(strPasta)) Then
      Exit;

    If (Not strPasta.EndsWith('\')) Then
      strPasta := Concat(strPasta, '\');

    blnNomeArquivo := False;
    If Assigned(TInterfaceRelatorio(objInterfaceGera).stlArquivos) Then
      If TInterfaceRelatorio(objInterfaceGera).stlArquivos.Count > 0 Then
        blnNomeArquivo := Not fEmptyStr(TInterfaceRelatorio(objInterfaceGera).stlArquivos[0]);

    strNomArq := '';
    If Not blnNomeArquivo Then
    Begin
      FSavArq.Filter     := 'Arquivos CSV|*.csv';
      FSavArq.DefaultExt := 'csv';
      FSavArq.Title      := 'Salvar';

      If Not StrPasta.IsEmpty Then
      Begin
        FSavArq.InitialDir := strPasta;
        FSavArq.FileName := ExtractFileName(FSavArq.FileName);
      End;

      If FSavArq.Execute Then
        strNomArq := FSavArq.FileName;
    End;

    If (blnNomeArquivo) Or (Not fEmptyStr(strNomArq)) Then
    Begin
      objGeraCSV := TGeraCSV.Create(Nil);
      objGeraCSV.objGeraGR3 := Self;

      If Assigned(FCadRel) And (Length(FCadrel) > 0) Then
      Begin

        If objGeraCSV.fGeraCSV(blnNomeArquivo,
                               strNomArq,
                               strPasta,
                               FCadRel[0].FieldByName('REL_CSVTIT').AsString = 'S',
                               FCadRel[0].FieldByName('REL_CSVCOL').AsString = 'S',
                               FCadRel[0].FieldByName('REL_CSVASP').AsString = 'S',
                               FCadRel[0].FieldByName('REL_CSVCAQ').AsString = 'S',
                               FCadRel[0].FieldByName('REL_CSVCAR').AsString = 'S',
                               FCadRel[0].FieldByName('REL_CSVDAS').AsString = 'S',
                               blnApenasPrincipal) Then
        Begin
          pMensagemOk('Arquivo gerado com sucesso!');
          Result := strNomArq;
        End;

      End Else
      begin
        pMensagemOk('Erro interno - Relatório não carregado!');
      End;

      FreeAndNil(objGeraCSV);
     End;
  end;

  procedure pEnviarEmail;
    Var
      arrArquivos, arrDestinatarios : TStringArray;
  begin
    pCriarArrayAnexosEDestinatarios(strNomArq,
                                    '', //strEmailDestinatario
                                    arrDestinatarios,
                                    arrArquivos);

    TEnvioEmail.EnviarEmail(Self,
                            strLoginUsuarioLogado,
                            '',
                            arrDestinatarios,
                            [],
                            [],
                            TEnvioEmail.ContruirArrayMensagem(''),
                            arrArquivos);
  end;

Begin
  Try
    desDestinoFr3 := desDestino;

    Result := True;

    FListaPaginas.Clear;
    FlistaArquivos.Clear;

    blnSetarOrientacao  := False;
    oriOrientationGeral := FOrientation;

    If (desDestino In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then
    Begin

      If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
      Begin

        If (Length(FFrxDataSet) <> Length(FDados)) Or
           (FfrxReport.DataSets.Count <> Length(FDados)) Or fMudouDataSet Then
        Begin
          If Assigned(FFrxDataSet) Then
            For intContador := Low(FFrxDataSet) To High(FFrxDataSet) Do
              If Assigned(FFrxDataSet[intContador]) Then
              Begin
                FreeAndNil(FFrxDataSet[intContador]);
                FFrxDataSet[intContador] := Nil;
              End;
          SetLength(FFrxDataSet, Length(FDados));

          FfrxReport.DataSets.Clear;

          blnGerarVazio := fRetGerarVideoVazio;

          intPageRel := 0;
          For intContador := Low(FDados) To IIF(blnApenasPrincipal, Low(FDados), High(FDados)) Do
          Begin
            FFrxDataSet[intContador]          := TFrxDBDataSet.Create(Self);
            FFrxDataSet[intContador].UserName := fDataSetName(intContador);

            frxReport.DataSets.Add(FFrxDataSet[intContador]);

            frxMasterData := fRetMasterData(FfrxReport, fMasterDataName(intContador, FControleRel[intContador].strNomCam));

            FFrxDataSet[intContador].DataSet := FDados[intContador];

            If Assigned(frxMasterData) Then
              frxMasterData.DataSet := FFrxDataSet[intContador];

            if not FControleRel[intContador].blnChild then
            Begin
              TfrxReportPage(frxReport.Pages[Succ(intPageRel)]).Visible :=
                 TfrxReportPage(frxReport.Pages[Succ(intPageRel)]).PrintOnPreviousPage Or
                 (Not FDados[intContador].IsEmpty) Or blnGerarVazio;

              If Assigned(objInterfaceGera) And
                 TInterfaceRelatorio(objInterfaceGera).blnImpressaoGrid And
                (TInterfaceRelatorio(objInterfaceGera).intIndexGrid <> intContador) Then
                TfrxReportPage(frxReport.Pages[Succ(intPageRel)]).Visible := False;
            End;

            // só não irá incrementar quando for um child que não virou página no Fast
            intPageRel := IIF(FControleRel[intContador].blnPrint, Succ(intPageRel), intPageRel);
          End;

          If blnGerarVazio then
          Begin
            SetLength(FFrxDataSet, Length(FFrxDataSet) + 1);

            intContador := Length(FFrxDataSet)-1;

            FFrxDataSet[intContador]          := TFrxDBDataSet.Create(Self);
            FFrxDataSet[intContador].UserName := 'frxDataSetVazio';

            frxReport.DataSets.Add(FFrxDataSet[intContador]);

            frxMasterData := fRetMasterData(FfrxReport, 'frxDataSetVazio');

            FFrxDataSet[intContador].DataSet := pCriaDataSetVazio;

            If Assigned(frxMasterData) Then
              frxMasterData.DataSet := FFrxDataSet[intContador];

          End;

        End;
      End
      Else If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') Then
      Begin

        If Assigned(FFrxDataSet) Then
          For intContador := Low(FFrxDataSet) To High(FFrxDataSet) Do
            If Assigned(FFrxDataSet[intContador]) Then
            Begin
              FreeAndNil(FFrxDataSet[intContador]);
              FFrxDataSet[intContador] := Nil;
            End;

        SetLength(FFrxDataSet, Length(FDadosPersonalizado));

        FfrxReport.DataSets.Clear;

        For intContador := Low(FDadosPersonalizado) To High(FDadosPersonalizado) Do
        Begin
          FFrxDataSet[intContador]          := TFrxDBDataSet.Create(Self);
          FFrxDataSet[intContador].UserName := TInterfaceRelatorio(objInterfaceGera).fRetornaTabelaDadosNome(intContador);

          FfrxReport.DataSets.Add(FFrxDataSet[intContador]);

          FFrxDataSet[intContador].DataSet := FDadosPersonalizado[intContador];
        End;
      End;

      If (not blnApenasPrincipal) and (Length(FDados) > 1) and (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
      Begin
        intPagFinal := frxReport.PagesCount -1;

        // SETA TODOS COM A ORIENTAÇÃO DO PRINCIPAL
        For intContador := 1 To frxReport.PagesCount -1 Do
          If (intContador = 1) Or TfrxReportPage(frxReport.Pages[intContador]).PrintOnPreviousPage Then
          Begin
            TfrxReportPage(frxReport.Pages[intContador]).Orientation := oriOrientationGeral
          End Else
          Begin
            intPagFinal := Pred(intContador);
            Break;
          End;

        intPageRel := 0;
        For intContador := Low(FDados) To High(FDados) Do
        Begin

          If (Not FDados[intContador].IsEmpty) And (Not FControleRel[intContador].blnChild) Then
          Begin
            blnSetarOrientacao := True;

            If (TfrxReportPage(frxReport.Pages[Succ(intPageRel)]).Tag = 0) Or (Not FJato) Or
               (TInterfaceRelatorio(fGetInterface).fMudaParaRetrato) Then
              oriOrientationGeral := poPortrait
            Else
              oriOrientationGeral := poLandscape;
          End;

          // só não irá incrementar quando for um child que não virou página no Fast
          intPageRel := IIF(FControleRel[intContador].blnPrint, Succ(intPageRel), intPageRel);
        End;

        If blnSetarOrientacao Then
        Begin

          For intContador := 1 To intPagFinal Do
            TfrxReportPage(frxReport.Pages[intContador]).Orientation := oriOrientationGeral;

        End;

      End;

      If Assigned(FBase) and (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
        FBase.arrConsulta := FDados;

      If Assigned(FBase) and (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') Then
        FBase.arrConsulta := FDadosPersonalizado;

      Result := fSetaVariaveis;

      // FFrxReport.SaveToFile('oi.fr3');

      If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') and
         (FCadRel[0].State In [dsInsert, dsEdit]) Then
      Begin
        FFrxReport.EngineOptions.SilentMode := True;
        FFrxReport.PrepareReport;
        FFrxReport.EngineOptions.SilentMode := False;
        Result := Result;
      End
      Else
        Result := Result And FFrxReport.PrepareReport

    End; {If (desDestino In [desVideo, desDesignReport, desImpressora, desPDF, desEmail]) Then}

    If strPasta.IsEmpty then
      strPasta := fGetPathSaidaSQL;

    If (FArquivoSaidaDiretoPDF.IsEmpty) and (not strPasta.IsEmpty) and (not fGetArqSaidaPDF.IsEmpty) Then
      FArquivoSaidaDiretoPDF := strPasta + '\' + fGetArqSaidaPDF;

    strDesPro := fGetNomeRelatorio(FCadRel[0]);

    If Not strDesPro.ToLower.Contains('relat') Then
      strDesPro := strDesPro + ' (Relatório)';

    Result := Result and fValidaPontosImpressao;

    If Result Then
    Begin
      If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') and
         (FCadRel[0].State In [dsInsert, dsEdit])  Then
      Begin
        if not Assigned(FFrxDesign) then
          FFrxDesign    := TfrxDesigner.Create(Self);

        FFrxReport.DesignReport;

        mmsReport := TMemoryStream.Create;
        FFrxReport.SaveToStream(mmsReport);

        TBlobField(FCadRel[0].FieldByName('REL_FR3FAS')).LoadFromStream(mmsReport);

        FreeAndNil(mmsReport);
        FreeAndNil(FFrxReport);
      End

      Else If fTemDestinoGrafico Then
        Result := fMontaGrafico

      Else If fTemDestinoGraficoDashboard Then
        Result := fMontaGraficoDashboard

      Else

      Case desDestino Of
        desVideo:      Begin
                         Try
                           FFrxReport.PreviewOptions.Buttons  := [pbPrint, pbZoom, pbFind, pbOutline, pbNavigator];
                           {* Utilizado no TestComplete apenas *}
                           {$IFDEF TESTABILIDADE_AUTCOM}
                             FFrxReport.PreviewOptions.Buttons := [pbPrint, pbZoom, pbFind, pbOutline, pbPageSetup, pbNavigator, pbExport, pbSave];
                           {$ENDIF}

                           FFrxReport.PreviewOptions.ZoomMode := zmDefault;
                           FFrxReport.PreviewOptions.Zoom     := IIF(FCadRel[0].FieldByName('REL_ZOOINI').AsInteger = 0, fCfgSis('ZOOINI', varInteger), FCadRel[0].FieldByName('REL_ZOOINI').AsInteger) / 100;

                           pPreviewReport(strIdent, strDesPro, FFrxReport);
                         Except
                             On E: Exception Do
                             Begin
                               pMensagemOk('Não foi possível realizar a visualização do relatório.');
                             End;
                         End;
                       End;

        desDesignReport: Begin
                         Try
                           FFrxReport.PreviewOptions.Buttons  := [pbPrint, pbZoom, pbFind, pbOutline, pbNavigator];
                           {* Utilizado no TestComplete apenas *}
                           {$IFDEF TESTABILIDADE_AUTCOM}
                             FFrxReport.PreviewOptions.Buttons := [pbPrint, pbZoom, pbFind, pbOutline, pbPageSetup, pbNavigator, pbExport, pbSave];
                           {$ENDIF}

                           FFrxReport.PreviewOptions.ZoomMode := zmDefault;
                           FFrxReport.PreviewOptions.Zoom     := IIF(FCadRel[0].FieldByName('REL_ZOOINI').AsInteger = 0, fCfgSis('ZOOINI', varInteger), FCadRel[0].FieldByName('REL_ZOOINI').AsInteger) / 100;

                           pDesignReport(strIdent, strDesPro, FFrxReport);
                         Except
                             On E: Exception Do
                             Begin
                               pMensagemOk('Não foi possível acessar o relatório em  modo design.');
                             End;
                         End;
                       End;

        desImpressora: Begin
                         Try
                           TCfgRel.pCarregaConfImprRel(strIdent, strNomImp, strTipImp, '', fCfgSis('CADIMP', varBoolean) Or TCfgRel.VS_SpoolImpressaoCitel);

                           FFrxReport.PrintOptions.ShowDialog := False;

                           If fEmptyStr(strNomImp) Then
                           Begin
                             TCfgRel.pFillPrinters;
                             FFrxReport.PrintOptions.ShowDialog := True;
                           End;

                           FFrxReport.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

                           If not fEmptyStr(strNomImp) Then
                             FFrxReport.PrepareReport;

                           pPrintReport(strIdent, strDesPro, strNomImp, FFrxReport);
                         Except
                             On E: Exception Do
                             Begin
                               pMensagemOk('Não foi possível realizar a impressão. Verifique a impressora: '+AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\',''));
                             End;
                         End;
                       End;

        desPDF:        Begin
                         Try
                           fExportaArquivoPDF();
                         Except
                             On E: Exception Do
                             Begin
                               pMensagemOk('Não foi possível gerar o arquivo PDF desejado.');
                             End;
                         End;
                       End;

        desCSV:        Begin
                         Try
                           fExportaArquivoCSV(strPasta);
                         Except
                             On E: Exception Do
                             Begin
                               pMensagemOk('Não foi possível gerar o arquivo CSV desejado.');
                             End;
                         End;
                       End;

        desTXT:        fExportaArquivoTXT(strPasta, blnApenasPrincipal, blnExibirMensagem);

        desXML:        fExportaArquivoXML(strPasta, blnApenasPrincipal, blnExibirMensagem);

        desArquivoSaida: fExportaArquivoSaida(strPasta, blnExibirMensagem);

        desExcel:      fMontaGrid(IIF(blnApenasPrincipal, 0, -1), mntExcel);

        desEmail:      Begin
                         //pergunta qual quer exporta: PDF ou CSV
                         intOpcoes := fMensagem('ANEXO E-MAIL','Deseja exportar em qual formato?', ['PDF', 'CSV'], 1,
                           False, 1, 0, False, 0, False, False, True);

                         //gera arquivo
                         If (intOpcoes = 1) Then
                           strNomArq := fExportaArquivoPDF()
                         Else If (intOpcoes = 2) Then
                           strNomArq := fExportaArquivoCSV(strPasta);

                         blnGerouArq := (Not fEmptyStr(strNomArq));

                         //chama tela do editor de email
                         If (Not blnGerouArq) Then
                           fMensagem('','Não foi possível exportar o arquivo. Operação cancelada!', ['&OK'])
                         Else
                           pEnviarEmail();
                       End;

        desGrid:   fMontaGrid(IIF(blnApenasPrincipal, 0, -1));

        desGraficoColunas,
        desGraficoLinha,
        desGraficoBarras,
        desGraficoTorta,
        desGraficoArea,
        desGraficoColunasEmpilhado,
        desGraficoBarrasEmpilhado,
        desGraficoAreaEmpilhado: Result := fMontaGrafico;

        desValidacao: Result := fConfirmaExecucao;
      End;

    End;

    pGravaLogExecucao('Gerado com Sucesso!');
  Except
    On E: Exception Do
    Begin
      Result := False;
      If Pos(E.Message, 'thumbcache.dll') <= 0 Then
        pMensagensErro(E.Message, '[TGeraFR3.fExecutaRelatorio]');
        pGravaLogPaf('N', E.Message);
        pGravaLogExecucao(E.Message);
    End;
  End;

  pLiberaComplementos;
End;

Procedure TGeraFR3.pLiberaComplementos;
  Var
    intContador: Integer;
Begin
  For intContador := Low(arrSalvaComplementos) To High(arrSalvaComplementos) Do
    FreeAndNil(TRelatorio(arrSalvaComplementos[intContador]));

  SetLength(arrSalvaComplementos, 0);
End;

procedure TGeraFR3.pOpenDialogShow(Sender: TObject);
begin
  SetDlgItemText(GetParent(dlgOpen.Handle), IDOK, PChar('&Salvar'));
end;

Function TGeraFR3.fMontaGrid(intIndiceRelatorio: Integer = -1;
                             mntMontagemGrid: TMontagemGrid = mntGrid): Boolean;
  Var
    objGridRel: TGridRelatorioGeral;
Begin
  Result := False;

  Try
    dlgOpen := Nil;

    objGridRel := TGridRelatorioGeral.Create(Nil);

    Try
      objGridRel.dtmModuloGrid := TdtmModuloGrid.Create(Self);

      objGridRel.mntMontagemGrid := mntMontagemGrid;
      objGridRel.objGeraFr3 := Self;
      objGridRel.intIndiceRelatorio := intIndiceRelatorio;

      If mntMontagemGrid In [mntExcel, mntExcelGrid] Then
      Begin
        dlgOpen        := TOpenDialog.Create(Self);
        dlgOpen.OnShow := pOpenDialogShow;
        dlgOpen.Filter := 'Arquivos do Excel|*.xls;*.xlsx';
        dlgOpen.Title  := 'Salvar';

        If dlgOpen.Execute Then
          objGridRel.strNomeArq := dlgOpen.FileName
        Else
          Exit;

        If mntMontagemGrid In [mntExcelGrid] Then
          pMontaCabecalhosGrid(objGridRel.arrCabec);
      End;

      Result := objGridRel.fShowGrid;

      If Result Then
        Case mntMontagemGrid Of
          mntGrid:      objGridRel.LfrmGridRelatResult.ShowModal;
          mntExcelGrid,
          mntExcel:     pMensagemOk('Arquivo gerado com sucesso!');

        End;

      FreeAndNil(objGridRel.LfrmGridRelatResult);

    Finally
      FreeAndNil(objGridRel);

      If Assigned(dlgOpen) Then
        FreeAndNil(dlgOpen);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFR3.fMontaGrid]');
    End;
  End;
End;

procedure TGeraFR3.pDataGroupGetValueDisplayTextMes(Sender: TObject;
        const AValue: Variant; var ADisplayText: string);
  Var
    strMes: String;
Begin
  strMes := LeftStr(ADisplayText, 2);

  If StrToIntDef(strMes, -1) In [1..12] Then
  Begin
    Delete(ADisplayText, 1, 2);
    ADisplayText := String(LeftStr(arrMes[StrToIntDef(strMes, -1)], 3)) + ADisplayText;
  End;

End;

Procedure TGeraFR3.pMontaSeries(cxvGrafico: TcxGridDBChartView; cdsCampos: TZClient; intRelatorio: Integer);
  Var
    serie: TcxGridDbChartSeries;
    grupo: TcxGridDBChartDataGroup;
Begin
  cxvGrafico.ClearSeries;

  If cdsCampos.Locate('CAM_TIPGRA', 2, []) Then
    cxvGrafico.Categories.DataBinding.FieldName := cdsCampos.FieldByName('CAM_NOMCAM').AsString;

  cdsCampos.IndexFieldNames := 'CAM_POSICA';
  cdsCampos.First;

  While Not cdsCampos.Eof Do
  Begin

    Case cdsCampos.FieldByName('CAM_TIPGRA').AsInteger Of
      1: Begin
           serie := cxvGrafico.CreateSeries;
           serie.DataBinding.FieldName := cdsCampos.FieldByName('CAM_NOMCAM').AsString;
           serie.DisplayText := cdsCampos.FieldByName('CAM_DESCAM').AsString;

           If (cdsCampos.FieldByName('CAM_VALCOR').AsInteger > 0) And
              (TInterfaceRelatorio.fDestinoToTipo(FCadRel[intRelatorio].FieldByName('REL_DESTIN').AsString) <> desGraficoTorta) Then
           Begin
             serie.Styles.Values := TcxStyle.Create(serie);
             serie.Styles.Values.Color := cdsCampos.FieldByName('CAM_VALCOR').AsInteger;
           End;

           If SameText(cdsCampos.FieldByName('CAM_TIPCAM').AsString, 'Número decimal') And Not SameText(cdsCampos.FieldByName('CAM_MASCAR').AsString, 'Máscara Contábil') Then
             serie.ValueCaptionFormat := ',0.' + fStrZero('0', cdsCampos.FieldByName('CAM_NRODEC').AsInteger);
          End;

      3: Begin
           grupo := cxvGrafico.CreateDataGroup;
           grupo.DataBinding.FieldName := cdsCampos.FieldByName('CAM_NOMCAM').AsString;
           grupo.DisplayText := cdsCampos.FieldByName('CAM_DESCAM').AsString;

           If cdsCampos.FieldByName('CAM_GRODIS').AsInteger = 1 Then
             grupo.OnGetValueDisplayText := pDataGroupGetValueDisplayTextMes;
         End;
    End;

    cdsCampos.Next;
  End;

End;

Procedure TGeraFR3.pMontaGraficoColunas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramColumn.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramColumn.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramColumn.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramColumn.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramColumn.Legend.Position := cppNone;
    2: cxvGrafico.DiagramColumn.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramColumn.Legend.Position := cppTop;
    4: cxvGrafico.DiagramColumn.Legend.Position := cppRight;
    5: cxvGrafico.DiagramColumn.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_VALCAP').AsInteger Of
    1:   cxvGrafico.DiagramColumn.Values.CaptionPosition := cdvcpInsideBase;
    2:   cxvGrafico.DiagramColumn.Values.CaptionPosition := cdvcpCenter;
    3:   cxvGrafico.DiagramColumn.Values.CaptionPosition := cdvcpInsideEnd;
    4:   cxvGrafico.DiagramColumn.Values.CaptionPosition := cdvcpOutsideEnd;
    Else cxvGrafico.DiagramColumn.Values.CaptionPosition := cdvcpNone;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramColumn.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramColumn.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramColumn.Styles.AxisTitle.TextColor := cxvGrafico.DiagramColumn.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramColumn.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramColumn.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramColumn.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramColumn.Styles.CategoryAxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramColumn.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramColumn.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramColumn.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramColumn.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramColumn.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramColumn.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;
End;

Procedure TGeraFR3.pMontaGraficoColunasEmpilhadas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramStackedColumn.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramStackedColumn.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramStackedColumn.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramStackedColumn.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramStackedColumn.Legend.Position := cppNone;
    2: cxvGrafico.DiagramStackedColumn.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramStackedColumn.Legend.Position := cppTop;
    4: cxvGrafico.DiagramStackedColumn.Legend.Position := cppRight;
    5: cxvGrafico.DiagramStackedColumn.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_VALCAP').AsInteger Of
    1:   cxvGrafico.DiagramStackedColumn.Values.CaptionPosition := cdvcpInsideBase;
    2:   cxvGrafico.DiagramStackedColumn.Values.CaptionPosition := cdvcpCenter;
    3:   cxvGrafico.DiagramStackedColumn.Values.CaptionPosition := cdvcpInsideEnd;
    4:   cxvGrafico.DiagramStackedColumn.Values.CaptionPosition := cdvcpOutsideEnd;
    Else cxvGrafico.DiagramStackedColumn.Values.CaptionPosition := cdvcpNone;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedColumn.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedColumn.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramStackedColumn.Styles.AxisTitle.TextColor := cxvGrafico.DiagramStackedColumn.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedColumn.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedColumn.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramStackedColumn.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramStackedColumn.Styles.CategoryAxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramStackedColumn.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedColumn.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramStackedColumn.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramStackedColumn.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramStackedColumn.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramStackedColumn.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;;
End;

Procedure TGeraFR3.pMontaGraficoBarras(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramBar.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramBar.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramBar.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramBar.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramBar.Legend.Position := cppNone;
    2: cxvGrafico.DiagramBar.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramBar.Legend.Position := cppTop;
    4: cxvGrafico.DiagramBar.Legend.Position := cppRight;
    5: cxvGrafico.DiagramBar.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_VALCAP').AsInteger Of
    1:   cxvGrafico.DiagramBar.Values.CaptionPosition := cdvcpInsideBase;
    2:   cxvGrafico.DiagramBar.Values.CaptionPosition := cdvcpCenter;
    3:   cxvGrafico.DiagramBar.Values.CaptionPosition := cdvcpInsideEnd;
    4:   cxvGrafico.DiagramBar.Values.CaptionPosition := cdvcpOutsideEnd;
    Else cxvGrafico.DiagramBar.Values.CaptionPosition := cdvcpNone;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramBar.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramBar.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramBar.Styles.AxisTitle.TextColor := cxvGrafico.DiagramBar.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramBar.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramBar.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramBar.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramBar.Styles.CategoryAxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramBar.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramBar.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramBar.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramBar.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramBar.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramBar.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;;
End;

Procedure TGeraFR3.pMontaGraficoBarrasEmpilhadas(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramStackedBar.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramStackedBar.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramStackedBar.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramStackedBar.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramStackedBar.Legend.Position := cppNone;
    2: cxvGrafico.DiagramStackedBar.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramStackedBar.Legend.Position := cppTop;
    4: cxvGrafico.DiagramStackedBar.Legend.Position := cppRight;
    5: cxvGrafico.DiagramStackedBar.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_VALCAP').AsInteger Of
    1:   cxvGrafico.DiagramStackedBar.Values.CaptionPosition := cdvcpInsideBase;
    2:   cxvGrafico.DiagramStackedBar.Values.CaptionPosition := cdvcpCenter;
    3:   cxvGrafico.DiagramStackedBar.Values.CaptionPosition := cdvcpInsideEnd;
    4:   cxvGrafico.DiagramStackedBar.Values.CaptionPosition := cdvcpOutsideEnd;
    Else cxvGrafico.DiagramStackedBar.Values.CaptionPosition := cdvcpNone;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedBar.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedBar.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramStackedBar.Styles.AxisTitle.TextColor := cxvGrafico.DiagramStackedBar.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedBar.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedBar.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramStackedBar.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramStackedBar.Styles.CategoryAxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramStackedBar.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedBar.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramStackedBar.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramStackedBar.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramStackedBar.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramStackedBar.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;;
End;

Procedure TGeraFR3.pMontaGraficoLinha(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramLine.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramLine.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramLine.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramLine.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramLine.Legend.Position := cppNone;
    2: cxvGrafico.DiagramLine.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramLine.Legend.Position := cppTop;
    4: cxvGrafico.DiagramLine.Legend.Position := cppRight;
    5: cxvGrafico.DiagramLine.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINCAP').AsInteger Of
    1:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpLeft;
    2:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpAbove;
    3:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpRight;
    4:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpBelow;
    5:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpCenter;
    6:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpAboveRight;
    7:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpBelowRight;
    8:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpAboveLeft;
    9:   cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpBelowLeft;
    Else cxvGrafico.DiagramLine.Values.CaptionPosition := ldvcpNone;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINSTY').AsInteger Of
    1:   cxvGrafico.DiagramLine.Values.LineStyle := clsNone;
    2:   cxvGrafico.DiagramLine.Values.LineStyle := clsDash;
    3:   cxvGrafico.DiagramLine.Values.LineStyle := clsDot;
    4:   cxvGrafico.DiagramLine.Values.LineStyle := clsDashDot;
    5:   cxvGrafico.DiagramLine.Values.LineStyle := clsDashDotDot;
    Else cxvGrafico.DiagramLine.Values.LineStyle := clsSolid;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger > 0 Then
    cxvGrafico.DiagramLine.Values.LineWidth := FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger;

  Case FCadRel[intRelatorio].FieldByName('REL_MARSTY').AsInteger Of
    1:   cxvGrafico.DiagramLine.Values.MarkerStyle := cmsCircle;
    2:   cxvGrafico.DiagramLine.Values.MarkerStyle := cmsDiamond;
    3:   cxvGrafico.DiagramLine.Values.MarkerStyle := cmsSquare;
    4:   cxvGrafico.DiagramLine.Values.MarkerStyle := cmsTriangle;
    Else cxvGrafico.DiagramLine.Values.MarkerStyle := cmsNone;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger > 0 Then
    cxvGrafico.DiagramLine.Values.MarkerSize := FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramLine.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramLine.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramLine.Styles.AxisTitle.TextColor := cxvGrafico.DiagramLine.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramLine.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramLine.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramLine.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramLine.Styles.CategoryAxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramLine.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramLine.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramLine.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramLine.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramLine.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramLine.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;;
End;

Procedure TGeraFR3.pMontaGraficoArea(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramArea.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramArea.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramArea.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramArea.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramArea.Legend.Position := cppNone;
    2: cxvGrafico.DiagramArea.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramArea.Legend.Position := cppTop;
    4: cxvGrafico.DiagramArea.Legend.Position := cppRight;
    5: cxvGrafico.DiagramArea.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINCAP').AsInteger Of
    1:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpLeft;
    2:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpAbove;
    3:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpRight;
    4:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpBelow;
    5:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpCenter;
    6:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpAboveRight;
    7:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpBelowRight;
    8:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpAboveLeft;
    9:   cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpBelowLeft;
    Else cxvGrafico.DiagramArea.Values.CaptionPosition := ldvcpNone;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINSTY').AsInteger Of
    1:   cxvGrafico.DiagramArea.Values.LineStyle := clsNone;
    2:   cxvGrafico.DiagramArea.Values.LineStyle := clsDash;
    3:   cxvGrafico.DiagramArea.Values.LineStyle := clsDot;
    4:   cxvGrafico.DiagramArea.Values.LineStyle := clsDashDot;
    5:   cxvGrafico.DiagramArea.Values.LineStyle := clsDashDotDot;
    Else cxvGrafico.DiagramArea.Values.LineStyle := clsSolid;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger > 0 Then
    cxvGrafico.DiagramArea.Values.LineWidth := FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger;

  Case FCadRel[intRelatorio].FieldByName('REL_MARSTY').AsInteger Of
    1:   cxvGrafico.DiagramArea.Values.MarkerStyle := cmsCircle;
    2:   cxvGrafico.DiagramArea.Values.MarkerStyle := cmsDiamond;
    3:   cxvGrafico.DiagramArea.Values.MarkerStyle := cmsSquare;
    4:   cxvGrafico.DiagramArea.Values.MarkerStyle := cmsTriangle;
    Else cxvGrafico.DiagramArea.Values.MarkerStyle := cmsNone;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger > 0 Then
    cxvGrafico.DiagramArea.Values.MarkerSize := FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramArea.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramArea.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramArea.Styles.AxisTitle.TextColor := cxvGrafico.DiagramArea.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramArea.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramArea.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramArea.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramArea.Styles.CategoryAxisTitle.Font.Color;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_TRAARE').AsInteger > 0 Then
    cxvGrafico.DiagramArea.Transparency := FCadRel[intRelatorio].FieldByName('REL_TRAARE').AsInteger;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramArea.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramArea.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramArea.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramArea.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramArea.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramArea.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;
End;

Procedure TGeraFR3.pMontaGraficoAreaEmpilhada(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  cxvGrafico.DiagramStackedArea.Values.VaryColorsByCategory :=
    (FCadRel[intRelatorio].FieldByName('REL_VARCOR').AsString = 'S') And
    (cxvGrafico.SeriesCount = 1);

  cxvGrafico.DiagramStackedArea.AxisCategory.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINVER').AsString = 'S';

  cxvGrafico.DiagramStackedArea.AxisValue.GridLines :=
   FCadRel[intRelatorio].FieldByName('REL_LINHOR').AsString = 'S';

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramStackedArea.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramStackedArea.Legend.Position := cppNone;
    2: cxvGrafico.DiagramStackedArea.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramStackedArea.Legend.Position := cppTop;
    4: cxvGrafico.DiagramStackedArea.Legend.Position := cppRight;
    5: cxvGrafico.DiagramStackedArea.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINCAP').AsInteger Of
    1:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpLeft;
    2:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpAbove;
    3:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpRight;
    4:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpBelow;
    5:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpCenter;
    6:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpAboveRight;
    7:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpBelowRight;
    8:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpAboveLeft;
    9:   cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpBelowLeft;
    Else cxvGrafico.DiagramStackedArea.Values.CaptionPosition := ldvcpNone;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_LINSTY').AsInteger Of
    1:   cxvGrafico.DiagramStackedArea.Values.LineStyle := clsNone;
    2:   cxvGrafico.DiagramStackedArea.Values.LineStyle := clsDash;
    3:   cxvGrafico.DiagramStackedArea.Values.LineStyle := clsDot;
    4:   cxvGrafico.DiagramStackedArea.Values.LineStyle := clsDashDot;
    5:   cxvGrafico.DiagramStackedArea.Values.LineStyle := clsDashDotDot;
    Else cxvGrafico.DiagramStackedArea.Values.LineStyle := clsSolid;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger > 0 Then
    cxvGrafico.DiagramStackedArea.Values.LineWidth := FCadRel[intRelatorio].FieldByName('REL_LINWID').AsInteger;

  Case FCadRel[intRelatorio].FieldByName('REL_MARSTY').AsInteger Of
    1:   cxvGrafico.DiagramStackedArea.Values.MarkerStyle := cmsCircle;
    2:   cxvGrafico.DiagramStackedArea.Values.MarkerStyle := cmsDiamond;
    3:   cxvGrafico.DiagramStackedArea.Values.MarkerStyle := cmsSquare;
    4:   cxvGrafico.DiagramStackedArea.Values.MarkerStyle := cmsTriangle;
    Else cxvGrafico.DiagramStackedArea.Values.MarkerStyle := cmsNone;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger > 0 Then
    cxvGrafico.DiagramStackedArea.Values.MarkerSize := FCadRel[intRelatorio].FieldByName('REL_MARWID').AsInteger;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedArea.Styles.AxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedArea.Styles.AxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_VALFON').AsString);
    cxvGrafico.DiagramStackedArea.Styles.AxisTitle.TextColor := cxvGrafico.DiagramStackedArea.Styles.AxisTitle.Font.Color;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString) Then
  Begin
    cxvGrafico.DiagramStackedArea.Styles.CategoryAxisTitle := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedArea.Styles.CategoryAxisTitle.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_CATFON').AsString);
    cxvGrafico.DiagramStackedArea.Styles.CategoryAxisTitle.TextColor := cxvGrafico.DiagramStackedArea.Styles.CategoryAxisTitle.Font.Color;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_TRAARE').AsInteger > 0 Then
    cxvGrafico.DiagramStackedArea.Transparency := FCadRel[intRelatorio].FieldByName('REL_TRAARE').AsInteger;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramStackedArea.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramStackedArea.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramStackedArea.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramStackedArea.Styles.ValueCaptions.Font.Color;
  End;

  If cxvGrafico.DataGroupCount = 0 Then
    cxvGrafico.DiagramStackedArea.AxisCategory.Title.Text := FCadRel[intRelatorio].FieldByName('REL_CATTIT').AsString;

  cxvGrafico.DiagramStackedArea.AxisValue.Title.Text    := FCadRel[intRelatorio].FieldByName('REL_VALTIT').AsString;
End;

Procedure TGeraFR3.pMontaGraficoPie(cxvGrafico: TcxGridDBChartView; AOwner: TComponent; intRelatorio: Integer);
Begin
  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.DiagramPie.Legend.Position := cppDefault;
    1: cxvGrafico.DiagramPie.Legend.Position := cppNone;
    2: cxvGrafico.DiagramPie.Legend.Position := cppLeft;
    3: cxvGrafico.DiagramPie.Legend.Position := cppTop;
    4: cxvGrafico.DiagramPie.Legend.Position := cppRight;
    5: cxvGrafico.DiagramPie.Legend.Position := cppBottom;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_PIECAP').AsInteger Of
    1:   cxvGrafico.DiagramPie.Values.CaptionPosition := pdvcpCenter;
    2:   cxvGrafico.DiagramPie.Values.CaptionPosition := pdvcpInsideEnd;
    3:   cxvGrafico.DiagramPie.Values.CaptionPosition := pdvcpNone;
    4:   cxvGrafico.DiagramPie.Values.CaptionPosition := pdvcpOutsideEndWithLeaderLines;
    Else cxvGrafico.DiagramPie.Values.CaptionPosition := pdvcpOutsideEnd;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString) Then
  Begin
    cxvGrafico.DiagramPie.Styles.ValueCaptions := TcxStyle.Create(AOwner);
    cxvGrafico.DiagramPie.Styles.ValueCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONCAP').AsString);
    cxvGrafico.DiagramPie.Styles.ValueCaptions.TextColor := cxvGrafico.DiagramPie.Styles.ValueCaptions.Font.Color;
  End;

  If (Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_SITCAP').AsString)) Or
     (FCadRel[intRelatorio].FieldByName('REL_FUNSIT').AsInteger > 0) Then
    cxvGrafico.DiagramPie.Styles.SeriesSiteCaptions := TcxStyle.Create(AOwner);

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_SITCAP').AsString) Then
  Begin
    cxvGrafico.DiagramPie.Styles.SeriesSiteCaptions.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_SITCAP').AsString);
    cxvGrafico.DiagramPie.Styles.SeriesSiteCaptions.TextColor := cxvGrafico.DiagramPie.Styles.SeriesSiteCaptions.Font.Color;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_FUNSIT').AsInteger > 0 Then
    cxvGrafico.DiagramPie.Styles.SeriesSiteCaptions.Color := FCadRel[intRelatorio].FieldByName('REL_FUNSIT').AsInteger;

  cxvGrafico.DiagramPie.SeriesCaptions := FCadRel[intRelatorio].FieldByName('REL_SERCAP').AsString = 'S';
  cxvGrafico.DiagramPie.SeriesSites    := FCadRel[intRelatorio].FieldByName('REL_SERSIT').AsString = 'S';

  If FCadRel[intRelatorio].FieldByName('REL_SERCOL').AsInteger > 0 Then
    cxvGrafico.DiagramPie.SeriesColumnCount := FCadRel[intRelatorio].FieldByName('REL_SERCOL').AsInteger;

  cxvGrafico.DiagramPie.Values.CaptionItems := [];

  If FCadRel[intRelatorio].FieldByName('REL_ITECAT').AsString = 'S' Then
    cxvGrafico.DiagramPie.Values.CaptionItems := cxvGrafico.DiagramPie.Values.CaptionItems + [pdvciCategory];

  If FCadRel[intRelatorio].FieldByName('REL_ITEVAL').AsString = 'S' Then
    cxvGrafico.DiagramPie.Values.CaptionItems := cxvGrafico.DiagramPie.Values.CaptionItems + [pdvciValue];

  If FCadRel[intRelatorio].FieldByName('REL_ITEPER').AsString = 'S' Then
    cxvGrafico.DiagramPie.Values.CaptionItems := cxvGrafico.DiagramPie.Values.CaptionItems + [pdvciPercentage];
End;

Procedure TGeraFR3.pMontaGrafico(cxgGrafico: TCxGrid;
                                 cxvGrafico: TcxGridDBChartView;
                                 AOwner: TComponent;
                                 cdsCampos: TZClient;
                                 intRelatorio: Integer;
                                 dtsGrafigo: TDataSource;
                                 shpGrafico: TShape);
Begin
  Case FCadRel[intRelatorio].FieldByName('REL_ALILEG').AsInteger Of
    0: cxvGrafico.Title.Alignment := cpaCenter;
    1: cxvGrafico.Title.Alignment := cpaDefault;
    2: cxvGrafico.Title.Alignment := cpaEnd;
    3: cxvGrafico.Title.Alignment := cpaStart;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_POSLEG').AsInteger Of
    0: cxvGrafico.Legend.Position := cppDefault;
    1: cxvGrafico.Legend.Position := cppNone;
    2: cxvGrafico.Legend.Position := cppLeft;
    3: cxvGrafico.Legend.Position := cppTop;
    4: cxvGrafico.Legend.Position := cppRight;
    5: cxvGrafico.Legend.Position := cppBottom;
  End;

  cxvGrafico.Title.Text := fGetNomeRelatorio(FCadRel[intRelatorio]);

  Case FCadRel[intRelatorio].FieldByName('REL_ALITIT').AsInteger Of
    0: cxvGrafico.Title.Alignment := cpaCenter;
    1: cxvGrafico.Title.Alignment := cpaDefault;
    2: cxvGrafico.Title.Alignment := cpaEnd;
    3: cxvGrafico.Title.Alignment := cpaStart;
  End;

  Case FCadRel[intRelatorio].FieldByName('REL_POSTIT').AsInteger Of
    0: cxvGrafico.Title.Position := cppDefault;
    1: cxvGrafico.Title.Position := cppNone;
    2: cxvGrafico.Title.Position := cppLeft;
    3: cxvGrafico.Title.Position := cppTop;
    4: cxvGrafico.Title.Position := cppRight;
    5: cxvGrafico.Title.Position := cppBottom;
  End;

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONTIT').AsString) Then
  Begin
    cxvGrafico.Styles.Title := TcxStyle.Create(AOwner);
    cxvGrafico.Styles.Title.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONTIT').AsString);
    cxvGrafico.Styles.Title.TextColor := cxvGrafico.Styles.Title.Font.Color;
  End;

  If (Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONLEG').AsString)) Or
     (FCadRel[intRelatorio].FieldByName('REL_FUNLEG').AsInteger > 0) Then
    cxvGrafico.Styles.Legend := TcxStyle.Create(AOwner);

  If Not fEmptyStr(FCadRel[intRelatorio].FieldByName('REL_FONLEG').AsString) Then
  Begin
    cxvGrafico.Styles.Legend.Font := TInterfaceRelatorio.StrToFont(FCadRel[intRelatorio].FieldByName('REL_FONLEG').AsString);
    cxvGrafico.Styles.Legend.TextColor := cxvGrafico.Styles.Legend.Font.Color;
  End;

  If FCadRel[intRelatorio].FieldByName('REL_FUNLEG').AsInteger > 0 Then
    cxvGrafico.Styles.Legend.Color := FCadRel[intRelatorio].FieldByName('REL_FUNLEG').AsInteger;

  shpGrafico.Visible := FCadRel[intRelatorio].FieldByName('REL_MOLGRA').AsString = 'A';

  cxgGrafico.BorderStyle := cxcbsNone;

  If FCadRel[intRelatorio].FieldByName('REL_MOLGRA').AsString = 'R' Then
    cxgGrafico.Align := alClient;

  If FCadRel[intRelatorio].FieldByName('REL_BORLEG').AsString = 'S' Then
    cxvGrafico.Legend.Border := lbSingle
  Else
    cxvGrafico.Legend.Border := lbNone;

  If FCadRel[intRelatorio].FieldByName('REL_CATPAG').AsInteger > 0 Then
    cxvGrafico.OptionsView.CategoriesPerPage := FCadRel[intRelatorio].FieldByName('REL_CATPAG').AsInteger;

  dtsGrafigo.DataSet := FDados[intRelatorio];

  pMontaSeries(cxvGrafico, cdsCampos, intRelatorio);

  pMontaGraficoColunas(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoLinha(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoBarras(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoArea(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoPie(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoAreaEmpilhada(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoColunasEmpilhadas(cxvGrafico, AOwner, intRelatorio);
  pMontaGraficoBarrasEmpilhadas(cxvGrafico, AOwner, intRelatorio);

  Case TInterfaceRelatorio.fDestinoToTipo(FCadRel[intRelatorio].FieldByName('REL_DESTIN').AsString) Of
    desGraficoColunas         : cxvGrafico.DiagramColumn.Active := True;
    desGraficoLinha           : cxvGrafico.DiagramLine.Active := True;
    desGraficoBarras          : cxvGrafico.DiagramBar.Active := True;
    desGraficoArea            : cxvGrafico.DiagramArea.Active := True;
    desGraficoTorta           : cxvGrafico.DiagramPie.Active := True;
    desGraficoAreaEmpilhado   : cxvGrafico.DiagramStackedArea.Active := True;
    desGraficoColunasEmpilhado: cxvGrafico.DiagramStackedColumn.Active := True;
    desGraficoBarrasEmpilhado : cxvGrafico.DiagramStackedBar.Active := True;
  End;

End;


Function TGeraFR3.fMontaGrafico: Boolean;
  Var
    frmDefinePosicaoGrafico: TfrmDefinePosicaoGrafico;
begin

  Try
    pCriarFormularios(TfrmDefinePosicaoGrafico, frmDefinePosicaoGrafico);
    frmDefinePosicaoGrafico.blnMontagem := FCadRel[0].State In [dsEdit, dsInsert];
    frmDefinePosicaoGrafico.blnLayOut   := False;
    frmDefinePosicaoGrafico.objGeraFr3  := Self;
    frmDefinePosicaoGrafico.intGraficos := Length(FCadRel);
    frmDefinePosicaoGrafico.Caption     := fGetNomeRelatorio(FCadRel[0]);
    frmDefinePosicaoGrafico.intMoldura  := FCadRel[0].FieldByName('REL_WIDMOL').AsInteger;
    frmDefinePosicaoGrafico.intLinhas   := FCadRel[0].FieldByName('REL_LINGRA').AsInteger;
    frmDefinePosicaoGrafico.intColunas  := FCadRel[0].FieldByName('REL_COLGRA').AsInteger;

    If FCadRel[0].FieldByName('REL_CORMOL').AsInteger > 0 Then
      frmDefinePosicaoGrafico.Color := FCadRel[0].FieldByName('REL_CORMOL').AsInteger;

    If FCadRel[0].FieldByName('REL_ALTGRA').AsInteger > 0 Then
    Begin
      Self.intAlturaGrafico  := FCadRel[0].FieldByName('REL_ALTGRA').AsInteger;
      Self.intLarguraGrafico := FCadRel[0].FieldByName('REL_LARGRA').AsInteger;
      Self.blnMaximizado     := FCadRel[0].FieldByName('REL_MAXGRA').AsString = 'S';
      Self.stlAlturaLinhas.Text := FCadRel[0].FieldByName('REL_ALTLIN').AsString;
    End;

    frmDefinePosicaoGrafico.ShowModal;

    If FCadRel[0].State In dsEditModes Then
    Begin

      FCadRel[0].FieldByName('REL_ALTGRA').AsInteger := Self.intAlturaGrafico;
      FCadRel[0].FieldByName('REL_LARGRA').AsInteger := Self.intLarguraGrafico;
      FCadRel[0].FieldByName('REL_ALTLIN').AsString  := Self.stlAlturaLinhas.Text;

      If Self.blnMaximizado Then
        FCadRel[0].FieldByName('REL_MAXGRA').AsString := 'S'
      Else
        FCadRel[0].FieldByName('REL_MAXGRA').AsString := 'N';
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFR3.fMontaGrafico]');
    End;
  End;

  pFreeAndNil(frmDefinePosicaoGrafico);
End;

Procedure TGeraFR3.pSetCampos(Value: TZClient);
Begin
  FCampos.Data    := Value.Data;
  FCamposExp.Data := Value.Data;

  FCampos.IndexFieldNames    := 'CAM_POSICA';
  FCamposExp.IndexFieldNames := 'TAMANHO_CAMPO';
End;

function TGeraFR3.fFormataCpfCgcRel(strCPF: String): String;
begin
  Result := fFormataCpfCgc(strCPF, FPais);
end;

function TGeraFR3.fFormataContabilRel(dblValor: Double; intCasas: Integer; blnTotalizador: Boolean): String;
var
  strMascara: string;
  intCont: Integer;
begin
  strMascara := '###,##0.';
  for intCont := 0 to intCasas - 1 do
    strMascara := strMascara + '0';

  if blnTotalizador and (dblValor = 0) then
    Result := ''
  else
    Result := IIF(dblValor < 0, '(' + FormatFloat(strMascara, (dblValor * -1)) + ')', FormatFloat(strMascara, dblValor));
end;

Class function TGeraFR3.fFormataFoneRel(strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TGeraFR3.fFiltraDadosChild(intContRel: Integer; strCodRel: String; strNomCam: String; strCamLig: String; strValores: String): Boolean;
var
  sltCamLig: TStringList;
  sltValores: TStringList;
  strFilter: string;
  intContador: Integer;

begin

  try
    strFilter := '';
    sltCamLig := Split(strCamLig, ';');
    sltValores := Split(strValores, ';');
    for intContador := 0 to sltCamLig.Count - 1 do
    begin
      if FDados[intContRel].FieldByName(sltCamLig[intContador]).DataType in [ftLargeint, ftInteger, ftWord, ftFloat] then
        strFilter := strFilter + IIF(fEmptyStr(strFilter), '', ' AND ') + sltCamLig[intContador] + ' = ' + AnsiReplaceStr(sltValores[intContador], ',', '.')
      else
        strFilter := strFilter + IIF(fEmptyStr(strFilter), '', ' AND ') + sltCamLig[intContador] + ' = ' + QuotedStr(sltValores[intContador]);
    end;
  finally
    FreeAndNil(sltCamLig);
    FreeAndNil(sltValores);
  end;

  FDados[intContRel].Filtered := False;
  FDados[intContRel].Filter   := strFilter;
  FDados[intContRel].Filtered := True;

  Result := True;
end;

function TGeraFR3.fFiltraDadosFr3Child(strNomeTmp: String; strCamLig: String; strValores: String): Boolean;
var
  sltCamLig: TStringList;
  sltValores: TStringList;
  strFilter: string;
  intQuerie: Integer;
  intContador: Integer;

begin

  For intQuerie := Low(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) To High(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) Do
  Begin
    If TInterfaceRelatorio(fGetInterface).FTabelasTemporarias[intQuerie].strNome_relatorio = strNomeTmp Then
    Begin
        try
          strFilter := '';
          sltCamLig := Split(strCamLig, ';');
          sltValores := Split(strValores, ';');
          for intContador := 0 to sltCamLig.Count - 1 do
          begin
            if qryDadosPersonalizado[intQuerie].FieldByName(sltCamLig[intContador]).DataType in [ftLargeint, ftInteger, ftWord, ftFloat] then
              strFilter := strFilter + IIF(fEmptyStr(strFilter), '', ' AND ') + sltCamLig[intContador] + ' = ' + AnsiReplaceStr(sltValores[intContador], ',', '.')
            else
              strFilter := strFilter + IIF(fEmptyStr(strFilter), '', ' AND ') + sltCamLig[intContador] + ' = ' + QuotedStr(sltValores[intContador]);
          end;
        finally
          FreeAndNil(sltCamLig);
          FreeAndNil(sltValores);
        end;

        qryDadosPersonalizado[intQuerie].Filtered := False;
        qryDadosPersonalizado[intQuerie].Filter   := strFilter;
        qryDadosPersonalizado[intQuerie].Filtered := True;
    End;
  End;

  Result := True;
end;

function TGeraFR3.fRetQtdRegFr3Child(strNomeTmp: String): Integer;
var
  intQuerie: Integer;
begin
  Result := 0;

  For intQuerie := Low(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) To High(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) Do
  Begin
    If TInterfaceRelatorio(fGetInterface).FTabelasTemporarias[intQuerie].strNome_relatorio = strNomeTmp Then
    Begin
      Result := qryDadosPersonalizado[intQuerie].RecordCount;
    End;
  End;
end;

function TGeraFR3.fRetornaValorTemporariaFr3(strNomeTmp, strNomeCampo: String): String;
var
  intQuerie: Integer;
begin
  Result := '';

  For intQuerie := Low(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) To High(TInterfaceRelatorio(fGetInterface).FTabelasTemporarias) Do
  Begin
    If TInterfaceRelatorio(fGetInterface).FTabelasTemporarias[intQuerie].strNome_relatorio = strNomeTmp Then
    Begin
      Result := qryDadosPersonalizado[intQuerie].FieldByName(strNomeCampo).AsString;
      Break;
    End;
  End;
end;

Procedure TGeraFR3.pAddFunction(frxReport: TfrxReport);
begin
  With frxReport Do
  Begin
    AddFunction('function fFormataCpfCgcRel(strCPF: String): String;');
    AddFunction('function fFormataContabilRel(dblValor: Double; intCasas: Integer; blnTotalizador: Boolean): String;');
    AddFunction('function fFormataFoneRel(strTelefo: String): String;');
    AddFunction('function fCalculaJurosCadCtr(dtaDtaVen: TDateTime; fltValDup: Double; fltPerJur: Double = 9999; fltPerMul: Double = 9999; intTolerancia: Integer = 9999): Double;');
    AddFunction('function fDescricaoLinhaWandaPro(intCodLin: Integer): String;');
    AddFunction('function fNomeTinta(strIdePro: String): String;');
    AddFunction('function fCampoNulo(strNomCam: String; intPosicao: Integer): Boolean;');
    AddFunction('function fCampoVazio(strNomCam: String; intPosicao: Integer): Boolean;');
    AddFunction('function fAdicionaPaginaQuebra(intNroPag: Integer; strArquivoSaida: String; strNumWpp: String; strEmail: String; strAssunto: String; strCorpo: String; intRelatPos: Integer): Boolean;');
    AddFunction('function fFiltraDadosChild(intContRel: Integer; strCodRel: String; strNomCam: String; strCamLig: String; strValores: String): Boolean;');
    AddFunction('function fFiltraDadosFr3Child(strNomeTmp: String; strCamLig: String; strValores: String): Boolean;');
    AddFunction('function fRetQtdRegFr3Child(strNomeTmp: String): Integer;');
    AddFunction('function fRetornaValorTemporariaFr3(strNomeTmp, strNomeCampo: String): String;');
    AddFunction('function fRetIncremento: Integer');
    AddFunction('function fAtuIncremento(intIncReport: Integer): Boolean');
    AddFunction('function fRetornaFontName(strValor: String): String;');
    AddFunction('function fRetornaFontColor(strValor: String): Integer;');
    AddFunction('function fRetornaFontStyles(strValor: String): String;');
    AddFunction('function fRetornaBrushColor(strValor: String): Integer;');
    AddFunction('function fVerificaFileExists(strFilePath: String): Boolean;');
    AddFunction('function fRetLocFisica(strCodIte: String): String;');
    AddFunction('function fAbreComposicao(strNomeTmp: String; strCampoSeqDet: String; strValorSeqDet: String): Boolean;');
    AddFunction('function fBuscaLocFisica(strNomeTmp: String; strValorSeqDet: String; strCampoRetorno: String): String;');
    AddFunction('function fCfgSis(strCodCfg: String): String;');
    AddFunction('procedure pCarregaImagemProduto(strCodIte, strNomePicCodIte: String; strAutInc: String = '''');');
    AddFunction('procedure pCarregaImagemProdutoRed(strCodIte, strNomePicCodIte: String; strAutInc: String = '''');');
    AddFunction('function fRetornaLeftImagem(strOrientacao: String; intQtdColunas: Integer): Double;');
    AddFunction('function fRetornaWidthImagem(strOrientacao: String; intQtdColunas: Integer): Double;');
  End;
End;

Function TGeraFR3.fMontaFuncaoAutCom(funFuncao: TFuncaoAutCom; cdsCampo: TZClient): String;
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  stlLista := TStringList.Create;

  stlLista.Text := cdsCampo.FieldbyName('CAM_PARAME').AsString;

  For intContador := 0 To stlLista.Count -1 Do
    stlLista[intContador] := '<' + fDataSetName(intRelatPos) + '."' + stlLista[intContador] + '">';

  Result := ArrDesDefFuncao[funFuncao] + '(' + fCommaText(stlLista) + ')';

  FreeAndNil(stlLista);
End;

Function TGeraFR3.fAjutaFormatoCampo(strCampo: String): String;
Begin
  If Not strCampo.StartsWith('<') Then
    Result := Concat('<', strCampo, '>')
  Else
    Result := strCampo;
End;

Function TGeraFR3.fRetCampoRel(cdsCampo: TZClient; Var strFormatStr: String; blnTotal, blnFormataTitulo: Boolean): String;
  Var
    strValCam: String;
    funFuncao: TFuncaoAutCom;
Begin
  strFormatStr := '';
  With cdsCampo Do
  Begin
    strValCam := '';

    If (Not fEmptyStr(FieldByName('CAM_FUNCAO').AsString)) Then
    Begin
      funFuncao := TInterfaceRelatorio.fDescFuncaoToTipo(FieldByName('CAM_FUNCAO').AsString);

      If funFuncao <> funVazio Then
        strValCam := fMontaFuncaoAutCom(funFuncao, cdsCampo);
    End;

    If fEmptyStr(strValCam) Then
    Begin
      strValCam := fDataSetName(intRelatPos) + '."' + FieldByName('CAM_NOMCAM').AsString + '"';

      If blnTotal Or (Not fEmptyStr(FieldByName('CAM_MASCAR').AsString)) Then
        strValCam := '<' + strValCam + '>';
    End;

    If Not blnTotal Then
    Begin

      Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
        masCNPJ         : Result := '[fFormataCpfCgcRel(' + strValCam + ')]';
        masContabil     : Result := '[fFormataContabilRel(' + strValCam + ', ' + IntToStr(StrToIntDef(FieldByName('CAM_NRODEC').AsString, 2)) + ', False)]';
        masTelefone     : Result := '[FormatMaskText(' + QuotedStr(fRetMascaraFonePais) + ', ' + strValCam + ')]';
        masCEP          : Result := '[FormatMaskText(' + QuotedStr('99999-999;0;_')     + ', ' + strValCam + ')]';
        masPlacaVeiculo : Result := '[FormatMaskText(' + QuotedStr('lll-9999;0;_')      + ', ' + strValCam + ')]';
        masPlanoContabil: Result := '[FormatMaskText(' + QuotedStr(fCfgSis('MSKCON') + ';0;_') + ', ' + strValCam + ')]';
        masCondPagto    : Result := '[FormatMaskText(' + QuotedStr(MASK_CONPAG) + ', ' + strValCam + ')]';
        Else              Result := '[' + strValCam + ']'
      End;

    End

    Else Result := strValCam;

    If blnFormataTitulo Then
    Begin

      Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
        masDecUni       : Result := '[FormatFloat(' + QuotedStr(fMskDigitos(fCfgSis('DECUNI', varInteger))) + ', ' + fAjutaFormatoCampo(strValCam) + ')]';
        masDecQtd       : Result := '[FormatFloat(' + QuotedStr(fMskDigitos(fCfgSis('DECQTD', varInteger))) + ', ' + fAjutaFormatoCampo(strValCam) + ')]';
        masEstDec       : Result := '[FormatFloat(' + QuotedStr(fMskDigitos(fCfgSis('ESTDEC', varInteger))) + ', ' + fAjutaFormatoCampo(strValCam) + ')]';
        masDeqTpc       : Result := '[FormatFloat(' + QuotedStr(fMskDigitos(fCfgSis('DEQTPC', varInteger))) + ', ' + fAjutaFormatoCampo(strValCam) + ')]';
        Else              If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') And Not SameText(FieldByName('CAM_MASCAR').AsString, 'Máscara Contábil') Then
                            Result := '[FormatFloat(' + QuotedStr(fMskDigitos(FieldByName('CAM_NRODEC').AsInteger)) + ', ' + fAjutaFormatoCampo(strValCam) + ')]';
      End;

    End Else
    Begin

      Case TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) Of
        masDecUni       : strFormatStr := '%2.' + fCfgSis('DECUNI', varString) + 'n';
        masDecQtd       : strFormatStr := '%2.' + fCfgSis('DECQTD', varString) + 'n';
        masEstDec       : strFormatStr := '%2.' + fCfgSis('ESTDEC', varString) + 'n';
        masDeqTpc       : strFormatStr := '%2.' + fCfgSis('DEQTPC', varString) + 'n';

        Else             If SameText(FieldByName('CAM_TIPCAM').AsString, 'Número decimal') And Not SameText(FieldByName('CAM_MASCAR').AsString, 'Máscara Contábil') Then
                           strFormatStr := '%2.' + IntToStr(FieldByName('CAM_NRODEC').AsInteger) + 'n';
      End;

    End;

  End;
End;

Function TGeraFR3.fCarregaReport(qryCadRel: TUniQuery): Boolean;
Begin
  FJato   := SameText(qryCadRel.FieldbyName('REL_TIPIMP').AsString, 'J');
  FTipImp := qryCadRel.FieldByName('REL_TIPIMP').AsString;

  FfrxReport := fCriaBase(FBase);

  Result := fLoadReport(qryCadRel, FfrxReport);
End;

Function TGeraFR3.fColunasToPagMat(intColunas: Integer): TPaginaMatricial;
  Var
    pagContador: TPaginaMatricial;
Begin
  Result := pag137;

  For pagContador := Low(COLUNAS_MAT) To High(COLUNAS_MAT) Do
    If COLUNAS_MAT[pagContador] = intColunas Then
    Begin
      Result := pagContador;
      Exit;
    End;
End;

Class Function TGeraFR3.fRetColunasMatricial: String;
  Var
    stlLista: TStringList;
    pagPaginas: TPaginaMatricial;
Begin
  stlLista := TStringList.Create;

   For pagPaginas := Low(COLUNAS_MAT) To High(COLUNAS_MAT) Do
     stlLista.Add(IntToStr(COLUNAS_MAT[pagPaginas]));

  Result := stlLista.Text;
  FreeAndNil(stlLista);
End;

Function TGeraFR3.fColunasToCommand(intColunas: Integer): String;
  Var
    pagPaginas: TPaginaMatricial;
Begin
  Result := IIF(FCadRel[intRelatPos].FieldByName('REL_IMPMEI').AsString = 'S', FORMATO_MAT_MEIA[pag137], FORMATO_MAT[pag137]);

  For pagPaginas := Low(COLUNAS_MAT) To High(COLUNAS_MAT) Do
    If COLUNAS_MAT[pagPaginas] = intColunas Then
    Begin
      Result := IIF(FCadRel[intRelatPos].FieldByName('REL_IMPMEI').AsString = 'S', FORMATO_MAT_MEIA[pagPaginas], FORMATO_MAT[pagPaginas]);
      Exit;
    End;

End;

Procedure TGeraFR3.pSetaTamanhoDados(intQueries: Integer);
Begin
  SetLength(FDados, intQueries);
  SetLength(FDadosOrig, intQueries);
End;

Procedure TGeraFR3.pSetaTamanhoDadosPersonalizado(intQueries: Integer);
Begin
  SetLength(FDadosPersonalizado, intQueries);
End;

Function TGeraFR3.fDataSetName(intQuerie: Integer): String;
Begin
  Result := 'frxDataSet' + IntToStr(intQuerie);
End;

Function TGeraFR3.fMasterDataName(intQuerie: Integer; strNomCam: string): String;
Begin
  Result := 'frxMasterData' + IntToStr(intQuerie) + strNomCam;
End;

Function TGeraFR3.fPageName(intQuerie: Integer): String;
Begin
  Result := 'frxPage' + IntToStr(intQuerie);
End;

Function TGeraFR3.fAtualizaPapel(qryCadRel: TUniQuery): Boolean;
Begin
  With qryCadRel Do
  Begin
    If fEmptyStr(FieldByName('REL_CODMOD').AsString) Then
    Begin
      Result := False;
      Exit;
    End;

    intPaper            := fRetPaperSize(FieldByName('REL_TIPFOL').AsString);

    fltFatorScale       := FieldByName('REL_FATSCA').AsFloat;

    If fltFatorScale < 1 Then
      fltFatorScale := 1;

    FSplit := SameText(FieldByName('REL_SPLIT_').AsString, 'S');

    intColunasMatricial := StrToIntDef(FieldByName('REL_QTDCOL').AsString, COLUNAS_MAT[pag137]);

    If (SameText(FieldByName('REL_ORIENT').AsString, 'R')) Or (Not FJato) Then
      proOrientation := poPortrait
    Else
      proOrientation := poLandscape;

    strCodMod := FieldByName('REL_CODMOD').AsString;

    Result := blnCarregouPagina;
  End;
End;

Procedure TGeraFR3.pCarregaTitulosRelatorio;
  Var
    intContador: Integer;
Begin
  SetLength(FTitulosRelatorio, Length(FCadRel));

  for intContador := Succ(Low(FCadRel)) to High(FCadRel) Do
  Begin
    If Pos(FCadRel[intContador].FieldByName('REL_TITPOS').AsString, 'S_A_') > 0 then
      FTitulosRelatorio[intContador] := fUpper(fGetNomeRelatorio(FCadRel[intContador]))
    Else
      FTitulosRelatorio[intContador] := '';
  end;

End;

Procedure TGeraFR3.pCarregaSubTitulosRelatorio;
  Var
    intContador: Integer;
Begin
  SetLength(FSubTitulosRelatorio, Length(FCadRel));

  for intContador := Succ(Low(FCadRel)) to High(FCadRel) Do
  Begin
    If Pos(FCadRel[intContador].FieldByName('REL_TITPOS').AsString, 'S_A_') > 0 then
      FSubTitulosRelatorio[intContador] := fUpper(fGetSubNomeRelatorio(FCadRel[intContador]))
    Else
      FSubTitulosRelatorio[intContador] := '';
  end;

End;

Function TGeraFR3.fMontaGraficoDashboard: Boolean;
  Var
    objPainel: TGraficosDashboard;
begin

  Try

    objPainel := TGraficosDashboard.Create;

    objPainel.objGeraFr3 := Self;

    objPainel.arrCadRel := FCadRel;
    objPainel.arrDados  := FDados;

    objPainel.desDestino := desDestinoFr3;

    objPainel.cdsColunasPorLinha := TInterfaceRelatorio(fGetInterface).cdsColunasPorLinha;

    If objPainel.fMontaGrafico Then
    Begin
      TInterfaceRelatorio(fGetInterface).strJson       := objPainel.strJson;

      if not VS_AutcomIniciadoRoboRelatorioWeb then
        TInterfaceRelatorio(fGetInterface).strUrlGrafico := objPainel.strUrlGrafico;

      If Not TInterfaceRelatorio(fGetInterface).blnDestinoJson Then
        objPainel.pMostraGrafico;
    End;

    FreeAndNil(objPainel);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TGeraFR3.fMontaGraficoDashboard]');
    End;
  End;

End;

procedure TGeraFR3.pGravaLogPaf(strSucesso, strResultado: String);
begin
  If Assigned(objInterfaceGeraPrincipal) Then
    TInterfaceRelatorio(objInterfaceGeraPrincipal).pGravaLogPaf(strSucesso, strResultado)
  Else
    TInterfaceRelatorio(objInterfaceGera).pGravaLogPaf(strSucesso, strResultado);
end;

procedure TGeraFR3.pGravaLogExecucao(strResultado: String);
begin
  If Assigned(objInterfaceGeraPrincipal) Then
    TInterfaceRelatorio(objInterfaceGeraPrincipal).pGravaLogExecucao(strResultado)
  Else
    TInterfaceRelatorio(objInterfaceGera).pGravaLogExecucao(strResultado);
end;

Function TGeraFR3.fGetDestinoRelatorio: TDestinoRel;
Begin
  If fGetInterface <> Nil Then
    Result := TInterfaceRelatorio(fGetInterface).desDestinoInicial
  Else
    Result := FDestino;
End;

procedure TGeraFR3.pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp: String);
Begin
  If Assigned(objInterfaceGeraPrincipal) Then
    TInterfaceRelatorio(objInterfaceGeraPrincipal).pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp)
  Else
    TInterfaceRelatorio(objInterfaceGera).pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp);
end;

Function TGeraFR3.fRetPerguntaEnviarGatilho(strTipo, strMensagem : String): Boolean;
Begin
  Result := False;

  Try
    If FCadRel[0].FieldByName(strTipo).AsString = 'S' Then
      If fPergunta(strMensagem) Then
        Result := True;
  Except
    Result := False;
  End;
End;

Function TGeraFR3.fRetGerarVideoVazio: Boolean;
Begin
  If Assigned(objInterfaceGeraPrincipal) Then
    Result := TInterfaceRelatorio(objInterfaceGeraPrincipal).blnImprimirVazio
  Else
    Result := TInterfaceRelatorio(objInterfaceGera).blnImprimirVazio;
end;

Function TGeraFR3.fEnviaPontosImpressao: Boolean;
Begin
  Result := (Assigned(TInterfaceRelatorio(objInterfaceGera).arrArquivosPontoImpressao) And
            (Length(TInterfaceRelatorio(objInterfaceGera).arrArquivosPontoImpressao) > 0) And
            (VS_SpoolImpressaoCitel));
End;

Function TGeraFR3.fValidaPontosImpressao: Boolean;
var
  intContador: Integer;
  strMsg: String;
  strPonto, strCFG : String;
Begin
  Result := True;

  If fEnviaPontosImpressao then
  begin
    for intContador := 0 to Length(TInterfaceRelatorio(objInterfaceGera).arrArquivosPontoImpressao) -1 do
    begin
      strPonto := TInterfaceRelatorio(objInterfaceGera).arrArquivosPontoImpressao[intContador].strPontoImpressao;

      If (Not TSpoolImpressaoCitel.fGetPontoImpressao(strPonto).Existe) Then
      begin
        strCFG := TInterfaceRelatorio(objInterfaceGera).arrArquivosPontoImpressao[intContador].strCfg;

        strMsg := 'O ponto de impressão ' +
                  strPonto +
                  IIF(strCFG = '', ' ', ' (' + strCFG + ') ' ) +
                  'não existe. Verifique!';
        fMensagem('ATENÇÃO!', strMsg, ['&Ok']);
        Result := False;
        Break;
      end;
    end;
  end;

End;

end.

