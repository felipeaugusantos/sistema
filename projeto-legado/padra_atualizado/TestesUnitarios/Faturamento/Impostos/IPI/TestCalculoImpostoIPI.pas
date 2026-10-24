unit TestCalculoImpostoIPI;

interface

uses
  TestFramework,
  Shared.Functions.Configuracoes,
  Shared.Functions.Core,
  untConsultaModelFaturamento;

type
  TestTCalculoImpostoIPI = class(TTestCase)
  strict private
    FConsultaModel: IConsultaModelFaturamento;
    procedure SetarConfiguracoesDefault;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularValorIPI_ClienteOrgaoPublico_E_EmpresaSimplesNacional_E_VendaDentroDoEstado;
    procedure TestCalcularValorIPI_ClienteNaoEOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;

    procedure TestCalcularValorIPI_ClienteOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
    procedure TestCalcularValorIPI_ClienteOrgaoPublico_E_EmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;

    procedure TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_VendaDentroDoEstado;
    procedure TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_EmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
    procedure TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_EmpresaSimplesNacional_E_VendaDentroDoEstado;

    procedure TestCalcularValorIPI_RetornaValorExato;
    procedure TestCalcularValorIPI_ZonaFranca;
    procedure TestCalcularValorIPI_NaoEZonaFranca;
    procedure TestCalcularValorIPI_SubstituicaoTributariaDiferenteDeTributado;
    procedure TestCalcularValorIPI_ClienteDoExterior;
    procedure TestCalcularValorIPI_AliquotaDeCalculoNegativa;
    procedure TestCalcularValorIPI_AliquotaDeCalculoZerada;
    procedure TestCalcularValorIPI_ValorCalculadoIPIEBaseDoIPIMaiorQueZero;
    procedure TestCalcularValorIPI_ValorCalculadoIPIEBaseDoIPIExatos;

    procedure TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoTrue_ClienteExteriorFalse_Trib;
    procedure TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoFalse_ClienteExteriorFalse_Trib;
    procedure TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoTrue_ClienteExteriorFalse_Valores;
    procedure TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoFalse_ClienteExteriorFalse_Valores;

    procedure TestCalcularValorIPI_ValorCalculadoIPIBaseDoIPIAliquotaIPIExatos;

    procedure TestRegimeNormalClienteTributaProdutoTributaDentroEstado;
    procedure TestRegimeNormalClienteIsentoProdutoTributaDentroEstado;
    procedure TestRegimeNormalClienteTributaProdutoIsentaDentroEstado;
    procedure TestRegimeNormalClienteIsentaProdutoIsentaDentroEstado;

    procedure TestSimplesNacClienteTributaProdutoTributaDentroEstado;
    procedure TestSimplesNacClienteIsentoProdutoTributaDentroEstado;
    procedure TestSimplesNacClienteTributaProdutoIsentaDentroEstado;
    procedure TestSimplesNacClienteIsentaProdutoIsentaDentroEstado;

    procedure TestRegimeNormalOrgaoPublicoTributaProdutoTributaForaEstado;
    procedure TestRegimeNormalOrgaoPublicoIsentoProdutoTributa;
    procedure TestRegimeNormalOrgaoPublicoTributaProdutoIsentaDentroEstado;
    procedure TestRegimeNormalOrgaoPublicoIsentaProdutoIsenta;

    procedure TestSimplesNacOrgaoPublicoTributaProdutoTributaDentroEstado;
    procedure TestSimplesNacOrgaoPublicoTributaProdutoTributaForaEstado;
    procedure TestSimplesNacOrgaoPublicoIsentoProdutoTributa;
    procedure TestSimplesNacOrgaoPublicoTributaProdutoIsentaDentroEstado;
    procedure TestSimplesNacOrgaoPublicoIsentaProdutoIsenta;

    procedure TestRegimeNormalZonaFrancaTributaProdutoTributaDentroEstado;
    procedure TestRegimeNormalZonaFrancaTributaProdutoTributaForaEstado;
    procedure TestRegimeNormalZonaFrancaIsentoProdutoTributa;
    procedure TestRegimeNormalZonaFrancaTributaProdutoIsentaDentroEstado;
    procedure TestRegimeNormalZonaFrancaIsentaProdutoIsenta;

    procedure TestZerarDadosIpiZerandoAliquota;
    procedure TestZerarDadosIpiSemZerarAliquota;

    procedure TestCalcularValorIpiFinalAbrvForaEstado;
    procedure TestCalcularValorIpiFinalAbrvForaEstadoCfopNaoVenda;
    procedure TestCalcularValorIpiFinalForaEstado;
    procedure TestCalcularValorIpiFinalForaEstadoOutrasSaidasRemessaDeposito;
    procedure TestCalcularValorIpiFinalForaEstadoOutrasSaidasRemessaDepositoZeraRemessa;
  end;

