unit untScopeNCR;

interface

uses untInterfaceTefCitel ;

type
  TLibHandle = THandle;

  TEnumStatus = (esOk, esExit, esBreak) ;

  TEnumPP_INTERFACE = (
        PP_NAO_UTILIZA,
        PP_INTERFACE_LIB_VISA,
        PP_INTERFACE_LIB_COMPARTILHADA);


  //** Enumerador dos tipos das operadoras de celular */
  TEnumCelOperModelo = (
        REC_CEL_OPERADORAS_MODELO_1 = 1,
        REC_CEL_OPERADORAS_MODELO_2);


  { Enumerador dos tipos de estruturas retornadas
        para os valores de recarga }
  TEnumCelOperVals = (
        REC_CEL_VALORES_MODELO_1 = 1,
        REC_CEL_VALORES_MODELO_2,
        REC_CEL_VALORES_MODELO_3);


  //** dados utlizados na coleta de parametros */
  PParam_Coleta = ^TParam_Coleta;

  TParam_Coleta = packed record
    Bandeira,
    FormatoDado,
    HabTeclas:            Word;
    MsgOp1,
    MsgOp2,
    MsgCl1,
    MsgCl2:               array [1..64] of AnsiChar;
    WrkKey:               array [1..17] of AnsiChar;
    PosMasterKey:         Word;
    PAN:                  array [1..20] of AnsiChar;
    UsaCriptoPinpad,
    IdModoPagto,
    AceitaCartaoDigitado: Byte;
    Reservado:            array [1..105] of AnsiChar;
  end;


  //** Estrutura devolvida pela funcao ScopeGetLastMsg() */
  PColeta_Msg = ^TColeta_Msg;

  TColeta_Msg = packed record
    Op1,
    Op2,
    Cl1,
    Cl2:                  array [1..64] of AnsiChar;
  end;


  //** Estrutura devolvida pela funcao ScopeGetCheque() */
  PParam_Cheq = ^TParam_Cheq;

  TParam_Cheq = packed record
    Banco:      array [1..4] of AnsiChar;
    Agencia:    array [1..5] of AnsiChar;
    NumCheque,
    Valor:      array [1..13] of AnsiChar;
    BomPara:    array [1..9] of AnsiChar;
    CodAut:     array [1..11] of AnsiChar;
    Municipio:  array [1..41] of AnsiChar;
    Ordem:      SmallInt;
  end;


  //** Lista de Operadoras de Recarga de Celular retornadas pelo Servidor */
  PRec_Cel_Oper = ^TRec_Cel_Oper;

  TRec_Cel_Oper = packed record
    NumOperCel:   SmallInt;
    OperCel:      array [1..2000] of AnsiChar;
  end;


  //** Lista de Operadoras de Recarga de Celular retornadas pelo Servidor */
  PRec_Cel_ID_Oper = ^TRec_Cel_ID_Oper;

  TRec_Cel_ID_Oper = packed record
    CodOperCel:   AnsiChar;
    NomeOperCel:  array [1..21] of AnsiChar;
  end;


  //** Formato do valor para Recarga de Celular */
  PRec_Cel_Valor = ^TRec_Cel_Valor;

  TRec_Cel_Valor = packed record
    Valor,
    Bonus,
    Custo:      array [1..12] of AnsiChar;
  end;

  TRec_Cel_Faixa_Valores = packed record
    ValorMin,
    ValorMax:      array [1..12] of AnsiChar;
  end;


  //** Lista de Valores de Recarga de Celular retornadas pelo Servidor */
  PRec_Cel_Valores = ^TRec_Cel_Valores;

  TRec_Cel_Valores = packed record
    TipoValor:      AnsiChar;               { Tipo dos valores
                                          'V' - variavel(val min e val maximo)
                                          'F' - Fixo (apenas um valor fixo)
                                          'T' - Todos (tabela de valores) }
    ValorMinimo,
    ValorMaximo:    array [1..12] of AnsiChar;
    Totvalor:       AnsiChar;
    TabValores:     array [1..10] of TRec_Cel_Valor;
    MsgPromocional: array [1..41] of AnsiChar;
    TotFaixaValores: AnsiChar;
    TabFaixaValores:array [1..10] of TRec_Cel_Faixa_Valores;
  end;

  //** Formato de valores do PIX
  const
    CARTVIRT_MAX_PRODUTOS = 24;

  type
    stCV_BandRede = packed record
      CodBandeira    : array[0..2]  of AnsiChar;  // 3 bytes
      szNomeBandeira : array[0..40] of AnsiChar;  // 41 bytes (40 + 1)
      CodRede        : array[0..2]  of AnsiChar;  // 3 bytes
      szNomeRede     : array[0..40] of AnsiChar;  // 41 bytes (40 + 1)
    end;
    PPCV_BandRede = ^stCV_BandRede;

    stCV_ListaBandRede = packed record
      Versao      : array[0..1] of AnsiChar;
      QtdProdutos : array[0..1] of AnsiChar;
      sProduto    : array[0..CARTVIRT_MAX_PRODUTOS-1] of stCV_BandRede;
    end;
    PPCV_ListaBandRede = ^stCV_ListaBandRede;

    PAbecs_PPFile_Iinfo = ^TAbecs_PPFile_Iinfo ;
    TAbecs_PPFile_Iinfo = packed record
      Version:        Integer;                      // 4 bytes - igual ao int em C
      szFileNamePP:   array [0..8] of AnsiChar;     // 9 bytes
      cFileType:      AnsiChar;
      szFileName:     array [0..256] of AnsiChar;   // 257 bytes
      szFilePath:     array [0..320] of AnsiChar;   // 321 bytes
    end;


  //** Estrutura para o acesso dinamico das funções da DLL
  TScopeOpen                     = function (Modo, Empresa, Filial, Pdv: PAnsiChar): LongInt; stdcall;
  TScopeClose                    = function (): LongInt; stdcall;
  TScopeVersao                   = function (_Versao: PAnsiChar; _TamBufVersao: Integer): LongInt; stdcall;
  TScopeCompraCartaoCredito      = function (Valor, TxServico: PAnsiChar): LongInt; stdcall;
  TScopeAbreSessaoTEF            = function (): LongInt; stdcall;
  TScopeSetAplColeta             = function (): LongInt; stdcall;
  TScopeStatus                   = function (): LongInt; stdcall;
  TScopeGetParam                 = function (_TipoParam: LongInt; _lpParam: PParam_Coleta): LongInt; stdcall;
  TScopeResumeParam              = function (_CodTipoColeta: LongInt; _Dados: PAnsiChar; _DadosParam: Word; _Acao: LongInt): LongInt; stdcall;
  TScopeGetLastMsg               = function (_ptParamColetaMsg: PColeta_Msg): LongInt; stdcall;
  TScopeGetCheque                = function (_ptParamCheque: PParam_Cheq): LongInt; stdcall;
  TScopeGetCupomEx               = function (_CabecLen: Word; _Cabec: PAnsiChar; _CupomClienteLen: Word; _CupomCliente: PAnsiChar; _CupomLojaLen: Word; _CupomLoja: PAnsiChar; _CupomReduzLen: Word; _CupomReduz: PAnsiChar; _NroLinhasReduz: PByte): LongInt; stdcall;
  TScopeFechaSessaoTEF           = function (_Acao: Byte; _DesfezTEFAposQuedaEnergia: PByte): LongInt; stdcall;
  TScopeConsultaCDC              = function (_Valor, _TxServico: PAnsiChar): LongInt; stdcall;
  TScopeCompraCartaoDebito       = function (Valor: PAnsiChar): LongInt; stdcall;
  TScopeConsultaCheque           = function (Valor: PAnsiChar): LongInt; stdcall;
  TScopeCancelamento             = function (_Valor, _TxServico: PAnsiChar): LongInt; stdcall;
  TScopeReimpressaoComprovante   = function () : LongInt; stdcall;
  TScopeResumoVendas             = function () : LongInt; stdcall;
  TScopeObtemCampoExt            = function (_Handle, _Masc, _Masc2: LongInt; _FieldSeparator: Byte; _Buffer: PAnsiChar): LongInt; stdcall;
  TScopeObtemCampoExt2           = function (_Handle, _Masc, _Masc2, _Masc3: LongInt; _FieldSeparator: Byte; _Buffer: PAnsiChar): LongInt; stdcall;
  TScopeObtemCampoExt3           = function (_Handle, _Masc, _Masc2, _Masc3, _Masc4: LongInt; _FieldSeparator: Byte; _Buffer: PAnsiChar): LongInt; stdcall;
  TScopeObtemHandle              = function (_Desloc: LongInt): LongInt; stdcall;
  TScopePagamento                = function (_Servico, _CodBandeira: Word): LongInt; stdcall;
  TScopeRecargaCelular           = function (): LongInt; stdcall;
  TScopePreAutorizacaoCredito    = function (_Valor, _TxServico: PAnsiChar): LongInt; stdcall;
  TScopeRecuperaOperadorasRecCel = function (_TipoTabela: Byte; _Buffer: PAnsiChar; _TamBuffer: Word): LongInt; stdcall;
  TScopeRecuperaValoresRecCel    = function (_TipoTabela: Byte; _Buffer: PAnsiChar; _TamBuffer: Word): LongInt; stdcall;
  TScopeConfigura                = function (_Id, _Param: LongInt): LongInt; stdcall;
  TScopeValidaInterfacePP        = function (IntPP: Byte): LongInt; stdcall;
  TScopeConsultaPP               = function (Configurado, UsoExclusivoScope, Porta: PByte): LongInt; stdcall;
  TScopePPClose                  = function (IdleMsg: PAnsiChar): LongInt; stdcall;
  TScopeSuspend                  = function (_Estado: LongInt): LongInt; stdcall;
  TScopeResume                   = function (): LongInt; stdcall;
  TScopeAbort                    = function (): LongInt; stdcall;
  TScopeForneceCampo             = function (_Tipo: Byte; _Atributos: PAnsiChar): LongInt; stdcall;
  TScopeMTEFOnOff                = function (_Trata: Byte): LongInt; stdcall;
  TScopePPStartGetData           = function (_Dado, _TamMin, _TamMax: Word): LongInt; stdcall;
  TScopePPGetData                = function (_LenDado: Word; _Buffer: PAnsiChar): LongInt; stdcall;
  TScopePPStartGetKey            = function (): LongInt; stdcall;
  TScopePPOpenSecure             = function (_TipoCanal: Word; _Endereco: PAnsiChar): LongInt; stdcall;
  TScopePPGetCOMPort             = function (_ComEndereco: PAnsiChar): LongInt; stdcall;
  TScopeObtemListaCarteiraVirtualEx = function (_Versao: PAnsiChar; _Servico: Word; _Buffer: PPCV_ListaBandRede; _TamBuffer: Word): LongInt; stdcall;
  TScopeCarteiraVirtualEx2       = function (_Valor: PAnsiChar; _CodBandeira: Word; _CodRede: Word; _CodServico: Word): LongInt; stdcall;
  TScopePPMMFileLoad             = function (_ptInfoFile: PAbecs_PPFile_Iinfo): LongInt; stdcall;
  TScopePPMMFileList             = function (_ptFileList: PAnsiChar; _ptTamanho: PLongInt): LongInt; stdcall;
  TScopePPMMFileDelete           = function (_ptFileNamePP: PAnsiChar): LongInt; stdcall;
  TScopePPMMDisplayImage         = function (_ptFileNamePP: PAnsiChar): LongInt; stdcall;
  TScopePPDisplay                = function (_Msg: PAnsiChar): LongInt; stdcall;
  TScopePPGetInfoEx              = function (_IdSaida: Word; _DadosLen: Word; _Dados: PAnsiChar): LongInt; stdcall;

