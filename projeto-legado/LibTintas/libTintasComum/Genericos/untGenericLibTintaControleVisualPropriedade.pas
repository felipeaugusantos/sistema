unit untGenericLibTintaControleVisualPropriedade;

interface

uses
  untILibTintaControleVisualPropriedade, Variants;

type
  TGenericLibTintaControleVisualPropriedade = class(TInterfacedObject, ILibTintaControleVisualPropriedade)
  private
    valor: Variant;
    strNome: string;
  public
    constructor Create(const strNome: string; const valor: Variant);
    function GetNome: string;
    function GetValue: Variant;
    procedure SetValue(const value: Variant);
  end;

implementation

{ TGenericLibTintaControleVisualPropriedade }

constructor TGenericLibTintaControleVisualPropriedade.Create(const strNome: string; const valor: Variant);
begin
  inherited Create();
  Self.strNome := strNome;
  Self.valor := valor;
end;

function TGenericLibTintaControleVisualPropriedade.GetNome: string;
begin
  Result := strNome;
end;

function TGenericLibTintaControleVisualPropriedade.GetValue: Variant;
begin
  Result := valor;
end;

procedure TGenericLibTintaControleVisualPropriedade.SetValue(
  const value: Variant);
begin
  valor := value;
end;

end.
