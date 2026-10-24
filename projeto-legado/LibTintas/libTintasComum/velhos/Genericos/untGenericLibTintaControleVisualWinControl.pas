unit untGenericLibTintaControleVisualWinControl;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade;

type
  TGenericLibTintaControleVisualWinControl = class(TGenericLibTintaControleVisual)
  public
    constructor Create(const strNomeClasse, strNome: string; const intLeft, intTop, intWidth, intHeight: Integer); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualWinControl }

constructor TGenericLibTintaControleVisualWinControl.Create(const strNomeClasse, strNome: string; const intLeft, intTop, intWidth,
  intHeight: Integer);
begin
  inherited Create(strNome, strNomeClasse);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Left', intLeft)).
    AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Top', intTop)).
    AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Width', intWidth)).
    AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Height', intHeight));
end;

end.
