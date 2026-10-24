unit TestFaturamento.Impostos.Regras.Tributacao.Factory;

interface

uses
  TestFramework,
  System.StrUtils,
  System.SysUtils,
  Shared.Functions.Configuracoes,
  Faturamento.Impostos.Tipos.Model,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Model.Cliente,
  Faturamento.Model.Produto,
  Faturamento.Model.AbreviacaoIcms,
  Faturamento.Model.Empresa,
  Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Tipos.Tributacao,
  Faturamento.Impostos.Regras.Tributacao.Factory,
  Shared.Functions.DataSet, untTestObjMyCampoTabela,
  Shared.Functions.Core;


type
  // Test methods for class TClassificaoConsignacao

  TestTributacaoFactory = class(TTestCase)
  strict private
    FParametros             : IParametrosRegrasTributacao;
    FModelClienteFornecedor : IResultadoFaturamentoImpostosModelClienteFornecedor;
    FModelProduto           : IResultadoFaturamentoImpostosModelProduto;
    FModelEmpresa           : IResultadoFaturamentoImpostosModelEmpresa;
    FModelTributacao        : IResultadoFaturamentoImpostosModelAbreviacaoIcms;

    procedure CarregarParametros;
    procedure SetarModelClienteFornecedor;
    procedure SetarModelEmpresa;
    procedure SetarModelProduto;
    procedure SetarModelAbreviacaoIcms;
    procedure SetarConfiguracoes;


  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExecutarFactory;

  end;

implementation



procedure TestTributacaoFactory.CarregarParametros;
begin
  SetarModelClienteFornecedor;
  SetarModelEmpresa;
  SetarModelProduto;
  SetarModelAbreviacaoIcms;
  SetarConfiguracoes;

  FParametros :=
    TParametrosRegrasTributacao.New
      .ModelClienteFornecedor(FModelClienteFornecedor)
      .ModelProduto(FModelProduto)
      .ModelEmpresa(FModelEmpresa)
      .ModelAbreviacaoIcms(FModelTributacao)
      .DentroDoEstado(false)
      .NotaDeImportacao(false)
      .CodigoDaSituacaoTributaria('041')
      .AliquotaDeIcmsDoItem(0)
      .EspecieDoDocumento('VN')
      .UtilizaSat(false)
      .CalcularSatEcf(false)
      .DentroDoEstadoCFOP(false)
      .AtividadeConstrutora(false)
      .TipoOperacaoPedidoVenda('A')
      .AlqIcmEstEmpFaturamento(0)
      .ValorDeIpiDoItem(0)
      .DocumentoParaFornecedor(false)
	    .TotalGeralDoItem(0)
      .ImportacaoDiretaDoItem('S')
      .ValorUnitarioDoItem(0)
      .QuantidadeDoItem(1)
      .AlqIcmEstEmpSimples(0);
end;

procedure TestTributacaoFactory.SetarConfiguracoes;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICM_PR, 'S');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_DIRETORIO_PARA_OPCOES_FISCAIS_INI, '');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, '0');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_EMPRESA_DISTRIBUIDORA, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZAR_NFCE, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_VENDA_FORA_ESTADO_NAO_CONTRIBUINTE_TRIBUTAR_ALIQUOTA_INTERNA_ESTADO, 'N');
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');

end;

procedure TestTributacaoFactory.SetarModelAbreviacaoIcms;
var
  AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms;
begin
  // TODO: Setup method call parameters
  AParametros :=
    TParametrosFaturamentoImpostosModelAbreviacaoIcms.New
      .CodigoDoItem('15511')
      .CodigoDaAbreviacaoFiscal('059')
      .Estado('SP')
      .CodigoDaEmpresaTE('001')
      .CodigoDaEmpresa('001')
      .TipoDaAbreviacaoFiscal('_SAI_CNC');

  objMyCampoTabelaAdd.Add('ABF_ALQICM_SAI_CNC', '18');
  objMyCampoTabelaAdd.Add('ABF_ALQRET_SAI_CNC', '0');
  objMyCampoTabelaAdd.Add('ABF_BASICM_SAI_CNC', '100');
  objMyCampoTabelaAdd.Add('ABF_CODSIT_SAI_CNC', '999');
  objMyCampoTabelaAdd.Add('ABF_IVA_ST_SAI_CNC', '15');
  objMyCampoTabelaAdd.Add('ABF_BASRET_SAI_CNC', '060');
  objMyCampoTabelaAdd.Add('ABF_CAL_ST_SAI_CCO', '666');
  objMyCampoTabelaAdd.Add('ABF_CODABF', '040');
  objMyCampoTabelaAdd.Add('ABF_ALQFCP_SAI_CNC', '090');


  FModelTributacao := TFaturamentoImpostosModelAbreviacaoIcms.New.Consultar(AParametros);
end;

procedure TestTributacaoFactory.SetarModelClienteFornecedor;
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

procedure TestTributacaoFactory.SetarModelEmpresa;
Var
  ACodigoDaEmpresa: string;
begin
  objMyCampoTabelaAdd.Add('EMP_ESTADO', 'SP');
  objMyCampoTabelaAdd.Add('EMP_COIBGE', '3543402');
  FModelEmpresa :=
    TFaturamentoImpostosModelEmpresa.New.
      Consultar(ACodigoDaEmpresa);
end;

procedure TestTributacaoFactory.SetarModelProduto;
var
  ACodigoDaEmpresa: string;
  ACodigoDoProduto: string;
  ACodigoEmpresaTE: string;
begin
  objMyCampoTabelaAdd.Add('ITE_IPISAI', 18);
  objMyCampoTabelaAdd.Add('ITE_ITECCR', False);
  objMyCampoTabelaAdd.Add('CADITE_CODABF','009');
  objMyCampoTabelaAdd.Add('ITEGER_CODABF','002');
  objMyCampoTabelaAdd.Add('ITEGER_IMPDIR','N');
  objMyCampoTabelaAdd.Add('CADITE_IMPDIR','N');
  objMyCampoTabelaAdd.Add('ITE_UTIAMP', 'S');

  objConfiguracoes.fAtualizaValorConfiguracao(CFG_IMPORTACAO_DIRETA_PRODUTOS, '1');

  // TODO: Setup method call parameters
  FModelProduto :=
    TFaturamentoImpostosModelProduto.New.
      Consultar(ACodigoDoProduto,ACodigoDaEmpresa, ACodigoEmpresaTE, EmptyStr, false);
end;

procedure TestTributacaoFactory.SetUp;
begin
end;

procedure TestTributacaoFactory.TearDown;
begin
end;

procedure TestTributacaoFactory.TestExecutarFactory;
Var
  ReturnValue : IResultadoRegrasTributacaoIcmsSt;
begin
  CarregarParametros;

  ReturnValue := TFaturamentoImpostosRegrasTributacaoFactory.New(FParametros).Tributacao.IcmsSt;

  CheckTrue(
    (ReturnValue.AliquotaDeIcms = 18) And
    (ReturnValue.PercentualDaBaseDeIcms = 90 ) And
    (ReturnValue.AliquotaDeIcmsAnterior = 18) And
    (ReturnValue.BaseDeCalculoDoIcmsAnterior = 0) And
    (ReturnValue.ValorDoIcmsAnterior = 0) And
    (ReturnValue.PercentualDeReducaoDaBaseDeIcms = 10) And
    (ReturnValue.ReducaoRICMPR = 'N'));
end;

initialization
  RegisterTest(TestTributacaoFactory.Suite);
end.

