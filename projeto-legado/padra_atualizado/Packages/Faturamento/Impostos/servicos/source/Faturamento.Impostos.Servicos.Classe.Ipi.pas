unit Faturamento.Impostos.Servicos.Classe.Ipi;

interface

uses System.SysUtils, Faturamento.Impostos.Interfaces.Servicos.Classe.Ipi,
  Faturamento.Impostos.Interfaces.Ipi, Faturamento.Impostos.Tipos.Ipi,
  Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Calculos.Ipi,
  Shared.Functions.Core, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes,
  Faturamento.Model.Cliente,Faturamento.Model.Fornecedor,
  Faturamento.Model.Empresa, Faturamento.Model.Produto,
  Shared.Functions.DataSet, Shared.Functions.Types, Shared.Functions.Faturamento.Impostos.Regras,
  Shared.Functions.Faturamento.Impostos.Regras.ZerarImpostos,
  Faturamento.Impostos.Servicos.Funcoes;


type
  TFaturamentoImpostosServicosClasseIpi = class(TInterfacedObject, IFaturamentoImpostosServicosClasseIpi)
  private
    FParametros : IParametrosServicoIPI;
    FDocumentoParaFornecedor : Boolean;

    FModelClienteFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    FModelProduto : IResultadoFaturamentoImpostosModelProduto;

    procedure SetarModelClienteFornecedor;
    procedure SetarModelEmpresa;
    procedure SetarModelProduto;

    function RetornarClassificacaoDeVenda : String ;
    Function ValidarConfirmacaoNotaFiscalConcreto : Boolean;
    Function TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento              : String;
                                            AConfirmandoNotaFiscalConcreto : Boolean;
                                            AItemConcreto                  : Boolean) : Boolean;
    Function EhItemConcreto: Boolean;
    Function ZerarEspecie : String;
    Function TemMIFFEntreOsDevolvidos : Boolean;
    Function RetornarEspecieDeDocumento : String;
    Function ZerarIpiMIFF : Boolean;
    Function ZerarValorFinalDoIpi: Boolean;
    Function ZerarValorDoIpi: Boolean;
    function ZerarMeiaNotaParaDocumentosMIFF : Boolean;
    function ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto : Boolean;
    function ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota : Boolean;

    function ValorDaAliquotaDeCalculoIpi : Double;

    function RetornarTrocaUFEndEntrega: String;
    function ParametrosCalculoIPI(const AEstadoEntrega: String; const AValorBaseDoIpi: Double; const AValorDaAliquotaIpi: Double): IParametrosCalculoIPI;
    function ZerarResultadosIpiRetornandoAliquota: IResultadoServicosClasseIpi;
    function ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(const AValorCalculadoIPIConsignacao: double): IResultadoServicosClasseIpi;
    function ZerarResultadosIpiZerandoAliquota: IResultadoServicosClasseIpi;
    function ZerarResultadosIpi(Const AAliquotaIpi: double): IResultadoServicosClasseIpi;
    function ValidarSeDeveRetornarAliquotaZero: boolean;
  public
    function CalcularValorIpi: IResultadoServicosClasseIpi;
    function CalcularValorIpiProduto: IResultadoServicosClasseIpi;
    function CalcularValorIpiFinal: IResultadoServicosClasseIpi;
    function CalcularValorIpiEntrada: Double;
    function ZeraValorIpiEntrada: Boolean;

    class function New(AParametros: IParametrosServicoIPI): IFaturamentoImpostosServicosClasseIpi;

    constructor Create(AParametros: IParametrosServicoIPI); overload;
  end;

implementation

{ TFaturamentoImpostosServicosClasseIpi }

