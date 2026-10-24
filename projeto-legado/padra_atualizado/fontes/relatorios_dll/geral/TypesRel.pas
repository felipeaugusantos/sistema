unit TypesRel;

interface

uses untTypesSistema, Uni, untIFuncoes, Classes, UniClientDataSet, DB, frxClass,
  untConstantes, Menus, frxDBSet, untIZClient, ComCtrls, untTipoTinta, untFuncoesRel,
  SysUtils, cxProgressBar;

Type
  TLoteProdutoEtiq = Record
    intQtdEti: Integer;
    strAutInc: String[20];
  End;

  TTipoEtiquetaHelper = record Helper for TTipoEtiqueta
    function GetName: String;
    class function GetByName(AName: String): TTipoEtiqueta; static;
  end;

  TRetValorParametroGrid = Function(strNomPar: String): String Of Object;

  TArrLoteProdutoEtiq = array of TLoteProdutoEtiq;

  TTipoRelFaturamento = (relFatVendasMarkup,relFatVendasMarkupAndor, relFatEmiDiaria,relFatComVendedor,
                         relFatCtlTempoEspera, relFatVendaConjunto,
                         relFatItensVenMod,relFatRelOrc,relFatExtratoFatFuturo,relFatDocConfOutroCliente,
                         relFatVendasDiariasLoja,relFatVenTipFat,
                         relFatServicosCliente,relFatVenTransp,relFatLogLib,relFatMargemDocumento,
                         relFatMetasVendedor,relFatTipoDoc,relFatEvolVendas,relFatDemonstracaoCamp,relFatComparatVenda,
                         relFatTransferencias, relFatBocaCaixaVendedor, relFatMetasVendedorCtr,
                         relFatConfDiariaCaixa, relFatDespAcessoria, relFatComVendInd, relFatComVendPes,
                         relFatAltDescricaoFat, relFatVendasCondPagto, relFatComEntregadores, relFatComVendFat,
                         relFatComVenPropLucro, relFatEmprestimos, relFatDemonstraDespesas,
                         relFatMetasVendedorLitGal, relFatVendasPerdidas, relBrindesProfissionais, relFatReciboAvulso,
                         relFatSepMercadoria, relFatComVendRec, relFatEvolVendasGrafico, relFatComissaoEspecie,
                         relFatComVendedorMod1, relFatDistrSherWill, relFatMetasClientes, relFatAltVendedorDoc,
                         relFatDevolucoesVenda, relFatBonificacao, relFatAcompanhaPromocao,
                         relFatLogAltEntregaFutura, relFatServAtendCliente, relFatVendasConcreto, relFatComFatVend,
                         relFatItensVendEndEntrega, relFatPorProduto, relFatExtratoProfissional,
                         relFatMetasVendedorLitragem, relFatComVendDepart, relFatComDepart, relFatComGerente,
                         relFatEvolVendasMes, relComissaoVendedorCTRPrevia, relFatMapDemonsEstoq,
                         relFatMetasFornecValFat, relFatComVendCndDes, relFatDocumentoTipoEnt,
                         relFatMetFaturamentoEmp,relFatMetasVendDeparProd, relFatMetasVendAtivCliente, relFatComMecanicos,
                         relFatComissaoFaixaDescTabPre, relFatHistoricoRomaneio, relFatVendasCompartilhadas,
                         relFatMetasVendedorValorGruMar, relFatVendaForPagDesc, relFatUsoConsumo, relFatLogLibRem,
                         relFatDocsMIConf, relFatPedVendaFaturados, relFatEmiDiaMod3, relFatMetasVendedorFrete, relFatMetasVendedorFatLiq);

    TTipoRelEstatisticas = (relEstatAbcClientes, relEstatAbcProdutos, relEstatAbcFornecedor,
                          relEstatAbcFornecVenda, relEstatAbcVenRep, relEstatAbcCidade,
                          relEstatAnalResult, relEstatCliNaoCom, relEstatAbcProfissionais,
                          relEstatAnalResultMovBan, relEstatRelLitragemCompraVenda, relEstatAbcCredito,
                          relEstatAbcSeparacao, relEstatAnaliseDesemp, relEstatMetasClientes,
                          relEstatVendasPorHorario, relEstatBalancoGerencial, relEstatDemonsFat,
                          relEstatPesquisaMercado, relEstatLiquidezServicos, relEstatVisitasClientes, relEstatResumoCliAti,
                          relEstatCMV,relEstatAnalResultRitec);

  TTipoRelContasAReceber = (relCtrAnaCreditos, relCtrTitRecPortador, relCtrTitReceb,
                            relCtrReceber, relCtrIncDiarias, relPosContabil,
                            relTitDeletados, relCtrCartoes,
                            relCartaAnuencia, relDupAgr,
                            relCtrComVendedor, relCtrLogDesagrup, relBoletosImpressos,
                            relCtrInadimplencia, relCtrAnaliseCredito, relDupEnvBanco, relPosContabilCar,
                            relCtrBordero, relCtrHistReceb, relCtrLogAcompDuplic,
                            relCtrCreditosUtilizados, relCtrCartaProtesto, relCtrFpgFatRec,
                            relCtrRegistroDuplicatas, relCtrCartaDes, relCtrAgingCobranca,
                            relCtrContaCorrenteProduto, relCtrExportaCobranca);

  TTipoRelContasAPagar = (relCtpAnaDebitos, relCtpTitAbertoMes, relCtpEncQuitados,
                          relCtpContaCorrente,relCtpIncDiarias, relCtpIncDiariasMes,
                          relCtpTitContas, relCtpPosContabil, relCtpAgrup, relCtpTitPortador,
                          relCtpTitPagosComCheque, relCtpTitContasAno, relCtpKmRodadoVeic,
                          relCtpChequesEmitidos, relCtpReimpDocs, relCtpTitDeletados,
                          relCtpLogAcompDuplic);

  TTipoRelCadastro = (relPortadores, relProdutos, relEstrutura, relAtividade,
                      relBancos, relFornecedores, relFornecedoRres, relExpiracaoConsutacredito,
                      relTransportadoras, relVendedor, relMarca, relCadDiversos,
                      relItensPromocao, relCadMsg, relClientes, relItensBocaCaixa,
                      relCadImobilizado, relRedeLojas, relLogLocFisica,
                      RelContratoAberturaCredito, relCadDireitosDeAcesso, relCadLogCfg,
                      relTelefoneContato, relCadCfg, relCadEventos, relEtiqQtdRestante,
                      relEstruturaIndustrial, relCadAbrevFiscais, relCadLogAltLimite, relLogDir, relFichaCadFuncionario,
                      relClientesPromocao, relCadLogTin,relCadBasLogTin, relProdutosAgregados, relCad800);

  TTipoRelLivrosFiscais = (relFiscRegEntrada,relFiscRegSaida,relFiscResumoIcms,
                         relFiscOpeInterEntradas,relFiscOpeInterSaidas,relFiscCartCorreIcms,
                         relFiscPisCof,relFiscTermoAbert,relFiscProdutoControlado, relFiscResumoApuracaoIcms,
                         relFiscDiarioAuxiliar, relFiscBoletimContabil, relFiscConhecimentoFrete,
                         relFiscNFServicos, relFiscCanhotoNF, relFiscIcmRetItem, relFiscSaiSTDadosEntrada,
                         relFiscCreIcmVendInterest, relFiscGerArqAcSef107_2011, relFiscMovEstoqContabil,
                         relFiscInconsistenciasFiscais, relFiscMapaResumo, cadRelAjusteICMST, cadRelControleCredFiscais,
                         relFiscDesvalorizacaoProdutos, relFiscGerArqAcMod2, relFiscItensPorNCM, relRessarcImpRetidoPorSujeicaoPassivaSubst,
                         relFiscCreditosCIAP, relFiscDepreciacaoAtivos, relFiscPagAntIcmsPR, relServicosTomados,
                         relSimplesNacional, relRestituicaoIcms, relFiscProdVenSt, relFiscControleEstoqueCat1799);

  TTipoRelEstoque = (relEspNotaEnt,relEspNotaEntDev,relLstPreAlt,relEstListaPrecos,relEstContEst,
                     relEstKardex,relEstSemMov,relEstSaldoLoj, relEstInvFisico,relEstGirEstVenda,
                     relEstGirEstCompra,relEstPedCompra,relEstGirEstVenda12Meses,relEstSaldoReservado,
                     relEstEvoCompras,relEstListaAjuste,relEstKardexGramas,relEstEntregaFutura,
                     relEstPedCompraGrid, relEstConfControleEntrega, relEstEstoqueMaxMin, relEstPosicaoEstData,
                     relEstInvFisicoArt63, relEstContEstAle, relEstKardexAcabado, relEstEvoComprasGrafico,
                     relEstPrazoMedRecebMerc, relEstKardexSint, relEstPrecosNaoAlt,
                     relEstPedidosDev, relEstPosicaoEstProAca, relEstListaPrecosTab, relEstListaPrecosTabC,
                     relEstLogAlteracaoMinMax, relEstPontoReposArm, relEstTransfEntreArm, relEstComparativoPrecosFornec, relEstEfetivacaoPrecos,
                     relEstMarkupCompras, relEstFornecFormacaoPrecos, relEstListaPrecoGerFor, relEstAnaliseAbastMultEmp,
                     relEstLogLibPreNotaEntrada, relEstEvolucaoProducaoMensal, relEstMovProducaoAjuste, relEstEntFutPosEntrega,
                     relEstConferPreco, relEstMetasComprador, relEstMetasDespesas, RelEstMetasRapel, relEstPosicaoEstLocFis,
                     relEstPedCompraDtaVencto, relEstCorrecoesBxOp, relEstEnderecamentoComOperador, relEstLogTransfLocFisGlobalWMS,
                     relEstComprasCondPagto, relCatalogoLinhaGrupo);

  TRegistroVarEstoque = Record
    blnTemParametros : Boolean;
    strCodIte        : String[10];
    strDesIte        : String[70];
    strDataSalBal    : String[10];
    strGerVen        : String[1];
    strExibirFornec  : String[1];
    blnOriRcx        : Boolean;
    prgProgresso     : TcxProgressBar;
    blnOriConsulPro  : Boolean;
    blnExibirUnitario: Boolean;
    prcExecutaRelatorio: TExecutaRelatorio;
    fncExecutaRelatorio: TfExecutaRelatorio;
  End;

  TRegistroVarFaturamento = Record
    blnTemParametros       : Boolean;
    blnAbreDireto          : Boolean;
    blnVeioDoTelemarketing : Boolean;
    blnVeioDoTablet        : Boolean;
    blnVeioTelaVendas      : Boolean;
    strCtr_DupPar          : String[12];
    strCtr_EspDoc          : String[2];
    strCtr_CodEmp          : String[3];
    strCodCli              : String[8];
    strNomCli              : String[70];
    strCodIte              : String[10];
    strCodVen              : String[10];
    oleDados               : OleVariant;
    arrDados               : TStringArray;
  End;

  TRegistroVarChequesPre = Record
    arrCheques : TStringArray;
  End;

  TFuncPrecoCusto = Function(fltPreCom,
                            fltDesF01,
                            fltDesF02,
                            fltDesF03,
                            fltDesF04,
                            fltDesF05,
                            fltDesF06,
                            fltIcmEnt,
                            fltIpiEnt,
                            fltFreEnt,
                            fltAcrFin,
                            fltSubsti,
                            fltValFre,
                            fltDesAdb,
                            fltSubFed,
                            fltTCIFCu,
                            fltTSCust,
                            fltDePiCo,
                            fltDeICMS,
                            fltFatReg: Double): Double;

  TRecVariaveis = Record
    VS_Date                  : TDateTime;
    utcRegistros             : IUltConsultas;
    blnUsuarioLogadoUtilizaModoClassico: Boolean;
    strLoginUsuarioLogado    : String;
    strDescriUsuarioLogado   : String;
    strEmpAcessoUsuarioLogado: String;
    VS_strCodEmp             : String;
    VS_strUsaTmq             : string;
    VS_strTitLot             : String;
    VS_strTitLts             : String;
    objFuncoes               : IFuncoes;
    objTraceViewer           : ITraceViewer;
    strPortadoresOperador    : String;
    arrProCod                : TArrProCod;
    objTrace                 : ISQLTrace;
    funcPrecoCusto           : TFuncPrecoCusto;
  End;

  TRecModulos = Record
    Banco       : TUniConnection;
    ModuloSpr   : Pointer;
  End;

  TParamDllRelFaturamento = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelFaturamento;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
      varRecEst : TRegistroVarFaturamento;
  End;

  TRegistroVarVenda = Record
    blnTemParametros : Boolean;
    strCodCli        : String[8];
  End;

  TTipoRelPedidosDeVenda = (relPedMetasVendedor,
                            relPedNecessidadeProducao, relPedItensRepresent,
                            relPedTipoEnt);



  TParamDllRelPedidosDeVenda = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelPedidosDeVenda;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
      varRecEst : TRegistroVarVenda;
  End;

  TProcedureRelatorio = procedure (prmDllRel: Pointer);
  TFunctionRelatorio = Function (prmDllRel: Pointer): Boolean;

  TTipoRelBancariosContabeis = (relBancarios, relBancContaCorrente, relBancSaldosPor,
                                relBancDespesas, relBancFluxoCaixa, relBancReceitasXDespesas,
                                relBancApuraOrcado, relBancSalRcxGlobal);


  TParamDllRelBancariosContabeis = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelBancariosContabeis;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
  End;

  TTipoRelChequesPre = (relChqInclDiarias, relChqDepos, relChqRepassados,
                        relChqPredatados, relChqDevolvidos, relChqEmCustodia, relPosContabilChq,
                        relChqTelecheque, relReimpressaoBorderoTelecheque, relChqDeletados,
                        relChqLogAcomp);

  TParamDllRelChequesPre = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelChequesPre;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
      varRecEst : TRegistroVarChequesPre;
  End;

  TParamDllRelEstoque = class(TObject)
  public
    intDebugH : Byte;
    relTipRel : TTipoRelEstoque;
    modRecMod : TRecModulos;
    varRecVar : TRecVariaveis;
    varRecEst : TRegistroVarEstoque;
  End;

  TParamDllRelEstatisticas = class(TObject)
  public
    intDebugH : Byte;
    relTipRel : TTipoRelEstatisticas;
    modRecMod : TRecModulos;
    varRecVar : TRecVariaveis;
  End;

  TParamDllRelContasAReceber = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelContasAReceber;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
  End;

  TParamDllRelContasAPagar = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelContasAPagar;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
  End;


  TParamDllEtiquetas = class(TObject)
    public
      intDebugH: Byte;
      tpeTipEtq: TTipoEtiqueta;   // TIPO DA ETIQUETA
      tptTipTin: TTipoTinta;      // TIPO DE TINTA
      TipoOrigemEtiquetaAbreItens: TTipoOrigemEtiquetaAbreItens;
      strTipoFC: String[1];       // TIPO FORNECEDOR OU CLIENTE >> DESPACHO
      strEspDoc: String[2];       // ESPECIE DO DOCUMENTO PARA ITENS DE ORC/PED OU DESPACHO
      strCodEmp: String[3];       // CODIGO DA EMPRESA PARA ITENS DE ORC/PED
      strNomTab: String[7];       // NOME DA TABELA >> DESPACHO
      strNumDoc: String[12];      // NUMERO DO DOCUMENTO PARA ITENS DE ORC/PED OU DESPACPHO
      strCamBus: String[20];      // CAMPO DE BUSCA
      strAutInc: String[20];      // AUTO INCREMENTO TINTA DE MAQUINA
      strSeqAgeILo : String[20]; //autoincremento para reimpressao de apenas 1 etiqueta do plano de recebimento
      strNomFil: String;          // NOME DA FILA DE IMPRESSAO
      strLisReg: String;          // LISTA DE AUTOINCREMENTOS PARA IMPRESSAO
      strTabela: String;          // TABELA PARA O SELECT DAS ETIQUETAS DE NOTA DE ENTRADA
      strCodCon: String;          // CÓDIGO DO CONFERENTE
      strArqPDF: String;
      strCodCnd: String;
      strCndDes: String;
      strNumPar: String;
      strTipImp: String;
      strLayDoc: String;
      strIdxFld: String;          // FIELDS PARA ORDERNAR CLIENTDATASET GENERICO
      strPerDes: String;          // PERCENTUAL DE DESCONTO PARA OS ITENS
      strValAcr: String;          // PERCENTUAL DE ACRÉSCIMO PARA PRECIFICAÇÃO DE PRODUTOS
      strValDes: String;          // PERCENTUAL DE DESCONTO PARA PRECIFICAÇÃO DE PRODUTOS
      strNomFrm: String;          // NOME FORMULÁRIO
      strCodCli: String;          // CÓDIGO DO CLIENTE PARA ETIQUETA AVULSA DE UNIDADE RESTANTE / ETIQUETA DE DESPACHO
      strChaveTemporariaLotMarmore: String;
      strForceFiltro: String;
      strCodIte: String;           //CÓDIGO ITEM
      strDtaPro: String;
      strOperador: String; // Código do Operador + Descrição do Operador
      strOrdPro: String;          // NÚMERO DA ORDEM DE PRODUÇÃO NÃO INDUSTRIAL
      strPDF_Diretorio  : String;
      blnEdrCob: Boolean;         // SE IMPRIME ENDERECO DE COBRANCA
      blnSoDesc: Boolean;         // ORDENAÇÃO DECRESCENTE
      blnImpEti: Boolean;         // IMPRESSAO [VIDEO,IMPRESSORA] PARA ITENS DE ORC/PED OU DESPACHO
      blnImprim: Boolean;         // SE IMPRIME OU SO ABRA A QUERY
      blnPromoc: Boolean;         // PRECO DE PROMOCAO
      blnPrePro: Boolean;         // Caso Verdadeiro, verificar se existe promoção para o dia atual, caso tenha grava preço no VALITE para Impressão do valor de promoção;
      blnImpNot: Boolean;         // Se imprime número da Nota de Entrada.
      blnUsfrxU: Boolean;         // Se Usa apenas o frxUserDataSet;
      blnB2W : Boolean;
      blnEtiNFe: Boolean;
      blnPDF_Gerar      : Boolean;
      blnPDF_Apresentar : Boolean;
      intQtdVol: Integer;         // QUANTIDADE DE VOLUMES NO DESPACHO
      intNumCop: Integer;         // NUMERO DE COPIAS
      intTabPre: Integer;         // TABELA DE PRECO
      intQtdEti: Integer;         // QUANTIDADE DE ETIQUETAS A SEREM IMPRESSAS
      intTabPra: Integer;         // TABELA DE PRECO A PRAZO PARA PRECIFICAÇÃO DE PRODUTOS
      intParcel: Integer;         // QUANTIDADE DE PARCELAS PARA PRECIFICAÇÃO DE PRODUTOS
      intEtqInicial: Integer; // Iniciar impressão a partir de determinada etiqueta
      {B2W Entrega (Direct)}
      strTipoAlter: integer;
      arrEAN39: TStringArray;     // EAN39 para etiqueta de caixas
      ArrLoteProdutoEtiq: TArrLoteProdutoEtiq; //Lista de Lotes;
      modRecMod: TRecModulos;     // DATAMODULOS
      varRecVar: TRecVariaveis;   // VARIAVEIS DO SISTEMA
      recDocume: TRecDocumento;
      cdsPlanoRecebimento: TUniClientDataSet;  // CLIENTE COM OS DADOS DOS ARMAZENS PARA TRAZER A LOC FISICA.
      cdsPromoc: TUniClientDataSet;  // CLIENT COM ITENS DA PROMOCAO
      cdsCodBar: TUniClientDataSet;  // CLIENT DE CODIGO DE BARRAS SELECIONADOS
      cdsArmaze: TUniClientDataSet;  // CLIENTE COM OS DADOS DOS ARMAZENS PARA TRAZER A LOC FISICA.
      cdsDadosEtiqueta: TUniClientDataSet;  // CLIENT COM DADOS DA ETIQUETA - MONTAGEM DE CAIXAS
      qryImpres: TUniQuery;         // QUERY DA ETIQUETA
      dtsImpres: TDataSet;        // DATASET DA ETIQUETA
      frxUserDd: TfrxUserDataSet; // DADOS DA ETIQUETA
      arrPrxCod: TarrProCod;      // DADOS PROXIMO CODIGO
      ftiDadEti: TFormulEtiq;     // DADOS DA FORMULAÇÃO DE TINTA
      stlPromoc: TStringList;     // ITENS EM PROMOCAO ou NO CASO DE ETIQUETAS DO PEDIDO OU ORÇAMENTO A QTDE ETIQ. A IMPRIMIR
      blnAtualizaAgeIteImp: Boolean;
      strUltimaFilaUtilizada: String;
      blnSepExclusiva: Boolean;
      strMultPed: String;
      blnImpAut: Boolean;
      blnImpEtiquetaMontagemCaixa: Boolean;
      strOpeImp: String;
      blnImpGrp: Boolean;
      strLisGrpPre: String;
      cdsDespachoPorAmbiente: TUniClientDataSet;  // ESPECIFICAÇÃO DE VOLUMES POR AMBIENTE.
      strTipTipoEtiqueta: TTipoImpressaoEntEtq;
      constructor Create;
  End;

  TRegistroVarCadastro = Record
    blnTemParametros : Boolean;
    mnuMainMenu      : TMainMenu;
    strcodFun        : String;
    strCod800        : String;
  End;

  TParamDllRelLivrosFiscais = class(TObject)
  public
      intDebugH : Byte;
      relTipRel : TTipoRelLivrosFiscais;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
  End;

  TParamDllRelCadastros = class(TObject)
    public
      intDebugH : Byte;
      relTipRel : TTipoRelCadastro;
      modRecMod : TRecModulos;
      varRecVar : TRecVariaveis;
      varRecCad : TRegistroVarCadastro;
  End;

  TarrFiltros = Array Of TRecFiltros;

  TSituacaoPedido = (sitAberto,sitParcial,sitBaixado);

  TfuncAvaliaExpressaoString = Function(strExpressao: String; Var blnErro: Boolean): String Of Object;

  type
    TParcelas = record
      strData : String;
      strValor: String;
  End;

  TParcelasArray = Array Of TParcelas;

  Const
    CONJ_DOCUMENTOS: Set Of TTipoEtiqueta = [tpeMI, tpeFF, tpeBR, tpeTR, tpeDV, tpeAmostraProdutoAuto,
                                             tpeAJ, tpeTA, tpeEP, tpeBE, tpeUS,
                                             tpeCS, tpeCR, tpeTE, tpePI, tpePD,
                                             tpeOR, tpePR, tpeOrdProImobiliaria, tpeOrdProAutomotiva, tpePA, tpeROTin, tpeSeparacaoGondola, tpeGA, tpeContGC, tpeGF, tpeOrdPro,
                                             tpeNF, tpeIF, tpeNS, tpeTicketNF, tpeTicketDV, tpeSF, tpeD1, tpeSepNota, tpeSepNotaObs,
                                             tpeSepSF, tpeSepPedido, tpeCupomServico, tpeSepRomaneio, tpeSepItem, tpeOrdemServico,
                                             tpeOrdemServicoTermoResp, tpeOrdemServicoTermoDev, tpeOrdemServicoOrdExecucao, tpeOrdemServicoImagem, tpeReqMaterialConsumo, tpeReqMaterialConsumoVidro,
                                             tpeLiberacaoArmazenagem, tpeCarnePagamento, tpeDuplicata, tpeInspecaoEnt, tpeInspecaoSai,
                                             tpeComprovanteGeracaoCredito, tpeProcessoDeExtrusao, tpeEnderecamentoDeProduto, tpePDExterior, tpeORExterior,
                                             tpeCupomPromocao, tpeRemessaDevolucao, tpeFFDocumentosCR, tpeCupomProxDesc, tpeRequisicao, tpeContGF, tpeContGR, tpeContGRBaixa, tpeSolicitacaoManutencaoEquipamentos, tpePedidoCompra,
                                             tpeLocacaoEquipamento, tpeRL, tpeDevolucaoLocacao, tpeFaturaLocacao,
                                             tpeRB];

    arrLetras : Array [0..23] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X');

    CONJ_LASER: Set Of TTipoEtiqueta = [tpeClienteLaser, tpeFornecedorLaser,
                                       tpeDiversosLaser, tpeOperadorLaser,
                                       tpeItensLaser, tpePrecificacaoProdutosLaser,
                                       tpeItensControladosLaser, tpeItensLaserCodBarPadr,
                                       tpeItensLaserCodBarPers, tpeItensLaserCodBarSPre, tpeItensOrcPedLaser,
                                       tpeItensOrcPedLaserCodBar, tpeDespachoLaser, tpeDespachoLaserECommerce,tpeDespachoFaturarExpedidoLaser,tpeEtiquetaDespachoVolumeGeralLaser, tpeEtiquetaDespachoVolumeIndividualLaser,
                                       tpeFomulacaoTinta, tpeUnidadesRestantesFat,
                                       tpeUnidadesRestantesAvu, tpeOPIndustrial,
                                       tpeFuncionarioLaser, tpeOrdemServicoLaser, tpeMarmoreGranito, tpeEtiquetaDoProdutoSeparado, tpeLoteProduto,

                                       tpeMI, tpeFF, tpeBR, tpeTR, tpeDV, tpeAJ,
                                       tpeTA, tpeEP, tpeBE, tpeUS, tpeCS, tpeCR,
                                       tpeTE, tpePI, tpePD, tpeOR, tpePR, tpeOrdProImobiliaria, tpeOrdProAutomotiva, tpePA,  tpeROTin, tpeSeparacaoGondola, tpeGA,
                                       tpeContGC, tpeGF, tpeContGF, tpeOrdPro, tpeNF, tpeIF, tpeTicketNF, tpeTicketDV, tpeSF, tpeD1, tpeContGR, tpeContGRBaixa, tpePedidoCompra,
                                       tpeSepNota, tpeSepNotaObs, tpeSepSF, tpeSepPedido,
                                       tpeCupomServico, tpeSepRomaneio, tpeOrdemServico, tpeOrdemServicoTermoResp, tpeOrdemServicoTermoDev, tpeOrdemServicoOrdExecucao, tpeOrdemServicoImagem,
                                       tpeReqMaterialConsumo, tpeReqMaterialConsumoVidro, tpeLiberacaoArmazenagem, tpeCarnePagamento, tpeDuplicata, tpeInspecaoEnt, tpeInspecaoSai,
                                       tpeComprovanteGeracaoCredito, tpeProcessoDeExtrusao,
                                       tpeLocacaoEquipamento, tpeRL, tpeDevolucaoLocacao, tpeFaturaLocacao,
                                       tpeRB,
                                       tpeEnderecamentoDeProduto, tpePDExterior, tpeORExterior,
                                       tpeCupomPromocao, tpeRemessaDevolucao, tpeFFDocumentosCR, tpeCupomProxDesc, tpeRequisicao, tpeItensCPF, tpeLocFisLaser,
                                       tpePlanoRecebWMSLaser, tpePlanoDeRecebimentoEtiquetaIDLaser , tpeSeqSeparacaoWMSLaser, tpeOrdemProducao, tpeCaixasLaser, tpeArmazenamento, tpeOrdemServicoVendaLaser, tpeSepErrLaser,
                                       tpeMontagemCaixasLaser, tpeLoteRastreamentoProdutoLaser, tpeLocalArmazenamentoWmsLaser,
                                       tpeRegiaoLaser, tpeMontagemCaixasLaserCodBarras, tpeMontagemCaixasLaserPackList,
                                       tpeProdutosControladosVendasLaser, tpeMontagemCaixasZebraPackList, tpeProdutoQuantidadeFracionadaLaser];

   CONJ_ARGOX: Set Of TTipoEtiqueta = [tpeClienteArgox, tpeFornecedorArgox, tpeDiversosArgox,
                                       tpePrecificacaoProdutosArgox, tpeItensControladosArgox,
                                       tpeEstruturaArgox, tpeItensZebraGondolaCPre,
                                       tpeItensZebraGondolaSPre, tpeItensZebraCodBarCPre,
                                       tpeItensZebraCodBarSPre, tpeItensArgoxGondolaCPre, tpeItensArgoxGondolaCPreLayout1,
                                       tpeItensArgoxGondolaSPre, tpeItensArgoxCodBarCPre,
                                       tpeItensArgoxCodBarSPre, tpeItensOrcPedZebraGondolaCPre,
                                       tpeItensOrcPedZebraGondolaSPre, tpeItensOrcPedZebraCodBarCPre,
                                       tpeItensOrcPedZebraCodBarSPre, tpeItensOrcPedArgoxGondolaCPre,
                                       tpeItensOrcPedArgoxGondolaSPre, tpeItensOrcPedArgoxCodBarCPre,
                                       tpeItensOrcPedArgoxCodBarSPre, tpeDespachoArgox, tpeDespachoFaturarExpedidoArgox,tpeEtiquetaDespachoVolumeGeralArgox, tpeEtiquetaDespachoVolumeIndividualArgox,
                                       tpeEntregaTintaMaquina, tpeProducaoTintaMaquina,
                                       tpeUnidadesRestantesArgoxFat, tpeUnidadesRestantesArgoxAvu,
                                       tpeOPIndustrialArgox, tpeFuncionarioArgox,
                                       tpeOrdemServicoArgox, tpeOrdemServicoZebra,
                                       tpeMarmoreGranitoArgox,
                                       tpeItensCPFArgox, tpeOrdemProducaoArgox, tpeEtiquetaDoProdutoSeparadoArgox, tpeLoteProdutoArgox,
                                       tpeLocFisArgox, tpePlanoRecebWMSArgox, tpePlanoDeRecebimentoEtiquetaIDArgox, tpeSeqSeparacaoWMSArgox,
                                       tpeOrdemProducaoZebra, tpeCaixasArgox, tpeArmazenamentoArgox,
                                       tpeArmazenamentoZebra, tpeOrdemServicoVendaArgox, tpeOrdemServicoVendaZebra, tpeSepErrArgox,
                                       tpeLoteRastreamentoProdutoArgox, tpeLoteRastreamentoProdutoLaser, tpeLocalArmazenamentoWmsArgox,
                                       tpeRegiaoArgox, tpeMontagemCaixasArgox, tpeMontagemCaixasZebra,
                                       tpeProdutosControladosVendasArgox, tpeProdutosControladosVendasZebra,
                                       tpeDespachoProdutoArgox, tpeProdutoQuantidadeFracionadaArgox, tpeFFDocumentosCR];

   ARR_CODIGO_ETIQUETA : Array [tpeClienteLaser..tpeProdutoQuantidadeFracionadaArgox] Of Integer =
    (1, 1, 1,                               // CLIENTES  {DEFINI O CAMPO LAY_TIPLAY NA TABELA LAYETI}
     2, 2, 2,                               // FORNECEDOR
     3, 3, 3,                               // DIVERSOS
     4,                                     // ESTRUTURAS
     5, 5,                                  // OPERADORES
     6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6,    // ITENS
     7 ,7, 7, 7, 7, 7, 7, 7, 7, 7, 7,       // ITENS DE ORCAMENTO E PEDIDO
     8, 8, 8, 8, 8, 8, 8, 8, 8, 8,          // DESPACHO DE MERCADORIAS
     9,                                     // ENTREGA DE TINTA DE MAQUINA
     10,                                    // FORMULACAO DE TINTA DE MAQUINA
     14,                                    // PRODUCAO DE TINTA DE MAQUINA
     12, 12,                                // UNIDADES RESTANTES FATURAMENTO
     12, 12,                                // UNIDADES RESTANTES AVULSA
     13, 13,                                // ORDEM DE PRODUCAO INDUSTRIAL
     44, 44,                                // FUNCIONARIOS

     15,                                    // DOCUMENTO DE MI
     16,                                    // DOCUMENTO DE FF
     24,                                    // DOCUMENTO DE BR
     140,
     25,                                    // DOCUMENTO DE PR
     26,                                    // DOCUMENTO DE DV
     27,                                    // DOCUMENTO DE AJ
     28,                                    // DOCUMENTO DE TA
     29,                                    // DOCUMENTO DE EP
     30,                                    // DOCUMENTO DE BE
     31,                                    // DOCUMENTO DE UC
     32,                                    // DOCUMENTO DE CS
     33,                                    // DOCUMENTO DE CR
     34,                                    // DOCUMENTO DE TE
     35,                                    // DOCUMENTO DE PI
     17,                                    // DOCUMENTO DE PD
     18,                                    // DOCUMENTO DE OR
     23,                                    // DOCUMENTO DE PR
     150,                                   //Ordem de Produção para tintas Imobiliarias/Industriais
     151,                                   //Ordem de Produção para tintas automotivas
     59,                                    // Ordem de Produção avulsa de produtos tintométricos
     131,                                   // ORDEM DE PRODUCAO TINTA DE MAQUINA (RO)
     237,                                   // Documento Separacao Gondola
     36,                                    // DOCUMENTO DE GA
     37,                                    // DOCUMENTO DE GC
     38,                                    // DOCUMENTO DE GF
     46,                                    // CONTROLE DOCUMENTO DE GF
     47,                                    // CONTROLE DOCUMENTO DE GR
     48,                                    // CONTROLE DOCUMENTO DE GR BAIXA
     241,                                   //Solicitação de Manutenção de Equipamentos Internos
     214,                                   // Pedido de Compra

     63,                                    // DOCUMENTO DE ORDEM DE PRODUÇÃO TIPO_LAYOUT = 107, tpeOrdPro

     21,                                    // DOCUMENTO DE NF
     22,                                    // DOCUMENTO DE IF (CUPOM FISCAL)
     58, 58,                                // TiketNF
     40,                                    // DOCUMENTO DE NF FORNECEDOR
     39,                                    // DOCUMENTO DE D1

     19,                                    // SEPARACAO PELA NOTA CLIENTE
     41,                                    // SEPARACAO PELA NOTA FORNECEDOR
     235,
     20,                                    // SEPARACAO PELO PEDIDO

     152,                                   // Cupom De Serviço
     45,                                    // SEPARACAO DE ROMANEIO
     105,                                   // SEPARACAO DE ITEM
     51, 52, 53, 51,                        // Ordem de Conserto, TERMO DE RESPONSABILDADE, Termo de Devolução e Ordem de Execução

     64,                                    // Ordem de Serviço - Imagens

     57,                                    // Requisição de Material de Consumo
     138,                                   // Requisição de Material de Consumo Vidro

     157,                                   //LIBERACAO DE ARMAZENAGEM

     135,                                   // CREDIÁRIO - CARNE DE PAGAMENTO
     136,                                   // CREDIÁRIO - DUPLICATA


     162,                                   //INSPECAO - ENTRADA
     163,                                   //INSPECAO - SAIDA


     164,                                   // COMPROVANTE DE GERAÇÃO DE CRÉDITOS

     166,                                   // PROCESSO DE EXTRUSÃO ORDEM DE PRODUÇÃO INDUSTRIAL

     160,                                   // LOCAÇÃO DE EQUIPAMENTOS
     168,                                   // RL - RECIBO LOCAÇÃO
     169,                                   // DL - DEVOLUCAO LOCAÇÃO
     170,                                   // FATURA CONTRATO DE LOCAÇÃO

     171,                                   // RECEBIMENTO DE VENDA A BASE DE TROCA

     210,                                   // ENDEREÇAMENTO DO PRODUTO

     213,                                   // PEDIDO DE VENDA PARA O EXTERIOR
     212,                                   // ORÇAMENTO DE VENDA PARA O EXTERIOR

     229,                                   // CUPOM DE PROMOÇÃO

     231,                                   // REMESSA DE DEVOLUÇÃO
     232,                                   // DOCUMENTOS DE CRÉDITO DO FF
     234,                                   // CUPOM DE DESCONTO PRÓXIMA VENDA
     42,                                    // REQUISICAO

     43, 43,                                // PRECIFICAÇÃO DE PRODUTOS

     49, 49,                                // PRODUTOS CONTROLADOS

     50, 50, 50,                            // ORDEM DE SERVIÇO

     70, 70, 70,                            // ORDEM DE SERVIÇO VENDA

     11, 11,                                // ITENS COM CPF
     54, 54,                                // EMPRESAS
     56, 56, 56,                            // Ordem Producao(Não Industrial)

     60, 60,                                // Cadastro de Localização Física
     61, 61,                                // Plano de Recebimento WMS tpePlanoRecebWMSLaser, tpePlanoRecebWMSArgox,
     62, 62,                                // Sequencial de Separação WMS tpeSeqSeparacaoWMSLaser, tpeSeqSeparacaoWMSArgox,

     65, 65,                                // CAIXAS

     66, 66, 66,                            //ARMAZENAMENTO

     125,

     137,                                   // Código de Barras de Produtos na Expedição

     126, 126,                              // Separação de produtos errado expedição tpeSepErrLaser, tpeSepErrArgox

     130, 165, 208, 208,                        // MONTAGEM DE CAIXAS

     202,202,                                // Marmore Granito

     206, 206,                                // Etiqueta do Produto Separado / Etiqueta da Quantidade Restante da Embalagem Aberta

     55, 55,                               // LOTE DO PRODUTO

     141, 141, 141,                       // RASTREAMENTO PRODUTO

     155, 155,                            // CADASTRO LOCAL DE ARMAZENAMENTO - WMS

     156, 156,                            // CADASTRO DE REGIAO

     200,                                 // MONTAGEM DE CAIXA ARGOX

     201,                                 // MONTAGEM DE CAIXA LASER

     203, 204, 205,                       // ETIQUETAS DE PRODUTOS CONTROLADOS-VENDAS (ARGOX/LASER/ZEBRA)

     220,                                 // ETIQUETA INDIVIDUAL DE DESPACHO POR PRODUTO

     221, 222,                           // ETIQUETA ID DE PLANO DE RECEBIMENTO Laser, ETIQUETA ID DE PLANO DE RECEBIMENTO Argox

     223, 224);                          // ETIQUETA DE PRODUTO - QTD FRACIONADA E PACOTES Laser, ETIQUETA DE PRODUTO - QTD FRACIONADA E PACOTES Argox

  ARR_TIPO_LAYOUT : Array [tpeClienteLaser..tpeProdutoQuantidadeFracionadaArgox] Of Integer =
    (1, 2, 3, {DEFINI O CAMPO LAY_TIPLAY NA TABELA LAYETI}
     4, 5, 6,
     7, 8, 78,
     9,
     10, 11,
     12, 13, 14, 167, 15, 16, 17, 18, 19, 161, 20, 21, 22, 23,
     24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34,
     35, 139, 36, 37, 223, 224, 225, 226, 227, 228,

     38,  {* 38 = TINTA DE MAQUINA  *}
     39,  (* 39 = FORMULAÇÃO DE TINTA DE MAQUINA  *)
     48,  (* 14 = PRODUÇÃO DE TINTA DE MAQUINA  *)
     42,  (* 42 = Etiqueta de Unidades Restantes Laser - Faturamento *)
     43,  (* 43 = Etiqueta de Unidades Restantes Argox - Faturamento *)
     44,  (* 44 = Etiqueta de Unidades Restantes Laser - Avulsa *)
     45,  (* 45 = Etiqueta de Unidades Restantes Argox - Avulsa *)
     46,  (* 46 = Ordem Producao Industrial Laser *)
     47,  (* 47 = Ordem Producao Industrial Argox *)
     81,  (* 46 = Funcionarios Laser *)
     49,  (* 47 = Funcionarios Argox *)

     50,  {* DOCUMENTO DE MI *}
     51,  {* DOCUMENTO DE FF *}
     59,  {* DOCUMENTO DE BR *}
     140, (* AMOSTRA DE PRODUTO AUTOMOTIVO *)
     60,  {* DOCUMENTO DE TR *}
     61,  {* DOCUMENTO DE DV *}
     62,  {* DOCUMENTO DE AJ *}
     63,  {* DOCUMENTO DE TA *}
     64,  {* DOCUMENTO DE EP *}
     65,  {* DOCUMENTO DE BE *}
     66,  {* DOCUMENTO DE UC *}
     67,  {* DOCUMENTO DE CS *}
     68,  {* DOCUMENTO DE CR *}
     69,  {* DOCUMENTO DE TE *}
     70,  {* DOCUMENTO DE PI *}

     52,  {* DOCUMENTO DE PD *}
     53,  {* DOCUMENTO DE OR *}
     58,  {* DOCUMENTO DE PR *}
     150,  {* tpeOrdProImobiliaria *}
     151,  {* tpeOrdProAutomotiva *}
     99,  (* ORDEM DE PRODUCAO AVULSA *)
     131, (* ORDEM DE PRODUCAO TINTA DE MAQUINA (RO) *)
     237, (* SEPARACAO GONDOLA *)
     71,  {* DOCUMENTO DE GA *}
     72,  {* DOCUMENTO DE GC *}
     73,  {* DOCUMENTO DE GF *}
     83,  {* CONTROLE DOCUMENTO DE GF *}
     84,  {* CONTROLE DOCUMENTO DE GR *}
     85,  {* CONTROLE DOCUMENTO DE GR BAIXA *}
     241, {* Solicitação de Manutenção de Equipamentos Internos *}
     214, {* Pedido de Compra *}

     107, {* DOCUMENTO DE ORDEM DE PRODUÇÃO Codigo Etiqueta = 63, tpeOrdPro * }

     56,  {* DOCUMENTO DE NF *}
     57,  {* DOCUMENTO DE IF - CUPOM FISCAL *}
     98,  (* tpeTicketNF  *)
     113, (* tpeTicketDV  *)

     75,  {* DOCUMENTO DE NF FORNECEDOR     *}
     74,  {* DOCUMENTO DE D1 *}

     54,  {* SEPARACAO PELA NOTA - MOVGER(X) CLIENTE *}
     235, {* OBS SEPARACAO PELA NOTA - MOVGER(X) CLIENTE/FORNECEDOR *}
     76,  {* SEPARACAO PELA NOTA - MOVGER(X) FORNECEDOR *}
     55,  {* SEPARACAO PELO PEDIDO - FATGOR  *}
     152, {* Cupom de Serviço }
     82,  {* SEPARACAO DE ROMANEIO - ROMGERX *}
     105, {* SEPARACAO DE ITEM *}
     89,  (* ORDEM DE CONSERTO *)
     90,  (* ORDEM DE CONSERTO TERMO DE RESPONSABILIDADE *)
     91,  (* ORDEM DE CONSERTO TERMO DE DEVOLUCAO *)
     100,  (* ORDEM DE CONSERTO ORDEM DE EXECUÇÃO DE SERVIÇO *)

     110,  (* Ordem de Serviço - Imagens *)

     97,  (* Requisição de Material de Consumo *)
     138,  (* Requisição de Material de Consumo Vidro*)

     157, (* LIBERACAO DE ARMAZENAGEM *)

     135, (* CREDIÁRIO - CARNE DE PAGAMENTO *)
     136, (* CREDIÁRIO - DUPLICATA *)

     162, {* INSPECAO - ENTRADA *}
     163, {* INSPECAO - SAIDA *}


     164, {* COMPROVANTE DE GERAÇÃO DE CRÉDITO *}

     166, {* PROCESSO DE EXTRUSÃO ORDEM DE PRODUÇÃO INDUSTRIAL *}
     160, (* LOCAÇÃO DE EQUIPAMENTOS *)
     168, {* RECIBO LOCAÇÃO *}
     169, {* DEVOLUCAO LOCAÇÃO *}
     170, {* FATURA CONTRATO DE LOCAÇÃO *}

     171, {* RECEBIMENTO DE VENDA A BASE DE TROCA *}

     210, {* ENDEREÇAMENTO DO PRODUTO *}

     213, {* PEDIDO DE VENDA PARA O EXTERIOR *}
     212, {* ORÇAMENTO DE VENDA PARA O EXTERIOR *}

     229, {* CUPOM DE PROMOÇÃO *}

     231, {* REMESSA DE DEVOLUÇÃO *}
     232, {* DOCUMENTOS DE CRÉDITO DO FF *}
     234,  {* CUPOM DE DESCONTO PRÓXIMA VENDA*}
     77,  {* REQUISIÇÃO DE ABASTECIMENTO *}

     79,  (* Precificação Laser *)
     80,  (* Precificação Argox *)

     82,  (* PRODUTOS CONTROLADOS LASER *)
     83,  (* PRODUTOS CONTROLADOS ARGOX *)

     86,  (* ORDEM DE SERVIÇO LASER *)
     87,  (* ORDEM DE SERVIÇO ARGOX *)
     88,  (* ORDEM DE SERVIÇO ZEBRA *)

     131, (* ORDEM DE SERVIÇO VENDA LASER *)
     132, (* ORDEM DE SERVIÇO VENDA ARGOX *)
     133, (* ORDEM DE SERVIÇO VENDA ZEBRA *)

     40,  (* 40 = ITENS COM CPF LASER             *)
     41,  (* 41 = ITENS COM CPF TERMICA           *)

     92,  (* tpeEmpresaLazer *)
     93,  (* tpeEmpresaArgox *)

     120, (* tpeOrdemProducao *)
     95,  (* tpeOrdemProducaoArgox *)
     121, (* tpeOrdemProducaoZebra *)

     101, (* tpeLocFisLaser *)
     102, (* tpeLocFisArgox *)

     103, (* tpePlanoRecebWMSLaser *)
     104, (* tpePlanoRecebWMSArgox *)

     105, (* tpeSeqSeparacaoWMSLaser *)
     106, (* tpeSeqSeparacaoWMSArgox *)

     108,  (* 65 = CAIXAS LASER             *)
     109,  (* 66 = CAIXAS ARGOX             *)

     122, (* Armazenamento       *)
     123, (* Armazenamento ZEBRA *)
     124, (* Armazenamento ARGOX *)

     125, {* DOCUMENTO DE NS *}

     137, (* tpeCodBarrasProduto *)
     126, (* tpeSepErrLaser *)
     127, (* tpeSepErrArgox *)

     130, (* tpeMontagemCaixasLaser *)

     165, (* tpeMontagemCaixasLaserCodBarras *)
     208, (* tpeMontagemCaixasLaserPackList *)
     209, (* tpeMontagemCaixasZebraPackList *)

     202,210,  {* tpeMarmoreGranito*}
     207,  {* tpeEtiquetaDoProdutoSeparadoArgox*}
     206,  {* tpeEtiquetaDoProdutoSeparado*}
     96,  {* tpeLoteProdutoArgox*}
     94,   (* lote do Produto *)
     141, (* Rastreamento Produto *)
     142, (* Rastreamento Produto *)
     143, (* Rastreamento Produto *)

     145, (* Local de Armazenamento Wms - Laser *)
     146, (* Local de Armazenamento Wms - Argox *)

     147, (* Cadastro de Regiao - Laser *)
     148, (* Cadastro de Regiao - Argox *)
     200,  {*Mntagem de Caixa Argox*}
     201,  {*Mntagem de Caixa Zebra*}
     203,  {* Produtos Controlados Vendas Argox *}
     204,  {* Produtos Controlados Vendas Laser *}
     205,  {* Produtos Controlados Vendas Zebra *}
     220,  {* ETIQUETA INDIVIDUAL DE DESPACHO POR PRODUTO *}
     221,  {* ETIQUETA ID DE PLANO DE RECEBIMENTO Laser*}
     222,  {* ETIQUETA ID DE PLANO DE RECEBIMENTO Argox*}
     223, {* ETIQUETA DE PRODUTOS QTD FRAC. E PACOT. Laser*}
     224); {* ETIQUETA DE PRODUTOS QTD FRAC. E PACOT. Argox*}


  ARR_NOME_ETIQUETA : Array [tpeClienteLaser..tpeProdutoQuantidadeFracionadaArgox] Of String[126] =
     {* CLIENTES *}
    ('Etiqueta de Clientes Laser',
     'Etiqueta de Clientes Argox',
     'Etiqueta de Clientes Matricial',
     {* FORNECEDOR *}
     'Etiqueta de Fornecedor Laser',
     'Etiqueta de Fornecedor Argox',
     'Etiqueta de Fornecedor Matricial',
     {* DIVERSOS *}
     'Etiqueta de Diversos Laser',
     'Etiqueta de Diversos Matricial',
     'Etiqueta de Diversos Argox',
     {* ESTRUTURAS *}
     'Etiqueta de Estrutura Argox',
     {* OPERADORES *}
     'Etiqueta de Operador Laser',
     'Etiqueta de Operador Matricial',
     {* ITENS *}
     'Etiqueta de Produtos Laser',
     'Etiqueta de Produtos Laser Código de Barras Padrão',
     'Etiqueta de Produtos Laser Código de Barras Personalizado',
     'Etiqueta de Produtos Laser Sem Preço',
     'Etiqueta de Produtos Zebra Gondola com Preço',
     'Etiqueta de Produtos Zebra Gondola sem Preço',
     'Etiqueta de Produtos Zebra Código de Barras com Preço',
     'Etiqueta de Produtos Zebra Código de Barras sem Preço',
     'Etiqueta de Produtos Argox Gondola com Preço',
     'Etiqueta de Produtos Argox Gondola Com Preço Layout 1',
     'Etiqueta de Produtos Argox Gondola sem Preço',
     'Etiqueta de Produtos Argox Código de Barras com Preço',
     'Etiqueta de Produtos Argox Código de Barras sem Preço',
     'Etiqueta de Produtos Matricial',
     {* ITENS DE ORCAMENTO E PEDIDO *}
     'Etiqueta de Produtos Orçamento/Pedido Laser',
     'Etiqueta de Produtos Orçamento/Pedido Laser Código de Barras Padrão',
     'Etiqueta de Produtos Orçamento/Pedido Zebra Gondola com Preço',
     'Etiqueta de Produtos Orçamento/Pedido Zebra Gondola sem Preço',
     'Etiqueta de Produtos Orçamento/Pedido Zebra Código de Barras com Preço',
     'Etiqueta de Produtos Orçamento/Pedido Zebra Código de Barras sem Preço',
     'Etiqueta de Produtos Orçamento/Pedido Argox Gondola com Preço',
     'Etiqueta de Produtos Orçamento/Pedido Argox Gondola sem Preço',
     'Etiqueta de Produtos Orçamento/Pedido Argox Código de Barras com Preço',
     'Etiqueta de Produtos Orçamento/Pedido Argox Código de Barras sem Preço',
     'Etiqueta de Produtos Orçamento/Pedido Matricial',
     {* DESPACHO DE MERCADORIAS *}
     'Etiqueta de Despacho de Mercadorias Laser',
     'Etiqueta de Despacho de Mercadorias Laser E-Commerce',
     'Etiqueta de Despacho de Mercadorias Argox',
     'Etiqueta de Despacho de Mercadorias Matricial',
     'Etiqueta de Despacho Faturar Pedido Laser',
     'Etiqueta de Despacho Faturar Pedido Argox',
     'Etiqueta de Despacho de Volume Geral Argox',
     'Etiqueta de Despacho de Volume Individual Argox',
     'Etiqueta de Despacho de Volume Geral Laser',
     'Etiqueta de Despacho de Volume Individual Laser',
     {* TINTA DE MAQUINA  *}
     'Etiqueta de Entrega de Tinta de Máquina',
     'Etiqueta de Formulação de Tinta de Máquina',
     'Etiqueta de Producao de Tinta de Máquina',

     {* UNIDADES RESTANTES *}
     'Etiqueta de Unidades Restantes Laser - Faturamento',
     'Etiqueta de Unidades Restantes Argox - Faturamento',

     'Etiqueta de Unidades Restantes Laser - Avulsa',
     'Etiqueta de Unidades Restantes Argox - Avulsa',

     {* ORDEM DE PRODUÇÃO INDUSTRIAL *}
     'Ordem de Produção Industrial Laser',
     'Ordem de Produção Industrial Argox',

     {* FUNCIONARIOS *}
     'Etiqueta de Funcionários Laser',
     'Etiqueta de Funcionários Argox',

     {* DOCUMENTO DE MI *}
     'Movimentação de Itens (MI)',

     {* DOCUMENTO DE FF *}
     'Faturamento Futuro (FF)',

     {* DOCUMENTO DE BR *}
     'Brinde (BR)',

     (* AMOSTRA DE PRODUTO AUTOMOTIVO *)
     'Comprovante de Recebimento de Amostra de Veículo',

     {* DOCUMENTO DE TR *}
     'Troca (TR)',

     {* DOCUMENTO DE DV *}
     'Devolução (DV)',

     {* DOCUMENTO DE AJ *}
     'Ajuste de Estoque (AJ)',

     {* DOCUMENTO DE TA *}
     'Transferência entre Armazéns/Lotes (TA/TL)',

     {* DOCUMENTO DE EP *}
     'Empréstimo (EP)',

     {* DOCUMENTO DE BE *}
     'Baixa de Empréstimo (BE)',

     {* DOCUMENTO DE UC *}
     'Uso / Consumo (UC)',

     {* CONSIGNAÇÃO *}
     'Consignação (CS)',

     {* RETORNO DE CONSIGNAÇÃO *}
     'Retorno de Consignação (CR)',

     {* TE *}
     'Transferência de Estoque (TE)',

     {* PI *}
     'Baixa de Pigmento (PI)',

     {* DOCUMENTO DE PD *}
     'Pedido de Venda (PD)',

     {* DOCUMENTO DE OR *}
     'Orçamento de Venda (OR)',

     {* DOCUMENTO DE PR *}
     'Pedido de Devolução para Retirada (PR)',

     {* ORDEM DE PRODUÇÃO TINTAS IMOBILIARIAS/INDUSTRIAIS *}
     'Ordem de Produção para Tintas Imobiliarias/Industriais',

     {* ORDEM DE PRODUÇÃO TINTAS AUTOMOTIVAS *}
     'Ordem de Produção para Tintas Automotivas',

     {* ORDEM DE PRODUCAO AVULSA *}
     'Ordem de Produção Avulsa de Produtos Tintométricos',

     {* ORDEM DE PRODUCAO TINTA DE MAQUINA (RO) *}
     'Ordem de Produção de Tinta de Máquina (RO)',

     {* SEPARACAO GONDOLA *}
     'Separação Gondola',

     {* DOCUMENTO DE GA *}
     'Garantia - Recebimento do Cliente (GA)',

     {* DOCUMENTO DE GC *}
     'Garantia - Controle de Envio para o Cliente (GC)',

     {* DOCUMENTO DE GF *}
     'Garantia - Envio para o Fornecedor (GF)',

     {* DOCUMENTO DE GA *}
//     'Garantia - Controle de Retorno do Cliente (GF)',

     {* DOCUMENTO DE GF *}
     'Garantia - Controle de Envio para o Fornecedor (GF)',

     {* DOCUMENTO DE GR *}
     'Garantia - Controle de Retorno do Fornecedor (GR)',

     {* DOCUMENTO DE GR *}
     'Garantia - Controle de "Baixa" do Fornecedor',

     'Solicitação de Manutenção de Equipamentos Internos',

     {* DOCUMENTO DE Pedido de Compra *}
     'Pedido de Compra',


     {* DOCUMENTO DE Ordem de Produção *}
     'Ordem de Produção',

     {* DOCUMENTO DE NF *}
     'Nota Fiscal (NF) - Formulário Simples - Cliente',

     {* DOCUMENTO DE CF *}
     'Cupom Fiscal (IF)',
     'Cupom Fiscal (NF) - Ticket',
     'Cupom Fiscal (DV) - Ticket',

     {* DOCUMENTO DE NF *}
     'Nota Fiscal (NF) - Formulário Simples - Fornecedor',

     {* DOCUMENTO DE D1 *}
     'Nota Fiscal Série D1',

     {* DOCUMENTO DE SEPARACAO PELA MOVGER(X) *}
     'Separação pela NF/ MI/ FF/ TE...',

     {* DOCUMENTO DE SEPARACAO PELA MOVGER(X) *}
     'Obs. da Separação pela NF/ MI/ FF/ TE...',

     {* DOCUMENTO DE SEPARACAO PELA MOVGER(X) *}
     'Separação pela NF - Fornecedor',

     {* DOCUMENTO DE SEPARACAO PELO PEDIDO - FATGOR *}
     'Separação pelo Pedido',

     {* DOCUMENTO Cupom de Serviço *}
     'Cupom de Serviço',

     {* DOCUMENTO DE SEPARACAO DE ROMANEIO - ROMGERX *}
     'Separação de Romaneio',

     {* DOCUMENTO DE SEPARACAO DE ITEM *}
     'Separação de Item',

     {* ORDEM DE SERVIÇO *}
     'Ordem de Serviço',
     'Ordem de Serviço - Termo de Responsabilidade',
     'Ordem de Serviço - Termo de Devolução',
     'Ordem de Serviço - Ordem de Execução de Serviço',
     'Ordem de Serviço - Imagens',

     {* REQUISIÇÃO DE MATERIAL DE CONSUMO *}
     'Requisição de Material de Consumo',

     {* REQUISIÇÃO DE MATERIAL DE CONSUMO  VIDRO*}
     'Requisição de Material de Consumo Vidro',

     (* LIBERACAO DE ARMAZENAGEM *)
     'Liberação de Armazenagem',

     (* CREDIÁRIO *)
     'Crediário - Carne de Pagamentos',
     'Crediário - Duplicata',

     {* INSPEÇÃO DE ENTRADA E SAÍDA}
     'Inspeção de Entrada de Equipamentos',
     'Inspeção de Saída de Equipamentos',

     {* COMPROVANTE DE GERAÇÃO DE CRÉDITO *}
     'Comprovante de Geração de Crédito',

     {* PROCESSO DE EXTRUSÃO ORDEM DE PRODUÇÃO INDUSTRIAL *}
     'Processo de Extrusão Ordem de Produção Industrial',

     (* LOCAÇÃO DE EQUIPAMENTOS *)
     'Locação de Equipamentos (LE)',

     {* RECIBO DE LOCAÇÃO *}
     'Recibo Locação (RL)',

     {* DEVOLUCAO DE LOCAÇÃO *}
     'Devolução Locação (DL)',

     {* FATURA CONTRATO DE LOCAÇÃO *}
     'Fatura Contrato de Locação',

     {* RECEBIMENTO DE VENDA A BASE DE TROCA *}
     'Recebimento de Venda a Base de Troca',

     {* ENDEREÇAMENTO DO PRODUTO *}
     'Endereçamento do Produto',

     {* PEDIDO DE VENDA PARA O EXTERIOR *}
     'Pedido de Venda Exterior',

     {* ORÇAMENTO DE VENDA PARA O EXTERIOR *}
     'Orçamento de Venda Exterior',

     {* CUPOM DE PROMOÇÃO *}
     'Cupom de Promoção',

     {* REMESSA DE DEVOLUÇÃO *}
     'Remessa de Devolução (RD)',

     {*Documentos de Crédito do FF - FFCR*}
     'Documentos de Crédito do FF (FFCR)',

     {*Cupom de Desconto Próxima Venda*}
     'Cupom de Desconto Próxima Venda',

     {* REQUISIÇÃO DE ABASTECIMENTO - ENTGER *}
     'Requisição de Abastecimento',

     {* PRECIFICAÇÃO DE PRODUTOS *}
     'Etiqueta de Precificação de Produtos Laser',
     'Etiqueta de Precificação de Produtos         Argox',

     'Etiqueta de Produtos Controlados Laser',
     'Etiqueta de Produtos Controlados Argox',

     {* ORDEM DE SERVIÇO *}
     'Etiqueta de Ordem de Serviço Laser',
     'Etiqueta de Ordem de Serviço Argox',
     'Etiqueta de Ordem de Serviço Zebra',

     {* ORDEM DE SERVIÇO VENDA *}
     'Etiqueta de Ordem de Serviço de Venda Laser',
     'Etiqueta de Ordem de Serviço de Venda Argox',
     'Etiqueta de Ordem de Serviço de Venda Zebra',

     {* ITENS COM CPF *}
     'Etiqueta de Produtos com Obrigatoriedade de CPF Laser',
     'Etiqueta de Produtos com Obrigatoriedade de CPF Térmica',

     'Etiqueta de Empresa Lazer',
     'Etiqueta de Empresa Argox',
     'Etiqueta de Ordem de Produção',
     'Etiqueta de Ordem de Produção Argox',
     'Etiqueta de Ordem de Produção Zebra',

     (* Cadastro de Localização Física *)
     'Etiqueta de Localização Física Laser',
     'Etiqueta de Localização Física Argox',

     (* Plano de Recebimento WMS *)
     'Etiqueta de Plano de Recebimento Laser',
     'Etiqueta de Plano de Recebimento Argox',

     (* Sequencial de Separação WMS *)
     'Etiqueta de Sequencial de Separação WMS Laser',
     'Etiqueta de Sequencial de Separação WMS Argox',

     {* ETIQUETA DE CAIXAS *}
     'Etiqueta de Caixas Laser',
     'Etiqueta de Caixas Argox',

     'Etiqueta de Armazenamento Laser',
     'Etiqueta de Armazenamento Argox',
     'Etiqueta de Armazenamento Zebra',

     {* DOCUMENTO DE NS *}
     'Nota Fiscal (NS) - Formulário Simples - Cliente',

     'Etiqueta do Código de Barras do Produto da Expedição',

     (* Produto que foi separado a mais na Expedicao de Saída *)
     'Etiqueta do produto que foi separado a mais na Expedição de Saída Laser',
     'Etiqueta do produto que foi separado a mais na Expedição de Saída Argox',

     'Etiqueta de Montagem de Caixas Laser',

     'Etiqueta de Montagem de Caixas Laser Com Cód. de Barras',
     'Etiqueta de Montagem de Caixas Laser Pack List',
     'Etiqueta de Montagem de Caixas Laser Pack List Zebra',

     'Etiqueta de Mármore/Granito',
     'Etiqueta de Mármore/Granito Argox',
     'Etiqueta do Produto Separado / Etiqueta da Quantidade Restante da Embalagem Aberta Argox',
     'Etiqueta do Produto Separado / Etiqueta da Quantidade Restante da Embalagem Aberta Laser',


     {* LOTE PRODUTOS *}
     'Etiqueta de Lote de Produtos Argox',
     'Etiqueta de Lote de Produtos',

     (* Rastreamento Produto*)
     'Lote de Rastreamento de Produto Laser',
     'Lote de Rastreamento de Produto Argox',
     'Lote de Rastreamento de Produto Zebra',

     (* Local de armazenamento - WMS *)
     'Etiqueta de Local de Armazenamento - Wms Laser',
     'Etiqueta de Local de Armazenamento - Wms Argox',

     (* Região *)
     'Etiqueta de Região Laser',
     'Etiqueta de Região Argox',

     {*Montagem de Caixa Argox Zebra*}
     'Montagem de Caixas Argox',
     'Montagem de Caixas Zebra',

     {*Produtos Controlados Vendas*}
     'Produtos Controlados Vendas Argox',
     'Produtos Controlados Vendas Laser',
     'Produtos Controlados Vendas Zebra',

     'Etiqueta Individual de Despacho por Produto Argox',


     'Etiqueta ID do plano de recebimento Laser',
     'Etiqueta ID do plano de recebimento Argox',

     'Etiqueta de Produtos Quantidade Fracionada - Laser',
     'Etiqueta de Produtos Quantidade Fracionada - Argox');

  {***************************************************************************}
  {* ARRAY PARA CONF. DO CAPTION DAS OPÇÕES DE ETIQUETAS EM FUNÇÃO DO LAYOUT *}
  {***************************************************************************}

  ARR_MENU_ETIQ: Array [tpeClienteLaser..tpeProdutoQuantidadeFracionadaArgox] Of Array[0..2] Of String = (
    ('1',   'Etiqueta de Clientes Laser', 'mnuEditorEtiquetasCliLaser'),
    ('2',   'Etiqueta de Clientes Argox',	'frmEditorEtiquetasCliArgox'),
    ('3',   'Etiqueta de Clientes Matricial', ''),
    ('4',   'Etiqueta de Fornecedor Laser', 'mnuEditorEtiquetasForLaser'),
    ('5',	  'Etiqueta de Fornecedor Argox',	'mnuEditorEtiquetasForArgox'),
    ('6',   'Etiqueta de Fornecedor Matricial', ''),
    ('7',   'Etiqueta de Diversos Laser', 'mnuEditorEtiquetasDivLaser'),
    ('8',   'Etiqueta de Diversos Matricial', ''),
    ('78', 	'Etiqueta de Diversos Argox', 'mnuEditorEtiquetasDivArgox'),
    ('9',		'Etiqueta de Estrutura Argox', 'mnuEditorEtiquetasEstArgox'),
    ('10',	'Etiqueta de Operador Laser', 'mnuEditorEtiquetasOpeLaser'),
    ('11',	'Etiqueta de Operador Matricial', ''),
    ('12',	'Etiqueta de Produtos Laser', 'mnuEditorEtiquetasIteLaser'),
    ('13',	'Etiqueta de Produtos Laser Código de Barras Padrão', 'mnuEditorEtiquetasIteLasCodBarPadr'),
    ('14',	'Etiqueta de Produtos Laser Código de Barras Personalizado', 'mnuEditorEtiquetasIteLasCodBarPers'),
    ('167',	'Etiqueta de Produtos Argox Gondola Com Preço Layout 1', 'mnuEditorEtiquetasIteLasCodBarSPre'),
    ('15',	'Etiqueta de Produtos Zebra Gondola com Preço', 'mnuEditorEtiquetasIteZebGondCPre'),
    ('16',	'Etiqueta de Produtos Zebra Gondola sem Preço', 'mnuEditorEtiquetasIteZebGondSPre'),
    ('17',	'Etiqueta de Produtos Zebra Código de Barras com Preço', 'mnuEditorEtiquetasIteZebCodBarCPre'),
    ('18',	'Etiqueta de Produtos Zebra Código de Barras sem Preço', 'mnuEditorEtiquetasIteZebCodBarSPre'),
    ('19',	'Etiqueta de Produtos Argox Gondola com Preço', 'mnuEditorEtiquetasIteArgGondCPre'),
    ('161',	'Etiqueta de Produtos Argox Gondola Com Preço Layout 1', 'mnuEditorEtiquetasIteArgGondCPreLayout1'),
    ('20',	'Etiqueta de Produtos Argox Gondola sem Preço', 'mnuEditorEtiquetasIteArgGondSPre'),
    ('21',	'Etiqueta de Produtos Argox Código de Barras com Preço', 'mnuEditorEtiquetasIteArgCodBarCPre'),
    ('22',	'Etiqueta de Produtos Argox Código de Barras sem Preço', 'mnuEditorEtiquetasIteArgCodBarSPre'),
    ('23',	'Etiqueta de Produtos Matricial', ''),
    ('24',	'Etiqueta de Produtos Orçamento/Pedido Laser', 'mnuEditorEtiquetasIteOrcPedLas'),
    ('25',	'Etiqueta de Produtos Orçamento/Pedido Laser Código de Barras Padrão', 'mnuEditorEtiquetasIteOrcPedLasCodBar'),
    ('26',	'Etiqueta de Produtos Orçamento/Pedido Zebra Gondola com Preço', 'mnuEditorEtiquetasIteOrcPedZebGondCPre'),
    ('27',	'Etiqueta de Produtos Orçamento/Pedido Zebra Gondola sem Preço', 'mnuEditorEtiquetasIteOrcPedZebGondSPre'),
    ('28',	'Etiqueta de Produtos Orçamento/Pedido Zebra Código de Barras com Preço', 'mnuEditorEtiquetasIteOrcPedZebCodBarCPre'),
    ('29',	'Etiqueta de Produtos Orçamento/Pedido Zebra Código de Barras sem Preço', 'mnuEditorEtiquetasIteOrcPedZebCodBarSPre'),
    ('30',	'Etiqueta de Produtos Orçamento/Pedido Argox Gondola com Preço', 'mnuEditorEtiquetasIteOrcPedArgGondCPre'),
    ('31',	'Etiqueta de Produtos Orçamento/Pedido Argox Gondola sem Preço', 'mnuEditorEtiquetasIteOrcPedArgGondSPre'),
    ('32',	'Etiqueta de Produtos Orçamento/Pedido Argox Código de Barras com Preço', 'mnuEditorEtiquetasIteOrcPedArgCodBarCPre'),
    ('33',	'Etiqueta de Produtos Orçamento/Pedido Argox Código de Barras sem Preço',	'mnuEditorEtiquetasIteOrcPedArgCodBarSPre'),
    ('34',	'Etiqueta de Produtos Orçamento/Pedido Matricial', ''),
    ('35',	'Etiqueta de Despacho de Mercadorias Laser', 'mnuEditorEtiquetasDespachoLaser'),
    ('139',	'Etiqueta de Despacho de Mercadorias Laser E-Commerce',	'mnuEditorEtiquetasDespachoLaserECommerce'),
    ('36',	'Etiqueta de Despacho de Mercadorias Argox', 'mnuEditorEtiquetasDespachoArgox'),
    ('37',	'Etiqueta de Despacho de Mercadorias Matricial', ''),

    ('223',	'Etiqueta de Despacho Faturar Pedido Laser', 'mnuEditorEtiquetasDespachoFaturarPedidoLaser'),
    ('224',	'Etiqueta de Despacho Faturar Pedido Argox', 'mnuEditorEtiquetasDespachoFaturarPedidoArgox'),

    ('38',	'Etiqueta de Entrega de Tinta de Máquina', 'mnuEditorEtiquetasTinta'),
    ('39',	'Etiqueta de Formulação de Tinta de Máquina', 'mnuEditorEtiquetasFormulacao'),
    ('48',	'Etiqueta de Producao de Tinta de Máquina',	'mnuEditorEtiquetasProducaoTinta'),
    ('42',	'Etiqueta de Unidades Restantes Laser - Faturamento',	'mnuEditorEtiquetasItensQtdRestFat'),
    ('43',	'Etiqueta de Unidades Restantes Argox - Faturamento',	'mnuEditorEtiquetasItensQtdRestFat'),
    ('44',	'Etiqueta de Unidades Restantes Laser - Avulsa', 'mnuEditorEtiquetasItensQtdRestAvu'),
    ('45',	'Etiqueta de Unidades Restantes Argox - Avulsa', 'mnuEditorEtiquetasItensQtdRestAvu'),
    ('46',	'Ordem de Produção Industrial Laser',	'mnuEditorEtiquetasOPI'),
    ('47',	'Ordem de Produção Industrial Argox',	'mnuEditorEtiquetasOPI'),
    ('81',	'Etiqueta de Funcionários Laser', 'mnuEditorEtiquetasFuncionariosLaser'),
    ('49',	'Etiqueta de Funcionários Argox', 'mnuEditorEtiquetasFuncionariosArgox'),
    ('50',	'Movimentação de Itens (MI)', ''),
    ('51',	'Faturamento Futuro (FF)', ''),
    ('59',	'Brinde (BR)', ''),
    ('140',	'Comprovante de Recebimento de Amostra de Veículo', ''),
    ('60',	'Troca (TR)', ''),
    ('61',	'Devolução (DV)', ''),
    ('62',	'Ajuste de Estoque (AJ)', ''),
    ('63',	'Transferência entre Armazéns/Lotes (TA/TL)', ''),
    ('64',	'Empréstimo (EP)', ''),
    ('65',	'Baixa de Empréstimo (BE)', ''),
    ('66',	'Uso / Consumo (UC)', ''),
    ('67',	'Consignação (CS)', ''),
    ('68',	'Retorno de Consignação (CR)', ''),
    ('69',	'Transferência de Estoque (TE)', ''),
    ('70',	'Baixa de Pigmento (PI)', ''),
    ('52',	'Pedido de Venda (PD)', ''),
    ('53',	'Orçamento de Venda (OR)', ''),
    ('58',	'Pedido de Devolução para Retirada (PR)', ''),
    ('150',	'Ordem de Produção para Tintas Imobiliarias/Industriais', ''),
    ('151',	'Ordem de Produção para Tintas Automotivas', ''),
    ('99',	'Ordem de Produção Avulsa de Produtos Tintométricos', ''),
    ('131',	'Ordem de Produção de Tinta de Máquina (RO)', ''),
    ('237',	'Separação Gondola', ''),

    ('71',	'Garantia - Recebimento do Cliente (GA)', ''),
    ('72',	'Garantia - Controle de Envio para o Cliente (GC)', ''),
    ('73',	'Garantia - Envio para o Fornecedor (GF)', ''),
    ('83',	'Garantia - Controle de Envio para o Fornecedor (GF)', ''),
    ('84',	'Garantia - Controle de Retorno do Fornecedor (GR)', ''),
    ('85',	'Garantia - Controle de "Baixa" do Fornecedor', ''),
    ('241',	'Solicitação de Manutenção de Equipamentos Internos', ''),
    ('214',	'Pedido de Compra', ''),

    ('107',	'Ordem de Produção', ''),
    ('56',	'Nota Fiscal (NF) - Formulário Simples - Cliente', ''),
    ('57',	'Cupom Fiscal (IF)', ''),
    ('98',	'Cupom Fiscal (NF) - Ticket', ''),
    ('113',	'Cupom Fiscal (DV) - Ticket', ''),
    ('75',	'Nota Fiscal (NF) - Formulário Simples - Fornecedor', ''),
    ('74',	'Nota Fiscal Série D1', ''),
    ('54',	'Separação pela NF/ MI/ FF/ TE...', ''),
    ('235',	'Obs. da Separação pela NF/ MI/ FF/ TE...', ''),

    ('76',	'Separação pela NF - Fornecedor', ''),
    ('55',	'Separação pelo Pedido', ''),
    ('152',	'Cupom de Serviço', ''),
    ('82',	'Separação de Romaneio', ''),
    ('105',	'Separação de Item', ''),
    ('89',	'Ordem de Serviço', ''),
    ('90',	'Ordem de Serviço - Termo de Responsabilidade', ''),
    ('91',	'Ordem de Serviço - Termo de Devolução', ''),
    ('100',	'Ordem de Serviço - Ordem de Execução de Serviço', ''),
    ('110', 'Ordem de Serviço - Imagens', ''),
    ('97',	'Requisição de Material de Consumo', ''),
    ('138',	'Requisição de Material de Consumo Vidro', ''),
    ('157',	'Liberação de Armazenagem', ''),
    ('135',	'Crediário - Carne de Pagamentos', ''),
    ('136',	'Crediário - Duplicata', ''),

    ('162', 'Inspeção de Entrada de Equipamentos', ''),
    ('163', 'Inspeção de Saída de Equipamentos', ''),

    ('164', 'Comprovante de Geração de Crédito', ''),

    ('166', 'Processo de Extrusão Ordem de Produção Industrial', ''),

    ('160',	'Locação de Equipamentos', ''),
    ('168', 'Recibo Locação (RL)', ''),
    ('169', 'Devolução Locação (DL)', ''),
    ('170', 'Fatura Contrato de Locação', ''),
    ('171', 'Recebimento de Venda a Base de Troca', ''),

    ('210', 'Endereçamento do Produto', ''),

    ('213', 'Pedido de Venda Exterior', ''),
    ('212', 'Orçamento de Venda Exterior', ''),

    ('229', 'Cupom de Promoção', ''),

    ('231', 'Remessa de Devolução (RD)', ''),
    ('232', 'Documentos de Crédito do FF (FFCR)', ''),
    ('234', 'Cupom de Próximo Desconto', ''),
    ('77',	'Requisição de Abastecimento', ''),
    ('79',	'Etiqueta de Precificação de Produtos Laser',	'mnuEditorEtiquetasPreLaser'),
    ('80',	'Etiqueta de Precificação de Produtos Argox',	'mnuEditorEtiquetasPreArgox'),
    ('82',	'Etiqueta de Produtos Controlados Laser',	'mnuEditorEtiquetasProdutosContLaser'),
    ('83',	'Etiqueta de Produtos Controlados Argox',	'mnuEditorEtiquetasProdutosContArgox'),
    ('86',	'Etiqueta de Ordem de Serviço Laser',	'mnufrmEditorEtiquetasOrdemServicoLaser'),
    ('87',	'Etiqueta de Ordem de Serviço Argox',	'mnufrmEditorEtiquetasOrdemServicoArgox'),
    ('88',	'Etiqueta de Ordem de Serviço Zebra',	'mnuEditorEtiquetasOrdemServicoZebra'),
    ('131',	'Etiqueta de Ordem de Serviço de Venda Laser', 'mnuEtiqOrdSerVendaLaser'),
    ('132',	'Etiqueta de Ordem de Serviço de Venda Argox', 'mnuEtiqOrdSerVendaArgox'),
    ('133',	'Etiqueta de Ordem de Serviço de Venda Zebra', 'mnuEtiqOrdSerVendaZebra'),
    ('40',	'Etiqueta de Produtos com Obrigatoriedade de CPF Laser', 'mnuEditorEtiquetasItensCPFLaser'),
    ('41',	'Etiqueta de Produtos com Obrigatoriedade de CPF Térmica', 'mnuEditorEtiquetasItensCPFArgox'),
    ('92',	'Etiqueta de Empresa Lazer', 'mnuImpEtiEmpresaLazer'),
    ('93',	'Etiqueta de Empresa Argox', 'mnuImpEtiEmpresaArgox'),
    ('120',	'Etiqueta de Ordem de Produção', 'mnuEditorEtiquetasOPLaser'),
    ('95',	'Etiqueta de Ordem de Produção Argox', 'mnuEditorEtiquetasOPLaserArgox'),
    ('121',	'Etiqueta de Ordem de Produção Zebra', 'mnuEditorEtiquetasOPLaserZebra'),
    ('101',	'Etiqueta de Localização Física Laser',	'mnuEtiLocFisLaser'),
    ('102',	'Etiqueta de Localização Física Argox',	'mnuEtiLocFisArgox'),
    ('103',	'Etiqueta de Plano de Recebimento Laser',	'mnuEtiquetasPlanoRecebimentoLaser'),
    ('104',	'Etiqueta de Plano de Recebimento Argox',	'mnuEtiquetasPlanoRecebimentoArgox'),
    ('105',	'Etiqueta de Sequencial de Separação WMS Laser', 'mnuEtiquetasSeqSeparacaoWMSLaser'),
    ('106',	'Etiqueta de Sequencial de Separação WMS Argox', 'mnuEtiquetasSeqSeparacaoWMSArgox'),
    ('108',	'Etiqueta de Caixas Laser',	'mnuEditorEtiquetasCaixasLaser'),
    ('109',	'Etiqueta de Caixas Argox',	'mnuEditorEtiquetasCaixasArgox'),
    ('122',	'Etiqueta de Armazenamento Laser', 'mnuEtiquetasArmazenamentoLaser'),
    ('123',	'Etiqueta de Armazenamento Argox', 'mnuEtiquetasArmazenamentoArgox'),
    ('124',	'Etiqueta de Armazenamento Zebra', 'mnuEtiquetasArmazenamentoZebra'),
    ('125',	'Nota Fiscal (NS) - Formulário Simples - Cliente', ''),
    ('137',	'Etiqueta do Código de Barras do Produto da Expedição',	'mnuEtiquetasCodBarrasProdutoExpedicaoLaser'),
    ('126',	'Etiqueta do produto que foi separado a mais na Expedição de Saída Laser', 'mnuEtiquetasSeparacaoErradaLaser'),
    ('127',	'Etiqueta do produto que foi separado a mais na Expedição de Saída Argox', 'mnuEtiquetasSeparacaoErradaArgox'),
    ('130',	'Etiqueta de Montagem de Caixas Laser',	'mnuEditorEtiquetasMontagemCaixas'),
    ('165',	'Etiqueta de Montagem de Caixas Laser Com Código de Barras',	'mnuEditorEtiquetasMontagemCaixasLaserComCodBarras'),
    ('208',	'Etiqueta de Montagem de Caixas Laser Pack List',	'mnuEditorEtiquetasMontagemCaixasLaserPackList'),
    ('209',	'Etiqueta de Montagem de Caixas Laser Pack List Zebra',	'mnuEditorEtiquetasMontagemCaixasZebraPackList'),

    ('202',	'Etiqueta de Mármore/Granito Laser', 'mnuEtiquetasMarmoreGranito'),
    ('211',	'Etiqueta de Mármore/Granito Argox', 'mnuEtiquetasMarmoreGranito'),
    ('206', 'Etiqueta do Produto Separado / Etiqueta da Quantidade Restante da Embalagem Aberta', 'mnuEtiquetaDoProdutoSeparado'),
    ('207', 'Etiqueta do Produto Separado / Etiqueta da Quantidade Restante da Embalagem Aberta Argox', 'mnuEtiquetaDoProdutoSeparadoArgox'),
    ('96',	'Etiqueta de Lote de ProdutosArgox', 'mnuEtiLoteProdArgox'),
    ('94',	'Etiqueta de Lote de Produtos', 'mnuEtiLoteProdLaser'),
    ('141',	'Lote de Rastreamento de Produto Laser', 'mnuEtiquetasLoteRastreamentoProdutoLaser'),
    ('142',	'Lote de Rastreamento de Produto Argox', 'mnuEtiquetasLoteRastreamentoProdutoArgox'),
    ('143',	'Lote de Rastreamento de Produto Zebra', 'mnuEtiquetasLoteRastreamentoProdutoZebra'),
    ('145',	'Etiqueta de Local de Armazenamento - Wms Laser', 'mnuEtiquetasLocalArmazenamentoWMSLaser'),
    ('146',	'Etiqueta de Local de Armazenamento - Wms Argox',	'mnuEtiquetasLocalArmazenamentoWMSArgox'),
    ('147',	'Etiqueta de Região Laser', 'mnuEtiquetasRegioesLaser'),
    ('148',	'Etiqueta de Região Argox', 'mnuEtiquetasRegioesArgox'),
    ('97',	'Etiqueta de Montagem de Etiqueta Argox', 'mnuEtiquetasMontagemArgox'),
    ('98',	'Etiqueta de Montagem de Etiqueta Zebra', 'mnuEtiquetasMontagemZebra'),

    ('203',	'Produtos Controlados Vendas Argox', 'mnuEtiquetasProdutoControladoVendaArgox'),
    ('204',	'Produtos Controlados Vendas Laser', 'mnuEtiquetasProdutoControladoVendaLaser'),
    ('205',	'Produtos Controlados Vendas Zebra', 'mnuEtiquetasProdutoControladoVendaZebra'),

    ('220',	'Etiqueta Individual de Despacho por Produto Argox', 'mnuEditorEtiquetasIndividuaisDespachoProdutoArgox'),

    ('221',	'Etiqueta ID do plano de recebimento Laser', 'mnuEditorEtiquetasIDDoPlanoDeRecebimentoLaser'),
    ('222',	'Etiqueta ID do plano de recebimento Argox', 'mnuEditorEtiquetasIDDoPlanoDeRecebimentoArgox'),
    ('225',	'Etiqueta de Despacho de Volume Geral Argox', 'mnuEditorEtiquetasDespachoVolumeGeralArgox'),
    ('226',	'Etiqueta de Despacho de Volume Individual Argox', 'mnuEditorEtiquetasDespachoVolumeIndividualArgox'),
    ('227',	'Etiqueta de Despacho de Volume Geral Laser', 'mnuEditorEtiquetasDespachoVolumeGeralLaser'),
    ('228',	'Etiqueta de Despacho de Volume Individual Laser', 'mnuEditorEtiquetasDespachoVolumeIndividualLaser'),
    ('223',	'Etiqueta de Produtos Quantidade Fracionada - Laser', 'mnuEditorEtiquetasProdutosQtdFracionadaLaser'),
    ('224',	'Etiqueta de Produtos Quantidade Fracionada - Argox', 'mnuEditorEtiquetasProdutosQtdFracionadaArgox'));

