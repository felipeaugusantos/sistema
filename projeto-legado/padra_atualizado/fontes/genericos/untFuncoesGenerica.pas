unit untFuncoesGenerica;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  untGTinForTipos,
{$ELSE}
  Forms, DBGrids, Windows, UniClientDataSet,
{$ENDIF}
  IdCoderMIME,
  SysUtils,
  iniFiles,
  Uni,
  Variants,
  StrUtils,
  MaskUtils,
  DateUtils,
  System.RegularExpressions,
  System.Classes,
  untTypesSistema,
  Math,
  Data.DB,
  untConstantes,
  untMadeireira,
  untSaldoPedidoCompra,
  untIFatReservaSaldo,
  untTFatReservaSaldo,
  untIFatEntregaFutura,
  untTFatEntregaFutura,
  Controller.Faturamento.Precos.PrecoCusto,
  Faturamento.Precos.Tipos.PrecoCusto,
  Faturamento.Connections.Functions,
  Shared.Functions.SQL,
  Shared.Functions.Funcoes.Faturamento.Precos,
  Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Utils,
  Shared.Functions.Types,
  Shared.Functions.Tipos,
  Shared.Functions.DataSet,
  Shared.Functions.Interfaces,
  System.Generics.Collections,
  Shared.Functions.Monitores,
  System.SyncObjs,
  untTConfiguracao,
  untCalculoPrecoVenda,
  OrdemProducaoIndustrial.Funcoes,
  NetEncoding, IOUtils;

{$IFDEF LINUX}
Type
  TForMulTinDetArray = untGTinForTipos.TForMulTinDetArray;
  TBaixaPigmentosArray = untGTinForTipos.TBaixaPigmentosArray;
{$ENDIF}

Type
  TPais = (opcBrasil, opcParaguai);

Type
  TTipoFone = (tpCelular, tpFixo);

Type
  TCgcCpf = (C_G_C_, C_P_F_);

Type
  TCaptionCgcCpf = (capC_G_C_, capC_P_F_, capGERAL_);

Type
  TLimparCaches = class sealed
  public
    class procedure Execute;
  end;

type
  TBatchReprocessarSaldo = class sealed
  private
    FSemaphore: TCriticalSection;
    FListaCmds: TObjectDictionary<UInt64, TList<string>>;

    function fIteGerDevidamenteFormado(const LSQL: String): Boolean;
    function fCadLotDevidamenteFormado(const LSQL: String): Boolean;
    procedure pUnifica(const AIdTransaction: UInt64);
    function fGetOrCreateLista(const AIdTransaction: UInt64): TList<string>;
    function fIncluiPontoVirgula(const ASQL: string): string;
    function fSQLInvalido(const ASQL: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const AIdTransaction: UInt64; const ASQL: string; ACmdOri: boolean = False);
    procedure Execute(const AIdTransaction: UInt64; const AConexao: TUniConnection);
    procedure Clear(const AIdTransaction: UInt64);
    procedure ClearAll;
    function CountCommands(const AIdTransaction: UInt64): Integer;
  end;

function fSaldoItegerNegativo(const ACodIte, ACodEmp, AEntSai: String; out ASalFis: Double; out AMsgExc: String): Boolean;

function fGetItemEstrutura(Const strIteEst: String): String;
function fExisteLote(strNumLot: String; strCodIte: String; strCodEmp: String; blnSoAtivos: Boolean = False; blnSalPos: Boolean = False): Boolean; overload;
function fExisteLote(strCodIte: String; strCodEmp : String = ''): Boolean; overload;

procedure pGravarThumbItemSPO(strBase64, strAutInc: String);
procedure pGravarThumbItem(strBase64, strAutInc: String);

function fFormataFone(strFone: String; tpFone: TTipoFone = tpCelular): String;
function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil; tpFone: TTipoFone = tpCelular): String;
function fRetMascaraFone(opcPais: TPais; tpFone: TTipoFone = tpCelular): String;
function fRetMascaraFonePais: String;

function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf; opcLiteralChar: Boolean = False): String;
function fRetCaptionRG(opcPais: TPais): String;
function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
function fTiraCaracEspeciaisParenteses(strTexto: String): String;
function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;

function fSetaPais: TPais;
function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
function fRetSiglaPais(opcPais: TPais): String;
function fRetSiglaPaisAtual: String;
function fPodeValidarCgcCpf(FPais: TPais): Boolean;
function fMostraTipoCgcCpf(FPais: TPais): Boolean;

function fAcertaMaskTel(strFone: String): String;
function fValidaTelefone(strFone: String): Boolean;
function fValidaCelular(strNumero: string): Boolean;

procedure pGravaCfgPais(strSigPai: String);
procedure pGravaCfgComCus(intValCfg : Integer);
procedure pGravaCfgCertificadoDigital(strCerDig: String);

{$IFNDEF LINUX}
procedure pAjustaLarguraDasColunas(DBGrid: TDBGrid);
{$ENDIF}

function fUtilizaEmpresaPrioridade(strCodEmp: String = ''): Boolean;

function fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis(const strCodEmp : String = '') : Boolean;

function fGravaLogContEst(strCodOpe, strCodIte, strNumLot: String; fltSalCon, fltSalMl: Double; strAutInc: String = ''; fltSalAnt: Double = 0): Boolean;

function fGravaLogLocFisica(strCodIte,
                            strInfAnt,
                            strInfNov: String;
                            intTipAlt: Integer;
                            strNumLote: String;
                            strCodOpe: String = ''): Boolean;

function fConferenciaDepoisDaEntrada : Boolean;
function fRetEmpresasWms(blnUtiWms: Boolean): String;

function fRetSaldosEmpresa(strCodIte,
                           strCodEmp: String;
                           strNumLot: String = '';
                           blnIgnorarLote: Boolean = False): Double;

function fRetSaldosMLEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''): Double;
function fItemMarmore(strCodIte: String): Boolean;
function fItemLoteChapa(const strCodIte, strOpcDoc : String) : Boolean;

function fFormataTagRepAud(const ATag: String; aModoListaRepAud: TModListaRepAud): String;
function fTagRepAudToTagSQL(const ATag: String; APos: TPosTagMarcaSQL): String;
function fMarcarListaRepAud(const AstrLista: String; const ATag: String; aModoListaRepAud: TModListaRepAud): String;
function fExtraiListaRepAud(const ASQL: String; const ATag: String; aModoListaRepAud: TModListaRepAud): String;
function fLimparMarcaRepAud(const ASQL: String): String;
function fCountOccurences(const SubText: string; const Text: string): Integer;
function fUsouBatchReprocessarSaldo(const AArrSQL: Array Of String; const ACmdOri: Boolean): Boolean; overload;
function fUsouBatchReprocessarSaldo(const AArrSQL: Array Of String): Boolean; overload;

function GetSQLReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True): String;
function fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>;
function fGetEmpresasReprocessarPedido(ASeqFgo: String): TArray<String>;
function fGetEmpresasReprocessarItemPedido(ASeqFdo: String): TArray<String>; overload;
function fGetEmpresasReprocessarItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>; overload;
function fGetSubItensEstrutura(ACodIte: String; ACodEmp: String = ''): TArray<String>;
function ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True; blnRaise: Boolean = False): Boolean;

function fArrCodigosToText(arrCodigos: TConsultasArray): String;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;

function fExecutaValCfg(strSQL, strEmp: String): String;
function fRetornaValCfgMarCam(strValCfgOri: String): String;

function fUsaSat(strCodEmp : String = '') : Boolean;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal : Boolean = True; strEmpSalRes : String = ''; ignoraEntFut : Boolean = False): Boolean;

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;

function fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
procedure pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
procedure pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);

function fRetPrecoVenda(strCodIte, strTabPre: String; strCodEmp: String = ''; Conexao: TUniConnection = Nil): Double;
function fRetDescMaxCnd(strCodCnd: String; mdTipDes: TTipoMaxDesconto; Conexao: TUniConnection = Nil): Double;

function fEhEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte: Double): Boolean;
function fUnidadeDoProdutoEhFracionaria(strCodIte : String): Boolean;

function fRetNomCliente(Const strCodCli: String): String; Overload;
function fRetNomFazenda(Const strCodFaz: String): String;

{$IFNDEF LINUX}
function fRetNomCliente(Const strCodCli: String; strCpfCnpjConsumidor: String): String; Overload;
{$ENDIF}

function fQuantEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte : Double): Double;
function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean;

function fRetForFilialTodos(blnLista: Boolean = False): String;

function fRetornaSaldoDisponivel(strCodIte                         : String;
                                 blnCnvMl                          : Boolean = False;
                                 blnFaturamento                    : Boolean = True;
                                 strNumLot                         : String  = '';
                                 blnConsiderarPedidos              : Boolean = True;
                                 strCodEmp                         : String  = '';
                                 strNumPedAlt                      : String  = '';
                                 blnConsiderarPedidoCompraPendente : Boolean = False;
                                 blnConsiderarCfgCalSal            : Boolean = True;
                                 blnConsiderarOrdemProducao        : Boolean = True;
                                 blnInformaSaldoGeralDisponivel    : Boolean = False;
                                 blnConsiderarLocalizacaoCritica   : Boolean = False;
                                 blnUsaSalMlLote                   : Boolean = False;
                                 blnForcaSaldoReservadoViaSelect   : Boolean = False): Double;

function fRetornaSaldoDisponivelLotesWMS(strCodIte                          : String;
                                         blnCnvMl                           : Boolean = False;
                                         blnFaturamento                     : Boolean = True;
                                         strNumLot                          : String  = '';
                                         blnConsiderarPedidos               : Boolean = True;
                                         strCodEmp                          : String  = '';
                                         strNumPedAlt                       : String  = '';
                                         blnConsiderarPedidoCompraPendente  : Boolean = False;
                                         blnConsiderarCfgCalSal             : Boolean = True;
                                         blnConsiderarOrdemProducao         : Boolean = True;
                                         blnInformaSaldoGeralDisponivel     : Boolean = False;
                                         strSQLLotes                        : String  = '';
                                         strWhereLotes                      : String  = '';
                                         blnUsaSalMlLote                    : Boolean = False;
                                         blnForcaSaldoReservadoViaSelect    : Boolean = False): Double;

{$IFDEF LINUX}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
{$ENDIF}

function fEhAdministrador(strCodOpe: String): Boolean;

function fGetSQLNumCmp(strAliasFatGor: String = 'FATGOR'): String;
function fGetPedidoProvenienteDePromocaoBrinde(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

function fGetSQLEstruturaPai(strCodEmp: String): String;
function fRetEmpCarregamentoItem(strCodIte: String): String;
function fRetMotivoVendasPerdidas(Const strCodMot: String): String;

function fGetSQLSomaCamposEntregaFutura(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): String;

function fEhOuCompoeEstrutura(strCodIte: String; strCodEmp: String=''): TItemEstru;

function fEhItemServico(strCodIte: String; blnEntradaMercadoria : Boolean = False; strCodEmp: String = ''): Boolean;
function fEhItemVendaVidro(strCodigo: String; strIteVid: String = '-1'): Boolean;
function fEhItemEspecial(strCodIte: String): Boolean;

function fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
                                    fltDesf04, fltDesf05, fltDesf06: Double;
                                    intDecUni: Integer = -1;
                                    blnPreDol: Boolean = False;
                                    fltDesf07: Double = 0;
                                    fltCotacao: Double = -1): Double; overload;

function fCalculaPrecoCompraLiquido(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double; overload;

function fConvertePrecos(fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer = 2): Double;

function fSqlCdsIteger(strTabPre: String; Out strTabUti: String): String;

Procedure pIncluiIteger(cdsIteger: TUniClientDataSet; ACampos: IMyCampoTabela); overload;
Procedure pIncluiIteger(cdsIteger: TUniClientDataSet; qryIteger: TUniQuery); overload;

function fRetCstPisCofins(strClaFis, strCodSit, strIncPis, strSitP_C, strMenP_C: String; blnForcaCstPisCofSimPau: Boolean = False): String;

function fRetPerComLucro(fltQtdIte, fltUniOri, fltTotCus, fltTotIteLiq,
                         fltComVar: Double;
                         fltTotCu2: Double = 0.0;
                         strMarMkp: String = '';
                         strPcmPro: String = '';
                         intDecUni: Integer = -1): Double;

function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;

function fRetPerComOpeMargem(fltCusto, fltVenda : Double; strCodOpe : String; strCodEmp : String = ''): Double;
function fRetPerComMargem(fltValor: Double; strTipVen : String = ''; strConPag : String = ''): Double;

function fRetornaPercIVA(strCodAbf: String; strEstado, strTipAbf: String; cdsPerIva: TUniClientDataSet = Nil): Double;

function fStatusCndPag(strCndPag: String): Integer;
function fRetConPagCodCnd(strCodCnd: String): String;

function fPercDescComissClienteRegiao(strCodCli, strCodIte, strCampo: String; Var fltPerDes: Double): Boolean;

function fPercDescClienteProduto(strCodCli, strCodIte: String): Double;
function fPercDescClienteMarca(strCodCli, strCodIte: String): Double;

function fRetSQLEnderecoEntregaCli(strTabMov: String; blnTodCam: Boolean = False): String;
function fRetSQLEnderecoEntregaCliConsumidor(strClient, strAutInc, strTabMov: String): String;

function fRetSeqIndEndereco(strCodCli: String; strCampo: String): Integer;

function fFormataCEP(strCEP: String): String;

function fMarMpkParaVenda(strMarMpk: String=''): String;

function fCalculaQuantidadeMetrosCubicos(fltQuantidade,
                                         fltComprimento,
                                         fltLargura,
                                         fltEspessura : Double;
                                         strSiglaUni  : String): Double;

function fGetCampoMD5KEYTabelaTinta(strIdePro: String): String;

function fInArray(strValor: String; arrDados: TStringArray): Boolean;
function GetInToOr(const strNomeCampo: string; const strValores: string): string;

function fRoundSql(const strCampo: String; const intDecimais: Integer): String;

function fTravaUnitarioDeTintaComoProdutoNormal: Boolean;
function fUsaTravaPorMargemMinimaLiquida: Boolean;
function fAnalisaTodosCompomentesAoTravarUnitarioDeTintaComoProdutoNormal: Boolean;

function fCriarQueryIteGer(Owner: TComponent = Nil): TUniQuery;

function fRetUnidadeItem(strCodIte: String): String;
function fIsItemEspecial(strCodIte: String): Boolean;
function IsItemAtivo(const strCodIte: string): Boolean;

function fTamPrecoIteger: Integer;
function fTamPrecoItepro: Integer;
function fTamCampoQtdAjuste: Integer; // Req. 457063

function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;
function fObterPrecisaoCampo(strTabela, strCampo: String): Integer;

function fVerificarSeEhNotaImportacao(strAutIncGERELE: String; blnValidaNotaAcompanhamento: Boolean = False): Boolean;

function fItemConcreto(const strCodIte: String; strEmpIte: String = ''): Boolean;
function fItemAmpara(strCodIte: String): Boolean;
function fItemRevInd(strCodIte, strCodEmp: String): String;
function fItemEstrutura(strCodIte: String): Boolean;

function fCadIte(ACodIte: string): IMyCampoTabela;
function fIteGer(ACodIte, ACodEmp: string): IMyCampoTabela;

function fVendaProducao(strOpcDoc, strClaFis: String): Boolean;

function fDentroDoEstado(strCliEst: String; strCodEmp: String): Boolean;

function fRetornaAliquotaDeIcmsInterestadual(strOrigem, strDestino: String): Double;
function fEmpresaZeraIcmsTE(strEmpOri, strCliFil: String): Boolean;

function fMultiplicadorReducaoRICMS(fltValor: Double): Double;

function fItemUtilizaPrecoEmDolar(strItem: String): Boolean;

function fClientePessoaFisica(strCodCli: String): Boolean;

function fRetAliquotaIssCidade(strCodCid: String): Double;
function fRetReducaoBaseIssCidade(strCodCid: String): Double;

function fRetComissaoTabelaItem(strItem, strTabPre: String): Double;

function fEhClienteFilialEmpLogada(strCodCli: String): Boolean;

function fTemQuantEmbalagemFechada(strCodIte: String): Boolean;

function fPercDescEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte: Double; strCodBarEmb: string): Double;

function fRetornaPrecoCodBarraEmb(strCodIte, strCodBar, strCodEmp, strTabPre: String; blnPegaPrecoEmb: Boolean): Double;

function fRetornaTabPreCodBarraEmb(strCodIte, strCodBar: String): String;

Function fRetCustoServico(strCodSer: String): Double;

function fEhServicoTerceirizado(strCodSer: String): Boolean;
function fRetornaCustoServicoTerceirizado(strCodSer: String): Double;

function fConsideraEmpresaDoPedidoOrcamentoNoCupomPromocional: Boolean;

function fRateiaFreteItensTransportadora(const strCodTra, strTipFre : String) : Boolean;
function fTipoDeFreteEfetuaRateio(const strCodTra : String; const intTipFre : Integer): Boolean;

function fEhExportacaoIndireta(strCliExpInd, strFgoTipOpe: String): Boolean;

function fRetDescontoFidelidade(strCodCli: String): Double;

function fRetCodEmpClienteFilial(strCliFil: String): String;

function fRetDesCla(strClaFis: String; blnConsulta: Boolean = False): String;

procedure pGravaRegistroContabilidade(RegistroContabilidade: TrecRegistroContabilidade);

function fOSVerificaOriPDO(strNumDoc, strEspDoc, strCodEmp: String; var strEmpOri: String): Boolean;

function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;

function fPedidoEhOrigemTabletSite(strNumDoc, strEspDoc, strEmpDoc : String) : Boolean;

function fGetItemAhGranel(strCodIte: String): String;
function fGetCodCorItem(strCodIte: String): String;
function fGetPesoEspecificoItemGranel(strCodIteGranel, strCodCor: String; Var strFormula: String): Double;
{Req. 456948-B. Liga/desliga o cache de fGetPesoEspecificoItemGranel por
 strCodIteGranel+strCodCor. So a gravacao do balanco arma; fora dali o
 dicionario fica Nil e a funcao le do banco sempre, como hoje.}
procedure pLigaCachePesoEspGranel;
procedure pDesligaCachePesoEspGranel;

function fTemServicoPD(strCodEmp, strNumDoc, strCodCli: String): Boolean;

function fExistemCompromissosAgendados: boolean;

function fRetQuantidadeDevolvida(strNumDoc, strEspDoc, strCodEmp, strCodIte : String; blnIncluirDevolucaoPorGarantia : Boolean = True; strTabela: String = 'MOVDET'):Double;

function fChaveDocumentoEntradaMercadorias(cdsDocumentos: TDataSet): String;

function fFormataFloatSky(fltValor: Double): Double;

Procedure pRetImpostosItem(    strCodIte: String;
                           Var fltIcmSai,
                               fltOutVal,
                               fltDesOpe,
                               fltImpFed: Double;
                               cdsIteGer: TUniClientDataSet = Nil;
                               strTabPre: String = '-1';
                               strCodEmp: String = '');

function fRetornaGrupoItem(strCodIte: String): String;
function fRetMarcaItem(strCodIte: String): String;
function fRetCodFornecedor(strCodIte: String): String;

function fGetCodAbf(strCodIte: String; strCodEmp: String = ''): String;
function fRetImportacaoDiretaItem(strItem: String; strCodEmp: string = ''): String;

function fAplicarTaxaJurosPrecoSugestao: Boolean;
function fAplicarTaxaJurosPrecoDigitado: Boolean;

function fAlqIcmEstEmp(strCodAbfIte, strCodEmpIte: String): Double;

function fRetNomVendedor(strCodVen: String): String; overload;
function fRetNomVendedor(strCodVen, strCodEmp: String): String; Overload;
function fRetNomVendedor(strCodVen, strCodEmp, strCodCli: string): String; overload;

function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;

function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;
  blnMaximo : Boolean = False; blnMensagem :Boolean = False; blnAbreviadoAltura : Boolean = False;
  blnMinimo : Boolean = False; blnSugestao : Boolean = False) : String;

Procedure pIncluiCdsAbreviacao(cdsPerIva: TUniClientDataSet; objDadosAbf: IMyCampoTabela);

function fGetDadosAbf(strCodAbf, strEstado: String): IMyCampoTabela;

function fGetTipoAbreviacaoFornecedor(const strCodFor: String): String; OverLoad;
function fGetTipoAbreviacaoFornecedor(const strCodFor: String; Var strTipFor: String): String; OverLoad;

function fGetTipoAbfCliente(const strCodCli: String; strConsum: String = ''; strIndust: String = '';
  strEmp_TE: String = ''; strCodEmp: string = ''; strProRur: String = ''): String;

function fGetTipOpeTransferencia(strEmpOri, strCliFil: String): String;

function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;

function fGetPercentualRessarcimentoCAT(strCodAbf, strEstFor: String): Double;
function fGetPercentualRessarcimentoCATIPIEnt(strCodIte, strCodEmp, strCodAbf, strEstFor: String): Double;
function fGetPercentualDescontoCAT(strCodAbf, strEstFor, strTabPre: String): Double;

procedure pRetDadosAbfFornecedor(strCodAbf, strCodFor, strEstFor: String;
                                 Var fltAlqIcm, fltAlqRet, fltValIva,
                                 fltPerBas, fltPeBaST: Double;
                                 Var strCodSit: String);

function fEstadoFornecedor(strCodFor: String): String;

function fRetornaIesUni(strCodCli: String): String;
function fEhProdutorRural(strCodCli: String): Boolean;

function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;

Function fCalcMediaPagto(strConPag:String): Double;

function fPermiteInformarEmpresaNoItemOpc(const strOpcDoc: String): Boolean;

function fRetCodIbamaCliente(Const strCodCli: String): String;

function fRetornaDadosTransportadora(strCodTra: String): TrecDadosTransportadora;

procedure pGravarICMSUFDest(strAutInc, strTabela: String; fltBaseUfDestino, fltPercentualFCP,
  fltAlqUfDestino, fltAlqInterestadual, fltPercentualPartilha, fltValorFCP,
  fltValorIcmsDifalDestino, fltValorIcmsDifalOrigem, fltBaseFCP: Double; strFcpProprio: String = '');

function fRetornaValCom(fltValCom: Double): Double;

function fUsaImpostoFonteIBPT: Boolean;
function fPermiteBrindeComValorZero: Boolean;

function fRetComplementoStrClaDevBrinde(strOpcDoc: String): String;

function fCalculaValorIss(fltBasIss, fltAlqIss: Double): Double;

function fUsaRateioDeServicos: Boolean;

function fAtividadeConstrutora(strCodAti: String; strCodEmp: string = ''): Boolean;

function fRetNomeRedeLoja(Const strCodRed: String): String;

function fRetNomFornecedor(strCodFor: String): String;
function fRetFornecedorSimples(strCodFor: String): Boolean;
function fRetFornecedorRegimeTributario(strCodFor: String): string;
function fRetNomeLinhaGrupo(strCodigo: String): String;
function fRetNomMarca(strCodMar: String): String;
function fRetornaTelefonesCliente(Const strCodCli: String): String;
function fRetornaEmailsCliente(Const strCodCli: String): String;

function fGetInformacoesUltimaCompra(const strCodIte: String;
                                     var dtaDataCompra: TDateTime;
                                     var strDocumento: String;
                                     var fltPrecoCompra: Double;
                                     var strFornecedor: String): Boolean;

function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                            curPrecus: Double;
                            curPreven: Double;
                            curMarBru: Double;
                            curIcmsVenda: Double;
                            curImpFed: Double;
                            curDesOpe: Double;
                            curValCom: Double;
                            strMarMkp: String = '';
                            strPcmPro: String = '';
                            intDecUni: Integer = -1;
                            fltIcmsST: Double = 0;
                            blnCalcSt: Boolean = False;
                            curDifal: Double = 0;
                            curFCP: Double = 0;
                            curOutVal: Double = 0;
                            blnRestringirElementosMargem: Boolean = false;
                            fltCnvCus: Double = 1):Double;
function fValidaVendedorMarca(strCodVen, strCodIte, strOpcDoc : String): Boolean;
function fVendedorAssociadoMarca(strCodVen, strCodIte : String): Boolean;
function fExisteVendedorAssociadoMarca(strCodVen : String): Boolean;
function fRetCubagemItem(strCodIte: String; fltQtdIte: Double): Double;
function fExibirApenasItensDoVendedorVinculadoAoCliente(strCodVen, strCodCli, strOpcDoc: String): Boolean;
function fExisteCLIVEN(strCodVen, strCodCli: String): Boolean;
procedure pCarregaCLIVEN(Var qryCliVen: TUniQuery; strCodVen, strCodCli: String);
function fItemPermitidoParaVendedorVinculadoAoCliente(strCodVen, strCodCli, strCodIte: String): Boolean;
function fCampoCfgMLTOP2: String;
function fUsaCfopDecretoCeara(strCodIte: String): String;
function fRetornaCfopDecretoCeara(strCodIte: String): String;

function fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
function fRetSomenteNumeros(strTexto: String): String;
function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;
function fRetMltVenItem(Const strCodIte: String): Double;
function fRetMltComItem(Const strCodIte: String): Double;
function fCalcVolumes(strCodIte: String; fltQtdIte, fltEmbala: Double): Double;
function fGeraCodBarraEAN13(strCodigo: String): String;
procedure pCarregaDuplicatasCND(intTabela:Integer; strAutoincrem:String; var arrDuplicataCND: TarrDuplicata; blnVeioDaEntrada: Boolean = False);

function fRemoveCaracterNulo(AString: String): String;
function fRemoveBarraInvertidaFinalDaLinha(strText: String): String;
function fFloatToSQL(fltValor: Double): String;
function fDoubleToSQL(const AValue: Double): string;

function fGetFullTextColumnsFromField(AField, ATable: string; var AFieldIndex: Integer): string;
function fRefazLogNfeCasoExcluido(strAcesso: String): Boolean;

function fRetornaRequisicaoCompra(strNumDoc: String; strEspDoc: String; strCodEmp: String; strCodIte: String):String;
function fPedidosRequisicaoCompra(strCodReq: String; strCodEmp: String): String;
function fCriarCdsCheques(AOwner: TComponent): TUniClientDataSet;

function GeraUUIDVersao4: String;
function fEnviarWhatsappParaCliente(strCodCli: String; blnExibeMsg: Boolean = False): Boolean;
function fUtilizaRestApiBoletoDLL: Boolean;
function fUtilizaEnderecamento: Boolean;
function fRegimeSubstituicaoTributaria(const strCodEmp : String = ''; const strOpcDoc : String = '') : String;
function fCfgRegimeSubstituicaoTributaria(const strOpcDoc : String = '') : String;

function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;
function fGetUniqueTempPath(const AExt: string = '.tmp'): string;

function fGetExtensaoArquivo(TipoArquivo: TTipoArquivo): String;
function fGetTipoArquivo(const AstrArquivo: String): TTipoArquivo;
function fRetBase64ParaArquivo(const ABase64: String; ANomeArquivo: String): String;
function fEhArquivoBase64(const AstrArquivo: String): Boolean;
function fOrdenarListaParaClausulaIN(const ALista: string): string;
function fValidarEnderecoEmail(strEmail: String): Boolean;
function fValidarEmail(strEmail: String; blnExibeAlerta: Boolean = True;
  strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
  blnEmailNfe: Boolean = True): Boolean;
function fRetornaXMLNFeBD(AChaveAcesso: string): String;
function fSomarNovosImpostosDaReformaAoValorContabil : Boolean;
function fSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
function fSqlValorReformaRef(const ATabelaReforma, AAutoincrementoDetalhe: String): String;
function fSqlCampoReformaRef(const ATabelaReforma, ACampo, AAutoincrementoDetalhe: String): String;
function fCampoSeqReformaRef(const ATabelaReforma: String): String;
function fSafeFloatField(const ADataSet: TDataSet; const AFieldName : String): Double;

{$IFDEF LINUX}
var
  arrLogLib: TArrLogLib;
  arrLogAvi: TArrLogAvi;
{$ENDIF}

const
  SQL_GET_EMPRESA_PEDIDO_SELECT =
    'CONCAT( ' +
    '  IFNULL(FATGOR.FGO_CODEMP, ""), "," , ' +
    '  IFNULL(FATGOR.FGO_EMPFOR, ""), "," , ' +
    '  IFNULL(FATGOR.FGO_EMPFAT, ""), "," , ' +

    '  IFNULL(CADEMP.EMP_CODEMP, ""), "," , ' +

    '  IFNULL(EXTGOR.FGO_EMP_TE, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMP_CD, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMPDAB, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMPEXP, ""), "," , ' +

    '  IFNULL(EXTDOR.FDO_EMPFOR, ""), "," , ' +
    '  IFNULL(EXTDOR.FDO_EMPCAR, ""), "," , ' +

    '  IFNULL((SELECT MOVDET.DET_CODEMP FROM MOVDET WHERE MOVDET.AUTOINCREM = EXTDOR.FDO_INCFUT), ""), "," , ' +

    '  IFNULL(FATDOR.FDO_CODEMP, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPITE, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPPRD, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPDEV, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPACA, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPFAT, "")        ' +
    ') ';

  SQL_GET_EMPRESA_PEDIDO_FROM =
    ' FATGOR ' +
    ' INNER JOIN EXTGOR ' +
    '   ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    ' INNER JOIN FATDOR ' +
    '   ON FDO_SEQGER = FATGOR.AUTOINCREM ' +
    ' INNER JOIN EXTDOR ' +
    '   ON FDO_SEQFDO = FATDOR.AUTOINCREM ' +
    ' LEFT JOIN CADEMP ' +
    '   ON EMP_CLIFIL = FATGOR.FGO_CODCLI ';

implementation

uses
{$IFNDEF LINUX}
  untFuncoesSimples,
{$ENDIF}
  untParCalculaPrecoCusto, untDicionarioResultadoQuerySimples,
  Controller.Faturamento.Interfaces.Cache;

var
  FForSet: TFormatSettings;

procedure pGravarThumbItem(strBase64, strAutInc: String);
var
  qryTabela : TUniQuery;
begin
  qryTabela := fCriaQuery;
  Try
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(' UPDATE ITEIMG SET ITE_THUB64 = :ITE_THUB64 ');
    qryTabela.SQL.Add(' WHERE AUTOINCREM = :AUTINC');

    qryTabela.ParamByName('ITE_THUB64').AsString := strBase64;
    qryTabela.ParamByName('AUTINC').AsString := strAutInc;

    Try
      qryTabela.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'pGravarThumbItem');
      End;
    End;
  Finally
    FreeAndNil(qryTabela);
  End;
end;

procedure pGravarThumbItemSPO(strBase64, strAutInc: String);
var
  qryTabela : TUniQuery;
begin
  qryTabela := fCriaQuery;
  Try
    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(' UPDATE ITEIMG SET ITE_SPOB64 = :ITE_SPOB64 ');
    qryTabela.SQL.Add(' WHERE AUTOINCREM = :AUTINC');

    If (strBase64 <> '') Then
      qryTabela.ParamByName('ITE_SPOB64').AsString := strBase64
    Else
      qryTabela.ParamByName('ITE_SPOB64').Clear;

    qryTabela.ParamByName('AUTINC').AsString := strAutInc;

    Try
      qryTabela.ExecSQL;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'pGravarThumbItem');
      End;
    End;
  Finally
    FreeAndNil(qryTabela);
  End;
end;

function fFormataFone(strFone: String; tpFone: TTipoFone = tpCelular): String;
Begin
  strFone := fFormataFonePais(Trim(fTiraCaracEspeciaisParenteses(strFone)),fSetaPais, tpFone);
  Result  := strFone;
End;

function fGetItemEstrutura(Const strIteEst: String): String;
Var
  strSQL   : String;
  qryGenReg: TUniQuery;
Begin
  Try

    qryGenReg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  I.ITE_DESITE AS DESITE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '  GERMAT G ';
    strSQL := strSQL + '  LEFT JOIN CADITE I ON G.GMT_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  G.GMT_CODITE  = :ITEEST ';


    With qryGenReg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ITEEST').AsString := strIteEst;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('DESITE').AsString
      Else
        Result := '';

      Close;
    End;

  Finally
    FreeAndNil(qryGenReg);
  End;

End;

function fExisteLote(strNumLot: String; strCodIte: String; strCodEmp: String; blnSoAtivos: Boolean = False; blnSalPos: Boolean = False): Boolean;
  Var
    qryCadLot: TUniQuery;
    strSQL: String;
