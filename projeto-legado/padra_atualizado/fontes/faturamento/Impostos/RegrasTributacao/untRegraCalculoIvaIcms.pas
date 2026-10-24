unit untRegraCalculoIvaIcms;

interface

uses Faturamento.Impostos.Interfaces.Iva, untRegraCalculoIva,
  Faturamento.Impostos.Interfaces.Model, Shared.Functions.Core, untTypesST;

type
  TRegraCalculoIvaIcms = class(TRegraCalculoIva, ICalculoIva)
  private
  public
    procedure CalcularValorDoIvaCNAESimplificado; override;
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

uses System.SysUtils;

{ TRegraCalculoIvaIcms }

procedure TRegraCalculoIvaIcms.CalcularValorDoIvaCNAESimplificado;
begin
  If GetParametros.DentroDoEstado Then
  Begin
    CalcularValorDoIvaCNAESimplificadoDentroDoEstado;
    Exit;
  End;
end;

function TRegraCalculoIvaIcms.CalcularValorIva(const NullParameter: String): TResultadoCalculoIva;
begin
  FillChar(Result, SizeOf(Result), #0);

  IniciarIvaCliente;
  IniciarIvaAliquota;
  CalcularValorDoIvaEspMTOuNacMT;
  AdicionarValorDoIvaAosCamposParaMatriz;
  CalcularValorDoIvaCNAESimplificado;

  Result := ResultadoDoCalculoDoIva('');// testar o result
end;

constructor TRegraCalculoIvaIcms.Create(AParametros: TParametrosCalculoIva;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      ACore: IFunctionsCore);
begin
  inherited Create(AParametros, AModelClienteFornecedor, AModelProduto, AModelEmpresa, ACore);
end;

class function TRegraCalculoIvaIcms.New(AParametros: TParametrosCalculoIva;
      AModelClienteFornecedor: IResultadoFaturamentoImpostosModelClienteFornecedor;
      AModelProduto: IResultadoFaturamentoImpostosModelProduto;
      AModelEmpresa: IResultadoFaturamentoImpostosModelEmpresa;
      ACore: IFunctionsCore): ICalculoIva;
begin
  Result := Self.Create(AParametros, AModelClienteFornecedor, AModelProduto, AModelEmpresa, ACore);
end;

end.
