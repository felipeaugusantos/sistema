unit untInterfaceLinkPagamentoCitel;

interface

uses
   untClassesComumLinkPagamentoCitel, System.JSON, System.SysUtils, System.Classes;

type
  TLinkPagamentoCitel = (pcSitef, pcCielo, pcVindi, pcCredPay, pcRede, pcIpag);
  TArrayLinkPagamentoCitelFornecedor = Array[TLinkPagamentoCitel] of String ;
  TArrayLinkPagamentoCitelDescricaoFornecedor = Array[TLinkPagamentoCitel] of String ;
  TArrayLinkPagamentoCitelCfg = Array[TLinkPagamentoCitel] of String ;

  ExceptionLinkPg = class(Exception);
  ExceptionLinkPgTokenInvalido = class(ExceptionLinkPg);
  ExceptionLinkPgUrlInvalida = class(ExceptionLinkPg);
  ExceptionLinkPgTransacaoNaoEncontrada = class(ExceptionLinkPg);
  ExceptionLinkPgPagamentoNaoEncontrado = class(ExceptionLinkPg);
  ExceptionLinkPgJaCancelado = class(ExceptionLinkPg);
  ExceptionLinkPgCredencial = class(ExceptionLinkPg);
  ExceptionLinkPgCredencialNaoAutorizada = class(ExceptionLinkPgCredencial);
  ExceptionLinkPgCredencialInvalida = class(ExceptionLinkPgCredencial);
  ExceptionLinkPgParametrosInvalidos = class(ExceptionLinkPg);
  ExceptionLinkPgPersistencia = class(ExceptionLinkPg);

  TInfoDocumentoLinkPagamentoCitel = record
    Tipo: String ;
    Documentos: String ;
  end ;

  TInfoLinkPagamentoExec = record
    TabelaSitDocExist: Boolean ;
  end ;

  ILinkPagamentoCitelBandeiras = interface
   ['{55BB35CC-F62F-4754-BCC4-13759259E56F}']
   procedure pPreencheCombo(const AComboItens: TStrings) ;
  end ;

  ILinkPagamentoCitelNormalizaTipo = interface
    ['{451ED18F-F295-4802-A447-F6F1A60C7401}']
    function fTipo(const AstrTipo: String): String ;
    function fTipoAbreviado(const AstrTipo: String): String ;
  end;

  ILinkPagamentoCitelFornecedor = interface
    ['{BAB13F9A-00F1-459B-B2A0-EC93CEEB16B5}']
    function fGetTipRec: String ;
  end ;

  ILinkPagamentoCitelRepositorio = interface
    ['{2CA8BD52-569C-4CFD-AE30-7C5CC33D8A87}']
    function fGetMerchantId : String;
    function fGetMerchantKey : String;
    function fGetURL : String;
    function fGetChavePrivada : String ;
    function fGetChavePublica : String ;
    function fGetComprovanteCancLoja(const AstrNsu, AstrId_link: String): String ;
    function fGetComprovanteCancCliente(const AstrNsu, AstrId_link: String): String ;
    function fCondicaoPagamentoComLinkPagamento(const AstrCodCnd: String): Boolean ;
  end ;

  ILinkPagamentoCitel = interface
    ['{91DE16F9-88EA-46E3-9349-692F16CA72B9}']
    function fGerarLinkPagamento(const AstrOperacao : String;
                                 const AintQtdParcelas : Integer;
                                 const AtpParcLoja : String;
                                 const AfltValPed : Double;
                                 var   AstrRetornoMsgErro: string;
                                 const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                 const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta ;

    function fConsultarTransacao(const AstrId_link: String;
                                 const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta ;

    function fExpirarLinkPagamento(const AstrId_link: String): Boolean ;

    function fCriarCancelamento(const AstrNsu, AstrId_link: String;
                                var   AstrJSONRet : String;
                                var   AstrJSONReq : String): TJSONObject ;
    function fEfetuarCancelamento(const AstrId_linkCanc,
                                        AstrNumeroCartao,
                                        AstrVencCartao: String;
                                  var AstrJSONRet: String;
                                  var AstrJSONReq : String): TJSONObject ;

    function NumDoc: String ; overload ;
    function NumDoc(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function EspDoc: String ; overload ;
    function EspDoc(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodCli: String ; overload ;
    function CodCli(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodOpe: String ; overload ;
    function CodOpe(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function SeqFgo: String ; overload ;
    function SeqFgo(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function JSONRequest: String ; overload ;
    function JSONRequest(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function JSONResponse: String ; overload ;
    function JSONResponse(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function RequestResource: String ;
    function NomeFornecedorServico: String ;
  end ;

const
  LinkPagamentoCitelFornecedores : TArrayLinkPagamentoCitelFornecedor = ('ESIT', 'LPCIELO', 'LPVINDI', 'LPCPAY', 'LPREDE', 'LPIPAG') ;
  LinkPagamentoCitelDescricaoFornecedores : TArrayLinkPagamentoCitelDescricaoFornecedor = ('esitef', 'cielo', 'vindi', 'credpay', 'rede', 'ipag') ;
  LinkLinkPagamentoCitelCfg: TArrayLinkPagamentoCitelCfg = ('2', '3', '4', '5', '6', '7') ;
  LinkPagamentoMovcarHistoricoComplementar: array[1..5] of string = ('3', '4', '5', '6', '7') ;
  CODIGO_CANCELAMENTO_TRANSACAO_VINDI_SUCESSO    = 0 ;
  CODIGO_CANCELAMENTO_TRANSACAO_VINDI_AGUARDANDO = 4 ;
implementation

end.
