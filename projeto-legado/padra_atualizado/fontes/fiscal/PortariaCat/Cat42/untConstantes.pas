unit untConstantes;

interface

Uses
  {$IFDEF MSWINDOWS}
  cxProgressBar,
  {$ENDIF}
  SysUtils,
  UniClientDataSet, CRAccess;

Type
  ExceptionAutCom = Class(Exception)
End;

Type
  TTipoOperacao = (opIncluir, opAlterar, opExcluir, opVazio);
  TOperacaoTroco = (otCredito, otTroco, otNada);
  TFormaOriTroco = (foCheque, foChequePre, foCartao);
  TTipoTinta = (ttImobiliaria, ttAutomotiva);
  {$IFDEF MSWINDOWS}
  TFunctionFormGravando = function(pgbProgresso: TcxProgressBar): Boolean Of Object;
   {$ENDIF}

  TGenericProcedureWithClientParamAndVar = procedure(Var strParamPorReferencia1: String; strParamPorValor1: String; cdsConsulta: TUniClientDataSet);

  Const
    DEFAULT_ISOLATION_LEVEL_UNIDAC = ilReadCommitted;
    DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION = ' SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; ';

    FLT_LITRO_GALAO = 3.600;
    STR_LITRO_GALAO = '3.600';

    //#STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*';
    STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#';
    STR_CHAR_SENHA_C = 'abcdefghijklmnopqrstuvwyxzABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/@#$%:&*()_+-!';

    STR_ESTADO_REG_1900 = '_RS_';

    STR_CHAR_ESP = '/ @ # $ % ¨ & * ( ) _ + - !';

    STR_CLIENTE = 'Cliente: ';

    ERR_UNKNOW_ERROR    = 0000000;
    ERR_UNKNOW_DATABASE = 0000001;
    ERR_ACCESS_DENIED   = 0000002;
    ERR_TABLE_NOT_EXIST = 0000003;
    ERR_FIELD_NOT_FOUND = 0000004;
    ERR_TABLE_READONLY  = 0000005;
    ERR_NOT_VALID_INT   = 0000006;
    ERR_NOT_VALID_DATE  = 0000007;
    ERR_NOT_VALID_FLOAT = 0000008;
    ERR_NOT_IN_EDIT     = 0000009; //Not in EDIT or INSERT mode
    ERR_SQL_SYNTAX      = 0000010;
    ERR_BD_NOT_ACTIVE   = 0000011;
    ERR_FIELD_NOT_NULL  = 0000012;
    ERR_PRIMARY_KEY     = 0000013;
    ERR_ORDER_BY        = 0000014;

    ARRMOVGER: Array[1..2] Of String[7] = ('MOVGER','MOVGERX');
    ARRMOVDET: Array[1..2] Of String[7] = ('MOVDET','MOVDETX');
    ARRCADPAG: Array[1..2] Of String[7] = ('CADPAG','CADPAGX');
    ARRCADREC: Array[1..2] Of String[7] = ('CADREC','CADRECX');
    ARRDUPAGP: Array[1..2] Of String[7] = ('DUPAGP','DUPAGPX');
    ARRMOVBAN: Array[1..2] Of String[7] = ('MOVBAN','MOVBANX');
    ARRCHQDEV: Array[1..2] Of String[7] = ('CHQDEV','CHQDEVX');

    //****************************************//
    // ESSA STRING POSSUI OS CÓDS. DOS BANCOS //
    // QUE JÁ ESTÃO PREPARADOS PARA IMPRESSÃO //
    // DE BOLETOS LASER                       //
    //*************************************ED*//
    BANCOS_LASER = '001_033_041_104_151_237_341_353_356_399_409_741_748_756_422_';

    ARQOPCOES = 'opcoes.ini';
    {*******************************************}
    {* ARQUIVO DE CONFIGURAÇÕES DO AUTBAN      *}
    {****************************************MV*}
    ARQCNFBCO = 'cnfbco.ini';

    {*****************************************}
    {* MAIOR VALOR MONETÁRIO PERMITIDO       *}
    {**************************************MV*}
    MAX_VALMON = 99999999.99;

    {*****************************************}
    {* QUANTIDADE MAXIMA DE ARQUIVOS TMP     *}
    {**************************************MV*}
    MAX_ARQTMP = 9999;

    {*****************************************}
    {* QUANTIDADE MÁXIMA DE LINHAS DOS MEMOS *}
    {**************************************MV*}
    MAX_LINHAS_MEMO = 2; // MAX_LINHAS_MEMO = 3 - 1;

    {************************************************}
    {* SENHA PARA CONFIGURAÇÃO DE BOLETOS/NOTAS/ETC *}
    {*********************************************MV*}
    SEN_CNF = '13347';
    SEN_AUTTIN = 'CITEL13347';
    SEN_AUTRCX = 'CITEL13347';
    SEN_PROCOD = 'CITEL13347';
    SEN_ATIINI = 'a@uu*86';

    {*****************************************}
    {* CONSTANTES AUXILIARES PARA ETIQUETA   *}
    {**************************************MV*}
    ETI_MARCAR    = 0;
    ETI_DESMARCAR = 1;
    ETI_CANCELAR  = 2;

    {******************************************}
    {* TIPO DE ETIQUETA: CLIENTES, ITENS, ETC *}
    {***************************************MV*}
    ETI_CLIENTES     = 1;
    ETI_ITENS        = 2;
    ETI_DIVERSOS     = 3;
    ETI_FORNECEDORES = 4;
    ETI_VENDEDORES   = 5;
    ETI_ESTRUTURAS   = 6;    

    {*****************************************}
    {* CODIGOS DE ERRO ESPECIFICOS DO MYSQL  *}
    {**************************************MV*}
    ERROR_FOREIGN_KEY_DELETE = 1217;
    ERROR_FOREIGN_KEY_INSERT = 1216;
    ERROR_PRIMARY_KEY_INSERT = 1062;
    ERROR_USUARIO_SENHA_INV =  1045;
    ERRO_NAO_CONECTOU = 2003;

    {*****************************************}
    {* QUATIDADE DE MESES USADAS NO GIRO DE  *}
    {* ESTOQUE                               *}
    {**************************************MV*}
    GIR_03MESES = 0;
    GIR_06MESES = 1;
    GIR_12MESES = 2;

    ESTADOS: Array[0..27] Of String[2] = ('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SP', 'TO', 'SE','EX');

    COD_ESTADOS: Array[0..27] Of String[2] = ('12', '27', '13', '16', '29', '23', '53', '32', '52', '21', '31', '50', '51', '15', '25', '26', '22', '41', '33', '24', '11', '14', '43', '42', '35', '17', '28','99');

    DES_ESTADOS: Array[0..27] Of String =('Acre', 'Alagoas', 'Amazonas', 'Amapá', 'Bahia', 'Ceará', 'Distrito Federal', 'Espírito Santo', 'Goiás', 'Maranhão', 'Minas Gerais',
                                          'Mato Grosso do Sul', 'Mato Grosso', 'Para', 'Paraiba', 'Pernambuco', 'Piaui', 'Parana', 'Rio de Janeiro', 'Rio Grande do Norte', 'Rondonia', 'Roraima',
                                          'Rio Grande do Sul', 'Santa Catarina', 'São Paulo', 'Tocantins', 'Sergipe','EX');

    {**********************************************}
    {* LOGIN PADRÃO DA CITEL (SENHA = citel13347) *}
    {*******************************************AF*}
    LOG_ADM = '999';
    SEN_ADM = 'CITEL13347';
    SENHAADM_AUTBAN  = 'CITEL13347';

    {*****************************************}
    {* STATUS DA CONDIÇÃO DE PAGAMENTO       *}
    {**************************************MV*}
    A_VISTA = 1;
    A_PRAZO = 2;

    {*****************************************}
    {* CAMPOS DE VENDA                       *}
    {**************************************MV*}
    CAMPOS_VENDA = 'COM_CUS_VE1_VE2_VE3_VE4_VE5_VE6_VE7_VEN';

    {******************************************}
    {* CAMPOS PARA PREÇO DO INVENTÁRIO FISICO *}
    {***************************************MV*}
    CAMPOS_INV = 'COM_CUS_VE1_VE2_VE3_VE4_VE5_VE6_VE7_MED_ULTFED_PRELIQ_ULT_IMPULT';

    {*****************************************}
    {* CAMPOS PARA O SALDO DO INVENTÁRIO     *}
    {**************************************MV*}
    CAMPOS_SALDO_INV = 'SALDOS_SALBAL_';

    UNIDADES_BASE = 'LT_GL_LA_';

    arrArqCaixa2: Array[0..8] Of String = ('CADRECX',
                                           'DUPAGRX',
                                           'CADPAGX',
                                           'MOVBANX',
                                           'CADCHQX',
                                           'MOVDETX',
                                           'MOVGERX',
                                           'NOTDETX',
                                           'NOTGERX');

    {*******************************************}
    {* CONSTANTES PARA TIPO DE CLIENTE         *}
    {****************************************MV*}
    TPC_DINHEIRO = 1;
    TPC_CHEQUE_PRE = 2;
    TPC_CHEQUE_VISTA = 3;
    TPC_CARTAO = 4;
    TPC_CARTAO_DEBITO = 5;
    TPC_ORDEM_PAGAMENTO = 5;

    {*****************************************}
    {* CONSTANTES PARA TIPO DE CHEQUE        *}
    {**************************************MV*}
    CHQ_VISTA = 1;
    CHQ_PRE = 2;

    {*****************************************}
    {* IDENTIFICAÇÃO DOS SISTEMAS            *}
    {**************************************MV*}
    AUTCOM = 1;
    AUTTIN = 2;
    AUTBAN = 3;

    {*****************************************}
    {* ORIGEM DAS TINTAS IMOBILIARIAS... AO  *}
    {* CRIAR NOVA TINTA INCLUIR NESTA STRING *}
    {**************************************IV*}
    STR_IMOBILIARIAS = 'SUV_CIM_VZA_REI_CID_SHE_BZI_LKS_DAC_SHE_FUT_KIL_COL_EUC_ADV_UNI_MAZ_';

    {*****************************************}
    {* CÓDOGOS DE SITUAÇÃO TRIBUTÁRIA        *}
    {**************************************JU*}
    CST_SUBSTITUICAO = '010_110_210_310_410_510_610_710_810_' +
                       '060_160_260_360_460_560_660_760_860_' +
                       '070_170_270_370_470_570_670_770_870_';

    CST_NAO_TRIBUTADO = '041_141_241_341_441_541_641_741_' +
                        '051_151_251_351_451_551_651_751_';

    CST_ISENTO = '030_130_230_330_430_530_630_730_' +
                 '040_140_240_340_440_540_640_740_' +
                 '050_150_250_350_450_550_650_750_';

    CST_REDUCAO = '020_120_220_320_420_520_620_720_' +
                  '070_170_270_370_470_570_670_770_';

    {*****************************************}
    {* IDENTIFICAÇÃO DOS SISTEMAS            *}
    {**************************************IV*}
    CLASSIF_SERVICOS = '933_';

    CFOP_ISENTOS_PISCOFINS_ENTRADA = '1925_2925';

    CFOP_TRANSPORTES  = '1351_1352_1353_1354_1355_1356_1360_1932_2351_2352_2353_2354_2355_2356_2932_5351_5352_' +
                       '5353_5354_5355_5356_5357_5359_5360_5932_6351_6352_6353_6354_6355_6356_6357_6359_6360_6932_';

    CFOP_ENERGIA      = '1251_1252_1253_1254_1255_1256_1257_2251_2252_2253_2254_2255_2256_2257_3251_' +
                       '5251_5252_5253_5254_5255_5256_5257_5258_6251_6252_6253_6254_6255_6256_6257_6258_';

    CFOP_COMUNICACAO  = '1301_1302_1303_1304_1305_1306_2301_2302_2303_2304_2305_2306_2301_3301_' +
                       '5301_5302_5303_5304_5305_5306_5307_6301_6302_6303_6304_6305_6306_6307_';

    CFOP_DEVOLUCAO    = '1411_2411_1202_2202_';

    CFOP_CRED_RESSARC = '1604_2604_';

    CFOP_IMOBIL_MAT_CONSUMO = '1406_1551_1552_1553_1554_1555_1556_1557_' +
                              '2406_2551_2552_2553_2554_2555_2556_2557_' +
                              '3551_3553_3556_' ;

    CFOP_CONSUMO = '1406_2406_3406_1551_2551_3551_1407_2407_3407_1556_2556_3556_1653_2653_3653_';

    CFOP_ST = '401_402_403_404_405_406_407_408_409_410_411_412_413_414_415';

    CST_PIS_SOMENTE_ENTRADA = '50_51_52_53_54_55_56_60_61_62_63_64_65_66_67_70_71_72_73_74_75_98';

    CFOP_SEM_IPI_INDUSTRIAL = '1556_2556_1407_2407_2912_1912_2911_1911';

    ALQ_PIS_PRESUMIDO = 0.65;

    CPFS_INVALIDOS = '00000000000_11111111111_22222222222_' +
                     '33333333333_44444444444_55555555555_' +
                     '66666666666_77777777777_88888888888_' +
                     '99999999999_';

    CNPJS_INVALIDOS = '00000000000000_11111111111111_22222222222222_33333333333333_' +
                      '44444444444444_55555555555555_66666666666666_77777777777777_' +
                      '88888888888888_99999999999999';


    ESPECIES_NFCE = 'IF_IV';

implementation

end.




