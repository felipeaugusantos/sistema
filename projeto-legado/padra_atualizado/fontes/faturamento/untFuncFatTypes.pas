unit untFuncFatTypes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  Controls, UniClientDataSet, untFuncoesSimples, Vcl.Forms, untCadLote,
{$ENDIF}
  Classes, TypInfo,  untTMatrizSaldosColorantes, DB,
  Uni, SysUtils, Variants, untConstantes, untTypesSistema,
  strUtils, DateUtils, Rest.Json, Shared.Functions.Types,
  System.Generics.Collections,
  untTipoFreteAtc, Promocao.Regra.Preco.Sugestao, Math;

type
  TPegaPrecoVendaOutput = record
    ValorUnitario : Double;
    ValorUnitarioOriginal : Double;
    ValorUnitarioLiquido : Double;
    ValorUnitarioSemJuros : Double;
    TaxaDeJurosDaCondicao : Double;
    PercentualDescontoEmbalagemFechada : Double;
    ValorDescontoEmbalagemFechada : Double;
    PercentualDescontoCondicaoPagamento : Double;
    ValorDescontoCondicaoPagamento : Double;
    StatusDoProduto : String;
    ValorCotacaoDolarVenda : Double;
    ItemEmbalagemFechada : Boolean;
  End;

type
  TItemRemovido = (tirTodos, tirRequisicao, tirTransferencia);
  TRegraPrecoSugestao = Promocao.Regra.Preco.Sugestao.TRegraPrecoSugestao;

type
  TDadosFazendaBase = class
  public
    strCodCli: String;
    strCodFaz: String;
    strNomFaz: String;
    strEndere: String;
    strBairro: String;
    strEndNum: String;
    strEndCom: String;
    strEndCep: String;
    strCodCid: String;
    strNomCid: String;
    strEstado: String;
    intCgcCpf: Integer;
    strNuCnpj: String;
    strNumIes: String;
    strNomCon: String;
    strTelCon: String;
  end;

type
  TPedidoVenda = class(TObject)
    public
      strNumDoc: String;
      strEspDoc: String;
      strCodEmp: String;
      strCodCli: String;
      fltDesCon: Double;
      strSeqGer: String;
      strEmpExp: String;
      strCodFaz: String;
      strCodEmb: String;
      strCodVen: String;
      strTemADT: String;
      blnGaraTE: Boolean;
  End;

