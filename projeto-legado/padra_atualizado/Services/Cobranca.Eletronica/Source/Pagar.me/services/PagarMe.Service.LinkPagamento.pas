unit PagarMe.Service.LinkPagamento;

interface

uses
  PagarMe.Base.Service;

type
  TLinkPagamentoServicePagarMe = class(TBaseServicePagarMe)
  protected
    procedure pLoadConnection; override;

  public
    function fCriarLink(const ALinkPagamentoJSON: String;
      out ACodigoCobranca: String; out AUrl: String; out AUrlRequisicao: String;
      out AJsonRetorno: String): Boolean;
    function fCancelarLink(const ALinkPagamentoId: String): Boolean;
    function fCobrancaEstaCancelada(const ALinkPagamentoId: String): Boolean;
    function fCobrancaExpirada(const ALinkPagamentoId: String): Boolean;

  end;

implementation

uses
  Services.Core.Rest, System.JSON, System.Classes, System.StrUtils,
  System.SysUtils;

const
  PAYMENT_LINKS = 'payment_links';

{ TLinkPagamentoServicePagarMe }

function TLinkPagamentoServicePagarMe.fCancelarLink(
  const ALinkPagamentoId: String): Boolean;
var
  LResult : Boolean;
begin
  if (ALinkPagamentoId.IsEmpty) then
    Exit(False);

  LResult := False;

  try
    pClearRequest;
    Method   := rmPOST;
    Resource := '/' + ALinkPagamentoId + '/cancel';

    pExecutar;
    LResult := True;
  finally
    Result := LResult;
  end;
end;

function TLinkPagamentoServicePagarMe.fCobrancaEstaCancelada(
  const ALinkPagamentoId: String): Boolean;
var
  LResult : Boolean;
  LJson   : TJSONValue;
begin
  LResult := False;
  try
    pClearRequest;
    Method   := rmGET;
    Resource := '/'+ALinkPagamentoId;

    pExecutar;

    LJson := TJSONObject.ParseJSONValue(RestResponse.Content);

    try
      LResult := LJson.GetValue<String>('status') <> 'active';;
    except
    end
  finally
    Result := LResult;
  end;
end;

function TLinkPagamentoServicePagarMe.fCobrancaExpirada(
  const ALinkPagamentoId: String): Boolean;
var
  LResult : Boolean;
  LJson   : TJSONValue;
begin
  LResult := False;
  try
    pClearRequest;
    Method   := rmGET;
    Resource := '/'+ALinkPagamentoId;

    pExecutar;

    LJson := TJSONObject.ParseJSONValue(RestResponse.Content);
    try
      LResult := (LJson.GetValue<TDateTime>('expires_at') < Now);
    except
    end
  finally
    Result := LResult;
  end;
end;

function TLinkPagamentoServicePagarMe.fCriarLink(
  const ALinkPagamentoJSON: String; out ACodigoCobranca: String;
  out AUrl: String; out AUrlRequisicao: String;
  out AJsonRetorno: String): Boolean;
var
  LResult : Boolean;
  LJson   : TJSONValue;
begin
  LResult := False;
  try
    pClearRequest;

    Method := rmPOST;
    Body   := ALinkPagamentoJSON;

    pExecutar;

    LJson          := TJSONObject.ParseJSONValue(RestResponse.Content);
    AJsonRetorno   := Response.Content;
    AUrlRequisicao := FullURLRequest;

    try
      ACodigoCobranca := LJson.GetValue<String>('id');
      AUrl            := LJson.GetValue<String>('url');
    except
    end;

    LResult := True;
  finally
    Result := LResult;
  end;
end;

procedure TLinkPagamentoServicePagarMe.pLoadConnection;
begin
  inherited;
  BaseResource := PAYMENT_LINKS;
end;

end.
