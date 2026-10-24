unit TestFaturamento.Impostos.Regras.Tributacao.ST_Simulada;

interface

uses
  TestFramework,
  Faturamento.Impostos.Interfaces.ST_Simulada,
  Faturamento.Impostos.Tipos.ST_Simulada,
  Faturamento.Impostos.Regras.Tributacao.ST_Simulada,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Shared.Functions.Configuracoes,
  untTestObjMyCampoTabela,
  Faturamento.Model.Cliente,
  Faturamento.Model.Produto,
  Faturamento.Model.AbreviacaoIcms,
  Faturamento.Model.Empresa,
  SysUtils;


type
  TestTRegraTributacaoST_Simulada = class(TTestCase)
  strict private
    FParametros                                    : IParametrosRegrasSTSimulada;
    FAliquotaDaSubstituicaoTributariaDoItem        : Double;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FModelClienteFornecedor                        : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto                                  : IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa                                  : IResultadoFaturamentoImpostosModelEmpresa;
    FTotalGeralDoItem                              : Double;
    FClienteConsumidorFinal                             : Boolean;
    FCodigoDaSubstituicaoTributaria                : String;
    FTipoDaAbreviacaoFiscal                        : String;
    FValorDoIva                                    : Double;
    FEspecieDoDocumento                            : String;
    FDentroDoEstado                                : Boolean;
    FDentroDoEstadoCFOP                            : Boolean;
    FAtividadeConstrutora                          : Boolean;

    procedure SetarParametrosDefault;
  private
    procedure SetarModelProduto;
    procedure SetarModelEmpresa(AEstadoEmpresa : String = 'SP');
    procedure SetarModelClienteFornecedor;
    procedure CarregarParametros;

    procedure SetarConfiguracoesDefault;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularForaDentroDoEstado;
    procedure TestCalcularDentroDoEstadoSemSubstituicaoTributaria;
    procedure TestCalcularDentroDoEstadoComSubstituicaoTributaria;
    procedure TestCalcularDentroDoEstadoComSubstituicaoTributariaClienteConsumidorFinal;
    procedure TestCalcularDentroDoEstadoComSubstituicaoTributariaClienteConsumidorFinalNCOEspiritoSanto;

  end;

implementation
{ TestTRegraTributacaoST_Simulada }

procedure TestTRegraTributacaoST_Simulada.SetarParametrosDefault;
begin
  FAliquotaDaSubstituicaoTributariaDoItem        := 10;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem:= 10;
  FTotalGeralDoItem                              := 100;
  FClienteConsumidorFinal                             := false;
  FCodigoDaSubstituicaoTributaria                := '010';
  FTipoDaAbreviacaoFiscal                        := '_SAI_CNC';
  FValorDoIva                                    := 0;
  FEspecieDoDocumento                            := 'VN';
  FDentroDoEstado                                := true;
  FDentroDoEstadoCFOP                            := false;
  FAtividadeConstrutora                          := false;
end;

procedure TestTRegraTributacaoST_Simulada.SetarModelEmpresa(AEstadoEmpresa : String = 'SP');
Var
  ACodigoDaEmpresa: string;
begin
  objMyCampoTabelaAdd.Add('EMP_ESTADO', AEstadoEmpresa);
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');

  FModelEmpresa := TFaturamentoImpostosModelEmpresa.New.Consultar(ACodigoDaEmpresa);
end;