function TFaturamentoImpostosServicosClasseIpi.ZeraValorIpiEntrada: Boolean;
begin
  Result := False;

  If not (objConfiguracoes.fGetValorConfiguracao(CFG_MODELO_DE_CALCULO_DECRETO_REDUCAO_BASE_IMPOSTOS) = 2) Then
    Exit;

  If objCore.fEmptyStr(FModelProduto.CodigoDoFornecedorDaUltimaCompra) Then
    Exit;

  If not (FModelProduto.TipoDoFornecedorDaUltimaCompra <> 'I') Then
    Exit;

  Result := True;
end;

function TFaturamentoImpostosServicosClasseIpi.CalcularValorIpiEntrada: Double;
begin

  If ZeraValorIpiEntrada Then
  Begin
    Result := 0;
    Exit;
  End;

  Result := objCore.fFormataFloat((FParametros.TotalGeralDoItemPreUlt * FModelProduto.IpiDeEntrada) / 100, 2);
end;

function TFaturamentoImpostosServicosClasseIpi.CalcularValorIpi: IResultadoServicosClasseIpi;
Var
  LValorDaAliquotaIpi   : Double;
  LPercentualDaBase     : Double;
  LValorBaseDoIpi       : Double;
  LResultadoAbreviacao  : IResultadoAbreviacaoIpi;
  LParametrosCalculoIPI : IParametrosCalculoIPI;
  LResultadoCalculoIPI  : IResultadoCalculoIPI;
begin
  if (ZerarValorDoIpi) then
  Begin
    result := ZerarResultadosIpiZerandoAliquota;
    Exit;
  End;

  LResultadoAbreviacao :=
    TFaturamentoImpostosServicosFuncoes.
      CarregarDadosIpi(FParametros.EspecieDoDocumento,
                       FParametros.ClassificacaoFiscalDoItem,
                       FParametros.CodigoDoProduto,
                       FParametros.CodigoDaEmpresa,
                       FModelProduto.IpiDeSaida,
                       FModelClienteFornecedor.SituacaoDoIpi);


  LValorDaAliquotaIpi := LResultadoAbreviacao.AliquotaDeCalculoIPI;
  LPercentualDaBase   := LResultadoAbreviacao.BaseDeCalculoIPI;

  LValorBaseDoIpi     := 0;

  If LValorDaAliquotaIpi > 0 Then
  begin
    LValorBaseDoIpi :=
          TFunctionFuncoesFaturamento.
            TotalGeralItem(FParametros.ClienteConsumidorFinal,
                           FParametros.DescontoEspecial,
                           FParametros.ValorFreteDoItem,
                           FParametros.TotalGeralDoItem,
                           FParametros.DespesaAcessoriaDoItem,
                           FModelClienteFornecedor.OrgaoPublico,
                           FModelClienteFornecedor.ZonaFranca,
                           TFaturamentoImpostosServicosFuncoes.
                             VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                                                 FModelEmpresa.EmpresaEstado,
                                                 FParametros.VendaPresencial),
                           FParametros.OpcaoDoDocumento,
                           false,
                           true,
                           false);
  end;


  If objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, varBoolean) Then
  begin
    LValorBaseDoIpi := objCore.fFormataFloat(LValorBaseDoIpi * LPercentualDaBase / 100, 2);
  end;

  LParametrosCalculoIPI := ParametrosCalculoIPI(RetornarTrocaUFEndEntrega, LValorBaseDoIpi, LValorDaAliquotaIpi);

  LResultadoCalculoIPI :=
    TCalculoImpostosIPI.New.
      CalcularValorIPI(LParametrosCalculoIPI);

  Result :=
    TResultadoServicosClasseIpi.New
      .ResultadoCalculoIPI(LResultadoCalculoIPI)
      .ParametrosCalculoIPI(LParametrosCalculoIPI);
end;


function TFaturamentoImpostosServicosClasseIpi.RetornarTrocaUFEndEntrega : String;
begin
  Result :=
    TFaturamentoImpostosServicosFuncoes.
      RetornarTrocaUFEndEntrega(FModelClienteFornecedor,
                                FParametros.CodigoDaEmpresa,
                                FParametros.OpcaoDoDocumento,
                                FDocumentoParaFornecedor);

