unit untConsultaModelFaturamento;

interface

uses Faturamento.Impostos.Interfaces.Model, untTypesGenericosImpostos;

type
  IConsultaModelFaturamento = interface
    ['{BAA6C7DF-86EF-45DE-AC90-8D588A501F59}']
    function ConsultarFornecedor(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarCliente(const ACodigoDoCliente: String; const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
      AParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor; const ACodigoDaFazenda: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarProduto(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String; const ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
      const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;
    function ConsultarEmpresa(const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
  end;

implementation

end.