type
  IResolveConflitosPedido = interface
    procedure pAddDocumentos(strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
  end;

type
  TProdutosOriginaisFatorServico = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strCodIte: String;
    intSeqInd: Integer;
    fltUniTar: Double;
    fltTotIte: Double;
    fltVlrCon: Double;
    fltComRep: Double;
    fltTotCom: Double;
    fltUniDig: Double;
    fltValFle: Double;
    fltUndIde: Double;
    fltDesEsp: Double;
    fltBasIpi: Double;
    fltValIpi: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
    fltBasRet: Double;
    fltValRet: Double;
  End;

  TArrayProdutosOriginaisFatorServico = Array of TProdutosOriginaisFatorServico;

  TPedidoOriginalFatorServico = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    fltTotPro: Double;
    fltDesEsp: Double;
    fltBasIpi: Double;
    fltTotIpi: Double;
    fltBasIcm: Double;
    fltTotIcm: Double;
    fltBasRet: Double;
    fltTotRet: Double;
    objItensPedido: TArrayProdutosOriginaisFatorServico;
  End;

type
  TExpedicaoParams = class
  public
    strNumRom: String;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strSerie_: String;
    strEmpExp: String;
    strCtrNumDup: String;
    strCtrEspDoc: String;
    strCtrCodEmp: String;
    strCtrCodCli: String;
    blnTemRec: Boolean;
    blnTemAdt: Boolean;
    blnBolAdt: Boolean;
    blnManPar: Boolean;
    strNumPok: String;
    strPedSit: String;
    blnRegEsp: Boolean;
    strEmpOriRegEsp: String;
    strEspTra: String;
    intQtdTra: Integer;
    intQtdTraSepExc: Integer;
    intQtdTraSepNExc: Integer;
    intQtdTraTmp: Integer;
    stlPedidos: TStringList;
    stlListaClientes: TStringList;
    stlListaGrupos: TStringList;
    VS_strTipExpInterna: String;
    qryFatGor: TUniQuery;
    cdsItens: TUniClientDataSet;
    cdsFilEst: TUniClientDataSet;
    cdsExpedicao: TUniClientDataSet;
    blnLimparExpedidos: Boolean;
    blnVendaPerdidaAutomatica: Boolean;
    blnExpPar: Boolean;
    blnExpParcial: Boolean;
    blnExpediMult: Boolean;
    blnCarregarQtdExpedida: Boolean;
    blnSolicitaTelaDeVolume: Boolean;
    blnExiPedRetiraExpAntFat: Boolean;
    blnPermiteExpParcial: Boolean;
    blnSepPorArmazem: Boolean;
    blnReposicao: Boolean;
    blnAutSer: Boolean;
    blnUsaImpressaoSeparacaoPorLocal: Boolean;
    blnFaturarExpedidos: Boolean;
    blnApenasFaturarJaExpedidos: Boolean;
    blnEhUmaExpedicaoParcialOuTemPedidosFaturadosParcialmente: Boolean;
    blnMaisDeUmPedidoDoMesmoClienteComAdiantamento : Boolean;
    blnFaturarAposExpedirTodosOsItens : Boolean;
    blnGravouNumerosSeries : Boolean;
    blnExpedicaoDocumentoFaturadoAutomaticamente: Boolean;
    blnOndaSeparacao: Boolean;
    TipoItemDoPedidoOndaSeparacao: TTipoItemDoPedidoExp;
    blnFaturandoTodosAutomaticamente: Boolean;
    strCodBarrasExp: String;
    blnExpAut: Boolean;
    blnBaiEntFut: Boolean;
    blnExpedicaoDePedidoDeConsignacao: Boolean;
    blnFreteRateado: Boolean;
    blnDescontoComercialZonaFranca: Boolean;
    strPesoPedido: String;
    strBotaoAcionado: String;
    strSeparador: String;
    strCfgENFUOP: String;
    strRegimeEspecial: String;
    blnDesmembraPedRegEsp: Boolean;
    strEmpresaSolicitanteAbastecimentoDeposito: String;
    blnAbastecimentoDeposito: Boolean;
    blnColetor: Boolean;
    blnSimplesRemessaConcreto: Boolean;
    blnApenasConferenciaProdutosRetiraCaixa: Boolean;
    blnExpParcialTipExp4 : Boolean;
    blnControlePorArmazem: Boolean;
    blnTemPedidoComDAV: Boolean;
    blnPermitiuLiberouExpedirQuantidadeDiferenteSeparadaWMS: Boolean;
    blnUsaRotinaWMS: Boolean;
    strCodTraSel: String;
    strConPagSel: String;
    strForPagSel: String;
    strCodCndSel: String;
    blnCodTraDif: Boolean;
    blnConPagDif: Boolean;
    blnForPagDif: Boolean;
    blnCodCndDif: Boolean;
    objResolveConflitosPedido: IResolveConflitosPedido;
    blnFatAut: Boolean;
    blnPermiteExpedirPedidoAVistaCaixaFechado: Boolean;
    blnExibirRetiraEntregaPedidosTransfFaturamentoAntExp: Boolean;
  end;

Type
  TParametrosEnvio = Record
    strDestinatario      : String;
    strEmailDestinatario : String;
    strTipExp            : String;
    strModo              : String;
    strOrdem             : String;
    strNomEmp            : String;
    strMessages          : String;
    strArqHtml           : String;
    strDocumentos        : string;
    strNumOse            : String;
    arrArquivos          : TStringArray;
    arrDestinatarios     : TStringArray;
    blnCabCD             : Boolean;
    blnLocFis            : Boolean;
    opcComSemPreco       : TImpressaoComSemPrecoOrPd;
    blnComMar            : Boolean;
    blnAnexar            : Boolean;
    blnShowMessages      : Boolean;
    blnShowDialog        : Boolean;
    blnEnviar            : Boolean;
    blnVariosDocumentos  : Boolean;

    QRCodePix,
    LinkCitel: String;
  End;

Type
  IFechamentoVendaObserver = Interface
  ['{32F5B0EA-ADF0-47BF-A2BD-31A035740BB1}']
    procedure NotificarProgressoFechamento(AInformacao: String; AMax, AProgress: Double);
  end;

Type
  IFechamentoVendaSubject = interface
  ['{A8D11D74-BCED-4131-8932-9ECD698B596A}']
    procedure AddFechamentoVendaObserver(AObserver: IFechamentoVendaObserver);
    procedure RemoveFechamentoVendaObserver(AObserver: IFechamentoVendaObserver);
    procedure NotificarFechamentoVendaObservers;
  end;

Type
  TOrdArrIte = (tOrdIntAutInc, tOrdStrSeqDet, tOrdIncSeqInc);

{*****************************************}
{* ESTRUTURA QUE REPRESENTA UMA OPÇÃO DE *}
{* FATURAMENTO                           *}
{**************************************MV*}
Type
  TOpcoesFaturamento = Record
    strDesCri: String;
    strEspDoc: String;
    strOpcLet: String;
    strMosMen: String;
  End;

  TOpcoesFaturamentoArray = Array Of TOpcoesFaturamento;

  TVariaveisFechamentoVenda = class(TInterfacedObject, IInterface)
  public
    strMsgInt,
    strCndAtu: String;

    fltTotAnt: Double;
    blnTemTro: Boolean;

    fltDesMinConf: Double;

    fltDesEspTmp: Double;
    fltDesAceAnt: Double;

    fltDescontosCliente: Double;

    fltTotMod: Double;

    strEspecie: String;
    blnAchou: Boolean;

    intPosAtual: Integer;

    arrDatas: TDateArray;
    blnMostraDesconto: Boolean;
    strSQL: String;
    fltSerAnt: Double;
    arrMenSag: TStringArray;

    blnMostraDigDuplic: Boolean;

    blnMosSer: Boolean;
    blnTraOrc: Boolean; // trava para somente orçamento

    qryGenDiv: TUniQuery;

    strNTrava: String;
    strOperador: String;

    strItensTravarIF: String;
    arrOpcoes: TOpcoesFaturamentoArray;
    strConfirma: String;
    strCndTmp: String;

    arrCarFin: TCartoesResumoCaixaArray;
    intIndice: Integer;

    strInformacao: String;

    strTemp: String;
    fltTotTrava : Double;

    blnApenasServico: Boolean;

    strTmpTipFat : String;

    strAuxTipFre : String;
    strNumOrcRef : String;
    strEmpOrcRef : String;

    fltParMin : Double;
    intCont: Integer;

    blnSecol : Boolean;
    strPedAbe: String;
    blnUsaCndVenFinal: Boolean;
    fltTotSerAux: Double;

    dtaCaiAbe: TDateTime;
    fltSalFec: Double;
    dtaDtaFec: TDateTime;
    Comanda: TComanda;
    strMsgDiasPermitidos : String;
    stlMsgDiasPermitidos : TStringList;
    stlAlteracoesDocumento : TStrings;

    strNumSerExp: string;
    strCodIteExp: string;
  end;

type
  TRegravarLotesPedidoWMS = class
  private
    FLotDor: TUniClientDataSet;
    procedure pCarregarLotDor(ANumDoc, AEspDoc, ACodEmp: String);
  public
    constructor Create(ANumDoc, AEspDoc, ACodEmp: String);
    destructor Destroy; override;
    procedure pRegravarLotesItem(AIdAnterior, AIdNovo: String);
  end;

type
  TRecInfUltimoCalculoTotal = record
    strCodCnd: String;
    strConPag: String;
    strCodFpg: String;
    fltValFre: Double;
    fltDesAce: Double;
    fltTotBom: Double;
    strTipOpe: String;
    strTipPed: String;
    blnZerTax: Boolean;
    strUfTrib: String;
  end;

type
  TRecBackupValMat = record
    fltDesEsp : Double;
    fltDesAce : Double;
    fltValFre : Double;
    fltFreRat : Double;
    fltFreSug : Double;
    fltFreCot : Double;
    fltTaxEnt : Double;
  end;

Type
  TFdoSeqGerServicos = record
    strLisCodIteSer: String;
    strLisFdoSeqGer: String;
  End;

Type
  TFinalidadeDocumento = (tfdNotaFiscal, tfdCupomFiscal);

Type
  TAnalisePromocComDesEsp = (tapcdePromocaoCorrente, tapcdeOlhandoTodosItens);

Type
  TOpcaoAbastecimentoItem = (oaSolicitTransf, oaReqCompra, oaEstoque, oaTodos);
  TOpcaoExibirTelaAbastecimento = (oeNaoExibir, oeExibirSempre, oeExibirSeTranfOuCompra);

Type
  TEntFut = record
    strNumDoc : String;
    strEspDoc : String;
    strCodemp : String;
    strCodIte : String;
    strCodAca : String;
    strEmpAca : String;
    fltUnitar : Double;
    fltQtdIte : Double;
    fltQtdUti : Double;
  End;

  TArrCodEmpML = Array Of String;
  TArrQtdIteML = Array of Double;
  TArrLotAbaML = Array Of String;
  TArrChaveNFReferenciaDocumentos = Array of String;

Type
  TRecTotaisMargemLucro = Record
    strTemItensVenda: String;
    fltTotUnitar: Double;
    fltTotCusto: Double;
    fltTotMedio: Double;
    fltTotCusImp: Double;
    fltTotMarPrat: Double;
    fltTotMrPrBr: Double;
    fltTotMarItem: Double;
    fltTotMarMedio: Double;
    fltTotMePrBr: Double;
    fltTotMarImpUlt: Double;
    fltTotUniOri: Double;
    fltTotQtdIte : Double;
    fltTotMarIde : Double;
    fltTotPreIde : Double;
    fltTotMCat17 : Double;
    blnSomenteItemEntrada: Boolean;
    fltTotMarPratSemDesOpe: Double;
    fltTotCusReaMZr: Double;
    fltTotCusIte : Double;
    fltTotPreUlt : Double;
    fltTotMedLiq : Double;
    fltTotImpUlt : Double;
    fltTotPreUltLiq : Double;
    fltTotVCat17 : Double;
    fltTotMarPra_PRECUS : Double;
    fltTotMrPrBr_PRECUS : Double;
    fltTotMarPro_PRECUS : Double;
    fltTotMarBru_PREMED : Double;
    fltTotMePrBr_PREMED : Double;
    fltTotMarLiq_PREMED : Double;
    fltTotMarBru_IMPULT : Double;
    fltTotMarLiq_IMPULT : Double;
    fltTotMarBru_PREULT : Double;
    fltTotMarLiq_PREULT : Double;
    fltTotMarPra_CUSITE : Double;
    fltTotMarPro_CUSITE : Double;
    fltTotMarLiq_PREIDE : Double;
    fltTotMarLiq_CAT_17 : Double;
    fltTotCusto2: Double;
    fltTotPreTab: Double;
    fltTotPreOri: Double;
    fltTotUniDig: Double;
    fltTotalTravaMinima: Double;
    fltMargemDoCadastro: Double;
  End;

{*********************************************}
{* RATEIO DO DESCONTO DA CONFIRMAÇÃO DE DOCS *}
{******************************************AF*}
Type
  TDesCffGer = Record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    fltValCff: Double;
  End;

Type
  TDesCffDet = Record
    intIncMat: Integer;
    strCodIte: String;
    strSeqDet: String;
    fltValCff: Double;
  End;

Type
  TCodFiscais = Record
    strCodFis: String;
    fltTotIte: Double;
  End;


Type
  TResCfop = Record
    strClaFis: String;
    fltTotBas: Double;
    fltTotVal: Double;
    fltTotPro: Double;
  End;

{*****************************************}
{* NUMEROS DO PEDIDO DE COMPRA DIGITADOS *}
{* NO FATURAMENTO                        *}
{**************************************RN*}
Type
  TNumPedCmp = record
    NumCmp : String[15];
    DtaCmp : TDateTime;
  End;

Type
  TDadosDocDev = Record
    blnUsa: Boolean;
    strNumDoc : String;
    strEspDoc : String;
    strCodEmp : String;
    strAutInc : String;
  End;

Type
  TNumerosPedidoCompras = Array of TNumPedCmp;

Type
  TResumoAliquota = Record
    strComLub: String;
    fltAlqIcm: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
    fltTotIte: Double;
    fltBasIpi: Double;
    fltValIpi: Double;
    fltDesAce: Double;
  End;

Type
  TResumoIcmAnt = Record
    fltAlqIcm: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
  End;

{**************************************************}
{* REGISTRO REFERENTE AOS CAMPOS DAS TINTAS       *}
{***********************************************PH*}
Type
  TForTin = Record
    strTipCor: String;
    strTextBase: String;
    intModDil: Integer;
    blnTemSaldoVenda: Boolean;
    fltQtdMaximoBase: Double;
    Formulas: TClassMatrizSaldosColorantes;
    strCompB: String; //Complmento da Base
    strUniver: String;
    strCatali: String;
  End;

{********************************************************************************}
{* REGISTRO REFERENTE AS INFORMACOES DAS TINTAS AUTOMOTIVA PARA O TABLET APENAS *}
{*****************************************************************************AC*}
Type
  TInfAut = Record
    strTipPre: String;
    fltVolume: Double;
    strTipCor: String;
    strCodDil: String;
    fltPorDil: Double;
    strCodEmb: String;
    fltPreEmb: Double;
    strTipEmb: String;
    strLinha_: String;
    fltQtdEmb: Double;
    fltPrcTin: Double;
  End;

{*****************************************}
{* ESTRUTURA QUE REPRESENTA UM REGISTRO  *}
{* DA TEMPORARIA DE ITENS                *}
{**************************************MV*}

Type
  TInfoTravaUnitario = class
  public
    strOpcTrvUnit: String;     // Em qual trava da função "fValidaUnitario" ele travou? (VECUS, PRMIN);
    strLibUniComSenha: String; // Unitário foi liberado mediante senha?
    fltUniLiqCal: Double;      // Unitário cálculado da trava;
    fltMargMin: Double;        // Margem mínima cálculada da trava;
    fltMargPra: Double;        // Margem praticada da trava;
    blnNvl2: Boolean;          // Nível de Trava 2
    blnNvl3: Boolean;          // Nível de Trava 3
    blnNvl4: Boolean;          // Nível de Trava 4
    blnNvl5: Boolean;          // Nível de Trava 5
    blnNvl6: Boolean;          // Nível de Trava 6
    fltPreMin: Variant;        // Preço Mínimo
  End;

  TRecMeiaNota = Record
    strEmpDoc: String;
    strEspDoc: String;
    strNumDoc: String;
  End;

  TArrMeiaNota = Array of TRecMeiaNota;

  TCalcFlex = Record
    strAutInc : String;
    strCodIte : String;
    strDebCre : String;
    fltValFle : Double;
    fltUniPra : Double;
    fltUniMax : Double;
    fltValDif : Double;
    fltTotIte : Double;
    fltDesEsp : Double;
    fltQtdIte : Double;
    fltUniOri : Double;
    fltDesMax : Double;
  End;

  TrecFCP = record
    fltBase     : double;
    fltValor    : double;
    fltAliquota : double;
  end;

  TDigImp = class
  public
    stlValores_Alterados: TStringList;

    blnOperadorDigitouImpostos : Boolean;

    procedure pLimpar;

    function fGravarDIGIMP(strSeqGer : String) : Boolean;
    function fGravarNOTIMP(strSeqGer : String) : Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

  TChaveReferenciada = Record
    strChvRef: String;
  end;

  { Valores da tabela REF (MOVREF/NOTREF) de um item gravados pelo Delphi, e nao
    pela trigger (documento com chave na NFEIMP). Campos = colunas REF_*. }
  TRefTribValoresGravacao = Record
    blnPreenchido : Boolean;
    strCodCst     : String;
    strClaTri     : String;
    fltValOpe     : Double;
    fltBasCal     : Double;
    fltCbsAlq     : Double;
    fltCbsAld     : Double;
    fltCbsVld     : Double;
    fltCbsAlr     : Double;
    fltCbsVlt     : Double;
    fltCbsAle     : Double;
    fltCbsVal     : Double;
    fltIbsUfa     : Double;
    fltIbsUfd     : Double;
    fltIbsUvd     : Double;
    fltIbsUfr     : Double;
    fltIbsUft     : Double;
    fltIbsUfe     : Double;
    fltIbsUfv     : Double;
    fltIbsMna     : Double;
    fltIbsMnd     : Double;
    fltIbsMvd     : Double;
    fltIbsMnr     : Double;
    fltIbsMnt     : Double;
    fltIbsMne     : Double;
    fltIbsMnv     : Double;
    strSelCst     : String;
    strSelCla     : String;
    fltSelBas     : Double;
    fltSelAlq     : Double;
    fltSelVal     : Double;
    strTriReg     : String;
    fltValIbs     : Double;
    strCstReg     : String;
    strClaReg     : String;
    fltAiuReg     : Double;
    fltTiuReg     : Double;
    fltAimReg     : Double;
    fltTimReg     : Double;
    fltCbsReg     : Double;
    fltTcbReg     : Double;
    strCrePre     : String;
    strMonofa     : String;
    strSeqOrigem  : String; // retorno de consignacao: SEQGER do envio de onde vem o perfil
  End;

  TDadosFechamento = Record
  private
    FClaFis: String;
    FBasIcm: Double;
    procedure pSetClaFis(Value: String);
    procedure pSetBasIcm(VAlue: Double);
  public
    function GetBasFcp: Double;
    function GetAlqFcp: Double;
    function GetValFcp: Double;
    function GetBasFcpST: Double;
    function GetAlqFcpST: Double;
    function GetValFcpST: Double;
  public
    strAutIncAnt: String;
    strTabelaOri: String;
    strCodIte: String; //
    strCodGru: String; //
    strCodMar: String; //
    strDesIte: String; //
    strDesFab: String; //
    strCodFab: String; //
    strDesOri: String; //
    strRefere: String; //
    strCodUni: String; //
    strUnidad: String; //
    strSigUni: String; //        
    strCodFor: String; //
    strComLub: String; //
    strIdePro: String; //
    strIncPis: String; //
    strCodRot: String; // Codigo da Rota de entrega
    fltIpiSai: Double; //
    fltUniTar: Double; //
    fltUniOri: Double; //Preco sugestao
    fltUniVis: Double; //Preco sugestao sem juros
    fltTaxJur: Double; //Taxa de juros aplicada no preco do produto
    fltUniTmp: Double; //
    fltQtdRco: Double; //Quantidade comprar req compra
    strObsRco: String;
    fltQtdOri: Double; //    
    fltQtdIte: Double; //
    fltTotIte: Double; //
    fltBasOrg: Double; //
    fltIcmOrg: Double; //
    fltDesOrg: Double; //
    strEntSai: String; //
    fltPreCus: Double; // PODE TER IMPOSTOS OU NAO DEPENDE DA CONFIGURACAO
    fltCusIte: Double; // SEMPRE O PREÇO DE CUSTO DA CADASTRO SEM IMPOSTOS - SOMENTE ITEGER.ITE_PRECUS
    fltPreCu2: Double; // PODE TER IMPOSTOS OU NAO DEPENDE DA CONFIGURACAO
    fltTotCus: Double; //
    fltTotCu2: Double; //
    fltDesCon: Double; //
    fltDesEsp: Double; //
    fltDesAce: Double; //
    fltValFre: Double; //
    fltValSeg: Double; //
    fltFreSug: Double; //
    fltFreRat: Double; //
    fltTaxEnt: Double; //Taxa de entrega
    fltPreMed: Double; //
    fltTotMed: Double; //
    fltTotUlt: Double; //
    fltImpUlt: Double; //
    fltTotImp: Double;
    fltAlqIpi: Double; //
    fltValipi: Double; //
    fltBasIpi: Double; //
    strCodFis: String; //
    strCstAnt: String; //
    strFisAnt: String; //
    strCodMen: String; //
    fltPerBas: Double; //
    fltPeBaST: Double; //
    fltIVA_ST: Double; //
    fltValIva: Double; //
    strCodSit: String; //
    strAlqIte: String; //
    fltAlqIcm: Double; //

    fltValIcm: Double; //
    strCodAbf: String; //
    strIteAbf: String; //
    fltAlqOrS: Double; //
    fltAlq__S: Double; //
    fltBas__S: Double; //
    fltBasSTS: Double; //
    strMen__S: String; //
    fltAlq__E: Double; //
    fltAlIStS: Double; //
    fltValRet: Double; //
    fltBasRet: Double; //
    fltAlqRet: Double; //
    fltPerRed: Double; //

    fltImpPag: Double; //    
    fltPeImPg: Double; //            
    fltFedImp: Double; //
    fltPeImFd: Double; //
    fltEstImp: Double; //
    fltPeImEs: Double; //
    fltMunImp: Double; //
    fltPeImMn: Double; //

    fltComInt: Double; //
    fltComExt: Double; //
    fltComDis: Double;
    fltComDig: Double;

    fltPesoIt: Double; //
    fltPesLiq: Double; //

    fltPesoItCalc: Double;  // ARMAZENA O CALCULO DO PESO BRUTO
    fltPesLiqCalc: Double;  // ARMAZENA O CALCUYLO DO PESO LÍQUIDO

    fltPesoItOri: Double;  // ARMAZENA O CALCULO DO PESO BRUTO BASEADO NO CADASTRO DO PRODUTO
    fltPesLiqOri: Double;  // ARMAZENA O CALCULO DO PESO LÍQUIDO BASEADO NO CADASTRO DO PRODUTO

    fltPesoItCad: Double;  // ARMAZENA O PESO BRUTO BASEADO NO CADASTRO DO PRODUTO
    fltPesLiqCad: Double;  // ARMAZENA O PESO LÍQUIDO BASEADO NO CADASTRO DO PRODUTO

    blnEdiPes    : Boolean; // CONTROLA SE EDITOU O PESO

    dtaEmiDev: TDate;  //
    strCndDev: String; //
    strCCndDv: String; //
    strDocDev: String; //
    strEspDev: String; //
    strEmpDev: String; //
    strDivDev: String; //
    strAiDvOr: String; //
    strClaIpi: String; //
    strNcmTin: String; //        
    strLetIpi: String; //
    strIteCha: String; //
    strIteTin: String; //
    strDesCor: String; //
    fltQtdEmb: Double; //
    fltPreEmb: Double; //
    fltUniEmb: Double; //
    strTipEmb: String; //
    strTipPre: String; //
    fltPrvTin: Double; //
    fltPrcTin: Double; //
    fltFatTin: Double; //
    strProEmb: String; //
    intLazQua: Integer;//
    strMontad: String; //
    strA_n_o_: String; //
    fltComFor: Double; //
    strIteEmb: String; //
    strPromoc: String; //
    strCodPro: String; // Código da Promoção
    strRecPro: String;
    fltProCus: Double; //
    fltProVen: Double; //
    fltProCva: Double; //
    fltProCAt: Double; //
    fltProCdi: Double;    
    intAutInc: Integer; //
    strTipTin: String; //
    fltGPeCom: Double; //
    intSeqInd: Integer; //

    strNumOrc: String; //
    strEspOrc: String; //
    strEmpOrc: String; //

    blnJaFatu: Boolean;
    strTipFat: String;
    strNumFat: String;
    strEmpFat: String;
    strVenFat: String;
    strCndFat: String;
    fltValFat: Double;
    dtaDtaFat: TDateTime;
    fltQtdBai: Double;

    blnEntpCD: Boolean; //

    fltAlqAnt: Double; //
    fltIcmAnt: Double; //
    fltBIcAnt: Double; //
    fltComDev: Double; //
    fltCoDvRp: Double; //
    fltDesDev: Double; //
    fltFreDev: Double; //
    fltDeADev: Double; //

    strSeqDet: String; //
    fltDesCff: Double; //
    strLinTin: String; //
    strCatali: String; //
    strDesNes: String; //
    strSemEst: String; //
    strLibEst: String; //Liberou sem estoque mediante senha
    fltUniDig: Double; //
    fltQtdPon: Double; //

    strComple: String; //
    fltVolPro: Double; //
    strChaFor: String; //
    strCodAca: String; //
    strEmpAca: String; //
    blnProAca: Boolean; //

    strEmpFut: String; //
    strDocFut: String; //
    strEspFut: String; //
    strIncFut: String; //

    strSepExp: String; //

    strTipBus: String; //

    fltOutVal: Double; //OUTROS VALORES COMO POR EXEMPLO BOCA DE CAIXA
    fltComTbl: Double; // (%) COMISSAO DA TABELA DE PRECO

    fltImpFed: Double; //
    fltDesOpe: Double; //
    fltICMSai: Double; //

    strCodAcaOr: String; //
    strEmpAcaOr: String; //

    strDocCnf: String;
    strEspCnf: String;
    strEmpCnf: String;

    strEntRet: String;//(E)ntrega ou (R)etira
    strLocRet: String;//(C)aixa ou (E)xpedicao

    strTabPre: String;
    strEntFut: String;
    strMotFut: String;
    strCliBus: String;
    strTurEnt: String;    
    strImpDir: String;

    dtaDtEntr: TDateTime; //Data da Entrega. Seja imediata ou futura
    intQdeNtr: Integer;   //Quantidade de dias para entrega
    strCodVenD: String;

    fltIpiEnt: Double;
    fltFreEnt: Double;

    strAutIncTdt: String; //

    strCodDil: String;
    fltPorDil: Double;
    strPorPer: String;
    strDilCon: String;
    fltPorCat: Double;

    fltSaldos: Double;
    strEmpSol: String;
    fltQtdSol: Double;
    strLotAba: String;

    fltQtdExp: Double;

    strNumCmp: String; //Nfe xPed Numero do Pedido de Compra
    intNItCmp: Integer;//Nfe nItemPed nº do item do Pedido de Compra
    DtaDtaCmp: TDateTime;//Data do Pedido de Compra

    fltUniIcm: Double;    

    // USADO SOMENTE NA BAIXA DE ENTREGA FUTURA
    // ENDERECO ORIGINAL DE ENTREGA DO ITEM PARA GRAVAR LOG DE ALTERACAO
    strEntGer: String;

    fltBasIcmImp: Double;
    fltAlqIcmImp: Double;
    fltValIcmImp: Double;

    fltBasIpiImp: Double;
    fltAlqIpiImp: Double;
    fltValIpiImp: Double;

    fltBasRetImp: Double;
    fltValRetImp: Double;

    fltPreTab: Double;
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
    recForTin: TForTin;

    strKey_EP,
    strLotAnt,
    strNumLot: String;
    strEmpPrd: String;

    fltBaRtSp: Double;
    fltVaRtSp: Double;
    fltIcOpPr: Double;

    strVenCnf: String; //
    strOrdPro: String; // ORDEM DE PRODUCAO
    blnGerOrd: Boolean;// GEROU ORDEM DE PRODUCAO
    strBxSbIt: String; // BAIXA DE SUB.ITEM ESTRUTURA

    strPigBas: String; // DEVOLUCAO - ENTRADA NO ESTOQUE POR PIGMENTO BASE
    strIdeDev: String; // IDEPRO DA DEVOLUCAO
    strITinDv: String; // ITETIN DA DEVOLUÇÃO
    fltQtdDet: Double; // QUANTIDADE ORIGINAL VENDIDA
    strTabDev: String; // TABELA DO ITEM DEVOLVIDO

    stlDetMLs: TStringList;
    strCodBar: String;

    strTipFin: String; //  Tipo de Desconto financeiro (Somente para Confirmacao de Pedidos)
    fltDesFin: Double; //  Valor do Desconto financeiro (Somente para Confirmacao de Pedidos)

    strMenFis: String;

    fltPreLot: Double; // Preço do Lote
    fltCusLot: Double; // Preço do Lote

    fltEmbala: Double; //Embalagem do cadastro do Produto

    strEmpIte: String;  // Empresa por item

    strBrinde: String; // BRINDE (S)IM OU (N)AO
    strCodPar: String; // PARCEIRO
    strTipBri: String; // TIPO DE BRINDE
    strCodCmg: String; // Código da Campanha de Vendas

    strNum_Di: String;
    dtaDta_Di: TDateTime;
    strLcDese: String;
    strUfDese: String;
    dtaDtDese: TDateTime;

    strVTrInt: String;//VIA DE TRANSPORTE INTERNACIONAL
    fltVAfrMM: Double;//VALOR DA AFRMM
    strForImp: String;//FORMA DE IMPORTAÇÃO QUANTO A INTERMEDIAÇÃO
    strCgcAdq: String;//CNPJ DO ADQUIRENTE OU DO ENCOMENDANTE
    strUf_Adq: String;//SIGLA UF DO ADQUIRENTE OU DO ENCOMENDANTE
    strCForDi: String;

    fltBaseII: Double;
    fltDesAdu: Double;
    fltVal_II: Double;
    fltValIof: Double;
    fltImpTax: Double;

    fltFatAce: Double;
    blnPodAlt: Boolean;

    fltBasIpr: Double;

    opcINFesp: TopcItensNFespTinta;

    recMadeira: TDadosMadeira;

    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;
    strCSTPis: String;
    strNatPis: String;

    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;
    strCSTCof: String;
    strNatCof: String;    

    strNotEsp: String;
    strIteFra: String;

    strIteFla: String;
    strPrdGru: String;
    strUsaBon: String;

    fltOutIcm: Double;
    fltIseIcm: Double;
    fltVlrCon: Double;

    strSeqGad: String; // CHAVE DOS ITENS DA GARANTIA (ENVIO PARA FORNECEDOR)

    strBarEmb: String; //Codigo de barras da Embalagem CFG_PRVEMB
    strCodMec: String; //Codigos dos Mecanicos do Produto

    strSeqRcd: String; //Autoincremento do item na requisicao de compra

    strRICMPR: String; //Item possui Reducao Icms conf. RICMPR (S/N)
    fltPerRic: Double; //Percentual de Redução Imcs conf. RICMPR (S/N)

    fltComLiq: Double; //Preco de compra Liquido (Preco compra menos descontos do fornecedor)

    strCSTIpi: String;
    strEnqIpi: String;
    fltDeDVCf: Double; // Desconto da devolução na confirmação de documento
    strIncDev: String;//Autoincrem da devolucao
    intSeqInc: Integer;
    intOrdIte: Integer;

    strIteEst: String;  //Codigo do item estrutura
    intSeqEst: Integer; //Sequencial de inclusao do item estrutura (usado para agrupar os itens)
    fltUniEst: Double;  //Unitario item estrutura
    fltQtdSbi: Double;  //quantidade do subitem dentro da estrutura
    fltUniSbi: Double;  //unitario do subitem dentro da estrutura

    strCodVen: String; //Vendedor do Produto (Autcenter)
    strCodVe2: String; //Vendedor2 do Produto (Autcenter)
    strAltPCo: String; //Alterou o percentual de comissão do vendedor (CFG_ALTPCO)
    fltPerCom: Double; //Percentual de comissão do vendedor (CFG_ALTPCO)

    strExcIpi: String;
    fltTotCom: Double; //Total de comissão que é cálculado para exibição! Não utiliza na gravação!

    strAltera: String; //Usado somente para PD/OR sendo alterado
    strInsere: String; //Usado somente para PD/OR sendo alterado

    fltBasComPro: Double; // Base de cálculo da Comissão do Profisional (MOVCPR)
    fltVlrComPro: Double; // Valor de Comissão do Profisional (MOVCPR)
    fltPerComPro: Double; // Percentual de Comissão do Profisional (MOVCPR)

    fltVal_RT: Double; //Valor do RT (Comissao do profissional - Cofert)
    fltRT_Ori: Double; //Valor do RT (Comissao do profissional - Cofert)

    strAutIncDet: String; // Salva o AUTOINCREM no MOVDET/X para gravação na tabela MOVCPR

    intSeqCcr: Integer; // Sequencial de Venda de Concreto

    fltDopTin: Double; // Despesa Operacional da tinta(Cada tinta terá uma configurada no auttin)

    fltFatRat: Double; // Fator de Rateio do Valor do Serviço baseado no Valor dos Itens
    fltSerRat: Double; // Valor Unitário do Serviço Rateado nos Itens

    strProBri: String; //Codigo da promocao de Brindes por produto Vendido
    fltPonBri: Double; //Quantidade de pontos gerado nesta venda para direito a brinde
    strSeqOpI: String; // Sequencial da ordem de produção que foi gerada para atender esse item.
    strRatDes: String; //Entrará no rateio do desconto (Default = 'S')

    fltValDif: Double; // Diferença do total de diferimento
    fltPerDif: Double;

    blnMeiaNotaFatorExpedicao: Boolean;

    strSeqGer: String;

    strBaqtze: String; //essa variável guarda a base automotiva com quantidade zerada, e que foi liberada a sua venda atraves de senha;
    strPegou_: String;
    strBasTro: String;
    fltMaxPed: Double;

    fltDesEspExp: Double;
    fltPorDesExp: Double;
    fltDesCndExp: Double;

    fltValFreExp: Double;
    fltDesAceExp: Double;

    fltVrdIcm: Double;
    fltBasVrd: Double;
    strMtdIcm: String;
    strMtdIcmOri: String;
    strAtivac: String;
    intSeqCom: Integer;
    fltQtdAti: Double;
    fltQtdCom: Double;
    strTabCom: String;

    recDifalFCP: TRecDifalFCP;

    fltIcmsDifalOrigem: Double;
    fltIcmsDifalDestino: Double;

    strComPro: String;
    strObsCol: String;   // Observação do Colorista no formulário de seleção de embalagens das tintas automotivas
    intTipFor: Integer;  // tipo de formulação (0: Fórmula Original / 1: Fórmula Ajustada)
    blnExp_CX: Boolean;  // Indica que o item na expedição esta dentro de uma caixa.
    opcTipAbs: TOpcaoAbastecimentoItem;

    strAutoincrementoGravacao: String; //autoincremento para gravacao do FATDOR/MOVDET
    strAutoincrementoDaLogDor: String; //autoincremento para gravacao da LOGDOR
    strAutoincrementoGravacaoNotDet: String; //autoincremento gravado na NOTDET (conferencia da NOTREF)
    fltIcmPav: Double;
    blnIcmSai: Boolean;
    fltDesF07: Double;

    blnSelAbs: Boolean; //Define se foi selecionado na tela de abastecimento
    blnFatPar: Boolean; //Define se foi selecionado Fat. Parcial na tela de abastecimento
    strIndRev: String;  //Industrialização ou revenda

    strDadosSeparadorWms : String; //Dado dos separadores quando WMS com coletor de dados, pois mais de 1 separador por separar a mesma mercadoria. essa informaçao será gravada na DETSEP

    intAdicao: Integer;

    fltPreUlt: Double;

    strProEsp: String;

    strNotUlt: String;
    fltPICMEF: Double;
    fltBICMEF: Double;
    fltAICMEF: Double;
    fltVICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;
    fltSICMEF: Double;
    strNotC17: String;
    fltTotGerIteParaCalcIcmEfetivo: Double;
    fltAlqIcmIntParaCalcIcmEfetivo: Double;
    fltQtdSep: Double;
    strOpBxSe: String;
    dtaDtBxSe: TDateTime;
    dtaHrBxSe: TDateTime;
    fltDesCnd: Double; // armazena o desconto abatido automaticamente pela condição de pagamento;
//    strTipoTinta: String;

    fltBaseOperacaoPropriaICMSEntrada     : Double;
    fltAliquotaOperacaoPropriaICMSEntrada : Double;
    fltValorOperacaoPropriaIMCSEntrada    : Double;

    {
    [Atenção]:
    Os campos "VisualizarFcpIcms" e "VisualizarFcpIcmsST",
    são utilizados apenas para visualização na tela de dados fiscais.}
    VisualizarFcpIcms   : TrecFCP;
    VisualizarFcpIcmsST : TrecFCP;
    strExibSE: string;

    fltFreMkp: Double;
    fltComMkp: Double;

    EspelhoFcpIcms   : TrecFCP;
    EspelhoFcpIcmsST : TrecFCP;

    strAIdKitPromocao : String;
    fltPerDesEmbFec: Double;
    strFdoIteRecalcPrecos: String;
    strChaveAcesso: string;
    fltQtItCo: Double;
    fltDesBai: Double;
    fltIpiCon: Double;
    fltValorCalculadoSTConsignacao,
    fltValorCalculadoFCPSTConsignacao : Double;
    fltFreCot: Double;
    strEmpCar: String; //empresa de carregamento do item
    strAutoinDevCar: String; //autoincrem da MOVDET devolução emp. carregamento
    strAutoincrementoGravacaoDifal: String;

    strEntFutDocOri: String;   //entrega futura documento de origem (usada na confirmação de documentos)
    fltValIpiEntFut: Double;   //variável auxiliar, quando CFG_ENFUOP = 2
    fltValRetEntFut: Double;   //variável auxiliar, quando CFG_ENFUOP = 2
    fltValFcpSTEntFut: Double; //variável auxiliar, quando CFG_ENFUOP = 2

    strOpSeEx,
    strConExp,
    strEmbExp,
    strObsExp: String;

    arrSeriesItem: TMatrizSeries;

    strChkOut: String;
    strNumCooSerCupom: String;
    blnAtoDeclaratorioDF: Boolean;
    strMovTriLocFis: String;

    fltVDesST: Double;
    strMDesST: String;
    strReserv: String;
    strAplica: String;
    intSeqInv: Integer;
    strSeqEql: String;

    fltOrgPubIcm: Double;
    fltOrgPubPis: Double;
    fltOrgPubCof: Double;

    fltOrgPubAlqIcm: Double;
    fltOrgPubAlqPis: Double;
    fltOrgPubAlqCof: Double;
  	strNumDrw: String; // NÚMERO DRAWBACK
    blnGarantiaReposicaoCliente: boolean;
    blnMntPrc: Boolean; //mantém o preço unitário
    fltDesEspZonFra: Double;

    strNumPla: String;
    strParNum: String;
    strReqCom: String;
    strRegEsp: String;

    fltQtdRet: Double;

    fltValRei: Double;

    blnGravaMovIcd: Boolean;
    blnAltEst: Boolean;
    intSeqPer: Integer;
    blnSTAtribuidaPorRegimeEspecial: Boolean;
    strCilVas: String;

    fltBasIcmBenST: Double; // Usado no cálculo do FCP-ST do beneficio de redução de base de ST

    blnRatEst: Boolean;
    strIncEsp: String;
    fltAlERet: Double;
    fltBaERet: Double;
    fltVaERet: Double;
    strUpseml: String;
    strEmpExp: String;

    blnSepExc: Boolean; //separação exclusiva

    strOpeSep: String;
    strOpeExp: String;

    recBackup: TRecBackupValMat;
    fltDesEspBaiFut: Double;

    fltCfbIpi: Double;
    fltCfaIpi: Double;
    fltCfvIpi: Double;
    strCipiOK: String;
    strDocIpi: String;
    strEspIpi: String;
    strEmpIpi: String;

    strUsaDce: Boolean;
    strClaDce: String;
    intSeqDocDsm: Integer;
    strLctBar: String;
    strSit_PC: String;
    fltPiiZfm: Double;
    strCodDig: String;
    fltOutValPD: Double;
    fltFreEntPD: Double;
    fltAcpProPD: Double;
    fltAcpTxcPD: Double;
    fltAcpVctPD: Double;
    fltAcpResPD: Double;
    fltAcpMarPD: Double;
    strTckQbt: String;
    strCbenef: string;
    strCodPre: string;
    fltBasPre: Double;
    fltPerPre: Double;
    fltValPre: Double;

    fltMarProCusIte: Double;
    fltMarPraCusIte: Double;
    fltMarIte: Double;
    fltMarLuc: Double;
    fltSomaColorantes : Double;
    strExiSim: String;
    fltVimRet: Double;
    fltFreRatOri: Double;

    blnUsaPPF: Boolean;
    strIdDest: String;
    fltIcmPrd: Double;
    strChvRef: String;
    strIteRef: String;
    fltDifalDev : Double;
    fltBimRet: Double;
    fltAimRet: Double;

    fltBasCBS: Double;
    fltValCBS: Double;
    fltAlqCBS: Double;
    fltBasIBS: Double;
    fltValIBS: Double;
    fltAlqIBS: Double;
    fltBas_IS: Double;
    fltVal_IS: Double;
    fltAlq_IS: Double;

    recRefGravacao: TRefTribValoresGravacao;

    property strClaFis: String Read FClaFis Write pSetClaFis;
    property fltBasIcm: Double REad FBasIcm Write pSetBasIcm;
  End;

  TMatrizFechamento = Array Of TDadosFechamento;
  TMatrizesFechamento = Array Of TMatrizFechamento;
  TMatrizCalcFlex = Array Of TCalcFlex;
  TMatrizChaveReferenciada = Array Of TChaveReferenciada;

  TCalculaImpostoItemSelecionado = record
    Unitario : Double;
    UnitarioLiquido : Double;
    Quantidade : Double;
    PercentualDesconto : Double;
    TotalDoItem : Double;
  End;

  TMatrizFechamentoHelper = Record Helper For TMatrizFechamento
    function fGetItemIndex(Const intAutInc: Integer): Integer;
  end;

  TDadosSepDor = record
  public
    strAutInc: String;
    strSeqFdo: String;
    fltQtdCon: Double;
    strOpeCon: String;
    strConFin: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
  end;

  TMatrizSepDor = Array Of TDadosSepDor;

  TDadosConDor = record
  public
    strAutInc: String;
    strSeqFdo: String;
    fltQtdCon: Double;
    strOpeCon: String;
    strNumFat: String;
    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;
  end;

  TMatrizConDor = Array Of TDadosConDor;

  TItemVendasPerdidas = class
    strAutoIncrem: String;
    strCodIte: String;
    strDesIte: String;
    fltQtdIte: Double;
    fltUniOri: Double;
    fltUnitar: Double;
    fltTotIte: Double;
    strCodMot: String;
    strObserv: String;
    strIteNov: String;
    strCodCon: String;
    fltVlrCon: Double;
    strNumCmp: String;
    intNItCmp: Integer;
    dtaDtaCmp: TDateTime;
  end;

  TMatrizCalcFlexObject = class(TInterfacedObject, IInterface)
  public
    FItems: TMatrizCalcFlex;
  public
    property Items: TMatrizCalcFlex read FItems write FItems;
  public
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TMatrizCalcFlexObject;
  end;

  TOrdenarItensParaGravacao = class
    private
      FMatrizOriginal: TMatrizFechamento;
      FMatrizOrdenada: TMatrizFechamento;
      function fBuscarItem(arrItens: TMatrizFechamento; intAutInc: Integer): TDadosFechamento;
    public
      procedure pSalvarOrdemMatrizItens(const arrMatrizItens: TMatrizFechamento);
      procedure pRestaurarOrdemMatrizItens(const arrMatrizItens: TMatrizFechamento);
      procedure pOrdenarItensPorCodigo(const arrMatrizItens: TMatrizFechamento);

      property arrMatrizItensOrdenados: TMatrizFechamento Read FMatrizOrdenada;
  end;

  TTipoListaModificacoes = (tlmCRMTexto, tlmCRMEmail, tlmMsgBloq);
  TOperacaoFaturamento = (ofBaixaDeEntregaFutura, ofIndefinido);

  IParametrosItensModificados = Interface
  ['{0CFCCBE8-2A47-431C-A9B1-2D41F3DF1A1B}']
    function NumDoc(Const Value: String): IParametrosItensModificados; Overload;
    function EspDoc(Const Value: String): IParametrosItensModificados; Overload;
    function CodEmp(Const Value: String): IParametrosItensModificados; Overload;
    function Values(Const Value: TVariantArray): IParametrosItensModificados; Overload;
    function Fields(Const Value: TStringArray): IParametrosItensModificados; Overload;
    function Labels(Const Value: TStringArray): IParametrosItensModificados; Overload;
    function MatItens(Const Value: TMatrizFechamento): IParametrosItensModificados; Overload;
    function Tipo(Const Value: TTipoListaModificacoes): IParametrosItensModificados; Overload;
    function ConsiderarUniDig(Const Value: Boolean): IParametrosItensModificados; Overload;
    function ImpRateadoDescOrgaoPublico(Const Value: Boolean): IParametrosItensModificados; Overload;

    function ItensVendaPerdida(Const Value: TObjectList<TItemVendasPerdidas>): IParametrosItensModificados; Overload;


    function NumDoc: String; Overload;
    function EspDoc: String; Overload;
    function CodEmp: String; Overload;
    function Values: TVariantArray; Overload;
    function Fields: TStringArray; Overload;
    function Labels: TStringArray; Overload;
    function MatItens: TMatrizFechamento; Overload;
    function Tipo: TTipoListaModificacoes; Overload;
    function ItensVendaPerdida : TObjectList<TItemVendasPerdidas>; Overload;
    function ConsiderarUniDig: Boolean; Overload;
    function ImpRateadoDescOrgaoPublico: Boolean; Overload;
  End;

  TParametrosItensModificados = Class(TInterfacedObject, IParametrosItensModificados)
  private
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FMatItens: TMatrizFechamento;
    FTipo: TTipoListaModificacoes;
    FFields: TStringArray;
    FValues: TVariantArray;
    FLabels: TStringArray;
    FItensVendaPerdida: TObjectList<TItemVendasPerdidas>;
    FConsiderarUniDig: Boolean;
    FImpRateadoDescOrgaoPublico: Boolean;

    constructor Create;
  public
    function NumDoc(Const Value: String): IParametrosItensModificados; Overload;
    function EspDoc(Const Value: String): IParametrosItensModificados; Overload;
    function CodEmp(Const Value: String): IParametrosItensModificados; Overload;
    function Fields(Const Value: TStringArray): IParametrosItensModificados; Overload;
    function Labels(Const Value: TStringArray): IParametrosItensModificados; Overload;
    function Values(Const Value: TVariantArray): IParametrosItensModificados; Overload;
    function MatItens(Const Value: TMatrizFechamento): IParametrosItensModificados; Overload;
    function Tipo(Const Value: TTipoListaModificacoes): IParametrosItensModificados; Overload;
    function ConsiderarUniDig(Const Value: Boolean): IParametrosItensModificados; Overload;
    function ImpRateadoDescOrgaoPublico(Const Value: Boolean): IParametrosItensModificados; Overload;

    function ItensVendaPerdida (Const Value: TObjectList<TItemVendasPerdidas>): IParametrosItensModificados; Overload;


    function NumDoc: String; Overload;
    function EspDoc: String; Overload;
    function CodEmp: String; Overload;
    function Labels: TStringArray; Overload;
    function Fields: TStringArray; Overload;
    function Values: TVariantArray; Overload;
    function MatItens: TMatrizFechamento; Overload;
    function Tipo: TTipoListaModificacoes; Overload;
    function ConsiderarUniDig: Boolean; Overload;
    function ImpRateadoDescOrgaoPublico: Boolean; Overload;

    function ItensVendaPerdida : TObjectList<TItemVendasPerdidas>; Overload;

    class function New: IParametrosItensModificados;
  End;

  IListarModificacoesItensPedido = Interface
  ['{CF8443FD-EF67-4A89-A3F9-5FCDCD4F50B2}']
    function fGetModificacoes: String;
  end;

  TListarModificacoesItensPedido = Class(TInterfacedObject, IListarModificacoesItensPedido)
  private
    FCdsItens: TUniClientDataSet;
    FParams: IParametrosItensModificados;
    procedure pCarregarItens;
  protected
    function fGetModificacoesBloq: String;
    function fGetModificacoesParaEmail: String;
    function fGetModificacoesParaMensagem: String;
    constructor Create(AParams: IParametrosItensModificados);
  public
    destructor Destroy; override;

    function fGetModificacoes: String;

    class function New(AParams: IParametrosItensModificados): IListarModificacoesItensPedido;
  end;

  TListarModificacoesPedido = Class(TInterfacedObject, IListarModificacoesItensPedido)
  private
    FCdsPedido: TUniClientDataSet;
    FParams: IParametrosItensModificados;
    procedure pCarregarDocumento;
  protected
    constructor Create(AParams: IParametrosItensModificados);
  public
    destructor Destroy; override;

    function fGetModificacoes: String;

    class function New(AParams: IParametrosItensModificados): IListarModificacoesItensPedido;
  end;

  IListarProdutosDevolvidos = interface
  ['{E18D88C6-8C6C-4CB7-9B52-34AB1B8F31D0}']
    function fGetProdutos: String;
  end;

  TListarProdutosDevolvidos = class(TInterfacedObject, IListarProdutosDevolvidos)
  private
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FSerie_: String;
    FCodCli: String;
  protected
    constructor Create(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
  public
    class function New(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String): IListarProdutosDevolvidos;
    function fGetProdutos: String;
  end;

  TDadosDuplicatas = Record
    strNumD01: String;            // Duplicata 01
    strNumD02: String;            // Duplicata 02
    strNumD03: String;            // Duplicata 03
    strNumD04: String;            // Duplicata 04
    strNumD05: String;            // Duplicata 05
    strNumD06: String;            // Duplicata 06
    strNumD07: String;            // Duplicata 07
    strNumD08: String;            // Duplicata 08
    strNumD09: String;            // Duplicata 09
    strNumD10: String;            // Duplicata 10
    strNumD11: String;            // Duplicata 11
    strNumD12: String;            // Duplicata 12

    strDtaV01: String;
    strDtaV02: String;
    strDtaV03: String;
    strDtaV04: String;
    strDtaV05: String;
    strDtaV06: String;
    strDtaV07: String;
    strDtaV08: String;
    strDtaV09: String;
    strDtaV10: String;
    strDtaV11: String;
    strDtaV12: String;

    fltValD01: Double;
    fltValD02: Double;
    fltValD03: Double;
    fltValD04: Double;
    fltValD05: Double;
    fltValD06: Double;
    fltValD07: Double;
    fltValD08: Double;
    fltValD09: Double;
    fltValD10: Double;
    fltValD11: Double;
    fltValD12: Double;
    fltValD13: Double;
    fltValD14: Double;
    fltValD15: Double;
    fltValD16: Double;
    fltValD17: Double;
    fltValD18: Double;
    fltValD19: Double;
    fltValD20: Double;
    fltValD21: Double;
    fltValD22: Double;
    fltValD23: Double;
    fltValD24: Double;
  end;

  {***************************************}
  {* VARIAVEIS QUE SERÃO UTILIZADAS PARA *}
  {* A GRAVAÇÃO DO RESUMO DE CAIXA       *}
  {************************************AF*}
  TDadosModalidades = record
    fltValCqP: Double;
    fltValCqV: Double;
    fltValDin: Double;
    fltValCar: Double;
    fltValOrd: Double;
    fltFatura: Double;
    fltValCre: Double;
    fltValVle: Double;
    fltValFin: Double;
    fltValAdt: Double; // Valor do Adiantamento (Já pago no pedido)
    fltBolAdt: Double; // Valor do boleto de Adiantamento
    blnResCaiAdt: Boolean;

    fltVlARec: Double; // Modalidade 015-A Receber
    blnBolVen: Boolean; // Boletos de adiantamento nos vencimentos da condicao de pagamento informada

    optTroco: TOperacaoTroco;    // CHEQUE A VISTA
    fltValorTroco: Double;       // CHEQUE A VISTA

    optTrocoPre: TOperacaoTroco; // CHEQUE PRÉ
    fltValorTrocoPre: Double;    // CHEQUE PRÉ

    optTrocoCar: TOperacaoTroco; // Cartao
    fltValorTrocoCar: Double;    // Cartao

    optTrocoDinheiro: TOperacaoTroco; // Dinheiro
    fltValorTrocoDinheiro: Double;    // Dinheiro

    fltCredUtilizados: Double; //Creditos utilizados
  End;

{*****************************************}
{* CLASSE PRINCIPAL PARA A VENDA         *}
{**************************************MV*}
Type
  TOnAdicionouItemDoPedido = procedure of Object;  

  // PARA EVITAR RELEITURA NO BANCO
  TDadosCliente = Record
    strCodCli: String;  // ULTIMO CLIENTE LIDO;
    strStaCli: String;  // STATUS DO CLIENTE

    strCliFil: String;  // ULTIMO CLIENTE LIDO;
    blnCliFil: Boolean; // EH CLIENTE FILIAL
    fltFat_TE: Double;  // FATOR TE (tributado)
    fltFatTE2: Double;  // FATOR TE (ST)
    strTEPREV: String;  // CÓDIGO DO TIPO DE TRANSFERENCIA DE PREÇO NÃO PROMOCIONAL[CUS, VE1, ETC..]
    strTEPPRO: String;  // CÓDIGO DO TIPO DE TRANSFERENCIA DE PREÇO PROMOCIONAL [CUS, VE1, ETC..]
  End;

  TRecIcmsImobilizado = Record
    intIndIte: Integer;
    blnInfVal: Boolean;
    fltBasIcm: Double;
    fltAlqIcm: Double;
  End;

  Type
    TTipoDeMovimento = (tmFaturamento, tmDevolucaoDefinitiva);

  TRecConsignacao = Record
    strNumDoc,
    strEspDoc,
    strCodIte,
    strCodEmp: String;
    fltQtdIte,
    fltDesEsp: Double;
    strCodAca: String;
    strAutInc: string;
    tmTipoDeMovimento : TTipoDeMovimento;
  End;

  TItemCalcMargem = class
    public
      ITE_CODITE,
      ITE_DESITE,
      ITE_IMPDIR,
      ITE_IDEPRO,
      ITE_PROMOC,
      ITE_EMPITE,
      ITE_TABPRE,
      ITE_NUMLOT: String;

      ITE_QTDITE,
      ITE_CUSITE,
      ITE_UNITAR,
      ITE_UNIORI,
      ITE_PREMED,
      ITE_IMPULT,
      ITE_PREULT,
      ITE_TAXJUR: Double;

      ITE_COMTBL,
      ITE_IMPFED,
      ITE_OUTVAL,
      ITE_DESOPE,
      ITE_ICMSAI,
      ITE_ICMCAL,
      ITE_VDIFAL,
      ITE_VALFCP: Double;

      ITE_RICMPR,
      ABF_CODFIS: String;

      ITE_VAL_ST,
      ITE_VALIPI,
      ITE_IPISAI,
      ITE_ALQICM,
      ITE_BASICM,
      ITE_VALICM,
      ITE_TOTCU2,
      ITE_BASRET,
      ITE_VALRET,
      ITE_PERRIC: Double;

      AUTOINCREM: Integer;//Identificacao do item alterando

      ITE_VDIFAL_MARGEM: Double;
      ITE_ALQDIF_ICMS_MARGEM: Double;
      ITE_ALQDIF_ICMS_MARGEM_IMPOSTOS: Double;
      ITE_CODFIS_MARGEM: string;
      ITE_CODABF_MARGEM: string;
      ITE_VALFCP_MARGEM: Double;
      ITE_CALMAR_PREDIN_MAR_MARGEM: Double;
      ITE_CALMAR_PREDIN_MARLIQ_MARGEM: Double;
      ITE_UTILIZA_PRECO_EM_DOLAR_MARGEM: Boolean;
  End;

  TProcCalculaAliquotasParaMargemAntesAdicionarItem = procedure(itemCalcMar: TItemCalcMargem) of object;

  TMostraTravaMinima = class
    public
      strCodIte,
      strEmpIte,
      strDesIte,
      strUnidad: String;

      fltQtdIte,
      fltPreCus,
      fltVlrTab: Double;

      strIdePro: String;

      strAutInc: String;//Identificacao do item alterando
  End;



Type
  {$M+}
  TClassDadosServicos = class
    private
      FRecSer: TDadosServicos;
    public
      constructor Create(servicos: TDadosServicos);
    published
      property recServicos: TDadosServicos Read FRecSer;

      property strCodS01: String     Read FRecSer.strCodS01 Write FRecSer.strCodS01;
      property strCodS02: String     Read FRecSer.strCodS02 Write FRecSer.strCodS02;
      property strCodS03: String     Read FRecSer.strCodS03 Write FRecSer.strCodS03;
      property strCodS04: String     Read FRecSer.strCodS04 Write FRecSer.strCodS04;
      property strCodS05: String     Read FRecSer.strCodS05 Write FRecSer.strCodS05;
      property strCodS06: String     Read FRecSer.strCodS06 Write FRecSer.strCodS06;
      property strCodS07: String     Read FRecSer.strCodS07 Write FRecSer.strCodS07;
      property strCodS08: String     Read FRecSer.strCodS08 Write FRecSer.strCodS08;
      property strCodS09: String     Read FRecSer.strCodS09 Write FRecSer.strCodS09;
      property strCodS10: String     Read FRecSer.strCodS10 Write FRecSer.strCodS10;
      property strCodS11: String     Read FRecSer.strCodS11 Write FRecSer.strCodS11;
      property strCodS12: String     Read FRecSer.strCodS12 Write FRecSer.strCodS12;
      property strCodS13: String     Read FRecSer.strCodS13 Write FRecSer.strCodS13;
      property strCodS14: String     Read FRecSer.strCodS14 Write FRecSer.strCodS14;
      property strCodS15: String     Read FRecSer.strCodS15 Write FRecSer.strCodS15;
      property strCodS16: String     Read FRecSer.strCodS16 Write FRecSer.strCodS16;
      property strCodS17: String     Read FRecSer.strCodS17 Write FRecSer.strCodS17;
      property strCodS18: String     Read FRecSer.strCodS18 Write FRecSer.strCodS18;
      property strCodS19: String     Read FRecSer.strCodS19 Write FRecSer.strCodS19;
      property strCodS20: String     Read FRecSer.strCodS20 Write FRecSer.strCodS20;
      property strCodS21: String     Read FRecSer.strCodS21 Write FRecSer.strCodS21;
      property strCodS22: String     Read FRecSer.strCodS22 Write FRecSer.strCodS22;
      property strCodS23: String     Read FRecSer.strCodS23 Write FRecSer.strCodS23;
      property strCodS24: String     Read FRecSer.strCodS24 Write FRecSer.strCodS24;
      property strCodS25: String     Read FRecSer.strCodS25 Write FRecSer.strCodS25;
      property strCodS26: String     Read FRecSer.strCodS26 Write FRecSer.strCodS26;
      property strCodS27: String     Read FRecSer.strCodS27 Write FRecSer.strCodS27;
      property strCodS28: String     Read FRecSer.strCodS28 Write FRecSer.strCodS28;
      property strCodS29: String     Read FRecSer.strCodS29 Write FRecSer.strCodS29;
      property strCodS30: String     Read FRecSer.strCodS30 Write FRecSer.strCodS30;

      property strDesS01: String     Read FRecSer.strDesS01 Write FRecSer.strDesS01;
      property strDesS02: String     Read FRecSer.strDesS02 Write FRecSer.strDesS02;
      property strDesS03: String     Read FRecSer.strDesS03 Write FRecSer.strDesS03;
      property strDesS04: String     Read FRecSer.strDesS04 Write FRecSer.strDesS04;
      property strDesS05: String     Read FRecSer.strDesS05 Write FRecSer.strDesS05;
      property strDesS06: String     Read FRecSer.strDesS06 Write FRecSer.strDesS06;
      property strDesS07: String     Read FRecSer.strDesS07 Write FRecSer.strDesS07;
      property strDesS08: String     Read FRecSer.strDesS08 Write FRecSer.strDesS08;
      property strDesS09: String     Read FRecSer.strDesS09 Write FRecSer.strDesS09;
      property strDesS10: String     Read FRecSer.strDesS10 Write FRecSer.strDesS10;
      property strDesS11: String     Read FRecSer.strDesS11 Write FRecSer.strDesS11;
      property strDesS12: String     Read FRecSer.strDesS12 Write FRecSer.strDesS12;
      property strDesS13: String     Read FRecSer.strDesS13 Write FRecSer.strDesS13;
      property strDesS14: String     Read FRecSer.strDesS14 Write FRecSer.strDesS14;
      property strDesS15: String     Read FRecSer.strDesS15 Write FRecSer.strDesS15;
      property strDesS16: String     Read FRecSer.strDesS16 Write FRecSer.strDesS16;
      property strDesS17: String     Read FRecSer.strDesS17 Write FRecSer.strDesS17;
      property strDesS18: String     Read FRecSer.strDesS18 Write FRecSer.strDesS18;
      property strDesS19: String     Read FRecSer.strDesS19 Write FRecSer.strDesS19;
      property strDesS20: String     Read FRecSer.strDesS20 Write FRecSer.strDesS20;
      property strDesS21: String     Read FRecSer.strDesS21 Write FRecSer.strDesS21;
      property strDesS22: String     Read FRecSer.strDesS22 Write FRecSer.strDesS22;
      property strDesS23: String     Read FRecSer.strDesS23 Write FRecSer.strDesS23;
      property strDesS24: String     Read FRecSer.strDesS24 Write FRecSer.strDesS24;
      property strDesS25: String     Read FRecSer.strDesS25 Write FRecSer.strDesS25;
      property strDesS26: String     Read FRecSer.strDesS26 Write FRecSer.strDesS26;
      property strDesS27: String     Read FRecSer.strDesS27 Write FRecSer.strDesS27;
      property strDesS28: String     Read FRecSer.strDesS28 Write FRecSer.strDesS28;
      property strDesS29: String     Read FRecSer.strDesS29 Write FRecSer.strDesS29;
      property strDesS30: String     Read FRecSer.strDesS30 Write FRecSer.strDesS30;

      property fltQtdS01: Double     Read FRecSer.fltQtdS01 Write FRecSer.fltQtdS01;
      property fltQtdS02: Double     Read FRecSer.fltQtdS02 Write FRecSer.fltQtdS02;
      property fltQtdS03: Double     Read FRecSer.fltQtdS03 Write FRecSer.fltQtdS03;
      property fltQtdS04: Double     Read FRecSer.fltQtdS04 Write FRecSer.fltQtdS04;
      property fltQtdS05: Double     Read FRecSer.fltQtdS05 Write FRecSer.fltQtdS05;
      property fltQtdS06: Double     Read FRecSer.fltQtdS06 Write FRecSer.fltQtdS06;
      property fltQtdS07: Double     Read FRecSer.fltQtdS07 Write FRecSer.fltQtdS07;
      property fltQtdS08: Double     Read FRecSer.fltQtdS08 Write FRecSer.fltQtdS08;
      property fltQtdS09: Double     Read FRecSer.fltQtdS09 Write FRecSer.fltQtdS09;
      property fltQtdS10: Double     Read FRecSer.fltQtdS10 Write FRecSer.fltQtdS10;
      property fltQtdS11: Double     Read FRecSer.fltQtdS11 Write FRecSer.fltQtdS11;
      property fltQtdS12: Double     Read FRecSer.fltQtdS12 Write FRecSer.fltQtdS12;
      property fltQtdS13: Double     Read FRecSer.fltQtdS13 Write FRecSer.fltQtdS13;
      property fltQtdS14: Double     Read FRecSer.fltQtdS14 Write FRecSer.fltQtdS14;
      property fltQtdS15: Double     Read FRecSer.fltQtdS15 Write FRecSer.fltQtdS15;
      property fltQtdS16: Double     Read FRecSer.fltQtdS16 Write FRecSer.fltQtdS16;
      property fltQtdS17: Double     Read FRecSer.fltQtdS17 Write FRecSer.fltQtdS17;
      property fltQtdS18: Double     Read FRecSer.fltQtdS18 Write FRecSer.fltQtdS18;
      property fltQtdS19: Double     Read FRecSer.fltQtdS19 Write FRecSer.fltQtdS19;
      property fltQtdS20: Double     Read FRecSer.fltQtdS20 Write FRecSer.fltQtdS20;
      property fltQtdS21: Double     Read FRecSer.fltQtdS21 Write FRecSer.fltQtdS21;
      property fltQtdS22: Double     Read FRecSer.fltQtdS22 Write FRecSer.fltQtdS22;
      property fltQtdS23: Double     Read FRecSer.fltQtdS23 Write FRecSer.fltQtdS23;
      property fltQtdS24: Double     Read FRecSer.fltQtdS24 Write FRecSer.fltQtdS24;
      property fltQtdS25: Double     Read FRecSer.fltQtdS25 Write FRecSer.fltQtdS25;
      property fltQtdS26: Double     Read FRecSer.fltQtdS26 Write FRecSer.fltQtdS26;
      property fltQtdS27: Double     Read FRecSer.fltQtdS27 Write FRecSer.fltQtdS27;
      property fltQtdS28: Double     Read FRecSer.fltQtdS28 Write FRecSer.fltQtdS28;
      property fltQtdS29: Double     Read FRecSer.fltQtdS29 Write FRecSer.fltQtdS29;
      property fltQtdS30: Double     Read FRecSer.fltQtdS30 Write FRecSer.fltQtdS30;

      property fltUniS01: Double     Read FRecSer.fltUniS01 Write FRecSer.fltUniS01;
      property fltUniS02: Double     Read FRecSer.fltUniS02 Write FRecSer.fltUniS02;
      property fltUniS03: Double     Read FRecSer.fltUniS03 Write FRecSer.fltUniS03;
      property fltUniS04: Double     Read FRecSer.fltUniS04 Write FRecSer.fltUniS04;
      property fltUniS05: Double     Read FRecSer.fltUniS05 Write FRecSer.fltUniS05;
      property fltUniS06: Double     Read FRecSer.fltUniS06 Write FRecSer.fltUniS06;
      property fltUniS07: Double     Read FRecSer.fltUniS07 Write FRecSer.fltUniS07;
      property fltUniS08: Double     Read FRecSer.fltUniS08 Write FRecSer.fltUniS08;
      property fltUniS09: Double     Read FRecSer.fltUniS09 Write FRecSer.fltUniS09;
      property fltUniS10: Double     Read FRecSer.fltUniS10 Write FRecSer.fltUniS10;
      property fltUniS11: Double     Read FRecSer.fltUniS11 Write FRecSer.fltUniS11;
      property fltUniS12: Double     Read FRecSer.fltUniS12 Write FRecSer.fltUniS12;
      property fltUniS13: Double     Read FRecSer.fltUniS13 Write FRecSer.fltUniS13;
      property fltUniS14: Double     Read FRecSer.fltUniS14 Write FRecSer.fltUniS14;
      property fltUniS15: Double     Read FRecSer.fltUniS15 Write FRecSer.fltUniS15;
      property fltUniS16: Double     Read FRecSer.fltUniS16 Write FRecSer.fltUniS16;
      property fltUniS17: Double     Read FRecSer.fltUniS17 Write FRecSer.fltUniS17;
      property fltUniS18: Double     Read FRecSer.fltUniS18 Write FRecSer.fltUniS18;
      property fltUniS19: Double     Read FRecSer.fltUniS19 Write FRecSer.fltUniS19;
      property fltUniS20: Double     Read FRecSer.fltUniS20 Write FRecSer.fltUniS20;
      property fltUniS21: Double     Read FRecSer.fltUniS21 Write FRecSer.fltUniS21;
      property fltUniS22: Double     Read FRecSer.fltUniS22 Write FRecSer.fltUniS22;
      property fltUniS23: Double     Read FRecSer.fltUniS23 Write FRecSer.fltUniS23;
      property fltUniS24: Double     Read FRecSer.fltUniS24 Write FRecSer.fltUniS24;
      property fltUniS25: Double     Read FRecSer.fltUniS25 Write FRecSer.fltUniS25;
      property fltUniS26: Double     Read FRecSer.fltUniS26 Write FRecSer.fltUniS26;
      property fltUniS27: Double     Read FRecSer.fltUniS27 Write FRecSer.fltUniS27;
      property fltUniS28: Double     Read FRecSer.fltUniS28 Write FRecSer.fltUniS28;
      property fltUniS29: Double     Read FRecSer.fltUniS29 Write FRecSer.fltUniS29;
      property fltUniS30: Double     Read FRecSer.fltUniS30 Write FRecSer.fltUniS30;

      property fltValS01: Double     Read FRecSer.fltValS01 Write FRecSer.fltValS01;
      property fltValS02: Double     Read FRecSer.fltValS02 Write FRecSer.fltValS02;
      property fltValS03: Double     Read FRecSer.fltValS03 Write FRecSer.fltValS03;
      property fltValS04: Double     Read FRecSer.fltValS04 Write FRecSer.fltValS04;
      property fltValS05: Double     Read FRecSer.fltValS05 Write FRecSer.fltValS05;
      property fltValS06: Double     Read FRecSer.fltValS06 Write FRecSer.fltValS06;
      property fltValS07: Double     Read FRecSer.fltValS07 Write FRecSer.fltValS07;
      property fltValS08: Double     Read FRecSer.fltValS08 Write FRecSer.fltValS08;
      property fltValS09: Double     Read FRecSer.fltValS09 Write FRecSer.fltValS09;
      property fltValS10: Double     Read FRecSer.fltValS10 Write FRecSer.fltValS10;
      property fltValS11: Double     Read FRecSer.fltValS11 Write FRecSer.fltValS11;
      property fltValS12: Double     Read FRecSer.fltValS12 Write FRecSer.fltValS12;
      property fltValS13: Double     Read FRecSer.fltValS13 Write FRecSer.fltValS13;
      property fltValS14: Double     Read FRecSer.fltValS14 Write FRecSer.fltValS14;
      property fltValS15: Double     Read FRecSer.fltValS15 Write FRecSer.fltValS15;
      property fltValS16: Double     Read FRecSer.fltValS16 Write FRecSer.fltValS16;
      property fltValS17: Double     Read FRecSer.fltValS17 Write FRecSer.fltValS17;
      property fltValS18: Double     Read FRecSer.fltValS18 Write FRecSer.fltValS18;
      property fltValS19: Double     Read FRecSer.fltValS19 Write FRecSer.fltValS19;
      property fltValS20: Double     Read FRecSer.fltValS20 Write FRecSer.fltValS20;
      property fltValS21: Double     Read FRecSer.fltValS21 Write FRecSer.fltValS21;
      property fltValS22: Double     Read FRecSer.fltValS22 Write FRecSer.fltValS22;
      property fltValS23: Double     Read FRecSer.fltValS23 Write FRecSer.fltValS23;
      property fltValS24: Double     Read FRecSer.fltValS24 Write FRecSer.fltValS24;
      property fltValS25: Double     Read FRecSer.fltValS25 Write FRecSer.fltValS25;
      property fltValS26: Double     Read FRecSer.fltValS26 Write FRecSer.fltValS26;
      property fltValS27: Double     Read FRecSer.fltValS27 Write FRecSer.fltValS27;
      property fltValS28: Double     Read FRecSer.fltValS28 Write FRecSer.fltValS28;
      property fltValS29: Double     Read FRecSer.fltValS29 Write FRecSer.fltValS29;
      property fltValS30: Double     Read FRecSer.fltValS30 Write FRecSer.fltValS30;

      property fltCusS01: Double     Read FRecSer.fltCusS01 Write FRecSer.fltCusS01;
      property fltCusS02: Double     Read FRecSer.fltCusS02 Write FRecSer.fltCusS02;
      property fltCusS03: Double     Read FRecSer.fltCusS03 Write FRecSer.fltCusS03;
      property fltCusS04: Double     Read FRecSer.fltCusS04 Write FRecSer.fltCusS04;
      property fltCusS05: Double     Read FRecSer.fltCusS05 Write FRecSer.fltCusS05;
      property fltCusS06: Double     Read FRecSer.fltCusS06 Write FRecSer.fltCusS06;
      property fltCusS07: Double     Read FRecSer.fltCusS07 Write FRecSer.fltCusS07;
      property fltCusS08: Double     Read FRecSer.fltCusS08 Write FRecSer.fltCusS08;
      property fltCusS09: Double     Read FRecSer.fltCusS09 Write FRecSer.fltCusS09;
      property fltCusS10: Double     Read FRecSer.fltCusS10 Write FRecSer.fltCusS10;
      property fltCusS11: Double     Read FRecSer.fltCusS11 Write FRecSer.fltCusS11;
      property fltCusS12: Double     Read FRecSer.fltCusS12 Write FRecSer.fltCusS12;
      property fltCusS13: Double     Read FRecSer.fltCusS13 Write FRecSer.fltCusS13;
      property fltCusS14: Double     Read FRecSer.fltCusS14 Write FRecSer.fltCusS14;
      property fltCusS15: Double     Read FRecSer.fltCusS15 Write FRecSer.fltCusS15;
      property fltCusS16: Double     Read FRecSer.fltCusS16 Write FRecSer.fltCusS16;
      property fltCusS17: Double     Read FRecSer.fltCusS17 Write FRecSer.fltCusS17;
      property fltCusS18: Double     Read FRecSer.fltCusS18 Write FRecSer.fltCusS18;
      property fltCusS19: Double     Read FRecSer.fltCusS19 Write FRecSer.fltCusS19;
      property fltCusS20: Double     Read FRecSer.fltCusS20 Write FRecSer.fltCusS20;
      property fltCusS21: Double     Read FRecSer.fltCusS21 Write FRecSer.fltCusS21;
      property fltCusS22: Double     Read FRecSer.fltCusS22 Write FRecSer.fltCusS22;
      property fltCusS23: Double     Read FRecSer.fltCusS23 Write FRecSer.fltCusS23;
      property fltCusS24: Double     Read FRecSer.fltCusS24 Write FRecSer.fltCusS24;
      property fltCusS25: Double     Read FRecSer.fltCusS25 Write FRecSer.fltCusS25;
      property fltCusS26: Double     Read FRecSer.fltCusS26 Write FRecSer.fltCusS26;
      property fltCusS27: Double     Read FRecSer.fltCusS27 Write FRecSer.fltCusS27;
      property fltCusS28: Double     Read FRecSer.fltCusS28 Write FRecSer.fltCusS28;
      property fltCusS29: Double     Read FRecSer.fltCusS29 Write FRecSer.fltCusS29;
      property fltCusS30: Double     Read FRecSer.fltCusS30 Write FRecSer.fltCusS30;

      property fltDecS01: Double     Read FRecSer.fltDecS01 Write FRecSer.fltDecS01;
      property fltDecS02: Double     Read FRecSer.fltDecS02 Write FRecSer.fltDecS02;
      property fltDecS03: Double     Read FRecSer.fltDecS03 Write FRecSer.fltDecS03;
      property fltDecS04: Double     Read FRecSer.fltDecS04 Write FRecSer.fltDecS04;
      property fltDecS05: Double     Read FRecSer.fltDecS05 Write FRecSer.fltDecS05;
      property fltDecS06: Double     Read FRecSer.fltDecS06 Write FRecSer.fltDecS06;
      property fltDecS07: Double     Read FRecSer.fltDecS07 Write FRecSer.fltDecS07;
      property fltDecS08: Double     Read FRecSer.fltDecS08 Write FRecSer.fltDecS08;
      property fltDecS09: Double     Read FRecSer.fltDecS09 Write FRecSer.fltDecS09;
      property fltDecS10: Double     Read FRecSer.fltDecS10 Write FRecSer.fltDecS10;
      property fltDecS11: Double     Read FRecSer.fltDecS11 Write FRecSer.fltDecS11;
      property fltDecS12: Double     Read FRecSer.fltDecS12 Write FRecSer.fltDecS12;
      property fltDecS13: Double     Read FRecSer.fltDecS13 Write FRecSer.fltDecS13;
      property fltDecS14: Double     Read FRecSer.fltDecS14 Write FRecSer.fltDecS14;
      property fltDecS15: Double     Read FRecSer.fltDecS15 Write FRecSer.fltDecS15;
      property fltDecS16: Double     Read FRecSer.fltDecS16 Write FRecSer.fltDecS16;
      property fltDecS17: Double     Read FRecSer.fltDecS17 Write FRecSer.fltDecS17;
      property fltDecS18: Double     Read FRecSer.fltDecS18 Write FRecSer.fltDecS18;
      property fltDecS19: Double     Read FRecSer.fltDecS19 Write FRecSer.fltDecS19;
      property fltDecS20: Double     Read FRecSer.fltDecS20 Write FRecSer.fltDecS20;
      property fltDecS21: Double     Read FRecSer.fltDecS21 Write FRecSer.fltDecS21;
      property fltDecS22: Double     Read FRecSer.fltDecS22 Write FRecSer.fltDecS22;
      property fltDecS23: Double     Read FRecSer.fltDecS23 Write FRecSer.fltDecS23;
      property fltDecS24: Double     Read FRecSer.fltDecS24 Write FRecSer.fltDecS24;
      property fltDecS25: Double     Read FRecSer.fltDecS25 Write FRecSer.fltDecS25;
      property fltDecS26: Double     Read FRecSer.fltDecS26 Write FRecSer.fltDecS26;
      property fltDecS27: Double     Read FRecSer.fltDecS27 Write FRecSer.fltDecS27;
      property fltDecS28: Double     Read FRecSer.fltDecS28 Write FRecSer.fltDecS28;
      property fltDecS29: Double     Read FRecSer.fltDecS29 Write FRecSer.fltDecS29;
      property fltDecS30: Double     Read FRecSer.fltDecS30 Write FRecSer.fltDecS30;

      property strMecS01: String     Read FRecSer.strMecS01 Write FRecSer.strMecS01;
      property strMecS02: String     Read FRecSer.strMecS02 Write FRecSer.strMecS02;
      property strMecS03: String     Read FRecSer.strMecS03 Write FRecSer.strMecS03;
      property strMecS04: String     Read FRecSer.strMecS04 Write FRecSer.strMecS04;
      property strMecS05: String     Read FRecSer.strMecS05 Write FRecSer.strMecS05;
      property strMecS06: String     Read FRecSer.strMecS06 Write FRecSer.strMecS06;
      property strMecS07: String     Read FRecSer.strMecS07 Write FRecSer.strMecS07;
      property strMecS08: String     Read FRecSer.strMecS08 Write FRecSer.strMecS08;
      property strMecS09: String     Read FRecSer.strMecS09 Write FRecSer.strMecS09;
      property strMecS10: String     Read FRecSer.strMecS10 Write FRecSer.strMecS10;
      property strMecS11: String     Read FRecSer.strMecS11 Write FRecSer.strMecS11;
      property strMecS12: String     Read FRecSer.strMecS12 Write FRecSer.strMecS12;
      property strMecS13: String     Read FRecSer.strMecS13 Write FRecSer.strMecS13;
      property strMecS14: String     Read FRecSer.strMecS14 Write FRecSer.strMecS14;
      property strMecS15: String     Read FRecSer.strMecS15 Write FRecSer.strMecS15;
      property strMecS16: String     Read FRecSer.strMecS16 Write FRecSer.strMecS16;
      property strMecS17: String     Read FRecSer.strMecS17 Write FRecSer.strMecS17;
      property strMecS18: String     Read FRecSer.strMecS18 Write FRecSer.strMecS18;
      property strMecS19: String     Read FRecSer.strMecS19 Write FRecSer.strMecS19;
      property strMecS20: String     Read FRecSer.strMecS20 Write FRecSer.strMecS20;
      property strMecS21: String     Read FRecSer.strMecS21 Write FRecSer.strMecS21;
      property strMecS22: String     Read FRecSer.strMecS22 Write FRecSer.strMecS22;
      property strMecS23: String     Read FRecSer.strMecS23 Write FRecSer.strMecS23;
      property strMecS24: String     Read FRecSer.strMecS24 Write FRecSer.strMecS24;
      property strMecS25: String     Read FRecSer.strMecS25 Write FRecSer.strMecS25;
      property strMecS26: String     Read FRecSer.strMecS26 Write FRecSer.strMecS26;
      property strMecS27: String     Read FRecSer.strMecS27 Write FRecSer.strMecS27;
      property strMecS28: String     Read FRecSer.strMecS28 Write FRecSer.strMecS28;
      property strMecS29: String     Read FRecSer.strMecS29 Write FRecSer.strMecS29;
      property strMecS30: String     Read FRecSer.strMecS30 Write FRecSer.strMecS30;

      property strObsS01: String     Read FRecSer.strObsS01 Write FRecSer.strObsS01;
      property strObsS02: String     Read FRecSer.strObsS02 Write FRecSer.strObsS02;
      property strObsS03: String     Read FRecSer.strObsS03 Write FRecSer.strObsS03;
      property strObsS04: String     Read FRecSer.strObsS04 Write FRecSer.strObsS04;
      property strObsS05: String     Read FRecSer.strObsS05 Write FRecSer.strObsS05;
      property strObsS06: String     Read FRecSer.strObsS06 Write FRecSer.strObsS06;
      property strObsS07: String     Read FRecSer.strObsS07 Write FRecSer.strObsS07;
      property strObsS08: String     Read FRecSer.strObsS08 Write FRecSer.strObsS08;
      property strObsS09: String     Read FRecSer.strObsS09 Write FRecSer.strObsS09;
      property strObsS10: String     Read FRecSer.strObsS10 Write FRecSer.strObsS10;
      property strObsS11: String     Read FRecSer.strObsS11 Write FRecSer.strObsS11;
      property strObsS12: String     Read FRecSer.strObsS12 Write FRecSer.strObsS12;
      property strObsS13: String     Read FRecSer.strObsS13 Write FRecSer.strObsS13;
      property strObsS14: String     Read FRecSer.strObsS14 Write FRecSer.strObsS14;
      property strObsS15: String     Read FRecSer.strObsS15 Write FRecSer.strObsS15;
      property strObsS16: String     Read FRecSer.strObsS16 Write FRecSer.strObsS16;
      property strObsS17: String     Read FRecSer.strObsS17 Write FRecSer.strObsS17;
      property strObsS18: String     Read FRecSer.strObsS18 Write FRecSer.strObsS18;
      property strObsS19: String     Read FRecSer.strObsS19 Write FRecSer.strObsS19;
      property strObsS20: String     Read FRecSer.strObsS20 Write FRecSer.strObsS20;
      property strObsS21: String     Read FRecSer.strObsS21 Write FRecSer.strObsS21;
      property strObsS22: String     Read FRecSer.strObsS22 Write FRecSer.strObsS22;
      property strObsS23: String     Read FRecSer.strObsS23 Write FRecSer.strObsS23;
      property strObsS24: String     Read FRecSer.strObsS24 Write FRecSer.strObsS24;
      property strObsS25: String     Read FRecSer.strObsS25 Write FRecSer.strObsS25;
      property strObsS26: String     Read FRecSer.strObsS26 Write FRecSer.strObsS26;
      property strObsS27: String     Read FRecSer.strObsS27 Write FRecSer.strObsS27;
      property strObsS28: String     Read FRecSer.strObsS28 Write FRecSer.strObsS28;
      property strObsS29: String     Read FRecSer.strObsS29 Write FRecSer.strObsS29;
      property strObsS30: String     Read FRecSer.strObsS30 Write FRecSer.strObsS30;

      property strStaS01: String     Read FRecSer.strStaS01 Write FRecSer.strStaS01;
      property strStaS02: String     Read FRecSer.strStaS02 Write FRecSer.strStaS02;
      property strStaS03: String     Read FRecSer.strStaS03 Write FRecSer.strStaS03;
      property strStaS04: String     Read FRecSer.strStaS04 Write FRecSer.strStaS04;
      property strStaS05: String     Read FRecSer.strStaS05 Write FRecSer.strStaS05;
      property strStaS06: String     Read FRecSer.strStaS06 Write FRecSer.strStaS06;
      property strStaS07: String     Read FRecSer.strStaS07 Write FRecSer.strStaS07;
      property strStaS08: String     Read FRecSer.strStaS08 Write FRecSer.strStaS08;
      property strStaS09: String     Read FRecSer.strStaS09 Write FRecSer.strStaS09;
      property strStaS10: String     Read FRecSer.strStaS10 Write FRecSer.strStaS10;
      property strStaS11: String     Read FRecSer.strStaS11 Write FRecSer.strStaS11;
      property strStaS12: String     Read FRecSer.strStaS12 Write FRecSer.strStaS12;
      property strStaS13: String     Read FRecSer.strStaS13 Write FRecSer.strStaS13;
      property strStaS14: String     Read FRecSer.strStaS14 Write FRecSer.strStaS14;
      property strStaS15: String     Read FRecSer.strStaS15 Write FRecSer.strStaS15;
      property strStaS16: String     Read FRecSer.strStaS16 Write FRecSer.strStaS16;
      property strStaS17: String     Read FRecSer.strStaS17 Write FRecSer.strStaS17;
      property strStaS18: String     Read FRecSer.strStaS18 Write FRecSer.strStaS18;
      property strStaS19: String     Read FRecSer.strStaS19 Write FRecSer.strStaS19;
      property strStaS20: String     Read FRecSer.strStaS20 Write FRecSer.strStaS20;
      property strStaS21: String     Read FRecSer.strStaS21 Write FRecSer.strStaS21;
      property strStaS22: String     Read FRecSer.strStaS22 Write FRecSer.strStaS22;
      property strStaS23: String     Read FRecSer.strStaS23 Write FRecSer.strStaS23;
      property strStaS24: String     Read FRecSer.strStaS24 Write FRecSer.strStaS24;
      property strStaS25: String     Read FRecSer.strStaS25 Write FRecSer.strStaS25;
      property strStaS26: String     Read FRecSer.strStaS26 Write FRecSer.strStaS26;
      property strStaS27: String     Read FRecSer.strStaS27 Write FRecSer.strStaS27;
      property strStaS28: String     Read FRecSer.strStaS28 Write FRecSer.strStaS28;
      property strStaS29: String     Read FRecSer.strStaS29 Write FRecSer.strStaS29;
      property strStaS30: String     Read FRecSer.strStaS30 Write FRecSer.strStaS30;

      property strBriS01: String     Read FRecSer.strBriS01 Write FRecSer.strBriS01;
      property strBriS02: String     Read FRecSer.strBriS02 Write FRecSer.strBriS02;
      property strBriS03: String     Read FRecSer.strBriS03 Write FRecSer.strBriS03;
      property strBriS04: String     Read FRecSer.strBriS04 Write FRecSer.strBriS04;
      property strBriS05: String     Read FRecSer.strBriS05 Write FRecSer.strBriS05;
      property strBriS06: String     Read FRecSer.strBriS06 Write FRecSer.strBriS06;
      property strBriS07: String     Read FRecSer.strBriS07 Write FRecSer.strBriS07;
      property strBriS08: String     Read FRecSer.strBriS08 Write FRecSer.strBriS08;
      property strBriS09: String     Read FRecSer.strBriS09 Write FRecSer.strBriS09;
      property strBriS10: String     Read FRecSer.strBriS10 Write FRecSer.strBriS10;
      property strBriS11: String     Read FRecSer.strBriS11 Write FRecSer.strBriS11;
      property strBriS12: String     Read FRecSer.strBriS12 Write FRecSer.strBriS12;
      property strBriS13: String     Read FRecSer.strBriS13 Write FRecSer.strBriS13;
      property strBriS14: String     Read FRecSer.strBriS14 Write FRecSer.strBriS14;
      property strBriS15: String     Read FRecSer.strBriS15 Write FRecSer.strBriS15;
      property strBriS16: String     Read FRecSer.strBriS16 Write FRecSer.strBriS16;
      property strBriS17: String     Read FRecSer.strBriS17 Write FRecSer.strBriS17;
      property strBriS18: String     Read FRecSer.strBriS18 Write FRecSer.strBriS18;
      property strBriS19: String     Read FRecSer.strBriS19 Write FRecSer.strBriS19;
      property strBriS20: String     Read FRecSer.strBriS20 Write FRecSer.strBriS20;
      property strBriS21: String     Read FRecSer.strBriS21 Write FRecSer.strBriS21;
      property strBriS22: String     Read FRecSer.strBriS22 Write FRecSer.strBriS22;
      property strBriS23: String     Read FRecSer.strBriS23 Write FRecSer.strBriS23;
      property strBriS24: String     Read FRecSer.strBriS24 Write FRecSer.strBriS24;
      property strBriS25: String     Read FRecSer.strBriS25 Write FRecSer.strBriS25;
      property strBriS26: String     Read FRecSer.strBriS26 Write FRecSer.strBriS26;
      property strBriS27: String     Read FRecSer.strBriS27 Write FRecSer.strBriS27;
      property strBriS28: String     Read FRecSer.strBriS28 Write FRecSer.strBriS28;
      property strBriS29: String     Read FRecSer.strBriS29 Write FRecSer.strBriS29;
      property strBriS30: String     Read FRecSer.strBriS30 Write FRecSer.strBriS30;

      property strParS01: String     Read FRecSer.strParS01 Write FRecSer.strParS01;
      property strParS02: String     Read FRecSer.strParS02 Write FRecSer.strParS02;
      property strParS03: String     Read FRecSer.strParS03 Write FRecSer.strParS03;
      property strParS04: String     Read FRecSer.strParS04 Write FRecSer.strParS04;
      property strParS05: String     Read FRecSer.strParS05 Write FRecSer.strParS05;
      property strParS06: String     Read FRecSer.strParS06 Write FRecSer.strParS06;
      property strParS07: String     Read FRecSer.strParS07 Write FRecSer.strParS07;
      property strParS08: String     Read FRecSer.strParS08 Write FRecSer.strParS08;
      property strParS09: String     Read FRecSer.strParS09 Write FRecSer.strParS09;
      property strParS10: String     Read FRecSer.strParS10 Write FRecSer.strParS10;
      property strParS11: String     Read FRecSer.strParS11 Write FRecSer.strParS11;
      property strParS12: String     Read FRecSer.strParS12 Write FRecSer.strParS12;
      property strParS13: String     Read FRecSer.strParS13 Write FRecSer.strParS13;
      property strParS14: String     Read FRecSer.strParS14 Write FRecSer.strParS14;
      property strParS15: String     Read FRecSer.strParS15 Write FRecSer.strParS15;
      property strParS16: String     Read FRecSer.strParS16 Write FRecSer.strParS16;
      property strParS17: String     Read FRecSer.strParS17 Write FRecSer.strParS17;
      property strParS18: String     Read FRecSer.strParS18 Write FRecSer.strParS18;
      property strParS19: String     Read FRecSer.strParS19 Write FRecSer.strParS19;
      property strParS20: String     Read FRecSer.strParS20 Write FRecSer.strParS20;
      property strParS21: String     Read FRecSer.strParS21 Write FRecSer.strParS21;
      property strParS22: String     Read FRecSer.strParS22 Write FRecSer.strParS22;
      property strParS23: String     Read FRecSer.strParS23 Write FRecSer.strParS23;
      property strParS24: String     Read FRecSer.strParS24 Write FRecSer.strParS24;
      property strParS25: String     Read FRecSer.strParS25 Write FRecSer.strParS25;
      property strParS26: String     Read FRecSer.strParS26 Write FRecSer.strParS26;
      property strParS27: String     Read FRecSer.strParS27 Write FRecSer.strParS27;
      property strParS28: String     Read FRecSer.strParS28 Write FRecSer.strParS28;
      property strParS29: String     Read FRecSer.strParS29 Write FRecSer.strParS29;
      property strParS30: String     Read FRecSer.strParS30 Write FRecSer.strParS30;

      property strTBrS01: String     Read FRecSer.strTBrS01 Write FRecSer.strTBrS01;
      property strTBrS02: String     Read FRecSer.strTBrS02 Write FRecSer.strTBrS02;
      property strTBrS03: String     Read FRecSer.strTBrS03 Write FRecSer.strTBrS03;
      property strTBrS04: String     Read FRecSer.strTBrS04 Write FRecSer.strTBrS04;
      property strTBrS05: String     Read FRecSer.strTBrS05 Write FRecSer.strTBrS05;
      property strTBrS06: String     Read FRecSer.strTBrS06 Write FRecSer.strTBrS06;
      property strTBrS07: String     Read FRecSer.strTBrS07 Write FRecSer.strTBrS07;
      property strTBrS08: String     Read FRecSer.strTBrS08 Write FRecSer.strTBrS08;
      property strTBrS09: String     Read FRecSer.strTBrS09 Write FRecSer.strTBrS09;
      property strTBrS10: String     Read FRecSer.strTBrS10 Write FRecSer.strTBrS10;
      property strTBrS11: String     Read FRecSer.strTBrS11 Write FRecSer.strTBrS11;
      property strTBrS12: String     Read FRecSer.strTBrS12 Write FRecSer.strTBrS12;
      property strTBrS13: String     Read FRecSer.strTBrS13 Write FRecSer.strTBrS13;
      property strTBrS14: String     Read FRecSer.strTBrS14 Write FRecSer.strTBrS14;
      property strTBrS15: String     Read FRecSer.strTBrS15 Write FRecSer.strTBrS15;
      property strTBrS16: String     Read FRecSer.strTBrS16 Write FRecSer.strTBrS16;
      property strTBrS17: String     Read FRecSer.strTBrS17 Write FRecSer.strTBrS17;
      property strTBrS18: String     Read FRecSer.strTBrS18 Write FRecSer.strTBrS18;
      property strTBrS19: String     Read FRecSer.strTBrS19 Write FRecSer.strTBrS19;
      property strTBrS20: String     Read FRecSer.strTBrS20 Write FRecSer.strTBrS20;
      property strTBrS21: String     Read FRecSer.strTBrS21 Write FRecSer.strTBrS21;
      property strTBrS22: String     Read FRecSer.strTBrS22 Write FRecSer.strTBrS22;
      property strTBrS23: String     Read FRecSer.strTBrS23 Write FRecSer.strTBrS23;
      property strTBrS24: String     Read FRecSer.strTBrS24 Write FRecSer.strTBrS24;
      property strTBrS25: String     Read FRecSer.strTBrS25 Write FRecSer.strTBrS25;
      property strTBrS26: String     Read FRecSer.strTBrS26 Write FRecSer.strTBrS26;
      property strTBrS27: String     Read FRecSer.strTBrS27 Write FRecSer.strTBrS27;
      property strTBrS28: String     Read FRecSer.strTBrS28 Write FRecSer.strTBrS28;
      property strTBrS29: String     Read FRecSer.strTBrS29 Write FRecSer.strTBrS29;
      property strTBrS30: String     Read FRecSer.strTBrS30 Write FRecSer.strTBrS30;

      property strPriS01: String     Read FRecSer.strPriS01 Write FRecSer.strPriS01;
      property strPriS02: String     Read FRecSer.strPriS02 Write FRecSer.strPriS02;
      property strPriS03: String     Read FRecSer.strPriS03 Write FRecSer.strPriS03;
      property strPriS04: String     Read FRecSer.strPriS04 Write FRecSer.strPriS04;
      property strPriS05: String     Read FRecSer.strPriS05 Write FRecSer.strPriS05;
      property strPriS06: String     Read FRecSer.strPriS06 Write FRecSer.strPriS06;
      property strPriS07: String     Read FRecSer.strPriS07 Write FRecSer.strPriS07;
      property strPriS08: String     Read FRecSer.strPriS08 Write FRecSer.strPriS08;
      property strPriS09: String     Read FRecSer.strPriS09 Write FRecSer.strPriS09;
      property strPriS10: String     Read FRecSer.strPriS10 Write FRecSer.strPriS10;
      property strPriS11: String     Read FRecSer.strPriS11 Write FRecSer.strPriS11;
      property strPriS12: String     Read FRecSer.strPriS12 Write FRecSer.strPriS12;
      property strPriS13: String     Read FRecSer.strPriS13 Write FRecSer.strPriS13;
      property strPriS14: String     Read FRecSer.strPriS14 Write FRecSer.strPriS14;
      property strPriS15: String     Read FRecSer.strPriS15 Write FRecSer.strPriS15;
      property strPriS16: String     Read FRecSer.strPriS16 Write FRecSer.strPriS16;
      property strPriS17: String     Read FRecSer.strPriS17 Write FRecSer.strPriS17;
      property strPriS18: String     Read FRecSer.strPriS18 Write FRecSer.strPriS18;
      property strPriS19: String     Read FRecSer.strPriS19 Write FRecSer.strPriS19;
      property strPriS20: String     Read FRecSer.strPriS20 Write FRecSer.strPriS20;
      property strPriS21: String     Read FRecSer.strPriS21 Write FRecSer.strPriS21;
      property strPriS22: String     Read FRecSer.strPriS22 Write FRecSer.strPriS22;
      property strPriS23: String     Read FRecSer.strPriS23 Write FRecSer.strPriS23;
      property strPriS24: String     Read FRecSer.strPriS24 Write FRecSer.strPriS24;
      property strPriS25: String     Read FRecSer.strPriS25 Write FRecSer.strPriS25;
      property strPriS26: String     Read FRecSer.strPriS26 Write FRecSer.strPriS26;
      property strPriS27: String     Read FRecSer.strPriS27 Write FRecSer.strPriS27;
      property strPriS28: String     Read FRecSer.strPriS28 Write FRecSer.strPriS28;
      property strPriS29: String     Read FRecSer.strPriS29 Write FRecSer.strPriS29;
      property strPriS30: String     Read FRecSer.strPriS30 Write FRecSer.strPriS30;

      property strIdeS01: String     Read FRecSer.strIdeS01 Write FRecSer.strIdeS01;
      property strIdeS02: String     Read FRecSer.strIdeS02 Write FRecSer.strIdeS02;
      property strIdeS03: String     Read FRecSer.strIdeS03 Write FRecSer.strIdeS03;
      property strIdeS04: String     Read FRecSer.strIdeS04 Write FRecSer.strIdeS04;
      property strIdeS05: String     Read FRecSer.strIdeS05 Write FRecSer.strIdeS05;
      property strIdeS06: String     Read FRecSer.strIdeS06 Write FRecSer.strIdeS06;
      property strIdeS07: String     Read FRecSer.strIdeS07 Write FRecSer.strIdeS07;
      property strIdeS08: String     Read FRecSer.strIdeS08 Write FRecSer.strIdeS08;
      property strIdeS09: String     Read FRecSer.strIdeS09 Write FRecSer.strIdeS09;
      property strIdeS10: String     Read FRecSer.strIdeS10 Write FRecSer.strIdeS10;
      property strIdeS11: String     Read FRecSer.strIdeS11 Write FRecSer.strIdeS11;
      property strIdeS12: String     Read FRecSer.strIdeS12 Write FRecSer.strIdeS12;
      property strIdeS13: String     Read FRecSer.strIdeS13 Write FRecSer.strIdeS13;
      property strIdeS14: String     Read FRecSer.strIdeS14 Write FRecSer.strIdeS14;
      property strIdeS15: String     Read FRecSer.strIdeS15 Write FRecSer.strIdeS15;
      property strIdeS16: String     Read FRecSer.strIdeS16 Write FRecSer.strIdeS16;
      property strIdeS17: String     Read FRecSer.strIdeS17 Write FRecSer.strIdeS17;
      property strIdeS18: String     Read FRecSer.strIdeS18 Write FRecSer.strIdeS18;
      property strIdeS19: String     Read FRecSer.strIdeS19 Write FRecSer.strIdeS19;
      property strIdeS20: String     Read FRecSer.strIdeS20 Write FRecSer.strIdeS20;
      property strIdeS21: String     Read FRecSer.strIdeS21 Write FRecSer.strIdeS21;
      property strIdeS22: String     Read FRecSer.strIdeS22 Write FRecSer.strIdeS22;
      property strIdeS23: String     Read FRecSer.strIdeS23 Write FRecSer.strIdeS23;
      property strIdeS24: String     Read FRecSer.strIdeS24 Write FRecSer.strIdeS24;
      property strIdeS25: String     Read FRecSer.strIdeS25 Write FRecSer.strIdeS25;
      property strIdeS26: String     Read FRecSer.strIdeS26 Write FRecSer.strIdeS26;
      property strIdeS27: String     Read FRecSer.strIdeS27 Write FRecSer.strIdeS27;
      property strIdeS28: String     Read FRecSer.strIdeS28 Write FRecSer.strIdeS28;
      property strIdeS29: String     Read FRecSer.strIdeS29 Write FRecSer.strIdeS29;
      property strIdeS30: String     Read FRecSer.strIdeS30 Write FRecSer.strIdeS30;

      property strVenS01: String     Read FRecSer.strVenS01 Write FRecSer.strVenS01;
      property strVenS02: String     Read FRecSer.strVenS02 Write FRecSer.strVenS02;
      property strVenS03: String     Read FRecSer.strVenS03 Write FRecSer.strVenS03;
      property strVenS04: String     Read FRecSer.strVenS04 Write FRecSer.strVenS04;
      property strVenS05: String     Read FRecSer.strVenS05 Write FRecSer.strVenS05;
      property strVenS06: String     Read FRecSer.strVenS06 Write FRecSer.strVenS06;
      property strVenS07: String     Read FRecSer.strVenS07 Write FRecSer.strVenS07;
      property strVenS08: String     Read FRecSer.strVenS08 Write FRecSer.strVenS08;
      property strVenS09: String     Read FRecSer.strVenS09 Write FRecSer.strVenS09;
      property strVenS10: String     Read FRecSer.strVenS10 Write FRecSer.strVenS10;
      property strVenS11: String     Read FRecSer.strVenS11 Write FRecSer.strVenS11;
      property strVenS12: String     Read FRecSer.strVenS12 Write FRecSer.strVenS12;
      property strVenS13: String     Read FRecSer.strVenS13 Write FRecSer.strVenS13;
      property strVenS14: String     Read FRecSer.strVenS14 Write FRecSer.strVenS14;
      property strVenS15: String     Read FRecSer.strVenS15 Write FRecSer.strVenS15;
      property strVenS16: String     Read FRecSer.strVenS16 Write FRecSer.strVenS16;
      property strVenS17: String     Read FRecSer.strVenS17 Write FRecSer.strVenS17;
      property strVenS18: String     Read FRecSer.strVenS18 Write FRecSer.strVenS18;
      property strVenS19: String     Read FRecSer.strVenS19 Write FRecSer.strVenS19;
      property strVenS20: String     Read FRecSer.strVenS20 Write FRecSer.strVenS20;
      property strVenS21: String     Read FRecSer.strVenS21 Write FRecSer.strVenS21;
      property strVenS22: String     Read FRecSer.strVenS22 Write FRecSer.strVenS22;
      property strVenS23: String     Read FRecSer.strVenS23 Write FRecSer.strVenS23;
      property strVenS24: String     Read FRecSer.strVenS24 Write FRecSer.strVenS24;
      property strVenS25: String     Read FRecSer.strVenS25 Write FRecSer.strVenS25;
      property strVenS26: String     Read FRecSer.strVenS26 Write FRecSer.strVenS26;
      property strVenS27: String     Read FRecSer.strVenS27 Write FRecSer.strVenS27;
      property strVenS28: String     Read FRecSer.strVenS28 Write FRecSer.strVenS28;
      property strVenS29: String     Read FRecSer.strVenS29 Write FRecSer.strVenS29;
      property strVenS30: String     Read FRecSer.strVenS30 Write FRecSer.strVenS30;

      property strVe2S01: String     Read FRecSer.strVe2S01 Write FRecSer.strVe2S01;
      property strVe2S02: String     Read FRecSer.strVe2S02 Write FRecSer.strVe2S02;
      property strVe2S03: String     Read FRecSer.strVe2S03 Write FRecSer.strVe2S03;
      property strVe2S04: String     Read FRecSer.strVe2S04 Write FRecSer.strVe2S04;
      property strVe2S05: String     Read FRecSer.strVe2S05 Write FRecSer.strVe2S05;
      property strVe2S06: String     Read FRecSer.strVe2S06 Write FRecSer.strVe2S06;
      property strVe2S07: String     Read FRecSer.strVe2S07 Write FRecSer.strVe2S07;
      property strVe2S08: String     Read FRecSer.strVe2S08 Write FRecSer.strVe2S08;
      property strVe2S09: String     Read FRecSer.strVe2S09 Write FRecSer.strVe2S09;
      property strVe2S10: String     Read FRecSer.strVe2S10 Write FRecSer.strVe2S10;
      property strVe2S11: String     Read FRecSer.strVe2S11 Write FRecSer.strVe2S11;
      property strVe2S12: String     Read FRecSer.strVe2S12 Write FRecSer.strVe2S12;
      property strVe2S13: String     Read FRecSer.strVe2S13 Write FRecSer.strVe2S13;
      property strVe2S14: String     Read FRecSer.strVe2S14 Write FRecSer.strVe2S14;
      property strVe2S15: String     Read FRecSer.strVe2S15 Write FRecSer.strVe2S15;
      property strVe2S16: String     Read FRecSer.strVe2S16 Write FRecSer.strVe2S16;
      property strVe2S17: String     Read FRecSer.strVe2S17 Write FRecSer.strVe2S17;
      property strVe2S18: String     Read FRecSer.strVe2S18 Write FRecSer.strVe2S18;
      property strVe2S19: String     Read FRecSer.strVe2S19 Write FRecSer.strVe2S19;
      property strVe2S20: String     Read FRecSer.strVe2S20 Write FRecSer.strVe2S20;
      property strVe2S21: String     Read FRecSer.strVe2S21 Write FRecSer.strVe2S21;
      property strVe2S22: String     Read FRecSer.strVe2S22 Write FRecSer.strVe2S22;
      property strVe2S23: String     Read FRecSer.strVe2S23 Write FRecSer.strVe2S23;
      property strVe2S24: String     Read FRecSer.strVe2S24 Write FRecSer.strVe2S24;
      property strVe2S25: String     Read FRecSer.strVe2S25 Write FRecSer.strVe2S25;
      property strVe2S26: String     Read FRecSer.strVe2S26 Write FRecSer.strVe2S26;
      property strVe2S27: String     Read FRecSer.strVe2S27 Write FRecSer.strVe2S27;
      property strVe2S28: String     Read FRecSer.strVe2S28 Write FRecSer.strVe2S28;
      property strVe2S29: String     Read FRecSer.strVe2S29 Write FRecSer.strVe2S29;
      property strVe2S30: String     Read FRecSer.strVe2S30 Write FRecSer.strVe2S30;

      property intNroPro: Integer    Read FRecSer.intNroPro Write FRecSer.intNroPro;
      property dtaSerIni: TDate      Read FRecSer.dtaSerIni Write FRecSer.dtaSerIni;
      property dtaSerFin: TDate      Read FRecSer.dtaSerFin Write FRecSer.dtaSerFin;
      property strSerObs: String     Read FRecSer.strSerObs Write FRecSer.strSerObs;
      property intPraEnt: Integer    Read FRecSer.intPraEnt Write FRecSer.intPraEnt;
      property fltTotSer: Double     Read FRecSer.fltTotSer Write FRecSer.fltTotSer;
      property fltPerIss: Double     Read FRecSer.fltPerIss Write FRecSer.fltPerIss;
      property fltRedIss: Double     Read FRecSer.fltRedIss Write FRecSer.fltRedIss;
      property fltDedIss: Double     Read FRecSer.fltDedIss Write FRecSer.fltDedIss;
      property fltBasIss: Double     Read FRecSer.fltBasIss Write FRecSer.fltBasIss;
      property fltValIss: Double     Read FRecSer.fltValIss Write FRecSer.fltValIss;
      property strNroCEI: String     Read FRecSer.strNroCEI Write FRecSer.strNroCEI;// Número do CEI - Serviço

      property dtaDtAgeS: TDate      Read FRecSer.dtaDtAgeS Write FRecSer.dtaDtAgeS;
      property horHrAgeS: TDateTime  Read FRecSer.horHrAgeS Write FRecSer.horHrAgeS;
      property dtaDtEntS: TDate      Read FRecSer.dtaDtEntS Write FRecSer.dtaDtEntS;
      property horHrEntS: TDateTime  Read FRecSer.horHrEntS Write FRecSer.horHrEntS;

      property strDisSer: String     Read FRecSer.strDisSer Write FRecSer.strDisSer;
      property strMunPre: String     Read FRecSer.strMunPre Write FRecSer.strMunPre;
      property strNatSer: String     Read FRecSer.strNatSer Write FRecSer.strNatSer;
  end;

Type
  TDividirItensMeiaNota = class
    private
      FItensVenda      : TMatrizFechamento;
      FItensMeiaNota   : TMatrizFechamento;
      FItensNotaNormal : TMatrizFechamento;

      FTipoPedido: String;
      FEspecieDocumento: String;
      FMeiaNotaComNotaNormal: Boolean;
      FFatorQtdeMeiaNotaNotaNormal: Double;

      procedure pAcertaTotaisItem(var   itemNovo    : TDadosFechamento;
                                  const itemOriginal: TDadosFechamento);

      procedure pAcertaItensDocumentoSenha1MeiaNota;
      procedure pAcertaItensDocumentoSenha2MeiaNota;

      function fAplicarFator: Boolean;
      function fQuantidadeJaEmitidaSenha2(intAutInc: Integer): Double;

    public
      constructor Create(arrMatItens: TMatrizFechamento; strEspDoc, strTipPed: String;
        blnMeiaNotaComNotaNormal: Boolean; fltFatorQtdeMeiaNotaNotaNormal: Double);

      procedure pDividirMatrizItens;

      property arrItensMeiaNota: TMatrizFechamento Read FItensMeiaNota;
      property arrItensNotaNormal: TMatrizFechamento Read FItensNotaNormal;
  end;

Type
  TFiltroEmpresa = (opTodasEmpresas, opPropriaEmpresa, opOutraEmpresa);
  TFiltroLocalRetira = (opLocalRetiraTodas, opLocalRetiraCaixa, opLocalRetiraExpedicao, opLocalRetiraBalcao, opLocalRetiraBalcao2);

Type
  TFilterItem = function(const item: TDadosFechamento): Boolean of object;

Type
  TFiltersItem = class
    Private
      FEmpresaItem: String;
      FEmpresaExpedicao: String;
      FGrupoProdutos: String;
      FMeiaNota: Boolean;
      FSelAbs: Boolean;
      FRegEsp: Boolean;
      FCilVas: Boolean;
      FOpcAbs: TOpcaoAbastecimentoItem;
      FdtaDtEntr: TDateTime;
      FstrCodVen: String;
      FDesmembraRegEsp: Boolean;
      function fConsideraBrinde(const item: TDadosFechamento): Boolean;
      function fEhEntregaFuturaClienteVaiRetirar(const item: TDadosFechamento): Boolean;
    public
      function fFiltraEmpresa(const item: TDadosFechamento): Boolean;
      function fFiltraGrupoProdutos(const item: TDadosFechamento): Boolean;
      function fFiltraMeiaNota(const item: TDadosFechamento): Boolean;
      function fFiltraSelAbastecimento(const item: TDadosFechamento): Boolean;
      function fFiltraOpcAbastecimento(const item: TDadosFechamento): Boolean;
      function fFiltraRegimeEspecial(const item: TDadosFechamento): Boolean;
      function fFiltraServico(const item: TDadosFechamento): Boolean;
      function fFiltraRetira(const item: TDadosFechamento): Boolean;
      function fFiltraRetiraCaixa(const item: TDadosFechamento): Boolean;
      function fFiltraRetiraBalcao(const item: TDadosFechamento): Boolean;
      function fFiltraRetiraBalcao2(const item: TDadosFechamento): Boolean;
      function fFiltraRetiraexpedicao(const item: TDadosFechamento): Boolean;
      function fFiltraEntrega(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaImediata(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaFutura(const item: TDadosFechamento): Boolean;
      function fFiltraDataEntrega(const item: TDadosFechamento): Boolean;
      function fFiltraProdutoBrinde(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaDesconsiderandoBrinde(const item: TDadosFechamento): Boolean;
      function fFiltraCodigoVendedor(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaFuturaFaltaProduto(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaFuturaAguardandoCliente(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaFuturaPrevisaoEntrega(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaFuturaPrevisaoAguardandoCliente(const item: TDadosFechamento): Boolean;
      function fFiltraEntregaDesconsiderandoEntregaFuturaClienteVaiRetirar(const item: TDadosFechamento): Boolean;
      function fFiltraCilindroVasilhame(const item: TDadosFechamento): Boolean;
      function fFiltraRetiraCaixaBalcao(const item: TDadosFechamento): Boolean;

      property strEmpresaItem: String Read FEmpresaItem Write FEmpresaItem;
      property strEmpresaExpedicao: String Read FEmpresaExpedicao Write FEmpresaExpedicao;
      property strGrupoProdutos: String Read FGrupoProdutos Write FGrupoProdutos;
      property blnMeiaNota: Boolean Read FMeiaNota Write FMeiaNota;
      property blnSelAbastecimento: Boolean Read FSelAbs Write FSelAbs;
      property blnRegEsp: Boolean Read FRegEsp Write FRegEsp;
      property opcAbastecimento: TOpcaoAbastecimentoItem Read FOpcAbs Write FOpcAbs;
      property dtaDtEntr: TDateTime Read FdtaDtEntr Write FdtaDtEntr;
      property strCodVenD: String Read FstrCodVen Write FstrCodVen;
      property blnCilVas: Boolean Read FCilVas Write FCilVas;
      property blnDesmembraRegEsp: Boolean read FDesmembraRegEsp write FDesmembraRegEsp;
  end;

Type
  TFilterMatrizItens = class
    private
      FItens: TMatrizFechamento;
      FItensTmp: TMatrizFechamento;
    public
      constructor Create(const Itens: TMatrizFechamento);
      procedure pDesfazerFiltros;
      function fFiltrar(filtro: TFilterItem): TFilterMatrizItens; overload;
      function fFiltrar(filtros: Array Of TFilterItem): TFilterMatrizItens; overload;
      function fFiltrarMatriz(filtro: array of TFilterItem): TFilterMatrizItens; overload;
      property MatrizItens: TMatrizFechamento Read FItensTmp;
  end;

Type
  TArrLivFis = Array [1..5] Of TRegLivroFiscal;
  PArrLivFis = ^TArrLivFis;

Type
  TDesmembrarMatrizItens = class
    private
      FItensOri: TMatrizFechamento;
      FMatrizes: TMatrizesFechamento;
      FServicosOri: TDadosServicos;
      FArrServicos: TArrDadosServicos;
      FInformacoes: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF};
      FArrTipoMatrizDesmembrada: TArrTipoMatrizDesmembrada;
      FEntregaImediataPorGrupoProdutos: Boolean;
      FEntregaImediataPorDataDeEntrega: Boolean;
      FEntregaImediataPorDataDeEntregaComRotaPorPedido: Boolean;
      FDesmembraPorVendedor: Boolean;
      FstrOpcDoc: String;
      FDesmembraRegEsp: Boolean;
      FDesmembraPorCFG_ITEDOC: Boolean;
      FVerificaDesmembramentoDeBrinde: Boolean;
      FVerificaDesmembramentoLimiteExcedidoLivro : Boolean;
      procedure pAddMatriz(const matriz: TMatrizFechamento; strInformacao: String; TipoMatriz: TTipoMatrizDesmembrada; recServicos: TDadosServicos);
      procedure pLimparMatrizesDesmembramento;
      procedure pCopiaArrays(var AMatrizes: TMatrizesFechamento; var AArrServicos: TArrDadosServicos; var AInformacoes: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF}; var AArrTipoMatrizDesmembrada: TArrTipoMatrizDesmembrada);
      procedure pDesmembrarMatrizesItensPorCFG_ITEDOC;
      procedure pDesmembrarMatrizesItensPorLimiteExcedidoLivroFiscal;
    public
      Constructor Create(const Itens: TMatrizFechamento;
                         const recServicos: TDadosServicos;
                         const blnEntregaImediataPorGrupoProdutos: Boolean;
                         const blnEntregaImediataPorDataDeEntrega: Boolean;
                         const blnEntregaImediataPorDataDeEntregaComRotaPorPedido: Boolean;
                         const blnDesmembraPorVendedor: Boolean = False;
                         const blnDesmembraRegEsp: Boolean = True;
                         const strOpcDoc: String = '';
                         const blnDesmembraPorCFG_ITEDOC: Boolean=False);

      function fTemMatrizDoTipo(TipoMatriz: TTipoMatrizDesmembrada): Boolean;
      function fTemMatrizSomenteItensBrinde():Boolean;
      procedure pDesmembrarMatrizItens;

      class function fDesdobroImpostos(fltAlqIcmIte: Double; strClaFisIte: String; Var intIndice: Integer; const arrLivroFiscal: TArrLivFis): Boolean;
      class function fExcedeuLimiteClassificacoesLivroFiscal(const AMatriz: TMatrizFechamento): Boolean;

      property MatrizesItens : TMatrizesFechamento Read FMatrizes;
      property MatrizInfItens: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF} Read FInformacoes;
      property MatrizOriginal: TMatrizFechamento   Read FItensOri;
      property MatrizServicos: TArrDadosServicos   Read FArrServicos;
      property MatrizTipoMatriz: TArrTipoMatrizDesmembrada Read FArrTipoMatrizDesmembrada;
      property blnVerificaDesmembramentoDeBrinde : Boolean read FVerificaDesmembramentoDeBrinde write FVerificaDesmembramentoDeBrinde;
      property blnVerificaDesmembramentoLimiteExcedidoLivro : Boolean read FVerificaDesmembramentoLimiteExcedidoLivro write FVerificaDesmembramentoLimiteExcedidoLivro;
  end;


Type
  TStatusGravacaoVenda = (stgAguardandoGravacao, stgSimulandoGravacao, stgRealizandoGravacao);

Type
  TInfoDocVenda = record
    strEspDoc: String;
    strTipDoc: String;
    fltTotGer: Double;
    fltTotDup: Double;
    fltTotUti: Double;
    arrDupDoc: TarrDuplicata;
    arrItens : TMatrizFechamento;
  end;

Type
  TArrInfoDocVenda = Array Of TInfoDocVenda;

Type
  TAcertaVencimentosMeiaNotaComNotaNormal = class
    private
      FStatus        : TStatusGravacaoVenda;
      FArrDocsVencOri: TArrInfoDocVenda;
      FArrDocsVencNov: TArrInfoDocVenda;

      function GetMaxParcelasAutcom: Integer;

      function GetTemMeiaNotaComNotaNormal: Boolean;

      function fGetTotalDuplicatas(arrDuplicatas: TarrDuplicata): Double;
      function fGetCondicaoPagamentoDuplicatas(arrDuplicatas: TarrDuplicata): String;

      function fRecalcularVencimentosParaEmissaoBoleto(strConPag: String): Boolean;

      function fDigitaDuplicata(strConPag: String; fltTotDup: Double; Var arrDupDoc: untTypesSistema.TarrDuplicata): Boolean;

      procedure pIniciarArrayDocumentosVencimentosNovos;

      procedure pVerificaAcertaValorMinimoParcelasBoleto(var documento: TInfoDocVenda);

    public
      constructor Create;

      procedure pAdicionarInformacoesVenda(intIndDoc: Integer; strEspDoc, strTipDoc: String; arrDupDoc: TarrDuplicata; fltTotGer: Double; arrItens: TMatrizFechamento);
      procedure pCarregarNovosVencimentos(intIndDoc: Integer; Var strConPag: String; Var arrDupDoc: TarrDuplicata);

      function fSetarStatus(status: TStatusGravacaoVenda): TAcertaVencimentosMeiaNotaComNotaNormal;

      property StatusGravacaoVenda: TStatusGravacaoVenda Read FStatus;
      property blnTemMeiaNotaComNotaNormal: Boolean Read GetTemMeiaNotaComNotaNormal;

      property arrInfoDocumentos: TArrInfoDocVenda Read FArrDocsVencOri;
  end;

Type
  TOpcaoCustoReal = (opCalcular, opVariaveis, opClientItens);
  TOpcaoMargemMinimaLiquida = (omCalcular, omVariaveis, omClientItens);

  TOpcPrecoEstrutura = (Preco_de_Custo,
                        Preco_de_Custo_Real,
                        Preco_de_Venda,
                        Trava_Preco_Margem_Minima_Liquida,
                        Trava_Preco_de_Custo_Real);

  TPAdicionaItem = procedure(strCodIte, strDesIte: String; fltQtdIte, fltUnitar: Double; strCodUni: String = ''; strCodAca: String = ''; strEmpAca: String = '') of object;
  TOnProcessaItem = procedure(const item: TDadosFechamento; index, count: Integer; AInfo: String = '') of object;

  TPCancNFEspecial = procedure(strMensagem: String = '') of object;

  TImprimePdOrSep = (imImprimeSemPergutar, imPerguntaSeImprime, imNaoImprime);
  TDadosImprimePdOrSep = class
  public
    imImpDoc: TImprimePdOrSep;
    intQtdVia: Integer;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    blnExibirTotalOrcamento : Boolean;
    blnEnviarEmail : Boolean;
  End;

Type
  TProfissionalVenda = record
    strCodDiv: String;
    fltQtdPon: Double;
  end;

Type
  TProfissionaisVenda = Array Of TProfissionalVenda;

Type
  TDocumento = record
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strSerie_: String;
    strTip_FC: String;
  end;

Type
  TDocumentos = Array of TDocumento;

Type
  TFatDocInfo = record
    Numero: String;
    Especie: String;
    Empresa: String;
    Cliente: String;
    Serie  : String;
  end;

Type
  TFatDocInfoArray = Array of TFatDocInfo;

Type
  TDocumentoConf = class
    public
      strNumDoc,
      strEspDoc,
      strCodEmp,
      strCodCli: String;
  end;


Type
  TDadosImpressaoVenda = record
    strOpcDoc,
    strNumDoc,
    strEspDoc,
    strEmpDoc,
    strSerFsc,
    strCodCli,
    strTip_FC,
    strCliNom,
    strCliCgc,
    strCliIes,
    strCli_Rg,
    strCliEnd,
    strCliNum,
    strCliBai,
    strCliCom,
    strCliCep,
    strCliCid,
    strCliEst,
    strCodVen,
    strNomVen,
    strConPag,
    strCodCnd,
    strCodFpg,
    strMen001,
    strMen002,
    strEntFut,
    strEntFat,
    strNumOrc,
    strEspOrc,
    strEmpOrc,
    strCodAca,
    strIdePro,
    strRequisocoesPD,
    strDocsConf,
    strDocsConfTE,
    strDocsConfIF,
    strCupCon,
    strCupCha,
    strCupConDev,
    strCodPor,
    strCodigoBarrasContrato,
    strNomImp,
    strCliNFV,
    strCGCNFV,
    strIE_NFV,
    strNroNFV,
    strDtaNFV,
    strClaFis: String;
    fltValNFV: Double;
    strPorBol,
    strBanBol,
    strBcoIni: String;
    intCodCar: Integer;
    intNosNum: Int64;
    fltValMor: Double;
    recEndEnt: TRecEnderecoEntrega;
    strEndCob,
    strBaiCob,
    strCepCob,
    strCidCob,
    strEstCob: String;
    intQtdTra: Integer;
    intQtdTraSepExc: Integer;
    intQtdTraSepNExc: Integer;
    fltPesBru,
    fltPesLiq,
    fltTotIcm,
    fltTotPro,
    fltTotGer,
    fltDesEsp,
    fltTotDeb,
    fltDupRec,
    fltValAdt,
    fltBolAdt: Double;
    blnBolVen: Boolean;
    fltBolEnv,
    fltImpPag,
    fltPeImPg,
    fltFedImp,
    fltPeImFd,
    fltEstImp,
    fltPeImEs,
    fltMunImp,
    fltPeImMn: Double;
    arrMatItens: TMatrizFechamento;
    strOriF11: String;
    Duplicatas,
    DuplicatasParaF11: TDadosDuplicatas;
    strPonImp: String;
    blnGerNfe,
    blnEnt_CD,
    blnValTot,
    blnPedBlo,
    blnPedPen,
    blnMenFor,
    blnLibCnf,
    blnNotEsp,
    blnMeiaNota,
    blnBaiEntFut,
    blnBaixaEmprestimos,
    blnConfOrcamento,
    blnImportacaoSpedPisCofins,
    blnImpReq,
    blnSepFut,
    blnExpedi,
    blnImprimeSep,
    blnImprimeTicketIF,
    blnImprimeAmostraVeiculo,
    blnImprimeEtiqDespacho,
    blnEntregaImediataEmNovoPedido,
    blnEmitirNovoPedidoEntregaCD,
    blnRetiraOutraLojaEmNovoPedido: Boolean;
    blnRetiraMesmaLojaEmNovoPedido: Boolean;
    blnRetiraExpedicaoEmNovoPedido: Boolean;
    blnAbastecTransfReqEmNovoPedido: Boolean;
    opcComSemPreco: TImpressaoComSemPrecoOrPd;
    Profissionais: TProfissionaisVenda;
    cdsLogSep: TUniClientDataSet;
    objFatVenda: Pointer;
    blnImpSepGarantia: Boolean;
    blnBolPdf: Boolean;
    blnEnvMai: Boolean;
    dtaDtaEnt: TDate;
    strHorEnt: String;
    strCodLse: String;
    strCodLsePorSetor: String;
    blnPedOrcBrinde: Boolean;
    strOpcDocTrue: String;
    strImportacaoGeoSales: String;
    blnItensDiferentes: Boolean;
    strMensNovo,
    strMensExcluido: String;
    strMen003,
    strMen004,
    strMen005: String;
    blnQtdOri : Boolean;
    arrDuplicatasCND: TarrDuplicata;
    strNumRom: String;
    blnNotaPro : Boolean;
    dtaGraPed: TDateTime;
    dtaSepFut: TDate;
    hraSepFut: TTime;
    blnExpediMult : Boolean;
    blnPedInterno: Boolean; //numpok vazio
    blnNotaFatFF: Boolean;
    strCodIct: String;
    blnPicOut : Boolean;
    blnExpFatAut: Boolean;
    blnFaturadorAutomatico: Boolean;
  end;

Type
  TCalcCustoReal = Class
    private
      FUnitar,
      FPreCus,
      FIcmSai,
      FImpFed,
      FOutVal,
      FDesOpe,
      FIcmPav,
      FDifal,
      FFcp: Double;
      FCalcST: Boolean;
      FFrete: Double;
    public
      constructor Create;
    published
      property fltUnitar: Double     Read FUnitar Write FUnitar;
      property fltPreCus: Double     Read FPreCus Write FPreCus;
      property fltIcmSai: Double     Read FIcmSai Write FIcmSai;
      property fltImpFed: Double     Read FImpFed Write FImpFed;
      property fltOutVal: Double     Read FOutVal Write FOutVal;
      property fltDesOpe: Double     Read FDesOpe Write FDesOpe;
      property fltIcmPav: Double     Read FIcmPav Write FIcmPav;
      property blnCalcSt: Boolean    Read FCalcST Write FCalcST;
      property fltDifal : Double     Read FDifal  Write FDifal;
      property fltFcp   : Double     Read FFcp    Write FFcp;
      property fltFrete : Double     Read FFrete  Write FFrete;
  End;

Type
  TPrecos = Record
    fltPreVen: Double;
    fltTotVen: Double;
    fltQtdPro: Double;
    fltPreVenSemJuros : Double;
    fltTotVenSemJuros : Double;
  End;

  TarrPrecos = Array Of TPrecos;

  TImpostosSubItensEstrutura = Record
    strCodIte: String; //Item Estrutura Pai
    strEmpIte: String; //Empresa do Item Estrutura Pai
    fltUniPai: Double; //Valor Unitário Pai
    fltQtdPai: Double; //Qtde Pai

    // Array de valores de preços calculados para ajustar o valor de venda
    // que é obitido no momento de realizar os calculos dos impostos
    arrPrecos: TarrPrecos;

    //Os valores abaixo são dos subitens do item estrutura pai
    fltOutVal: Double;
    //Os valores abaixo são o % dos subitens do item estrutura pai
    fltImpFed: Double;
    fltIcmSai: Double;
    fltDesOpe: Double;
End;

Type
  TRetornaPrecoCusto = function(opcPreco: TOpcPrecoEstrutura; strCodIte: String;
        fltPreAtu: Double; strTabPre: String = ''; ccrCustoReal: TCalcCustoReal = Nil;
        blnItemEspecial: Boolean = False; fltTaxaJuros : Double = 0): Double of object;
  TGetAlqFcpIcms = function(strCodIte, strCodAbf, strCodFis: String; fltAlqIcm, fltValIte: Double): Double of object;
  TCalculaCustoBruto = function(fltPreVen, fltPreLiq, fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Double): Double of object;
  TAlqDifIcmsPrecoDinamico = function (strCodIte, strCodAbf, strCodFis: String; fltAlqIcm: Double): Double of object;

Type
  TSubItemEstruturaAtual = Record
    strCodigo,
    strPromoc: String;
  end;

Type
  TSubItemEstrutura = Record
    strCodigo,
    strImpLis: String;
    fltSaldos,
    fltQtdSub,
    fltQtdTot,
    fltPreCus,
    fltTotCus,
    fltTotCu2,
    fltPreVen,
    fltPreMin,
    fltTotVen,
    fltTotMin: Double;
    fltQtdPec,
    fltComPec,
    fltLarPec,
    fltEspPec: Double;
    strAparel,
    strBenefi: String;
    fltPerApa,
    fltPerBen,
    fltOutVal,
    fltIcmSai,
    fltImpFed,
    fltDesOpe,
    fltPreMed,
    fltPreUlt,
    fltImpUlt: Double;
    strEmpCar: String; //empresa de carregamento
    fltPreVenSemJuros : Double;
    fltTotVenSemJuros : Double;
  end;

Type
  TConsignacoes = Class
  private
    FblnDeveGravar : Boolean;
  public
    arrConsignacoes: Array Of TRecConsignacao;

    constructor Create;
    function fGetTotalDesEsp: Double;

    property blnDeveGravar : Boolean Read FblnDeveGravar Write FblnDeveGravar;
  end;

  TIcmsImobilizado = class(TComponent)
    private
      recIcmsImobilizado: TRecIcmsImobilizado;
      arrIcmsImobilizado: Array Of TRecIcmsImobilizado;

      function GetIndex: Integer;
      function GetIndIte: Integer;
      function GetInfVal: Boolean;
      function GetBasIcm: Double;
      function GetAlqIcm: Double;
      function GetValIcm: Double;

      procedure SetIndIte(Value: Integer);
      procedure SetInfVal(Value: Boolean);
      procedure SetBasIcm(Value: Double);
      procedure SetAlqIcm(Value: Double);
    public
      procedure pLimpaValores;
    published
      property intAutInc: Integer read GetIndIte write SetIndIte;
      property blnInfVal: Boolean read GetInfVal write SetInfVal;
      property fltBasIcm: Double read GetBasIcm write SetBasIcm;
      property fltAlqIcm: Double read GetAlqIcm write SetAlqIcm;
      property fltValIcm: Double read GetValIcm;
    end;

  TDadosItemNotaEspelho = Record
  private
    FfltDesAce: Double;
    FfltDesEsp: Double;
    function GetDesAce: Double;
    procedure SetDesAce(Value: Double);
    function GetDesEsp: Double;
    procedure SetDesEsp(Value: Double);
  public

    strItemID: String;

    fltQtdIte: Double;
    fltUnitar: Double;
    fltUniDig: Double;
    fltUniOri: Double;
    fltUniVis: Double;
    fltTotIte: Double;
    fltValFre: Double;

    fltOutIcm: Double;
    fltIseIcm: Double;
    fltTotMed: Double;

    fltImpPag: Double;
    fltFedImp: Double;
    fltEstImp: Double;
    fltMunImp: Double;

    strClaFis: String;
    strCodFis: String;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;

    strCstIpi: String;
    strEnqIpi: String;
    fltBasIpi: Double;
    fltAlqIpi: Double;
    fltValIpi: Double;

    fltBasRet: Double;
    fltValRet: Double;
    fltAlqRet: Double;

    strCstPis: String;
    strNatPis: String;
    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;

    strCstCof: String;
    strNatCof: String;
    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;

    fltPerFcp: Double;
    fltBasFcp: Double;
    fltValFcp: Double;

    fltPerFcpST: Double;
    fltBasFcpST: Double;
    fltValFcpST: Double;

    fltDesOpe: Double;
    fltImpFed: Double;
    fltIcmSai: Double;
    fltOutVal: Double;

    fltTotCus,
    fltTotCu2 : Double;

    fltVrdIcm : Double;
    strMtdIcm : String;

    strDvfCodFis: String;

    fltDvfBasIcm: Double;
    fltDvfAlqIcm: Double;
    fltDvfValIcm: Double;

    fltDvfPerFcp: Double;
    fltDvfBasFcp: Double;
    fltDvfValFcp: Double;

    fltDvfPfcpST: Double;
    fltDvfBfcpST: Double;
    fltDvfVfcpST: Double;

    fltDvfPST: Double;
    fltDvfBST: Double;
    fltDvfVST: Double;
    fltFreSug: Double;
    fltFreCot: Double;

    blnDevFilPD : Boolean;
    fltPerRed: Double;
    fltPerDif: Double;

    fltPeBaST: Double;
    fltValIva: Double;

    strIdDest: String;

    blnCarregouDadosDoXml : Boolean;

    property fltDesAce: Double Read GetDesAce Write SetDesAce;
    property fltDesEsp: Double Read GetDesEsp Write SetDesEsp;

  End;

  TItemNotaEspelho = Class
    protected
      FDadosItem: TDadosItemNotaEspelho;
      FDadosCalc: TDadosItemNotaEspelho;
      procedure pAplicarFator(fltFator: Double);
      procedure pCalculaImpostosProporcionalExec(fltQtdIte: Double);
    public
      constructor Create(dadosItem: TDadosItemNotaEspelho);virtual;
      procedure pCalculaImpostosProporcional(fltQtdIte: Double);Virtual;
    published
      property itemOrig: TDadosItemNotaEspelho Read FDadosItem;
      property itemCalc: TDadosItemNotaEspelho Read FDadosCalc;
    end;

  TItensNotaEspelho = class(TComponent)
    private
      FUtilizarIcmsDoXmlDeEntrada : Boolean;
      FblnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho: Boolean;
      FTabDev: String;
      FOpcDoc: String;
      FOpcDocOri: String;
      FEmpForFil: String;
      ArrItemsNE: Array Of TItemNotaEspelho;
      procedure pAddItem(itemNE: TItemNotaEspelho);
      function fLoadItem(strID: String): TItemNotaEspelho;
      function fSQLNotaEspelho(const strTabelaBaseFornecedoraFilial: String; const blnVerificarPD: Boolean = False): String;
    Protected
      function GetItem(strID: String): TItemNotaEspelho;
      function fNovoItemNotaEspelho(dadosItem: TDadosItemNotaEspelho): TItemNotaEspelho; Virtual;
      function fTabela: String;

    public
      blnRecCliGarantia: Boolean;
      constructor Create(AOwner : TComponent);override;
      destructor Destroy; override;
      property Item[Index: String]: TItemNotaEspelho Read GetItem; Default;
      property blnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho: Boolean read FblnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho write FblnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho;
      property strTabDev: String Read FTabDev Write FTabDev;
      property strOpcDoc: String Read FOpcDoc Write FOpcDoc;
      property strOpcDocOri: String Read FOpcDocOri Write FOpcDocOri;
      property strEmpForFil: String Read FEmpForFil Write FEmpForFil;
      property blnUtilizarIcmsDoXmlDeEntrada : Boolean Read FUtilizarIcmsDoXmlDeEntrada Write FUtilizarIcmsDoXmlDeEntrada;
    end;

  TItemNotaEspelhoEnvioFornecedor = class(TItemNotaEspelho)
    protected
      FAlterouValores: Boolean;
      function fAlterouPrecoItem(fltVlrA, fltVlrB: Double): Boolean;
    public
      constructor Create(dadosItem: TDadosItemNotaEspelho);override;
      procedure pAlterarValFre(const Value: Double);
      procedure pAlterarValorItem(pfltTotIte, pfltQtdIte: Double);
      procedure pCalculaImpostosProporcional(fltQtdIte: Double);Override;
      procedure pAplicarAlteracaoPreco(pfltTotIte: Double);
  end;

  TItensNotaEspelhoEnvioFornecedor = class(TItensNotaEspelho)
  Strict Protected
    FIncAlteracao: TStrings;
    function fNovoItemNotaEspelho(dadosItem: TDadosItemNotaEspelho): TItemNotaEspelho; Override;
  public
    destructor Destroy; override;
    procedure pAddListaItensAlterados(pstrIncAlteracao: TStrings);
    function fItemPrecoAlterado(pstrIncEsp: String): Boolean;
    function GetItemCalc(pstrId: String): TItemNotaEspelhoEnvioFornecedor;
  end;

  TValoresDuplicatas = class(TComponent)
    private
      FDuplic: TDadosDuplicatas;
      function fDuplicataValida(intSeqBaiBaixado, intIndex: Integer): Boolean;
      procedure pZerarValores;
    public
      constructor Create(duplicatas: Array Of TArrDigDuplic; intSeqBaiBaixado: Integer); reintroduce;
    published
      function fGetDuplicatas: TarrDuplicata;
      property Duplicatas: TDadosDuplicatas Read FDuplic Write FDuplic;
      property fltValor01: Double Read FDuplic.fltValD01 Write FDuplic.fltValD01;
      property fltValor02: Double Read FDuplic.fltValD02 Write FDuplic.fltValD02;
      property fltValor03: Double Read FDuplic.fltValD03 Write FDuplic.fltValD03;
      property fltValor04: Double Read FDuplic.fltValD04 Write FDuplic.fltValD04;
      property fltValor05: Double Read FDuplic.fltValD05 Write FDuplic.fltValD05;
      property fltValor06: Double Read FDuplic.fltValD06 Write FDuplic.fltValD06;
      property fltValor07: Double Read FDuplic.fltValD07 Write FDuplic.fltValD07;
      property fltValor08: Double Read FDuplic.fltValD08 Write FDuplic.fltValD08;
      property fltValor09: Double Read FDuplic.fltValD09 Write FDuplic.fltValD09;
      property fltValor10: Double Read FDuplic.fltValD10 Write FDuplic.fltValD10;
      property fltValor11: Double Read FDuplic.fltValD11 Write FDuplic.fltValD11;
      property fltValor12: Double Read FDuplic.fltValD12 Write FDuplic.fltValD12;
      property fltValor13: Double Read FDuplic.fltValD13 Write FDuplic.fltValD13;
      property fltValor14: Double Read FDuplic.fltValD14 Write FDuplic.fltValD14;
      property fltValor15: Double Read FDuplic.fltValD15 Write FDuplic.fltValD15;
      property fltValor16: Double Read FDuplic.fltValD16 Write FDuplic.fltValD16;
      property fltValor17: Double Read FDuplic.fltValD17 Write FDuplic.fltValD17;
      property fltValor18: Double Read FDuplic.fltValD18 Write FDuplic.fltValD18;
      property fltValor19: Double Read FDuplic.fltValD19 Write FDuplic.fltValD19;
      property fltValor20: Double Read FDuplic.fltValD20 Write FDuplic.fltValD20;
      property fltValor21: Double Read FDuplic.fltValD21 Write FDuplic.fltValD21;
      property fltValor22: Double Read FDuplic.fltValD22 Write FDuplic.fltValD22;
      property fltValor23: Double Read FDuplic.fltValD23 Write FDuplic.fltValD23;
      property fltValor24: Double Read FDuplic.fltValD24 Write FDuplic.fltValD24;
    End;

Type
  TRecItemPedido = record
    strNumOrc: String;
    strEspOrc: String;
    strEmpOrc: String;
    strCodIte: String;
    intSeqInd: Integer;
    fltQtdOri: Double;
    fltQtdBai: Double;
    fltQtdIte: Double;
    fltDesEsp: Double;    
    fltDesBai: Double;
    blnEntpCD: Boolean;
    strSeqDet: String;
    strIncFut: String;
  end;

Type
  TArrItemPedidos = Array Of TRecItemPedido;
  
Type
  TArrItemPedidosObj = class
    public
      arrItemPedidos: TArrItemPedidos;
  end;    

Type
  TItensPedidos = class
    private
      dicItensPedidos: TDicionario;
      function GetItemPedidos(index: integer): TArrItemPedidos;
    public
      constructor Create;
      destructor Destroy; override;

      procedure pLimpar;
      procedure pAddItem(index: Integer; recItemPedido: TRecItemPedido);

      procedure pAcertaQuantidadeItem(Index: Integer; fltQtdIteNova: Double);

      property ItemPedidos[index: integer]: TArrItemPedidos read GetItemPedidos; Default;
  end;

Type
  TArrDadosImpressoesVenda = Array Of TDadosImpressaoVenda;

Type
  TRecBackupVar = Record
    strNomVar: String;
    varValVar: Variant;
  End;

Type
  TObjectBackupVar = class(TInterfacedObject, IInterface)
    private
      FObj: TObject;
      FVar: TDictionary<String,Variant>;
    public
      constructor Create(AObj: TObject);
      destructor Destroy; override;
      procedure SetBackupVar(ANames: Array Of String);
      procedure GetBackupVar(ANames: Array Of String);
  end;

Type
  {Utilizado na Venda Normal!}
  TpCarregaEstrutura = procedure(strCodIte, strEmpIte  : String;
                                 fltQtdIte,
                                 fltDesCon  : Double;
                                 fltTotIte  : Double = 0;
                                 fltTotOri  : Double = 0;
                                 blnConcreto: Boolean = False) of object;

  {Utilizado na Expedição e Caixa F11!}
  TfCarregaEstrutura = function(Item : TDadosFechamento;
                                blnBaixaSubItemEstrutura: Boolean) : Boolean of object;

Const
  TRAVA_MINIMO_PRECO_CUSTO = 'C';
  TRAVA_MINIMO_CUSTO_REAL  = 'R';

  {blnZeraPercentuaisDesconto = True}
  VARIAVEIS_ZERA_PERCENTUAIS_DESCONTO_TRUE: Array[0..11] Of String =
    ('fltValFre', 'fltDesAce', 'fltDesEsp', 'fltTotDes', 'fltPorDes', 'strTipPed',
     'strTipOpe', 'strEspDoc', 'fltDesOrg', 'fltQtdBom', 'fltPrcBom', 'fltTotBom');

  ARRAY_CONFIG_EMPRESA_DESTINO_IMPOSTOS: Array[0..64] of string = (
    'IFSN41', 'IFPR41', 'ZRICUC', 'CLASUB', 'TRIFRE', 'TRIACE', 'CONIPI', 'IPIFRE',
    'DEDDES', 'BSTPRE', 'MODBEN', 'IPSTMF', 'CALSUB', 'HEFCOE', 'IMPDIR', 'CAL_ST',
    'UTIABI', 'TCASOP', 'CALRCF', 'REBAST', 'MIN_ST', 'ISEIMP', 'ALTLOJ', 'USNFCE',
    'EMPDIS', 'ALPISP', 'ALCOFP', 'ZERSNO', 'ZERSIM', 'ZERCIF', 'PRACST', 'FAMECO',
    'FATCON', 'RETCON', 'TPNFCR', 'IMPFRE', 'IMPSUB', 'IMPIPI', 'ISSSER', 'PERISS',
    'REDISS', 'IMPCF4', 'RAICF4', 'MARMKP', 'AUTCEN', 'SERTER', 'ITESER', 'BEN_ST',
    'BBSFCP', 'COCURE', 'SIMPAU', 'ICMSIM', 'EXI_ST', 'IMPDIG', 'UTIAMP', 'DIFREM',
    'DIFDES', 'DIFPST', 'DFRDAF', 'DTADFL', 'BASDFL', 'ICMIND', 'TIPABF', 'CLASUF', 'IMPCBS');

implementation

{$IFDEF LINUX}
{$ELSE}
uses
  untFatImpressao,
  untDuplicatas,
  untFuncoesGenerica,
  untMargemMinima;
{$ENDIF}

{ TItemNotaEntrada }

constructor TItemNotaEspelho.Create(dadosItem: TDadosItemNotaEspelho);
begin
  FDadosItem := dadosItem;
  FDadosCalc := dadosItem;
end;

procedure TItemNotaEspelho.pCalculaImpostosProporcional(fltQtdIte: Double);
begin
  FDadosCalc := FDadosItem;
  pCalculaImpostosProporcionalExec(fltQtdIte);
end;

procedure TItemNotaEspelho.pCalculaImpostosProporcionalExec(fltQtdIte: Double);
  Var
    fltFator,
    fltValCalc,
    fltValOrig,
    fltDifere: Double;
begin
  fltFator := (fltQtdIte / FDadosItem.fltQtdIte);

  fltValCalc := (FDadosCalc.fltTotIte * fltFator);
  fltValOrig := (FDadosCalc.fltUnitar * FDadosCalc.fltQtdIte) * fltFator;
  fltDifere := fltValCalc - fltValOrig;

  FDadosCalc.fltTotIte := fFormataFloat(IIF(InRange(fltDifere, -0.004, 0.004), fltValOrig, fltValCalc), 2);

  pAplicarFator(fltFator);
end;

procedure TItemNotaEspelho.pAplicarFator(fltFator: Double);
begin
  With FDadosCalc Do
  Begin
    fltUnitar := fFormataFloat(fltUnitar * fltFator,4);
    fltUniDig := fFormataFloat(fltUniDig * fltFator,4);
    fltUniOri := fFormataFloat(fltUniOri * fltFator,4);
    fltUniVis := fFormataFloat(fltUniVis * fltFator,4);

    fltOutIcm := fFormataFloat(fltOutIcm * fltFator,2);
    fltIseIcm := fFormataFloat(fltIseIcm * fltFator,2);
    fltTotMed := fFormataFloat(fltTotMed * fltFator,2);

    fltImpPag := fFormataFloat(fltImpPag * fltFator,2);
    fltFedImp := fFormataFloat(fltFedImp * fltFator,2);
    fltEstImp := fFormataFloat(fltEstImp * fltFator,2);
    fltMunImp := fFormataFloat(fltMunImp * fltFator,2);

    fltFreSug := fFormataFloat(fltFreSug * fltFator,2);
    fltFreCot := fFormataFloat(fltFreCot * fltFator,2);

    fltValFre := fFormataFloat(fltValFre * fltFator,2);
    fltDesAce := fFormataFloat(fltDesAce * fltFator,2);
    fltDesEsp := fFormataFloat(fltDesEsp * fltFator,2);

    fltBasIcm := fFormataFloat(fltBasIcm * fltFator,2);
    fltValIcm := fFormataFloat(fltValIcm * fltFator,2);

    fltBasIpi := fFormataFloat(fltBasIpi * fltFator,2);
    fltValIpi := fFormataFloat(fltValIpi * fltFator,2);

    fltBasRet := fFormataFloat(fltBasRet * fltFator,2);
    fltValRet := fFormataFloat(fltValRet * fltFator,2);

    fltBasPis := fFormataFloat(fltBasPis * fltFator,2);
    fltValPis := fFormataFloat(fltValPis * fltFator,2);

    fltBasCof := fFormataFloat(fltBasCof * fltFator,2);
    fltValCof := fFormataFloat(fltValCof * fltFator,2);

    fltBasFcp := fFormataFloat(fltBasFcp * fltFator,2);
    fltValFcp := fFormataFloat(fltValFcp * fltFator,2);

    fltBasFcpST := fFormataFloat(fltBasFcpST * fltFator,2);
    fltValFcpST := fFormataFloat(fltValFcpST * fltFator,2);

    fltDesOpe := fFormataFloat(fltDesOpe * fltFator,2);
    fltImpFed := fFormataFloat(fltImpFed * fltFator,2);
    fltIcmSai := fFormataFloat(fltIcmSai * fltFator,2);
    fltOutVal := fFormataFloat(fltOutVal/FDadosItem.fltQtdIte, 2);

    fltDesOpe := fFormataFloat(((fltDesOpe / ((fltTotIte - fltDesEsp) + fltValFre + fltDesAce)) * 100), 2);
    fltImpFed := fFormataFloat(((fltImpFed / ((fltTotIte - fltDesEsp) + fltValFre + fltDesAce)) * 100), 2);
    fltIcmSai := fFormataFloat(((fltIcmSai / ((fltTotIte - fltDesEsp) + fltValFre + fltDesAce)) * 100), 2);

    fltTotCus := fFormataFloat(fltTotCus * fltFator,2);
    fltTotCu2 := fFormataFloat(fltTotCu2 * fltFator,2);

    fltVrdIcm := fFormataFloat(fltVrdIcm * fltFator,2);

    fltDvfBasIcm := fFormataFloat(fltDvfBasIcm * fltFator,2);
    fltDvfValIcm := fFormataFloat(fltDvfValIcm * fltFator,2);

    fltDvfBasFcp := fFormataFloat(fltDvfBasFcp * fltFator,2);
    fltDvfValFcp := fFormataFloat(fltDvfValFcp * fltFator,2);

    fltDvfBfcpST := fFormataFloat(fltDvfBfcpST * fltFator,2);
    fltDvfVfcpST := fFormataFloat(fltDvfVfcpST * fltFator,2);

    fltDvfBST := fFormataFloat(fltDvfBST * fltFator,2);
    fltDvfVST := fFormataFloat(fltDvfVST * fltFator,2);

    If (fltBasIcm > 0) And (RoundTo(Abs((fltTotIte - fltDesEsp) - fltBasIcm), -2) = 0.01) Then
    Begin
      fltBasIcm := (fltTotIte - fltDesEsp);
    End;
  End;
end;

{ TItensNotaEntrada }

constructor TItensNotaEspelho.Create(AOwner: TComponent);
begin
  inherited;
  blnRecCliGarantia := False;
  FUtilizarIcmsDoXmlDeEntrada := False;
  blnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho := False;
  FTabDev := '';
  FOpcDocOri := '';
  FOpcDoc := '';
end;

destructor TItensNotaEspelho.Destroy;
  Var
    item: TItemNotaEspelho;
begin
  For item In ArrItemsNE Do
    If Assigned(item) Then
      item.Destroy;

  SetLength(ArrItemsNE, 0);

  inherited;
end;

function TItensNotaEspelho.GetItem(strID: String): TItemNotaEspelho;
  Var
    item: TItemNotaEspelho;
begin
  Result := Nil;

  For item In ArrItemsNE Do
  Begin
    If SameStr(item.itemOrig.strItemID, strID) Then
    Begin
      Result := item;
      Break;
    End;
  End;

  If (Result = Nil) Then
    Result := fLoadItem(strID);
end;

procedure TItensNotaEspelho.pAddItem(itemNE: TItemNotaEspelho);
begin
  SetLength(ArrItemsNE, Length(ArrItemsNE)+1);
  ArrItemsNE[Length(ArrItemsNE)-1] := itemNE;
end;

function TItensNotaEspelho.fSQLNotaEspelho(const strTabelaBaseFornecedoraFilial: String; const blnVerificarPD: Boolean = False): String;
  Var
    strTabDetForFil : String;
    strTabTriForFil : String;
    strTabIcdForFil : String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '   A.AUX_OPCDOC, ';
  Result := Result + '   D.DET_QTDITE, ';
  Result := Result + '   D.DET_UNITAR, ';
  Result := Result + '   D.DET_UNIDIG, ';
  Result := Result + '   D.DET_UNIORI, ';
  Result := Result + '   T.DET_UNIVIS, ';
  Result := Result + '   D.DET_TOTITE, ';
  Result := Result + '   D.DET_DESESP, ';
  Result := Result + '   D.DET_TOTFRE, ';
  Result := Result + '   D.DET_DESACE, ';
  Result := Result + '   D.DET_CODFIS, ';
  Result := Result + '   D.DET_CLAFIS, ';

  Result := Result + '   T.DET_OUTICM, ';
  Result := Result + '   T.DET_ISEICM, ';
  Result := Result + '   D.DET_TOTMED, ';

  Result := Result + '   T.DET_IMPPAG, ';
  Result := Result + '   T.DET_FEDIMP, ';
  Result := Result + '   T.DET_ESTIMP, ';
  Result := Result + '   T.DET_MUNIMP, ';
  Result := Result + '   IFNULL(GER_IDDEST,0) AS GER_IDDEST, ';
  Result := Result + '   IFNULL(E.N19_PMVAST,0) AS DET_PMVAST, ';
  Result := Result + '   IFNULL(E.N16B_PDIF,0) AS N16B_PDIF, ';
  Result := Result + '   IF(E.DET_SEQGER IS NULL, "NÃO", "SIM") AS TEM_XML, ';

  If FUtilizarIcmsDoXmlDeEntrada Then
  Begin
    Result := Result + '   IF(E.AUTOINCREM IS NOT NULL, N15_VBC,   D.DET_BASICM) AS DET_BASICM, ';
    Result := Result + '   IF(E.AUTOINCREM IS NOT NULL, N16_PICMS, D.DET_ALQICM) AS DET_ALQICM, ';
    Result := Result + '   IF(E.AUTOINCREM IS NOT NULL, N17_VICMS, D.DET_VALICM) AS DET_VALICM, ';
  End
  Else
    Result := Result + '   D.DET_BASICM, D.DET_ALQICM, D.DET_VALICM, ';

  Result := Result + '   IF(IFNULL(T.DET_VICMDE,0) > 0, IFNULL(T.DET_VICMDE,0), IFNULL(T.DET_VRDICM,0)) AS DET_VRDICM, ';
  Result := Result + '   T.DET_MTDICM, ';

  Result := Result + '   T.DET_DESOPE, ';
  Result := Result + '   T.DET_IMPFED, ';
  Result := Result + '   T.DET_ICMSAI, ';
  Result := Result + '   T.DET_OUTVAL, ';
  Result := Result + '   T.DET_CSTIPI, ';
  Result := Result + '   T.DET_ENQIPI, ';
  Result := Result + '   (D.DET_BASIPI + IFNULL(T.DET_BAEIPI,0)) AS DET_BASIPI, ';
  Result := Result + '   (D.DET_VALIPI + IFNULL(T.DET_VAEIPI,0)) AS DET_VALIPI, ';
  Result := Result + '   IF(IFNULL(D.DET_ALQIPI, 0) = 0, T.DET_ALEIPI, D.DET_ALQIPI) AS DET_ALQIPI, ';
  Result := Result + '   (D.DET_BASRET + IFNULL(T.DET_BAERET,0)) AS DET_BASRET, ';
  Result := Result + '   (D.DET_VALRET + IFNULL(T.DET_VAERET,0)) AS DET_VALRET, ';
  Result := Result + '   IF(IFNULL(E.N14_PREDBC,0) > 0, IFNULL(E.N14_PREDBC,0), IFNULL(D.DET_PERRED,0)) AS DET_PERRED, ';
  Result := Result + '   IF(IFNULL(E.N20_PREBCST,0) > 0, IFNULL(E.N20_PREBCST,0), IFNULL(T.DET_PEBAST,0)) AS DET_PEBAST, ';
  Result := Result + '   IF(IFNULL(E.N22_PICMSST, 0) = 0, IF(IFNULL(D.DET_ALQRET, 0) = 0, T.DET_ALERET, D.DET_ALQRET), E.N22_PICMSST) AS DET_ALQRET, ';

  Result := Result + '   T.DET_CSTPIS, T.DET_NR_PIS, T.DET_BASPIS, T.DET_ALQPIS, T.DET_VALPIS, ';
  Result := Result + '   T.DET_CSTCOF, T.DET_NR_COF, T.DET_BASCOF, T.DET_ALQCOF, T.DET_VALCOF, D.DET_TOTCUS, D.DET_TOTCU2,  ';

  Result := Result + '   IFNULL(I.ICD_PERFCP,0) AS ICD_PERFCP, ';
  Result := Result + '   IFNULL(I.ICD_BASFCP,0) AS ICD_BASFCP, ';
  Result := Result + '   IFNULL(I.ICD_VALFCP,0) AS ICD_VALFCP, ';

  Result := Result + '   IFNULL(T.DET_PFCPST,0) AS DET_PFCPST, ';
  Result := Result + '   IFNULL(T.DET_BFCPST,0) AS DET_BFCPST, ';
  Result := Result + '   IFNULL(T.DET_VFCPST,0) AS DET_VFCPST, ';

  Result := Result + '   DX.DET_CODFIS AS DVF_CODFIS, ';

  Result := Result + '   DX.DET_BASICM AS DVF_BASICM, ';
  Result := Result + '   DX.DET_ALQICM AS DVF_ALQICM, ';
  Result := Result + '   DX.DET_VALICM AS DVF_VALICM, ';

  Result := Result + '   IX.ICD_PERFCP AS DVF_PERFCP, ';
  Result := Result + '   IX.ICD_BASFCP AS DVF_BASFCP, ';
  Result := Result + '   IX.ICD_VALFCP AS DVF_VALFCP, ';

  If (blnVerificarPD) Then
  Begin
    Result := Result + '   (DX.DET_BASRET + IFNULL(TX.DET_BAERET,0)) AS DVF_BASRET, ';
    Result := Result + '   (DX.DET_VALRET + IFNULL(TX.DET_VAERET,0)) AS DVF_VALRET, ';
    Result := Result + '   IF(IFNULL(DX.DET_ALQRET, 0) = 0, TX.DET_ALERET, DX.DET_ALQRET) AS DVF_ALQRET, ';
  End
  Else
  Begin
    Result := Result + '   0.00 AS DVF_BASRET, ';
    Result := Result + '   0.00 AS DVF_VALRET, ';
    Result := Result + '   0.00 AS DVF_ALQRET, ';
  End;

  Result := Result + '   TX.DET_PFCPST AS DVF_PFCPST, ';
  Result := Result + '   TX.DET_BFCPST AS DVF_BFCPST, ';
  Result := Result + '   TX.DET_VFCPST AS DVF_VFCPST, ';
  Result := Result + '    T.DET_FRESUG AS DET_FRESUG, ';
  Result := Result + '    T.DET_FRECOT AS DET_FRECOT  ';

  Result := Result + ' FROM ';
  Result := Result + '   MOVDET D';
  Result := Result + '   INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ';
  Result := Result + '    LEFT JOIN MOVICD I ON D.AUTOINCREM = I.ICD_SEQGER ';
  Result := Result + '    LEFT JOIN AUXMOV A ON A.AUX_SEQGER = D.DET_SEQGER ';

  If (strTabelaBaseFornecedoraFilial = 'NOTGER') then
  begin
    strTabDetForFil := 'NOTDET';
    strTabTriForFil := 'NOTTRI';
    strTabIcdForFil := 'NOTICD';
  end
  else
  begin
    strTabDetForFil := 'MOVDET';
    strTabTriForFil := 'MOVTRI';
    strTabIcdForFil := 'MOVICD';
  end;

  If (blnVerificarPD) Then
  Begin
    Result := Result + '    LEFT JOIN ' + strTabDetForFil + ' PDX ON PDX.DET_NUMDOC = D.DET_NUMDOC AND ';
    Result := Result + '                           PDX.DET_ESPDOC = IF(D.DET_ESPDOC = "PD", "TE", D.DET_ESPDOC) AND ';
    Result := Result + '                           PDX.DET_CODEMP = :EMPFIL      AND ';
    Result := Result + '                           PDX.DET_TIP_FC = "C"          AND ';
    Result := Result + '                           PDX.DET_CODITE = D.DET_CODITE AND ';
    Result := Result + '                           PDX.DET_QTDITE = D.DET_QTDITE AND ';
    Result := Result + '                           IFNULL(PDX.DET_CODACA, "") = IFNULL(D.DET_CODACA,"") AND ';
    Result := Result + '                           IFNULL(PDX.DET_EMPACA, "") = IFNULL(D.DET_EMPACA,"") AND ';
    Result := Result + '                           PDX.DET_CODCLI = (SELECT EMP_CLIFIL FROM CADEMP WHERE EMP_CODEMP = D.DET_CODEMP) ';
  End;

  If (blnVerificarPD) Then
  Begin
    Result := Result + '    LEFT JOIN NOTDET DX ON DX.DET_NUMDOC = PDX.DET_NUMFAT AND ';
    Result := Result + '                           DX.DET_ESPDOC = PDX.DET_TIPFAT AND ';
    Result := Result + '                           DX.DET_CODEMP = :EMPFIL      AND ';
    Result := Result + '                           DX.DET_TIP_FC = "C"          AND ';
    Result := Result + '                           DX.DET_CODITE = PDX.DET_CODITE AND ';
    Result := Result + '                           DX.DET_QTDITE = PDX.DET_QTDITE AND ';
    Result := Result + '                           IFNULL(DX.DET_CODACA, "") = IFNULL(PDX.DET_CODACA,"") AND ';
    Result := Result + '                           IFNULL(DX.DET_EMPACA, "") = IFNULL(PDX.DET_EMPACA,"") AND ';
    Result := Result + '                           DX.DET_CODCLI = (SELECT EMP_CLIFIL FROM CADEMP WHERE EMP_CODEMP = D.DET_CODEMP) ';
  End
  Else
  Begin
    Result := Result + '    LEFT JOIN ' + strTabDetForFil + ' DX ON DX.DET_NUMDOC = D.DET_NUMDOC AND ';
    Result := Result + '                           DX.DET_ESPDOC = D.DET_ESPDOC AND ';
    Result := Result + '                           DX.DET_CODEMP = :EMPFIL      AND ';
    Result := Result + '                           DX.DET_TIP_FC = "C"          AND ';
    Result := Result + '                           DX.DET_CODITE = D.DET_CODITE AND ';
    Result := Result + '                           DX.DET_QTDITE = D.DET_QTDITE AND ';
    Result := Result + '                           IFNULL(DX.DET_CODACA, "") = IFNULL(D.DET_CODACA,"") AND ';
    Result := Result + '                           IFNULL(DX.DET_EMPACA, "") = IFNULL(D.DET_EMPACA,"") AND ';
    Result := Result + '                           DX.DET_CODCLI = (SELECT EMP_CLIFIL FROM CADEMP WHERE EMP_CODEMP = D.DET_CODEMP) ';
  End;

  Result := Result + '    LEFT JOIN ' + strTabTriForFil + ' TX ON DX.AUTOINCREM = TX.DET_SEQGER ';
  Result := Result + '    LEFT JOIN ' + strTabIcdForFil + ' IX ON DX.AUTOINCREM = IX.ICD_SEQGER ';

  Result := Result + '   LEFT JOIN GERELE ON GER_DOCENT = D.DET_NUMDOC ';
  Result := Result + '                   AND GER_ESPENT = D.DET_ESPDOC ';
  Result := Result + '                   AND GER_EMPENT = D.DET_CODEMP ';
  Result := Result + '                   AND B07_SERIE  = D.DET_SERIE_ ';
  Result := Result + '                   AND GER_CODFOR = D.DET_CODFOR ';
  Result := Result + '   LEFT JOIN DETELE E ON E.DET_SEQGER = GERELE.AUTOINCREM ';
  Result := Result + '                     AND E.DET_CODITE = D.DET_CODITE ';

  Result := Result + ' WHERE ';
  Result := Result + '   D.AUTOINCREM = :ID ';
end;

function TItensNotaEspelho.fTabela: String;
begin
  if blnRecCliGarantia then
    Result := IIF(FTabDev = 'NOTDET','NOTGER','MOVGER')
  else
    Result := 'MOVGER';
end;

function TItensNotaEspelho.fLoadItem(strID: String): TItemNotaEspelho;
  Var
    qryGen: TUniQuery;
    itemNE: TItemNotaEspelho;
    dadosItem: TDadosItemNotaEspelho;
    blnDevFilPD : Boolean;
begin
  Result := Nil;

  qryGen := fCriaQuery(Nil);
  Try
    blnDevFilPD := False;
    With qryGen, SQL Do
    Begin
      Close;
      Clear;

      qryGen.SQL.Text := fSQLNotaEspelho(fTabela);

      ParamByName('ID').AsString := strID;
      ParamByName('EMPFIL').AsString := strEmpForFil;

      If Pos(FTabDev, 'NOTDET_') > 0 Then
      Begin
        qryGen.SQL.Text := fReplaceStr(qryGen.SQL.Text, ['MOVDET','MOVTRI','MOVICD','AUXMOV'], ['NOTDET','NOTTRI','NOTICD','AUXNOT']);
        Open;
        FTabDev := '';
      End
      Else
      Begin
        Open;
      End;

      If (Self.strOpcDoc <> 'FD') Then
      Begin
        If (Not qryGen.IsEmpty) And (fEmptyStr(qryGen.FieldByName('DVF_CODFIS').AsString)) And (Not fEmptyStr(strEmpForFil)) Then
        Begin
          If (fCfgSis('DEVFIL',varBoolean)) Then
          Begin
            qryGen.Close;
            qryGen.SQL.Text := fSQLNotaEspelho(IIF(Pos(FTabDev, 'NOTDET_') > 0, 'MOVGER', 'NOTGER'));
            qryGen.ParamByName('ID').AsString := strID;
            qryGen.ParamByName('EMPFIL').AsString := strEmpForFil;
            qryGen.Open;

            If (Not qryGen.IsEmpty) And (fEmptyStr(qryGen.FieldByName('DVF_CODFIS').AsString)) Then
            Begin
              qryGen.Close;
              qryGen.SQL.Text := fSQLNotaEspelho('MOVGER', True);
              qryGen.ParamByName('ID').AsString := strID;
              qryGen.ParamByName('EMPFIL').AsString := strEmpForFil;
              qryGen.Open;
              blnDevFilPD := (Not fEmptyStr(qryGen.FieldByName('DVF_CODFIS').AsString));
            End;
          End;
        End;
      End;

      If Not IsEmpty Then
      Begin
        FOpcDocOri := FieldByName('AUX_OPCDOC').AsString;
        
        dadosItem.strItemID := strID;

        dadosItem.blnDevFilPD := blnDevFilPD;
        dadosItem.fltQtdIte := FieldByName('DET_QTDITE').AsFloat;
        dadosItem.fltUnitar := FieldByName('DET_UNITAR').AsFloat;
        dadosItem.fltUniDig := FieldByName('DET_UNIDIG').AsFloat;
        dadosItem.fltUniOri := FieldByName('DET_UNIORI').AsFloat;
        dadosItem.fltUniVis := FieldByName('DET_UNIVIS').AsFloat;
        dadosItem.fltTotIte := FieldByName('DET_TOTITE').AsFloat;
        dadosItem.fltDesEsp := FieldByName('DET_DESESP').AsFloat;
        If Not blnEmissaoNotaGarantiaEnvFornecedorConfirmacaoEspelho Then
          dadosItem.fltValFre := FieldByName('DET_TOTFRE').AsFloat;
        dadosItem.fltDesAce := FieldByName('DET_DESACE').AsFloat;

        dadosItem.strClaFis := FieldByName('DET_CLAFIS').AsString;
        dadosItem.strCodFis := FieldByName('DET_CODFIS').AsString;
        dadosItem.fltBasIcm := FieldByName('DET_BASICM').AsFloat;
        dadosItem.fltAlqIcm := FieldByName('DET_ALQICM').AsFloat;
        dadosItem.fltValIcm := FieldByName('DET_VALICM').AsFloat;

        dadosItem.fltOutIcm := FieldByName('DET_OUTICM').AsFloat;
        dadosItem.fltIseIcm := FieldByName('DET_ISEICM').AsFloat;
        dadosItem.fltTotMed := FieldByName('DET_TOTMED').AsFloat;

        dadosItem.fltImpPag := FieldByName('DET_IMPPAG').AsFloat;
        dadosItem.fltFedImp := FieldByName('DET_FEDIMP').AsFloat;
        dadosItem.fltEstImp := FieldByName('DET_ESTIMP').AsFloat;
        dadosItem.fltMunImp := FieldByName('DET_MUNIMP').AsFloat;

        dadosItem.strCstIpi := FieldByName('DET_CSTIPI').AsString;
        dadosItem.strEnqIpi := FieldByName('DET_ENQIPI').AsString;
        dadosItem.fltBasIpi := FieldByName('DET_BASIPI').AsFloat;
        dadosItem.fltAlqIpi := FieldByName('DET_ALQIPI').AsFloat;
        dadosItem.fltValIpi := FieldByName('DET_VALIPI').AsFloat;

        dadosItem.fltBasRet := FieldByName('DET_BASRET').AsFloat;
        dadosItem.fltValRet := FieldByName('DET_VALRET').AsFloat;
        dadosItem.fltAlqRet := FieldByName('DET_ALQRET').AsFloat;

        dadosItem.strCstPis := FieldByName('DET_CSTPIS').AsString;
        dadosItem.strNatPis := FieldByName('DET_NR_PIS').AsString;
        dadosItem.fltBasPis := FieldByName('DET_BASPIS').AsFloat;
        dadosItem.fltAlqPis := FieldByName('DET_ALQPIS').AsFloat;
        dadosItem.fltValPis := FieldByName('DET_VALPIS').AsFloat;

        dadosItem.strCstCof := FieldByName('DET_CSTCOF').AsString;
        dadosItem.strNatCof := FieldByName('DET_NR_COF').AsString;
        dadosItem.fltBasCof := FieldByName('DET_BASCOF').AsFloat;
        dadosItem.fltAlqCof := FieldByName('DET_ALQCOF').AsFloat;
        dadosItem.fltValCof := FieldByName('DET_VALCOF').AsFloat;

        dadosItem.fltPerFcp := FieldByName('ICD_PERFCP').AsFloat;
        dadosItem.fltBasFcp := FieldByName('ICD_BASFCP').AsFloat;
        dadosItem.fltValFcp := FieldByName('ICD_VALFCP').AsFloat;
 
        dadosItem.fltPerFcpST := FieldByName('DET_PFCPST').AsFloat;
        dadosItem.fltBasFcpST := FieldByName('DET_BFCPST').AsFloat;
        dadosItem.fltValFcpST := FieldByName('DET_VFCPST').AsFloat;

        dadosItem.fltDesOpe := FieldByName('DET_DESOPE').AsFloat;
        dadosItem.fltImpFed := FieldByName('DET_IMPFED').AsFloat;
        dadosItem.fltIcmSai := FieldByName('DET_ICMSAI').AsFloat;
        dadosItem.fltOutVal := FieldByName('DET_OUTVAL').AsFloat;

        dadosItem.fltTotCus := FieldByName('DET_TOTCUS').AsFloat;
        dadosItem.fltTotCu2 := FieldByName('DET_TOTCU2').AsFloat;

        dadosItem.fltVrdIcm := FieldByName('DET_VRDICM').AsFloat;
        dadosItem.strMtdIcm := FieldByName('DET_MTDICM').AsString;

        dadosItem.strDvfCodFis := FieldByName('DVF_CODFIS').AsString;

        dadosItem.fltDvfBasIcm := FieldByName('DVF_BASICM').AsFloat;
        dadosItem.fltDvfAlqIcm := FieldByName('DVF_ALQICM').AsFloat;
        dadosItem.fltDvfValIcm := FieldByName('DVF_VALICM').AsFloat;

        dadosItem.fltDvfPerFcp := FieldByName('DVF_PERFCP').AsFloat;
        dadosItem.fltDvfBasFcp := FieldByName('DVF_BASFCP').AsFloat;
        dadosItem.fltDvfValFcp := FieldByName('DVF_VALFCP').AsFloat;

        dadosItem.fltDvfPfcpST := FieldByName('DVF_PFCPST').AsFloat;
        dadosItem.fltDvfBfcpST := FieldByName('DVF_BFCPST').AsFloat;
        dadosItem.fltDvfVfcpST := FieldByName('DVF_VFCPST').AsFloat;

        dadosItem.fltDvfBST := FieldByName('DVF_BASRET').AsFloat;
        dadosItem.fltDvfVST := FieldByName('DVF_VALRET').AsFloat;
        dadosItem.fltDvfPST := FieldByName('DVF_ALQRET').AsFloat;
        dadosItem.fltFreSug := FieldByName('DET_FRESUG').AsFloat;
        dadosItem.fltFreCot := FieldByName('DET_FRECOT').AsFloat;

        dadosItem.fltPeBaST := FieldByName('DET_PEBAST').AsFloat;
        dadosItem.fltValIva := FieldByName('DET_PMVAST').AsFloat;

        dadosItem.fltPerRed := FieldByName('DET_PERRED').AsFloat;
        dadosItem.fltPerDif := FieldByName('N16B_PDIF').AsFloat;
        dadosItem.strIdDest := FieldByName('GER_IDDEST').AsString;
        dadosItem.blnCarregouDadosDoXml := (FieldByName('TEM_XML').AsString = 'SIM');

        itemNE := fNovoItemNotaEspelho(dadosItem);

        pAddItem(itemNE);

        Result := itemNE;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TItensNotaEspelho.fNovoItemNotaEspelho(dadosItem: TDadosItemNotaEspelho): TItemNotaEspelho;
begin
  Result := TItemNotaEspelho.Create(dadosItem);
end;

{ TConsignacoes }
constructor TConsignacoes.Create;
begin
  inherited;
  FblnDeveGravar := True;
end;

function TConsignacoes.fGetTotalDesEsp: Double;
  Var
    intIndex: Integer;
begin
  Result := 0;

  for intIndex := low(arrConsignacoes) to High(arrConsignacoes) do
    Result := Result + arrConsignacoes[intIndex].fltDesEsp;   

end;

{ TIcmsImobilizado }

function TIcmsImobilizado.GetAlqIcm: Double;
begin
  If GetIndex > -1 Then
    recIcmsImobilizado.fltAlqIcm := arrIcmsImobilizado[GetIndex].fltAlqIcm;
  Result := recIcmsImobilizado.fltAlqIcm;
end;

function TIcmsImobilizado.GetBasIcm: Double;
begin
  If GetIndex > -1 Then
    recIcmsImobilizado.fltBasIcm := arrIcmsImobilizado[GetIndex].fltBasIcm;
  Result := recIcmsImobilizado.fltBasIcm;
end;

function TIcmsImobilizado.GetIndex: Integer;
  var
    intCont: Integer;
begin
  Result := -1;
  For intCont := 0 To Length(arrIcmsImobilizado) -1 Do
    If arrIcmsImobilizado[intCont].intIndIte = recIcmsImobilizado.intIndIte Then
      Result := intCont;
end;

function TIcmsImobilizado.GetIndIte: Integer;
begin
  Result := recIcmsImobilizado.intIndIte;
end;

function TIcmsImobilizado.GetInfVal: Boolean;
begin
  If GetIndex > -1 Then
    recIcmsImobilizado.blnInfVal := arrIcmsImobilizado[GetIndex].blnInfVal;
  Result := recIcmsImobilizado.blnInfVal;
end;

function TIcmsImobilizado.GetValIcm: Double;
begin
  Result := fFormataFloat(recIcmsImobilizado.fltBasIcm * recIcmsImobilizado.fltAlqIcm / 100, 2);
end;

procedure TIcmsImobilizado.pLimpaValores;
begin
  recIcmsImobilizado.intIndIte := 0;
  recIcmsImobilizado.fltBasIcm := 0;
  recIcmsImobilizado.fltAlqIcm := 0;
  recIcmsImobilizado.blnInfVal := False;      
end;

procedure TIcmsImobilizado.SetAlqIcm(Value: Double);
begin
  recIcmsImobilizado.fltAlqIcm := Value;
  If GetIndex > -1 Then
    arrIcmsImobilizado[GetIndex].fltAlqIcm := recIcmsImobilizado.fltAlqIcm;
end;

procedure TIcmsImobilizado.SetBasIcm(Value: Double);
begin
  recIcmsImobilizado.fltBasIcm := Value;
  If GetIndex > -1 Then
    arrIcmsImobilizado[GetIndex].fltBasIcm := recIcmsImobilizado.fltBasIcm;
end;

procedure TIcmsImobilizado.SetInfVal(Value: Boolean);
begin
  recIcmsImobilizado.blnInfVal := Value;
  If GetIndex > -1 Then
    arrIcmsImobilizado[GetIndex].blnInfVal := recIcmsImobilizado.blnInfVal;
end;

procedure TIcmsImobilizado.SetIndIte(Value: Integer);
begin
  recIcmsImobilizado.intIndIte := Value;

  If recIcmsImobilizado.intIndIte > 0 Then
  Begin
    If (GetIndex = -1) Then
    Begin
      SetLength(arrIcmsImobilizado, Length(arrIcmsImobilizado) + 1);
      arrIcmsImobilizado[Length(arrIcmsImobilizado) - 1].intIndIte := recIcmsImobilizado.intIndIte;
      arrIcmsImobilizado[Length(arrIcmsImobilizado) - 1].blnInfVal := recIcmsImobilizado.blnInfVal;
      arrIcmsImobilizado[Length(arrIcmsImobilizado) - 1].fltBasIcm := recIcmsImobilizado.fltBasIcm;
      arrIcmsImobilizado[Length(arrIcmsImobilizado) - 1].fltAlqIcm := recIcmsImobilizado.fltAlqIcm;
    End;

    recIcmsImobilizado.blnInfVal := arrIcmsImobilizado[GetIndex].blnInfVal;
    recIcmsImobilizado.fltBasIcm := arrIcmsImobilizado[GetIndex].fltBasIcm;
    recIcmsImobilizado.fltAlqIcm := arrIcmsImobilizado[GetIndex].fltAlqIcm;
  End;
end;

{ TValoresDuplicatas }

constructor TValoresDuplicatas.Create(duplicatas: Array Of TArrDigDuplic; intSeqBaiBaixado: Integer);
  Var
    intContador: Integer;
    intIndex: Integer;
    intIndiceValor: Integer;
begin
  intIndiceValor := 1;
  pZerarValores;

  For intContador := 1 To 24 Do
  Begin
    intIndex := intContador -1;

    If fDuplicataValida(intSeqBaiBaixado, intIndex) Then
    Begin
      SetPropValue(Self, 'fltValor' + fStrZero(intIndiceValor, 2), duplicatas[intIndex].curValor);
      Inc(intIndiceValor);
    End;

  End;
end;

function TValoresDuplicatas.fGetDuplicatas:TarrDuplicata;
Const
 	arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
var
  intContador : Integer;
  arrDuplic: TarrDuplicata;
  intIndiceValor: Integer;
begin
  intIndiceValor := 1;
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  For intContador := 0 To 23 Do
  Begin
    arrDuplic[intContador].strSequen := arrLetra[intContador];
    arrDuplic[intContador].curValor  := GetPropValue(Self, 'fltValor' + fStrZero(intToStr(intIndiceValor), 2));
    Inc(intIndiceValor);
  End;

  Result := arrDuplic;

end;

procedure TValoresDuplicatas.pZerarValores;
begin
  Fillchar(FDuplic, SizeOf(FDuplic), #0);
end;

function TValoresDuplicatas.fDuplicataValida(intSeqBaiBaixado, intIndex: Integer): Boolean;
begin
  Result := True;
  If ((intSeqBaiBaixado > -1) And (intSeqBaiBaixado = intIndex)) Then
    Result := False;
end;

{ TFilterMatrizItens }

constructor TFilterMatrizItens.Create(const Itens: TMatrizFechamento);
begin
  FItens := Itens;
  FItensTmp := Itens;  
end;

function TFilterMatrizItens.fFiltrar(filtro: TFilterItem): TFilterMatrizItens;
  var
    item: TDadosFechamento;
    matriz: TMatrizFechamento;
begin
  SetLength(matriz, 0);

  For item In FItensTmp Do
    If filtro(item) Then
    Begin
      SetLength(matriz, Length(matriz) + 1);
      matriz[Length(matriz) - 1] := item;
    end;

  Result := Self;
  FItensTmp := matriz;
end;

function TFilterMatrizItens.fFiltrar(filtros: Array Of TFilterItem): TFilterMatrizItens;
  Var
    filtro: TFilterItem;
begin
  For filtro In filtros Do
    fFiltrar(filtro);
  Result := Self;
end;

function TFilterMatrizItens.fFiltrarMatriz(
  filtro: array of TFilterItem): TFilterMatrizItens;
  var
    item: TDadosFechamento;
    matriz: TMatrizFechamento;
    filterItem : TFilterItem;
begin
  SetLength(matriz, 0);

  For item In FItensTmp Do
  Begin
    For filterItem In filtro Do
    Begin
      If filterItem(item) Then
      Begin
        SetLength(matriz, Length(matriz) + 1);
        matriz[Length(matriz) - 1] := item;
      end;
    End;
  End;

  Result := Self;
  FItensTmp := matriz;
end;

procedure TFilterMatrizItens.pDesfazerFiltros;
begin
  FItensTmp := FItens;
end;

{ TDesmembrarMatrizItens }

constructor TDesmembrarMatrizItens.Create(const Itens: TMatrizFechamento;
                                          const recServicos: TDadosServicos;
                                          const blnEntregaImediataPorGrupoProdutos: Boolean;
                                          const blnEntregaImediataPorDataDeEntrega: Boolean;
                                          const blnEntregaImediataPorDataDeEntregaComRotaPorPedido: Boolean;
                                          const blnDesmembraPorVendedor: Boolean = False;
                                          const blnDesmembraRegEsp: Boolean = True;
                                          const strOpcDoc: String = '';
                                          const blnDesmembraPorCFG_ITEDOC: Boolean=False);
begin
  FItensOri := Itens;
  FServicosOri := recServicos;
  FEntregaImediataPorGrupoProdutos := blnEntregaImediataPorGrupoProdutos;
  FEntregaImediataPorDataDeEntrega := blnEntregaImediataPorDataDeEntrega;
  FEntregaImediataPorDataDeEntregaComRotaPorPedido := blnEntregaImediataPorDataDeEntregaComRotaPorPedido;
  FDesmembraPorVendedor := blnDesmembraPorVendedor;
  FDesmembraRegEsp := blnDesmembraRegEsp;
  FVerificaDesmembramentoDeBrinde := True;
  FstrOpcDoc := strOpcDoc;
  FDesmembraPorCFG_ITEDOC := blnDesmembraPorCFG_ITEDOC;
  FVerificaDesmembramentoLimiteExcedidoLivro := fCfgSis('DESFIS', varBoolean);
  pLimparMatrizesDesmembramento;
end;

procedure TDesmembrarMatrizItens.pAddMatriz(const matriz: TMatrizFechamento; strInformacao: String; TipoMatriz: TTipoMatrizDesmembrada; recServicos: TDadosServicos);
begin
  If Length(matriz) > 0 Then
  Begin
    If fEhItemServico(matriz[0].strCodIte) And fEmptyStr(recServicos.strCodS01) Then
      Exit;

    SetLength(FMatrizes, Length(FMatrizes) + 1);
    FMatrizes[Length(FMatrizes) - 1] := matriz;

    SetLength(FArrServicos, Length(FArrServicos) + 1);
    FArrServicos[Length(FArrServicos) - 1] := recServicos;

    SetLength(FArrTipoMatrizDesmembrada, Length(FArrTipoMatrizDesmembrada) + 1);
    FArrTipoMatrizDesmembrada[Length(FArrTipoMatrizDesmembrada) - 1] := TipoMatriz;

    pAddDados(FInformacoes, strInformacao);
  End;
end;

class function TDesmembrarMatrizItens.fDesdobroImpostos(fltAlqIcmIte: Double;
  strClaFisIte: String; var intIndice: Integer;
  const arrLivroFiscal: TArrLivFis): Boolean;
  Var
    intIdxLiv: Integer;
    strAlqLiv: String;
    strAlqIte: String;
begin
  Result := True;
  intIndice := 0;

  strAlqIte := FloatToStrF(fltAlqIcmIte, ffNumber, 12, 2);

  For intIdxLiv := Low(arrLivroFiscal) To High(arrLivroFiscal) Do
  Begin
    strAlqLiv := FloatToStrF(arrLivroFiscal[intIdxLiv].fltAlqIcm, ffNumber, 12, 2);

    {*****************************************}
    {* VERIFICA SE USA ÍNDICE JÁ EXISTENTE...*}
    {**************************************MV*}
    If (strAlqIte = strAlqLiv)                         And
       (strClaFisIte = arrLivroFiscal[intIdxLiv].strClaFis) Then
    Begin
      intIndice := intIdxLiv;
      Result := False;
      Exit;
    End

    {*****************************************}
    {* ... OU SE CRIA UM NOVO.               *}
    {**************************************MV*}
    Else If (fEmptyStr(arrLivroFiscal[intIdxLiv].strClaFis)) Then
    Begin
      intIndice := intIdxLiv;
      Exit;
    End;
  End;
end;

class function TDesmembrarMatrizItens.fExcedeuLimiteClassificacoesLivroFiscal(
  const AMatriz: TMatrizFechamento): Boolean;
  Var
    arrLivroFiscal : TArrLivFis;
    intIndiceLivro : Integer;
    intCnt : Integer;
begin
  Result := False;
  FillChar(arrLivroFiscal, Length(arrLivroFiscal), #0);
  For intCnt := Low(AMatriz) To High(AMatriz) Do
  Begin
    If fEhItemServico(AMatriz[intCnt].strCodIte) Then
      Continue;
    intIndiceLivro := -1;
    If TDesmembrarMatrizItens.fDesdobroImpostos(AMatriz[intCnt].fltAlqIcm,
                                                AMatriz[intCnt].strClaFis, intIndiceLivro, arrLivroFiscal) Then
    Begin
      If (intIndiceLivro = 0) Then
        Exit(True)
      Else
      Begin
        arrLivroFiscal[intIndiceLivro].fltAlqIcm := AMatriz[intCnt].fltAlqIcm;
        arrLivroFiscal[intIndiceLivro].strClaFis := AMatriz[intCnt].strClaFis;
      End;
    End;
  End;
end;

function TDesmembrarMatrizItens.fTemMatrizDoTipo(TipoMatriz: TTipoMatrizDesmembrada): Boolean;
  Var
    item: TTipoMatrizDesmembrada;
begin
  Result := False;
  For item In FArrTipoMatrizDesmembrada Do
  Begin
    If item = TipoMatriz Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TDesmembrarMatrizItens.fTemMatrizSomenteItensBrinde():Boolean;
var
  objMatriz: TMatrizFechamento;
  objItem: TDadosFechamento;
begin
  Result := False;

  If (Not fCfgSis('VENBRI', VarBoolean)) Then
    Exit;

  For objMatriz In MatrizesItens Do
  Begin
    Result := True;
    For objItem In objMatriz Do
    Begin
      If (Not (objItem.strBrinde = 'S')) Then
      Begin
        Result := False;
        Break;
      End;
    End;

    If Result Then
      Break;
  End;
end;

procedure TDesmembrarMatrizItens.pDesmembrarMatrizesItensPorLimiteExcedidoLivroFiscal;
  Var
    LMatrizes: TMatrizesFechamento;
    LArrServicos: TArrDadosServicos;
    LInformacoes: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF};
    LArrTipoMatrizDesmembrada: TArrTipoMatrizDesmembrada;
    LMatriz : TMatrizFechamento;
    LMatrizNova : TMatrizFechamento;
    LArrLivroFiscal : TArrLivFis;
    LServicos: TDadosServicos;
    LInformacao: String;
    LIndiceLivro : Integer;
    LCntPrincipal : Integer;
    LCnt : Integer;
    LTipo: TTipoMatrizDesmembrada;
    LSeraNecessarioDesmembrar : Boolean;
begin
  If (Not FVerificaDesmembramentoLimiteExcedidoLivro) Then
    Exit;

  pCopiaArrays(LMatrizes, LArrServicos, LInformacoes, LArrTipoMatrizDesmembrada);

  LSeraNecessarioDesmembrar := False;
  For LCntPrincipal := Low(LMatrizes) To High(LMatrizes) Do
  Begin
    LMatriz := LMatrizes[LCntPrincipal];
    If TDesmembrarMatrizItens.fExcedeuLimiteClassificacoesLivroFiscal(LMatriz) Then
    Begin
      LSeraNecessarioDesmembrar := True;
      Break;
    End;
  End;

  If (Not LSeraNecessarioDesmembrar) Then
    Exit;

  pLimparMatrizesDesmembramento;

  For LCntPrincipal := Low(LMatrizes) To High(LMatrizes) Do
  Begin
    LMatriz := LMatrizes[LCntPrincipal];
    LInformacao := LInformacoes[LCntPrincipal];
    LTipo := LArrTipoMatrizDesmembrada[LCntPrincipal];
    LServicos := LArrServicos[LCntPrincipal];

    FillChar(LArrLivroFiscal, Length(LArrLivroFiscal), #0);
    SetLength(LMatrizNova, 0);

    For LCnt := Low(LMatriz) To High(LMatriz) Do
    Begin
      LIndiceLivro := -1;
      If TDesmembrarMatrizItens.fDesdobroImpostos(LMatriz[LCnt].fltAlqIcm,
                                                  LMatriz[LCnt].strClaFis, LIndiceLivro, LArrLivroFiscal) Then
      Begin
        If (LIndiceLivro = 0) Then
        Begin
          pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);
          SetLength(LMatrizNova, 0);
          FillChar(LArrLivroFiscal, SizeOf(LArrLivroFiscal), #0);
        End
        Else
        Begin
          LArrLivroFiscal[LIndiceLivro].fltAlqIcm := LMatriz[LCnt].fltAlqIcm;
          LArrLivroFiscal[LIndiceLivro].strClaFis := LMatriz[LCnt].strClaFis;
        End;
      End;

      SetLength(LMatrizNova, Length(LMatrizNova)+1);
      LMatrizNova[Pred(Length(LMatrizNova))] := LMatriz[LCnt];
    End;

    If Length(LMatrizNova) > 0 Then
      pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);
  End;
end;

procedure TDesmembrarMatrizItens.pDesmembrarMatrizesItensPorCFG_ITEDOC;
var
  LMatrizes: TMatrizesFechamento;
  LArrServicos: TArrDadosServicos;
  LInformacoes: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF};
  LArrTipoMatrizDesmembrada: TArrTipoMatrizDesmembrada;
var
  LMatriz,
  LMatrizNova: TMatrizFechamento;
  LServicos: TDadosServicos;
  LInformacao: String;
  LTipo: TTipoMatrizDesmembrada;
  intSeqDocDsm,
  intQtdSeqGer,
  intCnt,
  intCntPrincipal,
  intCntItensDesmembrar: Integer;
  dicItePorDoc: TDictionary<String,Integer>;
  strUltSeqGer: String;
begin
  If Not FDesmembraPorCFG_ITEDOC Then
    Exit;

  pCopiaArrays(LMatrizes, LArrServicos, LInformacoes, LArrTipoMatrizDesmembrada);

  pLimparMatrizesDesmembramento;

  dicItePorDoc := TDictionary<String,Integer>.Create;
  Try
    For intCntPrincipal := Low(LMatrizes) To High(LMatrizes) Do
    Begin
      LMatriz     := LMatrizes[intCntPrincipal];
      LInformacao := LInformacoes[intCntPrincipal];
      LTipo       := LArrTipoMatrizDesmembrada[intCntPrincipal];
      LServicos   := LArrServicos[intCntPrincipal];

      SetLength(LMatrizNova, 0);
      intCntItensDesmembrar := 0;

      dicItePorDoc.Clear;
      For intCnt := Low(LMatriz) To High(LMatriz) Do
      Begin
        intQtdSeqGer := 0;
        If (Not fEmptyStr(LMatriz[intCnt].strSeqGer)) Then
        Begin
          dicItePorDoc.TryGetValue(LMatriz[intCnt].strSeqGer, intQtdSeqGer);
          Inc(intQtdSeqGer);
          dicItePorDoc.AddOrSetValue(LMatriz[intCnt].strSeqGer, intQtdSeqGer);
        End;
      End;

      If (dicItePorDoc.Count > 0) Then
      Begin
        intQtdSeqGer :=  0;
        intSeqDocDsm :=  1;
        strUltSeqGer := '';

        For intCnt := Low(LMatriz) To High(LMatriz) Do
        Begin
          If (Not fEmptyStr(LMatriz[intCnt].strSeqGer)) Then
          Begin
            dicItePorDoc.TryGetValue(LMatriz[intCnt].strSeqGer, intQtdSeqGer);

            If (intQtdSeqGer > fCfgSis('ITEDOC', varInteger)) Then
              Raise Exception.Create('A CFG_ITEDOC nunca pode ser menor que a quantidade de um documento confirmado!'+#10#13+
                                     'CFG_ITEDOC: '+IntToStr(fCfgSis('ITEDOC', varInteger))+' ITENS'+#10#13+
                                     'DOCUMENTO: '+fCampoTabela('CONCAT(GER_NUMDOC,"-",GER_ESPDOC,"-",GER_CODEMP)', 'MOVGER', ['AUTOINCREM'], [LMatriz[intCnt].strSeqGer])+' '+intQtdSeqGer.ToString+' ITENS');

            If (LMatriz[intCnt].strSeqGer <> strUltSeqGer) Then
            Begin
              strUltSeqGer := LMatriz[intCnt].strSeqGer;

              If ((intCntItensDesmembrar + intQtdSeqGer) > fCfgSis('ITEDOC', varInteger)) Then
              Begin
                Inc(intSeqDocDsm);
                intCntItensDesmembrar := 0;
              End;
            End;

            LMatriz[intCnt].intSeqDocDsm := intSeqDocDsm;

            Inc(intCntItensDesmembrar);
          End;
        End;

        intSeqDocDsm := 1;
        For intCnt := Low(LMatriz) To High(LMatriz) Do
        Begin
          If (intSeqDocDsm <> LMatriz[intCnt].intSeqDocDsm) Then
          Begin
            pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);

            SetLength(LMatrizNova, 0);

            intSeqDocDsm := LMatriz[intCnt].intSeqDocDsm;
          End;

          SetLength(LMatrizNova, Length(LMatrizNova)+1);
          LMatrizNova[Pred(Length(LMatrizNova))] := LMatriz[intCnt];
        End;

        If Length(LMatrizNova) > 0 Then
          pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);
      End
      Else
      Begin
        For intCnt := Low(LMatriz) To High(LMatriz) Do
        Begin
          If (intCntItensDesmembrar = fCfgSis('ITEDOC', varInteger)) Then
          Begin
            pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);

            SetLength(LMatrizNova, 0);
            intCntItensDesmembrar := 0;
          End;

          SetLength(LMatrizNova, Length(LMatrizNova)+1);
          LMatrizNova[Pred(Length(LMatrizNova))] := LMatriz[intCnt];

          Inc(intCntItensDesmembrar);
        End;

        If Length(LMatrizNova) > 0 Then
          pAddMatriz(LMatrizNova, LInformacao, LTipo, LServicos);
      End;
    End;
  Finally
    dicItePorDoc.Free;
  End;
end;

procedure TDesmembrarMatrizItens.pCopiaArrays(var AMatrizes: TMatrizesFechamento; var AArrServicos: TArrDadosServicos; var AInformacoes: {$IFDEF LINUX}TArray<String>{$ELSE}TStringArray{$ENDIF}; var AArrTipoMatrizDesmembrada: TArrTipoMatrizDesmembrada);
  Var
    LMatriz: TMatrizFechamento;
    LServicos: TDadosServicos;
    LInformacao: String;
    LTipo: TTipoMatrizDesmembrada;
begin
  For LMatriz in FMatrizes Do
  Begin
    SetLength(AMatrizes, Length(AMatrizes)+1);
    AMatrizes[Pred(Length(AMatrizes))] := LMatriz;
  End;

  For LServicos in FArrServicos Do
  Begin
    SetLength(AArrServicos, Length(AArrServicos)+1);
    AArrServicos[Pred(Length(AArrServicos))] := LServicos;
  End;

  For LInformacao in FInformacoes Do
  Begin
    SetLength(AInformacoes, Length(AInformacoes)+1);
    AInformacoes[Pred(Length(AInformacoes))] := LInformacao;
  End;

  For LTipo in FArrTipoMatrizDesmembrada Do
  Begin
    SetLength(AArrTipoMatrizDesmembrada, Length(AArrTipoMatrizDesmembrada)+1);
    AArrTipoMatrizDesmembrada[Pred(Length(AArrTipoMatrizDesmembrada))] := LTipo;
  End;
end;

procedure TDesmembrarMatrizItens.pDesmembrarMatrizItens;
  Const
    arrMeiaNotaFatorExpedicao: Array[0..1] Of Boolean = (True, False);
    arrSelAbastecimento: Array[0..1] Of Boolean = (True, False);
    arrRegimeEspecial: Array[0..1] Of Boolean = (True, False);
    arrCilindroVasilhame: Array[0..1] Of Boolean = (False, True);
    arrOpcoesAbastecimento: Array[0..3] Of TOpcaoAbastecimentoItem = (oaSolicitTransf, oaReqCompra, oaEstoque, oaTodos);
  var
    item: TDadosFechamento;

    intEmpresa: Integer;
    stlEmpresas: TStringList;
    intEmpresaExpedicao: Integer;

    stlGrupoProdutos: TStringList;
    stlDatasEntrega : TStringList;
    stlCodigoVendedor: TStringList;
    stlEmpExp: TStringList;

    recSerTmp: TDadosServicos;
    recSerBriTmp: TDadosServicos;
    objFilterMat: TFilterMatrizItens;
    objFiltersItem: TFiltersItem;

    blnMeiaNotaFatorExpedicao: Boolean;
    blnSelAbs: Boolean;
    blnRegimeEspecial: Boolean;
    blnCilindroVasilhame: Boolean;
    opcTipAbs: TOpcaoAbastecimentoItem;

    intCnt : Integer;

    Function fFatorServicoTotal(arrMatItens: TMatrizFechamento): Double;
      Var
        item: TDadosFechamento;
    Begin
      Result := 0;
      For item in arrMatItens Do
        Result := Result + item.fltFatRat;
    End;

    function fMontaServicos(arrIdeSer: Array Of String; strBrinde: String): TDadosServicos;
      Var
        objSerOri: TClassDadosServicos;
        objSerNov: TClassDadosServicos;
        intSerOri: Integer;
        intSerNov: Integer;
        strSerBri: String;
    begin
      FillChar(Result, SizeOf(Result), #0);

      objSerOri := TClassDadosServicos.Create(FServicosOri);
      objSerNov := TClassDadosServicos.Create(Result);

      For intSerOri := 1 To 30 Do
      Begin
        If MatchStr(GetPropValue(objSerOri, 'strIdeS' + fStrZero(intToStr(intSerOri), 2)), arrIdeSer) Then
        Begin
          For intSerNov := 1 To 30 Do
          Begin
            strSerBri := GetPropValue(objSerOri, 'strBriS' + fStrZero(intToStr(intSerOri), 2));

            If (fEmptyStr(strSerBri)) Then strSerBri := 'N';

            If (fEmptyStr(GetPropValue(objSerNov, 'strCodS' + fStrZero(intToStr(intSerNov), 2))))
              And (MatchStr(strSerBri, strBrinde)) Then
            Begin
              SetPropValue(objSerNov, 'strCodS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strCodS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strDesS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strDesS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'fltQtdS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'fltQtdS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'fltUniS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'fltUniS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'fltValS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'fltValS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'fltCusS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'fltCusS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'fltDecS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'fltDecS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strMecS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strMecS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strObsS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strObsS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strBriS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strBriS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strParS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strParS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strTBrS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strTBrS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strStaS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strStaS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strPriS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strPriS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strIdeS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strIdeS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strVenS' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strVenS' + fStrZero(intToStr(intSerOri), 2)));
              SetPropValue(objSerNov, 'strVe2S' + fStrZero(intToStr(intSerNov), 2), GetPropValue(objSerOri, 'strVe2S' + fStrZero(intToStr(intSerOri), 2)));

              Break;
            End;
          End;
        End;
      End;

      If MatchStr('S', arrIdeSer) And (strBrinde <> 'S') Then
      Begin
        objSerNov.fltTotSer := objSerOri.fltTotSer;
        objSerNov.fltPerIss := objSerOri.fltPerIss;
        objSerNov.fltRedIss := objSerOri.fltRedIss;
        objSerNov.fltBasIss := objSerOri.fltBasIss;
        objSerNov.fltValIss := objSerOri.fltValIss;
      End;

      objSerNov.intPraEnt := objSerOri.intPraEnt;
      objSerNov.strNroCEI := objSerOri.strNroCEI;

      objSerNov.intNroPro := objSerOri.intNroPro;
      objSerNov.dtaSerIni := objSerOri.dtaSerIni;
      objSerNov.dtaSerFin := objSerOri.dtaSerFin;
      objSerNov.strSerObs := objSerOri.strSerObs;

      objSerNov.dtaDtAgeS := objSerOri.dtaDtAgeS;
      objSerNov.horHrAgeS := objSerOri.horHrAgeS;
      objSerNov.dtaDtEntS := objSerOri.dtaDtEntS;
      objSerNov.horHrEntS := objSerOri.horHrEntS;

      objSerNov.strDisSer := objSerOri.strDisSer;
      objSerNov.strNatSer := objSerOri.strNatSer;

      Result := objSerNov.recServicos;

      FreeAndNil(objSerNov);
      FreeAndNil(objSerOri);
    end;

    {*************************************************************}
    {* Se tiver algum serviço com cobrança, todas as informações *}
    {* dos serviços serão salvas na NS.                          *}
    {* Se não, deverá calcular o valor do serviço proporcional   *}
    {* para cada documento emitido (Retira, Imediata e Futura).  *}
    {**********************************************************MM*}
    procedure pCarregaServicos(strFiltraBrinde: String);
    begin
      If FServicosOri.fTemCobranca Then Begin
        If (strFiltraBrinde = 'N') Then
          recSerTmp := fMontaServicos(['S','I'], 'N')
        Else
          recSerBriTmp := fMontaServicos(['S','I'], 'S');
      End Else Begin
        If (strFiltraBrinde = 'N') Then
          FillChar(recSerTmp, SizeOf(recSerTmp), #0)
        Else
          FillChar(recSerBriTmp, SizeOf(recSerBriTmp), #0);
      End;
    end;

    procedure pMontaServicosRateio(strFiltraBrinde: String);
    begin
      If FServicosOri.fTemCobranca Then Begin
        If (strFiltraBrinde = 'N') Then
          recSerTmp := fMontaServicos(['R'], strFiltraBrinde)
        Else
          recSerBriTmp := fMontaServicos(['R'], strFiltraBrinde);
      End Else Begin
        If (strFiltraBrinde = 'N') Then
          recSerTmp := fMontaServicos(['R','I'], strFiltraBrinde)
        Else
          recSerBriTmp := fMontaServicos(['R','I'], strFiltraBrinde);
      End;
    End;

Begin
  {****************************************}
  {* Lista as empresas dos itens da venda *}
  {*************************************JC*}
  stlEmpresas := TStringList.Create;
  stlEmpresas.Sorted := True;
  stlEmpresas.Duplicates := dupIgnore;

  For item In FItensOri Do
    stlEmpresas.Add(item.strEmpIte);

  {**************************************************}
  {* Lista os grupos de produtos dos itens da venda *}
  {***********************************************JC*}
  stlGrupoProdutos := TStringList.Create;
  stlGrupoProdutos.Sorted := True;
  stlGrupoProdutos.Duplicates := dupIgnore;

  stlDatasEntrega := TStringList.Create;
  stlDatasEntrega.Sorted := True;
  stlDatasEntrega.Duplicates := dupIgnore;

  stlCodigoVendedor := TStringList.Create;
  stlCodigoVendedor.Sorted := True;
  stlCodigoVendedor.Duplicates := dupIgnore;

  stlEmpExp := TStringList.Create;
  stlEmpExp.Sorted := True;
  stlEmpExp.Duplicates := dupIgnore;


{$IFNDEF LINUX}
  If (fUtilizaEmpresaPrioridade) And (fCfgSis('SLDPED') = 'T') Then
  Begin
    For item In FItensOri Do
    Begin
      if Not fEmptyStr(item.strEmpExp) then
        stlEmpExp.Add(item.strEmpExp);
    End;
  End
  Else
  Begin
    stlEmpExp.Add('---');
  end;

  if stlEmpExp.Count = 0 then
    stlEmpExp.Add('---');
{$ENDIF}

  For item In FItensOri Do
    stlGrupoProdutos.Add(item.strPrdGru);

  For item In FItensOri Do
  Begin
    If (item.strEntRet = 'E') And (item.strEntFut = 'N') And (item.dtaDtEntr <> 0) Then
      stlDatasEntrega.Add(DateToStr(item.dtaDtEntr));
  End;

  For item In FItensOri Do
    stlCodigoVendedor.Add(item.strCodVen);

  {********************************************}
  {* Inicia as matrizes para desmembramento   *}
  {*****************************************JC*}
  SetLength(FMatrizes, 0);
  SetLength(FInformacoes, 0);
  SetLength(FArrServicos, 0);
  SetLength(FArrTipoMatrizDesmembrada, 0);

  {****************************************}
  {* Cria o objeto de filtro dos produtos *}
  {*************************************JC*}
  objFilterMat := TFilterMatrizItens.Create(FItensOri);
  objFiltersItem := TFiltersItem.Create;

  {********************************************}
  {* Processa as empresas para desmembramento *}
  {*****************************************JC*}
  For intEmpresaExpedicao := 0 To stlEmpExp.Count - 1 Do
    For intEmpresa := 0 To stlEmpresas.Count -1 Do
      For opcTipAbs In arrOpcoesAbastecimento Do
        For blnSelAbs In arrSelAbastecimento Do
          For blnMeiaNotaFatorExpedicao In arrMeiaNotaFatorExpedicao Do
            For blnRegimeEspecial In arrRegimeEspecial Do
              For blnCilindroVasilhame In arrCilindroVasilhame Do
                With objFilterMat, objFiltersItem Do
                Begin
                  {***********************************}
                  {* Define Meia Nota ou Nota Normal *}
                  {********************************JC*}
                  blnMeiaNota := blnMeiaNotaFatorExpedicao;

                  {******************************************************}
                  {* Define se foi selecionado na tela de abastecimento *}
                  {***************************************************JC*}
                  blnSelAbastecimento := blnSelAbs;

                  {***********************************}
                  {* Define se é regime especial *}
                  {********************************JC*}
                  blnRegEsp := blnRegimeEspecial;
                  blnDesmembraRegEsp := Self.FDesmembraRegEsp;

                  {**********************************}
                  {* Define se é cilindro/vasilhame *}
                  {*******************************WL*}
                  blnCilVas := blnCilindroVasilhame;

                  {*******************************************}
                  {* Tipo de abastecimento do item do pedido *}
                  {****************************************JC*}
                  opcAbastecimento := opcTipAbs;

                  {*******************************}
                  {* Define a empresa do filtro  *}
                  {****************************JC*}
                  strEmpresaItem := stlEmpresas[intEmpresa];

                  strEmpresaExpedicao := stlEmpExp[intEmpresaExpedicao];

                  {*********************************}
                  {* Desmembra os itens de Servico *}
                  {******************************JC*}
                  pCarregaServicos('N');
                  pDesfazerFiltros;

                  fFiltrar([fFiltraEmpresa,
                            fFiltraMeiaNota,
                            fFiltraSelAbastecimento,
                            fFiltraOpcAbastecimento,
                            fFiltraRegimeEspecial,
                            fFiltraCilindroVasilhame,
                            fFiltraServico]);

                  pAddMatriz(MatrizItens, 'Serviços', matDesServico, recSerTmp);

                  {********************************}
                  {* Desmembra os itens de Retira *}
                  {*****************************JC*}
                  If (FstrOpcDoc <> 'FC') and (FstrOpcDoc <> 'CR') Then
                  Begin
                    If fCfgSis('LOCRET', VarBoolean) Then
                    Begin
                      If (fCfgSis('NOTDES', VarBoolean)) Then
                      Begin
                        //Retira no Caixa, Balcão, Balcão 2
                        pMontaServicosRateio('N');
                        pDesfazerFiltros;

                        fFiltrar([fFiltraEmpresa,
                                  fFiltraMeiaNota,
                                  fFiltraSelAbastecimento,
                                  fFiltraOpcAbastecimento,
                                  fFiltraRegimeEspecial,
                                  fFiltraCilindroVasilhame,
                                  fFiltraRetiraCaixaBalcao]);

                        recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                        pAddMatriz(MatrizItens, 'Retira - Caixa - Balcão', matDesRetira, recSerTmp);
                      End
                      Else
                      Begin
                        //Retira no Caixa
                        pMontaServicosRateio('N');
                        pDesfazerFiltros;

                        fFiltrar([fFiltraEmpresa,
                                  fFiltraMeiaNota,
                                  fFiltraSelAbastecimento,
                                  fFiltraOpcAbastecimento,
                                  fFiltraRegimeEspecial,
                                  fFiltraCilindroVasilhame,
                                  fFiltraRetiraCaixa]);

                        recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                        pAddMatriz(MatrizItens, 'Retira - Caixa', matDesRetira, recSerTmp);

                        //Retira no Balcao
                        pMontaServicosRateio('N');
                        pDesfazerFiltros;

                        fFiltrar([fFiltraEmpresa,
                                  fFiltraMeiaNota,
                                  fFiltraSelAbastecimento,
                                  fFiltraOpcAbastecimento,
                                  fFiltraRegimeEspecial,
                                  fFiltraCilindroVasilhame,
                                  fFiltraRetiraBalcao]);

                        recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                        pAddMatriz(MatrizItens, 'Retira - Balcão', matDesRetira, recSerTmp);

                        //Retira no Balcao 2
                        pMontaServicosRateio('N');
                        pDesfazerFiltros;

                        fFiltrar([fFiltraEmpresa,
                                  fFiltraMeiaNota,
                                  fFiltraSelAbastecimento,
                                  fFiltraOpcAbastecimento,
                                  fFiltraRegimeEspecial,
                                  fFiltraCilindroVasilhame,
                                  fFiltraRetiraBalcao2]);

                        recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                        pAddMatriz(MatrizItens, 'Retira - Balcão 2', matDesRetira, recSerTmp);
                      End;

                      //Retira na Expedicao
                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraRetiraExpedicao]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Retira - Expedição ', matDesRetira, recSerTmp);
                    End
                    Else
                    Begin
                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraRetira]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Retira', matDesRetira, recSerTmp);
                    End;
                  End;

                  {******************************************}
                      {* Desmembra os itens de Entrega Imediata *}
                      {* por Data de Entrega                    *}
                      {***************************************RN*}
                      If (FEntregaImediataPorDataDeEntrega Or FEntregaImediataPorDataDeEntregaComRotaPorPedido) And (stlDatasEntrega.Count > 1) Then
                      Begin
                        For intCnt := 0 To stlDatasEntrega.Count -1 Do
                        Begin
                      dtaDtEntr := StrToDateDef(stlDatasEntrega[intCnt], 0);

                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraEntregaImediata,
                                fFiltraDataEntrega]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Entrega Imediata', matDesEntregaImediata, recSerTmp);
                    End;
                  End
                  {******************************************}
                  {* Desmembra por Vendedor                 *}
                  {******************************************}
                  Else If (FDesmembraPorVendedor) And (stlCodigoVendedor.Count > 1) Then
                  Begin
                    For intCnt := 0 To stlCodigoVendedor.Count -1 Do
                    Begin
                      strCodVenD := stlCodigoVendedor[intCnt];

                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraCodigoVendedor]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Vendedor', matDesEntregaImediata, recSerTmp);
                    End;
                  End
                  {******************************************}
                  {******************************************}
                  {* Desmembra os itens de Entrega Imediata *}
                  {***************************************JC*}
                  Else If Not FEntregaImediataPorGrupoProdutos Then
                  Begin
                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaImediata]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Imediata', matDesEntregaImediata, recSerTmp);

                  End
                  Else
                  Begin
                    {***********************************************************************}
                    {* Desmembra os itens de entrega imediata tambem em grupo de produtos  *}
                    {********************************************************************JC*}
                    For intCnt := 0 To stlGrupoProdutos.Count -1 Do
                    Begin
                      {****************************************}
                      {* Define o grupo de produtos do filtro *}
                      {*************************************JC*}
                      strGrupoProdutos := stlGrupoProdutos[intCnt];

                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraEntregaImediata,
                                fFiltraGrupoProdutos]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Entrega Imediata', matDesEntregaImediata, recSerTmp);

                    End;
                  End;

                  {****************************************}
                  {* Desmembra os itens de Entrega Futura *}
                  {*************************************JC*}
                  if (fCfgSis('PEFF11', varString) = '1') then
                  begin
                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFutura]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura', matDesEntregaFutura, recSerTmp);
                  end
                  else if (fCfgSis('PEFF11', varString) = '2') then
                  begin
                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFuturaFaltaProduto]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura Falta Produto', matDesEntregaFutura, recSerTmp);

                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFuturaPrevisaoAguardandoCliente]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura Previsão de Entrega e Aguardando Cliente', matDesEntregaFutura, recSerTmp);
                  end
                  else
                  begin
                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFuturaFaltaProduto]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura Falta Produto', matDesEntregaFutura, recSerTmp);

                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFuturaAguardandoCliente]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura Aguardando Cliente', matDesEntregaFutura, recSerTmp);

                    pMontaServicosRateio('N');
                    pDesfazerFiltros;

                    fFiltrar([fFiltraEmpresa,
                              fFiltraMeiaNota,
                              fFiltraSelAbastecimento,
                              fFiltraOpcAbastecimento,
                              fFiltraRegimeEspecial,
                              fFiltraCilindroVasilhame,
                              fFiltraEntregaFuturaPrevisaoEntrega]);

                    recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                    pAddMatriz(MatrizItens, 'Entrega Futura Previsão de Entrega', matDesEntregaFutura, recSerTmp);
                  end;

                  {****************************************}
                  {* Desmembra os produtos de brinde      *}
                  {*************************************DF*}
                  {*******************************************}
                  {* Verifica se irá manter o Item de Brinde *}
                  {* junto com os demais Itens no mesmo doc. *}
                  {****************************************PZ*}
                  If (FVerificaDesmembramentoDeBrinde) Then
                  Begin
                    If (fCfgSis('VENBRI', varString) <> 'S') Then
                    Begin
                      pMontaServicosRateio('N');
                      pDesfazerFiltros;

                      fFiltrar([fFiltraEmpresa,
                                fFiltraMeiaNota,
                                fFiltraSelAbastecimento,
                                fFiltraOpcAbastecimento,
                                fFiltraRegimeEspecial,
                                fFiltraCilindroVasilhame,
                                fFiltraProdutoBrinde]);

                      recSerTmp.pRateiaServicos(fFatorServicoTotal(MatrizItens));
                      pAddMatriz(MatrizItens, 'Produto de Brinde', matDesProdutoDeBrinde, recSerTmp);
                    End;
                  End;

                  {*********************************}
                  {* Desmembra os itens de Servico *}
                  {******************************DF*}
                  pCarregaServicos('S');
                  pDesfazerFiltros;

                  fFiltrar([fFiltraEmpresa,
                            fFiltraMeiaNota,
                            fFiltraSelAbastecimento,
                            fFiltraOpcAbastecimento,
                            fFiltraRegimeEspecial,
                            fFiltraCilindroVasilhame,
                            fFiltraServico]);

                  pAddMatriz(MatrizItens, 'Serviço de Brinde', matDesServicoDeBrinde, recSerBriTmp);
                End;

  stlEmpresas.Destroy;
  stlGrupoProdutos.Destroy;
  stlEmpExp.Destroy;
  stlDatasEntrega.Destroy;
  stlCodigoVendedor.Destroy;
  objFilterMat.Destroy;
  objFiltersItem.Destroy;

  pDesmembrarMatrizesItensPorCFG_ITEDOC;
  pDesmembrarMatrizesItensPorLimiteExcedidoLivroFiscal;
