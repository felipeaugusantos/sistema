unit TestFaturamento.Impostos.Tipos.Iva;

interface

uses
  TestFramework,
  Faturamento.Impostos.Interfaces.Model,
  Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Iva,
  Faturamento.Impostos.tipos.Iva;

type

  TestTParametrosIva = class(TTestCase)
  Strict private
    FParametrosCalculoIva: TParametrosCalculoIva;
  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Published
    procedure TestPercentualDoIvaAbreviacao;
    procedure TestModelClienteFornecedor;
    procedure TestModelProduto;
    procedure TestModelEmpresa;
    procedure TestCodigoDaSituacaoTributaria;
    procedure TestCodigoDaSubstituicaoTributaria;
    procedure TestTipoDaAbreviacaoFiscal;
    procedure TestDentroDoEstado;
	  procedure TestTotalGeralDoItem;
    procedure TestValorDeIpiDoItem;
    procedure TestAliquotaDeIcmsDoItem;
    procedure TestAliquotaDaSubstituicaoTributariaDoItem;
    procedure TestDocumentoParaFornecedor;
    procedure TestExisteNaTabelaCEDEM;
  end;

  TestTResultadoIva = class(TTestCase)
  strict private
    FResultadoCalculoIva: TResultadoCalculoIva;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    Procedure TestValorDoIva;
    Procedure TestValorDoIvaMatriz;
    Procedure TestValorDoIvaStMatriz;
    Procedure TestClienteIVAEspMT;
  end;


implementation

procedure TestTParametrosIva.TestAliquotaDaSubstituicaoTributariaDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosCalculoIva.AliquotaDaSubstituicaoTributariaDoItem(125).AliquotaDaSubstituicaoTributariaDoItem;
  CheckTrue(ReturnValue = 125);
end;

procedure TestTParametrosIva.TestAliquotaDeIcmsDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosCalculoIva.AliquotaDeIcmsDoItem(10).AliquotaDeIcmsDoItem;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTParametrosIva.TestCodigoDaSituacaoTributaria;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosCalculoIva.CodigoDaSituacaoTributaria('060').CodigoDaSituacaoTributaria;
  CheckTrue(ReturnValue = '060');
end;

procedure TestTParametrosIva.TestCodigoDaSubstituicaoTributaria;
var
  ReturnValue: String;
begin
  ReturnValue := FParametrosCalculoIva.CodigoDaSubstituicaoTributaria('999').CodigoDaSubstituicaoTributaria;
  CheckTrue(ReturnValue = '999');
end;

procedure TestTParametrosIva.TestDentroDoEstado;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosCalculoIva.DentroDoEstado(True).DentroDoEstado;
  CheckTrue(ReturnValue = True);
end;

procedure TestTParametrosIva.TestDocumentoParaFornecedor;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosCalculoIva.DocumentoParaFornecedor(True).DocumentoParaFornecedor;
  CheckTrue(ReturnValue = True);
end;

procedure TestTParametrosIva.TestExisteNaTabelaCEDEM;
var
  ReturnValue: Boolean;
begin
  ReturnValue := FParametrosCalculoIva.ExisteNaTabelaCEDEM(True).ExisteNaTabelaCEDEM;
  CheckTrue(ReturnValue = True);
end;

procedure TestTParametrosIva.TestModelClienteFornecedor;
var
  ReturnValue: IResultadoFaturamentoImpostosModelClienteFornecedor;
begin
  ReturnValue := FParametrosCalculoIva.ModelClienteFornecedor(Nil).ModelClienteFornecedor;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosIva.TestModelEmpresa;
var
  ReturnValue: IResultadoFaturamentoImpostosModelEmpresa;
begin
  ReturnValue := FParametrosCalculoIva.ModelEmpresa(Nil).ModelEmpresa;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosIva.TestModelProduto;
var
  ReturnValue: IResultadoFaturamentoImpostosModelProduto;
begin
  ReturnValue := FParametrosCalculoIva.ModelProduto(Nil).ModelProduto;
  CheckTrue(ReturnValue = Nil);
end;

procedure TestTParametrosIva.TestPercentualDoIvaAbreviacao;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosCalculoIva.PercentualDoIvaAbreviacao(32).PercentualDoIvaAbreviacao;
  CheckTrue(ReturnValue = 32);
end;

procedure TestTParametrosIva.SetUp;
begin
  FParametrosCalculoIva := TParametrosCalculoIva.Create;
end;

procedure TestTParametrosIva.TearDown;
begin
  FParametrosCalculoIva := nil;
end;


procedure TestTParametrosIva.TestTipoDaAbreviacaoFiscal;
Var
  ReturnValue : String;
begin
  ReturnValue := FParametrosCalculoIva.TipoDaAbreviacaoFiscal('_SAI_CNC').TipoDaAbreviacaoFiscal;
  CheckTrue(ReturnValue = '_SAI_CNC');
end;

procedure TestTParametrosIva.TestTotalGeralDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosCalculoIva.TotalGeralDoItem(33).TotalGeralDoItem;
  CheckTrue(ReturnValue = 33);
end;

procedure TestTParametrosIva.TestValorDeIpiDoItem;
var
  ReturnValue: Double;
begin
  ReturnValue := FParametrosCalculoIva.ValorDeIpiDoItem(15).ValorDeIpiDoItem;
  CheckTrue(ReturnValue = 15);
end;

procedure TestTResultadoIva.SetUp;
begin
  FResultadoCalculoIva := TResultadoCalculoIva.Create;;
end;

procedure TestTResultadoIva.TearDown;
begin
  FResultadoCalculoIva := nil;
end;


procedure TestTResultadoIva.TestClienteIVAEspMT;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoCalculoIva.ClienteIVAEspMT(30).ClienteIVAEspMT;
  CheckTrue(ReturnValue = 30);
end;

procedure TestTResultadoIva.TestValorDoIva;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoCalculoIva.ValorDoIva(15).ValorDoIva;
  CheckTrue(ReturnValue = 15);
end;

procedure TestTResultadoIva.TestValorDoIvaMatriz;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoCalculoIva.ValorDoIvaMatriz(10).ValorDoIvaMatriz;
  CheckTrue(ReturnValue = 10);
end;

procedure TestTResultadoIva.TestValorDoIvaStMatriz;
var
  ReturnValue: Double;
begin
  ReturnValue := FResultadoCalculoIva.ValorDoIvaStMatriz(52).ValorDoIvaStMatriz;
  CheckTrue(ReturnValue = 52);
end;

initialization
  RegisterTest(TestTParametrosIva.Suite);
  RegisterTest(TestTResultadoIva.Suite);
end.

