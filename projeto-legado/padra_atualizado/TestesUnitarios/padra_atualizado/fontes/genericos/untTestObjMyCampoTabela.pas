unit untTestObjMyCampoTabela;

interface

uses Shared.Functions.DataSet;

  procedure SetarObjMyCampoTabela(AValue: TInterfacedObject);

var
  objMyCampoTabela: IMyCampoTabela;
  objMyCampoTabelaAdd: IMyCampoTabelaAdd;

implementation

procedure SetarObjMyCampoTabela(AValue: TInterfacedObject);
begin
  objMyCampoTabela := AValue as IMyCampoTabela;
  objMyCampoTabelaAdd := AValue as IMyCampoTabelaAdd;
end;

end.