const
  NCR_MEIOS_PAGAMENTO_CREDITO_HABILITADOS  = '1:2:3::' ;
  NCR_MEIOS_PAGAMENTO_DEBITO_BANRISUL_HABILITADOS  = '1:À Vista;2:Pré Datado;3:Parcelado' ;
  NCR_DEBITO = 'cartao debito' ;
  NCR_BANRISUL_DEBITO = 'banrisul' ;
  NCR_BANRISUL_DEBITO_CODIGO = '00021' ;
  NCR_BANRISUL_MODALIDADE_AVISTA = '1' ;
  NCR_BANRISUL_MODALIDADE_PREDATADO = '2' ;
  NCR_BANRISUL_MODALIDADE_PARCELADO = '3' ;
  NCR_BANRISUL_PARCELA_COM_ENTRADA = 0 ;
  NCR_BANRISUL_PARCELA_SEM_ENTRADA = 1 ;

  NCR_INFO_DATA_LOCAL_TRANSACAO = $00000010 ;
  NCR_INFO_HORA_LOCAL_TRANSACAO = $00000008 ;
  NCR_INFO_CODIGO_BANDEIRA      = $00040000 ;
  NCR_INFO_CODIGO_REDE          = $00400000 ;
  NCR_INFO_NSU_HOST             = $00004000 ;
  NCR_INFO_NSU                  = $00000004 ;
  NCR_INFO_CODIGO_AUTORIZACAO   = $00000100 ;
  NCR_INFO_VALOR_TRANSACAO      = $00000002 ;
  NCR_INFO_NUMERO_CARTAO        = $00000001 ;
  NCR_INFO_CONTROLE             = $00200000 ;
  NCR_INFO_CODIGO_ESTABELECI    = $00000800 ;
  NCR_INFO_MODO_ENTRADA         = $00000008 ;
  NCR_INFO_CARTAO_PRE_PAGO      = $04000000 ;
  NCR_INFO_NADA_PARAMETRIZADO   = $00 ;

  RCS_ERRO_MODO_ABECS:                LongInt  = $FF90 ;
  RCS_ERRO_TAMANHO_INVALIDO:          LongInt  = $FF91 ;
  RCS_ERRO_ARQUIVO_INVALIDO:          LongInt  = $FF92 ;
  RCS_ERRO_NOME_ARQUIVO_PP_INVALIDO:  LongInt  = $FF93 ;
  RCS_ERRO_TIPO_ARQUIVO_PP_INVALIDO:  LongInt  = $FF94 ;
  PC_NAO_ABERTO_APP:                  LongInt  = 211 ;

  FILE_TYPE_PNG:                      AnsiChar = '1' ;
  FILE_TYPE_JPG:                      AnsiChar = '2' ;
  FILE_TYPE_GIF:                      AnsiChar = '3' ;

  NCR_OPERACAO_CARTAO_CREDITO     = 3 ;
  NCR_OPERACAO_IMPRESSAO_ULTIMO   = 114 ;
  NCR_OPERACAO_IMPRESSAO_ESPECI   = 113 ;
  NCR_OPERACAO_CARTAO_CANCELAR    = 200 ;
  NCR_OPERACAO_CARTAO_CANCELAR_2  = 123 ;
  NCR_OPERACAO_CARTAO_DEBITO      = 2 ;

  NCR_OPERACAO_NAO_INFORMADO_PRE_PAGO  = '0' ;
  NCR_OPERACAO_CARTAO_CREDITO_PRE_PAGO = '1' ;
  NCR_OPERACAO_CARTAO_DEBITO_PRE_PAGO  = '2' ;

  NCR_CODIGO_RETORNO_REIMPRESSAO_DECIDE = 64541 ;
  NCR_CODIGO_RETORNO_COLETAR_SCOPE = 64530 ;
  NCR_CODIGO_RETORNO_TIPO_VIA_REIMPRESSAO = 64655 ;
  NCR_CODIGO_RETORNO_AGUARDA_OPERADOR = 64767 ;
  NCR_CODIGO_RETORNO_AVISTA_APRAZO = 64521 ;
  NCR_CODIGO_RETORNO_PRE_DATADO = 64523 ;
  NCR_CODIGO_RETORNO_COLETAR_QTD_PARCELAS = 64526 ;
  NCR_CODIGO_RETORNO_COLETAR_PARC_ADM_LOJA = 64522 ;
  NCR_CODIGO_RETORNO_CANCELAR_TRANSACAO = 64637 ;
  NCR_CODIGO_RETORNO_COLETAR_SE_PARC_AVISTA = 64524 ;
  NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_ENTRE_PARC = 64525 ;
  NCR_CODIGO_RETORNO_COLETAR_QTD_DIAS_PRIMEIRA_PARC = 64543 ;
  NCR_CODIGO_RETORNO_COLETAR_NUMERO_CARTAO = 64645 ;
  NCR_CODIGO_RETORNO_COLETAR_ANULA_COLETA_SENHA = 65282 ;
  NCR_CODIGO_RETORNO_COLETAR_DATA = 64562 ;
  NCR_CODIGO_RETORNO_COLETAR_ULTIMOS_DIG_CARTAO = 64536 ;
  NCR_CODIGO_RETORNO_EXIBE_MENU = 64647 ;
  NCR_CODIGO_RETORNO_SCOPE_API_JA_FOI_INICIALIZADA = 65026 ;
  NCR_CODIGO_RETORNO_AGUARDA_MAIS_TEMPO = 64540 ;

  TC_OBTEM_QRCODE = $FCF3;

  NCR_CODIGO_RETORNO_PINPAD_JA_FOI_ABERTO = 14 ;

  SCOPE_DADO_ATRIBUTOS_APLIC:   LongInt = 3 ;

  SCO_SUCESSO:                      LongInt = $0000;
  SCO_ERRO_CARREGAR_PINPAD:         LongInt = 31;
  PC_ALREADYOPEN:                   LongInt = 14 ;

  { Codigos devolvidos pelas funcoes de acesso
    ao PIN-Pad Compartilhado }
  PC_OK:                            LongInt = 0;
  PC_ANULA:                         LongInt = 13;

  PC_GETDATA_CPF:                    Word = 7 ;
  PC_GETDATA_CNPJ:                   Word = 14 ;
  PC_GETINFO_HW:                     Word = 0;

  // Identificacao das redes
  R_GWCEL:                          LongInt = 90;

  {- entrada dos dados -}
  SCO_NONE:                         LongInt = $0000;
  SCO_TECLADO:                      LongInt = $0004;
  SCO_PIN_PAD:                      LongInt = $0008;
  SCO_CMC_7:                        LongInt = $0010;
  SCO_CARTAO_MAGNETICO:             LongInt = $0020;
  SCO_SCANNER:                      LongInt = $0040;

  {- parametros do ScopeOpen -}
  SCO_ERRO_PARM_1:                  LongInt = $FA01;  // Modo
  SCO_ERRO_PARM_2:                  LongInt = $FA02;  // Empresa
  SCO_ERRO_PARM_3:                  LongInt = $FA03;  // Filial
  SCO_ERRO_PARM_4:                  LongInt = $FA04;  // PDV

  {- ainda não sei para que servem estes ??? -}
  SCO_AUTO_ERRO_CRD_RLV_INVALIDO:   LongInt = $F900;
  SCO_AUTO_ERRO_CRD_TRK_INVALIDA:   LongInt = $F901;
  SCO_AUTO_ERRO_CRD_INVALIDO:       LongInt = $F902;
  SCO_AUTO_ERRO_CRD_VALIDADE:       LongInt = $F903;
  SCO_AUTO_ERRO_PARM_INVALIDO:      LongInt = $F904;

  {- erros relacionados ao windows -}
  SCO_THREAD_API_NOT_INIT:          LongInt = $FB01;
  SCO_ERRO_CRIA_SERV:               LongInt = $FB02;
  SCO_ERRO_CRITICA_MSG:             LongInt = $FB03;
  SCO_ERRO_MONTA_MSG:               LongInt = $FB04;

  {-coleta de dados -}
  SCO_PRIMEIRO_COLETA_DADOS:        LongInt = $FC00;
  SCO_COLETAR_CARTAO:               LongInt = $FC00;

  SCO_CARTAO = $FC00;
  SCO_IMPRIME_CUPOM = $FC02;
  SCO_IMPRIME_CHEQUE = $FC08;
  SCO_SENHA = $FC11;
  SCO_IMPRIME_CONSULTA  = $FC1B;
  SCO_COLETA_VALOR_RECARGA  = $FC2E;
  SCO_IMPRIME_CUPOM_PARCIAL = $FC46;
  SCO_COLETA_AUT_OU_CARTAO = $FC6C;
  SCO_COLETA_OPERADORA = $FC70;
  SCO_CARTAO_DIGITADO = $FC85;

  SCO_COLETA_CARTAO_EM_ANDAMENTO = $FCFC;
  SCO_COLETA_EM_ANDAMENTO = $FCFD;
  SCO_MOSTRA_INFO_RET_SCOPE = $FCFE; // mostra informações e retorna para scope
  SCO_MOSTRA_INFO_AGUARDA_CONF = $FCFF; // mostra informações e aguarda operador
  SCO_ULTIMO_COLETA_DADOS = $FCFF;
  SCO_COLETA_AVISTA_PRAZO = $FC09;
  SCO_COLETA_NUMPARC = $FC0E;

  SCO_TRN_EM_ANDAMENTO = $FE00;  // transação em andamento
  SCO_API_NAO_INICIALIZADA:         LongInt = $FE01;
  SCO_API_JA_INICIALIZADA:          LongInt = $FE02;
  SCO_EXISTE_TRN_SUSPENSA:          LongInt = $FE03;  // existe transação suspensa
  SCO_NAO_EXISTE_TRN_SUSPENSA:      LongInt = $FE04;  // não existe transação suspensa
  SCO_API_NAO_FEZ_TRN:              LongInt = $FE05;  //
  SCO_POS_JA_LOGADO:                LongInt = $FE06;  // Logon duplicado
  SCO_POS_NAO_CADASTRADO:           LongInt = $FE08;  // Codigo POS não cadastrado no BD
  SCO_SRV_NOT_CFG:                  LongInt = $FE09;  // serviço nao configurado

  SCO_SERVER_OFF:                   LongInt = $FF00;
  SCO_INSTITUICAO_OFF:              LongInt = $FF01;
  SCO_CANCELADA_PELO_OPERADOR:      LongInt = $FF02;
  SCO_BIN_SERV_INV:                 LongInt = $FF03; // BIN não configurado
  SCO_TRN_JA_CANCELADA:             LongInt = $FF04;
  SCO_TRN_NOT_FOUND_BD:             LongInt = $FF05;
  SCO_TRN_NAO_REVERSIVEL:           LongInt = $FF06; // transação não pode ser cancelada
  SCO_PARMS_INCOMPATIVEIS:          LongInt = $FF07; // Dados não conferem com a transação original
  SCO_ERRO_BD:                      LongInt = $FF08;
  SCO_TIMEOUT_BD:                   LongInt = $FF09;
  SCO_BD_OFFLINE:                   LongInt = $FF0A;
  SCO_ABORTADA_PELO_APLICATIVO:     LongInt = $FF0B;
  SCO_TRN_NAO_IMPLEMENTADA:         LongInt = $FF0C;
  SCO_HANDLE_INVALIDO:              LongInt = $FF0D;
  SCO_TX_SERV_INVALIDA:             LongInt = $FF0E;
  SCO_TX_SERV_EXCEDE_LIM:           LongInt = $FF0F;
  SCO_DADO_INVALIDO:                LongInt = $FF10;
  SCO_NAO_EXITE_CUPOM_VALIDO:       LongInt = $FF11;
  SCO_AREA_RESERVADA_INSUFICIENTE:  LongInt = $FF12;
  SCO_ERRO_GENERICO:                LongInt = $FFFF;

  {- Define os campos para as funcoes ScopeObtemCampo() e para ScopeObtemCampoExt() -}
  Cod_Rede:                         LongInt = $400000;

  {- Define os parametros para a funcao ScopeObtemHandle -}
  HDL_TRANSACAO_ANTERIOR:           LongInt = $0000;
  HDL_TRANSACAO_EM_ARQUIVO:         LongInt = $0008;
  HDL_TRANSACAO_EM_ANDAMENTO:       LongInt = $0009;

  {- codigos das bandeiras -}
  SCO_SCOPE:                        LongInt = $0000;
  SCO_VISA:                         LongInt = $0001;
  SCO_MASTERCARD:                   LongInt = $0002;
  SCO_AMEX:                         LongInt = $0003;
  SCO_FININCARD:                    LongInt = $0004;
  SCO_DINERS:                       LongInt = $0005;
  SCO_SOLO:                         LongInt = $0006;
  SCO_CHEQUE_ELETRONICO:            LongInt = $0007;
  SCO_REDESHOP:                     LongInt = $0008;
  SCO_ITAU:                         LongInt = $0009;
  SCO_BRADESCO:                     LongInt = $000A;
  SCO_TRISHOP_ITAU:                 LongInt = $000B;
  SCO_SERASA:                       LongInt = $000C;
  SCO_TELECHEQUE:                   LongInt = $000D;
  SCO_CREDICARD:                    LongInt = $000E;
  SCO_RVA:                          LongInt = $000F;
  SCO_TICKET:                       LongInt = $0010;
  SCO_HIPERCARD:                    LongInt = $0011;
  SCO_CNS:                          LongInt = $0012;
  SCO_CSS:                          LongInt = $0013;
  SCO_BANRISUL:                     LongInt = $0014;
  SCO_ELECTRON:                     LongInt = $0015;
  SCO_REDECARD:                     LongInt = $0016;
  SCO_JBC:                          LongInt = $0017;
  SCO_QUALITY_CARD:                 LongInt = $0018;
  SCO_UNNISA:                       LongInt = $0019;
  SCO_FININVEST:                    LongInt = $001A;

  { Bits para indicacao do estado da comunicacao c/
    o SCOPE - possiveis vals da var FintSinc }
  INI_COMUNIC:                      LongInt = $0001;
  INI_SESSAO:                       LongInt = $0002;
  INI_APLCOLET:                     LongInt = $0004;

  ACAO_PROX:                        LongInt = $0008;
  ACAO_ANTER:                       LongInt = $0010;
  ACAO_CANCELAR:                    LongInt = $0020;

  COLETA_PROXIMO_ESTADO:            LongInt = 0;
  COLETA_ANTERIOR_ESTADO:           LongInt = 1;
  COLETA_CANCELAR:                  LongInt = 2;

  BIT6_ON:                          LongInt = $0040;
  BIT7_ON:                          LongInt = $0080;
  BIT8_ON:                          LongInt = $0100;
  BIT9_ON:                          LongInt = $0200;

  SCO_DESFAZ_TEF:                   Byte    = 0;
  SCO_CONFIRMA_TEF:                 Byte    = 1;

  // Funcao ScopeConfigura() - Configura a Interface Coleta do Scope
  CFG_CANCELAR_OPERACAO_PINPAD  :           LongInt = 1;
  CFG_OBTER_SERVICOS_SCOPE      :           LongInt = 2;
  CFG_SOLICITAR_DIGITACAO_SENHA :           LongInt = 8;
  CFG_IMPRESSORA_PAPEL_CARBONO  :           LongInt = 16;
  CFG_HABILITA_QRCODE_TELA      = $00000400;
  CFG_NAO_ABRIR_DIGITADO_COM_PP	= $00000004;
  CFG_ARMAZENA_EM_QUEDA         = $00000020;
  CFG_MASCARAR_DADOS            = $00000040;
  CFG_COLETA_RECARGA_PP         = $00000200;

