unit Processar.Dados.Icms;

interface

uses Interfaces.Processar.Dados.Icms, Tipos.Processar.Dados.Icms,
  Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Tipos.Icms,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Types,
  Faturamento.Impostos.Interfaces.ZerarImpostos,
  Faturamento.Impostos.Tipos.ZerarImpostos, untFatCalcularImpostos,
  untFatRegrasImpostos, untParametrosResultadoIcms;

type
  TProcessarDadosIcms = class(TInterfacedObject, IProcessarDadosIcms)
  private
    FParametros: IParametrosProcessarDadosIcms;
    FResultadoZerarImpostos: IResultadoProcessarDadosIcms;
  public
    function ZerarIcms: IProcessarDadosIcms;
    function CalcularIcms: IResultadoProcessarDadosIcms;

    constructor Create(AParametros: IParametrosProcessarDadosIcms); overload;

    class function New(AParametros: IParametrosProcessarDadosIcms): IProcessarDadosIcms;
  end;

implementation

{ TProcessarDadosIcms }

function TProcessarDadosIcms.CalcularIcms: IResultadoProcessarDadosIcms;
var
  LResultadoCalculoIcms: IResultadoCalculoIcms;
  LParametrosCalculoIcms: IParametrosCalculoIcms;
begin
  //Parametros para o calculo
  LParametrosCalculoIcms :=
    TParametrosCalculoIcms.New
      .VendaDentroDoEstado(FParametros.VendaDentroDoEstado)
      .SubstituicaoTributariaDoItem(FParametros.SubstituicaoTributariaDoItem)
      .UtilizaImportacaoDireta(FParametros.UtilizaImportacaoDireta)
      .ItemImportacaoDireta(FParametros.ItemImportacaoDireta)
      .CalculaBeneficioReducaoBaseIcmsST(FParametros.CalculaBeneficioReducaoBaseIcmsST)
      .SimplesNacional(FParametros.SimplesNacional)
      .TotalGeralDoItem(FParametros.TotalGeralDoItem)
      .EntraIPINaBaseIcms(FParametros.EntraIPINaBaseIcms)
      .AliquotaDeIcmsDoItem(FResultadoZerarImpostos.AliquotaDoIcms)
      .ValorDoIpiDoItem(FParametros.ValorDoIpiDoItem)
      .PercentualDaBaseDeIcmsDoItem(FParametros.PercentualDaBaseDeIcmsDoItem)
      .UtilizarReducaoRICMPR(FParametros.UtilizarReducaoRICMPR);

  //Calcular o valor do icms
  LResultadoCalculoIcms :=
    CalcularValorICMS(LParametrosCalculoIcms,
                      FParametros.ParametrosResultadoIcms);

  Result :=
    TResultadoProcessarDadosIcms.New()
      .AliquotaDoIcms(LResultadoCalculoIcms.AliquotaDoIcms)
      .BaseDeCalculoDoIcms(LResultadoCalculoIcms.BaseDeCalculoDoIcms)
      .ValorCalculadoDoIcms(LResultadoCalculoIcms.ValorCalculadoDoIcms)
      .PercentualDaBaseDeIcms(LResultadoCalculoIcms.PercentualDaBaseDeIcms)
      .ValorDaDiferencaDeIcms(LResultadoCalculoIcms.ValorDaDiferencaDeIcms);
end;

constructor TProcessarDadosIcms.Create(
  AParametros: IParametrosProcessarDadosIcms);
begin
  FParametros := AParametros;
end;

class function TProcessarDadosIcms.New(
  AParametros: IParametrosProcessarDadosIcms): IProcessarDadosIcms;
begin
  Result := Self.Create(AParametros);
end;

function TProcessarDadosIcms.ZerarIcms: IProcessarDadosIcms;
var
  LZerarImpostosIcmsZonaFrancaOrgaoPublico: IRegraImpostosZerarImpostos;
  LZerarImpostosIcmsGeral: IRegraImpostosZerarImpostos;
  LZerarImpostosIcmsValorMenorIgualAZero: IRegraImpostosZerarImpostos;
