unit untFuncoesBoleto;

interface

uses

	IniFiles, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, Mask, ComCtrls, StrUtils, dateUtils,
  BitBtnLockedIncrem, Uni, untIIntegracaoPixCitel, untTIntegracaoPixCitel, untTiposPix,
  untTFuncoesAuxiliaresPix, UNiClientDataset, Data.DB, System.Json;


type tCampos = Record

  strNomCam : String;
  strValCam : String;
  strIdeBan : String;
  intTamCam : Integer;

End;

Type
  TRetornoBoletoBancoDoBrasil = class
  public
    nossoNumero                      : String;
    numeroCarteira                   : String;
    numeroVariacaoCarteira           : String;
    codigoCliente                    : String;
    linhaDigitavel                   : String;
    codigoDeBarras                   : String;
    numeroContratoCobranca           : String;
    {Beneficiario}
    BeneficiarioAgencia              : String;
    BeneficiarioContaCorrente        : String;
    BeneficiarioTipoEndereco         : String;
    BeneficiarioLogradouro           : String;
    BeneficiarioBairro               : String;
    BeneficiarioCidade               : String;
    BeneficiarioCodigoCidade         : String;
    BeneficiarioUf                   : String;
    BeneficiarioCep                  : String;
    BeneficiarioIndicadorComprovacao : String;
    {Pix}
    QrCodeUrl                        : String;
    QrCodeTxId                       : String;
    QrCodeEmv                        : String;
    QrCodeLinkCitel                  : String;
  end;

Type
  TRetornoBoletoItau = class
  public
    nossoNumero                      : String;
    numeroCarteira                   : String;
    numeroVariacaoCarteira           : String;
    codigoCliente                    : String;
    linhaDigitavel                   : String;
    codigoDeBarras                   : String;
    idIndividualBoleto               : String;
    {Beneficiario}
    BeneficiarioAgencia              : String;
    BeneficiarioContaCorrente        : String;
    BeneficiarioTipoEndereco         : String;
    BeneficiarioLogradouro           : String;
    BeneficiarioBairro               : String;
    BeneficiarioCidade               : String;
    BeneficiarioCodigoCidade         : String;
    BeneficiarioUf                   : String;
    BeneficiarioCep                  : String;
    BeneficiarioIndicadorComprovacao : String;
    {Pix}
    QrCodeUrl                        : String;
    QrCodeTxId                       : String;
    QrCodeEmv                        : String;
    QrCodeLinkCitel                  : String;
  end;

Type
  TRetornoBoletoBancoCredisis = class
  public
    nossoNumero                      : String;
    numeroCarteira                   : String;
    codigoCliente                    : String;
    linhaDigitavel                   : String;
    codigoDeBarras                   : String;
    {Beneficiario}
    BeneficiarioAgencia              : String;
    BeneficiarioContaCorrente        : String;
    BeneficiarioTipoEndereco         : String;
    BeneficiarioLogradouro           : String;
    BeneficiarioBairro               : String;
    BeneficiarioCidade               : String;
    BeneficiarioCodigoCidade         : String;
    BeneficiarioUf                   : String;
    BeneficiarioCep                  : String;
    BeneficiarioIndicadorComprovacao : String;
    {Pix}
    //QrCodeUrl                        : String;
    //QrCodeTxId                       : String;
    //QrCodeEmv                        : String;
  end;

Type
  TRetornoBoletoBancoSicredi = class
  public
    nossoNumero                      : String;
    posto                            : String;
    cooperativa                      : String;
    numeroCarteira                   : String;
    numeroVariacaoCarteira           : String;
    codigoCliente                    : String;
    linhaDigitavel                   : String;
    codigoDeBarras                   : String;
    numeroContratoCobranca           : String;
    {Beneficiario}
    BeneficiarioAgencia              : String;
    BeneficiarioContaCorrente        : String;
    BeneficiarioTipoEndereco         : String;
    BeneficiarioLogradouro           : String;
    BeneficiarioBairro               : String;
    BeneficiarioCidade               : String;
    BeneficiarioCodigoCidade         : String;
    BeneficiarioUf                   : String;
    BeneficiarioCep                  : String;
    BeneficiarioIndicadorComprovacao : String;
    {Pix}
    QrCodeUrl                        : String;
    QrCodeTxId                       : String;
    QrCodeEmv                        : String;
    QrCodeLinkCitel                  : String;
  end;

Type
  TRetornoBoletoSicoob = class
  public
    numeroCliente,
    codigoModalidade,
    numeroContaCorrente,
    codigoEspecieDocumento,
    dataEmissao,
    nossoNumero,
    seuNumero,
    identificacaoBoletoEmpresa,
    codigoBarras,
    linhaDigitavel,
    identificacaoEmissaoBoleto,
    identificacaoDistribuicaoBoleto,
    valor,
    dataVencimento,
    dataLimitePagamento,
    valorAbatimento,
    tipoDesconto,
    dataPrimeiroDesconto,
    valorPrimeiroDesconto,
    dataSegundoDesconto,
    valorSegundoDesconto,
    dataTerceiroDesconto,
    valorTerceiroDesconto,
    tipoMulta,
    dataMulta,
    valorMulta,
    tipoJurosMora,
    dataJurosMora,
    valorJurosMora,
    numeroParcela,
    aceite,
    codigoNegativacao,
    numeroDiasNegativacao,
    codigoProtesto,
    numeroDiasProtesto,
    quantidadeDiasFloat,
    pagadorNumeroCpfCnpj,
    pagadorNome,
    pagadorEndereco,
    pagadorBairro,
    pagadorCidade,
    pagadorCep,
    pagadorUf,
    pagadorEmail,
    beneficiarioFinalNumeroCpfCnpj,
    beneficiarioFinalNome,

    Instrucao01,
    Instrucao02,
    Instrucao03,
    Instrucao04,
    Instrucao05,

    {Pix}
    QrCodeTxId, //Banco não retorna essa informação, será gerada uma interna
    QrCodeEmv,
    QrCodeLinkCitel: String;
  end;

Type
  TRetornoBoletoSantander = class
  public
    idBoleto,
    nossoNumero,
    seuNumero,
    chaveDuplicata,

    linhaDigitavel,
    codigoBarras,

    dataEmissao,

    {Pix}
    QrCodeTxId,
    QrCodeUrl,
    QrCodeEmv,
    QrCodeLinkCitel: String;
  end;

Type
  TRetornoBoletoBancoSafra = class
  public
    nossoNumero                      : String;
    digitoAgencia                    : String;
    codigoAgencia                    : String;
    CodigoCarteira                   : String;
    codigoCliente                    : String;
    linhaDigitavel                   : String;
    codigoDeBarras                   : String;

    {Beneficiario}
    BeneficiarioAgencia              : String;
    BeneficiarioContaCorrente        : String;
    BeneficiarioTipoEndereco         : String;
    BeneficiarioLogradouro           : String;
    BeneficiarioBairro               : String;
    BeneficiarioCidade               : String;
    BeneficiarioCodigoCidade         : String;
    BeneficiarioUf                   : String;
    BeneficiarioCep                  : String;

    {Pix}
    QrCodeUrl                        : String;
    QrCodeTxId                       : String;
    QrCodeEmv                        : String;
    QrCodeLinkCitel                  : String;
  end;

type
  TRetornoBoletoBradesco = class
  public
    CodigoRetorno: string;
    MensagemRetorno: string;
    IdProduto: Integer;
    Negociacao: Int64;
    NuTituloGerado: Int64;
    NomeBeneficiario: string;
    LogradouroBeneficiario: string;
    NuLogradouroBeneficiario: Integer;
    ComplementoLogradouroBeneficiario: string;
    BairroBeneficiario: string;
    CepBeneficiario: Integer;
    CepComplementoBeneficiario: Integer;
    MunicipioBeneficiario: string;
    UfBeneficiario: string;
    NomePagador: string;
    CpfCnpjPagador: Int64;
    EnderecoPagador: string;
    BairroPagador: string;
    MunicipioPagador: string;
    UfPagador: string;
    CepPagador: Integer;
    CepComplementoPagador: string;
    EndEletronicoPagador: string;
    NomeSacadorAvalista: string;
    CnpjCpfSacadorAvalista: Int64;
    EnderecoSacadorAvalista: string;
    MunicipioSacadorAvalista: string;
    UfSacadorAvalista: string;
    CepSacadorAvalista: Integer;
    CepComplementoSacadorAvalista: Integer;
    SeuNumeroTitulo: string;
    DtRegistro: string;
    EspecieDocumentoTitulo: string;
    DescEspecie: string;
    VlIOF: Double;
    DtEmissao: string;
    CodigoMoedaTitulo: string;
    QuantidadeMoeda: Double;
    QuantidadeCasas: Integer;
    DtVencimento: string;
    DescricacaoMoeda: string;
    VlTitulo: Double;
    VlAbatimento: Double;
    DtInstrucaoProtestoNegativacao: string;
    DiasInstrucaoProtestoNegativacao: Integer;
    DataEnvioCartorio: string;
    NumeroCartorio: Integer;
    NumeroProtocoloCartorio: Integer;
    DataPedidoSustacao: string;
    DataSustacao: string;
    DtMulta: string;
    VlMulta: Double;
    QtdeCasasDecimaisMulta: Integer;
    CdValorMulta: Integer;
    DescCdMulta: string;
    DtJuros: string;
    VlJurosAoDia: Double;
    DtDesconto1Bonificacao: string;
    VlDesconto1Bonificacao: Double;
    QtdeCasasDecimaisDesconto1Bonificacao: Integer;
    CdValorDesconto1Bonificacao: Integer;
    DescCdDesconto1Bonificacao: string;
    DtDesconto2: string;
    VlDesconto2: Double;
    QtdeCasasDecimaisDesconto2: Integer;
    CdValorDesconto2: Integer;
    DescCdDesconto2: string;
    DtDesconto3: string;
    VlDesconto3: Double;
    QtdeCasasDecimaisDesconto3: Integer;
    CdValorDesconto3: Integer;
    DescCdDesconto3: string;
    DiasDispensaMulta: Integer;
    DiasDispensaJuros: Integer;
    CdBarras: string;
    LinhaDigitavel: string;
    ValorDespesas: Double;
    TipoEndosso: string;
    CodigoOrigemProtesto: Integer;
    CodigoOrigemTitulo: Integer;
    TpVencimento: Integer;
    IndInstrucaoProtesto: Integer;
    IndicadorDecurso: Integer;
    QuantidadeDiasDecurso: Integer;
    CdValorJuros: Integer;
    TpDesconto1: Integer;
    TpDesconto2: Integer;
    TpDesconto3: Integer;
    NuControleParticipante: string;
    DiasJuros: Integer;
    CdJuros: Integer;
    VlJuros: Double;
    CpfCnpjBeneficiario: string;
    VlTituloEmitidoBoleto: Double;
    DtVencimentoBoleto: string;
    DtLimitePagamentoBoleto: string;

    {Pix}
    QrCodeTxId,
    QrCodeUrl,
    QrCodeEmv,
    QrCodeLinkCitel: String;
  end;

