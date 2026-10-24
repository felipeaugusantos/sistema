unit Faturamento.Impostos.Servicos.Classe.StCustoAquisicao;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.StCustoAquisicao,
  Faturamento.Impostos.Tipos.Servicos.Classe.StCustoAquisicao,
  Faturamento.Impostos.Interfaces.STCustoAquisicao,
  Faturamento.Impostos.Tipos.STCustoAquisicao,
  Faturamento.Impostos.Calculos.STCustoAquisicao;

type
  TServicosClasseStCustoAquisicao = class(TInterfacedObject, IServicosClasseStCustoAquisicao)
  private
    FParametros: IParametrosClasseStCustoAquisicao;

    function ResultadoCalculoStCustoAquisicaoFinal: IResultadoCalculoStCustoAquisicao;
  public
    function CalcularStCustoAquisicao: IResultadoClasseStCustoAquisicao;

    constructor Create(AParametros: IParametrosClasseStCustoAquisicao);

    class function New(AParametros: IParametrosClasseStCustoAquisicao): IServicosClasseStCustoAquisicao;
  end;

implementation

{ TServicosClasseStCustoAquisicao }

function TServicosClasseStCustoAquisicao.CalcularStCustoAquisicao: IResultadoClasseStCustoAquisicao;
var
  LResultadoCalculoSTCustoAquisicaoFinal : IResultadoCalculoSTCustoAquisicao;
begin
  LResultadoCalculoSTCustoAquisicaoFinal := ResultadoCalculoStCustoAquisicaoFinal;

  Result :=
    TResultadoClasseStCustoAquisicao.New
      .ResultadoCalculoStCustoAquisicao(LResultadoCalculoSTCustoAquisicaoFinal)
      .ParametrosCalculoStCustoAquisicao(FParametros.ParametrosCalculoStCustoAquisicao);
end;

constructor TServicosClasseStCustoAquisicao.Create(
  AParametros: IParametrosClasseStCustoAquisicao);
begin
  FParametros := AParametros;
end;

class function TServicosClasseStCustoAquisicao.New(
  AParametros: IParametrosClasseStCustoAquisicao): IServicosClasseStCustoAquisicao;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseStCustoAquisicao.ResultadoCalculoStCustoAquisicaoFinal: IResultadoCalculoStCustoAquisicao;
var
  LResultadoCalculoSTCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
begin
  LResultadoCalculoSTCustoAquisicao :=
    TCalculoImpostosSTCustoAquisicao.New
      .CalcularValorSTCustoAquisicao(FParametros.ParametrosCalculoStCustoAquisicao);

  Result :=
    TResultadoCalculoSTCustoAquisicao.New
      .BaseDaSTCustoAquisicao(LResultadoCalculoSTCustoAquisicao.BaseDaSTCustoAquisicao)
      .ValorDaSTCustoAquisicao(LResultadoCalculoSTCustoAquisicao.ValorDaSTCustoAquisicao)
      .ValorDoIcmsOperacoesProprias(LResultadoCalculoSTCustoAquisicao.ValorDoIcmsOperacoesProprias)
      .FatorPositivo(LResultadoCalculoSTCustoAquisicao.FatorPositivo)
      .FatorNegativo(LResultadoCalculoSTCustoAquisicao.FatorNegativo);
end;

end.