procedure TestTRegraTributacaoST_Simulada.CarregarParametros;
begin
  SetarModelProduto;
  SetarModelClienteFornecedor;

  FParametros :=
    TParametrosRegrasSTSimulada.New
      .ModelClienteFornecedor(FModelClienteFornecedor)
      .ModelProduto(FModelProduto)
      .ModelEmpresa(FModelEmpresa)
      .TotalGeralDoItem(FTotalGeralDoItem)
      .ClienteConsumidorFinal(FClienteConsumidorFinal)
      .CodigoDaSubstituicaoTributaria(FCodigoDaSubstituicaoTributaria)
      .TipoDaAbreviacaoFiscal(FTipoDaAbreviacaoFiscal)
      .ValorDoIva(FValorDoIva)
      .AliquotaDaSubstituicaoTributariaDoItem(FAliquotaDaSubstituicaoTributariaDoItem)
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FPercentualDaBaseDaSubstituicaoTributariaDoItem)
      .EspecieDoDocumento(FEspecieDoDocumento)
      .DentroDoEstado(FDentroDoEstado)
      .DentroDoEstadoCFOP(FDentroDoEstadoCFOP)
      .AtividadeConstrutora(FAtividadeConstrutora);
end;

procedure TestTRegraTributacaoST_Simulada.SetarConfiguracoesDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
end;

procedure TestTRegraTributacaoST_Simulada.SetarModelClienteFornecedor;
var
  ACodigoDoCliente,
  ASequencialEnderecoEntrega : String;
begin
  objMyCampoTabelaAdd.Add('CLI_SITIPI', 'T');
  objMyCampoTabelaAdd.Add('CLI_ZONFRA', 'N');
  objMyCampoTabelaAdd.Add('CLI_SUFRAM', 'N');
  objMyCampoTabelaAdd.Add('CLI_DESZON', 'N');
  objMyCampoTabelaAdd.Add('CLI_CODATI', '001');
  objMyCampoTabelaAdd.Add('CLI_REGFIS', '1');
  objMyCampoTabelaAdd.Add('CLI_ORGPUB', 'N');
  objMyCampoTabelaAdd.Add('CID_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('CLI_CONSUM', 'S');
  objMyCampoTabelaAdd.Add('CLI_SIBICM', 'S');
  objMyCampoTabelaAdd.Add('CLI_I_E_S_', '');
  objMyCampoTabelaAdd.Add('CLI_MICEMP', 'S');
  objMyCampoTabelaAdd.Add('CLI_INDCOM', 'C');
  objMyCampoTabelaAdd.Add('CLI_IVAESP', 0);
  objMyCampoTabelaAdd.Add('CLI_IVASIM', 0);
  objMyCampoTabelaAdd.Add('CLI_CALICM', '');
  objMyCampoTabelaAdd.Add('CLI_STREES', 'N');
  objMyCampoTabelaAdd.Add('CLI_REDICM', 10);
  objMyCampoTabelaAdd.Add('CLI_DIF_ST', 'S');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', '');
  objMyCampoTabelaAdd.Add('CLI_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('ENT_COIBGE', '3543402');
  objMyCampoTabelaAdd.Add('CLI_ORPURD', 'R');
  objMyCampoTabelaAdd.Add('CLI_IVANAC', '0');

  // TODO: Setup method call parameters
  FModelClienteFornecedor :=
    TFaturamentoImpostosModelCliente.New.
      Consultar(ACodigoDoCliente,ASequencialEnderecoEntrega, false, True);
end;



procedure TestTRegraTributacaoST_Simulada.SetarModelProduto;
var
  ACodigoDaEmpresa: string;
  ACodigoDoProduto: string;
  ACodigoEmpresaTE: string;
begin
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 18);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', False);
  objMyCampoTabelaAdd.Add('CADITE_CODABF','009');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF','002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR','S');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR','S');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');

  // TODO: Setup method call parameters
  FModelProduto :=
    TFaturamentoImpostosModelProduto.New.
      Consultar(ACodigoDoProduto,ACodigoDaEmpresa, ACodigoEmpresaTE, EmptyStr, false);
end;


procedure TestTRegraTributacaoST_Simulada.SetUp;
begin
  inherited;

end;

procedure TestTRegraTributacaoST_Simulada.TearDown;
begin
  inherited;

end;

