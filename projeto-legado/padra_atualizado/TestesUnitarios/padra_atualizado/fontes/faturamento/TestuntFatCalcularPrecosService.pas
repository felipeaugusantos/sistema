unit TestuntFatCalcularPrecosService;

interface

Uses
  TestFramework,
  System.SysUtils,
  Vcl.Forms,
  Shared.Functions.Core,
  untFatCalcularPrecosService,
  Faturamento.Precos.Interfaces.PrecoCusto,
  Faturamento.Precos.Tipos.PrecoCusto,
  Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto;

Type
  TestTFatCalcularPrecosService = class(TTestCase)
   private

   published
     procedure TestGetFaturamentoPrecosService;
   public
    procedure SetUp; override;
    procedure TearDown; override;
  end;


implementation

{ TFatCalcularPrecosService }

procedure TestTFatCalcularPrecosService.SetUp;
begin
  inherited;

end;

procedure TestTFatCalcularPrecosService.TearDown;
begin
  inherited;

end;

procedure TestTFatCalcularPrecosService.TestGetFaturamentoPrecosService;
Var
  LPath       : String;
  ReturnValue : Double;
  LParametrosCalculoPrecoCustoMargemMarkup : IParametrosServicoPrecoCustoMargemMarkup;
begin
  LPath := ExtractFilePath(Application.ExeName)+ 'auttin\';

  LParametrosCalculoPrecoCustoMargemMarkup :=
    TParametrosServicoPrecoCustoMargemMarkup.New
      .PrecoDeVenda(49.53)
      .Margem(25)
      .DecUni(4);

  ReturnValue :=
    GetFaturamentoPrecosService(ExtractFilePath(Application.ExeName))
      .PrecoCusto.CalculaPrecoCusto(LParametrosCalculoPrecoCustoMargemMarkup)
        .ResultadoCalculoPrecoCusto
          .ValorCalculadoPrecoCusto;

  CheckTrue(ReturnValue = objCore.fFormataFloat(37.1475, 4));

end;

Initialization
  RegisterTest(TestTFatCalcularPrecosService.Suite);


end.
