unit untInterfaces;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Controls,
{$ENDIF}
{$IF Defined(UNIDAC)}
  Uni,
{$IFEND}
  SysUtils, Classes, StrUtils, DB;

{***************************************************************}
{*************************** ATENCAO ***************************}
{***************************************************************}
{* SEMPRE QUE FOR ADICIONAR UMA NOVA VARIAVEL A UMA ESTRUTURA  *}
{* EX: TDadosGerais, SEMPRE ADICIONAR APOS A ULTIMA VARIAVEL.  *}
{* QUANDO INSERIDA NO MEIO OCORRE DA libNfe.dll FICAR INCOMPA- *}
{* TIVEL COM autcom.exe / painelNfe.exe QUANDO NAO FOREM RECOM-*}
{* PILADOS, GERANDO ERROS COMO DUPLICIDADE DE ITENS, ETC...    *}
{***************************************************************}
Type
  IVirtualUIPrintPDF = interface
  ['{848BC206-4C09-4620-9746-41E66F71121A}']
    procedure PrintPDF(strFileName: String);
  end;

  TTipDfe = (CCe, CTe, NFe, NFCe, NFSe, CTeCancelamento, NFeCancelamento, NFCeCancelamento, NFSeCancelamento, ENulo);
  TTipoFrete = (tfCif, tfFob, tfTerceiros, tfSemFrete, tfTransporteProprioRemetente, tfTransporteProprioDestinatario);
  TOperacaoNFE = (opEnvio, opCancelamento, opProcessaEnvio,
    opProcessaCancelamento, opDownloadXML, opConfirmaEntradaMercadoria);
  TRetornoStatusNFE = (rsOperacional, rsParalisadoMomentaneamente,
    rsParalisadoSemPrevisao, rsErroGeral, rsTimeoutIntegrador, rsDPEC);

  {*****************************************}
  {* DADOS DE UMA DUPLICATA.               *}
  {**************************************MV*}
  TDuplicatas = class(TInterfacedObject, IInterface)
    strNumDup: String;
    dtaDtaVen: TDateTime;
    fltValDup: Double;
  End;

  TConfiguracoesInternas = Record
    strFitIntegradorImpressao: String;
    strPontoVenda: String;
    strUrlNFCe: String;

    blnMonitoramentoTempo: Boolean;
    strTpNfCr: String;
    blnCstIpiOutras: Boolean;
    blnFabNfe: Boolean;
    strImpIcmsOpeProprias: String;
    strImpPag: String;
    strImpOnu: String;

    strPatNES: String;
    strCliNES: String;
    strReEsTr: String;
    strNtOpNS: String;
    blnSimISS: Boolean;
    strIteTax: String;
    strEmpNFSe: String;
    blnImpLot: Boolean;
    blnMsgIaI: Boolean;
    blnAgrDup: Boolean;
    blnPDCNFE: Boolean;
    blnNFeDig: Boolean;
    blnNFeBar: Boolean;
    strTCrIcm: String;
    strNFSeSemCpf: String;
    blnUniTri: Boolean;
    blnZerIss: Boolean;
    strArqEnt: String;
    blnEmiEnt: Boolean;
    blnFcpAni: Boolean;
    blnImprimeAnotacoesItem: Boolean;
    strUTCFOP: String;
    blnComplInfAd: Boolean;
    blnZeraIBPT: Boolean;
    blnImpIBP: Boolean;

  End;

  TChaveReferenciada = class(TInterfacedObject, IInterface)
    strTipoChave: String;
    //Nota Fiscal
    strChaveAcessoNfe: String;
    strModeloDocFiscalNF: String;
    strCnpjEmitente: String;
    strUfIbgeEmitente: String;
    strSerieFiscal: String;
    strDocumentoFiscal: String;
    strAnoMesEmissao: String;
    //Cupom Fiscal
    strModeloDocFiscalIF: String;
    strNumOrdSequencialECF: String;
    strNumeroCOO: String;
    strNumeroSerieECF: String;
    strHashEntrega: String;
  end;

  {**************************************}
  {* REGISTRO REFERENTE AO ITEM MADEIRA *}
  {***********************************JC*}
  TDadosMadeira = class(TInterfacedObject, IInterface)
    fltQtdPec: Double;
    fltComPec: Double;
    fltLarPec: Double;
    fltEspPec: Double;
    strAparel: String;
    fltPerApa: Double;
    strBenefi: String;
    fltPerBen: Double;
    fltVlUnPc: Double;
  end;

  TIS = class(TInterfacedObject, IInterface)
    strCodigoCST: String; // Código de Situação Tributária do IS
    strClassTrib: String; // Código de Classificação Tributária do IS
    fltBase     : Double; // Base de Cálculo IS
    fltAliquota : Double; // Alíquota do IS
    fltValor    : Double; // Valor do IS
  end;

  TIBS_CBS = class(TInterfacedObject, IInterface)
    strCodigoCST: String; // Código de Situação Tributária do IBS e CBS
    strClassTrib: String; // Código de Classificação Tributária do IBS e CBS
    fltBase     : Double; // Base de Cálculo IBS e CBS
    fltValor    : Double; // Valor da operação
    fltTotal    : Double; // Total da operação
    fltValIBS   : Double; // Valor do IBS
  end;

  TCBS = class(TInterfacedObject, IInterface)
    fltAliquota: Double; // Alíquota do CBS
    fltValor   : Double; // Valor do CBS
    fltPerDif  : Double; // Percentual de Diferimento
    fltValDif  : Double; // Valor do Diferimento
    fltTriDev  : Double; // Tributo Devolvido
    fltPerRed  : Double; // Percentual Redução
    fltAlqEfe  : Double; // Alíquota Efetiva
  end;

  TIBS_UF = class(TInterfacedObject, IInterface)
    fltAliquota: Double; // Alíquota do IBS-UF
    fltValor   : Double; // Valor do IBS-UF
    fltPerDif  : Double; // Percentual de Diferimento
    fltValDif  : Double; // Valor do Diferimento
    fltTriDev  : Double; // Tributo Devolvido
    fltPerRed  : Double; // Percentual Redução
    fltAlqEfe  : Double; // Alíquota Efetiva
  end;

  TIBS_MUN = class(TInterfacedObject, IInterface)
    fltAliquota: Double; // Alíquota do IBS-MUN
    fltValor   : Double; // Valor do IBS-MUN
    fltPerDif  : Double; // Percentual de Diferimento
    fltValDif  : Double; // Valor do Diferimento
    fltTriDev  : Double; // Tributo Devolvido
    fltPerRed  : Double; // Percentual Redução
    fltAlqEfe  : Double; // Alíquota Efetiva
  end;

  TIBSCBS_TRIB_REGULAR = class(TInterfacedObject, IInterface)
    strCodigoCST  : String; // Código de Situação Tributária
    strClassTrib  : String; // Código de Classificação Tributária
    fltCBS_Alq    : Double; // Valor da alíquota da CBS
    fltCBS_Val    : Double; // Valor do Tributo da CBS
    fltIBS_UF_Alq : Double; // Valor da alíquota do IBS da UF
    fltIBS_UF_Val : Double; // Valor da alíquota do IBS da UF
    fltIBS_MUN_Alq: Double; // Valor da alíquota do IBS do Município
    fltIBS_NUM_Val: Double; // Valor do Tributo do IBS do Município
  end;

  TIBS_CBS_SEL_TOTAL = class(TInterfacedObject, IInterface)
    fltValorTotalBase       : Double; // Valor Total da BC do IBS e da CBS
    fltValorTotalIS         : Double; // Valor Total do Imposto Seletivo
    fltValorTotalIBS_UF     : Double; // Valor Total do IBS da UF
    fltValorTotalIBS_MUN    : Double; // Valor Total do IBS da MUN
    fltValorTotalGrupoIBS   : Double; // Valor Total do Grupo IBS
    fltValorTotalCBS        : Double; // Valor Total da CBS
    fltValorTotalDifCBS     : Double; // Valor Total Diferimento da CBS
    fltValorTotalDifIBS_UF  : Double; // Valor Total Diferimento do IBS da UF
    fltValorTotalDifIBS_MUN : Double; // Valor Total Diferimento do IBS da MUN
    fltValorTotalNFe        : Double; // Valor Total da NF-e com IBS / CBS / IS
  end;

  TCREDITO_DEBITO = class(TInterfacedObject, IInterface)
    strCodigoCST   : String;  // Código de Situação Tributária
    strClassTrib   : String;  // Código de Classificação Tributária
    strMesAno      : String;  // Ano e mês referência do período de apuração
    fltBasCal      : Double;  // Base de Cálculo
    fltAlqCBS      : Double;  // Alíquota do Tributo da CBS
    fltValCBS      : Double;  // Valor do Tributo da CBS
    fltAlqIBS      : Double;  // Alíquota do Tributo da IBS
    fltValIBS      : Double;  // Valor do Tributo da IBS
  end;

  TDadosReformaTributaria = class(TInterfacedObject, IInterface)
    IBS_CBS     : TIBS_CBS;
    SEL         : TIS;
    CBS         : TCBS;
    IBS_UF      : TIBS_UF;
    IBS_MUN     : TIBS_MUN;
    TRIB_REGULAR: TIBSCBS_TRIB_REGULAR;

    destructor Destroy; override;
  end;

  {*****************************************}
  {* DADOS DOCUMENTO DE IMPORTAÇÃO.        *}
  {**************************************MV*}
  TDocumentoImportacao = class(TInterfacedObject, IInterface)
    strNumeroDi: String;
    dtaDataDi: TDateTime;
    strLocalizacaoDesembaracao: String;
    strUFDesembaraco: String;
    dtaDataDesembaraco: TDateTime;

    fltBaseImpostoImportacao: Double;
    fltDespesasAduaneiras: Double;
    fltValorImpostoImportacao: Double;
    fltValorIOF: Double;
    fltSiscomex: Double;
    fltPisPasep: Double;
    fltCofins: Double;

    intViaTransporte: Integer;
    fltValorAFRMM: Double;
    intFormaIntermediacao: Integer;
    strCNPJAdquirente: String;
    strUFAdquirente: String;
    strPerfilAduaneiro: string;

    intAdicao: Integer;
    fltValAdp: Double;
  End;

  {*****************************************}
  {* DADOS DA EMPRESA EMITENTE DA NOTA.    *}
  {**************************************MV*}
  TDadosEmitente = class(TInterfacedObject, IInterface)
    strCnpj: String;
    strRazao: String;
    strFantasia: String;
    strEndereco: String;
    strNumeroEnd: String;
    strComplementoEnd: String;
    strBairro: String;
    strCodIbge: String;
    strUfIbge: String;
    strNomeCidade: String;
    strEstado: String;
    strCep: String;
    strCodigoPais: String;
    strNomePais: String;
    strTelefone: String;
    strIES: String;
    strIESST: String;
    strInscricaoMunicipal: String;
    strCNAEFiscal: String;
    strEMail: String;
    strFitOffLineLicenca: String;
    strFitOffLineCertJKS: String;
    strFitOffLineCertSenha: String;
    strFitOffLineIdToken: String;
    strFitOffLineNroToken: String;
    strFitAmbiente: String;
    strFitOffLinePath: String;
    strREGTRI: String;
  End;

  IDisparadorEventos = interface(IInterface)
    procedure RegistrarEvento(classe: TClass; evento: TNotifyEvent);
    procedure EnviarMensagem(classe: TClass; valor: TObject);
    procedure RemoverEvento(classe: TClass; evento: TNotifyEvent);
  End;

  TFormaPagamento = class(TInterfacedObject, IInterface)
    private
      function getIndPag: string;
    public
      strCodigo: String;
      fltValor:  Double;
      fltValPag: Double;
      strCodRed: string;
      strModCodMod: string;
      strCndPag: String;
      strTxPix : String;
      strEndToEndIdPix : String;
      dtaDtaPag: TDateTime;
      strCnpjFinanceira: String;
      strCnpjBeneficiario: String;

      property indPag: string read getIndPag;
  End;

  TFormaPagamentoInterna = class(TInterfacedObject, IInterface)
    public
      strTipCar: String;
      strCnpjOperadora: String;
      strNumAutorizacao: String;
      strBandeira: String;
      strCnpjBeneficiario: String;
  End;

  TItemNfComp = class(TInterfacedObject, IInterface)
    strCodIte: String;
    strDesIte: String;
    strCodFis: String;
    strClaFis: String;
    strUnidad: String;
    strClaIpi: String;
    strExcIpi: String;
    strCdCEST: String;
    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;
    fltBasRet: Double;
    fltAlqRet: Double;
    fltValRet: Double;
    fltBasIpi: Double;
    fltAlqIpi: Double;
    fltValIpi: Double;
    fltValCom: Double;
    strCstPis: String;
    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;
    strCstCof: String;
    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;
    fltBasDes: Double;
    fltPerFCP: Double;
    fltAlqUfd: Double;
    fltAlqIne: Double;
    fltPerPar: Double;
    fltValFCP: Double;
    fltValDes: Double;
    fltValOri: Double;
    fltBasFCP: Double;
    strAutInc: String;
    fltBasFcpST: Double;
    fltAlqFcpST: Double;
    fltValFcpST: Double;
    strCodLub: String;
    strDesANP: String;
    strCodFab: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    fltSICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;
    fltIcmsOP: Double;
    fltPerDif: Double;
    fltIcmDif: Double;
    documentoImportacao: TDocumentoImportacao;
  end;

  {*****************************************}
  {* DADOS GERAIS DA NOTA (CLIENTE, NUMERO,*}
  {* ETC).                                 *}
  {**************************************MV*}
  TDadosGerais = class(TInterfacedObject, IInterface)
    public
      strCodCli: String;
      strNomCli: String;
      strCnpj: String;
      strLogradouro: String;
      strNumeroEnd: String;
      strComplementoEnd: String;
      strBairro: String;
      strCodIbge: String;
      strUfIbge: String;
      strNomeCidade: String;
      strEstado: String;
      strCEP: String;
      strCodigoPais: String;
      strNomePais: String;
      strTelefone: String;
      strIES: String;
      strSuframa: String;
      strEmail: String;
      strEmail2: String;

      strNumDoc: String;
      strCodEmp: String;
      strClaFis: String;
      strDescricaoClaFis: String;
      strCondPagamento: String;
      strDesCondPagamento: String;
      strModeloNota: String;
      strSerie: String;
      dtaDtaEnt: TDateTime;
      dtaHorEnt: TDateTime;
      dtaDtaDoc: TDateTime;
      dtaHorDoc: TDateTime;
      fltBasIcm: Double;
      fltTotIcm: Double;
      fltBasRet: Double;
      fltTotRet: Double;
      fltTotIpi: Double;

      fltBasRetBkp: Double;
      fltTotRetBkp: Double;
      fltTotIpiBkp: Double;

      fltValPis: Double;
      fltTotPro: Double;
      fltTotFre: Double;
      fltDesEsp: Double;
      fltValCof: Double;
      fltDesAce: Double;
      fltTotGer: Double;

      strDocOriNC: String;
      strSerOriNC: String;
      strAceOriNC: String;
      strDesIteNC: String;
      dtaDtaOriNC: TDateTime;

      strMenNc01: String;
      strMenNc02: String;
      strMenNc03: String;
      strMenNc04: String;
      strMenNc05: String;
      strMenNc06: String;
      strMenNc07: String;
      strMenNc08: String;
      strMenNc09: String;
      strMenNc10: String;
      fltImpMer: Double;
      fltImpSeg: Double;
      fltImpImp: Double;
      fltImpPro: Double;
      fltImpTax: Double;
      fltImpPis: Double;
      fltImpCof: Double;
      strImpIC1: String;
      strImpIC2: String;
      strMsgAdicional: String;
      strMsgAdicionalCom: String;
      strMsgAdicionalFis: String;
      arrDuplicatas: Array Of TDuplicatas;
      intTipFre: TTipoFrete;
      strCgcTra: String;
      strNomTra: String;
      strIesTra: String;
      strEndTra: String;
      strCidTra: String;
      strEstTra: String;
      strPlaVei: String;
      strEstVei: String;
      intQtdTra: Integer;
      strEspTra: String;
      strMarTra: String;
      fltPesLiq: Double;
      fltPesBru: Double;
      strCodVen: String;
      strNomVen: String;
      strMen001: String;
      strMen002: String;
      strMen003: String;
      strMen004: String;
      strMen005: String;

      strEndTelPrc: String;
      strEndTelAle: String;

      fltTotSer: Double;
      fltValIss: Double;

      blnNfComp: Boolean;
      strMensagemAplicacao: String;
      strMensagemFiscalCNf: String;
      strPontoImpressao: String;
      blnImprimirDuplicatas: Boolean;

      fltBasIss: Double;
      fltBasIpi: Double;

      strDocsPD: String; // Nº dos Pedidos Confirmados
      blnImprimirDuplicatasConfCI: Boolean;

      strCliCon: String;
      strZonFra: String;

      fltBaseII: Double;
      fltDesAdu: Double;
      fltValIOF: Double;
      fltVaFRMM: Double;

      strCodObr: String;
      strCodArt: String;

      strCodAti: String;

      strRetIss: String;

      strCodIbgeEntrega: String;
      strUfIbgeEntrega : String;

      strEmaTra: String;
      strC_Antt: String;

      strIESUni: String;

      fltPisRet: Double;
      fltCofRet: Double;
      fltIrfRet: Double;
      fltCslRet: Double;

      fltPerIss: Double;

      fltVlSgSo: Double;

      strEspOriNC: String;
      strEmpOriNC: String;

      strInscMunicipal: String;

      strLogradouroEndEnt: String;
      strNumeroEndEnt: String;
      strComplementoEndEnt: String;
      strBairroEndEnt: String;
      strCEPEndEnt: String;

      strNumeroRpsSubstituto: String;
      strSerieRpsSubstituto: String;

      strRegimeTributacao: String; // (S)imples  /  Lucro (R)eal  /  Lucro (P)resumido

      fltImpPag: Double; // Valor do Imposto embutido no preço do produto Artigo n.º 1 da Lei 12.741/12, discriminado na Nota Fiscal.
      fltFedImp: Double;
      fltEstImp: Double;
      fltMunImp: Double;

      blnTransfIcms: Boolean;
      blnCreditoIcms: Boolean;
      strCodSit: String;

      blnEst_Dv: Boolean;

      arrChavesReferenciadas: Array Of TChaveReferenciada;

      strMicroEmpreendedor: String;
      strProdutorRural: String;
      strEspDoc: String;

      {***************************}
      {* USADO PELA CENTRO OESTE *}
      {************************FC*}
      blnIseIpi: Boolean;
      blnIsPiCo: Boolean;

      strStReEs: String;
      strPrStRe: String;

      fltIcmOrg: Double;
      blnOrgPub: Boolean;
      strOrPuRD: String;
      blnCalIcm: Boolean;

      strInfAdEnt : String;

      arrFormasPagamento: Array Of TFormaPagamento;
      strTip_FC: String;

      strNumPok: String;
      strPedSit: String;

      blnNotEsp: Boolean;

      strUFEmba: String;
      strLoEmba: String;
      strLocDes: String;

      strCodDig: String;
      strNomDig: String;

      blnComVal: Boolean;
      strOpcDoc: String;
      blnIndust: Boolean;

      blnVenPre: Boolean;

      strDisSer: String;

      blnComplementoIcms: Boolean;

      fltAlqIcm: Double;

      arrItensNfComp: Array Of TItemNfComp;

      strNumera: String;

      fltVrdIcm: Double;

      strBeneficioREIDI: String;

      blnEntFat: Boolean;

      blnComplementoValor: Boolean;

      blnRestituicaoIcms: Boolean;

      blnTemItemTigre: Boolean;

      fltReceitaBrutaNS: Double;

      strMatRev: String;

      strSitP_C: String;
      strMenP_C: String;

      strSitIPI: String;
      strMenIPI: String;
      strEnqIPI: String;

      fltBasFcpST: Double;
      fltAlqFcpST: Double;
      fltTotFcpST: Double;

      strAuxEntGer: String;

      fltPerFcpComplementoIcmsCapa : Double;
      fltValFcpComplementoIcmsCapa : Double;

      strPerfil: String;

      strStaOffLine: String;
      dtaDteOffLine: TDateTime;
      strXmlOffLine: String;
      strMsgOffLine: String;
      blnNFCeOffLine: Boolean;

      fltBasIcmSimples: Double;
      fltBasFcpComplementoIcmsCapa : Double;
      blnTemEscritorioCredenciado: Boolean;

      strVendedorOriginalPedido: String;
      strVendedorOriginalDocumentos: String;

      fltAliquotaIRRF,
      fltAliquotaCSLL,
      fltBasePIS,
      fltAliquotaPIS,
      fltBaseCOFINS,
      fltAliquotaCOFINS : Double;

      strEntFutOpc: String;      //CFG_ENFUOP no momento da emissão da NF
      fltTotIpiEntFut: Double;   //variável auxiliar, quando CFG_ENFUOP = 2
      fltTotRetEntFut: Double;   //variável auxiliar, quando CFG_ENFUOP = 2
      fltTotFcpSTEntFut: Double; //variável auxiliar, quando CFG_ENFUOP = 2

      strEscCre: String;

      strIdentificacaoIntermediadorTransacao: String; //identificacao do intermediador/marketplace
      strCnpjIntermediadorTransacao: String; //CNPJ do intermediador/marketplace

      strNumeroDrawback : String; // Número do ato concessionario de Drawback

      blnAtoDeclaratorioDF: Boolean;   //Decreto 34063/12 para o estado DF - Ato Declaratório?
      strMsgAtoDeclaratorioDF: String; //mensagem Decreto 34063/12 para o estado DF

      blnEstornoDeCredito: Boolean;

      strOrdMaoObraCli: String; // Ordem de Mão de Obra Cliente

      strDesativaTagsDesoneracao: String; // Cliente/Fornecedor enquadrado no art. 7º do Anexo XVIII da Parte II da Resolução SEFAZ nº 720/14, incluído pela Resolução SEFAZ nº 13/19 ?

      strOriundoOS: String; // Oriundo de Ordem de Serviço

      strNfCIAP: String;
      strCstIPI: String;
      strCstPIS: String;
      strCstCOF: String;

      strDesZon: String;

      strIprNum: String; // Informações de Processo Referenciado - Número Identificador do processo ou Ato Concessório
      strIprOri: String; // Informações de Processo Referenciado - Indicador da origem do processo
      strIprTip: String; // Informações de Processo Referenciado - Tipo do ato concessório

      strObsNFSOrdServ: String; // Observação NFS - Conserto de Equipamentos

      strMotDes: String;
      strEmp_TE: String;

      strNomCidEndEnt: String;
      strEstadoEndEnt: String;

      strNaturezaServico: String;
      arrChaveNFRefExportacao: Array of String;

      blnInconsistenciaEFD_Gravar: Boolean; //inconsistência da EFD Manaus (requisitos 257848 e 261120)
      strInconsistenciaEFD_RefNfe: String;
      strInconsistenciaEFD_InfAdc: String;
      strInconsistenciaEFD_Identi: String;
      strInconsistenciaEFD_Period: String;

      strCpfVen: String;

      strEmaTrr: String;

      blnComplementoDifal: Boolean;

      blnNFAjusteICMSaMaior: Boolean;

      blnComplementoStPerfilCnc: Boolean;

      strChaveAcessoOffLine: String;

      strEmails: String;

      strFormaPagamento: String;

      strNtOpNS: String;

      strBenCst: String;

      strNatSer: String;

      fltBasOrg: Double;
      fltBasVrd: Double;

      strNotasDeCupomComIPI: String;

      strConsum: String;

      strMotivoEstorno: String;

      strRegFis: String;

      strPaisEndEnt: String;
      strFoneEndEnt: String;
      strIDEstrangeiro: String;
      strTxPixRecebimento : String;
      strTxPixPedido : String;
      strCNPJEndEnt : String;
      strNotPau : String;
      strEndToEndIdPixPedido : String;
      strEndToEndIdPixRecebimento : String;
      strIESEndEnt : String;
      blnComplementoFrete: Boolean;
      strTemRefFis: String;
      strIdNFSeSub: String;
      strDevSim: String;
      fltPerIcm: Double;
      fltIcmsOP: Double;
      fltPerDif: Double;
      fltIcmDif: Double;
      fltVlrIcm: Double;
      blnEnviaEnderecoDeEntrega: Boolean;
      blnComplementoStPerfilTrs: Boolean;
      strMesAno: String;
      fltTotDescInc: Double;
      ReformaTributariaTotal: TIBS_CBS_SEL_TOTAL;
      strXCampo: String;
      strXTexto: String;
      ReformaTributariaCreditoDebito: TCREDITO_DEBITO;
      strFinalidade: String;
      strTipoDebito: String;
      strTipoCredito: String;
      strCodCno: String;
      dtaCompetencia: TDateTime;
      strRetPco: String;
      fltAlqPisRet: Double;
      fltAlqCofRet: Double;
      fltAlqCslRet: Double;
      strInsImo: String;
      strCodCib: String;
      blnDesativaSinief_08_2026: Boolean;
      blnDesativaDfeReferenciado: Boolean;
      fltValAdp: Double;
      blnReformaNoValorContabil: Boolean; // GER_VLRCON veio com CBS/IBS/IS (CFG_REFCIS)
      fltValorReformaContabil: Double;    // CBS + IBS + IS retirados do fltTotGer
      strEntGov: String;
      strTpOpEg: String;
      blnReformaSomadaNoVNF: Boolean;     // CFG_REFVNF: vNF mantem CBS/IBS/IS

      function fNotaSaida: Boolean;
      function fTipoChaveReferenciada(strEspDoc, strChaveAcesso: String): String;
      function fNotaCreditoICMS: Boolean;
      function fNotaComplementoICMS: Boolean;

      constructor Create;
      destructor Destroy; override;
  End;

  {*****************************************}
  {* DADOS DE UM ITEM DA NOTA.             *}
  {**************************************MV*}
  TDadosItem = class(TInterfacedObject, IInterface)
    strCodIte: String;
    strCdGTin: String;
    strCodFab: String;
    strCodBar: String;
    strDesIte: String;
    strClaIpi: String;
    strClaFis: String;
    strUnidad: String;
    fltQtdIte: Double;
    fltUnitar: Double;
    fltUniOri: Double;
    fltTotIte: Double;
    fltDesEsp: Double;
    fltQtdTri: Double;
    fltUniTri: Double;
    fltUniTrO: Double;
    strCodSit: String;

    strDesDes: String;
    strCodMar: String;
    strDesMar: String;
    strMenFis: String;

    fltBasIcm: Double;
    fltAlqIcm: Double;
    fltValIcm: Double;
    fltBasRet: Double;
    fltAlqRet: Double;
    fltValRet: Double;
    fltPerRed: Double;
    fltValIpi: Double;
    fltBasIpi: Double;
    fltAlqIpi: Double;
    strCodAbf: String;
    strMen__S: String;
    blnIncPis: Boolean;
    strCstPis: String;
    fltBasPis: Double;
    fltAlqPis: Double;
    fltValPis: Double;
    fltAlPisR: Double; // Alíquota do Pis em Reais
    strCstCof: String;
    fltBasCof: Double;
    fltAlqCof: Double;
    fltValCof: Double;
    fltAlCofR: Double; // Alíquita do Cofins em Reais

    strDesNes: String;
    strNumLot: String;
    strValLot: String;
    strAnotacoes: String;
    strDesFab: String;

    strCod_Nf: String;
    strDes_Nf: String;

    fltBARTSP: Double;
    fltVLRTSP: Double;
    fltICOPPR: Double;

    strDiferi: String;

    fltTotFre: Double;
    fltDesAce: Double;

    documentoImportacao: TDocumentoImportacao;

    strCodSLC: String;
    strTriMun: String;

    strCodListaServ: String;

    strPedCom: String;
    strNItemPed: String;

    strImpDir: String;

    dadosMadeira: TDadosMadeira;
    strCodLub: String;
    strCodOnu: String;
    strDesOnu: String;
    strCodigo: String;
    strClaRis: String;
    strGruEmb: String;

    fltTotPes: Double;
    strCSTIpi: String;

    strNumFCI: String;

    strRICMPR: String;

    strLocFis: String;

    strCodigoTinta: String;

    strInfGar: String;    

    fltPRedST: Double; //Percentual Reducao Base ST
    fltValIva: Double; //IVA Saida ST

    strDocRemessaConcreto: String; //Prestcon
    fltImpPag: Double;
    fltFedImp: Double;
    fltEstImp: Double;
    fltMunImp: Double;
    strExcIpi: String;
    fltPerDevolvido: Double;

    strRIcmPRAbf: String;
    strCodigoCEST: String;
    strCodIteOriginal: String;

    fltBaseUfDestino: Double;
    fltPercentualFCP: Double;
    fltAliquotaDestino: Double;
    fltAliquotaInterestadual: Double;
    fltPercentualPartilha: Double;
    fltValorFCP: Double;
    fltValorIcmsDestino: Double;
    fltValorIcmsOrigem: Double;

    fltBaseCalculoReduzidaDestino: Double; //SEM FUNÇÃO, ENTRETANTO, MANTER POR QUESTÃO DE COMPATIBILIDADE REQ.: 74126

    strCoiCmp: String; // Código do item no cliente que solicitou a mercadoria (concatenada a descrição na Tag xProd)

    fltIcmOrg: Double;
    strAutInc: String;

    fltVrdIcm: Double;
    strMtdIcm: String;
    strProPCD: String;

    strEnqIpi: String;
    strUnTrib: String;
    strForIte: String;
    strIndEsc: String;
    strCnpFab: String;
    strDesANP: String;
    fltBaseFCP: Double;
    strEniEcb: String;
    strCdbFis: String;
    fltBaseFCPST: Double;
    fltPercentualFCPST: Double;
    fltValorFCPST: Double;
    fltAlqCreIcmSimples: Double;
    fltValCreIcmSimples: Double;

    fltPICMEF: Double;
    fltBICMEF: Double;
    fltAICMEF: Double;
    fltVICMEF: Double;
    fltBSTANT: Double;
    fltVSTANT: Double;
    blnPromocao: Boolean;
    fltPerBas: Double;
    fltSICMEF: Double;
    strIndRev: String;
    fltAlqFin: Double;

    fltValIpiDadosAdicionais: Double;

    strChaveAcesso: string;
    fltQtItCo: Double;

    strRefere: string;
    strUni_NF: String;

    fltVDesST: Double;
    strMDesST: String;
    strAplica: String;
    strCForDi: String;
    strNumDrw: String;

    strFabLot: String;
    blnMedicamento: Boolean;
    strCodPrdAnvisa: String;
    strMotIseAnvisa: String;

    strCnaeFiscal: String;

    strFcpProprio: String;

    strCodFor: String;

    strServicoTributavel: String;

    strComple: String;

    strNum_DI: String;

    fltValDif: Double;

    strNumLotDtaVal: String;

    fltEnvPre: String;
    strCodPre: String;
    fltPerPre: Double;
    fltValPre: Double;
    fltPerIcm: Double;
    fltIcmsOP: Double;
    fltPerDif: Double;
    fltIcmDif: Double;
    fltVlrIcm: Double;
    fltVimRet: Double;

    strCodNBS: String;

    blnRastreavel: Boolean;

    ReformaTributaria: TDadosReformaTributaria;

    strSerClaTri: String;
    strSerIndOpe: String;

    fltIBPT_F: Double;
    fltIBPT_E: Double;
    fltIBPT_M: Double;

    strNfsNat: String;

    strIteRef: String;
    strChvRef: String;
    fltVlrCon: Double;
    fltBimRet: Double;
    fltAimRet: Double;

    destructor Destroy; override;
  End;

  IFonteDados = Interface(IInterface)
    procedure pCarregarDados;
    procedure pInicio;
    function fDadosEmitente: TDadosEmitente;
    function fDadosGerais: TDadosGerais;
    function fTemDados: Boolean;
    function fProximoItem: TDadosItem;

    function fChaveAcesso: String;
    function fNotaServicoEletronica: Boolean;
    function fNotaServicoEletronicaConcreto: Boolean;

    function fRetornaEstadoEmpresa(strCnpj: String): String;
    procedure pCarregaConfiguracoes;

    function fSuportaOperacaoBanco: Boolean;
    function fExecutaQuery(strSQL: String; arrParametros: Array Of String; arrValores: Array Of Variant): TDataSet;
    function fCampoExiste(const strTabela, strCampo: String): Boolean;
    function fTabelaExiste(strNomeTabela: String): Boolean;
    procedure pCarregaConfiguracoesInternas(Var objConfig: TConfiguracoesInternas);
    procedure pSalvarXMLNFeBD(AChaveAcesso, AXML: string; AXMLJaBaixado: String = '');
    function XMLJaBaixado(AChaveAcesso: string): Boolean;
    function fGetCampoValor(strCampoRetorno, strCampoChave, strValorChave, strTabela: String): String;
    procedure pNFCeOffLineConfiguracoes(strCodEmp: String);
    function fChaveTabela: String;
    procedure pGravaTabela(objItem: TDadosItem; strTabela: String);
    procedure pGravaIcmsDesonerado(strTabela, strAutInc, strMtdIcm: String; fltIcmDes: Double);
    function fConfiguracaoExiste(strCodCfg: String): Boolean;
    function PDFJaBaixado(AChaveAcesso: string): Boolean;
    procedure pSalvarPDFNFeBD(AChaveAcesso, APDF: string; APDFJaBaixado: String = '');
    function fUsaNotaServicoEletronicaEnotas: Boolean;
    function CarregarPDF(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean): string;
    procedure pGravarLogNfe(strNumDoc, strEspDoc, strCodEmp, strSerie,
                            strCodCli, strTip_FC, strStatus, strObserv: String;
                            strChaAce: String=''; dtaDtaAut: TDateTime=0; strPonImp: String='');
    procedure pAtualizaDadosAutorizacaoNFe(Const strChaveAcesso, strProtocolo, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    function fRetornaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String): Boolean;
    procedure pGravaDocumentoImpresso(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC: String);
    procedure pGravaDocumentoPainelCitel(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli, strTip_FC, strProtoc, strTipInt: String);
    procedure pSalvarXmlDfeBD(ATipDfe, AChaveAcesso, AProtocolo, AXml: string);
    procedure pSetaIndicadorIntegracaoCitel(const AstrIntegradorCitel: String='S');
    procedure pSetaPathSatCitel(const AstrPathSatCitel: String='');
    procedure pGravarLogFit(strNumDoc, strEspDoc, strCodEmp, strSerie_, strForCli, strTip_FC, strTipArq, strArquiv: String);
    procedure pAtualizaDataDeAutorizacao(strNumDoc, strEspDoc, strCodEmp, strSerie, strCodCli: String);
    function GetTemPerfilAduaneiro: Boolean;
    {$IF Defined(UNIDAC)}
    function fRetDataBase: TUniConnection;
    {$IFEND}
  End;

  TLogPerformance = class(TInterfacedObject)
    strOrigem,
    strNumDoc,
    strEspDoc,
    strCodEmp,
    strCodCli,
    strSerie,
    strTipFc: String;
    dtaHoraInicial,
    dtaHoraFinal: TDateTime;
    intCodigo: Integer;
    strMensagem: String;
  End;

  TRetornoNFE = class(TInterfacedObject, IInterface)
    private
      FSucesso: Boolean;
      FMensagem: String;
      FChaveAcesso: String;
      FNumeroProtocolo: String;
      FContigencia: Boolean;
      FDataAutorizacao: TDateTime;
      FAguardando: Boolean;
      FDenegada: Boolean;
      FCancelada: Boolean;
      FInutilizada: Boolean;
      FEncerrada: Boolean;
      FQRCode: String;
      FDataEmissao: TDateTime;
      FNumeroSerieSAT: String;
      FNumeroCFe: String;
      FObsFisco: String;
      FRecusadaRejeitada: Boolean;
      FOffLine: Boolean;
      FContingenciaAutorizada: String;
      FErroImpressao: Boolean;
      FProtMsg: String;
      FProtocoloManifesto: String;
      FModeloManifesto: String;
      FDataHoraManifesto: String;
      FProtocoloConhecimento: String;
      FModeloConhecimento: String;
      FDataHoraConhecimento: String;
    public
      constructor Create(blnSucesso: Boolean; strMensagem, strChaveAcesso,
        strNumeroProtocolo: String; blnOffLine:Boolean=False);
      class function fCriaRetornoAguardando: TRetornoNFE;
      class function fCriaRetornoErro(strMensagem: String): TRetornoNFE;
      class function fCriaRetornoSucesso(strMensagem, strChaveAcesso,
        strProtocolo: String; dtaDtaAut: TDateTime): TRetornoNFE;
      class function fCriaRetornoContingencia(strMensagem: String): TRetornoNFE;
      class function fCriaRetornoDenegada(strMensagem: String): TRetornoNFE; overload;
      class function fCriaRetornoDenegada(strMensagem, strAcesso: String): TRetornoNFE; overload;
      class function fCriaRetornoCancelada(strProtocolo: String; blnSucesso:Boolean=False): TRetornoNFE;
      class function fCriaRetornoInutilizada(strProtocolo: String): TRetornoNFE;
      class function fCriaRetornoEncerrada(strMensagem, strChaveAcesso,
        strProtocolo: String; dtaDtaAut: TDateTime): TRetornoNFE;
      class function fCriaRetornoManifesto(var objRetornoNFE: TRetornoNFE;
        strProtocolo, strModelo, strDataHora: String): TRetornoNFE;

      function Sucesso: Boolean;
      function Mensagem: String;
      function ChaveAcesso: String;
      function NumeroProtocolo: String;
      function Contingencia: Boolean;
      function DataAutorizacao: TDateTime;
      function Aguardando: Boolean;
      function Denegada: Boolean;
      function Cancelada: Boolean;
      function Inutilizada: Boolean;
      function Encerrada: Boolean;
      function QRCode: String;
      function DataEmissao: TDateTime;
      function NumeroSerieSAT: String;
      function NumeroCFe: String;
      function ObsFisco: String;

      procedure SetaComoSucesso;
      procedure SetaComoNaoSucesso;
      procedure SetContingencia(blnContingencia: Boolean);
      procedure SetQRCode(Valor: String);
      procedure SetDataEmissao(Valor: TDateTime);
      procedure SetNumeroSerieSAT(Valor: String);
      procedure SetNumeroCFe(Valor: String);
      procedure SetObsFisco(Valor: String);
      procedure SetOffLine(blnOffLine: Boolean);
      procedure SetContingenciaAutorizada(strContingenciaAutorizada: String);

      procedure SetRecusadaRejeitada;
      function RecusadaRejeitada: Boolean;
      function OffLine: Boolean;
      function ContingenciaAutorizada: String;
      procedure SetaErroImpressao(const strMensagem: string);
      function ErroImpressao: Boolean;
      function ProtMsg: String;
      procedure SetProtMsg(strProtMsg: String);

      function ProtocoloManifesto: String;
      function ModeloManifesto: String;
      function DataHoraManifesto: String;

      function ProtocoloConhecimento: String;
      function ModeloConhecimento: String;
      function DataHoraConhecimento: String;

      class function fCriaRetornoConhecimento(var objRetornoNFE: TRetornoNFE;
        strProtocolo, strModelo, strDataHora: String): TRetornoNFE;
  End;

  TResultadoValidacao = class(TObject)
    private
      stlErros: TStringList;
      function GetErros(intIndice: Integer): String;
      function GetExceptions(intIndice: Integer): Exception;
      function GetCount: Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure pAdicionarErro(strMensagem: String; objErro: Exception);
      function fValido: Boolean;

      property intCount: Integer Read GetCount;
      property strErros[intIndice: Integer]: String Read GetErros;
      property objExceptions[intIndice: Integer]: Exception Read GetExceptions;
  End;

  TRetornoConsultaCadastro = class
  private
    FCodCidade: String;
    FComplemento: String;
    FEndereco: String;
    FNomeFantasia: String;
    FCnae: String;
    FBairro: String;
    FCpfCnpj: String;
    FCEP: String;
    FNumero: String;
    FIE: String;
    FRazaoSocial: String;
    FHabilitado: Boolean;
    FDescSituacao: String;
    FDataAbertura: TDate;
    FDataNascimento: TDate;
    FDataInscricao: TDate;
    FDigitoVerificador: String;
    FSituacaoSimples: String;
    FSituacaoSimei: String;
    FOptanteSimples: Boolean;
    FDescSituacao2: String;
    FDescSituacao3: String;
  public
    property strRazaoSocial: String read FRazaoSocial write FRazaoSocial;
    property strNomeFantasia: String read FNomeFantasia write FNomeFantasia;
    property strIE: String read FIE write FIE;
    property strEndereco: String read FEndereco write FEndereco;
    property strNumero: String read FNumero write FNumero;
    property strComplemento: String read FComplemento write FComplemento;
    property strBairro: String read FBairro write FBairro;
    property strCEP: String read FCEP write FCEP;
    property strCodCidade: String read FCodCidade write FCodCidade;
    property strCpfCnpj: String read FCpfCnpj write FCpfCnpj;
    property strCnae: String read FCnae write FCnae;
    property blnHabilitado: Boolean read FHabilitado write FHabilitado;
    property strDescSituacao: String read FDescSituacao write FDescSituacao;
    property dtaDataAbertura: TDate read FDataAbertura write FDataAbertura;
    property dtaDataNascimento: TDate read FDataNascimento write FDataNascimento;
    property dtaDataInscricao: TDate read FDataInscricao write FDataInscricao;
    property strDigitoVerificador: String read FDigitoVerificador write FDigitoVerificador;
    property strSituacaoSimples: String read FSituacaoSimples write FSituacaoSimples;
    property strSituacaoSimei: String read FSituacaoSimei write FSituacaoSimei;
    property blnOptanteSimples: Boolean read FOptanteSimples write FOptanteSimples;
    property strDescSituacao2 : String read FDescSituacao2 write FDescSituacao2;
    property strDescSituacao3 : String read FDescSituacao3 write FDescSituacao3;
  end;

  TRetornoCartaCorrecao = class
  private
    FProtocolo: String;
    FMensagem: String;
  public
    property strProtocolo: String read FProtocolo write FProtocolo;
    property strMensagem:  String read FMensagem  write FMensagem;
  end;

  INFE = Interface(IInterface)
    function fEnviarNota: Boolean;
    function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
    function fProcessarEnvio: TRetornoNFE;
    function fProcessarCancelamento: TRetornoNFE;

    function fMensagemErro: String;

    procedure pSetaDadosEmitente(dadosEmitente: TDadosEmitente);
    procedure pSetaDadosGerais(dadosGerais: TDadosGerais);
    procedure pAdicionaItem(dadosItem: TDadosItem);

    function fVerificarStatusNota: Boolean;
    function fProcessarStatusNota: TRetornoNFE;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE; overload;

    procedure pReimprimeDanfe(strChaveAcesso: String); overload;

    function fSuportaFuncoesAdministrativas: Boolean;
    procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer);
    procedure pReimprimeDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = ''); overload;
    procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
      strNumeroFinal, strDescricao: String);

    function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
      intTipo, intStatus: Integer): TStringList;
    function fRetXmlNfe(strChaveAcesso: string): string;
    function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
    function fEnviaNFCeXmlOffLine: Boolean;
    function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

    function fCarregaNfePdf(AChaveAcesso, ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;

    function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

    procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

    function fConsultaStatusDFe(strChaveAcesso: string): String;
    function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

    function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

    function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
    function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
  End;

  INFEService = Interface(IInterface)
    function fEnviarNota: Boolean;
    function fCancelarNota(strNumDoc, strSerie, strMotivo: String): Boolean;
    function fProcessarEnvio: TRetornoNFE;
    function fProcessarCancelamento: TRetornoNFE;

    function fVerificarStatusNota(strNumDoc, strSerie: String): Boolean;
    function fProcessarStatusNota: TRetornoNFE;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String): TRetornoStatusNFE; overload;

    procedure pReimprimirDanfe(strChaveAcesso: String);
    function fRetXmlNfe(strChaveAcesso: string): string;
    function fEnviaNFCeXmlOffLine: Boolean;
    function fConfirmacaoOperacaoEntradaMercadoria(strChaveAcesso: string): string;

    function fVerificarStatusServico(strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string): TRetornoStatusNFE; overload;

    procedure pGerarXmlCitel(ANumeroNSe, ANumeroRPS, ASerieRPS, AChaveAcesso: String);

    function fConsultaStatusDFe(strChaveAcesso: string): String;
    function fConsultaStatusInutilizado(const strCnpjEmitente, strNumeroSerie, strNumeroDocumento : String; const strModeloFiscal : String = '55') : String;

    function fConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strDocumentoRecebedor, strNomeRecebedor, strLatitude, strLongitude, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoConfirmacaoDeEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;

    function fInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoInsucessoNaEntrega(strNumDoc, strEspDoc, strCodEmp, strSerie: String): TRetornoNFE;
    function fConsultaStatusCancelamento(const strNumDoc, strEspDoc, strCodEmp, strSerie: String): String;
  End;

  INFEAdministrativoService = Interface(IInterface)
    function fSuportaFuncoesAdministrativas: Boolean;
    procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer);

    procedure pReimprimirDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');

    procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
      strNumeroFinal, strDescricao: String);

    function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
      intTipo, intStatus: Integer): TStringList;
    function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;

    function fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string;
      AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;

    function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;
  End;