{------------------------------------------------------------------------------
  DECLARACAO DE FUNCOES EXTERNAS - SCOPE
------------------------------------------------------------------------------}
  scope = 'scopeapi.dll';

  function FunctionDetect(const LibName, FuncName: String; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr; var LibHandle: TLibHandle): boolean; overload ;
  function FunctionDetect(const LibName, FuncName: String; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr): boolean; overload ;
  procedure NcrFunctionDetect(FuncName: AnsiString; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr; PathDLL: String = '') ;
  function PathWithDelim(const APath : string): string;
  function fLoadDLLFunctions(const AProcLogErr: TprocGravaLogErr; const PathDLL: String = ''): Boolean ;
  procedure UnLoadDLLFunctions(const PathDLL: String = '') ;
  function fDLLsExiste(const AstrPathDLL: String; var AstrDLL: String): Boolean ;

  function AbreSCOPE(_Empresa, _Filial, _PDV: string; _Desligou: Boolean = False): LongInt;
  procedure FechaSCOPE(const AstrMsg: String);
  function AbrePINPad(const AintPortaCom: Integer): LongInt;
  procedure FechaPINPad(const AstrMsg: String);
  function AbreSessaoTEF(const blnDesligou: Boolean = False; const blnPixSemPinPad: Boolean = False): LongInt;
  procedure FechaSessaoTEF(bAcao: Byte; bForcar: Byte = 0; blnDesligou: Boolean = False);
  procedure pLogError(const AStrMsg: String; const AStrPath: String; AProcLogErr: TprocGravaLogErr);
  function fGetPortaComAuto: Integer ;
  function fArrayToString(const AarrValor: array of AnsiChar): AnsiString;

