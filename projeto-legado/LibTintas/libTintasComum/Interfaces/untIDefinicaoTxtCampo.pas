unit untIDefinicaoTxtCampo;

interface

uses
  untDefinicaoTxtCampoTipo;

type
  IDefinicaoTxtCampo = interface
    ['{B9A41C6D-B1EF-4D60-B236-9A8636D339DE}']
    function GetNome: string;
    function GetTipo: TDefinicaoTxtCampoTipo.Tipo;
    function GetLargura: Integer;

    property Nome: string read GetNome;
    property Tipo: TDefinicaoTxtCampoTipo.Tipo read GetTipo;
    property Largura: Integer read GetLargura;
  end;

  TArrayIDefinicaoTxtCampo = array of IDefinicaoTxtCampo;

  TArrayIDefinicaoTxtCampoFactory = class(TInterfacedObject)
  public
    class function GetArrayIDefinicaoTxtCampo(const arrDefinicaoTxtCampo: array of IDefinicaoTxtCampo): TArrayIDefinicaoTxtCampo;
  end;

implementation

{ TArrayIDefinicaoTxtCampoFactory }

class function TArrayIDefinicaoTxtCampoFactory.GetArrayIDefinicaoTxtCampo(
  const arrDefinicaoTxtCampo: array of IDefinicaoTxtCampo): TArrayIDefinicaoTxtCampo;
var
  intCont: Integer;
begin
  SetLength(Result, Length(arrDefinicaoTxtCampo));
  for intCont := 0 to Length(arrDefinicaoTxtCampo) - 1 do
    Result[intCont] := arrDefinicaoTxtCampo[intCont];
    
end;

end.
