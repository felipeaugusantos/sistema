unit OrdemProducaoIndustrial.TCdsComposicao;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsComposicao = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsComposicao }

constructor TCdsComposicao.Create(AOwner: TComponent);
begin
  inherited;
  With FieldDefs.AddFieldDef Do Begin Name := 'SEQUENCIAL_ORDEM_PRODUCAO'; DataType := ftString; Size := 024; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_PRODUTO_ACABADO';    DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_COMPOSICAO';         DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_COMPOSICAO';      DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_ITEM';               DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_ITEM';            DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QUANTIDADE';                DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_UNITARIO';            DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_TOTAL';               DataType := ftFloat;  Required := False; End;

  CreateDataSet;
  Open;

  TFloatField(FieldByName('QUANTIDADE')).DisplayFormat := fMskDigitos(2);
  TFloatField(FieldByName('CUSTO_UNITARIO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('CUSTO_TOTAL')).DisplayFormat := fMskDigitos(4);

end;

end.
