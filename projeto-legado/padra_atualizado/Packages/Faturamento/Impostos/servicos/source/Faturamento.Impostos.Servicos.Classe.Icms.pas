unit Faturamento.Impostos.Servicos.Classe.Icms;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Icms,
  Faturamento.Impostos.Tipos.Servicos.Classe.Icms,
  Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Calculos.Icms,
  Faturamento.Impostos.Tipos.Icms, Faturamento.Impostos.Regras.ZerarImpostos.Icms;

type
  TServicosClasseIcms = class(TInterfacedObject, IServicosClasseIcms)
  private
    FParametros: IParametrosClasseIcms;
    FCalculouOValorDoIcms: Boolean;

    function ResultadoCalculoIcmsFinal: IResultadoCalculoIcms;
  public
    function CalcularIcms: IResultadoClasseIcms;
    function CalcularIcmsFinal(const AZerarValorDoIcms: Boolean): IResultadoClasseIcms;

    constructor Create(AParametros: IParametrosClasseIcms); overload;

    class function New(AParametros: IParametrosClasseIcms): IServicosClasseIcms;
  end;

implementation

{ TServicosClasseIcms }

function TServicosClasseIcms.CalcularIcms: IResultadoClasseIcms;
Var
  LResultadoCalculoIcmsFinal : IResultadoCalculoIcms;
begin
  FCalculouOValorDoIcms := True;

  LResultadoCalculoIcmsFinal := ResultadoCalculoIcmsFinal;

  Result :=
    TResultadoClasseIcms.New
      .ResultadoCalculoIcms(LResultadoCalculoIcmsFinal)
      .ParametrosCalculoIcms(FParametros.ParametrosCalculoIcms);
end;

function TServicosClasseIcms.CalcularIcmsFinal(const AZerarValorDoIcms: Boolean): IResultadoClasseIcms;
  Var
    LResultadoCalculoIcms  : IResultadoCalculoIcms;
    LBaseDeCalculoDoIcmsDoItemBenST: Double;
begin
  If AZerarValorDoIcms Then
  begin
    LResultadoCalculoIcms := TCalculoImpostosIcms.New.CalcularValorIcms(FParametros.ParametrosCalculoIcms);
    LBaseDeCalculoDoIcmsDoItemBenST := LResultadoCalculoIcms.BaseDeCalculoDoIcmsDoItemBenST;

    LResultadoCalculoIcms :=
      TResultadoCalculoIcms.New()
        .AliquotaDoIcms(0)
        .BaseDeCalculoDoIcms(0)
        .ValorCalculadoDoIcms(0)
        .PercentualDaBaseDeIcms(FParametros.RegrasTributacaoIcmsSt.PercentualDaBaseDeIcms)
        .ValorDaDiferencaDeIcms(0)
        .AliquotaDeIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.AliquotaDeIcmsAnterior)
        .BaseDeCalculoDoIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.BaseDeCalculoDoIcmsAnterior)
        .ValorDoIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.ValorDoIcmsAnterior)
        .PercentualDeReducaoDaBaseDeIcms(FParametros.RegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms)
        .ReducaoRICMPR(FParametros.RegrasTributacaoIcmsSt.ReducaoRICMPR)
        .TipoDaAbreviacaoFiscal(FParametros.ParametrosCalculoIcms.TipoDaAbreviacaoFiscal)
        .BaseDeCalculoDoIcmsDoItemBenST(LBaseDeCalculoDoIcmsDoItemBenST);

    Result :=
      TResultadoClasseIcms.New
        .ResultadoCalculoIcms(LResultadoCalculoIcms)
        .ParametrosCalculoIcms(FParametros.ParametrosCalculoIcms);

    Exit;
  end;

  Result := CalcularIcms;
end;

constructor TServicosClasseIcms.Create(AParametros: IParametrosClasseIcms);
begin
  FParametros := AParametros;
  FCalculouOValorDoIcms := False;
end;

class function TServicosClasseIcms.New(
  AParametros: IParametrosClasseIcms): IServicosClasseIcms;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseIcms.ResultadoCalculoIcmsFinal: IResultadoCalculoIcms;
var
  LResultadoCalculoIcms: IResultadoCalculoIcms;
begin
  LResultadoCalculoIcms := TCalculoImpostosIcms.New.CalcularValorIcms(FParametros.ParametrosCalculoIcms);

  Result :=
    TResultadoCalculoIcms.New
      .AliquotaDoIcms(LResultadoCalculoIcms.AliquotaDoIcms)
      .BaseDeCalculoDoIcms(LResultadoCalculoIcms.BaseDeCalculoDoIcms)
      .ValorCalculadoDoIcms(LResultadoCalculoIcms.ValorCalculadoDoIcms)
      .PercentualDaBaseDeIcms(LResultadoCalculoIcms.PercentualDaBaseDeIcms)
      .ValorDaDiferencaDeIcms(LResultadoCalculoIcms.ValorDaDiferencaDeIcms)
      .AliquotaDeIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.AliquotaDeIcmsAnterior)
      .BaseDeCalculoDoIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.BaseDeCalculoDoIcmsAnterior)
      .ValorDoIcmsAnterior(FParametros.RegrasTributacaoIcmsSt.ValorDoIcmsAnterior)
      .PercentualDeReducaoDaBaseDeIcms(FParametros.RegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms)
      .ReducaoRICMPR(FParametros.RegrasTributacaoIcmsSt.ReducaoRICMPR)
      .TipoDaAbreviacaoFiscal(FParametros.ParametrosCalculoIcms.TipoDaAbreviacaoFiscal)
      .EntraIPINaBaseIcms(LResultadoCalculoIcms.EntraIPINaBaseIcms)
      .BaseDeCalculoDoIcmsDoItemBenST(LResultadoCalculoIcms.BaseDeCalculoDoIcmsDoItemBenST);
end;

end.
