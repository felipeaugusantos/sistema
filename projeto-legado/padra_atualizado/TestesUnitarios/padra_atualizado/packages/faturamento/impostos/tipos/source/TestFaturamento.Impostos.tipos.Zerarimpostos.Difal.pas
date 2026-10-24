unit TestFaturamento.Impostos.tipos.Zerarimpostos.Difal;

interface

Uses
  TestFramework,
  Faturamento.impostos.tipos.zerarimpostos.difal,
  Faturamento.impostos.Interfaces.zerarimpostos.difal;
type

  TestTZerarimpostosDifal = class(TTestCase)
  Strict private

  Public
    procedure SetUp; override;
    procedure TearDown; override;
  Published
    procedure TestClienteOrgaoPublico;
    procedure TestClienteOrgaoPublicoDifal;
    procedure TestVendaPresencial;
  end;


implementation

{ TestTZerarimpostosDifal }

procedure TestTZerarimpostosDifal.SetUp;
begin
  inherited;

end;

procedure TestTZerarimpostosDifal.TearDown;
begin
  inherited;

end;

procedure TestTZerarimpostosDifal.TestClienteOrgaoPublico;
Var
  ReturnValue: Boolean;
begin
  ReturnValue := TParametrosRegraZerarImpostosDifal.New.ClienteOrgaoPublico(true).ClienteOrgaoPublico;
  CheckTrue(ReturnValue = true);

end;

procedure TestTZerarimpostosDifal.TestClienteOrgaoPublicoDifal;
Var
  ReturnValue: Boolean;
begin
  ReturnValue :=
    TParametrosRegraZerarImpostosDifal.New.ClienteOrgaoPublicoDifal(true).ClienteOrgaoPublicoDifal;
    CheckTrue(ReturnValue = true);
end;

procedure TestTZerarimpostosDifal.TestVendaPresencial;
Var
  ReturnValue: Boolean;
begin
  ReturnValue :=
    TParametrosRegraZerarImpostosDifal.New.VendaPresencial(False).VendaPresencial;
    CheckTrue(ReturnValue = False);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTZerarimpostosDifal.Suite);
end.
