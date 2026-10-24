unit untGenericLibTintaControleVisual;

interface

uses
  untILibTintaControleVisual, untAbstractLibTintaControleVisual;

type
  TGenericLibTintaControleVisual = class(TAbstractLibTintaControleVisual, ILibTintaControleVisual)
  protected
    strNomeClasse: string;
  public
    constructor Create(const strNome: string; const strNomeClasse: string); reintroduce;
    function GetClasse: string; override;
  end;

implementation


{ TGenericLibTintaControleVisual }

constructor TGenericLibTintaControleVisual.Create(const strNome, strNomeClasse: string);
begin
  inherited Create(strNome);
  Self.strNomeClasse := strNomeClasse;
end;

function TGenericLibTintaControleVisual.GetClasse: string;
begin
  Result := strNomeClasse;
end;

end.