Begin
  Result := False;

  Try
    qryCadLot := fCriaQuery(Nil);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT                      ';
      strSQL := strSQL + '   LOT_NUMLOT                ';
      strSQL := strSQL + ' FROM                        ';
      strSQL := strSQL + '   CADLOT                    ';
      strSQL := strSQL + ' WHERE                       ';
      strSQL := strSQL + '   LOT_NUMLOT = :NUMLOT AND  ';
      strSQL := strSQL + '   LOT_CODITE = :CODITE AND  ';
      strSQL := strSQL + '   LOT_CODEMP = :CODEMP      ';

      If blnSoAtivos Then
        strSQL := strSQL + '  AND LOT_STATUS = "S"     ';

      If blnSalPos Then
        strSQL := strSQL + '  AND IFNULL(LOT_SALDOS, 0) > 0  ';

      strSQL := strSQL + '  LIMIT 1                    ';

      qryCadLot.SQL.Add(strSQL);
      qryCadLot.ParamByName('NUMLOT').AsString := strNumLot;
      qryCadLot.ParamByName('CODITE').AsString := strCodIte;
      qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;
      qryCadLot.Open;

      Result := (Not qryCadLot.IsEmpty);

      qryCadLot.Close;

    Finally
      FreeAndNil(qryCadLot);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fExisteLote]');
  End;
End;

function fExisteLote(strCodIte: String; strCodEmp: String): Boolean;
  Var
    qryCadLot: TUniQuery;
    strSQL: String;
Begin
  Result := False;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Try
    qryCadLot := fCriaQuery(Nil);

    Try
      strSQL := '';
      strSQL := strSQL + '  SELECT                         ';
      strSQL := strSQL + '    LOT_NUMLOT                   ';
      strSQL := strSQL + '  FROM                           ';
      strSQL := strSQL + '    CADLOT                       ';
      strSQL := strSQL + '  WHERE                          ';
      strSQL := strSQL + '    LOT_CODITE = :CODITE AND     ';
      strSQL := strSQL + '    LOT_CODEMP = :CODEMP LIMIT 1 ';

      qryCadLot.SQL.Add(strSQL);
      qryCadLot.ParamByName('CODITE').AsString := strCodIte;
      qryCadLot.ParamByName('CODEMP').AsString := strCodEmp;
      qryCadLot.Open;

      Result := (Not qryCadLot.IsEmpty);
      qryCadLot.Close;

    Finally
      FreeAndNil(qryCadLot);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[fExisteLote]');
  End;
End;

function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fArqIniGeral(ReadWrite: Integer; NomChave,NomSecao,Conteudo,strPath: String): String;
  Var
    iniArqIni: TIniFile;
Begin
  iniArqIni := TIniFile.Create(strPath + '\opcoes.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;

End;

function fSetaPais: TPais;
Var
  strPais: String;
Begin
  //strPais := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));

  strPais := fCfgSis('SIGPAI', varString);

  If SameText(strPais, 'PAR') Then
    Result := opcParaguai
  Else
    Result := opcBrasil;

End;

function fSetaCgcCpf(strCgcCpf: String): TCgcCpf;
Begin
  If strCgcCpf = '1' Then
    Result := C_G_C_
  Else
    Result := C_P_F_;
End;

function fRetMascaraFone(opcPais: TPais; tpFone: TTipoFone = tpCelular): String;
Begin
  case opcPais Of
    opcBrasil  : Result := IIF(tpFone = tpCelular, '!\(99\)99999-9999;0;_', '!\(99\)9999-9999;0;_');
    opcParaguai: Result := '' ;
  end;
End;

function fRetMascaraC_G_C_(opcPais: TPais; opcCgcCpf: TCgcCpf; opcLiteralChar: Boolean = False): String;
  Var
    LLiteral: String;
Begin
  Result := '';

  If opcLiteralChar Then
    LLiteral := '1'
  Else
    LLiteral := '0';

  case opcPais Of
    opcBrasil: Begin
                 Case opcCgcCpf Of
                   C_G_C_: Result := IfThen(fCfgSis('NWCNPJ', varBoolean),
                                            '>aa\.aaa\.aaa/aaaa-99;' + LLiteral + ';',
                                            '99.999.999/9999-99;' + LLiteral + ';');
                   C_P_F_: Result := '999.999.999-99;0;';
                 End;
               End;

    opcParaguai: Result := '';
  end;

End;

function fRetCaptionRG(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'R.G.:';
    opcParaguai: Result := 'CI:';
  end;
End;

function fRetCaptionCgcCpf(opcPais: TPais; opcCgcCpf: TCaptionCgcCpf): String;
Begin
  Case opcPais Of
    opcBrasil  : Case opcCgcCpf Of
                   capC_G_C_: Result := 'CNPJ:';
                   capC_P_F_: Result := 'CPF:';
                   capGeral_: Result := '1-CNPJ/2-CPF:';
                 End;

    opcParaguai: Result := 'RUC:';
  end;
End;

procedure pGravaCfgPais(strSigPai: String);
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  //fArqIniGeral(1, 'PAIS', 'SIGLA', strSigPai, Pchar(ExtractFilePath(Application.ExeName)));

  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsString := strSigPai;
      ParamByName('CODCFG').AsString := 'CFG_SIGPAI';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

End;

procedure pGravaCfgComCus(intValCfg : Integer);
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsInteger := intValCfg;
      ParamByName('CODCFG').AsString  := 'CFG_COMCUS';
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

End;

function fRetSiglaPais(opcPais: TPais): String;
Begin
  Case opcPais Of
    opcBrasil  : Result := 'BRA';
    opcParaguai: Result := 'PAR';
  End;
End;

function fRetSiglaPaisAtual: String;
Begin
  //Result := fArqIniGeral(0, 'PAIS', 'SIGLA', 'BRA', Pchar(ExtractFilePath(Application.ExeName)));
  Result := fCfgSis('SIGPAI', varString);
End;

function fPodeValidarCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fMostraTipoCgcCpf(FPais: TPais): Boolean;
Begin
  Result := (FPais <> opcParaguai);
End;

function fRetMascaraFonePais: String;
Begin
  Result := fRetMascaraFone(fSetaPais);
end;

function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil; tpFone: TTipoFone = tpCelular): String;
Begin
  If FPais = opcParaguai Then
    Result := Trim(fTiraCaracEspeciaisParenteses(strTelefo))
  Else
    If Not (fEmptyStr(strTelefo)) Then
      Result := FormatMaskText(fRetMascaraFone(FPais, tpFone),Copy(strTelefo,1,11))
    Else
      Result := '';
End;

function fAcertaMaskTel(strFone: String): String;
begin
  strFone := AnsiReplaceStr(strFone, '(', '');
  strFone := AnsiReplaceStr(strFone, ')', '');
  strFone := AnsiReplaceStr(strFone, ' ', '');
  strFone := AnsiReplaceStr(strFone, '-', '');

  if (Length(strFone) = 10) then
    Result := Copy(strFone,1,2) + ' ' + Copy(strFone,3,8)
  Else
    Result := strFone;
end;

function fValidaTelefone(strFone: String): Boolean;
  Var
    intChar: Integer;
begin

  Result := True;

  strFone := AnsiReplaceStr(strFone, '(', '');
  strFone := AnsiReplaceStr(strFone, ')', '');
  strFone := AnsiReplaceStr(strFone, ' ', '');
  strFone := AnsiReplaceStr(strFone, '-', '');

  If (Length(strFone) < 10) Or AnsiStartsStr('00', strFone) Then
    Result := False
  Else
    For intChar := 1 To Length(strFone) Do
    Begin
      If (Not CharInSet(strFone[intChar], ['0'..'9'])) Then
      Begin
        Result := False;
        Break;
      End;
    End;

end;

function fValidaCelular(strNumero: string): Boolean;
var
  strRegExp: string;
begin
  Result := False;

  strRegExp := '^[1-9]{2}(?:[6-9]|9[1-9])[0-9]{3}[0-9]{4}$';
  if TRegEx.IsMatch(strNumero, strRegExp) then
    Result := True;
end;


procedure pGravaCfgCertificadoDigital(strCerDig: String);
Var
  strSQL: String;
  qryCfg: TUniQuery;
Begin
  Try
    qryCfg := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    With qryCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALCFG').AsString := strCerDig;
      ParamByName('CODCFG').AsString := 'CFG_CERDIG';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCfg);
  End;

End;

{$IFNDEF LINUX}
procedure pAjustaLarguraDasColunas(DBGrid: TDBGrid);
var
  LTotalColunaLargura, LTotalColunas, LGridClientLargura, LLargura, i: Integer;
begin
  LTotalColunas := DBGrid.Columns.Count;
  if LTotalColunas = 0 then
    Exit;

  LTotalColunaLargura := 0;
  for i := 0 to LTotalColunas-1 do
    LTotalColunaLargura := LTotalColunaLargura + DBGrid.Columns[i].Width;
  if dgColLines in DBGrid.Options then
    LTotalColunaLargura := LTotalColunaLargura + LTotalColunas;

  LGridClientLargura := DBGrid.Width - GetSystemMetrics(SM_CXVSCROLL);
  if dgIndicator in DBGrid.Options then begin
    LGridClientLargura := LGridClientLargura - IndicatorWidth;
    if dgColLines in DBGrid.Options then
      Dec(LGridClientLargura);
  end;
  if DBGrid.BorderStyle = bsSingle then begin
    if DBGrid.Ctl3D then
      LGridClientLargura := LGridClientLargura - 4
    else
      LGridClientLargura := LGridClientLargura - 2;
  end;

  if LTotalColunaLargura < LGridClientLargura then begin
    LLargura := (LGridClientLargura - LTotalColunaLargura) div LTotalColunas;
    for i := 0 to LTotalColunas-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width + LLargura;
  end
  else if LTotalColunaLargura > LGridClientLargura then begin
    LLargura := (LTotalColunaLargura - LGridClientLargura) div LTotalColunas;
    if (LTotalColunaLargura - LGridClientLargura) mod LTotalColunas <> 0 then
      Inc(LLargura);
    for i := 0 to LTotalColunas-1 do
      DBGrid.Columns[i].Width := DBGrid.Columns[i].Width - LLargura;
  end;

end;
{$ENDIF}

function fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis(const strCodEmp : String = '') : Boolean;
var
  strEmpresa : String;
begin

  Result := False;

  strEmpresa := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

  If Not (fCfgSis('LOTCRP', varBoolean, strEmpresa)) Then
    Exit;

  If (fCfgSis('WMSLOT', varBoolean, strEmpresa)) Then
    Exit;

  If Not (fCfgSis('UTIWMS', varBoolean, strEmpresa)) Then
    Exit;

  Result := True;

end;

function fUtilizaEmpresaPrioridade(strCodEmp: String = ''): Boolean;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result := (fCfgSis('UPSEML', varString, strCodEmp) = 'S') And (fCfgSis('EMPFAT', varString, strCodEmp) = 'S');
end;

function fGravaLogLocFisica(strCodIte, strInfAnt, strInfNov: String; intTipAlt: Integer; strNumLote: String; strCodOpe: String = ''): Boolean;
Var
  strSQL   : String;
  qryGenLoc: TUniQuery;
Begin
  Try

    qryGenLoc := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' LOGLOC (AUTOINCREM,  ';
    strSQL := strSQL + '         LOC_CODEMP,  ';
    strSQL := strSQL + '         LOC_DTAALT,  ';
    strSQL := strSQL + '         LOC_HRAALT,  ';
    strSQL := strSQL + '         LOC_OPEALT,  ';
    strSQL := strSQL + '         LOC_CODITE,  ';
    strSQL := strSQL + '         LOC_INFANT,  ';
    strSQL := strSQL + '         LOC_TIPALT,  ';
    strSQL := strSQL + '         LOC_INFNOV,  ';
    strSQL := strSQL + '         LOC_NUMLOT)  ';
    strSQL := strSQL + ' VALUES (:AUTOIN,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :DTAALT,     ';
    strSQL := strSQL + '         :HRAALT,     ';
    strSQL := strSQL + '         :OPEALT,     ';
    strSQL := strSQL + '         :CODITE,     ';
    strSQL := strSQL + '         :INFANT,     ';
    strSQL := strSQL + '         :TIPALT,     ';
    strSQL := strSQL + '         :INFNOV,     ';
    strSQL := strSQL + '         :NUMLOT)     ';


    With qryGenLoc Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTOIN').AsString  := fRetAutoIncrem('LOGLOC',VS_strCodEmp);
      ParamByName('CODEMP').AsString  := VS_strCodEmp;
      ParamByName('DTAALT').AsDate    := VS_Date;
      ParamByName('HRAALT').AsTime    := fTime();

      If strCodOpe = '' Then
        ParamByName('OPEALT').AsString  := strLoginUsuarioLogado
      Else
        ParamByName('OPEALT').AsString  := strCodOpe;

      ParamByName('CODITE').AsString  := strCodIte;
      ParamByName('INFANT').AsString  := strInfAnt;
      ParamByName('INFNOV').AsString  := strInfNov;
      ParamByName('TIPALT').AsInteger := intTipAlt;
      ParamByName('NUMLOT').AsString  := strNumLote;


      ExecSQL;
      Result := True;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGravaLogLocFisica]');
    End;
  End;

  FreeAndNil(qryGenLoc);

End;

function fGravaLogContEst(strCodOpe, strCodIte, strNumLot: String; fltSalCon, fltSalMl: Double; strAutInc: String = ''; fltSalAnt: Double = 0): Boolean;
Var
  strSQL   : String;
  qryConEst: TUniQuery;
Begin
  Try
    qryConEst := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO ';
    strSQL := strSQL + ' LOGEST (AUTOINCREM,  ';
    strSQL := strSQL + '         EST_CODEMP,  ';
    strSQL := strSQL + '         EST_DTAALT,  ';
    strSQL := strSQL + '         EST_HRAALT,  ';
    strSQL := strSQL + '         EST_OPEALT,  ';
    strSQL := strSQL + '         EST_CODITE,  ';
    strSQL := strSQL + '         EST_NUMLOT,  ';
    strSQL := strSQL + '         EST_QTDCON,  ';
    strSQL := strSQL + '         EST_QTD_ML,  ';
    strSQL := strSQL + '         EST_SALANT)  ';
    strSQL := strSQL + ' VALUES (:AUTOIN,     ';
    strSQL := strSQL + '         :CODEMP,     ';
    strSQL := strSQL + '         :DTAALT,     ';
    strSQL := strSQL + '         :HRAALT,     ';
    strSQL := strSQL + '         :OPEALT,     ';
    strSQL := strSQL + '         :CODITE,     ';
    strSQL := strSQL + '         :NUMLOT,     ';
    strSQL := strSQL + '         :QTDCON,     ';
    strSQL := strSQL + '         :QTD_ML,     ';
    strSQL := strSQL + '         :SALANT)     ';

    With qryConEst Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If fEmptyStr(strAutInc) Then
        ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGEST', VS_strCodEmp)
      Else
        ParamByName('AUTOIN').AsString := strAutInc;

      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAALT').AsDate   := VS_Date;
      ParamByName('HRAALT').AsTime   := fTime();
      ParamByName('OPEALT').AsString := strCodOpe;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMLOT').AsString := strNumLot;
      ParamByName('QTDCON').AsFloat  := fltSalCon;
      ParamByName('QTD_ML').AsFloat  := fltSalMl;
      ParamByName('SALANT').AsFloat  := fltSalAnt;

      ExecSQL;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[fGravaLogContEst]');
    End;
  End;
  FreeAndNil(qryConEst);
end;

function fConferenciaDepoisDaEntrada : Boolean;
Begin
  Result := (fCfgSis('TIPPNT', varString) = 'D');
End;

function fRetEmpresasWms(blnUtiWms: Boolean): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Result := '';

  Try

    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  GROUP_CONCAT(EMP_CODEMP) AS EMPRESA ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE    ';

    If (blnUtiWms) Then
      strSQL := strSQL + '  EMP_UTIWMS = "S"  '
    Else
      strSQL := strSQL + '  EMP_UTIWMS <> "S"  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('EMPRESA').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fRetSaldosEmpresa(strCodIte,
                           strCodEmp: String;
                           strNumLot: String = '';
                           blnIgnorarLote: Boolean = False): Double;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil);
  Result := 0;

  Try

    qryAux.SQL.Clear;

    If fEmptyStr(strNumLot) Then
    Begin

      qryAux.SQL.Add('SELECT ITE_SALDOS FROM ITEGER WHERE ');
      qryAux.SQL.Add('ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ');

      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      Result := qryAux.FieldByName('ITE_SALDOS').AsFloat;

    End
    Else
    Begin

      qryAux.SQL.Add(' SELECT SUM(LOT_SALDOS) AS LOT_SALDOS ');
      qryAux.SQL.Add('   FROM CADLOT ');
      qryAux.SQL.Add('  WHERE LOT_CODITE = :CODITE ');
      qryAux.SQL.Add('    AND LOT_CODEMP = :CODEMP ');

      If (Not blnIgnorarLote) Then
        qryAux.SQL.Add('    AND LOT_NUMLOT = :NUMLOT ');

      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;

      If (Not blnIgnorarLote) Then
        qryAux.ParamByName('NUMLOT').AsString := strNumLot;

      qryAux.Open;

      If Not qryAux.IsEmpty Then
        Result := qryAux.FieldByName('LOT_SALDOS').AsFloat;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fRetSaldosMLEmpresa(strCodIte, strCodEmp: String; strNumLot: String = ''): Double;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  If fEmptyStr(strNumLot) Then
  Begin
    qryAux.SQL.Add('SELECT ITE_SAL_ML FROM ITEGER WHERE ');
    qryAux.SQL.Add('ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;
    Result := qryAux.FieldByName('ITE_SAL_ML').AsFloat;
  End Else
  Begin
    With qryAux, SQL Do
    Begin
      Clear;
      Add('SELECT LOT_SAL_ML');
      Add('FROM CADLOT');
      Add('WHERE');
      Add('  LOT_CODITE = :CODITE AND LOT_CODEMP = :CODEMP AND LOT_NUMLOT = :NUMLOT');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('NUMLOT').AsString := strNumLot;

      Open;
      If Not IsEmpty Then
        Result := FieldByName('LOT_SAL_ML').AsFloat
      Else
        Result := 0;

    End;
  End;

  qryAux.Close;

  FreeAndNil(qryAux);
end;

function fItemLoteChapa(const strCodIte, strOpcDoc : String) : Boolean;
Begin
  If (fCfgSis('MARMOR', varString) = 'S') And (Pos(strOpcDoc, 'PD_OR_VN_BR_') > 0) Then
    Result := fItemMarmore(strCodIte)
  Else
    Result := False;
End;

Function fItemMarmore(strCodIte: String): Boolean;
Begin
  Result := false;
  If fCfgSis('MARMOR', varBoolean) Then
    Result := fCadIte(strCodIte).FieldByName('ITE_GRAMAR').AsString = 'S';
End;

function fGetSubItensEstrutura(ACodIte: String; ACodEmp: String = ''): TArray<String>;
begin
  If (Not fEmptyStr(ACodEmp)) Then
  Begin
    Result := String(fCampoTabela('GROUP_CONCAT(DMT_ITESUB)',
                                  'GERMAT INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM',
                                 ['GMT_CODITE', 'GMT_CODEMP'],
                                 [ACodIte, ACodEmp], False)).Split([',']);
  End
  Else
  Begin
    Result := String(fCampoTabela('GROUP_CONCAT(DMT_ITESUB)',
                                  'GERMAT INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM',
                                 ['GMT_CODITE'],
                                 [ACodIte], False)).Split([',']);
  End;
end;

function fGetSQLNumCmp(strAliasFatGor: String = 'FATGOR'): String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + '  CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(DISTINCT CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = ' + strAliasFatGor + '.AUTOINCREM ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL((SELECT GROUP_CONCAT(DISTINCT FDO_NUMCMP SEPARATOR ";") ';
  strSQL := strSQL + '                   FROM EXTDOR ';
  strSQL := strSQL + '                  WHERE FDO_SEQFDO IN (SELECT AUTOINCREM ';
  strSQL := strSQL + '                                         FROM FATDOR ';
  strSQL := strSQL + '                                        WHERE FDO_SEQGER = ' + strAliasFatGor + '.AUTOINCREM) ';
  strSQL := strSQL + '                    AND IFNULL(FDO_NUMCMP, "") <> ""), "")) ';
  Result := strSQL;
end;

function fFormataTagRepAud(const ATag: String; aModoListaRepAud: TModListaRepAud): String;
begin
  If (aModoListaRepAud = mlraIteGer) Then
    Result := 'IteGer' + ATag
  Else If (aModoListaRepAud = mlraCadLot) Then
    Result := 'CadLot' + ATag
  Else If (aModoListaRepAud = mlraCmdOri) Then
    Result := 'CmdOri' + ATag
  Else
    Raise Exception.CreateFmt('fFormataTagRepAud: modo não tratado (%d)', [Ord(aModoListaRepAud)]);
end;

function fTagRepAudToTagSQL(const ATag: String; APos: TPosTagMarcaSQL): String;
begin
  If (APos = ptmsSQLIni) Then
    Result := '/*' + ATag +'<*/'
  Else
    Result := '/*>' + ATag +'*/';
end;

function fMarcarListaRepAud(const AstrLista: String; const ATag: String; aModoListaRepAud: TModListaRepAud): String;
  Var
    LTag: String;
begin
  LTag := fFormataTagRepAud(ATag, aModoListaRepAud);

  Result := AstrLista;
  If Pos(LTag, AstrLista) = 0 Then
    Result := fTagRepAudToTagSQL(LTag, ptmsSQLIni) + AstrLista + fTagRepAudToTagSQL(LTag, ptmsSQLFim);
end;

function fExtraiListaRepAud(const ASQL: String; const ATag: String; aModoListaRepAud: TModListaRepAud): String;
  Var
    LTag,
    LTagIni,
    LTagFim: String;
begin
  LTag := fFormataTagRepAud(ATag, aModoListaRepAud);

  LTagIni := fTagRepAudToTagSQL(LTag, ptmsSQLIni);
  LTagFim := fTagRepAudToTagSQL(LTag, ptmsSQLFim);

  Result := Copy(ASQL, Pos(LTagIni, ASQL)+Length(LTagIni), (Pos(LTagFim, ASQL)-Pos(LTagIni, ASQL))-Length(LTagFim));
end;

function fLimparMarcaRepAud(const ASQL: String): String;

   procedure pRemove(const ATag: String; aModoListaRepAud: TModListaRepAud);
     Var
       LTag: String;
   begin
     LTag := fFormataTagRepAud(ATag, aModoListaRepAud);

     If (Pos(LTag, Result) > 0) Then
     begin
       Result := AnsiReplaceStr(Result, fTagRepAudToTagSQL(LTag, ptmsSQLIni), '');
       Result := AnsiReplaceStr(Result, fTagRepAudToTagSQL(LTag, ptmsSQLFim), '');
     end;
   end;

begin
  Result := Trim(ASQL);

  pRemove(TAG_REPAUD_CODITE, mlraIteGer);
  pRemove(TAG_REPAUD_CODEMP, mlraIteGer);

  pRemove(TAG_REPAUD_NUMLOT, mlraCadLot);
  pRemove(TAG_REPAUD_CODITE, mlraCadLot);
  pRemove(TAG_REPAUD_CODEMP, mlraCadLot);

  pRemove(TAG_CMDEXE_ORIGIN, mlraCmdOri);
end;

function fCountOccurences(const SubText: string; const Text: string): Integer;
begin
  if (SubText = '') Or (Text = '') Or (Pos(SubText, Text) = 0) then
    Result := 0
  else
    Result := (Length(Text) - Length(StringReplace(Text, SubText, '', [rfReplaceAll]))) div Length(subtext);
end;

function GetSQLReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True): String;
begin
  Result := '';
  Result := Result + ' UPDATE ITEGER ';
  Result := Result + ' SET ITE_REPAUD = "S" ';

  If AEntFut Then
    Result := Result + ' ,ITE_REPAEF = "S" ';

  Result := Result + ' WHERE ITE_CODITE = '+fMarcarListaRepAud('"'+ACodIte+'"', TAG_REPAUD_CODITE, mlraIteGer);

  If Not fEmptyStr(ACodEmp) Then
    Result := Result + ' AND ITE_CODEMP = '+fMarcarListaRepAud('"'+ACodEmp+'"', TAG_REPAUD_CODEMP, mlraIteGer);
end;

function fGetPedidoProvenienteDePromocaoBrinde(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT LOGGOR.AUTOINCREM');
    qryTemp.SQL.Add('FROM LOGGOR');
    qryTemp.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryTemp.SQL.Add('  AND FGO_ESPDOC = :ESPDOC');
    qryTemp.SQL.Add('  AND FGO_CODEMP = :CODEMP');
    qryTemp.SQL.Add('  AND FRMLOG LIKE (:FRMLOG)');
    qryTemp.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTemp.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTemp.ParamByName('CODEMP').AsString := strCodEmp;
    qryTemp.ParamByName('FRMLOG').AsString := '%frmFatPromocaoBrindes';
    qryTemp.Open;

    Result := Not qryTemp.IsEmpty;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>;
begin
  Result := String(fCampoTabela('GROUP_CONCAT(AUTOINCREM)', 'FATDOR',
                               ['FDO_NUMDOC','FDO_ESPDOC','FDO_CODEMP','FDO_CODITE'],
                               [ANumPed, AEspPed, AEmpPed, ACodIte])).Split([',']);
end;

function fGetEmpresasReprocessarPedido(ASeqFgo: String): TArray<String>;
Var
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  SetLength(Result, 0);

  try
    LEmpresas := String(fCampoTabela(
      'GROUP_CONCAT(DISTINCT '+SQL_GET_EMPRESA_PEDIDO_SELECT+')', SQL_GET_EMPRESA_PEDIDO_FROM, ['FATGOR.AUTOINCREM'], [ASeqFgo])).Split([',']);

    For LEmpresa In LEmpresas Do
      If Not LEmpresa.IsEmpty Then
        If Not MatchStr(LEmpresa, Result) Then
          pAddDados(Result, LEmpresa);
  except
    on e: Exception do
      raise;
  end;
end;

function fGetEmpresasReprocessarItemPedido(ASeqFdo: String): TArray<String>;
Var
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  SetLength(Result, 0);

  try
    LEmpresas := String(fCampoTabela(
      SQL_GET_EMPRESA_PEDIDO_SELECT, SQL_GET_EMPRESA_PEDIDO_FROM, ['FATDOR.AUTOINCREM'], [ASeqFdo])).Split([',']);

    For LEmpresa In LEmpresas Do
      If Not LEmpresa.IsEmpty Then
        If Not MatchStr(LEmpresa, Result) Then
          pAddDados(Result, LEmpresa);
  except
    on e: Exception do
      raise;
  end;
end;

function fGetEmpresasReprocessarItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>; overload;
Var
  LAutoincrem: String;
  LArrayAutoincrem: TArray<String>;
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  SetLength(Result, 0);

  LArrayAutoincrem := fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte);

  For LAutoincrem In LArrayAutoincrem Do
  Begin
    LEmpresas := untFuncoesGenerica.fGetEmpresasReprocessarItemPedido(LAutoincrem);

    For LEmpresa In LEmpresas Do
      If Not LEmpresa.IsEmpty Then
        If Not MatchStr(LEmpresa, Result) Then
          pAddDados(Result, LEmpresa);
  End;

end;

function ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True; blnRaise: Boolean = False): Boolean;
  Var
    LSQL: String;
begin
  LSQL := GetSQLReprocessarItem(ACodIte, ACodEmp, AEntFut);

  If fUsouBatchReprocessarSaldo(LSQL) Then
    Exit(True);

  Result := fExecutaSQL(fLimparMarcaRepAud(LSQL), blnRaise);
end;

function fUsouBatchReprocessarSaldo(const AArrSQL: Array Of String; const ACmdOri: Boolean): Boolean;
  Var
    LIDTransacao: UInt64;
    intIdx: Integer;
begin
  Result := False;

  LIDTransacao := 0;
  If Assigned(objBatchReprocessarSaldo) Then
  Begin
    If fGetConexao.InTransaction Then
      LIDTransacao := fGetIDTransacao(fGetConexao);
  End;

  If (LIDTransacao > 0) Then
  Begin
    For intIdx := Low(AArrSQL) To High(AArrSQL) Do
    Begin
      If (AArrSQL[intIdx] <> '') Then
      Begin
        objBatchReprocessarSaldo.Add(LIDTransacao, AArrSQL[intIdx], ACmdOri);
        Result := True;
      End;
    End;
  End;
end;

function fUsouBatchReprocessarSaldo(const AArrSQL: Array Of String): Boolean;
begin
  Result := fUsouBatchReprocessarSaldo(AArrSQL, False);
end;

Function fArrCodigosToText(arrCodigos: TConsultasArray): String;
  Var
    intContador: Integer;
    sltLista: TStringList;
Begin
  sltLista := TStringList.Create;

  For intContador := Low(arrCodigos) To High(arrCodigos) Do
    With arrCodigos[intContador] Do
      sltLista.Add(strCodigo);

  Result := sltLista.Text;

  FreeAndNil(sltLista);
End;

function fExecutaValCfg(strSQL, strEmp: String): String;
  Var
    qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery(Nil);
  If Pos('CFGSIS',strSQL) > 0 Then
  Begin
    qryTemp.SQL.Add(strSQL + ' AND SIS_CODEMP = :CODEMP');
    qryTemp.ParamByName('CODEMP').AsString := strEmp;
  End Else
  Begin
    qryTemp.SQL.Add(strSQL);
  End;

  qryTemp.Open;
  Result := qryTemp.Fields[0].AsString;
  qryTemp.Close;
  FreeAndNil(qryTemp);
end;

function fRetornaValCfgMarCam(strValCfgOri: String): String;
  Var
    qryCfgVal : TUniQuery;
Begin
  Result := strValCfgOri;

  If (fEmptyStr(Result)) Then
  Begin
    qryCfgVal := fCriaQuery();
    Try
      With qryCfgVal, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT SIS_VALCFG           ');
        Add('   FROM CFGSIS               ');
        Add('  WHERE SIS_CODCFG = :CODCFG ');
        Add('    AND SIS_CODEMP = :CODEMP ');
        ParamByName('CODCFG').AsString := 'CFG_CUSMAR';
        ParamByName('CODEMP').AsString := Vs_strCodEmp;
        Open;

        {
        CFG_CUSMAR:
          1-Não exibir
          2-Exibir somente margem líquida
          3-Exibir custo/margem bruta/margem líquida
          4-Exibir custo/margem bruta/margem líquida/total produtos preço tabela
          5-Exibir margem líquida/total produtos preço tabela
          6-Exibir custo / custo real / margem bruta / margem liquida
          7-Exibir custo / custo real / margem bruta / margem liquida / total produtos preço tabela
        }

        Result := StringOfChar('N', Ord(High(TMarCamOpcoes)) + 1);

        If (Not IsEmpty) And
           (Length(Result) >= 5) Then
        Begin
          If (FieldByName('SIS_VALCFG').AsString = '2') Then
            Result[3] := 'S'
          Else If (FieldByName('SIS_VALCFG').AsString = '3') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '4') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[4] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '5') Then
          Begin
            Result[3] := 'S';
            Result[4] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '6') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[5] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '7') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[4] := 'S';
            Result[5] := 'S';
          End;
        End;

        Close;
      End;
    Finally
      FreeAndNil(qryCfgVal);
    End;
  End;
end;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result := (fCfgSis('UTIWMS', VarString, strCodEmp) = 'S') And //Utilizar WMS ( Sistema de Gerênciamento de Armazém ) = SIM.
            (fCfgSis('CTLEST', VarString, strCodEmp) = '1') And //Tipo de controle de sub-estoque na mesma loja = POR LOTE.
            (fCfgSis('CADLOC', VarString, strCodEmp) = 'S') And //Utilizar cadastro de localizações físicas? = SIM.
            (fCfgSis('CONFME', VarString, strCodEmp) = '1') And //Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA.
            (fCfgSis('USACON', VarString, strCodEmp) = 'S') And //Utilizar Conferência para Entrada de Mercadorias? = SIM.
           ((fCfgSis('TIPEXP', varString, strCodEmp) = '3') Or  //Expedição = FATURAMENTO DEPOIS DA EXPEDICAO OU
            (fCfgSis('TIPEXP', varString, strCodEmp) = '4') Or  //            PEDIDO NÃO SERÁ FATURADO
            (fCfgSis('TIPEXP', varString, strCodEmp) = '5'));   //            PRÉ-ROMANEIO

end;

function fUsaSat(strCodEmp : String) : Boolean;
{$IFNDEF LINUX}
var
  strPathSat : String;
{$ENDIF}
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If (fCfgSis('USASAT', varString, strCodEmp) = 'S') and (fCfgSis('SATECF', varString, strCodEmp) = 'S') Then
  Begin
    {$IFNDEF LINUX}
    strPathSat := IncludeTrailingPathDelimiter(fCfgSis('PATSAT', varString)) + 'opcoes_sat.ini';
    If FileExists(strPathSat) Then
      Result := StrToBool(fArqIniLocal(0, 'SATCFE', 'USASAT', '0', strPathSat ))
    Else
    {$ENDIF}
      Result := False;
  End
  Else
    Result := fCfgSis('USASAT', varBoolean, strCodEmp);
End;