implementation

uses untTypesIPI, untCalculoImpostoIPI, SysUtils, untConsultaModelFaturamentoMemory,
  untFuncFatTypes, Shared.Functions.Types, Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model, Controller.Faturamento.Tipos.Impostos.Parametros.Comum,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum, untTestObjMyCampoTabela,
  untConstantes, untConsultaModelClienteFornecedorMemory, untFactoryClienteFornecedorMemory,
  Shared.Functions.Constantes, untFuncoes, untConsultaModelEmpresaMemory, untFactoryEmpresaMemory,
  untConsultaModelProdutoMemory, untFactoryProdutoMemory;

{ TestTCalculoImpostoIPI }

procedure TestTCalculoImpostoIPI.TestRegimeNormalClienteIsentaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacClienteIsentaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := True;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalClienteIsentoProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacClienteIsentoProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalClienteTributaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacClienteTributaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalClienteTributaProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 10);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestZerarDadosIpiSemZerarAliquota;
  Var
    FMatItens   : TMatrizFechamento;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].fltValIpi := 100;
    FMatItens[0].fltBasIpi := 10;
    FMatItens[0].fltAlqIpi := 10;

    objCalculoImpostosIPI.ZerarDadosIpi(False, FMatItens, 0);

    CheckTrue(FMatItens[0].fltValIpi = 0);
    CheckTrue(FMatItens[0].fltBasIpi = 0);
    CheckTrue(FMatItens[0].fltAlqIpi = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestZerarDadosIpiZerandoAliquota;
  Var
    FMatItens   : TMatrizFechamento;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].fltValIpi := 100;
    FMatItens[0].fltBasIpi := 10;
    FMatItens[0].fltAlqIpi := 10;

    objCalculoImpostosIPI.ZerarDadosIpi(True, FMatItens, 0);

    CheckTrue(FMatItens[0].fltValIpi = 0);
    CheckTrue(FMatItens[0].fltBasIpi = 0);
    CheckTrue(FMatItens[0].fltAlqIpi = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalOrgaoPublicoIsentaProdutoIsenta;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalOrgaoPublicoIsentoProdutoTributa;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalOrgaoPublicoTributaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalOrgaoPublicoTributaProdutoTributaForaEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 10);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalZonaFrancaIsentaProdutoIsenta;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ZonaFranca(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalZonaFrancaIsentoProdutoTributa;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .ZonaFranca(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := True;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalZonaFrancaTributaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ZonaFranca(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalZonaFrancaTributaProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ZonaFranca(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestRegimeNormalZonaFrancaTributaProdutoTributaForaEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ZonaFranca(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacClienteTributaProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 10);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacOrgaoPublicoIsentaProdutoIsenta;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacOrgaoPublicoIsentoProdutoTributa;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPIIsento)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacOrgaoPublicoTributaProdutoIsentaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(0);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 0);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 0);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 0);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacOrgaoPublicoTributaProdutoTributaDentroEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
    LConsumidorFinal : Boolean;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('SP');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := True;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 10);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestSimplesNacOrgaoPublicoTributaProdutoTributaForaEstado;
  var
    AParametros: TParametrosCalculoValorIpi;
    ReturnValue : TResultadoCalculoIPI;
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LConsumidorFinal : Boolean;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  LConsumidorFinal := True;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(LConsumidorFinal)
                  .SituacaoDoIpi(IPITributado)
                  .OrgaoPublico(True)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    FillChar(AParametros, SizeOf(AParametros), #0);
    AParametros.ClienteConsumidorFinal := LConsumidorFinal;
    AParametros.BaixaDeEntregaFutura := False;
    AParametros.TotalGeralDoItem := 100;

    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue(ReturnValue.ValorCalculadoIPI = 10);
    CheckTrue(ReturnValue.BaseDeCalculoIPI = 100);
    CheckTrue(ReturnValue.AliquotaDeCalculoIPI = 10);
    CheckTrue(ReturnValue.ValorCalculadoIPIConsignacao = 10);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.SetarConfiguracoesDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NOTA_FISCAL_CONCRETO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PROCEDIMENTO_IMPRESSAO_NOTA_FISCAL, CONCREMASSA);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '52046108');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERAR_BASES_ICMS_E_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_MODELO_VENDA_FORA_ESTABELECIMENTO, CFG_MODELO_VENDA_FORA_ESTABELECIMENTO_OPC_1);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, '59176917');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BRINDE, '123');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, '6917');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI, IGUAL_PARA_TODAS_AS_EMPRESAS);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_REMESSA_PARA_DEPOSITO, '59056905');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERA_IMPOSTOS_DA_REMESSA_PARA_DEPOSITO, 'N');
