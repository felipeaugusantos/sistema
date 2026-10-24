unit untRegraCalculoIvaST;

interface

uses Faturamento.Impostos.Tipos.Iva, untTypesST, untRegraCalculoIva,
  Faturamento.Impostos.Interfaces.Model, Shared.Functions.Core;

type
  TRegraCalculoIvaSt = class(TRegraCalculoIva, ICalculoIva)
  private

  public
    function CalcularValorIva(const NullParameter: String): TResultadoCalculoIva;

    constructor Create(AParametros: TParametrosCalculoIva;
                       AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                       AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                       AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                       ACore: IFunctionsCore); override;

    class function New(AParametros: TParametrosCalculoIva;
                       AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                       AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                       AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                       ACore: IFunctionsCore): ICalculoIva;
  end;

implementation

{ TRegraCalculoIvaSt }

function TRegraCalculoIvaSt.CalcularValorIva(const NullParameter: String): TResultadoCalculoIva;
begin
  IniciarIvaCliente;
  IniciarIvaAliquota;
  CalcularValorDoIvaEspMTOuNacMT;
  AdicionarValorDoIvaAosCamposParaMatriz;
  CalcularValorDoIvaCNAESimplificado;

  Result := ResultadoDoCalculoDoIva('');
end;

constructor TRegraCalculoIvaSt.Create(AParametros: TParametrosCalculoIva;
                                      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                                      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                                      ACore: IFunctionsCore);
begin
  inherited Create(AParametros, AModelClienteFornecedor, AModelProduto, AModelEmpresa, ACore);
end;

class function TRegraCalculoIvaSt.New(AParametros: TParametrosCalculoIva;
                                      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
                                      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
                                      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
                                      ACore: IFunctionsCore): ICalculoIva;
begin
  Result := Self.Create(AParametros, AModelClienteFornecedor, AModelProduto, AModelEmpresa, ACore);
end;

end.
