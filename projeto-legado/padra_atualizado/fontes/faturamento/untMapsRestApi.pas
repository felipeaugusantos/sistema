unit untMapsRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TControllerMaps = class
  public
    class function fConfigurarMaps(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
  end;

implementation

{ TControllerMaps }

class function TControllerMaps.fConfigurarMaps(RestClient: TRestClient;
  OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;
var
  strAutInc: String;
  intQtdConsumoAutcom: Integer;
  intQtdConsumoRobo: Integer;
begin
  Result := True;

  try
    intQtdConsumoAutcom := fRetQtdElementosKey(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP']),
                           monthOf(fNow),
                           YearOf(fNow),
                           strAutInc,
                           False);


    intQtdConsumoRobo := fRetQtdElementosKey(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP']),
                         monthOf(fNow),
                         YearOf(fNow),
                         strAutInc,
                         True);

    if (intQtdConsumoAutcom + intQtdConsumoRobo) > fCfgSis('QTDELE', varInteger) then
      RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLMDS'])
    else
      RestClient.BaseURL       := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLMDP']);

    RestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    RestClient.AcceptCharset := 'UTF-8, *;q=0.8';
    RestClient.ContentType   := 'application/json';

    RestResponse.ContentType := 'application/json';
  except
    Result := False;
  end;

end;

end.
