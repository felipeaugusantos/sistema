unit untGenericLibTintaControleVisualDBMemoFocus;

interface

uses
  untILibTintaControleVisual, untGenericLibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untGenericLibTintaControleVisualWinControl;

type
  TGenericLibTintaControleVisualDBMemoFocus = class(TGenericLibTintaControleVisualWinControl)
  public
    constructor Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
      const strDataField: string); reintroduce;
  end;

implementation

{ TGenericLibTintaControleVisualDBMemoFocus }

constructor TGenericLibTintaControleVisualDBMemoFocus.Create(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
  const strDataField: string);
begin
  inherited Create('TDBMemoFocus', strNome, intLeft, intTop, intWidth, intHeight);
  Self.AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('DataField', strDataField));
end;

end.

