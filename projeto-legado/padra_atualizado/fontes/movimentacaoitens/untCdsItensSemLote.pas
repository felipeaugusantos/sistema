unit untCdsItensSemLote;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsItensSemLote = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsItensSemLote }

constructor TCdsItensSemLote.Create(AOwner: TComponent);
begin
  inherited;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO';      DataType := ftString; Size := 07;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO';   DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'NUMERO_LOTE'; DataType := ftString; Size := 30;  Required := False; End;

  IndexFieldNames := 'CODIGO';
  CreateDataSet;
  Open;

end;

end.
