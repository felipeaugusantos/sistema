unit api.rest.main;

interface

uses
  ShareMem,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  REST.Types,
  api.rest.core;

function Execute(const AMetodo, AUrl,AToken : WideString;
                 out AJsonRetorno: WideString; AJsonEnvio: WideString): Integer; stdcall; export;

function ExecuteAuth(const AMetodo, AUrl, AJsonEnvio, AToken: WideString;
                     out AJsonRetorno: WideString): Integer; stdcall; export;

function Execute_(const AMetodo, AUrl,AToken : WideString;
                  out AJsonRetorno: WideString; AJsonEnvio: WideString; AKeyUser: WideString; ACooperativa: WideString; APosto: WideString; ABeneficiario: WideString): Integer; stdcall; export;

function ExecuteAuth_(const AMetodo, AUrl, AJsonEnvio, AToken: WideString;
                     out AJsonRetorno: WideString; AKeyUser: WideString; ACooperativa: WideString; APosto: WideString; ABeneficiario: WideString): Integer; stdcall; export;

implementation

function Execute(const AMetodo, AUrl, AToken : WideString;
                 out AJsonRetorno: WideString; AJsonEnvio: WideString): Integer; stdcall; export;
begin
  Result := ExecuteAuth(AMetodo, AUrl, AJsonEnvio, AToken, AJsonRetorno);
end;

function Execute_(const AMetodo, AUrl, AToken : WideString;
                 out AJsonRetorno: WideString; AJsonEnvio: WideString; AKeyUser: WideString; ACooperativa: WideString; APosto: WideString; ABeneficiario: WideString): Integer; stdcall; export;
begin
  Result := ExecuteAuth_(AMetodo, AUrl, AJsonEnvio, AToken, AJsonRetorno, AKeyUser, ACooperativa, APosto, ABeneficiario);
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

function ExecuteAuth_(const AMetodo, AUrl, AJsonEnvio, AToken: WideString;
                     out AJsonRetorno: WideString; AKeyUser, ACooperativa, APosto, ABeneficiario: WideString): Integer;
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
    LCore.KeyUser   := AKeyUser;
    LCore.Cooperativa        := ACooperativa;
    LCore.Posto              := APosto;
    LCore.CodigoBeneficiario := ABeneficiario;

    LCore.Execute_;

    AJsonRetorno := LCore.JsonRetorno;
    Result       := LCore.StatusCode;
  Finally
    FreeAndNil(LCore);
  End;
end;

end.