Type TFuncoesPixBoleto = class
  private
    class var FHandlePixCitel: THandle;
    class var FPixCitel: TIntegracaoPixCitel;

    class function ValidaErroCertificadoPfx(ADadosRetorno: String): String;
  public
    class procedure CarregaLibPixCitel;

    class function RetornaJsonRegistroBoleto(AAutoIncremCadRec,
                                             ACodigoBanco: String): String;
    class function EncontrarJsonRegistroBoleto(AAutoIncremCadRec,
                                               ACodigoBanco: String): String;
    class function RetornaFiltroJsonDoBanco(ACodigoBanco: String;
                                            ADatasetCadrec: TDataset): String;

    class function IncluirLinkCitelPixBoleto(ACodigoBanco,
                                             ATxIdPix,
                                             AQRCodePix,
                                             AValorPix,
                                             AAutoIncremChavePix: String;
                                             ADataVencimento: TDateTime): String;

    class function RemoverLinkCitelPixBoleto(ACNPJEmpresa,
                                             ACodigoEmpresa,
                                             AIxIdPix,
                                             AAutoIncremChavePix: String;
                                             AGravarLogErr :Boolean): Boolean;

    class function ImportarDadosAutenticacao(AAutoIncremChavePix,
                                             AChavePix,
                                             ACodigoEmpresaConta: String): TDadosWebhook;

    class function RetornaDatasetDadosChavePix(AAutoIncremChavePix: String): TUniClientDataset;

    class function ConversorCertificadoPfxWebServiceCitelSemTela(AArquivoPfx,
                                                                 ASenhaArquivo: String): TJsonObject;
  End;

  {***************************************}
  {* F u n ç õ e s  d o  S i s t e m a s *}
  {***************************************}
  function ffrmSenha(var strSenha: string; strTitulo: String = ''): Boolean;

  {*******************************************}
  {* GERA DIGITOS VERIFICADOS PARA O BANESPA *}
  {****************************************ED*}
  function fGeraPrDiLi(cedent, duplic:String):String;
  function fGeraSeDiLi(cedent, duplic, digver:String):String;
  function fGePriDig033(strBanco1, strMoeda1, strCedent: String): String;
  function fGeSegDig033(strCedent, strNumDup:String): String;
  function fGeTerDig033(strNumDup, strBanco1, strDigiL1, strDigiL2:String): String;
  function fGeDigAut033(Banco1, Moeda1, FatVen, VlrDup, NrCCor, NosNum, NrBanc, Digit1, Digit2: String): String;

  {*********************************************}
  {* GERA DIGITOS VERIFICADOS PARA O SANTANDER *}
  {******************************************ED*}
  function fGeTerDig33B(strNumDup, strIof, strModCar: String): String;
  function fGeDigAut33B(Banco1, Moeda1, FatVen, VlrDup, NrCCor, NosNum, strIof, ModCar: String): String;

  function fCalculaDigitos: Boolean;
  function fCalculaDigitosHSBC: Boolean;

  //**********************************************************//
  // FUNCOES USADAS PARA CALCULO DOS DIGITOS DO BANCO SICREDI //
  //*******************************************************ED*//
  function fGePriDigSic(strBanco1, strMoeda1, strCedent: String): String;
  function fGeSegDigSic(strCedent, strNumDup:String): String;
  function fGeTerDigSic(strNumAge, strCodCed:String): String;

  {**********************************************}
  {* FUNCAO USADA PARA CALCULO DO DIGITO ASBACE *}
  {*******************************************AF*}
  function fGeDigAutCon(strBarras: String): String;
  function fCalDigAsbace1(strNumero: String): String;
  function fCalDigAsbace2(strNumero: String): String;


  {**************************************************}
  {* GERA DIGITOS PARA BOLETOS ITAU, SAFRA, SICREDI *}
  {***********************************************ED*}
  function fGePriDig(strBanco1, strMoeda1, strCedent: String): String;
  function fGeSegDig(strCedent, strNumDup:String): String;
  function fGeTerDig(strNumAge, strCodCed:String): String;


  {**********************************}
  {* GERA DIGITOS PARA BOLETOS ITAU *}
  {*******************************ED*}
  function fGeDigAut(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;
  function fGeDigAutSicred(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;



  //********************************************//
  // GERA DIGITO VERIFICADO PARA O CAMPO LIVRE  //
  //*****************************************ED*//
  function fGeDigCmL(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;
  function fGeDigCmLSicred(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;


  //*************************************************//
  // CALCULA O DIGITAO DE COBRANCA DO BANCO REAL     //
  //**********************************************ED*//
  function fcDigitaoCobReal(strNosNum, strNumAge, strCodCed: String): String;


  {****************************************}
  {* OUTRAS FUNÇÕES UTILIZADAS NO SISTEMA *}
  {*************************************ED*}
	function fGerar_String_Codigo_Barra(Numero:String):String;
  function fMaskCNPJ(strCNPJ: String): String;
  function fMaskCPF(strCPF: String): String;
  function fMaskCEP(strCEP: String): String;
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
  procedure pAtribuiDadosBoleto(strCodBar: String; var strCodBco, strCodAge, strCodCar, strConCor, strNosNum, strFatVen: String);
//  function fArqIniExe(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;

  {*****************************************}
  {* CALCULO DO NC DO BANRRISUL            *}
  {**************************************AF*}
  function fCalcDigitoModulo10(strString: String): String;
  function fCalcDigitoModulo11(strString: String; var strDigit1: String): String;

  {***********************************************}
  {* GERA DIGITOS PARA BOLETOS BANCO NORDESTE    *}
  {********************************************MO*}
  function fGePriDig004(strBanc3, strMoeda1, strAgenc4, strCeden1: String): String;
  function fGeSegDig004(strCeden6, strDigCe1, strNosNu3:String): String;
  function fGeTerDig004(strNosNu4, strDvNosNu1, strCarte2:String): String;
  function fGeDigAut004(strCodB43: String): String;

  function fMontaCodBarLinDig: Boolean;

  function fMultiplo10(intValor: Integer): Integer;
  function fRetNumParcela(strNumDoc: String): String;
  function RetornaNumeroParcela(ANumDoc:String):String;
  function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;

  function fValidaStrings: Boolean;
  function fValidaTamanhoString(strDigito, strNomPar, strIdeBan: String; intTamanh: Integer): Boolean;
  function fVerificaContido(strOrigem, strContid, strNomStr: String): Boolean;
  function fValidaData(strPosicao, strVlrPos, strNomCam: String): Boolean;

  //function fCalcSDigitoUnibanco(strNosNum: String): String;
  function fRetDadosPadrao(strIdeBan, strNomPar: String): String;
  function fReplicatorStr(strRepl: String; intTamanho: Integer):String;

  function fRetornaVersao(strNomArq: String = ''): String;
  function fEmptyStr(strString : String) : Boolean;

  function fGetModulo11_409(strNosNum: String; strCodBar: String): String;

  {***************************************************************}
  {* GERA DIGITOS VERIFICADOS PARA O BANCO SOFISA LAYOUT PROPRIO *}
  {***************************************************************}
  function fGePriDig637(strBanco1, strMoeda1, strAgencia, strCarteira: String): String;
  function fGeSegDig637(strCarteira, strOperacao, strNosNumero:String): String;
  function fGeTerDig637(strNosNumero: String): String;
  function fGeDigAut637(Banco1, Moeda1, FatVen, VlrDup, Agencia, Carteira, NumeroOper, NosNum_Com_DV: String): String;

var

  blnBolPdf: Boolean;
  {*****************************************************}
  {* VARIÁVEIS QUE ARMAZENAM OS DIGITOS VERIFICADORES  *}
  {**************************************************ED*}
  strFatVen  : String;
  strStrBar  : String;
  strDigiL1  : String;
  strDigiL2  : String;
  strDigit1  : String;
  strDigit2  : String;

  strDigit1_Banrisul: String;
  strDigit2_Banrisul: String;

  strDigit3  : String;
  strCodBar  : String;
  strVlrDup  : String;
  strDiAuCo  : String;
  strLinDig  : String;
  strDiAsb1  : String;
  strDiAsb2  : String;
  strDCmLiv  : String;
  strDigita  : String; //DIGITAO DO BANCO REAL

  //*************************************************//
  // VARIAVEL QUE ARMAZENA O SUPER DIGITO, USADO     //
  // SOMENTE NO UNIBANCO                             //
  //**********************************************ED*//
  strSupDig : String;


  {***********************************************}
  {* VARIAVEIS QUE RECEBEM OS VALORES DOS TXT'S  *}
  {********************************************ED*}
  strIdeBan  : String;    // IDENTIFICAÇÃO DO BANCO
  strIdeFac  : String;    // IDENTIFICAÇÃO DA FACTORING
  strTipIns  : String;    // TIPO DE INSCRIÇÃO DA EMPRESA
  strNumIns  : String;    // NÚMERO DE INSCRIÇÃO DA EMPRESA
  strNomCed  : String;    // NOME DO CEDENTE
  strDigCed  : String;    // DIGITO DO CEDENTE
  strNumAge  : String;    // NÚMERO DA AGÊNCIA
  strCodCed  : String;    // CÓDIGO DO CEDENTE
  strNosNum  : String;    // NOSSO NÚMERO / NÚMERO DO DOCUMENTO
  strNumDup  : String;    // NÚMERO DA DUPLICATA
  strNumDoc  : String;    // NÚMERO DO DOCUMENTO
  strEspDoc  : String;    // ESPÉCIE DO DOCUMENTO
  strCodCar  : String;    // CÓDIGO DA CARTEIRA
  strEspTit  : String;    // ESPÉCIE  DO TÍTULO
  strIdeAce  : String;    // INDENTIFICAÇÃO ACEITE
  strTipISa  : String;    // TIPO DE INSCRIÇÃO DO SACADO
  strNuInSa  : String;    // NÚMERO DE INSCRICAO DO SACADO
  strNomSac  : String;    // NOME DO SACADO
  strEndSac  : String;    // ENDEREÇO DO SACADO
  strBaiSac  : String;    // BAIRRO DO SACADO
  strCep001  : String;    // CEP DO SACADO
  strCidSac  : String;    // CIDADE DO SACADO
  strEstSac  : String;    // ESTADO DO SACADO
  strSacAva  : String;    // NOME DO SACADO / AVALISTA
  strPraPro  : String;    // PRAZO PARA PROTESTO
  strLocPag  : String;    // LOCAL DE PAGAMENTO
  strUsoBan  : String;    // USO DO BANCO
  strInstr1  : String;    // INSTRUÇÃO DO BANCO 1
  strInstr2  : String;    // INSTRUÇÃO DO BANCO 2
  strInstr3  : String;    // INSTRUÇÃO DO BANCO 3
  strInstr4  : String;    // INSTRUÇÃO DO BANCO 4
  strInstr5  : String;    // INSTRUÇÃO DO BANCO 5
  strInTr5D  : String;    // DESTACA EM NEGRITO INSTRUÇÃO DO BANCO 5
  strVlrTit  : String;    // VALOR NOMINAL DO TITULO
  strMoeda1  : String;    // CODIGO DA MOEDA CORRENTE = 9
  strCmpLiv  : String;    // STRING CAMPO LIVRE
  strDigAge  : String;    // STRING RESPONSAVEL EM ARMAZENAR O DIGITO DA AGENCIA
  strNumCon  : String;    // NUMERO DO CONVENIO
  strCodCli  : String;    // CODIGO DO CLIENTE
  strModCob  : String;    // MODALIDADE DE COBRANCA (EX. COM OU SEM REGISTRO)
  strVariac  : String;    // VARIACAO
  strEndere  : String;    // ENDEREÇO
  strIdeCed  : String;    // IDENTIFICAÇÃO DO CEDENTE
  strUsoCli  : String;    // USO DO CLIENTE
  strTipDia  : String;    // TIPO DE DIAS PARA PROTESTO
  dtaDtaVen  : TDateTime; // DATA DO VENCIMENTO
  dtaDtaEmi  : TDateTime; // DATA DA EMISSÃO
  dtaDtaPro  : TDateTime; // DATA DO PROCESSAMENTO
  fltVlrDes  : Double;    // VALOR DO DESCONTO
  fltVlrMor  : Double;    // VALOR DA MORA DIÁRIA
  fltVlrMul  : Double;    // VALOR DA MULTA
  fltDesBol  : Double;    // DESCONTO PARA PAGAMENTO A VISTA
  blnProEnt  : Boolean;   // IMPRIME PROTOCOLO DE ENTREGA
  fltOutAcr  : Double;    // VALOR OUTROS ACRESCIMOS
  strSisCob  : String;    // COBRANÇA CEF (SICOB, SIGCB OU SINCO)
  strBB_Crr  : String;    // BANCOOB 240 POSIÇÕES COM CORRESPONDENTE BANCO DO BRASIL
  strConCrr  : String;    // CONVENIO PREFIXO NOSSO NÚMERO BANCOOB 240 POSIÇÕES COM CORRESPONDENTE BANCO DO BRASIL
  strCobReg  : String;    // COBRANÇA REGISTRADA (S/N) USADO PARA IDENTIFICAR O 1º NÚMERO DO CAMPO LIVRE 1 COM REG. 3 SEM REG (SICREDI)
  strObsSac	 : String;		// SACADOR/AVALISTA NOME + CPF/CNPJ;
  strTpIden  : String;    // TIPO IDENTIFICADOR //HSBC 399 //COBRANÇA SEM REGISTRO *BB*
  blnPegImp  : Boolean;
  blnPreview : Boolean;
  blnSantan  : Boolean;
  strBraCrr  : String;    // SIFRA/SAFRA/UNICRED COM CORRESPONDENTE BRADESCO
  strDesCed  : String;    // NOME DA AGÊNCIA CORRESPONDENTE
  strEndCed  : String;    // ENDEREÇO DA AGÊNCIA CORRESPONDENTE
  strCompCed : String;    // COMPLEMENTO DA AGÊNCIA CORRESPONDENTE
  strBaiCed  : String;    // BAIRRO DA AGÊNCIA CORRESPONDENTE
  strCidCed  : String;    // CIDADE DA AGÊNCIA CORRESPONDENTE
  strEstCed  : String;    // ESTADO DA AGÊNCIA CORRESPONDENTE
  strCepCed  : String;    // CEP DA AGÊNCIA CORRESPONDENTE
  strCgcCed  : String;    // CNPJ DA AGÊNCIA CORRESPONDENTE
  strUsoBco  : String;    // SE FOR SAFRA CORRESPONDENTE DEVE IR "CIP130", DEMAIS BANCOS DEVE IR EM BRANCO
  strCdIns1  : String;    // CÓDIGO DA PRIMERIA INSTRUÇÃO
  strCdIns2  : String;    // CÓDIGO DA SEGUNDA INSTRUÇÃO
  strCodEmp  : String;    // CÓDIGO DA EMPRESA
  strMailCli : String;    // EMAIL DO CLIENTE
  strBcoIni  : String;    // BANCO INICIAL
  strInfAdi  : String;    //Informação Adicional (Carteira)
  strBenefi  : String;
  strEndBen  : String;
  blnSantan240p  : Boolean;
  blnSantan637_444p  : Boolean;
  strEspeci  : String;
  strChaveBRB : String;
  strConRem  : String;
  fltPerMul  : Double;
  fltPerMor  : Double;
  strImpAgBenef: String;  // IMPRIME AGÊNCIA COM BENEFICIÁRIO
  strCodProt   : String;  //CODIGO DE PROTESTO (APENAS SICOOB POR ENQUANTO)

  strLinhaDigitavelAPI,
  strCodigoCedenteBancoInter,
  strInstrucao1BancoInter,
  strInstrucao2BancoInter,
  strInstrucao3BancoInter,
  strInstrucao4BancoInter,
  strInstrucao5BancoInter: String;

  LRetornoRegistroBoletoApi : TObject;

  LObservacaoAG1,
  LObservacaoAG2,
  LObservacaoAG3,
  LObsCompletaAG : String;

  strDiaMora : string;
  strNumOperacao : string;

  strbcoInicialCompleto : String;
  strCodCartBoleto : String;

  LIdentificacaoBanco : String;

  strRazaoSocialCooperativa, // RAZAO SOCIAL DA COOPERATIVA
  strIncrisaoCooperativa,    // INSCRIÇÃO DA COOPERATIVA
  strEnderecoCoopetativa,    // ENDEREÇO DA COOPERATIVA
  strBairroCooperativa,      // BAIRRO DA COOPERATIVA
  strCidadeCooperativa,      // CIDADE DA COOPERATIVA
  strEstadoCooperativa,      // ESTADO DA COOPERATIVA
  strCEPCooperativa: String; // CEP DA COOPERATIVA

  strNroOpe: String;         // Numero de Operação

  strImprimirParcela: String; //IMPRIME OU NÃO A PARCELA NO BOLETO

  FApresentarEspDocumento: String;
  FQRCode : String;

  arrValidar : Array Of tCampos;

  strEspDocOriginal         : String; //ESPÉCIE DO DOCUMENTO ORIGINAL PELO AUTCOM
  strNumDocumentoSemParcela : String; //NUMERO DO DOCUMENTO SEM A PARCELA
  strParcelaDoDocumento     : String; //PARCELA DO DOCUMENTO

  ADiasCartorio             : String; // QUANTIDADE DE DIAS PARA CARTÓRIO
  blnParNum                 : Boolean;// UTILIZAR PARCELA NUMERAL? (A = 001) REQ:158267 --> MTO
  blnObsDes                 : Boolean;// Destaca em negrito a observacao 5 req: 159365
  FExibirParcelasEmNegritoCarne: Boolean;
  VS_ErroGeraBoletoLaser: String;

implementation
uses untDesCam, untFuncoesSimples, System.UITypes;


function fGerar_String_Codigo_Barra(Numero:String):String;

  Var
    vIntContaDor : Integer;
    vStrTexto    : Array[00..99] of String;
    vStrNumero   : String;
    vStrTexto1   : String;

Begin

  vStrTexto[00] := '#';
  vStrTexto[01] := '$';
  vStrTexto[02] := '%';
  vStrTexto[03] := '&';
  vStrTexto[04] := '''';
  vStrTexto[05] := '(';
  vStrTexto[06] := ')';
  vStrTexto[07] := '*';
  vStrTexto[08] := '+';
  vStrTexto[09] := ',';
  vStrTexto[10] := '-';
  vStrTexto[11] := '.';
  vStrTexto[12] := '/';
  vStrTexto[13] := '0';
  vStrTexto[14] := '1';
  vStrTexto[15] := '2';
  vStrTexto[16] := '3';
  vStrTexto[17] := '4';
  vStrTexto[18] := '5';
  vStrTexto[19] := '6';
  vStrTexto[20] := '7';
  vStrTexto[21] := '8';
  vStrTexto[22] := '9';
  vStrTexto[23] := ':';
  vStrTexto[24] := ';';
  vStrTexto[25] := '<';
  vStrTexto[26] := '=';
  vStrTexto[27] := '>';
  vStrTexto[28] := '?';
  vStrTexto[29] := '@';
  vStrTexto[30] := 'A';
  vStrTexto[31] := 'B';
  vStrTexto[32] := 'C';
  vStrTexto[33] := 'D';
  vStrTexto[34] := 'E';
  vStrTexto[35] := 'F';
  vStrTexto[36] := 'G';
  vStrTexto[37] := 'H';
  vStrTexto[38] := 'I';
  vStrTexto[39] := 'J';
  vStrTexto[40] := 'K';
  vStrTexto[41] := 'L';
  vStrTexto[42] := 'M';
  vStrTexto[43] := 'N';
  vStrTexto[44] := 'O';
  vStrTexto[45] := 'P';
  vStrTexto[46] := 'Q';
  vStrTexto[47] := 'R';
  vStrTexto[48] := 'S';
  vStrTexto[49] := 'T';
  vStrTexto[50] := 'U';
  vStrTexto[51] := 'V';
  vStrTexto[52] := 'W';
  vStrTexto[53] := 'X';
  vStrTexto[54] := 'Y';
  vStrTexto[55] := 'Z';
  vStrTexto[56] := '[';
  vStrTexto[57] := '\';
  vStrTexto[58] := ']';
  vStrTexto[59] := '^';
  vStrTexto[60] := '_';
  vStrTexto[61] := '`';
  vStrTexto[62] := 'a';
  vStrTexto[63] := 'b';
  vStrTexto[64] := 'c';
  vStrTexto[65] := 'd';
  vStrTexto[66] := 'e';
  vStrTexto[67] := 'f';
  vStrTexto[68] := 'g';
  vStrTexto[69] := 'h';
  vStrTexto[70] := 'i';
  vStrTexto[71] := 'j';
  vStrTexto[72] := 'k';
  vStrTexto[73] := 'l';
  vStrTexto[74] := 'm';
  vStrTexto[75] := 'n';
  vStrTexto[76] := 'o';
  vStrTexto[77] := 'p';
  vStrTexto[78] := 'q';
  vStrTexto[79] := 'r';
  vStrTexto[80] := 's';
  vStrTexto[81] := 't';
  vStrTexto[82] := 'u';
  vStrTexto[83] := 'v';
  vStrTexto[84] := 'w';
  vStrTexto[85] := 'x';
  vStrTexto[86] := 'y';
  vStrTexto[87] := 'z';
  vStrTexto[88] := '{';
  vStrTexto[89] := '|';
  vStrTexto[90] := '}';
  vStrTexto[91] := '~';
  vStrTexto[92] := 'Ä';
  vStrTexto[93] := 'Å';
  vStrTexto[94] := 'Ç';
  vStrTexto[95] := 'É';
  vStrTexto[96] := 'Ñ';
  vStrTexto[97] := 'Ö';
  vStrTexto[98] := 'Ü';
  vStrTexto[99] := 'á';

  vStrTexto1 := '!';
  vStrNumero := Numero;

  For vIntContaDor := 1 to 22 Do
  Begin

    vStrTexto1 := vStrTexto1 + vStrTexto[StrToInt(Copy(vStrNumero,1,2))];
    Delete(vStrNumero,1,2);

  End;

  vStrTexto1 := vStrTexto1 + '"';
  Result := vStrTexto1;

end;

{*******************************************}
{* FUNCÃO QUE GERA O PRIMEIRO DÍGITO LIVRE *}
{****************************************ED*}
function fGeraPrDiLi(cedent, duplic:String):String;

  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..23] Of Integer;
    strOrigin: String;

Begin

  arrConsta[1]  := 2;
  arrConsta[2]  := 1;
  arrConsta[3]  := 2;
  arrConsta[4]  := 1;
  arrConsta[5]  := 2;
  arrConsta[6]  := 1;
  arrConsta[7]  := 2;
  arrConsta[8]  := 1;
  arrConsta[9]  := 2;
  arrConsta[10] := 1;
  arrConsta[11] := 2;
  arrConsta[12] := 1;
  arrConsta[13] := 2;
  arrConsta[14] := 1;
  arrConsta[15] := 2;
  arrConsta[16] := 1;
  arrConsta[17] := 2;
  arrConsta[18] := 1;
  arrConsta[19] := 2;
  arrConsta[20] := 1;
  arrConsta[21] := 2;
  arrConsta[22] := 1;
  arrConsta[23] := 2;

  strOrigin := cedent + duplic + '00' + strIdeBan;
  intResul1 := 0;

  For intI := 1 To 23 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);

end;

{*****************************************}
{ FUNCÃO QUE GERAR O SEGUNDO DÍGITO LIVRE }
{**************************************ED*}
function fGeraSeDiLi(cedent, duplic, digver:String):String;

  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..24] Of Integer;
    strOrigin: String;
    blnVerifi: Boolean;

Begin

  blnVerifi := False;

  arrConsta[1]  := 7;
  arrConsta[2]  := 6;
  arrConsta[3]  := 5;
  arrConsta[4]  := 4;
  arrConsta[5]  := 3;
  arrConsta[6]  := 2;
  arrConsta[7]  := 7;
  arrConsta[8]  := 6;
  arrConsta[9]  := 5;
  arrConsta[10] := 4;
  arrConsta[11] := 3;
  arrConsta[12] := 2;
  arrConsta[13] := 7;
  arrConsta[14] := 6;
  arrConsta[15] := 5;
  arrConsta[16] := 4;
  arrConsta[17] := 3;
  arrConsta[18] := 2;
  arrConsta[19] := 7;
  arrConsta[20] := 6;
  arrConsta[21] := 5;
  arrConsta[22] := 4;
  arrConsta[23] := 3;
  arrConsta[24] := 2;

  strOrigin := cedent + duplic + '00' + strIdeBan + digver;
  intResul1 := 0;

  For IntI := 1 To 24 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;

  If intResul1 = 10 Then
  Begin
    intResul1 := 1;
  End
  Else
  If intResul1 = 1 Then
  Begin
    If StrToInt(strDigiL1) = 9 Then
      strDigiL1 := '0'
    Else
      strDigiL1 := IntToStr(StrToInt(strDigiL1) + 1);

    strDigiL2 := inttostr(intResul1);

    While strDigiL2 = '1' Do
    Begin

      blnVerifi := True;
      strDigiL2 := fGeraSeDiLi(strCodCed, strNumDup, strDigiL1);

      If strDigiL2 = '1' Then
        strDigiL1 := IntToStr(StrToInt(strDigiL1) + 1);

      intResul1 := StrtoInt(strDigiL2);

    End;
  End;

  If Not blnVerifi Then
    If intResul1 > 1  Then
      intResul1 := 11 - intResul1;

  Result := InttoStr(intResul1);

end;

{************************************************}
{ FUNCÃO QUE GERAR O DÍGITO UM DA LINHA DIGITADA }
{*********************************************ED*}
function fGePriDig033(strBanco1, strMoeda1, strCedent: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanco1 + strMoeda1 + strCedent;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  If intResul1 < 10 Then
    Result := InttoStr(10 - intResul1)
  Else
  Begin
    intResul1 := intResul1 Mod 10;
    If intResul1 <> 0 Then intResul1 := 10 - intResul1;
    Result := InttoStr(intResul1);
  End;

end;

{**************************************************}
{ FUNCÃO QUE GERAR O DÍGITO DOIS DA LINHA DIGITADA }
{***********************************************ED*}
function fGeSegDig033(strCedent, strNumDup:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCedent + strNumDup;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  If (intResul1 < 10) and (intResul1 <> 0) Then
    Result := InttoStr(10 - intResul1)
  Else
  Begin
    intResul1 := intResul1 Mod 10;
    If intResul1 <> 0 Then intResul1 := 10 - intResul1;
    Result := InttoStr(intResul1);
  End;

end;

{**************************************************}
{* BANESPA                                        *}
{**************************************************}
{ FUNCÃO QUE GERAR O DÍGITO TRÊS DA LINHA DIGITADA }
{***********************************************ED*}
function fGeTerDig033(strNumDup, strBanco1, strDigiL1, strDigiL2:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNumDup + '00' + strBanco1 + strDigiL1 + strDigiL2;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);

end;

{**************************************************}
{* SANTANDER                                      *}
{**************************************************}
{ FUNCÃO QUE GERAR O DÍGITO TRÊS DA LINHA DIGITADA }
{***********************************************ED*}
function fGeTerDig33B(strNumDup, strIof, strModCar: String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNumDup + strIof + strModCar;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  If intResul1 < 10 Then
    Result := InttoStr(10 - intResul1)
  Else
  Begin
    intResul1 := intResul1 Mod 10;
    If intResul1 <> 0 Then intResul1 := 10 - intResul1;
    Result := InttoStr(intResul1);
  End;

end;

{***********}
{* BANESPA *}
{**********************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTOCONFERÊNCIA }
{*******************************************ED*}
function fGeDigAut033(Banco1, Moeda1, FatVen, VlrDup, NrCCor,
         NosNum, NrBanc, Digit1, Digit2: String): String;
  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;
begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + NrCCor +
            NosNum +  '00'  + NrBanc + Digit1 + Digit2;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;
  intResul1 := intResul1 Mod 11;
  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{*************}
{* SANTANDER *}
{**********************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTOCONFERÊNCIA }
{*******************************************ED*}
function fGeDigAut33B(Banco1, Moeda1, FatVen, VlrDup, NrCCor, NosNum, strIof, ModCar: String): String;
  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;
begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + NrCCor +  NosNum +  strIof + ModCar;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 * 10;
  intResul1 := intResul1 Mod 11;

  If ((intResul1 = 0) Or (intResul1 = 1) Or (intResul1 = 10)) Then
  //  intResul1 := 11 - intResul1
  //Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{************************************************}
{ FUNCÃO QUE GERAR O DÍGITO UM DA LINHA DIGITADA }
{*********************************************ED*}
function fGePriDig(strBanco1, strMoeda1, strCedent: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;

begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanco1 + strMoeda1 + strCedent;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;

{**************************************************}
{ FUNCÃO QUE GERAR O DÍGITO DOIS DA LINHA DIGITADA }
{***********************************************ED*}
function fGeSegDig(strCedent, strNumDup:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCedent + strNumDup;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;


{**************************************************}
{ FUNCÃO QUE GERAR O DÍGITO TRÊS DA LINHA DIGITADA }
{***********************************************ED*}
function fGeTerDig(strNumAge, strCodCed:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNumAge + strCodCed;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);

end;

{**********************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTOCONFERÊNCIA }
{*******************************************ED*}
function fGeDigAut(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + CodCar + NosNum + NumAge + CodCed;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;
  intResul1 := 11 - intResul1;

  If ((intResul1 = 0) Or (intResul1 = 10) Or (intResul1 = 11)) Then
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{**********************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTOCONFERÊNCIA }
{*******************************************AF*}
function fGeDigAutCon(strBarras: String): String;
  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := strBarras;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;

  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{**********************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTCON SICRED   }
{*******************************************AF*}
function fGeDigAutSicred(Banco1, Moeda1, FatVen, VlrDup, CodCar, NosNum, NumAge, CodCed: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + CodCar + NosNum + NumAge + CodCed;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;
  intResul1 := 11 - intResul1;

  If ((intResul1 = 0) Or (intResul1 = 1) Or (intResul1 > 9)) Then
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

function fMaskCNPJ(strCNPJ: String): String;
Begin

  Insert('.', strCNPJ, 3);
  Insert('.', strCNPJ, 7);
  Insert('/', strCNPJ, 11);
  Insert('-', strCNPJ, 16);

  Result := strCNPJ;

End;

function fMaskCPF(strCPF: String): String;
Begin

  Insert('.', strCPF, 4);
  Insert('.', strCPF, 8);
  Insert('-', strCPF, 12);
  Result := strCPF;

End;

function fMaskCEP(strCEP: String): String;
Begin

  Insert('-', strCEP, 6);
  Result := strCEP;

End;


function fGeDigCmL(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..24] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 9;
  arrConsta[2]  := 8;
  arrConsta[3]  := 7;
  arrConsta[4]  := 6;
  arrConsta[5]  := 5;
  arrConsta[6]  := 4;
  arrConsta[7]  := 3;
  arrConsta[8]  := 2;
  arrConsta[9]  := 9;
  arrConsta[10] := 8;
  arrConsta[11] := 7;
  arrConsta[12] := 6;
  arrConsta[13] := 5;
  arrConsta[14] := 4;
  arrConsta[15] := 3;
  arrConsta[16] := 2;
  arrConsta[17] := 9;
  arrConsta[18] := 8;
  arrConsta[19] := 7;
  arrConsta[20] := 6;
  arrConsta[21] := 5;
  arrConsta[22] := 4;
  arrConsta[23] := 3;
  arrConsta[24] := 2;


  strOrigin := strVlrFix + NosNum + NumAge + CodCed + strVlrFx1;
  intResul1 := 0;

  For IntI := 1 To 24 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;


  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{*******************************************}
{* O CALCULO DO SICRED EH DIFERENTE        *}
{****************************************AF*}
function fGeDigCmLSicred(strVlrFix, NosNum, NumAge, CodCed, strVlrFx1: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..24] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 9;
  arrConsta[2]  := 8;
  arrConsta[3]  := 7;
  arrConsta[4]  := 6;
  arrConsta[5]  := 5;
  arrConsta[6]  := 4;
  arrConsta[7]  := 3;
  arrConsta[8]  := 2;
  arrConsta[9]  := 9;
  arrConsta[10] := 8;
  arrConsta[11] := 7;
  arrConsta[12] := 6;
  arrConsta[13] := 5;
  arrConsta[14] := 4;
  arrConsta[15] := 3;
  arrConsta[16] := 2;
  arrConsta[17] := 9;
  arrConsta[18] := 8;
  arrConsta[19] := 7;
  arrConsta[20] := 6;
  arrConsta[21] := 5;
  arrConsta[22] := 4;
  arrConsta[23] := 3;
  arrConsta[24] := 2;


  strOrigin := strVlrFix + NosNum + NumAge + CodCed + strVlrFx1;
  intResul1 := 0;

  For IntI := 1 To 24 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;
  intResul1 := 11 - intResul1;

  If ((intResul1 = 10) Or (intResul1 = 11)) Then
    intResul1 := 0;

  Result := InttoStr(intResul1);

end;

function fcDigitaoCobReal(strNosNum, strNumAge, strCodCed: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..24] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;
  arrConsta[11] := 1;
  arrConsta[12] := 2;
  arrConsta[13] := 1;
  arrConsta[14] := 2;
  arrConsta[15] := 1;
  arrConsta[16] := 2;
  arrConsta[17] := 1;
  arrConsta[18] := 2;
  arrConsta[19] := 1;
  arrConsta[20] := 2;
  arrConsta[21] := 1;
  arrConsta[22] := 2;
  arrConsta[23] := 1;
  arrConsta[24] := 2;


  strOrigin := strNosNum + strNumAge + strCodCed;
  intResul1 := 0;

  For IntI := 1 To Length( strOrigin ) Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + (StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1)) + 
                                StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1)));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;


  intResul1 := intResul1 Mod 10;


  intResul1 := 10 - intResul1;


  If (intResul1 = 10) Then
    intResul1 := 0;


  Result := InttoStr(intResul1);

End;





function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
	var
		iniArquivo : TIniFile;
begin

	iniArquivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'opcoes.ini');
	Try
    Case ReadWrite of
      0: Result := iniArquivo.ReadString(NomChave,NomSecao,Conteudo);
			1: iniArquivo.WriteString(NomChave,NomSecao,Conteudo);
    End;
	Finally
		iniArquivo.Free;
  End;

end;
{
function fArqIniExe(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
	var
		iniArquivo : TIniFile;
begin

	iniArquivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'exemplos.ini');
	Try
    Case ReadWrite of
      0: Result := iniArquivo.ReadString(NomChave,NomSecao,Conteudo);
			1: iniArquivo.WriteString(NomChave,NomSecao,Conteudo);
    End;
	Finally
		iniArquivo.Free;
  End;

end;
 }

function fCalDigAsbace1(strNumero: String): String;
  Var
    arrConsta: Array [1..23] Of Integer;
    strOrigin: String;
    intI     : Integer;
    intResul1: Integer;
    intNumero: Integer;
begin
  arrConsta[1]  := 2;
  arrConsta[2]  := 1;
  arrConsta[3]  := 2;
  arrConsta[4]  := 1;
  arrConsta[5]  := 2;
  arrConsta[6]  := 1;
  arrConsta[7]  := 2;
  arrConsta[8]  := 1;
  arrConsta[9]  := 2;
  arrConsta[10] := 1;
  arrConsta[11] := 2;
  arrConsta[12] := 1;
  arrConsta[13] := 2;
  arrConsta[14] := 1;
  arrConsta[15] := 2;
  arrConsta[16] := 1;
  arrConsta[17] := 2;
  arrConsta[18] := 1;
  arrConsta[19] := 2;
  arrConsta[20] := 1;
  arrConsta[21] := 2;
  arrConsta[22] := 1;
  arrConsta[23] := 2;

  strOrigin := strNumero;
  intResul1 := 0;

  For IntI := 1 To 23 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * IntNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
    
  End;

  intResul1 := intResul1 Mod 10;

  If intResul1 <> 0 Then
    intResul1 := 10 - intResul1;

  Result := InttoStr(intResul1);
End;

function fCalDigAsbace2(strNumero: String): String;
  Var
    arrConsta : Array [1..24] Of Integer;
    strOrigin : String;
    intI      : Integer;
    intResul1 : Integer;
    intNumero : Integer;
    blnVerifi : Boolean;
begin
  blnVerifi := False;

  arrConsta[1]  := 7;
  arrConsta[2]  := 6;
  arrConsta[3]  := 5;
  arrConsta[4]  := 4;
  arrConsta[5]  := 3;
  arrConsta[6]  := 2;
  arrConsta[7]  := 7;
  arrConsta[8]  := 6;
  arrConsta[9]  := 5;
  arrConsta[10] := 4;
  arrConsta[11] := 3;
  arrConsta[12] := 2;
  arrConsta[13] := 7;
  arrConsta[14] := 6;
  arrConsta[15] := 5;
  arrConsta[16] := 4;
  arrConsta[17] := 3;
  arrConsta[18] := 2;
  arrConsta[19] := 7;
  arrConsta[20] := 6;
  arrConsta[21] := 5;
  arrConsta[22] := 4;
  arrConsta[23] := 3;
  arrConsta[24] := 2;

  strOrigin := strNumero;
  intResul1 := 0;

  For IntI := 1 To 24 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;

  If intResul1 = 10 Then
  Begin
    intResul1 := 1;
  End
  Else
  Begin

    If intResul1 = 1 Then
    Begin

      If StrToInt(strDiAsb1) = 9 Then
        strDiAsb1 := '0'
      Else
        strDiAsb1 := IntToStr(StrToInt(strDiAsb1) + 1);

      strDiAsb2 := inttostr(intResul1);

      While strDiAsb2 = '1' Do
      Begin

        blnVerifi := True;
        strDiAsb2 := fCalDigAsbace2(strCmpLiv + strDiAsb1);

        If strDiAsb2 = '1' Then
          strDiAsb1 := IntToStr(StrToInt(strDiAsb1) + 1);

        intResul1 := StrtoInt(strDiAsb2);

      End;
    End;
  End;

  If Not blnVerifi Then
    If intResul1 > 1 Then intResul1 := 11 - intResul1;

  Result := InttoStr(intResul1);

End;

{*****************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO UM DA LINHA DIGITADA DO BANCO SICREDI }
{**************************************************************ED*}
function fGePriDigSic(strBanco1, strMoeda1, strCedent: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;

begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanco1 + strMoeda1 + strCedent;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := fMultiplo10(intResul1) - intResul1;
  Result := InttoStr(intResul1);

{  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);}

end;



{*******************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO DOIS DA LINHA DIGITADA DO BANCO SICREDI }
{****************************************************************ED*}
function fGeSegDigSic(strCedent, strNumDup:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCedent + strNumDup;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := fMultiplo10(intResul1) - intResul1;
  Result := InttoStr(intResul1);

{
  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);
}

end;


{******************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO TRÊS DA LINHA DIGITADA DO BANCO SICREDI}
{***************************************************************ED*}
function fGeTerDigSic(strNumAge, strCodCed:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNumAge + strCodCed;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := fMultiplo10(intResul1) - intResul1;
  Result := InttoStr(intResul1);

{
  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);
}

end;



function fMultiplo10(intValor: Integer): Integer;
  Var
    strValor : String;
    strAux   : String;

Begin

  strValor := FormatFloat('00', intValor);

  strAux   := RightStr(strValor,1);

  If StrToInt(strAux) > 0 Then
  Begin
    strAux := FormatFloat('00', 10 - StrToInt(strAux));
    strValor := FormatFloat('00',fStrToFloat(strAux) + fStrToFloat(strValor));
  End;

  Result := StrToInt(strValor);

End;


//*****************************************************//
// FUNCAO QUE RETORNA O NUMERO DA PARCELA              //
//**************************************************ED*//
function fRetNumParcela(strNumDoc: String): String;
  Var
    arrParcel   : Array Of String;
    intContador : Integer;

Begin

  SetLength(arrParcel, 27);

  arrParcel[01] := 'A';
  arrParcel[02] := 'B';
  arrParcel[03] := 'C';
  arrParcel[04] := 'D';
  arrParcel[05] := 'E';
  arrParcel[06] := 'F';
  arrParcel[07] := 'G';
  arrParcel[08] := 'H';
  arrParcel[09] := 'I';
  arrParcel[10] := 'J';
  arrParcel[11] := 'K';
  arrParcel[12] := 'L';
  arrParcel[13] := 'M';
  arrParcel[14] := 'N';
  arrParcel[15] := 'O';
  arrParcel[16] := 'P';
  arrParcel[17] := 'Q';
  arrParcel[18] := 'R';
  arrParcel[19] := 'S';
  arrParcel[20] := 'T';
  arrParcel[21] := 'U';
  arrParcel[22] := 'V';
  arrParcel[23] := 'X';
  arrParcel[24] := 'Y';
  arrParcel[25] := 'W';
  arrParcel[26] := 'Z';

  For intContador := 1 To Length(arrParcel) - 1 Do
    If RightStr(strNumDoc, 1) = arrParcel[intContador] Then
      Break;

  Result := IntToStr(intContador);

End;

function RetornaNumeroParcela(ANumDoc:String):String;
  Var
    LParcela: String;
Begin
  LParcela := RightStr(ANumDoc, 1);

  Result := LParcela;
  If Not CharInSet(LParcela [1], ['0'..'9']) Then
    Result := fRetNumParcela(ANumDoc);
End;

function fQtdParcelas(strNumDup, strCodEmp, strEspDoc, strCodCli: String): Integer;
var
  strSQL: String;
  qryPes: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                    ';
  strSQL := strSQL + '  COUNT(*) AS QTDPARC     ';
  strSQL := strSQL + 'FROM                      ';
  strSQL := strSQL + '  CADREC                  ';
  strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP';
  strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP';
  strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI';

  qryPes := fCriaQuery();
  try
    qryPes.SQL.Text := strSQL;
    qryPes.ParamByName('NUMDUP').AsString := strNumDup;
    qryPes.ParamByName('CODEMP').AsString := strCodEmp;
    qryPes.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPes.ParamByName('CODCLI').AsString := strCodCli;
    qryPes.Open;

    Result := qryPes.FieldByName('QTDPARC').AsInteger;
  finally
    FreeAndNil(qryPes);
  end;
End;

function fValidaStrings: Boolean;
  Var
   intContador : Integer;

Begin
  Result := False;
  For intContador := 0 To Length(arrValidar) -1 Do
  Begin
    Result := fValidaTamanhoString(arrValidar[intContador].strValCam,
                                   arrValidar[intContador].strNomCam,
                                   arrValidar[intContador].strIdeBan,
                                   arrValidar[intContador].intTamCam);
    If Not( Result ) Then
      Exit;
  End;

End;






function fVerificaContido(strOrigem, strContid, strNomStr: String): Boolean;
begin

  Try
    Result := True;

    If Pos(strOrigem, strContid) = 0 Then
    Begin

      MessageDlg(strNomStr + ' ( ' + strOrigem + ' ) deve estar contido em ( ' +
                 strContid + ' )', mtInformation, [mbok], 0);

      Result := False;
    End;

  Except
    Result := False;
  End;

end;


function fValidaData(strPosicao, strVlrPos, strNomCam: String): Boolean;
  Var
    strData : String;

begin
  strData := Copy(strVlrPos, 1,02) + '/' +
             Copy(strVlrPos, 3,02) + '/' +
             Copy(strVlrPos, 5,04);

  Try
    StrToDate(strData);
    Result := True;
  Except
    MessageDlg('Ocorreu um erro ao carregar á ' + strNomCam + ' ( ' + strVlrPos +
               ' ) ' + #13 + 'Favor verificar a posição ' + strPosicao, mtInformation, [mbok], 0);

    Result := False;
  End;


end;

function fValidaTamanhoString(strDigito, strNomPar, strIdeBan: String; intTamanh: Integer): Boolean;
begin

  Result := True;

  Try

    If Length(strDigito) < intTamanh Then
    Begin

      Try
        pCriarFormularios(tfrmDesCam, frmDesCam);
        frmDesCam.strNomPar      := strNomPar;
        frmDesCam.strTamCam      := IntToStr(intTamanh);
        frmDesCam.edtVlrInf.Text := strDigito;
        frmDesCam.ShowModal;
      Finally
        FreeAndNil(frmDesCam);
      End;
      Result := False;

    End;

  Except
    Result := False;
  End;

End;

function fMontaCodBarLinDig: Boolean;
Begin
  If Pos(strIdeBan, '906_993_994_992_996_997_998_991_989_987_982_984_979_978_977_976_975_974_973_962_') > 0 then
    strIdeBan := '237';
  {*********************}
  { CODIGO DE BARRAS   *}
  {******************JB*}

  strCodBar := strIdeBan + // IDENTIFICACAO DO BANCO
               strMoeda1 + // MOEDA
               strDiAuCo + // DIGITO DE AUTO-CONFERENCIA
               strFatVen + // FATOR DE VENCIMENTO
               strVlrTit + // VALOR DO TITULO
               strCmpLiv;  // STRING CONTENDO O CAMPO LIVRE (25C)

  //*************************************************//
  // FUNCAO QUE TRANSFORMA OS NUMEROS EM CARACTERES  //
  // PARA A IMPRESSAO DO CODIGO DE BARRAS            //
  //**********************************************ED*//
  If Pos(strIdeBan, '041_356_399_237_001_104_756_748_389_085_003_422_070_089_994_995_996_099_707_246_988_208_133_364_274_084_983_990_970_981_906_978_964_') <= 0 Then
    strCodBar := fGerar_String_Codigo_Barra(strCodBar);

  strLinDig := strIdeBan               + // IDENTIFICACAO DO BANCO
               strMoeda1               + // MOEDA
               LeftStr(strCmpLiv ,5)   + // 5 PRIMEIRAS DO CAMPO LIVRE
               strDigit1               + // DIGITO DO PRIMEIRO CAMPO
               Copy(strCmpLiv, 6, 10)  + // POSICAO 6 C/ (10C) DO CAMPO LIVRE
               strDigit2               + // DIGITO DO SEGUNDO CAMPO
               Copy(strCmpLiv, 16, 10) + // POSICAO 6 C/ (10C) DO CAMPO LIVRE
               strDigit3               + // DIGITO DO TERCEIRO CAMPO
               strDiAuCo               + // DIGITO DE AUTO-CONFERENCIA
               strFatVen               + // FATOR DE VENCIMENTO
               strVlrTit;                // VALOR DO TITULO

  //*************************************************//
  // FORMATACAO - COLOCANDO OS PONTOS E BARRAS NA    //
  // LINHA DIGITAVEL                                 //
  //**********************************************ED*//
  Insert('.',strLinDig,6);
  Insert(' ',strLinDig,12);
  Insert('.',strLinDig,18);
  Insert(' ',strLinDig,25);
  Insert('.',strLinDig,31);
  Insert(' ',strLinDig,38);
  Insert(' ',strLinDig,40);

  Result := True;
End;


function fCalculaDigitos: Boolean;
Begin
  If Pos(strIdeBan, '906_993_994_992_996_997_998_991_989_987_982_984_979_978_977_976_975_974_973_962_') > 0 then
    strIdeBan := '237';
  Try
    //*************************************************//
    // CODIGO DO BANCO + MOEDA + 5 PRIMEIROS DO CAMPO  //
    // LIVRE                                           //
    //**********************************************ED*//
    strDigit1 := fGePriDig(strIdeBan,
                           strMoeda1,
                           LeftStr(strCmpLiv, 5));

    //*************************************************//
    // POSICAO DE 6 A 15 DO CAMPO LIVRE                //
    //**********************************************ED*//
    strDigit2 := fGeSegDig(Copy(strCmpLiv, 6, 10), '');


    //*************************************************//
    // POSICAO DE 16 A 25 DO CAMPO LIVRE               //
    //**********************************************ED*//
    strDigit3 := fGeTerDig( Copy(strCmpLiv, 16, 10), strDCmLiv);


    //*************************************************//
    // CALCULA DIGITO DE AUTO CONFERENCIA              //
    //**********************************************ED*//
    strDiAuCo := fGeDigAut(strIdeBan,
                           strMoeda1,
                           strFatVen,
                           strVlrTit,
                           strCmpLiv,
                           '',
                           '',
                           '');

    Result := True;

  Except
    Result := False;
  End;

End;



{function fCalcSDigitoUnibanco(strNosNum: String): String;
  Var
    strBan : String;
    intContador : Integer;
    intResSoma  : Integer;
    intResDiv   : Integer;

begin

  //*************************************************//
  // APOS O CALCULO DO DIGITO E NECESSARIO CALCULAR  //
  // O SUPER-DIGITO                                  //
  //**********************************************ED*//
  strNosNum := '1' + strNosNum;

  strBan := '43298765432';
  intResSoma := 0;

  For intContador := 1 To Length(strBan) Do
  Begin
    intResSoma := intResSoma +  ((StrToInt(strNosNum[intContador])) * (StrToInt(strBan[intContador])));
  End;

  intResSoma := intResSoma * 10;

  intResDiv := intResSoma Mod 11;

  If (intResDiv = 0) Or (intResDiv = 10) Then
    Result := '0'
  Else
    Result := LeftStr(IntToStr(intResDiv),1);

End;        }


function fRetDadosPadrao(strIdeBan, strNomPar: String): String;
Begin

  //*************************************************//
  // VALORES PADRAO DO BANCO DO BRASIL               //
  //**********************************************ED*//
  If strIdeBan = '001' Then
  Begin

    If strNomPar = 'Agência'      Then Result := '';
    If strNomPar = 'Carteira'     Then Result := '';
    If strNomPar = 'Nosso Número' Then Result := '';
    If strNomPar = 'cedente'      Then Result := '';

  End

  Else If strIdeBan = '237' Then
  Begin



  End

  Else If strIdeBan = '341' Then
  Begin



  End


{

[000] - EXEMPLO PARA BANCOS NOVOS
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[237]
Agência=(4)9999
Carteira=(2)99
Nosso Número=(12)999999999999
cedente=(8)99999999
OBSER_01=A EXPORTACAO DO NOSSO NUMERO DEVE SER FEITA COM OS 11 CARACTERES DO NOSSO NUMERO + DIGITO
OBSER_02=A EXPORTACAO DO CEDENTE DEVE SER O 7 CARACTERES + DIGITO
OBSER_03=CARTEIRA COM STRZERO(3)
OBSER_04=

[341]
Agência=(4)9999
Carteira=(3)999
Nosso Número=(9)999999999
cedente=(6)999999
OBSER_01=A EXPORTACAO DO NOSSO NUMERO DEVE SER FEITA COM OS 8 CARACTERES DO NOSSO NUMERO + DIGITO
OBSER_02=A EXPORTACAO DO CEDENTE DEVE SER O 5 CARACTERES + DIGITO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[033]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[422]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[748]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[001]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[151]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[104]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[741]
Agência=(4)9999
Carteira=(2)99
Nosso Número=(12)999999999999
cedente=(8)99999999
OBSER_01=A EXPORTACAO DO NOSSO NUMERO DEVE SER FEITA COM OS 11 CARACTERES DO NOSSO NUMERO + DIGITO   
OBSER_02=A EXPORTACAO DO CEDENTE DEVE SER O 7 CARACTERES + DIGITO
OBSER_03=CARTEIRA COM STRZERO(3)
OBSER_04=

[756]
Agência=NAO CONFIGURADO
Carteira=NAO CONFIGURADO
Nosso Número=NAO CONFIGURADO
cedente=NAO CONFIGURADO
OBSER_01=NAO CONFIGURADO
OBSER_02=NAO CONFIGURADO
OBSER_03=NAO CONFIGURADO
OBSER_04=NAO CONFIGURADO

[409]
Agência=(5)99999
Carteira=NAO USADO NA IMPRESSAO DO BOLETO
Nosso Número=(11)99999999999
cedente=NAO USADO NA IMPRESSAO DO BOLETO
OBSER_01=A EXPORTACAO DO NOSSO NUMERO DEVE SER FEITA COM OS 10 CARACTERES DO NOSSO NUMERO + DIGITO
OBSER_02=
OBSER_03=
OBSER_04=

}




End;


function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
	Var
  	intContador : Integer;
begin
	Result:= '';
  For intContador := 1 To intTamanho Do
  Begin
  	Result := Result + strRepl;
  End;
end;



{*********************************}
{* CALCULA O DIGITO NO MODULO 10 *}
{******************************AF*}
function fCalcDigitoModulo10(strString: String): String;
  Const
    strBase = '121212121212121212121212121212';

  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;

Begin

  intResult := 0;

  For intContador := 0 To Length(strString)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strString, Length(strString)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    If (intFator1 * intFator2) > 9 Then
      intResult := intResult + (intFator1 * intFator2) - 9
    Else
      intResult := intResult + (intFator1 * intFator2);

  End;

  If intResult >= 10 Then
    intResult := intResult Mod 10;
      
  If intResult = 0 Then
    Result := '0'
  Else
    Result := IntToStr( 10 - intResult );

End;

{*********************************}
{* CALCULA O DIGITO NO MODULO 11 *}
{******************************AF*}
function fCalcDigitoModulo11(strString: String; var strDigit1: String): String;
  Const
    strBase = '765432765432765432765432765432765432765432';
  Var
    intContador : Integer;
    intFator1   : Integer;
    intFator2   : Integer;
    intResult   : Integer;
    blnVerifi   : Boolean;
    strDigit2   : String;
Begin

  blnVerifi := False;

  if Trim(strDigit1) = '' then
  begin
    strDigit1 := RightStr(strString, 1);
    strString := Copy(strString, 1, Length(strString)-1);
  end;

  strString := strString + strDigit1;
  intResult := 0;

  For intContador := 0 To Length(strString)-1 Do
  Begin

    intFator1 := StrToInt( Copy(strString, Length(strString)-intContador, 1 ) );
    intFator2 := StrToInt( Copy(strBase,   Length(strBase)-intContador,   1 ) );

    intResult := intResult + (intFator1 * intFator2);

  End;


  If intResult >= 11 Then
    intResult := intResult Mod 11;

  If intResult = 1 Then
  Begin

    If StrToInt( strDigit1 ) = 9 Then
    Begin
      strDigit1_Banrisul := '0';
      strDigit1 := '0';
    End
    Else
    Begin
      strDigit1_Banrisul := IntToStr( StrToInt( strDigit1 ) + 1 );
      strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );
    End;


    strDigit2 := IntToStr( intResult );


    While strDigit2 = '1' Do
    Begin

      blnVerifi := True;

      strString := copy(strString,1,length(strString)-1);

      strDigit2 := fCalcDigitoModulo11(strString, strDigit1);

      If strDigit2 = '1' Then
        strDigit1 := IntToStr( StrToInt( strDigit1 ) + 1 );

      intResult := StrtoInt( strDigit2 );

    End;

  End
  Else If intResult = 10 Then
  Begin
    intResult := 1;
  End;

  If Not blnVerifi Then
    If intResult > 1  Then
      intResult := 11 - intResult;

  Result := IntToStr( intResult );

End;

{*******************************************}
{* RETORNA A VERSÃO ATUAL DO EXECUTÁVEL    *}
{****************************************MV*}
function fRetornaVersao(strNomArq: String = ''): String;
  Var
    BufferSize, Len: Integer;
    Buffer : PChar;
    Translate, Return: Pointer;
    LoCharSet, HiCharSet : Word;
    Dummy: Cardinal;
    StrFileInfo: String;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
  Begin
    strNomArq := Application.ExeName;
  End;

  If (Not FileExists(strNomArq)) Then
    Exit;

	BufferSize := GetFileVersionInfoSize(PWideChar(strNomArq), Dummy);

	If BufferSize <> 0 Then
  Begin
  	GetMem(Buffer, Succ(BufferSize));

  	Try
	  	If GetFileVersionInfo(PChar(strNomArq), 0, BufferSize,Buffer) Then
		  Begin
			  If VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) Then
			  Begin
				  LoCharSet := LoWord(Longint(Translate^));
				  HiCharSet := HiWord(Longint(Translate^));
          StrFileInfo := Format('\StringFileInfo\0%x0%x\%s',[LoCharSet, HiCharSet, 'ProductVersion']);
          If VerQueryValue(Buffer,PChar(StrFileInfo), Return, UINT(Len)) Then
          Begin
            Result := PChar(Return);
          End;
        End;
      End;
    Finally
		  FreeMem(Buffer, Succ(BufferSize));
	  End;

  End;
end;

{**************************************}
{*  VERIFICA SE UMA STRING ESTA VAZIA *}
{***********************************MV*}
function fEmptyStr(strString : String) : Boolean;
begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
end;

function fGetModulo11_409(strNosNum: String; strCodBar: String): String;
  Var
    intCon   : Integer;
    intValFat: Integer;
    intValSom: Integer;
    strDigEnt: String;
begin
  {**************************************************}
  {* NOSSO NUMERO = CALCULO P\ GERAR SUPER DIGITO   *}
  {* CODIGO BARRA = CALCULO P\ GERAR DIG. COD.BARRA *}
  {***********************************************JB*}
  strDigEnt := IIF(fEmptyStr(strNosNum), strCodBar, strNosNum);

  intValFat := 2;
  intValSom := 0;

  For intCon := Length(strDigEnt) DownTo 1 Do
  Begin
    intValSom := intValSom + (StrToInt(strDigEnt[intCon]) * intValFat);
    intValFat := IIF(intValFat = 9, 2, intValFat + 1);
  End;

  intValSom := (intValSom * 10) Mod 11;

  If fEmptyStr(strCodBar) Then
  Begin
    If intValSom = 10 Then
      Result := '0'
    Else
      Result := IntToStr(intValSom);
  End
  Else
  Begin
    If (intValSom = 0) Or (intValSom = 10) Then
      Result := '1'
    Else
      Result := IntToStr(intValSom);
  End;

end;

function ffrmSenha(var strSenha: string; strTitulo: String = ''): Boolean;
var
  Form: TForm;
  edt: TEdit;
begin
  Result := False;
  Form := TForm.Create(Application);
  Try
	  Form.BorderStyle := bsDialog;

    If fEmptyStr(strTitulo) Then
	    Form.Caption := 'Senha'
    Else
      Form.Caption := strTitulo;

	  Form.Position   := poScreenCenter;
	  Form.Width      := 250;
	  Form.Height     := 140;
    Form.Font.Name  := 'Arial';
    Form.Font.Size  := 13;
    Form.Color      := clBtnFace;
	  With TLabel.Create(form) do
    Begin
		  Parent     := Form;
		  Caption    := 'Digite a Senha:';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;
		edt := TEdit.Create(form);
	  With edt Do
    Begin
		  Parent       := form;
		  Left         := 10;
		  Top          := 35;
      Color        := clInfoBk;
		  Width        := form.ClientWidth - 22;
      PasswordChar :='*';
      CharCase     := ecUpperCase;
      MaxLength    := 10;
	  End;
	  With TBitBtnLocked.Create(form) Do
    Begin
	  	Parent  := form;
      Width   := 110;
		  Height  := 27;
		  Left    := form.ClientWidth - (Width * 2) - 14;
		  Top     := 70;
		  Kind    := bkOK;
      Caption := '&Confirma';
	  End;
	  With TBitBtnLocked.Create(form) Do
    Begin
		  Parent  := form;
      Width   := 110;
		  Height  := 27;
		  Left    := form.ClientWidth - Width - 12;
		  Top     := 70;
		  Kind    := bkCancel;
      Caption := 'C&ancela';
	  End;
	  If form.ShowModal = mrOK Then
    Begin
		  strSenha := edt.Text;
		  Result := true;
	  End;
  Finally
    Form.Free;
  End;

end;

function fCalculaDigitosHSBC: Boolean;
Begin
  Try
    //*************************************************//
    // CODIGO DO BANCO + MOEDA + 5 PRIMEIROS DO CAMPO  //
    // LIVRE                                           //
    //**********************************************ED*//
    strDigit1 := fGePriDig(strIdeBan,
                           strMoeda1,
                           LeftStr(strCmpLiv, 5));

    //*************************************************//
    // POSICAO DE 6 A 15 DO CAMPO LIVRE                //
    //**********************************************ED*//
    strDigit2 := fGeSegDig(Copy(strCmpLiv, 6, 10), '');


    //*************************************************//
    // POSICAO DE 16 A 25 DO CAMPO LIVRE               //
    //**********************************************ED*//
    strDigit3 := fGeTerDig( Copy(strCmpLiv, 16, 10), strDCmLiv);


    //*************************************************//
    // CALCULA DIGITO DE AUTO CONFERENCIA              //
    //**********************************************ED*//
  If strModCob <> 'S' Then
    strDiAuCo := fGeDigAut(strIdeBan,
                           strMoeda1,
                           strFatVen,
                           strVlrTit,
                           strCmpLiv,
                           LeftStr(strNosNum,10),
                           '',
                           strCodCed)
  Else
    strDiAuCo := fGeDigAut(strIdeBan,
                           strMoeda1,
                           strFatVen,
                           strVlrTit,
                           strCmpLiv,
                           '',
                           '',
                           '');

    Result := True;

  Except
    Result := False;
  End;
End;

{************************************}
{* PEGA DADOS DO BOLETO A PARTIR DO *}
{* CÓDIGO DE BARRAS                 *}
{*********************************AJ*}
procedure pAtribuiDadosBoleto(strCodBar: String; var strCodBco, strCodAge, strCodCar, strConCor, strNosNum, strFatVen: String);
begin

  strCodBco := LeftStr(strCodBar, 3);
  strFatVen := Copy(strCodBar, 6, 4);

  If (strCodBco = '237') Then
  Begin
    strCodAge := Copy(strCodBar, 20, 04);
    strCodCar := Copy(strCodBar, 24, 02);
    strNosNum := Copy(strCodBar, 26, 11);
    strConCor := Copy(strCodBar, 37, 07);
  End
  Else If (strCodBco = '422') Then
  Begin
    strCodAge := Copy(strCodBar, 21, 07);
    strCodCar := '';
    strNosNum := Copy(strCodBar, 35, 09);
    strConCor := Copy(strCodBar, 28, 07);
  End
  Else
  Begin
    strCodAge := '';
    strCodCar := '';
    strNosNum := '';
    strConCor := '';
  End;

end;

function fGePriDig004(strBanc3, strMoeda1, strAgenc4, strCeden1: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;

begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanc3 + strMoeda1 + strAgenc4 + strCeden1;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;


function fGeSegDig004(strCeden6, strDigCe1, strNosNu3:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCeden6 + strDigCe1 + strNosNu3;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result := InttoStr(intResul1);

end;


function fGeTerDig004(strNosNu4, strDvNosNu1, strCarte2:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNosNu4 + strDvNosNu1 + strCarte2;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));

    If (arrConsta[intI] * intNumero) > 9 Then
    Begin
      intResul1 := intResul1 + StrToInt(RightStr(IntToStr(arrConsta[intI] * IntNumero), 1));
      intResul1 := intResul1 + StrToInt(LeftStr(IntToStr(arrConsta[intI] * IntNumero), 1));
    End
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := intResul1 Mod 10;
  If intResul1 <> 0 Then intResul1 := 10 - intResul1;
  Result    := InttoStr(intResul1);

end;

function fGeDigAut004(strCodB43: String): String;
  Var

    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;

begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := strCodB43;
  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;

  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);

end;

{******************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO UM DA LINHA DIGITADA - BANCO SOFISA LP }
{******************************************************************}
function fGePriDig637(strBanco1, strMoeda1, strAgencia, strCarteira: String): String;
  Var
    arrConsta: Array [1..9] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1] := 2;
  arrConsta[2] := 1;
  arrConsta[3] := 2;
  arrConsta[4] := 1;
  arrConsta[5] := 2;
  arrConsta[6] := 1;
  arrConsta[7] := 2;
  arrConsta[8] := 1;
  arrConsta[9] := 2;

  strOrigin := strBanco1 + strMoeda1 + strAgencia + strCarteira;
  intResul1 := 0;

  For IntI := 1 To 9 Do
  Begin

    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := (intResul1 * 9);
  intResul1 := (intResul1 Mod 10);

  Result := InttoStr(intResul1);

end;

{********************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO DOIS DA LINHA DIGITADA - BANCO SOFISA LP }
{********************************************************************}
// strOperação -> contrato da empresa no banco;
function fGeSegDig637(strCarteira, strOperacao, strNosNumero:String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]  := 1;
  arrConsta[2]  := 2;
  arrConsta[3]  := 1;
  arrConsta[4]  := 2;
  arrConsta[5]  := 1;
  arrConsta[6]  := 2;
  arrConsta[7]  := 1;
  arrConsta[8]  := 2;
  arrConsta[9]  := 1;
  arrConsta[10] := 2;

  strOrigin := strCarteira + strOperacao + strNosNumero;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);

  End;

  intResul1 := (intResul1 * 9);
  intResul1 := (intResul1 Mod 10);

  Result := InttoStr(intResul1);

end;

{*******************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO TRES DA LINHA DIGITADA - BANCO SOFISA LP}
{*******************************************************************}
function fGeTerDig637(strNosNumero: String): String;
  Var
    arrConsta: Array [1..10] Of Integer;
    strOrigin: String;
    intI, intResul1, intNumero: Integer;
begin

  arrConsta[1]   := 1;
  arrConsta[2]   := 2;
  arrConsta[3]   := 1;
  arrConsta[4]   := 2;
  arrConsta[5]   := 1;
  arrConsta[6]   := 2;
  arrConsta[7]   := 1;
  arrConsta[8]   := 2;
  arrConsta[9]   := 1;
  arrConsta[10]  := 2;

  strOrigin := strNosNumero;
  intResul1 := 0;

  For IntI := 1 To 10 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    If (arrConsta[intI] * intNumero) > 9 Then
      intResul1 := intResul1 + ((arrConsta[intI] * IntNumero) - 9)
    Else
      intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := (intResul1 * 9);
  intResul1 := (intResul1 Mod 10);

  Result := InttoStr(intResul1);

end;

{*********************************************************************}
{ FUNCÃO QUE GERAR O DÍGITO DE AUTOCONFERÊNCIA - BANCO SOFISA LP(637) }
{*********************************************************************}
function fGeDigAut637(Banco1, Moeda1, FatVen, VlrDup, Agencia, Carteira, NumeroOper, NosNum_Com_DV: String): String;
  Var
    intNumero, intResul1, intI: Integer;
    arrConsta: Array [1..43] Of Integer;
    strOrigin: String;
begin

  arrConsta[1]  := 4;
  arrConsta[2]  := 3;
  arrConsta[3]  := 2;
  arrConsta[4]  := 9;
  arrConsta[5]  := 8;
  arrConsta[6]  := 7;
  arrConsta[7]  := 6;
  arrConsta[8]  := 5;
  arrConsta[9]  := 4;
  arrConsta[10] := 3;
  arrConsta[11] := 2;
  arrConsta[12] := 9;
  arrConsta[13] := 8;
  arrConsta[14] := 7;
  arrConsta[15] := 6;
  arrConsta[16] := 5;
  arrConsta[17] := 4;
  arrConsta[18] := 3;
  arrConsta[19] := 2;
  arrConsta[20] := 9;
  arrConsta[21] := 8;
  arrConsta[22] := 7;
  arrConsta[23] := 6;
  arrConsta[24] := 5;
  arrConsta[25] := 4;
  arrConsta[26] := 3;
  arrConsta[27] := 2;
  arrConsta[28] := 9;
  arrConsta[29] := 8;
  arrConsta[30] := 7;
  arrConsta[31] := 6;
  arrConsta[32] := 5;
  arrConsta[33] := 4;
  arrConsta[34] := 3;
  arrConsta[35] := 2;
  arrConsta[36] := 9;
  arrConsta[37] := 8;
  arrConsta[38] := 7;
  arrConsta[39] := 6;
  arrConsta[40] := 5;
  arrConsta[41] := 4;
  arrConsta[42] := 3;
  arrConsta[43] := 2;

  strOrigin := Banco1 + Moeda1 + FatVen + VlrDup + Agencia + Carteira + NumeroOper + NosNum_Com_DV;

  intResul1 := 0;

  For IntI := 1 To 43 Do
  Begin
    intNumero := StrtoInt(Copy(strOrigin, intI, 1));
    intResul1 := intResul1 + (arrConsta[intI] * IntNumero);
  End;

  intResul1 := intResul1 Mod 11;
  If ((intResul1 <> 0) And (intResul1 <> 1) And (intResul1 <> 10)) Then
    intResul1 := 11 - intResul1
  Else
    intResul1 := 1;

  Result := InttoStr(intResul1);



end;


{ TFuncoesPixBoleto }

class procedure TFuncoesPixBoleto.CarregaLibPixCitel;
  Var
    InicializaIntegracaoPixCitel: procedure(AIntegracaoPixCitel: IIntegracaoPixCitel); StdCall;

    LCaminhoDll: String;
begin
  If FHandlePixCitel <> 0 Then
    Exit;

  Try
    LCaminhoDll := ExtractFilePath(Application.ExeName) + 'libIntegracaoPixCitel.dll';

    If (Pos('\autban', LowerCase(LCaminhoDll)) > 0) Then
      LCaminhoDll := ExtractFilePath(Application.ExeName) + '..\libIntegracaoPixCitel.dll';

    If Not FileExists(LCaminhoDll) Then
      Raise Exception.Create('O arquivo ' + LCaminhoDll + ' não foi encontrado na pasta do AUTCOM. Operação cancelada!');

    FHandlePixCitel := SafeLoadLibrary(PChar(LCaminhoDll));

    If FHandlePixCitel = 0 Then
      Raise Exception.CreateFmt('Ocorreu uma falha ao carregar %s (erro %d)', ['libIntegracaoPixCitel.dll', GetLastError]);

    FPixCitel := TIntegracaoPixCitel.Create;
    InicializaIntegracaoPixCitel:= GetProcAddress(FHandlePixCitel, pChar('InicializaIntegracaoPixCitel'));
    InicializaIntegracaoPixCitel(FPixCitel);
  Except
    FHandlePixCitel := 0;
    If FPixCitel <> Nil Then
      FreeAndNil(FPixCitel);
    Raise;
  End;
end;

class function TFuncoesPixBoleto.ConversorCertificadoPfxWebServiceCitelSemTela(
  AArquivoPfx, ASenhaArquivo: String): TJsonObject;
  Var
    LRespostaRequisicao,
    LErro: String;

    ConverterCertificadoPfxCitelWebhookItauSemTela: function(AArquivoPfx, ASenhaArquivo: String): String; StdCall;
begin
  Try
    CarregaLibPixCitel;

    ConverterCertificadoPfxCitelWebhookItauSemTela  := GetProcAddress(FHandlePixCitel, 'ConverterCertificadoPfxCitelWebhookItauSemTela');
    LRespostaRequisicao := ConverterCertificadoPfxCitelWebhookItauSemTela(AArquivoPfx, ASenhaArquivo);

    LErro := ValidaErroCertificadoPfx(LRespostaRequisicao);
    If Not LErro.IsEmpty Then
      Raise Exception.Create(LErro);

    Result := TJsonObject.ParseJSONValue(LRespostaRequisicao) As TJsonObject;
  Except
    Raise;
  End;
end;

class function TFuncoesPixBoleto.EncontrarJsonRegistroBoleto(
  AAutoIncremCadRec, ACodigoBanco: String): String;
  Var
    LRegBol : TUniQuery;
    LCadRec: TUniQuery;
begin
  Result := '';

  LRegBol := nil;
  LCadRec := nil;
  Try
    LRegBol := fCriaQuery;
    LCadRec := fCriaQuery;
    Try
      LCadRec.Sql.Text := 'SELECT CTR_DTAENV,CTR_NOSNUM, CTR_DTAVEN FROM CADREC WHERE AUTOINCREM = :AUTOINCREM';
      LCadRec.ParamByName('AUTOINCREM').AsString := AAutoIncremCadRec;
      LCadRec.Open;

      if LCadRec.IsEmpty then
       Exit;

      LRegBol.Sql.Text := 'SELECT                             '+
                          '  REG_JSOENV,                      '+
                          '  REG_JSOREC                       '+
                          'FROM                               '+
                          '  REGBOL                           '+
                          'WHERE REG_CODBCO = :CODBCO         '+
                          '  AND REG_EXCEPT IS NULL           '+
                          '  AND REG_JSOREC IS NOT NULL       '+
                          '  AND REG_DTAREG = :DTAREG         '+
                          '  AND IFNULL(REG_DESCRI,"REGISTRO") = "REGISTRO" '+
                          RetornaFiltroJsonDoBanco(ACodigoBanco, LCadRec) +
                          'ORDER BY REG_DTAREG DESC,          '+
                          '  REG_HRAREG DESC                  ';

      LRegBol.ParamByName('CODBCO').AsString :=  ACodigoBanco;
      LRegBol.ParamByName('DTAREG').AsDateTime :=  LCadRec.FieldByName('CTR_DTAENV').AsDateTime;
      LRegBol.Open;

      If Not LRegBol.IsEmpty Then
        Result := LRegBol.FieldByName('REG_JSOREC').AsString;
    Except
      On E : Exception Do
      Begin
        Raise Exception.Create('Erro ao encontrar registro de boleto: ' + E.Message);
      End;
    End;
  Finally
    If Assigned(LRegBol) Then
    Begin
      LRegBol.Close;
      FreeAndNil(LRegBol);
    End;

    If Assigned(LCadRec) Then
    Begin
      LCadRec.Close;
      FreeAndNil(LCadRec);
    End;
  End;
end;

class function TFuncoesPixBoleto.ImportarDadosAutenticacao(AAutoIncremChavePix,
  AChavePix, ACodigoEmpresaConta: String): TDadosWebhook;
  Var
    LRespostaRequisicaoCertificados,
    LRespostaRequisicao: String;

    RetornaDadosAutorizacaoWebhookItau: function(ACNPJCliente, AChavePix,AAutoIncremChavePix: String): String; stdcall;
    RetornaCertificadosWebhookItau: function(): String; stdcall;
begin
  Try
    CarregaLibPixCitel;

    RetornaDadosAutorizacaoWebhookItau  := GetProcAddress(FHandlePixCitel, 'RetornaDadosAutorizacaoWebhookItau');

    LRespostaRequisicao := RetornaDadosAutorizacaoWebhookItau(untFuncoesSimples.fRetCGCEmpresa(ACodigoEmpresaConta),
                                                              AChavePix,
                                                              AAutoIncremChavePix);

    RetornaCertificadosWebhookItau := GetProcAddress(FHandlePixCitel, 'RetornaCertificadosWebhookItau');
    LRespostaRequisicaoCertificados := RetornaCertificadosWebhookItau;

    If Not MatchStr(TFuncoesPix.RetornaValorCampoJson('codigo', LRespostaRequisicaoCertificados), ['200', '201']) Then
      Raise Exception.Create('Ocorreu um erro ao retornar os certificados.' + #13 + #13 +
                             'Código do Erro: ' + TFuncoesPix.RetornaValorCampoJson('codigo', LRespostaRequisicaoCertificados));

    Result := TFuncoesPix.RetornaDadosDoRetornoWebhook(LRespostaRequisicao,
                                                       LRespostaRequisicaoCertificados);
  Except
    Raise;
  End;
end;


class function TFuncoesPixBoleto.RetornaDatasetDadosChavePix(
  AAutoIncremChavePix: String): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM CCAPIX P ' +
                          'JOIN CADCCA C ON C.AUTOINCREM=P.PIX_SEQCCA ' +
                          'WHERE P.AUTOINCREM=:AUTOIN';

    LConsulta.ParamByName('AUTOIN').AsString := AAutoIncremChavePix;
    LConsulta.Open;

    Result := fCriaClientDatSet(LConsulta);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TFuncoesPixBoleto.RetornaFiltroJsonDoBanco(
  ACodigoBanco: String; ADatasetCadrec: TDataset): String;
  Var
    LNossoNumero,
    LDataRegistro: String;
begin
  Result := EmptyStr;

  If ACodigoBanco.Equals('237') Then
  Begin
    LNossoNumero := LeftStr(ADatasetCadrec.FieldByName('CTR_NOSNUM').AsString,
                            ADatasetCadrec.FieldByName('CTR_NOSNUM').AsString.Length - 1);
    LDataRegistro := ADatasetCadrec.FieldByName('CTR_DTAENV').AsString.Replace('/', EmptyStr);

    Exit('  AND (JSON_UNQUOTE(JSON_EXTRACT(REG_JSOREC, "$.nuTituloGerado"))  = "' + LNossoNumero + '" OR '+
         '       JSON_UNQUOTE(JSON_EXTRACT(REG_JSOREC, "$.ctitloCobrCdent")) = "' + LNossoNumero + '")   '+
         '  AND (JSON_UNQUOTE(JSON_EXTRACT(REG_JSOREC, "$.dataReg10")) = "' + LDataRegistro + '" OR '+
         '       JSON_UNQUOTE(JSON_EXTRACT(REG_JSOREC, "$.dtRegistro")) = "' + LDataRegistro + '") ');
  End;
end;

class function TFuncoesPixBoleto.IncluirLinkCitelPixBoleto(ACodigoBanco,
  ATxIdPix, AQRCodePix, AValorPix, AAutoIncremChavePix: String;
  ADataVencimento: TDateTime): String;
  Var
    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;

    LExpiracao: Integer;

    LDataCriacao: TDateTime;
begin
  Result := EmptyStr;

  If AQRCodePix.IsEmpty Then
    Exit;

  Try
    CarregaLibPixCitel;
  Except
    Exit;
  End;

  LDataCriacao := fRetDtaHraServidor;
  LExpiracao := SecondsBetween(LDataCriacao, ADataVencimento);

  Try
    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    Result := LRequisicoesPix.IncluirQRCodePixBoletoBaseCitel(ACodigoBanco,
                                                              ATxIdPix,
                                                              AQRCodePix,
                                                              FormatDateTime('yyyy-MM-dd hh:mm:ss', LDataCriacao),
                                                              LExpiracao.ToString,
                                                              AValorPix);

    LRequisicoesPix := Nil;
  Except
    Raise;
  End;
end;

class function TFuncoesPixBoleto.RemoverLinkCitelPixBoleto(ACNPJEmpresa,
                                                           ACodigoEmpresa,
                                                           AIxIdPix,
                                                           AAutoIncremChavePix: String;
                                                           AGravarLogErr : Boolean): Boolean;
  Var
    LRequisicoesPix: IRequisicoesPix;

    CriaObjetoRequisicoesPix: function(AAutoIncremPix: String): IRequisicoesPix; StdCall;
begin
  Result := False;

  Try
    CarregaLibPixCitel;
  Except
    Exit;
  End;

  Try
    CriaObjetoRequisicoesPix  := GetProcAddress(FHandlePixCitel, 'CriaObjetoRequisicoesPix');
    LRequisicoesPix := CriaObjetoRequisicoesPix(AAutoIncremChavePix);

    Result := LRequisicoesPix.RemoverQRCodePixBaseCitel(ACNPJEmpresa,
                                                        ACodigoEmpresa,
                                                        AIxIdPix,
                                                        AGravarLogErr);
    LRequisicoesPix := Nil;
  Except
    Raise;
  End;
end;

class function TFuncoesPixBoleto.RetornaJsonRegistroBoleto(
  AAutoIncremCadRec, ACodigoBanco: String): String;
  Var
    LRegBol : TUniQuery;

    LSQL: String;
begin
  LRegBol := fCriaQuery(Nil);

  Try
    LSQL := 'SELECT                        '+
            '  REG_JSOREC                  '+
            'FROM                          '+
            '  REGBOL                      '+
            'WHERE REG_DUPLIC = :DUPLIC    '+
            '  AND REG_EXCEPT IS NULL      '+
            '  AND REG_JSOREC IS NOT NULL  '+
            'ORDER BY REG_DTAREG DESC,     '+
            '  REG_HRAREG DESC             ';
    Try
      LRegBol.Close;
      LRegBol.SQL.Text := LSQL;
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncremCadRec;
      LRegBol.Open;

      Result := LRegBol.FieldByName('REG_JSOREC').AsString;

      If (fEmptyStr(Result) Or (LRegBol.RecordCount > 1)) And (MatchStr(ACodigoBanco, ['237'])) Then
        Result := EncontrarJsonRegistroBoleto(AAutoIncremCadrec, ACodigoBanco);
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LRegBol);
  End;
end;

class function TFuncoesPixBoleto.ValidaErroCertificadoPfx(
  ADadosRetorno: String): String;
  Var
    LJsonObject: TJsonObject;
Begin
  Result := EmptyStr;

  LJsonObject := TJSONObject.ParseJSONValue(ADadosRetorno) As TJSONObject;

  If LJsonObject = Nil Then
    Exit;

  Try
    If LJsonObject.GetValue('nomeEmpresa') <> Nil Then
      Exit;

    Result := ADadosRetorno;
    If LJsonObject.GetValue('mensagem') <> nil Then
      Result := LJsonObject.GetValue<String>('mensagem');
  Finally
    LJsonObject.Free;
  End;
end;

Initialization
  TFuncoesPixBoleto.FHandlePixCitel := 0;
  TFuncoesPixBoleto.FPixCitel := Nil;

Finalization
  If TFuncoesPixBoleto.FPixCitel <> Nil Then
    FreeAndNil(TFuncoesPixBoleto.FPixCitel);

  TFuncoesPix.LiberaLibIntegracaoPix(TFuncoesPixBoleto.FHandlePixCitel);

End.
