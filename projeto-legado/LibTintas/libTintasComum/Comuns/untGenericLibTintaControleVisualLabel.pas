unit untGenericLibTintaControleVisualLabel;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untGenericLibTintaControleVisualWinControl;

type
  TGenericLibTintaControleVisualLabel = class(TGenericLibTintaControleVisualWinControl)
  public
    constructor Create(const strNome, strCaption: string; const intLeft, intTop, intWidth, intHeight: Integer;
      const Alignment: string); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualLabel }

constructor TGenericLibTintaControleVisualLabel.Create(const strNome, strCaption: string; const intLeft, intTop, intWidth,
  intHeight: Integer; const Alignment: string);
begin
  inherited Create('TLabel', strNome, intLeft, intTop, intWidth, intHeight);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Alignment', Alignment)).
    AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', strCaption));
end;

end.
