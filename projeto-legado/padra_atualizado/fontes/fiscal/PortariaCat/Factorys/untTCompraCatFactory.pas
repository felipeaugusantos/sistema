unit untTCompraCatFactory;

interface

uses untICompraCat, untTCompraCat42, untTipo, untTDadosAberturaExportacaoCat42;

type
  TCompraCatFactory = class
    class function fRetCompraCat(tipoCat: TTipoCat; abertura: TDadosAberturaExportacaoCat42): ICompraCat;
  end;

implementation

{ TCompraCatFactory }

class function TCompraCatFactory.fRetCompraCat(tipoCat: TTipoCat; abertura: TDadosAberturaExportacaoCat42): ICompraCat;
begin
  Result := nil;

  if tipoCat = Cat42 then
    Result := TCompraCat42.Create(abertura);
end;

end.