end;

procedure TDesmembrarMatrizItens.pLimparMatrizesDesmembramento;
begin
  SetLength(FMatrizes, 0);
  SetLength(FInformacoes, 0);
  SetLength(FArrServicos, 0);
  SetLength(FArrTipoMatrizDesmembrada, 0);
end;

{ TFiltersItem }

function TFiltersItem.fEhEntregaFuturaClienteVaiRetirar(
  const item: TDadosFechamento): Boolean;
begin
  Result := (item.strEntFut = 'S') And (item.strCliBus = 'S');
end;

function TFiltersItem.fFiltraCilindroVasilhame(
  const item: TDadosFechamento): Boolean;
begin
  If Not fCfgSis('CDTCLV', varBoolean) Then
    Exit(FCilVas);

  Result := (IfEmptyStr(item.strCilVas, 'N') = IIF(FCilVas, 'S', 'N'));
end;

function TFiltersItem.fFiltraCodigoVendedor(
  const item: TDadosFechamento): Boolean;
begin
  Result := (item.strCodVen = FstrCodVen);
end;

function TFiltersItem.fFiltraDataEntrega(const item: TDadosFechamento): Boolean;
begin
  Result := (item.dtaDtEntr = FdtaDtEntr);
end;

function TFiltersItem.fFiltraEmpresa(const item: TDadosFechamento): Boolean;
begin
  If (IfEmptyStr(FEmpresaExpedicao, '---') = '---')  Then
    Result := (item.strEmpIte = FEmpresaItem)
  Else
    Result := ((item.strEmpIte = FEmpresaItem) And (item.strEmpExp = FEmpresaExpedicao));
