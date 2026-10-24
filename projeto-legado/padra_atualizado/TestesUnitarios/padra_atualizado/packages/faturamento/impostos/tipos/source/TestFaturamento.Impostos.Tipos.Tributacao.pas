unit TestFaturamento.Impostos.Tipos.Tributacao;

interface

uses
  TestFramework, Faturamento.Impostos.Interfaces.Tributacao,
   Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Types, Faturamento.Impostos.tipos.Tributacao;

type

  TestTParametrosTributacao = class(TTestCase)
  Strict private
    FParametrosRegrasTributacao: TParametrosRegrasTributacao;
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Published
    procedure TestModelClienteFornecedor;
    procedure TestModelProduto;
    procedure TestModelEmpresa;
    procedure TestModelAbreviacaoIcms;
    procedure TestDentroDoEstado;
    procedure TestNotaDeImportacao;
    procedure TestCodigoDaSituacaoTributaria;
    procedure TestAliquotaDeIcmsDoItem;
    procedure TestEspecieDoDocumento;
    procedure TestUtilizaSat;
    procedure TestCalcularSatEcf;
    procedure TestDentroDoEstadoCFOP;
    procedure TestAtividadeConstrutora;
    procedure TestTipoOperacaoPedidoVenda;
    procedure TestAlqIcmEstEmpFaturamento;
    procedure TestAlqIcmEstEmpSimples;
    procedure TestValorDeIpiDoItem;
    procedure TestDocumentoParaFornecedor;
	  procedure TestTotalGeralDoItem;
    procedure TestImportacaoDiretaDoItem;
    procedure TestValorUnitarioDoItem;
    procedure TestQuantidadeDoItem;
    procedure TestTipoDaAbreviacaoFiscal;
    procedure TestClienteComercializacao;
    procedure TestExisteNaTabelaCEDEM;
    procedure TestUtilizaDecretoReducaoRICMSdaAbreviacao;
    procedure TestVendaDeProducao;
  end;
  // Test methods for class TResultadoDadosFiscaisAliquota

  TestTResultadoTributacao = class(TTestCase)
  strict private
    FResultadoRegrasTributacaoIcmsSt: TResultadoRegrasTributacaoIcmsSt;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAliquotaDeIcms;
    procedure TestPercentualDaBaseDeIcms;
    procedure TestValorIVAEspecialClienteMTIcms;
    procedure TestAliquotaDeIcmsAnterior;
    procedure TestBaseDeCalculoDoIcmsAnterior;
    procedure TestValorDoIcmsAnterior;
    procedure TestPercentualDeReducaoDaBaseDeIcms;
    procedure TestReducaoRICMPR;
    procedure TestAliquotaDaSubstituicaoTributaria;
    procedure TestValorDoIva;
    procedure TestValorDoIvaMatriz;
    procedure TestValorDoIvaStMatriz;
    procedure TestValorIVAEspecialClienteMTSt;
    procedure TestValorIcmsEstado;
    procedure TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
    procedure TestBaseDaSubstituicaoTributariaSimulada;
    procedure TestAliquotaDaSubstituicaoTributariaSimulada;
    procedure TestValorDaSubstituicaoTributariaSimulada;
    procedure TestCodigoDaSubstituicaoTributariaDoItem;
    procedure TestAtendeRegrasAtoDeclaratorioDF;
    procedure TestAliquotaReduzidaDaSt;
  end;

  TestResultadoRegrasTributacao = class(TTestCase)
  strict private
    FResultadoRegrasTributacao : TResultadoRegrasTributacao;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAliquotaDeIcms;
    procedure TestPercentualDaBaseDeIcms;
    procedure TestCodigoDaSubstituicaoTributaria;
    procedure TestValorIVAEspecialClienteMTIcms;
    procedure TestAliquotaDeIcmsAnterior;
    procedure TestBaseDeCalculoDoIcmsAnterior;
    procedure TestValorDoIcmsAnterior;
    procedure TestPercentualDeReducaoDaBaseDeIcms;
    procedure TestReducaoRICMPR;
    procedure TestAliquotaDaSubstituicaoTributaria;
    procedure TestAliquotaDeIcmsEfetivoDoItem;
    procedure TestValorDoIva;
    procedure TestValorDoIvaMatriz;
    procedure TestValorDoIvaStMatriz;
    procedure TestValorIVAEspecialClienteMTSt;
    procedure TestValorIcmsEstado;
    procedure TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
    procedure TestAliquotaDaSubstituicaoTributariaSimulada;
    procedure TestBaseDaSubstituicaoTributariaSimulada;
    procedure TestValorDaSubstituicaoTributariaSimulada;
    procedure TestAtendeRegrasAtoDeclaratorioDF;
    procedure TestAliquotaReduzidaDaSt;
  end;