function fRetornaSaldoDisponivel(strCodIte                         : String;
                                 blnCnvMl                          : Boolean = False;
                                 blnFaturamento                    : Boolean = True;
                                 strNumLot                         : String = '';
                                 blnConsiderarPedidos              : Boolean = True;
                                 strCodEmp                         : String = '';
                                 strNumPedAlt                      : String = '';
                                 blnConsiderarPedidoCompraPendente : Boolean = False;
                                 blnConsiderarCfgCalSal            : Boolean = True;
                                 blnConsiderarOrdemProducao        : Boolean = True;
                                 blnInformaSaldoGeralDisponivel    : Boolean = False;
                                 blnConsiderarLocalizacaoCritica   : Boolean = False;
                                 blnUsaSalMlLote                   : Boolean = False;
                                 blnForcaSaldoReservadoViaSelect   : Boolean = False): Double;
  Var
    fltSalMl,
    fltCnvMl,
    fltSaldos,
    fltSalRes,
    fltSalResG,
    fltSalResE,
    fltSalResOP,
    fltSalEntFut,
    fltSalBaiFutRes,
    fltSalPendComp,
    fltSalExt,
    fltFatorConversaoML,
    fltSalLocCrit: Double;
begin

  fltSalEntFut := 0;
  fltSalBaiFutRes := 0;
  fltSalPendComp := 0;
  fltSalResOP := 0;
  fltSalLocCrit := 0;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  fltFatorConversaoML := fCadIte(strCodIte).FieldByName('ITE_CNV_ML').AsFloat;
  If not blnCnvMl then
    fltCnvMl := 1
  Else
    fltCnvMl := fltFatorConversaoML;

  If fltCnvMl = 0 Then
    fltCnvMl := 1;

  If (blnUsaSalMlLote) And (Not fEmptyStr(strNumLot)) Then
    fltSalMl := fCampoTabela('IFNULL(LOT_SAL_ML, 0)','CADLOT',['LOT_CODITE', 'LOT_NUMLOT', 'LOT_CODEMP'],[strCodIte, strNumLot, strCodEmp])
  Else
    fltSalMl := fCampoTabela('IFNULL(ITE_SAL_ML, 0)','ITEGER',['ITE_CODITE', 'ITE_CODEMP'],[strCodIte, strCodEmp]);

  If (Not blnCnvMl) And
     (fltSalMl > 0) And
     (fltFatorConversaoML > 0) Then
  Begin
    fltSalMl := fltSalMl
              / fltFatorConversaoML;
  End;

  if blnInformaSaldoGeralDisponivel then
    fltSaldos := fRetSaldosEmpresa(strCodIte, strCodEmp, '')
  else
    fltSaldos := fRetSaldosEmpresa(strCodIte, strCodEmp, strNumLot);

  If blnConsiderarPedidos Then
  Begin
    fltSalRes := TSaldoReservado.New(
                   TReservaParametros.New()
                     .CodigoItem(strCodIte)
                     .CodEmpresa(strCodEmp)
                     .EmpresaItem(strCodEmp)
                     .NumeroDocumento(strNumPedAlt)
                     .NumeroLote(strNumLot)
                     .ConverterML(blnCnvMl)
                     .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                     .DesconsideraPedidosEnderecamento(True)
                     .TipoReserva(trsPedidoVenda)
                     .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                   ).fGetQuantidade();

    fltSalResE := TSaldoReservado.New(
                    TReservaParametros.New()
                      .CodigoItem(strCodIte)
                      .CodEmpresa(strCodEmp)
                      .EmpresaItem(strCodEmp)
                      .NumeroDocumento(strNumPedAlt)
                      .NumeroLote(strNumLot)
                      .ConverterML(blnCnvMl)
                      .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                      .TipoReserva(trsEnderecamento)
                      .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                    ).fGetQuantidade()
  End
  Else
  Begin
    fltSalRes := 0.00;
    fltSalResE := 0.00;

    If blnConsiderarLocalizacaoCritica Then
      fltSalLocCrit := TSaldoReservado.New(
                         TReservaParametros.New()
                           .CodigoItem(strCodIte)
                           .CodEmpresa(strCodEmp)
                           .EmpresaItem(strCodEmp)
                           .NumeroDocumento(strNumPedAlt)
                           .NumeroLote(strNumLot)
                           .ConverterML(blnCnvMl)
                           .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                           .TipoReserva(trsLocalizacaoCritica)
                           .EhAtualizacao(True)
                         ).fGetQuantidade();
  End;

  fltSalResG := TSaldoReservado.New(
                  TReservaParametros.New()
                    .CodigoItem(strCodIte)
                    .CodEmpresa(strCodEmp)
                    .EmpresaItem(strCodEmp)
                    .NumeroDocumento(strNumPedAlt)
                    .NumeroLote(strNumLot)
                    .ConverterML(blnCnvMl)
                    .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                    .TipoReserva(trsGarantia)
                    .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                  ).fGetQuantidade();

  if blnConsiderarOrdemProducao then
  begin
    fltSalResOP := TSaldoReservado.New(
                     TReservaParametros.New()
                       .CodigoItem(strCodIte)
                       .CodEmpresa(strCodEmp)
                       .EmpresaItem(strCodEmp)
                       .NumeroDocumento(strNumPedAlt)
                       .NumeroLote(strNumLot)
                       .ConverterML(blnCnvMl)
                       .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                       .TipoReserva(trsOrdemProducao)
                       .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                     ).fGetQuantidade();
  end;

  If fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal) Then
  Begin
    fltSalEntFut := TEntregaFutura.New(
                    TParamEF.New()
                      .CodIte(strCodIte)
                      .CodEmp(strCodEmp)
                      .Lote(strNumLot)
                      .ConverteML(blnCnvMl)
                      .Faturamento(blnFaturamento)
                      .TipoTE(IIF(blnFaturamento, tteAutomatica, tteTodas))
                    ).Total();

    fltSalBaiFutRes := TSaldoReservado.New(
                          TReservaParametros.New()
                          .CodigoItem(strCodIte)
                          .CodEmpresa(strCodEmp)
                          .EmpresaItem(strCodEmp)
                          .NumeroDocumento(strNumPedAlt)
                          .NumeroLote(strNumLot)
                          .ConverterML(blnCnvMl)
                          .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                          .TipoReserva(trsPedidoBaixaEntregaFuturaReservSaldo)
                          .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                       ).fGetQuantidade();
  End;

  If blnConsiderarPedidoCompraPendente Then
    fltSalPendComp := fRetQuantPendentePedidoCompra(strCodIte, '', QuotedStr(strCodEmp), True);

  fltSalExt := TSaldoReservado.New(
                 TReservaParametros.New()
                    .CodigoItem(strCodIte)
                    .CodEmpresa(strCodEmp)
                    .EmpresaItem(strCodEmp)
                    .NumeroDocumento(strNumPedAlt)
                    .NumeroLote(strNumLot)
                    .ConverterML(blnCnvMl)
                    .TipoFiltroDocumento(IIF(strNumPedAlt <> '', tfdIgnorarDocumento, tfdTodos))
                    .TipoReserva(trsExterno)
                    .EhAtualizacao(blnForcaSaldoReservadoViaSelect)
                 ).fGetQuantidade();

  If (fltSalExt < 0) Then
    fltSalExt := 0;

  If (fCfgSis('MOVFUL', varString) = '2') Then
    fltSalExt := 0;

  {** Não utilizar RoundTo() AQUI... **}
  Result := (fFormataFloat((fltSaldos + fltSalPendComp), 4) * fltCnvMl) + fFormataFloat(fltSalEntFut, 4) - fltSalRes - fltSalResG - fltSalResE - fltSalResOP + fltSalMl - fltSalExt - fltSalBaiFutRes - fltSalLocCrit;

end;

function fRetornaSaldoDisponivelLotesWMS(strCodIte                          : String;
                                         blnCnvMl                           : Boolean = False;
                                         blnFaturamento                     : Boolean = True;
                                         strNumLot                          : String  = '';
                                         blnConsiderarPedidos               : Boolean = True;
                                         strCodEmp                          : String  = '';
                                         strNumPedAlt                       : String  = '';
                                         blnConsiderarPedidoCompraPendente  : Boolean = False;
                                         blnConsiderarCfgCalSal             : Boolean = True;
                                         blnConsiderarOrdemProducao         : Boolean = True;
                                         blnInformaSaldoGeralDisponivel     : Boolean = False;
                                         strSQLLotes                        : String  = '';
                                         strWhereLotes                      : String  = '';
                                         blnUsaSalMlLote                    : Boolean = False;
                                         blnForcaSaldoReservadoViaSelect    : Boolean = False): Double;
  var
    LQry : TUniQuery;
Begin

  Result := 0;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  LQry := fCriaQuery;

  Try

    LQry.SQL.Add(strSQLLotes);
    LQry.SQL.Add(strWhereLotes);
    LQry.ParamByName('CODITE').AsString := strCodIte;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;
    LQry.ParamByName('BROKER').AsString := 'N';
    LQry.Open;

    LQry.First;
    While Not LQry.Eof Do
    Begin

      Result := Result + fRetornaSaldoDisponivel(strCodIte,
                                                 blnCnvMl,
                                                 blnFaturamento,
                                                 LQry.FieldbyName('LOT_NUMLOT').AsString,
                                                 blnConsiderarPedidos,
                                                 strCodEmp,
                                                 strNumPedAlt,
                                                 blnConsiderarPedidoCompraPendente,
                                                 blnConsiderarCfgCalSal,
                                                 blnConsiderarOrdemProducao,
                                                 blnInformaSaldoGeralDisponivel,
                                                 False,
                                                 blnUsaSalMlLote,
                                                 blnForcaSaldoReservadoViaSelect);
      LQry.Next;
    End;

  Finally
    FreeAndNil(LQry);
  End;

End;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Try
    qryGen.SQL.Text :=
      ' SELECT                               ' +
      '   ITE_CODITE                         ' +
      '   , ITE_CNV_ML                       ' +
      '   , (:QTD / ITE_CNV_ML) AS RESULT    ' +
      ' FROM                                 ' +
      '   CADITE I                           ' +
      '   INNER JOIN DUP_CADBAS B            ' +
      '     ON I.ITE_CODITE = B.BAS_CODITE   ' +
      ' WHERE B.BAS_CODITE = :CODITE         ' +
      ' LIMIT 1                              ';
    qryGen.ParamByName('QTD').AsFloat := fltQuantidade;
    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.Open;

    if qryGen.IsEmpty then
      Result := fltQuantidade
    else
      Result := qryGen.FieldByName('RESULT').AsFloat;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal: Boolean = True; strEmpSalRes : String = ''; ignoraEntFut : Boolean = False): Boolean;
begin
  {*********************************************************************}
  {* AO MUDAR AS CONDIÇÕES QUE DEIXA ESSA FUNÇÃO TRUE ADEQUAR A FUNÇÃO *}
  {* fRetSQLBaseadoNaCfgEmpOri EM untFatMostraEstoqueEmp               *}
  {******************************************************************VA*}
  Result := IIf(ignoraEntFut, True, fCfgSis('ENTFUT', varBoolean, strEmpSalRes)) And (Not fCfgSis('BEFTRG', VarBoolean));
  If blnConsiderarCfgCalSal Then
    Result := Result And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']);
end;

{*****************************************************************}
{* CARREGA TODOS OS FORNECEDORES FILIAIS DO CADASTRO DE EMPRESAS *}
{**************************************************************LU*}
function fRetForFilialTodos(blnLista: Boolean = False): String;
Var
  qryGenerica :  TUniQuery;
  strSQL      : String;
begin
  qryGenerica := fCriaQuery;

  Result := '';

  strSQL := TFunctionFuncoesFaturamento.GetSelectFornecedorFilial;

  With qryGenerica Do
  Begin
    CLose;
    SQL.Clear;
    SQL.Add(strSQL);

    Result :=
      TFunctionFuncoesFaturamento.
        RetornarListaDeFornecedorFilial(ExecutarQueryEmCache(qryGenerica).Fields(0).AsString, blnLista);
  End;

  FreeAndNil(qryGenerica);
End;

{$IFDEF LINUX}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
Begin
  If (Not fEmptyStr(strCodOpe)) Then
    strOperador := strCodOpe
  Else
    strOperador := strLoginUsuarioLogado;

  If (strNomeForm = 'frmLogoff') Or (strNomeForm = 'frmSobre') Or (strNomeForm = 'frmUtilMenuPAFNFCe') Then
    Exit(True);

  If fEhAdministrador(strOperador) Then
    Exit(True);

  Result := TPermissoesAcesso.GetInstance.fVerificaAcesso(strNomeForm, strOperador);

  Result := Result Or fEmptyStr(strNomeForm);
End;
{$ENDIF}

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

function fEhOuCompoeEstrutura(strCodIte: String; strCodEmp: String=''): TItemEstru;
  Var
    qryGerMat : TUniQuery;
    LSql: String;
    LItemPrincipal: String;
begin
  Result.blnEstrutura     := False;
  Result.blnPrincipal     := False;
  Result.strItemPrincipal := '';

  LSql := fGetSQLEstruturaPai(IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp));

  LSql := 'SELECT SQL_NO_CACHE ITE_CODITE FROM (' + LSql + ') AS T';

  qryGerMat := fCriaQuery(nil);
  Try
    qryGerMat.Close;
    qryGerMat.Sql.Clear;
    qryGerMat.Sql.Add(LSql);
    qryGerMat.ParamByName('CODITE').AsString := strCodIte;

    LItemPrincipal := ExecutarQueryEmCache(qryGerMat).FieldByName('ITE_CODITE').AsString;

    Result.blnEstrutura     := Not LItemPrincipal.IsEmpty;
    Result.blnPrincipal     := strCodIte.Equals(LItemPrincipal);
    Result.strItemPrincipal := LItemPrincipal;
  Finally
    FreeAndNil(qryGerMat);
  End;
End;

function fEhItemServico(strCodIte: String; blnEntradaMercadoria : Boolean = False; strCodEmp: String = ''): Boolean;
begin
  If fEmptyStr(strCodEmp) Then
  Begin
    strCodEmp := VS_StrCodEmp;
  End;

  Result := TFunctionFuncoesFaturamento.fEhItemServico(strCodIte, strCodEmp);

  If blnEntradaMercadoria And (Not Result) Then
    Result := (fIteGer(strCodIte, strCodEmp).FieldByName('ITE_TIPPRO').AsString = TIPO_PRODUTO_SPED[9,0]);
end;

function fEhItemVendaVidro(strCodigo: String; strIteVid: String = '-1'): Boolean;
begin
  Result := TFunctionFuncoesFaturamento.EhItemVendaVidro(strCodigo, strIteVid);
end;

function fVendedorAssociadoMarca(strCodVen, strCodIte : String): Boolean;
Var
    qryGen: TUniQuery;
begin
  Result := True;

  qryGen:= fCriaQuery(Nil);
  Try
    qryGen.SQL.Text := 'SELECT VEM_CODMAR FROM VENMAR WHERE VEM_CODVEN = :CODVEN';
    qryGen.ParamByName('CODVEN').AsString := strCodVen;
    qryGen.Open;

    If (Not qryGen.IsEmpty) Then
      Result := qryGen.Locate('VEM_CODMAR', fCadIte(strCodIte).FieldByName('ITE_CODMAR').AsString, []);

  Finally
    FreeAndNil(qryGen);
  End;

end;

function fExisteVendedorAssociadoMarca(strCodVen : String): Boolean;
Var
  qryGen: TUniQuery;
begin

  qryGen:= fCriaQuery(Nil);
  Try
    qryGen.SQL.Text := 'SELECT VEM_CODMAR FROM VENMAR WHERE VEM_CODVEN = :CODVEN';;
    qryGen.ParamByName('CODVEN').AsString := strCodVen;
    qryGen.Open;

    Result := Not qryGen.IsEmpty

  Finally
    FreeAndNil(qryGen);
  End;
end;

function fValidaVendedorMarca(strCodVen, strCodIte, strOpcDoc : String): Boolean;
begin
  Result := True;

  If ((fCfgSis('COSMAR', varBoolean)) and
      (fCfgSis('UTIVMA', varBoolean)) and
      ((Pos(strOpcDoc, 'VN_PD_OR_') > 0))) Then
  Begin
    If (Not fVendedorAssociadoMarca(strCodVen, strCodIte)) Then
      Result := False;
  End;

end;

function fExibirApenasItensDoVendedorVinculadoAoCliente(strCodVen, strCodCli, strOpcDoc: String): Boolean;
begin
  Result := False;

  If (Pos(strOpcDoc, 'VN_PD_OR_') <= 0) Then
    Exit;

  If (Not fCfgSis('MLTOPE', varBoolean)) Then
    Exit;

  If (fCfgSis('ITEVEN', varInteger) <> 2) Then
    Exit;

  If (Not fExisteCLIVEN(strCodVen, strCodCli)) Then
    Exit;

  Result := True;
end;

function fExisteCLIVEN(strCodVen, strCodCli: String): Boolean;
  Var
    qryCliVen: TUniQuery;
begin
  Result := False;
  qryCliVen := fCriaQuery(Nil);

  Try
    pCarregaCLIVEN(qryCliVen, strCodVen, strCodCli);

    If (qryCliVen.IsEmpty) Then
      Exit;

    Result := True;
  Finally
    FreeAndNil(qryCliVen);
  End;
end;

procedure pCarregaCLIVEN(Var qryCliVen: TUniQuery; strCodVen, strCodCli: String);
begin
  If (qryCliVen = Nil) Then
    Exit;

  qryCliVen.Close;
  qryCliVen.SQL.Clear;
  qryCliVen.SQL.Text := ' SELECT                       '+
                        '   CVE_CODMAR,                '+
                        '   CVE_CODFOR                 '+
                        ' FROM                         '+
                        '   CLIVEN                     '+
                        ' WHERE                        '+
                        '   CVE_CODVEN = :CODVEN AND   '+
                        '   CVE_CODCLI = :CODCLI       ';

  qryCliVen.ParamByName('CODVEN').AsString := strCodVen;
  qryCliVen.ParamByName('CODCLI').AsString := strCodCli;
  qryCliVen.Open;
end;

function fItemPermitidoParaVendedorVinculadoAoCliente(strCodVen, strCodCli, strCodIte: String): Boolean;
  Var
    qryCliVen: TUniQuery;
    strCadIte: String;
    strCampo: String;
begin
  Result := False;
  qryCliVen := fCriaQuery(Nil);

  Try
    pCarregaCLIVEN(qryCliVen, strCodVen, strCodCli);

    If (qryCliVen.IsEmpty) Then
      Exit;

    strCampo  := fCampoCfgMLTOP2;
    strCadIte := fCadIte(strCodIte).FieldByName('ITE_'+strCampo).AsString;
    Result    := qryCliVen.Locate('CVE_'+strCampo, strCadIte, []);
  Finally
    FreeAndNil(qryCliVen);
  End;
end;

function fCampoCfgMLTOP2: String;
begin
  Result := IIF(fCfgSis('MLTOP2', varInteger) = 1, 'CODMAR', 'CODFOR');
end;

function fEhItemEspecial(strCodIte: String): Boolean;
begin
  If fEmptyStr(strCodIte) Then
    Exit(False);
  Result := (Pos('ITEM ESPECIAL', fCadIte(strCodIte).FieldByName('ITE_DESITE').AsString) > 0);
end;

function fGetSQLSomaCamposEntregaFutura(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): String;
var
  LPrefix: String;
begin
  Result := '';
  LPrefix:= Concat(AAlias, IIF(fEmptyStr(AAlias), '', '.'), IIF(ALote, 'LOT_', 'ITE_'));

  If (AFaturamento) Then
  Begin
    Case AnsiIndexStr(fCfgSis('CALSAL', VarString), ['3', '4', '5']) Of
      0: Result := Concat(Result, 'IFNULL(', LPrefix, 'QTEF_F, 0)');
      1: Result := Concat(Result, 'IFNULL(', LPrefix, 'QTEF_A, 0) + IFNULL(', LPrefix, 'QTEF_P, 0)');
      2: Result := Concat(Result, 'IFNULL(', LPrefix, 'QTEF_A, 0) + IFNULL(', LPrefix, 'QTEF_F, 0)');
    Else
      Result := Concat(Result, 'IFNULL(', LPrefix, 'QTEF_A, 0) + IFNULL(', LPrefix, 'QTEF_P, 0) + IFNULL(', LPrefix, 'QTEF_F, 0)');
    End;
  End
  Else
    Result := Concat(Result, 'IFNULL(', LPrefix, 'QTEF_A + ', LPrefix, 'QTEF_P + ', LPrefix, 'QTEF_F, 0)');

  Result := ' (( '+Result+' ) + IFNULL('+LPrefix+'QTPDBF, 0)) ';
end;

function fGetSQLEstruturaPai(strCodEmp: String): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                               ';
  Result := Result + '      G.AUTOINCREM,                                ';
  Result := Result + '      C.ITE_CODITE,                                ';
  Result := Result + '        ITE_DESITE,                                ';
  Result := Result + '        ITE_CODFAB,                                ';
  Result := Result + '        ITE_CODMAR,                                ';
  Result := Result + '        ITE_CODSIM,                                ';
  Result := Result + '        ITE_PRECUS,                                ';
  Result := Result + '        ITE_ICMSAI,                                ';
  Result := Result + '        ITE_IMPFED,                                ';
  Result := Result + '        ITE_DESOPE,                                ';
  Result := Result + '        ITE_OUTVAL,                                ';
  Result := Result + '        M.MAR_DESMAR                               ';
  Result := Result + ' FROM GERMAT G                                     ';
  Result := Result + ' INNER JOIN CADITE C ON C.ITE_CODITE = GMT_CODITE  ';
  Result := Result + ' INNER JOIN ITEGER E ON E.ITE_CODITE = GMT_CODITE  ';
  Result := Result + '                    AND E.ITE_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + ' INNER JOIN CADMAR M ON C.ITE_CODMAR = M.MAR_CODMAR  ';
  Result := Result + ' WHERE (GMT_CODITE = :CODITE)                      ';
  Result := Result + '    OR (SELECT COUNT(0)                            ';
  Result := Result + '        FROM DETMAT                                ';
  Result := Result + '        WHERE DMT_ITESUB = :CODITE > 0             ';
  Result := Result + '          AND DMT_SEQGER = G.AUTOINCREM)           ';
  Result := Result + ' ORDER BY ITE_DESITE                               ';
end;

function fRetEmpCarregamentoItem(strCodIte: String): String;
begin
  Result := fCadIte(strCodIte).FieldByName('ITE_EMPCAR').AsString;
end;

function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
Begin
  Result := '';

  if fEmptyStr(strCodMot) then
    exit;

  Result := fCampoTabela('MOT_DESMOT', 'MOTVPD', ['MOT_CODMOT'], [strCodMot], False);
End;

function fRetNomCliente(Const strCodCli: String): String;
var
  qryAux: TUniQuery;
Begin
  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    qryAux := fCriaQuery();
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT CLI_NOMCLI');
      qryAux.SQL.Add('FROM CADCLI');
      qryAux.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
      qryAux.SQL.Add(fGetFiltroClienteEmpresaIdentificadora(strLoginUsuarioLogado));
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      Result := ExecutarQueryEmCache(qryAux).FieldByName('CLI_NOMCLI').AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  End
  Else
  Begin
    Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  End;
End;

function fRetNomFazenda(Const strCodFaz: String): String;
Begin
  Result := fCampoTabela('FAZ_NOMFAZ', 'CADFAZ', ['FAZ_CODFAZ'], [strCodFaz], False);
End;

{$IFNDEF LINUX}
function fRetNomCliente(Const strCodCli: String; strCpfCnpjConsumidor: String): String;
  Var
    strNomCon: String;
begin
  Result := fRetNomCliente(strCodCli);

  If (Not fEmptyStr(strCpfCnpjConsumidor)) Then
  Begin
    strNomCon := fRetDadosClienteConsumidor(strCpfCnpjConsumidor, 'NOMCON');
    If (Not fEmptyStr(strNomCon)) Then
    Begin
      Result := strNomCon;
    End;
  End;
end;
{$ENDIF}

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
  Var
    strEmpAce: String;
begin
  Result := '';

  if blnComAnd Then
    Result := Result + ' AND ';

  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    strEmpAce := fRetEmpAcessoUsuario(strCodOpe);

    Result := Result + ' ( ';
    If Not fEmptyStr(strEmpAce) Then
      Result := Result + '   (CLI_EMPIDE IN (' + fRetStrToSQLIn(strEmpAce) + ')) OR ';
    Result := Result + '   (CLI_EMPIDE IS NULL) OR ';
    Result := Result + '   (CLI_EMPIDE = "") ';
    Result := Result + ' ) ';
  End
  Else
    Result := Result + ' TRUE ';
end;

procedure pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
Begin
  If (fCfgSis('CXAEXP', VarString) = '2') Then
    Exit;
  If (fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel)) Then
  Begin
    pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli);
  End;
End;

function fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT                           ';
    strSQL := strSQL + '  CTR_NUMDUP                     ';
    strSQL := strSQL + 'FROM                             ';
    strSQL := strSQL + '  CADREC                         ';
    strSQL := strSQL + 'WHERE                            ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP    AND    ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC    AND    ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP    AND    ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI    AND    ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL    AND    ';
    strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND    ';  // VERIFICA SE É PARCELA É A VISTA
    strSQL := strSQL + '  CTR_VALDUP = 0          AND    ';  // FOI TOTALMENTE QUITADA.
    strSQL := strSQL + '  CTR_SEQBAI = 0                 ';

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strParcel;
      Open;

      Result := (Not IsEmpty);
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

End;

procedure pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE                     ';
    strSQL := strSQL + '  MOVGER                   ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'SET                        ';
    strSQL := strSQL + '  GER_OPLBRC = :OPLBRC,    ';
    strSQL := strSQL + '  GER_DTLBRC = :DTLBRC,    ';
    strSQL := strSQL + '  GER_HRLBRC = :HRLBRC,    ';
    strSQL := strSQL + '  AUX_LBRCAU = "S"         ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  GER_DTLBRC IS NULL       ';  // ATUALIZA SOMENTE SE O DOCUMENTO NÃO TEVE LIBERAÇÃO

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('OPLBRC').AsString   := strLoginUsuarioLogado;
      ParamByName('DTLBRC').AsDateTime := VS_Date;
      ParamByName('HRLBRC').AsDateTime := fTime();
      ParamByName('NUMDOC').AsString   := strNumDup;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

End;

function fRetPrecoVenda(strCodIte, strTabPre: String; strCodEmp: String = ''; Conexao: TUniConnection = Nil): Double;
Var
  strSQL: String;
  qryPre: TUniQuery;
Begin

  Try

    If Assigned(Conexao) Then
      qryPre := fCriaQuery(Nil, Conexao)
    Else
      qryPre := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  ITE_PREVE' + strTabPre + ' AS PREVEN ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

    With qryPre Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      If Not fEmptyStr(strCodEmp) Then
        ParamByName('CODEMP').AsString := strCodEmp
      Else
        ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;
      Result := FieldByName('PREVEN').AsFloat;
    End;

  Finally
    FreeAndNil(qryPre);
  End;

End;

function fRetDescMaxCnd(strCodCnd: String; mdTipDes: TTipoMaxDesconto; Conexao: TUniConnection = Nil): Double;
Var
  qryCnd: TUniQuery;
  strSQL: String;
Begin

  Result := 0;

  If fEmptyStr(strCodCnd) Then
    Exit;

  If Assigned(Conexao) Then
  Begin

    qryCnd := fCriaQuery(Nil, Conexao);

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT         ';

      If mdTipDes = mdGerenteMaster Then
        strSQL := strSQL + '  CND_DESMGM AS DESMAX '
      Else If mdTipDes = mdGerenteJunior Then
        strSQL := strSQL + '  CND_DESMGE AS DESMAX '
      Else If mdTipDes = mdSubGerenteMaster Then
        strSQL := strSQL + '  CND_DESMSM AS DESMAX '
      Else If mdTipDes = mdSubGerenteJunior Then
        strSQL := strSQL + '  CND_DESMSU AS DESMAX '
      Else If mdTipDes = mdVendedorMaster Then
        strSQL := strSQL + '  CND_DESMVM AS DESMAX '
      Else
        strSQL := strSQL + '  CND_DESMAX AS DESMAX ';

      strSQL := strSQL + 'FROM           ';
      strSQL := strSQL + '  CADCND       ';
      strSQL := strSQL + 'WHERE          ';
      strSQL := strSQL + '  CND_CODIGO = :CODCND ';

      With qryCnd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCND').AsString := strCodCnd;
        Open;

        Result := FieldByName('DESMAX').AsFloat;
      End;

    Finally
      FreeAndNil(qryCnd);
    End;

  End
  Else
  Begin
    If mdTipDes = mdGerenteMaster Then
      Result := fCampoTabela('CND_DESMGM', 'CADCND', ['CND_CODIGO'], [strCodCnd], False)
    Else If mdTipDes = mdGerenteJunior Then
      Result := fCampoTabela('CND_DESMGE', 'CADCND', ['CND_CODIGO'], [strCodCnd], False)
    Else If mdTipDes = mdSubGerenteMaster Then
      Result := fCampoTabela('CND_DESMSM', 'CADCND', ['CND_CODIGO'], [strCodCnd], False)
    Else If mdTipDes = mdSubGerenteJunior Then
      Result := fCampoTabela('CND_DESMSU', 'CADCND', ['CND_CODIGO'], [strCodCnd], False)
    Else If mdTipDes = mdVendedorMaster Then
      Result := fCampoTabela('CND_DESMVM', 'CADCND', ['CND_CODIGO'], [strCodCnd], False)
    Else
      Result := fCampoTabela('CND_DESMAX', 'CADCND', ['CND_CODIGO'], [strCodCnd], False);
  End;

End;

function fEhEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte: Double): Boolean;
  var
    fltQtdEmbFec: Double;
    fltValorCalculado: Double;
    blnUnidadeEFracionada: Boolean;
begin
  blnUnidadeEFracionada := fUnidadeDoProdutoEhFracionaria(strCodIte);
  fltQtdEmbFec := fQuantEmbalagemFechadaItem(strCodIte, strTabPreco, fltQtdIte);

  If (fltQtdEmbFec > 0) And
     (fltQtdIte > 0) And
     (((Frac(fltQtdIte) = 0) And (Not blnUnidadeEFracionada)) Or blnUnidadeEFracionada) Then
  begin
    if blnUnidadeEFracionada then
      fltValorCalculado := fFrac(fltQtdIte / fltQtdEmbFec)
    else if Floor(fltQtdEmbFec) <> 0 then
      fltValorCalculado := (Floor(fltQtdIte) Mod Floor(fltQtdEmbFec))
    else
      fltValorCalculado := 0;

    result := fltValorCalculado = 0;
  end
  else
    Result := False;
end;

function fUnidadeDoProdutoEhFracionaria(strCodIte : String): Boolean;
Begin
  Result := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  Result := fCadIte(strCodIte).FieldByName('UNI_ITEFRA').AsString = 'S';
End;

function fQuantEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte : Double): Double;
  Var
    qryConsulta : TUniQuery;
    fltQtdEmbFec: Double;
    objDados: IMyCampoTabela;
    strQtdEmb: String;
    arrQtdEmb: TArray<String>;
    blnUnidadeEFracionada: Boolean;
begin
  Result := 0;

  If fEmptyStr(strCodIte) Then
    Exit;

  blnUnidadeEFracionada := fUnidadeDoProdutoEhFracionaria(strCodIte);

  If (Not ((fltQtdIte > 0) And
          (((Frac(fltQtdIte) = 0) And (Not blnUnidadeEFracionada)) Or blnUnidadeEFracionada))) Then
    Exit;

  Try
    qryConsulta := fCriaQuery(Nil);
    With qryConsulta, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT GROUP_CONCAT(DISTINCT ITB_QTDEMB ORDER BY ITB_QTDEMB DESC) AS QTDEMB ');
      Add(' FROM ITEEMB                ');
      Add(' WHERE ITB_CODITE = :CODITE ');
      Add('   AND ITB_CODEMP = :CODEMP ');
      Add('   AND IF( IFNULL(ITB_TABPRE, "") = "", ' + IfThen(fEmptyStr(strTabPreco), '""', ':TABPRE') + ', ITB_TABPRE) = :TABPRE ');
      Add(' ORDER BY ITB_QTDEMB DESC   ');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('TABPRE').AsString := strTabPreco;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      objDados := ExecutarQueryEmCache(qryConsulta);
    End;

    arrQtdEmb := objDados.FieldByName('QTDEMB').AsString.Split([',']);

    For strQtdEmb In arrQtdEmb Do
    Begin

      fltQtdEmbFec := fStrToFloat(strQtdEmb.Replace('.',','));

      If Not blnUnidadeEFracionada Then
      Begin
        If (fltQtdEmbFec > 0) And (fltQtdIte > 0) And (Frac(fltQtdIte) = 0) Then
        Begin
          If (Floor(fltQtdEmbFec) = 0) or ((Floor(fltQtdIte) Mod Floor(fltQtdEmbFec)) = 0) Then
          Begin
            Result := Floor(fltQtdEmbFec);
            Break;
          End;
        End;
      End
      Else
      Begin
        If (fltQtdEmbFec > 0) And (fltQtdIte > 0) Then
        Begin
          if fFrac(fltQtdIte / fltQtdEmbFec) = 0 then
          Begin
            Result := fltQtdEmbFec;
            Break;
          End;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function fDesconsiderarNaQtdLimDaPromoItensUnitarMaior: Boolean;
