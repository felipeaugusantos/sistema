unit Faturamento.Impostos.Regras.Tributacao.Iva.St;

interface

uses Faturamento.Impostos.Interfaces.Iva, Faturamento.Impostos.Regras.Tributacao.Iva;

type
  TRegraCalculoIvaSt = class(TRegraCalculoIva, IRegraCalculoIva )
  private

  public
    function CalcularValorIva: IResultadoCalculoIva;

    constructor Create(AParametros: IParametrosCalculoIva); override;

    class function New(AParametros: IParametrosCalculoIva): IRegraCalculoIva;
  end;


implementation


{ TRegraCalculoIvaSt }

function TRegraCalculoIvaSt.CalcularValorIva: IResultadoCalculoIva;
begin
  IniciarIvaCliente;
  IniciarIvaAliquota;
  CalcularValorDoIvaEspMTOuNacMT;
  AdicionarValorDoIvaAosCamposParaMatriz;
  CalcularValorDoIvaCNAESimplificado;

  Result := ResultadoDoCalculoDoIva;
end;

constructor TRegraCalculoIvaSt.Create(AParametros: IParametrosCalculoIva);
begin
  inherited Create(AParametros);
end;

class function TRegraCalculoIvaSt.New(
  AParametros: IParametrosCalculoIva): IRegraCalculoIva;
begin
  Result := Self.Create(AParametros);
end;

end.
