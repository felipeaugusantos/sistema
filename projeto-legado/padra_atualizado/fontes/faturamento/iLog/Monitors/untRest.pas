unit untRest;

interface

function fCommunicate(strUrl: String; strGetPost: String; strJson: String; Token: String): String;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  Vcl.Graphics, REST.Types,
  Web.HTTPApp, System.Variants, // fCommunicateWSCitel
  IPPeerCommon, IPPeerClient,
  IdHTTP, IdURI,
  REST.Json,
  Soap.XSBuiltIns, //need libcurl-nss.so.4
  Soap.EncdDecd, //need libcurl-nss.so.4
  REST.Client, //need libcurl-nss.so.4
  REST.Authenticator.Basic, //need libcurl-nss.so.4
{$ENDIF LINUX}
  SysUtils,
  Classes,
  System.NetEncoding,
  untConstantes;

{$IFNDEF LINUX}
function fCommunicate(strUrl: String; strGetPost: String; strJson: String; Token: String): String;
var
  IdHTTP1: TIdHttp;
  jsResponse: TStringStream;
  PostData: TStringStream;
begin
  IdHTTP1 := TIdHttp.Create(nil);
  IdHTTP1.ConnectTimeout := 10000;
  IdHTTP1.Request.Clear;

  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.Accept := 'application/json;charset=UTF-8';

  IdHTTP1.HandleRedirects := True;
  IdHTTP1.Request.CustomHeaders.AddValue('token', Token);

  try
    jsResponse := TStringStream.Create('', TEncoding.UTF8);
    strUrl := TIdURI.URLEncode(strUrl);

    if strGetPost = 'GET' then
      IdHTTP1.Get(strUrl, jsResponse)
    else if strGetPost = 'POST' then
    begin
      PostData := TStringStream.Create(strJson, TEncoding.UTF8);
      IdHTTP1.Post(strUrl, PostData, jsResponse);
    end
    else if strGetPost = 'PUT' then
    begin
      PostData := TStringStream.Create(strJson, TEncoding.UTF8);
      IdHTTP1.Put(strUrl, PostData, jsResponse);
    end
    else if strGetPost = 'DELETE' then
    begin
      IdHTTP1.Delete(strUrl, jsResponse);
    end;

    Result := jsResponse.DataString;
  except
    on E: EIdHTTPProtocolException do
    begin
      Result := '*' + IntToStr(IdHTTP1.ResponseCode) + ' ' +
        IdHTTP1.ResponseText + ' - ' + E.ErrorMessage;
    end;
  end;
end;
{$ENDIF LINUX}

{$IFDEF LINUX}
function fCommunicate(strUrl: String; strGetPost: String;
  strJson: String; Token: String): String;
Var
  LRequest: String;
begin
  Try
    Sleep(250);
    LRequest := 'curl';
    LRequest := LRequest + ' --location ';//o cliente HTTP manipulará os redirecionamentos automaticamente
    LRequest := LRequest + ' --request ' + strGetPost;
    LRequest := LRequest + ' --connect-timeout 10'; // 10 segundos timeout
    LRequest := LRequest + ' --url ' + QuotedStr(TNetEncoding.Html
      .Encode(strUrl).Replace(' ', '%20').Replace('&amp;','&'));

    LRequest := LRequest + ' --header ' +
      QuotedStr('Accept: application/json;charset=UTF-8');

    LRequest := LRequest + ' --header ' +
      QuotedStr('Content-Type: application/json');

    LRequest := LRequest + ' --header ' +
      QuotedStr('token: ' + Token);

    If Not fEmptyStr(strJson) Then
      LRequest := LRequest + ' --data ' + QuotedStr(strJson);

    Result := ExecuteCurl(LRequest);

  Except
    On E: Exception do
    Begin
      Result := '*' + E.Message;
      pErro(Result);
    End;
  End;
end;
{$ENDIF LINUX}

end.
