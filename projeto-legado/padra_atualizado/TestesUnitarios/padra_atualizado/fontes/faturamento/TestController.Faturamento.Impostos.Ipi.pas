unit TestController.Faturamento.Impostos.Ipi;

interface

Uses
  TestFramework,
  untFuncFatTypes,
  Controller.Faturamento.Impostos.Ipi,
  Faturamento.Impostos.Tipos.Ipi,
  Controller.Faturamento.Interfaces.Impostos.Ipi,
  Controller.Faturamento.Tipos.Impostos.Parametros.Comum,
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum,
  Controller.Faturamento.Tipos.Impostos.Ipi,
  untTestObjMyCampoTabela,
  Shared.Functions.Configuracoes,
  Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.tipos.Model,
  Faturamento.Impostos.Interfaces.Ipi;

Type
  TTestControllerFatImpostosIpi = class(TTestCase)
  private
    procedure SetarValoresDefault;

  Published
    procedure TestCalcularValorIpi;
    procedure TestCalcularValorIpi_Parametros_Basicos;
    procedure TestCalcularValorIpiFinal;

    procedure TestZerarDadosIpi;
    procedure TestZerarDadosZerandoIpiAliquota;
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

{ TTestControllerFatImpostosIpi }

procedure TTestControllerFatImpostosIpi.SetarValoresDefault;
begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '002');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'S');
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 18);
  objMyCampoTabelaAdd.Add('CLI_IVANAC', 0.0000);
  objMyCampoTabelaAdd.Add('CLI_DESPIS', 'S');
  objMyCampoTabelaAdd.Add('CLI_BENREI', 'S');
  objMyCampoTabelaAdd.Add('CLI_ICMREI', 'S');
  objMyCampoTabelaAdd.Add('CLI_PRORUR', 'N');
  objMyCampoTabelaAdd.Add('CLI_IESUNI', 'N');
  objMyCampoTabelaAdd.Add('CLI_ORPUDF', 'N');

  objMyCampoTabelaAdd.Add('ATI_CODATI', '002');
  objMyCampoTabelaAdd.Add('COUNT(*)', 0);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', 'N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objMyCampoTabelaAdd.Add('CADITE_INDREV', 'I');
  objMyCampoTabelaAdd.Add('ITEGER_INDREV', 'I');

  objMyCampoTabelaAdd.Add('BASE', 70);
  objMyCampoTabelaAdd.Add('ALQ', 12);
end;

procedure TTestControllerFatImpostosIpi.SetUp;
begin
  inherited;

end;

procedure TTestControllerFatImpostosIpi.TearDown;
begin
  inherited;

end;

procedure TTestControllerFatImpostosIpi.TestCalcularValorIpi;
Var
  FMatItens: TMatrizFechamento;
  LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
  returnValue : IResultadoCalculoIPI;
begin
  SetarValoresDefault;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');


  SetLength(FMatItens, Length(FMatItens) + 1 );

  FMatItens[0].blnMeiaNotaFatorExpedicao := False;
  FMatItens[0].strCodIte := '10000';
  FMatItens[0].strClaFis := '5204';
  FMatItens[0].opcINFesp := opcVazio;
  FMatItens[0].fltTotIte := 150;
  FMatItens[0].fltValFre := 0;
  FMatItens[0].fltDesAce := 0;
  FMatItens[0].fltDesEsp := 0;
  FMatItens[0].strEspDev := '';


  LParametrosClienteConsumidor :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado('SP')
      .ClienteFisicoOuJuridico('F')
      .ClienteInscricaoEstadual('35487586810')
      .ClienteAtividade('')
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

  returnValue :=
    TImpostosFatControllerIpi
      .New(FMatItens, 0)
        .CalcularValorIpi;

  CheckTrue(
    (returnValue.ValorCalculadoIPI = 27)  And
    (returnValue.BaseDeCalculoIPI = 150) And
    (returnValue.AliquotaDeCalculoIPI = 18));
end;