begin
  Result := Self;

  //Zerar valor do icms = tziZonaFrancaOrgaoPublico
  LZerarImpostosIcmsZonaFrancaOrgaoPublico :=
    ZerarImpostos.SetarParametros(
      TParametrosRegraZerarImpostos.New
        .AliquotaDeIcmsDoItem(FParametros.AliquotaDeIcmsDoItem)
        .BaseDeCalculoDoIcmsDoItem(FParametros.BaseDeCalculoDoIcmsDoItem)
        .ValorDoIcmsDoItem(FParametros.ValorDoIcmsDoItem)
        .DentroDoEstado(FParametros.VendaDentroDoEstado)
        .TipoZerarIcms(tziZonaFrancaOrgaoPublico)
    ).ZerarIcms;

  //Zerar valor do icms = tziGeral
  LZerarImpostosIcmsGeral :=
    ZerarImpostos.SetarParametros(
      TParametrosRegraZerarImpostos.New
        .AliquotaDeIcmsDoItem(LZerarImpostosIcmsZonaFrancaOrgaoPublico.ResultadoIcms.AliquotaDeIcmsDoItem)
        .BaseDeCalculoDoIcmsDoItem(LZerarImpostosIcmsZonaFrancaOrgaoPublico.ResultadoIcms.BaseDeCalculoDoIcmsDoItem)
        .ValorDoIcmsDoItem(LZerarImpostosIcmsZonaFrancaOrgaoPublico.ResultadoIcms.ValorDoIcmsDoItem)
        .SimplesNacional(FParametros.SimplesNacional)
        .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
        .OpcaoDeDocumento(FParametros.OpcaoDeDocumento)
        .TaxaBombeamentoPedidoOrcamento(FParametros.TaxaBombeamentoPedidoOrcamento)
        .ClassificacaoFiscal(FParametros.ClassificacaoFiscal)
        .OpcaoItensNFEspTinta(FParametros.OpcaoItensNFEspTinta)
        .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
        .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
        .EstadoDaEmpresa(FParametros.EstadoDaEmpresa)
        .CodigoDaSubstituicaoTributariaDoItem(FParametros.CodigoDaSubstituicaoTributariaDoItem)
        .EspecieDoDocumento(FParametros.EspecieDoDocumento)
        .ClassificacaoDeVenda(FParametros.ClassificacaoDeVenda)
        .EmpresaOptanteSimples(FParametros.EmpresaOptanteSimples)
        .ItemTributado(FParametros.ItemTributado)
        .ConfiguradoParaTrocarParaX41(FParametros.ConfiguradoParaTrocarParaX41)
        .TipoZerarIcms(tziGeral)
    ).ZerarIcms;

  //Zerar valor do icms = tziValorMenorIgualAZero
  LZerarImpostosIcmsValorMenorIgualAZero :=
    ZerarImpostos.SetarParametros(
      TParametrosRegraZerarImpostos.New
        .AliquotaDeIcmsDoItem(LZerarImpostosIcmsGeral.ResultadoIcms.AliquotaDeIcmsDoItem)
        .BaseDeCalculoDoIcmsDoItem(LZerarImpostosIcmsGeral.ResultadoIcms.BaseDeCalculoDoIcmsDoItem)
        .ValorDoIcmsDoItem(LZerarImpostosIcmsGeral.ResultadoIcms.ValorDoIcmsDoItem)
        .TipoZerarIcms(tziValorMenorIgualAZero)
    ).ZerarIcms;

  FResultadoZerarImpostos :=
    TResultadoProcessarDadosIcms.New()
      .AliquotaDoIcms(LZerarImpostosIcmsValorMenorIgualAZero.ResultadoIcms.AliquotaDeIcmsDoItem)
      .BaseDeCalculoDoIcms(LZerarImpostosIcmsValorMenorIgualAZero.ResultadoIcms.BaseDeCalculoDoIcmsDoItem)
      .ValorCalculadoDoIcms(LZerarImpostosIcmsValorMenorIgualAZero.ResultadoIcms.ValorDoIcmsDoItem);
end;

end.
