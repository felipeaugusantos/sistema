unit untLibTintaControleVisualImplementacao;

interface

uses
  untGenericLibTintaControleVisual;

type
  TLibTintaControleVisualImplementacao = class(TGenericLibTintaControleVisual)
  public
    constructor Create(const strImplementacao: string); reintroduce;
  end;

implementation

{ TLibTintaControleVisualImplementacao }

constructor TLibTintaControleVisualImplementacao.Create(
  const strImplementacao: string);
begin
  inherited Create('', 'TLibTintaControleVisualImplementacao');
  Self.strImplementacao := strImplementacao;
end;

end.