begin
  Result := (fCfgSis('AMTPRO', varBoolean)) And (fCfgSis('PROPRE') = '1') And (fCfgSis('EDIUNP', varBoolean));
end;

function fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
  fltDesf04, fltDesf05, fltDesf06: Double;
  intDecUni: Integer = -1; blnPreDol: Boolean = False; fltDesf07: Double = 0;
  fltCotacao: Double = -1): Double;
Begin
  Result := fltPreCom;

  {***********************************}
  {* VERIFICA SE CONVERTE PARA DÓLAR *}
  {********************************PZ*}
  If (blnPreDol) Then
  Begin
    If intDecUni <= 0 Then
      intDecUni := fCfgSis('DECUNI');

    If fltCotacao = -1 Then
      Result := fConvertePrecos(Result, moeDolar, intDecUni)
    Else
      Result := fFormataFloat(Result * fltCotacao, intDecUni);
  End;

  Result := Result - ( Result * ( fltDesf01 / 100 ) );
  Result := Result - ( Result * ( fltDesf02 / 100 ) );
  Result := Result - ( Result * ( fltDesf03 / 100 ) );
  Result := Result - ( Result * ( fltDesf04 / 100 ) );
  Result := Result - ( Result * ( fltDesf05 / 100 ) );
  Result := Result - ( Result * ( fltDesf06 / 100 ) );
  Result := Result - ( Result * ( fltDesf07 / 100 ) );
End;

function fCalculaPrecoCompraLiquido(strCodIte, strCodEmp: String; cdsIteGer: TUniClientDataSet): Double;
  Var
    strSQL   : String;
    strTabUti: String;
    qryGen   : TUniQuery;
    dtsIteger: TDataSet;
    LCampos  : IMyCampoTabela;
Begin
  Try
    qryGen := Nil;

    strSQL := fSqlCdsIteger('', strTabUti);

    If (Not Assigned(cdsIteGer)) Or
       (Not cdsIteGer.Locate('ITE_CODITE;ITE_CODEMP', VarArrayOf([strCodIte, strCodEmp]), [])) Then
    Begin
      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
        LCampos := ExecutarQueryEmCache(qryGen);

        If Assigned(cdsIteger) Then
          pIncluiIteger(cdsIteger, LCampos);

      End;
    End;

    If Assigned(cdsIteger) Then
    Begin
      dtsIteger := cdsIteger;
    End
    Else
    Begin
      If (Not qryGen.Active) Then
        qryGen.Open;

      dtsIteger := qryGen;
    End;

    With dtsIteGer Do
    Begin
      Result := untFuncoesGenerica.
                fCalculaPrecoCompraLiquido(Fieldbyname('ITE_PRECOM').AsFloat,
                                           Fieldbyname('ITE_DESF01').AsFloat,
                                           Fieldbyname('ITE_DESF02').AsFloat,
                                           Fieldbyname('ITE_DESF03').AsFloat,
                                           Fieldbyname('ITE_DESF04').AsFloat,
                                           Fieldbyname('ITE_DESF05').AsFloat,
                                           Fieldbyname('ITE_DESF06').AsFloat);
      Result := fFormataFloat(Result, fCfgSis('DECUNI', VarInteger));
    End;

  Finally
    If Assigned(qryGen) Then
      FreeAndNil(qryGen);
  End;
end;

function fConvertePrecos(fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer = 2): Double;
Var
  qryGen   : TUniQuery;
  LParametrosMoedaConvertePrecos: IParametrosMoedaConvertePrecos;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(TFunctionsSQL.GetSelectConvertePrecos);
      Open;

      LParametrosMoedaConvertePrecos :=
        TParametrosMoedaConvertePrecos.New()
          .ValorDolarVenda(fieldbyname('MOE_DOLVEN').AsFloat)
          .ValorRealVenda(fieldbyname('MOE_REAVEN').AsFloat)
          .ValorPesoVenda(fieldbyname('MOE_PARVEN').AsFloat)
          .ValorEuroVenda(fieldbyname('MOE_EURVEN').AsFloat);

      Result :=
        TFunctionFuncoesFaturamentoPrecos
          .RegraConvertePrecos(LParametrosMoedaConvertePrecos, fltPreAtu, moeTipMoe, intDecUni);
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fSqlCdsIteger(strTabPre: String; Out strTabUti: String): String;
Begin
  If fEmptyStr(strTabPre) Then
    strTabPre := '-1';

  Result := TFunctionFuncoesFaturamento.SqlCdsIteger(strTabPre, strTabUti);
End;

Procedure pIncluiIteger(cdsIteger: TUniClientDataSet; ACampos: IMyCampoTabela);
  Var
    intIndice: Integer;
Begin
  With cdsIteger Do
  Begin
    Insert;

    For intIndice := 0 To Fields.Count - 1 Do
      Fields[intIndice].Value := ACampos.FieldbyName(Fields[intIndice].FieldName).Value;

    Post;
  End;
End;

Procedure pIncluiIteger(cdsIteger: TUniClientDataSet; qryIteger: TUniQuery);
  Var
    intIndice: Integer;
Begin
  With cdsIteger Do
  Begin
    Insert;

    For intIndice := 0 To Fields.Count - 1 Do
      Fields[intIndice].Value := qryIteger.FieldbyName(Fields[intIndice].FieldName).Value;

    Post;
  End;
end;

function fRetornaPercIVA(strCodAbf: String; strEstado, strTipAbf: String; cdsPerIva: TUniClientDataSet = Nil): Double;
Var
  objDadosAbf: IMyCampoTabela;
begin
  If Assigned(cdsPerIva) Then
    With cdsPerIva Do
    Begin
      If Locate('ABF_CODABF;ABF_ESTADO', VarArrayOf([strCodAbf, strEstado]), []) Then
      Begin
        Result := FieldByName('ABF_IVA_ST' + strTipAbf).AsFloat;
        Exit;
      End;
    End;

  objDadosAbf := fGetDadosAbf(strCodAbf, strEstado);

  {********************************************}
  {* PEGA PERCENTUAL AVI DA ABREVIAÇÃO FISCAL *}
  {*****************************************LU*}
  Result := objDadosAbf.FieldByName('ABF_IVA_ST' + strTipAbf);

  If Assigned(cdsPerIva) Then
    pIncluiCdsAbreviacao(cdsPerIva, objDadosAbf);
end;

function fGetDadosAbf(strCodAbf, strEstado: String): IMyCampoTabela;
Var
  qryAbfIcm: TUniQuery;
begin
  qryAbfIcm := fCriaQuery();
  Try
    qryAbfIcm.SQL.Text := TFunctionFuncoesFaturamento.GetDadosAbf;
    qryAbfIcm.ParamByName('CODABF').AsString := strCodAbf;
    qryAbfIcm.ParamByName('ESTADO').AsString := strEstado;
    Result := ExecutarQueryEmCache(qryAbfIcm);
  Finally
    FreeAndNil(qryAbfIcm);
  End;
end;

Procedure pIncluiCdsAbreviacao(cdsPerIva: TUniClientDataSet; objDadosAbf: IMyCampoTabela);
Var
  intCol: Integer;
Begin
  cdsPerIva.Insert;
  For intCol := 0 To cdsPerIva.Fields.Count -1 Do
    cdsPerIva.Fields[intCol].Value := objDadosAbf.FieldByName(cdsPerIva.Fields[intCol].FieldName);
  cdsPerIva.Post;
end;

function fGetTipoAbfCliente(const strCodCli: String; strConsum: String = ''; strIndust: String = '';
  strEmp_TE: String = ''; strCodEmp: string = ''; strProRur: String = ''): String;
Var
  qryCliente: TUniQuery;
  objDadosCliente: IMyCampoTabela;
begin
  Result := '';

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If fEmptyStr(strCodCli) Then
    Exit(fGetTipoAbf('C', '', '', '', '', '', '', '', '', '', ''));

  qryCliente := fCriaQuery;

  Try
    qryCliente.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfCliente;
    qryCliente.ParamByName('CODCLI').AsString := strCodCli;
    objDadosCliente := ExecutarQueryEmCache(qryCliente);

    Result :=
      TFunctionFuncoesFaturamento.
        fGetTipoAbfCliente(strCodCli,
                           objDadosCliente.FieldByName('FISJUR'),
                           objDadosCliente.FieldByName('I_E_S_'),
                           IIF(fEmptyStr(strConsum), objDadosCliente.FieldByName('CONSUM'), strConsum),
                           objDadosCliente.FieldByName('CODATI'),
                           IIF(fEmptyStr(strProRur), objDadosCliente.FieldByName('PRORUR'), strProRur),
                           objDadosCliente.FieldByName('MICEMP'),
                           objDadosCliente.FieldByName('REGTRI'),
                           '',
                           IIF(fEmptyStr(strIndust),objDadosCliente.FieldByName('INDUST'), strIndust),
                           VS_strCliFil,
                           fAtividadeConstrutora(objDadosCliente.FieldByName('CODATI'), strCodEmp));

    If (Result = '_SAI_TRS') Then
    Begin
      If (objDadosCliente.FieldByName('INDUST').AsString = 'S') Then
        Result := '_SAI_IND'
      Else If (fGetTipOpeTransferencia(IIF(fEmptyStr(strEmp_TE), strCodEmp, strEmp_TE), strCodCli) = 'V') Then
        Result := '_SAI_CNC';
    End;
  Finally
    FreeAndNil(qryCliente);
  End;
end;

function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur,
  strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
begin
  Result :=
    TFunctionFuncoesFaturamento.fGetTipoAbf(strTipFC, strFisJur,
      strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor,
      strIndust, strFilial, fAtividadeConstrutora(strCodAti));
end;

function fAtividadeConstrutora(strCodAti: String; strCodEmp: string = ''): Boolean; // FuncoesSimples
Var
  LCodigoAtividadeBD : String;
begin
  if fEmptyStr(strCodEmp) then
    strCodEmp := VS_strCodEmp;

  LCodigoAtividadeBD :=
    fCampoTabela('ATI_CODATI', 'CLIATI', ['ATI_CODATI', 'ATI_CODEMP'], [strCodAti, strCodEmp], False);

  Result := TFunctionFuncoesFaturamento.fAtividadeConstrutora(strCodAti, LCodigoAtividadeBD);
end;

function fGetTipOpeTransferencia(strEmpOri, strCliFil: String): String;
  Var
    qryConEmp : TUniQuery;
begin
  qryConEmp := fCriaQuery(Nil);
  Try
    With qryConEmp Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT IF(CON_TIPOPE=2, "T", "V") AS CON_TIPOPE ');
      SQL.Add('   FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = :EMPORI ');
      SQL.Add('                                AND CON_EMPDES = EMP_CODEMP ');
      SQL.Add('  WHERE EMP_CLIFIL = :CLIFIL ');
      ParamByName('EMPORI').AsString := strEmpOri;
      ParamByName('CLIFIL').AsString := strCliFil;
      Result := ExecutarQueryEmCache(qryConEmp).FieldByName('CON_TIPOPE').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryConEmp);
  End;
end;

function fGetInformacoesUltimaCompra(const strCodIte: String;
                                     var dtaDataCompra: TDateTime;
                                     var strDocumento: String;
                                     var fltPrecoCompra: Double;
                                     var strFornecedor: String): Boolean;
var
  qryGen: TUniQuery;
  objDados: IMyCampoTabela;
begin
  qryGen := fCriaQuery(nil);

  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ITE_DTAULT, ITE_NOTULT, ITE_PREULT, ITE_FORULT ');
    qryGen.SQL.Add('FROM ITEGER ');
    qryGen.SQL.Add('WHERE ITE_CODITE = :CODITE ');

    If Not fEmptyStr(fRetForFilialTodos(True)) Then
      qryGen.SQL.Add('  AND (ITE_FORULT NOT IN (' + fRetForFilialTodos(True) + ')) ');

    qryGen.SQL.Add('ORDER BY ITE_DTAULT DESC ');
    qryGen.SQL.Add('LIMIT 1 ');

    qryGen.ParamByName('CODITE').AsString := strCodIte;

    objDados := ExecutarQueryEmCache(qryGen);

    dtaDataCompra  := 0;
    fltPrecoCompra := 0.0;
    strDocumento   := '';
    strFornecedor  := '';

    Result := Not objDados.FieldByName('ITE_FORULT').AsString.IsEmpty;

    If Result Then
    Begin
      dtaDataCompra  := objDados.FieldByName('ITE_DTAULT').AsDateTime;
      fltPrecoCompra := objDados.FieldByName('ITE_PREULT').AsFloat;
      strDocumento   := objDados.FieldByName('ITE_NOTULT').AsString;
      strFornecedor  := objDados.FieldByName('ITE_FORULT').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

{***********************************************************************}
{* -> Calcula 1 Preco de Venda  e  2 Margem Bruta                      *}
{********************************************************************WI*}
function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                            curPrecus: Double;
                            curPreven: Double;
                            curMarBru: Double;
                            curIcmsVenda: Double;
                            curImpFed: Double;
                            curDesOpe: Double;
                            curValCom: Double;
                            strMarMkp: String = '';
                            strPcmPro: String = '';
                            intDecUni: Integer = -1;
                            fltIcmsST: Double = 0;
                            blnCalcSt: Boolean = False;
                            curDifal: Double = 0;
                            curFCP: Double = 0;
                            curOutVal: Double = 0;
                            blnRestringirElementosMargem: Boolean = false;
                            fltCnvCus: Double = 1):Double;
Begin
  Result := untCalculoPrecoVenda.fCalculaPrecoVenda(intOpcPrecoMargem,
                                                    curPrecus,
                                                    curPreven,
                                                    curMarBru,
                                                    curIcmsVenda,
                                                    curImpFed,
                                                    curDesOpe,
                                                    curValCom,
                                                    strMarMkp,
                                                    strPcmPro,
                                                    intDecUni,
                                                    fltIcmsST,
                                                    blnCalcSt,
                                                    curDifal,
                                                    curFCP,
                                                    curOutVal,
                                                    blnRestringirElementosMargem,
                                                    fltCnvCus);
End;

function fRetNomeRedeLoja(Const strCodRed: String): String;
  Var
    strSQL   : String;
    qryGenRed: TUniQuery;

begin
  Try

    qryGenRed := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  RED_DESRED NOMRED ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRED ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RED_CODRED = :CODRED ';

    With qryGenRed Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODRED').AsString := strCodRed;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('NOMRED').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRed);
  End;

end;

{*****************************************}
{* RETORNA SE UM FORNECEDOR É SIMPLES    *}
{**************************************MV*}
function fRetFornecedorSimples(strCodFor: String): Boolean;
begin
  Result := fRetFornecedorRegimeTributario(strCodFor) = 'S';
end;

function fRetFornecedorRegimeTributario(strCodFor: String): string;
begin
  Result := fCampoTabela('FOR_SIMPAU', 'CADFOR', ['FOR_CODFOR'], [strCodFor], False);
end;

function fRetNomFornecedor(strCodFor: String): String;
  Var
    strSQL   : String;
    qryGenFor: TUniQuery;

Begin
  Try

    qryGenFor := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

    With qryGenFor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('FOR_NOMFOR').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenFor);
  End;

End;

function fRetNomeLinhaGrupo(strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenGru: TUniQuery;

Begin
  Try

    qryGenGru := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADGRU ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GRU_CODGRU = :CODGRU ';

    With qryGenGru Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODGRU').AsString := strCodigo;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('GRU_DESGRU').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenGru);
  End;

End;

function fRetNomMarca(strCodMar: String): String;
  Var
    strSQL   : String;
    qryGenMar: TUniQuery;
Begin
  Try

    qryGenMar := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MAR_CODMAR = :CODMAR ';
    strSQL := strSQL + '  AND CADMAR.MAR_ATIVA_ = "S" ';

    With qryGenMar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMAR').AsString := strCodMar;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('MAR_DESMAR').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenMar);
  End;

End;

function fRetornaTelefonesCliente(Const strCodCli: String): String;
var
  qryTelefones: TUniQuery;
begin
  qryTelefones := fCriaQuery;

  try
    Result := EmptyStr;

    qryTelefones.Close;
    qryTelefones.SQL.Clear;
    qryTelefones.SQL.Add('SELECT CLI_FONE01, CLI_FONE02, CLI_CELULA');
    qryTelefones.SQL.Add('FROM CADCLI');
    qryTelefones.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryTelefones.ParamByName('CODCLI').AsString := strCodCli;
    qryTelefones.Open;

    if qryTelefones.IsEmpty then
      Exit;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE01').AsString) then
      Result := Result + qryTelefones.FieldByName('CLI_FONE01').AsString;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE02').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryTelefones.FieldByName('CLI_FONE02').AsString;
    end;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_CELULA').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryTelefones.FieldByName('CLI_CELULA').AsString;
    end;

  finally
    FreeAndNil(qryTelefones);
  end
end;

function fRetornaEmailsCliente(Const strCodCli: String): String;
var
  qryEmails: TUniQuery;
begin
  qryEmails := fCriaQuery;

  try
    Result := EmptyStr;

    qryEmails.Close;
    qryEmails.SQL.Clear;
    qryEmails.SQL.Add('SELECT CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3');
    qryEmails.SQL.Add('FROM CADCLI');
    qryEmails.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryEmails.ParamByName('CODCLI').AsString := strCodCli;
    qryEmails.Open;

    if qryEmails.IsEmpty then
      Exit;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL_').AsString) then
      Result := Result + qryEmails.FieldByName('CLI_EMAIL_').AsString;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL2').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryEmails.FieldByName('CLI_EMAIL2').AsString;
    end;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL3').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryEmails.FieldByName('CLI_EMAIL3').AsString;
    end;

  finally
    FreeAndNil(qryEmails);
  end
end;

function fRetCstPisCofins(strClaFis, strCodSit, strIncPis, strSitP_C, strMenP_C: String;
  blnForcaCstPisCofSimPau: Boolean = False): String;

  function fNaoEhVenda: Boolean;
  begin
    Result := Pos(strClaFis, VS_strClaVen) <= 0;
  end;

  function fNaoEhCompra: Boolean;
  begin
    Result := Pos(strClaFis, VS_strClaCom) <= 0;
  end;

  function fNaoEhDevolucao: boolean;
  begin
    Result := Pos(RightStr(strClaFis, 3), '202_411_') <= 0;
  end;

  function fNaoEhTransferencia: boolean;
  begin
    Result := Pos(RightStr(strClaFis, 3), '152_409_') <= 0;
  end;

  function fEhServico: boolean;
  begin
    Result := Pos(RightStr(strClaFis, 3), '933_') > 0;
  end;

  function fEhClassificacaoDeEntrada: Boolean;
  begin
    If fEmptyStr(strClaFis) Then
      Exit(False);

    Result := (StrToIntDef(LeftStr(strClaFis, 1), 5) < 5);
  end;

begin

  If (fCfgSis('SIMPAU', varString) = 'S') And  (fCfgSis('IGNSIM') = '1') Then
  Begin
    If blnForcaCstPisCofSimPau Then
    Begin
      If (fEhClassificacaoDeEntrada) Then
        Result := '98'
    Else
        Result := '49';
    End
    Else
      Result := '99';
  End
  Else
  Begin
    If (fNaoEhVenda And fNaoEhDevolucao And fNaoEhCompra){ Or (fEhServico)} Then
    Begin
      If fCfgSis('CSTPOD', varBoolean) Then
        Result := '49'
      Else
      Begin
        If fNaoEhTransferencia Then
          Result := '08'
        Else
          Result := '99';
      End;
    End
            {Devolucao}
    Else If (Not fNaoEhDevolucao) And fCfgSis('CSTPOD', varBoolean) Then
    Begin
      If strClaFis > '5000' Then
        Result := '01'
      Else
        Result := '50';
    End

    Else If (strIncPis = 'S') Then
    Begin
      If strClaFis > '5000' Then
        Result := '01'
      Else
        Result := '50';
    End

    Else
    Begin
      If strClaFis > '5000' Then
      Begin
        If (strSitP_C = 'D') And (Pos(strCodSit, CST_DIFERE_PIS_COFINS) > 0) Then
          Result := '09'
        Else
          Result := '07';
      End
      Else
        Result := '70';
    End;
  End;

  // Nota de amostra grátis
  if Pos(strClaFis, '5911_6911') > 0 then
    Result := '07';

  Case AnsiIndexStr(UpperCase(strSitP_C), ['I','S','Z']) of
    0 : Begin
          Result := '07';
        End;
    1 : Begin
          Result := '09';
        End;
    2 : Begin
          Result := '06';
        End;
  End;

end;

function fRetPerComLucro(fltQtdIte, fltUniOri, fltTotCus,
    fltTotIteLiq, fltComVar: Double;
    fltTotCu2: Double = 0.0;
    strMarMkp: String = '';
    strPcmPro: String = '';
    intDecUni: Integer = -1): Double;
  Var
    fltTotOri: Double;
    fltPreVen: Double;
    fltMSuger: Double;
    fltMPrati: Double;

Begin

  fltTotOri := Abs(fltQtdIte * fltUniOri);
  fltPreVen := Abs(fltTotIteLiq);

  fltMSuger := fCalculaPrecoVenda(2, Abs(fltTotCus), fltTotOri, 0, 0, 0, 0, 0, strMarMkp, strPcmPro, intDecUni);

  If (fltTotCu2 > 0) Then Begin
    fltMPrati := fCalculaPrecoVenda(2, Abs(fltTotCu2), fltPreVen, 0, 0, 0, 0, 0, strMarMkp, strPcmPro, intDecUni);
  End Else Begin
    fltMPrati := fCalculaPrecoVenda(2, Abs(fltTotCus), fltPreVen, 0, 0, 0, 0, 0, strMarMkp, strPcmPro, intDecUni);
  End;

  If fltMSuger <> 0 Then
    Result := fFormataFloat( ( fltComVar * ( fltMPrati / fltMSuger ) ), 2 )
  Else
    Result := 0.00;

  Result := Result;
End;

function fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, fltDifal, fltFCP: Double): Double;
  Var
    objParCalculaPrecoCusto: TParCalculaPrecoCusto;
begin
  objParCalculaPrecoCusto := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);

  Try
    Result := objParCalculaPrecoCusto.fCalculaPrecoCustoRealVenda(
      fltPreVen,
      fltPreCus,
      fltOutVal,
      fltICMSai,
      fltImpFed,
      fltDesOpe,
      fltDifal,
      fltFCP);
  Finally
    FreeAndNil(objParCalculaPrecoCusto);
  End;
end;

function fRetPerComOpeMargem(fltCusto, fltVenda : Double; strCodOpe : String; strCodEmp : String = ''): Double;
  Var
    strSQL   : String;
    qryGenCom: TUniQuery;
    fltPercentual : Double;
Begin
  Try

    fltPercentual := fCalculaPrecoVenda(2,fltCusto,fltVenda,0,0,0,0,0);

    qryGenCom := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  COM_PERCOM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  COMOPE ';
    strSQL := strSQL + 'WHERE (:DESCON BETWEEN COM_PERINI AND COM_PERFIN) ';
    strSQL := strSQL + 'AND    COM_CODOPE = :CODOPE ';

    If (Not fEmptyStr(strCodEmp)) Then
      strSQL := strSQL + ' AND COM_CODEMP =:CODEMP ';

    With qryGenCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DESCON').AsFloat  := fltPercentual;
      ParamByName('CODOPE').AsString := strCodOpe;

      If (Not fEmptyStr(strCodEmp)) Then
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      If Not IsEmpty Then
        Result := qryGenCom.FieldByName('COM_PERCOM').AsFloat
      Else
        Result := 0;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCom);
  End;

End;

function fRetPerComMargem(fltValor: Double; strTipVen: String = ''; strConPag : String = ''): Double;
  Var
    strSQL   : String;
    qryGenCom: TUniQuery;
Begin
  Try

    qryGenCom := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    If (fStatusCndPag(strConPag) = A_VISTA) Then
      strSQL := strSQL + '  COM_PERCOM AS PERCOM '
    Else
      strSQL := strSQL + '  COM_PERCOP AS PERCOM ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCOM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  :VALOR >= COM_PERINI AND ';
    strSQL := strSQL + '  :VALOR <= COM_PERFIN ';

    If (fCfgSis('OPCCOM') = 'PD') And (not fEmptyStr(strTipVen)) Then
      strSQL := strSQL + '  AND COM_TIPVEN = :TIPVEN ';

    With qryGenCom Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALOR').AsFloat := RoundTo(fltValor, -2);

      If (fCfgSis('OPCCOM') = 'PD') And (not fEmptyStr(strTipVen)) Then
        ParamByName('TIPVEN').AsString := strTipVen;

      Result := ExecutarQueryEmCache(qryGenCom).FieldByName('PERCOM');

      Close;
    End;

  Finally
    FreeAndNil(qryGenCom);
  End;

End;

function fStatusCndPag(strCndPag: String): Integer;
begin

  Result := A_PRAZO;

  strCndPag := Trim(fTiraCaracEspeciais(strCndPag));

  Try
    If fStrToFloat(strCndPag) = 1000.0 Then
      Result := A_VISTA;
  Except
    {*****************************************}
    {* APENAS PARA NÃO DAR ERRO PARA O USUA- *}
    {* RIO.                                  *}
    {**************************************MV*}
  End;

end;

function fRetConPagCodCnd(strCodCnd: String): String;
Begin
  Result := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [strCodCnd], False);
End;

function fPercDescClienteProduto(strCodCli, strCodIte: String): Double;
begin
  Result := fCampoTabela('PDS_PERDES', 'PRODES', ['PDS_CODCLI', 'PDS_CODITE'], [strCodCli, strCodIte]);
end;

function fPercDescClienteMarca(strCodCli, strCodIte: String): Double;
var
  strCodMar: String;
begin
  strCodMar := fCadIte(strCodIte).FieldByName('ITE_CODMAR').AsString;
  Result := fCampoTabela('MDS_PERDES', 'MARDES', ['MDS_CODCLI', 'MDS_CODMAR'], [strCodCli, strCodMar]);
end;

function fPercDescComissClienteRegiao(strCodCli, strCodIte, strCampo: String; Var fltPerDes: Double): Boolean;
  Var
    qryConCli: TUniQuery;
    strCodFor, strSql: String;
    fltPerDesCliPro,
    fltPerDesCliMar: Double;
begin
  fltPerDes := 0.00;
  Result    := False;

  If Not fCfgSis('UTCDDE', varBoolean) Then
    Exit;

  strCodFor := fCadIte(strCodIte).FieldByName('ITE_CODFOR').AsString;

  If Not fEmptyStr(strCodFor) Then
  Begin
    strSql := '';
    strSql := strSql + ' SELECT SQL_NO_CACHE ';
    strSql := strSql + '        IFNULL(CDS_' + strCampo + ',0) AS CDS_PERCEN, ';
    strSql := strSql + '        IFNULL(RDS_' + strCampo + ',0) AS RDS_PERCEN  ';
    strSql := strSql + ' FROM ';
    strSql := strSql + '   CADCLI ';
    strSql := strSql + '   LEFT JOIN CLIDES ON CLI_CODCLI = CDS_CODCLI AND CDS_CODFOR = ' + QuotedStr(strCodFor);
    strSql := strSql + '   LEFT JOIN REGDES ON CLI_CODREG = RDS_CODREG AND RDS_CODFOR = ' + QuotedStr(strCodFor);
    strSql := strSql + ' WHERE ';
    strSql := strSql + '   CLI_CODCLI =  ' + QuotedStr(strCodCli);

    Try
      qryConCli := fCriaQuery;

      With qryConCli, SQL Do
      Begin
        Clear;
        Add(strSql);
        Open;

        If ((FieldByName('CDS_PERCEN').AsFloat > 0) Or (FieldByName('RDS_PERCEN').AsFloat > 0)) Then
          fltPerDes := Max(FieldByName('CDS_PERCEN').AsFloat, FieldByName('RDS_PERCEN').AsFloat);

        Result := ((FieldByName('CDS_PERCEN').AsFloat > 0) Or (FieldByName('RDS_PERCEN').AsFloat > 0));
      End;
    Finally
      FreeAndNil(qryConCli);
    End;
  End;

  If (strCampo = 'PERDES') Then
  Begin
    fltPerDesCliPro := fPercDescClienteProduto(strCodCli, strCodIte);
    fltPerDesCliMar := fPercDescClienteMarca(strCodCli, strCodIte);

    If (fltPerDesCliPro > fltPerDes) or (fltPerDesCliMar > fltPerDes) Then
    Begin
      Result    := True;

      if fltPerDesCliPro > fltPerDesCliMar then
        fltPerDes := fltPerDesCliPro
      else
        fltPerDes := fltPerDesCliMar;
    End;
  End;

end;

function fRetSQLEnderecoEntregaCli(strTabMov: String; blnTodCam: Boolean = False): String;
  Var
    strSQL: String;
    strTabAux: String;
Begin
  strTabAux :=  fRetNomTabAuxMov(strTabMov);

  strSQL := '';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  If blnTodCam Then
  Begin
    strSQL := strSQL + '  C.*, ';
    strSQL := strSQL + '  CC.CID_NOMCID AS CLI_NOMCID, ';
    strSQL := strSQL + '  CC.CID_ESTADO AS CLI_ESTADO, ';
    strSQL := strSQL + '  CE.CID_NOMCID AS CLI_NCIDEN, ';
    strSQL := strSQL + '  CE.CID_ESTADO AS CLI_NESTEN, ';
  End
  Else
  Begin
    strSQL := strSQL + '  C.*, ';

    {strSQL := strSQL + '  CLI_CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI, ';
    strSQL := strSQL + '  CLI_FANSOB, ';
    strSQL := strSQL + '  CLI_CGCCPF, ';
    strSQL := strSQL + '  CLI_C_G_C_, ';
    strSQL := strSQL + '  CLI_I_E_S_, ';
    strSQL := strSQL + '  CLI_FONE01, ';
    strSQL := strSQL + '  CLI_ENDERE, ';
    strSQL := strSQL + '  CLI_BAIRRO, ';
    strSQL := strSQL + '  CLI_CODCID, ';
    strSQL := strSQL + '  CLI_C_E_P_, ';
    strSQL := strSQL + '  CLI_ENDNUM, ';
    strSQL := strSQL + '  CLI_ENDCOM, ';
    strSQL := strSQL + '  CLI_FONE01, ';}
  End;

  strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDNUM, "") = "", C.CLI_ENDERE, CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))) AS ENDERE, ';

  strSQL := strSQL + '  CC.CID_NOMCID AS CIDCLI, ';
  strSQL := strSQL + '  CC.CID_ESTADO AS ESTCLI, ';

  strSQL := strSQL + '  E.*,                     ';
  strSQL := strSQL + '  CE.CID_NOMCID AS ETC_NOMCID, ';
  strSQL := strSQL + '  CE.CID_ESTADO AS ETC_ESTADO  ';

  strSQL := strSQL + '  FROM CADCLI C ';

  strSQL := strSQL + ' LEFT JOIN (';

  If Not fEmptyStr(strTabAux) Then
  Begin
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   ETC_CODCLI,       ';
    strSQL := strSQL + '   ETC_ENDENT,       ';
    strSQL := strSQL + '   ETC_BAIENT,       ';
    strSQL := strSQL + '   ETC_CIDENT,       ';
    strSQL := strSQL + '   ETC_CEPENT,       ';
    strSQL := strSQL + '   ETC_TELENT,       ';
    strSQL := strSQL + '   ETC_REFENT,       ';
    strSQL := strSQL + '   ETC_CONENT,       ';
    strSQL := strSQL + '   ETC_CODTRA,       ';
    strSQL := strSQL + '   ETC_COBISS,       ';
    strSQL := strSQL + '   ETC_CODOBR,       ';
    strSQL := strSQL + '   ETC_CODART,       ';
    strSQL := strSQL + '   ETC_CODCNO,       ';
    strSQL := strSQL + '   ETC_INSIMO,       ';
    strSQL := strSQL + '   ETC_CODCIB,       ';
    strSQL := strSQL + '   -1 AS ETC_SEQIND   ';
    strSQL := strSQL + ' FROM                ';
    strSQL := strSQL + '   ENTCLI E          ';
    strSQL := strSQL + ' INNER JOIN ' + strTabAux + ' ON';
    strSQL := strSQL + '   AUX_ENTGER = E.AUTOINCREM AND ';
    strSQL := strSQL + '   AUX_SEQGER = :SEQGER          ';

    strSQL := strSQL + '  UNION ';
  End;

  strSQL := strSQL + ' SELECT * FROM ';

  strSQL := strSQL + ' (SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   ETC_CODCLI,       ';
  strSQL := strSQL + '   ETC_ENDENT,       ';
  strSQL := strSQL + '   ETC_BAIENT,       ';
  strSQL := strSQL + '   ETC_CIDENT,       ';
  strSQL := strSQL + '   ETC_CEPENT,       ';
  strSQL := strSQL + '   ETC_TELENT,       ';
  strSQL := strSQL + '   ETC_REFENT,       ';
  strSQL := strSQL + '   ETC_CONENT,       ';
  strSQL := strSQL + '   ETC_CODTRA,       ';
  strSQL := strSQL + '   ETC_COBISS,       ';
  strSQL := strSQL + '   ETC_CODOBR,       ';
  strSQL := strSQL + '   ETC_CODART,       ';
  strSQL := strSQL + '   ETC_CODCNO,       ';
  strSQL := strSQL + '   ETC_INSIMO,       ';
  strSQL := strSQL + '   ETC_CODCIB,       ';
  strSQL := strSQL + '   ETC_SEQIND        ';
  strSQL := strSQL + ' FROM                ';
  strSQL := strSQL + '   ENTCLI E          ';
  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '   ETC_CODCLI = :CODCLI ORDER BY ETC_SEQIND LIMIT 1) AS TAB ';

  strSQL := strSQL + '  UNION ';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE         ';
  strSQL := strSQL + '   CLI_CODCLI AS ETC_CODCLI, ';
  strSQL := strSQL + '   IF(IFNULL(CLI_ENDNUM, "") = "", CLI_ENDERE, CONCAT(CLI_ENDERE, ", ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM)))) AS ETC_ENDENT, ';
  strSQL := strSQL + '   CLI_BAIRRO AS ETC_BAIENT, ';
  strSQL := strSQL + '   CLI_CODCID AS ETC_CIDENT, ';
  strSQL := strSQL + '   CLI_C_E_P_ AS ETC_CEPENT, ';
  strSQL := strSQL + '   CLI_FONE01 AS ETC_TELENT, ';
  strSQL := strSQL + '   ""         AS ETC_REFENT, ';
  strSQL := strSQL + '   CLI_CONTAT AS ETC_CONENT, ';
  strSQL := strSQL + '   ""         AS ETC_CODTRA, ';
  strSQL := strSQL + '   ""         AS ETC_COBISS, ';
  strSQL := strSQL + '   ""         AS ETC_CODOBR, ';
  strSQL := strSQL + '   ""         AS ETC_CODART, ';
  strSQL := strSQL + '   ""         AS ETC_CODCNO, ';
  strSQL := strSQL + '   ""         AS ETC_INSIMO, ';
  strSQL := strSQL + '   ""         AS ETC_CODCIB, ';
  strSQL := strSQL + '   999999     AS ETC_SEQIND  ';
  strSQL := strSQL + ' FROM                   ';
  strSQL := strSQL + '   CADCLI               ';
  strSQL := strSQL + ' WHERE                  ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

  strSQL := strSQL + ' ORDER BY ETC_SEQIND LIMIT 1 ';

  strSQL := strSQL + ' ) E ON E.ETC_CODCLI = C.CLI_CODCLI ';

  strSQL := strSQL + ' INNER JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ';

  strSQL := strSQL + ' LEFT JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  C.CLI_CODCLI = :CODCLI ';

  Result := strSQL;
