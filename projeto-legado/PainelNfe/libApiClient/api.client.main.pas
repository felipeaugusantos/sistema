unit api.client.main;

interface

uses
  ShareMem,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  api.client.core,
  api.client.json,
  IdSSLOpenSSLHeaders;

function Execute(const AMetodo, AUrl, AJsonEnvio: WideString;
                 out AJsonRetorno: WideString): Integer; stdcall; export;

function ExecuteAuth(const AMetodo, AUrl, AJsonEnvio, AToken, AContentType: WideString;
                     const ABytes: TBytes; out AJsonRetorno: WideString): Integer; stdcall; export;

function ExecuteAuth2(const AMetodo, AUrl, AJsonEnvio, AToken, AContentType, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath: WideString;
                      const AProxyServer, AProxyPort, AProxyUsername, AProxyPassword: WideString;
                      const ABytes: TBytes; out AJsonRetorno: WideString): Integer; stdcall; export;

function GetJsonValue(const AJsonString, AChave: WideString): WideString; stdcall; export;

function GetJsonArrayCount(const AJsonString, AChaveArr: WideString): Integer; stdcall; export;

function GetJsonArrayValue(const AJsonString, AChaveArr, AChave: WideString;
                           const AIndex: Integer): WideString; stdcall; export;

function GetToken(const ACnpjEmitente: WideString;
                  const AChavePublica: TStringList;
                  const AUnixTimestamp: Int64): WideString; stdcall; export;

function GetTokenPrefix(const APrefixoCliente: String;
                        const AChavePublica: TStringList;
                        const AUnixTimestamp: Int64;
                        const APathLibREST: String): WideString; stdcall; export;

implementation

function Execute(const AMetodo, AUrl, AJsonEnvio: WideString;
                 out AJsonRetorno: WideString): Integer;
begin
  Result := ExecuteAuth2(AMetodo, AUrl, AJsonEnvio, '', 'application/json', '', '', '', '', '', '', '', '', nil, AJsonRetorno);
end;

function ExecuteAuth(const AMetodo, AUrl, AJsonEnvio, AToken, AContentType: WideString;
                     const ABytes: TBytes; out AJsonRetorno: WideString): Integer;
begin
  Result := ExecuteAuth2(AMetodo, AUrl, AJsonEnvio, AToken, AContentType, '', '', '', '', '', '', '', '', ABytes, AJsonRetorno);
end;

function ExecuteAuth2(const AMetodo, AUrl, AJsonEnvio, AToken, AContentType, AFormDataField, AFormDataFieldValue, AFormDataFile, AFormDataFilePath: WideString;
                      const AProxyServer, AProxyPort, AProxyUsername, AProxyPassword: WideString;
                      const ABytes: TBytes; out AJsonRetorno: WideString): Integer; stdcall; export;
  Var
    LCore: TApiClientCore;
begin
  If AnsiIndexText(AMetodo, ['GET','DELETE','POST']) = -1 Then
  Begin
    AJsonRetorno := Format('{"mensagem": "Método %s não suportado!"}', [AMetodo]);
    Exit(400);
  End;

  LCore := TApiClientCore.Create;
  Try
    LCore.Metodo             := AMetodo;
    LCore.Url                := AUrl;
    LCore.Token              := AToken;
    LCore.JsonEnvio          := AJsonEnvio;
    LCore.ContentType        := AContentType;
    LCore.FormDataField      := AFormDataField;
    LCore.FormDataFieldValue := AFormDataFieldValue;
    LCore.FormDataFile       := AFormDataFile;
    LCore.FormDataFilePath   := AFormDataFilePath;
    LCore.ProxyServer        := AProxyServer;
    LCore.ProxyPort          := StrToIntDef(AProxyPort, 0);
    LCore.ProxyUsername      := AProxyUsername;
    LCore.ProxyPassword      := AProxyPassword;
    LCore.Bytes              := ABytes;

    LCore.Execute;

    AJsonRetorno := LCore.JsonRetorno;
    Result       := LCore.StatusCode;
  Finally
    FreeAndNil(LCore);
  End;
end;

function GetJsonValue(const AJsonString, AChave: WideString): WideString;
  Var
    LJson: TApiClientJson;
begin
  LJson := TApiClientJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonValue(AChave);
  Finally
    FreeAndNil(LJson);
  End;
end;

function GetJsonArrayValue(const AJsonString, AChaveArr, AChave: WideString;
  const AIndex: Integer): WideString;
  Var
    LJson: TApiClientJson;
begin
  LJson := TApiClientJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonArrayValue(AChaveArr, AChave, AIndex);
  Finally
    FreeAndNil(LJson);
  End;
end;

function GetJsonArrayCount(const AJsonString, AChaveArr: WideString): Integer;
  Var
    LJson: TApiClientJson;
begin
  LJson := TApiClientJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonArrayCount(AChaveArr);
  Finally
    FreeAndNil(LJson);
  End;
end;

function GetToken(const ACnpjEmitente: WideString;
                  const AChavePublica: TStringList;
                  const AUnixTimestamp: Int64): WideString;
var
  LToken: TToken;
begin
  LToken := TToken.Create;
  LToken.CnpjEmitente  := ACnpjEmitente;
  LToken.ChavePublica  := AChavePublica;
  LToken.UnixTimestamp := AUnixTimestamp;

  Try
    Result := LToken.Execute;
  Finally
    FreeAndNil(LToken);
  End;

end;

function GetTokenPrefix(const APrefixoCliente: String;
                        const AChavePublica: TStringList;
                        const AUnixTimestamp: Int64;
                        const APathLibREST: String): WideString; stdcall;
var
  LToken: TToken;
begin
  Result := '';

  LToken := nil;

  IdOpenSSLSetLibPath(APathLibREST);

  Try
    LToken := TToken.Create;
    LToken.PrefixoCliente := APrefixoCliente;
    LToken.ChavePublica   := AChavePublica;
    LToken.UnixTimestamp  := AUnixTimestamp;

    Result := LToken.ExecutePrefix;

  Except
    on E: Exception do
      Result := '';
  End;

  FreeAndNil(LToken);
end;

end.
