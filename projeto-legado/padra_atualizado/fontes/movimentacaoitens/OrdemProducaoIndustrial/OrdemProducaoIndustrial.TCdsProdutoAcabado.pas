unit OrdemProducaoIndustrial.TCdsProdutoAcabado;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db, untFuncoesSimples,
  System.Variants;

  type
    TCdsProdutoAcabado = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsProdutoAcabado }

constructor TCdsProdutoAcabado.Create(AOwner: TComponent);
begin
  inherited;

  With FieldDefs.AddFieldDef Do Begin Name := 'SEQUENCIAL_ORDEM_PRODUCAO';              DataType := ftString; Size := 024; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_ORDEM_PRODUCAO';                  DataType := ftString; Size := 005; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DATA_CADASTRO_ORDEM_PRODUCAO';           DataType := ftDate;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DATA_BAIXA_ORDEM_PRODUCAO';              DataType := ftDate;   Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_OPERADOR';                        DataType := ftString; Size := 003; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'NOME_OPERADOR';                          DataType := ftString; Size := 030; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_OPEBAIXA';                        DataType := ftString; Size := 003; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'NOME_OPEBAIXA';                          DataType := ftString; Size := 030; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_PRODUTO_GRANEL';                  DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_PRODUTO_GRANEL';               DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'KILO_LITRO_GRANEL';                      DataType := ftString; Size := 005; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_COR';                             DataType := ftString; Size := 007; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_COR';                          DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'PESO_REAL';                              DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_KILO';                             DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_LITRO';                            DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'TOTAL_ENVASADO_KILO';                    DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'TOTAL_ENVASADO_LITRO';                   DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'TOTAL_PRODUZIDO_KILO';                   DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_TOTAL_PRODUCAO';                   DataType := ftFloat;  Required := False; End;

  With FieldDefs.AddFieldDef Do Begin Name := 'CODIGO_PRODUTO_ACABADO';                 DataType := ftString; Size := 07; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'DESCRICAO_PRODUTO_ACABADO';              DataType := ftString; Size := 100; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'PESO_LITRO_PRODUTO_ACABADO';             DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QUANTIDADE_PRODUZIDA_PRODUTO_ACABADO';   DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'QUANTIDADE_ENVASADA_PRODUTO_ACABADO';    DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'PESO_PRODUZIDO_PRODUTO_ACABADO';         DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_RELATIVO_PRODUCAO_PRODUTO_ACABADO';DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_FORMULA_UNITARIO_PRODUTO_ACABADO'; DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_COMPOSICAO_PRODUTO_ACABADO';       DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'PRECO_COMPRA_PRODUTO_ACABADO';           DataType := ftFloat;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := 'CUSTO_PRODUTO_ACABADO';                  DataType := ftFloat;  Required := False; End;


  CreateDataSet;
  Open;


  TFloatField(FieldByName('PESO_REAL')).DisplayFormat := fMskDigitos(5);
  TFloatField(FieldByName('CUSTO_KILO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('CUSTO_LITRO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('TOTAL_ENVASADO_KILO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('TOTAL_ENVASADO_LITRO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('TOTAL_PRODUZIDO_KILO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('CUSTO_TOTAL_PRODUCAO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('PESO_LITRO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('QUANTIDADE_PRODUZIDA_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('QUANTIDADE_ENVASADA_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('PESO_PRODUZIDO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(3);
  TFloatField(FieldByName('CUSTO_RELATIVO_PRODUCAO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('CUSTO_FORMULA_UNITARIO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('CUSTO_COMPOSICAO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('PRECO_COMPRA_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(4);
  TFloatField(FieldByName('CUSTO_PRODUTO_ACABADO')).DisplayFormat := fMskDigitos(2);

  IndexFieldNames :=  'DATA_CADASTRO_ORDEM_PRODUCAO' +
                      ';CODIGO_ORDEM_PRODUCAO'       +
                      ';CODIGO_PRODUTO_GRANEL'       +
                      ';CODIGO_COR;'                 +
                      'DESCRICAO_PRODUTO_ACABADO'    ;

end;

end.
