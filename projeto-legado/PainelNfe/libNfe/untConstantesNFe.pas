unit untConstantesNFe;

interface

uses SysUtils;

Type
  TRecCliEnd = Record
    strOriEnd,
    strLograd,
    strNumero,
    strComple: String;
End;

Type
 TListaDuplicata = (dupCredito, dupQuitada);

 ExceptionNFePrinter = Class(Exception);

const
  FORMA_PAGTO_PIX : String = '17';

  consCredito:string=' CR';
  consQuitada:string=' q';

  RET_STATUS_AUTORIZADA = 100;
  RET_STATUS_AUTORIZADA_FORA_PRAZO = 150;
  RET_STATUS_AUTORIZADA_FORA_PRAZO_2 = 155;

  RET_CANCELAMENTO_HOMOLOGADO = 101;
  RET_EVENTO_REGISTRADO = 135;
  RET_EVENTO_REGISTRADO_NAO_VINCULADO = 136;
  RET_INUTILIZACAO_OK = 102;
  RET_INUTILIZACAO_OK_FIT = 1;
  RET_STATUS_DUPLICIDADE_EVENTO = 573;

  TIPO_NORMAL = 1;
  TIPO_CONTINGENCIA = 2;
  TIPO_SCAN = 3;
  TIPO_DPEC = 4;
  TIPO_SVC_AN = 6; // Sefaz Virtual de Contingência - Ambiente Nacional
  TIPO_SVC_RS = 7; // Sefaz Virtual de Contingência - Rio Grande do Sul

  DENEGADA_110 = 110; //Uso Denegado
  DENEGADA_205 = 205; //NF-e está denegada na base de dados da SEFAZ
  DENEGADA_301 = 301; //Uso Denegado: Irregularidade fiscal do emitente
  DENEGADA_302 = 302; //Rejeição: Irregularidade fiscal do destinatário
  DENEGADA_303 = 303; //Uso Denegado: Destinatário não habilitado a operar na UF

  CST_SUBSTITUICAO = '010_110_210_310_410_510_610_710_810_' +
                     '060_160_260_360_460_560_660_760_860_' +
                     '070_170_270_370_470_570_670_770_870_' +
                     '030_130_230_330_430_530_630_730_';  // Isenta ou não tributada e com cobrança do ICMS por substituição tributária

  CFOP_DEVOLUCAO = '' +
    '1201_1202_1203_1204_1208_1209_1410_1411_1503_1504_1505_1506_1553_1660_' +
    '1661_1662_1918_1919_2201_2202_2203_2204_2208_2209_2410_2411_2503_' +
    '2504_2505_2506_2553_2660_2661_2662_2901_2918_2919_3201_3202_' +
    '3211_3503_3553_2902_' + // (CFOP RETORNO, FINALIDADE_DEVOLUCAO, NÃO AUTORIZA) -> 5664_6664_5903_6903_5909_6909_5913_6913_5916_6916_

    '5200_6200_5201_6201_5202_6202_5208_6208_5209_6209_5210_6210_5410_' + 
    '6410_5411_6411_5412_6412_5413_6413_5500_6500_5503_6503_5553_6553_' +
    '5555_6555_5556_6556_5660_6660_5661_6661_5662_6662_5918_6918_5919_' +
    '6919_5921_6921_';

  {***************************************************************}
  {* AO REFERENCIAR UM NOVO CAMPO A SER CRIPT. SEPARAR COM ";"   *}
  {* EX, CFG_CITPSP;CFG_XXXXXX;CFG_YYYYYY                        *}
  {*************************************************************VA}
  consChavesCript:string='CFG_CITPSP';

  CLAFIS_ENTFUT_VEN_ABR = '"117_116_"';

  {******************************************************}
  {* CONFIGURACAO CFG_TPNFCR (TIPO DE NOTA DE CONCRETO) *}
  {***************************************************JC*}
  CONCREMASSA        = '1';
  FIGUEIREDO         = '2';
  PRESTCON           = '3';
  SECOL              = '4';
  J_A_MASSA_CONCRETO = '5';

  MSG_NETPOINTS : String = 'Parabéns! Você ganhou %s NETPOINTS nesta compra.';

  PONTO_IMPRESSAO_NAO_IMPRIMIR = 'NÃO IMPRIMIR';

  CONST_PERCENTUAL_DIFERIMENTO_RICMS = 33.33;

  consCodIbgeBrasil: String = '1058';

 {$IFDEF LINUX}
  PATH_SEPARATOR = '/';
 {$ELSE}
  PATH_SEPARATOR = '\';
 {$ENDIF}

implementation

end.
