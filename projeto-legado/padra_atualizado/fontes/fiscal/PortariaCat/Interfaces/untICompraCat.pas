unit untICompraCat;

interface

uses System.Generics.Collections, untTItemNotaUtilizadoCat, untTNotaFiscal, untTItemNotaFiscal, untTDadosAberturaExportacaoCat42;

type
  ICompraCat = interface
    function fRetCompraCat(dtaDataVenda: TDatetime;
                           itemVenda: TItemNotaFiscal;
                           listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TNotaFiscal>;
  end;

implementation

end.
