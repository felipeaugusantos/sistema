unit untIRepositorioAjusteIcms;

interface

uses System.Generics.Collections,
     untTypesSistema, untTAjusteIcms;

type
  IRepositorioAjusteIcms = interface
    function fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>;
  end;

implementation

end.