end;

function fRetSQLEnderecoEntregaCliConsumidor(strClient, strAutInc, strTabMov: String): String;
  Var
    strSQL: String;
    strAbr: String;
Begin
  strSQL := '';
  If (Pos(strTabMov, 'FATGOR_DEL_FATGOR') > 0) Then
    strAbr := 'FGO_'
  Else If (strTabMov = 'MOVGAG') Then
    strAbr := 'GAG_'
  Else
    strAbr := 'GER_';

  strSQL := strSQL + ' SELECT SQL_NO_CACHE           ';
  strSQL := strSQL + strAbr + 'ENDCON AS ETC_ENDENT, ';
  strSQL := strSQL + strAbr + 'BAICON AS ETC_BAIENT, ';
  strSQL := strSQL + strAbr + 'CIDCON AS ETC_CIDENT, ';
  strSQL := strSQL + strAbr + 'CEPCON AS ETC_CEPENT, ';
  strSQL := strSQL + strAbr + 'TELCON AS ETC_TELENT, ';
  strSQL := strSQL + strAbr + 'ESTCON AS ETC_ESTADO, ';
  strSQL := strSQL + '  ""            AS ETC_CONENT, ';
  strSQL := strSQL + '  ""            AS ETC_REFENT, ';
  strSQL := strSQL + '  ""            AS ETC_CODTRA, ';
  strSQL := strSQL + '  ""            AS ETC_COBISS, ';
  strSQL := strSQL + '  ""            AS ETC_CODOBR, ';
  strSQL := strSQL + '  ""            AS ETC_CODART, ';
  strSQL := strSQL + '  ""            AS ETC_CODCNO, ';
  strSQL := strSQL + '  ""            AS ETC_INSIMO, ';
  strSQL := strSQL + '  ""            AS ETC_CODCIB, ';
  strSQL := strSQL + '  -1            AS ETC_SEQIND  ';
  strSQL := strSQL + 'FROM                           ';
  strSQL := strSQL + strTabMov + '                   ';
  strSQL := strSQL + 'WHERE                          ';
  strSQL := strSQL + strAbr + 'CODCLI = :CODCLI AND  ';
  strSQL := strSQL + '  AUTOINCREM = :SEQGER         ';

  Result := strSQL;
end;

function fRetSeqIndEndereco(strCodCli: String; strCampo: String): Integer;
  Var
    qryEntEnt: TUniQuery;
Begin
  qryEntEnt := fCriaQuery;
  With qryEntEnt, SQL Do
  Begin
    Clear;
    Add('SELECT IFNULL(MAX(' + strCampo + '), -1) AS SEQIND FROM ENTCLI WHERE ETC_CODCLI = :CODCLI');
    ParamByName('CODCLI').AsString := strCodCli;;
    Open;
    Result := Succ(FieldByName('SEQIND').AsInteger);
    Close;
  End;
  FreeAndNil(qryEntEnt);
End;

function fFormataCEP(strCEP: String): String;
begin
	Result := '';

  If Not fEmptyStr(strCEP) Then
  Begin
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),0,5) + '-';
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),6,3);
  End;

end;

function fMarMpkParaVenda(strMarMpk: String=''): String;
begin
  Result := strMarMpk;

  If (fCfgSis('CLPVDI', varString) = 'N') Then
  Begin
     If ((fCfgSis('MARMKP', varString) = '3') Or (strMarMpk= '3')) Then
     Begin
       Result := '2';
     End;
  End;
end;

function fCalculaQuantidadeMetrosCubicos(fltQuantidade,
                                         fltComprimento,
                                         fltLargura,
                                         fltEspessura : Double;
                                         strSiglaUni  : String): Double;
begin
  If fCfgSis('VENVID',varBoolean) Then
    pConverteMedidas(fltComprimento, fltLargura, strSiglaUni);

  If fCfgSis('VENMTL',varBoolean) Then
  Begin
    fltLargura   := 1;
    fltEspessura := 1;
  End;

  Result := fltQuantidade * IIF(fltComprimento > 0, fltComprimento, 1) * fltLargura * fltEspessura;
end;

function fGetCampoMD5KEYTabelaTinta(strIdePro: String): String;
begin
  Result := strIdePro + '_MD5KEY';

  If strIdePro = 'LKS' Then
    Result := 'LKD_MD5KEY'
  Else If strIdePro = 'WCP' Then
    Result := 'WAN_MD5KEY'
  Else If strIdePro = 'LAZ' Then
    Result := 'MIX_CODIGO'
  Else If strIdePro = 'CIM' Then
    Result := 'COR_MD5KEY';
end;

function fInArray(strValor: String; arrDados: TStringArray): Boolean;
Var
    str: String;
begin
  Result := False;

  For str in arrDados Do
    If str = strValor Then
    Begin
      Result := True;
      Exit;
    End;
End;

function GetInToOr(const strNomeCampo: string; const strValores: string): string;
var
  stlResult: TStringList;
  intCont: Integer;
begin
  stlResult := nil;
  Try
    Try
      stlResult := TStringList.Create;
      stlResult.StrictDelimiter := True;
      stlResult.CommaText := strValores;

      for intCont := 0 to stlResult.Count - 1 do
        stlResult[intCont] := strNomeCampo + ' = ' + stlResult[intCont];

      stlResult.Sorted := True;
      Result := '(' + StringReplace(stlResult.CommaText, ',', ' OR ', [rfReplaceAll]) + ')';

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlResult) then FreeAndNil(stlResult);
  End;
end;

function fFormataCasaDecimalVIDRO(strMascaraDefault : Variant) : Variant;
begin
  If fCfgSis('DECVID') = 'S' Then
    Result := strMascaraDefault
  Else
    Result := '';
end;

function fRetornaInfMedVIDRO(blnDoisPontos: Boolean = False; blnAbreviadoComprimento: Boolean = False;blnMaximo : Boolean = False; blnMensagem :Boolean = False;
  blnAbreviadoAltura : Boolean = False; blnMinimo : Boolean = False; blnSugestao : Boolean = False) : String;
begin
  If fCfgSis('INFMED') = '1' Then
    Result := IfThen(blnMensagem,'A ','')+'Altu'+ IfThen(blnAbreviadoAltura,'.','ra') + IfThen(blnMaximo,' Máxima','') + IfThen(blnMinimo,' Mínima','') + IfThen(blnSugestao,' Sugestão','') + IfThen(blnDoisPontos,':','')
  Else
    Result := IfThen(blnMensagem,'O ','')+'Comprim'+ IfThen(blnAbreviadoComprimento,'.','ento') + IfThen(blnMaximo,' Máximo','') + IfThen(blnMinimo,' Mínimo','') + IfThen(blnSugestao,' Sugestão','') + IfThen(blnDoisPontos,':','');
end;

function fRoundSql(const strCampo: String; const intDecimais: Integer): String;
begin
  Result := '';

  //SE O VALOR POSSUI CASAS DECIMAIS E
  Result := Result + 'IF(LOCATE(".", {CAMPO}) > 0 AND ';

  //SE A PRECISAO DESEJADA FOR INFORMADA
  Result := Result + '   {PRECISAO} > 0 AND ';

  //SE A PRECISAO FOR MENOR QUE A QUANTIDADES DE CASAS DECIMAIS E
  Result := Result + '   LENGTH({CAMPO}) - LOCATE(".", {CAMPO}) > {PRECISAO} AND ';

  //SE O ULTIMO NUMERO TERMINAR EM 5
  Result := Result + '   MID({CAMPO}, LENGTH({CAMPO}), 1) = "5", ';

  //ENTAO SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA
  Result := Result + ' CONCAT(LEFT({CAMPO}, LENGTH({CAMPO}) - 1), "6"), ';

  //SENAO MANTEM O PROPRIO NUMERO
  Result := Result + ' {CAMPO}) ';

  //ARREDONDA O NUMERO COM A PRECISAO INFORMADA
  Result := ' ROUND(' + Result + ', {PRECISAO}) ';

  Result := AnsiReplaceStr(Result, '{CAMPO}', strCampo);
  Result := AnsiReplaceStr(Result, '{PRECISAO}', intDecimais.ToString);
end;

function fUsaTravaPorMargemMinimaLiquida: Boolean;
begin
  Result := ((VS_strTRADES = '3') And (fCfgSis('MMPOPM') = 'L'));
end;

function fAnalisaTodosCompomentesAoTravarUnitarioDeTintaComoProdutoNormal: Boolean;
begin
  Result := (fTravaUnitarioDeTintaComoProdutoNormal) And
            (fCfgSis('ANLTIN') = '2') And
            (VS_strTRADES = '3');
end;

function fTravaUnitarioDeTintaComoProdutoNormal: Boolean;
begin
  Result := (fCfgSis('TRVTIN') = '2');
end;

function IsItemAtivo(const strCodIte: string): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  Try
    qryGen.SQL.Text :=
      ' SELECT                               ' +
      '   IFNULL(ITE_ITEATI, "N") ITE_ITEATI ' +
      ' FROM                                 ' +
      '   CADITE                             ' +
      ' WHERE ITE_CODITE = :CODITE           ';
    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.Open;

    Result := qryGen.FieldByName('ITE_ITEATI').AsString = 'S';
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fIsItemEspecial(strCodIte: String): Boolean;
  Var
    qryGenIte: TUniQuery;
begin
  Try
    qryGenIte := fCriaQuery;

    With qryGenIte Do
    Begin
      SQL.Clear;

      SQL.Add('SELECT      ');
      SQL.Add('  ITE_DESITE');
      SQL.Add('FROM        ');
      SQL.Add('  CADITE    ');
      SQL.Add('WHERE       ');
      SQL.Add('  ITE_CODITE = :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
      Begin
        If Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').asString) <= 0 Then
        Begin
          Result := False;
        End
        Else
        Begin
          Result := True;

        End;

      End
      Else
        Result := False;

    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

function fRetUnidadeItem(strCodIte: String): String;
Begin
  Result := '';
  If (fEmptyStr(strCodIte)) Then
    Exit;
  Result := fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
End;

function fCriarQueryIteGer(Owner: TComponent = Nil): TUniQuery;
  Var
    strSQL: String;
    intCont, intDecUni,
    intQtdUco: Integer;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT * FROM ITEGER ';
  strSQL := strSQL + ' WHERE ITEGER.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + ' ITEGER.ITE_CODITE = :CODITE ';

  Result := fCriarQuery(strSQL, Owner);

  intQtdUco := fCfgSis('DECUNI', varInteger);
  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > fTamPrecoIteger Then
    intDecUni := 4;

  With Result Do
  Begin
    {******************************************}
    {*   MASCARAS                             *}
    {***************************************AN*}
    For intCont := 1 To 7 Do
    Begin

      { PRECO DE VENDA }
      TFloatField(FieldByName('ITE_PREVE' + IntToStr(intCont))).DisplayFormat := fMskDigitos(intDecUni);
      FieldByName('ITE_PREVE' + IntToStr(intCont)).DisplayLabel := 'Preço de Venda ' + IntToStr(intCont);

      { MARGEM BRUTA }
      TFloatField(FieldByName('ITE_MARBR' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('ITE_MARBR' + IntToStr(intCont))).EditFormat := fMskDigitos(fRetPrecisaoMargemItem);
      FieldByName('ITE_MARBR' + IntToStr(intCont)).DisplayLabel := 'Margem Bruta ' + IntToStr(intCont);

      { DESCONTO }
      If intCont < 7 Then
      Begin
        TFloatField(FieldByName('ITE_DESF0' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
        FieldByName('ITE_DESF0' + IntToStr(intCont)).DisplayLabel := 'Desconto ' + IntToStr(intCont);
      End;

      { COMISSAO POR TABELA DE PRECO }
      TFloatField(FieldByName('ITE_COMTB' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      FieldByName('ITE_COMTB' + IntToStr(intCont)).DisplayLabel := 'Com. Tab. Preço ' + IntToStr(intCont);

    End;

    TFloatField(FieldByName('ITE_PRECOM')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_IPIENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_FREENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMAX')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_ACRFIN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_SALBAL')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_SUBSTI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_ICMENT')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_ICMSAI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IPISAI')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREMED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_PREULT')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_PREUVE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_COMVAR')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_COMATA')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_COMDIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_COMDIG')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESADB')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMIN')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMSG')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMGE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESOPE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IMPFED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMGE')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMSU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_VALFRE')).DisplayFormat := fMskDigitos(intDecUni);
    TFloatField(FieldByName('ITE_SUBFED')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_SALDOS')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_ESTMIN')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_ESTMAX')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_PMED_V')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_QTDUCO')).DisplayFormat := fMskDigitos(intQtdUco);
    TFloatField(FieldByName('ITE_QTDUVE')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_SAL_ML')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_OUTVAL')).DisplayFormat := '#,##0.000';
    TFloatField(FieldByName('ITE_QTPPRO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_TCIFCU')).DisplayFormat := '#,##0.000000';
    TFloatField(FieldByName('ITE_TSCUST')).DisplayFormat := '#,##0.000000';
    TFloatField(FieldByName('ITE_DEPICO')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DEICMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_FATREG')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMVM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMSM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_DESMGM')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMMV')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMMS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_MARMMG')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('ITE_IMPULT')).DisplayFormat := fMskDigitos(intDecUni);

    TDateField(FieldByName('ITE_DTABAL')).EditMask := '99/99/9999';
    TDateField(FieldByName('ITE_DTAULT')).EditMask := '99/99/9999';
    TDateField(FieldByName('ITE_DTAUVE')).EditMask := '99/99/9999';

    {******************************************}
    {*    DISPLAY LABELS                      *}
    {***************************************AN*}
    FieldByName('ITE_CODITE').DisplayLabel := 'Cód. Item';
    FieldByName('ITE_FORULT').DisplayLabel := 'Último Fornecedor';
    FieldByName('ITE_LOCFIS').DisplayLabel := 'Localização Física';
    FieldByName('ITE_QTPPRO').DisplayLabel := 'Qtd. Pont. Profiss.';
    FieldByName('ITE_PRECOM').DisplayLabel := 'Preço de Compra';
    FieldByName('ITE_PRECUS').DisplayLabel := 'Preço de Custo';
    FieldByName('ITE_IPIENT').DisplayLabel := 'IPI Entrada';
    FieldByName('ITE_FREENT').DisplayLabel := 'Frete';
    FieldByName('ITE_DESMAX').DisplayLabel := 'Desconto Máximo';
    FieldByName('ITE_ACRFIN').DisplayLabel := 'Acréscimo Financeiro';
    FieldByName('ITE_SALBAL').DisplayLabel := 'Saldo Balanço';
    FieldByName('ITE_SUBSTI').DisplayLabel := 'Subst. Tributária';
    FieldByName('ITE_ICMENT').DisplayLabel := 'ICMS Entrada';
    FieldByName('ITE_ICMSAI').DisplayLabel := 'ICMS Venda';
    FieldByName('ITE_IPISAI').DisplayLabel := 'IPI de Venda';
    FieldByName('ITE_PREMED').DisplayLabel := 'Preço Médio';
    FieldByName('ITE_PREULT').DisplayLabel := 'Valor Últ. Compra';
    FieldByName('ITE_PREUVE').DisplayLabel := 'Valor Últ. Venda';
    FieldByName('ITE_COMVAR').DisplayLabel := 'Comissão Vendedor Interno';
    FieldByName('ITE_COMATA').DisplayLabel := 'Comissão Repres. Ext. Loja';
    FieldByName('ITE_COMDIS').DisplayLabel := 'Comissão Repres. Ext. Distrib.';
    FieldByName('ITE_COMDIG').DisplayLabel := 'Comissão Digitador';
    FieldByName('ITE_MARMIN').DisplayLabel := 'Margem Mínima Vendedor Júnior';
    FieldByName('ITE_MARMSG').DisplayLabel := 'Margem Mínima Sub Gerente Júnior';
    FieldByName('ITE_MARMGE').DisplayLabel := 'Margem Mínima Gerente Júnior';
    FieldByName('ITE_MARMMV').DisplayLabel := 'Margem Mínima Vendedor Master';
    FieldByName('ITE_MARMMS').DisplayLabel := 'Margem Mínima Sub Gerente Master';
    FieldByName('ITE_MARMMG').DisplayLabel := 'Margem Mínima Gerente Master';
    FieldByName('ITE_DESMGE').DisplayLabel := 'Desconto Máximo do Gerente Júnior';
    FieldByName('ITE_DESMSU').DisplayLabel := 'Desconto Máximo do Sub-Gerente Júnior';
    FieldByName('ITE_DESMGM').DisplayLabel := 'Desconto Máximo do Gerente Master';
    FieldByName('ITE_DESMSM').DisplayLabel := 'Desconto Máximo do Sub-Gerente Master';
    FieldByName('ITE_VALFRE').DisplayLabel := fCfgSis('DESVFR');
    FieldByName('ITE_SALDOS').DisplayLabel := 'Saldo';
    FieldByName('ITE_ESTMIN').DisplayLabel := 'Estoque Mínimo';
    FieldByName('ITE_ESTMAX').DisplayLabel := 'Estoque Máximo';
    FieldByName('ITE_PMED_V').DisplayLabel := 'Preço  Médio Venda';
    FieldByName('ITE_QTDUCO').DisplayLabel := 'Qtd. Ult. Compra';
    FieldByName('ITE_QTDUVE').DisplayLabel := 'Qtd. Últ. Venda';
    FieldByName('ITE_DTABAL').DisplayLabel := 'Data Balanço';
    FieldByName('ITE_DTAULT').DisplayLabel := 'Data Últ. Compra';
    FieldByName('ITE_DTAUVE').DisplayLabel := 'Data Últ. Venda';
    FieldByName('ITE_DESADB').DisplayLabel := fCfgSis('DESADI');
    FieldByName('ITE_IMPULT').DisplayLabel := 'Preço de Última Compra + Imp';
    FieldByName('AUTOINCREM').Visible := False;
  End;

end;

function fTamPrecoIteger: Integer;
begin
  If VS_intTamPrecoIteger = 0 Then
    VS_intTamPrecoIteger := fObterQtdeCasasDecimaisCampo('ITEGER','ITE_PREVE1');

  Result := VS_intTamPrecoIteger;
end;

{*******************************************************}
{* TAMANHO MAXIMO DE CARACTERES P/ CAMPO DE QUANTIDADE  *}
{* DO AJUSTE DE ESTOQUE, DERIVADO DA PRECISAO REAL DE   *}
{* MOVDET.DET_QTDITE (SEM HARDCODE) - Req. 457063       *}
{*******************************************************}
function fTamCampoQtdAjuste: Integer;
begin
  If VS_intTamCampoQtdAjuste = 0 Then
    VS_intTamCampoQtdAjuste := fObterPrecisaoCampo('MOVDET','DET_QTDITE') + 2;

  Result := VS_intTamCampoQtdAjuste;
end;

function fTamPrecoItepro: Integer;
begin
  If VS_intTamPrecoItepro = 0 Then
    VS_intTamPrecoItepro := fObterQtdeCasasDecimaisCampo('ITEPRO','IPR_PREVEN');

  Result := VS_intTamPrecoItepro;
end;

function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;
Var
  qrySQL: TUniQuery;
  strTipoCmp: String;
begin
  qrySQL := fCriaQuery;
  Result := 0;
  Try
    qrySQL.SQL.Add('DESC ' + strTabela);
    qrySQL.Open;
    While Not qrySql.Eof Do
    Begin
      If qrySQL.FieldByName('Field').AsString = strCampo Then
      Begin
        strTipoCmp := qrySQL.FieldByName('Type').AsString;
        If UpperCase(LeftStr(strTipoCmp, 8)) = 'DECIMAL(' Then
        Begin
          Result := StrToIntDef(strTipoCmp[Pos(',', strTipoCmp)+1], 0);
        End;
        Break;
      End;
      qrySQL.Next;
    End;
  Finally
    FreeAndNil(qrySQL);
  End;
End;

{***********************************************}
{* IGUAL A fObterQtdeCasasDecimaisCampo, MAS   *}
{* RETORNA A PRECISAO TOTAL (DIGITOS) DE UM    *}
{* CAMPO DECIMAL(P,S) - Req. 457063            *}
{***********************************************}
function fObterPrecisaoCampo(strTabela, strCampo: String): Integer;
Var
  qrySQL: TUniQuery;
  strTipoCmp: String;
  posfin: integer;
  posInit: integer;
begin
  qrySQL := fCriaQuery;
  Result := 0;
  Try
    qrySQL.SQL.Add('DESC ' + strTabela);
    qrySQL.Open;
    While Not qrySql.Eof Do
    Begin
      If qrySQL.FieldByName('Field').AsString = strCampo Then
      Begin
        strTipoCmp := qrySQL.FieldByName('Type').AsString;
        If UpperCase(LeftStr(strTipoCmp, 8)) = 'DECIMAL(' Then
        Begin
          posInit := Pos('(', strTipoCmp) + 1;
          posfin  := Pos(',', strTipoCmp);
          Result  := StrToIntDef(copy(strTipoCmp, posInit, posfin - posInit), 0);
        End;
        Break;
      End;
      qrySQL.Next;
    End;
  Finally
    FreeAndNil(qrySQL);
  End;
End;

function fVerificarSeEhNotaImportacao(strAutIncGERELE: String; blnValidaNotaAcompanhamento: Boolean = False): Boolean;
var
  qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(1) AS QTD FROM DETELE ');
    qryAux.SQL.Add('  WHERE DET_SEQGER = :AUTINC  ');
    qryAux.SQL.Add('    AND LEFT(I08_CFOP,1) = "3" ');

    if blnValidaNotaAcompanhamento Then
      qryAux.SQL.Add('    AND I08_CFOP = "3949" ');

    qryAux.ParamByName('AUTINC').AsString := strAutIncGERELE;

    qryAux.Open;

    Result := (qryAux.FieldByName('QTD').asInteger > 0);
  finally
    FreeAndNil(qryAux);
  end;
End;

class procedure TLimparCaches.Execute;
begin
  dicConfiguracoes.Clear;
  FCacheMyCampoTabela.Clear;
  TDicResultadoQuerySimples.Limpar;
  If Assigned(dicDirAceAutTin) Then
    FreeAndNil(dicDirAceAutTin);
  TPermissoesAcesso.GetInstance.pLimpar;
  TControllerFaturamentoInterfacesCache.ClearCache;
end;

function fCadIte(ACodIte: string): IMyCampoTabela;
begin
  Result := fCampoTabelaArray(
              [
               'ITE_DESFAB', 'ITE_DESITE', 'ITE_NOTESP', 'ITE_APLICA', 'UNI_ITEFRA',
               'ITE_INFLAM', 'ITE_PRDGRU', 'ITE_USABON', 'ITE_CODUNI', 'UNI_SIGUNI',
               'ITE_CODMAR', 'ITE_CODGRU', 'MAR_DESMAR', 'ITE_OBRIBA', 'ITE_ATICOM',
               'ITE_INDREV', 'ITE_CODABF', 'ITE_PROEMB', 'ITE_GRAMAR', 'ITE_CNV_ML',
               'ITE_EMPCAR', 'ITE_CODFOR', 'ITE_IMPDIR', 'ITE_ITECCR', 'ITE_UTIAMP',
               'ITE_CODPAG', 'ITE_CODCOR', 'ITE_CEREPI', 'ITE_MSGLV1', 'ITE_MSGLV2',
               'IF(UNI_KILLIT = "L" OR UNI_KILLIT = "", UNI_PESLIT, 0) AS UNI_LITRAG',
               'ITE_EXISIM', 'ITE_MLTVEN', 'ITE_CAREST', 'ITE_PERVDA'
              ],
               'CADITE ' +
               'LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ' +
               'LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ',
              ['ITE_CODITE'], [ACodIte], False);
end;

function fIteGer(ACodIte, ACodEmp: string): IMyCampoTabela;
begin
  Result := fCampoTabelaArray(
              [
               'ITE_DTAVAL', 'ITE_INDREV', 'ITE_TIPPRO', 'ITE_CODABF', 'ITE_IMPDIR', 'ITE_IPIENT', 'ITE_PREDOL',
               'ITE_PRECUS', 'ITE_ICMSAI', 'ITE_PRAMIN', 'ITE_PREULT', 'ITE_RECDEV', 'ITE_OUTVAL', 'ITE_IMPLIS',
               'ITE_COMTB1', 'ITE_COMTB2', 'ITE_COMTB3', 'ITE_COMTB4', 'ITE_COMTB5', 'ITE_COMTB6', 'ITE_COMTB7',
               'ITE_MARBR1', 'ITE_MARBR2', 'ITE_MARBR3', 'ITE_MARBR4', 'ITE_MARBR5', 'ITE_MARBR6', 'ITE_MARBR7',
               'ITE_MARID1', 'ITE_MARID2', 'ITE_MARID3', 'ITE_MARID4', 'ITE_MARID5', 'ITE_MARID6', 'ITE_MARID7',
               'ITE_PREVE1', 'ITE_PREVE2', 'ITE_PREVE3', 'ITE_PREVE4', 'ITE_PREVE5', 'ITE_PREVE6', 'ITE_PREVE7',
               'ITE_PEVNDA'
              ],
               'ITEGER',
              ['ITE_CODITE','ITE_CODEMP'],[ACodIte,ACodEmp], False);
end;

function fItemRevInd(strCodIte, strCodEmp: String): String;
  Var
    LIndustrializacaoRevendaCADITE : String;
    LIndustrializacaoRevendaITEGER : String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  LIndustrializacaoRevendaCADITE := fCadIte(strCodIte).FieldByName('ITE_INDREV').AsString;
  LIndustrializacaoRevendaITEGER := fIteGer(strCodIte, strCodEmp).FieldByName('ITE_INDREV').AsString;

  Result := TFunctionFuncoesFaturamento.fItemRevInd(LIndustrializacaoRevendaCADITE, LIndustrializacaoRevendaITEGER);
end;

function fItemEstrutura(strCodIte: String): Boolean;
Var
  LCount : Integer;
Begin

  Result := False;

  If fEmptyStr(strCodIte) Then
    Exit;

  LCount := fCampoTabela('COUNT(*)', 'GERMAT', ['GMT_CODITE'], [strCodIte], False);

  Result := TFunctionFuncoesFaturamento.fItemEstrutura(LCount);

End;

function fDentroDoEstado(strCliEst: String; strCodEmp: String): Boolean;
Var
  LClienteEstadoBD : String;
Begin

  LClienteEstadoBD :=
    fCampoTabela('CID_ESTADO', 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID',
      ['EMP_CODEMP'], [IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp)], False);

  Result := TFunctionFuncoesFaturamento.fDentroDoEstado(strCliEst, LClienteEstadoBD);
End;

function fRetornaGrupoItem(strCodIte: String): String;
begin
  Result := fCadIte(strCodIte).FieldByName('ITE_CODGRU').AsString;
end;

function fRetMarcaItem(strCodIte: String): String;
Begin
  Result := fCadIte(strCodIte).FieldByName('ITE_CODMAR').AsString;
End;

function fRetCodFornecedor(strCodIte: String): String;
Begin
  Result := fCadIte(strCodIte).FieldByName('ITE_CODFOR').AsString;
End;

function fGetCodAbf(strCodIte: String; strCodEmp: String = ''): String;
Var
  LCodigoAbreviacaoTodasEmpresas : String;
  LCodigoAbreviacaoPorEmpresas : String;
begin

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  LCodigoAbreviacaoTodasEmpresas := fCadIte(strCodIte).FieldByName('ITE_CODABF').AsString;
  LCodigoAbreviacaoPorEmpresas   := fIteGer(strCodIte, strCodEmp).FieldByName('ITE_CODABF').AsString;

  Result :=
    TFunctionFuncoesFaturamento.
      fGetCodAbf(LCodigoAbreviacaoTodasEmpresas,
                 LCodigoAbreviacaoPorEmpresas,
                 strCodEmp);

end;

function fRetImportacaoDiretaItem(strItem: String; strCodEmp: string = ''): String;
begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;
  If fCfgSis('IMPDIG', varString, strCodEmp) = '1' Then
    Result := fCadIte(strItem).FieldByName('ITE_IMPDIR').AsString
  Else
    Result := fIteGer(strItem, strCodEmp).FieldByName('ITE_IMPDIR').AsString;
end;

function fAplicarTaxaJurosPrecoSugestao: Boolean;
begin
  Result := (fCfgSis('CNDVEN') = 'I');
  If (VS_strTxjCni = 'S') Then
    Result := Result And (fCfgSis('TXJCNI') = '1');
end;

function fAplicarTaxaJurosPrecoDigitado: Boolean;
begin
  Result := False;
  If (VS_strTxjCni = 'S') Then
    Result := (fCfgSis('CNDVEN') = 'I') And (fCfgSis('TXJCNI') = '2');
end;

function fAlqIcmEstEmp(strCodAbfIte, strCodEmpIte: String): Double;
var
  strSQL: String;

  LDesmembrarSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  strSQL := TFunctionFuncoesFaturamento.GetSelectAlqIcmEstEmp;

  LDesmembrarSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(strSQL);

  Result := fCampoTabelaArray(LDesmembrarSelectParaCampoTabela.CamposSelect,
                              LDesmembrarSelectParaCampoTabela.NomeTabela,
                              LDesmembrarSelectParaCampoTabela.CampoChave,
                              [strCodAbfIte, fRetUFEmpresa(strCodEmpIte)],
                              False).Fields(0);
end;

function fRetNomVendedor(strCodVen: String): String;
Begin
  Result := untFuncoesGenerica.fRetNomVendedor(strCodVen, String.Empty, String.Empty);
End;

function fRetNomVendedor(strCodVen, strCodEmp: String): String;
begin
  Result := untFuncoesGenerica.fRetNomVendedor(strCodVen, strCodEmp, String.Empty);
end;

function fRetNomVendedor(strCodVen, strCodEmp, strCodCli: string): String;
var
  arrCamposChave: array of string;
  arrCamposValores: array of variant;
  intTamanhoVetorParametros: integer;
  strNomeTabela: string;

