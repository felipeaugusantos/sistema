unit untAbstractDataSetFactory;

interface

uses
  untIDataSetFactory, DB;

type
  TAbstractDataSetFactory = class abstract(TInterfacedObject, IDataSetFactory)
  public
    function GetDataSet: TDataSet; virtual; abstract;
  end;

implementation

end.
