unit untInterfaceRelatorio;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema, cxVGrid, Graphics,
  Controls, StdCtrls, StrUtils, DateUtils, Forms, Vcl.ExtCtrls,
  Uni, UniClientDataSet, UniDataSetProvider, DB, untFuncoesSimples,
  untZClient, untGeraFr3, untModulo, System.Generics.Collections,
  untConsultasRel, untFuncEditorRel, cxProgressBar, cxCheckBox,
  fs_iinterpreter, Menus, AdvMenus, untGravando,
  CRParser, MyParserUni, Math, untInterfaceGrafica, untConstantes,
  cxGridDBTableView, DBMemoFocus, BCEditor.Types, BCEditor.Lines,
  BCEditor.Editor.Base, BCEditor.Editor, System.NetEncoding,
  System.RegularExpressions, System.UITypes, untDadosEnviaWhatsapp,
  untRotinasGrid, untConsultasGrid, untDllGatIme;

Const
  MAX_TABELAS_DINAMICAS = 12;

Type
  TExpreVisibPar = Record
    strNomPar,
    strExpVis: String;
  End;

  TSQLVisibPar = Record
    strNomPar,
    strSQLVis: String;
  End;

  TEmpConfigPar = Record
    strNomPar,
    strEmpCfg: String;
  End;

  TSelectCheckList = Record
    strNomPar: String;
    intLimRet,
    intLimite: Integer;
    qryDados: TUniQuery;
    strSqlOri: String;
  End;

  TArrSelectCheckList = Array Of TSelectCheckList;

  TArrArquivoPontoImpressao = Array Of Record
    strArquivo: String;
    strPontoImpressao: String;
    strCfg: String;
  End;

  TArrTemporarias = Array of Record
    strNome_relatorio,
    strNome_banco: String;
  End;

  TGuiaSaldos = Record
    blnGarantia,
    blnExterno,
    blnPedidoVenda,
    blnPedidoBaixaEntregaFutura,
    blnEnderecamento,
    blnOrdemProducao,
    blnSaldoTransferencias,
    blnEntregaFuturaPrevisao,
    blnEntregaFuturaFaltaProduto,
    blnEntregaFuturaAguandandoCliente: Boolean;

    strSQLFormatado,
    strSQL: String;

    qryGuiaSaldos: TUniQuery;
  End;

  TArrGuiaSaldos = Array Of TGuiaSaldos;

  TRecSetSelect = Record
    strNomVar,
    strNomPar: String;
    intQuery: Integer;
    qryInfo: TUniQuery;
  End;

  TRecConstInst = Record
    strNomConst: String;
    strDescInst: String;
  End;

  TarrRecSetSelect = Array Of TRecSetSelect;
  TarrRecConstInst = Array Of TRecConstInst;

  TRecDadosPai = Record
    strSQLDEF,
    strDEFSQL: String;
  End;

  TTemTabelaDinamica = Array[1..MAX_TABELAS_DINAMICAS] Of Boolean;

  TIndexTabelaDinamica = Array[1..MAX_TABELAS_DINAMICAS] Of Integer;

  TInterfaceRelatorio = class(TComponent)
    private
      FCodPai,
      FSQLFil,
      FExtensaoCtr,
      FstrHorizo,
      FTipFacAnterior,
      FTipoSomaAnterior: String;

      FPastaDestino: String;

      FGravando: TfrmGravando;

      FIntMaxCol: Integer;

      FFilteredGruParAnt: Boolean;
      FFilterGruParAnt: String;

      FTemInventFinanc,  // FIndexCTR_
      FFr3Gerado,
      FTemComposicaoCusto: Boolean;

      FTemTabelaI_,      // FIndexInventario
      FTemEstExt_,       // FIndexEstExt
      FTemTabelaSALINV,  // FIndexSalInv
      FTemTabelaL_,      // FIndexLote
      FTemEstEnv_,       // FIndexEstEnv
      FTemEstEnt_: TTemTabelaDinamica; // FIndexEstEnt

      FIndexInventario,
      FIndexEstExt,
      FIndexEstEnv,
      FIndexEstEnt,
      FIndexSalInv,
      FIndexLote: TIndexTabelaDinamica;

      FscrLinhas: TScrollBox;
      FimgFundo: TImage;

      FInterGraf: TInterfaceGrafica;

      FArrExpVis: Array Of TExpreVisibPar;

      FArrSQLVis: Array Of TSQLVisibPar;
      FArrEmpCfg: Array Of TEmpConfigPar;

      FArrSelectCheckList: TArrSelectCheckList;

      FArrLarguraUsada: Array[1..MAX_LINHAS_DETALHE] Of Double;

      FQtdCamposListados: Array[1..MAX_LINHAS_DETALHE] Of Integer;

      blnCriouConexao: Boolean;
      FConexaoRelatorio: TCriarConexao;

      FDacPor: Boolean;

      FListaGatilhos: String;

      FIndexCTR_,
      FIndexPaginaInicial,
      FIndexDestino,
      FIndexPasta,
      FIndexParCusto,
      FIndexImagemCabecalho: Integer;

      FExecutarDireto: Boolean;

      FSQLErro: Boolean;

      FNomeColunaHorizo,
      FOrderByOriginal,
      FOrderBy,
      FListaCampos: TStringList;

      FListaParFiltros: TStringList;
      FTituloFiltros: TStringList;

      FConsulta: TConsultasRel;

      FTitulo: String;
      FSubTitulo: String;

      FIndiceListaPreco,
      FLimiteTabelas: Integer;

      FSQLFormatado,
      FSQL: TArrString;

      FGeraFr3: TGeraFR3;

      FHorizo: TArrClient;

      FqryCadGetDesc: TUniQuery;
      FqryCadGetDescPrr: TUniQuery;

      FConsultasGrid: TConsultasGrid;

      FParamFuncao,
      FValueParams,
      FValueParamsDisplayText,
      FComplementos,
      FChilds,
      FParams,
      FCampos,
      FGruposParams,
      FHistoricos,
      FDirAcesso: TZClient;

      FdtsCamposAprove: TDataSource;

      FParamsCopia: TUniClientDataSet;
      FCamposCopia: TUniClientDataSet;

      FGuiaSaldosTemp: TGuiaSaldos;
      arrGuiaSaldos: TArrGuiaSaldos;
      FTabelasSaldos: TStringList;

      FGruposParametros,
      FCadRel,
      FQueryFiltros,
      FQueryDados,
      FQueryDadosPersonalizado: TArrQuery;

      FClientDados,
      FClientDadosPersonalizado: TArrUniClient;
      FProviderDados,
      FProviderDadosPersonalizado: TArrProvider;
      FEditavel: TArrBoolean;

      FControleRel: TArrControleRel;

      FComFilComplementos: TStringList;
      FComFilSQLFormatado: Array Of String;
      FComFilFiltros: TArrQuery;
      FComFilDados: TArrQuery;

      FFiltros: TcxVerticalGrid;

      FIdentRel: String;

      FLinhas: TZClient;

      FTiposBanda: TZClient;

      FLimits: TStringList;

      FarrRecSetSelect: TarrRecSetSelect;
      FarrRecConstInst: TarrRecConstInst;

      FParamValidacao: TUniQuery;

      FExecutaPelaInterface: Boolean;

      crwCategoriaGeracao: TcxCategoryRow;

      FTabelaFiltrosValores: string;
      FArquivoSaidaDiretoPDF: string;
      FPathImagemCabecalho: string;
      FExecutaRelatorioValidacao: Boolean;

      strMensagem: String;

      FDadosJsonEnviaWhatsapp: String;

      Function GetTag(AQuery: TUniQuery): Integer;
      Procedure SetTag(AQuery: TUniQuery; Value: Integer);

      Function fGetListaGatilhos: String;

      Procedure pAfterPostCamposRodape(dataSet: TDataSet);
      Procedure pBeforePostCamposRodape(dataSet: TDataSet);

      Procedure pSetCodPai(strValue: String);

      Function fTiraSelect(strSQL: String): String;

      Function fTrataConstantes(strInfo: String): String;
      Function fTrataTemplates(strInfo: String): String;
      Function fTrataInstrucoes(strInfo: String): String;

      Function fValidaComFil: Boolean;
      Function fGetLimiteTabelas(strSQL: String): Integer;
      Function fMudouHorizo: Boolean;
      Function fAjustaCases(strSQL: String; intQuerie: Integer): String;
      Function fGetSQL: String;
      Function fSQLCadGetDesc: String;
      Function fSQLCadGetDescPrr(strSeqGer: String): String;
      Function fSQLValueParams: String;
      Function fSQLParams: String;
      Function fSQLGruposParams: String;
      Function fSQLCampos: String;
      Function fSQLComplementos: String;
      Function fSQLChilds: String;
      Function fSQLHistoricos: String;
      Function fSQLDirAcesso: String;
      Function fSQLLinhas: String;
      Function fSQLParamFuncao: String;
      Function fSubstituiLinhaGrupo(strSQL, strNomPar, strSQLLinha: String): String;
      Function fSubstituiPlanoContabilNovo(strSQL, strNomPar, strSQLPlanoContabilNovo: String): String;
      Function fSubstituiPlanoContas(strSQL, strNomPar, strSQLPlano: String): String;
      Function fRetDado(rowDado: TcxEditorRow; blnMesmoInvisivel: Boolean = False): String;
      Function fValidaDia(strDia: String): Boolean;
      Function fValidaMes(Var strMes: String): Boolean;
      Function fCriaMaxLinhas: Boolean;
      Function fGetTipo(strTipo: String): TFieldType;
      Function fSQLHorizo(intQuerie: Integer): String;
      Function fSQLHorizoLines(intQuerie: Integer): String;
      Function fBuscaNomeCampo(strSQL, strNomPar: String): String;
      Function fExisteParametro(strNomPar: String; intOriPar: Integer): Boolean;
      Function fAtualizaCampos: Boolean;

      Function fAjustaTABELA_I_(strSQL: String; blnExecucao: Boolean): String;
      Function fAjustaESTEXT_(strSQL: String; blnExecucao: Boolean): String;
      Function fAjustaESTENV_(strSQL: String; blnExecucao: Boolean): String;
      Function fAjustaESTENT_(strSQL: String; blnExecucao: Boolean): String;
      Function fAjustaTabelaL_(strSQL: String; blnExecucao: Boolean): String;
      Function fAjustaSALINV(strSQL: String; blnExecucao: Boolean): String;

      Function fRetiraFormatacaoSQL(strInfo: String; blnExecucao, blnSetVS, blnQueryFiltros: Boolean; intQuerie: Integer = 0): String;

      Function fRetiraFormatacaoSaldos(strInfo: String; Var recSaldos: TGuiaSaldos; blnExecucao, blnQueryFiltros: Boolean): String;

      Function fRetiraFormatacaoSQLSetEmp(strSQL: String; intQuerie: Integer = 0): String;
      Function fTrataLimits(strInfo: String; blnExecucao: Boolean): String;
      Function fLeDadosProgresso(Progress : TcxProgressBar): Boolean;
      Function fLeDadosProgressoSQL: string;

      Procedure pSalvaTrace(qryDados: TUniQuery; strCodRel: String; strSetSQL: String = '');

      function fSetouNomeArquivo: Boolean;

      Function fExecutaSets(Progress : TcxProgressBar; var strSetSQL: string; strSQL: String; intQuerie: Integer; strNomeSet: string = ''): String;
      Function fExecutaConsts(strSQL: String): String;
      function fDevolveSQLExecucao(qryFiltros: TUniQuery; strSQL: string): string;

      Procedure pLiberaArrRecSetSelect;

      function fRetornaNomeArquivo(intQuerie: Integer = 0): String;
      function fRetornaPontoImpressao(intQuerie: Integer = 0): String;
      function fRetornaGerarSeVazio: String;

      Function fRetDescricaoTodos(dbeDesTod: TField): String;
      Function fMontaSQLDados(strSQL: String; qryDados: TUniQuery; intQuerie: Integer = 0): String;
      Function fEmpAcessoToValPar: String;
      Function fPortadorUsuarioToValPar(strNomCam: String): String;
      Function fRetiraClausula(strSQL, strNomPar: String): String;
      Function fEhParametroEmpresa(strNomPar: String): Boolean;
      Function fEhParametroEmpresaCompleto(strNomPar: String): Boolean;
      Function fEhParametroPortador(strNomPar: String): Boolean;
      Function fPoeMultiSelecao(strSQL, strNomPar, strValPar: String; strNomCam: String = ''; intPosNomCam: Integer = 0): String;
      Function fCriaValueParams: Boolean;
      Function fTemMultiSelecao(strNomPar: String): Boolean;
      Function fTemMultiSelecaoDisplayText(strNomPar: String): Boolean;
      Function fVerificaCampos: Boolean;
      Function fPastaSaida: String;
      Function fImagemCabecalho: String;
      Function fGetValorCombo(strDescricao: String): String;
      Function fSQLLoadCadVal: String;

      Function fParametroAutomaticoVisivel(strNomPar: String; Var strDesPar, strNomGru: String): Boolean;

      Function fAbreTabelaSaldos(intQuerie: Integer; Var strSQLPtincipalAtualizado: String): Boolean;

      Function fInverteConsulta(intQuerie: Integer; Var blnTudoNulo: Boolean): Boolean;

      Function fInverteConsultaLines(intQuerie: Integer; Var blnTudoNulo: Boolean): Boolean;

      Function fGetTamanhoCampo(strNomCam: String; blnSemCampos: Boolean): Double;
      Function fRetDescricaoCampo(strCodCam: String): String;
      Function fRetDescricaoFiltro(strCodPrr, strTipoRetorno, strSeqGer: String): Variant;

      Function fIncluiParametrosValidacao: Boolean;
      Function fSQLBuscaParametroValidacao: String;

      Function fAtualizaParametros(blnQueriesComplentares: Boolean): Boolean;
      Function fBuscaParametro(qryParam: TUniQuery; strNomPar, strSeqGer: String): Boolean;
      Function fSQLBuscaParametro: String;
      Function fRetPosOrdem(strNomCam: String): Integer;
      Function fCallIIF(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;

      Function fCallPos(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;

      Function fCallSum(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallCount(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallCopy(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallIntToStr(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallStrToInt(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallFloatToStr(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallStrToFloat(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;
      Function fCallFormatFloat(Instance: TObject; ClassType: TClass; Const MethodName: String; Var Params: Variant): Variant;

      Function fRetCategoria(strNomCat: String): TcxCategoryRow;
      Function fRetCategoriaCaption(strNomCat: String): TcxCategoryRow;

      Function fRetTabelasInventario: String;
      Function fRetTabelasEstExt: String;
      Function fRetTabelasEstEnt: String;
      Function fRetTabelasEstEnv: String;
      Function fRetTabelasLotes: String;
      Function fRetTabelasSALINV: String;
      Function fRetTabelasCTR_: String;

      Function fRetTabelaInventarioInicial: String;
      Function fRetTabelaEstExtInicial: String;
      Function fRetTabelaEstEnvInicial: String;
      Function fRetTabelaEstEntInicial: String;
      Function fRetTabelaLoteInicial: String;
      Function fRetTabelaInventarioSelecionada(intTabela: Integer): String;
      Function fRetTabelaEstExtSelecionada(intTabela: Integer): String;
      Function fRetTabelaEstEnvSelecionada(intTabela: Integer): String;
      Function fRetTabelaEstEntSelecionada(intTabela: Integer): String;
      Function fNomeToTabInv(strNome: String): String;
      Function fNomeToEstExt(strNome: String): String;
      Function fNomeToEstEnv(strNome: String): String;
      Function fNomeToEstEnt(strNome: String): String;
      Function fNomeToTabLot(strNome: String): String;
      Function fRetTabelaLoteSelecionado(intTabela: Integer): String;

      Function fRetTabelaSALINVInicial: String;
      Function fRetTabelaSALINVSelecionada(intTabela: Integer): String;

      Function fRetTabelaCTR_Inicial: String;
      Function fRetTabelaCTR_Selecionada: String;

      Function fRetMesInv(strMes: String): String;

      Function fTrataSaldoProduto(strInfo: String): String;

      Function fSQLSaldoProduto(strAliasIteger, strAliasCadIte: String): String;

      Class Function fRetDescricaoVisibilidade: String;

      Function fTemComandosProibidos(strSQL: String): Boolean;

      Function fCompletaDescricaoTabelasPrecoAtivas(blnValor: Boolean; intUltimo: Integer): String;

      Function fSetaDadosQuery(qryDados, qryFiltros: TUniQuery; blnVerObrigatorio: Boolean; Var blnFaltaInformacao: Boolean): Boolean;

      Function fSetaDadosQueryInterface(qryDados, qryFiltros: TUniQuery; blnVerObrigatorio: Boolean; Var blnFaltaInformacao: Boolean): Boolean;

      Function fSetaDadosQueryExecucao(qryDados,
                                       qryFiltros: TUniQuery;
                                       blnVerObrigatorio: Boolean;
                                       Var blnFaltaInformacao: Boolean): Boolean;

      Function fMontaComFilDados: Boolean;

      Function fGeraTitulosQuery(qryFiltro: TUniQuery; lstListaParFiltros: TStringList; blnFiltraImpFil: Boolean = False): Boolean;

      Function fGeraTitulo(strNomPar: String): Boolean;

      Function fAvaliaExpressao(strExpVis: String): Boolean;
      Function fAvaliaExpressaoString(strExpressao: String; Var blnErro: Boolean): String;

      Function fDisplayTextsToValPar(strDisplay: String): String;

      Function fGetQtdMarcados(strNomPar: String): Integer;

      Procedure pSetaRecSaldos(Var recSaldos: TGuiaSaldos);
      Procedure pSetaSQLFormatadoSaldos(Var strInfo: String; Var recSaldos: TGuiaSaldos; blnQueryFiltros: Boolean);

      Procedure pSetSQLFil(value: String);

      Procedure pIncluiParametroLimits;

      Procedure pLiberaSelectCheckList;

      Procedure pIncluiExprVisibilParametro(strNomPar, strExpressao: String);
      Procedure pAvaliaVisibilidadeCategoria(rowDado: TcxEditorRow);
      Procedure pAvaliaExprVisibilParametro(strNomPar: String);

      Procedure pIncluiSQLVisibilParametro(strNomPar, strSQL: String);
      Procedure pIncluiEmpConfigParametro(strNomPar, strEmp: String);

      procedure pComboChange(Sender: TObject);

      procedure pComboChangeInventario(Sender: TObject);
      procedure pComboChangeEstExt(Sender: TObject);
      procedure pComboChangeGatilho(Sender: TObject);

      Procedure pSalvaMultiSelecaoCustomCheckList;

      Procedure pInicializaLargura;
      Procedure pIncrementaLargura;

      function  fGetNomeTabelaTemporaria(strNome: String): String;

      Procedure pAtualizaCamposOrderBy;
      Procedure pBeforePostCampos(dataSet: TDataSet);
      Procedure pBeforeEditCampos(dataSet: TDataSet);

      Procedure pBeforeEditParams(dataSet: TDataSet);
      Procedure pBeforePostParams(dataSet: TDataSet);
      Procedure pAfterScrollParams(dataSet: TDataSet);

      Procedure pBeforePostGrupoParams(DataSet: TDataSet);

      Procedure pSetaFiltroGrupoParametro(strTipGru: String);
      Procedure pRestauraFiltroGrupoParametro;

      Procedure pSetaDataType(qryDados: TUniQuery);

      Procedure pIncluiFiltroGrid;

      Procedure pIncluiExprVisibilParametrosAutomaticos;
      Procedure pInicializaParametrosAutomaticos;


      Procedure pCriaCategoriaGeracao;

      Function fCriaCategoriaFixos(strGrupo: String): TcxCategoryRow;

      procedure pButtonClickDirectory(Sender: TObject; AButtonIndex: Integer);

  //    procedure pInitPopup(Sender: TObject);

      Function fParametroVisivel(strSQLVis: String; blnComParametros: Boolean; cdsParams: TUniClientDataSet): Boolean;

      Function fGetComFilComplementos: String;

      Function fComFilToName(strNome: String): String;

      Function fGetDadosCustomCheckList: TUniQuery;

      Function fGetCustomCheckList(strNomPar: String): TSelectCheckList;

      Procedure pSetComFilComplementos(Const Value: String);

      Procedure pLiberaTabelaSaldos;

      Procedure pSetaParametrosReadOnly;
      Procedure pSetaParametrosInvisiveis;

      Procedure pHabilitaDatasGatilho(strNomPar, strValPar: String);
      Function fRetornaDataGatilho(strGatilho: String; Var strDatGat: String; blnInicial: Boolean): Boolean;

      Procedure pSetSQL(Const Value: String);
      Procedure pCalculaTamanhoColunas;
      Procedure pLimpaTelaFiltros;
      Procedure pIncluiComboDestinoRelatorio;
      Procedure pIncluiPastaGravacao;
      Procedure pIncluiImagemCabecalho;

      Procedure pIncluiPaginaInicial;
      Procedure pAjustaIndicesCombo;

      Procedure pAjustaIndice(Var FIndex: TIndexTabelaDinamica; strNomeRow: String; intIndex: Integer);

      Procedure pIncluiComboComposicaoCusto;
      Procedure pIncluiComboInventario(intTabela: Integer);

      Procedure pIncluiComboGatilhoPeriodo(crwCategoria: TcxCategoryRow; strParIni: String);

      Procedure pIncluiComboEstExt(intTabela: Integer);
      Procedure pIncluiComboEstEnt(intTabela: Integer);
      Procedure pIncluiComboEstEnv(intTabela: Integer);
      Procedure pIncluiComboSALINV(intTabela: Integer);
      Procedure pIncluiComboCTR_;
      Procedure pIncluiComboLote(intTabela: Integer);
      procedure pCarregaComposicaoCusto(Var strDescricao, strValorPadrao: String);
      Procedure pSetaParFloat(intIndice, intDecimais: Integer);
      Procedure pSetaParInteger(intIndice: Integer);
      Procedure pSetaParDate(intIndice: Integer);
      Procedure pSetaParDiaMes(intIndice: Integer);
      Procedure pSetaParConPag(intIndice: Integer);
      Procedure pSetaParCPF(intIndice: Integer);
      Procedure pSetaParCNPJ(intIndice: Integer);
      Procedure pSetaParEspDoc(intIndice: Integer);
      Procedure pSetaParMesAno(intIndice: Integer);
      Procedure pSetaParAno(intIndice: Integer);
      Procedure pSetaParLotOP(intIndice: Integer);
      Procedure pSetaParPlaVei(intIndice: Integer);
      Procedure pSetaParHoraMinSec(intIndice: Integer);
      Procedure pSetaParCheckBox(intIndice: Integer);

      Procedure pSetaParDirectory(intIndice: Integer);

      Procedure pSetaParComboBox(intIndice: Integer; facInterface: TTipoInterface);
      Procedure pSetaParTabelaPreco(intIndice: Integer);
      Procedure pSetaParTabelaPrecoLista(intIndice: Integer);
      Procedure pSetaParCustomCheckList(intIndice: Integer);

  //    procedure pCheckAllItems(Sender: TObject; AButtonIndex: Integer);

      procedure pClickCheck(Sender: TObject; ItemIndex: Integer; var AllowToggle: Boolean);
      procedure pClickCustomCheckList(Sender: TObject; ItemIndex: Integer; var AllowToggle: Boolean);
      Procedure pIncluiParametro(strNomPar: String; intLast, intQueries, intIndice: Integer; qryParam: TUniQuery; intOriPar: Integer);
      Procedure pSetaParRadioGroup(intIndice: Integer);
      Procedure pSetaParString(intIndice: Integer);
      Procedure pSetaParDocumento(intIndice: Integer);
      procedure pFiltrosButtonClick(Sender: TObject; AButtonIndex: Integer = 0);
      procedure pFiltrosValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
      Procedure pSetaParamsObrigatorios;
      procedure pGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);

      procedure pRestauraValores;
      Procedure pMarcaAnteriores;
      Procedure pDesmarcaPosteriores;
      Procedure pInicializaScript(fscScript: TfsScript; Var strExpressao: String);
      Procedure pInicializaScriptParametro(fscScript: TfsScript; Var strExpressao: String);
      Procedure pCriaTiposDeBanda;
      Procedure pCarregaQueriesComFil;

      Procedure pAtualizaTelaComFil(strSQL: String; blnLimparValor: Boolean);

      Function fSQLColunhasPorLinha: String;
      Function fSQLParamametrosAutomaticos: String;
      Function fCarregaParametrosAutomaticos(strSeqGer: String): Boolean;
      Procedure pIncluiParametroAutomatico(strNomPar, strDesPar: String);
      Function fUsaParametroAutomatico(strNomPar: String): Boolean;
      Function fUsouTabelaDinamica(FTemTabela: TTemTabelaDinamica; strInicio, strNomPar: String): Boolean;

      Function fSQLParamametrosGatilho: String;
      Procedure pIncluiParametroGatilho(strParIni, strParFin, strDesPar, strGruFil: String);
      Function fCarregaParametrosGatilho(strSeqGer: String): Boolean;
      Procedure pAtualizaParametrosGatilho;

      Function fSQLCamposRodape: String;

      Procedure pCriaConexaoRelatorio(AConexaoRelatorio: TCriarConexao; AConexaoIndependente: Boolean);
      Procedure pDisconectaConexaoRelatorio;
      Procedure pValidarConexaoRelatorio;

      Function fPedePastaTrace: Boolean;

      Procedure pSetaListaCheckListCustomizado(strNomPar: String; qryDados: TUniQuery);

      Function fRetValParSimples(strValPar: String): String;

      Function fExecutaThread(qryDados: TUniQuery; cdsDados: TUniClientDataSet;
                              cxProgress: TcxProgressBar; blnExec: Boolean): Boolean;

      Procedure pAdicionaArquivoPontoImpressao(intQuerie: Integer);

    public
      stlVeVerDesc: TStringList;
      stlVeVerHint: TStringList;

      objParametrosRelatorio: TParametrosRelatorio;

      desDestinoGrid: TDestinoRel;

      cdsGatPer: TZClient;

      dicQueryTag: TDictionary<TUniQuery, Integer>;

      objRotinasGrid,
      objRotinasFiltro: TRotinasGrid;

      intIndexGrid: Integer;
      strFiltroGrid: String;
      blnImpressaoGrid,
      blnApagaTemporarias: Boolean;

      stlArquivos :TStringList;
      stlGerarSeVazio :TStringList;
      FArquivosPontoImpressao: TArrArquivoPontoImpressao;

      FTabelasTemporarias: TArrTemporarias;

      recDadosPai: TRecDadosPai;

      frmRelatorio: TForm;
      frmPedeDados: TForm;

      blnConexaoIndependente,
      blnExecutouSemErro,
      blnTemDados,
      blnValidacao,
      blnCarregarCamposAuto,
      blnCarregarCamposManual,
      blnImprimirVazio: Boolean;

      blnExecutandoPeloMenu,
      blnApenasPrincipal,
      blnTemArquivoSaida: Boolean;

      cdsCamposRodape,
      cdsColunasPorLinha,
      cdsProporcaoPorLinha,
      cdsParametrosAutomaticos,
      cdsParametrosGatilho: TZClient;

      arrParametrosReadOnly: TArrString;

      strScriptImplementation: String;
      blnExibirMensagem : Boolean;
      blnRetornoDados: Boolean;
      blnApenasEditarFiltros: Boolean;
      blnGerarLinhaComando: Boolean;
      blnUsuarioLogadoDefaultVerdeVermelho: Boolean;
      blnEditarGatilho: Boolean;
      blnApenasSalvar: Boolean;

      blnMostrarProgresso,
      blnDestinoJson: Boolean;
      fecharJanelaDeDadosAoImprimir: Boolean;
      HndSelPedidoCompra: THandle;

      strJson: String;
      strUrlGrafico: String;

      desDestinoInicial: TDestinoRel;

      objRelatorioRetorno: TRetornoRelatorio;

      constructor Create(AOwner: TComponent;
                         AExecutandoPeloMenu: Boolean;
                         AConexaoRelatorio: TCriarConexao;
                         AConexaoIndependente: Boolean;
                         AApenasPrincipal: Boolean = False;
                         ATabelaFiltrosValores: string = 'CADVAL';
                         AArquivoSaidaDiretoPDF: string = '';
                         APathImagemCabecalho: string = '';
                         AExecutaRelatorioValidacao: Boolean = True);  Reintroduce;

      destructor Destroy; override;

      Class Function fExisteCadVal(strSeqGer, strNomPar, strCodOpe, strTabela: String): Boolean;
      Class Function fSQLInsertCadVal(intContador: Integer; strTabela: String): String;
      Class Function fSQLUpdateCadVal(intContador: Integer; strTabela: String): String;

      procedure pCheckListCloseUp(Sender: TObject);

      Procedure pCopiaCampoRodape(cdsOrigem, cdsDestino: TZClient);
      procedure pExcluiCampoRodape;
      procedure pIncluiCampoRodape(strNomCam, strCampoReferencia: String; intPosicao: Integer);
      Procedure pDecOrdemRodape(cxvRodape: TcxGridDBTableView);
      Procedure pIncOrdemRodape(cxvRodape: TcxGridDBTableView);
      Function fValidaOrdemCamposRodape: Boolean;

      Function fExtraiCamposTemplate(strTexto: String; Var Campos: TArray<string>): Boolean;
      Function fVerificaCamposTemplate(strTexto: String): Boolean;

      Procedure pRefazConexaoRelatorio(AConexaoIndependente: Boolean);

      Function fNomeToIndexTabelaDinamica(strNome: String): Integer;

      Function fLeDados: Boolean;
      Function fLeDadosSQL: string;

      Function fValidaParametroFinal: Boolean;

      Function fCarregaColunhasPorLinha: Boolean;
      Procedure pAjustColunhasPorLinha(intNumLin: Integer);
      Procedure pSalvaColunhasPorLinha;
      Function fValidaColunhasPorLinha: Boolean;

      Procedure pAtualizaCamposParametros;

      Procedure pDecOrdemFiltro(cxvParams: TcxGridDBTableView);
      Procedure pIncOrdemFiltro(cxvParams: TcxGridDBTableView);

      Procedure pDecOrdemComplementar(cxvParams: TcxGridDBTableView);
      Procedure pIncOrdemComplementar(cxvParams: TcxGridDBTableView);

      Procedure pSetaTRANSACTIONISOLATION;

      Procedure pFiltraGrupoParametro(strTipGru: String);

      Procedure pAjustaQuebras;

      Procedure pPedeDados(blnExecutarDireto: Boolean = False;
                           blnLimpaFiltros: Boolean = False); overload;

      Procedure pPedeDados(blnExecutarDireto: Boolean;
                           blnLimpaFiltros: Boolean;
                           var AModalResult: TModalResult); overload;

      Function fPedeDados(blnExecutarDireto: Boolean = False; blnLimpaFiltros: Boolean = False; const blnRetornarErro : Boolean = True): string;

      Function fCarregaParametrosExcecucao: Boolean;

      Procedure pPedeDadosInterface;
      Function fGeraTitulosFiltros(blnFiltraImpFil: Boolean = False): Boolean;

      Procedure pPedeDadosParametrosAutomaticos(strNomPar: String);

      Procedure pCarregaParametrosValidacao;

      Procedure pAvaliaComboBoxConfig(strNomPar: String);

      Procedure pAvaliaSQLVisibilParametro(strNomPar: String);

      Function fRetornaComboBoxConfig(var strValorConfig: String; strEmpCfg: String; cdsParams: TUniClientDataSet; rowDado: TcxEditorRow): Boolean;

      Procedure pAvaliaCheckListCustomizado(strNomPar: String);

      Function fEhParametroAutomatico(strNomPar: String): Boolean;

      Function fEhParametroGatilho(strNomPar: String): Boolean;

      Function fEhCampoGatilho(strNomPar: String): Boolean;

      Procedure pMoldura(blnDeixarEspacoEntreCampos: Boolean);
      Procedure pCriaComponentes;
      Procedure pAtualizaLarguraCampo;

      Procedure pPedeDadosCampo(blnDestinoDashboard: Boolean);
      Procedure pCarregaParametrosFuncao(strFuncao: String);
      Procedure pRetornaParametrosFuncao;

      Procedure pKeyPress(Var Key: Char);
      procedure pKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

      Procedure pLimpaMultiSelecao(rowFiltro: TcxCustomRow);

      Procedure pCarregaQueriesComplentares(blnAlimentaArrays: Boolean);
      Procedure pCarregaQueriesCompRecursiva(var intQueries: Integer; strMaster, strComple, strNomCam, strCamLig: string; blnAlimentaArrays, blnCompPri, blnChild: Boolean);

      Function fTemCampoEditavelComplemento(strComple: String): Boolean;
      Function fTemCampoEditavel(intRelatorio: Integer): Boolean;

      Procedure pSetaEditavel;

      Procedure pLiberaQueriesComplentares;

      Procedure pLiberaQueriesComFil;

      Procedure pCarregaSistemaVerdeVermelho;

      Procedure pLimpaParametrosExcluidos;

      Procedure pApagaCadVal(strSeqGer: string);

      Function fGetNomeColunaCheckList(strNomCol: String; blnQuoted: Boolean = False): String;

      Function fTrocaBrancoNomeColunaCheckList(strEspressao: String): String;

      Function fGeraNomesTemporarias(strSQL: String): String;

      Function fAchaTemporaria(strNomeRelatorio: String): Boolean;

      Function fRetornaTabelaDadosNome(intContador: Integer): String;

      Procedure pDropTemporarias;

      Function fGetListaTemporarias: String;

      Procedure pCarregaTemporarias(strTemporarias: String);

      Function fMudaParaRetrato: Boolean;

      Function fRetColunasDados: Integer;

      Procedure pInicializaIndexTabelasDinamicas;

      Function fPedeImagemCabecalho: Boolean;

      Function fMontaFiltros: Boolean;

      Function fMontaFiltrosExecucao: Boolean;

      Function fValidaCfgSis(strExpressao: String): String;

      Function fRetornaMesAnoPersonalizado(strExpressao: String): String;

      Function fRetornaValorVar(strParam: string; blnQuoted: Boolean): String;

      Function fRetornaValorVariavel(strExpressao: String; blnQuoted: Boolean = True): String;

      Function fValidaStrQuebra(strExpressao, strQuebra: String): String;

      Function fValidaRetTabela(strExpressao: String; blnExecucao: Boolean; strTabelaRetorno: string; intQuerie: Integer): String;

      Function fValidaFCampoExiste(strExpressao: String): String;
      Function fValidaFObjetoExiste(strExpressao: String): String;

      Class Function fTrataDesCam(strDesCam: String): String;

      Class Function fGetSimbolAtCursor(mmoText: TBCEditor{TDBMemoFocus}): String;

      Class Procedure pMostraTemplateMemo(mmoText: TBCEditor {TDBMemoFocus});

      Class Procedure pAddSimbolsTemplate(Lines: TStrings);
      Class Procedure pAddSimbolsInstrucao(Lines: TStrings);

      Class procedure pCarregaDireitosMenu(frmGravando: TfrmGravando; blnOrdena: Boolean);

      Class Function fExisteSimboloTemplate(strCodigo, strSimbol: String): Boolean;
      Class Function fGetTemplateSQL(SelfTela: TForm; intColuna: Integer): String;
      Class Function fGetInstrucaoSQL(SelfTela: TForm; intColuna: Integer): String;
      Class Function fGetTemplateSQLToMemo(SelfTela: TForm; mmoText: TBCEditor {TDBMemoFocus}): String;
      Class Function fGetInstrucaoSQLToMemo(SelfTela: TForm; mmoText: TBCEditor {TDBMemoFocus}): String;

      Class Procedure pAjustaEditorSQL(bceDefSQL: TBCEditor);

      Procedure pExcluiGrupoParametro;
      Procedure pInsereNovoGrupo(strGrupo: String; blnParam, blnSilencioso: Boolean);

      Function fRetDestino: TDestinoRel;
      Function fVeSeExecutaComFil(strNomPar: String; blnShow: Boolean = False): Boolean;
      Function fVeSeExecutaComFilShow: Boolean;

      Procedure pAvaliaParametrosShow;

      Function fCompilaExpressao(strExpressao, strTitulo: String; blnParametro: Boolean = False; blnSilencioso: Boolean = False): Boolean;

      Function fPodeQuebrar(strNomCam: String): Boolean;
      Function fLargurasOk: Boolean;
      Function fRetQuebras(blnCombo: Boolean = False): String;
      Function fVerificaParametrosFuncoes: Boolean;
      Function fCarregaParametros(strSeqGer, strComFil: String): Boolean;
      Function fCarregaGruposParametros(strSeqGer: String): Boolean;
      Function fCarregaCampos(strSeqGer: String): Boolean;
      Function fCarregaCamposRodape(strSeqGer: String): Boolean;
      Function fCarregaChilds(strSeqGer: String): Boolean;
      Function fCarregaComplementos(strSeqGer: String): Boolean;

      Procedure pCompCarregaComplementosChilds;

      Function fCarregaHistoricos(strChave: String): Boolean;
      Function fCarregaDirAcesso(strSeqGer: String): Boolean;
      Function fRetRowDado(strNomPar: String): TcxEditorRow;

      Function fTiraEspacosMemo(strInfo: String): String;

      Function fPaginaInicial: Integer;

      Function fGetValorParametro(strNomPar: String;
                                  Var blnAchou: Boolean;
                                  blnTiraMascara: Boolean = True;
                                  blnMesmoInvisivel: Boolean = False): String;

      Function fGetValorParametroRotinasGrid(strNomPar: String;
                                             Var blnAchou: Boolean;
                                             Var blnMultiSelecao: Boolean;
                                             blnTiraMascara: Boolean = True;
                                             blnMesmoInvisivel: Boolean = False): String;

      Function fGetTipoInterface(strTipo: String): TTipoInterface;
      Function fGetTipoConfig(strTipo: String): TTipoConfig;

      Class Function fInsereDireitoNoMenu(strCodDir, strNomDir: String): Boolean;
      Class Function fPodeExcluirDireito(strCodDir: String): Boolean;

      Function fCriaHorizo(intQuerie: Integer): Boolean;
      Function fCriaHorizoLines(intQuerie: Integer): Boolean;

      Function fSalvaParametros(strSeqGer: String): Boolean;
      Function fSalvaParametrosAutomaticos(strSeqGer: String): Boolean;
      Function fSalvaParametrosGatilho(strSeqGer: String): Boolean;
      Function fSalvaGruposParametros(strSeqGer: String): Boolean;
      Function fSalvaCampos(strSeqGer: String): Boolean;
      Function fSalvaComplementos(strSeqGer: String): Boolean;
      Function fSalvaChilds(strSeqGer: String): Boolean;
      Function fSalvaHistoricos(strChave: String): Boolean;
      Function fSalvaDirAcesso(strSeqGer: String): Boolean;

      Function fAbreConsultaCampos: Boolean;
      Function fAbreConsultaCamposPrg(prgProgresso: TcxProgressBar): Boolean;

      Function fTemCampoPreCusSemAlias(qryFiltro: TUniQuery): Boolean;
      Function fRetPreCusTeste: String;
      Function fTemCampoCusto(strMessage: String): Boolean;

      Function fGetQtdCamListados(intLinha: Integer): Integer;
      Function fGetLarguraUsada(intLinha: Integer): Double;
      Function fPodeHorizontalizar(blnMultLines: Boolean): Boolean;

      Function fIncluiComplemento(strCodCom, strSeqGer: String): Boolean;
      Function fIncluiChild(strCodChi, strSeqGer: String): Boolean;
      Function fIncluiHistorico(strTitulo, strDescri, strChave: String): Boolean;
      Function fIncluiDirAcesso(strCodDir, strSeqGer: String): Boolean;
      Function fAlteraHistorico(strTitulo, strDescri: String): Boolean;
      Function fExcluiComplemento: Boolean;
      Function fExcluiTodosComplementos: Boolean;
      Function fExcluiChild: Boolean;
      Function fExcluiTodasChild: Boolean;
      Function fExcluiHistorico: Boolean;
      Function fExcluiDirAcesso: Boolean;

      Function fPrecisaRefazerFr3: Boolean;

      Function fMontaListaRel: String;

      Function fRetornaNomeGrupo(strCodGru, strTipGru: String; Var strNomGru: String): Boolean; overload;

      Function fRetornaNomeGrupo(strCodGru, strTipGru: String; Var strNomGru: String; Var intTipBan: Integer): Boolean; overload;

      Class Function fRetDescricaoParametros: String;
      Class Function fRetDescricaoInterface: String;
      Class Function fRetDescricaoConfig: String;
      Class Function fRetDescricaoTotalizadores: String;
      Class Function fRetDescricaoMascara: String;
      Class Function fRetDescricaoFuncoes: String;
      Class Function fParametroBasico(strTipPar: String): Boolean;
      Class Function fDescMascaraToTipo(strMascara: String): TMascara;
      Class Function fDescFuncaoToTipo(strFuncao: String): TFuncaoAutcom;
      Class Function StrToFont(strFont: string; fonFont: TFont = Nil): TFont;
      Class Function FontToStr(fntFont: TFont): string;
      Class Function fRetornaFontTag(fntFont: TFont; strTag: string): string;

      Class Procedure pInsereDirMenu(mnuRelatorio: TMenuItem; strCodDir, strNomDir: String; blnOrdena: Boolean=True);
      Class procedure pExcluiItemMenu(strCodDir: String);

      Function fValidaSQL(strSQL: String; blnVazioOk: Boolean;
                          blnExecute: Boolean = False;
                          blnMarcarSQLErro: Boolean = True;
                          intNroCols: Integer = -1;
                          strMsgErro: String = ''): Boolean;

      Function fValidaQueryValidacao(qryDados: TUniQuery): Boolean;

      Function fGetDataSet(intQuerie: Integer): TDataSet;

      Function fExecutaRelatorio: Boolean;

      Function fSalvarFiltrosRelatorio: Boolean;

      Function fVerificaRelatorioValidacao: Boolean;

      Function fValidaDado(intIndex: Integer): Boolean;

      Function fGetAlturaTela: Integer;
      Function fGetLarguraTela: Integer;

      Function fGetAlturaGrid: Integer;
      Function fGetLarguraGrid: Integer;

      Function fGetValueWidth: Integer;
      Function fGetRowHeaderWidth: Integer;

      Function fDesmarcandoTabela(strMarcadas: String; intIndice: Integer): Boolean;

      Procedure pCarregaLargura;

      Procedure pSetValueWidth(Value: Integer);
      Procedure pSetRowHeaderWidth(Value: Integer);

      Procedure pSetAlturaTela(Value: Integer);
      Procedure pSetLarguraTela(Value: Integer);

      Procedure pSetAlturaGrid(Value: Integer);
      Procedure pSetLarguraGrid(Value: Integer);

      Procedure pAjustaTipoDeInterface;

      procedure pSalvaValores(strAutInc: String; blnValoresValidacao: Boolean = False);

      procedure pExportaFiltros;
      procedure pImportaFiltros;

      Function fInsereLoteNovoGrupo: Boolean;
      Function fInsereLoteNovoGrupoProgresso(Progress : TcxProgressBar): Boolean;

      procedure pReplicaFonteOutrosCampos;
      procedure pReplicaExpImpOutrosFiltros;
      procedure pLimpaFonteTodosCampos;

      Class Function fDestinoToTipo(strDescricao: String): TDestinoRel;

      Function fCarregaProporcao: Boolean;

      Function fCriaQueryRelarorio(AOwner: TComponent = Nil): TUniQuery;

      Procedure pInicializaTabelasDinamicas;

      Procedure pCriaClientDados(intRelatorio: Integer);

      Procedure pCriaClientDadosPersonalizado(intRelatorio: Integer);      

      procedure pGravaLogPaf(strSucesso, strResultado: String);

      procedure pGravaLogExecucao(strResultado: String);

      Function fGetLinhaComando: String;

      Function fExisteComplementos: Boolean;

      Function fExisteChild: Boolean;

      Procedure pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp: String);

      Function fVerificaDashboarQuebra(blnDestinoDashboard: Boolean): Boolean;

      Function fRetornaFilaMeta: String;
      Function fRetornaFileMetaOficial: Boolean;

      Function fRetornaUrlGrafico: String;

    published

      Property strCodPai: String read FCodPai write pSetCodPai;

      Property strSQLFil: String read FSQLFil write pSetSQLFil;

      Property blnExecutaPelaInterface: Boolean Read FExecutaPelaInterface Write FExecutaPelaInterface;

      Property strTipFacAnterior:   String Read FTipFacAnterior;
      Property strTipoSomaAnterior: String Read FTipoSomaAnterior;

      Property strTitulo: String Read FTitulo Write FTitulo;
      Property strSubTitulo: String Read FSubTitulo Write FSubTitulo;
      Property stlTituloFiltros: TStringList Read FTituloFiltros;

      Property stlLimits: TStringList Read FLimits;

      Property stlNomeColunaHorizo: TStringList Read FNomeColunaHorizo;

      Property strSQL   : String Read fGetSQL Write pSetSQL;

      Property conConexaoRelatorio: TCriarConexao Read FConexaoRelatorio;

      Property arrSQLFormatado: TArrString Read FSQLFormatado;

      Property cdsParams: TZClient       Read FParams       Write FParams;
      Property cdsGruposParams: TZClient Read FGruposParams Write FGruposParams;

      Property objConsultasGrid: TConsultasGrid Read FConsultasGrid Write FConsultasGrid;

      Property cdsCampos: TZClient       Read FCampos       Write FCampos;
      Property cdsComplementos: TZClient Read FComplementos Write FComplementos;
      Property cdsChilds: TZClient       Read FChilds       Write FChilds;
      Property cdsHistoricos: TZClient Read FHistoricos Write FHistoricos;
      Property cdsDirAcesso: TZClient Read FDirAcesso Write FDirAcesso;

      Property cdsLinhas: TZClient Read FLinhas Write FLinhas;

      Property objGeraFr3: TGeraFR3 Read FGeraFR3 Write FGeraFR3;

      Property blnSQLErro: Boolean Read FSQLErro Write FSQLErro;

      Property strIdentRel: String Read FIdentRel Write FIdentRel;

      Property arrCadRel: TArrQuery Read FCadRel Write FCadRel;
      Property arrControleRel: TArrControleRel Read FControleRel Write FControleRel;

      Property intAlturaTela: Integer  Read fGetAlturaTela  Write pSetAlturaTela;
      Property intLarguraTela: Integer Read fGetLarguraTela Write pSetLarguraTela;

      Property intAlturaGrid: Integer  Read fGetAlturaGrid  Write pSetAlturaGrid;
      Property intLarguraGrid: Integer Read fGetLarguraGrid Write pSetLarguraGrid;

      Property intValWid: Integer  Read fGetValueWidth      Write pSetValueWidth;
      Property intHeaWid: Integer  Read fGetRowHeaderWidth  Write pSetRowHeaderWidth;

      Property scrLinhas: TScrollBox Read FscrLinhas Write FscrLinhas;
      Property imgFundo: TImage Read FimgFundo Write FimgFundo;

      Property objConsulta: TConsultasRel Read FConsulta;

      Property cdsTiposBanda: TZClient Read FTiposBanda;

      Property strComFilComplementos: String Read fGetComFilComplementos Write pSetComFilComplementos;

      Property arrSelectCheckList: TArrSelectCheckList Read FArrSelectCheckList;

      Property arrArquivosPontoImpressao: TArrArquivoPontoImpressao Read FArquivosPontoImpressao;

      Property Dados: TArrQuery Read FQueryDados;

      Property strTabelaFiltrosValores: string Read FTabelaFiltrosValores;

      Property blnFr3Gerado: Boolean Read FFr3Gerado Write FFr3Gerado;

      Property strListaGatilhos: String Read fGetListaGatilhos Write FListaGatilhos;

      Property strLinhaComando: String Read fGetLinhaComando;

      Property intIndexDestino: Integer Read FIndexDestino;

      Property strDadosJsonEnviaWhatsapp: String Read FDadosJsonEnviaWhatsapp Write FDadosJsonEnviaWhatsapp;
  end;

implementation

Uses
  Messages,
  Windows,
  cxStyles,
  cxEdit,
  cxClasses,
  cxCustomData,
  cxCalendar,
  cxTimeEdit,
  cxCurrencyEdit,
  cxGridCustomView,
  cxTextEdit,
  cxRadioGroup,
  cxDropDownEdit,
  cxCheckComboBox,
  cxMaskEdit,
  cxButtonEdit,
  cxGrid,
  cxLookAndFeelPainters,
  cxDBLookupComboBox,
  cxInplaceContainer,
  untPedeDadosRelatorio,
  untPedeDadosInterface,
  untPedeDadosInterfaceAutomatico,
  untPedeDadosCampo,
  untMsgErroSQL,
  untPrincipal,
  untConsultas,
  untCadTemplates,
  untITintasDeMaquina,
  untFuncTinta,
  FileCtrl,
  untRelatorio,
  untThreadRelatorio,
  untFatGerarTabelasParaRelatorio,
  untTFatReservaSaldo,
  untTFatEntregaFutura,
  untVersaoProg,
  untSQLBind_Query,
  Dialogs,
  Json,
  untFuncoesGenerica;

Const
  STR_INDENT_TP = 'TP_';
  STR_INDENT_IA = 'IA_';

  arrPassos: Array[1..4] Of Char = ('/', '—', '\', '|');

  STR_INFORMAR_PERIODO =  'Informar período';

  STR_SELECT_PRINCIPAL = '/*SELECT PRINCIPAL*/';

  MAX_TAMANHO_COMPLETO_STRING = 13;

  STR_ARQUIVO_SAIDA    = 'ARQUIVO_SAIDA';
  STR_GATILHO_WHATSAPP = 'GATILHO_WHATSAPP';
  STR_GATILHO_EMAIL    = 'GATILHO_EMAIL';
  STR_GATILHO_ASSUNTO  = 'GATILHO_ASSUNTO';
  STR_GATILHO_CORPO    = 'GATILHO_CORPO';

  STR_TABELA_I_     = 'VS_TABELA_I_';
  STR_ESTEXT_       = 'VS_ESTEXT_';
  STR_TABELA_SALINV = 'VS_TABELA_SALINV';
  STR_TABELA_CTR_   = 'VS_TABELA_CTR_';
  STR_TABELA_PCG_   = 'VS_TABELA_PCG_';
  STR_TABELA_CAR_   = 'VS_TABELA_CAR_';
  STR_TABELA_CTP_   = 'VS_TABELA_CTP_';
  STR_TABELA_CHQ_   = 'VS_TABELA_CHQ_';
  STR_TABELA_FDO_   = 'VS_TABELA_FDO_';
  STR_TABELA_PCD_   = 'VS_TABELA_PCD_';
  STR_TABELA_FGO_   = 'VS_TABELA_FGO_';
  STR_TABELA_L_     = 'VS_TABELA_L_';
  STR_ESTENV_       = 'VS_ESTENV_';
  STR_ESTENT_       = 'VS_ESTENT_';

  STR_RET_TABELA_I_      = 'VS_RET_TABELA_I_';
  STR_RET_TABELA_SALINV_ = 'VS_RET_TABELA_SALINV_';

  STR_F_CAMPO_EXISTE = 'FCAMPOEXISTE';
  STR_F_OBJETO_EXISTE = 'FOBJETOEXISTE';

  STR_PRECUS = 'VS_FLTPRECUS';
  STR_LITGAL = 'VS_FLTLITGAL';
  STR_CLACOM = 'VS_STRCLACOM';
  STR_CLAVEN = 'VS_STRCLAVEN';
  STR_CLADEV = 'VS_STRCLADEV';
  STR_CODEMP = 'VS_STRCODEMP';
  STR_MESATU = 'VS_STRMESATU';
  STR_DESTINO = 'VS_STRDESTINO';
  STR_TIPO_TOT = 'VS_STRTIPOTOT';
  STR_QUEBRA = 'VS_STRQUEBRA';
  STR_LOGINUSUARIOLOGADO = 'STR_LOGINUSUARIOLOGADO';
  STR_EMPACESSOUSUARIOLOGADO = 'STR_EMPACESSOUSUARIOLOGADO';
  STR_CLIFIL = 'VS_STRCLIFIL';
  STR_FORFIL = 'VS_STRFORFIL';
  STR_SUBSTITUICAO = 'VS_STRSUBSTITUICAO';

  STR_CHARSENHA = 'VS_STR_CHAR_SENHA';
  STR_CHARTROCA = 'VS_STR_CHAR_TROCA';

  STR_VERSAO_EXE = 'VS_STR_VERSAO_EXE';
  STR_RELEASE_EXE = 'VS_STR_RELEASE_EXE';

  INTTAMDOCCADREC = 'VS_INTTAMDOCCADREC';

  STR_CLAFIS_BR             = 'VS_STRCLAFIS_BR';
  STR_CLAFIS_BR_ENT         = 'VS_STRCLAFIS_BR_ENT';
  STR_CLAFIS_ENTFUT_VEN     = 'VS_STRCLAFIS_ENTFUT_VEN';
  STR_CLAFIS_ENTFUT_VEN_ABR = 'VS_STRCLAFIS_ENTFUT_VEN_ABR';

  STRIMOBILIARIAS  = 'VS_STRIMOBILIARIAS';
  STRINDUSTRIAIS   = 'VS_STRINDUSTRIAIS';
  STRAUTOMOTIVAS   = 'VS_STRAUTOMOTIVAS';
  // Essa variável retorna a opção selecionada na rotina de CRM - (CLIENTE/PROSPECAO)
  I_STR_CRM_TIP_PC = 'VS_CRM_TIP_PC';
  STRCLAFISREGISTRADOECF = 'VS_CLAFIS_REGISTRADO_ECF';

  CSFSBOLD      = '|fsBold';
  CSFSITALIC    = '|fsItalic';
  CSFSUNDERLINE = '|fsUnderline';
  CSFSSTRIKEOUT = '|fsStrikeOut';

  TMP_GARANTIA                = 'tmpGARANTIA';
  TMP_EXTERNO                 = 'tmpEXTERNO';
  TMP_PEDIDO_VENDA            = 'tmpPEDIDO_VENDA';
  TMP_PEDIDO_BAIXA_ENTFUT     = 'tmpPEDIDO_BAIXA_ENTFUT';
  TMP_ENDERECAMENTO           = 'tmpENDERECAMENTO';
  TMP_ORDEM_PRODUCAO          = 'tmpORDEM_PRODUCAO';
  TMP_TRANSF_ANDAMENTO        = 'tmpTRANSF_ANDAMENTO';
  TMP_ENTREGA_FUTURA_PREVISAO = 'tmpENTREGA_FUTURA_PREVISAO';
  TMP_ENTREGA_FUTURA_FALTA    = 'tmpENTREGA_FUTURA_FALTA';
  TMP_ENTREGA_FUTURA_AGUARDA  = 'tmpENTREGA_FUTURA_AGUARDA';

constructor TInterfaceRelatorio.Create(AOwner: TComponent;
                                       AExecutandoPeloMenu: Boolean;
                                       AConexaoRelatorio: TCriarConexao;
                                       AConexaoIndependente: Boolean;
                                       AApenasPrincipal: Boolean = False;
                                       ATabelaFiltrosValores: string = 'CADVAL';
                                       AArquivoSaidaDiretoPDF: string = '';
                                       APathImagemCabecalho: string = '';
                                       AExecutaRelatorioValidacao: Boolean = True);
begin
  inherited Create(AOwner);

  objParametrosRelatorio := Nil;

  dicQueryTag := TDictionary<TUniQuery, Integer>.Create;

  objRelatorioRetorno := Nil;

  blnDestinoJson := False;
  blnMostrarProgresso := True;

  strJson := '';

  blnImpressaoGrid := False;
  strFiltroGrid := '';

  FExecutarDireto := False;

  blnApagaTemporarias := True;

  pCriaConexaoRelatorio(AConexaoRelatorio, AConexaoIndependente);

  FTabelaFiltrosValores := ATabelaFiltrosValores;
  FArquivoSaidaDiretoPDF := AArquivoSaidaDiretoPDF;
  FPathImagemCabecalho   := APathImagemCabecalho;
  FExecutaRelatorioValidacao := AExecutaRelatorioValidacao;

  SetLength(FTabelasTemporarias, 0);

  stlArquivos := TStringList.Create;
  SetLength(FArquivosPontoImpressao, 0);

  stlGerarSeVazio := TStringList.Create;

  Fillchar(recDadosPai, SizeOf(recDadosPai), #0);

  cdsParametrosAutomaticos := TZClient.Create(Self, fSQLParamametrosAutomaticos);
  cdsParametrosAutomaticos.IndexFieldNames := 'PAR_NOMPAR';

  cdsParametrosGatilho := TZClient.Create(Self, fSQLParamametrosGatilho);
  cdsParametrosGatilho.IndexFieldNames := 'PARINI';

  cdsCamposRodape := TZClient.Create(Self, fSQLCamposRodape);
  cdsCamposRodape.AfterPost  := pAfterPostCamposRodape;
  cdsCamposRodape.BeforePost := pBeforePostCamposRodape;
  cdsCamposRodape.pCriaSoma('CAM_ORDROD', 'MAX_ORDROD', 'MAX(CAM_ORDROD)');

  cdsColunasPorLinha := TZClient.Create(Self, fSQLColunhasPorLinha);
  cdsColunasPorLinha.IndexFieldNames := 'NROLIN';

  cdsProporcaoPorLinha := Nil;

  cdsGatPer := TZClient.Create(Self, 'SELECT * FROM GATPER');

  FParamValidacao := Nil;
  blnValidacao      := False;
  blnExibirMensagem := True;
  blnRetornoDados := False;

  blnTemArquivoSaida := False;

  FExecutaPelaInterface := True;

  blnExecutandoPeloMenu := AExecutandoPeloMenu;

  blnApenasPrincipal := AApenasPrincipal;

  FIndexPasta := -1;
  FIndexImagemCabecalho := -1;

  blnTemDados := False;
  blnImprimirVazio := False;
  blnExecutouSemErro := False;

  arrParametrosReadOnly := Nil;

  strScriptImplementation := '';

  SetLength(FArrSelectCheckList, 0);

  FLimits := TStringList.Create;
  FLimits.Sorted := True;

  FComFilComplementos := TStringList.Create;
  FComFilComplementos.Sorted := True;

  pCriaTiposDeBanda;

  FIndiceListaPreco := -1;
  FLimiteTabelas := 8;

  FstrHorizo := '';
  FIntMaxCol := 0;

  SetLength(FarrRecSetSelect, 0);

  FFr3Gerado := False;
  FTemComposicaoCusto := False;
  FTemInventFinanc := False;

  pInicializaTabelasDinamicas;

  FNomeColunaHorizo := TStringList.Create;
  FOrderByOriginal  := TStringList.Create;

  FOrderBy := TStringList.Create;
  FOrderBy.Sorted := True;

  FDacPor   := fCfgSis('DACPOR', varBoolean);

  FIndexParCusto := 0;
  FSQLErro  := False;
  FConsulta := TConsultasRel.Create(Self);
  FConsulta.fAvaliaExpressaoString := fAvaliaExpressaoString;

  FConsultasGrid :=  TConsultasGrid.Create(Self);
  FConsultasGrid.objConsulta := FConsulta;

  SetLength(FQueryFiltros, 1);
  SetLength(FQueryDados, 1);
  SetLength(FQueryDadosPersonalizado, 1);
  SetLength(FClientDados, 1);
  SetLength(FClientDadosPersonalizado, 1);
  SetLength(FProviderDados, 1);
  SetLength(FProviderDadosPersonalizado, 1);
  SetLength(FEditavel, 1);

  SetLength(FSQL, 1);
  SetLength(FSQLFormatado, 1);

  SetLength(arrGuiaSaldos, 1);

  SetLength(FHorizo, 1);
  SetLength(FCadRel, 1);
  SetLength(FGruposParametros, 1);

  SetLength(FControleRel, 1);

  with FControleRel[0] do
  begin
    strMaster  := '';
    strComple  := '';
    strNomCam  := '';
    strCamLig  := '';
    blnCompPri := False;
    blnChild   := False;
    blnPrint   := True;
  end;

  SetLength(FComFilFiltros, 0);
  SetLength(FComFilDados, 0);
  SetLength(FComFilSQLFormatado, 0);

  FHorizo[0]           := Nil;
  FCadRel[0]           := Nil;
  FGruposParametros[0] := Nil;

  FQueryFiltros[0]             := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  FQueryDados[0]               := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  FQueryDadosPersonalizado[0]  := fCriaQuery(Self, FConexaoRelatorio.objConexao);

  arrGuiaSaldos[0].qryGuiaSaldos := fCriaQuery(Self, FConexaoRelatorio.objConexao);

  FGuiaSaldosTemp.qryGuiaSaldos := fCriaQuery(Self, FConexaoRelatorio.objConexao);

  FValueParams            := TZClient.Create(Self, fSQLValueParams, FConexaoRelatorio.objConexao);
  FValueParamsDisplayText := TZClient.Create(Self, fSQLValueParams, FConexaoRelatorio.objConexao);

  FParams       := TZClient.Create(Self, fSQLParams);
  FGruposParams := TZClient.Create(Self, fSQLGruposParams);
  FCampos       := TZClient.Create(Self, fSQLCampos);
  FComplementos := TZClient.Create(Self, fSQLComplementos);
  FChilds       := TZClient.Create(Self, fSQLChilds);
  FHistoricos   := TZClient.Create(Self, fSQLHistoricos);
  FDirAcesso    := TZClient.Create(Self, fSQLDirAcesso);
  FParamFuncao  := TZClient.Create(Self, fSQLParamFuncao);

  FCamposCopia     := TUniClientDataSet.Create(Self);
  FdtsCamposAprove := TDataSource.Create(Self);

  FParamsCopia     := TUniClientDataSet.Create(Self);

  fCriaMaxLinhas;

  FGeraFr3 := Nil;

  FTituloFiltros   := TStringList.Create;
  FListaParFiltros := TStringList.Create;

  FTabelasSaldos   := TStringList.Create;

  FListaCampos     := TStringList.Create;
  FListaCampos.Sorted := True;

  FqryCadGetDesc := fCriaQuery(Self);
  FqryCadGetDesc.SQL.Text := fSQLCadGetDesc;

  FqryCadGetDescPrr := fCriaQuery(Self);

  pInicializaLargura;

  FInterGraf := TInterfaceGrafica.Create(Self);

  stlVeVerDesc := TStringList.Create;
  stlVeVerHint := TStringList.Create;

end;

Procedure TInterfaceRelatorio.pCriaClientDados(intRelatorio: Integer);
Begin
  If fTemCampoEditavel(intRelatorio) Then
  Begin
    If Not Assigned(FClientDados[intRelatorio]) Then
    Begin
      FClientDados[intRelatorio] := TUniClientDataSet.Create(Self);

      FProviderDados[intRelatorio] := TUniDataSetProvider.Create(Self);
      FProviderDados[intRelatorio].ResolveToDataSet := True;
    End Else
    Begin
      FClientDados[intRelatorio].Close;
    End;

    FProviderDados[intRelatorio].DataSet := FQueryDados[intRelatorio];
    FClientDados[intRelatorio].SetProvider(FProviderDados[intRelatorio]);

  End Else
  Begin
    If Assigned(FClientDados[intRelatorio]) Then
      FreeAndNil(FClientDados[intRelatorio]);

    If Assigned(FProviderDados[intRelatorio]) Then
      FreeAndNil(FProviderDados[intRelatorio]);
  End;
End;

Procedure TInterfaceRelatorio.pCriaClientDadosPersonalizado(intRelatorio: Integer);
Begin
  If Not Assigned(FClientDadosPersonalizado[intRelatorio]) Then
  Begin
    FClientDadosPersonalizado[intRelatorio] := TUniClientDataSet.Create(Self);
  End Else
  Begin
    FClientDadosPersonalizado[intRelatorio].Close;
  End;

  FProviderDadosPersonalizado[intRelatorio] := TUniDataSetProvider.Create(Self);
  FProviderDadosPersonalizado[intRelatorio].ResolveToDataSet := True;

  FProviderDadosPersonalizado[intRelatorio].DataSet := FQueryDadosPersonalizado[intRelatorio];
  FClientDadosPersonalizado[intRelatorio].SetProvider(FProviderDadosPersonalizado[intRelatorio]);
End;

Procedure TInterfaceRelatorio.pInicializaTabelasDinamicas;
Begin
  FillChar(FTemTabelaI_, SizeOf(FTemTabelaI_), #0);
  FillChar(FTemEstExt_, SizeOf(FTemEstExt_), #0);
  FillChar(FTemTabelaSALINV, SizeOf(FTemTabelaSALINV), #0);
  FillChar(FTemTabelaL_, SizeOf(FTemTabelaL_), #0);
End;

Function TInterfaceRelatorio.fCriaQueryRelarorio(AOwner: TComponent = Nil): TUniQuery;
Begin
  Result := fCriaQuery(AOwner, FConexaoRelatorio.objConexao);
End;

Function TInterfaceRelatorio.fCarregaProporcao: Boolean;
Begin
  Try

    If Assigned(cdsProporcaoPorLinha) Then
    Begin
      Result := True;
    End Else
    Begin
      cdsProporcaoPorLinha := TZClient.Create(Self, 'SELECT * FROM PROPOR');
      cdsProporcaoPorLinha.IndexFieldNames := 'PRO_NROCOL';

      Result := cdsProporcaoPorLinha.fLeDados('TInterfaceRelatorio.fCarregaProporcao');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro('[TInterfaceRelatorio.fCarregaProporcao]', E.message);
    End;
  End;
End;

Procedure TInterfaceRelatorio.pCriaConexaoRelatorio(AConexaoRelatorio: TCriarConexao; AConexaoIndependente: Boolean);
Begin
  blnConexaoIndependente := AConexaoIndependente;

  If Assigned(AConexaoRelatorio) Then
  Begin
    blnCriouConexao := False;
    FConexaoRelatorio := AConexaoRelatorio
  End Else
  Begin
    blnCriouConexao := True;

    FConexaoRelatorio := TCriarConexao.Create('pCriaConexaoRelatorio', blnConexaoIndependente);

    If blnConexaoIndependente Then
    Begin
      FConexaoRelatorio.objConexao.Connect;
      pAjustaConexao(FConexaoRelatorio.objConexao);
    End;
  End;
End;

Procedure TInterfaceRelatorio.pDisconectaConexaoRelatorio;
Begin
  If blnCriouConexao And blnConexaoIndependente And Assigned(FConexaoRelatorio) And
     FConexaoRelatorio.objConexao.Connected Then
    FConexaoRelatorio.objConexao.Disconnect;
End;

Procedure TInterfaceRelatorio.pValidarConexaoRelatorio;

  function fErroDeConexaoComBancoDeDados(const AstrMensagemErro: String): Boolean;
  begin
    Result := ((Pos('lost connection', LowerCase(AstrMensagemErro)) > 0) Or
              (Pos('assertion failure', LowerCase(AstrMensagemErro)) > 0)) ;
  end;

var
  LQuery: TUniQuery;
Begin
  If Not blnCriouConexao Then
    Exit;

  If Not blnConexaoIndependente Then
    Exit;

  If Not Assigned(FConexaoRelatorio) Then
    Exit;

  LQuery := fCriaQuery(nil, FConexaoRelatorio.objConexao);
  Try
    Try
      LQuery.SQL.Text := 'SELECT TRUE';
      LQuery.Open;
    Except
      On E: Exception Do
      Begin
        If fErroDeConexaoComBancoDeDados(E.Message) then
          FConexaoRelatorio.objConexao.Connected := True
        Else
          Raise;
      End;
    End;
  Finally
    FreeAndNil(LQuery);
  End;
End;

Procedure TInterfaceRelatorio.pRefazConexaoRelatorio(AConexaoIndependente: Boolean);
Begin
  If AConexaoIndependente Then
  Begin

    If Not blnConexaoIndependente Then
    Begin
      If Assigned(FConexaoRelatorio) Then
        pFreeAndNil(FConexaoRelatorio);

      pCriaConexaoRelatorio(Nil, AConexaoIndependente);
    End;

  End Else
  Begin

    If blnConexaoIndependente And Assigned(FConexaoRelatorio) Then
    Begin
     // pDisconectaConexaoRelatorio;
     // pFreeAndNil(FConexaoRelatorio);

      pCriaConexaoRelatorio(Nil, AConexaoIndependente);
    End;

  End;
End;

Procedure TInterfaceRelatorio.pInicializaLargura;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FArrLarguraUsada) To High(FArrLarguraUsada) Do
  Begin
    FQtdCamposListados[intContador] := 0;
    FArrLarguraUsada[intContador] := 0;
  End;
End;

Procedure TInterfaceRelatorio.pIncrementaLargura;
Begin
  With FCampos Do
  Begin

    If (Not fEmptyStr(FieldByName('CAM_LISTAR').AsString)) And
       (StrToIntDef(FieldByName('CAM_LISTAR').AsString, -1) <= MAX_LINHAS_DETALHE) Then
    Begin
      Inc(FQtdCamposListados[FieldByName('CAM_LISTAR').AsInteger]);
      FArrLarguraUsada[FieldByName('CAM_LISTAR').AsInteger] := FArrLarguraUsada[FieldByName('CAM_LISTAR').AsInteger] +
                                                               FieldByName('CAM_LARGUR').AsFloat;
    End;

  End;
End;

destructor TInterfaceRelatorio.Destroy;
begin
  pLiberaQueriesComplentares;

  pLiberaQueriesComFil;

  pLiberaSelectCheckList;

  FSQLFil := '';

  SetLength(FQueryFiltros,               0);
  SetLength(FQueryDados,                 0);
  SetLength(FQueryDadosPersonalizado,    0);
  SetLength(FClientDados,                0);
  SetLength(FClientDadosPersonalizado,   0);
  SetLength(FProviderDados,              0);
  SetLength(FProviderDadosPersonalizado, 0);
  SetLength(FEditavel,                   0);
  SetLength(arrGuiaSaldos,               0);

  SetLength(FSQL,                        0);
  SetLength(FSQLFormatado,               0);

  SetLength(FHorizo,                     0);
  SetLength(FCadRel,                     0);
  SetLength(FGruposParametros,           0);
  SetLength(FArrExpVis,                  0);
  SetLength(FArrSQLVis,                  0);
  SetLength(FArrEmpCfg,                  0);

  SetLength(FControleRel,                0);

  if Assigned(dicQueryTag) then
  begin
    FreeAndNil(dicQueryTag);
  end;

  if Assigned(FComFilComplementos) then
  begin
    FComFilComplementos.Clear;
    FreeAndNil(FComFilComplementos);
  end;

  if Assigned(FTituloFiltros) then
  begin
    FTituloFiltros.Clear;
    FreeAndNil(FTituloFiltros);
  end;

  if Assigned(FNomeColunaHorizo) then
  begin
    FNomeColunaHorizo.Clear;
    FreeAndNil(FNomeColunaHorizo);
  end;

  if Assigned(FListaParFiltros) then
  begin
    FListaParFiltros.Clear;
    FreeAndNil(FListaParFiltros);
  end;

  if Assigned(FListaCampos) then
  begin
    FListaCampos.Clear;
    FreeAndNil(FListaCampos);
  end;

  if Assigned(FOrderBy) then
  begin
    FOrderBy.Clear;
    FreeAndNil(FOrderBy);
  end;

  if Assigned(FOrderByOriginal) then
  begin
    FOrderByOriginal.Clear;
    FreeAndNil(FOrderByOriginal);
  end;

  if Assigned(stlVeVerDesc) then
  begin
    stlVeVerDesc.Clear;
    FreeAndNil(stlVeVerDesc);
  end;

  if Assigned(stlVeVerHint) then
  begin
    stlVeVerHint.Clear;
    FreeAndNil(stlVeVerHint);
  end;

  if Assigned(FLimits) then
  begin
    FLimits.Clear;
    FreeAndNil(FLimits);
  end;

  if Assigned(stlArquivos) then
  begin
    stlArquivos.Clear;
    FreeAndNil(stlArquivos);
  end;

  SetLength(FArquivosPontoImpressao, 0);

  if Assigned(stlGerarSeVazio) then
  begin
    stlGerarSeVazio.Clear;
    FreeAndNil(stlGerarSeVazio);
  end;

  pLiberaTabelaSaldos;

  pDisconectaConexaoRelatorio;

  If (blnCriouConexao) And (Assigned(FConexaoRelatorio)) Then
    FreeAndNil(FConexaoRelatorio);

  inherited;
end;

Procedure TInterfaceRelatorio.pLiberaTabelaSaldos;
  Var
    intContador: Integer;
Begin
  if not Assigned(FTabelasSaldos) then
    Exit;

  For intContador := 0 To FTabelasSaldos.Count - 1 Do
    fDropTable(FTabelasSaldos[intContador]);

  FTabelasSaldos.Clear;
  FreeAndNil(FTabelasSaldos);
End;

Function TInterfaceRelatorio.fSQLCadGetDesc: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CAM_DESCAM ';
  Result := Result + ' FROM ';
  Result := Result + '   CADCAM ';
  Result := Result + ' INNER JOIN CADREL R ON R.AUTOINCREM = CAM_SEQGER ';
  Result := Result + ' WHERE  ';
  Result := Result + '   CAM_NOMCAM = :NOMCAM  ';
  Result := Result + ' ORDER BY  ';
  Result := Result + '   REL_DTAALT DESC, REL_HORALT DESC ';
  Result := Result + ' LIMIT 1 ';
End;

Function TInterfaceRelatorio.fSQLCadGetDescPrr(strSeqGer: String): String;
Var
  strCampos: String;
Begin

  strCampos := '';
  strCampos := strCampos + '   PAR_DESPAR, ';
  strCampos := strCampos + '   PAR_TIPFAC, ';
  strCampos := strCampos + '   PAR_TIPPAR, ';
  strCampos := strCampos + '   PAR_PESQUI, ';
  strCampos := strCampos + '   PAR_FACTXT, ';
  strCampos := strCampos + '   PAR_FACVAL, ';
  strCampos := strCampos + '   PAR_VALCHK, ';
  strCampos := strCampos + '   PAR_VALNCH, ';
  strCampos := strCampos + '   PAR_VALDEF, ';
  strCampos := strCampos + '   PAR_CHKDEF, ';
  strCampos := strCampos + '   PAR_DESTOD, ';
  strCampos := strCampos + '   PAR_SQLCHK, ';
  strCampos := strCampos + '   PAR_SQLVIS, ';
  strCampos := strCampos + '   PAR_EXPVIS, ';
  strCampos := strCampos + '   PAR_EXPIMP, ';
  strCampos := strCampos + '   PAR_ORDENA, ';
  strCampos := strCampos + '   REL_DTAALT, ';
  strCampos := strCampos + '   REL_HORALT  ';

  // Primeiro tenta achar o filtro no relatório pai com TMP, Complementar ou Child
  // Se não achar o filtro, roda o segundo SELECT por garantia para pegar dados de outro relatório
  Result := '';
  Result := Result + ' SELECT "' + IIF(fEmptyStr(strSeqGer), 'N', 'S') + '" AS REL_RELPAI, T1.* FROM ( ';
  Result := Result + '   SELECT ' + strCampos;
  Result := Result + '   FROM CADPRR ';
  Result := Result + '     JOIN CADREL R ON R.AUTOINCREM = PAR_SEQGER ';
  Result := Result + '   WHERE TRUE ';
  Result := Result + '     AND PAR_NOMPAR = :NOMPAR  ';
  If Not fEmptyStr(strSeqGer) Then
    Result := Result + '   AND PAR_SEQGER = :SEQGER ';
  If fEmptyStr(strSeqGer) Then
  Begin
    Result := Result + ' ORDER BY  ';
    Result := Result + '   REL_DTAALT DESC, REL_HORALT DESC ';
    Result := Result + ' LIMIT 1 ';
  End;
  Result := Result + ' ) AS T1 ';

  If Not fEmptyStr(strSeqGer) Then
  Begin
    Result := Result + ' UNION ALL ';

    Result := Result + ' SELECT "N" AS REL_RELPAI, T2.* FROM ( ';
    Result := Result + '   SELECT ' + strCampos;
    Result := Result + '   FROM CADPRR ';
    Result := Result + '     JOIN CADREL R ON R.AUTOINCREM = PAR_SEQGER ';
    Result := Result + '   WHERE TRUE ';
    Result := Result + '     AND PAR_NOMPAR = :NOMPAR  ';
    Result := Result + '   ORDER BY  ';
    Result := Result + '     REL_DTAALT DESC, REL_HORALT DESC ';
    Result := Result + '   LIMIT 1 ';
    Result := Result + ' ) AS T2 ';
  End;

  Result := Result + ' ORDER BY  ';
  Result := Result + '   REL_RELPAI DESC, REL_DTAALT DESC, REL_HORALT DESC ';
  Result := Result + ' LIMIT 1 ';
End;

Function TInterfaceRelatorio.fSQLParamFuncao: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CAST("" AS CHAR(255)) AS NOMPAR, ';
  Result := Result + '   CAST("" AS CHAR(255)) AS VALPAR  ';
End;

Function TInterfaceRelatorio.fSQLComplementos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   R.*, ';
  Result := Result + '   (SELECT REL_TITPOS FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_TITPOS, ';
  Result := Result + '   (SELECT REL_DESCRI FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_DESCRI, ';
  Result := Result + '   (SELECT REL_SUBTIT FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_SUBTIT, ';
  Result := Result + '   (SELECT REPLACE(REL_DESCMP,"<<csq>>"," ") AS REL_DESCMP FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_DESCMP,  ';
  Result := Result + '   (SELECT REL_CODREL FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_CODREL, ';
  Result := Result + '   (SELECT REL_NOVPAG FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_NOVPAG  ';
  Result := Result + ' FROM SUBREL R ';
  Result := Result + ' WHERE ';
  Result := Result + '   REL_MASTER = :SEQGER ';
  Result := Result + ' ORDER BY REL_ORDENA ';
End;

Function TInterfaceRelatorio.fSQLDirAcesso: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   R.*, ';
  Result := Result + '   (SELECT DIR_CODDIR FROM CADDIR D WHERE D.AUTOINCREM = REL_SEQDIR) AS DIR_CODDIR, ';
  Result := Result + '   (SELECT DIR_NOMDIR FROM CADDIR D WHERE D.AUTOINCREM = REL_SEQDIR) AS DIR_NOMDIR  ';
  Result := Result + ' FROM DIRREL R ';
  Result := Result + ' WHERE ';
  Result := Result + '   REL_SEQGER = :SEQGER ';
  Result := Result + ' ORDER BY DIR_NOMDIR ';
End;

Function TInterfaceRelatorio.fSQLChilds: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   R.*, ';
  Result := Result + '   (SELECT REL_TITPOS FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_TITPOS, ';
  Result := Result + '   (SELECT REL_DESCRI FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_DESCRI, ';
  Result := Result + '   (SELECT REL_SUBTIT FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_SUBTIT, ';
  Result := Result + '   (SELECT REPLACE(REL_DESCMP,"<<csq>>"," ") AS REL_DESCMP FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_DESCMP,  ';
  Result := Result + '   (SELECT REL_CODREL FROM CADREL C WHERE C.AUTOINCREM = REL_COMPLE) AS REL_CODREL ';
  Result := Result + ' FROM CHIREL R ';
  Result := Result + ' WHERE ';
  Result := Result + '   REL_MASTER = :SEQGER ';
  Result := Result + ' ORDER BY REL_ORDENA ';
End;

Function TInterfaceRelatorio.fSQLHistoricos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   H.* ';
  Result := Result + ' FROM HISREL H ';
  Result := Result + ' WHERE ';
  Result := Result + '   HIS_CHAVE_ = :CHAVE ';
  Result := Result + ' ORDER BY HIS_SEQHIS DESC ';
End;

Function TInterfaceRelatorio.fSQLParams: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CADPRR.*,     ';
  Result := Result + '   1 AS PARVIS,  ';
  Result := Result + '   1 AS PARIMP,  ';
  Result := Result + '   1 AS IMPFIL,  ';
  Result := Result + '   CAST(NULL AS CHAR(255)) AS VALOR, ';
  Result := Result + '   IF((PAR_SQLVIS <> "") OR (PAR_EXPVIS <> "") OR (PAR_EXPIMP <> ""), "Sim", "") AS PAR_CNDVIS ';
  Result := Result + ' FROM CADPRR ';
  Result := Result + ' WHERE ';
  Result := Result + '   PAR_SEQGER = :SEQGER AND PAR_AUTOMA NOT IN ("S", "P") ';
  Result := Result + ' ORDER BY ';
  Result := Result + '   PAR_ORDENA ';
End;

Function TInterfaceRelatorio.fSQLGruposParams: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   *  ';
  Result := Result + ' FROM GRUPAR ';
  Result := Result + ' WHERE ';
  Result := Result + '   GRU_SEQGER = :SEQGER ';
End;

Function TInterfaceRelatorio.fSQLValueParams: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   PAR_NOMPAR AS NOMPAR, ';
  Result := Result + '   CAST("" AS CHAR(100000)) AS VALPAR,  ';
  Result := Result + '   CAST("" AS CHAR(100000)) AS DESEDT   ';

  Result := Result + ' FROM CADPRR ';
  Result := Result + ' WHERE ';
  Result := Result + '   FALSE ';
End;

Function TInterfaceRelatorio.fSQLCampos: String;
Begin
  Result := '';
  Result := Result + ' SELECT ';

  Result := Result + '  -1 AS CAM_POSORD, ';

  Result := Result + '  -1.0000000000 AS LARGURA_REAL, ';

  Result := Result + '  -1 AS VISIVEL, ';

  Result := Result + '  LENGTH(CAM_NOMCAM) AS TAMANHO_CAMPO, ';

  Result := Result + '  IF((CAM_EXPVIS <> "") OR (CAM_QUAQUE <> ""), "Sim", "") AS CAM_CNDVIS, ';

  Result := Result + '   CADCAM.* ';

  Result := Result + ' FROM CADCAM ';
  Result := Result + ' WHERE ';
  Result := Result + '   CAM_SEQGER = :SEQGER ';
End;

Function TInterfaceRelatorio.fSQLLinhas: String;
Begin
  Result := Result + ' SELECT ';

  Result := Result + '   0.00 AS LARMA1, ';
  Result := Result + '   0.00 AS LARMA2, ';
  Result := Result + '   0.00 AS LARMA3, ';
  Result := Result + '   0.00 AS LARMA4, ';
  Result := Result + '   0.00 AS LARMA5, ';

  Result := Result + '   0.00 AS LARCO1, ';
  Result := Result + '   0.00 AS LARCO2, ';
  Result := Result + '   0.00 AS LARCO3, ';
  Result := Result + '   0.00 AS LARCO4, ';
  Result := Result + '   0.00 AS LARCO5  ';
End;

Function TInterfaceRelatorio.fCriaMaxLinhas: Boolean;
Begin
  FLinhas := TZClient.Create(Self, fSQLLinhas);

  Result := FLinhas.fAbreClient(True, 'TInterfaceRelatorio.fCriaMaxLinhas');
End;

Procedure TInterfaceRelatorio.pBeforePostCampos(dataSet: TDataSet);
Begin
  With DataSet Do
  Begin
    If FieldByName('CAM_NRODEC').IsNull And
       SameText(FieldByName('CAM_TIPCAM').AsString, ArrDesInterface[facFloat]) Then
     FieldByName('CAM_NRODEC').AsInteger := 2;

    If fEmptyStr(FieldByName('CAM_LISQUE').AsString) Then
      FieldByName('CAM_LINQUE').AsString := ''

    Else If fEmptyStr(FieldByName('CAM_LINQUE').AsString) Then
           FieldByName('CAM_LINQUE').AsString := '1';

    If Not fEmptyStr(FieldByName('CAM_TOTALI').AsString) Then
      FieldByName('CAM_LISQUE').AsString := '';
  End;
End;

Procedure TInterfaceRelatorio.pBeforeEditCampos(dataSet: TDataSet);
Begin
  With DataSet Do
  FTipoSomaAnterior := FieldByName('CAM_TOTALI').AsString;
End;

Procedure TInterfaceRelatorio.pBeforeEditParams(dataSet: TDataSet);
Begin
  With DataSet Do
  FTipFacAnterior := FieldByName('PAR_TIPFAC').AsString;
End;

Function TInterfaceRelatorio.fExisteParametro(strNomPar: String; intOriPar: Integer): Boolean;
  Var
    intQueries: Integer;
Begin

  Result := False;

  strNomPar := Trim(strNomPar);

  If intOriPar = 1 Then
  Begin

    Result := FComFilComplementos.Find(strNomPar, intQueries);

  End

  Else If intOriPar = 2 Then
  Begin

    Result := FLimits.Find(strNomPar, intQueries);

  End

  Else If intOriPar = 3 Then
  Begin

    Result := Assigned(FParamValidacao) And FParamValidacao.FindKey([strNomPar]);

  End Else

  Begin

    For intQueries := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
      If FQueryFiltros[intQueries].Params.FindParam(strNomPar) <> Nil Then
      Begin
        Result := True;
        Exit;
      End;

    For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
      If FComFilFiltros[intQueries].Params.FindParam(strNomPar) <> Nil Then
      Begin
        Result := True;
        Exit;
      End;

   End;
End;

Procedure TInterfaceRelatorio.pSetaParamsObrigatorios;
  Var
    intIndice,
    intQueries: Integer;
    strTesteSQL: String;
Begin
  With FParams Do
  Begin
    First;

    While Not Eof Do
    Begin
      Edit;

      If FieldByName('PAR_ORIPAR').AsInteger = 1 Then
        FieldByName('PAR_OBRIGA').AsString := 'N'
      Else
        FieldByName('PAR_OBRIGA').AsString := 'S';

      Post;

      Next;
    End;
  End;

  For intQueries := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
  With FQueryFiltros[intQueries] Do
  Begin

    For intIndice := 0 To Params.Count - 1 Do
    Begin
      strTesteSQL := fRetiraClausula(fTrataTemplates(FSQLFormatado[intQueries]), Params[intIndice].Name);

      If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) Then
      Begin
        FParams.Edit;

        If Not SameText(strTesteSQL, fTrataTemplates(FSQLFormatado[intQueries])) Then
          FParams.FieldByName('PAR_OBRIGA').AsString := 'N';

        FParams.Post;
      End;

    End;

  End;

  For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
  With FComFilFiltros[intQueries] Do
  Begin

    For intIndice := 0 To Params.Count - 1 Do
    Begin
      strTesteSQL := fRetiraClausula(fTrataTemplates(FSQLFil), Params[intIndice].Name);

      If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) Then
      Begin
        FParams.Edit;

        If Not SameText(strTesteSQL, fTrataTemplates(FSQLFil)) Then
          FParams.FieldByName('PAR_OBRIGA').AsString := 'N';

        FParams.Post;
      End;

    End;

  End;

End;

Procedure TInterfaceRelatorio.pLiberaQueriesComplentares;
  Var
    intQueries: Integer;
Begin
  For intQueries := Succ(Low(FQueryFiltros)) To HiGh(FQueryFiltros) Do
    If Assigned(FQueryFiltros[intQueries]) Then
      FreeAndNil(FQueryFiltros[intQueries]);

  For intQueries := Succ(Low(FQueryDados)) To HiGh(FQueryDados) Do
  Begin
    If Assigned(FQueryDados[intQueries]) Then
      FreeAndNil(FQueryDados[intQueries]);

    If Assigned(FProviderDados[intQueries]) Then
      FreeAndNil(FProviderDados[intQueries]);

    If Assigned(FClientDados[intQueries]) Then
      FreeAndNil(FClientDados[intQueries]);
  End;

  For intQueries := (Low(FQueryDadosPersonalizado)) To HiGh(FQueryDadosPersonalizado) Do
  Begin
    If Assigned(FClientDadosPersonalizado[intQueries]) Then
      FreeAndNil(FClientDadosPersonalizado[intQueries]);

    If Assigned(FProviderDadosPersonalizado[intQueries]) Then
      FreeAndNil(FProviderDadosPersonalizado[intQueries]);

    If Assigned(FQueryDadosPersonalizado[intQueries]) Then
      FreeAndNil(FQueryDadosPersonalizado[intQueries]);
  End;

  For intQueries := Succ(Low(arrGuiaSaldos)) To HiGh(arrGuiaSaldos) Do
    If Assigned(arrGuiaSaldos[intQueries].qryGuiaSaldos) Then
      FreeAndNil(arrGuiaSaldos[intQueries].qryGuiaSaldos);

  For intQueries := Succ(Low(FCadRel)) To HiGh(FCadRel) Do
    If Assigned(FCadRel[intQueries]) Then
      FreeAndNil(FCadRel[intQueries]);

  For intQueries := Succ(Low(FGruposParametros)) To HiGh(FGruposParametros) Do
    If Assigned(FGruposParametros[intQueries]) Then
      FreeAndNil(FGruposParametros[intQueries]);
End;

Procedure TInterfaceRelatorio.pLiberaQueriesComFil;
  Var
    intQueries: Integer;
Begin
  For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
    If Assigned(FComFilFiltros[intQueries]) Then
      FreeAndNil(FComFilFiltros[intQueries]);

  For intQueries := Low(FComFilDados) To HiGh(FComFilDados) Do
    If Assigned(FComFilDados[intQueries]) Then
      FreeAndNil(FComFilDados[intQueries]);

  SetLength(FComFilFiltros, 0);
  SetLength(FComFilDados, 0);
  SetLength(FComFilSQLFormatado, 0);
End;

Function TInterfaceRelatorio.fTemCampoEditavelComplemento(strComple: String): Boolean;
  Var
    qryCampos: TUniQuery;
Begin
  qryCampos := fCriaQuery;
  qryCampos.SQL.Text := 'SELECT COUNT(*) AS QTD FROM CADCAM WHERE CAM_SEQGER = :SEQGER AND CAM_EDITAV = "S"';
  qryCampos.ParamByName('SEQGER').AsString := strComple;
  qryCampos.Open;
  Result := qryCampos.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryCampos);
End;

Function TInterfaceRelatorio.fTemCampoEditavel(intRelatorio: Integer): Boolean;
Begin
  Result := FEditavel[intRelatorio];
End;

Procedure TInterfaceRelatorio.pSetaEditavel;
Begin
  FEditavel[0] := FCampos.Locate('CAM_EDITAV', 'S', []);
End;

procedure TInterfaceRelatorio.pCarregaQueriesCompRecursiva(var intQueries: Integer; strMaster, strComple, strNomCam, strCamLig: string; blnAlimentaArrays, blnCompPri, blnChild: Boolean);
var
  qryChildComp: TUniQuery;
Begin

  Inc(intQueries);

  // alimenta query no início ou quando há algum relatório a mais
  if blnAlimentaArrays or (Length(FControleRel) < (intQueries + 1)) then
  begin
    SetLength(FQueryFiltros,     Succ(Length(FQueryFiltros)));
    SetLength(FQueryDados,       Succ(Length(FQueryDados)));
    SetLength(FClientDados,      Succ(Length(FClientDados)));
    SetLength(FProviderDados,    Succ(Length(FProviderDados)));
    SetLength(FEditavel,         Succ(Length(FEditavel)));
    SetLength(arrGuiaSaldos,     Succ(Length(arrGuiaSaldos)));
    SetLength(FSQL,              Succ(Length(FSQL)));
    SetLength(FSQLFormatado,     Succ(Length(FSQLFormatado)));
    SetLength(FHorizo,           Succ(Length(FHorizo)));
    SetLength(FCadRel,           Succ(Length(FCadRel)));
    SetLength(FGruposParametros, Succ(Length(FGruposParametros)));
    SetLength(FControleRel,      Succ(Length(FControleRel)));
  end;

  FHorizo[intQueries]           := Nil;
  FClientDados[intQueries]      := Nil;
  FProviderDados[intQueries]    := Nil;
  FEditavel[intQueries] := fTemCampoEditavelComplemento(strComple);

  FQueryFiltros[intQueries]     := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  FQueryDados[intQueries]       := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  arrGuiaSaldos[intQueries].qryGuiaSaldos := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  FCadRel[intQueries]           := fCriaQuery(Self);
  FGruposParametros[intQueries] := fCriaQuery(Self);

  FCadRel[intQueries].SQL.Text := 'SELECT * FROM CADREL WHERE AUTOINCREM = :AUTINC';
  FCadRel[intQueries].ParamByName('AUTINC').AsString := strComple;
  FCadRel[intQueries].Open;

  FGruposParametros[intQueries].SQL.Text := 'SELECT * FROM GRUPAR WHERE GRU_SEQGER = :AUTINC';
  FGruposParametros[intQueries].ParamByName('AUTINC').AsString := strComple;
  FGruposParametros[intQueries].Open;

  FSQLFormatado[intQueries]          := FCadRel[intQueries].FieldByName('REL_SQLDEF').AsString;

  If FSQLFormatado[intQueries].IsEmpty Then
    FSQLFormatado[intQueries] := AnsiReplaceStr(FCadRel[intQueries].FieldByName('REL_DEFSQL').AsString, '<<csq>>', #13#10);

  FSQL[intQueries] := fRetiraFormatacaoSQL(FSqlFormatado[intQueries], False, False, False, intQueries {blnQueryFiltros});

  pSetaRecSaldos(arrGuiaSaldos[intQueries]);

  If arrGuiaSaldos[intQueries].strSQLFormatado.IsEmpty Then
    FQueryFiltros[intQueries].SQL.Text := FSQL[intQueries]
  Else
    FQueryFiltros[intQueries].SQL.Text := fRetiraFormatacaoSQL(FSqlFormatado[intQueries], False, False, True, intQueries {blnQueryFiltros});

  FQueryFiltros[intQueries].Close;

  If (SameText(FCadRel[intQueries].FieldByName('REL_HORIZO').AsString, 'S')  Or
      SameText(FCadRel[intQueries].FieldByName('REL_HORIZO').AsString, 'I')) Then
    FQueryFiltros[intQueries].Open;

  FControleRel[intQueries].strMaster  := strMaster;
  FControleRel[intQueries].strComple  := strComple;
  FControleRel[intQueries].strNomCam  := strNomCam;
  FControleRel[intQueries].strCamLig  := strCamLig;
  FControleRel[intQueries].blnCompPri := blnCompPri;
  FControleRel[intQueries].blnChild   := blnChild;
  FControleRel[intQueries].blnPrint   := not blnChild;

  qryChildComp := fCriaQuery(Nil);
  try
    with qryChildComp do
    begin
      // carregando recursivamente os childs desse relatório
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CHIREL WHERE REL_MASTER = :COMPLE ORDER BY REL_ORDENA');
      ParamByName('COMPLE').AsString := strComple;
      Open;
      while not Eof do
      begin
        pCarregaQueriesCompRecursiva(intQueries,
                                     FieldByName('REL_MASTER').AsString,
                                     FieldByName('REL_COMPLE').AsString,
                                     FieldByName('REL_NOMCAM').AsString,
                                     FieldByName('REL_CAMLIG').AsString,
                                     blnAlimentaArrays,
                                     False,
                                     True);
        Next;
      end;
      // carregando recursivamente os complementos desse relatório
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM SUBREL WHERE REL_MASTER = :COMPLE ORDER BY REL_ORDENA');
      ParamByName('COMPLE').AsString := strComple;
      Open;
      while not Eof do
      begin
        pCarregaQueriesCompRecursiva(intQueries,
                                     FieldByName('REL_MASTER').AsString,
                                     FieldByName('REL_COMPLE').AsString,
                                     '', '', blnAlimentaArrays, False, False);
        Next;
      end;
    end;
  finally
    FreeAndNil(qryChildComp);
  end;

end;

Procedure TInterfaceRelatorio.pCarregaQueriesComplentares(blnAlimentaArrays: Boolean);
  Var
    intQueries: Integer;
Begin
  pLiberaQueriesComplentares;

  intQueries := 0;

  blnAlimentaArrays := IIF(blnAlimentaArrays, not (Length(FControleRel) > 1), False);

  if not FChilds.IsEmpty then
  begin
    FChilds.First;
    while not FChilds.Eof do
    begin
      pCarregaQueriesCompRecursiva(intQueries,
                                   FChilds.FieldByName('REL_MASTER').AsString,
                                   FChilds.FieldByName('REL_COMPLE').AsString,
                                   FChilds.FieldByName('REL_NOMCAM').AsString,
                                   FChilds.FieldByName('REL_CAMLIG').AsString,
                                   blnAlimentaArrays,
                                   False,
                                   True);
      FChilds.Next;
    end;
  end;

  FComplementos.First;
  While Not FComplementos.Eof Do
  Begin
    pCarregaQueriesCompRecursiva(intQueries,
                                 FComplementos.FieldByName('REL_MASTER').AsString,
                                 FComplementos.FieldByName('REL_COMPLE').AsString,
                                 '', '', blnAlimentaArrays, True, False);
    FComplementos.Next;
  End;

  // ajusta posições caso tenha adicionado ou removido algum relatório
  if Length(FControleRel) <> (intQueries + 1) then
  begin
    SetLength(FQueryFiltros,     (intQueries + 1));
    SetLength(FQueryDados,       (intQueries + 1));
    SetLength(FProviderDados,    (intQueries + 1));
    SetLength(FEditavel,         (intQueries + 1));
    SetLength(FClientDados,      (intQueries + 1));
    SetLength(arrGuiaSaldos,     (intQueries + 1));
    SetLength(FSQL,              (intQueries + 1));
    SetLength(FSQLFormatado,     (intQueries + 1));
    SetLength(FHorizo,           (intQueries + 1));
    SetLength(FCadRel,           (intQueries + 1));
    SetLength(FGruposParametros, (intQueries + 1));
    SetLength(FControleRel,      (intQueries + 1));
  end;

End;

Procedure TInterfaceRelatorio.pSetSQLFil(value: String);
Begin
  If (Value <> FSQLFil) Or FSQLErro Then
  Begin
    FSQLFil := Value;
    FSQLErro := False;

    if FParams.Active Then
    begin
      pCarregaQueriesComFil;
      fAtualizaParametros(False);
    end;
  End;
End;

Function TInterfaceRelatorio.fSQLBuscaParametro: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM CADPRR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PAR_SEQGER = :SEQGER AND ';
  strSQL := strSQL + '   PAR_NOMPAR = :NOMPAR     ';

  Result := strSQL;
End;

Function TInterfaceRelatorio.fBuscaParametro(qryParam: TUniQuery; strNomPar, strSeqGer: String): Boolean;
Begin
  With qryParam Do
  Begin
    Close;

    ParamByName('SEQGER').AsString := strSeqGer;
    ParamByName('NOMPAR').AsString := strNomPar;

    Open;

    Result := Not IsEmpty;
  End;
End;

Procedure TInterfaceRelatorio.pIncluiExprVisibilParametro(strNomPar, strExpressao: String);
  var
    intContador: Integer;
Begin
  If fEmptyStr(strExpressao) Then
    Exit;

  For intContador := Low(FArrExpVis) To High(FArrExpVis) Do
    If SameText(FArrExpVis[intContador].strNomPar, strNomPar) Then
    Begin
      FArrExpVis[intContador].strExpVis := strExpressao;
      Exit;
    End;

  SetLength(FArrExpVis, Succ(Length(FArrExpVis)));
  FArrExpVis[High(FArrExpVis)].strNomPar := strNomPar;
  FArrExpVis[High(FArrExpVis)].strExpVis := AnsiReplaceStr(strExpressao, '<<csq>>', ' ');
End;

Procedure TInterfaceRelatorio.pIncluiSQLVisibilParametro(strNomPar, strSQL: String);
  var
    intContador: Integer;
Begin
  If fEmptyStr(strSQL) Then
    Exit;

  If Pos(':', strSQL) = 0 Then
    Exit;

  For intContador := Low(FArrSQLVis) To High(FArrSQLVis) Do
    If SameText(FArrSQLVis[intContador].strNomPar, strNomPar) Then
    Begin
      FArrSQLVis[intContador].strSQLVis := strSQL;
      Exit;
    End;

  SetLength(FArrSQLVis, Succ(Length(FArrSQLVis)));
  FArrSQLVis[High(FArrSQLVis)].strNomPar := strNomPar;
  FArrSQLVis[High(FArrSQLVis)].strSQLVis := strSQL;
End;

Procedure TInterfaceRelatorio.pIncluiEmpConfigParametro(strNomPar, strEmp: String);
  var
    intContador: Integer;
Begin
  If fEmptyStr(strEmp) Then
    Exit;

  If Pos(':', strEmp) = 0 Then
    Exit;

  For intContador := Low(FArrEmpCfg) To High(FArrEmpCfg) Do
    If SameText(FArrEmpCfg[intContador].strNomPar, strNomPar) Then
    Begin
      FArrEmpCfg[intContador].strEmpCfg := strEmp;
      Exit;
    End;

  SetLength(FArrEmpCfg, Succ(Length(FArrEmpCfg)));
  FArrEmpCfg[High(FArrEmpCfg)].strNomPar := strNomPar;
  FArrEmpCfg[High(FArrEmpCfg)].strEmpCfg := strEmp;
End;

procedure TInterfaceRelatorio.pComboChange(Sender: TObject);
Begin
  If Assigned(FFiltros) And Assigned(FFiltros.FocusedRow) Then
  Begin
    pAvaliaExprVisibilParametro(TcxEditorRow(FFiltros.FocusedRow).Name);
    pAvaliaCheckListCustomizado(TcxEditorRow(FFiltros.FocusedRow).Name);
  End;
End;

Procedure TInterfaceRelatorio.pAvaliaVisibilidadeCategoria(rowDado: TcxEditorRow);
Var
  blnCategoriaVisible: Boolean;
  crwCategoria: TcxCategoryRow;
  intChilds: Integer;
  objParent: TObject;
Begin
  blnCategoriaVisible := False;
  If Assigned(rowDado.Parent) Then
  Begin
    objParent := rowDado.Parent;
    If (objParent is TcxCategoryRow) Then
    Begin
      crwCategoria := TcxCategoryRow(objParent);
      For intChilds := 0 To crwCategoria.Count - 1 Do
      Begin
        If TcxEditorRow(crwCategoria.Rows[intChilds]).Visible Then
        Begin
          blnCategoriaVisible := True;
          Break;
        End;
      End;
      crwCategoria.Visible := blnCategoriaVisible;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAvaliaExprVisibilParametro(strNomPar: String);
  var
    intRecNo,
    intRecNoAuto,
    intContador: Integer;
    rowDado: TcxEditorRow;
    strExpressao: string;

Begin
  intRecNo := FParams.RecNo;
  intRecNoAuto := cdsParametrosAutomaticos.RecNo;

  For intContador := Low(FArrExpVis) To High(FArrExpVis) Do
    If (Pos(':' + strNomPar, FArrExpVis[intContador].strExpVis) > 0) Or
       (Pos(STR_DESTINO, FArrExpVis[intContador].strExpVis) > 0) Then
    Begin
      rowDado := fRetRowDado(FArrExpVis[intContador].strNomPar);

      If Assigned(rowDado) Then
      Begin

        strExpressao := AnsiReplaceStr(FArrExpVis[intContador].strExpVis, STR_DESTINO, QuotedStr(string(ArrDestino[fRetDestino])));

        rowDado.Visible := fAvaliaExpressao(strExpressao);

        pAvaliaVisibilidadeCategoria(rowDado);

        If FParams.Locate('PAR_NOMPAR', rowDado.Name, []) Then
        Begin
          FParams.Edit;
          FParams.FieldByName('PARVIS').AsInteger := IfThen(rowDado.Visible, 1, 0);
          FParams.Post;
        End

        Else If cdsParametrosAutomaticos.Locate('PAR_NOMPAR', rowDado.Name, []) Then
        Begin
          cdsParametrosAutomaticos.Edit;
          cdsParametrosAutomaticos.FieldByName('PARVIS').AsInteger := IfThen(rowDado.Visible, 1, 0);
          cdsParametrosAutomaticos.Post;
        End

      End;
    End;

  FParams.RecNo := intRecNo;
  cdsParametrosAutomaticos.RecNo := intRecNoAuto;
End;

Function TInterfaceRelatorio.fEhParametroAutomatico(strNomPar: String): Boolean;
Begin
  Result := strNomPar.StartsWith('INVENTARIO') Or
            strNomPar.StartsWith('ESTOQUE_EXTERNO') Or
            strNomPar.StartsWith('ENVIADO_TERCEIROS') Or
            strNomPar.StartsWith('RECEBIDO_TERCEIROS') Or
            strNomPar.StartsWith('SALINV') Or
            SameText(strNomPar, 'CTR_') Or
            strNomPar.StartsWith('LOTES') Or
            SameText(strNomPar, STR_PRECUS) Or
            SameText(strNomPar, STR_PAGINA_INICIAL) Or
            SameText(strNomPar, 'DESTINO_REL');
End;

Function TInterfaceRelatorio.fEhParametroGatilho(strNomPar: String): Boolean;
Begin
  Result := strNomPar.StartsWith('GATILHO_');
End;

Function TInterfaceRelatorio.fEhCampoGatilho(strNomPar: String): Boolean;
Begin
  Result := cdsParametrosGatilho.Locate('PARINI', strNomPar, []) Or
            cdsParametrosGatilho.Locate('PAR_PARFIN', strNomPar, [])
End;

Procedure TInterfaceRelatorio.pAvaliaComboBoxConfig(strNomPar: String);
  var
    intRecNo,
    intContador: Integer;
    rowDado: TcxEditorRow;
    cdsParams: TUniClientDataSet;
    strValorConfig: String;
Begin
  intRecNo := FParams.RecNo;

  For intContador := Low(FArrEmpCfg) To High(FArrEmpCfg) Do
    If Pos(':' + strNomPar, FArrEmpCfg[intContador].strEmpCfg) > 0 Then
    Begin
      rowDado := fRetRowDado(FArrEmpCfg[intContador].strNomPar);

      If Assigned(rowDado) Then
      Begin
        If fEhParametroAutomatico(strNomPar) Then
          cdsParams := cdsParametrosAutomaticos
        Else
          cdsParams := FParams;

        strValorConfig := '';
        If fRetornaComboBoxConfig(strValorConfig, fRetRowDado(strNomPar).Properties.Value, cdsParams, rowDado) Then
          rowDado.Properties.Value := strValorConfig;
      End;
    End;

  FParams.RecNo := intRecNo;
End;

Procedure TInterfaceRelatorio.pAvaliaSQLVisibilParametro(strNomPar: String);
  var
    intRecNo,
    intContador: Integer;
    rowDado: TcxEditorRow;
    cdsParams: TUniClientDataSet;
Begin
  intRecNo := FParams.RecNo;

  For intContador := Low(FArrSQLVis) To High(FArrSQLVis) Do
    If Pos(':' + strNomPar, FArrSQLVis[intContador].strSQLVis) > 0 Then
    Begin
      rowDado := fRetRowDado(FArrSQLVis[intContador].strNomPar);

      If Assigned(rowDado) Then
      Begin
        If fEhParametroAutomatico(strNomPar) Then
          cdsParams := cdsParametrosAutomaticos
        Else
          cdsParams := FParams;

        rowDado.Visible := fParametroVisivel(FArrSQLVis[intContador].strSQLVis, True, cdsParams);

        If cdsParams.Locate('PAR_NOMPAR', rowDado.Name, []) Then
        Begin
          cdsParams.Edit;
          cdsParams.FieldByName('PARVIS').AsInteger := IfThen(rowDado.Visible, 1, 0);
          cdsParams.Post;
        End;

      End;
    End;

  FParams.RecNo := intRecNo;
End;

Function TInterfaceRelatorio.fRetornaComboBoxConfig(var strValorConfig: String; strEmpCfg: String; cdsParams: TUniClientDataSet; rowDado: TcxEditorRow): Boolean;
Var
  stlDescricao,
  stlValores: TStringList;
  strEmpresaConfig,
  strCodigoConfig: String;
Begin
  Result := False;

  If Assigned(rowDado.Properties) And
    (rowDado.Properties.EditPropertiesClass = TcxComboBoxProperties) And
      (cdsParams.Locate('PAR_NOMPAR', rowDado.Name, [])) Then
  Begin
    If Not fEmptyStr(cdsParams.FieldByName('PAR_CODCFG').AsString) Then
    Begin
      If fEmptyStr(AnsiReplaceStr(cdsParams.FieldByName('PAR_EMPCFG').AsString, ':', '')) Then
        strEmpresaConfig := VS_strCodEmp
      Else
        strEmpresaConfig := IIF(Length(strEmpCfg) <> 3, VS_strCodEmp, strEmpCfg);

      If fGetTipoConfig(cdsParams.FieldByName('PAR_TIPCFG').AsString) = cfgAutcom Then
        strCodigoConfig := fCfgSis(cdsParams.FieldByName('PAR_CODCFG').AsString, varString, strEmpresaConfig)
      Else
        strCodigoConfig := fCfgSpd(cdsParams.FieldByName('PAR_CODCFG').AsString, strEmpresaConfig);

      If (Not fEmptyStr(strCodigoConfig)) And (cdsParams.FieldByName('PAR_VALCFG').AsString = 'N') Then
      Begin
        stlDescricao := TStringList.Create;
        stlDescricao.Text := AnsiReplaceStr(cdsParams.FieldByName('PAR_FACTXT').AsString, '<<csq>>', #13#10);

        stlValores := TStringList.Create;
        stlValores.Text := AnsiReplaceStr(cdsParams.FieldByName('PAR_FACVAL').AsString, '<<csq>>', #13#10);

        strValorConfig := stlDescricao[stlValores.IndexOf(strCodigoConfig)];

        Result := Not fEmptyStr(strValorConfig);

        FreeAndNil(stlDescricao);
        FreeAndNil(stlValores);
      End;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAvaliaCheckListCustomizado(strNomPar: String);
  Var
    intContador, intIdx: Integer;
    blnAchou, blnDepende: Boolean;
    strValor, strSQLProv: String;
    slNomes: TStringList;
    qryProv: TUniQuery;
Begin
  For intContador := Low(FArrSelectCheckList) To High(FArrSelectCheckList) Do
  Begin
    If SameText(FArrSelectCheckList[intContador].strNomPar, strNomPar) Then
      Continue;

    strSQLProv := FArrSelectCheckList[intContador].strSqlOri;

    slNomes := TStringList.Create;
    Try
      qryProv := fCriaQuery(Nil);
      Try
        qryProv.SQL.Text := strSQLProv;
        blnDepende := Assigned(qryProv.Params.FindParam(strNomPar));
        For intIdx := 0 To qryProv.Params.Count - 1 Do
          slNomes.Add(qryProv.Params[intIdx].Name);
      Finally
        FreeAndNil(qryProv);
      End;

      If Not blnDepende Then
        Continue;

      fGetValorParametro(strNomPar, blnAchou);
      If Not blnAchou Then
        Continue;

      For intIdx := 0 To slNomes.Count - 1 Do
        If fTemMultiSelecao(slNomes[intIdx]) Then
          strSQLProv := fPoeMultiSelecao(strSQLProv, slNomes[intIdx],
                                         FValueParams.FieldByName('VALPAR').AsString);
    Finally
      slNomes.Free;
    End;

    FArrSelectCheckList[intContador].qryDados.Close;
    FArrSelectCheckList[intContador].qryDados.IndexFieldNames := '';
    FArrSelectCheckList[intContador].qryDados.SQL.Text := strSQLProv;

    For intIdx := 0 To FArrSelectCheckList[intContador].qryDados.Params.Count - 1 Do
    Begin
      strValor := fGetValorParametro(FArrSelectCheckList[intContador].qryDados.Params[intIdx].Name, blnAchou);
      If blnAchou Then
        FArrSelectCheckList[intContador].qryDados.Params[intIdx].AsString := strValor;
    End;

    FArrSelectCheckList[intContador].qryDados.Open;
    pSetaListaCheckListCustomizado(FArrSelectCheckList[intContador].strNomPar, FArrSelectCheckList[intContador].qryDados);
  End;
End;

Procedure TInterfaceRelatorio.pSetaListaCheckListCustomizado(strNomPar: String; qryDados: TUniQuery);
  Var
    cxRow: TcxEditorRow;
Begin
  cxRow := fRetRowDado(strNomPar);

  If Not Assigned(cxRow) Then
    Exit;

  With FFiltros, cxRow, Properties Do
  Begin

    With TcxCheckComboBoxProperties(EditProperties) Do
    Begin
      EmptySelectionText  := '';

      Items.BeginUpdate;
      Items.Clear;

      qryDados.First;
      While Not qryDados.Eof Do
      Begin
        Items.AddCheckItem(qryDados.Fields[0].AsString, qryDados.Fields[1].AsString);
        qryDados.Next;
      End;

      qryDados.IndexFieldNames := qryDados.Fields[1].FieldName;

      Items.EndUpdate;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAvaliaParametrosShow;
  Var
    intIndice: Integer;
Begin
  With FFiltros Do
  For intIndice := 0 To Rows.Count - 1 Do
  If (Not Rows[intIndice].IsCategory) Then
  Begin
    pAvaliaComboBoxConfig(Rows.Items[intIndice].Name);
    pAvaliaSQLVisibilParametro(Rows.Items[intIndice].Name);
    pAvaliaVisibilidadeCategoria(TcxEditorRow(Rows.Items[intIndice]));
  End;
End;

Function TInterfaceRelatorio.fAvaliaExpressao(strExpVis: String): Boolean;
  Var
    blnErro: Boolean;
    strExpres: String;
Begin
  Try
    strExpres := FGeraFr3.fColocaValoresExpressao(strExpVis, blnErro);

    If blnErro Then
      result := False
    Else
      Result := FGeraFr3.fExecutaExpressao(strExpres);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TInterfaceRelatorio.fAvaliaExpressao]');
    End;
  End;

End;

Function TInterfaceRelatorio.fAvaliaExpressaoString(strExpressao: String; Var blnErro: Boolean): String;
  Var
    strExpres: String;
Begin
  Try
    strExpres := FGeraFr3.fColocaValoresExpressao(strExpressao, blnErro);

    If blnErro Then
      result := ''
    Else
      Result := FGeraFr3.fExecutaExpressaoString(strExpres);

  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.message, '[TInterfaceRelatorio.fAvaliaExpressaoString]');
    End;
  End;

End;

Procedure TInterfaceRelatorio.pIncluiParametro(strNomPar: String; intLast, intQueries, intIndice: Integer; qryParam: TUniQuery; intOriPar: Integer);
Var
  strSeqGer: String;
  intOrdPai: Integer;
Begin

  strSeqGer := '';

  If intQueries = 0 Then
  Begin
    // Busca AUTOINCREM do relatório Pai, seja ele filho de TMP, Complementar ou Child
    If Not fEmptyStr(FCadRel[0].FieldByName('REL_CODPAI').AsString) Then
      strSeqGer := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [FCadRel[0].FieldByName('REL_CODPAI').AsString])
    Else
    Begin
      strSeqGer := fCampoTabela('REL_MASTER', 'SUBREL', ['REL_COMPLE'], [FCadRel[0].FieldByName('AUTOINCREM').AsString]);
      If fEmptyStr(strSeqGer) Then
        strSeqGer := fCampoTabela('REL_MASTER', 'CHIREL', ['REL_COMPLE'], [FCadRel[0].FieldByName('AUTOINCREM').AsString]);
    End;
  End;

  With FParams Do
  Begin
    strNomPar := Trim(strNomPar);
    If fEmptyStr(strNomPar) Then
      Exit;

    FieldByName('PAR_PESQUI').ReadOnly := False;
    FieldByName('PAR_GATPER').ReadOnly := False;

    If Locate('PAR_NOMPAR', strNomPar, []) Then
    Begin
      Edit;
    End Else
    Begin
      Append;
      intOrdPai := StrToIntDef(VarToStr(fRetDescricaoFiltro(strNomPar, 'ORDENA', strSeqGer)), 0);
      FieldByName('PAR_ORDENA').AsInteger := IIF(intOrdPai = 0, intLast, intOrdPai);
      FieldByName('PAR_NOMPAR').AsString  := strNomPar;
      FieldByName('PAR_DESPAR').Value := fRetDescricaoFiltro(strNomPar, 'DESPAR', strSeqGer);
      FieldByName('PAR_TIPFAC').Value := fRetDescricaoFiltro(strNomPar, 'TIPFAC', strSeqGer);
      FieldByName('PAR_TIPPAR').Value := fRetDescricaoFiltro(strNomPar, 'TIPPAR', strSeqGer);
      FieldByName('PAR_PESQUI').Value := fRetDescricaoFiltro(strNomPar, 'PESQUI', strSeqGer);
      FieldByName('PAR_FACTXT').Value := fRetDescricaoFiltro(strNomPar, 'FACTXT', strSeqGer);
      FieldByName('PAR_FACVAL').Value := fRetDescricaoFiltro(strNomPar, 'FACVAL', strSeqGer);
      FieldByName('PAR_VALCHK').Value := fRetDescricaoFiltro(strNomPar, 'VALCHK', strSeqGer);
      FieldByName('PAR_VALNCH').Value := fRetDescricaoFiltro(strNomPar, 'VALNCH', strSeqGer);
      FieldByName('PAR_VALDEF').Value := fRetDescricaoFiltro(strNomPar, 'VALDEF', strSeqGer);
      FieldByName('PAR_CHKDEF').Value := fRetDescricaoFiltro(strNomPar, 'CHKDEF', strSeqGer);
      FieldByName('PAR_DESTOD').Value := fRetDescricaoFiltro(strNomPar, 'DESTOD', strSeqGer);
      FieldByName('PAR_SQLCHK').Value := fRetDescricaoFiltro(strNomPar, 'SQLCHK', strSeqGer);
      FieldByName('PAR_SQLVIS').Value := fRetDescricaoFiltro(strNomPar, 'SQLVIS', strSeqGer);
      FieldByName('PAR_EXPVIS').Value := fRetDescricaoFiltro(strNomPar, 'EXPVIS', strSeqGer);
      FieldByName('PAR_EXPIMP').Value := fRetDescricaoFiltro(strNomPar, 'EXPIMP', strSeqGer);
      FieldByName('PAR_CHKDEF').AsString  := 'N';
      FieldByName('PAR_TABATI').AsString  := 'N';
      FieldByName('PAR_SIMPLE').AsString  := 'N';
      FieldByName('PAR_DEFEMP').AsString  := 'N';
      FieldByName('PAR_GATPER').AsString  := 'N';

      FieldByName('PAR_ORIPAR').AsInteger := intOriPar;

      If (intQueries > Low(FQueryFiltros)) And (FCadRel[intQueries].FindParam('AUTINC') <> Nil) And
         fBuscaParametro(qryParam, FieldByName('PAR_NOMPAR').AsString, FCadRel[intQueries].ParamByName('AUTINC').AsString) Then
      Begin
        FieldByName('PAR_DESPAR').Value := qryParam.FieldByName('PAR_DESPAR').Value;
        FieldByName('PAR_TIPFAC').Value := qryParam.FieldByName('PAR_TIPFAC').Value;
        FieldByName('PAR_TIPPAR').Value := qryParam.FieldByName('PAR_TIPPAR').Value;
        FieldByName('PAR_PESQUI').Value := qryParam.FieldByName('PAR_PESQUI').Value;
        FieldByName('PAR_FACTXT').Value := qryParam.FieldByName('PAR_FACTXT').Value;
        FieldByName('PAR_FACVAL').Value := qryParam.FieldByName('PAR_FACVAL').Value;
        FieldByName('PAR_VALCHK').Value := qryParam.FieldByName('PAR_VALCHK').Value;
        FieldByName('PAR_VALNCH').Value := qryParam.FieldByName('PAR_VALNCH').Value;
        FieldByName('PAR_VALDEF').Value := qryParam.FieldByName('PAR_VALDEF').Value;
        FieldByName('PAR_CHKDEF').Value := qryParam.FieldByName('PAR_CHKDEF').Value;
        FieldByName('PAR_DESTOD').Value := qryParam.FieldByName('PAR_DESTOD').Value;
        FieldByName('PAR_SQLCHK').Value := qryParam.FieldByName('PAR_SQLCHK').Value;
        FieldByName('PAR_SQLVIS').Value := qryParam.FieldByName('PAR_SQLVIS').Value;
        FieldByName('PAR_EXPVIS').Value := qryParam.FieldByName('PAR_EXPVIS').Value;
        FieldByName('PAR_EXPIMP').Value := qryParam.FieldByName('PAR_EXPIMP').Value;
        FieldByName('PAR_OBRIGA').Value := qryParam.FieldByName('PAR_OBRIGA').Value;
        FieldByName('PAR_CODGRU').Value := qryParam.FieldByName('PAR_CODGRU').Value;
      End;

    End;

    FieldByName('PAR_POSREL').AsInteger := intQueries;
    FieldByName('PAR_POSICA').AsInteger := intIndice;

    If FieldByName('PAR_ORDENA').IsNull Then
      FieldByName('PAR_ORDENA').AsInteger := intLast;

    FieldByName('PAR_CNDVIS').AsString := '';

    if FieldByName('PAR_SQLVIS').AsString <> '' then
      FieldByName('PAR_CNDVIS').AsString  := 'Sim';

    if FieldByName('PAR_EXPVIS').AsString <> '' then
      FieldByName('PAR_CNDVIS').AsString  := 'Sim';

    if FieldByName('PAR_EXPIMP').AsString <> '' then
      FieldByName('PAR_CNDVIS').AsString  := 'Sim';

    Post;
  End;
End;

Procedure TInterfaceRelatorio.pIncluiParametroLimits;
  Var
    intLast,
    intContador: Integer;
Begin
  For intContador := 0 To FLimits.Count - 1 Do
  Begin
    intLast := FParams.RecordCount + 1;
    pIncluiParametro(FLimits[intContador], intLast, -1, intLast + intContador, Nil, 2);
  End;
End;

Function TInterfaceRelatorio.fSQLBuscaParametroValidacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM CADPRR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PAR_SEQGER = (SELECT C.AUTOINCREM FROM CADREL C WHERE C.REL_CODREL = :CODREL) AND PAR_AUTOMA NOT IN ("S", "P") ';

  Result := strSQL;
End;

Procedure TInterfaceRelatorio.pCarregaParametrosValidacao;
Begin
  If Not fEmptyStr(FCadRel[0].FieldByName('REL_CODVAL').AsString) Then
  Begin
    If Not Assigned(FParamValidacao) Then
      FParamValidacao := fCriaQuery(Self);

    FParamValidacao.Close;
    FParamValidacao.SQL.Text := fSQLBuscaParametroValidacao;
    FParamValidacao.ParamByName('CODREL').AsString := FCadRel[0].FieldByName('REL_CODVAL').AsString;
    FParamValidacao.Open;
    FParamValidacao.IndexFieldNames := 'PAR_NOMPAR';
    FParamValidacao.KeyFields := 'PAR_NOMPAR';
  End;
End;

Function TInterfaceRelatorio.fIncluiParametrosValidacao: Boolean;
  Var
    intIndice,
    intCampos,
    intLast: Integer;
Begin
  Try
    pCarregaParametrosValidacao;

    intIndice := 0;

    FParamValidacao.First;
    While Not FParamValidacao.Eof Do
    Begin

      If Not FParams.Locate('PAR_NOMPAR', FParamValidacao.FieldByName('PAR_NOMPAR').AsString, []) Then
      Begin
        intLast := FParams.RecordCount + 1;

        intIndice := Succ(intIndice);

        FParams.Append;

        For intCampos := 0 To FParamValidacao.Fields.Count - 1 Do
          If Pos(FParamValidacao.Fields[intCampos].FieldName, 'AUTOINCREM-PAR_SEQGER') = 0 Then
            FParams.FieldByName(FParamValidacao.Fields[intCampos].FieldName).Value := FParamValidacao.Fields[intCampos].Value;

        FParams.FieldByName('PAR_ORDENA').AsInteger := intLast;
        FParams.FieldByName('PAR_GATPER').AsString  := 'N';
        FParams.FieldByName('PAR_ORIPAR').AsInteger := 3;
        FParams.FieldByName('PAR_POSREL').AsInteger := -1;
        FParams.FieldByName('PAR_POSICA').AsInteger := intLast + intIndice;

        FParams.FieldByName('PAR_CNDVIS').AsString := '';

        if FParams.FieldByName('PAR_SQLVIS').AsString <> '' then
          FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        if FParams.FieldByName('PAR_EXPVIS').AsString <> '' then
          FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        if FParams.FieldByName('PAR_EXPIMP').AsString <> '' then
          FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        FParams.FieldByName('IMPFIL').AsInteger := 1;

        FParams.Post;
      End;

      FParamValidacao.Next;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TInterfaceRelatorio.fIncluiParametrosValidacao]');
    End;
  End;
End;

Function TInterfaceRelatorio.fAtualizaParametros(blnQueriesComplentares: Boolean): Boolean;
  Var
    intLast,
    intIndice,
    intQueries: Integer;
    qryParam: TUniQuery;
    pAfterPostParams: TAfterPost;
Begin
  Result := True;

  pAfterPostParams := FParams.AfterPost;
  FParams.AfterScroll := Nil;
  FParams.AfterPost   := Nil;

  qryParam := fCriaQuery(Nil);

  Try
    qryParam.SQL.Text := fSQLBuscaParametro;

    If blnQueriesComplentares Then
    Begin
      pCarregaQueriesComplentares(False);

      For intQueries := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
      Begin
        For intIndice := 0 To FQueryFiltros[intQueries].Params.Count - 1 Do
        Begin
          intLast := FParams.RecordCount + 1;

          pIncluiParametro(FQueryFiltros[intQueries].Params[intIndice].Name, intLast, intQueries, intIndice, qryParam, 0);
        End;
      End;

      pIncluiParametroLimits;

      If Not fEmptyStr(FCadRel[0].FieldByName('REL_CODVAL').AsString) Then
      Begin
        Result := fIncluiParametrosValidacao;

        If Not Result Then
          Exit;
      End;

    End Else
    Begin

      For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
      Begin
        For intIndice := 0 To FComFilFiltros[intQueries].Params.Count - 1 Do
        Begin
          intLast := FParams.RecordCount + 1;

          pIncluiParametro(FComFilFiltros[intQueries].Params[intIndice].Name, intLast, 0, FQueryFiltros[0].Params.Count + intIndice, qryParam, 0);
        End;
      End;

    End;

  Finally
    FreeAndNil(qryParam);
  End;

  pAtualizaParametrosGatilho;

  FParams.AfterScroll := pAfterScrollParams;
  FParams.AfterPost   := pAfterPostParams;
End;

Function TInterfaceRelatorio.fGetComFilComplementos: String;
Begin
  Result := FComFilComplementos.Text;
End;

Function TInterfaceRelatorio.fTiraEspacosMemo(strInfo: String): String;
  Var
    intIndice: Integer;
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  stlLista.Text := AnsiReplaceStr(strInfo, '<<csq>>', #13#10);

  For intIndice := 0 To stlLista.Count - 1 Do
    stlLista[intIndice] := Trim(stlLista[intIndice]);

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Procedure TInterfaceRelatorio.pSetComFilComplementos(Const Value: String);
  Var
    intLast,
    intIndice: Integer;
    strValue: String;
Begin
  strValue := AnsiReplaceStr(Value, '<<csq>>', #13#10);

  If Not SameText(value, FComFilComplementos.Text) Then
  Begin
    FComFilComplementos.Text := strValue;

    intLast := FParams.RecordCount + 1;

    FParams.AfterScroll := Nil;

    For intIndice := 0 To FComFilComplementos.Count - 1 Do
      pIncluiParametro(FComFilComplementos[intIndice], intLast, 0, intIndice, Nil, 1);

    FParams.AfterScroll := pAfterScrollParams;
  End;
End;

Procedure TInterfaceRelatorio.pAfterScrollParams(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    FieldByName('PAR_PESQUI').ReadOnly := FieldByName('PAR_ORIPAR').AsInteger = 1;

    FieldByName('PAR_GATPER').ReadOnly := FieldByName('PAR_TIPPAR').AsString <> 'Data';
  End;
End;

Procedure TInterfaceRelatorio.pBeforePostParams(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If (FieldByName('PAR_ORIPAR').AsInteger = 1) And
       (Not fEmptyStr(FieldByName('PAR_TIPFAC').AsString)) And
       (Pos(FieldByName('PAR_TIPFAC').AsString, 'Texto_Número decimal_Número Inteiro_Data') = 0) Then
    Begin
      FieldByName('PAR_TIPFAC').AsString := '';
      pMensagemOk('Os complementos de Filtros podem ser definidos apenas como Texto, Número decimal, Número inteiro ou Data');
      Application.ProcessMessages;
      Abort;
    End;

    If SameText(FieldByName('PAR_GATPER').AsString, 'S') And
       (Pos(FieldByName('PAR_TIPPAR').AsString, 'Data') = 0) Then
    Begin
      FieldByName('PAR_GATPER').AsString := 'N';
      FieldByName('PAR_PARFIN').Clear;
      FieldByName('PAR_DESGAT').Clear;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pLimpaParametrosExcluidos;
Begin
  Try

    FParams.DisableControls;
    FParams.indexfieldnames := 'PAR_ORDENA';
    FParams.First;

    While Not FParams.Eof Do
    Begin
      If Not fExisteParametro(FParams.FieldByName('PAR_NOMPAR').AsString,
                              FParams.FieldByName('PAR_ORIPAR').AsInteger) Then
      Begin
        FParams.Delete
      End Else
      Begin
        FParams.Edit;
        FParams.FieldByName('PAR_ORDENA').AsInteger := FParams.RecNo;
        FParams.Post;

        FParams.Next;
      End;
    End;

    pSetaParamsObrigatorios;

    FParams.EnableControls;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TInterfaceRelatorio.pLimpaParametrosExcluidos]');
    End;
  End;

End;

Function TInterfaceRelatorio.fPodeHorizontalizar(blnMultLines: Boolean): Boolean;
  Var
    intIndice,
    intInicio: Integer;
    fdtTipo: TFieldType;
Begin
  Result := fAbreConsultaCampos;

  If Not Result Then
    Exit;

  If blnMultLines Then
    intInicio := 1
  Else
    intInicio := 0;

  fdtTipo := FQueryFiltros[0].Fields[intInicio].DataType;

  For intIndice := Succ(intInicio) To FQueryFiltros[0].Fields.Count - 1 Do
    If fdtTipo <> FQueryFiltros[0].Fields[intIndice].DataType Then
    Begin
      Result := False;
      Exit;
    End;
End;

Function TInterfaceRelatorio.fRetPreCusTeste: String;
  Var
    intContador: Integer;
Begin
  Result := ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR[Low(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR)];

  For intContador := Succ(Low(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR)) To High(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR) Do
    Result := Result + ' + ' + ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR[intContador];

  Result := 'ABS((((' + Result + '))))';
End;

Function TInterfaceRelatorio.fTemCampoCusto(strMessage: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := Low(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR) To High(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR) Do
    If Pos(ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR[intContador], strMessage) > 0 Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TInterfaceRelatorio.fTemCampoPreCusSemAlias(qryFiltro: TUniQuery): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 0 To qryFiltro.FieldCount - 1 Do
    If Pos(fRetPreCusTeste, qryFiltro.Fields[intContador].FieldName) > 0 Then
    Begin
      Result := True;
      Exit;
    End;
End;

Function TInterfaceRelatorio.fTemComandosProibidos(strSQL: String): Boolean;
Begin
  Result := False;

  strSQL := UpperCase(strSQL);

  If (Pos('DELETE', strSQL) > 0)   Or
     (Pos('DROP', strSQL) > 0)     Or
     (Pos('REPLACE INTO', strSQL) > 0)  Or
     (Pos('TRUNCATE TABLE', strSQL) > 0) Or
     (Pos('UPDATE', strSQL) > 0) Then
  Begin
    pMensagemOk('Os comandos DELETE, DROP, REPLACE INTO, TRUNCATE TABLE e UPDATE não são permitidos!');
    Result := True;
    Exit;
  End;

End;

Function TInterfaceRelatorio.fAbreConsultaCampos: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fAbreConsultaCamposPrg, frmGravando, 'Carregando campos do relatório...');
End;

Function TInterfaceRelatorio.fAbreConsultaCamposPrg(prgProgresso: TcxProgressBar): Boolean;
  Var
    intQuerie: Integer;
    strMsgErr: String;
Begin
  Result := True;

  Try
    If blnApagaTemporarias Then
      pDropTemporarias;

    strMsgErr := '';

    prgProgresso.Properties.Max := IIF(blnApenasPrincipal, 1, Length(FQueryFiltros));

    For intQuerie := Low(FQueryFiltros) To IIF(blnApenasPrincipal, Low(FQueryFiltros), HiGh(FQueryFiltros)) Do
    Begin
      If Assigned(FQueryFiltros[intQuerie]) Then
      Begin
        FQueryFiltros[intQuerie].Close;

        If fTemComandosProibidos(FQueryFiltros[intQuerie].SQL.Text) Then
        Begin
          FSQLErro := True;
          Result := False;
          Exit;
        End;

        If fEmptyStr(FQueryFiltros[intQuerie].SQL.Text) Then
        Begin
          Result := False;
        End Else if (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') then
        Begin
          FQueryFiltros[intQuerie].ExecSQL;
        End Else
        Begin
          FQueryFiltros[intQuerie].Open;
        End;

        If fTemCampoPreCusSemAlias(FQueryFiltros[intQuerie]) Then
        Begin
          Raise Exception.Create('O campo ' + STR_PRECUS + ' dever ser utilizado com um Alias. Exemplo: ' + STR_PRECUS + ' AS PRECUS !');
        End;
      End; {If Assigned(FQueryFiltros[intQuerie]) Then}

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End; {For intQuerie := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do}

  Except
    On E: Exception Do
    Begin
      Result := False;
      FSQLErro := True;

      If (Pos(STR_PRECUS, FSQLFormatado[0]) > 0) And
         (Pos('Unknown column', E.Message) > 0) And
         fTemCampoCusto(E.Message) Then
        strMsgErr := 'As tabelas ou views utilizadas não contém os campos para a montagem da Composição do Preço de Custo (' + STR_PRECUS + ')!'
      Else
        strMsgErr :=  E.Message;

      pCriarFormularios(TfrmMsgErroSQL, frmMsgErroSQL);
      frmMsgErroSQL.mmoErrSQL.Lines.text := strMsgErr;
      frmMsgErroSQL.ShowModal;
      pFreeAndNil(frmMsgErroSQL);

      Exit;
    End;

  End;

  FSQLErro := False;
End;

Function TInterfaceRelatorio.fRetDescricaoCampo(strCodCam: String): String;
Begin
  With FqryCadGetDesc Do
  Begin
    Close;
    ParambyName('NOMCAM').AsString := strCodCam;
    Open;

    If IsEmpty Then
      Result := ''
    Else
      Result := fTrataDesCam(FieldByName('CAM_DESCAM').AsString);
  End;
End;

Function TInterfaceRelatorio.fRetDescricaoFiltro(strCodPrr, strTipoRetorno, strSeqGer: String): Variant;
Begin
  With FqryCadGetDescPrr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fSQLCadGetDescPrr(strSeqGer));
    ParambyName('NOMPAR').AsString := strCodPrr;
    If Not fEmptyStr(strSeqGer) Then
      ParambyName('SEQGER').AsString := strSeqGer;
    Open;

    If IsEmpty Then
      Result := ''
    Else
    Begin
      case AnsiIndexStr(strTipoRetorno, ['DESPAR', 'TIPFAC', 'TIPPAR', 'PESQUI', 'FACTXT', 'FACVAL', 'VALCHK', 'VALNCH', 'VALDEF', 'CHKDEF', 'DESTOD', 'SQLCHK', 'SQLVIS', 'EXPVIS', 'EXPIMP', 'ORDENA']) of
        0  : Result := FieldByName('PAR_DESPAR').Value;
        1  : Result := FieldByName('PAR_TIPFAC').Value;
        2  : Result := FieldByName('PAR_TIPPAR').Value;
        3  : Result := FieldByName('PAR_PESQUI').Value;
        4  : Result := FieldByName('PAR_FACTXT').Value;
        5  : Result := FieldByName('PAR_FACVAL').Value;
        6  : Result := FieldByName('PAR_VALCHK').Value;
        7  : Result := FieldByName('PAR_VALNCH').Value;
        8  : Result := FieldByName('PAR_VALDEF').Value;
        9  : Result := FieldByName('PAR_CHKDEF').Value;
        10 : Result := FieldByName('PAR_DESTOD').Value;
        11 : Result := FieldByName('PAR_SQLCHK').Value;
        // As condições de vibilidade e ordenação só serão copiadas se for um relatório pai TMP, Complementar ou Child
        12 : Result := IIF(FieldByName('REL_RELPAI').AsString = 'S', FieldByName('PAR_SQLVIS').Value, Null);
        13 : Result := IIF(FieldByName('REL_RELPAI').AsString = 'S', FieldByName('PAR_EXPVIS').Value, Null);
        14 : Result := IIF(FieldByName('REL_RELPAI').AsString = 'S', FieldByName('PAR_EXPIMP').Value, Null);
        15 : Result := IIF(FieldByName('REL_RELPAI').AsString = 'S', FieldByName('PAR_ORDENA').Value, Null);
      end;
    End;
  End;
End;

Class Function TInterfaceRelatorio.fTrataDesCam(strDesCam: String): String;
Begin
  Result := Trim(AnsiReplaceStr(strDesCam, '<<csq>>', ' '));
End;

Function TInterfaceRelatorio.fPodeQuebrar(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
Begin
  Result := FOrderBy.Find(strNomCam, intIndex);
End;

Function TInterfaceRelatorio.fRetPosOrdem(strNomCam: String): Integer;
  Var
    intIndex: Integer;
Begin
  Result := -1;
  For intIndex := 0 To FOrderByOriginal.Count - 1 Do
    If SameText(strNomCam, FOrderByOriginal[intIndex]) Then
    Begin
      Result := intIndex;
      Exit;
    End;

End;

Function TInterfaceRelatorio.fMudouHorizo: Boolean;
Begin
  Result := False;

  If Assigned(FCadRel[0]) Then
  Begin
    Result  := (Not SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, FstrHorizo)) Or
               (FIntMaxCol <> FCadRel[0].FieldByName('REL_MAXCOL').AsInteger);

    FstrHorizo := FCadRel[0].FieldByName('REL_HORIZO').AsString;
    FIntMaxCol := FCadRel[0].FieldByName('REL_MAXCOL').AsInteger;
  End;
End;

Function TInterfaceRelatorio.fAtualizaCampos: Boolean;
  Var
    intIndice: Integer;
    dstFiltros: TDataSet;
    blnSemCampos: Boolean;
    prcAfterPost: TAfterPost;
    blnMudouCampos: Boolean;
    intQtdReg: Integer;
Begin
  blnMudouCampos := False;

  pAtualizaCamposOrderBy;

  Result := fAbreConsultaCampos;

  If Not Result Then
    Exit;

  If Assigned(FCadRel[0]) And
     (SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'S')  Or
      SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'I')) Then
  Begin

    If Not fCriaHorizo(0) Then
    Begin
      Result := True;
      Exit;
    End;

    dstFiltros := FHorizo[0];

  End Else
  Begin
    dstFiltros := FQueryFiltros[0];
  End;

  prcAfterPost := FCampos.AfterPost;
  FCampos.AfterPost := Nil;

  blnSemCampos := FCampos.IsEmpty;

  blnTemArquivoSaida := False;

  if FCadRel[0].State In dsEditModes then
  begin
    FCadRel[0].FieldByName('REL_ARQSAI').AsString := 'N';
    FCadRel[0].FieldByName('REL_GATWPP').AsString := 'N';
    FCadRel[0].FieldByName('REL_GATEMA').AsString := 'N';
    FCadRel[0].FieldByName('REL_GATASS').AsString := 'N';
    FCadRel[0].FieldByName('REL_GATCOR').AsString := 'N';
  end;

  For intIndice := 0 To dstFiltros.Fields.Count - 1 Do
  Begin
    If (LeftStr(dstFiltros.Fields[intIndice].FieldName, 1) = '@') AND (POS(' AS ', dstFiltros.Fields[intIndice].FieldName) = 0) Then
      Continue;

    If SameText(dstFiltros.Fields[intIndice].FieldName, STR_ARQUIVO_SAIDA) Then
    Begin
      if FCadRel[0].State In dsEditModes then
        FCadRel[0].FieldByName('REL_ARQSAI').AsString := 'S';
      blnTemArquivoSaida := True;
      Continue;
    End;

    If SameText(dstFiltros.Fields[intIndice].FieldName, STR_GATILHO_WHATSAPP) And Assigned(FGeraFr3) Then
    Begin
      if FCadRel[0].State In dsEditModes then
        FCadRel[0].FieldByName('REL_GATWPP').AsString := 'S';

      FGeraFr3.blnTemNumWppGat := True;
      Continue;
    End;

    If SameText(dstFiltros.Fields[intIndice].FieldName, STR_GATILHO_EMAIL) And Assigned(FGeraFr3) Then
    Begin
      if FCadRel[0].State In dsEditModes then
        FCadRel[0].FieldByName('REL_GATEMA').AsString := 'S';

      FGeraFr3.blnTemEmailGat := True;
      Continue;
    End;

    If SameText(dstFiltros.Fields[intIndice].FieldName, STR_GATILHO_ASSUNTO) And Assigned(FGeraFr3) Then
    Begin
      if FCadRel[0].State In dsEditModes then
        FCadRel[0].FieldByName('REL_GATASS').AsString := 'S';

      FGeraFr3.blnTemAssuntoGat := True;
      Continue;
    End;

    If SameText(dstFiltros.Fields[intIndice].FieldName, STR_GATILHO_CORPO) And Assigned(FGeraFr3) Then
    Begin
      if FCadRel[0].State In dsEditModes then
        FCadRel[0].FieldByName('REL_GATCOR').AsString := 'S';

      FGeraFr3.blnTemCorpoGat := True;
      Continue;
    End;

    If FCampos.Locate('CAM_NOMCAM', dstFiltros.Fields[intIndice].FieldName, []) Then
    Begin
      FCampos.Edit;

    End Else
    Begin // INCLUINDO NOVOS CAMPOS
      blnMudouCampos := True;

      intQtdReg := FCampos.RecordCount;

      FCampos.Append;

      FCampos.FieldByName('CAM_POSICA').AsInteger := intQtdReg;

      FCampos.FieldByName('CAM_NOMCAM').AsString  := dstFiltros.Fields[intIndice].FieldName;

      FCampos.FieldByName('CAM_DESCAM').AsString  := fRetDescricaoCampo(FCampos.FieldByName('CAM_NOMCAM').AsString);

      If fEmptyStr(FCampos.FieldByName('CAM_DESCAM').AsString) Then
        FCampos.FieldByName('CAM_DESCAM').AsString := FCampos.FieldByName('CAM_NOMCAM').AsString;

      FCampos.FieldByName('CAM_LISTAR').AsString := '1';
      FCampos.FieldByName('CAM_QUEBRA').AsString := 'N';
      FCampos.FieldByName('CAM_NEWPAG').AsString := 'N';
      FCampos.FieldByName('CAM_REPRIN').AsString := 'N';
      FCampos.FieldByName('CAM_LISQUE').AsString := '';
      FCampos.FieldByName('CAM_STRETC').AsString := 'N';

      FCampos.FieldByName('VISIVEL').AsInteger := -1;
      FCampos.FieldByName('LARGURA_REAL').AsInteger := -1;

      FCampos.FieldByName('CAM_LARGUR').AsFloat  := fGetTamanhoCampo(FCampos.FieldByName('CAM_NOMCAM').AsString, blnSemCampos);
    End;

    Case dstFiltros.Fields[intIndice].DataType Of
      ftLargeint,
      ftInteger,
      ftWord     : FCampos.FieldByName('CAM_TIPCAM').AsString := String(ArrDesInterface[facInteger]);

      ftFloat    : Begin
                     FCampos.FieldByName('CAM_TIPCAM').AsString  := String(ArrDesInterface[facFloat]);
                     If (FCampos.FieldByName('CAM_NRODEC').IsNull) Or (FCampos.State = dsInsert) Then
                       FCampos.FieldByName('CAM_NRODEC').AsInteger := 2;
                   End;

      ftDate     : FCampos.FieldByName('CAM_TIPCAM').AsString := String(ArrDesInterface[facDate]);
      Else         FCampos.FieldByName('CAM_TIPCAM').AsString := String(ArrDesInterface[facString]);
    End;

    FCampos.FieldByName('CAM_POSORD').AsInteger := fRetPosOrdem(FCampos.FieldByName('CAM_NOMCAM').AsString);

    FCampos.FieldByName('CAM_CNDVIS').AsString  := '';

    if FCampos.FieldByName('CAM_EXPVIS').AsString <> '' then
      FCampos.FieldByName('CAM_CNDVIS').AsString  := 'Sim';

    if FCampos.FieldByName('CAM_QUAQUE').AsString <> '' then
      FCampos.FieldByName('CAM_CNDVIS').AsString  := 'Sim';

    If FCampos.FieldByName('CAM_POSORD').AsInteger = -1 Then
      FCampos.FieldByName('CAM_QUEBRA').AsString := 'N';

    FCampos.Post;
  End;

  FListaCampos.Clear;

  FCampos.DisableControls;
  FCampos.First;
  While Not FCampos.Eof Do
  Begin
    If dstFiltros.FindField(FCampos.FieldByName('CAM_NOMCAM').AsString) = Nil Then
    Begin
      FCampos.Delete;

      blnMudouCampos := True;
    End Else
    Begin
      FListaCampos.Add(FCampos.FieldByName('CAM_NOMCAM').AsString);
      FCampos.Next;
    End;
  End;

  FCampos.AfterPost := prcAfterPost;

  FCampos.EnableControls;

  If blnSemCampos Then
    pCalculaTamanhoColunas;

  Result := True;

  If blnMudouCampos Then
    pCriaComponentes;
 End;

Function TInterfaceRelatorio.fGetTamanhoCampo(strNomCam: String; blnSemCampos: Boolean): Double;
  Var
    filCampo: TField;
    blnJato: Boolean;
Begin
  blnJato := SameText(FCadRel[0].FieldByName('REL_TIPIMP').AsString, 'J');

  If blnJato Then
    Result := 2
  Else
    Result := 15;

  If Not FQueryFiltros[0].Active Then
  Begin
    If Not fAbreConsultaCampos Then
      Exit;
  End;

  filCampo := FQueryFiltros[0].FindField(strNomCam);

  If Not Assigned(filCampo) Then
    Exit;

  Case filCampo.DataType Of
    ftTime    : If blnJato Then
                  Result := 1
                Else
                  Result := 5;

    ftDate    : If blnJato Then
                  Result := 1.5
                Else
                  Result := 10;

    ftDateTime: If blnJato Then
                  Result := 2
                Else
                  Result := 16;

    ftFloat   : If blnJato Then
                  Result := 2
                Else
                  Result := 12;
    ftLargeint,
    ftInteger,
    ftWord,
    ftSmallint: If blnJato Then
                  Result := 1.5
                Else
                  Result := 6;

    ftString  : Begin
                  If filCampo.DataSize <= MAX_TAMANHO_COMPLETO_STRING Then
                  Begin
                    Result := filCampo.DataSize
                  End Else
                  Begin

                    If blnSemCampos Then
                    Begin
                      Result := 0;
                    End Else
                    Begin
                      If blnJato Then
                        Result := 2
                      Else
                        Result := 15;
                    End;

                  End;

                  If blnJato Then
                    Result := Result * 0.15
                End;
  End;
End;

Procedure TInterfaceRelatorio.pCalculaTamanhoColunas;
  Var
    fltRestante,
    fltTotLargura: Double;
    filCampo: TField;
    prcAfterPost: TAfterPost;
Begin
  fltTotLargura := 0;
  fltRestante   := FGeraFr3.fGetMaxLarCam(fGetQtdCamListados(1)) - fGetLarguraUsada(1);

  If (fGetQtdCamListados(1) = 0) And (FCampos.RecordCount > 0) Then
    fltRestante := fltRestante - FGeraFr3.fGetLarguraEspacamentoUsada(FCampos.RecordCount + 1);

  If fltRestante < 0 Then
    fltRestante := 0;

  FCampos.DisableControls;

  prcAfterPost := FCampos.AfterPost;
  FCampos.AfterPost := Nil;

  FCampos.First;
  While Not FCampos.Eof Do
  Begin

    If (FCampos.FieldByName('CAM_LARGUR').AsFloat = 0) Then
    Begin
      filCampo := FQueryFiltros[0].FindField(FCampos.FieldByName('CAM_NOMCAM').AsString);

      If Assigned(filCampo) Then
        fltTotLargura := fltTotLargura + filCampo.DataSize;

    End Else
    Begin
      fltRestante := fltRestante - FCampos.FieldByName('CAM_LARGUR').AsFloat;
    End;

    FCampos.Next;
  End;

  If fltRestante <= 0 Then
    fltRestante := 0;

  FCampos.First;
  While Not FCampos.Eof Do
  Begin

    If (FCampos.FieldByName('CAM_LARGUR').AsFloat = 0) Then
    Begin
      filCampo := FQueryFiltros[0].FindField(FCampos.FieldByName('CAM_NOMCAM').AsString);

      If Assigned(filCampo) Then
      Begin
        FCampos.Edit;

        If fltTotLargura > 0 Then
        Begin
          FCampos.FieldbyName('CAM_LARGUR').AsFloat := filCampo.DataSize * (fltRestante / fltTotLargura);

          If Not SameText(FCadRel[0].FieldByName('REL_TIPIMP').AsString, 'J') Then
            FCampos.FieldbyName('CAM_LARGUR').AsFloat := Trunc(FCampos.FieldbyName('CAM_LARGUR').AsFloat);

        End

        Else FCampos.FieldbyName('CAM_LARGUR').AsFloat := 0;

        FCampos.Post;
      End;
    End;

    FCampos.Next;
  End;

  FCampos.AfterPost := prcAfterPost;

  FCampos.EnableControls;
End;

Function TInterfaceRelatorio.fCarregaParametros(strSeqGer, strComFil: String): Boolean;
Begin
  FParams.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
  Result := FParams.fAbreClient(True, 'TInterfaceRelatorio.fCarregaParametros') And
            fCarregaGruposParametros(strSeqGer) And
            fCarregaParametrosAutomaticos(strSeqGer) And
            fCarregaParametrosGatilho(strSeqGer);

  strComFilComplementos := strComFil;

  FParams.IndexFieldNames := 'PAR_ORDENA';

  FParams.BeforeEdit  := pBeforeEditParams;
  FParams.BeforePost  := pBeforePostParams;
  FParams.AfterScroll := pAfterScrollParams;
End;

Function TInterfaceRelatorio.fCarregaGruposParametros(strSeqGer: String): Boolean;
Begin
  FGruposParams.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
  Result := FGruposParams.fAbreClient(True, 'TInterfaceRelatorio.fCarregaGruposParametros');

  FGruposParams.BeforePost := pBeforePostGrupoParams;
End;

Procedure TInterfaceRelatorio.pExcluiGrupoParametro;
Begin
  If FGruposParams.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do grupo ' + FGruposParams.FieldByName('GRU_NOMGRU').AsString + '?') Then
  Begin
    FParams.First;
    While Not FParams.Eof Do
    Begin

      If FParams.FieldByName('PAR_CODGRU').AsString = FGruposParams.FieldByName('GRU_CODGRU').AsString Then
      Begin
        FParams.Edit;
        FParams.FieldByName('PAR_CODGRU').Clear;
        FParams.Post;
      End;

      FParams.Next;
    End;

    FGruposParams.Delete;
  End;
End;

Function TInterfaceRelatorio.fInsereLoteNovoGrupo: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin

  Result := False;

  if fPergunta('Confirma inclusão dos 20 grupos de filtros mais utilizados no editor?') then
  begin
    try

      Result := TfrmGravando.fExecuta(fInsereLoteNovoGrupoProgresso, frmGravando, 'Inserindo grupos de filtros mais utilizados...');

    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TInterfaceRelatorio.fInsereLoteNovoGrupo]');
      end;
    end;
  end;
End;

Function TInterfaceRelatorio.fInsereLoteNovoGrupoProgresso(Progress : TcxProgressBar): Boolean;
var
  qryLoteGrupo: TUniQuery;
begin
  qryLoteGrupo := fCriaQuery(Nil);
  try
    with qryLoteGrupo, qryLoteGrupo.SQL do
    begin
      Close;
      Clear;
      Add('SELECT TRIM(GRU_NOMGRU) AS NOMGRU FROM GRUPAR WHERE GRU_TIPGRU = 0 GROUP BY GRU_NOMGRU ORDER BY COUNT(*) DESC LIMIT 20');
      Open;

      if not IsEmpty then
      begin
        if Assigned(Progress) then
        begin
          Progress.Properties.Max := RecordCount;
          Progress.Position       := 0;
        end;
        Application.ProcessMessages;

        First;
        while not Eof do
        begin
          pInsereNovoGrupo(FieldByName('NOMGRU').AsString, True, True);
          Next;

          if Assigned(Progress) then
            Progress.Position := Progress.Position + 1;

          Application.ProcessMessages;
        end;
      end;
    end;
  finally
    FreeAndNil(qryLoteGrupo);
    Result := True;
  end;
end;

Procedure TInterfaceRelatorio.pReplicaFonteOutrosCampos;
var
  intRecNo: Integer;
  strFntCnd, strFntCam: string;
begin
  if fPergunta('Confirma a replicação dessa fonte personalizada para os outros campos listados?') then
  begin
    intRecNo := FCampos.RecNo;
    FCampos.DisableControls;
    try
      strFntCnd := FCampos.FieldByName('CAM_FNTCND').AsString;
      strFntCam := FCampos.FieldByName('CAM_FNTCAM').AsString;
      FCampos.First;
      while not FCampos.Eof do
      begin
        if (FCampos.RecNo <> intRecNo) and (not fEmptyStr(FCampos.FieldByName('CAM_LISTAR').AsString)) then
        begin
          FCampos.Edit;
          FCampos.FieldByName('CAM_FNTCND').AsString := strFntCnd;
          FCampos.FieldByName('CAM_FNTCAM').AsString := strFntCam;
          FCampos.Post;
        end;
        FCampos.Next;
      end;
    finally
      FCampos.RecNo := intRecNo;
      FCampos.EnableControls;
    end;
  end;
end;

Procedure TInterfaceRelatorio.pReplicaExpImpOutrosFiltros;
var
  intRecNo: Integer;
  strExpImp: string;
begin
  if fPergunta('Confirma a replicação dessa expressão de impressão de filtro para os demais filtros?') then
  begin
    intRecNo := FParams.RecNo;
    FParams.DisableControls;
    try
      strExpImp := FParams.FieldByName('PAR_EXPIMP').AsString;
      FParams.First;
      while not FParams.Eof do
      begin
        if (FParams.RecNo <> intRecNo) then
        begin
          FParams.Edit;
          FParams.FieldByName('PAR_EXPIMP').AsString := strExpImp;

          FParams.FieldByName('PAR_CNDVIS').AsString := '';

          if FParams.FieldByName('PAR_SQLVIS').AsString <> '' then
            FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          if FParams.FieldByName('PAR_EXPVIS').AsString <> '' then
            FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          if FParams.FieldByName('PAR_EXPIMP').AsString <> '' then
            FParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          FParams.FieldByName('IMPFIL').AsInteger := 1;
          FParams.Post;
        end;
        FParams.Next;
      end;
    finally
      FParams.RecNo := intRecNo;
      FParams.EnableControls;
    end;
  end;
end;

Procedure TInterfaceRelatorio.pLimpaFonteTodosCampos;
var
  intRecNo: Integer;
begin
  if fPergunta('Deseja apagar a fonte personalizada de todos os campos listados?') then
  begin
    intRecNo := FCampos.RecNo;
    FCampos.DisableControls;
    try
      FCampos.First;
      while not FCampos.Eof do
      begin
        if not fEmptyStr(FCampos.FieldByName('CAM_LISTAR').AsString) then
        begin
          FCampos.Edit;
          FCampos.FieldByName('CAM_FNTCND').Clear;
          FCampos.FieldByName('CAM_FNTCAM').Clear;
          FCampos.Post;
        end;
        FCampos.Next;
      end;
    finally
      FCampos.RecNo := intRecNo;
      FCampos.EnableControls;
    end;
  end;
end;

Procedure TInterfaceRelatorio.pInsereNovoGrupo(strGrupo: String; blnParam, blnSilencioso: Boolean);
Begin
  strGrupo := Trim(strGrupo);

  If Not fEmptyStr(strGrupo) Then
  Begin

    If FGruposParams.Locate('GRU_NOMGRU', strGrupo, []) Then
    Begin
      if not blnSilencioso then
        pMensagemOk('Esse grupo já existe!');
    End Else
    Begin
      FGruposParams.Append;
      FGruposParams.FieldByName('GRU_CODGRU').AsString  := fAtualizaProCod('GRUPAR', 'GRU_CODGRU');
      FGruposParams.FieldByName('GRU_NOMGRU').AsString  := strGrupo;
      FGruposParams.FieldByName('GRU_TIPBAN').AsInteger := 0;

      If blnParam Then
        FGruposParams.FieldByName('GRU_TIPGRU').AsString := '0'
      Else
        FGruposParams.FieldByName('GRU_TIPGRU').AsString := '1';

      FGruposParams.Post;
    End;

  End;
End;

Procedure TInterfaceRelatorio.pBeforePostGrupoParams(DataSet: TDataSet);
Begin
  With dataSet Do
  Begin

    If fEmptyStr(FieldByName('GRU_NOMGRU').AsString) Then
    Begin
      pMensagemOk('Informe o nome do grupo!');
      Cancel;
      Abort;
    End;

  End;
End;

Procedure TInterfaceRelatorio.pDecOrdemComplementar(cxvParams: TcxGridDBTableView);
  Var
    strCodPar: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  With FComplementos Do
  Begin
    strCodPar   := FieldByName('REL_CODREL').AsString;
    intOrdAtual := FieldByName('REL_ORDENA').AsInteger;

    cxvParams.NavigatorButtons.Prior.Click;

    If FieldByName('REL_CODREL').AsString = strCodPar Then
      Exit;

    intOrdNova := FieldByName('REL_ORDENA').AsInteger;
    Edit;
    FieldByName('REL_ORDENA').AsInteger := intOrdAtual;
    Post;

    If Locate('REL_CODREL', strCodPar, []) Then
    Begin
      Edit;
      FieldByName('REL_ORDENA').AsInteger := intOrdNova;
      Post;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pIncOrdemComplementar(cxvParams: TcxGridDBTableView);
  Var
    strCodCam: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  With FComplementos Do
  Begin
    strCodCam   := FieldByName('REL_CODREL').AsString;
    intOrdAtual := FieldByName('REL_ORDENA').AsInteger;

    cxvParams.NavigatorButtons.Next.Click;

    If FieldByName('REL_CODREL').AsString = strCodCam Then
      Exit;

    intOrdNova := FieldByName('REL_ORDENA').AsInteger;
    Edit;
    FieldByName('REL_ORDENA').AsInteger := intOrdAtual;
    Post;

    If Locate('REL_CODREL', strCodCam, []) Then
    Begin
      Edit;
      FieldByName('REL_ORDENA').AsInteger := intOrdNova;
      Post;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pDecOrdemFiltro(cxvParams: TcxGridDBTableView);
  Var
    strCodPar: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  With FParams Do
  Begin
    strCodPar   := FieldByName('PAR_NOMPAR').AsString;
    intOrdAtual := FieldByName('PAR_ORDENA').AsInteger;

    cxvParams.NavigatorButtons.Prior.Click;

    If FieldByName('PAR_NOMPAR').AsString = strCodPar Then
      Exit;

    intOrdNova := FieldByName('PAR_ORDENA').AsInteger;
    Edit;
    FieldByName('PAR_ORDENA').AsInteger := intOrdAtual;
    Post;

    If Locate('PAR_NOMPAR', strCodPar, []) Then
    Begin
      Edit;
      FieldByName('PAR_ORDENA').AsInteger := intOrdNova;
      Post;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pIncOrdemFiltro(cxvParams: TcxGridDBTableView);
  Var
    strCodCam: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  With FParams Do
  Begin
    strCodCam   := FieldByName('PAR_NOMPAR').AsString;
    intOrdAtual := FieldByName('PAR_ORDENA').AsInteger;

    cxvParams.NavigatorButtons.Next.Click;

    If FieldByName('PAR_NOMPAR').AsString = strCodCam Then
      Exit;

    intOrdNova := FieldByName('PAR_ORDENA').AsInteger;
    Edit;
    FieldByName('PAR_ORDENA').AsInteger := intOrdAtual;
    Post;

    If Locate('PAR_NOMPAR', strCodCam, []) Then
    Begin
      Edit;
      FieldByName('PAR_ORDENA').AsInteger := intOrdNova;
      Post;
    End;
  End;
End;

Function TInterfaceRelatorio.fCarregaCampos(strSeqGer: String): Boolean;
Begin
  Try
    If FCampos.Active Then
      FCampos.Close;

    FCampos.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;

    Result := FCampos.fAbreClient(True, 'TInterfaceRelatorio.fCarregaCampos');
    FCampos.IndexFieldNames := 'CAM_POSICA';

    FCampos.pAlinhaCampoCentro('CAM_LISTAR');
    FCampos.pAlinhaCampoCentro('CAM_QUEBRA');
    FCampos.pAlinhaCampoCentro('CAM_LISQUE');
    FCampos.pAlinhaCampoCentro('CAM_LINQUE');
    FCampos.pAlinhaCampoCentro('CAM_TOTALI');
    FCampos.pAlinhaCampoCentro('CAM_FUNCAO');

    pCarregaLargura;

    FCampos.BeforeEdit := pBeforeEditCampos;
    FCampos.BeforePost := pBeforePostCampos;

    Result := Result And objConsultasGrid.fCarregaDados(strSeqGer, FCampos, blnExecutandoPeloMenu);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaCampos');
    End;
  End;
End;

Procedure TInterfaceRelatorio.pCarregaLargura;
  Var
    intRecNo: Integer;
Begin
  With FCampos Do
  Begin
    DisableControls;

    intRecNo := RecNo;

    pInicializaLargura;

    First;
    While Not Eof Do
    Begin
      pIncrementaLargura;

      Next;
    End;

    If intRecNo > 0 Then
      RecNo := intRecNo;

    EnableControls;
  End;

End;

Function TInterfaceRelatorio.fRetQuebras(blnCombo: Boolean = False): String;
  Var
    stlLista: TStringList;
    strIndex: String;
Begin
  With FCampos Do
  Begin
    strIndex := IndexFieldNames;

    stlLista := TStringList.Create;

    If blnCombo Then
      stlLista.Add('');

    DisableControls;

    IndexFieldNames := 'CAM_POSORD';

    First;
    While Not Eof Do
    Begin
      If FieldByName('CAM_QUEBRA').AsString = 'S' Then
        stlLista.Add(FieldByName('CAM_NOMCAM').AsString);

      Next;
    End;

    IndexFieldNames := strIndex;

    EnableControls;

    Result := stlLista.Text;

    FreeAndNil(stlLista);
  End;
End;

Procedure TInterfaceRelatorio.pCompCarregaComplementosChilds;
Begin
  If Assigned(FGeraFr3) Then
    FGeraFr3.stlCodRels.Text := fMontaListaRel;

  pCarregaQueriesComplentares(True);
End;

Function TInterfaceRelatorio.fCarregaComplementos(strSeqGer: String): Boolean;
Begin
  With FComplementos Do
  Try
    qryQuery.ParamByName('SEQGER').AsString := strSeqGer;

    Result := fAbreClient(True, 'TInterfaceRelatorio.fCarregaComplementos');

    pAlinhaCampoCentro('REL_CODREL');
    pAlinhaCampoCentro('REL_ORDENA');
    pAlinhaCampoCentro('REL_NOVPAG');

    IndexFieldNames := 'REL_ORDENA';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaComplementos');
    End;
  End;
End;

Function TInterfaceRelatorio.fCarregaDirAcesso(strSeqGer: String): Boolean;
Begin

  Try
    FDirAcesso.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;

    Result := FDirAcesso.fAbreClient(True, 'TInterfaceRelatorio.fCarregaDirAcesso');

    FDirAcesso.pAlinhaCampoCentro('DIR_CODDIR');

    FDirAcesso.IndexFieldNames := 'DIR_NOMDIR';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaDirAcesso');
    End;
  End;
End;

Function TInterfaceRelatorio.fCarregaChilds(strSeqGer: String): Boolean;
Begin
  With FChilds Do
  Try
    qryQuery.ParamByName('SEQGER').AsString := strSeqGer;

    Result := fAbreClient(True, 'TInterfaceRelatorio.fCarregaChilds');

    pAlinhaCampoCentro('REL_CODREL');
    pAlinhaCampoCentro('REL_ORDENA');

    IndexFieldNames := 'REL_ORDENA';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaChilds');
    End;
  End;
End;

Function TInterfaceRelatorio.fCarregaHistoricos(strChave: String): Boolean;
Begin
  With FHistoricos Do
  Try
    qryQuery.ParamByName('CHAVE').AsString := strChave;

    Result := fAbreClient(True, 'TInterfaceRelatorio.fCarregaHistoricos');
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaHistoricos');
    End;
  End;
End;

Function TInterfaceRelatorio.fSalvaParametros(strSeqGer: String): Boolean;
Begin
  With FParams Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('PAR_SEQGER').AsString) Then
      Begin
        Edit;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADPRR', VS_strCodEmp);
        FieldByName('PAR_SEQGER').AsString := strSeqGer;
        Post;
      End;

      Next;
    End;

    Result := fSalvaGruposParametros(strSeqGer) And fSalva;
    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fSalvaGruposParametros(strSeqGer: String): Boolean;
Begin
  With FGruposParams Do
  Begin
    DisableControls;

    Filtered := False;

    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('GRU_SEQGER').AsString) Then
      Begin
        Edit;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GRUPAR', VS_strCodEmp);
        FieldByName('GRU_SEQGER').AsString := strSeqGer;
        Post;
      End;

      Next;
    End;

    Result := fSalva;

    Filtered := True;

    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fSalvaCampos(strSeqGer: String): Boolean;
  Var
    strQuebras: String;
    prcAfterPost: TAfterPost;
Begin
  With FCampos Do
  Begin
    strQuebras := fRetQuebras;

    DisableControls;
    prcAfterPost := FCampos.AfterPost;
    FCampos.AfterPost := Nil;

    First;
    While Not Eof Do
    Begin

      If fEmptyStr(FieldByName('CAM_SEQGER').AsString) Then
      Begin
        Edit;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADCAM', VS_strCodEmp);
        FieldByName('CAM_SEQGER').AsString := strSeqGer;
        Post;
      End;

      If (Not fEmptyStr(FieldByName('CAM_LISQUE').AsString)) And
         (Pos(FieldByName('CAM_LISQUE').AsString, strQuebras) <= 0) Then
      Begin
        Edit;
        FieldByName('CAM_LISQUE').AsString := '';
        FieldByName('CAM_LINQUE').AsString := '';
        Post;
      End;

      Next;
    End;

    Result := fSalva And
              objConsultasGrid.fSalvaDados(strSeqGer);

    FCampos.AfterPost := prcAfterPost;
    EnableControls;
  End;
End;

Procedure TInterfaceRelatorio.pMarcaAnteriores;
  Var
    strCampo,
    strIndex: String;
Begin

  With FCampos Do
  Begin
    strCampo := FieldByName('CAM_NOMCAM').AsString;

    strIndex := IndexFieldNames;
    IndexFieldNames := 'CAM_POSORD';
    Locate('CAM_NOMCAM', strCampo, []);

    Prior;

    While True Do
    Begin

      If FieldByName('CAM_POSORD').AsInteger > -1 Then
      Begin
        Edit;
        FieldByName('CAM_QUEBRA').AsString := 'S';
        Post;
      End;

      strCampo := FieldByName('CAM_NOMCAM').AsString;

      Prior;

      If strCampo = FieldByName('CAM_NOMCAM').AsString Then
        Break;
    End;

    IndexFieldNames := strIndex;
  End;
End;

Procedure TInterfaceRelatorio.pDesmarcaPosteriores;
  Var
    strCampo,
    strIndex: String;
Begin

  With FCampos Do
  Begin
    strCampo := FieldByName('CAM_NOMCAM').AsString;

    strIndex := IndexFieldNames;
    IndexFieldNames := 'CAM_POSORD';
    Locate('CAM_NOMCAM', strCampo, []);

    Next;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('CAM_QUEBRA').AsString := 'N';
      Post;

      Next;
    End;

    IndexFieldNames := strIndex;
  End;
End;

Procedure TInterfaceRelatorio.pAjustaQuebras;
  Var
    strQuebras: String;
Begin
  Exit;

  With FCampos Do
  Begin
    If FieldByName('CAM_POSORD').AsInteger < 0 Then
      Exit;

    DisableControls;

    If FieldByName('CAM_QUEBRA').AsString = 'S' Then
      pMarcaAnteriores
    Else
      pDesmarcaPosteriores;

    strQuebras := fRetQuebras;

    pInicializaLargura;

    First;
    While Not Eof Do
    Begin

      If (Not fEmptyStr(FieldByName('CAM_LISQUE').AsString)) And
         (Pos(FieldByName('CAM_LISQUE').AsString, strQuebras) <= 0) Then
      Begin
        Edit;
        FieldByName('CAM_LISQUE').AsString := '';
        FieldByName('CAM_LINQUE').AsString := '';
        Post;
      End;

      pIncrementaLargura;

      Next;
    End;

    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fSalvaComplementos(strSeqGer: String): Boolean;
Begin
  With FComplementos Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('REL_MASTER').AsString) Then
      Begin
        Edit;
        FieldByName('REL_MASTER').AsString := strSeqGer;
        Post;
      End;

      Next;
    End;

    Result := fSalva;
    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fSalvaDirAcesso(strSeqGer: String): Boolean;
Begin

  FDirAcesso.DisableControls;
  FDirAcesso.First;
  While Not FDirAcesso.Eof Do
  Begin
    If fEmptyStr(FDirAcesso.FieldByName('REL_SEQGER').AsString) Then
    Begin
      FDirAcesso.Edit;
      FDirAcesso.FieldByName('REL_SEQGER').AsString := strSeqGer;
      FDirAcesso.Post;
    End;

    FDirAcesso.Next;
  End;

  Result := FDirAcesso.fSalva;
  FDirAcesso.EnableControls;
End;

Function TInterfaceRelatorio.fSalvaChilds(strSeqGer: String): Boolean;
Begin
  With FChilds Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('REL_MASTER').AsString) Then
      Begin
        Edit;
        FieldByName('REL_MASTER').AsString := strSeqGer;
        Post;
      End;

      Next;
    End;

    Result := fSalva;
    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fSalvaHistoricos(strChave: String): Boolean;
Begin
  With FHistoricos Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If fEmptyStr(FieldByName('HIS_CHAVE_').AsString) Then
      Begin
        Edit;
        FieldByName('HIS_CHAVE_').AsString := strChave;
        Post;
      End;

      Next;
    End;

    Result := fSalva;
    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fTrataSaldoProduto(strInfo: String): String;
  Var
    intPosIni,
    intPosFim: Integer;
    msgErro,
    strAliasIteger,
    strAliasCadIte: String;
Begin
  msgErro := 'A função fSaldoProduto deve ser utilizada da seguinte forma:' + #13#10 +
             '  fSaldoProduto(ALIAS_DA_TABELA_ITEGER)   - não considera o saldo em ml/gr' + #13#10 +
             '  fSaldoProduto(ALIAS_DA_TABELA_ITEGER, ALIAS_DA_TABELA_CADITE)   - soma o saldo em ml/gr';

  Repeat
    intPosIni := Pos('fSaldoProduto(', strInfo);

    If intPosIni > 0 Then
    Begin

      intPosFim := intPosIni + Length('fSaldoProduto(');

      strAliasIteger := '';
      strAliasCadIte := '';

      While (intPosFim <= Length(strInfo)) And (Not CharInSet(strInfo[intPosFim], [')', ','])) Do
      Begin
        strAliasIteger := strAliasIteger + strInfo[intPosFim];

        Inc(intPosFim);
      End;

      If (Not CharInSet(strInfo[intPosFim], [')', ','])) Then
      Begin
        FSQLErro := True;
        pMensagemOk(msgErro);
        Exit;
      End;

      If strInfo[intPosFim] = ',' Then
      Begin
        Inc(intPosFim);

        While (intPosFim <= Length(strInfo)) And (Not CharInSet(strInfo[intPosFim], [')'])) Do
        Begin
          strAliasCadIte := strAliasCadIte + strInfo[intPosFim];

          Inc(intPosFim);
        End;

        If fEmptyStr(strAliasCadIte) Or (Not CharInSet(strInfo[intPosFim], [')'])) Then
        Begin
          FSQLErro := True;
          pMensagemOk(msgErro);
          Exit;
        End;

      End;

      Delete(strInfo, intPosIni, intPosFim - intPosIni + 1);
      Insert(fSQLSaldoProduto(Trim(strAliasIteger), Trim(strAliasCadIte)), strInfo, intPosIni);
    End;

  until intPosIni = 0;

  Result := strInfo;
End;

Function TInterfaceRelatorio.fTrataLimits(strInfo: String; blnExecucao: Boolean): String;
  Var
    sqlParser: TSQLParser;
    strSQL,
    strToken,
    strValLimit: String;
    intIndex,
    intToken: Integer;
    blnAchou: Boolean;
Begin
  Result := strInfo;

  While Pos(':LIMITE', Result) > 0 Do
  Begin
    strSQL := Copy(Result, Succ(Pos(':LIMITE', Result)), Length(Result) - Pos(':LIMITE', Result));

    sqlParser := TMyParser.Create(strSQL);
    sqlParser.OmitBlank := False;
    sqlParser.OmitComment := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    intToken := sqlParser.GetNextToken;

    If intToken <> 0 Then
    Begin
      strToken := sqlParser.Lexem;

      If Not FLimits.Find(strToken, intIndex) Then
        FLimits.Add(strToken);

      If blnExecucao Then
      begin
        strValLimit := fGetValorParametro(strToken, blnAchou);

        If fEmptyStr(strValLimit) Then
          Result := fRetiraClausula(Result, strToken)
        Else
          Result := AnsiReplaceStr(Result, ':' + strToken, strValLimit);
      end
      Else
        Result := AnsiReplaceStr(Result, ':' + strToken, '0');
    End;

    FreeAndNil(sqlParser);
  End;

End;

Procedure TInterfaceRelatorio.pSetaRecSaldos(Var recSaldos: TGuiaSaldos);
Begin
  With recSaldos Do
  Begin
    strSQL                            := FGuiaSaldosTemp.strSQL;
    strSQLFormatado                   := FGuiaSaldosTemp.strSQLFormatado;
    blnGarantia                       := FGuiaSaldosTemp.blnGarantia;
    blnExterno                        := FGuiaSaldosTemp.blnExterno;
    blnPedidoVenda                    := FGuiaSaldosTemp.blnPedidoVenda;
    blnPedidoBaixaEntregaFutura       := FGuiaSaldosTemp.blnPedidoBaixaEntregaFutura;
    blnEnderecamento                  := FGuiaSaldosTemp.blnEnderecamento;
    blnOrdemProducao                  := FGuiaSaldosTemp.blnOrdemProducao;
    blnSaldoTransferencias            := FGuiaSaldosTemp.blnSaldoTransferencias;
    blnEntregaFuturaPrevisao          := FGuiaSaldosTemp.blnEntregaFuturaPrevisao;
    blnEntregaFuturaFaltaProduto      := FGuiaSaldosTemp.blnEntregaFuturaFaltaProduto;
    blnEntregaFuturaAguandandoCliente := FGuiaSaldosTemp.blnEntregaFuturaAguandandoCliente;;
  End;
End;

Procedure TInterfaceRelatorio.pSetaSQLFormatadoSaldos(Var strInfo: String; Var recSaldos: TGuiaSaldos; blnQueryFiltros: Boolean);
  Var
    intPosCriaTabela,
    intPosFinal: Integer;
Begin

  With recSaldos Do
  Begin
    blnGarantia                       := False;
    blnExterno                        := False;
    blnPedidoVenda                    := False;
    blnPedidoBaixaEntregaFutura       := False;
    blnEnderecamento                  := False;
    blnOrdemProducao                  := False;
    blnSaldoTransferencias            := False;
    blnEntregaFuturaPrevisao          := False;
    blnEntregaFuturaFaltaProduto      := False;
    blnEntregaFuturaAguandandoCliente := False;

    strSQLFormatado                         := '';
    strSQL                                  := '';

    intPosCriaTabela := Pos('pCriaTabelaSaldos(', strInfo);

    intPosFinal := Pos(');', strInfo, intPosCriaTabela);

    If intPosCriaTabela > 0 Then
    Begin
      strSQLFormatado := Copy(strInfo, 1, Pred(intPosFinal));
      strSQLFormatado := Trim(AnsiReplaceStr(strSQLFormatado, 'pCriaTabelaSaldos(', ''));

      System.Delete(strInfo, 1, intPosFinal + Length(');'));
    End;
  End;

End;

Function TInterfaceRelatorio.fRetiraFormatacaoSaldos(strInfo: String; Var recSaldos: TGuiaSaldos; blnExecucao, blnQueryFiltros: Boolean): String;
  Var
    intContador: Integer;
    strWhere: String;
Begin
  Result := strInfo;

  With recSaldos Do
  Begin
    If Pos('pGeraSaldoGarantia;', Result) > 0 Then
    Begin
      blnGarantia := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoGarantia;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_GARANTIA), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoExterno;', Result) > 0 Then
    Begin
      blnExterno := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoExterno;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_EXTERNO), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoPedidoVenda;', Result) > 0 Then
    Begin
      blnPedidoVenda := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoPedidoVenda;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_PEDIDO_VENDA), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoPedidoBaixaEntregaFutura;', Result) > 0 Then
    Begin
      blnPedidoBaixaEntregaFutura := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoPedidoBaixaEntregaFutura;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_PEDIDO_BAIXA_ENTFUT), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoEnderecamento;', Result) > 0 Then
    Begin
      blnEnderecamento := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoEnderecamento;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_ENDERECAMENTO), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoOrdemProducao;', Result) > 0 Then
    Begin
      blnOrdemProducao := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoOrdemProducao;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_ORDEM_PRODUCAO), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoTransferencias;', Result) > 0 Then
    Begin
      blnSaldoTransferencias := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoTransferencias;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Concat('IF NOT EXISTS ', TMP_TRANSF_ANDAMENTO), EngineMemory]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoEntregaFuturaPrevisao;', Result) > 0 Then
    Begin
      blnEntregaFuturaPrevisao := True;
      Result := AnsiReplaceStr(Result, 'pGeraSaldoEntregaFuturaPrevisao;', '');

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosPendentes, [Concat('IF NOT EXISTS ', TMP_ENTREGA_FUTURA_PREVISAO)]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoEntregaFuturaFalta;', Result) > 0 Then
    Begin
      Result := AnsiReplaceStr(Result, 'pGeraSaldoEntregaFuturaFalta;', '');
      blnEntregaFuturaFaltaProduto := True;

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosPendentes, [Concat('IF NOT EXISTS ', TMP_ENTREGA_FUTURA_FALTA)]))) Then
        Exit;
    End;

    If Pos('pGeraSaldoEntregaFuturaAguarda;', Result) > 0 Then
    Begin
      Result := AnsiReplaceStr(Result, 'pGeraSaldoEntregaFuturaAguarda;', '');
      blnEntregaFuturaAguandandoCliente := True;

      If (Not fExecutaSQL(Format(sqlCreateTabelaDocumentosPendentes, [Concat('IF NOT EXISTS ', TMP_ENTREGA_FUTURA_AGUARDA)]))) Then
        Exit;
    End;

    If blnQueryFiltros Then
    Begin
      qryGuiaSaldos.SQL.Text := fRetiraFormatacaoSQL(strSQLFormatado, False, False, False);

      strWhere := '';

      For intContador := 0 To qryGuiaSaldos.Params.Count - 1 Do
        strWhere := strWhere + ' :' + qryGuiaSaldos.Params[intContador].Name + ' AND ';

      If Not fEmptyStr(strWhere) Then
      Begin
        strWhere := 'WHERE ' + strWhere;

        Result := AnsiReplaceStr(Result, 'WHERE', strWhere);
      End;
    End;

  End;
End;

Function TInterfaceRelatorio.fValidaRetTabela(strExpressao: String; blnExecucao: Boolean; strTabelaRetorno: string; intQuerie: Integer): String;
Var
  rgxExpRegMesAno, rgxExpRegDiaMesAno: TRegEx;
  intCont: Integer;
  mclMatchColMesAno, mclMatchColDiaMesAno: TMatchCollection;
  strRegexMesAno, strRegexDiaMesAno, strDataErrada, strTabelaConcat: string;
  dtaData, dtaServidor: TDate;

  procedure pTrocaVarParam(var strExpressao: String; blnExecucao: Boolean; strTabelaRetorno: string; intQuerie: Integer; strVarParam: string);
  var
    rgxExpRegVarParam: TRegEx;
    intCont: Integer;
    mclMatchColVarParam: TMatchCollection;
    strRegexVarParam, strValorSubst, strNomeVarParam: string;

    function fRetornaValorParam(strParam: string): string;
    var
      rowDado: TcxEditorRow;
    begin
      rowDado := fRetRowDado(strParam);
      if Assigned(rowDado) then
      begin
        if FParams.Locate('PAR_NOMPAR', strParam, []) and (rowDado.Properties.Value <> Null) then
        begin
          case fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) of
            facComboBox, facComboBoxVerdeVermelho   : Result := fGetValorCombo(rowDado.Properties.Value);
            facTabelaPrecoLista, facCustomCheckList : Result := rowDado.Properties.DisplayTexts[0];
          else
            Result := rowDado.Properties.Value;
          end;
        end;
      end;
    end;

    function fRetornaValorVar(strParam: string; intQuerie: Integer): string;
    var
      strSQLRelatorio: string;
      qryConsultaVar: TUniQuery;
      strSetSQL: string;
    begin
      strSQLRelatorio := strExpressao;
      strSQLRelatorio := fExecutaSets(Nil, strSetSQL, strSQLRelatorio, intQuerie, '@' + strParam);
      qryConsultaVar := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
      try
        with qryConsultaVar, qryConsultaVar.SQL do
        begin
          Close;
          Clear;
          Add('SELECT IF(LENGTH(@' + strParam + ') = 7, @' + strParam + ', DATE_FORMAT(@' + strParam + ', "%d/%m/%Y")) AS VALVAR');
          Open;
          Result := FieldByName('VALVAR').AsString;
        end;
      finally
        FreeAndNil(qryConsultaVar);
      end;
    end;

  begin

    strRegexVarParam := strTabelaRetorno + '\([ ]*' + strVarParam + '[0-9A-z_]*[ ]*\)';

    rgxExpRegVarParam   := TRegEx.Create(strRegexVarParam);
    mclMatchColVarParam := rgxExpRegVarParam.Matches(strExpressao);
    for intCont := 0 to mclMatchColVarParam.Count - 1 do
    begin
      strNomeVarParam := Trim(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchColVarParam.Item[intCont].Value, strTabelaRetorno + '(', ''), ')', ''), strVarParam, ''));
      if not blnExecucao then
        strValorSubst := 'ITEGER' // Tabela padrão para quando estiver em tempo de projeto
      else
      begin
        case AnsiIndexStr(strVarParam, [':', '@']) of
          0 : strValorSubst := strTabelaRetorno + '(''' + fRetornaValorParam(strNomeVarParam) + ''')';
          1 : strValorSubst := strTabelaRetorno + '(''' + fRetornaValorVar(strNomeVarParam, intQuerie) + ''')';
        end;
      end;
      strExpressao := AnsiReplaceStr(strExpressao, mclMatchColVarParam.Item[intCont].Value, strValorSubst);
    end;
  end;

Begin

  pTrocaVarParam(strExpressao, blnExecucao, strTabelaRetorno, intQuerie, ':');
  pTrocaVarParam(strExpressao, blnExecucao, strTabelaRetorno, intQuerie, '@');

  strRegexMesAno    := strTabelaRetorno + '\([ ]*''[0-9][0-9]/[0-9][0-9][0-9][0-9]''[ ]*\)';
  strRegexDiaMesAno := strTabelaRetorno + '\([ ]*''[0-9][0-9]/[0-9][0-9]/[0-9][0-9][0-9][0-9]''[ ]*\)';

  strTabelaConcat := IIF(strTabelaRetorno = STR_RET_TABELA_I_, 'I_', 'SALINV_');

  Try
    rgxExpRegMesAno   := TRegEx.Create(strRegexMesAno);
    mclMatchColMesAno := rgxExpRegMesAno.Matches(strExpressao);
    for intCont := 0 to mclMatchColMesAno.Count - 1 do
    try
      dtaData := StrToDate('01/' + Trim(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchColMesAno.Item[intCont].Value, strTabelaRetorno + '(', ''), ')', ''), Chr(39), '')));
      dtaServidor := StrToDate('01/' + Copy(DateToStr(fRetDataServidor), 4, 7));
      if not (dtaData < dtaServidor) then
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchColMesAno.Item[intCont].Value, 'ITEGER')
      else
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchColMesAno.Item[intCont].Value, strTabelaConcat + fPadL(IntToStr(YearOf(dtaData)), 4, '0') + fPadL(IntToStr(MonthOf(dtaData)), 2, '0'));
    except
      strDataErrada := Trim(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchColMesAno.Item[intCont].Value, strTabelaRetorno + '(', ''), ')', ''), Chr(39), ''));
      strExpressao := AnsiReplaceStr(strExpressao, mclMatchColMesAno.Item[intCont].Value, strTabelaConcat + Copy(strDataErrada, 4, 4) + Copy(strDataErrada, 1, 2));
    end;

    rgxExpRegDiaMesAno   := TRegEx.Create(strRegexDiaMesAno);
    mclMatchColDiaMesAno := rgxExpRegDiaMesAno.Matches(strExpressao);
    for intCont := 0 to mclMatchColDiaMesAno.Count - 1 do
    try
      dtaData := StrToDate(Trim(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchColDiaMesAno.Item[intCont].Value, strTabelaRetorno + '(', ''), ')', ''), Chr(39), '')));
      dtaServidor := StrToDate('01/' + Copy(DateToStr(fRetDataServidor), 4, 7));
      if not (dtaData < dtaServidor) then
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchColDiaMesAno.Item[intCont].Value, 'ITEGER')
      else
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchColDiaMesAno.Item[intCont].Value, strTabelaConcat + fPadL(IntToStr(YearOf(dtaData)), 4, '0') + fPadL(IntToStr(MonthOf(dtaData)), 2, '0'));
    except
      strDataErrada := Trim(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchColDiaMesAno.Item[intCont].Value, strTabelaRetorno + '(', ''), ')', ''), Chr(39), ''));
      strExpressao := AnsiReplaceStr(strExpressao, mclMatchColDiaMesAno.Item[intCont].Value, strTabelaConcat + Copy(strDataErrada, 7, 4) + Copy(strDataErrada, 4, 2)+ '_COM_DIA_' + Copy(strDataErrada, 1, 2));
    end;

    Result := strExpressao;
  Except
    On E: Exception Do
    Begin
      Result := strExpressao;
      pMensagemOk(E.message + #13#10 + '[TInterfaceRelatorio.fValidaRetTabela]');
      Abort;
    End;
  End;

End;

Function TInterfaceRelatorio.fValidaFCampoExiste(strExpressao: String): String;
Var
  rgxExpReg: TRegEx;
  intCont: Integer;
  mclMatchCol: TMatchCollection;
  strRegex, strValorSubst: string;
  strCampo, strTabela1, strTabela2, strAlias1, strAlias2: string;
  stlTermos: TStringList;

Begin

  strRegex := STR_F_CAMPO_EXISTE + '\([ ]*''[0-9A-z_]*''[ ]*,[ ]*''[0-9A-z_]*''[ ]*,[ ]*''[0-9A-z_]*''[ ]*,[ ]*''[0-9A-z_]*''[ ]*,[ ]*''[0-9A-z_]*''[ ]*\)';

  rgxExpReg := TRegEx.Create(strRegex);
  mclMatchCol := rgxExpReg.Matches(strExpressao);
  for intCont := 0 to mclMatchCol.Count - 1 do
  begin
    stlTermos := TStringList.Create;
    try
      ExtractStrings([','], [], PWideChar(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchCol.Item[intCont].Value, STR_F_CAMPO_EXISTE + '(', ''), ')', ''), Chr(39), '')), stlTermos);

      strCampo   := Trim(stlTermos[0]);
      strTabela1 := Trim(stlTermos[1]);
      strTabela2 := Trim(stlTermos[2]);
      strAlias1  := Trim(stlTermos[3]);
      strAlias2  := Trim(stlTermos[4]);

      if fTabelaExiste(strTabela1) and fTabelaExiste(strTabela2) and (not fEmptyStr(strAlias1)) and (not fEmptyStr(strAlias2)) then
      begin
        strValorSubst := IIF(fCampoExiste(strTabela1, strCampo), strAlias1 + '.' + strCampo, strAlias2 + '.' + strCampo);
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, strValorSubst);
      end;
    finally
      FreeAndNil(stlTermos);
    end;
  end;

  Result := strExpressao;

End;

Function TInterfaceRelatorio.fValidaFObjetoExiste(strExpressao: String): String;
Var
  rgxExpReg: TRegEx;
  intCont: Integer;
  mclMatchCol: TMatchCollection;
  strRegex, strValorSubst, strOcorrencia: string;
  strTipoObjeto, strNomeObjeto, strNomeTabela, strExpressaoVerdade, strExpressaoFalsa: string;
  stlTermos: TStringList;

Begin

  strRegex := STR_F_OBJETO_EXISTE + '\([ ]*''[CTct]*''[ ]*;[ ]*''[0-9A-z_]*''[ ]*;[ ]*''[0-9A-z_]*''[ ]*;[ ]*''[^;'']*''[ ]*;[ ]*''[^;'']*''[ ]*\)';

  rgxExpReg := TRegEx.Create(strRegex);
  mclMatchCol := rgxExpReg.Matches(strExpressao);
  for intCont := 0 to mclMatchCol.Count - 1 do
  begin
    stlTermos := TStringList.Create;
    try
      strOcorrencia := AnsiReplaceStr(mclMatchCol.Item[intCont].Value, STR_F_OBJETO_EXISTE + '(', '');
      strOcorrencia := Copy(strOcorrencia, 1, Length(strOcorrencia) - 1);
      ExtractStrings([';'], [], PWideChar(AnsiReplaceStr(strOcorrencia, Chr(39), '')), stlTermos);

      strTipoObjeto  := Trim(stlTermos[0]);
      strNomeObjeto  := Trim(stlTermos[1]);
      strNomeTabela  := Trim(stlTermos[2]);
      strExpressaoVerdade := Trim(stlTermos[3]);
      strExpressaoFalsa   := Trim(stlTermos[4]);

      if strTipoObjeto = 'C' then
      begin
        strValorSubst := IIF(fCampoExiste(strNomeTabela, strNomeObjeto), strExpressaoVerdade, strExpressaoFalsa);
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, strValorSubst);
      end;
      if strTipoObjeto = 'T' then
      begin
        strValorSubst := IIF(fTabelaExiste(strNomeObjeto), strExpressaoVerdade, strExpressaoFalsa);
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, strValorSubst);
      end;
    finally
      FreeAndNil(stlTermos);
    end;
  end;

  Result := strExpressao;

End;

Function TInterfaceRelatorio.fAjustaTABELA_I_(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemTabelaI_) To High(FTemTabelaI_) Do
  Begin
    strTabela := Concat(STR_TABELA_I_, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemTabelaI_[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaInventarioSelecionada(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaInventarioInicial);
    End;

  End;

  strTabela := STR_TABELA_I_;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemTabelaI_[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaInventarioSelecionada(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaInventarioInicial);

  End;
End;

Function TInterfaceRelatorio.fAjustaESTEXT_(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemEstExt_) To High(FTemEstExt_) Do
  Begin
    strTabela := Concat(STR_ESTEXT_, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemEstExt_[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstExtSelecionada(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstExtInicial);
    End;

  End;

  strTabela := STR_ESTEXT_;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemEstExt_[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstExtSelecionada(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstExtInicial);
  End;
End;

Function TInterfaceRelatorio.fAjustaEstEnv_(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemEstEnv_) To High(FTemEstEnv_) Do
  Begin
    strTabela := Concat(STR_ESTENV_, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemEstEnv_[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEnvSelecionada(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEnvInicial);
    End;

  End;

  strTabela := STR_ESTENV_;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemEstEnv_[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEnvSelecionada(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEnvInicial);
  End;
End;

Function TInterfaceRelatorio.fAjustaEstEnt_(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemEstEnt_) To High(FTemEstEnt_) Do
  Begin
    strTabela := Concat(STR_ESTENT_, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemEstEnt_[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEntSelecionada(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEntInicial);
    End;

  End;

  strTabela := STR_ESTENT_;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemESTENT_[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEntSelecionada(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaEstEntInicial);
  End;
End;

Function TInterfaceRelatorio.fAjustaTabelaL_(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemTabelaL_) To High(FTemTabelaL_) Do
  Begin
    strTabela := Concat(STR_TABELA_L_, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemTabelaL_[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaLoteSelecionado(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaLoteInicial);
    End;

  End;

  strTabela := STR_TABELA_L_;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemTabelaL_[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaLoteSelecionado(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaLoteInicial);
  End;

End;

Function TInterfaceRelatorio.fAjustaSALINV(strSQL: String; blnExecucao: Boolean): String;
  Var
    intContador: Integer;
    strTabela: String;
Begin
  Result := strSQL;

  For intContador := Low(FTemTabelaSALINV) To High(FTemTabelaSALINV) Do
  Begin
    strTabela := Concat(STR_TABELA_SALINV, '[', intContador.ToString, ']');

    If (Pos(strTabela, Result) > 0) Then
    Begin
      FTemTabelaSALINV[intContador] := True;

      If blnExecucao Then
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaSALINVSelecionada(intContador))
      Else
        Result := AnsiReplaceStr(Result, strTabela, fRetTabelaSALINVInicial);
    End;

  End;

  strTabela := STR_TABELA_SALINV;

  If (Pos(strTabela, Result) > 0) Then
  Begin
    FTemTabelaSALINV[1] := True;

    If blnExecucao Then
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaSALINVSelecionada(1))
    Else
      Result := AnsiReplaceStr(Result, strTabela, fRetTabelaSALINVInicial);
  End;

End;

Function TInterfaceRelatorio.fRetiraFormatacaoSQL(strInfo: String; blnExecucao, blnSetVS,
                                                  blnQueryFiltros: Boolean; intQuerie: Integer = 0): String;
  Var
    strFormula: String;
    blnTemInventFinancLocal,
    blnTemComposicaoCustoLocal,
    blnTemRetTabelaI_Local,
    blnTemretTabelaSalInv_Local,
    blnTemFCampoExiste,
    blnTemFObjetoExiste: Boolean;
    Tipo_Tinta: ITintasDeMaquina;
Begin
  strInfo := AnsiReplaceStr(strInfo, #9, ' ');

  If fEmptyStr(strInfo) Then
  Begin
    Result := '';
    Exit;
  End;

  pSetaSQLFormatadoSaldos(strInfo, FGuiaSaldosTemp, blnQueryFiltros);

  If fUsaTmq Then
  Begin
    Tipo_Tinta := untFuncTinta.fGetTintasdeMaquina;
  End;

  strInfo := fTrataConstantes(strInfo);
  strInfo := fTrataTemplates(strInfo);
  strInfo := fTrataInstrucoes(strInfo);

  strInfo := ' SET @GERAR_SE_VAZIO = "S"; ' + strInfo;

  If blnExecucao Then
    strInfo := ' SET @ABRINDO_CONSULTA = TRUE; ' + strInfo
  Else
    strInfo := ' SET @ABRINDO_CONSULTA = FALSE; ' + strInfo;

  strInfo := fTrataLimits(strInfo, blnExecucao);

  blnTemComposicaoCustoLocal := Pos(STR_PRECUS, strInfo) > 0;

  If blnTemComposicaoCustoLocal Then
    FTemComposicaoCusto := True;

  if blnTemComposicaoCustoLocal then
  Begin
    If (blnExecucao) and (FIndexParCusto > -1) Then
      strInfo := ' SET @VS_STRPRECUS = "' + TcxEditorRow(FFiltros.Rows[FIndexParCusto]).Properties.Value + '"; ' + strInfo
    Else
      strInfo := ' SET @VS_STRPRECUS = ""; ' + strInfo;
  End;

  Result := strInfo;

  Result := fAjustaTABELA_I_(Result, blnExecucao);

  Result := fAjustaESTEXT_(Result, blnExecucao);

  Result := fAjustaEstEnt_(Result, blnExecucao);

  Result := fAjustaEstEnv_(Result, blnExecucao);

  Result := fAjustaTabelaL_(Result, blnExecucao);

  Result := fAjustaSALINV(Result, blnExecucao);

  Result := AnsiReplaceStr(Result, '[', ' ');
  Result := AnsiReplaceStr(Result,  ']', ' ');

  Result := fGeraNomesTemporarias(Result);

  Result := AnsiReplaceStr(Result, '@NOME_RELATORIO', CONCAT('@NOME_RELATORIO', FCadRel[intQuerie].FieldByName('REL_CODREL').AsString));
  Result := AnsiReplaceStr(Result, '@SUBNOME_RELATORIO', CONCAT('@SUBNOME_RELATORIO', FCadRel[intQuerie].FieldByName('REL_CODREL').AsString));

  Result := AnsiReplaceStr(Result, STR_CODEMP, QuotedStr(VS_strCodEmp));

  Result := AnsiReplaceStr(Result, STR_VERSAO_EXE, QuotedStr(TVersaoExecutavel.GetVersaoArquivo));
  Result := AnsiReplaceStr(Result, STR_RELEASE_EXE, QuotedStr(TVersaoExecutavel.GetVersaoProduto));

  Result := AnsiReplaceStr(Result, STR_DESTINO, QuotedStr(string(ArrDestino[fRetDestino])));
  Result := AnsiReplaceStr(Result, STR_LOGINUSUARIOLOGADO, QuotedStr(strLoginUsuarioLogado));
  Result := AnsiReplaceStr(Result, STR_EMPACESSOUSUARIOLOGADO, QuotedStr(strEmpAcessoUsuarioLogado));
  Result := AnsiReplaceStr(Result, STR_CLACOM, QuotedStr(VS_strClaCom));
  Result := AnsiReplaceStr(Result, STR_CLAVEN, QuotedStr(VS_strClaVen));
  Result := AnsiReplaceStr(Result, STR_CLADEV, QuotedStr(VS_strClaDev));
  Result := AnsiReplaceStr(Result, STR_CLIFIL, IIF((VS_strCliFil)= '""','""',QuotedStr(VS_strCliFil)));
  Result := AnsiReplaceStr(Result, STR_FORFIL, IIF((fRetForFilialTodos)= '""', '""', QuotedStr(fRetForFilialTodos)));
  Result := AnsiReplaceStr(Result, STR_SUBSTITUICAO, QuotedStr(CST_SUBSTITUICAO));
  Result := AnsiReplaceStr(Result, #9, ' ');
  Result := AnsiReplaceStr(Result, STRCLAFISREGISTRADOECF, CLAFIS_REGISTRADO_ECF);


  Result := AnsiReplaceStr(Result, STR_CHARSENHA, QuotedStr(STR_CHAR_SENHA));
  Result := AnsiReplaceStr(Result, STR_CHARTROCA, QuotedStr(STR_CHAR_TROCA));


  Result := AnsiReplaceStr(Result, INTTAMDOCCADREC, INTTOSTR(fTamDocCadRec()));

  If fUsaTmq Then
  Begin
    Result := AnsiReplaceStr(Result, STRIMOBILIARIAS, QuotedStr(Tipo_Tinta.fGetImobiliarias));
    Result := AnsiReplaceStr(Result, STRINDUSTRIAIS,  QuotedStr(Tipo_Tinta.fGetIndustriais));
    Result := AnsiReplaceStr(Result, STRAUTOMOTIVAS,  QuotedStr(Tipo_Tinta.fGetAutomotivas));
  End
  Else
  Begin
    Result := AnsiReplaceStr(Result, STRIMOBILIARIAS, '""');
    Result := AnsiReplaceStr(Result, STRINDUSTRIAIS,  '""');
    Result := AnsiReplaceStr(Result, STRAUTOMOTIVAS,  '""');
  End;

  Result := AnsiReplaceStr(Result, I_STR_CRM_TIP_PC, QuotedStr(STR_CRM_TIP_PC));

  Result := fTrataSaldoProduto(Result);

  If SameText(fCfgSis('LITGAL'), 'L') Then
    Result := AnsiReplaceStr(Result, STR_LITGAL, '1')
  Else
    Result := AnsiReplaceStr(Result, STR_LITGAL, '3.6');

  Result := AnsiReplaceStr(Result, STR_CLAFIS_BR_ENT,         QuotedStr(CLAFIS_BR_ENT));
  Result := AnsiReplaceStr(Result, STR_CLAFIS_BR,             QuotedStr(CLAFIS_BR));
  Result := AnsiReplaceStr(Result, STR_CLAFIS_ENTFUT_VEN_ABR, QuotedStr(CLAFIS_ENTFUT_VEN_ABR));
  Result := AnsiReplaceStr(Result, STR_CLAFIS_ENTFUT_VEN,     QuotedStr(CLAFIS_ENTFUT_VEN));

  If blnTemComposicaoCustoLocal Then
  Begin
    If blnExecucao Then
    Begin

      strFormula := fRetornaComposicao(TcxEditorRow(FFiltros.Rows[FIndexParCusto]).Properties.Value);

      If fEmptyStr(strFormula) Then
        strFormula := '0.00';

      Result := AnsiReplaceStr(Result, STR_PRECUS, 'IFNULL(' + strFormula + ',0)')

    End Else
    Begin

      Result := AnsiReplaceStr(Result, STR_PRECUS, fRetPreCusTeste);

    End;
  End;

//-----------------------------------------------------------------------------------------------
  blnTemInventFinancLocal := (Pos(STR_TABELA_CTR_, strInfo) > 0) Or
                             (Pos(STR_TABELA_PCG_, strInfo) > 0) Or
                             (Pos(STR_TABELA_CAR_, strInfo) > 0) Or
                             (Pos(STR_TABELA_CTP_, strInfo) > 0) Or
                             (Pos(STR_TABELA_CHQ_, strInfo) > 0) Or
                             (Pos(STR_TABELA_FDO_, strInfo) > 0) Or
                             (Pos(STR_TABELA_PCD_, strInfo) > 0) Or
                             (Pos(STR_TABELA_FGO_, strInfo) > 0);

  If blnTemInventFinancLocal Then
    FTemInventFinanc := True;

  If blnTemInventFinancLocal  Then
  Begin

    If blnExecucao Then
    Begin
      Result := AnsiReplaceStr(Result, STR_TABELA_CTR_, fRetTabelaCTR_Selecionada)
    End Else
    Begin
      Result := AnsiReplaceStr(Result, STR_TABELA_CTR_, fRetTabelaCTR_Inicial);
    End;

    Result := AnsiReplaceStr(Result, STR_TABELA_PCG_, 'PCG_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_CAR_, 'CAR_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_CTP_, 'CTP_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_CHQ_, 'CHQ_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_FDO_, 'FDO_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_PCD_, 'PCD_' + FExtensaoCtr);
    Result := AnsiReplaceStr(Result, STR_TABELA_FGO_, 'FGO_' + FExtensaoCtr);
  End;

  If blnSetVS Then
    Result := 'SET @VS_STRCODEMP = ' + QuotedStr(VS_strCodEmp) + '; ' + Result;

  Result := fRetiraFormatacaoSaldos(Result, FGuiaSaldosTemp, blnExecucao, blnQueryFiltros);

  //-----------------------------------------------------------------------------------------------

  blnTemRetTabelaI_Local := Pos(STR_RET_TABELA_I_, strInfo) > 0;
  If blnTemRetTabelaI_Local Then
    Result := fValidaRetTabela(Result, blnExecucao, STR_RET_TABELA_I_, intQuerie);

//-----------------------------------------------------------------------------------------------

  blnTemretTabelaSalInv_Local := Pos(STR_RET_TABELA_SALINV_, strInfo) > 0;
  If blnTemretTabelaSalInv_Local Then
    Result := fValidaRetTabela(Result, blnExecucao, STR_RET_TABELA_SALINV_, intQuerie);

//-----------------------------------------------------------------------------------------------

  blnTemFCampoExiste := Pos(STR_F_CAMPO_EXISTE, strInfo) > 0;
  If blnTemFCampoExiste Then
    Result := fValidaFCampoExiste(Result);

  blnTemFObjetoExiste := Pos(STR_F_OBJETO_EXISTE, strInfo) > 0;
  If blnTemFObjetoExiste Then
    Result := fValidaFObjetoExiste(Result);

//  If Not blnExecucao Then
//    Result := AnsiReplaceStr(Result, 'WHERE', 'WHERE FALSE AND ');
End;

Function TInterfaceRelatorio.fGetSQL: String;
Begin
  Result := FSQL[0];
End;

Procedure TInterfaceRelatorio.pSetSQL(Const Value: String);
Begin
  If (Not SameText(Value, FSqlFormatado[0])) Or FSQLErro Or fMudouHorizo Then
  Begin
    If Not blnExecutandoPeloMenu Then
    Begin
      pInicializaTabelasDinamicas;
      FTemInventFinanc := False;
      FTemComposicaoCusto := False;
    End;

    FLimits.Clear;

    FSqlFormatado[0] := Value;

    FSQL[0] := fRetiraFormatacaoSQL(FSqlFormatado[0], False, False, False{blnQueryFiltros});

    pSetaRecSaldos(arrGuiaSaldos[0]);

    If arrGuiaSaldos[0].strSQLFormatado.IsEmpty Then
      FQueryFiltros[0].SQL.Text := FSQL[0]
    Else
      FQueryFiltros[0].SQL.Text := fRetiraFormatacaoSQL(FSqlFormatado[0], False, False, True{blnQueryFiltros});

    If ((Not blnExecutandoPeloMenu) And blnCarregarCamposAuto) Or
       (blnExecutandoPeloMenu And
       ((SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'S') Or
       (SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'I'))))) Then
      pAtualizaCamposParametros;

    FLimiteTabelas := fGetLimiteTabelas(FSQL[0]);
  End;
End;

Procedure TInterfaceRelatorio.pAtualizaCamposParametros;
Begin
  FSQLErro := False;

    If FCampos.Active Then
      fAtualizaCampos;

    If (Not FSQLErro) And FParams.Active Then
      fAtualizaParametros(True);
End;

Procedure TInterfaceRelatorio.pAtualizaCamposOrderBy;
  Var
    sqlParser: TSQLParser;
    blnOrder,
    blnBy: Boolean;
    strToken: String;
    intToken: Integer;
Begin
  blnOrder := False;
  blnBy    := False;

  FOrderByOriginal.Clear;

  sqlParser := TMyParser.Create(FSQL[0]);

  sqlParser.OmitBlank := False;
  sqlParser.OmitComment := True;
  sqlParser.QuotedString := True;
  sqlParser.DecSeparator := '.';
  sqlParser.ToBegin;

  While sqlParser.CurrPos <= Length(FSQL[0]) Do
  Begin

    intToken := sqlParser.GetNextToken;

    If intToken <> 0 Then
    Begin
      strToken := sqlParser.Lexem;

      If blnBy And (Not SameText(strToken,'BY')) And (strToken <> ',') And (Not fEmptyStr(strToken)) Then
        FOrderByOriginal.Add(strToken);

      If SameText('ORDER', strToken) Then
      Begin
        blnOrder := True;
        blnBy    := False;
        FOrderByOriginal.Clear;
      End;

      If blnOrder And SameText('BY', strToken) Then
      Begin
        blnBy := True;
      End;

    End

    Else Break;

End;

  FOrderBy.Text := FOrderByOriginal.Text;

  FreeAndNil(sqlParser);
End;

Function TInterfaceRelatorio.fGetQtdCamListados(intLinha: Integer): Integer;
Begin
  Result := FQtdCamposListados[intLinha];
End;

Function TInterfaceRelatorio.fGetLarguraUsada(intLinha: Integer): Double;
Begin
  Result := FArrLarguraUsada[intLinha];
End;

Procedure TInterfaceRelatorio.pPedeDados(blnExecutarDireto: Boolean = False;
                                         blnLimpaFiltros: Boolean = False);
var
  LModalResult: TModalResult;
begin
  Self.pPedeDados(blnExecutarDireto, blnLimpaFiltros, LModalResult);
end;

Procedure TInterfaceRelatorio.pPedeDados(blnExecutarDireto: Boolean;
                                         blnLimpaFiltros: Boolean;
                                         var AModalResult: TModalResult);

Begin
  Try
    AModalResult := mrNone;

    FExecutarDireto := blnExecutarDireto;

    If Not fCriaValueParams Then
      Exit;

    if not Assigned(frmPedeDados) then
    begin
      pCriarFormularios(TfrmPedeDadosRelatorio, frmPedeDados);
      TfrmPedeDadosRelatorio(frmPedeDados).Name := '';//A component named frmPedeDadosRelatorio already exists EComponentError.
    end;

    try
      If Assigned(FCadRel[0]) And SameText(Trim(FCadRel[0].FieldByName('REL_DESTIN').AsString), 'TXT') Then
      Begin
        If Not blnExecutandoPeloMenu then
          blnGerarLinhaComando := True;

        TfrmPedeDadosRelatorio(frmPedeDados).btnConfigurar.Visible := False;
      End;

      TfrmPedeDadosRelatorio(frmPedeDados).objInteface := Self;

      TfrmPedeDadosRelatorio(frmPedeDados).Caption := FTitulo;

      FFiltros := TfrmPedeDadosRelatorio(frmPedeDados).cxvFiltros;

      If Assigned(FGeraFr3) Then
      Begin
        FGeraFr3.objInterfaceGera := Self;

        If blnExecutarDireto Then
        Begin
          FGeraFr3.strArquivoSaidaDiretoPDF := FArquivoSaidaDiretoPDF;
          FGeraFr3.strPatImgCab := FPathImagemCabecalho;
        End;

        If FGeraFr3.strTipImp = 'J' Then
          TfrmPedeDadosRelatorio(frmPedeDados).Caption := TfrmPedeDadosRelatorio(frmPedeDados).Caption + ' - Laser'
        Else
          TfrmPedeDadosRelatorio(frmPedeDados).Caption := TfrmPedeDadosRelatorio(frmPedeDados).Caption + ' - Matricial';
      End;

      If fMontaFiltros Then
      Begin
        pRestauraValores;

        If Not blnLimpaFiltros Then
        Begin
          If blnExecutarDireto Or (FFiltros.LastVisibleRow = Nil) Then
            TfrmPedeDadosRelatorio(frmPedeDados).btnImprimir.Click
          Else
            TfrmPedeDadosRelatorio(frmPedeDados).ShowModal;
        End;

      End;

      AModalResult := TfrmPedeDadosRelatorio(frmPedeDados).ModalResult;

    finally

      If Not blnLimpaFiltros Then
      Begin
        if VS_AutcomIniciadoModoRobo then
          FreeAndNil(frmPedeDados)
        else
          pFreeAndNil(frmPedeDados);

        FGeraFr3.objInterfaceGera := Nil;
        FFiltros := Nil;
      End;

    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TInterfaceRelatorio.pPedeDados');
    End;
  End;

  pSetaTRANSACTIONISOLATION;
End;

Procedure TInterfaceRelatorio.pSetaTRANSACTIONISOLATION;
  Var
    qryExecuta: TUniQuery;
Begin
  qryExecuta := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
  Try
    qryExecuta.SQL.Text := 'SHOW VARIABLES';
    qryExecuta.Open;
    If qryExecuta.Locate('Variable_name', 'tx_isolation', []) Then
    Begin
      If SameText(qryExecuta.FieldByName('value').AsString, 'READ-UNCOMMITTED') Then
      Begin
        qryExecuta.Close;
        qryExecuta.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
        qryExecuta.ExecSQL;
      End;
    End;
  Finally
    FreeAndNil(qryExecuta);
  End;
End;

Function TInterfaceRelatorio.fPedeDados(blnExecutarDireto: Boolean = False; blnLimpaFiltros: Boolean = False; const blnRetornarErro : Boolean = True): string;
Begin
  Try
    If Not fCriaValueParams Then
      Exit;

    if not Assigned(frmPedeDados) then
    begin
      pCriarFormularios(TfrmPedeDadosRelatorio, frmPedeDados);
      TfrmPedeDadosRelatorio(frmPedeDados).Name := '';//A component named frmPedeDadosRelatorio already exists EComponentError.
    end;

    try
      TfrmPedeDadosRelatorio(frmPedeDados).objInteface := Self;

      TfrmPedeDadosRelatorio(frmPedeDados).Caption := FTitulo;

      FFiltros := TfrmPedeDadosRelatorio(frmPedeDados).cxvFiltros;

      If Assigned(FGeraFr3) Then
      Begin
        FGeraFr3.objInterfaceGera := Self;

        If blnExecutarDireto Then
        Begin
          FGeraFr3.strArquivoSaidaDiretoPDF := FArquivoSaidaDiretoPDF;
          FGeraFr3.strPatImgCab := FPathImagemCabecalho;
        End;

        If FGeraFr3.strTipImp = 'J' Then
          TfrmPedeDadosRelatorio(frmPedeDados).Caption := TfrmPedeDadosRelatorio(frmPedeDados).Caption + ' - Laser'
        Else
          TfrmPedeDadosRelatorio(frmPedeDados).Caption := TfrmPedeDadosRelatorio(frmPedeDados).Caption + ' - Matricial';
      End;

      If fMontaFiltros Then
      Begin
        pRestauraValores;

        If Not blnLimpaFiltros Then
          If blnExecutarDireto Then
            Result := fLeDadosSQL;
      End;

    finally
      If Not blnLimpaFiltros Then
      Begin
        pFreeAndNil(frmPedeDados);
        FGeraFr3.objInterfaceGera := Nil;
        FFiltros := Nil;
      End;
    end;
  Except
    On E: Exception Do
    Begin
      Result := '';
      If (blnRetornarErro) Then
        Result := E.Message;
    End;
  End;

  pSetaTRANSACTIONISOLATION;
End;

Function TInterfaceRelatorio.fCarregaParametrosExcecucao: Boolean;
Begin
  Try
    Result := False;

    If Not fCriaValueParams Then
      Exit;

    If Not fMontaFiltrosExecucao Then
      Exit;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fCarregaParametrosExcecucao');
    End;
  End;
End;

Function TInterfaceRelatorio.fGetTipo(strTipo: String): TFieldType;
  Var
    facIndice: TTipoInterface;
Begin
  Result := ftUnknown;
  For facIndice := Low(ArrDesParametro) To High(ArrDesParametro) Do
    If SameText(strTipo, String(ArrDesParametro[facIndice])) Then
    Begin
      Result := ArrTipoParametro[facIndice];
      Exit;
    End;
End;

Function TInterfaceRelatorio.fGetTipoInterface(strTipo: String): TTipoInterface;
  Var
    facIndice: TTipoInterface;
Begin
  Result := facString;

  For facIndice := Low(ArrDesInterface) To High(ArrDesInterface) Do
    If SameText(strTipo, String(ArrDesInterface[facIndice])) Then
    Begin
      Result := facIndice;
      Exit;
    End;
End;

Function TInterfaceRelatorio.fGetTipoConfig(strTipo: String): TTipoConfig;
  Var
    cfgIndice: TTipoConfig;
Begin
  Result := cfgAutcom;

  For cfgIndice := Low(ArrDesConfig) To High(ArrDesConfig) Do
    If SameText(strTipo, String(ArrDesConfig[cfgIndice])) Then
    Begin
      Result := cfgIndice;
      Exit;
    End;
End;

Procedure TInterfaceRelatorio.pLimpaTelaFiltros;
  Var
    intIndice: Integer;
Begin
  With FFiltros Do
  Begin
    For intIndice := 0 To Rows.Count - 1 Do
    Begin
      Rows.Items[intIndice].Visible := False;
      Rows.Items[intIndice].Name    := 'P' + IntToStr(intIndice);
      TcxEditorRow(Rows.Items[intIndice]).Styles.Header := Nil;

      With TcxEditorRow(Rows[intIndice]), Properties Do
        OnGetDisplayText := Nil;
    End;

    OptionsView.ScrollBars := ssBoth;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParFloat(intIndice, intDecimais: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(EditProperties).DecimalPlaces := intDecimais;
    TcxCurrencyEditProperties(EditProperties).DisplayFormat := '0.' + fStrZero('0', intDecimais) + ';-0.' + fStrZero('0', intDecimais);
    TcxCurrencyEditProperties(EditProperties).OnValidate := pFiltrosValidate;

    Value := FParams.FieldByName('PAR_VALDEF').AsString;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParInteger(intIndice: Integer);
 Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(EditProperties).DecimalPlaces := 0;
    TcxCurrencyEditProperties(EditProperties).DisplayFormat := '';
    TcxCurrencyEditProperties(EditProperties).OnValidate := pFiltrosValidate;

    Value := FParams.FieldByName('PAR_VALDEF').AsString;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParDate(intIndice: Integer);
var
  strBase64Calendar: string;
  LStream: TBytesStream;
Begin

  strBase64Calendar := 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAA'+
                       'RnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAKYSURBVDhPfZL5SxRh'+
                       'HIcnKju0+0+pSEOkQqRSiUiNDhOPNhUts0NNzRTzyCPL1RTxaDPNrDxBJNNczTIUgz'+
                       'BS99Ddnd1x190tSfdw7dP7vru1/aIDD893hvk+zDDDkWMTweM/tqzDVhd03kzYwElD'+
                       'ggY/hAZj6EwgBk+fxMCp4+gPDsDbQH9G74lj6Ak4gm5/P3Qd9UW732G88fXBC+8DUh'+
                       'Lw4EbCgmFuroS5qQLGxnIYJWUw1j+EoaaIoa8qgL7iPnSPcqAryQJfmAk+Pw2vfA6C'+
                       'BLZxw6FBMJFF7b0EaO7GQ5MeC1WqCHO3ohmzyZFQXLsEecJFyOLOY1p0FvLkGLR6s8'+
                       'B2jj76Ql0J1BmuxdsxbEmZFMFQJISTxQuYEZ3DdEwYpqJCIEuMxMtD+2nAkxM/n4DD'+
                       '8Rs22+o/rHaCyxabw43VfV4mGaMBL67s6TgLPOv4AqXaDEn7BHNDm9P1r8eZhYIbMG'+
                       'jnocu7jiXLCopqR2lgB1dMBodjFTKVaV30WgF6XsC8RsDish15VSPOQH7VR9hXVlHb'+
                       'OoaZWRNqWj4zVzePMlc2fmLmsxMhqAVoMuPx45cd2eXDNLCTyxEPwW53YEppxHfCWt'+
                       'aqtAyeYFq0IaP0PQ3s4jLJYCMBsWQE3xRGPG4YZi6tkzIX1wwyz6VchmaWJ18oCoaf'+
                       'VqQU9tHAbi6VDFYSmJQbMClbWNNqJQ8VRcFj3mRFcm6vM0CHZesKHlQP4Ou0AQVP+p'+
                       'nzKt4x54r7mOWJ4ZiTa9jPpDNacDWrhwb2cHRYIgFapQhmCwSTG3qzlrEM7YITnhCX'+
                       '3u0MRN9skcZldJMLXYil3PlLp5M0Mqd14golldIBESEiqWmIBDwJ5H+m70JrbvauwT'+
                       '4XdPbiOG7jHxkJmflqfDKfAAAAAElFTkSuQmCC';

  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    LStream := TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(strBase64Calendar));
    Try
      EditPropertiesClass := TcxDateEditProperties;
      TcxDateEditProperties(EditProperties).OnValidate := pFiltrosValidate;
      TcxDateEditProperties(EditProperties).View := cavClassic;
      TcxDateEditProperties(EditProperties).DateButtons := [];
      TcxDateEditProperties(EditProperties).ButtonGlyph.LoadFromStream(LStream);
      Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
    Finally
      FreeAndNil(LStream);
    End;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParDiaMes(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := '!99/99;1;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParMesAno(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := '!99/9999;1;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParAno(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := '!9999;1;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParConPag(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := MASK_CONPAG3;
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParCPF(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := '!999.999.999-99;0;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParCNPJ(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := fRetMascaraC_G_C_(fSetaPais, C_G_C_);
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParLotOP(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).EditMask   := '!999999-999;0;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParEspDoc(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).CharCase   := ecUpperCase;
    TcxMaskEditProperties(EditProperties).EditMask   := 'll-ll-ll-ll-ll-ll-ll-ll-ll-ll-ll;1;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParHoraMinSec(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).CharCase   := ecUpperCase;
    TcxMaskEditProperties(EditProperties).EditMask   := '99:99:99;1;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParPlaVei(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxMaskEditProperties;
    TcxMaskEditProperties(EditProperties).CharCase   := ecUpperCase;
    TcxMaskEditProperties(EditProperties).EditMask   := 'aaa-9a99;0;_';
    TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParCheckBox(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxCheckBoxProperties;
    With TcxCheckBoxProperties(EditProperties) Do
    Begin
      ImmediatePost  := True;
      ValueChecked   := FParams.FieldByName('PAR_VALCHK').AsString;
      ValueUnchecked := FParams.FieldByName('PAR_VALNCH').AsString;
    End;

   If FParams.FieldByName('PAR_CHKDEF').AsString = 'S' Then
     Value := 'S'
   Else
     Value := 'N';
  End;
End;

Function TInterfaceRelatorio.fCompletaDescricaoTabelasPrecoAtivas(blnValor: Boolean; intUltimo: Integer): String;
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  stlLista := TStringList.Create;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intContador] = 'S' Then
      If blnValor Then
        stlLista.Add(IntToStr(intContador + intUltimo))
      Else
        stlLista.Add(FParams.FieldByName('PAR_DESATI').AsString + ' ' + IntToStr(intContador));

  Result := stlLista.Text;
  FreeAndNil(stlLista);
End;

Procedure TInterfaceRelatorio.pSetaParComboBox(intIndice: Integer; facInterface: TTipoInterface);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxComboBoxProperties;

    With TcxComboBoxProperties(EditProperties) Do
    Begin
      Items.Text := AnsiReplaceStr(FParams.FieldByName('PAR_FACTXT').AsString, '<<csq>>', #13#10);

      If FParams.FieldByName('PAR_TABATI').AsString = 'S' Then
        Items.Text := Items.Text + fCompletaDescricaoTabelasPrecoAtivas(False, 0);

      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      If facInterface = facComboBoxVerdeVermelho Then
      Begin

        If fVerificaAcessoSistema(FParams.FieldByName('PAR_VERVER').AsString) Then
        Begin

          Styles.Header := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleVerde;

        End Else
        Begin

          Styles.Header := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleVermelho;

          Value := 'NÃO';
          Options.Editing := False;

        End;

      End;

      OnCloseUp := pComboChange;
    End;

    Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

    If Options.Editing Then
      Value := FParams.FieldByName('PAR_VALDEF').AsString;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParTabelaPreco(intIndice: Integer);
  Var
    intContador: Integer;
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxComboBoxProperties;

    With TcxComboBoxProperties(EditProperties) Do
    Begin
      Items.Clear;

      Items.Add('');

      For intContador := 1 To Length(VS_strTabPrc) Do
        If VS_strTabPrc[intContador] = 'S' Then
          Items.Add(IntToStr(intContador));

      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
    End;

  End;
End;

Function TInterfaceRelatorio.fGetLimiteTabelas(strSQL: String): Integer;
  Var
    intPos: Integer;
Begin
  Result := 7;

  intPos := Pos('LIMITE_TABELAS=', strSQL);

  If intPos > 0 Then
  Begin
    Result := StrToIntDef(Copy(strSQL, intPos + Length('LIMITE_TABELAS='), 1), 7);
  End;

End;

Function TInterfaceRelatorio.fDesmarcandoTabela(strMarcadas: String; intIndice: Integer): Boolean;
  Var
    intPos,
    intContador: Integer;
    strTabela,
    strAtivas: String;
Begin

  strAtivas := '';
  For intContador := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intContador] = 'S' Then
       strAtivas := strAtivas + IntToStr(intContador);

  strTabela := Copy(strAtivas, intIndice, 1);

  intPos := Pos(strTabela, strMarcadas);

  Result := intPos > 0;
End;

procedure TInterfaceRelatorio.pClickCheck(Sender: TObject; ItemIndex: Integer; var AllowToggle: Boolean);
  Var
    strMarcadas: String;
begin
  inherited;

  If FIndiceListaPreco = -1 Then
    Exit;

  With FFiltros, TcxEditorRow(Rows[FIndiceListaPreco]), Properties Do
  strMarcadas := DisplayTexts[0];

  If fDesmarcandoTabela(strMarcadas, ItemIndex + 1) Then
    Exit;

  If Length(AnsiReplaceStr(strMarcadas, ';', '')) >= FLimiteTabelas Then
    AllowToggle := False;
end;

Procedure TInterfaceRelatorio.pSetaParTabelaPrecoLista(intIndice: Integer);
  Var
    intContador: Integer;
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    FIndiceListaPreco := intIndice;

    EditPropertiesClass := TcxCheckComboBoxProperties;

    With TcxCheckComboBoxProperties(EditProperties) Do
    Begin
      EmptySelectionText  := '';

      EditValueFormat := cvfCaptions;

      ShowEmptyText  := False;

      onClickCheck := pClickCheck;

      Items.Clear;

      For intContador := 1 To Length(VS_strTabPrc) Do
        If VS_strTabPrc[intContador] = 'S' Then
          Items.AddCheckItem(IntToStr(intContador), IntToStr(intContador));

      ImmediatePost := True;
    End;

  End;
End;

Function TInterfaceRelatorio.fGetCustomCheckList(strNomPar: String): TSelectCheckList;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FArrSelectCheckList) To High(FArrSelectCheckList) Do
    If SameText(FArrSelectCheckList[intContador].strNomPar, strNomPar) Then
    Begin
      Result := FArrSelectCheckList[intContador];
      Exit;
    End;
End;

Function TInterfaceRelatorio.fGetDadosCustomCheckList: TUniQuery;
  Var
    intContador: Integer;
Begin
  With FParams Do
  Begin
    For intContador := Low(FArrSelectCheckList) To High(FArrSelectCheckList) Do
      If SameText(FArrSelectCheckList[intContador].strNomPar, FParams.FieldByName('PAR_NOMPAR').AsString) Then
      Begin
        Result := FArrSelectCheckList[intContador].qryDados;
        Exit;
      End;

    SetLength(FArrSelectCheckList, Succ(Length(FArrSelectCheckList)));

    FArrSelectCheckList[High(FArrSelectCheckList)].intLimRet := FParams.FieldByName('PAR_LIMRET').AsInteger;
    FArrSelectCheckList[High(FArrSelectCheckList)].intLimite := FParams.FieldByName('PAR_LIMCHK').AsInteger;
    FArrSelectCheckList[High(FArrSelectCheckList)].strNomPar := FParams.FieldByName('PAR_NOMPAR').AsString;
    FArrSelectCheckList[High(FArrSelectCheckList)].qryDados  := fCriaQuery(Nil);
    FArrSelectCheckList[High(FArrSelectCheckList)].qryDados.SQL.Text :=
      fRetiraFormatacaoSQLSetEmp(Trim(AnsiReplaceStr(FParams.FieldByName('PAR_SQLCHK').AsString, '<<csq>>', #13#10)));
    FArrSelectCheckList[High(FArrSelectCheckList)].strSqlOri := FArrSelectCheckList[High(FArrSelectCheckList)].qryDados.SQL.Text;

    FArrSelectCheckList[High(FArrSelectCheckList)].qryDados.Open;

    Result := FArrSelectCheckList[High(FArrSelectCheckList)].qryDados;
  End;
End;

procedure TInterfaceRelatorio.pCheckListCloseUp(Sender: TObject);
Begin
  pSalvaMultiSelecaoCustomCheckList;

  If Assigned(FFiltros) And Assigned(FFiltros.FocusedRow) Then
    pAvaliaCheckListCustomizado(TcxEditorRow(FFiltros.FocusedRow).Name);
End;

Function TInterfaceRelatorio.fGetNomeColunaCheckList(strNomCol: String; blnQuoted: Boolean = False): String;
  Var
    intPosIniNum,
    intPosIni,
    intPosFin,
    intContador,
    intNroSel: Integer;
    sltLista: TStringList;
    strCodigo,
    strInfo: String;
Begin
  Result := strNomCol;

  For intContador := Low(arrSelectCheckList) To High(arrSelectCheckList) Do
    If (Pos(arrSelectCheckList[intContador].strNomPar + '(', Result) > 0) And
       arrSelectCheckList[intContador].qryDados.Active And
       (arrSelectCheckList[intContador].qryDados.Fields.Count >= 3) Then
    Begin

      intPosIni    := Pos(arrSelectCheckList[intContador].strNomPar + '(', Result);
      intPosFin    := Pos(')', Result);
      intPosIniNum := intPosIni + Length(arrSelectCheckList[intContador].strNomPar + '(');

      intNroSel := StrToIntDef(Copy(Result, intPosIniNum, intPosFin - intPosIniNum), -1);

      If Assigned(FFiltros) And
         Assigned(FFiltros.RowByName(arrSelectCheckList[intContador].strNomPar)) Then
      Begin
        sltLista := TStringList.Create;

        sltLista.CommaText := ReplaceStr(TcxEditorRow(FFiltros.RowByName(arrSelectCheckList[intContador].strNomPar)).Properties.DisplayTexts[0], ';', ',');

        If (intNroSel > -1) Then
        Begin

          strInfo := '';

          If (sltLista.Count >= intNroSel) Then
          Begin
            strCodigo := sltLista[Pred(intNroSel)];

            If arrSelectCheckList[intContador].qryDados.Locate(arrSelectCheckList[intContador].qryDados.Fields[1].FieldName, strCodigo, []) Then
              strInfo := arrSelectCheckList[intContador].qryDados.Fields[2].AsString;
          End;

          Delete(Result, intPosIni, intPosFin - intPosIni + 1);

          If blnQuoted Then
            strInfo := QuotedStr(strInfo);

          Insert(strInfo, Result, intPosIni);

        End;

        FreeAndNil(sltLista);
      End;

    End;

End;

function TInterfaceRelatorio.fGetNomeTabelaTemporaria(strNome: String): String;
  Var
    ID : TGuid;
begin
  Result := '';
  CreateGUID(ID);
  Result :=  Concat('`', strNome, GuidToString(ID), '`');
end;

Function TInterfaceRelatorio.fAchaTemporaria(strNomeRelatorio: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
    If SameText(strNomeRelatorio, FTabelasTemporarias[intContador].strNome_relatorio) Then
    Begin
      Result := True;
      Exit;
    End;

End;

Function TInterfaceRelatorio.fRetornaTabelaDadosNome(intContador: Integer): String;
Begin
  Result := '';
  Try
    Result := FTabelasTemporarias[intContador].strNome_relatorio;
  Except
    Result := 'frxDataSet' + IntToStr(intContador);
  End;

End;

Function TInterfaceRelatorio.fGeraNomesTemporarias(strSQL: String): String;
  Var
    intPosicao,
    intPosicaoAbre,
    intPosicaoFecha,
    intContador: Integer;
    strNomeRelatorio: String;
Begin
  if (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') then
    SetLength(FTabelasTemporarias, 0);

  While Pos('GERANOMETEMPORARIA', UpperCase(strSQL)) > 0 Do
  Begin
    intPosicao := Pos('GERANOMETEMPORARIA', UpperCase(strSQL));

    intPosicaoAbre := Pos('(', strSQL, intPosicao);
    intPosicaoFecha := Pos(')', strSQL, intPosicao);

    strNomeRelatorio := Trim(Copy(strSQL, intPosicaoAbre + 1, intPosicaoFecha - (intPosicaoAbre + 1)));

    If Not fAchaTemporaria(strNomeRelatorio) Then
    Begin
      SetLength(FTabelasTemporarias, Succ(Length(FTabelasTemporarias)));
      FTabelasTemporarias[High(FTabelasTemporarias)].strNome_relatorio := strNomeRelatorio;
      FTabelasTemporarias[High(FTabelasTemporarias)].strNome_banco := fGetNomeTabelaTemporaria(FTabelasTemporarias[High(FTabelasTemporarias)].strNome_relatorio);
    End;

    System.Delete(strSQL, intPosicao, intPosicaoFecha - intPosicao + 1);
    If fRetDestino = desTrace Then
      System.Insert('DROP TABLE IF EXISTS ' + strNomeRelatorio + ';', strSQL, intPosicao);
  End;

  For intContador := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
    strSQL := AnsiReplaceStr(strSQL, FTabelasTemporarias[intContador].strNome_relatorio,  FTabelasTemporarias[intContador].strNome_banco);

  Result := strSQL;
End;

Procedure TInterfaceRelatorio.pDropTemporarias;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
    fExecutaSQL(Concat('DROP TABLE IF EXISTS ', FTabelasTemporarias[intContador].strNome_banco));
End;

Function TInterfaceRelatorio.fGetListaTemporarias: String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
  Begin
    Result := Concat(FTabelasTemporarias[intContador].strNome_relatorio, ';', FTabelasTemporarias[intContador].strNome_banco);
    If intContador <> High(FTabelasTemporarias) Then
      Result := Concat(Result, #13#10);
  End;
End;

Procedure TInterfaceRelatorio.pCarregaTemporarias(strTemporarias: String);
  Var
    stlTemporarias: TStringList;
    intInicio,
    intContador: Integer;
Begin
  stlTemporarias := TStringList.Create;
  stlTemporarias.Text := strTemporarias;
  intInicio := Length(FTabelasTemporarias);

  SetLength(FTabelasTemporarias, Length(FTabelasTemporarias) + stlTemporarias.Count);

  For intContador := 0 To stlTemporarias.Count - 1 Do
  Begin
    FTabelasTemporarias[intInicio + intContador].strNome_relatorio := LeftStr(stlTemporarias[intContador], Pred(Pos(';', stlTemporarias[intContador])));
    FTabelasTemporarias[intInicio + intContador].strNome_banco := RightStr(stlTemporarias[intContador], Length(stlTemporarias[intContador])- Pos(';', stlTemporarias[intContador]));
  End;

  FreeAndNil(stlTemporarias);
End;

Function TInterfaceRelatorio.fTrocaBrancoNomeColunaCheckList(strEspressao: String): String;
  Var
    strExpress,
    strValor,
    strFilter,
    strIndexFieldNames: String;
    blnFiltered: Boolean;
    intFechaParent,
    intPosicao,
    intInicio,
    intRecNo: Integer;
    dssState: TDataSetState;
Begin
  With FParams Do
  Begin
    strFilter          := Filter;
    blnFiltered        := Filtered;
    intRecNo           := RecNo;
    dssState           := State;
    strIndexFieldNames := IndexFieldNames;

    Result := strEspressao;

    Try
      Filtered := False;

      IndexFieldNames := 'PAR_NOMPAR';

      Filter   := 'PAR_TIPFAC = ' + QuotedStr(ArrDesInterface[facCustomCheckList]);
      Filtered := True;

      intInicio := 1;
      Last;
      While (Not Bof) Do
      Begin

        intPosicao := Pos(FieldByName('PAR_NOMPAR').AsString + '(', Result, intInicio);

        If intPosicao > 0 Then
        Begin
          intFechaParent := Pos(')', Result, intPosicao);

          If intFechaParent > 0 Then
          Begin
            strExpress := Copy(Result, intPosicao, intFechaParent - intPosicao + 1);
            strValor   := '';
            Result     := AnsiReplaceStr(Result, strExpress, QuotedStr(strValor));

            intInicio := intFechaParent;
          End

          Else intInicio := intPosicao + Length(FieldByName('PAR_NOMPAR').AsString);

        End;

        Prior;
      End;

    Finally
      IndexFieldNames := strIndexFieldNames;
      Filter          := strFilter;
      Filtered        := blnFiltered;
      RecNo           := intRecNo;
      case dssState of
        dsBrowse : Cancel;
        dsEdit   : Edit;
        dsInsert : Insert;
      end;
    End;

  End;
End;

Function TInterfaceRelatorio.fDisplayTextsToValPar(strDisplay: String): String;
  Var
    arrSel: TConsultasArray;
    sltLista: TStringList;
    intContador: Integer;
Begin
  strDisplay := Trim(strDisplay);

  If fEmptyStr(strDisplay) Then
  begin
    Result := '';
  End Else
  Begin
    sltLista := TStringList.Create;
    sltLista.Text := ReplaceStr(strDisplay, ';', #13#10);

    SetLength(arrSel, sltLista.Count);

    For intContador := 0 To sltLista.Count - 1 Do
      arrSel[intContador].strCodigo := sltLista[intContador];

    TConsultasRel.pMontaValPar(Result, arrSel, True);

    SetLength(arrSel, 0);

    FreeAndNil(sltLista);
  End;

End;

Procedure TInterfaceRelatorio.pSalvaMultiSelecaoCustomCheckList;
  Var
    strValPar: String;
Begin
  strValPar := fDisplayTextsToValPar(TcxEditorRow(FFiltros.FocusedRow).Properties.DisplayTexts[0]);

  If FValueParams.Locate('NOMPAR', FFiltros.FocusedRow.Name, []) Then
  Begin
    FValueParams.Edit;

    FValueParams.FieldByName('DESEDT').AsString := TcxEditorRow(FFiltros.FocusedRow).Properties.DisplayTexts[0];

    If Pos(' IN', strValPar) > 0 Then
    Begin
      FValueParams.FieldByName('VALPAR').AsString := strValPar;
    End Else
    Begin
      FValueParams.FieldByName('VALPAR').Clear;
      FValueParams.Post;
    End;
  End;

End;

Function TInterfaceRelatorio.fMudaParaRetrato: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := Low(arrSelectCheckList) To High(arrSelectCheckList) Do
  With arrSelectCheckList[intContador] Do
  If (intLimRet > 0) And (fGetQtdMarcados(strNomPar) <= intLimRet) Then
  Begin
    Result := True;
    Exit;
  End;

End;

Function TInterfaceRelatorio.fGetQtdMarcados(strNomPar: String): Integer;
  Var
    strMarcadas: String;
Begin
  Result := 0;

  If Assigned(FFiltros) And
     Assigned(FFiltros.RowByName(strNomPar)) Then
  With TcxEditorRow(FFiltros.RowByName(strNomPar)), Properties Do
  Begin
    strMarcadas := DisplayTexts[0];

    If Not fEmptyStr(strMarcadas) Then
      Result := 1 + strMarcadas.CountChar(';');
  End;
End;

procedure TInterfaceRelatorio.pClickCustomCheckList(Sender: TObject; ItemIndex: Integer; var AllowToggle: Boolean);
  Var
    strMarcadas: String;
    intLimite,
    intMarcados: Integer;
    staState: TCxCheckBoxState;
begin
  inherited;

  staState := TcxCheckComboBox(Sender).States[ItemIndex];

  With FFiltros, TcxEditorRow(FocusedRow), Properties Do
  Begin
    strMarcadas := DisplayTexts[0];

    If fEmptyStr(strMarcadas) Then
      intMarcados := 0
    Else
      intMarcados := 1 + strMarcadas.CountChar(';');

    If staState <> cbsChecked Then
    Begin
      intLimite := fGetCustomCheckList(TcxEditorRow(FocusedRow).Name).intLimite;
      AllowToggle := (intLimite = 0) Or (intMarcados < intLimite);
    End;
  End;
end;

Procedure TInterfaceRelatorio.pSetaParCustomCheckList(intIndice: Integer);
Begin

  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxCheckComboBoxProperties;

    With TcxCheckComboBoxProperties(EditProperties) Do
    Begin
      EmptySelectionText  := '';

      EditValueFormat := cvfCaptions;

      ShowEmptyText  := False;

      onClickCheck := pClickCustomCheckList;

      Items.BeginUpdate;
      Items.Clear;

      With fGetDadosCustomCheckList Do
      Begin

        First;
        While Not Eof Do
        Begin
          Items.AddCheckItem(Fields[0].AsString, Fields[1].AsString);
          Next;
        End;

        IndexFieldNames := Fields[1].FieldName;
      End;

      ImmediatePost := True;

      Items.EndUpdate;

      onCloseUp := pCheckListCloseUp;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParRadioGroup(intIndice: Integer);
  Var
    stlDescricao,
    stlValores: TStringList;
    radItem: TcxRadioGroupItem;
    intUltimo,
    intItens: Integer;
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxRadioGroupProperties;

    With TcxRadioGroupProperties(EditProperties) Do
    Begin
      ImmediatePost := True;

      stlDescricao := TStringList.Create;
      stlDescricao.Text := AnsiReplaceStr(FParams.FieldByName('PAR_FACTXT').AsString, '<<csq>>', #13#10);

      If FParams.FieldByName('PAR_TABATI').AsString = 'S' Then
        stlDescricao.Text := stlDescricao.Text + fCompletaDescricaoTabelasPrecoAtivas(False, 0);

      stlValores := TStringList.Create;
      stlValores.Text := AnsiReplaceStr(FParams.FieldByName('PAR_FACVAL').AsString, '<<csq>>', #13#10);

      If stlValores.Count > 0 Then
        intUltimo := StrToIntDef(stlValores[stlValores.Count -1], 0)
      Else
        intUltimo := 0;

      If FParams.FieldByName('PAR_TABATI').AsString = 'S' Then
        stlValores.Text := stlValores.Text + fCompletaDescricaoTabelasPrecoAtivas(True, intUltimo);

      For intItens := 0 To stlDescricao.Count - 1 Do
      Begin
        radItem := Items.Add;
        radItem.Caption := stlDescricao[intItens];

        If intItens < stlValores.Count Then
          radItem.Value   := stlValores[intItens]
        Else
          radItem.Value   := '';
      End;

      If (stlDescricao.IndexOf(FParams.FieldByName('PAR_VALDEF').AsString) < stlValores.Count) And
         (stlDescricao.IndexOf(FParams.FieldByName('PAR_VALDEF').AsString) > -1)  Then
      Begin
        Value := stlValores[stlDescricao.IndexOf(FParams.FieldByName('PAR_VALDEF').AsString)]
      End Else
      Begin
        Value := '';
      End;

      FreeAndNil(stlDescricao);
      FreeAndNil(stlValores);
    End;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParString(intIndice: Integer);
Var
  pesPesquisa: TPesquisas;
  intTamCampo: Integer;
  strBase64Pesquisa: string;
  LStream: TBytesStream;
Begin

  strBase64Pesquisa := 'Qk02BAAAAAAAADYAAAAoAAAAEAAAABAAAAABACAAAAAAAAAEAAAAAAAAAAAAAAAAAA'+
                       'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
                       'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
                       'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAAACgAAABYAAAAb'+
                       'AAAAFwAAAAsAAAACAAAAAAAAAAEAAAAGAAAACwAAAA8AAAAMAAAABgAAAAEAAAAAAA'+
                       'AADyYWEHJYNCTYaT0q/00sH9kdEQt1AAAAEgAAAAMAAAAIJBYRYlEwI89hOSf/RSgb'+
                       '0BoPCmMAAAAJAAAAASkaE22jgHD/1MW9/+3l4f/Pvrf/kHFj/x8SDHcAAAAPLBwWY6'+
                       'GBcv/Uxr7/7ujk/83AuP+Gal3/GQ4JYAAAAAVzSTfe49fR/86unv+veVf/0LOe/9fJ'+
                       'w/9VMyTgAAAAG3dQP9ji19L/0K2b/7N3U//Sspr/1svF/0orHtkAAAAKjlpH+/j29P'+
                       '+uclv/569m/7J/Xv/w6+j/dEg1/wAAAEiaa1X/+Pbz/7JwVv/or2T/tn5Z/+rj3/9h'+
                       'Oyn6AAAAC5BgTfjx6OT/0rCl/6psU//Utqf/zcC6/3FCL/9MKSD/gFE9//Ho4//Tra'+
                       'H/rmhP/9Syof/Ftq//akIx9wAAAAlYPDGiyq+j//fy7v/9/Pv/6uDa/56Eev93SDX/'+
                       'Zj42/4VZRP/o2c//9/Dt//z6+f/f1M7/imZX/0UtIpoAAAAFCAUEHZ9yXfjo29T/5t'+
                       'fO/823qv+La17/fUw6/4ZfVv+LX0v/6djO/+rc1P/Puaz/mXtt/5ZqVPcHBQQWAAAA'+
                       'AQAAAAdgRzuk0Let/+7j3//Vwbf/k3Zs/4JTP/9zRjX/kmVQ/+zg2f/r3tj/xLCl/5'+
                       't4aP9fRTidAAAABAAAAAAAAAACIhkVQbiTg//z6+j/2cnC/6mTif+meWb/AAAAJrSL'+
                       'dv/w5+P/6t7Z/72nn/+mfWz/IRkVOQAAAAEAAAAAAAAAAAAAAAeEZVTG3czE/+bc2P'+
                       '/CqZ7/pn5p+QAAAAyzjnn44NHJ/+nf2v+8pJf/hGVVwgAAAAMAAAAAAAAAAAAAAAAA'+
                       'AAACEw8NI31hUrevhnP6e2BQuRMODCcAAAAEFBAOHoNlWLO2j3n5gGRVsxMPDR4AAA'+
                       'ABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAABgAAAAUAAAACAAAAAAAAAAAAAAAB'+
                       'AAAAAQAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'+
                       'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA==';

  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    LStream := TBytesStream.Create(TNetEncoding.Base64.DecodeStringToBytes(strBase64Pesquisa));
    Try
      pesPesquisa := TConsultasRel.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString);
      intTamCampo  := TConsultasRel.fTamanhoCampoPesquisa(pesPesquisa);

      Case pesPesquisa Of
        pesLinhaGrupo: Begin
                         EditPropertiesClass := TcxMaskEditProperties;
                         TcxMaskEditProperties(EditProperties).EditMask      := '999.999;1;_';
                         TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
                         TcxTextEditProperties(EditProperties).Buttons.Add;
                         TcxTextEditProperties(EditProperties).Buttons[0].Kind := bkGlyph;
                         TcxTextEditProperties(EditProperties).Buttons[0].Glyph.LoadFromStream(LStream);
                         TcxTextEditProperties(EditProperties).OnButtonClick := pFiltrosButtonClick;
                         Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
                         OnGetDisplayText := pGetDisplayText;
                       End;

        pesPlanoContas: Begin
                          EditPropertiesClass := TcxMaskEditProperties;
                          TcxMaskEditProperties(EditProperties).EditMask      := '99.99.999;0;_';
                          TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
                          TcxTextEditProperties(EditProperties).Buttons.Add;
                          TcxTextEditProperties(EditProperties).Buttons[0].Kind := bkGlyph;
                          TcxTextEditProperties(EditProperties).Buttons[0].Glyph.LoadFromStream(LStream);
                          TcxTextEditProperties(EditProperties).OnButtonClick := pFiltrosButtonClick;
                          Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
                          OnGetDisplayText := pGetDisplayText;
                        End;

        pesPlanoContabilNovo: Begin
                                EditPropertiesClass := TcxMaskEditProperties;
                                TcxMaskEditProperties(EditProperties).EditMask   := fCfgSis('MSKCON') + ';1;_';
                                TcxMaskEditProperties(EditProperties).OnValidate := pFiltrosValidate;
                                TcxTextEditProperties(EditProperties).Buttons.Add;
                                TcxTextEditProperties(EditProperties).Buttons[0].Kind := bkGlyph;
                                TcxTextEditProperties(EditProperties).Buttons[0].Glyph.LoadFromStream(LStream);
                                TcxTextEditProperties(EditProperties).OnButtonClick := pFiltrosButtonClick;
                                Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
                                OnGetDisplayText := pGetDisplayText;
                              End;

        Else Begin
               EditPropertiesClass := TcxTextEditProperties;
               TcxTextEditProperties(EditProperties).CharCase   := ecUpperCase;
               TcxTextEditProperties(EditProperties).OnValidate := pFiltrosValidate;
               If Not fEmptyStr(FParams.FieldByName('PAR_PESQUI').AsString) Then
               Begin
                 TcxTextEditProperties(EditProperties).Buttons.Add;
                 TcxTextEditProperties(EditProperties).Buttons[0].Kind := bkGlyph;
                 TcxTextEditProperties(EditProperties).Buttons[0].Glyph.LoadFromStream(LStream);
                 TcxTextEditProperties(EditProperties).OnButtonClick := pFiltrosButtonClick;
                 Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
               End;

               If (pesPesquisa = pesOperador) And
                  (Not fEmptyStr(FParams.FieldByName('PAR_VERVER').AsString)) Then
               Begin

                 If fVerificaAcessoSistema(FParams.FieldByName('PAR_VERVER').AsString) Then
                 Begin

                   Styles.Header := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleVerde;

                 End Else
                 Begin

                   Styles.Header := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleVermelho;
                   TcxTextEditProperties(EditProperties).EchoMode     := eemPassword;
                   TcxTextEditProperties(EditProperties).PasswordChar := '*';
                   intTamCampo := 10;

                 End;

               End;

               If (intTamCampo > 0) Or (pesPesquisa in [pesLocalizacaoFisica, pesCodigoReceita, pesGuiaReceita, pesLote]) Then
               Begin
                 OnGetDisplayText := pGetDisplayText;

                 If (intTamCampo > 0) Then
                   TcxTextEditProperties(EditProperties).MaxLength := intTamCampo;
               End;

             End;
      End;
    Finally
      FreeAndNil(LStream);
    End;

    Value := FParams.FieldByName('PAR_VALDEF').AsString;
  End;
End;

Procedure TInterfaceRelatorio.pSetaParDocumento(intIndice: Integer);
  Var
    intTamCampo: Integer;
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    intTamCampo  := 12;
    EditPropertiesClass := TcxTextEditProperties;
    TcxTextEditProperties(EditProperties).OnValidate := pFiltrosValidate;
    TcxTextEditProperties(EditProperties).MaxLength := intTamCampo;
  End;
End;

Function TInterfaceRelatorio.fRetCategoria(strNomCat: String): TcxCategoryRow;
  Var
    intContador: Integer;
Begin
  Result := Nil;

  For intContador := 0 To FFiltros.Rows.Count - 1 Do
    If FFiltros.Rows[intContador].IsCategory And
       SameText(FFiltros.Rows[intContador].Name, strNomCat) Then
    Begin
      Result := TcxCategoryRow(FFiltros.Rows[intContador]);
      Break;
    End;
End;

Function TInterfaceRelatorio.fRetCategoriaCaption(strNomCat: String): TcxCategoryRow;
  Var
    intContador: Integer;
Begin
  Result := Nil;

  For intContador := 0 To FFiltros.Rows.Count - 1 Do
    If FFiltros.Rows[intContador].IsCategory And
       SameText(TcxCategoryRow(FFiltros.Rows[intContador]).Properties.Caption, strNomCat) Then
    Begin
      Result := TcxCategoryRow(FFiltros.Rows[intContador]);
      Break;
    End;
End;


Procedure TInterfaceRelatorio.pSetaFiltroGrupoParametro(strTipGru: String);
Begin
  With FGruposParams Do
  Begin
    DisableControls;
    FFilteredGruParAnt := Filtered;
    FFilterGruParAnt   := Filter;

    Filter   := 'GRU_TIPGRU = ' + QuotedStr(strTipGru);
    Filtered := True;
  End;
End;

Procedure TInterfaceRelatorio.pFiltraGrupoParametro(strTipGru: String);
Begin
  With FGruposParams Do
  Begin
    Filter   := 'GRU_TIPGRU = ' + QuotedStr(strTipGru);
    Filtered := True;
  End;
End;

Procedure TInterfaceRelatorio.pRestauraFiltroGrupoParametro;
Begin
  With FGruposParams Do
  Begin
    Filter   := FFilterGruParAnt;
    Filtered := FFilteredGruParAnt;
    EnableControls;
  End;
End;

Function TInterfaceRelatorio.fRetornaNomeGrupo(strCodGru, strTipGru: String; Var strNomGru: String): Boolean;
  Var
    intTipBan: Integer;
Begin
  Result := fRetornaNomeGrupo(strCodGru, strTipGru, strNomGru, intTipBan);
End;

Function TInterfaceRelatorio.fRetornaNomeGrupo(strCodGru, strTipGru: String; Var strNomGru: String; Var intTipBan: Integer): Boolean;
  Var
    intContador: Integer;
    strFilterAnt,
    strFilter: String;
    blnFilteredAnt: Boolean;
Begin
  Result := False;
  intTipBan := 0;

  blnFilteredAnt := FGruposParams.Filtered;
  strFilterAnt   := FGruposParams.Filter;

  strFilter      := 'GRU_TIPGRU = ' + QuotedStr(strTipGru);

  If Not SameText(FGruposParams.Filter, strFilter) Then
    FGruposParams.Filter := strFilter;

  If Not FGruposParams.Filtered Then
    FGruposParams.Filtered := True;

  If FGruposParams.Locate('GRU_CODGRU', strCodGru, []) Then
  Begin

    strNomGru := fRetornaValorVariavel(FGruposParams.FieldbyName('GRU_NOMGRU').AsString, False);

    intTipBan := FGruposParams.FieldbyName('GRU_TIPBAN').AsInteger;

    Result := True;

  End Else
  Begin

    For intContador := Succ(Low(FGruposParametros)) To High(FGruposParametros) Do
    If FGruposParametros[intContador].Locate('GRU_CODGRU', strCodGru, []) Then
    Begin
      strNomGru := fRetornaValorVariavel(FGruposParametros[intContador].FieldbyName('GRU_NOMGRU').AsString, False);
      intTipBan := FGruposParametros[intContador].FieldbyName('GRU_TIPBAN').AsInteger;

      Result := True;
      Exit;
    End;

  End;

  If Not SameText(strFilterAnt, FGruposParams.Filter) Then
    FGruposParams.Filter := strFilterAnt;

  If blnFilteredAnt <> FGruposParams.Filtered Then
    FGruposParams.Filtered := blnFilteredAnt;
End;

Procedure TInterfaceRelatorio.pSetaDataType(qryDados: TUniQuery);
  Var
    intContador: Integer;
Begin
  With qryDados Do
  For intContador := 0 To Params.Count - 1 Do
    With Params[intContador] Do
    If FParams.Locate('PAR_NOMPAR', Name, []) Then
      DataType := fGetTipo(FParams.FieldByName('PAR_TIPPAR').AsString);
End;

Function TInterfaceRelatorio.fComFilToName(strNome: String): String;
Begin
  Result := AnsiReplaceStr(strNome, '@', 'ARROBA_');
End;

Function TInterfaceRelatorio.fParametroVisivel(strSQLVis: String; blnComParametros: Boolean; cdsParams: TUniClientDataSet): Boolean;
  Var
    qrySQLVis: TUniQuery;
    strSQLTxt: String;
    blnFaltaInformacao: Boolean;
    slNomes: TStringList;
    intIdx: Integer;
Begin
  Result := True;

  // SE TIVER PARÂMETRO TEM QUE EXECITAR EM TEMPO DE EXECUÇÃO DE DIGITAÇÃO DE FILTROS
  If (Not blnComParametros) And (Pos(':', strSQLVis) > 0) Then
    Exit;

  Try
    strSQLTxt := AnsiReplaceStr(strSQLVis, '<<csq>>', #13#10);
    strSQLVis := AnsiReplaceStr(strSQLVis, '<<csq>>', ' ');

    If fEmptyStr(strSQLVis) Then
    Begin

      cdsParams.Edit;
      cdsParams.FieldByName('PARVIS').AsInteger := 1;
      cdsParams.Post;

      Exit;
    End;

    strSQLVis := fRetiraFormatacaoSQL(strSQLVis, True, True, False);

    qrySQLVis := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

    With qrySQLVis Do
    Begin
      SQL.Text := strSQLVis;

      If blnComParametros Then
      Begin

        slNomes := TStringList.Create;
        Try
          For intIdx := 0 To Params.Count - 1 Do
            slNomes.Add(Params[intIdx].Name);

          For intIdx := 0 To slNomes.Count - 1 Do
            If fTemMultiSelecao(slNomes[intIdx]) Then
              strSQLVis := fPoeMultiSelecao(strSQLVis, slNomes[intIdx],
                                            FValueParams.FieldByName('VALPAR').AsString);
        Finally
          slNomes.Free;
        End;

        SQL.Text := strSQLVis;

        Result := fSetaDadosQuery(qrySQLVis, qrySQLVis, False, blnFaltaInformacao);
      End;

      Open;

      Result := Fields[0].AsString = '1';

      FParams.Edit;
      FParams.FieldByName('PARVIS').AsInteger := IfThen(Result, 1, 0);
      FParams.Post;

    End;

  Except
    On E: Exception Do
    Begin

      pCriarFormularios(TfrmMsgErroSQL, frmMsgErroSQL);
      frmMsgErroSQL.mmoErrSQL.Lines.text := 'SQL com erro:' + #13#10#13#10 + strSQLTxt + #13#10#13#10 + E.Message;
      frmMsgErroSQL.ShowModal;
      pFreeAndNil(frmMsgErroSQL);

    End;
  End;

  FreeAndNil(qrySQLVis);
End;

Procedure TInterfaceRelatorio.pIncluiExprVisibilParametrosAutomaticos;
Begin
  cdsParametrosAutomaticos.First;

  While Not cdsParametrosAutomaticos.Eof Do
  Begin
    pIncluiExprVisibilParametro(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString,
                                cdsParametrosAutomaticos.FieldByName('PAR_EXPVIS').AsString);

    pIncluiSQLVisibilParametro(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString,
                               cdsParametrosAutomaticos.FieldByName('PAR_SQLVIS').AsString);

    pIncluiEmpConfigParametro(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString,
                              cdsParametrosAutomaticos.FieldByName('PAR_EMPCFG').AsString);

    cdsParametrosAutomaticos.Next;
  End;

End;

Procedure TInterfaceRelatorio.pInicializaParametrosAutomaticos;
Begin
  cdsParametrosAutomaticos.First;

  While Not cdsParametrosAutomaticos.Eof Do
  Begin
    cdsParametrosAutomaticos.Edit;
    cdsParametrosAutomaticos.FieldByName('PARVIS').AsInteger := 1;
    cdsParametrosAutomaticos.FieldByName('IMPFIL').AsInteger := 1;
    cdsParametrosAutomaticos.Post;

    cdsParametrosAutomaticos.Next;
  End;

End;


Procedure TInterfaceRelatorio.pIncluiFiltroGrid;
  Var
    intQtdPar: Integer;
    facInterface: TTipoInterface;
    crwCategoria: TcxCategoryRow;
    erwEditor: TcxEditorRow;
    strNomGru: String;
Begin
  pInicializaParametrosAutomaticos;

  FParams.First;

  With FFiltros Do
  While Not FParams.Eof Do
  Begin

    If Not fParametroVisivel(FParams.FieldByName('PAR_SQLVIS').AsString, False, FParams) Then
    Begin
      FParams.Next;
      Continue;
    End;

    pIncluiExprVisibilParametro(FParams.FieldByName('PAR_NOMPAR').AsString,
                                FParams.FieldByName('PAR_EXPVIS').AsString);

    pIncluiSQLVisibilParametro(FParams.FieldByName('PAR_NOMPAR').AsString,
                               FParams.FieldByName('PAR_SQLVIS').AsString);

    pIncluiEmpConfigParametro(FParams.FieldByName('PAR_NOMPAR').AsString,
                              FParams.FieldByName('PAR_EMPCFG').AsString);

    crwCategoria := Nil;

    If (Not fEmptyStr(FParams.FieldByName('PAR_CODGRU').AsString)) Then
    Begin

      crwCategoria := fRetCategoria('C' + FParams.FieldByName('PAR_CODGRU').AsString);

      If (Not Assigned(crwCategoria)) And fRetornaNomeGrupo(FParams.FieldByName('PAR_CODGRU').AsString, '0', strNomGru) Then
      Begin
        crwCategoria := TcxCategoryRow(FFiltros.Add(TcxCategoryRow));
        crwCategoria.Name               := 'C' + FParams.FieldByName('PAR_CODGRU').AsString;
        crwCategoria.Properties.Caption := strNomGru;
        crwCategoria.Properties.HeaderAlignmentHorz := taCenter;
        crwCategoria.Options.TabStop := False;
      End;

    End;

    If SameText(FParams.FieldByName('PAR_GATPER').AsString, 'S') Then
      pIncluiComboGatilhoPeriodo(crwCategoria, FParams.FieldByName('PAR_NOMPAR').AsString);

    If Assigned(crwCategoria) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoria, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    If FParams.FieldByName('PAR_ORIPAR').AsInteger = 1 Then
    Begin
      erwEditor.Properties.Options.Editing := False;
      erwEditor.Options.TabStop  := False;
      erwEditor.Options.Focusing := False;
      erwEditor.Styles.Content   := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleComplemento;
      erwEditor.Styles.Header    := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleTituloComplemento;
    End;

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    intQtdPar := erwEditor.AbsoluteIndex;

    Rows.Items[intQtdPar].Visible := True;
  //  Rows.Items[intQtdPar].Visible := Not SameText(FParams.FieldByName('PAR_INVISI').AsString, 'S');

    Rows.Items[intQtdPar].Name := fComFilToName(FParams.FieldByName('PAR_NOMPAR').AsString);

    TcxEditorRow(Rows[intQtdPar]).Properties.Caption := FParams.FieldByName('PAR_DESPAR').AsString + ' ';

    facInterface := fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString);

    If SameText(FParams.FieldByName('PAR_OBRIGA').AsString, 'S') And
       (Not (facInterface in [facCheckBox, facComboBox, facComboBoxVerdeVermelho, facRadioGroup])) Then
    Begin
      TcxEditorRow(Rows[intQtdPar]).Styles.Header := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleTituloBold;

      TcxEditorRow(Rows[intQtdPar]).Properties.Caption := '* ' + TcxEditorRow(Rows[intQtdPar]).Properties.Caption;

      TcxEditorRow(Rows[intQtdPar]).Tag := 1;
    End;

    With TcxEditorRow(Rows[intQtdPar]), Properties Do
    Case facInterface Of
      facFloat           : pSetaParFloat(intQtdPar, FParams.FieldByName('PAR_NRODEC').AsInteger);
      facInteger         : pSetaParInteger(intQtdPar);
      facDate            : pSetaParDate(intQtdPar);
      facDiaMes          : pSetaParDiaMes(intQtdPar);
      facMesAno          : pSetaParMesAno(intQtdPar);
      facAno             : pSetaParAno(intQtdPar);
      facConPag          : pSetaParConPag(intQtdPar);
      facCPF             : pSetaParCPF(intQtdPar);
      facCNPJ            : pSetaParCNPJ(intQtdPar);
      facLotOP           : pSetaParLotOP(intQtdPar);
      facPlaVei          : pSetaParPlaVei(intQtdPar);
      facEspDoc          : pSetaParEspDoc(intQtdPar);
      facHoraMinSeg      : pSetaParHoraMinSec(intQtdPar);
      facDocumento       : pSetaParDocumento(intQtdPar);
      facTabelaPreco     : pSetaParTabelaPreco(intQtdPar);
      facTabelaPrecoLista: pSetaParTabelaPrecoLista(intQtdPar);
      facCheckBox        : pSetaParCheckBox(intQtdPar);
    //  facDirectory       : pSetaParDirectory(intQtdPar);

      facComboBox,
      facComboBoxVerdeVermelho : pSetaParComboBox(intQtdPar, facInterface);

      facRadioGroup            : pSetaParRadioGroup(intQtdPar);

      facCustomCheckList       : pSetaParCustomCheckList(intQtdPar);

      Else                       pSetaParString(intQtdPar);
    End;

    FParams.Next;
  End;

  pIncluiExprVisibilParametrosAutomaticos;
End;

Procedure TInterfaceRelatorio.pLiberaSelectCheckList;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FArrSelectCheckList) To High(FArrSelectCheckList) Do
    If Assigned(FArrSelectCheckList[intContador].qryDados) Then
      FreeAndNil(FArrSelectCheckList[intContador].qryDados);

  SetLength(FArrSelectCheckList, 0);
End;

Procedure TInterfaceRelatorio.pApagaCadVal(strSeqGer: string);
Var
  qryDelCadVal: TUniQuery;
Begin

  qryDelCadVal := fCriaQuery(Self);

  Try
    qryDelCadVal.SQL.Clear;
    qryDelCadVal.SQL.Add('DELETE FROM ' + FTabelaFiltrosValores + ' WHERE VAL_SEQGER = :SEQGER AND VAL_CODOPE = :CODOPE');
    qryDelCadVal.ParamByName('SEQGER').AsString := strSeqGer;
    qryDelCadVal.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryDelCadVal.ExecSQL;
  Finally
    FreeAndNil(qryDelCadVal);
  End;

End;

Procedure TInterfaceRelatorio.pCriaCategoriaGeracao;
Begin
  crwCategoriaGeracao := fRetCategoriaCaption('Geração');

  If Not Assigned(crwCategoriaGeracao) Then
  Begin
    crwCategoriaGeracao := TcxCategoryRow(FFiltros.Add(TcxCategoryRow));
    crwCategoriaGeracao.Name               := 'CGeracao';
    crwCategoriaGeracao.Properties.Caption := 'Geração';
    crwCategoriaGeracao.Properties.HeaderAlignmentHorz := taCenter;
    crwCategoriaGeracao.Options.TabStop := False;
  End;
End;

Function TInterfaceRelatorio.fCriaCategoriaFixos(strGrupo: String): TcxCategoryRow;
Var
  crwCategoriaFixos: TcxCategoryRow;
Begin
  Result := Nil;

  If Trim(strGrupo).IsEmpty Then
    Exit;

  crwCategoriaFixos := fRetCategoriaCaption(strGrupo);

  If Not Assigned(crwCategoriaFixos) Then
  Begin
    crwCategoriaFixos := TcxCategoryRow(FFiltros.Add(TcxCategoryRow));
    crwCategoriaFixos.Name               := 'C' + AnsiReplaceStr(fTiraCaracEspeciaisPonto(strGrupo), ' ', '');
    crwCategoriaFixos.Properties.Caption := strGrupo;
    crwCategoriaFixos.Properties.HeaderAlignmentHorz := taCenter;
    crwCategoriaFixos.Options.TabStop := False;
  End;

  Result := crwCategoriaFixos;
End;

Procedure TInterfaceRelatorio.pInicializaIndexTabelasDinamicas;
  Var
    intContador: Integer;
Begin
  For intContador := 1 To MAX_TABELAS_DINAMICAS Do
  Begin
    FIndexInventario[intContador] := -1;
    FIndexEstExt[intContador] := -1;
    FIndexSalInv[intContador] := -1;
    FIndexLote[intContador] := -1;
  End;
End;

Function TInterfaceRelatorio.fPedeImagemCabecalho: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := Low(FCadRel) To High(FCadRel) Do
    If Assigned(FCadRel[intContador]) And SameText(FCadRel[intContador].FieldByName('REL_PEDIMA').AsString, 'S') Then
    Begin
      Result := True;
      Exit;
    End;
End;

Function TInterfaceRelatorio.fMontaFiltros: Boolean;
  Var
    intQueries,
    intContador: Integer;
Begin
  if (not Assigned(FFiltros)) then
    Exit(False);

  pSetaFiltroGrupoParametro('0');

  pInicializaIndexTabelasDinamicas;

  FIndexCTR_ := -1;
  FIndexPaginaInicial := -1;
  FIndexDestino := -1;
  FIndexPasta := -1;
  FIndexImagemCabecalho := -1;
  FIndexParCusto := -1;

  With FFiltros Do
  Begin
    pLimpaTelaFiltros;

    FFiltros.ClearRows;

    SetLength(FArrExpVis, 0);
    SetLength(FArrSQLVis, 0);
    SetLength(FArrEmpCfg, 0);

    pLiberaSelectCheckList;

    FParams.indexfieldnames := 'PAR_ORDENA';

    For intQueries := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
      pSetaDataType(FQueryFiltros[intQueries]);

    For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
      pSetaDataType(FComFilFiltros[intQueries]);

    pIncluiFiltroGrid;

    If FTemComposicaoCusto Then
      pIncluiComboComposicaoCusto;

    For intContador := Low(FTemTabelaI_) To High(FTemTabelaI_) Do
      If FTemTabelaI_[intContador] Then
        pIncluiComboInventario(intContador);

    For intContador := Low(FTemEstExt_) To High(FTemEstExt_) Do
    If FTemEstExt_[intContador] Then
      pIncluiComboEstExt(intContador);

    For intContador := Low(FTemEstEnt_) To High(FTemEstEnt_) Do
    If FTemEstEnt_[intContador] Then
      pIncluiComboEstEnt(intContador);

    For intContador := Low(FTemEstEnv_) To High(FTemEstEnv_) Do
    If FTemEstEnv_[intContador] Then
      pIncluiComboEstEnv(intContador);

    For intContador := Low(FTemTabelaSALINV) To High(FTemTabelaSALINV) Do
    If FTemTabelaSALINV[intContador] Then
      pIncluiComboSALINV(intContador);

    If FTemInventFinanc Then
      pIncluiComboCTR_;

    For intContador := Low(FTemTabelaL_) To High(FTemTabelaL_) Do
    If FTemTabelaL_[intContador] Then
      pIncluiComboLote(intContador);

    pIncluiPaginaInicial;

    If Assigned(FCadRel[0]) And SameText(Trim(FCadRel[0].FieldByName('REL_DESTIN').AsString), 'TXT') Then
      pCriaCategoriaGeracao
    Else
      crwCategoriaGeracao := Nil;

    pIncluiComboDestinoRelatorio;

    FIndexPasta := -1;

    If Assigned(FCadRel[0]) And SameText(FCadRel[0].FieldByName('REL_PASSAI').AsString, 'S') Then
      pIncluiPastaGravacao;

    FIndexImagemCabecalho := -1;

    If fPedeImagemCabecalho Then
      pIncluiImagemCabecalho;

    Parent.ClientHeight := Rows.Count * (FFiltros.OptionsView.RowHeight + 2) + 29 + 16 { - (Rows.Count Div 3)};
  End; { With FFiltros Do}

  pRestauraFiltroGrupoParametro;

  Result := True;
End;

Function TInterfaceRelatorio.fMontaFiltrosExecucao: Boolean;
  Var
    intQueries: Integer;
Begin
  SetLength(FArrExpVis, 0);
  SetLength(FArrSQLVis, 0);
  SetLength(FArrEmpCfg, 0);

  FParams.indexfieldnames := 'PAR_ORDENA';

  For intQueries := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
    pSetaDataType(FQueryFiltros[intQueries]);

  For intQueries := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
    pSetaDataType(FComFilFiltros[intQueries]);

  Result := True;
End;

Procedure TInterfaceRelatorio.pSetaParametrosReadOnly;
  Var
    intContador: Integer;
    blnAchou: Boolean;
Begin
  If Assigned(FFiltros) And Assigned(arrParametrosReadOnly) Then
    For intContador := Low(arrParametrosReadOnly) To High(arrParametrosReadOnly) Do
     If Assigned(FFiltros.RowByName(arrParametrosReadOnly[intContador])) Then
     With TcxEditorRow(FFiltros.RowByName(arrParametrosReadOnly[intContador])), Properties Do
       If Not fEmptyStr(fGetValorParametro(arrParametrosReadOnly[intContador], blnAchou)) Then
       Begin
         Options.Editing := False;

         If Assigned(frmPedeDados) Then
           TcxEditorRow(FFiltros.RowByName(arrParametrosReadOnly[intContador])).Styles.Content := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleTitulo;
       End;
End;

Procedure TInterfaceRelatorio.pSetaParametrosInvisiveis;
  Var
    intContador: Integer;
Begin
  If Not Assigned(FFiltros) Then
    Exit;

  If Not Assigned(objRelatorioRetorno) Then
    Exit;

  If Not Assigned(objRelatorioRetorno.arrParametrosInvisiveis) Then
    Exit;

  For intContador := Low(objRelatorioRetorno.arrParametrosInvisiveis) To High(objRelatorioRetorno.arrParametrosInvisiveis) Do
   If Assigned(FFiltros.RowByName(objRelatorioRetorno.arrParametrosInvisiveis[intContador])) Then
     FFiltros.RowByName(objRelatorioRetorno.arrParametrosInvisiveis[intContador]).Visible := False;
End;

Function TInterfaceRelatorio.fRetornaDataGatilho(strGatilho: String; Var strDatGat: String; blnInicial: Boolean): Boolean;
  Var
    qryData: TUniQuery;
Begin
  Result := False;
  strDatGat := '';

  Try
    If Not cdsGatPer.FindKey([strGatilho]) Then
      Exit;

    qryData := fCriaQuery;

    If blnInicial Then
      qryData.SQL.Text := cdsGatPer.FieldByName('GPE_DTAINI').AsString
    Else
      qryData.SQL.Text := cdsGatPer.FieldByName('GPE_DTAFIN').AsString;

    qryData.Open;

    Result := qryData.Fields[0].DataType = ftDate;

    If Result Then
      strDatGat := FormatDateTime('DD/MM/YYYY', qryData.Fields[0].AsDateTime);

    FreeAndNil(qryData);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fRetornaDataGatilho');
    End;
  End;
End;

Procedure TInterfaceRelatorio.pHabilitaDatasGatilho(strNomPar, strValPar: String);
  Var
    cxData: TcxEditorRow;
    strDatGat: String;
Begin
  If cdsParametrosGatilho.Locate('PAR_NOMPAR', strNomPar, []) Then
  Begin
    cxData := TcxEditorRow(FFiltros.RowByName(cdsParametrosGatilho.FieldByName('PARINI').AsString));
    If Assigned(cxData) Then
    Begin
      cxData.Properties.Options.Editing := SameText(strValPar, STR_INFORMAR_PERIODO);

      If cxData.Properties.Options.Editing Then
      Begin
        cxData.Styles.Content := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleContent
      End Else
      Begin
        cxData.Styles.Content := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleReadOnly;

        If fRetornaDataGatilho(strValPar, strDatGat, True) Then
          cxData.Properties.Value := strDatGat;
      End;

    End;

    cxData := TcxEditorRow(FFiltros.RowByName(cdsParametrosGatilho.FieldByName('PAR_PARFIN').AsString));
    If Assigned(cxData) Then
    Begin
      cxData.Properties.Options.Editing := SameText(strValPar, STR_INFORMAR_PERIODO);

      If cxData.Properties.Options.Editing Then
      Begin
        cxData.Styles.Content := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleContent
      End Else
      Begin
        cxData.Styles.Content := TfrmPedeDadosRelatorio(frmPedeDados).cxStyleReadOnly;

        If fRetornaDataGatilho(strValPar, strDatGat, False) Then
          cxData.Properties.Value := strDatGat;
      End;
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAjustaIndice(Var FIndex: TIndexTabelaDinamica; strNomeRow: String; intIndex: Integer);
  Var
    intTabela: Integer;
Begin
  intTabela := fNomeToIndexTabelaDinamica(strNomeRow);
  If intTabela In [1..MAX_TABELAS_DINAMICAS] Then
    FIndex[intTabela] := intIndex;
End;

Procedure TInterfaceRelatorio.pAjustaIndicesCombo;
  Var
    intContador: Integer;
Begin
  For intContador := 0 To FFiltros.Rows.Count -1 Do
    If SameText('DESTINO_REL', FFiltros.Rows[intContador].Name) Then
      FIndexDestino := FFiltros.Rows[intContador].AbsoluteIndex

    Else If SameText(STR_PRECUS, FFiltros.Rows[intContador].Name) Then
      FIndexParCusto := FFiltros.Rows[intContador].AbsoluteIndex

    Else If SameText('CTR_', FFiltros.Rows[intContador].Name) Then
      FIndexCTR_ := FFiltros.Rows[intContador].AbsoluteIndex

    Else If SameText(STR_PAGINA_INICIAL, FFiltros.Rows[intContador].Name) Then
      FIndexPaginaInicial := FFiltros.Rows[intContador].AbsoluteIndex

    Else If SameText('PASTA_REL', FFiltros.Rows[intContador].Name) Then
      FIndexPasta := FFiltros.Rows[intContador].AbsoluteIndex

    Else If SameText('IMAGEM_CABECALHO', FFiltros.Rows[intContador].Name) Then
      FIndexImagemCabecalho := FFiltros.Rows[intContador].AbsoluteIndex

    Else If AnsiStartsStr('INVENTARIO', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexInventario, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)

    Else If AnsiStartsStr('ESTOQUE_EXTERNO', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexEstExt, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)

    Else If AnsiStartsStr('SALINV', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexSalInv, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)

    Else If AnsiStartsStr('LOTES', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexLote, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)

    Else If AnsiStartsStr('ENVIADO_TERCEIROS', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexEstEnv, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)

    Else If AnsiStartsStr('RECEBIDO_TERCEIROS', FFiltros.Rows[intContador].Name) Then
      pAjustaIndice(FIndexEstEnt, FFiltros.Rows[intContador].Name, FFiltros.Rows[intContador].AbsoluteIndex)
End;

Procedure TInterfaceRelatorio.pIncluiPaginaInicial;
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin

  With FFiltros Do
  If Assigned(FCadRel[0]) And SameText(FCadRel[0].FieldByName('REL_PAGINI').AsString, 'S') And SameText(FCadRel[0].FieldByName('REL_PGRCPE').AsString, 'N') Then
  Begin
    strNomPar := STR_PAGINA_INICIAL;

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUPAG').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexPaginaInicial := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;
    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Página inicial ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxCurrencyEditProperties;
    TcxCurrencyEditProperties(TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditProperties).DecimalPlaces := 0;
    TcxCurrencyEditProperties(TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditProperties).DisplayFormat := '';
    TcxCurrencyEditProperties(TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditProperties).OnValidate := pFiltrosValidate;
  End;

End;

Procedure TInterfaceRelatorio.pSetaParDirectory(intIndice: Integer);
Begin
  With FFiltros, TcxEditorRow(Rows[intIndice]), Properties Do
  Begin
    EditPropertiesClass := TcxButtonEditProperties;
    With TcxButtonEditProperties(EditProperties) Do
    Begin
      OnButtonClick := pButtonClickDirectory;
      Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
    End;
  End;
End;

procedure TInterfaceRelatorio.pButtonClickDirectory(Sender: TObject; AButtonIndex: Integer);
  Var
    strLocalDir: String;
begin
  If TcxEditorRow(FFiltros.FocusedRow).Properties.Value <> Null Then
    strLocalDir := TcxEditorRow(FFiltros.FocusedRow).Properties.Value
  Else
    strLocalDir := '';

  If SelectDirectory('', '', strLocalDir, [sdNewUI, sdShowEdit], nil) Then
  Begin
    TcxButtonEdit(Sender).Text := strLocalDir;
    TcxEditorRow(FFiltros.FocusedRow).Properties.Value := strLocalDir;
    TcxButtonEdit(Sender).PostEditValue;
  End;
end;

Procedure TInterfaceRelatorio.pIncluiPastaGravacao;
  Var
    erwEditor: TcxEditorRow;
Begin
  With FFiltros Do
  Begin
    If Assigned(crwCategoriaGeracao) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaGeracao, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexPasta := erwEditor.AbsoluteIndex;

    erwEditor.Name := 'PASTA_REL';
    erwEditor.Visible := True;

    Case fRetDestino Of
      desTXT: erwEditor.Properties.Caption := '* Pasta de saída (TXT) ';
      desArquivoSaida: erwEditor.Properties.Caption := '* Pasta de saída (Arquivo Saída) ';
      desXML: erwEditor.Properties.Caption := '* Pasta de saída (XML) ';
      Else    erwEditor.Properties.Caption := 'Pasta de saída (PDF/CSV/TXT) ';
    End;

    pSetaParDirectory(erwEditor.AbsoluteIndex);
  End;
End;

Procedure TInterfaceRelatorio.pIncluiImagemCabecalho;
  Var
    erwEditor: TcxEditorRow;
Begin
  With FFiltros Do
  Begin
    If Assigned(crwCategoriaGeracao) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaGeracao, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexImagemCabecalho := erwEditor.AbsoluteIndex;

    erwEditor.Name := 'IMAGEM_CABECALHO';
    erwEditor.Visible := True;

    erwEditor.Properties.Caption := 'Imagem de cabeçalho';
  End;
End;

Procedure TInterfaceRelatorio.pIncluiComboDestinoRelatorio;
Var
  crwCategoriaFixos: TcxCategoryRow;
  desIndice: TDestinoRel;
  erwEditor: TcxEditorRow;
  stlLista : TStringList;
  intContador: Integer;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    strNomPar := 'DESTINO_REL';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUDES').AsString;

    If Not fEmptyStr(strGruFil) Then
    Begin
      crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

      If Assigned(crwCategoriaFixos) Then
        erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
      Else
        erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));
    End
    Else
    Begin
      If Assigned(crwCategoriaGeracao) Then
        erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaGeracao, TcxEditorRow))
      Else
        erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));
    End;

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexDestino := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;
    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Destino' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items Do
    Begin

      If Assigned(FCadRel[0]) Then
      Begin

        If fEmptyStr(FCadRel[0].FieldByName('REL_DESTIN').AsString) Then
        Begin

          For desIndice := Low(ArrDestino) To High(ArrDestino) Do
            If (desIndice <> desEmail) And (desIndice <> desGrid) Then
             Add(String(ArrDestino[desIndice]));

        End Else
        Begin

          stlLista      := TStringList.Create;
          stlLista.Text := Trim(FCadRel[0].FieldByName('REL_DESTIN').AsString);

          For desIndice := Low(ArrDestino) To High(ArrDestino) Do
            For intContador := 0 To stlLista.Count - 1 Do
              If SameText(String(ArrDestino[desIndice]), stlLista[intContador]) Then
                Add(String(ArrDestino[desIndice]));

          FreeAndNil(stlLista);

        End;

        If (Not blnExecutandoPeloMenu) Or
           (strLoginUsuarioLogado = '997') Or
           (strLoginUsuarioLogado = '998') Or
           (strLoginUsuarioLogado = '999') Then
        Begin
          Add('Trace');
          Add('DesignReport');
        End;
      End;

    End;
    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
      OnCloseUp := pComboChange;
    End;

    If (TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count = 1) And
       (objGeraFr3.fTemDestinoGrafico Or
       (fDestinoToTipo(FCadRel[0].FieldByName('REL_DESTIN').AsString) In SET_GRAFICO)) Then
    Begin
      Rows.Items[erwEditor.AbsoluteIndex].Visible := False;
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value := ArrDestino[fDestinoToTipo(FCadRel[0].FieldByName('REL_DESTIN').AsString)];
    End Else
    Begin
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value := ArrDestino[desVideo];
    End;

  End;
End;

procedure TInterfaceRelatorio.pCarregaComposicaoCusto(Var strDescricao, strValorPadrao: String);
  Var
    qryGen  : TUniQuery;
    stlLista: TStringList;
begin
  Try
    qryGen   := fCriaQuery(Nil);
    stlLista := TStringList.Create;
    strValorPadrao := '';

    With qryGen Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM COMCUS ');
      SQL.Add('ORDER BY AUTOINCREM, COM_DESCRI, COM_COMPOS ');
      Open;

      If Not IsEmpty Then
      Begin
        First;

        strValorPadrao := FieldByName('COM_DESCRI').AsString;

        while Not EOF Do
        Begin
          stlLista.Add(FieldByName('COM_DESCRI').AsString);

          If (FieldByName('COM_SUGERI').AsString = 'S') Then
            strValorPadrao := FieldByName('COM_DESCRI').AsString;

          Next;
        End;
      End;

    End;

  Except
    On E : Exception Do
      pMensagensErro(E.Message,'[pCarregaComposicaoCusto]');
  End;

  strDescricao := stlLista.Text;

  FreeAndNil(qryGen);
  FreeAndNil(stlLista);
end;

Procedure TInterfaceRelatorio.pIncluiComboComposicaoCusto;
Var
  crwCategoriaFixos: TcxCategoryRow;
  strDescricao,
  strValorPadrao: String;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    strNomPar := STR_PRECUS;

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUFIX').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexParCusto := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;
    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If FCampos.Locate('CAM_NOMCAM', STR_PRECUS, []) Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := fTrataDesCam(FCampos.FieldByName('CAM_DESCAM').AsString) + ' '
    Else
    Begin
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Composição do Preço de Custo' + ' ';

      If Not strDesPar.IsEmpty Then
        TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';
    End;

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

    pCarregaComposicaoCusto(strDescricao, strValorPadrao);

    TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := strDescricao;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
    End;

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value := strValorPadrao;
  End;
End;

Class Function TInterfaceRelatorio.fRetDescricaoParametros: String;
  Var
    stlLista: TStringList;
    facContador: TTipoInterface;
Begin
  stlLista := TStringList.Create;

  For facContador := Low(ArrDesParametro) To High(ArrDesParametro) Do
    stlLista.Add(String(ArrDesParametro[facContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TInterfaceRelatorio.fRetDescricaoInterface: String;
  Var
    stlLista: TStringList;
    facContador: TTipoInterface;
Begin
  stlLista := TStringList.Create;

  For facContador := Low(ArrDesInterface) To High(ArrDesInterface) Do
    stlLista.Add(String(ArrDesInterface[facContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TInterfaceRelatorio.fRetDescricaoConfig: String;
  Var
    stlLista: TStringList;
    cfgContador: TTipoConfig;
Begin
  stlLista := TStringList.Create;

  For cfgContador := Low(ArrDesConfig) To High(ArrDesConfig) Do
    stlLista.Add(String(ArrDesConfig[cfgContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TInterfaceRelatorio.fRetDescricaoMascara: String;
  Var
    stlLista: TStringList;
    masContador: TMascara;
Begin
  stlLista := TStringList.Create;

  For masContador := Low(ArrDesMascara) To High(ArrDesMascara) Do
    stlLista.Add(String(ArrDesMascara[masContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TInterfaceRelatorio.fRetDescricaoFuncoes: String;
  Var
    stlLista: TStringList;
    funContador: TFuncaoAutcom;
Begin
  stlLista := TStringList.Create;

  For funContador := Low(ArrDesFuncao) To High(ArrDesFuncao) Do
    stlLista.Add(String(ArrDesFuncao[funContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Class Function TInterfaceRelatorio.fRetDescricaoTotalizadores: String;
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  stlLista := TStringList.Create;

  For intContador := Low(ArrDesTotal) To High(ArrDesTotal) Do
    stlLista.Add(String(ArrDesTotal[intContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Function TInterfaceRelatorio.fTemMultiSelecao(strNomPar: String): Boolean;
Begin
  With FValueParams Do
  Result := Active And Locate('NOMPAR', strNomPar, []) And (Not FieldByName('VALPAR').IsNull);
End;

Function TInterfaceRelatorio.fTemMultiSelecaoDisplayText(strNomPar: String): Boolean;
Begin
  With FValueParamsDisplayText Do
  Result := Active And Locate('NOMPAR', strNomPar, []) And (Not FieldByName('VALPAR').IsNull);
End;

Function TInterfaceRelatorio.fRetDado(rowDado: TcxEditorRow; blnMesmoInvisivel: Boolean = False): String;
Begin
  If (rowDado.Properties.Value <> Null) And (rowDado.Visible Or blnMesmoInvisivel) Then
  Begin
    If Not SameText(rowDado.Name, FParams.FieldByName('PAR_NOMPAR').AsString) Then
      If Not FParams.Locate('PAR_NOMPAR', rowDado.Name, []) Then
        pMensagemOK('Erro interno - Parâmetro não encontrado!');

    Case fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) Of
      facComboBox,
      facComboBoxVerdeVermelho : Result := fGetValorCombo(rowDado.Properties.Value);

      facTabelaPrecoLista,
      facCustomCheckList : Result := rowDado.Properties.DisplayTexts[0];

      Else                 Result := IfThen(fEmptyStr(rowDado.Properties.Value), rowDado.Properties.DisplayTexts[0], rowDado.Properties.Value);
    End;

  End Else
  Begin
    Result := '';
  End;
End;

Function TInterfaceRelatorio.fBuscaNomeCampo(strSQL, strNomPar: String): String;
  Var
    intPos,
    intContador: Integer;
    blnInicioCampo: Boolean;
Begin
  intPos := Pos(':' + strNomPar, strSQL);

  Result := '';

  blnInicioCampo := False;

  For intContador := Pred(intPos) DownTo 1 Do
  Begin
    If Not (CharInSet(strSQL[intContador], [' ', '<', '>', '='])) Then
      blnInicioCampo := True;

    If blnInicioCampo And (CharInSet(strSQL[intContador], [' ', '[', #10, #13])) Then
      Break;

    If blnInicioCampo Then
      Result := strSQL[intContador] + Result;
  End;

  Result := Trim(Result);
End;

Function TInterfaceRelatorio.fSubstituiLinhaGrupo(strSQL, strNomPar, strSQLLinha: String): String;
  Var
    intPos, intInicio, intContador, intTamanhoTexto: Integer;
    blnInicioCampo: Boolean;
    strTexto: String;
Begin
  intPos := Pos(':' + strNomPar, strSQL);

  intInicio := intPos - 1;

  blnInicioCampo := False;

  For intContador := Pred(intPos) DownTo 1 Do
  Begin
    If blnInicioCampo And (CharInSet(strSQL[intContador], [' ', '[', #10, #13])) Then
      Break;

    Dec(intInicio);

    If Not (CharInSet(strSQL[intContador], [' ', '<', '>', '='])) Then
      blnInicioCampo := True;
  End;

  If (intPos > 0) And (intInicio > 0) Then
  Begin
    intTamanhoTexto := ((intPos + Length(':' + strNomPar)) - intInicio);

    strTexto := Copy(strSQL, intInicio, intTamanhoTexto);

    If Pos('<>', strTexto) > 0 Then
      strSQLLinha := ' (NOT (' + strSQLLinha + ')) ';

    Delete(strSQL, intInicio, intTamanhoTexto);
    Insert(strSQLLinha, strSQL, intInicio);
    Result := strSQL;
  End;

End;

Function TInterfaceRelatorio.fSubstituiPlanoContabilNovo(strSQL, strNomPar, strSQLPlanoContabilNovo: String): String;
  Var
    intPos, intInicio, intContador, intTamanhoTexto: Integer;
    blnInicioCampo: Boolean;
    strTexto: String;
Begin
  intPos := Pos(':' + strNomPar, strSQL);

  intInicio := intPos - 1;

  blnInicioCampo := False;

  For intContador := Pred(intPos) DownTo 1 Do
  Begin
    If blnInicioCampo And (CharInSet(strSQL[intContador], [' ', '[', #10, #13])) Then
      Break;

    Dec(intInicio);

    If Not (CharInSet(strSQL[intContador], [' ', '<', '>', '='])) Then
      blnInicioCampo := True;
  End;

  If (intPos > 0) And (intInicio > 0) Then
  Begin
    intTamanhoTexto := ((intPos + Length(':' + strNomPar)) - intInicio);

    strTexto := Copy(strSQL, intInicio, intTamanhoTexto);

    If Pos('<>', strTexto) > 0 Then
      strSQLPlanoContabilNovo := ' (NOT (' + strSQLPlanoContabilNovo + ')) ';

    Delete(strSQL, intInicio, intTamanhoTexto);
    Insert(strSQLPlanoContabilNovo, strSQL, intInicio);
    Result := strSQL;
  End;

End;

Function TInterfaceRelatorio.fSubstituiPlanoContas(strSQL, strNomPar, strSQLPlano: String): String;
  Var
    intPos, intInicio, intContador, intTamanhoTexto: Integer;
    blnInicioCampo: Boolean;
    strTexto: String;
Begin
  intPos := Pos(':' + strNomPar, strSQL);

  intInicio := intPos - 1;

  blnInicioCampo := False;

  For intContador := Pred(intPos) DownTo 1 Do
  Begin
    If blnInicioCampo And (CharInSet(strSQL[intContador], [' ', '[', #10, #13])) Then
      Break;

    Dec(intInicio);

    If Not (CharInSet(strSQL[intContador], [' ', '<', '>', '='])) Then
      blnInicioCampo := True;
  End;

  If (intPos > 0) And (intInicio > 0) Then
  Begin
    intTamanhoTexto := ((intPos + Length(':' + strNomPar)) - intInicio);

    strTexto := Copy(strSQL, intInicio, intTamanhoTexto);

    If Pos('<>', strTexto) > 0 Then
      strSQLPlano := ' (NOT (' + strSQLPlano + ')) ';

    Delete(strSQL, intInicio, intTamanhoTexto);
    Insert(strSQLPlano, strSQL, intInicio);
    Result := strSQL;
  End;

End;

Function TInterfaceRelatorio.fRetRowDado(strNomPar: String): TcxEditorRow;
  Var
    intIndice: Integer;
Begin
  Result := Nil;

  If Assigned(FFiltros) Then
  With FFiltros Do
  For intIndice := 0 To Rows.Count - 1 Do
    If SameText(strNomPar, FFiltros.Rows[intIndice].Name) Then
    Begin
      Result := TcxEditorRow(FFiltros.Rows[intIndice]);
      Exit;
    End;
End;

Function TInterfaceRelatorio.fRetValParSimples(strValPar: String): String;
Begin
  Result := Trim(strValPar.Substring(Pos('(', strValPar)));
  Result := Copy(Result, 1, Length(Result) - 1);
End;

Function TInterfaceRelatorio.fGetValorParametroRotinasGrid(strNomPar: String;
                                                           Var blnAchou: Boolean;
                                                           Var blnMultiSelecao: Boolean;
                                                           blnTiraMascara: Boolean = True;
                                                           blnMesmoInvisivel: Boolean = False): String;
Begin
  blnMultiSelecao := fTemMultiSelecao(strNomPar);

  If blnMultiSelecao Then
  Begin
    Result := fRetValParSimples(FValueParams.FieldByName('VALPAR').AsString);
    blnAchou := True;
  End Else
    Result := fGetValorParametro(strNomPar, blnAchou, blnTiraMascara, blnMesmoInvisivel);
End;

Function TInterfaceRelatorio.fGetValorParametro(strNomPar: String;
                                                Var blnAchou: Boolean;
                                                blnTiraMascara: Boolean = True;
                                                blnMesmoInvisivel: Boolean = False): String;
  Var
    rowDado: TcxEditorRow;
Begin
  Result := '';

  rowDado := fRetRowDado(strNomPar);

  blnAchou := Assigned(rowDado);

  If Assigned(rowDado) And (rowDado.Visible Or blnMesmoInvisivel) Then
  Begin

    If blnTiraMascara Then
      Result := fTiraCaracEspeciaisPonto(fRetDado(rowDado, blnMesmoInvisivel))
    Else
      Result := fRetDado(rowDado, blnMesmoInvisivel);

  End;
End;

Function TInterfaceRelatorio.fAjustaCases(strSQL: String; intQuerie: Integer): String;
  Var
    sqlParser: TSQLParser;
    intToken,
    intInicioCase,
    intFimCase: Integer;
    strNomPar,
    strToken,
    strSQLWhere: String;
    blnSubstituiu,
    blnParam: Boolean;

    Function fGetNextToken(blnPulaBranco: Boolean = True): String;
    Begin
      Result := '';

      While sqlParser.CurrPos <= Length(strSQL) Do
      Begin
        intToken := sqlParser.GetNextToken;

        If intToken <> 0 Then
        Begin
          Result := sqlParser.Lexem;


          If (Not blnPulaBranco) Or
             ((Not fEmptyStr(Result)) And
              (Result <> #10) And
              (Result <> #13) And
              (Result <> #13#10)) Then
            Break;
        End

        Else Break;
      End;
    End;

    Function fProximoSoParametro(var blnParam: Boolean): Boolean;
    Begin
      Result := False;

      strNomPar := '';
      strToken  := fGetNextToken;

      // Fiz todos os tratamentos para funcionar @VARIAVEL aqui também, o problema é que nem sempre
      // as variáveis são setadas com SELECT, e na primeira execução ficam sem valor trazendo o CASE inteiro
      // Quando é executado pela segunda vez, elas já tem valor, mas referente à última visualização do relatório

      If SameText(strToken, ':') { Or SameText(strToken, '@')} Then
      Begin
        blnParam := IIF(SameText(strToken, ':'), True, False);
        strToken := fGetNextToken;

        If Not fEmptyStr(strToken) Then
        Begin
          strNomPar := strToken;

          strToken := fGetNextToken;

          Result := SameText(strToken, 'WHEN');
        End;

      End;

    End;

    Function fTrataString(var strValor: String): String;
    Begin
      strValor := AnsiReplaceStr(strValor, '''', '');
      strValor := IIF((Copy(strValor, 1, 1) = '"') and (Copy(strValor, Length(strValor), 1) = '"'), Copy(strValor, 2, Length(strValor) - 2), strValor);
      Result := strValor;
    End;

    Function fPegaValor(blnParam: Boolean): String;
      Var
        strDado,
        strValPar: String;
        blnAchou: Boolean;
        strSQLRelatorio: string;
        strSetSQL: string;
    Begin
      Result := '';

      strDado := fGetNextToken;

      If AnsiStartsStr('"', strDado) And AnsiEndsStr('"', strDado) Then
        strDado := Copy(strDado, 2, Length(strDado) - 2)

      Else If AnsiStartsStr('''', strDado) And AnsiEndsStr('''', strDado) Then
        strDado := Copy(strDado, 2, Length(strDado) - 2);

      if blnParam then
        strValPar := fGetValorParametro(strNomPar, blnAchou)
      else
      begin
        strSQLRelatorio := strSQL;
        strSQLRelatorio := fExecutaSets(Nil, strSetSQL, strSQLRelatorio, intQuerie, '@' + strNomPar);
        strValPar := fRetornaValorVar(strNomPar, False);
      end;

      While (sqlParser.CurrPos <= Length(strSQL)) And (fTrataString(strValPar) <> fTrataString(strDado)) Do
      Begin

        intToken := sqlParser.GetNextToken;

        If intToken <> 0 Then
        Begin
          strToken := sqlParser.Lexem;

          If SameText(UpperCase(strToken), 'CASE') Then
          Begin
            Result := '';
            Exit;
          End;

          If SameText(strToken, 'END') Then
            Break;

          If SameText(strToken, 'WHEN') Then
            strDado := fGetNextToken;

        End

        Else Break;

      End;

      If strValPar = strDado Then
      Begin
        strToken := fGetNextToken; // THEN DO SQL

        While (sqlParser.CurrPos <= Length(strSQL)) Do
        Begin

          strToken := fGetNextToken(False);

          If SameText(UpperCase(strToken), 'CASE') Then
          Begin
            Result := '';
            Exit;
          End;

          If SameText(strToken, 'END') Or SameText(strToken, 'WHEN') Or SameText(strToken, 'ELSE') Then
            Break;

          Result := Result + strToken
        End;

        While (sqlParser.CurrPos <= Length(strSQL)) Do
        Begin
          If SameText(strToken, 'END') Then
            Break;

          strToken := fGetNextToken(False);

          If SameText(UpperCase(strToken), 'CASE') Then
          Begin
            Result := '';
            Exit;
          End;

        End;

        intFimCase := sqlParser.CurrPos;

      End;

    End;

Begin
  blnSubstituiu := True;

  While blnSubstituiu Do
  Begin
    blnSubstituiu := False;

    sqlParser := TMyParser.Create(strSQL);

    sqlParser.OmitBlank    := False;
    sqlParser.OmitComment  := True;
    sqlParser.QuotedString := True;
    sqlParser.DecSeparator := '.';
    sqlParser.ToBegin;

    strSQLWhere := '';

    While sqlParser.CurrPos <= Length(strSQL) Do
    Begin
    //  intInicioCase := sqlParser.CurrPos;

      intToken := sqlParser.GetNextToken;

      If intToken <> 0 Then
      Begin
        strToken := sqlParser.Lexem;

        If SameText(strToken, 'CASE') Then
        Begin
          intInicioCase := sqlParser.CurrPos - Length('CASE') + 1;

          blnParam := True;
          If fProximoSoParametro(blnParam) Then
          Begin
            strSQLWhere := fPegaValor(blnParam);

            If Not fEmptyStr(strSQLWhere) Then
            Begin
              Delete(strSQL, intInicioCase, intFimCase - intInicioCase + 1);
              Insert(' ' + Trim(strSQLWhere) + ' ', strSQL, intInicioCase);

              blnSubstituiu := True;
              Break;
            End;

          End;

        End;

      End

      Else Break;

    End;

    FreeAndNil(sqlParser);

  End; {While blnSubstituiu Do}

  Result := strSQL;
End;

Function TInterfaceRelatorio.fMontaSQLDados(strSQL: String; qryDados: TUniQuery; intQuerie: Integer = 0): String;
  Var
    intIndice: Integer;
    rowDado: TcxEditorRow;
    strDado: String;
    blnMulSel,
    blnRetiraClasulas: Boolean;
    pesPesquisa: TPesquisas;
    arrLinha: TConsultasArray;
    arrPlanoContabilNovo: TConsultasArray;
    arrPlano: TConsultasArray;
    strNomeCampo,
    strSQLLinha: String;
    strSQLPlanoContabilNovo: String;
    strSQLPlano: String;

    Function fGetDado: String;
    Begin
      If FExecutaPelaInterface Then
      Begin
        If Assigned(rowDado) Then
          Result := fRetDado(rowDado)
        Else
          Result := '';
      End Else
      Begin
        Result := FParams.FieldByName('VALOR').AsString;
      End;
   End;

Begin
  Result := AnsiReplaceStr(strSQL, #9, ' ');

  Result := fTrataConstantes(Result);
  Result := fTrataTemplates(Result);
  Result := fTrataInstrucoes(Result);

  Result := fAjustaCases(Result, intQuerie);

  With qrydados Do
  Begin

    For intIndice := 0 To Params.Count - 1 Do
    Begin

      If FExecutaPelaInterface Then
      Begin
        rowDado := fRetRowDado(Params[intIndice].Name);

        If Not Assigned(rowDado) Then
        Begin

          If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And
             (FParams.FieldByName('PARVIS').AsInteger = 0) Then
          Begin

            strDado := '';

          End Else
          Begin

            Result := '';
            pMensagemOk('Erro interno. Valor do parâmetro ' + Params[intIndice].Name + ' não encontrado!');
            Exit;

          End;

        End;

      End;

      If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) Then
        pesPesquisa := TConsultasRel.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString)
      Else
        pesPesquisa := pesSemPesquisa;

      If pesPesquisa = pesLinhaGrupo Then
      Begin

        strDado := fTiraCaracEspeciaisPonto(fGetDado);

        blnMulSel := fTemMultiSelecao(Params[intIndice].Name);

        blnRetiraClasulas := (Not blnMulSel) And fEmptyStr(strDado);

        If blnRetiraClasulas Then
        Begin

          Result := fRetiraClausula(Result, Params[intIndice].Name)

        End Else
        Begin

          While True Do
          Begin
            strNomeCampo := fBuscaNomeCampo(Result, Params[intIndice].Name);

            If Not fEmptyStr(strNomeCampo) Then
            Begin

              If blnMulSel Then
              Begin
                TConsultasRel.pValParToArrSel(FValueParams.FieldByName('VALPAR').AsString, arrLinha);
              End Else
              Begin
                SetLength(arrLinha, 1);
                arrLinha[0].strCodigo := strDado;
              End;

              strSQLLinha := TConsultasRel.fSQLLinhaGrupo(strNomeCampo, Params[intIndice].Name, arrLinha);

              SetLength(arrLinha, 0);

              Result := fSubstituiLinhaGrupo(Result, Params[intIndice].Name, strSQLLinha);

            End

            Else Break;

          End;

        End;

      End

      Else If pesPesquisa = pesPlanoContabilNovo Then
      Begin

        If Assigned(rowDado) Then
          strDado := fTiraCaracEspeciaisPonto(fRetDado(rowDado))
        Else
          strDado := '';

        blnMulSel := fTemMultiSelecao(Params[intIndice].Name);

        blnRetiraClasulas := (Not blnMulSel) And fEmptyStr(strDado);

        If blnRetiraClasulas Then
        Begin

          Result := fRetiraClausula(Result, Params[intIndice].Name)

        End Else
        Begin

          While True Do
          Begin
            strNomeCampo := fBuscaNomeCampo(Result, Params[intIndice].Name);

            If Not fEmptyStr(strNomeCampo) Then
            Begin

              If blnMulSel Then
              Begin
                TConsultasRel.pValParToArrSel(FValueParams.FieldByName('VALPAR').AsString, arrPlanoContabilNovo);
              End Else
              Begin
                SetLength(arrPlanoContabilNovo, 1);
                arrPlanoContabilNovo[0].strCodigo := strDado;
              End;

              strSQLPlanoContabilNovo := TConsultasRel.fSQLPlanoContabilNovo(strNomeCampo, Params[intIndice].Name, arrPlanoContabilNovo);

              SetLength(arrPlanoContabilNovo, 0);

              Result := fSubstituiPlanoContabilNovo(Result, Params[intIndice].Name, strSQLPlanoContabilNovo);

            End

            Else Break;

          End;

        End;

      End

      Else If pesPesquisa = pesPlanoContas Then
      Begin

        strDado := fTiraCaracEspeciaisPonto(fGetDado);

        blnMulSel := fTemMultiSelecao(Params[intIndice].Name);

        blnRetiraClasulas := (Not blnMulSel) And fEmptyStr(strDado);

        If blnRetiraClasulas Then
        Begin

          Result := fRetiraClausula(Result, Params[intIndice].Name)

        End Else
        Begin

          While True Do
          Begin

            strNomeCampo := fBuscaNomeCampo(Result, Params[intIndice].Name);

            If Not fEmptyStr(strNomeCampo) Then
            Begin

              If blnMulSel Then
              Begin
                TConsultasRel.pValParToArrSel(FValueParams.FieldByName('VALPAR').AsString, arrPlano);
              End Else
              Begin
                SetLength(arrPlano, 1);
                arrPlano[0].strCodigo := strDado;
              End;

              strSQLPlano := TConsultasRel.fSQLPlanoContas(strNomeCampo, Params[intIndice].Name, arrPlano);

              SetLength(arrPlano, 0);

              Result := fSubstituiPlanoContas(Result, Params[intIndice].Name, strSQLPlano);
            End

            Else Break;

          End;

        End;

      End

      Else If fTemMultiSelecao(Params[intIndice].Name) Then
      begin

        Result := fPoeMultiSelecao(Result, Params[intIndice].Name, FValueParams.FieldByName('VALPAR').AsString);

      End Else
      Begin

        strDado := fGetDado;

        Case fGetTipoInterface(FParams.FieldByName('PAR_TIPPAR').AsString) Of
          facDiaMes,
          facMesAno: Begin
                       strDado := Trim(strDado);
                       If strDado = '/' Then
                         strDado := '';
                     End;
        End;

        blnRetiraClasulas := fEmptyStr(strDado);

        If blnRetiraClasulas Then
          Result := fRetiraClausula(Result, Params[intIndice].Name);
      End;

    End;

  End;

  For intIndice := 0 To FLimits.Count - 1 Do
  Begin

    If FExecutaPelaInterface Then
    Begin
      rowDado := fRetRowDado(FLimits[intIndice]);
      strDado := fRetDado(rowDado);

      blnRetiraClasulas := (Not rowDado.Visible) Or fEmptyStr(strDado);
    End Else
    Begin
      strDado := FParams.FieldByName('VALOR').AsString;

      blnRetiraClasulas := fEmptyStr(strDado);
    End;

    If blnRetiraClasulas Then
       Result := fRetiraClausula(Result, FLimits[intIndice]);
  End;

  Result := fRetiraFormatacaoSQLSetEmp(Result, intQuerie);
End;

Function TInterfaceRelatorio.fRetiraFormatacaoSQLSetEmp(strSQL: String; intQuerie: Integer = 0): String;
Begin
  Result := 'SET @VS_STRCODEMP = ' + QuotedStr(VS_strCodEmp) + '; ' + fRetiraFormatacaoSQL(strSQL, True, True, False, intQuerie {blnQueryFilstros});
End;

Function TInterfaceRelatorio.fPoeMultiSelecao(strSQL, strNomPar, strValPar: String; strNomCam: String = ''; intPosNomCam: Integer = 0): String;
  Var
    intIni,
    intFin,
    intPos,
    intContador,
    intContador2,
    intOffSet: Integer;

    strNot: String;
Begin
  intOffSet := 1;

  While Pos(':' + strNomPar, strSQL, intOffSet) > 0 Do
  Begin
    strNot := '';

    intPos := Pos(':' + strNomPar, strSQL, intOffSet);
    intIni := -1;

    intFin := intPos + Length(strNomPar);

    If Not fEmptyStr(strNomCam) Then
    Begin

      intIni := intPosNomCam;

    End Else
    Begin

      For intContador := intPos DownTo 1 Do
      Begin

        If CharInSet(strSQL[intContador], ['<', '>', '=']) Then
        Begin

          intContador2 := intContador;

          While (intContador2 > 1) And CharInSet(strSQL[intContador2], ['<', '>', '=']) Do
          Begin

            If (strSQL[intContador2] = '<') And (strSQL[intContador] = '>') Then
              strNot := ' NOT ';

            intIni := intContador2;
            Dec(intContador2);
          End;

          Break;
        End;

      End;

    End;

    If (intIni > 0) And (intFin > 0) Then
    Begin
      Delete(strSQL, intIni, intFin - IntIni + 1);
      Insert(strNot + strValPar, strSQL, intIni);

      If Not fEmptyStr(strNomCam) Then
        Break;

    End Else
    Begin
      intOffSet := intPos + Length(strNomPar);

     // Break;

    End;

  End; {While Pos(':' + strNomPar, strSQL, intOffSet) > 0 Do}

  Result := strSQL;
End;

Function TInterfaceRelatorio.fEmpAcessoToValPar: String;
  Var
    stlLista: TStringList;
Begin

  stlLista := TStringList.Create;
  stlLista.CommaText := AnsiReplaceStr(strEmpAcessoUsuarioLogado, '_', ',');

  Result := ' IN (' + fCommaText(stlLista, True)  + ') ';

  FreeAndNil(stlLista);
End;

Function TInterfaceRelatorio.fPortadorUsuarioToValPar(strNomCam: String): String;
Begin
 Result := '';
 Result := Result + ' (IFNULL(' + strNomCam + ', "") = "" ';
 Result := Result + ' OR LOCATE(' + strNomCam + ', ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
End;

Function TInterfaceRelatorio.fEhParametroEmpresa(strNomPar: String): Boolean;
Begin
  With FParams Do
  Result := Locate('PAR_NOMPAR', strNomPar, []) And SameText(FieldByName('PAR_PESQUI').AsString,  ArrDescPesquisa[pesEmpresa]);
End;

Function TInterfaceRelatorio.fEhParametroEmpresaCompleto(strNomPar: String): Boolean;
Begin
  With FParams Do
  Result := Locate('PAR_NOMPAR', strNomPar, []) And SameText(FieldByName('PAR_PESQUI').AsString,  ArrDescPesquisa[pesEmpresaCompleto]);
End;

Function TInterfaceRelatorio.fEhParametroPortador(strNomPar: String): Boolean;
Begin
  With FParams Do
  Result := Locate('PAR_NOMPAR', strNomPar, []) And SameText(FieldByName('PAR_PESQUI').AsString,  ArrDescPesquisa[pesPortador]);
End;

Function TInterfaceRelatorio.fRetiraClausula(strSQL, strNomPar: String): String;
  Var
    intIni,
    intFin,
    intPos,
    intPosStr,
    intContador,
    intPosNomCam: Integer;
    strNomCam: String;
    blnParar,
    blnAchouOperador,
    blnAchouIFNull: Boolean;

    intPosOperador,
    intPosIfNull,
    intContadorIfNull: Integer;
Begin
  intPosNomCam := 0;
  strNomCam    := '';

  blnParar := False;
  blnAchouOperador := False;

  intPosStr := 1;

  While Pos(':' + strNomPar, strSQL, intPosStr) > 0 Do
  Begin
    intPos := Pos(':' + strNomPar, strSQL, intPosStr);
    intIni := -1;
    intFin := -1;

    intPosOperador := 0;
    blnAchouIFNull := False;

    For intContador := intPos To Length(strSQL) Do
    Begin

      If strSQL[intContador] = '[' Then
        Break;

      If strSQL[intContador] = ']' Then
      Begin
        intFin := intContador;
        Break;
      End;

    End;

    If intFin <> -1 Then
      For intContador := intPos DownTo 1 Do
      Begin
        If strSQL[intContador] = ']' Then
          Break;

        If strSQL[intContador] = '[' Then
        Begin
          intIni := intContador;
          Break;
        End;

        If CharInSet(strSQL[intContador], ['>', '<', '=']) Then
        Begin
          intPosOperador := intContador;
          blnAchouOperador := True;
        End;

        If (Not blnAchouIFNull) And blnAchouOperador And (Not CharInSet(strSQL[intContador], ['>', '<', '='])) Then
        Begin
          If CharInSet(strSQL[intContador], [' ', ',']) And (Not fEmptyStr(strNomCam)) Then
          Begin
            If fEhParametroPortador(strNomPar) And strNomCam.EndsWith(')') Then
            Begin
              For intContadorIfNull := intContador DownTo 1 Do
              Begin
                If strSQL[intContadorIfNull] = '[' Then
                Begin
                  intPosIfNull := Pos('IFNULL', UpperCase(Copy(strSQL, intContadorIfNull, intContador - intContadorIfNull)));

                  If intPosIfNull > 0 Then
                  Begin
                    intPosIfNull := intPosIfNull + intContadorIfNull - 1;
                    strNomCam    := Copy(strSQL, intPosIfNull, Pred(intPosOperador) - intPosIfNull);
                    intPosNomCam := intPosIfNull;

                    blnAchouIFNull := True;
                  End;

                  Break;
                End;

              End;
            End;

            blnParar := True;
          End;

          If Not blnParar Then
          Begin
            strNomCam    := Trim(strSQL[intContador]) + strNomCam;
            intPosNomCam := intContador;
          End;
        End;
      End; {For intContador := intPos DownTo 1 Do}

    strNomCam := Trim(strNomCam);

    If (intIni > 0) And (intFin > 0) Then
    Begin
      If fEhParametroEmpresa(strNomPar) Then
      Begin
        strSQL := fPoeMultiSelecao(strSQL, strNomPar, fEmpAcessoToValPar);
      End

      Else If fEhParametroEmpresaCompleto(strNomPar) Then
      Begin
        strSQL := fPoeMultiSelecao(strSQL, strNomPar, fEmpAcessoToValPar);
      End

      Else If FDacPor And fEhParametroPortador(strNomPar) Then
      Begin
        strSQL := fPoeMultiSelecao(strSQL, strNomPar, fPortadorUsuarioToValPar(strNomCam), strNomCam, intPosNomCam);
        intPosNomCam := 0;
        strNomCam    := '';

        blnParar := False;
        blnAchouOperador := False;
        intPosStr := 1;

      End Else

      Begin
        Delete(strSQL, intIni, intFin - IntIni + 1);
      End

    End Else
    Begin
      blnParar := False;
      blnAchouOperador := False;
      intPosStr := intPos + Length(':' + strNomPar);
    End;
  End;

  Result := strSQL;
End;

Function TInterfaceRelatorio.fGetValorCombo(strDescricao: String): String;
  Var
    stlLista,
    stlValores: TStringList;
    intUltimo,
    intIndice: Integer;
Begin
  Result     := '';

  stlLista   := TStringList.Create;
  stlValores := TStringList.Create;

  stlLista.Text   := AnsiReplaceStr(FParams.FieldByName('PAR_FACTXT').AsString, '<<csq>>', #13#10);
  stlValores.Text := AnsiReplaceStr(FParams.FieldByName('PAR_FACVAL').AsString, '<<csq>>', #13#10);

  If stlValores.Count > 0 Then
    intUltimo := StrToIntDef(stlValores[stlValores.Count -1], 0)
  Else
    intUltimo := 0;

  If FParams.FieldByName('PAR_TABATI').AsString = 'S' Then
  Begin
    stlLista.Text   := stlLista.Text   + fCompletaDescricaoTabelasPrecoAtivas(False, 0);
    stlValores.Text := stlValores.Text + fCompletaDescricaoTabelasPrecoAtivas(True, intUltimo);
  End;

  intIndice := stlLista.IndexOf(strDescricao);

  If (intIndice > -1) And (intIndice < stlValores.Count) Then
    Result := stlValores[intIndice]
  Else
    Result := '';

  FreeAndNil(stlLista);
  FreeAndNil(stlValores);
End;

Function TInterfaceRelatorio.fSQLHorizo(intQuerie: Integer): String;
  Var
    strSQL: String;
    intColIni,
    intMaxCol,
    intContador: Integer;
    typTipoCampo: TFieldType;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("" AS CHAR(255)) AS DESCRICAO ';

  If SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S') Then
    intColIni := 0
  Else
    intColIni := 1;

  typTipoCampo := FQueryFiltros[intQuerie].Fields[intColIni].DataType;

  For intContador := Succ(intColIni) To FQueryFiltros[intQuerie].FieldCount - 1 Do
    If FQueryFiltros[intQuerie].Fields[intContador].DataType <> typTipoCampo Then
    Begin
      typTipoCampo := ftUnknown;
      Break;
    End;

  If SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S') Then
    intMaxCol := 1
  Else
    intMaxCol := FCadRel[intQuerie].FieldByName('REL_MAXCOL').AsInteger;

  For intContador := 1 To intMaxCol Do
  Begin

    strSQL := strSQL + ', ';

    Case typTipoCampo Of
       ftTime     : strSQL := strSQL + ' CURRENT_TIME  ';
       ftDateTime,
       ftDate     : strSQL := strSQL + ' CURRENT_DATE  ';
       ftInteger,
       ftLargeint,
       ftWord,
       ftFloat    : strSQL := strSQL + '  0.0000       ';
       Else         strSQL := strSQL + '  CAST("" AS CHAR(255)) ';
    End;

    If SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S') Then
      strSQL := strSQL + ' AS VALOR '
    Else
      strSQL := strSQL + ' AS VALOR' + intToStr(intContador);

  End;

  Result := strSQL;
End;

Function TInterfaceRelatorio.fCriaHorizo(intQuerie: Integer): Boolean;
Begin
  If (Not FQueryFiltros[intQuerie].Active) Or (FQueryFiltros[intQuerie].Fields.Count = 0) Then
  Begin
    pMensagemOk('Erro interno. Estrutura de dados não carregada!');
    Result := False;
    Exit;
  End;

  If Not Assigned(FHorizo[intQuerie]) Then
    FHorizo[intQuerie] := TZClient.Create(Self, '', FConexaoRelatorio.objConexao);

  With FHorizo[intQuerie] Do
  Begin

    qryQuery.SQL.Text := fSQLHorizo(intQuerie);

    Result := fAbreClient(True, 'fCriaHorizo');

    If Result Then
      EmptyDataSet;
  End;
End;

Function TInterfaceRelatorio.fSQLHorizoLines(intQuerie: Integer): String;
  Var
    strSQL: String;
    intContador: Integer;
    typTipoCampo: TFieldType;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("" AS CHAR(255)) AS DESCRICAO ';

  typTipoCampo := FQueryFiltros[intQuerie].Fields[1].DataType;

  For intContador := 2 To FQueryFiltros[intQuerie].FieldCount - 1 Do
    If FQueryFiltros[intQuerie].Fields[intContador].DataType <> typTipoCampo Then
    Begin
      typTipoCampo := ftUnknown;
      Break;
    End;

  intContador := 1;

  FQueryDados[intQuerie].First;

  While Not FQueryDados[intQuerie].Eof Do
  Begin

    strSQL := strSQL + ', ';

    Case typTipoCampo Of
       ftTime     : strSQL := strSQL + ' CURRENT_TIME  ';
       ftDateTime,
       ftDate     : strSQL := strSQL + ' CURRENT_DATE  ';
       ftInteger,
       ftLargeint,
       ftWord,
       ftFloat    : strSQL := strSQL + '  0.0000       ';
       Else         strSQL := strSQL + '  CAST("" AS CHAR(255)) ';
    End;

    strSQL := strSQL + ' AS VALOR' + intToStr(intContador);

    Inc(intContador);

    FQueryDados[intQuerie].Next;
  End;

  FQueryDados[intQuerie].First;

  Result := strSQL;
End;

Function TInterfaceRelatorio.fCriaHorizoLines(intQuerie: Integer): Boolean;
Begin
  If (Not FQueryFiltros[intQuerie].Active) Or (FQueryFiltros[intQuerie].Fields.Count = 0) Then
  Begin
    pMensagemOk('Erro interno. Estrutura de dados não carregada!');
    Result := False;
    Exit;
  End;

  If Not Assigned(FHorizo[intQuerie]) Then
    FHorizo[intQuerie] := TZClient.Create(Self, '', FConexaoRelatorio.objConexao);

  With FHorizo[intQuerie] Do
  Begin

    qryQuery.SQL.Text := fSQLHorizoLines(intQuerie);

    Result := fAbreClient(True, 'fCriaHorizoLines');

    If Result Then
      EmptyDataSet;
  End;
End;

Function TInterfaceRelatorio.fInverteConsulta(intQuerie: Integer; Var blnTudoNulo: Boolean): Boolean;
  Var
    intIndice: Integer;
Begin
  blnTudoNulo := True;

  Result := fCriaHorizo(intQuerie);

  If Not Result Then
    Exit;

  With FHorizo[intQuerie]  Do
  Begin
    For intIndice := 0 To FQueryDados[intQuerie].Fields.Count - 1 Do
    Begin
      Append;
      FieldByName('DESCRICAO').AsString := FQueryDados[intQuerie].Fields[intIndice].FieldName;
      FieldByName('VALOR').Value        := FQueryDados[intQuerie].Fields[intIndice].Value;

      If Not FQueryDados[intQuerie].Fields[intIndice].IsNull Then
        blnTudoNulo := False;

      Post;
    End;

    First;
  End;
End;

Function TInterfaceRelatorio.fInverteConsultaLines(intQuerie: Integer; Var blnTudoNulo: Boolean): Boolean;
  Var
    intIndice,
    intColuna: Integer;
Begin
  blnTudoNulo := True;

  Result := fCriaHorizoLines(intQuerie);

  If Not Result Then
    Exit;

  With FHorizo[intQuerie]  Do
  Begin

    For intIndice := 1 To FQueryDados[intQuerie].Fields.Count - 1 Do
    Begin
      Append;
      FieldByName('DESCRICAO').AsString := FQueryDados[intQuerie].Fields[intIndice].FieldName;
      Post;
    End;

    blnTudoNulo := IsEmpty;

    FNomeColunaHorizo.Clear;
    FQueryDados[intQuerie].First;
    intColuna := 1;

    While Not FQueryDados[intQuerie].Eof Do
    Begin
      FNomeColunaHorizo.Add(FQueryDados[intQuerie].Fields[0].AsString);

      First;

      For intIndice := 1 To FQueryDados[intQuerie].Fields.Count - 1 Do
      Begin

        Edit;
        Fields[intColuna].Value := FQueryDados[intQuerie].Fields[intIndice].Value;
        Post;

        Next;
      End;

      FQueryDados[intQuerie].Next;
      Inc(intColuna);
    End;

    First;
  End;
End;

Function TInterfaceRelatorio.fSetaDadosQuery(qryDados, qryFiltros: TUniQuery;
          blnVerObrigatorio: Boolean; Var blnFaltaInformacao: Boolean): Boolean;
Begin
  If FExecutaPelaInterface Then
    Result := fSetaDadosQueryInterface(qryDados, qryFiltros, blnVerObrigatorio, blnFaltaInformacao)
  Else
    Result := fSetaDadosQueryExecucao(qryDados, qryFiltros, blnVerObrigatorio, blnFaltaInformacao)
End;

Function TInterfaceRelatorio.fSetaDadosQueryInterface(qryDados, qryFiltros: TUniQuery;
          blnVerObrigatorio: Boolean; Var blnFaltaInformacao: Boolean): Boolean;
  Var
    intIndice: Integer;
    parParam: TUniParam;
    rowDado: TcxEditorRow;
    strDado: String;
    facInterface: TTipoInterface;
Begin
  Result := True;

  blnFaltaInformacao := False;

  With qryDados Do
  For intIndice := 0 To Params.Count - 1 Do
  Begin
    parParam := qryFiltros.Params.FindParam(Params[intIndice].Name);

    If Assigned(parParam) Then
    Begin

      rowDado := fRetRowDado(Params[intIndice].Name);

      If Not Assigned(rowDado) Then
      Begin

        If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And
          (FParams.FieldByName('PARVIS').AsInteger = 0) Then
        Begin

          Continue;

        End Else
        Begin

          Result := False;
          pMensagemOk('Erro interno. Valor do parâmetro ' + Params[intIndice].Name + ' não encontrado!');
          Exit;

        End;

      End;

      If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And (rowDado.Properties.Value <> Null) Then
      Begin
        facInterface := fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString);

        Case facInterface Of
          facComboBox,
          facComboBoxVerdeVermelho: strDado := fGetValorCombo(rowDado.Properties.Value);

          facTabelaPrecoLista,
          facCustomCheckList:  strDado := rowDado.Properties.DisplayTexts[0];

          Else                 strDado := rowDado.Properties.Value;
        End;

        If (TcxTextEditProperties((rowDado.Properties).EditProperties).EchoMode = eemPassword) Then
          strDado := fRetCodVendedor(strDado);

        Case parParam.DataType Of
          ftTime     : Params[intIndice].AsTime     := StrToTimeDef(strDado, 0);
          ftDateTime : Params[intIndice].AsDateTime := StrToDateTime(strDado);
          ftDate     : Params[intIndice].AsDate     := StrToDate(strDado);
          ftFloat    : Params[intIndice].AsFloat    := fstrToFloat(strDado);
          Else         Params[intIndice].Value      := strDado;
        End;

      End

      Else If blnVerObrigatorio And
              FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And
              (FParams.FieldByName('PAR_OBRIGA').AsString = 'S') Then
      Begin
        blnFaltaInformacao := True;
        Exit;
      End

      Else Params[intIndice].Value := Null;

    End;

  End;

End;

Function TInterfaceRelatorio.fSetaDadosQueryExecucao(qryDados,
                                                     qryFiltros: TUniQuery;
                                                     blnVerObrigatorio: Boolean;
                                                     Var blnFaltaInformacao: Boolean): Boolean;
  Var
    intIndice: Integer;
    parParam: TUniParam;
    strDado: String;
    facInterface: TTipoInterface;
    blnAchouParametro: Boolean;
Begin
  Result := True;

  blnFaltaInformacao := False;

  With qryDados Do
  For intIndice := 0 To Params.Count - 1 Do
  Begin
    parParam := qryFiltros.Params.FindParam(Params[intIndice].Name);

    If Assigned(parParam) Then
    Begin

      blnAchouParametro := FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []);

      If Not blnAchouParametro Then
      Begin

        If FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And
          (FParams.FieldByName('PARVIS').AsInteger = 0) Then
        Begin

          Continue;

        End Else
        Begin

          Result := False;
          pMensagemOk('Erro interno. Valor do parâmetro ' + Params[intIndice].Name + ' não encontrado!');
          Exit;

        End;

      End;

      If Not FParams.FieldByName('VALOR').IsNull Then
      Begin
        facInterface := fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString);

        Case facInterface Of
          facComboBox,
          facComboBoxVerdeVermelho: strDado := FParams.FieldByName('VALOR').AsString;

          facTabelaPrecoLista,
          facCustomCheckList:  strDado := FParams.FieldByName('VALOR').AsString;

          Else                 strDado := FParams.FieldByName('VALOR').AsString;
        End;

        Case parParam.DataType Of
          ftTime     : Params[intIndice].AsTime     := StrToTimeDef(strDado, 0);
          ftDateTime : Params[intIndice].AsDateTime := StrToDateTime(strDado);
          ftDate     : Params[intIndice].AsDate     := StrToDate(strDado);
          ftFloat    : Params[intIndice].AsFloat    := fstrToFloat(strDado);
          Else         Params[intIndice].Value      := strDado;
        End;

      End

      Else If blnVerObrigatorio And
              FParams.Locate('PAR_NOMPAR', Params[intIndice].Name, []) And
              (FParams.FieldByName('PAR_OBRIGA').AsString = 'S') Then
      Begin
        blnFaltaInformacao := True;
        Exit;
      End

      Else Params[intIndice].Value := Null;

    End;

  End;

End;

Function TInterfaceRelatorio.fValidaComFil: Boolean;
  Var
    intQuerie: Integer;
    strMsgErr: String;
Begin
  Result := True;

  Try
    strMsgErr := '';

    For intQuerie := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
    If Assigned(FComFilFiltros[intQuerie]) Then
    With FComFilFiltros[intQuerie] Do
    Begin
      Close;

      If fTemComandosProibidos(SQL.Text) Then
      Begin
        FSQLErro := True;
        Result := False;
        Exit;
      End;

      If fEmptyStr(SQL.Text) Then
      Begin
        Result := False;
      End Else
      Begin
        Execute;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      FSQLErro := True;

      If (Pos(STR_PRECUS, FSQLFil) > 0) And
         (Pos('Unknown column', E.Message) > 0) And
         fTemCampoCusto(E.Message) Then
        strMsgErr := 'As tabelas ou views utilizadas não contém os campos para a montagem da Composição do Preço de Custo (' + STR_PRECUS + ')!'
      Else
        strMsgErr :=  E.Message;

      pCriarFormularios(TfrmMsgErroSQL, frmMsgErroSQL);
      frmMsgErroSQL.mmoErrSQL.Lines.text := strMsgErr;
      frmMsgErroSQL.ShowModal;
      pFreeAndNil(frmMsgErroSQL);

      Exit;
    End;
  End;

  FSQLErro := False;
End;

Procedure TInterfaceRelatorio.pCarregaQueriesComFil;
  Var
    strSQL,
    strParcial: String;
    intPosicao: Integer;
Begin
  pLiberaQueriesComFil;

  strSQL := Trim(AnsiReplaceStr(FSQLFil, '<<csq>>', #13#10));

  If Pos('{', strSQL) = 0 Then
  Begin
    SetLength(FComFilSQLFormatado, 1);
    FComFilSQLFormatado[0] := strSQL;

    SetLength(FComFilFiltros, 1);
    FComFilFiltros[0] := fCriaQuery(Self, FConexaoRelatorio.objConexao);
    FComFilFiltros[0].SQL.Text := fRetiraFormatacaoSQL(strSQL, False, False, False {blnQueryFiltros});
  End Else
  Begin

    While Pos('}', strSQL) > 0 Do
    Begin
      intPosicao := Pos('}', strSQL);
      strParcial := Trim(AnsiReplaceStr(LeftStr(strSQL, intPosicao -1), '{', ''));

      SetLength(FComFilSQLFormatado, Succ(Length(FComFilSQLFormatado)));
      FComFilSQLFormatado[High(FComFilSQLFormatado)] := strParcial;

      SetLength(FComFilFiltros, Succ(Length(FComFilFiltros)));
      FComFilFiltros[High(FComFilFiltros)] := fCriaQuery(Self, FConexaoRelatorio.objConexao);
      FComFilFiltros[High(FComFilFiltros)].SQL.Text := fRetiraFormatacaoSQL(strParcial, False, False, False {blnQueryFiltros});

      Delete(strSQL, 1, intPosicao);
    End;

  End;

  If fValidaComFil Then
    fMontaComFilDados
  Else
    FSQLFil := '';
End;

Function TInterfaceRelatorio.fValidaQueryValidacao(qryDados: TUniQuery): Boolean;
Begin
  Result := Assigned(qryDados.FindField('RETORNO')) And Assigned(qryDados.FindField('TIPO'));
End;

Function TInterfaceRelatorio.fValidaSQL(strSQL: String; blnVazioOk: Boolean;
                                        blnExecute: Boolean = False;
                                        blnMarcarSQLErro: Boolean = True;
                                        intNroCols: Integer = -1;
                                        strMsgErro: String = ''): Boolean;
  Var
    qrySQL: TUniQuery;
    strMsgErr: String;
Begin
  Try
    Result := True;

    If fEmptyStr(strSQL) And blnVazioOk Then
      Exit;

    strSQL := Trim(AnsiReplaceStr(strSQL, '<<csq>>', #13#10));

    strSQL := Trim(AnsiReplaceStr(strSQL, '(WHERE)', 'WHERE'));

    strSQL := Trim(AnsiReplaceStr(strSQL, 'WHERE', 'WHERE FALSE AND '));

    qrySQL := fCriaQuery(Self, FConexaoRelatorio.objConexao);
    qrySQL.SQL.Text := fRetiraFormatacaoSQL(strSQL, False, False, True{blnQueryFiltros});

    With qrySQL Do
    Begin
      If fTemComandosProibidos(SQL.Text) Then
        Result := False;

      If fEmptyStr(SQL.Text) Then
        Result := False;

      If Result Then
      Begin

        If blnExecute Then
          Execute
        Else
        begin
          Open;

          If (intNroCols > -1) And (Fields.Count < intNroCols) Then
          Begin
            Result := False;
            pMensagemOk(strMsgErro);
          End;

        End;
      End;

    End;

    If Result And (fRetDestino = desValidacao) And (Not fValidaQueryValidacao(qrySQL)) Then
      Raise Exception.Create('O Relatório de validação deve conter as colunas "RETORNO" e "TIPO"!');

  Except
    On E: Exception Do
    Begin
      Result := False;

      If blnMarcarSQLErro Then
        FSQLErro := True;

      If (Pos(STR_PRECUS, FSQLFil) > 0) And
         (Pos('Unknown column', E.Message) > 0) And
         fTemCampoCusto(E.Message) Then
        strMsgErr := 'As tabelas ou views utilizadas não contém os campos para a montagem da Composição do Preço de Custo (' + STR_PRECUS + ')!'
      Else
        strMsgErr :=  E.Message;

      pCriarFormularios(TfrmMsgErroSQL, frmMsgErroSQL);
      frmMsgErroSQL.mmoErrSQL.Lines.text := strMsgErr;
      frmMsgErroSQL.ShowModal;
      pFreeAndNil(frmMsgErroSQL);

      Exit;
    End;
  End;

  FreeAndNil(qrySQL);
End;

Function TInterfaceRelatorio.fMontaComFilDados: Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  SetLength(FComFilDados, Length(FComFilFiltros));

  For intContador := Low(FComFilDados) To High(FComFilDados) Do
  Begin
    FComFilFiltros[intContador].Execute;

    FComFilDados[intContador] := fCriaQuery(Self, FConexaoRelatorio.objConexao);
  End;
End;

Function TInterfaceRelatorio.fVeSeExecutaComFilShow: Boolean;
  Var
    blnExcuta: Boolean;
    intIndice,
    intQuerie: Integer;
Begin
  Result    := True;

  blnExcuta := False;

  For intQuerie := Low(FComFilFiltros) To High(FComFilFiltros) Do
    SetTag(FComFilFiltros[intQuerie], 0);

  With FFiltros Do
  For intIndice := 0 To Rows.Count - 1 Do
  If (Not Rows[intIndice].IsCategory) Then
  Begin
    If (Not fVeSeExecutaComFil(Rows.Items[intIndice].Name, True)) Then
    Begin
      Result := False;
      Exit;
    End;

    For intQuerie := Low(FComFilFiltros) To High(FComFilFiltros) Do
      If GetTag(FComFilFiltros[intQuerie]) = 0 Then
      Begin
        blnExcuta := True;
        Break;
      End;

    If Not blnExcuta Then
      Exit;
  End;
End;

function TInterfaceRelatorio.GetTag(AQuery: TUniQuery): Integer;
begin
  if dicQueryTag.ContainsKey(AQuery) then
    Result := dicQueryTag[AQuery]
  else
    Result := 0;
end;

Procedure TInterfaceRelatorio.SetTag(AQuery: TUniQuery; Value: Integer);
begin
  dicQueryTag.AddOrSetValue(AQuery, Value)
end;

Function TInterfaceRelatorio.fVeSeExecutaComFil(strNomPar: String; blnShow: Boolean = False): Boolean;
  Var
    intQueries: Integer;
    parParam: TUniParam;
    blnFaltaInformacao: Boolean;
Begin
  Result := True;

  For intQueries := Low(FComFilFiltros) To High(FComFilFiltros) Do
    With FComFilFiltros[intQueries] Do
    If (Not blnShow) Or (GetTag(FComFilFiltros[intQueries]) = 0) Then
    Begin

      parParam := FindParam(strNomPar);

      If Assigned(parParam) Then
      Begin
        SetTag(FComFilFiltros[intQueries], 1);

        If GetTag(FComFilDados[intQueries]) = 0 Then
        Begin
          FComFilDados[intQueries].SQL.Text := fMontaSQLDados(FComFilSQLFormatado[intQueries], FComFilFiltros[intQueries]);
          SetTag(FComFilDados[intQueries], 1);
        End;

        Result := Not FSQLErro;

        If Not Result Then
          Exit;

        FComFilDados[intQueries].Close;

        Result := fSetaDadosQuery(FComFilDados[intQueries],
                                  FComFilFiltros[intQueries],
                                  True,
                                  blnFaltaInformacao);

        If Not Result Then
          Exit;

        If Not blnFaltaInformacao Then
          FComFilDados[intQueries].Execute;

        pAtualizaTelaComFil(FComFilDados[intQueries].SQL.Text, blnFaltaInformacao);
      End;

    End;

End;

Procedure TInterfaceRelatorio.pAtualizaTelaComFil(strSQL: String; blnLimparValor: Boolean);
  Var
    intContador: Integer;
    stlCampos: TStringList;
    qryConsulta: TUniQuery;
    objComp: TcxCustomRow;
Begin
  stlCampos := TStringList.Create;

  For intContador := 0 To FComFilComplementos.Count - 1 Do
    If Pos(FComFilComplementos[intContador], strSQL) > 0 Then
      stlCampos.Add(FComFilComplementos[intContador]);

  If stlCampos.Count > 0 Then
  Begin

    If blnLimparValor Then
    Begin

      For intContador := 0 To stlCampos.Count - 1 Do
      Begin
        objComp := FFiltros.RowByName(fComFilToName(stlCampos[intContador]));

        If Assigned(objComp) Then
          TcxEditorRow(objComp).Properties.Value := Null;
      End;

    End Else
    Begin
      qryConsulta := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
      qryConsulta.SQL.Text := 'SELECT ' + stlCampos.CommaText;
      qryConsulta.Open;

      For intContador := 0 To qryConsulta.Fields.Count - 1 Do
      Begin
        objComp := FFiltros.RowByName(fComFilToName(qryConsulta.Fields[intContador].FieldName));

        If Assigned(objComp) Then
          TcxEditorRow(objComp).Properties.Value := qryConsulta.Fields[intContador].Value;
      End;

      FreeAndNil(qryConsulta);
    End;
  End;

  FreeAndNil(stlCampos);
End;

function TInterfaceRelatorio.fDevolveSQLExecucao(qryFiltros: TUniQuery; strSQL: string): string;
var
  intIndice: Integer;
  stlParams: TStringList;
  strParam: string;
begin
  stlParams := TStringList.Create;
  try
    for intIndice := 0 To qryFiltros.Params.Count - 1 do
      stlParams.Add(fPadL(IntToStr(Length(qryFiltros.Params[intIndice].Name)), 2, '0') + qryFiltros.Params[intIndice].Name);
    stlParams.Sort;
    for intIndice := stlParams.Count - 1 downto 0 do
    Begin
      strParam := Copy(stlParams[intIndice], 3, Length(stlParams[intIndice]));
      if qryFiltros.Params.FindParam(strParam).IsNull then
        strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, 'NULL')
      else
      begin
        case qryFiltros.Params.FindParam(strParam).DataType of
          ftTime     : strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, QuotedStr(FormatDateTime('hh:nn:ss', qryFiltros.Params.FindParam(strParam).AsTime)));
          ftDateTime : strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', qryFiltros.Params.FindParam(strParam).AsDateTime)));
          ftDate     : strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, QuotedStr(FormatDateTime('yyyy-mm-dd', qryFiltros.Params.FindParam(strParam).AsDate)));
          ftFloat    : strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, AnsiReplaceStr(FloatToStr(qryFiltros.Params.FindParam(strParam).AsFloat), ',', '.'));
          ftInteger  : strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, IntToStr(qryFiltros.Params.FindParam(strParam).AsInteger));
          else         strSQL := AnsiReplaceStr(strSQL, ':' + qryFiltros.Params.FindParam(strParam).Name, QuotedStr(qryFiltros.Params.FindParam(strParam).AsString));
        end;
      end;
    end;
    Result := strSQL;
  finally
    FreeAndNil(stlParams);
  end;
end;

Function TInterfaceRelatorio.fExecutaSets(Progress : TcxProgressBar; var strSetSQL: string; strSQL: String;
  intQuerie: Integer; strNomeSet: string = ''): String;
  Var
    strVariavel,
    strSQLAux,
    strSetSelect: String;
    intPosSelect,
    intPosDoisPontosIgual,
    intInicio,
    intIncremento,
    intPosIgual: Integer;
    blnFaltaInformacao: Boolean;

    qrySetSelect: TUniquery;

    Function fVerificaSetSelect(var strSetSQL: string; strNomeSet: string): Boolean;
      Var
        intPosicao: Integer;
    Begin
      Result := True;

      intPosicao := Pos('SET ', strSQLAux, intInicio);

      If intPosicao > 0 Then
      Begin

        If intPosicao > 1 Then
        Begin

          // VERIFICA SE REALMENTE É SET
          If Not CharInSet(strSQLAux[Pred(intPosicao)], [' ', #10]) Then
          Begin
            intInicio  := intPosicao + 3;
            intPosicao := 0;
          End;
        End;

      End
      Else Result := False; // NAO TEM SET

      If intPosicao > 0 Then
      Begin
        intInicio  := intPosicao;
        intPosicao := Pos(';', strSQLAux, intInicio);

        If intPosicao > 0 Then
        Begin
          // VERIFICA SE TEM SELECT NO SET
          intPosSelect := Pos('SELECT', strSQLAux, intInicio);

          If (intPosSelect > 0) And (intPosSelect < intPosicao) Then
          Begin
            // ACHOU UM SET ... SELECT ... ;
            strSetSelect := Copy(strSQLAux, intInicio, intPosicao - intInicio + 1);

            intPosIgual           := Pos('=', strSetSelect);
            intPosDoisPontosIgual := Pos(':=', strSetSelect);

            intIncremento := 0;

            If (intPosDoisPontosIgual > 0) And (intPosDoisPontosIgual < intPosIgual) Then
            Begin
              intPosIgual := intPosDoisPontosIgual;
              intIncremento := 1;
            End;

            If intPosIgual > 0 Then
            Begin
              strVariavel := Trim(Copy(strSetSelect, 4, intPosIgual - 4));

              If (fEmptyStr(strNomeSet) Or (strNomeSet = strVariavel)) Then
              Begin

                SetLength(FarrRecSetSelect, Succ(Length(FarrRecSetSelect)));
                FarrRecSetSelect[High(FarrRecSetSelect)].strNomVar := strVariavel;
                FarrRecSetSelect[High(FarrRecSetSelect)].strNomPar := AnsiReplaceStr(strVariavel, '@', ':ARROBA_');
                FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo   := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
                FarrRecSetSelect[High(FarrRecSetSelect)].intQuery  := intQuerie;

                FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.SQL.Text :=
                  Copy(strSQLAux, 1, intInicio - 1) +
                  'SELECT (' + Trim(Copy(strSetSelect, Succ((intPosIgual + intIncremento)), Length(strSetSelect) - (intPosIgual + intIncremento) - 1)) + ')';

                Result := fSetaDadosQuery(FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo, FQueryFiltros[intQuerie], False, blnFaltaInformacao);

                strSetSQL := strSetSQL + IIF(not fEmptyStr(strSetSQL), ' ', '') +  fDevolveSQLExecucao(FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo, Copy(strSQLAux, 1, intInicio - 1));

                If blnConexaoIndependente Then
                  fExecutaThread(FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo, Nil, Progress, False{blnExec})
                Else
                  FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Open;

                qrySetSelect.Close;
                if AnsiMatchStr(FarrRecSetSelect[High(FarrRecSetSelect)].strNomVar, ['@TITULO_RELATORIO', '@SUBTITULO_RELATORIO', '@TITULO_EMPRESA', '@PATH_IMAGEM_CABECALHO']) then
                  qrySetSelect.SQL.Text := 'SET ' + FarrRecSetSelect[High(FarrRecSetSelect)].strNomVar + '_' + IntToStr(intQuerie) + ' = :VALOR;'
                else
                  qrySetSelect.SQL.Text := 'SET ' + FarrRecSetSelect[High(FarrRecSetSelect)].strNomVar + ' = :VALOR;';

                Case FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].DataType of
                  ftFloat:    qrySetSelect.ParamByName('VALOR').AsFloat    := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].AsFloat;
                  ftString:   qrySetSelect.ParamByName('VALOR').AsString   := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].AsString;
                  ftMemo:     qrySetSelect.ParamByName('VALOR').AsString   := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].AsString;
                  ftDateTime: qrySetSelect.ParamByName('VALOR').AsDateTime := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].AsDateTime;
                  ftInteger:  qrySetSelect.ParamByName('VALOR').AsInteger  := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].AsInteger;
                  Else        qrySetSelect.ParamByName('VALOR').Value      := FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Fields[0].Value;
                End;

                strSetSQL := strSetSQL + IIF(not fEmptyStr(strSetSQL), ' ', '') + fDevolveSQLExecucao(qrySetSelect, qrySetSelect.SQL.Text);

                If blnConexaoIndependente Then
                  fExecutaThread(qrySetSelect, Nil, Progress, True{blnExec})
                Else
                  qrySetSelect.ExecSQL;

                FarrRecSetSelect[High(FarrRecSetSelect)].qryInfo.Close;

                System.Delete(strSQLAux, 1, intPosicao);

                intInicio := 1;

              End
              Else
                intInicio := intPosicao;
            End

            // VAI TENTAR O PROXIMO SET
            Else intInicio := intPosicao;

          End

          // VAI TENTAR O PROXIMO SET
          Else intInicio := intPosicao;
        End;

      End;

    End;

Begin
  strSQLAux := strSQL;
  intInicio := 1;

  qrySetSelect := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  While fVerificaSetSelect(strSetSQL, strNomeSet) Do ;

  FreeAndNil(qrySetSelect);

  Result := strSQLAux;
End;

Function TInterfaceRelatorio.fExecutaConsts(strSQL: String): String;
  Var
    strConstante,
    strSQLAux,
    strConstInst: String;
    intPosInst,
    intInicio,
    intPosIgual: Integer;

    Function fVerificaConstSelect: Boolean;
      Var
        intPosicao: Integer;
    Begin
      Result := True;

      intPosicao := Pos('CONST ', strSQLAux, intInicio);

      If intPosicao > 0 Then
      Begin

        If intPosicao > 1 Then
        Begin

          // VERIFICA SE REALMENTE É CONST
          If Not CharInSet(strSQLAux[Pred(intPosicao)], [' ', #10]) Then
          Begin
            intInicio  := intPosicao + 5;
            intPosicao := 0;
          End;
        End;

      End
      Else Result := False; // NAO TEM CONST

      // Modo de uso:
      // CONST VS_NOME_INSTRUCAO = INST IF(EMP_CODEMP = VS_STRCODEMP, '001', '002');
      // Lembrar de começar com INST e terminar com ;
      // Onde tiver VS_NOME_INSTRUCAO no SQL, vai ser substituído por IF(EMP_CODEMP = VS_STRCODEMP, '001', '002')

      If intPosicao > 0 Then
      Begin
        intInicio  := intPosicao;
        intPosicao := Pos(';', strSQLAux, intInicio);

        If intPosicao > 0 Then
        Begin
          // VERIFICA SE TEM INST NO CONST
          intPosInst := Pos('INST', strSQLAux, intInicio);

          If (intPosInst > 0) And (intPosInst < intPosicao) Then
          Begin
            // ACHOU UM CONST ... INST ... ;
            strConstInst := Copy(strSQLAux, intInicio, intPosicao - intInicio);

            intPosIgual := Pos('=', strConstInst);

            If intPosIgual > 0 Then
            Begin
              strConstante := Trim(Copy(strConstInst, 6, intPosIgual - 6));

              SetLength(FarrRecConstInst, Succ(Length(FarrRecConstInst)));
              FarrRecConstInst[High(FarrRecConstInst)].strNomConst := strConstante;
              FarrRecConstInst[High(FarrRecConstInst)].strDescInst := Trim(Copy(strConstInst, Succ((intPosIgual)) + 5, Length(strConstInst) - (intPosIgual) - 1));

              System.Delete(strSQLAux, 1, intPosicao);

              intInicio := 1;

            End

            // VAI TENTAR O PROXIMO SET
            Else intInicio := intPosicao;

          End

          // VAI TENTAR O PROXIMO SET
          Else intInicio := intPosicao;
        End;

      End;

    End;

Begin
  strSQLAux := strSQL;
  intInicio := 1;

  While fVerificaConstSelect Do ;

  Result := strSQLAux;
End;

Procedure TInterfaceRelatorio.pLiberaArrRecSetSelect;
  Var
    intContador: Integer;
Begin
  For intContador := Low(FarrRecSetSelect) To High(FarrRecSetSelect) Do
    If Assigned(FarrRecSetSelect[intContador].qryInfo) Then
      FreeAndNil(FarrRecSetSelect[intContador].qryInfo);

  SetLength(FarrRecSetSelect, 0);
End;

Function TInterfaceRelatorio.fRetDescricaoTodos(dbeDesTod: TField): String;
Begin
  If dbeDesTod.IsNull Then
    Result := 'TODOS'

  Else Result := dbeDesTod.Value;
End;

Function TInterfaceRelatorio.fGeraTitulo(strNomPar: String): Boolean;
  Var
    blnAchou: Boolean;
Begin
  Result := (FCadRel[0].FieldByName('REL_FILINF').AsString <> 'S') Or
            (Not fEmptyStr(fGetValorParametro(strNomPar, blnAchou)));

  FParams.Edit;
  FParams.FieldByName('PARIMP').AsInteger := IfThen(Result, 1, 0);
  FParams.Post;

End;

Function TInterfaceRelatorio.fGeraTitulosQuery(qryFiltro: TUniQuery; lstListaParFiltros: TStringList; blnFiltraImpFil: Boolean = False): Boolean;
  Var
    intIndexPar,
    intContador,
    intIndice: Integer;
    blnAchouValor,
    blnTemPesquisa: Boolean;
    rowDado: TcxEditorRow;
    strValue: String;
    parParam: TUniParam;
    strDescPar: String;
    blnFiltered: Boolean;
    strFilter: String;

  procedure pCarregaCombosDinamicos;
  begin
    cdsParametrosAutomaticos.First;
    while not cdsParametrosAutomaticos.Eof do
    begin
      if (not lstListaParFiltros.Find(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString, intIndexPar)) then
      begin
        rowDado := fRetRowDado(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString);
        if Assigned(rowDado) then
        begin
          lstListaParFiltros.Add(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString);
          FListaParFiltros.Add(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString);
          FTituloFiltros.Add(rowDado.Properties.Caption + ': ' + rowDado.Properties.Value);
        end
        else
        begin
          cdsParametrosAutomaticos.Edit;
          cdsParametrosAutomaticos.FieldByName('PARVIS').AsInteger := 0;
          cdsParametrosAutomaticos.Post;
        end;
      end;
      cdsParametrosAutomaticos.Next;
    end;
  end;

Begin
  Result := True;

  With qryFiltro Do
  Begin

    blnFiltered := FParams.Filtered;
    strFilter   := FParams.Filter;

    If blnFiltraImpFil Then
    Begin
      FParams.Filtered := False;
      FParams.Filter := '(IMPFIL = 1)';
      FParams.Filtered := True;
    End;

    FParams.First;

    While Not FParams.Eof Do
    Begin

      If fGeraTitulo(FParams.FieldByName('PAR_NOMPAR').AsString) And // MANTER COMO PRIMEIRO TESTE - TEM QUE ATUALIZAR TODOS REGISTROS
         (FParams.FieldByName('PAR_ORIPAR').AsString <> '1') And
         (Not lstListaParFiltros.Find(FParams.FieldByName('PAR_NOMPAR').AsString, intIndexPar)) Then
      Begin
        parParam := Params.FindParam(FParams.FieldByName('PAR_NOMPAR').AsString);

        If parParam <> Nil Then
        Begin
          intIndice := parParam.Index;

          rowDado := fRetRowDado(Params[intIndice].Name);

          If Not Assigned(rowDado) Then
          Begin

            If (FParams.FieldByName('PARVIS').AsInteger = 0) Then
            Begin

              FParams.Next;
              Continue;

            End Else
            Begin

              Result := False;
              pMensagemOk('Erro interno. Valor do parâmetro ' + Params[intIndice].Name + ' não encontrado!');
              Exit;

            End;

          End;

          lstListaParFiltros.Add(FParams.FieldByName('PAR_NOMPAR').AsString);
          FListaParFiltros.Add(FParams.FieldByName('PAR_NOMPAR').AsString);

          With rowDado Do
          strDescPar := Properties.Caption;

          If AnsiStartsStr('* ', strDescPar) Then
            System.Delete(strDescPar, 1, 2);

          With rowDado Do
          If fTemMultiSelecao(Params[intIndice].Name) Then
          Begin

            FTituloFiltros.Add(strDescPar + ': ' + FValueParams.FieldByName('DESEDT').AsString)

          End

          Else If (Properties.Value <> Null) And (Not fEmptyStr(Properties.Value)) Then
          Begin
            blnTemPesquisa := (Not fEmptyStr(FParams.FieldByName('PAR_PESQUI').AsString));

            If blnTemPesquisa Then
            Begin
              strValue := fTiraCaracEspeciaisPonto(Properties.Value);

              If (TcxTextEditProperties((Properties).EditProperties).EchoMode = eemPassword) Then
                strValue := fRetCodVendedor(strValue);

              FTituloFiltros.Add(strDescPar + ': ' +
                FConsulta.fRetDescricaoRel(strValue, FParams.FieldByName('PAR_PESQUI').AsString));

            End Else
            Begin

              If Properties.EditPropertiesClass = TcxCheckComboBoxProperties Then
              Begin
                FTituloFiltros.Add(strDescPar + ': ' + Properties.DisplayTexts[0]);
              End

              Else If Properties.EditPropertiesClass = TcxCheckBoxProperties Then
              Begin
                If Properties.Value = 'S' Then
                  FTituloFiltros.Add(strDescPar + ': SIM')
                Else
                  FTituloFiltros.Add(strDescPar + ': NÃO');
              End

              Else If Properties.EditPropertiesClass = TcxRadioGroupProperties Then
              Begin
                blnAchouValor := False;

                For intContador := 0 To TcxRadioGroupProperties(Properties.EditProperties).Items.Count - 1 Do
                  If Properties.Value = TcxRadioGroupProperties(Properties.EditProperties).Items[intContador].Value Then
                  Begin
                    blnAchouValor := True;
                    FTituloFiltros.Add(strDescPar + ': ' + fUpper(TcxRadioGroupProperties(Properties.EditProperties).Items[intContador].Caption));
                    Break;
                  End;

                If Not blnAchouValor Then
                  FTituloFiltros.Add(strDescPar + ': ');
              End

              Else FTituloFiltros.Add(strDescPar + ': ' + fUpper(Properties.Value));
            End;

          End Else
          Begin
            If fEhParametroEmpresa(Params[intIndice].Name) Then
              FTituloFiltros.Add(strDescPar + ': ' + strEmpAcessoUsuarioLogado)

            Else If fEhParametroEmpresaCompleto(Params[intIndice].Name) Then
              FTituloFiltros.Add(strDescPar + ': ' + strEmpAcessoUsuarioLogado)

            Else If FDacPor And fEhParametroPortador(Params[intIndice].Name) Then
              FTituloFiltros.Add(strDescPar + ': ' + strPortadoresOperador)

            Else
              FTituloFiltros.Add(strDescPar + ': ' + fRetDescricaoTodos(FParams.FieldByName('PAR_DESTOD')));
          End;

        End;

      End;

      FParams.Next;

    End;

    If blnFiltraImpFil Then
    Begin
      FParams.Filter   := strFilter;
      FParams.Filtered := blnFiltered;
    End;

  End;

  pCarregaCombosDinamicos;

End; {fGeraTitulosQuery}

Function TInterfaceRelatorio.fGeraTitulosFiltros(blnFiltraImpFil: Boolean = False): Boolean;
  Var
    intQuerie: Integer;
    lstListaParFiltros: TStringList;
Begin
  Result := True;

  lstListaParFiltros := TStringList.Create;
  lstListaParFiltros.Sorted := True;

  FTituloFiltros.Clear;
  FListaParFiltros.Clear;
  lstListaParFiltros.Clear;

  For intQuerie := Low(FQueryFiltros) To HiGh(FQueryFiltros) Do
  Begin
    Result := fGeraTitulosQuery(FQueryFiltros[intQuerie], lstListaParFiltros, blnFiltraImpFil);
    If Not Result Then
      Break;
  End;

  If Result Then
  For intQuerie := Low(FComFilFiltros) To HiGh(FComFilFiltros) Do
  Begin
    Result := fGeraTitulosQuery(FComFilFiltros[intQuerie], lstListaParFiltros, blnFiltraImpFil);
    If Not Result Then
      Break;
  End;

  lstListaParFiltros.Clear;
  FreeAndNil(lstListaParFiltros);
End;

Function TInterfaceRelatorio.fRetDestino: TDestinoRel;
  Var
    desIndice: TDestinoRel;
    strDestino: String;
Begin
  Result := desVideo;

  Try
    If blnImpressaoGrid Then
    Begin
      Result := desDestinoGrid;
      Exit;
    End;


    If Not Assigned(FFiltros) Then
      Result := fDestinoToTipo(FCadRel[0].FieldByName('REL_DESTIN').AsString);

    Try

      If Assigned(FFiltros) And (FIndexDestino < FFiltros.Rows.Count) And
        (Not TcxEditorRow(FFiltros.Rows[FIndexDestino]).IsCategory) Then
      With FFiltros Do
      Begin
        strDestino := TcxEditorRow(Rows[FIndexDestino]).Properties.Value;

        If (TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items.IndexOf(VarToStr(TcxEditorRow(Rows[FIndexDestino]).Properties.Value)) < 0) And
           (TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items.Count > 0) Then
             strDestino := TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items[0]
      End;

    Except
      Result := desVideo;
    End;

    For desIndice := Low(ArrDestino) To High(ArrDestino) Do
      If SameText(strDestino, String(ArrDestino[desIndice])) Then
      Begin
        Result := desIndice;
        Exit;
      End;

  Finally
    desDestinoInicial := Result;
  End;
End;

Class Function TInterfaceRelatorio.fDestinoToTipo(strDescricao: String): TDestinoRel;
  Var
    desIndice: TDestinoRel;
    strDestino: String;
    stlLista: TStringList;
Begin
  Result := desVideo;

  stlLista      := TStringList.Create;
  stlLista.Text := Trim(strDescricao);

  If stlLista.Count > 0 Then
    strDestino := stlLista[0]
  Else
    strDestino := '';

  For desIndice := Low(ArrDestino) To High(ArrDestino) Do
    If SameText(strDestino, String(ArrDestino[desIndice])) Then
    Begin
      Result := desIndice;
      Break;
    End;

  FreeAndNil(stlLista);
End;

Function TInterfaceRelatorio.fPastaSaida: String;
Begin
  Result := '';

  With FFiltros Do
  If (FIndexPasta > -1) And (TcxEditorRow(Rows[FIndexPasta]).Properties.Value <> Null) Then
    Result := TcxEditorRow(Rows[FIndexPasta]).Properties.Value;
End;

Function TInterfaceRelatorio.fImagemCabecalho: String;
Begin
  Result := '';

  With FFiltros Do
  If (FIndexImagemCabecalho > -1) And (TcxEditorRow(Rows[FIndexImagemCabecalho]).Properties.Value <> Null) Then
    Result := TcxEditorRow(Rows[FIndexImagemCabecalho]).Properties.Value;
End;

Function TInterfaceRelatorio.fMontaListaRel: String;
  Var
    stlCodRels: TStringList;
Begin
  stlCodRels := TStringList.Create;

  stlCodRels.Clear;
  stlCodRels.Add(FCadRel[0].FieldByName('REL_CODREL').AsString);

  With FComplementos Do
  Begin
    First;
    While Not Eof Do
    Begin
      stlCodRels.Add(FieldByName('REL_CODREL').AsString);
      Next;
    End;

    First;
  End;

  if not FChilds.IsEmpty then
  With FChilds Do
  Begin
    First;
    While Not Eof Do
    Begin
      stlCodRels.Add(FieldByName('REL_CODREL').AsString);
      Next;
    End;

    First;
  End;

  Result := stlCodRels.Text;

  FreeAndNil(stlCodRels);
End;

Function TInterfaceRelatorio.fRetColunasDados: Integer;
Begin
  Result := -1;

  If Assigned(FCadRel[0]) And
     SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'I') And
     Assigned(FHorizo[0]) And
     FHorizo[0].Active Then
   Result := FHorizo[0].Fields.Count;

End;

Function TInterfaceRelatorio.fGetDataSet(intQuerie: Integer): TDataSet;
Begin
  If Assigned(FCadRel[intQuerie]) And
     (SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S')  Or
      SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'I')) And
     Assigned(FHorizo[intQuerie]) Then
    Result := FHorizo[intQuerie]
  Else
    Result := FQueryDados[intQuerie];
End;

function TInterfaceRelatorio.fSetouNomeArquivo: Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  If Not Assigned(FSQLFormatado) Then
    Exit;

  If Length(FSQLFormatado) = 0 Then
    Exit;

  Result := Pos('@NOME_ARQUIVO', FSQLFormatado[Low(FSQLFormatado)]) > 0;

  If Result Then
  Begin
    intContador := 0;

    FComplementos.First;
    While Not FComplementos.Eof Do
    Begin
      Inc(intContador);

      If FComplementos.FieldByName('REL_NOVPAG').AsString = 'S' Then
      Begin
        Result := Pos('@NOME_ARQUIVO', FSQLFormatado[intContador]) > 0;

        If Not Result Then
        Begin
         pMensagemOk('Informe no SQL do Relatório complementar ' +  FComplementos.FieldByName('REL_CODREL').AsString +  ' o nome do arquivo ' + IIF(fRetDestino In [desTXT], 'TXT', 'CSV') + ': SET @NOME_ARQUIVO = ...;');
         Break;
        End;

      End Else
      Begin

        Result := Pos('@NOME_ARQUIVO', FSQLFormatado[intContador]) = 0;

        If Not Result Then
        Begin
         pMensagemOk('O Relatório complementar ' +  FComplementos.FieldByName('REL_CODREL').AsString +  ' não pode setar o nome do arquivo ' + IIF(fRetDestino In [desTXT], 'TXT', 'CSV') + '' + #13#10 +
                     'porque ele não é gerado em arquivo separado!');
         Break;
        End;

      End;

      FComplementos.Next;
    End;

    FComplementos.First;
  End

  Else
  Begin
    If fRetDestino In [desTXT] Then
      pMensagemOk('Informe no SQL o nome do arquivo TXT: SET @NOME_ARQUIVO = ...;')
    Else
      Result := True;
  End;
End;

Function TInterfaceRelatorio.fLeDados: Boolean;
var
  LfrmLeDados: TfrmGravando;
Begin
  Try

    If blnMostrarProgresso Then
    Begin

      pCriarFormularios(TfrmGravando, LfrmLeDados);
      try
        Result := LfrmLeDados.fExecuta(fLeDadosProgresso, FGravando);
      finally
        pFreeAndNil(LfrmLeDados);
      end;

      FGeraFr3.frmProgresso := Nil;

    End Else
    Begin
      FGeraFr3.frmProgresso := Nil;
      Result := fLeDadosProgresso(Nil);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TInterfaceRelatorio.fLeDados]');
    End;
  End;

  If Result And (fRetDestino = desTrace) Then
    pMensagemOk('Arquivos gerados com sucesso!');
End;

Function TInterfaceRelatorio.fLeDadosSQL: string;
Begin
  Try
    Result := fLeDadosProgressoSQL;
  Except
    On E: Exception Do
    Begin
      Result := E.Message;
    End;
  End;
End;

function TInterfaceRelatorio.fRetornaNomeArquivo(intQuerie: Integer = 0): String;
  Var
    qryNomArq: TUniQuery;
Begin
  qryNomArq := fCriaQueryRelarorio;
  qryNomArq.SQL.Text := 'SELECT IFNULL(@NOME_ARQUIVO, "ARQUIVO_REL.TXT") AS ARQSAI ';
  qryNomArq.Open;

  Result := '';

  If fRetDestino In [desCSV] Then
  Begin
    If Assigned(FSQLFormatado) Then
      If Length(FSQLFormatado) <> 0 Then
        Result := IIF(Pos('@NOME_ARQUIVO', FSQLFormatado[intQuerie]) > 0, qryNomArq.FieldByName('ARQSAI').AsString, '')
  End
  Else
    Result := qryNomArq.FieldByName('ARQSAI').AsString;

  FreeAndNil(qryNomArq);
End;

function TInterfaceRelatorio.fRetornaPontoImpressao(intQuerie: Integer = 0): String;
  Var
    qryNomArq: TUniQuery;
Begin
  qryNomArq := fCriaQueryRelarorio;
  qryNomArq.SQL.Text := 'SELECT IFNULL(@PONTO_IMPRESSAO_RELATORIO, "") AS PONIMP ';
  qryNomArq.Open;

  Result := '';

  If fRetDestino In [desCSV] Then
  Begin
    If Assigned(FSQLFormatado) Then
      If Length(FSQLFormatado) <> 0 Then
        Result := IIF(Pos('@PONTO_IMPRESSAO_RELATORIO', FSQLFormatado[intQuerie]) > 0, qryNomArq.FieldByName('PONIMP').AsString, '')
  End
  Else
    Result := qryNomArq.FieldByName('PONIMP').AsString;

  FreeAndNil(qryNomArq);
End;

function TInterfaceRelatorio.fRetornaGerarSeVazio: String;
  Var
    qryNomArq: TUniQuery;
Begin
  qryNomArq := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
  qryNomArq.SQL.Text := 'SELECT IFNULL(@GERAR_SE_VAZIO, "S") AS GERAR ';
  qryNomArq.Open;

  Result := qryNomArq.FieldByName('GERAR').AsString;

  FreeAndNil(qryNomArq);
End;

Procedure TInterfaceRelatorio.pSalvaTrace(qryDados: TUniQuery; strCodRel: String; strSetSQL: String = '');
 Var
   txtArquivo: TextFile;
Begin
  System.AssignFile(txtArquivo, FPastaDestino + 'TRACE_' + strCodRel + '.SQL');
  System.Rewrite(txtArquivo);
  System.Write(txtArquivo, AnsiReplaceStr(strSetSQL, ';', ';'+#13#10) + AnsiReplaceStr(TfrmSQLBind_Query.fBoundSQL(qryDados), ';', ';'+#13#10));
  System.CloseFile(txtArquivo);
End;

Function TInterfaceRelatorio.fExecutaThread(qryDados: TUniQuery; cdsDados: TUniClientDataSet;
                                            cxProgress : TcxProgressBar; blnExec: Boolean): Boolean;
  Var
    intPassos: Integer;
    objThread: TThreadRelatorio;
    strErroThread: String;
Begin
  objThread := TThreadRelatorio.Create(qryDados, cdsDados, blnExec);
  objThread.Start;

  intPassos := 1;
  While Not objThread.blnTerminou Do
  Begin
    If Assigned(FGravando) Then
      FGravando.lblGravando.Caption := strMensagem + ' ' + arrPassos[intPassos];

    Inc(intPassos);
    If intPassos = 5 Then
      intPassos := 1;

    Sleep(50);

    if not VS_AutcomIniciadoModoRobo then
      Application.ProcessMessages;
  End;

  Result := Not objThread.blnComErro;

  strErroThread := objThread.strMsgErro;

  FreeAndNil(objThread);

  pValidarConexaoRelatorio;

  If Not Result Then
    Raise Exception.Create(strErroThread);
End;

Function TInterfaceRelatorio.fLeDadosProgresso(Progress : TcxProgressBar): Boolean;
  Var
    intQuerie,
    intContador: Integer;

    blnTudoNulo,
    blnFaltaInformacao: Boolean;
    blnTraceExecutaSet: Boolean;
    strSQLFormatadoAux: String;
    strSetSQL: string;

//    trmIni: TTime;
Begin
  Try
    strMensagem := '';

    If blnImpressaoGrid Then
    Begin
      Result := True;
    End Else
    Begin
      blnTemDados := False;
      blnImprimirVazio := False;
      Result := False;
      blnExecutouSemErro := False;

      pLiberaArrRecSetSelect;

      If blnApagaTemporarias Then
        pDropTemporarias;

      FTabelasSaldos.Clear;

      stlArquivos.Clear;
      stlGerarSeVazio.Clear;
      SetLength(FArquivosPontoImpressao, 0);

      If Assigned(Progress) Then
      Begin
        Progress.Properties.Max := IIF(blnApenasPrincipal, 1, Length(FQueryDados));
        Progress.Position := 0;
      End;

      For intQuerie := Low(FQueryDados) To IIF(blnApenasPrincipal, Low(FQueryDados), HiGh(FQueryDados)) Do
      With FQueryDados[intQuerie] Do
      Begin
        If not blnImprimirVazio then
          blnImprimirVazio := FCadRel[intQuerie].FieldByName('REL_SEMDAD').AsString = 'S';

        strSQLFormatadoAux := FSQLFormatado[intQuerie];

        Result := fAbreTabelaSaldos(intQuerie, strSQLFormatadoAux);

        If Not Result Then
          Exit;

        If Assigned(FGravando) Then
        Begin
          FGravando.lblGravando.font.Name := 'Courier New';

          If blnValidacao Then
            FGravando.lblGravando.Caption := 'Validando dados...'

          Else If fRetDestino In [desTXT, desXML, desArquivoSaida] Then
            FGravando.lblGravando.Caption := 'Preparando dados para exportação...'
          Else
            FGravando.lblGravando.Caption := 'Preparando relatório...';

          strMensagem := FGravando.lblGravando.Caption;
        End;

        If (Assigned(Progress)) and (not VS_AutcomIniciadoModoRobo) Then
        Begin
          Progress.Visible   := Progress.Properties.Max > 1;
          Application.ProcessMessages;
        End;

        If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
        Begin
          Close;

          SQL.Clear;

          blnTraceExecutaSet := False; {vai salvar o trace sem as substituições do fExecutaSet}

          If (fRetDestino = desTrace) and Not blnTraceExecutaSet Then
            SQL.Text := fMontaSQLDados(strSQLFormatadoAux, FQueryFiltros[intQuerie], intQuerie)
          Else
          Begin
            strSetSQL := IIf(fRetDestino = desTrace, '', strSetSQL);
            SQL.Text := fExecutaSets(Progress, strSetSQL, fMontaSQLDados(strSQLFormatadoAux, FQueryFiltros[intQuerie], intQuerie), intQuerie);
          End;

          Result := Not FSQLErro;

          If Not Result Then
            Exit;

          Result := fSetaDadosQuery(FQueryDados[intQuerie], FQueryFiltros[intQuerie], False, blnFaltaInformacao);

          If Not Result Then
            Exit;

          pCriaClientDados(intQuerie);

          If blnConexaoIndependente And (fRetDestino <> desTrace) Then
          Begin
            fExecutaThread(FQueryDados[intQuerie], FClientDados[intQuerie], Progress, False{blnExec});
          End

          Else If fRetDestino = desTrace Then
          Begin
            pSalvaTrace(FQueryDados[intQuerie], FCadRel[intQuerie].FieldByName('REL_CODREL').AsString, IIf(blnTraceExecutaSet, strSetSQL, ''))
          End Else
          Begin
            FQueryDados[intQuerie].Open;

            If Assigned(FClientDados[intQuerie]) Then
            Begin
              pSetaClient(FQueryDados[intQuerie]);
              FClientDados[intQuerie].Open;
            End;
          End;

          stlArquivos.Add(fRetornaNomeArquivo(intQuerie));
          stlGerarSeVazio.Add(fRetornaGerarSeVazio);
          pAdicionaArquivoPontoImpressao(intQuerie);

          Result := True;

          If Not IsEmpty Then
          Begin

            If Assigned(FCadRel[intQuerie]) And
               (SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S')  Or
                SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'I')) Then
            Begin

              If SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'I') Then
                Result := fInverteConsultaLines(intQuerie, blnTudoNulo)
              Else
                Result := fInverteConsulta(intQuerie, blnTudoNulo);

              If Not blnTudoNulo Then
                blnTemDados := True;
            End

            Else blnTemDados := True;

            If Not Result Then
              Break;

          End Else
          Begin

            If Assigned(FCadRel[intQuerie]) Then
            Begin
              If (SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S')  Or
                  SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'I')) And
                Assigned(FHorizo[intQuerie]) Then
                  FHorizo[intQuerie].EmptyDataSet;
            End;

          End;

          If Assigned(FGravando) Then
          Begin

            If blnValidacao Then
              FGravando.lblGravando.Caption := 'Preparando validação...'
            Else
            Case fRetDestino Of
              desTXT: FGravando.lblGravando.Caption := 'Preparando registros do arquivo TXT...';
              desXML: FGravando.lblGravando.Caption := 'Preparando registros do arquivo XML...';
              Else    FGravando.lblGravando.Caption := 'Preparando relatório...';
            End;

          End;

          If (Assigned(Progress)) and (not VS_AutcomIniciadoModoRobo) Then
          Begin
            Progress.Position := Succ(intQuerie);
            Application.ProcessMessages;
          End;

          If (fRetDestino = desExcel) And (FQueryDados[intQuerie].RecordCount > 65000) Then
          Begin
            pMensagemOk('Não é possível gerar um excel para arquivos maiores que 65.000 linhas!');
            Result := False;
            Break;
          End;

        End
        Else If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') Then
        Begin
          FGeraFr3.pSetaTamanhoDados(Length(FTabelasTemporarias));

          Close;

          SQL.Clear;

          SQL.Text := fExecutaSets(Progress, strSetSQL, fMontaSQLDados(strSQLFormatadoAux, FQueryFiltros[intQuerie], intQuerie), intQuerie);

          Result := Not FSQLErro;

          If Not Result Then
            Exit;

          Result := fSetaDadosQuery(FQueryDados[intQuerie], FQueryFiltros[intQuerie], False, blnFaltaInformacao);

          If Not Result Then
            Exit;

          If blnConexaoIndependente Then
            fExecutaThread(FQueryDados[intQuerie], nil, Progress, True{blnExec})
          Else
          Begin
            FQueryDados[intQuerie].ExecSQL;
            FQueryDados[intQuerie].Close;
          End;

          {SetLength(FQueryDadosPersonalizado, 0);
          SetLength(FClientDadosPersonalizado, 0);
          SetLength(FProviderDadosPersonalizado, 0);}

          SetLength(FQueryDadosPersonalizado, Length(FTabelasTemporarias));
          SetLength(FClientDadosPersonalizado, Length(FTabelasTemporarias));
          SetLength(FProviderDadosPersonalizado, Length(FTabelasTemporarias));

          For intContador := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
          Begin
            FQueryDadosPersonalizado[intContador] := fCriaQuery(Self, FConexaoRelatorio.objConexao);
            FQueryDadosPersonalizado[intContador].SQL.Text := 'SELECT * FROM ' + FTabelasTemporarias[intContador].strNome_banco + ' WHERE TRUE ';

            pCriaClientDadosPersonalizado(intContador);

            If Assigned(FClientDadosPersonalizado[intContador]) Then
            Begin
              pSetaClient(FQueryDadosPersonalizado[intContador]);
              FClientDadosPersonalizado[intContador].Open;
            End;
          End;

          Result := True;
          blnTemDados := True;

        End;

      End; {For intQuerie := Low(FQueryDados) To HiGh(FQueryDados) Do}

    End; {If Not blnImpressaoGrid Then}

    if blnTemDados then
      blnImprimirVazio := False;

    If FExecutaPelaInterface And (fRetDestino <> desTrace) Then
    Begin
      If Result And ((Not blnTemDados) And (Not blnImprimirVazio)) and blnExibirMensagem Then
      Begin
        pMensagemOk(MSG_SEM_DADOS_PARA_GERAR_RELATORIO);
      End;

      blnExecutouSemErro := Result;

      Result := (blnTemDados Or blnImprimirVazio) And Result And fGeraTitulosFiltros;

      If Result Then
      Begin

        If Assigned(FGravando) Then
        Begin

          If blnValidacao Then
            FGravando.lblGravando.Caption := 'Criando páginas de validação...'
          Else
            Case fRetDestino Of
              desTXT: FGravando.lblGravando.Caption := 'Criando registros do arquivo TXT...';
              desXML: FGravando.lblGravando.Caption := 'Criando registros do arquivo XML...';
              Else    FGravando.lblGravando.Caption := 'Criando páginas...';
            End;

        End;

      End;

      If (Assigned(Progress)) and (not VS_AutcomIniciadoModoRobo) Then
      Begin
        Progress.Position := 0;
        Application.ProcessMessages;
      End;

      for intContador := Low(FControleRel) to High(FControleRel) do
        if FControleRel[intContador].blnChild then
          FControleRel[intContador].blnPrint := False;

      FGeraFr3.arrControleRel := FControleRel;

      FGeraFr3.frmProgresso := FGravando;

      FGeraFr3.desDestinoFr3 := fRetDestino;

      If Not FExecutarDireto Then
        FGeraFr3.strPatImgCab := fImagemCabecalho;


      Result := Result And (FFr3Gerado Or FGeraFr3.fGerarFr3(fMontaListaRel, objConsulta, True, fRetColunasDados, '', blnApenasPrincipal));
      blnRetornoDados := Result;
    End;

    If blnApagaTemporarias Then
      pDropTemporarias;

  Except
    On E: Exception Do
    Begin
      If blnApagaTemporarias Then
        pDropTemporarias;
      Result := False;
      pMensagemOk(E.Message);
      pGravaLogPaf('N', E.Message);
      pGravaLogExecucao(E.Message);
    End;
  End;

  pLiberaArrRecSetSelect;
End;

Function TInterfaceRelatorio.fLeDadosProgressoSQL: string;
  Var
    blnFaltaInformacao: Boolean;
    strSQLFormatadoAux: string;
    strSetSQL: string;
Begin
  Try
    Result := '';

    pLiberaArrRecSetSelect;

    If blnApagaTemporarias Then
      pDropTemporarias;

    FTabelasSaldos.Clear;

    With FQueryDados[0] Do
    Begin

      if not fEmptyStr(Result) then
        Exit;

      strSQLFormatadoAux := FSQLFormatado[0];

      If Not fAbreTabelaSaldos(0, strSQLFormatadoAux) Then
        Exit;

      Close;

      SQL.Clear;

      strSetSQL := '';

      SQL.Text := fMontaSQLDados(strSQLFormatadoAux, FQueryFiltros[0]);

      If FSQLErro Then
        Exit;

      If Not fSetaDadosQuery(FQueryDados[0], FQueryFiltros[0], False, blnFaltaInformacao) Then
        Exit;

      Result := strSetSQL + IIF(not fEmptyStr(strSetSQL), ' ', '') + fDevolveSQLExecucao(FQueryDados[0], SQL.Text);
    End;

    If blnApagaTemporarias Then
      pDropTemporarias;

  Except
    On E: Exception Do
    Begin
      If blnApagaTemporarias Then
        pDropTemporarias;
      Result := E.Message;
    End;
  End;

  pLiberaArrRecSetSelect;
End;

Function TInterfaceRelatorio.fVerificaRelatorioValidacao: Boolean;
  Var
    objRelatorio: TRelatorio;
    arrParametros: Array Of String;
    arrValores: Array Of String;
Begin
  Try
    Result := True;

    If Not FExecutaRelatorioValidacao Then
      Exit;

    If fEmptyStr(FCadRel[0].FieldByName('REL_CODVAL').AsString) Then
      Exit;

    If Not Assigned(FParamValidacao) Then
      Exit;

    pSalvaValores(fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [FCadRel[0].FieldByName('REL_CODVAL').AsString]), True);

    SetLength(arrParametros, 0);
    SetLength(arrValores, 0);

    objRelatorio := TRelatorio.Create(Nil, True, SameText(FCadRel[0].FieldByName('REL_CONIND').AsString, 'S'), FConexaoRelatorio);

    TRelatorio.fExecutaRelatorioCodigoRetorno(objRelatorio,
                                              FCadRel[0].FieldByName('REL_CODVAL').AsString,
                                              arrParametros,
                                              arrValores,
                                              Nil,   // arrParametrosReadOnly: TArrString = Nil;
                                              True,  // blnExecutarDireto: Boolean = False;
                                              False,  // blnExibeMensagem: Boolean =  True;
                                              '',    // strDirAce: String = '';
                                              True); // blnValidacao: Boolean = False

    Result := Result And
              objRelatorio.objInterface.blnExecutouSemErro And
              ((objRelatorio.objInterface.desDestinoInicial = desValidacao) Or (Not objRelatorio.objInterface.blnTemDados));

    FreeAndNil(objRelatorio);

  Except
    On E: Exception Do
    Begin
      Result := False;
    End;
  End;
End;

Function TInterfaceRelatorio.fPedePastaTrace: Boolean;
Begin
  Result := SelectDirectory('Pasta para a gravação do trace', '', FPastaDestino);

  If Result And (Not FPastaDestino.EndsWith('\')) Then
    FPastaDestino := Concat(FPastaDestino, '\');
End;

Function TInterfaceRelatorio.fExecutaRelatorio: Boolean;
  Var
    intQuerie: Integer;
Begin
  Try
    pValidarConexaoRelatorio;

    If (fRetDestino = desTrace) And (Not fPedePastaTrace) Then
    Begin
      Result := False;
      Exit;
    End;

    Screen.Cursor := crHourGlass;

    If blnImpressaoGrid Then
    Begin
      Result := True;

      For intQuerie := Low(FCadRel) To High(FCadRel) Do
        FQueryDados[intQuerie].DisableControls;

    End Else
      Result := Assigned(FGeraFr3) And fVerificaCampos;

    FGeraFr3.blnTemArquivoSaida := FCadRel[0].FieldByName('REL_ARQSAI').AsString = 'S';

    FGeraFr3.blnTemNumWppGat  := FCadRel[0].FieldByName('REL_GATWPP').AsString = 'S';
    FGeraFr3.blnTemEmailGat   := FCadRel[0].FieldByName('REL_GATEMA').AsString = 'S';
    FGeraFr3.blnTemAssuntoGat := FCadRel[0].FieldByName('REL_GATASS').AsString = 'S';
    FGeraFr3.blnTemCorpoGat   := FCadRel[0].FieldByName('REL_GATCOR').AsString = 'S';

    SetLength(FGeraFr3.FListaEnvioPDFGatilho, 0);

    If (fRetDestino In [desTXT, desXML, desCSV]) And (Not fSetouNomeArquivo) Then
    Begin
      Screen.Cursor := crDefault;
      Result := False;
      Exit;
    End;

    Result := Result And
              (blnImpressaoGrid Or fVerificaRelatorioValidacao) And
              fLeDados;

    If Result And (fRetDestino <> desTrace) Then
    Begin

      If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'N') Then
      Begin
        FGeraFr3.strTituloRelatorio := fUpper(FTitulo);
        FGeraFr3.strSubTituloRelatorio := fUpper(FSubTitulo);
        FGeraFr3.stlTituloFiltros   := FTituloFiltros;
        FGeraFr3.sltListaParFiltros := FListaParFiltros;

        FGeraFr3.pSetaTamanhoDados(Length(FCadRel));

        For intQuerie := Low(FCadRel) To High(FCadRel) Do
        Begin
          If Assigned(FCadRel[intQuerie]) And
             (SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'S')  Or
              SameText(FCadRel[intQuerie].FieldByName('REL_HORIZO').AsString, 'I')) And
             Assigned(FHorizo[intQuerie]) Then
            FGeraFr3.qryDados[intQuerie] := FHorizo[intQuerie]
          Else If Assigned(FClientDados[intQuerie]) Then
            FGeraFr3.qryDados[intQuerie] := FClientDados[intQuerie]
          Else
            FGeraFr3.qryDados[intQuerie] := FQueryDados[intQuerie];

          FGeraFr3.qryDadosOrig[intQuerie] := FQueryDados[intQuerie];
        End;

        FGeraFr3.qryFiltros := FQueryFiltros;

      End
      Else If (FCadRel[0].FieldByName('REL_FR3PER').AsString = 'S') Then
      Begin
        FGeraFr3.pSetaTamanhoDadosPersonalizado(Length(FTabelasTemporarias));

        For intQuerie := Low(FTabelasTemporarias) To High(FTabelasTemporarias) Do
        Begin
          FGeraFr3.qryDadosPersonalizado[intQuerie] := FClientDadosPersonalizado[intQuerie];
        End;

      End;

      Result := FGeraFr3.fExecutaRelatorio(FIdentRel, fPastaSaida, fRetDestino, blnApenasPrincipal, blnExibirMensagem);

      if Result then
        Self.strDadosJsonEnviaWhatsapp := FGeraFr3.fJSonWhatsApp(0);
    End;

    If blnImpressaoGrid Then
    Begin
      For intQuerie := Low(FCadRel) To High(FCadRel) Do
        FQueryDados[intQuerie].EnableControls;
    End;

    strFiltroGrid := '';

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagemOk(E.Message);
    End;
  End;

  Screen.Cursor := crDefault;
End;

Function TInterfaceRelatorio.fSalvarFiltrosRelatorio: Boolean;
var
  strAutInc: String;
Begin
  Result := False;
  Try
    Screen.Cursor := crHourGlass;
    Try
      If fVerificaCampos Then
      Begin
        strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [FCadRel[0].FieldByName('REL_CODREL').AsString]);
        pSalvaValores(strAutInc);
        Result := True;
      End;
    Finally
      Screen.Cursor := crDefault;
    End;
  Except
    On E: Exception Do
      pMensagemOk(E.Message);
  End;
End;

Procedure TInterfaceRelatorio.pLimpaMultiSelecao(rowFiltro: TcxCustomRow);
  Var rowDado: TcxEditorRow;
Begin
//  Quando o item já tem valor digitado nao pode perguntar
//     And fPergunta('Deseja limpar a multi-seleção?')

  If Assigned(rowFiltro) Then
  With rowFiltro Do
  Begin
    If (IsCategory) Then
      Exit;

    rowDado :=  TcxEditorRow(rowFiltro);

    With rowDado Do
    If ((Properties.Value = Null) Or fEmptyStr(fTiraCaracEspeciaisPonto(Properties.Value))) And
       fTemMultiSelecao(Name) Then
    Begin
      FValueParams.Edit;
      FValueParams.FieldByName('VALPAR').Clear;
      FValueParams.Post;

      If FValueParamsDisplayText.Locate('NOMPAR', FValueParams.FieldByName('NOMPAR').AsString, []) Then
      Begin
        FValueParamsDisplayText.Edit;
        FValueParamsDisplayText.FieldByName('VALPAR').Clear;
        FValueParamsDisplayText.Post;
      End;

    End;
  End;
End;

procedure TInterfaceRelatorio.pKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  Case Key Of
    VK_BACK,
    VK_DELETE: pLimpaMultiSelecao(FFiltros.FocusedRow);
  End;
end;

Procedure TInterfaceRelatorio.pKeyPress(Var Key: Char);
  Var
    strCodigos,
    strDesEdt: String;
    intContador: Integer;
Begin
  If Not fEntraCons(Key) Then
    Exit;

  If Not Assigned(FFiltros) Then
    Exit;

  If Not Assigned(FFiltros.FocusedRow) Then
    Exit;

  If FFiltros.FocusedRow.ClassNameIs('TcxCategoryRow') Then
    Exit;

  If Not Assigned(TcxEditorRow(FFiltros.FocusedRow).Properties) Then
    Exit;

  If Not Assigned(TcxTextEditProperties((TcxEditorRow(FFiltros.FocusedRow).Properties).EditProperties)) Then
    Exit;

  If (TcxTextEditProperties((TcxEditorRow(FFiltros.FocusedRow).Properties).EditProperties).EchoMode = eemPassword) Then
    Exit;

  If Not TcxEditorRow(FFiltros.FocusedRow).Properties.Options.Editing Then
    Exit;

  If FValueParams.Locate('NOMPAR', FFiltros.FocusedRow.Name, []) Then
  Begin

    If FParams.Locate('PAR_NOMPAR', FValueParams.FieldByName('NOMPAR').AsString, []) Then
    Begin

      If Not fEmptyStr(FParams.FieldByName('PAR_FILPES').AsString) Then
      Begin
        If Not FConsulta.fAvaliaExpressoesParametro(FParams.FieldByName('PAR_FILPES').AsString) Then
          Exit;

        FParams.Locate('PAR_NOMPAR', FValueParams.FieldByName('NOMPAR').AsString, []);
      End;

      If FConsulta.fPesqisaTabela(FParams.FieldByName('PAR_PESQUI').AsString,
                                  strCodigos, strDesEdt, frmPedeDados, Key,
                                  FParams.FieldByName('PAR_SIMPLE').AsString = 'S') Then
      Begin
        FValueParams.Edit;

        If Pos(' IN', strCodigos) > 0 Then
        Begin
          FValueParams.FieldByName('VALPAR').AsString := strCodigos;
        End Else
        Begin
          FValueParams.FieldByName('VALPAR').Clear;
          FValueParams.Post;

          Keybd_Event(vk_Home, 0, 0, 0);
          Application.ProcessMessages;

          If Assigned(FFiltros.InplaceEditor) Then
          Begin
            Try
              TcxCustomEdit(FFiltros.InplaceEditor).EditValue := strCodigos;
            Except
              Exit;//Access violation (fechando autcom) não conseguimos reproduzir
            End;
          End
          Else
            For intContador := 1 To Length(strCodigos) Do
            Begin
              Keybd_Event(Byte(strCodigos[intContador]), 0, 0, 0);
              Application.ProcessMessages;
            End;

          TcxEditorRow(FFiltros.FocusedRow).Properties.Value := strCodigos;

          FFiltros.Refresh;
        End;

        If Not (FValueParams.State In dsEditModes) Then
          FValueParams.Edit;

        FValueParams.FieldByName('DESEDT').AsString := strDesEdt;
        FValueParams.Post;

        If FValueParamsDisplayText.Locate('NOMPAR', FValueParams.FieldByName('NOMPAR').AsString, []) Then
        Begin
          FValueParamsDisplayText.Edit;
          FValueParamsDisplayText.FieldByName('VALPAR').Value := FValueParams.FieldByName('VALPAR').Value;
          FValueParamsDisplayText.FieldByName('DESEDT').Value := FValueParams.FieldByName('DESEDT').Value;
          FValueParamsDisplayText.Post;
        End;

        If Pos(' IN', strCodigos) > 0 Then
          TcxEditorRow(FFiltros.FocusedRow).Properties.Value := '';

          Key := #0;

          If FFiltros.FocusedRow = FFiltros.LastVisibleRow Then
          Begin
            pSetFocus(TfrmPedeDadosRelatorio(frmPedeDados).btnImprimir);
          End Else
          Begin
            FFiltros.NextRow(FFiltros.FocusedRow).Focused := True;
          End;

      End; {If FConsulta.fPesqisaTabela...}

    End; {If FParams.Locate('PAR_NOMPAR', FValueParams.FieldByName('NOMPAR').AsString, [])}

  End; {If FValueParams.Locate('NOMPAR', FFiltros.FocusedRow.Name, []) Then...}
End;

Function TInterfaceRelatorio.fValidaDado(intIndex: Integer): Boolean;
Begin
  Result := True;

  If ((TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value = Null) Or
      (TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value = '')) And
      (TcxEditorRow(FFiltros.Rows[intIndex]).Visible) And
     (Not fTemMultiSelecao(TcxEditorRow(FFiltros.Rows[intIndex]).Name)) Then
  Begin

    If (intIndex < FFiltros.Rows.Count) And
       (
         (FParams.Locate('PAR_NOMPAR', FFiltros.Rows[intIndex].Name, []) And
          (SameText(FParams.FieldByName('PAR_OBRIGA').AsString, 'S') Or
          (TcxTextEditProperties((TcxEditorRow(FFiltros.Rows[intIndex]).Properties).EditProperties).EchoMode = eemPassword))) Or

          ((intIndex = FIndexPasta) And (fRetDestino In [desTXT, desXML, desArquivoSaida])) Or

          ((SameText(FFiltros.Rows[intIndex].Name, STR_PAGINA_INICIAL)) And (SameText(FCadRel[0].FieldByName('REL_PGRCPE').AsString, 'N')))) Then

    Begin
      pMensagemOk('Informe um valor para "' +  TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Caption + '" !');
      Result := False;
      Exit;
    End;

  End;

  If (intIndex = FIndexPasta) And
     (fRetDestino In [desTXT, desXML, desPDF, desCSV, desArquivoSaida]) And
     (Not DirectoryExists(VarToStr(TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value))) Then
  Begin
    pMensagemOk('Pasta "' + VarToStr(TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value) + '" não encontrada!');
    Result := False;
  End;

  If (intIndex = FIndexImagemCabecalho) And
     (Not fEmptyStr(VarToStr(TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value))) And
     (Not FileExists(VarToStr(TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value))) Then
  Begin
    pMensagemOk('Arquivo "' + VarToStr(TcxEditorRow(FFiltros.Rows[intIndex]).Properties.Value) + '" não encontrado!');
    Result := False;
  End;
End;

Function TInterfaceRelatorio.fVerificaCampos: Boolean;
  Var
    intIndex: Integer;
Begin
  Result := True;

  For intIndex := 0 To FFiltros.Rows.Count - 1 Do
    If (Not FFiltros.Rows[intIndex].IsCategory) And
       (Not fValidaDado(intIndex)) Then
    Begin
      pSetFocus(TfrmPedeDadosRelatorio(frmPedeDados).cxvFiltros);
      FFiltros.Rows[intIndex].Focused := True;
      Result := False;

      Break;
    End;
End;

function TInterfaceRelatorio.fVerificaDashboarQuebra(blnDestinoDashboard: Boolean): Boolean;
var
  FCamposPes: TUniClientDataSet;
begin
  if (not blnDestinoDashboard) then
    Exit(True);

  Try

    Try
      Result := False;

      FCamposPes := TUniClientDataSet.Create(Self);
      FCamposPes.Data := Self.cdsCampos.Data;

      FCamposPes.Filtered := False;
      FCamposPes.Filter := 'CAM_QUEBRA = ' + QuotedStr('S');
      FCamposPes.Filtered := True;

      if (FCamposPes.RecordCount > 1) then
      begin
        pMensagemOk('Ja existe uma quebra para a Grid atual');
        Result := False;
      end
      else
        Result := True;

    Except
      Result := False;
    End;

  Finally
    FreeAndNil(FCamposPes);
  End;
end;

Function TInterfaceRelatorio.fValidaDia(strDia: String): Boolean;
Begin
  strDia := strDia + '/2020';
  Result := StrToDateDef(strDia, 0) > 0;
End;

Function TInterfaceRelatorio.fValidaMes(Var strMes: String): Boolean;
  Var
    strData: String;
Begin
  If Pos('/', strMes) > 0 Then
  Begin
    strData := Trim(fTiraCaracEspeciais(Copy(strMes, Succ(Pos('/', strMes)), 4)));

    If Length(strData) = 2 Then
      strData := LeftStr(FormatDateTime('YYYY', VS_Date) , 2) + strData

    Else If Length(strData) = 0 Then
      strData := FormatDateTime('YYYY', VS_Date);

    strMes := LeftStr(strMes, 2) + '/' + strData;
  End;

  Result := StrToDateDef('01/' + strMes, 0) > 0;
End;

procedure TInterfaceRelatorio.pFiltrosButtonClick(Sender: TObject; AButtonIndex: Integer = 0);
var
  charKey: Char;
begin
  charKey := '/';
  pKeyPress(charKey);
end;

procedure TInterfaceRelatorio.pFiltrosValidate(Sender: TObject; var DisplayValue: Variant;
    var ErrorText: TCaption; var Error: Boolean);
  Var
    strCodOpe,
    strDado: String;
begin
  inherited;

  If Assigned(frmPedeDados) And TfrmPedeDadosRelatorio(frmPedeDados).btnSair.Focused Then
  Begin
    ErrorText := '';
    Error := False;
    FFiltros.CancelEdit;
    Abort;
  End;

  If Error Then
    ErrorText := '';

  // LIMPANDO A MULTI-SELECAO
  If (DisplayValue = Null) Or (Not fEmptyStr(fTiraCaracEspeciaisPonto(DisplayValue))) Then
  Begin
    If FValueParams.Locate('NOMPAR', FFiltros.FocusedRow.Name, []) Then
    Begin
      FValueParams.Edit;
      FValueParams.FieldByName('VALPAR').Clear;
      FValueParams.Post;

      If FValueParamsDisplayText.Locate('NOMPAR', FFiltros.FocusedRow.Name, []) Then
      Begin
        FValueParamsDisplayText.Edit;
        FValueParamsDisplayText.FieldByName('VALPAR').Clear;
        FValueParamsDisplayText.Post;
      End;
    End;
  End;

  // VALIDANDO DADO DE CADASTRO
  If (DisplayValue <> Null) And (Not fEmptyStr(fTiraCaracEspeciaisPonto(DisplayValue))) Then
  Begin

    If SameText(TcxEditorRow(FFiltros.FocusedRow).Properties.EditPropertiesClassName, 'TcxTextEditProperties') And
       (TcxTextEditProperties(TcxEditorRow(FFiltros.FocusedRow).Properties.EditProperties).MaxLength > 0) And
       FParams.Locate('PAR_NOMPAR', FFiltros.FocusedRow.Name, []) And (Not fEmptyStr(FParams.FieldByName('PAR_PESQUI').AsString)) Then
    Begin

      If (TcxTextEditProperties(TcxEditorRow(FFiltros.FocusedRow).Properties.EditProperties).EchoMode = eemPassword) Then
      Begin
        strCodOpe := fRetCodVendedor(DisplayValue);

        If fEmptyStr(strCodOpe) Then
        Begin
          pMensagemOk('Operador não encontrado!');
          Error := True;
          ErrorText := '';
        End;

      End Else
      Begin
        DisplayValue := fStrZero(String(DisplayValue), TcxTextEditProperties(TcxEditorRow(FFiltros.FocusedRow).Properties.EditProperties).MaxLength);

        If fEmptyStr({TConsultasRel}FConsulta.fRetDescricao(DisplayValue, FParams.FieldByName('PAR_PESQUI').AsString, False, FParams.FieldByName('PAR_FILPES').AsString)) Then
        Begin
          DisplayValue := IIF((FConsulta.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString) In [pesEmpresa, pesPortador, pesOperador]), '', DisplayValue);
          pMensagemOk(TcxEditorRow(FFiltros.FocusedRow).Properties.Caption + ' não encontrado(a)!');
          Error := True;
          ErrorText := '';
        End;
      End;

    End;

    If (TcxTextEditProperties(TcxEditorRow(FFiltros.FocusedRow).Properties.EditProperties).MaxLength > 0) And
       FParams.Locate('PAR_NOMPAR', FFiltros.FocusedRow.Name, []) And
       (fGetTipoInterface(FParams.FieldByName('PAR_TIPPAR').AsString) = facDocumento) Then
    Begin
      DisplayValue := fStrZero(String(DisplayValue), TcxTextEditProperties(TcxEditorRow(FFiltros.FocusedRow).Properties.EditProperties).MaxLength);
    End;

    If SameText(TcxEditorRow(FFiltros.FocusedRow).Properties.EditPropertiesClassName, 'TcxDateEditProperties') And
       (StrToDateDef(DisplayValue, VS_Date) < IncYear(VS_Date, -1)) And
       Not fPergunta('Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?') Then
    Begin
      Error := True;
      ErrorText := '';
      Exit;
    End;

    If SameText(TcxEditorRow(FFiltros.FocusedRow).Properties.EditPropertiesClassName, 'TcxMaskEditProperties') And
       FParams.Locate('PAR_NOMPAR', FFiltros.FocusedRow.Name, []) And (Not fEmptyStr(FParams.FieldByName('PAR_PESQUI').AsString)) Then
    Begin
      If fEmptyStr({TConsultasRel}FConsulta.fRetDescricao(fTiraCaracEspeciaisPonto(DisplayValue), FParams.FieldByName('PAR_PESQUI').AsString, False, FParams.FieldByName('PAR_FILPES').AsString)) Then
      Begin
        DisplayValue := IIF((FConsulta.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString) In [pesEmpresa, pesPortador, pesOperador]), '', DisplayValue);
        pMensagemOk(TcxEditorRow(FFiltros.FocusedRow).Properties.Caption + ' não encontrado(a)!');
        Error := True;
        ErrorText := '';
      End;
    End;

    If SameText(TcxEditorRow(FFiltros.FocusedRow).Properties.EditPropertiesClassName, 'TcxMaskEditProperties') And
       FParams.Locate('PAR_NOMPAR', FFiltros.FocusedRow.Name, []) Then
    Begin

      Case fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) Of
        facDiaMes: Begin
                     Error := Not fValidaDia(DisplayValue);
                     ErrorText := '';
                     If Error Then
                       pMensagemOk('Dia inválido');
                   End;

        facMesAno: Begin
                     strDado := DisplayValue;
                     Error := Not fValidaMes(strDado);

                     If Not Error Then
                       DisplayValue := strDado;

                     ErrorText := '';
                     If Error Then
                       pMensagemOk('Mês inválido');
                   End;
      End

    End;


  End;

end;

Function TInterfaceRelatorio.fCriaValueParams: Boolean;
Begin
  Result := FValueParams.fAbreClient(True, 'TInterfaceRelatorio.fCriaValueParams') And
            FValueParamsDisplayText.fAbreClient(True, 'TInterfaceRelatorio.fCriaValueParams');

  If Not Result Then
    Exit;

  With FParams Do
  Begin
    First;

    While Not Eof Do
    Begin

      FValueParams.Insert;
      FValueParams.FieldByName('NOMPAR').AsString := FieldByName('PAR_NOMPAR').AsString;
      FValueParams.Post;

      FValueParamsDisplayText.Insert;
      FValueParamsDisplayText.FieldByName('NOMPAR').AsString := FieldByName('PAR_NOMPAR').AsString;
      FValueParamsDisplayText.Post;

      Next;
    End;
  End;

End;

Procedure TInterfaceRelatorio.pPedeDadosInterface;
  Var
    prcAfterPost: TAfterPost;
    strTmpExpVis,
    strTmpExpImp,
    strTmpSqlVis,
    strTmpSqlChk,
    strTmpFilPes: string;
    dssState: TDataSetState;
Begin
  If cdsParams.IsEmpty Then
    Exit;

  prcAfterPost := cdsParams.AfterPost;

  Try
    cdsParams.AfterPost := Nil;

    FParamsCopia.Data := cdsParams.Data;

    pCriarFormularios(TfrmPedeDadosInterface, frmPedeDadosInterface);

    With frmPedeDadosInterface Do
    Begin
      dbeTipFac.Items.Text := fRetDescricaoInterface;
      dbeTipCfg.Items.Text := fRetDescricaoConfig;
      dbeTipPar.Items.Text := fRetDescricaoParametros;
      dbePesqui.Items.Text := TConsultasRel.fRetDescPesquisas;

      dtsCadPar.DataSet := Self.cdsParams;

      Self.cdsParams.Edit;

      objInterface := Self;

      strTmpExpVis := Self.cdsParams.FieldByName('PAR_EXPVIS').AsString;
      strTmpExpImp := Self.cdsParams.FieldByName('PAR_EXPIMP').AsString;
      strTmpSqlVis := Self.cdsParams.FieldByName('PAR_SQLVIS').AsString;
      strTmpSqlChk := Self.cdsParams.FieldByName('PAR_SQLCHK').AsString;
      strTmpFilPes := Self.cdsParams.FieldByName('PAR_FILPES').AsString;

      dssState := Self.cdsParams.State;

      If ShowModal = mrOk Then
      Begin

        case dssState of
          dsBrowse : Self.cdsParams.Cancel;
          dsEdit   : Self.cdsParams.Edit;
          dsInsert : Self.cdsParams.Insert;
        end;

        Self.cdsParams.FieldByName('PAR_CNDVIS').AsString := '';

        if Self.cdsParams.FieldByName('PAR_SQLVIS').AsString <> '' then
          Self.cdsParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        if Self.cdsParams.FieldByName('PAR_EXPVIS').AsString <> '' then
          Self.cdsParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        if Self.cdsParams.FieldByName('PAR_EXPIMP').AsString <> '' then
          Self.cdsParams.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

        Self.cdsParams.FieldByName('IMPFIL').AsInteger := 1;

        Self.cdsParams.Post;
      End
      Else
      Begin
        Self.cdsParams.Cancel;
        // Corrigindo eventual expressão que ficou salva quando passou pelo fTrocaBrancoNomeColunaCheckList
        // Pois a validação da expressão ocorre depois que essa função já deu Post no FParams ao aplicar o Filtered
        // Então quando fecha e abre novamente, a expressão inválida acusada estará preenchida como se não tivesse sido validada
        if not fCompilaExpressao(dbeExpVis.Text, '', True, True) then
        begin
          // Voltando valor antigo da empressão que foi validada mas salva indevidamente antes da validação
          Self.cdsParams.Edit;
          Self.cdsParams.FieldByName('PAR_EXPVIS').AsString := strTmpExpVis;
          Self.cdsParams.FieldByName('PAR_EXPIMP').AsString := strTmpExpImp;
          Self.cdsParams.FieldByName('PAR_SQLVIS').AsString := strTmpSqlVis;
          Self.cdsParams.FieldByName('PAR_SQLCHK').AsString := strTmpSqlChk;
          Self.cdsParams.FieldByName('PAR_FILPES').AsString := strTmpFilPes;
          Self.cdsParams.Post;
        end;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TInterfaceRelatorio.pPedeDadosInterface]');
    End;
  End;

  cdsParams.AfterPost := prcAfterPost;

  pFreeAndNil(frmPedeDadosInterface);
End;

Class Function TInterfaceRelatorio.fDescFuncaoToTipo(strFuncao: String): TFuncaoAutcom;
  Var
    funContador: TFuncaoAutcom;
Begin
  Result := funVazio;

  For funContador := Low(ArrDesFuncao) To High(ArrDesFuncao) Do
    If SameText(ArrDesFuncao[funContador], strFuncao) Then
    Begin
      Result := funContador;
      Exit;
    End;
End;

Procedure TInterfaceRelatorio.pCarregaParametrosFuncao(strFuncao: String);
  Var
    stlLista: TStringList;
    intContador: Integer;
    funFuncao: TFuncaoAutcom;
Begin
  If FCampos.IsEmpty Then
    Exit;

  With FParamFuncao Do
  If fAbreClient(True, 'TInterfaceRelatorio.pCarregaParametrosFuncao') Then
  Begin
    EmptyDataSet;

    funFuncao := fDescFuncaoToTipo(strFuncao);

    If funFuncao <> funVazio Then
    Begin
      stlLista := TStringList.Create;
      stlLista.Text := ArrDesParametrosFuncao[funFuncao];

      For intContador := 0 To stlLista.Count - 1 Do
      Begin
        Append;
        FieldByName('NOMPAR').AsString := stlLista[intContador];
        Post;
      End;

      First;

      stlLista.Text := FCampos.FieldByName('CAM_PARAME').AsString;

      For intContador := 0 To stlLista.Count - 1 Do
      Begin
        Edit;
        FieldByName('VALPAR').AsString := stlLista[intContador];
        Post;

        Next;

        If Eof Then
          Break;
      End;

      FreeAndNil(stlLista);
    End;
  End;
End;

Procedure TInterfaceRelatorio.pRetornaParametrosFuncao;
  Var
    stlLista: TStringList;
Begin
  If FCampos.IsEmpty Then
    Exit;

  If Not (FCampos.State In dsEditModes) Then
    Exit;

  stlLista := TStringList.Create;

  With FParamFuncao Do
  Begin
    First;

    While Not Eof Do
    Begin
      stlLista.Add(FieldByName('VALPAR').AsString);

      Next;
    End;
  End;

  FCampos.FieldByName('CAM_CNDVIS').AsString := '';

  if FCampos.FieldByName('CAM_EXPVIS').AsString <> '' then
    FCampos.FieldByName('CAM_CNDVIS').AsString  := 'Sim';

  if FCampos.FieldByName('CAM_QUAQUE').AsString <> '' then
    FCampos.FieldByName('CAM_CNDVIS').AsString  := 'Sim';

  FCampos.FieldByName('CAM_PARAME').AsString := stlLista.Text;

  FreeAndNil(stlLista);
End;

Function TInterfaceRelatorio.fVerificaParametrosFuncoes: Boolean;
  Var
    stlLisPar,
    stlLisVal: TStringList;
    funFuncao: TFuncaoAutcom;
    intIndex,
    intContador: Integer;
    prcAfterPost: TAfterPost;
Begin
  Result := True;

  stlLisPar := TStringList.Create;
  stlLisVal := TStringList.Create;

  With FCampos do
  Begin
    prcAfterPost := FCampos.AfterPost;
    FCampos.AfterPost := Nil;

    First;

    While Not Eof Do
    Begin

      funFuncao := fDescFuncaoToTipo(FieldByName('CAM_FUNCAO').AsString);

      If funFuncao <> funVazio Then
      Begin
        stlLisPar.Text := ArrDesParametrosFuncao[funFuncao];
        stlLisVal.Text := FieldByName('CAM_PARAME').AsString;

        If stlLisPar.Count <> stlLisVal.Count Then
        Begin
          Edit;
          FieldByName('CAM_PARAME').Clear;
          Post;

          Result := False;
          Exit;
        End;

        For intContador := 0 To stlLisVal.Count - 1 Do
        Begin

          If Not FListaCampos.Find(stlLisVal[intContador], intIndex) Then
          Begin
            Edit;
            FieldByName('CAM_PARAME').Clear;
            Post;

            Result := False;
            Exit;
          End;

        End;
      End;

      Next;
    End;

    FCampos.AfterPost := prcAfterPost;
  End;
End;

Procedure TInterfaceRelatorio.pPedeDadosCampo(blnDestinoDashboard: Boolean);
Begin
  If cdsCampos.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmPedeDadosCampo, frmPedeDadosCampo);

  With frmPedeDadosCampo Do
  Begin
    grbQuebra.Visible := Not blnDestinoDashboard;
    pnlGrafico.Visible := Not blnDestinoDashboard;

    dbeFuncao.Items.Text := fRetDescricaoFuncoes;
    dbeVisibi.Items.Text := TInterfaceRelatorio.fRetDescricaoVisibilidade;

    FCamposCopia.Data := Self.cdsCampos.Data;
    FdtsCamposAprove.DataSet := FCamposCopia;
    dbeAprove.ListSource := FdtsCamposAprove;
    dbeLegRef.ListSource := FdtsCamposAprove;

    dtsCadCam.DataSet := Self.cdsCampos;

    objInterface := Self;

    pCarregaCamposFonte;

    Self.cdsCampos.Edit;

    If fEmptyStr(Self.cdsCampos.FieldByName('CAM_VISIBI').AsString) Then
      Self.cdsCampos.FieldByName('CAM_VISIBI').AsString := ArrDesVisibilidade[visSempre];

    TcxCustomComboBoxProperties(cxvParametrosVALPAR.Properties).Items.Text := FListaCampos.Text;

    cxlPesGri.Properties.ListSource := objConsultasGrid.dtsSource;
    cxvParametrosConsulta.DataController.DataSource := objConsultasGrid.cdsConsultasGrid.dtsSource;

    TcxLookupComboBoxProperties(cxvParametrosTIPATR.Properties).ListSource := objRotinasGrid.objMapeiaParametros.cdsTipoAtribuicao.dtsSource;
    TcxLookupComboBoxProperties(cxvParametrosPARPAI.Properties).ListSource := cdsParams.dtsSource;
    TcxLookupComboBoxProperties(cxvParametrosNOMCAM.Properties).ListSource := FdtsCamposAprove;

    cxvParametros.DataController.DataSource := FParamFuncao.dtsSource;

    pCarregaParametrosFuncao(cdsCampos.FieldByName('CAM_FUNCAO').AsString);

    If ShowModal = mrOk Then
    Begin

      pRetornaParametrosFuncao;
      Self.cdsCampos.Post;

    End Else
    Begin

      Self.cdsCampos.Cancel;

    End;

  End;

  pFreeAndNil(frmPedeDadosCampo);
End;

Function TInterfaceRelatorio.fGetAlturaTela: Integer;
Begin
  If Assigned(objRelatorioRetorno) And objRelatorioRetorno.blnExecutandoPeloBotao And
    (objRelatorioRetorno.intAlturaTela > 0) Then
  Begin

    Result := objRelatorioRetorno.intAlturaTela;

  End Else
  Begin
    If Assigned(FCadRel[0]) Then
      Result := FCadRel[0].FieldByName('REL_ALTTEL').AsInteger
    Else
      Result := 0;
  End;
End;

Function TInterfaceRelatorio.fGetLarguraTela: Integer;
Begin
  If Assigned(objRelatorioRetorno) And objRelatorioRetorno.blnExecutandoPeloBotao And
    (objRelatorioRetorno.intLarguraTela > 0) Then
  Begin

    Result := objRelatorioRetorno.intLarguraTela;

  End Else
  Begin
    If Assigned(FCadRel[0]) Then
      Result := FCadRel[0].FieldByName('REL_LARTEL').AsInteger
    Else
      Result := 0;
  End;
End;

Function TInterfaceRelatorio.fGetAlturaGrid: Integer;
Begin
  If Assigned(FCadRel[0]) Then
    Result := FCadRel[0].FieldByName('REL_ALTGRI').AsInteger
  Else
    Result := 0;
End;

Function TInterfaceRelatorio.fGetLarguraGrid: Integer;
Begin
  If Assigned(FCadRel[0]) Then
    Result := FCadRel[0].FieldByName('REL_LARGRI').AsInteger
  Else
    Result := 0;
End;

Function TInterfaceRelatorio.fGetValueWidth: Integer;
Begin
  If Assigned(FCadRel[0]) Then
    Result := FCadRel[0].FieldByName('REL_VALWID').AsInteger
  Else
    Result := 0;
End;

Function TInterfaceRelatorio.fGetRowHeaderWidth: Integer;
Begin
  If Assigned(FCadRel[0]) Then
    Result := FCadRel[0].FieldByName('REL_HEAWID').AsInteger
  Else
    Result := 0;
End;

Procedure TInterfaceRelatorio.pSetValueWidth(Value: Integer);
Begin
  If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_VALWID').AsInteger := Value;
End;

Procedure TInterfaceRelatorio.pSetRowHeaderWidth(Value: Integer);
Begin
  If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_HEAWID').AsInteger := Value;
End;

Procedure TInterfaceRelatorio.pSetAlturaTela(Value: Integer);
Begin
  If Assigned(objRelatorioRetorno) And objRelatorioRetorno.blnExecutandoPeloBotao Then
    objRelatorioRetorno.intAlturaTela := Value

  Else If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_ALTTEL').AsInteger := Value;
End;

Procedure TInterfaceRelatorio.pSetLarguraTela(Value: Integer);
Begin
  If Assigned(objRelatorioRetorno) And objRelatorioRetorno.blnExecutandoPeloBotao Then
    objRelatorioRetorno.intLarguraTela := Value

  Else If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_LARTEL').AsInteger := Value;
End;

Procedure TInterfaceRelatorio.pSetAlturaGrid(Value: Integer);
Begin
  If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_ALTGRI').AsInteger := Value;
End;

Procedure TInterfaceRelatorio.pSetLarguraGrid(Value: Integer);
Begin
  If Assigned(FCadRel[0]) And (FCadRel[0].State In [dsEdit, dsInsert]) Then
    FCadRel[0].FieldByName('REL_LARGRI').AsInteger := Value;
End;


Class Function TInterfaceRelatorio.fParametroBasico(strTipPar: String): Boolean;
  Var
    facContador: TTipoInterface;
Begin
  Result := False;
  For facContador := Low(ArrDesParametro) To High(ArrDesParametro) Do
    If SameText(strTipPar, String(ArrDesParametro[facContador])) Then
    Begin
      Result := True;
      Exit;
    End;
End;

Procedure TInterfaceRelatorio.pAjustaTipoDeInterface;
Begin
  If FParams.IsEmpty Then
    Exit;

  If Not (FParams.State In dsEditModes) Then
    FParams.Edit;

  If fParametroBasico(FParams.FieldByName('PAR_TIPFAC').AsString) Then
    FParams.FieldByName('PAR_TIPPAR').AsString := FParams.FieldByName('PAR_TIPFAC').AsString;
End;

Class Function TInterfaceRelatorio.fDescMascaraToTipo(strMascara: String): TMascara;
  Var
    masIndide: TMascara;
Begin
  Result := masVazio;

  For masIndide := Low(ArrDesMascara) To High(ArrDesMascara) Do
    If SameText(ArrDesMascara[masIndide], strMascara) Then
    Begin
      Result := masIndide;
      Exit;
    End;
End;

procedure TInterfaceRelatorio.pGetDisplayText(Sender: TcxCustomEditorRowProperties; ARecord: Integer; var AText: string);
  Var
    strTexto,
    strDescricao,
    strCodigo: String;
begin
  inherited;

  If sender.Row.IsCategory Then
    Exit;

  If (sender.Row.AbsoluteIndex < FFiltros.Rows.Count -1) And
     (Not fEmptyStr(TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Name)) And
     fTemMultiSelecaoDisplayText(TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Name) Then
       AText := '+1'

  Else
  Begin
    strTexto := AText;

    If (Not strTexto.IsEmpty) And (Not (TConsultasRel.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString) In [pesLote])) Then
      strTexto := fTiraCaracEspeciaisPonto(AText);

    If (Not fEmptyStr(strTexto)) And
         FParams.Locate('PAR_NOMPAR', TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Name, []) And
         (Not fEmptyStr(FParams.FieldByName('PAR_PESQUI').AsString)) Then
    Begin
      If (TcxTextEditProperties(TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Properties.EditProperties).EchoMode = eemPassword) Then
        AText := fRetCodVendedor(TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Properties.Value);

      If SameText(TcxEditorRow(FFiltros.Rows[sender.Row.AbsoluteIndex]).Properties.EditPropertiesClassName, 'TcxMaskEditProperties') Then
        strCodigo := strTexto
      Else
        strCodigo := AText;

      strDescricao := FConsulta.fRetDescricao(strCodigo, FParams.FieldByName('PAR_PESQUI').AsString, True, FParams.FieldByName('PAR_FILPES').AsString);

      If Not fEmptyStr(strDescricao) Then
        AText := AText + ' - ' + strDescricao;
   End;

  End;
end;

Class Function TInterfaceRelatorio.fSQLInsertCadVal(intContador: Integer; strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO ' + strTabela + ' ';
  strSQL := strSQL + ' (VAL_SEQGER, VAL_NOMPAR, VAL_CODOPE, VAL_ULTVAL, VAL_MULSEL) VALUES ';
  strSQL := strSQL + ' (:SEQGER'+IntToStr(intcontador)   ;
  strSQL := strSQL + ', :NOMPAR'+IntToStr(intcontador)   ;
  strSQL := strSQL + ', :CODOPE'+IntToStr(intcontador)   ;
  strSQL := strSQL + ', :ULTVAL'+IntToStr(intcontador)   ;
  strSQL := strSQL + ', :MULSEL'+IntToStr(intcontador)+'); ';

  Result := strSQL;
End;

Class Function TInterfaceRelatorio.fSQLUpdateCadVal(intContador: Integer; strTabela: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE ' + strTabela + ' SET ';
  strSQL := strSQL + '   VAL_ULTVAL = :ULTVAL'+IntToStr(intcontador) + ', ';
  strSQL := strSQL + '   VAL_MULSEL = :MULSEL'+IntToStr(intcontador);
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       VAL_SEQGER = :SEQGER'+IntToStr(intcontador);
  strSQL := strSQL + '   AND VAL_NOMPAR = :NOMPAR'+IntToStr(intcontador);
  strSQL := strSQL + '   AND VAL_CODOPE = :CODOPE'+IntToStr(intcontador) + '; ';
  Result := strSQL;
End;

Class Function TInterfaceRelatorio.fExisteCadVal(strSeqGer, strNomPar, strCodOpe, strTabela: String): Boolean;
  Var
    strSQL: String;
    qryCadVal: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTD FROM ' + strTabela;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       VAL_SEQGER = :SEQGER ';
  strSQL := strSQL + '   AND VAL_NOMPAR = :NOMPAR ';
  strSQL := strSQL + '   AND VAL_CODOPE = :CODOPE ';

  qryCadVal := fCriaQuery;
  qryCadVal.SQL.Text := strSQL;
  qryCadVal.ParamByName('SEQGER').AsString := strSeqGer;
  qryCadVal.ParamByName('NOMPAR').AsString := strNomPar;
  qryCadVal.ParamByName('CODOPE').AsString := strCodOpe;
  qryCadVal.Open;

  Result := qryCadVal.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryCadVal);
End;

procedure TInterfaceRelatorio.pExportaFiltros;
  Var
    intContador: Integer;
    strValPar: String;
    objArquivo: TJSONObject;
    objValor: TJSONObject;
    objValores: TJSONArray;
    dlgOpen: TOpenDialog;
    sltLista: TStringList;
Begin
  Try
    objArquivo := TJSONObject.Create;
    objArquivo.AddPair('codigoRelatorio', FCadRel[0].FieldByName('REL_CODREL').AsString);

    objValores := TJSONArray.Create;

    For intContador := 0 To FFiltros.Rows.Count - 1 do
    If Not FFiltros.Rows[intContador].IsCategory Then
    Begin
      objValor := TJSONObject.Create;
      objValor.AddPair('NOMPAR', TcxEditorRow(FFiltros.Rows[intContador]).Name);

      If fTemMultiSelecao(TcxEditorRow(FFiltros.Rows[intContador]).Name) Then
      Begin
        objValor.AddPair('MULSEL', 'S');

        strValPar := FValueParams.FieldByName('VALPAR').AsString;
        Delete(strValPar, 1, Length(' IN ('));
        strValPar := LeftStr(strValPar, Length(strValPar) -1);

        If FParams.Locate('PAR_NOMPAR', TcxEditorRow(FFiltros.Rows[intContador]).Name, []) And
           (fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList) Then
          objValor.AddPair('ULTVAL', TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value)
        Else
          objValor.AddPair('ULTVAL', strValPar);
      End

      Else If TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value <> Null Then
      Begin
        objValor.AddPair('MULSEL', 'N');
        objValor.AddPair('ULTVAL', TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value)
      End

      Else
      Begin
        objValor.AddPair('MULSEL', 'N');
        objValor.AddPair('ULTVAL', '');
      End;

      objValores.AddElement(objValor);
    End;

    objArquivo.AddPair('filtros', objValores);

    dlgOpen := TOpenDialog.Create(Self);
    dlgOpen.Filter := 'Arquivos json|*.json';
    dlgOpen.FileName := 'REL' + '-' + FCadRel[0].FieldByName('REL_CODREL').AsString + '.json';
    dlgOpen.Title  := 'Salvar';

    If dlgOpen.Execute Then
    Begin
      sltLista := TStringList.Create;
      sltLista.Add(objArquivo.ToJSON);
      sltLista.SaveToFile(dlgOpen.FileName);
      FreeAndNil(sltLista);

      pMensagemOk('Arquivo exportado com sucesso!');
    End;

    FreeAndNil(dlgOpen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('[TInterfaceRelatorio.pExportaFiltros]', E.message);
    End;
  End;
End;

procedure TInterfaceRelatorio.pImportaFiltros;
  Var
    dlgOpen: TOpenDialog;
    objArquivo: TJSONObject;
    objValores: TJSONArray;
    sltLista: TStringList;
    intContador: Integer;
    strAutInc,
    strNomPar,
    strMulSel,
    strUltVal: String;
    row: TcxEditorRow;
    qryCadVal: TUniQuery;
Begin
  Try
    strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [FCadRel[0].FieldByName('REL_CODREL').AsString]);
    pSalvaValores(strAutInc);

    dlgOpen := TOpenDialog.Create(Self);
    dlgOpen.Filter := 'Arquivos json|*.json';
    dlgOpen.FileName := 'REL' + '-' + FCadRel[0].FieldByName('REL_CODREL').AsString + '.json';
    dlgOpen.Title  := 'Carregar';

    If dlgOpen.Execute Then
    Begin
      sltLista := TStringList.Create;
      sltLista.LoadFromFile(dlgOpen.FileName);

      objArquivo := TJSONObject.ParseJSONValue(sltLista.Text) As TJSONObject;

      If Assigned(objArquivo) then
      Begin
        qryCadVal := fCriaQuery(Self, FConexaoRelatorio.objConexao);

        objValores := objArquivo.GetValue('filtros') As TJSONArray;

        For intContador := 0 To objValores.Count - 1 Do
        Begin
          If Not objValores.Items[intContador].TryGetValue<string>('NOMPAR', strNomPar) Then
            strNomPar := '';

          If Not objValores.Items[intContador].TryGetValue<string>('MULSEL', strMulSel) Then
            strMulSel := '';

          If Not objValores.Items[intContador].TryGetValue<string>('ULTVAL', strUltVal) Then
            strUltVal := '';

          If Not strNomPar.IsEmpty Then
          Begin
            row := TcxEditorRow(FFiltros.RowByName(strNomPar));

            If Assigned(row) Then
            Begin
              If fExisteCadVal(strAutInc,
                               row.Name,
                               strLoginUsuarioLogado,
                               FTabelaFiltrosValores) Then
                qryCadVal.SQL.Text := qryCadVal.SQL.Text + fSQLUpdateCadVal(intContador, FTabelaFiltrosValores)
              Else
                qryCadVal.SQL.Text := qryCadVal.SQL.Text + fSQLInsertCadVal(intContador, FTabelaFiltrosValores);

              qryCadVal.ParamByName('SEQGER' + IntToStr(intcontador)).AsString := strAutInc;
              qryCadVal.ParamByName('NOMPAR' + IntToStr(intcontador)).AsString := strNomPar;
              qryCadVal.ParamByName('CODOPE' + IntToStr(intcontador)).AsString := strLoginUsuarioLogado;
              qryCadVal.ParamByName('MULSEL' + IntToStr(intcontador)).AsString := strMulSel;

              If Not strUltVal.IsEmpty Then
                qryCadVal.ParamByName('ULTVAL' + IntToStr(intcontador)).AsString := strUltVal

              Else
                qryCadVal.ParamByName('ULTVAL'+ IntToStr(intcontador)).Clear;
            End;

          End;

        End;

        If Not fEmptyStr(qryCadVal.SQL.Text) Then
          qryCadVal.ExecSQL;

        FreeAndNil(qryCadVal);

        pRestauraValores;

        pMensagemOk('Arquivo importado com sucesso!');

      End Else
      Begin
        pMensagemOk('Formato do arquivo inválido!');
      End;

      FreeAndNil(sltLista);
    End;

    FreeAndNil(dlgOpen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('[TInterfaceRelatorio.pExportaFiltros]', E.message);
    End;
  End;
End;

procedure TInterfaceRelatorio.pSalvaValores(strAutInc: String; blnValoresValidacao: Boolean = False);
  Var
    intContador: Integer;
    qryCadVal: TUniQuery;
    strValPar: String;
Begin

  Try
    If fEmptyStr(strAutInc) Then
      Exit;

    qryCadVal := fCriaQuery(Self, FConexaoRelatorio.objConexao);
    try
      For intContador := 0 To FFiltros.Rows.Count - 1 do
      If Not FFiltros.Rows[intContador].IsCategory Then
      Begin

        If (Not blnValoresValidacao) Or
           (Assigned(FParamValidacao) And FParamValidacao.FindKey([TcxEditorRow(FFiltros.Rows[intContador]).Name])) Then
        Begin
          If fExisteCadVal(strAutInc,
                           TcxEditorRow(FFiltros.Rows[intContador]).Name,
                           strLoginUsuarioLogado,
                           FTabelaFiltrosValores) Then
            qryCadVal.SQL.Text := qryCadVal.SQL.Text + fSQLUpdateCadVal(intContador, FTabelaFiltrosValores)
          Else
            qryCadVal.SQL.Text := qryCadVal.SQL.Text + fSQLInsertCadVal(intContador, FTabelaFiltrosValores);

          qryCadVal.ParamByName('SEQGER' + IntToStr(intcontador)).AsString := strAutInc;
          qryCadVal.ParamByName('NOMPAR' + IntToStr(intcontador)).AsString := TcxEditorRow(FFiltros.Rows[intContador]).Name;
          qryCadVal.ParamByName('CODOPE' + IntToStr(intcontador)).AsString := strLoginUsuarioLogado;
          qryCadVal.ParamByName('MULSEL' + IntToStr(intcontador)).AsString := 'N';

          If fTemMultiSelecao(TcxEditorRow(FFiltros.Rows[intContador]).Name) Then
          Begin
            strValPar := FValueParams.FieldByName('VALPAR').AsString;
            Delete(strValPar, 1, Length(' IN ('));
            strValPar := LeftStr(strValPar, Length(strValPar) -1);

            If FParams.Locate('PAR_NOMPAR', qryCadVal.ParamByName('NOMPAR' + IntToStr(intcontador)).AsString, []) And
               (fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList) Then
              qryCadVal.ParamByName('ULTVAL'+ IntToStr(intcontador)).AsString := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value
            Else
              qryCadVal.ParamByName('ULTVAL'+ IntToStr(intcontador)).AsString := strValPar;

            qryCadVal.ParamByName('MULSEL' + IntToStr(intcontador)).AsString := 'S';
          End

          Else If TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value <> Null Then
          Begin
            qryCadVal.ParamByName('ULTVAL' + IntToStr(intcontador)).AsString := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value
          End

          Else
            qryCadVal.ParamByName('ULTVAL'+ IntToStr(intcontador)).Clear;
        End;

      End;

      If Not fEmptyStr(qryCadVal.SQL.Text) Then
        qryCadVal.ExecSQL;

    finally
      FreeAndNil(qryCadVal);
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TInterfaceRelatorio.pSalvaValores]');
    End;
  End;

End;

Function TInterfaceRelatorio.fSQLLoadCadVal: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT VAL_ULTVAL, VAL_MULSEL FROM ' + FTabelaFiltrosValores + ' ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   VAL_SEQGER = :SEQGER AND VAL_NOMPAR = :NOMPAR AND VAL_CODOPE = :CODOPE';

  Result := strSQL;
End;

procedure TInterfaceRelatorio.pRestauraValores;
  Var
    intContador: Integer;
    qryCadVal: TUniQuery;
    pesPesquisa: TPesquisas;
    arrSel: TConsultasArray;
    strValPar: String;

  function fVerificaAcessoVerdeVermelho(): Boolean;
  begin
    Result := True;
    if FParams.Locate('PAR_NOMPAR', TcxEditorRow(FFiltros.Rows[intContador]).Name, []) then
      if not fEmptyStr(FParams.FieldByName('PAR_VERVER').AsString) then
        if not fVerificaAcessoSistema(FParams.FieldByName('PAR_VERVER').AsString) then
          Result := False;
  end;

Begin
  Try
    With FFiltros Do
    Begin
      If (TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items.IndexOf(TcxEditorRow(Rows[FIndexDestino]).Properties.Value) < 0) And
         (TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items.Count > 0) Then
        TcxEditorRow(Rows[FIndexDestino]).Properties.Value :=
          TcxComboBoxProperties(TcxEditorRow(Rows.Items[FIndexDestino]).Properties.EditProperties).Items[0];
    End;

    If fEmptyStr(FCadRel[0].FieldByName('AUTOINCREM').AsString) Then
      Exit;

    pesPesquisa := pesSemPesquisa;

    qryCadVal := fCriaQuery(Self, FConexaoRelatorio.objConexao);

    qryCadVal.SQL.Text := fSQLLoadCadVal;

    With FFiltros Do
    Begin

      For intContador := 0 To Rows.Count - 1 do
      If Not Rows[intContador].IsCategory Then
      Begin

        qryCadVal.Close;
        qryCadVal.ParamByName('SEQGER').AsString := FCadRel[0].FieldByName('AUTOINCREM').AsString;
        qryCadVal.ParamByName('NOMPAR').AsString := TcxEditorRow(Rows[intContador]).Name;
        qryCadVal.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryCadVal.Open;

        If FParams.Locate('PAR_NOMPAR', TcxEditorRow(Rows[intContador]).Name, []) Then
          pesPesquisa := TConsultasRel.fNomePesquisaToTipo(FParams.FieldByName('PAR_PESQUI').AsString);

        If pesPesquisa = pesOperador Then
          If Not fVerificaAcessoVerdeVermelho Then
            If blnUsuarioLogadoDefaultVerdeVermelho Then
              TcxEditorRow(Rows[intContador]).Properties.Value := fRetSenhaVendedor(strLoginUsuarioLogado);

        If Not qryCadVal.IsEmpty Then
        Begin
          If Not fVerificaAcessoVerdeVermelho Then
          Begin
            If Assigned(TcxEditorRow(Rows[intContador]).Properties) And
              (TcxEditorRow(Rows[intContador]).Properties.EditPropertiesClass = TcxComboBoxProperties) Then
              pAvaliaExprVisibilParametro(TcxEditorRow(Rows[intContador]).Name);

            If pesPesquisa = pesOperador Then
              If blnUsuarioLogadoDefaultVerdeVermelho Then
                If qryCadVal.FieldByName('VAL_ULTVAL').AsString <> '' Then
                  TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString;

            Continue;
          End;

          If Pos(TcxEditorRow(Rows[intContador]).Name, 'DESTINO_REL') > 0 Then
          Begin
            If TcxComboBoxProperties(TcxEditorRow(Rows.Items[intContador]).Properties.EditProperties).Items.IndexOf(qryCadVal.FieldByName('VAL_ULTVAL').AsString) >= 0 Then
              TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString

            Else If TcxComboBoxProperties(TcxEditorRow(Rows.Items[intContador]).Properties.EditProperties).Items.Count > 0 Then
                   TcxEditorRow(Rows[intContador]).Properties.Value :=
                      TcxComboBoxProperties(TcxEditorRow(Rows.Items[intContador]).Properties.EditProperties).Items[0];
          End

          Else If Pos(TcxEditorRow(Rows[intContador]).Name, 'PASTA_REL') > 0 Then
          Begin
            TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString;
          End

          Else If Pos(TcxEditorRow(Rows[intContador]).Name, 'IMAGEM_CABECALHO') > 0 Then
          Begin
            TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString;
          End

          Else If (qryCadVal.FieldByName('VAL_MULSEL').AsString = 'S') And
                  FParams.Locate('PAR_NOMPAR', TcxEditorRow(Rows[intContador]).Name, []) Then
          Begin

            If fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList Then
            Begin

              TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString;

              strValPar := fDisplayTextsToValPar(TcxEditorRow(Rows[intContador]).Properties.DisplayTexts[0]);

            End Else
            Begin

              strValPar := ' IN (' +  qryCadVal.FieldByName('VAL_ULTVAL').AsString + ')';

            End;

            If FValueParams.Locate('NOMPAR', TcxEditorRow(Rows[intContador]).Name, []) Then
              FValueParams.Edit
            Else
              FValueParams.Insert;

            FValueParams.FieldByName('NOMPAR').AsString := TcxEditorRow(Rows[intContador]).Name;
            FValueParams.FieldByName('VALPAR').AsString := strValPar;

            TConsultasRel.pValParToArrSel(FValueParams.FieldByName('VALPAR').AsString, arrSel);

            FValueParams.FieldByName('DESEDT').AsString := FConsulta.fRetDescricaoEdit(arrSel, pesPesquisa);

            FValueParams.Post;

            If FValueParamsDisplayText.Locate('NOMPAR', TcxEditorRow(Rows[intContador]).Name, []) Then
              FValueParamsDisplayText.Edit
            Else
              FValueParamsDisplayText.Insert;

            FValueParamsDisplayText.FieldByName('NOMPAR').Value := FValueParams.FieldByName('NOMPAR').Value;
            FValueParamsDisplayText.FieldByName('VALPAR').Value := FValueParams.FieldByName('VALPAR').Value;
            FValueParamsDisplayText.FieldByName('DESEDT').Value := FValueParams.FieldByName('DESEDT').Value;
            FValueParamsDisplayText.Post;

          End Else
          Begin

            If (Not fEmptyStr(qryCadVal.FieldByName('VAL_ULTVAL').AsString)) And

               (TcxEditorRow(Rows[intContador]).Properties.Options.Editing Or
                (Not fEhCampoGatilho(TcxEditorRow(Rows[intContador]).Name))) And

               ( SameText(TcxEditorRow(Rows[intContador]).Name, STR_PAGINA_INICIAL) Or
                 fEhParametroAutomatico(TcxEditorRow(Rows[intContador]).Name) Or
                 fEhParametroGatilho(TcxEditorRow(Rows[intContador]).Name) Or
                 (FParams.Locate('PAR_NOMPAR', TcxEditorRow(Rows[intContador]).Name, []) And
                  (TcxTextEditProperties((TcxEditorRow(Rows[intContador]).Properties).EditProperties).EchoMode <> eemPassword)) ) Then
            Begin
              TcxEditorRow(Rows[intContador]).Properties.Value := qryCadVal.FieldByName('VAL_ULTVAL').AsString;

              If fEhParametroGatilho(TcxEditorRow(Rows[intContador]).Name) Then
                pHabilitaDatasGatilho(TcxEditorRow(Rows[intContador]).Name, qryCadVal.FieldByName('VAL_ULTVAL').AsString);
            End;

          End;

        End;

        If (Not TcxEditorRow(Rows[intContador]).IsCategory) And
            Assigned(TcxEditorRow(Rows[intContador]).Properties) And
           (TcxEditorRow(Rows[intContador]).Properties.EditPropertiesClass = TcxComboBoxProperties) Then
          pAvaliaExprVisibilParametro(TcxEditorRow(Rows[intContador]).Name);

        pAvaliaCheckListCustomizado(TcxEditorRow(Rows[intContador]).Name);

        pAvaliaVisibilidadeCategoria(TcxEditorRow(Rows[intContador]));
      End; {If Not Rows[intContador].IsCategory Then}

    End;

    FreeAndNil(qryCadVal);

    pSetaParametrosReadOnly;
    pSetaParametrosInvisiveis;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TInterfaceRelatorio.pRestauraValores]');
    End;
  End;
End;

Function TInterfaceRelatorio.fIncluiComplemento(strCodCom, strSeqGer: String): Boolean;
  Var
    intOrdem: Integer;
Begin
  Result := False;

  With FComplementos Do
  Begin
    If Locate('REL_CODREL', strCodCom, []) Then
    Begin
      pMensagemOk('Esse relatório já foi incluido!');
    End
    Else If FChilds.Locate('REL_CODREL', strCodCom, []) Then
    Begin
      pMensagemOk('Esse relatório já foi incluido como subrelatório (child)!');
    End
    Else if not fEmptyStr(fCampoTabela('REL_MASTER', 'CHIREL', ['REL_COMPLE'], [strSeqGer])) Then
    Begin
      pMensagemOk('Não é possível incluir rel. complementar pois rel. principal é child de outro relatório!');
    End
    Else
    Begin
      Last;
      If IsEmpty Then
        intOrdem := 1
      Else
        intOrdem := FieldByName('REL_ORDENA').AsInteger + 1;

      Append;
      FieldByName('REL_MASTER').AsString  := strSeqGer;
      FieldByName('REL_CODREL').AsString  := strCodCom;
      FieldByName('REL_COMPLE').AsString  := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [strCodCom]);
      FieldByName('REL_DESCRI').AsString  := fCampoTabela('REL_DESCRI', 'CADREL', ['REL_CODREL'], [strCodCom]);
      FieldByName('REL_SUBTIT').AsString  := fCampoTabela('REL_SUBTIT', 'CADREL', ['REL_CODREL'], [strCodCom]);
      FieldByName('REL_DESCMP').AsString  := fCampoTabela('REL_DESCMP', 'CADREL', ['REL_CODREL'], [strCodCom]);
      FieldByName('REL_ORDENA').AsInteger := intOrdem;
      FieldByName('REL_NOVPAG').AsString  := 'N';
      Post;

      fAtualizaParametros(True);
    End;
  End;

End;

Function TInterfaceRelatorio.fIncluiDirAcesso(strCodDir, strSeqGer: String): Boolean;
Begin
  Result := False;

  If FDirAcesso.Locate('DIR_CODDIR', strCodDir, []) Then
  Begin
    pMensagemOk('Esse direito de acesso já foi incluido!');
  End
  Else
  Begin
    FDirAcesso.Last;

    FDirAcesso.Append;
    FDirAcesso.FieldByName('REL_SEQGER').AsString  := strSeqGer;
    FDirAcesso.FieldByName('REL_SEQDIR').AsString  := fCampoTabela('AUTOINCREM', 'CADDIR', ['DIR_CODDIR'], [strCodDir]);
    FDirAcesso.FieldByName('DIR_CODDIR').AsString  := strCodDir;
    FDirAcesso.FieldByName('DIR_NOMDIR').AsString  := fCampoTabela('DIR_NOMDIR', 'CADDIR', ['DIR_CODDIR'], [strCodDir]);
    FDirAcesso.Post;
  End;
End;

Function TInterfaceRelatorio.fIncluiChild(strCodChi, strSeqGer: String): Boolean;
  Var
    intOrdem: Integer;
Begin
  Result := False;

  With FChilds Do
  Begin
    If Locate('REL_CODREL;REL_MASTER;REL_NOMCAM', VarArrayOf([strCodChi, strSeqGer, '']), []) Then
    Begin
      pMensagemOk('Esse relatório já foi incluido!');
    End
    Else If FComplementos.Locate('REL_CODREL', strCodChi, []) Then
    Begin
      pMensagemOk('Esse relatório já foi incluido como relatório complementar!');
    End
    Else
    Begin
      Last;
      If IsEmpty Then
        intOrdem := 1
      Else
        intOrdem := FieldByName('REL_ORDENA').AsInteger + 1;

      Append;
      FieldByName('REL_MASTER').AsString  := strSeqGer;
      FieldByName('REL_CODREL').AsString  := strCodChi;
      FieldByName('REL_COMPLE').AsString  := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [strCodChi]);
      FieldByName('REL_DESCRI').AsString  := fCampoTabela('REL_DESCRI', 'CADREL', ['REL_CODREL'], [strCodChi]);
      FieldByName('REL_SUBTIT').AsString  := fCampoTabela('REL_SUBTIT', 'CADREL', ['REL_CODREL'], [strCodChi]);
      FieldByName('REL_DESCMP').AsString  := fCampoTabela('REL_DESCMP', 'CADREL', ['REL_CODREL'], [strCodChi]);
      FieldByName('REL_ORDENA').AsInteger := intOrdem;
      Post;

      fAtualizaParametros(True);
    End;
  End;

End;

Function TInterfaceRelatorio.fIncluiHistorico(strTitulo, strDescri, strChave: String): Boolean;
Var
    intOrdem: Integer;
Begin
  Result := False;

  With FHistoricos Do
  Begin
    First;
    If IsEmpty Then
      intOrdem := 1
    Else
      intOrdem := FieldByName('HIS_SEQHIS').AsInteger + 1;

    Append;
    FieldByName('HIS_CHAVE_').AsString   := strChave;
    FieldByName('HIS_TITULO').AsString   := strTitulo;
    FieldByName('HIS_DESCRI').AsString   := AnsiReplaceStr(strDescri, #13#10, '<<csq>>');
    FieldByName('HIS_DTACAD').AsDateTime := VS_Date;
    FieldByName('HIS_HORCAD').AsDateTime := fTime();
    FieldByName('HIS_SEQHIS').AsInteger  := intOrdem;
    Post;
  End;

End;

Function TInterfaceRelatorio.fAlteraHistorico(strTitulo, strDescri: String): Boolean;
Begin
  Result := False;

  With FHistoricos Do
  Begin
    Edit;
    FieldByName('HIS_TITULO').AsString   := strTitulo;
    FieldByName('HIS_DESCRI').AsString   := AnsiReplaceStr(strDescri, #13#10, '<<csq>>');
    FieldByName('HIS_DTACAD').AsDateTime := VS_Date;
    FieldByName('HIS_HORCAD').AsDateTime := fTime();
    Post;
  End;

End;

Function TInterfaceRelatorio.fExcluiComplemento: Boolean;
  Var
    intOrdem: Integer;
Begin
  Result := False;

  With FComplementos Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do relatório complementar ' + FieldByName('REL_CODREL').AsString + '?') Then
    Begin
      intOrdem := FieldByName('REL_ORDENA').AsInteger;

      Delete;
      Result := True;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('REL_ORDENA').AsInteger := intOrdem;
        Post;

        Inc(intOrdem);
        Next;
      End;

      fAtualizaParametros(True);
    End;

  End;

End;

Function TInterfaceRelatorio.fExcluiTodosComplementos: Boolean;
Begin
  Result := False;

  With FComplementos Do
  Begin
    If IsEmpty Then
      Exit;

    First;

    while not Eof do
    Begin
      Delete;
      Next;
    End;

  End;

  fAtualizaParametros(True);

End;

Function TInterfaceRelatorio.fExcluiDirAcesso: Boolean;
Begin
  Result := False;

  If FDirAcesso.IsEmpty Then
    Exit;

  If fPergunta('Confirma a exclusão do direito de acesso ' + FDirAcesso.FieldByName('DIR_CODDIR').AsString + '?') Then
  Begin
    FDirAcesso.Delete;
    Result := True;
  End;
End;

Function TInterfaceRelatorio.fExcluiChild: Boolean;
Begin
  Result := False;

  With FChilds Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do subrelatório (child) ' + FieldByName('REL_CODREL').AsString + '?') Then
    Begin
      Delete;
      Result := True;

      fAtualizaParametros(True);
    End;

  End;

End;

Function TInterfaceRelatorio.fExcluiTodasChild: Boolean;
Begin
  Result := False;

  With FChilds Do
  Begin
    If IsEmpty Then
      Exit;

    First;

    while not Eof do
    Begin
      Delete;
      Next;
    End;

  End;

  fAtualizaParametros(True);

End;

Function TInterfaceRelatorio.fExcluiHistorico: Boolean;
Begin
  Result := False;

  With FHistoricos Do
  Begin
    If IsEmpty Then
      Exit;

    If fPergunta('Confirma a exclusão do histórico "' + FieldByName('HIS_TITULO').AsString + '"?') Then
    Begin
      Delete;
      Result := True;
    End;

  End;

End;

Function TInterfaceRelatorio.fLargurasOk: Boolean;
Var
  intNumCol, intLinha: Integer;
  fltLarguraPaginaPix: Double;
begin
  Result := True;

  If Not (fRetDestino In [desVideo, desDesignReport, desImpressora]) Then
    Exit;

  // PEGAR A POSICAO DO ULTIMO COMPONENT + LARGURA
  fltLarguraPaginaPix := FGeraFr3.fGetLarguraPaginaPix;

  For intLinha := 1 To MAX_LINHAS_DETALHE Do
  Begin
    intNumCol := FCadRel[0].FieldByName('REL_NUMCOL').AsInteger;
    If (
         (SameText(FCadRel[0].FieldByName('REL_TIPIMP').AsString, 'J') And (FInterGraf.arrDireitaUltimoCampo[intLinha-1] > Trunc(fltLarguraPaginaPix / intNumCol))) Or
         (SameText(FCadRel[0].FieldByName('REL_TIPIMP').AsString, 'M') And (RoundTo(fGetLarguraUsada(intLinha), -2) > RoundTo((FGeraFr3.fGetMaxLarCam(fGetQtdCamListados(intLinha)) / intNumCol), -2)))

        ) Then
    Begin
      pMensagemOk('A largura das colunas da linha ' + IntToStr(intLinha) + ' excede a largura da página!');
      Result := False;
      Exit;
    End;
  End;

End;

Procedure TInterfaceRelatorio.pMoldura(blnDeixarEspacoEntreCampos: Boolean);
Begin
  FInterGraf.frmPai := frmRelatorio;

  If SameText(FCadRel[0].FieldByName('REL_SPLIT_').AsString, 'S') Then
    FInterGraf.pSetaDadosSplit(Ceil(FCadRel[0].FieldByName('REL_FATSCA').AsFloat),
                   FGeraFr3.fLarguraPaginaOriginal, FGeraFr3.fMargemEsquerda, FGeraFr3.fMargemDireita);

  FInterGraf.pMoldura(FscrLinhas, FimgFundo,
                      FGeraFr3.fLarguraPagina,
                      FCadRel[0].FieldByName('REL_QTDCOL').AsInteger,
                      FCadRel[0].FieldByName('REL_MARESQ').AsInteger,
                      FCadRel[0].FieldByName('REL_MARDIR').AsInteger,
                      FCadRel[0].FieldByName('REL_NUMCOL').AsInteger,
                      FGeraFr3.strTipImp, FGeraFr3.fonFontHeader, FCampos,
                      blnDeixarEspacoEntreCampos);
End;

Procedure TInterfaceRelatorio.pCriaComponentes;
Begin
  If Assigned(FscrLinhas) Then
    FInterGraf.pCriaComponentes(FscrLinhas, FimgFundo, FGeraFr3.strTipImp, FGeraFr3.fonFontHeader, FCampos);
End;

Procedure TInterfaceRelatorio.pAtualizaLarguraCampo;
Begin
  FInterGraf.pAtualizaLarguraCampo(FGeraFr3.strTipImp, FCampos);
End;

Function TInterfaceRelatorio.fValidaCfgSis(strExpressao: String): String;
Var
  rgxExpReg: TRegEx;
  intCont: Integer;
  mclMatchCol: TMatchCollection;
  strRegex: string;

Begin

  strRegex := 'fCfgSis\(''[A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9][A-Z0-9]''\)';

  Try
    rgxExpReg := TRegEx.Create(strRegex);
    mclMatchCol := rgxExpReg.Matches(strExpressao);
    for intCont := 0 to mclMatchCol.Count - 1 do
      strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, QuotedStr(fCfgSis(Copy(mclMatchCol.Item[intCont].Value, 10, 6))));

    Result := strExpressao;
  Except
    On E: Exception Do
    Begin
      Result := strExpressao;
      pMensagemOk(E.message + #13#10 + '[TInterfaceRelatorio.fValidaCfgSis]');
      Abort;
    End;
  End;

End;

Function TInterfaceRelatorio.fRetornaMesAnoPersonalizado(strExpressao: String): String;
Var
  rgxExpReg: TRegEx;
  intCont, intQtdMes: Integer;
  mclMatchCol: TMatchCollection;
  strRegex, strValorSubst: string;
  strMesAtu, strPosNeg, strSigla: string;
  stlTermosGer: TStringList;
  stlTermosMes: TStringList;

  function fTrocaVarParam(strMesAtu, strSigla, strVarParam: string; intQtdMes: Integer): string;

    function fRetornaValorParam(strParam, strSigla: string; intQtdMes: Integer): string;
    var
      rowDado: TcxEditorRow;
    begin
      Result := strParam;
      rowDado := fRetRowDado(strParam);
      if Assigned(rowDado) then
      begin
        if FParams.Locate('PAR_NOMPAR', strParam, []) and (rowDado.Properties.Value <> Null) then
          Result := FormatDateTime(IIF(strSigla = 'S', 'mmm/YYYY', 'MM/YYYY'), IncMonth(StrToDate(IIF(Length(rowDado.Properties.Value) = 7, '01/' + rowDado.Properties.Value, rowDado.Properties.Value)), intQtdMes));
      end;
    end;

    function fRetornaValorVar(strParam, strSigla: string; intQtdMes: Integer): string;
    var
      qryConsultaVar: TUniQuery;
    begin
      Result := strParam;
      qryConsultaVar := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
      try
        with qryConsultaVar, qryConsultaVar.SQL do
        begin
          Close;
          Clear;
          Add('SELECT IF(LENGTH(@' + strParam + ') = 7, CONCAT("01/", @' + strParam + '), DATE_FORMAT(@' + strParam + ', "%d/%m/%Y")) AS VALVAR');
          Open;
          Result := FormatDateTime(IIF(strSigla = 'S', 'mmm/YYYY', 'MM/YYYY'), IncMonth(StrToDate(FieldByName('VALVAR').AsString), intQtdMes));
        end;
      finally
        FreeAndNil(qryConsultaVar);
      end;
    end;

  begin

    case AnsiIndexStr(strVarParam, [':', '@']) of
      0 : Result := fRetornaValorParam(strMesAtu, strSigla, intQtdMes);
      1 : Result := fRetornaValorVar(strMesAtu, strSigla, intQtdMes);
    end;

  end;

Begin

  strRegex := '\([ ]*(\@|\:|)[0-9A-z_]*[ ]*([+-][ ]*[0-9]*[ ]*(,[ ]*''[SN]''[ ]*|)|,[ ]*''[SN]''[ ]*)\)';

  rgxExpReg := TRegEx.Create(strRegex);
  mclMatchCol := rgxExpReg.Matches(strExpressao);
  for intCont := 0 to mclMatchCol.Count - 1 do
  begin
    stlTermosGer := TStringList.Create;
    stlTermosMes := TStringList.Create;
    try
      ExtractStrings([','], [], PWideChar(AnsiReplaceStr(AnsiReplaceStr(mclMatchCol.Item[intCont].Value, '(', ''), ')', '')), stlTermosGer);

      if stlTermosGer.Count > 1 then
        strSigla := Trim(StringReplace(stlTermosGer[1],'''','',[rfReplaceAll]))
      else
        strSigla := 'N';

      if Pos('+', mclMatchCol.Item[intCont].Value) > 0 then
      begin
        strPosNeg := '+';
        ExtractStrings(['+'], [], PWideChar(stlTermosGer[0]), stlTermosMes);
      end
      else
      begin
        strPosNeg := '-';
        ExtractStrings(['-'], [], PWideChar(stlTermosGer[0]), stlTermosMes);
      end;

      strMesAtu := Trim(stlTermosMes[0]);
      if stlTermosMes.Count > 1 then
        intQtdMes := IIF(strPosNeg = '+', StrToInt(Trim(stlTermosMes[1])), - StrToInt(Trim(stlTermosMes[1])))
      else
        intQtdMes := 0;

      if strMesAtu = STR_MESATU then
        strValorSubst := FormatDateTime(IIF(strSigla = 'S', 'mmm/YYYY', 'MM/YYYY'), IncMonth(VS_Date, intQtdMes));
      if Pos(':', strMesAtu) > 0 then
        strValorSubst := fTrocaVarParam(Copy(strMesAtu, 2, Length(strMesAtu)), strSigla, ':', intQtdMes);
      if Pos('@', strMesAtu) > 0 then
        strValorSubst := fTrocaVarParam(Copy(strMesAtu, 2, Length(strMesAtu)), strSigla, '@', intQtdMes);

      strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, QuotedStr(UpperCase(strValorSubst)));

    finally
      FreeAndNil(stlTermosGer);
      FreeAndNil(stlTermosMes);
    end;
  end;

  Result := strExpressao;

End;

function TInterfaceRelatorio.fRetornaValorVar(strParam: string; blnQuoted: Boolean): string;
var
  qryConsultaVar: TUniQuery;
begin
  qryConsultaVar := fCriaQuery(Nil, FConexaoRelatorio.objConexao);
  try
    with qryConsultaVar, qryConsultaVar.SQL do
    begin
      Close;
      Clear;
      Add('SELECT @' + strParam + ' AS VALVAR');
      Open;
      case FieldByName('VALVAR').DataType of
        ftLargeint, ftInteger, ftWord, ftFloat: Result := FieldByName('VALVAR').AsString;
      else
        Result := IIF(blnQuoted, QuotedStr(FieldByName('VALVAR').AsString), FieldByName('VALVAR').AsString);
      end;
    end;
  finally
    FreeAndNil(qryConsultaVar);
  end;
end;

function TInterfaceRelatorio.fRetornaValorVariavel(strExpressao: String; blnQuoted: Boolean = True): String;
var
  rgxExpReg: TRegEx;
  intCont: Integer;
  mclMatchCol: TMatchCollection;
  strRegex, strValorSubst: string;

begin

  strRegex := '\@\b[0-9A-z_]*';

  rgxExpReg := TRegEx.Create(strRegex);
  mclMatchCol := rgxExpReg.Matches(strExpressao);
  for intCont := 0 to mclMatchCol.Count - 1 do
  begin
    strValorSubst := fRetornaValorVar(Copy(Trim(mclMatchCol.Item[intCont].Value), 2, Length(Trim(mclMatchCol.Item[intCont].Value))), blnQuoted);
    strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, strValorSubst);
  end;

  Result := strExpressao;

end;

Function TInterfaceRelatorio.fValidaStrQuebra(strExpressao, strQuebra: String): String;
Var
  rgxExpReg: TRegEx;
  intCont: Integer;
  mclMatchCol: TMatchCollection;
  strRegex, strValorSubst: string;
  strCampo: string;
  stlTermos: TStringList;

Begin

  strRegex := STR_QUEBRA + '\([ ]*[0-9A-z_]*[ ]*\)';

  rgxExpReg := TRegEx.Create(strRegex);
  mclMatchCol := rgxExpReg.Matches(strExpressao);
  for intCont := 0 to mclMatchCol.Count - 1 do
  begin
    stlTermos := TStringList.Create;
    try
      ExtractStrings([','], [], PWideChar(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(mclMatchCol.Item[intCont].Value, STR_QUEBRA + '(', ''), ')', ''), Chr(39), '')), stlTermos);
      if stlTermos.Count > 0 then
      begin
        strCampo   := Trim(stlTermos[0]);
        strValorSubst := IIF(strQuebra = strCampo, '1=1', '1<>1');
        strExpressao := AnsiReplaceStr(strExpressao, mclMatchCol.Item[intCont].Value, strValorSubst);
      end;
    finally
      FreeAndNil(stlTermos);
    end;
  end;

  Result := strExpressao;

End;

Class Function TInterfaceRelatorio.StrToFont(strFont: string; fonFont: TFont = Nil): TFont;
var
  intPosition: Integer;
  strStyle: string;
begin
  If Assigned(fonFont) Then
    Result := fonFont
  Else
    Result := TFont.Create;

  with Result do
  begin
    intPosition := Pos(',', strFont);
    Name := Copy(strFont, 1, intPosition - 1);
    Delete(strFont, 1, intPosition);
    intPosition := Pos(',', strFont);
    Size := StrToInt(Copy(strFont, 2, intPosition - 2));
    Delete(strFont, 1, intPosition);
    intPosition := Pos(',', strFont);
    strStyle := '|' + Copy(strFont, 3, intPosition - 4);
    Delete(strFont, 1, intPosition);
    Color := StringToColor(Copy(strFont, 2, Length(strFont)));
    Style := [];
    if(Pos(CSFSBOLD, strStyle ) > 0) then
      Style := Style + [fsBold];
    if(Pos(CSFSITALIC, strStyle) > 0) then
      Style := Style + [fsItalic];
    if(Pos(CSFSUNDERLINE, strStyle) > 0) then
      Style := Style + [fsUnderline];
    if(Pos(CSFSSTRIKEOUT, strStyle) > 0) then
      Style := Style + [fsStrikeout];
  end;
end;

Class Function TInterfaceRelatorio.FontToStr(fntFont: TFont): string;
var
  strStyle : string;
begin
  with fntFont do
  begin
    strStyle := '';
    if(fsBold in Style) then
      strStyle := strStyle + CSFSBOLD;
    if(fsItalic in Style) then
      strStyle := strStyle + CSFSITALIC;
    if(fsUnderline in Style) then
      strStyle := strStyle + CSFSUNDERLINE;
    if(fsStrikeout in Style) then
      strStyle := strStyle + CSFSSTRIKEOUT;
    if((Length(strStyle) > 0) and ('|' = strStyle[1])) then
      strStyle := Copy(strStyle, 2, Length(strStyle) - 1);
    Result := Format('%s, %d, [%s], %s', [Name, Size, strStyle, ColorToString(Color)]);
  end;
end;

Class Function TInterfaceRelatorio.fRetornaFontTag(fntFont: TFont; strTag: string): string;
var
  strStyle : string;
begin
  with fntFont do
  begin
    strStyle := '';
    if(fsBold in Style) then
      strStyle := strStyle + CSFSBOLD;
    if(fsItalic in Style) then
      strStyle := strStyle + CSFSITALIC;
    if(fsUnderline in Style) then
      strStyle := strStyle + CSFSUNDERLINE;
    if(fsStrikeout in Style) then
      strStyle := strStyle + CSFSSTRIKEOUT;
    if((Length(strStyle) > 0) and ('|' = strStyle[1])) then
      strStyle := Copy(strStyle, 2, Length(strStyle) - 1);

    case AnsiIndexStr(strTag, ['Name', 'Size', 'Style', 'Color']) of
      0 : Result := Format('%s', [Name]);
      1 : Result := Format('%d', [Size]);
      2 : Result := Format('%s', [IIF(fEmptyStr(strStyle), '0', strStyle)]);
      3 : Result := Format('%s', [ColorToString(Color)]);
    end;
  end;
end;

Procedure TInterfaceRelatorio.pInicializaScript(fscScript: TfsScript; Var strExpressao: String);
  var
    strIndex: String;
Begin

  With fscScript Do
  Begin
    Clear;
    AddType('Integer', fvtInt);
    AddType('Boolean', fvtBool);
    AddType('Double' , fvtFloat);
    AddType('Char',    fvtChar);
    AddType('String',  fvtString);
    AddType('Variant', fvtVariant);
  End;

  With FCamposCopia, fscScript Do
  Begin
    First;
    While Not Eof Do
    Begin

      Case fGetTipoInterface(FieldByName('CAM_TIPCAM').AsString) Of
        facFloat   : AddConst(FieldByName('CAM_NOMCAM').AsString, 'Double',  1.11);
        facInteger : AddConst(FieldByName('CAM_NOMCAM').AsString, 'Integer', 1);
        facDate    : AddConst(FieldByName('CAM_NOMCAM').AsString, 'Integer', 1);
        Else         AddConst(FieldByName('CAM_NOMCAM').AsString, 'String',  'AAAA');
      End;

      Next;
    End;

  End;

  With FParams, fscScript Do
  Begin
    strIndex := IndexFieldNames;

    IndexFieldNames := 'PAR_NOMPAR';

    strExpressao := AnsiReplaceStr(strExpressao, STR_DESTINO, QuotedStr(string(ArrDestino[fRetDestino])));
    strExpressao := AnsiReplaceStr(strExpressao, STR_TIPO_TOT, QuotedStr('TG'));
    strExpressao := fValidaStrQuebra(strExpressao, '');
    strExpressao := fValidaCfgSis(strExpressao);
    strExpressao := fRetornaValorVariavel(strExpressao);

    Last;
    While Not Bof Do
    Begin
      strExpressao := AnsiReplaceStr(strExpressao, ':' + FieldByName('PAR_NOMPAR').AsString, FieldByName('PAR_NOMPAR').AsString);

      Case fGetTipoInterface(FieldByName('PAR_TIPPAR').AsString) Of
        facFloat   : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Double',  1.11);
        facInteger : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Integer', 1);
        facDate    : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Integer', 1);
        Else         AddConst(FieldByName('PAR_NOMPAR').AsString, 'String',  'AAAA');
      End;

      Prior;
    End;

    IndexFieldNames := strIndex;
  End;

End;

Procedure TInterfaceRelatorio.pInicializaScriptParametro(fscScript: TfsScript; Var strExpressao: String);
  var
    strIndex: String;
Begin

  With fscScript Do
  Begin
    Clear;
    AddType('Integer', fvtInt);
    AddType('Boolean', fvtBool);
    AddType('Double' , fvtFloat);
    AddType('Char',    fvtChar);
    AddType('String',  fvtString);
    AddType('Variant', fvtVariant);
  End;

  With FParamsCopia, fscScript Do
  Begin
    strIndex := IndexFieldNames;

    IndexFieldNames := 'PAR_NOMPAR';

    strExpressao := AnsiReplaceStr(strExpressao, STR_DESTINO, QuotedStr(string(ArrDestino[fRetDestino])));
    strExpressao := AnsiReplaceStr(strExpressao, STR_TIPO_TOT, QuotedStr('TG'));
    strExpressao := fValidaStrQuebra(strExpressao, '');
    strExpressao := fValidaCfgSis(strExpressao);
    strExpressao := fRetornaValorVariavel(strExpressao);

    Last;
    While Not Bof Do
    Begin
      strExpressao := AnsiReplaceStr(strExpressao, ':' + FieldByName('PAR_NOMPAR').AsString, FieldByName('PAR_NOMPAR').AsString);

      Case fGetTipoInterface(FieldByName('PAR_TIPPAR').AsString) Of
        facFloat   : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Double',  1.11);
        facInteger : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Integer', 1);
        facDate    : AddConst(FieldByName('PAR_NOMPAR').AsString, 'Integer', 1);
        Else         AddConst(FieldByName('PAR_NOMPAR').AsString, 'String',  'AAAA');
      End;

      Prior;
    End;

  End;

End;

Function TInterfaceRelatorio.fCallIIF(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  If Boolean(Params[0]) Then Result := Params[1]
  Else Result := Params[2];
End;

Function TInterfaceRelatorio.fCallPos(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := Pos(Params[0], Params[1]);
End;

Function TInterfaceRelatorio.fCallSum(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := Params[0];
End;

Function TInterfaceRelatorio.fCallCount(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := 1;
End;

Function TInterfaceRelatorio.fCallCopy(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
  Var
    from,
    count: Integer;
Begin
  from  := Params[1];
  count := Params[2];
  Result := Copy(Params[0], from, count);
End;

Function TInterfaceRelatorio.fCallIntToStr(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := IntToStr(Params[0]);
End;

Function TInterfaceRelatorio.fCallStrToInt(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := StrToInt(Params[0]);
End;

Function TInterfaceRelatorio.fCallFloatToStr(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := FloatToStr(Params[0]);
End;

Function TInterfaceRelatorio.fCallStrToFloat(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := StrToFloat(Params[0]);
End;

Function TInterfaceRelatorio.fCallFormatFloat(Instance: TObject; ClassType: TClass;
  Const MethodName: String; Var Params: Variant): Variant;
Begin
  Result := FormatFloat(Params[0], Params[1]);
End;

Function TInterfaceRelatorio.fCompilaExpressao(strExpressao, strTitulo: String; blnParametro: Boolean = False; blnSilencioso: Boolean = False): Boolean;
  Var
    fscScript: TfsScript;
    strExpres,
    strMsgErr: String;
    intContador: Integer;
Begin
  If fEmptyStr(strExpressao) Then
  Begin
    Result := True;
    Exit;
  End;

  if not blnSilencioso then
    strExpressao := fTrocaBrancoNomeColunaCheckList(strExpressao);

  fscScript := TfsScript.Create(Nil);

  With fscScript Do
  Begin

    If blnParametro Then
      pInicializaScriptParametro(fscScript, strExpressao)
    Else
      pInicializaScript(fscScript, strExpressao);

    AddMethod('Function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant', fCallIIF);

    AddMethod('Function Pos(strSubStr, strTexto: String):Integer', fCallPos);

    AddMethod('Function Copy(s: String; from, count: Integer):String', fCallCopy);

    AddMethod('Function IntToStr(intNumber: Integer):String', fCallIntToStr);

    AddMethod('Function StrToInt(strTexto: String):Integer', fCallStrToInt);

    AddMethod('Function FloatToStr(fltNumeric: Double):String', fCallFloatToStr);

    AddMethod('Function StrToFloat(strTexto: String):Double', fCallStrToFloat);

    AddMethod('Function FormatFloat(strTexto: String; fltNumeric: Double):String', fCallFormatFloat);

    For intContador := Low(ArrTipoTotal) To High(ArrTipoTotal) Do
      If Not fEmptyStr(ArrTipoTotal[intContador]) Then
        If SameText('COUNT', ArrTipoTotal[intContador]) Then
          AddMethod('Function COUNT(): Integer', fCallCount)
        Else
          AddMethod('Function ' + ArrTipoTotal[intContador] + '(fltDado: Double): Double', fCallSum);

    strExpres := Trim(strExpressao);

    Lines.Clear;
    Lines.Add('Function Expressao: Variant;');
    Lines.Add('Begin');
    Lines.Add('  Result := ');
    Lines.Add(strExpres);
    Lines.Add('End;');
    Lines.Add('Begin');
    Lines.Add('End.');

    Result := Compile;

    If Result And
      (  CharInSet( RightStr(strExpres, 1)[1], [';', '+', '-'] )) Then
    Begin
      ErrorMsg := ' "' + RightStr(strExpres, 1) +'" inesperado';
      Result := False;
    End;

    If Not Result Then
    Begin
      strMsgErr := ErrorMsg;

      If SameText(strMsgErr, 'Incompatible types') Then
        strMsgErr := 'Tipos incompatíveis'

      Else If Pos('Undeclared identifier', strMsgErr) > 0 Then
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Undeclared identifier:', 'Campo desconhecido: ');
      End

      Else If SameText(strMsgErr, ''';'' expected') Then
        strMsgErr := 'Expressão inválida'

      Else
      Begin
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expression expected', 'Expressão esperada');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'expected', 'esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Expected', 'Esperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'unexpected', 'inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Unexpected', 'Inesperado');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'Identifier', 'Identificador');
        strMsgErr := AnsiReplaceStr(strMsgErr, 'identifier', 'identificador');
      End;

      if not blnSilencioso then
        pMensagemOk(strTitulo + #13#10 + strMsgErr + '!' + '  Pos: [' + ErrorPos + ']');
    End;

  End;

  FreeAndNil(fscScript);
End;

Procedure TInterfaceRelatorio.pCarregaSistemaVerdeVermelho;
  Var
    intContador: Integer;
Begin
  stlVeVerDesc.Clear;
  stlVeVerDesc.Add('');
  stlVeVerHint.Clear;
  stlVeVerHint.Add('');

  If Assigned(frmPrincipal) Then
  Begin

    For intContador := 0 To frmPrincipal.SIVDVM.Count -1 Do
    Begin
      stlVeVerDesc.Add(frmPrincipal.SIVDVM.Items[intContador].Caption);
      stlVeVerHint.Add(frmPrincipal.SIVDVM.Items[intContador].Hint);
    End;

  End;
End;

Class Procedure TInterfaceRelatorio.pInsereDirMenu(mnuRelatorio: TMenuItem; strCodDir, strNomDir: String; blnOrdena: Boolean=True);
  Var
    intContador: Integer;
    mnuInsertRel: TMenuItem;
Begin
  mnuInsertRel := Nil;

  For intContador := 0 To mnuRelatorio.Count - 1 Do
    If SameText(mnuRelatorio.Items[intContador].Hint, 'vv' + strCodDir) Then
    Begin
      If SameText(mnuRelatorio.Caption, strNomDir) Then
        Exit;

      mnuRelatorio.Caption := strNomDir;
      mnuInsertRel := mnuRelatorio;
      Break;
    End;

  If Not Assigned(mnuInsertRel) Then
  Begin
    mnuInsertRel := TMenuItem.Create(mnuRelatorio);
    mnuInsertRel.Caption := strNomDir;
    mnuInsertRel.Hint := 'vv' + strCodDir;
    mnuInsertRel.Name := 'vv' + strCodDir;
    mnuRelatorio.Add(mnuInsertRel);

    If blnOrdena Then
      mnuInsertRel.MenuIndex := mnuRelatorio.Count - 2;
  End;

  If blnOrdena Then
  Begin
    For intContador := 0 To mnuRelatorio.Count - 1 Do
    Begin
      If AnsiReplaceStr(mnuRelatorio.Items[intContador].Caption, '&', '') >
         AnsiReplaceStr(mnuInsertRel.Caption, '&', '') Then
      Begin
        mnuInsertRel.MenuIndex := intContador;
        Break;
      End;
    End;
  End;
End;

Class Function TInterfaceRelatorio.fInsereDireitoNoMenu(strCodDir, strNomDir: String): Boolean;
Begin
  Try
    frmPrincipal.mnuAutcomK.BeginUpdate;

    pInsereDirMenu(frmPrincipal.SIVDVM, strCodDir, strNomDir);

    frmPrincipal.mnuAutcomK.EndUpdate;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TInterfaceRelatorio.fInsereDireitoNoMenu');
    End;
  End;
End;

Class procedure TInterfaceRelatorio.pCarregaDireitosMenu(frmGravando: TfrmGravando; blnOrdena: Boolean);
  Var
    qryRelMen: TUniQuery;
Begin
  Try
    qryRelMen := fCriaQuery;

    With qryRelMen Do
    Begin
      qryRelMen.SQL.Text := 'SELECT DIR_CODDIR, DIR_NOMDIR FROM CADDIR ORDER BY DIR_NOMDIR';
      Open;

      If Assigned(frmGravando) Then
      Begin
        frmGravando.pgbStatus.Properties.Max := RecordCount;
        frmGravando.pgbStatus.Position       := 0;
      End;

      Application.ProcessMessages;

      While Not Eof Do
      Begin

        pInsereDirMenu(frmPrincipal.SIVDVM,
                       FieldByName('DIR_CODDIR').AsString,
                       FieldByName('DIR_NOMDIR').AsString,
                       blnOrdena);

        Next;

        If Assigned(frmGravando) Then
          frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;

        Application.ProcessMessages;
      End;

    End;

    FreeAndNil(qryRelMen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TInterfaceRelatorio.pCarregaDireitosMenu');
    End;
  End;

End;

Class Function TInterfaceRelatorio.fPodeExcluirDireito(strCodDir: String): Boolean;
  Var
    qryCadPar: TUniQuery;
Begin
  Result := True;

  qryCadPar := fCriaQuery;
  With qryCadPar, SQL Do
  Begin
    Add('SELECT GROUP_CONCAT(REL_CODREL) AS CODIGOS FROM CADPRR');
    Add('INNER JOIN CADREL C ON C.AUTOINCREM = PAR_SEQGER');
    Add('WHERE PAR_VERVER = :VERVER AND PAR_AUTOMA NOT IN ("S", "P")');

    ParamByName('VERVER').AsString := 'vv' + strCodDir;

    Open;

    If Not fEmptyStr(FieldbyName('CODIGOS').AsString) Then
    Begin
      Result := False;
      pMensagemOk('Direito de Acesso utilizado no(s) relatório(s): ' + FieldbyName('CODIGOS').AsString + '.' + #13#10 +
                  'Para excluí-lo retire a trava dos relatórios!');
    End;

  End;
  FreeAndNil(qryCadPar);
End;

Class procedure TInterfaceRelatorio.pExcluiItemMenu(strCodDir: String);
  Var
    intContador: Integer;
    mnuItem: TMenuItem;
Begin
  With frmPrincipal.SIVDVM Do
  For intContador := 0 To Count - 1 Do
    If SameText(Items[intContador].Name, 'vv' + strCodDir) Then
    Begin
      mnuItem := Items[intContador];
      Delete(intContador);

      FreeAndNil(mnuItem);
      Exit;
    End;
End;

Class Function TInterfaceRelatorio.fRetDescricaoVisibilidade: String;
  Var
    stlLista: TStringList;
    visContador: TVisibilidade;
Begin
  stlLista := TStringList.Create;

  For visContador := Low(ArrDesVisibilidade) To High(ArrDesVisibilidade) Do
    stlLista.Add(String(ArrDesVisibilidade[visContador]));

  Result := stlLista.Text;

  FreeAndNil(stlLista);
End;

Function TInterfaceRelatorio.fPrecisaRefazerFr3: Boolean;
Begin
//  Result := False;

  Result := True;
(*
  Try
    Try

      If Assigned(FCadRel[0]) And
         SameText(FCadRel[0].FieldByName('REL_HORIZO').AsString, 'I') Then
      Begin
        Result := True;
        Exit;
      End;

      With FCampos Do
      Begin
        First;

        While Not Eof Do
        Begin
          If Pos(':', FieldByName('CAM_DESCAM').AsString) > 0 Then
            Result := True

          Else If (Not fEmptyStr(FieldByName('CAM_QUAQUE').AsString)) Then
            Result := True

          Else If (TInterfaceRelatorio.fDescMascaraToTipo(FieldByName('CAM_MASCAR').AsString) In [masDecQtd, masDecUni]) Then
            Result := True

          Else If (Not fEmptyStr(FieldByName('CAM_EXPVIS').AsString)) Then
            Result := True

          Else If SameText(FieldByName('CAM_NULBRA').AsString, 'S') Then
            Result := True

          Else If ((Not fEmptyStr(FieldByName('CAM_VISIBI').AsString)) And
                  (Not SameText(FieldByName('CAM_VISIBI').AsString, ArrDesVisibilidade[visSempre]))) Then
            Result := True;

          If Result Then
            Break;

          Next;
        End;
      End;

      If Not Result Then
      With FParams Do
      Begin
        First;

        While Not Eof Do
        Begin

          If (Not fEmptyStr(FieldByName('PAR_SQLVIS').AsString)) Or
             (Not fEmptyStr(FieldByName('PAR_EXPVIS').AsString)) Or
             (fGetTipoInterface(FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList) Then
            Result := True;

          If Result Then
            Break;

          Next;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TInterfaceRelatorio.fPrecisaRefazerFr3]');
      End;
    End;

  Finally

    FFr3Gerado := Not Result;

  End;
*)
End;

Function TInterfaceRelatorio.fRetTabelasInventario: String;
  Var
    qryTabInv: TUniQuery;
    stlInfo,
    stlTabs: TStringList;
    intContador: Integer;
Begin
  stlTabs   := TStringList.Create;
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabInv := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabInv Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "I\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      If (strToIntDef(Copy(Fields[0].AsString,7,2), 0) <= High(arrMesAbr)) And
         (strToIntDef(Copy(Fields[0].AsString,3,4), 0) > 0) Then
        stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

    For intContador := 0 To stlInfo.Count - 1 Do
      If (Length(stlInfo[intContador]) = 8) Then
        stlTabs.Add(String(Copy(stlInfo[intContador], 3, 4) + ' / ' + String(arrMes[strToIntDef(Copy(stlInfo[intContador],7,2), 0)])))
      Else
        stlTabs.Add(stlInfo[intContador]);

  End;

  Result := stlTabs.Text;

  FreeAndNil(qryTabInv);
  FreeAndNil(stlTabs);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fRetTabelasEstExt: String;
  Var
    qryTabExt: TUniQuery;
    stlInfo,
    stlTabs: TStringList;
    intContador: Integer;
Begin
  stlTabs   := TStringList.Create;
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabExt := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabExt Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "ESTEXT\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      If (Length(Fields[0].AsString) = 13) And
         (strToIntDef(Copy(Fields[0].AsString,12,2), 0) <= High(arrMesAbr)) And
         (strToIntDef(Copy(Fields[0].AsString,8,4), 0) > 0) Then
        stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

    For intContador := 0 To stlInfo.Count - 1 Do
      stlTabs.Add(String(Copy(stlInfo[intContador], 8, 4) + ' / ' + String(arrMes[strToIntDef(Copy(stlInfo[intContador],12,2), 0)])));

  End;

  Result := stlTabs.Text;

  FreeAndNil(qryTabExt);
  FreeAndNil(stlTabs);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fRetTabelasEstEnt: String;
  Var
    qryTabEnt: TUniQuery;
    stlInfo,
    stlTabs: TStringList;
    intContador: Integer;
Begin
  stlTabs   := TStringList.Create;
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabEnt := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabEnt Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "ESTENT\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      If (Length(Fields[0].AsString) = 13) And
         (strToIntDef(Copy(Fields[0].AsString,12,2), 0) <= High(arrMesAbr)) And
         (strToIntDef(Copy(Fields[0].AsString,8,4), 0) > 0) Then
        stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

    For intContador := 0 To stlInfo.Count - 1 Do
      stlTabs.Add(String(Copy(stlInfo[intContador], 8, 4) + ' / ' + String(arrMes[strToIntDef(Copy(stlInfo[intContador],12,2), 0)])));

  End;

  Result := stlTabs.Text;

  FreeAndNil(qryTabEnt);
  FreeAndNil(stlTabs);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fRetTabelasEstEnv: String;
  Var
    qryTabEnv: TUniQuery;
    stlInfo,
    stlTabs: TStringList;
    intContador: Integer;
Begin
  stlTabs   := TStringList.Create;
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabEnv := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabEnv Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "ESTENV\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      If (Length(Fields[0].AsString) = 13) And
         (strToIntDef(Copy(Fields[0].AsString,12,2), 0) <= High(arrMesAbr)) And
         (strToIntDef(Copy(Fields[0].AsString,8,4), 0) > 0) Then
        stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

    For intContador := 0 To stlInfo.Count - 1 Do
      stlTabs.Add(String(Copy(stlInfo[intContador], 8, 4) + ' / ' + String(arrMes[strToIntDef(Copy(stlInfo[intContador],12,2), 0)])));

  End;

  Result := stlTabs.Text;

  FreeAndNil(qryTabEnv);
  FreeAndNil(stlTabs);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fRetTabelasLotes: String;
  Var
    qryTabLot: TUniQuery;
    stlInfo,
    stlTabs: TStringList;
    intContador: Integer;
Begin
  stlTabs   := TStringList.Create;
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabLot := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabLot Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "L\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      If (Length(Fields[0].AsString) = 8) And
         (strToIntDef(Copy(Fields[0].AsString,7,2), 0) <= High(arrMesAbr)) And
         (strToIntDef(Copy(Fields[0].AsString,3,4), 0) > 0) Then
        stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

    For intContador := 0 To stlInfo.Count - 1 Do
      stlTabs.Add(String(Copy(stlInfo[intContador], 3, 4) + ' / ' + String(arrMes[strToIntDef(Copy(stlInfo[intContador],7,2), 0)])));

  End;

  Result := stlTabs.Text;

  FreeAndNil(qryTabLot);
  FreeAndNil(stlTabs);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fNomeToIndexTabelaDinamica(strNome: String): Integer;
Begin
  strNome := RightStr(strNome, 2);

  If StrToIntDef(strNome, -1) > 0 Then
  Begin
    Result := StrToIntDef(strNome, -1);
  End Else
  Begin
    strNome := RightStr(strNome, 1);

    If StrToIntDef(strNome, -1) > 0 Then
      Result := StrToIntDef(strNome, -1)
    Else
      Result := 1;
  End;
End;

procedure TInterfaceRelatorio.pComboChangeInventario(Sender: TObject);
  Var
    intTabela: Integer;
Begin
  intTabela := fNomeToIndexTabelaDinamica(TComponent(Sender).Name);

  If FindexEstExt[intTabela] > -1 Then
  Begin
    If (TcxComboBoxProperties(TcxEditorRow(FFiltros.Rows.Items[FindexEstExt[intTabela]]).Properties.EditProperties).Items.IndexOf(TcxEditorRow(FFiltros.Rows[FIndexInventario[intTabela]]).Properties.Value) < 0) Then
    Begin
      If fCfgSis('ESTEXT', varBoolean) Then
        pMensagemOk('Não há dados para ' + Trim(TcxEditorRow(FFiltros.Rows[FindexEstExt[intTabela]]).Properties.Caption) + ' no mês selecionado!')
    End Else
      TcxEditorRow(FFiltros.Rows[FindexEstExt[intTabela]]).Properties.Value := TcxEditorRow(FFiltros.Rows[FIndexInventario[intTabela]]).Properties.Value
  End;
End;

procedure TInterfaceRelatorio.pComboChangeEstExt(Sender: TObject);
  Var
    intTabela: Integer;
Begin
  intTabela := fNomeToIndexTabelaDinamica(TComponent(Sender).Name);

  If FIndexInventario[intTabela] > -1 Then
  Begin
    If (TcxComboBoxProperties(TcxEditorRow(FFiltros.Rows.Items[FIndexInventario[intTabela]]).Properties.EditProperties).Items.IndexOf(TcxEditorRow(FFiltros.Rows[FindexEstExt[intTabela]]).Properties.Value) < 0) Then
      pMensagemOk('Não há dados para ' + Trim(TcxEditorRow(FFiltros.Rows[FIndexInventario[intTabela]]).Properties.Caption) + ' no mês selecionado!')
    Else
      TcxEditorRow(FFiltros.Rows[FIndexInventario[intTabela]]).Properties.Value := TcxEditorRow(FFiltros.Rows[FindexEstExt[intTabela]]).Properties.Value;
  End;
End;

Function TInterfaceRelatorio.fParametroAutomaticoVisivel(strNomPar: String; Var strDesPar, strNomGru: String): Boolean;
Begin
  Result := True;

  strDesPar := '';
  strNomGru := '';

  If Not cdsParametrosAutomaticos.FindKey([strNomPar]) Then
    Exit;

  Result := (cdsParametrosAutomaticos.FieldByName('PARVIS').AsInteger = 1) And
            fParametroVisivel(cdsParametrosAutomaticos.FieldByName('PAR_SQLVIS').AsString, False, cdsParametrosAutomaticos);

  strDesPar := cdsParametrosAutomaticos.FieldByName('PAR_DESPAR').AsString;

  strNomGru := cdsParametrosAutomaticos.FieldByName('PAR_GRUFIL').AsString;
End;

Procedure TInterfaceRelatorio.pIncluiComboInventario(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'INVENTARIO_' + intTabela.ToString
    Else
      strNomPar := 'INVENTARIO';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUINV').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexInventario[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário (I_*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário (I_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasInventario;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      OnCloseUp := pComboChangeInventario;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;


Procedure TInterfaceRelatorio.pIncluiComboGatilhoPeriodo(crwCategoria: TcxCategoryRow; strParIni: String);
  Var
    erwEditor: TcxEditorRow;
Begin
  With FFiltros Do
  Begin
    If Not cdsParametrosGatilho.locate('PARINI', strParIni, []) Then
      Exit;

    If Assigned(crwCategoria) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoria, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := cdsParametrosGatilho.FieldByName('PAR_NOMPAR').AsString;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := True;

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := cdsParametrosGatilho.FieldByName('PAR_DESPAR').AsString;

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

    TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := strListaGatilhos;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      OnCloseUp := pComboChangeGatilho;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[0];
  End;
End;

procedure TInterfaceRelatorio.pComboChangeGatilho(Sender: TObject);
  Var
    strNomPar,
    strValor: String;
Begin
  strNomPar := TcxEditorRow(FFiltros.FocusedRow).Name;
  strValor :=  TcxEditorRow(FFiltros.FocusedRow).Properties.Value;

  pHabilitaDatasGatilho(strNomPar, strValor);
End;

Function TInterfaceRelatorio.fGetListaGatilhos: String;
  Var
    stlLista: TStringList;
Begin
  Result := '';

  If Not FListaGatilhos.IsEmpty Then
  Begin
    Result := FListaGatilhos;
    Exit;
  End;

  If Not cdsGatPer.fLeDados('TInterfaceRelatorio.Create') Then
    Exit;

  cdsGatPer.IndexFieldNames := 'GPE_CODIGO';
  cdsGatPer.Insert;
  cdsGatPer.FieldByName('GPE_CODIGO').AsString := '000';
  cdsGatPer.FieldByName('GPE_DESCRI').AsString := STR_INFORMAR_PERIODO;
  cdsGatPer.Post;

  stlLista := TStringList.Create;

  cdsGatPer.First;
  While Not cdsGatPer.Eof Do
  Begin
    stlLista.Add(cdsGatPer.FieldByName('GPE_DESCRI').AsString);
    cdsGatPer.Next;
  End;

  FListaGatilhos := stlLista.Text;

  Result := FListaGatilhos;

  cdsGatPer.IndexFieldNames := 'GPE_DESCRI';

  FreeAndNil(stlLista);
End;

Procedure TInterfaceRelatorio.pIncluiComboEstExt(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'ESTOQUE_EXTERNO_' + intTabela.ToString
    Else
      strNomPar := 'ESTOQUE_EXTERNO';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUEXT').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexEstExt[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Externo (ESTEXT_*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Externo (ESTEXT_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasEstExt;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      OnCloseUp := pComboChangeEstExt;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Procedure TInterfaceRelatorio.pIncluiComboEstEnt(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'RECEBIDO_TERCEIROS_' + intTabela.ToString
    Else
      strNomPar := 'RECEBIDO_TERCEIROS';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUENT').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexEstEnt[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Recebido de Terceiros (ESTENT_*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Recebido de Terceiros (ESTENT_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasEstEnt;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      OnCloseUp := pComboChangeEstExt;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Procedure TInterfaceRelatorio.pIncluiComboEstEnv(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'ENVIADO_TERCEIROS_' + intTabela.ToString
    Else
      strNomPar := 'ENVIADO_TERCEIROS';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUENV').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexEstEnv[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Enviado para Terceiros (ESTENV_*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Estoque Enviado para Terceiros (ESTENV_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasEstEnv;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;

      OnCloseUp := pComboChangeEstExt;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Procedure TInterfaceRelatorio.pIncluiComboLote(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strNomPar,
  strDesPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'LOTES_' + intTabela.ToString
    Else
      strNomPar := 'LOTES';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRULOT').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexLote[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário - Lotes - (L_*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário - Lotes - (L_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasLotes;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Function TInterfaceRelatorio.fRetTabelasSALINV: String;
  Var
    qryTabInv: TUniQuery;
    stlInfo: TStringList;
Begin
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabInv := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabInv Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "SALINV%"';
    Open;

    First;

    While Not Eof Do
    Begin
      stlInfo.Add(String(Fields[0].AsString));

      Next;
    End;

  End;

  Result := stlInfo.Text;

  FreeAndNil(qryTabInv);
  FreeAndNil(stlInfo);
End;

Function TInterfaceRelatorio.fRetTabelasCTR_: String;
  Var
    qryTabInv: TUniQuery;
    stlInfo: TStringList;
Begin
  stlInfo   := TStringList.Create;
  stlInfo.Sorted := True;

  qryTabInv := fCriaQuery(Nil, FConexaoRelatorio.objConexao);

  With qryTabInv Do
  Begin
    SQL.Text := 'SHOW TABLES LIKE "CTR\_%"';
    Open;

    First;

    While Not Eof Do
    Begin
      stlInfo.Add(String(arrMesAbr[StrToIntDef(Copy(Fields[0].AsString,9,2), 0)]) + '/' + Copy(Fields[0].AsString,5,4));
      Next;
    End;

  End;

  Result := stlInfo.Text;

  FreeAndNil(qryTabInv);
  FreeAndNil(stlInfo);
End;

Procedure TInterfaceRelatorio.pIncluiComboSALINV(intTabela: Integer);
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strGruFil,
  strNomPar: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    If intTabela > 1 Then
      strNomPar := 'SALINV_' + intTabela.ToString
    Else
      strNomPar := 'SALINV';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUSAL').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexSALINV[intTabela] := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;

    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;

    If intTabela > 1 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário (SALINV*)' + ' [' + intTabela.ToString + '] '
    Else
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Tabela de Inventário (SALINV*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

   TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasSALINV;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Procedure TInterfaceRelatorio.pIncluiComboCTR_;
Var
  crwCategoriaFixos: TcxCategoryRow;
  erwEditor: TcxEditorRow;
  strDesPar,
  strNomPar,
  strGruFil: String;
  blnVisivel: Boolean;
Begin
  With FFiltros Do
  Begin
    strNomPar := 'CTR_';

    blnVisivel := fParametroAutomaticoVisivel(strNomPar, strDesPar, strGruFil);

    If strGruFil.IsEmpty Then
      strGruFil := FCadRel[0].FieldByName('REL_GRUCTR').AsString;

    crwCategoriaFixos := fCriaCategoriaFixos(strGruFil);

    If Assigned(crwCategoriaFixos) Then
      erwEditor := TcxEditorRow(FFiltros.AddChild(crwCategoriaFixos, TcxEditorRow))
    Else
      erwEditor := TcxEditorRow(FFiltros.Add(TcxEditorRow));

    erwEditor.Properties.HeaderAlignmentHorz := taRightJustify;

    FIndexCTR_ := erwEditor.AbsoluteIndex;

    pAjustaIndicesCombo;

    Rows.Items[erwEditor.AbsoluteIndex].Name := strNomPar;
    Rows.Items[erwEditor.AbsoluteIndex].Visible := blnVisivel;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := 'Inventário Financeiro (CTR_*)' + ' ';

    If Not strDesPar.IsEmpty Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Caption := strDesPar + ' ';

    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
    TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);

    TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Text := fRetTabelasCTR_;

    With TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties) Do
    Begin
      DropDownListStyle   := lsFixedList;
      ImmediatePost       := True;
      ImmediateUpdateText := True;
    End;

    If TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count > 0 Then
      TcxEditorRow(Rows[erwEditor.AbsoluteIndex]).Properties.Value :=
        TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items[
           TcxComboBoxProperties(TcxEditorRow(Rows.Items[erwEditor.AbsoluteIndex]).Properties.EditProperties).Items.Count -1];
  End;
End;

Function TInterfaceRelatorio.fRetTabelaInventarioInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasInventario;

  If stlTabs.Count > 0 Then
    Result := fNomeToTabInv(stlTabs[stlTabs.Count - 1])
  Else
    Result := 'I_';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaEstExtInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasEstExt;

  If stlTabs.Count > 0 Then
    Result := fNomeToEstExt(stlTabs[stlTabs.Count - 1])
  Else
    Result := 'ESTEXT_';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaEstEnvInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasEstEnv;

  If stlTabs.Count > 0 Then
    Result := fNomeToEstEnv(stlTabs[stlTabs.Count - 1])
  Else
    Result := 'ESTENV';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaEstEntInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasEstEnt;

  If stlTabs.Count > 0 Then
    Result := fNomeToEstEnt(stlTabs[stlTabs.Count - 1])
  Else
    Result := 'ESTENT';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaLoteInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasLotes;

  If stlTabs.Count > 0 Then
    Result := fNomeToTabLot(stlTabs[stlTabs.Count - 1])
  Else
    Result := 'L_';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaInventarioSelecionada(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := fNomeToTabInv(TcxEditorRow(Rows[FIndexInventario[intTabela]]).Properties.Value);

End;

Function TInterfaceRelatorio.fRetTabelaEstExtSelecionada(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := fNomeToEstExt(TcxEditorRow(Rows[FIndexEstExt[intTabela]]).Properties.Value);

End;

Function TInterfaceRelatorio.fRetTabelaEstEnvSelecionada(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := fNomeToEstEnv(TcxEditorRow(Rows[FIndexEstEnv[intTabela]]).Properties.Value);

End;

Function TInterfaceRelatorio.fRetTabelaEstEntSelecionada(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := fNomeToEstEnt(TcxEditorRow(Rows[FIndexEstEnt[intTabela]]).Properties.Value);

End;

Function TInterfaceRelatorio.fRetTabelaLoteSelecionado(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := fNomeToTabLot(TcxEditorRow(Rows[FIndexLote[intTabela]]).Properties.Value);

End;

Function TInterfaceRelatorio.fNomeToTabInv(strNome: String): String;
  Var
    strMes: String;
    intContador: Integer;
Begin
  If StartsStr('I_', strNome) Then
  Begin
    Result := strNome;
  End Else
  Begin
    strMes := strNome;
    Delete(strMes, 1, 7);

    For intContador := Low(arrMes) To High(arrMes) Do
      If SameText(strMes, String(arrMes[intContador])) Then
      Begin
        strMes := RightStr('0' + IntToStr(intContador), 2);
        Break;
      End;

    Result := 'I_' + LeftStr(strNome, 4) + strMes;
  End;
End;

Function TInterfaceRelatorio.fNomeToEstExt(strNome: String): String;
  Var
    strMes: String;
    intContador: Integer;
Begin
  If StartsStr('ESTEXT_', strNome) Then
  Begin
    Result := strNome;
  End Else
  Begin
    strMes := strNome;
    Delete(strMes, 1, 7);

    For intContador := Low(arrMes) To High(arrMes) Do
      If SameText(strMes, String(arrMes[intContador])) Then
      Begin
        strMes := RightStr('0' + IntToStr(intContador), 2);
        Break;
      End;

    Result := 'ESTEXT_' + LeftStr(strNome, 4) + strMes;
  End;
End;

Function TInterfaceRelatorio.fNomeToEstEnv(strNome: String): String;
  Var
    strMes: String;
    intContador: Integer;
Begin
  If StartsStr('ESTENV_', strNome) Then
  Begin
    Result := strNome;
  End Else
  Begin
    strMes := strNome;
    Delete(strMes, 1, 7);

    For intContador := Low(arrMes) To High(arrMes) Do
      If SameText(strMes, String(arrMes[intContador])) Then
      Begin
        strMes := RightStr('0' + IntToStr(intContador), 2);
        Break;
      End;

    Result := 'ESTENV_' + LeftStr(strNome, 4) + strMes;
  End;
End;

Function TInterfaceRelatorio.fNomeToEstEnt(strNome: String): String;
  Var
    strMes: String;
    intContador: Integer;
Begin
  If StartsStr('ESTENT_', strNome) Then
  Begin
    Result := strNome;
  End Else
  Begin
    strMes := strNome;
    Delete(strMes, 1, 7);

    For intContador := Low(arrMes) To High(arrMes) Do
      If SameText(strMes, String(arrMes[intContador])) Then
      Begin
        strMes := RightStr('0' + IntToStr(intContador), 2);
        Break;
      End;

    Result := 'ESTENT_' + LeftStr(strNome, 4) + strMes;
  End;
End;

Function TInterfaceRelatorio.fNomeToTabLot(strNome: String): String;
  Var
    strMes: String;
    intContador: Integer;
Begin
  strMes := strNome;
  Delete(strMes, 1, 7);

  For intContador := Low(arrMes) To High(arrMes) Do
    If SameText(strMes, String(arrMes[intContador])) Then
    Begin
      strMes := RightStr('0' + IntToStr(intContador), 2);
      Break;
    End;

  Result := 'L_' + LeftStr(strNome, 4) + strMes;
End;

Function TInterfaceRelatorio.fRetTabelaSALINVInicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasSALINV;

  If stlTabs.Count > 0 Then
    Result := stlTabs[stlTabs.Count - 1]
  Else
    Result := 'SALINV';

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaSALINVSelecionada(intTabela: Integer): String;
Begin

  With FFiltros Do
  Result := TcxEditorRow(Rows[FIndexSALINV[intTabela]]).Properties.Value;

End;

Function TInterfaceRelatorio.fRetMesInv(strMes: String): String;
  Var
    intContador: Integer;
Begin
  Result := '';
  For intContador := Low(arrMesAbr) To High(arrMesAbr) Do
    If SameText(strMes, String(arrMesAbr[intContador])) Then
      Result := fStrZero(IntToStr(intContador), 2);
End;

Function TInterfaceRelatorio.fRetTabelaCTR_Inicial: String;
  Var
    stlTabs: TStringList;
Begin
  stlTabs   := TStringList.Create;

  stlTabs.Text := fRetTabelasCTR_;

  If stlTabs.Count > 0 Then
  Begin
    Result := stlTabs[stlTabs.Count - 1];

    Result := 'CTR_' + RightStr(Result, 4) + fRetMesInv(LeftStr(Result, 3));

    FExtensaoCtr := RightStr(Result, Length(Result) - Length('CTR_'));
  End Else
  Begin
    Result := 'TABELA_DE_INVENTARIO_FINANCEIRO';
    FExtensaoCtr := '';
  End;

  FreeAndNil(stlTabs);
End;

Function TInterfaceRelatorio.fRetTabelaCTR_Selecionada: String;
Begin

  With FFiltros Do
  Result := TcxEditorRow(Rows[FIndexCTR_]).Properties.Value;

  Result := 'CTR_' + RightStr(Result, 4) + fRetMesInv(LeftStr(Result, 3));

  FExtensaoCtr := RightStr(Result, Length(Result) - Length('CTR_'));
End;

Function TInterfaceRelatorio.fSQLSaldoProduto(strAliasIteger, strAliasCadIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + strAliasIteger + '.ITE_SALDOS';

  If Not fEmptyStr(strAliasCadIte) Then
    strSQL := strSQL + ' + IFNULL(' + strAliasIteger + '.ITE_SAL_ML, 0) / IF(IFNULL(' + strAliasCadIte + '.ITE_CNV_ML, 0) <= 0, 1, ' + strAliasCadIte + '.ITE_CNV_ML) ';

  If fUsaQtdPendenteEntregaFutura Then
  Begin

    If (fCfgSis('CALSAL') = '1') Then
      strSQL := strSQL + ' + ' + strAliasIteger + '.ITE_QTEF_A + ' + strAliasIteger + '.ITE_QTEF_P + ' + strAliasIteger + '.ITE_QTEF_F'

    Else If (fCfgSis('CALSAL') = '3') Then
      strSQL := strSQL + ' + ' + strAliasIteger + '.ITE_QTEF_F'

    Else If (fCfgSis('CALSAL') = '4') Then
      strSQL := strSQL + ' + ' + strAliasIteger + '.ITE_QTEF_A + ' + strAliasIteger + '.ITE_QTEF_P'

    Else If (fCfgSis('CALSAL') = '5') Then
      strSQL := strSQL + ' + ' + strAliasIteger + '.ITE_QTEF_A + ' + strAliasIteger + '.ITE_QTEF_F';

  End;

  Result := ' (' + strSQL + ') ';
End;

Function TInterfaceRelatorio.fPaginaInicial: Integer;
  Var
    strValPar: String;
    rowDado: TcxEditorRow;
Begin
  Result := 1;

  rowDado := fRetRowDado(STR_PAGINA_INICIAL);

  If Assigned(rowDado) And (rowDado.Properties.Value <> Null) Then
  Begin
    strValPar := rowDado.Properties.Value;
    Result := StrToIntDef(strValPar, 1);
  End;

End;

Procedure TInterfaceRelatorio.pCriaTiposDeBanda;
Begin
  FTiposBanda := TZClient.Create(Self, 'SELECT 0 AS CODTIP, CAST("" AS CHAR(15)) AS DESTIP', FConexaoRelatorio.objConexao);
  With FTiposBanda Do
  Begin
    fAbreClient(True);
    EmptyDataSet;

    Insert;
    FieldByName('CODTIP').AsInteger := 0;
    FieldByName('DESTIP').AsString  := 'Móvel';
    Post;

    Insert;
    FieldByName('CODTIP').AsInteger := 1;
    FieldByName('DESTIP').AsString  := 'Fixa à esquerda';
    Post;

    Insert;
    FieldByName('CODTIP').AsInteger := 2;
    FieldByName('DESTIP').AsString  := 'Fixa à direita';
    Post;
  End;

End;

Class Function TInterfaceRelatorio.fExisteSimboloTemplate(strCodigo, strSimbol: String): Boolean;
  Var
    qryCadTem: TUniQuery;
Begin
  qryCadTem := fCriaQuery;

  With qryCadTem, SQL Do
  Begin
    Add('SELECT COUNT(*) AS QTD FROM CADTEM');
    Add('WHERE');
    Add('  TEM_SIMBOL = :SIMBOL');

    If Not fEmptyStr(strCodigo) Then
    Begin
      Add(' AND TEM_CODIGO <> :CODIGO');
      ParamByName('CODIGO').AsString := strCodigo;
    End;

    ParamByName('SIMBOL').AsString := strSimbol;

    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryCadTem);
End;

Class Function TInterfaceRelatorio.fGetTemplateSQL(SelfTela: TForm; intColuna: Integer): String;
  Var
    arrSel: TConsultasArray;
    qryCadTem: TUniQuery;
    intContador: Integer;
    Key: Char;
Begin
  Result := '';

  Key := '?';
  If fPesqTemplateSQL(SelfTela, Nil, Nil, Nil, Key, arrSel, False) Then
  Begin
    qryCadTem := fCriaQuery;

    With qryCadTem, SQL Do
    Begin
      Add('SELECT * FROM CADTEM');
      Add('WHERE');
      Add('  TEM_CODIGO = :CODIGO');

      For intContador := Low(arrSel) To High(arrSel) Do
      Begin
        Close;
        ParamByName('CODIGO').AsString := arrSel[intContador].strCodigo;
        Open;

        If Not IsEmpty Then
        Begin
          If (FieldByName('TEM_TIPSQL').AsString = 'SELECT') Then
            Result := Result + AnsiReplaceStr(FieldByName('TEM_INSSQL').AsString, '<<csq>>', #13#10)
          Else
            Result := Result + STR_INDENT_TP + FieldByName('TEM_SIMBOL').AsString;

          If (FieldByName('TEM_TIPSQL').AsString = 'CAMPO') And (intContador < High(arrSel)) And
             (fCampoTabela('TEM_TIPSQL', 'CADTEM', ['TEM_CODIGO'], [arrSel[Succ(intContador)].strCodigo]) = 'CAMPO') Then
            Result := Result + ',';

          If intContador < High(arrSel) Then
          Begin
            Result := Result + #13#10 + fstrEspaco(' ', intColuna);
          End;

        End;

      End;

    End;

    FreeAndNil(qryCadTem);
  End;

End;

Class Function TInterfaceRelatorio.fGetInstrucaoSQL(SelfTela: TForm; intColuna: Integer): String;
  Var
    arrSel: TConsultasArray;
    qryRelIns: TUniQuery;
    intContador: Integer;
    Key: Char;
Begin
  Result := '';

  Key := '?';
  If fPesqInstrucaoSQL(SelfTela, Nil, Nil, Nil, Key, arrSel, True) Then
  Begin
    qryRelIns := fCriaQuery;

    With qryRelIns, SQL Do
    Begin
      Add('SELECT * FROM RELINS');
      Add('WHERE');
      Add('  AUTOINCREM = :AUTOINCREM');

      For intContador := Low(arrSel) To High(arrSel) Do
      Begin
        Close;
        ParamByName('AUTOINCREM').AsString := arrSel[intContador].strCodigo;
        Open;

        If Not IsEmpty Then
        Begin
          Result := Result + '/*' + STR_INDENT_IA + FieldByName('INS_SIMBOL').AsString + '*/';

          If intContador < High(arrSel) Then
          Begin
            Result := Result + #13#10 + fstrEspaco(' ', intColuna);
          End;

        End;

      End;

    End;

    FreeAndNil(qryRelIns);
  End;

End;

Class Function TInterfaceRelatorio.fGetTemplateSQLToMemo(SelfTela: TForm; mmoText: TBCEditor {TDBMemoFocus}): String;
  Var
    intColuna: Integer;
Begin
  With mmoText do
  begin
    intColuna := mmoText.DisplayCaretPosition.Column;
    InsertText(fGetTemplateSQL(SelfTela, intColuna));
  end
End;

Class Function TInterfaceRelatorio.fGetInstrucaoSQLToMemo(SelfTela: TForm; mmoText: TBCEditor {TDBMemoFocus}): String;
  Var
    intColuna: Integer;
Begin
  With mmoText do
  begin
    intColuna := mmoText.DisplayCaretPosition.Column;
    InsertText(fGetInstrucaoSQL(SelfTela, intColuna));
  end
End;

Function TInterfaceRelatorio.fTrataConstantes(strInfo: String): String;
  Var
    intContador: Integer;
Begin

  SetLength(FarrRecConstInst, 0);

  strInfo := fExecutaConsts(strInfo);

  For intContador := High(FarrRecConstInst) DownTo Low(FarrRecConstInst) Do
    strInfo := AnsiReplaceStr(strInfo, FarrRecConstInst[intContador].strNomConst, FarrRecConstInst[intContador].strDescInst);

  SetLength(FarrRecConstInst, 0);

  Result := strInfo;
End;

Function TInterfaceRelatorio.fTrataTemplates(strInfo: String): String;
  Const
    strTrataTemplates = 'TrataTemplates';
  Var
    intContador,
    intPos: Integer;
    strSQL,
    strSimbol: String;
Begin
  While Pos(STR_INDENT_TP, strInfo) > 0 Do
  Begin
    intPos := Pos(STR_INDENT_TP, strInfo);

    If (intPos > 1) And CharInSet(strInfo[Pred(intPos)], ['A'..'Z', 'a'..'z']) Then
    Begin

      Insert(strTrataTemplates, strInfo, Succ(intPos));

    End Else
    Begin
      intContador := intPos + Length(STR_INDENT_TP);
      strSimbol   := '';

      While intContador <= Length(strInfo) Do
      Begin
        If (Not CharInSet(strInfo[intContador], ['A'..'Z', 'a'..'z', '_', '-'])) Then
          Break;

        strSimbol := strSimbol + strInfo[intContador];
        Inc(intContador);
      End;

      strSQL := AnsiReplaceStr(fCampoTabela('TEM_INSSQL', 'CADTEM', ['TEM_SIMBOL'], [strSimbol], False), '<<csq>>', #13#10);

      If fEmptyStr(strSQL) Then
        Insert(strTrataTemplates, strInfo, Succ(intPos))
      Else
        strInfo := AnsiReplaceStr(strInfo, STR_INDENT_TP + strSimbol, strSQL);
    End;
  End;

  Result := AnsiReplaceStr(strInfo, strTrataTemplates, '');
End;

Function TInterfaceRelatorio.fTrataInstrucoes(strInfo: String): String;
  Const
    strTrataInstrucoes = 'TrataInstrucoes';
  Var
    intContador,
    intPos: Integer;
    strSQL,
    strSimbol: String;
Begin
  While Pos('/*' + STR_INDENT_IA, strInfo) > 0 Do
  Begin
    intPos := Pos('/*' + STR_INDENT_IA, strInfo);

    If (intPos > 1) And CharInSet(strInfo[Pred(intPos + 2)], ['A'..'Z', 'a'..'z']) Then
    Begin

      Insert(strTrataInstrucoes, strInfo, Succ(intPos + 2));

    End Else
    Begin
      intContador := intPos + 2 + Length(STR_INDENT_IA);
      strSimbol   := '';

      While intContador <= Length(strInfo) Do
      Begin
        If (Not CharInSet(strInfo[intContador], ['A'..'Z', 'a'..'z', '_', '-'])) Then
          Break;

        strSimbol := strSimbol + strInfo[intContador];
        Inc(intContador);
      End;

      strSQL := AnsiReplaceStr(fCampoTabela('INS_INSSQL', 'RELINS', ['INS_SIMBOL', 'INS_CODREL'], [strSimbol, FCadRel[0].FieldByName('REL_CODREL').AsString]), '<<csq>>', #13#10);

      If fEmptyStr(strSQL) Then
        Insert(strTrataInstrucoes, strInfo, Succ(intPos + 2))
      Else
        strInfo := AnsiReplaceStr(strInfo, '/*' + STR_INDENT_IA + strSimbol + '*/', strSQL);
    End;
  End;

  Result := AnsiReplaceStr(strInfo, strTrataInstrucoes, '');
End;

Class Function TInterfaceRelatorio.fGetSimbolAtCursor(mmoText: TBCEditor{ TDBMemoFocus}): String;
  Var
    intLinha,
    intColuna: Integer;
    strLinha: String;
    intContador: Integer;
    strSimbol: String;
Begin
  With mmoText do
  begin
    Result := '';

    intColuna := mmoText.DisplayCaretPosition.Column;
    intLinha  := mmoText.DisplayCaretPosition.Row;

    strLinha  := Lines[Pred(intLinha)];

    If fEmptyStr(strLinha) Then
      Exit;

    While (intColuna > 0) And
          (Not CharInSet(strLinha[intcoluna], ['A'..'Z', 'a'..'z', '_', '-']))  Do
    Begin
      Dec(intColuna);
    End;

    While (intColuna <= Length(strLinha)) And
          (Not CharInSet(strLinha[intColuna], ['A'..'Z', 'a'..'z', '_', '-']))  Do
    Begin
      Inc(intColuna);
    End;

    strSimbol := '';

    // COPIA A PARTE DA FRENTE
    intContador := intColuna;
    While intContador <= Length(strLinha) Do
    Begin
      If (Not CharInSet(strLinha[intContador], ['A'..'Z', 'a'..'z', '_', '-'])) Then
        Break;

      strSimbol := strSimbol + strLinha[intContador];
      Inc(intContador);
    End;

    // COPIA A PARTE DA TRAS
    intContador := Pred(intColuna);
    While intContador > 0 Do
    Begin
      If (Not CharInSet(strLinha[intContador], ['A'..'Z', 'a'..'z', '_', '-'])) Then
        Break;

      strSimbol := strLinha[intContador] + strSimbol;
      Dec(intContador);
    End;

    Result := strSimbol;
  end
End;

Class Procedure TInterfaceRelatorio.pMostraTemplateMemo(mmoText: TBCEditor {TDBMemoFocus});
  Var
    strSimbol,
    strCodigo: String;
    frmCadTemplates : TfrmCadTemplates;
Begin
  strSimbol := fGetSimbolAtCursor(mmoText);

  If AnsiStartsStr(STR_INDENT_TP, strSimbol) And (Length(strSimbol) > 3) Then
  Begin
    Delete(strSimbol, 1, 3);

    strCodigo := fCampoTabela('TEM_CODIGO', 'CADTEM', ['TEM_SIMBOL'], [strSimbol]);

    If Not fEmptyStr(strCodigo) Then
    Begin
      pCriarFormularios(TfrmCadTemplates, frmCadTemplates);

      frmCadTemplates.strCodigo := strCodigo;
      frmCadTemplates.ShowModal;

      pFreeAndNil(frmCadTemplates);
    End;

  End;

End;

Class Procedure TInterfaceRelatorio.pAddSimbolsTemplate(Lines: TStrings);
  Var
    qryCadTem: TUniQuery;
    intContador: Integer;
Begin
  qryCadTem := fCriaQuery;

  With qryCadTem, SQL Do
  Begin
    Add('SELECT TEM_SIMBOL AS SIMBOL FROM CADTEM');
    Add('WHERE');
    Add('  IFNULL(TEM_SIMBOL, "") <> ""');
    Add('ORDER BY TEM_SIMBOL');

    Open;

    intContador := 416;

    While Not Eof Do
    Begin
      Lines.Insert(intContador, '              "tp_' + LowerCase(FieldByName('SIMBOL').AsString) + '",');

      Inc(intContador);
      Next;
    End;

  End;

  FreeAndNil(qryCadTem);
End;

Class Procedure TInterfaceRelatorio.pAddSimbolsInstrucao(Lines: TStrings);
  Var
    qryRelIns: TUniQuery;
    intContador: Integer;
Begin
  qryRelIns := fCriaQuery;

  With qryRelIns, SQL Do
  Begin
    Add('SELECT INS_SIMBOL AS SIMBOL FROM RELINS');
    Add('WHERE');
    Add('  IFNULL(INS_SIMBOL, "") <> ""');
    Add('ORDER BY INS_SIMBOL');

    Open;

    intContador := 416;

    While Not Eof Do
    Begin
      Lines.Insert(intContador, '              "/*ia_' + LowerCase(FieldByName('SIMBOL').AsString) + '*/",');

      Inc(intContador);
      Next;
    End;

  End;

  FreeAndNil(qryRelIns);
End;

Class Procedure TInterfaceRelatorio.pAjustaEditorSQL(bceDefSQL: TBCEditor);
  Var
    stlSQL: TStringList;
    rscSQL: TResourceStream;
    rscCores: TResourceStream;
    StrStreamSQL: TStringStream;
Begin
  Try
    stlSQL   := TStringList.Create;
    rscSQL   := TResourceStream.Create(HInstance,'MySQLJson',RT_RCDATA);

    stlSQL.LoadFromStream(rscSQL);
    TInterfaceRelatorio.pAddSimbolsTemplate(stlSQL);
    TInterfaceRelatorio.pAddSimbolsInstrucao(stlSQL);
    StrStreamSQL   := TStringStream.Create(AnsiReplaceStr(stlSQL.Text, #13#10, ''));
    bceDefSQL.Highlighter.LoadFromStream(StrStreamSQL);

    FreeAndNil(StrStreamSQL);
    FreeAndNil(rscSQL);

    rscCores := TResourceStream.Create(HInstance,'CoresJson',RT_RCDATA);
    bceDefSQL.Highlighter.Colors.LoadFromStream(rscCores);
    FreeAndNil(rscCores);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TInterfaceRelatorio.pAjustaEditorSQL');
  End;

End;

Function TInterfaceRelatorio.fAbreTabelaSaldos(intQuerie: Integer; Var strSQLPtincipalAtualizado: String): Boolean;
  Var
    blnFaltaInformacao: Boolean;
    objGerarTabela: TFatGerarTabelasParaRelatorio;
    strTabela: String;
Begin
  Result := True;

  With arrGuiaSaldos[intQuerie], qryGuiaSaldos Do
  If Not strSQLFormatado.IsEmpty Then
  Begin
    If Assigned(FGravando) Then
    Begin
      FGravando.lblGravando.Caption := 'Criando resumo de produtos...';
      FGravando.pgbStatus.Visible  := False;
      FGravando.pgbStatus.Position := 0;

      if (not VS_AutcomIniciadoModoRobo) then
        Application.ProcessMessages;
    End;

    Close;

    SQL.Clear;
    SQL.Text := fMontaSQLDados(strSQLFormatado, FQueryFiltros[intQuerie]);

    Result := Not FSQLErro;

    If Not Result Then
      Exit;

    Result := fSetaDadosQuery(qryGuiaSaldos, FQueryFiltros[intQuerie], False, blnFaltaInformacao);

    If Not Result Then
      Exit;

    Open;

    If Assigned(FGravando) Then
    Begin
      FGravando.lblGravando.Caption := 'Calculando saldos...';
      FGravando.pgbStatus.Visible   := True;
      FGravando.pgbStatus.Position  := 0;

      if (not VS_AutcomIniciadoModoRobo) then
        Application.ProcessMessages;
    End;

    objGerarTabela := TFatGerarTabelasParaRelatorio.Create(qryGuiaSaldos, FGravando.pgbStatus);

    If blnGarantia Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Garantia)...';

      strTabela := objGerarTabela.fTabelaReservadoGarantia;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_GARANTIA, strTabela);
    End;

    If blnExterno Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Estoque Empresa Externa)...';

      strTabela := objGerarTabela.fTabelaReservadoExterno;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_EXTERNO, strTabela);
    End;

    If blnPedidoVenda Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Pedidos de Venda)...';

      strTabela := objGerarTabela.fTabelaReservadoPedidoVenda;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_PEDIDO_VENDA, strTabela);
    End;

    If blnPedidoBaixaEntregaFutura Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Pedidos de Baixa de Entrega Futura)...';

      strTabela := objGerarTabela.fTabelaReservadoPedidoBaixaEntregaFuturaReservSaldo;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_PEDIDO_BAIXA_ENTFUT, strTabela);
    End;

    If blnEnderecamento Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Endereçamento)...';

      strTabela := objGerarTabela.fTabelaReservadoEnderecamento;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_ENDERECAMENTO, strTabela);
    End;

    If blnOrdemProducao Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Ordem de Produção)...';

      strTabela := objGerarTabela.fTabelaReservadoOrdemProducao;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_ORDEM_PRODUCAO, strTabela);
    End;

    If blnSaldoTransferencias Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Transferências em Andamento)...';

      strTabela := objGerarTabela.fTabelaTransferenciasEmAndamento;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_TRANSF_ANDAMENTO, strTabela);
    End;

    If blnEntregaFuturaPrevisao Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Entrega Futura - Previsão)...';

      strTabela := objGerarTabela.fTabelaEntregaFuturaPrevisao;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_ENTREGA_FUTURA_PREVISAO, strTabela);
    End;

    If blnEntregaFuturaFaltaProduto Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Entrega Futura - Falta de Produto)...';

      strTabela := objGerarTabela.fTabelaEntregaFuturaFaltaProduto;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_ENTREGA_FUTURA_FALTA, strTabela);
    End;

    If blnEntregaFuturaAguandandoCliente Then
    Begin
      If Assigned(FGravando) Then
        FGravando.lblGravando.Caption := 'Calculando saldos (Entrega Futura - Aguardando Cliente)...';

      strTabela := objGerarTabela.fTabelaEntregaFuturaAguandandoCliente;
      FTabelasSaldos.Add(strTabela);

      strSQLPtincipalAtualizado := AnsiReplaceStr(strSQLPtincipalAtualizado, TMP_ENTREGA_FUTURA_AGUARDA, strTabela);
    End;

    FreeAndNil(objGerarTabela);

    FGravando.pgbStatus.Visible := False;

    Result := True;
  End;
End;

Function TInterfaceRelatorio.fTiraSelect(strSQL: String): String;
  Var
    intPosSelect: Integer;
Begin
  Result := strSQL;
  intPosSelect := Pos(STR_SELECT_PRINCIPAL, strSQL);

  If intPosSelect > 0 Then
    Result := LeftStr(strSQL, Pred(intPosSelect));
End;

Procedure TInterfaceRelatorio.pSetCodPai(strValue: String);
  Var
    qryCadRel: TUniQuery;
Begin
  If strValue <> FCodPai Then
  Begin
    FCodPai := strValue;

    If strValue.IsEmpty Then
    Begin
      Fillchar(recDadosPai, SizeOf(recDadosPai), #0);

    End Else
    Begin
      qryCadRel := fCriaQuery(Nil);
      qryCadRel.SQL.Text := 'SELECT REL_SQLDEF, REL_DEFSQL FROM CADREL WHERE REL_CODREL = ' + QuotedStr(strValue);
      qryCadRel.Open;

      If Pos(STR_SELECT_PRINCIPAL, qryCadRel.FieldByName('REL_SQLDEF').AsString) = 0 Then
      Begin
        Fillchar(recDadosPai, SizeOf(recDadosPai), #0);

        pMensagemOk(Concat('A instrução SQL do relatório pai deve conter o comentário: ', STR_SELECT_PRINCIPAL,
                    ' antes do SELECT principal!'));
      End Else
      Begin
        recDadosPai.strSQLDEF := fTiraSelect(qryCadRel.FieldByName('REL_SQLDEF').AsString);
        recDadosPai.strDEFSQL := fTiraSelect(qryCadRel.FieldByName('REL_DEFSQL').AsString);
      End;

      FreeAndNil(qryCadRel);
    End;

  End;
End;

Function TInterfaceRelatorio.fSQLColunhasPorLinha: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   99 AS NROLIN, ';
  strSQL := strSQL + '   99 AS QTDCOL, ';
  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS DEFPRO ';
  Result := strSQL;
End;

Function TInterfaceRelatorio.fCarregaColunhasPorLinha: Boolean;
  Var
    stlDados: TStringList;
    intPos: Integer;
    intContador,
    intNroCol: Integer;
    strProporcao: String;
Begin
  Result := cdsColunasPorLinha.fLeDados('TInterfaceRelatorio.fCarregaColunhasPorLinha');
  cdsColunasPorLinha.EmptyDataSet;
  stlDados := TStringList.Create;
  stlDados.Text := FCadRel[0].FieldByName('REL_COLLIN').AsString;

  For intContador := 0 To stlDados.Count - 1 Do
  Begin
    cdsColunasPorLinha.Append;
    cdsColunasPorLinha.FieldByName('NROLIN').AsInteger := Succ(intContador);

    intPos := Pos('-', stlDados[intContador]);

    If intPos > 0 Then
    Begin
      intNroCol := StrToIntDef(LeftStr(stlDados[intContador], Pred(intPos)), 0);
      strProporcao := RightStr(stlDados[intContador], Length(stlDados[intContador]) - intPos);
    End Else
    Begin
      intNroCol := StrToIntDef(stlDados[intContador], 0);
      strProporcao := '';
    End;

    cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger := intNroCol;
    cdsColunasPorLinha.FieldByName('DEFPRO').AsString := strProporcao;

    cdsColunasPorLinha.Post;
  End;

  FreeAndNil(stlDados);

  pAjustColunhasPorLinha(FCadRel[0].FieldByName('REL_LINGRA').AsInteger);
End;

Procedure TInterfaceRelatorio.pAjustColunhasPorLinha(intNumLin: Integer);
  Var
    intContador: Integer;
Begin
  For intContador := Succ(cdsColunasPorLinha.RecordCount) To intNumLin  Do
  Begin
    cdsColunasPorLinha.Append;
    cdsColunasPorLinha.FieldByName('NROLIN').AsInteger := intContador;
    cdsColunasPorLinha.Post;
  End;

  While (cdsColunasPorLinha.RecordCount > intNumLin) And (cdsColunasPorLinha.RecordCount > 0) Do
  Begin
    cdsColunasPorLinha.Last;
    cdsColunasPorLinha.Delete;
  End;
End;

Function TInterfaceRelatorio.fValidaColunhasPorLinha: Boolean;
  Var
    intQtdCol: Integer;
    strValor: String;
Begin
  Result := True;

  If (Not objGeraFr3.fTemDestinoGraficoDashboard) And
     (Not objGeraFr3.fTemDestinoGrafico) Then
   Exit;

  If (FCadRel[0].FieldByName('REL_INFCOL').AsString <> 'S') And
     (Not objGeraFr3.fTemDestinoGraficoDashboard) Then
    Exit;

  intQtdCol := 0;
  cdsColunasPorLinha.First;
  While Not cdsColunasPorLinha.Eof Do
  Begin
    If cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger <= 0 Then
    Begin
      Result := False;
      pMensagemOk('Informe a quantidade de colunas por linha do layout de gráficos!');
      Exit;
    End;

    strValor := cdsColunasPorLinha.FieldByName('DEFPRO').AsString;

    If (fRetDestino In SET_GRAFICO_DASH) And
       (Not fEmptyStr(strValor)) And
       (Length(strValor.Split(['-'])) <> cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger) Then
    Begin
      Result := False;
      pMensagemOk('A proporção deve obedecer o número de colunas da linha!');
      Exit;
    End;

    Inc(intQtdCol, cdsColunasPorLinha.FieldByName('QTDCOL').AsInteger);

    cdsColunasPorLinha.Next;
  End;

  If intQtdCol < Succ(cdsComplementos.RecordCount) Then
  Begin
    Result := False;
    pMensagemOk('Total de colunas por linha do layout de gráficos é menor que o total de relatórios!');
    Exit;
  End;

  If intQtdCol > Succ(cdsComplementos.RecordCount) Then
  Begin
    Result := False;
    pMensagemOk('Total de colunas por linha do layout de gráficos é maior que o total de relatórios!');
    Exit;
  End;

End;

Procedure TInterfaceRelatorio.pSalvaColunhasPorLinha;
  Var
    stlDados: TStringList;
Begin
  If Not (FCadRel[0].State In dsEditModes) Then
    Exit;

  If Not cdsColunasPorLinha.Active Then
    Exit;

  stlDados := TStringList.Create;

  cdsColunasPorLinha.First;
  While Not cdsColunasPorLinha.Eof Do
  Begin
    stlDados.Add(cdsColunasPorLinha.FieldByName('QTDCOL').AsString + '-' + cdsColunasPorLinha.FieldByName('DEFPRO').AsString);
    cdsColunasPorLinha.Next;
  End;

  FCadRel[0].FieldByName('REL_COLLIN').AsString := stlDados.Text;

  FreeAndNil(stlDados);
End;

Function TInterfaceRelatorio.fSQLParamametrosAutomaticos: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   C.*,   ';
  strSQL := strSQL + '   1 AS PARVIS, ';
  strSQL := strSQL + '   1 AS IMPFIL, ';
  strSQL := strSQL + '   IF((PAR_SQLVIS <> "") OR (PAR_EXPVIS <> "") OR (PAR_EXPIMP <> ""), "Sim", "") AS PAR_CNDVIS ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADPRR C ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       PAR_SEQGER = :SEQGER ';
  strSQL := strSQL + '   AND PAR_AUTOMA = "S" ';

  Result := strSQL;
End;

Function TInterfaceRelatorio.fSQLParamametrosGatilho: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT   ';
  strSQL := strSQL + '   C.*,   ';
  strSQL := strSQL + '   CAST(REPLACE(PAR_NOMPAR, "GATILHO_", "") AS CHAR(70)) AS PARINI, ';
  strSQL := strSQL + '   1 AS PARVIS, ';
  strSQL := strSQL + '   1 AS IMPFIL ';
  strSQL := strSQL + ' FROM     ';
  strSQL := strSQL + '   CADPRR C ';
  strSQL := strSQL + ' WHERE    ';
  strSQL := strSQL + '       PAR_SEQGER = :SEQGER ';
  strSQL := strSQL + '   AND PAR_AUTOMA = "P" ';

  Result := strSQL;
End;

Function TInterfaceRelatorio.fCarregaParametrosAutomaticos(strSeqGer: String): Boolean;
  Var
    intContador: Integer;
    strComplemento,
    strIndex: String;
Begin
  Try
    cdsParametrosAutomaticos.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
    Result := cdsParametrosAutomaticos.fLeDados('TInterfaceRelatorio.fCarregaParametrosAutomaticos');

    If Result Then
    Begin
      For intContador := 1 To MAX_TABELAS_DINAMICAS Do
      Begin
        If intContador > 1 Then
        Begin
          strComplemento := '_' + intContador.ToString();
          strIndex := ' [' + intContador.ToString() + ']';
        End Else
        Begin
          strComplemento := '';
          strIndex := '';
        End;

        pIncluiParametroAutomatico('INVENTARIO' + strComplemento, 'Tabela de Inventário (I_*)' + strIndex);
        pIncluiParametroAutomatico('LOTES' + strComplemento, 'Tabela de Inventário - Lotes - (L_*)' + strIndex);
        pIncluiParametroAutomatico('ESTOQUE_EXTERNO' + strComplemento, 'Tabela de Estoque Externo (ESTEXT_*)' + strIndex);
        pIncluiParametroAutomatico('ENVIADO_TERCEIROS' + strComplemento, 'Estoque Enviado para Terceiros (ESTENV_*):' + strIndex);
        pIncluiParametroAutomatico('RECEBIDO_TERCEIROS' + strComplemento, 'Estoque Recebido de Terceiros (ESTENT_*):' + strIndex);
        pIncluiParametroAutomatico('SALINV' + strComplemento, 'Tabela de Inventário (SALINV*)' + strIndex);
      End;

      pIncluiParametroAutomatico('CTR_', 'Inventário Financeiro (CTR_*)');
      pIncluiParametroAutomatico(STR_PRECUS, 'Composição do Preço de Custo');
      pIncluiParametroAutomatico('DESTINO_REL', 'Destino');
      pIncluiParametroAutomatico('PAGINA_INICIAL', 'Página Inicial');
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TInterfaceRelatorio.fCarregaParametrosAutomaticos]');
    End;
  End;
End;

Procedure TInterfaceRelatorio.pIncluiParametroAutomatico(strNomPar, strDesPar: String);
Begin
  If Not cdsParametrosAutomaticos.FindKey([strNomPar]) Then
  Begin
    cdsParametrosAutomaticos.Append;
    cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString := strNomPar;
    cdsParametrosAutomaticos.FieldByName('PAR_DESPAR').AsString := strDesPar;
    cdsParametrosAutomaticos.FieldByName('PAR_AUTOMA').AsString := 'S';
    cdsParametrosAutomaticos.Post;
  End;
End;

Function TInterfaceRelatorio.fCarregaParametrosGatilho(strSeqGer: String): Boolean;
Begin
  Try
    cdsParametrosGatilho.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
    Result := cdsParametrosGatilho.fLeDados('TInterfaceRelatorio.fCarregaParametrosGatilho');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TInterfaceRelatorio.fCarregaParametrosGatilho]');
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAtualizaParametrosGatilho;
Begin
  FParams.DisableControls;
  FParams.Filter := 'PAR_GATPER = ' + QuotedStr('S');
  FParams.Filtered := True;
  FParams.First;

  While Not FParams.Eof Do
  Begin
    If Not cdsParametrosGatilho.locate('PARINI', FParams.FieldByName('PAR_NOMPAR').AsString, []) Then
      pIncluiParametroGatilho(FParams.FieldByName('PAR_NOMPAR').AsString,
                              FParams.FieldByName('PAR_PARFIN').AsString,
                              IIF(fEmptyStr(FParams.FieldByName('PAR_DESGAT').AsString),
                                  'Período ' + FParams.FieldByName('PAR_DESPAR').AsString,
                                  FParams.FieldByName('PAR_DESGAT').AsString),
                              FParams.FieldByName('PAR_CODGRU').AsString);

    FParams.Next;
  End;

  cdsParametrosGatilho.First;

  While Not cdsParametrosGatilho.Eof Do
  Begin
    If Not FParams.locate('PAR_NOMPAR', cdsParametrosGatilho.FieldByName('PARINI').AsString, []) Then
      cdsParametrosGatilho.Delete
    Else
      cdsParametrosGatilho.Next;
  End;

  FParams.Filtered := False;
  FParams.Filter := '';
  FParams.EnableControls;
End;

Procedure TInterfaceRelatorio.pIncluiParametroGatilho(strParIni, strParFin, strDesPar, strGruFil: String);
Begin
  If cdsParametrosGatilho.FindKey([strParIni]) Then
    cdsParametrosGatilho.Edit
  Else
    cdsParametrosGatilho.Append;

  cdsParametrosGatilho.FieldByName('PAR_NOMPAR').AsString := 'GATILHO_' + strParIni;
  cdsParametrosGatilho.FieldByName('PARINI').AsString     := strParIni;
  cdsParametrosGatilho.FieldByName('PAR_PARFIN').AsString := strParFin;
  cdsParametrosGatilho.FieldByName('PAR_DESPAR').AsString := strDesPar;
  cdsParametrosGatilho.FieldByName('PAR_CODGRU').AsString := strGruFil;
  cdsParametrosGatilho.FieldByName('PAR_AUTOMA').AsString := 'P';
  cdsParametrosGatilho.Post;
End;

Function TInterfaceRelatorio.fUsouTabelaDinamica(FTemTabela: TTemTabelaDinamica; strInicio, strNomPar: String): Boolean;
Begin
  Result := False;

  If SameText(strInicio, strNomPar) Then
  Begin
    Result := FTemTabela[1]
  End Else
  Begin
    strNomPar := RightStr(strNomPar, 2);
    If StrToIntDef(strNomPar, -1) = -1 Then
      strNomPar := RightStr(strNomPar, 1);

    If StrToIntDef(strNomPar, -1) In [1..MAX_TABELAS_DINAMICAS] Then
      Result := FTemTabela[StrToIntDef(strNomPar, -1)];
  End;
End;

Function TInterfaceRelatorio.fUsaParametroAutomatico(strNomPar: String): Boolean;
Begin
  If strNomPar.StartsWith('INVENTARIO') Then
    Result := fUsouTabelaDinamica(FTemTabelaI_, 'INVENTARIO', strNomPar)

  Else If strNomPar.StartsWith('LOTES') Then
    Result := fUsouTabelaDinamica(FTemTabelaL_, 'LOTES', strNomPar)

  Else If strNomPar.StartsWith('ESTOQUE_EXTERNO') Then
    Result := fUsouTabelaDinamica(FTemEstExt_, 'ESTOQUE_EXTERNO', strNomPar)

  Else If strNomPar.StartsWith('ENVIADO_TERCEIROS') Then
    Result := fUsouTabelaDinamica(FTemEstEnv_, 'ENVIADO_TERCEIROS', strNomPar)

  Else If strNomPar.StartsWith('RECEBIDO_TERCEIROS') Then
    Result := fUsouTabelaDinamica(FTemEstEnt_, 'RECEBIDO_TERCEIROS', strNomPar)

  Else If strNomPar.StartsWith('SALINV') Then
    Result := fUsouTabelaDinamica(FTemTabelaSALINV, 'SALINV', strNomPar)

  Else If SameText(strNomPar, 'CTR_') Then
    Result := FTemInventFinanc

  Else If SameText(strNomPar, STR_PRECUS) Then
    Result := FTemComposicaoCusto

  Else If SameText(strNomPar, 'DESTINO_REL') Then
    Result := Not fEmptyStr(cdsParametrosAutomaticos.FieldByName('PAR_GRUFIL').AsString)

  Else
    Result := False;
End;

Function TInterfaceRelatorio.fSalvaParametrosAutomaticos(strSeqGer: String): Boolean;
Begin
  cdsParametrosAutomaticos.DisableControls;
  cdsParametrosAutomaticos.First;

  While Not cdsParametrosAutomaticos.Eof Do
  Begin

    If Not fUsaParametroAutomatico(cdsParametrosAutomaticos.FieldByName('PAR_NOMPAR').AsString) Then
    Begin
      cdsParametrosAutomaticos.Delete;
    End Else
    Begin
      If fEmptyStr(cdsParametrosAutomaticos.FieldByName('PAR_SEQGER').AsString) Then
      Begin
        cdsParametrosAutomaticos.Edit;
        cdsParametrosAutomaticos.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADPRR', VS_strCodEmp);
        cdsParametrosAutomaticos.FieldByName('PAR_SEQGER').AsString := strSeqGer;
        cdsParametrosAutomaticos.Post;
      End;

      cdsParametrosAutomaticos.Next;
    End;

  End;

  Result := cdsParametrosAutomaticos.fSalva;
  cdsParametrosAutomaticos.EnableControls;
End;

Function TInterfaceRelatorio.fSalvaParametrosGatilho(strSeqGer: String): Boolean;
Begin
  cdsParametrosGatilho.DisableControls;
  cdsParametrosGatilho.First;

  While Not cdsParametrosGatilho.Eof Do
  Begin

    If fEmptyStr(cdsParametrosGatilho.FieldByName('PAR_SEQGER').AsString) Then
    Begin
      cdsParametrosGatilho.Edit;
      cdsParametrosGatilho.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADPRR', VS_strCodEmp);
      cdsParametrosGatilho.FieldByName('PAR_SEQGER').AsString := strSeqGer;
      cdsParametrosGatilho.Post;
    End;

    cdsParametrosGatilho.Next;

  End;

  Result := cdsParametrosGatilho.fSalva;
  cdsParametrosGatilho.EnableControls;
End;

Procedure TInterfaceRelatorio.pPedeDadosParametrosAutomaticos(strNomPar: String);
  Var
    strTmpExpVis,
    strTmpExpImp,
    strTmpSqlVis: string;
    intContador: Integer;
    sltLista: TStringList;
    dssState: TDataSetState;
Begin
  Try
    Try
      If Pos(strNomPar, STR_PRECUS + '-INVENTARIO-LOTES-ESTOQUE_EXTERNO-SALINV-ENVIADO_TERCEIROS-RECEBIDO_TERCEIROS-PAGINA_INICIAL-DESTINO_REL') > 0 Then
      Begin
        sltLista := TStringList.Create;
        sltLista.Add('PAR_NOMPAR = ' + QuotedStr(strNomPar));

        For intContador := 2 To MAX_TABELAS_DINAMICAS Do
          sltLista.Add('PAR_NOMPAR = ' + QuotedStr(strNomPar + '_' + intContador.ToString()));

        cdsParametrosAutomaticos.Filter := fCommaText(sltLista, False, ' OR ');

        cdsParametrosAutomaticos.Filtered := True;

        FreeAndNil(sltLista);
      End;

      If Not cdsParametrosAutomaticos.FindKey([strNomPar]) Then
        Exit;

      FParamsCopia.Data := cdsParams.Data;

      cdsParametrosAutomaticos.Edit;

      pCriarFormularios(TfrmPedeDadosInterfaceAutomatico, frmPedeDadosInterfaceAutomatico);

      frmPedeDadosInterfaceAutomatico.strNomPar := strNomPar;
      frmPedeDadosInterfaceAutomatico.dtsCadPar.DataSet := cdsParametrosAutomaticos;

      frmPedeDadosInterfaceAutomatico.objInterface := Self;

      frmPedeDadosInterfaceAutomatico.pnlVisible.Visible := strNomPar <> 'DESTINO_REL';
      frmPedeDadosInterfaceAutomatico.lblExpImp.Visible  := strNomPar <> 'DESTINO_REL';
      frmPedeDadosInterfaceAutomatico.dbeExpImp.Visible  := strNomPar <> 'DESTINO_REL';

      strTmpExpVis := cdsParametrosAutomaticos.FieldByName('PAR_EXPVIS').AsString;
      strTmpExpImp := cdsParametrosAutomaticos.FieldByName('PAR_EXPIMP').AsString;
      strTmpSqlVis := cdsParametrosAutomaticos.FieldByName('PAR_SQLVIS').AsString;

      dssState := cdsParametrosAutomaticos.State;

      If frmPedeDadosInterfaceAutomatico.ShowModal = mrOk Then
      Begin

        case dssState of
          dsBrowse : cdsParametrosAutomaticos.Cancel;
          dsEdit   : cdsParametrosAutomaticos.Edit;
          dsInsert : cdsParametrosAutomaticos.Insert;
        end;

        If cdsParametrosAutomaticos.State = dsEdit Then
        Begin
          cdsParametrosAutomaticos.FieldByName('PAR_CNDVIS').AsString := '';

          if cdsParametrosAutomaticos.FieldByName('PAR_SQLVIS').AsString <> '' then
            cdsParametrosAutomaticos.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          if cdsParametrosAutomaticos.FieldByName('PAR_EXPVIS').AsString <> '' then
            cdsParametrosAutomaticos.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          if cdsParametrosAutomaticos.FieldByName('PAR_EXPIMP').AsString <> '' then
            cdsParametrosAutomaticos.FieldByName('PAR_CNDVIS').AsString  := 'Sim';

          cdsParametrosAutomaticos.FieldByName('IMPFIL').AsInteger := 1;

          cdsParametrosAutomaticos.Post;
        End;
      End Else
      Begin
        If cdsParametrosAutomaticos.State = dsEdit Then
        Begin
            cdsParametrosAutomaticos.Cancel;
          // Corrigindo eventual expressão que ficou salva quando passou pelo fTrocaBrancoNomeColunaCheckList
          // Pois a validação da expressão ocorre depois que essa função já deu Post no FParams ao aplicar o Filtered
          // Então quando fecha e abre novamente, a expressão inválida acusada estará preenchida como se não tivesse sido validada
          if not fCompilaExpressao(frmPedeDadosInterfaceAutomatico.dbeExpVis.Text, '', True, True) then
          begin
            // Voltando valor antigo da empressão que foi validada mas salva indevidamente antes da validação
            cdsParametrosAutomaticos.Edit;
            cdsParametrosAutomaticos.FieldByName('PAR_EXPVIS').AsString := strTmpExpVis;
            cdsParametrosAutomaticos.FieldByName('PAR_EXPIMP').AsString := strTmpExpImp;
            cdsParametrosAutomaticos.FieldByName('PAR_SQLVIS').AsString := strTmpSqlVis;
            cdsParametrosAutomaticos.Post;
          end;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TInterfaceRelatorio.pPedeDadosInterfaceAutomatico]');
      End;
    End;

  Finally
    cdsParametrosAutomaticos.Filtered := False;
  End;

  If cdsParametrosAutomaticos.state = dsEdit Then
    cdsParametrosAutomaticos.Cancel;

  pFreeAndNil(frmPedeDadosInterfaceAutomatico);
End;

Function TInterfaceRelatorio.fValidaParametroFinal: Boolean;
Begin
  Result := True;
  cdsParams.DisableControls;

  Try
    FParamsCopia.Data := cdsParams.Data;
    FParamsCopia.IndexFieldNames := 'PAR_NOMPAR';

    cdsParams.Filter := 'PAR_PARFIN <> ''''';
    cdsParams.Filtered := True;
    cdsParams.First;

    While Not cdsParams.Eof Do
    Begin
      If Not FParamsCopia.FindKey([cdsParams.FieldByName('PAR_PARFIN').AsString]) Then
      Begin
        pMensagemOk('Parâmetro ' + cdsParams.FieldByName('PAR_PARFIN').AsString + ' não econtrado!');
        Result := False;
        Exit;
      End;

      If Not SameText(FParamsCopia.FieldByName('PAR_TIPPAR').AsString, 'Data') Then
      Begin
        pMensagemOk('Parâmetro ' + cdsParams.FieldByName('PAR_PARFIN').AsString + ' não é do tipo Data!');
        Result := False;
        Exit;
      End;

      cdsParams.Next;
    End;

  Finally
    cdsParams.EnableControls;
    cdsParams.Filtered := False;
  End;
End;

Function TInterfaceRelatorio.fSQLCamposRodape: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT          ';
  strSQL := strSQL + '   C.CAM_NOMCAM, ';
  strSQL := strSQL + '   C.CAM_DESCAM, ';
  strSQL := strSQL + '   C.CAM_LARGUR, ';
  strSQL := strSQL + '   C.CAM_ORDROD, ';
  strSQL := strSQL + '   C.CAM_NOVROD, ';
  strSQL := strSQL + '   C.CAM_ALTURA, ';
  strSQL := strSQL + '   C.CAM_POSREL, ';
  strSQL := strSQL + '   C.CAM_REFROD, ';

  strSQL := strSQL + '   CASE C.CAM_POSREL ';
  strSQL := strSQL + '     WHEN 0 THEN "Abaixo, alinhado pelo conteúdo" ';
  strSQL := strSQL + '     WHEN 1 THEN "Abaixo, alinhado pelo título" ';
  strSQL := strSQL + '     WHEN 2 THEN "Direita" ';
  strSQL := strSQL + '   END AS POSREL ';

  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CADCAM C                 ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       CAM_ORDROD > 0       ';
  strSQL := strSQL + '   AND CAM_SEQGER = :SEQGER ';
  strSQL := strSQL + ' ORDER BY CAM_ORDROD        ';
  Result := strSQL;
End;

Function TInterfaceRelatorio.fCarregaCamposRodape(strSeqGer: String): Boolean;
Begin
  Try
    cdsCamposRodape.qryQuery.ParamByName('SEQGER').AsString := strSeqGer;
    Result := cdsCamposRodape.fLeDados('TInterfaceRelatorio.fCarregaCamposRodape');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.message, '[TInterfaceRelatorio.fCarregaCamposRodape]');
    End;
  End;
End;

Procedure TInterfaceRelatorio.pAfterPostCamposRodape(dataSet: TDataSet);
Begin
  pCopiaCampoRodape(TZClient(dataSet), FCampos);
End;

Procedure TInterfaceRelatorio.pBeforePostCamposRodape(dataSet: TDataSet);
Begin
  Case cdsCamposRodape.FieldByName('CAM_POSREL').AsInteger Of
    0: cdsCamposRodape.FieldByName('POSREL').AsString := 'Abaixo, alinhado pelo conteúdo';
    1: cdsCamposRodape.FieldByName('POSREL').AsString := 'Abaixo, alinhado pelo título';
    2: cdsCamposRodape.FieldByName('POSREL').AsString := 'Direita';
  End;
End;

Procedure TInterfaceRelatorio.pCopiaCampoRodape(cdsOrigem, cdsDestino: TZClient);
  Var
    prcAfterPost: TAfterPost;
Begin
  prcAfterPost := cdsDestino.AfterPost;

  Try
    cdsDestino.AfterPost := Nil;

    If cdsDestino.Locate('CAM_NOMCAM', cdsOrigem.FieldByName('CAM_NOMCAM').AsString, []) Then
    Begin
      cdsDestino.Edit;
      cdsDestino.FieldByName('CAM_DESCAM').Value := cdsOrigem.FieldByName('CAM_DESCAM').Value;
      cdsDestino.FieldByName('CAM_LARGUR').Value := cdsOrigem.FieldByName('CAM_LARGUR').Value;
      cdsDestino.FieldByName('CAM_ALTURA').Value := cdsOrigem.FieldByName('CAM_ALTURA').Value;
      cdsDestino.FieldByName('CAM_ORDROD').Value := cdsOrigem.FieldByName('CAM_ORDROD').Value;
      cdsDestino.FieldByName('CAM_NOVROD').Value := cdsOrigem.FieldByName('CAM_NOVROD').Value;
      cdsDestino.FieldByName('CAM_POSREL').Value := cdsOrigem.FieldByName('CAM_POSREL').Value;
      cdsDestino.FieldByName('CAM_REFROD').Value := cdsOrigem.FieldByName('CAM_REFROD').Value;
      cdsDestino.Post;
    End;

    cdsDestino.AfterPost := prcAfterPost;

  Except
    On E: Exception Do
    Begin
      cdsDestino.AfterPost := prcAfterPost;
      pMensagensErro(E.message, '[TInterfaceRelatorio.pCopiaCampoRodape]');
    End;
  End;

End;

procedure TInterfaceRelatorio.pExcluiCampoRodape;
Begin
  If cdsCamposRodape.IsEmpty Then
    Exit;

  If Not fPergunta('Confirma a exclusão do campo ' + cdsCamposRodape.FieldByName('CAM_DESCAM').AsString + ' do rodapé?') Then
    Exit;

  // FAZ AFTERPOST ATUALIZANDO O FCampos
  cdsCamposRodape.Edit;
  cdsCamposRodape.FieldByName('CAM_ORDROD').Clear;
  cdsCamposRodape.Post;

  cdsCamposRodape.Delete;
End;

procedure TInterfaceRelatorio.pIncluiCampoRodape(strNomCam, strCampoReferencia: String; intPosicao: Integer);
  Var
    intMax: Integer;
Begin

  If cdsCamposRodape.Locate('CAM_NOMCAM', strNomCam, []) Then
  Begin
    cdsCamposRodape.Edit;
    cdsCamposRodape.FieldByName('CAM_POSREL').Value := intPosicao;
    cdsCamposRodape.FieldByName('CAM_REFROD').Value := strCampoReferencia;
    cdsCamposRodape.Post;
  End Else
  Begin

    If FCampos.Locate('CAM_NOMCAM', strNomCam, []) Then
    Begin
      intMax := Trunc(cdsCamposRodape.fRetSoma('MAX_ORDROD'));

      cdsCamposRodape.Insert;
      cdsCamposRodape.FieldByName('CAM_NOMCAM').Value := FCampos.FieldByName('CAM_NOMCAM').Value;
      cdsCamposRodape.FieldByName('CAM_DESCAM').Value := FCampos.FieldByName('CAM_DESCAM').Value;
      cdsCamposRodape.FieldByName('CAM_LARGUR').Value := FCampos.FieldByName('CAM_LARGUR').Value;
      cdsCamposRodape.FieldByName('CAM_POSREL').Value := intPosicao;
      cdsCamposRodape.FieldByName('CAM_REFROD').Value := strCampoReferencia;

      cdsCamposRodape.FieldByName('CAM_ORDROD').Value := Succ(intMax);
      cdsCamposRodape.FieldByName('CAM_NOVROD').Value := 'N';
      cdsCamposRodape.Post;
    End;

  End;

End;

Procedure TInterfaceRelatorio.pDecOrdemRodape(cxvRodape: TcxGridDBTableView);
  Var
    strCodPar: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  strCodPar   := cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString;
  intOrdAtual := cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger;

  cxvRodape.NavigatorButtons.Prior.Click;

  If cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString = strCodPar Then
    Exit;

  intOrdNova := cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger;
  cdsCamposRodape.Edit;
  cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger := intOrdAtual;
  cdsCamposRodape.Post;

  If cdsCamposRodape.Locate('CAM_NOMCAM', strCodPar, []) Then
  Begin
    cdsCamposRodape.Edit;
    cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger := intOrdNova;
    cdsCamposRodape.Post;
  End;
End;

Procedure TInterfaceRelatorio.pIncOrdemRodape(cxvRodape: TcxGridDBTableView);
  Var
    strCodCam: String;
    intOrdAtual,
    intOrdNova: Integer;
Begin
  strCodCam   := cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString;
  intOrdAtual := cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger;

  cxvRodape.NavigatorButtons.Next.Click;

  If cdsCamposRodape.FieldByName('CAM_NOMCAM').AsString = strCodCam Then
    Exit;

  intOrdNova := cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger;
  cdsCamposRodape.Edit;
  cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger := intOrdAtual;
  cdsCamposRodape.Post;

  If cdsCamposRodape.Locate('CAM_NOMCAM', strCodCam, []) Then
  Begin
    cdsCamposRodape.Edit;
    cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger := intOrdNova;
    cdsCamposRodape.Post;
  End;
End;

Function TInterfaceRelatorio.fValidaOrdemCamposRodape: Boolean;
Begin
  Result := True;

  Try
   cdsCampos.DisableControls;
   cdsCamposRodape.DisableControls;

   While Not cdsCamposRodape.Eof Do
   Begin
     If (Not fEmptyStr(cdsCamposRodape.FieldByName('CAM_REFROD').AsString)) And
        cdsCampos.Locate('CAM_NOMCAM', cdsCamposRodape.FieldByName('CAM_REFROD').AsString, []) And
        (cdsCampos.FieldByName('CAM_ORDROD').AsInteger > cdsCamposRodape.FieldByName('CAM_ORDROD').AsInteger) Then
      Begin
        pMensagemOk('O campo de referência deve vir antes do campo que o está referenciando!');
        Result := False;
        Exit;
      End;

     cdsCamposRodape.Next;
   End;

  Finally
    cdsCampos.EnableControls;
    cdsCamposRodape.EnableControls;
  End;
End;

procedure TInterfaceRelatorio.pGravaLogPaf(strSucesso, strResultado: String);
  Var
    qryLog: TUniQuery;
    strSQL: String;
    dtaIni, dtaFin: TDateTime;
Begin
  // função de log para geração de arquivos PAF de Santa Catarina,

  if not Assigned(FGeraFr3) then
    exit;

  if SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_ASSDIG').AsString, 'N')
    and SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_XMLPAF').AsString, 'N') then
    exit;

  dtaIni := StrToDateTime(fRetDado(fRetRowDado('DTAINI')));
  dtaFin := StrToDateTime(fRetDado(fRetRowDado('DTAFIN')));

  qryLog := fCriaQuery(Nil, conConexaoRelatorio.objConexao);

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO RELPAF (';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  PAF_CODREL, ';
  strSQL := strSQL + '  PAF_EMPLOG, ';
  strSQL := strSQL + '  PAF_ARQUIV, ';
  strSQL := strSQL + '  PAF_DTAGER, ';
  strSQL := strSQL + '  PAF_HRAGER, ';
  strSQL := strSQL + '  PAF_DINGER, ';
  strSQL := strSQL + '  PAF_DFIGER, ';
  strSQL := strSQL + '  PAF_SUCESS, ';
  strSQL := strSQL + '  PAF_RESULT ';
  strSQL := strSQL + ') VALUES (';
  strSQL := strSQL + '  :AUTOIN, ';
  strSQL := strSQL + '  :CODREL, ';
  strSQL := strSQL + '  :EMPLOG, ';
  strSQL := strSQL + '  :ARQUIV, ';
  strSQL := strSQL + '  CURRENT_DATE, ';
  strSQL := strSQL + '  CURRENT_TIME, ';
  strSQL := strSQL + '  :DINGER, ';
  strSQL := strSQL + '  :DFIGER, ';
  strSQL := strSQL + '  :SUCESS, ';
  strSQL := strSQL + '  :RESULT ';
  strSQL := strSQL + ')';

  qryLog.SQL.Text := strSQL;

  qryLog.ParamByName('AUTOIN').AsString := fRetAutoIncrem('RELPAF', VS_strCodEmp);
  qryLog.ParamByName('CODREL').AsString := FGeraFr3.arrCadRel[0].FieldByName('REL_CODREL').AsString;
  qryLog.ParamByName('EMPLOG').AsString := VS_strCodEmp;
  qryLog.ParamByName('ARQUIV').AsString := fRetornaValorVariavel('@NUMERO_ARQUIVO', False);
  qryLog.ParamByName('DINGER').AsDate := dtaIni;
  qryLog.ParamByName('DFIGER').AsDate := dtaFin;
  qryLog.ParamByName('SUCESS').AsString := strSucesso;
  qryLog.ParamByName('RESULT').AsString := strResultado;

  qryLog.ExecSQL;

  FreeAndNil(qryLog);
end;

procedure TInterfaceRelatorio.pGravaLogExecucao(strResultado: String);
Var
  qryLog: TUniQuery;
  strParams,
  strAutInc,
  strValPar,
  strAutIncLog,
  strAutIncLod: String;
  intContador: Integer;
Begin
  If Not Assigned(FGeraFr3) Then
    exit;

  If SameText(FGeraFr3.arrCadRel[0].FieldByName('REL_GERLOG').AsString, 'N') Then
    exit;

  strParams := '';
  If (ParamCount > 0) Then
  Begin
    For intContador := 1 To ParamCount Do
    Begin
      strParams := strParams + IIF(strParams.IsEmpty, '', ' ') + ParamStr(intContador);
    End;
  End;

  qryLog := fCriaQuery(Nil, conConexaoRelatorio.objConexao);

  Try
    Try
      fStartTransaction;

      qryLog.SQL.Text := 'INSERT INTO RELLOG (' +
                         '  AUTOINCREM, ' +
                         '  LOG_CODREL, ' +
                         '  LOG_DTALOG, ' +
                         '  LOG_HORLOG, ' +
                         '  LOG_PARAMS, ' +
                         '  LOG_CODOPE, ' +
                         '  LOG_CODEMP, ' +
                         '  LOG_RESULT  ' +
                         ') VALUES ( ' +
                         '  :AUTINC,    ' +
                         '  :CODREL,    ' +
                         '  :DTALOG,    ' +
                         '  :HORLOG,    ' +
                         '  :PARAMS,    ' +
                         '  :CODOPE,    ' +
                         '  :CODEMP,    ' +
                         '  :RESULT     ' +
                         ') ';

      strAutIncLog := fRetAutoIncrem('RELLOG', VS_strCodEmp);

      qryLog.ParamByName('AUTINC').AsString := strAutIncLog;
      qryLog.ParamByName('CODREL').AsString := FGeraFr3.arrCadRel[0].FieldByName('REL_CODREL').AsString;
      qryLog.ParamByName('DTALOG').AsString := FormatDateTime('yyyy-MM-dd', fNow);
      qryLog.ParamByName('HORLOG').AsString := FormatDateTime('HH:mm:ss', fNow);
      qryLog.ParamByName('PARAMS').AsString := strParams;
      qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryLog.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryLog.ParamByName('RESULT').AsString := strResultado;

      qryLog.ExecSQL;

      qryLog.Close;
      qryLog.SQL.Clear;

      qryLog.SQL.Text := 'INSERT INTO RELLOD (' +
                         '  AUTOINCREM, ' +
                         '  LOG_SEQGER, ' +
                         '  VAL_CODOPE, ' +
                         '  VAL_MULSEL, ' +
                         '  VAL_NOMPAR, ' +
                         '  VAL_SEQGER, ' +
                         '  VAL_ULTVAL  ' +
                         ') VALUES ( ' +
                         '  :AUTINC,    ' +
                         '  :INCLOG,    ' +
                         '  :CODOPE,    ' +
                         '  :MULSEL,    ' +
                         '  :NOMPAR,    ' +
                         '  :SEQGER,    ' +
                         '  :ULTVAL     ' +
                         ') ';

      strAutInc := fCampoTabela('AUTOINCREM', 'CADREL', ['REL_CODREL'], [FCadRel[0].FieldByName('REL_CODVAL').AsString]);

      For intContador := 0 To FFiltros.Rows.Count - 1 do
      If (Not FFiltros.Rows[intContador].IsCategory) Then
      Begin

        qryLog.Close;

        strAutIncLod := fRetAutoIncrem('RELLOD', VS_strCodEmp);

        qryLog.ParamByName('AUTINC').AsString := strAutIncLod;
        qryLog.ParamByName('INCLOG').AsString := strAutIncLog;
        qryLog.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryLog.ParamByName('MULSEL').AsString := 'N';
        qryLog.ParamByName('NOMPAR').AsString := TcxEditorRow(FFiltros.Rows[intContador]).Name;
        qryLog.ParamByName('SEQGER').AsString := strAutInc;

        If fTemMultiSelecao(TcxEditorRow(FFiltros.Rows[intContador]).Name) Then
        Begin
          strValPar := FValueParams.FieldByName('VALPAR').AsString;
          Delete(strValPar, 1, Length(' IN ('));
          strValPar := LeftStr(strValPar, Length(strValPar) -1);

          If fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList Then
            qryLog.ParamByName('ULTVAL').AsString := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value
          Else
            qryLog.ParamByName('ULTVAL').AsString := strValPar;

          qryLog.ParamByName('MULSEL').AsString := 'S';
        End

        Else If TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value <> Null Then
        Begin
          qryLog.ParamByName('ULTVAL').AsString := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value
        End

        Else
          qryLog.ParamByName('ULTVAL').Clear;

        qryLog.ExecSQL;

      End;

      fCommit;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pGravarErro(True, 'Erro Log de Relatórios', E.message);
      End;
    End;

  Finally
    FreeAndNil(qryLog);
  End;
End;

Function TInterfaceRelatorio.fGetLinhaComando: String;
  Var
    intContador: Integer;
    strNomPar,
    strValPar: String;
Begin
  Result := '';

  If (Not fVerificaCampos) Then
    Exit;

  Result := Result + 'autcom.exe ';
  Result := Result + 'EXPORTACAO_RELATORIO ' ;
  Result := Result + FCadRel[0].FieldByName('REL_CHAVE_').AsString + ' ';
  Result := Result + VS_strCodEmp + ' ';
  Result := Result + strLoginUsuarioLogado + ' ';

  For intContador := 0 To FFiltros.Rows.Count - 1 do
  If Not FFiltros.Rows[intContador].IsCategory Then
  //If (Assigned(FParamValidacao) And FParamValidacao.FindKey([TcxEditorRow(FFiltros.Rows[intContador]).Name])) Then
  Begin
    strNomPar := TcxEditorRow(FFiltros.Rows[intContador]).Name;
    strValPar := '';

    If fTemMultiSelecao(TcxEditorRow(FFiltros.Rows[intContador]).Name) Then
    Begin
      strValPar := FValueParams.FieldByName('VALPAR').AsString;
      Delete(strValPar, 1, Length(' IN ('));
      strValPar := LeftStr(strValPar, Length(strValPar) -1);

      If fGetTipoInterface(FParams.FieldByName('PAR_TIPFAC').AsString) = facCustomCheckList Then
        strValPar := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value;

      strValPar := '(IN)' + strValPar;
    End

    Else If TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value <> Null Then
    Begin
      strValPar := TcxEditorRow(FFiltros.Rows[intContador]).Properties.Value
    End

    Else
      strValPar := '';

    Result := Result + '"' + strNomPar + '"="' + strValPar + '" ';
  End;

End;

Function TInterfaceRelatorio.fExisteComplementos: Boolean;
Begin
  Result := not FComplementos.IsEmpty;
End;

Function TInterfaceRelatorio.fExisteChild: Boolean;
Begin
  Result := not FChilds.IsEmpty;
End;

Function TInterfaceRelatorio.fExtraiCamposTemplate(strTexto: String; Var Campos: TArray<string>): Boolean;
var
  Regex: TRegEx;
  Matches: TMatchCollection;
  I: Integer;
begin
  strTexto := AnsiReplaceStr(strTexto, STRING_QUEBRA, STRING_ENTER);

  Regex := TRegEx.Create('<<([^>]+)>>');
  Matches := Regex.Matches(strTexto);

  SetLength(Campos, Matches.Count);

  for I := 0 to Matches.Count - 1 do
    Campos[I] := Matches[I].Groups[1].Value;

  Result := True;
end;

Function TInterfaceRelatorio.fVerificaCamposTemplate(strTexto: String): Boolean;
  Var
    Campos: TArray<string>;
    I: Integer;
Begin
  Result := True;

  If Trim(strTexto).IsEmpty Then
    Exit;

  If Not fExtraiCamposTemplate(strTexto, Campos) Then
    Exit;

  for I := Low(Campos) to High(Campos) do
  begin
    If Campos[I] = 'URL_DASHBOARD' then
      Continue;

    If Not FCampos.Locate('CAM_NOMCAM', Campos[i], []) Then
    Begin
      Result := False;
      pMensagemOk('Campo não encontrado: ' + Campos[i]);
      break;
    End;
  end;

  SetLength(Campos, 0);
End;

procedure TInterfaceRelatorio.pGravaGatilhoRelatorio(strNumWpp, strEmail, strAssunto, strCorpo, strArquivo, strJSonWhatsApp: String);
var
  LArquivos: TArray<TRecArquivosGatilhos>;
Begin
  if not Assigned(FGeraFr3) then
    exit;

  If (not FGeraFr3.blnEnviarGatWpp) and (not FGeraFr3.blnEnviarGatEma) then
    exit;

  If (strArquivo = '') then
    exit;

  if (strNumWpp = '') And (strEmail = '') then
    exit;

  SetLength(LArquivos, Length(LArquivos)+1);
  LArquivos[High(LArquivos)] := TRecArquivosGatilhos.Create(strAssunto,
                                                            strArquivo,
                                                            EmptyStr);

  TDllGatIme
    .fNew
    .fGravarGatilhoImediato(TRecGatilhoImediato
                              .Create(strAssunto,
                                      strCorpo,
                                      LArquivos,
                                      strJSonWhatsApp,
                                      EmptyStr,
                                      strNumWpp,
                                      strEmail)
                            );
end;

procedure TInterfaceRelatorio.pAdicionaArquivoPontoImpressao(intQuerie: Integer);
var
  strPonto: String;
begin
  strPonto := fRetornaPontoImpressao(intQuerie);

  if (fEmptyStr(strPonto)) then
    Exit;

  SetLength(FArquivosPontoImpressao, Length(FArquivosPontoImpressao)+1);

  FArquivosPontoImpressao[Length(FArquivosPontoImpressao)-1].strArquivo := fRetornaNomeArquivo(intQuerie);

  If (strPonto.StartsWith('CFG_')) And (strPonto.Length = 10) Then
  Begin
    FArquivosPontoImpressao[Length(FArquivosPontoImpressao)-1].strCfg := strPonto;

    strPonto := AnsiReplaceStr(strPonto, 'CFG_', '');
    FArquivosPontoImpressao[Length(FArquivosPontoImpressao)-1].strPontoImpressao := fCfgSis(strPonto, varString);
  End
  Else
  Begin
    FArquivosPontoImpressao[Length(FArquivosPontoImpressao)-1].strPontoImpressao := strPonto;
    FArquivosPontoImpressao[Length(FArquivosPontoImpressao)-1].strCfg := '';
  End;

end;

Function TInterfaceRelatorio.fRetornaFilaMeta: String;
Begin
  Result := FCadRel[0].FieldByName('REL_WIDDIS').AsString;
    If fEmptyStr(Result) then
      Result := fRetFilaEnvioWhatsAppOperadorRelatorio(fCfgSis('GATOPE'));
End;

Function TInterfaceRelatorio.fRetornaFileMetaOficial: Boolean;
Begin
  Result := fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [fRetornaFilaMeta]) = 'S';
End;

Function TInterfaceRelatorio.fRetornaUrlGrafico: String;
Begin
  Result := strUrlGrafico;

  If (fRetornaFileMetaOficial) Then
    Result := Result.Replace('https://dashboard.citelsoftware.com.br/', '');

End;

end.