end;

function TFiltersItem.fFiltraGrupoProdutos(const item: TDadosFechamento): Boolean;
begin
  Result := (item.strPrdGru = FGrupoProdutos);
end;

function TFiltersItem.fFiltraMeiaNota(const item: TDadosFechamento): Boolean;
begin
  Result := (item.blnMeiaNotaFatorExpedicao = FMeiaNota);
end;

function TFiltersItem.fFiltraProdutoBrinde(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strBrinde = 'S');
end;

function TFiltersItem.fFiltraEntregaFutura(const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut = 'S')
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntregaFuturaAguardandoCliente(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut = 'S') And (item.strMotFut = 'A')
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntregaFuturaFaltaProduto(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut = 'S') And (item.strMotFut = 'F')
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntregaFuturaPrevisaoAguardandoCliente(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut = 'S') And ((item.strMotFut = 'P') Or (item.strMotFut = 'A'))
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntregaFuturaPrevisaoEntrega(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut = 'S') And (item.strMotFut = 'P')
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntregaImediata(const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And (item.strEntFut <> 'S')
    And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraEntrega(const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraRegimeEspecial(const item: TDadosFechamento): Boolean;
begin
  If Not FDesmembraRegEsp Then
    Exit(FRegEsp);
  Result := (IfEmptyStr(item.strRegEsp, 'N') = IIF(FRegEsp, 'S', 'N'));
end;

function TFiltersItem.fFiltraRetira(const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet = 'R') And fConsideraBrinde(item) ;
end;

function TFiltersItem.fFiltraRetiraCaixa(const item: TDadosFechamento): Boolean;
begin
  Result := fFiltraRetira(item) And (item.strLocRet = 'C');
end;

function TFiltersItem.fFiltraRetiraCaixaBalcao(
  const item: TDadosFechamento): Boolean;
begin
  Result := fFiltraRetira(item) And ((item.strLocRet = 'C') Or (item.strLocRet = 'B') Or (item.strLocRet = 'B2'));
end;

function TFiltersItem.fFiltraRetiraBalcao(const item: TDadosFechamento): Boolean;
begin
  Result := fFiltraRetira(item) And (item.strLocRet = 'B');
end;

function TFiltersItem.fFiltraRetiraBalcao2(const item: TDadosFechamento): Boolean;
begin
  Result := fFiltraRetira(item) And (item.strLocRet = 'B2');
end;

function TFiltersItem.fFiltraRetiraExpedicao(const item: TDadosFechamento): Boolean;
begin
  Result := fFiltraRetira(item) And (item.strLocRet = 'E');
end;

function TFiltersItem.fFiltraEntregaDesconsiderandoBrinde(const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') ;
end;

function TFiltersItem.fFiltraSelAbastecimento(const item: TDadosFechamento): Boolean;
begin
  Result := (item.blnSelAbs = FSelAbs);
end;

function TFiltersItem.fFiltraEntregaDesconsiderandoEntregaFuturaClienteVaiRetirar(
  const item: TDadosFechamento): Boolean;
begin
  Result := (Not fFiltraServico(item)) And (item.strEntRet <> 'R') And
            (fConsideraBrinde(item)) And (Not fEhEntregaFuturaClienteVaiRetirar(item));
end;

function TFiltersItem.fFiltraOpcAbastecimento(const item: TDadosFechamento): Boolean;
begin
  Result := item.opcTipAbs = FOpcAbs;
end;

function TFiltersItem.fFiltraServico(const item: TDadosFechamento): Boolean;
begin
  Result := fEhItemServico(item.strCodIte);
end;

function TFiltersItem.fConsideraBrinde(const item: TDadosFechamento):Boolean;
Begin
  If (fCfgSis('VENBRI', varString) <> 'S') Then
    Result := (item.strBrinde <> 'S')
  else
    Result := True ;
end;

{ TItensPedidos }

constructor TItensPedidos.Create;
begin
  inherited Create;
  dicItensPedidos := TDicionario.Create;
end;

destructor TItensPedidos.Destroy;
begin
  pLimpar;
  FreeAndNil(dicItensPedidos);
  inherited Destroy;  
end;

function TItensPedidos.GetItemPedidos(index: integer): TArrItemPedidos;
  Var
    intTemp: Integer;
    objArrPed: TArrItemPedidosObj;
begin
  SetLength(Result, 0);

  If Assigned(dicItensPedidos.RetornaObjeto(IntToStr(index))) Then
  Begin
    objArrPed := TArrItemPedidosObj(dicItensPedidos.RetornaObjeto(IntToStr(index)));

    SetLength(Result, Length(objArrPed.arrItemPedidos));

    For intTemp := Low(objArrPed.arrItemPedidos) To High(objArrPed.arrItemPedidos) Do
      Result[intTemp] := objArrPed.arrItemPedidos[intTemp];
  End;

end;

procedure TItensPedidos.pAcertaQuantidadeItem(Index: Integer; fltQtdIteNova: Double);
  Var
    objArrPed: TArrItemPedidosObj;
    intIndPed: Integer;
    fltQtdRes: Double;
begin
  If dicItensPedidos.RetornaObjeto(IntToStr(index)) = nil Then
    Raise Exception.Create('Ocorreu uma falha na localização do produto!');

  fltQtdRes := fltQtdIteNova;

  objArrPed := TArrItemPedidosObj(dicItensPedidos.RetornaObjeto(IntToStr(index)));

  For intIndPed := Low(objArrPed.arrItemPedidos) To High(objArrPed.arrItemPedidos) Do
  Begin
    With objArrPed.arrItemPedidos[intIndPed] Do
    Begin
      fltQtdIte := 0;

      If fltQtdRes > 0 Then
      Begin
        If fltQtdRes > (fltQtdOri - fltQtdBai) Then
          fltQtdIte := (fltQtdOri - fltQtdBai)
        Else
          fltQtdIte := fltQtdRes;

        fltQtdRes := fltQtdRes - fltQtdIte;
      End;
    End;
  End;

  If fltQtdRes <> 0 Then
    Raise Exception.Create('Ocorreu uma falha no cálculo da quantidade do produto!');
end;

procedure TItensPedidos.pAddItem(index: Integer; recItemPedido: TRecItemPedido);
  Var
    objArrPed: TArrItemPedidosObj;
begin
  If dicItensPedidos.RetornaObjeto(IntToStr(index)) = nil Then
    objArrPed := TArrItemPedidosObj.Create
  Else
    objArrPed := TArrItemPedidosObj(dicItensPedidos.RetornaObjeto(IntToStr(index)));

  SetLength(objArrPed.arrItemPedidos, Length(objArrPed.arrItemPedidos) + 1);
  objArrPed.arrItemPedidos[Length(objArrPed.arrItemPedidos) -1] := recItemPedido;

  dicItensPedidos.AdicionarObjeto(IntToStr(index), objArrPed);
end;

procedure TItensPedidos.pLimpar;
begin
  dicItensPedidos.LimparObjetos;
end;

{ TClassDadosServicos }

constructor TClassDadosServicos.Create(servicos: TDadosServicos);
begin
  FRecSer := servicos;
end;

{ TCalcCustoReal }

constructor TCalcCustoReal.Create;
begin
  FUnitar := 0.00;
  FPreCus := 0.00;
  FIcmSai := 0.00;
  FImpFed := 0.00;
  FOutVal := 0.00;
  FDesOpe := 0.00;
  FIcmPav := 0.00;
  FCalcST := False;
  FFrete  := 0.00;
end;

{ TDividirItensMeiaNota }

constructor TDividirItensMeiaNota.Create(arrMatItens: TMatrizFechamento; strEspDoc, strTipPed: String;
  blnMeiaNotaComNotaNormal: Boolean; fltFatorQtdeMeiaNotaNotaNormal: Double);
  Var
    intItem: Integer;
begin
  FTipoPedido := strTipPed;
  FEspecieDocumento := strEspDoc;
  FMeiaNotaComNotaNormal := blnMeiaNotaComNotaNormal;
  FFatorQtdeMeiaNotaNotaNormal := fltFatorQtdeMeiaNotaNotaNormal;

  SetLength(FItensMeiaNota, 0);
  SetLength(FItensNotaNormal, 0);
  SetLength(FItensVenda, Length(arrMatItens));

  For intItem := Low(arrMatItens) To High(arrMatItens) Do
    FItensVenda[intItem] := arrMatItens[intItem];
end;

procedure TDividirItensMeiaNota.pAcertaItensDocumentoSenha2MeiaNota;
  Var
    item: TDadosFechamento;
    fltNovaQtd: Double;
    fltMltVen : Double;

    function fItemPermitidoParaEspecie: Boolean;
    begin
      If FEspecieDocumento = 'NF' Then
        Result := True
      Else
        Result := (item.strNotEsp = 'S') And
                  (item.strIdePro = 'NOR') And
                  (fEmptyStr(item.strCodAca));
    end;

begin
  For item In FItensVenda Do
  Begin
    If fItemPermitidoParaEspecie Then
    Begin
      If ((FEspecieDocumento = 'NF') And (item.strNotEsp = 'N')) Or
          (FTipoPedido = 'D') Then
      Begin
        fltNovaQtd := item.fltQtdIte;
      End
      Else
      Begin
        fltNovaQtd := fFormataFloat(item.fltQtdIte * FFatorQtdeMeiaNotaNotaNormal, fCfgSis('DECQTD', varInteger));

        If fCfgSis('MLTFAT', varBoolean) Then
        Begin
          fltMltVen := fRetMltVenItem(item.strCodIte);
          If (fltMltVen > 1) Then
          Begin
            if ( (fltNovaQtd / fltMltVen ) - Int( fltNovaQtd / fltMltVen )) > 0 Then
            Begin
              fltNovaQtd := fltNovaQtd - ( fltMltVen * ( (fltNovaQtd / fltMltVen ) - Int( fltNovaQtd / fltMltVen )));
            End;
          End;
        End;

        If (item.strIteFra = 'N') Then
        Begin
          fltNovaQtd := Int(fltNovaQtd);
        End;
      End;

      If fltNovaQtd > 0 Then
      Begin
        SetLength(FItensMeiaNota, Length(FItensMeiaNota) + 1);
        FItensMeiaNota[Length(FItensMeiaNota) - 1] := item;
        FItensMeiaNota[Length(FItensMeiaNota) - 1].fltQtdIte := fltNovaQtd;
        FItensMeiaNota[Length(FItensMeiaNota) - 1].blnMeiaNotaFatorExpedicao := True;
        pAcertaTotaisItem(FItensMeiaNota[Length(FItensMeiaNota) - 1], item);
      End;
    End;
  End;
end;

procedure TDividirItensMeiaNota.pAcertaTotaisItem(var itemNovo: TDadosFechamento;
  const itemOriginal: TDadosFechamento);
begin
  itemNovo.fltTotIte := fFormataFloat(itemNovo.fltQtdIte * itemNovo.fltUnitar, 2);
  itemNovo.fltTotCus := fFormataFloat(itemNovo.fltQtdIte * itemNovo.fltPreCus, 2);
  itemNovo.fltTotCu2 := fFormataFloat(itemNovo.fltQtdIte * itemNovo.fltPreCu2, 2);
  itemNovo.fltTotMed := fFormataFloat(itemNovo.fltQtdIte * (itemOriginal.fltTotMed / itemOriginal.fltQtdIte), 2);
  itemNovo.fltTotUlt := fFormataFloat(itemNovo.fltQtdIte * (itemOriginal.fltTotUlt / itemOriginal.fltQtdIte), 2);
  itemNovo.fltTotImp := fFormataFloat(itemNovo.fltQtdIte * (itemOriginal.fltTotImp / itemOriginal.fltQtdIte), 2);
end;

procedure TDividirItensMeiaNota.pDividirMatrizItens;
begin
  SetLength(FItensMeiaNota, 0);
  SetLength(FItensNotaNormal, 0);

  If fAplicarFator Then
  Begin
    pAcertaItensDocumentoSenha2MeiaNota;
    pAcertaItensDocumentoSenha1MeiaNota;
  End;
end;

function TDividirItensMeiaNota.fAplicarFator: Boolean;
begin
  Result := (FMeiaNotaComNotaNormal) And
            (FFatorQtdeMeiaNotaNotaNormal > 0) And
            (Pos(FEspecieDocumento, 'NF_MI_FF_') > 0);
end;

function TDividirItensMeiaNota.fQuantidadeJaEmitidaSenha2(intAutInc: Integer): Double;
  var
    intSenha2: Integer;
begin
  Result := 0;
  For intSenha2 := Low(FItensMeiaNota) To High(FItensMeiaNota) Do
    If FItensMeiaNota[intSenha2].intAutInc = intAutInc Then
    Begin
      Result := FItensMeiaNota[intSenha2].fltQtdIte;
      Break;
    End;
end;


procedure TDividirItensMeiaNota.pAcertaItensDocumentoSenha1MeiaNota;
  Var
    fltNovaQtd: Double;
    item: TDadosFechamento;
begin
  For item In Self.FItensVenda Do
  Begin
    fltNovaQtd := item.fltQtdIte - fQuantidadeJaEmitidaSenha2(item.intAutInc);

    If fltNovaQtd > 0 Then
    Begin
      SetLength(FItensNotaNormal, Length(FItensNotaNormal) + 1);
      FItensNotaNormal[Length(FItensNotaNormal) - 1] := item;
      FItensNotaNormal[Length(FItensNotaNormal) - 1].fltQtdIte := fltNovaQtd;
      FItensNotaNormal[Length(FItensNotaNormal) - 1].blnMeiaNotaFatorExpedicao := False;
      pAcertaTotaisItem(FItensNotaNormal[Length(FItensNotaNormal) - 1], item);
    End;
  End;
end;

{ TAcertaVencimentosMeiaNotaComNotaNormal }

constructor TAcertaVencimentosMeiaNotaComNotaNormal.Create;
begin
  FStatus := stgAguardandoGravacao;
  SetLength(FArrDocsVencOri, 0);
  SetLength(FArrDocsVencNov, 0);
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.fSetarStatus(
  status: TStatusGravacaoVenda): TAcertaVencimentosMeiaNotaComNotaNormal;
begin
  FStatus := status;
  Result  := Self;
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.fGetTotalDuplicatas(
  arrDuplicatas: TarrDuplicata): Double;
  Var
    duplicata: TArrDigDuplic;
begin
  Result := 0;
  For duplicata In arrDuplicatas Do
    Result := Result + duplicata.curValor;

  Result := fFormataFloat(Result, 2);
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.fGetCondicaoPagamentoDuplicatas(
  arrDuplicatas: TarrDuplicata): String;
  Var
    intQtdPar: Integer;
    duplicata: TArrDigDuplic;
begin
  intQtdPar := 0;
  Result    := '';

  For duplicata In arrDuplicatas Do
    If (duplicata.curValor > 0) And (duplicata.dtaDtaVen <> '') Then
    Begin
      Result := Result + fStrZero(DaysBetween(VS_Date, StrToDateDef(duplicata.dtaDtaVen, VS_Date)), 3);
      Inc(intQtdPar);
    End;

  Result := fStrZero(IntToStr(intQtdPar), 2) + Result;
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.GetMaxParcelasAutcom: Integer;
var
  arrDuplicata: TarrDuplicata;
begin
{$IFNDEF LINUX}
  pZeraDigDuplic(arrDuplicata);
{$ENDIF}
  Result := Length(arrDuplicata);
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.GetTemMeiaNotaComNotaNormal: Boolean;
  Var
    blnTemNotaNormal : Boolean;
    blnTemMeiaNota   : Boolean;
    docVenc          : TInfoDocVenda;
begin
  blnTemNotaNormal := False;
  blnTemMeiaNota   := False;

  For docVenc In FArrDocsVencOri Do
  Begin
    blnTemNotaNormal := blnTemNotaNormal Or (docVenc.strEspDoc <> 'FF');
    blnTemMeiaNota   := blnTemMeiaNota   Or (docVenc.strEspDoc =  'FF');
  End;

  Result := blnTemNotaNormal And blnTemMeiaNota;
end;

procedure TAcertaVencimentosMeiaNotaComNotaNormal.pAdicionarInformacoesVenda(intIndDoc: Integer;
  strEspDoc, strTipDoc: String; arrDupDoc: TarrDuplicata; fltTotGer: Double; arrItens: TMatrizFechamento);
  Var
    intParcela: Integer;
begin
  SetLength(FArrDocsVencOri, intIndDoc + 1);

  FArrDocsVencOri[intIndDoc].strEspDoc := strEspDoc;
  FArrDocsVencOri[intIndDoc].strTipDoc := strTipDoc;
  FArrDocsVencOri[intIndDoc].arrItens  := arrItens;
  FArrDocsVencOri[intIndDoc].fltTotGer := fltTotGer;
  FArrDocsVencOri[intIndDoc].fltTotDup := 0;
  FArrDocsVencOri[intIndDoc].fltTotUti := 0;

  For intParcela := 0 To GetMaxParcelasAutcom -1 Do
  Begin
    FArrDocsVencOri[intIndDoc].arrDupDoc[intParcela] := arrDupDoc[intParcela];
    FArrDocsVencOri[intIndDoc].fltTotDup := FArrDocsVencOri[intIndDoc].fltTotDup + arrDupDoc[intParcela].curValor;
  End;

  pIniciarArrayDocumentosVencimentosNovos;
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.fDigitaDuplicata(strConPag: String;
  fltTotDup: Double; Var arrDupDoc: TarrDuplicata): Boolean;
  Var
    arrDuplic: TArrDigDuplicArray;
    intDuplic: Integer;
begin
  Result := fDigDuplicVar(strConPag, 0, fltTotDup, False, False, False, VS_Date, False, arrDuplic, 0, 'N', False);

  If Result Then
  Begin
    FillChar(arrDupDoc, SizeOf(arrDupDoc), #0);
    For intDuplic := Low(arrDuplic) To High(arrDuplic) Do
      arrDupDoc[intDuplic] := arrDuplic[intDuplic];
  End;
end;

procedure TAcertaVencimentosMeiaNotaComNotaNormal.pCarregarNovosVencimentos(
  intIndDoc: Integer; Var strConPag: String; Var arrDupDoc: TarrDuplicata);
  Var
    intParcela: Integer;
    intParDup : Integer;
    fltTotDup : Double;
begin
  If Not blnTemMeiaNotaComNotaNormal Then
    Exit;

  If Not fRecalcularVencimentosParaEmissaoBoleto(strConPag) Then
    Exit;

  If fGetTotalDuplicatas(arrDupDoc) <> fGetTotalDuplicatas(FArrDocsVencNov[intIndDoc].arrDupDoc) Then
    Exit;

  If fGetTotalDuplicatas(arrDupDoc) <= 0 Then
    Exit;

  If fGetTotalDuplicatas(FArrDocsVencNov[intIndDoc].arrDupDoc) <= 0 Then
    Exit;

  fltTotDup := fGetTotalDuplicatas(FArrDocsVencNov[intIndDoc].arrDupDoc);
  strConPag := fGetCondicaoPagamentoDuplicatas(FArrDocsVencNov[intIndDoc].arrDupDoc);

  If fDigitaDuplicata(strConPag, fltTotDup, arrDupDoc) Then
  Begin
    intParDup := -1;
    For intParcela := 0 To GetMaxParcelasAutcom -1 Do
    Begin
      If FArrDocsVencNov[intIndDoc].arrDupDoc[intParcela].curValor > 0 Then
      Begin
        Inc(intParDup);
        arrDupDoc[intParDup].curValor := FArrDocsVencNov[intIndDoc].arrDupDoc[intParcela].curValor;
      End;
    End;
  End;
end;

procedure TAcertaVencimentosMeiaNotaComNotaNormal.pIniciarArrayDocumentosVencimentosNovos;
  Var
    intDoc: Integer;
    intDup: Integer;
begin
  SetLength(FArrDocsVencNov, Length(FArrDocsVencOri));
  For intDoc := Low(FArrDocsVencOri) To High(FArrDocsVencOri) Do
  Begin
    FArrDocsVencNov[intDoc] := FArrDocsVencOri[intDoc];
    FArrDocsVencNov[intDoc].fltTotUti := 0;
    For intDup := 0 To GetMaxParcelasAutcom -1 Do
      FArrDocsVencNov[intDoc].arrDupDoc[intDup] := FArrDocsVencOri[intDoc].arrDupDoc[intDup];
  End;
end;

procedure TAcertaVencimentosMeiaNotaComNotaNormal.pVerificaAcertaValorMinimoParcelasBoleto(var documento: TInfoDocVenda);
  Var
    intDup: Integer;
    fltValMinBoleto: Double;
begin
  fltValMinBoleto := fCfgSis('MINBOL', varDouble);

  If fltValMinBoleto <= 0 Then
    Exit;

  {*************************************************************}
  {* Quando NF acerta o valor da parcela na duplicata anterior *}
  {**********************************************************JC*}
  If documento.strEspDoc = 'NF' Then
  Begin
    For intDup := High(documento.arrDupDoc) Downto Low(documento.arrDupDoc) Do
    Begin
      If (intDup > Low(documento.arrDupDoc)) And
         (documento.arrDupDoc[intDup].curValor > 0) And
         (documento.arrDupDoc[intDup].curValor < fltValMinBoleto) Then
      Begin
        documento.arrDupDoc[Pred(intDup)].curValor := documento.arrDupDoc[Pred(intDup)].curValor +
                                                      documento.arrDupDoc[intDup].curValor;

        documento.arrDupDoc[intDup].curValor := 0.00;
      End;
    End;
  End
  {**************************************************************}
  {* Quando FF acerta o valor da parcela na duplicata posterior *}
  {**********************************************************JC**}
  Else If documento.strEspDoc = 'FF' Then
  Begin
    For intDup := Low(documento.arrDupDoc) To High(documento.arrDupDoc) Do
    Begin
      If (intDup < High(documento.arrDupDoc)) And
         (documento.arrDupDoc[intDup].curValor > 0) And
         (documento.arrDupDoc[intDup].curValor < fltValMinBoleto) And
         (documento.arrDupDoc[Succ(intDup)].curValor > 0) And
         (documento.arrDupDoc[Succ(intDup)].dtaDtaVen <> '') Then
      Begin
        documento.arrDupDoc[Succ(intDup)].curValor := documento.arrDupDoc[Succ(intDup)].curValor +
                                                      documento.arrDupDoc[intDup].curValor;

        documento.arrDupDoc[intDup].curValor := 0.00;
      End;
    End;
  End;
end;

function TAcertaVencimentosMeiaNotaComNotaNormal.fRecalcularVencimentosParaEmissaoBoleto(strConPag: String): Boolean;
  Var
    intDup: Integer;
    intDoc: Integer;
    intQtdPar: Integer;
    fltFatorDoc: Double;
    fltValorTotalParcelaAtual: Double;
    fltTotDupMeiaNotaRestante: Double;
    fltTotDupNotaNormalRestante: Double;
    fltTotDupMeiaNota: Double;
    fltTotDupNotaNormal: Double;
begin
  Result := False;

  {*************************************************************************}
  {* CALCULA A QUANTIDADE DE PARCELAS, CASO APENAS UMA NAO DEVE PROSSEGUIR *}
  {**********************************************************************JC*}
  intQtdPar := strToIntDef(LeftStr(strConPag, 2), -1);

  If intQtdPar < 2 Then
    Exit;

  {***********************************************}
  {* INICIA OS TOTALIZADORES COM NOTA E SEM NOTA *}
  {*******************************************JC**}
  fltTotDupMeiaNota           := 0;
  fltTotDupNotaNormal         := 0;

  pIniciarArrayDocumentosVencimentosNovos;

  {*********************************************}
  {* CALCULA O VALOR TOTAL COM NOTA E SEM NOTA *}
  {******************************************JC*}
  For intDoc := Low(FArrDocsVencOri) To High(FArrDocsVencOri) Do
  Begin
    If FArrDocsVencOri[intDoc].strEspDoc = 'FF' Then
      fltTotDupMeiaNota   := fltTotDupMeiaNota   + FArrDocsVencOri[intDoc].fltTotDup
    Else
      fltTotDupNotaNormal := fltTotDupNotaNormal + FArrDocsVencOri[intDoc].fltTotDup;
  End;

  fltTotDupMeiaNotaRestante   := fltTotDupMeiaNota;
  fltTotDupNotaNormalRestante := fltTotDupNotaNormal;

  For intDup := 0 To GetMaxParcelasAutcom -1 Do
  Begin
    {************************************}
    {* CALCULA O VALOR TOTAL DA PARCELA *}
    {*********************************JC*}
    fltValorTotalParcelaAtual := 0;
    For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
    Begin
      fltValorTotalParcelaAtual := fltValorTotalParcelaAtual + FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
    End;

    {******************************************}
    {* ZERA O VALOR DA PARCELA DOS DOCUMENTOS *}
    {***************************************JC*}
    For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
    Begin
      FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor := 0;
    End;

    {*****************************************************************}
    {* CASO NAO HOUVER VALOR PARA A PARCELA NAO DEVE FAZER MAIS NADA *}
    {**************************************************************JC*}
    If fltValorTotalParcelaAtual <= 0 Then
      Continue;

    {********************************************************************}
    {* CASO O VALOR RESTANTE DAS NOTAS SEJA MAIOR QUE O VALOR DA PARCELA*}
    {*****************************************************************JC*}
    If (fltTotDupNotaNormalRestante - fltValorTotalParcelaAtual > 0) Then
    Begin
      {*******************************************************************************}
      {* CALCULA O VALOR DE CADA DOCUMENTO COM NOTA PROPORCIONAL AO VALOR DA PARCELA *}
      {****************************************************************************JC*}
      For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
      Begin
        If FArrDocsVencNov[intDoc].strEspDoc <> 'FF' Then
        Begin
          fltFatorDoc := (FArrDocsVencNov[intDoc].fltTotDup / fltTotDupNotaNormal);

          FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor := fFormataFloat(fltValorTotalParcelaAtual * fltFatorDoc, 2);

          FArrDocsVencNov[intDoc].fltTotUti := FArrDocsVencNov[intDoc].fltTotUti + FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
          fltTotDupNotaNormalRestante       := fltTotDupNotaNormalRestante       - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
        End;
      End;

      Continue;
    End;

    {**********************************************************************************}
    {* SE CHEGOU AQUI ENTAO O VALOR RESTANTE DAS NOTAS É MENOR QUE O VALOR DA PARCELA *}
    {*******************************************************************************JC*}
    For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
    Begin
      {***********************************************************************}
      {* ATUALIZA O VALOR RESTANTE DAS DUPLICATAS DE CADA DOCUMENTO COM NOTA *}
      {********************************************************************JC*}
      If FArrDocsVencNov[intDoc].strEspDoc <> 'FF' Then
      Begin
        FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor := FArrDocsVencNov[intDoc].fltTotDup - FArrDocsVencNov[intDoc].fltTotUti;

        FArrDocsVencNov[intDoc].fltTotUti := FArrDocsVencNov[intDoc].fltTotUti + FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
        fltTotDupNotaNormalRestante       := fltTotDupNotaNormalRestante       - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
        fltValorTotalParcelaAtual         := fltValorTotalParcelaAtual         - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
      End;
    End;

    {***********************************************************************}
    {* NESTE PONTO NAO DEVE HAVER NENHUM VALOR RESTANTE PARA A NOTA FISCAL *}
    {********************************************************************JC*}
    If fFormataFloat(fltTotDupNotaNormalRestante, 2) <> 0.00 Then
    Begin
      Result := False;
      Exit;
    End;

    {*****************************************************************}
    {* CASO NAO HOUVER VALOR PARA A PARCELA NAO DEVE FAZER MAIS NADA *}
    {**************************************************************JC*}
    If fltValorTotalParcelaAtual <= 0 Then
      Continue;

    {*************************************************************}
    {* CASO NAO SEJA A ULTIMA DUPLICATA DOS DOCUMENTOS MEIA NOTA *}
    {*********************************************************JC**}
    If intDup < (intQtdPar -1) Then
    Begin
      {*******************************************************************************}
      {* CALCULA O VALOR DE CADA DOCUMENTO SEM NOTA PROPORCIONAL AO VALOR DA PARCELA *}
      {****************************************************************************JC*}
      For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
      Begin
        If FArrDocsVencNov[intDoc].strEspDoc = 'FF' Then
        Begin
          fltFatorDoc := (FArrDocsVencNov[intDoc].fltTotDup / fltTotDupMeiaNota);

          FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor := fFormataFloat(fltValorTotalParcelaAtual * fltFatorDoc, 2);

          FArrDocsVencNov[intDoc].fltTotUti := FArrDocsVencNov[intDoc].fltTotUti + FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
          fltTotDupMeiaNotaRestante         := fltTotDupMeiaNotaRestante         - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
        End;
      End;
    End
    {********************************************************}
    {* CASO SEJA A ULTIMA DUPLICATA DOS DOCUMENTOS SEM NOTA *}
    {****************************************************JC**}
    Else If intDup = (intQtdPar - 1) Then
    Begin
      {***********************************************************************}
      {* ATUALIZA O VALOR RESTANTE DAS DUPLICATAS DE CADA DOCUMENTO SEM NOTA *}
      {********************************************************************JC*}
      For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
      Begin
        If FArrDocsVencNov[intDoc].strEspDoc = 'FF' Then
        Begin
          FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor := FArrDocsVencNov[intDoc].fltTotDup - FArrDocsVencNov[intDoc].fltTotUti;

          FArrDocsVencNov[intDoc].fltTotUti := FArrDocsVencNov[intDoc].fltTotUti + FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
          fltTotDupMeiaNotaRestante         := fltTotDupMeiaNotaRestante         - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
          fltValorTotalParcelaAtual         := fltValorTotalParcelaAtual         - FArrDocsVencNov[intDoc].ArrDupDoc[intDup].curValor;
        End;
      End;

      {*****************************************************************}
      {* NESTE PONTO NAO DEVE HAVER NENHUM VALOR RESTANTE PARA OS FF's *}
      {**************************************************************JC*}
      If fFormataFloat(fltTotDupMeiaNotaRestante, 2) <> 0.00 Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;

  {*************************************************************}
  {* VALIDA O VALOR MINIMO PARA EMISSAO DE BOLETO (CFG_MINBOL) *}
  {**********************************************************JC*}
  For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
  Begin
    pVerificaAcertaValorMinimoParcelasBoleto(FArrDocsVencNov[intDoc]);
  End;

  {*****************************************************************************}
  {* VALIDA SE O VALOR TOTAL DAS DUPLICATAS DE CADA DOCUMENTO CONTINUA O MESMO *}
  {**************************************************************************JC*}
  For intDoc := Low(FArrDocsVencNov) To High(FArrDocsVencNov) Do
  Begin
    Result := fGetTotalDuplicatas(FArrDocsVencOri[intDoc].arrDupDoc) =
              fGetTotalDuplicatas(FArrDocsVencNov[intDoc].arrDupDoc);

    If Not Result Then
      Break;
  End;

end;

{ TOrdenarItensParaGravacao }

function TOrdenarItensParaGravacao.fBuscarItem(arrItens: TMatrizFechamento;
  intAutInc: Integer): TDadosFechamento;
  Var
    item: TDadosFechamento;
begin
  For item In arrItens Do
    If item.intAutInc = intAutInc Then
      Exit(item);
  Raise Exception.Create('item não foi encontrado!');
end;

procedure TOrdenarItensParaGravacao.pOrdenarItensPorCodigo(
  const arrMatrizItens: TMatrizFechamento);
  Var
    i: Integer;
    intAutInc: Integer;
    stlItens: TStringList;
begin
  SetLength(FMatrizOrdenada, Length(arrMatrizItens));

  stlItens := TStringList.Create;
  stlItens.Sorted := True;

  For i := Low(arrMatrizItens) To High(arrMatrizItens) Do
    stlItens.Add(arrMatrizItens[i].strCodIte + '=' + intToStr(arrMatrizItens[i].intAutInc));

  For i := 0 To stlItens.Count -1 Do
  Begin
    intAutInc := StrToInt(RightStr(stlItens[i], Length(stlItens[i]) - Pos('=', stlItens[i])));
    FMatrizOrdenada[i] := fBuscarItem(arrMatrizItens, intAutInc);
  End;

  FreeAndNil(stlItens);
end;

procedure TOrdenarItensParaGravacao.pRestaurarOrdemMatrizItens(
  const arrMatrizItens: TMatrizFechamento);
  Var
    i: Integer;
    arrMatrizTmp: TMatrizFechamento;
begin
  SetLength(arrMatrizTmp, Length(arrMatrizItens));

  For i := Low(arrMatrizItens) To High(arrMatrizItens) Do
    arrMatrizTmp[i] := arrMatrizItens[i];

  For i := Low(FMatrizOriginal) To High(FMatrizOriginal) Do
    FMatrizOrdenada[i] := fBuscarItem(arrMatrizTmp, FMatrizOriginal[i].intAutInc);
end;

procedure TOrdenarItensParaGravacao.pSalvarOrdemMatrizItens(
  const arrMatrizItens: TMatrizFechamento);
  Var
    i: Integer;
begin
  SetLength(FMatrizOriginal, Length(arrMatrizItens));
  For i := Low(arrMatrizItens) To High(arrMatrizItens) Do
    FMatrizOriginal[i] := arrMatrizItens[i];
end;

{ TModificacoesItensPedido }

constructor TListarModificacoesItensPedido.Create(AParams: IParametrosItensModificados);
begin
  FParams := AParams;
  pCarregarItens();
end;

destructor TListarModificacoesItensPedido.Destroy;
begin
  FreeAndNil(FCdsItens);
  inherited;
end;

class function TListarModificacoesItensPedido.New(
  AParams: IParametrosItensModificados): IListarModificacoesItensPedido;
begin
  Result := TListarModificacoesItensPedido.Create(AParams);
end;

function TListarModificacoesItensPedido.fGetModificacoesParaMensagem: String;
  Var
    item: TDadosFechamento;
    blnAchou: Boolean;
    strItensInseridos: String;
    strItensRemovidos: String;
    strItensAlterados: String;
    blnAlterouQtd: Boolean;
    blnAlterouEmp: Boolean;
    strObservacao : String;
    strMotivo     : String;
    intContador   : Integer;
    blnVendaPerd  : Boolean;
    blnAlterouVlr : Boolean;

  function LinhaSeparacaoInclusao: string;
  begin
    If fTamCodIte = 5 Then
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 160, '-') + #13#10
      Else
        Result := fPadL('-', 135, '-') + #13#10;
    End
    Else
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 162, '-') + #13#10
      Else
        Result := fPadL('-', 137, '-') + #13#10;
    End;
  end;

  function LinhaSeparacaoAlteraQtde: string;
  begin
    If fTamCodIte = 5 Then
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 191, '-') + #13#10
      Else
        Result := fPadL('-', 166, '-') + #13#10;
    End
    Else
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 193, '-') + #13#10
      Else
        Result := fPadL('-', 168, '-') + #13#10;
    End;
  end;

  function LinhaSeparacaoAlteraValor: string;
  begin
    If fTamCodIte = 5 Then
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 180, '-') + #13#10
      Else
        Result := fPadL('-', 155, '-') + #13#10;
    End
    Else
    Begin
      If fCfgSis('MKGDOC',varBoolean) Then
        Result := fPadL('-', 182, '-') + #13#10
      Else
        Result := fPadL('-', 168, '-') + #13#10;
    End;
  end;