var
  FintSinc: Integer ;
  FstrEmpresa: String ;
  FstrFilial: String ;
  FstrPdv: String ;
  FintComPort: Integer ;
  FstrMsgPinPad: String ;
  FstrProcessandoChar: char = '|' ;
  FblnDesligaShowProcessamento: Boolean = False ;
  FsppPinPad: TStatusPinPad = sppNull ;

  ///variaveis de função
  ScopeVersao: TScopeVersao ;
  ScopeOpen:   TScopeOpen ;
  ScopeClose:  TScopeClose ;
  ScopeCompraCartaoCredito: TScopeCompraCartaoCredito ;
  ScopeAbreSessaoTEF: TScopeAbreSessaoTEF ;
  ScopeSetAplColeta: TScopeSetAplColeta ;
  ScopeStatus: TScopeStatus ;
  ScopeGetParam: TScopeGetParam ;
  ScopeResumeParam: TScopeResumeParam ;
  ScopeGetLastMsg: TScopeGetLastMsg ;
  ScopeGetCheque: TScopeGetCheque ;
  ScopeGetCupomEx: TScopeGetCupomEx ;
  ScopeFechaSessaoTEF: TScopeFechaSessaoTEF ;
  ScopeConsultaCDC: TScopeConsultaCDC ;
  ScopeCompraCartaoDebito: TScopeCompraCartaoDebito ;
  ScopeConsultaCheque: TScopeConsultaCheque ;
  ScopeCancelamento: TScopeCancelamento ;
  ScopeReimpressaoComprovante: TScopeReimpressaoComprovante ;
  ScopeResumoVendas: TScopeResumoVendas ;
  ScopeObtemCampoExt: TScopeObtemCampoExt ;
  ScopeObtemCampoExt2: TScopeObtemCampoExt2 ;
  ScopeObtemCampoExt3: TScopeObtemCampoExt3 ;
  ScopeObtemHandle: TScopeObtemHandle ;
  ScopePagamento: TScopePagamento ;
  ScopeRecargaCelular: TScopeRecargaCelular ;
  ScopePreAutorizacaoCredito: TScopePreAutorizacaoCredito ;
  ScopeRecuperaOperadorasRecCel: TScopeRecuperaOperadorasRecCel ;
  ScopeRecuperaValoresRecCel: TScopeRecuperaValoresRecCel ;
  ScopeConfigura: TScopeConfigura ;
  ScopeValidaInterfacePP: TScopeValidaInterfacePP ;
  ScopeConsultaPP: TScopeConsultaPP ;
  ScopePPClose: TScopePPClose ;
  ScopeSuspend: TScopeSuspend ;
  ScopeResume: TScopeResume ;
  ScopeAbort: TScopeAbort ;
  ScopeForneceCampo: TScopeForneceCampo ;
  ScopeMTEFOnOff: TScopeMTEFOnOff ;
  ScopePPStartGetData: TScopePPStartGetData ;
  ScopePPGetData: TScopePPGetData ;
  ScopePPStartGetKey: TScopePPStartGetKey ;
  ScopePPOpenSecure: TScopePPOpenSecure ;
  ScopePPGetCOMPort: TScopePPGetCOMPort ;
  ScopeObtemListaCarteiraVirtualEx: TScopeObtemListaCarteiraVirtualEx;
  ScopeCarteiraVirtualEx2: TScopeCarteiraVirtualEx2;
  ScopePPMMFileLoad: TScopePPMMFileLoad;
  ScopePPMMFileList: TScopePPMMFileList;
  ScopePPMMFileDelete: TScopePPMMFileDelete;
  ScopePPMMDisplayImage: TScopePPMMDisplayImage;
  ScopePPDisplay: TScopePPDisplay;
  ScopePPGetInfoEx: TScopePPGetInfoEx;