Type
  TTipoImpressao = (tiNfeImpressao, tiPadrao);
  IManifestoEletronicoSerivce = Interface(IInterface)
    function fEnviarManifesto(strNumeroManifesto: String): Boolean;
    function fProcessarManifesto(strNumeroManifesto: String): TRetornoNFE; overload;
    function fProcessarManifesto(strNumeroManifesto: String; strImpressora: String): TRetornoNFE; overload;
    procedure pImprimirManifesto(strNumeroManifesto: String); overload;
    procedure pImprimirManifesto(strNumeroManifesto: String; strImpressora: String); overload;
    function fEncerrarManifesto(strNumeroManifesto: String): Boolean;
    function fCancelarManifesto(strNumeroManifesto, strJustificativa: String): Boolean;
    function fEnviarDocsCarregadosManifesto(strNumeroManifesto, strListaAutoIncrem: String): Boolean;
    function fEnviarManifestoEventoPagamento(strNumeroManifesto: String): Boolean;
  End;

  IEnviarArquivosService = Interface(IInterface)
    function fEnviarXMLSat(strArqXML: String): TRetornoNFE;
    function fEnviarXMLSatWithModeSoap(strArqXML: String; strModeEnvSoap: String): TRetornoNFE;
  End;

  IVerificarStatusServicoService = Interface(IInterface)
    function fVerificarStatusServicoPelaUF(const strUF: string; var strRetornoConsulta: string; strModeEnvSoap: String='0'): TRetornoStatusNFE;
  End;

  IAmbienteEmpresaService = Interface(IInterface)
    function fCodigoEmpresaNaFit: string;
  End;

  IImportaXMLTerceirosArquivosService = Interface(IInterface)
    function fRetornaListaChavesAcessoTerceirosPeriodo(const strCodEmp: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
    function fRetXMLNfe(const strChaveAcesso: string): string;
    function fRetornaListaChavesAcessoCTeTerceirosPeriodo(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
    function fRetXMLCTe(const strChaveAcesso: string): string;
  End;

  IAuditarDocumentoServiceFIT = Interface(IInterface)
    function fRetornaListaCanceladasPorDataCancelamento(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime; const tdfTipDFe: TTipDfe): string;
    function fConsultaSituacaoInutilizacaoTraduzido(const strCnpj_, strSerie_, strNumDoc: String): TRetornoNFE;
    function fConsultaStatusDFeTraduzido(const strChaAce: String): TRetornoNFE;
  End;

Type
  IConhecimentoEletronicoService = Interface(IInterface)
    function fEnviarConhecimento(strNumeroConhecimento: String): Boolean;
    function fProcessarConhecimento(strNumeroConhecimento: String): TRetornoNFE;
    procedure pImprimirConhecimento(strNumeroConhecimento: String; strForcarImpressaoPDF: String = 'N');
    function fCancelarConhecimento(strNumeroConhecimento, strJustificativa, strNomeUsuario: String): Boolean;
    function fInsucessoNaEntrega(strNumeroConhecimento, strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoInsucessoNaEntrega(strNumeroConhecimento: String): TRetornoNFE;
    function fConfirmacaoDeEntrega(strNumeroConhecimento, strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoConfirmacaoDeEntrega(strNumeroConhecimento: String): TRetornoNFE;
  End;

  IEventoConciliacaoFinanceiraService = Interface(IInterface)
    function fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao: String): string;
  End;

  TAbstractAdministrativoService = class(TInterfacedObject, INFEAdministrativoService)
    function fSuportaFuncoesAdministrativas: Boolean;
    procedure pEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer);

    procedure pReimprimirDanfe(strChaveAcesso, strImpressora: String; strImprimirTelaPDF: String = '');

    procedure pInutilizarNumeros(strAno, strSerie, strNumeroInicial,
      strNumeroFinal, strDescricao: String);

    function fListagemNotas(strCodEmp: String; dtaDtaIni, dtaDtaFin: TDateTime;
      intTipo, intStatus: Integer): TStringList;
    function fConsultaCadastro(strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;

    function fCarregarNfePdf(AChaveAcesso, ANomeArquivo: string;
      AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;

    function fEnviaCartaCorrecao(strChaveAcesso: String; stlCorrecoes: TStringList;
      strImpressora: String; intSequencial: Integer): TRetornoCartaCorrecao;
  End;

  ErroConsultaCadastro = class(Exception)
  end;

  {*****************************************}
  {* EXCEÇÕES DO SISTEMA.                  *}
  {**************************************MV*}
  ErrosValidacaoNFE = class(Exception)
    private
      FOffLine: Boolean;
      FResultadoValidacao: TResultadoValidacao;
    public
      constructor Create(strMensagem: String; resultadoValidacao: TResultadoValidacao; blnNFCeOffLine: Boolean=False);
      function ResultadoValidacao: TResultadoValidacao;
      function NFCeOffLine: Boolean;
      class function fCriaErroSimples(strMensagem: String): ErrosValidacaoNFE;
      property blnOffLine: Boolean read FOffLine write FOffLine;
  End;

  TRetornoEnotas = class
  private
    FCodigo: String;
    FMensagem: String;
    FStatus: String;
    FTipo: String;
    FChaveAcesso: String;
    FProtocolo: String;
    FNumRps: String;
    FUltimoRetorno: WideString;
  public
    property strCodigo: String            read FCodigo        write FCodigo;
    property strMensagem: String          read FMensagem      write FMensagem;
    property strStatus: String            read FStatus        write FStatus;
    property strTipo: String              read FTipo          write FTipo;
    property strChaveAcesso: String       read FChaveAcesso   write FChaveAcesso;
    property strProtocolo: String         read FProtocolo     write FProtocolo;
    property strNumRps: String            read FNumRps        write FNumRps;
    property strUltimoRetorno: WideString read FUltimoRetorno write FUltimoRetorno;
  end;

  TTotalServico = class
    public
      fltPerIss: Double;
      fltValIss: Double;
      fltIssRet: Double;
      fltValLiq: Double;
      fltOutRet: Double;
      fltValDed: Double;
      strRecBru: String;
      strRespRet: String;
  end;
 {$IF Defined(VER180)}
 {$ELSE}
  TOnNotificarProgresso = reference to procedure(AMsg: string);
 {$IFEND}

Const
  DOCUMENTO_REF_NFe_Modelo_55             = '0';
  DOCUMENTO_REF_NF_Modelo_1_1A            = '1';
  DOCUMENTO_REF_NFP_Nota_Fiscal_Produtor  = '2';
  DOCUMENTO_REF_Cte                       = '3';
  DOCUMENTO_REF_ECF                       = '4';
  DOCUMENTO_REF_NFCE                      = '5';

  Var
  CFOP_DEVOLUCAO_FORNECEDOR_NFE: String = '5201_6201_5202_6202_5410_6410_5411_6411_5949_6949_5206_6206_';

implementation

{ TRetornoNFE }

function TRetornoNFE.Contingencia: Boolean;
begin
  Result := FContigencia;
end;

function TRetornoNFE.ContingenciaAutorizada: String;
begin
  Result := FContingenciaAutorizada;
end;

constructor TRetornoNFE.Create(blnSucesso: Boolean; strMensagem,
  strChaveAcesso, strNumeroProtocolo: String; blnOffLine:Boolean=False);
begin
  FSucesso         := blnSucesso;
  FMensagem        := strMensagem;
  FChaveAcesso     := strChaveAcesso;
  FNumeroProtocolo := strNumeroProtocolo;
  FContigencia     := False;
  FAguardando      := False;
  FDenegada        := False;
  FCancelada       := False;
  FInutilizada     := False;
  FDataEmissao     := 0;
  FNumeroSerieSAT  := '';
  FNumeroCFe       := '';
  FProtMsg         := '';
  FRecusadaRejeitada := False;
  FOffLine         := blnOffLine;
  FContingenciaAutorizada := 'N';
  FErroImpressao := False;
end;

function TRetornoNFE.DataAutorizacao: TDateTime;
begin
  Result := FDataAutorizacao;
end;

function TRetornoNFE.DataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

function TRetornoNFE.DataHoraConhecimento: String;
begin
  Result := FDataHoraConhecimento;
end;

function TRetornoNFE.DataHoraManifesto: String;
begin
  Result := FDataHoraManifesto;
end;

function TRetornoNFE.Denegada: Boolean;
begin
  Result := FDenegada;
end;

function TRetornoNFE.Encerrada: Boolean;
begin
  Result := FEncerrada;
end;

function TRetornoNFE.ErroImpressao: Boolean;
begin
  Result := FErroImpressao;
end;

class function TRetornoNFE.fCriaRetornoAguardando: TRetornoNFE;
begin
  Result := TRetornoNFE.Create(False, 'Aguardando retorno do integrador.', '', '');
  Result.FAguardando := True;
end;

class function TRetornoNFE.fCriaRetornoCancelada(
  strProtocolo: String; blnSucesso:Boolean=False): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(blnSucesso, 'Nota cancelada.', '', strProtocolo);
  Result.FCancelada := True;
end;

class function TRetornoNFE.fCriaRetornoConhecimento(
  var objRetornoNFE: TRetornoNFE; strProtocolo, strModelo,
  strDataHora: String): TRetornoNFE;
begin
  If Assigned(objRetornoNFE) Then
  Begin
    objRetornoNFE.FProtocoloConhecimento := strProtocolo;
    objRetornoNFE.FModeloConhecimento    := strModelo;
    objRetornoNFE.FDataHoraConhecimento  := strDataHora;
  End;

  Result := objRetornoNFE;
end;

class function TRetornoNFE.fCriaRetornoContingencia(
  strMensagem: String): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(False, strMensagem, '', '');
  Result.FContigencia := True;
end;

class function TRetornoNFE.fCriaRetornoDenegada(
  strMensagem: String): TRetornoNFE;
begin
  Result := fCriaRetornoDenegada(strMensagem, '');
end;

class function TRetornoNFE.fCriaRetornoEncerrada(strMensagem, strChaveAcesso,
  strProtocolo: String; dtaDtaAut: TDateTime): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(True, strMensagem, strChaveAcesso, strProtocolo);
  Result.FDataAutorizacao := dtaDtaAut;
  Result.FEncerrada := True;
end;

class function TRetornoNFE.fCriaRetornoErro(strMensagem: String): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(False, strMensagem, '', '');
end;

class function TRetornoNFE.fCriaRetornoInutilizada(
  strProtocolo: String): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(False, 'Nota inutilizada.', '', strProtocolo);
  Result.FInutilizada := True;
end;

class function TRetornoNFE.fCriaRetornoManifesto(var objRetornoNFE: TRetornoNFE;
  strProtocolo, strModelo, strDataHora: String): TRetornoNFE;
begin

  If Assigned(objRetornoNFE) Then
  Begin
    objRetornoNFE.FProtocoloManifesto := strProtocolo;
    objRetornoNFE.FModeloManifesto    := strModelo;
    objRetornoNFE.FDataHoraManifesto  := strDataHora;
  End;

  Result := objRetornoNFE;

end;

class function TRetornoNFE.fCriaRetornoSucesso(strMensagem, strChaveAcesso,
  strProtocolo: String; dtaDtaAut: TDateTime): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(True, strMensagem, strChaveAcesso, strProtocolo);
  Result.FDataAutorizacao := dtaDtaAut;
end;

function TRetornoNFE.Inutilizada: Boolean;
begin
  Result := FInutilizada;
end;

function TRetornoNFE.Aguardando: Boolean;
begin
  Result := FAguardando;
end;

function TRetornoNFE.Cancelada: Boolean;
begin
  Result := FCancelada;
end;

function TRetornoNFE.ChaveAcesso: String;
begin
  Result := FChaveAcesso;
end;

function TRetornoNFE.Mensagem: String;
begin
  Result := FMensagem;
end;

function TRetornoNFE.ModeloConhecimento: String;
begin
  Result := FModeloConhecimento;
end;

function TRetornoNFE.ModeloManifesto: String;
begin
  Result := FModeloManifesto;
end;

function TRetornoNFE.NumeroCFe: String;
begin
  Result := FNumeroCFe;
end;

function TRetornoNFE.NumeroProtocolo: String;
begin
  Result := FNumeroProtocolo;
end;

function TRetornoNFE.NumeroSerieSAT: String;
begin
  Result := FNUmeroSerieSAT;
end;

function TRetornoNFE.ObsFisco: String;
begin
  Result := FObsFisco;
end;

function TRetornoNFE.QRCode: String;
begin
  Result := FQRCode;
end;

procedure TRetornoNFE.SetaComoNaoSucesso;
begin
  FSucesso := False;
end;

procedure TRetornoNFE.SetaComoSucesso;
begin
  FSucesso := True;
end;

procedure TRetornoNFE.SetaErroImpressao(const strMensagem: string);
begin
  FErroImpressao := True;
  FMensagem := strMensagem;
end;

procedure TRetornoNFE.SetContingencia(blnContingencia: Boolean);
begin
  FContigencia := blnContingencia;
end;

procedure TRetornoNFE.SetContingenciaAutorizada(strContingenciaAutorizada: String);
begin
  FContingenciaAutorizada := strContingenciaAutorizada;
end;

procedure TRetornoNFE.SetDataEmissao(Valor: TDateTime);
begin
  Self.FDataEmissao := Valor;
end;

procedure TRetornoNFE.SetNumeroCFe(Valor: String);
begin
  FNumeroCFe := Valor;
end;

procedure TRetornoNFE.SetNumeroSerieSAT(Valor: String);
begin
  FNumeroSerieSAT := Valor;
end;

procedure TRetornoNFE.SetObsFisco(Valor: String);
begin
  FObsFisco := Valor;
end;

procedure TRetornoNFE.SetQRCode(Valor: String);
begin
  Self.FQRCode := Valor;
end;

function TRetornoNFE.Sucesso: Boolean;
begin
  Result := FSucesso;
end;

procedure TRetornoNFE.SetRecusadaRejeitada;
begin
  FRecusadaRejeitada := True;
end;

function TRetornoNFE.RecusadaRejeitada: Boolean;
begin
  Result := FRecusadaRejeitada;
end;

function TRetornoNFE.OffLine: Boolean;
begin
  Result := FOffLine;
end;

function TRetornoNFE.ProtMsg: String;
begin
  Result := FProtMsg;
end;

function TRetornoNFE.ProtocoloConhecimento: String;
begin
  Result := FProtocoloConhecimento;
end;

function TRetornoNFE.ProtocoloManifesto: String;
begin
  Result := FProtocoloManifesto;
end;

procedure TRetornoNFE.SetOffLine(blnOffLine: Boolean);
begin
  Self.FOffLine := blnOffLine;
end;

procedure TRetornoNFE.SetProtMsg(strProtMsg: String);
begin
  Self.FProtMsg := strProtMsg;
end;

{ TErrosValidacao }

constructor TResultadoValidacao.Create;
begin
  stlErros := TStringList.Create;
end;

destructor TResultadoValidacao.Destroy;
begin
  FreeAndNil(stlErros);
  inherited;
end;

function TResultadoValidacao.fValido: Boolean;
begin
  Result := (stlErros.Count = 0);
end;

function TResultadoValidacao.GetCount: Integer;
begin
  Result := stlErros.Count;
end;

function TResultadoValidacao.GetErros(intIndice: Integer): String;
begin

  If (fValido) Then
    Result := ''
  Else
  Begin
    If intIndice >= stlErros.Count Then
      intIndice := stlErros.Count-1
    Else If intIndice < 0 Then
      intIndice := 0;

    Result := stlErros[intIndice];
  End;
end;

function TResultadoValidacao.GetExceptions(intIndice: Integer): Exception;
begin
  If (fValido) Then
    Result := Nil
  Else
  Begin
    If intIndice >= stlErros.Count Then
      intIndice := stlErros.Count-1
    Else If intIndice < 0 Then
      intIndice := 0;

    Result := Exception(stlErros.Objects[intIndice]);
  End;
end;

procedure TResultadoValidacao.pAdicionarErro(strMensagem: String;
  objErro: Exception);
begin
  stlErros.AddObject(strMensagem, objErro);
end;

class function TRetornoNFE.fCriaRetornoDenegada(strMensagem,
  strAcesso: String): TRetornoNFE;
begin
  Result := TRetornoNFE.Create(False, strMensagem, strAcesso, '');
  Result.FDenegada := True;
end;

{ ErrosValidacaoNFE }

constructor ErrosValidacaoNFE.Create(strMensagem: String;
  resultadoValidacao: TResultadoValidacao; blnNFCeOffLine: Boolean=False);
begin
  inherited Create(strMensagem);
  FResultadoValidacao := resultadoValidacao;
  FOffLine := blnNFCeOffLine;
end;

class function ErrosValidacaoNFE.fCriaErroSimples(
  strMensagem: String): ErrosValidacaoNFE;
  Var
    resultValidacao: TResultadoValidacao;
begin
  resultValidacao := TResultadoValidacao.Create;
  resultValidacao.pAdicionarErro(strMensagem, Nil);
  Result := ErrosValidacaoNFE.Create(strMensagem, resultValidacao);
end;

function ErrosValidacaoNFE.ResultadoValidacao: TResultadoValidacao;
begin
  Result := FResultadoValidacao;
end;

function ErrosValidacaoNFE.NFCeOffLine: Boolean;
begin
  Result := FOffLine;
end;

{ TDadosGerais }

constructor TDadosGerais.Create;
begin
  blnImprimirDuplicatas := True;
  blnImprimirDuplicatasConfCI := False;
  SetLength(arrFormasPagamento, 0);
  fltPerFcpComplementoIcmsCapa := 0;
  fltValFcpComplementoIcmsCapa := 0;
  blnNotEsp := False;
  blnAtoDeclaratorioDF := False;
  blnInconsistenciaEFD_Gravar := False;
end;

function TDadosGerais.fNotaSaida: Boolean;
begin
  Result := (StrToIntDef(LeftStr(strClaFis, 1), 0) >= 5);
end;

function TDadosGerais.fTipoChaveReferenciada(strEspDoc, strChaveAcesso: String): String;
begin
  Result := '';
  If strEspDoc = 'IF' Then
  Begin
    If Trim(strChaveAcesso) = '' Then
      Result := DOCUMENTO_REF_ECF
    Else
      Result := DOCUMENTO_REF_NFCE;
  End
  Else
  Begin
    If Trim(strChaveAcesso) = '' Then
      Result := DOCUMENTO_REF_NF_Modelo_1_1A //NF não eletronica
    Else
      Result := DOCUMENTO_REF_NFe_Modelo_55; //NF eletronica
  End;
end;

function TDadosGerais.fNotaComplementoICMS: Boolean;
begin
  Result := (blnNfComp) And (blnComplementoIcms) And (Not blnCreditoIcms);
end;

function TDadosGerais.fNotaCreditoICMS: Boolean;
begin
  Result := (blnNfComp) And (blnCreditoIcms) And (Not blnComplementoIcms);
end;

destructor TDadosGerais.Destroy;
begin
  If Assigned(Self.ReformaTributariaCreditoDebito) Then
    FreeAndNil(Self.ReformaTributariaCreditoDebito);

  If Assigned(Self.ReformaTributariaTotal) Then
    FreeAndNil(Self.ReformaTributariaTotal);

  inherited;
end;

{ TAbstractAdministrativoService }

function TAbstractAdministrativoService.fCarregarNfePdf(AChaveAcesso,
  ANomeArquivo: string; AExtensao: Boolean; AIgnorarLayoutSimplificado: Boolean = False): string;
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

function TAbstractAdministrativoService.fConsultaCadastro(strUf, strCnpj,
  strIe: String): TRetornoConsultaCadastro;
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

function TAbstractAdministrativoService.fEnviaCartaCorrecao(
  strChaveAcesso: String; stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer): TRetornoCartaCorrecao;
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

function TAbstractAdministrativoService.fListagemNotas(strCodEmp: String;
  dtaDtaIni, dtaDtaFin: TDateTime; intTipo, intStatus: Integer): TStringList;
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

function TAbstractAdministrativoService.fSuportaFuncoesAdministrativas: Boolean;
begin
  Result := False;
end;

procedure TAbstractAdministrativoService.pEnviaCartaCorrecao(
  strChaveAcesso: String; stlCorrecoes: TStringList; strImpressora: String;
  intSequencial: Integer);
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

procedure TAbstractAdministrativoService.pInutilizarNumeros(strAno, strSerie,
  strNumeroInicial, strNumeroFinal, strDescricao: String);
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

procedure TAbstractAdministrativoService.pReimprimirDanfe(strChaveAcesso,
  strImpressora: String; strImprimirTelaPDF: String = '');
begin
  Raise Exception.Create('Funcionalidade não implementada.');
end;

function TFormaPagamento.getIndPag: string;
const
  intPAGAMENTO_A_VISTA = '0';
  intPAGAMENTO_A_PRAZO = '1';
begin
  if strCodigo = '01' then
  begin
    Result := intPAGAMENTO_A_VISTA;
    Exit;
  end;

  if strCodigo = '03' then
  begin
    Result := intPAGAMENTO_A_VISTA;
    Exit;
  end;

  if strCodigo = '04' then
  begin
    Result := intPAGAMENTO_A_VISTA;
    Exit;
  end;

  if strCodigo = '16' then
  begin
    Result := intPAGAMENTO_A_PRAZO;
    Exit;
  end;

  if strCodigo = '17' then
  begin
    Result := intPAGAMENTO_A_VISTA;
    Exit;
  end;

  if strModCodMod = '006' then
  begin
    Result := intPAGAMENTO_A_VISTA;
    Exit;
  end;

  if (strModCodMod = '012') then
  begin
    If strCndPag = '01000' Then
      Result := intPAGAMENTO_A_VISTA
    Else
      Result := intPAGAMENTO_A_PRAZO;

    Exit;
  end;

  result := intPAGAMENTO_A_PRAZO;
end;

destructor TDadosItem.Destroy;
begin
  If Assigned(Self.ReformaTributaria) Then
    Self.ReformaTributaria.Free;

  inherited;
end;

destructor TDadosReformaTributaria.Destroy;
begin
  If Assigned(Self.IBS_CBS) Then
    Self.IBS_CBS.Free;

  If Assigned(Self.SEL) Then
    Self.SEL.Free;

  If Assigned(Self.CBS) Then
    Self.CBS.Free;

  If Assigned(Self.IBS_UF) Then
    Self.IBS_UF.Free;

  If Assigned(Self.IBS_MUN) Then
    Self.IBS_MUN.Free;

  If Assigned(Self.TRIB_REGULAR) Then
    Self.TRIB_REGULAR.Free;

  inherited;
end;

end.