end;

function TFaturamentoImpostosServicosClasseIpi.ZerarResultadosIpi(Const AAliquotaIpi: double): IResultadoServicosClasseIpi;
var
  LResultadoCalculoIPI  : IResultadoCalculoIPI;
  LParametrosCalculoIPI : IParametrosCalculoIPI;
begin
  LParametrosCalculoIPI :=
    ParametrosCalculoIPI(RetornarTrocaUFEndEntrega, 0, AAliquotaIpi);

  LResultadoCalculoIPI :=
    TResultadoCalculoIPI.New()
      .ValorCalculadoIPI(0)
      .BaseDeCalculoIPI(0)
      .AliquotaDeCalculoIPI(AAliquotaIpi)
      .ValorCalculadoIPIConsignacao(0);

  Result :=
    TResultadoServicosClasseIpi.New
      .ResultadoCalculoIPI(LResultadoCalculoIPI)
      .ParametrosCalculoIPI(LParametrosCalculoIPI);
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarResultadosIpiRetornandoAliquota: IResultadoServicosClasseIpi;
var
  LAliquota: Double;
begin
  LAliquota := ValorDaAliquotaDeCalculoIpi;
  Result := ZerarResultadosIpi(LAliquota);
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(const AValorCalculadoIPIConsignacao: double): IResultadoServicosClasseIpi;
begin
  Result := ZerarResultadosIpiRetornandoAliquota;
  Result.ResultadoCalculoIPI.ValorCalculadoIPIConsignacao(AValorCalculadoIPIConsignacao);
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarResultadosIpiZerandoAliquota: IResultadoServicosClasseIpi;
begin
  result := ZerarResultadosIpi(0);
end;

function TFaturamentoImpostosServicosClasseIpi.CalcularValorIpiFinal: IResultadoServicosClasseIpi;
begin
  If ZerarValorFinalDoIpi Then
  Begin
    result := ZerarResultadosIpiRetornandoAliquota;
    Exit;
  End;

  if TFunctionsZerarImpostosRegrasImpostosFaturamento.fZerarIpiFaturamentoConsignacao(FParametros.ClassificacaoFiscalDoItem) then
  begin
    result := ZerarResultadosIpiRetornandoAliquotaSetandoIpiConsignado(CalcularValorIpi.ResultadoCalculoIPI.ValorCalculadoIPI);
    Exit;
  end;

  Result := CalcularValorIpi;
end;

function TFaturamentoImpostosServicosClasseIpi.CalcularValorIpiProduto: IResultadoServicosClasseIpi;
Var
  LValorDaAliquotaIpi : Double;
  LValorBaseDoIpi     : Double;
  LParametrosCalculoIPI : IParametrosCalculoIPI;
  LResultadoCalculoIPI  : IResultadoCalculoIPI;
begin
  if (ZerarValorDoIpi) then
  Begin
    result := ZerarResultadosIpiZerandoAliquota;
    Exit;
  End;

  LValorDaAliquotaIpi := FModelProduto.IpiDeSaida;
  LValorBaseDoIpi     := FParametros.TotalGeralDoItem;

  LParametrosCalculoIPI :=
    ParametrosCalculoIPI(FModelClienteFornecedor.ClienteEstado, LValorBaseDoIpi, LValorDaAliquotaIpi);

  LResultadoCalculoIPI :=
      TCalculoImpostosIPI.New.
        CalcularValorIPI(LParametrosCalculoIPI);

  Result :=
    TResultadoServicosClasseIpi.New
      .ResultadoCalculoIPI(LResultadoCalculoIPI)
      .ParametrosCalculoIPI(LParametrosCalculoIPI);
end;

constructor TFaturamentoImpostosServicosClasseIpi.Create(
  AParametros: IParametrosServicoIPI);
