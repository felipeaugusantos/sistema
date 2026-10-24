{******************************************************************************}
{*  Lib de integração que faz a comunicação via TCP com o ConectorTef.exe da  *}
{*  Multiplus.                                                                *}
{*                                                                            *}
{*  Manuais e Arquivos:  \\192.168.10.21\c_linux\autpas\_MANUAIS_\Multiplus   *}
{*                                                                            *}
{*  Desenvolvido por Renan Serrano                                            *}
{******************************************************************************}
unit untInterfacesMultiplus;

interface

uses Classes, SysUtils;

  const
    SEPARADOR_PARAMETRO : String = '¬';

  const
    OPERACAO_CREDITO_A_VISTA                   : Integer = 1;
    OPERACAO_CREDITO_PARCELADO_LOJA            : Integer = 2;
    OPERACAO_CREDITO_PARCELADO_ADM             : Integer = 3;
    OPERACAO_DEBITO                            : Integer = 4;
    OPERACAO_CANCELAMENTO_ESTORNO              : Integer = 5;
    OPERACAO_REIMPRESSAO                       : Integer = 6;
    OPERACAO_PAGAMENTO_CONTAS                  : Integer = 7;
    OPERACAO_CONSULTA_CDC                      : Integer = 8;
    OPERACAO_CONSULTA_SALDO_CREDITO            : Integer = 9;
    OPERACAO_CONSULTA_SALDO_DEBITO             : Integer = 10;
    OPERACAO_ADM_FUNCOES_ADMINISTRATIVAS       : Integer = 11;
    OPERACAO_RELATORIOS                        : Integer = 12;
    OPERACAO_RETORNAR_VALOR_CONFIG             : Integer = 96;
    OPERACAO_CONFIRMACAO_ULTIMA_VENDA_PENDENTE : Integer = 98;
    OPERACAO_DESFAZER_ULTIMA_VENDA_PENDENTE    : Integer = 99;

  const
    POS_STATUS : Integer = 1;
    POS_MENSAGEM : Integer = 2;
    STATUS_MULTIPLUS_APROVADA : Integer = 1;

  const
    POS_CUPOM : Integer = 3;
    POS_VALOR : Integer = 4;
    POS_BANDEIRA : Integer = 5;
    POS_NOME_REDE : Integer = 6;
    POS_AUTORIZACAO : Integer = 7;
    POS_NSU : Integer = 8;
    POS_TIPO_TRANSACAO : Integer = 9;
    POS_QUANTIDADE_PARCELAS : Integer = 10;
    POS_NUMERO_CONTROLE : Integer = 11;
    POS_NSU_HOST : Integer = 12;

  const
    CAPTURA_PINPAD : String = '1';
    CAPTURA_CIELO_LIO : String = '2';

Type
  ExceptionLibTefMultiplus = Class(Exception);

type
  TStatusTEF = Class(TInterfacedObject)
    strStatus: String;
    strMensagem: String;
  End;

type
  TDadosCartao = Class(TInterfacedObject)
    strCupom : String;
    strValor : String;
    strBandeira : String;
    strNomeRede : String;
    strAutorizacao : String;
    strNSU : String;
    strTipoTransacao : String;
    strQuantidadeParcelas : String;
    strNumeroControle : String;
  End;

type
  IRetornoTEF = Interface
    ['{CFFCE76A-5BB5-48E2-943B-3DA4C5628750}']
    function GetCupom(): TStringList;
    function GetDadosCartao(): TDadosCartao;
    function GetStatusTEF(): TStatusTEF;
    property Cupom: TStringList read GetCupom;
    property DadosCartao: TDadosCartao read GetDadosCartao;
    property StatusTEF: TStatusTEF read GetStatusTEF;
  End;

type
  IProcessaRetornoTEF = Interface
    ['{9D93D4AB-A73A-4B4C-ACA5-53C9F4F5DF03}']
    procedure Processar(strLinha: String);
  End;

type
  IObserverTEF = interface
    ['{7E0D2664-5243-400B-AAFE-EDC8A2AA8B3F}']
    procedure Atualizar(Resposta: IRetornoTEF);
  End;

type
  ISubjectTEF = interface
    ['{22BABCE4-84F4-4233-A3ED-EDF66CA3F1BE}']
    procedure AdicionaObserver(AObserver: IObserverTEF);
    procedure RemoveObserver(AObserver: IObserverTEF);
    procedure NotificaObservers();
  End;

type
  ITefMultiplus = interface(ISubjectTEF)
    ['{5A0F22C8-7DEF-4D2A-B940-B9721390FEAF}']
    procedure CreditoAvista(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CreditoParceladoLoja(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CreditoParceladoADM(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure Debito(AParcelas: String; ACupom: String; AValor: String; ACaptura: String='1');
    procedure CancelamentoEstorno(AParcelas: String; ACupom: String; AValor: String; AControle: String; ACaptura: String='1');
    procedure Reimpressao(AParcelas: String; ACupom: String; AValor: String; AControle: String='');
    procedure PagamentoContas(AParcelas: String; ACupom: String; AValor: String);
    procedure ConsultaCDC(AParcelas: String; ACupom: String; AValor: String);
    procedure ConsultaSaldoDebito(AParcelas: String; ACupom: String; AValor: String='');
    procedure ConsultaSaldoCredito(AParcelas: String; ACupom: String; AValor: String);
    procedure ConfirmacaoUltimaVendaPendente(AParcelas: String; ACupom: String; AValor: String; AControle: String='');
    procedure DesfazerUltimaVendaPendente(AParcelas: String; ACupom: String; AValor: String; AControle: String='');
    procedure AdmFuncoesAdministrativas(AParcelas, ACupom, AValor: String);
    procedure Relatorios(AParcelas, ACupom, AValor: String);
    procedure AdmValorConfig(ACampoConfig: String);
  End;

implementation

end.