implementation

procedure TestTParametrosTributacao.SetUp;
begin
  FParametrosRegrasTributacao := TParametrosRegrasTributacao.Create;
end;

procedure TestTParametrosTributacao.TearDown;
begin
  FParametrosRegrasTributacao := nil;
end;

procedure TestTParametrosTributacao.TestAliquotaDeIcmsDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.AliquotaDeIcmsDoItem(0).AliquotaDeIcmsDoItem;
  CheckTrue(ReturnValue = 0);
end;

procedure TestTParametrosTributacao.TestAlqIcmEstEmpFaturamento;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.AlqIcmEstEmpFaturamento(0).AlqIcmEstEmpFaturamento;
  CheckTrue(ReturnValue = 0);
end;

procedure TestTParametrosTributacao.TestAlqIcmEstEmpSimples;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.AlqIcmEstEmpSimples(0).AlqIcmEstEmpSimples;
  CheckTrue(ReturnValue = 0);
end;

procedure TestTParametrosTributacao.TestAtividadeConstrutora;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.AtividadeConstrutora(true).AtividadeConstrutora;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestCalcularSatEcf;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.CalcularSatEcf(true).CalcularSatEcf;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestClienteComercializacao;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.ClienteComercializacao(true).ClienteComercializacao;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestCodigoDaSituacaoTributaria;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosRegrasTributacao.CodigoDaSituacaoTributaria('041').CodigoDaSituacaoTributaria;
  CheckTrue(ReturnValue = '041');
end;

procedure TestTParametrosTributacao.TestDentroDoEstado;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.DentroDoEstado(true).DentroDoEstado;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestDentroDoEstadoCFOP;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.DentroDoEstadoCFOP(true).DentroDoEstadoCFOP;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestDocumentoParaFornecedor;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.DocumentoParaFornecedor(true).DocumentoParaFornecedor;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestEspecieDoDocumento;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosRegrasTributacao.EspecieDoDocumento('VN').EspecieDoDocumento;
  CheckTrue(ReturnValue = 'VN');
end;

procedure TestTParametrosTributacao.TestExisteNaTabelaCEDEM;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.ExisteNaTabelaCEDEM(True).ExisteNaTabelaCEDEM;
  CheckTrue(ReturnValue = True);
end;

procedure TestTParametrosTributacao.TestImportacaoDiretaDoItem;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosRegrasTributacao.ImportacaoDiretaDoItem('S').ImportacaoDiretaDoItem;
  CheckTrue(ReturnValue = 'S');
end;

procedure TestTParametrosTributacao.TestModelAbreviacaoIcms;
var
  ReturnValue: IResultadoFaturamentoImpostosModelAbreviacaoIcms;
begin
  ReturnValue := FParametrosRegrasTributacao.ModelAbreviacaoIcms(Nil).ModelAbreviacaoIcms;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosTributacao.TestModelClienteFornecedor;
var
  ReturnValue: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  ReturnValue := FParametrosRegrasTributacao.ModelClienteFornecedor(Nil).ModelClienteFornecedor;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosTributacao.TestModelEmpresa;
var
  ReturnValue: IResultadoFaturamentoImpostosModelEmpresa;
begin
  ReturnValue := FParametrosRegrasTributacao.ModelEmpresa(Nil).ModelEmpresa;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosTributacao.TestModelProduto;
var
  ReturnValue: IResultadoFaturamentoImpostosModelProduto;
begin
  ReturnValue := FParametrosRegrasTributacao.ModelProduto(Nil).ModelProduto;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosTributacao.TestNotaDeImportacao;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.NotaDeImportacao(true).NotaDeImportacao;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestQuantidadeDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.QuantidadeDoItem(10).QuantidadeDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosTributacao.TestTipoDaAbreviacaoFiscal;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosRegrasTributacao.TipoDaAbreviacaoFiscal('_NCO').TipoDaAbreviacaoFiscal;
  CheckTrue(ReturnValue = '_NCO');
end;

procedure TestTParametrosTributacao.TestTipoOperacaoPedidoVenda;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosRegrasTributacao.TipoOperacaoPedidoVenda('A').TipoOperacaoPedidoVenda;
  CheckTrue(ReturnValue = 'A');
end;

procedure TestTParametrosTributacao.TestTotalGeralDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.TotalGeralDoItem(10).TotalGeralDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosTributacao.TestUtilizaDecretoReducaoRICMSdaAbreviacao;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.UtilizaDecretoReducaoRICMSdaAbreviacao(True).UtilizaDecretoReducaoRICMSdaAbreviacao;
  CheckTrue(ReturnValue = True);
