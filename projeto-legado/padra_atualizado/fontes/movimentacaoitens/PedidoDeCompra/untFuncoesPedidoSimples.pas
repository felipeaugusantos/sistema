unit untFuncoesPedidoSimples;

interface

Uses
  untFuncoesSimples, Uni, UniClientDataSet, DB, SysUtils, Classes,
  untConstantes, Controls, EditFocus, DateUtils, Math, StrUtils,
  Windows, Variants, untTypesSistema, CxProgressBar,
  cxGridDBTableView, ExtCtrls, StdCtrls, DBEditFocus, Graphics,
  cxGridDBBandedTableView, untSalvaDadosGiro, untZClient,
  untFuncoesRel, untFuncoesRel2, untMsgInterna, untFuncoesGenerica,
  untOpcaoBaixaRequisicao;

Const
  STR_COMPRAR    = 'Comprar';
  STR_TRANSFERIR = 'Transferir';

Type

 TNivelDeGiroComAgrupamento = class
   class var blnNivelDeGiroComAgrupamento: Boolean;
 End;


 TRegraCalcImp = (rciSim, rciNao, rciFornecedor);

 TParametrosCalcImpostosFornecedor = Record
   blnAplicaDescontoICMSDesoneradoPedido: Boolean;
   blnIncluiFrete_DesAce_na_BaseIcmsDesonerado: Boolean;
   blnAplicaPisCofins_na_BaseIcmsDesonerado: Boolean;
   blnAplicaDescontoPisCofinsPedidoCompra: Boolean;

   blnIncluiFrete_desAce_Na_BaseCalculoPisCofins: Boolean;
   blnAplicaDescontoICMSDesonerado_na_BasePisCofins: Boolean;
   fltAliquotaPis: Double;
   fltAliquotaCofins: Double;

   blnAplicaDescontoICMSDesonerado_na_BaseST: Boolean;
   blnAplicaDescontoPisCofins_na_BaseST: Boolean;

   blnAplicaDescontoICMSDesonerado_na_BaseICMS: Boolean;
   blnAplicaDescontoPisCofins_na_BaseICMS: Boolean;

   blnAplicaDescontoICMSDesonerado_na_BaseIPI: Boolean;
   blnAplicaDescontoPisCofins_na_BaseIPI: boolean;
   procedure pCarregaConfiguracoes(strCodFor: String); overload;
   procedure pCarregaConfiguracoes(qryCadFor: TUniQuery); overload;
   function fRetAliquotaPisCofins: Double;
  End;

  TParametrosCalculoImposto = Record
    blnCalcularICMSDesonerado: Boolean;
    rciConsideraDescontoPisCofins_na_Base_ICMSOpProprias: TRegraCalcImp;
    rciConsiderarDescontoICMSDson_Na_Base_ICMSOpProprias: TRegraCalcImp;
    Param_Fornecedor : TParametrosCalcImpostosFornecedor;
    procedure pSetaParametros(AValField_ITE_CICMDE: String;
                              AValField_ITE_CDPIOP: String;
                              AValField_ITE_DIDIOP: String);



  end;




  TBeforePost = procedure (dataSet: TDataSet) of object;
  TSelecaoLocFisica = (slfComLocal, slfSemLocal, slfTodas);
  TSelecaoSaldos    = (slsPositivo, slsNegativo, slsTodos, slsMenorOuIgualZero, slsAbaixoMinimo, slsAcimaOuIgualMinimo, slsZerado);
  TPrcAtualizaMeses = procedure(cxgGiroView: TcxGridDBBandedTableView) Of Object;
  TarrCamposPedCompra = Array of Array[1..6] Of String;
  TarrCamposAggPedCompra = Array Of Array[1..3] Of String;


  TProcChamaAtualizaProdReqOrdemServico = reference to procedure(strCodReq, strCodEmp: String; Var blnConfirmado: Boolean);

  TSqlReqCompra = (tpSelecao, tpVendedor);

  TNivelEstoque = (nivNenhum, nivGiro, nivCriticidade, nivAmbos, nivGiroFornecedor);

  TRecOpcoesNivel = record
    nivEstoque: TNivelEstoque;
    strNiveis: String;

    strIteGir,
    strIteCri: String;

    intDiaComGer: Integer;

    intDiaComNvA: Integer;
    intDiaComNvB: Integer;
    intDiaComNvC: Integer;

    intDiaComNvZ: Integer;
    intDiaComNvY: Integer;
    intDiaComNvX: Integer;

    intDiaComNvAZ: Integer;
    intDiaComNvAY: Integer;
    intDiaComNvAX: Integer;

    intDiaComNvBZ: Integer;
    intDiaComNvBY: Integer;
    intDiaComNvBX: Integer;

    intDiaComNvCZ: Integer;
    intDiaComNvCY: Integer;
    intDiaComNvCX: Integer;

    fltPerConGer,

    fltPerConA,
    fltPerConB,
    fltPerConC,

    fltPerConZ,
    fltPerConY,
    fltPerConX,

    fltPerConAZ,
    fltPerConAY,
    fltPerConAX,

    fltPerConBZ,
    fltPerConBY,
    fltPerConBX,

    fltPerConCZ,
    fltPerConCY,
    fltPerConCX: Double;
  End;

  TArrNiveis = Array Of String;

  TNivelGiroCriticidade = Class(TZClient)
  Private

     Procedure pMontaNivel(arrNiveis: TarrNiveis);

     Procedure pBeforePost(dataSet: TDataSet);

     Function fSQLDados: String;
  Public

    constructor Create(Owner: TComponent);

    Procedure pMontaNivelGiro;
    Procedure pMontaNivelCriticidade;
    Procedure pMontaNivelAmbos;
    Procedure pMontaSemNivel;

    Procedure pTiraBeforePost;
    Procedure pPoeBeforePost;

    Procedure pGravaNivelFornecedor(strCodFor: String);

    Function fCarregaNivelFornecedor(strCodFor: String; Var intIndex: Integer; blnLimpaNiveis: Boolean = True): Boolean;

    Procedure pRetNiveis(Var recNivel: TRecOpcoesNivel);

    Function fValidaDados: Boolean;

   Class Function fSQLFiltraNiveis(recNivel: TRecOpcoesNivel): String;
   Class Function fSQLNiveis(recNivel: TRecOpcoesNivel): String;

  End;

  TOpcaoChamadaGiro = (chaNenhum, chaPedido, chaCotacao, chaGeraAuto, chaSpoolTransferencia);

  TRecOpcoesGiro = record

    strEmpresasDestino: String;
    strEmpresasOrigens: String;

    blnConfirmouExcecucao: Boolean;

    strNumPedUmaLoja,
    strCodEmpUmaLoja,

    strValKey: String;
    strNomFrm: String;

    objSalInt: TSalvaInterfaceGiro;
    strSeqCot: String;

    blnAgrSim,
    blnCotacao,
    blnImpReq,
    blnLimReq,
    blninfMes,
    blnUsaGiro: Boolean;
    intMesGir: Integer;
    intMesMos: Integer;
    dtaDataBaseGir: TDateTime;
    blnCarregItensGrid: Boolean;
    strPedMlj: String;

    opcChamada: TOpcaoChamadaGiro;

    recNivEst: TRecOpcoesNivel;

    blnMedAju: Boolean;

    strLocIni,
    strLocFin,
    strCodGru: String;
    strCodFor: String;
    strCodMar: String;
    strPrdGru: String;
    strGruCmp: String;
    strSitPro: String;
    strUnidade: String;
    strRefere: String;
    strDesIte: String;
    strCodDep: String;
    strAcoObj: String;
    intDiaVen: Integer;
    blnAllIte: Boolean;
    cdsEmpSel: OleVariant;
    intOpcGir: Integer;
    strFilGir,
    strCodCmp: String;
    strCodDig: String;
    strEmpSubtraiPedTransf: String;
    strEmpGir,
    strEmpCal: String;
    blnAnalisaITEFOR: Boolean;
    blnArredSug: Boolean;  // Arredonda quantidade de sugestão
    blnConsMCom: Boolean;  // Considera múltiplo de compra
    blnMultiploNaEmpresaCentralizadora: Boolean;
    blnEmbala  : Boolean;  // Converte para embalagem
    blnConsTLoj: Boolean;  // Considera todas as lojas somadas
    intDiaPedVen: Integer; // Dias de previsão de pedidos de venda
    intOrdem   : Integer;  // Ordenação: 1-descricao e 2-marca+descricao
    blnConsEMin: Boolean;  // Considera estoque minimo para sugestão
    blnConsEMax: Boolean;  // Considera estoque máximo para sugestão
    blnConsRequisicao: Boolean; // Considera requisição de compra em aberto para sugetão de compra.
    blnConsPedPen: Boolean;// Considera Pedidos de Compra Pendentes (Compras)
    blnConsPedPenTransferencia: Boolean;// Considera Pedidos de Compra Pendentes (Trasnferecia)
    blnDesconsPedGar: Boolean;  // Subtrair Pedido de garantia
    blnConsPedVen: Boolean;// Considera Pedidos de Venda Pendentes
    blnDescSalExt: Boolean;// Descontar Saldo Externo do Saldo Base
    blnConsTransf: Boolean;// Considera Pedidos de Transferencia
    blnConsCot:    Boolean;// Considera Cotacao em Aberto
    blnConsOrdPro: Boolean;// Considera Ordem de Produção
    blnConsGarPen: Boolean;// Considera Garantia Pendente
    blnConsMesAtu: Boolean;// Considera Mes Atual
    blnVenPer    : Boolean;// Vendas Perdidas
    blnVenPerMed : Boolean;// Considerar de vendas perdidas a media
    blnConsEndere : Boolean;
    blnVenEsp    : Boolean;// Considerar Vendas Esporádicas

    blnEntFutPrevisao,
    blnEntFutFalta,
    blnEntFutAguarda: Boolean;

    blnAteMax    : Boolean; // CALCULA ATÉ O ESTOQUE MÁXIMO
    blnPonPed    : Boolean; // PONTO DE PEDIDO

    blnSpoTra    : Boolean;

    blnExiApli   : Boolean;

    strEmpAgr: String;
    blnSugInd: Boolean;
    slfLocFis: TSelecaoLocFisica;
    slsSaldos,
    slsSaldosDestino: TSelecaoSaldos;
    arrCodFor    : TConsultasArray;
    arrLinhaGrupo: TConsultasArray;
    arrMarca     : TConsultasArray;
    arrPrdGru    : TConsultasArray;
    arrGruCmp    : TConsultasArray;
    arrSitPro    : TConsultasArray;
    arrUnidade   : TConsultasArray;
    arrCodDep    : TConsultasArray;
    strMeses     : String;
    strCodTab    : String;
    objRecupera  : Pointer;

    strNumPedAlt,
    strEmpPedAlt,
    strEspPedAlt: String;

    blnRecuperCot: Boolean; //CÓPIA SEGURANÇA COTAÇÃO
   blnAlterandoCotacaoComGiroNaoMultiloja: Boolean;

    function fFornecedoresSelecionados: String;
  end;

  TProdutosGiro = function (Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
    blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant;

  Function fSQLEmpresaPedido: String;

  Function fTravaDestravaPedidoCompra(blnTrava : Boolean; strNumPed, strEspDoc, strCodEmp: String): Boolean;

  Function fChaveTravaPedido(strNumPed, strEspDoc, strCodEmp: String): String;

  Function fSQLFiltrosGiro(recOpcGir: TRecOpcoesGiro; blnFiltrarOperador: Boolean): String;
  function fSQLFiltroSaldo(slsSaldos: TSelecaoSaldos; strEmpSel: String): String;
  Function fSqlFiltroLocFisica(slfLocFis: TSelecaoLocFisica; strEmpSel: String): String;
  Function fSqlIteESMIDG: String;

  Function fSqlFiltroLocFisicaInicialFinal(strLocIni, strLocFin, strEmpSel: String): String;

  function fSQLFiltroAteMax(strEmpSel: String): String;

  Function fTemPreNotaPedido(strNumPed, strCodEmp: String; Var strNotas: String): Boolean;

  procedure pCarregaDadosST(qryAbf: TUniQuery; strCodFor, strCodAbf: String);

  Function fCalculaPerSub(fltTotIte, fltTotFre, fltTotAce, fltTotIpi, fltTotSub: Double;
                          strFrmPcm, strBStFre, strBStAce: String): Double;

  function fRetornaAbreviacaoItem(strCodIte: String; strTipAbf: String = ''): String;

  function fCalcularSubstituicaoProduto(strCodFor,
                                        strCodAbf: String;
                                        fltTotIte,
                                        fltTotFre,
                                        fltTotAce: Double;
                                        strFrmPcm,
                                        strBStFre,
                                        strBStAce: String;
                                        blnZonaFranca,
                                        blnIncPis,
                                        blnFornecSimples,
                                        blnTemDare: Boolean;
                                        fltAlqIPI: Double;
                                        blnZeraST: boolean;
                                        Var AfltBasIcm,
                                            AfltAlqIcm,
                                            AfltValIcm,
                                            AfltBaseST,
                                            AfltDesPis,

                                            AfltBasIPI,
                                            AfltValIPI,
                                            AfltPerFCP,
                                            AfltSubFCP,
                                            AfltTotDar: Double;

                                        Var strCodSit,
                                            strCodSitOrigem: String;
                                        var AfltAliquotaSub: Double;
                                        ParametrosImpostos: TParametrosCalculoImposto;
                                        strTipAbfFor: String = '';
                                        qryDadosAbf: TUniQuery = Nil): Double;

  Procedure pCarregaUltimaCompraGeral(cdsItensPedido: TUniClientDataSet; strCodIte, strEmpGir: String);

  function fCarregaPontoExposicao(strCodIte, strEmpGir: String): Double;

  Procedure pInicializaFiltros(Var strCodFor, strRefere, strDesIte, strAcoObj: String);

  Procedure pCarrregaDadosGiro(cdsItensPedido: TUniClientDataSet; strEmpresas, strCodSim: String);

  procedure pRetornaMaiorVenda(cdsItensPedido: TUniClientDataSet; intMosMes: Integer);

  Procedure pAtualizaTotaisPedido(strAutInc: String;
               fltValFre, fltDesAce, fltTotSub, fltSubFCP, fltTotIte, fltTotIpi, fltIcmDes: Double;
               const AblnGravaReforma: Boolean = False;
               const AfltValCbs: Double = 0;
               const AfltValIbs: Double = 0;
               const AfltVal_Is: Double = 0);

  procedure pCalculaImpostosReformaItem(ADataSet: TDataSet; const AblnImportacao: Boolean);
  procedure pCopiaAliquotasReforma(AOrigem, ADestino: TDataSet; const AblnImportacao: Boolean);
  function fTotalImpostosReformaItem(ADataSet: TDataSet): Double;
  function fSQLSomaImpostosReforma(const APrefixo: String): String;
  function fSQLUnitarioImpostosReforma(const APrefixo: String): String;

  Function fSubSQLPreparaTE(strAlias: String = 'I'; strSQLCodSim: String = ''): String;

  Function fSQLSaldoCotacao(strCodIte, strEmpresas: String; strSQLCodSim: String = ''): String;

  Function fSQLVendasPerdidas(strCodIte, strEmpresas: String; recOpcGir: TRecOpcoesGiro; blnComGiro: Boolean; strSQLCodSim: String = ''): String;

  function fMesesGiro(recOpcGir: TRecOpcoesGiro; intQtdMeses: Integer = 0): String;

  Function fSQLSaldoItem(strAliasIteger: String; blnAgrSim: Boolean = False; strAliasCodIte: String = ''): String;

  Function fSQLSaldosReservados(blnSoma,
                                blnUsarOpcGiro: Boolean;
                                recOpcGir: TRecOpcoesGiro;
                                strAliasIteger,
                                strAliasCadIte,
                                strAliasSALPDC: String;
                                blnVirgulaultimocampo: Boolean = True): String; OverLoad;

  Function fSQLSaldosReservados(blnSoma: Boolean;
                                strAlias,
                                strAliasCadIte,
                                strAliasSALPDC: String): String; OverLoad;

  Function fSQLSaldosReservadosAgrSim(blnSoma,
                                      blnUsarOpcGiro: Boolean;
                                      recOpcGir: TRecOpcoesGiro;
                                      strAliasIteger,
                                      strAliasCodIte,
                                      strAliasSALPDC: String): String; OverLoad;

  Function fSQLSaldosReservadosAgrSim(blnSoma: Boolean;
                                      strAliasIteger,
                                      strAliasCadIte,
                                      strAliasSALPDC: String): String; OverLoad;

  procedure pAcertaCorPedido(cdsItensPedido: TUniClientDataSet; fltLimAma, fltLimVer: Double);

  Procedure pMostraDadosRodapeGiro(cdsItensPedido: TUniClientDataSet;
                                   intMesGir,
                                   intMesMos: Integer;
                                   pnlVendas: TPanel;
                                   edtMaQtSa,
                                   edtMaDtSa: TEditFocus;
                                   dbeMes: TDBEditFocus;
                                   blnConsMesAtu: Boolean);

  procedure pMascaraCamposGiro(cdsItensPedido: TUniClientDataSet; intMesGir: Integer);

  Procedure pMontaCamposGiro(pnlVendas: TPanel; intMesGir, intMesMos: Integer; strMeses: String);

  procedure pDadosEntregaPedido(var strNomEmp, strEndEmp, strCidEmp: String; strCodEmp: String);

  Procedure pAbreEmpresas(qryCadEmp: TUniQuery; strEmpresas: String = '');
  Procedure pCarregaUltimaCompra(cdsItensPedido: TDataSet; strCodIte, strCodEmp: String);
  Procedure pCarregaUltimaVenda(cdsItensPedido: TDataSet; strCodIte, strCodEmp: String; blnEntBrf: Boolean);

  procedure pZeraMultiLojas(strCodIte: String; cdsItensMultiLojas: TUniClientDataSet; blnDeletandoItem: Boolean);

  Procedure pCalculaVariacaoCompra(cdsItens: TDataSet);

  procedure pVoltaQtdTmpMultiLojas(strCodIte: String; cdsItensMultiLojas: TUniClientDataSet);

  Procedure pGetSaldosReservados(cdsSaldos: TZClient;
                                 strCodIte,
                                 strEmpresas: String;
                                 blnUsarOpcGiro: Boolean;
                                 recOpcGir: TRecOpcoesGiro);

  function fEhPedidoCompraMultiLoja(strNumPed, strEspDoc, strCodEmp: String): Boolean;

  Function fRetItensPed(cdsItensPedido: TUniClientDataSet): String;
  Function fTemPedidoEmpresa(cdsItensMultiLojas: TUniClientDataSet; qryCadEmp: TUniQuery; strItensPed: String): Boolean;

  Function fRetornaSaldoItem(strCodIte, strCodSim, strLisEmp: String): Double;

  Function fLiberaTravaValidadeCertGestao(strCodFor: String): Boolean;
  function fLiberaQuantidadeMultiplos(strCodIte: String): Boolean;
  function fPedidoEstaEmPreNota(strNumPed,strEmpPed,strEspDoc: String): Boolean;
  function fPedidoBaixadoPelaEntrada(strNumPed,strEmpPed,strEspDoc: String): Boolean;

  Procedure pRetCamposGiro(cdsItensGiro: TUniClientDataSet;
                           strCodIte,
                           strEmpresas,
                           strMeses: String;
                           blnConsMesAtu: Boolean;
                           intMesGir,
                           intMosMes: Integer;
                           recNivEst: TRecOpcoesNivel;
                           strCodSim: String);

  function fLiberaCompraCentralizada(strCodIte, strEmpDes: String): Boolean;

  function fValidaSeDocumentoPodeSerBaixado(strNumDoc,strEspDoc,strCodEmp, strAutInc: String;
                                            out AopcRequisicao: TOpcRequisicao;
                                            out AintMotivoReq: Integer;
                                            out AstrMotivoReq: String;
                                            stlListaSelecao: TStringList = Nil): Boolean;

  function fVerificaProssegueComPedidoDeImportacao(AQryPedImp:TUniQuery): Boolean;

  Function fMontaStrMeses(intQtdMes: Integer): String;

  procedure pCalculaGiroAnalitico(dtaDataBase: TDateTime; strCodIte, strCodEmp: String; intQtdMes: Integer; strTipoChamadaGrid: string); overload;
  procedure pCalculaGiroAnalitico(strCodIte, strCodEmp, strMeses, strTipoChamadaGrid: String; blnAgrSim: Boolean = False); overload;
  function fTransformaData(strmAnoMes: String): TDate;

  function fDiasCompra(recNivEst: TRecOpcoesNivel): Integer;
  function fPercElevacaoConsumiveis(recNivEst: TRecOpcoesNivel): Double;

  function fDiasPorNivel(recNivEst: TRecOpcoesNivel): String;
  function fEscreAsteriscoPromocao(recOpcGir: TRecOpcoesGiro): string;

  Function fRetVendasMesItem(strCodIte, strCodSim, strEmpresas: String; intMes, intAno: Integer; blnPromocao: Boolean): Double;

  function fCriaDatasetPedido(intQtdMes: Integer;
                              Var arrCampos: TarrCamposPedCompra;
                              Var arrCamposAgg: TarrCamposAggPedCompra;
                              frmDono: TWinControl = Nil): TUniClientDataSet;

  function fRetornaForFil: String;

  Function fBaixaPedidoNaoEntregue(strAutoincrem, strMotivo, strCodOco: String; blnComTransacao: Boolean;
                                   opcRequisicao: TOpcRequisicao;
                                   intMotivoReq: Integer;
                                   strMotivoReq: String): Boolean;

  procedure pSqlBaixaPedido(blnViaAutoincrem: Boolean; var qry: TUniQuery);

  Function fDesfazerBaixaPedidoNaoEntregue(strNumPed, strEspDoc, strCodEmp: String; blnVisualizarMensagem: Boolean = true):Boolean;
  Function fValidaPedComQuantidadeBaixada(strNumPed, strEspDoc, strCodEmp: String):Boolean;
  Function fGetSQLPedidosComQuantidadeBaixada:String;
  Function fValidaPedBaixado(strNumPed, strEspDoc, strCodEmp: String):Boolean;
  Function fGetSQLPedidosBaixado: String;
  Function fGerarLogDesBai(strNumPed, strEspDoc, strCodEmp, strNumCtn, strMotBai: String): Boolean;


  procedure pReqCompraSql(tpSel : TSqlReqCompra; var qry: TUniQuery);
  procedure pMensagemBaixaRequisicaoCompra(strNumPed, strEspDoc, strCodEmp, strMotivo, strCodOco: String; qry: TUniQuery);

  procedure pAjustaMultiLoja(cdsItensPedido, cdsItensMultiLojas: TUniClientDataSet; chkPedImp: Boolean = False);

  Function fPedidoSoUmaLoja(cdsItensMultiLojas: TUniClientDataSet): Boolean;

  Function fCalculaUnitarioLiquido(intDecUni: Integer; fltUnitar, fltDesUni, fltDesUn2, fltDesUn3, fltDesUn4, fltDesUn5, fltDesUn6: Double): Double;

  procedure pAlteraPasCmp(strTabela : String; qryPcmDet: TUniQuery);


Var
  prcImprimeDocumento: TImprimeDocumento;
  prcCadProdutos: TAbreCadastroProcedure;
  prcExibeRequisicaoCompra: TExibeRequisicaoCompra;
  funGerarEmail: TGerarEmail;
  funProdutosGiro: TProdutosGiro;
  procChamaAtualizaProdReqOrdemServico,
  procChamaAtualizaProdReqSemOS: TProcChamaAtualizaProdReqOrdemServico;

Type
  TCalculaCamposPedido = Class

  Public
     Class procedure pCalcFields(DataSet: TDataSet);

  End;

implementation

Uses
  untGravando, untSaldoPedidoCompra,
  untEntDigMultiLojasNovo, untModulo, untFuncoesConsulta, untILiberacao,
  untLiberacaoFactory, untTFatReservaSaldo,
  untRequisicaoPedidoCompra, untMensagemExplicativa, untImpostosReformaCompra;

Class Procedure TCalculaCamposPedido.pCalcFields(DataSet: TDataSet);
begin
  With DataSet do
  Begin
    pCalculaVariacaoCompra(DataSet);
  End;
end;

{*****************************************}
{* CRIA O DATASET DO PEDIDO DE COMPRA    *}
{* TIPOS:                                *}
{* 'C' -> CARACTER                       *}
{* 'N' -> NUMERICO                       *}
{* 'D' -> DATA                           *}
{**************************************MV*}
function fCriaDatasetPedido(intQtdMes: Integer;
                            Var arrCampos: TarrCamposPedCompra;
                            Var arrCamposAgg: TarrCamposAggPedCompra;
                                frmDono: TWinControl = Nil): TUniClientDataSet;
  Var
    intTamMat: Integer;
    intContador: Integer;
    strTamanhoDescricao : String;
    intDecUni,
    intQtdUco: Integer;
    procedure pCampo(strNome, strTipo, strMascara, strDescricao: String; strAlinha: String = ''; blnCalcul: Boolean = False);
    begin
      intTamMat := Length(arrCampos);
      SetLength(arrCampos, intTamMat+1);
      arrCampos[intTamMat][1] := strNome;
      arrCampos[intTamMat][2] := strTipo;
      arrCampos[intTamMat][3] := strMascara;
      arrCampos[intTamMat][4] := strDescricao;
      arrCampos[intTamMat][5] := strAlinha;

      If blnCalcul Then
        arrCampos[intTamMat][6] := 'C'
      Else
        arrCampos[intTamMat][6] := '';
    end;

    procedure pCampoAgg(strNome, strExpressao, strMascara: String);
    begin
      intTamMat := Length(arrCamposAgg);
      SetLength(arrCamposAgg, intTamMat+1);
      arrCamposAgg[intTamMat][1] := strNome;
      arrCamposAgg[intTamMat][2] := strExpressao;
      arrCamposAgg[intTamMat][3] := strMascara;
    end;

    procedure pGerarCampos;
      Var
        intContador: Integer;
    begin

      For intContador := Low(arrCampos) To High(arrCampos) Do
      Begin

        With Result.FieldDefs.AddFieldDef Do
        Begin
          Name := arrCampos[intContador][1];

          If arrCampos[intContador][2] = 'C' Then
          Begin
            DataType := ftString;
            Size     := StrToInt(arrCampos[intContador][3]);
          End
          Else If arrCampos[intContador][2] = 'N' Then
          Begin
            DataType := ftFloat;
          End
          Else If arrCampos[intContador][2] = 'I' Then
          Begin
            DataType := ftInteger;
          End
          Else If arrCampos[intContador][2] = 'T' Then
          Begin
            DataType := ftMemo;
          End
          Else
          Begin
            DataType := ftDateTime;
          End;

          If arrCampos[intContador][6] = 'C' Then
            InternalCalcField := True;

        End;

      End;

    end;

    procedure pGerarCamposAgg(cdsDataset: TUniClientDataSet);
      Var
        intContador: Integer;
    begin
      For intContador := Low(arrCamposAgg) To High(arrCamposAgg) Do
      Begin
        With TAggregateField.Create(cdsDataset) Do
        Begin
          Name          := arrCamposAgg[intContador][1];
          FieldName     := arrCamposAgg[intContador][1];
          Expression    := arrCamposAgg[intContador][2];
          DisplayFormat := arrCamposAgg[intContador][3];
          DataSet       := cdsDataset;
          Active        := True;
          Alignment     := Classes.taRightJustify;
        End;
      End;
    end;
begin
  intQtdUco := fCfgSis('DEQTPC', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);
  Result := TUniClientDataSet.Create(Nil);

  SetLength(arrCampos, 0);
  SetLength(arrCamposAgg, 0);
  Try
    strTamanhoDescricao := fRetFieldCharLength('PCMDET','PCD_DESITE');
    If  fEmptyStr(strTamanhoDescricao) Then
      Abort;
  Except
     strTamanhoDescricao := '70';
  End;
  pCampo('TAB', 'I', '1', 'Tab','',True);  //
  pCampo('ITE_CODITE', 'C', IntToStr(fTamCodIte), 'Código');       // 01

  pCampo('ITE_GRAVAD', 'C', '01', '');       // 01  S/N SE JÁ ESTÁ GRAVADO NO BANCO

  pCampo('ITE_CODGRU', 'C', '06', 'Grupo');       // 02
  pCampo('ITE_CODTAB', 'C', '06', 'Tabela de Preço Fornecedor');       // 02
  pCampo('ITE_CODEMP', 'C', '03', 'Empresa');       // 03
  pCampo('ITE_DESITE', 'C', strTamanhoDescricao, 'Descrição');       // 04
  pCampo('ITE_APLICA', 'T', '100','Aplicação');       // 04
  pCampo('ITE_REFERE', 'C', '40', 'Referência');       // 05
  pCampo('ITE_CODUNI', 'C', '04', 'Cód. Unidade');       // 06
  pCampo('ITE_UNICOM', 'C', '02', 'Cód. Unidade de Compra');       // 06
  pCampo('ITE_SIGUNI', 'C', '06', 'Sig. Unidade', 'C'); // 07
  pCampo('ITE_CODMAR', 'C', '03', 'Cód. Marca');       // 08
  pCampo('ITE_DESMAR', 'C', '30', 'Marca');       // 09
  pCampo('ITE_CODFOR', 'C', '08', 'Cód. Fornecedor');       // 10
  pCampo('ITE_ITEESP', 'C', '01', '');       // 11
  pCampo('ITE_ACRFIN', 'N', '#,##0.00', ''); // 12
  pCampo('ITE_DESF01', 'N', '#,##0.00', ''); // 12
  pCampo('ITE_DESF02', 'N', '#,##0.00', ''); // 13
  pCampo('ITE_DESF03', 'N', '#,##0.00', ''); // 14
  pCampo('ITE_DESF04', 'N', '#,##0.00', ''); // 15
  pCampo('ITE_DESF05', 'N', '#,##0.00', ''); // 16
  pCampo('ITE_DESF06', 'N', '#,##0.00', ''); // 17
  pCampo('ITE_SALDIS', 'N', '#,##0.00', ''); // 18
  pCampo('ITE_INIBAS', 'N', '#,##0.00', ''); // 18
  pCampo('ITE_SALBAS', 'N', '#,##0.00', ''); // 18
  pCampo('ITE_SALDOS', 'N', '#,##0.00', ''); // 18
  pCampo('ITE_SALFIS', 'N', '#,##0.00', ''); // 18
  pCampo('ITE_QTEF_A', 'N', '#,##0.00', ''); //
  pCampo('ITE_QTPD_P', 'N', '#,##0.00', ''); //
  pCampo('ITE_QTEF_F', 'N', '#,##0.00', ''); //
  pCampo('ITE_QTEF_P', 'N', '#,##0.00', ''); //
  pCampo('ITE_PRECUS', 'N', '#,##0.00', ''); // 19
  pCampo('ITE_PREVE1', 'N', '#,##0.00', ''); // 20
  pCampo('ITE_PREVE2', 'N', '#,##0.00', ''); // 21
  pCampo('ITE_PREVE3', 'N', '#,##0.00', ''); // 22
  pCampo('ITE_PREVE4', 'N', '#,##0.00', ''); // 23
  pCampo('ITE_PREVE5', 'N', '#,##0.00', ''); // 24
  pCampo('ITE_PREVE6', 'N', '#,##0.00', ''); // 25
  pCampo('ITE_PREVE7', 'N', '#,##0.00', ''); // 25
  pCampo('ITE_MARBR1', 'N', '#,##0.00', ''); // 26
  pCampo('ITE_MARBR2', 'N', '#,##0.00', ''); // 27
  pCampo('ITE_MARBR3', 'N', '#,##0.00', ''); // 28
  pCampo('ITE_MARBR4', 'N', '#,##0.00', ''); // 29
  pCampo('ITE_MARBR5', 'N', '#,##0.00', ''); // 30
  pCampo('ITE_MARBR6', 'N', '#,##0.00', ''); // 31
  pCampo('ITE_MARBR7', 'N', '#,##0.00', ''); // 31
  pCampo('ITE_PREULT', 'N', fMskDigitos(intDecUni), ''); // 32
  pCampo('ITE_DIFPRE', 'N', fMskDigitos(intDecUni), ''); // 32
  pCampo('ITE_PRECOM', 'N', '#,##0.00', ''); // 33
  pCampo('ITE_IMPULT', 'N', fMskDigitos(intDecUni), ''); // 32

  pCampo('ITE_EMBALA', 'N', fMskDigitos(DEC_EMBALAGEM), ''); // 34
  pCampo('ITE_QTDEMB', 'N', fMskDigitos(DEC_EMBALAGEM), ''); // 34
  pCampo('ITE_CONVER', 'C', '1', '');
  pCampo('ITE_QTDUCO', 'N', fMskDigitos(intQtdUco), ''); // 35
  pCampo('ITE_CPRCEN', 'C', '2', '', 'C');
  pCampo('ITE_EMPCEN', 'C', '3', '', 'C');
  pCampo('ITE_PRINCI', 'C', '1', '', 'C');
  pCampo('ITE_CICMDE', 'C', '1', '', 'C');
  pCampo('ITE_CDPIOP', 'C', '1', '', 'C');
  pCampo('ITE_DIDIOP', 'C', '1', '', 'C');

  pCampo('ITE_DESPIS', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_SUBUSU', 'C', '1', '', 'C');

  pCampo('ITE_TIPOPE', 'C', '10', '', 'C');                                  // Compra ou Transferencia
  pCampo('ITE_QTDTRA', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Quantidade a transferir
  pCampo('ITE_MLTSPO', 'C', '1', '');
  pCampo('ITE_ESTEXC', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Sugestão Real;
  pCampo('ITE_DIFSUG', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Diferença sugestão;


  pCampo('ITE_QTDEXC', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Quantidade excedente disponível para transferir
  pCampo('ITE_REATRA', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Quantidade excedente que vai ser transferida
  pCampo('ITE_QTDREM', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // Quantidade remanescente disponível para transferir

  pCampo('ITE_CPCEMO', 'C', '2', '');

  pCampo('ITE_CLACRM', 'C', '1', '');

  pCampo('ITE_UNITAR', 'N', fMskDigitos(fCfgSis('DECUNI', varInteger)), ''); // 37
  pCampo('ITE_UNILIQ', 'N', fMskDigitos(fCfgSis('DECUNI', varInteger)), ''); // 37
  pCampo('ITE_DESUNI', 'N', fMskDigitos(2), '');                             //
  pCampo('ITE_DESUN2', 'N', fMskDigitos(2), '');                             //
  pCampo('ITE_DESUN3', 'N', fMskDigitos(2), '');                             //
  pCampo('ITE_DESUN4', 'N', fMskDigitos(2), '');                             //
  pCampo('ITE_DESUN5', 'N', fMskDigitos(2), '');                             //
  pCampo('ITE_DESUN6', 'N', fMskDigitos(2), '');                             //

  pCampo('ITE_UNIORI', 'N', fMskDigitos(fCfgSis('DECUNI', varInteger)), ''); //Unitario Original 38
  pCampo('ITE_CNDPAG', 'C', '22', '');       // 39
  pCampo('ITE_QTDITE', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40
  pCampo('ITE_BKPQTI', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40

  pCampo('ITE_QTDINC', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40
  pCampo('ITE_TRAINC', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40

  pCampo('ITE_QTDALT', 'C', '1', '');       // 39

  pCampo('ITE_BAIPED', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40
  pCampo('ITE_BAINOT', 'C', '60', '');       // 39

  pCampo('ITE_QTDCAL', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40  // QUANTIDADE CALCULADA SEM O MÚLTIPLO DE COMPRA
  pCampo('ITE_SUGESTORI', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40  // QUANTIDADE CALCULADA SEM O MÚLTIPLO DE COMPRA

  pCampo('ITE_QTDORI', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 40
  pCampo('ITE_QTDBAI', 'N', fMskDigitos(fCfgSis('DEQTPC', varInteger)), ''); // 41

  pCampo('ITE_TOTITE', 'N', '#,##0.00', ''); // 42

  pCampo('ITE_VALFRE', 'N', '#,##0.00', ''); //
  pCampo('ITE_DESACE', 'N', '#,##0.00', ''); //

  pCampo('ITE_TOTGER', 'N', '#,##0.00', ''); // 42
  pCampo('ITE_PERIPI', 'N', '#,####0.0000', ''); // 43
  pCampo('ITE_BASIPI', 'N', '#,##0.00', ''); // 44
  pCampo('ITE_TOTIPI', 'N', '#,##0.00', ''); // 44
  pCampo('ITE_PERSUB', 'N', '#0.00', ''); // 45
  pCampo('ITE_TOTSUB', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_TOTDAR', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_UNIIMP', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_BASSUB', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_PERFCP', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_SUBFCP', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_ALQICM', 'N', '#,####0.0000', ''); // 45
  pCampo('ITE_BASICM', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_PERBAS', 'N', '#,##0.0000', ''); // 46
  pCampo('ITE_VALICM', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_ALQIMP', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_VALIMP', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_VALSIS', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_VALMAR', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_BASPIS', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_ALQPIS', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_VALPIS', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_BASCOF', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_ALQCOF', 'N', '#,##0.00', ''); // 46
  pCampo('ITE_VALCOF', 'N', '#,##0.00', ''); // 46

  pCampo('ITE_TOTBAI', 'N', '#,##0.00', ''); // 47
  pCampo('ITE_IPIBAI', 'N', '#,##0.00', ''); // 48
  pCampo('ITE_SUBBAI', 'N', '#,##0.00', ''); // 49
  pCampo('ITE_DARBAI', 'N', '#,##0.00', ''); // 49
  pCampo('ITE_LITROS', 'N', '#,##0.00', ''); // 50
  pCampo('ITE_CODFAB', 'C', '35', 'Cód. Fábrica');       // 51
  pCampo('ITE_CODBAR', 'C', '15', 'Cód. Barras');       // 52
  pCampo('ITE_PEDTXT', 'C', '03', '');       // 53
  pCampo('ITE_QTDPEN', 'N', '#,##0.00', 'Qtd. Pendente'); // 54
  pCampo('ITE_SALREQ', 'N', '#,##0.00', 'Qtd. Requisição'); // 54

  pCampo('ITE_VENPER', 'N', '#,##0.00', 'Qtd. Perdida'); // VENDAS PERDIDAS

  pCampo('ITE_SALRES', 'N', '#,##0.00', 'Saldo Reservado'); // 54
  pCampo('ITE_SALGAR', 'N', '#,##0.00', 'Saldo Garantia'); // 54
  pCampo('ITE_SALEXT', 'N', '#,##0.00', 'Saldo Externo'); // 54
  pCampo('ITE_SALEND', 'N', '#,##0.00', 'Saldo Endereçamento'); // 54
  pCampo('ITE_SALTRA', 'N', '#,##0.00', 'Saldo Transferência'); // 54
  pCampo('ITE_SALCOT', 'N', '#,##0.00', 'Saldo Cotação'); // 54

  pCampo('AUTOINCREM', 'C', '20', '');       // 55
  pCampo('ITE_DESFAB', 'C', '70', 'Desc. Fábrica');       // 56
  pCampo('ITE_CODSIM', 'C', '06', 'Cod. Similar');        //57
  pCampo('ITE_PESOIT', 'N', '#,##0.00', 'Peso');         // 58
  pCampo('ITE_PESORI', 'N', '#,##0.00', 'Peso');         // 58
  pCampo('ITE_FORULT', 'C', '8',  '');             // 59
  pCampo('ITE_NOMFOR', 'C', '70',  '');            // 60
  pCampo('ITE_DTAULT', 'D', '10', '', 'C');             // 61
  pCampo('ITE_NVLGIR', 'C', '1', 'Nível de Giro', 'C'); // 62
  pCampo('ITE_NVLCRI', 'C', '1', 'Nível de Criticidade', 'C'); // 62

  pCampo('GIRSINT', 'C', '1', 'Nível de Giro', 'C'); // 62         -- DA EMPRESA LOGADA
  pCampo('CRISINT', 'C', '1', 'Nível de Criticidade', 'C'); // 62  -- DA EMPRESA LOGADA

  pCampo('ITE_PREUVE', 'N', '#,##0.00', '');
  pCampo('ITE_QTDUVE', 'N', '#,##0.00', '');
  pCampo('ITE_DTAUVE', 'D', '10', '', 'C');
  pCampo('ITE_NOMCLI', 'C', '70',  '');
  pCampo('ITE_CLIUVE', 'C', '08',  '');
  pCampo('ITE_ITEFRA', 'C', '01', '');

  pCampo('ITE_CODABF', 'C', '0' + IIf(fCfgSis('USASAN') = 'S', '7', '3'), 'Cód. Abr. Fiscal');       // 01

  pCampo('ITE_ALTERA', 'C', '01', '');
  pCampo('ITE_SEQCOT', 'C', '20', '');

  pCampo('ITE_DIAEST', 'I', '', '');                             //
  pCampo('ITE_DIASUG', 'I', '', '');                             //

  pCampo('ITE_DIAFOR', 'I', '', '');                             //

  pCampo('ITE_DIASAI', 'I', '', '');                             //

  pCampo('ITE_CORMED', 'I', '', '');                             //

  pCampo('ITE_DESSIT', 'C', '50', '');                  // DESC. SITUAÇÃO DO PRODUTO
  pCampo('ITE_CORSIT', 'I', '',   '');                  // COR DA SITUAÇÃO DO PRODUTO

  pCampo('ITE_FORPRI', 'C', '80', 'Fornecedor Principal');       // 04
  pCampo('ITE_DEPART', 'C', '60', 'Departamento');       // 04

  For intContador := 1 To 12 Do
  Begin

    {*****************************************}
    {* CRIA OS CAMPOS REFERENTES ÀS VENDAS   *}
    {*****************************************}
    pCampo('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2), 'N', '#,##0.00', '');
    pCampo('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2), 'N', '#,##0.00', '');

    {*****************************************}
    {* CRIA OS CAMPOS REFERENTES ÀS COMPRAS  *}
    {*****************************************}
    pCampo('ITE_Q_C_' + fStrZero(IntToStr(intContador), 2), 'N', '#,##0.00', '');

    {*****************************************}
    {* CRIA OS CAMPOS REFERENTES AOS MESES   *}
    {* DAS COMPRAS / VENDAS                  *}
    {*****************************************}
    pCampo('ITE_DESM' + fStrZero(IntToStr(intContador), 2), 'C', '7', '');

    {*****************************************}
    {* CRIA OS CAMPOS REF. QTD MAIOR VENDA   *}
    {*****************************************}
    pCampo('ITE_MQSA' + fStrZero(IntToStr(intContador), 2), 'N', '#,##0.00', '');

    {*****************************************}
    {* CRIA OS CAMPOS REF. DTA MAIOR VENDA   *}
    {*****************************************}
    pCampo('ITE_MDSA' + fStrZero(IntToStr(intContador), 2), 'D', '', '');

  End;

  pCampo('ITE_QTDCON', 'N', '#,##0.00', '');
  pCampo('ITE_SUGEST', 'N', '#,##0.00', '');
  pCampo('ITE_VENMES', 'N', '#,##0.00', 'Vendas Mês');
  pCampo('ITE_Q_VPME', 'N', '#,##0.00', 'Vendas Mês Promoção');
  pCampo('ITE_CODACA', 'C', '06', '');
  pCampo('ITE_EMPACA', 'C', '03', '');
  pCampo('ITE_PROACA', 'C', '01', '');
  pCampo('ITE_CONPAG', 'C', '50', '');
  pCampo('ITE_DESEMP', 'C', '50', '');
  pCampo('ITE_FANEMP', 'C', '50', '');
  pCampo('ITE_MEDIA_', 'N', '#,##0.00', '');
  pCampo('ITE_AJUSTA', 'N', '#,##0.00', '');  // MÉDIA AJUSTADA

  pCampo('ITE_MLTCOM', 'N', '#,##0.00', 'Qtd por Embalagem');

  pCampo('ITE_ABAMLT', 'C', '01', ''); // ABASTECER COM MULTIPIPLO DE COMPRA

  pCampo('ITE_MAQTSA', 'N', '#,##0.00', '');
  pCampo('ITE_MADTSA', 'D', '', '');
  pCampo('ITE_DTAPED', 'D', '', '');
  pCampo('ITE_DTAENT', 'D', '', '', 'C');
  pCampo('ITE_DTAEDT', 'D', '', '', 'C'); //ARMAZENA A DATA DE ENTREGA FUTURA SE ALTERADO
  pCampo('ITE_QTDTMP', 'N', '', '');
  pCampo('ITE_QTDANT', 'N', '', '');

  pCampo('ITE_ESTMIN', 'N', '#,##0.00', '');
  pCampo('ITE_ESTMAX', 'N', '#,##0.00', '');
  pCampo('ITE_PMED_V', 'N', '#,##0.00', '');

  pCampo('ITE_MINDIG', 'N', '#,##0.00', '');
  pCampo('ITE_MAXDIG', 'N', '#,##0.00', '');

  pCampo('ITE_ESMIDG', 'C', '01', '');

  pCampo('ITE_PONPED', 'N', '#,##0.00', '');

  pCampo('ITE_ABAPON', 'C', '01', '');

  pCampo('ITE_MEDIXX', 'N', '#,##0.00', '');
  pCampo('ITE_MEDAJU', 'N', '#,##0.00', '');

  pCampo('ITE_VARCOM', 'N', '#,##0.00', '');

  pCampo('ITE_LOCFIS', 'C', '30', 'Loc.Física');
  pCampo('ITE_INCPIS', 'C', '01', 'Incide PIS');

  pCampo('ITE_INCIRQ', 'T', '500', '');
  pCampo('ITE_QTDREQ', 'N', '#,##0.00', '');
  pCampo('ITE_CRIREQ', 'C', '01', '');        // INCLUIDO PELA REQUISIÇÃO
  pCampo('ITE_ATEREQ', 'C', '01', '');        // QUEM ATENDE A REQUISIÇÃO T = TRANSFERENCIA,  C.C. PEDIDO

  pCampo('ITE_QATREQ', 'N', '#,##0.00', '');  // QUANTIDADE RESERVADA PARA AS REQUISIÇOES

  pCampo('ITE_DIAUCO', 'I', '5', '');
  pCampo('ITE_DIAUVE', 'I', '5', '');

  pCampoAgg('MAX_AUTOINCREM', 'MAX(AUTOINCREM)', '');

  pCampo('ITE_CLAIPI', 'C', '10', 'NCM');
  pCampo('ITE_PRAVAL', 'I', '5', 'Tempo Validade(Meses)');
  pCampo('ITE_CODSIT', 'C', '3',  'CST');
  pCampo('ITE_SITORI', 'C', '3',  'CST ORIGEM');

  pCampo('ITE_PEDVEN', 'C', '12', 'Pedido de Venda');
  pCampo('ITE_ESPPVE', 'C', '2' , 'Espécie');
  pCampo('ITE_EMPPED', 'C', '3' , 'Empresa');
  pCampo('ITE_PEDDTA', 'D', '10', 'Data de Entrega');
  pCampo('ITE_SEQFDO', 'C', '20', '');
  pCampo('ITE_FORESC', 'C', '8', '');

  pCampo('ITE_IPIESC', 'N', '#,##0.00', '');
  pCampo('ITE_ST_ESC', 'N', '#,##0.00', '');
  pCampo('ITE_FREESC', 'N', '#,##0.00', '');
  pCampo('ITE_VRTESC', 'N', '#,##0.00', '');

  pCampo('ITE_AUTRES', 'C', '20', 'Código');  // AUTOINCREMENTO DA PCMDET_RES
  pCampo('ITE_DESGRU', 'C', '120', 'Descrição Grupo/Linha');       // 04
  pCampo('ITE_DESSIM', 'C', '120', 'Descrição Simplificada');       // 04

  pCampo('ITE_SALEXC', 'N', '#,##0.00', '');

  pCampo('ITE_PONEXP', 'N', '#,##0.00', '');
  pCampo('ITE_QTEP_S', 'N', '#,##0.00', '');

  pCampo('ITE_TIPABS', 'C', '1', 'Tipo Abastecimento');
  pCampo('ITE_VNOLCD', 'C', '1', 'Venda Saldo Outra Loja/CD');

  pCampo('ITE_ALQCBS', 'N', '#,##0.00', '% CBS');
  pCampo('ITE_ALQIBS', 'N', '#,##0.00', '% IBS');
  pCampo('ITE_ALQ_IS', 'N', '#,##0.00', '% IS');
  pCampo('ITE_VALCBS', 'N', '#,##0.00', 'Valor CBS');
  pCampo('ITE_VALIBS', 'N', '#,##0.00', 'Valor IBS');
  pCampo('ITE_VAL_IS', 'N', '#,##0.00', 'Valor IS');

  pCampoAgg('TOT_TOTSUB', 'SUM(ITE_TOTSUB)', '#,##0.00');
  pCampoAgg('TOT_TOTDAR', 'SUM(ITE_TOTDAR)', '#,##0.00');
  pCampoAgg('TOT_SUBFCP', 'SUM(ITE_SUBFCP)', '#,##0.00');

  pCampoAgg('TOT_TOTIPI', 'SUM(ITE_TOTIPI)', '#,##0.00');

  pCampoAgg('TOT_VALCBS', 'SUM(ITE_VALCBS)', '#,##0.00');
  pCampoAgg('TOT_VALIBS', 'SUM(ITE_VALIBS)', '#,##0.00');
  pCampoAgg('TOT_VAL_IS', 'SUM(ITE_VAL_IS)', '#,##0.00');

  pCampoAgg('TOT_TOTITE', 'SUM(ITE_TOTITE)', '#,##0.00');
  pCampoAgg('TOT_VALFRE', 'SUM(ITE_VALFRE)', '#,##0.00');
  pCampoAgg('TOT_DESACE', 'SUM(ITE_DESACE)', '#,##0.00');


  pCampoAgg('TOT_TOTGER', 'SUM(ITE_TOTITE) + SUM(ITE_TOTSUB) + SUM(ITE_SUBFCP) + SUM(ITE_TOTIPI)' +
                    IIF(fSomarNovosImpostosDaReformaAoValorContabil, ' + SUM(ITE_VALCBS) + SUM(ITE_VALIBS) + SUM(ITE_VAL_IS)', '') +
                    IIF(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')), ' - SUM(ITE_VALICM) - SUM(ITE_DESPIS)', ''), '#,##0.00');

  pCampoAgg('TOT_LITROS', 'SUM(ITE_LITROS)', '#,##0.00');
  pCampoAgg('TOT_PESOIT', 'SUM(ITE_PESOIT)', '#,##0.00');

  pCampoAgg('TOT_BASCOF', 'SUM(ITE_BASCOF)', '#,##0.00');
  pCampoAgg('TOT_VALCOF', 'SUM(ITE_VALCOF)', '#,##0.00');
  pCampoAgg('TOT_BASPIS', 'SUM(ITE_BASPIS)', '#,##0.00');
  pCampoAgg('TOT_VALPIS', 'SUM(ITE_VALPIS)', '#,##0.00');

  pCampoAgg('TOT_BASICM', 'SUM(ITE_BASICM)', '#,##0.00');
  pCampoAgg('TOT_VALICM', 'SUM(ITE_VALICM)', '#,##0.00');
  pCampoAgg('TOT_BASIPI', 'SUM(ITE_BASIPI)', '#,##0.00');
  pCampoAgg('TOT_BASSUB', 'SUM(ITE_BASSUB)', '#,##0.00');

  pCampoAgg('TOT_DESPIS', 'SUM(ITE_DESPIS)', '#,##0.00');

  pCampoAgg('TOT_VALIMP', 'SUM(ITE_VALIMP)', '#,##0.00');
  pCampoAgg('TOT_VALSIS', 'SUM(ITE_VALSIS)', '#,##0.00');
  pCampoAgg('TOT_VALMAR', 'SUM(ITE_VALMAR)', '#,##0.00');

  pCampoAgg('TOT_IPIESC', 'SUM(ITE_IPIESC)', '#,##0.00');
  pCampoAgg('TOT_ST_ESC', 'SUM(ITE_ST_ESC)', '#,##0.00');
  pCampoAgg('TOT_FREESC', 'SUM(ITE_FREESC)', '#,##0.00');
  pCampoAgg('TOT_VRTESC', 'SUM(ITE_VRTESC)', '#,##0.00');



  pGerarCampos;
  pGerarCamposAgg(Result);

  Result.CreateDataSet;

  For intContador := Low(arrCampos) To High(arrCampos) Do
  Begin
    Result.Fields[intContador].DisplayLabel := arrCampos[intContador][4];

    If arrCampos[intContador][2] = 'N' Then
    Begin
      TFloatField(Result.Fields[intContador]).DisplayFormat := arrCampos[intContador][3];
      Result.Fields[intContador].DefaultExpression := '0';
    End;

    If arrCampos[intContador][5] = 'C' Then
      Result.Fields[intContador].Alignment := taCenter;
  End;

  Result.BeforePost := TCalculaCamposPedido.pCalcFields;
end;

procedure pZeraMultiLojas(strCodIte: String; cdsItensMultiLojas: TUniClientDataSet; blnDeletandoItem: Boolean);
  Var
    strFilter: String;
    blnFiltered: Boolean;
    blnDisabled: Boolean;
    pBeforePost: TBeforePost;
Begin
  If Assigned(cdsItensMultiLojas) Then
  With cdsItensMultiLojas Do
  Begin
    pBeforePost := cdsItensMultiLojas.BeforePost;
    If blnDeletandoItem Then
      cdsItensMultiLojas.BeforePost := nil;

    blnDisabled  := ConstraintsDisabled;

    If Not blnDisabled Then
      DisableControls;

    strFilter   := Filter;
    blnFiltered := Filtered;

    Try

      Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte);
      Filtered := True;
      First;

      While Not Eof Do
      Begin
        Edit;
        FieldByName('ITE_QTDITE').AsFloat := 0;
        FieldByName('ITE_TOTITE').AsFloat := 0;
        FieldByName('ITE_TOTIPI').AsFloat := 0;
        FieldByName('ITE_TOTSUB').AsFloat := 0;
        FieldByName('ITE_TOTDAR').AsFloat := 0;
        FieldByName('ITE_PERFCP').AsFloat := 0;
        FieldByName('ITE_SUBFCP').AsFloat := 0;
        FieldByName('ITE_VALCBS').AsFloat := 0;
        FieldByName('ITE_VALIBS').AsFloat := 0;
        FieldByName('ITE_VAL_IS').AsFloat := 0;
        Post;

        Next;
      End;

    Finally
      If  blnDeletandoItem Then
        cdsItensMultiLojas.beforePost := pBeforePost;
      Filter   := strFilter;
      Filtered := blnFiltered;

      If Not blnDisabled Then
        EnableControls;

    End;
  End;
End;

Procedure pCalculaVariacaoCompra(cdsItens: TDataSet);
Begin
  With cdsItens Do
  Begin
    If FieldByName('ITE_EMBALA').AsFloat = 0 Then
      FieldByName('ITE_EMBALA').AsFloat := 1;

    If (FieldByName('ITE_PREULT').AsFloat > 0) And (FieldByName('ITE_UNILIQ').AsFloat > 0) Then
      FieldByName('ITE_VARCOM').AsFloat := ((FieldByName('ITE_UNILIQ').AsFloat / FieldByName('ITE_EMBALA').AsFloat - FieldByName('ITE_PREULT').AsFloat) / FieldByName('ITE_PREULT').AsFloat) * 100
    Else
      FieldByName('ITE_VARCOM').Clear;

    If (RoundTo(FieldByName('ITE_QTDITE').AsFloat, -4) <> RoundTo(FieldByName('ITE_QTDINC').AsFloat, -4)) Or
       (RoundTo(FieldByName('ITE_QTDTRA').AsFloat, -4) <> RoundTo(FieldByName('ITE_TRAINC').AsFloat, -4)) Then
      FieldByName('ITE_QTDALT').AsString := 'S'
    Else
      FieldByName('ITE_QTDALT').AsString := 'N';
  End;
End;

Function fGetSQLPedidosComQuantidadeBaixada: String;
Begin
  Result := Result + 'SELECT IFNULL(SUM(PCD_QTDBAI),0) AS QUANTIA_BAIXADA ';
  Result := Result + 'FROM PCMGER'                                         ;
  Result := Result + '  INNER JOIN PCMDET'                                 ;
  Result := Result + '    ON (  PCD_NUMPED = PCG_NUMPED AND'               ;
  Result := Result + '          PCD_ESPDOC = PCG_ESPDOC AND'               ;
  Result := Result + '          PCD_CODEMP = PCG_CODEMP)'                  ;
  Result := Result + '  WHERE PCG_NUMCTN = 0 '                             ;
  Result := Result + '    AND PCG_NUMPED = :NUMPED'                        ;
  Result := Result + '    AND PCG_ESPDOC = :ESPDOC'                        ;
  Result := Result + '    AND PCG_CODEMP = :CODEMP'                        ;
End;

Function fGetSQLPedidosBaixado: String;
Begin
  Result := Result + 'SELECT COUNT(1) AS QTD '    ;
  Result := Result + '  FROM PCMGER'              ;
  Result := Result + ' WHERE PCG_NUMCTN = 0 '     ;
  Result := Result + '   AND PCG_NUMPED = :NUMPED';
  Result := Result + '   AND PCG_ESPDOC = :ESPDOC';
  Result := Result + '   AND PCG_CODEMP = :CODEMP';
  Result := Result + '   AND PCG_BAIXAD = 1'      ;
End;


Function fValidaPedBaixado(strNumPed, strEspDoc, strCodEmp: String):Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(fGetSQLPedidosBaixado);

    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    Try
      qryAux.Open;
    Except
      On E:Exception Do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fValidaPedBaixado]');
      end;
    End;
    Result := qryAux.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
End;


Function fValidaPedComQuantidadeBaixada(strNumPed, strEspDoc, strCodEmp: String):Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add(fGetSQLPedidosComQuantidadeBaixada);

    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    Try
      qryAux.Open;
    Except
      On E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fValidaPedComQuantidadeBaixada]');

      End;
    End;
    Result := qryAux.FieldByName('QUANTIA_BAIXADA').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
End;

Function fDesfazerBaixaPedidoNaoEntregue(strNumPed, strEspDoc, strCodEmp: String; blnVisualizarMensagem: Boolean = true):Boolean;
var
  qryAux: TUniQuery;
  strMotBai,
  strNumCtn,
  strAutInc: String;
Begin
  qryAux := fCriaQuery;

  With qryAux,SQL Do
  Begin
    Clear;
    Add(' SELECT SQL_NO_CACHE PCMGER.PCG_MOTBAI,       ');
    Add('                     PCMGER.AUTOINCREM,       ');
    Add('                     PCMGER.PCG_NUMCTN        ');
    Add(' FROM PCMGER                                  ');
    Add('  INNER JOIN PCMDET                           ');
    Add('     ON PCMGER.PCG_NUMPED = PCMDET.PCD_NUMPED ');
    Add('    AND PCMGER.PCG_CODEMP = PCMDET.PCD_CODEMP ');
    Add('    AND PCMGER.PCG_ESPDOC = PCMDET.PCD_ESPDOC ');
    Add('    AND PCMGER.PCG_CODFOR = PCMDET.PCD_CODFOR ');
    Add('    AND PCMGER.PCG_NUMCTN = PCMDET.PCD_NUMCTN ');
    Add('  WHERE PCMGER.PCG_NUMPED = :NUMPED  AND      ');
    Add('        PCMGER.PCG_ESPDOC = :ESPDOC  AND      ');
    Add('        PCMGER.PCG_CODEMP = :CODEMP           ');
    Add(' LIMIT 1                                      ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Try
      Open;
      strMotBai := FieldByName('PCG_MOTBAI').AsString;
      strAutInc := FieldByName('AUTOINCREM').AsString;
      strNumCtn := FieldByName('PCG_NUMCTN').AsString;

    Except On E:Exception Do
      Begin
        pMensagensErro(E.Message, '[fBaixaPedidoNaoEntregue]');
      End;
    End;
    fStartTransaction;
    Close;

    Clear;
    Add('UPDATE PCMGER SET PCG_MOTBAI = NULL, ');
    Add('                  PCG_CODOPE = NULL, ');
    Add('                  PCG_DTABAI = NULL, ');
    Add('                  PCG_HORBAI = NULL, ');
    Add('                  PCG_CODOCO = NULL, ');
    Add('                  PCG_BAIXAD = 0  '   );
    Add('WHERE AUTOINCREM = :AUTINC;');

    ParamByName('AUTINC').AsString := strAutInc;

    Add('UPDATE PCMDET SET PCD_BAIXAD = 0,'     );
    Add('                  PCD_ENTREG = NULL'   );
    Add('  WHERE PCD_NUMPED = :NUMPED AND'      );
    Add('        PCD_CODEMP = :CODEMP AND'      );
    Add('        PCD_ESPDOC = :ESPDOC;'         );



    SQL.Add('UPDATE CONCOL');
    SQL.Add('   LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = CONCOL.CON_AUTDET');
    SQL.Add('   LEFT JOIN PCMGER ON PCD_NUMPED = PCG_NUMPED ');
    SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP ');
    SQL.Add('                   AND PCD_ESPDOC = PCG_ESPDOC ');
    SQL.Add('    SET CONCOL.CON_BAIXAD = "N" ');
    SQL.Add('  WHERE PCG_NUMPED = :NUMPED');
    SQL.Add('    AND PCG_CODEMP = :CODEMP');
    SQL.Add('    AND PCG_ESPDOC = :ESPDOC;');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;

    Try

      ExecSQL;
      Result := True;

      If Result Then
         pEstornaSaldoPedidoCompra(strNumPed, strEspDoc, strCodEmp);
      If (Result) And (fGerarLogDesBai(strNumPed, strEspDoc, strCodEmp, strNumCtn, strMotBai)) Then
      Begin
        fCommit;
        If blnVisualizarMensagem Then
          fMensagem('', 'Baixa desfeita com sucesso!', ['&Ok']);
      End
      Else
        fRollBack;
    Except
      On E:Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[fBaixaPedidoNaoEntregue]');
      End;
    End;
  End;


  FreeAndNil(qryAux);
End;

Function fGerarLogDesBai(strNumPed, strEspDoc, strCodEmp, strNumCtn, strMotBai: String):Boolean;
var
  qryIns: TUniQuery;
Begin
  qryIns := fCriaQuery;

  With qryIns, SQL Do
  Begin
    Add(' INSERT INTO DESBAI (AUTOINCREM,');
    Add('                     DES_DTAOCO,');
    Add('                     DES_HRAOCO,');
    Add('                     DES_CODOPE,');
    Add('                     DES_NUMPED,');
    Add('                     DES_ESPDOC,');
    Add('                     DES_CODEMP,');
    Add('                     DES_MOTBAI,');
    Add('                     DES_NUMCTN)');
    Add('            VALUES (:AUTOINCREM,');
    Add('                        :DTAOCO,');
    Add('                        :HRAOCO,');
    Add('                        :CODOPE,');
    Add('                        :NUMPED,');
    Add('                        :ESPDOC,');
    Add('                        :CODEMP,');
    Add('                        :MOTBAI,');
    Add('                        :NUMCTN)');

    ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('DESBAI', VS_strCodEmp);
    ParamByName('DTAOCO').AsDate       := Date;
    ParamByName('HRAOCO').AsTime       := fTime();
    ParamByName('CODOPE').AsString     := strLoginUsuarioLogado;
    ParamByName('NUMPED').AsString     := strNumPed;
    ParamByName('ESPDOC').AsString     := strEspDoc;
    ParamByName('CODEMP').AsString     := strCodEmp;
    ParamByName('MOTBAI').AsString     := strMotBai;
    ParamByName('NUMCTN').AsString     := strNumCtn;

    Try
      ExecSQL;
      Result := True;
    Except
      on E:Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGerarLogDesBai]');
      End;
    End;
  End;

  FreeAndNil(qryIns);
End;

procedure pVoltaQtdTmpMultiLojas(strCodIte: String; cdsItensMultiLojas: TUniClientDataSet);
  Var
     blnFiltra: Boolean;
     pAfterPost: TprcScroll;
begin
  cdsItensMultiLojas.DisableControls;
  pAfterPost := cdsItensMultiLojas.AfterPost;
  cdsItensMultiLojas.AfterPost := Nil;
  Try
    blnFiltra := False;
    If (Not cdsItensMultiLojas.Filtered) Or (Not SameText(cdsItensMultiLojas.Filter, 'ITE_CODITE = ' + QuotedStr(strCodIte))) Then
    Begin
      cdsItensMultiLojas.Filtered := False;
      cdsItensMultiLojas.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
      cdsItensMultiLojas.Filtered := True;
      blnFiltra := True;
    End;
    Try
      cdsItensMultiLojas.First;
      While (Not cdsItensMultiLojas.Eof) Do
      Begin
        If cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat <> cdsItensMultiLojas.FieldByName('ITE_QTDTMP').AsFloat Then
        Begin
          cdsItensMultiLojas.Edit;
          cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat := cdsItensMultiLojas.FieldByName('ITE_QTDTMP').AsFloat;
          cdsItensMultiLojas.Post;
        End;
        cdsItensMultiLojas.Next;
      End;
    Finally
      If blnFiltra Then
        cdsItensMultiLojas.Filter := 'ITE_CODITE = ' + QuotedStr(strCodIte);
    End;
  Finally
    cdsItensMultiLojas.AfterPost := pAfterPost;
    cdsItensMultiLojas.EnableControls;
  End;
end;

function fDiasCompra(recNivEst: TRecOpcoesNivel): Integer;
var strNivGirFor: String;
begin
  With recNivEst Do
  Begin

    Result := intDiaComGer;

    Case recNivEst.nivEstoque Of
      nivGiroFornecedor: Begin
                           strNivGirFor := recNivEst.strIteGir;
                           If Length(strNivGirFor) > 1 Then
                             strNivGirFor := strNivGirFor[1];


                           If strNivGirFor = 'A' Then
                             Result := intDiaComNvA

                           Else If strNivGirFor = 'B' Then
                             Result := intDiaComNvB

                           Else If strNivGirFor = 'C' Then
                             Result := intDiaComNvC;

                         End;
      nivGiro: Begin
                 If strIteGir = 'A' Then
                   Result := intDiaComNvA

                 Else If strIteGir = 'B' Then
                   Result := intDiaComNvB

                 Else If strIteGir = 'C' Then
                   Result := intDiaComNvC;
               end;

      nivCriticidade: Begin
                        If strIteCri = 'Z' Then
                           Result := intDiaComNvZ

                        Else If strIteCri = 'Y' Then
                          Result := intDiaComNvY

                        Else If strIteCri = 'X' Then
                          Result := intDiaComNvX;
                      end;

      nivAmbos: Begin
                  If strIteGir = 'A' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := intDiaComNvAZ

                    Else If strIteCri = 'Y' Then
                      Result := intDiaComNvAY

                    Else If strIteCri = 'X' Then
                      Result := intDiaComNvAX;
                  End

                  Else If strIteGir = 'B' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := intDiaComNvBZ

                    Else If strIteCri = 'Y' Then
                      Result := intDiaComNvBY

                    Else If strIteCri = 'X' Then
                      Result := intDiaComNvBX;
                  End

                  Else If strIteGir = 'C' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := intDiaComNvCZ

                    Else If strIteCri = 'Y' Then
                      Result := intDiaComNvCY

                    Else If strIteCri = 'X' Then
                      Result := intDiaComNvCX;
                  End;
                end;
    End;

  End;
end;

function fPercElevacaoConsumiveis(recNivEst: TRecOpcoesNivel): Double;
var strNivGirFor: String;
begin
  With recNivEst Do
  Begin

    Result := fltPerConGer;

    Case nivEstoque Of
      nivGiroFornecedor: Begin
                           strNivGirFor := recNivEst.strIteGir;
                           If Length(strNivGirFor) > 1 Then
                             strNivGirFor := strNivGirFor[1];


                           If strNivGirFor = 'A' Then
                             Result := fltPerConA

                           Else If strNivGirFor = 'B' Then
                             Result := fltPerConB

                           Else If strNivGirFor = 'C' Then
                             Result := fltPerConC;

                         End;

      nivGiro: Begin
                 If strIteGir = 'A' Then
                   Result := fltPerConA

                 Else If strIteGir = 'B' Then
                   Result := fltPerConB

                 Else If strIteGir = 'C' Then
                   Result := fltPerConC;
               end;

      nivCriticidade: Begin
                        If strIteCri = 'Z' Then
                           Result := fltPerConZ

                        Else If strIteCri = 'Y' Then
                          Result := fltPerConY

                        Else If strIteCri = 'X' Then
                          Result := fltPerConX;
                      end;

      nivAmbos: Begin
                  If strIteGir = 'A' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := fltPerConAZ

                    Else If strIteCri = 'Y' Then
                      Result := fltPerConAY

                    Else If strIteCri = 'X' Then
                      Result := fltPerConAX;
                  End

                  Else If strIteGir = 'B' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := fltPerConBZ

                    Else If strIteCri = 'Y' Then
                      Result := fltPerConBY

                    Else If strIteCri = 'X' Then
                      Result := fltPerConBX;
                  End

                  Else If strIteGir = 'C' Then
                  Begin
                    If strIteCri = 'Z' Then
                      Result := fltPerConCZ

                    Else If strIteCri = 'Y' Then
                      Result := fltPerConCY

                    Else If strIteCri = 'X' Then
                      Result := fltPerConCX;
                  End;
                end;
    End;

  End;
end;


function fEscreAsteriscoPromocao(recOpcGir: TRecOpcoesGiro): string;
begin
  Result := '';
  If(recOpcGir.blnUsaGiro) and (recOpcGir.strPedMlj = 'S') and (not recOpcGir.blnCotacao) Then
    Result := '(*)';
End;

function fDiasPorNivel(recNivEst: TRecOpcoesNivel): String;
Begin
  Result := '';

  With recNivEst Do
  Case nivEstoque Of
    nivGiro: Begin
               Result := Result + 'A: ' + IntToStr(intDiaComNvA) + ', ';
               Result := Result + 'B: ' + IntToStr(intDiaComNvB) + ', ';
               Result := Result + 'C: ' + IntToStr(intDiaComNvC);
             end;

    nivCriticidade: Begin
                      Result := Result + 'Z: ' + IntToStr(intDiaComNvZ) + ', ';
                      Result := Result + 'Y: ' + IntToStr(intDiaComNvY) + ', ';
                      Result := Result + 'X: ' + IntToStr(intDiaComNvX);
                    end;

    nivAmbos: Begin
                Result := Result + 'AZ: ' + IntToStr(intDiaComNvAZ) + ', ';
                Result := Result + 'AY: ' + IntToStr(intDiaComNvAY) + ', ';
                Result := Result + 'AX: ' + IntToStr(intDiaComNvAX) + ', ';

                Result := Result + 'BZ: ' + IntToStr(intDiaComNvBZ) + ', ';
                Result := Result + 'BY: ' + IntToStr(intDiaComNvBY) + ', ';
                Result := Result + 'BX: ' + IntToStr(intDiaComNvBX) + ', ';

                Result := Result + 'CZ: ' + IntToStr(intDiaComNvCZ) + ', ';
                Result := Result + 'CY: ' + IntToStr(intDiaComNvCY) + ', ';
                Result := Result + 'CX: ' + IntToStr(intDiaComNvCX);
              end;

    Else Result := IntToStr(intDiaComGer);

  End;
End;

Procedure pRetCamposGiro(cdsItensGiro: TUniClientDataSet;
                         strCodIte,
                         strEmpresas,
                         strMeses: String;
                         blnConsMesAtu: Boolean;
                         intMesGir,
                         intMosMes: Integer;
                         recNivEst: TRecOpcoesNivel;
                         strCodSim: String);
  Var
    intContador: Integer;
    qryGenGir: TUniQuery;
    wrdMes: Word;
    dtaBase,
    dtaMaiSai,
    dtaMaiSaiTodas: TDate;
    fltMedia,
    fltMedAju,
    fltQtdSai,
    fltMaiSai,
    fltMaiSaiTodas: Double;
    stlMeses: TStringList;

    intQtdDias: Integer;
    fltQtdSaiPromoc,
    fltSaiMaior,
    fltSaiMenor: Double;

    intDiaSaiEmpresas,
    intDiaSai,
    intDiaSaiMaior,
    intDiaSaiMenor: Integer;

    intDiaMaior,
    intDiaMenor: Integer;

    blnDiaSai: Boolean;

    Procedure pRetGiro(dtaBase: TDateTime);
      Var
        strSQL: String;
    Begin
      wrdMes := MonthOf(dtaBase);

      strSQL := '';

      With qryGenGir, SQL Do
      Begin
        Close;
        Clear;

        strSQL := strSQL + ' SELECT ';

        If fEmptyStr(strCodSim) Then
        Begin
          strSQL := strSQL + ' GIR_DSAI' + fStrZero(wrdMes, 2) + ' AS GIR_DSAI' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' GIR_QSAI' + fStrZero(wrdMes, 2) + ' AS GIR_QSAI' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' GIR_MQSA' + fStrZero(wrdMes, 2) + ' AS GIR_MQSA' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' GIR_QPSA' + fStrZero(wrdMes, 2) + ' AS GIR_QPSA' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' GIR_MDSA' + fStrZero(wrdMes, 2) + ' AS GIR_MDSA' + fStrZero(wrdMes, 2);
        End Else
        Begin
          strSQL := strSQL + ' SUM(IFNULL(GIR_DSAI' + fStrZero(wrdMes, 2) + ', 0)) AS GIR_DSAI' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' SUM(IFNULL(GIR_QSAI' + fStrZero(wrdMes, 2) + ', 0)) AS GIR_QSAI' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' SUM(IFNULL(GIR_QPSA' + fStrZero(wrdMes, 2) + ', 0)) AS GIR_QPSA' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' (SELECT GG.GIR_QPSA' + fStrZero(wrdMes, 2) + ' FROM GIRITE GG WHERE GG.GIR_CODEMP = G.GIR_CODEMP AND GG.GIR_A_N_O_ = G.GIR_A_N_O_ AND GG.GIR_CODITE = :CODITE) AS GIR_QPSA' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' (SELECT GG.GIR_MQSA' + fStrZero(wrdMes, 2) + ' FROM GIRITE GG WHERE GG.GIR_CODEMP = G.GIR_CODEMP AND GG.GIR_A_N_O_ = G.GIR_A_N_O_ AND GG.GIR_CODITE = :CODITE) AS GIR_MQSA' + fStrZero(wrdMes, 2) + ', ';
          strSQL := strSQL + ' (SELECT GG.GIR_MDSA' + fStrZero(wrdMes, 2) + ' FROM GIRITE GG WHERE GG.GIR_CODEMP = G.GIR_CODEMP AND GG.GIR_A_N_O_ = G.GIR_A_N_O_ AND GG.GIR_CODITE = :CODITE) AS GIR_MDSA' + fStrZero(wrdMes, 2);
        End;

        strSQL := strSQL +  ' FROM ';
        strSQL := strSQL + '    GIRITE G ';

        If Not fEmptyStr(strCodSim) Then
          strSQL := strSQL + '  INNER JOIN CADITE CS ON CS.ITE_CODITE = GIR_CODITE ';

        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '  GIR_A_N_O_ = :ANOGIR AND ';

        If Not strEmpresas.IsEmpty Then
          strSQL := strSQL + '  GIR_CODEMP IN (' + strEmpresas + ') AND ';

        If fEmptyStr(strCodSim) Then
          strSQL := strSQL + '  GIR_CODITE = :CODITE '
        Else
          strSQL := strSQL + '  CS.ITE_CODSIM = :CODSIM ';

        qryGenGir.SQL.Text := strSQL;

        ParamByName('CODITE').AsString  := strCodIte;

        If Not fEmptyStr(strCodSim) Then
          ParamByName('CODSIM').AsString  := strCodSim;

        ParamByName('ANOGIR').AsInteger := YearOf(dtaBase);

        Open;
      End;
    End;

Begin
  If fEmptyStr(strMeses) Then
    Exit;

  blnDiaSai := fCfgSis('GIRDIA', varInteger) = 2;

  If intMesGir = 0 Then
    intMesGir := 3;

  stlMeses := TStringList.Create;
  stlMeses.Text := strMeses;

  qryGenGir := fCriaQuery(Nil);

  fltMedia   := 0;
  fltMedAju  := 0;
  intQtdDias := 0;

  fltSaiMaior := 0;
  fltSaiMenor := -1;

  intDiaMaior := 0;
  intDiaMenor := 0;

  intDiaSai := 0;

  intDiaSaiMaior := 0;
  intDiaSaiMenor := 0;

  fltMaiSaiTodas := 0;
  dtaMaiSaiTodas := 0;

  For intContador := 1 To intMosMes Do
  Begin
    dtaBase   := EncodeDate(StrToIntDef(LeftStr(stlMeses[Pred(intContador)], 4), 0),
                            StrToIntDef(RightStr(stlMeses[Pred(intContador)], 2), 0),
                            1);

    fltMaiSai := 0;
    fltQtdSai := 0;
    dtaMaiSai := 0;
    fltQtdSaiPromoc := 0;
    intDiaSaiEmpresas := 0;

    pRetGiro(dtaBase);

    With qryGenGir Do
    Begin

      While Not Eof Do
      Begin

        fltQtdSai := fltQtdSai + qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(wrdMes), 2)).AsFloat;
        fltQtdSaiPromoc := fltQtdSaiPromoc + qryGenGir.FieldByName('GIR_QPSA' + fStrZero(IntToStr(wrdMes), 2)).AsFloat;
        intDiaSaiEmpresas := intDiaSaiEmpresas + qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(wrdMes), 2)).AsInteger;

        If (intContador <= intMesGir) And
           (qryGenGir.FieldByName('GIR_MQSA' + fStrZero(IntToStr(wrdMes), 2)).AsFloat > fltMaiSai) Then
        Begin
          fltMaiSai := qryGenGir.FieldByName('GIR_MQSA' + fStrZero(IntToStr(wrdMes), 2)).AsFloat;
          dtaMaiSai := qryGenGir.FieldByName('GIR_MDSA' + fStrZero(IntToStr(wrdMes), 2)).AsDateTime;

          If fltMaiSai > fltMaiSaiTodas Then
          Begin
            fltMaiSaiTodas := fltMaiSai;
            dtaMaiSaiTodas := dtaMaiSai;
          End;
        End;

        Next;
      End;
    End;

    cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat    := fltQtdSai;
    cdsItensGiro.FieldByName('ITE_Q_VP' + fStrZero(IntToStr(intContador), 2)).AsFloat    := fltQtdSaiPromoc;
    cdsItensGiro.FieldByName('ITE_MQSA' + fStrZero(IntToStr(intContador), 2)).AsFloat    := fltMaiSai;
    cdsItensGiro.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador), 2)).AsDateTime := dtaMaiSai;
    cdsItensGiro.FieldByName('ITE_DESM' + fStrZero(IntToStr(intContador), 2)).AsString := FormatDateTime('mm/yyyy', dtaBase);

    If dtaMaiSai = 0 Then
      cdsItensGiro.FieldByName('ITE_MDSA' + fStrZero(IntToStr(intContador), 2)).Clear;

    If intContador <= intMesGir Then
    Begin
      fltMedia := fltMedia + cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat;

      intDiaSai := intDiaSai + intDiaSaiEmpresas;

      If cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat > fltSaiMaior Then
      Begin
        fltSaiMaior    := cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat;
        intDiaMaior    := DaysInAMonth(YearOf(dtaBase), MonthOf(dtaBase));
        intDiaSaiMaior := intDiaSaiEmpresas;
      End;

      If (cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat < fltSaiMenor) Or (fltSaiMenor = -1) Then
      Begin
        fltSaiMenor    := cdsItensGiro.FieldByName('ITE_Q_V_' + fStrZero(IntToStr(intContador), 2)).AsFloat;
        intDiaMenor    := DaysInAMonth(YearOf(dtaBase), MonthOf(dtaBase));
        intDiaSaiMenor := intDiaSaiEmpresas;
      End;

      If (YearOf(VS_Date)= YearOf(dtaBase)) And (MonthOf(VS_Date) = MonthOf(dtaBase)) Then
      Begin

        If Not blnConsMesAtu Then
          intQtdDias := intQtdDias + DayOfTheMonth(VS_Date) - 1;

      End Else
      Begin

        intQtdDias := intQtdDias + DaysInAMonth(YearOf(dtaBase), MonthOf(dtaBase));

      End;

    End;
  End;

  cdsItensGiro.FieldByName('ITE_MAQTSA').AsFloat    := fltMaiSaiTodas;
  cdsItensGiro.FieldByName('ITE_MADTSA').AsDateTime := dtaMaiSaiTodas;

  If dtaMaiSaiTodas = 0 Then
    cdsItensGiro.FieldByName('ITE_MADTSA').Clear;

  If blnConsMesAtu Then
  Begin
    Inc(intMesGir);
    pRetGiro(VS_Date);
    fltMedia := fltMedia + qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsFloat;

    intDiaSai := intDiaSai + qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsInteger;

    If qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsFloat > fltSaiMaior Then
    Begin
      fltSaiMaior := qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsFloat;
      intDiaMaior := DayOfTheMonth(VS_Date) - 1;
      intDiaSaiMaior := qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsInteger;
    End;

    If (qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsFloat < fltSaiMenor) Or (fltSaiMenor = -1) Then
    Begin
      fltSaiMenor := qryGenGir.FieldByName('GIR_QSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsFloat;
      intDiaMenor := DayOfTheMonth(VS_Date) - 1;
      intDiaSaiMenor := qryGenGir.FieldByName('GIR_DSAI' + fStrZero(IntToStr(MonthOf(VS_Date)), 2)).AsInteger;
    End;

    intQtdDias := intQtdDias + DayOfTheMonth(VS_Date) - 1
  End;

  cdsItensGiro.FieldByName('ITE_DIASAI').AsInteger := intDiaSai;

  If blnDiaSai And (intDiaSai > 0) Then
  Begin
    cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat := RoundTo((fltMedia / intDiaSai) * 30, -2);

    If (intDiaSai - intDiaSaiMaior - intDiaSaiMenor) <> 0 Then
      fltMedAju := RoundTo(((fltMedia - fltSaiMaior - fltSaiMenor) / (intDiaSai - intDiaSaiMaior - intDiaSaiMenor)) * 30, -2);

  End Else
  Begin

    If blnConsMesAtu Then
    Begin

      If intQtdDias <> 0 Then
      Begin
        cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat := RoundTo((fltMedia / intQtdDias) * 30, -2);

        If (intQtdDias - intDiaMaior - intDiaMenor) <> 0 Then
          fltMedAju := RoundTo(((fltMedia - fltSaiMaior - fltSaiMenor) / (intQtdDias - intDiaMaior - intDiaMenor)) * 30, -2);

      End;

    End Else
    Begin

      cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat := RoundTo(fltMedia / intMesGir, -2);
      fltMedAju                                      := RoundTo((fltMedia - fltSaiMaior - fltSaiMenor) / (intMesGir - 2), -2);

    End;

  End;

  cdsItensGiro.FieldByName('ITE_AJUSTA').AsFloat := fltMedAju;

  recNivEst.strIteGir := cdsItensGiro.FieldByName('ITE_NVLGIR').AsString;
  recNivEst.strIteCri := cdsItensGiro.FieldByName('ITE_NVLCRI').AsString;

  cdsItensGiro.FieldByName('ITE_MEDIXX').AsFloat := RoundTo(cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30 * fDiasCompra(recNivEst), -2);

  cdsItensGiro.FieldByName('ITE_MEDAJU').AsFloat := RoundTo(fltMedAju / 30 * fDiasCompra(recNivEst), -2);

  If cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat > 0 Then
  Begin
    cdsItensGiro.FieldByName('ITE_DIAEST').AsInteger := Trunc(RoundTo(cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat /
                                                         (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30), -4));

    cdsItensGiro.FieldByName('ITE_DIASUG').AsInteger := Trunc(RoundTo((cdsItensGiro.FieldByName('ITE_SALDIS').AsFloat +
                                                               cdsItensGiro.FieldByName('ITE_SUGEST').AsFloat) /
                                                         (cdsItensGiro.FieldByName('ITE_MEDIA_').AsFloat / 30), -4));
  End Else
  Begin
    cdsItensGiro.FieldByName('ITE_DIAEST').Clear;
    cdsItensGiro.FieldByName('ITE_DIASUG').Clear;
  End;

  FreeAndNil(qryGenGir);
  FreeAndNil(stlMeses);
End;

Function fRetVendasMesItem(strCodIte, strCodSim, strEmpresas: String; intMes, intAno: Integer; blnPromocao: Boolean): Double;
  Var
    qrySoma: TUniQuery;
Begin
  qrySoma := fCriaQuery(Nil);

  With qrySoma, SQL Do
  Begin
    Add('SELECT ');
    Add(' SUM(IFNULL(' + IIf(blnPromocao,'GIR_QPSA',  'GIR_QSAI') + fStrZero(intMes, 2) + ', 0)) AS TOTAL');
    Add('FROM');
    Add('  GIRITE');

    If Not fEmptyStr(strCodSim) Then
      Add(' INNER JOIN CADITE CS ON CS.ITE_CODITE = GIR_CODITE');

    Add('WHERE');
    Add('  GIR_A_N_O_ = :ANOGIR AND ');
    Add('  GIR_CODEMP IN (' + strEmpresas + ') AND ');


    If fEmptyStr(strCodSim) Then
    Begin
      Add('  GIR_CODITE = :CODITE ');
      ParamByName('CODITE').AsString  := strCodIte;
    End Else
    Begin
      Add('  CS.ITE_CODSIM = :CODSIM ');
      ParamByName('CODSIM').AsString  := strCodSim;
    End;

    ParamByName('ANOGIR').AsInteger := intAno;

    Open;

    Result := FieldByName('TOTAL').AsFloat;

    Close;
  End;

  FreeAndNil(qrySoma);
End;

Function fRetUltimaCompa(qryIteger: TUniQuery; strCodIte, strCodEmp: String): Boolean;
Begin
  With qryIteger Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE        ');
    SQL.Add('  ITE_PREULT,              ');
    SQL.Add('  ITE_IMPULT,              ');
    SQL.Add('  ITE_FORULT,              ');
    SQL.Add('  ITE_QTDUCO,              ');
    SQL.Add('  ITE_DTAULT,              ');
    SQL.Add('  ITE_PONEXP,              ');
    SQL.Add('  CONCAT(ITE_FORULT, "-", FOR_NOMFOR) AS ITE_NOMFOR');
    SQL.Add('FROM                       ');
    SQL.Add('  ITEGER                   ');
    SQL.Add('INNER JOIN CADFOR ON FOR_CODFOR = ITE_FORULT  ');
    SQL.Add('WHERE                        ');
    SQL.Add('  ITE_CODITE = :CODITE AND   ');
    SQL.Add('  ITE_DTAULT IS NOT NULL AND ');
    SQL.Add('  ITE_QTDUCO > 0 AND         ');
    SQL.Add('  ITE_FORULT NOT IN (' + fRetornaForFil + ')');

    If Not fEmptyStr(strCodEmp) then
      SQL.Add(' AND ITE_CODEMP = :CODEMP ');

    SQL.Add('ORDER BY ITE_DTAULT DESC     ');
    SQL.Add('LIMIT 1                      ');
    ParamByName('CODITE').AsString := strCodIte;

    If Not fEmptyStr(strCodEmp) then
      ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    Result := Not IsEmpty;
  End;
End;

Procedure pCarregaUltimaCompra(cdsItensPedido: TDataSet; strCodIte, strCodEmp: String);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery;
  If fRetUltimaCompa(qryIteger, strCodIte, strCodEmp) Then
  Begin
    cdsItensPedido.FieldByName('ITE_PREULT').AsFloat    := qryIteger.FieldByName('ITE_PREULT').AsFloat;
    cdsItensPedido.FieldByName('ITE_IMPULT').AsFloat    := qryIteger.FieldByName('ITE_IMPULT').AsFloat;
    cdsItensPedido.FieldByName('ITE_QTDUCO').AsFloat    := qryIteger.FieldByName('ITE_QTDUCO').AsFloat;
    cdsItensPedido.FieldByName('ITE_FORULT').AsString   := qryIteger.FieldByName('ITE_FORULT').AsString;
    cdsItensPedido.FieldByName('ITE_NOMFOR').AsString   := qryIteger.FieldByName('ITE_NOMFOR').AsString;
    cdsItensPedido.FieldByName('ITE_DTAULT').Value      := qryIteger.FieldByName('ITE_DTAULT').Value;
    cdsItensPedido.FieldByName('ITE_PONEXP').Value      := qryIteger.FieldByName('ITE_PONEXP').AsFloat;

    If (Not cdsItensPedido.FieldByName('ITE_DTAULT').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
      cdsItensPedido.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime);
  End;
  FreeAndNil(qryIteger);
End;

Function fRetUltimaVenda(qryIteger: TUniQuery; strCodIte, strCodEmp: String; blnEntBrf: Boolean): Boolean;
Begin
  With qryIteger Do
  Begin
    Close;
    SQL.Text := fSQLUltimasVendas(1, Not fEmptyStr(strCodEmp), blnEntBrf, False);

    If Not fEmptyStr(strCodEmp) Then
      ParamByName('CODEMP').AsString := strCodEmp;

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;

    Open;
    Result := Not IsEmpty;
  End;
End;

Procedure pCarregaUltimaVenda(cdsItensPedido: TDataSet; strCodIte, strCodEmp: String; blnEntBrf: Boolean);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery;
  If fRetUltimaVenda(qryIteger, strCodIte, strCodEmp, blnEntBrf) Then
  Begin
    cdsItensPedido.FieldByName('ITE_PREUVE').AsFloat    := qryIteger.FieldByName('PR_UNITARIO').AsFloat;
    cdsItensPedido.FieldByName('ITE_QTDUVE').AsFloat    := qryIteger.FieldByName('QTDITE').AsFloat;
    cdsItensPedido.FieldByName('ITE_DTAUVE').Value      := qryIteger.FieldByName('DTA_MOV').Value;
    cdsItensPedido.FieldByName('ITE_CLIUVE').AsString   := qryIteger.FieldByName('CODCLI').AsString;
    cdsItensPedido.FieldByName('ITE_NOMCLI').AsString   := qryIteger.FieldByName('CODCLI').AsString + '-' + qryIteger.FieldByName('CLIENTE').AsString;
    cdsItensPedido.FieldByName('ITE_PONEXP').AsFloat   := qryIteger.FieldByName('ITE_PONEXP').AsFloat;

    If (Not cdsItensPedido.FieldByName('ITE_DTAUVE').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime > 0) Then
      cdsItensPedido.FieldByName('ITE_DIAUVE').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAUVE').AsDateTime);
  End;
  FreeAndNil(qryIteger);
End;

{*****************************************}
{* INSERE UM REGISTRO NO GIRITE, EM DE-  *}
{* TERMINADA COLUNA DE MES. SE O REGIS-  *}
{* TRO JA EXISTIR, A FUNÇÃO ATUALIZA O   *}
{* MESMO.                                *}
{**************************************MV*}
procedure pCalculaGiroAnalitico(dtaDataBase: TDateTime; strCodIte, strCodEmp: String;
  intQtdMes: Integer; strTipoChamadaGrid: string);

Var
    dtaBaseTmp: TDateTime;
    dtaDtaFin: TDate;
begin

  dtaDataBase := dtaDataBase - 1;
  dtaDtaFin := dtaDataBase;
  dtaBaseTmp := EndOfTheMonth(IncMonth(dtaDataBase, -1));
  Dec(intQtdMes);

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(102, 5779, [],
                        ['CODITE','CODEMP','DTAINI','DTAFIN','TIPGRD','AGPSIN'],
                        [strCodIte,
                        strCodEmp,
                        DateToStr(StartOfTheMonth(IncMonth(dtaBaseTmp, -intQtdMes))),
                        DateToStr(dtaDtaFin),
                        strTipoChamadaGrid,
                        'N'],
                        nil,
                        nil,
                        True);
  End;

end;

function fTransformaData(strmAnoMes: String): TDate;
var strData: String;
Begin
  strData  := '01/' + Copy(strmAnoMes, 6, 2) + '/' + Copy(strmAnoMes, 1, 4);
  Result := StrToDate(strData);
End;


procedure pCalculaGiroAnalitico(strCodIte, strCodEmp, strMeses, strTipoChamadaGrid: String; blnAgrSim: Boolean = False);
  var
    lstMeses : TStringList;
    arrParametros, arrValues: Array of String;
    i, intPos: integer;
    strAgrSim : String;
begin

  lstMeses := TStringList.Create;

  lstMeses.Text := strMeses;

  strAgrSim := 'N';

  If blnAgrSim then
    strAgrSim := 'S';

  SetLength(arrParametros, 28);
  SetLength(arrValues,  28);
  intPos := 0;
  arrParametros[intPos] := 'CODITE';
  arrValues[intPos] := strCodIte;
  inc(intPos);
  arrParametros[intPos] := 'CODEMP';
  arrValues[intPos] := strCodEmp;
  inc(intPos);

  For i := 0 To lstMeses.Count - 1 DO
  Begin
   If i = 0 Then
    Begin
      arrParametros[intPos] := 'DTAINI';
      arrValues[intPos] := DateToStr(StartOfTheMonth(fTransformaData(lstMeses[i])));
      inc(intPos);
      arrParametros[intPos] := 'DTAFIN';
      arrValues[intPos] := DateToStr(EndOfTheMonth(fTransformaData(lstMeses[i])));
      inc(intPos);
    End
    Else
    Begin
      arrParametros[intPos] := 'DTAIN' + intToStr(i);
      arrValues[intPos] := DateToStr(StartOfTheMonth(fTransformaData(lstMeses[i])));
      inc(intPos);
      arrParametros[intPos] := 'DTAFI' + intToStr(i);
      arrValues[intPos] := DateToStr(EndOfTheMonth(fTransformaData(lstMeses[i])));
      inc(intPos);
    End;

  End;

  For i := lstMeses.Count To 11 DO
  Begin
    arrParametros[intPos] := 'DTAIN' + intToStr(i);
    arrValues[intPos] := '';
    inc(intPos);
    arrParametros[intPos] := 'DTAFI' + intToStr(i);
    arrValues[intPos] := '';
    inc(intPos);

  End;

   arrParametros[intPos] := 'TIPGRD';
   arrValues[intPos] := strTipoChamadaGrid;
   inc(intPos);
   arrParametros[intPos] := 'AGPSIN';
   arrValues[intPos] := strAgrSim;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(102, 5779, [],
                        arrParametros ,
                        arrValues,
                        nil,
                        nil,
                        True);
  End;

end;


function fRetornaForFil: String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := '';

  qryTmp := fCriaQuery;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result + '"' + FieldByName('EMP_FORFIL').AsString + '", ';
          Next;
        End;

        Result := Copy(Result, 1, Length(Result) - 2);
      End;

  Finally
    qryTmp.Close;
    FreeAndNil(qryTmp);
  End;

end;

Procedure pAbreEmpresas(qryCadEmp: TUniQuery; strEmpresas: String = '');
Begin
  With qryCadEmp, SQL Do
  Begin
    Add('SELECT');
    Add('  EMP_CODEMP,');
    Add('  EMP_NOMEMP AS NOMENT, ');
    Add('  CONCAT(EMP_ENDERE, IF(EMP_ENDNUM = " ", "?", ", "), EMP_ENDNUM, " - ", EMP_BAIRRO) AS ENDENT, ');
    Add('  CONCAT(CID_NOMCID, " - ", CID_ESTADO) AS NOMCID ');
    Add('FROM CADEMP');
    Add('LEFT JOIN CADCID ON EMP_CODCID = CID_CODCID');

    If Not fEmptyStr(strEmpresas) Then
      Add('WHERE EMP_CODEMP IN (' + strEmpresas + ') ');

    Add('ORDER BY EMP_CODEMP');
    Open;
  End;
End;

Function fRetItensPed(cdsItensPedido: TUniClientDataSet): String;
begin
  Result := '';
  cdsItensPedido.First;
  While (Not cdsItensPedido.Eof) Do
  Begin
    If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
      Result := Result + IIf(Result = '', '', ',') + QuotedStr(cdsItensPedido.FieldByName('ITE_CODITE').AsString);
    cdsItensPedido.Next;
  End;
  cdsItensPedido.First;
end;

Function fTemPedidoEmpresa(cdsItensMultiLojas: TUniClientDataSet; qryCadEmp: TUniQuery; strItensPed: String): Boolean;
Begin
  If fEmptyStr(strItensPed) Then
  Begin
    Result := False;
    Exit;
  End;

  With cdsItensMultiLojas Do
  Begin
    AggregatesActive := False;
    Filtered := False;
    Filter   := 'ITE_CODEMP = ' + QuotedStr(qryCadEmp.FieldByName('EMP_CODEMP').AsString) + ' AND ITE_QTDITE > 0 ' +
                                 ' AND ITE_CODITE IN (' + strItensPed + ') ' ;
    Filtered := True;

    AggregatesActive := True;

    Active := False;
    Active := True;

    Result := (TAggregateField(FieldByName('TOT_TOTITE')).Value <> Null) And
              (TAggregateField(FieldByName('TOT_TOTITE')).Value > 0);
  End;
End;

Function fPedidoSoUmaLoja(cdsItensMultiLojas: TUniClientDataSet): Boolean;
  Var
    blnFilter: Boolean;
    strFilter: String;
    qryCadEmp: TUniQuery;
    intQtdEmp: Integer;
Begin
  If Not Assigned(cdsItensMultiLojas) Then
  Begin
    Result := False;
    Exit;
  End;

  With cdsItensMultiLojas Do
  Begin
    blnFilter := Filtered;
    strFilter := Filter;

    qryCadEmp := fCriaQuery;

    Try
      Filtered := False;
      Filter   := 'ITE_QTDITE > 0';
      Filtered := True;

      qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
      qryCadEmp.Open;

      intQtdEmp := 0;

      While Not qryCadEmp.Eof Do
      Begin
        If Locate('ITE_CODEMP', qryCadEmp.FieldByName('EMP_CODEMP').AsString, []) Then
          Inc(intQtdEmp);

        If intQtdEmp > 1 Then
          Break;

        qryCadEmp.Next;
      End;

    Finally
      Filtered := blnFilter;
      Filter   := strFilter;

      FreeAndNil(qryCadEmp);
    End;

    Result := intQtdEmp = 1;
  End;
End;

procedure pAjustaMultiLoja(cdsItensPedido, cdsItensMultiLojas: TUniClientDataSet; chkPedImp: Boolean = False);
  Var
    intDecUni: Integer;
begin
  {**********************************************}
  {* ATUALIZA DADOS PARA PEDIDO MULTILOJAS      *}
  {*******************************************MV*}
  intDecUni := fCfgSis('DECUNI', varInteger);

  cdsItensMultiLojas.Filtered := False;
  cdsItensMultiLojas.Filter   := 'ITE_QTDITE > 0';
  cdsItensMultiLojas.Filtered := True;

  cdsItensMultiLojas.IndexFieldNames := 'ITE_CODITE';

  cdsItensPedido.First;
  While Not cdsItensPedido.Eof Do
  Begin
    cdsItensMultiLojas.First;
    cdsItensMultiLojas.FindKey([cdsItensPedido.FieldByName('ITE_CODITE').AsString]);

    While (Not cdsItensMultiLojas.Eof) And
          (cdsItensMultiLojas.FieldByName('ITE_CODITE').AsString = cdsItensPedido.FieldByName('ITE_CODITE').AsString) Do
    Begin

      cdsItensMultiLojas.Edit;

      cdsItensMultiLojas.FieldByName('ITE_QTDEMB').Value    := cdsItensPedido.FieldByName('ITE_QTDEMB').Value;

      cdsItensMultiLojas.FieldByName('ITE_DTAENT').Value    := cdsItensPedido.FieldByName('ITE_DTAENT').Value;

      cdsItensMultiLojas.FieldByName('ITE_DESITE').AsString := cdsItensPedido.FieldByName('ITE_DESITE').AsString;

      cdsItensMultiLojas.FieldByName('ITE_SEQFDO').AsString := cdsItensPedido.FieldByName('ITE_SEQFDO').AsString;
      cdsItensMultiLojas.FieldByName('ITE_UNITAR').AsFloat  := cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUNI').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUN2').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUN3').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUN4').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUN5').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DESUN6').AsFloat  := cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_UNILIQ').AsFloat  := cdsItensPedido.FieldByName('ITE_UNILIQ').AsFloat;
      cdsItensMultiLojas.FieldByName('ITE_DIFPRE').AsFloat  := cdsItensPedido.FieldByName('ITE_DIFPRE').AsFloat;

      cdsItensMultiLojas.FieldByName('ITE_SUBUSU').AsString := cdsItensPedido.FieldByName('ITE_SUBUSU').AsString;

      cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat :=
        cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat *
          RoundTo(cdsItensPedido.FieldByName('ITE_UNITAR').AsFloat *
            ((1 - cdsItensPedido.FieldByName('ITE_DESUNI').AsFloat/100) *
             (1 - cdsItensPedido.FieldByName('ITE_DESUN2').AsFloat/100) *
             (1 - cdsItensPedido.FieldByName('ITE_DESUN3').AsFloat/100) *
             (1 - cdsItensPedido.FieldByName('ITE_DESUN4').AsFloat/100) *
             (1 - cdsItensPedido.FieldByName('ITE_DESUN5').AsFloat/100) *
             (1 - cdsItensPedido.FieldByName('ITE_DESUN6').AsFloat/100)), -intDecUni);

      If chkPedImp Then
        cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat + cdsItensMultiLojas.FieldByName('ITE_VALIMP').AsFloat
      Else
        cdsItensMultiLojas.FieldByName('ITE_BASIPI').AsFloat := IIF(cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat > 0, cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat, 0);

      cdsItensMultiLojas.FieldByName('ITE_TOTIPI').AsFloat := cdsItensMultiLojas.FieldByName('ITE_TOTITE').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_PERIPI').AsFloat / 100);

      If cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat > 0 Then
      Begin
        cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                     cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);

        cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat  := cdsItensPedido.FieldByName('ITE_TOTDAR').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                     cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);

        cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat  := cdsItensPedido.FieldByName('ITE_BASSUB').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                       cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);


        cdsItensMultiLojas.FieldByName('ITE_BASICM').AsFloat  := cdsItensPedido.FieldByName('ITE_BASICM').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                       cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);

        cdsItensMultiLojas.FieldByName('ITE_PERBAS').AsFloat := 100;

        cdsItensMultiLojas.FieldByName('ITE_ALQICM').AsFloat  := cdsItensPedido.FieldByName('ITE_ALQICM').AsFloat;

        cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat  := cdsItensPedido.FieldByName('ITE_PERSUB').AsFloat;

        cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat  := cdsItensPedido.FieldByName('ITE_PERFCP').AsFloat;

        cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat  := cdsItensPedido.FieldByName('ITE_SUBFCP').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                       cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);


        cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat  := cdsItensPedido.FieldByName('ITE_VALICM').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                       cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);

        cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat  := cdsItensPedido.FieldByName('ITE_DESPIS').AsFloat * (cdsItensMultiLojas.FieldByName('ITE_QTDITE').AsFloat /
                                                                       cdsItensPedido.FieldByName('ITE_QTDITE').AsFloat);
      End Else
      Begin
        cdsItensMultiLojas.FieldByName('ITE_TOTSUB').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_TOTDAR').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_BASSUB').AsFloat := 0;

        cdsItensMultiLojas.FieldByName('ITE_PERFCP').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_SUBFCP').AsFloat := 0;

        cdsItensMultiLojas.FieldByName('ITE_ALQICM').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_PERSUB').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_VALICM').AsFloat := 0;
        cdsItensMultiLojas.FieldByName('ITE_DESPIS').AsFloat := 0;
      End;

      pCopiaAliquotasReforma(cdsItensPedido, cdsItensMultiLojas, chkPedImp);

      TCalculaCamposPedido.pCalcFields(cdsItensMultiLojas);

      cdsItensMultiLojas.Post;

      cdsItensMultiLojas.Next;
    End;

    cdsItensPedido.Next;
  End;
end;

Function fRetornaSaldoItem(strCodIte, strCodSim, strLisEmp: String): Double;
  Var
    strSQL: String;
    qrySaldo: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE  ';
  strSQL := strSQL + '    SUM(IFNULL(I.ITE_SALDOS, 0)) AS SALDOS ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEGER I ';

  If Not fEmptyStr(strCodSim) Then
    strSQL := strSQL + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = I.ITE_CODITE ';

  strSQL := strSQL + ' WHERE  ';

  If fEmptyStr(strCodSim) Then
    strSQL := strSQL + '   I.ITE_CODITE = :CODITE '
  Else
    strSQL := strSQL + '   CS.ITE_CODSIM = :CODSIM ';

  If Not fEmptyStr(strLisEmp) Then
    strSQL := strSQL + ' AND I.ITE_CODEMP IN (' + strLisEmp + ') ';

  qrySaldo := fCriaQuery(Nil);

  With qrySaldo Do
  Begin
    SQL.Text := strSQL;

    If fEmptyStr(strCodSim) Then
      ParamByName('CODITE').AsString := strCodIte
    Else
      ParamByName('CODSIM').AsString := strCodSim;

    Open;

    Result := FieldByName('SALDOS').AsFloat;
  End;

  FreeAndNil(qrySaldo);
End;

function fLiberaCompraCentralizada(strCodIte, strEmpDes: String): Boolean;
 var
   objLiberacao : ILiberacao;
Begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.objMsgLibera.pAddTexto('Produto ' + strCodIte + '-' + fRetNomProduto(strCodIte) + ' com compra centralizada na Loja ' + strEmpDes + '!');

  objLiberacao.strDirAce := 'LIBCPRCEN';
  objLiberacao.strMsgSen := 'PRODUTO COM COMPRA CENTRALIZADA';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;
  objLiberacao.tipCliFor := cfFornecedor;

  Result := objLiberacao.fLibera;
End;

Function fMontaStrMeses(intQtdMes: Integer): String;
  Var
    wrdAno, wrdMes, wrdDia: Word;
    intContador1: Integer;
    dtaBaseTmp: TDateTime;
    stlMeses: TStringList;
Begin
  stlMeses := TStringList.Create;
  dtaBaseTmp:= IncMonth(VS_Date, -1);

  For intContador1 := 0 To intQtdMes -1 Do
  Begin
    DecodeDate(dtaBaseTmp, wrdAno, wrdMes, wrdDia);
    stlMeses.Add(IntToStr(wrdAno) + '/' + fStrZero(IntToStr(wrdMes), 2));
    dtaBaseTmp := IncMonth(dtaBaseTmp, -1)
  End;

  Result := stlMeses.Text;
  stlMeses.Clear;
  FreeAndNil(stlMeses);
End;

procedure pAlteraDataSetGiro(dtsItensGiro: TDataSource;
                             cdsItensGiroExt: TUniClientDataSet;
                             pnlVendas: TPanel);
  Var
    intContador: Integer;
Begin
  dtsItensGiro.DataSet := cdsItensGiroExt;
  For intContador := 0 To pnlVendas.ControlCount - 1 Do
    If (pnlVendas.Controls[intContador] Is TDBEditFocus) Then
      (pnlVendas.Controls[intContador] As TDBEditFocus).DataSource := dtsItensGiro;
End;

procedure pAlteraDataSetMlj(dtsItensMlj: TDataSource;
                            cdsItensMultiLojas: TUniClientDataSet;
                            pnlVendas: TPanel);
  Var
    intContador: Integer;
Begin
  dtsItensMlj.DataSet := cdsItensMultiLojas;
  For intContador := 0 To pnlVendas.ControlCount - 1 Do
    If (pnlVendas.Controls[intContador] Is TDBEditFocus) Then
      (pnlVendas.Controls[intContador] As TDBEditFocus).DataSource := dtsItensMlj;
End;

procedure pMostraMaiorVenda(cdsItensPedido: TUniClientDataSet;
                            intMesGir, intMesMos: Integer;
                            edtMaQtSa, edtMaDtSa: TEditFocus);
  Var
    intContador: Integer;
    fltMaiorQtdSai: Double;
    dtaMaiorDtaSai: TDateTime;
begin
  fltMaiorQtdSai := -1;
  dtaMaiorDtaSai := 0;

  For intContador := 1 To intMesGir Do
  Begin

    If cdsItensPedido.FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat > fltMaiorQtdSai Then
    Begin
      fltMaiorQtdSai := cdsItensPedido.FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat;
      dtaMaiorDtaSai := cdsItensPedido.FieldByName('ITE_MDSA' + fStrZero(intContador, 2)).AsDateTime;
    End;

  End;

  edtMaQtSa.Clear;
  edtMaDtSa.Clear;
  If fltMaiorQtdSai > -1 Then
  Begin
    edtMaQtSa.Text := FloatToStrF(fltMaiorQtdSai, ffFixed, 12, IIF(Frac(fltMaiorQtdSai) = 0, 0, 2));
    If dtaMaiorDtaSai = 0 Then
      edtMaDtSa.Clear
    Else
      edtMaDtSa.Text := DateToStr(dtaMaiorDtaSai);
  End;

end;

procedure pRetornaMaiorVenda(cdsItensPedido: TUniClientDataSet; intMosMes: Integer);
  Var
    intContador: Integer;
    fltMaiorQtdSai: Double;
    dtaMaiorDtaSai: TDateTime;
    blnGravar: Boolean;
begin
  fltMaiorQtdSai := -1;
  dtaMaiorDtaSai := 0;

  With cdsItensPedido Do
  Begin

    For intContador := 1 To intMosMes Do
    Begin

      If FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat > fltMaiorQtdSai Then
      Begin
        fltMaiorQtdSai := FieldByName('ITE_MQSA' + fStrZero(intContador, 2)).AsFloat;
        dtaMaiorDtaSai := FieldByName('ITE_MDSA' + fStrZero(intContador, 2)).AsDateTime;
      End;

    End;

    If Not (State in [dsEdit, dsInsert]) Then
    Begin
      Edit;
      blnGravar := True;
    End Else
    Begin
      blnGravar := False;
    End;

    FieldByName('ITE_MQSGIR').Clear;
    FieldByName('ITE_MDSGIR').Clear;

    If fltMaiorQtdSai > -1 Then
    Begin
      FieldByName('ITE_MAQTSA').AsFloat := fltMaiorQtdSai;
      If dtaMaiorDtaSai > 0 Then
        FieldByName('ITE_MADTSA').AsDateTime := dtaMaiorDtaSai;
    End;

    If blnGravar Then
      Post;
  End;

end;

Procedure pMostraDadosRodapeGiro(cdsItensPedido: TUniClientDataSet;
                                 intMesGir,
                                 intMesMos: Integer;
                                 pnlVendas: TPanel;
                                 edtMaQtSa,
                                 edtMaDtSa: TEditFocus;
                                 dbeMes: TDBEditFocus;
                                 blnConsMesAtu: Boolean);
Begin
  If Not pnlVendas.Visible Then
    Exit;

  pMostraMaiorVenda(cdsItensPedido, intMesGir, intMesMos, edtMaQtSa, edtMaDtSa);
End;

procedure pMascaraCamposGiro(cdsItensPedido: TUniClientDataSet; intMesGir: Integer);
  Var
    intContador: Integer;

    procedure pMascaraFrac(strCampo: String);
    begin
      If cdsItensPedido.FieldByName('ITE_ITEFRA').AsString = 'N' Then
      Begin
        TFloatField(cdsItensPedido.FieldByName(strCampo)).DisplayFormat := '#0';
      End
      Else
      Begin
        TFloatField(cdsItensPedido.FieldByName(strCampo)).DisplayFormat := '#,##0.00';
      End;
    end;

begin
  If Not Assigned(cdsItensPedido) Then
    Exit;

  For intContador := 1 To intMesGir Do
  Begin
    pMascaraFrac('ITE_Q_V_' + fStrZero(intContador, 2));
    pMascaraFrac('ITE_Q_VP' + fStrZero(intContador, 2));
  End;

  pMascaraFrac('ITE_SUGEST');
  pMascaraFrac('ITE_SALFIS');
  pMascaraFrac('ITE_SALDIS');
  pMascaraFrac('ITE_SALEXT');
  pMascaraFrac('ITE_ESTMIN');
  pMascaraFrac('ITE_ESTMAX');
  pMascaraFrac('ITE_PMED_V');

  pMascaraFrac('ITE_MINDIG');
  pMascaraFrac('ITE_MAXDIG');

  pMascaraFrac('ITE_PONPED');
  pMascaraFrac('ITE_VENMES');
  pMascaraFrac('ITE_Q_VPME');
  pMascaraFrac('ITE_QTDPEN');
  pMascaraFrac('ITE_SALREQ');
  pMascaraFrac('ITE_MAQTSA');
  pMascaraFrac('ITE_MLTCOM');

  cdsItensPedido.FieldByName('ITE_CODITE').Alignment := taCenter;
  cdsItensPedido.FieldByName('ITE_SIGUNI').Alignment := taCenter;
  cdsItensPedido.FieldByName('ITE_CODSIT').Alignment := taCenter;
End;

Procedure pMontaCamposGiro(pnlVendas: TPanel; intMesGir, intMesMos: Integer; strMeses: String);
  Var
    lblTemp: TLabel;
    dbeTemp: TDBEditFocus;
    intContador: Integer;
    intIndiceCtrl: Integer;
    stlMeses: TStringList;
Begin
  If intMesMos = 0 Then
    intMesMos := 12;

  If fEmptyStr(strMeses) Then
    strMeses := fMontaStrMeses(intMesMos);

  stlMeses := TStringList.Create;
  stlMeses.Text := strMeses;

  If intMesGir = 0 Then
    intMesGir := 3;

  For intContador := 1 To intMesMos {intMesGir} Do
  Begin
    intIndiceCtrl := intMesMos - intContador + 1;

    lblTemp := (fComponentByName(pnlVendas, 'lblMes' + fStrZero(IntToStr(intIndiceCtrl), 2)) As TLabel);
    lblTemp.Caption := RightStr(stlMeses[Pred(intContador)], 2) + '/' + LeftStr(stlMeses[Pred(intContador)], 4);

    dbeTemp := (fComponentByName(pnlVendas, 'dbeMes' + fStrZero(IntToStr(intIndiceCtrl), 2)) As TDBEditFocus);

    lblTemp.Visible := True;

    dbeTemp.Visible     := True;
    dbeTemp.DataField   := 'ITE_Q_V_' + fStrZero(IntToStr(intContador), 2);

    If intContador <= intMesGir Then
    Begin
      dbeTemp.Font.Color := clRed;
      lblTemp.Font.Color := clRed;
    End;
  End;

  stlMeses.Clear;
  FreeAndNil(stlMeses);
End;

procedure pAcertaCorPedido(cdsItensPedido: TUniClientDataSet; fltLimAma, fltLimVer: Double);
Begin
  cdsItensPedido.FieldByName('ITE_TOTGER').AsFloat := cdsItensPedido.FieldByName('ITE_TOTITE').AsFloat +
                                                      cdsItensPedido.FieldByName('ITE_TOTIPI').AsFloat +
                                                      cdsItensPedido.FieldByName('ITE_TOTSUB').AsFloat +
                                                      fTotalImpostosReformaItem(cdsItensPedido);

  cdsItensPedido.FieldByName('ITE_CORMED').AsInteger := clGreen;

  If (Not cdsItensPedido.FieldByName('ITE_MEDIXX').IsNull) And
     (Not cdsItensPedido.FieldByName('ITE_MEDAJU').IsNull) And
     (cdsItensPedido.FieldByName('ITE_MEDIXX').AsFloat <> 0) Then
  Begin
    If Abs((cdsItensPedido.FieldByName('ITE_MEDAJU').AsFloat / cdsItensPedido.FieldByName('ITE_MEDIXX').AsFloat - 1 ) * 100) > fltLimAma Then
      cdsItensPedido.FieldByName('ITE_CORMED').AsInteger := clRed

    Else If Abs((cdsItensPedido.FieldByName('ITE_MEDAJU').AsFloat / cdsItensPedido.FieldByName('ITE_MEDIXX').AsFloat - 1 ) * 100) > fltLimVer Then
      cdsItensPedido.FieldByName('ITE_CORMED').AsInteger := clYellow;
  End;
End;

procedure pSqlBaixaPedido(blnViaAutoincrem: Boolean; var qry: TUniQuery);
Begin
  With qry do
  Begin
    SQL.Add(' UPDATE PCMGER ');
    SQL.Add('    SET PCG_CODOCO = :OCORRE, ');
    SQL.Add('        PCG_MOTBAI = :MOTBAI, ');
    SQL.Add('        PCG_BAIXAD = 1, ');
    SQL.Add('        PCG_CODOPE = :CODOPE, ');
    SQL.Add('        PCG_DTABAI = :DTABAI, ');
    SQL.Add('        PCG_HORBAI = :HORBAI ');
    If Not blnViaAutoincrem Then
    Begin
      SQL.Add('  WHERE PCG_NUMPED = :NUMPED');
      SQL.Add('    AND PCG_CODEMP = :CODEMP');
      SQL.Add('    AND PCG_ESPDOC = :ESPDOC');
    End
    Else
      SQL.Add('  WHERE AUTOINCREM = :AUTOINCREM');

    SQL.Add('    AND PCG_NUMCTN = 0 ');
    SQL.Add('    AND (PCG_BAIXAD = FALSE OR PCG_BAIXAD IS NULL); ');


   (*
    SQL.Add(' UPDATE MOVRCD ');
    SQL.Add(' INNER JOIN PCMDET P ON P.AUTOINCREM = RCD_SEQPCD');
    If blnViaAutoincrem Then
    Begin
      SQL.Add('   INNER JOIN PCMGER ON PCD_NUMPED = PCG_NUMPED ');
      SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP ');
      SQL.Add('                   AND PCD_ESPDOC = PCG_ESPDOC ');
    End;
    SQL.Add(' SET RCD_SEQPCD = (NULL), ');
    SQL.Add('     RCD_REQNEG = "S"     ');

    If Not blnViaAutoincrem Then
    Begin
      SQL.Add('  WHERE PCD_NUMPED = :NUMPED');
      SQL.Add('    AND PCD_CODEMP = :CODEMP');
      SQL.Add('    AND PCD_ESPDOC = :ESPDOC');
    End
    Else
      SQL.Add('  WHERE PCMGER.AUTOINCREM = :AUTOINCREM');

    SQL.Add('    AND PCD_NUMCTN = 0 ');
    SQL.Add('    AND (PCD_BAIXAD = FALSE OR PCD_BAIXAD IS NULL); ');
    *)

    SQL.Add(' UPDATE PCMDET ');
    If blnViaAutoincrem Then
    Begin
      SQL.Add('   LEFT JOIN PCMGER ON PCD_NUMPED = PCG_NUMPED ');
      SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP ');
      SQL.Add('                   AND PCD_ESPDOC = PCG_ESPDOC ');
    End;

    SQL.Add('    SET PCD_ENTREG = "N", ');
    SQL.Add('        PCD_BAIXAD = 1    ');

    If Not blnViaAutoincrem Then
    Begin
      SQL.Add('  WHERE PCD_NUMPED = :NUMPED');
      SQL.Add('    AND PCD_CODEMP = :CODEMP');
      SQL.Add('    AND PCD_ESPDOC = :ESPDOC');
    End
    Else
      SQL.Add('  WHERE PCMGER.AUTOINCREM = :AUTOINCREM');

    SQL.Add('    AND PCD_NUMCTN = 0 ');
    SQL.Add('    AND (PCD_BAIXAD = FALSE OR PCD_BAIXAD IS NULL);');



    SQL.Add('UPDATE CONCOL');
    SQL.Add('   LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = CONCOL.CON_AUTDET');
    SQL.Add('   LEFT JOIN PCMGER ON PCD_NUMPED = PCG_NUMPED ');
    SQL.Add('                   AND PCD_CODEMP = PCG_CODEMP ');
    SQL.Add('                   AND PCD_ESPDOC = PCG_ESPDOC ');
    SQL.Add('    SET CONCOL.CON_BAIXAD = "S" ');

    If Not blnViaAutoincrem Then
    Begin
      SQL.Add('  WHERE PCG_NUMPED = :NUMPED');
      SQL.Add('    AND PCG_CODEMP = :CODEMP');
      SQL.Add('    AND PCG_ESPDOC = :ESPDOC');
    End
    Else
      SQL.Add('  WHERE PCMGER.AUTOINCREM = :AUTOINCREM;');
  End;

End;

Function fTrataRequisicoesPedido(strAutInc: String; opcRequisicao: TOpcRequisicao; intMotivo: Integer; strMotivo: String): Boolean;
  Var
    strSQL: String;
    qryPcmdet: TUniQuery;
    cdsDados: TZClient;

    objRequisicao: TRequisicaoPedidoCompra;
Begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT     ';
  strSQL := strSQL + '   M.*,     ';

  strSQL := strSQL + '  VEN.OPE_MSGRCN,';
  strSQL := strSQL + QuotedStr(strMotivo) + ' AS JUSTIF, ';
  strSQL := strSQL + intMotivo.ToString() + ' AS MOTNEG, ';
  strSQL := strSQL + '  CONCAT(RCD_CODITE, "-", ITE_DESITE) AS PRODUT,';
  strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '  ROUND(RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM), 0), 4) AS QTDITE, ';

  If opcRequisicao = opcNegar Then
    strSQL := strSQL +  ' 1 AS NEGADA, '
  Else
    strSQL := strSQL +  ' 0 AS NEGADA, ';

  strSQL := strSQL + '   RCD_DOCPDV AS DOCPDV, ';
  strSQL := strSQL + '   RCD_EMPPDV AS EMPPDV, ';
  strSQL := strSQL + '   RCD_ESPPDV AS ESPPDV, ';
  strSQL := strSQL + '   RCD_CODIGO AS CODREQ, ';
  strSQL := strSQL + '   RCD_CODITE AS CODITE, ';
  strSQL := strSQL + '   RCD_QTDITE AS QTDORI, ';
  strSQL := strSQL + '   RCD_CODEMP AS CODEMP  ';

  strSQL := strSQL + ' FROM       ';
  strSQL := strSQL + '   PCMGER G ';

  strSQL := strSQL + ' INNER JOIN PCMDET D ON PCG_NUMPED = PCD_NUMPED AND ';
  strSQL := strSQL + '                        PCG_CODEMP = PCD_CODEMP AND ';
  strSQL := strSQL + '                        PCG_ESPDOC = PCD_ESPDOC AND ';
  strSQL := strSQL + '                        PCG_NUMCTN = PCD_NUMCTN     ';

  strSQL := strSQL + ' INNER JOIN MOVRCD M ON RCD_SEQPCD = D.AUTOINCREM   ';
  strSQL := strSQL + ' INNER JOIN MOVRCG ON M.RCD_CODIGO = RCG_CODIGO AND M.RCD_CODEMP = RCG_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADOPE VEN ON VEN.OPE_CODOPE = RCG_CODVEN   ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = RCD_CODITE       ';

  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PCD_BAIXAD = 0 AND                                                                               ';
  strSQL := strSQL + '   RCD_QTDITE > IFNULL(PCD_QTDBAI, 0) * IF(PCD_EMBALA IS NULL OR PCD_EMBALA = 0, 1, PCD_EMBALA) AND ';
  strSQL := strSQL + '   G.AUTOINCREM = ' +  QuotedStr(strAutInc);

  strSQL := strSQL + '   AND RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM), 0) > 0 ';

  cdsDados := TZClient.Create(Nil, strSQL);

  cdsDados.fLeDados('pTrataRequisicoesPedido');

  If Not cdsDados.IsEmpty Then
  Begin

    If opcRequisicao = opcManterAberto Then
    Begin
      qryPcmdet := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM PCMIRQ WHERE PCM_SEQDET = :SEQDET AND PCM_SEQREQ = :SEQREQ; ';
      strSQL := strSQL + ' DELETE FROM PCMIRQ_RES WHERE PCM_SEQREQ = :SEQREQ; ';

      strSQL := strSQL + ' UPDATE MOVRCD SET           ';
      strSQL := strSQL + '   RCD_SEQPCD = NULL         ';
      strSQL := strSQL + ' WHERE AUTOINCREM = :SEQREQ; ';

      qryPcmdet.SQL.Text := strSQL;

      While Not cdsDados.Eof Do
      Begin
        qryPcmdet.Close;
        qryPcmdet.ParamByName('SEQDET').AsString := cdsDados.FieldByName('RCD_SEQPCD').AsString;
        qryPcmdet.ParamByName('SEQREQ').AsString := cdsDados.FieldByName('AUTOINCREM').AsString;
        qryPcmdet.ExecSQL;

        cdsDados.Next;
      End;

      FreeAndNil(qryPcmdet);

    End Else
    Begin

      objRequisicao := TRequisicaoPedidoCompra.Create;

      If intMotivo = 0 Then
        Result := objRequisicao.fNegaRequisicoesMotivoNaoVaiComprar(cdsDados, False)
      Else
        Result := objRequisicao.fNegaRequisicoesMotivoPossuiEstoque(cdsDados, False);

      FreeAndNil(objRequisicao);

    End;

  End;

  FreeAndNil(cdsDados);
End;

function fLiberaTravaValidadeCertGestao(strCodFor: String): Boolean;

  function fGetDadosFornec: TUniQuery;
  var
    qryAux: TUniQuery;
  begin
    qryAux := fCriaQuery;
    qryAux.SQL.Add('  SELECT                                              ');
    qryAux.SQL.Add('    CONCAT(FOR_CODFOR," - ",FOR_NOMFOR) AS FOR_NOMFOR,');
    qryAux.SQL.Add('    FOR_CERVAL,                                       ');
    qryAux.SQL.Add('    FOR_C_G_C_                                        ');
    qryAux.SQL.Add('  FROM                                                ');
    qryAux.SQL.Add('    CADFOR                                            ');
    qryAux.SQL.Add('  WHERE                                               ');
    qryAux.SQL.Add('    FOR_CODFOR = :CODFOR AND FOR_OBGCTR = "S"         ');

    qryAux.ParamByName('CODFOR').AsString := strCodFor;
    qryAux.Open;

    Result := qryAux;
  end;

var
  objLiberacao: ILiberacao;
  qryDados: TUniQuery;
begin
  qryDados := fGetDadosFornec;

  If Not fCfgSis('CTRQLD', varBoolean) Then
    Exit(True);

  If qryDados.IsEmpty Then
    Exit(True);

  Try
    If VS_Date > qryDados.FieldByName('FOR_CERVAL').AsDateTime Then
    Begin
      objLiberacao := TLiberacaoFactory.fGetLiberacao;
      objLiberacao.Clear;

      objLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------');
      objLiberacao.objMsgLibera.pAddTexto('       FORNECEDOR COM CERTIFICADO DE QUALIDADE VENCIDO           ');
      objLiberacao.objMsgLibera.pAddTexto('-----------------------------------------------------------------');

      objLiberacao.objMsgLibera.pAddTexto('      Fornecedor: ' + qryDados.FieldByName('FOR_NOMFOR').AsString);
      objLiberacao.objMsgLibera.pAddTexto('            CNPJ: ' + fFormataCpfCgc(qryDados.FieldByName('FOR_C_G_C_').AsString, TPais.opcBrasil));
      objLiberacao.objMsgLibera.pAddTexto('Data de validade: ' + qryDados.FieldByName('FOR_CERVAL').AsString);

      objLiberacao.strDirAce := 'CRTGQD';
      objLiberacao.strMsgSen := 'FORNECEDOR COM CERTIFICADO DE QUALIDADE VENCIDO';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      Result := objLiberacao.fLibera;
    End
    Else
      Result := True;
  Finally
    FreeAndNil(qryDados);
  End;
end;


procedure pAlteraPasCmp(strTabela : String; qryPcmDet: TUniQuery);
Var
  strSQL: String;
  qryAux: TUniQuery;
begin

  if not fTabelaExiste(strTabela) then
    Exit;

  qryAux := fCriaQuery;
  Try
    strSQL := ' UPDATE ';
    strSQL := strSQL + strTabela;
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   PAS_PEDGER = "0", ';
    strSQL := strSQL + '   PAS_QTDEFT = 0,   ';
    strSQL := strSQL + '   PAS_CMPEFT = 0    ';
    strSQL := strSQL + ' WHERE PAS_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND PAS_CODITE = :CODITE ';

    qryPcmDet.First;
    While Not qryPcmDet.Eof Do
    Begin
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := qryPcmDet.FieldbyName('PCD_CODEMP').AsString;
        ParamByName('CODITE').AsString := qryPcmDet.FieldbyName('PCD_CODITE').AsString;
        ExecSQL;
      end;

      qryPcmDet.Next;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

Function fBaixaPedidoNaoEntregue(strAutoincrem, strMotivo, strCodOco: String; blnComTransacao: Boolean;
                                 opcRequisicao: TOpcRequisicao;
                                 intMotivoReq: Integer;
                                 strMotivoReq: String): Boolean;
  Var
    qryUpdate: TUniQuery;
    qryPcmDet: TUniQuery;
    LNumPed: String;
    LEspDoc: String;
    LCodEmp: String;
    LRepor_: String;
    LDtaPed: TDateTime;
Begin
  qryUpdate := Nil;
  qryPcmDet := Nil;

  Try
    Try
      If blnComTransacao Then
        fStartTransaction;

      Result := fTrataRequisicoesPedido(strAutoincrem, opcRequisicao, intMotivoReq, strMotivoReq);

      If Not Result Then
        Exit;

      qryUpdate := fCriaQuery;
      qryPcmDet := fCriaQuery;

      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT PCG_NUMPED, PCG_ESPDOC, PCG_CODEMP, PCG_REPOR_, PCG_DTAPED FROM PCMGER WHERE AUTOINCREM = :AUTOINCREM';
        ParamByName('AUTOINCREM').AsString := strAutoincrem;
        Open;

        LNumPed := FieldByName('PCG_NUMPED').AsString;
        LEspDoc := FieldByName('PCG_ESPDOC').AsString;
        LCodEmp := FieldByName('PCG_CODEMP').AsString;
        LRepor_ := FieldByName('PCG_REPOR_').AsString;
        LDtaPed := FieldByName('PCG_DTAPED').AsDateTime;

        pEstornaSaldoPedidoCompra(LNumPed, LEspDoc, LCodEmp);

        Close;
        SQL.Clear;

        pSqlBaixaPedido(True, qryUpdate);

        ParamByName('MOTBAI').AsString   := strMotivo;
        ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
        ParamByName('DTABAI').AsDateTime := VS_Date;
        ParamByName('HORBAI').AsDateTime := fTime();
        ParamByName('OCORRE').AsString   := strCodOco;
        ParamByName('AUTOINCREM').AsString := strAutoincrem;

        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('UPDATE PCMGER_RES ');
        SQL.Add('SET PCG_EXCLUI = "S"');
        SQL.Add('WHERE PCG_NUMPED = :NUMPED ');
        SQL.Add('  AND PCG_ESPDOC = :ESPDOC ');
        SQL.Add('  AND PCG_CODEMP = :CODEMP ');

        ParamByName('NUMPED').AsString := LNumPed;
        ParamByName('ESPDOC').AsString := LEspDoc;
        ParamByName('CODEMP').AsString := LCodEmp;

        ExecSQL;

      End;

      If (LRepor_ = 'S') And (LDtaPed = Date) Then
      Begin
        With qryPcmDet Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT PCD_CODEMP, PCD_CODITE ');
          SQL.Add('  FROM PCMDET ');
          SQL.Add('  WHERE ');
          SQL.Add('    PCD_NUMPED = :NUMPED AND ');
          SQL.Add('    PCD_ESPDOC = :ESPDOC AND ');
          SQL.Add('    PCD_CODEMP = :CODEMP ');
          ParamByName('NUMPED').AsString := LNumPed;
          ParamByName('ESPDOC').AsString := LEspDoc;
          ParamByName('CODEMP').AsString := LCodEmp;
          Open;
        End;

         if fTabelaExiste('PASCMP_PRODUTOS_SINTETICO') then
           pAlteraPasCmp('PASCMP_PRODUTOS_SINTETICO', qryPcmDet);

         if fTabelaExiste('PASCMP_PRODUTOS_ANALITICO') then
           pAlteraPasCmp('PASCMP_PRODUTOS_ANALITICO', qryPcmDet);
      End;

      If blnComTransacao Then
        fCommit;

      Result := True;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fBaixaPedidoNaoEntregue]');
      End;
    End;

  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qryPcmDet);
  End;