implementation

uses Winapi.Windows, System.SysUtils, System.AnsiStrings, System.DateUtils,
     untTefCitelComum ;

function fArrayToString(const AarrValor: array of AnsiChar): AnsiString;
var
  LintCnt: integer;
begin
  Result := '' ;
  for LintCnt := Low(AarrValor) to High(AarrValor) do
    if AarrValor[LintCnt] <> #0 then
      Result := Result + AarrValor[LintCnt]
end;

function fGetPortaComAuto: Integer ;
var
  LstrRetComAuto: array [1..3] of AnsiChar;
  LstrRetorno: String ;
  LintRet: LongInt ;
begin
  Result := 0 ;
  {$WARN UNSAFE_CODE OFF}
  ZeroMemory(@LstrRetComAuto, SizeOf(LstrRetComAuto));
  LintRet := ScopePPGetCOMPort(@LstrRetComAuto) ;
  {$WARN UNSAFE_CODE ON}

  if LintRet = 0 then
  begin
    LstrRetorno := Trim(String(fArrayToString(LstrRetComAuto))) ;
    Result := StrToIntDef(LstrRetorno, 0) ;
  end ;

end ;

// método original, "pLoga", foi movido para a classe: TTefCitelNCR
procedure pLogError(const AStrMsg: String; const AStrPath: String; AProcLogErr: TprocGravaLogErr);
var
  LDataHoraFormatada : string;
  LLogError: TextFile ;
  LstrPathLog: String ;
  LstrConteudoLog: String ;
