unit untGenericLibTintaControleVisualDBEditFocus;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untGenericLibTintaControleVisualWinControl;

type
  TGenericLibTintaControleVisualDBEditFocus = class(TGenericLibTintaControleVisualWinControl)
  public
    constructor Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
      const TipoTexto: string; const strDataField: string); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualDBEditFocus }

constructor TGenericLibTintaControleVisualDBEditFocus.Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
  const TipoTexto: string; const strDataField: string);
begin
  inherited Create('TDBEditFocus', strNome, intLeft, intTop, intWidth, intHeight);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TipoTexto', TipoTexto))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('DataField', strDataField));
end;

end.

