unit Faturamento.Impostos.Servicos.Classe.IcmsOrgaoPublico;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsOrgaoPublico,
  Faturamento.Impostos.Tipos.Servicos.Classe.IcmsOrgaoPublico,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
  Faturamento.Impostos.Calculos.IcmsOrgaoPublico;

type
  TServicosClasseIcmsOrgaoPublico = class(TInterfacedObject, IServicosClasseIcmsOrgaoPublico)
  private
    FParametros: IParametrosClasseIcmsOrgaoPublico;

    function ResultadoCalculoIcmsOrgaoPublicoFinal: IResultadoCalculoIcmsOrgaoPublico;
  public
    function CalcularIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
    function CalcularIcmsOrgaoPublicoFinal: IResultadoClasseIcmsOrgaoPublico;

    constructor Create(AParametros: IParametrosClasseIcmsOrgaoPublico); overload;

    class function New(AParametros: IParametrosClasseIcmsOrgaoPublico): IServicosClasseIcmsOrgaoPublico;
  end;

implementation

{ TServicosClasseIcmsOrgaoPublico }

function TServicosClasseIcmsOrgaoPublico.CalcularIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
Var
  LResultadoCalculoIcmsOrgaoPublicoFinal: IResultadoCalculoIcmsOrgaoPublico;
begin
  LResultadoCalculoIcmsOrgaoPublicoFinal := ResultadoCalculoIcmsOrgaoPublicoFinal;

  Result :=
    TResultadoClasseIcmsOrgaoPublico.New
      .ResultadoCalculoIcmsOrgaoPublico(LResultadoCalculoIcmsOrgaoPublicoFinal)
      .ParametrosCalculoIcmsOrgaoPublico(FParametros.ParametrosCalculoIcmsOrgaoPublico);
end;

function TServicosClasseIcmsOrgaoPublico.CalcularIcmsOrgaoPublicoFinal: IResultadoClasseIcmsOrgaoPublico;
begin
  Result := CalcularIcmsOrgaoPublico;
end;

constructor TServicosClasseIcmsOrgaoPublico.Create(
  AParametros: IParametrosClasseIcmsOrgaoPublico);
begin
  FParametros := AParametros;
end;

class function TServicosClasseIcmsOrgaoPublico.New(AParametros: IParametrosClasseIcmsOrgaoPublico): IServicosClasseIcmsOrgaoPublico;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseIcmsOrgaoPublico.ResultadoCalculoIcmsOrgaoPublicoFinal: IResultadoCalculoIcmsOrgaoPublico;
var
  LResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico;
begin
  LResultadoCalculoIcmsOrgaoPublico := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(FParametros.ParametrosCalculoIcmsOrgaoPublico);

  Result :=
    TResultadoCalculoIcmsOrgaoPublico.New
      .ValorDoIcmsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem)
      .BaseDeIcmsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem)
      .TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(LResultadoCalculoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao)
      .TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(LResultadoCalculoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao)
      .ValorSeparadoDoIcmsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoIcmsDeOrgaoPublicoDoItem)
      .ValorSeparadoDoPisDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoPisDeOrgaoPublicoDoItem)
      .ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.ValorSeparadoDoCofinsDeOrgaoPublicoDoItem)
      .AliquotaDoIcmsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.AliquotaDoIcmsDeOrgaoPublicoDoItem)
      .ValorSeparadoDoPisDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.AliquotaDoPisDeOrgaoPublicoDoItem)
      .ValorSeparadoDoCofinsDeOrgaoPublicoDoItem(LResultadoCalculoIcmsOrgaoPublico.AliquotaDoCofinsDeOrgaoPublicoDoItem);
end;

end.
