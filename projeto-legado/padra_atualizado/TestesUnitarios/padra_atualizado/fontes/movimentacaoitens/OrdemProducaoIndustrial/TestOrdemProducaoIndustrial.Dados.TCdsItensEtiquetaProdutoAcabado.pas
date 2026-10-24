unit TestOrdemProducaoIndustrial.Dados.TCdsItensEtiquetaProdutoAcabado;

interface

uses
  UniClientDataSet,
  Classes,
  SysUtils,
  Data.Db,
  System.Variants,

  OrdemProducaoIndustrial.TEtiquetaProdutoAcabadoFields;

  type
    TCdsItensEtiquetaProdutoAcabado = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;

      procedure pAlimentaItens;
  end;


implementation

{ TCdsItensEtiquetaProdutoAcabado }

constructor TCdsItensEtiquetaProdutoAcabado.Create(AOwner: TComponent);
begin
  inherited;

  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO;  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COR;                        DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_BAIXA;                 DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS;              DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_VALIDADE;              DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO;           DataType := ftDateTime;              Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE;             DataType := ftInteger;               Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_CADASTRO;              DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFERENCIA;                 DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE;              DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO;   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM;    DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO;       DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA;   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM;       DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA;            DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.NOME_CLIENTE;               DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DATA_PREVISAO;              DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PESO_BRUTO;                 DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO;               DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL;DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE; DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B;         DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE;  DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL;   DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B;           DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE;       DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.LAYOUT;                     DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.QUANTIDADE_ETIQUETAS;       DataType := ftInteger;               Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.MARCA_DESMARCA;             DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.QUANTIDADE_PRODUZIDA;       DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.PESO_LITRO;                 DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.ETIQUETA_IMPRESSA;          DataType := ftString;   Size := 250; Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.VOLUME;                     DataType := ftFloat;                 Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.QUANTIDADE_LAYOUT;          DataType := ftInteger;               Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.OBSERVACAO;                 DataType := ftString;   Size := 30;  Required := False; End;
  With FieldDefs.AddFieldDef Do Begin Name := TEtiquetaProdutoAcabadoFields.COMPLEMENTOITEM;            DataType := ftString;   Size := 60;  Required := False; End;
  CreateDataSet;
  Open;

end;

