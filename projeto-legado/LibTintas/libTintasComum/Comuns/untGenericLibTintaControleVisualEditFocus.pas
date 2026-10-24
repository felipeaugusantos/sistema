unit untGenericLibTintaControleVisualEditFocus;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untGenericLibTintaControleVisualWinControl;

type
  TGenericLibTintaControleVisualEditFocus = class(TGenericLibTintaControleVisualWinControl)
  public
    constructor Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
      const TipoTexto: string); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualDBEditFocus }

constructor TGenericLibTintaControleVisualEditFocus.Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
  const TipoTexto: string);
begin
  inherited Create('TEditFocus', strNome, intLeft, intTop, intWidth, intHeight);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TipoTexto', TipoTexto))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Text', ''));
end;

end.

