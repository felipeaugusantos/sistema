unit OrdemProducaoIndustrial.TCdsEtiquetaProdutoAcabado;

interface

uses
  UniClientDataSet,
  Classes,
  SysUtils,
  Data.Db,
  System.Variants,

  OrdemProducaoIndustrial.TEtiquetaProdutoAcabadoFields;

  type
    TCdsEtiquetaProdutoAcabado = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsEtiquetaProdutoAcabado }

constructor TCdsEtiquetaProdutoAcabado.Create(AOwner: TComponent);
begin
  inherited;

  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COR;                                DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_BAIXA;                         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS;                      DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_VALIDADE;                      DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO;                   DataType := ftDateTime;              Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE;                     DataType := ftInteger;                Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_CADASTRO;                      DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.NUMERO_LOTE;                        DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.LOTE_RASTREAMENTO;                  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM;                  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFERENCIA;                         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA;                 DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE;                      DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE;                  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM;            DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO;               DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM;               DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA;                    DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.NOME_CLIENTE;                       DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO;                   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_PREVISAO;                      DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PESO_BRUTO;                         DataType := ftFloat;                  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO;                       DataType := ftFloat;                  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL;        DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B;                 DataType:= ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO;                  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE;                   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B;                   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE;               DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.LAYOUT;                             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SEQUENCIAL_COMPLETO;                DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SEQUENCIAL;                         DataType := ftInteger;               Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.OBSERVACAO;                         DataType := ftString;   Size := 30;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTOITEM;                    DataType := ftString;   Size := 60;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPOS;                             DataType := ftString;   Size := 30;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.ITESAC;                             DataType := ftString;   Size := 30;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PAISOR;                             DataType := ftString;   Size := 30;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VALIDA;                             DataType := ftString;   Size := 30;  Required := False; End;

  CreateDataSet;
  Open;

end;

end.
