unit BrasilApi.WebService;

interface

type
  TBrasilApiRequestMethods = (lmGet);

type
  TBrasilApiResponse = record
    statusCode : Integer;
    content : string;
  End;

type
  TBrasilApiWS = class
  private
    const
      URLBase : String = 'https://brasilapi.com.br/api';
  public
    function Request(const AResource : String; const AMethod : TBrasilApiRequestMethods): TBrasilApiResponse;
  End;

implementation

uses System.SysUtils, System.Classes, untFuncoesSimples, System.Net.HttpClient,
  System.Net.HttpClientComponent;

{ TBrasilApiWS }

function TBrasilApiWS.Request(const AResource: String; const AMethod: TBrasilApiRequestMethods): TBrasilApiResponse;
  Var
    LClient : TNetHTTPClient;
    LHttpResponse: IHTTPResponse;
    LResponse : TStringStream;
begin
  LClient := TNetHTTPClient.Create(nil);
  LResponse := TStringStream.Create('', TEncoding.UTF8);
  try
    FillChar(Result, SizeOf(Result), #0);
    If (AMethod = lmGet) Then
      LHttpResponse := LClient.Get(URLBase + AResource, LResponse)
    Else
      Raise Exception.Create('Invalid Request Method');
    Result.statusCode := LHttpResponse.StatusCode;
    Result.content := LResponse.DataString;
  finally
    FreeAndNil(LClient);
    FreeAndNil(LResponse);
  end;
end;

end.
