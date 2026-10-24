unit untConfiguracoes;

interface

uses Shared.Functions.Configuracoes, untFuncoes;

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
  Result := false;
end;


function TConfiguracoes.fGetValorConfiguracao(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
begin
  Result := untFuncoes.fGetValorConfiguracao(strCamCfg, varTipVar, strCodEmp);
end;

class function TConfiguracoes.New: IConfiguracoes;
begin
  Result := Self.Create;
end;

initialization

SetObjConfiguracoes(TConfiguracoes.New());

end.