end;

procedure TestTParametrosTributacao.TestVendaDeProducao;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.VendaDeProducao(true).VendaDeProducao;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestUtilizaSat;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosRegrasTributacao.UtilizaSat(true).UtilizaSat;
  CheckTrue(ReturnValue);
end;

procedure TestTParametrosTributacao.TestValorDeIpiDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.ValorDeIpiDoItem(10).ValorDeIpiDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosTributacao.TestValorUnitarioDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosRegrasTributacao.ValorUnitarioDoItem(10).ValorUnitarioDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestAliquotaDaSubstituicaoTributaria;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributaria(17).AliquotaDaSubstituicaoTributaria;
  CheckTrue(ReturnValue = 17);
end;

procedure TestTResultadoTributacao.TestAliquotaDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AliquotaDaSubstituicaoTributariaSimulada(27).AliquotaDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 27);
end;

procedure TestTResultadoTributacao.TestAliquotaDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AliquotaDeIcms(10).AliquotaDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestAliquotaDeIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AliquotaDeIcmsAnterior(10).AliquotaDeIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestAliquotaReduzidaDaSt;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AliquotaReduzidaDaSt(11).AliquotaReduzidaDaSt;
  CheckTrue(ReturnValue = 11);
end;

procedure TestTResultadoTributacao.TestAtendeRegrasAtoDeclaratorioDF;
Var
  ReturnValue: Boolean;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.AtendeRegrasAtoDeclaratorioDF(True).AtendeRegrasAtoDeclaratorioDF;
  CheckTrue( ReturnValue );
end;

procedure TestTResultadoTributacao.TestBaseDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.BaseDaSubstituicaoTributariaSimulada(170).BaseDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 170);
end;

procedure TestTResultadoTributacao.TestBaseDeCalculoDoIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.BaseDeCalculoDoIcmsAnterior(10).BaseDeCalculoDoIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestCodigoDaSubstituicaoTributariaDoItem;
Var
  ReturnValue: String;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.CodigoDaSubstituicaoTributariaDoItem('051').CodigoDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = '051');
end;

procedure TestTResultadoTributacao.TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDaSubstituicaoTributariaDoItem(9).PercentualDaBaseDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 9);
end;

procedure TestTResultadoTributacao.TestPercentualDaBaseDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.PercentualDaBaseDeIcms(10).PercentualDaBaseDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestPercentualDeReducaoDaBaseDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms(10).PercentualDeReducaoDaBaseDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestReducaoRICMPR;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.PercentualDeReducaoDaBaseDeIcms(10).PercentualDeReducaoDaBaseDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.SetUp;
begin
  FResultadoRegrasTributacaoIcmsSt := TResultadoRegrasTributacaoIcmsSt.Create;;
end;

procedure TestTResultadoTributacao.TearDown;
begin
  FResultadoRegrasTributacaoIcmsSt := nil;
end;

procedure TestTResultadoTributacao.TestValorDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorDaSubstituicaoTributariaSimulada(11).ValorDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 11);
end;

procedure TestTResultadoTributacao.TestValorDoIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorDoIcmsAnterior(10).ValorDoIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;


procedure TestTResultadoTributacao.TestValorDoIva;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorDoIva(99).ValorDoIva;
  CheckTrue(ReturnValue = 99);
end;

procedure TestTResultadoTributacao.TestValorDoIvaMatriz;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorDoIvaMatriz(10).ValorDoIvaMatriz;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestValorDoIvaStMatriz;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorDoIvaStMatriz(10).ValorDoIvaStMatriz;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoTributacao.TestValorIcmsEstado;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorIcmsEstado(131).ValorIcmsEstado;
  CheckTrue(ReturnValue = 131);
end;

procedure TestTResultadoTributacao.TestValorIVAEspecialClienteMTIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTIcms(39).ValorIVAEspecialClienteMTIcms;
  CheckTrue(ReturnValue = 39);
end;

procedure TestTResultadoTributacao.TestValorIVAEspecialClienteMTSt;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacaoIcmsSt.ValorIVAEspecialClienteMTSt(31).ValorIVAEspecialClienteMTSt;
  CheckTrue(ReturnValue = 31);
end;

{ TestResultadoRegrasTributacao }

procedure TestResultadoRegrasTributacao.SetUp;
begin
  FResultadoRegrasTributacao := TResultadoRegrasTributacao.Create;;
end;

procedure TestResultadoRegrasTributacao.TearDown;
begin
  FResultadoRegrasTributacao := nil;
end;

