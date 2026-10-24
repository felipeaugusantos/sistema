unit untConfiguracoes;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  untFuncoesSimples,
{$ENDIF LINUX}
  Shared.Functions.Configuracoes;

type
  TConfiguracoes = class(TInterfacedObject, IConfiguracoes)
  public
    class function New: IConfiguracoes;
    function fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;

    function fAtualizaValorConfiguracao(strCamCfg: String; strValCfg: String): Boolean;
  end;

implementation

{ TConfiguracoes }

function TConfiguracoes.fAtualizaValorConfiguracao(strCamCfg,
  strValCfg: String): Boolean;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fAtuCfgSis(strCamCfg, strValCfg);
{$ELSE}
  Result := untFuncoesSimples.fAtuCfgSis(strCamCfg, strValCfg);
{$ENDIF}
end;

function TConfiguracoes.fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
begin
{$IFDEF LINUX}
  Result := Services.Core.Settings.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ELSE}
  Result := untFuncoesSimples.fCfgSis(strCamCfg, varTipVar, strCodEmp);
{$ENDIF}
end;

class function TConfiguracoes.New: IConfiguracoes;
begin
  Result := Self.Create;
end;

initialization

SetObjConfiguracoes(TConfiguracoes.New());

end.
