unit LalaMove.WebService;

interface

type
  TLalaMoveRequestMethods = (lmGet, lmPost, lmDelete);

  TLalaMoveResponse = record
    statusCode : Integer;
    content : string;
  End;

  TLalaMoveWS = class
  private
    FURLBaseIntegracao : String;
  public
    function Request(const AResource, ABody : String; const AMethod : TLalaMoveRequestMethods; const AToken : String): TLalaMoveResponse;
    constructor Create;
  End;

implementation

uses
  System.SysUtils, System.Classes, untFuncoesSimples, System.Net.HttpClient,
  System.Net.HttpClientComponent;

{ TLalaMoveWS }

constructor TLalaMoveWS.Create;
begin
  If (fCfgSis('LAUHOM', varString) = 'S') Then
    FURLBaseIntegracao := fCfgSis('LALHOM', varString)
  Else
    FURLBaseIntegracao := fCfgSis('LALPRD', varString);
end;

function TLalaMoveWS.Request(const AResource, ABody : String; const AMethod : TLalaMoveRequestMethods; const AToken : String): TLalaMoveResponse;
  Var
    LClient : TNetHTTPClient;
    LHttpResponse: IHTTPResponse;
    LResponse : TStringStream;
    LPostData : TStringStream;
begin
  LClient := TNetHTTPClient.Create(nil);
  LResponse := TStringStream.Create('', TEncoding.UTF8);
  LPostData := Nil;
  try
    FillChar(Result, SizeOf(Result), #0);
    LClient.CustomHeaders['Authorization'] := 'hmac ' + AToken;
    LClient.CustomHeaders['Content-Type'] := 'application/json';
    LClient.CustomHeaders['Request-ID'] := TGUID.NewGuid.ToString;
    LClient.CustomHeaders['Market'] := 'BR';
    If (AMethod = lmGet) Then
      LHttpResponse := LClient.Get(FURLBaseIntegracao + AResource, LResponse)
    Else If (AMethod = lmPost) Then
    Begin
      LPostData := TStringStream.Create(ABody, TEncoding.UTF8);
      LHttpResponse := LClient.Post(FURLBaseIntegracao + AResource, LPostData, LResponse);
    End
    Else If (AMethod = lmDelete) Then
      LHttpResponse := LClient.Delete(FURLBaseIntegracao + AResource, LResponse)
    Else
      Raise Exception.Create('Invalid Request Method');
    Result.statusCode := LHttpResponse.StatusCode;
    Result.content := LResponse.DataString;
  finally
    FreeAndNil(LClient);
    FreeAndNil(LResponse);
    If Assigned(LPostData) Then
      FreeAndNil(LPostData);
  end;
end;

end.
