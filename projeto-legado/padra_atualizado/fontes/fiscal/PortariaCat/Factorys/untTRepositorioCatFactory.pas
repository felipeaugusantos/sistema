unit untTRepositorioCatFactory;

interface

uses untTRepositorioCat42,
     untIRepositorioCat,
     untTipo;

type
  TRepositorioCatFactory = class
    class function fRetRepositorioCat(tipoCat: TTipoCat): IRepositorioCat;
  end;

implementation

{ TRepositorioCatFactory }

class function TRepositorioCatFactory.fRetRepositorioCat(tipoCat: TTipoCat): IRepositorioCat;
begin
  Result := nil;
end;

end.
