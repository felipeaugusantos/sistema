unit untPcmGer;

interface

uses
  SysUtils, Classes, DB, Uni, untTypesSistema, untLotePrecos,
  Variants, ComCtrls, Forms, StrUtils, UniClientDataSet, UniDataSetProvider, Windows,
  Math, DateUtils, untEntVendor, untEntOutrasDespesas, untCadLote,
  untEntEmbalagens,untAlteraFornecedorEntrada, untTipoTinta, untZClient,
  untVinculoBaixaEntregaFuturaEdocVenda, untDefineBaixaPedido, untLiberacao,
  untMsgLiberacao, untEntradaAutomatizada, untEntRetencaoNotaServico, untEmissaoNotaEspecial,
  Faturamento.Classes.TFatVendaBase,
  Faturamento.Consignacao.Classes, untParCalculaPrecoCusto, untPreAlt_Trigger, untCalculoPisCofins,
  Controls,
  untLogCtp,
  untTCadPagRepository,
  untSelCtaPagar,
  untCadCtaPagarPrevisao,
  untControleNumeroSerie,
  untTDistribuicaoConferencia;


type
  TArrMarcaProAcaEndere = array of string;

  TRecPrecos = Record
    fltPreVen,
    fltMarBru,
    fltComiss: Double;
    blnEmbala: Boolean;
    blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco: Boolean;
  End;

  TarrPrecos = Array[1..7] Of TRecPrecos;

 TValidacaoZeraData =  record
   blnConferenciaDepoisDaEntrada: Boolean;
   blnDevolu: Boolean;
   blnRecCliGarantia: Boolean;
   blnConEqu: Boolean;
   AblnAcessadoViaRetornoConsignacao: Boolean;
   blnRetornoSimbolico: Boolean;
   strTipFor: string;
   blnUsaRotinaWMS: Boolean;
   TipoCfop: TTipoCfop;
   blnUtilizarCFG_CLARET: Boolean;
   blnUtilizaColetorCFG_TPLREC: Boolean;
   blnGeraEnderecamento: Boolean;
   blnTemItemParaEnderecar: Boolean;
   blnImpNFEEntradaRetFor: Boolean;
 end;

type
  TItemDevolucao = Record
    strDocumento,
    strEspecie,
    strEmpresa,
    strCliente,
    strProduto,
    strAutIncVenda,
    strAutIncDevolucao: String;
    fltQuantidade,
    fltTotalItem,
    fltDescontoEspecial: Double;
  End;


type
  TArrItensDevolucao = Array Of TItemDevolucao;

  function fZeraDataEntrada(ValidacaoZeraData: TValidacaoZeraData): Boolean;

  Procedure pRecalculaPrecosEntrada(qryEntMer, qryConIte: TDataSet;
                                    fltPreMed,
                                    fltPreUlt,
                                    fltPreUltImp: Double;
                                    Var fltPreCom, fltPreCus, fltPrecomOri: Double;
                                    Var recPrecos: TarrPrecos;
                                    Var blnAltPre: Boolean;
                                    Var cpcParams: TParCalculaPrecoCusto;
                                    var blnOutDesEntraNoprecoCompra: Boolean;
                                    strCodFor, strForFil, strEspDoc, strAtuNMD, strNaoAtu, strCnvEmb, strTipFor: String;
                                    blnAtpRau, blnAtpRen, blnMedSe2: Boolean;
                                    objAtuFor: TAlteraFornecedorEntrada;
                                    blnAtpVmb: TarrAtpVmb;
                                    intDecUni: Integer;
                                    blnEncargosNoFrete: Boolean);

  Procedure pCalculaPreUltImp(blnNotaImp: Boolean;
                              qryEntMer: TDataSet;
                       strCodEmp, strCodFor, strEspDoc, strSimPau, strTipFor: String;
                       dtaDtaEnt: TDateTime;
                       blnDevolu,
                       blnConEqu,
                       blnUltPis,
                       blnDedIcm,
                       blnPrecoPraticado,
                       blnAchouDevolucao,
                       blnForFil: Boolean;
                       Var CalcResult: TResultPisCofins;
                       Var fltPreUltImp, fltImpUlt, fltAlqRet,
                           fltTotAlqPis, fltTotAlqCof,
                           fltAlqPisCofPreUlt,
                           fltValorFreteCalc,
                           fltValorFreConCalc: Double);

  procedure pAddCTEMOVArr(strSeqMovDet: String; fltConFre: Double; fltAlqIcmFre: Double; var ArrCteMov: TArrCteMov);
  

  function fgravapcmger(strNumPed,
                        strCodEmp,
                        strEspDoc,
                        strCodFor,
                        strCodTra,
                        strConPag: String;
                        dtaDtaEnt,
                        tmeHorEnt,
                        dtaDtaPed: TDateTime;
                        strCompra: String;
                        fltTotIpi,
                        fltTotSub,
                        fltTotDar,
                        fltSubFCP,
                        fltTotIte,
                        fltTotGer: Double;
                        strObs001,
                        strObs002,
                        strObs003,
                        strObs004,
                        strObs005,
                        strObsPd1,
                        strObsPd2,
                        strObsPd3,
                        strPedVen,
                        strAtenca,
                        strTipFre,
                        strDocOri: String;
                        intNumCtn: Integer;
                        strPedImp,
                        strempdes: String;
                        fltDesAdi,
                        fltBasCof,
                        fltValCof,
                        fltBasPis,
                        fltValPis,
                        fltBasIcm,
                        fltValIcm,
                        fltBasIpi,
                        fltBasSub: Double;
                        strCodCta: String='';
                        strNumPok: String='';
                        fltValFre: Double = 0;
                        blnGeraParcelas: Boolean = True;
                        dtaDtaFat: TDateTime = 0): Boolean;

  function fGravaPcmDet(strCampoSaldoAdd: String;
                        intDeqTpc: Integer;
                        strNumPed,
                        strCodEmp,
                        strEspDoc,
                        strCodFor,
                        strCodIte,
                        strCodUni: String;
                        dtaDtaEnt,
                        tmeHorPed,
                        dtaDtaPed: TDateTime;
                        strCndPag,
                        strDesIte: String;
                        fltQtdIte,
                        fltUniTar,
                        fltDesUni,
                        fltTotIte,
                        fltPerIpi,
                        fltTotIpi,

                        fltPerSub,
                        fltTotSub,
                        fltTotDar,

                        fltPerFCP,
                        fltSubFCP,

                        fltQtdBai,
                        fltTotBai,
                        fltIpiBai,
                        fltSubBai,
                        fltFreBai,
                        fltAceBai,
                        fltValFre,
                        fltDesAce,
                        fltValIcm,
                        fltDesPis: Double;
                        intBaixad: Integer;
                        strDocOri: String;
                        intNumCtn: Integer;
                        strPedImp,
                        strPedTxt: String;
                        Var strAutInc: String;
                        strCodAca,
                        strEmpAca: String;
                        blnProAca: Boolean;
                        strNumLot: String = '';
                        fltEmbala: Double = 1;
                        intAdicao: Integer = 0): Boolean;

  function fPedidoBaixado(strNumPed, strCodEmp, strEspDoc: String): Boolean;
  function fDeletaPedido(strNumPed, strCodEmp, strEspDoc: String): Boolean;
  function fLimpaVinculoComRequisicoes(strNumPed, strCodEmp, strEspDoc: String): Boolean;

  function fAtualizaDocumentoOriginal(arrDocOri: TStringArrayArray; strNumDoc, strEspDoc: String): Boolean;

  function fAtualizaDadosPcmDet(fltQtdIte,
                                fltUnitar: Double;
                                strNumPed,
                                strCodEmp,
                                strSeqPcd,
                                strForEle,
                                strCnvEmb: String;
                                blnNotEle,
                                blnSaldoPendente,
                                blnLibPcm: Boolean;
                                strForFil: String;
                                intDEQTPC: Integer): Boolean;

  function fBaixaPcmDet(strNumPed, strCodEmp, strNumDoc,strEspDoc, strSerie_: String; blnSaldoPendente: Boolean): Boolean;

  function fBaixaPcmGer(blnNotEle: Boolean; strNumPed, strCodEmp, strNumDoc, strEspDoc: String; blnSempreBaixa: Boolean = False): Boolean;
  procedure pRecalculaPrecos(Var recPrecos: TarrPrecos;
                             Var fltPreCus: Double;
                             Var blnAltPre: Boolean;
                             var cpcParams: TParCalculaPrecoCusto;
                                 fltPreCom: Double;
                                 qryConIte,
                                 qryEntMer: TDataSet;
                                 blnAtuFor: Boolean;
                                 blnAtpVmb: TArrAtpVmb);


Procedure pAtualizaPrecos(strEmpresas: String; qryTempor: TDataSet;
                          recPrecos: TarrPrecos;
                          fltPreCom,
                          fltPreCus,
                          fltCotDol: Double;
                          blnResFor,
                          blnInfMat,
                          blnAtuPis,
                          blnAtuDic: Boolean;
                          intInfFed,
                          intInfSai,
                          intInfOpe,
                          intDecUni: Integer;
                          strAgrupadorPreAlt: String);

  Function fCalculaComissaoDevolucao(strNumAde,
                                     strAutVen,
                                     strTabDev,
                                      strCodIte,
                                      strNumDoc,
                                      strEspDoc,
                                      strCodEmp: string;
                                      fltTotIte,
                                      fltQtdIte: Double;
                                      Var strTabela: String;
                                      Var strCodVen,
                                      strCodVe2,
                                      strCodRep,
                                      strTabPre: String;
                                      Var fltPerCom,
                                      fltTotCom,
                                      fltTotCo2,
                                      fltPerRep,
                                      fltTotExt,
                                      fltVlrCom,
                                      fltTotCus,
                                      fltTotCu2,
                                      fltOutVal,
                                      fltIcmSai,
                                      fltImpFed,
                                      fltDesOpe,
                                      fltImpUlt,
                                      fltTotUlt,
                                      fltVal_RT,
                                      fltUniOri: Double): Boolean;

  function fRetTotalBonificacaoEntMer: Double;

  Procedure pAtualizaUltimaCompra(strNumDoc,
                                  strEspDoc,
                                  strSerie_,
                                  strCodFor,
                                  strCodIte,
                                  strClaFisDet,
                                  strClaIpi,
                                  strForFil,
                                  strNumLot,
                                  strMedEmp,
                                  strEmpMeds: String;
                                  blnAtuMed,
                                  blnAtuUlt,
                                  blnMedSe2: Boolean;
                                  fltPreUlt,
                                  fltPreUltImp,
                                  fltPreMed,
                                  fltQtdIte,
                                  fltUltCot: Double;
                                  dtaDtaEnt: TDateTime;
                                  blnRecCliGarantia: Boolean;
                                  cdsMovGad: TUniClientDataSet;
                                  blnConEqu: Boolean;
                                  var blnUpdatePreMed : Boolean);

  Procedure pAtualizaUltimaCompraCadLot(strCodIte,
                                        strNumLot,
                                        strCodFor,
                                        strNotUlt,
                                        strCodEmp: String;
                                        fltPreUlt,
                                        fltPreUltImp: Double;
                                        dtaDtaEnt: TDateTime;
                                        blnUltimaNota: Boolean = False);

  procedure pEnviaMsgRequisicaoConcluida(strSeqGer: String; blnConferencia: Boolean = False);
  procedure pSetaReservaSaldoPedidoOS(strSeqGer: String; blnConferencia: Boolean = False);
  function fBaixaPedidosAtendidosDepoisDaEntrada(strAutoincMovDet: String): Boolean;
  function fItemJaProcessado(strIncGae, strIncGad: String): Boolean;


  procedure pVinculaImportacaoDocumentoComEntrada(strSeqDet, strNumDoc, strEspDoc, strCodEmp, strCodFor,
                                                  strSerie, strCodIte: string);
  procedure pMarcaMovTriComAtualizacaoDePrecos(strSeqDet: String);
  function  fGravaCALGNR(qryEntMer: TDataSet; strAutIncTmp: String): Boolean;


  procedure pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque(strSeqGer: String; blnVaiGerarEnderecamentoDepois_ou_JaGerou: Boolean);

  procedure pProcessaPrecoDeVendaEMargem(blnNotaImp: Boolean;
                                         qryEntMer: TDataSet;
                                         Var cdsPrecosEntMer: TDataSet;
                                         cdsMovGad: TUniClientDataSet;
                                         blnConEqu: Boolean;
                                         strAutEle,
                                         strNumDoc,
                                         strCodFor,
                                         strSerie: String;
                                         fltCotDol: Double;
                                         objAtuFor: TAlteraFornecedorEntrada;
                                         objEntAuto: TEntradaAutomatizada = Nil;
                                         blnPrecoPraticado: Boolean = False;
                                         strNaoAtu: String = '';
                                         blnEncargosNoFrete: Boolean = False;
                                         blnGarantia: Boolean = False;
                                         blnRecCliGarantia: Boolean = False;
                                         AblnAcessadoViaRetornoConsignacao : Boolean = False;
                                         tpFinalidadeXML: tpeFinalidadeXML = xmlEntradaMercadoria;
                                         strEmpresaDeposito: String = '');
  procedure pGravaPreEnt(qryEntMer: TDataSet; incMovDet: String; fltImpUlt, fltPreCom, fltPreCus, fltPrecomOri: Double; blnOutDesNoPrecom: Boolean; blnOutDesNoFreIte,blnencargosNoFrete,blnFreIpi: Boolean);

  function fConfirmaEntradaMercadorias(Var strSeqGer: String;
                                       var strListaItens: String;
                                       var ArrCteMov: TArrCteMov;
                                       var blnGravouMovDet: Boolean;
                                       Out blnGerouLotDePreco: Boolean;
                                       strTipFor: String;
                                       blnNotImport: Boolean;
                                       objAtuFor: TAlteraFornecedorEntrada;
                                       cdsDefBaixa: TDefineBaixaPedido;
                                       arrLinDigCodbar: TarrLinDigCodbar;
                                       fltCotDol,
                                       fltFreNot: Double;
                                       strCodOpe,
                                       strCndPag,
                                       strPorBai,
                                       strCodCta,
                                       strCodFor,
                                       strCodFaz,
                                       strNumDoc,
                                       strEspDoc: String;
                                       dtaDtaEnt,
                                       dtaDtaDoc,
                                       dtaIcmAnt: TDateTime;
                                       strSerie,
                                       strEstFor,
                                       strVeiBol,
                                       strDeposi,
                                       strEspVol: String;
                                       fltQtdVol: Double;
                                       fltAlqFor: Double;
                                       pgbDados: TProgressBar;
                                       strCodEve: String;
                                       blnDevolu: Boolean;
                                       strCodDig,
                                       strCodRep: String;
                                       blnGraFin,
                                       blnImprCP: Boolean;
                                       strHisCtp: String;
                                       fltTotPis,
                                       fltTotCof,
                                       fltBasPis,
                                       fltBasCof,
                                       fltAlqPis,
                                       fltAlqCof: Double;
                                       strCodCon: String;
                                       oleItensPedidos: OleVariant;
                                       strOrdIte,
                                       strNomeForm: String;
                                       blnCarPro: Boolean;           // Se carregou itens do pedido de compra
                                       strAutEle: String;            // AUTOINCREM DA NOTA FISCAL ELETRONICA
                                       strModFre,                    // Mod. Frete
                                       str_Chave,                    // Chave NFE
                                       strCodOco: String;            // Motivo da devolução
                                       qryEntMer: TDataSet;           // Query com os Itens da Entrada de Mercadoria
                                       objVendor: TEntVendor;
                                       objOutDes: TEntOutrasDespesas;
                                       cdsCtpDet: TUniClientDataSet;
                                       Var strAutIncCadFis : String;
                                       Var arrDuplicata: TarrDuplicata;
                                       objEmbala: TEntEmbalagens;
                                       dtsCadFis: TDataSet;
                                       strDocFre: String;               // Conhecimento de frete
                                       fltConFre: Double;               // Conhecimento de frete
                                       strNumAde: String;               // Número do AD
                                       intCtpCon: Longint;
                                       Out strAutIncMovGer: string;
                                       fltPesBru: Double = 0;
                                       fltPesLiq: Double = 0;
                                       strNaoAtu: String = '';
                                       fltVAntFr: Double = 0; // Valor de Antecipação do Conhecimento
                                       fltBAntFr: Double = 0; // Base de Antecipação do Conhecimento
                                       blnGarantia: Boolean = False;
                                       blnRecCliGarantia: Boolean = False;
                                       cdsMovGad: TUniClientDataSet = Nil;
                                       arrDocOri: TStringArrayArray = Nil; //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                       blnPedFilialGarantia: Boolean = False;
                                       blnConEqu: Boolean = False; //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                       blnDescIncond: Boolean = False;  //Desconto Incondicional
                                       blnFreIpi: Boolean = False;
                                       blnPrecoPraticado: Boolean = False;
                                       frmVinculoBaixaEntregaFuturaEdocVenda: TfrmVinculoBaixaEntregaFuturaEdocVenda = nil;
                                       blnUtilizarCFG_CLARET: boolean = False;
                                       strBcoFor: String = '';
                                       strCodMod: String = '';
                                       objEntAuto: TEntradaAutomatizada = Nil;
                                       strCompet: String = '';
                                       arrClienteConsumidor: TStringArray = Nil;
                                       onBeforeConfirma : TGenericProcedure = nil;
                                       onAfterConfirma  : TGenericProcedure = nil;
                                       tpFinalidadeXML: tpeFinalidadeXML = xmlEntradaMercadoria;
                                       frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico = nil;
                                       AblnAcessadoViaRetornoConsignacao : Boolean = False;
                                       ATipoRetornoConsignacao : tTipoRetornoConsignacao = ttrImportacaoXML;
                                       strExtFul: String = '';
                                       strCodExt: String = '';
                                       blnRetornoSimbolico: Boolean = False;
                                       objEmissaoNotaEspecial : TEmissaoNotaEspecial =nil;
                                       strEmpresaDeposito: String = '';
                                       blnEncargosNoFrete: Boolean = False;
                                       TipoCFOP: TTipoCFOP = tcCFOPNormal;
                                       blnFornJaAtualizado: Boolean = False;
                                       blnEhAbastecimentoDeposito: Boolean = False;
                                       blnGerarContasAPagarx117: Boolean = False;
                                       strCodCondicaoPagamentoClienteDevolucao: String = '';
                                       blnPrevis: Boolean = False): Boolean;

  function fGeraHtml(strNumPed, strEspDoc: String): String;

  function fFornecedorGravaCtp(strCodFor: String): Boolean;

  function fTestaDataBalanco(strNumPed, strNumEmp: String; Var qryGenIte : TUniQuery): Boolean;

  function fDefinePedidosABaixar(Var blnResult: Boolean; // = False se houve erro
                                 qryTmpItens: TDataSet;
                                 stlPedidos: TStringList;
                                 strAutEle: String;
                                 blnEntradaSimplificada: Boolean = False;
                                 blnCaixaUm: Boolean = False;
                                 cdsDefBaixa: TDefineBaixaPedido = Nil;
                                 strAutDet: String = 'AUTOINCREM';
                                 blnBaixaEfetivaMovFiscal: Boolean = False;
                                 strAutoIncMOVGER: string = ''): OleVariant;

  function fDefinePedidosABaixarGarantia(Var blnResult: Boolean; // = False se houve erro
                                         qryTmpItens: TDataSet;
                                         strCnvEmb: String;
                                         blnRefugo : Boolean =  False;
                                         blnBaixa  : Boolean = False;
                                         cdsDefBaixa: TDefineBaixaPedido = Nil;
                                         strAutDet: String = 'AUTOINCREM'): OleVariant;

  function fGravaHistoricoEntradaMercadorias(strNumDoc,
                                             strEspDoc,
                                             strCodEmp,
                                             strCodFor,
                                             strSerie,
                                             strNumPed,
                                             strEmpPed,
                                             strCodIte,
                                             strDesIte: String;
                                             fltQtdIte,
                                             fltUnitar,
                                             fltTotIte,
                                             fltQtdBai,
                                             fltUniBai,
                                             fltTotBai,
                                             fltExcess,
                                             fltDifQtd,
                                             fltDifUni: Double;
                                             strAutInc: String = ''): Boolean;

  function fPedidoJaExplodido(strNumPed, strEspPed, strEmpPed: String): Boolean;

  function fCalTotPontProfissDev: Double;

  function fQtdPontoProfiss(strCodIte, strCodEmp: String): Double;

  function fDesfaturaPedidoCompra(stlPedCom: TStringList): Boolean;

  function fVerificaItensAbaixoPrecoMedio(blnNotaImp: Boolean;
                                          qryEntMer: TUniQuery;
                                          strCodFor,
                                          strCodEmp,
                                          strEspDoc,
                                          strNaoAtu: String;
                                          dtaDtaEnt: TDateTime;
                                          Var blnErro: Boolean;
                                          blnPrecoPraticado,
                                          blnConEqu: Boolean;
                                          objAtuFor: TAlteraFornecedorEntrada;
                                          fltCotDol: Double;
                                          blnEncargosNoFrete: Boolean): TUniClientDataSet;

  Function fLiberaPrecoMedio(cdsItens: TDataSet; strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String): Boolean;

  procedure pConverteQtdItensEmb;

  procedure pAtualizaPercentuaisSubstituicaoFreteDoItem(blnAtuTCI, blnAtu_TS, blnAtuSub, blnAtuFre, blnAtuIcm, blnFreIpi, blnencargosNoFrete, blnNotaImportacao: Boolean; fltValFre, fltFreCon: Double; var blnOutDesNoFreIte: Boolean);

  function fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  function fGerarPedidosReservaEstoque(strDocEnt, strEspEnt, strSerEnt,
    strForEnt, strCodEmp: String; qryEntMer, qryConIte: TDataSet;
    blnDevolu: Boolean; blnRecCliGarantia: Boolean; blnConEqu: Boolean; blnAcessadoViaRetornoConsignacao: Boolean;
    objCadLot: TCadLot; ArrMarcaProAcaEndere: TArrMarcaProAcaEndere; prgProgresso: TProgressBar = Nil): Boolean;

  function fAtualizaTabelaAux(strCodIte,strSeqDet:String; blnEntradaDeMercadorias : Boolean = True): Boolean;

  function fEhRecClienteGarantia(blnRecCliGarantia: Boolean; cdsMovGad: TUniClientDataSet): Boolean;

  Procedure pExcluiContagemAnalitica(strAutInc: String);

  procedure pRetornaDadosCliente(strCodFor: String; Var strNomCli, strEmaCli: String);

  Function fBaixaProdutoAcabadoDecomposto(strAutMovDet: String; const strCodAca, strEmpAca,
    strTipFat, strNumFat, strEmpFat, strCodOco, strEmpOrigem, strCndPag, strCodOpe,
    strNumDoc, strEspDoc, strCodEmp, strCodCli, strSeqGerDev, strSerie: string;
    fltQtdDev, fltQtdOri, fltVlrCon, fltTotIte: Double; dtaDtaEnt: TDateTime;
    blnDevolucao: Boolean; var strAutIncMovGer: String; strTip_FC: string = 'C'): Boolean;

  function fVerificaVariacaoQuantidadeFinal(qryEntMer, qryItePed : TDataSet; cdsCopia : TUniClientDataSet = nil): Boolean;

  function fGComProDev(arrItensDev: TArrItensDevolucao;
                       strNumDoc,
                       strEspDoc,
                       strCodCli: String): Boolean;

  function fRetSQLComPro(arrItensDev: TArrItensDevolucao): String;

  function fGComProDevCtr(arrItensDev: TArrItensDevolucao;
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strClaFis,
                          strCodVen,
                          strCodDig,
                          strCodPor: String): Boolean;
  Function fTrataRecebimentoDeGarantiaFilial : Boolean;

  function  fGravaPortariaCAT(strCodEmp, strCodVen, strTipDoc, strNumDoc, strClaFis, strForCli: string): Boolean;
  procedure pGravaFisAju(strCodCAT, strCFOP, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen: string; intTipGra: integer; fltValor: Double);
  function  fBuscaAutoIncCADFIS(strNumDoc, strTipoDoc, strForCli: string): string;
  procedure pBuscaValoresCST10(strCodEmp, strCodVen, strNumDoc, strTipDoc: string; var fltValorST, fltOutras: Double);
  function fRetHistoricoRetencao(dtsCadFis: TDataSet;  fltTotDoc: Double): String;


  function fBaixaPedidos(oleItensPedidos : oleVariant; cdsPedidos : TUniClientDataSet;
                         blnEntradaDeMercadorias : Boolean = True):Boolean;

  procedure pCarregarDuplicataAReceberParaRetornoConsignacao(const AIdGerEle, AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrCodigoCliFor, AstrTip_FC : String; var arrDuplicata: TarrDuplicata);
  procedure pLocalizaDocumentoOrigem(AstrNumped, AStrCodemp, AstrEspDoc, AStrCodAca: String; var strNumPed: String; var strCodEmp:String;  var strEspDoc: string);
  function fTemMamoreNaEntrada: Boolean;
  Function fTemItemMarcadoParaFazerEnderecamento(qryEntMer: TDataSet) : Boolean;
  procedure pAlterarVencimento(strAutInc: String; dtaVencimento: TDate);
  function pAlteraContasPagar(const DataSet: TDataSet; fltTotDoc: Double;
    strCodEmp, strNumDoc, strSerie: String): Boolean;
  function fGravarContasPagarPrevisao(dtsCadFis: TDataSet): Boolean;
  function fGravarNumeroSerie(oleItensPedidos: OleVariant; strNumDoc, strEspDoc,
    strSerie, strCodEmp: String): Boolean;
implementation

uses  untCadIte, untCadFis, untEnderecamentoProduto,
      untFuncoesCRM, untMsgInterna, untFuncTinta,
      untTConfiguracao, untSaldoPedidoCompra,
      untFuncoesGenerica,
      untConstantes,
      untfuncoesSimples,
      untFuncoes,
      untPreAlt,
      untFuncoesAuxiliares,
      untFatorPreco,
      untFuncFatTypes,
      untCadRec,
      untComissaoProfissional,
      untProdAcabado,
      untFuncFat,
      untMovGer,
      untGarant,
      untControleChavesGarantia,
      untClubeFidelidade,
      untMovBan,
      untCadPag,
      untPromocaoBrindes,
      untPreNota,
      untCalculoUltimaCompraImpostos, untFuncoesPedidoSimples,
      untTCadPag, untFatGor, untDuplicatasPedidoCompra,
      untTBanCtpRepository, untAtualizaOcorrenciasCRM, untProdMargemNegativa,
      untProjetos, untTinGer, untFatImpressao, untDuplicatas,
      Fulfillment.RegrasMovimentacaoEstoque, untManutencaoEquipamentoInterno;

Const
  CONFERENCIA_PEDIDO = '2';

Var
  VS_strTCoPro: String;
  blnAtualizaForPed: Boolean;
  ArrMarcaProAcaEndere: TArrMarcaProAcaEndere;

  {*****************************************}
{* CRIA REGISTRO NA 'PCMGER'             *}
{**************************************MV*}
function fGravaPcmGer(strNumPed,
                      strCodEmp,
                      strEspDoc,
                      strCodFor,
                      strCodTra,
                      strConPag: String;
                      dtaDtaEnt,
                      tmeHorEnt,
                      dtaDtaPed: TDateTime;
                      strCompra: String;
                      fltTotIpi,
                      fltTotSub,
                      fltTotDar,
                      fltSubFCP,
                      fltTotIte,
                      fltTotGer: Double;
                      strObs001,
                      strObs002,
                      strObs003,
                      strObs004,
                      strObs005,
                      strObsPd1,
                      strObsPd2,
                      strObsPd3,
                      strPedVen,
                      strAtenca,
                      strTipFre,
                      strDocOri: String;
                      intNumCtn: Integer;
                      strPedImp,
                      strEmpDes: String;
                      fltDesAdi,
                      fltBasCof,
                      fltValCof,
                      fltBasPis,
                      fltValPis,
                      fltBasIcm,
                      fltValIcm,
                      fltBasIpi,
                      fltBasSub: Double;
                      strCodCta: String='';
                      strNumPok: String='';
                      fltValFre: Double = 0;
                      blnGeraParcelas: Boolean = True;
                      dtaDtaFat: TDateTime = 0): Boolean;
  Var
    strAutInc,
    strSQL   : String;
    qryGenGer: TUniQuery;
    objParcelas: TDuplicatasPedidoCompra;
begin

  qryGenGer := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO ';
  strSQL := strSQL + '  PCMGER ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  PCG_NUMPED, ';
  strSQL := strSQL + '  PCG_CODEMP, ';
  strSQL := strSQL + '  PCG_EMPDES, ';
  strSQL := strSQL + '  PCG_ESPDOC, ';
  strSQL := strSQL + '  PCG_CODFOR, ';
  strSQL := strSQL + '  PCG_CODTRA, ';
  strSQL := strSQL + '  PCG_CONPAG, ';
  strSQL := strSQL + '  PCG_DTAENT, ';
  strSQL := strSQL + '  PCG_HORENT, ';
  strSQL := strSQL + '  PCG_DTAPED, ';
  strSQL := strSQL + '  PCG_CODCMP, ';
  strSQL := strSQL + '  PCG_TOTIPI, ';
  strSQL := strSQL + '  PCG_TOTSUB, ';
  strSQL := strSQL + '  PCG_TOTDAR, ';
  strSQL := strSQL + '  PCG_SUBFCP, ';
  strSQL := strSQL + '  PCG_TOTITE, ';
  strSQL := strSQL + '  PCG_TOTGER, ';
  strSQL := strSQL + '  PCG_OBS001, ';
  strSQL := strSQL + '  PCG_OBS002, ';
  strSQL := strSQL + '  PCG_OBS003, ';
  strSQL := strSQL + '  PCG_OBS004, ';
  strSQL := strSQL + '  PCG_OBS005, ';
  strSQL := strSQL + '  PCG_OBSPD1, ';
  strSQL := strSQL + '  PCG_OBSPD2, ';
  strSQL := strSQL + '  PCG_OBSPD3, ';
  strSQL := strSQL + '  PCG_PEDVEN, ';
  strSQL := strSQL + '  PCG_ATENCA, ';
  strSQL := strSQL + '  PCG_TIPFRE, ';
  strSQL := strSQL + '  PCG_DOCORI, ';

  strSQL := strSQL + '  PCG_ORIGND, ';
  strSQL := strSQL + '  PCG_ORIGES, ';
  strSQL := strSQL + '  PCG_ORIGEP, ';

  strSQL := strSQL + '  PCG_NUMCTN, ';
  strSQL := strSQL + '  PCG_PEDIMP, ';
  strSQL := strSQL + '  PCG_DESADI, ';

  strSQL := strSQL + '  PCG_BASCOF, ';
  strSQL := strSQL + '  PCG_VALCOF, ';
  strSQL := strSQL + '  PCG_BASPIS, ';
  strSQL := strSQL + '  PCG_VALPIS, ';
  strSQL := strSQL + '  PCG_BASICM, ';
  strSQL := strSQL + '  PCG_VALICM, ';
  strSQL := strSQL + '  PCG_BASIPI, ';
  strSQL := strSQL + '  PCG_BASSUB, ';
  strSQL := strSQL + '  PCG_BAIXAD, ';
  strSQL := strSQL + '  PCG_PAGVIS, ';
  strSQL := strSQL + '  PCG_CODCTA, ';
  strSQL := strSQL + '  PCG_NUMPOK, ';
  strSQL := strSQL + '  PCG_VALFRE, ';
  strSQL := strSQL + '  PCG_DTAFAT, ';
  strSQL := strSQL + '  AUTOINCREM) ';
  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :NUMPED, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :EMPDES, ';
  strSQL := strSQL + '  :ESPDOC, ';
  strSQL := strSQL + '  :CODFOR, ';
  strSQL := strSQL + '  :CODTRA, ';
  strSQL := strSQL + '  :CONPAG, ';
  strSQL := strSQL + '  :DTAENT, ';
  strSQL := strSQL + '  :HORENT, ';
  strSQL := strSQL + '  :DTAPED, ';
  strSQL := strSQL + '  :CODCMP, ';
  strSQL := strSQL + '  :TOTIPI, ';
  strSQL := strSQL + '  :TOTSUB, ';
  strSQL := strSQL + '  :TOTDAR, ';
  strSQL := strSQL + '  :SUBFCP, ';
  strSQL := strSQL + '  :TOTITE, ';
  strSQL := strSQL + '  :TOTGER, ';
  strSQL := strSQL + '  :OBS001, ';
  strSQL := strSQL + '  :OBS002, ';
  strSQL := strSQL + '  :OBS003, ';
  strSQL := strSQL + '  :OBS004, ';
  strSQL := strSQL + '  :OBS005, ';
  strSQL := strSQL + '  :OBSPD1, ';
  strSQL := strSQL + '  :OBSPD2, ';
  strSQL := strSQL + '  :OBSPD3, ';
  strSQL := strSQL + '  :PEDVEN, ';
  strSQL := strSQL + '  :ATENCA, ';
  strSQL := strSQL + '  :TIPFRE, ';
  strSQL := strSQL + '  :DOCORI, ';

  strSQL := strSQL + '  :ORIGND, ';
  strSQL := strSQL + '  :ORIGES, ';
  strSQL := strSQL + '  :ORIGEP, ';

  strSQL := strSQL + '  :NUMCTN, ';
  strSQL := strSQL + '  :PEDIMP, ';
  strSQL := strSQL + '  :DESADI, ';

  strSQL := strSQL + '  :BASCOF, ';
  strSQL := strSQL + '  :VALCOF, ';
  strSQL := strSQL + '  :BASPIS, ';
  strSQL := strSQL + '  :VALPIS, ';
  strSQL := strSQL + '  :BASICM, ';
  strSQL := strSQL + '  :VALICM, ';
  strSQL := strSQL + '  :BASIPI, ';
  strSQL := strSQL + '  :BASSUB, ';
  strSQL := strSQL + '  :BAIXAD, ';
  strSQL := strSQL + '  IF(:CONPAG = "01000", "S", "N"), ';
  strSQL := strSQL + '  :CODCTA, ';
  strSQL := strSQL + '  :NUMPOK, ';
  strSQL := strSQL + '  :VALFRE, ';
  strSQL := strSQL + '  :DTAFAT, ';
  strSQL := strSQL + '  :AUTINC) ';

  Try

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString   := strNumPed;
      ParamByName('CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strEmpDes) Then
        ParamByName('EMPDES').Value    := Null
      Else
        ParamByName('EMPDES').AsString := strEmpDes;

      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODFOR').AsString   := strCodFor;

      If fEmptyStr(strCodTra) Then
        ParamByName('CODTRA').Value := Null
      Else
        ParamByName('CODTRA').AsString   := strCodTra;

      ParamByName('CONPAG').AsString   := fTiraCaracEspeciais(strConPag);

      If dtaDtaEnt = 0 Then
        ParamByName('DTAENT').Value := Null
      Else
        ParamByName('DTAENT').AsDateTime := dtaDtaEnt;  // DATA DO PEDIDO

      If dtaDtaFat = 0 Then
      Begin
        //Caso a data de faturamento não esteja preenchida, o sistema considerará a data do pedido.
        If dtaDtaEnt = 0 Then
          ParamByName('DTAFAT').Value := Null
        Else
          ParamByName('DTAFAT').AsDateTime := dtaDtaEnt;  // DATA DO PEDIDO
      End
      Else
        ParamByName('DTAFAT').AsDateTime := dtaDtaFat; //Data Faturamento

      If fltValFre > 0 Then
        ParamByName('VALFRE').AsFloat := fltValFre //vALOR DO FRETE
      Else
        ParamByName('VALFRE').Value := 0;

      If tmeHorEnt = 0 Then
        ParamByName('HORENT').Value := Null
      Else
        ParamByName('HORENT').AsDateTime := tmeHorEnt; // HORA DO PEDIDO

      If dtaDtaPed = 0 Then
        ParamByName('DTAPED').Value := Null
      Else
        ParamByName('DTAPED').AsDateTime := dtaDtaPed;  // DATA DE ENTREGA

      If fEmptyStr(strCompra) Then
        ParamByName('CODCMP').Value := Null
      Else
        ParamByName('CODCMP').AsString := strCompra;

      ParamByName('TOTIPI').AsFloat    := fltTotIpi;
      ParamByName('TOTSUB').AsFloat    := fltTotSub;
      ParamByName('TOTDAR').AsFloat    := fltTotDar;
      ParamByName('SUBFCP').AsFloat    := fltSubFCP;
      ParamByName('TOTITE').AsFloat    := fltTotIte;
      ParamByName('TOTGER').AsFloat    := fltTotGer;
      ParamByName('OBS001').AsString   := strObs001;
      ParamByName('OBS002').AsString   := strObs002;
      ParamByName('OBS003').AsString   := strObs003;
      ParamByName('OBS004').AsString   := strObs004;
      ParamByName('OBS005').AsString   := strObs005;
      ParamByName('OBSPD1').AsString   := strObsPd1;
      ParamByName('OBSPD2').AsString   := strObsPd2;
      ParamByName('OBSPD3').AsString   := strObsPd3;

      If fEmptyStr(strPedVen) Then
        ParamByName('PEDVEN').Value    := Null
      Else
        ParamByName('PEDVEN').AsString := strPedVen;

      ParamByName('ATENCA').AsString   := strAtenca;
      ParamByName('TIPFRE').AsString   := strTipFre;
      ParamByName('DOCORI').AsString   := strDocOri;
      If strDocOri <> '' Then
      begin
        ParamByName('ORIGND').AsString :=  Copy(strDocOri, 1 , 12);
        ParamByName('ORIGES').AsString :=  Copy(strDocOri, 13 , 2);
        ParamByName('ORIGEP').AsString :=  Copy(strDocOri, 15 , 18);
      End;

      ParamByName('NUMCTN').AsInteger  := intNumCtn;
      ParamByName('PEDIMP').AsString   := strPedImp;
      ParamByName('DESADI').AsFloat    := fltDesAdi;

      ParamByName('BASCOF').AsFloat    := fltBasCof;
      ParamByName('VALCOF').AsFloat    := fltValCof;
      ParamByName('BASPIS').AsFloat    := fltBasPis;
      ParamByName('VALPIS').AsFloat    := fltValPis;
      ParamByName('BASICM').AsFloat    := fltBasIcm;
      ParamByName('VALICM').AsFloat    := fltValIcm;
      ParamByName('BASIPI').AsFloat    := fltBasIpi;
      ParamByName('BASSUB').AsFloat    := fltBasSub;
      ParamByName('BAIXAD').AsInteger  := 0;

      If fEmptyStr(strCodCta) Then
        ParamByName('CODCTA').Value    := Null
      Else
        ParamByName('CODCTA').AsString := strCodCta;

      If fEmptyStr(strNumPok) Then
        ParamByName('NUMPOK').Value    := Null
      Else
        ParamByName('NUMPOK').AsString := strNumPok;

      strAutInc :=  fRetAutoIncrem('PCMGER', strCodEmp);
      ParamByName('AUTINC').AsString   := strAutInc;

      ExecSQL;
      Close;
      If blnGeraParcelas Then
      Begin
        objParcelas := TDuplicatasPedidoCompra.Create;
        objParcelas.pGravaParcelas(strAutInc, strConPag, strCodFor, fltTotGer, fltTotIte, dtaDtaPed);
        FreeAndNil(objParcelas);
      End;

      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaPcmGer]');
    End;
  End;

  FreeAndNil(qryGenGer);

end;

function fGravaPcmDet(strCampoSaldoAdd: String;
                      intDeqTpc: Integer;
                      strNumPed,
                      strCodEmp,
                      strEspDoc,
                      strCodFor,
                      strCodIte,
                      strCodUni: String;
                      dtaDtaEnt,
                      tmeHorPed,
                      dtaDtaPed: TDateTime;
                      strCndPag,
                      strDesIte: String;
                      fltQtdIte,
                      fltUniTar,
                      fltDesUni,
                      fltTotIte,
                      fltPerIpi,
                      fltTotIpi,

                      fltPerSub,
                      fltTotSub,
                      fltTotDar,

                      fltPerFCP,
                      fltSubFCP,

                      fltQtdBai,
                      fltTotBai,
                      fltIpiBai,
                      fltSubBai,
                      fltFreBai,
                      fltAceBai,
                      fltValFre,
                      fltDesAce,
                      fltValIcm,
                      fltDesPis: Double;
                      intBaixad: Integer;
                      strDocOri: String;
                      intNumCtn: Integer;
                      strPedImp,
                      strPedTxt: String;
                      Var strAutInc: String;
                      strCodAca,
                      strEmpAca: String;
                      blnProAca: Boolean;
                      strNumLot: String = '';
                      fltEmbala: Double = 1;
                      intAdicao: Integer = 0): Boolean;
  Var
    qryPcmDet: TUniQuery;
    strSQL: String;

begin

  Try

    If fEmptyStr(strNumPed) Then
    Begin
      Result := False;
      pMensagensErro('Número do pedido vazio!','[fGravaPcmDet]');
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM PCMDET     ';
    strSQL := strSQL + ' WHERE                    ';
    strSQL := strSQL + ' PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + ' PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + ' PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + ' PCD_NUMCTN = 0           ';

    qryPcmDet := fCriarQuery(strSQL);
    strAutInc := fRetAutoIncrem('PCMDET', strCodEmp);

    With qryPcmDet Do
    Begin
      Open;
      Insert;

      FieldByName('PCD_NUMPED').AsString   := strNumPed;
      FieldByName('PCD_CODEMP').AsString   := strCodEmp;
      FieldByName('PCD_ESPDOC').AsString   := strEspDoc;
      FieldByName('PCD_CODFOR').AsString   := strCodFor;
      FieldByName('AUTOINCREM').AsString   := strAutInc;
      FieldByName('PCD_CODITE').AsString   := strCodIte;
      FieldByName('PCD_CODUNI').AsString   := strCodUni;

      If dtaDtaEnt = 0 Then
        FieldByName('PCD_DTAENT').Value := Null
      Else
        FieldByName('PCD_DTAENT').AsDateTime := dtaDtaEnt;  // DATA DE ENTREGA

      If tmeHorPed = 0 Then
        FieldByName('PCD_HORPED').Value := Null
      Else
        FieldByName('PCD_HORPED').AsDateTime := tmeHorPed; // HORA DO PEDIDO

      If dtaDtaPed = 0 Then
        FieldByName('PCD_DTAPED').Value := Null
      Else
        FieldByName('PCD_DTAPED').AsDateTime := dtaDtaPed; // DATA DO PEDIDO

      FieldByName('PCD_CONPAG').AsString   := fTiraCaracEspeciais(strCndPag);
      FieldByName('PCD_DESITE').AsString   := strDesIte;
      FieldByName('PCD_QTDITE').AsFloat    := fltQtdIte;
      FieldByName('PCD_UNITAR').AsFloat    := fltUnitar;
      FieldByName('PCD_DESUNI').AsFloat    := fltDesUni;
      FieldByName('PCD_TOTITE').AsFloat    := fltTotIte;
      FieldByName('PCD_PERIPI').AsFloat    := fltPerIpi;
      FieldByName('PCD_TOTIPI').AsFloat    := fltTotIpi;

      FieldByName('PCD_PERSUB').AsFloat    := fltPerSub;
      FieldByName('PCD_TOTSUB').AsFloat    := fltTotSub;
      FieldByName('PCD_TOTDAR').AsFloat    := fltTotDar;

      FieldByName('PCD_PERFCP').AsFloat    := fltPerFCP;
      FieldByName('PCD_SUBFCP').AsFloat    := fltSubFCP;

      FieldByName('PCD_VALFRE').AsFloat    := fltValFre;
      FieldByName('PCD_DESACE').AsFloat    := fltDesAce;

      FieldByName('PCD_QTDBAI').AsFloat    := fltQtdBai;
      FieldByName('PCD_TOTBAI').AsFloat    := fltTotBai;
      FieldByName('PCD_IPIBAI').AsFloat    := fltIpiBai;
      FieldByName('PCD_SUBBAI').AsFloat    := fltSubBai;
      FieldByName('PCD_FREBAI').AsFloat    := fltFreBai;
      FieldByName('PCD_ACEBAI').AsFloat    := fltAceBai;

      FieldByName('PCD_VALICM').AsFloat    := fltValIcm;
      FieldByName('PCD_DESPIS').AsFloat    := fltDesPis;

      FieldByName('PCD_BAIXAD').AsInteger  := intBaixad;
      FieldByName('PCD_DOCORI').AsString   := strDocOri;
      FieldByName('PCD_PEDIMP').AsString   := strPedImp;
      FieldByName('PCD_NUMCTN').AsInteger  := intNumCtn;
      FieldByName('PCD_PEDTXT').AsString   := Trim(strPedTxt);

      If fEmptyStr(strCodAca) Then
      Begin
        FieldByName('PCD_CODACA').Value := Null;
        FieldByName('PCD_EMPACA').Value := Null;
      End
      Else
      Begin
        FieldByName('PCD_CODACA').AsString := strCodAca;
        FieldByName('PCD_EMPACA').AsString := strEmpAca;
      End;

      FieldByName('PCD_PROACA').AsString := IIF(blnProAca, 'S', 'N');

      If Not fEmptyStr(strNumLot) then
        FieldByName('PCD_NUMLOT').AsString   := strNumLot;

      If fltEmbala = 0 Then
        fltEmbala := 1;

      FieldByName('PCD_EMBALA').AsFloat := fltEmbala;
      FieldByName('PCD_ADICAO').asInteger := intAdicao;

      Post;

      pAtualizaSaldoItemPedidoCompra(strAutInc, strCampoSaldoAdd, intDeqTpc);
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaPcmDet]');
      qryPcmDet.Cancel;
    End;
  End;

  FreeAndNil(qryPcmDet);

end;

function fDeletaPedido(strNumPed, strCodEmp, strEspDoc: String): Boolean;
  Var
    strtCampoSaldoSub,
    strSQL: String;
    qryGenGer, qryDados, qryPcmDet: TUniQuery;
    strForFil   : String;
    blnLibPcm   : Boolean;
    intDEQTPC: Integer;
begin
  Result := False;

  If (fPedidoBaixado(strNumPed, strCodEmp, strEspDoc)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse pedido já sofreu baixas, portanto não será permitido o cancelamento!', ['&O k']);
    Exit;
  End;

  qryDados  := Nil;
  qryGenGer := Nil;
  qryPcmDet := Nil;

  Try
    strForFil := fRetForFilialTodos;
    blnLibPcm := fCfgSis('LIBPCM', varBoolean);
    intDEQTPC := fCfgSis('DEQTPC', varInteger);

    qryDados  := fCriaQuery;
    qryGenGer := fCriaQuery;
    qryPcmDet := fCriaQuery;

    {***********************************************}
    {* GRAVANDO O DEL_PCMDET                       *}
    {********************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC ';

    With qryPcmDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;
    End;

    strtCampoSaldoSub := fRetCampoAtualizaSaldoPedidoCompra('',
                                                            strNumPed,
                                                            strCodEmp,
                                                            blnLibPcm,
                                                            strForFil);

    qryPcmDet.First;

    While Not qryPcmDet.Eof Do
    Begin
      pEstornaSaldoItemPedidoCompra(qryPcmDet.FieldByName('AUTOINCREM').AsString, strtCampoSaldoSub, intDEQTPC);

      fVerificaIntegridade('', 'PCMDET', qryPcmDet);
      qryPcmDet.Next;
    End;

    {***********************************************}
    {* GRAVANDO O DEL_PCMGER                       *}
    {********************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC ';

    With qryDados Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      Open;
    End;

    fVerificaIntegridade('', 'PCMGER', qryDados);

    If (qryDados.FieldByName('PCG_REPOR_').AsString = 'S') And
       (qryDados.FieldByName('PCG_DTAPED').AsDateTime = Date) Then
    Begin
      pAlteraPasCmp('PASCMP_PRODUTOS_SINTETICO', qryPcmDet);
      pAlteraPasCmp('PASCMP_PRODUTOS_ANALITICO', qryPcmDet);
    End;

    {***********************************************}
    {* APAGANDO O PEDIDO DE COMPRA                 *}
    {********************************************LU*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCG_ESPDOC = :ESPDOC ';

    Try
      fStartTransaction;

      With qryGenGer Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMPED').AsString := strNumPed;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESPDOC').AsString := strEspDoc;

        If fLimpaVinculoComRequisicoes(strNumPed,  strCodEmp,  strEspDoc) Then
          ExecSQL;
        Close;
      End;

      fCommit;
      Result := True;

      if Result then
        TManutencaoEquipamentoInterno.fRemoverVinculoSolicitacao(strNumPed, strEspDoc);
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro('Erro ao cancelar pedido: ' + E.Message, '[ fDeletaPedido ]');
      End;
    End;

  Finally
    FreeAndNil(qryGenGer);
    FreeAndNil(qryDados);
    FreeAndNil(qryPcmDet);
  End;
end;


function fLimpaVinculoComRequisicoes(strNumPed, strCodEmp, strEspDoc: String): Boolean;
  var
    qryUpdate: TUniQuery;
    qryPcmDet: TUniQuery;
    qryMovRcd: TUniQuery;
Begin
  Result := True;
  qryUpdate := fCriaQuery;
  qryPcmDet := fCriaQuery;
  qryMovRcd := fCriaQuery;

  Try
    Try
      qryPcmDet.SQL.Add('SELECT AUTOINCREM FROM PCMDET');
      qryPcmDet.SQL.Add(' WHERE PCD_NUMPED = :NUMPED');
      qryPcmDet.SQL.Add('   AND PCD_CODEMP = :CODEMP');
      qryPcmDet.SQL.Add('   AND PCD_ESPDOC = :ESPDOC');

      qryPcmDet.ParamByName('NUMPED').AsString := strNumPed;
      qryPcmDet.ParamByName('CODEMP').AsString := strCodEmp;
      qryPcmDet.ParamByName('ESPDOC').AsString := strEspDoc;

      qryPcmDet.Open();
      qryMovRcd.SQL.Add('SELECT AUTOINCREM FROM MOVRCD WHERE RCD_SEQPCD = :SEQPCD');

      While (Not qryPcmDet.Eof) Do
      Begin
        qryMovRcd.Close();
        qryMovRcd.ParamByName('SEQPCD').AsString := qryPcmDet.FieldByName('AUTOINCREM').AsString;
        qryMovRcd.Open();

        While (Not qryMovRcd.Eof) Do
        Begin
          qryUpdate.SQL.Clear();
          qryUpdate.SQL.Add('UPDATE MOVRCD SET RCD_SEQPCD = NULL');
          qryUpdate.SQL.Add(' WHERE AUTOINCREM = :AUTINC');
          qryUpdate.SQL.Add('   AND RCD_SEQPCD = :SEQPCD');
          qryUpdate.ParamByName('AUTINC').AsString := qryMovRcd.FieldByName('AUTOINCREM').AsString;
          qryUpdate.ParamByName('SEQPCD').AsString := qryPcmDet.FieldByName('AUTOINCREM').AsString;
          qryUpdate.ExecSQL;

          qryMovRcd.Next();
        End;

        qryPcmDet.Next();
      End;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[untPcmGer.fLimpaVinculoComRequisicoes]');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qryPcmDet);
    FreeAndNil(qryMovRcd);
  End;
End;


function fUsaConferenciaParcial(blnNotEle: Boolean): Boolean;
begin
  Result := (fCfgSis('USACON', varBoolean)) And           //USA CONFERENCIA
            (fCfgSis('PERCPA', varBoolean)) And           //CONFERENCIA PARCIAL
            ((fCfgSis('CONFME') = CONFERENCIA_PEDIDO) Or  //CONFERENCIA POR PEDIDO
             ((fCfgSis('CONFME') = '3') And (Not blnNotEle)));
end;

Procedure pExcluiContagemAnalitica(strAutInc: String);
  Var
    qryGen,
    qryDelete: TUniQuery;
Begin
  qryGen := fCriaQuery;
  qryDelete := fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   CON_SEQGER ');
    qryGen.SQL.Add(' FROM ');
    qryGen.SQL.Add('   PCDCON ');
    qryGen.SQL.Add(' WHERE CON_SEQDET = :AUTINC ');
    qryGen.ParamByName('AUTINC').AsString := strAutInc;
    qryGen.Open;

    If Not qryGen.IsEmpty Then
    Begin
      qryGen.First;
      While Not qryGen.Eof Do
      Begin
         qryDelete.Close;
         qryDelete.SQL.Clear;
         qryDelete.SQL.Add(' DELETE FROM PCMCON WHERE AUTOINCREM = :AUTINC_PCDCON ');
         qryDelete.ParamByName('AUTINC_PCDCON').AsString := qryGen.FieldByName('CON_SEQGER').AsString;
         qryDelete.ExecSQL;

         qryGen.Next;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryDelete);
  End
End;

function fAtualizaDadosPcmDet(fltQtdIte,
                              fltUnitar: Double;
                              strNumPed,
                              strCodEmp,
                              strSeqPcd,
                              strForEle,
                              strCnvEmb: String;
                              blnNotEle,
                              blnSaldoPendente,
                              blnLibPcm: Boolean;
                              strForFil: String;
                              intDEQTPC: Integer): Boolean;
  Var
    strCampoSaldo,
    strSQL: String;
    qryGenDet: TUniQuery;
begin

  Result := True;
  qryGenDet := fCriaQuery;

  Try
    strSQL := '';


    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMDET D ';

    strSQL := strSQL + 'SET ';

    strSQL := strSQL + '  PCD_VALFRE = PCD_VALFRE + (@FREUNI:=(PCD_VALFRE / ( PCD_QTDITE - PCD_QTDBAI)))* 0, ';
    strSQL := strSQL + '  PCD_DESACE = PCD_DESACE + (@ACEUNI:=(PCD_DESACE / ( PCD_QTDITE - PCD_QTDBAI)))* 0, ';

    If strCnvEmb <> 'N' Then
    Begin
      strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI + (:QTDBAI / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) >= PCD_QTDITE, PCD_QTDITE, PCD_QTDBAI + (:QTDBAI / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA))), ';
      strSQL := strSQL + '  PCD_TOTBAI = (IF(PCD_QTDBAI >= PCD_QTDITE, PCD_QTDITE, PCD_QTDBAI) * (:UNITAR * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA))), ';
    End

    Else
    Begin
      strSQL := strSQL + '  PCD_QTDBAI = IF(PCD_QTDBAI + :QTDBAI >= PCD_QTDITE, PCD_QTDITE, PCD_QTDBAI + :QTDBAI), ';
      strSQL := strSQL + '  PCD_TOTBAI = (IF(PCD_QTDBAI >= PCD_QTDITE, PCD_QTDITE, PCD_QTDBAI) * :UNITAR), ';
    End;

    strSQL := strSQL + '  PCD_FREBAI = ROUND(@FREUNI * PCD_QTDBAI, 2), ';
    strSQL := strSQL + '  PCD_ACEBAI = ROUND(@ACEUNI * PCD_QTDBAI, 2), ';

    strSQL := strSQL + '  PCD_VALFRE = ROUND(@FREUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';
    strSQL := strSQL + '  PCD_DESACE = ROUND(@ACEUNI * (PCD_QTDITE - PCD_QTDBAI), 2), ';

    strSQL := strSQL + '  PCD_IPIBAI = (PCD_TOTIPI * (IF(PCD_QTDBAI >= PCD_QTDITE, 100, PCD_QTDBAI / PCD_QTDITE * 100) / 100)), ';
    strSQL := strSQL + '  PCD_SUBBAI = (PCD_TOTSUB * (IF(PCD_QTDBAI >= PCD_QTDITE, 100, PCD_QTDBAI / PCD_QTDITE * 100) / 100)), ';
    strSQL := strSQL + '  PCD_DARBAI = (PCD_TOTDAR * (IF(PCD_QTDBAI >= PCD_QTDITE, 100, PCD_QTDBAI / PCD_QTDITE * 100) / 100)), ';
    strSQL := strSQL + '  PCD_FCPBAI = (PCD_TOTSUB * (IF(PCD_QTDBAI >= PCD_QTDITE, 100, PCD_QTDBAI / PCD_QTDITE * 100) / 100)) * PCD_PERFCP / 100  ';

    If fUsaConferenciaParcial(blnNotEle) Then
    Begin                           // QTDBAI JA FOI CONVETIDO PRA UNIDADE DE VENDA
      strSQL := strSQL + '  , PCD_QTDCON = IF(:QTDBAI >= PCD_QTDCON, 0, PCD_QTDCON - :QTDBAI) ';
    End;

    If fEmptyStr(strNumPed) Then
    Begin
      strSQL := strSQL + ', PCD_BAIXAD = IF(PCD_QTDBAI >= PCD_QTDITE, 1,  IFNULL(PCD_BAIXAD, 0)) ';
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND        ';
    strSQL := strSQL + '  D.AUTOINCREM = :AUTINC    ';

    If Not fEmptyStr(strNumPed) Then
    Begin
      strSQL := strSQL + '  AND PCD_NUMPED = :NUMPED  ';
      strSQL := strSQL + '  AND PCD_CODEMP = :CODEMP  ';
    End;

    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);

    qryGenDet.ParamByName('QTDBAI').AsFloat   := fltQtdIte;
    qryGenDet.ParamByName('UNITAR').AsFloat   := fltUnitar;

    If Not fEmptyStr(strNumPed) Then
    Begin
      qryGenDet.ParamByName('NUMPED').AsString  := strNumPed;
      qryGenDet.ParamByName('CODEMP').AsString  := strCodEmp;
    End;

    qryGenDet.ParamByName('AUTINC').AsString  := strSeqPcd;

    strCampoSaldo := fRetCampoAtualizaSaldoPedidoCompra('',
                                                        strNumPed,
                                                        strCodEmp,
                                                        blnLibPcm,
                                                        strForFil);

    pEstornaSaldoItemPedidoCompra(strSeqPcd, strCampoSaldo, intDEQTPC);

    qryGenDet.ExecSQL;

    If blnSaldoPendente Then
      pAtualizaSaldoItemPedidoCompra(strSeqPcd, strCampoSaldo, intDEQTPC);

    qryGenDet.Close;

    If fUsaConferenciaParcial(blnNotEle) Then
      pExcluiContagemAnalitica(strSeqPcd);

    If Not fEmptyStr(strForEle) And (Not(blnAtualizaForPed)) Then
      Result := fAtualizaFornecedorPedido(strNumPed, strCodEmp, strForEle); //blnAtualizaForcedorPedido

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fAtualizaDadosPcmDet]');
    End;

  End;

  FreeAndNil(qryGenDet);

end;

function fBaixaPcmDet(strNumPed, strCodEmp, strNumDoc,strEspDoc, strSerie_: String; blnSaldoPendente: Boolean): Boolean;
  Var
    strSQL: String;
    qryGenDet: TUniQuery;
begin

  Try
    Result := True;
    qryGenDet := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  PCD_BAIXAD = :BAIXAD, ';
    strSQL := strSQL + '  PCD_DOCEMI = IF(IFNULL(PCD_DOCEMI,"") = "", :NUMDOC, PCD_DOCEMI), ';
    strSQL := strSQL + '  PCD_SEREMI = IF(IFNULL(PCD_SEREMI,"") = "", :SEREMI, PCD_SEREMI), ';
    strSQL := strSQL + '  PCD_ESPEMI = IF(IFNULL(PCD_ESPEMI,"") = "", :ESPDOC, PCD_ESPEMI)  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP ';

    //Caso for entrada de pedido de transferencia de refuro e gerar o
    //endereçamento nao deve baixar o pedido, pois o pedido é baixado no endereçamento
    If (fCfgSis('REFENT', varBoolean) Or
       (fCfgSis('GARMAT', varBoolean) And fCfgSis('REFENT', varBoolean, fCfgSis('EMPGAR', varString)))) And
       (fCfgSis('USACON', varBoolean) And (Pos(fCfgSis('CONFME'), '1_3_') > 0)) Then
      strSQL := strSQL + ' AND (SELECT COUNT(0) FROM SEQGAR WHERE SEQ_PCDREF = PCMDET.AUTOINCREM) = 0 ';

    Try

      If blnSaldoPendente Then
      Begin
        strSQL := strSQL + '  AND PCD_QTDBAI >= PCD_QTDITE ';
      End;

      qryGenDet.Close;
      qryGenDet.SQL.Clear;
      qryGenDet.SQL.Add(strSQL);

      qryGenDet.ParamByName('BAIXAD').AsInteger := 1;
      qryGenDet.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryGenDet.ParamByName('SEREMI').AsString  := strSerie_;
      qryGenDet.ParamByName('ESPDOC').AsString  := strEspDoc;

      qryGenDet.ParamByName('NUMPED').AsString  := strNumPed;
      qryGenDet.ParamByName('CODEMP').AsString  := strCodEmp;

      qryGenDet.ExecSQL;

      qryGenDet.Close;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fBaixaPcmDet]');
      End;
    End;

  Finally
    FreeAndNil(qryGenDet);
  End;

end;

function fPedidoTemItensPendentesConferidos(strNumPed, strCodEmp: String): Boolean;
  Var
    qryPcmdet: TUniQuery;
Begin
  qryPcmdet := fCriaQuery(Nil);
  With qryPcmdet, SQL Do
  Begin
    Clear;
    Add('SELECT');
    Add('  COUNT(*) AS QTDCON');
    Add('FROM');
    Add('  PCMDET');
    Add('WHERE');
    Add('  PCD_NUMPED = :NUMPED AND');
    Add('  PCD_CODEMP = :CODEMP AND');
    Add('  PCD_ESPDOC = "PD"    AND');
    Add('  PCD_QTDCON > 0          ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result := FieldByName('QTDCON').AsInteger > 0;

    Close;

  End;
  FreeAndNil(qryPcmdet);
End;

function fBaixaPcmGer(blnNotEle: Boolean; strNumPed, strCodEmp, strNumDoc, strEspDoc: String; blnSempreBaixa: Boolean = False): Boolean;
  Var
    strSQL         : String;
    qryGenDet      : TUniQuery;
    intQtdAberto   : Integer;
    fltValFrePcmDet: Double;
    fltDesAcePcmDet: Double;
    fltTotIpiPcmDet: Double;
    fltTotSubPcmDet: Double;
    fltTotDarPcmDet: Double;
    fltSubFCPPcmDet: Double;
    fltTotItePcmDet: Double;
    fltTotIcmPcmDet: Double;
    fltTotPisPcmDet: Double;
    fltValCbsPcmDet: Double;
    fltValIbsPcmDet: Double;
    fltVal_IsPcmDet: Double;
    blnZonaFranca  : Boolean;
    blnBAIXAD: Boolean;
begin
  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  Try
    Result := True;
    qryGenDet := fCriaQuery;

    {*******************************************}
    {* PEGA QUANTIDADE DE PEDIDOS NÃO BAIXADOS *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCD_BAIXAD = 0 ';

    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);

    qryGenDet.ParamByName('NUMPED').AsString := strNumPed;
    qryGenDet.ParamByName('CODEMP').AsString := strCodEmp;

    qryGenDet.Open;
    intQtdAberto := qryGenDet.FieldByName('QTD').AsInteger;
    qryGenDet.Close;

    {*****************************************}
    {* CALCULA TOTAIS PARA ATUALIZAR PCMGER  *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    strSQL := strSQL + ' SUM(IF(PCD_BAIXAD = 0, PCD_VALFRE, 0)) AS VALFRE, ';
    strSQL := strSQL + ' SUM(IF(PCD_BAIXAD = 0, PCD_DESACE, 0)) AS DESACE, ';

    strSQL := strSQL + ' SUM( ((PCD_QTDITE - PCD_QTDBAI)  * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    strSQL := strSQL + '       )) ) AS TOTITE, ';

    strSQL := strSQL + ' SUM( (((PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    strSQL := strSQL + '     )) * ( PCD_PERIPI/100)) ) AS TOTIPI, ';

    strSQL := strSQL + ' SUM(PCD_TOTSUB - PCD_SUBBAI) AS TOTSUB,  ';
    strSQL := strSQL + ' SUM(PCD_TOTDAR - IFNULL(PCD_DARBAI, 0)) AS TOTDAR,  ';

    strSQL := strSQL + ' SUM(PCD_SUBFCP - PCD_FCPBAI) AS SUBFCP,  ';

    strSQL := strSQL + ' SUM( (PCD_VALICM / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS TOTICM, ';
    strSQL := strSQL + ' SUM( (PCD_DESPIS / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS TOTPIS, ';

    strSQL := strSQL + ' SUM( (IFNULL(PCD_VALCBS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VALCBS, ';
    strSQL := strSQL + ' SUM( (IFNULL(PCD_VALIBS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VALIBS, ';
    strSQL := strSQL + ' SUM( (IFNULL(PCD_VAL_IS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VAL_IS  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  (PCD_BAIXAD = 0 OR ';
    strSQL := strSQL + '  (PCD_QTDITE - PCD_QTDBAI) > 0) ';

    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);

    qryGenDet.ParamByName('NUMPED').AsString := strNumPed;
    qryGenDet.ParamByName('CODEMP').AsString := strCodEmp;

    qryGenDet.Open;
    fltTotIpiPcmDet := qryGenDet.FieldByName('TOTIPI').AsFloat;
    fltTotSubPcmDet := qryGenDet.FieldByName('TOTSUB').AsFloat;
    fltTotDarPcmDet := qryGenDet.FieldByName('TOTDAR').AsFloat;
    fltSubFCPPcmDet := qryGenDet.FieldByName('SUBFCP').AsFloat;
    fltTotItePcmDet := qryGenDet.FieldByName('TOTITE').AsFloat;
    fltValFrePcmDet := qryGenDet.FieldByName('VALFRE').AsFloat;
    fltDesAcePcmDet := qryGenDet.FieldByName('DESACE').AsFloat;
    fltTotIcmPcmDet := qryGenDet.FieldByName('TOTICM').AsFloat;
    fltTotPisPcmDet := qryGenDet.FieldByName('TOTPIS').AsFloat;
    fltValCbsPcmDet := RoundTo(qryGenDet.FieldByName('VALCBS').AsFloat, -2);
    fltValIbsPcmDet := RoundTo(qryGenDet.FieldByName('VALIBS').AsFloat, -2);
    fltVal_IsPcmDet := RoundTo(qryGenDet.FieldByName('VAL_IS').AsFloat, -2);

    qryGenDet.Close;

    {*****************************************}
    {* ATUALIZA PCMGER                       *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  PCMGER ';
    strSQL := strSQL + 'SET ';

    If fUsaConferenciaParcial(blnNotEle) And
       (Not fPedidoTemItensPendentesConferidos(strNumPed, strCodEmp)) Then
    Begin
      strSQL := strSQL + ' PCG_DTALIB = IF(:BAIXAD = 1, PCG_DTALIB, NULL), ';
      strSQL := strSQL + ' PCG_HORLIB = IF(:BAIXAD = 1, PCG_HORLIB, NULL), ';
      strSQL := strSQL + ' PCG_OPELIB = IF(:BAIXAD = 1, PCG_OPELIB, NULL), ';
      strSQL := strSQL + ' PCG_LIBERA = IF(:BAIXAD = 1, PCG_LIBERA, 0),    ';
    End;

    strSQL := strSQL + '  PCG_VALFRE = :VALFRE, ';
    strSQL := strSQL + '  PCG_DESACE = :DESACE, ';

    strSQL := strSQL + '  PCG_TOTIPI = :IPIATU, ';
    strSQL := strSQL + '  PCG_TOTSUB = :SUBATU, ';
    strSQL := strSQL + '  PCG_TOTDAR = :DARATU, ';
    strSQL := strSQL + '  PCG_SUBFCP = :FCPATU, ';
    strSQL := strSQL + '  PCG_TOTITE = :ITEATU, ';

    strSQL := strSQL + '  PCG_VALICM = :TOTICM, ';
    strSQL := strSQL + '  PCG_DESPIS = :TOTPIS, ';

    strSQL := strSQL + '  PCG_VALCBS = :VALCBS, ';
    strSQL := strSQL + '  PCG_VALIBS = :VALIBS, ';
    strSQL := strSQL + '  PCG_VAL_IS = :VAL_IS, ';

    strSQL := strSQL + '  PCG_TOTGER = (PCG_TOTIPI + PCG_TOTSUB + PCG_TOTITE + PCG_VALFRE + PCG_DESACE ' + fSQLSomaImpostosReforma('PCG');

    If blnZonaFranca Then
      strSQL := strSQL + '  - :TOTICM - :TOTPIS ';

    strSQL := strSQL + ' ), ';

    strSQL := strSQL + '  PCG_DOCEMI = :NUMDOC, ';
    strSQL := strSQL + '  PCG_ESPEMI = :ESPDOC, ';
    strSQL := strSQL + '  PCG_BAIXAD = :BAIXAD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCG_ESPDOC = "PD"    AND ';
    strSQL := strSQL + '  PCG_CODEMP = :CODEMP ';


    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);

    qryGenDet.ParamByName('IPIATU').AsFloat := fltTotIpiPcmDet;
    qryGenDet.ParamByName('SUBATU').AsFloat := fltTotSubPcmDet;
    qryGenDet.ParamByName('DARATU').AsFloat := fltTotDarPcmDet;
    qryGenDet.ParamByName('FCPATU').AsFloat := fltSubFCPPcmDet;
    qryGenDet.ParamByName('ITEATU').AsFloat := fltTotItePcmDet;

    qryGenDet.ParamByName('VALFRE').AsFloat := fltValFrePcmDet;
    qryGenDet.ParamByName('DESACE').AsFloat := fltDesAcePcmDet;

    qryGenDet.ParamByName('VALCBS').AsFloat := fltValCbsPcmDet;
    qryGenDet.ParamByName('VALIBS').AsFloat := fltValIbsPcmDet;
    qryGenDet.ParamByName('VAL_IS').AsFloat := fltVal_IsPcmDet;

    If blnZonaFranca Then
    Begin
      qryGenDet.ParamByName('TOTICM').AsFloat := fltTotIcmPcmDet;
      qryGenDet.ParamByName('TOTPIS').AsFloat := fltTotPisPcmDet;
    End Else
    Begin
      qryGenDet.ParamByName('TOTICM').AsFloat := 0;
      qryGenDet.ParamByName('TOTPIS').AsFloat := 0;
    End;

    qryGenDet.ParamByName('NUMPED').AsString := strNumPed;
    qryGenDet.ParamByName('CODEMP').AsString := strCodEmp;

    qryGenDet.ParamByName('NUMDOC').AsString  := strNumDoc;
    qryGenDet.ParamByName('ESPDOC').AsString  := strEspDoc;

    If (intQtdAberto > 0) And (Not blnSempreBaixa) Then
    Begin
      qryGenDet.ParamByName('BAIXAD').AsInteger := 0;
      blnBAIXAD := False;
    End
    Else
    Begin
      qryGenDet.ParamByName('BAIXAD').AsInteger := 1;
      blnBAIXAD := True;
    End;

    qryGenDet.ExecSQL;
    qryGenDet.Close;

    TDuplicatasPedidoCompra.pAtualizaBaixaParcial(strNumPed, strCodEmp, 'PD');

    If blnBAIXAD and fCfgSis('URMEIE', varBoolean) Then
      TManutencaoEquipamentoInterno.pAjustaStatusAutomatica(TManutencaoEquipamentoInterno.fRetornaSolicitacaoVinculada(strNumPed, 'PD'));

    Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fBaixaPcmGer]');
      Result := False;

    End;
  End;

  FreeAndNil(qryGenDet);

end;

Function fCalculaComissaoDevolucao(strNumAde,
                                   strAutVen,
                                   strTabDev,
                                    strCodIte,
                                    strNumDoc,
                                    strEspDoc,
                                    strCodEmp: string;
                                    fltTotIte,
                                    fltQtdIte: Double;
                                    Var strTabela: String;
                                    Var strCodVen,
                                    strCodVe2,
                                    strCodRep,
                                    strTabPre: String;
                                    Var fltPerCom,
                                    fltTotCom,
                                    fltTotCo2,
                                    fltPerRep,
                                    fltTotExt,
                                    fltVlrCom,
                                    fltTotCus,
                                    fltTotCu2,
                                    fltOutVal,
                                    fltIcmSai,
                                    fltImpFed,
                                    fltDesOpe,
                                    fltImpUlt,
                                    fltTotUlt,
                                    fltVal_RT,
                                    fltUniOri: Double ): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    fltTaxRep: Double;
    fltTot_RT: Double;

  procedure pOpenQuery(const blnVerAdeDet : Boolean = False);
    Var
      blnBuscarAdeDet : Boolean;
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT               ';
    strSQL := strSQL + '  D.DET_CODVEN,      ';
    strSQL := strSQL + '  D.DET_CODVE2,      ';
    strSQL := strSQL + '  D.DET_CODREP,      ';
    strSQL := strSQL + '  D.DET_TABPRE,      ';
    strSQL := strSQL + '  D.DET_TOTITE,      ';
    strSQL := strSQL + '  D.DET_TOTCO2,      ';
    strSQL := strSQL + '  D.DET_PERREP,      ';
    strSQL := strSQL + '  D.DET_COMREP,      ';
    strSQL := strSQL + '  D.DET_DESESP,      ';
    strSQL := strSQL + '  D.DET_PERCOM,      ';
    strSQL := strSQL + '  D.DET_UNIORI,      ';
    strSQL := strSQL + '  T.DET_VAL_RT,      ';

    strSQL := strSQL + '  T.DET_IMPULT / D.DET_QTDITE AS IMPULT,  ';
    strSQL := strSQL + '  T.DET_TOTULT / D.DET_QTDITE AS TOTULT,      ';

    strSQL := strSQL + '  D.DET_TOTCUS / D.DET_QTDITE AS UNICUS, ';
    strSQL := strSQL + '  D.DET_TOTCU2 / D.DET_QTDITE AS UNICU2, ';
    strSQL := strSQL + ' (T.DET_OUTVAL/D.DET_QTDITE)  AS OUTVAL, ';
    strSQL := strSQL + ' (T.DET_ICMSAI/(D.DET_TOTITE - D.DET_DESESP) * 100) AS ICMSAI, ';
    strSQL := strSQL + ' (T.DET_IMPFED/(D.DET_TOTITE - D.DET_DESESP) * 100) AS IMPFED, ';
    strSQL := strSQL + ' (T.DET_DESOPE/(D.DET_TOTITE - D.DET_DESESP) * 100) AS DESOPE  ';
    strSQL := strSQL + 'FROM               ';

    blnBuscarAdeDet := False;
    If (blnVerAdeDet)  And (Not fEmptyStr(strAutVen)) And (Not fEmptyStr(strCodIte)) Then
    Begin
      strSQL := strSQL + ' ADEDET E ';
      strSQL := strSQL + ' JOIN ' + strTabela + ' D ON D.AUTOINCREM = E.DET_SEQORI ';
      strSQL := strSQL + '                         AND D.DET_NUMDOC = E.DET_NUMDOC ';
      strSQL := strSQL + '                         AND D.DET_ESPDOC = E.DET_ESPDOC ';
      strSQL := strSQL + '                         AND D.DET_CODEMP = E.DET_CODEMP ';
      strSQL := strSQL + '                         AND D.DET_SERIE_ = E.DET_SERIE_ ';
      strSQL := strSQL + '                         AND D.DET_CODITE = E.DET_CODITE ';
      strSQL := strSQL + ' LEFT JOIN ' + fRetNomTabMovTri(strTabela) + ' T ON T.DET_SEQGER = D.AUTOINCREM ';
      blnBuscarAdeDet := True;
    End
    Else
    Begin
      strSQL := strSQL + '  ' + strTabela + ' D ';
      strSQL := strSQL + ' LEFT JOIN ' + fRetNomTabMovTri(strTabela) + ' T ON T.DET_SEQGER = D.AUTOINCREM ';
    End;

    strSQL := strSQL + 'WHERE               ';

    If (blnBuscarAdeDet) Then
      strSQL := strSQL + '  E.AUTOINCREM = :AUTVEN AND '
    Else
    Begin
      If Not fEmptyStr(strAutVen) Then
        strSQL := strSQL + '  D.AUTOINCREM = :AUTVEN AND ';
    End;

    If Not fEmptyStr(strCodIte) Then
      strSQL := strSQL + '  D.DET_CODITE = :CODITE AND ';

    strSQL := strSQL + '  D.DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  D.DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP      ';

    With qryGen Do
    Begin
      Close;
      Sql.Clear;
      Sql.Add(strSQL);

      If Not fEmptyStr(strAutVen) Then
        ParamByName('AUTVEN').AsString := strAutVen;

      If Not fEmptyStr(strCodIte) Then
        ParamByName('CODITE').AsString := strCodIte;

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;
    End;
  end;

Begin
  strCodVe2 := '';
  fltPerCom := 0;
  fltPerRep := 0;
  fltTotCom := 0;
  fltTotCo2 := 0;
  fltTaxRep := 0;
  fltTotExt := 0;
  fltImpUlt := 0;
  fltTotUlt := 0;
  fltVal_RT := 0;
  fltTot_RT := 0;
  strTabPre := '';

  Result := False;

  If (Not fEmptyStr(strAutVen)) Or (Not fEmptyStr(strCodIte)) Then
  Begin
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      If strTabDev <>'' Then
      Begin
        strTabela := strTabDev;
        If (Not fEmptyStr(strNumAde)) Then
        Begin
          pOpenQuery(True);
          If IsEmpty Then
            pOpenQuery;
        End
        Else
          pOpenQuery;
      End
      Else
      Begin

        strTabela := 'MOVDET';
        pOpenQuery;

        If IsEmpty Then
        Begin
          strTabela := 'NOTDET';
          pOpenQuery;
        End;
      End;

      If Not IsEmpty Then
      Begin
        Result    := True;

        strCodVen := FieldByName('DET_CODVEN').AsString;
        strCodRep := FieldByName('DET_CODREP').AsString;
        strCodVe2 := FieldByName('DET_CODVE2').AsString;
        strTabPre := FieldByName('DET_TABPRE').AsString;

        fltPerCom := FieldByName('DET_PERCOM').AsFloat;
        fltPerRep := FieldByName('DET_PERREP').AsFloat;

        fltVal_RT := FieldByName('DET_VAL_RT').AsFloat;
        fltTot_RT := fltQtdIte * fltVal_RT;

        fltUniOri := FieldByName('DET_UNIORI').AsFloat;

        {***************************************}
        {* CALCULA TAXA DO REPRESENTANTE       *}
        {************************************LA*}
        If (fltPerCom * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat - fltTot_RT)/100) > 0 Then
          fltTaxRep := FieldByName('DET_TOTCO2').AsFloat / (fltPerCom * (FieldByName('DET_TOTITE').AsFloat - FieldByName('DET_DESESP').AsFloat - fltTot_RT) / 100)
        Else
          fltTaxRep := 0;

        fltTotCus := RoundTo(fltQtdIte * FieldByName('UNICUS').AsFloat, -2);
        fltTotCu2 := RoundTo(fltQtdIte * FieldByName('UNICU2').AsFloat, -2);
        fltOutVal := FieldByName('OUTVAL').AsFloat;
        fltIcmSai := FieldByName('ICMSAI').AsFloat;
        fltImpFed := FieldByName('IMPFED').AsFloat;
        fltDesOpe := FieldByName('DESOPE').AsFloat;

        fltImpUlt := RoundTo(fltQtdIte * FieldByName('IMPULT').AsFloat, -2);
        fltTotUlt := RoundTo(fltQtdIte * FieldByName('TOTULT').AsFloat, -2);
      End;

    End;

    FreeAndNil(qryGen);

    If Not fEmptyStr(strCodVen) Then
    Begin
      fltTotCom := (fltPerCom * (fltTotIte - fltTot_RT)) / 100;
      fltVlrCom := fltTotCom;
    End;

    If (Not fEmptyStr(strCodVe2)) And (fltTaxRep > 0) Then
    Begin
      fltTotCo2 := fltTotCom * fltTaxRep;
      fltTotCom := fltTotCom - fltTotCo2;
    End;

    If Not fEmptyStr(strCodRep) Then
    Begin
      fltTotExt := (fltPerRep * (fltTotIte - fltTot_RT)) / 100;
    End;

  End;
End;

procedure pRecalculaPrecos(Var recPrecos: TarrPrecos;
                           Var fltPreCus: Double;
                           Var blnAltPre: Boolean;
                           var cpcParams: TParCalculaPrecoCusto;
                               fltPreCom: Double;
                               qryConIte,
                               qryEntMer: TDataSet;
                               blnAtuFor: Boolean;
                               blnAtpVmb: TArrAtpVmb);
  Var
    fltMargem1,
    fltPreVen1,
    fltPrvPad: Double;
    intTabPre: Integer;
    objFatPre: TFatorPreco;
Begin
  If fCfgSis('FATPRE', varBoolean) Then
    objFatPre := TFatorPreco.Create
  Else
    objFatPre := Nil;

  {**********************************}
  {* CALCULA PREÇOS DE CUSTO        *}
  {*******************************JB*}
  With qryEntMer Do
  Begin
    With cpcParams Do
    Begin
      curPreCom := fltPreCom;
      curDesF01 := FieldByName('ENT_DESF01').AsFloat;
      curDesF02 := FieldByName('ENT_DESF02').AsFloat;
      curDesF03 := FieldByName('ENT_DESF03').AsFloat;
      curDesF04 := FieldByName('ENT_DESF04').AsFloat;
      curDesF05 := FieldByName('ENT_DESF05').AsFloat;
      curDesF06 := FieldByName('ENT_DESF06').AsFloat;
      curICMSEnt:= FieldByName('ENT_ICMENT').AsFloat;
      curIPIEnt := FieldByName('ENT_IPIENT').AsFloat;
      curFrete  := FieldByName('ENT_FREENT').AsFloat;
      curValFre := FieldByName('ENT_FREITE').AsFloat;
      curAcrFin := FieldByName('ENT_ACRFIN').AsFloat;
      curSubsti := FieldByName('ENT_SUBSTI').AsFloat;
      curDesAdb := FieldByName('ENT_DESADB').AsFloat;
      curSubFed := FieldByName('ENT_SUBFED').AsFloat;
      if Assigned(qryEntMer.FindField('ENT_FRERPA')) then
        curRpaFre := FieldByName('ENT_FRERPA').AsFloat
      else
        curRpaFre := 0;

      if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
      begin
        curTCIFCu := FieldByName('ENT_TCIFCU').AsFloat;
        curTSCust := FieldByName('ENT_TSCUST').AsFloat;
        curDePiCo := FieldByName('ENT_DEPICO').AsFloat;
        curDeICMS := FieldByName('ENT_DEICMS').AsFloat;
        curFatReg := FieldByName('ENT_FATREG').AsFloat;
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
    fltPreCus := cpcParams.fCalculaPrecoCusto();

    IF Assigned(qryConIte)  Then
      fltMargem1 := qryConIte.FieldByName('ITE_MARBR1').AsFloat
    Else
      fltMargem1 := qryEntMer.FieldByName('ENT_MARBR1').AsFloat;
    fltPrvPad := fCalculaPrecoVenda(1,
                                    fltPreCus + FieldByName('ENT_OUTVAL').AsFloat,
                                    0,
                                    fltMargem1,
                                    FieldByName('ENT_ICMSAI').AsFloat,
                                    FieldByName('ENT_IMPFED').AsFloat,
                                    FieldByName('ENT_DESOPE').AsFloat,
                                    recPrecos[1].fltComiss);
    IF Assigned(qryConIte)  Then
      fltPreVen1 := qryConIte.FieldByName('ITE_PREVE1').AsFloat
    Else
      fltPreVen1 := qryEntMer.FieldByName('ENT_PREVE1').AsFloat;

    recPrecos[1].blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco := False;

    If (fltPrvPad >= fltPreVen1) Or
       (FieldByName('ENT_RPRENT').AsString = 'S') Or
       (blnAtuFor And (FieldByName('ENT_RPRENT').AsString = 'S')) Then
    Begin

      For intTabPre := 1 To length(recPrecos) Do
      Begin
        If blnAtpVmb[intTabPre] Then
        Begin

          If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabPre))))) Or (intTabPre = 1) Then
          Begin
            recPrecos[intTabPre].fltMarBru := FieldByName('ENT_MARBR' + IntToStr(intTabPre)).AsFloat;

            {*******************************************}
            {* CALCULA OS NOVOS PREÇOS DE VENDA        *}
            {****************************************MV*}
            recPrecos[intTabPre].fltPreVen := fCalculaPrecoVenda(1,
                                                                 fltPreCus + FieldByName('ENT_OUTVAL').AsFloat,
                                                                 0,
                                                                 recPrecos[intTabPre].fltMarBru,
                                                                 FieldByName('ENT_ICMSAI').AsFloat,
                                                                 FieldByName('ENT_IMPFED').AsFloat,
                                                                 FieldByName('ENT_DESOPE').AsFloat,
                                                                 recPrecos[intTabPre].fltComiss);
          End Else
          Begin
              recPrecos[intTabPre].fltPreVen :=
                objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intTabPre);

            recPrecos[intTabPre].fltMarBru := fCalculaPrecoVenda(2,
                                                                 fltPreCus + FieldByName('ENT_OUTVAL').AsFloat,
                                                                 recPrecos[intTabPre].fltPreVen,
                                                                 0,
                                                                 FieldByName('ENT_ICMSAI').AsFloat,
                                                                 FieldByName('ENT_IMPFED').AsFloat,
                                                                 FieldByName('ENT_DESOPE').AsFloat,
                                                                 recPrecos[intTabPre].fltComiss);
          End;

        End
        Else
        Begin

          If ((Not Assigned(objFatPre) Or (Assigned(objFatPre) And (Not objFatPre.fTabelaAtiva(intTabPre))))) Or (intTabPre = 1) Then
            recPrecos[intTabPre].fltPreVen := FieldByName('ENT_PREVE' + IntToStr(intTabPre)).AsFloat
          Else
            recPrecos[intTabPre].fltPreVen :=
              objFatPre.fCalculaPrecoVendaFator(recPrecos[1].fltPreVen, intTabPre);

          {*******************************************}
          {* CALCULA AS NOVAS MARGENS BRUTAS         *}
          {****************************************MV*}
          recPrecos[intTabPre].fltMarBru := fCalculaPrecoVenda(2,
                                                               fltPreCus + FieldByName('ENT_OUTVAL').AsFloat,
                                                               recPrecos[intTabPre].fltPreVen,
                                                               0,
                                                               FieldByName('ENT_ICMSAI').AsFloat,
                                                               FieldByName('ENT_IMPFED').AsFloat,
                                                               FieldByName('ENT_DESOPE').AsFloat,
                                                               recPrecos[intTabPre].fltComiss);
        End;
      End;

    End {If (fltPrvPad >= FieldByName('ENT_PREVE1').AsFloat) Or (FieldByName('ENT_RPRENT').AsString = 'S') Then...}

    Else
    Begin
      blnAltPre := False;
      recPrecos[1].blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco := True
    End;

  End;

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);
End;

function fRetTotalBonificacaoEntMer: Double;
  Var
    qryEntMer: TUniQuery;
Begin
  If (Pos('1910', VS_strClaCom) > 0) Or
     (Pos('2910', VS_strClaCom) > 0) Then
  Begin
    Result := 0;
    Exit;
  End;

  qryEntMer := fCriaQuery;
  With qryEntMer, SQL Do
  Begin
    Clear;
    Add('SELECT SUM(ENT_VLRCON) AS TOTITE FROM TMP_ENTMER');
    Add('WHERE ENT_CLAFIS IN ("1910", "2910")');
    Open;
    Result := FieldByName('TOTITE').AsFloat;
    Close;
  End;
  FreeAndNil(qryEntMer);
End;

Procedure pAtualizaUltimaCompraCadLot(strCodIte,
                                      strNumLot,
                                      strCodFor,
                                      strNotUlt,
                                      strCodEmp: String;
                                      fltPreUlt,
                                      fltPreUltImp: Double;
                                      dtaDtaEnt: TDateTime;
                                      blnUltimaNota: Boolean = False);
  Var
    qryCadLot: TUniQuery;
Begin
  If fEmptyStr(strNumLot) Then
    Exit;

  If SameText(strNumLot, STR_A_DEFINIR) Then
    Exit;

  qryCadLot := fCriaQuery;

  With qryCadLot, SQL Do
  Begin
    Add('UPDATE CADLOT SET');
    Add('  LOT_DTAULT = :DTAULT, ');
    Add('  LOT_NOTULT = :NOTULT, ');
    Add('  LOT_FORULT = :FORULT, ');
    Add('  LOT_PREULT = :PREULT, ');
    Add('  LOT_IMPULT = :IMPULT  ');
    Add('WHERE');
    Add('      LOT_CODITE = :CODITE');
    Add('  AND LOT_NUMLOT = :NUMLOT');
    Add('  AND LOT_CODEMP = :CODEMP');
    Add('  AND LOT_GARPRI <> "S" ');

    If blnUltimaNota Then
      Add(' AND LOT_NOTULT = :NOTULT ');

    ParamByName('DTAULT').AsDateTime := dtaDtaEnt;
    ParamByName('NOTULT').AsString   := strNotUlt;
    ParamByName('FORULT').AsString   := strCodFor;
    ParamByName('PREULT').AsFloat    := fltPreUlt;
    ParamByName('IMPULT').AsFloat    := fltPreUltImp;

    ParamByName('CODITE').AsString   := strCodIte;
    ParamByName('NUMLOT').AsString   := strNumLot;
    ParamByName('CODEMP').AsString   := strCodEmp;

    ExecSQL;
  End;

  FreeAndNil(qryCadLot);
End;

Procedure pAtualizaUltimaCompra(strNumDoc,
                                strEspDoc,
                                strSerie_,
                                strCodFor,
                                strCodIte,
                                strClaFisDet,
                                strClaIpi,
                                strForFil,
                                strNumLot,
                                strMedEmp,
                                strEmpMeds: String;
                                blnAtuMed,
                                blnAtuUlt,
                                blnMedSe2: Boolean;
                                fltPreUlt,
                                fltPreUltImp,
                                fltPreMed,
                                fltQtdIte,
                                fltUltCot: Double;
                                dtaDtaEnt: TDateTime;
                                blnRecCliGarantia: Boolean;
                                cdsMovGad: TUniClientDataSet;
                                blnConEqu: Boolean;
                                var blnUpdatePreMed : Boolean);
  Var
    strUpdIte: String;
    qryGenMer: TUniQuery;
    strVirgul: String;
    blnUpDate: Boolean;
    strClaFisBonificacao: String;
Begin
  blnUpDate := False;
  blnUpdatePreMed := False;

  strUpdIte := '';
  strUpdIte := strUpdIte + 'UPDATE ';
  strUpdIte := strUpdIte + '  ITEGER I, ';
  strUpdIte := strUpdIte + '  CADITE C  ';
  strUpdIte := strUpdIte + 'SET ';

  strVirgul := '';

  If (Not fEmptyStr(strClaIpi)) Then
  Begin
    blnUpDate := True;

    strUpdIte := strUpdIte + '  C.ITE_CLAIPI = :CLAIPI ';
    strVirgul := ',';
  End;

  strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;

  If ((Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
     (blnAtuUlt And (Pos(strCodFor, strForFil) > 0)) Then
  Begin
    blnUpDate := True;

    strUpdIte := strUpdIte + strVirgul;
    strUpdIte := strUpdIte + '  I.ITE_NOTULT = :NOTULT, ';
    strUpdIte := strUpdIte + '  I.ITE_ULTCOT = :ULTCOT, ';

    If (Not fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad)) Or (Not blnConEqu) Then
      strUpdIte := strUpdIte + '  I.ITE_FORULT = :FORULT, ';

    strUpdIte := strUpdIte + '  I.ITE_QTDUCO = :QTDITE, ';
    strUpdIte := strUpdIte + '  I.ITE_PREULT = :PREULT, ';
    strUpdIte := strUpdIte + '  I.ITE_IMPULT = :ULTIMP, ';
    strUpdIte := strUpdIte + '  I.ITE_DTAULT = :DTAENT  ';

    strVirgul := ',';
  End;

  // O sistema so vai atualualizar o preço medio na entrada de Tipo NF
  If (((Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
     (blnAtuMed And (Pos(strCodFor, strForFil) > 0))) and (SameText(strEspDoc,'NF') Or blnMedSe2) Then
  Begin
    blnUpDate := True;
    blnUpdatePreMed := True;

    strUpdIte := strUpdIte + strVirgul;
    strUpdIte := strUpdIte + ' I.ITE_PREMED = :PREMED ';
  End;

  strUpdIte := strUpdIte + 'WHERE ';
  strUpdIte := strUpdIte + '  I.ITE_CODITE = C.ITE_CODITE AND ';
  strUpdIte := strUpdIte + '  I.ITE_CODITE = :CODITE AND ';
  strUpdIte := strUpdIte + '  I.ITE_CODEMP = :CODEMP ';

  If Not blnUpDate Then
    Exit;

  qryGenMer := fCriaQuery(Nil);
  qryGenMer.Close;
  qryGenMer.SQL.Clear;
  qryGenMer.SQL.Add(strUpdIte);

  {*****************************************}
  {* DADOS QUE SERÃO ATUALIZADOS           *}
  {**************************************MV*}
  If ((Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (not (Pos(strCodFor, strForFil) > 0))) Or
     (blnAtuUlt And (Pos(strCodFor, strForFil) > 0)) Then
  Begin
    qryGenMer.ParamByName('QTDITE').AsFloat    := fltQtdIte;
    qryGenMer.ParamByName('PREULT').AsFloat    := fltPreUlt;
    qryGenMer.ParamByName('ULTIMP').AsFloat    := fltPreUltImp;
    qryGenMer.ParamByName('ULTCOT').AsFloat    := fltUltCot;

    If (Not fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad)) And (Not blnConEqu) Then
      qryGenMer.ParamByName('FORULT').AsString   := strCodFor;

    qryGenMer.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;

    qryGenMer.ParamByName('NOTULT').AsString := fCodificaChaveNota(strNumDoc,
                                                                   strEspDoc,
                                                                   VS_strCodEmp,
                                                                   strSerie_,
                                                                   strCodFor);

    If (Not blnConEqu) Then
    Begin
      pAtualizaUltimaCompraCadLot(strCodIte,
                                  strNumLot,
                                  strCodFor,
                                  qryGenMer.ParamByName('NOTULT').AsString,
                                  VS_strCodEmp,
                                  fltPreUlt,
                                  fltPreUltImp,
                                  dtaDtaEnt);
    End;

  End;

  If (((Pos(strClaFisDet, VS_strClaCom +  '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (not (Pos(strCodFor, strForFil) > 0))) Or
     (blnAtuMed And (Pos(strCodFor, strForFil) > 0))) and (SameText(strEspDoc,'NF') Or blnMedSe2) Then
    qryGenMer.ParamByName('PREMED').AsFloat := fltPreMed;

  If (Not fEmptyStr(strClaIpi)) Then
    qryGenMer.ParamByName('CLAIPI').AsString := strClaIpi;

  qryGenMer.ParamByName('CODITE').AsString := strCodIte;
  qryGenMer.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryGenMer.ExecSQL;
  qryGenMer.Close;

  If blnUpdatePreMed And (strMedEmp = '1') Then
  Begin
    pAtualizaPrecoMedioEmpreas(strCodIte, strEmpMeds, fltPreMed);
  End;

  FreeAndNil(qryGenMer);
End;

Procedure pAtualizaPrecos(strEmpresas: String; qryTempor: TDataSet;
                          recPrecos: TarrPrecos;
                          fltPreCom,
                          fltPreCus,
                          fltCotDol: Double;
                          blnResFor,
                          blnInfMat,
                          blnAtuPis,
                          blnAtuDic: Boolean;
                          intInfFed,
                          intInfSai,
                          intInfOpe,
                          intDecUni: Integer;
                          strAgrupadorPreAlt: String);
  Var
    strUpdIte: String;
    qryGenMer: TUniQuery;
    intTabPre: Integer;
Begin
  strUpdIte := '';
  strUpdIte := strUpdIte + 'UPDATE ';
  strUpdIte := strUpdIte + '  ITEGER I, ';
  strUpdIte := strUpdIte + '  CADITE C  ';
  strUpdIte := strUpdIte + 'SET ';

  If (fltCotDol <> 0) Then
    strUpdIte := strUpdIte + '  I.ITE_PRECOM = IF(I.ITE_PREDOL = "S", ROUND(:PRECOM / :COTDOL, :DECUNI), :PRECOM), '
  Else
    strUpdIte := strUpdIte + '  I.ITE_PRECOM = :PRECOM, ';

  If blnAtuPis Then
    strUpdIte := strUpdIte + '  I.ITE_DEPICO = :DEPICO, ';

  If blnAtuDIC Then
    strUpdIte := strUpdIte + '  I.ITE_DEICMS = :DEICMS,  ';

  strUpdIte := strUpdIte + '  I.ITE_DESF01 = :DESF01, ';
  strUpdIte := strUpdIte + '  I.ITE_DESF02 = :DESF02, ';
  strUpdIte := strUpdIte + '  I.ITE_DESF03 = :DESF03, ';
  strUpdIte := strUpdIte + '  I.ITE_DESF04 = :DESF04, ';
  strUpdIte := strUpdIte + '  I.ITE_DESF05 = :DESF05, ';
  strUpdIte := strUpdIte + '  I.ITE_DESF06 = :DESF06, ';
  strUpdIte := strUpdIte + '  I.ITE_ICMENT = :ICMENT, ';
  strUpdIte := strUpdIte + '  I.ITE_SUBFED = :SUBFED, ';
  strUpdIte := strUpdIte + '  I.ITE_IPIENT = :IPIENT, ';
  strUpdIte := strUpdIte + '  I.ITE_FREENT = :FREENT, ';
  strUpdIte := strUpdIte + '  I.ITE_VALFRE = :VALFRE, ';
  strUpdIte := strUpdIte + '  I.ITE_ACRFIN = :ACRFIN, ';
  strUpdIte := strUpdIte + '  I.ITE_SUBSTI = :SUBSTI, ';
  strUpdIte := strUpdIte + '  I.ITE_DESADB = :DESADB, ';
  strUpdIte := strUpdIte + '  I.ITE_PREALT = :PREALT,  ';
  strUpdIte := strUpdIte + '  I.ITE_PRECUS = :PRECUS,  ';
  strUpdIte := strUpdIte + '  I.ITE_TCIFCU = :TCIFCU,  ';
  strUpdIte := strUpdIte + '  I.ITE_TSCUST = :TSCUST  ';



  If Not blnResFor Then
  Begin
    strUpdIte := strUpdIte + ',  ';

    If blnInfMat And (intInfSai = 1) Then
      strUpdIte := strUpdIte + '  I.ITE_ICMSAI = IF(:EMPLOG = I.ITE_CODEMP, :ICMSAI, I.ITE_ICMSAI), '
    Else
      strUpdIte := strUpdIte + '  I.ITE_ICMSAI = :ICMSAI, ';

    If blnInfMat And (intInfFed = 1)  Then
      strUpdIte := strUpdIte + '  I.ITE_IMPFED = IF(:EMPLOG = I.ITE_CODEMP, :IMPFED, I.ITE_IMPFED), '
    Else
      strUpdIte := strUpdIte + '  I.ITE_IMPFED = :IMPFED, ';

    If blnInfMat And (intInfOpe = 1)  Then
      strUpdIte := strUpdIte + '  I.ITE_DESOPE = IF(:EMPLOG = I.ITE_CODEMP, :DESOPE, I.ITE_DESOPE), '
    Else
      strUpdIte := strUpdIte + '  I.ITE_DESOPE = :DESOPE, ';

    strUpdIte := strUpdIte + '  I.ITE_OUTVAL = :OUTVAL, ';

    For intTabPre := 1 To length(recPrecos) Do
    Begin
      strUpdIte := strUpdIte + '  I.ITE_MARBR' + IntToStr(intTabPre) + ' = :MARBR' + IntToStr(intTabPre) + ', ';
      strUpdIte := strUpdIte + '  I.ITE_PREVE' + IntToStr(intTabPre) + ' = :PREVE' + IntToStr(intTabPre) + ', ';
      strUpdIte := strUpdIte + '  I.ITE_COMTB' + IntToStr(intTabPre) + ' = :COMTB' + IntToStr(intTabPre) + ', ';
    End;
  End;

  strUpdIte := Trim(strUpdIte);

  If (RightStr(strUpdIte, 1) = ',') Then
    strUpdIte := Copy(strUpdIte, 1, Length(strUpdIte)-1);

  strUpdIte := strUpdIte + ' ';

  strUpdIte := strUpdIte + 'WHERE ';
  strUpdIte := strUpdIte + '  I.ITE_CODITE = C.ITE_CODITE AND ';
  strUpdIte := strUpdIte + '  I.ITE_CODITE = :CODITE AND ';

  If blnResFor Then
    strUpdIte := strUpdIte + '  LOCATE(I.ITE_CODEMP, :CODEMP) = 0 '
  Else
    strUpdIte := strUpdIte + '  LOCATE(I.ITE_CODEMP, :CODEMP) > 0 ';

  qryGenMer := fCriaQuery(Nil);
  qryGenMer.Close;
  qryGenMer.SQL.Clear;
  qryGenMer.SQL.Add(strUpdIte);

  With qryTempor Do
  Begin

    If fltCotDol <> 0 Then
    Begin
      qryGenMer.ParamByName('COTDOL').AsFloat   := fltCotDol;
      qryGenMer.ParamByName('DECUNI').AsInteger := intDecUni;
    End;

    qryGenMer.ParamByName('PRECOM').AsFloat := fltPreCom;

    If blnAtuPis Then
      qryGenMer.ParamByName('DEPICO').AsFloat := FieldByName('ENT_DEPICO').AsFloat;

    If blnAtuDIC Then
      qryGenMer.ParamByName('DEICMS').AsFloat := FieldByName('ENT_DEICMS').AsFloat;

    qryGenMer.ParamByName('DESF01').AsFloat := FieldByName('ENT_DESF01').AsFloat;
    qryGenMer.ParamByName('DESF02').AsFloat := FieldByName('ENT_DESF02').AsFloat;
    qryGenMer.ParamByName('DESF03').AsFloat := FieldByName('ENT_DESF03').AsFloat;
    qryGenMer.ParamByName('DESF04').AsFloat := FieldByName('ENT_DESF04').AsFloat;
    qryGenMer.ParamByName('DESF05').AsFloat := FieldByName('ENT_DESF05').AsFloat;
    qryGenMer.ParamByName('DESF06').AsFloat := FieldByName('ENT_DESF06').AsFloat;
    qryGenMer.ParamByName('ICMENT').AsFloat := FieldByName('ENT_ICMENT').AsFloat;
    qryGenMer.ParamByName('SUBFED').AsFloat := FieldByName('ENT_SUBFED').AsFloat;
    qryGenMer.ParamByName('IPIENT').AsFloat := FieldByName('ENT_IPIENT').AsFloat;
    qryGenMer.ParamByName('FREENT').AsFloat := FieldByName('ENT_FREENT').AsFloat;
    qryGenMer.ParamByName('VALFRE').AsFloat := FieldByName('ENT_FREITE').AsFloat;
    qryGenMer.ParamByName('ACRFIN').AsFloat := FieldByName('ENT_ACRFIN').AsFloat;
    qryGenMer.ParamByName('SUBSTI').AsFloat := FieldByName('ENT_SUBSTI').AsFloat;
    qryGenMer.ParamByName('DESADB').AsFloat := FieldByName('ENT_DESADB').AsFloat;
    qryGenMer.ParamByName('PREALT').AsString:= strAgrupadorPreAlt;

    qryGenMer.ParamByName('TCIFCU').AsFloat := FieldByName('ENT_TCIFCU').AsFloat;
    qryGenMer.ParamByName('TSCUST').AsFloat := FieldByName('ENT_TSCUST').AsFloat;

    qryGenMer.ParamByName('PRECUS').AsFloat := fltPreCus;

    If Not blnResFor Then
    Begin

      qryGenMer.ParamByName('ICMSAI').AsFloat := FieldByName('ENT_ICMSAI').AsFloat;
      qryGenMer.ParamByName('OUTVAL').AsFloat := FieldByName('ENT_OUTVAL').AsFloat;
      qryGenMer.ParamByName('IMPFED').AsFloat := FieldByName('ENT_IMPFED').AsFloat;
      qryGenMer.ParamByName('DESOPE').AsFloat := FieldByName('ENT_DESOPE').AsFloat;

      For intTabPre := 1 To length(recPrecos) Do
      Begin
        qryGenMer.ParamByName('MARBR' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltMarBru;
        qryGenMer.ParamByName('PREVE' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltPreVen;
        qryGenMer.ParamByName('COMTB' + IntToStr(intTabPre)).AsFloat := recPrecos[intTabPre].fltComiss;
      End;

    End;

    {*****************************************}
    {* DADOS DO FILTRO                       *}
    {**************************************MV*}
    qryGenMer.ParamByName('CODITE').AsString := FieldByName('ENT_CODITE').AsString;
    qryGenMer.ParamByName('CODEMP').AsString := strEmpresas;

    If qryGenMer.Params.FindParam('EMPLOG') <> Nil Then
      qryGenMer.ParamByName('EMPLOG').AsString := VS_strCodEmp;

    qryGenMer.ExecSQL;
    qryGenMer.Close;

    If blnInfMat Then
      pRecalculaItensResponsavelFornecedor(strEmpresas, FieldByName('ENT_CODITE').AsString, blnResFor);
  End;

  FreeAndNil(qryGenMer);
End;

Procedure pApagaNotaImportacao(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie: String);
  Var
    qryDelete: TUniQuery;
    procedure pSetParamns;
    Begin
      qryDelete.ParamByName('NUMDOC').AsString := strNumDoc;
      qryDelete.ParamByName('ESPDOC').AsString := strEspDoc;
      qryDelete.ParamByName('CODEMP').AsString := strCodEmp;
      qryDelete.ParamByName('CODFOR').AsString := strCodFor;
      qryDelete.ParamByName('SERIE_').AsString := strSerie;
    End;

    procedure pGravaDEL;
    Begin
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('SELECT * FROM NOTDET');
      qryDelete.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC');
      qryDelete.SQL.Add('   AND DET_ESPDOC = :ESPDOC');
      qryDelete.SQL.Add('   AND DET_CODEMP = :CODEMP');
      qryDelete.SQL.Add('   AND DET_CODFOR = :CODFOR');
      qryDelete.SQL.Add('   AND IFNULL(DET_SERIE_, "") = :SERIE_');
      pSetParamns;
      qryDelete.Open;
      While not qryDelete.EoF do
      Begin
        fVerificaIntegridade('untPcmGer.pApagaNotaImportacao',
                             'NOTDET',
                             qryDelete);
        qryDelete.Next;
      End;
      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('SELECT * FROM NOTGER');
      qryDelete.SQL.Add('WHERE');
      qryDelete.SQL.Add('  GER_NUMDOC = :NUMDOC AND');
      qryDelete.SQL.Add('  GER_ESPDOC = :ESPDOC AND');
      qryDelete.SQL.Add('  GER_CODEMP = :CODEMP AND');
      qryDelete.SQL.Add('  GER_CODFOR = :CODFOR AND');
      qryDelete.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

      pSetParamns;

      qryDelete.Open;

      fVerificaIntegridade('untPcmGer.pApagaNotaImportacao',
                           'NOTGER',
                           qryDelete);

      qryDelete.SQL.Clear;
      qryDelete.SQL.Add('SELECT * FROM CADFIS');
      qryDelete.SQL.Add('WHERE');
      qryDelete.SQL.Add('  FIS_TIP_FC = "F" AND');
      qryDelete.SQL.Add('  FIS_NUMDOC = :NUMDOC AND');
      qryDelete.SQL.Add('  FIS_ESPDOC = :ESPDOC AND');
      qryDelete.SQL.Add('  FIS_CODEMP = :CODEMP AND');
      qryDelete.SQL.Add('  FIS_FORCLI = :CODFOR AND');
      qryDelete.SQL.Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');

      pSetParamns;

      qryDelete.Open;

      fVerificaIntegridade('untPcmGer.pApagaNotaImportacao',
                           'CADFIS',
                           qryDelete);

    End;

Begin

  qryDelete := fCriaQuery(Nil);
  With qryDelete, SQL Do
  Begin
    pGravaDEL;
    Clear;
    Add('DELETE FROM NOTGER');
    Add('WHERE');
    Add('  GER_NUMDOC = :NUMDOC AND');
    Add('  GER_ESPDOC = :ESPDOC AND');
    Add('  GER_CODEMP = :CODEMP AND');
    Add('  GER_CODFOR = :CODFOR AND');
    Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');
    pSetParamns;
    ExecSQL;

    Clear;
    Close;
    Add('DELETE FROM CADFIS');
    Add('WHERE');
    Add('  FIS_TIP_FC = "F" AND');
    Add('  FIS_NUMDOC = :NUMDOC AND');
    Add('  FIS_ESPDOC = :ESPDOC AND');
    Add('  FIS_CODEMP = :CODEMP AND');
    Add('  FIS_FORCLI = :CODFOR AND');
    Add('  IFNULL(FIS_SERIE_, "") = :SERIE_ ');
    pSetParamns;
    ExecSQL;
  End;

  FreeAndNil(qryDelete);
End;

procedure pSetaReservaSaldoPedidoOS(strSeqGer: String; blnConferencia: Boolean = False);
begin
{}
End;

procedure pEnviaMsgRequisicaoConcluida(strSeqGer: String; blnConferencia: Boolean = False);
  Var
    qryReq, qryVen: TUniQuery;
    strOpeAtu,
    strNumReq,
    strDtaCad,
    strNomCli,
    strDesIte,
    strRefere,
    strSigUni,
    strQtdReq,
    strQtdRec,
    strDtaVen,
    strNumLot,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strStatus,
    strEntFut,
    strNumDoc,
    strCodVen,
    strNomVen : String;
    blnDocVendaVinculado: boolean;

    stlMsg: TStringList;
    msgInt: TMsgInterna;
    qryOperadosMarcadosParaReceberNotificacao : TUniQuery;


begin
  qryReq := fCriaQuery;
  qryVen := fCriaQuery;
  stlMsg := TStringList.Create;
  msgInt := TMsgInterna.Create(Nil);
  Try
    qryReq.Close;
    qryReq.SQL.Clear;
    qryReq.SQL.Add('SELECT');
    qryReq.SQL.Add('  RCG_CODVEN AS CODVEN,');
    qryReq.SQL.Add('  OPE_NOMOPE AS NOMOPE,');
    qryReq.SQL.Add('  RCG_CODIGO AS NUMREQ,');
    qryReq.SQL.Add('  RCG_DTACAD AS DTACAD,');
    qryReq.SQL.Add('  CLI_NOMCLI AS NOMCLI,');
    qryReq.SQL.Add('  RCD_CODITE AS CODITE,');
    qryReq.SQL.Add('  RCD_DOCPDV,          ');
    qryReq.SQL.Add('  RCD_EMPPDV,          ');
    qryReq.SQL.Add('  RCD_ESPPDV,          ');
    qryReq.SQL.Add('  FGO_CODCLI AS CODCLI,');
    qryReq.SQL.Add('  CONCAT(ITE_CODITE, "-", ITE_DESITE) AS DESITE,');
    qryReq.SQL.Add('  ITE_REFERE AS REFERE,');
    qryReq.SQL.Add('  UNI_SIGUNI AS SIGUNI,');
    qryReq.SQL.Add('  RCD_QTDITE AS QTDREQ,');
    qryReq.SQL.Add('  FGO_DTAENT AS DTAVEND,');
    qryReq.SQL.Add('  DET_NUMLOT AS NUMLOT,');
    qryReq.SQL.Add('  DET_ESPDOC AS ESPDOC,');
    qryReq.SQL.Add('  DET_CODEMP AS CODEMP,');
    qryReq.SQL.Add('  DET_NUMDOC AS NUMDOC,');
    qryReq.SQL.Add('  DET_MOTFUT AS DETSTA,');
    qryReq.SQL.Add('  CONCAT(RCD_DOCPDV, "-", RCD_EMPPDV, "-", RCD_ESPPDV) AS DOCPDV, ');
    qryReq.SQL.Add('  IFNULL(EQUGER.EQU_NUMOSE, EQ.EQU_NUMOSE) AS EQU_NUMOSE,');
    qryReq.SQL.Add('  IFNULL(EQUGER.EQU_PROTOC, EQ.EQU_PROTOC) AS EQU_PROTOC, ');
    qryReq.SQL.Add('  IFNULL(EQUGER.EQU_CODEMP, EQ.EQU_CODEMP) AS EQU_CODEMP, ');
    qryReq.SQL.Add('  CASE IFNULL(EQUGER.EQU_GARANT, EQ.EQU_GARANT) ');
    qryReq.SQL.Add('  WHEN "N" THEN "Não"');
    qryReq.SQL.Add('  WHEN "L" THEN "Garantia Loja"');
    qryReq.SQL.Add('  WHEN "F" THEN "Garantia Fábrica"');
    qryReq.SQL.Add('  WHEN "R" THEN "Retorno de Garantia"');
    qryReq.SQL.Add('  END AS GARANT,');
    qryReq.SQL.Add('  IFNULL(EQUGER.EQU_GARANT, EQ.EQU_GARANT) AS EQU_GARANT, ');
    qryReq.SQL.Add('  IF(C.EQU_CODIGO IS NULL, CONCAT(CE.EQU_CODIGO, "-", CE.EQU_DESCRI), CONCAT(C.EQU_CODIGO, "-", C.EQU_DESCRI)) AS DESEQU, ');
    qryReq.SQL.Add('  (SELECT CONCAT(OPE_CODOPE, "-", OPE_NOMOPE) FROM CADOPE WHERE OPE_CODOPE = IFNULL(EQUGER.EQU_CODVEN, EQ.EQU_CODVEN) ) AS OSVEND,');
    If blnConferencia Then
    Begin
      qryReq.SQL.Add(' (SELECT SUM(DIG_QTDITE) FROM DIGELE ');

      qryReq.SQL.Add('  INNER JOIN GERELE G ON G.GER_IDEDIG = DIG_IDEDIG AND G.GER_CODEMP = DIG_CODEMP ');

      qryReq.SQL.Add('  WHERE DET_CODITE = DIG_CODITE ');
      qryReq.SQL.Add('                AND G.GER_DOCENT = DET_NUMDOC ');
      qryReq.SQL.Add('                AND G.GER_ESPENT = DET_ESPDOC ');
      qryReq.SQL.Add('                AND G.GER_CODFOR = DET_CODFOR ');
      qryReq.SQL.Add('                AND G.GER_CODEMP = DET_CODEMP ');
      qryReq.SQL.Add('                AND G.B07_SERIE  = DET_SERIE_ ');

      qryReq.SQL.Add('  ) AS QTDREC ');

    End

    Else
      qryReq.SQL.Add('  DET_QTDITE AS QTDREC ');


    qryReq.SQL.Add(', (SELECT IFNULL(ITE_QTEF_A, 0) +  IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) + IFNULL(ITE_QTPDBF, 0) AS ITE_ENTFUT '+
                      ' FROM '+
                      '  ITEGER '+
                      'WHERE ITEGER.ITE_CODITE = CADITE.ITE_CODITE '+
                      'AND ITEGER.ITE_CODEMP = DET_CODEMP) AS ENTFUT ');

    qryReq.SQL.Add('FROM');

    qryReq.SQL.Add('  MOVDET D');

    qryReq.SQL.Add('  JOIN BAIREQ ON BAI_AUTDET = D.AUTOINCREM ');

    qryReq.SQL.Add('  JOIN MOVRCD R ON R.AUTOINCREM = BAI_AUTREQ ');

    qryReq.SQL.Add('  JOIN MOVRCG ON RCG_CODIGO = RCD_CODIGO');
    qryReq.SQL.Add('             AND RCG_CODEMP = RCD_CODEMP');

    qryReq.SQL.Add('  JOIN CADOPE ON OPE_CODOPE = RCG_CODVEN');
    qryReq.SQL.Add('  JOIN CADITE ON ITE_CODITE = RCD_CODITE');
    qryReq.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
    qryReq.SQL.Add('  JOIN CADCLI ON CLI_CODCLI = RCG_CODCLI');
    qryReq.SQL.Add('  LEFT JOIN FATGOR ON FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP =  RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV');
    qryReq.SQL.Add('  LEFT JOIN EQUGER ON (EQUGER.EQU_TIPPED = FATGOR.FGO_ESPDOC ');
    qryReq.SQL.Add('       AND EQUGER.EQU_EMPPED = FATGOR.FGO_CODEMP ');
    qryReq.SQL.Add('       AND EQUGER.EQU_NUMPED = FATGOR.FGO_NUMDOC) ');
    qryReq.SQL.Add('  LEFT JOIN EQUGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM');
    qryReq.SQL.Add('  LEFT JOIN EQUGER EQ ON (EQ.AUTOINCREM = EQUGOR.FGO_SEQEQU) ');
    qryReq.SQL.Add('  LEFT JOIN CADEQU C ON EQUGER.EQU_CODEQU = C.EQU_CODIGO ');
    qryReq.SQL.Add('  LEFT JOIN CADEQU CE ON EQ.EQU_CODEQU = CE.EQU_CODIGO ');

    qryReq.SQL.Add('  WHERE ');
    qryReq.SQL.Add('    DET_SEQGER = ' + QuotedStr(strSeqGer));

    qryReq.SQL.Add('  HAVING QTDREC > 0');

    qryReq.SQL.Add('ORDER BY');
    qryReq.SQL.Add('  RCG_CODVEN,');
    qryReq.SQL.Add('  RCG_CODIGO,');
    qryReq.SQL.Add('  RCD_CODITE');
    qryReq.Open;

    strOpeAtu := '';

    While Not qryReq.Eof Do
    Begin
      blnDocVendaVinculado := False;
      If Not fEmptyStr(qryReq.FieldByName('RCD_DOCPDV').AsString) Then
      Begin
        qryVen.Close;
        qryVen.SQL.Clear;
        qryVen.SQL.Add('SELECT FDO_DTAFAT AS DTAVEND, FDO_NUMFAT AS NUMDOC, DET_NUMLOT AS NUMLOT, FDO_TIPFAT AS ESPDOC, OPE_NOMOPE AS NOMOPE,');
        qryVen.SQL.Add('                 FDO_EMPFAT AS CODEMP, FDO_CODCLI AS CODCLI, FDO_VENFAT AS CODVEN,FDO_MOTFUT AS STATUS, FDO_QTDITE AS QTDITE FROM FATDOR');
        qryVen.SQL.Add(' INNER JOIN MOVDET ON DET_NUMDOC = FDO_NUMFAT');
        qryVen.SQL.Add('                 AND DET_ESPDOC =  FDO_TIPFAT');
        qryVen.SQL.Add('                 AND DET_CODCLI = FDO_CODCLI');
        qryVen.SQL.Add('                 AND DET_DTAENT = FDO_DTAFAT');
        qryVen.SQL.Add('                 AND DET_CODEMP = FDO_EMPFAT');
        qryVen.SQL.Add('                 AND DET_CODITE = FDO_CODITE');
        qryVen.SQL.Add(' JOIN CADOPE ON OPE_CODOPE = FDO_VENFAT');

        qryVen.SQL.Add(' WHERE FDO_NUMDOC = '+ QuotedStr(qryReq.FieldByName('RCD_DOCPDV').AsString));
        qryVen.SQL.Add(' AND FDO_CODITE = '+ QuotedStr(qryReq.FieldByName('CODITE').AsString));
        qryVen.SQL.Add(' AND FDO_CODCLI = '+ QuotedStr(qryReq.FieldByName('CODCLI').AsString));
        qryVen.SQL.Add(' AND FDO_CODEMP = '+ QuotedStr(qryReq.FieldByName('RCD_EMPPDV').AsString));
        qryVen.SQL.Add(' AND FDO_ESPDOC = '+ QuotedStr(qryReq.FieldByName('RCD_ESPPDV').AsString));
        qryVen.open;

        blnDocVendaVinculado := (Not qryVen.IsEmpty);
      End;


      If strOpeAtu <> qryReq.FieldByName('CODVEN').AsString Then
      Begin
        strOpeAtu := qryReq.FieldByName('CODVEN').AsString;
        stlMsg.Clear;
        stlMsg.Add('Caro Sr(a). '+ qryReq.FieldByName('NOMOPE').AsString);
        stlMsg.Add('');
        stlMsg.Add('Em '+ FormatDateTime('dd/mm/yyyy', VS_Date) +' ocorreu Entrada de Mercadorias para atender sua Requisição de Compra, conforme segue abaixo:');
        If qryReq.FieldByname('EQU_NUMOSE').AsString <> '' Then
        Begin
          stlMsg.Add('Numero da Ordem de Serviço: ' + qryReq.FieldByName('EQU_NUMOSE').AsString + '-' + qryReq.FieldByName('EQU_CODEMP').AsString);
          stlMsg.Add('Protocolo.................: ' + qryReq.FieldByName('EQU_PROTOC').AsString);
          stlMsg.Add('Garantia..................: ' + qryReq.FieldByName('GARANT').AsString);
          stlMsg.Add('Vendedor..................: ' + qryReq.FieldByName('OSVEND').AsString);
          stlMsg.Add('Equipamento...............: ' + qryReq.FieldByName('DESEQU').AsString);
        End;

                 //     5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5    5   1234567890123456789
        stlMsg.Add('-----------------------------------------------------------------------------------------------------------------------------------------');
        stlMsg.Add('Requisição Data Cad.  Cliente                            Item                    Ref        Un. Qtd.Requi. Qtd.Receb. Pedido de Venda    ');
//        If Not blnDocVendaVinculado Then
//          stlMsg.Add('-------------------------------------------------------------------------------------------------------------------------------------')
//        Else
//        Begin
          stlMsg.Add(' Dt. Venda | Documento | Lote do Doc. | Esp. | Emp | Cód. Cli. |  Cód. Ven.  | Nome Vendedor | Status | Qtd. A Receber  ');
          stlMsg.Add('---------------------------------------------------------------------------------------------------------------------------------------');
//        End;
      End;

      strNumReq := qryReq.FieldByName('NUMREQ').AsString;
      strDtaCad := FormatDateTime('dd/mm/yyyy', qryReq.FieldByName('DTACAD').AsDateTime);
      strNomCli := qryReq.FieldByName('CODCLI').AsString + ' - '+qryReq.FieldByName('NOMCLI').AsString;
      strDesIte := qryReq.FieldByName('DESITE').AsString;
      strRefere := qryReq.FieldByName('REFERE').AsString;
      strSigUni := qryReq.FieldByName('SIGUNI').AsString;
      strQtdReq := FormatFloat('#,##0.00', qryReq.FieldByName('QTDREQ').AsFloat);
      strQtdRec := FormatFloat('#,##0.00', qryReq.FieldByName('QTDREC').AsFloat);

      stlMsg.Add(fPadL(strNumReq, 10, ' ')
         + ' ' + strDtaCad
         + ' ' + fPadR(strNomCli, 34, ' ')
         + ' ' + fPadR(strDesIte, 23, ' ')
         + ' ' + fPadR(strRefere, 10, ' ')
         + ' ' + fPadR(strSigUni,  3, ' ')
         + ' ' + fPadL(strQtdReq, 10, ' ')
         + ' ' + fPadL(strQtdRec, 10, ' ')
         + ' ' + fPadR(qryReq.FieldByName('DOCPDV').AsString, 19, ' '));

      If blnDocVendaVinculado Then
      Begin
        strDtaVen := FormatDateTime('dd/mm/yyyy', qryVen.FieldByName('DTAVEND').AsDateTime);
        strNumDoc := qryVen.FieldByName('NUMDOC').AsString;
        strNumLot := qryVen.FieldByName('NUMLOT').AsString;
        strEspDoc := qryVen.FieldByName('ESPDOC').AsString;
        strCodEmp := qryVen.FieldByName('CODEMP').AsString;
        strCodVen := qryReq.FieldByName('CODVEN').AsString;
        strCodCli := qryVen.FieldByName('CODCLI').AsString;
        strStatus := qryVen.FieldByName('STATUS').AsString;
        strEntFut := qryVen.FieldByName('QTDITE').AsString;
        strNomVen := qryVen.FieldByName('NOMOPE').AsString;

        stlMsg.Add(fPadL(strDtaVen, 11, ' ')
         + ' ' + fPadR(strNumDoc, 12, ' ')
         + ' ' + fPadR(strNumLot, 15, ' ')
         + ' ' + fPadR(strEspDoc,  5, ' ')
         + ' ' + fPadR(strCodEmp,  6, ' ')
         + ' ' + fPadR(strCodCli, 15, ' ')
         + ' ' + fPadR(strCodVen, 10, ' ')
         + ' ' + fPadR(strNomVen, 15, ' ')
         + ' ' + fPadL(strStatus,  3, ' ')
         + ' ' + fPadL(strEntFut, 8, ' '));
      End
      Else 
        stlMsg.Add('Sem documento faturado.');
      qryReq.Next;

      // Envia Mensagem
      If qryReq.Eof Or (strOpeAtu <> qryReq.FieldByName('CODVEN').AsString) Then
      Begin
        msgInt.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_ATENDIDA, stlMsg.Text, strLoginUsuarioLogado, strOpeAtu, 'N','');

        qryOperadosMarcadosParaReceberNotificacao := fCriaQuery(nil);
        Try
          qryOperadosMarcadosParaReceberNotificacao.SQL.Add('SELECT OPE_CODOPE FROM CADOPE WHERE OPE_MSGCVA  = "S" AND IFNULL(OPE_CVATDS, "S") = "S"');
          qryOperadosMarcadosParaReceberNotificacao.Open;
          While Not qryOperadosMarcadosParaReceberNotificacao.Eof Do
          Begin
            If qryOperadosMarcadosParaReceberNotificacao.FieldByName('OPE_CODOPE').AsString <> strOpeAtu Then
               msgInt.fEnviaMensagem(MSG_ASSUNTO_REQUISICAO_ATENDIDA, stlMsg.Text, strLoginUsuarioLogado, qryOperadosMarcadosParaReceberNotificacao.FieldByName('OPE_CODOPE').AsString, 'N','');

            qryOperadosMarcadosParaReceberNotificacao.Next;
          End;

        Finally
          FreeAndNil(qryOperadosMarcadosParaReceberNotificacao);
        End;
      End;
    End;

  Finally
    FreeAndNil(qryReq);
    FreeAndNil(stlMsg);
    FreeAndNil(msgInt);
    FreeAndNil(qryVen);
  End;
end;

Procedure pAtualizaClassificaoIPI_CDCEST(strCodIte, strClaIpi, strCDCEST: String);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery(Nil);
  With qryIteger, SQL Do
  Begin
    Add('UPDATE CADITE');
    Add('SET');
    If Not fEmptyStr(strClaIpi) Then
      Add('  ITE_CLAIPI = :CLAIPI');
    If Not fEmptyStr(strCDCEST) Then
      Add(IIf(fEmptyStr(strClaIpi), '', ',') + ' ITE_CDCEST = :CDCEST');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE ');

    ParamByName('CODITE').AsString := strCodIte;
    If Not fEmptyStr(strClaIpi) Then
      ParamByName('CLAIPI').AsString := strClaIpi;
    If Not fEmptyStr(strCDCEST) Then
      ParamByName('CDCEST').AsString := strCDCEST;

    ExecSQL;

  End;

  FreeAndNil(qryIteger);
End;

function fRetInfCpl(strAutInc : String; Var strInfAdFisco: String) : String;
  Var
    qryBusca : TUniQuery;
Begin
  Try
    Result := '';
    strInfAdFisco := '';

    qryBusca := fCriaQuery;
    With qryBusca, Sql Do
    Begin
      Add(' SELECT      ');
      Add('   Z03_INFCPL,  ');
      Add('   Z02_INFADFISCO ');
      Add(' FROM INFELE ');
      Add(' WHERE       ');
      Add(' ELE_SEQELE = :SEQELE ');

      ParamByName('SEQELE').AsString := strAutInc;

      Open;

      if not IsEmpty Then
      Begin
        strInfAdFisco := FieldByName('Z02_INFADFISCO').AsString;
        Result        := FieldByName('Z03_INFCPL').AsWideString;
      End;

    End;
  Finally
    FreeAndNil(qryBusca);
  End;

End;

Function fRetNumLot(qryEntMer: TDataSet; strCodEmp: String; objCadLot: TCadLot): String;
Begin
  //Quando usa rotina WMS na empresa CD existe lote, porem nas outras empresas nao utiliza
  //cadastro de lotes. Por isso antes de gravar precisa verificar se a empresa possui o lote.
  With qryEntMer Do
  Begin
    Result := FieldByName('ENT_NUMLOT').AsString;

    If fUsaRotinaWMS And fEmptyStr(Result) Then
      Result := 'A DEFINIR';

    If Not objCadLot.fExisteLote(FieldByName('ENT_CODITE').AsString, strCodEmp,
                                 FieldByName('ENT_NUMLOT').AsString, False, False) Then
    Begin
      Result := '';
    End;
  End;
End;

Function fAtualizaItem(strTipFor: String; blnAtpRau: Boolean; strCodIte: String; objAtuFor: TAlteraFornecedorEntrada): Boolean;
Begin
  Result := (strTipFor <> 'M') And blnAtpRau Or (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(strCodIte));
End;

Procedure pRecalculaPrecosEntrada(qryEntMer, qryConIte: TDataSet;
   fltPreMed,
   fltPreUlt,
   fltPreUltImp: Double;
   Var fltPreCom, fltPreCus, fltPrecomOri: Double;
   Var recPrecos: TarrPrecos;
   Var blnAltPre: Boolean;
   Var cpcParams: TParCalculaPrecoCusto;
   var blnOutDesEntraNoprecoCompra: Boolean;
   strCodFor, strForFil, strEspDoc, strAtuNMD, strNaoAtu, strCnvEmb, strTipFor: String;
   blnAtpRau, blnAtpRen, blnMedSe2: Boolean;
   objAtuFor: TAlteraFornecedorEntrada;
   blnAtpVmb: TarrAtpVmb;
   intDecUni: Integer;
   blnEncargosNoFrete: Boolean);

  function fItem(strCampo: String): TField;
  begin
    Result := qryConIte.FieldByName('ITE_' + strCampo);
  end;

  Var
    intTabPre: Integer;
Begin
  With qryEntMer Do
  Begin
    blnOutDesEntraNoprecoCompra := False;
    fltPreCom := FieldByName('ENT_PRECOM').AsFloat;
    fltPreCus := FieldByName('ENT_PRECUS').AsFloat;

    If (strCnvEmb <> 'N') And (FieldByName('ENT_EMBALA').AsFloat <> 0) And
       ((Not SameText(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_ITE_F5').AsString)) Or
        SameText(FieldByName('ENT_EMB_F5').AsString, 'S')) Then
    Begin
      fltPreCom := fStrToFloat( FormatFloat(fMskDigitos(intDecUni), fltPreCom / FieldByName('ENT_EMBALA').AsFloat ) );
      fltPreCus := fStrToFloat( FormatFloat(fMskDigitos(intDecUni), fltPreCus / FieldByName('ENT_EMBALA').AsFloat ) );
    End;
    fltPrecomOri := fltPreCom;
    For intTabPre := 1 To length(recPrecos) Do
    Begin
      recPrecos[intTabPre].fltPreVen := FieldByName('ENT_PREVE' + IntToStr(intTabPre)).AsFloat;

      If FieldByName('ENT_PREEM' + IntToStr(intTabPre)).AsString = 'S' Then
        recPrecos[intTabPre].fltPreVen := fStrToFloat( FormatFloat(fMskDigitos(intDecUni), recPrecos[intTabPre].fltPreVen / FieldByName('ENT_EMBALA').AsFloat ) );

      recPrecos[intTabPre].fltMarBru := FieldByName('ENT_MARBR' + IntToStr(intTabPre)).AsFloat;
      recPrecos[intTabPre].fltComiss := FieldByName('ENT_COMTB' + IntToStr(intTabPre)).AsFloat;
    End;

    blnAltPre := (strNaoAtu <> 'S');

    If fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor) And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
    Begin
      If (strAtuNMD = 'M') Then
      Begin
        if SameText(strEspDoc,'NF') Or blnMedSe2 Then
          fltPreCom := fltPreMed
        Else
          fltPreCom := fItem('PREMED').AsFloat;
      End
      Else If (strAtuNMD = 'U') Then
        fltPreCom := fltPreUlt
      Else If (strAtuNMD = 'D') Then
      Begin

        If blnEncargosNoFrete Then
          fltPreCom := fltPreUlt
        Else
        Begin
          fltPreCom := fltPreUlt + ((FieldByName('ENT_OUTDES').AsFloat + FieldByName('ENT_DESACE').AsFloat) / FieldByName('ENT_QTDITE').AsFloat );
          blnOutDesEntraNoprecoCompra := True;
        End

      End Else If (strAtuNMD = 'I') Then
        fltPreCom := fltPreUltImp
      Else If (strAtuNMD = 'O') Then
      Begin

        If Not blnEncargosNoFrete Then
        Begin
          fltPreCom := fltPreCom + ((FieldByName('ENT_OUTDES').AsFloat + FieldByName('ENT_DESACE').AsFloat) / FieldByName('ENT_QTDITE').AsFloat );
          blnOutDesEntraNoprecoCompra := True;
        End
      End;

      pRecalculaPrecos(recPrecos,
                       fltPreCus,
                       blnAltPre,
                       cpcParams,
                       fltPreCom,
                       qryConIte,
                       qryEntMer,
                       (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(FieldByName('ENT_CODITE').AsString)),
                       blnAtpVmb);

      blnAltPre := blnAltPre And (strNaoAtu <> 'S');
    End;

  End;

End;

Procedure pCalculaPreUltImp(blnNotaImp: boolean;
                            qryEntMer: TDataSet;
                       strCodEmp, strCodFor, strEspDoc, strSimPau, strTipFor: String;
                       dtaDtaEnt: TDateTime;
                       blnDevolu,
                       blnConEqu,
                       blnUltPis,
                       blnDedIcm,
                       blnPrecoPraticado,
                       blnAchouDevolucao,
                       blnForFil: Boolean;
                       Var CalcResult: TResultPisCofins;
                       Var fltPreUltImp, fltImpUlt, fltAlqRet,
                           fltTotAlqPis, fltTotAlqCof,
                           fltAlqPisCofPreUlt,
                           fltValorFreteCalc,
                           fltValorFreConCalc: Double);
  Var
    tmp: TCalculoPisCofins;
    objImpUlt: TCalculoUltimaCompraImpostos;
    strSitP_C: String;
    blnZeraIPI: Boolean;
Begin

  With qryEntMer Do
  Begin
    tmp := TCalculoPisCofins.Create;
    tmp.blnGerarException := True;

    strSitP_C := fDefineSit_P_C(strCodEmp, strCodFor);

    CalcResult := tmp.fCalculoPisCofins(strCodEmp,
                                        FieldByName('ENT_CODITE').AsString,
                                        FieldByName('ENT_CLAFIS').AsString,
                                        FieldByName('ENT_CODFIS').AsString,
                                        strCodFor,
                                        strSimPau,
                                        strEspDoc,
                                        FieldByName('ENT_TOTITE').AsFloat,
                                        FieldByName('ENT_DESESP').AsFloat,
                                        FieldByName('ENT_VALIPI').AsFloat + FieldByName('ENT_VAEIPI').AsFloat,
                                        FieldByName('ENT_VALRET').AsFloat + FieldByName('ENT_VAERET').AsFloat,
                                        FieldByName('ENT_VALFRE').AsFloat,
                                        FieldByName('ENT_DESACE').AsFloat,
                                        FieldByName('ENT_VALICM').AsFloat,
                                        0,
                                        IIF(blnDevolu Or blnConEqu,'C','F'),
                                        FieldByName('ENT_INCPIS').AsString,
                                        strSitP_C, '',
                                        dtaDtaEnt,
                                        '',
                                        False,
                                        False,
                                        '',
                                        '',
                                        '',
                                        '',
                                        False,
                                        FieldByName('ENT_SITXML').AsString,
                                        FieldByName('ENT_ICMXML').ASFloat,
                                        FieldByName('ENT_CSTPIS').AsString,
                                        FieldByName('ENT_CSTCOF').AsString,
                                        FieldByName('ENT_VALPIS').AsFloat,
                                        FieldByName('ENT_VALCOF').AsFloat);

    tmp.Destroy;

    If strTipFor = 'M' Then
    Begin
      fltTotAlqPis := 0;
      fltTotAlqCof := 0;
      fltAlqPisCofPreUlt := 0;
      fltImpUlt := 0;
      fltPreUltImp := 0;
    End;

    If blnPrecoPraticado Then
    Begin
      CalcResult.dblAlqPis    := FieldByName('ENT_ALQPIS').AsFloat;
      CalcResult.dblBasePis   := FieldByName('ENT_BASPIS').AsFloat;
      CalcResult.dblValorPis  := FieldByName('ENT_VALPIS').AsFloat;
      CalcResult.dblAlqCof    := FieldByName('ENT_ALQCOF').AsFloat;
      CalcResult.dblBaseCof   := FieldByName('ENT_BASCOF').AsFloat;
      CalcResult.dblValorCof  := FieldByName('ENT_VALCOF').AsFloat;

      CalcResult.strNatRecPis := FieldByName('ENT_NR_PIS').AsString;
      CalcResult.strNatRecCof := FieldByName('ENT_NR_COF').AsString;
      fltAlqRet               := FieldByName('ENT_ALQRET').AsFloat;
    End;

    If CalcResult.dblBasePis > 0 Then
    Begin
      fltTotAlqPis := CalcResult.dblAlqPis;
      fltTotAlqCof := CalcResult.dblAlqCof;
    End;

    If blnUltPis Then
      fltAlqPisCofPreUlt := (CalcResult.dblAlqPis + CalcResult.dblAlqCof) / 100
    Else
      fltAlqPisCofPreUlt := 0;

    objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt
      .TotalItem(FieldByName('ENT_TOTITE').AsFloat)
      .DescontoEspecial(FieldByName('ENT_DESESP').AsFloat);

    If blnUltPis Then
    Begin
      objImpUlt.AliquotaPis(CalcResult.dblAlqPis).AliquotaCofins(CalcResult.dblAlqCof);
    End
    Else
    Begin
      objImpUlt.AliquotaPis(0).AliquotaCofins(0);
    End;


    blnZeraIPI := fZeraIPI(FieldByName('ENT_CODITE').AsString);

    if Assigned(qryEntMer.FindField('ENT_FRERPA')) then
      objImpUlt.fRecebimentoPagamentoAutonomoFrete(FieldByName('ENT_FRERPA').AsFloat);

    objImpUlt.blnUltPis := blnUltPis;

    objImpUlt
      .ValorIpi(IIf(blnZeraIPI, 0, FieldByName('ENT_VALIPI').AsFloat))
      .ValorIpiNaoCreditado(IIf(blnZeraIPI, 0, FieldByName('ENT_VAEIPI').AsFloat))
      .Frete(FieldByName('ENT_VALFRE').AsFloat)
      .ConhecimentoFrete(FieldByName('ENT_FRECON').AsFloat)
      .AliquotaICMSdoFrete(FieldByName('ENT_ICMCFR').AsFloat)
      .OutrasDespesas(FieldByName('ENT_OUTDES').AsFloat)
      .Vendor(FieldByName('ENT_VENDOR').AsFloat)
      .DespesaAcessoria(FieldByName('ENT_DESACE').AsFloat)

      .ValorIcms(IIF(blnDedIcm and (not blnNotaImp), FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat, 0))

      .ValorIcmsNaoCreditado(IIF(blnDedIcm and (not blnNotaImp), IIF((FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                0,
                                                FieldByName('ENT_ICMXML').AsFloat + FieldByName('ENT_FCPXML').AsFloat), 0))

      .ValorIcmsAntecipado(FieldByName('ENT_VALANT').AsFloat)
      .ValorIcmsAntecipadoFrete(FieldByName('ENT_VAFRAN').AsFloat)
      .ValorGNRE(FieldByName('ENT_VALGNR').AsFloat)
      .ValorTCIF(FieldByName('ENT_VLTCIF').AsFloat)
      .ValorTS(FieldByName('ENT_VAL_TS').AsFloat)
      .ValorRetido(FieldByName('ENT_VALRET').AsFloat)
      .ValorRetidoNaoCreditado(FieldByName('ENT_VAERET').AsFloat)
      .ValorFundoCombateAPobreza(FieldByName('ENT_VFCPST').ASFloat)
      .FornecedorFilial(blnForFil)
      .ItemIncidePis(FieldByName('ENT_INCPIS').AsString)
      .ValorSiscomex(IIf(blnNotaImp, FieldByName('ENT_VALSIS').AsFloat, 0))
      .ValorIcmsNotaImportacao(IIf(blnNotaImp, FieldByName('ENT_VALICM').AsFloat, 0));


    If blnAchouDevolucao Then
    Begin
      fltPreUltImp := fltImpUlt / FieldByName('ENT_QTDITE').AsFloat;
    End Else
    Begin
      fltImpUlt := objImpUlt.fTotal;
      fltPreUltImp := objImpUlt.fUnitario(FieldByName('ENT_QTDITE').AsFloat);
    End;

    fltPreUltImp := fFormataFloat(fltPreUltImp, 4);
    fltValorFreteCalc := fFormataFloat(objImpUlt.ValorFreteCalculado, 4);
    fltValorFreConCalc := fFormataFloat(objImpUlt.ValorConhecimentoCalculado, 4);

    If Assigned(objImpUlt) Then
      FreeAndNil(objImpUlt);
  End;
End;

function fBaixaPedidosEmbalagem(oleItensPedidos : oleVariant; cdsPedidos : TUniClientDataSet;
                       strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle : String;
                       Var objEmbala: TEntEmbalagens;
                       blnEntradaDeMercadorias : Boolean = True;
                       pgbDados: TProgressBar = Nil):Boolean;
  Var
    blnLibPcm,
    blnSaldoPendente : Boolean;
    strAutIncHISENT,
    strForFil,
    strPedAnt,
    strEmpAnt,
    strCnvEmb        : String;
    intDEQTPC: Integer;
Begin
  Result := True;
  blnSaldoPendente := (fCfgSis('SLPEPD', varBoolean));
  strCnvEmb        := fCfgSis('CNVEMB');
  strForFil        := fRetForFilialTodos;
  blnLibPcm        := fCfgSis('LIBPCM', varBoolean);
  intDEQTPC        := fCfgSis('DEQTPC', varInteger);

  If (oleItensPedidos <> Null) And cdsPedidos.Active Then
    cdsPedidos.First;

 If (Not cdsPedidos.IsEmpty) Then
    strAutIncHISENT := fRetAutoIncrem('HISENT', VS_strCodEmp, cdsPedidos.RecordCount);

  While (oleItensPedidos <> Null) And (Not cdsPedidos.Eof) Do
  Begin
    strPedAnt := cdsPedidos.FieldByName('NUMPED').AsString;
    strEmpAnt := cdsPedidos.FieldByName('CODEMP').AsString;

    While (Not cdsPedidos.Eof)                                    And
          (strPedAnt = cdsPedidos.FieldByName('NUMPED').AsString) And
          (strEmpAnt = cdsPedidos.FieldByName('CODEMP').AsString) Do
    Begin
      If blnEntradaDeMercadorias Then
      Begin
        If Not fEmptyStr(strCodFor) Then
        Begin
          Result := Result And
                  fGravaHistoricoEntradaMercadorias(strNumDoc,
                                                    strEspDoc,
                                                    strCodEmp,
                                                    strCodFor,
                                                    strSerie,
                                                    cdsPedidos.FieldByName('NUMPED').AsString,
                                                    cdsPedidos.FieldByName('CODEMP').AsString,
                                                    cdsPedidos.FieldByName('CODITE').AsString,
                                                    cdsPedidos.FieldByName('DESITE').AsString,
                                                    cdsPedidos.FieldByName('QTDITE').AsFloat,
                                                    cdsPedidos.FieldByName('UNITAR').AsFloat,
                                                    cdsPedidos.FieldByName('TOTITE').AsFloat,
                                                    cdsPedidos.FieldByName('QTDBAI').AsFloat,
                                                    cdsPedidos.FieldByName('UNIBAI').AsFloat,
                                                    cdsPedidos.FieldByName('TOTBAI').AsFloat,
                                                    cdsPedidos.FieldByName('EXCESS').AsFloat,
                                                    cdsPedidos.FieldByName('DIFQTD').AsFloat,
                                                    cdsPedidos.FieldByName('DIFUNI').AsFloat,
                                                    strAutIncHISENT);

          strAutIncHISENT := fNextAutoIncrem(strAutIncHISENT);
        End;
      End
      Else
        fAtualizaTabelaAux(cdsPedidos.FieldByName('CODITE').AsString, 'REFUGO_S', blnEntradaDeMercadorias); //Marca Como baixada em Refugo.

      If (Not Result) Then
        Break;

      If (cdsPedidos.FieldByName('QTDBAI').AsFloat <= 0.0) Then
      Begin
        cdsPedidos.Next;
        Continue;
      End;

      If Assigned(objEmbala) Then
        Result := Result And objEmbala.fConverteItemPedidoUnidadeVenda(cdsPedidos.FieldByName('AUTINC').AsString,
                                                                       cdsPedidos.FieldByName('CODITE').AsString);

      Result := Result And
                fAtualizaDadosPcmDet(cdsPedidos.FieldByName('QTDBAI').AsFloat + cdsPedidos.FieldByName('EXCESS').AsFloat,
                                     cdsPedidos.FieldByName('UNITAR').AsFloat,
                                     cdsPedidos.FieldByName('NUMPED').AsString,
                                     cdsPedidos.FieldByName('CODEMP').AsString,
                                     cdsPedidos.FieldByName('AUTINC').AsString,
                                     IIF(fEmptyStr(strAutEle), '', strCodFor),
                                     strCnvEmb,
                                     Not fEmptyStr(strAutEle),
                                     blnSaldoPendente,
                                     blnLibPcm,
                                     strForFil,
                                     intDEQTPC);

      If (Not Result) Then
        Break;

      cdsPedidos.Next;

      If Assigned(pgbDados) Then
      Begin
        pgbDados.StepBy(1);
        Application.ProcessMessages;
      End
    End; {While (Not cdsPedidos.Eof)                                    And
          (strPedAnt = cdsPedidos.FieldByName('NUMPED').AsString) And
          (strEmpAnt = cdsPedidos.FieldByName('CODEMP').AsString) Do}

    If (Not Result) Then
      Break;

    Result := Result And fBaixaPcmDet(strPedAnt, strEmpAnt, strNumdoc, strEspDoc, strSerie, blnSaldoPendente);

    {*****************************************}
    {* SE OCORRER UM ERRO, SAI               *}
    {**************************************MV*}
    If Not Result Then
      Break;

    {*****************************************}
    {* BAIXA O PCMGER                        *}
    {**************************************MV*}
    Result := Result And fBaixaPcmGer(Not fEmptyStr(strAutEle), strPedAnt, strEmpAnt, strNumdoc, strEspDoc);

    {*****************************************}
    {* SE OCORRER UM ERRO, SAI               *}
    {**************************************MV*}
    If Not Result Then
      Break;

  End; {While (oleItensPedidos <> Null) And (Not cdsPedidos.Eof) Do}

End;

function fBaixaPedidos(oleItensPedidos : oleVariant; cdsPedidos : TUniClientDataSet;
                       blnEntradaDeMercadorias : Boolean = True):Boolean;
  Var
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodFor,
    strSerie,
    strAutEle : String;
    objEmbala: TEntEmbalagens;
Begin
  objEmbala := Nil;
  Result := fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos, strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, strAutEle,
                                   objEmbala, blnEntradaDeMercadorias);
End;

function fZeraDataEntrada(ValidacaoZeraData: TValidacaoZeraData): Boolean;
begin
  If ValidacaoZeraData.TipoCFOP  =  tcCFOP922 Then
     Exit(False);

  Result := ValidacaoZeraData.blnConferenciaDepoisDaEntrada;

  Result := Result And (ValidacaoZeraData.strTipFor <> 'M');

  Result := Result And (Not ValidacaoZeraData.blnDevolu);

  Result := Result And (Not ValidacaoZeraData.blnDevolu);
  Result := Result And (Not ValidacaoZeraData.blnRecCliGarantia);
  Result := Result And (Not ValidacaoZeraData.blnConEqu);
  Result := Result And (Not ValidacaoZeraData.AblnAcessadoViaRetornoConsignacao);
  Result := Result And (Not ValidacaoZeraData.blnRetornoSimbolico);
  Result := Result And (Not ValidacaoZeraData.blnUtilizarCFG_CLARET);
  Result := Result And (Not ValidacaoZeraData.blnImpNFEEntradaRetFor);

  {IF PARA VERIFICAR SE TRABALHA COM PLANO DE RECEBIMENTO E SE O DOCUMENTO POSSUI ALGUM ITEM PARA ENDEREÇAR; CASO NÃO POSSUA, O DOCUMENTO JÁ SERÁ REGISTRADO COMO EFETIVADO.}
  If Result And
    (ValidacaoZeraData.blnConferenciaDepoisDaEntrada) And
    (ValidacaoZeraData.blnUtilizaColetorCFG_TPLREC)   And
    (ValidacaoZeraData.blnGeraEnderecamento) Then
      Result := (ValidacaoZeraData.blnTemItemParaEnderecar);
End;



procedure pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque(strSeqGer: String; blnVaiGerarEnderecamentoDepois_ou_JaGerou: Boolean);
var qryConsulta, qryComand: TUniQuery;
begin
  If Not fCfgSis('FXRESS', varBoolean) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT MOVGER.AUTOINCREM, MOVRCD.RCD_QTDITE,');
    qryConsulta.SQL.Add('       MOVDET.DET_QTDITE, OSX.FDO_SEQFDO,');
    qryConsulta.SQL.Add('       FDO_CODITE,');
    qryConsulta.SQL.Add('       FDO_CODEMP,');
    qryConsulta.SQL.Add('       (SELECT SUM(BAI_QTDREQ)');
    qryConsulta.SQL.Add('          FROM BAIREQ');
    qryConsulta.SQL.Add('         WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM ) TOTAL_REQ_BAIXADA,');
    qryConsulta.SQL.Add('       IFNULL((SELECT SUM(EXT_QTDATD) FROM RREEXT WHERE EXT_SEQDOR = OSD.AUTOINCREM), 0) + MOVDET.DET_QTDITE  AS  TOTAL_REQ_ATENDIDA');
    qryConsulta.SQL.Add('  FROM MOVGER');
    qryConsulta.SQL.Add(' INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM');
    qryConsulta.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ');
    qryConsulta.SQL.Add(' INNER JOIN BAIREQ ON BAI_AUTDET = MOVDET.AUTOINCREM');
    qryConsulta.SQL.Add(' INNER JOIN MOVRCD ON MOVRCD.AUTOINCREM =  BAI_AUTREQ');
    qryConsulta.SQL.Add(' INNER JOIN FATGOR OS ON OS.FGO_NUMDOC = RCD_DOCPDV');
    qryConsulta.SQL.Add('                     AND OS.FGO_CODEMP = RCD_EMPPDV');
    qryConsulta.SQL.Add('                     AND OS.FGO_ESPDOC = RCD_ESPPDV');
    qryConsulta.SQL.Add(' INNER JOIN FATDOR OSD ON OSD.FDO_SEQGER = OS.AUTOINCREM AND OSD.FDO_CODITE = MOVDET.DET_CODITE');
    qryConsulta.SQL.Add(' INNER JOIN EXTDOR OSX ON OSX.FDO_SEQFDO = OSD.AUTOINCREM AND  FDO_RESERV = "N"');

    qryConsulta.SQL.Add(' WHERE MOVGER.AUTOINCREM = "'+strSeqGer+'"');
    If blnVaiGerarEnderecamentoDepois_ou_JaGerou Then
      qryConsulta.SQL.Add('  AND ITE_REAEND = "N" ');

    qryConsulta.Open;



    If not qryConsulta.IsEmpty Then
    Begin
      qryComand := fCriaQuery;

      try
        qryConsulta.First;
        while not qryConsulta.Eof do
        begin
          If RoundTo(qryConsulta.FieldByName('RCD_QTDITE').AsFloat,-2) =
             RoundTo(qryConsulta.FieldByName('TOTAL_REQ_ATENDIDA').AsFloat, -2) Then
          begin
            qryComand.SQL.Clear;
            qryComand.SQL.Add('UPDATE EXTDOR SET FDO_RESERV = "S"');
            qryComand.SQL.Add(' WHERE FDO_SEQFDO = "'+qryConsulta.FieldByName('FDO_SEQFDO').AsString+'"');
            qryComand.ExecSQL;
            qryComand.SQL.Clear;
            qryComand.SQL.Add('UPDATE ITEGER SET ITE_REPAUD = "S"');
            qryComand.SQL.Add(' WHERE ITE_CODITE = "'+qryConsulta.FieldByName('FDO_CODITE').AsString+'"');
            qryComand.SQL.Add('   AND ITE_CODEMP = "'+qryConsulta.FieldByName('FDO_CODEMP').AsString+'"');
            qryComand.ExecSQL;
          end;

          qryComand.SQL.Clear;
          qryComand.SQL.Add('INSERT INTO RREEXT(EXT_SEQDOR, EXT_SEQGER, EXT_QTDATD) VALUES ');
          qryComand.SQL.Add('                  (:EXT_SEQDOR, :EXT_SEQGER, :EXT_QTDATD)');
          qryComand.ParamByName('EXT_SEQDOR').AsString := qryConsulta.FieldByName('FDO_SEQFDO').AsString;
          qryComand.ParamByName('EXT_SEQGER').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
          qryComand.ParamByName('EXT_QTDATD').AsFloat  := qryConsulta.FieldByName('DET_QTDITE').AsFloat;

          qryComand.ExecSQL;

          qryConsulta.Next;
        end;
      Finally
        freeAndNil(qryComand);
      end;
    end;

  Finally
    FreeAndNil(qryConsulta);
  End;
end;


procedure pCarregaRefTribItemEntrada(qryItem: TDataSet; Var objRef: TMovDetParams);
begin
  objRef.Init;

  If Not Assigned(qryItem.FindField('ENT_REFCST')) Then
    Exit;

  objRef.strRefCodCst := Trim(qryItem.FieldByName('ENT_REFCST').AsString);
  objRef.strRefClaTri := qryItem.FieldByName('ENT_REFCLA').AsString;
  objRef.fltRefValOpe := qryItem.FieldByName('ENT_REFVBC').AsFloat;
  objRef.fltRefBasCal := qryItem.FieldByName('ENT_REFVBC').AsFloat;
  objRef.fltRefCbsAlq := qryItem.FieldByName('ENT_RFCALQ').AsFloat;
  objRef.fltRefCbsAlD := qryItem.FieldByName('ENT_RFCALD').AsFloat;
  objRef.fltRefCbsVlD := qryItem.FieldByName('ENT_RFCVLD').AsFloat;
  objRef.fltRefCbsAlR := qryItem.FieldByName('ENT_RFCALR').AsFloat;
  objRef.fltRefCbsVlT := qryItem.FieldByName('ENT_RFCVLT').AsFloat;
  objRef.fltRefCbsAlE := qryItem.FieldByName('ENT_RFCALE').AsFloat;
  objRef.fltRefCbsVal := qryItem.FieldByName('ENT_RFCVAL').AsFloat;
  objRef.fltRefIbsUfA := qryItem.FieldByName('ENT_RFIUFA').AsFloat;
  objRef.fltRefIbsUfD := qryItem.FieldByName('ENT_RFIUFD').AsFloat;
  objRef.fltRefIbsUvD := qryItem.FieldByName('ENT_RFIUVD').AsFloat;
  objRef.fltRefIbsUfR := qryItem.FieldByName('ENT_RFIUFR').AsFloat;
  objRef.fltRefIbsUfT := qryItem.FieldByName('ENT_RFIUFT').AsFloat;
  objRef.fltRefIbsUfE := qryItem.FieldByName('ENT_RFIUFE').AsFloat;
  objRef.fltRefIbsUfV := qryItem.FieldByName('ENT_RFIUFV').AsFloat;
  objRef.fltRefIbsMnA := qryItem.FieldByName('ENT_RFIMNA').AsFloat;
  objRef.fltRefIbsMnD := qryItem.FieldByName('ENT_RFIMND').AsFloat;
  objRef.fltRefIbsMvD := qryItem.FieldByName('ENT_RFIMVD').AsFloat;
  objRef.fltRefIbsMnR := qryItem.FieldByName('ENT_RFIMNR').AsFloat;
  objRef.fltRefIbsMnT := qryItem.FieldByName('ENT_RFIMNT').AsFloat;
  objRef.fltRefIbsMnE := qryItem.FieldByName('ENT_RFIMNE').AsFloat;
  objRef.fltRefIbsMnV := qryItem.FieldByName('ENT_RFIMNV').AsFloat;
  objRef.fltRefValIbs := qryItem.FieldByName('ENT_RFIVAL').AsFloat;
  objRef.strRefSelCst := Trim(qryItem.FieldByName('ENT_RFSCST').AsString);
  objRef.strRefSelCla := qryItem.FieldByName('ENT_RFSCLA').AsString;
  objRef.fltRefSelBas := qryItem.FieldByName('ENT_RFSBAS').AsFloat;
  objRef.fltRefSelAlq := qryItem.FieldByName('ENT_RFSALQ').AsFloat;
  objRef.fltRefSelVal := qryItem.FieldByName('ENT_RFSVLR').AsFloat;
  objRef.strRefCstReg := Trim(qryItem.FieldByName('ENT_RFRCST').AsString);
  objRef.strRefClaReg := qryItem.FieldByName('ENT_RFRCLA').AsString;
  If Not fEmptyStr(objRef.strRefCstReg) Then
    objRef.strRefTriReg := 'S';
  objRef.fltRefAiuReg := qryItem.FieldByName('ENT_RFRUFA').AsFloat;
  objRef.fltRefTiuReg := qryItem.FieldByName('ENT_RFRUVT').AsFloat;
  objRef.fltRefAimReg := qryItem.FieldByName('ENT_RFRUMA').AsFloat;
  objRef.fltRefTimReg := qryItem.FieldByName('ENT_RFRUMT').AsFloat;
  objRef.fltRefCbsReg := qryItem.FieldByName('ENT_RFRUCA').AsFloat;
  objRef.fltRefTcbReg := qryItem.FieldByName('ENT_RFRUCB').AsFloat;
end;

function fConfirmaEntradaMercadorias(Var strSeqGer: String;
                                     Var strListaItens: String;
                                     var ArrCteMov: TArrCteMov;
                                     var blnGravouMovDet: Boolean;
                                     Out blnGerouLotDePreco: Boolean;
                                     strTipFor: string;
                                     blnNotImport: Boolean;
                                     objAtuFor: TAlteraFornecedorEntrada;
                                     cdsDefBaixa: TDefineBaixaPedido;
                                     arrLinDigCodbar: TarrLinDigCodbar;
                                     fltCotDol,
                                     fltFreNot: Double;
                                     strCodOpe,
                                     strCndPag,
                                     strPorBai,
                                     strCodCta,
                                     strCodFor,
                                     strCodFaz,
                                     strNumDoc,
                                     strEspDoc: String;
                                     dtaDtaEnt,
                                     dtaDtaDoc,
                                     dtaIcmAnt: TDateTime;
                                     strSerie,
                                     strEstFor,
                                     strVeiBol,
                                     strDeposi,
                                     strEspVol: String;
                                     fltQtdVol: Double;
                                     fltAlqFor: Double;
                                     pgbDados: TProgressBar;
                                     strCodEve: String;
                                     blnDevolu: Boolean;
                                     strCodDig,
                                     strCodRep: String;
                                     blnGraFin,
                                     blnImprCP: Boolean;
                                     strHisCtp: String;
                                     fltTotPis,
                                     fltTotCof,
                                     fltBasPis,
                                     fltBasCof,
                                     fltAlqPis,
                                     fltAlqCof: Double;
                                     strCodCon: String;
                                     oleItensPedidos: OleVariant;
                                     strOrdIte,
                                     strNomeForm: String;
                                     blnCarPro: Boolean;           // Se carregou itens do pedido de compra
                                     strAutEle: String;            // AUTOINCREM DA NOTA FISCAL ELETRONICA
                                     strModFre,                    // Mod. Frete
                                     str_Chave,                    // Chave NFE
                                     strCodOco: String;            // Motivo da Devolução
                                     qryEntMer: TDataSet;           // Query com os Itens da Entrada de Mercadoria
                                     objVendor: TEntVendor;
                                     objOutDes: TEntOutrasDespesas;
                                     cdsCtpDet: TUniClientDataSet;
                                     Var strAutIncCadFis : String;
                                     Var arrDuplicata: TarrDuplicata;
                                     objEmbala: TEntEmbalagens;
                                     dtsCadFis: TDataSet;
                                     strDocFre: String;                 // Conhecimento de frete
                                     fltConFre: Double;                 // Conhecimento de frete
                                     strNumAde: String;                 // Número do AD
                                     intCtpCon: Longint;
                                     Out strAutIncMovGer: string;
                                     fltPesBru: Double = 0;
                                     fltPesLiq: Double = 0;
                                     strNaoAtu: String = '';
                                     fltVAntFr: Double = 0; // Valor de Antecipação do Conhecimento
                                     fltBAntFr: Double = 0; // Base de Antecipação do Conhecimento
                                     blnGarantia: Boolean = False;
                                     blnRecCliGarantia: Boolean = False;
                                     cdsMovGad: TUniClientDataSet = Nil;
                                     arrDocOri: TStringArrayArray = Nil; //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                     blnPedFilialGarantia: Boolean = False;
                                     blnConEqu: Boolean = False; //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                     blnDescIncond: Boolean = False; //Desconto Incondicional
                                     blnFreIpi: Boolean = False;
                                     blnPrecoPraticado: Boolean = False;
                                     frmVinculoBaixaEntregaFuturaEdocVenda: TfrmVinculoBaixaEntregaFuturaEdocVenda = nil;
                                     blnUtilizarCFG_CLARET: boolean = False;
                                     strBcoFor: String = '';
                                     strCodMod: String = '';
                                     objEntAuto: TEntradaAutomatizada = Nil;
                                     strCompet: String = '';
                                     arrClienteConsumidor: TStringArray = nil;
                                     onBeforeConfirma : TGenericProcedure = nil;
                                     onAfterConfirma  : TGenericProcedure = nil;
                                     tpFinalidadeXML: tpeFinalidadeXML = xmlEntradaMercadoria;
                                     frmEntRetencaoNotaServico: TfrmEntRetencaoNotaServico = nil;
                                     AblnAcessadoViaRetornoConsignacao : Boolean = False;
                                     ATipoRetornoConsignacao : tTipoRetornoConsignacao = ttrImportacaoXML;
                                     strExtFul: String = '';
                                     strCodExt: String = '';
                                     blnRetornoSimbolico: Boolean = False;
                                     objEmissaoNotaEspecial : TEmissaoNotaEspecial =nil;
                                     strEmpresaDeposito: String = '';
                                     blnEncargosNoFrete: Boolean = False;
                                     TipoCFOP: TTipoCFOP = tcCFOPNormal;
                                     blnFornJaAtualizado: Boolean = False;
                                     blnEhAbastecimentoDeposito: Boolean = False;
                                     blnGerarContasAPagarx117: Boolean = False;
                                     strCodCondicaoPagamentoClienteDevolucao: String = '';
                                     blnPrevis: Boolean = False): Boolean;
var

    stlPedidosGarantia : TStringList;
    strNumPedGarantia,
    strEmpPedGarantia : String;
    intIndexGarantia  : Integer;

    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;

    blnATPVMB: TarrATPVMB;

    intDecUni: Integer;

    blnUltPis: Boolean;
    blnCtpBol: Boolean;

    strCodVe2: String;

    fltSalRef,
    fltSalRet,
    fltSalRefRetRestante,

    fltIcmMed,
    fltValAux,
    fltPerRep,
    fltPerCom,
    fltTotCom,
    fltVlrCom,
    fltTotCo2,
    fltTotExt,
    //Totais da comissao acumulado
//    fltTotComGeral,
    fltVlrComGeral,
//    fltTotCo2Geral,
    fltTotExtGeral: Double;

    blnAtuMed,
    blnAtuUlt,
    blnMedSe2: Boolean;

    fltBasIpi: Double;
    fltTotIpi: Double;
    fltBaEIpi: Double;
    fltToEIpi: Double;
    fltBasIcm: Double;
    fltTotIcm: Double;
    fltValRet: Double;
    fltBasRet: Double;
    fltAlERet: Double;
    fltVaeRet: Double;
    fltBaeRet: Double;
    fltValAnt: Double;
    fltBasAnt: Double;
    fltDesEsp: Double;
    fltTotIte: Double;
    fltValFre: Double;
    fltVlrCon: Double;
    fltDesAce: Double;
    fltAlqRet: Double;
    fltTotCus: Double;
    fltTotCu2: Double;
    fltTotMed: Double;
    fltVal_RT: Double;
    fltUniImp: Double;
    fltPreMed: Double;
    fltPreUlt: Double;
    fltTotUlt: Double;
    fltImpUlt: Double;
    fltPreUltImp: Double;

    fltDesOpe : Double;
    fltIcmSai : Double;
    fltImpFed : Double;
    fltOutVal : Double;

    strAutInc: String;
    strAutCpl: String;
    strSQL: String;
    strUpdIte: String;
    strCodEmp: String;
    strEmpresas: String;

    {******************************************}
    {* VARIÁVEIS PARA BAIXA DE CONTAS A PAGAR *}
    {***************************************MV*}
    strHisBai: String;
    strCtaBai: String;
    strDocBai: String;
    strOpeBai: String;

    dtaDtaPag: TDateTime;
    fltValPag: Double;

    strSeqLan: String;
    strCodPor: String;
    strEmpBai: String;

    blnSaldoPendente: Boolean;
    blnContribuinteIPI: Boolean;
    blnAlteraPrecos: Boolean;
    blnBaixaCTPAVista: Boolean;
    intContador: Integer;

    blnUsaLotePrecos,
    blnMostrarTodosLote,
    blnAtpRen,
    blnAtuFre: Boolean;
    blnAtuSub: Boolean;

    blnAtuTCI: Boolean;
    BlnAtu_TS: Boolean;

    blnAtuIcm: Boolean;
    blnDedIcm: Boolean;
    strAtuNMD: String;
    strPedAnt: String;
    strEmpAnt: String;
    strClaFis: String;
    strNatOpe: String;
    strNatOpeCadFis: String;
    strClaFisDet: String;
    strAutIncTmp: String;
    strAutIncProAca: String;
    strHistorico: String;
    strHistoricoCred: String;
    strOldAutoincrem: String;
    strForCli: String;
    strCodCmp: String;

    fltPreCom: Double;
    fltPreComAux: Double;
    fltComLot: Double;
    fltPreCus: Double;
    fltCusLot: Double;
    recPrecos: TarrPrecos;
    recPreLot: TarrPrecos;
    intTabPre: Integer;
    blnFilKar: Boolean;
    blnFilFul: Boolean;
    objCluFid: TCluFid;
    cpcParams: TParCalculaPrecoCusto;
    objComPro: TComPro;
    qryGen   : TUniQuery;
    strCodPro: String;
    fltBcaMin: Double;
    fltBcaCom: Double;
    fltQtdPon: Double;
    fltComiss: Double;
    fltPreComOri: Double;
    strIncGau: String;

    qryGenMer: TUniQuery;
    qryConIte: TUniQuery;

    fltSaldosPreMed: Double;

    cdsPedidos: TUniClientDataSet;

    objCadLot: TCadLot;

    fltPrvPad: Double;
    blnAltPre: Boolean;
    blnAltLot: Boolean;
    blnInfMat: Boolean;
    blnAtuPis: Boolean;
    blnAtuDIC,
    blnSepICM: Boolean;

    intDEQTPC,
    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    objLotePrecos: TLotePrecos;

    blnConferenciaDepoisDaEntrada,
    blnGerouPagAnt: Boolean;

    strOriPro: String;
    strNomeArquivo,
    strNumLot: String;

    fltIcmDes,
    fltDesPis,
    fltTotDoc: Double;
    fltUniOri: Double;
    fltUniVis: Double;

    fltBFCPST: Double;
    fltVFCPST: Double;

    arrDuplicVend: TArrDigDuplicArray;
    arrDuplicRepr: TArrDigDuplicArray;

    fltVlIva0: Double;
    fltVlIva5: Double;
    fltVIva10: Double;

    strAutIncLOTPRE,
    strAutIncPREMED,
    strAutIncMovDet,
    strTabDocOriDev: String;

    strLinha,
    strHistoricoRentecao,
    strTabPre,
    strTabela: String;

    CalcResult: TResultPisCofins;
    tmp: TCalculoPisCofins;
    fltPisAlq: Double;
    fltCofAlq: Double;

    recServicos: TDadosServicos;

    objGarant       : TMovGag;

    blnLibPcm: Boolean;

    intESTFLJ: Integer;

    strNumPed_Out,
    strCodEmp_Out,
    strEspDoc_Out,
    strEmpGar,
    strSimPau,
    strForFil,
    strNumPedVen    : String;
    strCodCliPed    : String;
    strAutIncPed    : String;
    strAutIncPedDet : String;

    strProBriDev: String;
    fltPonBriDev: Double;

    fltValorFreteCalc,
    fltValorFreConCalc: Double;

    arrItensDev: TArrItensDevolucao;

    fltTotBasPis: Double;
    fltTotAlqPis: Double;
    fltTotBasCof: Double;
    fltTotAlqCof: Double;
    fltValorFundoCombateAPobreza: Double;
    fltAlqPisCofPreUlt: Double;

    blnAchouDevolucao: Boolean;

    objFazenda: TDadosFazenda;

    blnDocumentoGeraEnderecamento,
    blnAtpRau,
    blnAtuali: Boolean;

    strInfAdFisco,
    strCnvEmb,
    strCodCom,
    strCodVenGag : String;

    blnOutDesEntraNoprecoCompra: Boolean;
    blnOutDesNoFreIte: Boolean;

    objLote : TCadLot;
    blnTemLot : Boolean;
    strNumLotVen : String;
    blnAtualizouPreco: Boolean;
    blnAtualizouPrecoMedio: Boolean;

    lstBanCtp : TBanCtpRepository;

    objAtuOcoCrm : TAtuOcoCrm;
    qryAuxRetFor : TUniQuery;
    qryInsRetFor : TUniQuery;
    strClaRet: String;
    blnRefEnt,
    blnOpeGad : Boolean;

    blnTintaBaixada : Boolean;

    blnUtiAbI: Boolean;
    strCSTIpi,
    strEnqIpi: String;

    strMedEmp: String;
    strEmpMeds: String;
    strAgrupadorPreAlt: String;

    intQtdeItensLotPre : Integer;

    stlPedidosCompra: TStringList;
    strClaFisBonificacao: String;

    arrDuplic : TarrDuplicata;

    arrDupGer : TarrDuplicata;

    LObjRetornoConsignacaoBuilder : TRetornoConsignacaoBuilder;
    LstrMensagem : String;

    ValidacaoZeraData: TValidacaoZeraData;

    intSeqCon : integer;
    strOpcDocEnt : String;
    blnVaiGerarEnderecamentoDepois: Boolean;
    fltRpaFre: Double;

    fltVaeIpiTmp,
    fltAleIpiTmp,
    fltBaeIpiTmp,
    fltPremedAtu,
    fltPreUltOriginal,
    fltPreImpUltOriginal: Double;

    strSeqDetOriginal: String;
    blnMarcaProAca,
    blnCadLoc: Boolean;
    objFulfillmentRegrasMovimentacaoEstoque: FulfillmentRegrasMovimentacaoEstoque;
    strNatCfo: String;

    strIdeDig: String;
    blnDeveGerarDigCon: Boolean;
    lDistribuicaoConferencia : TDistribuicaoConferencia;
    objRefIte: TMovDetParams;
    arrLivFisRT: TArrLivFis;
    pArrLivFisRT: PArrLivFis;
    intBlocoRT: Integer;
    strBlocoRT: String;
    fltTotCbsRT: Double;
    fltTotIbsRT: Double;
    fltTotIsRT: Double;
    fltTotProIsRT: Double;
    fltTotNfRT: Double;
    qryTotRT: TUniQuery;
    LstlCesBas: TStringList;
    strTB01RE: String;
    strTB06RE: String;

    blnNumSer,
    blnEntEnd: Boolean;

    strSONCEE: String;
    LCodEveCTP: String;

    function fTemPedido: Boolean;
      Var
        strBmk: TBookmark;
    begin
      Result := False;
      strBmk := qryEntMer.Bookmark;
      Try
        qryEntMer.First;
        While Not qryEntMer.Eof Do
        Begin
          If Not fEmptyStr(qryEntMer.FieldByName('ENT_NUMPED').AsString) Then
          Begin
            Result := True;
            Break;
          End;
          qryEntMer.Next;
        End;
      Finally
        qryEntMer.Bookmark := strBmk;
      End;
    end;

    function fIndValido: Boolean;
    begin
      Result := (intContador <= Length(arrDuplicVend)-1);
    end;

    {*************************************************************************}
    {* SE FOR UMA ENTRADA CARREGANDO UMA NOTA ELETRONICA OU                  *}
    {* SEJA UMA DEVOLUCAO DE MERCADORIAS (CLIENTE) E                         *}
    {* UTILIZA CONFERENCIA NA ENTRADA DE MERCADORIAS QUE SEJA PELA PRE-NOTA  *}
    {**********************************************************************JC*}
    function fDocumentoGeraEnderecamento: Boolean;
      var blnMarmore: Boolean;
    begin
      Result := True;
      If Not fEmptyStr(strEmpresaDeposito) Then
      Begin
        Result := False;
        Exit;
      End;
      If blnRetornoSimbolico Then
        Exit(False);
      If Pos(qryEntMer.FieldByName('ENT_CLAFIS').AsString, '1922_2922_') > 0 Then
      begin
        Result := False;
        Exit;
      End;

      If (blnUtilizarCFG_CLARET) and (Pos(qryEntMer.FieldByName('ENT_CLAFIS').AsString, strClaRet) > 0) Then
      Begin
        Result := False;
        Exit;
      End;

      If (strTipFor = 'M') Then
      Begin
        Result := False;
        Exit;
      End;

      blnMarmore := False;
      If (Not Assigned(objEntAuto)) Then
        blnMarmore := (fCfgSis('MARMOR', varBoolean) And (fTemMamoreNaEntrada));

      If (Not blnMarmore) And (Not fCfgSis('ENTEND', varBoolean)) Then
         Exit(False);

      if (AblnAcessadoViaRetornoConsignacao) and (Pos(qryEntMer.FieldByName('ENT_CLAFIS').AsString, fTransform(fCfgSis('CLADSC'), 4)) > 0) then
        Exit(False);

      If (blnDevolu) And (Not fCfgSis('DEVEND', varBoolean)) And (Not fUsaRotinaWMS) Then
        Exit(False);

      If Not blnMarmore Then
      Begin
        Result := (blnGarantia And fUsaEnderecamento);
        If Not Result Then
          Result := ((fCfgSis('USACON', varBoolean)) And (Pos(fCfgSis('CONFME'), '1_3_') > 0));
      End;

      //Se for entrada de mercadorias pelo recebimento de garantia, nao deve endereçar pois o movimento já é gravado para o lote principal de garantia.
      //Varejo car req. 81052
      If blnRecCliGarantia Then
        Exit(False);

      {*************************************************************************************************************}
      {* QUANDO USA ROTINA WMS SEMPRE DEVE ENDERECAR OS PRODUTOS, POIS SOMENTE PERMITE LOTE "A DEFINIR" NA ENTRADA *}
      {**********************************************************************************************************JC*}
      {* Quando a conferência é apos a entrada de mercadorias, então não deve-se reservar o estoque, pois a        *}
      {* mercadoria ainda nao chegou na empresa, toda movimentaçao fiscal é gravada sem data de entrada. A reserva *}
      {* sera realizada depois do planejamento do armazenamento                                                    *}
      {**********************************************************************************************************GB*}
      If fUsaRotinaWMS Then
      Begin
        If blnConferenciaDepoisDaEntrada And (not blnDevolu) Then
        begin
          Result := False;
          blnVaiGerarEnderecamentoDepois := True;
        End
        Else
          Result := True;
      End
      Else If blnConferenciaDepoisDaEntrada Then
      Begin
        Result := (blnDevolu And fCfgSis('DEVEND', varBoolean)) Or blnGarantia Or blnConEqu;
        If Not Result Then
          blnVaiGerarEnderecamentoDepois := True;
      End;

      If Result And fEmptyStr(fRetNomCliente(fCadEmp('CLIFIL'))) then
        Raise Exception.Create('Para gerar pedido de reserva é preciso informar o código do cliente filial no cadastro da empresa!');
    end;

    function fGravarCtpDet: Boolean;
    begin
      Result := False;
      If (Not blnDevolu) {And (strCodCta = fCfgSis('CTAPRI'))} Then
      Begin
        If Assigned(cdsCtpDet) Then
        Begin
          If Not cdsCtpDet.Active Then
            cdsCtpDet.Open;

          Result := (cdsCtpDet.RecordCount > 0);
        End;
      End;
    end;

    procedure pGravarCtpDet(strParcel: String);
      Var
        qryInsert: TUniQuery;
        strAutIncCtpDet: String;
    begin
      qryInsert := fCriaQuery;

      qryInsert.SQL.Add('INSERT INTO ');
      qryInsert.SQL.Add('  CTPDET ');
      qryInsert.SQL.Add('( ');
      qryInsert.SQL.Add('  CTP_NUMDUP, ');
      qryInsert.SQL.Add('  CTP_PARCEL, ');
      qryInsert.SQL.Add('  CTP_SERIE_, ');
      qryInsert.SQL.Add('  CTP_CODEMP, ');
      qryInsert.SQL.Add('  CTP_CODFOR, ');
      qryInsert.SQL.Add('  CTP_CODCTA, ');
      qryInsert.SQL.Add('  CTP_EMPORI, ');
      qryInsert.SQL.Add('  CTP_FATCAL, ');
      qryInsert.SQL.Add('  CTP_CODEVE, ');
      qryInsert.SQL.Add('  AUTOINCREM ');
      qryInsert.SQL.Add(') VALUES ( ');
      qryInsert.SQL.Add('  :NUMDUP, ');
      qryInsert.SQL.Add('  :PARCEL, ');
      qryInsert.SQL.Add('  :SERIE_, ');
      qryInsert.SQL.Add('  :CODEMP, ');
      qryInsert.SQL.Add('  :CODFOR, ');
      qryInsert.SQL.Add('  :CODCTA, ');
      qryInsert.SQL.Add('  :EMPORI, ');
      qryInsert.SQL.Add('  :FATCAL, ');
      qryInsert.SQL.Add('  :CODEVE, ');
      qryInsert.SQL.Add('  :AUTINC) ');

      If Not cdsCtpDet.Active Then
        cdsCtpDet.Open;

      If Assigned(objEntAuto) Then
        strAutIncCtpDet := fRetAutoIncrem('CTPDET', VS_strCodEmp, cdsCtpDet.RecordCount)
      Else
        strAutIncCtpDet := '';

      cdsCtpDet.First;

      While (Not cdsCtpDet.Eof) Do
      Begin
        qryInsert.ParamByName('NUMDUP').AsString := fStrZero(strNumDoc, 12);
        qryInsert.ParamByName('PARCEL').AsString := strParcel;
        qryInsert.ParamByName('SERIE_').AsString := strSerie;
        qryInsert.ParamByName('CODEMP').AsString := cdsCtpDet.FieldByName('CTP_CODEMP').AsString;
        qryInsert.ParamByName('CODFOR').AsString := strCodFor;
        qryInsert.ParamByName('CODCTA').AsString := cdsCtpDet.FieldByName('CTP_CODCTA').AsString;
        qryInsert.ParamByName('EMPORI').AsString := VS_strCodEmp;
        qryInsert.ParamByName('FATCAL').AsFloat  := cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat;
        qryInsert.ParamByName('CODEVE').AsString := cdsCtpDet.FieldByName('CTP_CODEVE').AsString;

        If fEmptyStr(qryInsert.ParamByName('CODEVE').AsString) Then
          qryInsert.ParamByName('CODEVE').Clear;

        If fEmptyStr(strAutIncCtpDet) Then
        Begin

          qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);

        End Else
        Begin
          qryInsert.ParamByName('AUTINC').AsString := strAutIncCtpDet;
          strAutIncCtpDet := fNextAutoIncrem(strAutIncCtpDet);
        End;

        qryInsert.ExecSQL;

        cdsCtpDet.Next;
      End;

      FreeAndNil(qryInsert);
    end;

    function fItem(strCampo: String): TField;
    begin
      If Assigned(objEntAuto) Then
      Begin

        If SameText('CODFOR', strCampo) Then
          Result := objEntAuto.cdsItens.FieldByName('ENT_FORITE')
        Else
          Result := objEntAuto.cdsItens.FieldByName('ENT_' + strCampo)

      End Else
        Result := qryConIte.FieldByName('ITE_' + strCampo);
    end;

    function fHouveAlteracaoComposicaoPreco: Boolean;
      Var
        intAux, intAuxFinal: Integer;
    begin
      Result := (blnAtuFre And ((fFormataFloat(fItem('FREENT').AsFloat, 3) <> fFormataFloat(qryEntMer.FieldByName('ENT_FREENT').AsFloat, 3)) Or
                                (fFormataFloat(fItem('VALFRE').AsFloat, 3) <> fFormataFloat(qryEntMer.FieldByName('ENT_FREITE').AsFloat, 3)))) Or
                (fFormataFloat(fItem('PRECOM').AsFloat,3) <> fFormataFloat(IIF(blnUsaLotePrecos,fltComLot, fltPreCom), 3)) Or
                (fFormataFloat(fItem('PRECUS').AsFloat, 3) <> fFormataFloat(IIF(blnUsaLotePrecos,fltCusLot, fltPreCus), 3));

      If Not Result Then
      Begin
        If blnUsaLotePrecos Then
          intAuxFinal := Length(recPreLot)
        Else
          intAuxFinal := Length(recPrecos);

        For intAux := 1 To intAuxFinal Do
        Begin
          If (VS_strTabPrc[intAux] = 'S') Then
          Begin
           If (fFormataFloat(fItem('PREVE' + IntToStr(intAux)).AsFloat, 4) <> fFormataFloat(IIF(blnUsaLotePrecos,recPreLot[intAux].fltPreVen,recPrecos[intAux].fltPreVen), 4)) Or
              (fFormataFloat(fItem('MARBR' + IntToStr(intAux)).AsFloat, fRetPrecisaoMargemItem) <> fFormataFloat(IIF(blnUsaLotePrecos,recPreLot[intAux].fltMarBru,recPrecos[intAux].fltMarBru), fRetPrecisaoMargemItem)) Then
            Begin
              Result := True;
              Break;
            End;
          End;
        End;
      End;

    end;

    procedure pCalculaQuantidadePontosPromocaoBrindes;
      Var
        item: TDadosFechamento;
    begin
      strProBriDev := '';
      fltPonBriDev := 0.00;

      If blnDevolu Then
      Begin
        With item, qryEntMer Do
        Begin
          strDocDev := FieldByName('ENT_NUMPED').AsString;
          strEspDev := FieldByName('ENT_ESPDOC').AsString;
          strEmpDev := FieldByName('ENT_CODEMP').AsString;
          strSeqDet := FieldByName('ENT_AUTVEN').AsString;
          fltQtdIte := FieldByName('ENT_QTDITE').AsFloat;
        End;

        TPromocaoBrindes.pRetornaQuantidadePontosProdutoDevolucao(item);

        strProBriDev := item.strProBri;
        fltPonBriDev := item.fltPonBri;
      End;
    end;

    procedure pAdicionarItemDevolvidoArray(strAutIncMovDet: String);
    begin
      SetLength(arrItensDev, Length(arrItensDev) + 1);

      With arrItensDev[Length(arrItensDev) - 1] Do
      Begin
        strDocumento        := qryEntMer.FieldByName('ENT_NUMPED').AsString;
        strEspecie          := qryEntMer.FieldByName('ENT_ESPDOC').AsString;
        strEmpresa          := qryEntMer.FieldByName('ENT_CODEMP').AsString;
        strCliente          := qryEntMer.FieldByName('ENT_CODFOR').AsString;
        strProduto          := qryEntMer.FieldByName('ENT_CODITE').AsString;
        strAutIncVenda      := qryEntMer.FieldByName('ENT_AUTVEN').AsString;
        strAutIncDevolucao  := strAutIncMovDet;
        fltQuantidade       := qryEntMer.FieldByName('ENT_QTDITE').AsFloat;
        fltTotalItem        := qryEntMer.FieldByName('ENT_TOTITE').AsFloat;
        fltDescontoEspecial := qryEntMer.FieldByName('ENT_DESESP').AsFloat;
      End;

    end;

    function fGravaMovModDevolucao: Boolean;
      Var
        qryAux: TUniQuery;
        strCodMod: String;

      function fGravaMovMod: Boolean;
      Begin
        Result := untMovGer.fGravaMovMod(strNumDoc,
                                         strEspDoc,
                                         VS_strCodEmp,
                                         strCodFor,
                                         strSerie,
                                         strCodMod,
                                         fltVlrCon,
                                         '',
                                         fltVlrCon);
      End;
    Begin
      Try
        qryAux := fCriaQuery;

        With qryAux Do
        Begin
          SQL.Clear;
          SQL.Add('DELETE FROM MOVMOD ');
          SQL.Add('WHERE ');
          SQL.Add('  MOD_NUMDOC = :NUMDOC AND ');
          SQL.Add('  MOD_ESPDOC = :ESPDOC AND ');
          SQL.Add('  MOD_CODEMP = :CODEMP AND ');
          SQL.Add('  MOD_CODCLI = :CODCLI AND ');

          If fEmptyStr(strSerie) Then
              SQL.Add('  ((MOD_SERIE_ IS NULL) OR (MOD_SERIE_ = ""))')
          Else
            SQL.add('  MOD_SERIE_ = :SERIE_ ');

          ParamByName('NUMDOC').AsString := strNumDoc;
          ParamByName('ESPDOC').AsString := strEspDoc;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ParamByName('CODCLI').AsString := strCodFor;

          If Not fEmptyStr(strSerie) Then
            ParamByName('SERIE_').AsString := strSerie;

          ExecSQL;
        End;

        If fCfgSis('USAFPG', VarBoolean) Then
        Begin
          If (fStatusCndPag(strCndPag) = A_VISTA) Or (Not fCfgSis('USACND', VarBoolean)) Then
          Begin
            strCodMod := '001';
            Result := fGravaMovMod;
          End
          Else
          Begin
            strCodMod := '008';
            Result := fGravaMovMod;
          End;
        End
        Else
          Result := True;
      Finally
        FreeAndNil(qryAux);
      End;
    End;
    procedure pDeletaDocumento_TabelaDEL;
      var
         qryGenGer: TUniQuery;
    begin
      Try

        qryGenGer := fCriaQuery(Nil);
        qryGenGer.SQL.Add('DELETE FROM DEL_MOVGER ');
        qryGenGer.SQL.Add('WHERE ');
        qryGenGer.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
        qryGenGer.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
        qryGenGer.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ AND ');
        qryGenGer.SQL.Add('  GER_CODEMP = :CODEMP AND ');

        If (blnDevolu) Or (blnRecCliGarantia) or (AblnAcessadoViaRetornoConsignacao) Then
          qryGenGer.SQL.Add('  GER_CODCLI = :CODFOR ')
        Else
          qryGenGer.SQL.Add('  GER_CODFOR = :CODFOR ');

        qryGenGer.ParamByName('NUMDOC').AsString := strNumDoc;
        qryGenGer.ParamByName('ESPDOC').AsString := strEspDoc;
        qryGenGer.ParamByName('SERIE_').AsString := strSerie;
        qryGenGer.ParamByName('CODEMP').AsString := strCodEmp;
        qryGenGer.ParamByName('CODFOR').AsString := strCodFor;
        qryGenGer.ExecSQL;

      Finally
        FreeAndNil(qryGenGer)
      End;
    end;

    Function fBaixaPedidosEntrada: Boolean;
      Var
        intContador: Integer;
        strNumPed, strEmpPed: String;
    Begin
      Result := True;
      {FZERADATAENTRADA(VALIDACAOZERADATA): SE TRUE, O DOCUMENTO SERÁ EFETIVADO POSTERIORMENTE E O PEDIDO SERÁ BAIXADO NA EFETIVAÇÃO; }
      {                                    SE FALSE, É NECESSÁRIO BAIXAR O PEDIDO DE COMPRA, POIS O DOCUMENTO JÁ ENTRARÁ EFETIVADO    }
      If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) Then
      Begin
        If oleItensPedidos <> Null Then
        Begin
          Result := Result And fBaixaPedidosEmbalagem(oleItensPedidos, cdsPedidos, strNumDoc, strEspDoc, strCodEmp,
                                                      strCodFor, strSerie, strAutEle, objEmbala, True {blnEntradaDeMercadorias : Boolean = True}, pgbDados);


        End Else
        Begin

          For intContador := 0 To stlPedidosCompra.Count - 1 Do
          Begin
            strNumPed := LeftStr(stlPedidosCompra[intContador], 12);
            strEmpPed := RightStr(stlPedidosCompra[intContador], 3);

            Result := Result And fBaixaPcmDet(strNumPed, strEmpPed, strNumdoc, strEspDoc, strSerie, blnSaldoPendente);

            If Not Result Then
              Break;

            Result := Result And fBaixaPcmGer(Not fEmptyStr(strAutEle), strNumPed, strEmpPed, strNumdoc, strEspDoc);

           If Not Result Then
              Break;
          End;

        End;

      End;

      If Result Then
      For intContador := 0 To stlPedidosCompra.Count - 1 Do
      Begin
        strNumPed := LeftStr(stlPedidosCompra[intContador], 12);
        strEmpPed := RightStr(stlPedidosCompra[intContador], 3);

        If fCfgSis('UTLPRJ', varBoolean) And blnDevolu Then
          TProjeto.pRecalculaVendas(strNumPed,
                                    'PD',
                                    strEmpPed);
      End;

    End; {For intContador := 0 To stlPedidosCompra.Count - 1 Do}

    function fEnt_FreRpaE: Double;
    begin
      if Assigned(qryEntMer.FindField('ENT_FRERPA')) then
        Result := qryEntMer.FieldByName('ENT_FRERPA').AsFloat
      else
        Result := 0;
    end;

    function fHistoricoDocDevSelecionado(pstrNumDoc, pstrEspDoc, pstrCodEmp: String; pfltValor: Double): String;
      CONST
        RES_MSG: String = 'REF. DEV. No.: %s-%s-%s, %s no valor total de R$ %s';
      Var
        Qry: TUniQuery;
        strSQL: String;
        lstrNumDoc: String;
        lstrDocSel: String;

    begin
      lstrNumDoc := fStrZero(pstrNumDoc, 12);
      Result := EmptyStr;
      lstrDocSel := EmptyStr;

      strSQL :=          ' SELECT GROUP_CONCAT(A.NUMDOC) AS "DOCUMENTOS" ';
      strSQL := strSQL + ' FROM (SELECT DISTINCT CONCAT(ENT_NUMPED,"-", ENT_ESPDOC,"-", ENT_CODEMP) AS "NUMDOC" ';
      strSQL := strSQL + '       FROM TMP_ENTMER) A ';

      Try
        Qry := fCriaQuery;
        Qry.Close;
        Qry.Sql.Clear;
        Qry.SQL.Add(strSQL);
        Qry.Open;
        if Not Qry.IsEmpty then
        begin
          if Not fEmptyStr(Qry.FieldByName('DOCUMENTOS').AsString) then
            lstrDocSel := ' REF.DOC.:' + Qry.FieldByName('DOCUMENTOS').AsString + ',';
        end;

        Result := Format(RES_MSG,[lstrNumDoc,
                                  pstrEspDoc,
                                  pstrCodEmp,
                                  lstrDocSel,
                                  FormatFloat('###,##0.000', fltVlrCon)]) ;

      Finally
        if Assigned(Qry) then
          FreeAndNil(Qry);
      End;
    end;

    function fCesBasItem(const AstrCodIte: String): String;
      Var
        intPos: Integer;
    begin
      If (Not Assigned(objEntAuto)) And Assigned(qryConIte) And qryConIte.Active And
         (qryConIte.FieldByName('ITE_CODITE').AsString = AstrCodIte) Then
        Exit(qryConIte.FieldByName('ITE_CESBAS').AsString);

      intPos := LstlCesBas.IndexOfName(AstrCodIte);
      If intPos >= 0 Then
        Exit(LstlCesBas.ValueFromIndex[intPos]);

      Result := VarToStr(fCampoTabela('ITE_CESBAS', 'CADITE', ['ITE_CODITE'], [AstrCodIte]));
      LstlCesBas.Add(AstrCodIte + '=' + Result);
    end;
  Var
    stlUpdates: TStringList;
begin
  blnDeveGerarDigCon := False;
  SetLength(ArrMarcaProAcaEndere, 0);
  blnMarcaProAca := False;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;

  if Assigned(objOutDes) then
    fltRpaFre := objOutDes.fTotalFreteRpa
  else
    fltRpaFre := 0.00;

  blnGravouMovDet := False;
  blnAtualizaForPed:= blnFornJaAtualizado;
  If (Not Assigned(arrClienteConsumidor)) Then
    SetLength(arrClienteConsumidor, 11);

  intESTFLJ := StrToIntDef(fCfgSis('ESTFLJ'), 1);
  FillChar(arrDupGer, Sizeof(arrDupGer) , #0);

  intQtdeItensLotPre := 0;
  blnGerouLotDePreco := False;

  blnUtiAbI := fCfgSis('UTIABI', varBoolean);

  strNatOpeCadFis := EmptyStr;

  Result := True;
  LstlCesBas := TStringList.Create;
  Try
    If Not (tpFinalidadeXML in [xmlCFG_IMPXGRGarantiaRetFornecedor]) Then
      pPreAltDefineVariaveisAltPre(fNow, 'ENTRADA DE MERCADORIAS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    if Assigned(onBeforeConfirma) then
        onBeforeConfirma();

    stlPedidosCompra := TStringList.Create;

    stlPedidosCompra.Duplicates := dupIgnore;
    stlPedidosCompra.Sorted := True;


    For intTabPre := 1 to 7 Do
      blnAtpVmb[intTabPre] := (fCfgSis( IIF( intTabPre = 1, 'ATPVMB', 'ATPVM' + IntToStr(intTabPre) )) = 'P');

    blnConferenciaDepoisDaEntrada := fConferenciaDepoisDaEntrada And (Not fEmptyStr(strAutEle)) And fEmptyStr(strEmpresaDeposito);

    If (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor]) Then
      blnConferenciaDepoisDaEntrada := False;

    
    If Not blnDevolu Then
      blnPrecoPraticado := False;

    If blnUtilizarCFG_CLARET Then
       strClaRet := fTransform(fCfgSis('CLARET'), 4);

    strForFil := fRetForFilialTodos;

    fltIcmDes := 0;
    fltDesPis := 0;
    fltDesOpe := 0;
    fltIcmSai := 0;
    fltImpFed := 0;
    fltOutVal := 0;
    fltTotCus := 0;
    fltTotCu2 := 0;

    strEmpMeds := fEmpresasMedEmp;

    strMedEmp := fCfgSis('MEDEMP', varString);
    blnAtpRen := fCfgSis('ATPREN', varBoolean);
    blnAtuMed := fCfgSis('ATUMED', varBoolean);
    blnAtuUlt := fCfgSis('ATUULT', varBoolean);
    blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
    blnAtuFre := fCfgSis('ATUFRE', varBoolean);
    blnAtuSub := fCfgSis('ATUSUB', varBoolean);

    blnAtuTCI  := fCfgSis('ATUTCF', varBoolean);
    BlnAtu_TS  := fCfgSis('ATU_TS', varBoolean);

    blnAtuIcm := fCfgSis('ATUICE', varBoolean);
    blnInfMat := fCfgSis('INFMAT', varBoolean);

    blnAtuPis := fCfgSis('ATUPIS', varBoolean) And fSeparaICMDesoneradoDoDesconto;
    blnAtuDIC := fCfgSis('ATUDIC', varBoolean) And fSeparaICMDesoneradoDoDesconto;

    blnSepICM := fSeparaICMDesoneradoDoDesconto;

    blnLibPcm := fCfgSis('LIBPCM', varBoolean);

    intInfFed := fCfgSis('INFFED', varInteger);
    intInfOpe := fCfgSis('INFOPE', varInteger);
    intInfSai := fCfgSis('INFSAI', varInteger);

    intDEQTPC := fCfgSis('DEQTPC', varInteger);

    intDecUni := fCfgSis('DECUNI', varInteger);

    blnAtpRau := fCfgSis('ATPRAU', varBoolean);
    strCnvEmb := fCfgSis('CNVEMB');
    strSimPau := IIf((fCfgSis('SIMPAU',varString) = 'S') and (fCfgSis('IGNSIM') = '1'), 'S', 'N') ;

    blnRefEnt := fCfgSis('REFENT', varBoolean);

    strEmpGar := fCfgSis('EMPGAR', varString);

    blnAtuali := blnAtpRau Or Assigned(objAtuFor);

    SetLength(arrItensDev, 0);

    VS_strTCoPro := fCfgSis('TCOPRO');

    strAtuNMD := fCfgSis('ATUNMD');

    If (Pos(strCodFor, strForFil) > 0) Then
      blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnUltPis := fCfgSis('ULTPIS', VarBoolean);

    If (Pos(strCodFor, strForFil) > 0) Then
      blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnDedIcm := fCfgSis('DEDICM', VarBoolean);


    strOriPro := fCfgSis('ORIPRO');

    blnCtpBol := fCfgSis('CTPBOL', varBoolean);

    blnCadLoc := fCfgSis('CADLOC', varBoolean);
    blnNumSer := fCfgSis('NUMSER', varBoolean);
    blnEntEnd := fCfgSis('ENTEND', varBoolean);
    strSONCEE := fCfgSis('SONCEE', varString);

    fltComiss := 0;
    If (blnDevolu) Then
      objComPro := TComPro.Create(Nil);

    pInicializaImpressaoCP;

    {**********************************}
    {* CASO FOR NFE EFETUA A BAIXA    *}
    {*******************************JB*}
    If Not fEmptyStr(strAutEle) Then
    Begin
      If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp) Then
      Begin
        Result := FALSE;
        Exit;
      End;
    End;

    cpcParams  := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

    qryGenMer  := fCriaQuery;
    qryConIte  := fCriaQuery;
    cdsPedidos := TUniClientDataSet.Create(nil);

    objCadLot := TCadLot.Create(nil);

    stlPedidosGarantia := TStringList.Create;
    If oleItensPedidos <> Null Then
    Begin
      cdsPedidos.Data := oleItensPedidos;
      cdsPedidos.IndexFieldNames := 'NUMPED;CODEMP;CODITE';
      cdsPedidos.Filtered := False;
      cdsPedidos.First;

      While Not cdsPedidos.Eof Do
      Begin

        if (stlPedidosGarantia.IndexOf(cdsPedidos.FieldByName('NUMPED').AsString + ';' + cdsPedidos.FieldByName('CODEMP').AsString) < 0) Then
          stlPedidosGarantia.Add(cdsPedidos.FieldByName('NUMPED').AsString + ';' + cdsPedidos.FieldByName('CODEMP').AsString);

        cdsPedidos.Next;
      End;
      cdsPedidos.First;
    End;

    Try
      strCodVe2 := '';
      fltPerCom := 0;
      fltPerRep := 0;
      fltVlrCom := 0;
      fltTotExt := 0;
      fltTotCom := 0;
      fltTotCo2 := 0;

//      fltTotComGeral := 0;
      fltVlrComGeral := 0;
//      fltTotCo2Geral := 0;
      fltTotExtGeral := 0;

      {*****************************************}
      {* PEGA DADOS INICIAIS                   *}
      {**************************************MV*}
      strCodEmp          := VS_strCodEmp;
      blnSaldoPendente   := (fCfgSis('SLPEPD', varBoolean));
      blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
      blnAlteraPrecos    := (fCfgSis('EXITCU', varBoolean));
      blnBaixaCTPAVista  := (fCfgSis('CTPAVI', varBoolean)) And (Not Assigned(objEntAuto));
      blnUsaLotePrecos   := (fCfgSis('LOTPRE', varBoolean));
      blnMostrarTodosLote:= (fCfgSis('TPLTPR', varString) = '2');

      If (Not blnDevolu) And (Not blnGarantia) And (Not blnRecCliGarantia) Then
      Begin
        If strTipFor = 'M' Then
        Begin
          blnUsaLotePrecos := False;
          blnAtpRau        := False;
          blnAtuali        := False;
          blnAtpRen        := False;
          blnAlteraPrecos  := False;
        End;

      End;
      blnVaiGerarEnderecamentoDepois := False;
      blnDocumentoGeraEnderecamento := fDocumentoGeraEnderecamento;

     If (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                             xmlDevolucaoEntradaEmitidaFornecedor]) Then
       blnDocumentoGeraEnderecamento := False;

     If blnEhAbastecimentoDeposito Then
       blnDocumentoGeraEnderecamento := False;


      strEmpresas := VS_strCodEmp;

      If (blnAlteraPrecos Or blnAtuali) And
         ( (Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
      Begin
        strEmpresas := fRetEmpresasUsamPrecoMatriz;
      End;

      Application.ProcessMessages;

      {*****************************************}
      {* CARREGA ALGUMAS INFORMAÇÕES DO CADAS- *}
      {* TRO DE ITENS                          *}
      {**************************************JB*}
      If Not Assigned(objEntAuto) Then
      Begin
        pCarregaItens(strCodEmp, qryConIte, fltCotDol);
        Application.ProcessMessages;
      End;

      fltBasIpi := 0.0;
      fltTotIpi := 0.0;

      fltBaEIpi := 0.0;
      fltToEIpi := 0.0;

      fltBasIcm := 0.0;
      fltTotIcm := 0.0;
      fltBasRet := 0.0;
      fltBasAnt := 0.0;
      fltDesEsp := 0.0;
      fltTotIte := 0.0;
      fltValFre := 0.0;
      fltVlrCon := 0.0;
      fltDesAce := 0.0;

      strHistorico := '';

      strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;

      If Assigned(objEntAuto) Then
      Begin

        objEntAuto.pRetTotaisNota(fltBasIpi, fltTotIpi, fltBaEIpi, fltToEIpi, fltBasIcm, fltTotIcm, fltValRet,
                                  fltBasRet, fltVaeRet, fltBaeRet, fltValAnt, fltBasAnt, fltDesEsp, fltTotIte,
                                  fltValFre, fltVlrCon, fltDesAce, fltBFCPST, fltVFCPST);

      End Else
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  SUM(ENT_BASIPI) AS ENT_BASIPI, ';
        strSQL := strSQL + '  SUM(ENT_VALIPI) AS ENT_VALIPI, ';

        strSQL := strSQL + '  SUM(ENT_BAEIPI) AS ENT_BAEIPI, ';
        strSQL := strSQL + '  SUM(ENT_VAEIPI) AS ENT_VAEIPI, ';

        strSQL := strSQL + '  SUM(ENT_BASICM) AS ENT_BASICM, ';
        strSQL := strSQL + '  SUM(ENT_VALICM) AS ENT_TOTICM, ';
        strSQL := strSQL + '  SUM(ENT_VALRET) AS ENT_VALRET, ';
        strSQL := strSQL + '  SUM(ENT_BASRET) AS ENT_BASRET, ';
        strSQL := strSQL + '  SUM(ENT_VAERET) AS ENT_VAERET, ';
        strSQL := strSQL + '  SUM(ENT_BAERET) AS ENT_BAERET, ';
        strSQL := strSQL + '  SUM(ENT_VALANT) AS ENT_VALANT, ';
        strSQL := strSQL + '  SUM(ENT_BASANT) AS ENT_BASANT, ';
        strSQL := strSQL + '  SUM(ENT_DESESP) AS ENT_DESESP, ';
        strSQL := strSQL + '  SUM(ENT_TOTITE) AS ENT_TOTITE, ';
        strSQL := strSQL + '  SUM(IF(ENT_VALANT > 0, ENT_TOTITE, 0)) AS ENT_TOTDAR, ';
        strSQL := strSQL + '  SUM(ENT_VALFRE) AS ENT_VALFRE, ';

        strSQL := strSQL + '  SUM(ENT_VICMDE) AS ENT_VICMDE, ';
        strSQL := strSQL + '  SUM(ENT_DESPIS) AS ENT_DESPIS, ';

        strSQL := strSQL + '  SUM(ENT_VLRCON)' + IIf(blnDescIncond, ' - SUM(ENT_DESESP)', '') + ' AS ENT_VLRCON, ';
        strSQL := strSQL + '  SUM(ENT_DESACE) AS ENT_DESACE  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  TMP_ENTMER ';

        With qryGenMer Do
        Begin

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          Open;

          fltBasIpi := FieldByName('ENT_BASIPI').AsFloat;
          fltTotIpi := FieldByName('ENT_VALIPI').AsFloat;

          fltBaEIpi := FieldByName('ENT_BAEIPI').AsFloat;
          fltToEIpi := FieldByName('ENT_VAEIPI').AsFloat;

          fltBasIcm := FieldByName('ENT_BASICM').AsFloat;
          fltTotIcm := FieldByName('ENT_TOTICM').AsFloat;
          fltValRet := FieldByName('ENT_VALRET').AsFloat;
          fltBasRet := FieldByName('ENT_BASRET').AsFloat;

          fltVaeRet := FieldByName('ENT_VAERET').AsFloat;
          fltBaeRet := FieldByName('ENT_BAERET').AsFloat;

          fltValAnt := FieldByName('ENT_VALANT').AsFloat;
          fltBasAnt := FieldByName('ENT_BASANT').AsFloat;

          fltDesEsp := FieldByName('ENT_DESESP').AsFloat;
          fltTotIte := FieldByName('ENT_TOTITE').AsFloat;
          fltValFre := FieldByName('ENT_VALFRE').AsFloat;
          fltVlrCon := FieldByName('ENT_VLRCON').AsFloat;
          fltDesAce := FieldByName('ENT_DESACE').AsFloat;

          fltIcmDes := FieldByName('ENT_VICMDE').AsFloat;
          fltDesPis := FieldByName('ENT_DESPIS').AsFloat;
        End;
      End;

      With qryEntMer Do
      Begin

        {**********************************************}
        {* ATUALIZA A QUANTIDADE DE ITENS NA ENTRADA, *}
        {* CONFORME A QUANTIDADE DE EMBALAGENS        *}
        {*******************************************JC*}
        If (strCnvEmb <> 'N') and (not blnDevolu) And (not AblnAcessadoViaRetornoConsignacao) And (Not Assigned(objEntAuto)) Then
        Begin
          pConverteQtdItensEmb;
        End;
                                  {*Qualquer tipo de garantia nao muda preço*}
        If blnUsaLotePrecos And ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) And (Not Assigned(objEntAuto)) And (Not blnRetornoSimbolico) Then
        Begin
          pAtualizaPercentuaisSubstituicaoFreteDoItem(blnAtuTCI, blnAtu_TS, blnAtuSub, blnAtuFre, blnAtuIcm, blnFreIpi, blnencargosNoFrete, blnNotImport,fltFreNot,
            (fltConFre + fltRpaFre),  blnOutDesNoFreIte);
        End

        Else If ((blnAtuFre Or blnAtuSub Or blnAtuIcm) And blnAtuali) And
                ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) And (Not Assigned(objEntAuto)) Then
        Begin
          pAtualizaPercentuaisSubstituicaoFreteDoItem(blnAtuTCI, blnAtu_TS, blnAtuSub, blnAtuFre, blnAtuIcm, blnFreIpi, blnencargosNoFrete, blnNotImport, fltFreNot, (fltConFre + fltRpaFre), blnOutDesNoFreIte);
        End;

        If Assigned(objEntAuto) Then
        Begin

          objEntAuto.pSetaAutoincremMovDet;

        End Else
        Begin

          With TUniQuery(qryEntMer) Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM TMP_ENTMER ');
            If Not fEmptyStr(strOrdIte) Then
              SQL.Add('ORDER BY ' + strOrdIte);

            Open;
          End;

          If blnUsaLotePrecos Then
            strAutIncLOTPRE := fRetAutoIncrem('LOTPRE', strCodEmp, qryEntMer.RecordCount);

          strAutIncPREMED := fRetAutoIncrem('PREMED', strCodEmp, qryEntMer.RecordCount);

          strAutIncMovDet := fRetAutoIncrem('MOVDET', strCodEmp, qryEntMer.RecordCount);
          qryEntMer.First;

          stlUpdates := TStringList.Create;

          While Not qryEntMer.Eof Do
          Begin
            strOldAutoincrem := qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;

            If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
              frmVinculoBaixaEntregaFuturaEdocVenda.pAtualizarAutoincrem(strOldAutoincrem, strAutIncMovDet);

            If Assigned(cdsDefBaixa) Then
              cdsDefBaixa.pAtualizaAutoincrem(qryEntMer.FieldByName('AUTOINCREM').AsString, strAutIncMovDet);

            stlUpdates.Add('UPDATE TMP_ENTMER SET AUTOINCREMENTO_GRAVACAO = ' + QuotedStr(strAutIncMovDet) +
                          ' WHERE AUTOINCREM = ' +  qryEntMer.FieldByName('AUTOINCREM').AsString + ';');

            qryEntMer.Next;

            strAutIncMovDet := fNextAutoIncrem(strAutIncMovDet);
          End;

          TUniQuery(qryEntMer).Close;
          TUniQuery(qryEntMer).SQL.Text := stlUpdates.Text;
          TUniQuery(qryEntMer).ExecSQL;

          FreeAndNil(stlUpdates);

          With TUniQuery(qryEntMer) Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM TMP_ENTMER ORDER BY ENT_CODITE');//Ordena os itens por codigo para evitar deadlock com gravacoes do faturamento
            Open;
          End;

        End;

        strClaFis := FieldByName('ENT_CLAFIS').AsString;

        If fEmptyStr(FieldByName('ENT_NATOPE').AsString) Then
          strNatOpe := fCampoTabela('NAT_DESCRI', 'NATCFO', ['NAT_CODCFO'], [strClaFis])
        Else
          strNatOpe := FieldByName('ENT_NATOPE').AsString;

        strNatCfo := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO', 'NAT_DESCRI'], [strClaFis, strNatOpe]);

        If Assigned(pgbDados) Then
        Begin
          pgbDados.Visible := True;
          pgbDados.Max := RecordCount + 10;
          pgbDados.Max := pgbDados.Max + IIF(SameText(strEspDoc, 'NF'), 10, 0);

          If (oleItensPedidos <> Null) And cdsPedidos.Active Then
            pgbDados.Max := pgbDados.Max + cdsPedidos.RecordCount;

          Application.ProcessMessages;
        End

        Else If Assigned(objEntAuto) Then
        Begin
          objEntAuto.cxProgressoAuto.Properties.Max := RecordCount + 10 + IIF(SameText(strEspDoc, 'NF'), 10, 0);
        End;

        If Not fEmptyStr(strCodFaz) And blnDevolu And fCfgSis('CADFAZ', VarBoolean) Then
        Begin
          objFazenda := TDadosFazenda.Create;
          objFazenda.strCodCli := strCodFor;
          objFazenda.strCodFaz := strCodFaz;
          objFazenda.pCarregarDadosFazenda;
        End;


        If blnDevolu Then
        Begin
          strOpcDocEnt := 'DE';
        End
        Else
        Begin
          strOpcDocEnt := IfThen(tpFinalidadeXML = xmlRetornoLocacao,'DL','EM');
        End;

        ValidacaoZeraData.blnConferenciaDepoisDaEntrada := blnConferenciaDepoisDaEntrada;
        ValidacaoZeraData.blnDevolu                     := blnDevolu;
        ValidacaoZeraData.blnRecCliGarantia             := blnRecCliGarantia;
        ValidacaoZeraData.blnConEqu                     := blnConEqu;
        ValidacaoZeraData.AblnAcessadoViaRetornoConsignacao := AblnAcessadoViaRetornoConsignacao;
        ValidacaoZeraData.blnRetornoSimbolico           :=  blnRetornoSimbolico;
        ValidacaoZeraData.strTipFor                     :=  strTipFor;
        ValidacaoZeraData.TipoCfop                      :=  TipoCFOP;
        ValidacaoZeraData.blnUsaRotinaWMS               :=  fUsaRotinaWMS;
        ValidacaoZeraData.blnUtilizarCFG_CLARET         :=  blnUtilizarCFG_CLARET;
        ValidacaoZeraData.blnUtilizaColetorCFG_TPLREC   := (fCfgSis('TPLREC', varString) <> 'N');
        ValidacaoZeraData.blnGeraEnderecamento          := (blnDocumentoGeraEnderecamento Or blnVaiGerarEnderecamentoDepois);
        ValidacaoZeraData.blnTemItemParaEnderecar       :=  fTemItemMarcadoParaFazerEnderecamento(qryEntMer);
        ValidacaoZeraData.blnImpNFEEntradaRetFor        :=  tpFinalidadeXML in [xmlCFG_IMPXGRGarantiaRetFornecedor];
        blnDeveGerarDigCon := Not fZeraDataEntrada(ValidacaoZeraData);

        fltTotCbsRT := 0;
        fltTotIbsRT := 0;
        fltTotIsRT  := 0;
        fltTotProIsRT := 0;
        fltTotNfRT  := 0;
        If Assigned(dtsCadFis) And dtsCadFis.Active And Assigned(dtsCadFis.FindField('FIS_VLCBST')) Then
        Begin
          fltTotCbsRT := dtsCadFis.FieldByName('FIS_VLCBST').AsFloat;
          fltTotIbsRT := dtsCadFis.FieldByName('FIS_VLIBST').AsFloat;
          fltTotIsRT  := dtsCadFis.FieldByName('FIS_VL_IST').AsFloat;
          If Assigned(dtsCadFis.FindField('FIS_TPROIS')) Then
            fltTotProIsRT := dtsCadFis.FieldByName('FIS_TPROIS').AsFloat;
        End;
        If (Not fEmptyStr(strAutEle)) And ((fltTotCbsRT + fltTotIbsRT + fltTotIsRT) > 0) And fTabelaExiste('GERERT', True) Then
        Begin
          qryTotRT := fCriaQuery;
          Try
            qryTotRT.SQL.Text := 'SELECT W16_VNFTOT FROM GERERT WHERE AUTOINCREM = ' + QuotedStr(strAutEle);
            qryTotRT.Open;
            If Not qryTotRT.IsEmpty Then
              fltTotNfRT := qryTotRT.FieldByName('W16_VNFTOT').AsFloat;
          Finally
            FreeAndNil(qryTotRT);
          End;
        End;

        Result := Result And
          fGravaMovGer(strAutInc,                       // Auto Incremento (Retorno)
                       strNumDoc,                       // Numero Documento
                       strEspDoc,                       // Espécie
                       strCodEmp,                       // Empresa
                       '',                              // Transportadora
                       strCodOpe,                       // Vendedor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, '', strCodFor),   // Fornecedor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, strCodFor, ''),   // Cliente
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, 'C', 'F'),        // Tipo ((C)liente / (F)ornecedor)

                       IIF(fZeraDataEntrada(ValidacaoZeraData), 0, dtaDtaEnt), // Data da Entrada
                       IIF(fZeraDataEntrada(ValidacaoZeraData), 0, fTime()),   // Hora da Entrada

                       dtaDtaDoc,                       // Data do Documento
                       strCndPag,                       // Condição de Pagamento
                       strEstFor,                       // Estado do Cliente / Fornecedor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[0] , ''), // [0] GER_NOMCON - Nome do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[1] , ''), // [1] GER_ENDCON - Endereço do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[2] , ''), // [2] GER_BAICON - Bairro do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[3] , ''), // [3] GER_CEPCON - Cep do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[4] , ''), // [4] GER_CIDCON - Cidade do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[5] , ''), // [5] GER_ESTCON - Estado do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[6] , ''), // [6] GER_TELCON - Telefone do Consumidor
                       0,                                                                           //                  Nascimento do consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[8] , ''), // [8] GER_CGCCPF - CNPJ / CGC
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[7] , ''), // [7] GER_CGCCON - CNPJ / CGC do consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[9] , ''), // [9] GER_IESCON - Inscrição estadual do Consumidor
                       IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, arrClienteConsumidor[10], ''), // [10]GER_R_GCON - RG do Consumidor
                       0.0,                             // Base Simples Paulista
                       fltBasIpi,                       // Base de IPI
                       0.0,                             // Aliquota de IPI
                       fltTotIpi,                       // Total de IPI
                       fltBasIcm,                       // Base de ICMS
                       0.0,                             // Aliquota de ICMS
                       fltTotIcm,                       // Total de ICMS
                       fltValRet,                       // Valor de Substituição
                       0.0,
                       0.0,                             // Aliquota de Substituição
                       fltBasRet,                       // Base de Substituição
                       fltDesEsp,                       // Desconto Especial
                       fltVlrCon,                       // Valor Contábil
                       fltTotIte,                       // Total dos Itens
                       0.0,                             // Total de Custo
                       0.0,                             // Total Médio
                       strModFre,                       // Tipo de Frete
                       fltValFre,                       // Valor do Frete
                       fltPesBru,                       // Peso Bruto
                       fltPesLiq,                       // Peso Liquido
                       fltQtdVol,                       // Volume
                       strEspVol,                       // Especie
                       '',                              // Marca
                       '',                              // Mensagem 1
                       '',                              // Mensagem 2
                       '',                              // Mensagem 3
                       '',                              // Mensagem 4
                       '',                              // Mensagem 5
                       False,                           // Indica se Faturado ou nao
                       '',                              // Tipo de Faturamento
                       '',                              // Numero de Faturamento
                       '',                              // Empresa do Faturamento
                       0,                               // Data de Faturamento
                       '',                              // Vendedor do Faturamento
                       '',                              // Condição de Pagamento do Faturamento
                       False,                           // Devolução Especial
                       0.0,                             // Valor do Faturamento
                       0.0,                             // Valor Parcela 01
                       0.0,                             // Valor Parcela 02
                       0.0,                             // Valor Parcela 03
                       0.0,                             // Valor Parcela 04
                       0.0,                             // Valor Parcela 05
                       0.0,                             // Valor Parcela 06
                       0.0,                             // Valor Parcela 07
                       0.0,                             // Valor Parcela 08
                       0.0,                             // Valor Parcela 09
                       0.0,                             // Valor Parcela 10
                       0.0,                             // Valor Parcela 11
                       0.0,                             // Valor Parcela 12
                       arrDupGer,                       // arrDuplic
                       strSerie,                        // Série
                       'N',                             // Nota Especial
                       strClaFis,                       // Classificação Fiscal
                       '',                              // Classificação Fiscal 2
                       '',                              // Classificação Fiscal 3
                       strNatOpe,                       // Natureza da Operação
                       0.0,                             // Percentual de Desconto
                       strCodDig,                       // Código do Digitador
                       '',                              // Codigo da Condição
                       '',                              // Forma de Pagamento
                       0.0,                             // Fator para meia nota
                       recServicos,
                       fltDesAce,                       // Despesa Acessória
                       IIF((blnRecCliGarantia) Or (blnConEqu), '', IIF(blnGarantia,'G', IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, 'D', ''))), // Origem do Documento - (D)evolução / (E)ntrada / (V)enda
                       'N',                             // Usa controle de entrega
                       strCodRep,                       // Representante
                       0.0,                             // Aliquota do IRPF (SERVIÇO)
                       0.0,                             // Valor do IRPF (SERVIÇO + PRODUTO)
                       0.0,                             // Aliquota do Pis (SERVIÇO)
                       0.0,                             // Valor do Pis (SERVIÇO + PRODUTO)
                       0.0,                             // Aliquota do Cofins (SERVIÇO)
                       0.0,                             // Valor do Cofins (SERVIÇO + PRODUTO)
                       0.0,                             // Aliquota do CSLL (SERVIÇO)
                       0.0,                             // Valor do CSLL (SERVIÇO + PRODUTO)
                       0.0,                             // Valor de IRPF que foi retido
                       0.0,                             // Valor de PIS que foi retido
                       0.0,                             // Valor de COFINS que foi retido
                       0.0,                             // Valor de CSLL que foi retido
                       '',                              // Notas de Documentos Acumulados
                       0.0,                             // Aliquota do IRPF (PRODUTOS)
                       0.0,                             // Aliquota do PIS (PRODUTOS)
                       0.0,                             // Aliquota do COFINS (PRODUTOS)
                       0.0,                             // Aliquota do CSLL (PRODUTOS)
                       0.0,                             // Valor de SERVIÇO que foi retido
                       '',                              // Notas de documentos acumulados (SERVIÇO)
                       0.0,                             // Percentual da Seguridade Social
                       0.0,                             // Valor da Seguridade Social
                       0.0,                             // Valor do IRPF Retido (Produto)
                       0.0,                             // Valor do IRPF Devido (Produto)
                       0.0,                             // Valor do IRPF Retido (Serviço)
                       0.0,                             // Valor do IRPF Devido (Serviço)
                       0.0,                             // Valor do PIS Retido (Produto)
                       0.0,                             // Valor do PIS Devido (Produto)
                       0.0,                             // Valor do PIS Retido (Serviço)
                       0.0,                             // Valor do PIS Devido (Serviço)
                       0.0,                             // Valor do COFINS Retido (Produto)
                       0.0,                             // Valor do COFINS Devido (Produto)
                       0.0,                             // Valor do COFINS Retido (Serviço)
                       0.0,                             // Valor do COFINS Devido (Serviço)
                       0.0,                             // Valor do CSLL Retido (Produto)
                       0.0,                             // Valor do CSLL Devido (Produto)
                       0.0,                             // Valor do CSLL Retido (Serviço)
                       0.0,                             // Valor do CSLL Devido (Serviço)
                       '',                              // Ordem de Produção
                       0.0,                             // Base Orgão Público
                       0.0,                             // ICMS Orgão Público
                       0,                               // Número do Conhecimento de Frete
                       '',                              // Consumidor final
                       'N',                             // Entrega no Faturamento
                       '',                              // CLiente de faturamento
                       '',                              // Operador da Expedição
                       '',                              // Separador da Expedição
                       '',                              // Tabela de preços utilizada
                       '',
                       'N',                             // Entrega Futura
                       FALSE,                          // Baixa de Entrega Futura
                       0,                               // Margem de Lucro
                       0.0,                             // Base do retido (caso tivesse) com ipi e frete de entrada
                       0.0,                             // Valor do retido considerando a base acima.
                       'N',
                       '',
                       VS_Date,                        // Data de Entrega no Romaneio
                       '',                             // Classificação fiscal 4
                       'N',                            // AUTO-SERVIÇO
                       '',                             //Codigo do Evento
                       '',                             // AUTINC ENDEREÇO DE ENTREGA
                       fRetInfCpl(strAutEle, strInfAdFisco),  // Conteúdo do CNFNFE
                       strCodOco,                      // Motivo da Devolução
                       '',
                       True,                           // Imprime Duplicatas na NF-e
                       0,               //fltValCre
                       0,               //dtadtlBex
                       '',              //strEmlCon
                       0,               //dtaDtESNf
                       0,               //tmrHrESNf
                       Nil,             //bjFinanc
                       strDocFre,       //Conhecimento de frete
                       '',              //srCodObr
                       '',              //strCodObr
                       'N',             //strPermut
                       '',              //strRetIss
                       strOpcDocEnt,    //strOpcDoc
                       0,               //fltFreSug
                       strNumAde,       //Número do AD
                       fltBasAnt,       //BASE DE ICMS ANTECIPADO
                       fltValAnt,       //VALOR DE ICMS ANTECIPADO
                       strNaoAtu,       // "S" SE MARCOU PARA NAO ATUALIZAR OS PREÇOS AUTOMATICAMENTE
                       '',              //strEntUrg
                       '',              //strMenExp
                       '',              //strMenEx2
                       '',              //strMenEx3
                       '',              //strMenEx4
                       0 ,              //fltDupRec
                       0 ,              //fltValAdt
                       0 ,              //fltDeDVCf
                       '',              //strPlaVei
                       '',              //strKm_Vei
                       '',              //strCliOri
                       '',              //strCodMot
                       '',              //strBetone
                       '',              //strLacre_
                       '',              //strTipMps
                       '',              //strAbatim
                       '',              //strBrita_
                       '',              //strConBom
                       0,               //intFckDia
                       0,               //fltImpPag
                       0,               //intPrzMed
                       False,           //blnImpPdv
                       False,           //blnDTEXREP
                       '',              //strChvNfeDev
                       '',              //strOpeSol
                       False,           //blnEst_Dv
                       '',              //strNumCOODev
                       '',              //strNumSerDev
                       '',              //strNumUSUDev
                       '',              //strTipDocDev
                       0,               //fltTotDif
                       objFazenda,      //objFazenda
                       0,               //fltFedImp
                       0,               //fltEstImp
                       0,               //fltMunImp
                       0,               //fltTroco
                       strInfAdFisco,   //strObsNfeFis
                       IIf(qryEntMer.FieldByName('ENT_VENPRE').ASString = '', 'N', qryEntMer.FieldByName('ENT_VENPRE').ASString),       //strVenPre
                       '',              //strSeqDocOri
                       blnConEqu,       //blnConEqu
                       blnDescIncond,   //blnDescIncond
                       blnGraFin,       //blnGraCTP
                       '',              //strNumera
                       '',              //strEdiPes
                        0,              //fltTaxEnt
                        0,              //fltVrdIcm
                        0,              //fltBasVrd
                        0,              //intNroBox
                       '',              //strCodEmbarcacao
                        0,              //fltTotBri
                       '',              //strTraRdp
                       '',              //strCliCtt
                       strCodMod,       //strCodMod
                       '',              //strNumGui: String = '';
                       '',              //strHisCom: String = '';
                       '',              //strCodPrj: String = '';
                       strNatCfo,       //strNatCfo: String = '';
                       '',              //strTpOper: String = '';
                       '',
                       '',
                       fltCotDol,      //fltCotMoe: Double = 0
                       0,     // fltFreMkp: Double = 0;
                       0,     // fltComMkp: Double = 0;
                       '',    // strPlaFat: String = '';
                       False, // blnDevWms: Boolean = False;
                       False, // blnFulfillmentModoRobo : Boolean = False;
                       0,     //  fltFreCot: Double = 0;
                       0,     // fltFreRat: Double = 0;
                       'N',   // strEntSim: String = 'N';
                       '',    // strSeqDmp: String = '';
                       '',    // strEntFutOpc: String = '';
                       0,     // fltTotIpiEntFut: Double = 0;
                       0,     //  fltTotRetEntFut: Double = 0;
                       0,     // fltTotFcpSTEntFut: Double = 0;
                       fltIcmDes, // fltICMDes: Double = 0;
                       fltDesPis,  // fltDesPis: Double = 0
                       '', //strOpFaEx: String = '';
                       '', //strDocAba: String = '';
                       '', //strEspAba: String = '';
                       '', //strEmpAba: String = '';
                       '', //strCliAba: String = '';
                       False, //blnColeta: Boolean = False;
                       '', //strNumeroRandomico : String = '';
                       '', //strNumeroDrawback : String = '';
                       '', //strCodFinalidadeAjuste : String = '';
                       '', //strDoc_RE: String = '';
                       '', //strEsp_RE: String = '';
                       '', //strEmp_RE: String = '';
                       '', //strCli_RE: String = '';
                       '', //strDocRE2: String = '';
                       '', //strEspRE2: String = '';
                       '', //strEmpRE2: String = '';
                       '', //strCliRE2: String = '';
                       '', //strEmp_TE: String = '';
                       '', //strAutIcv: String = '';
                       '', //strEmp_PR: String = '';
                       '', //strCliCEO: String = '';
                       0, //fltVolSepExc: Double = 0;
                       0, //fltVolSepNExc: Double = 0;
                       '', //strSupGer: String = '';
                       '', //strSupReg: String = '';
                       '', //strCelCon: String = '';
                       'N', //strAbaDep: String = 'N';
                       '', //strEmpDep: String = '';
                       '', //strAbf_Uf: String = '';
                       '', //strEstornoNotaFiscal: String = '';
                       '',
                       strTipFor,
                       '',//strVchCdp
                       '',//strCodCno
                       fltTotIbsRT,  // fltTotIbs   -> AUX_TOTIBS {Req. 410369}
                       fltTotCbsRT,  // fltTotCbs   -> AUX_TOTCBS
                       fltTotIsRT,   // fltTotIs    -> AUX_TOT_IS
                       fltTotProIsRT, // fltTotProIs -> AUX_TPROIS
                       fltTotNfRT, //fltTotNf
                       '',//strInsImo
                       ''//strCodCib
                       );

        strAutIncMovGer := strAutInc;
        If Assigned(objFazenda) Then
          FreeAndNil(objFazenda);

        {*****************************************************************}
        {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
        {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
        {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
        {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
        {**************************************************************MM*}
        If (Result) And (blnPedFilialGarantia) Then
        Begin
          strNumPedVen := fRetSequencialPedido;
          strCodCliPed := fRetornaClienteFilial(VS_strCodEmp);
          FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

          Result := fGravaFatGor(strAutIncPed,
                                 strCodEmp,
                                 strNumPedVen,
                                 'PD',
                                 strCodCliPed,
                                 strCodOpe,
                                 '',
                                 '',
                                 VS_Date,
                                 fTime(),
                                 '01000',
                                 fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCliPed)) ,1),
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 0,
                                 '',
                                 '',
                                 '',
                                 '',
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 '',
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 0,
                                 arrDuplic,
                                 '',
                                 '',
                                 'GARANTIA',
                                 '',
                                 False,
                                 '',
                                 '',
                                 '',
                                 0,
                                 '',
                                 '',
                                 0.0,
                                 0,
                                 strCodOpe,
                                 '',
                                 '',
                                 recServicos,
                                 '',
                                 0,
                                 0,
                                 0,
                                 '',
                                 '',
                                 '',
                                 0,
                                 '',
                                 0,
                                 '1',
                                 '',
                                 0,
                                 '',
                                 '',
                                 False,
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 '',
                                 False,
                                 VS_Date,
                                 'N',
                                 'V',
                                 VS_Date,
                                 '',
                                 0,
                                 '',
                                 '',
                                 '',
                                 False,
                                 '',
                                 Nil,
                                 '',
                                 '',
                                 0,
                                 0,
                                 0,
                                 '',
                                 Nil,
                                 '',
                                 0,
                                 0,
                                 '',
                                 '',
                                 0,
                                 '',
                                 0,
                                 '',
                                 '0',
                                 'N',
                                 'N');
        End;

        strSeqGer := strAutInc;

        {*****************************************}
        {* PROCESSA TABELA TEMPORARIA            *}
        {**************************************MV*}
        First;

        If Assigned(pgbDados) Then
        Begin
          Application.ProcessMessages;
          pgbDados.StepBy(10);
        End
        Else If Assigned(objEntAuto) Then
        Begin
          objEntAuto.cxProgressoAuto.Position := objEntAuto.cxProgressoAuto.Position + 10;
          Application.ProcessMessages;
        End;

        {*Qualquer tipo de garantia nao muda preço*}
        If Result
             And blnUsaLotePrecos
               And ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao))
                 And (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao,
                                               xmlDevolucaoEntradaEmitidaFornecedor,
                                               xmlCFG_IMPXGRGarantiaRetFornecedor])) Then
        Begin
          objLotePrecos := TLotePrecos.Create(Nil);
          objLotePrecos.strNumDoc := strNumDoc;
          objLotePrecos.strEspDoc := strEspDoc;
          objLotePrecos.strSerie  := strSerie;
          objLotePrecos.strCodEmp := strCodEmp;
          objLotePrecos.strCodFor := strCodFor;
        End;

        fltTotPis := 0;
        fltTotCof := 0;
        fltTotBasPis := 0;
        fltTotBasCof := 0;
        fltTotAlqPis := 0;
        fltTotAlqCof := 0;

        if fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) Then
        begin
          TControleChavesGarantia.strOpcDoc := 'NE';
          TControleChavesGarantia.strTipMod := 'E';
        end;

        While (Not Eof) And (Result) Do
        Begin
          If strClaFis = '1910' Then
            strClaFis := FieldByName('ENT_CLAFIS').AsString;

          {*****************************************}
          {* PROCESSA TABELA TEMPORARIA ENQUANTO   *}
          {* FOR O PEDIDO ANTERIOR                 *}
          {**************************************MV*}
          strPedAnt := FieldByName('ENT_NUMPED').AsString;
          strEmpAnt := FieldByName('ENT_CODEMP').AsString;

          stlPedidosCompra.Add(Concat(strPedAnt,strEmpAnt));

          While (Not Eof)                                        And
                (strPedAnt = FieldByName('ENT_NUMPED').AsString) And
                (strEmpAnt = FieldByName('ENT_CODEMP').AsString) Do
          Begin
            If RoundTo(FieldByName('ENT_QTDITE').AsFloat, -4) = 0 Then
            Begin
              Result := False;
              fRollBack;

              If strCnvEmb = 'N' Then
                pMensagemOk('A quantidade do item ' + FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString + ' está zerada!')
              Else
                pMensagemOk('A quantidade do item ' + FieldByName('ENT_CODITE').AsString + '-' + FieldByName('ENT_DESITE').AsString + ' multiplicada por sua embalagem resulta em um valor igual a zero!');

              Exit;
            End;

            {*****************************************}
            {* SE OCORRER UM ERRO, SAI               *}
            {**************************************MV*}
            If Not Result Then
              Break;

            If fEmptyStr(strListaItens) Then
              strListaItens := QuotedStr(FieldByName('ENT_CODITE').AsString)
            Else
              strListaItens := strListaItens + ', ' + QuotedStr(FieldByName('ENT_CODITE').AsString);

            {*****************************************}
            {* POSICIONA NO ITEM                     *}
            {**************************************MV*}
            If Not Assigned(objEntAuto) Then
              qryConIte.Locate('ITE_CODITE', FieldByName('ENT_CODITE').AsString, []);

    ////////////////////////////////////////////////////////////////

            {*****************************************}
            {* REALIZA CALCULO DO TOTAL DE CUSTO     *}
            {**************************************MV*}
            If blnDevolu Then
            Begin
              fltTotCus := fItem('PRECUS').AsFloat * FieldByName('ENT_QTDITE').AsFloat;

              fltTotCu2 := fltTotCus + (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat) *
                                       ((fItem('OUTVAL').AsFloat + FieldByName('ENT_ICMSAI').AsFloat + fItem('IMPFED').AsFloat + fItem('DESOPE').AsFloat) / 100);
            End
            Else
            Begin
              If strTipFor = 'M' Then
                fltTotCus := FieldByName('ENT_UNITAR').AsFloat
              Else
              Begin
                fltTotCus := fItem('PRECUS').AsFloat * FieldByName('ENT_QTDITE').AsFloat;

                If fltTotCus <= 0 Then
                Begin
                  Result := False;
                  Raise Exception.Create('O item: '+FieldByName('ENT_CODITE').AsString+' está com o seu preço de custo zerado. Corrija-o antes de prosseguir com a entrada de mercadoria.');
                End;
              End;

              fltTotCu2 := fltTotCus;
            End;

            {*****************************************}
            {* REALIZA CALCULO DO TOTAL MÉDIO        *}
            {**************************************MV*}
            fltPremedAtu := fItem('PREMED').AsFloat;
            fltPreUltOriginal := fItem('PREULT').AsFloat;
            fltPreImpUltOriginal := fItem('IMPULT').AsFloat;
            strSeqDetOriginal :=  fItem('SEQDET').AsString;


            If strTipFor = 'M' Then
              fltTotMed := 0
            Else
            Begin
              fltTotMed := fItem('PREMED').AsFloat * FieldByName('ENT_QTDITE').AsFloat;
              If CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].blnEncontrado Then
              Begin
                fltTotMed := CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].PrecoMedioAnterior * FieldByName('ENT_QTDITE').AsFloat;
                fltPremedAtu := CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].fltPreMedOriginal;
                fltPreUltOriginal := CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].fltPreUltOriginal;
                fltPreImpUltOriginal := CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].fltPreImpUltOriginal;
                strSeqDetOriginal :=  CalculoPrecoMediAgrup.CalculoPreMed[FieldByName('ENT_CODITE').AsString, ''].strSeqDetOriginal
              End;
            End;

            {*****************************************}
            {* REALIZA CALCULO DA ALIQUOTA DE SUBST. *}
            {**************************************MV*}
            fltAlqRet := 0.0;
            If FieldByName('ENT_BASRET').AsFloat > 0.0 Then
              fltAlqRet := (FieldByName('ENT_VALRET').AsFloat / FieldByName('ENT_BASRET').AsFloat) * 100;

            fltAlERet := 0.0;
            If FieldByName('ENT_BAERET').AsFloat > 0.0 Then
              fltAlERet := (FieldByName('ENT_VAERET').AsFloat / FieldByName('ENT_BAERET').AsFloat) * 100;

            blnAchouDevolucao := False;

            strTabPre := '';

            If strTipFor = 'M' Then
              fltUniOri := FieldByName('ENT_UNITAR').AsFloat
            Else
              fltUniOri := fItem('PREVE1').AsFloat;

            If (blnDevolu) Then
            Begin
              blnAchouDevolucao := fCalculaComissaoDevolucao(strNumAde, FieldByName('ENT_AUTVEN').AsString,
                                         FieldByName('ENT_TABELA').AsString,
                                         IIF(fEmptyStr(strNumAde), '', FieldByName('ENT_CODITE').AsString),
                                         FieldByName('ENT_NUMPED').AsString,
                                         FieldByName('ENT_ESPDOC').AsString,
                                         FieldByName('ENT_CODEMP').AsString,
                                         (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat),
                                         FieldByName('ENT_QTDITE').AsFloat,
                                         strTabDocOriDev,
                                         strCodOpe, strCodVe2, strCodRep, strTabPre,
                                         fltPerCom, fltTotCom, fltTotCo2,
                                         fltPerRep, fltTotExt, fltVlrCom,
                                         fltTotCus, fltTotCu2,
                                         fltOutVal,
                                         fltIcmSai,
                                         fltImpFed,
                                         fltDesOpe,
                                         fltImpUlt,
                                         fltTotUlt,
                                         fltVal_RT,
                                         fltUniOri);

              If Not blnAchouDevolucao Then
              Begin
                fltOutVal := FieldByName('ENT_OUTVAL').AsFloat;
                fltIcmSai := FieldByName('ENT_ICMSAI').AsFloat;
                fltImpFed := FieldByName('ENT_IMPFED').AsFloat;
                fltDesOpe := FieldByName('ENT_DESOPE').AsFloat;
              End;

              fltVlrComGeral := fltVlrComGeral + fltVlrCom;
              fltTotExtGeral := fltTotExtGeral + fltTotExt;
            End;

            {******************************}
            {* VERIFICAÇÕES BOCA DE CAIXA *}
            {***************************LU*}
            If (Not blnDevolu) Or
               fEmptyStr(FieldByName('ENT_AUTVEN').AsString) Or
               fEmptyStr(strTabDocOriDev) Then
            Begin
              fltBcaMin := 0;
              fltBcaCom := 0;
            End
            Else
            Begin
              qryGen := fCriaQuery;
              strSQL := '';
              strSQL := strSQL + ' SELECT ';
              strSQL := strSQL + '   DET_QTDITE, ';
              strSQL := strSQL + '   DET_BCACOM, ';
              strSQL := strSQL + '   DET_BCAMIN, ';
              strSQL := strSQL + '   DET_CODVEN ';
              strSQL := strSQL + ' FROM ';
              strSQL := strSQL + strTabDocOriDev;
              strSQL := strSQL + ' WHERE ';
              strSQL := strSQL + '   DET_CODITE = :CODITE AND ';
              strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
              strSQL := strSQL + '   DET_NUMDOC = :DOCDEV AND ';
              strSQL := strSQL + '   DET_ESPDOC = :ESPDEV ';

              qryGen.Close;
              qryGen.SQL.Clear;
              qryGen.SQL.Add(strSQL);
              qryGen.ParamByName('CODITE').AsString := FieldByName('ENT_CODITE').AsString;
              qryGen.ParamByName('CODEMP').AsString := FieldByName('ENT_CODEMP').AsString;
              qryGen.ParamByName('DOCDEV').AsString := FieldByName('ENT_NUMPED').AsString;;
              qryGen.ParamByName('ESPDEV').AsString := FieldByName('ENT_ESPDOC').AsString;;
              qryGen.Open;

              If Not (qryGen.IsEmpty) Then
              Begin
                fltBcaCom := ((qryGen.fieldbyname('DET_BCACOM').AsFloat / qryGen.fieldbyname('DET_QTDITE').AsFloat) * FieldByName('ENT_QTDITE').AsFloat);
                fltBcaMin := qryGen.FieldByName('DET_BCAMIN').AsFloat;
              End
              Else
              Begin
                fltBcaMin := 0;
                fltBcaCom := 0;
              End;
              FreeAndNil(qryGen);
            End;

            {*********************}
            {* GRAVA O MOVDET    *}
            {******************MV*}
            blnMarcaProAca := False;
            If Not (fEmptyStr(FieldByName('ENT_CODACA').AsString)) Then
            Begin
              strClaFisDet := FieldByName('ENT_CLAFIS').AsString;

              pLocalizaDocumentoOrigem(FieldByName('ENT_NUMPED').AsString,
                                       FieldByName('ENT_CODEMP').AsString,
                                       FieldByName('ENT_ESPDOC').AsString,
                                       FieldByName('ENT_CODACA').AsString,
                                       strNumPed_Out,
                                       strCodEmp_Out,
                                       strEspDoc_Out);

              blnTintaBaixada := TinGer.fVerificaTinDetBaixado(strNumPed_Out,
                                                               strCodEmp_Out,
                                                               strEspDoc_Out,
                                                               FieldByName('ENT_CODACA').AsString,
                                                               FieldByName('ENT_EMPACA').AsString,
                                                               '');

              If blnDevolu Then
              Begin
                if blnTintaBaixada Then
                   blnFilKar := True
                Else
                   blnFilKar := False;
              End
              Else
              Begin  {Não é Devolução}
                If (intESTFLJ = 1) Then
                  blnFilKar := True
                Else
                  blnFilKar := False;
              End;
              blnMarcaProAca := ((intESTFLJ = 1) And (Not blnDevolu)) Or ( (blnDevolu) And ( (FieldByName('ENT_PROACA').AsString = 'S') Or (blnTintaBaixada)));
              If blnMarcaProAca Then
              Begin
                 SetLength(ArrMarcaProAcaEndere, Succ(Length(ArrMarcaProAcaEndere)));
                 ArrMarcaProAcaEndere[Length(ArrMarcaProAcaEndere)-1] := FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;
              End;
            End
            Else
            Begin
              strClaFisDet := FieldByName('ENT_CLAFIS').AsString;
              blnFilKar    := False;
            End;

            If AnsiEndsText('933', FieldByName('ENT_CLAFIS').AsString) Then
              blnFilKar    := True;

            If(Pos(FieldByName('ENT_CLAFIS').AsString, '1922_2922')) > 0 Then
            begin
              TipoCfop := tcCFOP922;
              blnFilKar := True;
            End;

            If Pos(FieldByName('ENT_CLAFIS').AsString, '1117_2117_1116_2116') > 0 Then
              TipoCfop := tcCFOP117;


            If (blnUtilizarCFG_CLARET) and (Pos(FieldByName('ENT_CLAFIS').AsString, strClaRet) > 0) Then
              blnFilKar    := True;

            If blnConEqu Then
              blnFilKar    := True;

            If strTipFor = 'M' Then
              blnFilKar := True;

            If(blnConferenciaDepoisDaEntrada And (not (blnDevolu Or blnRecCliGarantia Or blnConEqu or blnGarantia Or AblnAcessadoViaRetornoConsignacao))) Then
            Begin
              blnFilKar := True;
              IF (ValidacaoZeraData.blnUtilizaColetorCFG_TPLREC) And (ValidacaoZeraData.blnGeraEnderecamento) And ( Not ValidacaoZeraData.blnTemItemParaEnderecar) Then
                blnFilKar := False;
            End;

            If fIsItemEspecial(FieldByName('ENT_CODITE').AsString) Then
              blnFilKar := True;

            If tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor] Then
              blnFilKar := True;

            If blnRetornoSimbolico Then
              blnFilKar := False;

            If Not fEmptyStr(strEmpresaDeposito) Then
              blnFilKar := True;


            fltQtdPon := 0;

            If blnDevolu Then
              fltQtdPon := fQtdPontoProfiss(FieldByName('ENT_CODITE').AsString,
                                            FieldByName('ENT_CODEMP').AsString);

            If (Not blnAchouDevolucao) Then
              fltTotUlt := ( FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat );

            fltPreUlt := fltTotUlt / FieldByName('ENT_QTDITE').AsFloat;

            fltPreUlt := fFormataFloat(fltPreUlt, 4);

            pCalculaPreUltImp(blnNotImport,
                              qryEntMer,
                              strCodEmp,
                              strCodFor,
                              strEspDoc,
                              strSimPau,
                              strTipFor,
                              dtaDtaEnt,
                              blnDevolu,
                              blnConEqu,
                              blnUltPis,
                              blnDedIcm,
                              blnPrecoPraticado,
                              blnAchouDevolucao,
                              (Pos(strCodFor, strForFil) > 0),
                              CalcResult,
                              fltPreUltImp,
                              fltImpUlt,
                              fltAlqRet,
                              fltTotAlqPis,
                              fltTotAlqCof,
                              fltAlqPisCofPreUlt,
                              fltValorFreteCalc,
                              fltValorFreConCalc);



            fltUniVis := fItem('PREVE1').AsFloat;

            fltTotBasPis := fltTotBasPis + CalcResult.dblBasePis;
            fltTotBasCof := fltTotBasCof + CalcResult.dblBaseCof;
            fltTotPis := fltTotPis + CalcResult.dblValorPis;
            fltTotCof := fltTotCof + CalcResult.dblValorCof;
            If strTipFor = 'M' Then
            Begin
              fltUniVis := 0;
              fltUniOri := 0;
            End;

            If fltUniOri <= 0 Then
            Begin
              fltUniOri := FieldByName('ENT_UNITAR').AsFloat;
              fltUniVis := FieldByName('ENT_UNITAR').AsFloat;
            End;

            If (blnDevolu) And (strOriPro = '2') Then
              fltComiss := fltComiss + FieldByName('ENT_VLRCON').AsFloat *
                objComPro.fRetComissaoProfissionalItem(FieldByName('ENT_CODITE').AsString) / 100;

            strNumLot := fRetNumLot(qryEntMer, strCodEmp, objCadLot);
            If Assigned(objEmissaoNotaEspecial) Then
              strNumLot := '';

            pCalculaQuantidadePontosPromocaoBrindes;

            blnOpeGad := False;
            If fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) Then
            Begin
              If cdsMovGad.Locate('CODITE', FieldByName('ENT_CODITE').AsString, []) Then
                blnOpeGad := True;
            End;

            strCodVenGag := '';
            If Assigned(cdsMovGad) Then
               strCodVenGag := cdsMovGad.FieldByName('CODVEN').AsString;

            strAutIncTmp := qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;
            pCarregaRefTribItemEntrada(qryEntMer, objRefIte);
            objRefIte.strRefCesBas := fCesBasItem(qryEntMer.FieldByName('ENT_CODITE').AsString);
            if (AblnAcessadoViaRetornoConsignacao) and (Pos(FieldByName('ENT_CLAFIS').AsString, fTransform(fCfgSis('CLADSC'), 4)) > 0) then
            Begin
              blnFilKar := True;
              strNumLot := '';
            End;

            If tpFinalidadeXML = xmlRetornoLocacao Then
              blnFilKar := False;

            If blnRetornoSimbolico And fUsaRotinaWMS And Not strCodExt.IsEmpty Then
              If Not TCadLot.ExisteLoteEstoqueExterno(FieldByName('ENT_CODITE').AsString, strCodExt, strNumLot) Then
                TCadLot.GeraLoteEstoqueExterno(FieldByName('ENT_CODITE').AsString, strCodExt, strNumLot);

            {Utiliza Cadastro de IPI}
            strCSTIpi := '';
            strEnqIpi := '';
            If blnUtiAbI And
            (Not (blnDevolu Or blnRecCliGarantia Or blnConEqu Or blnGarantia Or AblnAcessadoViaRetornoConsignacao)) And
            (Not (strTipFor = 'M')) Then
            Begin
              If Not fRetornaCSTIPI(FieldByName('ENT_CODITE').AsString, strClaFisDet, strCSTIpi, strEnqIpi) Then
              Begin
                fMensagem('ATENÇÃO!','Abreviação de IPI não configurada.'+ #13+#10 +
                                     'Favor verificar cadastros de abreviação e produto.'+ #13+#10 +
                                     'CFOP IPI ENTRADA: ' + strClaFisDet + #13+#10 +
                                     'PRODUTO: ' + FieldByName('ENT_CODITE').AsString + ' ', ['&O k']);
                Result := False;
              End;
            End;

            blnFilFul := True;

            If strExtFul.Equals('S') And (Not strCodExt.IsEmpty) Then
            Begin
              objFulfillmentRegrasMovimentacaoEstoque := FulfillmentMovimentacaoEstoque(strClaFisDet, str_Chave);

              blnFilKar := objFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueFisico.ToFilKar;
              blnFilFul := objFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueExterno.ToFilFul;
            End;

            If Assigned(objEntAuto) And objEntAuto.recDadFor.fFornecedorMaterialConsumo Then
            Begin
              fltVaeIpiTmp := FieldByName('ENT_VAEIPI').AsFloat;
              fltAleIpiTmp := FieldByName('ENT_ALEIPI').AsFloat;
              fltBaeIpiTmp := FieldByName('ENT_BAEIPI').AsFloat;
            End
            Else
            Begin
              fltVaeIpiTmp := IIF((Not Assigned(objEntAuto) Or (Not objEntAuto.recDadNot.blnCreIpi)), FieldByName('ENT_VAEIPI').AsFloat, 0);
              fltAleIpiTmp := IIF((Not Assigned(objEntAuto) Or (Not objEntAuto.recDadNot.blnCreIpi)), FieldByName('ENT_ALEIPI').AsFloat, 0);
              fltBaeIpiTmp := IIF((Not Assigned(objEntAuto) Or (Not objEntAuto.recDadNot.blnCreIpi)), FieldByName('ENT_BAEIPI').AsFloat, 0);
            End;

            Result := Result And
                      fGravaMovDet(strAutIncTmp,                                                   // Retorna Auto-Incremento por Referencia
                                   strAutInc,                                                      // Sequencial do Arquivo Geral
                                   strNumDoc,                                                      // Numero do Documento
                                   strEspDoc,                                                      // Espécie
                                   strCodEmp,                                                      // Empresa
                                   FieldByName('ENT_CODITE').AsString,                             // Cód. Item
                                   IfThen(blnOpeGad, strCodVenGag, strCodOpe),                                                      // Vendedor
                                   IIF(blnDevolu, FieldByName('ENT_CODDIV').AsString, ''),         // Código Diversos
                                   fItem('CODMAR').AsString, // Código da Marca
                                   IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, '', strCodFor),                                  // Fornecedor
                                   IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, strCodFor, ''),                                  // Cliente
                                   IIF(fZeraDataEntrada(ValidacaoZeraData), 0, dtaDtaEnt), // Data da Entrada
                                   IIF(fZeraDataEntrada(ValidacaoZeraData), 0, fTime()),   // Hora da Entrada

                                   dtaDtaDoc,                                                      // Data do Documento
                                   strCndPag,                                                      // Condição de Pagamento
                                   IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, 'C', 'F'),                                       // Tipo: (C)liente / (F) Fornecedor
                                   strEstFor,                                                      // Estado do Fornecedor
                                   FieldByName('ENT_DESITE').AsString,                             // Descrição do Item
                                   FieldByName('ENT_REFERE').AsString,                             // Referencia do Item
                                   FieldByName('ENT_CODUNI').AsString,                             // Cód. Unidade
                                   fItem('CODFOR').AsString,                                       // Fornecedor Item
                                   FieldByName('ENT_QTDITE').AsFloat,                              // Quantidade do Item
                                   FieldByName('ENT_UNITAR').AsFloat,                              // Valor Unitario
                                   fltUniOri,                                                      // Valor Unitário Original
                                   fltUniVis,                                                      // Valor Unitário Original sem juros
                                   FieldByName('ENT_TOTITE').AsFloat,                              // Total do Item
                                   FieldByName('ENT_VLRCON').AsFloat,                              // Valor Contábil do Item
                                   fltTotCus,                                                      // Valor Total de Custo
                                   fltTotMed,                                                      // Valor Total Medio
                                   0.0,                                                            // % Desconto do Item
                                   FieldByName('ENT_VALFRE').AsFloat,                              // Valor do Frete
                                   FieldByName('ENT_DESESP').AsFloat,                              // Valor do Desconto Especial
                                   strCodRep,                                                      // Código do Representante
                                   strCodVe2,                                                      // Código do vendedor2
                                   fltPerCom,                                                      // Percentual de Comissão do Vendedor
                                   fltTotCom,                                                      // Total de Comissão do Vendedor
                                   fltTotCo2,                                                      // Total de Comissão do Vendedor 2
                                   strClaFisDet,                                                   // Classificação Fiscal
                                   FieldByName('ENT_CODFIS').AsString,                             // Código Fiscal

                                   IIF((Not Assigned(objEntAuto) Or objEntAuto.recDadNot.blnCreIpi), FieldByName('ENT_VALIPI').AsFloat, 0),  // Valor IPI
                                   IIF((Not Assigned(objEntAuto) Or objEntAuto.recDadNot.blnCreIpi), FieldByName('ENT_ALQIPI').AsFloat, 0),  // Aliquota IPI
                                   IIF((Not Assigned(objEntAuto) Or objEntAuto.recDadNot.blnCreIpi), FieldByName('ENT_BASIPI').AsFloat, 0),  // Base IPI

                                   FieldByName('ENT_VALICM').AsFloat,                              // Valor de ICMS
                                   FieldByName('ENT_ALQICM').AsFloat,                              // Aliquota de ICMS
                                   FieldByName('ENT_BASICM').AsFloat,                              // Base de ICMS
                                   FieldByName('ENT_VALRET').AsFloat,                              // Valor de Substituição
                                   fltAlqRet,                                                      // Aliquota de Substituição
                                   FieldByName('ENT_BASRET').AsFloat,                              // Base de Substituição
                                   0.0,                                                            // Total de Peso
                                   FieldByName('ENT_PERBAS').AsFloat,                              // Percentual de Base de ICMS
                                   0.0,                                                            // Percentual de Redução de Base
                                   False,                                                          // Indica se ja esta Faturado
                                   '',                                                             // Tipo de Faturamento
                                   '',                                                             // Número do Faturamento
                                   '',                                                             // Empresa do Faturamento
                                   0,                                                              // Data do Faturamento
                                   '',                                                             // Vendedor do Faturamento
                                   '',                                                             // Condição de Pagamento Faturamento
                                   0.0,                                                            // Valor do Faturamento
                                   IIf(blnDevolu and (not fEmptyStr(FieldByName('ENT_IDEPRO').AsString)), FieldByName('ENT_IDEPRO').AsString, 'NOR'),                                                          // Identificação Produto ( Normal / Outros )
                                   FieldByName('ENT_INCPIS').AsString,                             // Indice se incide Pis
                                   strSerie,                                                       // Série
                                   FieldByName('ENT_DESACE').AsFloat,                              // Valor de Despesa Acessória
                                   'N',                                                            // Nota Especial
                                   IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, FieldByName('ENT_NUMPED').AsString, ''),         // Documento da Devolução
                                   IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, FieldByName('ENT_ESPDOC').AsString, ''),         // Espécie da Devolução
                                   IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, FieldByName('ENT_CODEMP').AsString, ''),         // Empresa da Devolução
                                   '',                                                             // Item de Chamada (TINTA DE MAQUINA)
                                   IIf(blnDevolu and (Not fEmptyStr(FieldByName('ENT_ITETIN').AsString)), FieldByName('ENT_ITETIN').AsString, ''), // Item da Tinta (TINTA DE MAQUINA)
                                   '',                                                             // Descrição da Cor (TINTA DE MAQUINA)
                                   '',                                                             // Tipo de Embalagem (TINTA DE MAQUINA)
                                   0.0,                                                            // Quantidade de Embalagem (TINTA DE MAQUINA)
                                   0.0,                                                            // Preço da Embalagem (TINTA DE MAQUINA)
                                   '',                                                             // Tipo de Preço (TINTA DE MAQUINA)
                                   0.0,                                                            // Preço de Venda da Tinta (TINTA DE MAQUINA)
                                   0.0,                                                            // Preço de Compra da Tinta (TINTA DE MAQUINA)
                                   0.0,                                                            // Fator da Tinta (TINTA DE MAQUINA)
                                   IIF(blnDevolu, FieldByName('ENT_PROEMB').AsString, 'N'),        // Produto Embalagem (TINTA DE MAQUINA)
                                   strCodDig,                                                      // Código do Digitador
                                   '',                                                             // Codigo da Condição
                                   '',                                                             // Forma de Pagamento
                                   '',                                                             // Item da Embalagem
                                   '',                                                             // Grupo do Item da Embalagem
                                   0,                                                              // Quarto Lazzumix
                                   '',                                                             // Item promocional? (S/N)
                                   '',                                                             // Tipo de Tinta (1 / 2)
                                   0.0,                                                            // Quantidade de Pulsos
                                   IIF(blnDevolu, '', FieldByName('ENT_NUMPED').AsString),         // Número do Pedido de Compras
                                   IIF((blnRecCliGarantia) Or (blnConEqu), '', IIF(blnGarantia,'G', IIF(blnDevolu or AblnAcessadoViaRetornoConsignacao, 'D', ''))),                   // Origem do Documento - (D)evolução / (E)ntrada / (V)enda
                                   '',                                                             // Pedido de Venda - Número
                                   '',                                                             // Pedido de Venda - Espécie
                                   IIF(blnDevolu, FieldByName('ENT_EMP_PD').AsString, ''),                                         // Pedido de Venda - Empresa
                                   0,                                                              // Pedido de Venda - Sequencial
                                   '',                                                             // Ordem de Produção
                                   '',                                                             // Descrição para Nota Fiscal Especial
                                   '',                                                             // CLiente de faturamento
                                   fltBcaMin,                                                      // Boca de caixa - valor mínimo
                                   fltBcaCom,                                                      // Boca de caixa - comissao
                                   0.0,                                                            // Volume a produzir (Tinta de Máquina Venda Dinâmica)
                                   qryEntMer.FieldByName('ENT_CODACA').AsString,                             // Código do produto acabado
                                   qryEntMer.FieldByName('ENT_EMPACA').AsString,                             // Empresa do produto acabado
                                   IIf(blnDevolu and blnMarcaProAca , True, FieldByName('ENT_PROACA').AsString = 'S'), // É produto acabado? (mesma lógica da kardex).
                                   blnFilKar,                                                      // Filtrar na Kardex?
                                   '',                                                             //  Especie da Entrega Fututa
                                   '',                                                             //  Documento da Entrega Fututa
                                   '',                                                             //  Empresa da Entrega Fututa
                                   strTabPre,
                                   FieldByName('ENT_CODEMP').AsString,                             //  Empresa do pedido de compra
                                   '', '', '', 0.0, '', 0.0,0.0,
                                   fltQtdPon,
                                   'N',
                                   '',
                                   0,
                                   fltTotCu2,
                                   fltTotExt,
                                   fltPerRep,
                                   '',
                                   IIf(blnMarcaProAca, '', strNumLot),                           // strNumLot
                                   'N',                                 // strPigBas

                                   fltVaeIpiTmp,  //fltVaeIpiTmp Valor IPI QUANDO NAO UTILIZA CREDITO DE IPI
                                   fltAleIpiTmp,  //fltAleIpiTmp Aliquota IPI QUANDO NAO UTILIZA CREDITO DE IPI
                                   fltBaeIpiTmp,  //fltBaeIpiTmp Base IPI QUANDO NAO UTILIZA CREDITO DE IPI

                                   fltTotUlt,                           // Total a preço de última compra
                                   fltImpUlt,
                                   0,
                                   0,
                                   0,
                                   0,
                                   FieldByName('ENT_EMBALA').AsFloat,

                                   CalcResult.dblAlqPis,
                                   CalcResult.dblBasePis,
                                   CalcResult.dblValorPis,
                                   CalcResult.strCstPis,
                                   CalcResult.dblAlqCof,
                                   CalcResult.dblBaseCof,
                                   CalcResult.dblValorCof,
                                   CalcResult.strCstCof,
                                   IIF(blnUtiAbI, strCSTIpi, ''),
                                   IIF(blnUtiAbI, strEnqIpi, ''),
                                   FieldByName('ENT_VAERET').AsFloat,
                                   fltAlERet,
                                   FieldByName('ENT_BAERET').AsFloat,
                                   0,
                                   0,
                                   '',
                                   FieldByName('ENT_FRECON').AsFloat,
                                   FieldByName('ENT_BASANT').AsFloat + FieldByName('ENT_BAFRAN').AsFloat,
                                   FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VAFRAN').AsFloat,
                                   FieldByName('ENT_VENDOR').AsFloat,
                                   FieldByName('ENT_OUTDES').AsFloat,
                                   FieldByName('ENT_VALGNR').AsFloat,
                                   FieldByName('ENT_GNRORI').AsString,
                                   FieldByName('ENT_OUTRAS').AsFloat,
                                   FieldByName('ENT_ISENTO').AsFloat,
                                   0,
                                   FieldByName('ENT_CODMOT').AsString,

                                   CalcResult.strNatRecPis,
                                   CalcResult.strNatRecCof,

                                   '',
                                   fltOutVal,  // fltOutVal
                                   fltIcmSai,  // fltIcmSai
                                   fltImpFed,  // fltImpFed
                                   fltDesOpe,  // fltDesOpe
                                   0,  // fltQtdExp
                                   '', // strNumCmp
                                   0,  // intNItCmp
                                   0,  // fltDeDVCf
                                   '', // strCodMec
                                   FieldByName('ENT_ANTPRO').AsString,
                                   FieldByName('ENT_ANTFRE').AsString,
                                   fltPremedAtu,
                                   fltPreUltOriginal,
                                   fltPreImpUltOriginal,
                                   strSeqDetOriginal,
                                   '',
                                   0,
                                   '',
                                   0,
                                   'N',
                                   '',
                                   'NOR',
                                   FieldByName('ENT_PEBAST').AsFloat,// Percentual de Base de ST
                                   fltVal_RT,
                                   0,
                                   0,
                                   0,
                                   0,
                                   strProBriDev,
                                   fltPonBriDev,
                                   0,                                 {fltValDif}
                                   FieldByName('ENT_VAFRAN').AsFloat, {fltVaFrAn}
                                   '', //strLotAba
                                   0, //fltFedImp
                                   0, //fltEstImp
                                   0, //fltMunImp
                                   IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, FieldByName('ENT_AUTVEN').AsString, ''), //strIncDev,
                                   'N', //strBrinde
                                   '', //strCodPar
                                   '', //strTipBri
                                   0, //fltIcmOrg
                                   '', //strBaqtze
                                   IIF(blnDevolu, FieldByName('ENT_INCFUT').AsString, ''), //strIncFut
                                   0, //fltValFle
                                   0, //fltTaxEnt
                                   0, //fltVrdIcm
                                   0, //fltBasVrd
                                   FieldByName('ENT_MTDICM').AsString, //strMtdIcm
                                   'N', //strBxSbIt
                                   '', //strIteAbf
                                   'N', //strAtivac
                                   0, //intSeqCom                                                            intSeqCom: Integer = 0;
                                   FieldByName('ENT_VICMDE').AsFloat, //fltVICMDe                            fltVICMDe: Double = 0;
                                   FieldByName('ENT_CLAIPI').AsString, //strNcmIte      strNcmIte: String = '';
                                   0,
                                   0,
                                   0,
                                   False,
                                   0,
                                   '',
                                   qryEntMer.FieldByName('ENT_BFCPST').AsFloat,
                                   qryEntMer.FieldByName('ENT_PFCPST').AsFloat,
                                   qryEntMer.FieldByName('ENT_VFCPST').AsFloat,
                                   '',
                                   IIF(fEmptyStr(strAutEle), '', FieldByName('ENT_AUTELE').AsString),
                                   '', //   strNotUlt: String = '';
                                   FieldByName('ENT_PICMEF').AsFloat,    //fltPICMEF
                                   FieldByName('ENT_BICMEF').AsFloat,    //fltBICMEF
                                   FieldByName('ENT_AICMEF').AsFloat,    //fltAICMEF
                                   FieldByName('ENT_VICMEF').AsFloat,    //fltVICMEF
                                   FieldByName('ENT_BSTANT').AsFloat,    //fltBSTANT
                                   FieldByName('ENT_VSTANT').AsFloat,    //fltVSTANT
                                   '',                                   //strNotC17
                                   0,                                    //fltAlq922
                                   0,                                    //fltDesCnd
                                   '',                                   //strProEsp
                                   '',                                   //strCodPro
                                   '',                                   //strInc_Pd
                                   0,                                    //fltSICMEF
                                   FieldByName('ENT_VLTCIF').AsFloat,    //fltValTCI
                                   FieldByName('ENT_CLTCIF').AsFloat,    //fltClaTCI
                                   FieldByName('ENT_VAL_TS').AsFloat,   //fltVal_TS
                                   strExtFul, // strExtFul: String = '';
                                   strCodExt, // strCodExt: String = '';
                                   0,  // fltFreMkp: Double = 0;
                                   0,  // fltComMkp: Double = 0;
                                   '', // strAIdKitPromocao : String = '';
                                   str_Chave, // strChaveAcesso: String = '';
                                   0,  // fltQtdCom: Double = 0;
                                   0,  // fltFreCot: Double = 0;
                                   '', // AstrComplemento : String = '';
                                   '', // strEmpCar: String = '';
                                   '', // strAutoinDevCar: String = '';
                                   0,  // AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                                   0,  // AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                                   0,  // AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                                   0,  // fltFreRat: Double = 0;
                                   0,  // fltValIpiEntFut: Double = 0;
                                   0,  // fltValRetEntFut: Double = 0;
                                   0,  // fltValFcpSTEntFut: Double = 0;
                                   FieldByName('ENT_DESPIS').AsFloat,  //  ftlDesPis: Double = 0
                                   blnUtilizarCFG_CLARET,
                                   '',
                                   '',
                                   '',
                                   '',
                                   False,
                                   '',
                                   0,
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   '',
                                   FieldByName('ENT_NATOPE').AsString,
                                   fEnt_FreRpaE,
                                   0,
                                   False,
                                   0,
                                   qryEntMer.FieldByName('ENT_N_ITEM').AsInteger,
                                   qryEntMer.FieldByName('ENT_ICMCFR').AsFloat,
                                   fltValorFreteCalc,
                                   fltValorFreConCalc,
                                   'N', //strPegou_
                                   0,   //fltVFCPOP
                                   0,   //fltVFCPDF
                                   0,   //fltCubage
                                   0,   //fltCfbIpi
                                   0,   //fltCfaIpi
                                   0,   //fltCfvIpi
                                   'N', //strCipiOK
                                   '',  //strDocIpi
                                   '',  //strEspIpi
                                   '',  //strEmpIpi
                                   0,   //intRemFil
                                   0,   //fltQtdRemFil
                                   False, //blnFulfillmentModoRobo
                                   blnFilFul,
                                   False,//blnBaiDev
                                   '', //strAuthEnt
                                   0,   //dtaDtaCmp
                                   '', //strFullHubMkp
                                   0, //fltOutValPD
                                   '', //strFilFul_EntSai
                                   '', //strIncOri
                                   '', //strTckQbt
                                   qryEntMer.FieldByName('ENT_ITETRI').AsString,
                                   '', // strFulDif: String = '';
                                   '', // strClaFat: String = '';
                                   IIF(FieldByName('ENT_VALICM').AsFloat > 0, 0, FieldByName('ENT_ICMXML').AsFloat),  //fltICMNCR
                                   IIF(FieldByName('ENT_VALFCP').AsFloat > 0, 0, FieldByName('ENT_FCPXML').AsFloat),//fltFCPNCR
                                   'N',//strColoranteDeEntregaFutura
                                   '', //strCbenef: string = '';
                                   '', //strCodPre: string = '';
                                   0, // fltBasPre: Double = 0;
                                   0, //fltPerPre: Double = 0;
                                   0, //fltValPre: Double = 0;
                                   '', //strCodCmg: string = '';
                                   0, //fltVimRet: Double = 0;
                                   FieldByName('ENT_QBCMON').AsFloat,//dobQIcmsMonRet: Double = 0;
                                   FieldByName('ENT_ADREMN').AsFloat,//dobAdBcMonRet: Double = 0;
                                   FieldByName('ENT_VALMON').AsFloat,//dobVrEmIcmsRet: Double = 0
                                   0,
                                   0,
                                   FieldByName('ENT_ALQSTI').AsFloat,
                                   0,   // fltCliDes
                                   objRefIte.strRefCodCst,   // strRefCodCst {Req. 410369 - MOVREF}
                                   objRefIte.strRefClaTri,   // strRefClaTri
                                   objRefIte.fltRefValOpe,   // fltRefValOpe
                                   objRefIte.fltRefBasCal,   // fltRefBasCal
                                   objRefIte.fltRefCbsAlq,   // fltRefCbsAlq
                                   objRefIte.fltRefCbsAlD,   // fltRefCbsAlD
                                   objRefIte.fltRefCbsVlD,   // fltRefCbsVlD
                                   objRefIte.fltRefCbsAlR,   // fltRefCbsAlR
                                   objRefIte.fltRefCbsVlT,   // fltRefCbsVlT
                                   objRefIte.fltRefCbsAlE,   // fltRefCbsAlE
                                   objRefIte.fltRefCbsVal,   // fltRefCbsVal
                                   objRefIte.fltRefIbsUfA,   // fltRefIbsUfA
                                   objRefIte.fltRefIbsUfD,   // fltRefIbsUfD
                                   objRefIte.fltRefIbsUvD,   // fltRefIbsUvD
                                   objRefIte.fltRefIbsUfR,   // fltRefIbsUfR
                                   objRefIte.fltRefIbsUfT,   // fltRefIbsUfT
                                   objRefIte.fltRefIbsUfE,   // fltRefIbsUfE
                                   objRefIte.fltRefIbsUfV,   // fltRefIbsUfV
                                   objRefIte.fltRefIbsMnA,   // fltRefIbsMnA
                                   objRefIte.fltRefIbsMnD,   // fltRefIbsMnD
                                   objRefIte.fltRefIbsMvD,   // fltRefIbsMvD
                                   objRefIte.fltRefIbsMnR,   // fltRefIbsMnR
                                   objRefIte.fltRefIbsMnT,   // fltRefIbsMnT
                                   objRefIte.fltRefIbsMnE,   // fltRefIbsMnE
                                   objRefIte.fltRefIbsMnV,   // fltRefIbsMnV
                                   objRefIte.strRefSelCst,   // strRefSelCst
                                   objRefIte.strRefSelCla,   // strRefSelCla
                                   objRefIte.fltRefSelBas,   // fltRefSelBas
                                   objRefIte.fltRefSelAlq,   // fltRefSelAlq
                                   objRefIte.fltRefSelVal,   // fltRefSelVal
                                   objRefIte.strRefTriReg,   // strRefTriReg ('N' pelo Init)
                                   objRefIte.strRefCrePre,   // strRefCrePre ('N' pelo Init)
                                   objRefIte.strRefMonoFa,   // strRefMonoFa ('N' pelo Init)
                                   objRefIte.fltRefValIbs,   // fltRefValIbs
                                   objRefIte.strRefCesBas,   // strRefCesBas
                                   objRefIte.strRefCstReg,   // strRefCstReg
                                   objRefIte.strRefClaReg,   // strRefClaReg
                                   objRefIte.fltRefAiuReg,   // fltRefAiuReg
                                   objRefIte.fltRefTiuReg,   // fltRefTiuReg
                                   objRefIte.fltRefAimReg,   // fltRefAimReg
                                   objRefIte.fltRefTimReg,   // fltRefTimReg
                                   objRefIte.fltRefCbsReg,   // fltRefCbsReg
                                   objRefIte.fltRefTcbReg,   // fltRefTcbReg
                                   0,//fltIcmPrd
                                   FieldByName('ENT_VALSIS').AsFloat, // fltSiscomex
                                   '', //strChvRef,
                                   '', //strIteRef
                                   nil, //ABatch
                                   0, //fltBimRet
                                   0, //fltAimRet
                                   true //blnRefEspelhaDocumento - grava MOVREF tambem para item so com IS
                                   );

             If Result Then
               blnGravouMovDet := True;

             If Result Then
               result := fGravaCALGNR(qryEntMer, strAutIncTmp);
             If (FieldByName('ENT_FRECON').AsFloat > 0) And (SameText(strEspDoc,'NF')) Then
               pAddCTEMOVArr(strAutIncTmp,
                             FieldByName('ENT_FRECON').AsFloat,
                             FieldByName('ENT_ICMCFR').AsFloat,
                             ArrCteMov);

             pGravarICMSUFDest(strAutIncTmp,
                               'MOVICD',
                               0,
                               qryEntMer.FieldByName('ENT_PERFCP').AsFloat,
                               0,
                               0,
                               0,
                               qryEntMer.FieldByName('ENT_VALFCP').AsFloat,
                               0,
                               0,
                               qryEntMer.FieldByName('ENT_VBCFCP').AsFloat);

            {*****************************************************************}
            {* SE FOR UMA ENTRADA DE MERCADORIA, REFERENTE A UM PEDIDO DE    *}
            {* COMPRA GERADO ATRAVÉS DE UMA TRANSFERENCIA DE ESTOQUE DE      *}
            {* GARANTIA, GRAVA PEDIDO DE VENDA PARA RESERVAR O PRODUTO, POIS *}
            {* O MESMO NÃO PODE SER VENDIDO PELO FATO DE ESTAR COM DEFEITO.  *}
            {**************************************************************MM*}
            If (Result) And (blnPedFilialGarantia) Then
            Begin
              strAutIncPedDet := '';
              Result := fGravaFatDor(strAutIncPedDet,
                                     strAutIncPed,
                                     strCodEmp,
                                     strCodCliPed,
                                     strCodOpe,
                                     FieldByName('ENT_CODITE').AsString,
                                     qryConIte.FieldByName('ITE_CODMAR').AsString,
                                     '',
                                     strNumPedVen,
                                     'PD',
                                     '',
                                     VS_Date,
                                     fTime(),
                                     '01000',
                                     '',
                                     FieldByName('ENT_DESITE').AsString,
                                     FieldByName('ENT_REFERE').AsString,
                                     FieldByName('ENT_CODUNI').AsString,
                                     qryConIte.FieldByName('ITE_CODFOR').AsString,
                                     FieldByName('ENT_QTDITE').AsFloat,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     fRetCodRepresCliente(fRetornaClienteFilial(strCodEmp)),
                                     '',
                                     0,
                                     0,
                                     0,
                                     '5999',
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     0,
                                     False,
                                     '',
                                     '',
                                     '',
                                     0,
                                     '',
                                     '',
                                     0.0,
                                     'NOR',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     '',
                                     0,
                                     0,
                                     0,
                                     '',
                                     '',
                                     0,
                                     '',
                                     '',
                                     0.0,
                                     0,
                                     0,
                                     0,
                                     '',
                                     0,
                                     '',
                                     '',
                                     False,
                                     '1',
                                     '',
                                     '',
                                     '',
                                     0,
                                     '',
                                     0,
                                     '',
                                     '',
                                     'N',
                                     '',
                                     0,
                                     0,
                                     0,
                                     0,
                                     '',
                                     '',
                                     '',
                                     False,
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     '',
                                     '',
                                     0,
                                     '',
                                     '',
                                     0,
                                     0,
                                     0);

              If (Result) Then
              Begin
                Try
                  objGarant := TMovGag.Create(Nil);
                  Result := objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FATDOR', strAutIncPedDet, 'SEQ_PCMDET', FieldByName('ENT_SEQPCD').AsString);
                Except
                  Result := False;
                End;

                FreeAndNil(objGarant);

              End;

            End;


            //Vincula documentos de importação com a entrada.
            If (LeftStr(strClaFis, 1) = '3') And (Not blnDevolu) And (Not blnConEqu) Then
               pVinculaImportacaoDocumentoComEntrada(strAutIncTmp, strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie, FieldByName('ENT_CODITE').AsString);

            pAdicionarItemDevolvidoArray(strAutIncTmp);

            {*************************************}
            {* RECEBIMENTO DE CLIENTE (GARANTIA) *}
            {***********************************FC}
            If fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) Then
            Begin
              TControleChavesGarantia.pInserirMovDet(FieldByName('ENT_CODITE').AsString,
                                                     strAutIncTmp,
                                                     FieldByName('ENT_QTDITE').AsFloat);
            End
            {*********************************}
            {* RETORNO FORNECEDOR (GARANTIA) *}
            {*******************************FC}
            Else If (Result) And (blnGarantia) Then
            Begin
              Result := fAtualizaTabelaAux(FieldByName('ENT_CODITE').AsString,
                                           strAutIncTmp);
            End;

            If Result And (strTipFor <> 'M') And (Not blnRecCliGarantia) And
              ((Not fEmptyStr(FieldByName('ENT_CLAIPI').AsString)) Or
                           (Not fEmptyStr(FieldByName('ENT_CDCEST').ASString))) And
              (not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor, xmlGarantiaRecCliente])) Then
              pAtualizaClassificaoIPI_CDCEST(FieldByName('ENT_CODITE').AsString,
                                             FieldByName('ENT_CLAIPI').AsString,
                                             FieldByName('ENT_CDCEST').AsString);

            {*****************************************}
            {* SE OCORRER UM ERRO, SAI               *}
            {**************************************MV*}
            If Not Result Then
              Break;

            {*****************************************}
            {* CALCULO DO PREÇO MÉDIO DO ITEM        *}
            {*                                       *}
            {* ------------> ATENÇÃO <-------------- *}
            {*                                       *}
            {* NÃO COLOCAR A GRAVAÇÃO DO PREÇO MEDIO *}
            {* APÓS A GRAVAÇÃO DO SALDO!!            *}
            {**************************************MV*}
            If Not (blnRetornoSimbolico Or  (tpFinalidadeXML in [xmlCFG_IMPXGRGarantiaRetFornecedor])) Then
            Begin
              fltUniImp := (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat);

              If FieldByName('ENT_QTDITE').AsFloat > 0 Then
                fltUniImp := (fltUniImp / FieldByName('ENT_QTDITE').AsFloat)
              Else
                fltUniImp := 0.0;

              fltUniImp := fFormataFloat(fltUniImp, 4);

              fltPreMed := 0.0;

              If (fEmptyStr(FieldByName('ENT_CODACA').AsString)) And (strTipFor <> 'M') And
                 (RoundTo(FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat, -2) > 0) Then
              Begin

                If (Pos(strCodFor, strForFil) <= 0) OR ((Pos(strCodFor, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
                  fltIcmMed := IIF((fFormataFloat(FieldByName('ENT_TOTITE').AsFloat, 2) <> fFormataFloat(FieldByName('ENT_BASICM').AsFloat, 2)),
                                                    fFormataFloat((FieldByName('ENT_VALICM').AsFloat / (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat)) * 100, 2),
                                                    FieldByName('ENT_ALQICM').AsFloat + FieldByName('ENT_PERFCP').AsFloat)
                Else
                  fltIcmMed := 0;

                If strMedEmp = '1' Then
                  fltSaldosPreMed := fSaldoEmpresas(FieldByName('ENT_CODITE').AsString, strEmpMeds)
                Else
                  fltSaldosPreMed := fItem('SALDOS').AsFloat;

                {*************************************************************}
                {* CONFIGURAÇÃO QUE PERMITE UTILIZAR O ÚLTIMO PRECO DE       *}
                {* COMPRA PARA FORMAÇÃO DO PRECO MÉDIO DO PRODUTO            *}
                {**************************** 22/07/09**************** AM ****}
                Try
                  CalculoPrecoMediAgrup.strCodIteAtual := FieldByName('ENT_CODITE').AsString;
                  If (fCfgSis('BASMED') <> 'S') Then
                    fltPreMed := fCalculaPrecoMedio( FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                                   FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                                   fItem('PREMED').AsFloat,                     // Preço medio anterior
                                                   fltSaldosPreMed,                             // Saldo anterior
                                                   FieldByName('ENT_QTDITE').AsFloat,           // Quantidade de entrada
                                                   fltUniImp,                                   // Unitario sem impostos
                                                   fltIcmMed,                                  // Aliquota de ICMS do Item
                                                   FieldByName('ENT_VALIPI').AsFloat +
                                                   FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                                   FieldByName('ENT_VALRET').AsFloat +
                                                   FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                                   FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                                   FieldByName('ENT_VALGNR').AsFloat,
                                                   FieldByName('ENT_VLTCIF').AsFloat,
                                                   FieldByName('ENT_VAL_TS').AsFloat,

                                                   blnContribuinteIPI,                          // Contribuinte de IPI?
                                                   (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                                   FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                                   FieldByName('ENT_VALFRE').AsFloat +          // VALOR DO FRETE
                                                   FieldByName('ENT_FRECON').AsFloat +
                                                   fEnt_FreRpaE ,

                                                   FieldByName('ENT_OUTDES').AsFloat +
                                                   FieldByName('ENT_VENDOR').AsFloat +
                                                   FieldByName('ENT_DESACE').AsFloat,

                                                   FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat,

                                                   IIF((FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                       0,
                                                       FieldByName('ENT_ICMXML').AsFloat + FieldByName('ENT_FCPXML').AsFloat),

                                                   FieldByName('ENT_VFCPST').AsFloat,
                                                   FieldByName('ENT_ICMCFR').AsFloat,
                                                   CalculoPrecoMediAgrup,
                                                   FieldByName('ENT_VAEIPI').AsFloat > 0)
                  Else
                    fltPreMed := fCalculaPrecoMedio( FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                                   FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                                   fItem('PRECOM').AsFloat,                     // Preço compra anterior
                                                   fltSaldosPreMed,                             // Saldo anterior
                                                   FieldByName('ENT_QTDITE').AsFloat,           // Quantidade de entrada
                                                   fltUniImp,                                   // Unitario sem impostos
                                                   fltIcmMed,                                   // Aliquota de ICMS do Item
                                                   FieldByName('ENT_VALIPI').AsFloat +
                                                   FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                                   FieldByName('ENT_VALRET').AsFloat +
                                                   FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                                   FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                                   FieldByName('ENT_VALGNR').AsFloat,
                                                   FieldByName('ENT_VLTCIF').AsFloat,
                                                   FieldByName('ENT_VAL_TS').AsFloat,

                                                   blnContribuinteIPI,                          // Contribuinte de IPI?
                                                   (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                                   FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                                   FieldByName('ENT_VALFRE').AsFloat +
                                                   FieldByName('ENT_FRECON').AsFloat +
                                                   fEnt_FreRpaE,

                                                   FieldByName('ENT_OUTDES').AsFloat +
                                                   FieldByName('ENT_VENDOR').AsFloat +
                                                   FieldByName('ENT_DESACE').AsFloat,           // VALOR DO FRETE

                                                   FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat,

                                                   IIF((FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                       0,
                                                       FieldByName('ENT_ICMXML').AsFloat + FieldByName('ENT_FCPXML').AsFloat),

                                                   FieldByName('ENT_VFCPST').AsFloat,
                                                   FieldByName('ENT_ICMCFR').AsFloat,
                                                   CalculoPrecoMediAgrup,
                                                   FieldByName('ENT_VAEIPI').AsFloat > 0);

                  CalculoPrecoMediAgrup.pSetPreMedOri(FieldByName('ENT_CODITE').AsString,
                                                      fltPremedAtu,
                                                      fltPreUltOriginal,
                                                      fltPreImpUltOriginal,
                                                      strSeqDetOriginal);
                Except

                  On E: Exception Do
                  Begin
                    Result    := False;

                    If Pos('preço médio', E.Message) > 0 Then
                      Raise Exception.Create('Item ' + FieldByName('ENT_CODITE').AsString + ': ' + E.Message)

                    Else Raise;
                  End;

                End;

              End;

              pRecalculaPrecosEntrada(qryEntMer,
                                      qryConIte,
                                      fltPreMed,
                                      fltPreUlt,
                                      fltPreUltImp,
                                      fltPreCom,
                                      fltPreCus,
                                      fltPreComOri,
                                      recPrecos,
                                      blnAltPre,
                                      cpcParams,
                                      blnOutDesEntraNoprecoCompra,
                                      strCodFor,
                                      strForFil,
                                      strEspDoc,
                                      strAtuNMD,
                                      strNaoAtu,
                                      strCnvEmb,
                                      strTipFor,
                                      blnAtpRau,
                                      blnAtpRen,
                                      blnMedSe2,
                                      objAtuFor,
                                      blnAtpVmb,
                                      intDecUni,
                                      blnEncargosNoFrete);

              If ((fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor) And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen)) Or
                  (blnAlteraPrecos And
                    SameText(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_ITE_F5').AsString))) And
                  blnUsaLotePrecos And
                  {*Qualquer tipo de garantia nao muda preço*}
                  ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) And (not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
              Begin
                recPreLot := recPrecos;

                If CharInSet(strAtuNMD[1] , ['O', 'C']) Then
                Begin

                  If blnSepICM Then
                    fltComLot := fltPreCom - (FieldByName('ENT_DESESP').AsFloat - FieldByName('ENT_DESPIS').AsFloat - FieldByName('ENT_VICMDE').AsFloat) / FieldByName('ENT_QTDITE').AsFloat
                  Else
                    fltComLot := fltPreCom - FieldByName('ENT_DESESP').AsFloat / FieldByName('ENT_QTDITE').AsFloat;

                End Else
                  fltComLot := fltPreCom;

                With cpcParams Do
                fltComLot := objLotePrecos.fCalculaPrecoCompraBruto(fltComLot,
                                                                   [cpcParams.curDesF01, cpcParams.curDesF02, cpcParams.curDesF03,
                                                                    cpcParams.curDesF04, cpcParams.curDesF05, cpcParams.curDesF06]);
                pRecalculaPrecos(recPreLot,
                                 fltCusLot,
                                 blnAltLot,
                                 cpcParams,
                                 fltComLot,
                                 qryConIte,
                                 qryEntMer,
                                 (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(FieldByName('ENT_CODITE').AsString)),
                                 blnATPVMB);
              End;

              blnAtualizouPreco := False;

              If (strTipFor <> 'M') And
                 (Pos(FieldByName('ENT_CLAFIS').AsString, '1922_2922_') <= 0) And
                 (Not blnDevolu) And
                 (Not blnConEqu) And
                 (not AblnAcessadoViaRetornoConsignacao) And
                 (Not blnRecCliGarantia) And
                 (fEmptyStr(FieldByName('ENT_CODACA').AsString)) And
                 (((Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
                  ((blnAtuMed Or blnAtuUlt) And (Pos(strCodFor, strForFil) > 0))) And
                 (not fZeraDataEntrada(ValidacaoZeraData)) And //conferencia
                 (RoundTo(FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat, -2) > 0) And
                 (not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor, xmlCFG_IMPXGRGarantiaRetFornecedor])) Then
              Begin

                If Not Result Then
                  Break;

                pAtualizaUltimaCompra(strNumDoc,
                                      strEspDoc,
                                      strSerie,
                                      strCodFor,
                                      FieldByName('ENT_CODITE').AsString,
                                      strClaFisDet,
                                      FieldByName('ENT_CLAIPI').AsString,
                                      strForFil,
                                      FieldByName('ENT_NUMLOT').AsString,
                                      strMedEmp,
                                      strEmpMeds,
                                      blnAtuMed,
                                      blnAtuUlt,
                                      blnMedSe2,
                                      fltPreUlt,
                                      fltPreUltImp,
                                      fltPreMed,
                                      FieldByName('ENT_QTDITE').AsFloat,
                                      fltCotDol,
                                      VS_Date,
                                      blnRecCliGarantia,
                                      cdsMovGad,
                                      blnConEqu,
                                      blnAtualizouPrecoMedio);

                If blnAtualizouPrecoMedio Then
                Begin
                  Result := fGravaCalcPreMed(strAutIncTmp, 'untPcmGer.fConfirmaEntradaMercadorias', strAutIncPREMED, True);
                  If Not Result Then
                    Break;

                  strAutIncPREMED := fNextAutoIncrem(strAutIncPREMED);
                End;

                If ((blnAlteraPrecos And SameText(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_ITE_F5').AsString)) Or
                      fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor)
                    ) And
                    ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) And
                   blnAltPre And fHouveAlteracaoComposicaoPreco And (Not blnUsaLotePrecos) And
                  {*Qualquer tipo de garantia nao muda preço*}
                  ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) Then
                Begin
                  fltPreComAux := fltPreCom;
                  If CharInSet(strAtuNMD[1] , ['O', 'C']) Then
                  Begin

                    If blnSepICM Then
                      fltPreCom := fltPreCom - (FieldByName('ENT_DESESP').AsFloat - FieldByName('ENT_DESPIS').AsFloat - FieldByName('ENT_VICMDE').AsFloat) / FieldByName('ENT_QTDITE').AsFloat
                    Else
                      fltPreCom := fltPreCom - FieldByName('ENT_DESESP').AsFloat / FieldByName('ENT_QTDITE').AsFloat;

                  End;


                  If RoundTo(fltPreComAux, -4) <> RoundTo(fltPreCom, -4) Then
                    pRecalculaPrecos(recPrecos,
                                     fltPreCus,
                                     blnAltPre,
                                     cpcParams,
                                     fltPreCom,
                                     qryConIte,
                                     qryEntMer,
                                    (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(FieldByName('ENT_CODITE').AsString)),
                                     blnAtpVmb);

                  If blnAltPre Then
                  Begin
                    pGravaPreEnt(qryEntMer, strAutIncTmp, fltImpUlt, fltPreCom, fltPreComOri,  fltPreCus, blnOutDesEntraNoprecoCompra, blnOutDesNoFreIte, blnencargosNoFrete,  blnFreIpi);
                    pAtualizaPrecos(strEmpresas, qryEntMer, recPrecos, fltPreCom, fltPreCus, fltCotDol, False,
                                    blnInfMat, blnAtuPis, blnAtuDIC, intInfFed, intInfSai, intInfOpe, intDecUni, strAgrupadorPreAlt);

                    blnAtualizouPreco := True;

                    If blnInfMat And fEhEmpresaResponsavelFornecedor(fRetFornecedorItem(FieldByName('ENT_CODITE').AsString)) Then
                      pAtualizaPrecos(strEmpresas, qryEntMer, recPrecos, fltPreCom, fltPreCus, fltCotDol, True,
                                      blnInfMat, blnAtuPis, blnAtuDIC, intInfFed, intInfSai, intInfOpe, intDecUni, strAgrupadorPreAlt);
                  End
                  Else
                    blnAtualizouPreco := False;

                End;

                // Faz a mesma validação mas sem a validação se fHouveAlteracaoComposicaoPreco pois nesse caso deve marcar pq poderia ter alterado
                // Dessa forma é possivel saber se pode ou não atualizar o precom na gnre.
                If ((blnAlteraPrecos And SameText(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_ITE_F5').AsString)) Or
                      fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor)
                    ) And
                    ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) And
                   blnAltPre And (Not blnUsaLotePrecos) And
                  {*Qualquer tipo de garantia nao muda preço*}
                  ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) Then
                  pMarcaMovTriComAtualizacaoDePrecos(strAutIncTmp);
              End;
            End; {Not blnRetornoSimbolico}

            {*********************************************}
            {* ATUALIZA ESTOQUE SE NAO FOR ITEW ESPECIAL *}
            {******************************************JB*}
            If Not fIsItemEspecial(FieldByName('ENT_CODITE').AsString) And (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
            Begin

              If (fEmptyStr(FieldByName('ENT_CODACA').AsString)) Then
              Begin

                If Not blnFilKar Then
                  Result := Result And fAtualizaEstoqueCadIte(FieldByName('ENT_CODITE').AsString,
                                         'E', FieldByName('ENT_QTDITE').AsFloat, 0.0,
                                         strNumLot);

              End
              Else
              Begin
                //validar endereçamento
                if ((intESTFLJ = 1) And (Not blnDevolu)) Or
                   ( (blnDevolu) And ( (FieldByName('ENT_PROACA').AsString = 'S') Or (blnTintaBaixada))) then
                begin
                  Result := Result And TProdAcabado.fAtualizaEstoque(FieldByName('ENT_CODACA').AsString,
                                                    FieldByName('ENT_EMPACA').AsString,
                                                    VS_strCodEmp,
                                                    'E',
                                                    FieldByName('ENT_QTDITE').AsFloat);
                end
                else
                begin
                  Result := Result And fBaixaProdutoAcabadoDecomposto(strAutIncTmp, FieldByName('ENT_CODACA').AsString,
                    FieldByName('ENT_EMPACA').AsString,
                    strEspDoc_Out,         // Espécie da Devolução
                    strNumPed_Out,         // Documento da Devolução
                    strCodEmp_Out,         // Empresa da Devolução
                    strCodOco,
                    FieldByName('ENT_CODEMP').AsString,
                    strCndPag,
                    strCodOpe,
                    strNumDoc,
                    strEspDoc,
                    strCodEmp,
                    strCodFor,
                    strAutInc,
                    strSerie,
                    FieldByName('ENT_QTDITE').AsFloat,
                    FieldByName('ENT_QTDORI').AsFloat,
                    FieldByName('ENT_VLRCON').AsFloat,
                    FieldByName('ENT_TOTITE').AsFloat,
                    dtaDtaEnt,
                    blnDevolu,
                    strAutIncProAca,
                    IIF(blnDevolu, 'C', 'F'));
                end;

              End;
            End;

            {*****************************************}
            {* GRAVA PREALT                          *}
            {**************************************MV*}
            If (strTipFor <> 'M') And (Not blnRetornoSimbolico) And
               (Pos(FieldByName('ENT_CLAFIS').AsString, '1922_2922_') <= 0) And
               (Not blnDevolu) And (Not blnConEqu) And (fEmptyStr(FieldByName('ENT_CODACA').AsString)) And
               (Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And
               (RoundTo(FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat, -2) > 0) And
               (not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
            Begin

              If ((blnAlteraPrecos And
                  SameText(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_ITE_F5').AsString)) Or
                   fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor)
                 ) And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) And
                {*Qualquer tipo de garantia nao muda preço*}
                ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao))Then
              Begin

                If blnAltPre And fHouveAlteracaoComposicaoPreco And (Not blnUsaLotePrecos) And
                  (not blnConferenciaDepoisDaEntrada) Then
                Begin
                  pGravaPreEnt(qryEntMer, strAutIncTmp, fltImpUlt, fltPreCom, fltPreCus, fltPrecomOri, blnOutDesEntraNoprecoCompra, blnOutDesNoFreIte, blnencargosNoFrete,  blnFreIpi);

                  If Result And blnAtualizouPreco And (Not VS_blnPreAltViaTrigger) Then
                    Result := fGravaPreAlt(FieldByName('ENT_CODITE').AsString,

                                           fItem('PRECUS').AsFloat,
                                           fltPreCus,

                                           fItem('PREVE1').AsFloat,
                                           recPrecos[01].fltPreVen,

                                           fItem('MARBR1').AsFloat,
                                           recPrecos[01].fltMarBru,

                                           fItem('PREVE2').AsFloat,
                                           recPrecos[02].fltPreVen,

                                           fItem('MARBR2').AsFloat,
                                           recPrecos[02].fltMarBru,

                                           fItem('PREVE3').AsFloat,
                                           recPrecos[03].fltPreVen,

                                           fItem('MARBR3').AsFloat,
                                           recPrecos[03].fltMarBru,

                                           fItem('PREVE4').AsFloat,
                                           recPrecos[04].fltPreVen,

                                           fItem('MARBR4').AsFloat,
                                           recPrecos[04].fltMarBru,

                                           fItem('PREVE5').AsFloat,
                                           recPrecos[05].fltPreVen,

                                           fItem('MARBR5').AsFloat,
                                           recPrecos[05].fltMarBru,

                                           fItem('PREVE6').AsFloat,
                                           recPrecos[06].fltPreVen,

                                           fItem('MARBR6').AsFloat,
                                           recPrecos[06].fltMarBru,

                                           fItem('PREVE7').AsFloat,
                                           recPrecos[07].fltPreVen,

                                           fItem('MARBR7').AsFloat,
                                           recPrecos[07].fltMarBru,

                                           fItem('PRECOM').AsFloat,
                                           fltPreCom,

                                           'ENTRADA DE MERCADORIAS',

                                           Nil,
                                           '',
                                           strLoginUsuarioLogado);

                  pAtualizaItensGrupoPrecos(FieldByName('ENT_CODITE').AsString, 'ENTRADA DE MERCADORIAS', strAgrupadorPreAlt);
                End;

                If ((blnAltPre And blnUsaLotePrecos And fHouveAlteracaoComposicaoPreco) Or
                   (blnUsaLotePrecos And blnMostrarTodosLote)) And
                   {*Qualquer tipo de garantia nao muda preço*}
                   ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) And
                   (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
                Begin
                   objLotePrecos.strOpeRes := fItem('OPERES').AsString;
                   pGravaPreEnt(qryEntMer, strAutIncTmp, fltImpUlt, fltComLot,  fltCusLot, fltPrecomOri, blnOutDesEntraNoprecoCompra, blnOutDesNoFreIte,blnencargosNoFrete, blnFreIpi);

                   { novo preço é menor do que está no cadastro e
                    Item não permite redução de preço e
                    Carrega todos os itnes na ativação de lote então
                    Grava na lotpre os novos volores iguao ao que está no cadastro }
                  If (Not blnAltLot) And (recPreLot[1].blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco) And (blnMostrarTodosLote) Then
                  Begin
                    Result := Result And
                              objLotePrecos.fGravaLoteAlteracaoPrecoItem(strAutIncTmp,

                                                                         FieldByName('ENT_CODITE').AsString,

                                                                         fItem('PRECOM').AsFloat,
                                                                         fItem('PRECOM').AsFloat,

                                                                         fItem('DESF01').AsFloat,
                                                                         fItem('DESF01').AsFloat,

                                                                         fItem('DESF02').AsFloat,
                                                                         fItem('DESF02').AsFloat,

                                                                         fItem('DESF03').AsFloat,
                                                                         fItem('DESF03').AsFloat,

                                                                         fItem('DESF04').AsFloat,
                                                                         fItem('DESF04').AsFloat,

                                                                         fItem('DESF05').AsFloat,
                                                                         fItem('DESF05').AsFloat,

                                                                         fItem('DESF06').AsFloat,
                                                                         fItem('DESF06').AsFloat,

                                                                         fItem('ICMENT').AsFloat,
                                                                         fItem('ICMENT').AsFloat,

                                                                         fItem('SUBFED').AsFloat,
                                                                         fItem('SUBFED').AsFloat,

                                                                         fItem('IPIENT').AsFloat,
                                                                         fItem('IPIENT').AsFloat,

                                                                         fItem('FREENT').AsFloat,
                                                                         fItem('FREENT').AsFloat,

                                                                         fItem('VALFRE').AsFloat,
                                                                         fItem('VALFRE').AsFloat,

                                                                         fItem('ACRFIN').AsFloat,
                                                                         fItem('ACRFIN').AsFloat,

                                                                         fItem('SUBSTI').AsFloat,
                                                                         fItem('SUBSTI').AsFloat,

                                                                         fItem('DESADB').AsFloat,
                                                                         fItem('DESADB').AsFloat,

                                                                         fItem('OUTVAL').AsFloat,
                                                                         fItem('OUTVAL').AsFloat,

                                                                         fItem('IMPFED').AsFloat,
                                                                         fItem('IMPFED').AsFloat,

                                                                         fItem('DESOPE').AsFloat,
                                                                         fItem('DESOPE').AsFloat,

                                                                         fItem('PRECUS').AsFloat,
                                                                         fItem('PRECUS').AsFloat,

                                                                         fItem('ICMSAI').AsFloat,
                                                                         fItem('ICMSAI').AsFloat,

                                                                         fItem('MARBR1').AsFloat,
                                                                         fItem('MARBR1').AsFloat,

                                                                         fItem('PREVE1').AsFloat,
                                                                         fItem('PREVE1').AsFloat,

                                                                         fItem('COMTB1').AsFloat,
                                                                         fItem('COMTB1').AsFloat,

                                                                         fItem('MARBR2').AsFloat,
                                                                         fItem('MARBR2').AsFloat,

                                                                         fItem('PREVE2').AsFloat,
                                                                         fItem('PREVE2').AsFloat,

                                                                         fItem('COMTB2').AsFloat,
                                                                         fItem('COMTB2').AsFloat,

                                                                         fItem('MARBR3').AsFloat,
                                                                         fItem('MARBR3').AsFloat,

                                                                         fItem('PREVE3').AsFloat,
                                                                         fItem('PREVE3').AsFloat,

                                                                         fItem('COMTB3').AsFloat,
                                                                         fItem('COMTB3').AsFloat,

                                                                         fItem('MARBR4').AsFloat,
                                                                         fItem('MARBR4').AsFloat,

                                                                         fItem('PREVE4').AsFloat,
                                                                         fItem('PREVE4').AsFloat,

                                                                         fItem('COMTB4').AsFloat,
                                                                         fItem('COMTB4').AsFloat,

                                                                         fItem('MARBR5').AsFloat,
                                                                         fItem('MARBR5').AsFloat,

                                                                         fItem('PREVE5').AsFloat,
                                                                         fItem('PREVE5').AsFloat,

                                                                         fItem('COMTB5').AsFloat,
                                                                         fItem('COMTB5').AsFloat,

                                                                         fItem('MARBR6').AsFloat,
                                                                         fItem('MARBR6').AsFloat,

                                                                         fItem('PREVE6').AsFloat,
                                                                         fItem('PREVE6').AsFloat,

                                                                         fItem('COMTB6').AsFloat,
                                                                         fItem('COMTB6').AsFloat,

                                                                         fItem('MARBR7').AsFloat,
                                                                         fItem('MARBR7').AsFloat,

                                                                         fItem('PREVE7').AsFloat,
                                                                         fItem('PREVE7').AsFloat,

                                                                         fItem('COMTB7').AsFloat,
                                                                         fItem('COMTB7').AsFloat,

                                                                         fltPreCom,
                                                                         blnAltPre,

                                                                         strAutIncLOTPRE,

                                                                         fItem('TCIFCU').AsFloat,
                                                                         fItem('TCIFCU').AsFloat,
                                                                         fItem('TSCUST').AsFloat,
                                                                         fItem('TSCUST').AsFloat,
                                                                         cpcParams.curDePiCo,
                                                                         cpcParams.curDePiCo,
                                                                         cpcParams.curDeICMS,
                                                                         cpcParams.curDeICMS,
                                                                         cpcParams.curFatReg,
                                                                         cpcParams.curFatReg,

                                                                         IIF(recPreLot[1].blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco, 'S', 'N'));
                  End
                  Else
                  Begin
                    Result := Result And
                              objLotePrecos.fGravaLoteAlteracaoPrecoItem(strAutIncTmp,

                                                                         FieldByName('ENT_CODITE').AsString,

                                                                         fItem('PRECOM').AsFloat,
                                                                         fltComLot,

                                                                         fItem('DESF01').AsFloat,
                                                                         cpcParams.curDesF01,

                                                                         fItem('DESF02').AsFloat,
                                                                         cpcParams.curDesF02,

                                                                         fItem('DESF03').AsFloat,
                                                                         cpcParams.curDesF03,

                                                                         fItem('DESF04').AsFloat,
                                                                         cpcParams.curDesF04,

                                                                         fItem('DESF05').AsFloat,
                                                                         cpcParams.curDesF05,

                                                                         fItem('DESF06').AsFloat,
                                                                         cpcParams.curDesF06,

                                                                         fItem('ICMENT').AsFloat,
                                                                         cpcParams.curICMSEnt,

                                                                         fItem('SUBFED').AsFloat,
                                                                         cpcParams.curSubFed,

                                                                         fItem('IPIENT').AsFloat,
                                                                         cpcParams.curIPIEnt,

                                                                         fItem('FREENT').AsFloat,
                                                                         cpcParams.curFrete,

                                                                         fItem('VALFRE').AsFloat,
                                                                         cpcParams.curValFre,

                                                                         fItem('ACRFIN').AsFloat,
                                                                         cpcParams.curAcrFin,

                                                                         fItem('SUBSTI').AsFloat,
                                                                         cpcParams.curSubsti,

                                                                         fItem('DESADB').AsFloat,
                                                                         cpcParams.curDesAdb,

                                                                         fItem('OUTVAL').AsFloat,
                                                                         FieldByName('ENT_OUTVAL').AsFloat,

                                                                         fItem('IMPFED').AsFloat,
                                                                         FieldByName('ENT_IMPFED').AsFloat,

                                                                         fItem('DESOPE').AsFloat,
                                                                         FieldByName('ENT_DESOPE').AsFloat,

                                                                         fItem('PRECUS').AsFloat,
                                                                         fltCusLot,

                                                                         fItem('ICMSAI').AsFloat,
                                                                         FieldByName('ENT_ICMSAI').AsFloat,

                                                                         fItem('MARBR1').AsFloat,
                                                                         recPreLot[01].fltMarBru,

                                                                         fItem('PREVE1').AsFloat,
                                                                         recPreLot[01].fltPreVen,

                                                                         fItem('COMTB1').AsFloat,
                                                                         recPreLot[01].fltComiss,

                                                                         fItem('MARBR2').AsFloat,
                                                                         recPreLot[02].fltMarBru,

                                                                         fItem('PREVE2').AsFloat,
                                                                         recPreLot[02].fltPreVen,

                                                                         fItem('COMTB2').AsFloat,
                                                                         recPreLot[02].fltComiss,

                                                                         fItem('MARBR3').AsFloat,
                                                                         recPreLot[03].fltMarBru,

                                                                         fItem('PREVE3').AsFloat,
                                                                         recPreLot[03].fltPreVen,

                                                                         fItem('COMTB3').AsFloat,
                                                                         recPreLot[03].fltComiss,

                                                                         fItem('MARBR4').AsFloat,
                                                                         recPreLot[04].fltMarBru,

                                                                         fItem('PREVE4').AsFloat,
                                                                         recPreLot[04].fltPreVen,

                                                                         fItem('COMTB4').AsFloat,
                                                                         recPreLot[04].fltComiss,

                                                                         fItem('MARBR5').AsFloat,
                                                                         recPreLot[05].fltMarBru,

                                                                         fItem('PREVE5').AsFloat,
                                                                         recPreLot[05].fltPreVen,

                                                                         fItem('COMTB5').AsFloat,
                                                                         recPreLot[05].fltComiss,

                                                                         fItem('MARBR6').AsFloat,
                                                                         recPreLot[06].fltMarBru,

                                                                         fItem('PREVE6').AsFloat,
                                                                         recPreLot[06].fltPreVen,

                                                                         fItem('COMTB6').AsFloat,
                                                                         recPrecos[06].fltComiss,

                                                                         fItem('MARBR7').AsFloat,
                                                                         recPreLot[07].fltMarBru,

                                                                         fItem('PREVE7').AsFloat,
                                                                         recPreLot[07].fltPreVen,

                                                                         fItem('COMTB7').AsFloat,
                                                                         recPreLot[07].fltComiss,

                                                                         fltPreCom,
                                                                         blnAltPre,

                                                                         strAutIncLOTPRE,

                                                                         FieldByName('ENT_TCIFCU').AsFloat,
                                                                         fItem('TCIFCU').AsFloat,
                                                                         FieldByName('ENT_TSCUST').AsFloat,
                                                                         fItem('TSCUST').AsFloat,
                                                                         FieldByName('ENT_DEPICO').AsFloat,
                                                                         cpcParams.curDePiCo,
                                                                         FieldByName('ENT_DEICMS').AsFloat,
                                                                         cpcParams.curDeICMS,
                                                                         FieldByName('ENT_FATREG').AsFloat,
                                                                         cpcParams.curFatReg,

                                                                         IIF(recPreLot[1].blnHouveReducaoDePrecoEItemNaoAceitaReducaoPreco, 'S', 'N'));
                  End;
                  strAutIncLOTPRE := fNextAutoIncrem(strAutIncLOTPRE);

                  blnGerouLotDePreco := Result;
                  If blnGerouLotDePreco then
                    intQtdeItensLotPre := intQtdeItensLotPre + 1;
                End;

              End;

            End;

            {*****************************************}
            {* ATUALIZA O PCMDET                     *}
            {**************************************MV*}
            If ((strTipFor <> 'M') Or blnCarPro) And { Quando carregava itens do Pedido de Compra, não estava baixando o pedido de compra}
               (Not blnDevolu) And
               (Not fEmptyStr(strPedAnt)) And
               (oleItensPedidos = Null) Then //ESTAVA BAIXANDO AQUI E LOGO ABAIXO ESTAVA BAIXANDO NOVAMENTE QUANDO ERA DIGITACAO MANUAL
            Begin

              If Assigned(objEmbala) Then
                Result := Result And objEmbala.fConverteItemPedidoUnidadeVenda(FieldByName('ENT_SEQPCD').AsString,
                                                                               FieldByName('ENT_CODITE').AsString);

              If (Not blnConferenciaDepoisDaEntrada) or (blnGarantia) Then
                Result := Result And fAtualizaDadosPcmDet(FieldByName('ENT_QTDITE').AsFloat,
                                                          FieldByName('ENT_UNITAR').AsFloat,
                                                          FieldByName('ENT_NUMPED').AsString,
                                                          FieldByName('ENT_CODEMP').AsString,
                                                          FieldByName('ENT_SEQPCD').AsString,
                                                          IIF(fEmptyStr(strAutEle), '', strCodFor),
                                                          strCnvEmb,
                                                          Not fEmptyStr(strAutEle),
                                                          blnSaldoPendente,
                                                          blnLibPcm,
                                                          strForFil,
                                                          intDEQTPC);

              If Assigned(cdsDefBaixa) And Result Then
              Begin
                If Not cdsDefBaixa.Active Then
                  Result := cdsDefBaixa.fIniciaDados;

                cdsDefBaixa.pInsereBaixa(FieldByName('AUTOINCREMENTO_GRAVACAO').AsString,
                                         FieldByName('ENT_SEQPCD').AsString,
                                         FieldByName('ENT_QTDITE').AsFloat);
              End;

            End;

            fltSalRefRetRestante := FieldByName('ENT_QTDITE').AsFloat;
            For intIndexGarantia := 0 To stlPedidosGarantia.Count-1 Do
            Begin
              strNumPedGarantia := Copy( stlPedidosGarantia.Strings[intIndexGarantia],1, Pos(';',stlPedidosGarantia.Strings[intIndexGarantia])-1 );
              strEmpPedGarantia := Copy( stlPedidosGarantia.Strings[intIndexGarantia],Pos(';',stlPedidosGarantia.Strings[intIndexGarantia])+1, 3 );

              if fPedidoDeCompraOriundoDeGarantiaFilial(strNumPedGarantia, strEmpPedGarantia) Then
                pAtualizaLoteMovGad(strNumPedGarantia, strEmpPedGarantia);

              //Se for entrada por nota eletronica, verifica se é retorno de produto em garantia.
              If (strTipFor <> 'M') And
                 (not blnConferenciaDepoisDaEntrada) And blnRefEnt And
                  fPedidoDeCompraOriundoDeGarantia(strNumPedGarantia, strEmpPedGarantia) Then
              Begin
                Try
                  qryAuxRetFor := fCriaQuery;
                  qryInsRetFor := fCriaQuery;
                  objGarant    := TMovGag.Create(Nil);
                  With qryAuxRetFor, SQL Do
                  Begin
                    Close;
                    Clear;

                    Add(' SELECT DISTINCT G.AUTOINCREM AS INCGAD,                          ');
                    Add('                 IFNULL(E.GAE_QTDRET,0) AS QTDRET,                '); //Quantidade Já retornado do Fornecedor
                    Add('                 IFNULL(E.GAE_QTDREF,0) AS QTDREF,                '); //Quantidade Já Refugada Pelo Fornecedor
                    Add('                 IFNULL(E.GAE_RETCON,0) AS RETCON,                ');
                    Add('                 IFNULL(E.GAE_REFCON,0) AS REFCON,                ');
                    Add('                 E.AUTOINCREM AS INCGAE                           ');
                    Add(' FROM PCMDET P                                                    ');
                    Add('   LEFT JOIN MOVGAE E ON GAE_NUMENV = SUBSTRING(PCD_DOCORI,1,12)  ');
                    Add('                     AND GAE_ESPENV = SUBSTRING(PCD_DOCORI,13,2)  ');
                    Add('                     AND GAE_DTAENV = PCD_DTAPED                  ');
                    Add('                     AND GAE_EMPENV = PCD_CODEMP                  ');
                    Add('   INNER JOIN MOVGAD G ON G.AUTOINCREM = GAE_SEQGAD               ');
                    Add('                     AND PCD_CODITE = GAD_CODITE                  ');

                    Add(' WHERE PCD_NUMPED = :NUMPED                                       ');
                    Add('   AND PCD_CODEMP = :CODEMP                                       ');
                    Add('   AND PCD_ESPDOC = "PD"                                          ');
                    Add('   AND PCD_CODITE = :CODITE                                       ');
                    Add('   AND (IFNULL(E.GAE_RETCON,0) + IFNULL(E.GAE_REFCON,0)) > IFNULL(E.GAE_QTDRET,0) + IFNULL(E.GAE_QTDREF,0) ');

                    ParamByName('NUMPED').AsString := strNumPedGarantia;
                    ParamByName('CODEMP').AsString := strEmpPedGarantia;
                    ParamByName('CODITE').AsString := qryEntMer.FieldByName('ENT_CODITE').AsString;

                    Open;

                  End;

                  While (Not qryAuxRetFor.Eof) And (fltSalRefRetRestante > 0) Do
                  Begin

                    fltSalRet := qryAuxRetFor.FieldByName('RETCON').AsFloat;
                    fltSalRef := qryAuxRetFor.FieldByName('REFCON').AsFloat;

                    fltSalRefRetRestante := fltSalRefRetRestante - (fltSalRet + fltSalRef);
                    if (fltSalRet + fltSalRef) = 0 Then
                    Begin
                      qryAuxRetFor.Next;
                      Continue;
                    End;
                    If fItemJaProcessado(qryAuxRetFor.FieldByName('INCGAE').AsString,
                                         qryAuxRetFor.FieldByName('INCGAD').AsString) Then
                    Begin
                      qryAuxRetFor.Next;
                      Continue;
                    End;

                    qryInsRetFor.Close;
                    qryInsRetFor.SQL.Text := objGarant.objMovGad.fSQLInsereTabelaAux;

                    strIncGau := fRetAutoIncrem('MOVGAU', VS_strCodEmp);
                    qryInsRetFor.ParamByName('AUTINC').AsString := strIncGau;
                    qryInsRetFor.ParamByName('SEQGAD').AsString := qryAuxRetFor.FieldByName('INCGAD').AsString;
                    qryInsRetFor.ParamByName('ESPDOC').AsString := strEspDoc;
                    qryInsRetFor.ParamByName('CODITE').AsString := FieldByName('ENT_CODITE').AsString;
                    qryInsRetFor.ParamByName('QTDRET').AsFloat  := fltSalRet;
                    qryInsRetFor.ParamByName('QTDREF').AsFloat  := 0.00;
                    qryInsRetFor.ParamByName('SEQDET').AsString := strAutIncTmp;
                    qryInsRetFor.ParamByName('SEQGAE').AsString := qryAuxRetFor.FieldByName('INCGAE').AsString;
                    qryInsRetFor.ExecSQL;

                    If fltSalRef > 0 Then
                    Begin
                      qryInsRetFor.Close;
                      qryInsRetFor.SQL.Text := 'UPDATE MOVGAU SET GAU_QTDREF = IFNULL(GAU_QTDREF,0) + :QTDREF WHERE AUTOINCREM = :AUTINC ';
                      qryInsRetFor.ParamByName('AUTINC').AsString := strIncGau;
                      qryInsRetFor.ParamByName('QTDREF').AsFloat  := fltSalRef;
                      qryInsRetFor.ExecSQL;
                    End;

                    qryInsRetFor.Close;
                    With qryInsRetFor, SQL Do
                    Begin
                      Clear;

                      Add(' UPDATE MOVGAD SET GAD_QTDRET = IFNULL(GAD_QTDRET,0) + :QTDRET, ');
                      If not blnDocumentoGeraEnderecamento Then
                        Add('                 GAD_QTDREF = IFNULL(GAD_QTDREF,0) + :QTDREF, ');
                      Add('                   GAD_DTARET = ' + fCurrentDate + ', ');
                      Add('                   GAD_NUMRET = :NUMRET               ');
                      Add(' WHERE AUTOINCREM = :AUTINC                           ');
                    End;

                    qryInsRetFor.ParamByName('QTDRET').AsFloat  := fltSalRet;
                    If not blnDocumentoGeraEnderecamento Then
                      qryInsRetFor.ParamByName('QTDREF').AsFloat  := fltSalRef;
                    qryInsRetFor.ParamByName('NUMRET').AsString := strNumDoc;
                    qryInsRetFor.ParamByName('AUTINC').AsString := qryAuxRetFor.FieldByName('INCGAD').AsString;
                    qryInsRetFor.ExecSQL;

                    qryInsRetFor.Close;
                    With qryInsRetFor, SQL Do
                    Begin
                      Clear;

                      Add(' UPDATE MOVGAE SET GAE_QTDRET = IFNULL(GAE_QTDRET,0) + :QTDRET, ');
                      Add('                   GAE_QTDREF = IFNULL(GAE_QTDREF,0) + :QTDREF  ');
                      Add(' WHERE AUTOINCREM = :AUTINC ;                          ');
                      Add('                        ');
                      Add(' UPDATE MOVGAD ');
                      Add(' INNER JOIN ITEGER ON GAD_CODITE = ITE_CODITE AND GAD_CODEMP = ITE_CODEMP ');
                      Add(' SET ITE_REPAUD = "S" ');
                      Add(' WHERE MOVGAD.AUTOINCREM = "' + qryAuxRetFor.FieldByName('INCGAD').AsString + '"; ');
                    End;

                    qryInsRetFor.ParamByName('QTDRET').AsFloat  := fltSalRet;
                    qryInsRetFor.ParamByName('QTDREF').AsFloat  := fltSalRef;
                    qryInsRetFor.ParamByName('AUTINC').AsString := qryAuxRetFor.FieldByName('INCGAE').AsString;
                    qryInsRetFor.ExecSQL;

                    qryAuxRetFor.Next;
                  End;

                Finally
                  FreeAndNil(objGarant);
                  FreeAndNil(qryAuxRetFor);
                  FreeAndNil(qryInsRetFor);
                End;
              End;
            End;

            Next;
            strNumLotVen := '';
            blnTemlot := False;

            if ( objLote <> nil ) then // destroy o objeto do lote/armazem
              FreeAndNil(objLote);

            If Assigned(pgbDados) Then
            Begin
              pgbDados.StepBy(1);
              Application.ProcessMessages;
            End
            Else If Assigned(objEntAuto) Then
            Begin
              objEntAuto.cxProgressoAuto.Position := objEntAuto.cxProgressoAuto.Position + 1;
              Application.ProcessMessages;
            End;

          End; {While (Not Eof)                                        And
                (strPedAnt = FieldByName('ENT_NUMPED').AsString) And
                (strEmpAnt = FieldByName('ENT_CODEMP').AsString) Do}

          If Not Result Then
            Break;

        End;  {While (Not Eof) And (Result) Do}

        if Result And fEhRecClienteGarantia(blnRecCliGarantia, cdsMovGad) Then
        begin
          Result := TControleChavesGarantia.fGerarVinculosMOVGRC;
          TControleChavesGarantia.pReiniciarProcessoGarantia;
        end;

        If (strTipFor <> 'M')  Then
        Begin

          If blnRefEnt And
            (strEmpGar = VS_strCodEmp) And
            (not blnDocumentoGeraEnderecamento) Then
          Begin
            Result := Result And fTrataRecebimentoDeGarantiaFilial;
          End;

        End;
        If TipoCfop <> tcCFOP922 Then
          Result := Result And fBaixaPedidosEntrada;

        If Assigned(frmVinculoBaixaEntregaFuturaEdocVenda) Then
           Result := Result And frmVinculoBaixaEntregaFuturaEdocVenda.fGravaVinculosNoBanco;

        If (Result) And (blnDevolu) And VS_strHabilitarCRM Then
        Begin
          If (Not fEmptyStr(strNumAde)) Then
          Begin
            strTabela := 'MOVDET';

            Result := fAtualizaOcorrenciaDevolucaoCRM(strNumAde, dtaDtaEnt,
                                                      strNumDoc, strEspDoc, VS_strCodEmp,
                    strCodFor, strSerie, strLoginUsuarioLogado, fltVlrCon, strTabela);

            Result := Result And
              fEnviaMensagemDevolucaoParaOperadorAD(strNumAde, strCodFor,
                      strNumDoc + '-' + strEspDoc + '-' + strSerie + '-' + strCodEmp);

            If Result Then
              pMarcaDocumentoDevAD(strNumAde, VS_strCodEmp, strNumDoc, strEspDoc, strCodEmp);
          End
          Else
          If not fEmptyStr( fCfgSis('VENDEV', varString) ) Then
          Begin
            Try
              objAtuOcoCrm := TAtuOcoCrm.Create(Nil);
              objAtuOcoCrm.strNomFrm := '[fConfirmaEntradaMercadorias]';
              objAtuOcoCrm.strCodCli := strCodFor;
              objAtuOcoCrm.strDtaInc := VS_Date;
              objAtuOcoCrm.strHorInc := fRetHoraServidor();
              objAtuOcoCrm.strDtaAge := objAtuOcoCrm.strDtaInc;
              objAtuOcoCrm.strHorAge := objAtuOcoCrm.strHorInc;
              objAtuOcoCrm.strDtaCon := objAtuOcoCrm.strDtaInc;
              objAtuOcoCrm.strHorCon := objAtuOcoCrm.strHorInc;
              objAtuOcoCrm.strOpeHis := strLoginUsuarioLogado;
              objAtuOcoCrm.strCodOpe := strLoginUsuarioLogado;
              objAtuOcoCrm.strDescri := 'Devolução número: ' + strNumDoc + '-' + strEspDoc + '-' + strSerie + '-' + strCodEmp +
                                        '<<csq>><<csq>>Operador Origem : ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                         FormatDateTime('dd/mm/yyyy', VS_Date) + ' ' + FormatDateTime('hh:nn:ss', fNow) + ' - ' +
                                         strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado) + '<<csq>>' +
                                         TListarProdutosDevolvidos.New(strNumDoc, strEspDoc, strCodEmp,
                                           strSerie, strCodFor).fGetProdutos;
              objAtuOcoCrm.strCodEmp := VS_strCodEmp;
              objAtuOcoCrm.strCodToc := fCfgSis('VENDEV', varString);
              objAtuOcoCrm.pInsereNovaOcorrencia;
              objAtuOcoCrm.pInsereHistoricoOcorrencia;
            Finally
              FreeAndNil(objAtuOcoCrm);
            End;
          End;
        End; {While (Not Eof) And (Result) Do}

        If (Result) And (intQtdeItensLotPre > 0) And (Not blnRetornoSimbolico) then
          objLotePrecos.pMensagemLotePrecoAtivar(intQtdeItensLotPre,DateToStr(dtaDtaDoc));

        If Result And Assigned(cdsDefBaixa)  Then
        Begin
          cdsDefBaixa.blnx922 := TipoCfop = tcCFOP922;
          Result := cdsDefBaixa.fSalva;
        End;

        If Result And (Assigned(cdsDefBaixa)) And ((TipoCfop = tcCFOP922) or (TipoCfop = tcCFOP117)) Then
          Result := cdsDefBaixa.fBaixaEntregaFuturaPedido(TipoCfop);


        If blnDocumentoGeraEnderecamento Then
          Result := Result And fGerarPedidosReservaEstoque(strNumDoc, strEspDoc, strSerie, strCodFor, strCodEmp,
             qryEntMer, qryConIte, blnDevolu, blnRecCliGarantia, blnConEqu, AblnAcessadoViaRetornoConsignacao, objCadLot,ArrMarcaProAcaEndere, pgbDados);

        If Result Then
        begin
          If (LeftStr(strClaFis, 1) = '3') And (Not blnDevolu) And (Not blnConEqu) Then
            pApagaNotaImportacao(strNumDoc, strEspDoc, strCodEmp, strCodFor, strSerie);
        End;

        If Result and blnDeveGerarDigCon and (not fEmptyStr(strAutEle)) and
          (Not blnConferenciaDepoisDaEntrada) and (fCfgSis('UDEVME', VarBoolean)) then
        begin
          strIdeDig := TDistribuicaoConferencia.GetIdeDigByIncGerEle(strAutEle);
          If not fEmptyStr(strIdeDig) then
          begin
            lDistribuicaoConferencia := TDistribuicaoConferenciaFactory.CriarPorIDeDig(strIdeDig);
            Try
              lDistribuicaoConferencia.fGravaLiberacaoEnderecamento;
              lDistribuicaoConferencia.fFinalizaConferencia;
            finally
              FreeAndNil(lDistribuicaoConferencia);
            End;
          end;
        End;

        {*******************************************}
        {* SE FOR CAIXA 1 ENTAO GRAVA O LIVRO      *}
        {****************************************AF*}
        If Result And SameText(strEspDoc, 'NF') Then
        Begin

          {*****************************************}
          {* GRAVA O CADFIS                        *}
          {**************************************MV*}
          With dtsCadFis Do
          Begin
            if Assigned(FindField('FIS_NATOPE')) then
              strNatOpeCadFis := FieldByName('FIS_NATOPE').AsString;

            strClaFis := FieldByName('FIS_CLFSC1').AsString;
            strForCli := FieldByName('FIS_FORCLI').AsString;

            Application.ProcessMessages;

            If (fSetaPais = opcParaguai) Then
            Begin
              fltVlIva0 := FieldByName('FIS_VLIVA0').AsFloat;
              fltVlIva5 := FieldByName('FIS_VLIVA5').AsFloat;
              fltVIva10 := FieldByName('FIS_VIVA10').AsFloat;
            End
            Else
            Begin
              fltVlIva0 := 0;
              fltVlIva5 := 0;
              fltVIva10 := 0;
            End;

            strTB01RE := EmptyStr;
            strTB06RE := EmptyStr;
            if (FieldByName('FIS_TIP_FC').AsString = 'F') and
               (fObrigaTipoServicoNaturezaRendimentoREINF('F', FieldByName('FIS_FORCLI').AsString)) then
            begin
              strTB01RE := fCampoTabela('FOR_TB01RE', 'CADFOR', ['FOR_CODFOR'], [FieldByName('FIS_FORCLI').AsString]);
                strTB06RE := fCampoTabela('FOR_TB06RE', 'CADFOR', ['FOR_CODFOR'], [FieldByName('FIS_FORCLI').AsString]);
            end;

            pArrLivFisRT := Nil;
            If Assigned(FindField('FIS_VLCBS1')) And ((fltTotCbsRT + fltTotIbsRT + fltTotIsRT) > 0) Then
            Begin
              For intBlocoRT := Low(arrLivFisRT) To High(arrLivFisRT) Do
              Begin
                arrLivFisRT[intBlocoRT].strClaFis := '';
                arrLivFisRT[intBlocoRT].fltBasCbs := 0;
                arrLivFisRT[intBlocoRT].fltVlrCbs := 0;
                arrLivFisRT[intBlocoRT].fltBasIbs := 0;
                arrLivFisRT[intBlocoRT].fltVlrIbs := 0;
                arrLivFisRT[intBlocoRT].fltBas_IS := 0;
                arrLivFisRT[intBlocoRT].fltVlr_IS := 0;
              End;

              For intBlocoRT := 1 To 5 Do
              Begin
                strBlocoRT := IntToStr(intBlocoRT);
                arrLivFisRT[intBlocoRT].strClaFis := FieldByName('FIS_CLFSC' + strBlocoRT).AsString;
                arrLivFisRT[intBlocoRT].fltVlrCbs := FieldByName('FIS_VLCBS' + strBlocoRT).AsFloat;
                arrLivFisRT[intBlocoRT].fltVlrIbs := FieldByName('FIS_VLIBS' + strBlocoRT).AsFloat;
                arrLivFisRT[intBlocoRT].fltVlr_IS := FieldByName('FIS_VL_IS' + strBlocoRT).AsFloat;
                If Assigned(FindField('FIS_BCCBS' + strBlocoRT)) Then
                Begin
                  arrLivFisRT[intBlocoRT].fltBasCbs := FieldByName('FIS_BCCBS' + strBlocoRT).AsFloat;
                  arrLivFisRT[intBlocoRT].fltBasIbs := FieldByName('FIS_BCIBS' + strBlocoRT).AsFloat;
                  arrLivFisRT[intBlocoRT].fltBas_IS := FieldByName('FIS_BC_IS' + strBlocoRT).AsFloat;
                End;
              End;
              pArrLivFisRT := @arrLivFisRT;
            End;

            Result := Result And
                      fGravaCadFis(strAutIncCadFis,
                                   IIF(fZeraDataEntrada(ValidacaoZeraData), 0, FieldByName('FIS_DTAENT').AsDateTime), // Data de Entrada
                                   FieldByName('FIS_NUMDOC').AsString,   // Número do Documento
                                   FieldByName('FIS_NUMDO2').AsString,   // Número do Documento 2
                                   FieldByName('FIS_ESPDOC').AsString,   // Espécie
                                   FieldByName('FIS_ENTSAI').AsString,   // Entrada / Saida
                                   FieldByName('FIS_DTADOC').AsDateTime, // Data do Documento
                                   IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, 'C', FieldByName('FIS_TIP_FC').AsString), // Tipo (F)ornecedor / (C)liente
                                   FieldByName('FIS_FORCLI').AsString,   // Código Fornecedor / Cliente
                                   FieldByName('FIS_HISTOR').AsString,   // Histórico
                                   FieldByName('FIS_NFCOMP').AsString,   // ???
                                   FieldByName('FIS_NOTESP').AsString,   // ???
                                   FieldByName('FIS_CLFSC1').AsString,   // Classificação Fiscal 1
                                   FieldByName('FIS_VLCON1').AsFloat,    // Valor Contábil 1
                                   FieldByName('FIS_BASIC1').AsFloat,    // Base de ICMS 1
                                   FieldByName('FIS_ALQIC1').AsFloat,    // Aliquota de ICMS 1
                                   FieldByName('FIS_VLRIC1').AsFloat,    // Valor de ICMS 1
                                   FieldByName('FIS_OUTRA1').AsFloat,    // Valor de Outras 1
                                   FieldByName('FIS_ISENT1').AsFloat,    // Valor de Isento 1
                                   FieldByName('FIS_RETID1').AsFloat,    // Valor de Retido 1
                                   FieldByName('FIS_BASIP1').AsFloat,    // Base de IPI 1
                                   FieldByName('FIS_VLRIP1').AsFloat,    // Valor de IPI 1
                                   FieldByName('FIS_BCRET1').AsFloat,    // Base de Substituição 1
                                   FieldByName('FIS_DACES1').AsFloat,    // Valor de Despesa Acessária 1
                                   0.0,                                  // Valor do ISS 1
                                   FieldByName('FIS_CLFSC2').AsString,   // Classificação Fiscal 2
                                   FieldByName('FIS_VLCON2').AsFloat,    // Valor Contábil 2
                                   FieldByName('FIS_BASIC2').AsFloat,    // Base de ICMS 2
                                   FieldByName('FIS_ALQIC2').AsFloat,    // Aliquota de ICMS 2
                                   FieldByName('FIS_VLRIC2').AsFloat,    // Valor de ICMS 2
                                   FieldByName('FIS_OUTRA2').AsFloat,    // Valor de Outras 2
                                   FieldByName('FIS_ISENT2').AsFloat,    // Valor de Isento 2
                                   FieldByName('FIS_RETID2').AsFloat,    // Valor de Retido 2
                                   FieldByName('FIS_BASIP2').AsFloat,    // Base de IPI 2
                                   FieldByName('FIS_VLRIP2').AsFloat,    // Valor de IPI 2
                                   FieldByName('FIS_BCRET2').AsFloat,    // Base de Substituição 2
                                   FieldByName('FIS_DACES2').AsFloat,    // Valor de Despesa Acessária 2
                                   0.0,                                  // Valor do ISS 2
                                   FieldByName('FIS_CLFSC3').AsString,   // Classificação Fiscal 3
                                   FieldByName('FIS_VLCON3').AsFloat,    // Valor Contábil 3
                                   FieldByName('FIS_BASIC3').AsFloat,    // Base de ICMS 3
                                   FieldByName('FIS_ALQIC3').AsFloat,    // Aliquota de ICMS 3
                                   FieldByName('FIS_VLRIC3').AsFloat,    // Valor de ICMS 3
                                   FieldByName('FIS_OUTRA3').AsFloat,    // Valor de Outras 3
                                   FieldByName('FIS_ISENT3').AsFloat,    // Valor de Isento 3
                                   FieldByName('FIS_RETID3').AsFloat,    // Valor de Retido 3
                                   FieldByName('FIS_BASIP3').AsFloat,    // Base de IPI 3
                                   FieldByName('FIS_VLRIP3').AsFloat,    // Valor de IPI 3
                                   FieldByName('FIS_BCRET3').AsFloat,    // Base de Substituição 3
                                   FieldByName('FIS_DACES3').AsFloat,    // Valor de Despesa Acessária 3
                                   0.0,                                  // Valor do ISS 3
                                   FieldByName('FIS_CLFSC4').AsString,   // Classificação Fiscal 4
                                   FieldByName('FIS_VLCON4').AsFloat,    // Valor Contábil 4
                                   FieldByName('FIS_BASIC4').AsFloat,    // Base de ICMS 4
                                   FieldByName('FIS_ALQIC4').AsFloat,    // Aliquota de ICMS 4
                                   FieldByName('FIS_VLRIC4').AsFloat,    // Valor de ICMS 4
                                   FieldByName('FIS_OUTRA4').AsFloat,    // Valor de Outras 4
                                   FieldByName('FIS_ISENT4').AsFloat,    // Valor de Isento 4
                                   FieldByName('FIS_RETID4').AsFloat,    // Valor de Retido 4
                                   FieldByName('FIS_BASIP4').AsFloat,    // Base de IPI 4
                                   FieldByName('FIS_VLRIP4').AsFloat,    // Valor de IPI 4
                                   FieldByName('FIS_BCRET4').AsFloat,    // Base de Substituição 4
                                   FieldByName('FIS_DACES4').AsFloat,    // Valor de Despesa Acessária 4
                                   0.0,                                  // Valor do ISS 4
                                   FieldByName('FIS_CLFSC5').AsString,   // Classificação Fiscal 5
                                   FieldByName('FIS_VLCON5').AsFloat,    // Valor Contábil 5
                                   FieldByName('FIS_BASIC5').AsFloat,    // Base de ICMS 5
                                   FieldByName('FIS_ALQIC5').AsFloat,    // Aliquota de ICMS 5
                                   FieldByName('FIS_VLRIC5').AsFloat,    // Valor de ICMS 5
                                   FieldByName('FIS_OUTRA5').AsFloat,    // Valor de Outras 5
                                   FieldByName('FIS_ISENT5').AsFloat,    // Valor de Isento 5
                                   FieldByName('FIS_RETID5').AsFloat,    // Valor de Retido 5
                                   FieldByName('FIS_BASIP5').AsFloat,    // Base de IPI 5
                                   FieldByName('FIS_VLRIP5').AsFloat,    // Valor de IPI 5
                                   FieldByName('FIS_BCRET5').AsFloat,    // Base de Substituição 5
                                   FieldByName('FIS_DACES5').AsFloat,    // Valor de Despesa Acessária 5
                                   0.0,                                  // Valor do ISS 5
                                   fltTotPis,
                                   fltTotCof,
                                   fltTotBasPis,
                                   fltTotBasCof,
                                   fltTotAlqPis,
                                   fltTotAlqCof,
                                   VS_strCodEmp,                         // Empresa
                                   FieldByName('FIS_SERIE_').AsString,   // Série
                                   FieldByName('FIS_ESTADO').AsString,   // Estado do Cliente / Fornecedor
                                   '',                                   // Número de Série
                                   '',                                   // Número COO
                                   strCodCon,                            // Código da Conta Contábil
                                   '',                                   // Documento do conhecimento de frete
                                   str_Chave,                            // Chave de Acesso NF-e
                                   '',                                   // Numero protocolo NF-e
                                   IIF((blnRecCliGarantia) Or (blnConEqu), '', IIF(blnGarantia,'G', IIF(blnDevolu Or AblnAcessadoViaRetornoConsignacao, 'D', ''))),              // Origem do documento
                                   '',
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   0,
                                   '',
                                   '',
                                   strModFre,
                                   fltVlIva0,
                                   fltVlIva5,
                                   fltVIva10,
                                   0, // fltBaseII
                                   0, // fltDesAdu
                                   0, // fltValIOF
                                   FieldByName('FIS_BASAN1').AsFloat,
                                   FieldByName('FIS_ANTIC1').AsFloat,
                                   FieldByName('FIS_BASAN2').AsFloat,
                                   FieldByName('FIS_ANTIC2').AsFloat,
                                   FieldByName('FIS_BASAN3').AsFloat,
                                   FieldByName('FIS_ANTIC3').AsFloat,
                                   FieldByName('FIS_BASAN4').AsFloat,
                                   FieldByName('FIS_ANTIC4').AsFloat,
                                   FieldByName('FIS_BASAN5').AsFloat,
                                   FieldByName('FIS_ANTIC5').AsFloat,
                                   '',
                                   False,
                                   FieldByName('FIS_BAERE1').AsFloat,
                                   FieldByName('FIS_VAERE1').AsFloat,
                                   FieldByName('FIS_BAERE2').AsFloat,
                                   FieldByName('FIS_VAERE2').AsFloat,
                                   FieldByName('FIS_BAERE3').AsFloat,
                                   FieldByName('FIS_VAERE3').AsFloat,
                                   FieldByName('FIS_BAERE4').AsFloat,
                                   FieldByName('FIS_VAERE4').AsFloat,
                                   FieldByName('FIS_BAERE5').AsFloat,
                                   FieldByName('FIS_VAERE5').AsFloat,
                                   FieldByName('FIS_BAEIP1').AsFloat,
                                   FieldByName('FIS_VAEIP1').AsFloat,
                                   FieldByName('FIS_BAEIP2').AsFloat,
                                   FieldByName('FIS_VAEIP2').AsFloat,
                                   FieldByName('FIS_BAEIP3').AsFloat,
                                   FieldByName('FIS_VAEIP3').AsFloat,
                                   FieldByName('FIS_BAEIP4').AsFloat,
                                   FieldByName('FIS_VAEIP4').AsFloat,
                                   FieldByName('FIS_BAEIP5').AsFloat,
                                   FieldByName('FIS_VAEIP5').AsFloat,
                                   CalcResult.strCstPis,                // strCtsPis
                                   CalcResult.strCstCof,                // strCtsCof
                                   strCodMod,
                                   '',
                                   FieldByName('FIS_BFCPS1').AsFloat,
                                   FieldByName('FIS_VFCPS1').AsFloat,
                                   FieldByName('FIS_BFCPS2').AsFloat,
                                   FieldByName('FIS_VFCPS2').AsFloat,
                                   FieldByName('FIS_BFCPS3').AsFloat,
                                   FieldByName('FIS_VFCPS3').AsFloat,
                                   FieldByName('FIS_BFCPS4').AsFloat,
                                   FieldByName('FIS_VFCPS4').AsFloat,
                                   FieldByName('FIS_BFCPS5').AsFloat,
                                   FieldByName('FIS_VFCPS5').AsFloat,
                                   0,                                   // fltALQFCP
                                   0,                                   // ffltTotRmm
                                   '',                                  // fstrCodTra
                                   FieldByName('FIS_REIRRF').AsFloat,   // fltIrSeRt:
                                   FieldByName('FIS_VREPIS').AsFloat,   // fltPiSeRt:
                                   FieldByName('FIS_VRECOF').AsFloat,   // fltCoSeRt:
                                   FieldByName('FIS_RECSSL').AsFloat,   // fltCsSeRt:
                                   FieldByName('FIS_RETISS').AsFloat,   // fltRetISS:
                                   FieldByName('FIS_REINSS').AsFloat,   // fltRetINS:
                                   FieldByName('FIS_BAFCP1').AsFloat,
                                   FieldByName('FIS_VLFCP1').AsFloat,
                                   FieldByName('FIS_BAFCP2').AsFloat,
                                   FieldByName('FIS_VLFCP2').AsFloat,
                                   FieldByName('FIS_BAFCP3').AsFloat,
                                   FieldByName('FIS_VLFCP3').AsFloat,
                                   FieldByName('FIS_BAFCP4').AsFloat,
                                   FieldByName('FIS_VLFCP4').AsFloat,
                                   FieldByName('FIS_BAFCP5').AsFloat,
                                   FieldByName('FIS_VLFCP5').AsFloat,
                                   '',
                                   0,
                                   0,
                                   0,
                                   '',
                                   'N',
                                   0,
                                   '',
                                   '',
                                   IIF(not fEmptyStr(strNatOpeCadFis), strNatOpeCadFis, strNatOpe),
                                   strTB01RE,
                                   strTB06RE,
                                    '', //strBasFre
                                    False, //blnDevSim
                                    '', //strCdsErv
                                    FieldByName('FIS_QBCMO1').AsFloat,
                                    FieldByName('FIS_QBCMO2').AsFloat,
                                    FieldByName('FIS_QBCMO3').AsFloat,
                                    FieldByName('FIS_QBCMO4').AsFloat,
                                    FieldByName('FIS_QBCMO5').AsFloat,
                                    FieldByName('FIS_QBCMO6').AsFloat,
                                    FieldByName('FIS_QBCMO7').AsFloat,
                                    FieldByName('FIS_QBCMO8').AsFloat,
                                    FieldByName('FIS_ADREM1').AsFloat,
                                    FieldByName('FIS_ADREM2').AsFloat,
                                    FieldByName('FIS_ADREM3').AsFloat,
                                    FieldByName('FIS_ADREM4').AsFloat,
                                    FieldByName('FIS_ADREM5').AsFloat,
                                    FieldByName('FIS_ADREM6').AsFloat,
                                    FieldByName('FIS_ADREM7').AsFloat,
                                    FieldByName('FIS_ADREM8').AsFloat,
                                    FieldByName('FIS_VALMO1').AsFloat,
                                    FieldByName('FIS_VALMO2').AsFloat,
                                    FieldByName('FIS_VALMO3').AsFloat,
                                    FieldByName('FIS_VALMO4').AsFloat,
                                    FieldByName('FIS_VALMO5').AsFloat,
                                    FieldByName('FIS_VALMO6').AsFloat,
                                    FieldByName('FIS_VALMO7').AsFloat,
                                    FieldByName('FIS_VALMO8').AsFloat,
                                    '',//strNfsSub
                                    '',//strMesAno
                                    '',// strFinNfe
                                    '', // strFinTip
                                    fltTotIbsRT,    // fltTotIbs  -> FIS_TOTIBS {Req. 410369}
                                    fltTotCbsRT,    // fltTotCbs  -> FIS_TOTCBS
                                    fltTotIsRT,     // fltTotIs   -> FIS_TOT_IS
                                    fltTotProIsRT,  // fltTotProIs -> FIS_TPROIS
                                    fltTotNfRT,     // fltTotNf   -> FIS_TOT_NF
                                    '', //strNumDPS
                                    '', //strSerDPS
                                    '',             // strCodCCE
                                    '',             // strCodGRT
                                    pArrLivFisRT);  // pArrLivFis -> AUXFIS


          End;
          Result := Result And fAtualizaDocumentoOriginal(arrDocOri, strNumDoc, strEspDoc);
          if (fCfgSis('GIPCAT') = 'S') And (Pos(strEspDoc,'IF_NF_') > 0) then
          begin
            Result := Result And fGravaPortariaCAT(VS_strCodEmp, IfThen(blnOpeGad, strCodVenGag, strCodOpe), strEspDoc, strNumDoc, strClaFis, strForCli);
          End;
        End;

        {*******************************************}
        {* VERIFICA SE GRAVA FINANCEIRO            *}
        {****************************************AF*}
        If Result And (blnGraFin) And (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao])) Then
        Begin

          if (AblnAcessadoViaRetornoConsignacao) then
            pCarregarDuplicataAReceberParaRetornoConsignacao(strAutEle,
                                                             strNumDoc,
                                                             strEspDoc,
                                                             strCodEmp,
                                                             strCodFor,
                                                             IIF(blnDevolu Or blnConEqu Or AblnAcessadoViaRetornoConsignacao, 'C', 'F'),
                                                             arrDuplicata);

          SetLength(arrDuplicVend,0);
          SetLength(arrDuplicRepr,0);

          If (blnDevolu) or
             ((AblnAcessadoViaRetornoConsignacao) and (Pos(FieldByName('ENT_CLAFIS').AsString, fTransform(fCfgSis('CLADSC'), 4)) <= 0)) Then
          Begin

            intContador := 0;
            {*****************************************}
            {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
            {**************************************MV*}
            While (ArrDuplicata[intContador].dtaDtaVen <> '') And
                  (intContador < 24)                          And
                  (Result)                                    Do
            Begin

              strHistorico := '';

              If Not fEmptyStr(strHisCtp) Then
                strHistorico := strHisCtp;

              If (fCfgSis('HISCTP', varBoolean)) Then
              begin
                if not fEmptyStr(strHistorico) then
                  strHistorico := strHistorico + #13;

                if fEmptyStr(strHistoricoCred) then
                begin
                  strHistoricoCred := fHistoricoDocDevSelecionado(strNumDoc, strEspDoc, strCodEmp, fltVlrCon);
                end;

                strHistorico := strHistorico + 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc +
                                ', no valor total de ' + FormatFloat('R$ ###,##0.000', fltVlrCon);
              end;

              strHisBai := '';
              strCtaBai := '';
              strDocBai := '';
              strOpeBai := '';
              dtaDtaPag := 0;
              fltValPag := 0;
              strSeqLan := '';
              strCodPor := strPorBai;
              strEmpBai := '';

              If intContador = 0 Then
              Begin
                fDigDuplicVar(strCndPag, 0, fltVlrComGeral, False, False, False, VS_Date, False, arrDuplicVend, arrDuplicata, 0, 'N', False);
                fDigDuplicVar(strCndPag, 0, fltTotExtGeral, False, False, False, VS_Date, False, arrDuplicRepr, arrDuplicata, 0, 'N', False);
              End;

              fltValAux := IIF(arrDuplicata[intContador].curValor = 0, 1, arrDuplicata[intContador].curValor);

              If (fCfgSis('BAIAVI', varBoolean))                            And
                 (IIF(blnDevolu, fCfgSis('TROQUI', varBoolean), True))      And
                 (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) And
                 (not AblnAcessadoViaRetornoConsignacao) Then
              Begin
                lstBanCtp := TBanCtpRepository.Create;
                lstBanCtp.fAdd(strNumDoc,
                               'A',
                               strSerie,
                               VS_strCodEmp,
                               '',
                               strHistorico + Chr(13) + ' Cliente: ' + strCodFor,
                               '',
                               strCodCta,
                               VS_strCodEmp,
                               0,
                               ArrDuplicata[intContador].curValor,
                               0,
                               0,
                               0,
                               0);

                strSeqLan := fGravaMovBan(strCodCta,                                                    // Centro de Custo
                                          strCodPor,                                                    // Portador da Baixa
                                          strCodOpe,                                                    // Operador da Baixa
                                          dtaDtaEnt,                                                    // Data do Lançamento
                                          fTime(),                                                      // Hora do Lançamento
                                          fStrZero(strNumDoc, 12),                                       // Numero do Documento
                                          'D',                                                          // Credito / Debito
                                          VS_strCodEmp,                                                 // Empresa da Baixa
                                          ArrDuplicata[intContador].curValor,                           // Valor Do Lançamento
                                          strHistorico, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                                          '',                                                           // Histórico 2
                                          strCodFor,                                                    // Cliente da Duplicata
                                          '',                                                           // Fornecedor da Duplicata
                                          fStrZero(strNumDoc, 12),                                       // Número da Duplicata
                                          0,                                                            // Sequencial de Baixa
                                          'A',                                                          // Parcela da Duplicata
                                          VS_strCodEmp,                                                 // Empresa da Duplicata
                                          strSerie,                                                     // Série
                                          '',                                                           // Código do Evento
                                          '',                                                           // Documento da Baixa
                                          lstBanCtp.fGetList                                            // Log Bancário
                                         );

                FreeAndNil(lstBanCtp);

                Result := Not fEmptyStr(strSeqLan);

                If (fCfgSis('HISCTP', varBoolean)) Then
                  strHisBai := 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc
                Else
                  strHisBai := '';

                strCtaBai := strCodCta;
                strDocBai := strSeqLan;
                strOpeBai := strLoginUsuarioLogado;
                dtaDtaPag := VS_Date;
                fltValPag := ArrDuplicata[intContador].curValor;
                strEmpBai := VS_strCodEmp;

              End;

              If Result And blnDevolu Then
                Result := fGravaMovModDevolucao;

              if AblnAcessadoViaRetornoConsignacao then
              Begin
                strHistorico := 'RETORNO CONSIG - ' + strNumDoc + '-' + strEspDoc;

                strCodPor := fCfgSis('PORCON', varString);
                If Not fEmpresaTemAcessoPortador(strCodPor) Then
                Begin
                  pMensagemOk('Empresa sem acesso para utilizar o portador '+ strCodPor +'. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".');
                  Result := False;
                  Exit;
                End;

                If fCfgSis('DACPOR', varBoolean) Then
                Begin
                  If Pos(strCodPor, strPortadoresOperador) <= 0 Then
                  Begin
                    pMensagemOk('Portador ' + strCodPor + ' não permitido para o operador ' + strLoginUsuarioLogado);
                    Result := False;
                    Exit;
                  End;
                End;

                strCtaBai := fCfgSis('CTAAVI');
                dtaDtaPag := VS_Date;
                strOpeBai := strLoginUsuarioLogado;
                strPorBai := fCfgSis('PORCTR');
                strEmpBai := VS_strCodEmp;
              End;

              intSeqCon := IfThen(dtaDtaPag = 0, 0, StrToInt(fRetRcxCon(VS_strCodEmp)));

              if fEmptyStr(strHistoricoCred) then
                strHistoricoCred := strHistorico;

              Result := Result And
                        fGravaCadRec('untPcmGer',
                                     'INCLUSÃO',
                                     strNumDoc,
                                     arrDuplicata[intContador].strSequen,
                                     0,               // intSeqBai
                                     strEspDoc,
                                     strCodFor,
                                     VS_strCodEmp,
                                     strCodOpe,
                                     strCodDig,
                                     strCodPor,
                                     dtaDtaEnt,
                                     StrToDate(arrDuplicata[intContador].dtaDtaVen),
                                     IfThen(AblnAcessadoViaRetornoConsignacao, 0, -(arrDuplicata[intContador].curValor - fltValPag)),
                                     -arrDuplicata[intContador].curValor,
                                     0,
                                     'N',
                                     strHistoricoCred, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc,
                                     '',
                                     strPorBai,
                                     strCtaBai,
                                     strOpeBai,
                                     strDocBai,
                                     IfThen(AblnAcessadoViaRetornoConsignacao, -arrDuplicata[intContador].curValor, IfThen(dtaDtaPag = 0, 0, - fltValPag)),
                                     dtaDtaPag,
                                     'N',
                                     strCodEve,
                                     '',
                                     '',
                                     IIF(blnDevolu,strCodCondicaoPagamentoClienteDevolucao,''),
                                     False,
                                     strCodCta,
                                     intSeqCon,
                                     -arrDuplicata[intContador].curValor,
                                     '',
                                     '',
                                     '',
                                     '',
                                     0,
                                     0,
                                     IIF(fIndValido, arrDuplicVend[intContador].curValor, 0), //fltVlrCom,
                                     IIF(fIndValido, (arrDuplicVend[intContador].curValor / fltValAux), 0),
                                     strEmpBai,
                                     '',
                                     '',
                                     '',
                                     '',
                                     '',
                                     IIF(fIndValido, arrDuplicRepr[intContador].curValor, 0), //fltVlrCom,
                                     IIF(fIndValido, (arrDuplicRepr[intContador].curValor / fltValAux), 0),
                                     strCodRep,
                                     0, // fltValIPI: Double = 0;
                                     0, // fltValRet: Double = 0;
                                     'N', // strOriF11: String = 'N';
                                     0, // fltDesSuj: Double = 0;
                                     0, // fltJurSuj: Double = 0;
                                     0, // fltValCqP: Double = 0;
                                     0, // fltValCqV: Double = 0;
                                     IfThen(dtaDtaPag = 0, 0, -arrDuplicata[intContador].curValor));

              {*****************************************}
              {* LIMPA O PORTADOR DA BAIXA, PARA QUE   *}
              {* AS PROXIMAS GRAVAÇÕES DE CTP NÃO O    *}
              {* GRAVEM                                *}
              {**************************************MV*}
              strCodPor := '';

              Inc(intContador);

            End;

          End;

        End;

        If Assigned(pgbDados) Then
        Begin
          pgbDados.StepBy(10);
          Application.ProcessMessages;
        End

        Else If Assigned(objEntAuto) Then
        Begin
          objEntAuto.cxProgressoAuto.Position := objEntAuto.cxProgressoAuto.Position + 10;
          Application.ProcessMessages;
        End;

        {**************************************}
        {* GRAVA DEBITO PARA CLUBE FIDELIDADE *}
        {***********************************AF*}
        If (Result) And
           (blnDevolu) And
           (fCfgSis('VLPCCL', varDouble) > 0) And
           (fCampoTabela('CLI_CLUFID', 'CADCLI', ['CLI_CODCLI'], [strCodFor]) = 'S') Then
        Begin
          objCluFid := TCluFid.Create(Nil);

          Result := Result And
                    objCluFid.fGravaCluFid(strNumDoc,
                                           strEspDoc,
                                           strCodFor,
                                           'D',
                                           'REFERENTE A DEV. ENTRADA DE MERCADORIA',
                                           ((fltTotIte - fltDesEsp)/fCfgSis('VLPCCL', varDouble)));
          FreeAndNil(objCluFid);
        End;

        {***********************************************}
        {* GRAVA DEBITO PARA COMISSAO DE PROFISSIONAIS *}
        {********************************************MM*}
        If (Not blnRetornoSimbolico) Then
          Result := Result And fGComProDev(arrItensDev, strNumDoc, strEspDoc, strCodFor);

        If Not Result Then
          Exit
        Else
        Begin
          If VS_strTCoPro = '2' Then
            If (Not fGComProDevCtr(arrItensDev,
                                   strNumDoc,
                                   strEspDoc,
                                   strCodFor,
                                   strClaFis,
                                   strCodOpe,
                                   strCodDig,
                                   strCodPor)) Then
            Begin
              Result := False;
              Exit;
            End;
        End;

        blnGerouPagAnt := False;

        {*********************************************}
        {* SE NAO FOR DEVOLUCAO GRAVA CONTAS A PAGAR *}
        {******************************************AF*}
        If Result And (blnGraFin or blnGerarContasAPagarx117) And (not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao])) Then
        Begin

          If (Not blnDevolu) And (Not blnConEqu) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao) Then
          Begin
            If strTipFor <> 'M' Then
              pInicializaImpressaoCP;

            If TEntradaAutomatizada.fGravaContasPagar(strClaFis, strCodFor, blnGerarContasAPagarx117, tpFinalidadeXML) Then
            Begin

              intContador := 0;
              {*****************************************}
              {* INICIA A GRAVAÇÃO DO CONTAS A PAGAR   *}
              {**************************************MV*}
              While (ArrDuplicata[intContador].dtaDtaVen <> '') And
                    (intContador < 24)                          And
                    (Result)                                    Do
              Begin

                If Not fEmptyStr(strHisCtp) Then
                  strHistorico := strHisCtp

                Else If (fCfgSis('HISCTP', varBoolean)) Then
                Begin
                  strHistorico := 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc + strSerie + ' EMITIDO EM ' + FormatDateTime('DD/MM/YYYY', dtaDtaDoc);
                  If (fCfgSis('HPDCMP', varBoolean)) And (Not fEmptyStr(FieldByName('ENT_NUMPED').AsString)) Then
                  Begin
                    strCodCmp    := fCampoTabela('PCG_CODCMP', 'PCMGER', ['PCG_NUMPED', 'PCG_CODEMP'], [FieldByName('ENT_NUMPED').AsString, FieldByName('ENT_CODEMP').AsString]);
                    strHistorico := strHistorico + ' ' + #13;
                    strHistorico := strHistorico + 'NUM. PED: ' + FieldByName('ENT_NUMPED').AsString + ' / ' +
                                                   'COMPRADOR: ' + strCodCmp + '-' + fRetNomVendRep(strCodCmp);
                  End;
                End
                Else
                  strHistorico := '';

                strHistoricoRentecao := fRetHistoricoRetencao(dtsCadFis, fltVlrCon);

                strHisBai := '';
                strCtaBai := '';
                strDocBai := '';
                strOpeBai := '';
                dtaDtaPag := 0;
                fltValPag := 0;
                strSeqLan := '';

                If (blnBaixaCTPAVista) And
                   (StrToDate(ArrDuplicata[intContador].dtaDtaVen) = VS_Date) Then
                Begin
                  lstBanCtp := TBanCtpRepository.Create;
                  lstBanCtp.fAdd(strNumDoc,
                                 'A',
                                 strSerie,
                                 VS_strCodEmp,
                                 strCodFor,
                                 strHistorico,
                                 '',
                                 strCodCta,
                                 VS_strCodEmp,
                                 0,
                                 ArrDuplicata[intContador].curValor,
                                 0,
                                 0,
                                 0,
                                 0);

                  strSeqLan := fGravaMovBan(strCodCta,                                                     // Centro de Custo
                                            strPorBai,                                                     // Portador da Baixa
                                            strCodOpe,                                                     // Operador da Baixa
                                            dtaDtaEnt,                                                       // Data do Lançamento
                                            fTime(),                                                       // Hora do Lançamento
                                            fStrZero(strNumDoc, 12),                                       // Numero do Documento
                                            'D',                                                           // Credito / Debito
                                            VS_strCodEmp,                                                  // Empresa da Baixa
                                            ArrDuplicata[intContador].curValor,                            // Valor Do Lançamento
                                            strHistorico, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                                            '',                                                            // Histórico 2
                                            '',                                                            // Cliente da Duplicata
                                            strCodFor,                                                     // Fornecedor da Duplicata
                                            fStrZero(strNumDoc, 12),                                       // Número da Duplicata
                                            0,                                                             // Sequencial de Baixa
                                            'A',                                                           // Parcela da Duplicata
                                            VS_strCodEmp,                                                  // Empresa da Duplicata
                                            strSerie,                                                      // Série
                                            //'',                                                          // Sequencial de Lançamento
                                            '',                                                            // Código do Evento
                                            '',                                                            // Documento da Baixa
                                            lstBanCtp.fGetList,                                            // Log Bancário
                                            0,
                                            intCtpCon);

                  Result := Not fEmptyStr(strSeqLan);

                  FreeAndNil(lstBanCtp);

                  If (fCfgSis('HISCTP', varBoolean)) Then
                    strHisBai := 'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc
                  Else
                    strHisBai := '';

                  strCtaBai := strCodCta;
                  strDocBai := strSeqLan;
                  strOpeBai := strLoginUsuarioLogado;
                  dtaDtaPag := VS_Date;
                  fltValPag := ArrDuplicata[intContador].curValor;

                End;

                If strVeiBol = '' Then
                  strVeiBol:= 'N';

                If strDeposi = '' Then
                  strDeposi:= 'N';

                If ArrDuplicata[intContador].strUsaChq = '' Then
                  ArrDuplicata[intContador].strUsaChq := 'N';


                If blnPrevis Then
                  blnPrevis := fGravarContasPagarPrevisao(dtsCadFis);

                If Assigned(objEntAuto) Then
                  LCodEveCTP := objEntAuto.FCodEveCTP
                Else
                  LCodEveCTP := strCodEve;

                If Not blnPrevis Then
                  Result := Result And
                          fGravaCadPag(strNomeForm,
                                       'CONFIRMACAO DE ENTRADA DE MERCADORIA',
                                       strCodFor,                                                     // Fornecedor
                                       fStrZero(strNumDoc, 12),                                       // Numero da Duplicata
                                       ArrDuplicata[intContador].strSequen,                           // Parcela
                                       VS_strCodEmp,                                                  // Empresa
                                       strCodCta,                                                     // Centro de Custo
                                       strSerie,                                                      // Serie do Documento
                                       0,                                                             // Sequencial de Baixa
                                       IIF(fZeraDataEntrada(ValidacaoZeraData), 0, dtaDtaEnt),        // Data do lançamento
                                       StrToDate(ArrDuplicata[intContador].dtaDtaVen),                // Data de Vencimento
                                       (ArrDuplicata[intContador].curValor - fltValPag) * IIf((tpFinalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor), -1, 1),                // Valor da Duplicata
                                       ArrDuplicata[intContador].curValor* IIf((tpFinalidadeXML = xmlDevolucaoEntradaEmitidaFornecedor), -1, 1) ,                            // Valor Original
        //                               ArrDuplicata[intContador].curValor - fltValPag,                // Valor Original
                                       'N',                                                           // Previsão?
                                       strVeiBol,                                                     // Veio Boleto
                                       strDeposi,                                                     // Deposito
                                       strHistorico + #$A#$D + strHistoricoRentecao, //'REF. AO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                                       '',                                                            // Histórico 2
                                       strHisBai,                                                     // Histórico da Baixa
                                       IIF(fEmptyStr(strDocBai), '', strPorBai),                       // Portador da Baixa
                                       strCtaBai,                                                     // Centro de Custo da Baixa
                                       strDocBai,                                                     // Documento da Baixa
                                       strOpeBai,                                                     // Operador da Baixa
                                       dtaDtaPag,                                                     // Data do Pagamento
                                       fltValPag,                                                     // Valor Pago
                                       0,                                                             // Valor de Juros
                                       0,                                                             // Valor Desconto
                                       VS_strCodEmp,                                                  // Empresa
                                       LCodEveCTP,                                                     // Código do Evento
                                       ArrDuplicata[intContador].strUsaChq,                           // Usa Cheque
                                       strPorBai,                                                     // Codigo do Portador
                                       fStrZero(strNumDoc, 12),                                       // Nro do Documento da Baixa
                                       0.0,                                                           // fltJurSuj,
                                       0.0,                                                           // fltDesSuj: Double;
                                       intCtpCon,                                                     // intSeqCon: Integer;
                                       False,                                                         // blnResCai: Boolean = False;
                                       0,                                                             // intRcxCon: Integer = 0;
                                       IIF(strTipFor='M','1',''),                                     // strTipDoc: String = '';
                                       0,                                                             // fltVendor: Double  = 0;
                                       IIF(SameText(strEspDoc, 'NF'), 'S', 'N'),                      // strVeioNF: String = '';
                                       '',                                                            // strNotEnt: String = '';
                                       '',                                                            // strNotTip: String = '';
                                       '',                                                            // strCTPCom: String = '';
                                       '',                                                            // strAutInc: String = '';
                                       '',                                                            // strDocTer: String = '';
                                       '',                                                            // strEspTer: String = '';
                                       '',                                                            // strEmpTer: String = '';
                                       '',                                                            // strCliTer: String = '';
                                       IIF(strTipFor='M','S','N'),                                    // strUsoCon: String = '';
                                       strCompet,                                                     // strCompet: String = '';
                                       '',                                                            // strCodCliUC: String = '';
                                       '',                                                            // strNumDocUC: String = '';
                                       '',                                                            // strEspDocUC: String = '';
                                       '',                                                            // strCodEmpUC: String = '';
                                       fltValPag,                                                     // fltDinhei: Double = 0;
                                       0,                                                             // fltChqAvi: Double = 0;
                                       0,                                                             // fltOrdPag: Double = 0;
                                       0,                                                             // fltRepChq: Double = 0;
                                       '',                                                            // strCodVen: String = '';
                                       0,                                                             // fltJurAnt: Double = 0;
                                       0,                                                             // fltDesAnt: Double = 0;
                                       IIF((strVeiBol = 'S') And (blnCtpBol),arrLinDigCodbar[intContador].strLinDig,''),// strLinDig: String = '';
                                       IIF((strVeiBol = 'S') And (blnCtpBol),arrLinDigCodbar[intContador].strCodBar,''),// strCodBar: String = '';
                                       '',                                                            // strAutCtp: String = '';
                                       ArrDuplicata[intContador].strNFNumDup,                         // strNFNumDup: String = ''): Boolean;
                                       '',
                                       '0',
                                       '',
                                       strBcoFor,
                                       '',
                                       '',
                                       'N',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       0,
                                       '',
                                       0,
                                       0,
                                       0,
                                       '',
                                       '',
                                       strAutIncCadFis,                                                      // AIncCadFis: string = '';
                                       '',                                                            // strQrCode: string = '';
                                       'N');                                                          // AUsaMca: String = '' -- Req. 462891


                If (Not blnGerouPagAnt) Then
                Begin

                  // CONTAS A PAGAR DO ICMS ANTECIPADO
                  If ( (fltValAnt) > 0) Then
                    Result := Result And
                            fGravaCadPag(strNomeForm,                                                   // Nome Form LOGCTP
                                         'INCLUSÃO ICMS ANTECIPADO CONTAS A PAGAR',                     // Descrição LOGCTP
                                         fCfgSis('ANTFOR'),                                             // Fornecedor
                                         fRetSequencialCadPag,                                          // Numero da Duplicata
                                         'A',                                                           // Parcela
                                         VS_strCodEmp,                                                  // Empresa
                                         fCfgSis('ANTCTA'),                                             // Centro de Custo
                                         '',                                                      // Serie do Documento
                                         0,                                                             // Sequencial de Baixa
                                         IIF(fZeraDataEntrada(ValidacaoZeraData), 0, dtaDtaEnt), // Data do lançamento
                                         dtaIcmAnt,                                                     // Data de Vencimento
                                         (fltValAnt),                                                   // Valor da Duplicata
                                         (fltValAnt),                                                   // Valor Original
                                         'N',                                                           // Previsão?
                                         'N',                                                           // Veio Boleto
                                         'N',                                                            // Deposito
                                         'REF. AO ICMS ANTECIPADO DO DOCUMENTO No ' + fStrZero(strNumDoc, 12) + strEspDoc, // Histórico 1
                                         '',                                                            // Histórico 2
                                         '',                                                            // Histórico da Baixa
                                         '',                                                            // Portador da Baixa
                                         '',                                                            // Centro de Custo da Baixa
                                         '',                                                            // Documento da Baixa
                                         '',                                                            // Operador da Baixa
                                         0,                                                             // Data do Pagamento
                                         0,                                                             // Valor Pago
                                         0,                                                             // Valor de Juros
                                         0,                                                             // Valor Desconto
                                         VS_strCodEmp,                                                  // Empresa
                                         LCodEveCTP,                                                     // Código do Evento
                                         'N',                                                           // Usa Cheque
                                         '',                                                            // Codigo do Portador
                                         '',                                                            // Nro do Documento da Baixa
                                         0.0,
                                         0.0,
                                         intCtpCon,
                                         False, //blnResCai
                                         0,     //intRcxCon
                                         '1',   //strTipDoc
                                         0,     //fltVendor
                                         IIF(SameText(strEspDoc, 'NF'), 'S', 'N'),    //strVeioNF
                                         strNumDoc + strEspDoc + strCodEmp +
                                         fstrEspaco(strSerie, 3) + strCodFor, // Nota de Entrada
                                         CTP_ICMS_ANTECIPADO,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         'N',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '0',
                                         '',
                                         '',
                                         '',
                                         '',
                                         'N',                                                           // strPagAntecipado: String = 'N';
                                         '',                                                            // strAutIncFunrural: String = '';
                                         '',                                                            // strGnreNumeroDocumento: String = '';
                                         '',                                                            // strGnreChaveDeAcesso: String = '';
                                         '',                                                            // strGnreNumeroDeControle: String = '';
                                         0,                                                             // dtaGnreDataPrevisaoPagamento: TDateTime = 0;
                                         '',                                                            // strGnreConvenio: String = '';
                                         0,                                                             // fltMulSuj: Double = 0;
                                         '',                                                            // strAutIncPix: String = '';
                                         0,                                                             // fltGrvOri: Double = 0;
                                         0,                                                             // ADtaLiberacao: TDateTime = 0;
                                         0,                                                             // AHorLiberacao: TDateTime = 0;
                                         '',                                                            // AOpeLiberacao: String = '';
                                         '',                                                            // strGnreChaveDeApuracao: String = '';
                                         '',                                                            // AIncCadFis: string = '';
                                         '',                                                            // strQrCode: string = '';
                                         'N');                                                          // AUsaMca: String = '' -- Req. 462891

                  If Assigned(objVendor) Then
                    Result := Result And objVendor.fGravaContasAPagar(strCodFor, strNumDoc,
                                 strEspDoc, strCodEmp, strSerie, strCodEve, intCtpCon, dtaDtaEnt);

                  If Assigned(objOutDes) Then
                    Result := Result And objOutDes
                      .fAutoIncrem(strSeqGer)
                      .fGravaContasAPagar(strCodFor, strNumDoc,
                                 strEspDoc, strCodEmp, strSerie, {strCodEve,} strTipFor, strCompet, intCtpCon, dtaDtaEnt, False,
                                 blnConferenciaDepoisDaEntrada, blnDevolu, blnRecCliGarantia,
                                 blnConEqu, blnGarantia, blnUtilizarCFG_CLARET
                                 );

                  blnGerouPagAnt := True;
                End; {If (Not blnGerouPagAnt) Then}

                If (Result) Then
                Begin
                  If (fGravarCtpDet) Then
                  Begin
                    pGravarCtpDet(ArrDuplicata[intContador].strSequen);
                  End;

                  If ( blnImprCP ) Then
                  Begin
                    pAdicionaImpressaoCP(fStrZero(strNumDoc, 12),
                                         ArrDuplicata[intContador].strSequen,
                                         strCodFor,
                                         strSerie,
                                         strNomeForm);
                  End;


                End;

                {*****************************************}
                {* LIMPA O PORTADOR DA BAIXA, PARA QUE   *}
                {* AS PROXIMAS GRAVAÇÕES DE CTP NÃO O    *}
                {* GRAVEM                                *}
                {**************************************MV*}
                strCodPor := '';

                Inc(intContador);

              End;

            End;
          End;

        End
        Else
        Begin
          If Assigned(objVendor) Then
            Result := Result And objVendor.fGravaContasAPagar(strCodFor, strNumDoc,
                         strEspDoc, strCodEmp, strSerie, strCodEve, intCtpCon, dtaDtaEnt);

          If Assigned(objOutDes) Then
            Result := Result And objOutDes.fGravaContasAPagar(strCodFor, strNumDoc,
                         strEspDoc, strCodEmp, strSerie, {strCodEve,} strTipFor,strCompet, intCtpCon, dtaDtaEnt, False,
                         blnConferenciaDepoisDaEntrada, blnDevolu, blnRecCliGarantia,
                         blnConEqu, blnGarantia, blnUtilizarCFG_CLARET
                         );
        End;



        If Assigned(frmEntRetencaoNotaServico) Then
        Begin
          frmEntRetencaoNotaServico.fraCadImpostosNFS.CtaDet(cdsCtpDet);
          frmEntRetencaoNotaServico.fraCadImpostosNFS.strForCli := strCodFor;
          With frmEntRetencaoNotaServico.fraCadImpostosNFS Do
           If (Not cdsForRet.IsEmpty) Then
              fCriarParcelasRetencoesFornecedor(strAutIncCadFis, strNomeForm);
        End;

        FreeAndNil(qryGen);
        If (Not blnRetornoSimbolico) Then
          If Assigned(objLotePrecos) Then
            objLotePrecos.pEnviaMensagemResponsavel;

      End;

      if (AblnAcessadoViaRetornoConsignacao) And (Result) then
      Begin
        LObjRetornoConsignacaoBuilder                                 := TRetornoConsignacaoBuilder.Create;
        LObjRetornoConsignacaoBuilder.TipoRetornoConsignacao          := ATipoRetornoConsignacao;
        LObjRetornoConsignacaoBuilder.NumeroDoDocumentoDoRetorno      := strNumDoc;
        LObjRetornoConsignacaoBuilder.EspecieDoDocumentoDoRetorno     := strEspDoc;
        LObjRetornoConsignacaoBuilder.EmpresaDoDocumentoDoRetorno     := strCodEmp;
        LObjRetornoConsignacaoBuilder.CodigoCliente                   := strCodFor;
        LObjRetornoConsignacaoBuilder.SequenciaConciliacaoFinanceiro  := intSeqCon;

        Result := LObjRetornoConsignacaoBuilder.fGerarRetornoConsignacao(LstrMensagem);

        FreeAndNil(LObjRetornoConsignacaoBuilder);

        if not Result then
        Begin
          pMensagemOk(LstrMensagem);
          Exit(False);
        End
        Else
          strListIdGerEle.Clear;
      End;

      If Result And Assigned(objEmissaoNotaEspecial) Then
      Begin
        objEmissaoNotaEspecial.pSetaTransferenciaDepositoFechado(strCodFor, strEmpresaDeposito);
        Result := objEmissaoNotaEspecial.fEmitirNotaEspecial(strNumDoc, strEspDoc, VS_strCodEmp, '', 1, 0, 0, False, strAutInc);
      End;

      If Result And (Not blnConferenciaDepoisDaEntrada) And fTemPedido Then
      begin
        pEnviaMsgRequisicaoConcluida(strSeqGer);
      End;
      TDefineBaixaPedido.ProcessaStatusPedidoRequisicao(strSeqGer);


      {Requisito 20339}

      If Result Then
        pAtualizasaldoSaldoDosPedidosQueDevemPassarAReservarEstoque(strSeqGer, (blnVaiGerarEnderecamentoDepois or blnDocumentoGeraEnderecamento));


      If Assigned(pgbDados) Then
        pgbDados.Visible := False;

      If (blnDevolu) And (fCfgSis('TCKNFD', varBoolean)) And (strEspDoc = 'NF') Then
       pImprimeFatImp('MOVDET',
                       strNumDoc,
                       strEspDoc,
                       VS_strCodEmp,
                       strCodFor,
                       'C',
                       'D',
                       False,
                       strNomeArquivo,
                       False,
                       'I',
                       1,
                       impComPrecoGeral,
                       0,
                       False,
                       False,
                       True,
                       True,
                       '',
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       opcTodos,
                       False,
                       False,
                       False,
                       False,
                       False,
                       '',
                       ' ',
                       Nil,
                       False,
                       '',
                       '', // Razao Social ou Fantasia
                       '',  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                       False,
                       opcNaoAgrupa,
                       False,
                       '',
                       '',
                       False,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       True); //Ticket NF

      If (blnDevolu) And (fCfgSis('TCKDVD', varBoolean)) And (strEspDoc = 'DV') Then
       pImprimeFatImp('MOVDET',
                       strNumDoc,
                       strEspDoc,
                       VS_strCodEmp,
                       strCodFor,
                       'C',
                       'D',
                       False,
                       strNomeArquivo,
                       False,
                       'I',
                       1,
                       impComPrecoGeral,
                       0,
                       False,
                       False,
                       True,
                       True,
                       '',
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       opcTodos,
                       False,
                       False,
                       False,
                       False,
                       False,
                       '',
                       ' ',
                       Nil,
                       False,
                       '',
                       '', // Razao Social ou Fantasia
                       '',  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                       False,
                       opcNaoAgrupa,
                       False,
                       '',
                       '',
                       False,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       '',
                       '',
                       '',
                       False,
                       '',
                       0,
                       0,
                       True); //Ticket DV

      If Result Then
        pDeletaDocumento_TabelaDEL;

      IF (Not blnEntEnd) And (blnNumSer) And (Not Assigned(objEntAuto)) And (strSONCEE = '2') Then
        Result := fGravarNumeroSerie(oleItensPedidos, strNumDoc, strEspDoc,
          strSerie, strCodEmp);
    Except
      On E: Exception Do
      Begin
        FreeAndNil(objCluFid);
        Result := False;
        pMensagensErro('Erro: ' + E.Message, '[fConfirmaEntradaMercadorias]');
      End;
    End;
  Finally
    FreeAndNil(CalculoPrecoMediAgrup);
    strAgrupadorPreAlt := '';
    If Not blnGravouMovDet Then
      Result := False;

    if Result then
      if Assigned(onAfterConfirma) then
        onAfterConfirma();

    If blnDevolu Then
      FreeAndNil(objComPro);
    FreeAndNil(cpcParams);
    FreeAndNil(qryGenMer);
    FreeAndNil(qryConIte);
    FreeAndNil(stlPedidosGarantia);

    if ( objLote <> nil ) then
      FreeAndNil(objLote);

    If Assigned(cdsPedidos) Then
      FreeAndNil(cdsPedidos);

    If Assigned(objCadLot) Then
      FreeAndNil(objCadLot);

    If Assigned(objLotePrecos) Then
      FreeAndNil(objLotePrecos);

    FreeAndNil(stlPedidosCompra);
    FreeAndNil(LstlCesBas);
  End;

end;


procedure pMarcaMovTriComAtualizacaoDePrecos(strSeqDet: String);
var qryUpdate: TUniQuery;
Begin
  qryUpdate:= fCriaQuery;
  Try
    qryUpdate.SQL.Add('UPDATE MOVTRI SET DET_ATUPRE = "S"');
    qryUpdate.SQL.Add(' WHERE DET_SEQGER = "' + strSeqDet + '"');

    qryUpdate.ExecSQL;

  Finally
    FreeAndNil(qryUpdate);
  End;


End;


function fGeraHtml(strNumPed, strEspDoc: String): String;
  Var
    strSQL: String;
    qryTblPcmGer: TUniQuery;
    qryTblPcmDet: TUniQuery;
    qryTblCadEmp: TUniQuery;
    qryTblCadTra: TUniQuery;

    strHtmlCabItens: String;
    strHtmlItens: String;
    strHtmlObsRodape: String;
    strHtmlTmp: String;

    strLinha: String;
    strDiaEntrega: String;
    strMesEntrega: String;
    strAnoEntrega: String;
    strPedidoOrcamento: String;
    strMensagemRodape: String;
    strHtmlRodapeTotais: String;

    arrCorItem: Array Of String;
    intContador: Integer;
    intCorItem: Integer;

    arqHtmlModelo: TextFile;
    arqHtmlSaida: TextFile;

begin
  qryTblPcmGer := fCriaQuery;
  qryTblPcmDet := fCriaQuery;
  qryTblCadEmp := fCriaQuery;
  qryTblCadTra := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCMGER.*, ';
  strSQL := strSQL + '  CADFOR.*, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID AS FOR_NOMCID, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO AS FOR_ESTGADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMGER, ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCMGER.PCG_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCMGER.PCG_CODFOR = CADFOR.FOR_CODFOR AND ';
  strSQL := strSQL + '  CADFOR.FOR_CODCID = CADCID.CID_CODCID AND ';
  strSQL := strSQL + '  PCMGER.PCG_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '  PCMGER.PCG_ESPDOC = :ESPDOC ';

  With qryTblPcmGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    Open;

    TFloatField(FieldByName('PCG_TOTITE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCG_TOTGER')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCG_TOTIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCG_TOTSUB')).DisplayFormat := '#,##0.00';
  End;

  SetLength(arrCorItem, 2);
  arrCorItem[0] := '#CCCCCC';
  arrCorItem[1] := '#E6E6E6';

  If (strEspDoc = 'PD') Then
  Begin
    strPedidoOrcamento := 'Pedido de Compra';
    strMensagemRodape  := 'CONFIRMAR O RECEBIMENTO NO PEDIDO - MENCIONAR O NUMERO DO PEDIDO';
  End
  Else
  Begin
    strPedidoOrcamento := 'Or&ccedil;amento';
    strMensagemRodape  := 'CONFIRMAR O RECEBIMENTO NO OR&Ccedil;AMENTO - MENCIONAR O NUMERO DO OR&Ccedil;AMENTO';
  End;

  {**********************************************}
  {* HTML CORRESPONDENTE AO CABEÇALHO DA TABELA *}
  {* DOS ITENS DO PEDIDO                        *}
  {*******************************************MV*}
  strHtmlCabItens := '';
  strHtmlCabItens := strHtmlCabItens + '  <tr bgcolor='#330099'> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="7%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Codigo</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="36%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Descri&ccedil;&atilde;o</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="3%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Un.</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="9%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Marca</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Cod.Fab.</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Quant.</font></strong></font></div> ' + #13#10;
  strHtmlCabItens := strHtmlCabItens + '    </td> ' + #13#10;

  If (strEspDoc = 'PD') Then
  Begin
    strHtmlCabItens := strHtmlCabItens + '  <td width="7%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Pre&ccedil;o<br> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '    Unit. </font></strong></font></div> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '  </td> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '  <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Pre&ccedil;o<br> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '    Total </font></strong></font></div> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '  </td> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '  <td width="6%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">% ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '    IPI</font></strong></font></div></td> ' + #13#10;
    strHtmlCabItens := strHtmlCabItens + '  <td width="8%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Vr.IPI</font></strong></font></div></td> ' + #13#10;
  End;
  strHtmlCabItens := strHtmlCabItens + '  </tr> ' + #13#10;

  {*******************************************}
  {* HTML DAS OBSERVAÇÕES DO RODAPÉ          *}
  {****************************************MV*}
  strHtmlObsRodape := '';
  If (strEspDoc = 'OR') Then
  Begin

    strHtmlObsRodape := strHtmlObsRodape + '<tr> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '  <td height="31" bgcolor="#CCCCCC"> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + ' ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '    <div align="left"> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '      <em> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + ' ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '        <strong> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '          <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> ' + #13#10;

    If (Not fEmptyStr(qryTblPcmGer.FieldByName('PCG_OBS001').AsString)) Then
      strHtmlObsRodape := strHtmlObsRodape + '             {{PCMGER->PCG_OBS001}}<br> ' + #13#10;

    If (Not fEmptyStr(qryTblPcmGer.FieldByName('PCG_OBS002').AsString)) Then
      strHtmlObsRodape := strHtmlObsRodape + '             {{PCMGER->PCG_OBS002}}<br> ' + #13#10;

    If (Not fEmptyStr(qryTblPcmGer.FieldByName('PCG_OBS003').AsString)) Then
      strHtmlObsRodape := strHtmlObsRodape + '             {{PCMGER->PCG_OBS003}}<br> ' + #13#10;

    If (Not fEmptyStr(qryTblPcmGer.FieldByName('PCG_OBS004').AsString)) Then
      strHtmlObsRodape := strHtmlObsRodape + '             {{PCMGER->PCG_OBS004}}<br> ' + #13#10;

    If (Not fEmptyStr(qryTblPcmGer.FieldByName('PCG_OBS005').AsString)) Then
      strHtmlObsRodape := strHtmlObsRodape + '             {{PCMGER->PCG_OBS005}} ' + #13#10;

    strHtmlObsRodape := strHtmlObsRodape + '          </font> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '        </strong> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + ' ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '      </em> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '    </div> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + ' ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '  </td> ' + #13#10;
    strHtmlObsRodape := strHtmlObsRodape + '</tr> ' + #13#10;

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  PCMDET.*, ';
  strSQL := strSQL + '  CADITE.*, ';
  strSQL := strSQL + '  CADMAR.MAR_DESMAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET, ';
  strSQL := strSQL + '  CADITE, ';
  strSQL := strSQL + '  CADMAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PCMDET.PCD_NUMCTN = 0 AND ';
  strSQL := strSQL + '  PCMDET.PCD_CODITE = CADITE.ITE_CODITE AND ';
  strSQL := strSQL + '  CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR AND ';
  strSQL := strSQL + '  PCMDET.PCD_NUMPED = :NUMPED AND ';
  strSQL := strSQL + '  PCMDET.PCD_ESPDOC = :ESPDOC ';

  With qryTblPcmDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    Open;

    TFloatField(FieldByName('PCD_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DEQTPC', varInteger));
    TFloatField(FieldByName('PCD_UNITAR')).DisplayFormat := '#,###0.000';
    TFloatField(FieldByName('PCD_TOTITE')).DisplayFormat := '#,###0.000';
    TFloatField(FieldByName('PCD_PERIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_TOTIPI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_PERSUB')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('PCD_TOTSUB')).DisplayFormat := '#,##0.00';
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADEMP.*, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID AS EMP_NOMCID, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO AS EMP_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADEMP.EMP_CODCID = CADCID.CID_CODCID AND ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

  With qryTblCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADTRA.*, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID AS TRA_NOMCID, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO AS TRA_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADTRA, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADTRA.TRA_CODCID = CADCID.CID_CODCID AND ';
  strSQL := strSQL + '  CADTRA.TRA_CODTRA = :CODTRA ';

  With qryTblCadTra Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODTRA').AsString := qryTblPcmGer.FieldByName('PCG_CODTRA').AsString;
    Open;
  End;

  strHtmlItens := '';
  intCorItem   := 0;

  {**********************************************}
  {* HTML CORRESPONDENTE AOS ITENS DO PEDIDO    *}
  {*******************************************MV*}
  While (Not qryTblPcmDet.Eof) Do
  Begin

    strHtmlTmp := '';

    strHtmlTmp := strHtmlTmp + '  <tr bgcolor="' + arrCorItem[intCorItem] +  '"> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->ITE_CODITE}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><font size="1" face="Verdana, Arial, Helvetica, sans-serif">                    {{PCMDET->PCD_DESITE}}</font></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->ITE_CODUNI}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="Left"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->MAR_DESMAR}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="Left"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->ITE_CODFAB}}</font></div></td> ' + #13#10;
    strHtmlTmp := strHtmlTmp + '    <td><div align="right" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->PCD_QTDITE}}</font></div></td> ' + #13#10;

    If (strEspDoc = 'PD') Then
    Begin
      strHtmlTmp := strHtmlTmp + '     <td><div align="right" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->PCD_UNITAR}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '     <td><div align="right" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->PCD_TOTITE}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '     <td><div align="right" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->PCD_PERIPI}}</font></div></td> ' + #13#10;
      strHtmlTmp := strHtmlTmp + '     <td><div align="right" ><font size="1" face="Verdana, Arial, Helvetica, sans-serif">{{PCMDET->PCD_TOTIPI}}</font></div></td> ' + #13#10;
    End;
    strHtmlTmp := strHtmlTmp + ' </tr> ' + #13#10;

    For intContador := 0 To qryTblPcmDet.FieldCount -1 Do
    Begin
      If (qryTblPcmDet.Fields[intContador].DataType = ftFloat)                        And
         (Not fEmptyStr(TFloatField(qryTblPcmDet.Fields[intContador]).DisplayFormat)) Then
      Begin
        strHtmlTmp := AnsiReplaceStr(strHtmlTmp,
                                     '{{' + 'PCMDET->' + qryTblPcmDet.Fields[intContador].FieldName + '}}',
                                     FormatFloat(TFloatField(qryTblPcmDet.Fields[intContador]).DisplayFormat, qryTblPcmDet.Fields[intContador].AsFloat));
      End
      Else
      Begin
        strHtmlTmp := AnsiReplaceStr(strHtmlTmp,
                                     '{{' + 'PCMDET->' + qryTblPcmDet.Fields[intContador].FieldName + '}}',
                                     qryTblPcmDet.Fields[intContador].AsString);
      End;
    End;

    intCorItem := IIF(intCorItem = 0, 1, 0);
    strHtmlItens := strHtmlItens + strHtmlTmp;
    qryTblPcmDet.Next;
  End;

  strHtmlRodapeTotais := '';
  strHtmlRodapeTotais := strHtmlRodapeTotais + '<hr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '<div align="right"></div> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '<table width="100%" border="0" cellspacing="0" cellpadding="0"> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + ' <tr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '    <td width="65%">&nbsp;</td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '    <td width="35%"><table width="100%" border="0" cellspacing="0"> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      <tr bgcolor="#0066CC"> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td width="55%"><div align="right"><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Soma ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '                  dos Itens</strong></font></div></td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td width="45%"><div align="right"><font size="2"><b><font color="yellow">{{PCMGER->PCG_TOTITE}}</font></b></font></div> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        </td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      </tr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      <tr bgcolor="#0066CC"> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td><div align="right"><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Soma ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '                  do I.P.I.</strong></font></div></td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td><div align="right"><font size="2"><b><font color="yellow"> </font><font size="2"><b><font color="yellow">{{PCMGER->PCG_TOTIPI}}</font></b></font></b></font></div> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        </td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      </tr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      <tr bgcolor="#330099"> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td><div align="right"><font color="#FFFFFF" size="2" face="Verdana, Arial, Helvetica, sans-serif"><strong>Total ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '                  do Pedido</strong></font></div></td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        <td><div align="right"><font size="2"><b><font color="yellow"> </font><font size="2"><b><font color="yellow">{{PCMGER->PCG_TOTGER}}</font></b></font></b></font></div> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '        </td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '      </tr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '    </table></td> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '  </tr> ' + #13#10;
  strHtmlRodapeTotais := strHtmlRodapeTotais + '</table> ' + #13#10;


  strDiaEntrega := FormatDateTime('dd', qryTblPcmGer.FieldByName('PCG_DTAENT').AsDateTime);
  strMesEntrega := FormatDateTime('mmmm', qryTblPcmGer.FieldByName('PCG_DTAENT').AsDateTime);
  strAnoEntrega := FormatDateTime('yyyy', qryTblPcmGer.FieldByName('PCG_DTAENT').AsDateTime);

  Result := strEspDoc + '_' + strNumPed + '.html';

  {*******************************************}
  {* ABRE ARQUIVO MODELO E DE SAIDA          *}
  {****************************************MV*}
  AssignFile(arqHtmlModelo, ExtractFilePath(Application.ExeName) + '\modelo_pedorc.html');
  AssignFile(arqHtmlSaida, Result);

  Reset(arqHtmlModelo);
  Rewrite(arqHtmlSaida);

  While (Not Eof(arqHtmlModelo)) Do
  Begin

    ReadLn(arqHtmlModelo, strLinha);

    {*******************************************}
    {* IMPRIME LOGOTIPO DO CLIENTE SE EXISTIR  *}
    {****************************************AC*}
    If FileExists(fCfgSis('PATLOG')) Then
      strLinha := AnsiReplaceStr(strLinha, '{{PATH_LOGOTIPO}}', '<p align=center> <img src= ' + QuotedStr(fCfgSis('PATLOG')) + ' width="350" height="140"> </p>')
    Else
      strLinha := AnsiReplaceStr(strLinha, '{{PATH_LOGOTIPO}}', '');

    strLinha := AnsiReplaceStr(strLinha, '{{ITENS_PEDIDO}}', strHtmlCabItens + strHtmlItens);
    strLinha := AnsiReplaceStr(strLinha, '{{OBSERVACOES_RODAPE}}',  strHtmlObsRodape);
    strLinha := AnsiReplaceStr(strLinha, '{{PEDIDO_ORCAMENTO}}',  strPedidoOrcamento);

    strLinha := AnsiReplaceStr(strLinha, '{{DIA_ENTREGA}}',  strDiaEntrega);
    strLinha := AnsiReplaceStr(strLinha, '{{MES_ENTREGA}}',  strMesEntrega);
    strLinha := AnsiReplaceStr(strLinha, '{{ANO_ENTREGA}}',  strAnoEntrega);
    strLinha := AnsiReplaceStr(strLinha, '{{MENSAGEM_RODAPE}}', strMensagemRodape);

    If (strEspDoc = 'PD') Then
      strLinha := AnsiReplaceStr(strLinha, '{{RODAPE_TOTAIS}}', strHtmlRodapeTotais)
    Else
      strLinha := AnsiReplaceStr(strLinha, '{{RODAPE_TOTAIS}}', '');

    For intContador := 0 To qryTblPcmGer.FieldCount -1 Do
    Begin

      If (qryTblPcmGer.Fields[intContador].DataType = ftFloat)                        And
         (Not fEmptyStr(TFloatField(qryTblPcmGer.Fields[intContador]).DisplayFormat)) Then
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                     '{{' + 'PCMGER->' + qryTblPcmGer.Fields[intContador].FieldName + '}}',
                                     FormatFloat(TFloatField(qryTblPcmGer.Fields[intContador]).DisplayFormat, qryTblPcmGer.Fields[intContador].AsFloat));
      End
      Else
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                     '{{' + 'PCMGER->' + qryTblPcmGer.Fields[intContador].FieldName + '}}',
                                     qryTblPcmGer.Fields[intContador].AsString);
      End;
    End;

    For intContador := 0 To qryTblCadEmp.FieldCount -1 Do
    Begin
      strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + 'CADEMP->' + qryTblCadEmp.Fields[intContador].FieldName + '}}',
                                   qryTblCadEmp.Fields[intContador].AsString);
    End;


    strLinha := AnsiReplaceStr(strLinha,'{{CADTRA->TRA_NOMCID}}',
                               qryTblCadTra.FieldByName('TRA_NOMCID').AsString + ' - ' +
                               qryTblCadTra.FieldByName('TRA_ESTADO').AsString + ' - Fone: ' +
                               fFormataFone(qryTblCadTra.FieldByName('TRA_FONE01').AsString));

    For intContador := 0 To qryTblCadTra.FieldCount -1 Do
    Begin
      strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + 'CADTRA->' + qryTblCadTra.Fields[intContador].FieldName + '}}',
                                   qryTblCadTra.Fields[intContador].AsString);
    End;

    WriteLn(arqHtmlSaida, strLinha);

  End;

  CloseFile(arqHtmlModelo);
  CloseFile(arqHtmlSaida);

  FreeAndNil(qryTblPcmGer);
  FreeAndNil(qryTblPcmDet);
  FreeAndNil(qryTblCadEmp);
  FreeAndNil(qryTblCadTra);

end;

function fFornecedorGravaCtp(strCodFor: String): Boolean;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    Result := True;
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                                           ';
    strSQL := strSQL + '  FIN_GRVCTP                                     ';
    strSQL := strSQL + 'FROM                                             ';
    strSQL := strSQL + '  CADEMP                                         ';
    strSQL := strSQL + 'INNER JOIN FINEMP ON FIN_EMPORI = EMP_CODEMP AND ';
    strSQL := strSQL + '                     FIN_EMPDES = :EMPDES        ';
    strSQL := strSQL + 'WHERE                                            ';
    strSQL := strSQL + '  EMP_FORFIL = :CODFOR                           ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('EMPDES').AsString := VS_strCodEmp;

      Open;

      If (Not IsEmpty) Then
      Begin
        Result := (FieldByName('FIN_GRVCTP').AsString = 'S');
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

{*****************************************************************}
{* ESSA FUNCAO RETORNA TRUE SE HOUVER ALGUM ITEM NO PEDIDO COM   *}
{* DATA MAIOR OU IGUAL A DATA CORRENTE; FALSE CASO CONTRARIO     *)
***************************************************************LA*}
function fTestaDataBalanco(strNumPed, strNumEmp: String; Var qryGenIte : TUniQuery): Boolean;
 Var
   strSQL   : String;
Begin
  Result := False;

  //************************************************************//
  // ALTERADO A VERIFICAÇÃO DOS PRODUTOS, POIS FOI INCLEMENTADO //
  // UMA GRA DE VERIFICAÇÃO DOS PRODUTOS QUE POSSUEM DATA DE    //
  // BALANÇO MAIOR QUE A DATA ATUAL                             //
  //*********************************************************PB*//

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '	CADITE.ITE_CODITE AS "Cód. Item",  ';
  strSQL := strSQL + '	CADITE.ITE_DESITE AS "Nome do Item" , ';
  strSQL := strSQL + '	ITEGER.ITE_DTABAL AS "Data de Balanço" ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PCMDET, CADITE, ITEGER ';
  strSQL := strSQL + 'WHERE ';

  strSQL := strSQL + '  PCD_CODITE        = CADITE.ITE_CODITE AND ';

  strSQL := strSQL + '  CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
  strSQL := strSQL + '  ITEGER.ITE_CODEMP = :CODEMP AND ';

  strSQL := strSQL + '  ITEGER.ITE_DTABAL >= :DTHOJE  AND';

  strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND    ';
  strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND    ';
  strSQL := strSQL + '  PCD_ESPDOC = ''PD''         ';

  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMPED').AsString   := strNumPed;
    ParamByName('CODEMP').AsString   := strNumEmp;
    ParamByName('DTHOJE').AsDate     := VS_Date;
    Open;
    If IsEmpty Then
      Result := True;
  End;

End;

{*****************************************}
{* DEFINE QUAIS ITENS E DE QUAIS PEDIDOS *}
{* SERÃO BAIXADOS. ESSA OPÇÃO É USADA QDO*}
{* O USUÁRIO ESCOLHE EM NÃO CARREGAR OS  *}
{* ITENS DO PEDIDO NA ENTRADA DE MERCA-  *}
{* DORIAS, E DIGITÁ-LO MANUALMENTE.      *}
{**************************************MV*}
function fDefinePedidosABaixar(Var blnResult: Boolean;
                               qryTmpItens: TDataSet;
                               stlPedidos: TStringList;
                               strAutEle: String;
                               blnEntradaSimplificada: Boolean = False;
                               blnCaixaUm: Boolean = False;
                               cdsDefBaixa: TDefineBaixaPedido = Nil;
                               strAutDet: String = 'AUTOINCREM';
                               blnBaixaEfetivaMovFiscal: Boolean = False;
                               strAutoIncMOVGER: string = ''): OleVariant;
  Var
    cdsPedidos: TUniClientDataSet;
    dspPedidos: TUniDataSetProvider;
    qryPedidos: TUniQuery;
    strSQL: String;
    fltFaltou: Double;
    fltDisponivel: Double;
    fltEntQtdIte: Double;
    fltEmbala: Double;
    strEMBPED,
    strCnvEmb: String;
    intContador,
    intTamPed,
    intDEQTEM,
    intRecNo: Integer;
    blnPreBaixa: Boolean;

    Function fSQLPedido(strNumPed, strCodEmp: String): String;
      Var
        strSQL: String;
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  " " AS KEYDOC, ';
      strSQL := strSQL + '  " " AS SERIE_, ';
      strSQL := strSQL + '  " " AS NUMDOC, ';
      strSQL := strSQL + '  " " AS ESPDOC, ';
      strSQL := strSQL + '  " " AS CODFOR, ';
      strSQL := strSQL + '  PCD_NUMPED AS NUMPED, ';
      strSQL := strSQL + '  PCD_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  PCD_CODITE AS CODITE, ';
      strSQL := strSQL + '  PCD_DESITE AS DESITE, ';
      strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
      strSQL := strSQL + '  IFNULL(PCD_NUMLOT,"") AS NUMLOT, ';

      If strCnvEmb <> 'N' Then
        strEMBPED := ' IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) '
      Else
        strEMBPED := ' 1.0000 ';

      strSQL := strSQL + strEMBPED + ' AS EMBPED, ';
      strSQL := strSQL + '  (PCD_QTDITE - PCD_QTDBAI) * ' + strEMBPED  + ' AS QTDITE, ';

      If blnBaixaEfetivaMovFiscal Then
      Begin
        strSQL := strSQL + '  BAI_QTDPED AS QTDBAI, ';
        strSQL := strSQL + '  DET_UNITAR AS UNIBAI, ';
        strSQL := strSQL + '  (BAI_QTDPED * DET_UNITAR) AS TOTBAI, ';
        strSQL := strSQL + '  (((PCD_QTDITE - PCD_QTDBAI) * ' + strEMBPED + ') - BAI_QTDPED) AS DIFQTD, ';
        strSQL := strSQL + '  ((PCD_QTDITE - PCD_QTDBAI) * (DET_UNITAR ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
        strSQL := strSQL + '  )) - (BAI_QTDPED * DET_UNITAR) AS DIFUNI, ';
      End
      Else If blnPreBaixa Then
      Begin
        strSQL := strSQL + '  DEF_AUTELE, ';

        strSQL := strSQL + '  DEF_QTDITE AS QTDBAI, ';

        strSQL := strSQL + '  (SELECT PRE_UNIBAI FROM PREBAI WHERE PRE_AUTPED = PCMDET.AUTOINCREM LIMIT 1) AS UNIBAI, ';

        strSQL := strSQL + '  (DEF_QTDITE * (SELECT PRE_UNIBAI FROM PREBAI WHERE PRE_AUTPED = PCMDET.AUTOINCREM LIMIT 1)) AS TOTBAI, ';

        strSQL := strSQL + '  (((PCD_QTDITE - PCD_QTDBAI) * ' + strEMBPED + ') - DEF_QTDITE) AS DIFQTD, ';

        strSQL := strSQL + '  ((PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
        strSQL := strSQL + '     * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
        strSQL := strSQL + '  )) - (DEF_QTDITE * (SELECT PRE_UNIBAI FROM PREBAI WHERE PRE_AUTPED = PCMDET.AUTOINCREM LIMIT 1)) AS DIFUNI, ';
      End Else
      Begin
        strSQL := strSQL + '  0.0000 AS QTDBAI, ';
        strSQL := strSQL + '  0.0000 AS UNIBAI, ';
        strSQL := strSQL + '  0.0000 AS TOTBAI, ';
        strSQL := strSQL + '  0.0000 AS DIFQTD, ';
        strSQL := strSQL + '  0.0000 AS DIFUNI, ';
      End;

      strSQL := strSQL + '  PCD_UNITAR / ' + strEMBPED  + ' AS UNITAR, ';

      strSQL := strSQL + '  (PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                          * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                          * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                          * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                          * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                          * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      strSQL := strSQL + '    ) AS TOTITE, ';


      strSQL := strSQL + '  PCMDET.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '  PCD_DTAPED AS DTAPED, ';

      If blnEntradaSimplificada And blnCaixaUm Then
      Begin
        strSQL := strSQL + '  PCD_PERIPI AS PERIPI, ';
        strSQL := strSQL + '  PCD_PERSUB AS PERSUB, ';
      End Else
      Begin
        strSQL := strSQL + '  0.0000 AS PERIPI, ';
        strSQL := strSQL + '  0.0000 AS PERSUB, ';
      End;

      strSQL := strSQL + '  0.0000 AS EXCESS ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMDET ';

      strSQL := strSQL + 'INNER JOIN PCMGER ';
      strSQL := strSQL + '    ON  PCG_NUMPED = PCD_NUMPED ';
      strSQL := strSQL + '    AND PCG_CODEMP = PCD_CODEMP ';
      strSQL := strSQL + '    AND PCG_ESPDOC = PCD_ESPDOC ';
      strSQL := strSQL + '    AND PCG_NUMCTN = PCD_NUMCTN ';

      strSQL := strSQL + '  INNER JOIN CADITE C ON C.ITE_CODITE = PCD_CODITE ';

      strSQL := strSQL + '  LEFT JOIN CADUNI ON (UNI_CODUNI=PCD_CODUNI) ';

      If blnBaixaEfetivaMovFiscal Then
      Begin
        strSQL := strSQL + '  INNER JOIN BAIPED ON BAI_AUTPED = PCMDET.AUTOINCREM            ';
        strSQL := strSQL + '  INNER JOIN MOVDET ON MOVDET.AUTOINCREM = BAIPED.BAI_AUTDET ';
      End;

      If blnPreBaixa Then
      Begin
        strSQL := strSQL + '  INNER JOIN DEFBAI ON DEF_AUTPCD  = PCMDET.AUTOINCREM             ';
        strSQL := strSQL + '                   AND DEF_GERELE  = ' + QuotedStr(strAutEle) + ' ';

        If Not strNumPed.IsEmpty Then
        Begin
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  PCD_NUMPED = ' + QuotedStr(strNumPed) + ' AND ';
          strSQL := strSQL + '  PCD_CODEMP = ' + QuotedStr(strCodEmp);
        End;

      End Else
      Begin

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PCD_ESPDOC = "PD"  AND   ';
        strSQL := strSQL + '  PCD_BAIXAD = 0 AND       ';
        strSQL := strSQL + '  PCD_NUMCTN = 0 AND       ';

        If Not fEmptystr(strAutoIncMOVGER) Then
          strSQL := strSQL + '  MOVDET.DET_SEQGER = ' + fQuotedStr(strAutoIncMOVGER) + '  '
        Else
        Begin
          strSQL := strSQL + '  PCD_NUMPED = ' + QuotedStr(strNumPed) + ' AND ';
          strSQL := strSQL + '  PCD_CODEMP = ' + QuotedStr(strCodEmp);
        End;

      End;

      Result := strSQL;
    End;

    Procedure pInsereDefBai(strAutDet, strAutPcd: String; fltQtdIte: Double);
    Begin
      If Assigned(cdsDefBaixa) And cdsDefBaixa.Active Then
        cdsDefBaixa.pInsereBaixa(strAutDet, strAutPcd, fltQtdIte);
    End;

begin
  blnResult := True;
  Result := Null;

  If Assigned(cdsDefBaixa) And (Not cdsDefBaixa.fIniciaDados) Then
  Begin
    blnResult := False;
    Exit;
  End;

  If (Not blnBaixaEfetivaMovFiscal) And ((Not Assigned(stlPedidos)) Or (stlPedidos.Count <= 0)) Then
    Exit;

  intTamPed := fTamNumPedCom;

  blnPreBaixa := (Not blnBaixaEfetivaMovFiscal) And TPreNota.fPossuiPreBaixa(strAutEle);

  strCnvEmb := fCfgSis('CNVEMB');

  intDEQTEM := fCfgSis('DEQTEM', VarInteger);

  Try
    If (Not blnBaixaEfetivaMovFiscal) Then
    Begin
      strSQL := fSQLPedido(LeftStr(stlPedidos[0], intTamPed), RightStr(stlPedidos[0], 3));
      For intContador := 1 To stlPedidos.Count - 1 Do
        strSQL := strSQL + ' UNION ALL ' + fSQLPedido(LeftStr(stlPedidos[intContador], intTamPed), RightStr(stlPedidos[intContador], 3));

      strSQL := strSQL + 'ORDER BY ';
      strSQL := strSQL + '  CODITE, DTAPED, NUMPED ';
    End
    Else
     strSQL := fSQLPedido('', '');

    qryPedidos := fCriaQuery;
    qryPedidos.SQL.Add(strSQL);
    qryPedidos.Open;
    pSetaClient(qryPedidos);

    dspPedidos := TUniDataSetProvider.Create(nil);
    dspPedidos.DataSet := qryPedidos;

    cdsPedidos := TUniClientDataSet.Create(nil);
    cdsPedidos.SetProvider(dspPedidos);
    If blnPreBaixa Then
      cdsPedidos.IndexFieldNames := 'DEF_AUTELE'
    Else
      cdsPedidos.IndexFieldNames := 'CODITE;DTAPED;AUTINC';

    cdsPedidos.Open;

    If blnPreBaixa Then
    Begin

      qryTmpItens.First;
      While (Not qryTmpItens.Eof) Do
      Begin
        If cdsPedidos.Locate('DEF_AUTELE', qryTmpItens.FieldByName('ENT_AUTELE').AsString, []) Then
        Begin
          While (cdsPedidos.FieldByName('DEF_AUTELE').AsString = qryTmpItens.FieldByName('ENT_AUTELE').AsString) And (not cdsPedidos.Eof) do
          Begin
            pInsereDefBai(qryTmpItens.FieldByName(strAutDet).AsString,
                          cdsPedidos.FieldByName('AUTINC').AsString,
                          cdsPedidos.FieldByName('QTDBAI').AsFloat);
            cdsPedidos.Next;
          End;
        end;

        qryTmpItens.Next;
      End;
    End;
    If blnPreBaixa Then
      cdsPedidos.IndexFieldNames := 'CODITE;DTAPED;AUTINC';

    {*****************************************}
    {* PROCESSA TODO O PEDIDO                *}
    {**************************************MV*}
    If (Not blnPreBaixa) And (Not blnBaixaEfetivaMovFiscal) Then
    Begin
      qryTmpItens.First;
      While (Not qryTmpItens.Eof) Do
      Begin
        {******************************************}
        {* PARA CADA PRODUTO, PERCORRO O ITEM COR-*}
        {* RESPONDENTE EM TODOS OS PEDIDOS        *}
        {***************************************MV*}
        If (strCnvEmb <> 'N') And (qryTmpItens.FindField('ENT_EMBALA') <> Nil) Then
          fltEmbala := IIF(qryTmpItens.FieldByName('ENT_EMBALA').AsFloat > 0,
                               qryTmpItens.FieldByName('ENT_EMBALA').AsFloat, 1)
        Else
          fltEmbala := 1;

        fltEntQtdIte := RoundTo(qryTmpItens.FieldByName('ENT_QTDITE').AsFloat * fltEmbala, - intDEQTEM);

        fltFaltou := fltEntQtdIte;

        cdsPedidos.First;
        cdsPedidos.Locate('CODITE', qryTmpItens.FieldByName('ENT_CODITE').AsString, []);

        intRecNo := -1;

        While (Not cdsPedidos.Eof) Do
        Begin

          If (cdsPedidos.FieldByName('CODITE').AsString = qryTmpItens.FieldByName('ENT_CODITE').AsString) And
             ((cdsPedidos.FieldByName('NUMLOT').AsString = qryTmpItens.FieldByName('ENT_NUMLOT').AsString) Or
               fEmptyStr(cdsPedidos.FieldByName('NUMLOT').AsString) Or
               fEmptyStr(qryTmpItens.FieldByName('ENT_NUMLOT').AsString) Or
              ('A DEFINIR' = qryTmpItens.FieldByName('ENT_NUMLOT').AsString)) Then
          Begin
            {*****************************************}
            {* SE JÁ TIVER QTD EM EXCESSO PULA       *}
            {**************************************MV*}
            If (cdsPedidos.FieldByName('EXCESS').AsFloat > 0.0) Then
            Begin
              cdsPedidos.Next;
              Continue;
            End;

            {*****************************************}
            {* SE JÁ BAIXOU COMPLETAMENTE PULA       *}
            {**************************************MV*}
            If (cdsPedidos.FieldByName('QTDBAI').AsFloat >= cdsPedidos.FieldByName('QTDITE').AsFloat) Then
            Begin
              cdsPedidos.Next;
              Continue;
            End;

            fltDisponivel := cdsPedidos.FieldByName('QTDITE').AsFloat -
                             cdsPedidos.FieldByName('QTDBAI').AsFloat;

            cdsPedidos.Edit;
            {*****************************************}
            {* CASO A QUANTIDADE DISPONÍVEL PARA     *}
            {* BAIXAR SEJA MAIOR QUE A QTD DIGITADA, *}
            {* BAIXO TODA A QUANTIDADE DIGITADA,     *}
            {* SENÃO, BAIXO APENAS O DISPONÍVEL      *}
            {**************************************MV*}
            If (fltDisponivel > fltEntQtdIte) and (fltFaltou >= fltEntQtdIte)  Then
            Begin
              cdsPedidos.FieldByName('QTDBAI').AsFloat := cdsPedidos.FieldByName('QTDBAI').AsFloat +
                                                          fltEntQtdIte;

              fltFaltou := fltFaltou - fltEntQtdIte;

              pInsereDefBai(qryTmpItens.FieldByName(strAutDet).AsString,
                            cdsPedidos.FieldByName('AUTINC').AsString,
                            fltEntQtdIte);
            End
            Else
            Begin

              If (fltFaltou > fltDisponivel) Then
              Begin
                cdsPedidos.FieldByName('QTDBAI').AsFloat := cdsPedidos.FieldByName('QTDBAI').AsFloat +
                                                            fltDisponivel;
                fltFaltou := fltFaltou - fltDisponivel;

               pInsereDefBai(qryTmpItens.FieldByName(strAutDet).AsString,
                             cdsPedidos.FieldByName('AUTINC').AsString,
                             fltDisponivel);

              End
              Else
              Begin
                cdsPedidos.FieldByName('QTDBAI').AsFloat := cdsPedidos.FieldByName('QTDBAI').AsFloat +
                                                            fltFaltou;

                pInsereDefBai(qryTmpItens.FieldByName(strAutDet).AsString,
                              cdsPedidos.FieldByName('AUTINC').AsString,
                              fltFaltou);

                fltFaltou := 0.0;
              End;


            End;

            If Not blnEntradaSimplificada Then
            Begin
              cdsPedidos.FieldByName('PERIPI').AsFloat := qryTmpItens.FieldByName('ENT_PERIPI').AsFloat;
              cdsPedidos.FieldByName('PERSUB').AsFloat := qryTmpItens.FieldByName('ENT_PERSUB').AsFloat;
            End;

            If (strCnvEmb <> 'N') Then
              cdsPedidos.FieldByName('UNIBAI').AsFloat := qryTmpItens.FieldByName('ENT_UNITAR').AsFloat / fltEmbala
            Else
              cdsPedidos.FieldByName('UNIBAI').AsFloat := qryTmpItens.FieldByName('ENT_UNITAR').AsFloat;

            cdsPedidos.Post;

            intRecNo := cdsPedidos.RecNo;
          End;

          cdsPedidos.Next;

          {*****************************************}
          {* SE NÃO FALTA BAIXAR MAIS NADA DESSE   *}
          {* ITEM, SAI DO WHILE                    *}
          {**************************************MV*}
          If fltFaltou <= 0.0 Then
            Break;

          If (cdsPedidos.FieldByName('CODITE').AsString <> qryTmpItens.FieldByName('ENT_CODITE').AsString) Then
            Break;
        End; {While (Not cdsPedidos.Eof) Do}

        {*****************************************}
        {* CASO FALTOU ALGUMA COISA PARA BAIXAR, *}
        {* É CONSIDERADO EXCESSO E VAI PARA O    *}
        {* ÚLTIMO PEDIDO.                        *}
        {**************************************MV*}
        If (fltFaltou > 0.0) And (intRecNo > -1) Then
        Begin
          cdsPedidos.RecNo := intRecNo;
          cdsPedidos.Edit;
          cdsPedidos.FieldByName('EXCESS').AsFloat := cdsPedidos.FieldByName('EXCESS').AsFloat + fltFaltou;
          cdsPedidos.Post;
        End;

        qryTmpItens.Next;
      End;
    End;

    If (Not blnPreBaixa) Then
    Begin
      {*****************************************}
      {* ALIMENTA A COLUNA DA DIFERENCA        *}
      {**************************************MV*}
      cdsPedidos.First;
      While (Not cdsPedidos.Eof) Do
      Begin
        cdsPedidos.Edit;

        cdsPedidos.FieldByName('TOTBAI').AsFloat := (cdsPedidos.FieldByName('QTDBAI').AsFloat + cdsPedidos.FieldByName('EXCESS').AsFloat) *
                                                     cdsPedidos.FieldByName('UNIBAI').AsFloat;

        cdsPedidos.FieldByName('DIFQTD').AsFloat := cdsPedidos.FieldByName('QTDITE').AsFloat -
                                                     (cdsPedidos.FieldByName('QTDBAI').AsFloat + cdsPedidos.FieldByName('EXCESS').AsFloat);

        cdsPedidos.FieldByName('DIFUNI').AsFloat := cdsPedidos.FieldByName('TOTITE').AsFloat - cdsPedidos.FieldByName('TOTBAI').AsFloat;

        cdsPedidos.Post;
        cdsPedidos.Next;

      End; {While (Not qryTmpItens.Eof) Do}
    End;

    Result := cdsPedidos.Data;

    FreeAndNil(cdsPedidos);
    FreeAndNil(dspPedidos);
    FreeAndNil(qryPedidos);
  Except
    On E: Exception Do
    Begin
      blnResult := False;
      pMensagensErro(E.Message, '[fDefinePedidosABaixar]');
    End;
  End;
end;

function fDefinePedidosABaixarGarantia(Var blnResult: Boolean;
                                       qryTmpItens: TDataSet;
                                       strCnvEmb: String;
                                       blnRefugo : Boolean = False;
                                       blnBaixa  : Boolean = False;
                                       cdsDefBaixa: TDefineBaixaPedido = Nil;
                                       strAutDet: String = 'AUTOINCREM'): OleVariant;
  Var
    cdsPedidos: TUniClientDataSet;
    dspPedidos: TUniDataSetProvider;
    qryPedidos: TUniQuery;
    strSQL: String;

    {*****************************************}
    {* DEFINE O FILTRO QUE SERÁ USADO        *}
    {**************************************MV*}
    procedure pMontaFiltro;
    begin
      cdsPedidos.Filtered := False;
      cdsPedidos.Filter   := ' CODITE = ' + qryTmpItens.FieldByName('ENT_CODITE').AsString;
      cdsPedidos.Filtered := True;
    end;

    Procedure pInsereDefBai(strAutDet, strAutPcd: String; fltQtdIte: Double);
    Begin
      If Assigned(cdsDefBaixa) And cdsDefBaixa.Active Then
        cdsDefBaixa.pInsereBaixa(strAutDet, strAutPcd, fltQtdIte);
    End;

begin
  blnResult := True;
  Result    := Null;

  If Assigned(cdsDefBaixa) And (Not cdsDefBaixa.fIniciaDados) Then
  Begin
    blnResult := False;
    Exit;
  End;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
   	strSQL := strSQL + '  " " AS KEYDOC, ';
  	strSQL := strSQL + '  " " AS SERIE_, ';
  	strSQL := strSQL + '  " " AS NUMDOC, ';
  	strSQL := strSQL + '  " " AS ESPDOC, ';
  	strSQL := strSQL + '  " " AS CODFOR, ';
    strSQL := strSQL + '  PCD_NUMPED AS NUMPED, ';
    strSQL := strSQL + '  PCD_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  PCD_CODITE AS CODITE, ';
    strSQL := strSQL + '  PCD_DESITE AS DESITE, ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
    strSQL := strSQL + '  IFNULL(PCD_NUMLOT,"") AS NUMLOT, ';

    If strCnvEmb <> 'N' Then
    Begin
      strSQL := strSQL + '  SUM(L.GAU_QTDRET * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA)) AS QTDITE, ';
      strSQL := strSQL + '  PCD_UNITAR / IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AS UNITAR, ';
    End Else
    Begin
      strSQL := strSQL + '  SUM(L.GAU_QTDRET) AS QTDITE, ';
      strSQL := strSQL + '  PCD_UNITAR AS UNITAR, ';
    End;

    strSQL := strSQL + '  SUM(L.GAU_QTDRET) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
    strSQL := strSQL + '                                  * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
    strSQL := strSQL + '                                  * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
    strSQL := strSQL + '                                  * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
    strSQL := strSQL + '                                  * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
    strSQL := strSQL + '                                  * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
    strSQL := strSQL + '    ) AS TOTITE, ';

    strSQL := strSQL + '  P.AUTOINCREM AS AUTINC, ';
    strSQL := strSQL + '  PCD_DTAPED AS DTAPED, ';
    strSQL := strSQL + '  0.0000 AS QTDBAI, ';
    strSQL := strSQL + '  0.0000 AS UNIBAI, ';
    strSQL := strSQL + '  0.0000 AS TOTBAI, ';
    strSQL := strSQL + '  0.0000 AS DIFQTD, ';
    strSQL := strSQL + '  0.0000 AS DIFUNI, ';
    strSQL := strSQL + '  0.0000 AS PERIPI, ';
    strSQL := strSQL + '  0.0000 AS PERSUB, ';

    strSQL := strSQL + '  0.0000 AS EXCESS ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGAG G INNER JOIN MOVGAD D ON G.AUTOINCREM  = D.GAD_SEQGAG ';
    strSQL := strSQL + '           INNER JOIN MOVGAE E ON E.GAE_SEQGAD  = D.AUTOINCREM ';
    strSQL := strSQL + '           INNER JOIN MOVGAU L ON D.AUTOINCREM  = L.GAU_SEQGAD ';
    strSQL := strSQL + '           INNER JOIN PCMDET P ON SUBSTRING(P.PCD_DOCORI,1,' + IntToStr(fTamDocCadRec) + ') = GAE_NUMENV ';
    strSQL := strSQL + '                              AND SUBSTRING(P.PCD_DOCORI,' + IntToStr(IfThen(fTamDocCadRec = 6, 7, 13)) + ',2) = GAE_ESPENV ';
    strSQL := strSQL + '                              AND P.PCD_CODEMP = ' + QuotedStr(VS_strCodEmp);
    strSQL := strSQL + '           LEFT  JOIN CADUNI U ON U.UNI_CODUNI = P.PCD_CODUNI ';

    strSQL := strSQL + 'WHERE ';
    if Not blnRefugo Then
    Begin
      If blnBaixa Then
        strSQL := strSQL + '      IFNULL(GAU_SEQDET,"") = "BAIXA_N" '
      Else
        strSQL := strSQL + '      IFNULL(GAU_SEQDET,"") = "" ';
    End
    Else
      strSQL := strSQL + '      IFNULL(GAU_SEQDET,"") = "REFUGO_N" ';

    strSQL := strSQL + '  AND PCD_CODEMP = ' + QuotedStr(VS_strCodEmp);
    strSQL := strSQL + '  AND PCD_ESPDOC = "PD" ';
    strSQL := strSQL + '  AND PCD_BAIXAD = 0 ';
    strSQL := strSQL + '  AND PCD_NUMCTN = 0 ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  PCD_CODITE, PCD_NUMPED ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  PCD_CODITE, PCD_DTAPED, PCD_NUMPED ';

    qryPedidos := fCriaQuery;
    qryPedidos.SQL.Add(strSQL);
    qryPedidos.Open;
    pSetaClient(qryPedidos);

    dspPedidos := TUniDataSetProvider.Create(nil);
    dspPedidos.DataSet := qryPedidos;

    cdsPedidos := TUniClientDataSet.Create(nil);
    cdsPedidos.SetProvider(dspPedidos);
    cdsPedidos.IndexFieldNames := 'DTAPED;AUTINC';
    cdsPedidos.Open;

    {*****************************************}
    {* PROCESSA TODO O PEDIDO                *}
    {**************************************MV*}
    qryTmpItens.First;
    While (Not qryTmpItens.Eof) Do
    Begin
      pMontaFiltro;

      If cdsPedidos.IsEmpty Then
      Begin
        qryTmpItens.Next;
        Continue;
      End;

      cdsPedidos.First;
      While (Not cdsPedidos.Eof) Do
      Begin

        If not fEmptyStr(qryTmpItens.FieldByName(strAutDet).AsString) Then
          pInsereDefBai(qryTmpItens.FieldByName(strAutDet).AsString,
                        cdsPedidos.FieldByName('AUTINC').AsString,
                        cdsPedidos.FieldByName('QTDITE').AsFloat);

        cdsPedidos.Edit;
        cdsPedidos.FieldByName('QTDBAI').AsFloat := cdsPedidos.FieldByName('QTDBAI').AsFloat +
                                                    cdsPedidos.FieldByName('QTDITE').AsFloat;

        cdsPedidos.FieldByName('PERIPI').AsFloat := qryTmpItens.FieldByName('ENT_PERIPI').AsFloat;
        cdsPedidos.FieldByName('PERSUB').AsFloat := qryTmpItens.FieldByName('ENT_PERSUB').AsFloat;
        cdsPedidos.FieldByName('UNIBAI').AsFloat := cdsPedidos.FieldByName('UNITAR').AsFloat;
        cdsPedidos.Post;

        cdsPedidos.Next;
      End;

      qryTmpItens.Next;
    End;

    cdsPedidos.Filtered := False;
    cdsPedidos.Filter   := '';

    {*****************************************}
    {* ALIMENTA A COLUNA DA DIFERENCA        *}
    {**************************************MV*}
    cdsPedidos.First;
    While (Not cdsPedidos.Eof) Do
    Begin
      cdsPedidos.Edit;

      cdsPedidos.FieldByName('TOTBAI').AsFloat := cdsPedidos.FieldByName('QTDBAI').AsFloat *
                                                  cdsPedidos.FieldByName('UNIBAI').AsFloat;

      cdsPedidos.FieldByName('DIFQTD').AsFloat := cdsPedidos.FieldByName('QTDITE').AsFloat -
                                                  cdsPedidos.FieldByName('QTDBAI').AsFloat;

      cdsPedidos.FieldByName('DIFUNI').AsFloat := cdsPedidos.FieldByName('TOTITE').AsFloat -
                                                  cdsPedidos.FieldByName('TOTBAI').AsFloat;

      cdsPedidos.Post;
      cdsPedidos.Next;
    End;

    Result := cdsPedidos.Data;

    FreeAndNil(cdsPedidos);
    FreeAndNil(dspPedidos);
    FreeAndNil(qryPedidos);
  Except
    On E: Exception Do
    Begin
      blnResult := False;
      pMensagensErro(E.Message, '[fDefinePedidosABaixarGarantia]');
    End;
  End;
end;

function fGravaHistoricoEntradaMercadorias(strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           strCodFor,
                                           strSerie,
                                           strNumPed,
                                           strEmpPed,
                                           strCodIte,
                                           strDesIte: String;
                                           fltQtdIte,
                                           fltUnitar,
                                           fltTotIte,
                                           fltQtdBai,
                                           fltUniBai,
                                           fltTotBai,
                                           fltExcess,
                                           fltDifQtd,
                                           fltDifUni: Double;
                                           strAutInc: String = ''): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  Try
    qryAux.SQL.Add('INSERT INTO ');
    qryAux.SQL.Add('  HISENT ');
    qryAux.SQL.Add('( ');
    qryAux.SQL.Add('  HIS_NUMDOC, ');
    qryAux.SQL.Add('  HIS_ESPDOC, ');
    qryAux.SQL.Add('  HIS_CODEMP, ');
    qryAux.SQL.Add('  HIS_CODFOR, ');
    qryAux.SQL.Add('  HIS_SERIE_, ');
    qryAux.SQL.Add('  HIS_NUMPED, ');
    qryAux.SQL.Add('  HIS_EMPPED, ');
    qryAux.SQL.Add('  HIS_CODITE, ');
    qryAux.SQL.Add('  HIS_DESITE, ');
    qryAux.SQL.Add('  HIS_QTDITE, ');
    qryAux.SQL.Add('  HIS_UNITAR, ');
    qryAux.SQL.Add('  HIS_TOTITE, ');
    qryAux.SQL.Add('  HIS_QTDBAI, ');
    qryAux.SQL.Add('  HIS_UNIBAI, ');
    qryAux.SQL.Add('  HIS_TOTBAI, ');
    qryAux.SQL.Add('  HIS_EXCESS, ');
    qryAux.SQL.Add('  HIS_DIFQTD, ');
    qryAux.SQL.Add('  HIS_DIFUNI, ');
    qryAux.SQL.Add('  AUTOINCREM) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :NUMDOC, ');
    qryAux.SQL.Add('  :ESPDOC, ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :CODFOR, ');
    qryAux.SQL.Add('  :SERIE_, ');
    qryAux.SQL.Add('  :NUMPED, ');
    qryAux.SQL.Add('  :EMPPED, ');
    qryAux.SQL.Add('  :CODITE, ');
    qryAux.SQL.Add('  :DESITE, ');
    qryAux.SQL.Add('  :QTDITE, ');
    qryAux.SQL.Add('  :UNITAR, ');
    qryAux.SQL.Add('  :TOTITE, ');
    qryAux.SQL.Add('  :QTDBAI, ');
    qryAux.SQL.Add('  :UNIBAI, ');
    qryAux.SQL.Add('  :TOTBAI, ');
    qryAux.SQL.Add('  :EXCESS, ');
    qryAux.SQL.Add('  :DIFQTD, ');
    qryAux.SQL.Add('  :DIFUNI, ');
    qryAux.SQL.Add('  :AUTINC) ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODFOR').AsString := strCodFor;

    If fEmptyStr(strSerie) Then
      qryAux.ParamByName('SERIE_').AsString := ''
    Else
      qryAux.ParamByName('SERIE_').AsString := strSerie;

    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('EMPPED').AsString := strEmpPed;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('DESITE').AsString := strDesIte;
    qryAux.ParamByName('QTDITE').AsFloat  := fltQtdIte;
    qryAux.ParamByName('UNITAR').AsFloat  := fltUnitar;
    qryAux.ParamByName('TOTITE').AsFloat  := fltTotIte;
    qryAux.ParamByName('QTDBAI').AsFloat  := fltQtdBai;
    qryAux.ParamByName('UNIBAI').AsFloat  := fltUniBai;
    qryAux.ParamByName('TOTBAI').AsFloat  := fltTotBai;
    qryAux.ParamByName('EXCESS').AsFloat  := fltExcess;
    qryAux.ParamByName('DIFQTD').AsFloat  := fltDifQtd;
    qryAux.ParamByName('DIFUNI').AsFloat  := fltDifUni;

    If strAutInc.IsEmpty Then
      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('HISENT', VS_strCodEmp)
    Else
      qryAux.ParamByName('AUTINC').AsString := strAutInc;

    qryAux.ExecSQL;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaHistoricoEntradaMercadorias]');
    End;
  End;

  FreeAndNil(qryAux);
end;

function fPedidoJaExplodido(strNumPed, strEspPed, strEmpPed: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  COUNT(DISTINCT PCD_EMPDES) AS QTD ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  PCDDET ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  PCD_NUMPED = :NUMPED AND ');
  qryAux.SQL.Add('  PCD_ESPDOC = :ESPPED AND ');
  qryAux.SQL.Add('  PCD_CODEMP = :EMPPED AND ');
  qryAux.SQL.Add('  PCD_QTDITE > 0 ');

  qryAux.ParamByName('NUMPED').AsString := strNumPed;
  qryAux.ParamByName('ESPPED').AsString := strEspPed;
  qryAux.ParamByName('EMPPED').AsString := strEmpPed;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger <= 1);

  qryAux.Close;
  FreeAndNil(qryAux);
end;

function fCalTotPontProfissDev: Double;
  Var
    qryGen: TUniQuery;
begin

  Result := 0.0;
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQl.Clear;
    SQL.Add('SELECT * FROM TMP_ENTMER ');
    Open;
    First;
    While Not Eof Do
    Begin
      Result := Result + ( FieldByName('ENT_QTDITE').AsFloat *
                           fQtdPontoProfiss(FieldByName('ENT_CODITE').AsString, FieldByName('ENT_CODEMP').AsString) );
      Next;
    End;
  End;

  FreeAndNil(qryGen);

end;

function fQtdPontoProfiss(strCodIte, strCodEmp: String): Double;
  Var
    qryGen : TUniQuery;
begin

  Result := 0;
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ITE_QTPPRO FROM ITEGER WHERE ITE_CODITE =:CODITE AND ITE_CODEMP =:CODEMP ');
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If Not IsEmpty Then
      Result := Fields[0].AsFloat;

  End;

  FreeAndNil(qryGen);

end;

{*****************************************}
{* ESSA FUNCAO DESFATURA APENAS O PCMGER *}
{* O PCMDET TEM QUE SER DESFAT. NA MÃO   *}
{**************************************AF*}
function fDesfaturaPedidoCompra(stlPedCom: TStringList): Boolean;
  Var
    fltTotIpiPcmDet: Double;
    fltTotSubPcmDet: Double;
    fltTotDarPcmDet: Double;
    fltSubFCPPcmDet: Double;
    fltTotItePcmDet: Double;
    fltTotIcmPcmDet: Double;
    fltTotPisPcmDet: Double;
    fltValCbsPcmDet: Double;
    fltValIbsPcmDet: Double;
    fltVal_IsPcmDet: Double;

    strSQL: String;
    qryGen: TUniQuery;
    intContador: Integer;
    blnZonaFranca  : Boolean;
begin
  blnZonaFranca := fEhEstadoRegraZonaFranca(fCadEmp('ESTADO'));

  Result := True;
  qryGen := fCriaQuery;

  Try

    For intContador := 0 To stlPedCom.Count -1 Do
    Begin
      {*****************************************}
      {* CALCULA TOTAIS PARA ATUALIZAR PCMGER  *}
      {**************************************AF*}
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + ' SUM( ((PCD_QTDITE - PCD_QTDBAI)  * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      strSQL := strSQL + '      )) ) AS TOTITE, ';

      strSQL := strSQL + ' SUM( (((PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      strSQL := strSQL + '      )) * ( PCD_PERIPI/100)) ) AS TOTIPI, ';

      strSQL := strSQL + ' SUM( (((PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100) ';
      strSQL := strSQL + '      )) * ( PCD_PERSUB/100)) ) AS TOTSUB,  ';

      strSQL := strSQL + ' SUM( (((PCD_QTDITE - PCD_QTDBAI) * (PCD_UNITAR * (1 - IFNULL(PCD_DESUNI, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN2, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN3, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN4, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN5, 0)/100) ';
      strSQL := strSQL + '                                                * (1 - IFNULL(PCD_DESUN6, 0)/100))) * ( PCD_PERSUB/100)) * PCD_PERFCP / 100) AS SUBFCP, ';

      strSQL := strSQL + ' SUM( (PCD_VALICM / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS TOTICM, ';
      strSQL := strSQL + ' SUM( (PCD_DESPIS / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS TOTPIS, ';

      strSQL := strSQL + ' SUM( (IFNULL(PCD_VALCBS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VALCBS, ';
      strSQL := strSQL + ' SUM( (IFNULL(PCD_VALIBS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VALIBS, ';
      strSQL := strSQL + ' SUM( (IFNULL(PCD_VAL_IS, 0) / PCD_QTDITE) * (PCD_QTDITE - PCD_QTDBAI) ) AS VAL_IS, ';

      strSQL := strSQL + ' SUM(PCD_TOTDAR) AS TOTDAR  ';

      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  PCMDET ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCD_ESPDOC = "PD" AND ';
      strSQL := strSQL + '  PCD_NUMCTN = 0 AND ';
      strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  (PCD_BAIXAD = 0 OR ';
      strSQL := strSQL + '  (PCD_QTDITE - PCD_QTDBAI) > 0) ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('NUMPED').AsString := LeftStr(stlPedCom.Strings[intContador] , fTamDocCadRec());
      qryGen.ParamByName('CODEMP').AsString := RightStr(stlPedCom.Strings[intContador],3);
      qryGen.Open;

      fltTotIpiPcmDet := qryGen.FieldByName('TOTIPI').AsFloat;
      fltTotSubPcmDet := qryGen.FieldByName('TOTSUB').AsFloat;
      fltTotDarPcmDet := qryGen.FieldByName('TOTDAR').AsFloat;
      fltSubFCPPcmDet := qryGen.FieldByName('SUBFCP').AsFloat;
      fltTotItePcmDet := qryGen.FieldByName('TOTITE').AsFloat;
      fltTotIcmPcmDet := qryGen.FieldByName('TOTICM').AsFloat;
      fltTotPisPcmDet := qryGen.FieldByName('TOTPIS').AsFloat;
      fltValCbsPcmDet := RoundTo(qryGen.FieldByName('VALCBS').AsFloat, -2);
      fltValIbsPcmDet := RoundTo(qryGen.FieldByName('VALIBS').AsFloat, -2);
      fltVal_IsPcmDet := RoundTo(qryGen.FieldByName('VAL_IS').AsFloat, -2);

      qryGen.Close;

      {*****************************************}
      {* ATUALIZA PCMGER                       *}
      {**************************************AF*}
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  PCMGER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  PCG_TOTIPI = :IPIATU, ';
      strSQL := strSQL + '  PCG_TOTSUB = :SUBATU, ';
      strSQL := strSQL + '  PCG_TOTDAR = :DARATU, ';
      strSQL := strSQL + '  PCG_SUBFCP = :FCPATU, ';
      strSQL := strSQL + '  PCG_TOTITE = :ITEATU, ';

      strSQL := strSQL + '  PCG_VALICM = :TOTICM, ';
      strSQL := strSQL + '  PCG_DESPIS = :TOTPIS, ';

      strSQL := strSQL + '  PCG_VALCBS = :VALCBS, ';
      strSQL := strSQL + '  PCG_VALIBS = :VALIBS, ';
      strSQL := strSQL + '  PCG_VAL_IS = :VAL_IS, ';

      strSQL := strSQL + '  PCG_TOTGER = (PCG_TOTIPI + PCG_TOTSUB + PCG_SUBFCP + PCG_TOTITE + PCG_VALFRE + PCG_DESACE ' + fSQLSomaImpostosReforma('PCG');

      If blnZonaFranca Then
        strSQL := strSQL + '  - :TOTICM - :TOTPIS ';

      strSQL := strSQL + ' ), ';

      strSQL := strSQL + '  PCG_BAIXAD = :BAIXAD ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PCG_ESPDOC = "PD" AND ';
      strSQL := strSQL + '  PCG_NUMPED = :NUMPED AND ';
      strSQL := strSQL + '  PCG_CODEMP = :CODEMP ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ParamByName('IPIATU').AsFloat := fltTotIpiPcmDet;
      qryGen.ParamByName('SUBATU').AsFloat := fltTotSubPcmDet;
      qryGen.ParamByName('DARATU').AsFloat := fltTotDarPcmDet;
      qryGen.ParamByName('FCPATU').AsFloat := fltSubFCPPcmDet;

      qryGen.ParamByName('VALCBS').AsFloat := fltValCbsPcmDet;
      qryGen.ParamByName('VALIBS').AsFloat := fltValIbsPcmDet;
      qryGen.ParamByName('VAL_IS').AsFloat := fltVal_IsPcmDet;

      If blnZonaFranca Then
      Begin
        qryGen.ParamByName('TOTICM').AsFloat := fltTotIcmPcmDet;
        qryGen.ParamByName('TOTPIS').AsFloat := fltTotPisPcmDet;
      End Else
      Begin
        qryGen.ParamByName('TOTICM').AsFloat := 0;
        qryGen.ParamByName('TOTPIS').AsFloat := 0;
      End;

      qryGen.ParamByName('ITEATU').AsFloat := fltTotItePcmDet;
      qryGen.ParamByName('NUMPED').AsString := LeftStr(stlPedCom.Strings[intContador] , fTamDocCadRec());
      qryGen.ParamByName('CODEMP').AsString := RightStr(stlPedCom.Strings[intContador], 3);
      qryGen.ParamByName('BAIXAD').AsInteger := 0;
      qryGen.ExecSQL;

      TDuplicatasPedidoCompra.pAtualizaBaixaParcial(LeftStr(stlPedCom.Strings[intContador] , fTamDocCadRec()), RightStr(stlPedCom.Strings[intContador],3), 'PD');

      If fCfgSis('URMEIE', varBoolean) Then
        TManutencaoEquipamentoInterno.pAjustaStatusAutomatica(TManutencaoEquipamentoInterno.fRetornaSolicitacaoVinculada(LeftStr(stlPedCom.Strings[intContador] , fTamDocCadRec()), 'PD'));
    End;

  Except

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fDesfaturaPedidoCompra]');
      Result := False;

    End;

  End;

  FreeAndNil(qryGen);

End;

function fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryGerEle: TUniQuery;
Begin
  Try
    qryGerEle := fCriaQuery;

    With qryGerEle, SQL Do
    Begin
      Clear;
      Add('UPDATE GERELE');
      Add('SET');
      Add('  GER_EMPENT = :CODEMP,');
      Add('  GER_DOCENT = :NUMDOC,');
      Add('  GER_ESPENT = :ESPDOC ');
      Add('WHERE');
      Add('  AUTOINCREM = :AUTINC');

      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('AUTINC').AsString := strAutEle;
      ExecSQL;

      Result := TRUE;
    End;

    FreeAndNil(qryGerEle);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fBaixaNotaEletronica]');
    End;
  End;
End;

procedure pConverteQtdItensEmb;
  Var
    qryUpd: TUniQuery;
    strSql: String;
begin

  qryUpd := fCriaQuery;

  strSql := '';
  strSql := strSql + ' UPDATE                                    ';
  strSql := strSql + ' 	 TMP_ENTMER                              ';
  strSql := strSql + ' SET                                       ';
  strSql := strSql + '   ENT_QTDITE = ROUND(ENT_QTDITE * ENT_EMBALA, ' + fCfgSis('DEQTEM') + '), ';
  strSql := strSql + '   ENT_UNITAR = (ENT_UNITAR / ENT_EMBALA)  ';
  strSql := strSql + ' WHERE                                     ';
  strSql := strSql + '   ENT_EMBALA > 0                          ';

  With qryUpd, SQL Do
  Begin
    Clear;
    Add(strSql);
    ExecSQL;
  End;

  FreeAndNil(qryUpd);

end;

Function fRetBaseSubstituicaoCusto4(Var strBasCalSub: String): Boolean;
  Var
    qryForCus: TUniQuery;
Begin
  Result := False;
  strBasCalSub := '';

  qryForCus := fCriaQuery;
  qryForCus.SQL.Text := 'SELECT FOR_BASCAL FROM FORCUS WHERE FOR_CODEMP = :CODEMP AND FOR_CODCAM = "SUBSTI"';
  qryForCus.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryForCus.Open;

  If Not qryForCus.IsEmpty Then
  Begin
    strBasCalSub := qryForCus.FieldByName('FOR_BASCAL').AsString;

    If (Pos('FREENT', strBasCalSub) > 0) And (Pos('VALFRE', strBasCalSub) > 0) Then // NÃO PODE SOMAR OS DOIS - ISSO AQUI TÁ MEIA BOCA SÓ
      strBasCalSub := AnsiReplaceStr(strBasCalSub, 'FREENT', '0');

    If fConsideraICMSDesoneradoComDesconto(fCadEmp('ESTADO')) Then
      strBasCalSub := AnsiReplaceStr(strBasCalSub, 'COMLIQ', '(ENT_TOTITE - ENT_DESESP + IF(ENT_USODES = 1, ENT_VICMDE, 0))')
    Else
      strBasCalSub := AnsiReplaceStr(strBasCalSub, 'COMLIQ', '(ENT_TOTITE - ENT_DESESP)');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'ICMENT', 'ENT_VALICM');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'SUBFED', '0');          // COLOCADO ZERO POIS NÃO EXISTE NA TEMPORÁRIA E NA PRÁTICA NA É UDAD0
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'IPIENT', '(ENT_VALIPI + IFNULL(ENT_VAEIPI, 0))');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'VALFRE', '(ENT_VALFRE + ENT_FRECON + ENT_FRERPA)');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'FREENT', '(ENT_VALFRE + ENT_FRECON + ENT_FRERPA)');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'ACRFIN', '0');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'DESADB', '0');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'DEPICO', 'IFNULL(ENT_DEPICO,0)');
    strBasCalSub := AnsiReplaceStr(strBasCalSub, 'DEICMS', 'IFNULL(ENT_DEICMS,0)');
    strBasCalSub := Trim(strBasCalSub);

    Result := Not strBasCalSub.IsEmpty;

    If Result Then
      strBasCalSub := Concat('(', strBasCalSub, ')');
  End;

  FreeAndNil(qryForCus);
End;

procedure pAtualizaPercentuaisSubstituicaoFreteDoItem(blnAtuTCI, blnAtu_TS, blnAtuSub, blnAtuFre, blnAtuIcm, blnFreIpi, blnencargosNoFrete, blnNotaImportacao: Boolean;
    fltValFre, fltFreCon: Double;
    var blnOutDesNoFreIte: Boolean);
  Var
    qryUpd: TUniQuery;
    strBasCalSub,
    strFRMCUS,
    strSql: String;
    strSQLCampos: String;
    intDecUni,
    intPreFre: Integer;
    ConjCalculoIpiNotImp: TConjCalculoIpiNotImp;
    strAtuNMD: String;
    strRoundICM: string;
begin
  blnOutDesNoFreIte := False;
  strRoundICM := IIf(blnNotaImportacao, '2', '1');
  If blnAtuSub Or blnAtuFre Or blnAtuIcm Then
  Begin


    strFRMCUS := fCfgSis('FRMCUS',varString);
    strAtuNMD := fCfgSis('ATUNMD');

    If strFRMCUS.IsEmpty Then
      strFRMCUS := '1';

    intPreFre := fCfgSis('PERFRE', varInteger);

    // SE TIVER FRETE NA NOTA E CFG_PERFRE = 2 NAO DEVERIA TER CONHECIMENTO DE FRETE E VAI SER ATUALIZADO O PERCENTUAL DE FRETE
    If (intPreFre = 2) And (fltValFre > 0) Then
      intPreFre := 1;

    qryUpd := fCriaQuery;

    strSql := '';
    strSql := strSql + ' UPDATE         ';
    strSql := strSql + ' 	 TMP_ENTMER   ';
    strSql := strSql + ' SET            ';

    intDecUni := fCfgSis('DECUNI', varInteger);
    strSQLCampos := '';
    If blnAtuFre Then
    Begin


      If (intPreFre = 2) And (fltFreCon > 0) Then
      Begin
        If blnencargosNoFrete Then
        Begin
          strSQLCampos := strSQLCampos + '  ENT_FREITE = ROUND((ENT_FRECON + ENT_FRERPA + ENT_OUTDES + ENT_DESACE) / ENT_QTDITE, ' +  IntToStr(intDecUni)  + '), ';
          blnOutDesNoFreIte := True;
        End
        Else
          strSQLCampos := strSQLCampos + '  ENT_FREITE = ROUND((ENT_FRECON + ENT_FRERPA) / ENT_QTDITE, ' +  IntToStr(intDecUni)  + '), ';

        strSQLCampos := strSQLCampos + '  ENT_FREENT = 0 ';
      End Else
      Begin

        If blnFreIpi Then
        Begin
          strSQLCampos := strSQLCampos + '  ENT_FREENT = ( ( ( ENT_VALFRE + ENT_FRECON + ENT_FRERPA) / (ENT_TOTITE - ENT_DESESP + ENT_VALIPI + IFNULL(ENT_VAEIPI, 0) + ';
          strSQLCampos := strSQLCampos + '                                    (ENT_VALRET + ENT_VAERET + ENT_VALANT + ENT_VALGNR) + ENT_DESACE) ) * 100 ) ';
        End Else
        Begin
          strSQLCampos := strSQLCampos + '  ENT_FREENT = ( ( ( ENT_VALFRE + ENT_FRECON + ENT_FRERPA) / (ENT_TOTITE - ENT_DESESP) ) * 100 )  ';
        End;

        If blnencargosNoFrete Then
        Begin
          strSQLCampos := strSQLCampos + ',  ENT_FREITE = ROUND((ENT_OUTDES + ENT_DESACE) / ENT_QTDITE, ' +  IntToStr(intDecUni)  + ') ';
          blnOutDesNoFreIte := True;
        End

        Else If fCfgSis('PERFRE', varInteger) = 2 Then
          strSQLCampos := strSQLCampos + ',  ENT_FREITE = 0 ';
      End;

    End;

    If blnAtuSub Then
    Begin
      If Not fEmptyStr(strSQLCampos) Then
        strSQLCampos := strSQLCampos + ', ';

      Case strFRMCUS[1] Of
        '1': strSQLCampos := strSQLCampos + '  ENT_SUBSTI = ( ( ( ENT_VALRET + ENT_VAERET + ENT_VALANT + IF(ENT_GNRORI = "T", 0, ENT_VALGNR) + IFNULL(ENT_VFCPST, 0)) / (ENT_TOTITE - ENT_DESESP + ENT_VALIPI + IFNULL(ENT_VAEIPI, 0))) * 100 ) ';
        '3': strSQLCampos := strSQLCampos + '  ENT_SUBSTI = ( ( ( ENT_VALRET + ENT_VAERET + ENT_VALANT + IF(ENT_GNRORI = "T", 0, ENT_VALGNR) + IFNULL(ENT_VFCPST, 0)) / (ENT_TOTITE - ENT_DESESP + ENT_VALIPI + IFNULL(ENT_VAEIPI, 0) + (ENT_VALFRE + ENT_FRECON + ENT_FRERPA) ) ) * 100 )';

        '4': Begin
               If fRetBaseSubstituicaoCusto4(strBasCalSub) Then
                 strSQLCampos := strSQLCampos + '  ENT_SUBSTI = ( ( ( ENT_VALRET + ENT_VAERET + ENT_VALANT + IF(ENT_GNRORI = "T", 0, ENT_VALGNR) + IFNULL(ENT_VFCPST, 0)) / ' + strBasCalSub + ') * 100 ) '
               Else
                 strSQLCampos := strSQLCampos + '  ENT_SUBSTI = ENT_SUBSTI '; // APENAS PARA NAO DAR ERRO ABAIXO
             End;

        Else strSQLCampos := strSQLCampos + '  ENT_SUBSTI = ( ( ( ENT_VALRET + ENT_VAERET + ENT_VALANT + IF(ENT_GNRORI = "T", 0, ENT_VALGNR) + IFNULL(ENT_VFCPST, 0)) / (ENT_TOTITE - ENT_DESESP) ) * 100 ) ';
      End;

    End;

    If blnAtuTCI Then
    begin
      If Not fEmptyStr(strSQLCampos) Then
        strSQLCampos := strSQLCampos + ', ';
      strSQLCampos := strSQLCampos + '  ENT_TCIFCU =  ENT_ALQTCI';
    End;

    If BlnAtu_TS Then
    begin
      If Not fEmptyStr(strSQLCampos) Then
        strSQLCampos := strSQLCampos + ', ';
      strSQLCampos := strSQLCampos + '  ENT_TSCUST =  ENT_ALQ_TS';
    End;

    If blnAtuIcm Then
    Begin
      If Not fEmptyStr(strSQLCampos) Then
        strSQLCampos := strSQLCampos + ', ';

      If fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) And (fCfgSis('CTCICI', varBoolean))  Then
      Begin
        strSQLCampos := strSQLCampos + '  ENT_ICMENT = IF(IFNULL(ENT_VICMDE, 0) > 0 AND ENT_N12CST = "40", ';
        strSQLCampos := strSQLCampos + '   ROUND(( (ENT_VICMDE + IF(ENT_VICMDE > 0, IFNULL(ENT_VALFCP, 0), 0)) / ENT_TOTITE) * 100, 2), ';
        strSQLCampos := strSQLCampos + '   IF(ROUND(ENT_TOTITE - ENT_DESESP + ENT_DESACE + ENT_VALFRE, 2) = ROUND(ENT_BASICM, 2), ';
        strSQLCampos := strSQLCampos + '   ENT_ALQICM + IF(ENT_ALQICM > 0, IFNULL(ENT_PERFCP, 0), 0), ROUND(( (ENT_VALICM + IF(ENT_VALICM > 0, IFNULL(ENT_VALFCP, 0), 0)) / (ENT_TOTITE - ENT_DESESP + ENT_DESACE + IFNULL(ENT_VALFRE,0))) * 100, 1))) ';
      End Else
      Begin
        strSQLCampos := strSQLCampos + '  ENT_ICMENT = IF ( ENT_RICMPR = "S", ';
        strSQLCampos := strSQLCampos + '  ROUND(( (ENT_VALICM + IF(ENT_VALICM > 0, IFNULL(ENT_VALFCP, 0), 0)) / (ENT_TOTITE - ENT_DESESP)) * 100, 2) , ';
        strSQLCampos := strSQLCampos + '  IF(ROUND((ENT_TOTITE - ENT_DESESP + ENT_DESACE) + ENT_VALFRE, 2) = ROUND(ENT_BASICM, 2), ';
        If (strAtuNMD = 'D') And blnEncargosNoFrete Then
          strSQLCampos := strSQLCampos + '  ENT_ALQICM + IF(ENT_ALQICM > 0, IFNULL(ENT_PERFCP, 0), 0), ROUND(( (ENT_VALICM + IF(ENT_VALICM > 0, IFNULL(ENT_VALFCP, 0), 0)) / (ENT_TOTITE - ENT_DESESP)) * 100, '+strRoundICM+')))'
        Else
          strSQLCampos := strSQLCampos + '  ENT_ALQICM + IF(ENT_ALQICM > 0, IFNULL(ENT_PERFCP, 0), 0), ROUND(( (ENT_VALICM + IF(ENT_VALICM > 0, IFNULL(ENT_VALFCP, 0), 0)) / (ENT_TOTITE - ENT_DESESP + ENT_DESACE + IFNULL(ENT_VALFRE,0))) * 100, '+strRoundICM+')))';
      End;
    End;

    If blnNotaImportacao Then
    Begin
      If fCfgSis('HRIPNI') = 'S' Then
      Begin
        If Not fEmptyStr(strSQLCampos) Then
          strSQLCampos := strSQLCampos + ', ';

        ConjCalculoIpiNotImp := fGetCfgCamposbaseCalculoIPINotaImportacao;
        strSQLCampos := strSQLCampos + ' ENT_IPIENT = ROUND(((IFNULL(ENT_VAEIPI, 0) + IFNULL(ENT_VALIPI, 0)) / (ENT_TOTITE ';
        If cipiNotaImpSubDesc in  ConjCalculoIpiNotImp then
           strSQLCampos := strSQLCampos + ' - IFNULL(ENT_DESESP, 0) ';
        If cipiNotaImpDespesasAcessorias in  ConjCalculoIpiNotImp then
          strSQLCampos := strSQLCampos + ' + IFNULL(ENT_DESACE, 0) ';
        If cipiNotaImpSomarII in  ConjCalculoIpiNotImp then
          strSQLCampos := strSQLCampos + ' + IFNULL(ENT_VALVII, 0) ';
        strSQLCampos := strSQLCampos + ') * 100) , ' +  IntToStr(intDecUni) + ') ';
      End;
    End;

    strSql := strSql + strSQLCampos;

    With qryUpd, SQL Do
    Begin
      Clear;
      Add(strSql);
      ExecSQL;
    End;

    FreeAndNil(qryUpd);
  End;
end;

Function fTemMargemNegativa(recPrecos: TarrPrecos): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;

  For intContador := 1 To Length(VS_strTabPrc) Do
    If (VS_strTabPrc[intContador] = 'S') And (recPrecos[intContador].fltMarBru < 0) Then
    Begin
      Result := True;
      Exit;
    End;
End;

function fVerificaItensAbaixoPrecoMedio(blnNotaImp: Boolean;
                                        qryEntMer: TUniQuery;
                                        strCodFor,
                                        strCodEmp,
                                        strEspDoc,
                                        strNaoAtu: String;
                                        dtaDtaEnt: TDateTime;
                                        Var blnErro: Boolean;
                                        blnPrecoPraticado,
                                        blnConEqu: Boolean;
                                        objAtuFor: TAlteraFornecedorEntrada;
                                        fltCotDol: Double;
                                        blnEncargosNoFrete: Boolean): TUniClientDataSet;
  Var
    qryCadIte: TUniQuery;
    blnOutDesEntraNoprecoCompra: Boolean;

    strTipFor: String;

    intDecUni,
    intTabPre,
    intDecTem: Integer;

    blnAtpVmb: TarrAtpVmb;

    cdsMarNeg: TZClient;

    blnMarNeg: Boolean;

    fltPreCom,
    fltPreCus,

    fltAlqRet,
    fltTotAlqPis,
    fltTotAlqCof,
    fltAlqPisCofPreUlt,

    fltSaldosPreMed,
    fltImpUlt,
    fltPreUltImp,
    fltTotUlt,
    fltPreUlt,
    fltOscila,
    fltOscMed,
    fltQtdIte,
    fltIcmMed,
    fltPrecomOri,
    fltPreMed: Double;
    fltUniImp: Double;

    strMedEmp: String;
    strEmpMeds: String;

    strCnvEmb,
    strAtuNMD,
    strBasMed,
    strForFil,
    strSimPau: String;

    blnMedSe2,
    blnAtpRen,
    blnAtpRau,
    blnAltPre,
    blnDedIcm,
    blnUltPis,
    blnDevolu,
    blnAtuMed,
    blnAtuUlt,
    blnContribuinteIPI,
    blnUsaLotePrecos,
    blnAchouDevolucao: Boolean;

    fltValorFreteCalc,
    fltValorFreConCalc: Double;

    recPrecos: TarrPrecos;

    cpcParams: TParCalculaPrecoCusto;

    CalcResult: TResultPisCofins;

    strClaFisBonificacao: String;
    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;

    function fItem(strCampo: String): TField;
    begin
      Result := qryCadIte.FieldByName('ITE_' + strCampo);
    end;

    procedure pCriaCampo(strNome: String; fdtTipo: TFieldType; intTamanho: Integer);
    begin
      With Result.FieldDefs.AddFieldDef Do
      Begin
        Name     := strNome;
        DataType := fdtTipo;
        If intTamanho > 0 Then
          Size   := intTamanho;
      End;
    end;

    Procedure pIncluiMargemNegativa;
      Var
        intContador: Integer;
    Begin

      With qryEntMer Do
      If fTemMargemNegativa(recPrecos) Then
      Begin
        cdsMarNeg.Append;

        cdsMarNeg.FieldByName('ITE_CODITE').AsString := FieldByName('ENT_CODITE').AsString;
        cdsMarNeg.FieldByName('ITE_DESITE').AsString := FieldByName('ENT_DESITE').AsString;
        cdsMarNeg.FieldByName('ITE_CODUNI').AsString := FieldByName('ENT_CODUNI').AsString;
        cdsMarNeg.FieldByName('ITE_PRECUS').AsFloat  := fltPreCus;

        For intContador := 1 To 7 Do
        Begin
          cdsMarNeg.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat := recPrecos[intContador].fltPreVen;
          cdsMarNeg.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat := recPrecos[intContador].fltMarBru;
        End;

        cdsMarNeg.Post;
      End;

   End;

    function fEnt_FreRpaE: Double;
    begin
      if Assigned(qryEntMer.FindField('ENT_FRERPA')) then
        Result := qryEntMer.FieldByName('ENT_FRERPA').AsFloat
      else
        Result := 0;
    end;

begin
  strTipFor := fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);

  For intTabPre := 1 to 7 Do
    blnAtpVmb[intTabPre] := (fCfgSis( IIF( intTabPre = 1, 'ATPVMB', 'ATPVM' + IntToStr(intTabPre) )) = 'P');

  blnErro := False;

  blnDevolu := False;
  blnAchouDevolucao := False;

  cpcParams  := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);

  strForFil := fRetForFilialTodos;

  If (Pos(strCodFor, strForFil) > 0) Then
    blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
  Else
    blnUltPis := fCfgSis('ULTPIS', VarBoolean);


  If (Pos(strCodFor, strForFil) > 0) Then
    blnDedICM := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
  Else
    blnDedICM := fCfgSis('DEDICM', VarBoolean);

  strEmpMeds := fEmpresasMedEmp;

  strMedEmp := fCfgSis('MEDEMP', varString);

  blnMarNeg := fCfgSis('MARNEG', varBoolean);
  blnUsaLotePrecos := (fCfgSis('LOTPRE', varBoolean));
  strAtuNMD := fCfgSis('ATUNMD');
  blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
  blnAtpRen := fCfgSis('ATPREN', varBoolean);
  blnAtpRau := fCfgSis('ATPRAU', varBoolean);
  fltOscMed := fCfgSis('OSCMED', varDouble);
  blnAtuMed := fCfgSis('ATUMED', varBoolean);
  blnAtuUlt := fCfgSis('ATUULT', varBoolean);
  strCnvEmb := fCfgSis('CNVEMB');
  strBasMed := fCfgSis('BASMED');
  intDecTem := fCfgSis('DEQTEM', VarInteger);
  intDecUni := fCfgSis('DECUNI', VarInteger);

  blnContribuinteIPI := (fCfgSis('CONIPI', varBoolean));
  strSimPau := IIf((fCfgSis('SIMPAU',varString) = 'S') and (fCfgSis('IGNSIM') = '1'), 'S', 'N') ;

  Result := TUniClientDataSet.Create(Nil);

  pCriaCampo('CODITE', ftString, fTamCodIte);
  pCriaCampo('DESITE', ftString, 80);
  pCriaCampo('SIGUNI', ftString, 06);
  pCriaCampo('CLAFIS', ftString, 05);
  pCriaCampo('QTDITE', ftFloat,  00);
  pCriaCampo('MEDATU', ftFloat,  00);
  pCriaCampo('MEDNOV', ftFloat,  00);
  pCriaCampo('OSCILA', ftFloat,  00);
  pCriaCampo('AUTINC', ftString, 20);

  Result.CreateDataSet;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;

  TFloatField(Result.FieldByName('QTDITE')).DisplayFormat := '#,####0.0000';
  TFloatField(Result.FieldByName('MEDATU')).DisplayFormat := '#,####0.0000';
  TFloatField(Result.FieldByName('MEDNOV')).DisplayFormat := '#,####0.0000';
  TFloatField(Result.FieldByName('OSCILA')).DisplayFormat := '#,####0.0000';

  qryCadIte := fCriaQuery;
  pCarregaItens(VS_strCodEmp, qryCadIte, fltCotDol);

  If  blnMarNeg And (Not blnUsaLotePrecos) Then
    cdsMarNeg := TProdMargemNegativa.fCriaDadosItem('');

  strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;

  With qryEntMer Do
  Begin
    First;

    While (Not Eof) Do
    Begin

      If (Pos(FieldByName('ENT_CLAFIS').AsString, '1922_2922_') <= 0) And
         {(Not blnDevolu) And }
         (fEmptyStr(FieldByName('ENT_CODACA').AsString)) And
         (((Pos(FieldByName('ENT_CLAFIS').AsString, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
        ((blnAtuMed Or blnAtuUlt) And (Pos(strCodFor, strForFil) > 0))) Then
      Begin

        qryCadIte.Locate('ITE_CODITE', FieldByName('ENT_CODITE').AsString, []);

        If (fEmptyStr(FieldByName('ENT_CODACA').AsString)) and
           ((FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat) > 0) And
           (RoundTo(qryCadIte.FieldByName('ITE_PREMED').AsFloat, -2) > 0) Then
        Begin
          fltQtdIte := FieldByName('ENT_QTDITE').AsFloat;

          If (strCnvEmb <> 'N') {and (not blnDevolu)} Then
            fltQtdIte := RoundTo(fltQtdIte * FieldByName('ENT_EMBALA').AsFloat, - intDecTem);

          fltUniImp := (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat);

          If fltQtdIte > 0 Then
            fltUniImp := (fltUniImp / fltQtdIte)
          Else
            fltUniImp := 0.0;

          fltUniImp := fFormataFloat(fltUniImp, 4);

          If (Pos(strCodFor, strForFil) <= 0) OR ((Pos(strCodFor, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
            fltIcmMed := IIF((fFormataFloat(FieldByName('ENT_TOTITE').AsFloat, 2) <> fFormataFloat(FieldByName('ENT_BASICM').AsFloat, 2)),
                                              fFormataFloat((FieldByName('ENT_VALICM').AsFloat / (FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat)) * 100, 2),
                                              FieldByName('ENT_ALQICM').AsFloat + IIf(FieldByName('ENT_ALQICM').AsFloat > 0, FieldByName('ENT_PERFCP').AsFloat, 0))
          Else
            fltIcmMed := 0;

          If strMedEmp = '1' Then
            fltSaldosPreMed := fSaldoEmpresas(FieldByName('ENT_CODITE').AsString, strEmpMeds)
          Else
            fltSaldosPreMed := fItem('SALDOS').AsFloat;

          Try
            CalculoPrecoMediAgrup.strCodIteAtual := FieldByName('ENT_CODITE').AsString;

            If (strBasMed <> 'S') Then
              fltPreMed := fCalculaPrecoMedio( FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                             FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                             fItem('PREMED').AsFloat,                     // Preço medio anterior
                                             fltSaldosPreMed,                             // Saldo anterior
                                             fltQtdIte,                                   // Quantidade de entrada
                                             fltUniImp,                                   // Unitario sem impostos
                                             fltIcmMed,                                  // Aliquota de ICMS do Item
                                             FieldByName('ENT_VALIPI').AsFloat +
                                             FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                             FieldByName('ENT_VALRET').AsFloat +
                                             FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                             FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                             FieldByName('ENT_VALGNR').AsFloat,
                                             FieldByName('ENT_VLTCIF').AsFloat,
                                             FieldByName('ENT_VAL_TS').AsFloat,

                                             blnContribuinteIPI,                          // Contribuinte de IPI?
                                             (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                             FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                             FieldByName('ENT_VALFRE').AsFloat +          // VALOR DO FRETE
                                             FieldByName('ENT_FRECON').AsFloat +
                                             fEnt_FreRpaE ,
                                             FieldByName('ENT_OUTDES').AsFloat +
                                             FieldByName('ENT_VENDOR').AsFloat +
                                             FieldByName('ENT_DESACE').AsFloat,

                                             FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat,

                                             IIF((FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                 0,
                                                 FieldByName('ENT_ICMXML').AsFloat + FieldByName('ENT_FCPXML').AsFloat),

                                             FieldByName('ENT_VFCPST').AsFloat,
                                             FieldByName('ENT_ICMCFR').AsFloat,
                                             CalculoPrecoMediAgrup,
                                             FieldByName('ENT_VAEIPI').AsFloat > 0)
              Else
                fltPreMed := fCalculaPrecoMedio( FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                               FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                               fItem('PRECOM').AsFloat,                     // Preço compra anterior
                                               fltSaldosPreMed,                             // Saldo anterior
                                               fltQtdIte,                                   // Quantidade de entrada
                                               fltUniImp,                                   // Unitario sem impostos
                                               fltIcmMed,                                   // Aliquota de ICMS do Item
                                               FieldByName('ENT_VALIPI').AsFloat +
                                               FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                               FieldByName('ENT_VALRET').AsFloat +
                                               FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                               FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                               FieldByName('ENT_VALGNR').AsFloat,
                                               FieldByName('ENT_VLTCIF').AsFloat,
                                               FieldByName('ENT_VAL_TS').AsFloat,

                                               blnContribuinteIPI,                          // Contribuinte de IPI?
                                               (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                               FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                               FieldByName('ENT_VALFRE').AsFloat +
                                               FieldByName('ENT_FRECON').AsFloat +
                                               fEnt_FreRpaE,
                                               FieldByName('ENT_OUTDES').AsFloat +
                                               FieldByName('ENT_VENDOR').AsFloat +
                                               FieldByName('ENT_DESACE').AsFloat,

                                               FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat,

                                               IIF((FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                   0,
                                                   FieldByName('ENT_ICMXML').AsFloat + FieldByName('ENT_FCPXML').AsFloat),

                                               FieldByName('ENT_VFCPST').AsFloat,
                                               FieldByName('ENT_ICMCFR').AsFloat,
                                               CalculoPrecoMediAgrup,
                                               FieldByName('ENT_VAEIPI').AsFloat > 0);          // VALOR DO FRETE

          Except

            On E: Exception Do
            Begin
               blnErro := True;

               If Pos('preço médio', E.Message) > 0 Then
                 Raise Exception.Create('Item ' + FieldByName('ENT_CODITE').AsString + ': ' + E.Message)

               Else Raise;
            End;

          End;

          fltOscila := RoundTo(((fltPreMed / qryCadIte.FieldByName('ITE_PREMED').AsFloat) - 1) * 100 , -4);

          If Abs(RoundTo(fltOscila, -4)) > Abs(RoundTo(fltOscMed, -4)) Then
          Begin
            {*****************************************}
            {* CASO O ITEM PERMITA REDUÇÃO DE PREÇO, *}
            {* SERA INCLUIDO PARA MOSTRAR NO VIDEO   *}
            {**************************************LA*}
            If (qryEntMer.FieldByName('ENT_RPRENT').AsString = 'S') Then
            Begin

              Result.Append;
              Result.FieldByName('CODITE').AsString := FieldByName('ENT_CODITE').AsString;
              Result.FieldByName('DESITE').AsString := FieldByName('ENT_DESITE').AsString;
              Result.FieldByName('SIGUNI').AsString := fRetSiglaUni(FieldByName('ENT_CODUNI').AsString);
              Result.FieldByName('CLAFIS').AsString := FieldByName('ENT_CLAFIS').AsString;
              Result.FieldByName('MEDATU').AsFloat  := qryCadIte.FieldByName('ITE_PREMED').AsFloat;
              Result.FieldByName('QTDITE').AsFloat  := fltQtdIte;
              Result.FieldByName('MEDNOV').AsFloat  := fltPreMed;
              Result.FieldByName('OSCILA').AsFloat  := fltOscila;
              Result.FieldByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
              Result.Post;
            End;

          End;

          If blnMarNeg And (Not blnUsaLotePrecos) Then
          Begin
            fltTotUlt := ( FieldByName('ENT_TOTITE').AsFloat - FieldByName('ENT_DESESP').AsFloat );
            fltPreUlt := fltTotUlt / FieldByName('ENT_QTDITE').AsFloat;
            fltPreUlt := fFormataFloat(fltPreUlt, 4);

            pCalculaPreUltImp(blnNotaImp,
                              qryEntMer,
                              strCodEmp,
                              strCodFor,
                              strEspDoc,
                              strSimPau,
                              strTipFor,
                              dtaDtaEnt,
                              blnDevolu,
                              blnConEqu,
                              blnUltPis,
                              blnDedIcm,
                              blnPrecoPraticado,
                              blnAchouDevolucao,
                              (Pos(strCodFor, strForFil) > 0),
                              CalcResult,
                              fltPreUltImp,
                              fltImpUlt,
                              fltAlqRet,
                              fltTotAlqPis,
                              fltTotAlqCof,
                              fltAlqPisCofPreUlt,
                              fltValorFreteCalc,
                              fltValorFreConCalc);

            pRecalculaPrecosEntrada(qryEntMer,
                                    qryCadIte,
                                    fltPreMed,
                                    fltPreUlt,
                                    fltPreUltImp,
                                    fltPreCom,
                                    fltPreCus,
                                    fltPrecomOri,
                                    recPrecos,
                                    blnAltPre,
                                    cpcParams,
                                    blnOutDesEntraNoprecoCompra,
                                    strCodFor,
                                    strForFil,
                                    strEspDoc,
                                    strAtuNMD,
                                    strNaoAtu,
                                    strCnvEmb,
                                    strTipFor,
                                    blnAtpRau,
                                    blnAtpRen,
                                    blnMedSe2,
                                    objAtuFor,
                                    blnAtpVmb,
                                    intDecUni,
                                    blnEncargosNoFrete);

             If blnAltPre And
                fAtualizaItem(strTipFor, blnAtpRau, FieldByName('ENT_CODITE').AsString, objAtuFor) And
                ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) Then
              pIncluiMargemNegativa;

          End;

        End;

      End;

      qryEntMer.Next;
    End;

  End;

  FreeAndNil(qryCadIte);
  FreeAndNil(CalculoPrecoMediAgrup);

  If blnMarNeg And (Not blnUsaLotePrecos) Then
  Begin

    If (Not blnErro) And (Not cdsMarNeg.IsEmpty) Then
      blnErro := Not TProdMargemNegativa.fLiberaMargemNegativa(cdsMarNeg, cdsMarNeg, rotEntradaMercadorias);

    FreeAndNil(cdsMarNeg);
  End;
end;

Function fLiberaPrecoMedio(cdsItens: TDataSet; strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String): Boolean;
var
	objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
  objLiberacao : TLiberacao;
Begin
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('OSCILAÇÃO DE PREÇO MÉDIO DO PRODUTO');
    objLiberacao.objMsgLibera.pAddSeparador(129);
    objLiberacao.objMsgLibera.pAddTexto('Durante a entrada do documento: ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp + ' Série: ' + strSerie + ' Fornecedor: ' + strCodFor + '-' + fRetNomFornecedor(strCodFor) + ', ');
    objLiberacao.objMsgLibera.pAddTexto('o sistema calculou grande oscilaçao do preço médio, comparando preço anterior e o preço após entrada de mercadorias.');
    objLiberacao.objMsgLibera.pAddTexto('Caso esteja correto, será necessária liberação de operadores autorizados.');

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'CÓD.'         , 5  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'PRODUTO'      , 44 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'UN'           , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CFOP'         , 5  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'QTD.ENTRADA'  , 11 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'PR.MÉDIO ANT.', 14 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'NOVO PR.MÉDIO', 14 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'OSCILAÇÃO'    , 9  , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    With cdsItens Do
    Begin
      First;

      While Not Eof Do
      Begin
        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('CÓD.'         , FieldByName('CODITE').AsString                                , fTamCodIte , alEsquerda );
        objLinha.pAddColuna('PRODUTO'      , FieldByName('DESITE').AsString                                , 44 , alEsquerda );
        objLinha.pAddColuna('UN'           , FieldByName('SIGUNI').AsString                                , 4  , alCentro   );
        objLinha.pAddColuna('CFOP'         , FieldByName('CLAFIS').AsString                                , 5  , alCentro   );
        objLinha.pAddColuna('QTD.ENTRADA'  , FormatFloat('#,##0.000',  FieldByName('QTDITE').AsFloat)      , 11 , alDireita  );
        objLinha.pAddColuna('PR.MÉDIO ANT.', FormatFloat('#,##0.0000', FieldByName('MEDATU').AsFloat)      , 14 , alDireita  );
        objLinha.pAddColuna('NOVO PR.MÉDIO', FormatFloat('#,##0.0000', FieldByName('MEDNOV').AsFloat)      , 14 , alDireita  );
        objLinha.pAddColuna('OSCILAÇÃO'    , FormatFloat('#,##0.00',   FieldByName('OSCILA').AsFloat)+ '%' , 9  , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        Next;
      End;
    End;

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'LIBPREMED';
    objLiberacao.strMsgSen := 'OSCILAÇÃO DE PREÇO MÉDIO DO PRODUTO';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  finally
    FreeAndNil(objLiberacao);
  end;
End;

function fPedidoBaixado(strNumPed, strCodEmp, strEspDoc: String): Boolean;
Var
  strSQL: String;
  qryPed: TUniQuery;
begin

  Try

    qryPed := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  COUNT(*) AS QTDBAI ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  PCMDET ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  PCD_NUMPED = :NUMPED AND ';
    strSQL := strSQL + '  PCD_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  PCD_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  PCD_QTDBAI > 0           ';

    With qryPed Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMPED').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := (FieldByName('QTDBAI').AsInteger > 0);
    End;

  Finally
    FreeAndNil(qryPed);
  End;

end;

function fGerarPedidosReservaEstoque(strDocEnt, strEspEnt, strSerEnt, strForEnt, strCodEmp: String;
  qryEntMer, qryConIte: TDataSet; blnDevolu: Boolean; blnRecCliGarantia: Boolean;
  blnConEqu: Boolean; blnAcessadoViaRetornoConsignacao: Boolean; objCadLot: TCadLot; ArrMarcaProAcaEndere: TArrMarcaProAcaEndere; prgProgresso: TProgressBar = Nil): Boolean;
  Var
    endItem: TEndItem;
    endDocumento: TEndDocumento;
    objEnderecamento: TEnderecamentoProduto;
    blnTemItem,
    blnCadLoc: Boolean;
    blnMarMor, blnEntEnd: Boolean;
    strIteSer, strSerTer, strProMat: String;

  function fItemAcabado(AAutInc: string): Boolean;
   var i: integer;
  begin
    Result := False;
    For i := 0 To High(ArrMarcaProAcaEndere) do
     If ArrMarcaProAcaEndere[i] = AAutInc then
       Exit(True);
  End;

  procedure pDeletaPedidoReservaAntigo;
  var
    qryGenGer, qryGenDel : TUniQuery;
  Begin
    try
      qryGenGer := fCriaQuery(Nil);
      qryGenDel := fCriaQuery(Nil);

      qryGenGer.SQL.Clear;
      qryGenGer.SQL.Add('SELECT FGO_SEQFGO ');
      qryGenGer.SQL.Add('  FROM DEL_EXTGOR ');
      qryGenGer.SQL.Add(' WHERE FGO_DOCEND  = :NUMDOC ');

      qryGenGer.ParamByName('NUMDOC').AsString :=  objEnderecamento.strDocumento;
      qryGenGer.Close;
      qryGenGer.Open;

      If (Not qryGenGer.IsEmpty) Then
      Begin

        qryGenGer.First;
        While Not qryGenGer.Eof Do
        Begin
           qryGenDel.SQL.Clear;
           qryGenDel.SQL.Add('DELETE FROM DEL_FATGOR WHERE AUTOINCREM = :AUTINC ');
           qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
           qryGenDel.ExecSQL;

           qryGenDel.SQL.Clear;
           qryGenDel.SQL.Add('DELETE FROM DEL_AUXGOR WHERE AUX_SEQGER = :AUTINC ');
           qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
           qryGenDel.ExecSQL;

           qryGenDel.SQL.Clear;
           qryGenDel.SQL.Add('DELETE FROM DEL_EXTGOR WHERE FGO_SEQFGO = :AUTINC ');
           qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
           qryGenDel.ExecSQL;

           qryGenDel.SQL.Clear;
           qryGenDel.SQL.Add('DELETE FROM DEL_FATDOR WHERE FDO_SEQGER = :AUTINC ');
           qryGenDel.ParamByName('AUTINC').AsString :=  qryGenGer.FieldByName('FGO_SEQFGO').AsString;
           qryGenDel.ExecSQL;

           qryGenGer.Next;
        End;

      End;

    finally
      FreeAndNil(qryGenGer);
      FreeAndNil(qryGenDel);
    End;
  End;

begin
  Try
    objEnderecamento := TEnderecamentoProduto.Create;
    objEnderecamento.pLimpar;

    endDocumento.strNumDoc := strDocEnt;
    endDocumento.strEspDoc := strEspEnt;
    endDocumento.strSerie_ := strSerEnt;
    endDocumento.strCodEmp := VS_strCodEmp;
    endDocumento.strCliFor := strForEnt;
    endDocumento.strTip_FC := IIF(blnDevolu Or blnRecCliGarantia Or blnConEqu or blnAcessadoViaRetornoConsignacao, 'C', 'F');

    objEnderecamento.endDocumento := endDocumento;

    qryEntMer.First;

    blnTemItem := False;

    If Assigned(prgProgresso) Then
    Begin
      prgProgresso.Position := 0;
      prgProgresso.Max := qryEntMer.RecordCount;
    End;

    blnEntEnd := fCfgSis('ENTEND', varBoolean);
    blnMarMor := fCfgSis('MARMOR', varBoolean);
    strIteSer := fCfgSis('ITESER', VarString);
    strSerTer := fCfgSis('SERTER', VarString);
    strProMat := fCfgSis('PROMAT', VarString);
    blnCadLoc := fCfgSis('CADLOC', varBoolean);

    While Not qryEntMer.Eof Do
    Begin

      {Item serviço}
      If (Sametext(qryEntMer.FieldByName('ENT_CODITE').AsString, strIteSer) Or
          Sametext(qryEntMer.FieldByName('ENT_CODITE').AsString, strSerTer) Or
          Sametext(qryEntMer.FieldByName('ENT_CODITE').AsString, strProMat)) Then
      Begin
        qryEntMer.Next;
        Continue;
      End;

      If fItemAcabado(qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString) and (Not blnCadLoc) Then
      Begin
        qryEntMer.Next;
        Continue;
      End;

      If (Not fIsItemEspecial(qryEntMer.FieldByName('ENT_CODITE').AsString)) And (blnEntEnd And (fCampoTabela('ITE_REAEND', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByName('ENT_CODITE').AsString]) <> 'N')) Or
         (blnMarMor And (fItemMarmore(qryEntMer.FieldByName('ENT_CODITE').AsString))) Then
      Begin
        qryConIte.Locate('ITE_CODITE', qryEntMer.FieldByName('ENT_CODITE').AsString, []);

        endItem.strCodIte := qryEntMer.FieldByName('ENT_CODITE').AsString;
        endItem.strCodMar := qryConIte.FieldByName('ITE_CODMAR').AsString;
        endItem.strDesIte := qryEntMer.FieldByName('ENT_DESITE').AsString;
        endItem.strRefere := qryEntMer.FieldByName('ENT_REFERE').AsString;
        endItem.strCodUni := qryEntMer.FieldByName('ENT_CODUNI').AsString;
        endItem.strCodFor := qryConIte.FieldByName('ITE_CODFOR').AsString;
        endItem.fltQtdIte := qryEntMer.FieldByName('ENT_QTDITE').AsFloat - qryEntMer.FieldByName('ENT_QTDREF').AsFloat;
        endItem.strCodAmz := fRetNumLot(qryEntMer, strCodEmp, objCadLot);
        endItem.strAutDet := qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;

        endItem.strEmpAca := '';
        endItem.strCodAca := '';
        endItem.blnIteAca := fItemAcabado(qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString);
        If endItem.blnIteAca Then
        Begin
          endItem.strEmpAca := qryEntMer.FieldByName('ENT_EMPACA').AsString;
          endItem.strCodAca := qryEntMer.FieldByName('ENT_CODACA').AsString;
        End;

        endItem.blnRefugo := False;

        objEnderecamento.pAddItem(endItem);

        blnTemItem  := True;
      End;

      qryEntMer.Next;

      If Assigned(prgProgresso) Then
      Begin
        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

    If Assigned(prgProgresso) Then
    Begin
      prgProgresso.Position := 0;
      prgProgresso.Max := qryEntMer.RecordCount;
    End;

    //Adiciona Itens de Refugo Caso Tenha.
    qryEntMer.First;

    While Not qryEntMer.Eof Do
    Begin

      If blnEntEnd And ((fCampoTabela('ITE_REAEND', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByName('ENT_CODITE').AsString]) <> 'N') And
         (qryEntMer.FieldByName('ENT_QTDREF').AsFloat > 0)) Then
      Begin
        qryConIte.Locate('ITE_CODITE', qryEntMer.FieldByName('ENT_CODITE').AsString, []);
        endItem.strCodIte := qryEntMer.FieldByName('ENT_CODITE').AsString;
        endItem.strCodMar := qryConIte.FieldByName('ITE_CODMAR').AsString;
        endItem.strDesIte := qryEntMer.FieldByName('ENT_DESITE').AsString;
        endItem.strRefere := qryEntMer.FieldByName('ENT_REFERE').AsString;
        endItem.strCodUni := qryEntMer.FieldByName('ENT_CODUNI').AsString;
        endItem.strCodFor := qryConIte.FieldByName('ITE_CODFOR').AsString;
        endItem.fltQtdIte := qryEntMer.FieldByName('ENT_QTDREF').AsFloat;
        endItem.strCodAmz := fRetNumLot(qryEntMer, strCodEmp, objCadLot);

        endItem.strAutDet := qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString;
        endItem.strEmpAca := '';
        endItem.strCodAca := '';
        endItem.blnIteAca := fItemAcabado(qryEntMer.FieldByName('AUTOINCREMENTO_GRAVACAO').AsString);
        If endItem.blnIteAca Then
        Begin
          endItem.strEmpAca := qryEntMer.FieldByName('ENT_EMPACA').AsString;
          endItem.strCodAca := qryEntMer.FieldByName('ENT_CODACA').AsString;
        End;


        endItem.blnRefugo := True;

        objEnderecamento.pAddItem(endItem);

        blnTemItem  := True;
      End;

      qryEntMer.Next;

      If Assigned(prgProgresso) Then
      Begin
        prgProgresso.Position := prgProgresso.Position + 1;
        Application.ProcessMessages;
      End;
    End;

    If blnTemItem Then
    Begin
      pDeletaPedidoReservaAntigo;
      Result := objEnderecamento.fGerarPedidoParaReservarEstoque(prgProgresso)
    End
    Else
      Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  If Assigned(objEnderecamento) Then
    FreeAndNil(objEnderecamento);
end;

function fAtualizaTabelaAux(strCodIte,strSeqDet:String; blnEntradaDeMercadorias : Boolean = True): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'UPDATE                       ';
  strSQL := strSQL + '  MOVGAU                     ';
  strSQL := strSQL + 'SET                          ';
  strSQL := strSQL + '  GAU_SEQDET = :SEQDET       ';
  strSQL := strSQL + 'WHERE                        ';
  strSQL := strSQL + '  GAU_CODITE = :CODITE AND   ';

  if blnEntradaDeMercadorias Then
    strSQL := strSQL + '      IFNULL(GAU_SEQDET,"") = "" AND '
  Else
    strSQL := strSQL + '      IFNULL(GAU_SEQDET,"") = "REFUGO_N" AND ';

  strSQL := strSQL + '  IFNULL(GAU_SEQDET,"") = "" ';


  With qryTmp Do
  Begin

    Try

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQDET').AsString := strSeqDet;
      ParamByName('CODITE').AsString := strCodIte;
      ExecSQL;

      Result := True;
    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'fAtualizaTabelaAux');
        //Raise Exception.Create('Erro ao atualizar tabela auxiliar! ' + E.Message + ' - [fAtualizaTabelaAux]');
      End

    End;

  End;

  FreeAndNil(qryTmp);
end;

Function fEhRecClienteGarantia(blnRecCliGarantia: Boolean; cdsMovGad: TUniClientDataSet): Boolean;
Begin
  Result := blnRecCliGarantia And
            (cdsMovGad <> Nil);
End;

procedure pRetornaDadosCliente(strCodFor: String; Var strNomCli, strEmaCli: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  CLI_NOMCLI, ');
  qryAux.SQL.Add('  CLI_EMAIL3 ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADCLI ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  CLI_CODCLI = :CODCLI ');

  qryAux.ParamByName('CODCLI').AsString := strCodFor;
  qryAux.Open;

  strNomCli := qryAux.FieldByName('CLI_NOMCLI').AsString;
  strEmaCli := qryAux.FieldByName('CLI_EMAIL3').AsString;

  FreeAndNil(qryAux);
end;

Procedure pZeraFilkar(strAutMovDet: String);
  Var
    qryMovDet: TUniQuery;
Begin
  qryMovDet := fCriaQuery;
  qryMovDet.SQL.Text := 'UPDATE MOVDET SET DET_FILKAR = 0 WHERE AUTOINCREM = ' + QuotedStr(strAutMovDet);
  qryMovDet.ExecSQL;

  FreeAndNil(qryMovDet);
End;

Function fBaixaProdutoAcabadoDecomposto(strAutMovDet: String; const strCodAca, strEmpAca, strTipFat, strNumFat,
  strEmpFat, strCodOco, strEmpOrigem, strCndPag, strCodOpe,
  strNumDoc, strEspDoc, strCodEmp, strCodCli, strSeqGerDev, strSerie: string;
  fltQtdDev, fltQtdOri, fltVlrCon, fltTotIte: Double;
  dtaDtaEnt: TDateTime; blnDevolucao: Boolean;
  var strAutIncMovGer: String; strTip_FC: string = 'C'): Boolean;
var
  qryGenDet: TZClient;
  qryMovDet: TZClient;
 // qryGenGer: TUniQuery;
  strCliEst,
  strNumDocMovGer: string;
  recServicos: TDadosServicos;
  strAutIncMovDet: string;
  arrDuplic : TarrDuplicata;
begin
  Result := True;

  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  If strTip_FC = 'C' Then
    strCliEst := fRetEstadoCliente(strCodCli)
  Else
    strCliEst := fRetEstadoFornecedor(strCodCli);

  qryGenDet := nil;
  qryMovDet := nil;
  Try
    Try

      qryGenDet := TZClient.Create(Nil,
        ' SELECT                                    ' +
        '   D.*,                                    ' +
        '   T.*,                                    ' +
        ' DET_QTDITE * :PROP_DEV AS DET_QTDITE_DEV, ' +
        ' DET_TOTITE * :PROP_DEV AS DET_TOTITE_DEV, ' +
        ' DET_VLRCON * :PROP_DEV AS DET_VLRCON_DEV, ' +
        ' DET_TOTCUS * :PROP_DEV AS DET_TOTCUS_DEV, ' +
        ' DET_TOTCU2 * :PROP_DEV AS DET_TOTCU2_DEV, ' +
        ' DET_TOTMED * :PROP_DEV AS DET_TOTMED_DEV, ' +
        ' DET_DESCON * :PROP_DEV AS DET_DESCON_DEV, ' +
        ' DET_TOTFRE * :PROP_DEV AS DET_TOTFRE_DEV, ' +
        ' DET_DESESP * :PROP_DEV AS DET_DESESP_DEV, ' +
        ' T.DET_VAEIPI * :PROP_DEV AS DET_VAEIPI_DEV, ' +
        ' T.DET_BAEIPI * :PROP_DEV AS DET_BAEIPI_DEV, ' +
        ' DET_VALIPI * :PROP_DEV AS DET_VALIPI_DEV, ' +
        ' DET_BASIPI * :PROP_DEV AS DET_BASIPI_DEV, ' +
        ' DET_TOTULT * :PROP_DEV AS DET_TOTULT_DEV, ' +
        ' DET_IMPULT * :PROP_DEV AS DET_IMPULT_DEV, ' +
        ' DET_BARTSP * :PROP_DEV AS DET_BARTSP_DEV, ' +
        ' DET_VLRTSP * :PROP_DEV AS DET_VLRTSP_DEV, ' +
        ' DET_ICOPPR * :PROP_DEV AS DET_ICOPPR_DEV, ' +
        ' DET_BASPIS * :PROP_DEV AS DET_BASPIS_DEV, ' +
        ' DET_VALPIS * :PROP_DEV AS DET_VALPIS_DEV, ' +
        ' DET_BASCOF * :PROP_DEV AS DET_BASCOF_DEV, ' +
        ' DET_VALCOF * :PROP_DEV AS DET_VALCOF_DEV, ' +
        ' T.DET_VAERET * :PROP_DEV AS DET_VAERET_DEV, ' +
        ' T.DET_BAERET * :PROP_DEV AS DET_BAERET_DEV, ' +
        ' DET_VALRET * :PROP_DEV AS DET_VALRET_DEV, ' +
        ' DET_BASRET * :PROP_DEV AS DET_BASRET_DEV, ' +
        ' DET_VALICM * :PROP_DEV AS DET_VALICM_DEV, ' +
        ' DET_BASICM * :PROP_DEV AS DET_BASICM_DEV, ' +
        ' DET_TOTPES * :PROP_DEV AS DET_TOTPES_DEV, ' +
        ' T.DET_CONFRE * :PROP_DEV AS DET_CONFRE_DEV, ' +
        ' T.DET_BASANT * :PROP_DEV AS DET_BASANT_DEV, ' +
        ' T.DET_ICMANT * :PROP_DEV AS DET_ICMANT_DEV, ' +
        ' T.DET_VENDOR * :PROP_DEV AS DET_VENDOR_DEV, ' +
        ' T.DET_OUTDES * :PROP_DEV AS DET_OUTDES_DEV, ' +
        ' T.DET_VLGNRE * :PROP_DEV AS DET_VLGNRE_DEV, ' +
        ' DET_OUTICM * :PROP_DEV AS DET_OUTICM_DEV, ' +
        ' DET_ISEICM * :PROP_DEV AS DET_ISEICM_DEV, ' +
        ' DET_TOTCOM * :PROP_DEV AS DET_TOTCOM_DEV, ' +
        ' DET_TOTCO2 * :PROP_DEV AS DET_TOTCO2_DEV, ' +
        ' DET_FRESUG * :PROP_DEV AS DET_FRESUG_DEV, ' +
        ' DET_DESACE * :PROP_DEV AS DET_DESACE_DEV  ' +

        ' FROM                                 ' +
        '   MOVDET D                           ' +
        '   LEFT JOIN MOVTRI T                 ' +
        '     ON D.AUTOINCREM = T.DET_SEQGER   ' +
        ' WHERE DET_CODACA = :CODACA           ' +
        '   AND DET_EMPACA = :EMPACA           ' +
        '   AND DET_ESPDOC <> "PR"             ' +
        '   AND D.DET_CODEMP = :CODEMP         ' +
        '   AND D.DET_TIPFAT = :TIPFAT         ' +
        '   AND D.DET_NUMFAT = :NUMFAT         ' +
        '   AND D.DET_EMPFAT = :EMPFAT         ');

      qryGenDet.qryQuery.ParamByName('CODACA').AsString := strCodAca;
      qryGenDet.qryQuery.ParamByName('EMPACA').AsString := strEmpAca;
      qryGenDet.qryQuery.ParamByName('CODEMP').AsString := strEmpOrigem;

      qryGenDet.qryQuery.ParamByName('TIPFAT').AsString := strTipFat;
      qryGenDet.qryQuery.ParamByName('NUMFAT').AsString := strNumFat;
      qryGenDet.qryQuery.ParamByName('EMPFAT').AsString := strEmpFat;

      If fltQtdOri = 0 Then
        fltQtdOri := fltQtdDev;

      qryGenDet.qryQuery.ParamByName('PROP_DEV').AsFloat := fltQtdDev / fltQtdOri;

      qryGenDet.fLeDados('pBaixaProdutoAcabadoDecomposto');

      if qryGenDet.IsEmpty then
        Exit;

      strNumDocMovGer := fRetSequencial('PRO_ML', VS_strCodEmp, fTamDocCadRec);

      Result := fGravaMovGer(
        strAutIncMovGer,
        strNumDocMovGer,
        'ML',         // qryGenGer.FieldByName('GER_ESPDOC').AsString,
        strCodEmp,    // qryGenGer.FieldByName('GER_CODEMP').AsString,
        '',           // qryGenGer.FieldByName('GER_CODTRA').AsString,
        strCodOpe,    //  qryGenGer.FieldByName('GER_CODVEN').AsString,
        IIf(strTip_FC = 'F', strCodCli, ''),        // qryGenGer.FieldByName('GER_CODFOR').AsString,
        IIf(strTip_FC = 'C', strCodCli, ''), // qryGenGer.FieldByName('GER_CODCLI').AsString,
        strTip_FC,       // qryGenGer.FieldByName('GER_TIP_FC').AsString,
        dtaDtaEnt, //  qryGenGer.FieldByName('GER_DTAENT').AsDateTime,
        fTime(),
        VS_Date,
        strCndPag, // qryGenGer.FieldByName('GER_CONPAG').AsString,
        '', // qryGenGer.FieldByName('GER_ESTADO').AsString,
        '', // qryGenGer.FieldByName('GER_NOMCON').AsString,
        '', // qryGenGer.FieldByName('GER_ENDCON').AsString,
        '', // qryGenGer.FieldByName('GER_BAICON').AsString,
        '', // qryGenGer.FieldByName('GER_CEPCON').AsString,
        '', // qryGenGer.FieldByName('GER_CIDCON').AsString,
        '', // qryGenGer.FieldByName('GER_ESTCON').AsString,
        '', // qryGenGer.FieldByName('GER_TELCON').AsString,
        0,  //
        '', // qryGenGer.FieldByName('GER_CGCCPF').AsString,
        '', // qryGenGer.FieldByName('GER_CGCCON').AsString,
        '', // qryGenGer.FieldByName('GER_IESCON').AsString,
        '', // qryGenGer.FieldByName('GER_R_GCON').AsString,
        0,  // qryGenGer.FieldByName('GER_BASSIM').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_BASIPI'),
        0,  // qryGenGer.FieldByName('GER_ALQIPI').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_TOTIPI'),
        0,  // qryGenDet.fRetSoma('GER_BASICM'),
        0,  // qryGenGer.FieldByName('GER_ALQICM').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_TOTICM'),
        0,  // qryGenDet.fRetSoma('GER_TOTRET'),
        0,  // qryGenGer.FieldByName('GER_ALQRET').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_BASRET'),
        0,  // qryGenDet.fRetSoma('GER_RET_SP'),
        0,  // qryGenDet.fRetSoma('GER_DESESP'),
        fltVlrCon, //  qryGenDet.fRetSoma('GER_VLRCON'),
        fltTotIte, // qryGenDet.fRetSoma('GER_TOTITE'),
        0,  // qryGenDet.fRetSoma('GER_TOTCUS'),
        0,  // qryGenDet.fRetSoma('GER_TOTMED'),
        '', //qryGenGer.FieldByName('GER_TIPFRE').AsString,
        0,  // qryGenDet.fRetSoma('GER_TOTFRE'),
        0,  // qryGenDet.fRetSoma('GER_PESBRU'),
        0,  // qryGenDet.fRetSoma('GER_PESLIQ'),
        0,  // qryGenDet.fRetSoma('GER_VOLUME'),
        '', // qryGenGer.FieldByName('GER_ESPECI').AsString,
        '', // qryGenGer.FieldByName('GER_MARCA_').AsString,
        '', // qryGenGer.FieldByName('GER_MEN001').AsString,
        '', // qryGenGer.FieldByName('GER_MEN002').AsString,
        '', // qryGenGer.FieldByName('GER_MEN003').AsString,
        '', // qryGenGer.FieldByName('GER_MEN004').AsString,
        '', // qryGenGer.FieldByName('GER_MEN005').AsString,
        True,
        strEspDoc,  // strTipFat,
        strNumDoc,  // strNumFat,
        strCodEmp,  // strEmpFat,
        VS_Date,
        strLoginUsuarioLogado,
        '01000',       // qryGenGer.FieldByName('GER_CNDFAT').AsString,
        False,
        0, // qryGenGer.FieldByName('GER_VALFAT').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR01').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR02').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR03').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR04').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR05').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR06').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR07').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR08').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR09').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR10').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR11').AsFloat,
        0, // qryGenGer.FieldByName('GER_VPAR12').AsFloat,
        arrDuplic,
        '', // qryGenGer.FieldByName('GER_SERIE_').AsString,
        'N', // qryGenGer.FieldByName('GER_NOTESP').AsString,
        '1999',
        '',
        '',
        fRetDesCla('1999'),
        0,  // qryGenGer.FieldByName('GER_PORDES').AsFloat,
        strCodOpe, // qryGenGer.FieldByName('GER_CODDIG').AsString,
        '', // qryGenGer.FieldByName('GER_CODCND').AsString,
        '', // qryGenGer.FieldByName('GER_CODFPG').AsString,
        0,  // qryGenGer.FieldByName('GER_FATNOT').AsFloat,
        recServicos,
        0,   // qryGenDet.fRetSoma('GER_DESACE'),
        IIF(blnDevolucao, 'D', ''),  // qryGenGer.FieldByName('GER_ORIDOC').AsString,
        'N', // qryGenGer.FieldByName('GER_CONENT').AsString,
        '',  // qryGenGer.FieldByName('GER_CODREP').AsString,
        0,  // qryGenGer.FieldByName('GER_ALQIRF').AsFloat,
        0,  // qryGenGer.FieldByName('GER_VALIRF').AsFloat,
        0,  // qryGenGer.FieldByName('GER_ALQPIS').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_VALPIS'),
        0,  // qryGenGer.FieldByName('GER_ALQCOF').AsFloat,
        0,  // qryGenDet.fRetSoma('GER_VALCOF'),
        0,  // qryGenGer.FieldByName('GER_ALQCSL').AsFloat,
        0,  // qryGenGer.FieldByName('GER_VALCSL').AsFloat,
        0,  // qryGenGer.FieldByName('GER_IRFRET').AsFloat,
        0,  // qryGenGer.FieldByName('GER_PISRET').AsFloat,
        0,  // qryGenGer.FieldByName('GER_COFRET').AsFloat,
        0,  // qryGenGer.FieldByName('GER_CSLRET').AsFloat,
        '', // qryGenGer.FieldByName('GER_NOTRET').AsString,
        0,  // qryGenGer.FieldByName('GER_ALIRFP').AsFloat,
        0,  // qryGenGer.FieldByName('GER_ALPISP').AsFloat,
        0,  // qryGenGer.FieldByName('GER_ALCOFP').AsFloat,
        0,  // qryGenGer.FieldByName('GER_ALCSLP').AsFloat,
        0,  // qryGenGer.FieldByName('GER_SERRET').AsFloat,
        '', // qryGenGer.FieldByName('GER_NORESE').AsString,
        0,  // qryGenGer.FieldByName('GER_PESGSO').AsFloat,
        0,  // qryGenGer.FieldByName('GER_VLSGSO').AsFloat,
        0,  // qryGenGer.FieldByName('GER_IRPRRT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_IRPRDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_IRSERT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_IRSEDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_PIPRRT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_PIPRDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_PISERT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_PISEDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_COPRRT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_COPRDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_COSERT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_COSEDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_CSPRRT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_CSPRDV').AsFloat,
        0,  // qryGenGer.FieldByName('GER_CSSERT').AsFloat,
        0,  // qryGenGer.FieldByName('GER_CSSEDV').AsFloat,
        '', // qryGenGer.FieldByName('GER_ORDPRO').AsString,
        0,  // qryGenGer.FieldByName('GER_BASORG').AsFloat,
        0,  // qryGenGer.FieldByName('GER_ICMORG').AsFloat,
        0,  // qryGenGer.FieldByName('GER_NCONHE').AsInteger,
        '', // qryGenGer.FieldByName('GER_CONSUM').AsString,
        '', // qryGenGer.FieldByName('GER_ENTFAT').AsString,
        IIf(strTip_FC = 'C', strCodCli, ''), // qryGenGer.FieldByName('GER_CLIFAT').AsString,
        '', // qryGenGer.FieldByName('GER_OPEEXP').AsString,
        '', // qryGenGer.FieldByName('GER_SEPEXP').AsString,
        '', // qryGenGer.FieldByName('GER_TABPRE').AsString,
        '', // qryGenGer.FieldByName('GER_NUM_PR').AsString,
        '', // qryGenGer.FieldByName('GER_ENTFUT').AsString,
        False,
        0, // qryGenGer.FieldByName('GER_MARGEM').AsFloat,
        0,  // qryGenGer.FieldByName('GER_BARTSP').AsFloat,
        0,  // qryGenGer.FieldByName('GER_VLRTSP').AsFloat,
        '', // qryGenGer.FieldByName('GER_OPRFLJ').AsString,
        '', // qryGenGer.FieldByName('GER_NUMREG').AsString,
        VS_Date, // qryGenGer.FieldByName('GER_DTENTR').AsDateTime,
        '',  // qryGenGer.FieldByName('GER_CLAFI4').AsString,
        'N', // qryGenGer.FieldByName('GER_AUTSER').AsString,
        '',  // qryGenGer.FieldByName('GER_CODEVE').AsString,
        '',
        '',
        strCodOco,
        '',
        True);

      If Not Result Then
        Exit;

      if Result then
      begin

        qryGenDet.First;
        while not qryGenDet.Eof do
        begin

          If (qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML') Or
             ((fTipoTinta(qryGenDet.FieldByName('DET_IDEPRO').AsString) = ttAutomotiva) And
              (qryGenDet.FieldByName('DET_PROEMB').AsString = 'S')) Or
             (fTipoTinta(qryGenDet.FieldByName('DET_IDEPRO').AsString) = ttImobiliaria) Then
          Begin
            strAutIncMovDet := '';

            Result := Result and fGravaMovDet(
              strAutIncMovDet,
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', strAutIncMovGer, strSeqGerDev),
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', strNumDocMovGer, strNumDoc),
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', 'ML',            strEspDoc),
              strCodEmp, //qryGenDet.FieldByName('DET_CODEMP').AsString,
              qryGenDet.FieldByName('DET_CODITE').AsString,
              qryGenDet.FieldByName('DET_CODVEN').AsString,
              qryGenDet.FieldByName('DET_CODDIV').AsString,
              qryGenDet.FieldByName('DET_CODMAR').AsString,

              IIf(strTip_FC = 'F', strCodCli, ''), // qryGenDet.FieldByName('DET_CODFOR').AsString,
              IIf(strTip_FC = 'C', strCodCli, ''), // qryGenGer.FieldByName('DET_CODCLI').AsString,

              dtaDtaEnt,
              fTime(),
              VS_Date,   // qryGenDet.FieldByName('DET_DTADOC').AsDateTime,
              strCndPag, // qryGenDet.FieldByName('DET_CONPAG').AsString,
              'C',       // qryGenDet.FieldByName('DET_TIP_FC').AsString,
              strCliEst, // qryGenDet.FieldByName('DET_ESTADO').AsString,
              qryGenDet.FieldByName('DET_DESCRI').AsString,
              qryGenDet.FieldByName('DET_REFERE').AsString,
              qryGenDet.FieldByName('DET_UNIDAD').AsString,
              qryGenDet.FieldByName('DET_FORITE').AsString,

              qryGenDet.FieldByName('DET_QTDITE_DEV').AsFloat,
              qryGenDet.FieldByName('DET_UNITAR').AsFloat,
              qryGenDet.FieldByName('DET_UNIORI').AsFloat,
              qryGenDet.FieldByName('DET_UNIVIS').AsFloat,
              qryGenDet.FieldByName('DET_TOTITE_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VLRCON_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTCUS_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTMED_DEV').AsFloat,
              qryGenDet.FieldByName('DET_DESCON_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTFRE_DEV').AsFloat,
              qryGenDet.FieldByName('DET_DESESP_DEV').AsFloat,
              qryGenDet.FieldByName('DET_CODREP').AsString,
              qryGenDet.FieldByName('DET_CODVE2').AsString,
              qryGenDet.FieldByName('DET_PERCOM').AsFloat,
              qryGenDet.FieldByName('DET_TOTCOM_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTCO2_DEV').AsFloat,
              '1999',
              qryGenDet.FieldByName('DET_CODFIS').AsString,
              qryGenDet.FieldByName('DET_VALIPI_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ALQIPI').AsFloat,
              qryGenDet.FieldByName('DET_BASIPI_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VALICM_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ALQICM').AsFloat,
              qryGenDet.FieldByName('DET_BASICM_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VALRET_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ALQRET').AsFloat,
              qryGenDet.FieldByName('DET_BASRET_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTPES_DEV').AsFloat,
              qryGenDet.FieldByName('DET_PERBAS').AsFloat,
              qryGenDet.FieldByName('DET_PERRED').AsFloat,
              True,
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', strEspDoc, ''), // strTipFat,
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', strNumDoc, ''), // strNumFat,
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', strCodEmp, ''), // strEmpFat,
              VS_Date,
              strLoginUsuarioLogado,
              '',
              0,
              qryGenDet.FieldByName('DET_IDEPRO').AsString,
              qryGenDet.FieldByName('DET_INCPIS').AsString,
              IIF(qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML', '', strSerie),
              qryGenDet.FieldByName('DET_DESACE_DEV').AsFloat,
              'N', // qryGenDet.FieldByName('DET_NOTESP').AsString,
              '',  // qryGenDet.FieldByName('DET_DOCDEV').AsString,
              '',  // qryGenDet.FieldByName('DET_ESPDEV').AsString,
              '',  // qryGenDet.FieldByName('DET_EMPDEV').AsString,
              qryGenDet.FieldByName('DET_ITECHA').AsString,
              qryGenDet.FieldByName('DET_ITETIN').AsString,
              qryGenDet.FieldByName('DET_DESCOR').AsString,
              qryGenDet.FieldByName('DET_TIPEMB').AsString,
              qryGenDet.FieldByName('DET_QTDEMB').AsFloat,
              qryGenDet.FieldByName('DET_PREEMB').AsFloat,
              qryGenDet.FieldByName('DET_TIPPRE').AsString,
              qryGenDet.FieldByName('DET_PRVTIN').AsFloat,
              qryGenDet.FieldByName('DET_PRCTIN').AsFloat,
              qryGenDet.FieldByName('DET_FATTIN').AsFloat,
              qryGenDet.FieldByName('DET_PROEMB').AsString,
              qryGenDet.FieldByName('DET_CODDIG').AsString,
              qryGenDet.FieldByName('DET_CODCND').AsString,
              qryGenDet.FieldByName('DET_CODFPG').AsString,
              qryGenDet.FieldByName('DET_ITEEMB').AsString,
              '',
              qryGenDet.FieldByName('DET_LAZQUA').AsInteger,
              qryGenDet.FieldByName('DET_PROMOC').AsString,
              qryGenDet.FieldByName('DET_SEQTIN').AsString,
              qryGenDet.FieldByName('DET_QTDPUL').AsFloat,
              qryGenDet.FieldByName('DET_PEDCOM').AsString,
              IIF(blnDevolucao, 'D', ''),
              qryGenDet.FieldByName('DET_NUM_PD').AsString,
              qryGenDet.FieldByName('DET_ESP_PD').AsString,
              qryGenDet.FieldByName('DET_EMP_PD').AsString,
              qryGenDet.FieldByName('DET_IND_PD').AsInteger,
              qryGenDet.FieldByName('DET_ORDPRO').AsString,
              qryGenDet.FieldByName('DET_DESNES').AsString,
              IIF((qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML') And (strTip_FC = 'C'), strCodCli, ''),
              qryGenDet.FieldByName('DET_BCAMIN').AsFloat,
              qryGenDet.FieldByName('DET_BCACOM').AsFloat,
              qryGenDet.FieldByName('DET_VOLPRO').AsFloat,
              qryGenDet.FieldByName('DET_CODACA').AsString,
              qryGenDet.FieldByName('DET_EMPACA').AsString,
              qryGenDet.FieldByName('DET_PROACA').AsString = 'S',
              False,
              '', // qryGenDet.FieldByName('DET_ESPFUT').AsString,
              '', // qryGenDet.FieldByName('DET_DOCFUT').AsString,
              '', // qryGenDet.FieldByName('DET_EMPFUT').AsString,
              qryGenDet.FieldByName('DET_TABPRE').AsString,
              qryGenDet.FieldByName('DET_EMPCOM').AsString,
              qryGenDet.FieldByName('DET_LINLIN').AsString,
              qryGenDet.FieldByName('DET_CATALI').AsString,
              qryGenDet.FieldByName('DET_CODDIL').AsString,
              qryGenDet.FieldByName('DET_PORDIL').AsFloat,
              qryGenDet.FieldByName('DET_DILCON').AsString,
              qryGenDet.FieldByName('DET_PORCAT').AsFloat,
              qryGenDet.FieldByName('DET_UNIDIG').AsFloat,
              qryGenDet.FieldByName('DET_QTDPON').AsFloat,
              qryGenDet.FieldByName('DET_ENTFUT').AsString,
              qryGenDet.FieldByName('DET_MOTFUT').AsString,
              qryGenDet.FieldByName('DET_DTAFUT').AsDateTime,
              qryGenDet.FieldByName('DET_TOTCU2_DEV').AsFloat,
              qryGenDet.FieldByName('DET_COMREP').AsFloat,
              qryGenDet.FieldByName('DET_PERREP').AsFloat,
              qryGenDet.FieldByName('DET_KEY_EP').AsString,
              qryGenDet.FieldByName('DET_NUMLOT').AsString,
              qryGenDet.FieldByName('DET_PIGBAS').AsString,
              qryGenDet.FieldByName('DET_VAEIPI_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ALEIPI').AsFloat,
              qryGenDet.FieldByName('DET_BAEIPI_DEV').AsFloat,
              qryGenDet.FieldByName('DET_TOTULT_DEV').AsFloat,
              qryGenDet.FieldByName('DET_IMPULT_DEV').AsFloat,
              qryGenDet.FieldByName('DET_BARTSP_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VLRTSP_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ICOPPR_DEV').AsFloat,
              qryGenDet.FieldByName('DET_SEQCCR').AsInteger,
              qryGenDet.FieldByName('TRI_EMBALA').AsFloat,
              qryGenDet.FieldByName('DET_ALQPIS').AsFloat,
              qryGenDet.FieldByName('DET_BASPIS_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VALPIS_DEV').AsFloat,
              qryGenDet.FieldByName('DET_CSTPIS').AsString,
              qryGenDet.FieldByName('DET_ALQCOF').AsFloat,
              qryGenDet.FieldByName('DET_BASCOF_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VALCOF_DEV').AsFloat,
              qryGenDet.FieldByName('DET_CSTCOF').AsString,
              qryGenDet.FieldByName('DET_CSTIPI').AsString,
              qryGenDet.FieldByName('DET_ENQIPI').AsString,
              qryGenDet.FieldByName('DET_VAERET_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ALERET').AsFloat,
              qryGenDet.FieldByName('DET_BAERET_DEV').AsFloat,
              0,
              qryGenDet.FieldByName('DET_UNITAB').AsFloat,
              qryGenDet.FieldByName('DET_LOT_TA').AsString,
              qryGenDet.FieldByName('DET_CONFRE_DEV').AsFloat,
              qryGenDet.FieldByName('DET_BASANT_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ICMANT_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VENDOR_DEV').AsFloat,
              qryGenDet.FieldByName('DET_OUTDES_DEV').AsFloat,
              qryGenDet.FieldByName('DET_VLGNRE_DEV').AsFloat,
              'P',
              qryGenDet.FieldByName('DET_OUTICM_DEV').AsFloat,
              qryGenDet.FieldByName('DET_ISEICM_DEV').AsFloat,
              qryGenDet.FieldByName('DET_FRESUG_DEV').AsFloat,
              qryGenDet.FieldByName('DET_CODMOT').AsString,
              qryGenDet.FieldByName('DET_NR_PIS').AsString,
              qryGenDet.FieldByName('DET_NR_COF').AsString,
              qryGenDet.FieldByName('DET_SEQGAD').AsString,
              0,
              0,
              0,
              0,
              0,
              '',
              0);

            If Not Result Then
              Exit;

            if qryGenDet.FieldByName('DET_ESPDOC').AsString = 'ML' then
              Result := fAtualizaEstoqueML(qryGenDet.FieldByName('DET_CODITE').AsString,
                -1 * qryGenDet.FieldByName('DET_QTDITE_DEV').AsFloat,
                qryGenDet.FieldByName('DET_NUMLOT').AsString)
            else
              Result := fAtualizaEstoqueCadIte(qryGenDet.FieldByName('DET_CODITE').AsString,
                'E',
                qryGenDet.FieldByName('DET_QTDITE_DEV').AsFloat,
                0,
                qryGenDet.FieldByName('DET_NUMLOT').AsString);
          End;

          If Not Result Then
            Exit;

          qryGenDet.Next;
        end;

        //AQUI ESTOU SELECIONANDO O DOCUMENTO ORIGINAL DE VENDA PARA BAIXAR A BASE
        If Result And blnDevolucao Then
        Begin
          qryMovDet := TZClient.Create(Nil,
            ' SELECT                               ' +
            '     D.*,                             ' +
            '     DET_QTDITE * :PROP_DEV AS DET_QTDITE_DEV ' +
            '   FROM                               ' +
            '     MOVDET D                         ' +
            '  WHERE D.DET_CODACA = :CODACA        ' +
            '    AND D.DET_EMPACA = :EMPACA        ' +
            '    AND D.DET_ESPDOC = :ESPDOC        ' +
            '    AND D.DET_NUMDOC = :NUMDOC        ' +
            '    AND D.DET_CODEMP = :CODEMP        ');

          qryMovDet.qryQuery.ParamByName('CODACA').AsString := strCodAca;
          qryMovDet.qryQuery.ParamByName('EMPACA').AsString := strEmpAca;

          qryMovDet.qryQuery.ParamByName('ESPDOC').AsString := strTipFat;
          qryMovDet.qryQuery.ParamByName('NUMDOC').AsString := strNumFat;
          qryMovDet.qryQuery.ParamByName('CODEMP').AsString := strEmpFat;

          If fltQtdOri = 0 Then
            fltQtdOri := fltQtdDev;

          qryMovDet.qryQuery.ParamByName('PROP_DEV').AsFloat := fltQtdDev / fltQtdOri;

          qryMovDet.fLeDados('pBaixaProdutoAcabadoDecomposto');

          if qryMovDet.IsEmpty then
            Exit;

          If Result And Assigned(fTipoTinta) And (fTipoTinta(qryMovDet.FieldByName('DET_IDEPRO').AsString) in [ttImobiliaria, ttIndustrial]) Then
          Begin
            if (fEmptyStr(qryMovDet.FieldByName('DET_ITEEMB').AsString)) then //se nao tiver embalagem
            begin
              Result := fAtualizaEstoqueCadIte(qryMovDet.FieldByName('DET_CODITE').AsString,
                                               'E',
                                               qryMovDet.FieldByName('DET_QTDITE_DEV').AsFloat,
                                               0,
                                               qryMovDet.FieldByName('DET_NUMLOT').AsString);

              If Result And (Not strAutMovDet.IsEmpty) Then
                pZeraFilkar(strAutMovDet);
            end;
          End;
        End;

      end; {if blnGrava then}

    Except
      on E: Exception do
      begin
        Result := False;
        raise;
      end;
    End;
  Finally
    if Assigned(qryGenDet) then FreeAndNil(qryGenDet);
    if Assigned(qryMovDet) then FreeAndNil(qryMovDet);
  //  if Assigned(qryGenGer) then FreeAndNil(qryGenGer);
  End;
end;

function fVerificaVariacaoQuantidadeFinal(qryEntMer, qryItePed : TDataSet; cdsCopia : TUniClientDataSet = nil): Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
	  objLinha  : TLinhaMsgLibera;
    objLiberacao : TLiberacao;

    fltqtdNov,
    fltQtdOri : Double;

begin
  With qryEntMer Do
  Begin
    objLiberacao := TLiberacao.Create;
    try

      DisableControls;
      First;


      objLiberacao.objMsgLibera.pAddTexto('Os Seguintes itens tem a Quantidade Digitada maior que a Quantidade do Pedido!');

      objTabela := TRegistroMsgLiberaTabela.Create;


      While Not Eof Do
      Begin
        If (Not fVerificaQuantidadeAMaior(FieldByName('ENT_CODITE').AsString,
                                          FieldByName('ENT_QTDITE').AsFloat,
                                          FieldByName('ENT_QTDITE').AsFloat,
                                          cdsCopia,
                                          qryItePed,
                                          fltQtdOri,
                                          fltQtdNov)) Then
        Begin
          if objTabela.isEmpty then
          begin
            objLinha  := TLinhaMsgLibera.Create;
            objLinha.enuTipoLinha := tlCabecalho;
            objLinha.pAddColuna(''  , 'CÓDIGO'       , 7  , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'DESCRICAO'    , 41 , alEsquerda , teAutcom);
            objLinha.pAddColuna(''  , 'QTD. PED.'    , 16 , alCentro   , teAutcom);
            objLinha.pAddColuna(''  , 'QTD. DIG.'    , 16 , alDireita  , teAutcom);
            objTabela.lstLinhas.Add(objLinha);
          end;

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna('CÓDIGO'       , FieldByName('ENT_CODITE').AsString  , 7  , alEsquerda );
          objLinha.pAddColuna('DESCRICAO'    , FieldByName('ENT_DESITE').AsString  , 41 , alEsquerda );
          objLinha.pAddColuna('QTD. PED.'    , FormatFloat('#,##0.00', fltQtdOri ) , 16 , alCentro   );
          objLinha.pAddColuna('QTD. DIG.'    , FormatFloat('#,##0.00', fltQtdNov ) , 16 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);

        End;

        Next;
      End;

      if objTabela.isEmpty then
      begin
        FreeAndNil(objTabela);
        Result := True;
      end
      else
      begin
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        objLiberacao.strDirAce := 'LIBALTMAI';
        objLiberacao.strMsgSen := 'Entrada de Mercadorias';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        Result := objLiberacao.fLibera;
      end;

    Finally
      FreeAndNil(objLiberacao);
      EnableControls;
    End;

  End;

end;

{**********************************************}
{* GRAVA COMISSAO DO PROFISSIONAL - DEVOLUÇÃO *}
{*******************************************LU*}
function fGComProDev(arrItensDev: TArrItensDevolucao;
                     strNumDoc,
                     strEspDoc,
                     strCodCli: String): Boolean;
  Var
    cdsComPro,
    cdsMovCpr    : TUniClientDataSet;

    qryGen,
    qryAux       : TUniQuery;

    strSQL,
    strCodCom,
    strDocDev,
    strCodDiv    : String;

    fltBasComiss,
    fltVlrComiss,
    fltTotIte,
    fltDesEsp    : Double;

    VS_intDecUni : Integer;

    objComPro    : TComPro;

    blnRecalcComi: Boolean;

    fatVenda : TFatVenda;

    fltFatorQuantidade: Double;

    itemDev: TItemDevolucao;
    intPosMat: Integer;

  function fGetSQL(blnAutInc: Boolean): String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  P.COM_CODPRO AS CODDIV, ';
    Result := Result + '  P.COM_CREDEB AS CREDEB, ';
    Result := Result + '  D.DET_CODITE AS CODITE, ';
    Result := Result + '  D.DET_QTDITE AS QTDVEN, ';
    Result := Result + '  C.CPR_BASCOM AS BASCOM, ';
    Result := Result + '  C.CPR_VLRCOM AS VLRCOM, ';
    Result := Result + '  C.CPR_PERCOM AS PERCOM  ';
    Result := Result + 'FROM ';
    Result := Result + '  MOVDET D INNER JOIN MOVCPR C ON D.AUTOINCREM = C.CPR_SEQDET ';
    Result := Result + '           INNER JOIN COMPRO P ON P.AUTOINCREM = C.CPR_SEQCOM ';
    Result := Result + 'WHERE ';
    Result := Result + '  D.DET_NUMDOC = ' + QuotedStr(itemDev.strDocumento) + ' AND ';
    Result := Result + '  D.DET_ESPDOC = ' + QuotedStr(itemDev.strEspecie)   + ' AND ';
    Result := Result + '  D.DET_CODEMP = ' + QuotedStr(itemDev.strEmpresa)   + ' AND ';
    Result := Result + '  D.DET_CODCLI = ' + QuotedStr(itemDev.strCliente);

    If blnAutInc Then
      Result := Result + '  AND D.AUTOINCREM = ' + QuotedStr(itemDev.strAutIncVenda)
    Else
      Result := Result + '  AND D.DET_CODITE = ' + QuotedStr(itemDev.strProduto);

    Result := Result + 'ORDER BY CODDIV, CODITE ';
  end;

  procedure pCarregaItemMatItens;
    Var
      qryDadosVenda: TUniQuery;
  begin
    qryDadosVenda := fCriaQuery(nil);

    With qryDadosVenda, SQL Do
    Begin
      Close;
      Clear;

      Add('SELECT ');
      Add('  DET_QTDPON, ');
      Add('  DET_UNIORI, ');
      Add('  DET_UNIVIS, ');
      Add('  DET_TAXJUR, ');
      Add('  DET_UNITAR, ');
      Add('  DET_VAL_RT  ');
      Add('FROM ');
      Add('  MOVDET D ');
      Add('  INNER JOIN MOVTRI T ');
      Add('    ON D.AUTOINCREM = T.DET_SEQGER ');
      Add('WHERE ');
      Add('   D.AUTOINCREM = ' + QuotedStr(itemDev.strAutIncVenda));

      Open;
    End;

    Inc(intPosMat);

    fatVenda.arrMatItens[intPosMat].strCodIte := itemDev.strProduto;
    fatVenda.arrMatItens[intPosMat].fltQtdIte := itemDev.fltQuantidade;
    fatVenda.arrMatItens[intPosMat].fltTotIte := itemDev.fltTotalItem;
    fatVenda.arrMatItens[intPosMat].fltDesEsp := itemDev.fltDescontoEspecial;

    fatVenda.arrMatItens[intPosMat].fltQtdPon := qryDadosVenda.FieldByName('DET_QTDPON').AsFloat;
    fatVenda.arrMatItens[intPosMat].fltUniOri := qryDadosVenda.FieldByName('DET_UNIORI').AsFloat;
    fatVenda.arrMatItens[intPosMat].fltUniVis := qryDadosVenda.FieldByName('DET_UNIVIS').AsFloat;
    fatVenda.arrMatItens[intPosMat].fltTaxJur := qryDadosVenda.FieldByName('DET_TAXJUR').AsFloat;
    fatVenda.arrMatItens[intPosMat].fltUnitar := qryDadosVenda.FieldByName('DET_UNITAR').AsFloat;
    fatVenda.arrMatItens[intPosMat].fltVal_RT := qryDadosVenda.FieldByName('DET_VAL_RT').AsFloat;

    fltTotIte := fltTotIte + itemDev.fltTotalItem;
    fltDesEsp := fltDesEsp + itemDev.fltDescontoEspecial;

    fatVenda.fltTotPro := fltTotIte;
    fatVenda.fltDesEsp := fltDesEsp;

    FreeAndNil(qryDadosVenda);
  end;

Begin
  Result   := True;

  If VS_strTCoPro = '4' Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    fatVenda := TFatVenda.Create(Nil);

    fatVenda.strCodCli := strCodCli;

    fltDesEsp := 0;
    fltTotIte := 0;

    VS_intDecUni := fCfgSis('DECUNI', varInteger);
    objComPro := TComPro.Create(Nil);

    objComPro.VS_strTCoProInterna := VS_strTCoPro;
    fatVenda.VS_strTCoPro := VS_strTCoPro;

    qryGen    := fCriaQuery(Nil);
    qryAux    := fCriaQuery(Nil);

    cdsMovCpr := TUniClientDataSet.Create(Nil);
    cdsComPro := TUniClientDataSet.Create(Nil);

    blnRecalcComi := False;
    strDocDev := EmptyStr;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODDIV';
      DataType := ftString;
      Size := 8;
    End;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODITE';
      DataType := ftString;
      Size := 8;
    End;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'AUTINC';
      DataType := ftString;
      Size := 20;
    End;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'BASCOM';
      DataType := ftFloat;
      Precision := 4;
    End;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'VLRCOM';
      DataType := ftFloat;
      Precision := VS_intDecUni;
    End;

    With cdsMovCpr.FieldDefs.AddFieldDef Do
    Begin
      Name := 'PERCOM';
      DataType := ftFloat;
      Precision := VS_intDecUni;
    End;

    cdsMovCpr.IndexFieldNames := 'CODDIV';
    cdsMovCpr.CreateDataSet;

    pCloneDataSet(cdsComPro, cdsMovCpr);

    intPosMat := -1;

    SetLength(fatVenda.arrMatItens, Length(arrItensDev));

    For itemdev In arrItensDev Do
      pCarregaItemMatItens;

    If fCfgSis('UTI_RT', VarBoolean) Then
      fatVenda.pRateiaValorRT;

    For itemdev In arrItensDev Do
    Begin
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(fGetSQL(True));
      qryGen.Open;
      qryGen.First;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(fGetSQL(False));
        qryGen.Open;
        qryGen.First;
      End;

      strDocDev := strDocDev + '"' + itemDev.strDocumento +
                                     itemDev.strEspecie   +
                                     itemDev.strEmpresa   + '",';

      {*************************************************************************}
      {* SE EXISTIR COMPRO E MOVCPR, DEVE RETORNAR A COMISSÃO DO DOC. DE VENDA *}
      {* SE NÃO, DEVE CALCULAR A COMISSÃO NOVAMENTE                            *}
      {**********************************************************************MM*}
      If Not qryGen.IsEmpty Then
      Begin

        While Not qryGen.Eof Do
        Begin
          fltFatorQuantidade := itemDev.fltQuantidade / qryGen.FieldByName('QTDVEN').AsFloat;

          cdsMovCpr.Insert;
          cdsMovCpr.FieldByName('CODDIV').AsString := qryGen.Fieldbyname('CODDIV').AsString;
          cdsMovCpr.FieldByName('CODITE').AsString := qryGen.Fieldbyname('CODITE').AsString;
          cdsMovCpr.FieldByName('AUTINC').AsString := itemDev.strAutIncDevolucao;
          cdsMovCpr.FieldByName('BASCOM').AsFloat  := qryGen.Fieldbyname('BASCOM').AsFloat;

          If (qryGen.Fieldbyname('BASCOM').AsFloat = 0) And (qryGen.Fieldbyname('PERCOM').AsFloat > 0) Then
            cdsMovCpr.FieldByName('BASCOM').AsFloat  := qryGen.Fieldbyname('VLRCOM').AsFloat / qryGen.Fieldbyname('PERCOM').AsFloat * 100;

          cdsMovCpr.FieldByName('BASCOM').AsFloat  := cdsMovCpr.Fieldbyname('BASCOM').AsFloat * fltFatorQuantidade;
          cdsMovCpr.FieldByName('VLRCOM').AsFloat  := qryGen.Fieldbyname('VLRCOM').AsFloat * fltFatorQuantidade;
          cdsMovCpr.FieldByName('PERCOM').AsFloat  := qryGen.Fieldbyname('PERCOM').AsFloat;
          cdsMovCpr.Post;

          qryGen.Next;
        End;

      End
      Else
        blnRecalcComi := True;

    End;

    If Not blnRecalcComi Then
    Begin

      cdsMovCpr.First;
      While Not cdsMovCpr.Eof Do
      Begin
        If cdsComPro.Locate('CODDIV', cdsMovCpr.FieldByName('CODDIV').AsString, []) Then
          cdsComPro.Edit
        Else
          cdsComPro.Insert;

        cdsComPro.FieldByName('CODDIV').AsString := cdsMovCpr.fieldbyname('CODDIV').AsString;
        cdsComPro.FieldByName('BASCOM').AsFloat  := cdsComPro.FieldByName('BASCOM').AsFloat + cdsMovCpr.fieldbyname('BASCOM').AsFloat;
        cdsComPro.FieldByName('VLRCOM').AsFloat  := cdsComPro.FieldByName('VLRCOM').AsFloat + cdsMovCpr.fieldbyname('VLRCOM').AsFloat;
        cdsComPro.Post;

        cdsMovCpr.Next;
      End;

      cdsComPro.First;
      While Not cdsComPro.Eof Do
      Begin
        Result := objComPro.fGravaComPro(strCodCom,
                                         strNumDoc,
                                         strEspDoc,
                                         strCodCli,
                                         cdsComPro.fieldbyname('CODDIV').AsString,
                                         'D',
                                         'REFERENTE A FATURAMENTO',
                                         Abs(cdsComPro.fieldbyname('BASCOM').AsFloat),
                                         Abs(cdsComPro.fieldbyname('VLRCOM').AsFloat));

        If Not Result Then
          Exit;

        cdsMovCpr.Filtered := False;
        cdsMovCpr.Filter   := ' CODDIV = ' + cdsComPro.FieldByName('CODDIV').AsString;
        cdsMovCpr.Filtered := True;
        cdsMovCpr.First;
        While Not cdsMovCpr.Eof Do
        Begin
          Result := objComPro.fGravaMovCpr(Nil,
                                           strNumDoc,
                                           strEspDoc,
                                           strCodCli,
                                           strCodCom,
                                           cdsComPro.fieldbyname('CODDIV').AsString,
                                           cdsMovCpr.FieldByName('CODITE').AsString,
                                           cdsMovCpr.FieldByName('AUTINC').AsString,
                                           Abs(cdsMovCpr.fieldbyname('BASCOM').AsFloat),
                                           Abs(cdsMovCpr.fieldbyname('PERCOM').AsFloat),
                                           Abs(cdsMovCpr.fieldbyname('VLRCOM').AsFloat));

          cdsMovCpr.Next;
        End;

        cdsComPro.Next;
      End;

    End
    Else
    Begin
      strDocDev := Copy(strDocDev, 1, Length(strDocDev)-1);

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQLComPro(arrItensDev));
        Open;
        First;

        While Not EOF Do
        Begin
          strCodDiv := FieldByName('COM_CODPRO').AsString;

          fltBasComiss := Abs(fltTotIte) - fltDesEsp;

          If ( VS_strTCoPro = '3' ) Then
          Begin
            fltVlrComiss := fCalTotPontProfissDev;
          End
          Else
          Begin

            If (fVerificaTipoComissao(strCodDiv) = '1') Then
            Begin
              {*****************************************************}
              {* BUSCANDO O PERCENTUAL DA COMISSÃO DO PROFISSIONAL *}
              {**************************************************LU*}
              strSQL := '';
              strSQL := strSQL + ' SELECT ';
              strSQL := strSQL + '   IFNULL(DIV_PERCOM,0) AS DIV_PERCOM, ';
              strSQL := strSQL + '   IFNULL(DIV_PERCOP,0) AS DIV_PERCOP  ';
              strSQL := strSQL + ' FROM ';
              strSQL := strSQL + '   CADDIV ';
              strSQL := strSQL + ' WHERE ';
              strSQL := strSQL + '   DIV_CODDIV = :CODDIV ';

              qryAux.Close;
              qryAux.SQL.Clear;
              qryAux.SQL.Add(strSQL);
              qryAux.ParamByName('CODDIV').AsString := strCodDiv;
              qryAux.Open;

              If qryAux.FieldByName('DIV_PERCOM').AsFloat > 0 Then
              Begin
                fatVenda.pPreencheComissaoItens(qryAux.FieldByName('DIV_PERCOM').AsFloat,
                                                qryAux.FieldByName('DIV_PERCOP').AsFloat);

                fltBasComiss := fatVenda.fCalcTotalItensComissaoProfiss(strCodDiv, False) +
                                fatVenda.fCalcTotalItensComissaoProfiss(strCodDiv, True );

                fltVlrComiss := (((fatVenda.fCalcTotalItensComissaoProfiss(strCodDiv, False)) / 100) * qryAux.FieldByName('DIV_PERCOM').AsFloat) +
                                (((fatVenda.fCalcTotalItensComissaoProfiss(strCodDiv, True )) / 100) * qryAux.FieldByName('DIV_PERCOP').AsFloat) ;
              End
              Else
              Begin
                fltBasComiss := 0.0;
                fltVlrComiss := 0.0;
              End;

            End Else If (fVerificaTipoComissao(strCodDiv) = '2') Then
            Begin

              fatVenda.pCalcComissaoProfissItem(objComPro, strCodDiv, fltBasComiss, fltVlrComiss);

            End Else If (fVerificaTipoComissao(strCodDiv) = '3') Then
            Begin

              fatVenda.fltTotPro := fltTotIte;
              fatVenda.fltDesEsp := fltDesEsp;

              fatVenda.pComProFaixaFat(strCodDiv, fltBasComiss, fltVlrComiss, fltTotIte-fltDesEsp);

            End Else If (fVerificaTipoComissao(strCodDiv) = '4') Then
            Begin

              If fCfgSis('UTI_RT', VarBoolean) Then
                fatVenda.pCalcComissaoProfissRT(fltBasComiss, fltVlrComiss)
              Else
                fatVenda.pCalcComissaoProfissCadCliente(fltBasComiss, fltVlrComiss);

            End;

          End;

          If (fltVlrComiss <> 0.0) Then
          Begin
            Result := objComPro.fGravaComPro(strCodCom,
                                             strNumDoc,
                                             strEspDoc,
                                             strCodCli,
                                             strCodDiv,
                                             'D',
                                             'REFERENTE A FATURAMENTO',
                                             Abs(fltBasComiss),
                                             Abs(fltVlrComiss))
                      And
                      objComPro.fGravaMovCpr(fatVenda.arrMatItens,
                                             strNumDoc,
                                             strEspDoc,
                                             strCodCli,
                                             strCodCom,
                                             strCodDiv);

            If Not Result Then
              Exit;
          End;

          Next;
        End;
      End;
    End;

    FreeAndNil(objComPro);
    FreeAndNil(qryGen);
    FreeAndNil(qryAux);
    FreeAndNil(cdsMovCpr);
    FreeAndNil(cdsComPro);
    FreeAndNil(fatVenda);

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGComProDev]');
    End;

  End;
End;

function fGComProDevCtr(arrItensDev: TArrItensDevolucao;
                        strNumDoc,
                        strEspDoc,
                        strCodCli,
                        strClaFis,
                        strCodVen,
                        strCodDig,
                        strCodPor: String): Boolean;
  Var
    qryGen,
    qryGen2 : TUniQuery;

    stlCodigos : TStringList;

    cdsProfissional : TUniClientDataSet;

    fltValor: Double;
    fltFatorQuantidade: Double;

    strHisto,
    strNumDup,
    strCliDiv: String;

    VS_intDecUni : Integer;

    objComPro : TComPro;

    itemDev: TItemDevolucao;

  function fRetornaClienteDiversos(strCodDiv: String): String;
    Var
      qryAux: TUniQuery;
  begin
    Result := '';

    If (fEmptyStr(strCodDiv)) Then
    Begin
      Exit;
    End;

    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('SELECT DIV_CODCLI FROM CADDIV WHERE DIV_CODDIV = :CODDIV');
    qryAux.ParamByName('CODDIV').AsString := strCodDiv;
    qryAux.Open;

    Result := qryAux.FieldByName('DIV_CODCLI').AsString;

    FreeAndNil(qryAux);
  end;

  function fGetSQL(blnAutInc: Boolean): String;
  begin
    Result := '';
    Result := Result + 'SELECT ';
    Result := Result + '  P.COM_CODPRO AS CODDIV, ';
    Result := Result + '  P.COM_CREDEB AS CREDEB, ';
    Result := Result + '  D.DET_CODITE AS CODITE, ';
    Result := Result + '  D.DET_QTDITE AS QTDVEN, ';
    Result := Result + '  C.CPR_BASCOM AS BASCOM, ';
    Result := Result + '  C.CPR_VLRCOM AS VLRCOM, ';
    Result := Result + '  C.CPR_PERCOM AS PERCOM  ';
    Result := Result + 'FROM ';
    Result := Result + '  MOVDET D INNER JOIN MOVCPR C ON D.AUTOINCREM = C.CPR_SEQDET ';
    Result := Result + '           INNER JOIN COMPRO P ON P.AUTOINCREM = C.CPR_SEQCOM ';
    Result := Result + 'WHERE ';
    Result := Result + '  D.DET_NUMDOC = ' + QuotedStr(itemDev.strDocumento) + ' AND ';
    Result := Result + '  D.DET_ESPDOC = ' + QuotedStr(itemDev.strEspecie)   + ' AND ';
    Result := Result + '  D.DET_CODEMP = ' + QuotedStr(itemDev.strEmpresa)   + ' AND ';
    Result := Result + '  D.DET_CODCLI = ' + QuotedStr(itemDev.strCliente);

    If blnAutInc Then
      Result := Result + '  AND D.AUTOINCREM = ' + QuotedStr(itemDev.strAutIncVenda)
    Else
      Result := Result + '  AND D.DET_CODITE = ' + QuotedStr(itemDev.strProduto);

    Result := Result + 'ORDER BY CODDIV, CODITE ';
  end;

begin
  VS_intDecUni := fCfgSis('DECUNI', varInteger);

  If VS_strTCoPro = '4' Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    Result := True;
    objComPro  := TComPro.Create(Nil);
    objComPro.VS_strTCoProInterna := VS_strTCoPro;
    stlCodigos := TStringList.Create;
    qryGen     := fCriaQuery(Nil);
    qryGen2    := fCriaQuery(Nil);

    cdsProfissional := TUniClientDataSet.Create(Nil);

    With cdsProfissional.FieldDefs.AddFieldDef Do
    Begin
      Name := 'CODDIV';
      DataType := ftString;
      Size := 8;
    End;

    With cdsProfissional.FieldDefs.AddFieldDef Do
    Begin
      Name := 'VTOTAL';
      DataType := ftFloat;
      Precision := VS_intDecUni;
    End;

    With cdsProfissional.FieldDefs.AddFieldDef Do
    Begin
      Name := 'PERCOM';
      DataType := ftFloat;
      Precision := VS_intDecUni;
    End;

    cdsProfissional.CreateDataSet;

    For itemDev In arrItensDev Do
    Begin
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(fGetSQL(True));
      qryGen.Open;
      qryGen.First;

      If qryGen.IsEmpty Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(fGetSQL(False));
        qryGen.Open;
        qryGen.First;
      End;

      While (Not qryGen.Eof) Do
      Begin
        strCliDiv := fRetornaClienteDiversos(qryGen.FieldByName('CODDIV').AsString);

        fltFatorQuantidade := itemDev.fltQuantidade / qryGen.FieldByName('QTDVEN').AsFloat;

        If (Not fEmptyStr(strCliDiv)) Then
        Begin
          If (cdsProfissional.Locate('CODDIV', strCliDiv, [])) Then
            cdsProfissional.Edit
          Else
          Begin
            cdsProfissional.Insert;
            cdsProfissional.FieldByName('VTOTAL').AsFloat  := 0;
          End;

          cdsProfissional.FieldByName('CODDIV').AsString := strCliDiv;
          cdsProfissional.FieldByName('VTOTAL').AsFloat  := cdsProfissional.FieldByName('VTOTAL').AsFloat +
                                                            qryGen.FieldByName('VLRCOM').AsFloat * fltFatorQuantidade;

          cdsProfissional.Post;
        End;
        qryGen.Next;
      End;

    End;

    If cdsProfissional.RecordCount <= 0 Then
      Exit;

    cdsProfissional.First;

    {***************************************}
    {* INCLUINDO OS ITENS NA TABELA CADREC *}
    {************************************LU*}
    While Not cdsProfissional.Eof Do
    Begin
      If (cdsProfissional.FieldByName('VTOTAL').AsFloat > 0) And
         (Not fEmptyStr(cdsProfissional.fieldbyname('CODDIV').AsString)) Then
      Begin

        fltValor := IfThen(LeftStr(strClaFis, 1) < '5',
                    cdsProfissional.fieldbyname('VTOTAL').AsFloat,
                    cdsProfissional.fieldbyname('VTOTAL').AsFloat * -1);

        strHisto := strNumDoc + '-' + strEspDoc + '-' + VS_strCodEmp + '-' + strCodCli + '-REF. DEBITO - COMISSAO PROFISSIONAIS';

        strNumDup := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);

        Result := fGravaCadRec('untPcmGer',
                               'INCLUSÃO',
                               strNumDup,                                      // Duplicata
                               'A',                                            // Parcela
                               0,                                              // Seq. Baixa
                               'CC',                                           // Especie
                               cdsProfissional.fieldbyname('CODDIV').AsString, // Cliente
                               VS_strCodEmp,                                   // Empresa
                               strCodVen,                                      // Vendedor
                               strCodDig,                                      // Digitador
                               strCodPor,                                      // Portador
                               VS_Date,                                        // Data de cadastro
                               VS_Date,                                        // Data de Vencimento
                               fltValor,                                       // Valor da Duplicata
                               fltValor,                                       // Valor Original
                               0.0,                                            // Despesa de Cobrança
                               '',                                             // Desconto
                               strHisto,                                       // Histórico 1
                               '',                                             // Histórico 2
                               '',                                             // Portador da Baixa
                               '',                                             // Centro de Custo da Baixa
                               '',                                             // Operador da Baixa
                               '',                                             // Documento da Baixa
                               0.0,                                            // Valor do Recebimento
                               0,                                              // Data do Recebimento
                               'N',
                               '',                                             // Código do Evento
                               '',                                             // Código Velho (CONVERSÃO)
                               '',                                             // Tipo de Fora (Condição de Pagamento)
                               '',                                             // Código da Condição de Pagamento
                               False,
                               '',                                             // Codigo do Centro de Custo
                               0,   // intSeqCon
                               fltValor,
                               '',                                             // Observação de Agrupamento 1
                               '',                                             // Observação de Agrupamento 2
                               '',                                             // Observação de Agrupamento 3
                               '',
                               0,
                               0,
                               0,
                               0,
                               '',
                               '',                                        // Empresa de Origem
                               strNumDoc,
                               strEspDoc,
                               VS_strCodEmp,
                               strCodCli,
                               0,
                               0,
                               '',
                               0,
                               0,
                               'N',
                               0,
                               0);


      End;
      cdsProfissional.Next;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGComProDevCtr]');
    End;

  End;

  FreeAndNil(objComPro);
  FreeAndNil(qryGen2);
  FreeAndNil(stlCodigos);
  FreeAndNil(cdsProfissional);
end;

function fAtualizaDocumentoOriginal(arrDocOri: TStringArrayArray; strNumDoc, strEspDoc: String): Boolean;
var
  qryUpOri: TUniQuery;
  intCont: Integer;
begin
  qryUpOri := fCriaQuery(nil);

  try
    with qryUpOri do
    begin
      for intCont := Low(arrDocOri) to High(arrDocOri) do
      begin
        Close;
        SQL.Clear;

        SQL.Add(' UPDATE NOTGER SET          ');
        SQL.Add(' GER_NUMFAT = :NUMFAT,      ');
        SQL.Add(' GER_EMPFAT = :EMPFAT,      ');
        SQL.Add(' GER_TIPFAT = :TIPFAT       ');
        SQL.Add(' WHERE GER_NUMDOC = :NUMDOC ');
        SQL.Add(' AND GER_CODEMP = :CODEMP   ');
        SQL.Add(' AND GER_ESPDOC = :ESPDOC   ');

        ParamByName('NUMFAT').AsString := strNumDoc;
        ParamByName('EMPFAT').AsString := VS_strCodEmp;
        ParamByName('TIPFAT').AsString := strEspDoc;
        ParamByName('NUMDOC').AsString := arrDocOri[intCont, 0];
        ParamByName('CODEMP').AsString := arrDocOri[intCont, 2];
        ParamByName('ESPDOC').AsString := arrDocOri[intCont, 1];

        ExecSQL;
      end;
    end;
    Result := True;
  except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fAtualizaDocumentoOriginal]');
    End;
  end;
  pFreeAndNil(qryUpOri);
end;

Function fTrataRecebimentoDeGarantiaFilial : Boolean;
  Var
    qryDados : TUniQuery;
    strNumPedVen : String;
    strCodCliPed : String;
    strCodOpe    : String;
    strAutIncPed : String;
    recServicos  : TDadosServicos;
    objGarant    : TMovGag;
    strAutIncPedDet : String;
    arrDuplic : TarrDuplicata;
Begin
  Try
    qryDados := fCriaQuery;
    With qryDados, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT ENT_CODITE,                             ');
      Add('        ITE_CODMAR,                             ');
      Add('        ITE_DESITE,                             ');
      Add('        ITE_REFERE,                             ');
      Add('        ITE_CODUNI,                             ');
      Add('        ITE_CODFOR,                             ');
      Add('        ENT_QTDITE,                             ');
      Add('        ENT_SEQPCD,                             ');
      Add('        SEQGAR.*                                ');
      Add(' FROM TMP_ENTMER                                ');
      Add('   INNER JOIN SEQGAR ON SEQ_PCMDET = ENT_SEQPCD ');
      Add('   INNER JOIN CADITE ON ITE_CODITE = ENT_CODITE ');
      Add('   WHERE IFNULL(SEQ_PCMDET,"") <> ""            ');
      Open;

      If not IsEmpty Then
      Begin
        strNumPedVen := fRetSequencialPedido;
        strCodCliPed := fRetornaClienteFilial(VS_strCodEmp);
        strCodOpe    := strLoginUsuarioLogado;
        FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

        Result := untFatGor.fGravaFatGor(strAutIncPed,
                                         VS_strCodEmp,
                                         strNumPedVen,
                                         'PD',
                                         strCodCliPed,
                                         strCodOpe,
                                         '',
                                         '',
                                         VS_Date,
                                         fTime(),
                                         '01000',
                                         fRetNomCidade(fRetNomGeral('CLI_CODCID', 'CLI_CODCLI', 'CADCLI', fStrToFloat(strCodCliPed)) ,1),
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         '',
                                         '',
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         '',
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         0,
                                         arrDuplic,
                                         '',
                                         '',
                                         'GARANTIA',
                                         '',
                                         False,
                                         '',
                                         '',
                                         '',
                                         0,
                                         '',
                                         '',
                                         0.0,
                                         0,
                                         strCodOpe,
                                         '',
                                         '',
                                         recServicos,
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         '',
                                         '',
                                         0,
                                         '',
                                         0,
                                         '1',
                                         '',
                                         0,
                                         '',
                                         '',
                                         False,
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         False,
                                         VS_Date,
                                         'N',
                                         'V',
                                         VS_Date,
                                         '',
                                         0,
                                         '',
                                         '',
                                         '',
                                         False,
                                         '',
                                         Nil,
                                         '',
                                         '',
                                         0,
                                         0,
                                         0,
                                         '',
                                         Nil,
                                         '',
                                         0,
                                         0,
                                         '',
                                         '',
                                         0,
                                         '',
                                         0,
                                         '',
                                         '0',
                                         'N',
                                         'N');

        If Result Then
        Begin
          While (Not Eof) Do
          Begin
            strAutIncPedDet := '';
            Result := Result And fGravaFatDor(strAutIncPedDet,
                                              strAutIncPed,
                                              VS_strCodEmp,
                                              strCodCliPed,
                                              strCodOpe,
                                              FieldByName('ENT_CODITE').AsString,
                                              FieldByName('ITE_CODMAR').AsString,
                                              '',
                                              strNumPedVen,
                                              'PD',
                                              '',
                                              VS_Date,
                                              fTime(),
                                              '01000',
                                              '',
                                              FieldByName('ITE_DESITE').AsString,
                                              FieldByName('ITE_REFERE').AsString,
                                              FieldByName('ITE_CODUNI').AsString,
                                              FieldByName('ITE_CODFOR').AsString,
                                              FieldByName('ENT_QTDITE').AsFloat,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              fRetCodRepresCliente(fRetornaClienteFilial(VS_strCodEmp)),
                                              '',
                                              0,
                                              0,
                                              0,
                                              '5999',
                                              '',
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              0,
                                              False,
                                              '',
                                              '',
                                              '',
                                              0,
                                              '',
                                              '',
                                              0.0,
                                              'NOR',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              0,
                                              0,
                                              '',
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              '',
                                              '',
                                              0.0,
                                              0,
                                              0,
                                              0,
                                              '',
                                              0,
                                              '',
                                              '',
                                              False,
                                              '1',
                                              '',
                                              '',
                                              '',
                                              0,
                                              '',
                                              0,
                                              '',
                                              '',
                                              'N',
                                              '',
                                              0,
                                              0,
                                              0,
                                              0,
                                              '',
                                              '',
                                              '',
                                              False,
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              '',
                                              0,
                                              0,
                                              '',
                                              '',
                                              0,
                                              '',
                                              '',
                                              0,
                                              0,
                                              0);

            If (Result) Then
            Begin
              Try
                objGarant := TMovGag.Create(Nil);
                Result := objGarant.objMovGad.fAtualizaSeqGarantia('SEQ_FATDOR', strAutIncPedDet, 'SEQ_PCMDET', FieldByName('ENT_SEQPCD').AsString);
              Except
                On E : Exception Do
                Begin
                  Result := False;
                  pMensagensErro(e.message,'');
                End;
              End;

              FreeAndNil(objGarant);

            End;

            Next;
          End;
        End;
      End
      Else
        Result := True;

    End;

  Finally
    FreeAndNil(qryDados);
  End;
End;

function  fGravaPortariaCAT(strCodEmp, strCodVen, strTipDoc, strNumDoc, strClaFis, strForCli: string): Boolean;
var
  qryPortariaCat: TUniQuery;
  strSQLSaida1, strSQLSaida2, strSQLEntrada1, strSQLEntrada2: string;
  strSubstituto_Substituido, strEntSai: string;
begin
  try
    Result := False;

    strSQLSaida1 := '';
    strSQLSaida2 := '';
    strSQLEntrada1   := '';
    strSQLEntrada2   := '';

    qryPortariaCat := fCriaQuery(nil);
    qryPortariaCat.Close;
    qryPortariaCat.SQL.Clear;

    if StrToInt(LeftStr(strClaFis, 1)) >= 5 then
    begin
      strEntSai  := 'S';
    end
    else
    begin
      strEntSai  := 'E';
    end;

    if strEntSai = 'S' then
    begin
      if fRegimeSubstituicaoTributaria = '1' then
      begin
        //Substituído
        strSubstituto_Substituido := fCfgSis('CCATST');
      end
      else
      begin
        //Substituto
        strSubstituto_Substituido := fCfgSis('CCATSS');
      end;

      strSQLSaida1 := strSQLSaida1 + 'SELECT  DET_CLAFIS, ';
      strSQLSaida1 := strSQLSaida1 + 'SUM((CASE ';
      strSQLSaida1 := strSQLSaida1 + '  WHEN SUBSTRING(DET_CODFIS,2,2) = "20" THEN (DET_VLRCON - DET_BASICM) ';
      strSQLSaida1 := strSQLSaida1 + '  ELSE DET_VLRCON ';
      strSQLSaida1 := strSQLSaida1 + 'END)) AS VALOR, ';
      strSQLSaida1 := strSQLSaida1 + 'GROUP_CONCAT("x", SUBSTRING(DET_CODFIS,2,2) SEPARATOR "/") AS CODFIS ';
      strSQLSaida1 := strSQLSaida1 + 'FROM MOVDET ';
      strSQLSaida1 := strSQLSaida1 + 'WHERE DET_CODEMP = :CODEMP ';
      strSQLSaida1 := strSQLSaida1 + 'AND DET_CODVEN = :CODVEN ';
      strSQLSaida1 := strSQLSaida1 + 'AND DET_NUMDOC = :NUMDOC ';
      strSQLSaida1 := strSQLSaida1 + 'AND DET_ESPDOC  = :ESPDOC ';
      strSQLSaida1 := strSQLSaida1 + 'AND SUBSTRING(DET_CODFIS,2,2) IN("20","30","40", "41") ';
      strSQLSaida1 := strSQLSaida1 + 'AND LEFT(DET_CLAFIS,1) >= 5 ';
      strSQLSaida1 := strSQLSaida1 + 'GROUP BY DET_CLAFIS ';
      strSQLSaida1 := strSQLSaida1 + 'ORDER BY DET_CLAFIS, DET_CODFIS ';

      strSQLSaida2 := strSQLSaida2 + 'SELECT  DET_CLAFIS, DET_VLRCON AS VALOR, ';
      strSQLSaida2 := strSQLSaida2 + 'GROUP_CONCAT("x", SUBSTRING(DET_CODFIS,2,2) SEPARATOR "/") AS CODFIS ';
      strSQLSaida2 := strSQLSaida2 + 'FROM MOVDET ';
      strSQLSaida2 := strSQLSaida2 + 'WHERE DET_CODEMP = :CODEMP ';
      strSQLSaida2 := strSQLSaida2 + 'AND DET_CODVEN = :CODVEN ';
      strSQLSaida2 := strSQLSaida2 + 'AND DET_NUMDOC = :NUMDOC ';
      strSQLSaida2 := strSQLSaida2 + 'AND DET_ESPDOC  = :ESPDOC ';
      strSQLSaida2 := strSQLSaida2 + 'AND SUBSTRING(DET_CODFIS,2,2) IN("10","60","70", "90") ';
      strSQLSaida2 := strSQLSaida2 + 'AND LEFT(DET_CLAFIS,1) >= 5 ';
      strSQLSaida2 := strSQLSaida2 + 'GROUP BY DET_CLAFIS ';
      strSQLSaida2 := strSQLSaida2 + 'ORDER BY DET_CLAFIS, DET_CODFIS ';

      qryPortariaCat.SQL.Add(strSQLSaida1);
      qryPortariaCat.ParamByName('CODEMP').AsString  := strCodEmp;
      qryPortariaCat.ParamByName('CODVEN').AsString  := strCodVen;
      qryPortariaCat.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryPortariaCat.ParamByName('ESPDOC').AsString  := strTipDoc;
      qryPortariaCat.Open;

      if not qryPortariaCat.IsEmpty then
      begin
        while not qryPortariaCat.Eof do
        begin
          pGravaFisAju(fCfgSis('CCATSA'), qryPortariaCat.FieldByName('DET_CLAFIS').AsString + ' - ' + qryPortariaCat.FieldByName('CODFIS').AsString, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen, 1, qryPortariaCat.FieldByName('VALOR').AsFloat);
          qryPortariaCat.Next;
        end;
      end;

      qryPortariaCat.Close;
      qryPortariaCat.SQL.Clear;
      qryPortariaCat.SQL.Add(strSQLSaida2);
      qryPortariaCat.ParamByName('CODEMP').AsString  := strCodEmp;
      qryPortariaCat.ParamByName('CODVEN').AsString  := strCodVen;
      qryPortariaCat.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryPortariaCat.ParamByName('ESPDOC').AsString  := strTipDoc;
      qryPortariaCat.Open;

      if not qryPortariaCat.IsEmpty then
      begin
        while not qryPortariaCat.Eof do
        begin
          pGravaFisAju(strSubstituto_Substituido, qryPortariaCat.FieldByName('DET_CLAFIS').AsString + ' - ' + qryPortariaCat.FieldByName('CODFIS').AsString, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen, 2, qryPortariaCat.FieldByName('VALOR').AsFloat);
          qryPortariaCat.Next;
        end;
      end;
    end
    else if strEntSai  = 'E' then
    begin
      strSQLEntrada1 := strSQLEntrada1 + 'SELECT  DET_CLAFIS, ';
      strSQLEntrada1 := strSQLEntrada1 + 'SUM((CASE ';
      strSQLEntrada1 := strSQLEntrada1 + '  WHEN SUBSTRING(DET_CODFIS,2,2) = "20" THEN (DET_VLRCON - DET_BASICM) ';
      strSQLEntrada1 := strSQLEntrada1 + '  ELSE DET_VLRCON ';
      strSQLEntrada1 := strSQLEntrada1 + 'END)) AS VALOR, ';
      strSQLEntrada1 := strSQLEntrada1 + 'GROUP_CONCAT("x", SUBSTRING(DET_CODFIS,2,2) SEPARATOR "/") AS CODFIS ';
      strSQLEntrada1 := strSQLEntrada1 + 'FROM MOVDET ';
      strSQLEntrada1 := strSQLEntrada1 + 'WHERE DET_CODEMP = :CODEMP ';
      strSQLEntrada1 := strSQLEntrada1 + 'AND DET_CODVEN = :CODVEN ';
      strSQLEntrada1 := strSQLEntrada1 + 'AND DET_NUMDOC = :NUMDOC ';
      strSQLEntrada1 := strSQLEntrada1 + 'AND DET_ESPDOC  = :ESPDOC ';
      strSQLEntrada1 := strSQLEntrada1 + 'AND SUBSTRING(DET_CODFIS,2,2) IN("20","30","40", "41") ';
      strSQLEntrada1 := strSQLEntrada1 + 'AND LEFT(DET_CLAFIS,1) < 5 ';
      strSQLEntrada1 := strSQLEntrada1 + 'GROUP BY DET_CLAFIS ';
      strSQLEntrada1 := strSQLEntrada1 + 'ORDER BY DET_CLAFIS, DET_CODFIS ';

      strSQLEntrada2 := strSQLEntrada2 + 'SELECT  DET_CLAFIS, DET_VLRCON AS VALOR, ';
      strSQLEntrada2 := strSQLEntrada2 + 'GROUP_CONCAT("x", SUBSTRING(DET_CODFIS,2,2) SEPARATOR "/") AS CODFIS ';
      strSQLEntrada2 := strSQLEntrada2 + 'FROM MOVDET ';
      strSQLEntrada2 := strSQLEntrada2 + 'WHERE DET_CODEMP = :CODEMP ';
      strSQLEntrada2 := strSQLEntrada2 + 'AND DET_CODVEN = :CODVEN ';
      strSQLEntrada2 := strSQLEntrada2 + 'AND DET_NUMDOC = :NUMDOC ';
      strSQLEntrada2 := strSQLEntrada2 + 'AND DET_ESPDOC  = :ESPDOC ';
      strSQLEntrada2 := strSQLEntrada2 + 'AND SUBSTRING(DET_CODFIS,2,2) IN("10") ';
      strSQLEntrada2 := strSQLEntrada2 + 'AND LEFT(DET_CLAFIS,1) < 5 ';
      strSQLEntrada2 := strSQLEntrada2 + 'GROUP BY DET_CLAFIS ';
      strSQLEntrada2 := strSQLEntrada2 + 'ORDER BY DET_CLAFIS, DET_CODFIS ';

      qryPortariaCat.SQL.Add(strSQLEntrada1);
      qryPortariaCat.ParamByName('CODEMP').AsString  := strCodEmp;
      qryPortariaCat.ParamByName('CODVEN').AsString  := strCodVen;
      qryPortariaCat.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryPortariaCat.ParamByName('ESPDOC').AsString  := strTipDoc;
      qryPortariaCat.Open;

      if not qryPortariaCat.IsEmpty then
      begin
        while not qryPortariaCat.Eof do
        begin
          pGravaFisAju(fCfgSis('CCATE1'), qryPortariaCat.FieldByName('DET_CLAFIS').AsString + ' - ' + qryPortariaCat.FieldByName('CODFIS').AsString, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen, 3, qryPortariaCat.FieldByName('VALOR').AsFloat);
          qryPortariaCat.Next;
        end;
      end;

      qryPortariaCat.Close;
      qryPortariaCat.SQL.Clear;
      qryPortariaCat.SQL.Add(strSQLEntrada2);
      qryPortariaCat.ParamByName('CODEMP').AsString  := strCodEmp;
      qryPortariaCat.ParamByName('CODVEN').AsString  := strCodVen;
      qryPortariaCat.ParamByName('NUMDOC').AsString  := strNumDoc;
      qryPortariaCat.ParamByName('ESPDOC').AsString  := strTipDoc;
      qryPortariaCat.Open;

      if not qryPortariaCat.IsEmpty then
      begin
        while not qryPortariaCat.Eof do
        begin
          pGravaFisAju(fCfgSis('CCATE2'), qryPortariaCat.FieldByName('DET_CLAFIS').AsString + ' - ' + qryPortariaCat.FieldByName('CODFIS').AsString, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen, 4, qryPortariaCat.FieldByName('VALOR').AsFloat);
          qryPortariaCat.Next;
        end;
      end;
    end;

    Result := True;
  finally
    FreeAndNil(qryPortariaCat);
  end;
end;

procedure pGravaFisAju(strCodCAT, strCFOP, strNumDoc, strTipDoc, strForCli, strCodEmp, strCodVen: string; intTipGra: integer; fltValor: Double);
var
  qryFisAju: TUniQuery;
  strSQL, strAutInc: string;
  fltValorST, fltOutras: Double;
begin
  //intTipGra
  //1 -> SAÍDA CFOP x20, x30, x40, x41
  //2 -> SAÍDA CFOP x10, x60, x70, x90
  //3 -> ENTRADA CFOP x20, x30, x40, x41
  //4 -> ENTRADA CFOP x10

  try
    qryFisAju  := fCriaQuery(nil);

    case intTipGra of
      1,3:begin
        strAutInc := fBuscaAutoIncCADFIS(strNumDoc, strTipDoc, strForCli);

        strSQL := '';
        strSQL := strSQL + 'INSERT INTO FISAJU(AJU_SEQGER, AJU_CD_AJU, AJU_DESAJU, AJU_BASICM, AJU_ALQICM, AJU_VALICM, AJU_OUTROS, AUTOINCREM) ';
        strSQL := strSQL + 'VALUES(:SEQGER, :CDAJU, :DESAJU, :BASICM, :ALQICM, :VALICM, :OUTROS, :AUTOINCREM) ';

        qryFisAju.Close;
        qryFisAju.SQL.Clear;
        qryFisAju.SQL.Add(strSQL);
        qryFisAju.ParamByName('SEQGER').AsString := strAutInc;
        qryFisAju.ParamByName('CDAJU').AsString  := strCodCAT;
        qryFisAju.ParamByName('DESAJU').AsString := strCFOP;
        qryFisAju.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJU', VS_strCodEmp);
        qryFisAju.ParamByName('VALICM').Value := fltValor;
        qryFisAju.ExecSQL;
      end;
      2:begin
        strAutInc := fBuscaAutoIncCADFIS(strNumDoc, strTipDoc, strForCli);

        strSQL := '';
        strSQL := strSQL + 'INSERT INTO FISAJU(AJU_SEQGER, AJU_CD_AJU, AJU_DESAJU, AJU_BASICM, AJU_ALQICM, AJU_VALICM, AJU_OUTROS, AUTOINCREM) ';
        strSQL := strSQL + 'VALUES(:SEQGER, :CDAJU, :DESAJU, :BASICM, :ALQICM, :VALICM, :OUTROS, :AUTOINCREM) ';

        qryFisAju.Close;
        qryFisAju.SQL.Clear;
        qryFisAju.SQL.Add(strSQL);
        qryFisAju.ParamByName('SEQGER').AsString := strAutInc;
        qryFisAju.ParamByName('CDAJU').AsString  := strCodCAT;
        qryFisAju.ParamByName('DESAJU').AsString := strCFOP;
        qryFisAju.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJU', VS_strCodEmp);
        qryFisAju.ParamByName('OUTROS').Value := fltValor;
        qryFisAju.ExecSQL;
      end;
      4:begin
        pBuscaValoresCST10(strCodEmp, strCodVen, strNumDoc, strTipDoc, fltValorST, fltOutras);

        if fltValorST > 0 then
        begin
          strAutInc := fBuscaAutoIncCADFIS(strNumDoc, strTipDoc, strForCli);

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO FISAJU(AJU_SEQGER, AJU_CD_AJU, AJU_DESAJU, AJU_BASICM, AJU_ALQICM, AJU_VALICM, AJU_OUTROS, AUTOINCREM) ';
          strSQL := strSQL + 'VALUES(:SEQGER, :CDAJU, :DESAJU, :BASICM, :ALQICM, :VALICM, :OUTROS, :AUTOINCREM) ';

          qryFisAju.Close;
          qryFisAju.SQL.Clear;
          qryFisAju.SQL.Add(strSQL);
          qryFisAju.ParamByName('SEQGER').AsString := strAutInc;
          qryFisAju.ParamByName('CDAJU').AsString  := strCodCAT;
          qryFisAju.ParamByName('DESAJU').AsString := strCFOP;
          qryFisAju.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJU', VS_strCodEmp);
          qryFisAju.ParamByName('VALICM').Value := fltValorST;
          qryFisAju.ExecSQL;
        end;

        if fltOutras > 0 then
        begin
        strAutInc := fBuscaAutoIncCADFIS(strNumDoc, strTipDoc, strForCli);

          strSQL := '';
          strSQL := strSQL + 'INSERT INTO FISAJU(AJU_SEQGER, AJU_CD_AJU, AJU_DESAJU, AJU_BASICM, AJU_ALQICM, AJU_VALICM, AJU_OUTROS, AUTOINCREM) ';
          strSQL := strSQL + 'VALUES(:SEQGER, :CDAJU, :DESAJU, :BASICM, :ALQICM, :VALICM, :OUTROS, :AUTOINCREM) ';

          qryFisAju.Close;
          qryFisAju.SQL.Clear;
          qryFisAju.SQL.Add(strSQL);
          qryFisAju.ParamByName('SEQGER').AsString := strAutInc;
          qryFisAju.ParamByName('CDAJU').AsString  := fCfgSis('CCATE1');
          qryFisAju.ParamByName('DESAJU').AsString := strCFOP;
          qryFisAju.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJU', VS_strCodEmp);
          qryFisAju.ParamByName('OUTROS').Value := fltOutras;
          qryFisAju.ExecSQL;
        end;
      end;
    end;

  finally
    FreeAndNil(qryFisAju);
  end;
end;

function  fBuscaAutoIncCADFIS(strNumDoc, strTipoDoc, strForCli: string): string;
var
  qryAutoInc: TUniQuery;
  strSQL: string;
begin
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM CADFIS WHERE FIS_NUMDOC = :NUMDOC AND FIS_ESPDOC = :ESPDOC AND FIS_FORCLI = :FORCLI';

    qryAutoInc := fCriaQuery(nil);
    qryAutoInc.Close;
    qryAutoInc.SQL.Clear;
    qryAutoInc.SQL.Add(strSQL);
    qryAutoInc.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAutoInc.ParamByName('ESPDOC').AsString := strTipoDoc;
    qryAutoInc.ParamByName('FORCLI').AsString := strForCli;
    qryAutoInc.Open;

    Result := qryAutoInc.FieldByName('AUTOINCREM').AsString;
  finally
    FreeAndNil(qryAutoInc);
  end;
end;

procedure pBuscaValoresCST10(strCodEmp, strCodVen, strNumDoc, strTipDoc: string; var fltValorST, fltOutras: Double);
var
  qryValoresCST10: TUniQuery;
  strSQL: string;
begin
  try
    fltValorST := 0;
    fltOutras := 0;

    strSQL := '';
    strSQL  := strSQL + 'SELECT (D.DET_VALRET + T.DET_VAERET) AS VALOR, T.DET_OUTICM AS OUTRAS ';
    strSQL  := strSQL + 'FROM MOVDET D ';
    strSQL  := strSQL + 'INNER JOIN MOVTRI T ';
    strSQL  := strSQL + 'ON(D.AUTOINCREM = T.DET_SEQGER) ';
    strSQL  := strSQL + 'WHERE D.DET_CODEMP = :CODEMP AND D.DET_CODVEN = :CODVEN ';
    strSQL  := strSQL + 'AND D.DET_NUMDOC = :NUMDOC AND D.DET_ESPDOC = :ESPDOC ';

    qryValoresCST10 := fCriaQuery(nil);
    qryValoresCST10.Close;
    qryValoresCST10.SQL.Clear;
    qryValoresCST10.SQL.Add(strSQL);
    qryValoresCST10.ParamByName('CODEMP').AsString := strCodEmp;
    qryValoresCST10.ParamByName('CODVEN').AsString := strCodVen;
    qryValoresCST10.ParamByName('NUMDOC').AsString := strNumDoc;
    qryValoresCST10.ParamByName('ESPDOC').AsString := strTipDoc;
    qryValoresCST10.Open;

    if not qryValoresCST10.IsEmpty then
    begin
      fltValorST := qryValoresCST10.FieldByName('VALOR').AsFloat;
      fltOutras := qryValoresCST10.FieldByName('OUTRAS').AsFloat;
    end;
  finally
    FreeAndNil(qryValoresCST10);
  end;
end;

procedure pVinculaImportacaoDocumentoComEntrada(strSeqDet, strNumDoc, strEspDoc, strCodEmp, strCodFor,
                                                strSerie, strCodIte: string);
  var
    qryDoc: TUniQuery;

  procedure pSetParametros;
  Begin
    qryDoc.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDoc.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDoc.ParamByName('CODEMP').AsString := strCodEmp;
    qryDoc.ParamByName('CODFOR').AsString := strCodFor;
    qryDoc.ParamByName('SERIE_').AsString := strSerie;
    qryDoc.ParamByName('CODITE').AsString := strCodIte;
  End;

  function  fTemNaNotGer: boolean;
  Begin
    qryDoc.SQL.Clear;
    qryDoc.SQL.Add('SELECT COUNT(1) AS QTD FROM NOTGER');
    qryDoc.SQL.Add(' INNER JOIN NOTDET ON NOTDET.DET_SEQGER = NOTGER.AUTOINCREM');
    qryDoc.SQL.Add(' INNER JOIN DOCIMP  ON IMP_SEQDET = NOTDET.AUTOINCREM');
    qryDoc.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    qryDoc.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    qryDoc.SQL.Add('   AND GER_CODEMP = :CODEMP');
    qryDoc.SQL.Add('   AND GER_CODFOR = :CODFOR');
    qryDoc.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
    qryDoc.SQL.Add('   AND DET_CODITE = :CODITE');
    pSetParametros;
    qryDoc.Open;
    result := qryDoc.FieldByName('QTD').AsInteger > 0
  End;

  procedure pVinculaApartirNotDet;
  Begin
    qryDoc.SQL.Clear;
    qryDoc.SQL.Add('UPDATE NOTGER');
    qryDoc.SQL.Add(' INNER JOIN NOTDET ON NOTDET.DET_SEQGER = NOTGER.AUTOINCREM');
    qryDoc.SQL.Add(' INNER JOIN DOCIMP  ON IMP_SEQDET = NOTDET.AUTOINCREM');
    qryDoc.SQL.Add('   SET IMP_SQMVDT = ' + fQuotedStr(strSeqDet));
    qryDoc.SQL.Add('       , IMP_OLDNTD = IMP_SEQDET ');
    qryDoc.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    qryDoc.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    qryDoc.SQL.Add('   AND GER_CODEMP = :CODEMP');
    qryDoc.SQL.Add('   AND GER_CODFOR = :CODFOR');
    qryDoc.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
    qryDoc.SQL.Add('   AND DET_CODITE = :CODITE');
    pSetParametros;
    qryDoc.ExecSQL;
  End;

  Procedure pVinculaApartirMovDetDel;
  Begin
    qryDoc.SQL.Clear;
    qryDoc.SQL.Add('UPDATE DEL_MOVDET');
    qryDoc.SQL.Add(' INNER JOIN DOCIMP  ON IMP_SQMVDT = DEL_MOVDET.AUTOINCREM');
    qryDoc.SQL.Add('   SET IMP_SQMVDT = ' + fQuotedStr(strSeqDet));
    qryDoc.SQL.Add('       , IMP_OLDNTD = IMP_SEQDET ');
    qryDoc.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC');
    qryDoc.SQL.Add('   AND DET_ESPDOC = :ESPDOC');
    qryDoc.SQL.Add('   AND DET_CODEMP = :CODEMP');
    qryDoc.SQL.Add('   AND DET_CODFOR = :CODFOR');
    qryDoc.SQL.Add('   AND IFNULL(DET_SERIE_, "") = :SERIE_');
    qryDoc.SQL.Add('   AND DET_CODITE = :CODITE');
    pSetParametros;
    qryDoc.ExecSQL;
  End;

Begin
  If (fEmptyStr(strSeqDet)) Or (fEmptyStr(strCodIte)) Then
    Exit;
  qryDoc := fCriaQuery(nil);
  Try
    If fTemNaNotGer Then
      pVinculaApartirNotDet
    Else
      pVinculaApartirMovDetDel;
  Finally
    FreeAndNil(qryDoc);
  End;
End;

function fRetSQLComPro(arrItensDev: TArrItensDevolucao): String;
  var
    itemDev: TItemDevolucao;
Begin
  Result := '';
  For itemdev In arrItensDev Do
  Begin
    If Not fEmptyStr(Result) Then
      Result := Result + 'UNION ';
    Result := Result + 'SELECT COM_CODPRO ';
    Result := Result + '  FROM COMPRO ';
    Result := Result + ' WHERE COM_NUMDOC = ' + QuotedStr(itemDev.strDocumento);
    Result := Result + '   AND COM_ESPDOC = ' + QuotedStr(itemDev.strEspecie);
    Result := Result + '   AND COM_CODEMP = ' + QuotedStr(itemDev.strEmpresa);
  End;

  If Not fEmptyStr(Result) Then
    Result := Result + ' ORDER BY COM_CODPRO ';
End;

function fBaixaPedidosAtendidosDepoisDaEntrada(strAutoincMovDet: String): Boolean;
var
  oleItensPedidos: OleVariant;
  blnBaiPed: Boolean;
  qryConsulta, qryEntMer: TUniQuery;
  cdsPedidos: TUniClientDataSet;
  strCnvEmb, strAutEle, strSQL: String;

  procedure pCriaEntmer;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM, ';
    strSQL := strSQL + '       DET_CODITE AS ENT_CODITE, ';
    strSQL := strSQL + '       DET_QTDITE AS ENT_QTDITE, ';
    strSQL := strSQL + '       DET_NUMLOT AS ENT_NUMLOT, ';
    strSQL := strSQL + '       DET_UNITAR AS ENT_UNITAR, ';
    strSQL := strSQL + '       TRI_EMBALA AS ENT_EMBALA, ';
    strSQL := strSQL + '       DET_ALQIPI AS ENT_PERIPI, ';
    strSQL := strSQL + '       DET_ALQRET AS ENT_PERSUB, ';

    strSQL := strSQL + '       DET_NUMDOC, ';
    strSQL := strSQL + '       DET_CODEMP, ';
    strSQL := strSQL + '       DET_CODFOR, ';
    strSQL := strSQL + '       DET_ESPDOC,  ';
    strSQL := strSQL + '       DET_SERIE_  ';


    strSQL := strSQL + '  FROM MOVDET  ';
    strSQL := strSQL + ' INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + ' WHERE MOVDET.DET_SEQGER = ' + fQuotedStr(strAutoincMovDet);        // 00700000000001620004
    qryEntMer := fCriaQuery;
    qryEntMer.SQL.Text := strSQL;
    qryEntMer.Open;
  End;

  Function fCarregaAutoIncremNotaFiscal: String;
  Begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT AUTOINCREM');
    qryConsulta.SQL.Add('  FROM  GERELE');
    qryConsulta.SQL.Add(' WHERE GER_DOCENT = :NUMDOC');
    qryConsulta.SQL.Add('   AND GER_EMPENT = :EMPENT');
    qryConsulta.SQL.Add('   AND GER_CODFOR = :CODFOR');
    qryConsulta.SQL.Add('   AND GER_ESPENT = :ESPENT');
    qryConsulta.ParamByName('NUMDOC').Value := qryEntMer.FieldByName('DET_NUMDOC').AsString;
    qryConsulta.ParamByName('EMPENT').Value := qryEntMer.FieldByName('DET_CODEMP').AsString;
    qryConsulta.ParamByName('CODFOR').Value := qryEntMer.FieldByName('DET_CODFOR').AsString;
    qryConsulta.ParamByName('ESPENT').Value := qryEntMer.FieldByName('DET_ESPDOC').AsString;
    qryConsulta.Open;
    If qryConsulta.IsEmpty Then
      Exit;

   Result := qryConsulta.FieldByName('AUTOINCREM').AsString;
  End;

Begin
  Try
    Result := False;
    strCnvEmb := fCfgSis('CNVEMB');

    Try

      qryConsulta := fCriaQuery;
      pCriaEntmer;
      strAutEle := fCarregaAutoIncremNotaFiscal;
      oleItensPedidos := fDefinePedidosABaixar(blnBaiPed,
                                                qryEntMer,
                                                nil,
                                                strAutEle,
                                                False,
                                                False,
                                                Nil,
                                                'AUTOINCREM',
                                                True,
                                                strAutoincMovDet);


      cdsPedidos := TUniClientDataSet.Create(nil);
      cdsPedidos.Data := oleItensPedidos;

      If blnBaiPed Then
        Result := fBaixaPedidos(oleItensPedidos, cdsPedidos);

    Finally
      FreeAndNil(qryEntMer);
      FreeAndNil(cdsPedidos);
      FreeAndNil(qryConsulta);
    End;
  Except
    Result := False
  End;
End;

function fItemJaProcessado(strIncGae, strIncGad: String): Boolean;
var qrySQL: TUniQuery;
begin
  qrySQL := fCriaQuery;
  Try
    qrySQL.SQL.Add('SELECT COUNT(1) AS QTD FROM MOVGAU');
    qrySQL.SQL.Add(' WHERE GAU_SEQGAD = :SEQGAD');
    qrySQL.SQL.Add('   AND GAU_SEQGAE = :SEQGAE');
    qrySQL.ParamByName('SEQGAD').AsString := strIncGad;
    qrySQL.ParamByName('SEQGAE').AsString := strIncGae;
    qrySQL.Open;
    Result := qrySQL.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qrySQL);
  End;
End;

function fRetHistoricoRetencao(dtsCadFis: TDataSet;  fltTotDoc: Double): String;
var strHistoricoRentecao: String;
    strLinha: String;
Begin
  If Not Assigned(dtsCadFis) Then
    Exit('');

  If dtsCadFis.FieldByName('FIS_VREPIS').AsFloat +
     dtsCadFis.FieldByName('FIS_VRECOF').AsFloat +
     dtsCadFis.FieldByName('FIS_RECSSL').AsFloat +
     dtsCadFis.FieldByName('FIS_REIRRF').AsFloat +
     dtsCadFis.FieldByName('FIS_REINSS').AsFloat +
     dtsCadFis.FieldByName('FIS_RETISS').AsFloat = 0 Then
    Exit('');

  strLinha := StringOfChar(' ', 100);
  System.Insert('Vr. Serviço.......:', strLinha, 1);
  System.Insert(fPadL(FormatFloat('#0.00', fltTotDoc), 15), strLinha, 21);
  strHistoricoRentecao := Copy(strLinha, 1 , 36);



  If dtsCadFis.FieldByName('FIS_VREPIS').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de PIS...:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_VREPIS').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_VREPIS').AsFloat;
  End;

  If dtsCadFis.FieldByName('FIS_VRECOF').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de COFINS:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_VRECOF').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_VRECOF').AsFloat;
  End;
  If dtsCadFis.FieldByName('FIS_RECSSL').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de CSSL..:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_RECSSL').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_RECSSL').AsFloat;
  End;
  If dtsCadFis.FieldByName('FIS_REIRRF').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de IRRF..:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_REIRRF').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_REIRRF').AsFloat;
  End;
  If dtsCadFis.FieldByName('FIS_REINSS').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de INSS..:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_REINSS').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_REINSS').AsFloat;
  End;
  If dtsCadFis.FieldByName('FIS_RETISS').AsFloat > 0 Then
  Begin
    strLinha := StringOfChar(' ', 100);
    System.Insert('Retenção de ISS...:', strLinha, 1);
    System.Insert(fPadL(FormatFloat('#0.00', dtsCadFis.FieldByName('FIS_RETISS').AsFloat), 15), strLinha, 21);
    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
    fltTotDoc := fltTotDoc - dtsCadFis.FieldByName('FIS_RETISS').AsFloat;
  End;

  strHistoricoRentecao := strHistoricoRentecao + #$A#$D + 'Vr.Líquido........: ' + fPadL(FormatFloat('#0.00', fltTotDoc), 15);
  Result := strHistoricoRentecao;
End;

procedure pCarregarDuplicataAReceberParaRetornoConsignacao(const AIdGerEle, AstrNumeroDocumento, AstrEspecieDocumento, AstrEmpresaDocumento, AstrCodigoCliFor, AstrTip_FC : String; var arrDuplicata: TarrDuplicata);
  var
    LQuery       : TUniQuery;
    intNumDupEle : Integer;
Begin
  intNumDupEle := 0;

  LQuery := fCriaQuery;
  Try

    if not fEmptyStr(AIdGerEle) then
    Begin
      LQuery.Sql.Text := 'SELECT W07_VPROD AS VALOR, B09_DEMI AS DATA_EMISSAO, B08_NNF AS DUPLICATA FROM GERELE WHERE AUTOINCREM = :AUTINC ';
      LQuery.ParamByName('AUTINC').AsString := AIdGerEle;
      LQuery.Open;
    End
    else
    Begin
      LQuery.Sql.Text := 'SELECT GER_VLRCON AS VALOR, GER_DTAENT AS DATA_EMISSAO, GER_NUMDOC AS DUPLICATA '+
                         '  FROM MOVGER '+
                         ' WHERE GER_NUMDOC = :NUMDOC '+
                         '   AND GER_ESPDOC = :ESPDOC '+
                         '   AND GER_CODEMP = :CODEMP '+
                         '   AND '+IIF(AstrTip_FC = 'C','GER_CODCLI', 'GER_CODFOR')+' = :CLIFOR ';

      LQuery.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
      LQuery.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
      LQuery.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
      LQuery.ParamByName('CLIFOR').AsString := AstrCodigoCliFor;
      LQuery.Open;
    End;

    pZeraDigDuplic(arrDuplicata);

    arrDuplicata[LQuery.RecNo - 1].intNumDup   := intNumDupEle;
    arrDuplicata[LQuery.RecNo - 1].strSequen   := 'A';
    arrDuplicata[LQuery.RecNo - 1].curValor    := LQuery.FieldByName('VALOR').AsFloat;
    arrDuplicata[LQuery.RecNo - 1].dtaDtaVen   := DateToStr(LQuery.FieldByName('DATA_EMISSAO').AsDateTime);
    arrDuplicata[LQuery.RecNo - 1].strNFNumDup := LQuery.FieldByName('DUPLICATA').AsString;
    arrDuplicata[LQuery.RecNo - 1].strUsaChq   := 'N';
    arrDuplicata[LQuery.RecNo - 1].strHist02   := '';

    LQuery.Close;

  Finally
    FreeAndNil(LQuery);
  End;
End;

procedure pLocalizaDocumentoOrigem(AstrNumped, AStrCodemp, AstrEspDoc, AStrCodAca: String; var strNumPed: String; var strCodEmp:String;  var strEspDoc: string);
var qryConsulta: TUniquery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT DET_NUMDOC, DET_ESPDOC, DET_CODEMP FROM MOVDET');
    qryConsulta.SQL.Add(' WHERE DET_NUMFAT = :NUNFAT');
    qryConsulta.SQL.Add('   AND DET_EMPFAT = :EMPFAT');
    qryConsulta.SQL.Add('   AND DET_TIPFAT = :TIPFAT');
    qryConsulta.SQL.Add('   AND DET_CODACA = :CODITE');
    qryConsulta.SQL.Add('   AND DET_ESPDOC NOT IN ("ML","TM", "PR", "RO")  ');

    qryConsulta.ParamByName('NUNFAT').AsString := AstrNumped;
    qryConsulta.ParamByName('EMPFAT').AsString := AStrCodemp;
    qryConsulta.ParamByName('TIPFAT').AsString := AstrEspDoc;
    qryConsulta.ParamByName('CODITE').AsString := AStrCodAca;

    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
    Begin
      strNumPed := AstrNumped;
      strCodEmp := AStrCodemp;
      strEspDoc := AstrEspDoc;
    End
    Else
    Begin
      strNumPed := qryConsulta.FieldByName('DET_NUMDOC').AsString;
      strCodEmp := qryConsulta.FieldByName('DET_CODEMP').AsString;
      strEspDoc := qryConsulta.FieldByName('DET_ESPDOC').AsString;
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;


function fTemMamoreNaEntrada: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM TMP_ENTMER WHERE ENT_GRAMAR = "S"');
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0
  Finally
    FreeAndNil(qryConsulta);
  End;

end;


function  fGravaCALGNR(qryEntMer: TDataSet; strAutIncTmp: String): Boolean;
var qryComand: TUniQuery;
  LMemCal: String;
  LValGNRDetEle: Double;
  LValGNRMovTri: Double;
begin
  Result := True;
  If (qryEntMer.FieldByName('ENT_PREGNR').AsString  =  'S') And
     Assigned(qryEntMer.FindField('CAL_VLICMS')) then
  begin
    Try
      LValGNRDetEle := fCampoTabela('IFNULL(DET_VLRGNR, 0) AS DET_VALGNR', 'DETELE', ['AUTOINCREM'], [qryEntMer.FieldByName('ENT_DETELE').AsString]);
      LValGNRMovTri := fCampoTabela('IFNULL(DET_VLGNRE, 0) AS DET_VLGNRE', 'MOVTRI', ['DET_SEQGER'], [strAutIncTmp]);

      If (qryEntMer.FieldByName('ENT_VALGNR').AsFloat > 0) And
          ((qryEntMer.FieldByName('ENT_VALGNR').AsFloat <> LValGNRDetEle) And (qryEntMer.FieldByName('ENT_VALGNR').AsFloat <> LValGNRMovTri)) Then
        LMemCal := MSG_VLR_GNR_MANUAL
      Else
        LMemCal := qryEntMer.FieldByName('ENT_CALGNR').AsString;

      If (LValGNRDetEle = 0) And (LValGNRMovTri = 0) Then
        LMemCal := '';

      qryComand := fCriaQuery;
      Try

        qryComand.SQl.Add('INSERT INTO CALGNR(DET_SEQDET,  CAL_VLICMS,  CAL_BASICM,  CAL_ALQICM,  CAL_BAS_ST,  CAL_VR_IVA,  CAL_VR_SUB,  CAL_ALQINT, CAL_VFCPST, CAL_MEMCAL) VALUES ');
        qryComand.SQl.Add('                  (:DET_SEQDET,  :CAL_VLICMS,  :CAL_BASICM,  :CAL_ALQICM,  :CAL_BAS_ST,  :CAL_VR_IVA,  :CAL_VR_SUB,  :CAL_ALQINT, :CAL_VFCPST, :CAL_MEMCAL)');
        qryComand.ParamByName('DET_SEQDET').AsString := strAutIncTmp;
        qryComand.ParamByName('CAL_VLICMS').AsFloat :=  qryEntMer.FieldByName('CAL_VLICMS').AsFloat;
        qryComand.ParamByName('CAL_BASICM').AsFloat :=  qryEntMer.FieldByName('CAL_BASICM').AsFloat;
        qryComand.ParamByName('CAL_ALQICM').AsFloat :=  qryEntMer.FieldByName('CAL_ALQICM').AsFloat;
        qryComand.ParamByName('CAL_BAS_ST').AsFloat :=  qryEntMer.FieldByName('CAL_BAS_ST').AsFloat;
        qryComand.ParamByName('CAL_VR_IVA').AsFloat :=  qryEntMer.FieldByName('CAL_VR_IVA').AsFloat;
        qryComand.ParamByName('CAL_VR_SUB').AsFloat :=  qryEntMer.FieldByName('CAL_VR_SUB').AsFloat;
        qryComand.ParamByName('CAL_ALQINT').AsFloat :=  qryEntMer.FieldByName('CAL_ALQINT').AsFloat;
        qryComand.ParamByName('CAL_VFCPST').AsFloat :=  qryEntMer.FieldByName('CAL_VFCPST').AsFloat;
        qryComand.ParamByName('CAL_MEMCAL').AsString:=  LMemCal;
        qryComand.ExecSQL;
      Finally
        FreeAndNil(qryComand);
      End;
    Except
      on e:Exception do
      begin
        pMensagensErro(e.message,'[untPcmGer.fGravaCALGNR]' );
        Result := False;

      End;
    End;
  End;

end;

procedure pProcessaPrecoDeVendaEMargem(blnNotaImp: Boolean;
                                       qryEntMer: TDataSet;
                                       Var cdsPrecosEntMer: TDataSet;
                                       cdsMovGad: TUniClientDataSet;
                                       blnConEqu: Boolean;
                                       strAutEle,
                                       strNumDoc,
                                       strCodFor,
                                       strSerie: String;
                                       fltCotDol: Double;
                                       objAtuFor: TAlteraFornecedorEntrada;
                                       objEntAuto: TEntradaAutomatizada = Nil;
                                       blnPrecoPraticado: Boolean = False;
                                       strNaoAtu: String = '';
                                       blnEncargosNoFrete: Boolean = False;
                                       blnGarantia: Boolean = False;
                                       blnRecCliGarantia: Boolean = False;
                                       AblnAcessadoViaRetornoConsignacao : Boolean = False;
                                       tpFinalidadeXML: tpeFinalidadeXML = xmlEntradaMercadoria;
                                       strEmpresaDeposito: String = '');

  var
    CalcResult: TResultPisCofins;
    blnOutDesEntraNoprecoCompra: boolean;
    fltSaldosPreMed,
    fltPreMed,
    fltTotUlt,
    fltPreUlt,
    fltPreUltImp,
    fltIcmMed,
    fltImpUlt,
    fltAlqRet,
    fltTotAlqPis,
    fltTotAlqCof,
    fltPreCom,
    fltPreCus,
    fltComLot,
    fltCusLot,
    fltPreComAux,
    fltAlqPisCofPreUlt,
    fltPrecomOri,
    fltUniImp: Double;
    dtaDtaEnt: TDateTime;
    cpcParams: TParCalculaPrecoCusto;
    strMedEmp,
    strForFil,
    strEmpMeds,
    strTipFor,
    strEspDoc,
    strSimPau,
    strAtuNMD,
    strCnvEmb,
    strClaFisDet,
    strClaFisBonificacao,
    strCodEmp: String;
    blnATPVMB: TarrATPVMB;
    recPrecos,
    recPreLot: TarrPrecos;
    blnContribuinteIPI,
    blnDevolu,
    blnAtpRau,
    blnUltPis,
    blnAltPre,
    blnAtpRen,
    blnMedSe2,
    blnSepICM,
    blnAlteraPrecos,
    blnUsaLotePrecos,
    blnAltLot,
    blnAtualizouPreco,
    blnAtuMed,
    blnAtuUlt,
    blnAtualizouPrecoMedio,
    blnConferenciaDepoisDaEntrada,
    blnAtuFre,
    blnDedIcm: Boolean;
    objLotePrecos: TLotePrecos;
    intTabPre,
    intDecUni,
    intTab: Integer;
    cds: TZClient;
    qryConIte: TUniQuery;

    fltValorFreteCalc,
    fltValorFreConCalc: Double;
    CalculoPrecoMediAgrup: TCalculoPrecoMediAgrup;

  function fItem(strCampo: String): TField;
  begin
    Result := qryConIte.FieldByName('ITE_' + strCampo);
  end;

  function fHouveAlteracaoComposicaoPreco: Boolean;
      Var
        intAux, intAuxFinal: Integer;
    begin
      Result := (blnAtuFre And ((fItem('FREENT').AsFloat <> fFormataFloat(qryEntMer.FieldByName('ENT_FREENT').AsFloat, 3)) Or
                                (fItem('VALFRE').AsFloat <> fFormataFloat(qryEntMer.FieldByName('ENT_FREITE').AsFloat, 3)))) Or
                (fItem('PRECOM').AsFloat <> fFormataFloat(IIF(blnUsaLotePrecos,fltComLot, fltPreCom), 3)) Or
                (fItem('PRECUS').AsFloat <> fFormataFloat(IIF(blnUsaLotePrecos,fltCusLot, fltPreCus), 3));

      If Not Result Then
      Begin
        If blnUsaLotePrecos Then
          intAuxFinal := Length(recPreLot)
        Else
          intAuxFinal := Length(recPrecos);

        For intAux := 1 To intAuxFinal Do
        Begin
          If (VS_strTabPrc[intAux] = 'S') Then
          Begin
           If (fItem('PREVE' + IntToStr(intAux)).AsFloat <> fFormataFloat(IIF(blnUsaLotePrecos,recPreLot[intAux].fltPreVen,recPrecos[intAux].fltPreVen), 4)) Or
               (fItem('MARBR' + IntToStr(intAux)).AsFloat <> fFormataFloat(IIF(blnUsaLotePrecos,recPreLot[intAux].fltMarBru,recPrecos[intAux].fltMarBru), fRetPrecisaoMargemItem)) Then
            Begin
              Result := True;
              Break;
            End;
          End;
        End;
      End;

    end;

    function fEnt_FreRpaE: Double;
    begin
      if Assigned(qryEntMer.FindField('ENT_FRERPA')) then
        Result := qryEntMer.FieldByName('ENT_FRERPA').AsFloat
      else
        Result := 0;
    end;

Begin
  cpcParams  := TParCalculaPrecoCusto.Create(nil, TConfiguracao.fGetConfiguracao);
  strMedEmp := fCfgSis('MEDEMP', varString);

  fltTotAlqPis := 0;
  fltTotAlqCof := 0;
  fltAlqPisCofPreUlt := 0;
  CalculoPrecoMediAgrup := TCalculoPrecoMediAgrup.Create;

  Try
    strTipFor := fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);
    blnAtpRau := fCfgSis('ATPRAU', varBoolean);
    strCnvEmb := fCfgSis('CNVEMB');
    blnAtpRen := fCfgSis('ATPREN', varBoolean);
    blnMedSe2 := fCfgSis('MEDSE2', varBoolean);
    blnConferenciaDepoisDaEntrada := fConferenciaDepoisDaEntrada And (Not fEmptyStr(strAutEle)) And fEmptyStr(strEmpresaDeposito);
    intDecUni := fCfgSis('DECUNI', varInteger);
    blnAtuMed := fCfgSis('ATUMED', varBoolean);
    blnAtuUlt := fCfgSis('ATUULT', varBoolean);
    blnDevolu := False;
    blnSepICM := fSeparaICMDesoneradoDoDesconto;
    blnAlteraPrecos := (fCfgSis('EXITCU', varBoolean));
    strSimPau := IIf((fCfgSis('SIMPAU',varString) = 'S') and (fCfgSis('IGNSIM') = '1'), 'S', 'N') ;
    strForFil        := fRetForFilialTodos;
    strAtuNMD := fCfgSis('ATUNMD');
    strClaFisBonificacao := fRetornarClassificacoesBonificacaoEntrada;
    strCodEmp := VS_strCodEmp;

    qryConIte := fCriaQuery;

    If Not Assigned(objEntAuto) Then
    Begin
      pCarregaItens(strCodEmp, qryConIte, fltCotDol);
      Application.ProcessMessages;
    End;

    If (Pos(strCodFor, strForFil) > 0) Then
      blnUltPis := fRetForFilialDeduzPisCofinsUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnUltPis := fCfgSis('ULTPIS', VarBoolean);

    If (Pos(strCodFor, strForFil) > 0) Then
      blnDedIcm := fRetForFilialDeduzICMSUltimaCompra(VS_strCodEmp, strCodFor)
    Else
      blnDedIcm := fCfgSis('DEDICM', VarBoolean);

     For intTabPre := 1 to 7 Do
      blnAtpVmb[intTabPre] := (fCfgSis( IIF( intTabPre = 1, 'ATPVMB', 'ATPVM' + IntToStr(intTabPre) )) = 'P');

    qryEntMer.First;
    while not qryEntMer.Eof do
    begin
      strClaFisDet := qryEntMer.FieldByName('ENT_CLAFIS').AsString;

      fltUniImp := (qryEntMer.FieldByName('ENT_TOTITE').AsFloat - qryEntMer.FieldByName('ENT_DESESP').AsFloat);
      If qryEntMer.FieldByName('ENT_QTDITE').AsFloat > 0 Then
        fltUniImp := (fltUniImp / qryEntMer.FieldByName('ENT_QTDITE').AsFloat)
      Else
        fltUniImp := 0.0;

       fltUniImp := fFormataFloat(fltUniImp, 4);


       fltTotUlt := ( qryEntMer.FieldByName('ENT_TOTITE').AsFloat - qryEntMer.FieldByName('ENT_DESESP').AsFloat );
       fltPreUlt := fltTotUlt / qryEntMer.FieldByName('ENT_QTDITE').AsFloat;

       fltPreMed := 0.0;

       If (fEmptyStr(qryEntMer.FieldByName('ENT_CODACA').AsString)) And (strTipFor <> 'M') And
          (RoundTo(qryEntMer.FieldByName('ENT_TOTITE').AsFloat - qryEntMer.FieldByName('ENT_DESESP').AsFloat, -2) > 0) Then
       Begin
          If (Pos(strCodFor, strForFil) <= 0) OR ((Pos(strCodFor, strForFil) > 0) And (fCfgSis('TRDPCI') = 'S')) Then
            fltIcmMed := IIF((fFormataFloat(qryEntMer.FieldByName('ENT_TOTITE').AsFloat, 2) <> fFormataFloat(qryEntMer.FieldByName('ENT_BASICM').AsFloat, 2)),
                                            fFormataFloat((qryEntMer.FieldByName('ENT_VALICM').AsFloat / (qryEntMer.FieldByName('ENT_TOTITE').AsFloat - qryEntMer.FieldByName('ENT_DESESP').AsFloat)) * 100, 2),
                                            qryEntMer.FieldByName('ENT_ALQICM').AsFloat + qryEntMer.FieldByName('ENT_PERFCP').AsFloat)
          Else
            fltIcmMed := 0;

          If strMedEmp = '1' Then
            fltSaldosPreMed := fSaldoEmpresas(qryEntMer.FieldByName('ENT_CODITE').AsString, strEmpMeds)
          Else
            fltSaldosPreMed := fItem('SALDOS').AsFloat;

          {*************************************************************}
          {* CONFIGURAÇÃO QUE PERMITE UTILIZAR O ÚLTIMO PRECO DE       *}
          {* COMPRA PARA FORMAÇÃO DO PRECO MÉDIO DO PRODUTO            *}
          {**************************** 22/07/09**************** AM ****}
          Try
            CalculoPrecoMediAgrup.strCodIteAtual := qryEntMer.FieldByName('ENT_CODITE').AsString;
            If (fCfgSis('BASMED') <> 'S') Then
              fltPreMed := fCalculaPrecoMedio( qryEntMer.FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                             qryEntMer.FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                             fItem('PREMED').AsFloat,                     // Preço medio anterior
                                             fltSaldosPreMed,                     // Saldo anterior
                                             qryEntMer.FieldByName('ENT_QTDITE').AsFloat,           // Quantidade de entrada
                                             fltUniImp,                                   // Unitario sem impostos
                                             fltIcmMed,                                  // Aliquota de ICMS do Item
                                             qryEntMer.FieldByName('ENT_VALIPI').AsFloat +
                                             qryEntMer.FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                             qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                                             qryEntMer.FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                             qryEntMer.FieldByName('ENT_VALANT').AsFloat + qryEntMer.FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                             qryEntMer.FieldByName('ENT_VALGNR').AsFloat,
                                             qryEntMer.FieldByName('ENT_VLTCIF').AsFloat,
                                             qryEntMer.FieldByName('ENT_VAL_TS').AsFloat,

                                             blnContribuinteIPI,                          // Contribuinte de IPI?
                                             (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                             qryEntMer.FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                             qryEntMer.FieldByName('ENT_VALFRE').AsFloat +          // VALOR DO FRETE
                                             qryEntMer.FieldByName('ENT_FRECON').AsFloat +
                                             fEnt_FreRpaE,
                                             qryEntMer.FieldByName('ENT_OUTDES').AsFloat +
                                             qryEntMer.FieldByName('ENT_VENDOR').AsFloat +
                                             qryEntMer.FieldByName('ENT_DESACE').AsFloat,

                                             qryEntMer.FieldByName('ENT_VALICM').AsFloat + qryEntMer.FieldByName('ENT_VALFCP').AsFloat,

                                             IIF((qryEntMer.FieldByName('ENT_VALICM').AsFloat + qryEntMer.FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                 0,
                                                 qryEntMer.FieldByName('ENT_ICMXML').AsFloat + qryEntMer.FieldByName('ENT_FCPXML').AsFloat),

                                             qryEntMer.FieldByName('ENT_VFCPST').AsFloat,
                                             qryEntMer.FieldByName('ENT_ICMCFR').AsFloat,
                                             CalculoPrecoMediAgrup,
                                             qryEntMer.FieldByName('ENT_VAEIPI').AsFloat > 0)
            Else
              fltPreMed := fCalculaPrecoMedio( qryEntMer.FieldByName('ENT_CODFIS').AsString,        // Código Fiscal
                                             qryEntMer.FieldByName('ENT_CLAFIS').AsString,          // Classificação Fiscal
                                             fItem('PRECOM').AsFloat,                     // Preço compra anterior
                                             fltSaldosPreMed,                             // Saldo anterior
                                             qryEntMer.FieldByName('ENT_QTDITE').AsFloat,           // Quantidade de entrada
                                             fltUniImp,                                   // Unitario sem impostos
                                             fltIcmMed,                                   // Aliquota de ICMS do Item
                                             qryEntMer.FieldByName('ENT_VALIPI').AsFloat +
                                             qryEntMer.FieldByName('ENT_VAEIPI').AsFloat,           // Valor do IPI

                                             qryEntMer.FieldByName('ENT_VALRET').AsFloat +
                                             qryEntMer.FieldByName('ENT_VAERET').AsFloat,           // Valor de Substituição

                                             qryEntMer.FieldByName('ENT_VALANT').AsFloat + qryEntMer.FieldByName('ENT_VAFRAN').AsFloat,           // Valor ICMS Antecipado

                                             qryEntMer.FieldByName('ENT_VALGNR').AsFloat,
                                             qryEntMer.FieldByName('ENT_VLTCIF').AsFloat,
                                             qryEntMer.FieldByName('ENT_VAL_TS').AsFloat,

                                             blnContribuinteIPI,                          // Contribuinte de IPI?
                                             (Pos(strCodFor, strForFil) > 0),    // Fornecedor Filial

                                             qryEntMer.FieldByName('ENT_INCPIS').AsString,          // Indice se incide Pis
                                             qryEntMer.FieldByName('ENT_VALFRE').AsFloat +
                                             qryEntMer.FieldByName('ENT_FRECON').AsFloat +
                                             fEnt_FreRpaE,
                                             qryEntMer.FieldByName('ENT_OUTDES').AsFloat +
                                             qryEntMer.FieldByName('ENT_VENDOR').AsFloat +
                                             qryEntMer.FieldByName('ENT_DESACE').AsFloat,           // VALOR DO FRETE

                                             qryEntMer.FieldByName('ENT_VALICM').AsFloat + qryEntMer.FieldByName('ENT_VALFCP').AsFloat,

                                             IIF((qryEntMer.FieldByName('ENT_VALICM').AsFloat + qryEntMer.FieldByName('ENT_VALFCP').AsFloat) > 0,
                                                 0,
                                                 qryEntMer.FieldByName('ENT_ICMXML').AsFloat + qryEntMer.FieldByName('ENT_FCPXML').AsFloat),

                                             qryEntMer.FieldByName('ENT_VFCPST').AsFloat,
                                             qryEntMer.FieldByName('ENT_ICMCFR').AsFloat,
                                             CalculoPrecoMediAgrup,
                                             qryEntMer.FieldByName('ENT_VAEIPI').AsFloat > 0);

          Except

            On E: Exception Do
            Begin
              If Pos('preço médio', E.Message) > 0 Then
                 Raise Exception.Create('Item ' + qryEntMer.FieldByName('ENT_CODITE').AsString + ': ' + E.Message)
              Else Raise;
            End;

          End;

       End;

       dtaDtaEnt := 0;

       pCalculaPreUltImp(blnNotaImp,
                         qryEntMer,
                          strCodEmp,
                          strCodFor,
                          strEspDoc,
                          strSimPau,
                          strTipFor,
                          dtaDtaEnt,
                          False,
                          blnConEqu,
                          blnUltPis,
                          blnDedIcm,
                          blnPrecoPraticado,
                          False,
                          (Pos(strCodFor, strForFil) > 0),
                          CalcResult,
                          fltPreUltImp,
                          fltImpUlt,
                          fltAlqRet,
                          fltTotAlqPis,
                          fltTotAlqCof,
                          fltAlqPisCofPreUlt,
                          fltValorFreteCalc,
                          fltValorFreConCalc);

       pRecalculaPrecosEntrada(qryEntMer,
                               qryConIte,
                               fltPreMed,
                               fltPreUlt,
                               fltPreUltImp,
                               fltPreCom,
                               fltPreCus,
                               fltPrecomOri,
                               recPrecos,
                               blnAltPre,
                               cpcParams,
                               blnOutDesEntraNoprecoCompra,
                               strCodFor,
                               strForFil,
                               strEspDoc,
                               strAtuNMD,
                               strNaoAtu,
                               strCnvEmb,
                               strTipFor,
                               blnAtpRau,
                               blnAtpRen,
                               blnMedSe2,
                               objAtuFor,
                               blnAtpVmb,
                               intDecUni,
                               blnEncargosNoFrete);

      If ((fAtualizaItem(strTipFor, blnAtpRau, qryEntMer.FieldByName('ENT_CODITE').AsString, objAtuFor) And ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen)) Or
          (blnAlteraPrecos And
            SameText(qryEntMer.FieldByName('ENT_CODITE').AsString, qryEntMer.FieldByName('ENT_ITE_F5').AsString))) And
          blnUsaLotePrecos And
          {*Qualquer tipo de garantia nao muda preço*}
          ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) And (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
      Begin
        recPreLot := recPrecos;

        If CharInSet(strAtuNMD[1] , ['O', 'C']) Then
        Begin

          If blnSepICM Then
            fltComLot := fltPreCom - (qryEntMer.FieldByName('ENT_DESESP').AsFloat - qryEntMer.FieldByName('ENT_DESPIS').AsFloat - qryEntMer.FieldByName('ENT_VICMDE').AsFloat) / qryEntMer.FieldByName('ENT_QTDITE').AsFloat
          Else
            fltComLot := fltPreCom - qryEntMer.FieldByName('ENT_DESESP').AsFloat / qryEntMer.FieldByName('ENT_QTDITE').AsFloat

        End Else
          fltComLot := fltPreCom;

        With cpcParams Do
        fltComLot := objLotePrecos.fCalculaPrecoCompraBruto(fltComLot,
                                                           [curDesF01, curDesF02, curDesF03,
                                                            curDesF04, curDesF05, curDesF06]);
        pRecalculaPrecos(recPreLot,
                         fltCusLot,
                         blnAltLot,
                         cpcParams,
                         fltComLot,
                         qryConIte,
                         qryEntMer,
                         (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(qryEntMer.FieldByName('ENT_CODITE').AsString)),
                         blnATPVMB);
      End;

      If (strTipFor <> 'M') And
         (Pos(qryEntMer.FieldByName('ENT_CLAFIS').AsString, '1922_2922_') <= 0) And
         (Not blnDevolu) And (Not blnConEqu) And (fEmptyStr(qryEntMer.FieldByName('ENT_CODACA').AsString)) And
         (((Pos(strClaFisDet, VS_strClaCom + '_1116_2116_1117_2117' + strClaFisBonificacao) > 0) And (Not (Pos(strCodFor, strForFil) > 0))) Or
          ((blnAtuMed Or blnAtuUlt) And (Pos(strCodFor, strForFil) > 0))) And
         (not blnConferenciaDepoisDaEntrada) And
         (RoundTo(qryEntMer.FieldByName('ENT_TOTITE').AsFloat - qryEntMer.FieldByName('ENT_DESESP').AsFloat, -2) > 0) And
         (Not (tpFinalidadeXML in [xmlEntradaMercadoriasSistemaAnteriorDevolucao, xmlDevolucaoEntradaEmitidaFornecedor])) Then
      Begin
       


        If ((blnAlteraPrecos And SameText(qryEntMer.FieldByName('ENT_CODITE').AsString, qryEntMer.FieldByName('ENT_ITE_F5').AsString)) Or
              fAtualizaItem(strTipFor, blnAtpRau, qryEntMer.FieldByName('ENT_CODITE').AsString, objAtuFor)
            ) And
            ((Pos(strCodFor, strForFil) = 0) Or blnAtpRen) And
           blnAltPre And fHouveAlteracaoComposicaoPreco And (Not blnUsaLotePrecos) And
          {*Qualquer tipo de garantia nao muda preço*}
          ((not blnGarantia) And (not blnRecCliGarantia) And (not AblnAcessadoViaRetornoConsignacao)) Then
        Begin
          fltPreComAux := fltPreCom;
          If CharInSet(strAtuNMD[1] , ['O', 'C']) Then
          Begin

            If blnSepICM Then
              fltPreCom := fltPreCom - (qryEntMer.FieldByName('ENT_DESESP').AsFloat - qryEntMer.FieldByName('ENT_DESPIS').AsFloat - qryEntMer.FieldByName('ENT_VICMDE').AsFloat) / qryEntMer.FieldByName('ENT_QTDITE').AsFloat
            Else
              fltPreCom := fltPreCom - qryEntMer.FieldByName('ENT_DESESP').AsFloat / qryEntMer.FieldByName('ENT_QTDITE').AsFloat;

          End;


          If RoundTo(fltPreComAux, -4) <> RoundTo(fltPreCom, -4) Then
            pRecalculaPrecos(recPrecos,
                             fltPreCus,
                             blnAltPre,
                             cpcParams,
                             fltPreCom,
                             qryConIte,
                             qryEntMer,
                            (Assigned(objAtuFor) And objAtuFor.fItemSelecionado(qryEntMer.FieldByName('ENT_CODITE').AsString)),
                             blnAtpVmb);

        End;
      End;

      // AVISO ALTERAÇÃO DE PREÇO
      qryConIte.Locate('ITE_CODITE', qryEntMer.FieldByName('ENT_CODITE').AsString, []);

      cdsPrecosEntMer.Insert;
      cdsPrecosEntMer.FieldByName('ITE_CODITE').AsString := qryConIte.FieldByName('ITE_CODITE').AsString;
      cdsPrecosEntMer.FieldByName('ITE_DESITE').AsString := qryConIte.FieldByName('ITE_DESITE').AsString;
      cdsPrecosEntMer.FieldByName('ITE_CODUNI').AsString := qryConIte.FieldByName('ITE_CODUNI').AsString;

      cdsPrecosEntMer.FieldByName('ITE_CUSANT').AsFloat  := qryConIte.FieldByName('ITE_PRECUS').AsFloat;
      cdsPrecosEntMer.FieldByName('ITE_CUSNOV').AsFloat  := fltPreCus;
      If cdsPrecosEntMer.FieldByName('ITE_CUSANT').AsFloat > 0 Then
        cdsPrecosEntMer.FieldByName('ITE_CUSVAR').AsFloat  := ABS(((cdsPrecosEntMer.FieldByName('ITE_CUSNOV').AsFloat /  cdsPrecosEntMer.FieldByName('ITE_CUSANT').AsFloat) -1) * 100.00);

      For intTab := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intTab] = 'S' Then
        Begin
          cdsPrecosEntMer.FieldByName('ITE_PREANT'+intTab.toString).AsFloat := qryConIte.FieldByName('ITE_PREVE'+intTab.toString).AsFloat;
          cdsPrecosEntMer.FieldByName('ITE_PRENOV'+intTab.toString).AsFloat := recPrecos[intTab].fltPreVen;
          If cdsPrecosEntMer.FieldByName('ITE_PREANT'+intTab.toString).AsFloat > 0 Then
            cdsPrecosEntMer.FieldByName('ITE_PREVAR'+intTab.toString).AsFloat := ABS(((cdsPrecosEntMer.FieldByName('ITE_PRENOV'+intTab.toString).AsFloat /  cdsPrecosEntMer.FieldByName('ITE_PREANT'+intTab.toString).AsFloat) -1) * 100.00);
        End;
      End;

      cdsPrecosEntMer.Post;

      qryEntMer.Next;
    End;

  Finally
    FreeAndNil(CalculoPrecoMediAgrup);
    FreeAndNil(cds);
  End;
End;

{  QUANDO É CONFERENCIA APÓS A ENTRADA E NAO TEM ITEM PARA ENDEREÇAR,                                 }
{  SERÁ FEITO A ENTRADA DO DOCUMENTO EFETIVADO, NÃO SENDO NECESSÁRIO REALIZAR O PLANO DE RECEBIMENTO  }
{  REQ.: 240278                                                                                       }
Function fTemItemMarcadoParaFazerEnderecamento(qryEntMer: TDataSet) : Boolean;
Var
  qrySqlAux: TUniQuery;
Begin
  try
    Result := False;
    If fTabelaExiste('TMP_ENTMER') Then
    begin

      qrySqlAux := fCriaQuery;
      qrySqlAux.Sql.Clear;
      qrySqlAux.Sql.Add(' SELECT                                        ');
      qrySqlAux.Sql.Add('  COUNT(1) AS QTD                              ');
      qrySqlAux.Sql.Add(' FROM TMP_ENTMER                               ');
      qrySqlAux.Sql.Add('  INNER JOIN CADITE ON ENT_CODITE = ITE_CODITE ');
      qrySqlAux.Sql.Add(' WHERE CADITE.ITE_REAEND = "S"                 ');
      qrySqlAux.Close;
      qrySqlAux.Open;

      If (qrySqlAux.FieldByName('QTD').AsFloat > 0) Then
        Result := True;
    End
    Else
    Begin
      qryEntMer.First;
      While not qryEntMer.Eof Do
      Begin
        If fCampoTabela('ITE_REAEND', 'CADITE', ['ITE_CODITE'], [qryEntMer.FieldByName('ENT_CODITE').AsString]) = 'S' Then
          Exit(True);
        qryEntMer.Next;
      End;
    End;
  finally
    FreeAndNil(qrySqlAux);
  end;
End;

procedure pGravaPreEnt(qryEntMer: TDataSet; incMovDet: String; fltImpUlt, fltPreCom, fltPreCus, fltPrecomOri: Double; blnOutDesNoPrecom: Boolean; blnOutDesNoFreIte,blnencargosNoFrete, blnFreIpi: Boolean);
var qryComand: TUniQuery;
begin

  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('REPLACE INTO PREENT(');
    qryComand.SQL.Add('ENT_MOVDET,           ');
    qryComand.SQL.Add('ENT_PRECOM_SEM_CALC,  ');
    qryComand.SQL.Add('ENT_PRECOM,           ');
    qryComand.SQL.Add('ENT_PRECUS,           ');
    qryComand.SQL.Add('ENT_OUTDES,           ');
    qryComand.SQL.Add('ENT_FREITE,           ');
    qryComand.SQL.Add('ENT_FRECON,           ');
    qryComand.SQL.Add('ENT_FRERPA,           ');
    qryComand.SQL.Add('ENT_FREENT,           ');
    qryComand.SQL.Add('ENT_VALFRE,           ');
    qryComand.SQL.Add('ENT_DESESP,           ');
    qryComand.SQL.Add('ENT_VALRET,           ');
    qryComand.SQL.Add('ENT_VAERET,           ');
    qryComand.SQL.Add('ENT_VALANT,           ');
    qryComand.SQL.Add('ENT_VALGNR,           ');
    qryComand.SQL.Add('ENT_VFCPST,           ');
    qryComand.SQL.Add('ENT_TOTITE,           ');
    qryComand.SQL.Add('ENT_VALIPI,           ');
    qryComand.SQL.Add('ENT_VAEIPI,           ');

    qryComand.SQL.Add('ENT_DESF01,           ');
    qryComand.SQL.Add('ENT_DESF02,           ');
    qryComand.SQL.Add('ENT_DESF03,           ');
    qryComand.SQL.Add('ENT_DESF04,           ');
    qryComand.SQL.Add('ENT_DESF05,           ');
    qryComand.SQL.Add('ENT_DESF06,           ');
    qryComand.SQL.Add('ENT_ICMENT,           ');
    qryComand.SQL.Add('ENT_IPIENT,           ');
    qryComand.SQL.Add('ENT_SUBSTI,           ');
    qryComand.SQL.Add('ENT_DESADB,           ');
    qryComand.SQL.Add('ENT_SUBFED,           ');
    qryComand.SQL.Add('ENT_IMPULT,           ');
    qryComand.SQL.Add('ENT_EMBALA,           ');


    qryComand.SQL.Add('ENT_OUTDES_NO_PRECOM, ');
    qryComand.SQL.Add('ENT_OUTDES_NO_FREITE, ');
    qryComand.SQL.Add('ENT_ENCARGOS_NO_FRET, ');
    qryComand.SQL.Add('ENT_FREIPI,           ');
    qryComand.SQL.Add('ENT_GNRORI,           ');
    qryComand.SQL.Add('ENT_PREFRE           ');
    qryComand.SQL.Add(')VALUES(');
    qryComand.SQL.Add(':ENT_MOVDET,          ');
    qryComand.SQL.Add(':ENT_PRECOM_SEM_CALC, ');
    qryComand.SQL.Add(':ENT_PRECOM,          ');
    qryComand.SQL.Add(':ENT_PRECUS,          ');
    qryComand.SQL.Add(':ENT_OUTDES,          ');
    qryComand.SQL.Add(':ENT_FREITE,          ');
    qryComand.SQL.Add(':ENT_FRECON,          ');
    qryComand.SQL.Add(':ENT_FRERPA,          ');
    qryComand.SQL.Add(':ENT_FREENT,          ');
    qryComand.SQL.Add(':ENT_VALFRE,          ');
    qryComand.SQL.Add(':ENT_DESESP,          ');
    qryComand.SQL.Add(':ENT_VALRET,          ');
    qryComand.SQL.Add(':ENT_VAERET,          ');
    qryComand.SQL.Add(':ENT_VALANT,          ');
    qryComand.SQL.Add(':ENT_VALGNR,          ');
    qryComand.SQL.Add(':ENT_VFCPST,          ');
    qryComand.SQL.Add(':ENT_TOTITE,          ');
    qryComand.SQL.Add(':ENT_VALIPI,          ');
    qryComand.SQL.Add(':ENT_VAEIPI,          ');
    qryComand.SQL.Add(':ENT_DESF01,           ');
    qryComand.SQL.Add(':ENT_DESF02,           ');
    qryComand.SQL.Add(':ENT_DESF03,           ');
    qryComand.SQL.Add(':ENT_DESF04,           ');
    qryComand.SQL.Add(':ENT_DESF05,           ');
    qryComand.SQL.Add(':ENT_DESF06,           ');
    qryComand.SQL.Add(':ENT_ICMENT,           ');
    qryComand.SQL.Add(':ENT_IPIENT,           ');
    qryComand.SQL.Add(':ENT_SUBSTI,           ');
    qryComand.SQL.Add(':ENT_DESADB,           ');
    qryComand.SQL.Add(':ENT_SUBFED,           ');
    qryComand.SQL.Add(':ENT_IMPULT,           ');
    qryComand.SQL.Add(':ENT_EMBALA,           ');

    qryComand.SQL.Add(':ENT_OUTDES_NO_PRECOM,');
    qryComand.SQL.Add(':ENT_OUTDES_NO_FREITE,');
    qryComand.SQL.Add(':ENT_ENCARGOS_NO_FRET,');
    qryComand.SQL.Add(':ENT_FREIPI,          ');
    qryComand.SQL.Add(':ENT_GNRORI,          ');
    qryComand.SQL.Add(':ENT_PREFRE);         ');


{    qryComand.ParamByName('ENT_MOVDET').AsString := incMovDet;
    qryComand.ParamByName('ENT_PRECOM').AsFloat := fltPreCom;
    qryComand.ParamByName('ENT_PRECUS').AsFloat := fltPreCus;
    qryComand.ParamByName('ENT_OUTDES_NO_PRECOM').AsFloat := IIf(blnOutDesNoPrecom, 'S', 'N');
    qryComand.ParamByName('ENT_OUTDES').AsFloat := fltValorOutDes;}

    qryComand.ParamByName('ENT_MOVDET').AsString := incMovDet;
    qryComand.ParamByName('ENT_PRECOM').AsFloat  := fltPreCom;
    qryComand.ParamByName('ENT_PRECUS').AsFloat  := fltPreCus;
    qryComand.ParamByName('ENT_OUTDES').AsFloat  := qryEntMer.FieldByName('ENT_OUTDES').AsFloat;
    qryComand.ParamByName('ENT_FREITE').AsFloat  := qryEntMer.FieldByName('ENT_FREITE').AsFloat;
    qryComand.ParamByName('ENT_FRECON').AsFloat  := qryEntMer.FieldByName('ENT_FRECON').AsFloat;
    qryComand.ParamByName('ENT_FRERPA').AsFloat  := qryEntMer.FieldByName('ENT_FRERPA').AsFloat;
    qryComand.ParamByName('ENT_FREENT').AsFloat  := qryEntMer.FieldByName('ENT_FREENT').AsFloat;
    qryComand.ParamByName('ENT_VALFRE').AsFloat  := qryEntMer.FieldByName('ENT_VALFRE').AsFloat;
    qryComand.ParamByName('ENT_DESESP').AsFloat  := qryEntMer.FieldByName('ENT_DESESP').AsFloat;
    qryComand.ParamByName('ENT_VALRET').AsFloat  := qryEntMer.FieldByName('ENT_VALRET').AsFloat;
    qryComand.ParamByName('ENT_VAERET').AsFloat  := qryEntMer.FieldByName('ENT_VAERET').AsFloat;
    qryComand.ParamByName('ENT_VALANT').AsFloat  := qryEntMer.FieldByName('ENT_VALANT').AsFloat;
    qryComand.ParamByName('ENT_VALGNR').AsFloat  := qryEntMer.FieldByName('ENT_VALGNR').AsFloat;
    qryComand.ParamByName('ENT_VFCPST').AsFloat  := qryEntMer.FieldByName('ENT_VFCPST').AsFloat;
    qryComand.ParamByName('ENT_TOTITE').AsFloat  := qryEntMer.FieldByName('ENT_TOTITE').AsFloat;
    qryComand.ParamByName('ENT_VALIPI').AsFloat  := qryEntMer.FieldByName('ENT_VALIPI').AsFloat;
    qryComand.ParamByName('ENT_VAEIPI').AsFloat  := qryEntMer.FieldByName('ENT_VAEIPI').AsFloat;

    qryComand.ParamByName('ENT_DESF01').AsFloat  := qryEntMer.FieldByName('ENT_DESF01').AsFloat;
    qryComand.ParamByName('ENT_DESF02').AsFloat  := qryEntMer.FieldByName('ENT_DESF02').AsFloat;
    qryComand.ParamByName('ENT_DESF03').AsFloat  := qryEntMer.FieldByName('ENT_DESF03').AsFloat;
    qryComand.ParamByName('ENT_DESF04').AsFloat  := qryEntMer.FieldByName('ENT_DESF04').AsFloat;
    qryComand.ParamByName('ENT_DESF05').AsFloat  := qryEntMer.FieldByName('ENT_DESF05').AsFloat;
    qryComand.ParamByName('ENT_DESF06').AsFloat  := qryEntMer.FieldByName('ENT_DESF06').AsFloat;
    qryComand.ParamByName('ENT_ICMENT').AsFloat  := qryEntMer.FieldByName('ENT_ICMENT').AsFloat;
    qryComand.ParamByName('ENT_IPIENT').AsFloat  := qryEntMer.FieldByName('ENT_IPIENT').AsFloat;
    qryComand.ParamByName('ENT_SUBSTI').AsFloat  := qryEntMer.FieldByName('ENT_SUBSTI').AsFloat;
    qryComand.ParamByName('ENT_DESADB').AsFloat  := qryEntMer.FieldByName('ENT_DESADB').AsFloat;
    qryComand.ParamByName('ENT_SUBFED').AsFloat  := qryEntMer.FieldByName('ENT_SUBFED').AsFloat;

    qryComand.ParamByName('ENT_IMPULT').AsFloat  := fltImpUlt;

    qryComand.ParamByName('ENT_EMBALA').AsFloat  := qryEntMer.FieldByName('ENT_EMBALA').AsFloat;


    qryComand.ParamByName('ENT_PRECOM_SEM_CALC').AsFloat := fltPrecomOri;

    qryComand.ParamByName('ENT_OUTDES_NO_PRECOM').AsString := IIf(blnOutDesNoPrecom, 'S', 'N');
    qryComand.ParamByName('ENT_OUTDES_NO_FREITE').AsString := IIf( blnOutDesNoFreIte, 'S', 'N');
    qryComand.ParamByName('ENT_ENCARGOS_NO_FRET').AsString := IIF(blnencargosNoFrete, 'S', 'N');
    qryComand.ParamByName('ENT_FREIPI').AsString := IIf(blnFreIpi, 'S', 'N');
    qryComand.ParamByName('ENT_GNRORI').AsString := qryEntMer.FieldByName('ENT_GNRORI').AsString;
    qryComand.ParamByName('ENT_PREFRE').AsInteger := fCfgSis('PERFRE', varInteger);





    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;
End;

procedure pAddCTEMOVArr(strSeqMovDet: string; fltConFre: Double; fltAlqIcmFre: Double; var ArrCteMov: TArrCteMov);
var intPos: integer;
Begin
  intPos := Length(ArrCteMov);
  SetLength(ArrCteMov, intPos+1);


  ArrCteMov[intPos].strMOV_MOVDET := strSeqMovDet;
  ArrCteMov[intPos].fltMOV_CONFRE := fltConFre;
  ArrCteMov[intPos].fltMOV_ALQFRE := fltAlqIcmFre;
End;

function fGravarContasPagarPrevisao(dtsCadFis: TDataSet): Boolean;
var
  fltTotDoc : Double;
  blnConfirmar: Boolean;
  qryPrevisao: TUniQuery;
  strClaFis: String;
  strENERGIA_ELETRICA: String;
  strTELECOMUNICACAO: String;
  strCodFor: String;
  strSerie: String;
  strNumDoc: String;
  strCodEmp: String;
  strDataDoc: String;
begin
  Result := True;
  strENERGIA_ELETRICA := fCfgSis('CLAELE', varString);
  strTELECOMUNICACAO := fCfgSis('CLATEL', varString);

  blnConfirmar := False;
  fltTotDoc := dtsCadFis.FieldByName('FIS_VLCON1').AsCurrency +
               dtsCadFis.FieldByName('FIS_VLCON2').AsCurrency +
               dtsCadFis.FieldByName('FIS_VLCON3').AsCurrency +
               dtsCadFis.FieldByName('FIS_VLCON4').AsCurrency +
               dtsCadFis.FieldByName('FIS_VLCON5').AsCurrency ;

  strClaFis := dtsCadFis.FieldByName('FIS_CLFSC1').AsString;
  strCodFor := dtsCadFis.FieldByName('FIS_FORCLI').AsString;
  strSerie  := dtsCadFis.FieldByName('FIS_SERIE_').AsString;
  strNumdoc := dtsCadFis.FieldByName('FIS_NUMDOC').AsString;
  strDataDoc := DateTimeToStr(dtsCadFis.FieldByName('FIS_DTADOC').AsDateTime);

  strCodEmp := VS_strCodEmp;
  qryPrevisao := fCriaQuery;
  try
    qryPrevisao.Close;
    qryPrevisao.SQL.Clear;
    qryPrevisao.SQL.Add('SELECT');
    qryPrevisao.SQL.Add('  CADPAG.AUTOINCREM, CTP_DTACAD, CTP_DTAVEN,');
    qryPrevisao.SQL.Add('  CONCAT(CTP_NUMDUP, "-", CTP_PARCEL) AS DOCUMENTO,');
    qryPrevisao.SQL.Add('  CTP_SERIE_, CTA_DESCTA, CTP_HIST01, CTP_VALDUP,');
    qryPrevisao.SQL.Add('  CAST("" AS CHAR(01)) AS MARDES');
    qryPrevisao.SQL.Add('FROM CADPAG');
    qryPrevisao.SQL.Add('JOIN CADCTA ON CTP_CODCTA = CTA_CODCTA');
    qryPrevisao.SQL.Add('WHERE CTP_PREVIS = "S"');
    qryPrevisao.SQL.Add('  AND CTP_CODFOR = :CODFOR');
    qryPrevisao.SQL.Add('  AND CTP_DTAPAG IS NULL');
    qryPrevisao.SQL.Add('ORDER BY CTP_DTAVEN');
    qryPrevisao.ParamByName('CODFOR').AsString := strCodFor;
    qryPrevisao.Open;

    if not qryPrevisao.IsEmpty then
    begin
      If (Pos(strClaFis, '1933_2933') > 0) Or
      (Pos(strClaFis, strENERGIA_ELETRICA) > 0) Or
      (Pos(strClaFis, strTELECOMUNICACAO) > 0) Then
      Begin
        Try
          TfrmCadCtaPagarPrevisao
            .Create(nil)
            .fCodFor(strCodFor)
            .fVlrTot(fltTotDoc)
            .fDataCadastro(strDataDoc)
            .fExecutar(
              procedure (objDataSet: TDataSet)
              Begin
                objDataSet.First;
                While Not objDataSet.Eof Do
                Begin
                  //Altera Vencimento
                  If objDataSet.FieldBYName('CTP_DTAVEN').OldValue <> objDataSet.FieldBYName('CTP_DTAVEN').NewValue Then
                  Begin
                    pAlterarVencimento(objDataSet.FieldBYName('AUTOINCREM').AsString,
                      objDataSet.FieldBYName('CTP_DTAVEN').AsDateTime);
                    blnConfirmar := True;
                  End;
                  //Converte Previsão em despesa
                  If objDataSet.FieldBYName('CONVERTER_DESPESA').AsString = '1' Then
                  Begin
                    pAlteraContasPagar(qryPrevisao, fltTotDoc,
                      strCodEmp,
                      strNumDoc,
                      strSerie
                    );
                    blnConfirmar := True;
                  End;
                  objDataSet.Next;
                End;
              End
            )
            .Free;
            Result := blnConfirmar;
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[untPcmGer.pGravarContasPagar]');
          End;
        End;
      End
      Else
      Begin
        if fMensagem('',
          'Existem lancamentos de previsão no contas a pagar para este fornecedor.' + SLineBreak +
          'Deseja vincular algum destes lancamentos ao documento fiscal que esta sendo escriturado ?',
          ['&Sim', '&Não'], 2) = 1 then
          Result := pAlteraContasPagar(qryPrevisao, fltTotDoc,
            strCodEmp,
            strNumDoc,
            strSerie
            );
      End;
    end
    Else
      Result := False;
  finally
    FreeAndNil(qryPrevisao);
  end;
end;

procedure pAlterarVencimento(strAutInc: String; dtaVencimento: TDate);
var
  qryCta : TUniQuery;
begin
  qryCta := fCriaQuery;
  Try
    qryCta.SQL.Add('UPDATE CADPAG SET');
    qryCta.SQL.Add('CTP_DTAVEN = :DTAVEN');
    qryCta.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
    qryCta.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryCta.ParamByName('DTAVEN').AsDateTime := dtaVencimento;
    qryCta.Execute;
  Finally
    FreeAndNil(qryCta);
  End;
end;

function pAlteraContasPagar(const DataSet: TDataSet; fltTotDoc: Double;
  strCodEmp, strNumDoc, strSerie: String): Boolean;
var
  frmSelCtaPag: TfrmSelCtaPag;
  QryUpdate: TUniQuery;
  objPag: TCadPag;
  objRep: TCadPagRepository;

begin
  Result := False;
  pCriarFormularios(TfrmSelCtaPag, frmSelCtaPag);
  try
    frmSelCtaPag.SetData(DataSet);
    if frmSelCtaPag.ShowModal =MrOk Then
    begin
      QryUpdate := fCriaQuery();
      try
        QryUpdate.SQL.Add('UPDATE CADPAG SET');
        QryUpdate.SQL.Add('  CTP_PREVIS = "N",');
        QryUpdate.SQL.Add('  CTP_VALANT = CTP_VALDUP,');
        QryUpdate.SQL.Add('  CTP_NUMDUP = :NUMDUP,');
        QryUpdate.SQL.Add('  CTP_CODEMP = :CODEMP,');
        QryUpdate.SQL.Add('  CTP_SERIE_ = :SERIE_,');
        QryUpdate.SQL.Add('  CTP_VALDUP = :VALDUP,');
        QryUpdate.SQL.Add('  CTP_VALORI = :VALORI');
        QryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');
        QryUpdate.ParamByName('NUMDUP').AsString := strNumDoc;
        QryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
        QryUpdate.ParamByName('SERIE_').AsString := strSerie;
        QryUpdate.ParamByName('VALDUP').AsFloat := fltTotDoc;
        QryUpdate.ParamByName('VALORI').AsFloat := fltTotDoc;
        QryUpdate.ParamByName('AUTOINCREM').AsString := frmSelCtaPag.Selecionado;

        QryUpdate.ExecSQL;


        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(frmSelCtaPag.Selecionado);

        If Assigned(objPag) Then
          untLogCtp.pGravaLogCtp(objPag, 'ALTERAÇÃO ENTRADA DE MERCADRIA', 'untPcmGer.pAlteraContasPagar');

        If Assigned(objRep) Then
          FreeAndNil(objRep);

      finally
        FreeAndNil(QryUpdate);
      end;
      Result := True;
    end
  finally
    pFreeAndNil(frmSelCtaPag);
  end;
end;

function fGravarNumeroSerie(oleItensPedidos: OleVariant; strNumDoc, strEspDoc,
  strSerie, strCodEmp: String): Boolean;
Var
  frmControleNumeroSerie: TfrmControleNumeroSerie;
Begin
  pCriarFormularios(TfrmControleNumeroSerie, frmControleNumeroSerie);
  Try
    Result := frmControleNumeroSerie
      .fNumDoc(strNumDoc)
      .fEspDoc(strEspDoc)
      .fCodEmp(strCodEmp)
      .fSerie(strSerie)
        .fAbrirForm;
  Finally
    FreeAndNil(frmControleNumeroSerie);
  End;
End;

end.





