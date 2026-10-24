unit PagarMe.Service.Recebivel;

interface

uses
  PagarMe.Base.Service, Generics.Collections, PagarMe.Classe.Transacao;

type
  TRecebivelServicePagarMe = class(TBaseServicePagarMe)
  private
    function fRetonaTransacaoByOrder(const AOrderId: String;
      out ATransacao: TTransacaoPagarMe): Boolean;

  public
    function fCobrancaSemFormaDePagamento(const ALinkPagamentoId: String;
      out ATransacao: TTransacaoPagarMe): Boolean;

    function fRetornaTransacao(const ATransacaoId: String;
      out ATransacao: TTransacaoPagarMe): Boolean;

  end;

implementation

uses
  Services.Core.Rest, System.JSON, System.SysUtils;

const
  ORDERS             = 'orders';
  TRANSACTIONS       = 'transactions';
  QP_PAYMENT_LINK_ID = 'payment_link_id';
  QP_ORDER_ID        = 'order_id';


{ TRecebivelServicePagarMe }

function TRecebivelServicePagarMe.fCobrancaSemFormaDePagamento(
  const ALinkPagamentoId: String; out ATransacao: TTransacaoPagarMe): Boolean;
var
  LResult  : Boolean;
  LJson    : TJSONArray;
  LIdOrder : String;
begin
  LResult := False;
  try
    pClearRequest;
    Method   := rmGET;
    Resource := ORDERS;
    pAddQueryParams(QP_PAYMENT_LINK_ID,ALinkPagamentoId);

    pExecutar;

    LJson := TJSONArray(TJSONObject.ParseJSONValue(RestResponse.Content));

    if LJson.Count = 0 then
      Exit;

    try
      LIdOrder := LJson.Items[0].GetValue<String>('id');
      LResult  := fRetonaTransacaoByOrder(LIdOrder, ATransacao);
    except
    end;
  finally
    Result := LResult;
  end;
end;

function TRecebivelServicePagarMe.fRetornaTransacao(
  const ATransacaoId: String; out ATransacao: TTransacaoPagarMe): Boolean;
var
  LResult : Boolean;
begin
  LResult := False;
  try
    pClearRequest;
    Method   := rmGET;
    Resource := TRANSACTIONS+'/'+ATransacaoId;

    pExecutar;

    ATransacao := nil;
    if RestResponse.StatusCode <> 200 then
      Exit;

    ATransacao := TTransacaoPagarMe.Create;
    ATransacao.AsJson := Response.Content;

    LResult := True;
  finally
    Result := LResult;
  end;
end;

function TRecebivelServicePagarMe.fRetonaTransacaoByOrder(const AOrderId: String;
  out ATransacao: TTransacaoPagarMe): Boolean;
var
  LResult : Boolean;
  LJson   : TJSONArray;
begin
  LResult := False;
  try
    pClearRequest;
    Method   := rmGET;
    Resource := TRANSACTIONS;
    pAddQueryParams(QP_ORDER_ID,AOrderId);

    pExecutar;

    LJson := TJSONArray(TJSONObject.ParseJSONValue(RestResponse.Content));

    if LJson.Count = 0 then
      Exit;

    try
      ATransacao := TTransacaoPagarMe.Create;
      ATransacao.AsJson := LJson.Items[0].ToJSON;

      LResult := True;
    except
    end;
  finally
    Result := LResult;
  end;
end;

end.