const
  strNOME_CAMPO_RETORNO = 'OPE_NOMOPE';

  procedure pIncrementaVetorParametros;
  begin
    inc(intTamanhoVetorParametros);
    SetLength(arrCamposChave, intTamanhoVetorParametros);
    SetLength(arrCamposValores, intTamanhoVetorParametros);
  end;

  procedure pAtribuiParametro(const strCampoChave, strCampoValor: string);
  begin
    if strCampoValor.IsEmpty then
      exit;
    pIncrementaVetorParametros;
    arrCamposChave[high(arrCamposChave)] := strCampoChave;
    arrCamposValores[high(arrCamposValores)] := strCampoValor;
  end;

  procedure pAtribuiParametroVendedor;
  const
    str_CAMPO_CHAVE = 'OPE_CODOPE';
  begin
    pAtribuiParametro(str_CAMPO_CHAVE, strCodVen);
  end;

  procedure pAtribuiParametroEmpresa;
  const
    str_CAMPO_CHAVE = 'OPE_CODEMP';
  begin
    if strCodEmp.IsEmpty then
      exit;
    pAtribuiParametro(str_CAMPO_CHAVE, strCodEmp);
  end;

  procedure pAtribuiParametroCliente;
  const
    str_CAMPO_CHAVE = 'CVE_CODCLI';
  begin
    pAtribuiParametro(str_CAMPO_CHAVE, strCodCli);
    if strCodCli.IsEmpty then
      exit;
    strNomeTabela := 'CADOPE JOIN CLIVEN ON OPE_CODOPE = CVE_CODVEN';
  end;

Begin
  strNomeTabela := 'CADOPE';
  intTamanhoVetorParametros := 0;

  pAtribuiParametroVendedor;
  pAtribuiParametroEmpresa;
  pAtribuiParametroCliente;

  If (Length(arrCamposChave) > 0) Then
  Begin
    Result := fCampoTabela(strNOME_CAMPO_RETORNO,
                           strNomeTabela,
                           arrCamposChave,
                           arrCamposValores,
                           False);
  End;
End;

function fGetTipoAbreviacaoFornecedor(const strCodFor: String): String;
  Var strTipFor: String;
Begin
  Result := untFuncoesGenerica.fGetTipoAbreviacaoFornecedor(strCodFor, strTipFor);
End;

function fGetTipoAbreviacaoFornecedor(const strCodFor: String; Var strTipFor: String): String;
  Var
    qryFornecedor :TUniQuery;
    objDados      :IMyCampoTabela;
begin

  Result := '';

  If fEmptyStr(strCodFor) Then
    Exit(fGetTipoAbf('F', '', '', '', '', '', '', '', '', '', ''));

  qryFornecedor := fCriaQuery;

  Try
    With qryFornecedor, SQL Do
    Begin
      qryFornecedor.SQL.Text := TFunctionFuncoesFaturamento.fGetSelectTipoAbfFornecedor;
      ParamByName('CODFOR').AsString := strCodFor;

      objDados := ExecutarQueryEmCache(qryFornecedor);


      strTipFor := objDados.FieldByName('TIPFOR').AsString;

      Result :=
        TFunctionFuncoesFaturamento.
          fGetTipoAbf('F',
                      objDados.FieldByName('FISJUR').AsString,
                      objDados.FieldByName('I_E_S_').AsString,
                      '',
                      '',
                      '',
                      '',
                      objDados.FieldByName('SIMPAU').AsString,
                      objDados.FieldByName('TIPFOR').AsString,
                      '',
                      '',
                      False);

    End;

  Finally
    FreeAndNil(qryFornecedor);
  End;

end;

function fGetPercentualRessarcimentoCAT(strCodAbf, strEstFor: String): Double;
begin
  Result := fCampoTabela('CAT_RESTOT', 'RESCAT', ['CAT_CODABF', 'CAT_ESTADO'], [strCodAbf, strEstFor], False);
end;

function fGetPercentualRessarcimentoCATIPIEnt(strCodIte, strCodEmp, strCodAbf, strEstFor: String): Double;
var
  fltIpiEnt: Double;
  fltBasRet: Double;
  fltValRet: Double;
  qryConsulta: TUniQuery;
begin
  fltIpiEnt := fIteGer(strCodIte, strCodEmp).FieldByName('ITE_IPIENT').AsFloat;

  qryConsulta := fCriaQuery();
  try
    qryConsulta.SQL.Add('SELECT ');
    qryConsulta.SQL.Add('  CAT_BASRET, CAT_ALQRET, CAT_IVA_ST, CAT_RESICM, CAT_CODSIT, CAT_RESICM');
    qryConsulta.SQL.Add('FROM RESCAT');
    qryConsulta.SQL.Add('WHERE CAT_CODABF = :CODABF');
    qryConsulta.SQL.Add('  AND CAT_ESTADO = :ESTADO');
    qryConsulta.ParamByName('CODABF').AsString := strCodAbf;
    qryConsulta.ParamByName('ESTADO').AsString := strEstFor;
    qryConsulta.Open;

    fltBasRet := qryConsulta.FieldByName('CAT_BASRET').AsFloat + fltIpiEnt;

    fltValRet := fltBasRet *
                 qryConsulta.FieldByName('CAT_ALQRET').AsFloat *
                 qryConsulta.FieldByName('CAT_IVA_ST').AsFloat / 100 - qryConsulta.FieldByName('CAT_RESICM').AsFloat;

    If fltValRet <= 0 Then
      fltValRet := 0.00;

    If (Not CST_SUBSTITUICAO.Contains(qryConsulta.FieldByName('CAT_CODSIT').AsString)) Then
      fltValRet := 0.00;

    Result := qryConsulta.FieldByName('CAT_RESICM').AsFloat + fltValRet;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function fGetPercentualDescontoCAT(strCodAbf, strEstFor, strTabPre: String): Double;
begin
  Result := 0;
  If strTabPre <> '' Then
    If CharInSet(strTabPre[1], ['1'..'7']) Then
      Result := fCampoTabela('CAT_DESCT' + strTabPre, 'RESCAT',
        ['CAT_CODABF', 'CAT_ESTADO'], [strCodAbf, strEstFor], False);
end;

procedure pRetDadosAbfFornecedor(strCodAbf, strCodFor, strEstFor: String;
  Var fltAlqIcm, fltAlqRet, fltValIva, fltPerBas, fltPeBaST: Double;
  Var strCodSit: String);
  Var
    strTipAbf: String;
  objDadosAbf: IMyCampoTabela;
begin
  objDadosAbf := fGetDadosAbf(strCodAbf, strEstFor);

  strTipAbf := untFuncoesGenerica.fGetTipoAbreviacaoFornecedor(strCodFor);

  strCodSit := objDadosAbf.FieldByName('ABF_CODSIT' + strTipAbf);
  fltValIva := objDadosAbf.FieldByName('ABF_IVA_ST' + strTipAbf);
  fltAlqIcm := objDadosAbf.FieldByName('ABF_ALQICM' + strTipAbf);
  fltAlqRet := objDadosAbf.FieldByName('ABF_ALQRET' + strTipAbf);
  fltPerBas := objDadosAbf.FieldByName('ABF_BASICM' + strTipAbf);
  fltPeBaST := objDadosAbf.FieldByName('ABF_BASRET' + strTipAbf);
end;

function fEstadoFornecedor(strCodFor: String): String;
  Var
    strCodCid: String;
    strEstado: String;
begin
  strCodCid := fCampoTabela('FOR_CODCID', 'CADFOR', ['FOR_CODFOR'], [strCodFor], False);
  strEstado := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodCid], False);

  If fEmptyStr(strEstado) Then
    Result := fRetUFEmpresa
  Else
    Result := strEstado;
end;

function fRetornaIesUni(strCodCli: String): String;
var
  strIesUni : String;
begin
  strIesUni := fCampoTabela('CLI_IESUNI','CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  Result := TFunctionFuncoesFaturamento.fRetornaIesUni(strIesUni);
end;

function fEhProdutorRural(strCodCli: String): Boolean;  // FuncFat
Var
  strProRur : String;
begin
  strProRur := fCampoTabela('IFNULL(CLI_PRORUR, "N")','CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  Result := TFunctionFuncoesFaturamento.fEhProdutorRural(strProRur);
end;

function fCalculaCustoReal(fltPreCus, fltIcmSai, fltImpFed, fltDesOpe, fltOutVal: Double): Double;
Begin
  Result :=
    TControllerFaturamentoPrecoCusto.New
      .CalculaCustoReal(
        TParametrosCalculoCustoReal.New
          .PrecoDeCusto(fltPreCus)
          .IcmsDeSaida(fltIcmSai)
          .ImpostosFederais(fltImpFed)
          .DespesasOperacionais(fltDesOpe)
          .OutrosValores(fltOutVal)
      );
End;

Function fCalcMediaPagto(strConPag:String): Double;
  Var
    intContador1 : Integer;
    intContador2 : Integer;
    intQtdPagto  : Integer;
Begin
  Try
    Result       := 0;
    intQtdPagto  := StrToIntDef(LeftStr(strConPag, 02), 0);
    intContador2 := 3;

    For intContador1 := 1 To intQtdPagto Do
    Begin
      Result       := Result + StrToIntDef(Copy(strConPag, intContador2, 03), 0);
      intContador2 := intContador2 + 3;
    End;

    If (intQtdPagto = 0) Then
      Result := 0
    Else
      Result := (Result / intQtdPagto);
  Except
    Result := 0;
  End;
End;

function fPermiteInformarEmpresaNoItemOpc(const strOpcDoc: String): Boolean;
Begin
  Result := True;

  If (strOpcDoc = 'OR') And (fCfgSis('EMPFAT', varString) = 'S') Then
    Exit;

  If (strOpcDoc = 'PD') And (fCfgSis('EMPFAT', varString) = 'S') Then
    Exit;

  If (strOpcDoc = 'VN') And (fCfgSis('EMPFVN', varString) = 'S') Then
    Exit;

  Result := False;
End;

function fRetCodIbamaCliente(Const strCodCli: String): String;
begin
  Result := fCampoTabela('CLI_CODIBA', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
end;

function fRetornaDadosTransportadora(strCodTra: String): TrecDadosTransportadora;
  Var
    qryCadTra : TUniQuery;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fEmptyStr(strCodTra) Then
    Exit;

  qryCadTra := fCriaQuery;
  Try
    With qryCadTra Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT TRA_CODTRA, TRA_NOMTRA, CID_NOMCID, CID_ESTADO, ');
      SQL.Add('        TRA_FONE01, TRA_C_G_C_, TRA_I_E_S_, TRA_ENDERE, ');
      SQL.Add('        TRA_BAIRRO, TRA_C_E_P_ ');
      SQL.Add('   FROM CADTRA ');
      SQL.Add('   LEFT JOIN CADCID ON CID_CODCID = TRA_CODCID ');
      SQL.Add('  WHERE TRA_CODTRA = :CODTRA ');
      ParamByName('CODTRA').AsString := strCodTra;
      Open;

      If (Not IsEmpty) Then
      Begin
        Result.strCodTra := FieldByName('TRA_CODTRA').AsString;
        Result.strNomTra := FieldByName('TRA_NOMTRA').AsString;
        Result.strCidTra := FieldByName('CID_NOMCID').AsString;
        Result.strEstTra := FieldByName('CID_ESTADO').AsString;
        Result.strFone01 := FieldByName('TRA_FONE01').AsString;
        Result.strCnpTra := FieldByName('TRA_C_G_C_').AsString;
        Result.strIesTra := FieldByName('TRA_I_E_S_').AsString;
        Result.strEndere := FieldByName('TRA_ENDERE').AsString;
        Result.strBairro := FieldByName('TRA_BAIRRO').AsString;
        Result.strCepTra := FieldByName('TRA_C_E_P_').AsString;
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryCadTra);
  End;
end;

procedure pGravarICMSUFDest(strAutInc, strTabela: String; fltBaseUfDestino, fltPercentualFCP,
  fltAlqUfDestino, fltAlqInterestadual, fltPercentualPartilha, fltValorFCP,
  fltValorIcmsDifalDestino, fltValorIcmsDifalOrigem, fltBaseFCP: Double; strFcpProprio: String = '');
  Var
    qryIns: TUniQuery;
begin

  qryIns := fCriaQuery;
  Try
    qryIns.SQL.Add('INSERT INTO ' + strTabela + '(');
    If Pos('DORICD', strTabela) > 0 Then
      qryIns.SQL.Add('  ICD_SEQFDO, ')
    Else
      qryIns.SQL.Add('  ICD_SEQGER, ');
    qryIns.SQL.Add('  ICD_BCUFDE, ');
    qryIns.SQL.Add('  ICD_PERFCP, ');
    qryIns.SQL.Add('  ICD_ALQUFD, ');
    qryIns.SQL.Add('  ICD_ALQINE, ');
    qryIns.SQL.Add('  ICD_PERPAR, ');
    qryIns.SQL.Add('  ICD_VALFCP, ');
    qryIns.SQL.Add('  ICD_VALDES, ');
    qryIns.SQL.Add('  ICD_BASFCP, ');
    qryIns.SQL.Add('  ICD_VALORI, ');
    qryIns.SQL.Add('  ICD_FCPPRO ) VALUES ( ');
    qryIns.SQL.Add('  :AUTINC, ');
    qryIns.SQL.Add('  :BCUFDE, ');
    qryIns.SQL.Add('  :PERFCP, ');
    qryIns.SQL.Add('  :ALQUFD, ');
    qryIns.SQL.Add('  :ALQINE, ');
    qryIns.SQL.Add('  :PERPAR, ');
    qryIns.SQL.Add('  :VALFCP, ');
    qryIns.SQL.Add('  :VALDES, ');
    qryIns.SQL.Add('  :BASFCP, ');
    qryIns.SQL.Add('  :VALORI, ');
    qryIns.SQL.Add('  :FCPPRO) ');

    qryIns.ParamByName('AUTINC').AsString := strAutInc;
    qryIns.ParamByName('BCUFDE').AsFloat  := fltBaseUfDestino;
    qryIns.ParamByName('PERFCP').AsFloat  := fltPercentualFCP;
    qryIns.ParamByName('ALQUFD').AsFloat  := fltAlqUfDestino;
    qryIns.ParamByName('ALQINE').AsFloat  := fltAlqInterestadual;
    qryIns.ParamByName('PERPAR').AsFloat  := fltPercentualPartilha;
    qryIns.ParamByName('VALFCP').AsFloat  := fltValorFCP;
    qryIns.ParamByName('VALDES').AsFloat  := fltValorIcmsDifalDestino;
    qryIns.ParamByName('BASFCP').AsFloat  := fltBaseFCP;
    qryIns.ParamByName('VALORI').AsFloat  := fltValorIcmsDifalOrigem;
    qryIns.ParamByName('FCPPRO').AsString := strFcpProprio;

    qryIns.ExecSQL;
  Finally
    FreeAndNil(qryIns);
  End;

end;

function fRetornaValCom(fltValCom: Double): Double;
Begin
  Result := untCalculoPrecoVenda.fRetornaValCom(fltValCom);
End;

function fUsaImpostoFonteIBPT: Boolean;
Begin
  Result := fCfgSis('IMPPAG', VarInteger) = 2;
End;

function fPermiteBrindeComValorZero: Boolean;
begin
  Result := (fCfgSis('ZERBRI', varString) = '1');
end;

function fRetComplementoStrClaDevBrinde(strOpcDoc: String): String;
begin
  Result := '';
  If (fCfgSis('VENBRI', varBoolean) Or fCfgSis('DVBRAD', varBoolean)) Then
    Result := IIF((Pos(strOpcDoc, 'DV_PR_') > 0), '_1949_2949_', '');
end;

function fCalculaValorIss(fltBasIss, fltAlqIss: Double): Double;
begin
  Result := (fltBasIss / 100) * fltAlqIss;
end;

function fUsaRateioDeServicos: Boolean;
begin
  Result := (fCfgSis('USRASE',varBoolean))      And
            (fCfgSis('AUTCEN',varBoolean))      And
            (fCfgSis('ACOSER',varString) = '1') And
            (Not fCfgSis('BTDISE',varBoolean))  And
            (Not fCfgSis('USAPAR',varBoolean));
end;

function fItemConcreto(const strCodIte: String; strEmpIte: String = ''): Boolean;
Var
  LProdutoConcreto : String;
  LEhItemEstrutura : Boolean;
begin

  LEhItemEstrutura := fItemEstrutura(strCodIte);
  LProdutoConcreto := fCadIte(strCodIte).FieldByName('ITE_ITECCR').AsString;

  Result := TFunctionFuncoesFaturamento.fItemConcreto(LEhItemEstrutura, strEmpIte, LProdutoConcreto);
end;

function fVendaProducao(strOpcDoc, strClaFis: String): Boolean;
begin
  Result := (fCfgSis('CONIPI', varBoolean)) And (Pos(strOpcDoc, 'VN_OR_PD_CP_') > 0) And (Pos(strClaFis, fCfgSis('CFOIND')) > 0);
end;

function fItemAmpara(strCodIte: String): Boolean;
var
  LItemUtilizaAmpara: String;
begin
  LItemUtilizaAmpara := fCadIte(strCodIte).FieldByName('ITE_UTIAMP').AsString;

  Result := TFunctionFuncoesFaturamento.ItemAmpara(LItemUtilizaAmpara);
end;

function fRetornaAliquotaDeIcmsInterestadual(strOrigem, strDestino: String): Double;
Begin
  Result := fCampoTabela('ICM_ALQICM', 'ICMALQ', ['ICM_UF_ORI','ICM_UF_DES'], [strOrigem, strDestino], False);
End;

function fEmpresaZeraIcmsTE(strEmpOri, strCliFil: String): Boolean;
  Var
    qryDoc : TUniQuery;
begin
  qryDoc := fCriaQuery(Nil);
  With qryDoc, SQL Do
  Begin
    Add('SELECT SQL_NO_CACHE');
    Add('  CON_ZERICM AS ZERICM');
    Add('FROM');
    Add('  CADEMP');
    Add('  INNER JOIN CONEMP ON CON_EMPORI = :EMPORI AND');
    Add('                       CON_EMPDES = EMP_CODEMP ');
    Add('WHERE');
    Add('  EMP_CLIFIL = :CLIFIL');

    ParamByName('EMPORI').AsString := strEmpOri;
    ParamByName('CLIFIL').AsString := strCliFil;

    Open;

    Result := FieldByName('ZERICM').AsString = 'S';

    Close;
  End;
  FreeAndNil(qryDoc);
end;

function fMultiplicadorReducaoRICMS(fltValor: Double): Double;
begin
  Result := ((100-IfFloatZero(fltValor, CONST_PERCENTUAL_DIFERIMENTO_RICMS)) / 100);
end;

Procedure pRetImpostosItem(    strCodIte: String;
                           Var fltIcmSai,
                               fltOutVal,
                               fltDesOpe,
                               fltImpFed: Double;
                               cdsIteGer: TUniClientDataSet = Nil;
                               strTabPre: String = '-1';
                               strCodEmp: String = '');
var
  qryGen       : TUniQuery;
  strSQL       : String;
  strTabUti    : String;
  dtsIteger    : TDataSet;
  strEmpresa   : String;
  LCampos      : IMyCampoTabela;
Begin

  qryGen := Nil;

  strEmpresa := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

  strSQL := fSqlCdsIteger(strTabPre, strTabUti);

  If (Not Assigned(cdsIteGer)) Or
     (Not cdsIteGer.Locate('ITE_CODITE;ITE_CODEMP;ITE_TABELA', VarArrayOf([strCodIte, strEmpresa, strTabUti]), [])) Then
  Begin

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strEmpresa;
      LCampos := ExecutarQueryEmCache(qryGen);

      If Assigned(cdsIteger) Then
        pIncluiIteger(cdsIteger, LCampos);
    End;
  End;

  If Assigned(cdsIteger) Then
  Begin
    dtsIteger := cdsIteger;
  End
  Else
  Begin
    If (Not qryGen.Active) Then
      qryGen.Open;

    dtsIteger := qryGen;
  End;

  With dtsIteger Do
  Begin
    If IsEmpty Then
    Begin
      fltIcmSai := 0;
      fltOutVal := 0;
      fltDesOpe := 0;
      fltImpFed := 0;
    End Else
    Begin
      fltIcmSai := FieldByName('ITE_ICMSAI').AsFloat;
      fltOutVal := FieldByName('ITE_OUTVAL').AsFloat;
      fltDesOpe := FieldByName('ITE_DESOPE').AsFloat;
      fltImpFed := FieldByName('ITE_IMPFED').AsFloat;
    End;
  End;

  If Assigned(qryGen) Then
    FreeAndNil(qryGen);
End;

function fItemUtilizaPrecoEmDolar(strItem: String): Boolean;
begin
  Result := fIteGer(strItem, VS_strCodEmp).FieldByName('ITE_PREDOL').AsString = 'S';
end;

function fClientePessoaFisica(strCodCli: String): Boolean;
  Var
    qryCli: TUniQuery;
begin
  qryCli := fCriaQuery;
  Try
    With qryCli, SQL Do
    Begin
      Add('SELECT');
      Add('  IFNULL(CLI_CGCCPF, 2)');
      Add('FROM');
      Add('  CADCLI');
      Add('WHERE');
      Add('  CLI_CODCLI = :CODCLI');
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      Result := Fields[0].AsInteger = 2;
    End;
  Finally
    FreeAndNil(qryCli);
  End;
End;

function fRetAliquotaIssCidade(strCodCid: String): Double;
begin
  Result := fCampoTabela('CID_ALQISS', 'CADCID', ['CID_CODCID'], [strCodCid]);
end;

function fRetReducaoBaseIssCidade(strCodCid: String): Double;
  Var
    qryGen: TUniQuery;
begin

  Result := 0;

  If fTabelaExiste('CADRBC', True) Then
  Begin
    Try
      qryGen := fCriaQuery;
      qryGen.SQL.Add('SELECT CADRBC.CID_REDISS ');
      qryGen.SQL.Add('  FROM CADRBC ');
      qryGen.SQL.Add(' WHERE CADRBC.CID_CODCID = :CODCID ');
      qryGen.SQL.Add('   AND CADRBC.CID_CODEMP = :CODEMP ');
      qryGen.ParamByName('CODCID').asString := strCodCid;
      qryGen.ParamByName('CODEMP').asString := VS_strCodEmp;
      qryGen.Open;

      If Not qryGen.isEmpty Then
        Result := qryGen.FieldByName('CID_REDISS').asFloat;

      qryGen.Close;
    Finally
      FreeAndNil(qryGen);
    End;
  End
  Else
    Result := fCampoTabela('CID_REDISS', 'CADCID', ['CID_CODCID'], [strCodCid]);

end;

function fRetComissaoTabelaItem(strItem, strTabPre: String): Double;
begin
  Result := fIteGer(strItem, VS_strCodEmp).FieldByName('ITE_COMTB' + strTabPre).AsFloat;
end;

function fEhClienteFilialEmpLogada(strCodCli: String): Boolean;
Var
  LClienteFilial : String;
begin
  LClienteFilial := fRetornaClienteFilial(VS_strCodEmp);
  Result :=
    TFunctionFuncoesFaturamento.
      fClientSelectEhClientFilialEmpLogada(strCodCli, LClienteFilial);
end;

function fTemQuantEmbalagemFechada(strCodIte: String): Boolean;
begin
  Result := fCampoTabela('COUNT(ITB_QTDEMB)', 'ITEEMB',
                        ['ITB_CODITE', 'ITB_CODEMP'],
                        [strCodIte, VS_strCodEmp], False) > 0;
end;

function fPercDescEmbalagemFechadaItem(strCodIte, strTabPreco: String; fltQtdIte : Double; strCodBarEmb: string ): Double;
  Var
    fltQtdEmb : Double;
    strQtdEmb : String;
    intDecQtd : Integer;
begin
  Result := 0.00;
  fltQtdEmb := fQuantEmbalagemFechadaItem(strCodIte, strTabPreco, fltQtdIte);
  If fltQtdEmb > 0 Then
  Begin
    intDecQtd := fCfgSis('DECQTD', varInteger);
    strQtdEmb := FormatFloat(fMskDigitos(intDecQtd), fltQtdEmb);
    strQtdEmb := StringReplace(strQtdEmb,'.','',[rfReplaceAll]);
    strQtdEmb := StringReplace(strQtdEmb,',','.',[rfReplaceAll]);
    Result := fCampoTabela('ITB_DESCON', 'ITEEMB',
                          ['ITB_CODITE', 'ITB_CODEMP', 'IF(IFNULL(ITB_TABPRE,"") = "", "' + strTabPreco + '", ITB_TABPRE)', 'ITB_QTDEMB'],
                          [strCodIte, VS_strCodEmp, strTabPreco, strQtdEmb], False);
  End;

  If (Result > 0) And (Not fEmptyStr(strCodBarEmb)) And (fCfgSis('PREEMB', VarInteger) = 1) Then //PREEMB PREÇO DEFINIDO NO CÓDIGO DE BARRAS DO CADASTRO DE PRODUTOS
  Begin
    If fRetornaPrecoCodBarraEmb( strCodIte,
                                 strCodBarEmb,
                                 VS_strCodEmp,
                                 strTabPreco, False ) > 0 Then
    Begin
      Result := 0.00; //VIDE CONCLUSÃO REQ.: 106211
    End;
  End;
end;

function fRetornaPrecoCodBarraEmb(strCodIte, strCodBar, strCodEmp, strTabPre: String;
  blnPegaPrecoEmb: Boolean): Double;
  Var
    intPreEmb: Integer;
    strTabEmb: String;
begin
  If blnPegaPrecoEmb Then
    Result := fCampoTabela('BAR_PREVEN', 'ITEBAR', ['BAR_CODITE', 'BAR_CODBAR'], [strCodIte, strCodBar], False)
  Else
  Begin
    If fEmptyStr(strTabPre) Then
      strTabPre := '1';

    intPreEmb := fCfgSis('PREEMB', VarInteger);

    If intPreEmb = 1 Then
      Result := fCampoTabela('BAR_PREVEN', 'ITEBAR', ['BAR_CODITE', 'BAR_CODBAR'], [strCodIte, strCodBar], False)
    Else
    Begin
      strTabEmb := fRetornaTabPreCodBarraEmb(strCodIte, strCodBar);

      If SameText(strTabEmb, 'F') Or fEmptyStr(strTabEmb) Then
        Result := fIteGer(strCodIte, VS_strCodEmp).FieldByName('ITE_PREVE' + strTabPre).AsFloat
      Else
        Result := fIteGer(strCodIte, VS_strCodEmp).FieldByName('ITE_PREVE' + strTabEmb).AsFloat;
    End;
  End;
end;

function fRetornaTabPreCodBarraEmb(strCodIte, strCodBar: String): String;
begin

  Result := '';

  If fEmptyStr(strCodIte) Then
    Exit;

  Result := fCampoTabela('BAR_TABPRE', 'ITEBAR', ['BAR_CODITE', 'BAR_CODBAR'], [strCodIte, strCodBar], False);

end;

Function fRetCustoServico(strCodSer: String): Double;
begin

  Result := 0;

  If fEmptyStr(strCodSer) Then
    Exit;

  Result := fCampoTabela('SER_VALCUS', 'CADSER', ['SER_CODSER'], [strCodSer], False);

end;

function fEhServicoTerceirizado(strCodSer: String): Boolean;
begin
  Result := fCampoTabela('SER_TERCER', 'CADSER', ['SER_CODSER'], [strCodSer]) = 'S';
end;

function fRetornaCustoServicoTerceirizado(strCodSer: String): Double;
begin
  Result := fCampoTabela('SER_VALCUS', 'CADSER', ['SER_CODSER','SER_TERCER'], [strCodSer, 'S']);
end;

function fConsideraEmpresaDoPedidoOrcamentoNoCupomPromocional: Boolean;
begin
  Result := (fCfgSis('EMPCPP', varInteger)) = 2;
end;

function fRateiaFreteItensTransportadora(const strCodTra, strTipFre : String): Boolean;
begin
  Result := (fCampoTabela('TRA_FREVEN', 'CADTRA', ['TRA_CODTRA'], [strCodTra], False) = 'R');
  If Not Result Then
    Exit;
  If fEmptyStr(strTipFre) Then
    Exit;
  If (StrToIntDef(strTipFre, -2) = -2) Then
    Exit;
  Result := fTipoDeFreteEfetuaRateio(strCodTra, StrToInt(strTipFre));
end;

function fTipoDeFreteEfetuaRateio(const strCodTra : String; const intTipFre : Integer): Boolean;
  Var
    qryGenDep : TUniQuery;
begin
  qryGenDep := fCriaQuery;
  Try
    Result := False;
    qryGenDep.Close;
    qryGenDep.SQL.Clear;
    qryGenDep.SQL.Add(' SELECT RAO_TIPFRE ');
    qryGenDep.SQL.Add('   FROM FRERAO ');
    qryGenDep.SQL.Add('  WHERE RAO_CODTRA = :CODTRA ');
    qryGenDep.ParamByName('CODTRA').AsString := strCodTra;
    qryGenDep.Open;
    If (qryGenDep.IsEmpty) Then
    Begin
      Result := True;
      Exit;
    End;
    qryGenDep.First;
    While Not qryGenDep.Eof Do
    Begin
      If (qryGenDep.FieldByName('RAO_TIPFRE').AsInteger = intTipFre) Then
      Begin
        Result := True;
        Exit;
      End;
      qryGenDep.Next;
    End;
  Finally
    FreeAndNil(qryGenDep);
  End;
end;

function fEhExportacaoIndireta(strCliExpInd, strFgoTipOpe: String): Boolean;
begin
  Result := True;

  If (strCliExpInd = 'S') Then
    Exit;

  If (strFgoTipOpe = 'E') Then
    Exit;

  Result := False;
end;

function fRetDescontoFidelidade(strCodCli: String): Double;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  If (fCfgSis('DDESFD', varInteger) = 0) Then
  Begin
    Result := 0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  CLI_ULTCOM           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADCLI               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      If ((VS_Date - FieldByName('CLI_ULTCOM').AsDateTime) > fCfgSis('DDESFD', varInteger)) Then
        Result := 0
      Else
        Result := fCfgSis('PDESFD', varDouble);

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

function fRetCodEmpClienteFilial(strCliFil: String): String;
  Var
    qryDoc : TUniQuery;
begin
  qryDoc := fCriaQuery(Nil);
  With qryDoc, SQL Do
  Begin
    Add(TFunctionFuncoesFaturamento.fRetSelectCodEmpClienteFilial);
    ParamByName('CLIFIL').AsString := strCliFil;
    Open;
    Result := TFunctionFuncoesFaturamento.fRetCodEmpClienteFilial(FieldByName('EMP_CODEMP').AsString);
    Close;
  End;
  FreeAndNil(qryDoc);
end;

function fRetDesCla(strClaFis: String; blnConsulta: Boolean = False): String;
var strCampo, strTabela, strCampoFiltro: string;
    qryConsulta: TUniQuery;
begin
  strCampo := 'CFO_DESCR1';
  strTabela := 'CADCFO';
  strCampoFiltro := 'CFO_CODCFO';
  If fCfgSis('OPCCFO', varInteger) = 1 Then
  Begin
    strCampo := 'NAT_DESCRI';
    strTabela := 'NATCFO';
    strCampoFiltro := 'NAT_CODCFO';
  End;

  If blnConsulta Then
  Begin
    qryConsulta := fCriaQuery;
    Try
      qryConsulta.SQL.Add('SELECT ' + strCampo + ' FROM ' +  strTabela + ' WHERE ' + strCampoFiltro + ' = "' + strClaFis + '"');
      qryConsulta.Open;
      IF qryConsulta.RecordCount > 1 Then
        Result := 'Diversos'
      Else
        Result := qryConsulta.FieldByName(strCampo).AsString;
      Exit;
    Finally
      FreeAndNil(qryConsulta);
    End;
  End
  Else
  Begin
    Result := '';
    If (strTabela = 'NATCFO') Then
      Result := fCampoTabela(strCampo, strTabela, [strCampoFiltro, 'NAT_ATIVO_'], [strClaFis, 'S'], False);
    If fEmptyStr(Result) Then
      Result := fCampoTabela(strCampo, strTabela, [strCampoFiltro], [strClaFis], False);
  End;
end;


procedure pGravaRegistroContabilidade(RegistroContabilidade: TrecRegistroContabilidade);
var qryInsertCONLOG: TUniQuery;
   strTabela: String;
   strTipLan: String;
   intModLan: Integer;
   blnGrava: Boolean;
begin

  If Not((fCfgsis('UTICON', varBoolean) and fCfgSis('CONONL', varBoolean))) Then
    Exit;

  case RegistroContabilidade.ttpTabela of
    ttMovger: strTabela := 'MOVGER';
    ttNotger: strTabela := 'NOTGER';
    ttCadFis: strTabela := 'CADFIS';
  end;

  If (StrToInt(RegistroContabilidade.strClafis) >= 5000) Then
    strTipLan := 'SAI'
  Else
    strTipLan := 'ENT';
  blnGrava := false;
  If RegistroContabilidade.ttpTabela in [ttMovger, ttNotGer] Then
    blnGrava := (Pos(copy(RegistroContabilidade.strClafis, 2, 3), '_933_253_303_602_605') = 0) And
                (Pos(RegistroContabilidade.strEspDoc, '_NF_NS_NV_IF_IV_D1_EL') > 0)
  Else if RegistroContabilidade.ttpTabela = ttCadFis Then

     blnGrava := (Pos(copy(RegistroContabilidade.strClafis, 2, 3), '_933_253_303_602_605') > 0);


  If Not blnGrava Then
    Exit;

  intModLan := 0;
  case RegistroContabilidade.mlModLan of
    mlInclusao: intModLan := 1;
    mlEstorno: intModLan := 2;
    mlCancelamento: intModLan := 3;
  End;

  qryInsertCONLOG := fCriaQuery;
  Try
    qryInsertCONLOG.SQL.Add('INSERT INTO CONLOG(');
    qryInsertCONLOG.SQL.Add('LOG_TIPLAN, ');
    qryInsertCONLOG.SQL.Add('LOG_EMPLAN, ');
    qryInsertCONLOG.SQL.Add('LOG_TABELA, ');
    qryInsertCONLOG.SQL.Add('LOG_INCDOC, ');
    qryInsertCONLOG.SQL.Add('LOG_MODLAN) VALUES ( ');
    qryInsertCONLOG.SQL.Add(':TIPLAN,  ');
    qryInsertCONLOG.SQL.Add(':EMPLAN,  ');
    qryInsertCONLOG.SQL.Add(':TABELA,  ');
    qryInsertCONLOG.SQL.Add(':INCDOC,  ');
    qryInsertCONLOG.SQL.Add(':MODLAN)  ');

    qryInsertCONLOG.ParamByName('TIPLAN').AsString := strTipLan;
    qryInsertCONLOG.ParamByName('EMPLAN').AsString := RegistroContabilidade.strEmpLan;
    qryInsertCONLOG.ParamByName('TABELA').AsString := strTabela;
    qryInsertCONLOG.ParamByName('INCDOC').AsString := RegistroContabilidade.strSeqGer;
    qryInsertCONLOG.ParamByName('MODLAN').AsInteger := intModLan;

    qryInsertCONLOG.ExecSQL;
  Finally
    FreeAndNil(qryInsertCONLOG);
  End;
end;

function fOSVerificaOriPDO(strNumDoc, strEspDoc, strCodEmp: String; var strEmpOri: String): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
Begin
  Result := False;
  strEmpOri := '';

  if (fCfgSis('ORIPDO', VarString) = '1') then
    Exit;

  qryAux := fCriaQuery(Nil);

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   EQU_CODEMP EMPORI ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' WHERE (EQU_EMPPED <> EQU_CODEMP) ';
    strSQL := strSQL + '    AND (EQU_NUMPED = :NUMPED ';
    strSQL := strSQL + '    AND EQU_TIPPED = :ESPPED  ';
    strSQL := strSQL + '    AND EQU_EMPPED = :CODEMP) ';
    strSQL := strSQL + ' UNION ';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   EQU_CODEMP EMPORI ';
    strSQL := strSQL + ' FROM EQUGER ';
    strSQL := strSQL + ' INNER JOIN EQUGOR ON EQUGER.AUTOINCREM = EQUGOR.FGO_SEQEQU ';
    strSQL := strSQL + ' INNER JOIN FATGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + ' WHERE (FGO_CODEMP <> EQU_CODEMP) ';
    strSQL := strSQL + '    AND (FGO_NUMDOC = :NUMPED ';
    strSQL := strSQL + '    AND FGO_ESPDOC = :ESPPED  ';
    strSQL := strSQL + '    AND FGO_CODEMP = :CODEMP) ';

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMPED').AsString := strNumDoc;
    qryAux.ParamByName('ESPPED').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      Result := True;
      strEmpOri := qryAux.FieldByName('EMPORI').AsString;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  Result := 0;

  If (Not fCfgSis('GARANT', varBoolean)) Or
     ((Pos(strClaFis, VS_strClaVen) = 0) And (Pos(strClaFis, CLAFIS_ENTFUT_VEN) <= 0)) Then
    Exit;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_TMPGAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := FieldByName('ITE_TMPGAR').AsInteger;

    Close;
  End;

  FreeAndNil(qryTmp);


End;

function fPedidoEhOrigemTabletSite(strNumDoc, strEspDoc, strEmpDoc : String) : Boolean;
var
  strNumPok : String;
Begin

  Result := False;

  If strNumDoc.IsEmpty Then
    Exit;

  If strEspDoc.IsEmpty Then
    Exit;

  If strEmpDoc.IsEmpty Then
    Exit;

  strNumPok := fCampoTabela('FGO_NUMPOK', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strEmpDoc]);

  Result := Not fEmptyStr(strNumPok);

End;

function fGetItemAhGranel(strCodIte: String): String;
begin
  Result := fCadIte(strCodIte).FieldByName('ITE_CODPAG').AsString;
end;

function fGetCodCorItem(strCodIte: String): String;
begin
  Result := fCadIte(strCodIte).FieldByName('ITE_CODCOR').AsString;
end;

{Req. 456948-B. Par fltPeso/strFormula do cache de
 fGetPesoEspecificoItemGranel - GEIMAT/DEIMAT e estrutura de formula,
 nao muda no meio de uma rodada de balanco.}
type
  TCachePesoEspGranel = record
    fltPeso: Double;
    strFormula: String;
  end;

var
  {Nil por default - fGetPesoEspecificoItemGranel roda sem cache fora do
   balanco. Armado/desarmado por pLigaCachePesoEspGranel/
   pDesligaCachePesoEspGranel, chamadas so em untBalancoEstoqueGravar.pas.}
  VS_dicCachePesoEspGranel: TDictionary<String, TCachePesoEspGranel>;

procedure pLigaCachePesoEspGranel;
begin
  If Not Assigned(VS_dicCachePesoEspGranel) Then
    VS_dicCachePesoEspGranel := TDictionary<String, TCachePesoEspGranel>.Create;
end;

procedure pDesligaCachePesoEspGranel;
begin
  FreeAndNil(VS_dicCachePesoEspGranel);
end;

function fGetPesoEspecificoItemGranel(strCodIteGranel, strCodCor: String; Var strFormula: String): Double;
  Var
    strSQL: String;
    qryGeiMat: TUniQuery;
    intMaxSeqGer: Integer;
    fltTotPercen,
    fltTotCusIte,
    fltTotDensid,
    fltPVC,
    fltCPVC,
    fltPVCCPVC,
    fltMassaSolidos,
    fltVolumeSolidos: Double;
    strChaveCache: String;
    recCache: TCachePesoEspGranel;
begin
  Result := 0;
  strFormula := '';

  If Assigned(VS_dicCachePesoEspGranel) Then
  Begin
    strChaveCache := strCodIteGranel + '|' + strCodCor;
    If VS_dicCachePesoEspGranel.TryGetValue(strChaveCache, recCache) Then
    Begin
      Result     := recCache.fltPeso;
      strFormula := recCache.strFormula;
      Exit;
    End;
  End;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IFNULL(ITE_PRECUS, 0) AS DMT_CUSITE, ';
  strSQL := strSQL + '   IFNULL(ITE_DENSID, 0) AS DMT_DENSID, ';
  strSQL := strSQL + '   COALESCE(GMT_FORMUL, 0) AS FORMUL,   ';
  strSQL := strSQL + '   DEIMAT.* ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   DEIMAT ';
  strSQL := strSQL + '   JOIN GEIMAT      G ON DMT_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '   LEFT JOIN CADITE   ON DMT_ITESUB = CADITE.ITE_CODITE ';
  strSQL := strSQL + '   LEFT JOIN ITEGER I ON DMT_ITESUB = I.ITE_CODITE AND ';
  strSQL := strSQL + '                       I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   GMT_CODITE = :CODITE AND ';
  strSQL := strSQL + '   GMT_CODCOR = :CODCOR AND ';
  strSQL := strSQL + '   GMT_STATUS = "A" ';

  Try
    qryGeiMat := fCriaQuery;

    With qryGeiMat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIteGranel;
      ParamByName('CODCOR').AsString := strCodCor;
      Open;

      If Not IsEmpty Then
      Begin
        pCalculaPesoEspecificoSubItens(qryGeiMat,
                                       intMaxSeqGer,
                                       fltTotPercen,
                                       fltTotCusIte,
                                       fltTotDensid,
                                       fltPVC,
                                       fltCPVC,
                                       fltPVCCPVC,
                                       fltMassaSolidos,
                                       fltVolumeSolidos);

        Result     := fltTotDensid;
        strFormula := fStrZero(FieldByName('FORMUL').AsInteger, 5);
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGetPesoEspecificoItemGranel]');
    End;
  End;

  FreeAndNil(qryGeiMat);

  If Assigned(VS_dicCachePesoEspGranel) Then
  Begin
    recCache.fltPeso    := Result;
    recCache.strFormula := strFormula;
    VS_dicCachePesoEspGranel.AddOrSetValue(strChaveCache, recCache);
  End;