end;

procedure TestTCalculoImpostoIPI.SetUp;
begin
  inherited;
  FConsultaModel := TConsultaModelFaturamentoMemory.Create;
  SetarConfiguracoesDefault;
end;

procedure TestTCalculoImpostoIPI.TearDown;
begin
  inherited;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIpiFinalAbrvForaEstado;
  var
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    ResultFunction : Boolean;
    FMatItens : TMatrizFechamento;
    LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    objMyCampoTabelaAdd.Add('COUNT(*)', 0);
    objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
    objMyCampoTabelaAdd.Add('BASE', 70);
    objMyCampoTabelaAdd.Add('ALQ', 12);

    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(True)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado('SP')
        .ClienteFisicoOuJuridico('F')
        .ClienteInscricaoEstadual('35487586810')
        .ClienteAtividade('002')
        .CalcularDescontoIcmsOrgaoPublico(false);

    SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('000080000')
        .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
        .CodigoDoCliente('000080000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .SequencialEnderecoEntrega('')
        .VendaPresencial(true)
        .EspecieDoDocumento('NF')
        .DesmembrarNotaProdutosServicos(false)
        .OpcaoDoDocumento('VN')
        .DesmembrarMeiaNotaComNotaNormal(false)
        .BaixaDeEntregaFutura(false)
        .EntregaFutura(false));

    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].strCodIte := '00001';
    FMatItens[0].strClaFis := '6108';
    FMatItens[0].opcINFesp := opcVazio;
    FMatItens[0].blnMeiaNotaFatorExpedicao := False;
    FMatItens[0].fltTotIte := 110;
    FMatItens[0].fltValFre := 10.10;
    FMatItens[0].fltDesAce := 12;
    FMatItens[0].fltDesEsp := 10.00;
    FMatItens[0].strEspDev := '000000000001';
    ResultFunction := objCalculoImpostosIPI.CalcularValorIpiFinal(FMatItens, 0);
    CheckTrue(ResultFunction);
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltAlqIpi, 12));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltBasIpi, 85.47));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltValIpi, 10.26));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIpiFinalAbrvForaEstadoCfopNaoVenda;
  var
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    ResultFunction : Boolean;
    FMatItens : TMatrizFechamento;
    LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    objMyCampoTabelaAdd.Add('COUNT(*)', 0);
    objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
    objMyCampoTabelaAdd.Add('BASE', 70);
    objMyCampoTabelaAdd.Add('ALQ', 5);

    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(True)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado('SP')
        .ClienteFisicoOuJuridico('F')
        .ClienteInscricaoEstadual('35487586810')
        .ClienteAtividade('002')
        .CalcularDescontoIcmsOrgaoPublico(false);

    SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('000080000')
        .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
        .CodigoDoCliente('000080000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .SequencialEnderecoEntrega('')
        .VendaPresencial(true)
        .EspecieDoDocumento('NF')
        .DesmembrarNotaProdutosServicos(false)
        .OpcaoDoDocumento('VN')
        .DesmembrarMeiaNotaComNotaNormal(false)
        .BaixaDeEntregaFutura(false)
        .EntregaFutura(false));

    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].strCodIte := '00001';
    FMatItens[0].strClaFis := '6102';
    FMatItens[0].opcINFesp := opcVazio;
    FMatItens[0].blnMeiaNotaFatorExpedicao := False;
    FMatItens[0].fltTotIte := 110;
    FMatItens[0].fltValFre := 10.10;
    FMatItens[0].fltDesAce := 12;
    FMatItens[0].fltDesEsp := 10.00;
    FMatItens[0].strEspDev := '000000000001';
    ResultFunction := objCalculoImpostosIPI.CalcularValorIpiFinal(FMatItens, 0);
    CheckTrue(ResultFunction);
    CheckTrue(FMatItens[0].fltAlqIpi = 5);
    CheckTrue(FMatItens[0].fltBasIpi = 0);
    CheckTrue(FMatItens[0].fltValIpi = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIpiFinalForaEstado;
  var
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    ResultFunction : Boolean;
    FMatItens : TMatrizFechamento;
    LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    objMyCampoTabelaAdd.Add('COUNT(*)', 0);
    objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
    objMyCampoTabelaAdd.Add('BASE', 70);
    objMyCampoTabelaAdd.Add('ALQ', 12);

    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(True)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado('SP')
        .ClienteFisicoOuJuridico('F')
        .ClienteInscricaoEstadual('35487586810')
        .ClienteAtividade('002')
        .CalcularDescontoIcmsOrgaoPublico(false);

    SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('000080000')
        .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
        .CodigoDoCliente('000080000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .SequencialEnderecoEntrega('')
        .VendaPresencial(true)
        .EspecieDoDocumento('NF')
        .DesmembrarNotaProdutosServicos(false)
        .OpcaoDoDocumento('VN')
        .DesmembrarMeiaNotaComNotaNormal(false)
        .BaixaDeEntregaFutura(false)
        .EntregaFutura(false));

    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].strCodIte := '00001';
    FMatItens[0].strClaFis := '6108';
    FMatItens[0].opcINFesp := opcVazio;
    FMatItens[0].blnMeiaNotaFatorExpedicao := False;
    FMatItens[0].fltTotIte := 110;
    FMatItens[0].fltValFre := 10.10;
    FMatItens[0].fltDesAce := 12;
    FMatItens[0].fltDesEsp := 10.00;
    FMatItens[0].strEspDev := '000000000001';
    ResultFunction := objCalculoImpostosIPI.CalcularValorIpiFinal(FMatItens, 0);
    CheckTrue(ResultFunction);
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltAlqIpi, 10));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltBasIpi, 122.10));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltValIpi, 12.21));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_AliquotaDeCalculoNegativa;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := False;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIpi := 100.00;
  AParametros.AliquotaDeCalculoIPI := -5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_AliquotaDeCalculoZerada;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 0;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ClienteDoExterior;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := true;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ClienteNaoEOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := false;
  AParametros.VendaDentroDoEstado := false;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ClienteOrgaoPublico_E_EmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := false;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ClienteOrgaoPublico_E_EmpresaSimplesNacional_E_VendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ClienteOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := false;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_EmpresaSimplesNacional_E_NaoEVendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := false;
  AParametros.VendaDentroDoEstado := false;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_EmpresaSimplesNacional_E_VendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := false;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_NaoEClienteOrgaoPublico_E_NaoEEmpresaSimplesNacional_E_VendaDentroDoEstado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := false;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_NaoEZonaFranca;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI > 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_RetornaValorExato;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 5);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_SubstituicaoTributariaDiferenteDeTributado;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPIIsento;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ValorCalculadoIPIBaseDoIPIAliquotaIPIExatos;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue((ReturnValue.ValorCalculadoIPI = 5) And
              (ReturnValue.BaseDeCalculoIPI = 100) And
              (ReturnValue.AliquotaDeCalculoIPI = 5));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ValorCalculadoIPIEBaseDoIPIExatos;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue((ReturnValue.ValorCalculadoIPI = 5) And (ReturnValue.BaseDeCalculoIPI = 100));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ValorCalculadoIPIEBaseDoIPIMaiorQueZero;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := false;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue((ReturnValue.ValorCalculadoIPI > 0) And (ReturnValue.BaseDeCalculoIPI > 0));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ZonaFranca;
