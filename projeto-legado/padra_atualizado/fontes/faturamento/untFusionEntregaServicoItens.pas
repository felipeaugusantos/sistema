unit untFusionEntregaServicoItens;

{ * Campo não obrigatório
  # Campo obsoleto

  // EXEMPLO -- DESCRIÇÃO }

interface

uses
  System.Generics.Collections;

type
  TFusionEntregaServicoItens = class

  private
  public
    cod_produto_erp :String; // 315524 -- Código do produto no ERP
    descricao	:String; // LUMINARIA FLUOR1X40W ABERTA -- Descrição do produto
    {*}unidade: String; //	UN -- Unidade do produto
    qtd: String; //	1	-- Quantidade dos itens
    preco: String; //	7.8	-- Valor do pedido
    subtotal: String; // 7.8 -- Sem descrição
    {*}valor_icms_st: String; //	0 -- Sem descrição
    {*}ncm: String; //	94051093 -- NCM do produto
    {*}cst: String; // 0 -- CST

    function fGerarJson: String;
  end;

implementation

uses
  REST.JSON;

{ TFusionEntregaServicoItens }

function TFusionEntregaServicoItens.fGerarJson: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

end.
