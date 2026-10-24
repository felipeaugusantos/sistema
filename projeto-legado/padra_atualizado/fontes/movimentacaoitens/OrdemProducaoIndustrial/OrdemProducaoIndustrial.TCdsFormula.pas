unit OrdemProducaoIndustrial.TCdsFormula;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsFormula = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsFormula }

constructor TCdsFormula.Create(AOwner: TComponent);
begin
  inherited;
  With FieldDefs.AddFieldDef Do Begin Name := 'SEQUENCIAL_ORDEM_PRODUCAO'; DataType := ftString; Size := 024; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'TIPO';                      DataType := ftString; Size := 010; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_ITEM';               DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_ITEM';            DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QUANTIDADE';                DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_UNITARIO';            DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_100KG';               DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_PRODUCAO';            DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QTD_PRODUCAO';            DataType := ftFloat;  Required := False; End;

  CreateDataSet;
  Open;

  TFloatField(FieldByName('QUANTIDADE')).DisplayFormat := fMskDigitos(2);
  TFloatField(FieldByName('CUSTO_UNITARIO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('CUSTO_100KG')).DisplayFormat := fMskDigitos(2);
  TFloatField(FieldByName('CUSTO_PRODUCAO')).DisplayFormat := fMskDigitos(2);
  TFloatField(FieldByName('QTD_PRODUCAO')).DisplayFormat := fMskDigitos(2);

end;

end.
