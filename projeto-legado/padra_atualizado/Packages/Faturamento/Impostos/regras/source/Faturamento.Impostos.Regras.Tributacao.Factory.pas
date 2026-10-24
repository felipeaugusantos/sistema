unit Faturamento.Impostos.Regras.Tributacao.Factory;

interface

uses Faturamento.Impostos.Interfaces.Tributacao, Faturamento.Impostos.Tipos.Tributacao,
  Faturamento.Impostos.Regras.Tributacao;

type
  TFaturamentoImpostosRegrasTributacaoFactory = class(TInterfacedObject, IFaturamentoImpostosRegrasTributacaoFactory)
  private
    FParametros: IParametrosRegrasTributacao;
    FResultadoRegrasTributacao: IResultadoRegrasTributacao;
  public
    function Tributacao: IFaturamentoImpostosRegrasTributacaoFactory;
    function IcmsSt: IResultadoRegrasTributacaoIcmsSt;

    constructor Create(AParametros: IParametrosRegrasTributacao); overload;
    class function New(AParametros: IParametrosRegrasTributacao): IFaturamentoImpostosRegrasTributacaoFactory;
  end;

implementation

{ TFaturamentoImpostosRegrasTributacaoFactory }

constructor TFaturamentoImpostosRegrasTributacaoFactory.Create(
  AParametros: IParametrosRegrasTributacao);
begin
  FParametros := AParametros;
end;

function TFaturamentoImpostosRegrasTributacaoFactory.IcmsSt: IResultadoRegrasTributacaoIcmsSt;
begin
  Result :=
    TResultadoRegrasTributacaoIcmsSt.New
      .AliquotaDeIcms(FResultadoRegrasTributacao.AliquotaDeIcms)
      .PercentualDaBaseDeIcms(FResultadoRegrasTributacao.PercentualDaBaseDeIcms)
      .ValorIVAEspecialClienteMTIcms(FResultadoRegrasTributacao.ValorIVAEspecialClienteMTIcms)
      .AliquotaDeIcmsAnterior(FResultadoRegrasTributacao.AliquotaDeIcmsAnterior)
      .BaseDeCalculoDoIcmsAnterior(FResultadoRegrasTributacao.BaseDeCalculoDoIcmsAnterior)
      .ValorDoIcmsAnterior(FResultadoRegrasTributacao.ValorDoIcmsAnterior)
      .PercentualDeReducaoDaBaseDeIcms(FResultadoRegrasTributacao.PercentualDeReducaoDaBaseDeIcms)
      .ReducaoRICMPR(FResultadoRegrasTributacao.ReducaoRICMPR)
      .AliquotaDaSubstituicaoTributaria(FResultadoRegrasTributacao.AliquotaDaSubstituicaoTributaria)
      .ValorDoIva(FResultadoRegrasTributacao.ValorDoIva)
      .ValorDoIvaMatriz(FResultadoRegrasTributacao.ValorDoIvaMatriz)
      .ValorDoIvaStMatriz(FResultadoRegrasTributacao.ValorDoIvaStMatriz)
      .ValorIVAEspecialClienteMTSt(FResultadoRegrasTributacao.ValorIVAEspecialClienteMTSt)
      .ValorIcmsEstado(FResultadoRegrasTributacao.ValorIcmsEstado)
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FResultadoRegrasTributacao.PercentualDaBaseDaSubstituicaoTributariaDoItem)
      .BaseDaSubstituicaoTributariaSimulada(FResultadoRegrasTributacao.BaseDaSubstituicaoTributariaSimulada)
      .AliquotaDaSubstituicaoTributariaSimulada(FResultadoRegrasTributacao.AliquotaDaSubstituicaoTributariaSimulada)
      .ValorDaSubstituicaoTributariaSimulada(FResultadoRegrasTributacao.ValorDaSubstituicaoTributariaSimulada)
      .CodigoDaSubstituicaoTributariaDoItem(FResultadoRegrasTributacao.CodigoDaSubstituicaoTributaria)
      .AtendeRegrasAtoDeclaratorioDF(FResultadoRegrasTributacao.AtendeRegrasAtoDeclaratorioDF)
      .AliquotaReduzidaDaSt(FResultadoRegrasTributacao.AliquotaReduzidaDaSt)
      .STAtribuidaPorRegimeEspecial(FResultadoRegrasTributacao.STAtribuidaPorRegimeEspecial)
end;

class function TFaturamentoImpostosRegrasTributacaoFactory.New(AParametros: IParametrosRegrasTributacao): IFaturamentoImpostosRegrasTributacaoFactory;
begin
  Result := Self.Create(AParametros);
end;

function TFaturamentoImpostosRegrasTributacaoFactory.Tributacao: IFaturamentoImpostosRegrasTributacaoFactory;
begin
  Result := Self;

  FResultadoRegrasTributacao :=
    TFaturamentoImpostosRegrasTributacao.New(FParametros)
      .IniciarAliquotasEPercentuais
        .DentroOuForaDoEstado
          .ResultadoTributacao;
end;

end.
