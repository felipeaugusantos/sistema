unit api.rest.main;

interface

uses
  ShareMem,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  REST.Types,
  api.rest.core,
  api.rest.json;

function Execute(const AMetodo, AUrl, AJsonEnvio: WideString;
                 out AJsonRetorno: WideString): Integer; stdcall; export;

function ExecuteAuth(const AMetodo, AUrl, AJsonEnvio, AToken: WideString;
                     out AJsonRetorno: WideString): Integer; stdcall; export;

function ExecuteSoap(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall; export;

function ExecuteSoapWithMode(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall; export;

function GetJsonValue(const AJsonString, AChave: WideString): WideString; stdcall; export;

function GetJsonArrayCount(const AJsonString, AChaveArr: WideString): Integer; stdcall; export;

function GetJsonArrayValue(const AJsonString, AChaveArr, AChave: WideString;
                           const AIndex: Integer): WideString; stdcall; export;

implementation

function Execute(const AMetodo, AUrl, AJsonEnvio: WideString;
                 out AJsonRetorno: WideString): Integer;
begin
  Result := ExecuteAuth(AMetodo, AUrl, AJsonEnvio, '', AJsonRetorno);
end;

function ExecuteAuth(const AMetodo, AUrl, AJsonEnvio, AToken: WideString;
                     out AJsonRetorno: WideString): Integer;
  Var
    LMetodo: TRESTRequestMethod;
    LCore: TApiRestCore;
begin
  Case AnsiIndexText(AMetodo, ['GET','POST','PUT','DELETE','PATCH']) Of
    0: LMetodo := rmGET;
    1: LMetodo := rmPOST;
    2: LMetodo := rmPUT;
    3: LMetodo := rmDELETE;
    4: LMetodo := rmPATCH;
  Else
    AJsonRetorno := Format('{"mensagem": "Método %s não suportado!"}', [AMetodo]);
    Exit(400);
  End;

  LCore := TApiRestCore.Create;
  Try
    LCore.Metodo    := LMetodo;
    LCore.Url       := AUrl;
    LCore.Token     := AToken;
    LCore.JsonEnvio := AJsonEnvio;

    LCore.Execute;

    AJsonRetorno := LCore.JsonRetorno;
    Result       := LCore.StatusCode;
  Finally
    FreeAndNil(LCore);
  End;
end;

function ExecuteSoap(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall; export;
  Var
    LCore: TApiRestCore;
begin
  LCore := TApiRestCore.Create(modeOpen, ordHTTPSecureProtocol);
  Try
    Try
      LCore.Url := AUrl;

      //FIX REQ: 26522...
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;quot;', '&quot;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;apos;', '&apos;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;lt;'  , '&lt;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;gt;'  , '&gt;');
      //...FIX REQ: 26522

      LCore.JsonEnvio := AEnvelopeEnvio;

      LCore.Execute;

      AEnvelopeRetorno := LCore.JsonRetorno;
      Result           := LCore.StatusCode;
    Except
      On E: Exception Do
      Begin
        Result := 0;
        AException := E.Message;
      End;
    End;
  Finally
    FreeAndNil(LCore);
  End;
end;

function ExecuteSoapWithMode(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall; export;
  Var
    LCore: TApiRestCore;
begin
  {$IF Defined(VER330)}
  LCore := TApiRestCore.Create(AmodeEnvSoap, ordHTTPSecureProtocol);
  {$ELSE}
  LCore := TApiRestCore.Create(modeOpen, ordHTTPSecureProtocol);
  {$IFEND};

  Try
    Try
      LCore.Url := AUrl;

      //FIX REQ: 26522...
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;quot;', '&quot;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;apos;', '&apos;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;lt;'  , '&lt;');
      AEnvelopeEnvio := AnsiReplaceStr(AEnvelopeEnvio, '&amp;gt;'  , '&gt;');
      //...FIX REQ: 26522

      LCore.JsonEnvio := AEnvelopeEnvio;

      LCore.Execute;

      AEnvelopeRetorno := LCore.JsonRetorno;
      Result           := LCore.StatusCode;
    Except
      On E: Exception Do
      Begin
        Result := 0;
        AException := E.Message;
      End;
    End;
  Finally
    FreeAndNil(LCore);
  End;
end;

function GetJsonValue(const AJsonString, AChave: WideString): WideString;
  Var
    LJson: TApiRestJson;
begin
  LJson := TApiRestJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonValue(AChave);
  Finally
    FreeAndNil(LJson);
  End;
end;

function GetJsonArrayValue(const AJsonString, AChaveArr, AChave: WideString;
  const AIndex: Integer): WideString;
  Var
    LJson: TApiRestJson;
begin
  LJson := TApiRestJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonArrayValue(AChaveArr, AChave, AIndex);
  Finally
    FreeAndNil(LJson);
  End;
end;

function GetJsonArrayCount(const AJsonString, AChaveArr: WideString): Integer;
  Var
    LJson: TApiRestJson;
begin
  LJson := TApiRestJson.Create(AJsonString);
  Try
    Result := LJson.GetJsonArrayCount(AChaveArr);
  Finally
    FreeAndNil(LJson);
  End;
end;

end.