var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := true;
  AParametros.ClienteOrgaoPublico := true;
  AParametros.VendaDentroDoEstado := true;
  AParametros.ClienteDoExterior := false;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 100.00;
  AParametros.AliquotaDeCalculoIPI := 5.00;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    checktrue(ReturnValue.ValorCalculadoIPI = 0);
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoFalse_ClienteExteriorFalse_Trib;
Var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := False;
  AParametros.ClienteOrgaoPublico := False;
  AParametros.VendaDentroDoEstado := False;
  AParametros.ClienteDoExterior := False;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 0;
  AParametros.AliquotaDeCalculoIPI := 0;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue((ReturnValue.ValorCalculadoIPI = 0) And
              (ReturnValue.BaseDeCalculoIPI = 0));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoFalse_ClienteExteriorFalse_Valores;
Var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := False;
  AParametros.ClienteOrgaoPublico := False;
  AParametros.VendaDentroDoEstado := False;
  AParametros.ClienteDoExterior := False;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 110;
  AParametros.AliquotaDeCalculoIPI := 10;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue((ReturnValue.ValorCalculadoIPI = 11) And
              (ReturnValue.BaseDeCalculoIPI = 110));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoTrue_ClienteExteriorFalse_Trib;
Var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := False;
  AParametros.ClienteOrgaoPublico := False;
  AParametros.VendaDentroDoEstado := True;
  AParametros.ClienteDoExterior := False;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 0;
  AParametros.AliquotaDeCalculoIPI := 0;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue((ReturnValue.ValorCalculadoIPI = 0) And
              (ReturnValue.BaseDeCalculoIPI = 0));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIPI_ZonaFrancaFalse_OrgaoPublicoFalse_DentroEstadoTrue_ClienteExteriorFalse_Valores;