begin

  LstrPathLog := '' ;
  if trim(AStrPath) <> '' then
    if DirectoryExists(AStrPath) then
      LstrPathLog := PathWithDelim(AStrPath);

  AssignFile(LLogError, LstrPathLog+TEFCitelErro_Log);
  try
    if FileExists(LstrPathLog+TEFCitelErro_Log) then
      Append(LLogError)
    else
      Rewrite(LLogError) ;

    LDataHoraFormatada := FormatDateTime('dd/mm/yyy hh:mm:ss', Now());
    LstrConteudoLog := 'Data/Hora: ' + LDataHoraFormatada + ' --> ' + AStrMsg;

    Writeln(LLogError, LstrConteudoLog);
    Flush(LLogError);

    if Assigned(AProcLogErr) then
    begin
      try
        AProcLogErr(True, TituloLogErr, LstrConteudoLog) ;
      except
        On E: Exception do
        begin
          //ignora o erro
        end ;
      end ;
    end ;

  finally
    CloseFile(LLogError);
  end ;
end;

function FunctionDetect(const LibName, FuncName: String; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr; var LibHandle: TLibHandle): boolean;
begin
 Result := false;
 LibPointer := NIL;
 {$IFDEF FPC}
  LibHandle := dynlibs.LoadLibrary(LibName) ;
 {$ELSE}
  if LoadLibrary(PChar(LibName)) = 0 then
  begin
    try
      RaiseLastOSError ;
    except
      on e: EOSError do
      begin
        pLogError('DLL: [' + LibName + '] Função: [' + FuncName + '] Erro: [' + e.Message + ']!', ExtractFileDir(LibName), AProcLogErr) ;
      end ;
    end ;
    exit;
  end ;

  LibHandle := GetModuleHandle(PChar(LibName));
 {$ENDIF}

 if LibHandle <> 0 then
  begin
     LibPointer := GetProcAddress(LibHandle, PChar(FuncName));
     if LibPointer <> NIL then
        Result := true;
  end;
end;

function FunctionDetect(const LibName, FuncName: String; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr): boolean;
Var
  LibHandle: TLibHandle;
begin
  Result := FunctionDetect(LibName, FuncName, LibPointer, AProcLogErr, LibHandle);
end;

procedure NcrFunctionDetect(FuncName: AnsiString; var LibPointer: Pointer; const AProcLogErr: TprocGravaLogErr; PathDLL: String = '') ;
 var
   sLibName: string;
 begin
   if not Assigned( LibPointer )  then
   begin
     sLibName := '';
     if Length(PathDLL) > 0 then
       sLibName := PathWithDelim(PathDLL);

     sLibName := sLibName + scope;

     if not FunctionDetect( sLibName, String(FuncName), LibPointer, AProcLogErr) then
     begin
       LibPointer := NIL ;
     end ;
   end ;
 end ;

function PathWithDelim(const APath: string): string;
begin
  Result := Trim(APath) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if (Result[Length(Result)] <> PathDelim) then
         Result := Result + PathDelim;
     {$EndIf}
  end;
end ;

