unit Reforma.Calculo.Modelo;

// Estado de um lado da simulacao (Novo ou Futuro). Espelha os campos virtuais
// de TCalculadoraPrecoCliente sem depender de dataset: a tela le e grava aqui.

interface

uses
  Reforma.Contrato.Tipos;

type
  TTabelaPreco = record
    PrecoVenda: Double;
    MargemBruta: Double;
    Comissao: Double;
    PrecoCliente: Double;
    CustoVenda: Double;
    FatorTabela: Double;
  end;

  TFormacaoCusto = record
    Lado: TLadoSimulacao;
    Estado: TEstadoCadastro;
    Custo: TCustoEntrada;
    // Desconto PIS/COFINS 2027 (%) e o preco de compra com ele (REFTRI-01, RN02): e o preco com desconto que
    // vai para o host como PrecoCompra do custo. Com CFG_REFCIS = 'S' o desconto e 0 e os dois precos sao iguais.
    DescontoPisCofins: Double;
    PrecoCompraComDesconto: Double;
    // Preco de compra e desconto de onde saiu o PrecoCompraComDesconto. Enquanto nao mudam, o preco com desconto
    // digitado na aba 3 (grPrecoLiquido) fica como foi digitado, sem ser refeito do preco de compra arredondado.
    BasePrecoCompra: Double;
    BaseDescontoPisCofins: Double;
    PrecoCompraLiquido: Double;
    PrecoCusto: Double;
    OutrosValores: Double;
    IcmsSaida: Double;
    ImpostoFederal: Double;
    DespesaOperacional: Double;
    CustoReal: Double;
    Aliquotas: TAliquotasReforma;
    Tabelas: array[1..QUANTIDADE_TABELAS_PRECO] of TTabelaPreco;
  end;

implementation

end.