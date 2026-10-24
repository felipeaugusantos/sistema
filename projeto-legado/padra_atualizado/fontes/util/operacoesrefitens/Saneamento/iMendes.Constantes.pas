unit iMendes.Constantes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni, UniClientDataSet, madStackTrace,
{$ENDIF}
  System.SyncObjs;

const
  IME_CST_TRIBUTADO = '000_100_200_300_400_500_600_700_800_' +
                  '020_120_220_320_420_520_620_720_820_';
  IME_CST_SUBSTITUICAO = '010_110_210_310_410_510_610_710_810_' +
                     '060_160_260_360_460_560_660_760_860_' +
                     '070_170_270_370_470_570_670_770_870_' +
                     '030_130_230_330_430_530_630_730_830';


  ACCEPT              = 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  ACCEPT_CHARSET      = 'UTF-8, *;q=0.8';
  CONTENT_TYPE        = 'application/json';
  ACCEPT_TEXT_HTML    = 'text/html; charset=utf-8';
  ACCEPT_OCTET_STREAM = 'application/octet-stream';
  PERFIS_ICMS_72      : Array[0..12] Of String = ('PEF', 'PEJ', 'PER', 'PES', 'PSI', 'NCO', 'CCO', 'CNC', 'SNA', 'CTA', 'PRU' ,'IND', 'TRS');
  UNIDESFEDERATIVA    : Array[0..26] Of String = ('AC','AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SE', 'SP', 'TO');
  cQtdItensPagina     = 100;
  cItensAlterados    = 'ITENS_ALTERADOS';




  PERFIS_ICMS         : Array[0..13] Of String = ('PEF', 'PEJ', 'PER', 'PES', 'PSI', 'PII', 'NCO', 'CCO', 'CNC', 'SNA', 'CTA', 'PRU' ,'IND', 'TRS');

  cImendesPendente  = 'P';
  cImendesConcluido = 'C';
  cImendesAndamento = 'A';
  cMensagemOk = 'OK';
  cMensagemProdutoNaoEncontrado = 'Nenhum produto encontrado. Entre em contato com equipe responsável por produtos pendentes.';
  cMensagemRateLimit            = 'API rate limit exceeded';
  cMensagemHTTP503              = 'HTTP/1.1 503 Service Temporarily Unavailable';
  cMensagemRestRequestFailed    = 'REST request failed: Execution of request terminated with unknown error';


   VersaoAutcomApi = 74;
   VersaoApi = '1.0.0.34';


  STR_CHAR_CRYPT_IMENDES = 'ABCDEFGHIJKLMNOPQRSTUVWYXZabcdefghijklmnopqrstuvwyxz 1234567890/:_*#';

{$IFNDEF LINUX}
var
  iMendes_Connection: TUniConnection;
  iMendes_strCodEmp: String;
{$ENDIF}

implementation

end.