End;

function fTemServicoPD(strCodEmp, strNumDoc, strCodCli: String): Boolean;
  Var
    qry: TUniQuery;
begin
  qry := fCriaQuery;
  Try
    qry.SQL.Add('SELECT COUNT(1)');
    qry.SQL.Add('  FROM FATDOR');
    qry.SQL.Add(' WHERE FDO_CODEMP = :CODEMP');
    qry.SQL.Add('   AND FDO_NUMDOC = :NUMDOC');
    qry.SQL.Add('   AND FDO_ESPDOC = "PD"');
    If Not fEmptyStr(strCodCli) Then
      qry.SQL.Add('   AND FDO_CODCLI = :CODCLI');
    qry.SQL.Add('   AND (FDO_CODITE = :ITESER OR FDO_CODITE = :SERTER)');

    qry.ParamByName('CODEMP').AsString := strCodEmp;
    qry.ParamByName('NUMDOC').AsString := strNumDoc;
    If Not fEmptyStr(strCodCli) Then
      qry.ParamByName('CODCLI').AsString := strCodCli;
    qry.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qry.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qry.Open;

    Result := qry.Fields[0].AsInteger > 0;
  Finally
    FreeAndNil(qry);
  End;
end;

function fFormataFloatSky(fltValor: Double): Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);
  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
end;

function fExistemCompromissosAgendados: boolean;
  var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Result := False;

  If fEmptyStr(strLoginUsuarioLogado) Then
    Exit;

  qryGen := fCriaQuery(Nil);

  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT COUNT(0) ';
      strSQL := strSQL + '   FROM AGENDA ';
      strSQL := strSQL + '  WHERE IFNULL(AGE_BAIXAD,"N") = "N" ';
      strSQL := strSQL + '    AND AGE_CODOPE = :CODOPE ';
      strSQL := strSQL + '    AND AGE_DTACOM <= CURRENT_DATE() ';
      strSQL := strSQL + '    AND AGE_HORCOM < CURRENT_TIME() ';
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        Open;
        Result := (Fields[0].AsInteger > 0);
        Close;
      End;
    Except
      On E : Exception Do
      begin
        Result := False;
        pMensagensErro(E.Message, '[fExistemCompromissosAgendados]');
      end;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetQuantidadeDevolvida(strNumDoc, strEspDoc, strCodEmp, strCodIte : String; blnIncluirDevolucaoPorGarantia : Boolean = True; strTabela: String = 'MOVDET'):Double;
  Var
    strSQL : String;
    qryDevolu : TUniQuery;
Begin
  strSQL := '';

  If (strTabela = 'NOTGER') or (strTabela = 'NOTDET') Then
  begin
    strSQL := strSQL + ' SELECT ';
    //DEVOLUÇÃO DE FF
    strSQL := strSQL + '   (IFNULL((SELECT SUM(A.DET_QTDITE) ';
    strSQL := strSQL + '            FROM MOVDET A ';
    strSQL := strSQL + '            WHERE A.DET_ESPDOC = "DV" ';
    strSQL := strSQL + '              AND A.DET_CODITE = D.DET_CODITE ';
    strSQL := strSQL + '              AND EXISTS (SELECT 1 ';
    strSQL := strSQL + '                          FROM MOVDET B ';
    strSQL := strSQL + '                          WHERE B.DET_CODCLI = A.DET_CODCLI ';
    strSQL := strSQL + '                            AND B.DET_CODITE = A.DET_CODITE ';
    strSQL := strSQL + '                            AND B.DET_NUMDOC = A.DET_DOCDEV ';
    strSQL := strSQL + '                            AND B.DET_ESPDOC = A.DET_ESPDEV ';
    strSQL := strSQL + '                            AND B.DET_EMPFAT = D.DET_CODEMP ';
    strSQL := strSQL + '                            AND B.DET_TIPFAT = D.DET_ESPDOC ';
    strSQL := strSQL + '                            AND B.DET_NUMFAT = D.DET_NUMDOC ';
    strSQL := strSQL + '                            AND B.DET_CODEMP = A.DET_EMPDEV ';
    strSQL := strSQL + '                            AND B.DET_ESPDOC = "FF")),0) ';

    //DEVOLUÇÃO DA NOTDET
    strSQL := strSQL + '    + IFNULL((SELECT SUM(A.DET_QTDITE) ';
    strSQL := strSQL + '              FROM MOVDET A ';
    If not blnIncluirDevolucaoPorGarantia Then
    Begin
      strSQL := strSQL + '              LEFT JOIN MOVGRC C ON C.GRC_SEQDET = A.AUTOINCREM ';
      strSQL := strSQL + '              LEFT JOIN AUXMOV B ON B.AUX_SEQGER = A.DET_SEQGER ';
    End;
    strSQL := strSQL + '              WHERE A.DET_CODCLI = D.DET_CODCLI ';
    strSQL := strSQL + '                AND A.DET_CODITE = D.DET_CODITE ';
    strSQL := strSQL + '                AND A.DET_EMPDEV = D.DET_CODEMP ';
    strSQL := strSQL + '                AND A.DET_ESPDEV = D.DET_ESPDOC ';
    strSQL := strSQL + '                AND A.DET_DOCDEV = D.DET_NUMDOC ';

    If not blnIncluirDevolucaoPorGarantia Then
      strSQL := strSQL + '                AND ((C.AUTOINCREM IS NULL) OR (IFNULL(B.AUX_COLETA, "N") = "S")) ';

    strSQL := strSQL + '    ),0)) AS DEV ';
    strSQL := strSQL + ' FROM NOTDET D ';
    strSQL := strSQL + ' WHERE D.DET_CODITE = :CODITE ';
    strSQL := strSQL + '   AND D.DET_CODEMP = :EMPDEV ';
    strSQL := strSQL + '   AND D.DET_ESPDOC = :ESPDEV ';
    strSQL := strSQL + '   AND D.DET_NUMDOC = :DOCDEV ';
  end
  else
  begin
    strSQL := strSQL + ' SELECT SUM(DET_QTDITE) AS DEV ';
    strSQL := strSQL + ' FROM MOVDET                   ';
    If not blnIncluirDevolucaoPorGarantia Then
    Begin
      strSQL := strSQL + ' LEFT JOIN MOVGRC ON GRC_SEQDET = MOVDET.AUTOINCREM ';
      strSQL := strSQL + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVDET.DET_SEQGER ';
    End;
    strSQL := strSQL + ' WHERE DET_DOCDEV = :DOCDEV    ';
    strSQL := strSQL + '   AND DET_ESPDEV = :ESPDEV    ';
    strSQL := strSQL + '   AND DET_EMPDEV = :EMPDEV    ';
    strSQL := strSQL + '   AND DET_CODITE = :CODITE    ';
    If not blnIncluirDevolucaoPorGarantia Then
    Begin
      strSQL := strSQL + '    AND ((MOVGRC.AUTOINCREM IS NULL) OR (IFNULL(AUX_COLETA, "N") = "S")) ';
    End;
  end;
  qryDevolu := Nil;
  Try
    qryDevolu := fCriaQuery;
    With qryDevolu, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);

      ParamByName('DOCDEV').AsString := strNumDoc;
      ParamByName('ESPDEV').AsString := strEspDoc;
      ParamByName('EMPDEV').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;

      Open;

      If not IsEmpty Then
        Result := FieldByName('DEV').AsFloat
      Else
        Result := 0.00;

      Close;
    End;
  Finally
    FreeAndNil(qryDevolu);
  End;
End;

function fRetCubagemItem(strCodIte: String; fltQtdIte: Double): Double;
  Const
    SQL = 'SELECT ' +
          '  IFNULL(ITE_EXPALT, 0) AS ITE_EXPALT, ' +
          '  IFNULL(ITE_EXPLAR, 0) AS ITE_EXPLAR, ' +
          '  IFNULL(ITE_EXPPRO, 0) AS ITE_EXPPRO  ' +
          'FROM     ' +
          '  DESSIT ' +
          'WHERE    ' +
          '  ITE_CODITE = :CODITE';
  Var
    qryItem: TUniQuery;
    fltAlt: Double;
    fltLar: Double;
    fltPro: Double;
begin
  Result := 0;

  If (strCodIte.IsEmpty) Then
    Exit;

  qryItem := fCriaQuery();

  Try
    qryItem.Close;
    qryItem.SQL.Clear;
    qryItem.SQL.Add(SQL);
    qryItem.ParamByName('CODITE').AsString := strCodIte;
    qryItem.Open;

    If (qryItem.IsEmpty) Then
      Exit;

    fltAlt := qryItem.FieldByName('ITE_EXPALT').AsFloat / 100;
    fltLar := qryItem.FieldByName('ITE_EXPLAR').AsFloat / 100;
    fltPro := qryItem.FieldByName('ITE_EXPPRO').AsFloat / 100;

    Result := (fltQtdIte * fltAlt * fltLar * fltPro);

  Finally
    FreeAndNil(qryItem);
  End;
end;

function fChaveDocumentoEntradaMercadorias(cdsDocumentos: TDataSet): String;
begin
  With cdsDocumentos Do
  Result := FieldByName('GER_NUMDOC').AsString +
            FieldByName('GER_ESPDOC').AsString +
            FieldByName('GER_CODEMP').AsString +
            FieldByName('GER_CODCLI').AsString +
            FieldByName('GER_ORIDOC').AsString;
  Result := QuotedStr(Result);
end;

function fUsaCfopDecretoCeara(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_USADCE', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

function fRetornaCfopDecretoCeara(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_CLADCE', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
end;

function fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryCadRec : TUniQuery;

  function fChaLck(strTab: String; strCli: String): String;
  begin
    Result := strTab + strNumDoc + strEspDoc + strCodEmp + strCli;
  end;

  procedure pProcuraParcelas;
  begin
    With qryCadRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT ');
      SQL.Add('   CTR_PARCEL, ');
      SQL.Add('   CTR_SEQBAI  ');
      SQL.Add('  FROM CADREC  ');
      SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
      SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
      SQL.Add('    AND CTR_CODEMP = :CODEMP ');
      SQL.Add('    AND CTR_CODCLI = :CODCLI ');
      ParamByName('NUMDUP').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspdoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;
  end;

  function fTemParcelaTravada: Boolean;
  begin
    Result := False;
    qryCadRec.First;
    While Not qryCadRec.Eof Do
    Begin

      If Not fLock_Unlock(fChaLck('CADREC', strCodCli) + qryCadRec.FieldByName('CTR_PARCEL').AsString + qryCadRec.FieldByName('CTR_SEQBAI').AsString, True, False) Then
      Begin
        Result := True;
        Break;
      End;

      qryCadRec.Next;
    End;
  end;

begin
  Result := False;
  qryCadRec := Nil;

  If Not fEmptyStr(fGetHostLock(fChaLck(strTabela, ''))) Then
  Begin
    Result := True;
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fChaLck(strTabela, '')), ['&OK']);
  End;

  If (Not Result) Then
  Begin
    qryCadRec := fCriaQuery(Nil);

    pProcuraParcelas;

    If fTemParcelaTravada Then
    Begin
      Result := True;
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fChaLck('CADREC', strCodCli) + qryCadRec.FieldByName('CTR_PARCEL').AsString), ['&OK']);
    End;

    qryCadRec.Close;
  End;

  If Assigned(qryCadRec) Then
    FreeAndNil(qryCadRec);
end;

{*****************************************}
{* RETORNA SOMENTE NUMEROS EM UMA STRING *}
{***************************************FC}
function fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
      If CharInSet(strTexto[intIndice], ['0'..'9']) Then
        strTmp := strTmp + strTexto[intIndice];
  End;

  Result := strTmp;
end;

function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;
var
  strDiaMes : String;
  strDiaSem : String;
  intCnt : Integer;
  intDiaSem : Integer;
