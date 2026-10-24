unit untConstantesUtils;

interface

uses Shared.Functions.Constantes, untConstantes, untConstantesNFe, untTypesSistema;

type
  TConstantesUtils = class(TInterfacedObject, IConstantesUtils)
  public
    function fGetCstSubstituicao: String;
    function fGetCstAntecipacaoIcms: String;
    function fGetCstTributado: String;

    class function New(): IConstantesUtils;
  end;

implementation

{ TConstantesUtils }

function TConstantesUtils.fGetCstAntecipacaoIcms: String;
begin
  Result := untTypesSistema.CST_ANTECIPACAO_ICMS;
end;

function TConstantesUtils.fGetCstSubstituicao: String;
begin
  Result := untConstantesNfe.CST_SUBSTITUICAO;
end;

function TConstantesUtils.fGetCstTributado: String;
begin
  Result := untTypesSistema.CST_TRIBUTADO;
end;

class function TConstantesUtils.New: IConstantesUtils;
begin
  Result := Self.Create;
end;

initialization

SetObjConstantes(TConstantesUtils.New());

end.
