unit untConstantes;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  cxProgressBar, Graphics, UniClientDataSet, Winapi.Messages,
{$ENDIF}
  SysUtils, Uni, CRAccess, System.UITypes, Data.DB;

Type
  TOcultarMensagemLiberacao = (omlMsgParaQuemEnvia, omlMsgParaQuemReceb);

Type
  TTipDescPro = (tdpPrecos, tdpDescon, tdpPrecosDescAdicional,
                 tdpPrecoQuantidadeColetiva, tdpPorcentoDescontoComDescontoAdicional,
                 tdpPorcentoDescontoQuantidadeColetiva, tdpEstoqueRemanescente,
                 tdpNegociacaoEspecialFornecedorPC, tdpPromocaoCompostaPorKit,
                 tdpPrecoPorQuantidadeMinimaEscalonada,
                 tdpPercentualPorQuantidadeMinimaEscalonada,
                 tdpPrecoPorVlrMinProd, tdpDescPorVlrMinProd
                 );

  TPromocaoUtilizaLimite = (pulLimitarPorCliente = 0, pulLimitarPorVenda = 1, pulSemLimite = 2);

  Taliquotas_Icms_Interestaduais = Array [0 .. 27 ] Of Array [0 .. 27] Of Double;

  TPosTagMarcaSQL = (ptmsSQLIni, ptmsSQLFim);
  TModListaRepAud = (mlraIteGer, mlraCadLot, mlraCmdOri);
  TTipoOperacao = (opIncluir, opAlterar, opExcluir, opVazio);
  TOperacaoTroco = (otCredito, otTroco, otNada);
  TFormaOriTroco = (foCheque, foChequePre, foCartao, foDinheiro);
  TDocEntrega = (DocVinculado, DocNaoVinculado, DocTodos);
  TSituacaoMotorista = (MotNenhum, MotDisponivel, MotIndisponivel, MotEntregando, MotAlmoco);

  TMarCamOpcoes = (mcoPrecoCusto, mcoMargemBruta, mcoMargemLiquida,
                   mcoTotalProdutosPrecoTabela, mcoCustoReal, mcoCustoRealComMargemZero,
                   mcoMargemBrutaValor, mcoMargemLiquidaValor, mcoMargemLiquidaValorSemDesOpePer,
                   mcoMargemLiquidaValorSemDesOpeVal, mcoUsandoMargemExibirMarkupBruto, mcoUsandoMargemExibirMarkupLiquido,
                   mcoDescTotDocumentoPerc, mcoPrecoUltimaCompraBruto, mcoPrecoUltimaCompraLiquido,
                   mcoPrecoMedioBruto, mcoPrecoMedioLiquido, mcoTotalProdutosPrecoTabelaAtual,
                   mcoMargemCadastroItemAtual, mcoMargemPraticadaBruta);

  TOpcConsultaProdutoAcabado = (ocaPadrao, ocaComSaldo, ocaTodos);
  TBooleanFunction = function(): Boolean Of Object;
  TClienteFornecedor = (cfCliente, cfFornecedor);
  TGenericProcedureWithClientParamAndVar = procedure(Var strParamPorReferencia1: String; strParamPorValor1: String; cdsConsulta: TUniClientDataSet);
  TGenericProcedureWithClientParam = procedure(cdsConsulta: TUniClientDataSet);
  TGenericFunctionWithArrayParam = function(arrString: Array of String): Boolean Of Object;
  TGenericProcedureWithQuery = procedure(qryConsulta: TUniQuery) of object;

  typTipTab = (ttCadRec, ttCadChq);
  typTipCon = (tcTitAbertos, tcTitLiquidados, tcTitAtrazados, tcTitAtrazadosLiq,
               tcChqAberto, tcChqLiquidados, tcChqDevolvidos, tcChqDevolvidosLiq,
               tcTitCreditos, tcTeleChq, tcTeleChqLiq, tcTitCreditosLiq, tcTitDentroPrazoAbertos, tcTitDentroPrazoLiquidados,
               tcChqAVistaEmAberto, tcChqAVistaLiquidados, tcChqAPrazoEmAberto, tcChqAPrazoLiquidados, tcTitCashback, tcTitCashbackLiq);


  TParamArrayString = Array Of String;
  TArrayString = Array Of String;

  Const
    {$IFDEF LINUX}
    DLL_TINTA_NAME = 'libAutcomTinta.so';
    DLL_TINTA_PATH = 'auttin/' + DLL_TINTA_NAME;
    {$ELSE}
    DLL_TINTA_NAME = 'AutcomTinta.dll';
    DLL_TINTA_PATH = 'auttin\' + DLL_TINTA_NAME;
    {$ENDIF}

    GRUPO_GATILHOS_COMPLEMENTARES_GATIME = '"009", ""';

    NO_SAFE_COMMIT_ID = 0;

    CFG_LENGTH = 10;
    CONTROLE_BOX_MOVGER     = 'BOX_ENTREGA_RETIRA_MOVGER';
    NAO_UTILIZA_BOX         = -1;
    SEM_BOX_DISPONIVEL      =  0;
    PRIMEIRO_BOX_DISPONIVEL =  1;
    CHECKOUT_COM_SUCESSO = 'SOMINC';
    CHECKOUT_SEM_SUCESSO = 'SOMREC';

    TEMPO_UNLOCK_SFAMOB : String = '00:10:00';
    MASCARA_PLACA_VEICULO: string = 'aaa-9a99;0; ';

    SULFIXOPARABLOBTOCAST = '_ORDIDXREL_';
    STR_MSG_PEDIDO_NOVA_LOJA = 'PEDIDO DE TRANSFER NCIA PARA ABERTURA DE NOVA EMPRESA';

    PASTA_PDF_IMPRESSAO_DIRETA = 'Docs_FDF_Direto';

    {Req. 456948-B - B16. Dias de retencao da foto de BALZER.

     A foto sobrevive ao commit de proposito: e o que
     testes/01_aceite_b9.sql compara de fora depois da gravacao, e a unica
     evidencia do estado anterior se a rodada precisar ser auditada. O que
     ela nao pode e acumular para sempre - a limpeza por ZER_CON_ID nao
     alcanca rodada de outra sessao, porque o ConnectionID muda a cada
     conexao.}
    INT_DIAS_RETENCAO_BALZER = 7;

    ESPECIES_CFG_CLASUF : String = '_NG_OF_GF_';

    TMP_ITEGER_CONTAGEM = 'TMP_ITEGER_CONTAGEM';
    TMP_CADLOT_CONTAGEM = 'TMP_CADLOT_CONTAGEM';

    CNS_TRA_EM_MSG = '<TRA_EM_MSG>';

    MASC_CODCTA = '99.99.999;0;_';

    STR_A_DEFINIR = 'A DEFINIR';

    CNS_TAG_FAT_DUP = '<FAT_DUP>';

    STR_DEFINICAO_LOTES = 'DefiniÁ„o de Lotes WMS';

    TIMER_UM_MINUTO = 60000;
    TIMER_TREZ_MINUTOS = 180000;
    TIMER_DEZ_MINUTOS = 600000;

    MSG_AGUARDE_REALIZANDO_FECHAMENTO_VENDA = 'Aguarde, Realizando Fechamento Venda ...';

    SVN_REPOSITORY = 'svn://srvprg1.citelsoftware.com.br';

    AUTCOM_STYLE_NAME = 'Sapphire Kamri';
    AUTCOM_COR_TELA_AGUARDE_TEMA = $005A3E00;
    AUTCOM_NOME_CORES_IDENT_EMPRESA: Array[0..7] Of String = ('Azul (Padr„o)', 'Vermelho', 'Marrom', 'Verde', 'Violeta', 'Azul PetrÛleo', 'Cinza', 'Preto');
    AUTCOM_CORES_IDENT_EMPRESA: Array[0..7] Of TAlphaColor = (TAlphaColor($FF003E5A),
                                                              TAlphaColor($FF5A0000),
                                                              TAlphaColor($FF5A3800),
                                                              TAlphaColor($FF005A2B),
                                                              TAlphaColor($FF47005A),
                                                              TAlphaColor($FF00575A),
                                                              TAlphaColor($FF696969),
                                                              TAlphaColor($FF000000));
    COR_INFORMACOES_ITEM_CONSULTA = $00FFE4D5;
    COR_INFORMACOES_SIMILARES_CONSULTA = $008CC6FF;

    INT_MOEDA_REAL  = 0;
    INT_MOEDA_DOLAR = 1;

  {$IFDEF LINUX}
    WM_USER = 32767;
  {$ENDIF}

    CM_AVISOS = WM_USER + 1;

    WM_MESSAGELIMPARFILTROCONSULTA  = WM_USER + 778;
    WM_MESSAGENAVEGANDOGRIDCONSULTA = WM_USER + 779;
    WM_MESSAGEPRESSIONOUTABCONSULTA = WM_USER + 780;
    WM_MESSAGECONSULTAFORMRESIZE    = WM_USER + 781;
    WM_MESSAGEATUALIZOUTOTALVENDA   = WM_USER + 782;
    WM_MESSAGEATUALIZAPESQUISA      = WM_USER + 783;
    WM_EXECUTOUEXPORTACAO           = WM_USER + 784;

    STR_TAB_MODO_COMPLETO = 'Alterar para TAB modo Completo';
    STR_TAB_MODO_RESUMIDO = 'Alterar para TAB modo Resumido';

    STR_FILTRO_STATUS_PEDIDO_EXIBIR = 'Clique aqui para exibir o filtro de Status dos Pedidos';
    STR_FILTRO_STATUS_PEDIDO_OCULTAR = 'Clique aqui para ocultar o filtro de Status dos Pedidos';

    TAG_ULTORC_INI = '/*ULTORC<*/';
    TAG_ULTORC_FIN = '/*>ULTORC*/';

    TAG_ULTPED_INI = '/*ULTPED<*/';
    TAG_ULTPED_FIN = '/*>ULTPED*/';

    TAG_REPAUD_CODITE = 'ListaRepAudCodIte';
    TAG_REPAUD_CODEMP = 'ListaRepAudCodEmp';
    TAG_REPAUD_NUMLOT = 'ListaRepAudNumLot';
    TAG_CMDEXE_ORIGIN = 'ExComandoOriginal';

    ESTADOS_REGRA_ZONA_FRANCA = 'AM_AC_AP_RR_RO_';

    IDX_TIPO_DESCONTO_PROMOCAO : Array[TTipDescPro] Of Integer = (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);

    DEC_EMBALAGEM = 8;

    GATURL_DEF = 'https://gatilhos-de-informacao.citelsoftware.com.br/';

    cnsFiltroFFDVTR: String = ' /*FF_DV_TR_*/ ';

    cnsNomeIdxGrid: String = '_IDXGRD_';

    CNS_MSG_USOCONSUMO = 'USO E CONSUMO REF:';

    INF_ADICIONAL_ITEM = 'INFAD';
    INF_DEVOLVER_ALMOXARIFADO = 'PRODUTOS A DEVOLVER PARA O ALMOXARIFADO';
    INF_RETIRAR_ALMOXARIFADO  = 'PRODUTOS A RETIRAR DO ALMOXARIFADO';

    SQL_TESTE_LOG_REPLICACAO = 'SET @TESTE_LOG_REPLICACAO := "EXECUTANDO TESTE LOGREP";';
    STR_MSG_ERRO_TESTE_LOG_REPLICACAO = 'Erro: Teste de log de replicaÁ„o identificou falha na gravaÁ„o!';
    STR_SQL_NAO_REPLICAR = '/* SQL_NAO_REPLICAR */';

    DEFAULT_ISOLATION_LEVEL_UNIDAC = ilReadCommitted;
    DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION = ' SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED; ';

    PRECOS_TE_PROMOC : String = 'VEP_CUP_CSD_';

    TOLERANCIA_DIFERENCA_EXPEDICAO_PARCIAL = 0.05;

    TOLERANCIA_DIFERENCA_DESMEMBRAMENTO : Double = 0.01;

    TOLERANCIA_DIFERENCA_F11 = 0.02;

    arrCtgCli : Array[0..26] Of String = (' ','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');


    arrMesAbr : Array [0..12] Of String[3] = ('', 'JAN', 'FEV', 'MAR', 'ABR', 'MAI', 'JUN', 'JUL', 'AGO', 'SET', 'OUT', 'NOV', 'DEZ');
    arrMes    : Array [0..12] Of String[10] = ('', 'Janeiro', 'Fevereiro', 'MarÁo', 'Abril', 'Maio', 'Junho',
                                                   'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

    arrPreInvCod : Array [0..13] of string = ('COM', 'CUS', 'VE1', 'VE2', 'VE3', 'VE4', 'VE5', 'VE6', 'VE7', 'MED', 'ULTFED', 'ULT', 'IMPULT', 'PRELIQ');
    arrPreInvDesc: Array [0..13]of string =  ('PreÁo de Compra',
                                                'PreÁo de Custo',
                                                'PreÁo de Venda 1',
                                                'PreÁo de Venda 2',
                                                'PreÁo de Venda 3',
                                                'PreÁo de Venda 4',
                                                'PreÁo de Venda 5',
                                                'PreÁo de Venda 6',
                                                'PreÁo de Venda 7',
                                                'PreÁo MÈdio de Compra',
                                                'PreÁo ⁄ltima compra menos impostos federais',
                                                'PreÁo de ⁄ltima Compra',
                                                'PreÁo de ⁄ltima Compra Mais Impostos Entrada',
                                                'PreÁo de Compra LÌquido');

    TiposFrete: Array[0..5] Of Integer = (1, 2, 3, 9, 4, 5);
    DescricoesFrete: Array[0..5] Of String = ('Remetente(CIF)', 'Destinat·rio(FOB)', 'Terceiros', 'Sem Frete', 'Transporte PrÛprio Remetente', 'Transporte PrÛprio Destinat·rio');

    TIPOS_LAYOUT_CORAL    : Array[0..10] Of String[1] = ('C', 'D', 'E', 'B', 'G', 'F', 'N', 'S', 'H', 'I', 'A');

    DESCRICAO_LAYOUT_CORAL: Array[0..10] Of String[36] = ('Coral',             {C}
                                                         'Coral Modelo 2',    {D}
                                                         'Coral Modelo 3',    {E}
                                                         'Coral Modelo 4',    {B}
                                                         'NeoGrid Modelo 2',  {G}
                                                         'NeoGrid Modelo 3',  {F}
                                                         'NeoGrid Vers„o 3.2',{N}
                                                         'NeoGrid Vers„o 3.2 Sherwin Willians',{S}
                                                         'NeoGrid Modelo 4',  {H}
                                                         'NeoGrid Modelo 5',  {I}
                                                         'NeoGrid Modelo 6'); {A}

    MARGEM_SOBRE_PRECO_VENDA_LIQUIDO_RITEC : String = '5';

    CTP_ICMS_ANTECIPADO = '01';
    CTP_VENDOR          = '02';
    CTP_OUTRAS_DESPESAS = '03';

    STR_TRAVA_CONDET = 'CONTAGEM DE ESTOQUE - CONDET';
    STR_TRAVA_LOTE = 'LOTE_ITEM_';
    TAM_CODIGO_FABRICA = 50;

    INI_STR_EXCEL = '''';

    ETIQUETA_UNIDADES_RESTANTE = 'etiqueta_unidades_restante';
    ETIQUETA_ARMAZENAMENTO = 'etiqueta_armazenamento';

    STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#';
    STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#';

    FLT_LITRO_GALAO = 3.600;
    STR_LITRO_GALAO = '3.600';

    STR_CLIENTE = 'Cliente: ';
    STR_FORNECEDOR = 'Fornecedor: ';

    INT_POS_NUMDOC_BARRAS_EAN39 = 2;
    INT_POS_ESPDOC_BARRAS_EAN39 = 14;
    INT_POS_CODEMP_BARRAS_EAN39 = 16;
    INT_POS_SERDOC_BARRAS_EAN39 = 19;

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
    ERR_DEFAULT_PRINTER = 0000015;
    ERR_GATILHO_PERIODO = 0000016;

    FORMA_ENVIO_LINK_PAGAMENTO_EMAIL =   '1' ;
    FORMA_ENVIO_LINK_PAGAMENTO_WHATS =   '2' ;
    FORMA_ENVIO_LINK_PAGAMENTO_ESCOLHA = '3' ;

    //****************************************//
    // ESSA STRING POSSUI OS C”DS. DOS BANCOS //
    // QUE J¡ EST√O PREPARADOS PARA IMPRESS√O //
    // DE BOLETOS LASER                       //
    //*************************************ED*//
    BANCOS_LASER = '001_033_041_104_151_237_341_353_356_399_409_741_748_756_422_021_389_085_090_003_070_004_099_089_993_994_995_992_996_997_998_136_707_077_246_991_989_988_987_637_097_208_133_364_274_982_984_084_983_990_970_981_979_906_978_977_976_975_974_973_964_962_';
    BANCOS_PDFMAIL = '237_399_001_341_033_104_756_041_748_389_085_090_003_422_021_070_004_099_089_993_994_995_992_996_997_998_136_707_077_246_991_989_988_987_637_097_208_133_364_274_982_984_084_983_990_970_981_979_906_978_977_976_975_974_973_964_962_';

    ARQOPCOES = 'opcoes.ini';
    {*******************************************}
    {* ARQUIVO DE CONFIGURA«’ES DO AUTBAN      *}
    {****************************************MV*}
    ARQCNFBCO = 'cnfbco.ini';

    {*****************************************}
    {* MAIOR VALOR MONET¡RIO PERMITIDO       *}
    {**************************************MV*}
    MAX_VALMON = 9999999999.99;

    {*****************************************}
    {* QUANTIDADE MAXIMA DE ARQUIVOS TMP     *}
    {**************************************MV*}
    MAX_ARQTMP = 9999;

    {*********************************************}
    {* QUANTIDADE MAXIMA DA CLASSIFICA«√O DE IPI *}
    {******************************************CI*}
    MAX_CLAIPI = 8;

    {*****************************************}
    {* QUANTIDADE M¡XIMA DE LINHAS DOS MEMOS *}
    {**************************************MV*}
    MAX_LINHAS_MEMO = 2; // MAX_LINHAS_MEMO = 3 - 1;

    {*****************************************}
    {* QUANTIDADE M¡XIMA NA QUANTIDADE QUANDO*}
    {* FAZ UM CUPOM FSICAL.                  *}
    {**************************************MV*}
    MAX_QUANTIDADE_CUPOM = 9999.99;

    {************************************************}
    {* SENHA PARA CONFIGURA«√O DE BOLETOS/NOTAS/ETC *}
    {*********************************************MV*}
    SEN_CNF = '13347';
    SEN_AUTTIN = 'CITEL13347';
    SEN_AUTRCX = 'CITEL13347';
    SEN_PROCOD = 'CITEL13347';
    SEN_ESTSIT = 'CITEL13347';
    SEN_ATIINI = 'a@uu*86';

    {*****************************************}
    {* CONSTANTES LOCAL ERRO PMENSAGENSERRO  *}
    {**************************************GR*}
    PME_MAN_ORD_PRO_INDUSTRIAL = '[TfrmManOrdProIndustrial.btnExcluirClick]';

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
    ETI_FUNCIONARIOS = 7;

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

    ESTADOS: Array[0..28] Of String = ('AC', 'AL', 'AM', 'AP', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MG', 'MS', 'MT', 'PA', 'PB', 'PE', 'PI', 'PR', 'RJ', 'RN', 'RO', 'RR', 'RS', 'SC', 'SP', 'TO', 'SE','EX', 'PY');

    DES_ESTADOS: Array[0..28] Of String =('Acre', 'Alagoas', 'Amazonas', 'Amap·', 'Bahia', 'Cear·', 'Distrito Federal', 'EspÌrito Santo', 'Goi·s', 'Maranh„o', 'Minas Gerais',
                                          'Mato Grosso do Sul', 'Mato Grosso', 'Para', 'Paraiba', 'Pernambuco', 'Piaui', 'Parana', 'Rio de Janeiro', 'Rio Grande do Norte', 'Rondonia', 'Roraima',
                                          'Rio Grande do Sul', 'Santa Catarina', 'S„o Paulo', 'Tocantins', 'Sergipe','EX', 'Paraguai');

    ALIQUOTAS_ICMS_TABELA_ANO = 'Tabela de AlÌquotas Interestaduais da base de dados';

    UF_EXTERIOR = 'EX';

    ALIQUOTAS_ICMS_UF: Array [0 .. 27] Of String =
     ('AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO','EX');


    ALIQUOTAS_FCP_UF: Array [0 .. 27] Of String =
     ('AC','AL','AM','AP','BA','CE','DF','ES','GO','MA','MG','MS','MT','PA','PB','PE','PI','PR','RJ','RN','RO','RR','RS','SC','SE','SP','TO','EX');

    ALIQUOTAS_FCP_DESTINO: Array [0 .. 27] Of Double =
      {      AC  AL  AM  AP  BA  CE  DF  ES  GO  MA  MG  MS  MT  PA  PB  PE  PI  PR  RJ  RN  RO  RR  RS  SC  SE  SP  TO  EX }
           (  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0 );

    NO_PARAMS = '';

  {$IFNDEF LINUX}
    STANDARD_COLORS: Array[0..17] Of TColor = (clBlack, clMaroon, clGreen, clOlive,
      clNavy, clPurple, clTeal, clGray, clSilver, clRed, clLime, clYellow, clBlue,
      clFuchsia, clAqua,clLtGray, clDkGray, clWhite);
  {$ENDIF}

    VENDEDORES_COLORS: Array[0..9] Of TColor = (
      $00A6FFFF,
      $00FAA9D6,
      $00FCC9BA,
      $00CCFFCC,
      $00FFDFBF,
      $00FFFF71,
      $0080BFFF,
      $0069E0A2,
      $00C7C7C7,
      $00C8CDFB);

    {**********************************************}
    {* LOGIN PADR√O DA CITEL (SENHA = citel13347) *}
    {*******************************************AF*}
    LOG_ATD = '997';
    LOG_PRG = '998';
    LOG_IMP = '999';
    LOG_ADM = '999';
    SEN_ADM = 'CITEL13347';
    SENHAADM_AUTBAN  = 'CITEL13347';
    SEN_AUT = 'C1T3L13347';

    {*****************************************}
    {* STATUS DA CONDI«√O DE PAGAMENTO       *}
    {**************************************MV*}
    A_VISTA = 1;
    A_PRAZO = 2;

    {*****************************************}
    {* CAMPOS DE VENDA                       *}
    {**************************************MV*}
    CAMPOS_VENDA = 'COM_CUS_VE1_VE2_VE3_VE4_VE5_VE6_VE7_VEN';

    {******************************************}
    {* CAMPOS PARA PRE«O DO INVENT¡RIO FISICO *}
    {***************************************MV*}
    CAMPOS_INV = 'COM_CUS_VE1_VE2_VE3_VE4_VE5_VE6_VE7_MED_ULTFED_PRELIQ_ULT_IMPULT';

    {*****************************************}
    {* CAMPOS PARA O SALDO DO INVENT¡RIO     *}
    {**************************************MV*}
    CAMPOS_SALDO_INV = 'SALDOS_SALBAL_';

    UNIDADES_BASE = 'LT_GL_LA_';

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

    {****************************************}
    {* CONSTANTE TOLERANCIA VALOR ICM E IPI *}
    {*************************************CI*}

     TOLERANCIA_ICM_IPI = '0,01';

    {*****************************************}
    {* IDENTIFICA«√O DOS SISTEMAS            *}
    {**************************************MV*}
    AUTCOM = 1;
    AUTTIN = 2;
    AUTBAN = 3;

    MSG_SEM_DADOS_PARA_GERAR_RELATORIO = 'N„o h· dados para gerar o relatÛrio!';

    TRAVAS_VENDA_VR_MINIMO = 'VEMIN_VEMIN2_VEMIN3_VEMIN4_VEMIN5_VEMIN6_';
    STRING_MENSAGEM_OCULTA_INI_ENV = '<:';
    STRING_MENSAGEM_OCULTA_FIM_ENV = ':>';

    STRING_MENSAGEM_OCULTA_INI_REC = '+:';
    STRING_MENSAGEM_OCULTA_FIM_REC = ':+';

    STRING_JUSTIFICATIVA_LIBERACAO = '<<FLAGJUSLIB>>';
    STRING_JUSTIFICATIVA = '<<FLAGJUST>>';
    STRING_FORMAS_PAGTO_NEGOCIADAS = '<<FLAGFPGNEG>>';
    STRING_PROFISSIONAIS_LIBERACAO = '<<FLAGPROFISSIONAIS>>';
    STRING_VALOR_FRETE = '<<FLAGFRETE>>';
    STRING_VALOR_FRETE_COTADO = '<<FLAGFRETECOTADO>>';
    STRING_VALOR_DOCUMENTO = '<<FLAGVALORDOCUMENTO>>';
    STRING_QUEBRA = '<<csq>>';
    STRING_ENTER = #13#10;
    LST_OPE_ITEESP = 'OR_PD_VN_OU_OE_OF_NE_EF_';

    FORMAS_PAGTO_PERMITIDAS_COM_A_RECEBER: Array[0..1] Of String = ('008','013');

    CFOP_CTE = '_206_351_352_353_354_355_356_357_359_360_601_602_603_605_606_932_949_206_351_352_353_354_355_356_357_359_360_603_932_949_206_358_949';
    CFOP_ENERGIA     = '_1251_1252_1253_1254_1255_1256_1257_2251_2252_2253_2254_2255_2256_2257_3251_5251_5252_5253_5254_5255_5256_5257_5258_6251_6252_6253_6254_6255_6256_6257_6258_';
    CFOP_COMUNICACAO = '_1301_1302_1303_1304_1305_1306_2301_2302_2303_2304_2305_2306_2301_3301_5301_5302_5303_5304_5305_5306_5307_6301_6302_6303_6304_6305_6306_6307_';
    CFOP_SERVICO     = '_1933_2933_';
    CFOP_TRANSF_DEPOSITO_FECHADO = '1905_2905_5906_6906_';

    TRAVAS_CREDIARIO = 'LIMCR_COMPR_DEATR_CONCC_VLCRE_';
    MENSAG_CREDIARIO = 'ENCAMINHAR O CLIENTE PARA AUMENTO DE LIMITE DE CREDITO!';

    MSG_CLIENTE_COM_DEBITOS_EM_ATRASO = 'Cliente possui dÈbitos em atraso.';
    MSG_FORMA_PAGAMENTO_DEVE_SER_INFORMADA = 'A Forma de Pagamento deve ser informada! Favor verificar.';
    MSG_FORMA_PAGAMENTO_INATIVA = 'A Forma de Pagamento est· com status inativo! Favor verificar.';
    MSG_CONDICAO_PAGAMENTO_DEVE_SER_INFORMADA = 'A CondiÁ„o de Pagamento deve ser informada! Favor verificar.';
    MSG_EMPRESA_SEM_ACESSO_CONDICAO_PAGTO = 'Empresa sem acesso para utilizar esta condiÁ„o. Verifique o Cadastro de CondiÁıes de Pagamento - Aba "Empresas Acesso".';
    MSG_ONDA_SEPARACAO_NAO_IMPRESSA = 'Pedido ainda n„o possui onda de separaÁ„o impressa.';
    MSG_VALOR_MINIMO_EMITIR_NF = 'Valor Total dos produtos menor que o valor mÌnimo para faturamento em Nota Fiscal.';
    MSG_PEDIDO_ORIGEM_F11_FATURAR_PELA_EXPEDICAO = 'N„o È permitido carregar um pedido que foi originado a partir de outro pedido pelo F11 do Resumo de Caixa. Para faturar este pedido utilizar rotina de ExpediÁ„o!';
    MSG_PEDIDO_NAO_IRA_GERAR_SOMENTE_NOVOS_PEDIDOS_F11 = 'Este pedido n„o ir· gerar somente novos pedidos pelo F11.';
    MSG_NAO_CONFIGURADO_NFE = 'Sistema n„o configurado para emiss„o de NFe';
    MSG_CLIENTE_DADOS_INCORRETOS_EMITIR_NFE = 'N„o È permitido emitir Nota Fiscal sem preencher todos os dados do cliente.';
    MSG_ITENS_OBRIGATORIEDADE_NFE = 'Existem itens com obrigatoriedade de NFe.';
    MSG_PEDIDO_NAO_POSSUI_ADIANTAMENTO = 'Pedido de venda n„o possui adiantamento.';
    MSG_PEDIDO_COM_ADIANTAMENTO_MENOR_TOTAL = 'Pedido de venda com valor de adiantamento menor que o valor total do pedido.';
    MSG_NAO_HA_PRODUTOS_PARA_FATURAR = 'N„o h· nenhum produto para ser faturado.';
    MSG_NAO_CONFIGURADO_NFCE = 'Sistema n„o configurado para emiss„o de NFCe.';
    MSG_ONDA_SEPARACAO_IMPRESSA = 'Pedido possui onda de separaÁ„o impressa.';
    MSG_PEDIDO_POSSUI_SERVICOS_NFCE = 'Pedido possui serviÁos, n„o ser· permitido emitir NFCe.';
    MSG_PEDIDO_POSSUI_ENTREGA_FUTURA_NFCE = 'Pedido possui itens de entrega futura, n„o ser· permitido emitir NFCe.';
    MSG_SOMENTE_ENTREGA_IMEDIATA_NFCE = 'Pedido possui somente itens de entrega imediata, n„o ser· permitido emitir NFCe.';
    MSG_FATURADO_PARCIALMENTE = 'Documento j· foi baixado parcialmente. Favor utilizar o mÛdulo de Venda Normal ou ExpediÁ„o para faturar este documento.';
    MSG_IMPRESSAO_BAIXA_SEP_NAO_REALIZADA = 'Pedido ainda n„o possui impress„o/baixa da separaÁ„o realizada.';
    MSG_UTILIZA_ROTINA_WMS_FAT_EXP = 'Sistema configurado para utilizar rotina de WMS. Favor utilizar o mÛdulo de expediÁ„o para faturar este documento.';
    MSG_UTILIZA_ONDA_SEPARACAO_FAT_EXP = 'Sistema configurado para utilizar onda de separaÁ„o. Favor utilizar o mÛdulo de expediÁ„o para faturar este documento.';
    MSG_UTILIZA_ONDA_SEPARACAO_WMS_FAT_EXP = 'Sistema configurado para utilizar onda de separaÁ„o WMS. Favor utilizar o mÛdulo de expediÁ„o para faturar este documento.';

    MSG_AGROTOXICO = 'EMBAL. DE AGROTOXICOS: ENTREGAR LAVADA NA ADIAESP ROD. DOM PEDRO I, KM 22, ANTIGO ATERRO';

    ESPCTR_TRAVA = 'EL_NF_IF_IV_MI_FF_TR_D1_';

    CLAFIS_BR             = '"5910_6910_"';
    CLAFIS_BR_ENT         = '"1910_2910_"';
    CLAFIS_ENTFUT_VEN     = '"5117_6117_5116_6116_"';
    CLAFIS_ENTFUT_ENT     = '"1117_2117_1116_2116_"';
    CLAFIS_ENTFUT_VEN_ABR = '"117_116_"'; //AO ALTERAR ALTEAR A MESMA EM untConstantesNFe.pas DA libNfe.dll

    STR_CHAVE_IMPORTACAO_NFE = 'IMPORTACAO DE NFe';

    STR_COMP_FRETE_CAMPO = '(COALESCE(DET_FRESUG, 0) - COALESCE(DET_TOTFRE, 0))';
    STR_COMP_FRETE_DESCR = '(FRESUG - TOTFRE)';

    STR_COMP_JURCUS_CAMPO = '(COALESCE(DET_TOTCUS, 0) * COALESCE(DET_TAXJUR, 0) / 100)';
    STR_COMP_JURCUS_DESCR = 'JURCUS';

    STR_COMP_DIFAL_CAMPO = '(COALESCE(ICD_VALORI, 0) + COALESCE(ICD_VALDES, 0))';
    STR_COMP_DIFAL_DESCR = '(VALORI + VALDES)';

    STR_COMP_FCP_CAMPO = 'COALESCE(ICD_VALFCP, 0)';
    STR_COMP_FCP_DESCR = 'VALFCP';

    {*****************************}
    { AUXILIARES DO CFG_COMCUS    }
    {*****************************}
    ARR_CFG_COMP_CUSTO_CAMPOS  : array[0..12] of String = ('DET_TOTCUS', 'DET_TOTMED', 'DET_TOTULT', 'DET_IMPULT',
                                                           'DET_OUTVAL', 'DET_ICMSAI', 'DET_IMPFED', 'DET_DESOPE',
                                                           STR_COMP_FRETE_CAMPO, STR_COMP_JURCUS_CAMPO,
                                                           STR_COMP_DIFAL_CAMPO, STR_COMP_FCP_CAMPO, 'DET_OPVICM');

    // TODOS OS CAMPOS USADOS NO CUSTO, LISTADOS SEPARADAMENTE
    ARR_CFG_COMP_CUSTO_CAMPOS_TESTE_EDITOR  : array[0..13] of String = ('DET_TOTCUS', 'DET_TOTMED', 'DET_TOTULT', 'DET_IMPULT',
                                                                       'DET_OUTVAL', 'DET_ICMSAI', 'DET_IMPFED', 'DET_DESOPE',
                                                                       'DET_FRESUG', 'DET_TOTFRE', 'DET_TAXJUR','ICD_VALORI',
                                                                       'ICD_VALDES', 'ICD_VALFCP');


    ARR_CFG_COMP_CUSTO_CAMPOS_ESPELHO  : array[0..9] of String = ('(ITE_PRECUS * ENT_QTDITE * ENT_EMBALA)',
                                                                  '(ITE_PREMED * ENT_QTDITE * ENT_EMBALA)',
                                                                  '(ENT_TOTITE - ENT_DESESP)',
                                                                  'ROUND( (ENT_TOTITE - ENT_DESESP) * (1 - (IFNULL(ENT_PERPIS, 0) + IFNULL(ENT_PERCOF, 0)) / 100) + IFNULL(ENT_VALIPI, 0) + ' +
                                                                  ' IFNULL(ENT_VAEIPI, 0) + IFNULL(ENT_VALFRE, 0) + IFNULL(ENT_FRECON, 0) + IFNULL(ENT_FRERPA, 0) + IFNULL(ENT_OUTDES, 0) + IFNULL(ENT_VENDOR, 0) + ' +
                                                                  ' IFNULL(ENT_DESACE, 0) + IFNULL(ENT_VALANT, 0) + IFNULL(ENT_VAFRAN, 0) + IFNULL(ENT_VALGNR, 0) + IFNULL(ENT_VALRET, 0) + IFNULL(ENT_VAERET, 0), 2) ',
                                                                  '0',  // VALORES EST√O GRAVANDO SEMPRE "0"
                                                                  '0',  // VALORES EST√O GRAVANDO SEMPRE "0"
                                                                  '0',  // VALORES EST√O GRAVANDO SEMPRE "0"
                                                                  '0',  // VALORES EST√O GRAVANDO SEMPRE "0"
                                                                  '0',  // VALORES EST√O GRAVANDO SEMPRE "0"
                                                                  '0'); // VALORES EST√O GRAVANDO SEMPRE "0"


    ARR_CFG_COMP_CUSTO_VALCAM  : array[0..12] of Integer = (1           , 2           , 4           , 8           ,
                                                            16          , 32          , 64          , 128         ,
                                                            256         , 512         , 1024        , 2048        ,
                                                            4096 );

    ARR_CFG_COMP_CUSTO_DISPLAY : array[0..12] of String = ('PreÁo de Custo',
                                                           'PreÁo MÈdio',
                                                           'PreÁo de ⁄ltima Compra',
                                                           'PreÁo ⁄lt. Compra com Impostos Entrada',
                                                           'Outros Valores',
                                                           'ICMS de SaÌda',
                                                           'Impostos Federais',
                                                           'Despesas Operacionais',
                                                           'Frete',
                                                           'Valor Juros do PrÁ. de Custo',
                                                           'Valor Difal',
                                                           'Valor FCP',
                                                           'ICMS de Entrada da Op. PrÛpria');

    CLAFIS_REGISTRADO_ECF     = '"5929_6929_"';

    IDX_ENTREGA = 0;
    IDX_RETIRA  = 1;
    IDX_VAZIO   = -1;

    ARR_LOC_RET: array[0..3] of String = ('C', 'E', 'B', 'B2');
    ARR_LOC_RET_DESC: array[0..3] of String = ('CAIXA', 'EXPEDI«√O', 'BALC√O', 'BALC√O 2');

    MSG_ASSUNTO_REQUISICAO_ATENDIDA = 'REQUISI«√O ATENDIDA';
    MSG_ASSUNTO_REQUISICAO_INCLUIDA = 'REQUISI«√O INCLUÕDA';
    MSG_ASSUNTO_REQUISICAO_NEGADA   = 'REQUISI«√O NEGADA';

    STR_COMISSAO_FAIXA = 'COM_FAIXA';

CNS_TIP_ABF: array[0..13] Of Array[0..1] Of String = (
       ('PEF', 'PEF - ENTRADAS PESSOA FISÕCA (PF OU PJ SEM INSC. ESTADUAL)'),
       ('PEJ', 'PEJ - ENTRADAS PESSOA JURÕDICA (IND⁄STRIA)'),
       ('PER', 'PER - ENTRADAS PESSOA JURÕDICA (DISTRIBUI«√O/REVENDA/COMERCIALIZA«√O)'),
       ('PES', 'PES - ENTRADAS PESSOA JURÕDICA (SIMPLES NACIONAL - DISTRIBUI«√O / REVENDA / COMERCIALIZA«√O)'),
       ('PSI', 'PSI - ENTRADAS PESSOA JURÕDICA (SIMPLES NACIONAL - IND⁄STRIA)'),
       ('PII', 'PII - ENTRADAS PESSOA JURIDICA (IND⁄STRIA INCENTIVADA)'),
       ('NCO', 'NCO - SAIDAS N√O CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)'),
       ('CCO', 'CCO - SAÕDAS CONTRIBUINTE CONSUMIDOR'),
       ('CNC', 'CNC - SAÕDAS CONTRIBUINTE N√O CONSUMIDOR'),
       ('SNA', 'SNA - SAÕDAS SIMPLES NACIONAL'),
       ('CTA', 'CTA - SAÕDAS CONSTRUTORA'),
       ('PRU', 'PRU - SAÕDAS PRODUTOR RURAL'),
       ('IND', 'IND - SAÕDAS IND⁄STRIA'),
       ('TRS', 'TRS - SAÕDAS TRANSFER NCIAS ENTRE LOJAS'));

    ARR_TIPO_BRINDES: Array[0..4] Of Array[0..1] of String = (
      ('G', 'GARANTIA'), ('C', 'CORTESIA'), ('R', 'REVISAO'), ('M', 'MONTAGEM'), ('L', 'LOCACAO') );

   ARR_OCORRENCIA_SPCBRASIL: array[0..16] Of Array[0..1] Of String = (
       ('01', '01 - Pagamento da dÌvida'),
       ('02', '02 - RenegociaÁ„o da dÌvida'),
       ('03', '03 - Inclus„o indevida'),
       ('04', '04 - Ordem Judicial'),
       ('05', '05 - CorreÁ„o de endereÁo'),
       ('06', '06 - AtualizaÁ„o de valor - ValorizaÁ„o'),
       ('07', '07 - AtualizaÁ„o de valor - Pagamento parcial'),
       ('08', '08 - AtualizaÁ„o de data'),
       ('09', '09 - CorreÁ„o de nome'),
       ('10', '10 - CorreÁ„o de n˙mero de contrato'),
       ('11', '11 - CorreÁ„o de v·rios dados(valor/datas/...)'),
       ('12', '12 - Baixa por perda de controle de base'),
       ('13', '13 - Motivo n„o identificado'),
       ('95', '95 - Comunicado devolvido pelo correio'),
       ('96', '96 - DeterminaÁ„o judicial'),
       ('97', '97 - Decurso de prazo'),
       ('99', '99 - Motivo de baixa n„o identificado'));

   ARR_CODIGO_FINALIDADE_TED: array[0..11] Of Array[0..1] Of String = (
       ('00001', '00001 - Pagamento de Impostos, Tributos e Taxas'),
       ('00002', '00002 - Pagamento ‡ Concession·rias de ServiÁo P˙blico'),
       ('00003', '00003 - Pagamentos de Dividendos'),
       ('00004', '00004 - Pagamento de Sal·rios'),
       ('00005', '00005 - Pagamento de Fornecedores'),
       ('00006', '00006 - Pagamento de Honor·rios'),
       ('00007', '00007 - Pagamento de AluguÈis e Taxas de CondomÌnio'),
       ('00008', '00008 - Pagamento de Duplicatas e TÌtulos'),
       ('00009', '00009 - Pagamento de Mensalidade Escolar'),
       ('00010', '00010 - CrÈdito em Conta'),
       ('00011', '00011 - Pagamento a Corretoras'),
       ('00101', '00101 - Pens„o AlimentÌcia'));

   PROPRE_PRECO_DE_PROMOCAO = '1';
   PROPRE_PRECO_DE_TABELA = '2';

   FRETRA_NAO_UTILIZA_CALC_FRETE                = '1';
   FRETRA_POR_TRANSPORTADORA_CIDADE             = '2';
   FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA = '3';
   FRETRA_POR_FAIXA_FATURAMENTO                 = '4';
   FRETRA_POR_TRANSPORTADORA_REGIAO             = '5';

   OPC_LOTE = 'VN_TR_PD_DV_PR_OR_TE_DD_CS_OE_EF_UC_OU_BR_UC_EP_OF_NP_OV_ER_';
   OPC_OUTRAS_ENTRADAS_FOR = 'EF';
   OPC_OUTRAS_ENTRADAS_CLI = 'OE';
   OPC_OUTRAS_SAIDAS_FOR = 'OF';
   OPC_OUTRAS_SAIDAS_CLI = 'OU';
   OPC_OUTRAS_ENTRADAS = OPC_OUTRAS_ENTRADAS_FOR +'_'+ OPC_OUTRAS_ENTRADAS_CLI +'_';
   OPC_OUTRAS_SAIDAS = OPC_OUTRAS_SAIDAS_FOR +'_'+ OPC_OUTRAS_SAIDAS_CLI +'_';

   NOME_FILA_RETIRA = 'RETIRA';
   NOME_FILA_ENTREGA = 'ENTREGA';

   CAP_CODBAR_EMB = 'CÛdigo de Barras (Embalagem):';
   CAP_CODBAR_FOR = 'CÛdigo de Barras (FÛrmula):';
   CAP_MONTAR_CAIXA: String = '[F8] Montar Caixa (Embalagem)';
   CAP_FECHAR_CAIXA: String = '[F8] Fechar Caixa (Embalagem)';

   {**************************************}
   {* MATRIZ PARA COMANDOS A SEREM GRAV. *}
   {***********************************AF*}
   arrRep1: Array[0..16] Of String = ('INSERT', 'REPLACE', 'DELETE FROM', 'UPDATE', 'SET FOREIGN_KEY_CHECKS', 'CREATE TEMPORARY TABLE ESTANT', 'DROP TABLE IF EXISTS ESTANT',
                                      'CREATE TABLE TMP_NOVOITEEMB', 'CREATE TABLE TMP_NOVOITEGER', 'CREATE TABLE TMP_NOVOACAGER', 'CREATE TABLE TMP_NOVOCFGREL',
                                      'CREATE TABLE TMP_NOVOCNFBOL', 'CREATE TABLE TMP_NOVOLAYETI', 'CREATE TABLE TMP_NOVOCADLOT', 'CREATE TABLE TMP_NOVOCADCAR', 'CREATE TABLE TMP_NOVOCONEMP',
                                      'SET @AUTINC =');

   arrRep2: Array[0..16] Of String = (' INTO ', ' INTO ' , ''           , ' SET ' , ''                      , '',                              '',
                                      '',  '', '', '',
                                      '',  '', '', '', '', '');

   {* untFuncoesEditorFast *}
   MATRIACIAL_FONT_SIZE = 12;
   MATRIACIAL_FONT_NAME = 'Courier New';
   MATRIACIAL_FONT_PPI  = 96;

   ALTURA_FONTE_MATRICIAL_PIXEL  = 17;
   LARGURA_FONTE_MATRICIAL_PIXEL = 9.6; {10}

   MAXPAPERSIZE_JATO      = 7;
   MAXPAPERSIZE_MATRICIAL = 9;

   INDICECUSTOM_JATO = 2;
   INDICECUSTOM_MATR = 8;

   MEIOCMPIXEL  = 18.897637795;
   CMPIXEL = 37.795275591;

   FUNDO_FOLHA  = $00FFF5EC;

  {$IFNDEF LINUX}
   COR_CABEC_DADOS   = clYellow;
  {$ENDIF}
   COR_DADOS         = $00FFE0C1;
   COR_CABEC_PAGINA  = $00C9FFB7;

   COR_RODAPE_DADOS  = $0066B3FF;
   COR_RODAPE_PAGINA = $00FFFFCE;

   STR_040COL     = '#18#27#80#27#87#49';
   STR_040COL_OFF = '#27#87#48';
   STR_080COL     = '#18#27#80';
   STR_096COL     = '#18#27#77';
   STR_137COL     = '#15#27#80';
   STR_160COL     = '#15#27#77';

   VAL_CABEC_PAGINA  = 1;
   VAL_CABEC_DADOS   = 2;
   VAL_DADOS         = 3;
   VAL_RODAPE_DADOS  = 4;
   VAL_RODAPE_PAGINA = 5;

   FATOR_MARGEM_VERTICAL   = 4.49791666666667;
   FATOR_MARGEM_HORIZONTAL = 2.54;

  {***************************************************************}
  {* AO REFERENCIAR UM NOVO CAMPO A SER CRIPT. SEPARAR COM ";"   *}
  {* EX, CFG_CITPSP;CFG_XXXXXX;CFG_YYYYYY                        *}
  {* CRIAR TAMB…M REFER NCIA NA untConstantesNFe.consChavesCript *}
  {*************************************************************VA}
  consChavesCript:string='CFG_CITPSP;CFG_SENPDS;CFG_SENWBL';

  {*****************************************************************}
  {* LISTA DE CONFIGURA«’ES QUE SE ENCONTRADA A IMAGEM INDICADA NO *}
  {* CAMINHO, VALIDA A MESMA PARA VER SE N√O EST¡ CORROMPIDA E SE  *}
  {* ESTIVER, PASSA VAZIO PARA RETORNO DA CHAMADA PARA N√O DAR PAU *}
  {* NA IMPRESS√O                                                  *}
  {**************************************************************VA*}
  consCFGSQueValidaIMG:string='CFG_PATLOG_CFG_PATCAB_CFG_IMGBOL_';

  AUDITORIA_GRAVACAO_FATURAMENTO_CODIGO_SUCESSO : Integer = 0;

  AUDITORIA_GRAVACAO_FATURAMENTO_MSG_ERRO : String = 'Ocorreu uma inconsistÍncia no banco de dados.' + sLineBreak +
                                                     'Esta operaÁ„o n„o ser· realizada.' + sLineBreak +
                                                     'Entre em contato com a Citel.' + sLineBreak +
                                                     'CÛdigo(s) do(s) erro(s): %s ';


  AUDITORIA_GRAVACAO_RESUMO_CAIXA_CODIGO_SUCESSO : Integer = 0;

  AUDITORIA_GRAVACAO_RESUMO_CAIXA_MSG_ERRO : String = 'Ocorreu uma inconsistÍncia no banco de dados.' + sLineBreak +
                                                      'Esta operaÁ„o n„o ser· realizada.' + sLineBreak +
                                                      'Entre em contato com a Citel.' + sLineBreak +
                                                      'CÛdigo(s) do(s) erro(s): %s ';

  {******************************************************}
  {* CONFIGURACAO CFG_TPNFCR (TIPO DE NOTA DE CONCRETO) *}
  {***************************************************JC*}
  CONCREMASSA        = '1';
  FIGUEIREDO         = '2';
  PRESTCON           = '3';
  SECOL              = '4';
  J_A_MASSA_CONCRETO = '5';

  TIPEXP_NAO_UTILIZAR_EXPEDICAO = '1';
  TIPEXP_POR_DOCUMENTO_DE_VENDA = '2';
  TIPEXP_POR_PEDIDO_E_PEDIDO_SERA_FATURADO = '3';
  TIPEXP_POR_PEDIDO_E_PEDIDO_NAO_SERA_FATURADO = '4';
  TIPEXP_POR_ROMANEIO_E_PEDIDO_NAO_SERA_FATURADO = '5';

  Gerar_credito_do_valor_removido_apos_a_alteracao_do_pedido = '2';

  CHAVE_CRED_PROFISSIONAL = 'BAIXA_CREDITO_PROFISSIONAL';

  ARR_ESPDOC_TO_CODE : Array[1..28] of String = ('NF',  // 01 ( NOTA FISCAL )
                                                 'IF',  // 02 ( CUPOM FISCAL )
                                                 'MI',  // 03 ( MOVIMENTACAO DE ITENS )
                                                 'FF',  // 04 ( FATURAMENTO FUTURO )
                                                 'TE',  // 05 ( TRANSFERENCIA DE ESTOQUE )
                                                 'TA',  // 06 ( TRANSFERENCIA ENTRE ARMAZENS )
                                                 'BR',  // 07 ( BRINDE )
                                                 'TR',  // 08 ( TROCA DE MERCADORIAS )
                                                 'DV',  // 09 ( DEVOLUCAO )
                                                 'PD',  // 10 ( PEDIDO DE VENDA )
                                                 'OR',  // 11 ( OR«AMENTO DE VENDA )
                                                 'D1',  // 12 ( NOTA FISCAL SERIE D1 )
                                                 'UC',  // 13 ( USO E CONSUMO )
                                                 'AJ',  // 14 ( AJUSTE DE ESTOQUE )
                                                 'EP',  // 15 ( EMPRESTIMO )
                                                 'BE',  // 16 ( BAIXA DE EMPRESTIMO )
                                                 'PI',  // 17 ( BAIXA DE PIGMENTO )
                                                 'CS',  // 18 ( CONSIGNACAO )
                                                 'CR',  // 19 ( RETORNO DE CONSIGNACAO )
                                                 'GA',  // 20 ( GARANTIA RECEBIMENTO DO CLIENTE )
                                                 'GF',  // 21 ( GARANTIA ENVIO PARA FORNECEDOR )
                                                 'PR',  // 22 ( PEDIDO DE DEVOLUCAO RETIRADA )
                                                 'GR',  // 23 ( GARANTIA RETORNO DO FORNECEDOR )
                                                 'GC',  // 24 ( GARANTIA ENVIO PARA CLIENTE )
                                                 'ME',  // 25 ( MENSAGEM ENVIADA )
                                                 'PC',  // 26 ( PEDIDO DE COMPRA )
                                                 'RQ',  // 27 ( REQUISI«√O DE MATERIAL DE CONSUMO )
                                                 'RO'); // 28 ( SEPARA«√O DE PR…-ROMANEIO )

   {******************************}
   {* C”DIGOS E REFER NCIAS DDA  *}
   {***************************AJ*}
   NOME_OCORRENCIA_DDA: array[1..36] Of Array[0..1] Of String = (
       ('01', 'Entrada de TÌtulos'),
       ('02', 'Pedido de Baixa'),
       ('03', 'Protestos para Fins Alimentares'),
       ('04', 'Concess„o de Abatimento'),
       ('05', 'Cancelamento de Abatimento'),
       ('06', 'AlteraÁ„o de Vencimento'),
       ('07', 'Concess„o de Desconto'),
       ('08', 'Cancelamento de Desconto'),
       ('09', 'Protestar'),
       ('10', 'Sustar Protesto e Baixa de TÌtulo'),
       ('11', 'Sustar Protesto e Manter em Carteira'),
       ('12', 'AlteraÁ„o de Juros de Mora'),
       ('13', 'Dispensar CobranÁa de Juros de Mora'),
       ('14', 'AlteraÁ„o de Valor/Percentual de Multa'),
       ('15', 'Dispensar CobranÁa de Multa'),
       ('16', 'AlteraÁ„o do Valor de Desconto'),
       ('17', 'N„o Conceder Desconto'),
       ('18', 'AlteraÁ„o do Valor de Abatimento'),
       ('19', 'Prazo Limite de Recebimento - Alterar'),
       ('20', 'Prazo Limite de Recebimento - Dispensar'),
       ('21', 'Alterar N˙mero do TÌtulo dado pelo Cedente'),
       ('22', 'Alterar N˙mero de Controle do Participante'),
       ('23', 'Alterar Dados do Sacado'),
       ('24', 'Alterar Dados do Sacador/Avalista'),
       ('30', 'Recusa da DelegaÁ„o do Sacado'),
       ('31', 'AlteraÁ„o de Outros Dados'),
       ('33', 'AlteraÁ„o dos Dados do Rateio de CrÈdito'),
       ('34', 'Pedido de Cancelamento dos Dados do Rateio de CrÈdito'),
       ('35', 'Pedido de Desagendamento do DÈbito Autom·tico'),
       ('40', 'AlteraÁ„o de Carteira'),
       ('41', 'Cancelar Protesto'),
       ('42', 'AlteraÁ„o de EspÈcie de TÌtulo'),
       ('43', 'transferÍncia de Carteira/Modalidade de CobranÁa'),
       ('44', 'AlteraÁ„o de Contrato de CobranÁa'),
       ('45', 'NegativaÁ„o sem Protesto'),
       ('46', 'SolicitaÁ„o de Baixa de TÌtulo Negativado sem Protesto')
      );


  EXE_ACESSO_REMOTO_CITEL = 'AcessoRemotoCitel.exe';

  CHAVE_LOCK_SFAMOB = 'frmImportacaoSfaMobAndroid';
  PARAM_EXEC_SFAMOB = 'SFAMOBILEIMPORTACAO';
  LIMIT_TEMP_SFAMOB = 120;

  CHAVE_LOCK_MOVMER = 'IMPORTACAO-MOVME-ROM';
  PARAM_EXEC_MOVMER = 'AUTCOM-IMPORTE-ROM-MOVME';
  LIMIT_TEMP_MOVMER = 30;

  CLAFIS_DRAWBACK = '7127';

  TIP_DOC_ORI_SIMBOL: string='+1';
  TIP_DOC_ORI_DOCCNF: string='DOC.CNF.';
  TIP_DOC_ORI_ENTFUT: string='ENT.FUT.';
  TIP_DOC_ORI_PEDORC: string='PED.ORC.';
  TIP_DOC_ORI_DOCIF_: string='DOC.IF_.';

  TIP_NUM_FAT_DETFAT: string='DET.FAT.';
  TIP_NUM_FAT_FATFAT: string='FAT.FAT.';
  TIP_NUM_FAT_NOTFAT: string='NOT.FAT.';

  IDX_USO_CONSUMO  = 0;
  IDX_REVENDA      = 1;
  IDX_PRODUCAO     = 2;

  IDX_COMERCIALIZACAO  = 0;
  IDX_INDUSTRIALIZACAO = 1;

  IDX_ENTREGA_FUTURA   = 0;
  IDX_ENTREGA_IMEDIATA = 1;

  INT_SEM_ATRIBUICAO  = 1;
  INT_PARAMETRO       = 2;
  INT_CONSTANTE       = 3;
  INT_CAMPO           = 4;

  {Cliente est· na loja? S/N}
  IDX_CLIENTE_S_LOJA = 0;
  IDX_CLIENTE_N_LOJA = 1;
  STR_CAMPOS_COMPRA_LIQ = 'ITE_PRECOM_ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_' +
    'ITE_DESF05_ITE_DESF06_';


  STR_CAMPOS_CUSTO_GERAL = STR_CAMPOS_COMPRA_LIQ + '_' +
    'ITE_ICMENT_ITE_SUBFED_ITE_IPIENT_' +
    'ITE_FREENT_ITE_VALFRE_ITE_ACRFIN_ITE_SUBSTI_ITE_DESADB_' +
    'ITE_TSCUST_ITE_DEPICO_ITE_DEICMS_ITE_FATREG_IMPFED';

   STR_CAMPOS_APENAS_CUSREA =
    'ITE_OUTVAL1_ITE_OUTVAL2_ITE_OUTVAL3_ITE_OUTVAL4_ITE_OUTVAL5_ITE_OUTVAL6_ITE_OUTVAL7_' +
    'ITE_ICMSAI1_ITE_ICMSAI2_ITE_ICMSAI3_ITE_ICMSAI4_ITE_ICMSAI5_ITE_ICMSAI6_ITE_ICMSAI7_' +
    'ITE_DESOPE1_ITE_DESOPE2_ITE_DESOPE3_ITE_DESOPE4_ITE_DESOPE5_ITE_DESOPE6_ITE_DESOPE7_';



  STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR =
    'ITE_PRECOM_ITE_DESF01_ITE_DESF02_ITE_DESF03_ITE_DESF04_' +
    'ITE_DESF05_ITE_DESF06_ITE_ICMENT_ITE_SUBFED_ITE_IPIENT_' +
    'ITE_FREENT_ITE_VALFRE_ITE_ACRFIN_ITE_SUBSTI_ITE_DESADB_' +
    'ITE_OUTVAL_ITE_ICMSAI_ITE_IMPFED_ITE_DESOPE_ITE_TCIFCU_' +
    'ITE_TSCUST_ITE_DEPICO_ITE_DEICMS_ITE_FATREG_';

  STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR_ALT_GLO_FOR =  STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR + '_' + STR_CAMPOS_APENAS_CUSREA;


  STR_CAMPOS_CUSTOS_ITEFOR = STR_CAMPOS_CUSTOS_ALTPRE_ITEFOR +
    'ITE_UNICOM_ITE_MLTCOM_ITE_CODABF_ITE_DIAFOR_ITE_CLAIPI_' +
    'ITE_CODFAB_ITE_DESFAB_ITE_REFERE_' +
    'ITE_CODFOR_ITE_BAREMB_ITE_EMBALA_ITE_CODBAR_' +
    'ITE_PESOIT_ITE_CODGRP_ITE_SITPRO_ITE_NOTESP_';

  STR_CAMPOS_VENDA  = 'ITE_PREVE1_ITE_PREVE2_ITE_PREVE3_ITE_PREVE4_ITE_PREVE5_ITE_PREVE6_ITE_PREVE7';
  STR_CAMPOS_MARGEM = 'ITE_MARBR1_ITE_MARBR2_ITE_MARBR3_ITE_MARBR4_ITE_MARBR5_ITE_MARBR6_ITE_MARBR7';

  IDX_MOTIVO_FALTA_PRODUTO = 0;
  IDX_MOTIVO_AGUARDANDO_CLIENTE = 1;
  IDX_MOTIVO_PREVISAO_ENTREGA = 2;
  PASTA_IMAGEM_EMAIL_AUT = 'Imagens_Email';
                                                      {- TAG           - DESCRI«√O DA TAG                     - ESP…CIE QUE PODE UTILIZAR A TAG}
  arrVarEma: Array[0..89] of Array[0..2] of String = (('<<NOMCLI>>'   ,'Nome completo do Cliente'           , 'TODAS'),
                                                      ('<<PRICLI>>'   ,'Primeiro nome do Cliente'           , 'TODAS'),
                                                      ('<<CIDCLI>>'   ,'Cidade do Cliente'                  , 'TODAS'),
                                                      ('<<ORCVEN>>'   ,'OrÁamento de Venda'                 , 'OR_'),
                                                      ('<<PEDVEN>>'   ,'Pedido de Venda'                    , 'OR_PD_E2_E3_E4_E5_RO_BO_EF_TE_CB_SE_CH_AI_LP_LP_RE_'),
                                                      ('<<DOCVEN>>'   ,'Documento de Venda'                 , 'VN_E2_E3_E4_E5_RO_BO_EF_TE_CB_AN_FF_RC_RL_SE_CH_AI_RE_'),
                                                      ('<<TRANSP>>'   ,'Transportadora'                     , 'OR_PD_VN_E2_E3_E4_E5_RO_BO_AC_EF_TE_AN_FF_AI_RE_'),
                                                      ('<<NROVEN>>'   ,'N˙mero Documento de Venda'          , 'VN_E2_E3_E4_E5_RO_BO_AC_CD_EF_TE_CB_AN_FF_RC_RL_SE_CH_AI_'),
                                                      ('<<EMPVEN>>'   ,'Empresa de Venda'                   , 'VN_E2_E3_E4_E5_RO_BO_AC_CD_EF_TE_CB_AN_FF_RC_RL_SE_CH_AI_RE_'),
                                                      ('<<ESPVEN>>'   ,'EspÈcie de Venda'                   , 'VN_E2_E3_E4_E5_RO_BO_AC_CD_EF_TE_CB_AN_FF_RC_RL_SE_CH_AI_RE_'),
                                                      ('<<LINDIG>>'   ,'Linha Digit·vel'                    , 'BO_AC_'),
                                                      ('<<EMACOB>>'   ,'E-Mail de cobranÁa'                 , 'BO_AC_PX_PC_CB_AD_'),
                                                      ('<<DTAEMI>>'   ,'Data Emiss„o da Venda'              , 'BO_AC_CD_CB_RC_CH_AN_'),
                                                      ('<<VALDUP>>'   ,'Valor do TÌtulo'                    , 'BO_AC_CH_'),
                                                      ('<<PARCEL>>'   ,'Parcela do TÌtulo'                  , 'BO_AC_'),
                                                      ('<<DTAVEN>>'   ,'Data Vencimento do TÌtulo'          , 'BO_AC_'),
                                                      ('<<CUPDES>>'   ,'Cupom de desconto'                  , 'CD_'),
                                                      ('<<TOTCUP>>'   ,'Valor cupom de desconto'            , 'CD_'),
                                                      ('<<INFCUP>>'   ,'InformaÁıes do cupom'               , 'CD_'),
                                                      ('<<NUMEOS>>'   ,'Conserto do Equipamento OS'         , 'CE_'),
                                                      ('<<LNKBOL>>'   ,'Link do Boleto'                     , 'BO_AC_'),
                                                      ('<<TABDUP>>'   ,'Tabela de Duplicatas'               , 'BO_AC_AD_'),
                                                      ('<<NROCON>>'   ,'N˙mero do Documento de ConfirmaÁ„o' , 'CF_'),
                                                      ('<<ESPCON>>'   ,'EspÈcie do Documento de ConfirmaÁ„o', 'CF_'),
                                                      ('<<EMPCON>>'   ,'Empresa do Documento de ConfirmaÁ„o', 'CF_'),
                                                      ('<<DOCCON>>'   ,'Documentos confirmados'             , 'CF_'),
                                                      ('<<QRCODE>>'   ,'Texto QRCode Pix'                   , 'PD_PX_PC_AN_FF_BO_AC_'),
                                                      ('<<TABDUPPX>>' ,'Tabela de Duplicatas'               , 'PX_'),
                                                      ('<<NOMVEN>>'   ,'Primeiro Nome do Vendedor'          , 'OR_PD_LP_'),
                                                      ('<<VALORC>>'   ,'Valor do OrÁamento'                 , 'OR_'),
                                                      ('<<DTACAD>>'   ,'Data de Cadastro'                   , 'OR_LP_'),
                                                      ('<<TELCLI>>'   ,'Telefone do Cliente'                , 'OR_'),
                                                      ('<<PRECHE>>'   ,'Previs„o de Chegada'                , 'TE_'),
                                                      ('<<MSGOCO>>'   ,'Mensagem da OcorrÍncia'             , 'TE_'),
                                                      ('<<DTACON>>'   ,'Data e Hora da Conclus„o da Entrega' , 'TE_'),
                                                      ('<<LNKPAG>>'   ,'Link de Pagamento'                  , 'CB_'),
                                                      ('<<NROCTR>>'   ,'N˙mero do Contrato'                 , 'RL_FF_NS'),
                                                      ('<<CODSER>>'   ,'CÛdigo do ServiÁo'                  , 'SE_'),
                                                      ('<<DESSER>>'   ,'DescriÁ„o do ServiÁo'               , 'SE_'),
                                                      ('<<PLAVEI>>'   ,'Placa do VeÌculo'                   , 'SE_'),
                                                      ('<<MSGSTA>>'   ,'Mensagem do Status'                 , 'SE_'),
                                                      ('<<MODVEI>>'   ,'Modelo do VeÌculo'                  , 'SE_'),
                                                      ('<<TOTDUP>>'   ,'Total Extrato Duplicatas Conf.'     , 'CF_'),
                                                      ('<<TOTREC>>'   ,'Total Receber Duplicatas Conf.'     , 'CF_'),
                                                      ('<<TOTDEB>>'   ,'Total DÈbitos Duplicatas Conf.'     , 'CF_'),
                                                      ('<<TBDCNF>>'   ,'Tabela Duplicatas Docs. Conf.'      , 'CF_'),
                                                      ('<<GRUOCO>>'   ,'Grupo da OcorrrÍncia'               , 'DC_'),
                                                      ('<<DTAOCO>>'   ,'Data/Hora OcorrÍncia'               , 'DC_'),
                                                      ('<<DTACOC>>'   ,'Data/Hora Conclus„o OcorrÍncia'     , 'DC_'),
                                                      ('<<TIPOCO>>'   ,'Tipo da Ocorrencia'                 , 'DC_'),
                                                      ('<<COMOCO>>'   ,'Complemento da OcorrÍncia'          , 'DC_'),
                                                      ('<<OPEORI>>'   ,'Operador de Origem'                 , 'DC_'),
                                                      ('<<COMDES>>'   ,'Complemento de Destino'             , 'DC_'),
                                                      ('<<LEADOC>>'   ,'Lead da OcorrÍncia'                 , 'DC_'),
                                                      ('<<HISOCO>>'   ,'HistÛrico da OcorrÍncia'            , 'DC_'),
                                                      ('<<PROOCO>>'   ,'Protocolo da OcorrÍncia'            , 'DC_'),
                                                      ('<<USUDES>>'   ,'Usu·rio de Destino'                 , 'DC_'),
                                                      ('<<CODCLI>>'   ,'Codigo do Cliente'                  , 'DC_'),
                                                      ('<<NOMCVE>>'   ,'Nome Completo do Vendedor'          , 'OR_PD_'),
                                                      ('<<CONVEN>>'   ,'Contato do Vendedor'                , 'OR_PD_'),
                                                      ('<<VALPED>>'   ,'Valor do Pedido'                    , 'CB_LP_'),
                                                      ('<<NUMCSH>>'   ,'N˙mero do Cashback'                 , 'CH_'),
                                                      ('<<DTACSH>>'   ,'Data do Cashback'                   , 'CH_'),
                                                      ('<<VLRCSH>>'   ,'Valor do Cashback'                  , 'CH_'),
                                                      ('<<DTAVAL>>'   ,'Data de Validade do Cashback'       , 'CH_'),
                                                      ('<<TOTDSP>>'   ,'Valor Total Cashback DisponÌvel'    , 'CH_'),
                                                      ('<<DIASVEN>>'  ,'Dias do vencimento'                 , 'AC_'),
                                                      ('<<NOMLOJ>>'   ,'Nome da Loja'                       , 'TODAS'),
                                                      ('<<STAENT>>'   ,'Status da Entrega'                  , 'AI_'),
                                                      ('<<DESENT>>'   ,'DescriÁ„o do Status de Entrega'     , 'AI_'),
                                                      ('<<LIKRAS>>'   ,'Link de Rastreamento da Entrega'    , 'AI_'),
                                                      ('<<LNKPGT>>'   ,'Link de Pagamento'                  , 'LP_'),
                                                      ('<<CGCEMP>>'   ,'CNPJ da empresa emissora'           , 'AN_BO_'),
                                                      ('<<CGCCLI>>'   ,'CNPJ/CPF do cliente'                , 'AN_BO_'),
                                                      ('<<SERIE_>>'   ,'N˙mero de sÈrie do documento'       , 'AN_BO_'),
                                                      ('<<ACESSO>>'   ,'Chave de acesso do documento'       , 'AN_BO_'),
                                                      ('<<HOREMI>>'   ,'Hora emiss„o do documento'          , 'AN_BO_'),
                                                      ('<<ENDEMP>>'   ,'EndereÁo completo da empresa'       , 'AN_BO_'),
                                                      ('<<ENDCLI>>'   ,'EndereÁo completo do cliente'       , 'AN_BO_'),
                                                      ('<<NOMITE>>'   ,'Nome do Produto'                    , 'PR_'),
                                                      ('<<CODITE>>'   ,'CÛdigo do Produto'                  , 'PR_'),
                                                      ('<<CIDPED>>'   ,'Cidade Pedido'                      , 'PD_'),
                                                      ('<<UF_PED>>'   ,'UF Pedido'                          , 'PD_'),
                                                      ('<<ENDPED>>'   ,'EndereÁo Pedido'                    , 'PD_'),
                                                      ('<<COMPED>>'   ,'Complemento do EndereÁo Pedido'     , 'PD_'),
                                                      ('<<BAIPED>>'   ,'Bairro Pedido'                      , 'PD_'),
                                                      ('<<CEPPED>>'   ,'CEP Pedido'                         , 'PD_'),
                                                      ('<<REFEND>>'   ,'ReferÍncia do EndereÁo Pedido'      , 'PD_'),
                                                      ('<<NOMMOT>>'   ,'Nome do Motorista'                  , 'TE_'),
                                                      ('<<CODRAS>>'   ,'CÛdigo de Rastreamento'             , 'RE_'));

  arrVarEmE: Array[0..10] of Array[0..2] of String = (('<<PEDCOM>>','Pedido de Compra'            , 'PD_'),
                                                      ('<<ESPCOM>>','EspÈcie de Compra'           , 'PD_'),
                                                      ('<<EMPCOM>>','Empresa Origem da Compra'    , 'PD_'),
                                                      ('<<EMPDES>>','Empresa Destino da Compra'   , 'PD_'),
                                                      ('<<TOTCOM>>','Valor Total da Compra'       , 'PD_'),
                                                      ('<<DTAEMI>>','Data de Emiss„o da Compra'   , 'PD_'),
                                                      ('<<DTAENT>>','Data de Entrega da Compra'   , 'PD_'),
                                                      ('<<CODFOR>>','CÛdigo do Fornecedor'        , 'TODAS'),
                                                      ('<<RAZFOR>>','Raz„o Social do Fornecedor'  , 'TODAS'),
                                                      ('<<FANFOR>>','Nome Fantasia do Fornecedor' , 'TODAS'),
                                                      ('<<CGCFOR>>','CNPJ/CPF do Fornecedor'      , 'TODAS'));

  MSG_ESPECIE_EMISSAO_NAO_PERMITIDA : String = 'A espÈcie escolhida n„o È permitida para emiss„o de documentos.' + sLineBreak +
                                               'FaÁa a alteraÁ„o para outra espÈcie ou se n„o for possÌvel, entre em contato com a Citel para realizar as devidas configuraÁıes.'+ sLineBreak +
                                               'ConfiguraÁ„o: %s';

  MSG_ESPECIES_PERMITIDAS_VENDA_PRESENCIAL = 'Para operaÁıes de Venda Presencial È permitido faturar apenas na(s) EspÈcie(s): %s. [CFG_ESPVPR]';

  //JOIN USADO PARA LEVANTAR MENOR E MAIOR DATA DE ENTRADA DENTRE OS DOCUMENTOS
  //DA A.D. PARA O SELECT DA CARGA DOS ITENS A SEREM DEVOLVIDOS N√O FICAR PESADA
  ADEDET_JOIN_MOVDET =
      '  ADEDET AD ' +
      '  LEFT JOIN MOVDET DT ' +
      '     ON AD.DET_TIP_FC = DT.DET_TIP_FC ' +
      '    AND AD.DET_NUMDOC = DT.DET_NUMDOC ' +
      '    AND AD.DET_ESPDOC = DT.DET_ESPDOC ' +
      '    AND AD.DET_CODEMP = DT.DET_CODEMP ' +
      '    AND AD.DET_SERIE_ = DT.DET_SERIE_ ' +
      '    AND AD.DET_CODITE = DT.DET_CODITE ' +
      '    AND ((DT.DET_JAFATU = 0) OR ' +
      '         ((SELECT COUNT(*) FROM NOTDET DES ' +
      '            WHERE DES.DET_NUMDOC = DT.DET_NUMFAT ' +
      '              AND DES.DET_ESPDOC = DT.DET_TIPFAT ' +
      '              AND DES.DET_CODEMP = DT.DET_EMPFAT ' +
      '              AND DES.DET_ESPDOC = "NF" ' +
      '              AND DT.DET_ESPDOC = "IF") > 0)) ' +
      '  LEFT JOIN NOTDET NT ' +
      '     ON AD.DET_TIP_FC = NT.DET_TIP_FC ' +
      '    AND AD.DET_NUMDOC = NT.DET_NUMDOC ' +
      '    AND AD.DET_ESPDOC = NT.DET_ESPDOC ' +
      '    AND AD.DET_CODEMP = NT.DET_CODEMP ' +
      '    AND AD.DET_SERIE_ = NT.DET_SERIE_ ' +
      '    AND AD.DET_CODITE = NT.DET_CODITE ' +
      '    AND ((SELECT COUNT(*) FROM MOVDET ORI ' +
      '          WHERE NT.DET_NUMDOC = ORI.DET_NUMFAT ' +
      '            AND NT.DET_ESPDOC = ORI.DET_TIPFAT ' +
      '            AND NT.DET_CODEMP = ORI.DET_EMPFAT ' +
      '            AND NT.DET_ESPDOC = "NF" ' +
      '            AND ORI.DET_ESPDOC = "IF") = 0) ';


  SELECT_STATUS_OS = '  IF(EQU_STATUS = "E", CONCAT("EM ABERTO", IF(EQU_SUBSTA = "P"," (AGUARD.PE«AS)","") ) , ' +
                     '  IF(EQU_STATUS = "F", "ORCAMENTO REALIZADO", '   +
                     '  IF(EQU_STATUS = "N", "REPROVADA", ' +
                     '  IF(EQU_STATUS = "A", "APROVADA", '  +
                     '  IF(EQU_STATUS = "M", "EM MANUTEN«√O", '  +
                     '  IF(EQU_STATUS = "R", CONCAT("REALIZADA", IF(EQU_SUBSTA = "A"," (ARMAZENADA)", IF(EQU_SUBSTA = "C"," (DEVOLVIDA AO CLIENTE)", ""))), "")))))) ';

  SELECT_STATUS_OS_LEFT = '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "E", CONCAT("EM ABERTO", IF(IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "P"," (AGUARD.PE«AS)","") ) , ' +
                          '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "F", "ORCAMENTO REALIZADO", '   +
                          '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "N", "REPROVADA", ' +
                          '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A", "APROVADA", '  +
                          '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "M", "EM MANUTEN«√O", '  +
                          '  IF(IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "R", CONCAT("REALIZADA", IF(IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "A"," (ARMAZENADA)", IF(IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "C"," (DEVOLVIDA AO CLIENTE)", ""))), "")))))) ';

  SELECT_RELATORIO_OS = '  CASE '  +
                        '    WHEN (EQU_STATUS = "F") THEN "OR«AMENTO REALIZADO" '  +
                        '    WHEN (EQU_STATUS = "M") AND (EQU_SUBSTA = "C") THEN "EM MANUTEN«√O (COMPLETA)" '  +
                        '    WHEN (EQU_STATUS = "M") AND (EQU_SUBSTA = "A") THEN "EM MANUTEN«√O (AGUARDANDO ITENS)" '  +
                        '    WHEN (EQU_STATUS = "E") AND (COALESCE(EQU_SUBSTA,"") = "") THEN "EM ABERTO" '  +
                        '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "O") THEN "EM ABERTO (OR«AMENTO)" '  +
                        '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "P") THEN "EM ABERTO (AGUARDANDO PE«AS)" '  +
                        '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "C") THEN "EM ABERTO (AGUARDANDO CLIENTE)" '  +
                        '    WHEN (EQU_STATUS = "N") AND (COALESCE(EQU_SUBSTA,"") = "") THEN "REPROVADA" '  +
                        '    WHEN (EQU_STATUS = "N") AND (EQU_SUBSTA = "C") THEN "REPROVADA (DEVOLVIDA AO CLIENTE)" '  +
                        '    WHEN (EQU_STATUS = "N") AND (EQU_SUBSTA = "A") THEN "REPROVADA (ARMAZENADA)" '  +
                        '    WHEN (EQU_STATUS = "A") AND (COALESCE(EQU_SUBSTA,"") = "") THEN "APROVADA" '  +
                        '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "C") THEN "APROVADA CLIENTE" '  +
                        '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "G") THEN "APROVADA GARANTIA" '  +
                        '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "B") THEN "APROVADA CORTESIA" '  +
                        '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "N") THEN (SELECT MRE_DESCRI FROM CADMRE WHERE MRE_CODIGO = EQU_CODMRE) '  +
                        '    WHEN (EQU_STATUS = "R") AND '  +
                        '         ((SELECT DISTINCT FGO_JAFATU '  +
                        '           FROM FATGOR F WHERE (FGO_NUMDOC = G.EQU_NUMPED) '  +
                        '                           AND (FGO_ESPDOC = G.EQU_TIPPED) '  +
                        '                           AND (FGO_CODEMP = G.EQU_EMPPED)) = 0) THEN "REALIZADA (N√O FATURADA)" '  +
                        '    WHEN (EQU_STATUS = "R") AND '  +
                        '         ((SELECT DISTINCT FGO_JAFATU '  +
                        '           FROM FATGOR F ' +
                        '           WHERE (FGO_NUMDOC = G.EQU_NUMPED) '  +
                        '             AND (FGO_ESPDOC = G.EQU_TIPPED) '  +
                        '             AND (FGO_CODEMP = G.EQU_EMPPED)) = 1) THEN "REALIZADA (FATURADA)" '  +
                        '    ELSE "" '  +
                        '  END ';

  SELECT_SUBSTA_OS = '  CASE '  +
                     '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "O") THEN "OR«AMENTO" '  +
                     '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "P") THEN "AGUARDANDO PE«AS" '  +
                     '    WHEN (EQU_STATUS = "E") AND (EQU_SUBSTA = "C") THEN "AGUARDANDO CLIENTE" '  +
                     '    WHEN (EQU_STATUS = "N") AND (EQU_SUBSTA = "C") THEN "DEVOLVIDA AO CLIENTE" '  +
                     '    WHEN (EQU_STATUS = "N") AND (EQU_SUBSTA = "A") THEN "ARMAZENADA" '  +
                     '    WHEN (EQU_STATUS = "M") AND (EQU_SUBSTA = "C") THEN "COMPLETA" '  +
                     '    WHEN (EQU_STATUS = "M") AND (EQU_SUBSTA = "A") THEN "AGUARDANDO ITENS" '  +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "C") THEN "APROVADA CLIENTE" '  +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "G") THEN "APROVADA GARANTIA" '  +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "B") THEN "APROVADA CORTESIA" '  +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA = "N") THEN (SELECT MRE_DESCRI FROM CADMRE WHERE MRE_CODIGO = EQU_CODMRE) '  +
                     '    WHEN (EQU_STATUS = "R") AND ' +
                     '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                     '           FROM FATDOR F ' +
                     '           WHERE (FDO_JAFATU = 1) '+
                     '             AND (FDO_NUMDOC = EQU_NUMPED) ' +
                     '             AND (FDO_ESPDOC = EQU_TIPPED) ' +
                     '             AND (FDO_CODEMP = EQU_EMPPED)) = 0) THEN "N√O FATURADAS" ' +
                     '    WHEN (EQU_STATUS = "R") AND '  +
                     '         ((SELECT DISTINCT FGO_JAFATU '  +
                     '           FROM FATGOR F ' +
                     '           WHERE (FGO_NUMDOC = EQU_NUMPED) '  +
                     '             AND (FGO_ESPDOC = EQU_TIPPED) '  +
                     '             AND (FGO_CODEMP = EQU_EMPPED)) = 1) THEN "FATURADAS" '  +
                     '    WHEN (EQU_STATUS = "R") AND ' +
                     '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                     '           FROM FATDOR F ' +
                     '           WHERE (FDO_NUMDOC = EQU_NUMPED) ' +
                     '             AND (FDO_ESPDOC = EQU_TIPPED) ' +
                     '             AND (FDO_CODEMP = EQU_EMPPED)) = 2) THEN "PARCIALMENTE FATURADAS" ' +
                     '    ELSE "" '  +
                     '  END ';

  SELECT_SUBSTA_OS_LEFT = '  CASE '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "E") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "O") THEN "OR«AMENTO" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "E") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "P") THEN "AGUARDANDO PE«AS" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "E") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "C") THEN "AGUARDANDO CLIENTE" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "N") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "C") THEN "DEVOLVIDA AO CLIENTE" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "N") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "A") THEN "ARMAZENADA" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "M") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "C") THEN "COMPLETA" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "M") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "A") THEN "AGUARDANDO ITENS" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "C") THEN "APROVADA CLIENTE" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "G") THEN "APROVADA GARANTIA" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "B") THEN "APROVADA CORTESIA" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) = "N") THEN ' +
                          '         (SELECT MRE_DESCRI FROM CADMRE WHERE MRE_CODIGO = IFNULL(EQ.EQU_CODMRE, EQ2.EQU_CODMRE)) '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "R") AND ' +
                          '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                          '           FROM FATDOR F ' +
                          '           WHERE (FDO_JAFATU = 1) '+
                          '             AND (FDO_NUMDOC = IFNULL(EQ.EQU_NUMPED, EQ2.EQU_NUMPED)) ' +
                          '             AND (FDO_ESPDOC = IFNULL(EQ.EQU_TIPPED, EQ2.EQU_TIPPED)) ' +
                          '             AND (FDO_CODEMP = IFNULL(EQ.EQU_EMPPED, EQ2.EQU_EMPPED))) = 0) THEN "N√O FATURADAS" ' +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "R") AND '  +
                          '         ((SELECT DISTINCT FGO_JAFATU '  +
                          '           FROM FATGOR F ' +
                          '           WHERE (FGO_NUMDOC = IFNULL(EQ.EQU_NUMPED, EQ2.EQU_NUMPED)) '  +
                          '             AND (FGO_ESPDOC = IFNULL(EQ.EQU_TIPPED, EQ2.EQU_TIPPED)) '  +
                          '             AND (FGO_CODEMP = IFNULL(EQ.EQU_EMPPED, EQ2.EQU_EMPPED))) = 1) THEN "FATURADAS" '  +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "R") AND ' +
                          '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
                          '           FROM FATDOR F ' +
                          '           WHERE (FDO_NUMDOC = IFNULL(EQ.EQU_NUMPED, EQ2.EQU_NUMPED)) ' +
                          '             AND (FDO_ESPDOC = IFNULL(EQ.EQU_TIPPED, EQ2.EQU_TIPPED)) ' +
                          '             AND (FDO_CODEMP = IFNULL(EQ.EQU_EMPPED, EQ2.EQU_EMPPED))) = 2) THEN "PARCIALMENTE FATURADAS" ' +
                          '    ELSE "" '  +
                          '  END ';

  SELECT_SITUAC_OS = '  CASE ' +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA <> "N") AND (EQU_AG_MON = "S") THEN "AGUARDANDO MONTAGEM" ' +
                     '    WHEN (EQU_STATUS = "A") AND (EQU_SUBSTA <> "N") AND (LOCATE("S",(SELECT GROUP_CONCAT(EQU_AGUARD) FROM EQUDET WHERE EQUDET.EQU_SEQGER = EQUGER.AUTOINCREM)) > 0) THEN "AGUARDANDO PE«AS" ' +
                     '    ELSE "" ' +
                     '  END ';

  SELECT_SITUAC_OS_LEFT = '  CASE ' +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) <> "N") AND (IFNULL(EQ.EQU_AG_MON, EQ2.EQU_AG_MON) = "S") THEN "AGUARDANDO MONTAGEM" ' +
                          '    WHEN (IFNULL(EQ.EQU_STATUS, EQ2.EQU_STATUS) = "A") AND (IFNULL(EQ.EQU_SUBSTA, EQ2.EQU_SUBSTA) <> "N") AND (LOCATE("S",(SELECT GROUP_CONCAT(EQU_AGUARD) ' +
                          '          FROM EQUDET WHERE EQUDET.EQU_SEQGER = IFNULL(EQ.AUTOINCREM, EQ2.AUTOINCREM))) > 0) THEN "AGUARDANDO PE«AS" ' +
                          '    ELSE "" ' +
                          '  END ';

  SELECT_SITUAC_EQ = '  CASE ' +
                     '    WHEN (EQU_SITEQU = "SA") THEN "OS REALIZADA - ARMAZENADO"            ' +
                     '    WHEN (EQU_SITEQU = "SR") THEN "OS REALIZADA - RETIRADO PELO CLIENTE" ' +
                     '    WHEN (EQU_SITEQU = "NA") THEN "OS REPROVADA - ARMAZENADO"            ' +
                     '    WHEN (EQU_SITEQU = "NR") THEN "OS REPROVADA - RETIRADO PELO CLIENTE" ' +
                     '    ELSE "" ' +
                     '  END ';

  SELECT_PD_EQUGOR = ' SELECT DISTINCT FGO_NUMDOC NUMDOC, FGO_CODEMP CODEMP, FGO_CODCLI CODCLI, FGO_DTAENT DTAENT, FGO_GARANT GARANT, FGO_ITEPED ITEPED, FDO_EMPITE EMPITE ' +
                     ' FROM EQUGOR ' +
                     ' INNER JOIN FATGOR ON EQUGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                     ' INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FDO_SEQGER ' +
                     ' WHERE EQUGOR.FGO_SEQEQU = :SEQEQU ';

  SELECT_PRECOS_PRODUTO_ACABADO = ' SELECT         ' +
                                  '   ACA_PREVE1,  ' +
                                  '   ACA_PREVE2,  ' +
                                  '   ACA_PREVE3,  ' +
                                  '   ACA_PREVE4,  ' +
                                  '   ACA_PREVE5,  ' +
                                  '   ACA_PREVE6,  ' +
                                  '   ACA_PREVE7,  ' +
                                  '   ACA_PRECUS,  ' +
                                  '   ACA_OUTVAL,  ' +
                                  '   ACA_PREMED,  ' +
                                  '   ACA_PREULT,  ' +
                                  '   ACA_IMPULT,  ' +
                                  '   ACA_PREVEN,  ' +
                                  '   ACA_DESOPE,  ' +
                                  '   ACA_IMPFED,  ' +
                                  '   ACA_ICMSAI   ' +
                                  ' FROM           ' +
                                  '   ACAGER       ' +
                                  ' WHERE          ' +
                                  '   ACA_CODACA = :CODACA AND ' +
                                  '   ACA_CODEMP = :CODEMP     ';

  SQL_ATRIBUTOS_PRODUTO =
    '  SELECT SQL_NO_CACHE                                               ' +
    '    GRU_DESCRI AS "Grupo",                                          ' +
    '    ATR_DESCRI AS "Descricao" ,                                     ' +
    '    DATE_FORMAT(DAT_VALATR, "%d/%m/%Y") AS "Valor"                  ' +
    '  FROM                                                              ' +
    '    ATRDAT                                                          ' +
    '    INNER JOIN CADATR                                               ' +
    '      ON ATR_CODIGO = DAT_CODATR                                    ' +
    '    LEFT JOIN GRUATR                                                ' +
    '      ON GRU_CODIGO = ATR_CODGRU                                    ' +
    '  WHERE DAT_CODITE = :CODITE                                        ' +
    '  UNION                                                             ' +
    '  SELECT                                                            ' +
    '    GRU_DESCRI,                                                     ' +
    '    ATR_DESCRI,                                                     ' +
    '    STR_VALATR                                                      ' +
    '  FROM                                                              ' +
    '    ATRSTR                                                          ' +
    '    INNER JOIN CADATR                                               ' +
    '      ON ATR_CODIGO = STR_CODATR                                    ' +
    '    LEFT JOIN GRUATR                                                ' +
    '      ON GRU_CODIGO = ATR_CODGRU                                    ' +
    '  WHERE STR_CODITE = :CODITE                                        ' +
    '  UNION                                                             ' +
    '  SELECT                                                            ' +
    '    GRU_DESCRI,                                                     ' +
    '    ATR_DESCRI,                                                     ' +
    '    IF(NUM_VALAT2 IS NULL, FORMAT(NUM_VALATR,                       ' +
    '                                  IFNULL(ATR_NRODEC, 1), "pt_BR"),  ' +
    '           CONCAT("MÌn. ", FORMAT(NUM_VALATR,                       ' +
    '                                  IFNULL(ATR_NRODEC, 1), "pt_BR"),  ' +
    '               " - M·x. ", FORMAT(NUM_VALAT2,                       ' +
    '                                  IFNULL(ATR_NRODEC, 1), "pt_BR"))) ' +
    '  FROM                                                              ' +
    '    ATRNUM                                                          ' +
    '    INNER JOIN CADATR                                               ' +
    '      ON ATR_CODIGO = NUM_CODATR                                    ' +
    '    LEFT JOIN GRUATR                                                ' +
    '      ON GRU_CODIGO = ATR_CODGRU                                    ' +
    '  WHERE NUM_CODITE = :CODITE                                        ' +
    '  ORDER BY Grupo, Descricao;                                        ' ;


  MSG_ALTERACAO_PRECO_VENDA_DINAMICA : String = 'Esta alteraÁ„o implica no rec·lculo do preÁo de venda dos produtos desta abreviaÁ„o.' + sLineBreak +
                                                'Ser· necess·rio informar o respons·vel pela atualizaÁ„o de preÁos para que faÁa as devidas alteraÁıes globais.' + sLineBreak +
                                                'Os produtos estar„o bloqueados para venda atÈ que sejam regularizados.' + sLineBreak +
                                                'Confirma a gravaÁao?';

  MSG_TRAVA_PRECO_VENDA_DINAMICA : String = 'Este produto est· com pendÍncia de rec·lculo de preÁos, devido ‡ alteraÁ„o de abreviaÁ„o fiscal.' + sLineBreak +
                                            'Ser· necess·rio informar o respons·vel pela atualizaÁ„o de preÁos para que faÁa as devidas alteraÁıes globais.' + sLineBreak +
                                            'Os produtos nesta situaÁ„o estar„o bloqueados para venda atÈ que sejam regularizados.';

  ARQUIVO_OPCOES_TEF : String = 'opcoes_tef.ini';


  arr_SITUACAOTRIBUTARIAPISCOFINS: Array[0..4] Of
                                     Array[0..1] Of String =
                                       (('T', 'Tributado    '),
                                        ('I', 'Isento       '),
                                        ('S', 'Suspenso     '),
                                        ('D', 'Diferido     '),
                                        ('Z', 'Tributado aliquota zero'));

  arr_SITUACAOTRIBUTARIAIPI: Array[0..4] Of
                               Array[0..1] Of String =
                                 (('T', 'Tributado    '),
                                  ('I', 'Isento       '),
                                  ('M', 'Imune        '),
                                  ('S', 'Suspenso     '),
                                  ('N', 'N„o Tributado'));

  MASK_CONPAG  = '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
  MASK_CONPAG2 = 'aa.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
  MASK_CONPAG3 = '!99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';
  MASK_CONPAG4 = '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;1;_';
  MASK_CONPAG5 = '(99).999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999;0;_';

  TEMPO_EXECUCAO_IMPORTADOR_CTE = 10;

  CODIGO_CLIENTE_VENDEDOR_MARCA = '1' ;
  CODIGO_CLIENTE_VENDEDOR_FORNECEDOR = '2' ;
  clMagenta = 16711935;

  CONST_PERCENTUAL_DIFERIMENTO_RICMS = 33.33;

  VENDA_REMESSA_FORA_ESTABELECIMENTO_FATURAMENTO = 'EM';

  STR_TRAVA_COLETOR = '_CONFERENCIA_SAIDA_COLETOR';
  STR_TRAVA_ROMANEIO = '_ROMANEIO_CONFERENCIA';
  STR_TRAVA_CONFERENCIA = '_CONFERENCIA_DOCUMENTO';

  STR_APLICACAO_PADRAO = 'CAST(LTRIM(REPLACE(ITE_APLICA, "<<csq>>", " ")) AS CHAR CHARACTER SET latin1)';

  CFOP_COMBUSTIVEL = '1651_1652_1653_1658_1659_1660_1661_' +
                     '1662_1663_1664_2651_2652_2653_2658_2659_' +
                     '2660_2661_2662_2663_2664_3651_3652_3653_' +
                     '5651_5652_5653_5654_5655_5656_5657_5658_' +
                     '5659_5660_5661_5662_5663_5664_5665_5666_' +
                     '5667_6651_6652_6653_6654_6655_6656_6657_' +
                     '6658_6659_6660_6661_6662_6663_6664_6665_' +
                     '6666_6667_7651_7654_7667';

  RETORNO_SUCESSO_ENVIO_CONTATO = 'Contato sincronizado com sucesso';
  RETORNO_INSUCESSO_ENVIO_CONTATO = 'Erro ao sincronizar contato';

  COMPARAR_QTDSEP_AUTCOM = '1';
  COMPARAR_QTDSEP_COLETOR = '2';
  MSG_VLR_GNR_MANUAL = 'VALOR GNRE FOI INSERIDO MANUALMENTE PELO USU¡RIO.';

  MESSAGE_CFG_LALAMOVE : String = 'Quando utilizar integraÁ„o LalaMove ( CFG_USALAL = S ) È necess·rio adequar as configuraÁıes:' + sLineBreak +
                                  '' + sLineBreak +
                                  'CFG_LAUHOM - Utilizar ambiente de homologaÁ„o LALAMOVE = N' + sLineBreak +
                                  'CFG_LAAPKE - Api Key para integraÁ„o LALAMOVE' + sLineBreak +
                                  'CFG_LALHOM - https://rest.sandbox.lalamove.com' + sLineBreak +
                                  'CFG_LALPRD - https://rest.lalamove.com' + sLineBreak +
                                  'CFG_LASKEY - Api Secret para integraÁ„o LALAMOVE' + sLineBreak +
                                  'CFG_USALAT - Vincular Latitude e Longitude no cadastro de clientes? = S' + sLineBreak +
                                  'CFG_ENPAFR - IntegraÁ„o Consulta de Frete = N' + sLineBreak +
                                  'CFG_ITPUTI - IntegraÁ„o Intelipost = N' + sLineBreak +
                                  'CFG_DTFUSA - IntegraÁ„o DataFrete = N' + sLineBreak +
                                  'CFG_QLPUSA - IntegraÁ„o QUALP = N' + sLineBreak +
                                  'CFG_FREUSA - IntegraÁ„o Frenet = N' + sLineBreak +
                                  'CFG_LATLON - Latitude e Longitude do C.D. = (Preenchido)' + sLineBreak +
                                  'CFG_KEYMDP - KEY API Matriz de Dist‚ncia principal (Chave ˙nica da Citel)' + sLineBreak +
                                  'CFG_URLMDP - URL API Matriz de Dist‚ncia principal = https://maps.googleapis.com' + sLineBreak +
                                  'CFG_URLMDS - URL API Matriz de Dist‚ncia secund·ria = https://maps.distancematrixapi.com' + sLineBreak +
                                  '' + sLineBreak +
                                  'Para realizar cotaÁıes de entregas com a LalaMove, È necess·rio que no cadastro de clientes, ' +
                                  'as informaÁıes de latitude e longitude estejam preenchidas inclusive nos endereÁos de entrega.' + sLineBreak +
                                  '' + sLineBreak +
                                  'No cadastro de transportadora È necess·rio que exista registro com a combobox ' +
                                  '"OpÁ„o de IntegraÁ„o e Imp. de Etiq. de Despacho:" selecionada o item "LALAMOVE".' + sLineBreak +
                                  '' + sLineBreak;

  Var
    CHAVE_PUBLICA: AnsiString;
    CHAVE_PRIVADA: AnsiString;
    STR_CRM_TIP_PC: String;
    EXIBE_MARMKP_4_5 : Boolean;
    VALIDA_QTDBAIXA_OP: Boolean;
    VALIDA_LOTE_OP: Boolean;
    TRAVA_PLANO_RECEBIMENTO_SEM_SUGESTAO: Boolean;
    COTACAO_MODO_GRAVACAO_ANTIGA: Boolean;
    ALIQUOTAS_ICMS_INTERESTADUAIS : Taliquotas_Icms_Interestaduais;

implementation

end.
