unit TestFaturamento.Impostos.Regras.Zerarimpostos.Difal;

interface

Uses
  TestFramework,
  faturamento.impostos.regras.zerarimpostos.difal,
  faturamento.impostos.Tipos.zerarimpostos.difal,
  faturamento.impostos.Interfaces.zerarimpostos.difal;

Type
  TestTRegrasZerarimpostosDifal = class(TTestCase)
  Strict private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifalFalse;
    procedure TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifal;
    procedure TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifal_VendaPresencial;
  end;


implementation

{ TestTRegrasZerarimpostosDifal }

procedure TestTRegrasZerarimpostosDifal.SetUp;
begin
  inherited;

end;

procedure TestTRegrasZerarimpostosDifal.TearDown;
begin
  inherited;

end;

procedure TestTRegrasZerarimpostosDifal.TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifal;
var
  ReturnValue: Boolean;
  LParametros: IParametrosRegraZerarImpostosDifal;
begin
  LParametros :=
    TParametrosRegraZerarImpostosDifal.New
      .ClienteOrgaoPublico(True)
      .ClienteOrgaoPublicoDifal(True)
      .VendaPresencial(False);

  ReturnValue := TRegraImpostosZerarImpostosDifal.New.ZerarValorDoDifal(LParametros);

  CheckTrue(ReturnValue = False);
end;

procedure TestTRegrasZerarimpostosDifal.TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifalFalse;
var
  ReturnValue: Boolean;
  LParametros: IParametrosRegraZerarImpostosDifal;
begin
  LParametros :=
    TParametrosRegraZerarImpostosDifal.New
      .ClienteOrgaoPublico(True)
      .ClienteOrgaoPublicoDifal(False)
      .VendaPresencial(False);

  ReturnValue := TRegraImpostosZerarImpostosDifal.New.ZerarValorDoDifal(LParametros);

  CheckTrue(ReturnValue = True);
end;

procedure TestTRegrasZerarimpostosDifal.TestZerarValorDoDifal_ClienteOrgaoPublico_ClienteOrgaoPublicoDifal_VendaPresencial;
var
  ReturnValue: Boolean;
  LParametros: IParametrosRegraZerarImpostosDifal;
begin
  LParametros :=
    TParametrosRegraZerarImpostosDifal.New
      .ClienteOrgaoPublico(True)
      .ClienteOrgaoPublicoDifal(True)
      .VendaPresencial(True);

  ReturnValue := TRegraImpostosZerarImpostosDifal.New.ZerarValorDoDifal(LParametros);

  CheckTrue(ReturnValue = True);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTRegrasZerarimpostosDifal.Suite);

end.