begin
  Result := True;

  If (Not fCfgSis('UTDTFE', varBoolean)) Then
    Exit;

  strDiaMes := fCampoTabela(strCampoDiaMes, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  strDiaSem := fCampoTabela(strCampoDiaSemana, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);

  strDiaSem := fPadR(strDiaSem, 7, 'N');
  intDiaSem := DayOfWeek(dtaData);

  For intCnt := 1 To 7 Do
  Begin
    If (intDiaSem = intCnt) Then
    Begin
      Result := (strDiaSem[intCnt] = 'S');
      Break;
    End;
  End;

  If (Result) Then
    Result := fTransform(strDiaMes, 2).Contains(fStrZero(DayOf(dtaData), 2));
End;

function fRetMltVenItem(Const strCodIte: String): Double;
Var
  strSQL   : String;
  qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_MLTVEN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_MLTVEN').AsFloat
      Else
        Result := 0;

      Close;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function fRetMltComItem(Const strCodIte: String): Double;
Var
  strSQL   : String;
  qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_MLTCOM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_MLTCOM').AsFloat
      Else
        Result := 0;

      Close;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function fCalcVolumes(strCodIte: String; fltQtdIte, fltEmbala: Double): Double;
Var
  strVolEmb: String;
  fltMltVen: Double;
  fltMltCom: Double;
Begin
  Result := 0;
  strVolEmb := fCfgSis('TIPVOL');

  If strVolEmb = '1' Then
  Begin
    If fltEmbala <= 0 Then
      fltEmbala := 1;

    Result := Result + Ceil(fltQtdIte / fltEmbala);
  End
  Else If strVolEmb = '2' Then
  Begin
    fltMltVen := fRetMltVenItem(strCodIte);

    If fltMltVen <= 0 Then
      fltMltVen := 1;

    Result := Result + Ceil(fFormataFloat(((fFormataFloat((fltQtdIte / fltMltVen), 4) * fFormataFloat((1 - fltMltVen), 4)) + fltQtdIte), 4));
  End
  Else If strVolEmb = '3' Then
  Begin
    fltMltVen := fRetMltVenItem(strCodIte);
    fltMltCom := fRetMltComItem(strCodIte);

    If fltMltVen <= 0 Then
      fltMltVen := 1;

    If fltMltCom <= 0 Then
      fltMltCom := 1;

    Result := Result + Ceil(Trunc(fltQtdIte / fltMltCom) + ((fltQtdIte - (Trunc(fltQtdIte / fltMltCom) * fltMltCom)) / fltMltVen));
  End;
End;

function fGetFullTextColumnsFromField(AField, ATable: string; var AFieldIndex: Integer): string;
var
  LQuery: TUniQuery;
begin
  Result := '';
  AFieldIndex := 0;
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SHOW INDEXES FROM ' + ATable);
    LQuery.Open;
    if LQuery.Locate('Column_name', AField, []) then
    begin
      LQuery.Filter := 'Key_name = ' + QuotedStr(LQuery.FieldByName('Key_name').AsString);
      LQuery.Filtered := True;
      LQuery.First;
      while not LQuery.Eof do
      begin
        if Result <> '' then
          Result := Result + ',';
        Result := Result + LQuery.FieldByName('Column_name').AsString;
        if LQuery.FieldByName('Column_name').AsString = AField then
          AFieldIndex := Pred(LQuery.RecNo);
        LQuery.Next;
      end;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

function fRefazLogNfeCasoExcluido(strAcesso: String): Boolean;
var
  strDocLogNfe: String;
  objCadFis: IMyCampoTabela;
  qryLogNfe: TUniQuery;
begin
  Result := True;

  strDocLogNfe := fCampoTabela('NFE_NUMDOC', 'LOGNFE', ['NFE_ACESSO'], [strAcesso]);

  if not fEmptyStr(strDocLogNfe) then
    Exit;

  objCadFis := fCampoTabela(['FIS_NUMDOC','FIS_ESPDOC','FIS_CODEMP','FIS_FORCLI','FIS_SERIE_','FIS_TIP_FC','FIS_DTAENT'], 'CADFIS', ['FIS_ACESSO'], [strAcesso]);

  if fEmptyStr(objCadFis.FieldByName('FIS_NUMDOC').AsString) then
    Exit(False);

  qryLogNfe := fCriaQuery;

  try
    try
      qryLogNfe.Close;
      qryLogNfe.SQL.Clear;
      qryLogNfe.SQL.Add('INSERT INTO LOGNFE(NFE_NUMDOC, NFE_ESPDOC, NFE_CODEMP, NFE_CODCLI, NFE_TIP_FC, ');
      qryLogNfe.SQL.Add('                   NFE_SERIE_, NFE_ACESSO, NFE_STATUS, NFE_HORINI)');
      qryLogNfe.SQL.Add('VALUES(:NUMDOC, :ESPDOC, :CODEMP, :CODCLI, :TIP_FC, ');
      qryLogNfe.SQL.Add('       :SERIE_, :ACESSO, :STATUS, :HORINI)');

      qryLogNfe.ParamByName('NUMDOC').AsString := objCadFis.FieldByName('FIS_NUMDOC').AsString;
      qryLogNfe.ParamByName('ESPDOC').AsString := objCadFis.FieldByName('FIS_ESPDOC').AsString;
      qryLogNfe.ParamByName('CODEMP').AsString := objCadFis.FieldByName('FIS_CODEMP').AsString;
      qryLogNfe.ParamByName('CODCLI').AsString := objCadFis.FieldByName('FIS_FORCLI').AsString;
      qryLogNfe.ParamByName('TIP_FC').AsString := objCadFis.FieldByName('FIS_TIP_FC').AsString;
      qryLogNfe.ParamByName('SERIE_').AsString := objCadFis.FieldByName('FIS_SERIE_').AsString;
      qryLogNfe.ParamByName('ACESSO').AsString := strAcesso;
      qryLogNfe.ParamByName('STATUS').AsString := 'AT';
      qryLogNfe.ParamByName('HORINI').AsDateTime := objCadFis.FieldByName('FIS_DTAENT').AsDateTime;

      qryLogNfe.ExecSQL;
    except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[fRefazLogNfeCasoExcluido]');
      End;
    end
  finally
    FreeAndNil(qryLogNfe);
  end;
end;

{**********************************************************}
{*Cod. de Barras -> 7  8  9  1  2  3  4  5  0  0  0  1  ? *}
{*Enumere  Pos.  ->13 12 11 10 09 08 07 06 05 04 03 02 01 *}
{*                                                        *}
{*Some as Colunas Pares   -> 8 + 1 + 3 + 5 + 0 + 1 = 18   *}
{*                          12  10  08  06  04  05        *}
{*                                                        *}
{*Multiplique o Result. P/ 3 -> 18 * 3 = 54               *}
{*                                                        *}
{*                                                        *}
{*Some as colunas Impares -> 7 + 9 + 2 + 4 + 0 + 0 = 22   *}
{*                          13  11  09  07  05  03        *}
{*                                                        *}
{*Some os Resultados -> 54 + 22 == 76                     *}
{*                                                        *}
{*Subtraia o Multiplo de Dez Maior Que Ele(80) do         *}
{*Resultado Encontrado( 76 ) ---> 80-76 = 4               *}
{*                                                        *}
{*                                                        *}
{*O Digito Verificador é --> 4                            *}
{**********************************************************}
function fGeraCodBarraEAN13(strCodigo: String): String;
  Var
    intContador: Integer;
    intSomaPar: Integer;
    intSomaImp: Integer;
    intTotal: Integer;
    intMultiplo: Integer;
    intResto: Integer;
begin

  Result := '';
  If (Length(strCodigo) <> 12) Then
  Begin
    Exit;
  End;

  intSomaPar := 0;
  intSomaImp := 0;

  For intContador := 1 To Length(strCodigo) Do
  Begin
    If intContador Mod 2 = 0 Then
      intSomaPar := intSomaPar + StrToIntDef(strCodigo[intContador], 0)
    Else
      intSomaImp := intSomaImp + StrToIntDef(strCodigo[intContador], 0);
  End;
  intSomaPar := intSomaPar * 3;
  intTotal   := intSomaPar + intSomaImp;
  intResto   := intTotal Mod 10;

  If intResto =  0 Then
    intMultiplo := intTotal
  Else
    intMultiplo := intTotal + (10 - (intResto));

  Result := strCodigo + IntToStr(intMultiplo - intTotal);
end;

procedure pCarregaDuplicatasCND(intTabela:Integer; strAutoincrem:String; var arrDuplicataCND: TarrDuplicata; blnVeioDaEntrada: Boolean);
var strSQL: String;
    qryCND: TUniQuery;
  intIndex: Integer;
Begin
  Case intTabela of
    1:Begin
        strSQL := 'SELECT FGO_PARCEL AS PARCEL, FGO_VALPAR AS VALPAR FROM GORCND '+
                  'INNER JOIN FATGOR ON FGO_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY FGO_PARCEL ';
      End;
    2:Begin
        strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM GERCND '+
                  'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY GER_PARCEL ';
      End;
    3:Begin
        strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM NOTCND '+
                  'INNER JOIN NOTGER ON GER_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY GER_PARCEL ';
      End;
    4:Begin
        strSQL := 'SELECT PRE_PARCEL AS PARCEL, PRE_VALPAR AS VALPAR, PRE_DTAVEN AS DTAVEN '+
                  ' FROM PRECND INNER JOIN GERELE ON PRE_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY PRE_PARCEL ';
      End;
  End;

  Try
    qryCND := fCriaQuery;

    FillChar(arrDuplicataCND, SizeOf(arrDuplicataCND), #0);

    with qryCND, SQL do
    Begin
      Clear;
      Add(strSQL);
      ParamByName('AUTOINCREM').AsString := strAutoincrem ;
      Open;

      intIndex := 0;
      While not eof do
      Begin
        If intIndex > High(arrDuplicataCND) Then
        Begin
          If blnVeioDaEntrada Then
            Raise Exception.Create('A condicao de pagamento possui mais de ' +
                                   IntToStr(Length(arrDuplicataCND)) +
                                   ' parcelas, acima do maximo suportado. Tabela ' +
                                   IntToStr(intTabela) + ', autoincremento ' + strAutoincrem + '.');

          Break;
        End;

        arrDuplicataCND[intIndex].strSequen := FieldByName('PARCEL').AsString;
        arrDuplicataCND[intIndex].curValor  := fFormataFloat(FieldByName('VALPAR').AsFloat, 2);
        If intTabela = 4 Then
          arrDuplicataCND[intIndex].dtaDtaVen := DateToStr(FieldByName('DTAVEN').AsDateTime);
        Inc(intIndex);

        Next;
      End;

    End;
  Finally
    FreeAndNil(qryCND);
  End;
End;

function fRemoveCaracterNulo(AString: String): String;
var
  s: String;
begin
  s := AString;

  While Pos(#0, s) > 0 Do
    Delete(s, Pos(#0, s), 1);

  Result := s;
end;

function fRemoveBarraInvertidaFinalDaLinha(strText: String): String;
begin
  Result := strText;
  If RightStr(Trim(strText),1) = '\' Then
    Result := strText + ' ';
end;

function fFloatToSQL(fltValor: Double): String;
begin
  Result := FormatFloat(fMskDigitos(4),fltValor);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,',','.',[rfReplaceAll]);
end;

function fDoubleToSQL(const AValue: Double): string;
begin
  Result := FormatFloat('0.########', AValue, FForSet);
end;

function fRetornaRequisicaoCompra(strNumDoc: String; strEspDoc: String; strCodEmp: String; strCodIte: String):String;
  Var
    qryGen : TUniQuery;
    strFgoNumDoc : String;
    strFgoEspDoc : String;
    strFgoEmpDoc : String;
    strSqlMovRcd : String;
begin
  Result := '';

  qryGen := fCriaQuery;
  Try
    strSqlMovRcd := '';
    strSqlMovRcd := strSqlMovRcd + ' SELECT ';
    strSqlMovRcd := strSqlMovRcd + '   RCD_CODIGO ';
    strSqlMovRcd := strSqlMovRcd + ' FROM MOVRCD ';
    strSqlMovRcd := strSqlMovRcd + ' WHERE RCD_CODITE = :CODITE ';
    strSqlMovRcd := strSqlMovRcd + '   AND RCD_DOCPDV = :NUMDOC ';
    strSqlMovRcd := strSqlMovRcd + '   AND RCD_ESPPDV = :ESPDOC ';
    strSqlMovRcd := strSqlMovRcd + '   AND RCD_CODEMP = :CODEMP ';

    qryGen.Close();
    qryGen.SQL.Text := strSqlMovRcd;
    qryGen.ParamByName('CODITE').AsString := strCodIte;
    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open();

    If qryGen.IsEmpty Then
    Begin
      qryGen.Close();
      qryGen.SQL.Clear;
      qryGen.SQL.Add(' SELECT ');
      qryGen.SQL.Add('   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ');
      qryGen.SQL.Add(' FROM FATGOR ');
      qryGen.SQL.Add(' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER  ');
      qryGen.SQL.Add(' WHERE FGO_NUMFAT = :NUMDOC ');
      qryGen.SQL.Add('   AND FGO_TIPFAT = :ESPDOC ');
      qryGen.SQL.Add('   AND FGO_EMPFAT = :CODEMP ');
      qryGen.SQL.Add('   AND FDO_CODITE = :CODITE ');
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.Open();

      If (Not qryGen.IsEmpty) Then
      Begin
        strFgoNumDoc := qryGen.FieldByName('FGO_NUMDOC').AsString;
        strFgoEspDoc := qryGen.FieldByName('FGO_ESPDOC').AsString;
        strFgoEmpDoc := qryGen.FieldByName('FGO_CODEMP').AsString;

        qryGen.Close();
        qryGen.SQL.Text := strSqlMovRcd;
        qryGen.ParamByName('CODITE').AsString := strCodIte;
        qryGen.ParamByName('NUMDOC').AsString := strFgoNumDoc;
        qryGen.ParamByName('ESPDOC').AsString := strFgoEspDoc;
        qryGen.ParamByName('CODEMP').AsString := strFgoEmpDoc;
        qryGen.Open();

        Result := qryGen.FieldByName('RCD_CODIGO').AsString;
      End;
    End
    Else
      Result := qryGen.FieldByName('RCD_CODIGO').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fPedidosRequisicaoCompra(strCodReq: String; strCodEmp: String): String;
  Var
    qryGen : TUniQuery;
begin
  If (fEmptyStr(strCodReq)) Then
    Exit;

  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear;
    qryGen.SQL.Add(' SELECT ');
    qryGen.SQL.Add('   GROUP_CONCAT(DISTINCT ''"'', PCD_NUMPED, ''"'') AS PEDIDOS ');
    qryGen.SQL.Add(' FROM MOVRCD ');
    qryGen.SQL.Add(' LEFT JOIN PCMDET ON PCMDET.AUTOINCREM = MOVRCD.RCD_SEQPCD ');
    qryGen.SQL.Add(' WHERE RCD_CODIGO = :CODIGO ');
    qryGen.SQL.Add('   AND RCD_CODEMP = :CODEMP ');
    qryGen.SQL.Add('   AND IFNULL(RCD_SEQPCD, "") <> "" ');
    qryGen.ParamByName('CODIGO').AsString := strCodReq;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;
    qryGen.Open();

    Result := qryGen.FieldByName('PEDIDOS').AsString;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fCriarCdsCheques(AOwner: TComponent): TUniClientDataSet;
  Var
    qryCadChq: TUniQuery;
    intCont  : Integer;
begin
  qryCadChq := fCriarQuery('SELECT * FROM CADCHQ WHERE FALSE', AOwner);

  Result := TUniClientDataSet.Create(AOwner);
  Result.AggregatesActive := True;

  For intCont := 0 To qryCadChq.Fields.Count -1 Do
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryCadChq.Fields[intCont].FieldName;
      DataType := qryCadChq.Fields[intCont].DataType;
      Size     := qryCadChq.Fields[intCont].Size;
      Required := False;
    End;

  With TAggregateField.Create(Result) Do
  Begin
    FieldName     := 'TOT_VALCHQ';
    DataSet       := Result;
    DisplayFormat := '#,##0.00';
    Alignment     := System.Classes.taRightJustify;
    Expression    := 'SUM(CHQ_VALCHQ)';
    Active := True;
  End;

  Result.CreateDataSet;
  Result.Open;

  FreeAndNil(qryCadChq);
end;

function GeraUUIDVersao4: String;
  Var
    LObjetoUUID: TGUID;

    LUUIDString: String;
Begin
  Result := EmptyStr;

  Try
    Result := fCampoTabela('uuid_v4s()', 'DUAL', [], []);
  Except
    CreateGUID(LObjetoUUID);

    LUUIDString := GUIDToString(LObjetoUUID);

    If Not LUUIDString.IsEmpty Then
      Result := LUUIDString.Replace('{', EmptyStr)
                           .Replace('}', EmptyStr);
  End;
End;

function fEnviarWhatsappParaCliente(strCodCli: String; blnExibeMsg: Boolean = False): Boolean;
begin
  Result := True;
  try
    if not fCfgSis('UTIWPP', varBoolean) then
    begin
      blnExibeMsg := False;
      Exit(False);
    end;

    if (fCfgSis('WHACLI', varBoolean)) and (fCampoTabela('CLI_RECWPP', 'CADCLI', ['CLI_CODCLI'], [strCodCli]) = 'N') then
      Exit(False);
  finally
    if (not Result) and (blnExibeMsg) then
      fMensagem('Aviso', 'Este cliente está configurado para não receber mensagens via Whatsapp!', ['&O k']);
  end;
end;

function fUtilizaRestApiBoletoDLL: Boolean;
begin
 {$IFDEF LINUX}
  Result := False;
 {$ELSE}
  Result := fCfgSis('DLLBOL', varBoolean);
 {$ENDIF}
end;

function fUtilizaEnderecamento: Boolean;
begin
  Result := False;
  If fCfgSis('ENTEND', varBoolean) Then
  Begin
    Result := fCfgSis('DEVEND', varBoolean);

    If Not Result Then
      Result := fCfgSis('USACON', varBoolean) And
               (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  End;
End;

function fRegimeSubstituicaoTributaria(const strCodEmp : String = ''; const strOpcDoc : String = '') : String;
begin
  Result := fCfgSis(fCfgRegimeSubstituicaoTributaria(strOpcDoc), varString, strCodEmp);
end;

function fCfgRegimeSubstituicaoTributaria(const strOpcDoc : String = '') : String;
begin
  If (Pos(strOpcDoc, ESPECIES_CFG_CLASUF) > 0) Then
    Result := 'CLASUF'
  Else
    Result := 'CLASUB';
end;

function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;
  Var
    LArquivo: TFilestream;
Begin
  Result := EmptyStr;

  LArquivo := nil;

  if fEmptyStr(ACaminhoArquivo) then
    Exit;

  Try
    LArquivo := TFileStream.Create(ACaminhoArquivo, fmOpenRead or fmShareDenyNone);
    Result := TIdEncoderMIME.EncodeStream(LArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;

function fGetUniqueTempPath(const AExt: string = '.tmp'): string;
begin
  Result := TPath.Combine(
    TPath.GetTempPath,
    TGUID.NewGuid.ToString
      .Replace('{', '').Replace('}', '').Replace('-', '') + AExt
  );
end;

function fGetExtensaoArquivo(TipoArquivo: TTipoArquivo): String;
begin
  case TipoArquivo of
    tpaPDF        : Result := '.pdf';
    tpaImagem     : Result := '.jpeg';
    tpaImagemJpeg : Result := '.jpeg';
    tpaImagemJpg  : Result := '.jpg';
    tpaImagemPng  : Result := '.png';
    tpaExcel      : Result := '.xls';
    tpaXml        : Result := '.xml';
    tpaDoc        : Result := '.doc';
    tpaImagemBmp  : Result := '.bmp';
    else
      Result := '.pdf';
  end;
end;

function fGetTipoArquivo(const AstrArquivo: String): TTipoArquivo;
begin
  case AnsiIndexStr(ExtractFileExt(AstrArquivo).ToLower, ['.pdf', '.jpeg', '.jpg', '.png', '.xls', '.xml', '.doc', '.bmp'])  of
    0: Result := tpaPDF;
    1: Result := tpaImagemJpeg;
    2: Result := tpaImagemJpg;
    3: Result := tpaImagemPng;
    4: Result := tpaExcel;
    5: Result := tpaXml;
    6: Result := tpaDoc;
    7: Result := tpaImagemBmp;
    else
      Result := tpaPDF;
  end;
end;

function fRetBase64ParaArquivo(const ABase64: String; ANomeArquivo: String): String;
var
  InStream: TStringStream;
  OutStream: TFileStream;
  blnGerarNomeArquivo: Boolean;
  strExtensaoArquivo: String;
  intTentativas: Integer;
  ANomeNovoArquivo: String;
  blnTentarNovamente: Boolean;
  strExcept: String;
begin
  blnGerarNomeArquivo := False;
  strExtensaoArquivo := ExtractFileExt(ANomeArquivo);
  intTentativas := 0;
  ANomeNovoArquivo := EmptyStr;

  repeat
    blnTentarNovamente := False;

    if intTentativas = 3 then
    begin
      pGravarErro(True, '[fRetBase64ParaArquivo] - Não foi possível gerar o arquivo para disparo na GATIME_WPPEMA - '+strExcept);
      Break;
    end;

    if blnGerarNomeArquivo then
    begin
      if fEmptyStr(ANomeNovoArquivo) then
        ANomeArquivo := ANomeArquivo.Replace(strExtensaoArquivo, EmptyStr);

      ANomeNovoArquivo := ANomeArquivo +'_'+ FormatDateTime('yyyymmddhhnnsszzz', fNow) + strExtensaoArquivo;
    end;

    blnGerarNomeArquivo := False;

    try
      InStream  := TStringStream.Create(ABase64, TEncoding.ASCII);
      try
        OutStream := TFileStream.Create(IIF(not fEmptyStr(ANomeNovoArquivo), ANomeNovoArquivo, ANomeArquivo), fmCreate);
        try
          TNetEncoding.Base64.Decode(InStream, OutStream);
          Result := IIF(not fEmptyStr(ANomeNovoArquivo), ANomeNovoArquivo, ANomeArquivo);
        finally
          OutStream.Free;
        end;
      finally
        InStream.Free;
      end;
    except
      on E: EFCreateError do
      begin
        blnGerarNomeArquivo := True;
        blnTentarNovamente := True;
        strExcept := E.Message;
        Inc(intTentativas);
      end;

      on E: Exception do
      begin
        strExcept := E.Message;
        blnTentarNovamente := True;
        Inc(intTentativas);
      end
    end;

  until not blnTentarNovamente;
end;

function fEhArquivoBase64(const AstrArquivo: String): Boolean;
begin
  Result := fEmptyStr(ExtractFileExt(AstrArquivo));
end;

function fValidarEnderecoEmail(strEmail: String): Boolean;
  Const
    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];

    quoted_string_chars = [#0..#255] - ['"', #13, '\'];

    letters = ['A'..'Z', 'a'..'z'];
    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

  Type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
              STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
              STATE_SUBDOMAIN, STATE_HYPHEN);

  Var
    State: States;
    i, n, subdomains: integer;
    c: char;

begin
  State := STATE_BEGIN;

  n := Length(strEmail);
  i := 1;
  subdomains := 1;

  while (i <= n) do begin
    c := strEmail[i];

    case State of
    STATE_BEGIN:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_ATOM:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else if not (CharInSet(c, atom_chars)) then
        break;

    STATE_QTEXT:
      if c = '\' then
        State := STATE_QCHAR
      else if c = '"' then
        State := STATE_QUOTE
      else if not (CharInSet(c, quoted_string_chars)) then
        break;

    STATE_QCHAR:
      State := STATE_QTEXT;

    STATE_QUOTE:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else
        break;

    STATE_LOCAL_PERIOD:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_EXPECTING_SUBDOMAIN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else
        break;

    STATE_SUBDOMAIN:
      if c = '.' then begin
        inc(subdomains);
        State := STATE_EXPECTING_SUBDOMAIN
      end else if c = '-' then
        State := STATE_HYPHEN
      else if not (CharInSet(c, letters_digits)) then
        break;

    STATE_HYPHEN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else if c <> '-' then
        break;
    end;

    inc(i);
  end;

  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function fValidarEmail(strEmail: String; blnExibeAlerta: Boolean = True;
  strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
  blnEmailNfe: Boolean = True): Boolean;
  var
    i: Integer;
    stlEmails: TStringList;
begin
  Result := True;

  Try
    stlEmails := TStringList.Create();

    If (Pos(';', strEmail) > 0) Or ((Pos(',', strEmail) > 0)) Then Begin
      If (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ';') Or
        (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ',') Then
        stlEmails.CommaText := AnsiReplaceStr(Copy(Trim(strEmail), 1, Length(Trim(strEmail)) - 1), ';', ',')
      Else
        stlEmails.CommaText := AnsiReplaceStr(Trim(strEmail), ';', ',');
    End Else Begin
      stlEmails.Add(Trim(strEmail));
    End;

    For i := 0 To stlEmails.Count - 1 Do Begin
      If fEmptyStr(stlEmails[i]) And (Not blnPermiteEmBranco) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+'!', ['&OK']);
        End;

        Result := False;
      End Else If (Not fEmptyStr(stlEmails[i])) And (Not fValidarEnderecoEmail(stlEmails[i])) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe corretamente!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+' corretamente!', ['&OK']);
        End;

        Result := False;
      End;
    End;
  Finally
    FreeAndNil(stlEmails);
  End;
end;

function fOrdenarListaParaClausulaIN(const ALista: string): string;

  function fRemoveAspasExternas(const AString: string): string;
  var
    L: Integer;
  begin
    Result := Trim(AString);
    L := Length(Result);

    if L >= 2 then
    begin
      if ((Result[1] = '''') and (Result[L] = '''')) or
         ((Result[1] = '"')  and (Result[L] = '"')) then
        Result := Copy(Result, 2, L - 2);
    end;
  end;

  const
    chrSepara = ',';
  var
    SL: TStringList;
    SLAux: TStringList;
    I: Integer;
    strSep: String;
begin
  if (ALista = '') then
    Exit;

  SL    := TStringList.Create;
  SLAux := TStringList.Create;
  try
    SLAux.StrictDelimiter := True;
    SLAux.Delimiter := ',';
    SLAux.DelimitedText := StringReplace(ALista, ', "', ',"', [rfReplaceAll]);

    SL.Sorted := True;
    SL.Duplicates := dupIgnore;

    for I := 0 to SLAux.Count - 1 do
      SL.Add(fRemoveAspasExternas(SLAux[I]));

    Result := '';
    for I := 0 to SL.Count - 1 do
    begin
      strSep := '';
      If I > 0 Then
        strSep := ',';
      Result := Result + strSep + '"'+SL[I]+'"';
    end;
  finally
    SL.Free;
    SLAux.Free;
  end;
end;

{ TBatchReprocessarSaldo }

constructor TBatchReprocessarSaldo.Create;
begin
  inherited Create;

  FListaCmds := TObjectDictionary<UInt64, TList<string>>.Create([doOwnsValues]);
  FSemaphore := TCriticalSection.Create;
end;

destructor TBatchReprocessarSaldo.Destroy;
begin
  FListaCmds.Free;
  FSemaphore.Free;

  inherited;
end;

function TBatchReprocessarSaldo.fGetOrCreateLista(const AIdTransaction: UInt64): TList<string>;
begin
  if not FListaCmds.TryGetValue(AIdTransaction, Result) then
  begin
    Result := TList<string>.Create;
    FListaCmds.Add(AIdTransaction, Result);
  end;
end;

function TBatchReprocessarSaldo.fIncluiPontoVirgula(const ASQL: string): string;
begin
  Result := Trim(ASQL);
  if Result <> '' then
  begin
    if RightStr(Result, 1) <> ';' then
      Result := Result + ';';
  end;
end;

function TBatchReprocessarSaldo.fSQLInvalido(const ASQL: string): Boolean;
var
  LSQL: string;
begin
  LSQL := Trim(ASQL);
  Result := (LSQL = '') or (LSQL = ';');
end;

procedure TBatchReprocessarSaldo.Add(const AIdTransaction: UInt64; const ASQL: string; ACmdOri: boolean = False);
var
  Lista: TList<string>;
  Idx: Integer;
  LSQL: String;
begin
  FSemaphore.Enter;
  try
    LSQL := fIncluiPontoVirgula(ASQL);
    if fSQLInvalido(LSQL) then
      Exit;

    Lista := fGetOrCreateLista(AIdTransaction);

    if (ACmdOri) then
    begin
      LSQL := fMarcarListaRepAud('', TAG_CMDEXE_ORIGIN, mlraCmdOri) + LSQL;
    end
    else If fIteGerDevidamenteFormado(LSQL) or fCadLotDevidamenteFormado(LSQL) then
    begin
      //REMOVE DUPLICIDADE E O RECENTECE VIRA O MAIS NOVO
      Idx := Lista.IndexOf(LSQL);
      if Idx >= 0 then
        Lista.Delete(Idx);
    end;

    Lista.Add(LSQL);
  finally
    FSemaphore.Leave;
  end;
end;

function TBatchReprocessarSaldo.fIteGerDevidamenteFormado(const LSQL: String): Boolean;
begin
  Result := fCountOccurences('UPDATE', LSQL) = 1;
  Result := Result And (Pos(fFormataTagRepAud(TAG_REPAUD_CODITE, mlraIteGer), LSQL) > 0);
end;

function TBatchReprocessarSaldo.fCadLotDevidamenteFormado(const LSQL: String): Boolean;
begin
  Result := fCountOccurences('UPDATE', LSQL) = 1;
  Result := Result And (Pos(fFormataTagRepAud(TAG_REPAUD_NUMLOT, mlraCadLot), LSQL) > 0);
  Result := Result And (Pos(fFormataTagRepAud(TAG_REPAUD_CODITE, mlraCadLot), LSQL) > 0);
end;

procedure TBatchReprocessarSaldo.pUnifica(const AIdTransaction: UInt64);
var
  LLisOfTransact: TList<string>;
  LSQL: String;
  intIdx: Integer;

  LUpd: TStringList;
  LRpl: TStringList;

  LTemEntregaFutura,
  LTemEntregaFuturaTodasEmpresas: Boolean;

  LListaItegerCodIteTodasEmpresas,
  LListaIteGerCodIte,
  LListaIteGerCodEmp,

  LListaCadLotCodIteTodasEmpresas,
  LListaCadLotNumLotTodasEmpresas,
  LListaCadLotCodIte,
  LListaCadLotCodEmp,
  LListaCadLotNumLot: String;

  function fExecutaSQLFormatoOrignal(const LSQL: String): Boolean;
  begin
    Result := (Pos(fFormataTagRepAud(TAG_CMDEXE_ORIGIN, mlraCmdOri), LSQL) > 0);
  end;

  function fInformouEmpresa(const LSQL: String; aModoListaRepAud: TModListaRepAud): Boolean;
  begin
    Result := (Pos(fFormataTagRepAud(TAG_REPAUD_CODEMP, aModoListaRepAud), LSQL) > 0);
  end;

  function fReplaceReservaSaldo(const LSQL: String): Boolean;
  begin
    Result := (Pos('REPLACE', LSQL) > 0) And (Pos('RESERVA_SALDO_ATUALIZAR', LSQL) > 0);
  end;

  procedure pConcatena(const AValor: String; var ALista: String);
  var
    V: string;
  begin
    V := Trim(AValor);
    if (V <> '') then
    begin
      if (ALista <> '') then
        ALista := ALista + ',' + V
      else
        ALista := V;
    end;
  end;

begin
  LTemEntregaFutura              := False;
  LTemEntregaFuturaTodasEmpresas := False;

  LListaItegerCodIteTodasEmpresas := '';
  LListaIteGerCodIte              := '';
  LListaIteGerCodEmp              := '';

  LListaCadLotCodIteTodasEmpresas := '';
  LListaCadLotNumLotTodasEmpresas := '';
  LListaCadLotCodIte              := '';
  LListaCadLotCodEmp              := '';
  LListaCadLotNumLot              := '';

  if FListaCmds.TryGetValue(AIdTransaction, LLisOfTransact) then
  begin
    if LLisOfTransact.Count = 0 then
      Exit;

    LUpd := TStringList.Create;
    LRpl := TStringList.Create;
    try
      for intIdx := 0 to LLisOfTransact.Count - 1 do
      begin
        LSQL := LLisOfTransact[intIdx];

        if fExecutaSQLFormatoOrignal(LSQL) then
        begin
          LUpd.Add(fLimparMarcaRepAud(LSQL));
        end

        else if fReplaceReservaSaldo(LSQL) then
        begin
          LRpl.Add(LSQL);
        end

        else if fIteGerDevidamenteFormado(LSQL) then
        begin
          if fInformouEmpresa(LSQL, mlraIteGer) then
          begin
            if (not LTemEntregaFutura) then
              LTemEntregaFutura := Pos('_REPAEF', LSQL) > 0;

            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODITE, mlraIteGer), LListaIteGerCodIte);
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODEMP, mlraIteGer), LListaIteGerCodEmp);
          end
          else
          begin
            if (not LTemEntregaFuturaTodasEmpresas) then
              LTemEntregaFuturaTodasEmpresas := Pos('_REPAEF', LSQL) > 0;

            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODITE, mlraIteGer), LListaItegerCodIteTodasEmpresas);
          end;
        end

        else if fCadLotDevidamenteFormado(LSQL) then
        begin
          if fInformouEmpresa(LSQL, mlraCadLot) then
          begin
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_NUMLOT, mlraCadLot), LListaCadLotNumLot);
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODITE, mlraCadLot), LListaCadLotCodIte);
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODEMP, mlraCadLot), LListaCadLotCodEmp);
          end
          else
          begin
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_NUMLOT, mlraCadLot), LListaCadLotNumLotTodasEmpresas);
            pConcatena(fExtraiListaRepAud(LSQL, TAG_REPAUD_CODITE, mlraCadLot), LListaCadLotCodIteTodasEmpresas);
          end;
        end

        else
        begin
          LUpd.Add(LSQL); //EXECUTA COMO VEIO
        end;
      end;

      //ORDENAR TODAS AS LISTAS...
      LListaItegerCodIteTodasEmpresas := fOrdenarListaParaClausulaIN(LListaItegerCodIteTodasEmpresas);
      LListaIteGerCodIte              := fOrdenarListaParaClausulaIN(LListaIteGerCodIte);
      LListaIteGerCodEmp              := fOrdenarListaParaClausulaIN(LListaIteGerCodEmp);

      LListaCadLotCodIteTodasEmpresas := fOrdenarListaParaClausulaIN(LListaCadLotCodIteTodasEmpresas);
      LListaCadLotNumLotTodasEmpresas := fOrdenarListaParaClausulaIN(LListaCadLotNumLotTodasEmpresas);
      LListaCadLotCodIte              := fOrdenarListaParaClausulaIN(LListaCadLotCodIte);
      LListaCadLotCodEmp              := fOrdenarListaParaClausulaIN(LListaCadLotCodEmp);
      LListaCadLotNumLot              := fOrdenarListaParaClausulaIN(LListaCadLotNumLot);
      //...ORDENAR TODAS AS LISTAS

      //ITEGER...
      if (LListaItegerCodIteTodasEmpresas <> '') then
      begin
        LSQL :=
          ' UPDATE ITEGER '+
          '    SET ITE_REPAUD = "S" ' + IfThen(LTemEntregaFuturaTodasEmpresas, ' ,ITE_REPAEF = "S" ','') +
          '  WHERE TRUE ';

        LSQL := LSQL + ' AND ITE_CODITE IN ('+LListaItegerCodIteTodasEmpresas+') ';

        LUpd.Add(fNormalizeSQL(LSQL));
      end;

      if (LListaIteGerCodIte <> '') then
      begin
        LSQL :=
          ' UPDATE ITEGER '+
          '    SET ITE_REPAUD = "S" ' + IfThen(LTemEntregaFutura, ' ,ITE_REPAEF = "S" ','') +
          '  WHERE TRUE ';

        LSQL := LSQL + ' AND ITE_CODITE IN ('+LListaIteGerCodIte+') ';

        if (LListaIteGerCodEmp <> '') then
          LSQL := LSQL + ' AND ITE_CODEMP IN ('+LListaIteGerCodEmp+') ';

        LUpd.Add(fNormalizeSQL(LSQL));
      end;
      //...ITEGER

      //CADLOT...
      if (LListaCadLotNumLotTodasEmpresas <> '') then
      begin
        LSQL :=
          ' UPDATE CADLOT '+
          '    SET LOT_REPAUD = "S" '+
          '  WHERE TRUE ';

        LSQL := LSQL + ' AND LOT_NUMLOT IN ('+LListaCadLotNumLotTodasEmpresas+') ';
        LSQL := LSQL + ' AND LOT_CODITE IN ('+LListaCadLotCodIteTodasEmpresas+') ';

        LUpd.Add(fNormalizeSQL(LSQL));
      end;

      if (LListaCadLotNumLot <> '') then
      begin
        LSQL :=
          ' UPDATE CADLOT '+
          '    SET LOT_REPAUD = "S" '+
          '  WHERE TRUE ';

        LSQL := LSQL + ' AND LOT_NUMLOT IN ('+LListaCadLotNumLot+') ';
        LSQL := LSQL + ' AND LOT_CODITE IN ('+LListaCadLotCodIte+') ';

        if (LListaCadLotCodEmp <> '') then
          LSQL := LSQL + ' AND LOT_CODEMP IN ('+LListaCadLotCodEmp+') ';

        LUpd.Add(fNormalizeSQL(LSQL));
      end;
      //...CADLOT

      //LIMPA E NA SEQUÊNCIA REINSERE UNFICADO
      LLisOfTransact.Clear;

      for intIdx := 0 to LUpd.Count - 1 do
      begin
        LSQL := fIncluiPontoVirgula(LUpd[intIdx]);
        if fSQLInvalido(LSQL) then
          Continue;

        LLisOfTransact.Add(LSQL);
      end;

      if LRpl.Count > 0 then
      begin
        LLisOfTransact.Add(fOtimizaInsertReplaceMultiValue(LRpl.Text, []));
      end;

    finally
      LUpd.Free;
      LRpl.Free;
    end;
  end;
end;

procedure TBatchReprocessarSaldo.Execute(const AIdTransaction: UInt64; const AConexao: TUniConnection);
var
  LLisForExecute: TList<string>;
  LLisOfTransact: TList<string>;
  LQry: TUniQuery;
  intIdx: Integer;
  LSQL: string;
begin
  if not Assigned(AConexao) then
  begin
    raise Exception.Create('TBatchReprocessarSaldo.Execute AConexao = Nil');
    Exit;
  end;

  LLisForExecute := nil;

  FSemaphore.Enter;
  try
    if (FListaCmds.TryGetValue(AIdTransaction, LLisOfTransact)) then
    begin
      if (LLisOfTransact.Count > 0) then
      begin
        Self.pUnifica(AIdTransaction);

        LLisForExecute := TList<string>.Create;
        LLisForExecute.AddRange(LLisOfTransact);

        FListaCmds.Remove(AIdTransaction);
      end;
    end;
  finally
    FSemaphore.Leave;
  end;

  if Assigned(LLisForExecute) then
  begin
    try
      LQry := fCriaQuery(Nil, AConexao);
      try
        for intIdx := 0 to LLisForExecute.Count - 1 do
        begin
          LSQL := LLisForExecute[intIdx];
          try
            LQry.SQL.Text := LSQL;
            LQry.ExecSQL;
          except
            on E: Exception do
              raise Exception.Create('TBatchReprocessarSaldo.Execute '+E.Message);
          end;
        end;
      finally
        LQry.Free;
      end;
    finally
      LLisForExecute.Free;
    end;
  end;
end;

procedure TBatchReprocessarSaldo.Clear(const AIdTransaction: UInt64);
begin
  FSemaphore.Enter;
  try
    FListaCmds.Remove(AIdTransaction);
  finally
    FSemaphore.Leave;
  end;
end;

procedure TBatchReprocessarSaldo.ClearAll;
begin
  FSemaphore.Enter;
  try
    FListaCmds.Clear;
  finally
    FSemaphore.Leave;
  end;
end;

function TBatchReprocessarSaldo.CountCommands(const AIdTransaction: UInt64): Integer;
var
  LLisForExecute: TList<string>;
begin
  FSemaphore.Enter;
  try
    if FListaCmds.TryGetValue(AIdTransaction, LLisForExecute) then
      Result := LLisForExecute.Count
    else
      Result := 0;
  finally
    FSemaphore.Leave;
  end;
end;

function fSaldoItegerNegativo(const ACodIte, ACodEmp, AEntSai: String; out ASalFis: Double; out AMsgExc: String): Boolean;
  Var
    LqryAux: TUniQuery;
    LstrSQL: String;
Begin
  Result   := False;
  ASalFis := 0;

  If (AEntSai = 'S') Then
  Begin
    LqryAux := fCriaQuery(Nil);
    Try
      LstrSQL := 'ITEGER.ITE_SALDOS';
      If fCfgSis('BLOCAL', varBoolean) Then
        If fUsaQtdPendenteEntregaFutura Then
          LstrSQL := 'ITEGER.ITE_SALDOS + ' + fGetSQLSomaCamposEntregaFutura('ITEGER', True);

      LqryAux.SQL.Text := 'SELECT ' + LstrSQL + ' FROM ITEGER WHERE ITEGER.ITE_CODITE = :CODITE AND ITEGER.ITE_CODEMP = :CODEMP';
      LqryAux.ParamByName('CODITE').AsString := ACodIte;
      LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
      LqryAux.Open;

      If (Not LqryAux.IsEmpty) Then
      Begin
        ASalFis := LqryAux.Fields[0].AsFloat;
        Result := ASalFis < 0;

        If Result Then
        Begin
          AMsgExc := 'O saldo físico do item '+ACodIte+' ficará negativo ('+FormatFloat('#,##0.000', ASalFis)+') se essa operação for concluída! '+
                     'O sistema está configurado para notificar esta operação através das configurações [CFG_BLOABS] e [CFG_BLOSAL].'+
                     'Tente refazer o documento para confirmar se há disponibilidade de saldo na empresa '+ACodEmp+'.';
        End;
      End;

      LqryAux.Close;
    Finally
      FreeAndNil(LqryAux);
    End;
  End;
end;

function fRetornaXMLNFeBD(AChaveAcesso: string): String;
Var
  qryAux: TUniQuery;
begin
  if not fTabelaExiste('XMLNFE', True) then
    Exit;

  qryAux := fCriaQuery(Nil);
  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT NFE_ARQXML FROM XMLNFE ');
    qryAux.SQL.Add('WHERE NFE_ACESSO = :ACESSO ');
    qryAux.ParamByName('ACESSO').AsString := AChaveAcesso;
    qryAux.Open;

    Result := qryAux.FieldByName('NFE_ARQXML').AsString;

  Finally
    FreeAndNil(qryAux);
  End;
end;
function fSomarNovosImpostosDaReformaAoValorContabil : Boolean;
begin
  Result := False;
  If fCfgSis('REFCIS', varString) = 'N' Then
    Exit;
  If (fCfgSis('SIMPAU', varString) = 'S') And (fCfgSis('SIMHIB', varString) = 'N') Then
    Exit;
  Result := True;
end;

function fCampoSeqReformaRef(const ATabelaReforma: String): String;
begin
  // FDOREF liga no FATDOR por REF_SEQFDO; MOVREF e NOTREF por REF_SEQGER
  If ATabelaReforma = 'FDOREF' Then
    Result := 'REF_SEQFDO'
  Else
    Result := 'REF_SEQGER';
end;

function fSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
begin
  // Parcela de CBS + IBS + IS do item do pedido, como gravada pela trigger no FDOREF
  Result := fSqlValorReformaRef('FDOREF', AAutoincrementoFatDor);
end;

function fSqlValorReformaRef(const ATabelaReforma, AAutoincrementoDetalhe: String): String;
begin
  // Parcela " + CBS + IBS + IS" do item na tabela REF (FDOREF, MOVREF, NOTREF); vazia sem a reforma
  Result := '';
  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  Result := ' + (SELECT IFNULL(SUM(IFNULL(R.REF_CBSVAL, 0) + IFNULL(R.REF_VALIBS, 0) + IFNULL(R.REF_SELVAL, 0)), 0) ' +
            'FROM ' + ATabelaReforma + ' R WHERE R.' + fCampoSeqReformaRef(ATabelaReforma) + ' = ' + AAutoincrementoDetalhe + ') ';
end;

function fSqlCampoReformaRef(const ATabelaReforma, ACampo, AAutoincrementoDetalhe: String): String;
begin
  // Valor de um campo da tabela REF para o item; "0" sem a reforma
  Result := '0';
  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  Result := '(SELECT IFNULL(SUM(R.' + ACampo + '), 0) FROM ' + ATabelaReforma + ' R ' +
            'WHERE R.' + fCampoSeqReformaRef(ATabelaReforma) + ' = ' + AAutoincrementoDetalhe + ')';
end;

function fSafeFloatField(const ADataSet: TDataSet; const AFieldName : String): Double;
begin
  Result := 0;
  If Not Assigned(ADataSet) Then
    Exit;
  If Not ADataSet.Active Then
    Exit;
  If ADataSet.FindField(AFieldName) = Nil Then
    Exit;
  Result := ADataSet.FieldByName(AFieldName).AsFloat;
end;

initialization
  untTFatReservaSaldo.fncUsouBatchReprocessarSaldo := fUsouBatchReprocessarSaldo;
  FForSet := TFormatSettings.Create;
  FForSet.DecimalSeparator := '.';

end.