End;

procedure pReqCompraSql(tpSel : TSqlReqCompra; var qry: TUniQuery);
Begin
  case tpSel of
    tpSelecao: Begin
                  qry.SQL.Add('    SELECT DISTINCT             ');
                  qry.SQL.Add('      RCG_CODIGO,               ');
                  qry.SQL.Add(' CONCAT(RCG_CODCLI, " - " ,     ');
                  qry.SQL.Add(' CLI_NOMCLI) AS CLIENTE,        ');
                  qry.SQL.Add(' CONCAT(RCG_CODVEN, " - " ,     ');
                  qry.SQL.Add(' OPE_NOMOPE) AS VENDEDOR,       ');
                  qry.SQL.Add(' RCG_CODVEN, RCG_DTACAD         ');
                  qry.SQL.Add('    FROM MOVRCG                 ');
                  qry.SQL.Add(' INNER JOIN MOVRCD ON           ');
                  qry.SQL.Add(' RCD_CODIGO = RCG_CODIGO AND    ');
                  qry.SQL.Add(' RCD_CODEMP = RCG_CODEMP        ');
                  qry.SQL.Add(' INNER JOIN PCMDET ON           ');
                  qry.SQL.Add(' RCD_SEQPCD = PCMDET.AUTOINCREM ');
                  qry.SQL.Add(' AND PCD_NUMPED = :NUMPED       ');
                  qry.SQL.Add(' AND PCD_CODEMP = :CODEMP       ');
                  qry.SQL.Add(' AND PCD_ESPDOC = :ESPDOC       ');
                  qry.SQL.Add(' INNER JOIN CADCLI ON           ');
                  qry.SQL.Add(' CLI_CODCLI = RCG_CODCLI        ');
                  qry.SQL.Add(' INNER JOIN CADOPE ON           ');
                  qry.SQL.Add(' RCG_CODVEN = OPE_CODOPE        ');
                  qry.SQL.Add(' ORDER BY RCG_CODIGO            ');
                End;

    tpVendedor: Begin
                  qry.SQL.Add('    SELECT DISTINCT             ');
                  qry.SQL.Add('    RCG_CODVEN                  ');
                  qry.SQL.Add('    FROM MOVRCG                 ');
                  qry.SQL.Add(' INNER JOIN MOVRCD ON           ');
                  qry.SQL.Add(' RCD_CODIGO = RCG_CODIGO AND    ');
                  qry.SQL.Add(' RCD_CODEMP = RCG_CODEMP        ');
                  qry.SQL.Add(' INNER JOIN PCMDET ON           ');
                  qry.SQL.Add(' RCD_SEQPCD = PCMDET.AUTOINCREM ');
                  qry.SQL.Add(' AND PCD_NUMPED = :NUMPED       ');
                  qry.SQL.Add(' AND PCD_CODEMP = :CODEMP       ');
                  qry.SQL.Add(' AND PCD_ESPDOC = :ESPDOC       ');
                  qry.SQL.Add(' INNER JOIN CADCLI ON           ');
                  qry.SQL.Add(' CLI_CODCLI = RCG_CODCLI        ');
                  qry.SQL.Add(' INNER JOIN CADOPE ON           ');
                  qry.SQL.Add(' RCG_CODVEN = OPE_CODOPE        ');
                  qry.SQL.Add(' ORDER BY RCG_CODVEN            ');
                End;
  end;
