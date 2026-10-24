unit untGenericLibTintaControleVisualDBCheckBox;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untGenericLibTintaControleVisualWinControl;

type
  TGenericLibTintaControleVisualDBCheckBox = class(TGenericLibTintaControleVisualWinControl)
  public
    constructor Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
      const Caption: string; const strDataField: string; const ValueChecked: Variant; const ValueUnchecked: Variant); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualDBEditFocus }

constructor TGenericLibTintaControleVisualDBCheckBox.Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
  const Caption: string; const strDataField: string; const ValueChecked: Variant; const ValueUnchecked: Variant);
begin
  inherited Create('TDBCheckBox', strNome, intLeft, intTop, intWidth, intHeight);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', Caption))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('DataField', strDataField))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('ValueChecked', ValueChecked))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('ValueUnchecked', ValueUnchecked));
end;

end.