procedure TestTRegraTributacaoST_Simulada.TestCalcularDentroDoEstadoComSubstituicaoTributaria;
Var
  ReturnValue : IResultadoRegrasSTSimulada;
begin
  SetarParametrosDefault;

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');

  FValorDoIva  := 10;

  SetarModelEmpresa;
  CarregarParametros;

  ReturnValue := TCalculoSTSimulada.New.Calcular(FParametros);

  CheckTrue(
    (ReturnValue.BaseDaSubstituicaoTributariaSimulada = 100) And
    (ReturnValue.AliquotaDaSubstituicaoTributariaSimulada = 10) And
    (ReturnValue.ValorDaSubstituicaoTributariaSimulada = 0));
end;

procedure TestTRegraTributacaoST_Simulada.TestCalcularDentroDoEstadoComSubstituicaoTributariaClienteConsumidorFinal;
Var
  ReturnValue : IResultadoRegrasSTSimulada;
begin
  SetarParametrosDefault;
  SetarConfiguracoesDefault;

  FValorDoIva  := 10;
  FClienteConsumidorFinal := true;

  SetarModelEmpresa;
  CarregarParametros;

  ReturnValue := TCalculoSTSimulada.New.Calcular(FParametros);

  CheckTrue(
    (ReturnValue.BaseDaSubstituicaoTributariaSimulada = 10) And
    (ReturnValue.AliquotaDaSubstituicaoTributariaSimulada = 10) And
    (ReturnValue.ValorDaSubstituicaoTributariaSimulada = 0));

end;

procedure TestTRegraTributacaoST_Simulada.TestCalcularDentroDoEstadoComSubstituicaoTributariaClienteConsumidorFinalNCOEspiritoSanto;
Var
  ReturnValue : IResultadoRegrasSTSimulada;
begin
  SetarParametrosDefault;
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, '2');

  FClienteConsumidorFinal := true;
  FCodigoDaSubstituicaoTributaria                := '010';
  FTipoDaAbreviacaoFiscal                        := '_SAI_NCO';

  SetarModelEmpresa('ES');
  CarregarParametros;

  ReturnValue := TCalculoSTSimulada.New.Calcular(FParametros);

  CheckTrue(
    (ReturnValue.BaseDaSubstituicaoTributariaSimulada = 0) And
    (ReturnValue.AliquotaDaSubstituicaoTributariaSimulada = 10) And
    (ReturnValue.ValorDaSubstituicaoTributariaSimulada = 0));
end;

procedure TestTRegraTributacaoST_Simulada.TestCalcularDentroDoEstadoSemSubstituicaoTributaria;
Var
  ReturnValue : IResultadoRegrasSTSimulada;
begin
  SetarParametrosDefault;

  FCodigoDaSubstituicaoTributaria := '';

  SetarModelEmpresa;
  CarregarParametros;

  ReturnValue := TCalculoSTSimulada.New.Calcular(FParametros);

  CheckTrue(
    (ReturnValue.BaseDaSubstituicaoTributariaSimulada = 0) And
    (ReturnValue.AliquotaDaSubstituicaoTributariaSimulada = 0) And
    (ReturnValue.ValorDaSubstituicaoTributariaSimulada = 0));

end;

procedure TestTRegraTributacaoST_Simulada.TestCalcularForaDentroDoEstado;
Var
  ReturnValue : IResultadoRegrasSTSimulada;
begin
  SetarParametrosDefault;

  FDentroDoEstado := false;

  SetarModelEmpresa;
  CarregarParametros;

  ReturnValue := TCalculoSTSimulada.New.Calcular(FParametros);

  CheckTrue(
    (ReturnValue.BaseDaSubstituicaoTributariaSimulada = 0) And
    (ReturnValue.AliquotaDaSubstituicaoTributariaSimulada = 0) And
    (ReturnValue.ValorDaSubstituicaoTributariaSimulada = 0));

end;

initialization
  RegisterTest(TestTRegraTributacaoST_Simulada.Suite);
end.

