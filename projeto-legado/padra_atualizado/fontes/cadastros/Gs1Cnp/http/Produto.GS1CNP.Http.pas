unit Produto.GS1CNP.Http;

interface

uses idHTTP, IdSSLOpenSSL, IdAuthentication, System.SysUtils,
  Produto.GS1CNP.Interfaces.Http, untFuncoesSimples;

type
  TProdutoGS1CNPHttp = class(TInterfacedObject, IProdutoGS1CNPHttp)
  private
    FHTTP: TidHTTP;
  public
    function GetHttp: TidHTTP;
    function SetCustomHeaders(const AAcessToken: String): IProdutoGS1CNPHttp;

    constructor Create;
    destructor Destroy; override;

    class function New(): IProdutoGS1CNPHttp;
  end;

implementation

{ TProdutoGS1CNPHttp }

constructor TProdutoGS1CNPHttp.Create;
begin
  inherited Create;
  FHTTP := TIdHTTP.Create(Nil);
  FHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(FHTTP);
  FHTTP.Request.Clear;
  FHTTP.Request.ContentType := 'application/json';
  FHTTP.Request.Accept := 'application/json;charset=UTF-8';
  FHTTP.Request.BasicAuthentication := True;
  FHTTP.Request.Authentication := TIdBasicAuthentication.Create;
  FHTTP.Request.Authentication.Username := fCfgSis('GCUSUA');
  FHTTP.Request.Authentication.Password := fCfgSis('GCSENA');
end;

destructor TProdutoGS1CNPHttp.Destroy;
begin
  FreeAndNil(FHTTP);
  inherited;
end;

function TProdutoGS1CNPHttp.GetHttp: TidHTTP;
begin
  Result := FHTTP;
end;

class function TProdutoGS1CNPHttp.New: IProdutoGS1CNPHttp;
begin
  Result := Self.Create;
end;

function TProdutoGS1CNPHttp.SetCustomHeaders(
  const AAcessToken: String): IProdutoGS1CNPHttp;
begin
  Result := Self;
  FHTTP.Request.CustomHeaders.Add('access_token:' + AAcessToken);
  FHTTP.Request.CustomHeaders.Add('client_id:' + fCfgSis('GCUSUA'));
end;

end.
