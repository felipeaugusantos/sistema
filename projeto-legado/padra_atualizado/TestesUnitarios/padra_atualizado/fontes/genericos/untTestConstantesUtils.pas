unit untTestConstantesUtils;

interface

uses Shared.Functions.Constantes, untTypesSistema, untConstantesNFe;

type
  TTestConstantesUtils = class(TInterfacedObject, IConstantesUtils)
  public
    function fGetCstSubstituicao: String;
    function fGetCstAntecipacaoIcms: String;
    function fGetCstTributado: String;

    class function New(): IConstantesUtils;
  end;

implementation

{ TConstantesUtils }

function TTestConstantesUtils.fGetCstAntecipacaoIcms: String;
begin
  Result := untTypesSistema.CST_ANTECIPACAO_ICMS;
end;

function TTestConstantesUtils.fGetCstSubstituicao: String;
begin
  Result := untConstantesNfe.CST_SUBSTITUICAO;
end;

function TTestConstantesUtils.fGetCstTributado: String;
begin
  Result := untTypesSistema.CST_TRIBUTADO;
end;

class function TTestConstantesUtils.New: IConstantesUtils;
begin
  Result := Self.Create;
end;

initialization

SetObjConstantes(TTestConstantesUtils.New());

end.