End;

procedure pMensagemBaixaRequisicaoCompra(strNumPed, strEspDoc, strCodEmp, strMotivo, strCodOco: String; qry: TUniQuery);
var
  qryOpe: TUniQuery;
  msgMensagem: TMsgInterna;
  stlMensagem: TStringList;
Begin
  qryOpe := fCriaQuery;
  pReqCompraSql(tpVendedor,qryOpe);
  qryOpe.ParamByName('NUMPED').AsString := strNumPed;
  qryOpe.ParamByName('ESPDOC').AsString := strEspDoc;
  qryOpe.ParamByName('CODEMP').AsString := strCodEmp;
  qryOpe.Open;

  msgMensagem := TMsgInterna.Create(Nil);
  stlMensagem := TStringList.Create;
  qryOpe.First;
  While Not qryOpe.Eof Do
  Begin
    qry.Filtered := False;
    qry.Filter   := '';
    qry.Filter   := ' RCG_CODVEN = ' + qryOpe.FieldByName('RCG_CODVEN').AsString;
    qry.Filtered := True;
    qry.First;

    stlMensagem.Clear;
    stlMensagem.Add('------------------------------------------------------------------------------------------ ');
    stlMensagem.Add('                CANCELAMENTO DE REQUISIÇÃO DE COMPRA                                       ');
    stlMensagem.Add('------------------------------------------------------------------------------------------ ');
    stlMensagem.Add(' As requições abaixo foram canceladas, pois, o operador: ' +strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));
    stlMensagem.Add(' baixou o pedido de compra ('+strNumPed +'-'+ strEspDoc +') a que estavam relacionadas.    ');
    stlMensagem.Add(' Ocorrência: ' + strCodOco + ' - ' + fRetDescOcorrencia(strCodOco)                          );
    stlMensagem.Add(' Motivo da Baixa: ' +  strMotivo                                                            );
    stlMensagem.Add('------------------------------------------------------------------------------------------ ');
    While Not qry.Eof Do
    Begin
      stlMensagem.Add(' Requisição: ' + qry.FieldByName('RCG_CODIGO').AsString + ' ' + ' Cliente: ' + qry.FieldByName('CLIENTE').AsString);
      qry.Next;
    End;
    stlMensagem.Add('------------------------------------------------------------------------------------------ ');
    msgMensagem.fEnviaMensagem('CANCELAMENTO DE REQUISIÇÃO DE COMPRA', stlMensagem.Text, strLoginUsuarioLogado, qryOpe.FieldByName('RCG_CODVEN').AsString, 'N', '');
    qryOpe.Next;
  End;
  FreeAndNil(msgMensagem);
  FreeAndNil(stlMensagem);
  FreeAndNil(qryOpe);