begin
  { lista os itens incluidos }

  strItensInseridos := '';
  blnVendaPerd := False;

  For item In FParams.MatItens() Do
    If Not FCdsItens.Locate('SEQDET', item.strSeqDet, []) Then
    Begin
      if fTamCodIte = 5 then
      begin
        If fCfgSis('MKGDOC',varBoolean) Then
        Begin
          If strItensInseridos = '' Then
            strItensInseridos := #13#10 + 'Produtos incluídos:' + #13#10 +
              LinhaSeparacaoInclusao +
              '| Código | Descrição                         | Emp |   UN   | Marca      | Cód. Fab.  |TAB.|    Quantidade |  Vr. Unitário |     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
              LinhaSeparacaoInclusao;
        End
        Else
        Begin
          If strItensInseridos = '' Then
            strItensInseridos := #13#10 + 'Produtos incluídos:' + #13#10 +
              LinhaSeparacaoInclusao +
              '| Código | Descrição                         | Emp |   UN   | Marca      | Cód. Fab.  |    Quantidade |  Vr. Unitário |     Vr. Total |' + #13#10 +
              LinhaSeparacaoInclusao;
        End;
      end
      else
      begin
        If fCfgSis('MKGDOC',varBoolean) Then
        Begin
          If strItensInseridos = '' Then
            strItensInseridos := #13#10 + 'Produtos incluídos:' + #13#10 +
              LinhaSeparacaoInclusao +
              '| Código   | Descrição                         | Emp |   UN   | Marca      | Cód. Fab.  |TAB.|    Quantidade |  Vr. Unitário |     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
              LinhaSeparacaoInclusao;
        End
        Else
        Begin
          If strItensInseridos = '' Then
            strItensInseridos := #13#10 + 'Produtos incluídos:' + #13#10 +
              LinhaSeparacaoInclusao +
              '| Código   | Descrição                         | Emp |   UN   | Marca      | Cód. Fab.  |    Quantidade |  Vr. Unitário |     Vr. Total |' + #13#10 +
              LinhaSeparacaoInclusao;
        End;
      end;
      strItensInseridos :=
        strItensInseridos + '| ' + fPadC(item.strCodIte, fTamCodIte + 1) + ' ' +
                            '| ' + fPadR(item.strDesIte, 33) + ' ' +
                            '| ' + fPadC(item.strEmpIte, 03) + ' ' +
                            '| ' + fPadC(item.strSigUni, 06) + ' ' +
                            '| ' + fPadR(IfThen(Not fEmptyStr(item.strCodMar), fRetNomMarca(item.strCodMar), ''), 10) + ' ' +
                            '| ' + fPadR(item.strCodFab, 10) + ' ' +
                            IfThen(fCfgSis('MKGDOC',varBoolean), '| ' + fPadC(item.strTabPre, 3) + '', '') +
                            '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte), 13) + ' ' +
                            '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar), 13) + ' ' +
                            '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltTotIte), 13) + ' ';

      If fCfgSis('MKGDOC',varBoolean) Then
      Begin
        If TMargemMinima.PorPrecoCustoPreCus Then
        Begin
          strItensInseridos :=
            strItensInseridos + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarProCusIte), 7) + ' ' +
                                '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarPraCusIte), 7) + ' ';
        End
        Else If (TMargemMinima.PorCustoRealPreCus) Then
        Begin
          strItensInseridos :=
            strItensInseridos + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarIte), 7) + ' ' +
                                '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarLuc), 7) + ' ';
        End;
      End;

      strItensInseridos :=
        strItensInseridos + '| ' + #13#10;
    End;

  If strItensInseridos <> '' Then
      strItensInseridos := strItensInseridos +
        LinhaSeparacaoInclusao;

  { lista os produtos removidos }

  strItensRemovidos := '';

  FCdsItens.First;

  While Not FCdsItens.Eof Do
  Begin
    blnAchou := False;
    For item In FParams.MatItens() Do
      If item.strSeqDet = FCdsItens.FieldByName('SEQDET').AsString Then
      Begin
        blnAchou := True;
        Break;
      End;

    If FParams.ItensVendaPerdida() <> Nil Then
    Begin
      blnVendaPerd := FParams.ItensVendaPerdida.Count > 0;
    End;

    If Not blnAchou Then
    Begin
      if fTamCodIte = 5 then
      begin
        If strItensRemovidos = '' Then
          strItensRemovidos := #13#10 + 'Produtos removidos: ' + IIF(blnVendaPerd, 'Itens Incluidos no Vendas Perdidas', '') + #13#10 +
          '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' + #13#10 +
          '| Código | Descrição                         |   UN   |    Quantidade |  Vr. Unitário |     Vr. Total | Motivo                            | Observação                        |'+ #13#10 +
          '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' + #13#10 ;
      end
      else
      begin
          If strItensRemovidos = '' Then
            strItensRemovidos := #13#10 + 'Produtos removidos: ' + IIF(blnVendaPerd, 'Itens Incluidos no Vendas Perdidas', '') + #13#10 +
          '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' + #13#10 +
          '|  Código  | Descrição                         |   UN   |    Quantidade |  Vr. Unitário |     Vr. Total  | Motivo                            | Observação                        |'+ #13#10 +
          '---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------' + #13#10 ;
      end;

      strMotivo     := '';
      strObservacao := '';

      If (FParams.ItensVendaPerdida() <> Nil) Then
      begin
        For intContador := 0 To FParams.ItensVendaPerdida.Count -1 Do
        begin
          if (FCdsItens.FieldByName('CODITE').AsString = FParams.ItensVendaPerdida.items[intContador].strCodIte) then
          begin
            if (FParams.ItensVendaPerdida.items[intContador].strCodMot <> '') Then
            begin
              strMotivo     := fRetMotivoVendasPerdidas(FParams.ItensVendaPerdida.items[intContador].StrCodMot);
              strObservacao := FParams.ItensVendaPerdida.items[intContador].strObserv;
            end
            else
            begin
              strMotivo     := 'Item excluído na edição do doc.';
              strObservacao := strMotivo;
            end;

            Break;
          end;

        End;
      end;

      strItensRemovidos :=
        strItensRemovidos + '| ' + fPadC(FCdsItens.FieldByName('CODITE').AsString, fTamCodIte + 1) + ' ' +
                            '| ' + fPadR(FCdsItens.FieldByName('DESCRI').AsString, 33) + ' ' +
                            '| ' + fPadC(FCdsItens.FieldByName('SIGUNI').AsString, 06) + ' ' +
                            '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FCdsItens.FieldByName('QTDITE').AsFloat), 13) + ' ' +
                            '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsItens.FieldByName('UNITAR').AsFloat), 13) + ' ' +
                            '| ' + fPadL(FormatFloat(fMskDigitos(2), FCdsItens.FieldByName('TOTITE').AsFloat), 13) + ' ' +
                            '| ' + fPadR(strMotivo, 33) + ' ' +
                            '| ' + fPadR(strObservacao, 33) + ' ' +
                            '| ' + #13#10;
    End;

    FCdsItens.Next;
  End;

  If strItensRemovidos <> '' Then
      strItensRemovidos := strItensRemovidos +
        '-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'+ #13#10 ;
  { lista os produtos alterados }

  strItensAlterados := '';

  For item In FParams.MatItens() Do
  Begin
    If FCdsItens.Locate('SEQDET', item.strSeqDet, []) Then
    Begin

      blnAlterouQtd := (fFormataFloat(item.fltQtdIte, fCfgSis('DECQTD', VarInteger)) <>
                        fFormataFloat(FCdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', VarInteger)));
      blnAlterouEmp := (item.strEmpIte <> FCdsItens.FieldByName('EMPITE').AsString);
      blnAlterouVlr := (fFormataFloat(item.fltUniTar , fCfgSis('DECUNI', VarInteger)) <>
                        fFormataFloat(FCdsItens.FieldByName('UNITAR').AsFloat, fCfgSis('DECUNI', VarInteger)));

      If FCdsItens.Locate('SEQDET', item.strSeqDet, []) And
         (blnAlterouQtd Or blnAlterouEmp) Then
      Begin
        If strItensAlterados = '' Then
        Begin
          If fTamCodIte = 5 Then
          Begin
            If fCfgSis('MKGDOC',varBoolean) Then
            Begin
              strItensAlterados := #13#10 + 'Produtos alterados (quantidade):' + #13#10 +
                LinhaSeparacaoAlteraQtde +
                '| Código | Descrição                         | Emp Ant | Emp Nova |   UN   | Marca      | Cód. Fab.  |TAB.|   Quant. Ant. |   Quant. Nova |  Vr. Unitário |     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
                LinhaSeparacaoAlteraQtde;
            End
            Else
            Begin
              strItensAlterados := #13#10 + 'Produtos alterados (quantidade):' + #13#10 +
                LinhaSeparacaoAlteraQtde +
                '| Código | Descrição                         | Emp Ant | Emp Nova |   UN   | Marca      | Cód. Fab.  |   Quant. Ant. |   Quant. Nova |  Vr. Unitário |     Vr. Total |' + #13#10 +
                LinhaSeparacaoAlteraQtde;
            End;
          End
          Else
          Begin
            If fCfgSis('MKGDOC',varBoolean) Then
            Begin
              strItensAlterados := #13#10 + 'Produtos alterados (quantidade):' + #13#10 +
                LinhaSeparacaoAlteraQtde +
                '|  Código  | Descrição                         | Emp Ant | Emp Nova |   UN   | Marca      | Cód. Fab.  |TAB.|   Quant. Ant. |   Quant. Nova |  Vr. Unitário |     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
                LinhaSeparacaoAlteraQtde;
            End
            Else
            Begin
              strItensAlterados := #13#10 + 'Produtos alterados (quantidade):' + #13#10 +
                LinhaSeparacaoAlteraQtde +
                '|  Código  | Descrição                         | Emp Ant | Emp Nova |   UN   | Marca      | Cód. Fab.  |   Quant. Ant. |   Quant. Nova |  Vr. Unitário |     Vr. Total |' + #13#10 +
                LinhaSeparacaoAlteraQtde;
            End;
          End;
        End;

        strItensAlterados :=
          strItensAlterados + '| ' + fPadC(item.strCodIte, fTamCodIte + 1) + ' ' +
                              '| ' + fPadR(item.strDesIte, 33) + ' ' +
                              '| ' + fPadC(FCdsItens.FieldByName('EMPITE').AsString, 08) + ' ' +
                              '| ' + fPadC(item.strEmpIte, 07) + ' ' +
                              '| ' + fPadC(item.strSigUni, 06) + ' ' +
                              '| ' + fPadR(IfThen(Not fEmptyStr(item.strCodMar), fRetNomMarca(item.strCodMar), ''), 10) + ' ' +
                              '| ' + fPadR(item.strCodFab, 10) + ' ' +
                              IfThen(fCfgSis('MKGDOC',varBoolean), '| ' + fPadC(item.strTabPre, 3) + '', '') +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FCdsItens.FieldByName('QTDITE').AsFloat), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltTotIte), 13) + ' ';

        If fCfgSis('MKGDOC',varBoolean) Then
        Begin
          If TMargemMinima.PorPrecoCustoPreCus Then
          Begin
            strItensAlterados :=
              strItensAlterados + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarProCusIte), 7) + ' ' +
                                  '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarPraCusIte), 7) + ' ';
          End
          Else If (TMargemMinima.PorCustoRealPreCus) Then
          Begin
            strItensAlterados :=
              strItensAlterados + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarIte), 7) + ' ' +
                                  '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarLuc), 7) + ' ';
          End;
        End;

        strItensAlterados := strItensAlterados +
                                  '| ' + #13#10;

        If strItensAlterados <> '' Then
          strItensAlterados := strItensAlterados + LinhaSeparacaoAlteraQtde;

      End;

      If FCdsItens.Locate('SEQDET', item.strSeqDet, []) And
         (blnAlterouVlr) Then
      Begin
        If fTamCodIte = 5 Then
        Begin
          If fCfgSis('MKGDOC',varBoolean) Then
          Begin
            strItensAlterados := strItensAlterados + #13#10 + 'Produtos alterados (valor):' + #13#10 +
                LinhaSeparacaoAlteraValor +
                '| Código | Descrição                         | Emp     |   UN   | Marca      | Cód. Fab.  |TAB.|   Quant.      |  Vr Unit. Ant.|  Vr Unit. Novo|     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
                LinhaSeparacaoAlteraValor;
          End
          Else
          Begin
            strItensAlterados := strItensAlterados + #13#10 + 'Produtos alterados (valor):' + #13#10 +
                LinhaSeparacaoAlteraValor +
                '| Código | Descrição                         | Emp     |   UN   | Marca      | Cód. Fab.  |   Quant.      |  Vr Unit. Ant.|  Vr Unit. Novo|     Vr. Total |' + #13#10 +
                LinhaSeparacaoAlteraValor;
          End;
        End
        Else
        Begin
          If fCfgSis('MKGDOC',varBoolean) Then
          Begin
            strItensAlterados := strItensAlterados + #13#10 + 'Produtos alterados (valor):' + #13#10 +
                LinhaSeparacaoAlteraValor +
                '|  Código  | Descrição                         | Emp     |   UN   | Marca      | Cód. Fab.  |TAB.|   Quant.      |  Vr Unit. Ant.|  Vr Unit. Novo|     Vr. Total | %M.PROP | %M.PRAT |' + #13#10 +
                LinhaSeparacaoAlteraValor;
          End
          Else
          Begin
            strItensAlterados := strItensAlterados + #13#10 + 'Produtos alterados (valor):' + #13#10 +
                LinhaSeparacaoAlteraValor +
                '|  Código  | Descrição                         | Emp     |   UN   | Marca      | Cód. Fab.  |   Quant.      |  Vr Unit. Ant.|  Vr Unit. Novo|     Vr. Total |' + #13#10 +
                LinhaSeparacaoAlteraValor;
          End;
        End;

        strItensAlterados :=
          strItensAlterados + '| ' + fPadC(item.strCodIte, fTamCodIte + 1) + ' ' +
                              '| ' + fPadR(item.strDesIte, 33) + ' ' +
                              '| ' + fPadC(item.strEmpIte, 07) + ' ' +
                              '| ' + fPadC(item.strSigUni, 06) + ' ' +
                              '| ' + fPadR(IfThen(Not fEmptyStr(item.strCodMar), fRetNomMarca(item.strCodMar), ''), 10) + ' ' +
                              '| ' + fPadR(item.strCodFab, 10) + ' ' +
                              IfThen(fCfgSis('MKGDOC',varBoolean), '| ' + fPadC(item.strTabPre, 3) + '', '') +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsItens.FieldByName('UNITAR').AsFloat), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar), 13) + ' ' +
                              '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltTotIte), 13) + ' ';

        If fCfgSis('MKGDOC',varBoolean) Then
        Begin
          If TMargemMinima.PorPrecoCustoPreCus Then
          Begin
            strItensAlterados :=
              strItensAlterados + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarProCusIte), 7) + ' ' +
                                  '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarPraCusIte), 7) + ' ';
          End
          Else If (TMargemMinima.PorCustoRealPreCus) Then
          Begin
            strItensAlterados :=
              strItensAlterados + '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarIte), 7) + ' ' +
                                  '| ' + fPadL(FormatFloat(fMskDigitos(2), item.fltMarLuc), 7) + ' ';
          End;
        End;

        strItensAlterados := strItensAlterados +
                              '| ' + #13#10;

        strItensAlterados := strItensAlterados + LinhaSeparacaoAlteraValor;
      End;
    End;
  End;


  Result := IIF(strItensInseridos <> '', strItensInseridos + #13#10, '') +
            IIF(strItensRemovidos <> '', strItensRemovidos + #13#10, '') +
            IIF(strItensAlterados <> '', strItensAlterados + #13#10, '');
end;

function TListarModificacoesItensPedido.fGetModificacoes: String;
begin
  Case FParams.Tipo() Of
    tlmCRMTexto:
      Result := fGetModificacoesParaMensagem();
    tlmCRMEmail:
      Result := fGetModificacoesParaEmail();
    tlmMsgBloq:
      Result := fGetModificacoesBloq();
  End;
end;

function TListarModificacoesItensPedido.fGetModificacoesBloq: String;
  Var
    item: TDadosFechamento;
    blnAchou: Boolean;
    strItensInseridos: String;
    strItensRemovidos: String;
    strItensAlterados: String;
    blnAlterouQtd: Boolean;
    blnAlterouVlr: Boolean;
begin
  { lista os itens incluidos }

  strItensInseridos := '';

  For item In FParams.MatItens() Do
    If Not FCdsItens.Locate('SEQDET', item.strSeqDet, []) Then
    Begin
      If strItensInseridos = '' Then
        strItensInseridos := 'Produtos incluídos:' + #13#10 +
          '-------------------------------------------------------------------------------' + #13#10;

      strItensInseridos := strItensInseridos + Concat(item.strCodIte, ' - ', item.strDesIte) + #13#10;
    End;

  { lista os produtos removidos }
  strItensRemovidos := '';

  FCdsItens.First;
  While Not FCdsItens.Eof Do
  Begin
    blnAchou := False;
    For item In FParams.MatItens() Do
      If item.strSeqDet = FCdsItens.FieldByName('SEQDET').AsString Then
      Begin
        blnAchou := True;
        Break;
      End;

    If Not blnAchou Then
    Begin
      If strItensRemovidos = '' Then
        strItensRemovidos := 'Produtos removidos:' + #13#10 +
          '-------------------------------------------------------------------------------' + #13#10;

      strItensRemovidos := strItensRemovidos + Concat(FCdsItens.FieldByName('CODITE').AsString, ' - ', FCdsItens.FieldByName('DESCRI').AsString) + #13#10;
    End;

    FCdsItens.Next;
  End;

  { lista os produtos alterados }

  strItensAlterados := '';

  For item In FParams.MatItens() Do
  Begin
    If FCdsItens.Locate('SEQDET', item.strSeqDet, []) Then
    Begin
      blnAlterouQtd := (fFormataFloat(item.fltQtdIte, fCfgSis('DECQTD', VarInteger)) <>
                        fFormataFloat(FCdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', VarInteger)));
      blnAlterouVlr := (FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsItens.FieldByName('UNITAR').AsFloat) <>
                        FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), IIF(FParams.ImpRateadoDescOrgaoPublico(), item.fltUniTmp, item.fltUnitar)));

      If (Not blnAlterouQtd) And (Not blnAlterouVlr) Then
        Continue;

      If strItensAlterados = '' Then
        strItensAlterados := 'Produtos alterados:' + #13#10 +
          '-------------------------------------------------------------------------------' + #13#10;

      strItensAlterados := strItensAlterados + Concat(item.strCodIte, ' - ', item.strDesIte) + #13#10;

      If blnAlterouQtd Then
        strItensAlterados := strItensAlterados + fPadL('', 5) +
                             ' Qtd Anterior: ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FCdsItens.FieldByName('QTDITE').AsFloat), 13) +
                             fPadL('', 5) +
                             ' Qtd Atual: ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte), 13) + #13#10;

      If blnAlterouVlr Then
        strItensAlterados := strItensAlterados + fPadL('', 5) +
                             ' Vlr Anterior: ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsItens.FieldByName('UNITAR').AsFloat), 13) +
                             fPadL('', 5) +
                             ' Vlr Atual: ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar), 13) + #13#10;
    End;
  End;

  Result := IIF(strItensInseridos <> '', strItensInseridos + #13#10, '') +
            IIF(strItensRemovidos <> '', strItensRemovidos + #13#10, '') +
            IIF(strItensAlterados <> '', strItensAlterados + #13#10, '');
end;

function TListarModificacoesItensPedido.fGetModificacoesParaEmail: String;
  Const
    borderStyle = 'border-collapse: collapse;border:1px solid;';
  Var
    item: TDadosFechamento;
    blnAchou: Boolean;
    strItensInseridos: String;
    strItensRemovidos: String;
    strItensAlterados: String;
begin
  { lista os itens incluidos }

  strItensInseridos := '';

  For item In FParams.MatItens() Do
    If Not FCdsItens.Locate('SEQDET', item.strSeqDet, []) Then
    Begin
      If strItensInseridos = '' Then
        strItensInseridos := '<br>' + 'Produtos incluídos:' + '<br><br>' +
          '<table style="' + borderStyle + '">' +
            '<tr>' +
              '<th style="' + borderStyle + 'text-align: center">Código</th> ' +
              '<th style="' + borderStyle + 'text-align: left">Descrição</th> ' +
              '<th style="' + borderStyle + 'text-align: center">UN</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Quant. Ant.</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Quant. Nova</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Unitário</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Total</th> ' +
            '</tr>';

      strItensInseridos :=
        strItensInseridos +
            '<tr>' +
              '<td style="' + borderStyle + 'text-align: center">' + item.strCodIte + '</td> ' +
              '<td style="' + borderStyle + 'text-align: left">' + item.strDesIte + '</td> ' +
              '<td style="' + borderStyle + 'text-align: center">' + item.strSigUni + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(2), item.fltTotIte) + '</td> ' +
            '</tr>';
    End;

  If strItensInseridos <> '' Then
      strItensInseridos := strItensInseridos + '</table>' + '<br>';

  { lista os produtos removidos }

  strItensRemovidos := '';

  FCdsItens.First;

  While Not FCdsItens.Eof Do
  Begin
    blnAchou := False;
    For item In FParams.MatItens() Do
      If item.strSeqDet = FCdsItens.FieldByName('SEQDET').AsString Then
      Begin
        blnAchou := True;
        Break;
      End;

    If Not blnAchou Then
    Begin
      If strItensRemovidos = '' Then
        strItensRemovidos := '<br>' + 'Produtos removidos:' + '<br><br>' +
          '<table style="' + borderStyle + '">' +
            '<tr>' +
              '<th style="' + borderStyle + 'text-align: center">Código</th> ' +
              '<th style="' + borderStyle + 'text-align: left">Descrição</th> ' +
              '<th style="' + borderStyle + 'text-align: center">UN</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Quantidade</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Unitário</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Total</th> ' +
            '</tr>';

      strItensRemovidos :=
        strItensRemovidos +
            '<tr>' +
              '<td style="' + borderStyle + 'text-align: center">' + FCdsItens.FieldByName('CODITE').AsString + '</td> ' +
              '<td style="' + borderStyle + 'text-align: left">' + FCdsItens.FieldByName('DESCRI').AsString + '</td> ' +
              '<td style="' + borderStyle + 'text-align: center">' + FCdsItens.FieldByName('SIGUNI').AsString + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FCdsItens.FieldByName('QTDITE').AsFloat) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsItens.FieldByName('UNITAR').AsFloat) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(2), FCdsItens.FieldByName('TOTITE').AsFloat) + '</td> ' +
            '</tr>';
    End;

    FCdsItens.Next;
  End;

  If strItensRemovidos <> '' Then
      strItensRemovidos := strItensRemovidos + '</table>' + '<br>';

  { lista os produtos alterados }

  strItensAlterados := '';

  For item In FParams.MatItens() Do
    If FCdsItens.Locate('SEQDET', item.strSeqDet, []) And
       (fFormataFloat(item.fltQtdIte, fCfgSis('DECQTD', VarInteger)) <>
        fFormataFloat(FCdsItens.FieldByName('QTDITE').AsFloat, fCfgSis('DECQTD', VarInteger))) Then
    Begin
      If strItensAlterados = '' Then
        strItensAlterados := '<br>' + 'Produtos alterados (quantidade):' + '<br><br>' +
          '<table style="' + borderStyle + '">' +
            '<tr>' +
              '<th style="' + borderStyle + 'text-align: center">Código</th> ' +
              '<th style="' + borderStyle + 'text-align: left">Descrição</th> ' +
              '<th style="' + borderStyle + 'text-align: center">UN</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Quant. Ant.</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Quant. Nova</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Unitário</th> ' +
              '<th style="' + borderStyle + 'text-align: right">Vr. Total</th> ' +
            '</tr>';

      strItensAlterados :=
        strItensAlterados +
            '<tr>' +
              '<td style="' + borderStyle + 'text-align: center">' + item.strCodIte + '</td> ' +
              '<td style="' + borderStyle + 'text-align: left">' + item.strDesIte + '</td> ' +
              '<td style="' + borderStyle + 'text-align: center">' + item.strSigUni + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), FCdsItens.FieldByName('QTDITE').AsFloat) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), item.fltQtdIte) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), item.fltUnitar) + '</td> ' +
              '<td style="' + borderStyle + 'text-align: right">' + FormatFloat(fMskDigitos(2), item.fltTotIte) + '</td> ' +
            '</tr>';
    End;

  If strItensAlterados <> '' Then
      strItensAlterados := strItensAlterados + '</table>' + '<br>';

  Result := IIF(strItensInseridos <> '', strItensInseridos + '<br>', '') +
            IIF(strItensRemovidos <> '', strItensRemovidos + '<br>', '') +
            IIF(strItensAlterados <> '', strItensAlterados + '<br>', '');