Var
  ReturnValue: TResultadoCalculoIPI;
  AParametros: TParametrosCalculoIPI;
  objCalculoImpostosIPI : TCalculoImpostoIPI;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.ClienteZonaFranca := False;
  AParametros.ClienteOrgaoPublico := False;
  AParametros.VendaDentroDoEstado := True;
  AParametros.ClienteDoExterior := False;
  AParametros.SituacaoTributariaIPI := IPITributado;
  AParametros.BaseDoIPI := 110;
  AParametros.AliquotaDeCalculoIPI := 10;

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    ReturnValue := objCalculoImpostosIPI.CalcularValorIPI(AParametros);
    CheckTrue((ReturnValue.ValorCalculadoIPI = 11) And
              (ReturnValue.BaseDeCalculoIPI = 110));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIpiFinalForaEstadoOutrasSaidasRemessaDeposito;
  var
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    ResultFunction : Boolean;
    FMatItens : TMatrizFechamento;
    LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    objMyCampoTabelaAdd.Add('COUNT(*)', 0);
    objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
    objMyCampoTabelaAdd.Add('BASE', 70);
    objMyCampoTabelaAdd.Add('ALQ', 12);

    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(True)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado('SP')
        .ClienteFisicoOuJuridico('F')
        .ClienteInscricaoEstadual('35487586810')
        .ClienteAtividade('002')
        .CalcularDescontoIcmsOrgaoPublico(false);

    SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('000080000')
        .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
        .CodigoDoCliente('000080000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .SequencialEnderecoEntrega('')
        .VendaPresencial(true)
        .EspecieDoDocumento('NF')
        .DesmembrarNotaProdutosServicos(false)
        .OpcaoDoDocumento('OU')
        .DesmembrarMeiaNotaComNotaNormal(false)
        .BaixaDeEntregaFutura(false)
        .EntregaFutura(false));

    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].strCodIte := '00001';
    FMatItens[0].strClaFis := '6905';
    FMatItens[0].opcINFesp := opcVazio;
    FMatItens[0].blnMeiaNotaFatorExpedicao := False;
    FMatItens[0].fltTotIte := 110;
    FMatItens[0].fltValFre := 10.10;
    FMatItens[0].fltDesAce := 12;
    FMatItens[0].fltDesEsp := 10.00;
    FMatItens[0].strEspDev := '000000000001';
    ResultFunction := objCalculoImpostosIPI.CalcularValorIpiFinal(FMatItens, 0);
    CheckTrue(ResultFunction);
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltAlqIpi, 10));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltBasIpi, 122.10));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltValIpi, 12.21));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