End;

procedure pDadosEntregaPedido(var strNomEmp, strEndEmp, strCidEmp: String; strCodEmp: String);
  Var
    qryAux: TUniQuery;
    strSQL: String;
begin
  If fEmptyStr(strNomEmp) Then
  Begin

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   EMP_NOMEMP AS NOMENT, ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, IF(EMP_ENDNUM = " ", "?", ", "), EMP_ENDNUM, " - ", EMP_BAIRRO) AS ENDENT, ';
    strSQL := strSQL + '   CONCAT(CID_NOMCID, " - ", CID_ESTADO) AS NOMCID ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   LEFT JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EMP_CODEMP = :CODEMP ';
    qryAux := fCriaQuery;

    With qryAux Do
    Begin
      Close;
      SQL.Add(strSQL);

      If fEmptyStr(strCodEmp) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      strNomEmp := FieldbyName('NOMENT').AsString;
      strEndEmp := FieldbyName('ENDENT').AsString;
      strCidEmp := FieldbyName('NOMCID').AsString;

    End;

    FreeAndNil(qryAux);

  End;
end;

Function fSQLGiro(strEmpresas, strCodSim: String): String;
  Var
    strSQL: String;
    intContador: Integer;
    dtaDate: TDateTime;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  dtaDate := StartOfTheMonth(VS_Date);

  For intContador := 1 To 12 Do
  Begin
    dtaDate := IncMonth(dtaDate, -1);
    strSQL := strSQL + ' SUM(IF(GIR_A_N_O_ = ' +  QuotedStr(IntToStr(YearOf(dtaDate))) +
       ', IFNULL(GIR_QSAI' + FormatDateTime('MM', dtaDate) + ', 0), 0)) AS ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2) + ', ';
    strSQL := strSQL + ' SUM(IF(GIR_A_N_O_ = ' +  QuotedStr(IntToStr(YearOf(dtaDate))) +
       ', IFNULL(GIR_QPSA' + FormatDateTime('MM', dtaDate) + ', 0), 0)) AS ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2) + ', ';
  End;

  strSQL := strSQL + ' SUM(IF(GIR_A_N_O_ = :ANOATU, IFNULL(GIR_QSAI' + FormatDateTime('MM', VS_Date) + ', 0), 0)) AS VENMES, ';
  strSQL := strSQL + ' SUM(IF(GIR_A_N_O_ = :ANOATU, IFNULL(GIR_QPSA' + FormatDateTime('MM', VS_Date) + ', 0), 0)) AS Q_VPME ';

  strSQL := strSQL + ' FROM GIRITE ';

  If Not fEmptyStr(strCodSim) Then
    strSQL := strSQL + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = GIR_CODITE ';

  strSQL := strSQL + ' WHERE';

  If fEmptyStr(strCodSim) Then
    strSQL := strSQL + '   GIR_CODITE = :CODITE AND '
  Else
    strSQL := strSQL + '   CS.ITE_CODSIM = ' + QuotedStr(strCodSim) + ' AND ';

  If Not strEmpresas.IsEmpty Then
    strSQL := strSQL + '   GIR_CODEMP IN (' + strEmpresas + ') AND ';

  strSQL := strSQL + '   GIR_A_N_O_ IN (:ANOANT, :ANOATU) ';

  strSQL := strSQL + ' GROUP BY ';

  If fEmptyStr(strCodSim) Then
    strSQL := strSQL + '  GIR_CODITE '
  Else
    strSQL := strSQL + '  ITE_CODSIM ';

  Result := strSQL;
