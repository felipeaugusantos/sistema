unit untLinkPagamentoCitelRepositorio;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TLinkPagamentoCitelRepositorio = class
  Public
    class function fGetMerchantId : String;
    class function fGetMerchantKey : String;
    class function fGetURL : String;
    class function fGetChavePrivada : String ;
    class function fGetChavePublica : String ;
    class function fGetComprovanteCancLoja(const AstrNsu, AstrId_link: String): String ;
    class function fGetComprovanteCancCliente(const AstrNsu, AstrId_link: String): String ;
    class function fCondicaoPagamentoComLinkPagamento(const AstrCodCnd: String): Boolean ;
  end ;

implementation

uses untFactoryLinkPagamentoCitel ;

{ TLinkPagamentoCitelRepositorio }

class function TLinkPagamentoCitelRepositorio.fCondicaoPagamentoComLinkPagamento(
  const AstrCodCnd: String): Boolean;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fCondicaoPagamentoComLinkPagamento(AstrCodCnd) ;
end;

class function TLinkPagamentoCitelRepositorio.fGetChavePrivada: String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetChavePrivada ;
end;

class function TLinkPagamentoCitelRepositorio.fGetChavePublica: String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetChavePublica ;
end;

class function TLinkPagamentoCitelRepositorio.fGetComprovanteCancCliente(
  const AstrNsu, AstrId_link: String): String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetComprovanteCancCliente(AstrNsu, AstrId_link) ;
end;

class function TLinkPagamentoCitelRepositorio.fGetComprovanteCancLoja(
  const AstrNsu, AstrId_link: String): String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetComprovanteCancLoja(AstrNsu, AstrId_link) ;
end;

class function TLinkPagamentoCitelRepositorio.fGetMerchantId: String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetMerchantId ;
end;

class function TLinkPagamentoCitelRepositorio.fGetMerchantKey: String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetMerchantKey ;
end;

class function TLinkPagamentoCitelRepositorio.fGetURL: String;
begin
  Result := fCriarLinkPagamentoCitelRepositorio.fGetURL ;
end;

end.
