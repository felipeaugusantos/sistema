unit Garantia.TCdsValidacaoEspelhoXML;

interface

uses
  UniClientDataSet, Classes, SysUtils, Data.Db,
  System.Variants;

  type
    TCdsValidacaoEspelhoXML = class(TUniClientDataSet)
    public
      constructor Create(AOwner: TComponent); override;
  end;


implementation

{ TCdsValidacaoEspelhoXML }

constructor TCdsValidacaoEspelhoXML.Create(AOwner: TComponent);
var
  objFiedDefs : TFieldDef;
begin

  inherited;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'TIPO';
  objFiedDefs.DataType := ftInteger;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CODIGO_PRODUTO';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 007;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CODIGO_FABRICA';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 025;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'DESCRICAO_PRODUTO';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 070;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'REFERENCIA';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 016;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'SIGLA_UNIDADE';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 016;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CODIGO_SITUACAO_TRIBUTARIA';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 003;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_BRUTO';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'QUANTIDADE';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'BASE_ICMS';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'ALIQUOTA_ICMS';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_ICMS';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'BASE_SUBSTITUICAO_TRIBUTARIA';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_SUBSTITUICAO_TRIBUTARIA';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'BASE_IPI';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'ALIQUOTA_IPI';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_IPI';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CLASSIFICACAO_FISCAL';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 005;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'SEQUENCIAL';
  objFiedDefs.DataType := ftInteger;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'CST';
  objFiedDefs.DataType := ftString;
  objFiedDefs.Size := 003;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'DESCONTO';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'BASE_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'ALIQUOTA_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'BASE_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'ALIQUOTA_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALOR_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftFloat;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_DESCRICAO'  ;
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_BRUTO';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_QUANTIDADE';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_BASE_ICMS';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_ALIQUOTA_ICMS';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_ICMS';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_BASE_SUBSTITUICAO_TRIBUTARIA';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_SUBSTITUICAO_TRIBUTARIA';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_BASE_IPI';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_ALIQUOTA_IPI';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_IPI';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_CST';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_DESCONTO';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_BASE_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA_ST';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_BASE_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_ALIQUOTA_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_VALOR_FUNDO_COMBATE_POBREZA';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDACAO_CLASSIFICACAO_FISCAL';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  objFiedDefs := FieldDefs.AddFieldDef;
  objFiedDefs.Name := 'VALIDO';
  objFiedDefs.DataType := ftBoolean;
  objFiedDefs.Required := False;

  CreateDataSet;
  Open;

end;

end.