procedure TTestControllerFatImpostosIpi.TestCalcularValorIpi_Parametros_Basicos;
Var
  MatrizFechamento: TMatrizFechamento;
  returnValue: IResultadoCalculoIPI;
  LParametrosCalculoValorIpi: IParametrosCalculoValorIpi;
begin
  SetarValoresDefault;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');

  LParametrosCalculoValorIpi :=
    TParametrosCalculoValorIpi.New
      .CodigoDoCliente('000080000')
      .CodigoDoProduto('10000')
      .CodigoDaEmpresa('001')
      .TotalGeralDoItem(150)
      .BaixaDeEntregaFutura(false)
      .ClienteConsumidorFinal(false);

  returnValue :=
    TImpostosFatControllerIpi
      .New(MatrizFechamento, 0)
        .CalcularValorIpi(LParametrosCalculoValorIpi);

  CheckTrue(
    (returnValue.ValorCalculadoIPI = 27)  And
    (returnValue.BaseDeCalculoIPI = 150) And
    (returnValue.AliquotaDeCalculoIPI = 18));
end;

procedure TTestControllerFatImpostosIpi.TestCalcularValorIpiFinal;
Var
  FMatItens: TMatrizFechamento;
  LParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
  returnValue : Boolean;
begin
  SetarValoresDefault;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CADASTRO_DE_ABREVIACAO_PIS_COFINS_IPI, '2');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DEDUZIR_DESCONTO_ICMS_ZONA_FRANCA_BASE_CALCULO_ST_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_DESPESAS_ACESSORIA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_SUBSTITUICAO_TRIBUTARIA_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CALCULAR_IPI_SOBRE_FRETE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_VENDA, '5204');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, 'N');


  SetLength(FMatItens, Length(FMatItens) + 1 );

  FMatItens[0].blnMeiaNotaFatorExpedicao := False;
  FMatItens[0].strCodIte := '10000';
  FMatItens[0].strClaFis := '5204';
  FMatItens[0].opcINFesp := opcVazio;
  FMatItens[0].fltTotIte := 150;
  FMatItens[0].fltValFre := 0;
  FMatItens[0].fltDesAce := 0;
  FMatItens[0].fltDesEsp := 0;
  FMatItens[0].strEspDev := '';


  LParametrosClienteConsumidor :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado('SP')
      .ClienteFisicoOuJuridico('F')
      .ClienteInscricaoEstadual('35487586810')
      .ClienteAtividade('')
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

  returnValue :=
    TImpostosFatControllerIpi
      .New(FMatItens, 0)
        .CalcularValorIpiFinal;

  CheckTrue(returnValue);

end;

procedure TTestControllerFatImpostosIpi.TestZerarDadosIpi;
Var
  FMatItens   : TMatrizFechamento;
  returnValue : Boolean;
begin
  ReturnValue := true;

  Try
    SetLength(FMatItens, Length(FMatItens) + 1 );
    FMatItens[0].fltValIpi := 100;
    FMatItens[0].fltBasIpi := 10;
    FMatItens[0].fltAlqIpi := 10;

    TImpostosFatControllerIpi
      .New(FMatItens, 0)
        .ZerarDadosIpi(false);
  except
    ReturnValue := False;
  end;

  CheckTrue(ReturnValue);
end;

procedure TTestControllerFatImpostosIpi.TestZerarDadosZerandoIpiAliquota;
Var
  FMatItens: TMatrizFechamento;
  returnValue : Boolean;
begin
  returnValue := true;

  Try
    SetLength(FMatItens, Length(FMatItens) + 1 );
    FMatItens[0].fltValIpi := 100;
    FMatItens[0].fltBasIpi := 10;
    FMatItens[0].fltAlqIpi := 10;

    TImpostosFatControllerIpi
      .New(FMatItens, 0)
        .ZerarDadosIpi(true);
  except
    ReturnValue := False;
  end;

  CheckTrue(ReturnValue);
end;

initialization

// Register any test cases with the test runner
RegisterTest(TTestControllerFatImpostosIpi.Suite);

end.
