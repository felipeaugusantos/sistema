unit untILocalizavel;

interface

uses
  DB;

type
  ILocalizavel = interface
    procedure OnLocalizado(qryDados: TDataSet);
  end;

implementation

end.
