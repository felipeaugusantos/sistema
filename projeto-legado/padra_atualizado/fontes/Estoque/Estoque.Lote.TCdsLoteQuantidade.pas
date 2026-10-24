unit Estoque.Lote.TCdsLoteQuantidade;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db,
  System.Variants;

  type
    TCdsLoteQuantidade = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsValidacaoEspelhoXML }

constructor TCdsLoteQuantidade.Create(AOwner: TComponent);
var
  objFiedDefs : TFieldDef;
  objAggregate : TAggregateField;
begin

  inherited;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CODIGO_PRODUTO';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 007;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'NUMERO_LOTE';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 030;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'QUANTIDADE';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  AggregatesActive := True;
  objAggregate := TAggregateField.Create(Self);
  objAggregate.FieldName := 'QUANTIDADE_TOTAL';
  objAggregate.DataSet := Self;
  objAggregate.Expression := 'SUM(QUANTIDADE)';
  objAggregate.Active := True;

  CreateDataSet;
  Open;

end;

end.