begin
  FParametros := AParametros;

   FDocumentoParaFornecedor :=
    TFunctionFuncoesFaturamento.
      fDocumentoParaFornecedor(FParametros.OpcaoDoDocumento,
                               FParametros.NotaComplementoFornecedor,
                               FParametros.NotaEspecialFornecedor,
                               SameText(TFaturamentoImpostosServicosFuncoes.RetornarNotaDeImportacao(FParametros.ClassificacaoFiscalDoItem), 'S'),
                               FParametros.CodigoDoCliente,
                               FParametros.CodigoDoFornecedor);


  SetarModelClienteFornecedor;
  SetarModelEmpresa;
  SetarModelProduto;
end;

function TFaturamentoImpostosServicosClasseIpi.EhItemConcreto: Boolean;
Var
  LEhItemEstrutura : Boolean;
  LCount           : IMyCampoTabela;
  LItemConcreto    : Boolean;
  LSimplesRemessaConcretoDadosCliente : Boolean;
begin

  LCount :=
    objCore.fCampoTabela(['COUNT(*)'], 'GERMAT', ['GMT_CODITE'], [FParametros.CodigoDoProduto], False);

  LEhItemEstrutura :=
    TFunctionFuncoesFaturamento.
      fItemEstrutura(LCount.FieldByName('COUNT(*)'));

  LItemConcreto :=
    TFunctionFuncoesFaturamento.
      fItemConcreto(LEhItemEstrutura, '' , FModelProduto.ItemConcreto);

  LSimplesRemessaConcretoDadosCliente :=
    (objConfiguracoes.fGetValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL) = CONCREMASSA);

  Result :=
    TFunctionFuncoesFaturamento.
      fEhItemConcreto( LSimplesRemessaConcretoDadosCliente,
                       LItemConcreto);
end;

class function TFaturamentoImpostosServicosClasseIpi.New(
  AParametros: IParametrosServicoIPI): IFaturamentoImpostosServicosClasseIpi;
begin
  Result := Self.Create(AParametros);
end;

function TFaturamentoImpostosServicosClasseIpi.ParametrosCalculoIPI(const AEstadoEntrega: String; const AValorBaseDoIpi: Double; const AValorDaAliquotaIpi: Double): IParametrosCalculoIPI;
begin
  Result :=
    TParametrosCalculoIPI.New()
      .ClienteZonaFranca(FModelClienteFornecedor.ZonaFranca)
      .ClienteOrgaoPublico(FModelClienteFornecedor.OrgaoPublico)
      .ClienteDoExterior(FModelClienteFornecedor.ClienteExterior)
      .VendaDentroDoEstado(
        TFaturamentoImpostosServicosFuncoes.
          VendaDentroDoEstado(AEstadoEntrega,
                              FModelEmpresa.EmpresaEstado,
                              FParametros.VendaPresencial))
      .SituacaoTributariaIPI(FModelClienteFornecedor.SituacaoDoIpi)
      .BaseDoIpi(AValorBaseDoIpi)
      .AliquotaDeCalculoIPI(AValorDaAliquotaIpi);
end;


function TFaturamentoImpostosServicosClasseIpi.RetornarClassificacaoDeVenda: String;
Var
  LCfgClassificacaoVenda : String;
begin
  LCfgClassificacaoVenda := objConfiguracoes.fGetValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA );

  Result := TFunctionFuncoesFaturamento.Transform(LCfgClassificacaoVenda, 4);
end;

function TFaturamentoImpostosServicosClasseIpi.RetornarEspecieDeDocumento: String;
begin
  Result := FParametros.EspecieDoDocumento;

  if Not (Result = EmptyStr) Then
    Exit;

  Result := FParametros.OpcaoDoDocumento;
end;