End;

Procedure pCarrregaDadosGiro(cdsItensPedido: TUniClientDataSet; strEmpresas, strCodSim: String);
  Var
    qryGirIte: TUniQuery;
    intContador: Integer;
Begin
  With cdsItensPedido Do
  Begin
    If Not (State In dsEditModes) Then
      Exit;

    qryGirIte := fCriaQuery;
    qryGirIte.SQL.Text := fSQLGiro(strEmpresas, strCodSim);

    If fEmptyStr(strCodSim) Then
      qryGirIte.ParamByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;

    qryGirIte.ParamByName('ANOATU').AsString := IntToStr(YearOf(VS_DATE));
    qryGirIte.ParamByName('ANOANT').AsString := IntToStr(YearOf(VS_DATE)- 1);
    qryGirIte.Open;

    For intContador := 1 To 12 Do
    Begin
      If FindField('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).Value :=
          qryGirIte.FieldByName('ITE_Q_V_' + RightStr('0' + IntToStr(intContador), 2)).Value;

      If FindField('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)) <> Nil Then
        FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).Value :=
          qryGirIte.FieldByName('ITE_Q_VP' + RightStr('0' + IntToStr(intContador), 2)).Value;
    End;
    FieldByName('ITE_VENMES').Value := qryGirIte.FieldByName('VENMES').Value;
    FieldByName('ITE_Q_VPME').Value := qryGirIte.FieldByName('Q_VPME').Value;

    FreeAndNil(qryGirIte);
  End;
End;

Function fCalculaUnitarioLiquido(intDecUni: Integer; fltUnitar, fltDesUni, fltDesUn2, fltDesUn3, fltDesUn4, fltDesUn5, fltDesUn6: Double): Double;
Begin
  Result := RoundTo(fltUnitar * (1 - fltDesUni / 100)
                              * (1 - fltDesUn2 / 100)
                              * (1 - fltDesUn3 / 100)
                              * (1 - fltDesUn4 / 100)
                              * (1 - fltDesUn5 / 100)
                              * (1 - fltDesUn6 / 100)
                                 , -intDecUni);
End;

Procedure pAtualizaTotaisPedido(strAutInc: String;
               fltValFre, fltDesAce, fltTotSub, fltSubFCP, fltTotIte, fltTotIpi, fltIcmDes: Double;
               const AblnGravaReforma: Boolean = False;
               const AfltValCbs: Double = 0;
               const AfltValIbs: Double = 0;
               const AfltVal_Is: Double = 0);
  Var
    qryAtuGer: TUniQuery;
Begin
  qryAtuGer := fCriaQuery;

  With qryAtuGer, SQL Do
  Begin
    Add('UPDATE PCMGER SET');

    Add('  PCG_TOTGER = :TOTGER,');
    Add('  PCG_VALFRE = :VALFRE,');
    Add('  PCG_DESACE = :DESACE,');
    Add('  PCG_TOTSUB = :TOTSUB,');

    // Sem AblnGravaReforma (pre-nota) os PCG_VAL* gravados ficam como estao
    If AblnGravaReforma Then
    Begin
      Add('  PCG_VALCBS = :VALCBS,');
      Add('  PCG_VALIBS = :VALIBS,');
      Add('  PCG_VAL_IS = :VAL_IS,');
    End;

    Add('  PCG_SUBFCP = :SUBFCP ');

    Add('WHERE');
    Add('  AUTOINCREM = :AUTINC');

    ParamByName('AUTINC').AsString := strAutInc;

    ParamByName('TOTGER').AsFloat  := fltValFre +  fltDesAce +  fltTotSub + fltTotIte + fltTotIpi -
       IIF(fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')), fltIcmDes, 0);

    If AblnGravaReforma Then
    Begin
      ParamByName('VALCBS').AsFloat := AfltValCbs;
      ParamByName('VALIBS').AsFloat := AfltValIbs;
      ParamByName('VAL_IS').AsFloat := AfltVal_Is;

      If fSomarNovosImpostosDaReformaAoValorContabil Then
        ParamByName('TOTGER').AsFloat := ParamByName('TOTGER').AsFloat + AfltValCbs + AfltValIbs + AfltVal_Is;
    End;

    ParamByName('TOTSUB').AsFloat  := fltTotSub;
    ParamByName('SUBFCP').AsFloat  := fltSubFCP;
    ParamByName('VALFRE').AsFloat  := fltValFre;
    ParamByName('DESACE').AsFloat  := fltDesAce;

    ExecSQL;
  End;

  FreeAndNil(qryAtuGer);
End;

procedure pCalculaImpostosReformaItem(ADataSet: TDataSet; const AblnImportacao: Boolean);
  Var
    recBase: TBaseReforma;
    recValores: TValoresReforma;
begin
  With ADataSet Do
  Begin
    recBase := TBaseReforma.fCriar(FieldByName('ITE_TOTITE').AsFloat,
                                   FieldByName('ITE_VALFRE').AsFloat,
                                   FieldByName('ITE_DESACE').AsFloat);

    // ICMS desonerado (Zona Franca) nao e destacado na nota, entao nao sai da base
    If Not (fEhEstadoRegraZonaFranca(fCadEmp('ESTADO')) And (FieldByName('ITE_CICMDE').AsString = 'S')) Then
      recBase.fltValIcm := RoundTo(FieldByName('ITE_BASICM').AsFloat * FieldByName('ITE_ALQICM').AsFloat / 100, -2);

    If AblnImportacao Then
    Begin
      recBase.fltValImp := FieldByName('ITE_VALIMP').AsFloat;
      recBase.fltValPis := FieldByName('ITE_VALPIS').AsFloat;
      recBase.fltValCof := FieldByName('ITE_VALCOF').AsFloat;
    End;

    recValores := TCalculoReformaCompra.fCalcular(recBase,
                                                  TAliquotasReforma.fCriar(FieldByName('ITE_ALQCBS').AsFloat,
                                                                           FieldByName('ITE_ALQIBS').AsFloat,
                                                                           FieldByName('ITE_ALQ_IS').AsFloat),
                                                  True);

    FieldByName('ITE_VALCBS').AsFloat := recValores.fltCbs;
    FieldByName('ITE_VALIBS').AsFloat := recValores.fltIbs;
    FieldByName('ITE_VAL_IS').AsFloat := recValores.fltIs;
  End;
end;

procedure pCopiaAliquotasReforma(AOrigem, ADestino: TDataSet; const AblnImportacao: Boolean);
begin
  ADestino.FieldByName('ITE_ALQCBS').AsFloat := AOrigem.FieldByName('ITE_ALQCBS').AsFloat;
  ADestino.FieldByName('ITE_ALQIBS').AsFloat := AOrigem.FieldByName('ITE_ALQIBS').AsFloat;
  ADestino.FieldByName('ITE_ALQ_IS').AsFloat := AOrigem.FieldByName('ITE_ALQ_IS').AsFloat;
  pCalculaImpostosReformaItem(ADestino, AblnImportacao);
end;

function fTotalImpostosReformaItem(ADataSet: TDataSet): Double;
begin
  Result := 0;
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    Result := ADataSet.FieldByName('ITE_VALCBS').AsFloat +
              ADataSet.FieldByName('ITE_VALIBS').AsFloat +
              ADataSet.FieldByName('ITE_VAL_IS').AsFloat;
end;

function fSQLSomaImpostosReforma(const APrefixo: String): String;
begin
  Result := '';
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    Result := ' + IFNULL(' + APrefixo + '_VALCBS, 0) + IFNULL(' + APrefixo + '_VALIBS, 0) + IFNULL(' + APrefixo + '_VAL_IS, 0) ';
end;

function fSQLUnitarioImpostosReforma(const APrefixo: String): String;
begin
  Result := '';
  If fSomarNovosImpostosDaReformaAoValorContabil Then
    Result := ' + IF(IFNULL(' + APrefixo + '_QTDITE, 0) = 0, 0, (0' + fSQLSomaImpostosReforma(APrefixo) + ') / ' + APrefixo + '_QTDITE)';
end;

// TNivelGiroCriticidade
constructor TNivelGiroCriticidade.Create(Owner: TComponent);
Begin
  Inherited Create(Owner, fSQLDados);

  fAbreClient(True, 'TNivelGiroCriticidade.Create');
  EmptyDataSet;
  pAlinhaCampoCentro('NIVGIR');
End;

Function TNivelGiroCriticidade.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   "AZ" AS NIVGIR, ';
  strSQL := strSQL + '   "N"  AS USANIV, ';
  strSQL := strSQL + '   30   AS QTDDIA, ';
  strSQL := strSQL + '   0.00 AS PERCON  ';

  Result := strSQL;
End;

Procedure TNivelGiroCriticidade.pMontaNivel(arrNiveis: TarrNiveis);
  Var
    intContador: Integer;
Begin
  pTiraBeforePost;

  EmptyDataSet;
  For intContador := Low(arrNiveis) To High(arrNiveis) Do
  Begin
    Append;
    FieldByName('NIVGIR').AsString  := arrNiveis[intContador];
    FieldByName('USANIV').AsString  := 'S';
    FieldByName('QTDDIA').AsInteger := 30;
    FieldByName('PERCON').AsFloat   := 0;
    Post;
  End;

  pPoeBeforePost;
End;

Procedure TNivelGiroCriticidade.pGravaNivelFornecedor(strCodFor: String);
  Var
    qryNivFor: TUniQuery;
Begin
  If State = dsEdit Then
    Post;

  qryNivFor := fCriaQuery;
  With qryNivFor Do
  Begin
    SQL.Text := 'DELETE FROM NIVFOR WHERE FOR_CODFOR = :CODFOR';
    ParamByName('CODFOR').AsString := strCodFor;
    ExecSQL;
  End;

  First;
  While Not Eof Do
  Begin
    qryNivFor.Close;
    qryNivFor.SQL.Text := 'SELECT * FROM NIVFOR WHERE FOR_CODFOR = :CODFOR';
    qryNivFor.ParamByName('CODFOR').AsString := strCodFor;
    qryNivFor.Open;

    qryNivFor.Insert;
    qryNivFor.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('NIVFOR', VS_strCodEmp);
    qryNivFor.FieldByName('FOR_NIVEL_').AsString  := FieldByName('NIVGIR').AsString;
    qryNivFor.FieldByName('FOR_USANIV').AsString  := FieldByName('USANIV').AsString;

    If fEmptyStr(qryNivFor.FieldByName('FOR_USANIV').AsString) Then
      qryNivFor.FieldByName('FOR_USANIV').AsString := 'S';

    qryNivFor.FieldByName('FOR_QTDDIA').AsInteger := FieldByName('QTDDIA').AsInteger;
    qryNivFor.FieldByName('FOR_PERCON').AsFloat   := FieldByName('PERCON').AsFloat;
    qryNivFor.FieldByName('FOR_CODFOR').AsString  := strCodFor;
    qryNivFor.Post;

    Next;
  End;

  FreeAndNil(qryNivFor);
End;

Function TNivelGiroCriticidade.fCarregaNivelFornecedor(strCodFor: String; Var intIndex: Integer; blnLimpaNiveis: Boolean = True): Boolean;
  Var
    qryNivFor: TUniQuery;
Begin
  If blnLimpaNiveis Then
    EmptyDataSet;

  Result := False;

  intIndex := 0;

  qryNivFor := fCriaQuery;

  qryNivFor.SQL.Text := 'SELECT * FROM NIVFOR WHERE FOR_CODFOR = :CODFOR';
  qryNivFor.ParamByName('CODFOR').AsString := strCodFor;
  qryNivFor.Open;

  If Not qryNivFor.IsEmpty Then
  Begin
    Result := True;

    If Pos(qryNivFor.FieldByName('FOR_NIVEL_').AsString, 'A_B_C') > 0 Then
    Begin
      intIndex := 1;
      pMontaNivelGiro;
    End

    Else If Pos(qryNivFor.FieldByName('FOR_NIVEL_').AsString, 'X_Y_Z') > 0 Then
    Begin
      intIndex := 2;
      pMontaNivelCriticidade;
    End

    Else
    Begin
      intIndex := 3;
      pMontaNivelAmbos;
    End;

    While Not qryNivFor.Eof Do
    Begin

      If Locate('NIVGIR',  qryNivFor.FieldByName('FOR_NIVEL_').AsString, []) Then
      Begin
        Edit;
        FieldByName('USANIV').AsString  := qryNivFor.FieldByName('FOR_USANIV').AsString;
        FieldByName('NIVGIR').AsString  := qryNivFor.FieldByName('FOR_NIVEL_').AsString;
        FieldByName('QTDDIA').AsInteger := qryNivFor.FieldByName('FOR_QTDDIA').AsInteger;
        FieldByName('PERCON').AsFloat   := qryNivFor.FieldByName('FOR_PERCON').AsFloat;
        Post;
      End;

      qryNivFor.Next;
    End;

  End;

  FreeAndNil(qryNivFor);
End;

Procedure TNivelGiroCriticidade.pTiraBeforePost;
Begin
  BeforePost := Nil;
End;

Procedure TNivelGiroCriticidade.pPoeBeforePost;
Begin
  BeforePost := pBeforePost;
End;

Procedure TNivelGiroCriticidade.pBeforePost(dataSet: TDataSet);
Begin
  With dataSet Do
  Begin
    If (FieldByName('USANIV').AsString = 'S') And
       (FieldByName('QTDDIA').AsInteger <= 0) Then
    Begin
      pMensagemOk('Informe os dias de compra para o nível ' + FieldByName('NIVGIR').AsString + '!');
      Abort;
      Exit;
    End;
  End;
End;

Procedure TNivelGiroCriticidade.pMontaNivelGiro;
Begin
  pMontaNivel(['A', 'B', 'C']);
End;

Procedure TNivelGiroCriticidade.pMontaNivelCriticidade;
Begin
  pMontaNivel(['Z', 'Y', 'X']);
End;

Procedure TNivelGiroCriticidade.pMontaNivelAmbos;
Begin
  pMontaNivel(['AZ', 'AY', 'AX', 'BZ', 'BY', 'BX', 'CZ', 'CY', 'CX']);
End;

Procedure TNivelGiroCriticidade.pMontaSemNivel;
Begin
  EmptyDataSet;
End;

Function TNivelGiroCriticidade.fValidaDados: Boolean;
  Var
    blnMarcouAlgum: Boolean;
Begin
  Result := True;

  blnMarcouAlgum := False;

  First;
  While Not Eof Do
  Begin

    If (FieldByName('USANIV').AsString = 'S') And
       (FieldByName('QTDDIA').AsInteger <= 0) Then
    Begin
      pMensagemOk('Informe os dias de compra para o nível ' + FieldByName('NIVGIR').AsString + '!');
      Result := False;
      Exit;
    End;

    If FieldByName('USANIV').AsString = 'S' Then
      blnMarcouAlgum := True;

    Next;
  End;

  If Result And (Not IsEmpty) And (Not blnMarcouAlgum) Then
  Begin
    Result := False;
    pMensagemOk('Marque pelo menos um nível!');
  End;
End;

Procedure TNivelGiroCriticidade.pRetNiveis(Var recNivel: TRecOpcoesNivel);
  Var
    stlNiveis: TStringList;
Begin
  stlNiveis := TStringList.Create;

  With recNivel Do
  Begin
    intDiaComNvA := 0;
    intDiaComNvB := 0;
    intDiaComNvC := 0;

    intDiaComNvZ := 0;
    intDiaComNvY := 0;
    intDiaComNvX := 0;

    intDiaComNvAZ := 0;
    intDiaComNvAY := 0;
    intDiaComNvAX := 0;

    intDiaComNvBZ := 0;
    intDiaComNvBY := 0;
    intDiaComNvBX := 0;

    intDiaComNvCZ := 0;
    intDiaComNvCY := 0;
    intDiaComNvCX := 0;

    fltPerConA := 0;
    fltPerConB := 0;
    fltPerConC := 0;

    fltPerConZ := 0;
    fltPerConY := 0;
    fltPerConX := 0;

    fltPerConAZ := 0;
    fltPerConAY := 0;
    fltPerConAX := 0;

    fltPerConBZ := 0;
    fltPerConBY := 0;
    fltPerConBX := 0;

    fltPerConCZ := 0;
    fltPerConCY := 0;
    fltPerConCX := 0;

    First;
    While Not Eof Do
    Begin

      If FieldByName('USANIV').AsString = 'S' Then
      Begin
        stlNiveis.Add(FieldByName('NIVGIR').AsString);

        If SameText('A', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvA := FieldByName('QTDDIA').AsInteger;
          fltPerConA   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('B', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvB := FieldByName('QTDDIA').AsInteger;
          fltPerConB   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('C', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvC := FieldByName('QTDDIA').AsInteger;
          fltPerConC   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('Z', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvZ := FieldByName('QTDDIA').AsInteger;
          fltPerConZ   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('Y', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvY := FieldByName('QTDDIA').AsInteger;
          fltPerConY   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('X', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvX := FieldByName('QTDDIA').AsInteger;
          fltPerConX   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('AZ', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvAZ := FieldByName('QTDDIA').AsInteger;
          fltPerConAZ   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('AY', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvAY := FieldByName('QTDDIA').AsInteger;
          fltPerConAY   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('AX', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvAX := FieldByName('QTDDIA').AsInteger;
          fltPerConAX   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('BZ', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvBZ := FieldByName('QTDDIA').AsInteger;
          fltPerConBZ   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('BY', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvBY := FieldByName('QTDDIA').AsInteger;
          fltPerConBY   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('BX', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvBX := FieldByName('QTDDIA').AsInteger;
          fltPerConBX   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('CZ', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvCZ := FieldByName('QTDDIA').AsInteger;
          fltPerConCZ   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('CY', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvCY := FieldByName('QTDDIA').AsInteger;
          fltPerConCY   := FieldByName('PERCON').AsFloat;
        End

        Else If SameText('CX', FieldByName('NIVGIR').AsString) Then
        Begin
          intDiaComNvCX := FieldByName('QTDDIA').AsInteger;
          fltPerConCX   := FieldByName('PERCON').AsFloat;
        End;

      End;

      Next;
    End;

    strNiveis := fCommaText(stlNiveis, True);
  End;

  FreeAndNil(stlNiveis);
End;

Class Function TNivelGiroCriticidade.fSQLFiltraNiveis(recNivel: TRecOpcoesNivel): String;
  Var
    strCamGir,
    strCamCri: String;
Begin
  Result := '';

  strCamGir := 'IF(TIPGIR.SIS_VALCFG = "S", I.ITE_NIVGIR, C.ITE_NVLGIR)';
  strCamCri := 'IF(TIPCRI.SIS_VALCFG = "S", I.ITE_NIVCRI, C.ITE_NVLCRI)';

  If recNivel.nivEstoque = nivGiroFornecedor Then
    strCamGir := 'LEFT(IFNULL(C.ITE_NVLFOR, "C"), 1)';

  With recNivel Do
  Begin

    Case nivEstoque Of
      nivGiroFornecedor,
      nivGiro:        Result := ' AND ' + strCamGir + ' IN (' + strNiveis + ') ';

      nivCriticidade: Result := ' AND ' + strCamCri + ' IN (' + strNiveis + ') ';

      nivAmbos:       Result := ' AND CONCAT(' + strCamGir + ', ' + strCamCri + ') IN (' + strNiveis + ') ';
    End;

  End;
End;

Class Function TNivelGiroCriticidade.fSQLNiveis(recNivel: TRecOpcoesNivel): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If recNivel.nivEstoque = nivGiroFornecedor Then
  Begin
    strSQL := strSQL + '  C.ITE_NVLFOR AS ITE_NVLGIR, ';
    strSQL := strSQL + '  C.ITE_NVLFOR AS GIRSINT, ';
  End
  Else If fCfgSis('TIPGIR') = 'S' Then
  Begin
    strSQL := strSQL + '  I.ITE_NIVGIR AS ITE_NVLGIR, ';
    strSQL := strSQL + '  (SELECT EL.ITE_NIVGIR FROM ITEGER EL WHERE EL.ITE_CODITE = I.ITE_CODITE AND EL.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') AS GIRSINT, ';
  End Else
  Begin
    strSQL := strSQL + '  C.ITE_NVLGIR, ';
    strSQL := strSQL + '  C.ITE_NVLGIR AS GIRSINT, ';
  End;

  If fCfgSis('TIPCRI') = 'S' Then
  Begin
    strSQL := strSQL + '  I.ITE_NIVCRI AS ITE_NVLCRI, ';
    strSQL := strSQL + '  (SELECT EL.ITE_NIVCRI FROM ITEGER EL WHERE EL.ITE_CODITE = I.ITE_CODITE AND EL.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') AS CRISINT, ';
  End Else
  Begin
    strSQL := strSQL + '  C.ITE_NVLCRI, ';
    strSQL := strSQL + '  C.ITE_NVLCRI AS CRISINT, ';
  End;

  Result := strSQL;
End;

function fSQLFiltroSaldo(slsSaldos: TSelecaoSaldos; strEmpSel: String): String;
  Var
    strSQL: String;
Begin
  Result := '';
  if strEmpSel = '' Then
    strEmpSel := VS_StrCodEmp;

  If slsSaldos <> slsTodos Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' AND (SELECT SUM(ITE_SALDOS)  ';
    strSQL := strSQL + '      FROM ITEGER IL                               ';
    strSQL := strSQL + '      WHERE IL.ITE_CODEMP IN (' + strEmpSel + ') > 0 AND ';
    strSQL := strSQL + '            IL.ITE_CODITE = C.ITE_CODITE) ';

    case slsSaldos Of
      slsZerado: strSQL := strSQL + ' = 0 ';
      slsPositivo: strSQL := strSQL + ' > 0 ';
      slsNegativo: strSQL := strSQL + ' < 0 ';
    End;

    Result := strSQL;
  End;

End;

Procedure pInicializaFiltros(Var strCodFor, strRefere, strDesIte, strAcoObj: String);
Begin
  If fEmptyStr(strCodFor) Then
    strCodFor := '%';

  If fEmptyStr(strRefere) And (strRefere <> '%') Then
    strRefere := '%'
  Else
    strRefere := strRefere + '%';

  If fEmptyStr(strDesIte) And (strDesIte <> '%') Then
    strDesIte := '%'
  Else
    strDesIte := strDesIte + '%';

  If fEmptyStr(strAcoObj) And (strAcoObj <> '%')  Then
    strAcoObj := '%'
  Else
    strAcoObj := strAcoObj + '%';
End;

Function fSqlFiltroLocFisica(slfLocFis: TSelecaoLocFisica; strEmpSel: String): String;
  Var
    strSQL: String;
Begin
  Result := '';
  If slfLocFis <> slfTodas Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' AND (SELECT COUNT(*) ';
    strSQL := strSQL + '      FROM ITEGER IL                               ';
    strSQL := strSQL + '      WHERE IL.ITE_CODEMP IN (' + strEmpSel + ') AND ';
    strSQL := strSQL + '            IL.ITE_CODITE = C.ITE_CODITE ';

    Case slfLocFis Of
      slfComLocal: strSQL := strSQL + ' AND IFNULL(IL.ITE_LOCFIS, "") <> "" ';
      slfSemLocal: strSQL := strSQL + ' AND IFNULL(IL.ITE_LOCFIS, "") =  "" ';
    End;

    strSQL := strSQL + ' ) > 0 ';

    Result := strSQL;
  End;
End;

Function fSqlIteESMIDG: String;
Begin
  Result := '';
  Result := ' SELECT ITE_CODEMP AS CODEMP, ITE_CODITE AS CODITE, ITE_ESMIDG ';
  Result := Result + ' FROM ITEGER ';
  Result := Result + ' WHERE ITE_CODITE = :CODITE ';
End;

Function fSqlFiltroLocFisicaInicialFinal(strLocIni, strLocFin, strEmpSel: String): String;
Begin
  Result := '';

  If Not fEmptyStr(strLocIni) Then
  Begin

    If fUsaRotinaWMS Then
    Begin
      Result := ' AND (SELECT COUNT(*) FROM CADLOT WHERE ';
      Result := Result + '     LOT_CODEMP IN (' + strEmpSel  + ')' ;
      Result := Result + ' AND LOT_CODITE = I.ITE_CODITE  ';

      If fEmptyStr(strLocFin) Then
        Result := Result + ' AND IFNULL(LOT_LOCFIS, "") LIKE ' + QuotedStr(strLocIni + '%')
      Else
        Result := Result + ' AND LEFT(IFNULL(LOT_LOCFIS, ""), GREATEST(LENGTH(' + QuotedStr(strLocIni) + '), LENGTH(' + QuotedStr(strLocFin) + '))) BETWEEN ' + QuotedStr(strLocIni) + ' AND ' + QuotedStr(strLocFin);

      Result := Result + ') > 0 ';
    End Else
    Begin
      Result := Result + ' AND (SELECT COUNT(*) ';
      Result := Result + '      FROM ITEGER IL                                 ';
      Result := Result + '      WHERE     IL.ITE_CODEMP IN (' + strEmpSel + ') ';
      Result := Result + '            AND IL.ITE_CODITE = I.ITE_CODITE ';

      If fEmptyStr(strLocFin) Then
        Result := Result + ' AND IFNULL(IL.ITE_LOCFIS, "") LIKE ' + QuotedStr(strLocIni + '%')
      Else
        Result := Result + ' AND LEFT(IFNULL(IL.ITE_LOCFIS, ""), GREATEST(LENGTH(' + QuotedStr(strLocIni) + '), LENGTH(' + QuotedStr(strLocFin) + '))) BETWEEN ' + QuotedStr(strLocIni) + ' AND ' + QuotedStr(strLocFin);

      Result := Result + ') > 0 ';
    End;

  End;

End;

function fSQLFiltroAteMax(strEmpSel: String): String;
  Var
    strSQL: String;
Begin
  Result := '';

  strSQL := '';
  strSQL := strSQL + ' AND (SELECT SUM(IFNULL(ITE_ESTMAX, 0))  ';
  strSQL := strSQL + '      FROM ITEGER IL                               ';
  strSQL := strSQL + '      WHERE IL.ITE_CODEMP IN (' + strEmpSel + ') > 0 AND ';
  strSQL := strSQL + '            IL.ITE_CODITE = C.ITE_CODITE) > 0 ';

  Result := strSQL;

End;

Function fSQLFiltrosGiro(recOpcGir: TRecOpcoesGiro; blnFiltrarOperador: Boolean): String;
  Var
    strCodForL, strRefereL, strDesIteL, strAcoObjL, strSQL: String;
Begin
  With recOpcGir Do
  Begin
    strCodForL := strCodFor;
    strRefereL := strRefere;
    strDesIteL := strDesIte;
    strAcoObjL := strAcoObj;

    pInicializaFiltros(strCodForL, strRefereL, strDesIteL, strAcoObjL);

    strSQL := '';

    strSQL := strSQL + ' IFNULL(C.ITE_REFERE,"") LIKE ' + QuotedStr(strRefereL);

    strSQL := strSQL + ' AND IFNULL(C.ITE_DESITE,"") LIKE ' + QuotedStr(strDesIteL);

    strSQL := strSQL + ' AND IFNULL(C.ITE_ACOOBJ,"") LIKE ' + QuotedStr(strAcoObjL);

    If recOpcGir.strCodFor = '00000000' Then
      strSQL := strSQL + fStrLocate(Nil, arrCodFor,  'C.ITE_CODFOR', 'CODFOR', False, False, strcodFor)
    Else
    Begin
      strSQL := strSQL + '  AND (C.ITE_CODFOR LIKE ' + QuotedStr(strCodForL) + ' OR  C.ITE_CODITE IN  (SELECT ITEFOR.ITE_CODITE FROM ITEFOR ';
      strSQL := strSQL + '       WHERE ITEFOR.ITE_CODFOR = ' + QuotedStr(strCodForL) + ')) ';
    End;


    strSQL := strSQL + fStrLocateLinGru(Nil, arrLinhaGrupo, 'C.ITE_CODGRU', 'CODGRU', False, False, strCodGru);

    strSQL := strSQL + fStrLocate(Nil, arrMarca,  'C.ITE_CODMAR', 'CODMAR', False, False, strcodMar);

    strSQL := strSQL + fStrLocate(Nil, arrPrdGru, 'C.ITE_PRDGRU', 'PRDGRU', False, False, strPrdGru);

    strSQL := strSQL + fStrLocate(Nil, arrGruCmp, 'C.ITE_GRUCMP', 'GRUCMP', False, False, strGruCmp);

    {Req: 120053 - CORDEIRO AO MARCAR A OPÇÃO 'IMPORTAR REQUISIÇÕES AUTOMATICAMENTE' NÃO CONSIDERAR O NOVO FILTRO 'SITUAÇÃO DO PRODUTO'
    strSQL := strSQL + fStrLocate(Nil, arrSitPro,  'C.ITE_SITPRO', 'SITPRO', False, False, strSitPro);}

    strSQL := strSQL + fStrLocate(Nil, arrUnidade,'C.ITE_CODUNI', 'CODUNI', False, False, strUnidade);

    strSQL := strSQL + fStrLocate(Nil, arrCodDep, 'C.ITE_CODDEP', 'CODDEP', False, False, strCodDep);

    strSQL := strSQL + ' AND C.ITE_ITEATI = "S" ';

    strSQL := strSQL + ' AND C.ITE_ATICOM = "S" ';

    If blnFiltrarOperador And (Not fEmptyStr(strCodCmp)) And (Not fVerificaAcessoSistema('GRUCOM', strCodCmp)) Then
      strSQL := strSQL + ' AND IF(IFNULL(GC.GRU_OPERES, "") = "", TRUE, GC.GRU_OPERES = "' + strCodCmp +'") ';

    strSQL := strSQL + fSqlFiltroLocFisica(slfLocFis, IIF(fEmptyStr(strEmpGir), VS_strCodEmp, strEmpGir) );

    If opcChamada = chaSpoolTransferencia Then
      strSQL := strSQL + fSqlFiltroLocFisicaInicialFinal(strLocIni, strLocFin, strEmpresasOrigens);

    strSQL := strSQL + fSQLFiltroSaldo(slsSaldos, strEmpGir);
  End;

  Result := strSQL;
End;

Function fSQLEmpresaPedido: String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + '  IF(IFNULL(FGO_ENT_CD, "") = "S", FGO_EMP_CD, ';
  strSQL := strSQL + '    IF(IFNULL(FGO_EMP_TE, "") <> "", FGO_EMP_TE, ';
  strSQL := strSQL + '      IF(IFNULL(FGO_EMPFOR, "") <> "", FGO_EMPFOR, ';
  strSQL := strSQL + '        IF(IFNULL(FDO_EMPITE, "") <> "", FDO_EMPITE, ';
  strSQL := strSQL + '          IF(IFNULL(FGO_OPRFLJ, "") = "S", FDO_EMPPRD, FGO_CODEMP))))) ';

  Result := strSQL;
End;


Function fChaveTravaPedido(strNumPed, strEspDoc, strCodEmp: String): String;
Begin
  Result := 'PEDCOM' + strNumPed + strEspDoc + strCodEmp;
End;

Function fTravaDestravaPedidoCompra(blnTrava : Boolean; strNumPed, strEspDoc, strCodEmp: String): Boolean;
  Var
    strTrava : String;
Begin
  Result := True;

  strTrava := fChaveTravaPedido(strNumPed, strEspDoc, strCodEmp);

  If (Not fLock_Unlock(strTrava, blnTrava, False)) Then
  Begin
    fMensagem('ATENÇÃO!', 'O pedido de compra ' + strEspDoc + '-' + strNumPed + '-' + strCodEmp + #13#10 +
               'está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
    Result := False;
  End
End;

Function fSQLSaldosReservados(blnSoma: Boolean;
                              strAlias,
                              strAliasCadite,
                              strAliasSALPDC: String): String;
  Var
    recOpcGir: TRecOpcoesGiro;
Begin
  FillChar(recOpcGir, SizeOf(recOpcGir), #0);

  Result := fSQLSaldosReservados(blnSoma,
                                 False,
                                 recOpcGir,
                                 strAlias,
                                 strAliasCadite,
                                 strAliasSALPDC);
End;

Function fSQLSaldoItem(strAliasIteger: String; blnAgrSim: Boolean = False; strAliasCodIte: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If blnAgrSim Then
  Begin
    strSQL := strSQL + ' IFNULL(IF(IFNULL(ITE_CODSIM, "") = "" OR IFNULL(ITE_PRISIM, "N") = "N", (I.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(I.ITE_SAL_ML, 0) / ITE_CNV_ML, 0)), ';
    strSQL := strSQL + '     (SELECT SUM(SS.ITE_SALDOS + IF(IFNULL(CS.ITE_CNV_ML, 0) > 0, IFNULL(SS.ITE_SAL_ML, 0) / CS.ITE_CNV_ML, 0)) ';
    strSQL := strSQL + '      FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
    strSQL := strSQL + '      WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP)), 0) ';
  End Else
  Begin
    strSQL := strSQL + ' IFNULL(' + strAliasIteger + '.ITE_SALDOS + IF(IFNULL(ITE_CNV_ML, 0) > 0, IFNULL(' + strAliasIteger + '.ITE_SAL_ML, 0) / ITE_CNV_ML, 0), 0) ';
  End;

  Result := strSQL;
End;

Function fSQLSaldoReservadoPedido(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM', ' ') + '(IFNULL(' + strAliasIteger + '.ITE_QTPD_V, 0) + IFNULL(' + strAliasIteger + '.ITE_QTPD_F, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoReservadoPedidoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoReservadoPedido(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoReservadoPedido(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSubSQLPreparaTE(strAlias: String = 'I'; strSQLCodSim: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IFNULL((SELECT             ';
  strSQL := strSQL + '    SUM(PRE_QTDITE)  ';
  strSQL := strSQL + '  FROM     ';
  strSQL := strSQL + '    PREPTE ';

  If Not fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = PRE_CODITE ';

  strSQL := strSQL + '  WHERE  ';
  strSQL := strSQL + '        PRE_LIBERA = "S"           ';
  strSQL := strSQL + '    AND PRE_NUMDOC IS NULL         ';

  If fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + '    AND PRE_CODITE = ' + strAlias + '.ITE_CODITE '
  Else
    strSQL := strSQL + '    AND CS.ITE_CODSIM = ' + strSQLCodSim;

  strSQL := strSQL + '    AND PRE_EMPDES = ' + strAlias + '.ITE_CODEMP), 0) ';

  Result := strSQL;
End;

Function fSQLSaldoTranferencia(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM', ' ') + '(IFNULL(' + strAliasIteger + '.ITE_SALTRA, 0) + ' + fSubSQLPreparaTE(strAliasIteger) + ') ';
  Result := strSQL;
End;

Function fSQLSaldoTranferenciaAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoTranferencia(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoTranferencia(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoEnderecamento(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM', ' ') + '(IFNULL(' + strAliasIteger + '.ITE_QTPD_E, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoEnderecamentoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoEnderecamento(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoEnderecamento(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoGarantia(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_SALREG, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoGarantiaAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoGarantia(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoGarantia(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoExterno(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_SALEXT, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoExternoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoExterno(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoExterno(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoOrdemProducao(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM', ' ') + '(IFNULL(' + strAliasIteger + '.ITE_QTPD_P, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoOrdemProducaoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoOrdemProducao(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoOrdemProducao(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaAguarda(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_QTEF_A, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaAguardaAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoEntregaFuturaAguarda(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoEntregaFuturaAguarda(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaFalta(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_QTEF_F, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaFaltaAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoEntregaFuturaFalta(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoEntregaFuturaFalta(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaPrevisao(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_QTEF_P, 0)) ';
  Result := strSQL;
End;

Function fSQLSaldoEntregaFuturaPrevisaoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoEntregaFuturaPrevisao(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoEntregaFuturaPrevisao(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoFisico(blnSoma: Boolean; strAliasIteger, strAliasCadIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + IIF(blnSoma, 'SUM', '') + '(IFNULL(' + strAliasIteger + '.ITE_SALDOS, 0) +  ';
  strSQL := strSQL + ' (IFNULL(' + strAliasIteger + '.ITE_SAL_ML, 0) / IF(IFNULL(' + strAliasCadIte + '.ITE_CNV_ML, 1)  <=0,  1, IFNULL(' + strAliasCadIte + '.ITE_CNV_ML, 1))) +  ';
  strSQL := strSQL + ' IFNULL(' + strAliasIteger + '.ITE_QTEF_A, 0) +  ';
  strSQL := strSQL + ' IFNULL(' + strAliasIteger + '.ITE_QTEF_F, 0) +   ';
  strSQL := strSQL + ' IFNULL(' + strAliasIteger + '.ITE_QTEF_P, 0))  ';

  Result := strSQL;
End;

Function fSQLSaldoFisicoAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoFisico(blnSoma, strAliasIteger, strAliasCodIte) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoFisico(True, 'SS', 'CS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoEntregaFutura(strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := ' (';

  Case fCfgSis('CALSAL', varInteger) Of
    1:  Begin
          strSQL := strSQL + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger) + ' + ';
          strSQL := strSQL + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger)   + ' + ';
          strSQL := strSQL + fSQLSaldoEntregaFuturaPrevisao(False, strAliasIteger);
        End;

    2:   strSQL := strSQL + ' 0 ';

    3:  Begin
          strSQL := strSQL + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger);
        End;

    4:  Begin
          strSQL := strSQL + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger) + ' + ';
          strSQL := strSQL + fSQLSaldoEntregaFuturaPrevisao(False, strAliasIteger);
        End;

    5:  Begin
          strSQL := strSQL + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger) + ' + ';
          strSQL := strSQL + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger);
        End;
  End;

  strSQL := strSQL +  ') ';

  Result := strSQL;
End;

Function fSQLSaldoDisponivel(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM(', ' (');

  strSQL := strSQL +         fSQLSaldoItem(strAliasIteger, False);                       // ITE_SALDOS
  strSQL := strSQL + ' - ' + fSQLSaldoReservadoPedido(False, strAliasIteger);            // PEDIDO
  strSQL := strSQL + ' - ' + fSQLSaldoGarantia(False, strAliasIteger);                   // GARANTIA
  strSQL := strSQL + ' - ' + fSQLSaldoExterno(False, strAliasIteger);                    // EXTERNO
  strSQL := strSQL + ' - ' + fSQLSaldoOrdemProducao(False, strAliasIteger);              // ORDEM PRODUÇÃO
  strSQL := strSQL + ' - ' + fSQLSaldoEnderecamento(False, strAliasIteger);              // ENDEREÇAMENTO
  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFutura(strAliasIteger);                     // ENTREGA FUTURA

  strSQL := strSQL +  ') ';

  Result := strSQL;
End;

Function fSQLSaldoDisponivelAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoDisponivel(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoDisponivel(True, 'SS');
  strSQL := strSQL + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoBasicoInicialDeCompra(blnSoma: Boolean; strAliasIteger: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM(', ' (');

  strSQL := strSQL +  fSQLSaldoItem(strAliasIteger, False);                // ITE_SALDOS

  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger);
  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger);
  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaPrevisao(False, strAliasIteger);

  strSQL := strSQL +  ') '; // ONDE COMEÇA O SALDO DISPONÍVEL DO PEDIDO DE COMPRA

  Result := strSQL;
End;

Function fSQLSaldoBasicoInicialDeCompraAgrSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoBasicoInicialDeCompra(blnSoma, strAliasIteger) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoBasicoInicialDeCompra(True, 'SS');
  strSQL := strSQL + '     FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '    WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';
  Result := strSQL;
End;


function fSQLSaldoPedidoDeCompraEnvioFornecedor(blnSoma: Boolean; strAliasIteger: String): string;
begin
  Result := 'IFNULL(';
  If blnSoma Then
    Result := Result +  ' SUM( ';

  Result := Result +  ' (SELECT ';
  Result := Result +  '    SUM(IF(COALESCE((SELECT COUNT(1)';
  Result := Result +  '                       FROM MOVGAE D';
  Result := Result +  '                      WHERE D.GAE_NUMENV = SUBSTRING(PCG_DOCORI,1, 12)';
  Result := Result +  '                        AND D.GAE_ESPENV = SUBSTRING(PCG_DOCORI, 13,2)';
  Result := Result +  '                        AND D.GAE_EMPENV = SUBSTRING(PCG_DOCORI, LENGTH(PCG_DOCORI) - 2, LENGTH(PCG_DOCORI))) , 0) > 0, PCD_QTDITE - IFNULL(PCD_QTDBAI, 0) ,0)) AS QTDITE';
  Result := Result +  ' FROM PCMDET PE';
  Result := Result +  ' INNER JOIN PCMGER GE ON GE.PCG_NUMPED = PCD_NUMPED';
  Result := Result +  '                     AND GE.PCG_CODEMP = PCD_CODEMP';
  Result := Result +  '                     AND GE.PCG_ESPDOC = PCD_ESPDOC';
  Result := Result +  '                     AND GE.PCG_NUMCTN = PCD_NUMCTN';
  Result := Result +  ' WHERE GE.PCG_BAIXAD = 0';
  Result := Result +  '   AND GE.PCG_NUMCTN = 0';
  Result := Result +  '   AND IFNULL(PE.PCD_BAIXAD, 0) = 0';
  Result := Result +  '   AND PE.PCD_CODITE = ' + strAliasIteger + '.ITE_CODITE AND PE.PCD_CODEMP = ' + strAliasIteger + '.ITE_CODEMP ';
  Result := Result +  ' GROUP BY PCD_CODITE, PCD_CODEMP)';
  If blnSoma Then
    Result := Result +  ' )';
  Result := Result +  ',0 )';
End;

function fSQLSaldoRequisicaoViculadoComPedidoDeCompra(blnSoma: Boolean;
                                                      strAliasIteger: String): string;
Begin
  If fCfgSis('TPFLPC') = '1' then
    Exit(' ' + IIf(blnSoma, ' SUM(0) ', ' 0 '));

  Result := '';
  Result := ' IFNULL( ';

  If blnSoma Then
    Result := Result +  ' SUM( ';

  Result := Result +  '  (SELECT  SUM(ROUND( RCD_QTDITE - IFNULL( (SELECT SUM(BAI_QTDREQ) FROM BAIREQ  WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0 ), 4 ) ) AS QTDITE';
  Result := Result +  '    FROM MOVRCG';
  Result := Result +  '    JOIN MOVRCD ON RCD_CODIGO = RCG_CODIGO AND RCD_CODEMP = RCG_CODEMP';
  Result := Result +  '    JOIN CADITE C ON ITE_CODITE = RCD_CODITE';

  Result := Result +  '   WHERE TRUE ';

  Result := Result +  '  AND ((IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) = 1 ';

  Result := Result +  '  AND (SELECT COUNT(1) FROM PCMDET ';

  Result := Result +  '       INNER JOIN PCMGER ON PCG_NUMPED = PCD_NUMPED ';
  Result := Result +  '                         AND PCG_CODEMP = PCD_CODEMP ';
  Result := Result +  '                         AND PCG_ESPDOC = PCD_ESPDOC ';
  Result := Result +  '                         AND PCG_NUMCTN = PCD_NUMCTN ';

  Result := Result +  '       WHERE ';
  Result := Result +  '         PCMDET.AUTOINCREM = RCD_SEQPCD AND PCD_BAIXAD = 0 AND PCG_BAIXAD = 0 ';

  Result := Result +  '       ) ';

  Result := Result +  '       ) OR ';

  Result := Result +  '       IFNULL((SELECT COUNT(*) ';
  Result := Result +  '               FROM PCMIRQ_RES PR ';
  Result := Result +  '               INNER JOIN PCMGER_RES ON PCMGER_RES.AUTOINCREM = PR.PCM_SEQPCG ';
  Result := Result +  '               WHERE PR.PCM_SEQREQ = MOVRCD.AUTOINCREM ';
  Result := Result +  '               AND IF(PCMGER_RES.PCG_EXCLUI = "N", PR.EXCLUIDO = "N", false )),0 ) > 0) ';

  Result := Result +  '   AND (SELECT GROUP_CONCAT(CONCAT(D.DET_ESPDOC, "-", D.DET_NUMDOC, "-", D.DET_CODEMP)) FROM BAIREQ ';
  Result := Result +  '                INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM)  IS NULL ';

  Result := Result +  '   AND RCD_CODITE = ' + strAliasIteger + '.ITE_CODITE AND RCD_CODEMP = ' + strAliasIteger + '.ITE_CODEMP ';

  Result := Result +  '   GROUP BY RCD_CODITE, RCD_CODEMP)';

  If blnSoma Then
    Result := Result +  ' )';

  Result := Result + ' , 0) ';
End;

function fSQLSaldoRequisicao(blnSoma: Boolean;
                             strAliasIteger: String): string;
Begin
  Result := '';
  If blnSoma Then
    Result := Result +  ' SUM( ';
  Result := Result +  '  (SELECT SUM((ROUND(RCD_QTDITE - IFNULL((SELECT SUM(BAI_QTDREQ) FROM BAIREQ WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0), 4))) AS QTDITE';
  Result := Result +  '    FROM MOVRCG';
  Result := Result +  '    JOIN MOVRCD ON RCD_CODIGO = RCG_CODIGO AND RCD_CODEMP = RCG_CODEMP';
  Result := Result +  '    LEFT JOIN PREPRQ ON PRQ_SEQRCD = MOVRCD.AUTOINCREM';
  Result := Result +  '    LEFT JOIN FDOABS ON ABS_SEQPRQ = PREPRQ.AUTOINCREM';
  Result := Result +  '    LEFT JOIN FATDOR ON FATDOR.AUTOINCREM = ABS_SEQFDO';
  Result := Result +  '    LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FDO_SEQGER';
  Result := Result +  '    JOIN CADITE C ON ITE_CODITE = RCD_CODITE';
  Result := Result +  '    LEFT JOIN FGOSTA S ON EXTGOR.FGO_STATUS = S.STA_CODIGO';
  Result := Result +  '   WHERE TRUE';
  Result := Result +  '     AND (((RCD_SEQPCD IS NULL) AND (RCD_SEQCOT IS NULL) AND';
  Result := Result +  '           (IFNULL((SELECT COUNT(*) FROM PCMIRQ_RES PR INNER JOIN  PCMGER_RES ON PCMGER_RES.AUTOINCREM = PR.PCM_SEQPCG WHERE PR.PCM_SEQREQ = MOVRCD.AUTOINCREM';
  Result := Result +  '            AND IF(PCMGER_RES.PCG_EXCLUI = "N", PR.EXCLUIDO = "N", FALSE)), 0 ) = 0)';
  Result := Result +  '            AND ((IFNULL(RCD_DOCPDV, "") = "") OR';
  Result := Result +  '          (IFNULL((SELECT FGO_LIBERA AND FGO_LIBCOM FROM FATGOR WHERE FGO_NUMDOC = RCD_DOCPDV AND FGO_CODEMP = RCD_EMPPDV AND FGO_ESPDOC = RCD_ESPPDV), TRUE)  ))))';
  Result := Result +  '     AND RCD_ATETRA <> 1';
  Result := Result +  '     AND RCD_REQNEG = "N"';
  Result := Result +  '     AND IFNULL((SELECT SUM(B.BAI_QTDREQ) FROM BAIREQ B';
  Result := Result +  '                  INNER JOIN MOVDET D ON D.AUTOINCREM = B.BAI_AUTDET AND D.DET_DTAENT IS NOT NULL WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM), 0) < RCD_QTDITE';
  Result := Result +  '     AND RCD_CODITE = ' + strAliasIteger + '.ITE_CODITE AND RCD_CODEMP = ' + strAliasIteger + '.ITE_CODEMP ';


  Result := Result +  '     AND IF(IFNULL(RCD_SEQCOT, "") = "", 0, 1) = 0 ';
  Result := Result +  '     AND IF(IFNULL(RCD_SEQPCD, "") = "", 0, 1) = 0 ';


  Result := Result +  '         AND (SELECT GROUP_CONCAT(CONCAT(D.DET_ESPDOC, "-", D.DET_NUMDOC, "-", D.DET_CODEMP)) FROM BAIREQ ';
  Result := Result +  '               INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET WHERE BAI_AUTREQ = MOVRCD.AUTOINCREM)  IS NULL ';

  Result := Result +  '   GROUP BY RCD_CODITE, RCD_CODEMP)';
  If blnSoma Then
    Result := Result +  ' )'
End;

function fSQLSaldoRequisicaoSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): string;
Begin
  Result := '';
  Result := Result + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoRequisicao(blnSoma, strAliasIteger) + ', ';
  Result := Result +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoRequisicao(True, 'SS');
  Result := Result + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  Result := Result + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';
End;

function fSQLSaldoRequisicaoViculadoComPedidoDeCompraSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte: String): string;
Begin
  Result := '';
  Result := Result + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoRequisicaoViculadoComPedidoDeCompra(blnSoma, strAliasIteger) + ', ';
  Result := Result +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoRequisicaoViculadoComPedidoDeCompra(True, 'SS');
  Result := Result + '       FROM ITEGER SS INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  Result := Result + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';
End;

Function fSQLSaldoBasicoDeCompra(blnSoma,
                                 blnUsarOpcGiro: Boolean;
                                 recOpcGir: TRecOpcoesGiro;
                                 strAliasIteger,
                                 strAliasSALPDC: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + IIF(blnSoma, ' SUM(', ' (');

  strSQL := strSQL +         fSQLSaldoItem(strAliasIteger, False);               // ITE_SALDOS

  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger);
  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger);
  strSQL := strSQL + ' + ' + fSQLSaldoEntregaFuturaPrevisao(False, strAliasIteger);

  If (Not blnUsarOpcGiro) Or recOpcGir.blnEntFutPrevisao Then
    strSQL := strSQL + ' - ' + fSQLSaldoEntregaFuturaPrevisao(False, strAliasIteger);

  If (Not blnUsarOpcGiro) Or recOpcGir.blnEntFutFalta Then
    strSQL := strSQL + ' - ' + fSQLSaldoEntregaFuturaFalta(False, strAliasIteger);

  If (Not blnUsarOpcGiro) Or recOpcGir.blnEntFutAguarda Then
    strSQL := strSQL + ' - ' + fSQLSaldoEntregaFuturaAguarda(False, strAliasIteger);

  If (Not blnUsarOpcGiro) Or recOpcGir.blnDescSalExt Then
    strSQL := strSQL + ' - ' + fSQLSaldoExterno(False, strAliasIteger);  // PEDIDO

  If (Not blnUsarOpcGiro) Or recOpcGir.blnConsPedVen Then
    strSQL := strSQL + ' - ' + fSQLSaldoReservadoPedido(False, strAliasIteger);  // PEDIDO

  If (Not blnUsarOpcGiro) Or recOpcGir.blnConsGarPen Then
     strSQL := strSQL + ' - ' +  fSQLSaldoGarantia(False, strAliasIteger);       // GARANTIA

  If (Not blnUsarOpcGiro) Or recOpcGir.blnConsOrdPro Then
    strSQL := strSQL + ' - ' + fSQLSaldoOrdemProducao(False, strAliasIteger);    // ORDEM PRODUÇÃO

  If blnUsarOpcGiro Then
  Begin
    If recOpcGir.blnConsTransf Then
      strSQL := strSQL + ' + ' + fSQLSaldoTranferencia(False, strAliasIteger);

    If recOpcGir.blnConsPedPen Then
      strSQL := strSQL + ' + ' + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, recOpcGir.blnConsPedPenTransferencia, False, strAliasSALPDC, recOpcGir.strEmpSubtraiPedTransf);

    If recOpcGir.blnConsRequisicao Then
      strSQL := strSQL + ' + ' + fSQLSaldoRequisicao(False {blnSoma},  strAliasIteger);

  End;

  // ENDEREÇAMENTO NAO TIRA DO SALBAS DO PEDIDO DE COMPRA

  strSQL := strSQL +  ') ';
  If recOpcGir.blnConsPedPen Then
  Begin
    If recOpcGir.strNumPedAlt <> '' Then
    Begin
      If blnSoma Then
      Begin
        strSQL := strSQL + ' - IFNULL((SELECT SUM(PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI)';
        strSQL := strSQL + '             FROM PCMDET ';
        strSQL := strSQL + '            WHERE PCMDET.PCD_CODITE = ' + strAliasIteger+'.ITE_CODITE';
        strSQL := strSQL + '              AND PCMDET.PCD_NUMPED = ' + QuotedStr(recOpcGir.strNumPedAlt);
        strSQL := strSQL + '              AND PCMDET.PCD_CODEMP = ' + QuotedStr(recOpcGir.strEmpPedAlt);
        strSQL := strSQL + '              AND PCMDET.PCD_ESPDOC = ' + QuotedStr(recOpcGir.strEspPedAlt);
        strSQL := strSQL + ' ), 0)';
      End
      Else
      Begin
        strSQL := strSQL + ' - IFNULL((SELECT IF(IFNULL(PCDDET.AUTOINCREM, "") = "",  SUM(PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI), SUM(PCDDET.PCD_QTDITE - PCDDET.PCD_QTDBAI)) ';
        strSQL := strSQL + '             FROM PCMDET ';
        strSQL := strSQL + '             INNER JOIN PCMGER ';
        strSQL := strSQL + '                     ON PCMGER.PCG_NUMPED = PCMDET.PCD_NUMPED ';
        strSQL := strSQL + '                    AND PCMGER.PCG_CODEMP = PCMDET.PCD_CODEMP ';
        strSQL := strSQL + '                    AND PCMGER.PCG_ESPDOC = PCMDET.PCD_ESPDOC ';
        strSQL := strSQL + '                    AND PCMGER.PCG_CODFOR = PCMDET.PCD_CODFOR ';
        strSQL := strSQL + '             LEFT JOIN PCDDET ON PCDDET.PCD_SEQGER = PCMDET.AUTOINCREM ';
        strSQL := strSQL + '            WHERE PCMDET.PCD_CODITE = ' + strAliasIteger+'.ITE_CODITE';
        strSQL := strSQL + '              AND PCMDET.PCD_NUMPED = ' + QuotedStr(recOpcGir.strNumPedAlt);
        strSQL := strSQL + '              AND PCMDET.PCD_CODEMP = ' + QuotedStr(recOpcGir.strEmpPedAlt);
        strSQL := strSQL + '              AND PCMDET.PCD_ESPDOC = ' + QuotedStr(recOpcGir.strEspPedAlt);
        strSQL := strSQL + '              AND (IF(IFNULL(PCDDET.AUTOINCREM, "") = "",                                ';
        strSQL := strSQL + '                             IFNULL(PCMGER.PCG_EMPDES,PCMGER.PCG_CODEMP) = I.ITE_CODEMP, ';
        strSQL := strSQL + '                             PCDDET.PCD_EMPDES = I.ITE_CODEMP))                           ';
        strSQL := strSQL + ' ), 0)';
      End;
    End;
  End;
  Result := strSQL;
End;

Function fSQLSaldoBasicoDeCompraAgrSim(blnSoma: Boolean;
                                       blnUsarOpcGiro: Boolean;
                                       recOpcGir: TRecOpcoesGiro;
                                       strAliasIteger,
                                       strAliasCodIte,
                                       strAliasSALPDC: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoBasicoDeCompra(blnSoma, blnUsarOpcGiro, recOpcGir, strAliasIteger, strAliasSALPDC) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoBasicoDeCompra(True, blnUsarOpcGiro, recOpcGir, 'SS', 'PS');
  strSQL := strSQL + '       FROM ITEGER SS ';
  strSQL := strSQL + '       INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       LEFT  JOIN SALPDC PS ON PS.SAL_CODITE = SS.ITE_CODITE AND PS.SAL_CODEMP = SS.ITE_CODEMP ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSaldoPedidoAtual(strAliasIteger: String; recOpcGir: TRecOpcoesGiro): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' - IFNULL((SELECT IF((IFNULL(PCDDET.AUTOINCREM, "") <> "" AND PCDDET.PCD_EMPDES <> PCMDET.PCD_CODEMP), 0, SUM( PCMDET.PCD_QTDITE - PCMDET.PCD_QTDBAI )) ';
  strSQL := strSQL + '             FROM PCMDET ';
  strSQL := strSQL + '             INNER JOIN PCMGER ';
  strSQL := strSQL + '                     ON PCMGER.PCG_NUMPED = PCMDET.PCD_NUMPED ';
  strSQL := strSQL + '                    AND PCMGER.PCG_CODEMP = PCMDET.PCD_CODEMP ';
  strSQL := strSQL + '                    AND PCMGER.PCG_ESPDOC = PCMDET.PCD_ESPDOC ';
  strSQL := strSQL + '                    AND PCMGER.PCG_CODFOR = PCMDET.PCD_CODFOR ';
  strSQL := strSQL + '             LEFT JOIN PCDDET ON PCDDET.PCD_SEQGER = PCMDET.AUTOINCREM ';

  strSQL := strSQL + '            WHERE PCMDET.PCD_CODITE = ' + strAliasIteger+'.ITE_CODITE';
  strSQL := strSQL + '              AND PCMDET.PCD_NUMPED = ' + QuotedStr(recOpcGir.strNumPedAlt);
  strSQL := strSQL + '              AND PCMDET.PCD_CODEMP = ' + QuotedStr(recOpcGir.strEmpPedAlt);
  strSQL := strSQL + '              AND PCMDET.PCD_ESPDOC = ' + QuotedStr(recOpcGir.strEspPedAlt);

  strSQL := strSQL + '              AND (IF(IFNULL(PCDDET.AUTOINCREM, "") = "",                                ';
  strSQL := strSQL + '                             IFNULL(PCMGER.PCG_EMPDES,PCMGER.PCG_CODEMP) = I.ITE_CODEMP, ';
  strSQL := strSQL + '                             PCDDET.PCD_EMPDES = I.ITE_CODEMP))                           ';
  strSQL := strSQL + ' ), 0)';

  Result := strSQL;
End;

Function fSQLSaldoCompraPendenteCalculoSugestao(blnSoma: Boolean;
                                                recOpcGir: TRecOpcoesGiro;
                                                strAliasIteger,
                                                strAliasSALPDC: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  strSQL := strSQL + fSQLCamposQuantidadePendenteCompra(blnSoma, recOpcGir.blnConsPedPenTransferencia, False, strAliasSALPDC,
                                                        recOpcGir.strEmpSubtraiPedTransf);

  strSQL := strSQL + ' - ' + fSQLSaldoRequisicaoViculadoComPedidoDeCompra(blnSoma, strAliasIteger) + ' ';

  If Not fEmptyStr(recOpcGir.strNumPedAlt) And SameText('PD', recOpcGir.strEspPedAlt) Then
    strSQL := strSQL + fSaldoPedidoAtual(strAliasIteger, recOpcGir);

  If recOpcGir.blnDesconsPedGar Then
    strSQL := strSQL + ' - ' + fSQLSaldoPedidoDeCompraEnvioFornecedor(blnSoma, strAliasIteger);

  Result := strSQL;
End;

Function fSQLSaldosReservados(blnSoma,
                              blnUsarOpcGiro: Boolean;
                              recOpcGir: TRecOpcoesGiro;
                              strAliasIteger,
                              strAliasCadIte,
                              strAliasSALPDC: String;
                              blnVirgulaultimocampo: Boolean = True): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + fSQLSaldoReservadoPedido(blnSoma, strAliasIteger)                         + ' AS ITE_SALRES, ';
  strSQL := strSQL + fSQLSaldoTranferencia(blnSoma, strAliasIteger)                            + ' AS ITE_SALTRA, ';
  strSQL := strSQL + fSQLSaldoEnderecamento(blnSoma, strAliasIteger)                           + ' AS ITE_SALEND, ';
  strSQL := strSQL + fSQLSaldoGarantia(blnSoma, strAliasIteger)                                + ' AS ITE_SALGAR, ';
  strSQL := strSQL + fSQLSaldoExterno(blnSoma, strAliasIteger)                                 + ' AS ITE_SALEXT, ';
  strSQL := strSQL + fSQLSaldoOrdemProducao(blnSoma, strAliasIteger)                           + ' AS ITE_QTPD_P, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaAguarda(blnSoma, strAliasIteger)                    + ' AS ITE_QTEF_A, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaFalta(blnSoma, strAliasIteger)                      + ' AS ITE_QTEF_F, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaPrevisao(blnSoma, strAliasIteger)                   + ' AS ITE_QTEF_P, ';
  strSQL := strSQL + fSQLSaldoFisico(blnSoma, strAliasIteger, strAliasCadIte)                  + ' AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel(blnSoma, strAliasIteger)                              + ' AS ITE_SALDIS, ';
  strSQL := strSQL + fSQLSaldoRequisicao(blnSoma, strAliasIteger)                   + ' AS ITE_SALREQ, ';


  strSQL := strSQL + fSQLSaldoCompraPendenteCalculoSugestao(blnSoma, recOpcGir,
                                  strAliasIteger, strAliasSALPDC)                              + ' AS ITE_QTDPEN, ';

  strSQL := strSQL + fSQLSaldoBasicoInicialDeCompra(blnSoma, strAliasIteger)                   + ' AS ITE_INIBAS, ';

  strSQL := strSQL + fSQLSaldoBasicoDeCompra(blnSoma,
                                             blnUsarOpcGiro,
                                             recOpcGir,
                                             strAliasIteger,
                                             strAliasSALPDC)                                   + ' AS ITE_SALBAS' + IIf(blnVirgulaultimocampo, ',', '');

  Result := strSQL;
End;

Function fSQLCamposQuantidadePendenteCompraSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte, strAliasSALPDC: String; recOpcGir: TRecOpcoesGiro): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLCamposQuantidadePendenteCompra(blnSoma, recOpcGir.blnConsPedPenTransferencia, False, strAliasSALPDC, recOpcGir.strEmpSubtraiPedTransf) + ', ';
  strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLCamposQuantidadePendenteCompra(True, recOpcGir.blnConsPedPenTransferencia, False, 'PS', '');
  strSQL := strSQL + '       FROM ITEGER SS ';
  strSQL := strSQL + '       INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
  strSQL := strSQL + '       LEFT  JOIN SALPDC PS ON PS.SAL_CODITE = SS.ITE_CODITE AND PS.SAL_CODEMP = SS.ITE_CODEMP ';
  strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';

  Result := strSQL;
End;

Function fSQLSaldoPedidoDeCompraEnvioFornecedorSim(blnSoma: Boolean; strAliasIteger, strAliasCodIte, strAliasSALPDC: String; recOpcGir: TRecOpcoesGiro): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  If recOpcGir.blnDesconsPedGar Then
  Begin
    strSQL := strSQL + ' IF(IFNULL(ITE_CODSIM, "") = "", ' + fSQLSaldoPedidoDeCompraEnvioFornecedor(blnSoma,  strAliasIteger) + ', ';
    strSQL := strSQL +     IIF(blnSoma, 'SUM', '') + '(IFNULL((SELECT ' + fSQLSaldoPedidoDeCompraEnvioFornecedor(True, 'SS');
    strSQL := strSQL + '       FROM ITEGER SS ';
    strSQL := strSQL + '       INNER JOIN CADITE CS ON SS.ITE_CODITE = CS.ITE_CODITE ';
    strSQL := strSQL + '       LEFT  JOIN SALPDC PS ON PS.SAL_CODITE = SS.ITE_CODITE AND PS.SAL_CODEMP = SS.ITE_CODEMP ';
    strSQL := strSQL + '       WHERE CS.ITE_CODSIM = ' + strAliasCodIte + '.ITE_CODSIM AND SS.ITE_CODEMP = ' + strAliasIteger + '.ITE_CODEMP), 0))) ';
  End;

  Result := strSQL;
End;


Function fSQLSaldosReservadosAgrSim(blnSoma,
                                    blnUsarOpcGiro: Boolean;
                                    recOpcGir: TRecOpcoesGiro;
                                    strAliasIteger,
                                    strAliasCodIte,
                                    strAliasSALPDC: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + fSQLSaldoReservadoPedidoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)        + ' AS ITE_SALRES, ';
  strSQL := strSQL + fSQLSaldoTranferenciaAgrSim(blnSoma, strAliasIteger, strAliasCodIte)           + ' AS ITE_SALTRA, ';
  strSQL := strSQL + fSQLSaldoEnderecamentoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)          + ' AS ITE_SALEND, ';
  strSQL := strSQL + fSQLSaldoGarantiaAgrSim(blnSoma, strAliasIteger, strAliasCodIte)               + ' AS ITE_SALGAR, ';
  strSQL := strSQL + fSQLSaldoExternoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)                + ' AS ITE_SALEXT, ';
  strSQL := strSQL + fSQLSaldoOrdemProducaoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)          + ' AS ITE_QTPD_P, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaAguardaAgrSim(blnSoma, strAliasIteger, strAliasCodIte)   + ' AS ITE_QTEF_A, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaFaltaAgrSim(blnSoma, strAliasIteger, strAliasCodIte)     + ' AS ITE_QTEF_F, ';
  strSQL := strSQL + fSQLSaldoEntregaFuturaPrevisaoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)  + ' AS ITE_QTEF_P, ';
  strSQL := strSQL + fSQLSaldoFisicoAgrSim(blnSoma, strAliasIteger, strAliasCodIte)                 + ' AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivelAgrSim(blnSoma, strAliasIteger, strAliasCodIte)             + ' AS ITE_SALDIS, ';
  strSQL := strSQL + fSQLSaldoRequisicaoSim(blnSoma, strAliasIteger, strAliasCodIte)                + ' AS ITE_SALREQ, ';


  strSQL := strSQL + fSQLCamposQuantidadePendenteCompraSim(blnSoma, strAliasIteger,  strAliasCodIte, strAliasSALPDC, recOpcGir);
  strSQL := strSQL +  ' - ' + fSQLSaldoRequisicaoViculadoComPedidoDeCompraSim(blnSoma, strAliasIteger, strAliasCodIte);
  If recOpcGir.blnDesconsPedGar Then
    strSQL := strSQL +  ' - ' + fSQLSaldoPedidoDeCompraEnvioFornecedorSim(blnSoma, strAliasIteger, strAliasCodIte, '', recOpcGir);
  strSQL := strSQL +  ' AS ITE_QTDPEN, ';

  strSQL := strSQL + fSQLSaldoBasicoInicialDeCompraAgrSim(blnSoma, strAliasIteger, strAliasCodIte)  + ' AS ITE_INIBAS, ';

  strSQL := strSQL + fSQLSaldoBasicoDeCompraAgrSim(blnSoma,
                                                   blnUsarOpcGiro,
                                                   recOpcGir,
                                                   strAliasIteger,
                                                   strAliasCodIte,
                                                   strAliasSALPDC)                                  + ' AS ITE_SALBAS, ';

  Result := strSQL;
End;

Function fSQLSaldosReservadosAgrSim(blnSoma: Boolean;
                                    strAliasIteger,
                                    strAliasCadIte,
                                    strAliasSALPDC: String): String;
  Var
    recOpcGir: TRecOpcoesGiro;
Begin
  FillChar(recOpcGir, SizeOf(recOpcGir), #0);

  Result := fSQLSaldosReservadosAgrSim(blnSoma,
                                       False,
                                       recOpcGir,
                                       strAliasIteger,
                                       strAliasCadIte,
                                       strAliasSALPDC);
End;

Procedure pGetSaldosReservados(cdsSaldos: TZClient;
                               strCodIte,
                               strEmpresas: String;
                               blnUsarOpcGiro: Boolean;
                               recOpcGir: TRecOpcoesGiro);
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';

  strSQL := strSQL + '   SUM(IFNULL(ITE_ESTMIN, 0)) AS ITE_ESTMIN, ';
  strSQL := strSQL + '   SUM(IFNULL(ITE_ESTMAX, 0)) AS ITE_ESTMAX, ';

  strSQL := strSQL + '   SUM(IFNULL(ITE_MINDIG, 0)) AS ITE_MINDIG, ';
  strSQL := strSQL + '   SUM(IFNULL(ITE_MAXDIG, 0)) AS ITE_MAXDIG, ';

  If recOpcGir.blnAgrSim And (fCfgSis('REMSIM', varBoolean) Or fSimilarPrincipal(strCodIte)) Then
  Begin
    strSQL := strSQL +  fSQLSaldosReservadosAgrSim(True,
                                                   blnUsarOpcGiro,
                                                   recOpcGir,
                                                   'I',
                                                   'C',
                                                   'SP');

    strSQL := strSQL + '  SUM(' + fSQLSaldoCotacao(strCodIte, 'I.ITE_CODEMP', 'C.ITE_CODSIM') + ') AS ITE_SALCOT, ';
    strSQL := strSQL + '  SUM((' + fSQLVendasPerdidas(strCodIte, 'I.ITE_CODEMP', recOpcGir, blnUsarOpcGiro, 'C.ITE_CODSIM') + ')) AS ITE_VENPER ';
  End Else
  Begin
    strSQL := strSQL +     fSQLSaldosReservados(True, blnUsarOpcGiro, recOpcGir, 'I', 'C','SP');
    strSQL := strSQL + '   SUM(' + fSQLSaldoCotacao(strCodIte, 'I.ITE_CODEMP') + ') AS ITE_SALCOT, ';
    strSQL := strSQL + '   SUM((' + fSQLVendasPerdidas(strCodIte, 'I.ITE_CODEMP', recOpcGir, blnUsarOpcGiro) + ')) AS ITE_VENPER ';
  End;

  strSQL := strSQL + ' FROM ITEGER I ';
  strSQL := strSQL + ' INNER JOIN CADITE C ON C.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN SALPDC SP ON SP.SAL_CODITE = I.ITE_CODITE AND SP.SAL_CODEMP = I.ITE_CODEMP ';

  strSQL := strSQL + ' WHERE I.ITE_CODITE = ' + QuotedStr(strCodIte);

  cdsSaldos.qryQuery.SQL.Text := strSQL;

  If Not fEmptyStr(strEmpresas) Then
    cdsSaldos.qryQuery.SQL.Add(' AND I.ITE_CODEMP IN (' + strEmpresas + ')');

  If cdsSaldos.fLeDados('pGetSaldosReservados') And blnUsarOpcGiro Then
  Begin
    cdsSaldos.Edit;

    If recOpcGir.blnVenPer Then
      cdsSaldos.FieldByName('ITE_SALBAS').AsFloat := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat - cdsSaldos.FieldByName('ITE_VENPER').AsFloat;

    If recOpcGir.blnConsCot Then
      cdsSaldos.FieldByName('ITE_SALBAS').AsFloat := cdsSaldos.FieldByName('ITE_SALBAS').AsFloat + cdsSaldos.FieldByName('ITE_SALCOT').AsFloat;

    cdsSaldos.Post;
  End;
End;

Function fSQLVendasPerdidas(strCodIte, strEmpresas: String; recOpcGir: TRecOpcoesGiro; blnComGiro: Boolean; strSQLCodSim: String = ''): String;
  Var
    strSQL: String;
    intMes,
    intContador: Integer;
    dtaDtaIni,
    dtaDtaFin: TDateTime;
    stlMeses: TStringList;

  Function fGetSQL(strDtaIni, strDtaFin: String): String;
    Var
     strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    SUM(VPD_QTDITE) AS QTDPER  ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    MOVVPD ';
    strSQL := strSQL + '    INNER JOIN MOVVPG ON VPG_CODEMP = VPD_CODEMP AND VPG_CODIGO = VPD_CODIGO ';
    strSQL := strSQL + '    INNER JOIN MOTVPD ON MOT_CODMOT = VPD_CODMOT AND MOT_CONPED = "S" ';

    If Not fEmptyStr(strSQLCodSim) Then
      strSQL := strSQL + '    INNER JOIN CADITE CS ON CS.ITE_CODITE = VPD_CODITE ';

    strSQL := strSQL + '  WHERE ';

    If fEmptyStr(strSQLCodSim) Then
      strSQL := strSQL + '    VPD_CODITE = ' + QuotedStr(strCodIte)
    Else
      strSQL := strSQL + '    CS.ITE_CODSIM = ' + strSQLCodSim;

    If Not fEmptyStr(strEmpresas) Then
      strSQL := strSQL + '  AND  VPD_CODEMP IN (' + strEmpresas + ') ';

    strSQL := strSQL + '    AND VPG_DTACAD BETWEEN ' + QuotedStr(strDtaIni) + ' AND ' + QuotedStr(strDtaFin) + ') ';

    Result := strSQL;
  End;

  function fRetMes(intContador: Integer): Integer;
  Begin
    Result := StrToIntDef(RightStr(stlMeses[Pred(intContador)], 2), 0);
  End;

  function fRetAno(intContador: Integer): Integer;
  Begin
    Result := StrToIntDef(LeftStr(stlMeses[Pred(intContador)], 4), 0);
  End;

Begin
  If (recOpcGir.strMeses.IsEmpty) Or (Not blnComGiro) Then
  Begin
    Result := '0';
    Exit;
  End;

  strSQL        := '';
  stlMeses      := TStringList.Create;
  stlMeses.Text := recOpcGir.strMeses;

  intMes := recOpcGir.intMesGir;

  If intMes = 0 Then
    intMes := 3;

  For intContador := 0 To intMes - 1 Do
  Begin
    If Not fEmptyStr(strSQL) Then
      strSQL := strSQL + ' + ';

    dtaDtaIni := EncodeDate(fRetAno(Succ(intContador)), fRetMes(Succ(intContador)), 1);
    dtaDtaFin := EndOfTheMonth(dtaDtaIni);

    strSQL := strSQL + fGetSQL(FormatDateTime('YYYY-MM-DD', dtaDtaIni), FormatDateTime('YYYY-MM-DD', dtaDtaFin));
  End;

  If recOpcGir.blnConsMesAtu Then
  Begin
    strSQL := strSQL + ' + ';

    dtaDtaIni := StartOfTheMonth(VS_Date);
    dtaDtaFin := VS_Date;

    strSQL := strSQL + fGetSQL(FormatDateTime('YYYY-MM-DD', dtaDtaIni), FormatDateTime('YYYY-MM-DD', dtaDtaFin));
  End;

  strSQL := 'SELECT (' + strSQL + ') AS SUM_PERDIDA';

  Result := strSQL;

  FreeAndNil(stlMeses);
End;

function fMesesGiro(recOpcGir: TRecOpcoesGiro; intQtdMeses: Integer = 0): String;
var
  arrMeses: TArray<String>;
  arrLimitado: TArray<String>;
  i: Integer;
begin
  arrMeses := recOpcGir.strMeses.Split([sLineBreak]);

  // Se intQtdMeses for maior que 0 e menor/igual que o tamanho do array, limita
  if (intQtdMeses > 0) and (intQtdMeses <= Length(arrMeses)) then
  begin
    SetLength(arrLimitado, intQtdMeses);
    for i := 0 to intQtdMeses - 1 do
      arrLimitado[i] := arrMeses[i];
  end
  else
    arrLimitado := arrMeses;

  Result := '"' + String.Join('","', arrLimitado) + '"';

  if recOpcGir.blnConsMesAtu then
    Result := Result + ',' + FormatDateTime('yyyy/mm', VS_Date).QuotedString('"');
End;


Function fSQLSaldoCotacao(strCodIte, strEmpresas: String; strSQLCodSim: String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL :=  '';
  strSQL := strSQL + ' (SELECT ';
  strSQL := strSQL + '   IFNULL(SUM(CT.COT_QTDITE), 0) AS QTDITE  ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   COTITE CT ';

  strSQL := strSQL + ' INNER JOIN COTGER CG ON CG.AUTOINCREM = CT.COT_SEQGER ';

  If Not fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = CT.COT_CODITE ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '   CG.COT_DTAFIN IS NULL AND ';
  strSQL := strSQL + '   CG.COT_MULLOJ = "N"   AND ';
  strSQL := strSQL + '   CT.COT_QTDITE > 0     AND ';

  If fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + '   CT.COT_CODITE = ' + QuotedStr(strCodIte)
  Else
    strSQL := strSQL + '   CS.ITE_CODSIM = ' + strSQLCodSim;

  If Not fEmptyStr(strEmpresas) Then
    strSQL := strSQL + ' AND CG.COT_CODEMP IN (' + strEmpresas + ') ';

  strSQL := strSQL + ' ) + (SELECT ';
  strSQL := strSQL + '       IFNULL(SUM(CT.PCD_QTDITE), 0) AS QTDITE  ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   PCDCOT CT ';

  strSQL := strSQL + ' INNER JOIN COTGER CG ON CG.AUTOINCREM = CT.PCD_SEQGER ';

  If Not fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + ' INNER JOIN CADITE CS ON CS.ITE_CODITE = CT.PCD_CODITE ';

  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '   CG.COT_DTAFIN IS NULL AND ';
  strSQL := strSQL + '   CG.COT_MULLOJ = "S"   AND ';
  strSQL := strSQL + '   CT.PCD_QTDITE > 0     AND ';

  If fEmptyStr(strSQLCodSim) Then
    strSQL := strSQL + '   CT.PCD_CODITE = ' + QuotedStr(strCodIte)
  Else
    strSQL := strSQL + '   CS.ITE_CODSIM = ' + strSQLCodSim;

  If Not fEmptyStr(strEmpresas) Then
    strSQL := strSQL + '  AND CT.PCD_EMPDES IN (' + strEmpresas + ')  ';

  strSQL := strSQL + ') ';

  Result := strSQL;
End;

function fEhPedidoCompraMultiLoja(strNumPed, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  COUNT(*) AS QTDREG ');
    SQL.Add('FROM ');
    SQL.Add('  PCDDET ');
    SQL.Add('WHERE ');
    SQL.Add('  PCD_NUMPED = :NUMPED AND ');
    SQL.Add('  PCD_ESPDOC = :ESPDOC AND ');
    SQL.Add('  PCD_CODEMP = :CODEMP ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    Result := FieldByName('QTDREG').AsInteger > 0;

    Close;
  End;

  FreeAndNil(qryGen);
End;

Function fTemPreNotaPedido(strNumPed, strCodEmp: String; Var strNotas: String): Boolean;
  Var
    qryNotas: TUniQuery;
Begin
  qryNotas := fCriaQuery(Nil);

  With qryNotas, SQL Do
  Begin
    Add('SELECT ');
    Add(' GROUP_CONCAT(B08_NNF) AS NOTAS ');
    Add('FROM PEDELE ');
    Add('INNER JOIN GERELE G ON G.AUTOINCREM = PEL_SEQELE AND (G.GER_DOCENT IS NULL)');
    Add('WHERE ');
    Add('  PEL_NUMDOC = :NUMPED AND');
    Add('  PEL_CODEMP = :CODEMP     ');

    ParamByName('NUMPED').AsString := strNumPed;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    strNotas := FieldByName('NOTAS').AsString;

    Result := Not fEmptyStr(strNotas)
  End;

  FreeAndNil(qryNotas);
End;

procedure pCarregaDadosST(qryAbf: TUniQuery; strCodFor, strCodAbf: String);
begin
  qryAbf.SQL.Clear;
  qryAbf.SQL.Add('SELECT ');
  qryAbf.SQL.Add('  ABFICM.* ');
  qryAbf.SQL.Add('FROM ');
  qryAbf.SQL.Add('  ABFICM ');
  qryAbf.SQL.Add('  JOIN CADFOR ON FOR_CODFOR = :CODFOR ');
  qryAbf.SQL.Add('  JOIN CADCID ON CID_CODCID = FOR_CODCID ');
  qryAbf.SQL.Add('WHERE ');
  qryAbf.SQL.Add('  ABF_CODABF = :CODABF AND ');
  qryAbf.SQL.Add('  ABF_ESTADO = CID_ESTADO ');

  qryAbf.ParamByName('CODABF').AsString := strCodAbf;
  qryAbf.ParamByName('CODFOR').AsString := strCodFor;
  qryAbf.Open;
end;

Function fCalculaPerSub(fltTotIte, fltTotFre, fltTotAce, fltTotIpi, fltTotSub: Double;
                        strFrmPcm, strBStFre, strBStAce: String): Double;
Begin
  If (strFrmPcm = '1') Then
    fltTotIte := fltTotIte + fltTotIpi;

  If strBStFre = 'S' Then
    fltTotIte := fltTotIte + fltTotFre;

  If strBStAce = 'S' Then
    fltTotIte := fltTotIte + fltTotAce;

  If fltTotIte > 0 Then
    Result := (fltTotSub / fltTotIte) * 100
  Else
    Result := 0;
End;

Function fCalculaPisCofins(fltTotIte, fltAlqPis: Double; blnIncPis: Boolean): Double;
Begin
  If blnIncPis Then
  Begin
    Result := RoundTo(fltTotIte * fltAlqPis / 100, -2);
  End Else
  Begin
    Result := 0;
  End;
End;

function fRetornaAbreviacaoItem(strCodIte: String; strTipAbf: String = ''): String;
  Var
    qryIte: TUniQuery;
begin
  If strTipAbf = '' Then
    strTipAbf := fCfgSis('TIPABF');

  qryIte := fCriaQuery(Nil);
  qryIte.SQL.Add('SELECT ');
  qryIte.SQL.Add('  ITE_CODABF ');
  qryIte.SQL.Add('FROM ');

  If strTipAbf = '1' Then
  Begin
    qryIte.SQL.Add('  CADITE ');
    qryIte.SQL.Add('WHERE ');
  End
  Else
  Begin
    qryIte.SQL.Add('  ITEGER ');
    qryIte.SQL.Add('WHERE ');
    qryIte.SQL.Add('  ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ');
  End;
  qryIte.SQL.Add('  ITE_CODITE = :CODITE ');

  qryIte.ParamByName('CODITE').AsString := strCodIte;
  qryIte.Open;

  Result := qryIte.FieldByName('ITE_CODABF').AsString;

  FreeAndNil(qryIte);
end;

function fCalcularSubstituicaoProduto(strCodFor,
                                      strCodAbf: String;
                                      fltTotIte,
                                      fltTotFre,
                                      fltTotAce: Double;
                                      strFrmPcm,
                                      strBStFre,
                                      strBStAce: String;
                                      blnZonaFranca,
                                      blnIncPis,
                                      blnFornecSimples,
                                      blnTemDare: Boolean;
                                      fltAlqIPI: Double;
                                      blnZeraST: boolean;
                                      Var AfltBasIcm,
                                          AfltAlqIcm,
                                          AfltValIcm,
                                          AfltBaseST,
                                          AfltDesPis,
                                          AfltBasIPI,
                                          AfltValIPI,
                                          AfltPerFCP,
                                          AfltSubFCP,
                                          AfltTotDar: Double;
                                      Var strCodSit,
                                          strCodSitOrigem: String;
                                      var AfltAliquotaSub: Double;
                                      ParametrosImpostos: TParametrosCalculoImposto;
                                      strTipAbfFor: String = '';
                                      qryDadosAbf: TUniQuery = Nil): Double;

  Var
    fltBasPis: Double;
    fltPerBasST: Double;
    fltPerBasIcms: Double;
    fltBasIPI_Save: Double;
    blnLiberarAbf: Boolean;

    Function fSetaBaseICMSInicial: Double;
    begin
      If blnZonaFranca Then
        Result := fltTotIte
      Else
        Result := fltTotIte + fltTotFre + fltTotAce;
    End;

    Procedure pCalculaPISCofins2(Var fltDesPis: Double);
    Begin
      fltBasPis := fltTotIte;

      If ParametrosImpostos.Param_Fornecedor.blnIncluiFrete_desAce_Na_BaseCalculoPisCofins Then
        fltBasPis :=  fltBasPis + fltTotFre + fltTotAce;
      fltDesPis := fCalculaPisCofins(fltBasPis, ParametrosImpostos.Param_Fornecedor.fRetAliquotaPisCofins, blnIncPis);
    End;

    Procedure pCalculaValorICMS(Var fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis: Double; blnChamadaPeloPisCofins: Boolean = False);
    Begin
      //Se for chamado pelo calculo de pisCofins não executa esse bloco, pois nesse bloco é aplicado o desconto de pisCofins
      If Not blnChamadaPeloPisCofins Then
      Begin
        //Icms Desonerado
        If ((blnZonaFranca) And ParametrosImpostos.blnCalcularICMSDesonerado And
           (ParametrosImpostos.Param_Fornecedor.blnAplicaPisCofins_na_BaseIcmsDesonerado)) Then
        Begin
           pCalculaPisCofins2(fltDesPis);
           fltBasIcm :=  fltBasIcm - fltDesPis
        End
        //Icms Operacoes Proprias
        Else If (Not blnZonaFranca) Then
        Begin
           case ParametrosImpostos.rciConsideraDescontoPisCofins_na_Base_ICMSOpProprias of
             rciSim        : begin
                              pCalculaPisCofins2(fltDesPis);
                              fltBasIcm :=  fltBasIcm - fltDesPis;
                             end;
             rciFornecedor : begin
                              pCalculaPISCofins2(fltDesPis);
                               If ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoPisCofins_na_BaseICMS Then
                                 fltBasIcm :=  fltBasIcm - fltDesPis;
                             End;
           end;
        End;
      End;
      // Incluir Frete e despesas Acessorias no calculo do icms desonerado
      If blnZonaFranca And ParametrosImpostos.blnCalcularICMSDesonerado and
         ParametrosImpostos.Param_Fornecedor.blnIncluiFrete_DesAce_na_BaseIcmsDesonerado Then
       fltBasIcm := fltBasIcm + fltTotFre + fltTotAce;

      fltBasIcm := fFormataFloatInterna(fltBasIcm * fltPerBasIcms / 100, 4);
      fltAlqIcm := qryDadosAbf.FieldByName('ABF_ALQICM' + strTipAbfFor).AsFloat;
      fltValIcm := fFormataFloatInterna(fltBasIcm * fltAlqIcm / 100, 4);
    End;

    procedure pCalculaIPI(Var fltBasIPI, fltValIpi, fltValIcm, fltDesPis: Double);
    Begin
      If (blnZonaFranca and ParametrosImpostos.blnCalcularICMSDesonerado and
          ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoICMSDesonerado_na_BaseIPI) Then
        fltBasIpi := fltBasIPI - fltValIcm;

      If ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoPisCofins_na_BaseIPI Then
        fltBasIpi := fltBasIPI - fltDesPis;

      fltValIPI := RoundTo(fltBasIPI * (fltAlqIPI /100), -2);
    End;

    procedure pCalculaPISCofins(Var fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis: Double);
    begin
      fltBasPis := fltTotIte;

      If ParametrosImpostos.Param_Fornecedor.blnIncluiFrete_desAce_Na_BaseCalculoPisCofins Then
        fltBasPis :=  fltBasPis + fltTotFre + fltTotAce;
      If blnZonaFranca and ParametrosImpostos.blnCalcularICMSDesonerado And ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoICMSDesonerado_na_BasePisCofins Then
      Begin
        fltBasIcm := fSetaBaseICMSInicial;
        pCalculaValorICMS(fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis, True);
        fltBasPis := fltBasPis - fltValIcm;
      End;

      fltDesPis := fCalculaPisCofins(fltBasPis, ParametrosImpostos.Param_Fornecedor.fRetAliquotaPisCofins, blnIncPis);
    End;

    function fCalculaST(Var fltBaseST, fltBasIPI, fltValIpi, fltValIcm, fltDesPis: Double): Double;
      Var
        fltPartePositiva: Double;
        fltParteNegativa: Double;
    Begin
      If blnZeraST Then
      Begin
        Result := 0;
        fltBaseST := 0;
      End
      Else
      Begin
        fltBaseST := fltTotIte;

        If strBStFre = 'S' Then
          fltBaseST := fltBaseST + fltTotFre;

        If strBStAce = 'S' Then
          fltBaseST := fltBaseST + fltTotAce;

        If (strFrmPcm = '1') Then
        Begin
          pCalculaIPI(fltBasIPI, fltValIpi, fltValIcm, fltDesPis);
          fltBaseST := fltBaseST + fltValIpi;
        End;

        If blnZonaFranca and ParametrosImpostos.blnCalcularICMSDesonerado And
           (Pos(qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor).AsString, CST_SUBSTITUICAO) > 0) Then
          fltBaseST := fltBaseST - fltValIcm;

        If ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoPisCofins_na_BaseST Then
          fltBaseST := fltBaseST - fltDesPis;

        fltBaseST := fltBaseST * fltPerBasST / 100;
        fltBaseST := fltBaseST * qryDadosAbf.FieldByName('ABF_IVA_ST' + strTipAbfFor).AsFloat;

        fltPartePositiva := (fltBaseST * qryDadosAbf.FieldByName('ABF_ALQRET' + strTipAbfFor).AsFloat) / 100;

        fltParteNegativa := fltValIcm;

        Result := fFormataFloatInterna(fltPartePositiva - fltParteNegativa, 2);
      End;

    End;

    Function fCalculaDare(fltBasIPI: Double): Double;
      Var
        fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis, fltValIpi, fltBaseST: Double;
    Begin
      fltBasIcm := fSetaBaseICMSInicial + RoundTo(fltBasIpi * (fltAlqIpi / 100), -4);

      pCalculaValorICMS(fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis);

      pCalculaPISCofins(fltBasIcm, fltAlqIcm, fltValIcm, fltDesPis);

      pCalculaIPI(fltBasIPI, fltValIpi, fltValIcm, fltDesPis);

      Result := fCalculaST(fltBaseST, fltBasIPI, fltValIpi, fltValIcm, fltDesPis);
    End;

begin
  AfltAliquotaSub := 0;

  fltBasIPI_Save := AfltBasIPI;

  Result := 0;

  AfltBasIcm := 0;
  AfltAlqIcm := 0;
  AfltValIcm := 0;
  AfltBaseST := 0;
  AfltDesPis := 0;
  AfltPerFCP := 0;
  AfltSubFCP := 0;
  AfltTotDar := 0;

  strCodSit := '';

  blnLiberarAbf := False;

  If fEmptyStr(strCodAbf) Then
    Exit;

  If strCodFor.IsEmpty Then
    Exit;

  If Not Assigned(qryDadosAbf) Then
  Begin
    qryDadosAbf := fCriaQuery(Nil);
    blnLiberarAbf := True;
  End;

  If qryDadosAbf.IsEmpty Or (strCodAbf <> qryDadosAbf.FieldByName('ABF_CODABF').AsString) Then
    pCarregaDadosST(qryDadosAbf, strCodFor, strCodAbf);

  If fEmptyStr(strTipAbfFor) Then
    strTipAbfFor := fGetTipoAbfFornecedor(strCodFor);

  strCodSit       := qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor).AsString;
  strCodSitOrigem := qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor+ '_O').AsString;

  fltPerBasIcms := qryDadosAbf.FieldByName('ABF_BASICM' + strTipAbfFor).AsFloat;
  fltPerBasST   := qryDadosAbf.FieldByName('ABF_BASRET' + strTipAbfFor).AsFloat;

  AfltBasIcm := fSetaBaseICMSInicial;

  pCalculaValorICMS(AfltBasIcm, AfltAlqIcm, AfltValIcm, AfltDesPis);

  pCalculaPISCofins(AfltBasIcm, AfltAlqIcm, AfltValIcm, AfltDesPis);

  pCalculaIPI(AfltBasIPI, AfltValIpi, AfltValIcm, AfltDesPis);

  Result := fCalculaST(AfltBaseST, AfltBasIPI, AfltValIpi, AfltValIcm, AfltDesPis);

  If Result < 0 Then
    Result := 0;

  If Not (Pos(qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor).AsString, CST_SUBSTITUICAO) > 0) Then
  Begin
    AfltBaseST := 0;
    Result    := 0;
  End

  Else If blnTemDare And
          (Pos(qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor + '_O').AsString, CST_SUBSTITUICAO) = 0) Then
  Begin
    AfltBaseST := 0;
    Result    := 0;

    AfltTotDar := fCalculaDare(fltBasIPI_Save);
  End;

  If (Not (
           ((Pos(qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor).AsString, CST_TRIBUTADO) > 0) And blnZonaFranca) Or
           ((Pos(qryDadosAbf.FieldByName('ABF_CODSIT' + strTipAbfFor).AsString, CST_SUBSTITUICAO) > 0) And blnZonaFranca And (ParametrosImpostos.Param_Fornecedor.blnAplicaDescontoPisCofins_na_BaseST))
         )) Or blnFornecSimples  Then
  Begin
    AfltBasIcm := 0;
    AfltAlqIcm := 0;
    AfltValIcm := 0;
    AfltDesPis := 0;
  End;

  If Result > 0 Then
    AfltAliquotaSub := fCalculaPerSub(fltTotIte, fltTotFre, fltTotAce, AfltValIpi, Result, strFrmPcm, strBStFre, strBStAce);

  AfltPerFCP := qryDadosAbf.FieldByName('ABF_ALQFCP' + strTipAbfFor).AsFloat;
  AfltSubFCP := fFormataFloatInterna(Result * qryDadosAbf.FieldByName('ABF_ALQFCP' + strTipAbfFor).AsFloat / 100, 2);

  If blnLiberarAbf Then
    FreeAndNil(qryDadosAbf);
end;

Procedure pCarregaUltimaCompraGeral(cdsItensPedido: TUniClientDataSet; strCodIte, strEmpGir: String);
  Var
    qryIteger: TUniQuery;
Begin
  qryIteger := fCriaQuery;
  With qryIteger, SQL Do
  Begin
    Add('SELECT ');
    Add('  ITE_PREULT, ');
    Add('  ITE_IMPULT, ');
    Add('  ITE_QTDUCO, ');
    Add('  ITE_FORULT, ');
    Add('  FOR_NOMFOR AS ITE_NOMFOR, ');
    Add('  ITE_DTAULT ');
    Add('FROM ITEGER ');
    Add('  LEFT JOIN CADFOR UF ON FOR_CODFOR = ITE_FORULT ');
    Add('WHERE ITE_CODITE = :CODITE AND ITE_DTAULT IS NOT NULL');

    If Not fEmptyStr(strEmpGir) Then
      Add(' AND ITE_CODEMP IN (' +  strEmpGir + ')');

    Add('ORDER BY ITE_DTAULT DESC LIMIT 1');

    ParamByName('CODITE').AsString := strCodIte;

    Open;

    If Not IsEmpty Then
    Begin
      cdsItensPedido.FieldByName('ITE_PREULT').Value := FieldByName('ITE_PREULT').Value;
      cdsItensPedido.FieldByName('ITE_IMPULT').Value := FieldByName('ITE_IMPULT').Value;
      cdsItensPedido.FieldByName('ITE_QTDUCO').Value := FieldByName('ITE_QTDUCO').Value;
      cdsItensPedido.FieldByName('ITE_FORULT').Value := FieldByName('ITE_FORULT').Value;
      cdsItensPedido.FieldByName('ITE_NOMFOR').Value := FieldByName('ITE_NOMFOR').Value;
      cdsItensPedido.FieldByName('ITE_DTAULT').Value := FieldByName('ITE_DTAULT').Value;

      If (Not cdsItensPedido.FieldByName('ITE_DTAULT').IsNull) And (cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime > 0) Then
        cdsItensPedido.FieldByName('ITE_DIAUCO').AsInteger  := Trunc(VS_Date - cdsItensPedido.FieldByName('ITE_DTAULT').AsDateTime);
    End;

  End;
  FreeAndNil(qryIteger);
End;

{ TParametrosImpostosFornecedor }

procedure TParametrosCalcImpostosFornecedor.pCarregaConfiguracoes(strCodFor: String);
  var qryFornecedor: TUniQuery;
begin
  qryFornecedor := fCriaQuery;
  Try
    qryFornecedor.SQL.Text := 'SELECT * FROM CADFOR WHERE FOR_CODFOR = "' + strCodFor + '"';
    qryFornecedor.Open;
    pCarregaConfiguracoes(qryFornecedor);

  Finally
    FreeAndNil(qryFornecedor);
  End;

end;

function TParametrosCalcImpostosFornecedor.fRetAliquotaPisCofins: Double;
begin
  Result := fltAliquotaPis + fltAliquotaCofins
end;

procedure TParametrosCalcImpostosFornecedor.pCarregaConfiguracoes(qryCadFor: TUniQuery);
begin
  blnAplicaDescontoICMSDesoneradoPedido            := qryCadFor.FieldByName('FOR_ADIDPC').AsString = 'S';
  blnIncluiFrete_DesAce_na_BaseIcmsDesonerado      := qryCadFor.FieldByName('FOR_FDAICD').AsString = 'S';
  blnAplicaPisCofins_na_BaseIcmsDesonerado         := qryCadFor.FieldByName('FOR_IDPCID').AsString = 'S';
  blnAplicaDescontoPisCofinsPedidoCompra           := qryCadFor.FieldByName('FOR_ADPCPC').AsString = 'S';
  blnIncluiFrete_desAce_Na_BaseCalculoPisCofins    := qryCadFor.FieldByName('FOR_IFDAPC').AsString = 'S';
  blnAplicaDescontoICMSDesonerado_na_BasePisCofins := qryCadFor.FieldByName('FOR_ADICPC').AsString = 'S';
  fltAliquotaPis                                   := qryCadFor.FieldByName('FOR_ALQPIS').AsFloat;
  fltAliquotaCofins                                := qryCadFor.FieldByName('FOR_ALQCOF').AsFloat;
  blnAplicaDescontoICMSDesonerado_na_BaseST        := qryCadFor.FieldByName('FOR_ADIDST').AsString = 'S';
  blnAplicaDescontoPisCofins_na_BaseST             := qryCadFor.FieldByName('FOR_REDPIS').AsString = 'S';
  blnAplicaDescontoICMSDesonerado_na_BaseICMS      := qryCadFor.FieldByName('FOR_ADIDIC').AsString = 'S';
  blnAplicaDescontoPisCofins_na_BaseICMS           := qryCadFor.FieldByName('FOR_ADPCST').AsString = 'S';
  blnAplicaDescontoICMSDesonerado_na_BaseIPI       := qryCadFor.FieldByName('FOR_ADIDCI').AsString = 'S';
  blnAplicaDescontoPisCofins_na_BaseIPI            := qryCadFor.FieldByName('FOR_ADPCIP').AsString = 'S';
end;

{ TParametrosCalculoImposto }

procedure TParametrosCalculoImposto.pSetaParametros(AValField_ITE_CICMDE,
  AValField_ITE_CDPIOP, AValField_ITE_DIDIOP: String);
begin
  blnCalcularICMSDesonerado := AValField_ITE_CICMDE = 'S';
  If AValField_ITE_CDPIOP = 'F' Then
    rciConsideraDescontoPisCofins_na_Base_ICMSOpProprias := rciFornecedor
  Else If AValField_ITE_CDPIOP = 'S' Then
    rciConsideraDescontoPisCofins_na_Base_ICMSOpProprias := rciSim
  Else
    rciConsideraDescontoPisCofins_na_Base_ICMSOpProprias := rciNao;

  If AValField_ITE_DIDIOP= 'F' Then
    rciConsiderarDescontoICMSDson_Na_Base_ICMSOpProprias := rciFornecedor
  Else If AValField_ITE_DIDIOP = 'S' Then
    rciConsiderarDescontoICMSDson_Na_Base_ICMSOpProprias := rciSim
  Else
    rciConsiderarDescontoICMSDson_Na_Base_ICMSOpProprias := rciNao;
end;

function fLiberaQuantidadeMultiplos(strCodIte: String): Boolean;
 var
   objLiberacao : ILiberacao;
Begin
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
  objLiberacao.objMsgLibera.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Produto ' + strCodIte + '-' + fRetNomProduto(strCodIte) + ' múltiplos de compra ');

  objLiberacao.strDirAce := 'CMPMLT';
  objLiberacao.strMsgSen := 'QUANTIDADE MÚLTIPLOS DE ECOMPRA';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;
//  objLiberacao.tipCliFor := cfFornecedor;

  Result := objLiberacao.fLibera;
End;

function fPedidoEstaEmPreNota(strNumPed,strEmpPed,strEspDoc: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM DEFBAI');
    qryConsulta.SQL.Add(' WHERE DEF_AUTPCG IN (SELECT  AUTOINCREM FROM PCMGER');
    qryConsulta.SQL.Add('                       WHERE PCG_NUMPED = "' + strNumPed + '"');
    qryConsulta.SQL.Add('                         AND PCG_CODEMP = "' + strEmpPed + '"');
    qryConsulta.SQL.Add('                         AND PCG_ESPDOC = "' + strEspDoc + '")');
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsFloat > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fPedidoBaixadoPelaEntrada(strNumPed,strEmpPed,strEspDoc: String): Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT SUM(QTD) AS QTD FROM(SELECT COUNT(1) AS QTD FROM PREBAI');
    qryConsulta.SQL.Add('                             WHERE PRE_AUTPED IN (SELECT AUTOINCREM FROM PCMDET');
    qryConsulta.SQL.Add('                                                   WHERE PCD_NUMPED ="' + strNumPed + '"');
    qryConsulta.SQL.Add('                                                     AND PCD_CODEMP ="' + strEmpPed + '"');
    qryConsulta.SQL.Add('                                                     AND PCD_ESPDOC = "' + strEspDoc + '")');
    qryConsulta.SQL.Add('                             UNION ALL');
    qryConsulta.SQL.Add('                            SELECT COUNT(1) AS QTD FROM BAIPED');
    qryConsulta.SQL.Add('                             WHERE BAI_AUTPED IN (SELECT AUTOINCREM FROM PCMDET');
    qryConsulta.SQL.Add('                                                   WHERE PCD_NUMPED ="' + strNumPed + '"');
    qryConsulta.SQL.Add('                                                     AND PCD_CODEMP ="' + strEmpPed + '"');
    qryConsulta.SQL.Add('                                                     AND PCD_ESPDOC = "' + strEspDoc + '")) TMP');
    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsFloat > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

function fVerificaProssegueComPedidoDeImportacao(AQryPedImp:TUniQuery): Boolean;
var
  strPedidos: String;
begin
  Result := True;
  If not AQryPedImp.IsEmpty Then
    if AQryPedImp.FieldByName('CLAFIS').AsString <> '3949' Then
      Exit(False);

  If AQryPedImp.IsEmpty Then
    Exit(True);

  If not (AQryPedImp.IsEmpty) Then
  Begin
    With AQryPedImp Do
    Begin
      First;
      While not Eof Do
      Begin
        strPedidos :=  strPedidos + ' Pedido / Nota Fiscal: '
                                 + FieldByName('PCG_NUMPED').AsString + ' | '
                                 + FieldByName('PCG_DOCEMI').AsString + sLineBreak;
        Next;
      End;

      Result := fPergunta('O Pedido abaixo é de importação'
                           +' e possui Nota Fiscal vinculada!'
                           + sLineBreak + sLineBreak
                           + strPedidos + sLineBreak
                           +' Deseja Continuar?')
    End;
  End;
end;


function fValidaSeDocumentoPodeSerBaixado(strNumDoc,strEspDoc,strCodEmp, strAutInc: String;
                                          out AopcRequisicao: TOpcRequisicao;
                                          out AintMotivoReq: Integer;
                                          out AstrMotivoReq: String;
                                          stlListaSelecao: TStringList = Nil): Boolean;
var
  qryDados,
  qryPedImp,
  qryConsulta: TUniQuery;
  strWhere: String;
  intCntLista:Integer;
begin
   Result      := True;
   strWhere    := '';
   qryConsulta := fCriaQuery;
   qryDados    := fCriaQuery;
   qryPedImp   := fCriaQuery;

   intCntLista := -1;
   If Assigned(stlListaSelecao) Then
   Begin
     If stlListaSelecao.Count > 0 Then
       intCntLista := stlListaSelecao.Count;
   End;

   Try
     qryConsulta.SQL.Add('SELECT ');
     qryConsulta.SQL.Add('  CONCAT("A transferência  ", GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP, " que gerou este pedido foi confirmada na nota ", GER_NUMFAT, "-NF-", GER_EMPFAT) AS MSG,');
     qryConsulta.SQL.Add('  CONCAT("A transferência  ", GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP, " que gerou o pedido ", PCG_NUMPED, "-", PCG_CODEMP, " foi confirmada na nota ", GER_NUMFAT, "-NF-", GER_EMPFAT) AS MSG2, ');
     qryConsulta.SQL.Add('  A.GER_NUMFAT, ');
     qryConsulta.SQL.Add('  PCG_NUMPED, ');
     qryConsulta.SQL.Add('  CONCAT(GER_ESPDOC, "-", GER_NUMDOC, "-", GER_CODEMP) AS NUMDOC ');

     qryConsulta.SQL.Add('  FROM PCMGER');
     qryConsulta.SQL.Add('  INNER JOIN   MOVGER A ON A.GER_NUMDOC = SUBSTR( PCG_DOCORI, 01, 12 )');
     qryConsulta.SQL.Add('                      AND A.GER_ESPDOC = SUBSTR( PCG_DOCORI, 13, 02 )');
     qryConsulta.SQL.Add('                      AND A.GER_CODEMP = SUBSTR( PCG_DOCORI, 15, 03 )');
     qryConsulta.SQL.Add('                      AND A.GER_CODCLI IS NOT NULL ');

     If Assigned(stlListaSelecao) And (intCntLista > 0) Then
     Begin

       strWhere:= 'WHERE PCMGER.AUTOINCREM IN (' + fRetStrToSQLIn(stlListaSelecao.CommaText, ',') + ')';

       qryConsulta.SQL.Add(strWhere);
     End
     Else
     Begin

       strWhere:= 'WHERE PCG_NUMPED = :NUMPED ';
       strWhere:= strWhere + ' AND PCG_CODEMP = :CODEMP';
       strWhere:= strWhere + ' AND PCG_ESPDOC = :ESPPED';

       qryConsulta.SQL.Add(strWhere);

     End;

     If intCntLista = -1 Then
     Begin
       qryConsulta.ParamByName('NUMPED').AsString := strNumDoc;
       qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
       qryConsulta.ParamByName('ESPPED').AsString := strEspDoc;
     End;

     qryConsulta.Open;

     qryPedImp.Close;
     qryPedImp.SQL.Clear;

     qryPedImp.SQL.Add('SELECT PCG_CODEMP, PCG_NUMPED, PCG_ESPDOC, PCG_DOCEMI, IFNULL(G.GER_CLAFIS, N.GER_CLAFIS) AS CLAFIS FROM PCMGER');
     qryPedImp.SQL.Add('LEFT JOIN MOVGER G ON G.GER_NUMDOC = PCG_DOCEMI');
     qryPedImp.SQL.Add('                AND G.GER_ESPDOC = PCG_ESPEMI');
     qryPedImp.SQL.Add('                AND G.GER_SERIE_ = PCG_SEREMI');
     qryPedImp.SQL.Add('LEFT JOIN NOTGER N ON N.GER_NUMDOC = PCG_DOCEMI');
     qryPedImp.SQL.Add('                AND N.GER_ESPDOC = PCG_ESPEMI');
     qryPedImp.SQL.Add('                AND N.GER_SERIE_ = PCG_SEREMI');
     qryPedImp.SQL.Add(strWhere + ' AND PCG_PEDIMP = "S" AND PCG_DOCEMI IS NOT NULL ');  {Pega os pedidos de importação com NF já emitida}

     If qryPedImp.FindParam('NUMPED') <> Nil Then
       qryPedImp.ParamByName('NUMPED').AsString := strNumDoc;

     If qryPedImp.FindParam('CODEMP') <> Nil Then
       qryPedImp.ParamByName('CODEMP').AsString := strCodEmp;

     If qryPedImp.FindParam('ESPPED') <> Nil Then
       qryPedImp.ParamByName('ESPPED').AsString := strEspDoc;

     qryPedImp.Open;
     qryPedImp.First;

     If Assigned(stlListaSelecao) And (intCntLista > 1) Then
       TRequisicaoPedidoCompra.pCarregaRequisicoesPedido(qryDados, fRetStrToSQLIn(stlListaSelecao.CommaText, ','))
     Else
       TRequisicaoPedidoCompra.pCarregaRequisicoesPedido(qryDados, QuotedStr(strAutInc));


     If Not qryPedImp.IsEmpty Then
     begin
       If qryPedImp.FieldByName('CLAFIS').AsString = '3949' Then
       begin
         Result := fVerificaProssegueComPedidoDeImportacao(qryPedImp);
         If qryConsulta.IsEmpty Then
           Exit;
       End;
     End;

     If qryConsulta.IsEmpty And qryDados.IsEmpty and qryPedImp.IsEmpty Then
       Exit;

     Result := qryConsulta.IsEmpty;

     Try
       pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);

       While not qryConsulta.Eof Do
       Begin
         frmMensagemExplicativa.mmoInstru.Lines.Add('');

         If fEmptyStr(qryConsulta.FieldByName('GER_NUMFAT').AsString) Then
         Begin
           frmMensagemExplicativa.mmoInstru.Lines.Add('   O Pedido ' + qryConsulta.FieldByName('PCG_NUMPED').AsString + ' é oriundo da ' + qryConsulta.FieldByName('NUMDOC').AsString);
           frmMensagemExplicativa.mmoInstru.Lines.Add('e não pode ser baixado. Cancele a T.E. na empresa origem.');
         End Else
         Begin
           frmMensagemExplicativa.mmoInstru.Lines.Add(qryConsulta.FieldByName('MSG2').AsString);
           frmMensagemExplicativa.mmoInstru.Lines.Add('Por este motivo, o Pedido de Compra não pode ser baixado, ');
           frmMensagemExplicativa.mmoInstru.Lines.Add('Caso deseje cancelar a transferência, é preciso primeiramente cancelar a nota.');
         End;

         qryConsulta.Next;
       End;

       If Not Result Then
       Begin
         frmMensagemExplicativa.ShowModal;
         Exit;
       End;

       If (Not (qryPedImp.IsEmpty)) And (qryPedImp.FieldByName('CLAFIS').AsString <> '3949') Then
       Begin
         frmMensagemExplicativa.mmoInstru.Lines.Add('');
         frmMensagemExplicativa.mmoInstru.Lines.Add('O Pedido abaixo não pode ser baixado, pois, o mesmo é de importação e possui Nota Fiscal vinculada!');
         frmMensagemExplicativa.mmoInstru.Lines.Add('');
         While not qryPedImp.Eof Do
         Begin
           frmMensagemExplicativa.mmoInstru.Lines.Add('Pedido / Nota Fiscal: '+qryPedImp.FieldByName('PCG_NUMPED').AsString +' | '+ qryPedImp.FieldByName('PCG_DOCEMI').AsString);
           qryPedImp.Next;
         End;

         frmMensagemExplicativa.ShowModal;
         Result:= False;
         Exit;
       End;

       If Not qryDados.IsEmpty Then
       Begin
         pCriarFormularios(TfrmOpcaoBaixaRequisicao, frmOpcaoBaixaRequisicao);

         While not qryDados.Eof Do
         Begin
           frmOpcaoBaixaRequisicao.mmoInstru.Lines.Add('');
           frmOpcaoBaixaRequisicao.mmoInstru.Lines.Add('   O Pedido ' + qryDados.FieldByName('NUMPED').AsString + ' tem as seguintes requisições vinculadas:');
           frmOpcaoBaixaRequisicao.mmoInstru.Lines.Add('     ' + qryDados.FieldByName('NUMRCD').AsString);

           qryDados.Next;
         End;

         Result := frmOpcaoBaixaRequisicao.ShowModal = MrOk;

         If Result Then
         Begin
           If frmOpcaoBaixaRequisicao.rdgOpcaoPedido.ItemIndex = 0 Then
             AopcRequisicao := opcManterAberto
           Else
             AopcRequisicao := opcNegar;

           AstrMotivoReq := frmOpcaoBaixaRequisicao.mmoJUSTIF.Texto;
           AintMotivoReq := frmOpcaoBaixaRequisicao.rdgMotNeg.ItemIndex;
         End;

         FreeAndNil(frmOpcaoBaixaRequisicao);
       End;

     Finally
       FreeAndNil(frmMensagemExplicativa);
     End;

   Finally
     FreeAndNil(qryDados);
     FreeAndNil(qryConsulta);
     FreeAndNil(qryPedImp);
   End;

End;
{ TRecOpcoesGiro }

function TRecOpcoesGiro.fFornecedoresSelecionados: String;
  Var
   i: Integer;
   lstrCodFor: String;
begin
  Result := EmptyStr;

  if (Length(Self.arrCodFor) = 0) and fEmptyStr(Self.strCodFor)  then
    Exit;

  For i := Low(Self.arrCodFor) to high(Self.arrCodFor) do
  begin
    lstrCodFor := Self.arrCodFor[i].strCodigo;

    if Not fEmptyStr(lstrCodFor) then
      Result := Result + Format('%s_',[lstrCodFor]);
  end;

  if fEmptyStr(Result) and (Not fEmptyStr(Self.strCodFor)) then
    Result := Format('_%s_',[Self.strCodFor])
  else
    Result := '_'+Result;
end;

function fCarregaPontoExposicao(strCodIte, strEmpGir: String): Double;
  Var
    qryIteger: TUniQuery;
Begin
  if fEmptyStr(strEmpGir) then
    strEmpGir := VS_StrCodEmp;
  Result := 0;
  qryIteger := fCriaQuery;
  Try
    qryIteger.Sql.Clear;
    qryIteger.Sql.Add('SELECT SUM(IFNULL(ITE_PONEXP,0)) AS PONEXP ');
    qryIteger.Sql.Add('FROM ITEGER ');
    qryIteger.Sql.Add('WHERE ITE_CODITE = :CODITE ');
    qryIteger.Sql.Add(' AND ITE_CODEMP IN (' +  strEmpGir + ')');

    qryIteger.ParamByName('CODITE').AsString := strCodIte;

    qryIteger.Open;

    If qryIteger.IsEmpty Then
      Exit;

    Result := qryIteger.FieldByName('PONEXP').Value;

  Finally
    FreeAndNil(qryIteger);
  End;
End;

end.