procedure TCdsItensEtiquetaProdutoAcabado.pAlimentaItens;
begin
  Insert;
  FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_PRODUTO ).AsString              := '00001';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_ACABADO ).AsString   := 'Descricao Produto Acabado';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_CADASTRO_PRODUTO ).AsString  := 'Descricao Produto';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_SIMPLES_CADASTRO_PRODUTO ).AsString  := 'Descricao Simples Produto';
  FieldByName( TEtiquetaProdutoAcabadoFields.COR ).AsString                         := 'Cor';
  FieldByName( TEtiquetaProdutoAcabadoFields.DATA_BAIXA ).AsString                  := '10/10/2020';
  FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS ).AsString               := '00001A';
  FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_FABRICA ).AsString              := '00001B';
  FieldByName( TEtiquetaProdutoAcabadoFields.DATA_VALIDADE ).AsString               := '10/10/2021';
  FieldByName( TEtiquetaProdutoAcabadoFields.VALIDADE_PRODUTO ).AsDateTime          := StrToDate('10/10/2022');
  FieldByName( TEtiquetaProdutoAcabadoFields.PRAZO_VALIDADE ).AsInteger             := 12;
  FieldByName( TEtiquetaProdutoAcabadoFields.DATA_CADASTRO ).AsString               := '01/10/2020';
  FieldByName( TEtiquetaProdutoAcabadoFields.ORDDET_AUTOINCREM ).AsString           := '00000000000000000001';
  FieldByName( TEtiquetaProdutoAcabadoFields.REFERENCIA ).AsString                  := 'Referencia';
  FieldByName( TEtiquetaProdutoAcabadoFields.LOCALIZACAO_FISICA ).AsString          := 'Localização Física';
  FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_UNIDADE ).AsString               := 'UN';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_UNIDADE ).AsString           := 'Unidade';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_RESUMIDA_UNIDADE ).AsString  := 'Unidade Resumida';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_UNIDADE ).AsString  := 'Unidade Etiqueta';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_GRUPO ).AsString    := 'Grupo Etiqueta';
  FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_BARRAS_EMBALAGEM ). AsString    := '00001C';
  FieldByName( TEtiquetaProdutoAcabadoFields.SIGLA_ETIQUETA_GRUPO ).AsString        := 'GP';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_ETIQUETA_LINHA ).AsString    := 'Descricao Linha';
  FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_EMBALAGEM ).AsFloat         := 1;
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_MARCA ).AsString             := 'Descricao Marca';
  FieldByName( TEtiquetaProdutoAcabadoFields.CODIGO_CLIENTE ).AsString              := '00000001';
  FieldByName( TEtiquetaProdutoAcabadoFields.NOME_CLIENTE ).AsString                := 'Nome Cliente';
  FieldByName( TEtiquetaProdutoAcabadoFields.NUMERO_DOCUMENTO ).AsString            := '000000000001';
  FieldByName( TEtiquetaProdutoAcabadoFields.DATA_PREVISAO ).AsString               := '09/10/2020';
  FieldByName( TEtiquetaProdutoAcabadoFields.PESO_BRUTO ).AsFloat                   := 20;
  FieldByName( TEtiquetaProdutoAcabadoFields.PESO_LIQUIDO ).AsFloat                 := 15;
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_PRINCIPAL ).AsString := 'Descricao Prouto Principal';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_PRODUTO_DILUENTE ).AsString  := 'Descricao Prouto Diluente';
  FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_B ).AsString          := 'REFERENCIA PRODUTO B';
  FieldByName( TEtiquetaProdutoAcabadoFields.REFENCIA_PRODUTO_DILUENTE ).AsString   := 'REFERENCIA PRODUTO DILUENTE';
  FieldByName( TEtiquetaProdutoAcabadoFields.APLICACAO_PRODUTO ).AsString           := 'APLICACAO PRODUTO';
  FieldByName( TEtiquetaProdutoAcabadoFields.RELACAO_CATALISE ).AsString            := '1';
  FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_PRINCIPAL ).AsString    := '1200';
  FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME_PRODUTO_B ).AsString            := '1250';
  FieldByName( TEtiquetaProdutoAcabadoFields.DESCRICAO_FABRICANTE ).AsString        := 'Descricao Fabricante';
  FieldByName( TEtiquetaProdutoAcabadoFields.LAYOUT ).AsString                      := '01';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_01 ).AsString              := 'Complemento 01';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_02 ).AsString              := 'Complemento 02';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_03 ).AsString              := 'Complemento 03';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_04 ).AsString              := 'Complemento 04';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_05 ).AsString              := 'Complemento 05';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_06 ).AsString              := 'Complemento 06';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_07 ).AsString              := 'Complemento 07';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_08 ).AsString              := 'Complemento 08';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_09 ).AsString              := 'Complemento 09';
  FieldByName( TEtiquetaProdutoAcabadoFields.COMPLEMENTO_10 ).AsString              := 'Complemento 10';
  FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_ETIQUETAS ).AsInteger       := 2;
  FieldByName( TEtiquetaProdutoAcabadoFields.MARCA_DESMARCA ).AsString              := 'M';
  FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_PRODUZIDA ).AsFloat         := 50;
  FieldByName( TEtiquetaProdutoAcabadoFields.PESO_LITRO ).AsFloat                   := 25;
  FieldByName( TEtiquetaProdutoAcabadoFields.ETIQUETA_IMPRESSA ).AsString           := 'N';
  FieldByName( TEtiquetaProdutoAcabadoFields.VOLUME ).AsFloat                       := 35;
  FieldByName( TEtiquetaProdutoAcabadoFields.QUANTIDADE_LAYOUT ).AsInteger          := 1;
  FieldByName( TEtiquetaProdutoAcabadoFields.OBSERVACAO ).AsString                  := 'Observacao livre OPI';
  Post;

end;

end.