procedure TFaturamentoImpostosServicosClasseIpi.SetarModelClienteFornecedor;
begin
  if FDocumentoParaFornecedor Then
  begin
    FModelClienteFornecedor :=
      TFaturamentoImpostosModelFornecedor.New.Consultar(FParametros.CodigoDoCliente);
    Exit;
  end;

  FModelClienteFornecedor :=
    TFaturamentoImpostosModelCliente.New.Consultar(FParametros.CodigoDoCliente, FParametros.SequencialEnderecoEntrega, FParametros.GerandoCasosTestes, FParametros.ClienteConsumidorFinal, FParametros.ParametrosClienteConsumidor, FParametros.CodigoDaFazenda);
end;

procedure TFaturamentoImpostosServicosClasseIpi.SetarModelEmpresa;
begin
  FModelEmpresa :=
    TFaturamentoImpostosModelEmpresa.New.Consultar(FParametros.CodigoDaEmpresa);
end;

procedure TFaturamentoImpostosServicosClasseIpi.SetarModelProduto;
begin
  FModelProduto :=
    TFaturamentoImpostosModelProduto.New.Consultar(FParametros.CodigoDoProduto, FParametros.CodigoDaEmpresa, '', EmptyStr, FParametros.GerandoCasosTestes);
end;

function TFaturamentoImpostosServicosClasseIpi.TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento              : String;
                                                                              AConfirmandoNotaFiscalConcreto : Boolean;
                                                                              AItemConcreto                  : Boolean): Boolean;
begin
  Result :=
    TFunctionFuncoesFaturamento.
       TaxaBombeamentoPedidoOrcamento(AOpcaoDeDocumento, AConfirmandoNotaFiscalConcreto, AItemConcreto);
end;

function TFaturamentoImpostosServicosClasseIpi.TemMIFFEntreOsDevolvidos: Boolean;
begin
  Result := true;

  If TFunctionFuncoesFaturamento.ValidarDocumentosMIFF(FParametros.EspecieDeDevolucao) Then
    Exit;

  Result := False;;
end;

function TFaturamentoImpostosServicosClasseIpi.ValidarConfirmacaoNotaFiscalConcreto: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.
              ValidarConfirmacaoNotaFiscalConcreto(EhItemConcreto,
                                                   FParametros.DesmembrarNotaProdutosServicos,
                                                   FParametros.OpcaoDoDocumento);
end;

function TFaturamentoImpostosServicosClasseIpi.ValidarSeDeveRetornarAliquotaZero: boolean;
begin
  result := False;

  if (not FParametros.BaixaDeEntregaFutura) then
    Exit;

  if not objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, varBoolean) then
    Exit;

  result := True;
end;