function fLoadDLLFunctions(const AProcLogErr: TprocGravaLogErr; const PathDLL: String = ''): Boolean ;
begin
  NcrFunctionDetect('ScopeVersao', @ScopeVersao, AProcLogErr, PathDLL);
  NcrFunctionDetect('ScopeOpen', @ScopeOpen, AProcLogErr, PathDLL);
  NcrFunctionDetect('ScopeClose', @ScopeClose, AProcLogErr, PathDLL);
  NcrFunctionDetect('ScopeCompraCartaoCredito', @ScopeCompraCartaoCredito, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeAbreSessaoTEF', @ScopeAbreSessaoTEF, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeSetAplColeta', @ScopeSetAplColeta, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeStatus', @ScopeStatus, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeGetParam', @ScopeGetParam, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeResumeParam', @ScopeResumeParam, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeGetLastMsg', @ScopeGetLastMsg, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeGetCheque', @ScopeGetCheque, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeGetCupomEx', @ScopeGetCupomEx, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeFechaSessaoTEF', @ScopeFechaSessaoTEF, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeConsultaCDC', @ScopeConsultaCDC, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeCompraCartaoDebito', @ScopeCompraCartaoDebito, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeConsultaCheque', @ScopeConsultaCheque, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeCancelamento', @ScopeCancelamento, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeReimpressaoComprovante', @ScopeReimpressaoComprovante, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeResumoVendas', @ScopeResumoVendas, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeObtemCampoExt', @ScopeObtemCampoExt, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeObtemCampoExt2', @ScopeObtemCampoExt2, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeObtemCampoExt3', @ScopeObtemCampoExt3, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeObtemHandle', @ScopeObtemHandle, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePagamento', @ScopePagamento, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeRecargaCelular', @ScopeRecargaCelular, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePreAutorizacaoCredito', @ScopePreAutorizacaoCredito, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeRecuperaOperadorasRecCel', @ScopeRecuperaOperadorasRecCel, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeRecuperaValoresRecCel', @ScopeRecuperaValoresRecCel, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeConfigura', @ScopeConfigura, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeValidaInterfacePP', @ScopeValidaInterfacePP, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeConsultaPP', @ScopeConsultaPP, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPClose', @ScopePPClose, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeSuspend', @ScopeSuspend, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeResume', @ScopeResume, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeAbort', @ScopeAbort, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeForneceCampo', @ScopeForneceCampo, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeMTEFOnOff', @ScopeMTEFOnOff, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPStartGetData', @ScopePPStartGetData, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPGetData', @ScopePPGetData, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPStartGetKey', @ScopePPStartGetKey, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPOpenSecure', @ScopePPOpenSecure, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPGetCOMPort', @ScopePPGetCOMPort, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeObtemListaCarteiraVirtualEx', @ScopeObtemListaCarteiraVirtualEx, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopeCarteiraVirtualEx2', @ScopeCarteiraVirtualEx2, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPMMFileLoad', @ScopePPMMFileLoad, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPMMFileList', @ScopePPMMFileList, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPMMFileDelete', @ScopePPMMFileDelete, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPMMDisplayImage', @ScopePPMMDisplayImage, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPDisplay', @ScopePPDisplay, AProcLogErr, PathDLL) ;
  NcrFunctionDetect('ScopePPGetInfoEx', @ScopePPGetInfoEx, AProcLogErr, PathDLL);
  Result := True ;
end ;

function fDLLsExiste(const AstrPathDLL: String; var AstrDLL: String): Boolean ;
var
  LarrDlls: array[0..18] of string ;
  LintCnt: Integer ;
  LstrLibName: String ;
  LPathDLL: string;
begin
  Result := False ;
  AstrDLL := '' ;

  LarrDlls[0] := 'csmsg.dll';
  LarrDlls[1] := 'libcrypto-3.dll';
  LarrDlls[2] := 'libcurl.dll';
  LarrDlls[3] := 'libssl-3.dll';
  LarrDlls[4] := 'msvcp110.dll';
  LarrDlls[5] := 'msvcp120.dll';
  LarrDlls[6] := 'msvcr110.dll';
  LarrDlls[7] := 'msvcr120.dll';
  LarrDlls[8] := 'scopeapi.dll';
  LarrDlls[9] := 'scopeclt.dll';
  LarrDlls[10] := 'scopecnx.dll';
  LarrDlls[11] := 'scopecom.dll';
  LarrDlls[12] := 'scopeiso.dll';
  LarrDlls[13] := 'scopejava.dll';
  LarrDlls[14] := 'scopelib.dll';
  LarrDlls[15] := 'scopeprf.dll';
  LarrDlls[16] := 'scopereg.dll';
  LarrDlls[17] := 'scopetcp.dll';
  LarrDlls[18] := 'scope.ini';

  LPathDLL := PathWithDelim(AstrPathDLL);
  for LintCnt := Low(LarrDlls) to High(LarrDlls) do
  begin
    LstrLibName := LPathDLL + LarrDlls[LintCnt];
    if not FileExists(LstrLibName) then
    begin
      AstrDLL := LstrLibName;
      Exit;
    end;
  end;

  Result := True ;
end ;

procedure UnLoadDLLFunctions(const PathDLL: String = '') ;
var
  LibHandle: TLibHandle ;
  LibName: string;
begin
  LibName := PathWithDelim(PathDLL);
  LibHandle := LoadLibrary(PChar(LibName + scope)) ;
  if LibHandle <> 0 then
    FreeLibrary(LibHandle) ;

  ScopeVersao := Nil ;
  ScopeOpen := Nil ;
  ScopeClose := Nil ;
  ScopeCompraCartaoCredito := Nil ;
  ScopeAbreSessaoTEF := Nil ;
  ScopeSetAplColeta := Nil ;
  ScopeStatus := Nil ;
  ScopeGetParam := Nil ;
  ScopeResumeParam := Nil ;
  ScopeGetLastMsg := Nil ;
  ScopeGetCheque := Nil ;
  ScopeGetCupomEx := Nil ;
  ScopeFechaSessaoTEF := Nil ;
  ScopeConsultaCDC := Nil ;
  ScopeCompraCartaoDebito := Nil ;
  ScopeConsultaCheque := Nil ;
  ScopeCancelamento := Nil ;
  ScopeReimpressaoComprovante := Nil ;
  ScopeResumoVendas := Nil ;
  ScopeObtemCampoExt := Nil ;
  ScopeObtemCampoExt2 := Nil ;
  ScopeObtemCampoExt3 := Nil ;
  ScopeObtemHandle := Nil ;
  ScopePagamento := Nil ;
  ScopeRecargaCelular := Nil ;
  ScopePreAutorizacaoCredito := Nil ;
  ScopeRecuperaOperadorasRecCel := Nil ;
  ScopeRecuperaValoresRecCel := Nil ;
  ScopeConfigura := Nil ;
  ScopeValidaInterfacePP := Nil ;
  ScopeConsultaPP := Nil ;
  ScopePPClose := Nil ;
  ScopeSuspend := Nil ;
  ScopeResume := Nil ;
  ScopeAbort := Nil ;
  ScopeForneceCampo := Nil ;
  ScopeMTEFOnOff := Nil ;
  ScopePPStartGetData := Nil ;
  ScopePPGetData := Nil ;
  ScopePPStartGetKey := Nil ;
  ScopePPOpenSecure := Nil ;
  ScopePPGetCOMPort := Nil ;
  ScopeObtemListaCarteiraVirtualEx := Nil;
  ScopeCarteiraVirtualEx2 := Nil;
  ScopePPMMFileLoad := Nil;
  ScopePPMMFileList := Nil;
  ScopePPMMFileDelete := Nil;
  ScopePPMMDisplayImage := Nil;
  ScopePPDisplay := Nil;
  ScopePPGetInfoEx := Nil;
end ;

function AbreSCOPE(_Empresa, _Filial, _PDV: string; _Desligou: Boolean = False): LongInt;
var
  iRet : LongInt;

begin
  iRet := SCO_SUCESSO;

  if (FintSinc and INI_COMUNIC) = 0 then
  begin
    iRet := ScopeOpen(PAnsiChar(AnsiString('2')),
                      PAnsiChar(AnsiString(_Empresa)),
                      PAnsiChar(AnsiString(_Filial)),
                      PAnsiChar(AnsiString(_PDV)));

    if iRet = NCR_CODIGO_RETORNO_SCOPE_API_JA_FOI_INICIALIZADA then
      iRet := SCO_SUCESSO ;

    if (iRet = SCO_SUCESSO) then
    begin
      FintSinc := FintSinc or INI_COMUNIC;
      if _Desligou then
      begin
        ScopeMTEFOnOff(1); // caso tenha alguma transação pendente, a mantem pendente
        FechaSessaoTEF(SCO_CONFIRMA_TEF, 1, _Desligou);
      end ;
    end;
  end;

  Result := iRet;
end;

//------------------------------------------------------------------------------
//  Realiza o procedimento para termino de uma sessao TEF. Basicamente essa
// funcao desfara' todos os passos realizados na funcao AbreSessaoTEF().
// @param  bAcao  A acao 'a ser realizada:
//                  - SCO_CONFIRMA_TEF: confirma a transacao.
//                  - SCO_DESFAZ_TEF: desfaz a transacao.
// @param  bForcar Para forcar o fechamento da sessao.
//------------------------------------------------------------------------------
procedure FechaSessaoTEF(bAcao: Byte; bForcar: Byte = 0; blnDesligou: Boolean = False);
var
  bAux:   Byte;
  iRet:   LongInt;
  iTentativas : Integer ;
begin
  if (((FintSinc and INI_SESSAO) <> 0 ) or (bForcar = 1)) then
  begin
    iTentativas := 0 ;
    repeat
      {$WARN UNSAFE_CODE OFF}
      iRet := ScopeFechaSessaoTEF(bAcao, @bAux);
      {$WARN UNSAFE_CODE ON}

      if iRet = SCO_SUCESSO then
        Break ;

      inc(iTentativas) ;
      if iTentativas > 10 then
        Break ;

      Sleep(1000);

    until iRet = SCO_SUCESSO ;

    if (iRet = SCO_SUCESSO) then
      FintSinc := FintSinc and not INI_SESSAO;

  end;

  if not blnDesligou then
    FechaSCOPE(FstrMsgPinPad) ;

end;

//------------------------------------------------------------------------------
//  Procedimento para finalizacao da comunicao com o servidor SCOPE.
//------------------------------------------------------------------------------
procedure FechaSCOPE(const AstrMsg: String);
begin
  FintSinc := 0 ;
  FechaPINPad(AstrMsg);
  ScopeClose;
end;

//------------------------------------------------------------------------------
//  Procedimento para finalização da comunicacao com o PPad.
//------------------------------------------------------------------------------
procedure FechaPINPad(const AstrMsg: String);
begin
  ScopePPClose(PAnsiChar(AnsiString(AstrMsg)));
end;

//------------------------------------------------------------------------------
//  Procedimento para inicializacao da comunicacao com o PPad.
//------------------------------------------------------------------------------
function AbrePINPad(const AintPortaCom: Integer): LongInt;
var
  iRet:       LongInt;

  bConfig,
  bExclusivo,
  bPorta:     Byte;
  LstrComPort: String;
begin

  { Consulta como esta' configurado o PIN-Pad
    compartilhado no ScopeCNF }
  {$WARN UNSAFE_CODE OFF}
  iRet := ScopeConsultaPP (@bConfig, @bExclusivo, @bPorta);
  {$WARN UNSAFE_CODE ON}

  if bExclusivo = 0 then
    bPorta := Byte(AintPortaCom)
  else /// se exclusivo não inicia o TEF
  begin
    Result := -5;
    Exit;
  end ;

  if iRet <> PC_OK then
  begin
    Result := iRet;
    Exit;
  end;

  FsppPinPad := sppOperacional ;

  // Abre conexao com PINPad
  LstrComPort := IntToStr(bPorta) ;
  iRet := ScopePPOpenSecure(1, PAnsiChar(AnsiString(LstrComPort))) ;
  if iRet <> PC_OK then
  begin
    Result := iRet;
    FsppPinPad := sppNaoExiste ;
    Exit;
  end;

  Result := SCO_SUCESSO;
end;

//------------------------------------------------------------------------------
//  Procedimento para inicializacao de uma transacao.
//------------------------------------------------------------------------------
function AbreSessaoTEF(const blnDesligou: Boolean = False; const blnPixSemPinPad: Boolean = False): LongInt;
var
  iRet:   LongInt;

begin
  iRet := SCO_SUCESSO;
  if blnPixSemPinPad then
  begin
    iRet := AbreSCOPE(FstrEmpresa, FstrFilial, FstrPdv, blnDesligou);
    if iRet <> SCO_SUCESSO then
    begin
      Result := iRet;
      Exit ;
    end ;
    ScopeSetAplColeta;

    ScopeConfigura(CFG_CANCELAR_OPERACAO_PINPAD, 0);
    ScopeConfigura(CFG_OBTER_SERVICOS_SCOPE, 0);
    ScopeConfigura(CFG_IMPRESSORA_PAPEL_CARBONO, 0);
    ScopeConfigura(CFG_SOLICITAR_DIGITACAO_SENHA, 0);
    ScopeConfigura(CFG_NAO_ABRIR_DIGITADO_COM_PP, 0);
    ScopeConfigura(CFG_MASCARAR_DADOS, 1);
    ScopeConfigura(CFG_ARMAZENA_EM_QUEDA, 0);
    ScopeConfigura(CFG_COLETA_RECARGA_PP, 0);

    AbrePINPad(FintComPort);

    iRet := ScopeAbreSessaoTEF;

    if iRet = SCO_SUCESSO then
    begin
      FintSinc := FintSinc or INI_SESSAO;
      FintSinc := FintSinc or INI_APLCOLET;
    end;
  end
  else
  begin
    if (FintSinc and INI_SESSAO) = 0 then
    begin
      iRet := AbreSCOPE(FstrEmpresa, FstrFilial, FstrPdv, blnDesligou);
      if iRet <> SCO_SUCESSO then
      begin
        Result := iRet;
        Exit ;
      end ;

      iRet := ScopeAbreSessaoTEF;

      if iRet = SCO_SUCESSO then
        FintSinc := FintSinc or INI_SESSAO;

      if (FintSinc and INI_APLCOLET) = 0 then
      begin
        ScopeSetAplColeta;

        // Verificar se a aplicacao precisa abrir o PINPad
        iRet := AbrePINPad(FintComPort);
        if iRet = NCR_CODIGO_RETORNO_PINPAD_JA_FOI_ABERTO then
          iRet := SCO_SUCESSO ;

        if iRet = SCO_SUCESSO then
        begin
          // Aproveitar e configurar o SCOPE.
          ScopeConfigura(CFG_CANCELAR_OPERACAO_PINPAD, 1);

          FintSinc := FintSinc or INI_APLCOLET;
        end ;

      end ;

    end;
  end;

  Result := iRet;
end;

end.