end;

procedure TListarModificacoesItensPedido.pCarregarItens;
  Var
    qryItens: TUniQuery;
begin
  qryItens := fCriaQuery(nil);

  qryItens.SQL.Text := ' SELECT ' +
                       '   SQL_NO_CACHE ' +
                       '   F.AUTOINCREM AS SEQDET, ' +
                       '   F.FDO_CODITE AS CODITE, ' +
                       '   F.FDO_DESCRI AS DESCRI, ' +
                       '   F.FDO_QTDITE AS QTDITE, ' +
                       '   U.UNI_SIGUNI AS SIGUNI, ' +
                           IIF(FParams.ConsiderarUniDig(), 'F.FDO_UNIDIG', 'F.FDO_UNITAR') + ' AS UNITAR, ' +
                       '   F.FDO_TOTITE AS TOTITE, ' +
                       '   F.FDO_EMPITE AS EMPITE ' +
                       ' FROM ' +
                       '   FATDOR F ' +
                       '   INNER JOIN CADUNI U ' +
                       '     ON U.UNI_CODUNI = F.FDO_UNIDAD ' +
                       ' WHERE FDO_NUMDOC = :NUMDOC ' +
                       '   AND FDO_ESPDOC = :ESPDOC ' +
                       '   AND FDO_CODEMP = :CODEMP; ' ;

  qryItens.ParamByName('NUMDOC').AsString     := FParams.NumDoc();
  qryItens.ParamByName('ESPDOC').AsString     := FParams.EspDoc();
  qryItens.ParamByName('CODEMP').AsString     := FParams.CodEmp();

  qryItens.Open;

  FCdsItens := fCriaClientDatSet(qryItens);

  FreeAndNil(qryItens);
