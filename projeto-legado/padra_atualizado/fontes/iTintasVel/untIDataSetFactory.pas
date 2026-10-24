unit untIDataSetFactory;

interface

uses
  DB;

type
  IDataSetFactory = interface
    ['{93D0B953-866A-4CA4-B9BB-652C98B0EF3F}']
    function GetDataSet: TDataSet;
    property DataSet: TDataSet read GetDataSet;
  end;

implementation

end.
