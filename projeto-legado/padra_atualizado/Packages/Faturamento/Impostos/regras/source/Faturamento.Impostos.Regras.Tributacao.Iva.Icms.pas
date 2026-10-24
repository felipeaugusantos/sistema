unit Faturamento.Impostos.Regras.Tributacao.Iva.Icms;

interface

uses Faturamento.Impostos.Interfaces.Iva, Faturamento.Impostos.Tipos.Iva,
  Faturamento.Impostos.Regras.Tributacao.Iva;

type
  TRegraCalculoIvaIcms = class(TRegraCalculoIva, IRegraCalculoIva)
  private
  public
    procedure CalcularValorDoIvaCNAESimplificado; override;
    function CalcularValorIva: IResultadoCalculoIva;

    constructor Create(AParametros: IParametrosCalculoIva); override;

    class function New(AParametros: IParametrosCalculoIva): IRegraCalculoIva;
  end;

implementation

{ TRegraCalculoIvaIcms }

procedure TRegraCalculoIvaIcms.CalcularValorDoIvaCNAESimplificado;
begin
  If GetParametros.DentroDoEstado Then
  Begin
    CalcularValorDoIvaCNAESimplificadoDentroDoEstado;
    Exit;
  End;
end;

function TRegraCalculoIvaIcms.CalcularValorIva: IResultadoCalculoIva;
begin
  IniciarIvaCliente;
  IniciarIvaAliquota;
  CalcularValorDoIvaEspMTOuNacMT;
  AdicionarValorDoIvaAosCamposParaMatriz;
  CalcularValorDoIvaCNAESimplificado;

  Result := ResultadoDoCalculoDoIva;
end;

constructor TRegraCalculoIvaIcms.Create(AParametros: IParametrosCalculoIva);
begin
  inherited Create(AParametros);
end;

class function TRegraCalculoIvaIcms.New(
  AParametros: IParametrosCalculoIva): IRegraCalculoIva;
begin
  result := Self.Create(AParametros);
end;

end.
