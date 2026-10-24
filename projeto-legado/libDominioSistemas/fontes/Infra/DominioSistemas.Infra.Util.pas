unit DominioSistemas.Infra.Util;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  REST.Client, Uni,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess;

type
  TControllerRestDominioSistemasToken = class
  public
    class function fConfigurar(RestClient: TRestClient;
                               OAuth2Authenticator: TOAuth2Authenticator;
                               RestResponse: TRestResponse): Boolean;
  end;

  TControllerRestDominioSistemas = class
  public
    class function fConfigurar(RestClient: TRestClient;
                               OAuth2Authenticator: TOAuth2Authenticator;
                               RestResponse: TRestResponse): Boolean;
  end;

  function fRemoverAcentuacao(const Texto: string): string;

implementation

uses
  DominioSistemas.Infra.Repository ;

function fRemoverAcentuacao(const Texto: string): string;
const
  Acentos = 'áãàäâéêèëíïîìóôõòöúüûùçÁÀÂÃÉÊÍÓÔÕÙÚÜÇ';
  SemAcentos = 'aaaaeaeeeiioooouuuçAAAEEIOOOUUUÇ';
var
  i, Posicao: Integer;
  TextoSemAcento: string;
begin
  TextoSemAcento := Texto;

  for i := 1 to Length(Texto) do
  begin
    Posicao := Pos(Texto[i], Acentos);
    if Posicao > 0 then
      TextoSemAcento[i] := SemAcentos[Posicao];
  end;

  Result := TextoSemAcento;
end;


{ TControllerRestDominioSistemasToken }

class function TControllerRestDominioSistemasToken.fConfigurar(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.BaseURL       := TMySQLRepository.fGetUrlToken;

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/x-www-form-urlencoded';
    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

{ TControllerRestDominioSistemas }

class function TControllerRestDominioSistemas.fConfigurar(
  RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator;
  RestResponse: TRestResponse): Boolean;
begin
  Result := True;

  try
    RestClient.BaseURL       := TMySQLRepository.fGetUrlApi;

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;
end;

end.
