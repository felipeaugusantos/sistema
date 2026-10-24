{*********************************************************}
{* Classe contendo as funcções comuns com o tipo Variant *}
{******************************************************PH*}
unit untVariantUtils;

interface

uses
  Variants;

type
  TVariantUtils = class(TInterfacedObject)
  public
    class function IfNull(varValor, varDefault: Variant): Variant;
  end;

implementation

{ TVariantUtils }

class function TVariantUtils.IfNull(varValor, varDefault: Variant): Variant;
begin
  Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

end.
