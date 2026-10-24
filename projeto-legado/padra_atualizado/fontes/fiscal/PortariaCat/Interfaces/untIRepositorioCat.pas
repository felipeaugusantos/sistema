unit untIRepositorioCat;

interface

uses System.Generics.Collections,
     untTDadosAbertura,
     untTRegistroCat;

type
  IRepositorioCat = interface
    function fRetListaRegCat(abertura: TDadosAbertura): TObjectList<TRegistroCat>;
  end;

implementation

end.
