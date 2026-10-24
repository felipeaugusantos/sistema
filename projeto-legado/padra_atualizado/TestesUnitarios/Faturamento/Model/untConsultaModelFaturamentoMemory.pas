unit untConsultaModelFaturamentoMemory;

interface

uses untConsultaModelFaturamento, untTypesGenericosImpostos, Faturamento.Impostos.Interfaces.Model;

type
  TConsultaModelFaturamentoMemory = class(TInterfacedObject, IConsultaModelFaturamento)
  public
    function ConsultarFornecedor(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarCliente(const ACodigoDoCliente: String; const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
      AParametrosClienteConsumidor : TFaturamentoImpostosClienteConsumidor; const ACodigoDaFazenda: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
    function ConsultarProduto(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String; const ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
      const AGerandoCasosTestes: Boolean; const ACodigoDaEmpresaAbf: String = ''): IResultadoFaturamentoImpostosModelProduto;
    function ConsultarEmpresa(const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
    class function New: IConsultaModelFaturamento;
  End;

implementation

uses untFactoryClienteFornecedorMemory, untFactoryProdutoMemory, untFactoryEmpresaMemory;

{ TConsultaModelFaturamentoMemory }

function TConsultaModelFaturamentoMemory.ConsultarCliente(const ACodigoDoCliente,
  ASequencialEnderecoEntrega: String; const AGerandoCasosTestes,
  AClienteConsumidorFinal: boolean;
  AParametrosClienteConsumidor: TFaturamentoImpostosClienteConsumidor; const ACodigoDaFazenda: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := TFactoryClienteFornecedorMemory.Create;
end;

function TConsultaModelFaturamentoMemory.ConsultarEmpresa(
  const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := TFactoryEmpresaMemory.Create;
end;

function TConsultaModelFaturamentoMemory.ConsultarFornecedor(
  const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  Result := TFactoryClienteFornecedorMemory.Create;
end;

function TConsultaModelFaturamentoMemory.ConsultarProduto(const ACodigoDoProduto,
  ACodigoDaEmpresa, ACodigoDaEmpresaTE, ACodigoDoFornecedorDoItem: String;
  const AGerandoCasosTestes: Boolean;
  const ACodigoDaEmpresaAbf: String): IResultadoFaturamentoImpostosModelProduto;
begin
  Result := TFactoryProdutoMemory.Create(ACodigoDoProduto);
end;

class function TConsultaModelFaturamentoMemory.New: IConsultaModelFaturamento;
begin
  Result := Self.Create;
end;

end.
