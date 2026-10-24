unit untRepositorioDadosScope;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest,
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TRepositorioDadosScope = class
  Public
    class function fGetURL: String;
    class function fGetCodigoInterno: String;
    class function fGetUsuario: String;
    class function fGetSenha: String;
  end;

implementation

{ TRepositorioDadosScope }

class function TRepositorioDadosScope.fGetURL: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_GC_URL']) ;
end;

class function TRepositorioDadosScope.fGetCodigoInterno: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_GC_COD']) ;
end;

class function TRepositorioDadosScope.fGetUsuario: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_GC_USR']) ;
end;

class function TRepositorioDadosScope.fGetSenha: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_GC_PWD']) ;
end;

end.
