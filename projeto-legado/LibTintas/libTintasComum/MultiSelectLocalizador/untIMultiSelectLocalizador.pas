unit untIMultiSelectLocalizador;

interface

uses
  Classes, untIDataSet;

type
  IMultiSelectLocalizador = interface
  ['{30F8BDA6-47F0-42FE-B589-CB365186A1BD}']
    function GetSqls(): TStringList;
    function Localizar(out cdsGen: IDataSet; const arrParametros: array of string; const arrValores: array of Variant): Boolean;
    property Sqls: TStringList read GetSqls;
  end;

implementation

end.
