unit PagarMe.Lib.Connection;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess;

type
  TConnectionPagarMe = class
  public
    class function fConfigurar(RestClient: TRestClient;
      OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse
      {$IFNDEF LINUX};conexao: TUniConnection = nil{$ENDIF}): Boolean;
  end;

implementation

{ TConnectionPagarMe }

class function TConnectionPagarMe.fConfigurar(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse
  {$IFNDEF LINUX};conexao: TUniConnection = nil{$ENDIF}): Boolean;
var
  LAmbiente   : Integer;
  LBaseURL    : String;
  LCampoToken : String;
begin
  RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
  RestResponse.ContentType := 'application/json';

  LAmbiente := StrToInt(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_PMEAMB']));
  if LAmbiente = 0 then
  begin
    LBaseURL    := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_PMEUSB']);
    LCampoToken := 'CFG_PMECRP';
  end
  else
  begin
    LBaseURL := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_PMEUPD']);
    LCampoToken := 'CFG_PMEAPK';
  end;;

  OAuth2Authenticator := TOAuth2Authenticator.Create(RestClient);
  OAuth2Authenticator.TokenType    := ttBASIC;

  OAuth2Authenticator.ClientID     := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, LCampoToken]);
  OAuth2Authenticator.ClientSecret := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_PMEPWD']);

  RestClient.BaseURL       := LBaseURL;
  RestClient.ContentType   := 'application/json';
  RestClient.Authenticator := OAuth2Authenticator;
  Result := True;
end;

end.