end;

{ TListarModificacoesParametros }

function TParametrosItensModificados.CodEmp: String;
begin
  Result := FCodEmp;
end;

function TParametrosItensModificados.CodEmp(
  const Value: String): IParametrosItensModificados;
begin
  FCodEmp := Value;
  Result := Self;
end;

constructor TParametrosItensModificados.Create;
begin
  FCodEmp := '';
  FEspDoc := '';
  FCodEmp := '';
  FTipo   := tlmCRMTexto;
end;

function TParametrosItensModificados.ConsiderarUniDig: Boolean;
begin
  Result := FConsiderarUniDig;
end;

function TParametrosItensModificados.ConsiderarUniDig(
  const Value: Boolean): IParametrosItensModificados;
begin
  FConsiderarUniDig := Value;
  Result := Self;
end;

function TParametrosItensModificados.EspDoc(
  const Value: String): IParametrosItensModificados;
begin
  FEspDoc := Value;
  Result := Self;
end;

function TParametrosItensModificados.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParametrosItensModificados.Fields(
  const Value: TStringArray): IParametrosItensModificados;
begin
  FFields := Value;
  Result := Self;
end;

function TParametrosItensModificados.Fields: TStringArray;
begin
  Result := FFields;
end;

function TParametrosItensModificados.ItensVendaPerdida(
  const Value: TObjectList<TItemVendasPerdidas>): IParametrosItensModificados;