procedure TestTCalculoImpostoIPI.TestCalcularValorIpiFinalForaEstadoOutrasSaidasRemessaDepositoZeraRemessa;
  var
    objCalculoImpostosIPI : TCalculoImpostoIPI;
    ResultFunction : Boolean;
    FMatItens : TMatrizFechamento;
    LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    LCliente : IResultadoFaturamentoImpostosModelClienteFornecedor;
    LEmpresa : IResultadoFaturamentoImpostosModelEmpresa;
    LProduto : IResultadoFaturamentoImpostosModelProduto;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_ABREVIACAO_DE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ZERA_IMPOSTOS_DA_REMESSA_PARA_DEPOSITO, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ATIVAR_REGRAS_PARA_O_CALCULO_DO_IPI_DE_SAIDA_PARA_EMPRESA_LOCALIZADA_NA_ZONA_FRANCA_DE_MANAUS, 'N');

  objCalculoImpostosIPI := TCalculoImpostoIPI.Create(objCore, objConfiguracoes, FConsultaModel);
  Try
    objMyCampoTabelaAdd.Add('COUNT(*)', 0);
    objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
    objMyCampoTabelaAdd.Add('BASE', 70);
    objMyCampoTabelaAdd.Add('ALQ', 12);

    LCliente := TConsultaClienteFornecedorMemory.New
                  .ConsumidorFinal(True)
                  .SituacaoDoIpi(IPITributado)
                  .ClienteEstado('SP');

    LEmpresa := TConsultaModelEmpresaMemory.New
                  .EmpresaEstado('RJ');

    LProduto := TConsultaModelProdutoMemory.New
                  .IpiDeSaida(10);

    TFactoryClienteFornecedorMemory.SetModel(LCliente);
    TFactoryEmpresaMemory.SetModel(LEmpresa);
    TFactoryProdutoMemory.SetModel(LProduto);

    LParametrosClienteConsumidor :=
      TParametrosFaturamentoImpostosClienteConsumidor.New
        .ClienteEstado('SP')
        .ClienteFisicoOuJuridico('F')
        .ClienteInscricaoEstadual('35487586810')
        .ClienteAtividade('002')
        .CalcularDescontoIcmsOrgaoPublico(false);

    SetImpostosFatParametrosComum(
      TImpostosFatParametrosComum.New
        .NotaComplementoFornecedor(false)
        .NotaEspecialFornecedor(false)
        .CodigoDoFornecedor('000080000')
        .ParametrosClienteConsumidor(LParametrosClienteConsumidor)
        .CodigoDoCliente('000080000')
        .ClienteConsumidorFinal(false)
        .CodigoDaEmpresa('001')
        .SequencialEnderecoEntrega('')
        .VendaPresencial(true)
        .EspecieDoDocumento('NF')
        .DesmembrarNotaProdutosServicos(false)
        .OpcaoDoDocumento('OU')
        .DesmembrarMeiaNotaComNotaNormal(false)
        .BaixaDeEntregaFutura(false)
        .EntregaFutura(false));

    SetLength(FMatItens, Length(FMatItens) + 1);
    FMatItens[0].strCodIte := '00001';
    FMatItens[0].strClaFis := '6905';
    FMatItens[0].opcINFesp := opcVazio;
    FMatItens[0].blnMeiaNotaFatorExpedicao := False;
    FMatItens[0].fltTotIte := 110;
    FMatItens[0].fltValFre := 10.10;
    FMatItens[0].fltDesAce := 12;
    FMatItens[0].fltDesEsp := 10.00;
    FMatItens[0].strEspDev := '000000000001';
    ResultFunction := objCalculoImpostosIPI.CalcularValorIpiFinal(FMatItens, 0);
    CheckTrue(ResultFunction);
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltAlqIpi, 10));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltBasIpi, 0));
    CheckTrue(fComparaValoresDecimais(FMatItens[0].fltValIpi, 0));
  Finally
    FreeAndNil(objCalculoImpostosIPI);
  End;
end;

initialization
  RegisterTest(TestTCalculoImpostoIPI.Suite);

end.
