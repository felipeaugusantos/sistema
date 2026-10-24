unit TestFaturamento.Impostos.Tipos.AliquotasDeRetencao;

interface

uses
  TestFramework,
  Faturamento.Impostos.Interfaces.AliquotasDeRetencao,
  Faturamento.Impostos.Tipos.AliquotasDeRetencao,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model;

type

  TestTiposAliquotasRetencao  = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCodigoCliente;
    procedure TestAliquotaIRPJ;
    procedure TestAliquotaPIS;
    procedure TestAliquotaCOFINS;
    procedure TestAliquotaCSLL;
    procedure TestAliquotaProdutoIRPJ;
    procedure TestAliquotaProdutoPIS;
    procedure TestAliquotaProdutoCOFINS;
    procedure TestAliquotaProdutoCSLL;
    procedure TestValorMinimoRetencaoPisCofinsCsll;
    procedure TestValorMinimoRetencaoIRPJ;
    procedure TestParametrosClienteConsumidor;
    procedure TestClienteConsumidorFinal;
  end;

implementation

procedure TestTiposAliquotasRetencao.SetUp;
begin

end;

procedure TestTiposAliquotasRetencao.TearDown;
begin

end;

procedure TestTiposAliquotasRetencao.TestAliquotaCOFINS;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaCOFINS(10).AliquotaCOFINS;

  CheckTrue(ReturnValue = 10);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaCSLL;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaCSLL(60).AliquotaCSLL;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaIRPJ;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaIRPJ(60).AliquotaIRPJ;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaPIS;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaPIS(60).AliquotaPIS;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaProdutoCOFINS;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaProdutoCOFINS(60).AliquotaProdutoCOFINS;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaProdutoCSLL;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaProdutoCSLL(60).AliquotaProdutoCSLL;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaProdutoIRPJ;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaProdutoIRPJ(60).AliquotaProdutoIRPJ;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestAliquotaProdutoPIS;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.AliquotaProdutoPIS(60).AliquotaProdutoPIS;

  CheckTrue(ReturnValue = 60);
end;

procedure TestTiposAliquotasRetencao.TestClienteConsumidorFinal;
var
  ReturnValue: Boolean;
begin
  ReturnValue := TParametrosAliquotasDeRetencao.New.ClienteConsumidorFinal(True).ClienteConsumidorFinal;
  CheckTrue(ReturnValue);
end;

procedure TestTiposAliquotasRetencao.TestCodigoCliente;
var
  ReturnValue: String;
begin
  ReturnValue := TParametrosAliquotasDeRetencao.New.CodigoDoCliente('0601010').CodigoDoCliente;

  CheckTrue(ReturnValue = '0601010');
end;

procedure TestTiposAliquotasRetencao.TestParametrosClienteConsumidor;
Var
  FParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
  ReturnValue : IParametrosFaturamentoImpostosClienteConsumidor;
begin
  FParametrosClienteConsumidor :=
    TParametrosFaturamentoImpostosClienteConsumidor.New
      .ClienteEstado('SP')
      .ClienteInscricaoEstadual('100000')
      .ClienteAtividade('010')
      .CalcularDescontoIcmsOrgaoPublico(true);

  ReturnValue :=
    TParametrosAliquotasDeRetencao.New
      .ParametrosClienteConsumidor(FParametrosClienteConsumidor).ParametrosClienteConsumidor;

  CheckTrue( (ReturnValue.ClienteEstado = 'SP') And
             (ReturnValue.ClienteInscricaoEstadual = '100000') And
             (ReturnValue.ClienteAtividade = '010') And
             (ReturnValue.CalcularDescontoIcmsOrgaoPublico = true) );


end;

procedure TestTiposAliquotasRetencao.TestValorMinimoRetencaoIRPJ;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.ValorMinimoRetencaoIRPJ(1).ValorMinimoRetencaoIRPJ;

  CheckTrue(ReturnValue = 1);
end;

procedure TestTiposAliquotasRetencao.TestValorMinimoRetencaoPisCofinsCsll;
var
  ReturnValue: Double;
begin
  ReturnValue := TResultadoAliquotasDeRetencao.New.ValorMinimoRetencaoPisCofinsCsll(10).ValorMinimoRetencaoPisCofinsCsll;

  CheckTrue(ReturnValue = 10);
end;

initialization
  RegisterTest(TestTiposAliquotasRetencao.Suite);
end.