function TFaturamentoImpostosServicosClasseIpi.ValorDaAliquotaDeCalculoIpi: Double;
begin
  result := 0;

  if (ValidarSeDeveRetornarAliquotaZero) then
    Exit;

  Result :=
    TFaturamentoImpostosServicosFuncoes.
      CarregarDadosIpi(FParametros.EspecieDoDocumento,
                       FParametros.ClassificacaoFiscalDoItem,
                       FParametros.CodigoDoProduto,
                       FParametros.CodigoDaEmpresa,
                       FModelProduto.IpiDeSaida,
                       FModelClienteFornecedor.SituacaoDoIpi).AliquotaDeCalculoIPI;
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarEspecie: String;
begin
  Result :=
    TFunctionFuncoesFaturamento.
      IsentaImpostosEspeciesZerar(FParametros.DesmembrarMeiaNotaComNotaNormal);
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto: Boolean;
begin
  Result := false;

  If Not TFunctionsRegrasImpostosFaturamento.
           IsentaImpostosEspeciesZerarBaixaEntregaFuturaVendaItemConcreto(FParametros.EspecieDoDocumento,
                                                                          ZerarEspecie,
                                                                          FParametros.OpcaoDoDocumento,
                                                                          FModelClienteFornecedor.OrgaoPublico ,
                                                                          FModelClienteFornecedor.ZonaFranca,
                                                                          FParametros.BaixaDeEntregaFutura,
                                                                          FParametros.EntregaFutura ,
                                                                          EhItemConcreto,
                                                                          FParametros.DesmembrarNotaProdutosServicos)then
  Begin
    Exit;
  End;

  If Not ZerarIpiMIFF Then
    Exit;

  Result := true;
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarIpiMIFF: Boolean;
begin
  Result := TFunctionFuncoesFaturamento.ZerarIpi(RetornarEspecieDeDocumento,
                                                 TemMIFFEntreOsDevolvidos,
                                                 FParametros.OpcaoDoDocumento,
                                                 FParametros.TipoDePedidoFaturamento,
                                                 FParametros.BaixaDeEntregaFutura,
                                                 FParametros.TipoDeBaixaEntregaFutura,
                                                 FParametros.OpcaoDoDocumentoVerdadeira);
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarMeiaNotaParaDocumentosMIFF: Boolean;
begin
  Result := False;

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.DesmembrarMeiaNotaComNotaNormalFatorExpedicao(
    FParametros.DesmembrarMeiaNotaComNotaNormal, FParametros.EspecieDoDocumento, FParametros.MeiaNotaFatorExpedicao) Then
    Exit;

  If Not ZerarIpiMIFF Then
    Exit;

  Result := true;
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota: Boolean;
Var
  LTaxaBombeamentoPedOrc: Boolean;
begin
  Result := false;

  LTaxaBombeamentoPedOrc :=
    TaxaBombeamentoPedidoOrcamento(FParametros.OpcaoDoDocumento,
                                   ValidarConfirmacaoNotaFiscalConcreto,
                                   EhItemConcreto);

  If Not TFunctionsZerarImpostosRegrasImpostosFaturamento.
            fClienteZonaFrancaOuConfirmacaoDeCupomEmNota(FParametros.ClassificacaoFiscalDoItem,
                                                         FParametros.OpcaoDoDocumento,
                                                         LTaxaBombeamentoPedOrc,
                                                         FParametros.ClassificacaoFiscalDoItem,
                                                         FParametros.OpcaoDeItemNfEspiritoSanto,
                                                         RetornarClassificacaoDeVenda,
                                                         FModelClienteFornecedor.ClienteEstado,
                                                         FModelClienteFornecedor.ZonaFranca,
                                                         TFaturamentoImpostosServicosFuncoes.VendaDentroDoEstado(RetornarTrocaUFEndEntrega,
                                                                                                                 FModelEmpresa.EmpresaEstado,
                                                                                                                 FParametros.VendaPresencial)) Then
  Begin
    Exit;
  End;

  Result := true;
end;

function TFaturamentoImpostosServicosClasseIpi.ZerarValorDoIpi: Boolean;
begin
  Result := False;

  If Not FParametros.BaixaDeEntregaFutura Then
    Exit;

  {******************************************************}
  {* CFG_ENFUOP no momento da emissão da entrega futura *}
  {*REQ.144458****************************************RP*}
  If FParametros.TipoDeBaixaEntregaFutura = '2' Then
    Exit;

  Result := True;
end;

Function TFaturamentoImpostosServicosClasseIpi.ZerarValorFinalDoIpi : Boolean;
begin
  Result := True;

  if (ZerarValorDoIpi) then
    Exit;

  If ZerarParaClienteZonaFrancaOuConfirmacaoDeCupomEmNota Then
    Exit;

  If TFunctionsRegrasImpostosFaturamento.
    fClassificacaoEnvioOuRetornoMercadoriaConsertoGarantia(FParametros.ClassificacaoFiscalDoItem) Then
  Begin
    Exit;
  End;

  If ZerarMeiaNotaParaDocumentosMIFF Then
    Exit;

  If ZerarEspeciesIsentaBaixaEntregaFuturaDeVendaParaItemConcreto Then
    Exit;

  Result := false;
end;


end.
