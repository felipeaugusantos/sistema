unit untTRetRegistroCatFactory;

interface

uses untIRetRegistroCat, untTipo;

type
  TRetRegistroCatFactory = class
    class function fRetTipoRegistroCat(tipo: TTipoEnquadramentoCat): IRetRegistroCat;
  end;

implementation

{ TRetRegistroCatFactory }

class function TRetRegistroCatFactory.fRetTipoRegistroCat(tipo: TTipoEnquadramentoCat): IRetRegistroCat;
begin
  Result := nil;

//  if tipo = teFatoGeradorNaoRealizado then
//    Result := TRetRegistroCat42FatoGeradorNaoRealizado.Create;
//
//  if tipo = teConsumidorFinal then
//    Result := TRetRegistroCat42VendasConsumidorFinal.Create;
//
//  if tipo = teSaidasOutroEstado then
//    Result := TRetRegistroCat42VendasInterEstaduais.Create;
//
//  if tipo = teSaidasIsencao then
//    Result := TRetRegistroCat42VendasIsencao.Create;
end;

end.
