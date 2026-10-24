unit untCotacao;

interface

Uses
  frxExportXLS,
  frxClass,
  frxExportPDF,
  frxDBSet,
  Classes,
  System.UITypes,
  cxGridCustomView,
  untItensCotacaoSemCotacao,
  Vcl.Graphics,
  Windows,
  SysUtils,
  Controls,
  ComCtrls,
  StdCtrls,
  dxCore,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untZClient,
  StrUtils,
  Math,
  Variants,
  cxProgressBar,
  untTypesSistema,
  untConstantes,
  untFuncoes,
  System.IniFiles,
  untFuncoesSimples,
  untFuncoesPedidoSimples,
  untImpostosReformaCompra,
  untTConfiguracao,
  untParCalculaPrecoCusto,
  untCdsDigMultLoja,
  untExcel,
  untGeraExcel,
  untDuplicatasPedidoCompra,
  untRequisicaoPedidoCompra,
  untGravando,
  untLiberacao,
  untGeraExcelHtml,Winapi.ShlObj,
  untImportCotacaoItens,
  untTPreparaPedidosCotacao,
  Cotacao.ApiPrecos.ConstAndTypes,
  pitstop.comunicacao,
  ancora.comunicacao,
  SkyPecas.Comunicacao,
  untCotacaoTypesAndConst;


Type

  TCotacao = Class(TZClient)
    Private
      RedeAncora: TRedeAncora;
      RedeSkyPecas: TRedeSkyPecas;
      RedePitStop: TRedePitStop;
      sqlPrecomImp: String;
      sqlPrecomImp_COT: String;
      sqlPrecomImp_COT_COM: String;

      sqlFreEntImp: String;
      sqlFreEntImp_COT: String;
      sqlFreEntImp_COT_COM : String;

      ANCORA_LOGO: TResourceStream;
      PITSTOP_LOGO: TResourceStream;
      SKYPECAS_LOG: TResourceStream;

      FFornecApi: TStringList;

      cfgfrmCus: Integer;

      FblnCOTSIM: Boolean;
      frxReportJ: TfrxReport;
      AcaoParaItensSemCotacao: TAcaoParaItensSemCotacao;
      blnAtualizaMltLojaDepois : Boolean;
      FMarDes,
      strCampoSaldoAdd: String;

      blnUsaColeta: Boolean;
      blnIncluiuGerRes : Boolean;

      recCotGer: TReCotGer;

      objRequisicao: TRequisicaoPedidoCompra;

      fltALPISP,
      fltALCOFP: Double;

      FAtualizarDadosSintetizados,
      FSintetizarItens: Boolean;

      objDuplicatasPedido: TDuplicatasPedidoCompra;

      FArrCodCta: TarrCodCtaFornec;

      strForFil : String;
      blnLibPcm : Boolean;
      intDeqTpc : Integer;
      intCPRANC : Integer;

      fltValFrePed,
      fltDesAcePed,
      fltTotSubPed,
      fltSubFCPPed,
      fltTotItePed,
      fltTotIcmDes,
      fltTotIpiPed,
      fltTotVlrPed,

      fltValFreGer,
      fltDesAceGer,
      fltTotIteGer,
      fltValFreRes,
      fltDesAceRes: Double;
      recDimFrm: TRecDimFrm;
      FAutGer,
      FMarcaAtuPre: String;

      FdtaDtaAtu: TDateTime;

      FcdsItensImportacao: TUniCLientDataSet;

      qryRePrFo,
      qryGenIte: TUniQuery;

      FFiltrarItens,
      FRecalcularPreco,
      FMantemPrecoVendaOuMargemDigitada: Boolean;

      blnTabPrf: Boolean;
      FqryCodCna,
      FqryConsulta,
      FLoadPrecos,
      FUpdateJaAtu,
      qryNovoItem: TUniQuery;

      strNumCot: String;

      FfrmGravandoCorrente: TFrmGravando;

      FItensGerados,
      FListaItensPendentes,
      FListaAutIncCotacao: TStringList;

      FColForIniExcel,
      FPosicaoExcluido: Integer;

      FCodForExportacao: String;
      FIndForExportacao: Integer;

      FstrFilter,
      strDirExp,
      strDirImp: String;

      TipoUnidade: TTipoUnidade;

      FExportarSemPreco,
      FSelecionados,
      FManterEscolhido,
      FEsvaziouItens: Boolean;
      FLimpaRequisicao: Boolean;

      FExcluidos: TStringList; 

      FstcStatus: TStatusCotacao;
      cpcParams: TParCalculaPrecoCusto;
      FRecalculouPrecos: Boolean; 

      arrCampos: TarrCamposPedCompra;
      arrCamposAgg: TarrCamposAggPedCompra;
      blnUtilizouGiro : Boolean;

      strField: String;
      strCodGirOriginal : String;
      blnSubstTodos: Boolean;
      blnEXILCC: Boolean;

      Function fJaGerouPedido: Boolean;
      function fRetCodCta(strCodFor: String): String;
      Procedure pInsereCadIntExtra(strCodGirOriginal, strSeqGerNovo: String; strNomFrm: String);
      Function fReplicaDadosPrg(pgbProgresso: TcxProgressBar): Boolean;
      function fIncluiComHeranca(Var strAutInc: String; blnCopiaSeguranca: Boolean): Boolean;
      function fIncluiItensFornecHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
      function fIncluiFornecedoresHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
      function fIncluiItensHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
      function fIncluiItensMultilojasHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
      function fVeSeBaixaCotacao: Boolean;
      Function fTrataCodFab(dtsDados: TDataSet): String;
      Function fRetTotalCotacao(cdsDados: TDataSet; strIndFor: String): Double;

      function fCodForToIndex(strCodFor: String): Integer;

      function fCarregaDadosCompraEmbalagem(const strCodIte: String;
        var strCodUni, strSigUni: String; var fltEmbala: Double): Boolean;

      function fGetFornecedoresPedidos: Boolean;

      function fGeraPedidosCompra(strNumCot, strEmpCot, strEmpDes: String): Boolean;

      function fIniciaPedidoCompra(    strCodFor,
                                       strCompra,
                                       strNumCot,
                                       strEmpCot,
                                       strNomEmpLoj,
                                       strEndEmpLoj,
                                       strCidEmpLoj,
                                       strMulLoj,
                                       strEmpDes: String;
                                   Var strNumPed,
                                       strConPag: String;
                                   Var dtaDtaPed,
                                       horHorPed,
                                       dtaDtaEnt: TDateTime;
                                       blnDesmem: Boolean): Boolean;

      function fGravaItemPedido(strCodFor,
                                strNumPed,
                                strEmpDes,
                                strConPag: String;
                                dtaDtaPed,
                                horHorPed,
                                dtaDtaEnt: TDateTime;
                                strCodIte,
                                strCodUni,
                                strDesIte,
                                strRefere,
                                strSigUni: String;
                                fltQtdIte,
                                fltValUni,
                                fltIpiEnt,
                                fltFreEnt,
                                fltSubsti,
                                fltPerFCP: Double;
                                blnMulLoj: Boolean): Boolean;

      function fGravaPedidoCompra(strNumCot,
                                  strEmpCot,
                                  strCodFor,
                                  strNomEmpLoj,
                                  strEndEmpLoj,
                                  strCidEmpLoj,
                                  strMulLoj,
                                  strEmpDes: String;
                                  blnDesmem: Boolean;
                                  StatusPitStopCotacao: TStatusPitStopCotacao): Boolean;

      function fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor: String): Boolean;
      Function fSQLNovoItem: String;
      Function fSQLCotacoes(stcStatus: TStatusCotacao; AIncGer: string = ''): String;
      Function fAbreItens(blnCarregandoCotacao: Boolean = False): Boolean;
      Function fAbreFornecedores(cdsFornec: TZClient; blnAtualizaArrFor: Boolean = True): Boolean;
      procedure pAjutaTelaApi(DataSet: TDataSet; idApi: integer);
      procedure pIncluiListaFornecApi(ACodFor: string);
      procedure pRemoveListaFornecApi(ACodFor: string);

      Function fGravaPcdDetCot: Boolean;
      Function fGravaPcdDetCotItem(pgbProgresso: TcxProgressBar): Boolean;
      Function fSQLPCDCOTInsert: String;
      Function fSQLPCDCOTUpdate(ACODITE: String;
                                ACODEMP: String;
                                AQTDITE: Double;
                                AstrSeqGer: String): String;
      Function fSQLPCDCOTDelete(ACODITE: String;
                                ACODEMP: String;
                                AstrSeqGer: String): String;
      Function fSQLInnerItem(blnNovoItem: Boolean): String;
      Function fSQLDadosCadastraisItem(AblnCarregandoCotacao: boolean = False): String;
      Function fSQLPrecosCadastraisItem: String;
      Function fSQLLoadPrecos: String;
      function fSqlItens(blnCarregandoCotacao: Boolean =False): String;
      function fSqlFornecedores: String;
      Function fCarregaCotacao: Boolean;
      Function fCarregaCotacaoPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fRecalculaPrecosInicialPrg(prgProgresso: TCxProgressBar): Boolean;
      function fCalculaPrecoCusto: Double;

      function fSalvaCotacaoPrg(pgbStatus: TcxProgressBar = Nil): Boolean;
      function fSalvaUmaCotacaoPrg(pgbStatus: TcxProgressBar = Nil): Boolean;
      function fSalvaCotger: Boolean;
      function fSalvaFornecedores(DataSet: TDataSet): Boolean;

      function fSalvaCotacao: Boolean;
      function fApagaCotacao(strAutInc: String): Boolean;
      function fDeletaCotacao(strAutInc: String): Boolean;
      Function fGravaFornecedores: Boolean;

      Function fGravaFornecedoresDesmemb: Boolean;

      Function fZeraPrecosExcluidoPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fSqlUpdateItem(AstrAutIncCotIte,
                              ADesite,
                              APJAATU: string;
                              AfltQtdIte: Double;
                              AFORESC: string;
                              AFORMEN: string;
                              AGerPed: String): String;
      Function fSqlInsertItem: String;
      Function fSqlInsertItemDireto: String;
      Function fSqlUpdateItemFornecedor(AstrSeqGer,
                                        AFornec,
                                        ACODITE: String;
                                        AVALUNI,
                                        AUNITOT,
                                        AIPIENT,
                                        AFREENT,
                                        ASUBSTI,
                                        AAlqCbs,
                                        AAlqIbs,
                                        AAlq_Is: Double): String;
      Function fSqlInsertItemFornecedor: String;
      function fExcluiItens: Boolean;
      function fExcluiItensProgresso(pgbProgresso: TcxProgressBar): Boolean;
      Function fGravaItens: Boolean;
      function fRetGerPed(strCodIte: String): String;
      function fGravaItensProgresso(pgbProgresso: TcxProgressBar): Boolean;
      function fGetRequisicoes(strCodIte: String; blnCodigo: Boolean = False; blnGetEmp: Boolean = False): TStringArray;
      function fGetRequisicoesFormatado(strCodIte: String): String;
      Function fFornecedorAtivo(intIndFor: Integer): Boolean;
      Function fFornecedorValido(intIndFor: Integer): Boolean;
      function fMostraPedidosPendentesPrg(pgbProgresso: TcxProgressBar): Boolean;
      Function fSelecionaMenoresPrecosPrg(pgbProgresso: TcxProgressBar): Boolean;
      Function fAlterouItem(dataSet: TDataSet): Boolean;
      Function fDesmarcaPrecosAtualizadosPrg(pgbProgresso: TcxProgressBar): Boolean;
      Function fSintetizaItens(pgbStatus: TcxProgressBar = nil): Boolean;
      Function fAtualizaDadosSintetizados(pgbStatus: TcxProgressBar = nil): Boolean;
      function fInsereItensGiro(pgbStatus: TcxProgressBar = Nil): Boolean;
      Function fCarregaPrecosFornecedorProgresso(prgProgresso: TCxProgressBar): Boolean;
//      Function fAtualizaMenorFornecedorPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fGetDadosFornecedor(strCodFor: String; Var strNomFor, strEmail, strContato: String): Boolean;
      Function fMarcaTodosAtualizaPrecoPrg(pgbProgresso: TCxProgressBar): Boolean;
      Function fRecalculaPrecosPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fFiltraItensComPrecoPrg(prgProgresso: TCxProgressBar): Boolean;
      Function fProgramaAtualizaPrecos: Boolean;
      Function fProgramaAtualizaPrecosPrg(pgbProgresso: TcxProgressBar): Boolean;
      Function fRecarregaPrecosProdutos: Boolean;
      Function fRecarregaPrecosProdutosPrg(pgbProgresso: TcxProgressBar): Boolean;
      Function fSQLTabUltimaCompra(blnNovoItem: Boolean): String;
      Function fRetCodCna(dtsDados: TDataSet): String;
      Function fGravarEmaCot(arrDest: TStringArray; strAssunto, strCodFor: String): Boolean;

      Function fRetAplicacao(dtsDados: TDataSet): String;

      function fIncluiCotacao(strAutInc,
                              strNumCot,
                              strDescri,
                              strCompra,
                              strMulLoj,
                              strMesAtu: String;
                              intMesGir,
                              intMesMos: Integer;
                              blnBaixar: Boolean;
                              strCodDig: String;
                              strCodTct: String;
                              strNovIpi: String;
                              ACodGir: String;
                              blnTabRestaura: Boolean = False;
                              blnUpdTabRestaura: Boolean = False;
                              strCodSolicitacao: string = ''): Boolean;

      function fIncluiItensFornec_CopiaSeguranca(blnIncluido: Boolean = false; AcodFor: String = ''): Boolean;
      function fGetCodForByPosArrCodFor(Posicao: integer): String;
      Function fSelecionaRecuperaCotacao(blnAlterando: Boolean): Boolean;

      procedure pIncluiPcmIrq(strAutIncPcd, strCodIte: String);
      Procedure pAtualizaDiaSugItem;
      Procedure pAtualizaItemSintetizado;
      Procedure pEnableControlsItens;
      Procedure pFreeAndNilGravando(Var frmGravando: TfrmGravando);
      procedure pAfterPostItens(DataSet: TDataSet);
      Procedure pBeforePostItens(dataSet: TDataSet);

      procedure pAtualizaCDSItensMultiLojaFornecedorEscolhido(strCodFor, strCodIte: String;
                   fltValEsc, fltIpiEsc, fltSubEsc, fltFreEsc: Double);
      function  fAtualizaCDSItensMultiLojaFornecedorEscolhidoGeralPrg(pgbProgresso: TcxProgressBar): Boolean;
      procedure pAtualizaCDSItensMultiLojaFornecedorEscolhidoGeral;

      Procedure pBeforePostItensAtualizaoPreco(dataSet: TDataSet);
      Procedure pRecalculaPreco(blnPreVen, blnMantemPrecoVendaOuMargemDigitada: Boolean);
      Procedure pRecalculaPrecoTabela(intIndice: Integer; blnPreVen, blnMantemPrecoVendaOuMargemDigitada: Boolean);
      Procedure pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);
      procedure pLimpaRequisicao(strAutInc: String);
      procedure pMensagemGravacao(strMensagem: String);
      procedure pFormShow;
      procedure pCarregaItensMultiLoja;
      procedure pAtuRequisicao(strCot_SeqCot, strCot_SeqReq: String);
      Procedure pAtualizaJaAtu;
      Procedure pAdicionaExcluidos(strCodIte: String);
      procedure pInicializaVariaveisEdicao;
      procedure pFinalizaVariaveis;
      procedure pAtualizaDadosSintetizados;
      procedure pCarregaGirosSimples;

      Procedure pIncluiItemGiroSintetizado(blnDisableControls: Boolean; strCodIte: String);
      Procedure pLoadFuncoesPedido;
      procedure pHabilitaColunasDiaEst(blnHabilita: Boolean);
      procedure pCentralizaCamposMultLoja;
      procedure pMascaraGiro;
      Procedure pAncoraPainelGiro(blnTestarMultLoja: Boolean = False);
      procedure pPosicionaPanelGiroItens;
      procedure pInicializaGiro;
      procedure pSintetizaItens;
      Procedure pCarregaMultLojas;
      procedure pConsultaAfterScrollItensRequisicoes;
      Procedure pSalvaDadosGiro;
      procedure pUpdateCotGerRes_CodGir(strSeqCot, strCodGir: String);

      Procedure pOrdenaGrid;
      Procedure pSetaComboFornecedor(strCodFor: String);
      Procedure pExcluiTodosItensDataSet;
      Function fExcluiTodosItensDataSetZeradoPrg(pgbProgresso: TcxProgressBar): Boolean;

      procedure pExcluiTodosItensRequisicaoDataSet;
      procedure pMarcaRequisicao;
      Procedure pVeSeExcluiTodosItensCotacao;
      procedure pSetaPosicaoArrFor;
      procedure pAtualizaArrFornecedores;
      procedure pExportarExcelNovo(cdsDados: TDataSet;var strNomArq: String; intIndFor: Integer; blnAplicacao, blnMsgLivre, blnTodosItens, blnMarca: Boolean;
                                   blnSemelhantes, blnCNA, blnReferencia: Boolean);

//      procedure pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
//      procedure pFimGeracaoExcel(Excel: TExcel; Campos: TCampos);
//      procedure pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
      procedure OnEscreveValorCampo(DataSet: TDataSet; AIdentificador: string; var ATexto: string; var AColorBackGround, AColorFont: TColor);
      Procedure pZeraPrecosExcluido(intPosicao: Integer);
      procedure pExcelImprimeFiltrosComparativo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);
      procedure pSomaTotaisComparativo(var Totais: TTotais; Dados: TDataSet);
      procedure pSomaTotaisComparativoNovo(DataSet: TDataSet; var ATotais: TTotaisHTML);
      procedure pMontaResumoComparativo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
      procedure pMontaResumoComparativoNovo(DataSet: TDataSet; ATotais: TTotaisHTML);
      procedure pMontaResumoCotacao(DataSet: TDataSet; ATotais: TTotaisHTML);
      procedure pSomaTotaisCotacao(DataSet: TDataSet; var ATotais: TTotaisHTML);
      procedure pSetUnidadeToClient(cdsDados: TDataSet; strIndFor: String; tpUnidade: TTipoUnidade);

      procedure pImprimeDetalhesComparativo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
      Procedure pDesmarcaCotacao;
      Procedure pCriaQueryGenIte;
      Procedure pGridsFirst;
      function fCalculaPrecoImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double): Double;
      function fCalculaFreteImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double): Double;
      function fCalculaReformaImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double;
                                  const AAliquotasReforma: TAliquotasReforma): TValoresReforma;

      procedure pAfterScrollItensGiro(DataSet: TDataSet);
      procedure pAjustaDecimais;

      Function fDesmembraCotacao(pgbStatus: TcxProgressBar = Nil): Boolean;
      procedure OnEscreveValorCampoComparativo(DataSet: TDataSet; AIdentificador: string; var ATexto: string; var AColorBackGround, AColorFont: TColor);

      procedure pCriarNovaCotacaoComItensComItensSemCotacao(seqGerCotacaoOriginal: String);
      Function fMarcaTodosGerPed(prgProgresso: TcxProgressBar): Boolean;
      Function fMarcaTodosMarPed(prgProgresso: TcxProgressBar): Boolean;

      procedure pIncluiNaListaConsulta(strCodIte: String);

      function fCarregaObservacaoFornecedor(strCodFor: String): String;
      function fProcessarCdsImportacaoAux(pgbProgresso: TCxProgressBar): Boolean;

      Procedure pIncluiGiroMultilojaSimilares;

    private
      geraExcel: TGeraArquivo;
    procedure pEditarSimilar(strCodIte, strCodSim: String;
      curQuantidade: Currency; Exclui: String);
    procedure pMarcarSimilar;
    function fGetSQLDadosItensImportacao: String;
    function fGetSQLWhereListaItensImportacaoCotacao(ACdsItens: TUniClientDataSet): String;
    procedure pProcessarCdsImportacao;

    Public
      tpcTipoCalculoExterno: TTipoCalculoExterno;
      blnDeveExcluirCOTFOR: Boolean;

      dtsCadIteEdicao: TDataSet;

      blnZonaFranca,
      blnDesmembraCotacao: Boolean;

      recObserv: TRecObserv;
      recDadGiro: TRecOpcoesGiro;
      blnEncerra,
      blnMulLoj,
      blnMarDesAtual,
      blnRecuperaCotacao,
      blnCancelouRecupera: Boolean;
      blnSalvouCotacao,
      blnApagaOnClose: Boolean;
      strSEQGER_TabelaOficial: String;
      strSeqGer: String;
      strSeqGerBKP: String;
      strLisPed: String;
      strCodCmp: String;
      strCodDig: String;
      strCodTct: String;
      opeOperac: TTipoOperacao;
      tpgGerarPedidos: TTipoGeracao;
      blnEdiCot,
      blnAtuPre,
      blnEditando,
      blnValidaQuantidade,
      blnAlterouFrete,
      blnConverterEmbalagens: Boolean;
      intDecTpc,
      intDecUni: Integer;
      strMarMkp,
      strPcmPro: String;
      EmProcessamento: Boolean;


      cdsItens       : TZClient;
      cdsFornecedores: TZClient;

      cdsFornecedoresDesmem: TZClient;

      cdsItensGiro,
      cdsItensMultiLojas: TUniClientDataSet;
      dtsItensMultiLojas: TDataSource;
      cdsDigMultLoja: TCdsDigMultLoja;

      cdsCotacoes: TzClient;

      stlItens: TStringList;

      strCodSolicitacao: String;

      blnExecutarBeforePostItem : Boolean;

      arrCodFor: Array[1..INT_MAX_FORNECEDOR] Of String;
      function  fAjustaTabelaRes(ASeqRes: String; ASeqCot: String): Boolean;
      constructor Create(Owner: TComponent); Reintroduce; Overload;

      Destructor Destroy; override;

      procedure DesabilitaEdicaoQtdMltLoja;

      function fRetCodComprador(strValorDoEdit: String): String;
      function fRetCodDigitador(strValorDoEdit: String): String;

      function fAdicionaFornecedoresGruposPrg(prgProgresso: TCxProgressBar): Boolean;
      function fAdicionaFornecedoresGruposCotacao: Boolean;
      Function fCarregaItem(strCodIte: String; blnValidar: Boolean = True; blnProcurar: Boolean = True): Boolean;
      Function fAbreCotacao(stcStatus: TStatusCotacao; AIncGer: String = ''): Boolean;
      Function fAlteraCotacao(opeOperacao: TTipoOperacao): Boolean;
      Function fAlteraValorUnitario(strNomCam: String): Boolean;
      Function fRecalculaPrecosInical: Boolean;
      Function fPedeItensGiro: Boolean;
      Function fDigQuantidadeMultilojaCotacao: Boolean;
      Function fIncluiItem(strCodIte, strDesIte: String; fltQtdIte, fltDiaEst, fltDiaSug, fltMedVen: Double; blnSomarQuantidade: Boolean; blnSimilar: Boolean = false; fltSaldoEmpresasGiro: Double = 0; fltQtdReq: Double = 0): Boolean;
      procedure pIncluirItemSimilar(strCodIte, strCodSim: String; fltQtdIte, fltDiaEst, fltDiaSug, fltMedVen: Double; blnSomarQuantidade: Boolean);
      Function fImportaRequisicao(strCodComprador: string): Boolean;
      Function fItemOk: Boolean;
      Function fFornecedorOk: Boolean;
      Function fCarregaPrecosFornecedor: Boolean;
      Function fAtualizaMenorFornecedor: Boolean;
      Function fPedeTransportadora: Boolean;
      function fCalculaFreteInformado: Double;
      Function fMostraPedidosPendentes(blnSelecionados: Boolean): Boolean;
      Function fSelecionaMenoresPrecos: Boolean;
      Function fIndice(intContador: Integer): String;
      Function fRecalculaPrecos(blnRecalcularPreco: Boolean): Boolean;
      Function fAtualizaPrecos: Boolean;
      function fTemPrecoSelecionado(blnSelecionados: Boolean): Boolean;

      procedure pUtilizaFornecedor(strCodFor: String; blnUtiliza: Boolean);
      Procedure pMarcaEscolhido(strNomCam: String);
      Procedure pRecalculaPrecosInical;
      procedure pExcluiItem(blnSemConfirmacao: Boolean = False; blnDeletandoZero: Boolean = False);
      procedure pSetaMultiLojas(blnEdicao: Boolean);
      Function  fIncluiFornecedor(strCodFor, strNomFor: String; strCndPag: String = ''; dtaDtaEnt: TDate = 0): Boolean;
      procedure pExcluiFornecedor;
      function fTemPedidoCompraGerado(var strPedidoCompra: String): Boolean;
      procedure pLimpaPcmGerRes(ANumCot, ACodEmp: String);
      procedure pMarcaDesmarcaFornecedor;
      procedure pExportarArquivos;
      procedure pImportaArquivos;
      Procedure pExportarExcelComparativo;
      procedure pExportarExcelComparativoNovo ;
      Procedure pMarcaDesmarcaAtualizaPreco;
      Procedure pMarcaTodosAtualizaPreco(blnMarcar: Boolean);
      Procedure pFiltraItensComPreco(blnFiltrar, blnFiltrarGerados: Boolean);
      Procedure pDesmarcaPrecosAtualizados;
      procedure pSetaItensGrid(blnSetar: Boolean);

      Procedure pSetaEventosItem(blnSetar: Boolean;
                                 blnAfterSroll: Boolean = True;
                                 blnAfterPost: Boolean  = True;
                                 blnBeforePost: Boolean = True);

      procedure pSetaAfterScrollItensGiro;
      procedure pTiraAfterScrollItens;
      procedure pHeranca;
      procedure pSalvaCopiaSegurancaPermanente;

      Function fRetSumValTot(intIndFor: Integer): Double;
      Function fRetSumValUni(intIndFor: Integer): Double;
      Function fRetSumSubsti(intIndFor: Integer): Double;
      Function fRetSumIpiEnt(intIndFor: Integer): Double;
      Function fRetSumFreEnt(intIndFor: Integer): Double;
      function fAliquotaImportada(const AfltAtual, AfltLida: Double): Double;
      Function fRetSumCampo(const AstrCampo: String; intIndFor: Integer): Double;
      function fValidaItensSemFornecedor: boolean;



      Procedure pCarregaConfiguracoes(frmCadCotacaoGeralCX: TForm);
      Procedure pAjustaConfigs;
      procedure pReplicaDados(AstrField: String; AblnSubstTodos: Boolean);
      Procedure pSalvaConfiguracoes(frmCadCotacaoGeralCX: TForm);
      Class function fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
      Class function fGetPathTempOpcoesLocais: String;
      Class function fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
      Class function fArquivoParaString(strNomArq: String): String;


      Procedure pMarDesGerPed;
      Procedure pMarDesMarPed;
      Procedure pMarDesMarPedTodos;
      Procedure pMarcaTodosGerPed(blnMarcar: Boolean);
      Procedure pMarDesExcluirItens;

      Function fCarregaItensRelacionados(strCodFor: String; cdsItensFornec: TUniClientDataSet): Boolean;
      procedure pExcluiTodosItensDataSetZerado;
      procedure pTemQuantidadeZerada;
      procedure pAtualizaCdsCotacao(AQtdite: Double; ACodIte: String);
      procedure pImportarItens;
      Function fMarcaCotacao( strSeqGer: String): Boolean;
      function fIncluir_CopiaSeguranca: Boolean;
      function fIncluir_CopiaSeguranca_AtualizaCapa: Boolean;
      function fIncluiCotacaoItens_CopiaSeguranca(blnApenasItemsFocado: Boolean = False): Boolean;
      function fExcluiItensCotacao_CopiaSeguranca(strCodIte: String; blnTodos: Boolean = False): Boolean;
      function fIncluiFornecedores_CopiaSeguranca(blnRegJaExistente: Boolean; strCodFor, strUtiLiz: String; strCndPag: String = ''; dtaDtaEnt: TDate = 0): Boolean;
      function fIncluiItensMultilojas_CopiaSeguranca(blnApenasItemsFocado: Boolean = False): Boolean;
      procedure pApaga_CopiaSeguranca(strAutInc: String);
      procedure pExcluiFornecedor_CopiaSeguranca(strCodFor: String);
      procedure pAtualizaFornecedor_CopiaSeguranca(strCodFor: String; blnUtiliza: Boolean);
      procedure pLiberaCotacoes;

      procedure pProcessaApiCotacao(AIdApi: integer);
      procedure pReiniciarCotacaoPitStop();

      procedure pCarregaPrecosCotacaoPitStop;
      procedure pIniciaSegundaEtapaCotacao;
      procedure pAtualizaStatusFornecedoresPitStop(ACotSeqger, AFornecedores: String);
      procedure pAtualizaStatusCotCFOPitStopAncaora(ASeqger, ACotFor: String; AIdentApi, AStatus: Integer; AHorIni: TDateTime);
      procedure pReiniciaIntegracao(AIdIntegracao: Integer);

      procedure pAtualizaConPitNotificacao(ACotSeqger, AFornecedores: String);
      function fFaturaPitStop(ACodFor, AIncPcmGer, ANumCot: String;AStatusPitStopCotacao: TStatusPitStopCotacao): Boolean;
      procedure pAjustaHandleConPit(AHAndle:HWND);
      procedure pAjustaStatusCotacaoPitStop;
      procedure MarcaTodosComoAlterado;

    End;

implementation

Uses
  cxCurrencyEdit, untRecuperaCotacaoSelec,
  untCadCotacaoGeralCX, untAlteraValorUnitario,
  untCadCotItensImpRequisicao, untSaldoPedidoCompra,
  untInicializaDllPedido, untTelaGiroUma, untGravacaoPedido, untCadForPre,
  untCadCotEmail, untModuloCotExportacao, untCadCotImportacao, untPedOrdenacao,
  untDigObservacoes, untDllOpeProd, untDllOpeProdFuncoes, untCadCotacaoCX, untSalvaDadosGiro,
  untTEnvioEmail, untDigCtaFornecedores, untImpressaoDocs, untLiberacaoFactory,
  untTValidaExcel, untAncoraController, untAncoraShowLog, untMsgLiberacao,
  untTMontaSQLPedidoCompra, untFuncoesRel, untFuncoesRel2,
  untCfgHabilitaConsultaCotacaoAPIBalcao,
  Ancora.Classes.EndPoint,
  PitStop.Classes.EndPoint, Cotacao.ProcessaApi, untManutencaoEquipamentoInterno;

Const
  TIT_CODIGO = 'Código';
  TIT_PRECO  = 'Preço Unit.';
  TIT_IPI    = '% I.P.I.';
  TIT_FRE    = '% Frete';
  TIT_CBS    = '% CBS';
  TIT_IBS    = '% IBS';
  TIT_IS     = '% I.S.';
  TIT_ST     = '%Subs.';
  TIT_TOT    = 'Valor Total';


constructor TCotacao.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, '');
  blnDeveExcluirCOTFOR := False;
  ANCORA_LOGO := TResourceStream.Create(hInstance, 'ANCORA_36', RT_RCDATA);
  PITSTOP_LOGO := TResourceStream.Create(hInstance, 'PIT_36', RT_RCDATA);
  SKYPECAS_LOG := TResourceStream.Create(hInstance, 'SKY_36', RT_RCDATA);

  FFornecApi := TStringList.Create;
  FFornecApi.Sorted := True;
  FFornecApi.Duplicates := dupIgnore;

If TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fApiHabilitada(idRedeAncora) Then
  begin
    RedeAncora := TRedeAncora.Create;
    If Not RedeAncora.fGetProfile Then
    begin
      pMensagemOk('Falha Ancora: ' + RedeAncora.retParamProfile.RetornoApi.Falha);
      FreeAndNil(RedeSkyPecas);
    End;
  end;

  If TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fApiHabilitada(idRedeSkyPecas) Then
  begin
    RedeSkyPecas := TRedeSkyPecas.Create;
    If not RedeSkyPecas.fLogin Then
    Begin
      pMensagemOk('Falha Sky Peças: ' + RedeSkyPecas.ParamSkyPecas.RetornoApi.Falha);
      FreeAndNil(RedeSkyPecas);
    End;
  end;

  If TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fApiHabilitada(idRedePitStop) Then
    RedePitStop := TRedePitStop.Create(fCfgSis('PSTCID'));

  FblnCOTSIM := fCfgSis('COTSIM', varBoolean);
  blnEncerra := False;
  blnTabPrf := fCfgSis('TABPRF', varBoolean);
  blnUtilizouGiro := False;
  blnAtualizaMltLojaDepois := False;
  blnDesmembraCotacao := False;
  blnMarDesAtual := True;
  blnRecuperaCotacao := False;
  blnExecutarBeforePostItem := True;

  intDecUni := fCfgSis('DECUNI', varInteger);
  cfgfrmCus := fCfgSis('FRMCUS', varInteger);
  case cfgfrmCus of
    1: Begin
         sqlPrecomImp := '(ROUND(' + STR_PREIMP_FRMCUS_1 + ', ' + intDecUni.ToString + '))' ;
         sqlFreEntImp := '(ROUND(' + STR_FRETE_FRMCUS_1 + ', ' + intDecUni.ToString + '))' ;
       End;
    2,4: Begin
           sqlPrecomImp := '(ROUND(' + STR_PREIMP_FRMCUS_2 + ', ' + intDecUni.ToString + '))' ;
           sqlFreEntImp := '(ROUND(' + STR_FRETE_FRMCUS_2 + ', ' + intDecUni.ToString + '))' ;
         End;
    3: Begin
         sqlPrecomImp := '(ROUND(' + STR_PREIMP_FRMCUS_3 + ', ' + intDecUni.ToString + '))' ;
         sqlFreEntImp := '(ROUND(' + STR_FRETE_FRMCUS_3 + ', ' + intDecUni.ToString + '))' ;
       End;
  End;
  sqlPrecomImp_COT :=  sqlPrecomImp;
  sqlFreEntImp_COT :=  sqlFreEntImp;

  sqlPrecomImp := AnsiReplaceStr(sqlPrecomImp, '@FREENT', 'IFNULL(G.ITE_FREENT, 0)');
  sqlPrecomImp := AnsiReplaceStr(sqlPrecomImp, '@SUBSTI', 'IFNULL(G.ITE_SUBSTI, 0)');
  sqlPrecomImp := AnsiReplaceStr(sqlPrecomImp, '@IPIENT', 'IFNULL(G.ITE_IPIENT, 0)');

  sqlFreEntImp := AnsiReplaceStr(sqlFreEntImp, '@FREENT', 'IFNULL(G.ITE_FREENT, 0)');
  sqlFreEntImp := AnsiReplaceStr(sqlFreEntImp, '@SUBSTI', 'IFNULL(G.ITE_SUBSTI, 0)');
  sqlFreEntImp := AnsiReplaceStr(sqlFreEntImp, '@IPIENT', 'IFNULL(G.ITE_IPIENT, 0)');



  sqlPrecomImp_COT := AnsiReplaceStr(sqlPrecomImp_COT, '@COMLIQ', 'IFNULL(COT_VALUNI, 0)');
  sqlPrecomImp_COT := AnsiReplaceStr(sqlPrecomImp_COT, '@FREENT', 'IFNULL(COT_FREENT, 0)');
  sqlPrecomImp_COT := AnsiReplaceStr(sqlPrecomImp_COT, '@SUBSTI', 'IFNULL(COT_SUBSTI, 0)');
  sqlPrecomImp_COT := AnsiReplaceStr(sqlPrecomImp_COT, '@IPIENT', 'IFNULL(COT_IPIENT, 0)');
  sqlPrecomImp_COT_COM := sqlPrecomImp_COT;
  sqlPrecomImp_COT := '(SELECT ' +  sqlPrecomImp_COT  + ' FROM COTFOR F' +
                      '  WHERE F.COT_SEQGER = C.COT_SEQGER ' +
                      '    AND F.COT_CODFOR = C.COT_FORESC ' +
                      '    AND C.COT_CODITE = F.COT_CODITE)';


  sqlFreEntImp_COT := AnsiReplaceStr(sqlFreEntImp_COT, '@COMLIQ', 'IFNULL(COT_VALUNI, 0)');
  sqlFreEntImp_COT := AnsiReplaceStr(sqlFreEntImp_COT, '@FREENT', 'IFNULL(COT_FREENT, 0)');
  sqlFreEntImp_COT := AnsiReplaceStr(sqlFreEntImp_COT, '@SUBSTI', 'IFNULL(COT_SUBSTI, 0)');
  sqlFreEntImp_COT := AnsiReplaceStr(sqlFreEntImp_COT, '@IPIENT', 'IFNULL(COT_IPIENT, 0)');
  sqlFreEntImp_COT_COM := sqlFreEntImp_COT;
  sqlFreEntImp_COT := '(SELECT ' +  sqlFreEntImp_COT  + ' FROM COTFOR F' +
                      '  WHERE F.COT_SEQGER = C.COT_SEQGER ' +
                      '    AND F.COT_CODFOR = C.COT_FORESC ' +
                      '    AND C.COT_CODITE = F.COT_CODITE)';



  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  objRequisicao       := TRequisicaoPedidoCompra.Create;

  objDuplicatasPedido := TDuplicatasPedidoCompra.Create;

  fltALPISP := fCfgSis('ALPISP', varDouble);
  fltALCOFP := fCfgSis('ALCOFP', varDouble);

  strForFil := fRetForFilialTodos;
  blnLibPcm := fCfgSis('LIBPCM', varBoolean);
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
  intCPRANC := fCfgSis('CPRANC', varInteger); {1 = todos 2 = com saldo}

  fltValFreGer := 0;
  fltDesAceGer := 0;
  fltValFreRes := 0;
  fltDesAceRes := 0;

  qryRepRFo := fCriaQuery(Self);
  qryRepRFo.SQL.Text := 'SELECT REL_CODITE FROM REPRFO WHERE REL_CODFOR = :CODFOR';

  stlItens        := TStringList.Create;
  stlItens.Sorted := True;
  stlItens.Duplicates := dupIgnore;

  tpcTipoCalculoExterno := tpcNenhum;

  FRecalcularPreco := False;
  FMantemPrecoVendaOuMargemDigitada := True;

  FExcluidos := TStringList.Create;
  FExcluidos.Sorted := True;
  FExcluidos.Duplicates := dupIgnore;

  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao);

  blnAtuPre := fCfgSis('ATPVMB', varString) = 'P';
  blnEdiCot := fCfgSis('EDICOT', varBoolean);
  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecTpc := fCfgSis('DEQTPC', varInteger);
  strMarMkp := fCfgSis('MARMKP');
  strPcmPro := fCfgSis('PCMPRO');
  blnEXILCC := fCfgSis('EXILCC', varBoolean);

  FqryConsulta := fCriaQuery(Self);
  FqryCodCna := fCriaQuery(Self);
  FqryCodCna.SQL.Text := 'SELECT ITE_CODCNA FROM ITEFOR WHERE ITE_CODITE = :CODITE AND ITE_CODFOR = :CODFOR';

  qryNovoItem          := fCriaQuery(Self);
  qryNovoItem.SQL.Text := fSQLNovoItem;

  cdsItens        := TZClient.Create(Self, '');

  cdsFornecedores := TZClient.Create(Self, '');

  cdsItensGiro    := TUniClientDataSet.Create(Self);

  pLoadFuncoesPedido;

  strDirExp := ExtractFilePath(Application.ExeName) + 'COTACOES\EXPORTAR';
  strDirImp := ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR';

  FListaItensPendentes := TStringList.Create;
  FItensGerados        := TStringList.Create;
  FListaAutIncCotacao  := TStringList.Create;
  FItensGerados.Sorted := True;


  cdsItensMultiLojas  := Nil;
  cdsDigMultLoja      := Nil;

  FillChar(recDadGiro, SizeOf(recDadGiro), #0);

  recDadGiro.blnConsPedVen := True;
  recDadGiro.blnConsGarPen := True;
  recDadGiro.blnConsOrdPro := True;
  recDadGiro.blnRecuperCot := blnRecuperaCotacao;

  recDadGiro.strNomFrm := 'frmDigGiroEstoqueCotacao';

  pInicializaVariaveisEdicao;

  FUpdateJaAtu := fCriaQuery(Self);
  FUpdateJaAtu.SQL.Text := 'UPDATE COTITE SET COT_PJAATU = "S" WHERE AUTOINCREM = :AUTINC';

  FLoadPrecos := fCriaQuery(Self);
  FLoadPrecos.SQL.Text := fSQLLoadPrecos;

  cdsCotacoes := TzClient.Create(Self);

  pCriaQueryGenIte;

  fAbreCotacao(stcAbertas);
End;

procedure TCotacao.pInicializaVariaveisEdicao;
Begin
  FfrmGravandoCorrente := Nil;
  FillChar(arrCodFor, Sizeof(arrCodFor), #0);

  FAtualizarDadosSintetizados := False;
  FSintetizarItens := False;

  strSeqGer := '';
  strCodCmp := '';
  strCodDig := '';
  strCodTct := '';
  strCodSolicitacao := '';
  FManterEscolhido := True;
  FEsvaziouItens := False;
  FLimpaRequisicao := False;
  blnMulLoj := False;
  blnEditando := False;
  FRecalculouPrecos := False;
  tpgGerarPedidos := tpgNaoGera;
  blnConverterEmbalagens := False;
  strLisPed := '';

  If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
  Begin
    cdsItensGiro.EmptyDataSet;
    cdsItensGiro.Close;
  End;

  objRequisicao.cdsRequisicao.Close;

  If Assigned(cdsItensMultiLojas) Then
    FreeAndNil(cdsItensMultiLojas);

  blnValidaQuantidade := True;

  FillChar(recDadGiro, SizeOf(recDadGiro), #0);
  recDadGiro.intMesGir := 3;

  If fCfgSis('MESGIR', VarInteger) = 1 Then
    recDadGiro.intMesMos := 12
  Else
    recDadGiro.intMesMos := recDadGiro.intMesGir;

  recDadGiro.strMeses  := fMontaStrMeses(recDadGiro.intMesMos);
  recDadGiro.strNomFrm := 'frmDigGiroEstoqueCotacao';

  FExcluidos.Clear;
End;

procedure TCotacao.pInsereCadIntExtra(strCodGirOriginal, strSeqGerNovo,
  strNomFrm: String);
Var
  qryInsert: TUniQuery;
  qryGiro: TUniQuery;
Begin
  If  fEmptyStr(strCodGirOriginal) Then
    Exit;
  qryInsert := fCriaQuery;
  qryGiro := fCriaQuery;

  Try

  qryGiro.SQL.Clear;
  qryGiro.SQL.Add('SELECT INT_NOMFRM, INT_VALKEY, INT_NOMCOM, INT_VALCOM, AUTOINCREM, INT_CODOPE');
  qryGiro.SQL.Add('  FROM CADINT');
  qryGiro.SQL.Add(' WHERE INT_VALKEY = "' + strCodGirOriginal + '"');
  qryGiro.SQL.Add('   AND INT_NOMFRM = "frmDigGiroEstoqueCotacao"');
  qryGiro.Open;

  While not qryGiro.Eof do
  Begin
    qryInsert.SQL.Add('INSERT INTO CADINT (INT_NOMFRM, INT_VALKEY, INT_NOMCOM, INT_VALCOM, AUTOINCREM, INT_CODOPE) VALUES (');
    qryInsert.SQL.Add('"' + strNomFrm + '",');
    qryInsert.SQL.Add('"'+strSeqGerNovo+'",');
    qryInsert.SQL.Add('"' + qryGiro.FieldByName('INT_NOMCOM').AsString + '",');
    qryInsert.SQL.Add('"' + qryGiro.FieldByName('INT_VALCOM').AsString + '",');
    qryInsert.SQL.Add('"'+fRetAutoIncrem('CADINT', VS_StrCodEmp)+'",');
    qryInsert.SQL.Add('"' + qryGiro.FieldByName('INT_CODOPE').AsString + '");');
    qryGiro.Next;
  end;
  If qryInsert.sql.text <> '' Then
    qryInsert.ExecSQL;

  Finally
    FreeAndnil(qryInsert);
    FreeAndnil(qryGiro);
  End;


end;

procedure TCotacao.DesabilitaEdicaoQtdMltLoja;
begin
  If blnMulLoj Then
    cdsDigMultLoja.frmEntDigMultiLojasNovo.cxgItensQTDITE.Options.Editing := False;
end;

Destructor TCotacao.Destroy;
Begin
  FreeAndNil(objRequisicao);
  FreeAndNil(FqryConsulta);
  FreeAndNil(cpcParams);

  FExcluidos.Clear;
  FreeAndNil(FExcluidos);

  FListaItensPendentes.Clear;
  FreeAndNil(FListaItensPendentes);

  FreeAndNil(FFornecApi);
  FreeAndNil(ANCORA_LOGO);
  FreeAndNil(PITSTOP_LOGO);
  FreeAndNil(SKYPECAS_LOG);


  If Assigned(FListaAutIncCotacao) Then
    FreeAndNil(FListaAutIncCotacao);

  FreeAndNil(objDuplicatasPedido);

  FreeAndNil(stlItens);

  FItensGerados.Clear;
  FreeAndNil(FItensGerados);

  if Assigned(RedeAncora) Then
    FreeAndNil(RedeAncora);

  if Assigned(RedeSkyPecas) Then
    FreeAndNil(RedeSkyPecas);

  if Assigned(RedePitStop) Then
    FreeAndNil(RedePitStop);

  Inherited;
End;

Function TCotacao.fIndice(intContador: Integer): String;
Begin
  Result := RightStr('0' + IntToStr(intContador), 2);
End;

Function TCotacao.fSQLCotacoes(stcStatus: TStatusCotacao; AIncGer: string = ''): String;
Begin

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   G.*, ';
  Result := Result + ' CONCAT(G.COT_CODCMP ,"-",(SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = COT_CODCMP)) AS DESCOP,  ';
  Result := Result + ' TMP_VLRTOT.COT_VLRTOT, ';
  Result := Result + '     (SELECT SUM(IFNULL(I.COT_QTDITE, 0) * IG.ITE_PRECUS) ';
  Result := Result + '      FROM COTITE I  ';
  Result := Result + '      INNER JOIN ITEGER IG ON IG.ITE_CODITE = I.COT_CODITE AND IG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '      WHERE I.COT_SEQGER = G.AUTOINCREM ';
  Result := Result + '  ) AS COT_CUSTOT,  ';
  Result := Result + ' (SELECT TCT_DESTCT FROM CADTCT WHERE TCT_CODTCT = COT_CODTCT) AS DESTCT, ';
  Result := Result + ' (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = COT_CODDIG) AS NOMDIG, ';
  Result := Result + ' (SELECT OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = COT_CODCMP) AS NOMOPE,  ';
  Result := Result + '  CASE WHEN COT_LIBBID = "L" THEN "Liberado" ';
  Result := Result + '       WHEN COT_LIBBID = "I" THEN "Integrado" ';
  Result := Result + '       ELSE "Não liberado" ';
  Result := Result + '  END AS STATUS_ITEGRA ';

  Result := Result + '   FROM ';
  Result := Result + '   COTGER G ';

  Result := Result + '  LEFT JOIN (SELECT SUM(( IFNULL(I.COT_QTDITE, 0)  ) *';
  Result := Result + '                        (IFNULL(F.COT_VALUNI, 0) * ( 1 + IFNULL(F.COT_SUBSTI, 0) / 100 + IFNULL(F.COT_IPIENT, 0) / 100 +';
  Result := Result + '                         IFNULL(F.COT_FREENT, 0) / 100 ) )';

  If fSomarNovosImpostosDaReformaAoValorContabil Then
    Result := Result + ' + ( IFNULL(I.COT_QTDITE, 0) ) * ' +
              TCalculoReformaCompra.fSQLValores('IFNULL(F.COT_VALUNI, 0) * (1 + IFNULL(F.COT_FREENT, 0) / 100)',
                                                'IFNULL(F.COT_ALQCBS, 0)', 'IFNULL(F.COT_ALQIBS, 0)', 'IFNULL(F.COT_ALQ_IS, 0)').fTotal;

  Result := Result + ')AS COT_VLRTOT ,';
  Result := Result + '                    I.COT_SEQGER';
  Result := Result + '               FROM COTITE I';
  Result := Result + '              INNER JOIN COTFOR F ON F.COT_SEQGER = I.COT_SEQGER AND F.COT_CODITE = I.COT_CODITE';
  Result := Result + '              WHERE F.COT_CODITE = I.COT_CODITE';
  Result := Result + '                AND F.COT_CODFOR = COT_FORESC';
  Result := Result + '              GROUP BY I.COT_SEQGER) TMP_VLRTOT ON TMP_VLRTOT.COT_SEQGER = G.AUTOINCREM';


  Result := Result + ' WHERE TRUE ';

  Result := Result + '  AND (IFNULL(G.AUTOINCREM, "") <> "") ';

  Result := Result + '  AND (SELECT EMP_EMPATI FROM CADEMP WHERE EMP_CODEMP = COT_CODEMP) = "S" ';

  Case stcStatus Of
    stcAbertas : Result := Result + ' AND COT_DTAFIN IS NULL ';
    stcBaixadas: Result := Result + ' AND COT_DTAFIN IS NOT NULL ';
  End;

  If not fEmptyStr(AIncGer) Then
    Result := Result + ' AND G.AUTOINCREM = "'+AIncGer+'"';

  If blnRecuperaCotacao Then
  Begin
    Result := AnsiReplaceStr(Result, 'COTITE', 'COTITE_RES');
    Result := AnsiReplaceStr(Result, 'COTFOR', 'COTFOR_RES');
    Result := AnsiReplaceStr(Result, 'COTGER', 'COTGER_RES');
  End;

End;

Function TCotacao.fAbreCotacao(stcStatus: TStatusCotacao; AIncGer: String = ''): Boolean;
Begin
  FstcStatus := stcStatus;
  qryQuery.SQL.Text := fSQLCotacoes(stcStatus, AIncGer);

  Result := fAbreClient(True, 'fAbreCotacao');

  pAlinhaCampoCentro('COT_NUMCOT');
  pAlinhaCampoCentro('COT_MULLOJ');
  pAlinhaCampoCentro('COT_DTACAD');
  pAlinhaCampoCentro('COT_DTAFIN');
  pAlinhaCampoCentro('COT_CODEMP');
  pAlinhaCampoCentro('COT_EMPDES');
End;

procedure TCotacao.pFinalizaVariaveis;
Begin
  If Assigned(cdsDigMultLoja) Then
    FreeAndNil(cdsDigMultLoja);
End;

procedure TCotacao.pSetaItensGrid(blnSetar: Boolean);
begin
  If Assigned(frmCadCotacaoGeralCX) Then
  With frmCadCotacaoGeralCX Do
  If blnSetar Then
  Begin
    pTiraAfterScrollItens;

    cxbItens.DataController.DataSource        := objCotacao.cdsItens.dtsSource;
    dbeAplica.DataSource                      := objCotacao.cdsItens.dtsSource;
    dbeAplicaComparativo.DataSource           := objCotacao.cdsItens.dtsSource;
    cxbItensFornec.DataController.DataSource  := objCotacao.cdsItens.dtsSource;
    cxbComparativo.DataController.DataSource  := objCotacao.cdsItens.dtsSource;
    cxbAtuPrecos.DataController.DataSource    := objCotacao.cdsItens.dtsSource;

    pSetaAfterScrollItensGiro;
  End Else
  Begin
    cxbItens.DataController.DataSource        := Nil;
    cxbItensFornec.DataController.DataSource  := Nil;
    cxbComparativo.DataController.DataSource  := Nil;
    cxbAtuPrecos.DataController.DataSource    := Nil;
    dbeAplica.DataSource                      := Nil;
  End;
End;

Class function TCotacao.fCriarArquivoTemporario(strNomArq: String = ''; strPathTmp: String = ''): String;
  Var
    Caminho  : PChar;
    Arquivo  : file;
    strDirVal: String;

  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
    Var
      FilePath: array [0..255] of Char;
  Begin
    SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
    Result := FilePath;
  End;

begin
  Result := '';

  Try
    If fEmptyStr(strPathTmp) Then
    Begin
      strDirVal := GetSpecialFolderPath(CSIDL_APPDATA, False) + '\Autcom\';

      If Not DirectoryExists(strDirVal) Then
        CreateDir(strDirVal);

      Caminho := PChar(strDirVal);
    End
    Else
      Caminho := PChar(strPathTmp);

    If fEmptyStr(strNomArq) Then
    Begin
      Result := Caminho + IntToStr(RandomRange(0, 99999));

      While FileExists(Result) Do
      Begin
        Result := Caminho + IntToStr(RandomRange(0, 99999));
      End;
    End
    Else
    Begin
      Result := Caminho + strNomArq;
    End;

    AssignFile(Arquivo, Result);
    Rewrite(Arquivo);

  Finally
    CloseFile(Arquivo);
  End;
end;

Class function TCotacao.fGetPathTempOpcoesLocais: String;
  Var
    Buffer: Array[0..254] Of Char;
    strPatIni: String;
    iniArqIni : TIniFile;
begin
  Result := '';
  GetWindowsDirectory(Buffer, 255);
  strPatIni := StrPas(Buffer) + '\OPCOES_LOCAIS.INI';

  If FileExists(strPatIni) Then
  Begin
    iniArqIni := TIniFile.Create(strPatIni);
    Try
      Result := iniArqIni.ReadString('ARQUIVOS_TEMPORARIOS', 'PATH' , Result)
    Finally
      iniArqIni.Free;
    End;
  End;
end;

Class function TCotacao.fEscreverNoArquivo(strNomArq, strTexto: String): Boolean;
  Var
    Arquivo: TextFile;
begin
  Result := True;

  Try

    If Not FileExists(strNomArq) Then
    Begin
      Result := False;
    End
    Else
    Begin
      AssignFile(Arquivo, strNomArq);
      Rewrite(Arquivo);
      Write(Arquivo, strTexto);
    End;

  Finally
    CloseFile(Arquivo);
  End;
end;

procedure TCotacao.pCarregaConfiguracoes(frmCadCotacaoGeralCX: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;

begin
  With TfrmCadCotacaoGeralCX(frmCadCotacaoGeralCX) Do
  Begin
    qryCfgPdc := fCriaQuery;

    With qryCfgPdc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "Fornecedor Cotação - Itens" ');
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      Open;

      If Not IsEmpty Then
      Begin
        stlCfgFrm := TStringList.Create;

        strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);

        If fEscreverNoArquivo(strArqTemp, FieldByName('CFG_CFGGRI').AsString) Then
        Begin
          TfrmCadCotacaoGeralCX(frmCadCotacaoGeralCX).cxbItens.RestoreFromIniFile(strArqTemp);
          DeleteFile(PChar(strArqTemp));
        End;

        stlCfgFrm.Text := FieldByName('CFG_CFGFRM').AsString;

        If stlCfgFrm.Count > 0 Then
          recDimFrm.wrdHeight := StrToIntDef(stlCfgFrm[0], 800);

        If stlCfgFrm.Count > 1 Then
          recDimFrm.wrdWidth := StrToIntDef(stlCfgFrm[1], 1280);

        If stlCfgFrm.Count > 2 Then
          recDimFrm.blnMaxim := StrToIntDef(stlCfgFrm[2], 0) = 1;

        FreeAndNil(stlCfgFrm);
      End;

      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "Fornecedor Cotação" ');
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      Open;

      If Not IsEmpty Then
      Begin
        stlCfgFrm := TStringList.Create;

        strArqTemp := fCriarArquivoTemporario('', fGetPathTempOpcoesLocais);

        If fEscreverNoArquivo(strArqTemp, FieldByName('CFG_CFGGRI').AsString) Then
        Begin
          Try
             TfrmCadCotacaoGeralCX(frmCadCotacaoGeralCX).cxbComparativo.RestoreFromIniFile(strArqTemp);
          Except
          End;
          TfrmCadCotacaoGeralCX(frmCadCotacaoGeralCX).pCarregaArrCampos;
          DeleteFile(PChar(strArqTemp));
        End;

        stlCfgFrm.Text := FieldByName('CFG_CFGFRM').AsString;

        If stlCfgFrm.Count > 0 Then
          recDimFrm.wrdHeight := StrToIntDef(stlCfgFrm[0], 800);

        If stlCfgFrm.Count > 1 Then
          recDimFrm.wrdWidth := StrToIntDef(stlCfgFrm[1], 1280);

        If stlCfgFrm.Count > 2 Then
          recDimFrm.blnMaxim := StrToIntDef(stlCfgFrm[2], 0) = 1;

        FreeAndNil(stlCfgFrm);
      End;

    End;

    FreeAndNil(qryCfgPdc);
  End;

   pAjustaConfigs;
end;



Procedure TCotacao.pAjustaConfigs;
Begin
  If Not Assigned(frmCadCotacaoGeralCX) Then
    Exit;

  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT01);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT02);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT03);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT04);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT05);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT06);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT07);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT08);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT09);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT10);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT11);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT12);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT13);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT14);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT15);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT16);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT17);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT18);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT19);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT20);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT21);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT22);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT23);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT24);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT25);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT26);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT27);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT28);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT29);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT30);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT31);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT32);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT33);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT34);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT35);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT36);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT37);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT38);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT39);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT40);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT41);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT42);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT43);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT44);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT45);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT46);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT47);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT48);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT49);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoVALTOT50);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoFORMEN);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoFORESC);
  frmCadCotacaoGeralCX.pAddCampoBloqueado(frmCadCotacaoGeralCX.cxbComparativoTOTESC);
End;

procedure TCotacao.pAjutaTelaApi(DataSet: TDataSet; idApi: integer);
begin
  case idApi of
    idRedeAncora: TBlobField(DataSet.FieldByName('COT_IMGAPI')).LoadFromStream(ANCORA_LOGO);
    idRedePitStop: TBlobField(DataSet.FieldByName('COT_IMGAPI')).LoadFromStream(PITSTOP_LOGO);
    idRedeSkyPecas: TBlobField(DataSet.FieldByName('COT_IMGAPI')).LoadFromStream(SKYPECAS_LOG);
  end;
  frmCadCotacaoGeralCX.cxvFornecedores.OptionsView.DataRowHeight := 40;
  frmCadCotacaoGeralCX.cxvFornecedoresACTAPI.Visible := True;
  frmCadCotacaoGeralCX.cxvFornecedoresCOT_IMGAPI.Visible := True;
  frmCadCotacaoGeralCX.cxvFornecedoresCOT_STAAPI.Visible := True;

  pIncluiListaFornecApi(DataSet.FieldByName('COT_CODFOR').AsString);

end;

procedure TCotacao.pCarregaItensMultiLoja;
Begin
  pSetaMultiLojas(False);
  pInicializaGiro;

  If blnMulLoj Then
    pCarregaMultLojas
  Else
    pCarregaGirosSimples;
End;

procedure TCotacao.pAjustaDecimais;
  Var
    strDisplay: String;
Begin
  With frmCadCotacaoGeralCX Do
  Begin
    strDisplay := '0.' + fStrZero('0', intDecTpc) + ';-0.' + fStrZero('0', intDecTpc);

    TcxCurrencyEditProperties(cxbItensQTDITE.Properties).DecimalPlaces         := intDecTpc;
    TcxCurrencyEditProperties(cxbItensFornecQTDITE.Properties).DecimalPlaces   := intDecTpc;
    TcxCurrencyEditProperties(cxbComparativoQTDITE.Properties).DecimalPlaces   := intDecTpc;

    TcxCurrencyEditProperties(cxbItensQTDITE.Properties).DisplayFormat         := strDisplay;
    TcxCurrencyEditProperties(cxbItensFornecQTDITE.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoQTDITE.Properties).DisplayFormat   := strDisplay;

    strDisplay := '0.' + fStrZero('0', intDecUni) + ';-0.' + fStrZero('0', intDecUni);

    TcxCurrencyEditProperties(cxbItensFornecVALUNI.Properties).DisplayFormat     := strDisplay;

    TcxCurrencyEditProperties(cxbComparativoVALTOT01.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT02.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT03.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT04.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT05.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT06.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT07.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT08.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT09.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT10.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT11.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT12.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT13.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT14.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT15.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT16.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT17.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT18.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT18.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT20.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT21.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT22.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT23.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT24.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT25.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT26.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT27.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT28.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT29.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT30.Properties).DisplayFormat   := strDisplay;

    TcxCurrencyEditProperties(cxbComparativoVALTOT31.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT32.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT33.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT34.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT35.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT36.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT37.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT38.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT39.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT40.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT41.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT42.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT43.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT44.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT45.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT46.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT47.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT48.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT49.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbComparativoVALTOT50.Properties).DisplayFormat   := strDisplay;
    TcxCurrencyEditProperties(cxbItensFornecVALUNI.Properties).DecimalPlaces   := 10;

    TcxCurrencyEditProperties(cxbComparativoVALTOT01.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT02.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT03.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT04.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT05.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT06.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT07.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT08.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT09.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT10.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT11.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT12.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT13.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT14.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT15.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT16.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT17.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT18.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT18.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT20.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT21.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT22.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT23.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT24.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT25.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT26.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT27.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT28.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT29.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT30.Properties).DecimalPlaces := intDecUni;

    TcxCurrencyEditProperties(cxbComparativoVALTOT31.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT32.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT33.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT34.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT35.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT36.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT37.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT38.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT39.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT40.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT41.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT42.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT43.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT44.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT45.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT46.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT47.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT48.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT49.Properties).DecimalPlaces := intDecUni;
    TcxCurrencyEditProperties(cxbComparativoVALTOT50.Properties).DecimalPlaces := intDecUni;
  End;
End;

function TCotacao.fAjustaTabelaRes(ASeqRes: String; ASeqCot: String): Boolean;
begin
  Result := True;
  Try
    FqryConsulta.SQL.Clear;

    FqryConsulta.SQL.Add('DELETE FROM COTCFO_RES WHERE COT_SEQGER = ' + ASeqRes + '; ');
    FqryConsulta.SQL.Add('DELETE FROM COTITE_RES WHERE COT_SEQGER = ' + ASeqRes + '; ');
    FqryConsulta.SQL.Add('DELETE FROM COTFOR_RES WHERE COT_SEQGER = ' + ASeqRes + '; ');
    FqryConsulta.SQL.Add('DELETE FROM PCDCOT_RES WHERE PCD_SEQGER = ' + ASeqRes + '; ');

    FqryConsulta.SQL.Add('INSERT INTO COTCFO_RES (COT_SEQGER,');
    FqryConsulta.SQL.Add('                        COT_CODFOR,');
    FqryConsulta.SQL.Add('                        COT_CONPAG,');
    FqryConsulta.SQL.Add('                        COT_DTAENT,');
    FqryConsulta.SQL.Add('                        COT_ANCORA,');
    FqryConsulta.SQL.Add('                        COT_SKYPEC,');
    FqryConsulta.SQL.Add('                        COT_PITSTO,');

    FqryConsulta.SQL.Add('                        COT_UTILIZ)');
    FqryConsulta.SQL.Add('                 SELECT ' + ASeqRes+ ',');
    FqryConsulta.SQL.Add('                        COT_CODFOR,');
    FqryConsulta.SQL.Add('                        COT_CONPAG,');
    FqryConsulta.SQL.Add('                        COT_DTAENT,');
    FqryConsulta.SQL.Add('                        COT_ANCORA,');
    FqryConsulta.SQL.Add('                        COT_SKYPEC,');
    FqryConsulta.SQL.Add('                        COT_PITSTO,');
    FqryConsulta.SQL.Add('                        COT_UTILIZ');
    FqryConsulta.SQL.Add('                     FROM COTCFO ');
    FqryConsulta.SQL.Add('                  WHERE COT_SEQGER ="'+ASeqCot+'"');
    FqryConsulta.ExecSQL;

    FqryConsulta.SQL.Clear;
    FqryConsulta.SQL.Add('INSERT INTO COTITE_RES (COT_SEQGER,');
    FqryConsulta.SQL.Add('                        COT_CODITE,');
    FqryConsulta.SQL.Add('                        COT_QTDITE,');
    FqryConsulta.SQL.Add('                        COT_DESITE,');
    FqryConsulta.SQL.Add('                        COT_PJAATU,');
    FqryConsulta.SQL.Add('                        COT_FORMEN,');
    FqryConsulta.SQL.Add('                        COT_FORESC,');
    FqryConsulta.SQL.Add('                        COT_GERPED)');
    FqryConsulta.SQL.Add('                 SELECT ' + ASeqRes+ ',');
    FqryConsulta.SQL.Add('                        COT_CODITE,');
    FqryConsulta.SQL.Add('                        COT_QTDITE,');
    FqryConsulta.SQL.Add('                        COT_DESITE,');
    FqryConsulta.SQL.Add('                        COT_PJAATU,');
    FqryConsulta.SQL.Add('                        COT_FORMEN,');
    FqryConsulta.SQL.Add('                        COT_FORESC,');
    FqryConsulta.SQL.Add('                        COT_GERPED');
    FqryConsulta.SQL.Add(' FROM COTITE WHERE COTITE.COT_SEQGER = "'+ASeqCot+'"');
    FqryConsulta.ExecSQL;

    FqryConsulta.SQL.Clear;
    FqryConsulta.SQL.Add('INSERT INTO COTFOR_RES (COT_SEQGER,');
    FqryConsulta.SQL.Add('                        COT_CODFOR,');
    FqryConsulta.SQL.Add('                        COT_CODITE,');
    FqryConsulta.SQL.Add('                        COT_VALUNI,');
    FqryConsulta.SQL.Add('                        COT_SUBSTI,');
    FqryConsulta.SQL.Add('                        COT_IPIENT,');
    FqryConsulta.SQL.Add('                        COT_STATUS,');
    FqryConsulta.SQL.Add('                        COT_FREENT,');
    FqryConsulta.SQL.Add('                        COT_UNITOT,');
    FqryConsulta.SQL.Add('                        COT_ALQCBS,');
    FqryConsulta.SQL.Add('                        COT_ALQIBS,');
    FqryConsulta.SQL.Add('                        COT_ALQ_IS)');
    FqryConsulta.SQL.Add('                SELECT  ' + ASeqRes + ',');
    FqryConsulta.SQL.Add('                       C.COT_CODFOR,');
    FqryConsulta.SQL.Add('                       I.COT_CODITE,');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_VALUNI, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_SUBSTI, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_IPIENT, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_STATUS, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_FREENT, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_UNITOT, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_ALQCBS, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_ALQIBS, 0),');
    FqryConsulta.SQL.Add('                       IFNULL(F.COT_ALQ_IS, 0)');
    FqryConsulta.SQL.Add('                  FROM COTITE I  ');
    FqryConsulta.SQL.Add('                  LEFT JOIN COTCFO C ON C.COT_SEQGER = I.COT_SEQGER');
    FqryConsulta.SQL.Add('                  LEFT JOIN COTFOR F ON F.COT_SEQGER = I.COT_SEQGER');
    FqryConsulta.SQL.Add('                                    AND F.COT_CODITE = I.COT_CODITE');
    FqryConsulta.SQL.Add('                                    AND F.COT_CODFOR = C.COT_CODFOR');
    FqryConsulta.SQL.Add('                 WHERE I.COT_SEQGER = "'+ASeqCot+'"');
    FqryConsulta.ExecSQL;

    FqryConsulta.SQL.Clear;
    FqryConsulta.SQL.Add('INSERT INTO PCDCOT_RES (PCD_CODITE,');
    FqryConsulta.SQL.Add('                        PCD_EMPDES,');
    FqryConsulta.SQL.Add('                        PCD_QTDITE,');
    FqryConsulta.SQL.Add('                        PCD_SEQGER)');
    FqryConsulta.SQL.Add('                 SELECT PCD_CODITE,');
    FqryConsulta.SQL.Add('                        PCD_EMPDES,');
    FqryConsulta.SQL.Add('                        PCD_QTDITE,');
    FqryConsulta.SQL.Add('                       ' + ASeqRes );
    FqryConsulta.SQL.Add('                   FROM PCDCOT');
    FqryConsulta.SQL.Add('                  WHERE PCD_SEQGER = "'+ASeqCot+'"');
    FqryConsulta.ExecSQL;

    FqryConsulta.SQL.Clear;
  Except
    on E:Exception do
    Begin
      pMensagensErro(e.message, '[TCotacao.fAjustaTabelaRes]');
      Result := False;
    End

  End
end;


procedure TCotacao.pFormShow;
begin
  objRequisicao.fCarregaRequisicoes(strSeqGer, recDadGiro);

  With frmCadCotacaoGeralCX Do
  Begin

    If (fCfgSis('DIGCOT', varBoolean)) Then
    Begin
      edtCodCmp.PasswordChar := #0;
      edtCodCmp.MaxLength    := 3;
      edtCodCmp.TamCampo     := 3;
      edtCodCmp.CompZeros    := True;

      pnlDigitador.Visible := True;
//      pnlTipoCotac.Left := pnlDigitador.Left+pnlDigitador.Width;
    End
    Else
    Begin
      pnlDigitador.Visible := False;
//      pnlTipoCotac.Left := pnlDigitador.Left;
    End;

    pAjustaDecimais;
    blnEncerra := False;

    If opeOperac = opExcluir Then
      btnEncerra.Visible := FALSE;

    btnSemelhantes.Visible := fCfgSis('UTISEM', varBoolean);

    cxbItensDESITE.Options.Editing := objCotacao.blnEdiCot;
    dtsCotGer.DataSet              := objCotacao;

    If Not objCotacao.FieldByName('COT_DTAFIN').IsNull Then
    Begin
      btnGravar.Visible := FALSE;
      pnlDados.Enabled   := FALSE;

      // ITENS
      cxbItens.OptionsData.Editing := False;
      pnlTail.Enabled    := FALSE;
      btnIncluir.Visible := FALSE;
      btnExcluir.Visible := FALSE;
      btnGiroEst.Visible := FALSE;

      // FORNECEDORES
      cxvFornecedores.OptionsData.Editing := False;
      pnlTailFornecedores.Visible := FALSE;
      btnMarDes.Visible := FALSE;
      btnImpArq.Visible := FALSE;
      btnExpArq.Visible := FALSE;

      // ITENS POR FOENECEDOR
      cxbItensFornec.OptionsData.Editing := False;
      dbeDtaEnt.ReadOnly  := TRUE;
      dbeConPag.ReadOnly  := TRUE;

      // COMPARATIVO
      cxbComparativo.OptionsData.Editing := False;
      btnMarPre.Visible := FALSE;
      btnGerPed.Visible := FALSE;
      btnSelMen.Visible := FALSE;
      btnEncerra.Visible := FALSE;
    End;

    dbeMulLoj.ReadOnly := Not ((objCotacao.State = dsInsert)  And (objCotacao.cdsItens.IsEmpty));

    cxvFornecedores.DataController.DataSource := objCotacao.cdsFornecedores.dtsSource;

    pSetaItensGrid(True);

    If edtCodCmp.PasswordChar <> '*' Then
      edtCodCmp.Text := FieldByName('COT_CODCMP').AsString;
    edtNomCmp.Text := fRetNomVendRep(FieldByName('COT_CODCMP').AsString);
    edtNomDig.Text := fRetNomVendRep(FieldByName('COT_CODDIG').AsString);
    edtCodTct.Text := FieldByName('COT_CODTCT').AsString;
    edtDesTct.Text := FieldByName('DESTCT').AsString;

    if FindField('COT_CODSOL') <> nil then
      edtCodSolicitacaoVinculada.Text := FieldByName('COT_CODSOL').AsString;

    dtsCotCfo.DataSet := cdsFornecedores;

    pCarregaComboFonecedores;

    pGridsFirst;
    pMarcarSimilar;
    pAtualizaTotalSelecionado;
    {Ajusta Status para forncedores Pit Stop Caso tenha acabado o processamento mas não notifiou o Autcom}
    pAjustaStatusCotacaoPitStop;

  End;
End;

Procedure TCotacao.pGridsFirst;
Begin
  With frmCadCotacaoGeralCX Do
  Begin
    cxbItens.NavigatorButtons.First.Click;
    cxbItensFornec.NavigatorButtons.First.Click;
    cxbComparativo.NavigatorButtons.First.Click;
    cxbAtuPrecos.NavigatorButtons.First.Click;
  End;
End;

Function TCotacao.fJaGerouPedido: Boolean;
  Var
    qryPcmger: TUniQuery;
Begin
  Result := False;

  qryPcmger := fCriaQuery;

  With qryPcmger, SQL Do
  Begin
    Add('SELECT');
    Add('  GROUP_CONCAT(CONCAT(PCG_NUMPED, "-", PCG_CODEMP)) AS NUMPED ');
    Add('FROM');
    Add('  PCMGER');
    Add('WHERE');
    Add('  PCG_NUMCOT = :NUMCOT AND');
    Add('  PCG_EMPCOT = :EMPCOT');

    ParamByName('NUMCOT').AsString := Self.FieldByName('COT_NUMCOT').AsString;
    ParamByName('EMPCOT').AsString := Self.FieldByName('COT_CODEMP').AsString;

    Open;

    If (Not IsEmpty) And (Not fEmptyStr(FieldByName('NUMPED').AsString)) Then
    Begin
      Result := True;
      pMensagemOk('Há pedido(s) gerado(s) por essa cotação: ' + FieldByName('NUMPED').AsString + '.' + #13#10 + 'Exclusão não permitida!');
    End;

  End;

  FreeAndNil(qryPcmger);
End;

Function TCotacao.fAlteraCotacao(opeOperacao: TTipoOperacao): Boolean;
  Var
    intRecNo: Integer;
    strTrava: String;
    strTrava2: String;
    strlPedidos: TStringList;
    intContador: Integer;
Begin
  Result := FALSE;
  blnUtilizouGiro := False;

  FFornecApi.Text := '';
  EmProcessamento := False;


  recDadGiro.blnConsPedVen := True;
  recDadGiro.blnConsGarPen := True;
  recDadGiro.blnConsOrdPro := True;
  recDadGiro.blnRecuperCot := blnRecuperaCotacao;

  If (opeOperacao <> opIncluir) And IsEmpty Then
    Exit;

  blnDesmembraCotacao := False;
  strTrava  := '';
  strTrava2 := '';

{
  If (Not blnRecuperaCotacao) Then
    strSEQGER_TabelaOficial := FieldbyName('AUTOINCREM').AsString;
}

  If (opeOperacao <> opExcluir) And (Not blnRecuperaCotacao) Then
    If fSelecionaRecuperaCotacao(opeOperacao = opAlterar) Then
      Exit;

  Try
    If (opeOperacao <> opIncluir) Then
    Begin
      If IsEmpty Then
        Exit;

      If blnRecuperaCotacao Then
      Begin
        strTrava  := 'COTACAO_' + IIf(FieldbyName('COT_NUMCOT').AsString = '',
                                      FieldbyName('AUTOINCREM').AsString,
                                      FieldbyName('COT_NUMCOT').AsString) + '_' + FieldbyName('COT_CODEMP').AsString;
        If Not fEmptyStr(FieldbyName('COT_NUMCOT').AsString) Then
          strTrava := 'COTACAO_' + FieldbyName('COT_NUMCOT').AsString + '_' + FieldbyName('COT_CODEMP').AsString;
      End
      Else
      Begin
        strTrava := 'COTACAO_' + FieldbyName('COT_NUMCOT').AsString + '_' + FieldbyName('COT_CODEMP').AsString;
      End;

      If (Not fLock_Unlock(strTrava, True, False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa cotação está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
        Exit;
      End;
    End;
    Try
      pInicializaVariaveisEdicao;

      opeOperac := opeOperacao;

      frmCadCotacaoGeralCX := Nil;

      If Not Self.Active Then
        Exit;

      If opeOperac = opIncluir Then
        strSeqGer := ''
      Else
        strSeqGer := FieldByName('AUTOINCREM').AsString;

      Case opeOperacao Of
        opAlterar,
        opExcluir: Begin
                     If Self.IsEmpty Then
                       Exit;

                     If (FieldByName('COT_DTAFIN').AsDateTime > 0) And
                        (Not fVerificaAcessoSistema('DELCEN')) Then
                     Begin
                        fMensagem('', 'Usuário sem permissão de Excluir Cotações já Encerradas!', ['&O k']);
                        Exit;
                     End;
                   End;
      End;

      Case opeOperacao Of
        opExcluir: Begin
                     If fJaGerouPedido Then
                       Exit;
                     If (fMensagem('', 'Confirma a exclusão da Cotação ' +
                           FieldbyName('COT_NUMCOT').AsString + ' ?', ['&Sim', '&Não']) <>  1) Then
                       Exit;
                   End
        Else       Begin
                     pCriarFormularios(TfrmCadCotacaoGeralCX, frmCadCotacaoGeralCX);
                     frmCadCotacaoGeralCX.objCotacao     := Self;
                     pCarregaConfiguracoes(frmCadCotacaoGeralCX);
                   End;
      End;

      Case opeOperacao Of
        opIncluir: Begin
                     Insert;
                     FieldByName('COT_DTACAD').AsDateTime := VS_Date;
                     FieldByName('COT_LIBBID').AsString   := 'N';
                     FieldByName('COT_CODEMP').AsString   := VS_strCodEmp;
                     FieldByName('COT_MULLOJ').AsString   := 'N';
                     FieldByName('COT_NOVIPI').AsString   := 'N';
                     FieldByName('COT_MESGIR').AsInteger  := 3;
                     FieldByName('COT_MESMOS').AsInteger  := fCfgSis('MESMOS', VarInteger);
                     FieldByName('COT_MESATU').AsString   := 'N';
                   End;
        opAlterar: Edit;
      End;

      Try
        If (opeOperacao = opExcluir ) Then
        Begin
          tpgGerarPedidos := tpgNaoGera;
          Result          := fSalvaCotacao;
        End

        Else
        Begin
          pCarregaItensMultiLoja;

          If Not fCarregaCotacao Then
            Exit;

          If FAtualizarDadosSintetizados Then
            pAtualizaDadosSintetizados
          Else If FSintetizarItens Then
            pSintetizaItens;

          pEnableControlsItens;
          pSetaEventosItem(True);

          pFormShow;
          If fCfgSis('UTIBID', varBoolean) Then
          Begin
            If Self.FieldByName('COT_LIBBID').AsString = 'N' Then
              frmCadCotacaoGeralCX.rdbNaoLiberado.Checked := True;
            If (Self.FieldByName('COT_LIBBID').AsString = 'L') Or
               (Self.FieldByName('COT_LIBBID').AsString = 'I') Then
              frmCadCotacaoGeralCX.rdbLiberado.Checked := True;

          End;
          blnDeveExcluirCOTFOR := False;
          Result := (frmCadCotacaoGeralCX.ShowModal = mrOk)  Or blnEncerra;
          pSalvaConfiguracoes(frmCadCotacaoGeralCX);
          If Result Then
          Begin
            strCodCmp := Self.fRetCodComprador(frmCadCotacaoGeralCX.edtCodCmp.Text);
            strCodDig := Self.fRetCodDigitador(frmCadCotacaoGeralCX.edtCodDig.Text);
            strCodTct := frmCadCotacaoGeralCX.edtCodTct.Text;
            strCodSolicitacao := frmCadCotacaoGeralCX.edtCodSolicitacaoVinculada.Text;

            If (Not blnSalvouCotacao) and (blnRecuperaCotacao) Then
              pSalvaCopiaSegurancaPermanente
            Else
            Begin
              Result    := fSalvaCotacao;
              If Result  then
                pApaga_CopiaSeguranca(strSeqGerBKP);
            End;
          End;

          If Not Result Then
            Cancel;

          If Result And (Not fEmptyStr(strLisPed)) Then
            fMensagem('','PEDIDO(S) DE COMPRA GERADO(S): ' + strLisPed, ['&OK']);

        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      intRecNo := RecNo;

      If Assigned(frmCadCotacaoGeralCX) Then
      Begin
        If (frmCadCotacaoGeralCX.edtCodSolicitacaoVinculada.Visible) and Result Then
        begin
          if not TManutencaoEquipamentoInterno.fVinculaSolicitacao(frmCadCotacaoGeralCX.edtCodSolicitacaoVinculada.Text, Self.FieldByName('COT_NUMCOT').AsString, 'CT') then
            pMensagemOk('Erro ao gravar vinculo com solicitação de manutenção de equipamento interno');

          If Not fEmptyStr(strLisPed) Then
          Begin
            try
              strlPedidos := TStringList.Create;
              strlPedidos.Delimiter := ',';
              strlPedidos.StrictDelimiter := True;
              strlPedidos.DelimitedText := strLisPed;

              for intContador := 0 to strlPedidos.Count - 1 do
              begin
                TManutencaoEquipamentoInterno.fVinculaSolicitacao(frmCadCotacaoGeralCX.edtCodSolicitacaoVinculada.Text, strlPedidos[intContador], 'PD');
              end;
            finally
              FreeAndNil(strlPedidos);
            end;
          End;
        end;
      End;

      If Result Then
      Begin
        blnRecuperaCotacao := False;
        If (opeOperacao = opIncluir) And (FstcStatus = stcBaixadas) Then
          fAbreCotacao(stcAbertas)
        Else
          fAbreCotacao(FstcStatus);

        Case opeOperacao of
          opIncluir: Self.Locate('COT_NUMCOT', strNumCot, []);

          Else       If (intRecNo > 0) And (intRecNo <= RecordCount) Then
                       RecNo := intRecNo;
        End;
      End;


    Except
      On E: Exception Do
      Begin
        If State in [dsEdit, dsInsert] Then
          Self.Cancel;

        Result := False;
        pMensagensErro(E.Message, '[AflteraCotacao]');
      End;
    End;

    Try
      If Assigned(frmCadCotacaoGeralCX) Then
      Begin
        pFinalizaVariaveis;
        pFreeAndNil(frmCadCotacaoGeralCX);
      End;

      cdsFornecedores.EnableControls;

      pEnableControlsItens;

      If Assigned(cdsItensMultiLojas) Then
      Begin
        cdsItensMultiLojas.EnableControls;
        cdsItensMultiLojas.Filtered := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[AflteraCotacao]');
      End;
    End;
  Finally
    If Not fEmptyStr(strTrava) Then
      fLock_Unlock(strTrava, False, False);

    If Not fEmptyStr(strTrava2) Then
      fLock_Unlock(strTrava2, False, False, True, '', True, '', False, False, True, True, True, True);

  End;
End;

function TCotacao.fSqlFornecedores: String;
 function fSqlEmaCot: String;
  begin
    Result := Result + '  IF(EMA_DTAENV IS NULL,"Não","Sim") AS EMA_EMAENV,              ';
    Result := Result + '  EMA_DESTIN,                                                    ';
    Result := Result + '  (SELECT                                                        ';
    Result := Result + '    (CONCAT(DATE_FORMAT(EMA_DTAENV,"%d/%m/%Y"), " ", EMA_HRAENV))';
    Result := Result + '   FROM                                                          ';
    Result := Result + '    EMACOT                                                       ';
    Result := Result + '   WHERE                                                         ';
    Result := Result + '    EMA_SEQGER = ' + QuotedStr(strSeqGer) + ' AND                ';
    Result := Result + '    EMA_CODFOR = COT_CODFOR                                      ';
    Result := Result + '   ORDER BY EMA_HRAENV DESC LIMIT 1) AS EMA_DTAENV,              ';
  end;
Begin
  Result := '';

  Result := Result + ' SET @CONTADOR=0; ';

  Result := Result + ' SELECT ';
  Result := Result + '   COTCFO.*,                              ';
  Result := Result +      fSqlEmaCot;
  Result := Result + '   (@CONTADOR:=@CONTADOR + 1) AS POSICAO, ';
  Result := Result + '   FOR_C_G_C_,                              ';
  Result := Result + '   COT_IMGAPI, ';
  Result := Result + '   CAST(""  AS CHAR(200))COT_STAAPI, ';
  Result := Result + '   COT_INIINT, ';

  Result := Result + '   (SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = COT_CODFOR) AS NOMFOR,  ';
  Result := Result + '   CAST("N" AS CHAR(1)) AS MARCADO,  ';
  Result := Result + '   (SELECT REPLACE(FOR_OBSERV,"<<csq>>"," ") FROM CADFOR WHERE FOR_CODFOR = COT_CODFOR) AS OBSERV  ';
  Result := Result + ' FROM            ';
  Result := Result + '   COTCFO ';
  Result := Result + '  LEFT JOIN';
  Result := Result + '    EMACOT ON ';
  Result := Result + '     EMA_SEQGER = ' + QuotedStr(strSeqGer) + ' AND ';
  Result := Result + '     EMA_CODFOR = COT_CODFOR';
  Result := Result + ' INNER JOIN  CADFOR ON FOR_CODFOR = COT_CODFOR ';


  Result := Result + '  WHERE COT_SEQGER = ' + QuotedStr(strSeqGer);
  Result := Result + '  GROUP BY COT_CODFOR';
  Result := Result + '  ORDER BY NOMFOR; ';

  If blnRecuperaCotacao Then
    Result := AnsiReplaceStr(Result, 'COTCFO', 'COTCFO_RES');
End;

Function TCotacao.fSQLLoadPrecos: String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL +     fSQLPrecosCadastraisItem;
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   ITEGER G ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   ITE_CODEMP = :CODEMP AND ITE_CODITE = :CODITE  ';

  Result := strSQL;
End;

Function TCotacao.fSQLPrecosCadastraisItem: String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';

  for intContador := 1 to Length(VS_strTabPrc) do
  Begin
    strSQL := strSQL + '     ITE_MARBR' + IntToStr(intContador) + ' AS MARBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     ITE_PREVE' + IntToStr(intContador) + ' AS PREVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     ITE_COMTB' + IntToStr(intContador) + ' AS COMTB' + IntToStr(intContador) + ', ';
  End;

  strSQL := strSQL + '   G.ITE_PRECOM AS PRECOM, ';
  strSQL := strSQL + '   G.ITE_PRECUS AS PRECUS, ';

  strSQL := strSQL +  '@COMLIQ := ' + STR_COMLIQ + ' AS COMLIQ, ';


  strSQL := strSQL +   sqlPrecomImp + ' AS PREIMP, ';
  strSQL := strSQL +   STR_CUSREA + ' AS CUSREA, ';

  strSQL := strSQL + '   G.ITE_DESF01 AS DESF01, ';
  strSQL := strSQL + '   G.ITE_DESF02 AS DESF02, ';
  strSQL := strSQL + '   G.ITE_DESF03 AS DESF03, ';
  strSQL := strSQL + '   G.ITE_DESF04 AS DESF04, ';
  strSQL := strSQL + '   G.ITE_DESF05 AS DESF05, ';
  strSQL := strSQL + '   G.ITE_DESF06 AS DESF06, ';
  strSQL := strSQL + '   G.ITE_ICMENT AS ICMENT, ';
  strSQL := strSQL + '   G.ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '   G.ITE_FREENT AS FREENT, ';
  strSQL := strSQL + '   G.ITE_ACRFIN AS ACRFIN, ';
  strSQL := strSQL + '   G.ITE_SUBSTI AS SUBSTI, ';
  strSQL := strSQL + '   G.ITE_VALFRE AS VALFRE, ';
  strSQL := strSQL + '   G.ITE_DESADB AS DESADB, ';
  strSQL := strSQL + '   G.ITE_SUBFED AS SUBFED, ';
  strSQL := strSQL + '   G.ITE_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '   G.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '   G.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '   G.ITE_DESOPE AS DESOPE, ';
  strSQL := strSQL + '   G.ITE_TCIFCU AS TCIFCU, ';
  strSQL := strSQL + '   G.ITE_TSCUST AS TSCUST, ';
  strSQL := strSQL + '   G.ITE_DEPICO AS DEPICO, ';
  strSQL := strSQL + '   G.ITE_DEICMS AS DEICMS, ';
  strSQL := strSQL + '   G.ITE_FATREG AS FATREG  ';

  Result := strSQL;
End;

Function TCotacao.fSQLDadosCadastraisItem(AblnCarregandoCotacao: boolean = False): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';

  strSQL := strSQL + '   U.UNI_SIGUNI AS UNIMED,  ';

  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   I.ITE_DESITE AS DESCRI, ';
  strSQL := strSQL + '   IFNULL(I.ITE_CODSIM, "") AS CODSIM, ';
  strSQL := strSQL + '   I.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   I.ITE_EMBALA AS EMBALA, ';

  If fCfgSis('MENAPL', varBoolean) Then
    strSQL := strSQL + ' CONCAT(IFNULL(I.ITE_APLICA,""), ' + 'CASE WHEN IFNULL(I.ITE_APLICA,"") = "" THEN "" ELSE ' + QuotedStr('\r\n') + ' END ' + ', IFNULL(I.ITE_MSGLV1,""), ' + QuotedStr('\r\n') + ', IFNULL(I.ITE_MSGLV2,"")) AS APLICA, '
  Else
    strSQL := strSQL + '  I.ITE_APLICA AS APLICA, ';

  strSQL := strSQL + '   I.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '   I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   I.ITE_MSGLV1 AS MSGLV1, ';
  strSQL := strSQL + '   I.ITE_PESOIT AS PESOCD, ';

  strSQL := strSQL + '   I.ITE_ITEATI AS ITEATI, ';
  strSQL := strSQL + '   I.ITE_ATICOM AS ATICOM, ';

  strSQL := strSQL + '   CAST((SELECT GROUP_CONCAT(SEM_CODSEM) FROM CADSEM WHERE I.ITE_CODITE = SEM_CODITE) AS CHAR(255)) AS CODSEM, ';

  strSQL := strSQL + '     MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL + '   I.ITE_CODUNI AS CODUNI, ';
  strSQL := strSQL + '   CAST(IFNULL((SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = ITE_UNICOM), "") AS CHAR(5)) AS UNICOM, ';
  strSQL := strSQL + '   CAST(IFNULL((SELECT UNI_SIGUNI FROM CADUNI WHERE UNI_CODUNI = ITE_CODUNI), "") AS CHAR(5)) AS SIGUNI, ';

  strSQL := strSQL + '   G.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '   G.ITE_SALDOS AS SALDOS, ';

  strSQL := strSQL + fSQLSaldoDisponivel('G', True, False, True) + ' AS SALDIS, ';
  If (AblnCarregandoCotacao) And (Not fEmptyStr(recDadGiro.strEmpGir)) And (recDadGiro.strPedMlj = 'S') Then
  Begin
    strSQL := strSQL + '(   ';
    strSQL := strSQL + ' SELECT SUM(IFNULL(LG.ITE_SALDOS,0)) FROM ITEGER AS LG  ';
    strSQL := strSQL + '    WHERE LG.ITE_CODITE = C.COT_CODITE AND LG.ITE_CODEMP IN (' +  recDadGiro.strEmpGir + ') ';
    strSQL := strSQL + ' ) AS SALDOS_LOJAS_GIROS, ';
  End
  Else
    strSQL := strSQL + '   CAST(0.0000 AS DECIMAL(14,4)) AS SALDOS_LOJAS_GIROS, ';

  strSQL := strSQL + '   G.ITE_PRECUS AS PRECUS, ';

  strSQL := strSQL +   fSQLPrecosCadastraisItem + ', ';

  for intContador := 1 to Length(VS_strTabPrc) do
  Begin
    strSQL := strSQL + '     ITE_MARBR' + IntToStr(intContador) + ' AS DIGBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS NOVBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS DIFBR' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS NOVVE' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS NOVCA' + IntToStr(intContador) + ', ';
    strSQL := strSQL + '     0.0000 AS DIFER' + IntToStr(intContador) + ', ';
  End;


  strSQL := strSQL + '   T2.DTAULT AS DTAULT, ';
  strSQL := strSQL + '   CAST(CONCAT(T2.FORULT, "-", UF.FOR_NOMFOR) AS CHAR(255)) AS FORULT, ';
  strSQL := strSQL + '   T2.PREULT AS PREULT, ';
  strSQL := strSQL + '   ROUND(T2.IMPULT, 2) AS IMPULT, ';

  If blnAtuPre Then
    strSQL := strSQL + ' CAST("' + STR_TIPALT_PRECO + '" AS CHAR(5))  AS TIPALT,   '
  Else
    strSQL := strSQL + ' CAST("' + STR_TIPALT_MARGEM + '" AS CHAR(6)) AS TIPALT,  ';

  strSQL := strSQL + '   I.ITE_PRISIM AS PRISIM, ';
  strSQL := strSQL + '   @ITESIM := (SELECT SM.ITE_CODITE FROM CADITE SM' +
                     '     INNER JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE ' +
                     '           AND SG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) +
                     '     WHERE SM.ITE_CODSIM  = I.ITE_CODSIM ' +
                     '           AND SM.ITE_CODSIM IS NOT NULL ' +
                     '           AND SM.ITE_ITEATI = "S"   ' +
                     '           AND SM.ITE_PRISIM = "S"   ' +
                     '     LIMIT 1) ,';
  strSQL := strSQL + '   CONCAT(IFNULL(@ITESIM,I.ITE_CODITE),IF(I.ITE_PRISIM = "S","A","B"),I.ITE_CODITE) AS ORDITE, ';

  strSQL := strSQL + '   (SELECT SUM(IF(SG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ', SG.ITE_SALDOS, 0)) ' +
                     '   FROM CADITE SM' +
                     '   JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE ' +
                     '   WHERE SM.ITE_CODSIM =  I.ITE_CODSIM ' +
                     '   AND SM.ITE_CODSIM IS NOT NULL ' +
                     '   AND SG.ITE_CODITE <>  I.ITE_CODITE) SALSIM,' ;

  strSQL := strSQL + '   (SELECT SUM(SG.ITE_SALDOS) ' +
                     '   FROM CADITE SM' +
                     '   JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE ' +
                     '   WHERE SM.ITE_CODSIM =  I.ITE_CODSIM ' +
                     '   AND SM.ITE_CODSIM IS NOT NULL ' +
                     '   AND SG.ITE_CODITE <>  I.ITE_CODITE ' +
                     ') SLMSIM,' ;

  strSQL := strSQL + ' G.ITE_IMPLIS AS ITE_IMPLIS, ';
  Result := strSQL;
End;

Function TCotacao.fSQLInnerItem(blnNovoItem: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + ' LEFT JOIN ( ' + fSQLTabUltimaCompra(blnNovoItem) + ') AS T2 ON T2.CODITE = I.ITE_CODITE ';

  strSQL := strSQL + ' LEFT  JOIN CADFOR UF ON UF.FOR_CODFOR = T2.FORULT ';

  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  strSQL := strSQL + ' LEFT  JOIN CADMAR ON ITE_CODMAR = MAR_CODMAR ';

  Result := strSQL;
End;

Function TCotacao.fSQLTabUltimaCompra(blnNovoItem: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + '   SELECT T1.ITE_CODITE AS CODITE, T1.ITE_DTAULT AS DTAULT , T1.ITE_PREULT AS PREULT, T1.ITE_IMPULT AS IMPULT, T1.ITE_FORULT AS FORULT FROM ( ';
  strSQL := strSQL + '     SELECT UG.ITE_CODITE, UG.ITE_DTAULT, UG.ITE_PREULT, UG.ITE_IMPULT, UG.ITE_FORULT FROM ITEGER UG ';

  If Not blnNovoItem Then
    strSQL := strSQL + '     INNER JOIN COTITE CT ON CT.COT_CODITE = UG.ITE_CODITE AND CT.COT_SEQGER = ' + QuotedStr(strSeqGer);

  strSQL := strSQL + '     WHERE UG.ITE_DTAULT IS NOT NULL ';

  If blnNovoItem Then
    strSQL := strSQL + '     AND UG.ITE_CODITE = :CODITE ';

  strSQL := strSQL + '     ORDER BY UG.ITE_CODITE, UG.ITE_DTAULT DESC, UG.ITE_DHUPES DESC) AS T1 ';
  strSQL := strSQL + '   GROUP BY T1.ITE_CODITE ';

  Result := strSQL;
End;

Function TCotacao.fSQLItens(blnCarregandoCotacao: Boolean =False): String;
  Var
    strSQL,
    strTotalReforma: String;
    intContador: Integer;
    recSQLReforma: TSQLValoresReforma;
Begin
  strSQL := '';

  recSQLReforma := TCalculoReformaCompra.fSQLValores('IFNULL(COT_VALUNI, 0) + ' + sqlFreEntImp_COT_COM,
                                                    'IFNULL(COT_ALQCBS, 0)', 'IFNULL(COT_ALQIBS, 0)', 'IFNULL(COT_ALQ_IS, 0)');
  strTotalReforma := '';
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    strTotalReforma := ' + (IFNULL(C.COT_QTDITE, 0)) * ' + recSQLReforma.fTotal;
  strSQL := strSQL + ' SELECT                    ';
  strSQL := strSQL + fSQLDadosCadastraisItem(blnCarregandoCotacao);

  // INFORMACOES DA COTACAO
  strSQL := strSQL + '   CAST(IF(COT_PJAATU IS NULL OR COT_PJAATU = "", "N", COT_PJAATU) AS CHAR(1)) AS PJAATU,   ';

  // SELECIONADO MANUALMENTE - TESTAR APENAS NA INCLUSÃO DE NOVOS ITENS
  strSQL := strSQL + '   CAST("N" AS CHAR(1))       AS SELMAN,  ';

  strSQL := strSQL + '   CAST("N" AS CHAR(1))       AS ATUPRE,  ';
  If blnRecuperaCotacao Then
    strSQL := strSQL + '   CAST("S" AS CHAR(1))       AS ALTERADO,'
  else
    strSQL := strSQL + '   CAST("N" AS CHAR(1))       AS ALTERADO,';

  strSQL := strSQL + '   0.0000    AS NOVCUS,   ';
  strSQL := strSQL + '   0    AS REQUIS,   ';

  strSQL := strSQL + '   0.0000    AS NOVREA,   ';


  strSQL := strSQL + '   0.0000    AS DIFCOM,   ';

  strSQL := strSQL + '   IF(G.ITE_PRECUS > 0, ((((@VALUNI:=(SELECT COT_VALUNI FROM COTFOR F WHERE ';
  strSQL := strSQL + '       F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = C.COT_FORESC AND C.COT_CODITE = F.COT_CODITE)) - G.ITE_PRECUS) / G.ITE_PRECUS) * 100), ';
  strSQL := strSQL + '                  NULL) AS DIFCUS, ';

  strSQL := strSQL + '   IF(' + STR_CUSREA + ' > 0, ((((' + STR_CUSREA_NOV + ') - ' + STR_CUSREA + ' ) / ' + STR_CUSREA + ' ) * 100), ';
  strSQL := strSQL + '                  NULL) AS DIFREA, ';

  strSQL := strSQL + ' @PRECOM_LIQ := ' + sqlPrecomImp + ' AS PRECOM_LIQ ,';
  strSQL := strSQL + ' @PRECOM_LIQ_COT := ' + sqlPrecomImp_COT + ' AS PRECOM_LIQ ,';


  strSQL := strSQL + '   IF(@PRECOM_LIQ   > 0, ((((@PRECOM_LIQ_COT ) - @PRECOM_LIQ ) / @PRECOM_LIQ  ) * 100), ';
  strSQL := strSQL + '                  NULL) AS DIFPREIMP, ';

  strSQL := strSQL +    sqlPrecomImp_COT + ' AS PREIMP_NOV, ';

  strSQL := strSQL +    sqlPrecomImp_COT +  'AS PREESC, ';

  strSQL := strSQL +    '('+sqlFreEntImp_COT + ' *  C.COT_QTDITE) AS FREESC, ';

  strSQL := strSQL + '   0            AS DIAEST,   ';
  strSQL := strSQL + '   0            AS DIASUG,   ';
  strSQL := strSQL + '   CAST(0 AS DECIMAL(15,2)) AS MEDVEN,   ';
  strSQL := strSQL + '   (ITE_PRECOM * (1 -  ITE_DESF01 / 100) * '  +
                     '                 (1 -  ITE_DESF02 / 100) * '  +
                     '                 (1 -  ITE_DESF03 / 100) * '  +
                     '                 (1 -  ITE_DESF04 / 100) * '  +
                     '                 (1 -  ITE_DESF05 / 100) * '  +
                     '                 (1 -  ITE_DESF06 / 100)) AS PRCLIQ, ';

  If blnEdiCot then
    strSQL := strSQL + '   COT_DESITE AS DESITE, '
  Else
    strSQL := strSQL + '   IF(LOCATE("ITEM ESPECIAL", I.ITE_DESITE) > 0, COT_DESITE, I.ITE_DESITE) AS DESITE, ';

  strSQL := strSQL + '   (C.COT_QTDITE * I.ITE_PESOIT) AS PESOIT,  ';
  strSQL := strSQL + '   C.COT_FORMEN AS FORMEN,  ';
  strSQL := strSQL + '   C.COT_FORESC AS FORESC,  ';
  strSQL := strSQL + '   C.COT_QTDITE AS QTDITE,  ';
  strSQL := strSQL + '   C.COT_GERPED AS GERPED,  ';
  strSQL := strSQL + '   CAST("N" AS CHAR(1)) AS MARPED, ';
  strSQL := strSQL + '   CAST("N" AS CHAR(1)) AS EXCLUI, ';
  strSQL := strSQL + '   CAST("N" AS CHAR(1)) AS ITESIM, ';

  intContador := 1;

  cdsFornecedores.IndexFieldNames := 'POSICAO';

  cdsFornecedores.First;
  While Not cdsFornecedores.Eof Do
  Begin
    strSQL := strSQL + ' IFNULL((SELECT F.COT_VALUNI FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS VALUNI' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_SUBSTI FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS SUBSTI' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_IPIENT FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS IPIENT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_ALQCBS FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS ALQCBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_ALQIBS FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS ALQIBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_ALQ_IS FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS ALQ_IS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT (IFNULL(C.COT_QTDITE, 0)) * ' + recSQLReforma.strCbs + ' FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS TOTCBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT (IFNULL(C.COT_QTDITE, 0)) * ' + recSQLReforma.strIbs + ' FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS TOTIBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT (IFNULL(C.COT_QTDITE, 0)) * ' + recSQLReforma.strIs + ' FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS TOT_IS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_FREENT FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.00) AS FREENT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT                                            ' + sqlPrecomImp_COT_COM + '     FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS UNITOT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT                             (IFNULL(C.COT_QTDITE, 0) ) * ' + sqlPrecomImp_COT_COM + strTotalReforma + '     FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS VALTOT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT IF(COT_FORESC = COT_CODFOR, (IFNULL(C.COT_QTDITE, 0) ) * ' + sqlPrecomImp_COT_COM + strTotalReforma + ', 0) FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), 0.0000) AS TOTESC' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00 AS TOTESCF2' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' IFNULL((SELECT F.COT_CODFOR FROM COTFOR F WHERE F.COT_SEQGER = C.COT_SEQGER AND F.COT_CODFOR = ' + QuotedStr(cdsFornecedores.FieldByName('COT_CODFOR').AsString) + ' AND C.COT_CODITE = F.COT_CODITE), CAST("" AS CHAR(8))) AS CODFOR' + fIndice(intContador) + ', ';

    cdsFornecedores.Next;

    Inc(IntContador);
  End;

  For intContador := Succ(cdsFornecedores.RecordCount) To INT_MAX_FORNECEDOR Do
  Begin
    strSQL := strSQL + ' 0.0000 AS VALUNI' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS SUBSTI' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS IPIENT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS ALQCBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS ALQIBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS ALQ_IS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS TOTCBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS TOTIBS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS TOT_IS' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.00   AS FREENT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS UNITOT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS VALTOT' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS TOTESC' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' 0.0000 AS TOTESCF2' + fIndice(intContador) + ', ';
    strSQL := strSQL + ' CAST("" AS CHAR(8)) AS CODFOR' + fIndice(intContador) + ', ';
  End;

  strSQL := strSQL + ' 0.0000 AS VLRUNT, ';
  strSQL := strSQL + ' 0.0000 AS DIFCOL, ';

  strSQL := strSQL + ' 0.0000 AS QTDREQ, ';

  strSQL := strSQL + '  C.AUTOINCREM AS AUTCOT,  ';
  If blnCarregandoCotacao Then
    strSQL := strSQL + '  CAST("1" AS CHAR(1))          AS VENDIDO  '
  Else
    strSQL := strSQL + '  CAST("" AS CHAR(1))          AS VENDIDO  ';

  strSQL := strSQL + ' FROM            ';
  strSQL := strSQL + '   COTITE C ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = C.COT_CODITE ';
  strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

  strSQL := strSQL +   fSQLInnerItem(False);

  strSQL := strSQL + ' WHERE C.COT_SEQGER = ' + QuotedStr(strSeqGer);

  strSQL := strSQL + ' AND (IFNULL(C.COT_SEQGER, "") <> "") ';

  strSQL := strSQL + ' ORDER BY CODITE  ';

  If blnRecuperaCotacao Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'COTITE', 'COTITE_RES');
    strSQL := AnsiReplaceStr(strSQL, 'COTFOR', 'COTFOR_RES');
  End;

  Result := strSQL;
End;

Function TCotacao.fSQLNovoItem: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                       ';
  strSQL := strSQL + fSQLDadosCadastraisItem;

  strSQL := strSQL + '   ITE_DESITE AS DESITE       ';
  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   CADITE I                   ';

  strSQL := strSQL +   fSQLInnerItem(True);

  strSQL := strSQL + ' LEFT JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';

  strSQL := strSQL + ' WHERE I.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TCotacao.fRetSumValTot(intIndFor: Integer): Double;
Begin
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_VALTOT' + fIndice(intIndFor))
  Else
    Result := 0;
End;

Function TCotacao.fRetSumValUni(intIndFor: Integer): Double;
Begin
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_UNITOT' + fIndice(intIndFor))
  Else
    Result := 0;
End;

function TCotacao.fRetTotalCotacao(cdsDados: TDataSet; strIndFor: String): Double;
var
  fltTotal,
  fltTotalUni: Double;
  strNomeCampo: String;
begin
  fltTotal := 0.0;

  strNomeCampo := 'VALUNI' + strIndFor;

  With cdsDados Do
  Begin
    First;
    While not Eof Do
    Begin
      fltTotalUni := FieldByName('QTDITE').AsFloat * FieldByName(strNomeCampo).AsFloat;
      fltTotal := fltTotal + fltTotalUni;

      Next;
    End;
  End;

    Result := fltTotal;
end;

Function TCotacao.fRetSumSubsti(intIndFor: Integer): Double;
Begin
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_SUBTOT' + fIndice(intIndFor))
  Else
    Result := 0;
End;

Function TCotacao.fRetSumIpiEnt(intIndFor: Integer): Double;
Begin
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_IPITOT' + fIndice(intIndFor))
  Else
    Result := 0;
End;

// Aliquota fora de 0 a 100 na planilha nao e importada: fica a atual
function TCotacao.fAliquotaImportada(const AfltAtual, AfltLida: Double): Double;
begin
  Result := AfltAtual;
  If TAliquotasReforma.fAliquotaValida(AfltLida) Then
    Result := AfltLida;
end;

Function TCotacao.fRetSumCampo(const AstrCampo: String; intIndFor: Integer): Double;
Begin
  Result := 0;
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_' + AstrCampo + fIndice(intIndFor));
End;

Function TCotacao.fRetSumFreEnt(intIndFor: Integer): Double;
Begin
  If intIndFor > -1 Then
    Result := cdsItens.fRetSoma('SUM_FRETOT' + fIndice(intIndFor))
  Else
    Result := 0;
End;

Function TCotacao.fAbreItens(blnCarregandoCotacao: Boolean = False): Boolean;
  Var
    intContador: Integer;
Begin
  cdsItens.Close;

  cdsItens.AggFields.Clear;

  For intContador := 1 To INT_MAX_FORNECEDOR Do
  Begin
    cdsItens.pCriaSoma('UNITOT' + fIndice(intContador), '', 'SUM(QTDITE * VALUNI' + fIndice(intContador) + ')');
    cdsItens.pCriaSoma('IPITOT' + fIndice(intContador), '', 'SUM(QTDITE * VALUNI' + fIndice(intContador) + ' * IPIENT' + fIndice(intContador) + ' / 100)');
    cdsItens.pCriaSoma('SUBTOT' + fIndice(intContador), '', 'SUM(QTDITE * VALUNI' + fIndice(intContador) + ' * SUBSTI' + fIndice(intContador) + ' / 100)');
    cdsItens.pCriaSoma('FRETOT' + fIndice(intContador), '', 'SUM(QTDITE * VALUNI' + fIndice(intContador) + ' * FREENT' + fIndice(intContador) + ' / 100)');

    cdsItens.pCriaSoma('VALTOT' + fIndice(intContador));
    cdsItens.pCriaSoma('TOTCBS' + fIndice(intContador));
    cdsItens.pCriaSoma('TOTIBS' + fIndice(intContador));
    cdsItens.pCriaSoma('TOT_IS' + fIndice(intContador));
  End;

  cdsItens.qryQuery.SQL.Text := fSQLItens(blnCarregandoCotacao);

  Result := cdsItens.fAbreClient(True, 'TCotacao.fAbreItens');

  cdsItens.pAlinhaCampoCentro('CODITE');
  cdsItens.pAlinhaCampoCentro('CODGRU');
  cdsItens.pAlinhaCampoCentro('DTAULT');
  cdsItens.pAlinhaCampoCentro('SIGUNI');
  cdsItens.pAlinhaCampoCentro('CODSIM');

  For intContador := 1 To INT_MAX_FORNECEDOR Do
  Begin
    cdsItens.pFormataDecimal('QTDITE', 4);
    cdsItens.pFormataDecimal('VALUNI' + fIndice(intContador), intDecUni);
    cdsItens.pFormataDecimal('IPIENT' + fIndice(intContador));
    cdsItens.pFormataDecimal('ALQCBS' + fIndice(intContador));
    cdsItens.pFormataDecimal('ALQIBS' + fIndice(intContador));
    cdsItens.pFormataDecimal('ALQ_IS' + fIndice(intContador));
    cdsItens.pFormataDecimal('FREENT' + fIndice(intContador));
    cdsItens.pFormataDecimal('SUBSTI' + fIndice(intContador));
    cdsItens.pFormataDecimal('UNITOT' + fIndice(intContador));
    cdsItens.pFormataDecimal('VALTOT' + fIndice(intContador), intDecUni);
  End;

  cdsItens.IndexFieldNames := 'CODITE';
End;

Procedure TCotacao.pSetaEventosItem(blnSetar: Boolean;
                                    blnAfterSroll: Boolean = True;
                                    blnAfterPost: Boolean  = True;
                                    blnBeforePost: Boolean = True);
Begin
  If blnSetar Then
  Begin
    If blnBeforePost Then
      cdsItens.BeforePost := pBeforePostItens;

    If blnAfterPost Then
    Begin
      cdsItens.AfterPost  := pAfterPostItens;
      pAfterPostItens(cdsItens);
    End;

    If blnAfterSroll And Assigned(frmCadCotacaoGeralCX) Then
    With frmCadCotacaoGeralCX Do
    Begin
      If (pagCotacao.ActivePage = tabItens) Or
         (pagCotacao.ActivePage = tabComparativo) Then
        pSetaAfterScrollItensGiro
      Else
        cdsItens.AfterScroll := Nil;
    End;

  End Else
  Begin

    If blnBeforePost Then
      cdsItens.BeforePost := Nil;

    If blnAfterPost Then
      cdsItens.AfterPost  := Nil;

    If blnAfterSroll Then
      cdsItens.AfterScroll:= Nil;

  End;
End;

Function TCotacao.fAbreFornecedores(cdsFornec: TZClient; blnAtualizaArrFor: Boolean = True): Boolean;
Begin
  With cdsFornec Do
  Begin
    AfterScroll := Nil;

    qryQuery.SQL.Text := fSQLFornecedores;

    Result := fAbreClient(True, 'TCotacao.fAbreFornecedores');

    pAlinhaCampoCentro('COT_CODFOR');

    FieldByName('COT_CONPAG').EditMask := MASK_CONPAG;
    FieldByName('COT_DTAENT').EditMask := '99/99/9999;1;_';

    IndexFieldNames := 'POSICAO';


    cdsFornec.First;
    If Assigned(RedeAncora) Or
       Assigned(RedeSkyPecas) Or
       Assigned(RedePitStop) Then
    begin
      while not  cdsFornec.Eof Do
      begin
        cdsFornec.Edit;
        If Assigned(RedeAncora) Then
        Begin
          if cdsFornec.FieldByName('COT_ANCORA').AsInteger = 0 then
            cdsFornec.FieldByName('COT_ANCORA').AsInteger := IIf(RedeAncora.RetApiProfile.LocateWarehouse(cdsFornec.FieldByname('FOR_C_G_C_').AsString) > -1, 1, 0);
          If cdsFornec.FieldByName('COT_ANCORA').AsInteger <> 0 Then
            pAjutaTelaApi(cdsFornec, idRedeAncora);
        End;

        If Assigned(RedeSkyPecas) Then
        Begin
          if cdsFornec.FieldByName('COT_SKYPEC').AsInteger = 0 then
            cdsFornec.FieldByName('COT_SKYPEC').AsInteger := IIf(RedeSkyPecas.ParamSkyPecas.fFornecedorSkyPecas(cdsFornec.FieldByname('COT_CODFOR').AsString), 1, 0);
          If cdsFornec.FieldByName('COT_SKYPEC').AsInteger <> 0 Then
            pAjutaTelaApi(cdsFornec, idRedeSkypecas);
        End;

        If Assigned(RedePitStop) Then
        Begin
          if TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornec.FieldByName('COT_PITSTO').AsInteger) = spscSemApi then
            cdsFornec.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(IIf(RedePitStop.fRetFornecedorDiponivel(cdsFornec.FieldByname('FOR_C_G_C_').AsString), spscComApi, spscSemApi));
          If TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornec.FieldByName('COT_PITSTO').AsInteger) <> spscSemApi  Then
            pAjutaTelaApi(cdsFornec, idRedePitStop);
        End;
        cdsFornec.Post;
        cdsFornec.Next;
      End;
    End;

    cdsFornec.First;

    If blnAtualizaArrFor Then
      pAtualizaArrFornecedores;
  End;
End;

procedure TCotacao.pSetaPosicaoArrFor;
Begin
  With cdsFornecedores Do
  Begin
    If (FieldByName('POSICAO').AsInteger <= INT_MAX_FORNECEDOR) And
       (FieldByName('POSICAO').AsInteger > 0) And
       (FieldByName('COT_UTILIZ').AsString = 'S') Then
      arrCodFor[FieldByName('POSICAO').AsInteger] := FieldByName('COT_CODFOR').AsString
    Else
      arrCodFor[FieldByName('POSICAO').AsInteger] := STR_NAO_UTILIZADO;
  End;
End;

procedure TCotacao.pSetUnidadeToClient(cdsDados: TDataSet; strIndFor: String;
  tpUnidade: TTipoUnidade);
var
  strNomeCampo: String;
begin
  If (tpUnidade = tuUnCompra) Or FExportarSemPreco Then
  Begin
    strNomeCampo := 'VALUNI' + strIndFor;

    With cdsDados Do
    Begin
      First;

      While not Eof Do
      Begin
        Edit;

        If tpUnidade = tuUnCompra Then
        Begin
          FieldByName('QTDITE').AsFloat     := FieldByName('QTDITE').AsFloat / IIf(FieldByName('EMBALA').AsFloat = 0, 1, FieldByName('EMBALA').AsFloat);
          FieldByName(strNomeCampo).AsFloat := FieldByName(strNomeCampo).AsFloat * IIf(FieldByName('EMBALA').AsFloat = 0, 1, FieldByName('EMBALA').AsFloat);
          FieldByName('SIGUNI').Value	 	  := FieldByName('UNICOM').Value;
        End;

        If FExportarSemPreco Then
        Begin
          FieldByName(strNomeCampo).AsFloat := 0;
          FieldByName('VALTOT' + strIndFor).AsFloat := 0;
        End;

        Post;

        Next;
      End;
    End;

  End;
end;

Function TCotacao.fFornecedorAtivo(intIndFor: Integer): Boolean;
Begin
  Result := (Not SameText(arrCodFor[intIndFor], STR_NAO_UTILIZADO)) And
            (Not SameText(arrCodFor[intIndFor], STR_EXCLUIDO)) And
            (Not fEmptyStr(arrCodFor[intIndFor]));
End;

Function TCotacao.fFornecedorValido(intIndFor: Integer): Boolean;
Begin
  Result := (Not SameText(arrCodFor[intIndFor], STR_EXCLUIDO)) And
            (Not fEmptyStr(arrCodFor[intIndFor]));
End;

procedure TCotacao.pAtualizaArrFornecedores;
Begin
  FillChar(arrCodFor, Sizeof(arrCodFor), #0);

  With cdsFornecedores Do
  Begin
    cdsFornecedores.First;

    While Not Eof Do
    Begin
      pSetaPosicaoArrFor;

      Next;
    End;

  End;
End;

procedure TCotacao.pAtualizaCdsCotacao(AQtdite: Double; ACodIte: String);
var blnContralEdicao: Boolean;
    bkpBefore: TDataSetNotifyEvent;
    bkpAfter: TDataSetNotifyEvent;
    bkpBeforeEdit: TDataSetNotifyEvent;
begin
  If Assigned(frmCadCotacaoGeralCX) Then
    If (frmCadCotacaoGeralCX.pagCotacao.ActivePage = frmCadCotacaoGeralCX.tabItens) Or
      (frmCadCotacaoGeralCX.pagCotacao.ActivePage = frmCadCotacaoGeralCX.tabComparativo) Then
    begin
      blnAtualizaMltLojaDepois := True;
      cdsDigMultLoja.desvinculaEventos(bkpBefore, bkpAfter,bkpBeforeEdit);
      Try
        blnContralEdicao := False;
        If Not (cdsItens.FieldByName('CODITE').AsString = ACodIte) Then
           cdsItens.Locate('CODITE', ACodITe, []);

        If Not (cdsItens.FieldByName('CODITE').AsString = ACodIte) Then
          Exit;
        If Not(cdsItens.State in dsEditModes) Then
        Begin
          blnContralEdicao := True;
          cdsItens.Edit;
        End;
        cdsItens.FieldByName('QTDITE').AsFloat := AQtdite;


        If blnContralEdicao Then
          cdsItens.Post;
      Finally
        cdsDigMultLoja.vinculaEventos(bkpBefore, bkpAfter,bkpBeforeEdit);
        blnAtualizaMltLojaDepois := False;
      End;
    End;
end;

procedure TCotacao.pAtualizaCDSItensMultiLojaFornecedorEscolhido(strCodFor, strCodIte: String;
fltValEsc, fltIpiEsc, fltSubEsc, fltFreEsc: Double);
 var strFilter: String;

begin
  If Assigned(cdsDigMultLoja) Then
  Begin
   cdsDigMultLoja.blnValidarDados := False;

    strFilter := '';
    If cdsItensMultiLojas.Filtered Then
    Begin
      strFilter := cdsItensMultiLojas.Filter;
      cdsItensMultiLojas.Filtered := False;
    End;
    cdsItensMultiLojas.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
    cdsItensMultiLojas.Filtered := True;
    While not cdsItensMultiLojas.EoF Do
    Begin
      cdsItensMultiLojas.Edit;
      cdsItensMultiLojas.FieldByName('ITE_FORESC').AsString := strCodFor;
      cdsItensMultiLojas.FieldByName('ITE_VRTESC').AsFloat  := fltValEsc * cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_IPIESC').AsFloat  := (cdsItensMultiLojas.FieldByName('ITE_VRTESC').AsFloat * fltIpiEsc) /100;
      cdsItensMultiLojas.FieldByName('ITE_ST_ESC').AsFloat  := (cdsItensMultiLojas.FieldByName('ITE_VRTESC').AsFloat * fltSubEsc) /100;
      cdsItensMultiLojas.FieldByName('ITE_FREESC').AsFloat  := (cdsItensMultiLojas.FieldByName('ITE_VRTESC').AsFloat * fltFreEsc) /100;
      cdsItensMultiLojas.Post;
      cdsItensMultiLojas.Next;
    End;
    cdsItensMultiLojas.Filtered := False;
    If strFilter <> '' Then
    Begin
      cdsItensMultiLojas.Filter := strFilter;
      cdsItensMultiLojas.Filtered := True;
    End;

    cdsDigMultLoja.blnValidarDados := True;
  End;
end;


function TCotacao.fAtualizaCDSItensMultiLojaFornecedorEscolhidoGeralPrg(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
end;


procedure TCotacao.pAtualizaCDSItensMultiLojaFornecedorEscolhidoGeral;
var frmGravandoCalcMlt: TfrmGravando;
Begin
  pCriarFormularios(TfrmGravando, frmGravandoCalcMlt);
  Try
    frmGravandoCalcMlt.lblGravando.Caption := 'Aguarde, Calculando produtos Multiloja...';
    frmGravandoCalcMlt.fExecutarAcao := fAtualizaCDSItensMultiLojaFornecedorEscolhidoGeralPrg;
    frmGravandoCalcMlt.ShowModal;
  Finally
    FreeAndNil(frmGravandoCalcMlt);
  End;

End;


Function TCotacao.fZeraPrecosExcluidoPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    cdsItens.BeforePost := nil;

    DisableControls;

    pSetaEventosItem(False, True, True, False);

    prgProgresso.Properties.Max := RecordCount;
    prgProgresso.Position := 0;
    Application.ProcessMessages;

    cdsItens.First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('VALUNI' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('IPIENT' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('ALQCBS' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('ALQIBS' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('ALQ_IS' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('FREENT' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      FieldByName('SUBSTI' + fIndice(FPosicaoExcluido)).AsFloat := 0;
      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    pSetaEventosItem(True, True, True, False);

    pEnableControlsItens;
    cdsItens.BeforePost := pBeforePostItens;

  End;

  Result := True;
End;

procedure TCotacao.OnEscreveValorCampoComparativo(DataSet: TDataSet; AIdentificador: string; var ATexto: string; var AColorBackGround, AColorFont: TColor);
var
    intContador: Integer;
    strColFor: String;
    stlPrecos: TStringList;
    fltPerVar: Double;
    idxFornecedor: Integer;

begin
  If Pos('UNITOT', AIdentificador) > 0 Then
  Begin
    idxFornecedor :=  StrToInt(StringReplace(AIdentificador, 'UNITOT', '', []));
    If DataSet.FieldByName('FORESC').AsString = arrCodFor[idxFornecedor] Then
    Begin
      AColorBackGround := clYellow;
      AColorFont := clBlue;
    End
    Else If DataSet.FieldByName('FORMEN').AsString = arrCodFor[idxFornecedor] Then
    Begin
      AColorBackGround := clGreen;
      AColorFont := clWhite;
    End;

  End
  Else If AIdentificador = 'VAR' Then
  Begin
    stlPrecos := TStringList.Create;
    stlPrecos.Sorted := True;
    For intContador := Low(arrCodFor) To High(arrCodFor) Do
    Begin
      If fFornecedorAtivo(intContador) Then
      Begin
        strColFor := 'UNITOT' + fIndice(intContador);
        If (DataSet.FieldByName(strColFor).AsFloat > 0) Then
        Begin
           stlPrecos.Add(fStrZero(FloatToStrF(DataSet.FieldByName(strColFor).AsFloat, ffFixed, 12, 2), 12));
        End;
      End;

      {*******************************************************}
      {* CALCULA % VARIAC ENTRE OS DOIS MENORES PRECOS       *}
      {****************************************************JC*}
      If stlPrecos.Count > 1 Then
      Begin
        fltPerVar := ( ( ( fStrToFloat(stlPrecos[1]) / fStrToFloat(stlPrecos[0]) ) - 1 ) * 100 );
      End
      Else
        fltPerVar := 0.00;

      ATexto := FloatToStr(fltPerVar);
    End;

    FreeAndNil(stlPrecos);
  End;

end;

Procedure TCotacao.pEnableControlsItens;
Begin
  If Assigned(FfrmGravandoCorrente) Then
  Begin
    FfrmGravandoCorrente.lblGravando.Caption := 'Liberando itens para edição, aguarde...';
    Application.ProcessMessages;
  End;

  cdsItens.EnableControls;
End;

Procedure TCotacao.pFreeAndNilGravando(Var frmGravando: TfrmGravando);
Begin
  pFreeAndNil(frmGravando);
  FfrmGravandoCorrente := Nil;
End;

Procedure TCotacao.pZeraPrecosExcluido(intPosicao: Integer);
Begin
  FPosicaoExcluido := intPosicao;

  pCriarFormularios(TfrmGravando, frmGravando);

  frmGravando.lblGravando.Caption := 'Aguarde, inicializando preços para o fornecedor...';

  frmGravando.fExecutarAcao := fZeraPrecosExcluidoPrg;

  FfrmGravandoCorrente := frmGravando;
  frmGravando.ShowModal;

  pFreeAndNilGravando(frmGravando);
End;

function TCotacao.fCarregaObservacaoFornecedor(strCodFor: String): String;
var
  qryCons: TUniQuery;
begin
  inherited;
  qryCons:= fCriaQuery();
  Try
    If Not(fEmptyStr(strCodFor)) Then
    Begin
      qryCons.SQL.Add('SELECT REPLACE(FOR_OBSERV,"<<csq>>"," ") AS FOR_OBSERV FROM CADFOR WHERE FOR_CODFOR = :CODFOR');
      qryCons.ParamByName('CODFOR').AsString:= strCodFor;
      qryCons.Open;

      Result:= qryCons.FieldByName('FOR_OBSERV').AsString;
    End
  Finally
    FreeAndNil(qryCons);
  End;
end;

Function TCotacao.fIncluiFornecedor(strCodFor, strNomFor: String; strCndPag: String = ''; dtaDtaEnt: TDate = 0): Boolean;
  Var
    intContador,
    intPosicao: Integer;
begin
  With cdsFornecedores Do
  Begin
    Result := True;

    If Locate('COT_CODFOR', strCodFor, []) Then
      Exit;

    If RecordCount >= INT_MAX_FORNECEDOR Then
    Begin
      Result := False;
      pMensagemOk('O número fornecedores na cotação chegou ao limite (' + IntToStr(INT_MAX_FORNECEDOR) + ') !');
      Exit;
    End;

    intPosicao := -1;

    // PEGA O PRIMEIRO LIVRE
    For intContador := Low(arrCodFor) To High(arrCodFor) Do
    If fEmptyStr(arrCodFor[intContador]) Then
    Begin
      intPosicao := intContador;
      Break;
    End;

    // NAO TEM LIVRE ENTAO PROCURA SE TEM EXLUIDO
    If intPosicao = -1 Then
      For intContador := Low(arrCodFor) To High(arrCodFor) Do
      If SameText(arrCodFor[intContador], STR_EXCLUIDO) Then
      Begin
        intPosicao := intContador;

        pZeraPrecosExcluido(intPosicao);

        Break;
      End;

    If intPosicao = -1 Then
      Exit;

    Append;
    FieldByName('COT_CODFOR').AsString := strCodFor;
    FieldByName('FOR_C_G_C_').AsString := fRetFornecedorCGC(strCodFor);
    FieldByName('COT_UTILIZ').AsString := 'S';
    FieldByName('NOMFOR').AsString     := strNomFor;
    FieldByName('POSICAO').AsInteger   := intPosicao;
    FieldByName('OBSERV').AsString := fCarregaObservacaoFornecedor(strCodFor);
    cdsFornecedores.FieldByName('COT_CONPAG').AsString := fRetCondPagFornecedor(strCodFor);
    FieldByName('COT_ANCORA').AsInteger := 0;
    FieldByName('COT_SKYPEC').AsInteger := 0;
    FieldByName('COT_PITSTO').AsInteger := 0;


    If Not fEmptyStr(strCndPag) Then
      FieldByName('COT_CONPAG').AsString := strCndPag;

    If dtaDtaEnt <> 0 Then
      FieldByName('COT_DTAENT').AsDateTime := dtaDtaEnt
    Else If dtaDtaEnt = 0 Then
      FieldByName('COT_DTAENT').AsDateTime := fRetDiaEntFornecedor(strCodFor);

    If Assigned(RedeAncora) Then
    Begin
      FieldByName('COT_ANCORA').AsInteger := IIf(RedeAncora.RetApiProfile.LocateWarehouse(FieldByName('FOR_C_G_C_').AsString ) > -1, 1, 0);
      If FieldByName('COT_ANCORA').AsInteger > 0 Then
        pAjutaTelaApi(cdsFornecedores, idRedeAncora);
    End;

    If Assigned(RedeSkyPecas) Then
    Begin
      FieldByName('COT_SKYPEC').AsInteger := IIf(RedeSkyPecas.ParamSkyPecas.fFornecedorSkyPecas(FieldByname('COT_CODFOR').AsString), 1, 0);
      If FieldByName('COT_SKYPEC').AsInteger > 0 Then
        pAjutaTelaApi(cdsFornecedores, idRedeSkypecas);
    End;

    If Assigned(RedePitStop) Then
    Begin
      FieldByName('COT_PITSTO').AsInteger :=  TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(IIf(RedePitStop.fRetFornecedorDiponivel(cdsFornecedores.FieldByname('FOR_C_G_C_').AsString), spscComApi, spscSemApi));
      If FieldByName('COT_PITSTO').AsInteger > TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscSemApi) Then
        pAjutaTelaApi(cdsFornecedores, idRedePitStop);
    End;
    Post;

    pSetaPosicaoArrFor;

    //INCLUIR COPIA DE SEGURANÇA
      If FEmptyStr(strSeqGerBKP) Then
        fIncluir_CopiaSeguranca
      Else
      Begin
        fIncluiFornecedores_CopiaSeguranca(False, strCodFor, 'S', IIF(fEmptyStr(strCndPag),fRetCondPagFornecedor(strCodFor), strCndPag), FieldByName('COT_DTAENT').AsDateTime);
        fIncluiItensFornec_CopiaSeguranca;
      End;

    If Assigned(frmCadCotacaoGeralCX) Then
      frmCadCotacaoGeralCX.pCarregaComboFonecedores;
  End;
end;

procedure TCotacao.pExcluiFornecedor;
  Var
    intPosicao: Integer;
    lCodFor: String;
Begin

  With cdsFornecedores Do
  Begin
    If IsEmpty Then
      Exit;

    If (fMensagem('', 'Confirma a exclusão do Fornecedor ' + FieldbyName('COT_CODFOR').AsString +
                 '-' + FieldbyName('NOMFOR').AsString + '?', ['&Sim', '&Não']) = 1) Then
    Begin
      intPosicao := FieldByName('POSICAO').AsInteger;
      lCodFor := cdsFornecedores.FieldbyName('COT_CODFOR').AsString;
      pExcluiFornecedor_CopiaSeguranca(cdsFornecedores.FieldbyName('COT_CODFOR').AsString);

      Delete;
      arrCodFor[intPosicao] := STR_EXCLUIDO;
      pRemoveListaFornecApi(lCodFor);


      If Assigned(frmCadCotacaoGeralCX) Then
        frmCadCotacaoGeralCX.pCarregaComboFonecedores;
    End;
  End;

  fAtualizaMenorFornecedor;
End;

procedure TCotacao.pExcluiFornecedor_CopiaSeguranca(strCodFor: String);
var
  qryExclui: TUniQuery;
begin
  try
    qryExclui := fCriaQuery;
    qryExclui.SQL.Add('DELETE FROM COTCFO_RES WHERE COT_SEQGER = '+QuotedStr(strSeqGerBKP)+ ' AND COT_CODFOR = '+QuotedStr(strCodFor)+'; ');
    qryExclui.SQL.Add('DELETE FROM COTFOR_RES WHERE COT_SEQGER = '+QuotedStr(strSeqGerBKP)+ ' AND COT_CODFOR = '+QuotedStr(strCodFor)+'; ');
    qryExclui.ExecSQL;

    FreeAndNil(qryExclui);

    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pExcluiFornecedor_CopiaSeguranca]');
    End;
  End;
end;

procedure TCotacao.pUtilizaFornecedor(strCodFor: String; blnUtiliza: Boolean);
begin
  With cdsFornecedores Do
  If Locate('COT_CODFOR', strCodFor, []) Then
  Begin
    Edit;
    FieldByName('COT_UTILIZ').AsString := IIF(blnUtiliza, 'S', 'N');
    Post;

    pSetaPosicaoArrFor;

    fAtualizaMenorFornecedor;
  End;

  pAtualizaFornecedor_CopiaSeguranca(strCodFor, blnUtiliza);

end;

Function TCotacao.fCarregaCotacaoPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  Result := False;

  If (opeOperac = opAlterar) Then
    frmGravando.lblGravando.Caption := 'Carregando fornecedores, aguarde...'
  Else
    frmGravando.lblGravando.Caption := 'Preparando dados, aguarde...';

  Application.ProcessMessages;

  If Not fAbreFornecedores(cdsFornecedores) Then
    Exit;

  If (opeOperac = opAlterar) Then
    frmGravando.lblGravando.Caption := 'Carregando itens, aguarde...'
  Else
    frmGravando.lblGravando.Caption := 'Preparando dados, aguarde...';

  Application.ProcessMessages;

  If Not fAbreItens(True) Then
    Exit
  Else
  Begin
    If (Not cdsItens.IsEmpty) Then
    Begin
      cdsItens.AfterSCroll := nil;
      Try
        cdsItens.First;
        prgProgresso.Properties.Max := cdsItens.RecordCount;
        While Not (cdsItens.Eof) Do
        Begin
          stlItens.Add(QuotedStr(cdsItens.FieldByName('CODITE').AsString));
          prgProgresso.Position := cdsItens.RecNo;
          If (cdsItens.RecNo mod 100) = 0 then
            Application.ProcessMessages;
          cdsItens.Next;
        End;
      Finally
        cdsItens.AfterSCroll := pAfterScrollItensGiro;
      End;
    End;
  End;

  Result := True;
End;

Function TCotacao.fCarregaCotacao: Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);

  With frmGravando Do
  Begin
    fExecutarAcao := fCarregaCotacaoPrg;

    FfrmGravandoCorrente := frmGravando;
    ShowModal;
    Result := blnConfirma;
  End;

  pFreeAndNilGravando(frmGravando);
End;

Procedure TCotacao.pBeforePostItens(dataSet: TDataSet);
  Var
    intContador: Integer;
    fltMenor,
    fltFreMenor,
    fltEscolhido: Double;
    strIndice,
    strCodForMenor: String;
    blnPrecoVenda: Boolean;
    blnSomaReforma: Boolean;
    recValores: TValoresReforma;
    bkpAfterSrollFornec : TDataSetNotifyEvent;
Begin
  blnSomaReforma := fSomarNovosImpostosDaReformaAoValorContabil;
  //If Not blnExecutarBeforePostItem Then
  //  Exit;

  bkpAfterSrollFornec := cdsFornecedores.AfterScroll;
  cdsFornecedores.AfterScroll := nil;
  Try
    With dataSet Do
    Begin
      fltMenor     := -1;
      fltEscolhido := -1;
      fltFreMenor  := -1;

      FieldByName('PREESC').Clear;

      strCodForMenor := '';

      For intContador := 1 To INT_MAX_FORNECEDOR Do
        If fFornecedorValido(intContador) Then
        Begin
          // RECALCULA PREÇO TOTAL
          strIndice := fIndice(intContador);
          dataSet.FieldByName('UNITOT' + fIndice(intContador)).AsFloat := fCalculaPrecoImp(dataSet.FieldByName('VALUNI' + strIndice).AsFloat,
                                                                                           dataSet.FieldByName('IPIENT' + strIndice).AsFloat,
                                                                                           dataSet.FieldByName('SUBSTI' + strIndice).AsFloat,
                                                                                           dataSet.FieldByName('FREENT' + strIndice).AsFloat);


    (*
          dataSet.FieldByName('UNITOT' + fIndice(intContador)).AsFloat :=
            dataSet.FieldByName('VALUNI'+ fIndice(intContador)).AsFloat *
                (1 + ((dataSet.FieldByName('IPIENT' + fIndice(intContador)).AsFloat +
                       dataSet.FieldByName('SUBSTI' + fIndice(intContador)).AsFloat +
                       dataSet.FieldByName('FREENT' + fIndice(intContador)).AsFloat) / 100));

      *)

            dataSet.FieldByName('VALTOT' + fIndice(intContador)).AsFloat :=
              FieldByName('UNITOT' + fIndice(intContador)).AsFloat * FieldByName('QTDITE').AsFloat;

            recValores := fCalculaReformaImp(FieldByName('VALUNI' + strIndice).AsFloat,
                                             FieldByName('IPIENT' + strIndice).AsFloat,
                                             FieldByName('SUBSTI' + strIndice).AsFloat,
                                             FieldByName('FREENT' + strIndice).AsFloat,
                                             TAliquotasReforma.fCriar(FieldByName('ALQCBS' + strIndice).AsFloat,
                                                                      FieldByName('ALQIBS' + strIndice).AsFloat,
                                                                      FieldByName('ALQ_IS' + strIndice).AsFloat));

            FieldByName('TOTCBS' + strIndice).AsFloat := FieldByName('QTDITE').AsFloat * recValores.fltCbs;
            FieldByName('TOTIBS' + strIndice).AsFloat := FieldByName('QTDITE').AsFloat * recValores.fltIbs;
            FieldByName('TOT_IS' + strIndice).AsFloat := FieldByName('QTDITE').AsFloat * recValores.fltIs;

            // CBS/IBS/IS somam no valor total, nao no unitario com impostos (UNITOT)
            If blnSomaReforma Then
              FieldByName('VALTOT' + strIndice).AsFloat := FieldByName('VALTOT' + strIndice).AsFloat +
                                                           FieldByName('QTDITE').AsFloat * recValores.fTotal;

            If fFornecedorAtivo(intContador) Then
            Begin
              // SELECIONA O MENOR PREÇO
              If (FieldByName('VALUNI' + fIndice(intContador)).AsFloat > 0) And
                 ((fltMenor = -1) Or
                  (FieldByName('UNITOT' + fIndice(intContador)).AsFloat < fltMenor)) Then
            Begin
              fltMenor       := FieldByName('UNITOT' + fIndice(intContador)).AsFloat;
              strCodForMenor := arrCodFor[intContador];
              fltFreMenor :=  (FieldByName('QTDITE').AsFloat * fCalculaFreteImp(FieldByName('VALUNI' + strIndice).AsFloat,
                                                                                FieldByName('IPIENT' + strIndice).AsFloat,
                                                                                FieldByName('SUBSTI' + strIndice).AsFloat,
                                                                                FieldByName('FREENT' + strIndice).AsFloat));
            End;

            // PROCURA O ESCOLHIDO
              If FManterEscolhido And (FieldByName('FORESC').AsString = arrCodFor[intContador]) Then
              Begin
                fltEscolhido := FieldByName('UNITOT' + fIndice(intContador)).AsFloat;

              FieldByName('PREESC').AsFloat := DataSet.FieldByName('VALUNI'+ fIndice(intContador)).AsFloat;

              FieldByName('FREESC').AsFloat :=
                FieldByName('QTDITE').AsFloat
                  * fCalculaFreteImp(FieldByName('VALUNI' + strIndice).AsFloat,
                                     FieldByName('IPIENT' + strIndice).AsFloat,
                                     FieldByName('SUBSTI' + strIndice).AsFloat,
                                     FieldByName('FREENT' + strIndice).AsFloat);

            End;

          End;

          End;

        // SETA O FOENECEDOR DE MENOR PREÇO
      FieldByName('FORMEN').AsString := strCodForMenor;

      If (FieldByName('PREESC').IsNull) Or // NÃO ACHOU NENHUM ESCOLHIDO ENTRE OS ATIVOS, ENTAO SETA O ESCOLHIDO COMO O MENOR
         (fEmptyStr(FieldByName('AUTCOT').AsString) And (FieldByName('SELMAN').AsString <> 'S')) Then // ESTA INCLUINDO UM NOVO ITEM E NÃO MARCOU MANUALMENTE ESSE ITEM
      Begin

        FieldByName('PREESC').AsFloat  := fltMenor;
        FieldByName('FORESC').AsString := strCodForMenor;
        FieldByName('FREESC').AsFloat := fltFreMenor;

      End Else
      Begin

        // SE O ESCOLHIDO TEM O MENOR PREÇO, SETA O MENOR PREÇO COMO O ESCOLHIDO PORQUE PODE HAVER PREÇOS IGUAIS
        If (RoundTo(fltMenor, -4) = RoundTo(fltEscolhido, -4)) Or (fltEscolhido = -1) Then
          FieldByName('FORMEN').AsString := FieldByName('FORESC').AsString;

      End;

      For intContador := 1 To INT_MAX_FORNECEDOR Do
        If fFornecedorValido(intContador) Then
        Begin

          If FieldByName('FORESC').AsString = arrCodFor[intContador] Then
          Begin
            FieldByName('TOTESC' + fIndice(intContador)).AsFloat := FieldByName('VALTOT' + fIndice(intContador)).AsFloat;

            If FieldByName('MARPED').AsString = 'S' Then
              FieldByName('TOTESCF2' + fIndice(intContador)).AsFloat := FieldByName('TOTESC' + fIndice(intContador)).AsFloat
            Else
              FieldByName('TOTESCF2' + fIndice(intContador)).AsFloat := 0;

          End Else
          Begin
            FieldByName('TOTESC'   + fIndice(intContador)).AsFloat := 0;
            FieldByName('TOTESCF2' + fIndice(intContador)).AsFloat := 0;
          End;

        End;

      pBeforePostItensAtualizaoPreco(dataSet);

      Case tpcTipoCalculoExterno Of
        tpcPrecoVenda : blnPrecoVenda := True;
        tpcMargem     : blnPrecoVenda := False;
        Else            blnPrecoVenda := SameText(STR_TIPALT_PRECO, FieldByName('TIPALT').AsString)
      End;

      pRecalculaPreco(blnPrecoVenda, True);

      If fAlterouItem(dataSet) Then
      Begin
        FieldByName('ALTERADO').AsString := 'S';
      End;

     {Atualiza CDS MultLoja}
      If Not blnAtualizaMltLojaDepois Then
      Begin
        If (blnMulLoj) And (CdsFornecedores.FieldByName('POSICAO').AsInteger > 0) Then
          pAtualizaCDSItensMultiLojaFornecedorEscolhido(
           FieldByName('FORESC').AsString,
           FieldByName('CODITE').AsString,
           FieldByName('PREESC').AsFloat,
           FieldByName('IPIENT' + fIndice(CdsFornecedores.FieldByName('POSICAO').AsInteger)).AsFloat,
           FieldByName('SUBSTI' + fIndice(CdsFornecedores.FieldByName('POSICAO').AsInteger)).AsFloat,
           FieldByName('FREENT' + fIndice(CdsFornecedores.FieldByName('POSICAO').AsInteger)).AsFloat);
      End;

    End;

    If FEmptyStr(strSeqGerBKP) Then
    Begin
      fIncluir_CopiaSeguranca;
      If dataset.State = dsEdit Then
      Begin
        fIncluiCotacaoItens_CopiaSeguranca(True);
        fIncluiItensFornec_CopiaSeguranca();
        If blnMulLoj Then
         fIncluiItensMultilojas_CopiaSeguranca(True);
      End;
    End
    Else
    Begin
      fIncluiCotacaoItens_CopiaSeguranca(True);
      fIncluiItensFornec_CopiaSeguranca();
      If blnMulLoj Then
       fIncluiItensMultilojas_CopiaSeguranca(True);
    End;
  Finally
    cdsFornecedores.AfterScroll := bkpAfterSrollFornec;
  End;

End;

Function TCotacao.fAlterouItem(dataSet: TDataSet): Boolean;
  Var
    intIndice: Integer;
Begin
  With DataSet Do
  Begin
    Result := (State = dsInsert) Or
              (FieldByName('QTDITE').Value <> FieldByName('QTDITE').OldValue) Or
              (FieldByName('DESITE').Value <> FieldByName('DESITE').OldValue) Or
              (FieldByName('PJAATU').Value <> FieldByName('PJAATU').OldValue) Or
              (FieldByName('FORESC').Value <> FieldByName('FORESC').OldValue) Or
              (FieldByName('GERPED').Value <> FieldByName('GERPED').OldValue) Or
              (FieldByName('FORMEN').Value <> FieldByName('FORMEN').OldValue);

    If Not Result Then
    Begin
      For intIndice := 1 To INT_MAX_FORNECEDOR Do
        If (FieldByName('VALUNI' + fIndice(intIndice)).Value <> FieldByName('VALUNI' + fIndice(intIndice)).OldValue) Or
           (FieldByName('SUBSTI' + fIndice(intIndice)).Value <> FieldByName('SUBSTI' + fIndice(intIndice)).OldValue) Or
           (FieldByName('FREENT' + fIndice(intIndice)).Value <> FieldByName('FREENT' + fIndice(intIndice)).OldValue) Or
           (FieldByName('IPIENT' + fIndice(intIndice)).Value <> FieldByName('IPIENT' + fIndice(intIndice)).OldValue) Or
           (FieldByName('ALQCBS' + fIndice(intIndice)).Value <> FieldByName('ALQCBS' + fIndice(intIndice)).OldValue) Or
           (FieldByName('ALQIBS' + fIndice(intIndice)).Value <> FieldByName('ALQIBS' + fIndice(intIndice)).OldValue) Or
           (FieldByName('ALQ_IS' + fIndice(intIndice)).Value <> FieldByName('ALQ_IS' + fIndice(intIndice)).OldValue) Then
        Begin
          Result := True;
          Break;
        End;

    End;
  End;
End;

Procedure TCotacao.pBeforePostItensAtualizaoPreco(dataSet: TDataSet);
  Var
    intIndex: Integer;
Begin
  With DataSet Do
  Begin
    If FieldByName('PRECOM').AsFloat <> 0 Then
      FieldByName('DIFCOM').AsFloat := ((FieldByName('PREESC').AsFloat - FieldByName('PRECOM').AsFloat) / FieldByName('PRECOM').AsFloat) * 100;

    If (FieldByName('ATUPRE').AsString = 'S') And
       (FieldByName('PREESC').AsFloat <= 0) Then
      FieldByName('ATUPRE').AsString := 'N';

  //---------------------------------------

    DataSet.FieldByName('NOVCUS').AsFloat := fCalculaPrecoCusto;

    If FieldByName('PRECUS').AsFloat > 0 then
      FieldByName('DIFCUS').AsFloat := ((FieldByName('NOVCUS').AsFloat - FieldByName('PRECUS').AsFloat) / FieldByName('PRECUS').AsFloat) * 100
    Else
      FieldByName('DIFCUS').Clear;

  //---------------------------------------

    intIndex := fCodForToIndex(FieldByName('FORESC').AsString);

    If (intIndex > -1) And fFornecedorValido(intIndex) Then
     DataSet.FieldByName('PREIMP_NOV').AsFloat := fCalculaPrecoImp(DataSet.FieldByName('VALUNI' + fIndice(intIndex)).AsFloat,
                                                                   DataSet.FieldByName('IPIENT' + fIndice(intIndex)).AsFloat,
                                                                   DataSet.FieldByName('SUBSTI' + fIndice(intIndex)).AsFloat,
                                                                   DataSet.FieldByName('FREENT' + fIndice(intIndex)).AsFloat);

    If FieldByName('PREIMP').AsFloat > 0 then
      FieldByName('DIFPREIMP').AsFloat := ((DataSet.FieldByName('PREIMP_NOV').AsFloat - DataSet.FieldByName('PREIMP').AsFloat) /  DataSet.FieldByName('PREIMP').AsFloat) * 100
    Else
      FieldByName('DIFPREIMP').Clear;

  //--------------------------------------

    FieldByName('NOVREA').AsFloat := fCalculaCustoReal(FieldByName('NOVCUS').AsFloat,
                                                       FieldByName('ICMSAI').AsFloat,
                                                       FieldByName('IMPFED').AsFloat,
                                                       FieldByName('DESOPE').AsFloat,
                                                       FieldByName('OUTVAL').AsFloat);

    If FieldByName('CUSREA').AsFloat > 0 then
      FieldByName('DIFREA').AsFloat := ((FieldByName('NOVREA').AsFloat - FieldByName('CUSREA').AsFloat) / FieldByName('CUSREA').AsFloat) * 100
    Else
      FieldByName('DIFREA').Clear;

  //--------------------------------------

    intIndex := fCodForToIndex(FieldByName('FORESC').AsString);
    If (intIndex > -1) And fFornecedorValido(intIndex) Then
    Begin
      FieldByName('VLRUNT').AsFloat := FieldByName('VALUNI' + fIndice(intIndex)).AsFloat;
      FieldByName('DIFCOL').AsFloat := ( (FieldByName('VLRUNT').AsFloat - RoundTo(FieldByName('COMLIQ').AsFloat, - 2)) / RoundTo(FieldByName('COMLIQ').AsFloat, - 2)) * 100;
    End;

  End;
End;

Procedure TCotacao.pRecalculaPrecoTabela(intIndice: Integer; blnPreVen, blnMantemPrecoVendaOuMargemDigitada: Boolean);
Begin
  With cdsItens Do
  If FieldByName('PREESC').AsFloat > 0 then
  Begin

    If blnPreVen Then
    Begin
      If( Not blnMantemPrecoVendaOuMargemDigitada) Or (FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat = 0) Then
        FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat := FieldByName('MARBR' + IntToStr(intIndice)).AsFloat;

      FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat :=
                                  fCalculaPrecoVenda(1,
                                     FieldByName('NOVCUS').AsFloat + FieldByName('OUTVAL').AsFloat,
                                     0,
                                     FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat,
                                     FieldByName('ICMSAI').AsFloat,
                                     FieldByName('IMPFED').AsFloat,
                                     FieldByName('DESOPE').AsFloat,
                                     FieldByName('COMTB' + IntToStr(intIndice)).AsFloat,
                                     strMarMkp,
                                     strPcmPro,
                                     intDecUni);

      FieldByName('NOVCA' + IntToStr(intIndice)).AsFloat := FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat;

    End Else
    Begin
      If (Not blnMantemPrecoVendaOuMargemDigitada) Or (FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat = 0) Then
      Begin
        FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat := FieldByName('PREVE' + IntToStr(intIndice)).AsFloat;
        FieldByName('NOVCA' + IntToStr(intIndice)).AsFloat := FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat;
      End;

      FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat :=
                                    fCalculaPrecoVenda(2,
                                       FieldByName('NOVCUS').AsFloat + FieldByName('OUTVAL').AsFloat,
                                       FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat,
                                       0,
                                       FieldByName('ICMSAI').AsFloat,
                                       FieldByName('IMPFED').AsFloat,
                                       FieldByName('DESOPE').AsFloat,
                                       FieldByName('COMTB' + IntToStr(intIndice)).AsFloat,
                                       strMarMkp,
                                       strPcmPro,
                                       intDecUni);

    End;

    If FieldByName('PREVE' + IntToStr(intIndice)).AsFloat > 0 Then
      FieldByName('DIFER' + IntToStr(intIndice)).AsFloat := ((FieldByName('NOVVE' + IntToStr(intIndice)).AsFloat -
                                                                   FieldByName('PREVE' + IntToStr(intIndice)).AsFloat) /
                                                                   FieldByName('PREVE' + IntToStr(intIndice)).AsFloat) * 100
    Else
      FieldByName('DIFER' + IntToStr(intIndice)).Clear;

    FieldByName('DIFBR' + IntToStr(intIndice)).AsFloat := (FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat -
                                                           FieldByName('MARBR' + IntToStr(intIndice)).AsFloat);

    FieldByName('DIGBR' + IntToStr(intIndice)).AsFloat := FieldByName('NOVBR' + IntToStr(intIndice)).AsFloat;
  End;
End;

Function TCotacao.fReplicaDadosPrg(pgbProgresso: TcxProgressBar): Boolean;
var fltValorReplicado : Double;
begin
  fltValorReplicado := cdsItens.fieldbyName(strField).Value;
  pgbProgresso.Properties.Max := cdsItens.RecordCount;

  cdsItens.First;
  while not cdsitens.Eof do
  Begin
    Try
      If Pos('SUBST', strField) > 0 Then
      Begin
        If Not (fCampoTabela('ITE_SUBSTI', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [cdsItens.FieldByName('CODITE').AsString, VS_strCodEmp], False) > 0) Then
        Begin
         Continue;
        End;
      End;

      If (cdsItens.fieldbyName(strField).AsFloat = 0) Or blnSubstTodos Then
      Begin
        cdsItens.Edit;
        cdsItens.fieldbyName(strField).Value := fltValorReplicado;
        cdsItens.Post;
      End;
    Finally
      cdsItens.Next;
      pgbProgresso.Position := cdsItens.RecNo;
      Application.ProcessMessages;
    End;
  End;
  Result := True;
End;


procedure TCotacao.pReplicaDados(AstrField: String; AblnSubstTodos: Boolean);
  Var
    frmGravando2: TfrmGravando;
Begin
  strField := AstrField;
  blnSubstTodos := AblnSubstTodos;

  Try
    pCriarFormularios(TfrmGravando, frmGravando2);
    frmGravando2.lblGravando.Caption := 'Replicando Valor';
    frmGravando2.fExecutarAcao := fReplicaDadosPrg;

    FfrmGravandoCorrente := frmGravando2;

    frmGravando2.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCotacao.pReplicaDados]');
    End;
  End;

  pFreeAndNilGravando(frmGravando2);
End;

Procedure TCotacao.pRecalculaPreco(blnPreVen, blnMantemPrecoVendaOuMargemDigitada: Boolean);
  Var
    intIndice: Integer;
Begin
  For intIndice := 1 to Length(VS_strTabPrc) do
    pRecalculaPrecoTabela(intIndice, blnPreVen, blnMantemPrecoVendaOuMargemDigitada);
End;

function TCotacao.fCalculaFreteImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double): Double;
var ValorIPI,
    ValorST,
    ValorFrete: Double;
begin
  ValorFrete := 0;

  case cfgfrmCus of
   1: Begin
        ValorIPI := (APrecoLiquido * AAliquotaIpi) / 100;
        ValorST  := ((APrecoLiquido + ValorIPI) * AAliquotaST) / 100;
        ValorFrete := (((APrecoLiquido + ValorIPI + ValorST ) * AAliquotaFrete) / 100);
      End;
   2,4: Begin
         ValorIPI :=   ((APrecoLiquido * AAliquotaIpi) /100);
         ValorST  :=   ((APrecoLiquido * AAliquotaST) /100);
         ValorFrete := ((APrecoLiquido  + ValorST +  ValorIPI) * AAliquotaFrete) / 100;
        End;
   3: ValorFrete := ((APrecoLiquido * AAliquotaFrete) /100);
  End;
  Result :=  ValorFrete;
end;

function TCotacao.fCalculaFreteInformado: Double;
var strFilter: String;
    blnFiltered: Boolean;

begin
  pTiraAfterScrollItens;
  cdsItens.DisableControls;
  blnFiltered := cdsItens.Filtered;
  strFilter   := cdsItens.Filter;
  try
    Result := 0.00;
    If blnFiltered Then
      cdsItens.Filtered := False;

    cdsItens.Filter := cdsItens.Filter + IIf(cdsItens.Filter <> '' , ' AND ', '') + 'FREESC > 0';
    cdsItens.Filtered := True;

    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If cdsItens.FieldByName('FREESC').AsFloat > 0 Then
        Result := result + cdsItens.FieldByName('FREESC').AsFloat;
      cdsItens.Next;
    End;
  Finally
    If blnFiltered Then
      cdsItens.Filtered := False;

    cdsItens.Filter := strFilter;
    cdsItens.Filtered := blnFiltered;

    pSetaAfterScrollItensGiro;
    cdsItens.EnableControls;
  End;
end;

function TCotacao.fCalculaPrecoCusto: Double;
  Var
    intIndex: Integer;
begin
  With cpcParams, cdsItens Do
  Begin
    intIndex := fCodForToIndex(FieldByName('FORESC').AsString);

    If Assigned(FindField('VALUNI' + fIndice(intIndex))) Then
    Begin
      curPreCom := cdsItens.FieldByName('VALUNI' + fIndice(intIndex)).AsFloat;
      curDesF01 := cdsItens.FieldByName('DESF01').AsFloat;
      curDesF02 := cdsItens.FieldByName('DESF02').AsFloat;
      curDesF03 := cdsItens.FieldByName('DESF03').AsFloat;
      curDesF04 := cdsItens.FieldByName('DESF04').AsFloat;
      curDesF05 := cdsItens.FieldByName('DESF05').AsFloat;
      curDesF06 := cdsItens.FieldByName('DESF06').AsFloat;
      curICMSEnt:= cdsItens.FieldByName('ICMENT').AsFloat;

      If SameText(Self.FieldbyName('COT_NOVIPI').AsString, 'S') Then
      begin
        curIPIEnt := cdsItens.FieldByName('IPIENT' + fIndice(intIndex)).AsFloat;
        curSubsti := cdsItens.FieldByName('SUBSTI' + fIndice(intIndex)).AsFloat;
        curFrete  := cdsItens.FieldByName('FREENT' + fIndice(intIndex)).AsFloat;
      End Else
      Begin
        curIPIEnt := FieldByName('IPIENT').AsFloat;
        curSubsti := FieldByName('SUBSTI').AsFloat;
        curFrete  := FieldByName('FREENT').AsFloat;
      End;

      curAcrFin := FieldByName('ACRFIN').AsFloat;
      cpcParams.curValFre := FieldByName('VALFRE').AsFloat;
      curDesAdb := FieldByName('DESADB').AsFloat;
      curSubFed := FieldByName('SUBFED').AsFloat;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('TCIFCU').AsFloat;
        curTSCust := FieldByName('TSCUST').AsFloat;
        curDePiCo := FieldByName('DEPICO').AsFloat;
        curDeICMS := FieldByName('DEICMS').AsFloat;
        curFatReg := FieldByName('FATREG').AsFloat;
      end
      else
      begin
        curTCIFCu := 0;
        curTSCust := 0;
        curDePiCo := 0;
        curDeICMS := 0;
        curFatReg := 0;
      end;

      Result := fCalculaPrecoCusto;
    End Else
    Begin
      Result := 0;
    End;

  End;

End;

function TCotacao.fCalculaPrecoImp(APrecoLiquido, AAliquotaIpi, AAliquotaST,
  AAliquotaFrete: Double): Double;
var ValorIPI,
    ValorST,
    ValorFrete: Double;
begin
  ValorIPI := 0;
  ValorST := 0;
  ValorFrete := 0;

  case cfgfrmCus of
   1: Begin
        ValorIPI := (APrecoLiquido * AAliquotaIpi) / 100;
        ValorST  := ((APrecoLiquido + ValorIPI) * AAliquotaST) / 100;
        ValorFrete := (((APrecoLiquido + ValorIPI + ValorST ) * AAliquotaFrete) / 100);
      End;
   2,4: Begin
         ValorIPI :=   ((APrecoLiquido * AAliquotaIpi) /100);
         ValorST  :=   ((APrecoLiquido * AAliquotaST) /100);
         ValorFrete := ((APrecoLiquido  + ValorST +  ValorIPI) * AAliquotaFrete) / 100;
        End;
   3: Begin
        ValorIPI := ((APrecoLiquido * AAliquotaIpi) /100);
        ValorFrete := ((APrecoLiquido * AAliquotaFrete) /100);
        ValorST := ((APrecoLiquido  + ValorFrete +  ValorIPI) * AAliquotaST) / 100;
      End;
  End;
  Result := RoundTo(APrecoLiquido + ValorIPI + ValorFrete + ValorST, intDecUni * -1);
end;

function TCotacao.fCalculaReformaImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete: Double;
                                     const AAliquotasReforma: TAliquotasReforma): TValoresReforma;
begin
  Result := TCalculoReformaCompra.fCalcular(TBaseReforma.fCriar(APrecoLiquido,
                                                                fCalculaFreteImp(APrecoLiquido, AAliquotaIpi, AAliquotaST, AAliquotaFrete),
                                                                0),
                                            AAliquotasReforma, False);
end;

Procedure TCotacao.pRecalculaPrecosInical;
Begin
  If FRecalculouPrecos Then
    Exit;

  If Self.State = dsInsert Then
    Exit;

  fRecalculaPrecosInical;
End;

Function TCotacao.fRecalculaPrecosInical: Boolean;
Begin
  Try
    pSetaEventosItem(False);

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde, recalculando preços...';
    frmGravando.fExecutarAcao := fRecalculaPrecosInicialPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      Result := False;
      pMensagensErro(E.Message, '[fRecalculaPrecosInical]');
    End;
  End;

  pFreeAndNilGravando(frmGravando);

  FRecalculouPrecos := Result;

  pSetaEventosItem(True);
End;

Function TCotacao.fRecalculaPrecosInicialPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    DisableControls;

    prgProgresso.Properties.Max := RecordCount;
    prgProgresso.Position := 0;
    Application.ProcessMessages;

    cdsItens.First;
    While Not Eof Do
    Begin
      Edit;

      pBeforePostItensAtualizaoPreco(cdsItens);
      pRecalculaPreco(SameText(STR_TIPALT_PRECO, cdsItens.FieldByName('TIPALT').AsString), False);

      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    pEnableControlsItens;
  End;

  Result := True;
End;

Function TCotacao.fRecalculaPrecos(blnRecalcularPreco: Boolean): Boolean;
Begin
  Try
    FRecalcularPreco := blnRecalcularPreco;

    // VOLTA PREÇO OU MARGEM DO CADASTRO
    FMantemPrecoVendaOuMargemDigitada := False;

    pSetaEventosItem(False);

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde, recalculando preços...';
    frmGravando.fExecutarAcao := fRecalculaPrecosPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      Result := False;
      pMensagensErro(E.Message, '[fRecalculaPrecos]');
    End;
  End;

  pFreeAndNilGravando(frmGravando);

  FRecalculouPrecos := Result;

  pSetaEventosItem(True);
End;

Function TCotacao.fRecalculaPrecosPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    DisableControls;

    prgProgresso.Properties.Max := RecordCount;
    prgProgresso.Position := 0;
    Application.ProcessMessages;

    cdsItens.First;
    While Not Eof Do
    Begin
      Edit;

      pBeforePostItensAtualizaoPreco(cdsItens);
      pRecalculaPreco(FRecalcularPreco, False);

      Post;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    pEnableControlsItens;
  End;

  Result := True;
End;

Procedure TCotacao.pMarcaEscolhido(strNomCam: String);
  Var
    intIndex: Integer;
Begin
  With cdsItens Do
  Begin

    intIndex := StrToIntDef(RightStr(strNomCam, 2), 0);

    If (intIndex > 0) And (intIndex <= INT_MAX_FORNECEDOR) Then
    Begin
      Edit;

      If FieldByName('FORESC').AsString = arrCodFor[intIndex] Then  // DESMARCA E MARCA O MENOR
      Begin
        FieldByName('FORESC').AsString := FieldByName('FORMEN').AsString;
        FieldByName('SELMAN').AsString := 'N';
      End Else If (FieldByName('VALUNI' + fIndice(intIndex)).AsFloat > 0) Then
      Begin
        FieldByName('FORESC').AsString := arrCodFor[intIndex];
        FieldByName('SELMAN').AsString := 'S';
      End;

      Post;
    End;

  End;
End;

Function TCotacao.fAlteraValorUnitario(strNomCam: String): Boolean;
  Var
    intIndex: Integer;
    frmAlteraValorUnitario : TfrmAlteraValorUnitario;
Begin
  pTiraAfterScrollItens;

  With cdsItens Do
  Begin
    Result := False;

    intIndex := StrToIntDef(RightStr(strNomCam, 2), 0);

    If (intIndex > 0) And (intIndex <= INT_MAX_FORNECEDOR) Then
    Begin

      Try
        pCriarFormularios(TfrmAlteraValorUnitario, frmAlteraValorUnitario);
        frmAlteraValorUnitario.FCalculaPrecoImp   := fCalculaPrecoImp;
        frmAlteraValorUnitario.FCalculaReformaImp := fCalculaReformaImp;

        frmAlteraValorUnitario.lblFornecedor.Caption := 'Fornecedor: ' + arrCodFor[intIndex] + '-' + fRetNomFornecedor(arrCodFor[intIndex]);

        frmAlteraValorUnitario.dbeValUni.DataField := 'VALUNI' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeIpiEnt.DataField := 'IPIENT' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeSubsti.DataField := 'SUBSTI' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeFreEnt.DataField := 'FREENT' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeValTot.DataField := 'VALTOT' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeUniTot.DataField := 'UNITOT' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeAlqCbs.DataField := 'ALQCBS' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeAlqIbs.DataField := 'ALQIBS' + fIndice(intIndex);
        frmAlteraValorUnitario.dbeAlq_Is.DataField := 'ALQ_IS' + fIndice(intIndex);

        frmAlteraValorUnitario.FblnSomaReforma    := fSomarNovosImpostosDaReformaAoValorContabil;
        frmAlteraValorUnitario.pnlReforma.Visible := frmAlteraValorUnitario.FblnSomaReforma;
        If Not frmAlteraValorUnitario.pnlReforma.Visible Then
          frmAlteraValorUnitario.Height := frmAlteraValorUnitario.Height - frmAlteraValorUnitario.pnlReforma.Height;


        frmAlteraValorUnitario.dtsItens.DataSet := cdsItens;

        Edit;

        Result := frmAlteraValorUnitario.ShowModal = mrOk;

        If Result Then
          Post
        Else
          Cancel;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TCotacao.fAlteraValorUnitario]');
          Result := False;
        End;
      End;

      pFreeAndNil(frmAlteraValorUnitario);
    End;

  End;

  pSetaAfterScrollItensGiro;
End;

function TCotacao.fSalvaCotacao: Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);

  Case opeOperac Of
    opIncluir: frmGravando.lblGravando.Caption := 'Aguarde, incluindo cotação...';
    opAlterar: frmGravando.lblGravando.Caption := 'Aguarde, alterando cotação...';
    opExcluir: frmGravando.lblGravando.Caption := 'Aguarde, excluindo cotação...';
  End;

  frmGravando.fExecutarAcao := fSalvaCotacaoPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  If Assigned(cdsDigMultLoja) And Assigned(cdsDigMultLoja.objPreparaGerMultiLoja) And cdsDigMultLoja.objPreparaGerMultiLoja.fPossuiDigitados Then
  Begin

    If fPergunta('Há preparações de TE digitadas, deseja salvá-las?') Then
    Begin
      If cdsDigMultLoja.objPreparaGerMultiLoja.fSalvaDigitados(True) Then
      Begin
        cdsDigMultLoja.objPreparaGerMultiLoja.cdsIteLib.EmptyDataSet;
        pMensagemOk('Preparação de Transferência de Estoque gerada com sucesso!');
      End;
    End
    Else cdsDigMultLoja.objPreparaGerMultiLoja.cdsIteLib.EmptyDataSet;
  End;

  Result := frmGravando.blnConfirma;

  blnSalvouCotacao := True;

  pFreeAndNilGravando(frmGravando);
End;

procedure TCotacao.pMensagemGravacao(strMensagem: String);
begin
  frmGravando.lblGravando.Caption := strMensagem;
  Application.ProcessMessages;
end;

Function TCotacao.fGravaFornecedores: Boolean;
 Begin
  With cdsFornecedores Do
  Begin
    DisableControls;
    cdsFornecedores.First;
 
    While Not Eof Do
    Begin
 
      If fEmptyStr(FieldbyName('COT_SEQGER').AsString) Then
      Begin
        Edit;
        FieldbyName('COT_SEQGER').AsString := Self.FieldbyName('AUTOINCREM').AsString;
        Post;
      End;
 
      Next;
    End;

    Result := fSalvaFornecedores(cdsFornecedores);

    EnableControls;
  End;
End;

Function TCotacao.fGravaFornecedoresDesmemb: Boolean;
  Var
    intContador: Integer;
Begin
  With cdsFornecedores Do
  Begin
    fAbreFornecedores(cdsFornecedoresDesmem, False);

    DisableControls;
    First;

    While Not Eof Do
    Begin
      cdsFornecedoresDesmem.Insert;

      For intContador := 0 To FieldCount - 1 Do
        cdsFornecedoresDesmem.Fields[intContador].Value := Fields[intContador].Value;

      cdsFornecedoresDesmem.FieldbyName('COT_SEQGER').AsString := Self.FieldbyName('AUTOINCREM').AsString;
      cdsFornecedoresDesmem.Post;

      Next;
    End;


    Result := fSalvaFornecedores(cdsFornecedoresDesmem);


    EnableControls;
  End;
End;

function TCotacao.fCodForToIndex(strCodFor: String): Integer;
  Var
    intContador:  Integer;
Begin
  Result := -1;
  For intContador := 1 To INT_MAX_FORNECEDOR Do
    If arrCodFor[intContador] = strCodFor Then
    Begin
      Result := intContador;
      Break;
    End;
End;

function TCotacao.fRetCodCta(strCodFor: String): String;
  Var
    intContador: Integer;
Begin
  Result := '';

  For intContador := Low(FarrCodCta) To High(FarrCodCta) Do
    If FarrCodCta[intContador].strCodFor = strCodFor Then
    Begin
      Result := FarrCodCta[intContador].strCodCta;
      Exit;
    End;

End;

function TCotacao.fIniciaPedidoCompra(    strCodFor,
                                          strCompra,
                                          strNumCot,
                                          strEmpCot,
                                          strNomEmpLoj,
                                          strEndEmpLoj,
                                          strCidEmpLoj,
                                          strMulLoj,
                                          strEmpDes: String;
                                      Var strNumPed,
                                          strConPag: String;
                                      Var dtaDtaPed,
                                          horHorPed,
                                          dtaDtaEnt: TDateTime;
                                          blnDesmem: Boolean): Boolean;
  Var
    fltTotIPI,
    fltTotSub,
    fltSubFCP,
    fltIcmDes,
    fltTotIte,
    fltTotGer,
    fltValIte,
    fltValIPI,
    fltValSub,
    fltValFCP,
    fltPerIPI,

    fltPerSub,
    fltPerFCP,

    fltBasCof,
    fltValCof,
    fltBasPis,
    fltValPis,
    fltPerFre,
    fltTotFre,
    fltBasIcm,
    fltValIcm,
    fltDesPis,
    fltBasIpi,
    fltBasSub,
    fltValFre,

    fltQtdIte,
    fltAlqPis,
    fltAlqCof: Double;

    blnIncPis: Boolean;

    intIndex: Integer;
Begin
  Try
    strNumPed := '';
    Result := False;

    intIndex := fCodForToIndex(strCodFor);

    If intIndex < 1 Then
    Begin
      pMensagemOk('Fornecedor ' + strCodFor + ' não encontrado na cotação!');
      Exit;
    End;

    blnUsaColeta := fCfgSis('CONCOL', varBoolean) And (fCampoTabela('FOR_CONCOL', 'CADFOR', ['FOR_CODFOR'], [strCodFor]) = 'S');

    fltValFrePed := 0;
    fltDesAcePed := 0;
    fltTotSubPed := 0;
    fltSubFCPPed := 0;
    fltTotIcmDes := 0;
    fltTotItePed := 0;
    fltTotIpiPed := 0;
    fltTotVlrPed := 0;

    fltAlqPis := fCfgSis('ALPISP');
    fltAlqCof := fCfgSis('ALCOFP');
    If  fltAlqPis = 0.65 Then
    Begin
      fltAlqPis := 0;
      fltAlqCof := 0;
    End;

    fltTotIPI := 0;
    fltTotSub := 0;
    fltSubFCP := 0;
    fltIcmDes := 0;
    fltTotIte := 0;
    fltTotGer := 0;
    fltTotFre := 0;

    fltBasCof := 0;
    fltValCof := 0;
    fltBasPis := 0;
    fltValPis := 0;
    fltBasIcm := 0;
    fltValIcm := 0;
    fltDesPis := 0;
    fltBasIpi := 0;
    fltBasSub := 0;

    With cdsItens Do
    Begin
      cdsItens.First;

      While Not Eof Do
      Begin

        If blnDesmem Then
        Begin

          If Assigned(cdsItensMultiLojas) And
             cdsItensMultiLojas.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
            fltQtdIte := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat
          Else
            fltQtdIte := 0;

        End Else
        Begin

          fltQtdIte := FieldByName('QTDITE').AsFloat;

        End;

        If fltQtdIte > 0 Then
        Begin
          fltPerIPI := FieldByName('IPIENT' + fIndice(intIndex)).AsFloat;
          fltPerFre := FieldByName('FREENT' + fIndice(intIndex)).AsFloat;
          fltPerSub := FieldByName('SUBSTI' + fIndice(intIndex)).AsFloat;
          fltPerFCP := 0;

          fltValIte := fltQtdIte * FieldByName('VALUNI' + fIndice(intIndex)).AsFloat;

          fltValIPI := fltValIte * (fltPerIPI/100);
          fltValSub := fltValIte * (fltPerSub/100);
          fltValFre := fltValIte * (fltPerFre/100);

          fltValFCP := fltValSub * (fltPerFCP/100);

          fltTotIte := fltTotIte + fltValIte;
          fltTotIPI := fltTotIPI + fltValIPI;
          fltTotSub := fltTotSub + fltValSub;
          fltSubFCP := fltSubFCP + fltValFCP;
          fltTotFre := fltTotFre + fltValFRe;

          fltTotGer := fltTotGer + fltValIte + fltValIPI + fltValSub + fltValFre;

          blnIncPis := fCampoTabela('ITE_INCPIS', 'CADITE', ['ITE_CODITE'], [FieldByName('CODITE').AsString]) = 'S';

          If blnIncPis And (fltAlqPis > 0) Then
          Begin
            fltBasCof := fltBasCof + fltValIte;
            fltValCof := fltValCof + RoundTo(fltValIte * fltAlqCof/100, -2);
            fltBasPis := fltBasPis + fltValIte;
            fltValPis := fltValPis + RoundTo(fltValIte * fltAlqPis/100, -2);
          End;

          fltBasIcm := 0;
          fltValIcm := 0;
          fltDesPis := 0;
          fltBasIpi := 0;
          fltBasSub := 0;
        End;

        Next;
      End;

    End;

    If fltTotIte > 0 Then
    Begin

      strNumPed := fSeqPedidoCompra;
      dtaDtaPed := VS_Date;
      horHorPed := fTime();

      strConPag := fTiraCaracEspeciais(cdsFornecedores.FieldByName('COT_CONPAG').AsString);
      dtaDtaEnt := cdsFornecedores.FieldByName('COT_DTAENT').AsDateTime;

      If Length(FArrCodCta) > 1 Then
        With recObserv Do
        strCodCta := fRetCodCta(strCodFor);

      objDuplicatasPedido.pCarregaParcelas('');

      with recObserv Do
      pGravaPcmGer(False,
                   Nil,
                   objDuplicatasPedido,
                   strNumPed,                        // Número do Pedido
                   VS_strCodEmp,                     // Empresa
                   'PD',                             // Espécie (PD / OR)
                   strCodFor,                        // Fornecedor
                   strCodTra,                        // Transportadora
                   strCodTraRedespacho,              // Transportadora
                   strConPag,                        // Cond. Pagamento
                   dtaDtaPed,                        // Data do Pedido
                   horHorPed,                        // Hora do Pedido
                   dtaDtaEnt,                        // Data de Entrega
                   strCompra,                        // Comprador
                   fltTotIpi,                        // Total de IPI
                   fltTotSub,                        // Total de SUB
                   0,                                // Total de DARE
                   fltSubFCP,                        // Total de SUB FCP
                   fltTotIte,                        // Total de Itens

                   fltTotGer + fltValFre + fltDesAce,// Total de Itens+IPI+SUB

                   strObs001,                        // Observação 1
                   strObs002,                        // Observação 2
                   strObs003,                        // Observação 3
                   '',                               // Observação 4
                   '',                               // Observação 5
                   strObsPd1,                        // Observ PD 1
                   strObsPd2,                        // Observ PD 2
                   strObsPd3,                        // Observ PD 3
                   strPedVen,                        // Pedido de venda
                   strAtenca,                        // Atenção de
                   strTipFre,                        // Tipo de Frete
                   strTipFreRedespacho,                        // Tipo de Frete
                   '',                               // Origem do Documento (Faturamento)
                   0,                                // Número do Container
                   'N',                              // Pedido de Importação?
                   'N',                              // Pedido Intrepostado
                   strEmpDes,                        // Codigo da empresa destino
                   0,                                // Desconto Adicionsl
                   strMulLoj,                        // Pedido Multi Lojas?
                   fltValFre,                        // fltValFre
                   fltDesAce,                        // fltDesAce
                   dtaDtaPed,                        // Data do Faturamento
                   strCodEve,                        // Código do Evento
                   strCodCta,                        // Centro de Custo
                   strNomEmpLoj,
                   strEndEmpLoj,
                   strCidEmpLoj,
                   '',
                   nivNenhum,
                   0,
                   0,
                   0,
                   0,
                   fltBasCof,
                   fltValCof,
                   fltBasPis,
                   fltValPis,
                   fltBasIcm,
                   fltValIcm,
                   fltBasIpi,
                   fltBasSub,
                   IIF(fStatusCndPag(strConPag) = A_VISTA, 'S', 'N'),
                   strNumCot,
                   strEmpCot,
                   'N',
                   'N',
                   'P',
                   recDadGiro.intMesGir,
                   IIF(recDadGiro.blnConsMesAtu, 'S', 'N'),
                   '',
                   0,
                   0,
                   fltDesPis,
                   FAutGer,
                   'N');

      strCampoSaldoAdd := fRetCampoAtualizaSaldoPedidoCompra(FAutGer,
                                                             '',
                                                             '',
                                                             blnLibPcm,
                                                             strForFil);

      Result := fSalvaInterfaceCotacaoAutCom(FAutGer, 'frmDigGiroEstoque', IIF(blnDesmem, strEmpDes, ''));

    End Else
    Begin
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIniciaPedidoCompra]');
    End;
  End;

End;

function TCotacao.fGravaItemPedido(strCodFor,
                                   strNumPed,
                                   strEmpDes,
                                   strConPag: String;
                                   dtaDtaPed,
                                   horHorPed,
                                   dtaDtaEnt: TDateTime;
                                   strCodIte,
                                   strCodUni,
                                   strDesIte,
                                   strRefere,
                                   strSigUni: String;
                                   fltQtdIte,
                                   fltValUni,
                                   fltIpiEnt,
                                   fltFreEnt,
                                   fltSubsti,
                                   fltPerFCP: Double;
                                   blnMulLoj: Boolean): Boolean;
 Var
   fltTotIte,
   fltTotIPI,
   fltTotSub,
   fltSubFCP,
   fltBasSub,
   fltBasIPI,
   fltBasIcm,
   fltAlqIcm,
   fltValIcm,
   fltValFre,
   fltDesAce,
   fltTotFre,
   fltDesPis: Double;
   blnIncPis: Boolean;
   strAutIncPcmDet,
   strAutIncPcdDet: string;
   intQtdConCol: Integer;

   var qryInsert: TUniQuery;

Begin

  Try
    fltTotIte := fltQtdIte * fltValUni;
    fltTotIPI := fltTotIte * (fltIpiEnt/100);
    fltTotSub := fltTotIte * (fltSubsti/100);
    fltSubFCP := fltTotSub * (fltPerFCP/100);
    fltTotFre := fltTotIte * (fltFreEnt/100);

    fltBasSub := fltTotIte;
    fltBasIPI := fltTotIte;
    fltBasIcm := 0;
    fltAlqIcm := 0;
    fltValIcm := 0;
    fltDesPis := 0;

    blnIncPis := fCampoTabela('ITE_INCPIS', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S';

    If (fltFreEnt > 0) And (Not blnAlterouFrete) Then
      fltValFre := fltTotFre
    Else
    Begin
      If (fltValFreRes > 0) And (fltTotIteGer > 0) Then
      Begin

        If RoundTo(fltTotIte * (fltValFreGer / fltTotIteGer), -2) > fltValFreRes Then
          fltValFre := fltValFreRes
        Else
          fltValFre := RoundTo(fltTotIte * (fltValFreGer / fltTotIteGer), -2);

      End
      Else fltValFre := 0;
    End;

    If (fltDesAceRes > 0) And (fltTotIteGer > 0) Then
    Begin

      If RoundTo(fltTotIte * (fltDesAceGer / fltTotIteGer), -2) > fltDesAceRes Then
        fltDesAce := fltDesAceRes
      Else
        fltDesAce := RoundTo(fltTotIte * (fltDesAceGer / fltTotIteGer), -2);

    End
    Else fltDesAce := 0;

    fltValFreRes := RoundTo(fltValFreRes - fltValFre, -2);
    fltDesAceRes := RoundTo(fltDesAceRes - fltDesAce, -2);

    fltValFrePed := fltValFrePed + fltValFre;
    fltDesAcePed := fltDesAcePed + fltDesAce;
    fltTotSubPed := fltTotSubPed + fltTotSub;
    fltSubFCPPed := fltSubFCPPed + fltSubFCP;

    fltTotIcmDes := fltTotIcmDes + IIF(blnZonaFranca, fltValIcm, 0);

    fltTotItePed := fltTotItePed + fltTotIte;
    fltTotIpiPed := fltTotIpiPed + fltTotIPI;

    strAutIncPcmDet :=  fRetAutoIncrem('PCMDET', VS_strCodEmp);

    intQtdConCol := 0;

    qryInsert := fCriaQuery;

    qryInsert.SQL.Add(fGravaPcmDet(intQtdConCol,
                 Nil,
                 blnUsaColeta And (Not blnMulLoj),
                 '', // strEmpDes
                 '', // strCampoSaldoSub
                 strCampoSaldoAdd,
                 intDeqTpc,
                 strNumPed,                                // Número do Pedido
                 VS_strCodEmp,                             // Empresa
                 'PD',                                     // Espécie (PD / OR)
                 strCodFor,                                // Fornecedor
                 strCodIte,                                // Código Item
                 strCodUni,                                // Código Unidade
                 dtaDtaEnt,                                // Data Entrega
                 horHorPed,                                // Hora do Pedido
                 dtaDtaPed,                                // Data do Pedido
                 strConPag,                                // Cond. Pagamento
                 strDesIte,                                // Descrição Item
                 fltQtdIte,                                // Quantidade
                 fltValUni,                                // Preço Unitario
                 0,                                        // % desconto 1 unitário
                 0,                                        // % desconto 2 unitário
                 0,                                        // % desconto 3 unitário
                 0,                                        // % desconto 4 unitário
                 0,                                        // % desconto 5 unitário
                 0,                                        // % desconto 6 unitário
                 fltTotIte,                                // Total Itens S
                 fltIPIEnt,                                // Percentual IPI
                 fltTotIPI,                                // Total IPI
                 fltSubsti,                                // Percentual SUB
                 fltTotSub,                                // Total SUB
                 0,                                        // Total DARE
                 fltPerFCP,                                // Percentual SUB FCP
                 fltSubFCP,                                // Total SUB
                 0,                                        // Quantidade Baixa
                 0,                                        // Total Baixado
                 0,                                        // IPI Baixado
                 0,                                        // SUB Baixado
                 0,                                        // DARE Baixado
                 0,                                        // SUB FCP Baixado
                 0,
                 0,
                 fltValFre,
                 fltDesAce,
                 0,                                        // Baixado?
                 '' ,                                       // Origem do Documento (Faturamento)
                 0,                                        // Número do Container
                 'N',                                      // Pedido de Importação?
                 'N',                                      // Pedido Intrepostado
                 'N',                                      // Proveninete de Importação?
                 0,
                 0,
                 strAutIncPcmDet,                             // Auto Incremento
                 '',                                       // Código do produto acabado
                 '',                                       // Empresa do produto acabado
                 '',                                       // Produto acabado? (S/N)
                 0,                                        // Conferencia de entrada
                 fltBasSub,
                 fltBasIPI,
                 fltBasIcm,
                 100,
                 fltAlqIcm,
                 fltValIcm,
                 blnIncPis,
                 '',
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 '',    //  strFatDor: string);
                 1,
                 fltALPISP,
                 fltALCOFP,
                 'S',
                 fltDesPis));

      qryInsert.SQL.Text := TMontaSQLPedidoCompra.fAjustaAutoIncControleDeColeta(intQtdConCol, qryInsert.SQL.Text);

      qryInsert.ExecSQL;

      // Insere relação PCMDET -> MOVRCD (Item do pedido com item da requisição de compra)
      pIncluiPcmIrq(strAutIncPcmDet, strCodIte);

      If blnMulLoj And Assigned(cdsItensMultiLojas) Then
      Begin
        qryInsert.SQL.Clear;
        strAutIncPcdDet := fRetAutoIncrem('PCDDET', VS_strCodEmp);
        qryInsert.SQL.Add(fGravarPcdDet(strAutIncPcdDet,
                      strNumPed, 'PD', VS_strCodEmp, strCodIte,
                      strAutIncPcmDet, cdsItensMultiLojas, False, '', True));
        If Trim(qryInsert.SQL.Text) <> '' Then
          qryInsert.ExecSQL;
      end;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaItem]');
    End;
  End;

End;

function TCotacao.fGravaPedidoCompra(strNumCot,
                                     strEmpCot,
                                     strCodFor,
                                     strNomEmpLoj,
                                     strEndEmpLoj,
                                     strCidEmpLoj,
                                     strMulLoj,
                                     strEmpDes: String;
                                     blnDesmem: Boolean;
                                     StatusPitStopCotacao: TStatusPitStopCotacao): Boolean;
  Var
    strNumPed,
    strConPag: String;
    dtaDtaPed,
    horHorPed,
    dtaDtaEnt: TDateTime;

    strCodUni,
    strSigUni: String;

    fltEmbala,
    fltUnitar,
    fltQtdIte: Double;

    blnRefPed: Boolean;

    intIndex,
    intIndexGerados: Integer;
Begin
  Result := False;

  intIndex := fCodForToIndex(strCodFor);

  If intIndex < 1 Then
  Begin
    pMensagemOk('Fornecedor ' + strCodFor + ' não encontrado na cotação!');
    Exit;
  End;

  blnRefPed := fCfgSis('REFPED', varBoolean);

  With cdsItens Do
  Begin
    Result := fIniciaPedidoCompra(strCodFor,
                                  strCodCmp,
                                  strNumCot,
                                  strEmpCot,
                                  strNomEmpLoj,
                                  strEndEmpLoj,
                                  strCidEmpLoj,
                                  strMulLoj,
                                  strEmpDes,
                                  strNumPed,
                                  strConPag,
                                  dtaDtaPed,
                                  horHorPed,
                                  dtaDtaEnt,
                                  blnDesmem);

    If fEmptyStr(strNumPed) Then
      Exit;

    strLisPed := strLisPed + strNumPed + ', ';

    cdsItens.First;
    While (Not Eof) And Result Do
    Begin
      strCodUni := FieldByName('CODUNI').AsString;
      strSigUni := FieldByName('SIGUNI').AsString;
      fltUnitar := FieldByName('VALUNI' + fIndice(IntIndex)).AsFloat;

      If blnDesmem Then
      Begin

        If Assigned(cdsItensMultiLojas) And
           cdsItensMultiLojas.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
          fltQtdIte := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat
        Else
          fltQtdIte := 0;

      End Else
      Begin

        fltQtdIte := FieldByName('QTDITE').AsFloat;

      End;

      If fltQtdIte > 0 Then
      Begin
        If blnConverterEmbalagens And
           fCarregaDadosCompraEmbalagem(FieldByName('CODITE').AsString, strCodUni, strSigUni, fltEmbala) Then
        Begin
          fltQtdIte := fltQtdIte / fltEmbala;
          fltUnitar := fltUnitar * fltEmbala;
        End;

        Result := fGravaItemPedido(strCodFor,
                                   strNumPed,
                                   strEmpDes,
                                   strConPag,
                                   dtaDtaPed,
                                   horHorPed,
                                   dtaDtaEnt,
                                   FieldByName('CODITE').AsString,
                                   strCodUni,
                                   Trim(FieldByName('DESITE').AsString + IIF(blnRefPed, ' ' + FieldByName('REFERE').AsString, '')),
                                   FieldByName('REFERE').AsString,
                                   strSigUni,
                                   fltQtdIte,
                                   fltUnitar,
                                   FieldByName('IPIENT' + fIndice(intIndex)).AsFloat,
                                   FieldByName('FREENT' + fIndice(intIndex)).AsFloat,
                                   FieldByName('SUBSTI' + fIndice(intIndex)).AsFloat,
                                   0,
                                   (Not blnDesmem) And (strMulLoj = 'S'));

        If Not Result Then
          Break;

        If Not FItensGerados.Find(FieldByName('CODITE').AsString, intIndexGerados) Then
        Begin
          FItensGerados.Add(FieldByName('CODITE').AsString);
          Edit;
          FieldByName('ALTERADO').AsString := 'S';
          Post;
        End;
      End;

      Next;
    End;

    pAtualizaTotaisPedido(FAutGer,
                          fltValFrePed,
                          fltDesAcePed,
                          fltTotSubPed,
                          fltSubFCPPed,
                          fltTotItePed,
                          fltTotIpiPed,
                          fltTotIcmDes);
    If Result Then
      If Assigned(RedePitStop) Then
        If StatusPitStopCotacao in [spscPendenteRecotarPreco, spscConcluido] Then
          result := fFaturaPitStop(strCodFor, FAutGer, strNumCot, StatusPitStopCotacao);

  End;
End;

function TCotacao.fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor: String): Boolean;
  Var
    qryCadEmp: TUniQuery;

   strNomEmpLoj,
   strEndEmpLoj,
   strCidEmpLoj: String;
Begin
  If Not Assigned(cdsItensMultiLojas) Then
  Begin
    Result := False;
    pMensagemOk('Dados Multiloja não inicializados!');
    Exit;
  End;

  Result := True;

  qryCadEmp := fCriaQuery;
  pAbreEmpresas(qryCadEmp);

  With qryCadEmp Do
  While (Not Eof) Do
  Begin

    If recObserv.blnEndLoj Then
    Begin
      strNomEmpLoj := FieldByName('NOMENT').AsString;  // Nome p/ Entrega
      strEndEmpLoj := FieldByName('ENDENT').AsString;  // Endereço p/ Entrega
      strCidEmpLoj := FieldByName('NOMCID').AsString;  // Cidade p/ Entrega
    End Else
    with recObserv Do
    Begin
      strNomEmpLoj := strNomEmp;  // Nome p/ Entrega
      strEndEmpLoj := strEndere;  // Endereço p/ Entrega
      strCidEmpLoj := strCidade;  // Cidade p/ Entrega
    End;

    cdsItensMultiLojas.Filter   := 'ITE_CODEMP = ' + QuotedStr(FieldByName('EMP_CODEMP').AsString) + ' AND ITE_QTDITE > 0';
    cdsItensMultiLojas.Filtered := True;

    If Not cdsItensMultiLojas.IsEmpty then
      Result := fGravaPedidoCompra(strNumCot,
                                   strEmpCot,
                                   strCodFor,
                                   strNomEmpLoj,
                                   strEndEmpLoj,
                                   strCidEmpLoj,
                                   'N',
                                   FieldByName('EMP_CODEMP').AsString,
                                   True,
                                   spscSemApi);

    If Not Result Then
      Break;

    Next;
  End;

End;

function TCotacao.fGravarEmaCot(arrDest: TStringArray; strAssunto,
  strCodFor: String): Boolean;
 function fGetDest: String;
  var
    I: Integer;
  begin
    For I := 0 To Length(arrDest)-1 Do
      If (I < Length(arrDest)-1) Then
        Result := Result + arrDest[I] + ', '
      Else
        Result := Result + arrDest[I];
  end;

  function fAtualizaCdsFornecedores:Boolean;
  begin
    Result := False;
    cdsFornecedores.Edit;
    cdsFornecedores.FieldByName('EMA_EMAENV').AsString   := 'Sim';
    cdsFornecedores.FieldByName('EMA_DTAENV').AsDateTime := fNow;
    cdsFornecedores.FieldByName('EMA_DESTIN').AsString   := fGetDest;
    cdsFornecedores.Post;
  end;

var
  qryIns: TUniQuery;
  strDest: String;
begin
  Result := False;
  strDest := fGetDest;

  Try
    qryIns := fCriarQuery('SELECT * FROM EMACOT WHERE FALSE');
    qryIns.Open;
    fStartTransaction;

    qryIns.Append;
    qryIns.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('EMACOT',VS_strCodEmp);
    qryIns.FieldByName('EMA_DTAENV').AsDateTime := fNow;
    qryIns.FieldByName('EMA_HRAENV').AsDateTime := fNow;
    qryIns.FieldByName('EMA_ASSUNT').AsString   := strAssunto;
    qryIns.FieldByName('EMA_DESTIN').AsString   := strDest;
    qryIns.FieldByName('EMA_CODFOR').AsString   := strCodFor;
    qryIns.FieldByName('EMA_SEQGER').AsString   := strSeqGer;
    qryIns.Post;

    Try
      If fCommit Then
        fAtualizaCdsFornecedores; // Atualização do cdsFornecedores já aberto, sem necessidade de chamar fAbreFornecedores novamente

      Result := True;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message,'fGravarEmaCot');
      End;
    End;

  Finally
    FreeAndNil(qryIns);
  End;

end;


function TCotacao.fCarregaDadosCompraEmbalagem(Const strCodIte: String; Var strCodUni: String;
  Var strSigUni: String; Var fltEmbala: Double): Boolean;
  Var
    qryItem: TUniQuery;
begin
  qryItem := fCriaQuery(Self);

  With qryItem, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT SQL_NO_CACHE');
    Add('  ITE_UNICOM,      ');
    Add('  UNI_SIGUNI,      ');
    Add('  ITE_EMBALA       ');
    Add('FROM               ');
    Add('  CADITE           ');
    Add('  LEFT JOIN CADUNI ON ITE_UNICOM = UNI_CODUNI');
    Add('WHERE ');
    Add('  ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := FieldByName('ITE_EMBALA').AsFloat > 0;

    If Result Then
    Begin
      fltEmbala := FieldByName('ITE_EMBALA').AsFloat;
      strCodUni := FieldByName('ITE_UNICOM').AsString;
      strSigUni := FieldByName('UNI_SIGUNI').AsString;
    End;

  End;

  FreeAndNil(qryItem);
end;

function TCotacao.fTemPedidoCompraGerado(var strPedidoCompra: String): Boolean;
var qryConsulta : TUniQuery;
begin

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT');
    qryConsulta.SQL.Add('  CONCAT(PCG_NUMPED,  "-" ,PCG_ESPDOC , "-" ,PCG_CODEMP) AS PEDIDO');
    qryConsulta.SQL.Add('FROM');
    qryConsulta.SQL.Add('  PCMGER');
    qryConsulta.SQL.Add('WHERE PCG_NUMCOT = :NUMCOT');
    qryConsulta.SQL.Add('  AND PCG_EMPCOT = :EMPCOT');

    qryConsulta.ParamByName('NUMCOT').AsString := FieldByName('COT_NUMCOT').AsString;
    qryConsulta.ParamByName('EMPCOT').AsString := FieldByName('COT_CODEMP').AsString;

    qryConsulta.Open;

    Result := Not qryConsulta.IsEmpty;
    If Result Then
      strPedidoCompra := qryConsulta.FieldByName('PEDIDO').AsString;



  Finally
    FreeAndNil(qryConsulta);
  End;
{}
end;

function TCotacao.fTemPrecoSelecionado(blnSelecionados: Boolean): Boolean;
  Var
    strFilter: String;
    blnFiltered: Boolean;
Begin
  with cdsItens Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;

    Try
      DisableControls;
      pSetaEventosItem(False);

      Filter   := '(FORESC <> ' + QuotedStr('')  + ') AND (QTDITE > 0) AND GERPED = ' + QuotedStr('N') +
                   IfThen(blnSelecionados, ' AND MARPED = ' + QuotedStr('S'), '');
      Filtered := True;

      Result := Not IsEmpty;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCotacao.fTemPrecoSelecionado]');
      End;
    End;

    Filter   := strFilter;
    Filtered := blnFiltered;

    pEnableControlsItens;
    pSetaEventosItem(True);
  End;
End;

function TCotacao.fTrataCodFab(dtsDados: TDataSet): String;
var
  intCnt: Integer;
begin
  FqryConsulta.sql.Clear;
  FqryConsulta.SQL.Add('   SELECT COUNT(1) AS CNT FROM ITEFOR F ');
  FqryConsulta.SQL.Add('   WHERE F.ITE_CODITE = :CODITE         ');
  FqryConsulta.SQL.Add('     AND F.ITE_CODFOR = :CODFOR         ');
  FqryConsulta.ParamByName('CODITE').AsString := dtsDados.FieldByName('CODITE').AsString;
  FqryConsulta.ParamByName('CODFOR').AsString := FCodForExportacao;
  FqryConsulta.Open;
  intCnt := FqryConsulta.FieldByName('CNT').AsInteger;

  If intCnt > 1 Then
  Begin
    FqryConsulta.sql.Clear;
    FqryConsulta.SQL.Add('  SELECT SQL_NO_CACHE            ');
    FqryConsulta.SQL.Add('   I02_CPROD                     ');
    FqryConsulta.SQL.Add('  FROM DETELE                    ');
    FqryConsulta.SQL.Add('  INNER JOIN GERELE G            ');
    FqryConsulta.SQL.Add('    ON DET_SEQGER = G.AUTOINCREM ');
    FqryConsulta.SQL.Add('  WHERE G.GER_CODFOR = :CODFOR   ');
    FqryConsulta.SQL.Add('      AND DET_CODITE = :CODITE   ');
    FqryConsulta.SQL.Add('  ORDER BY                       ');
    FqryConsulta.SQL.Add('    G.B10_DSAIENT DESC LIMIT 1   ');
    FqryConsulta.ParamByName('CODITE').AsString := dtsDados.FieldByName('CODITE').AsString;
    FqryConsulta.ParamByName('CODFOR').AsString := FCodForExportacao;
    FqryConsulta.Open;
    Result := FqryConsulta.FieldByName('I02_CPROD').AsString;
    Exit;
  End;

  FqryConsulta.sql.Clear;
  IF blnTabprf Then
  begin
    FqryConsulta.SQL.Add('   SELECT * FROM ITEFOR F');
    FqryConsulta.SQL.Add('    WHERE  F.ITE_CODFAB IS NOT NULL');
    FqryConsulta.SQL.Add('      AND (SELECT COUNT(*) FROM TABPRE');
    FqryConsulta.SQL.Add('            WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0');
    FqryConsulta.SQL.Add('     AND F.ITE_CODITE = :CODITE');
    FqryConsulta.SQL.Add('      AND F.ITE_CODFOR = :CODFOR');
    FqryConsulta.SQL.Add('      GROUP BY F.ITE_CODFAB');
  End
  Else
  Begin
    FqryConsulta.SQL.Add('SELECT * FROM ITEFOR F');
    FqryConsulta.SQL.Add('  WHERE F.ITE_CODITE = :CODITE');
    FqryConsulta.SQL.Add('    AND F.ITE_CODFOR = :CODFOR');
    FqryConsulta.SQL.Add('    AND F.AUTOINCREM = (SELECT MAX(FF.AUTOINCREM) FROM ITEFOR FF');
    FqryConsulta.SQL.Add('                         WHERE FF.ITE_CODITE = :CODITE');
    FqryConsulta.SQL.Add('                          AND  FF.ITE_CODFOR = :CODFOR)');
  End;

  FqryConsulta.ParamByName('CODITE').AsString := dtsDados.FieldByName('CODITE').AsString;
  FqryConsulta.ParamByName('CODFOR').AsString := FCodForExportacao;
  FqryConsulta.Open;

  If FqryConsulta.IsEmpty Then
    Result := dtsDados.FieldByName('CODFAB').AsString
  Else
  Begin
    If blnTabprf Then
      Result :=  IIF(FqryConsulta.FieldByName('ITE_CODFAB').AsString = '' , dtsDados.FieldByName('CODFAB').AsString, FqryConsulta.FieldByName('ITE_CODFAB').AsString)
    Else
      Result :=  IIF(FqryConsulta.FieldByName('ITE_CODITF').AsString = '' , dtsDados.FieldByName('CODFAB').AsString, FqryConsulta.FieldByName('ITE_CODITF').AsString);
  End;
end;

function TCotacao.fValidaItensSemFornecedor: boolean;
begin
  AcaoParaItensSemCotacao := TfrmItensCotacaoSemCotacao.fSelecionaAcaoParaItemsSemFornecedorCotado(cdsItens);
  Result := AcaoParaItensSemCotacao <> taAbortado;
end;

function TCotacao.fGetFornecedoresPedidos: Boolean;
  Var
    strFilter,
    strCodFor: String;
    blnFiltered: Boolean;
Begin
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    SetLength(FarrCodCta, 0);
    Result := True;
    Exit;
  End;

  With cdsItens Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;
  End;

  Try
    SetLength(FarrCodCta, 0);

    with cdsItens Do
    Begin
      DisableControls;

      pSetaEventosItem(False);

      cdsFornecedores.DisableControls;
      cdsFornecedores.First;

      While (Not cdsFornecedores.Eof) Do
      Begin
        strCodFor := cdsFornecedores.FieldbyName('COT_CODFOR').AsString;
        Filter   := '(FORESC = ''' + strCodFor + ''') AND (QTDITE > 0) AND (PREESC > 0)';
        Filtered := True;

        If Not IsEmpty Then
        Begin
          SetLength(FarrCodCta, Succ(Length(FarrCodCta)));

          FarrCodCta[High(FarrCodCta)].strCodFor := strCodFor;
        End;

        cdsFornecedores.Next;
      End;

      cdsFornecedores.EnableControls;

      pEnableControlsItens;
    End;

    Result := True

  Except
    On E: Exception Do
    Begin
      cdsFornecedores.EnableControls;
      cdsItens.EnableControls;

      Result := False;
      pMensagensErro(E.Message, '[fGetFornecedoresPedidos]');
    End;
  End;

  With cdsItens Do
  Begin
    Filter   := strFilter;
    Filtered := blnFiltered;
  End;

  pSetaEventosItem(True);
End;

function TCotacao.fGeraPedidosCompra(strNumCot, strEmpCot, strEmpDes: String): Boolean;
  Var
    strFilter,
    strTestaF2,
    strCodFor: String;
    blnFiltered: Boolean;
    PreparaPedidosCotacao: TPreparaPedidosCotacao;
    blnConfirma: Boolean;
Begin
  With cdsItens Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;
  End;

  Try
    strLisPed := '';
    blnConfirma := TRUE;

    with cdsItens Do
    Begin
      DisableControls;

      pSetaEventosItem(False);

      cdsFornecedores.DisableControls;

      fltValFreRes := recObserv.fltValFre;
      fltDesAceRes := recObserv.fltDesAce;

      fltValFreGer := recObserv.fltValFre;
      fltDesAceGer := recObserv.fltDesAce;

      If tpgGerarPedidos = tpgGeraF2 Then
        strTestaF2 := ' AND MARPED = ' + QuotedStr('S')
      Else
        strTestaF2 := '';
      If Not COTACAO_MODO_GRAVACAO_ANTIGA Then
      begin
        PreparaPedidosCotacao := TPreparaPedidosCotacao.Create(strNumCot,
                                                                strEmpCot,
                                                                strEmpDes,
                                                                strCodCmp,
                                                                strCodGirOriginal,
                                                                recDadGiro,
                                                                cdsFornecedores,
                                                                cdsItens,
                                                                cdsItensMultiLojas,
                                                                strTestaF2,
                                                                fCodForToIndex,
                                                                fCarregaDadosCompraEmbalagem,
                                                                pIncluiPcmIrq,
                                                                blnConverterEmbalagens,
                                                                recObserv,
                                                                FArrCodCta,
                                                                fRetCodCta,
                                                                objDuplicatasPedido,
                                                                IIf(recObserv.blnDesmen, 'N', IIF(blnMulLoj, 'S', 'N')),
                                                                fltValFreRes,
                                                                fltDesAceRes,
                                                                FItensGerados,
                                                                pInsereCadIntExtra,
                                                                RedePitStop,
                                                                fFaturaPitStop);
        Try
           blnConfirma := PreparaPedidosCotacao.fProcessa_e_insere;
           strLisPed := PreparaPedidosCotacao.PedidosGerados;
        Finally
          FreeAndNil(PreparaPedidosCotacao)
        End;
      End
      Else
      begin
        cdsFornecedores.First;
        While (Not cdsFornecedores.Eof) And blnConfirma Do
        Begin

          strCodFor := cdsFornecedores.FieldbyName('COT_CODFOR').AsString;

          Filter   := '(FORESC = ''' + strCodFor + ''') AND (QTDITE > 0) AND (PREESC > 0) AND GERPED = ' + QuotedStr('N') + strTestaF2;
          Filtered := True;

          fltTotIteGer := fRetSumValUni(fCodForToIndex(strCodFor));


 
          cdsItens.First;

          If Not IsEmpty Then
          Begin

            If blnMulLoj And recObserv.blnDesmen Then
            Begin
              blnConfirma := fGravaPedidoCompraDesmembrado(strNumCot, strEmpCot, strCodFor);
            End Else
            Begin
              With recObserv Do
              blnConfirma := fGravaPedidoCompra(strNumCot, strEmpCot, strCodFor,
                                                strNomEmp, strEndere, strCidade,
                                                IIF(blnMulLoj, 'S', 'N'),
                                                Self.FieldByName('COT_EMPDES').AsString,
                                                False,
                                              TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger));
            End;

          End;

          If Not blnConfirma Then
            Break;

          cdsFornecedores.Next;

        End;
        If Not fEmptyStr(strLisPed) Then
        strLisPed := Copy(strLisPed,1,Length(strLisPed) - 2);
      End;

      If fEmptyStr(strLisPed) Then
        blnConfirma := FALSE;

      cdsFornecedores.EnableControls;

      pEnableControlsItens;
    End;

    Result := blnConfirma;

  Except
    On E: Exception Do
    Begin
      cdsFornecedores.EnableControls;
      cdsItens.EnableControls;

      Result := False;
      pMensagensErro(E.Message, '[fGeraPedidosCompra]');
    End;
  End;

  With cdsItens Do
  Begin
    Filter   := strFilter;
    Filtered := blnFiltered;
  End;

  pSetaEventosItem(True);
End;

Function TCotacao.fDesmembraCotacao(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    qryCadEmp: TUniQuery;
    strSeqApagar: String;
Begin
  qryCadEmp := fCriaQuery;

  cdsFornecedoresDesmem := TZClient.Create(Nil);

  If opeOperac = opAlterar Then
  Begin
    strSeqApagar := FieldByName('AUTOINCREM').AsString;

    If State = dsEdit Then
      Post;
  End Else
  Begin
    strSeqApagar := '';
  End;

  With recCotGer Do
  Begin
    strDesCri := FieldByName('COT_DESCRI').AsString;
    strCompra := FieldByName('COT_COMPRA').AsString;
    strMesAtu := FieldByName('COT_MESATU').AsString;
    intMesGir := FieldByName('COT_MESGIR').AsInteger;
    strMesSel := FieldByName('COT_MESSEL').AsString;
    intMesMos := FieldByName('COT_MESMOS').AsInteger;
    strNovIpi := FieldByName('COT_NOVIPI').AsString;
  End;

  Try
    Result := False;

    opeOperac := opIncluir;

    qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP';
    qryCadEmp.Open;

    While Not qryCadEmp.Eof Do
    Begin
      cdsItensMultiLojas.Filter   := 'ITE_CODEMP = ' + QuotedStr(qryCadEmp.FieldByName('EMP_CODEMP').AsString) + ' AND ITE_QTDITE > 0';
      cdsItensMultiLojas.Filtered := True;

      If Not cdsItensMultiLojas.IsEmpty Then
      Begin
        If State <> dsInsert Then
          Insert;

        FieldByName('COT_CODEMP').AsString   := VS_strCodEmp;
        FieldByName('COT_EMPDES').AsString   := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
        FieldByName('COT_DTACAD').AsDateTime := VS_Date;
        FieldByName('COT_MULLOJ').AsString   := 'N';

        With recCotGer Do
        Begin
          FieldByName('COT_DESCRI').AsString  := strDesCri;

          FieldByName('COT_COMPRA').AsString  := strCompra;
          If fEmptyStr(FieldByName('COT_COMPRA').AsString) Then
            FieldByName('COT_COMPRA').Clear;

          FieldByName('COT_MESATU').AsString  := strMesAtu;
          FieldByName('COT_MESGIR').AsInteger := intMesGir;
          FieldByName('COT_MESSEL').AsString  := strMesSel;
          FieldByName('COT_MESMOS').AsInteger := intMesMos;
          FieldByName('COT_NOVIPI').AsString  := strNovIpi;
        End;

        Result  := fSalvaUmaCotacaoPrg(pgbStatus);

        If Not Result Then
          Break;
      End;

      qryCadEmp.Next;
    End;

  Finally
    FreeAndNil(qryCadEmp);
    FreeAndNil(cdsFornecedoresDesmem);

    cdsItensMultiLojas.Filtered := False;
  End;

  If Result And (Not fEmptyStr(strSeqApagar)) Then
  Begin
    blnMulLoj := True;
    Result    := fApagaCotacao(strSeqApagar);
  End;
End;

function TCotacao.fVeSeBaixaCotacao: Boolean;
  Var
    qryCotGer: TUniQuery;
Begin

  qryCotGer := fCriaQuery;

  With qryCotGer, SQL Do
  Begin
    Add('UPDATE COTGER SET COT_DTAFIN = :HOJE');
    Add('WHERE ');
    Add('  AUTOINCREM = :SEQGER AND ');
    Add('  (SELECT COUNT(*) FROM COTITE WHERE COT_GERPED = "N" AND COT_SEQGER = :SEQGER) = 0');

    ParamByName('HOJE').AsDateTime := VS_Date;
    ParamByName('SEQGER').AsString := Self.FieldByName('AUTOINCREM').AsString;

    ExecSQL;
  End;

  FreeAndNil(qryCotGer);

  Result := True;
End;

function TCotacao.fSalvaCotacaoPrg(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin
  cdsFornecedores.AfterScroll := Nil;

  blnConverterEmbalagens := (tpgGerarPedidos <> tpgNaoGera) And (fCfgSis('CNVEMB') <> 'N');

  blnConverterEmbalagens := blnConverterEmbalagens And
    (fMensagem('', 'Converter unidades para caixa no Pedido de Compra?', ['','']) = 1);

  fStartTransaction;

  Try
    strCodGirOriginal := FieldByName('COT_CODGIR').AsString;
    If blnDesmembraCotacao Then
    Begin
      blnMulLoj := False;

      Result := fDesmembraCotacao(pgbStatus);

    End Else
    Begin
      blnMulLoj := FieldByName('COT_MULLOJ').AsString = 'S';

      Result := fSalvaUmaCotacaoPrg(pgbStatus);

    End;

    If Result Then
    Begin
      fCommit;
      Result := TRUE;
      blnApagaOnClose := True;
      pLiberaInterfacePedidoCompraAutCom;
      recDadGiro.objSalInt := Nil;
    End Else
    Begin
      fRollBack;
      Cancel;
      Result := FALSE;
      blnApagaOnClose := False;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fSalvaCotacao]');
    End;
  End;

End;

function TCotacao.fSalvaCotger: Boolean;
begin
  Result := True;
  try
    FqryConsulta.SQL.Clear;
    FqryConsulta.SQL.Add('SELECT * FROM COTGER WHERE AUTOINCREM = ' + QuotedStr(FieldByName('AUTOINCREM').Value));
    FqryConsulta.Open;
    If Not FqryConsulta.IsEmpty Then
    Begin
      FqryConsulta.SQL.Clear;
      FqryConsulta.SQL.Add('UPDATE COTGER SET ');
      FqryConsulta.SQL.Add('COT_CODEMP = :COT_CODEMP, ');
      FqryConsulta.SQL.Add('COT_NUMCOT = :COT_NUMCOT, ');
      FqryConsulta.SQL.Add('COT_DTACAD = :COT_DTACAD, ');
      FqryConsulta.SQL.Add('COT_DTAFIN = :COT_DTAFIN, ');
      FqryConsulta.SQL.Add('COT_DESCRI = :COT_DESCRI, ');
      FqryConsulta.SQL.Add('COT_COMPRA = :COT_COMPRA, ');
      FqryConsulta.SQL.Add('COT_CODCMP = :COT_CODCMP, ');
      FqryConsulta.SQL.Add('COT_MESATU = :COT_MESATU, ');
      FqryConsulta.SQL.Add('COT_MESGIR = :COT_MESGIR, ');
      FqryConsulta.SQL.Add('COT_MULLOJ = :COT_MULLOJ, ');
      FqryConsulta.SQL.Add('COT_MESSEL = :COT_MESSEL, ');
      FqryConsulta.SQL.Add('COT_MESMOS = :COT_MESMOS, ');
      FqryConsulta.SQL.Add('COT_NOVIPI = :COT_NOVIPI, ');
      FqryConsulta.SQL.Add('COT_CODDIG = :COT_CODDIG, ');
      FqryConsulta.SQL.Add('COT_EMPDES = :COT_EMPDES, ');
      FqryConsulta.SQL.Add('COT_CODTCT = :COT_CODTCT, ');
      FqryConsulta.SQL.Add('COT_CODGIR = :COT_CODGIR, ');
      FqryConsulta.SQL.Add('COT_LIBBID = :COT_LIBBID  ');
      FqryConsulta.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM ');
    End
    Else
    Begin
      FqryConsulta.SQL.Clear;
      FqryConsulta.SQL.Add('INSERT INTO COTGER (');
      FqryConsulta.SQL.Add('AUTOINCREM,');
      FqryConsulta.SQL.Add('COT_CODEMP,');
      FqryConsulta.SQL.Add('COT_NUMCOT,');
      FqryConsulta.SQL.Add('COT_DTACAD,');
      FqryConsulta.SQL.Add('COT_DTAFIN,');
      FqryConsulta.SQL.Add('COT_DESCRI,');
      FqryConsulta.SQL.Add('COT_COMPRA,');
      FqryConsulta.SQL.Add('COT_CODCMP,');
      FqryConsulta.SQL.Add('COT_MESATU,');
      FqryConsulta.SQL.Add('COT_MESGIR,');
      FqryConsulta.SQL.Add('COT_MULLOJ,');
      FqryConsulta.SQL.Add('COT_MESSEL,');
      FqryConsulta.SQL.Add('COT_MESMOS,');
      FqryConsulta.SQL.Add('COT_NOVIPI,');
      FqryConsulta.SQL.Add('COT_CODDIG,');
      FqryConsulta.SQL.Add('COT_EMPDES,');
      FqryConsulta.SQL.Add('COT_CODTCT,');
      FqryConsulta.SQL.Add('COT_CODGIR,');
      FqryConsulta.SQL.Add('COT_LIBBID) VALUES (');
      FqryConsulta.SQL.Add(':AUTOINCREM,');
      FqryConsulta.SQL.Add(':COT_CODEMP,');
      FqryConsulta.SQL.Add(':COT_NUMCOT,');
      FqryConsulta.SQL.Add(':COT_DTACAD,');
      FqryConsulta.SQL.Add(':COT_DTAFIN,');
      FqryConsulta.SQL.Add(':COT_DESCRI,');
      FqryConsulta.SQL.Add(':COT_COMPRA,');
      FqryConsulta.SQL.Add(':COT_CODCMP,');
      FqryConsulta.SQL.Add(':COT_MESATU,');
      FqryConsulta.SQL.Add(':COT_MESGIR,');
      FqryConsulta.SQL.Add(':COT_MULLOJ,');
      FqryConsulta.SQL.Add(':COT_MESSEL,');
      FqryConsulta.SQL.Add(':COT_MESMOS,');
      FqryConsulta.SQL.Add(':COT_NOVIPI,');
      FqryConsulta.SQL.Add(':COT_CODDIG,');
      FqryConsulta.SQL.Add(':COT_EMPDES,');
      FqryConsulta.SQL.Add(':COT_CODTCT,');
      FqryConsulta.SQL.Add(':COT_CODGIR,');
      FqryConsulta.SQL.Add(':COT_LIBBID);');
    End;

    FqryConsulta.ParamByName('AUTOINCREM').Value := FieldByName('AUTOINCREM').Value;
    FqryConsulta.ParamByName('COT_CODEMP').Value := FieldByName('COT_CODEMP').Value;
    FqryConsulta.ParamByName('COT_NUMCOT').Value := FieldByName('COT_NUMCOT').Value;
    FqryConsulta.ParamByName('COT_DTACAD').Value := FieldByName('COT_DTACAD').Value;
    FqryConsulta.ParamByName('COT_DTAFIN').Value := FieldByName('COT_DTAFIN').Value;
    FqryConsulta.ParamByName('COT_DESCRI').Value := FieldByName('COT_DESCRI').Value;
    FqryConsulta.ParamByName('COT_COMPRA').Value := FieldByName('COT_COMPRA').Value;
    FqryConsulta.ParamByName('COT_CODCMP').Value := FieldByName('COT_CODCMP').Value;
    FqryConsulta.ParamByName('COT_MESATU').Value := FieldByName('COT_MESATU').Value;
    FqryConsulta.ParamByName('COT_MESGIR').Value := FieldByName('COT_MESGIR').Value;
    FqryConsulta.ParamByName('COT_MULLOJ').Value := FieldByName('COT_MULLOJ').Value;
    FqryConsulta.ParamByName('COT_MESSEL').Value := FieldByName('COT_MESSEL').Value;
    FqryConsulta.ParamByName('COT_MESMOS').Value := FieldByName('COT_MESMOS').Value;
    FqryConsulta.ParamByName('COT_NOVIPI').Value := FieldByName('COT_NOVIPI').Value;
    FqryConsulta.ParamByName('COT_CODDIG').Value := FieldByName('COT_CODDIG').Value;
    FqryConsulta.ParamByName('COT_EMPDES').Value := FieldByName('COT_EMPDES').Value;
    FqryConsulta.ParamByName('COT_CODTCT').Value := FieldByName('COT_CODTCT').Value;
    FqryConsulta.ParamByName('COT_CODGIR').Value := FieldByName('COT_CODGIR').Value;
    FqryConsulta.ParamByName('COT_LIBBID').Value := FieldByName('COT_LIBBID').Value;
    FqryConsulta.ExecSQL;
  Except
    on e:Exception do
    begin
      Result := False;
      pMensagensErro(e.message, '[TCotacao.fSalvaCotger]');
    End;
  End;
end;

function TCotacao.fSalvaFornecedores(DataSet: TDataSet): Boolean;
var ListaCodFor: String;
begin
  Result := True;
  Try
    ListaCodFor := '';
    DataSet.First;
    while not DataSet.Eof Do
    begin
      FqryConsulta.SQL.Clear;
      FqryConsulta.SQL.Add('SELECT * FROM COTCFO WHERE COT_SEQGER = ' + QuotedStr(DataSet.FieldByName('COT_SEQGER').Value) + ' AND COT_CODFOR = ' + QuotedStr(DataSet.FieldByName('COT_CODFOR').Value));
      FqryConsulta.Open;
      If Not FqryConsulta.IsEmpty Then
      Begin
        FqryConsulta.SQL.Clear;
        FqryConsulta.SQL.Add('UPDATE COTCFO SET ');
        FqryConsulta.SQL.Add('COT_CODFOR = :COT_CODFOR, ');
        FqryConsulta.SQL.Add('COT_CONPAG = :COT_CONPAG, ');
        FqryConsulta.SQL.Add('  COT_ANCORA = :COT_ANCORA, ');
        FqryConsulta.SQL.Add('  COT_SKYPEC = :COT_SKYPEC, ');
        FqryConsulta.SQL.Add('  COT_PITSTO = :COT_PITSTO, ');
        FqryConsulta.SQL.Add('  COT_INIINT = :COT_INIINT, ');
        FqryConsulta.SQL.Add('COT_DTAENT = :COT_DTAENT, ');
        FqryConsulta.SQL.Add('COT_UTILIZ = :COT_UTILIZ  ');
        FqryConsulta.SQL.Add('WHERE COT_SEQGER = :COT_SEQGER AND ');
        FqryConsulta.SQL.Add('      COT_CODFOR = :COT_CODFOR');
      End
      Else
      Begin
        FqryConsulta.SQL.Clear;
        FqryConsulta.SQL.Add('INSERT INTO COTCFO (');
        FqryConsulta.SQL.Add('COT_SEQGER,');
        FqryConsulta.SQL.Add('COT_CODFOR,');
        FqryConsulta.SQL.Add('COT_CONPAG,');
        FqryConsulta.SQL.Add('COT_ANCORA,');
        FqryConsulta.SQL.Add('COT_SKYPEC,');
        FqryConsulta.SQL.Add('COT_PITSTO,');
        FqryConsulta.SQL.Add('COT_INIINT,');
        FqryConsulta.SQL.Add('COT_DTAENT,');
        FqryConsulta.SQL.Add('COT_UTILIZ) VALUES (');

        FqryConsulta.SQL.Add(':COT_SEQGER,');
        FqryConsulta.SQL.Add(':COT_CODFOR,');
        FqryConsulta.SQL.Add(':COT_CONPAG,');
        FqryConsulta.SQL.Add(':COT_ANCORA,');
        FqryConsulta.SQL.Add(':COT_SKYPEC,');
        FqryConsulta.SQL.Add(':COT_PITSTO,');
        FqryConsulta.SQL.Add(':COT_INIINT,');

        FqryConsulta.SQL.Add(':COT_DTAENT,');
        FqryConsulta.SQL.Add(':COT_UTILIZ)');
      End;

      FqryConsulta.ParamByName('COT_SEQGER').Value := DataSet.FieldByName('COT_SEQGER').Value;
      FqryConsulta.ParamByName('COT_CODFOR').Value := DataSet.FieldByName('COT_CODFOR').Value;
      ListaCodFor := ListaCodFor + IIf(ListaCodFor = '', '', ',') + '"' + DataSet.FieldByName('COT_CODFOR').AsString + '"';
      FqryConsulta.ParamByName('COT_CONPAG').Value := DataSet.FieldByName('COT_CONPAG').Value;
      FqryConsulta.ParamByName('COT_ANCORA').Value := DataSet.FieldByName('COT_ANCORA').Value;
      FqryConsulta.ParamByName('COT_SKYPEC').Value := DataSet.FieldByName('COT_SKYPEC').Value;
      FqryConsulta.ParamByName('COT_PITSTO').Value := DataSet.FieldByName('COT_PITSTO').Value;
      FqryConsulta.ParamByName('COT_INIINT').Value := DataSet.FieldByName('COT_INIINT').Value;
      FqryConsulta.ParamByName('COT_DTAENT').Value := DataSet.FieldByName('COT_DTAENT').Value;
      FqryConsulta.ParamByName('COT_UTILIZ').Value := DataSet.FieldByName('COT_UTILIZ').Value;
      FqryConsulta.ExecSQL;
      DataSet.Next;
    End;

    FqryConsulta.SQL.Clear;
    FqryConsulta.SQL.Add('DELETE FROM COTCFO WHERE COT_SEQGER = "' + DataSet.FieldByName('COT_SEQGER').AsString + '" AND COT_CODFOR NOT IN ('+ListaCodFor+')');
    FqryConsulta.ExecSQL;
  Except
    on e: Exception  do
    Begin
      Result := False;
      pMensagensErro(e.message, '[TCotacao.fSalvaFornecedores]');
    end;

  End;
end;

function TCotacao.fSalvaUmaCotacaoPrg(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnConfirma: Boolean;
    strEmpCot,
    strEmpDes: String;

  procedure pProgresso(intInc: Integer);
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Position := pgbStatus.Position + intInc;
    Application.ProcessMessages;
  end;

Begin

  If Assigned(pgbStatus) Then
    pgbStatus.Position := 0;

  Application.ProcessMessages;

  strLisPed := '';
  strNumCot := FieldByName('COT_NUMCOT').AsString;
  strEmpCot := FieldByName('COT_CODEMP').AsString;
  strEmpDes := FieldByName('COT_EMPDES').AsString;

  blnConfirma := TRUE;

  If Assigned(pgbStatus) Then
    pgbStatus.Properties.Max := 6;

  Case opeOperac Of
    opIncluir: Begin
                 strSeqger := fRetAutoIncrem('COTGER',VS_strCodEmp);
                 FieldByName('AUTOINCREM').AsString   := strSeqGer;
                 FieldByName('COT_NUMCOT').AsString   := fAtualizaProCod('COTGER', 'COT_NUMCOT');
                 strNumCot := FieldByName('COT_NUMCOT').AsString;
                 strEmpCot := VS_strCodEmp;
                 If (strCodGirOriginal <> '') And (strCodGirOriginal <> FieldByName('COT_CODGIR').AsString) Then
                 Begin
                   FieldByName('COT_CODGIR').AsString := fAtualizaProCod('SEQ_COT_GIR', 'COT_CODGIR', 'COTGER', 1, Nil,
                     function (const AValue: String) : String
                     begin
                       Result := AValue + VS_StrCodEmp;
                     end
                   );
                   pInsereCadIntExtra(strCodGirOriginal, FieldByName('COT_CODGIR').AsString, 'frmDigGiroEstoqueCotacao');
                 End;
               End;
  End;

  Case opeOperac Of
    opIncluir,
    opAlterar: Begin
                If State <> dsEdit Then
                   Edit;

                 If strNumCot = '' Then
                 Begin
                   strSeqger := fRetAutoIncrem('COTGER',VS_strCodEmp);
                   FieldByName('AUTOINCREM').AsString   := strSeqGer;
                   FieldByName('COT_NUMCOT').AsString   := fAtualizaProCod('COTGER', 'COT_NUMCOT');
                   strNumCot := FieldByName('COT_NUMCOT').AsString;
                 End
                 Else
                   If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
                     FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COTGER',VS_strCodEmp);

                 strSeqGer := FieldByName('AUTOINCREM').AsString;

                 FieldByName('COT_CODCMP').AsString := strCodCmp;
                 FieldByName('COT_CODDIG').AsString := strCodDig;

                 If Not fEmptyStr(strCodTct) Then
                   FieldByName('COT_CODTCT').AsString := strCodTct
                 Else
                   FieldByName('COT_CODTCT').Value := Null;

                 If blnEncerra Then
                   FieldByName('COT_DTAFIN').AsDateTime := VS_Date;

                 If FindField('CODSOL') <> nil then
                   If Not fEmptyStr(strCodSolicitacao) Then
                      ParamByName('CODSOL').AsString:= strCodSolicitacao
                   Else
                      ParamByName('CODSOL').Value := Null;

                 Post;

                 blnConfirma := fSalvaCotger;

               End;
    opExcluir: Begin
                 blnConfirma := fApagaCotacao(FieldByName('AUTOINCREM').AsString);

               End;
  End;

  pProgresso(1);

  Case opeOperac Of
    opIncluir,
    opAlterar:  Begin
                  pMensagemGravacao('Aguarde, gravando Fornecedores...');

                  If blnDesmembraCotacao Then
                    blnConfirma := blnConfirma And fGravaFornecedoresDesmemb
                  Else
                    blnConfirma := blnConfirma And fGravaFornecedores;

                  pProgresso(1);

                  pMensagemGravacao('Aguarde, atualizando itens excluidos...');
                  blnConfirma := blnConfirma And fExcluiItens;
                  pProgresso(1);

                  FItensGerados.Clear;

                  If (tpgGerarPedidos <> tpgNaoGera) Then
                  Begin
                    pMensagemGravacao('Aguarde, gravando Pedidos...');
                    blnConfirma := blnConfirma And fGeraPedidosCompra(strNumCot, strEmpCot, strEmpDes);
                    If (tpgGerarPedidos = tpgTodos) And (AcaoParaItensSemCotacao = taGerarNovaCotacao) Then
                    Begin
                      pCriarNovaCotacaoComItensComItensSemCotacao(strSeqGer);
                    End;

                  End;


                  pMensagemGravacao('Aguarde, gravando Itens...');
                  blnConfirma := blnConfirma And fGravaItens;
                  pProgresso(1);

                  blnConfirma := blnConfirma And fGravaPcdDetCot;
                  pProgresso(1);

                  pProgresso(1);
                End;
  End;

  If Not (opeOperac In [opIncluir, opAlterar]) Then
    pProgresso(4);

  If (opeOperac In [opIncluir, opAlterar]) And ((blnUtilizouGiro) Or (recDadGiro.strValKey <> '')) Then
    blnConfirma := blnConfirma And fSalvaInterfaceCotacaoAutCom(strSeqGer, recDadGiro.strNomFrm, '');

   If opeOperac <> opExcluir Then
      blnConfirma := blnConfirma And fVeSeBaixaCotacao;


  Result := blnConfirma;
End;

function TCotacao.fApagaCotacao(strAutInc: String): Boolean;
Begin
  Try
    If Not blnDesmembraCotacao Then
      fStartTransaction;

    TSalvaInterfaceGiro.fApagaInterfaceCotacao(strAutInc);

    If (Not blnDesmembraCotacao) Or Self.Locate('AUTOINCREM', strAutInc, [])  Then
    Begin
      pLimpaPcmGerRes(Self.FieldByName('COT_NUMCOT').AsString, Self.FieldByName('COT_CODEMP').AsString);
      Delete;
      pLimpaRequisicao(strAutInc);

      Result := fDeletaCotacao(strAutInc);
    End

    Else Result := False;

    If Not blnDesmembraCotacao Then
    Begin
      If Not Result Then
        fRollback
      Else
        fCommit;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fApagaCotacao]');
    End;
  End;

End;

procedure TCotacao.pApaga_CopiaSeguranca(strAutInc: String);
  Var
    qryCotGer: TUniQuery;
Begin
  If fEmptyStr(strAutInc) Then
    Exit;

  qryCotGer := fCriaQuery;
  qryCotGer.SQL.Add(' UPDATE COTGER_RES SET COT_EXCLUI = "S" ');

  If Not FEmptyStr(strNumCot) Then
    qryCotGer.SQL.Add(', COT_NUMCOT ='+QuotedStr(strNumCot));

  qryCotGer.SQL.Add(' WHERE AUTOINCREM = :AUTINC;');
  qryCotGer.ParamByName('AUTINC').AsString := strAutInc;
  qryCotGer.ExecSQL;

  FreeAndNil(qryCotGer);
end;

procedure TCotacao.pLiberaCotacoes;
Var
  i: Integer;
begin
  If Assigned(FListaAutIncCotacao) Then
  Begin
    Try
      If FListaAutIncCotacao.Count > 0 Then
      Begin
        For i:=0 To FListaAutIncCotacao.Count-1 Do
        Begin
          fLock_Unlock(FListaAutIncCotacao[i], False, False);
        End;
      End;
    Finally
      FListaAutIncCotacao.Clear;
    End;
  End;
end;

procedure TCotacao.pLimpaPcmGerRes(ANumCot, ACodEmp: String);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  try
    qryComand.SQL.Add('UPDATE PCMGER_RES SET PCG_NUMCOT = NULL, PCG_EMPCOT = NULL');
    qryComand.SQL.Add(' WHERE PCG_NUMCOT = "'+ANumCot+'"');
    qryComand.SQL.Add('   AND PCG_EMPCOT = "'+ACodEmp+'"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
end;

procedure TCotacao.pLimpaRequisicao(strAutInc: String);
  Var
    qryReq: TUniQuery;
begin
  qryReq := fCriaQuery;
  Try
    qryReq.SQL.Add('UPDATE MOVRCD');
    qryReq.SQL.Add('   SET RCD_SEQCOT = NULL');
    qryReq.SQL.Add(' WHERE RCD_SEQCOT IN (SELECT ');
    qryReq.SQL.Add('                        AUTOINCREM');
    qryReq.SQL.Add('                      FROM');
    qryReq.SQL.Add('                        COTITE');
    qryReq.SQL.Add('                      WHERE');
    qryReq.SQL.Add('                        COT_SEQGER = :SEQGER)');
    qryReq.ParamByName('SEQGER').AsString := strAutInc;
    qryReq.ExecSQL;
  Finally
    FreeAndNil(qryReq);
  End;
end;

function TCotacao.fExcluiItensProgresso(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryItens: TUniQuery;
    intContador: Integer;
Begin
  Try
    qryItens := FCriaQuery;
    qryItens.SQL.Add('DELETE FROM COTITE WHERE COT_SEQGER = :SEQGER AND COT_CODITE = :CODITE; ');
    qryItens.SQL.Add('DELETE FROM COTFOR WHERE COT_SEQGER = :SEQGER AND COT_CODITE = :CODITE; ');

    If blnMulLoj Then
      qryItens.SQL.Add(' DELETE FROM PCDCOT WHERE PCD_SEQGER = :SEQGER AND PCD_CODITE = :CODITE; ');

    Result := True;

    pgbProgresso.Properties.Max := FExcluidos.Count;
    Application.ProcessMessages;

    For intContador := 0 To FExcluidos.Count - 1 Do
    Begin

      qryItens.Close;
      qryItens.ParamByName('SEQGER').AsString := strSeqGer;
      qryItens.ParamByName('CODITE').AsString := FExcluidos[intContador];
      qryItens.ExecSQL;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FreeAndNil(qryItens);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaExcluiProgresso]');
    End;
  End;
End;

Function TCotacao.fExcluiItens: Boolean;
  Var
    frmGravando2: TfrmGravando;
Begin
  Try
    Result := True;

    If FEsvaziouItens Then
    Begin
      pVeSeExcluiTodosItensCotacao;

      Exit;
    End
    Else If FLimpaRequisicao  And (opeOperac <> opIncluir) Then
      pLimpaRequisicao(strSeqGer);


    If FExcluidos.Count = 0 Then
      Exit;

    pCriarFormularios(TfrmGravando, frmGravando2);
    frmGravando2.lblGravando.Caption := 'Atualizando itens excluidos...';
    frmGravando2.fExecutarAcao := fExcluiItensProgresso;

    FfrmGravandoCorrente := frmGravando2;

    frmGravando2.ShowModal;

    Result := frmGravando2.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fExlcuiItens]');
    End;
  End;

  pFreeAndNilGravando(frmGravando2);
End;

function TCotacao.fExcluiItensCotacao_CopiaSeguranca(strCodIte: String; blnTodos: Boolean = False): Boolean;
var
  qryItens: TUniQuery;
begin
  Try
    qryItens := FCriaQuery;
    If ((strCodIte = '') and blnTodos) then
    Begin
      qryItens.SQL.Add('DELETE FROM COTITE_RES WHERE COT_SEQGER = :SEQGER; ');
      qryItens.SQL.Add('DELETE FROM COTFOR_RES WHERE COT_SEQGER = :SEQGER; ');
      If blnMulLoj Then
        qryItens.SQL.Add('DELETE FROM PCDCOT_RES WHERE PCD_SEQGER = :SEQGER; ');
    End
    Else
    Begin
      qryItens.SQL.Add('DELETE FROM COTITE_RES WHERE COT_SEQGER = :SEQGER AND COT_CODITE = :CODITE; ');
      qryItens.SQL.Add('DELETE FROM COTFOR_RES WHERE COT_SEQGER = :SEQGER AND COT_CODITE = :CODITE; ');
      If blnMulLoj Then
        qryItens.SQL.Add('DELETE FROM PCDCOT_RES WHERE PCD_SEQGER = :SEQGER AND PCD_CODITE = :CODITE; ');
      qryItens.ParamByName('CODITE').AsString := strCodIte;
    End;
    qryItens.ParamByName('SEQGER').AsString := strSeqGerBKP;
    qryItens.ExecSQL;

    Result := True;
    FreeAndNil(qryItens);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluiItensCotacao_CopiaSeguranca]');
    End;
  End;
end;

Function TCotacao.fGravaItens: Boolean;
  Var
    frmGravando2: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando2);
    frmGravando2.lblGravando.Caption := 'Gravando itens...';
    frmGravando2.fExecutarAcao := fGravaItensProgresso;

    FfrmGravandoCorrente := frmGravando2;

    frmGravando2.ShowModal;

    Result := frmGravando2.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fGravaItens]');
    End;
  End;

  pFreeAndNilGravando(frmGravando2);
End;

Function TCotacao.fSqlInsertItemDireto: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTITE (';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODITE, ';
  Result := Result + '   COT_QTDITE, ';
  Result := Result + '   COT_DESITE, ';
  Result := Result + '   COT_PJAATU, ';
  Result := Result + '   COT_FORMEN, ';
  Result := Result + '   COT_FORESC, ';
  Result := Result + '   COT_GERPED  ';

  Result := Result + ' ) VALUES ( ';
  Result := Result + '   :AUTINC, ';
  Result := Result + '   :SEQGER, ';
  Result := Result + '   :CODITE, ';
  Result := Result + '   :QTDITE, ';
  Result := Result + '   :DESITE, ';
  Result := Result + '   :PJAATU, ';
  Result := Result + '   :FORMEN, ';
  Result := Result + '   :FORESC, ';
  Result := Result + '   :GERPED) ';
End;

Function TCotacao.fSqlInsertItem: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTITE (';
  Result := Result + '   AUTOINCREM, ';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODITE, ';
  Result := Result + '   COT_QTDITE, ';
  Result := Result + '   COT_DESITE, ';
  Result := Result + '   COT_PJAATU, ';
  Result := Result + '   COT_FORMEN, ';
  Result := Result + '   COT_FORESC, ';
  Result := Result + '   COT_GERPED  ';

  Result := Result + ' ) VALUES ';
End;

Function TCotacao.fSqlUpdateItem(AstrAutIncCotIte,
                                 ADesite,
                                 APJAATU: string;
                                 AfltQtdIte: Double;
                                 AFORESC: string;
                                 AFORMEN: string;
                                 AGerPed: String): String;
Begin
  Result := '';
  Result := Result + ' UPDATE COTITE SET          ';
  Result := Result + '   COT_QTDITE = "'+ ReplaceStr(AfltQtdIte.ToString, ',', '.')+'",    ';
  Result := Result + '   COT_DESITE = "'+ ReplaceStr(ADesite, '"', '\"')+'", ';
  Result := Result + '   COT_PJAATU = "'+APJAATU+'",    ';
  Result := Result + '   COT_FORMEN = "'+AFORMEN+'",    ';
  Result := Result + '   COT_FORESC = "'+AFORESC+'",    ';
  Result := Result + '   COT_GERPED = "'+AGerPed+'"';
  Result := Result + ' WHERE AUTOINCREM = "'+AstrAutIncCotIte+'";';
End;

Function TCotacao.fSqlInsertItemFornecedor: String;
Begin
  Result := '';
  Result := Result + ' INSERT INTO COTFOR (';
  Result := Result + '   COT_SEQGER, ';
  Result := Result + '   COT_CODITE, ';
  Result := Result + '   COT_CODFOR, ';
  Result := Result + '   COT_VALUNI, ';
  Result := Result + '   COT_IPIENT, ';
  Result := Result + '   COT_FREENT, ';
  Result := Result + '   COT_UNITOT,  ';
  Result := Result + '   COT_SUBSTI, ';
  Result := Result + '   COT_ALQCBS, ';
  Result := Result + '   COT_ALQIBS, ';
  Result := Result + '   COT_ALQ_IS  ';
  Result := Result + ' ) VALUES ';
End;


Function TCotacao.fSqlUpdateItemFornecedor(AstrSeqGer,
                                           AFornec,
                                           ACODITE: String;
                                           AVALUNI,
                                           AUNITOT,
                                           AIPIENT,
                                           AFREENT,
                                           ASUBSTI,
                                           AAlqCbs,
                                           AAlqIbs,
                                           AAlq_Is: Double): String;
 Begin
   Result := '';
   Result := Result + ' UPDATE COTFOR SET ';
  Result := Result + '   COT_VALUNI = "'+ReplaceStr(AVALUNI.ToString, ',', '.')+'", ';
  Result := Result + '   COT_IPIENT = "'+ReplaceStr(AIPIENT.ToString, ',', '.')+'", ';
  Result := Result + '   COT_FREENT = "'+ReplaceStr(AFREENT.ToString, ',', '.')+'", ';
  Result := Result + '   COT_UNITOT = "'+ReplaceStr(AUNITOT.ToString, ',', '.')+'", ';
  Result := Result + '   COT_SUBSTI = "'+ReplaceStr(ASUBSTI.ToString, ',', '.')+'", ';
  Result := Result + '   COT_ALQCBS = ' + AnsiReplaceStr(FormatFloat('#0.0000', AAlqCbs), ',', '.') + ', ';
  Result := Result + '   COT_ALQIBS = ' + AnsiReplaceStr(FormatFloat('#0.0000', AAlqIbs), ',', '.') + ', ';
  Result := Result + '   COT_ALQ_IS = ' + AnsiReplaceStr(FormatFloat('#0.0000', AAlq_Is), ',', '.');
  Result := Result + ' WHERE ';
  Result := Result + '   COT_SEQGER = "'+AstrSeqGer+'" AND ';
  Result := Result + '   COT_CODITE = "'+ACODITE+'" AND ';
  Result := Result + '   COT_CODFOR = "'+AFornec+'";';
 End;
function TCotacao.fSQLPCDCOTDelete(ACODITE, ACODEMP,
  AstrSeqGer: String): String;
var
  strSQL: string;
begin
  strSQL := '';
  strSQL := strSQL + ' DELETE FROM PCDCOT WHERE ';
  strSQL := strSQL + '   PCD_SEQGER = "'+AstrSeqGer+'" AND ';
  strSQL := strSQL + '   PCD_CODITE = "'+ACODITE+'" AND ';
  strSQL := strSQL + '   PCD_EMPDES = "'+ACODEMP+'";';

  Result := strSQL;
end;

Function TCotacao.fSQLPCDCOTInsert: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO PCDCOT ';
  strSQL := strSQL + ' (                   ';
  strSQL := strSQL + ' PCD_SEQGER,         ';
  strSQL := strSQL + ' PCD_CODITE,         ';
  strSQL := strSQL + ' PCD_EMPDES,         ';
  strSQL := strSQL + ' PCD_QTDITE          ';
  strSQL := strSQL + ' ) VALUES            ';

  Result := strSQL;
end;

Function TCotacao.fSQLPCDCOTUpdate(ACODITE: String;
                                   ACODEMP: String;
                                   AQTDITE: Double;
                                   AstrSeqGer: String): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE PCDCOT SET          ';
  strSQL := strSQL + '   PCD_QTDITE = "'+ReplaceStr(AQTDITE.ToString, ',', '.') + '"' ;
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   PCD_SEQGER = "'+AstrSeqGer+'" AND ';
  strSQL := strSQL + '   PCD_CODITE = "'+ACODITE+'" AND ';
  strSQL := strSQL + '   PCD_EMPDES = "'+ACODEMP+'";';

  Result := strSQL;
end;

Function TCotacao.fGravaPcdDetCot: Boolean;
  Var
    frmGravando2: TfrmGravando;
Begin
  Result := True;

  If Not Assigned(cdsItensMultiLojas) Then
    Exit;

  If blnDesmembraCotacao Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando2);
    frmGravando2.lblGravando.Caption := 'Gravando quantidade de itens por loja...';
    frmGravando2.fExecutarAcao := fGravaPcdDetCotItem;

    FfrmGravandoCorrente := frmGravando2;

    frmGravando2.ShowModal;

    Result := frmGravando2.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fGravaPcdDetCot]');
    End;
  End;

  pFreeAndNilGravando(frmGravando2);
End;

Function TCotacao.fGravaPcdDetCotItem(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryPcdCot,
    qryPcdCotSQL: TUniQuery;
    sltListaInsert: TStringList;
    strInsert: String;

    Procedure pInsertLotePCDCOT;
    Begin
      If sltListaInsert.Count > 0 Then
      Begin
        qryPcdCot.SQL.Text := fSQLPCDCOTInsert;
        qryPcdCot.SQL.Add(sltListaInsert.Text);
        qryPcdCot.ExecSQL;
        sltListaInsert.Clear;
      End;
    End;

Begin
  qryPcdCot := fCriaQuery;
  qryPcdCotSQL := fCriaQuery;

  With cdsItensMultiLojas Do
  Begin
    cdsItensMultiLojas.DisableControls;
    sltListaInsert := TStringList.Create;

    If opeOperac = opAlterar Then
    Begin
      cdsItensMultiLojas.Filter    := 'ITE_ALTERA = ' + QuotedStr('S') + ' AND (ITE_QTDITE > 0 OR ITE_ALTERA = ' + QuotedStr('S') + ')' ;
      Filtered  := True;
    End

    Else
    Begin
      Filter    := 'ITE_QTDITE > 0' ;
      Filtered  := True;
    End;

    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    cdsItensMultiLojas.First;

    While Not cdsItensMultiLojas.Eof Do
    Begin
      qryPcdCot.Close;

      If fEmptyStr(FieldByName('ITE_SEQCOT').AsString) Then
      Begin
        If (FieldByName('ITE_QTDITE').AsFloat) > 0 Then
        Begin
          strInsert := '(' + QuotedStr(strSeqGer) + ', ' +
                             QuotedStr(FieldByName('ITE_CODITE').AsString) + ', ' +
                             QuotedStr(FieldByName('ITE_CODEMP').AsString) + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('ITE_QTDITE').AsFloat), ',', '.') +
                        ')';

          If sltListaInsert.Count = 0 Then
            sltListaInsert.Add(strInsert)
          Else
            sltListaInsert.Add(', ' + strInsert);
        End;
      End Else
      Begin
        qryPcdCotSQL.SQL.Add(fSQLPCDCOTUpdate(FieldByName('ITE_CODITE').AsString,
                                            FieldByName('ITE_CODEMP').AsString,
                                            FieldByName('ITE_QTDITE').AsFloat,
                                            strSeqGer));
      End;

      If sltListaInsert.Count > 1000 Then
        pInsertLotePCDCOT;

      If qryPcdCotSQL.SQL.Count > 500 Then
      Begin
        qryPcdCotSQL.ExecSQL;
        qryPcdCotSQL.SQL.Clear;
      End;

      cdsItensMultiLojas.Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    pInsertLotePCDCOT;
    If qryPcdCotSQL.SQL.Count > 0 Then
      qryPcdCotSQL.ExecSQL;

    cdsItensMultiLojas.EnableControls;

  End;

  sltListaInsert.Clear;
  FreeAndNil(sltListaInsert);

  FreeAndNil(qryPcdCot);
  FreeAndNil(qryPcdCotSQL);

  cdsItensMultiLojas.Filtered := False;

  Result := True;
End;

function TCotacao.fRetGerPed(strCodIte: String): String;
  Var
    intIndex: Integer;
Begin
  If FItensGerados.Find(strCodIte, intIndex) Then
    Result := 'S'
  Else
    Result := cdsItens.FieldByName('GERPED').AsString;

  If Pos(Result, 'S_N') = 0 Then
    Result := 'N';
End;

function TCotacao.fGravaItensProgresso(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryItens: TUniQuery;
    qryItemFornecedor,
    qrySqlUpdateItem: TUniQuery;
    strEmpFis,
    strInsert,
    strSeqReq,
    strAutIncCotIte: String;
    sltListaCotIte: TStringList;
    sltListaCotFor: TStringList;
    blnExecuta: Boolean;

    arrRequisicoes: TStringArray;

    Procedure pInsertLoteItem;
    Begin
      If sltListaCotIte.Count > 0 Then
      Begin
        qryItens.SQL.Clear;
        qryItens.SQL.add(fSqlInsertItem);
        qryItens.SQL.Add(sltListaCotIte.Text + ';');

        qryItens.ExecSQL;
        sltListaCotIte.Clear;
      End;
    End;

    Procedure pGravaItem(blnGravarDireto: Boolean);
      Var
        fltQtdIte: Double;
    Begin
      With cdsItens Do
      Begin
        qryItens.Close;

        blnExecuta := False;

        If blnDesmembraCotacao Then
          fltQtdIte := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat
        Else
          fltQtdIte := FieldByName('QTDITE').AsFloat;

        If blnDesmembraCotacao Or fEmptyStr(FieldByName('AUTCOT').AsString) Then
        Begin

          If blnGravarDireto Then
          Begin
            pInsertLoteItem;

            strAutIncCotIte := fRetAutoIncrem('COTITE', VS_strCodEmp);
            qryItens.SQL.Text := fSqlInsertItemDireto;
            qryItens.ParamByName('SEQGER').AsString := strSeqGer;
            qryItens.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;

            blnExecuta := True;

          End Else
          Begin
            strAutIncCotIte := fRetAutoIncrem('COTITE', VS_strCodEmp);

            strInsert := '( '+
                            QuotedStr(strAutIncCotIte)  + ', ' +
                            QuotedStr(strSeqGer) + ', ' +
                            QuotedStr(FieldByName('CODITE').AsString) + ', ' +
                            AnsiReplaceStr(FormatFloat('#0.0000', fltQtdIte), ',', '.') + ', ' +
                            '"'+ReplaceStr(FieldByName('DESITE').AsString, '"', '\"')+'", '+
                            QuotedStr(FieldByName('PJAATU').AsString) + ', ' +
                            QuotedStr(FieldByName('FORMEN').AsString) + ', ' +
                            QuotedStr(FieldByName('FORESC').AsString) + ', ' +
                            QuotedStr(fRetGerPed(FieldByName('CODITE').AsString)) +
                          ')';

            If sltListaCotIte.Count = 0 Then
              sltListaCotIte.Add(strInsert)
            Else
              sltListaCotIte.Add(', ' + strInsert);

          End;

        End Else
        Begin
          strAutIncCotIte := FieldByName('AUTCOT').AsString;
          qrySqlUpdateItem.SQL.Add(fSqlUpdateItem(strAutIncCotIte,
                                                  FieldByName('DESITE').AsString,
                                                  FieldByName('PJAATU').AsString,
                                                  fltQtdIte,
                                                  FieldByName('FORESC').AsString,
                                                  FieldByName('FORMEN').AsString,
                                                  fRetGerPed(FieldByName('CODITE').AsString)));

          If qrySqlUpdateItem.SQL.Count > 500 Then
          Begin
            qrySqlUpdateItem.ExecSQL;
            qrySqlUpdateItem.SQL.Clear;
          End;

        End;
        If blnExecuta Then
        Begin
          qryItens.ParamByName('AUTINC').AsString := strAutIncCotIte;
          qryItens.ParamByName('DESITE').AsString := FieldByName('DESITE').AsString;
          qryItens.ParamByName('PJAATU').AsString := FieldByName('PJAATU').AsString;
          qryItens.ParamByName('QTDITE').AsFloat  := fltQtdIte;
          qryItens.ParamByName('FORESC').AsString := FieldByName('FORESC').AsString;
          qryItens.ParamByName('FORMEN').AsString := FieldByName('FORMEN').AsString;
          qryItens.ParamByName('GERPED').AsString := fRetGerPed(FieldByName('CODITE').AsString);

          qryItens.ExecSQL;
        End;

      End;
    End;

    function fRetInsertItemFonecValues(stlLista: TStringList): string;
     var i: integer;
    Begin
      Result := '';

      For i := 0 To stlLista.Count - 1 Do
      Begin
        If pos(STR_NAO_UTILIZADO, stlLista.Strings[i]) = 0 Then
          Result := Result + stlLista.Strings[i];
      End;

      If (Length(Result) > 0) And (Result[1] = ',') Then
        Result := Copy(Result, 2, Length(Result));
    End;

    Procedure pInsertLoteItemFornecedor;
      Var
        strItens: String;
    Begin
      If sltListaCotFor.Count > 0 Then
      Begin
        strItens := fRetInsertItemFonecValues(sltListaCotFor);

        If Not strItens.IsEmpty Then
        Begin
          qryItens.SQL.Text := fSqlInsertItemFornecedor;
          qryItens.SQL.Add(strItens);

          qryItens.SQL.Add(' ON DUPLICATE KEY UPDATE ');
          qryItens.SQL.Add('   COT_VALUNI = VALUES(COT_VALUNI), ');
          qryItens.SQL.Add('   COT_IPIENT = VALUES(COT_IPIENT), ');
          qryItens.SQL.Add('   COT_FREENT = VALUES(COT_FREENT), ');
          qryItens.SQL.Add('   COT_UNITOT = VALUES(COT_UNITOT), ');
          qryItens.SQL.Add('   COT_SUBSTI = VALUES(COT_SUBSTI), ');
          qryItens.SQL.Add('   COT_ALQCBS = VALUES(COT_ALQCBS), ');
          qryItens.SQL.Add('   COT_ALQIBS = VALUES(COT_ALQIBS), ');
          qryItens.SQL.Add('   COT_ALQ_IS = VALUES(COT_ALQ_IS); ');

          qryItens.ExecSQL;
        End;

        sltListaCotFor.Clear;
      End;
    End;

    Procedure pGravaItemFornecedor;
      Var
        intContador: Integer;
    Begin
      With cdsItens Do
      For intContador := Low(arrCodFor) To High(arrCodFor) Do
      If fFornecedorValido(intContador) Then
      Begin
        qryItens.Close;

        If blnDesmembraCotacao Or fEmptyStr(cdsItens.FieldByName('CODFOR' + fIndice(intContador)).AsString) Then
        Begin

          strInsert := '(' + QuotedStr(strSeqGer) + ', ' +
                             QuotedStr(FieldByName('CODITE').AsString) + ', ' +
                             QuotedStr(arrCodFor[intContador]) + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('VALUNI' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('IPIENT' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('FREENT' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('UNITOT' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('SUBSTI' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('ALQCBS' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('ALQIBS' + fIndice(intContador)).AsFloat), ',', '.') + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('ALQ_IS' + fIndice(intContador)).AsFloat), ',', '.') +
                        ')';

          If sltListaCotFor.Count = 0 Then
            sltListaCotFor.Add(strInsert)
          Else
            sltListaCotFor.Add(', ' + strInsert);

        End Else
        Begin
          qryItemFornecedor.SQL.Add(fSqlUpdateItemFornecedor(strSeqGer,
                                                             arrCodFor[intContador],
                                                             FieldByName('CODITE').AsString,
                                                             FieldByName('VALUNI' + fIndice(intContador)).AsFloat,
                                                             FieldByName('UNITOT' + fIndice(intContador)).AsFloat,
                                                             FieldByName('IPIENT' + fIndice(intContador)).AsFloat,
                                                             FieldByName('FREENT' + fIndice(intContador)).AsFloat,
                                                             FieldByName('SUBSTI' + fIndice(intContador)).AsFloat,
                                                             FieldByName('ALQCBS' + fIndice(intContador)).AsFloat,
                                                             FieldByName('ALQIBS' + fIndice(intContador)).AsFloat,
                                                             FieldByName('ALQ_IS' + fIndice(intContador)).AsFloat));

          If qryItemFornecedor.SQL.Count > 500 Then
          begin
            qryItemFornecedor.ExecSQL;
            qryItemFornecedor.SQL.Clear;
          End;
        End;
      End;
    End;


Begin
  With cdsItens Do
  Try
    If Assigned(cdsItensMultiLojas) Then
      cdsItensMultiLojas.DisableControls;
    DisableControls;

    sltListaCotFor := TStringList.Create;
    sltListaCotIte := TStringList.Create;
    qrySqlUpdateItem := fCriaQuery;
    qryItemFornecedor:= fCriaQuery;
    strEmpFis      := fRetEmpresaFisica;

    pSetaEventosItem(False, True, True, False);

    qryItens   := fCriaQuery;

    If blnDesmembraCotacao Then
    Begin
      Filtered := False;
    End Else
    Begin
      Filter   := 'ALTERADO = ' + QuotedStr('S');
      Filtered := True;
    End;

    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    cdsItens.First;

    If blnDeveExcluirCOTFOR Then
    Begin
      qryItens.SQL.Add('DELETE FROM COTFOR WHERE COT_SEQGER = "'+strSeqGer+'"');
      qryItens.ExecSQL;
      qryItens.SQL.Clear;
    End;


    While Not Eof Do
    Begin

      If (Not blnDesmembraCotacao) Or (cdsItensMultiLojas.Locate('ITE_CODITE', FieldByName('CODITE').AsString, [])) Then
      Begin
        arrRequisicoes := fGetRequisicoes(FieldByName('CODITE').AsString);

        pGravaItem(Length(arrRequisicoes) > 0);

        pGravaItemFornecedor;

        For strSeqReq In arrRequisicoes Do
          pAtuRequisicao(strAutIncCotIte, strSeqReq);

        SetLength(arrRequisicoes, 0);
      End;

      Next;

      If sltListaCotIte.Count > 1000 Then
        pInsertLoteItem;

      If sltListaCotFor.Count > 1000 Then
        pInsertLoteItemFornecedor;

       pgbProgresso.Position := pgbProgresso.Position + 1;
       Application.ProcessMessages;
    End;

    pInsertLoteItem;
    pInsertLoteItemFornecedor;
    If qrySqlUpdateItem.SQL.Count > 0 Then
      qrySqlUpdateItem.ExecSQL;
    If qryItemFornecedor.SQL.Count > 0 Then
      qryItemFornecedor.ExecSQL;

    Result := True;
    FreeAndNil(qryItens);
    FreeAndNil(sltListaCotFor);
    FreeAndNil(sltListaCotIte);
    FreeAndNil(qrySqlUpdateItem);
    FreeAndNil(qryItemFornecedor);

    If Assigned(cdsItensMultiLojas) Then
      cdsItensMultiLojas.EnableControls;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaItensProgresso]');
    End;
  End;

  cdsItens.Filtered := False;

  pEnableControlsItens;

  pSetaEventosItem(True, True, True, False);
End;

procedure TCotacao.pIncluiPcmIrq(strAutIncPcd, strCodIte: String);
  Var
    strAutIncReq: String;
    qryPcmIrq: TUniQuery;


  procedure pInsere(strSeqReq: String);
  Begin
    qryPcmIrq.ParamByName('SEQDET').AsString := strAutIncPcd;
    qryPcmIrq.ParamByName('SEQREQ').AsString := strSeqReq;
    qryPcmIrq.ExecSQL;
  End;

begin
  qryPcmIrq := fCriaQuery;

  Try
    qryPcmIrq.SQL.Add('INSERT INTO PCMIRQ(');
    qryPcmIrq.SQL.Add('  PCM_SEQDET,');
    qryPcmIrq.SQL.Add('  PCM_SEQREQ');
    qryPcmIrq.SQL.Add(') VALUES (');
    qryPcmIrq.SQL.Add('  :SEQDET,');
    qryPcmIrq.SQL.Add('  :SEQREQ); ');
    qryPcmIrq.SQL.Add('UPDATE MOVRCD SET RCD_SEQPCD = :SEQDET WHERE AUTOINCREM = :SEQREQ;');

    For strAutIncReq In fGetRequisicoes(strCodIte) Do
      pInsere(strAutIncReq);
  Finally
    FreeAndNil(qryPcmIrq);
  End;

end;

function TCotacao.fGetRequisicoes(strCodIte: String; blnCodigo: Boolean = False; blnGetEmp: Boolean = False): TStringArray;
  Var
    intPos: Integer;
    strFilter: String;
    blnFiltered: Boolean;
begin
  SetLength(Result, 0);
  strFilter := '';
  blnFiltered := False;

  With objRequisicao.cdsRequisicao Do
  Begin
    If Not Active Then
      Exit;

    intPos := RecNo;
    If Filtered Then
    Begin
      strFilter := Filter;
      blnFiltered := True;
    End;

    Try
      Filter := 'CODITE = '+ QuotedStr(strCodIte) + ' AND ' + 'MARDES = 1';
      Filtered := True;

      IndexFieldNames := 'CODEMP';

      SetLength(Result, RecordCount);

      First;
      While Not Eof Do
      Begin
        If blnCodigo Then
          Result[RecNo-1] := FieldByName('CODREQ').AsString + IIF(blnGetEmp, '-' + FieldByName('CODEMP').AsString,'')
        Else
          Result[RecNo-1] := FieldByName('AUTOINCREM').AsString + IIF(blnGetEmp, '-' + FieldByName('CODEMP').AsString,'');

        Next;
      End;

    Finally
      Filtered := False;
      Filter := '';
      If blnFiltered Then
      Begin
        Filter := strFilter;
        Filtered := True;
      End;
      RecNo := intPos;
    End;

  End;
end;

function TCotacao.fGetRequisicoesFormatado(strCodIte: String): String;
  Var
    strReq: String;
begin
  For strReq In fGetRequisicoes(strCodIte, True, True) Do
    Result := Result + IIF(fEmptyStr(Result), '', ', ') + strReq;
end;

procedure TCotacao.pAtuRequisicao(strCot_SeqCot, strCot_SeqReq: String);
  Var
    qryReq: TUniQuery;
begin
  qryReq := fCriaQuery;
  Try
    qryReq.SQL.Add('UPDATE MOVRCD');
    qryReq.SQL.Add('   SET RCD_SEQCOT = :SEQCOT');
    qryReq.SQL.Add(' WHERE AUTOINCREM = :SEQREQ');
    qryReq.ParamByName('SEQCOT').AsString := strCot_SeqCot;
    qryReq.ParamByName('SEQREQ').AsString := strCot_SeqReq;
    qryReq.ExecSQL;
  Finally
    FreeAndNil(qryReq);
  End;
end;

Function TCotacao.fImportaRequisicao(strCodComprador: string): Boolean;
Var
  strIncMovRcd: String;
  intPos,
  intIndex: Integer;

  Procedure pFiltraMultiLoja;
    Var
      strFiltro: String;
  Begin
    strFiltro := 'ITE_CODITE = ' +  QuotedStr(cdsItens.FieldByName('CODITE').AsString);

    If strFiltro <> cdsItensMultiLojas.Filter Then
      cdsItensMultiLojas.Filter := strFiltro;

    If Not cdsItensMultiLojas.Filtered Then
      cdsItensMultiLojas.Filtered := True;

    cdsDigMultLoja.pVeSeIncluiItemMultiLoja(cdsItens.FieldByName('CODITE').AsString);
  End;

  Procedure pAdicionarItemMultiLoja;
    Var
      blnAdiciona: Boolean;
  Begin
    blnAdiciona := False;

    pFiltraMultiLoja;

    objRequisicao.cdsRequisicao.IndexFieldNames := 'CODEMP';

    If cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              objRequisicao.cdsRequisicao.FieldByName('CODEMP').AsString]), []) Then
      blnAdiciona := True

    {Else If (Not fEmptyStr(recOpcGir.strEmpAgr)) And
       cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              recOpcGir.strEmpAgr]), []) Then
      blnAdiciona := True}

    Else If cdsItensMultiLojas.Locate('ITE_CODITE;ITE_CODEMP',
                                  VarArrayOf([objRequisicao.cdsRequisicao.FieldByName('CODITE').AsString,
                                              VS_strCodEmp]), []) Then
      blnAdiciona := True

    Else If Not cdsItensMultiLojas.IsEmpty Then
    Begin
      cdsItensMultiLojas.First;
      blnAdiciona := True
    End;

    If blnAdiciona Then
    Begin
      cdsItensMultiLojas.Edit;
      cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat +
                                                                objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat / IIf(cdsItens.FieldByName('EMBALA').AsFloat = 0, 1, cdsItens.FieldByName('EMBALA').AsFloat);

      If fEmptyStr(cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString) Then
      Begin
        cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString := objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;
      End

      Else If (Pos(strIncMovRcd, cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString) = 0) Then
      Begin
        cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString :=
           cdsItensMultiLojas.FieldByName('ITE_INCIRQ').AsString + ',' + objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;

      End;

      cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat  := cdsItensMultiLojas.FieldByName('ITE_QTDREQ').AsFloat +
                                                                 objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat;

      cdsItensMultiLojas.Post;

      objRequisicao.cdsRequisicao.Edit;
      objRequisicao.cdsRequisicao.FieldByName('EMPDES').AsString := cdsItensMultiLojas.FieldByName('ITE_CODEMP').AsString;
      objRequisicao.cdsRequisicao.Post;
    End;

  End;

begin

  If Not Assigned(FListaAutIncCotacao) Then
    FListaAutIncCotacao := TStringList.Create;

  pTiraAfterScrollItens;
  pSetaEventosItem(False);
  If Assigned(cdsDigMultLoja) Then
    cdsDigMultLoja.desvinculaCDS;
  Try
    Result := False;

    pCriarFormularios(TfrmCadCotItensImpRequisicao, frmCadCotItensImpRequisicao);
    frmCadCotItensImpRequisicao.pImprimeDocumento := pImprimeDocumento;
    frmCadCotItensImpRequisicao.btnAssPedCom.Visible := False;
    frmCadCotItensImpRequisicao.pnlLegendas.Visible := False;
    frmCadCotItensImpRequisicao.btnNegar.Visible  := True;
    objRequisicao.strCodCmp := strCodComprador;
    frmCadCotItensImpRequisicao.objRequisicao := objRequisicao;

    pMarcaRequisicao;

    If frmCadCotItensImpRequisicao.ShowModal = mrOk Then
    Begin
      // Solicitacao do **Req 189885
      // Não remover os itens ao inserir requisição

     pExcluiTodosItensRequisicaoDataSet;
      {
      pRetiraItensDaListaConsulta;
      pExcluiTodosItensDataSet;

      While not cdsFornecedores.IsEmpty Do
      Begin
        cdsFornecedores.Delete;

      End;

      pAtualizaArrFornecedores;
      }

      FListaAutIncCotacao.Clear;

      With objRequisicao.cdsRequisicao Do
      Begin

        intPos := RecNo;
        Filter := 'MARDES = 1';
        Filtered := True;

        IndexFieldNames := 'CODEMP';

        First;
        While Not Eof Do
        Begin
          If FieldByName('MARDES').AsInteger > 0 Then
            fIncluiFornecedor(FieldByName('CODFOR').AsString, FieldByName('NOMFOR').AsString);

          Next;
        End;

        First;
        While Not Eof Do
        Begin
          If (FieldByName('MARDES').AsInteger > 0) And
             fCarregaItem(FieldByName('CODITE').AsString, False, True) Then
          Begin

            If Not FListaAutIncCotacao.Find(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString), intIndex) Then
              FListaAutIncCotacao.Add(objRequisicao.fRetChaveSelecao(objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString));

            fIncluiItem(FieldByName('CODITE').AsString,
                        FieldByName('DESITE').AsString,
                        FieldByName('QTDITE').AsFloat,
                        0,
                        0,
                        0,
                        True,
                        False,
                        0,
                        objRequisicao.cdsRequisicao.FieldByName('QTDITE').AsFloat);
            pIncluiNaListaConsulta(FieldByName('CODITE').AsString);
            //INCLUIR COPIA DE SEGURANÇA
            fIncluir_CopiaSeguranca;

            If (blnMulLoj) Then
            Begin
              strIncMovRcd := '';
              strIncMovRcd := objRequisicao.cdsRequisicao.FieldByName('AUTOINCREM').AsString;

              If (Not Assigned(cdsDigMultLoja)) Then
                pAncoraPainelGiro(True);

              pAdicionarItemMultiLoja;
            End;

          End;

          Next;
        End;

        Filtered := False;
        Filter := '';
        RecNo := intPos;
      End;

      Result := objRequisicao.fNegaRequisicoesMotivoNaoVaiComprar(objRequisicao.cdsRequisicao, True) And
                objRequisicao.fNegaRequisicoesMotivoPossuiEstoque(objRequisicao.cdsRequisicao, True);

    End;

    pFreeAndNil(frmCadCotItensImpRequisicao);
  Finally
    pSetaAfterScrollItensGiro;
    pSetaEventosItem(True);

    If Assigned(cdsDigMultLoja) Then
      cdsDigMultLoja.vinculaCDS;

  End
end;

Procedure TCotacao.pLoadFuncoesPedido;
Begin
  pSetLiberacao( TLiberacao.Create );
End;

procedure TCotacao.pCentralizaCamposMultLoja;
Begin
  If Assigned(cdsItensMultiLojas) Then
  With cdsItensMultiLojas Do
  If Active Then
  Begin
    FieldByName('ITE_CODEMP').Alignment := taCenter;
    FieldByName('ITE_FORULT').Alignment := taCenter;
    FieldByName('ITE_DTAULT').Alignment := taCenter;
    FieldByName('ITE_DTAUVE').Alignment := taCenter;

    IndexFieldNames := 'ITE_CODITE';
  End;
End;

procedure TCotacao.pSetaMultiLojas(blnEdicao: Boolean);
Begin
  If blnEdicao Then
    blnMulLoj := Assigned(frmCadCotacaoGeralCX) And (frmCadCotacaoGeralCX.dbeMulLoj.Checked)
  Else
    blnMulLoj := (FieldByName('COT_MULLOJ').AsString = 'S');

  If blnMulLoj Then
    recDadGiro.strPedMlj := 'S'
  Else
    recDadGiro.strPedMlj := 'N';

  If blnMulLoj And (Not Assigned(cdsItensMultiLojas)) Then
  Begin

    If recDadGiro.intMesGir > recDadGiro.intMesMos Then
    Begin

      If fCfgSis('MESGIR', VarInteger) = 1 Then
        recDadGiro.intMesMos := 12
      Else
        recDadGiro.intMesMos := recDadGiro.intMesGir;

    End;

    cdsItensMultiLojas := fCriaDatasetPedido(recDadGiro.intMesMos, arrCampos, arrCamposAgg, frmCadCotacaoGeralCX);

    dtsItensMultiLojas := TDataSource.Create(Self);
    dtsItensMultiLojas.DataSet := cdsItensMultiLojas;

    pCentralizaCamposMultLoja;
  End;

  If Assigned(frmCadCotacaoGeralCX) Then
  With frmCadCotacaoGeralCX Do
  Begin
    edtQtdIte.ReadOnly := blnMulLoj;
    cxbItensQTDITE.Options.Editing := Not blnMulLoj;
  End;

  pAncoraPainelGiro;
End;

procedure TCotacao.pConsultaAfterScrollItensRequisicoes;
  Var
    strReq: String;
begin
  With frmCadCotacaoGeralCX Do
  Begin
    lblReq.Visible := False;
    lblReq.Caption := '';

    If Not (cdsItens.State In dsEditModes) Then
    Begin
      strReq := fGetRequisicoesFormatado(cdsItens.FieldByName('CODITE').AsString);
      If Not fEmptyStr(strReq) Then
      Begin
        lblReq.Caption := 'Requisições: '+ strReq;
        lblReq.Visible := True;
      End;
    End;

    With cdsItens Do
    btnSimilares.Visible := (FindField('CODSIM') <> NIl ) And (Not fEmptyStr(FieldByName('CODSIM').AsString));
  End;
end;

procedure TCotacao.pAfterScrollItensGiro(DataSet: TDataSet);
  Var
    blnRodape: Boolean;
Begin
  If DataSet.ControlsDisabled Then
    Exit;

  If Assigned(frmCadCotacaoGeralCX) Then
  With frmCadCotacaoGeralCX Do
  If ((pagCotacao.ActivePage = TabItens) Or
      (pagCotacao.ActivePage = TabComparativo)) Then
  Begin
    If pagCotacao.ActivePage = TabItens Then
      pConsultaAfterScrollItensRequisicoes
    Else
      With cdsItens Do
        btnSimilaresComparativo.Visible := (FindField('CODSIM') <> NIl ) And (Not fEmptyStr(FieldByName('CODSIM').AsString));

    If recDadGiro.strPedMlj = 'S' Then
    Begin
      If Assigned(cdsItensMultiLojas) Then
      Begin
        If Assigned(cdsDigMultLoja) Then
          cdsDigMultLoja.FDesIte := cdsItens.FieldByName('DESITE').AsString;

        cdsItensMultiLojas.Filter   := 'ITE_CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString);
        cdsItensMultiLojas.Filtered := True;
      End;
    End Else
    Begin

      If Not cdsItensGiro.IsEmpty Then
      Begin
        blnRodape := cdsItensGiro.Locate('ITE_CODITE', cdsItens.FieldByName('CODITE').AsString, []);

        If (pagCotacao.ActivePage = TabItens) Then
        Begin

          If (blnRodape <> pnlGiro.Visible) Then
          Begin
            pnlGiro.Visible := blnRodape;
            pPosicionaPanelGiroItens;
          End;

        End Else
        Begin

          If (blnRodape <> pnlGiroComparativo.Visible) Then
          Begin
            pnlGiroComparativo.Visible := blnRodape;
          End;


        End;

      End;


    End;

    If Assigned(frmTelaGiroUma) Then
      frmTelaGiroUma.pAtualizaDadosUmaLoja(cdsItens.FieldByName('CODITE').AsString);
  End;
End;

procedure TCotacao.pMascaraGiro;
Begin
  With RecDadGiro do
  If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
  Begin
    pMascaraCamposGiro(cdsItensGiro, intMesMos);
  End;
End;

procedure TCotacao.pAfterPostItens(DataSet: TDataSet);
begin
  If Assigned(frmCadCotacaoGeralCX) And (State = dsInsert) then
  Begin
    frmCadCotacaoGeralCX.dbeMulLoj.ReadOnly := Not cdsItens.IsEmpty;
  End;

  If Not fEmptyStr(DataSet.FieldByName('CODSIM').AsString) Then
  Begin
    If DataSet.FieldByName('PRISIM').AsString = 'S' Then
    Begin
      pEditarSimilar(
        DataSet.FieldByName('CODITE').AsString,
        DataSet.FieldByName('CODSIM').AsString,
        DataSet.FieldByName('QTDITE').AsCurrency,
        DataSet.FieldByName('EXCLUI').AsString);
    End;
  End;
end;

Procedure TCotacao.pAncoraPainelGiro(blnTestarMultLoja: Boolean = False);
  Var
    cdsItensGridRodape: TUniClientDataSet;
    blnPosicionaPainel: Boolean;
Begin
  With frmCadCotacaoGeralCX Do
  Begin
    blnPosicionaPainel := Not pnlGiro.Visible;

    If (recDadGiro.blnUsaGiro) Or (blnTestarMultLoja And (recDadGiro.strPedMlj = 'S')) Then
    Begin
      If recDadGiro.strPedMlj = 'S' Then
        cdsItensGridRodape := cdsItensMultiLojas
      Else
        cdsItensGridRodape := cdsItensGiro;

      If Not Assigned(cdsDigMultLoja) Then
      Begin
        pMascaraGiro;
        cdsDigMultLoja := TCdsDigMultLoja.Create(Nil,
                                                 cdsItensGridRodape,
                                                 cdsItensGiro,
                                                 recDadGiro,
                                                 pnlGiro,
                                                 recDadGiro.blnUsaGiro,
                                                 pAfterPostItens,
                                                 Nil, {pAtualizaMesesP}
                                                 Nil, {PcddetAfterPost}
                                                 True {blnCotacao},
                                                 nil,
                                                 pAtualizaCdsCotacao);

        cdsDigMultLoja.pAncora(False, True, Nil);
      End;

    End;

    If blnPosicionaPainel And pnlGiro.Visible Then
    begin
      pPosicionaPanelGiroItens;
    End;
  End;
End;

procedure TCotacao.pPosicionaPanelGiroItens;
Begin
  With frmCadCotacaoGeralCX Do
  Begin
    splGiro.Visible := pnlGiro.Visible And (recDadGiro.strPedMlj = 'S');
    pnlGiro.Top     := pnlBotoesItens.Top - 20;
    splGiro.Top     := pnlGiro.Top - 2;

    pnlBotoesItens.Top := pnlGiro.Top + pnlGiro.Height;
  End;
End;

procedure TCotacao.pInicializaGiro;
Begin
  With recDadGiro Do
  Begin
    intMesGir     := FieldByName('COT_MESGIR').AsInteger;
//    intMesMos     := FieldByName('COT_MESMOS').AsInteger;
    strMeses      := FieldByName('COT_MESSEL').AsString;
    blnConsMesAtu := FieldByName('COT_MESATU').AsString = 'S';

    If fCfgSis('MESGIR', VarInteger) = 1 Then
      recDadGiro.intMesMos := 12
    Else
      recDadGiro.intMesMos := recDadGiro.intMesGir;

    If fEmptyStr(strMeses) Then
      strMeses := fMontaStrMeses(intMesMos);
  End;
End;

Procedure TCotacao.pIncluiItemGiroSintetizado(blnDisableControls: Boolean; strCodIte: String);
var
  strFilter: String;
Begin
  If Assigned(cdsItensMultiLojas) And Assigned(cdsItensGiro) And cdsItensGiro.Active Then
  With cdsItensMultiLojas Do
  Begin
    If blnDisableControls Then
      DisableControls;

    strFilter := '';
    If cdsItensMultiLojas.Filtered Then
    Begin
      strFilter := cdsItensMultiLojas.Filter;
      cdsItensMultiLojas.Filtered := False;
    End;

    If Locate('ITE_CODITE', strCodIte, []) Then
    Begin
      cdsItensGiro.Insert;
      cdsItensGiro.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      cdsItensGiro.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
      cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat  := 0;
      cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat  := 0;
      cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat  := 0;
      cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat  := 0;

      While (Not Eof) And (cdsItensGiro.FieldByName('ITE_CODITE').AsString = FieldByName('ITE_CODITE').AsString) Do
      Begin
        cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat := cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat + FieldByName('ITE_MEDIA_').AsFloat;
        cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat + FieldByName('ITE_SALDOS').AsFloat;
        cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat + FieldByName('ITE_SALDIS').AsFloat;
        cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat := cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat + FieldByName('ITE_QTDITE').AsFloat;
        cdsItensGiro.FieldByName('ITE_SALFIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALFIS').AsFloat + FieldByName('ITE_SALFIS').AsFloat;

        Next;
      End;

      If cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat > 0 Then
      Begin
        cdsItensGiro.FieldByName('ITE_DIAEST').AsInteger := Trunc(cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat /
                                                             (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30));

        cdsItensGiro.FieldByName('ITE_DIASUG').AsInteger := Trunc((cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat +
                                                                   cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat) /
                                                             (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30))
      End Else
      Begin
        cdsItensGiro.FieldByName('ITE_DIAEST').Clear;
        cdsItensGiro.FieldByName('ITE_DIASUG').Clear;
      End;

      cdsItensGiro.Post;
    End;

  //  Edit;

    If strFilter <> '' Then
    Begin
      cdsItensMultiLojas.Filter := strFilter;
      cdsItensMultiLojas.Filtered := True;
    End;

    If blnDisableControls Then
      EnableControls;
  End;
End;

procedure TCotacao.pIncluiListaFornecApi(ACodFor: string);
begin
  FFornecApi.Add(ACodFor);
end;

procedure TCotacao.pRemoveListaFornecApi(ACodFor: string);
var i: integer;
begin
  If FFornecApi.Find(ACodFor, i) Then
    FFornecApi.Delete(i);
  If FFornecApi.Count = 0 Then
  begin
    frmCadCotacaoGeralCX.cxvFornecedoresACTAPI.Visible := False;
    frmCadCotacaoGeralCX.cxvFornecedoresCOT_IMGAPI.Visible := False;
    frmCadCotacaoGeralCX.cxvFornecedoresCOT_STAAPI.Visible := False;
    frmCadCotacaoGeralCX.cxvFornecedores.OptionsView.DataRowHeight := 19;
  End;

end;

procedure TCotacao.pIncluiNaListaConsulta(strCodIte: String);
  Var
    intRecNo: Integer;
    intIndice: Integer;
Begin
  If Not stlItens.Find(QuotedStr(strCodIte), intIndice) Then
    stlItens.Add(QuotedStr(strCodIte));

  If Assigned(cdsItens) And (Not cdsItens.IsEmpty) Then
  Begin
    With cdsItens Do
    Begin
      intRecNo := RecNo;
      If Locate('CODITE', strCodIte, []) Then
      Begin
        Edit;
        FieldByName('VENDIDO').AsInteger := 1;
        Post;
      End;
      RecNo := intRecNo;
    End;
  End;
end;

Function TCotacao.fSintetizaItens(pgbStatus: TcxProgressBar = nil): Boolean;
Begin
  If Assigned(cdsItensMultiLojas) Then
  With cdsItens Do
  Begin
    DisableControls;

    pSetaEventosItem(False);

    pgbStatus.Properties.Max := RecordCount;

    cdsItensMultiLojas.DisableControls;

    cdsItens.First;
    While Not Eof Do
    Begin
      pIncluiItemGiroSintetizado(False, FieldByName('CODITE').AsString);

      pAtualizaItemSintetizado;

      Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

    cdsItensMultiLojas.EnableControls;

  End;

  Result := True;
End;

procedure TCotacao.pSintetizaItens;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Sintetizando itens, aguarde...';
    frmGravando.fExecutarAcao := fSintetizaItens;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      EnableControls;
      pMensagensErro(E.Message, 'pSintetizaItens');
    End;
  End;

  pFreeAndNilGravando(frmGravando);
End;

procedure TCotacao.pHabilitaColunasDiaEst(blnHabilita: Boolean);
Begin
  With frmCadCotacaoGeralCX Do
  Begin
    cxbItensDIAEST.Visible := blnHabilita;
    cxbItensDIASUG.Visible := blnHabilita;
  End;
End;


Class function TCotacao.fArquivoParaString(strNomArq: String): String;
  Var
    stlArq: TStringList;
begin
  Try
    stlArq := TStringList.Create;
    stlArq.LoadFromFile(strNomArq);
    Result := stlArq.Text;
  Except
    Result := '';
  End;

  FreeAndNil(stlArq);
end;


procedure TCotacao.pSalvaConfiguracoes(frmCadCotacaoGeralCX: TForm);
  Var
    qryCfgPdc: TUniQuery;
    strArqTemp: String;
    stlCfgFrm: TStringList;
Begin
  If Not Assigned(frmCadCotacaoGeralCX) Then
    Exit;

  With TfrmCadCotacaoGeralCX(frmCadCotacaoGeralCX) Do
  Begin

    stlCfgFrm := TStringList.Create;
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdHeight));
    stlCfgFrm.Add(IntToStr(recDimFrm.wrdWidth));

    If recDimFrm.blnMaxim Then
      stlCfgFrm.Add('1')
    Else
      stlCfgFrm.Add('0');

    strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
    cxbComparativo.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

    qryCfgPdc := fCriaQuery;

    With qryCfgPdc, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "Fornecedor Cotação" ');

      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;

      Open;

      If IsEmpty Then
      Begin
        qryCfgPdc.Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGPDC', VS_strCodEmp);
      End Else
      Begin
        Edit;
      End;

      FieldByName('CFG_CFGGRI').AsString := fArquivoParaString(strArqTemp);
      FieldByName('CFG_CFGFRM').AsString := stlCfgFrm.Text;
      FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;
      FieldByName('CFG_NOMGRI').AsString := 'Fornecedor Cotação';

      Post;

      DeleteFile(PChar(strArqTemp));


      strArqTemp := fCriarArquivoTemporario('',fGetPathTempOpcoesLocais);
      cxbItens.StoreToIniFile(strArqTemp, True, [gsoUseFilter, gsoUseSummary]);

      Clear;
      Add('SELECT * FROM CFGPDC');
      Add('WHERE CFG_CODOPE = :CODOPE');
      Add('  AND IFNULL(CFG_NOMGRI, "") =  "Fornecedor Cotação - Itens" ');
      ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      Open;

      If IsEmpty Then
      Begin
        qryCfgPdc.Insert;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CFGPDC', VS_strCodEmp);
      End Else
      Begin
        Edit;
      End;

      FieldByName('CFG_CFGGRI').AsString := fArquivoParaString(strArqTemp);
      FieldByName('CFG_CFGFRM').AsString := stlCfgFrm.Text;
      FieldByName('CFG_CODOPE').AsString := strLoginUsuarioLogado;
      FieldByName('CFG_NOMGRI').AsString := 'Fornecedor Cotação - Itens';

      Post;

      DeleteFile(PChar(strArqTemp));

    End;

    FreeAndNil(qryCfgPdc);
    FreeAndNil(stlCfgFrm);
  End;

end;

procedure TCotacao.pSalvaCopiaSegurancaPermanente;
Var
  strAutInc: String;
begin
  If (Not Active) Or IsEmpty Then
    Exit;

  If fIncluiComHeranca(strAutInc, True) Then
  Begin
    blnRecuperaCotacao := False;
    fAbreCotacao(stcAbertas);

    If Assigned(frmCadCotacaoCX) Then
    With frmCadCotacaoCX Do
    rdgStatus.ItemIndex := 0;

    If Locate('AUTOINCREM',strAutInc,[]) Then
      pMensagemOk('Cotação incluida com sucesso!');

    pApaga_CopiaSeguranca(strSeqGerBKP);
    blnSalvouCotacao := True;
    blnApagaOnClose := True;
    strNumCot := '';
  End;
end;

Procedure TCotacao.pSalvaDadosGiro;
  Var
    blnPost: Boolean;
Begin
  If Not (State In [dsEdit, dsInsert]) Then
  Begin
    Edit;
    blnPost := True;
  End Else
  Begin
    blnPost := False;
  End;

  FieldByName('COT_MESGIR').AsInteger := recDadGiro.intMesGir;
  FieldByName('COT_MESMOS').AsInteger := recDadGiro.intMesMos;
  FieldByName('COT_MESSEL').AsString  := recDadGiro.strMeses;
  FieldByName('COT_MESATU').AsString  := IIF(recDadGiro.blnConsMesAtu, 'S', 'N');

  If blnPost then
    Post;

  If FieldByName('COT_CODGIR').AsString <> '' Then
     TSalvaInterfaceGiro.fApagaInterfaceCotacao(FieldByName('COT_CODGIR').AsString);
  FieldByName('COT_CODGIR').AsString := fAtualizaProCod('SEQ_COT_GIR', '', '') + VS_strCodEmp;

  pUpdateCotGerRes_CodGir(strSeqGerBKP, FieldByName('COT_CODGIR').AsString);
  fSalvaInterfaceCotacaoAutCom(FieldByName('COT_CODGIR').AsString, recDadGiro.strNomFrm, '');
End;

procedure TCotacao.pUpdateCotGerRes_CodGir(strSeqCot, strCodGir: String);
begin
  FqryConsulta.SQL.TExt := 'UPDATE COTGER_RES SET COT_CODGIR = "'+strCodGir+ '" WHERE AUTOINCREM = "'+strSeqCot+'"';
  FqryConsulta.ExecSQL;
end;

Procedure TCotacao.pAtualizaItemSintetizado;
Begin
  With cdsItens Do
  Begin
    Edit;
    FieldByName('SALDIS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat;
    FieldByName('SALDOS').AsFloat := cdsItensGiro.FieldByName('ITE_SALDOS').AsFloat;
    FieldByName('DIAEST').AsFloat := cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat;
    FieldByName('DIASUG').AsFloat := cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat;
    FieldByName('MEDVEN').AsFloat := cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat;
    Post;
  End;
End;

Function TCotacao.fAtualizaDadosSintetizados(pgbStatus: TcxProgressBar = nil): Boolean;
Begin
  With cdsItens Do
  Begin
    cdsItens.DisableControls;

    pSetaEventosItem(False);

    pgbStatus.Properties.Max := RecordCount;

    cdsItens.First;
    While Not Eof Do
    Begin

      If cdsItensGiro.Locate('ITE_CODITE', FieldByName('CODITE').AsString, []) Then
        pAtualizaItemSintetizado;

      Next;
    End;

    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;
End;

procedure TCotacao.pAtualizaDadosSintetizados;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Atualizando dados sintetizados...';
    frmGravando.fExecutarAcao := fAtualizaDadosSintetizados;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;
  Except
    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      pMensagensErro(E.Message, 'pAtualizaDadosSintetizados');
    End;
  End;

  pSetaEventosItem(True);

  pFreeAndNilGravando(frmGravando);
End;

procedure TCotacao.pCarregaGirosSimples;
  Var
    oleItensMultiLojas: OleVariant;
    cdsItensGiroAux: TUniClientDataSet;
    qryTemCadInt: TUniQuery;
begin
  
  qryTemCadInt := fCriaQuery ;
  Try
    If fEmptyStr(FieldByName('COT_CODGIR').AsString) Then
       FieldByName('COT_CODGIR').AsString := FieldByName('AUTOINCREM').AsString;
    qryTemCadInt.SQL.Add('SELECT * FROM CADINT WHERE INT_VALKEY = "' + FieldByName('COT_CODGIR').AsString + '"');
    qryTemCadInt.Open;
    If  qryTemCadInt.IsEmpty Then
      Exit;
  Finally
    FreeAndNil(qryTemCadInt);
  End;

  With recDadGiro Do
  Begin
    dtaDataBaseGir := Date;
    recDadGiro.blnAlterandoCotacaoComGiroNaoMultiloja  := True;
    intMesGir      := FieldByName('COT_MESGIR').AsInteger;
    strMeses       := FieldByName('COT_MESSEL').AsString;
    blnConsMesAtu  := FieldByName('COT_MESATU').AsString = 'S';
    strValKey      := FieldByName('COT_CODGIR').AsString;
    strNomFrm      := 'frmDigGiroEstoqueCotacao';
    strSeqCot      := strSeqGer;
    objSalInt      := Nil;

    blnConsPedVen := True;
    blnConsGarPen := True;
    blnConsOrdPro := True;
    blnRecuperCot := blnRecuperaCotacao;

    If fCfgSis('MESGIR', VarInteger) = 1 Then
      recDadGiro.intMesMos := 12
    Else
      recDadGiro.intMesMos := recDadGiro.intMesGir;

    If fEmptyStr(strMeses) Then
      strMeses := fMontaStrMeses(intMesMos);
  End;


  recDadGiro.blnUsaGiro := True;

  cdsItensGiroAux := TUniClientDataSet.Create(Self);

  recDadGiro.strNomFrm := 'frmDigGiroEstoqueCotacao';

  cdsItensGiroAux.Data := fRetornaProdutosGiroCotacaoAutCom(recDadGiro, oleItensMultiLojas);

  If (cdsItensGiroAux.Data <> Null) Then
  Begin
    cdsItensGiro.Data := cdsItensGiroAux.Data;

    pMascaraGiro;


    recDadGiro.blnAlterandoCotacaoComGiroNaoMultiloja  := False;
    recDadGiro.blnUsaGiro := True;

    pAncoraPainelGiro;

    pHabilitaColunasDiaEst(True);
  End;

End;


procedure TCotacao.pCarregaMultLojas;
  Var
    oleItensGiro: OleVariant;
    oleItensMult: OleVariant;
Begin
  FSintetizarItens := False;
  FAtualizarDadosSintetizados := False;

  With recDadGiro Do
  Begin
     dtaDataBaseGir := Date;
     intMesGir      := FieldByName('COT_MESGIR').AsInteger;
     strMeses       := FieldByName('COT_MESSEL').AsString;
     blnConsMesAtu  := FieldByName('COT_MESATU').AsString = 'S';
     If fEmptyStr(FieldByName('COT_CODGIR').AsString) Then
       FieldByName('COT_CODGIR').AsString := FieldByName('AUTOINCREM').AsString;

     strValKey      := FieldByName('COT_CODGIR').AsString;
     strNomFrm      := 'frmDigGiroEstoqueCotacao';
     strSeqCot      := strSeqGer;
     objSalInt      := Nil;

     blnConsPedVen := True;
     blnConsGarPen := True;
     blnConsOrdPro := True;
     blnRecuperCot := blnRecuperaCotacao;

    If fCfgSis('MESGIR', VarInteger) = 1 Then
      recDadGiro.intMesMos := 12
    Else
      recDadGiro.intMesMos := recDadGiro.intMesGir;

     If fEmptyStr(strMeses) Then
       strMeses := fMontaStrMeses(intMesMos);
  End;

  If Assigned(cdsItensMultiLojas) Then
  Begin
    oleItensMult := fCarregaCotacaoMultiLojasAutCom(recDadGiro, oleItensGiro);

    If (oleItensMult <> Null) then
    Begin
      cdsItensMultiLojas.Data := oleItensMult;
    End;

    pCentralizaCamposMultLoja;

    If (oleItensGiro <> Null) And Assigned(cdsItensGiro) then
    Begin
      cdsItensGiro.Data := oleItensGiro;
      pSalvaDadosGiro;

      FAtualizarDadosSintetizados := True;

    End Else If Assigned(cdsItensGiro) then
    Begin
      cdsItensGiro.Data := cdsItensMultiLojas.Data;
      cdsItensGiro.EmptyDataSet;

      FSintetizarItens := True;
    End;

    pMascaraGiro;

    recDadGiro.blnUsaGiro := True;

    pAncoraPainelGiro;

    pHabilitaColunasDiaEst(True);
  End;
End;

Procedure TCotacao.pIncluiGiroMultilojaSimilares;
  Var
    blnAgrSim: Boolean;
Begin
  If Not blnMulLoj Then
    Exit;

  If Not Assigned(cdsDigMultLoja) Then
    Exit;

  cdsDigMultLoja.cdsItens.DisableControls;
  blnAgrSim := cdsDigMultLoja.recOpcGir.blnAgrSim;

  Try
    cdsDigMultLoja.pSetaAgrSim(False);

    cdsItens.Filter   := 'ITESIM = ' + QuotedStr('S');
    cdsItens.Filtered := True;
    cdsItens.First;

    frmGravando.lblGravando.Caption := 'Incluindo giro similares...';
    frmGravando.pgbStatus.Position := 0;
    frmGravando.pgbStatus.Properties.Max := cdsItens.RecordCount;

    While Not cdsItens.Eof Do
    Begin
      cdsDigMultLoja.pVeSeIncluiItem(cdsItens.FieldByName('CODITE').AsString);

      cdsItens.Next;

      frmGravando.pgbStatus.Position := frmGravando.pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;

  Finally
    cdsItens.Filtered := False;
    cdsDigMultLoja.pSetaAgrSim(blnAgrSim);
    cdsDigMultLoja.cdsItens.EnableControls;
  End;
End;

function TCotacao.fInsereItensGiro(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    oleItensMultiLojas: OleVariant;
    cdsItensGiroAux: TUniClientDataSet;
    intMesGir: Integer;
    blnIncluiuItens: Boolean;
begin
  Result := True;

  try
    blnIncluiuItens := False;

    blnValidaQuantidade := False;

  //  If hwdDllPedido > 0 Then
    Begin
      If Assigned(pgbStatus) Then
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, calculando giro...';

      recDadGiro.blnUsaGiro := True;

      cdsItensGiroAux := TUniClientDataSet.Create(Self);
      intMesGir := recDadGiro.intMesGir;

      recDadGiro.strNomFrm := 'frmDigGiroEstoqueCotacao';

      cdsItensGiroAux.Data := fRetornaProdutosGiroCotacaoAutCom(recDadGiro, oleItensMultiLojas);
      If (cdsItensGiroAux.Data <> Null) Then
      Begin
        stlItens.Clear;
        pExcluiTodosItensDataSet;

        While not cdsFornecedores.IsEmpty Do
        Begin
          cdsFornecedores.Delete;

        End;

        pAtualizaArrFornecedores;

        cdsItensGiro.Data := cdsItensGiroAux.Data;

        If Assigned(cdsItensMultiLojas) Then
        Begin
          If cdsItensMultiLojas.Active then
            cdsItensMultiLojas.EmptyDataSet;

          cdsItensMultiLojas.Data := oleItensMultiLojas;
          pCentralizaCamposMultLoja;
        End;



        If cdsItensGiro.Data <> null Then
        Begin

          pSalvaDadosGiro;

          If Assigned(pgbStatus) Then
          Begin
            pgbStatus.Properties.Max := cdsItensGiro.RecordCount;
            TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, inserindo produtos...';
          End;

          cdsItensGiro.First;

          blnIncluiuItens := Not cdsItensGiro.IsEmpty;

          If Assigned(cdsItensMultiLojas) Then
            cdsItensMultiLojas.DisableControls;
          If recDadGiro.strPedMlj <> 'S' Then
            If Assigned(cdsDigMultLoja) Then
              If Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
                If fCfgSis('TELMUL', varBoolean) Then
                  cdsDigMultLoja.cdsDadosRodapeUma.DisableControls;

          While Not cdsItensGiro.Eof Do
          Begin
            If fCarregaItem(cdsItensGiro.FieldByName('ITE_CODITE').AsString, False, False) Then
              If fIncluiItem(cdsItensGiro.FieldByName('ITE_CODITE').AsString,
                          cdsItensGiro.FieldByName('ITE_DESITE').AsString,
                          cdsItensGiro.FieldByName('ITE_QTDITE').AsFloat,
                          cdsItensGiro.FieldByName('ITE_DIAEST').AsFloat,
                          cdsItensGiro.FieldByName('ITE_DIASUG').AsFloat,
                          cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat,
                          False,
                          False,
                          cdsItensGiro.FieldByName('ITE_SALFIS').AsFloat) Then
              Begin
                 //INCLUIR COPIA DE SEGURANÇA
  //               fIncluir_CopiaSeguranca;
                 blnUtilizouGiro := True;
                 pIncluiNaListaConsulta(cdsItensGiro.FieldByName('ITE_CODITE').AsString);
              End;

            cdsItensGiro.Next;

            If Assigned(pgbStatus) Then
              pgbStatus.Position := cdsItensGiro.RecNo;

            Application.ProcessMessages;
          end;

        End;

      End Else
      Begin
        recDadGiro.intMesGir := intMesGir;
      End;

      FreeAndNil(cdsItensGiroAux);
    End;

    If (Assigned(cdsDigMultLoja)) And (blnUtilizouGiro) Then
      cdsDigMultLoja.recOpcGir := recDadGiro;

    If Not blnIncluiuItens Then
    Begin
      fMensagem('','Nenhum produto foi inserido com os filtros informados!', ['&Ok'])
    End Else
    Begin
      pMascaraGiro;

      frmGravando.lblGravando.Caption := 'Ordenando itens, aguarde...';
      Application.ProcessMessages;
      pOrdenaGrid;

      frmGravando.lblGravando.Caption := 'Abrindo painel do giro, aguarde...';
      Application.ProcessMessages;
      pAncoraPainelGiro;

      If fCfgSis('COTSIM', varBoolean) Then
        pIncluiGiroMultilojaSimilares;
    End;

    frmGravando.lblGravando.Caption := 'Habilitando grid, aguarde...';
    Application.ProcessMessages;

    pEnableControlsItens;
    If Assigned(cdsItensMultiLojas) Then
      cdsItensMultiLojas.EnableControls;
    If recDadGiro.strPedMlj <> 'S' Then
      If Assigned(cdsDigMultLoja) Then
        If Assigned(cdsDigMultLoja.cdsDadosRodapeUma) Then
          If fCfgSis('TELMUL', varBoolean) Then
            cdsDigMultLoja.cdsDadosRodapeUma.EnableControls;
  Finally
    blnValidaQuantidade := True;
  End;
end;

Procedure TCotacao.pOrdenaGrid;
Begin
  If Assigned(frmCadCotacaoGeralCX) Then
  With frmCadCotacaoGeralCX Do
  Begin
    Case recDadGiro.intOrdem Of
      0: Begin // DESITE
           cxbItensCODITE.SortOrder := soAscending;
           cxbItensCODITE.SortIndex := 0;

           cxbItensORDITE.SortOrder := soAscending;
           cxbItensCODITE.SortIndex := 0;

           cxbItensFornecCODITE.SortOrder := soAscending;
           cxbItensFornecCODITE.SortIndex := 0;

           cxbComparativoCODITE.SortOrder := soAscending;
           cxbComparativoCODITE.SortIndex := 0;
         End;
      1: Begin // DESMAR, DESITE
           cxbItensDESMAR.SortOrder := soAscending;
           cxbItensDESMAR.SortIndex := 0;
           cxbItensCODITE.SortOrder := soAscending;
           cxbItensCODITE.SortIndex := 1;

           cxbItensFornecDESMAR.SortOrder := soAscending;
           cxbItensFornecDESMAR.SortIndex := 0;
           cxbItensFornecCODITE.SortOrder := soAscending;
           cxbItensFornecCODITE.SortIndex := 1;

           cxbComparativoDESMAR.SortOrder := soAscending;
           cxbComparativoDESMAR.SortIndex := 1;
           cxbComparativoCODITE.SortOrder := soAscending;
           cxbComparativoCODITE.SortIndex := 1;
         End;
    End;

    pGridsFirst;

    If (dbeMulLoj.Checked) And (dbeMulLoj.ReadOnly) And (Not cxbItensSALDOSLOJASGIROS.Visible) Then
    Begin
      cxgItens.Width := cxgItens.Width + cxbItensSALDOSLOJASGIROS.Width;
      cxbItensSALDOSLOJASGIROS.Visible := True;
      cxbItensSALDOSLOJASGIROS.Index := cxbItensSALDOS.Index + 1;
    End;
  End;
End;

Function TCotacao.fPedeItensGiro: Boolean;
begin
  Result := False;
  cdsItens.DisableControls;

  pSetaEventosItem(False, True, True, False);

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fInsereItensGiro;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    If frmGravando.blnConfirma Then
    Begin
      pHabilitaColunasDiaEst(True);
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fPedeItensGiro');
      cdsItens.EnableControls;
    End;
  End;

  pSetaEventosItem(True, True, True, False);

  pAfterPostItens(cdsItens);

  pFreeAndNilGravando(frmGravando);
end;

procedure TCotacao.pExcluiItem(blnSemConfirmacao: Boolean = False; blnDeletandoZero: Boolean = False);
  Var
    strCodIte: String;
    intRetConf: Integer;
Begin
  Try
    intRetConf := 0;
    If Assigned(frmCadCotacaoGeralCX) Then
    With frmCadCotacaoGeralCX, cdsItens Do
    Begin
      If IsEmpty Then
        Exit;

      If not blnSemConfirmacao Then
      Begin
        intRetConf := fMensagem('', 'Confirma a exclusão do item ' + FieldbyName('CODITE').AsString +
                      '-' + FieldbyName('DESITE').AsString + '?', ['&Sim', '&Não']);
      End;

      if (blnSemConfirmacao) or (intRetConf = 1) Then
      Begin
        pTiraAfterScrollItens;
        strCodIte := FieldbyName('CODITE').AsString;
        If blnDeletandoZero then
           cdsItens.Delete
        Else
        Begin

          cxbitens.OptionsData.Deleting := True;
          cxbItens.NavigatorButtons.Delete.Click;
          cxbitens.OptionsData.Deleting := False;
        End;

        pZeraMultiLojas(strCodIte, cdsItensMultiLojas, True);

        pAdicionaExcluidos(strCodIte);

        pSetaAfterScrollItensGiro;

        objCotacao.fExcluiItensCotacao_CopiaSeguranca(strCodIte);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pExcluiItem]');
      pSetaAfterScrollItensGiro;
    End;
  End;

End;

procedure TCotacao.MarcaTodosComoAlterado;
var bkpFilter: string;
    bkpFiltered: Boolean;
    blnDeveHabilitarControle: Boolean;
    bkpBeforePost: TDataSetNotifyEvent;
    bkpAfterPost: TDataSetNotifyEvent;
    bkpAfterScroll: TDataSetNotifyEvent;

begin
  blnDeveHabilitarControle := False;
  bkpFilter := cdsItens.Filter;
  bkpFiltered := cdsItens.Filtered;

  bkpBeforePost := cdsItens.BeforePost;
  bkpAfterPost := cdsItens.AfterPost;
  bkpAfterScroll := cdsItens.AfterScroll;

  Try
    If Not cdsItens.ControlsDisabled Then
    begin
      blnDeveHabilitarControle := True;
      cdsItens.DisableControls;
    End;
    cdsItens.BeforePost := nil;
    cdsItens.AfterPost := nil;
    cdsItens.AfterScroll := nil;

    cdsItens.Filtered := False;
    cdsItens.First;
    while not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ALTERADO').AsString := 'S';
      cdsItens.Post;
      cdsItens.Next;
    End;
  Finally
    If blnDeveHabilitarControle then
       cdsItens.EnableControls;

    cdsItens.BeforePost := bkpBeforePost;
    cdsItens.AfterPost := bkpAfterPost;
    cdsItens.AfterScroll := bkpAfterScroll;
    If cdsItens.Filtered Then
    Begin
      cdsItens.Filter := bkpFilter;
      cdsItens.Filtered := bkpFiltered;
    End;
  End;
end;

Procedure TCotacao.pAdicionaExcluidos(strCodIte: String);
  Var
    intIndex: Integer;
Begin
  If Not FExcluidos.Find(strCodIte, intIndex) Then
    FExcluidos.Add(strCodIte);
End;

Function TCotacao.fCarregaItem(strCodIte: String; blnValidar: Boolean = True; blnProcurar: Boolean = True): Boolean;
Begin
  dtsCadIteEdicao := Nil;

  Result := blnProcurar And (SameText(strCodIte, cdsItens.FieldByName('CODITE').AsString) Or cdsItens.Locate('CODITE', strCodIte, []));

  blnEditando := Result;

  If Result Then
  Begin
    dtsCadIteEdicao := cdsItens;
  End Else
  With qryNovoItem Do
  Begin
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    If blnValidar Then
    Begin
      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'O item '+ strCodIte + ' não está cadastrado!', ['&O k']);
        Result := False;
      End

      Else If (FieldByName('ITEATI').AsString <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Item inativo!', ['&O k']);
        Result := False;
      End

      Else If (FieldByName('ATICOM').AsString <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Item não está ativo para compras, verifique o cadastro!', ['&O k']);
        Result := False;
      End

      Else If (Not blnEXILCC) And (FieldByName('ITE_IMPLIS').AsString = 'N')  Then
      Begin
        fMensagem('ATENÇÃO!', 'Item está com Imprime Lista não, verifique o cadastro!', ['&O k']);
        Result := False;
      End

      Else Result := True;
    End

    Else Result := Not IsEmpty;

    If Result Then
      dtsCadIteEdicao := qryNovoItem;
  End;

End;

function TCotacao.fCarregaItensRelacionados(strCodFor: String;
  cdsItensFornec: TUniClientDataSet): Boolean;
begin
  With qryRepRFo Do
  Begin
    Close;
    ParamByName('CODFOR').AsString := strCodFor;
    Open;

    Result := Not IsEmpty;

    IndexFieldNames := 'REL_CODITE';

    If Result Then
    Begin

      cdsItensFornec.First;
      While Not cdsItensFornec.Eof Do
      Begin

        If qryRepRFo.FindKey([cdsItensFornec.FieldByName('CODITE').AsString]) Then
          cdsItensFornec.Next
        Else
         cdsItensFornec.Delete;

      End;

      Result := Not cdsItensFornec.IsEmpty;

    End;



   End;
end;

Procedure TCotacao.pAtualizaDiaSugItem;
Begin
  cdsItensGiro.Edit;
  cdsItensGiro.FieldbyName('ITE_DIASUG').AsFloat := cdsDigMultLoja.intDiaSug;
  cdsItensGiro.Post;
End;

procedure TCotacao.pAtualizaFornecedor_CopiaSeguranca(strCodFor: String; blnUtiliza: Boolean);
var
  qryUpdate: TUniQuery;
begin
  try
    qryUpdate := fCriaQuery;
    qryUpdate.SQL.Text := 'UPDATE COTCFO_RES SET COT_UTILIZ = '+QuotedStr(IIF(blnUtiliza, 'S', 'N'))+' WHERE COT_SEQGER = '+QuotedStr(strSeqGerBKP)+ 'AND COT_CODFOR = '+QuotedStr(strCodFor);
    qryUpdate.ExecSQL;

    FreeAndNil(qryUpdate);

    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAtualizaFornecedor_CopiaSeguranca]');
    End;
  End;
end;

Function TCotacao.fDigQuantidadeMultilojaCotacao: Boolean;
Begin
  Try

    With frmCadCotacaoGeralCX Do
    Begin
      pAncoraPainelGiro(True);

      Result := cdsDigMultLoja.fDigQuantidadeMultiloja(edtQtdIte,
                                                       edtCodIte.Text,
                                                       edtDesIte.Text,
                                                       '',
                                                       1);
      If Result Then
      Begin
        If Assigned(cdsItensGiro) And cdsItensGiro.Active Then
        Begin
          If cdsItensGiro.Locate('ITE_CODITE', edtCodIte.Text, []) Then
            pAtualizaDiaSugItem
          Else
            pIncluiItemGiroSintetizado(True, edtCodIte.Text);
        End;
      End;
    End;

  Finally

  End;
End;

Function TCotacao.fIncluiItem(strCodIte, strDesIte: String; fltQtdIte, fltDiaEst, fltDiaSug, fltMedVen: Double;
                              blnSomarQuantidade: Boolean; blnSimilar: Boolean = false; fltSaldoEmpresasGiro: Double = 0; fltQtdReq: Double = 0): Boolean;
  Var
    intContador: Integer;
Begin
  Try
    With cdsItens Do
    Begin
      //blnEditando := FieldByName('CODITE').AsString = strCodIte;
      If fEmptyStr(strCodIte) Then
        strCodIte := FieldByName('CODITE').AsString;
      blnEditando := (SameText(strCodIte, FieldByName('CODITE').AsString) Or cdsItens.Locate('CODITE', strCodIte, []));

      If blnEditando Then
      Begin
        Edit;
      End Else
      Begin
        If qryNovoItem.FieldByName('CODITE').AsString <> strCodIte Then
        Begin
          pMensagemOk('Dados do item não carregados para inclusão!');
          Result := False;
          Exit;
        End;

        Insert;

        For intContador := 0 To qryNovoItem.Fields.Count - 1 Do
          FieldByName(qryNovoItem.Fields[intContador].FieldName).Value := qryNovoItem.Fields[intContador].Value;

        FieldByName('QTDITE').AsFloat  := 0;

        FieldByName('MARPED').AsString := 'N';
        FieldByName('GERPED').AsString := 'N';
        FieldByName('EXCLUI').AsString := 'N';
        FieldByName('ALTERADO').AsString := 'S';

        FieldByName('PRCLIQ').AsFloat := SimpleRoundTo(untfuncoesSimples.fCalculaPrecoCompraLiq(FieldByName('PRECOM').AsFloat,
                                                                                                FieldByName('DESF01').AsFloat,
                                                                                                FieldByName('DESF02').AsFloat,
                                                                                                FieldByName('DESF03').AsFloat,
                                                                                                FieldByName('DESF04').AsFloat,
                                                                                                FieldByName('DESF05').AsFloat,
                                                                                                FieldByName('DESF06').AsFloat), -2);

        For intContador := 1 To INT_MAX_FORNECEDOR Do
        Begin
          FieldByName('VALUNI' + fIndice(intContador)).AsFloat := 0;
          FieldByName('IPIENT' + fIndice(intContador)).AsFloat := 0;
          FieldByName('ALQCBS' + fIndice(intContador)).AsFloat := 0;
          FieldByName('ALQIBS' + fIndice(intContador)).AsFloat := 0;
          FieldByName('ALQ_IS' + fIndice(intContador)).AsFloat := 0;
          FieldByName('FREENT' + fIndice(intContador)).AsFloat := 0;
          FieldByName('SUBSTI' + fIndice(intContador)).AsFloat := 0;
        End;

        FieldByName('DIAEST').AsFloat  := fltDiaEst;
        FieldByName('DIASUG').AsFloat  := fltDiaSug;
        FieldByName('MEDVEN').AsFloat  := fltMedVen;
      End;

      FieldByName('PJAATU').AsString := 'N';
      FieldByName('ATUPRE').AsString := 'N';
      FieldByName('DESITE').AsString := strDesIte;

      If blnSomarQuantidade Then
        FieldByName('QTDITE').AsFloat  := FieldByName('QTDITE').AsFloat + fltQtdIte
      Else
        FieldByName('QTDITE').AsFloat  := fltQtdIte;

      FieldByName('PESOIT').AsFloat  := FieldByName('PESOCD').AsFloat * fltQtdIte;

      FieldByName('QTDREQ').AsFloat := FieldByName('QTDREQ').AsFloat + fltQtdReq;

      FieldByName('ITESIM').AsString := 'N';
      If blnSimilar Then
        FieldByName('ITESIM').AsString := 'S';

      FieldByName('SALDOS_LOJAS_GIROS').AsFloat :=  fltSaldoEmpresasGiro;
      Post;

      If FblnCOTSIM Then
      Begin
        If Not fEmptyStr(cdsItens.FieldByName('CODSIM').AsString) Then
        Begin
          If cdsItens.FieldByName('PRISIM').AsString = 'S' Then
          Begin
            pIncluirItemSimilar(strCodIte
              ,cdsItens.FieldByName('CODSIM').AsString
              ,fltQtdIte
              ,fltDiaEst
              ,fltDiaSug
              ,fltMedVen
              ,False);
          End;
        End;
      End;

      Result := True;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      cdsItens.EnableControls;
      pMensagensErro(E.Message, '[TCotacao.fIncluiItem]');
    End;
  End;

End;

Function TCotacao.fItemOk: Boolean;
  Var
    blnFiltered: Boolean;
Begin
  pTiraAfterScrollItens;

  blnFiltered := cdsItens.Filtered;

  cdsItens.Filtered := False;

  If cdsItens.IsEmpty Then
  Begin
    Result := FALSE;
    cdsItens.Filtered := blnFiltered;
    fMensagem('ATENÇÃO!', 'Não há itens na cotação!', ['&O k']);
  End

  Else Result := TRUE;

  pSetaAfterScrollItensGiro;
End;

Function TCotacao.fFornecedorOk: Boolean;
  Var
    pAfterScrollFor: TprcScroll;
Begin
  Result := TRUE;

  pAfterScrollFor := cdsFornecedores.AfterScroll;
  cdsFornecedores.AfterScroll := Nil;

  Try
    If cdsFornecedores.State = dsEdit Then
      cdsFornecedores.Post;

    If cdsFornecedores.IsEmpty Then
    Begin
      Result := FALSE;
      fMensagem('ATENÇÃO!', 'Não há fornecedores na cotação!', ['&O k']);
    End Else
    With cdsFornecedores, frmCadCotacaoGeralCX Do
    Begin
      cdsFornecedores.DisableControls;
      cdsFornecedores.First;
      While Not cdsFornecedores.Eof Do
      Begin

        If FieldByName('COT_DTAENT').IsNull Then
        Begin
          Result := FALSE;

          pagCotacao.ActivePage := tabCotForIte;
          pSetaComboFornecedor(FieldByName('COT_CODFOR').AsString);

          fMensagem('ATENÇÃO!', 'Informe a data de entrega!', ['&O k']);

          pSetFocus(dbeDtaEnt);
          Break;
        End

        Else If fEmptyStr(fTiraCaracEspeciais(FieldByName('COT_CONPAG').AsString)) Or
               (Not fValidaCndPag(FieldByName('COT_CONPAG').AsString)) Then
        Begin
          Result := FALSE;

          pagCotacao.ActivePage := tabCotForIte;
          pSetaComboFornecedor(FieldByName('COT_CODFOR').AsString);

          If fEmptyStr(fTiraCaracEspeciais(FieldByName('COT_CONPAG').AsString)) Then
            fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k'])
          Else
            fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é válida!', ['&O k']);

          pSetFocus(dbeConPag);
          Break;
        End;

        cdsFornecedores.Next;

      End;

      cdsFornecedores.EnableControls;
    End;

  Finally
    cdsFornecedores.AfterScroll := pAfterScrollFor;
  End;
End;

Procedure TCotacao.pSetaComboFornecedor(strCodFor: String);
  Var
    intContador: Integer;
Begin
  With frmCadCotacaoGeralCX Do
  For intContador := 0 To cmbCodFor.Items.Count - 1 Do
  If LeftStr(cmbCodFor.Items[intContador], 8) = strCodFor Then
  Begin
    cmbCodFor.ItemIndex := intContador;
    Break;
  End;
End;

Procedure TCotacao.pExcluiTodosItensDataSet;
Begin
  While not cdsItens.IsEmpty do
  Begin
    cdsItens.Delete;
  End;
  fExcluiItensCotacao_CopiaSeguranca('', True);
  FEsvaziouItens := True;
End;

Function TCotacao.fExcluiTodosItensDataSetZeradoPrg(pgbProgresso: TcxProgressBar): Boolean;
var int: Integer;
begin
  pgbProgresso.Properties.Max := cdsItens.recordCount;
  int := 0;
  While not cdsItens.IsEmpty do
  Begin

    pExcluiItem(true, True);
    inc(int);
    pgbProgresso.Position := pgbProgresso.Position + 1;
    If (int mod 10) = 0 then
      Application.ProcessMessages;
  End;
  Result :=  True;

End;

Procedure TCotacao.pExcluiTodosItensDataSetZerado;
  var
    frmDeletar: TFrmGravando;
Begin

  pCriarFormularios(TfrmGravando, frmDeletar);
  Try
    frmDeletar.lblGravando.Caption := 'Aguarde, deletando itens com quantidade zero...';
    frmDeletar.fExecutarAcao := fExcluiTodosItensDataSetZeradoPrg;
    frmDeletar.ShowModal;
  Finally
    FreeAndNil(frmDeletar);
  End;
End;

procedure TCotacao.pTemQuantidadeZerada;
Var
  strFilter: String;
  bnlFiltered: Boolean;
Begin

  pSetaItensGrid(False);
  cdsItens.LogChanges := False;

  strFilter := cdsItens.Filter;
  bnlFiltered := cdsItens.Filtered;
  cdsItens.DisableControls;
  cdsItens.Filter := 'QTDITE = 0';
  cdsItens.Filtered := true;
  If Not cdsItens.IsEmpty Then
    If (Not fPergunta('Há itens com quantidade zerada, deseja mantê-los no pedido?')) Then
       pExcluiTodosItensDataSetZerado;

  cdsItens.Filtered := False;

  cdsItens.Filter := strFilter;
  cdsItens.Filtered := bnlFiltered;
  cdsItens.LogChanges := True;
  pSetaItensGrid(True);
  cdsItens.EnableControls;

End;


procedure TCotacao.pMarcaRequisicao;
var strReq: String;
begin
  cdsItens.First;
  While not cdsItens.Eof do
  Begin
    strReq := '';
    strReq := fGetRequisicoesFormatado(cdsItens.FieldByName('CODITE').AsString);
    If ((Not fEmptyStr(strReq)) And (cdsItens.FieldByName('REQUIS').AsInteger <> 1)) Or
       ((fEmptyStr(strReq)) And (cdsItens.FieldByName('REQUIS').AsInteger = 1)) Then
    Begin
      cdsItens.Edit;

      If (Not fEmptyStr(strReq)) Then
        cdsItens.FieldByName('REQUIS').AsInteger := 1
      Else
        cdsItens.FieldByName('REQUIS').AsInteger := 0;

      cdsItens.Post;
    End;
    cdsItens.Next;
  End;
End;

procedure TCotacao.pExcluiTodosItensRequisicaoDataSet;
begin
  cdsItens.First;
  While not cdsItens.Eof do
  Begin
    If cdsItens.FieldByName('REQUIS').AsInteger = 1 Then
      pExcluiItem(True)
    Else
      cdsItens.Next;
  End;
  FLimpaRequisicao := True;
End;

Procedure TCotacao.pVeSeExcluiTodosItensCotacao;
  Var
    qryExclui: TUniQuery;
Begin
  If FEsvaziouItens And (opeOperac <> opIncluir) Then
  Begin
    pLimpaRequisicao(strSeqGer);

    qryExclui := fCriaQuery;

    qryExclui.SQL.Text := 'DELETE FROM COTITE WHERE COT_SEQGER = :SEQGER';
    qryExclui.ParambyName('SEQGER').AsString := strSeqGer;
      qryExclui.ExecSQL;

    FreeAndNil(qryExclui);
  End;
End;

procedure TCotacao.pMarcaDesmarcaFornecedor;
Begin
  With cdsFornecedores Do
  Begin
    If IsEmpty Then
      Exit;

    If (FieldbyName('MARCADO').AsString = 'N') And
       (fCodForToIndex(FieldbyName('COT_CODFOR').AsString) = -1) Then
    Begin
      pMensagemOk('Marque o fornecedor, na Aba 4-Comparativo, na opção "Fornecedores utilizados para comparação de preço" !');
      Exit;
    End;

    Edit;

    If FieldbyName('MARCADO').AsString = 'S' Then
      FieldbyName('MARCADO').AsString := 'N'
    Else
      FieldbyName('MARCADO').AsString := 'S';

    Post;
  End;
End;

Function TCotacao.fAtualizaMenorFornecedor: Boolean;
Begin

  cdsItens.AfterPost  := Nil;
  With cdsItens Do
  Begin
    DisableControls;

    pSetaEventosItem(False, True, True, False);


    Result := fSelecionaMenoresPrecos;

    pSetaEventosItem(True, True, True, False);

    pEnableControlsItens;
  End;


  FRecalculouPrecos := Result;

  cdsItens.BeforePost := pBeforePostItens;

End;

{Function TCotacao.fAtualizaMenorFornecedorPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    DisableControls;

    pSetaEventosItem(False, True, True, False);

    prgProgresso.Properties.Max := RecordCount;
    prgProgresso.Position := 0;
    Application.ProcessMessages;


    fSelecionaMenoresPrecos;

    pSetaEventosItem(True, True, True, False);

    pEnableControlsItens;
  End;

  Result := True;
End;                 }

Function TCotacao.fCarregaPrecosFornecedor: Boolean;
Begin
  Result := False;

  If fMensagem('','Deseja utilizar preços do cadastro de Fornecedor (Produtos/Preços)!', ['', '']) <> 1 Then
    Exit;

  pCriarFormularios(TfrmGravando, frmGravando);

  frmGravando.lblGravando.Caption := 'Aguarde, carregando preços...';

  frmGravando.fExecutarAcao := fCarregaPrecosFornecedorProgresso;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;

  Result := frmGravando.blnConfirma;
  pFreeAndNilGravando(frmGravando);
End;

Function TCotacao.fCarregaPrecosFornecedorProgresso(prgProgresso: TCxProgressBar): Boolean;
  var
    ArrForPre: Array Of Record
      objForPre: TForPre;
      intIndFor: Integer;
    End;

    intIndice: Integer;
begin
  Result := False;

  Try
    Try
      prgProgresso.Properties.Max := cdsItens.RecordCount;

      cdsFornecedores.DisableControls;
      cdsFornecedores.Filter   := 'MARCADO = ' + QuotedStr('S');
      cdsFornecedores.Filtered := True;

      If cdsFornecedores.RecordCount = 0 Then
      Begin
        fMensagem('','Selecione os fornecedores!', ['&O K']);
        Exit;
      End;

      cdsItens.DisableControls;

      pSetaEventosItem(False, True, True, False);

      SetLength(ArrForPre, cdsFornecedores.RecordCount);

      intIndice := 0;

      cdsFornecedores.First;
      While Not cdsFornecedores.Eof Do
      With ArrForPre[intIndice] Do
      Begin
        objForPre := TForPre.Create(Self);
        objForPre.strCodFor := cdsFornecedores.FieldByName('COT_CODFOR').AsString;
        objForPre.pCarregarItens;

        intIndFor := fCodForToIndex(cdsFornecedores.FieldByName('COT_CODFOR').AsString);

        cdsFornecedores.Next;

        Inc(intIndice);
      End;

      cdsItens.First;

      While Not cdsItens.Eof Do
      Begin
        Application.ProcessMessages;

        cdsItens.Edit;

        For intIndice := Low(ArrForPre) To High(ArrForPre) Do
        With ArrForPre[intIndice] Do
        Begin
          cdsItens.FieldByName('VALUNI' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('IPIENT' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('ALQCBS' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('ALQIBS' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('ALQ_IS' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('FREENT' + fIndice(intIndFor)).AsFloat := 0.00;
          cdsItens.FieldByName('SUBSTI' + fIndice(intIndFor)).AsFloat := 0.00;

          If objForPre.cdsItens.Locate('CODITE', cdsItens.FieldByName('CODITE').AsString, []) Then
            cdsItens.FieldByName('VALUNI' + fIndice(intIndFor)).AsFloat := objForPre.cdsItens.FieldByName('VALITE').AsFloat;
        End;

        cdsItens.Post;

        cdsItens.Next;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      For intIndice := Low(ArrForPre) To High(ArrForPre) Do
      With ArrForPre[intIndice] Do
        FreeAndNil(objForPre);

      SetLength(ArrForPre, 0);

      Result := True;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TCotacao.pCarregaPrecosFornecedor');
      End;
    End;

  Finally
    cdsFornecedores.Filtered := False;
    cdsFornecedores.EnableControls;

    pSetaEventosItem(True, True, True, False);

    pEnableControlsItens;
  End;
end;

{procedure TCotacao.pExcelImprimeFiltros(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; Filtros: Array Of String);

  procedure pTitulo(intLinha: Integer; CorDaFonte: TCorExcel; intFonte: Integer; opcAlinhamento: TAlinhamentoExcel; strTitulo: String);
    var
      strLinha: String;
  begin
    strLinha := IntToStr(intLinha);

    With Excel, Campos Do
    Begin
      Mesclar     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha);
      Alinhamento ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, opcAlinhamento);
      Negrito     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, True);
      CorFonte    ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, CorDaFonte);
      DefinirFonte('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, Arial, intFonte);

      Escrever(intLinha, 1, strTitulo);
    End;
  end;

begin
  Excel.PintarTudo(Branco);

  pTitulo(1, Preto, 16, Centro, fRetNomeEmpresa);

  pTitulo(Excel.ProximaLinha, Preto, 16, Centro,'DEPARTAMENTO DE COMPRAS');

  pTitulo(Excel.ProximaLinha, Vermelho, 16, Centro, 'COTAÇÃO DE PREÇOS: ' + FieldByName('COT_NUMCOT').AsString);

  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'FORNECEDOR: ' + FCodForExportacao + '-' + fRetNomFornecedor(FCodForExportacao));
  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'COMPRADOR: ' + fRetNomVendRep(FieldByName('COT_CODCMP').AsString));
end;         }


{procedure TCotacao.pFimGeracaoExcel(Excel: TExcel; Campos: TCampos);
begin
  Excel.ProtegerEstrutura(SEN_ADM);
  Excel.ProtegerPlanilha(SEN_ADM);
end;}

{procedure TCotacao.pImprimeDetalhes(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);

  function fCelula(strCampo: String): String;
  begin
    Result := Campos.ColunaPorNome[strCampo].Letra + IntToStr(Excel.LinhaAtual);
  end;

begin

  With Excel, Campos Do
  Begin
    BloquearCelulas(fCelula('CODCNA'), fCelula('CODCNA'), False);

    BloquearCelulas(fCelula('VALUNI' + fIndice(FIndForExportacao)), fCelula('VALUNI' + fIndice(FIndForExportacao)), False);
    BloquearCelulas(fCelula('IPIENT' + fIndice(FIndForExportacao)), fCelula('IPIENT' + fIndice(FIndForExportacao)), False);
    BloquearCelulas(fCelula('SUBSTI' + fIndice(FIndForExportacao)), fCelula('SUBSTI' + fIndice(FIndForExportacao)), False);

    ValidarCelulas(fCelula('VALUNI' + fIndice(FIndForExportacao)), fCelula('VALUNI' + fIndice(FIndForExportacao)), '0', '99999999');
    ValidarCelulas(fCelula('IPIENT' + fIndice(FIndForExportacao)), fCelula('IPIENT' + fIndice(FIndForExportacao)), '0', '100');
    ValidarCelulas(fCelula('SUBSTI' + fIndice(FIndForExportacao)), fCelula('SUBSTI' + fIndice(FIndForExportacao)), '0', '100');

   (*
    If frmCadCotEmail.chkExbAplicProd.Checked And
      Not fEmptyStr(Dados.FieldByName('APLICA').AsString) Then
    Begin
      Escrever(LinhaAtual,Campos.ColunaPorNome['DESITE'].Coluna,Dados.FieldByName('DESITE').AsString);
      FormatoNumerico(LinhaAtual, Campos.ColunaPorNome['DESITE'].Coluna, '');
      AlinhamentoVertical('A' + intToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + intToStr(LinhaAtual), xlsTop);
    End; *)
  End;

end;                                            }

procedure TCotacao.OnEscreveValorCampo(DataSet: TDataSet; AIdentificador: string; var ATexto: string; var AColorBackGround, AColorFont: TColor);
begin
  If AIdentificador = 'CODCNA' Then
    ATexto := fRetCodCna(DataSet)
  Else If AIdentificador = 'APLICA' Then
    ATexto := fRetAplicacao(DataSet)
  Else If AIdentificador = 'CODFAB' Then
    ATexto := fTrataCodFab(DataSet);
end;


Function TCotacao.fRetCodCna(dtsDados: TDataSet): String;
Begin
  Result := '';
  With FqryCodCna Do
  Begin
    Close;
    ParamByName('CODFOR').AsString := FCodForExportacao;
    ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
    Open;

    If Not IsEmpty Then
      Result := FieldByName('ITE_CODCNA').AsString;
  End;
End;

function TCotacao.fRetCodComprador(strValorDoEdit: String): String;
begin
  Result := strValorDoEdit;
  //Se não usa digitador então o campo de comprador está por senha
  If (Not fCfgSis('DIGCOT', varBoolean)) Then
    Result := fRetCodVendedor(strValorDoEdit);
end;

function TCotacao.fRetCodDigitador(strValorDoEdit: String): String;
begin
  //Se não usa digitador então o digitador é o próprio comprador cujo campo está por senha
  If (Not fCfgSis('DIGCOT', varBoolean)) Then
  Begin
    If Assigned(frmCadCotacaoGeralCX) Then
      Result := fRetCodVendedor(frmCadCotacaoGeralCX.edtCodCmp.Text);
  End
  Else
  Begin
    //Digitador é sempre por senha;
    Result := fRetCodVendedor(strValorDoEdit);
  End;
end;

Function TCotacao.fRetAplicacao(dtsDados: TDataSet): String;
Begin
  With dtsDados Do
  Begin
    Result := AnsiReplaceStr(FieldByName('APLICA').AsString, '<<csq>>', ' ');
  End;
End;

function TCotacao.fGetCodForByPosArrCodFor(Posicao: integer): String;
begin
  Result := '';
  If cdsFornecedores.FieldByName('POSICAO').AsInteger = Posicao Then
    Exit(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
  cdsFornecedores.First;
  while not  cdsFornecedores.Eof do
  Begin
    If cdsFornecedores.FieldByName('POSICAO').AsInteger = Posicao Then
      Exit(cdsFornecedores.FieldByName('COT_CODFOR').AsString);
    cdsFornecedores.Next;
  End;
end;

Function TCotacao.fGetDadosFornecedor(strCodFor: String; Var strNomFor, strEmail, strContato: String): Boolean;
  Var
    qryCadFor: TUniQuery;
Begin
  Result := FALSE;

  Try
    qryCadFor := fCriaQuery;
    With qryCadFor, SQL Do
    Begin
      Clear;
      Add('SELECT');
      Add('  FOR_NOMFOR,');
      Add('  FOR_CONTAT,');
      Add('  FOR_EMAIL_ ');
      Add('FROM');
      Add('  CADFOR');
      Add('WHERE');
      Add('  FOR_CODFOR = :CODFOR');

      ParamByName('CODFOR').AsString := strCodFor;

      Open;

      If Not IsEmpty Then
      Begin
        strNomFor  := FieldByName('FOR_NOMFOR').AsString;
        strContato := FieldByName('FOR_CONTAT').AsString;
        strEmail   := FieldByName('FOR_EMAIL_').AsString;
        Result := TRUE;
      End

    End;
    FreeAndNil(qryCadFor);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetDadosFornecedor]');
    End;

  End;

End;

procedure TCotacao.pExportarArquivos;
  Var
    frmCadCotEmail : TfrmCadCotEmail;
    strNomArq: String;
    strNomFor,
    strEmail,
    strAssunto,
    strContato: String;
    arrDestinatarios, arrArquivos: TStringArray;
    cdsItensFornec: TUniClientDataSet;
Begin
  Try
    Try
      cdsItensFornec := TUniClientDataSet.Create(Nil);

      cdsFornecedores.DisableControls;
      cdsFornecedores.Filter   := 'MARCADO = ' + QuotedStr('S');
      cdsFornecedores.Filtered := True;

      If cdsFornecedores.RecordCount = 0 Then
      Begin
        fMensagem('','Selecione os fornecedores para a exportação!', ['&O K']);
        Exit;
      End;

      If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'COTACOES') Then
        CreateDir(ExtractFilePath(Application.ExeName) + 'COTACOES');

      If Not DirectoryExists(strDirExp) Then
        CreateDir(strDirExp);

      If Not DirectoryExists(ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR') Then
        CreateDir(ExtractFilePath(Application.ExeName) + 'COTACOES\IMPORTAR');

      pCriarFormularios(TfrmModuloCotExportacao, frmModuloCotExportacao);

      With frmModuloCotExportacao Do
      Begin
        cdsItens.DisableControls;

        pSetaEventosItem(False);

        cdsFornecedores.First;

        While Not cdsFornecedores.Eof Do
        Begin
          cdsItensFornec.Data     := cdsItens.Data;
          cdsItensFornec.Filter   := 'GERPED = ' + QuotedStr('N');
          cdsItensFornec.Filtered := True;

          cdsItensExp      := cdsItensFornec;
          dtsItens.DataSet := cdsItensFornec;

          FCodForExportacao := cdsFornecedores.FieldbyName('COT_CODFOR').AsString;

          strIndFor := fIndice(fCodForToIndex(FCodForExportacao));

          If fGetDadosFornecedor(FCodForExportacao, strNomFor, strEmail, strContato) Then
          Begin

            pCriarFormularios(TfrmCadCotEmail, frmCadCotEmail);
            frmCadCotEmail.lblFornecedor.Caption := 'Fornecedor: ' + FCodForExportacao + ' - ' + strNomFor;
            frmCadCotEmail.edtEmail.Text         := strEmail;
            frmCadCotEmail.edtContato.Text       := strContato;

            If frmCadCotEmail.ShowModal = mrOk Then
            Begin
              If (frmCadCotEmail.rdgOpcIte.ItemIndex = 0) And (Not fCarregaItensRelacionados(FCodForExportacao, cdsItensFornec)) Then
              Begin

                pMensagemOk('Não há itens relacionados para o fornecedor ' + FCodForExportacao + ' - ' + strNomFor + ' para serem exportados!');

              End Else
              Begin
                Case frmCadCotEmail.rdgOrdenacao.ItemIndex Of
                  1:   cdsItensFornec.IndexFieldNames := 'DESITE';
                  2:   If frmCadCotEmail.rdgOrdenacao.Items.Count = 4 Then
                          cdsItensFornec.IndexFieldNames := 'DESMAR;DESITE'
                       Else
                         cdsItensFornec.IndexFieldNames := 'CODFAB';
                  3:   cdsItensFornec.IndexFieldNames := 'CODFAB';
                  Else cdsItensFornec.IndexFieldNames := 'CODITE';
                End;

                Case frmCadCotEmail.rdgTipoCod.ItemIndex Of
                  0:  TipoUnidade := tuUnCompra;
                  1:  TipoUnidade := tuUnVenda;
                End;

                FExportarSemPreco := frmCadCotEmail.chkExportarSemPreco.Checked;

                pSetUnidadeToClient(cdsItensFornec, strIndFor, TipoUnidade);

                fltTotVlrPed := fRetTotalCotacao(cdsItensFornec, strIndFor);

                cdsItensFornec.First;

                strNomArq := 'COT' + FieldbyName('COT_NUMCOT').AsString + '_' + FieldByName('COT_CODEMP').AsString + '_' + FCodForExportacao;

                If frmCadCotEmail.rdgGerArq.ItemIndex = 0 Then
                Begin
                  strNomArq := strDirExp + '\' + strNomArq + '.xls';
                  pExportarExcelNovo(cdsItensFornec, strNomArq, fCodForToIndex(FCodForExportacao),
                                     frmCadCotEmail.chkExbAplicProd.Checked,
                                     frmCadCotEmail.chkMsgLivre.Checked,
                                     frmCadCotEmail.rdgOpcIte.ItemIndex = 1,
                                     frmCadCotEmail.chkExbMarca.Checked,
                                     frmCadCotEmail.chkSemelhantes.Checked,
                                     frmCadCotEmail.chkCNA.Checked,
                                     frmCadCotEmail.chkReferencia.Checked);
                End
                Else
                Begin
                  If fltTotVlrPed > 0 Then
                  Begin
                    if frmCadCotEmail.rdgFormato.ItemIndex = 0 Then
                    Begin
                      TfrxMemoView(frxReportPDF.FindComponent('Memo23')).Visible := True;
                      TfrxMemoView(frxReportPDF.FindComponent('mmoValTotal')).Visible := True;
                      TfrxMemoView(frxReportPDF.FindComponent('mmoValTotal')).Text  := FormatFloat('R$ #,##0.00', fltTotVlrPed);
                    End Else
                    Begin
                      TfrxMemoView(frxReportPDF_P.FindComponent('Memo23')).Visible := True;
                      TfrxMemoView(frxReportPDF_P.FindComponent('mmoValTotal')).Visible := True;
                      TfrxMemoView(frxReportPDF_P.FindComponent('mmoValTotal')).Text  := FormatFloat('R$ #,##0.00', fltTotVlrPed);
                    End;
                  End;

                  if frmCadCotEmail.rdgFormato.ItemIndex = 0 Then
                  Begin
                    TfrxMemoView(frxReportPDF.FindComponent('rdbMsgLv1')).Visible := frmCadCotEmail.chkMsgLivre.Checked;
                    TfrxMemoView(frxReportPDF.FindComponent('rdbAplica')).Visible := frmCadCotEmail.chkExbAplicProd.Checked;
                    TfrxMemoView(frxReportPDF.FindComponent('mmoMarca')).Visible := frmCadCotEmail.chkExbMarca.Checked;
                    TfrxMemoView(frxReportPDF.FindComponent('mmMarca')).Visible := frmCadCotEmail.chkExbMarca.Checked;
                  End Else
                  Begin
                    TfrxMemoView(frxReportPDF_P.FindComponent('rdbMsgLv1')).Visible := frmCadCotEmail.chkMsgLivre.Checked;
                    TfrxMemoView(frxReportPDF_P.FindComponent('rdbAplica')).Visible := frmCadCotEmail.chkExbAplicProd.Checked;
                    TfrxMemoView(frxReportPDF_P.FindComponent('mmoMarca')).Visible := frmCadCotEmail.chkExbMarca.Checked;
                    TfrxMemoView(frxReportPDF_P.FindComponent('mmMarca')).Visible := frmCadCotEmail.chkExbMarca.Checked;
                  End;
                  If Not frmCadCotEmail.chkExbMarca.Checked Then
                  Begin
                    TfrxMemoView(frxReportPDF_P.FindComponent('mmReferencia')).Width :=
                      TfrxMemoView(frxReportPDF_P.FindComponent('mmReferencia')).Width +
                      TfrxMemoView(frxReportPDF_P.FindComponent('mmMarca')).Width;

                    TfrxMemoView(frxReportPDF.FindComponent('mmReferencia')).Width :=
                      TfrxMemoView(frxReportPDF.FindComponent('mmReferencia')).Width +
                      TfrxMemoView(frxReportPDF.FindComponent('mmMarca')).Width;
                  End;

                  frmModuloCotExportacao.FTabprf:= blnTabPrf;
                  frmModuloCotExportacao.FCodFor:= FCodForExportacao;

                  if frmCadCotEmail.rdgFormato.ItemIndex = 0 Then
                    frxReportJ := frxReportPDF
                  Else
                    frxReportJ := frxReportPDF_P;

                  frxPDFExport.FileName    := strNomArq + '.pdf';
                  frxPDFExport.DefaultPath := strDirExp;
                  frxPDFExport.ShowDialog  := False;

                  If FileExists(fCfgSis('PATLOG')) Then
                    frxReportJ.Script.Variables['IMAGEM'] := fCfgSis('PATLOG')
                  Else
                    frxReportJ.Script.Variables['IMAGEM'] := '';

                  If frmCadCotEmail.chkExbAplicProd.Checked Then
                    frxReportJ.Script.Variables['BLNAPLICA'] := 'T'
                  Else
                    frxReportJ.Script.Variables['BLNAPLICA'] := 'F';

                  frxReportJ.Script.Variables['BLNMSGLIV']   := frmCadCotEmail.chkMsgLivre.Checked;

                  frxReportJ.Script.Variables['COTACAO']     := 'COTAÇÃO DE PREÇOS: ' + FieldbyName('COT_NUMCOT').AsString;
                  frxReportJ.Script.Variables['COMPRADOR']   :=  fRetNomVendRep(FieldByName('COT_CODCMP').AsString) +
                                                                    ' - Email: ' + fCampoTabela('OPE_E_MAIL', 'CADOPE', ['OPE_CODOPE'], [FieldByName('COT_CODCMP').AsString]);
                  frxReportJ.Script.Variables['FORNECEDOR']  :=  FCodForExportacao + '-' + fRetNomFornecedor(FCodForExportacao);
                  frxReportJ.PrepareReport;

                  frxReportJ.Export(frxPDFExport);
                  strNomArq := frxPDFExport.FileName;
                End;

                If frmCadCotEmail.chkEnvEma.Checked Then Begin
                  pCriarArrayAnexosEDestinatarios(strNomArq, frmCadCotEmail.edtEmail.Text,
                                                  arrDestinatarios, arrArquivos);

                 strAssunto := 'COTAÇÃO Nº ' + FieldbyName('COT_NUMCOT').AsString;

                    If TEnvioEmail.EnviarEmail(Self,
                                            strLoginUsuarioLogado,
                                            strAssunto,
                                            arrDestinatarios,
                                            [],
                                            [],
                                            [fCfgSis('MSGCOT', varString)],
                                            arrArquivos) Then
                    Begin
                      fGravarEmaCot(arrDestinatarios, strAssunto, FCodForExportacao);
                    End;
                End
                Else
                  fMensagem('ATENÇÃO', 'Arquivo Salvo em: ' + strNomArq, ['&OK']);

              End; {Else If Not fCarregaItensRelacionados(FCodForExportacao, cdsItensFornec) Then}

            End; {If frmCadCotEmail.ShowModal = mkOk Then}

            FreeAndNil(frmCadCotEmail);

          End; {If fGetDadosFornecedor(strCodFor, strNomFor, strEmail, strContato) Then}

          cdsFornecedores.Next;
        End;

      End;

      FreeAndNil(frmModuloCotExportacao);

    Except

      On E: Exception Do
      Begin
        cdsItens.EnableControls;
        pMensagensErro(E.Message, '[pExportarArquivos]');
      End;

    End;

  Finally
    cdsFornecedores.Filtered := False;
    cdsFornecedores.EnableControls;

    FreeAndNil(cdsItensFornec);

    pSetaEventosItem(True);
    pEnableControlsItens;
  End;
End;

procedure TCotacao.pImportaArquivos;
  var
    frmCadCotImportacao: TfrmCadCotImportacao;
    strNomArq,
    strCodFor: String;
    intIndice,
    intConLin,
    intMaxLin: Integer;
    strCodIte: String;

    fltValUni,
    fltIPIEnt,
    fltFREEnt,
    fltSubsti: Double;

    intIndFor,
    intColCod,
    intColUni,
    intColIpi,
    intColFre,
    intColSub: Integer;
    intColCbs,
    intColIbs,
    intCol_Is: Integer;
    strFilter: string;
    intLinhaInicial: Integer;
    objValidaExcel: TValidadorExcel;

    function fEncontrouColunas: Boolean;
    begin

      Result := objValidaExcel.fLocalizaColunaCSV(TIT_CODIGO, intColCod);

      If Result Then
        Result := objValidaExcel.fLocalizaColunaCSV(TIT_PRECO, intColUni);

      If Result Then
        Result := objValidaExcel.fLocalizaColunaCSV(TIT_IPI, intColIpi);

      If Result Then
        Result := objValidaExcel.fLocalizaColunaCSV(TIT_FRE, intColFre);

      If Result Then
        Result  := objValidaExcel.fLocalizaColunaCSV(TIT_ST, intColSub);

      // Colunas opcionais: planilha antiga, sem elas, importa e preserva as aliquotas
      intColCbs := -1;
      intColIbs := -1;
      intCol_Is := -1;
      If fSomarNovosImpostosDaReformaAoValorContabil Then
      Begin
        If Not objValidaExcel.fLocalizaColunaCSV(TIT_CBS, intColCbs) Then
          intColCbs := -1;

        If Not objValidaExcel.fLocalizaColunaCSV(TIT_IBS, intColIbs) Then
          intColIbs := -1;

        If Not objValidaExcel.fLocalizaColunaCSV(TIT_IS, intCol_Is) Then
          intCol_Is := -1;
      End;


      If Not Result Then
        pMensagemOk('O Layout do arquivo ' + ExtractFileName(strNomArq) + ' é inválido, ' + #13#10 +
                    'o mesmo deve conter as colunas: ' + #13#10 +
                    TIT_CODIGO + ', ' + TIT_PRECO + ', ' + TIT_IPI + ' , ' + TIT_ST + ' e ' + TIT_FRE + ' !')
      Else
        intLinhaInicial := objValidaExcel.LinhaTitulos + 1
    end;

    Procedure pSalvaDadosFornecedor;
      Var
        strDtaEnt,
        strConPag: String;
    Begin
      strDtaEnt := objValidaExcel.fGetValueCSV(10, 'B');
      strConPag := fTiraCaracEspeciaisPonto(objValidaExcel.fGetValueCSV(11, 'B'));

      If cdsfornecedores.Locate('COT_CODFOR', strCodFor, []) Then
      Begin
        cdsfornecedores.Edit;

        If StrToDateDef(strDtaEnt, 0) > 0 Then
          cdsfornecedores.FieldByName('COT_DTAENT').AsDateTime := StrToDateDef(strDtaEnt, 0);

        If fValidaCndPag(strConPag)  Then
          cdsfornecedores.FieldByName('COT_CONPAG').AsString   := strConPag;

        cdsfornecedores.Post;
      End;

    End;

Begin
  Try
    pCriarFormularios(TfrmCadCotImportacao, frmCadCotImportacao);

    With frmCadCotImportacao Do
    Begin
      chlLisArq.Clear;

      With cdsFornecedores Do
      Begin
        DisableControls;
        cdsFornecedores.First;
        While Not Eof Do
        Begin
          strNomArq := strDirImp +  '\COT' + Self.FieldbyName('COT_NUMCOT').AsString + '_' + Self.FieldByName('COT_CODEMP').AsString + '_' + FieldByName('COT_CODFOR').AsString + '.xls';

          If FileExists(strNomArq) Then
          Begin
            chlLisArq.Items.Add(FieldByName('COT_CODFOR').AsString + ' - ' + FieldByName('NOMFOR').AsString);
            chlLisArq.Checked[Pred(chlLisArq.Count)] := TRUE;
          End;

          Next;
        End;
        EnableControls;
      End;

      If ShowModal = mrOk Then
      Begin

        cdsItens.DisableControls;

        pSetaEventosItem(False, True, True, False);

        cdsItens.IndexFieldNames := 'CODITE';

        frmCadCotacaoGeralCX.pgbProgresso.Visible := TRUE;
        strFilter := '';

        If blnMulLoj Then
        Begin
          cdsDigMultLoja.desvinculaCDS;
          If cdsItensMultiLojas.Filtered Then
          Begin
            strFilter := cdsItensMultiLojas.Filter;
            cdsItensMultiLojas.Filtered := False;
          End;
        End;
        Try
          blnAtualizaMltLojaDepois := True;
          For IntIndice := 0 To chlLisArq.Count - 1 Do
          If chlLisArq.Checked[IntIndice] Then
          Begin
            strCodFor := LeftStr(chlLisArq.Items[intIndice],8);
            intIndFor := fCodForToIndex(strCodFor);
            strNomArq := strDirImp + '\COT' + FieldbyName('COT_NUMCOT').AsString + '_' + FieldByName('COT_CODEMP').AsString + '_' + strCodFor + '.xls';

            objValidaExcel := TValidadorExcel.Create(strNomArq, 20, '', '');
            Try
              Try
                cdsItens.BeforePost := nil;
                If fEncontrouColunas Then
                Begin
                  intMaxLin := objValidaExcel.intQtdLinhas;

                  pSalvaDadosFornecedor;

                  frmCadCotacaoGeralCX.pgbProgresso.Max := intMaxLin - intLinhaInicial + 1;
                  frmCadCotacaoGeralCX.pgbProgresso.Position := 0;

                  For intConLin := intLinhaInicial To intMaxLin Do
                  Begin

                    strCodIte := objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColCod));


                    If Not fEmptyStr(strCodIte) Then
                    Begin
                      If Length(strCodIte) < fTamCodIte Then
                       strCodIte := fPadL(strCodIte, fTamCodIte, '0');

                      fltValUni := fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColUni)),'.',''));
                      fltIpiEnt := fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColIpi)),'.',''));
                      fltFreEnt := fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColFre)),'.',''));
                      fltSubsti := fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColSub)),'.',''));

                      If cdsItens.Locate('CODITE', VarArrayOf([strCodIte]), []) Then
                      Begin
                        cdsItens.Edit;
                        cdsItens.FieldByName('VALUNI' + fIndice(intIndFor)).AsFloat := fltValUni;
                        cdsItens.FieldByName('IPIENT' + fIndice(intIndFor)).AsFloat := fltIPIEnt;
                        cdsItens.FieldByName('SUBSTI' + fIndice(intIndFor)).AsFloat := fltSubsti;
                        cdsItens.FieldByName('FREENT' + fIndice(intIndFor)).AsFloat := fltFreEnt;

                        If intColCbs <> -1 Then
                          cdsItens.FieldByName('ALQCBS' + fIndice(intIndFor)).AsFloat := fAliquotaImportada(cdsItens.FieldByName('ALQCBS' + fIndice(intIndFor)).AsFloat, fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColCbs)), '.', '')));

                        If intColIbs <> -1 Then
                          cdsItens.FieldByName('ALQIBS' + fIndice(intIndFor)).AsFloat := fAliquotaImportada(cdsItens.FieldByName('ALQIBS' + fIndice(intIndFor)).AsFloat, fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intColIbs)), '.', '')));

                        If intCol_Is <> -1 Then
                          cdsItens.FieldByName('ALQ_IS' + fIndice(intIndFor)).AsFloat := fAliquotaImportada(cdsItens.FieldByName('ALQ_IS' + fIndice(intIndFor)).AsFloat, fStrToFloat(AnsiReplaceStr(objValidaExcel.fGetValueCSV(intConLin, fGetLetraAlfa(intCol_Is)), '.', '')));

                        cdsItens.Post;
                      End;
                    End;

                    frmCadCotacaoGeralCX.pgbProgresso.StepBy(1);
                    If (intIndice Mod 10 )  = 0 Then
                      Application.ProcessMessages;
                  End;

                End;

              Except
                On E: Exception Do
                Begin
                  pMensagensErro(E.Message, '');
                End;
              End;
            Finally
              FreeAndNil(objValidaExcel);
              cdsItens.BeforePost := pBeforePostItens;

            End;
          End;
        Finally
          fSelecionaMenoresPrecos;
          blnAtualizaMltLojaDepois := False;
          pAtualizaCDSItensMultiLojaFornecedorEscolhidoGeral;
        End;

        If blnMulLoj Then
        Begin
         cdsDigMultLoja.vinculaCDS;

          If strFilter <> '' Then
          Begin
            strFilter := cdsItensMultiLojas.Filter;
            cdsItensMultiLojas.Filtered := True;
          End
          Else If (strFilter = '') And (cdsItensMultiLojas.Filtered) Then
            cdsItensMultiLojas.Filtered := False;
        End;

        frmCadCotacaoGeralCX.pgbProgresso.Visible := FAlSE;

        pSetaEventosItem(True, True, True, False);

        pEnableControlsItens;

        fMensagem('','Arquivos importados com sucesso!', ['&O K']);
      End;

    End;

    FreeAndNil(frmCadCotImportacao);

  Except

    On E: Exception Do
    Begin
      pSetaEventosItem(True, True, True, False);
      cdsItens.EnableControls;
      pMensagensErro(E.Message, '[pExportarArquivos]');
    End;

  End;

End;

function TCotacao.fGetSQLDadosItensImportacao: String;
begin
  Result := '';
  Result := Result + '   SELECT                                                                                                         ';
  Result := Result + '     CAST("N" AS CHAR(1)) AS EXCLUI,                                                                              ';
  Result := Result + '     CAST("N" AS CHAR(1)) AS GERPED,                                                                              ';
  Result := Result + '     C.ITE_CODITE,                                                                                                ';
  Result := Result + '     C.ITE_CODFAB,                                                                                                ';
  Result := Result + '     C.ITE_CODGRU,                                                                                                ';
  Result := Result + '     C.ITE_DESITE,                                                                                                ';
  Result := Result + '     C.ITE_REFERE,                                                                                                ';
  Result := Result + '     U.UNI_SIGUNI AS ITE_UNIMED,                                                                                  ';
  Result := Result + '     G.ITE_DTAULT,                                                                                                ';
  Result := Result + '     G.ITE_FORULT,                                                                                                ';
  Result := Result + '     G.ITE_PREULT,                                                                                                ';
  Result := Result + '     G.ITE_IMPULT,                                                                                                ';
  Result := Result + '     M.MAR_DESMAR,                                                                                                ';
  Result := Result + '     C.ITE_CODMAR,                                                                                                ';

  Result := Result + '     CAST((SELECT GROUP_CONCAT(SEM_CODSEM) FROM CADSEM WHERE C.ITE_CODITE = SEM_CODITE) AS CHAR(255)) AS CODSEM,  ';
  Result := Result + '     G.ITE_SALDOS,                                                                                                ';
  Result := Result +       fSQLSaldoDisponivel('G', True, False, True) + ' AS ITE_SALDIS,                                               ';
  Result := Result + '     CAST(0 AS DECIMAL(15,2)) as ITE_DIAEST,                                                                      ';
  Result := Result + '     CAST(0 AS DECIMAL(15,2)) as ITE_DIASUG,                                                                      ';
  Result := Result + '     C.ITE_PESOIT,                                                                                                ';
  Result := Result + '     CAST(0 AS DECIMAL(15,2)) AS ITE_MEDVEN,                                                                      ';
  Result := Result + '     (ITE_PRECOM * (1 -  G.ITE_DESF01 / 100) *                                                                    ';
  Result := Result + '             (1 -  G.ITE_DESF02 / 100) *                                                                          ';
  Result := Result + '             (1 -  G.ITE_DESF03 / 100) *                                                                          ';
  Result := Result + '             (1 -  G.ITE_DESF04 / 100) *                                                                          ';
  Result := Result + '             (1 -  G.ITE_DESF05 / 100) *                                                                          ';
  Result := Result + '             (1 -  G.ITE_DESF06 / 100)) AS ITE_PRCLIQ,                                                            ';
  Result := Result + '     G.ITE_PRECUS,                                                                                                ';
  Result := Result + '     @ITESIM := (SELECT SM.ITE_CODITE FROM CADITE SM                                                              ';
  Result := Result + '            INNER JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE                                                 ';
  Result := Result + '           AND SG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)                                                         ;
  Result := Result + '            WHERE SM.ITE_CODSIM  = C.ITE_CODSIM                                                                   ';
  Result := Result + '           AND SM.ITE_ITEATI = "S"                                                                                ';
  Result := Result + '           AND SM.ITE_PRISIM = "S" LIMIT 1) AS ITE_ITESIM,                                                        ';
  Result := Result + '     CONCAT(IFNULL(@ITESIM,G.ITE_CODITE),IF(C.ITE_PRISIM = "S","A","B"),G.ITE_CODITE) AS ITE_ORDITE,               ';

  Result := Result + '   (SELECT SUM(SG.ITE_SALDOS) ';
  Result := Result + '   FROM CADITE SM';
  Result := Result + '   JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE ';
  Result := Result + '   WHERE SM.ITE_CODSIM =  C.ITE_CODSIM ' ;
  Result := Result + '   AND SG.ITE_CODITE <>  C.ITE_CODITE ' ;
  Result := Result + '   AND SG.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) ;
  Result := Result + ') ITE_SALSIM,' ;

  Result := Result + '   (SELECT SUM(SG.ITE_SALDOS) ';
  Result := Result + '   FROM CADITE SM';
  Result := Result + '   JOIN ITEGER SG ON SG.ITE_CODITE = SM.ITE_CODITE ';
  Result := Result + '   WHERE SM.ITE_CODSIM =  C.ITE_CODSIM ' ;
  Result := Result + '   AND SG.ITE_CODITE <>  C.ITE_CODITE ' ;
  Result := Result + ') ITE_SLMSIM' ;

  Result := Result + '   FROM                                                                                                           ';
  Result := Result + '   CADITE C                                                                                                       ';
  Result := Result + '     INNER JOIN ITEGER G ON G.ITE_CODITE = C.ITE_CODITE                                                           ';
  Result := Result + '     INNER JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR                                                           ';
  Result := Result + '     INNER JOIN CADUNI U ON U.UNI_CODUNI = C.ITE_CODUNI                                                           ';
  Result := Result + '     WHERE G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp)                                                              ;
end;

function TCotacao.fGetSQLWhereListaItensImportacaoCotacao(ACdsItens: TUniClientDataSet): String;
var
  strListaItens: String;
begin
  strListaItens := '';
  ACdsItens.DisableControls;
  ACdsItens.First;
  While Not ACdsItens.Eof Do
  Begin
    strListaItens := strListaItens + QuotedStr(ACdsItens.FieldByName('CODITE').AsString);
    If Not (ACdsItens.RecNo = ACdsItens.RecordCount) Then
      strListaItens := strListaItens + ',';

    ACdsItens.Next;
  End;

  ACdsItens.EnableControls;

  If strListaItens.IsEmpty Then
    strListaItens := ' "" ';

  Result := '  AND G.ITE_CODITE IN ( ' + strListaItens + ')';
end;

function TCotacao.fProcessarCdsImportacaoAux(pgbProgresso: TCxProgressBar): Boolean;
var
  qryDadosItem: TUniQuery;
begin
  qryDadosItem := fCriaQuery;

  Try
    qryDadosItem.SQL.Clear;
    qryDadosItem.SQL.Add(fGetSQLDadosItensImportacao);
    qryDadosItem.SQL.Add(fGetSQLWhereListaItensImportacaoCotacao(FcdsItensImportacao));
    qryDadosItem.Open;

    FcdsItensImportacao.DisableControls;
    FcdsItensImportacao.First;

    cdsItens.DisableControls;

    pgbProgresso.Properties.Max := FcdsItensImportacao.RecordCount;

    While Not FcdsItensImportacao.Eof Do
    Begin
      If Not qryDadosItem.Locate('ITE_CODITE', FcdsItensImportacao.FieldByName('CODITE').AsString,[]) Then
      Begin
        FcdsItensImportacao.Next;
        pgbProgresso.Position := FcdsItensImportacao.RecNo;
      End;

      If cdsItens.Locate('CODITE', FcdsItensImportacao.FieldByName('CODITE').AsString, []) Then
        cdsItens.Edit
      Else
        cdsItens.Insert;

      cdsItens.FieldByName('EXCLUI').AsString   := qryDadosItem.FieldByName('EXCLUI').AsString;
      cdsItens.FieldByName('GERPED').AsString   := qryDadosItem.FieldByName('GERPED').AsString;
      cdsItens.FieldByName('CODITE').AsString   := qryDadosItem.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('CODFAB').AsString   := qryDadosItem.FieldByName('ITE_CODFAB').AsString;
      cdsItens.FieldByName('CODGRU').AsString   := qryDadosItem.FieldByName('ITE_CODGRU').AsString;
      cdsItens.FieldByName('DESITE').AsString   := qryDadosItem.FieldByName('ITE_DESITE').AsString;
      cdsItens.FieldByName('REFERE').AsString   := qryDadosItem.FieldByName('ITE_REFERE').AsString;
      cdsItens.FieldByName('QTDITE').AsFloat    := FcdsItensImportacao.FieldByName('QTDITE').AsFloat;
      cdsItens.FieldByName('UNIMED').AsString   := qryDadosItem.FieldByName('ITE_UNIMED').AsString;
      cdsItens.FieldByName('DTAULT').AsDateTime := qryDadosItem.FieldByName('ITE_DTAULT').AsDateTime;
      cdsItens.FieldByName('FORULT').AsString   := qryDadosItem.FieldByName('ITE_FORULT').AsString;
      cdsItens.FieldByName('PREULT').AsFloat    := qryDadosItem.FieldByName('ITE_PREULT').AsFloat;
      cdsItens.FieldByName('IMPULT').AsFloat    := qryDadosItem.FieldByName('ITE_IMPULT').AsFloat;
      cdsItens.FieldByName('DESMAR').AsString   := qryDadosItem.FieldByName('MAR_DESMAR').AsString;
      cdsItens.FieldByName('CODSEM').AsString   := qryDadosItem.FieldByName('CODSEM').AsString;
      cdsItens.FieldByName('SALDOS').AsFloat    := qryDadosItem.FieldByName('ITE_SALDOS').AsFloat;
      cdsItens.FieldByName('SALDIS').AsFloat    := qryDadosItem.FieldByName('ITE_SALDIS').AsFloat;
      cdsItens.FieldByName('DIAEST').AsInteger  := qryDadosItem.FieldByName('ITE_DIAEST').AsInteger;
      cdsItens.FieldByName('DIASUG').AsInteger  := qryDadosItem.FieldByName('ITE_DIASUG').AsInteger;
      cdsItens.FieldByName('PESOIT').AsFloat    := qryDadosItem.FieldByName('ITE_PESOIT').AsFloat;
      cdsItens.FieldByName('MEDVEN').AsFloat    := qryDadosItem.FieldByName('ITE_MEDVEN').AsFloat;
      cdsItens.FieldByName('PRCLIQ').AsFloat    := qryDadosItem.FieldByName('ITE_PRCLIQ').AsFloat;
      cdsItens.FieldByName('PRECUS').AsFloat    := qryDadosItem.FieldByName('ITE_PRECUS').AsFloat;
      cdsItens.FieldByName('ITESIM').AsString   := qryDadosItem.FieldByName('ITE_ITESIM').AsString;
      cdsItens.FieldByName('ORDITE').AsString   := qryDadosItem.FieldByName('ITE_ORDITE').AsString;
      cdsItens.FieldByName('SALSIM').AsFloat   := qryDadosItem.FieldByName('ITE_SALSIM').AsFloat;
      cdsItens.FieldByName('SLMSIM').AsFloat   := qryDadosItem.FieldByName('ITE_SLMSIM').AsFloat;
      cdsItens.Post;
      FcdsItensImportacao.Next;

      pgbProgresso.Position := FcdsItensImportacao.RecNo;
      Application.ProcessMessages;
    End;

    Result := True;
    FcdsItensImportacao.EnableControls;
    cdsItens.EnableControls;
  Finally
    FreeAndNil(qryDadosItem);
    FreeAndNil(FcdsItensImportacao);
  End;
end;

procedure TCotacao.pProcessarCdsImportacao;
begin
  TfrmGravando.fExecuta(fProcessarCdsImportacaoAux, frmGravando, 'Importando itens...');
end;

procedure TCotacao.pImportarItens;
begin
  Application.CreateForm(TfrmImportCotacaoItens, frmImportCotacaoItens);
  Try
    frmImportCotacaoItens.ShowModal;
  Finally
    If frmImportCotacaoItens.FBlnProcessarItens Then
    Begin
      FcdsItensImportacao := frmImportCotacaoItens.cdsItens;
      pProcessarCdsImportacao;
    End;

    FreeAndNil(frmImportCotacaoItens);
  End;
end;

Procedure TCotacao.pExportarExcelComparativo;
  var
    qryCadEmp: TUniQuery;
    intContador: Integer;
    objGeraExcel: TGeraExcel;
    blnConfirma: Boolean;

  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;

begin

  Try
    pCriarFormularios(TfrmPedOrdenacao, frmPedOrdenacao);
    With frmPedOrdenacao Do
    Begin
      blnConfirma := ShowModal = mrOk;

      If blnConfirma Then
        Case rdgOrdenacao.ItemIndex Of
           1:   cdsItens.IndexFieldNames := 'DESITE';
           2:   cdsItens.IndexFieldNames := 'DESMAR;DESITE';
           3:   cdsItens.IndexFieldNames := 'CODFAB';
           Else cdsItens.IndexFieldNames := 'CODITE';
        End;
    End;
    FreeAndNil(frmPedOrdenacao);

    If Not blnConfirma Then
      Exit;

    cdsItens.DisableControls;

    pSetaEventosItem(False);

    cdsItens.First;

    objGeraExcel := TGeraExcel.Create(cdsItens, frmCadCotacaoGeralCX.pgbProgresso);

    objGeraExcel.strNomRel := fRetFantasiaEmpresa;
    objGeraExcel.intFonteNomRel := 16;

    objGeraExcel.blnImpEmp := False;

    pLeEmpresa;

    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_ENDERE').AsString);
    objGeraExcel.AddFiltro(qryCadEmp.FieldByName('EMP_NOMCID').AsString);
    objGeraExcel.AddFiltro('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString);
    objGeraExcel.AddFiltro('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString);
    objGeraExcel.AddFiltro('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString);

    objGeraExcel.OnImpFiltros  := pExcelImprimeFiltrosComparativo;
    objGeraExcel.OnSomaResumo  := pSomaTotaisComparativo;
    objGeraExcel.OnMontaResumo := pMontaResumoComparativo;
    objGeraExcel.OnImpDetalhes := pImprimeDetalhesComparativo;

    objGeraExcel.AddCampo('CODITE', 'Cód.Item');
    objGeraExcel.AddCampo('CODFAB', 'Código Fábrica');
    objGeraExcel.AddCampo('CODSIM', 'Cód. Similar');
    objGeraExcel.AddCampo('CODSEM', 'Semelhantes');
    objGeraExcel.AddCampo('DESITE', 'Descrição do Item');
    objGeraExcel.AddCampo('REFERE', 'Refeência');
    objGeraExcel.AddCampo('APLICA', 'Aplicação');
    objGeraExcel.AddCampo('SIGUNI', 'Unidade');
    objGeraExcel.AddCampo('QTDITE', 'Quantidade');
    objGeraExcel.AddCampo('DTAULT', 'Data Últ.Com.');
    objGeraExcel.AddCampo('FORULT', 'Fornecedor da Última Compra');
    objGeraExcel.AddCampo('PREULT', 'Unit.Últ.Com.');
    objGeraExcel.AddCampo('IMPULT', 'Últ.Com. + Imp.');

    objGeraExcel.AddCampo('VLRUNT', 'Valor Unitário');
    objGeraExcel.AddCampo('COMLIQ', 'Preço Compra Líquido');
    objGeraExcel.AddCampo('DIFCOL', 'Dif. Com. Liq %');
    objGeraExcel.AddCampo('IPIENT', '% IPI Ent');
    objGeraExcel.AddCampo('SUBSTI', '% ST Ent');
    objGeraExcel.AddCampo('PREIMP', 'Pr. Compra Líq. + Impostos');
    objGeraExcel.AddCampo('DIFPREIMP', 'Difer. Compra Liq + Imp %');

    objGeraExcel.AddCampo('PRECUS', 'Preço Custo');
    objGeraExcel.AddCampo('DIFCUS', 'Difer. Custo %');
    objGeraExcel.AddCampo('CUSREA', 'Preço Custo Real');
    objGeraExcel.AddCampo('DIFREA', 'Difer. Custo Real %');

    FColForIniExcel := 15;

    For intContador := Low(arrCodFor) To High(arrCodFor) Do
    If fFornecedorAtivo(intContador) Then
    Begin
      objGeraExcel.AddCampo('UNITOT' + fIndice(intContador), LeftStr(fRetNomFornecedor(arrCodFor[intContador]), 30) );

      objGeraExcel.AddTotais('TOT_SEL_' + fIndice(intContador) );
      objGeraExcel.AddTotais('TOT_GER_' + fIndice(intContador) );
    End;

    If objGeraExcel.fGerarRelatorio(True) Then
      pMensagemOk('Arquivo gerado com sucesso!');

    FreeAndNil(objGeraExcel);
    FreeAndNil(qryCadEmp);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TCotacao.pExportarExcelComparativo');
  End;

  pSetaEventosItem(True);
  pEnableControlsItens;
end;

procedure TCotacao.pExportarExcelComparativoNovo;
  var
    qryCadEmp: TUniQuery;
    intContador: Integer;
    blnConfirma: Boolean;
    FontFieldValues,
    FontFieldTitle: TFont;

  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;


begin
  pCriarFormularios(TfrmPedOrdenacao, frmPedOrdenacao);
  Try

    With frmPedOrdenacao Do
    Begin
      blnConfirma := ShowModal = mrOk;

       If blnConfirma Then
       Case rdgOrdenacao.ItemIndex Of
         1:   cdsItens.IndexFieldNames := 'DESITE';
         2:   cdsItens.IndexFieldNames := 'DESMAR;DESITE';
         3:   cdsItens.IndexFieldNames := 'CODFAB';
       Else
           cdsItens.IndexFieldNames := 'CODITE';
       End;
    End;
  Finally
    FreeAndNil(frmPedOrdenacao);
  End;

  If Not blnConfirma Then
    Exit;

  cdsItens.DisableControls;

  pSetaEventosItem(False);

  cdsItens.First;
  Try
    geraExcel := TGeraArquivo.create(taHtml, cdsItens, frmCadCotacaoGeralCX.pgbProgresso );
    Try
      geraExcel.protegeEstrutura := false;
      geraExcel.OnSomaTotais := pSomaTotaisComparativoNovo;
      geraExcel.OnEscreveValorCampo := OnEscreveValorCampoComparativo;
      geraExcel.OnResumo := pMontaResumoComparativoNovo;

      geraExcel.pAddTitulo(fRetNomeEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
      geraExcel.pAddTitulo(fRetFantasiaEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
      pLeEmpresa;
      geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_ENDERE').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_NOMCID').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString, TGeraArquivo.fSetFont());

      geraExcel.pAddTitulo('DEPARTAMENTO DE COMPRAS', TGeraArquivo.fSetFont(16, [fsBold]));
      geraExcel.pAddTitulo('COTAÇÃO DE PREÇOS: ' + FieldByName('COT_NUMCOT').AsString, TGeraArquivo.fSetFont(16, [fsBold], clRed));
      geraExcel.pAddTitulo('COMPRADOR: ' + fRetNomVendRep(FieldByName('COT_CODCMP').AsString), TGeraArquivo.fSetFont(10, [fsBold], clBlack));

//      objGeraExcel.OnSomaResumo  := pSomaTotaisComparativo;
//      objGeraExcel.OnMontaResumo := pMontaResumoComparativo;
//      objGeraExcel.OnImpDetalhes := pImprimeDetalhesComparativo;


      FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
      FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);


      geraExcel.AddCampo('CODITE', 'Cód.Item', FontFieldTitle, FontFieldValues, '', tahtmlUndef);
      geraExcel.AddCampo('CODFAB', 'Código Fábrica', FontFieldTitle, FontFieldValues, '', tahtmlUndef);
      geraExcel.AddCampo('CODSIM', 'Cód. Similar', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('CODSEM', 'Semelhantes', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('DESITE', 'Descrição do Item', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('REFERE', 'Refeência', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('APLICA', 'Aplicação', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('SIGUNI', 'Unidade', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('QTDITE', 'Quantidade', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('DTAULT', 'Data Últ.Com.', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('FORULT', 'Fornecedor da Última Compra', FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('PREULT', 'Unit.Últ.Com.', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('IMPULT', 'Últ.Com. + Imp.', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('VLRUNT', 'Valor Unitário', FontFieldTitle, FontFieldValues,'#0.00');
      GeraExcel.AddCampo('COMLIQ', 'Preço Compra Líquido', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('DIFCOL', 'Dif. Com. Liq %', FontFieldTitle, FontFieldValues,'#0.00');
      GeraExcel.AddCampo('IPIENT', '% IPI Ent', FontFieldTitle, FontFieldValues,'#0.00');
      GeraExcel.AddCampo('SUBSTI', '% ST Ent', FontFieldTitle, FontFieldValues,'#0.00');
      GeraExcel.AddCampo('PREIMP', 'Pr. Compra Líq. + Impostos', FontFieldTitle, FontFieldValues,'#0.00');
      GeraExcel.AddCampo('DIFPREIMP', 'Difer. Compra Liq + Imp %', FontFieldTitle, FontFieldValues,'#0.00');

      geraExcel.AddCampo('PRECUS', 'Preço Custo', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('DIFCUS', 'Difer. Custo %', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('CUSREA', 'Preço Custo Real', FontFieldTitle, FontFieldValues,'#0.00');
      geraExcel.AddCampo('DIFREA', 'Difer. Custo Real %', FontFieldTitle, FontFieldValues,'#0.00');
      FColForIniExcel := 15;

      For intContador := Low(arrCodFor) To High(arrCodFor) Do
      If fFornecedorAtivo(intContador) Then
      Begin
        geraExcel.AddCampo('UNITOT' + fIndice(intContador), LeftStr(fRetNomFornecedor(arrCodFor[intContador]), 30), FontFieldTitle, FontFieldValues,'#0.00');

        geraExcel.AddTotais('TOT_SEL_' + fIndice(intContador), 'VALTOT' + fIndice(intContador));
        geraExcel.AddTotais('TOT_GER_' + fIndice(intContador), 'VALTOT' + fIndice(intContador));
      End;
      geraExcel.AddCampoSemDataSet('VAR', '% VAR.(*)', FontFieldTitle, FontFieldValues, ftFloat, '#0.00');
      geraExcel.AddCampoSemDataSet('', 'Observação', FontFieldTitle, FontFieldValues, ftString, '', TTAlignHTM.tahtmlLeft, False);
      If geraExcel.fGerarRelatorio(True) Then
        pMensagemOk('Arquivo gerado com sucesso!');

      FreeAndNil(GeraExcel);
      FreeAndNil(qryCadEmp);
    Finally
        FreeAndNil(geraExcel);
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TCotacao.pExportarExcelComparativo');
  End;



  pSetaEventosItem(True);
  pEnableControlsItens;
end;

procedure TCotacao.pExportarExcelNovo(cdsDados: TDataSet;var strNomArq: String; intIndFor: Integer; blnAplicacao, blnMsgLivre, blnTodosItens, blnMarca: Boolean;
                                     blnSemelhantes, blnCNA, blnReferencia: Boolean);
  var
    qryCadEmp: TUniQuery;
    FontFieldValues: TFont;
    FontFieldTitle: TFont;
  procedure pLeEmpresa;
    Var
      strSQL: String;
  Begin
    qryCadEmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP, ';
    strSQL := strSQL + '  EMP_NOMFAN, ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), "  ", IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP)), " - ", EMP_BAIRRO) AS EMP_ENDERE, ';
    strSQL := strSQL + '  CONCAT(CADCID.CID_NOMCID, "-", CADCID.CID_ESTADO, "   CEP: ", EMP_C_E_P_) AS EMP_NOMCID, ';
    strSQL := strSQL + '  EMP_FONE01, ';
    strSQL := strSQL + '  EMP_F_A_X_, ';
    strSQL := strSQL + '  EMP_EMAIL_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
    strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

    With qryCadEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

  end;

begin
  FIndForExportacao := intIndFor;

  If FileExists(strNomArq) Then
    If Not DeleteFile(strNomArq) Then
    Begin
      fMensagem('','Não é possível gerar o arquivo, ' +
                   'verifique se o mesmo está sendo utilizado!', ['&Ok']);
      Exit;
    End;

  Try
    geraExcel := TGeraArquivo.create(taHtml, cdsDados, frmCadCotacaoGeralCX.pgbProgresso );
    Try
      geraExcel.protegeEstrutura := fCfgSis('COPLPR', varBoolean);
      geraExcel.OnSomaTotais := pSomaTotaisCotacao;
      geraExcel.OnEscreveValorCampo := OnEscreveValorCampo;
      geraExcel.OnResumo := pMontaResumoCotacao;
      geraExcel.strFile := strNomArq;

      geraExcel.pAddTitulo(fRetNomeEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
      geraExcel.pAddTitulo(fRetFantasiaEmpresa, TGeraArquivo.fSetFont(14, [fsBold]));
      pLeEmpresa;
      geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_ENDERE').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo(qryCadEmp.FieldByName('EMP_NOMCID').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Fone.: ' + qryCadEmp.FieldByName('EMP_FONE01').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Fax..: ' + qryCadEmp.FieldByName('EMP_F_A_X_').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Email: ' + qryCadEmp.FieldByName('EMP_EMAIL_').AsString, TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('Fornecedor: ' + cdsFornecedores.FieldByName('NOMFOR').AsString , TGeraArquivo.fSetFont());
      geraExcel.pAddTitulo('DEPARTAMENTO DE COMPRAS', TGeraArquivo.fSetFont(16, [fsBold]));
      geraExcel.pAddTitulo('COTAÇÃO DE PREÇOS: ' + FieldByName('COT_NUMCOT').AsString, TGeraArquivo.fSetFont(16, [fsBold], clRed));
      geraExcel.pAddTitulo('COMPRADOR: ' + fRetNomVendRep(FieldByName('COT_CODCMP').AsString) +
                           ' - Email: ' + fCampoTabela('OPE_E_MAIL', 'CADOPE', ['OPE_CODOPE'], [FieldByName('COT_CODCMP').AsString]), TGeraArquivo.fSetFont(10, [fsBold], clBlack));

//    objGeraExcel.OnImpFiltros  := pExcelImprimeFiltros;
//    objGeraExcel.OnImpDetalhes := pImprimeDetalhes;
//    objGeraExcel.OnFimGeracao  := pFimGeracaoExcel;

      FontFieldValues:= TGeraArquivo.fSetFont(10, [], clBlack);
      FontFieldTitle := TGeraArquivo.fSetFont(10, [], clWhite);

      geraExcel.pAddTituloEditavel('DATA DE ENTREGA:', cdsFornecedores.FieldbyName('COT_DTAENT').AsString, 'B', tahtmlLeft, ftDate, False);
      geraExcel.pAddTituloEditavel('CONDIÇÃO DE PAGAMENTO:', fFormataCondPag(cdsFornecedores.FieldbyName('COT_CONPAG').AsString), 'B', tahtmlLeft, ftString, False);

      geraExcel.AddCampo('CODITE', TIT_CODIGO, FontFieldTitle, FontFieldValues);
      geraExcel.AddCampo('CODFAB', 'Código Fábrica', FontFieldTitle, FontFieldValues);
      If blnCNA Then
        geraExcel.AddCampoSemDataSet('CODCNA', 'Código CNA', FontFieldTitle, FontFieldValues, ftString, '', tahtmlUndef, False);

      geraExcel.AddCampo('DESITE', 'Descrição', FontFieldTitle, FontFieldValues);

      If blnReferencia Then
        geraExcel.AddCampo('REFERE', 'Referência', FontFieldTitle, FontFieldValues);
      If blnMarca Then
        geraExcel.AddCampo('DESMAR', 'Marca', FontFieldTitle, FontFieldValues);

      Case TipoUnidade Of
        tuUnCompra:  geraExcel.AddCampo('UNICOM', 'UN', FontFieldTitle, FontFieldValues);
        tuUnVenda:   geraExcel.AddCampo('SIGUNI', 'UN', FontFieldTitle, FontFieldValues);
      End;

      geraExcel.AddCampo('QTDITE', 'Quant.', FontFieldTitle, FontFieldValues);

      geraExcel.AddCampo('VALUNI' + fIndice(FIndForExportacao), TIT_PRECO, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0 , 99999999);
      geraExcel.AddCampo('IPIENT' + fIndice(FIndForExportacao), TIT_IPI, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);
      geraExcel.AddCampo('SUBSTI' + fIndice(FIndForExportacao), TIT_ST, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);
      geraExcel.AddCampo('FREENT' + fIndice(FIndForExportacao), TIT_FRE, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);

      If fSomarNovosImpostosDaReformaAoValorContabil Then
      Begin
        geraExcel.AddCampo('ALQCBS' + fIndice(FIndForExportacao), TIT_CBS, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);
        geraExcel.AddCampo('ALQIBS' + fIndice(FIndForExportacao), TIT_IBS, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);
        geraExcel.AddCampo('ALQ_IS' + fIndice(FIndForExportacao), TIT_IS, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 100);
      End;

      geraExcel.AddCampo('VALTOT' + fIndice(FIndForExportacao), TIT_TOT, FontFieldTitle, FontFieldValues, '', tahtmlRight, False, 0, 99999999);

      If blnAplicacao Then
        geraExcel.AddCampo('APLICA', 'Aplicação',  FontFieldTitle, FontFieldValues);

      If blnMsgLivre Then
        geraExcel.AddCampo('MSGLV1', 'Mensagem Livre',  FontFieldTitle, FontFieldValues);
      If blnSemelhantes Then
        geraExcel.AddCampo('CODSEM', 'Semelhantes', FontFieldTitle, FontFieldValues);


      geraExcel.AddTotais('TOT_UNI_' + fIndice(FIndForExportacao), 'VALUNI' + fIndice(FIndForExportacao));
      geraExcel.AddTotais('TOT_QTD_' + fIndice(FIndForExportacao), 'QTDITE' + fIndice(FIndForExportacao));
      geraExcel.AddTotais('TOT_IPI_' + fIndice(FIndForExportacao), 'IPIENT' + fIndice(FIndForExportacao));


      geraExcel.fGerarRelatorio(True);
      strNomArq := geraExcel.strFile;
    finally
      FreeAndNil(geraExcel);
    End;
  Except
    On E: Exception Do
    Begin

      pMensagensErro(E.Message, '');
    End;
  End;

  FreeAndNil(qryCadEmp);
end;


procedure TCotacao.pExcelImprimeFiltrosComparativo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; Filtros: array of String);

  procedure pTitulo(intLinha: Integer; CorDaFonte: TCorExcel; intFonte: Integer; opcAlinhamento: TAlinhamentoExcel; strTitulo: String);
    var
      strLinha: String;
  begin
    strLinha := IntToStr(intLinha);

    With Excel, Campos Do
    Begin
      Mesclar     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha);
      Alinhamento ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, opcAlinhamento);
      Negrito     ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, True);
      CorFonte    ('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, CorDaFonte);
      DefinirFonte('A' + strLinha, fGetLetraAlfa(Colunas.Count) + strLinha, Arial, intFonte);

      Escrever(intLinha, 1, strTitulo);
    End;
  end;

begin
  Excel.PintarTudo(Branco);

  pTitulo(1, Preto, 16, Centro, fRetNomeEmpresa);
  Excel.Mesclar('A1', fGetLetraAlfa(Campos.Colunas.Count) + '1'); //No BROffice se der merge 2x ele tira, e ja estava com merge.

  pTitulo(Excel.ProximaLinha, Preto, 16, Centro,'DEPARTAMENTO DE COMPRAS');

  pTitulo(Excel.ProximaLinha, Vermelho, 16, Centro, 'COTAÇÃO DE PREÇOS: ' + FieldByName('COT_NUMCOT').AsString);

  pTitulo(Excel.ProximaLinha, Preto, 10, Centro, 'COMPRADOR: ' + fRetNomVendRep(FieldByName('COT_CODCMP').AsString));

  {**************************************}
  {* INSERE UMA NOVA COLUNA NOS TITULOS *}
  {**************************************}
  With Excel Do
  Begin
    Escrever   (LinhaAtual + 1, Campos.Colunas.Count + 1, '% VAR.(*)');
    Negrito    (LinhaAtual + 1, Campos.Colunas.Count + 1, True);
    Alinhamento(LinhaAtual + 1, Campos.Colunas.Count + 1, Direita);

    CorFundo('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1), Preto);
    CorFonte('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1), Branco);
    Bordas  ('A' + IntToStr(LinhaAtual + 1), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual + 1));
  End;

End;

procedure TCotacao.pSomaTotaisComparativo(var Totais: TTotais; Dados: TDataSet);
  Var
    intContador: Integer;
begin

  For intContador := Low(arrCodFor) To High(arrCodFor) Do
  If fFornecedorAtivo(intContador) Then
  With cdsItens Do
  Begin

    Totais['TOT_GER_' + fIndice(intContador) ] := Totais['TOT_GER_' + fIndice(intContador)] + FieldByName('VALTOT' + fIndice(intContador)).AsFloat;

    If FieldByName('FORESC').AsString = arrCodFor[intContador] Then
      Totais['TOT_SEL_' + fIndice(intContador)] := Totais['TOT_SEL_' + fIndice(intContador)] + FieldByName('VALTOT' + fIndice(intContador)).AsFloat;
  End;
End;

procedure TCotacao.pSomaTotaisCotacao(DataSet: TDataSet; var ATotais: TTotaisHTML);
begin
  ATotais.Totais['TOT_UNI_' + fIndice(FIndForExportacao)].Valor := ATotais.Totais['TOT_UNI_' + fIndice(FIndForExportacao)].Valor  + DataSet.FieldByName('VALUNI' + fIndice(FIndForExportacao)).AsFloat;
  ATotais.Totais['TOT_QTD_' + fIndice(FIndForExportacao)].Valor := ATotais.Totais['TOT_QTD_' + fIndice(FIndForExportacao)].Valor  + DataSet.FieldByName('QTDITE').AsFloat;
  ATotais.Totais['TOT_IPI_' + fIndice(FIndForExportacao)].Valor := ATotais.Totais['TOT_IPI_' + fIndice(FIndForExportacao)].Valor  + DataSet.FieldByName('IPIENT' + fIndice(FIndForExportacao)).AsFloat;
End;


procedure TCotacao.pSomaTotaisComparativoNovo(DataSet: TDataSet; var ATotais: TTotaisHTML);
  Var
    intContador: Integer;
begin

  For intContador := Low(arrCodFor) To High(arrCodFor) Do
  If fFornecedorAtivo(intContador) Then
  Begin

    ATotais.Totais['TOT_GER_' + fIndice(intContador)].Valor := ATotais.Totais['TOT_GER_' + fIndice(intContador)].Valor  + cdsItens.FieldByName('VALTOT' + fIndice(intContador)).AsFloat;

    If DataSet.FieldByName('FORESC').AsString = arrCodFor[intContador] Then
      ATotais.Totais['TOT_SEL_' + fIndice(intContador)].Valor := ATotais.Totais['TOT_SEL_' + fIndice(intContador)].Valor + cdsItens.FieldByName('VALTOT' + fIndice(intContador)).AsFloat;
  End;
End;


procedure TCotacao.pMontaResumoComparativo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
  var
    intContador: Integer;
begin
  With Excel Do
  Begin
    If Quebra.NomeCampo = '[GERAL]' Then
    Begin
      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(FColForIniExcel-1) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, 'TOTAL SELECIONADO POR FORNECEDOR');

      For intContador := Low(arrCodFor) To High(arrCodFor) Do
      If fFornecedorAtivo(intContador) Then
      Begin
        Escrever(LinhaAtual, FColForIniExcel + intContador - 1, Quebra.Totais['TOT_SEL_' + fIndice(intContador)]);
        FormatoNumerico(LinhaAtual, FColForIniExcel + intContador - 1);
      End;

      Negrito ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Verde_Mar);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Branco);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(FColForIniExcel-1) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, 'TOTAL GERAL POR FORNECEDOR');

      For intContador := Low(arrCodFor) To High(arrCodFor) Do
      If fFornecedorAtivo(intContador) Then
      Begin
        Escrever(LinhaAtual, FColForIniExcel + intContador - 1, Quebra.Totais['TOT_GER_' + fIndice(intContador)]);
        FormatoNumerico(LinhaAtual, FColForIniExcel + intContador - 1);
      End;

      Negrito ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas  ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      ProximaLinha;

      Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(FColForIniExcel-1) + IntToStr(LinhaAtual));
      Escrever(LinhaAtual, 1, '(*) Percentual de Variação entre os dois menores preços.');

      ProximaLinha;
      ProximaLinha;

      Bordas  ('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual), Verde);
      Escrever(LinhaAtual, 2, 'Menor Preço');

      ProximaLinha;

      Bordas  ('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual));
      CorFundo('A' + IntToStr(LinhaAtual), 'A' + IntToStr(LinhaAtual), Amarelo);
      Escrever(LinhaAtual, 2, 'Preço Escolhido');

    End;
  End;
End;

procedure TCotacao.pMontaResumoCotacao(DataSet: TDataSet; ATotais: TTotaisHTML);
var
  Valor: TValue;
begin

  Valor.pularLinha := True;

  Valor.ColSpan := 8;
  Valor.BackgroundColor := clMoneyGreen;
  valor.FontColor := clBlack;
  valor.size:= 13;
  Valor.Value := 'TOTAL GERAL';
  Valor.alinhamento := tahtmlRight;
  geraExcel.fEscreveLinha(Valor);

  Valor.ColSpan := 1;
  Valor.alinhamento := tahtmlRight;
  valor.size:= 13;

  Valor.Value := FormatFloat('#0.00', ATotais.Totais['TOT_QTD_' + fIndice(FIndForExportacao)].Valor);
  geraExcel.fEscreveLinha(Valor);

  Valor.Value := FormatFloat('#0.00', ATotais.Totais['TOT_UNI_' + fIndice(FIndForExportacao)].Valor);
  geraExcel.fEscreveLinha(Valor);

  Valor.Value := FormatFloat('#0.00', ATotais.Totais['TOT_IPI_' + fIndice(FIndForExportacao)].Valor);
  geraExcel.fEscreveLinha(Valor);

  geraExcel.pFechaLinha;

  If fltTotVlrPed > 0 Then
  Begin
    Valor.pularLinha := True;

    Valor.ColSpan := 8;
    Valor.BackgroundColor := clMoneyGreen;
    valor.FontColor := clBlack;
    valor.size:= 13;
    Valor.Value := 'VALOR TOTAL';
    Valor.alinhamento := tahtmlRight;
    geraExcel.fEscreveLinha(Valor);

    Valor.ColSpan := 3;
    Valor.alinhamento := tahtmlRight;
    valor.size:= 13;

    Valor.Value := FormatFloat('R$ #,##0.00', fltTotVlrPed);
    geraExcel.fEscreveLinha(Valor);

    geraExcel.pFechaLinha;
  End;
end;


procedure TCotacao.pMontaResumoComparativoNovo(DataSet: TDataSet; ATotais: TTotaisHTML);
  var
    intContador: Integer;
    Valor: TValue;
begin
  Valor.pularLinha := True;
  Valor.Size := 10;

  Valor.ColSpan := 17;
  Valor.Value := 'TOTAL SELECIONADO POR FORNECEDOR';
  Valor.BackgroundColor := clTeal;
  Valor.FontColor := clWhite;
  Valor.alinhamento := tahtmlCenter;
  geraExcel.fEscreveLinha(Valor);
  Valor.ColSpan := 0;
  Valor.alinhamento := tahtmlRight;
  For intContador := Low(arrCodFor) To High(arrCodFor) Do
  If fFornecedorAtivo(intContador) Then
  Begin
    Valor.Value := FormatFloat('#0.00', ATotais.Totais['TOT_SEL_' + fIndice(intContador)].Valor);
    geraExcel.fEscreveLinha(Valor);
  End;
  geraExcel.pFechaLinha;



  Valor.pularLinha := True;

  Valor.ColSpan := 17;
  Valor.BackgroundColor := clYellow;
  valor.FontColor := clBlack;
  Valor.Value := 'TOTAL GERAL POR FORNECEDOR';
  Valor.alinhamento := tahtmlCenter;
  geraExcel.fEscreveLinha(Valor);
  Valor.ColSpan := 1;
  Valor.alinhamento := tahtmlRight;


  For intContador := Low(arrCodFor) To High(arrCodFor) Do
  If fFornecedorAtivo(intContador) Then
  Begin
    Valor.Value := FormatFloat('#0.00', ATotais.Totais['TOT_GER_' + fIndice(intContador)].Valor);
    geraExcel.fEscreveLinha(Valor);
  End;
  geraExcel.pFechaLinha;

  Valor.pularLinha := True;
  Valor.ColSpan := 17;
  Valor.Value := '(*) Percentual de Variação entre os dois menores preços.';
  Valor.BackgroundColor := clWhite;
  Valor.FontColor := clBlack;
  Valor.alinhamento := tahtmlCenter;

  geraExcel.fEscreveLinha(Valor);
  geraExcel.pFechaLinha;

  Valor.pularLinha := True;
  Valor.Value := '';
  geraExcel.fEscreveLinha(Valor);
  geraExcel.pFechaLinha;
  Valor.pularLinha := True;
  geraExcel.fEscreveLinha(Valor);
  geraExcel.pFechaLinha;

  Valor.pularLinha := True;
  Valor.ColSpan := 0;
  Valor.BackgroundColor := clGreen;
  Valor.Value := 'Menor Preço';
  geraExcel.fEscreveLinha(Valor);
  geraExcel.pFechaLinha;

  Valor.pularLinha := True;
  Valor.BackgroundColor := clYellow;
  Valor.Value := 'Preço Escolhido';
  geraExcel.fEscreveLinha(Valor);
  geraExcel.pFechaLinha;
End;


procedure TCotacao.pImprimeDetalhesComparativo(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
  var
    intContador: Integer;
    strColFor,
    strRange : String;
    stlPrecos: TStringList;
    fltPerVar: Double;
begin

  stlPrecos := TStringList.Create;
  stlPrecos.Sorted := True;

  With Excel, Campos, cdsItens Do
  Begin
    For intContador := Low(arrCodFor) To High(arrCodFor) Do
    If fFornecedorAtivo(intContador) Then
    Begin
      strColFor := 'UNITOT' + fIndice(intContador);
      strRange  := fGetLetraAlfa(ColunaPorNome[strColFor].Coluna) + IntToStr(LinhaAtual);

      If FieldByName('FORESC').AsString = arrCodFor[intContador] Then
      Begin
        CorFundo(strRange, strRange, Amarelo);
        CorFonte(strRange, strRange, Azul);
      End

      Else If FieldByName('FORMEN').AsString = arrCodFor[intContador] Then
      Begin
        CorFundo(strRange, strRange, Verde);
        CorFonte(strRange, strRange, Branco);
      End;

      If (Dados.FieldByName(strColFor).AsFloat > 0)                           Then
      Begin
        stlPrecos.Add(fStrZero(FloatToStrF(Dados.FieldByName(strColFor).AsFloat, ffFixed, 12, 2), 12));
      End;

    End;

    {*******************************************************}
    {* CALCULA % VARIAC ENTRE OS DOIS MENORES PRECOS       *}
    {****************************************************JC*}
    If stlPrecos.Count > 1 Then
    Begin
      fltPerVar := ( ( ( fStrToFloat(stlPrecos[1]) / fStrToFloat(stlPrecos[0]) ) - 1 ) * 100 );
    End
    Else
      fltPerVar := 0.00;

    FormatoNumerico(LinhaAtual, Campos.Colunas.Count + 1);
    Escrever       (LinhaAtual, Campos.Colunas.Count + 1, fltPerVar);
    Alinhamento    (LinhaAtual, Campos.Colunas.Count + 1, Direita);

    Bordas(fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual));

    If Dados.RecNo Mod 2 = 0 Then
      CorFundo(fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count + 1) + IntToStr(LinhaAtual), Cinza);
  End;

  FreeAndNil(stlPrecos);
End;

Function TCotacao.fPedeTransportadora: Boolean;
var fltValorFreteInformado: Double;
Begin
  If Not fGetFornecedoresPedidos Then
  Begin
    Result := False;
    Exit;
  End;

  FillChar(recObserv, SizeOf(recObserv), #0);

  pCriarFormularios(TfrmDigObservacoes, frmDigObservacoes);

  TfrmDigCtaFornecedores.pCopiaCta(FArrCodCta, frmDigObservacoes.arrCodCta);

  If Assigned(frmDigObservacoes.arrCodCta) And
     (Length(frmDigObservacoes.arrCodCta) = 1) Then
    frmDigObservacoes.strCodFor := frmDigObservacoes.arrCodCta[0].strCodFor;

  frmDigObservacoes.Caption := 'Encerramento da Cotação e Geração de Pedido(s)';
  frmDigObservacoes.gpbFinalPed.Visible      := blnMulLoj;
  frmDigObservacoes.rdgOpcMultiLojas.Caption := 'Encerrar a cotação e';
  frmDigObservacoes.gpbFinalPed.Caption := ' FINALIZAÇÃO DA COTAÇÃO ';
  frmDigObservacoes.strCodComprador := strCodCmp;
  fltValorFreteInformado := fCalculaFreteInformado;
  frmDigObservacoes.edtValFre.Text := FormatFloat('#0.00', (fltValorFreteInformado));
  blnAlterouFrete := False;
  frmDigObservacoes.blnCotacao := True;

  If blnMulLoj Then
    frmDigObservacoes.rdgOpcMultiLojas.ItemIndex := fCfgSis('CGPODE', varInteger);
  frmDigObservacoes.ShowModal;
  If StrToFloat(frmDigObservacoes.edtValFre.Text) > 0 Then
    blnAlterouFrete      := fltValorFreteInformado <> StrToFloat(frmDigObservacoes.edtValFre.Text);

  Result := frmDigObservacoes.blnConfirma;

  If Result Then
  With recObserv Do
  Begin
    TfrmDigCtaFornecedores.pCopiaCta(frmDigObservacoes.arrCodCta, FArrCodCta);

    blnEndLoj   := frmDigObservacoes.rdgEndEnt.ItemIndex = 1;
    blnDesmen   := frmDigObservacoes.rdgOpcMultiLojas.ItemIndex = 1;
    strCodTra   := frmDigObservacoes.strCodTra;
    strCodTraRedespacho := frmDigObservacoes.strCodTraRedespacho;

    strNomEmp   := frmDigObservacoes.edtNomEmp.Text;
    strEndere   := frmDigObservacoes.strEndere;
    strCidade   := frmDigObservacoes.strCidade;

    recObserv.strTipFre   := frmDigObservacoes.strTipFre;
    strTipFreRedespacho   := frmDigObservacoes.strTipFreRedespacho;

    strCodEve   := frmDigObservacoes.fraCentroCusto.edtCodEve.Text;
    strCodCta   := frmDigObservacoes.fraPlanoDeContas.MskCodCta.Text;

    strObsPd1   := frmDigObservacoes.strObserv1;
    strObsPd2   := frmDigObservacoes.strObserv2;
    strObsPd3   := frmDigObservacoes.strObserv3;

    strPedVen   := frmDigObservacoes.edtPedVen.Text;
    strAtenca   := frmDigObservacoes.strAtenca;
    fltValFre   := fStrToFloat(frmDigObservacoes.edtValFre.Text);
    fltDesAce   := fStrToFloat(frmDigObservacoes.edtDesAce.Text);
    blnAltFrete := blnAlterouFrete;
  End;

  FreeAndNil(frmDigObservacoes);
End;

function TCotacao.fMostraPedidosPendentesPrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strFilter: String;
    blnFiltered: Boolean;
Begin
  With cdsItens Do
  Begin
    strFilter   := Filter;
    blnFiltered := Filtered;
  End;
  Try
    FListaItensPendentes.Clear;

    With cdsItens Do
    Begin
      DisableControls;

      pSetaEventosItem(False, True, True, False);

      Filter   := '(QTDITE > 0) AND (PREESC > 0) AND GERPED = ' + QuotedStr('N') +
                         IfThen(FSelecionados, ' AND MARPED = ' + QuotedStr('S'), '');
      Filtered := True;

      pgbProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;

      cdsItens.First;

      While (Not Eof) Do
      Begin
        FListaItensPendentes.Add(QuotedStr(FieldByName('CODITE').AsString));

        Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMostraPedidosPendentres]');
    End;
  End;

  cdsItens.Filter   := strFilter;
  cdsItens.Filtered := blnFiltered;
  pSetaEventosItem(True, True, True, False);
  pEnableControlsItens;
End;

Function TCotacao.fMostraPedidosPendentes(blnSelecionados: Boolean): Boolean;
Begin
  pCriarFormularios(TfrmGravando, frmGravando);
  FSelecionados := blnSelecionados;

  frmGravando.lblGravando.Caption := 'Verificando pedidos pendentes...';
  frmGravando.fExecutarAcao := fMostraPedidosPendentesPrg;

  FfrmGravandoCorrente := frmGravando;

  frmGravando.ShowModal;
  pFreeAndNilGravando(frmGravando);

  Result := FListaItensPendentes.Count > 0;

  If FListaItensPendentes.Count > 0 Then
  Begin

    If Assigned(prcExecutaRelatorio) Then
    begin
      prcExecutaRelatorio(136, 6199, [],
                          ['LSTITE','CODEMP'],
                          [fCommaText(FListaItensPendentes),
                          IfThen(blnMulLoj,'',VS_strCodEmp)],
                          nil,
                          nil,
                          True);
    End;


    FListaItensPendentes.Clear;

  End;

End;

Function TCotacao.fSelecionaMenoresPrecosPrg(pgbProgresso: TcxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    DisableControls;

    cdsItens.First;
    If (blnMulLoj) Then
      blnAtualizaMltLojaDepois := True;
    While Not Eof Do
    Begin
      Edit;

      Post;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;

      Next;
    End;
    If (blnMulLoj) Then
    begin
      blnAtualizaMltLojaDepois := True;
      If Assigned(cdsDigMultLoja) Then
      Begin
        cdsDigMultLoja.DesvinculaCDS;
        pAtualizaCDSItensMultiLojaFornecedorEscolhidoGeral;
        cdsDigMultLoja.vinculaCDS;
      End;
      blnAtualizaMltLojaDepois := False;
    End;

    pEnableControlsItens;
  End;

  Result := True;
End;

function TCotacao.fSelecionaRecuperaCotacao(blnAlterando: Boolean): Boolean;
var
  strSQL: String;
begin
  strNumCot := '';
  blnCancelouRecupera := False;
  Result := False;
  strSQL := '';
  strSQL := strSQL + ' SELECT C.*,              ';
  strSQL := strSQL + '  C.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '  COT_CODCMP AS CODOPE,   ';
  strSQL := strSQL + '  OPE_NOMOPE AS NOMOPE,   ';
  strSQL := strSQL + '  COT_CODEMP AS CODEMP,   ';
  strSQL := strSQL + '  COT_NUMCOT AS NUMCOT,   ';
  strSQL := strSQL + '  COT_DESCRI AS DESCRI,   ';
  strSQL := strSQL + '  COT_DTACAD AS DTAPED    ';
  strSQL := strSQL + ' FROM                     ';
  strSQL := strSQL + '  COTGER_RES C            ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = COT_CODCMP ';
  strSQL := strSQL + ' WHERE COT_EXCLUI = "N"   ';
  strSQL := strSQL + '   AND COT_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If (Not FEmptyStr(FieldbyName('COT_NUMCOT').AsString)) And blnAlterando Then
    strSQL := strSQL + ' AND COT_NUMCOT = ' + QuotedStr(FieldbyName('COT_NUMCOT').AsString)
  Else
    strSQL := strSQL + ' AND IFNULL(COT_NUMCOT, "") = "" ';

  cdsCotacoes.qryQuery.SQL.text := strSQL;
  cdsCotacoes.fAbreClient(True);

  If Not cdsCotacoes.IsEmpty Then
  Begin
    cdsCotacoes.pAlinhaCampoCentro('CODOPE');
    cdsCotacoes.pAlinhaCampoCentro('CODEMP');
    cdsCotacoes.pAlinhaCampoCentro('NUMPED');
    cdsCotacoes.pAlinhaCampoCentro('DTAPED');

    pCriarFormularios(TfrmRecuperaCotacaoSelec, frmRecuperaCotacaoSelec);
    frmRecuperaCotacaoSelec.cxvPedidos.DataController.DataSource := cdsCotacoes.dtsSource;
    frmRecuperaCotacaoSelec.objCotacao := Self;
    Result := frmRecuperaCotacaoSelec.ShowModal = mrOk;
    blnCancelouRecupera := (Not Result) And (Not cdsCotacoes.IsEmpty);
    FreeAndNil(frmRecuperaCotacaoSelec);
  End;

end;

Function TCotacao.fSelecionaMenoresPrecos: Boolean;
Begin
  Try
    FManterEscolhido := False;

    pSetaEventosItem(False, True, True, False);

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde, atualizando menores preços...';
    frmGravando.fExecutarAcao := fSelecionaMenoresPrecosPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fSelecionaMenoresPrecos]');
    End;
  End;

  FManterEscolhido := True;

  pFreeAndNilGravando(frmGravando);

  FRecalculouPrecos := Result;

  pSetaEventosItem(True, True, True, False);
End;

Procedure TCotacao.pMarcaDesmarcaAtualizaPreco;
Begin
  With cdsItens Do
  Begin
    pSetaEventosItem(False);

    Edit;

    If FieldByName('ATUPRE').AsString = 'S' Then
      FieldByName('ATUPRE').AsString := 'N'
    Else
      FieldByName('ATUPRE').AsString := 'S';

    Post;

    pSetaEventosItem(True);
  End;
End;

function TCotacao.fMarcaCotacao(strSeqGer: String): Boolean;
begin
  Result := False;
  blnRecuperaCotacao := True;

  If cdsCotacoes.IsEmpty Then
  Begin
    pMensagemOk('Nenhuma Cotação para recuperar!');
    blnRecuperaCotacao := False;
    Exit;
  End;

  strSeqGerBKP := strSeqGer;
  Result := fAbreCotacao(stcAbertas, strSeqGer);
  If Result And (Locate('AUTOINCREM',strSeqGerBKP,[])) Then
  Begin
    Result := Result And fAlteraCotacao(opAlterar);
    blnRecuperaCotacao := Result;
  End
  Else
  Begin
    Result := False;
    blnRecuperaCotacao := Result;
  End;

  If Not Result Then
    strSeqGerBKP := '';
end;

Function TCotacao.fMarcaTodosAtualizaPrecoPrg(pgbProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    DisableControls;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    cdsItens.First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('ATUPRE').AsString := FMarcaAtuPre;
      Post;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;

      Next;
    End;

    pEnableControlsItens;
  End;

  Result := True;
End;

Procedure TCotacao.pMarcaTodosAtualizaPreco(blnMarcar: Boolean);
Begin
  Try
    pSetaEventosItem(False);

    pCriarFormularios(TfrmGravando, frmGravando);

    If blnMarcar Then
    Begin
      FMarcaAtuPre := 'S';
      frmGravando.lblGravando.Caption := 'Aguarde, marcando itens para atualização de preço...';
    End Else
    Begin
      FMarcaAtuPre := 'N';
      frmGravando.lblGravando.Caption := 'Aguarde, desmarcando itens para atualização de preço...';
    End;

    frmGravando.fExecutarAcao := fMarcaTodosAtualizaPrecoPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      cdsItens.EnableControls;
      pMensagensErro(E.Message, '[TCotacao.pMarcaTodosAtualizaPreco]');
    End;
  End;

  pSetaEventosItem(True);

  pFreeAndNilGravando(frmGravando);
End;

Procedure TCotacao.pDesmarcaPrecosAtualizados;
Begin
  Try
    pSetaEventosItem(False);

    pCriarFormularios(TfrmGravando, frmGravando);

    FfrmGravandoCorrente := frmGravando;

    frmGravando.lblGravando.Caption := 'Desmarcando itens...';
    frmGravando.fExecutarAcao := fDesmarcaPrecosAtualizadosPrg;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCotacao.pDesmarcaPrecosAtualizados]');
    End;
  End;

  pSetaEventosItem(True);

  pFreeAndNilGravando(frmGravando);
End;

function TCotacao.fDeletaCotacao(strAutInc: String): Boolean;
begin
  Result := True;
  Try
    FqryConsulta.SQL.Text := 'DELETE FROM COTGER WHERE AUTOINCREM = "'+ strAutInc + '"';
    FqryConsulta.ExecSQL;
  Except
    on e: Exception  do
    Begin
      Result := False;
      pMensagensErro(e.message, '[TCotacao.fDeletaCotacao]');
    end;
  End;


end;

Function TCotacao.fDesmarcaPrecosAtualizadosPrg(pgbProgresso: TcxProgressBar): Boolean;
Begin
  With cdsItens Do
  Try
    DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    pDesmarcaCotacao;

    cdsItens.First;
    while Not Eof do
    Begin
      Edit;
      FieldByName('PJAATU').AsString := 'N';
      Post;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    pEnableControlsItens;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fDesmarcaPrecosAtualizados]');
    End;
  End;
End;

Procedure TCotacao.pDesmarcaCotacao;
  Var
    qryCotIte: TUniQuery;
Begin
 qryCotIte := fCriaQuery;
  With qryCotIte, SQL Do
  Begin
    Add('UPDATE COTITE SET COT_PJAATU = "N"');
    Add('WHERE COT_SEQGER = ' + QuotedStr(strSeqGer));
    ExecSQL;
  End;
  FreeAndNil(qryCotIte);
End;

Procedure TCotacao.pFiltraItensComPreco(blnFiltrar, blnFiltrarGerados: Boolean);
Begin
  Try
    pSetaItensGrid(False);
    pSetaEventosItem(False);
    Try
      FstrFilter := '';

      If blnFiltrarGerados Then
        FstrFilter := 'GERPED = ' + QuotedStr('N');

      If FFiltrarItens Then
      Begin
        If Not fEmptyStr(FstrFilter) Then
          FstrFilter := FstrFilter + ' AND ';

        FstrFilter := FstrFilter + 'PREESC > 0';
      End;

      If FstrFilter = cdsItens.Filter Then
        Exit;


      pCriarFormularios(TfrmGravando, frmGravando);

      FfrmGravandoCorrente := frmGravando;

      If blnFiltrar Then
        frmGravando.lblGravando.Caption := 'Filtrando itens com preço...'
      Else
        frmGravando.lblGravando.Caption := 'Retirando filtro de itens com preço...';

      frmGravando.fExecutarAcao := fFiltraItensComPrecoPrg;
      frmGravando.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TCotacao.pDesmarcaPrecosAtualizados]');
      End;
    End;


    pFreeAndNilGravando(frmGravando);
  Finally
    pSetaItensGrid(True);
    pSetaEventosItem(True);
  End;
End;

Function TCotacao.fFiltraItensComPrecoPrg(prgProgresso: TCxProgressBar): Boolean;
Begin
  With cdsItens Do
  Begin
    If FstrFilter <> Filter Then
    Begin
      Application.ProcessMessages;

      Filter   := FstrFilter;

      Filtered := Not fEmptyStr(FstrFilter);
    End;
  End;

  Result := True;
End;

Procedure TCotacao.pAtualizaJaAtu;
Begin
  With FUpdateJaAtu Do
  Begin
    Close;
    ParamByName('AUTINC').AsString := cdsItens.FieldByName('AUTCOT').AsString;
    ExecSQL;
  End;
End;

Procedure TCotacao.pCriaQueryGenIte;
  var
    strSql: String;
Begin
  strSql := '';
  strSql := strSql + 'INSERT INTO ';
  strSql := strSql + '  PREITE ';
  strSql := strSql + '(PRE_DTAPRE, ';
  strSql := strSql + ' PRE_CODITE, ';
  strSql := strSql + ' PRE_CODEMP, ';
  strSql := strSql + ' AUTOINCREM, ';
  strSql := strSql + ' PRE_PRECOM_ANT, ';
  strSql := strSql + ' PRE_PRECOM, ';
  strSql := strSql + ' PRE_DESF01, ';
  strSql := strSql + ' PRE_DESF02, ';
  strSql := strSql + ' PRE_DESF03, ';
  strSql := strSql + ' PRE_DESF04, ';
  strSql := strSql + ' PRE_DESF05, ';
  strSql := strSql + ' PRE_DESF06, ';
  strSql := strSql + ' PRE_ICMENT, ';
  strSql := strSql + ' PRE_SUBFED, ';
  strSql := strSql + ' PRE_IPIENT, ';
  strSql := strSql + ' PRE_FREENT, ';
  strSql := strSql + ' PRE_VALFRE, ';
  strSql := strSql + ' PRE_ACRFIN, ';
  strSql := strSql + ' PRE_SUBSTI, ';
  strSql := strSql + ' PRE_DESADB, ';
  strSql := strSql + ' PRE_OUTVAL, ';
  strSql := strSql + ' PRE_ICMSAI, ';
  strSql := strSql + ' PRE_IMPFED, ';
  strSql := strSql + ' PRE_MLTCOM, ';
  strSql := strSql + ' PRE_DESOPE, ';
  strSql := strSql + ' PRE_PRECUS, ';
  strSql := strSql + ' PRE_PRECUS_NOV, ';

  strSql := strSql + ' PRE_DESMAX, ';
  strSql := strSql + ' PRE_DESMGE, ';
  strSql := strSql + ' PRE_DESMSU, ';
  strSql := strSql + ' PRE_DESMVM, ';
  strSql := strSql + ' PRE_DESMSM, ';
  strSql := strSql + ' PRE_DESMGM, ';

  strSql := strSql + ' PRE_COMTB1, ';
  strSql := strSql + ' PRE_COMTB2, ';
  strSql := strSql + ' PRE_COMTB3, ';
  strSql := strSql + ' PRE_COMTB4, ';
  strSql := strSql + ' PRE_COMTB5, ';
  strSql := strSql + ' PRE_COMTB6, ';
  strSql := strSql + ' PRE_COMTB7, ';

  strSql := strSql + ' PRE_MARBR1, ';
  strSql := strSql + ' PRE_MARBR1_NOV, ';
  strSql := strSql + ' PRE_PREVE1, ';
  strSql := strSql + ' PRE_PREVE1_NOV, ';
  strSql := strSql + ' PRE_MARBR2, ';
  strSql := strSql + ' PRE_MARBR2_NOV, ';
  strSql := strSql + ' PRE_PREVE2, ';
  strSql := strSql + ' PRE_PREVE2_NOV, ';
  strSql := strSql + ' PRE_MARBR3, ';
  strSql := strSql + ' PRE_MARBR3_NOV, ';
  strSql := strSql + ' PRE_PREVE3, ';
  strSql := strSql + ' PRE_PREVE3_NOV, ';
  strSql := strSql + ' PRE_MARBR4, ';
  strSql := strSql + ' PRE_MARBR4_NOV, ';
  strSql := strSql + ' PRE_PREVE4, ';
  strSql := strSql + ' PRE_PREVE4_NOV, ';
  strSql := strSql + ' PRE_MARMIN, ';
  strSql := strSql + ' PRE_MARBR5, ';
  strSql := strSql + ' PRE_MARBR5_NOV, ';
  strSql := strSql + ' PRE_PREVE5, ';
  strSql := strSql + ' PRE_PREVE5_NOV, ';
  strSql := strSql + ' PRE_MARBR6, ';
  strSql := strSql + ' PRE_MARBR6_NOV, ';
  strSql := strSql + ' PRE_PREVE6, ';
  strSql := strSql + ' PRE_PREVE6_NOV, ';
  strSql := strSql + ' PRE_MARBR7, ';
  strSql := strSql + ' PRE_MARBR7_NOV, ';
  strSql := strSql + ' PRE_PREVE7, ';
  strSql := strSql + ' PRE_PREVE7_NOV, ';
  strSql := strSql + ' PRE_QTDITE,     ';
  strSql := strSql + ' PRE_TCIFCU,     ';
  strSql := strSql + ' PRE_TSCUST,     ';
  strSql := strSql + ' PRE_DEPICO,     ';
  strSql := strSql + ' PRE_DEICMS,     ';
  strSql := strSql + ' PRE_FATREG,     ';
  strSql := strSql + ' PRE_PROPRI)     ';
  strSql := strSql + '    VALUES ( ';
  strSql := strSql + '  :DTAPRE, ';
  strSql := strSql + '  :CODITE, ';
  strSql := strSql + '  :CODEMP, ';
  strSql := strSql + '  :AUTOIN, ';
  strSql := strSql + '  :PRECOM_ANT, ';
  strSql := strSql + '  :PRECOM, ';
  strSql := strSql + '  :DESF01, ';
  strSql := strSql + '  :DESF02, ';
  strSql := strSql + '  :DESF03, ';
  strSql := strSql + '  :DESF04, ';
  strSql := strSql + '  :DESF05, ';
  strSql := strSql + '  :DESF06, ';
  strSql := strSql + '  :ICMENT, ';
  strSql := strSql + '  :SUBFED, ';
  strSql := strSql + '  :IPIENT, ';
  strSql := strSql + '  :FREENT, ';
  strSql := strSql + '  :VALFRE, ';
  strSql := strSql + '  :ACRFIN, ';
  strSql := strSql + '  :SUBSTI, ';
  strSql := strSql + '  :DESADB, ';
  strSql := strSql + '  :OUTVAL, ';
  strSql := strSql + '  :ICMSAI, ';
  strSql := strSql + '  :IMPFED, ';
  strSql := strSql + '  :MLTCOM, ';
  strSql := strSql + '  :DESOPE, ';
  strSql := strSql + '  :PRECUS, ';
  strSql := strSql + '  :PRECUS_NOV, ';

  strSql := strSql + '  :DESMAX, ';
  strSql := strSql + '  :DESMGE, ';
  strSql := strSql + '  :DESMSU, ';
  strSql := strSql + '  :DESMVM, ';
  strSql := strSql + '  :DESMSM, ';
  strSql := strSql + '  :DESMGM, ';

  strSql := strSql + '  :COMTB1,     ';
  strSql := strSql + '  :COMTB2,     ';
  strSql := strSql + '  :COMTB3,     ';
  strSql := strSql + '  :COMTB4,     ';
  strSql := strSql + '  :COMTB5,     ';
  strSql := strSql + '  :COMTB6,     ';
  strSql := strSql + '  :COMTB7,     ';

  strSql := strSql + '  :MARBR1,     ';
  strSql := strSql + '  :MARBR1_NOV, ';
  strSql := strSql + '  :PREVE1,     ';
  strSql := strSql + '  :PREVE1_NOV, ';

  strSql := strSql + '  :MARBR2,     ';
  strSql := strSql + '  :MARBR2_NOV, ';
  strSql := strSql + '  :PREVE2,     ';
  strSql := strSql + '  :PREVE2_NOV, ';

  strSql := strSql + '  :MARBR3,      ';
  strSql := strSql + '  :MARBR3_NOV, ';
  strSql := strSql + '  :PREVE3,     ';
  strSql := strSql + '  :PREVE3_NOV, ';

  strSql := strSql + '  :MARBR4,     ';
  strSql := strSql + '  :MARBR4_NOV, ';
  strSql := strSql + '  :PREVE4,     ';
  strSql := strSql + '  :PREVE4_NOV, ';

  strSql := strSql + '  :MARMIN,     ';

  strSql := strSql + '  :MARBR5,     ';
  strSql := strSql + '  :MARBR5_NOV, ';
  strSql := strSql + '  :PREVE5,     ';
  strSql := strSql + '  :PREVE5_NOV, ';

  strSql := strSql + '  :MARBR6,     ';
  strSql := strSql + '  :MARBR6_NOV, ';
  strSql := strSql + '  :PREVE6,     ';
  strSql := strSql + '  :PREVE6_NOV, ';

  strSql := strSql + '  :MARBR7,     ';
  strSql := strSql + '  :MARBR7_NOV, ';
  strSql := strSql + '  :PREVE7,     ';
  strSql := strSql + '  :PREVE7_NOV, ';
  strSql := strSql + '  :QTDITE,     ';
  strSql := strSql + '  :TCIFCU,     ';
  strSql := strSql + '  :TSCUST,     ';
  strSql := strSql + '  :DEPICO,     ';
  strSql := strSql + '  :DEICMS,     ';
  strSql := strSql + '  :FATREG,     ';
  strSql := strSql + '  :PROPRI)     ';

  qryGenIte := fCriaQuery(Self);
  qryGenIte.SQL.Clear;
  qryGenIte.SQL.Add(strSql);
End;

procedure TCotacao.pCriarNovaCotacaoComItensComItensSemCotacao(seqGerCotacaoOriginal: String);
var strNovoNumCot,
    strSeqGerNovo: String;
    qryInsert: TUniQuery;
    qryGiro: TUniQuery;
    strNovoGiro: String;
begin
  strSeqGerNovo := fRetAutoIncrem('COTGER',VS_strCodEmp);
  strNovoNumCot := fAtualizaProCod('COTGER', 'COT_NUMCOT');
  strNovoGiro := fAtualizaProCod('SEQ_COT_GIR', 'COT_CODGIR', 'COTGER', 1, Nil,
    function (const AValue: String) : String
    begin
      Result := AValue + VS_strCodEmp;
    end
  );

  qryInsert := fCriaQuery;
  qryGiro := fCriaQuery;

  Try

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO COTGER');
    qryInsert.SQL.Add('(AUTOINCREM, COT_CODEMP, COT_NUMCOT, COT_DTACAD, COT_DESCRI, COT_COMPRA, COT_CODCMP, COT_MESATU, ');
    qryInsert.SQL.Add(' COT_MESGIR, COT_MULLOJ, COT_MESSEL, COT_MESMOS, COT_NOVIPI, COT_CODDIG, COT_EMPDES, COT_CODGIR) ');
    qryInsert.SQL.Add('SELECT ' + QuotedStr(strSeqGerNovo) + ',COT_CODEMP, ');
    qryInsert.SQL.Add(QuotedStr(strNovoNumCot) + ',COT_DTACAD, COT_DESCRI, COT_COMPRA, COT_CODCMP, COT_MESATU, COT_MESGIR, COT_MULLOJ, COT_MESSEL, COT_MESMOS, COT_NOVIPI, COT_CODDIG, COT_EMPDES,  "'+ strNovoGiro + '" FROM COTGER WHERE AUTOINCREM = ' + QuotedStr(seqGerCotacaoOriginal));
    qryInsert.ExecSQL;

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO COTCFO (COT_SEQGER, COT_CODFOR, COT_CONPAG, COT_DTAENT, COT_UTILIZ)');
    qryInsert.SQL.Add('SELECT ' + QuotedStr(strSeqGerNovo) + ', COT_CODFOR, COT_CONPAG, COT_DTAENT, COT_UTILIZ FROM COTCFO WHERE COT_SEQGER = ' + QuotedStr(seqGerCotacaoOriginal));
    qryInsert.ExecSQL;

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('UPDATE COTITE SET COT_SEQGER = "' + strSeqGerNovo+ '"');
    qryInsert.SQL.Add(' WHERE COT_SEQGER = "' + seqGerCotacaoOriginal + '"');
    qryInsert.SQL.Add('   AND IFNULL(COT_FORESC, "") = ""');
    qryInsert.ExecSQL;


    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('UPDATE COTFOR SET COT_SEQGER = "'+strSeqGerNovo+'"');
    qryInsert.SQL.Add('WHERE COT_SEQGER = "' + seqGerCotacaoOriginal + '"');
    qryInsert.SQL.Add(' AND  COT_CODITE IN (SELECT COT_CODITE FROM COTITE WHERE COT_SEQGER = "' + strSeqGerNovo + '" ');
    qryInsert.SQL.Add(' AND IFNULL(COT_FORESC, "") = "")');
    qryInsert.ExecSQL;

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('UPDATE PCDCOT SET PCD_SEQGER = "'+strSeqGerNovo+'"');
    qryInsert.SQL.Add('WHERE PCD_SEQGER = "'+seqGerCotacaoOriginal+'"');
    qryInsert.SQL.Add('  AND PCD_CODITE IN (SELECT  COT_CODITE  FROM COTITE WHERE COT_SEQGER = "'+strSeqGerNovo+'" ');
    qryInsert.SQL.Add('  AND IFNULL(COT_FORESC, "") = "")');

    qryInsert.ExecSQL;

    qryInsert.SQL.Clear;
    qryGiro.SQL.Clear;
    qryGiro.SQL.Add('SELECT INT_NOMFRM, INT_VALKEY, INT_NOMCOM, INT_VALCOM, AUTOINCREM, INT_CODOPE');
    qryGiro.SQL.Add('  FROM CADINT');
    qryGiro.SQL.Add(' WHERE INT_VALKEY = "'+seqGerCotacaoOriginal+'"');
    qryGiro.SQL.Add('   AND INT_NOMFRM = "frmDigGiroEstoqueCotacao"');
    qryGiro.Open;

    pInsereCadIntExtra(FieldByName('COT_CODGIR').AsString, strNovoGiro, 'frmDigGiroEstoqueCotacao');


  Finally
    FreeAndnil(qryInsert);
    FreeAndnil(qryGiro);
  End;


end;

Procedure TCotacao.pIncluiPreIte(DataSet: TDataSet; dtaDtaAtu: TDateTime; strProPri: String);
  var
    intCont: Integer;
Begin
  With DataSet Do
  Begin
    fExecutaSQL(' DELETE FROM PREITE ' +
                ' WHERE PRE_DTAPRE = ' + fCurrentDate(dtaDtaAtu)  + '  AND ' +
                '       PRE_CODITE = ' + QuotedStr(FieldByName('CODITE').AsString));

    qryGenIte.Close;

    qryGenIte.ParamByName('PRECOM_ANT').AsFloat  := FieldByName('PRECOM').AsFloat;
    qryGenIte.ParamByName('PRECOM').AsFloat  := FieldByName('PREESC').AsFloat;
    qryGenIte.ParamByName('DESF01').AsFloat  := FieldByName('DESF01').AsFloat;
    qryGenIte.ParamByName('DESF02').AsFloat  := FieldByName('DESF02').AsFloat;
    qryGenIte.ParamByName('DESF03').AsFloat  := FieldByName('DESF03').AsFloat;
    qryGenIte.ParamByName('DESF04').AsFloat  := FieldByName('DESF04').AsFloat;
    qryGenIte.ParamByName('DESF05').AsFloat  := FieldByName('DESF05').AsFloat;
    qryGenIte.ParamByName('DESF06').AsFloat  := FieldByName('DESF06').AsFloat;
    qryGenIte.ParamByName('ICMENT').AsFloat  := FieldByName('ICMENT').AsFloat;
    qryGenIte.ParamByName('SUBFED').AsFloat  := FieldByName('SUBFED').AsFloat;
    qryGenIte.ParamByName('IPIENT').AsFloat  := FieldByName('IPIENT').AsFloat;
    qryGenIte.ParamByName('FREENT').AsFloat  := FieldByName('FREENT').AsFloat;
    qryGenIte.ParamByName('VALFRE').AsFloat  := FieldByName('VALFRE').AsFloat;
    qryGenIte.ParamByName('ACRFIN').AsFloat  := FieldByName('ACRFIN').AsFloat;
    qryGenIte.ParamByName('SUBSTI').AsFloat  := FieldByName('SUBSTI').AsFloat;
    qryGenIte.ParamByName('DESADB').AsFloat  := FieldByName('DESADB').AsFloat;
    qryGenIte.ParamByName('OUTVAL').AsFloat  := FieldByName('OUTVAL').AsFloat;
    qryGenIte.ParamByName('ICMSAI').AsFloat  := FieldByName('ICMSAI').AsFloat;
    qryGenIte.ParamByName('IMPFED').AsFloat  := FieldByName('IMPFED').AsFloat;

    qryGenIte.ParamByName('DESOPE').AsFloat  := FieldByName('DESOPE').AsFloat;

    qryGenIte.ParamByName('PRECUS').AsFloat     := FieldByName('PRECUS').AsFloat;
    qryGenIte.ParamByName('PRECUS_NOV').AsFloat := FieldByName('NOVCUS').AsFloat;

    qryGenIte.ParamByName('DESMAX').Value  := Null;
    qryGenIte.ParamByName('DESMGE').Value  := Null;
    qryGenIte.ParamByName('DESMSU').Value  := Null;
    qryGenIte.ParamByName('DESMVM').Value  := Null;
    qryGenIte.ParamByName('DESMSM').Value  := Null;
    qryGenIte.ParamByName('DESMGM').Value  := Null;

    qryGenIte.ParamByName('MARMIN').Value  := Null;
    qryGenIte.ParamByName('MLTCOM').Value  := Null;

    qryGenIte.ParamByName('COMTB1').AsFloat  := FieldByName('COMTB1').AsFloat;
    qryGenIte.ParamByName('COMTB2').AsFloat  := FieldByName('COMTB2').AsFloat;
    qryGenIte.ParamByName('COMTB3').AsFloat  := FieldByName('COMTB3').AsFloat;
    qryGenIte.ParamByName('COMTB4').AsFloat  := FieldByName('COMTB4').AsFloat;
    qryGenIte.ParamByName('COMTB5').AsFloat  := FieldByName('COMTB5').AsFloat;
    qryGenIte.ParamByName('COMTB6').AsFloat  := FieldByName('COMTB6').AsFloat;
    qryGenIte.ParamByName('COMTB7').AsFloat  := FieldByName('COMTB7').AsFloat;

    For intCont := 1 To Length(VS_strTabPrc) Do
    Begin
      qryGenIte.ParamByName('MARBR' + IntToStr(intCont)).AsFloat := FieldByName('MARBR' + IntToStr(intCont)).AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont)).AsFloat := FieldByName('PREVE' + IntToStr(intCont)).AsFloat;

      qryGenIte.ParamByName('MARBR' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('NOVBR' + IntToStr(intCont)).AsFloat;
      qryGenIte.ParamByName('PREVE' + IntToStr(intCont) + '_NOV').AsFloat := FieldByName('NOVVE' + IntToStr(intCont)).AsFloat;
    End;

    qryGenIte.ParamByName('CODITE').AsString   := FieldByName('CODITE').AsString;
    qryGenIte.ParamByName('DTAPRE').AsDateTime := dtaDtaAtu;
    qryGenIte.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    qryGenIte.ParamByName('AUTOIN').AsString   := fRetAutoIncrem('PREITE', VS_strCodEmp);
    qryGenIte.ParamByName('QTDITE').AsFloat    := FieldByName('QTDITE').AsFloat;
    qryGenIte.ParamByName('TCIFCU').AsFloat    := FieldByName('TCIFCU').AsFloat;
    qryGenIte.ParamByName('TSCUST').AsFloat    := FieldByName('TSCUST').AsFloat;
    qryGenIte.ParamByName('DEPICO').AsFloat    := FieldByName('DEPICO').AsFloat;
    qryGenIte.ParamByName('DEICMS').AsFloat    := FieldByName('DEICMS').AsFloat;
    qryGenIte.ParamByName('FATREG').AsFloat    := FieldByName('FATREG').AsFloat;
    qryGenIte.ParamByName('PROPRI').AsString   := strProPri;

  End;

  qryGenIte.ExecSQL;
  qryGenIte.Close;
End;

Function TCotacao.fProgramaAtualizaPrecos: Boolean;
Begin
  Try
    pSetaEventosItem(False);

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Agendando atualizando dos preços...';
    frmGravando.fExecutarAcao := fProgramaAtualizaPrecosPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;

    If frmGravando.blnConfirma then
      pMensagemOk('Operação concluida com sucesso!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fProgramaAtualizaPrecos]');
    End;
  End;

  pSetaEventosItem(True);
  pFreeAndNilGravando(frmGravando);
End;

Function TCotacao.fProgramaAtualizaPrecosPrg(pgbProgresso: TcxProgressBar):Boolean;
  Var
    strProPri: String;
Begin
  With cdsItens Do
  Try
    DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;

    FfrmGravandoCorrente.lblGravando.Caption := 'Filtrando itens para atualização de preços...';

    Filter   := 'PREESC > 0 AND ATUPRE = ' + QuotedStr('S');
    Filtered := True;

    If IsEmpty Then
    Begin
      pMensagemOk('Nenhum item marcado para atualização!');
      Result := False;
    End Else
    Begin

      FfrmGravandoCorrente.lblGravando.Caption := 'Agendando atualizando dos preços...';

      strProPri := fRetSequencial('PROPRI', VS_strCodEmp);

      cdsItens.First;
      while Not Eof do
      Begin

        fStartTransaction;

        pIncluiPreIte(cdsItens, FdtaDtaAtu, strProPri);
        pAtualizaJaAtu;

        fCommit;

        Edit;
        FieldByName('PJAATU').AsString := 'S';

        Post;

        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;

      Result := True;
    End;

    FfrmGravandoCorrente.lblGravando.Caption := 'Retirando filtro de atualização de preços...';
    Filter   := 'PREESC > 0';

    pEnableControlsItens;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TCotacao.fProgramaAtualizaPrecosPrg]');
    End;
  End;
End;

Function TCotacao.fAtualizaPrecos: Boolean;
  Var
    strMensagem: String;
Begin
  Try
    Result := False;

    strMensagem := 'Confirma a atualização dos Preços/Margens para todos os itens marcados?';
    FdtaDtaAtu := VS_Date;

    If Not (fPergunta(strMensagem) And
            ffrmData(FdtaDtaAtu, '', 'Digite a Data para a Atualização de Preços', VS_Date)) Then
      Exit;

    Result := fProgramaAtualizaPrecos;

    If Result And (FdtaDtaAtu <= VS_Date) Then
    Begin
      pOpeProd(AltEfetivacaoPrecos);

      If fPergunta('Recarregar os preços que foram atualizados no cadastro de produtos?') Then
        fRecarregaPrecosProdutos;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TCotacao.fAtualizaPrecos]');
    End;
  End;
End;


Function TCotacao.fRecarregaPrecosProdutos: Boolean;
Begin
  Try
    pSetaEventosItem(False, True, True, False);

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Recarregando preços...';
    frmGravando.fExecutarAcao := fRecarregaPrecosProdutosPrg;

    FfrmGravandoCorrente := frmGravando;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRecarregaPrecosProdutos]');
    End;
  End;

  pSetaEventosItem(True, True, True, False);
  pFreeAndNilGravando(frmGravando);
End;

Function TCotacao.fRecarregaPrecosProdutosPrg(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    strIteAnt: String;
Begin
  With cdsItens Do
  Try
    DisableControls;

    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;

    FfrmGravandoCorrente.lblGravando.Caption := 'Filtrando itens para recarregar preços...';

    Filter   := 'PREESC > 0 AND ATUPRE = ' + QuotedStr('S');
    Filtered := True;

    FfrmGravandoCorrente.lblGravando.Caption := 'Carregando preços...';

    cdsItens.First;
    while Not Eof do
    Begin
      strIteAnt := FieldbyName('CODITE').AsString;
      FLoadPrecos.Close;
      FLoadPrecos.ParambyName('CODITE').AsString := FieldbyName('CODITE').AsString;
      FLoadPrecos.ParambyName('CODEMP').AsString := VS_strCodEmp;

      FLoadPrecos.Open;

      If Not FLoadPrecos.IsEmpty Then
      Begin
        Edit;

        For intContador := 0 To FLoadPrecos.Fields.Count - 1 Do
          FieldByName(FLoadPrecos.Fields[intContador].FieldName).Value := FLoadPrecos.Fields[intContador].Value;

        FieldByName('ATUPRE').AsString := 'N';

        Post;
      End;

      If strIteAnt = FieldbyName('CODITE').AsString Then
        Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    FfrmGravandoCorrente.lblGravando.Caption := 'Retirando filtro de atualização de preços...';
    Filter   := 'PREESC > 0';

    pEnableControlsItens;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TCotacao.fProgramaAtualizaPrecosPrg]');
    End;
  End;
End;


Procedure TCotacao.pSetaAfterScrollItensGiro;
Begin
  cdsItens.AfterScroll := pAfterScrollItensGiro;
  pAfterScrollItensGiro(cdsItens);
End;

procedure TCotacao.pTiraAfterScrollItens;
Begin
  cdsItens.AfterScroll := Nil;
End;

procedure TCotacao.pHeranca;
  Var
    strAutInc: String;
begin
  If (Not Active) Or IsEmpty Then
    Exit;

  If (fMensagem('', 'Confirma a inclusão herdando da Cotação ' +
                     FieldbyName('COT_NUMCOT').AsString + ' ?', ['&Sim', '&Não']) = 1)  And
                     fIncluiComHeranca(strAutInc, False) Then
  Begin
    fAbreCotacao(stcAbertas);

    If Assigned(frmCadCotacaoCX) Then
    With frmCadCotacaoCX Do
    rdgStatus.ItemIndex := 0;

    If Locate('AUTOINCREM',strAutInc,[]) Then
      pMensagemOk('Cotação incluida com sucesso!');
  End;

End;
function TCotacao.fIncluiCotacao(strAutInc,
                                 strNumCot,
                                 strDescri,
                                 strCompra,
                                 strMulLoj,
                                 strMesAtu: String;
                                 intMesGir,
                                 intMesMos: Integer;
                                 blnBaixar: Boolean;
                                 strCodDig: String;
                                 strCodTct: String;
                                 strNovIpi: String;
                                 ACodGir: String;
                                 blnTabRestaura: Boolean = False;
                                 blnUpdTabRestaura: Boolean = False;
                                 strCodSolicitacao: string = ''): Boolean;
  Var
    qryCotacao: TUniQuery;
    blnInclusao: Boolean;
Begin
  Try
    blnInclusao := False;
    blnIncluiuGerRes := False;
    qryCotacao := fCriaQuery;
    With qryCotacao, SQL Do
    Begin
      Clear;
      If blnTabRestaura Then
      Begin
        If (Not fEmptyStr(strAutInc)) Then
        Begin
          Add(' UPDATE COTGER_RES SET      ');
          Add('   COT_CODEMP = :CODEMP,    ');
          Add('   COT_NUMCOT = :NUMCOT,    ');
          Add('   COT_DESCRI = :DESCRI,    ');
          Add('   COT_CODCMP = :COMPRA,    ');
          Add('   COT_CODTCT = :CODTCT,    ');
          Add('   COT_CODDIG = :CODDIG,    ');
          Add('   COT_DTAFIN = :DTAFIN,    ');
          Add('   COT_DTACAD = :DTACAD,    ');
          Add('   COT_MULLOJ = :MULLOJ,    ');
          Add('   COT_MESGIR = :MESGIR,    ');
          Add('   COT_MESMOS = :MESMOS,    ');
          Add('   COT_MESATU = :MESATU,    ');
          Add('   COT_CODGIR = :CODGIR,    ');
          Add('   COT_NOVIPI = :NOVIPI,    ');
          Add('   COT_CODSOL = :CODSOL     ');
          Add(' WHERE AUTOINCREM = :AUTINC ');
        End
        Else
        Begin
          If (Not fEmptyStr(strSeqGer)) And (fEmptyStr(strAutInc)) Then
            blnIncluiuGerRes := True;
          blnInclusao := True;
          Add('INSERT INTO COTGER_RES (');
          Add('  AUTOINCREM,');
          Add('  COT_CODEMP,');
          Add('  COT_NUMCOT,');
          Add('  COT_DESCRI,');
          Add('  COT_CODCMP,');
          Add('  COT_CODTCT,');
          Add('  COT_CODDIG,');
          Add('  COT_DTAFIN,');
          Add('  COT_DTACAD,');
          Add('  COT_MULLOJ,');
          Add('  COT_MESGIR,');
          Add('  COT_MESMOS,');
          Add('  COT_MESATU,');
          Add('  COT_CODGIR,');
          Add('  COT_NOVIPI,');
          Add('  COT_CODSOL ');
          Add(') VALUES (');
          Add('  :AUTINC,');
          Add('  :CODEMP,');
          Add('  :NUMCOT,');
          Add('  :DESCRI,');
          Add('  :COMPRA,');
          Add('  :CODTCT,');
          Add('  :CODDIG,');
          Add('  :DTAFIN,');
          Add('  :DTACAD,');
          Add('  :MULLOJ,');
          Add('  :MESGIR,');
          Add('  :MESMOS,');
          Add('  :MESATU,');
          Add('  :CODGIR,');
          Add('  :NOVIPI,');
          Add('  :CODSOL)');
        End;
      End
      Else
      Begin
        If blnUpdTabRestaura Then
        Begin
          Add(' UPDATE COTGER SET      ');
          Add('   COT_CODEMP = :CODEMP,    ');
          Add('   COT_NUMCOT = :NUMCOT,    ');
          Add('   COT_DESCRI = :DESCRI,    ');
          Add('   COT_CODCMP = :COMPRA,    ');
          Add('   COT_CODTCT = :CODTCT,    ');
          Add('   COT_CODDIG = :CODDIG,    ');
          Add('   COT_DTAFIN = :DTAFIN,    ');
          Add('   COT_DTACAD = :DTACAD,    ');
          Add('   COT_MULLOJ = :MULLOJ,    ');
          Add('   COT_MESGIR = :MESGIR,    ');
          Add('   COT_MESMOS = :MESMOS,    ');
          Add('   COT_MESATU = :MESATU,    ');
          Add('   COT_CODGIR = :CODGIR,    ');
          Add('   COT_NOVIPI = :NOVIPI,    ');
          Add('   COT_CODSOL = :CODSOL     ');
          Add(' WHERE AUTOINCREM = :AUTINC ');
        End
        Else
        Begin
          Add('INSERT INTO COTGER (');
          Add('  AUTOINCREM,');
          Add('  COT_CODEMP,');
          Add('  COT_NUMCOT,');
          Add('  COT_DESCRI,');
          Add('  COT_CODCMP,');
          Add('  COT_CODTCT,');
          Add('  COT_CODDIG,');
          Add('  COT_DTAFIN,');
          Add('  COT_DTACAD,');
          Add('  COT_MULLOJ,');
          Add('  COT_MESGIR,');
          Add('  COT_MESMOS,');
          Add('  COT_MESATU,');
          Add('  COT_CODGIR,');
          Add('  COT_NOVIPI,');
          Add('  COT_CODSOL ');
          Add(') VALUES (');
          Add('  :AUTINC,');
          Add('  :CODEMP,');
          Add('  :NUMCOT,');
          Add('  :DESCRI,');
          Add('  :COMPRA,');
          Add('  :CODTCT,');
          Add('  :CODDIG,');
          Add('  :DTAFIN,');
          Add('  :DTACAD,');
          Add('  :MULLOJ,');
          Add('  :MESGIR,');
          Add('  :MESMOS,');
          Add('  :MESATU,');
          Add('  :CODGIR,');
          Add('  :NOVIPI,');
          Add('  :CODSOL)');
          blnInclusao := True;
        End;
      End;

      If (Not blnTabRestaura) Or (blnTabRestaura And (Not fEmptyStr(strAutInc))) Then
        ParamByName('AUTINC').AsString := strAutInc;
      ParamByName('NUMCOT').AsString := strNumCot;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DESCRI').AsString := strDescri;
      ParamByName('COMPRA').AsString := strCompra;
      ParamByName('MULLOJ').AsString := strMulLoj;
      ParamByName('DTACAD').AsDate   := VS_Date;

      ParamByName('MESGIR').AsInteger := intMesGir;
      ParamByName('MESMOS').AsInteger := intMesMos;
      ParamByName('MESATU').AsString  := strMesAtu;
      ParamByName('CODGIR').AsString  := ACodGir;

      If Not fEmptyStr(strCodTct) Then
        ParamByName('CODTCT').AsString  := strCodTct
      Else
        ParamByName('CODTCT').Value := Null;

      If Not fEmptyStr(strCodDig) Then
        ParamByName('CODDIG').AsString  := strCodDig
      Else
        ParamByName('CODDIG').Value := strCompra;

      ParamByName('NOVIPI').AsString := strNovIpi;

      If blnBaixar Then
        ParamByName('DTAFIN').AsDate   := VS_Date
      Else
        ParamByName('DTAFIN').Clear;

      if Params.FindParam('CODSOL') <> nil then
        If Not fEmptyStr(strCodSolicitacao) Then
          ParamByName('CODSOL').AsString:= strCodSolicitacao
        Else
          ParamByName('CODSOL').Value := Null;

      ExecSQL;

      If blnInclusao Then
      begin
        If blnTabRestaura And fEmptyStr(strAutInc) Then
          strSeqGerBKP := fLastInsertID;
      End;

    End;
    FreeAndNil(qryCotacao);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiCotacao]');
    End;
  End;
End;

function TCotacao.fIncluiCotacaoItens_CopiaSeguranca(blnApenasItemsFocado: Boolean = False): Boolean;
var
  strSQL: String;
  strAutIncCotIte: String;
  qryTmp: TUniQuery;

begin
  If fEmptyStr(strSeqGerBKP) Then
    Exit(True);

  Try
    If not cdsItens.IsEmpty Then
    Begin
      qryTMP := fCriaQuery;
      Try
        strAutIncCotIte := VarToStr(fCampoTabela('AUTOINCREM', 'COTITE_RES', ['COT_CODITE', 'COT_SEQGER'], [cdsItens.FieldByName('CODITE').AsString, strSeqGerBKP]));

        strSQL := '';
        If FEmptyStr(strAutIncCotIte) Then
        Begin
          strSQL := strSQL + ' INSERT INTO COTITE_RES (';
          strSQL := strSQL + '   COT_SEQGER, ';
          strSQL := strSQL + '   COT_CODITE, ';
          strSQL := strSQL + '   COT_QTDITE, ';
          strSQL := strSQL + '   COT_DESITE, ';
          strSQL := strSQL + '   COT_PJAATU, ';
          strSQL := strSQL + '   COT_FORMEN, ';
          strSQL := strSQL + '   COT_FORESC, ';
          strSQL := strSQL + '   COT_GERPED  ';
          strSQL := strSQL + ' ) VALUES ( ';
          strSQL := strSQL + '   :SEQGER, ';
          strSQL := strSQL + '   :CODITE, ';
          strSQL := strSQL + '   :QTDITE, ';
          strSQL := strSQL + '   :DESITE, ';
          strSQL := strSQL + '   :PJAATU, ';
          strSQL := strSQL + '   :FORMEN, ';
          strSQL := strSQL + '   :FORESC, ';
          strSQL := strSQL + '   :GERPED) ';
        End
        Else
        Begin
          strSQL := strSQL + ' UPDATE COTITE_RES SET ';
          strSQL := strSQL + ' COT_QTDITE  = :QTDITE, ';
          strSQL := strSQL + ' COT_DESITE  = :DESITE, ';
          strSQL := strSQL + ' COT_PJAATU  = :PJAATU, ';
          strSQL := strSQL + ' COT_FORMEN  = :FORMEN, ';
          strSQL := strSQL + ' COT_FORESC  = :FORESC, ';
          strSQL := strSQL + ' COT_GERPED  = :GERPED ';
          strSQL := strSQL + ' WHERE AUTOINCREM  = :AUTINC'
        End;
        qryTMP.SQL.Add(strSQL);

        If Not FEmptyStr(strAutIncCotIte) Then
          qryTMP.ParamByName('AUTINC').AsString := strAutIncCotIte
        Else
        Begin
          qryTMP.ParamByName('SEQGER').AsString := strSeqGerBKP;
          qryTMP.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
        End;
        qryTMP.ParamByName('QTDITE').AsFloat  := cdsItens.FieldByName('QTDITE').AsFloat;
        qryTMP.ParamByName('DESITE').AsString := cdsItens.FieldByName('DESITE').AsString;
        qryTMP.ParamByName('PJAATU').AsString := cdsItens.FieldByName('PJAATU').AsString;
        qryTMP.ParamByName('FORMEN').AsString := cdsItens.FieldByName('FORMEN').AsString;
        qryTMP.ParamByName('FORESC').AsString := cdsItens.FieldByName('FORESC').AsString;
        qryTMP.ParamByName('GERPED').AsString := fRetGerPed(cdsItens.FieldByName('CODITE').AsString);
        qryTMP.ExecSQL;
      Finally
        FreeAndNil(qryTMP);
      End;
    End;

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiCotacaoItens_CopiaSeguranca]');
    End;
  End;

end;

function TCotacao.fIncluiFornecedores_CopiaSeguranca(blnRegJaExistente: Boolean; strCodFor, strUtiLiz: String; strCndPag: String = ''; dtaDtaEnt: TDate = 0): Boolean;
var
  qryTmp: TUniQuery;
begin
  Try
    //COTCFO_RES
    qryTMP := fCriaQuery;
    qryTMP.SQL.Text := 'SELECT * FROM COTCFO_RES WHERE COT_SEQGER = ' + QuotedStr(strSeqGerBKP);
    qryTMP.Open;

    If Not blnRegJaExistente then
    Begin
      If qryTMP.Locate('COT_CODFOR', strCodFor, []) Then
      Begin
        qryTMP.Edit
      End
      Else
      Begin
        qryTMP.Append;
        qryTMP.FieldByName('COT_SEQGER').AsString   := strSeqGerBKP;
      End;
      qryTMP.FieldByName('COT_CODFOR').AsString   := strCodFor;
      qryTMP.FieldByName('COT_UTILIZ').AsString   := strUtiLiz;
      If Not fEmptyStr(strCndPag) Then
        qryTMP.FieldByName('COT_CONPAG').AsString   := strCndPag;
      If dtaDtaEnt <> 0 Then
        qryTMP.FieldByName('COT_DTAENT').AsDateTime := dtaDtaEnt;
      qryTMP.Post;
    End;

    If opeOperac = opAlterar Then
    Begin
      If Not cdsFornecedores.IsEmpty Then
      Begin
        {intRecNo := cdsItens.RecNo;}
        cdsFornecedores.DisableControls;
        cdsFornecedores.First;
        While Not cdsFornecedores.Eof Do
        Begin
          If (Not qryTMP.Locate('COT_CODFOR', cdsFornecedores.FieldbyName('COT_CODFOR').AsString, [])) Then
          Begin
            qryTMP.Append;
            qryTMP.FieldByName('COT_SEQGER').AsString   := strSeqGerBKP;
            qryTMP.FieldByName('COT_CODFOR').AsString   := cdsFornecedores.FieldByName('COT_CODFOR').AsString;
            qryTMP.FieldByName('COT_UTILIZ').AsString   := cdsFornecedores.FieldByName('COT_UTILIZ').AsString;
            qryTMP.FieldByName('COT_CONPAG').AsString   := cdsFornecedores.FieldByName('COT_CONPAG').AsString;
            qryTMP.FieldByName('COT_ANCORA').AsString   := cdsFornecedores.FieldByName('COT_ANCORA').AsString;
            qryTMP.FieldByName('COT_SKYPEC').AsString   := cdsFornecedores.FieldByName('COT_SKYPEC').AsString;
            qryTMP.FieldByName('COT_PITSTO').AsString   := cdsFornecedores.FieldByName('COT_PITSTO').AsString;
            qryTMP.FieldByName('COT_DTAENT').AsDateTime := cdsFornecedores.FieldByName('COT_DTAENT').AsDateTime;
            qryTMP.Post;
          End;
          cdsFornecedores.Next;
        End;
        {If cdsFornecedores.RecNo <> intRecNo Then
          cdsFornecedores.RecNo := intRecNo;}
        cdsFornecedores.EnableControls;
      End;
    End;

    FreeAndNil(qryTMP);
    Result:= True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiFornecedores_CopiaSeguranca]');
    End;
  End;

end;

function TCotacao.fIncluiItensHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
  Var
    qryItens,
    qryTmp: TUniQuery;
    strAutIncTmp: String;
Begin
  Try
    qryItens := fCriaQuery;
    qryTmp   := fCriaQuery;

    With qryItens, SQL Do
    Begin
      Clear;
      Add('SELECT ');
      Add('  *');
      Add('FROM ');
      If blnCopiaSeguranca Then
        Add('  COTITE_RES ')
      Else
        Add('  COTITE ');
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;

      Open;

      If Not IsEmpty Then
      Begin
        First;
        If blnUpdTabRestaura Then
        Begin
          qryTmp.Close;
          qryTmp.SQL.Clear;
          qryTmp.SQL.Add('DELETE FROM COTITE WHERE COT_SEQGER = :SEQGER; ');
          qryTmp.ParamByName('SEQGER').AsString := strAutInc;
          qryTmp.ExecSQL;
        End;

        While Not Eof Do
        Begin
          qryTmp.Close;
          qryTmp.SQL.Clear;
          strAutIncTmp := fRetAutoIncrem('COTITE', VS_strCodEmp);
          qryTmp.SQL.Add('INSERT INTO COTITE (AUTOINCREM, COT_SEQGER, COT_CODITE, COT_QTDITE, COT_DESITE, COT_PJAATU, COT_FORMEN, COT_FORESC, COT_GERPED) VALUES ');
          qryTmp.SQL.Add(' (:AUTINC, :SEQGER, :CODITE, :QTDITE, :DESITE, :PJAATU, :FORMEN, :FORESC, :GERPED) ');
          qryTmp.ParamByName('AUTINC').AsString := strAutIncTmp;
          qryTmp.ParamByName('SEQGER').AsString := strAutInc;
          qryTmp.ParamByName('CODITE').AsString := FieldByName('COT_CODITE').AsString;
          qryTmp.ParamByName('QTDITE').AsFloat  := FieldByName('COT_QTDITE').AsFloat;
          qryTmp.ParamByName('DESITE').AsString := FieldByName('COT_DESITE').AsString;
          qryTmp.ParamByName('PJAATU').AsString := Iif(blnCopiaSeguranca, FieldByName('COT_PJAATU').AsString, 'N');
          qryTmp.ParamByName('FORMEN').AsString := FieldByName('COT_FORMEN').AsString;
          qryTmp.ParamByName('FORESC').AsString := FieldByName('COT_FORESC').AsString;
          qryTmp.ParamByName('GERPED').AsString := FieldByName('COT_GERPED').AsString;
          qryTmp.ExecSQL;
          Next;
        End;
      End;
    End;

    FreeAndNil(qryItens);
    FreeAndNil(qryTmp);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensHeranca]');
    End;
  End;
End;

function TCotacao.fIncluiItensMultilojasHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca, blnUpdTabRestaura: Boolean): Boolean;
  var
    qryPcdCot: TUniQuery;
begin
  Try
    qryPcdCot := fCriaQuery;
    With qryPcdCot, SQL Do
    Begin
      Clear;
      If blnUpdTabRestaura Then
        Add(' DELETE FROM PCDCOT WHERE PCD_SEQGER = :AUTINC; ');
      Add(' INSERT INTO PCDCOT (PCD_SEQGER, PCD_CODITE, PCD_EMPDES, PCD_QTDITE) ');
      Add(' SELECT ');
      Add('  :AUTINC,');
      Add('  PCD_CODITE, ');
      Add('  PCD_EMPDES, ');
      Add('  PCD_QTDITE  ');
      Add('FROM ');
      If blnCopiaSeguranca Then
        Add('  PCDCOT_RES ')
      Else
        Add('  PCDCOT ');
      Add('WHERE PCD_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
    End;
    FreeAndNil(qryPcdCot);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensMultilojasHeranca]');
    End;
  End;
end;

function TCotacao.fIncluiItensMultilojas_CopiaSeguranca(blnApenasItemsFocado: Boolean = False): Boolean;
  Var
    qryPcdCot: TUniQuery;
    qryPcdCotSQL: TUniQuery;
    sltListaInsert: TStringList;
    strInsert: String;
    blnFiltered: Boolean;
    //intRecNo: Integer;
    strFilter: String;
    qryPcdCotSQLDelete: TUniQuery;
    Procedure pInsertLotePCDCOT;
    Begin
      If sltListaInsert.Count > 0 Then
      Begin
        qryPcdCot.SQL.Text := AnsiReplaceStr(AnsiReplaceStr(fSQLPCDCOTInsert, 'PCDCOT', 'PCDCOT_RES'), 'INSERT', 'REPLACE');
        qryPcdCot.SQL.Add(sltListaInsert.Text);
        qryPcdCot.ExecSQL;
        sltListaInsert.Clear;
      End;
    End;
Begin
  strFilter   := cdsItensMultiLojas.Filter;
  blnFiltered := cdsItensMultiLojas.Filtered;
  //intRecNo    := cdsItensMultiLojas.RecNo;

  qryPcdCot := fCriaQuery;
  qryPcdCotSQL := fCriaQuery;
  qryPcdCotSQLDelete := fCriaQuery;

  qryPcdCotSQLDelete.Close;
  qryPcdCotSQLDelete.SQL.Clear;

  With cdsItensMultiLojas Do
  Begin
    sltListaInsert := TStringList.Create;

    If opeOperac = opAlterar Then
    Begin
      cdsItensMultiLojas.Filter    := 'ITE_ALTERA = ' + QuotedStr('S') + ' AND (ITE_QTDITE > 0 OR ITE_ALTERA = ' + QuotedStr('S') + ')' ;
      If blnApenasItemsFocado Then
        cdsItensMultiLojas.Filter := ' (ITE_CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) +')';
      Filtered  := True;
    End

    Else
    Begin
      Filter    := 'ITE_QTDITE > 0' ;
      If blnApenasItemsFocado Then
        cdsItensMultiLojas.Filter := ' (ITE_CODITE = ' + QuotedStr(cdsItens.FieldByName('CODITE').AsString) +')';
      Filtered  := True;
    End;

    Application.ProcessMessages;

    cdsItensMultiLojas.First;

    While Not cdsItensMultiLojas.Eof Do
    Begin
      qryPcdCot.Close;

      If fEmptyStr(FieldByName('ITE_SEQCOT').AsString) Then
      Begin
        If ((FieldByName('ITE_QTDITE').AsFloat) > 0 ) Then
        Begin
          strInsert := '(' + QuotedStr(strSeqGerBKP) + ', ' +
                             QuotedStr(FieldByName('ITE_CODITE').AsString) + ', ' +
                             QuotedStr(FieldByName('ITE_CODEMP').AsString) + ', ' +
                             AnsiReplaceStr(FormatFloat('#0.0000', FieldByName('ITE_QTDITE').AsFloat), ',', '.') +
                        ')';

          If sltListaInsert.Count = 0 Then
            sltListaInsert.Add(strInsert)
          Else
            sltListaInsert.Add(', ' + strInsert);
        End
        Else If (blnApenasItemsFocado) And ((RoundTo(FieldByName('ITE_QTDITE').AsFloat,-4)) = 0 )Then
        Begin
          qryPcdCotSQLDelete.SQL.Add(AnsiReplaceStr(fSQLPCDCOTDelete(FieldByName('ITE_CODITE').AsString,
                                                                         FieldByName('ITE_CODEMP').AsString,
                                                                         strSeqGerBKP), 'PCDCOT', 'PCDCOT_RES'));
        End;

      End Else
      Begin
        qryPcdCotSQL.SQL.Add(AnsiReplaceStr(fSQLPCDCOTUpdate(FieldByName('ITE_CODITE').AsString,
                                                          FieldByName('ITE_CODEMP').AsString,
                                                          FieldByName('ITE_QTDITE').AsFloat,
                                                          strSeqGerBKP), 'PCDCOT', 'PCDCOT_RES'));


      End;

      If sltListaInsert.Count > 1000 Then
        pInsertLotePCDCOT;

      If qryPcdCotSQL.SQL.Count > 500 Then
      Begin
        qryPcdCotSQL.ExecSQL;
        qryPcdCotSQL.SQL.Clear;
      End;

      cdsItensMultiLojas.Next;

      Application.ProcessMessages;
    End;

    pInsertLotePCDCOT;
    If qryPcdCotSQL.SQL.Count > 0 Then
      qryPcdCotSQL.ExecSQL;

    If (blnApenasItemsFocado) And (qryPcdCotSQLDelete.SQL.Count > 0) Then
      qryPcdCotSQLDelete.ExecSQL;

  End;

  sltListaInsert.Clear;
  FreeAndNil(sltListaInsert);
  FreeAndNil(qryPcdCot);
  FreeAndNil(qryPcdCotSQL);
  FreeAndNil(qryPcdCotSQLDelete);

  cdsItensMultiLojas.Filter   := strFilter;
  cdsItensMultiLojas.Filtered := blnFiltered;
  //cdsItensMultiLojas.RecNo    := intRecNo;
  Result := True;
end;

function TCotacao.fIncluiFornecedoresHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
  Var
    qryCfo: TUniQuery;
Begin
  Try

    qryCfo := fCriaQuery;
    With qryCfo, SQL Do
    Begin
      Clear;
      If blnUpdTabRestaura Then
        Add(' DELETE FROM COTCFO WHERE COT_SEQGER = :AUTINC; ');

      Add('INSERT INTO COTCFO (COT_SEQGER, COT_CODFOR, COT_CONPAG, COT_INIINT, COT_ANCORA, COT_SKYPEC, COT_PITSTO, COT_DTAENT, COT_UTILIZ)');
      Add('SELECT ');
      Add('  :AUTINC,');
      Add('  COT_CODFOR, ');
      Add('  COT_CONPAG, ');
      Add('  COT_INIINT, ');
      Add('  COT_ANCORA, ');
      Add('  COT_SKYPEC, ');
      Add('  COT_PITSTO, ');
      Add('  COT_DTAENT, ');
      Add('  COT_UTILIZ  ');
      Add('FROM ');
      If blnCopiaSeguranca Then
        Add('  COTCFO_RES ')
      Else
        Add('  COTCFO ');
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
    End;
    FreeAndNil(qryCfo);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiFornecedoresHeranca]');
    End;
  End;
End;

procedure TCotacao.pReiniciaIntegracao(AIdIntegracao: Integer);
begin
  cdsFornecedores.Edit;
  case AIdIntegracao of
    idRedeAncora: cdsFornecedores.FieldByName('COT_ANCORA').AsInteger := 1;
    idRedeSkyPecas: cdsFornecedores.FieldByName('COT_SKYPEC').AsInteger := 1;
  End;
  cdsFornecedores.Post;
end;

procedure TCotacao.pReiniciarCotacaoPitStop();
var ProcessaApi: TProcessaApi;
begin
  ProcessaApi := TProcessaApi.Create;
  Try
    ProcessaApi.strNumCot := FieldByName('COT_NUMCOT').AsString;
    ProcessaApi.cdsFornecedores := cdsFornecedores;
    ProcessaApi.funcCodForToIndex := fCodForToIndex;
    ProcessaApi.funcIndice := fIndice;
    ProcessaApi.RedePitStop:= RedePitStop;
    ProcessaApi.Handle := frmCadCotacaoGeralCX.Handle;
    ProcessaApi.SeqGerRes := strSeqGerBKP;
    ProcessaApi.FAtualizaStatusCotCFOPitStopAncaora := pAtualizaStatusCotCFOPitStopAncaora;
    ProcessaApi.pCancelaCotacaoPitStop;
  Finally
    FreeAndNil(ProcessaApi);
  End;
End;


function TCotacao.fIncluiItensFornecHeranca(strAutInc, strSeqGer: String; blnCopiaSeguranca: Boolean; blnUpdTabRestaura: Boolean): Boolean;
  Var
    qryItens: TUniQuery;
Begin
  Try

    qryItens := fCriaQuery;
    With qryItens, SQL Do
    Begin
      Clear;

      If blnUpdTabRestaura Then
        Add('DELETE FROM COTFOR WHERE COT_SEQGER = :SEQGER; ');

      Add('INSERT INTO COTFOR (COT_SEQGER, COT_CODFOR, COT_CODITE, COT_VALUNI, COT_SUBSTI, COT_IPIENT, COT_STATUS, COT_FREENT, COT_UNITOT, ');
      Add('                    COT_ALQCBS, COT_ALQIBS, COT_ALQ_IS) ');
      Add('SELECT ');
      Add('  :AUTINC,');
      If blnCopiaSeguranca Then
      Begin
        Add('  COT_CODFOR, ');
        Add('  COT_CODITE, ');
        Add('  COT_VALUNI, ');
        Add('  COT_SUBSTI, ');
        Add('  COT_IPIENT, ');
        Add('  COT_STATUS, ');
        Add('  COT_FREENT, ');
        Add('  COT_UNITOT, ');
        Add('  COT_ALQCBS, ');
        Add('  COT_ALQIBS, ');
        Add('  COT_ALQ_IS  ');
        Add(' FROM         ');
        Add('  COTFOR_RES  ');
      End
      Else
      Begin
        Add('  COT_CODFOR, ');
        Add('  COT_CODITE, ');
        Add('  0.0,        ');
        Add('  0.0,        ');
        Add('  0.0,        ');
        Add('  0,          ');
        Add('  0.0,        ');
        Add('  0.0,        ');
        Add('  0.0,        ');
        Add('  0.0,        ');
        Add('  0.0         ');
        Add(' FROM         ');
        Add('  COTFOR      ');
      End;
      Add('WHERE COT_SEQGER = :SEQGER');

      ParamByName('SEQGER').AsString := strSeqGer;
      ParamByName('AUTINC').AsString := strAutInc;

      ExecSQL;
    End;
    FreeAndNil(qryItens);

    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensFornecHeranca]');
    End;
  End;
End;

function TCotacao.fIncluiItensFornec_CopiaSeguranca(blnIncluido: Boolean = false; AcodFor: String = ''): Boolean;
var
  intContador: Integer;
  strMarPed,
  strCodForCds,
  strCotEsc: String;
  function fRemoveVirgula(Value: String): String;
  begin
    Result := AnsiReplaceStr(Value, ',', '.');
    If fEmptyStr(Result) Then
      Result := '0';
  End;

begin
  Result:= True;
  Try
    If not cdsItens.IsEmpty Then
    Begin
      If blnIncluido Then
      Begin
        FqryConsulta.SQL.Clear;
        FqryConsulta.SQL.Add('INSERT INTO COTFOR_RES (COT_SEQGER,');
        FqryConsulta.SQL.Add('                        COT_CODFOR,');
        FqryConsulta.SQL.Add('                        COT_CODITE,');
        FqryConsulta.SQL.Add('                        COT_VALUNI,');
        FqryConsulta.SQL.Add('                        COT_SUBSTI,');
        FqryConsulta.SQL.Add('                        COT_IPIENT,');
        FqryConsulta.SQL.Add('                        COT_STATUS,');
        FqryConsulta.SQL.Add('                        COT_FREENT,');
        FqryConsulta.SQL.Add('                        COT_UNITOT)');
        FqryConsulta.SQL.Add('                SELECT  ' + strSeqGerBKP + ',');
        FqryConsulta.SQL.Add('                       "'+AcodFor+'",');
        FqryConsulta.SQL.Add('                       I.COT_CODITE,');
        FqryConsulta.SQL.Add('                       0,');
        FqryConsulta.SQL.Add('                       0,');
        FqryConsulta.SQL.Add('                       0,');
        FqryConsulta.SQL.Add('                       0,');
        FqryConsulta.SQL.Add('                       0,');
        FqryConsulta.SQL.Add('                       0');
        FqryConsulta.SQL.Add('                  FROM COTITE_RES I  ');
        FqryConsulta.SQL.Add('                 WHERE I.COT_SEQGER = "'+strSeqGerBKP+'"');
        FqryConsulta.ExecSQL;
      End
      Else
      Begin

        FqryConsulta.SQL.Clear;
        If AcodFor <> '' Then
        Begin
          intContador := fCodForToIndex(AcodFor);
          strMarPed := IIf((cdsItens.FieldByName('MARPED').AsString = 'S') And (arrCodFor[intContador] = cdsItens.FieldByName('FORESC').AsString), '1', '0');
          strCotEsc := IIf(arrCodFor[intContador] = cdsItens.FieldByName('FORESC').AsString, '1', '0');

          If fCampoTabela('COUNT(1)', 'COTFOR_RES', ['COT_SEQGER', 'COT_CODITE', 'COT_CODFOR'], [strSeqGerBKP, cdsItens.FieldByName('CODITE').AsString, arrCodFor[intContador]]) > 0 Then
          begin
            FqryConsulta.SQL.Add('UPDATE COTFOR_RES ');
            FqryConsulta.SQL.Add('   SET COT_VALUNI = '+ fRemoveVirgula(cdsItens.FieldByName('VALUNI' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_IPIENT = '+ fRemoveVirgula(cdsItens.FieldByName('IPIENT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_FREENT = '+ fRemoveVirgula(cdsItens.FieldByName('FREENT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_UNITOT = '+ fRemoveVirgula(cdsItens.FieldByName('UNITOT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_SUBSTI = '+ fRemoveVirgula(cdsItens.FieldByName('SUBSTI' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_ALQCBS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQCBS' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_ALQIBS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQIBS' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add('       COT_ALQ_IS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQ_IS' + fIndice(intContador)).AsString));
            FqryConsulta.SQL.Add(' WHERE COT_SEQGER = "'+strSeqGerBKP+'"');
            FqryConsulta.SQL.Add('   AND COT_CODITE = "'+cdsItens.FieldByName('CODITE').AsString+'"');
            FqryConsulta.SQL.Add('   AND COT_CODFOR = "'+arrCodFor[intContador]+'"; ');
          End
          Else
          Begin
            FqryConsulta.SQL.Add('INSERT INTO COTFOR_RES( ');
            FqryConsulta.SQL.Add('       COT_VALUNI, ');
            FqryConsulta.SQL.Add('       COT_IPIENT, ');
            FqryConsulta.SQL.Add('       COT_FREENT, ');
            FqryConsulta.SQL.Add('       COT_UNITOT, ');
            FqryConsulta.SQL.Add('       COT_SUBSTI, ');
            FqryConsulta.SQL.Add('       COT_ALQCBS, ');
            FqryConsulta.SQL.Add('       COT_ALQIBS, ');
            FqryConsulta.SQL.Add('       COT_ALQ_IS, ');
            FqryConsulta.SQL.Add('       COT_SEQGER, ');
            FqryConsulta.SQL.Add('       COT_CODITE, ');
            FqryConsulta.SQL.Add('       COT_CODFOR) VALUES ( ');

            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('VALUNI' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('IPIENT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('FREENT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('UNITOT' + fIndice(intContador)).AsString)+',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('SUBSTI' + fIndice(intContador)).AsString)+ ',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQCBS' + fIndice(intContador)).AsString)+ ',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQIBS' + fIndice(intContador)).AsString)+ ',');
            FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQ_IS' + fIndice(intContador)).AsString)+ ',');
            FqryConsulta.SQL.Add('"' + strSeqGerBKP+'",');
            FqryConsulta.SQL.Add('"' + cdsItens.FieldByName('CODITE').AsString+'",');
            FqryConsulta.SQL.Add('"' + arrCodFor[intContador]+'"); ');

          End;


        End
        Else
        Begin
          For intContador := 1 To INT_MAX_FORNECEDOR Do
          Begin
            If fEmptyStr(arrCodFor[intContador]) Then
              Break;
            strCodForCds := fGetCodForByPosArrCodFor(intContador);
            If fFornecedorAtivo(intContador) Then
            Begin
              strMarPed := IIf((cdsItens.FieldByName('MARPED').AsString = 'S') And (strCodForCds = cdsItens.FieldByName('FORESC').AsString), '1', '0');
              strCotEsc := IIf(strCodForCds = cdsItens.FieldByName('FORESC').AsString, '1', '0');
              If fCampoTabela('COUNT(1)', 'COTFOR_RES', ['COT_SEQGER', 'COT_CODITE', 'COT_CODFOR'], [strSeqGerBKP, cdsItens.FieldByName('CODITE').AsString, strCodForCds]) > 0 Then
              begin
                FqryConsulta.SQL.Add('UPDATE COTFOR_RES ');
                FqryConsulta.SQL.Add('   SET COT_VALUNI = '+ fRemoveVirgula(cdsItens.FieldByName('VALUNI' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_IPIENT = '+ fRemoveVirgula(cdsItens.FieldByName('IPIENT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_FREENT = '+ fRemoveVirgula(cdsItens.FieldByName('FREENT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_UNITOT = '+ fRemoveVirgula(cdsItens.FieldByName('UNITOT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_SUBSTI = '+ fRemoveVirgula(cdsItens.FieldByName('SUBSTI' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_ALQCBS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQCBS' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_ALQIBS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQIBS' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add('       COT_ALQ_IS = '+ fRemoveVirgula(cdsItens.FieldByName('ALQ_IS' + fIndice(intContador)).AsString));
                FqryConsulta.SQL.Add(' WHERE COT_SEQGER = "'+strSeqGerBKP+'"');
                FqryConsulta.SQL.Add('   AND COT_CODITE = "'+cdsItens.FieldByName('CODITE').AsString+'"');
                FqryConsulta.SQL.Add('   AND COT_CODFOR = "'+strCodForCds+'"; ');
              End
              Else
              Begin
                FqryConsulta.SQL.Add('INSERT INTO COTFOR_RES( ');
                FqryConsulta.SQL.Add('       COT_VALUNI, ');
                FqryConsulta.SQL.Add('       COT_IPIENT, ');
                FqryConsulta.SQL.Add('       COT_FREENT, ');
                FqryConsulta.SQL.Add('       COT_UNITOT, ');
                FqryConsulta.SQL.Add('       COT_SUBSTI, ');
                FqryConsulta.SQL.Add('       COT_ALQCBS, ');
                FqryConsulta.SQL.Add('       COT_ALQIBS, ');
                FqryConsulta.SQL.Add('       COT_ALQ_IS, ');
                FqryConsulta.SQL.Add('       COT_SEQGER, ');
                FqryConsulta.SQL.Add('       COT_CODITE, ');
                FqryConsulta.SQL.Add('       COT_CODFOR) VALUES ( ');

                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('VALUNI' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('IPIENT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('FREENT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('UNITOT' + fIndice(intContador)).AsString)+',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('SUBSTI' + fIndice(intContador)).AsString)+ ',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQCBS' + fIndice(intContador)).AsString)+ ',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQIBS' + fIndice(intContador)).AsString)+ ',');
                FqryConsulta.SQL.Add(fRemoveVirgula(cdsItens.FieldByName('ALQ_IS' + fIndice(intContador)).AsString)+ ',');
                FqryConsulta.SQL.Add('"' + strSeqGerBKP+'",');
                FqryConsulta.SQL.Add('"' + cdsItens.FieldByName('CODITE').AsString+'",');
                FqryConsulta.SQL.Add('"' + strCodForCds+'"); ');
              End
            End;
          End;
        End;
        If FqryConsulta.SQl.Text <> '' Then
          FqryConsulta.ExecSQL;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fIncluiItensFornec_CopiaSeguranca]');
    End;
  End;
End;


function TCotacao.fIncluir_CopiaSeguranca: Boolean;
  Var
    blnConfirma: Boolean;
Begin
  Try
    fStartTransaction;

    blnConfirma := fIncluiCotacao(strSeqGerBKP,
                                  FieldByName('COT_NUMCOT').AsString,
                                  FieldByName('COT_DESCRI').AsString,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_MULLOJ').AsString,
                                  FieldByName('COT_MESATU').AsString,
                                  FieldByName('COT_MESGIR').AsInteger,
                                  FieldByName('COT_MESMOS').AsInteger,
                                  False,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_CODTCT').AsString,
                                  FieldByName('COT_NOVIPI').AsString,
                                   FieldByName('COT_CODGIR').AsString,
                                  True, //Restaura
                                  False,
                                  FieldByName('COT_CODSOL').AsString);

    If blnIncluiuGerRes Then
    begin
      blnConfirma := blnConfirma And fAjustaTabelaRes(strSeqGerBKP, strSeqGer);
      blnIncluiuGerRes := False;
    End
    Else
    begin
      blnConfirma := blnConfirma And fIncluiCotacaoItens_CopiaSeguranca;
      blnConfirma := blnConfirma And fIncluiFornecedores_CopiaSeguranca(True,'','','',0);
      blnConfirma := blnConfirma And fIncluiItensFornec_CopiaSeguranca;
      If blnMulLoj Then
        blnConfirma := blnConfirma And fIncluiItensMultilojas_CopiaSeguranca;
    end;

    If blnConfirma Then
    Begin
      fCommit;
      Result := TRUE;
    End Else
    Begin
      fRollBack;
      Result := FALSE;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fIncluir_CopiaSeguranca]');
    End;
  End;
end;

function TCotacao.fIncluir_CopiaSeguranca_AtualizaCapa: Boolean;
  Var
    blnConfirma: Boolean;
Begin
  Try
    If FEmptyStr(strSeqGerBKP) Then
       Exit(True);

    fStartTransaction;

    blnConfirma := fIncluiCotacao(strSeqGerBKP,
                                  FieldByName('COT_NUMCOT').AsString,
                                  FieldByName('COT_DESCRI').AsString,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_MULLOJ').AsString,
                                  FieldByName('COT_MESATU').AsString,
                                  FieldByName('COT_MESGIR').AsInteger,
                                  FieldByName('COT_MESMOS').AsInteger,
                                  False,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_CODTCT').AsString,
                                  FieldByName('COT_NOVIPI').AsString,
                                  FieldByName('COT_CODGIR').AsString,
                                  True, //Restaura
                                  False,
                                  FieldByName('COT_CODSOL').AsString);

    If blnConfirma Then
    Begin
      fCommit;
      Result := TRUE;
    End Else
    Begin
      fRollBack;
      Result := FALSE;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fIncluir_CopiaSeguranca_AtualizaCapa]');
    End;
  End;
end;

function TCotacao.fIncluiComHeranca(Var strAutInc: String; blnCopiaSeguranca: Boolean): Boolean;
  Var
    blnConfirma: Boolean;
    blnUpdate: Boolean;
Begin
  blnUpdate := False;
  Try
    fStartTransaction;

    If not blnCopiaSeguranca Then
    Begin
      strAutInc := fRetAutoIncrem('COTGER',VS_strCodEmp);
      strNumCot := fAtualizaProCod('COTGER', 'COT_NUMCOT');
    End
    Else
    Begin
      If FEmptyStr(FieldByName('COT_NUMCOT').AsString) Then
      Begin
        strAutInc := fRetAutoIncrem('COTGER',VS_strCodEmp);
        strNumCot := fAtualizaProCod('COTGER', 'COT_NUMCOT');
      End
      Else
      Begin
        strAutInc := VarToStr(fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT', 'COT_CODEMP'], [FieldByName('COT_NUMCOT').AsString, VS_strCodEmp]));
        strNumCot := FieldByName('COT_NUMCOT').AsString;
        blnUpdate := True;
      End;
    End;

    blnConfirma := fIncluiCotacao(strAutInc,
                                  strNumCot,
                                  FieldByName('COT_DESCRI').AsString,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_MULLOJ').AsString,
                                  FieldByName('COT_MESATU').AsString,
                                  FieldByName('COT_MESGIR').AsInteger,
                                  FieldByName('COT_MESMOS').AsInteger,
                                  False,
                                  strLoginUsuarioLogado,
                                  FieldByName('COT_CODTCT').AsString,
                                  FieldByName('COT_NOVIPI').AsString,
                                  FieldByName('COT_CODGIR').AsString,
                                  False,      //Restaura
                                  blnUpdate); //Update

    blnConfirma := blnConfirma And fIncluiItensHeranca(strAutInc,
                                                       FieldByName('AUTOINCREM').AsString,
                                                       blnCopiaSeguranca, //Restaura
                                                       blnUpdate);        //Update

    blnConfirma := blnConfirma And fIncluiFornecedoresHeranca(strAutInc,
                                                              FieldByName('AUTOINCREM').AsString,
                                                              blnCopiaSeguranca, //Restaura
                                                              blnUpdate);        //Update

    blnConfirma := blnConfirma And fIncluiItensFornecHeranca(strAutInc,
                                                             FieldByName('AUTOINCREM').AsString,
                                                             blnCopiaSeguranca, //Restaura
                                                             blnUpdate);        //Update

    If blnMulLoj Then
      blnConfirma := blnConfirma And fIncluiItensMultilojasHeranca(strAutInc,
                                                                   FieldByName('AUTOINCREM').AsString,
                                                                   blnCopiaSeguranca, //Restaura
                                                                   blnUpdate);        //Update

    If blnConfirma Then
    Begin
      fCommit;
      Result := TRUE;
    End Else
    Begin
      fRollBack;
      Result := FALSE;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fIncluiComHeranca]');
    End;
  End;

End;

function TCotacao.fAdicionaFornecedoresGruposCotacao: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde, incluindo fornecedores...';

    frmGravando.fExecutarAcao := fAdicionaFornecedoresGruposPrg;

    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[fAdicionaFornecedoresGruposCotacao]');
    End;
  End;

  pFreeAndNil(frmGravando);

  cdsItens.EnableControls;
End;

function TCotacao.fAdicionaFornecedoresGruposPrg(prgProgresso: TCxProgressBar): Boolean;
  Var
    stlItens: TStringList;
    intIndex: Integer;
    qryCadFor: TUniQuery;
Begin
  Result := True;

  stlItens := TStringList.Create;
  stlItens.Sorted := True;

  prgProgresso.Properties.Max := cdsItens.RecordCount;

  cdsItens.DisableControls;
  cdsItens.First;

  While Not cdsItens.Eof Do
  Begin

    If Not stlItens.Find(cdsItens.FieldByName('CODITE').AsString, intIndex) Then
      stlItens.Add(cdsItens.FieldByName('CODITE').AsString);

    cdsItens.Next;

    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  prgProgresso.Position := 0;
  Application.ProcessMessages;

  qryCadFor := fCriaQuery;
  With qryCadFor, SQL Do
  Begin
    Add('SELECT');
    Add('  FOR_CODFOR, ');
    Add('  FOR_NOMFOR, ');
    Add('  FOR_DIAENT, ');
    Add('  FOR_CNDPAG  ');
    Add('FROM  ');
    Add('  REPRFO ');
    Add(' INNER JOIN CADFOR ON FOR_CODFOR = REL_CODFOR ');
    Add('WHERE');

    If stlItens.Count > 0 Then
      Add('  REL_CODITE IN (' + fCommaText(stlItens, True) + ')')
    Else
      Add(' FALSE');

    Open;

    prgProgresso.Properties.Max := RecordCount;

    While Not Eof Do
    Begin

      If Not fIncluiFornecedor(FieldByName('FOR_CODFOR').AsString,
                               FieldByName('FOR_NOMFOR').AsString,
                               FieldByName('FOR_CNDPAG').AsString,
                               VS_DATE +  FieldByName('FOR_DIAENT').AsInteger) Then
      Begin
        Result := False;
        Break;
      End;

      Next;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    If IsEmpty Then
      pMensagemOk('Nenhum fornecedor encontrado para os itens dessa cotação!')

    Else If Result Then
      pMensagemOk('Fornecedores incluidos com sucesso!');

  End;

  FreeAndNil(qryCadFor);

  stlItens.Clear;
  FreeAndNil(stlItens);
End;

Procedure TCotacao.pMarDesGerPed;
Begin
  With cdsItens Do
  Begin
    Edit;

    If FieldByName('GERPED').AsString = 'S' Then
      FieldByName('GERPED').AsString := 'N'
    Else
      FieldByName('GERPED').AsString := 'S';

    Post;
  End;
End;

Procedure TCotacao.pMarDesExcluirItens;
Begin
  With cdsItens Do
  Begin
    First;
    While not Eof do
    Begin
      Edit;

      FieldByName('EXCLUI').AsString := IfThen(blnMarDesAtual,'S','N');

      Post;
      Next;
    End;
  End;
  blnMarDesAtual := not blnMarDesAtual;
End;

Procedure TCotacao.pMarcaTodosGerPed(blnMarcar: Boolean);
  Var
    frmGravando: TfrmGravando;
Begin
  Try
    If blnMarcar Then
      FMarDes := 'S'
    Else
      FMarDes := 'N';

    pCriarFormularios(TfrmGravando, frmGravando);

    frmGravando.lblGravando.Caption := 'Aguarde, atualizando itens...';

    frmGravando.fExecutarAcao := fMarcaTodosGerPed;

    frmGravando.Showmodal;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fAdicionaFornecedoresGruposCotacao]');
    End;
  End;

  pFreeAndNil(frmGravando);

  cdsItens.EnableControls;
End;

Function TCotacao.fMarcaTodosGerPed(prgProgresso: TcxProgressBar): Boolean;
Begin

  With cdsItens Do
  Begin
    prgProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    DisableControls;

    cdsItens.First;

    While Not Eof Do
    Begin
      Edit;
      FieldByName('GERPED').AsString := FMarDes;
      Post;

      prgProgresso.Position := prgProgresso.Position + 1;
      Application.ProcessMessages;

      Next;
    End;

    pEnableControlsItens;
  End;

  Result := True;

End;

Procedure TCotacao.pMarDesMarPed;
Begin

  With cdsItens Do
  Begin
    Edit;

    If FieldByName('MARPED').AsString = 'S' Then
      FieldByName('MARPED').AsString := 'N'
    Else
      FieldByName('MARPED').AsString := 'S';

    Post;
  End;

End;

Procedure TCotacao.pMarDesMarPedTodos;
  Var
    frmGravando: TfrmGravando;
Begin
    With cdsItens Do
    Try
      If IsEmpty Then
        Exit;

      If FieldByName('MARPED').AsString = 'S' Then
        FMarDes := 'N'
      Else
        FMarDes := 'S';

      pCriarFormularios(TfrmGravando, frmGravando);

      frmGravando.lblGravando.Caption := 'Aguarde, atualizando itens...';

      frmGravando.fExecutarAcao := fMarcaTodosMarPed;

      frmGravando.Showmodal;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[pMarDesMarPedTodos]');
      End;
    End;

    pFreeAndNil(frmGravando);

    cdsItens.EnableControls;
  End;

Function TCotacao.fMarcaTodosMarPed(prgProgresso: TcxProgressBar): Boolean;
Begin
  cdsItens.BeforePost := nil;
  Try
    With cdsItens Do
    Begin
      prgProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;

      DisableControls;

      cdsItens.First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('MARPED').AsString := FMarDes;
        Post;

        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;

        Next;
      End;

      pEnableControlsItens;
    End;

    Result := True;
  Finally
    cdsItens.BeforePost := pBeforePostItens;
  End;
End;

procedure TCotacao.pEditarSimilar(strCodIte: String; strCodSim: String; curQuantidade: Currency; Exclui: String);
Var
  strFilter: String;
  blnFiltered: Boolean;
  intRecNo: Integer;
Begin
  intRecNo := cdsItens.RecNo;
  strFilter := cdsItens.Filter;
  blnFiltered := cdsItens.Filtered;

  cdsItens.DisableControls;
  cdsItens.Filter := 'ITESIM = ''S'' AND CODSIM = ' + strCodSim.QuotedString;
  cdsItens.Filtered := True;
  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    cdsItens.Edit;
    cdsItens.FieldByName('QTDITE').AsCurrency := curQuantidade;
    cdsItens.FieldByName('EXCLUI').AsString := Exclui;
    cdsItens.Post;
    cdsItens.Next;
  End;
  cdsItens.Filter := strFilter;
  cdsItens.Filtered := blnFiltered;
  cdsItens.RecNo := intRecNo;
  cdsItens.EnableControls;
End;

procedure TCotacao.pIncluirItemSimilar(strCodIte, strCodSim: String; fltQtdIte, fltDiaEst, fltDiaSug, fltMedVen: Double; blnSomarQuantidade: Boolean);
Var
  qryProSim: TUniQuery;
  strDesIte: String;
  strIteSim: String;
begin
  qryProSim := fCriaQuery(nil);
  Try
    qryProSim.SQL.Add('SELECT ');
    qryProSim.SQL.Add('  I.ITE_CODITE');
    qryProSim.SQL.Add('FROM ');
    qryProSim.SQL.Add('  CADITE I');
    qryProSim.SQL.Add('INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ');
    qryProSim.SQL.Add('WHERE ');
    qryProSim.SQL.Add('  I.ITE_ITEATI = "S"');
    qryProSim.SQL.Add('  AND I.ITE_CODSIM = :CODSIM');
    qryProSim.SQL.Add('  AND I.ITE_PRISIM <> "S"');
    qryProSim.SQL.Add('  AND I.ITE_CODITE <> :CODITE' );
    qryProSim.SQL.Add('  AND G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qryProSim.ParamByName('CODSIM').AsString := strCodSim;
    qryProSim.ParamByName('CODITE').AsString := strCodIte;
    qryProSim.Open;
    While Not qryProSim.Eof Do
    Begin
      strIteSim := qryProSim.FieldByName('ITE_CODITE').AsString;
      If fCarregaItem(strIteSim) Then
      Begin
        strDesIte := dtsCadIteEdicao.FieldByName('DESITE').AsString;

        If fIncluiItem(strIteSim, strDesIte, fltQtdIte, fltDiaEst, fltDiaSug, fltMedVen, blnSomarQuantidade, true{blnSimilar}) Then
        Begin
          pIncluiNaListaConsulta(strIteSim);

          //INCLUIR COPIA DE SEGURANÇA
          If cdsItens.Locate('CODITE', strIteSim, []) Then
            fIncluir_CopiaSeguranca;
        End;
      End;
      qryProSim.Next;
    End;
    cdsItens.Locate('CODITE', strCodIte, [])
  Finally
    FreeAndNil(qryProSim);
  End;
end;

procedure TCotacao.pMarcarSimilar;
Var
  blnFiltered: Boolean;
  strFilter: String;
  cdsSimialr: TZClient;
  intRecNo: Integer;
Begin
  If Not FblnCOTSIM Then
    Exit;

  intRecNo := cdsItens.RecNo;
  strFilter := cdsItens.Filter;

  blnFiltered := cdsItens.Filtered;
  cdsItens.Filtered := True;

  cdsItens.DisableControls;
  cdsSimialr := TZClient.Create(Self, '');

  cdsSimialr.Data := cdsItens.Data;
  cdsSimialr.Filter := 'CODSIM <> '''' AND PRISIM = ''S''';
  cdsSimialr.Filtered := True;
  cdsSimialr.First;
  While Not cdsSimialr.Eof Do
  Begin
    cdsItens.Filter := 'ITESIM = ''N'' AND PRISIM = ''N'' AND CODSIM = ' +
      cdsSimialr.FieldByName('CODSIM').AsString.QuotedString;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      cdsItens.Edit;
      cdsItens.FieldByName('ITESIM').AsString := 'S';
      cdsItens.Post;
    End;

    cdsSimialr.Next;
  End;
  pFreeAndNil(cdsSimialr);

  cdsItens.Filter := strFilter;
  cdsItens.Filtered := blnFiltered;
  cdsItens.RecNo := intRecNo;
  pEnableControlsItens;
End;


procedure TCotacao.pIniciaSegundaEtapaCotacao;
var ProcessaApi: TProcessaApi;
begin
  cdsFornecedores.DisableControls;
  Try
    cdsFornecedores.Filter := 'COT_PITSTO = '+ TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteRecotarPreco).ToString;
    cdsFornecedores.Filtered := True;
    If cdsFornecedores.IsEmpty Then
    Begin
      pMensagemOk('Sem fornecedores para importar segunda cotação.');
      Exit;
    End;

    ProcessaApi := TProcessaApi.Create;
    Try
      ProcessaApi.strNumCot := FieldByName('COT_NUMCOT').AsString;
      ProcessaApi.cdsFornecedores := cdsFornecedores;
      ProcessaApi.cdsItens := cdsItens;
      ProcessaApi.funcCodForToIndex := fCodForToIndex;
      ProcessaApi.funcIndice := fIndice;
      ProcessaApi.RedePitStop:= RedePitStop;
      ProcessaApi.Handle := frmCadCotacaoGeralCX.Handle;
      ProcessaApi.SeqGerRes := strSeqGerBKP;
      ProcessaApi.FAtualizaStatusCotCFOPitStopAncaora := pAtualizaStatusCotCFOPitStopAncaora;

      ProcessaApi.fIniciarSegundaEtapa;
    Finally
      FreeAndNil(ProcessaApi);
    End;
  Finally
    cdsFornecedores.Filtered := False;
    cdsFornecedores.Filter := '';
    cdsFornecedores.EnableControls;
  End;
end;


procedure TCotacao.pAtualizaConPitNotificacao(ACotSeqger, AFornecedores: String);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    AFornecedores := AnsiReplaceStr(AFornecedores, '""', '","');
    qryComand.SQL.Add('UPDATE CONPIT SET CON_NOTIFI  = "S"');
    qryComand.SQL.Add(' WHERE CON_COTGER = "'+ACotSeqger+'" ');
    qryComand.SQL.Add('   AND CON_CODFOR IN('+AFornecedores+')');
    qryComand.SQL.Add('   AND CON_STATUS <> -1;');
    qryComand.ExecSQL;

  Finally
    FreeAndNil(qryComand);
  End;

end;

procedure TCotacao.pProcessaApiCotacao(AIdApi: integer);
  var
    ProcessaApi: TProcessaApi;
    strCampoCotacao: string;
    lFornecedor: String;
begin
  case AIdApi of
      idRedeAncora: Begin
                      If not Assigned(RedeAncora) Then
                        Exit;
                    End;
      idRedePitStop: Begin
                      If not Assigned(RedePitStop) Then
                        Exit;
                     End;
      idRedeSkyPecas: Begin
                      If not Assigned(RedeSkyPecas) Then
                        Exit;
                     End;
   End;


  strCampoCotacao := 'COT_ANCORA';

  case AIdApi of
    idRedeAncora : strCampoCotacao := 'COT_ANCORA';
    idRedePitStop : strCampoCotacao := 'COT_PITSTO';
    idRedeSkyPecas : strCampoCotacao := 'COT_SKYPEC';
  End;

  Try
     cdsFornecedores.DisableControls;
     lFornecedor := cdsFornecedores.FieldByName('COT_CODFOR').AsString;

     cdsFornecedores.Filter := 'COT_CODFOR = ' + QuotedStr(lFornecedor) + ' AND ' +  strCampoCotacao + ' = 1';
     cdsFornecedores.Filtered := True;


     ProcessaApi := TProcessaApi.Create;
     Try
       ProcessaApi.blnReinicia := False;
       ProcessaApi.strNumCot := FieldByName('COT_NUMCOT').AsString;
       ProcessaApi.cdsFornecedores := cdsFornecedores;
       ProcessaApi.cdsItens := cdsItens;
       ProcessaApi.funcCodForToIndex := fCodForToIndex;
       ProcessaApi.funcIndice := fIndice;
       ProcessaApi.Handle := frmCadCotacaoGeralCX.Handle;
       ProcessaApi.SeqGerRes := strSeqGerBKP;
       ProcessaApi.FAtualizaStatusCotCFOPitStopAncaora := pAtualizaStatusCotCFOPitStopAncaora;
       ProcessaApi.FCalculaPrecoImp := fCalculaPrecoImp;
       ProcessaApi.IncluiItensFornec_CopiaSeguranca := fIncluiItensFornec_CopiaSeguranca;

       case AIdApi of
         idRedeAncora: ProcessaApi.RedeAncora := RedeAncora;
         idRedePitStop: ProcessaApi.RedePitStop:= RedePitStop;
         idRedeSkyPecas: ProcessaApi.RedeSkyPecas:= RedeSkyPecas;
       End;
       ProcessaApi.fProcessa(AIdApi);
     Finally
       FreeAndNil(ProcessaApi);
     End;

  Finally
    cdsFornecedores.Filtered := False;
    cdsFornecedores.EnableControls;
  End;
end;


procedure TCotacao.pCarregaPrecosCotacaoPitStop;
var ProcessaApi: TProcessaApi;

begin
  cdsFornecedores.DisableControls;
  Try
    cdsFornecedores.Filter := 'COT_PITSTO IN ('+ TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco).ToString + ', ' +
                                                 TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarRecotarPreco).ToString + ')';
    cdsFornecedores.Filtered := True;
    If cdsFornecedores.IsEmpty Then
    Begin
      pMensagemOk('Sem preços para importar.');
      Exit;
    End;

    ProcessaApi := TProcessaApi.Create;
    Try
      ProcessaApi.strNumCot := FieldByName('COT_NUMCOT').AsString;
      ProcessaApi.cdsFornecedores := cdsFornecedores;
      ProcessaApi.cdsItens := cdsItens;
      ProcessaApi.funcCodForToIndex := fCodForToIndex;
      ProcessaApi.funcIndice := fIndice;
      ProcessaApi.Handle := frmCadCotacaoGeralCX.Handle;
      ProcessaApi.SeqGerRes := strSeqGerBKP;
      ProcessaApi.FAtualizaStatusCotCFOPitStopAncaora := pAtualizaStatusCotCFOPitStopAncaora;
      ProcessaApi.FCalculaPrecoImp := fCalculaPrecoImp;
      ProcessaApi.IncluiItensFornec_CopiaSeguranca := fIncluiItensFornec_CopiaSeguranca;

      ProcessaApi.fImportarPrecos;
    Finally
      FreeAndNil(ProcessaApi);
    End;
  Finally
    cdsFornecedores.Filtered := False;
    cdsFornecedores.Filter := '';
    cdsFornecedores.EnableControls;
  End;

end;

function TCotacao.fFaturaPitStop(ACodFor, AIncPcmGer, ANumCot: String; AStatusPitStopCotacao: TStatusPitStopCotacao): boolean;
var ProcessaApi : TProcessaApi;
begin
  ProcessaApi := TProcessaApi.Create;
  Try
    ProcessaApi.funcCodForToIndex := fCodForToIndex;
    ProcessaApi.funcIndice := fIndice;
    ProcessaApi.StatusPitStopCotacao := AStatusPitStopCotacao;
    ProcessaApi.RedePitStop:= RedePitStop;
    ProcessaApi.SeqGerRes := strSeqGerBKP;
    ProcessaApi.FAtualizaStatusCotCFOPitStopAncaora := pAtualizaStatusCotCFOPitStopAncaora;
    Result := ProcessaApi.fFaturarPedido(ACodFor, AIncPcmGer, ANumCot);
  Finally
    FreeAndNil(ProcessaApi);
  End;
end;


procedure TCotacao.pAtualizaStatusFornecedoresPitStop(ACotSeqger, AFornecedores: String);
var qryCONPIT: TUniQuery;
    bkpFilter: string;
    bkpFiltered: Boolean;
    bkpRecNo: integer;
begin

  qryCONPIT := fCriaQuery;
  bkpFilter := cdsFornecedores.Filter;
  bkpFiltered := cdsFornecedores.Filtered;
  bkpRecNo := cdsFornecedores.RecNo;
  Try
     qryCONPIT.SQL.Add('SELECT * FROM CONPIT');
     qryCONPIT.SQL.Add('WHERE CON_STATUS IN(' + TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsConcluidoPrimeiraEtapa).ToString + ',');
     qryCONPIT.SQL.Add(                         TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsConcluido).ToString + ')');
     qryCONPIT.SQL.Add('  AND CON_COTGER =  "'+ACotSeqger+'"');
     qryCONPIT.SQL.Add('  AND CON_CODFOR =  "'+AFornecedores+'"');

     qryCONPIT.Open;
     cdsFornecedores.DisableControls;
     while not qryCONPIT.Eof Do
     Begin
       cdsFornecedores.First;
       If cdsFornecedores.Locate('COT_CODFOR', qryCONPIT.FieldByName('CON_CODFOR').AsString, []) Then
       Begin
         cdsFornecedores.Edit;
         If qryCONPIT.FieldByname('CON_STATUS').AsInteger = TStatusBuscaCotacaoPitStop.fConsultaPitStopToInt(scpsConcluidoPrimeiraEtapa) Then
         begin
           cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco);
           pAtualizaStatusCotCFOPitStopAncaora(strSeqGerBKP, qryCONPIT.FieldByName('CON_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco), 0);
         End
         Else
         begin
           cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarRecotarPreco);
           pAtualizaStatusCotCFOPitStopAncaora(strSeqGerBKP, qryCONPIT.FieldByName('CON_CODFOR').AsString, idRedePitStop, TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarRecotarPreco), 0);
         End;
         cdsFornecedores.Post;
       End;
       qryCONPIT.Next;
     End;

  Finally
    FreeAndNil(qryCONPIT);
    cdsFornecedores.Filter := bkpFilter;
    cdsFornecedores.Filtered := bkpFiltered;
    cdsFornecedores.RecNo := bkpRecNo;
    cdsFornecedores.EnableControls;
  End;
  {}
end;

procedure TCotacao.pAtualizaStatusCotCFOPitStopAncaora(ASeqger, ACotFor: String; AIdentApi, AStatus: Integer; AHorIni: TDateTime);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE COTCFO_RES SET ');
    case AIdentApi of
      idRedeAncora : qryComand.SQL.Add('  COT_ANCORA  = "'+AStatus.ToString+'"');
      idRedePitStop : qryComand.SQL.Add('  COT_PITSTO = "'+AStatus.ToString+'" ');
      idRedeSkyPecas : qryComand.SQL.Add('  COT_SKYPEC = "'+AStatus.ToString+'" ');
    End;

    If AHorIni > 0 Then
      qryComand.SQL.Add('  ,COT_INIINT = :INIINT');

    qryComand.SQL.Add(' WHERE COT_SEQGER = "'+ASeqger+'" ');
    qryComand.SQL.Add('   AND COT_CODFOR  = "'+ACotFor+'";');
    If AHorIni > 0 Then
      qryComand.ParamByName('INIINT').Value := AHorIni;
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
End;

procedure TCotacao.pAjustaHandleConPit(AHAndle: HWND);
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('UPDATE CONPIT SET CON_HANDLE = ' + IntToStr(AHAndle));
    qryComand.SQL.Add(' WHERE CON_COTGER IN (SELECT AUTOINCREM FROM COTGER WHERE COT_NUMCOT = "'+FieldByName('COT_NUMCOT').ASString+'")');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;


procedure TCotacao.pAjustaStatusCotacaoPitStop;
var lSeqCot: String;
    qryConPit: TUniQuery;
begin
  qryConPit := fCriaQuery;
  Try
    lSeqCot := fCampoTabela('AUTOINCREM', 'COTGER', ['COT_NUMCOT'], [Self.FieldByName('COT_NUMCOT').AsString]);
    qryConPit.SQL.Add('SELECT CON_STATUS FROM CONPIT');
    qryConPit.SQL.Add(' WHERE CON_COTGER = "'+lSeqCot+'"');
    qryConPit.SQL.Add('   AND CON_CODFOR = :CODFOR');
    qryConPit.SQL.Add('   AND CON_STATUS <> -1');

    cdsFornecedores.First;
    while not cdsFornecedores.Eof Do
    Begin

      If (TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) <> spscSemApi) Then
      Begin
        qryConPit.Close;
        qryConPit.ParamByName('CODFOR').AsString := cdsFornecedores.FieldByName('COT_CODFOR').AsString;
        qryConPit.Open;
        If Not qryConPit.IsEmpty then
        Begin
          If TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(qryConPit.FieldByname('CON_STATUS').AsInteger) = scpsProcessando Then
          Begin
            case TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) of
             spscComApi,
             spscPendenteConsultaPreco: Begin
                                            cdsFornecedores.Edit;
                                            cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoConsultaPreco);
                                            cdsFornecedores.Post;
                                          End;
            End;
          End;

          If TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(qryConPit.FieldByname('CON_STATUS').AsInteger) = scpsConcluidoPrimeiraEtapa Then
          Begin
            case TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) of
             spscComApi,
             spscPendenteConsultaPreco,
             spscIntegrandoConsultaPreco: Begin
                                            cdsFornecedores.Edit;
                                            cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco);
                                            cdsFornecedores.Post;
                                          End;
            End;
          End;

          If TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(qryConPit.FieldByname('CON_STATUS').AsInteger) = scpsConcluido Then
          Begin
            case TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) of
              spscComApi,
              spscPendenteConsultaPreco,
              spscIntegrandoConsultaPreco,
              spscPendenteImportarConsultaPreco,
              spscPendenteRecotarPreco,
              spscIntegrandoRecotarPreco: Begin
                                            cdsFornecedores.Edit;
                                            cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscPendenteImportarConsultaPreco);
                                            cdsFornecedores.Post;
                                          End;
            end;
          End;

          If TStatusBuscaCotacaoPitStop.fIntToStatusConsultaPitStop(qryConPit.FieldByname('CON_STATUS').AsInteger) = scpsProcessandoSegundaEtapa Then
          Begin
            case TStatusCotacaoPitStop.IntToStatusPitStopCotacao(cdsFornecedores.FieldByName('COT_PITSTO').AsInteger) of
              spscComApi,
              spscPendenteConsultaPreco,
              spscIntegrandoConsultaPreco,
              spscPendenteImportarConsultaPreco,
              spscPendenteRecotarPreco: Begin
                                            cdsFornecedores.Edit;
                                            cdsFornecedores.FieldByName('COT_PITSTO').AsInteger := TStatusCotacaoPitStop.StatusPitStopCotacaoToInt(spscIntegrandoRecotarPreco);
                                            cdsFornecedores.Post;
                                          End;
            end;
          End;
        End;
      End;
      cdsFornecedores.Next;
    End;
  Finally
    FreeAndNil(qryConPit)
  End;
  {}
end;




end.