procedure TestResultadoRegrasTributacao.TestAliquotaDaSubstituicaoTributaria;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaDaSubstituicaoTributaria(25).AliquotaDaSubstituicaoTributaria;
  CheckTrue(ReturnValue = 25);
end;

procedure TestResultadoRegrasTributacao.TestAliquotaDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaDaSubstituicaoTributariaSimulada(10).AliquotaDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestAliquotaDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaDeIcms(10).AliquotaDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestAliquotaDeIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaDeIcmsAnterior(10).AliquotaDeIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestAliquotaDeIcmsEfetivoDoItem;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaDeIcmsEfetivoDoItem(33).AliquotaDeIcmsEfetivoDoItem;
  CheckTrue(ReturnValue = 33);
end;

procedure TestResultadoRegrasTributacao.TestAliquotaReduzidaDaSt;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.AliquotaReduzidaDaSt(11).AliquotaReduzidaDaSt;
  CheckTrue(ReturnValue = 11);
end;

procedure TestResultadoRegrasTributacao.TestAtendeRegrasAtoDeclaratorioDF;
Var
  ReturnValue: Boolean;
begin
  ReturnValue := FResultadoRegrasTributacao.AtendeRegrasAtoDeclaratorioDF(True).AtendeRegrasAtoDeclaratorioDF;
  CheckTrue( ReturnValue );
end;

procedure TestResultadoRegrasTributacao.TestBaseDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.BaseDaSubstituicaoTributariaSimulada(10).BaseDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestBaseDeCalculoDoIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.BaseDeCalculoDoIcmsAnterior(10).BaseDeCalculoDoIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestCodigoDaSubstituicaoTributaria;
Var
  ReturnValue : string;
begin
  ReturnValue := FResultadoRegrasTributacao.CodigoDaSubstituicaoTributaria('010').CodigoDaSubstituicaoTributaria;
  CheckTrue(ReturnValue = '010');
end;

procedure TestResultadoRegrasTributacao.TestPercentualDaBaseDaSubstituicaoTributariaDoItem;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.PercentualDaBaseDaSubstituicaoTributariaDoItem(33).PercentualDaBaseDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 33);
end;

procedure TestResultadoRegrasTributacao.TestPercentualDaBaseDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.PercentualDaBaseDeIcms(10).PercentualDaBaseDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestPercentualDeReducaoDaBaseDeIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.PercentualDeReducaoDaBaseDeIcms(10).PercentualDeReducaoDaBaseDeIcms;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestReducaoRICMPR;
Var
  ReturnValue : String;
begin
  ReturnValue := FResultadoRegrasTributacao.ReducaoRICMPR('').ReducaoRICMPR;
  CheckTrue(ReturnValue = '');
end;

procedure TestResultadoRegrasTributacao.TestValorDaSubstituicaoTributariaSimulada;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorDaSubstituicaoTributariaSimulada(10).ValorDaSubstituicaoTributariaSimulada;
  CheckTrue(ReturnValue = 10);
end;

procedure TestResultadoRegrasTributacao.TestValorDoIcmsAnterior;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorDoIcmsAnterior(10).ValorDoIcmsAnterior;
  CheckTrue(ReturnValue = 10);
end;


procedure TestResultadoRegrasTributacao.TestValorDoIva;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorDoIva(191).ValorDoIva;
  CheckTrue(ReturnValue = 191);
end;

procedure TestResultadoRegrasTributacao.TestValorDoIvaMatriz;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorDoIvaMatriz(180).ValorDoIvaMatriz;
  CheckTrue(ReturnValue = 180);
end;

procedure TestResultadoRegrasTributacao.TestValorDoIvaStMatriz;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorDoIvaMatriz(111).ValorDoIvaMatriz;
  CheckTrue(ReturnValue = 111);
end;

procedure TestResultadoRegrasTributacao.TestValorIcmsEstado;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorIcmsEstado(115).ValorIcmsEstado;
  CheckTrue(ReturnValue = 115);
end;

procedure TestResultadoRegrasTributacao.TestValorIVAEspecialClienteMTIcms;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorIVAEspecialClienteMTIcms(999).ValorIVAEspecialClienteMTIcms;
  CheckTrue(ReturnValue = 999);
end;

procedure TestResultadoRegrasTributacao.TestValorIVAEspecialClienteMTSt;
Var
  ReturnValue : Double;
begin
  ReturnValue := FResultadoRegrasTributacao.ValorIVAEspecialClienteMTSt(32).ValorIVAEspecialClienteMTSt;
  CheckTrue(ReturnValue = 32);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTParametrosTributacao.Suite);
  RegisterTest(TestResultadoRegrasTributacao.Suite);
  RegisterTest(TestTResultadoTributacao.Suite);
end.

