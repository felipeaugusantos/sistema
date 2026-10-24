unit untIRetRegistroCat;

interface

uses System.Generics.Collections, untTDadosAberturaExportacaoCat42, untTItemNotaUtilizadoCat, untTNotaFiscal, untTRegistroCat, Classes;

type
  IRetRegistroCat = interface
    function fCarregaRegistrosCat(notas: TObjectList<TNotaFiscal>;
                                  abertura: TDadosAberturaExportacaoCat42;
                                  stlEnquadramento: TStringList): TObjectList<TRegistroCat>;
  end;

implementation

end.