begin
  FItensVendaPerdida:=  Value;
  Result := Self;
end;

function TParametrosItensModificados.ItensVendaPerdida: TObjectList<TItemVendasPerdidas>;
begin
  Result := FItensVendaPerdida;
end;

function TParametrosItensModificados.Labels(
  const Value: TStringArray): IParametrosItensModificados;
begin
  FLabels :=  Value;
  Result := Self;
end;

function TParametrosItensModificados.Labels: TStringArray;
begin
  Result := FLabels;
end;

function TParametrosItensModificados.MatItens(
  const Value: TMatrizFechamento): IParametrosItensModificados;
begin
  FMatItens := Value;
  Result := Self;
end;

function TParametrosItensModificados.MatItens: TMatrizFechamento;
begin
  Result := FMatItens;
end;

class function TParametrosItensModificados.New: IParametrosItensModificados;
begin
  Result := TParametrosItensModificados.Create();
end;

function TParametrosItensModificados.NumDoc: String;
begin
  Result := FNumDoc;
end;


function TParametrosItensModificados.NumDoc(
  const Value: String): IParametrosItensModificados;
begin
  FNumDoc := Value;
  Result := Self;
end;

function TParametrosItensModificados.Tipo(
  const Value: TTipoListaModificacoes): IParametrosItensModificados;
begin
  FTipo := Value;
  Result := Self;
end;

function TParametrosItensModificados.Tipo: TTipoListaModificacoes;
begin
  Result := FTipo;
end;

function TParametrosItensModificados.Values(
  const Value: TVariantArray): IParametrosItensModificados;
begin
  FValues := Value;
  Result := Self;
end;

function TParametrosItensModificados.Values: TVariantArray;
begin
  Result := FValues;
end;

function TParametrosItensModificados.ImpRateadoDescOrgaoPublico(
  const Value: Boolean): IParametrosItensModificados;
begin
  FImpRateadoDescOrgaoPublico := Value;
  Result := Self;
end;

function TParametrosItensModificados.ImpRateadoDescOrgaoPublico: Boolean;
begin
  Result := FImpRateadoDescOrgaoPublico;
end;

{ TListarModificacoesPedido }

constructor TListarModificacoesPedido.Create(
  AParams: IParametrosItensModificados);
begin
  FParams := AParams;
  pCarregarDocumento();
end;

destructor TListarModificacoesPedido.Destroy;
begin
  FreeAndNil(FCdsPedido);
  inherited;
end;

function TListarModificacoesPedido.fGetModificacoes: String;
var
  LModificacoesItens: IListarModificacoesItensPedido;
  strModificacoes: String;
  i: Integer;

  function fFormatacaoEspecifica(Const AValue: String): String;
  var
    strAux: TStrings;
  begin
    Result := AValue;
    strAux := TStringList.Create;

    Try
      If Pos('|>', AValue) > 0 Then
      Begin
        ExtractStrings(['|', '>'], [' '], PChar(AValue), strAux);

        If (strAux.Count = 2) Then
          Result := Concat(strAux[0], ' ', fFormataCondPag(strAux[1]));
      End;
    Finally
      strAux.Free;
    End;
  end;
begin
  strModificacoes := '';

  For i := 0 To Length(FParams.Fields()) - 1 Do
  Begin
    If (Trim(VarToString(FCdsPedido.FieldByName(FParams.Fields()[i]).Value)) <> Trim(VarToString(FParams.Values()[i]))) Then
    Begin
      If Pos(FParams.Fields()[i], 'FGO_TOTFRE;FGO_DESACE;FGO_DESESP;FGO_PORDES;') > 0 Then
        strModificacoes := strModificacoes + Format('%s Anterior: %s', [FParams.Labels()[i],
                                                                        fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FCdsPedido.FieldByName(FParams.Fields()[i]).AsFloat), 13)]) + sLineBreak +
                                             Format('%s Atual...: %s', [FParams.Labels()[i],
                                                                        fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), FParams.Values()[i]), 13)]) + sLineBreak + sLineBreak
      Else
        strModificacoes := strModificacoes + Format('%s Anterior: %s', [FParams.Labels()[i],
                                                                        fFormatacaoEspecifica(FCdsPedido.FieldByName(FParams.Fields()[i]).AsString)]) + sLineBreak +
                                             Format('%s Atual...: %s', [FParams.Labels()[i],
                                                                        fFormatacaoEspecifica(VarToString(FParams.Values()[i]))]) + sLineBreak + sLineBreak;
    End;
  End;

  LModificacoesItens := TListarModificacoesItensPedido.New(FParams);

  strModificacoes := strModificacoes + LModificacoesItens.fGetModificacoes();

  Result := IIF(Not fEmptyStr(strModificacoes), sLineBreak + strModificacoes, strModificacoes);
end;

class function TListarModificacoesPedido.New(
  AParams: IParametrosItensModificados): IListarModificacoesItensPedido;
begin
  Result := TListarModificacoesPedido.Create(AParams);
end;

procedure TListarModificacoesPedido.pCarregarDocumento;
Var
  qryPedido: TUniQuery;
  strSQL: String;
  i: Integer;
  intTipFre: Integer;
begin
  qryPedido := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    For i := 0 To Length(FParams.Fields()) - 1 Do
    Begin
      If FParams.Fields()[i] = 'FGO_TIPFRE' Then
      Begin
        strSQL := strSQL + 'CASE G.FGO_TIPFRE';
        For intTipFre In TiposFrete Do
         strSQL := strSQL + ' WHEN "' + IntToStr(intTipFre) + '" THEN "' + fDescricaoFrete(IntToStr(intTipFre)) + '"';
        strSQL := strSQL + 'END AS FGO_TIPFRE' + IIF(i = Length(FParams.Fields()) - 1, '', ', ');
      End
      Else
        strSQL := strSQL + FParams.Fields()[i] + IIF(i = Length(FParams.Fields()) - 1, '', ', ');
    End;

    If Length(FParams.Fields()) = 0 Then
      strSQL := strSQL + ' G.* ';

    strSQL := strSQL + ' FROM FATGOR G ';
    strSQL := strSQL + ' JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ';
    strSQL := strSQL + ' LEFT JOIN CADOPE O ON O.OPE_CODOPE = G.FGO_CODVEN ';
    strSQL := strSQL + ' LEFT JOIN CADFPG F ON F.FPG_CODIGO = G.FGO_CODFPG ';
    strSQL := strSQL + ' LEFT JOIN CADTRA T ON T.TRA_CODTRA = G.FGO_CODTRA ';
    strSQL := strSQL + ' LEFT JOIN CADCND N ON N.CND_CODIGO = G.FGO_CODCND ';
    strSQL := strSQL + ' WHERE FGO_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND FGO_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND FGO_CODEMP = :CODEMP ';

    qryPedido.SQL.Add(strSQL);

    qryPedido.ParamByName('NUMDOC').AsString := FParams.NumDoc();
    qryPedido.ParamByName('ESPDOC').AsString := FParams.EspDoc();
    qryPedido.ParamByName('CODEMP').AsString := FParams.CodEmp();

    qryPedido.Open;
    FCdsPedido := fCriaClientDatSet(qryPedido);
  Finally
    FreeAndNil(qryPedido);
  End;
end;

{ TListarProdutosDevolvidos }

constructor TListarProdutosDevolvidos.Create(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli: String);
begin
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FSerie_ := strSerie ;
  FCodCli := strCodCli;
end;

function TListarProdutosDevolvidos.fGetProdutos: String;
  Var
    qryItens: TUniQuery;
begin
  Result := '';
  qryItens := fCriaQuery(nil);

  Try
    qryItens.SQL.Text :=
      ' SELECT SQL_NO_CACHE ' +
      '   DET_CODITE AS CODITE, ' +
      '   DET_DESCRI AS DESCRI, ' +
      '   UNI_SIGUNI AS SIGUNI, ' +
      '   DET_QTDITE AS QTDITE, ' +
      '   DET_UNITAR AS UNITAR, ' +
      '   DET_TOTITE AS TOTITE, ' +
      '   CONCAT(DET_DOCDEV, "-", DET_ESPDEV, "-", DET_EMPDEV) AS DOCDEV ' +
      ' FROM MOVDET ' +
      '   INNER JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD ' +
      '  WHERE DET_NUMDOC = ' + FNumDoc.QuotedString +
      '    AND DET_ESPDOC = ' + FEspDoc.QuotedString +
      '    AND DET_CODEMP = ' + FCodEmp.QuotedString +
      '    AND DET_SERIE_ = ' + FSerie_.QuotedString +
      '    AND DET_CODCLI = ' + FCodCli.QuotedString ;

    qryItens.Open;

    While Not qryItens.Eof Do
    Begin
      if fTamCodIte = 5 then
      begin
        If Result = '' Then
        Result := '<<csq>>' + 'Produtos devolvidos:' + '<<csq>>' +
          '-----------------------------------------------------------------------------------------------------------------------------' + '<<csq>>' +
          '| Código | Descrição                         |   UN   |    Quantidade |  Vr. Unitário |     Vr. Total | Documento de Venda  |' + '<<csq>>' +
          '-----------------------------------------------------------------------------------------------------------------------------' + '<<csq>>' ;
      end
      else
      begin
        If Result = '' Then
        Result := '<<csq>>' + 'Produtos devolvidos:' + '<<csq>>' +
          '-----------------------------------------------------------------------------------------------------------------------------' + '<<csq>>' +
          '|  Código  | Descrição                         |   UN   |    Quantidade |  Vr. Unitário |     Vr. Total | Documento de Venda  |' + '<<csq>>' +
          '-----------------------------------------------------------------------------------------------------------------------------' + '<<csq>>' ;
      end;
      Result := Result +
        '| ' + fPadC(qryItens.FieldByName('CODITE').AsString, fTamCodIte + 1) + ' ' +
        '| ' + fPadR(qryItens.FieldByName('DESCRI').AsString, 33) + ' ' +
        '| ' + fPadC(qryItens.FieldByName('SIGUNI').AsString, 06) + ' ' +
        '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECQTD', VarInteger)), qryItens.FieldByName('QTDITE').AsFloat), 13) + ' ' +
        '| ' + fPadL(FormatFloat(fMskDigitos(fCfgSis('DECUNI', VarInteger)), qryItens.FieldByName('UNITAR').AsFloat), 13) + ' ' +
        '| ' + fPadL(FormatFloat(fMskDigitos(2), qryItens.FieldByName('TOTITE').AsFloat), 13) + ' ' +
        '| ' + fPadR(qryItens.FieldByName('DOCDEV').AsString, 19) + ' ' +
        '| ' + '<<csq>>';

      qryItens.Next;
    End;

    If Result <> '' Then
      Result := Result +
        '-----------------------------------------------------------------------------------------------------------------------------' + '<<csq>>' ;

  Finally
    FreeAndNil(qryItens);
  End;
end;

class function TListarProdutosDevolvidos.New(strNumDoc, strEspDoc, strCodEmp,
  strSerie, strCodCli: String): IListarProdutosDevolvidos;
begin
  Result := TListarProdutosDevolvidos.Create(strNumDoc, strEspDoc, strCodEmp,
    strSerie, strCodCli);
end;

{ TObjectBackupVar }

constructor TObjectBackupVar.Create(AObj: TObject);
begin
  FObj := AObj;
  FVar := TDictionary<String,Variant>.Create;
end;

destructor TObjectBackupVar.Destroy;
begin
  FVar.Free;
  inherited;
end;

procedure TObjectBackupVar.GetBackupVar(ANames: array of String);
  Var
    LVar: String;
begin
  For LVar In ANames Do
    SetPropValue(FObj, LVar, FVar[LVar]);
end;

procedure TObjectBackupVar.SetBackupVar(ANames: array of String);
  Var
    LVar: String;
begin
  For LVar In ANames Do
    FVar.AddOrSetValue(LVar, GetPropValue(FObj, LVar));
end;

{ TRegravarLotesPedidoWMS }

constructor TRegravarLotesPedidoWMS.Create(ANumDoc, AEspDoc, ACodEmp: String);
begin
  pCarregarLotDor(ANumDoc, AEspDoc, ACodEmp);
end;

destructor TRegravarLotesPedidoWMS.Destroy;
begin
  FreeAndNil(FLotDor);
  inherited;
end;

procedure TRegravarLotesPedidoWMS.pCarregarLotDor(ANumDoc, AEspDoc, ACodEmp: String);
Var
  LSQL: String;
  LQry: TUniQuery;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT SQL_NO_CACHE ';
  LSQL := LSQL + '   LOTDOR.* ';
  LSQL := LSQL + ' FROM ';
  LSQL := LSQL + '   FATDOR ';
  LSQL := LSQL + '   INNER JOIN LOTDOR ';
  LSQL := LSQL + '     ON LDO_SEQFDO = FATDOR.AUTOINCREM ';
  LSQL := LSQL + ' WHERE FDO_NUMDOC = ' + ANumDoc.QuotedString();
  LSQL := LSQL + '   AND FDO_ESPDOC = ' + AEspDoc.QuotedString();
  LSQL := LSQL + '   AND FDO_CODEMP = ' + ACodEmp.QuotedString();

  LQry := fCriarQuery(LSQL);
  Try
    LQry.Open;
    FLotDor := fCriaClientDatset(LQry);
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TRegravarLotesPedidoWMS.pRegravarLotesItem(AIdAnterior, AIdNovo: String);
Var
  LQry: TUniQuery;
  I: Integer;
begin
  LQry := fCriarQuery('SELECT * FROM LOTDOR WHERE FALSE');
  Try
    LQry.Open;

    FLotDor.Filtered := False;
    FLotDor.Filter   := 'LDO_SEQFDO = ' + AIdAnterior.QuotedString();
    FLotDor.Filtered := True;

    FLotDor.First;
    While Not FLotDor.Eof Do
    Begin
      LQry.Append;

      For I := 0 To FLotDor.FieldCount -1 Do
        LQry.Fields[I].Value := FLotDor.Fields[I].Value;

      LQry.FieldByName('LDO_SEQFDO').AsString := AIdNovo;
      LQry.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTDOR', VS_strCodEmp);

      LQry.Post;
      FLotDor.Next;
    End;

  Finally
    FreeAndNil(LQry);
  End;
end;

{ TDigImp }

function TDigImp.fGravarDIGIMP(strSeqGer: String): Boolean;
var
  qryDigImp : TUniQuery;
const
  strSQL = 'INSERT INTO DIGIMP (AUTOINCREM, IMP_SEQGER, IMP_ALTERA) VALUES (:AUTINC, :SEQGER, :ALTERA)';
begin

  Result := True;

  If strSeqGer.IsEmpty Then
    Exit(False);

  If Not Assigned(Self.stlValores_Alterados) Then
    Exit(False);

  If (stlValores_Alterados.Count > 0) Then
  Begin

    qryDigImp := fCriaQuery();

    Try

      qryDigImp.Close;
      qryDigImp.SQL.Clear;
      qryDigImp.SQL.Add(strSQL);

      qryDigImp.ParamByName('AUTINC').AsString := fRetAutoIncrem('DIGIMP', VS_strCodEmp);
      qryDigImp.ParamByName('SEQGER').AsString := strSeqGer;
      qryDigImp.ParamByName('ALTERA').AsString := Self.stlValores_Alterados.Text;

      Try
        qryDigImp.ExecSQL;
      Except
        Result := False;
      End;

    Finally
      FreeAndNil(qryDigImp);
    End;

  End;

end;

function TDigImp.fGravarNOTIMP(strSeqGer: String): Boolean;
var
  qryDigImp : TUniQuery;
const
  strSQL = 'INSERT INTO NOTIMP (AUTOINCREM, IMP_SEQGER, IMP_ALTERA) VALUES (:AUTINC, :SEQGER, :ALTERA)';
begin

  Result := True;

  If strSeqGer.IsEmpty Then
    Exit(False);

  If Not Assigned(Self.stlValores_Alterados) Then
    Exit(False);

  If (stlValores_Alterados.Count > 0) Then
  Begin

    qryDigImp := fCriaQuery();

    Try

      qryDigImp.Close;
      qryDigImp.SQL.Clear;
      qryDigImp.SQL.Add(strSQL);

      qryDigImp.ParamByName('AUTINC').AsString := fRetAutoIncrem('NOTIMP', VS_strCodEmp);
      qryDigImp.ParamByName('SEQGER').AsString := strSeqGer;
      qryDigImp.ParamByName('ALTERA').AsString := Self.stlValores_Alterados.Text;

      Try
        qryDigImp.ExecSQL;
      Except
        Result := False;
      End;

    Finally
      FreeAndNil(qryDigImp);
    End;

  End;

end;

procedure TDigImp.pLimpar;
begin
  Self.stlValores_Alterados.Clear;
  Self.blnOperadorDigitouImpostos := False;
end;

constructor TDigImp.Create;
begin
  stlValores_Alterados := TStringList.Create;
end;

destructor TDigImp.Destroy;
begin
  FreeAndNil(stlValores_Alterados);
  inherited;
end;

{ TDadosItemNotaEspelho }

function TDadosItemNotaEspelho.GetDesAce: Double;
begin
  Result := FfltDesAce;
end;

procedure TDadosItemNotaEspelho.SetDesAce(Value: Double);
begin
  FfltDesAce := Value;
end;

function TDadosItemNotaEspelho.GetDesEsp: Double;
begin
  Result := FfltDesEsp;
end;

procedure TDadosItemNotaEspelho.SetDesEsp(Value: Double);
begin
  FfltDesEsp := Value;
end;

{ TDadosFechamento }

function TDadosFechamento.GetAlqFcp: Double;
begin
  Result := 0;
  if (Self.GetValFcpST = 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltPerFcp;
end;

function TDadosFechamento.GetAlqFcpST: Double;
begin
  Result := 0;
  if (Self.fltValRet > 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltPerFcp;
end;

function TDadosFechamento.GetBasFcp: Double;
begin
  Result := 0;
  if (Self.GetValFcpST = 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltBasFcp;
end;

function TDadosFechamento.GetBasFcpST: Double;
begin
  Result := 0;
  if (Self.fltValRet > 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltBasFcp;
end;

function TDadosFechamento.GetValFcp: Double;
begin
  Result := 0;
  if (Self.GetValFcpST = 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltValFcp;
end;

function TDadosFechamento.GetValFcpST: Double;
begin
  Result := 0;
  if (Self.fltValRet > 0) then
    if Self.recDifalFCP.fltValFcp > 0 then
      Result := Self.recDifalFCP.fltValFcp;
end;

procedure TDadosFechamento.pSetBasIcm(VAlue: Double);
begin
  FBasIcm := Value;
end;

procedure TDadosFechamento.pSetClaFis(Value: String);
begin
   FClaFis := Value;
end;

{ TMatrizFechamentoHelper }

function TMatrizFechamentoHelper.fGetItemIndex(const intAutInc: Integer): Integer;
  Var
    intCont: Integer;
begin
  Result := -1;
  For intCont := 0 To Length(Self) -1 Do
  Begin
    If Self[intCont].intAutInc = intAutInc Then
      Exit(intCont);
  End;
end;

{ TMatrizCalcFlexObject }

class function TMatrizCalcFlexObject.FromJsonString(
  AJsonString: string): TMatrizCalcFlexObject;
begin
  Result := TJson.JsonToObject<TMatrizCalcFlexObject>(AJsonString);
end;

function TMatrizCalcFlexObject.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

{ TItensNotaEspelhoEnvioFornecedor }

destructor TItensNotaEspelhoEnvioFornecedor.Destroy;
begin
  inherited;
end;

function TItensNotaEspelhoEnvioFornecedor.fItemPrecoAlterado(pstrIncEsp: String): Boolean;
begin
  if Not Assigned(FIncAlteracao) then
    Exit(False);
  Result := FIncAlteracao.IndexOf(pstrIncEsp) >= 0;
end;

function TItensNotaEspelhoEnvioFornecedor.fNovoItemNotaEspelho(dadosItem: TDadosItemNotaEspelho): TItemNotaEspelho;
begin
  Result := TItemNotaEspelhoEnvioFornecedor.Create(dadosItem);
end;

function TItensNotaEspelhoEnvioFornecedor.GetItemCalc(pstrId: String): TItemNotaEspelhoEnvioFornecedor;
begin
  Result := TItemNotaEspelhoEnvioFornecedor(GetItem(pstrId));
end;

procedure TItensNotaEspelhoEnvioFornecedor.pAddListaItensAlterados(pstrIncAlteracao: TStrings);
begin
  FIncAlteracao := pstrIncAlteracao;
end;

{ TItemNotaEspelhoEnvioFornecedor }

constructor TItemNotaEspelhoEnvioFornecedor.Create(dadosItem: TDadosItemNotaEspelho);
begin
  inherited;
  FAlterouValores := False;
end;

function TItemNotaEspelhoEnvioFornecedor.fAlterouPrecoItem(fltVlrA, fltVlrB: Double): Boolean;
Var
  lstrValorCalc,
  lstrValorItem: String;
begin
  lstrValorCalc := formatFloat('#0.0000', fltVlrA);
  lstrValorItem := formatFloat('#0.0000', fltVlrB);
  Result :=  lstrValorCalc <> lstrValorItem;
end;

procedure TItemNotaEspelhoEnvioFornecedor.pAlterarValFre(const Value: Double);
Var
  lfltValFre,
  lfltDifere: Double;
begin
  lfltDifere := Value - FDadosItem.fltValFre;
  lfltValFre := fFormataFloat(IIF(InRange(lfltDifere, -0.003, 0.003), FDadosItem.fltValFre, Value), 2);

  if fAlterouPrecoItem(FDadosItem.fltValFre, lfltValFre) then
  begin
    if Not FAlterouValores then
      FAlterouValores := True;
    FDadosCalc := FDadosItem;
    FDadosCalc.fltValFre := lfltValFre;
  end;
end;

procedure TItemNotaEspelhoEnvioFornecedor.pAlterarValorItem(pfltTotIte, pfltQtdIte: Double);
Var
  lfltTotIte,
  lfltDifere: Double;
begin
  lfltTotIte :=  (pfltTotIte/pfltQtdIte) * FDadosItem.fltQtdIte;
  lfltDifere := lfltTotIte - FDadosItem.fltTotIte;
  lfltTotIte := fFormataFloat(IIF(InRange(lfltDifere, -0.003, 0.003), FDadosItem.fltTotIte, lfltTotIte), 2);
  //Comparar com valor do original do Item para confirmar se alterou

  if fAlterouPrecoItem(lfltTotIte, FDadosItem.fltTotIte) then
  begin
    if Not FAlterouValores then
      FAlterouValores := true;
  end;
  pAplicarAlteracaoPreco(lfltTotIte);
end;

procedure TItemNotaEspelhoEnvioFornecedor.pAplicarAlteracaoPreco(pfltTotIte: Double);
Var
  lfltFator: double;
begin
  FDadosCalc := FDadosItem;
  lfltFator := pfltTotIte/FDadosCalc.fltTotIte;
  FDadosCalc.fltUnitar := fFormataFloat((FDadosCalc.fltTotIte/FDadosCalc.fltQtdIte),4);
  FDadosCalc.fltTotIte := pfltTotIte;
  pAplicarFator(lfltFator);
end;

procedure TItemNotaEspelhoEnvioFornecedor.pCalculaImpostosProporcional(fltQtdIte: Double);
Var
  lDadosItemBkp: TDadosItemNotaEspelho;
begin
  lDadosItemBkp := FDadosItem;

  if FAlterouValores then
    FDadosItem := FDadosCalc
  else
    FDadosCalc := FDadosItem;

  pCalculaImpostosProporcionalExec(fltQtdIte);

  if FAlterouValores then
    FDadosItem := lDadosItemBkp;
end;

end.