implementation

{ TParamDllEtiquetas }

constructor TParamDllEtiquetas.Create;
begin
  TipoOrigemEtiquetaAbreItens := toeabiOutros;
  strForceFiltro := '';
  strChaveTemporariaLotMarmore := '';
  blnAtualizaAgeIteImp := True;
  blnSepExclusiva := False;
  strMultPed := EmptyStr;
  blnImpAut := false;
  blnImpEtiquetaMontagemCaixa := False;
  strOpeImp := '';
  blnImpGrp :=  False;
  strLisGrpPre := '';
end;

{ TTipoEtiquetaHelper }

class function TTipoEtiquetaHelper.GetByName(AName: String): TTipoEtiqueta;
Var
  LTipo: TTipoEtiqueta;
begin
  Result := tpeNenhum;
  For LTipo := Low(TTipoEtiqueta) To High(TTipoEtiqueta) Do
    If LTipo.GetName.Equals(AName) Then
      Exit(LTipo);
  //Manter compatibilidade com antiga funcao fNameToTipoEtiqueta
  If      AName = 'Laser padrão' Then Result :=  tpeItensLaserCodBarPadr
  Else If AName = 'Laser personalizado' Then Result := tpeItensLaserCodBarPers
  Else If AName = 'Zebra Gondola Com Preço' Then Result := tpeItensZebraGondolaCPre
  Else If AName = 'Argox Gondola Com Preço' Then Result := tpeItensArgoxGondolaCPre
  Else If AName = 'Argox Gondola Com Preço Layout 1' Then Result := tpeItensArgoxGondolaCPreLayout1
  Else If AName = 'Zebra Cód. Barra Com Preço' Then Result := tpeItensZebraCodBarCPre
  Else If AName = 'Argox Cód. Barra Com Preço' Then Result := tpeItensArgoxCodBarCPre
  Else If AName = 'Zebra Cód. Barra Sem Preço' Then Result := tpeItensZebraCodBarSPre
  Else If AName = 'Argox Cód. Barra Sem Preço' Then Result := tpeItensArgoxCodBarSPre
  Else If AName = 'Zebra Gondola Sem Preço' Then Result := tpeItensZebraGondolaSPre
  Else If AName = 'Argox Gondola Sem Preço' Then Result := tpeItensArgoxGondolaSPre
  Else If AName = 'Laser Sem Preço' Then Result := tpeItensLaserCodBarSPre
  Else If AName = 'Nenhum' Then Result := tpeNenhum;
end;

function TTipoEtiquetaHelper.GetName: String;
begin
  Result := String(ARR_NOME_ETIQUETA[Self]);
  If Result.IsEmpty Then
    Result := 'Não identificado';
end;

end.
