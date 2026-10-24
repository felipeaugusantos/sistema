unit untConstantesUtils;

interface

uses Shared.Functions.Constantes;

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
  Result := '090_190_290_390_490_590_690_790_';
end;

function TConstantesUtils.fGetCstSubstituicao: String;
begin
  Result :=  '010_110_210_310_410_510_610_710_810_' +
             '060_160_260_360_460_560_660_760_860_' +
             '070_170_270_370_470_570_670_770_870_' +
             '030_130_230_330_430_530_630_730_';
end;

function TConstantesUtils.fGetCstTributado: String;
begin
  Result := '000_100_200_300_400_500_600_700_800_' +
            '020_120_220_320_420_520_620_720_820_';
end;

class function TConstantesUtils.New: IConstantesUtils;
begin
  Result := Self.Create;
end;

initialization

SetObjConstantes(TConstantesUtils.New());

end.
