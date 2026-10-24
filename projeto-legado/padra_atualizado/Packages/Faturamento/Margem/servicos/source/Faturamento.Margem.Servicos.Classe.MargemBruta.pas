unit Faturamento.Margem.Servicos.Classe.MargemBruta;

interface

uses System.SysUtils,
     Faturamento.Margem.Interfaces.Servicos.Classe.MargemBruta,
     Faturamento.Margem.Interfaces.MargemBruta,
     Faturamento.Margem.Tipos.MargemBruta,
     Shared.Functions.Configuracoes,
     Shared.Functions.Types,
     Faturamento.Margem.Calculos.MargemBruta;


type
  TFaturamentoMargemServicosClasseMargemBruta = class(TInterfacedObject, IFaturamentoMargemServicosClasseMargemBruta)
  private
    function RetornarResultadoServicosClasseMargemBruta(const AParametros: IParametrosCalculoMargemBruta) : IResultadoServicosClasseMargemBruta;

    function RetonarParametrosCalculoMargemBruta(const AParametros: IParametrosServicoMargemBruta):IParametrosCalculoMargemBruta;

    function RetornarResultadoServicosClasseMargemParaMarkup(const AParametros: IParametrosCalculoMargemParaMarkup) : IResultadoServicosClasseMargemBruta;

    function RetonarParametrosCalculoMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup):IParametrosCalculoMargemParaMarkup;

  public
    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;

    class function New(): IFaturamentoMargemServicosClasseMargemBruta;
  end;

implementation

{ TFaturamentoMargemServicosClasseMargemBruta}

function TFaturamentoMargemServicosClasseMargemBruta.CalculaMargemBruta(
  const AParametros: IParametrosServicoMargemBruta): IResultadoServicosClasseMargemBruta;
begin
  Result :=
    RetornarResultadoServicosClasseMargemBruta(
      RetonarParametrosCalculoMargemBruta(AParametros));

end;

function TFaturamentoMargemServicosClasseMargemBruta.CalculaMargemParaMarkup(
  const AParametros: IParametrosServicoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
begin
  Result :=
    RetornarResultadoServicosClasseMargemParaMarkup(
      RetonarParametrosCalculoMargemParaMarkup(AParametros));
end;

class function TFaturamentoMargemServicosClasseMargemBruta.New: IFaturamentoMargemServicosClasseMargemBruta;
begin
  Result := Self.Create;
end;

function TFaturamentoMargemServicosClasseMargemBruta.RetonarParametrosCalculoMargemBruta(
  const AParametros: IParametrosServicoMargemBruta): IParametrosCalculoMargemBruta;
begin
  Result :=
    TParametrosCalculoMargemBruta.New
      .ConfiguracaoMargemMarkup(AParametros.ConfiguracaoMargemMarkup)
      .PrecoDeCusto(AParametros.PrecoDeCusto)
      .PrecoDeVenda(AParametros.PrecoDeVenda)
      .ValorDaMargem(AParametros.ValorDaMargem)
      .IcmsDeSaida(AParametros.IcmsDeSaida)
      .ImpostosFederais(AParametros.ImpostosFederais)
      .DespesasOperacionais(AParametros.DespesasOperacionais)
      .PrecoDeCompra(AParametros.PrecoDeCompra)
      .ValorIcmsSt(AParametros.ValorIcmsSt)
      .CalcularST(AParametros.CalcularST)
      .ValorDifal(AParametros.ValorDifal)
      .ValorFCP(AParametros.ValorFCP);
end;

function TFaturamentoMargemServicosClasseMargemBruta.RetonarParametrosCalculoMargemParaMarkup(
  const AParametros: IParametrosServicoMargemParaMarkup): IParametrosCalculoMargemParaMarkup;
begin
  Result :=
    TParametrosCalculoMargemParaMarkup.New
      .ValorDaMargem(AParametros.ValorDaMargem);

end;

function TFaturamentoMargemServicosClasseMargemBruta.RetornarResultadoServicosClasseMargemBruta(
  const AParametros: IParametrosCalculoMargemBruta): IResultadoServicosClasseMargemBruta;
Var
  LResultadoCalculoMargemBruta : IResultadoCalculoMargemBruta;
begin
  LResultadoCalculoMargemBruta :=
    TCalculoMargemMargemBruta.New()
      .CalculaMargemBruta(AParametros);

  Result :=
    TResultadoServicosClasseMargemBruta.New()
      .ParametrosCalculoMargemBruta(AParametros)
      .ResultadoCalculoMargemBruta(LResultadoCalculoMargemBruta);
end;

function TFaturamentoMargemServicosClasseMargemBruta.RetornarResultadoServicosClasseMargemParaMarkup(
  const AParametros: IParametrosCalculoMargemParaMarkup): IResultadoServicosClasseMargemBruta;
begin
  Result :=
    TResultadoServicosClasseMargemBruta.New()
      .ParametrosCalculoMargemParaMarkup(AParametros)
      .ResultadoCalculoMargemParaMarkup(TCalculoMargemMargemBruta.New()
                                          .CalculaMargemParaMarkup(AParametros));
end;

end.
