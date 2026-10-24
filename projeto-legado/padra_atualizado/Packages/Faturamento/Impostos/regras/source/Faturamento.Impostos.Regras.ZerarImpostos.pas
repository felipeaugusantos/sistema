unit Faturamento.Impostos.Regras.ZerarImpostos;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos,
  Faturamento.Impostos.Interfaces.ZerarImpostos.Icms,
  Faturamento.Impostos.Tipos.ZerarImpostos.Icms,
  Faturamento.Impostos.Regras.ZerarImpostos.Icms,
  Faturamento.Impostos.Interfaces.Model;

type
  TRegraImpostosZerarImpostos = class(TInterfacedObject, IRegraImpostosZerarImpostos)
  private
    FParametros: IParametrosRegraZerarImpostos;
    FResultadoIcms: IResultadoRegraZerarImpostosIcms;
  public
    function SetarParametros(const AParametros: IParametrosRegraZerarImpostos): IRegraImpostosZerarImpostos; overload;

    //Regra para zerar icms
    function ZerarIcms: IRegraImpostosZerarImpostos; overload;

    function ZerarValorDoIcms: Boolean; overload;


    function ResultadoIcms: IResultadoRegraZerarImpostosIcms; overload;

    class function New(): IRegraImpostosZerarImpostos;
  end;

  function ZerarImpostos: IRegraImpostosZerarImpostos; StdCall;

implementation

function ZerarImpostos: IRegraImpostosZerarImpostos; StdCall;
begin
  Result := TRegraImpostosZerarImpostos.New;
end;

{ TRegraImpostosZerarImpostos }

class function TRegraImpostosZerarImpostos.New: IRegraImpostosZerarImpostos;
begin
  Result := Self.Create;
end;

function TRegraImpostosZerarImpostos.ZerarIcms: IRegraImpostosZerarImpostos;
begin
  Result := Self;

  FResultadoIcms :=
    TRegraImpostosZerarImpostosIcms.New
      .ZerarIcms(
        TParametrosRegraZerarImpostosIcms.New
          .AliquotaDeIcmsDoItem(FParametros.AliquotaDeIcmsDoItem)
          .BaseDeCalculoDoIcmsDoItem(FParametros.BaseDeCalculoDoIcmsDoItem)
          .ValorDoIcmsDoItem(FParametros.ValorDoIcmsDoItem)
          .SimplesNacional(FParametros.SimplesNacional)
          .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
          .OpcaoDeDocumento(FParametros.OpcaoDeDocumento)
          .TaxaBombeamentoPedidoOrcamento(FParametros.TaxaBombeamentoPedidoOrcamento)
          .OpcaoItensNFEspTinta(FParametros.OpcaoItensNFEspTinta)
          .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
          .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
          .EstadoDaEmpresa(FParametros.EstadoDaEmpresa)
          .CodigoDaSubstituicaoTributariaDoItem(FParametros.CodigoDaSubstituicaoTributariaDoItem)
          .EspecieDoDocumento(FParametros.EspecieDoDocumento)
          .ClassificacaoDeVenda(FParametros.ClassificacaoDeVenda)
          .DentroDoEstado(FParametros.DentroDoEstado)
          .EmpresaOptanteSimples(FParametros.EmpresaOptanteSimples)
          .ItemTributado(FParametros.ItemTributado)
          .ConfiguradoParaTrocarParaX41(FParametros.ConfiguradoParaTrocarParaX41)
          .TipoZerarIcms(FParametros.TipoZerarIcms)
          .CodigoDaSituacaoTributaria(FParametros.CodigoDaSituacaoTributaria)
          .ConfiguradoParaTrocarParaX41noParana(FParametros.ConfiguradoParaTrocarParaX41noParana)
          .TributaClienteZonaFranca(FParametros.TributaClienteZonaFranca)
      );
end;

function TRegraImpostosZerarImpostos.ZerarValorDoIcms: Boolean;
begin
  Result :=
    TRegraImpostosZerarImpostosIcms.New
      .ZerarValorDoIcms(
        TParametrosRegraZerarImpostosIcms.New
          .AliquotaDeIcmsDoItem(FParametros.AliquotaDeIcmsDoItem)
          .BaseDeCalculoDoIcmsDoItem(FParametros.BaseDeCalculoDoIcmsDoItem)
          .ValorDoIcmsDoItem(FParametros.ValorDoIcmsDoItem)
          .SimplesNacional(FParametros.SimplesNacional)
          .ClassificacaoFiscalDoItem(FParametros.ClassificacaoFiscalDoItem)
          .OpcaoDeDocumento(FParametros.OpcaoDeDocumento)
          .TaxaBombeamentoPedidoOrcamento(FParametros.TaxaBombeamentoPedidoOrcamento)
          .OpcaoItensNFEspTinta(FParametros.OpcaoItensNFEspTinta)
          .BaixaDeEntregaFutura(FParametros.BaixaDeEntregaFutura)
          .EntregaFuturaDoItem(FParametros.EntregaFuturaDoItem)
          .EstadoDaEmpresa(FParametros.EstadoDaEmpresa)
          .CodigoDaSubstituicaoTributariaDoItem(FParametros.CodigoDaSubstituicaoTributariaDoItem)
          .EspecieDoDocumento(FParametros.EspecieDoDocumento)
          .ClassificacaoDeVenda(FParametros.ClassificacaoDeVenda)
          .DentroDoEstado(FParametros.DentroDoEstado)
          .EmpresaOptanteSimples(FParametros.EmpresaOptanteSimples)
          .ItemTributado(FParametros.ItemTributado)
          .ConfiguradoParaTrocarParaX41(FParametros.ConfiguradoParaTrocarParaX41)
          .TipoZerarIcms(FParametros.TipoZerarIcms)
          .CodigoDaSituacaoTributaria(FParametros.CodigoDaSituacaoTributaria)
          .ConfiguradoParaTrocarParaX41noParana(FParametros.ConfiguradoParaTrocarParaX41noParana)
          .TributaClienteZonaFranca(FParametros.TributaClienteZonaFranca)
      );

end;

function TRegraImpostosZerarImpostos.ResultadoIcms: IResultadoRegraZerarImpostosIcms;
begin
  Result := FResultadoIcms;
end;

function TRegraImpostosZerarImpostos.SetarParametros(
  const AParametros: IParametrosRegraZerarImpostos): IRegraImpostosZerarImpostos;
begin
  Result := Self;
  FParametros := AParametros;
end;

exports ZerarImpostos;

end.
