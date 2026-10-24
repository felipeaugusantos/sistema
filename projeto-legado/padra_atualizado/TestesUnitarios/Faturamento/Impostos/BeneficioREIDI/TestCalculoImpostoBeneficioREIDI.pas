unit TestCalculoImpostoBeneficioREIDI;

interface

uses
  TestFramework;

type
  TestTCalculoImpostoBeneficioREIDI = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDevolucaoNormalSemDeducaoIcms;
    procedure TestDevolucaoNormalComDeducaoIcms;
    procedure TestDeducaoIcmsSemPisCofins;
    procedure TestDeducaoIcmsComPisCofins;
    procedure TestDeducaoIcmsComPisCofinsAliquotaIcms;
    procedure TestDeducaoIcmsComPisCofinsSimplesNacional;
    procedure TestClienteNaoUtilizaBeneficioREIDI;
    procedure TestBaixaDeEntregaFuturaSemDesconto;
    procedure TestBaixaDeEntregaFuturaComDesconto;
  end;

implementation

uses Shared.Functions.Configuracoes, Shared.Functions.Core, untCalculoImpostoBeneficioREIDI,
  untTypesBeneficioREIDI, SysUtils, untFuncoes;

{ TestTCalculoImpostoBeneficioREIDI }

procedure TestTCalculoImpostoBeneficioREIDI.SetUp;
begin
  inherited;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TearDown;
begin
  inherited;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDevolucaoNormalComDeducaoIcms;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 100;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.EspecieDeDevolucao := 'NF';
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 0;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 0;
  LParametrosCalculoBeneficioREIDI.BasePis := 100;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 100;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(ReturnValue.ValorDoDescontoBeneficioREIDI = 0);
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDevolucaoNormalSemDeducaoIcms;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 65;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := False;
  LParametrosCalculoBeneficioREIDI.EspecieDeDevolucao := 'NF';
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 65;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 65;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(ReturnValue.ValorDoDescontoBeneficioREIDI = 0);
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDeducaoIcmsComPisCofins;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 100;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 100;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 100;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(objCore.fFormataFloat(ReturnValue.ValorDoDescontoBeneficioREIDI, 2), 28.41));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestClienteNaoUtilizaBeneficioREIDI;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 150;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 8;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := False;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 150;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 150;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(ReturnValue.ValorDoDescontoBeneficioREIDI, 0));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestBaixaDeEntregaFuturaSemDesconto;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 150;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 8;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 150;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 150;
  LParametrosCalculoBeneficioREIDI.EhBaixaDeEntregaFutura := True;
  LParametrosCalculoBeneficioREIDI.DescontoEspecialBaixaDeEntregaFutura := 0;
  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(ReturnValue.ValorDoDescontoBeneficioREIDI, objCore.fFormataFloat(40.76, 2)));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestBaixaDeEntregaFuturaComDesconto;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 150;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 8;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 150;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 150;
  LParametrosCalculoBeneficioREIDI.EhBaixaDeEntregaFutura := True;
  LParametrosCalculoBeneficioREIDI.DescontoEspecialBaixaDeEntregaFutura := 40.76;
  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(ReturnValue.ValorDoDescontoBeneficioREIDI, objCore.fFormataFloat(40.76, 2)));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDeducaoIcmsComPisCofinsAliquotaIcms;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 150;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 8;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 150;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 150;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(ReturnValue.ValorDoDescontoBeneficioREIDI, objCore.fFormataFloat(40.76, 2)));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDeducaoIcmsComPisCofinsSimplesNacional;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 150;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 8;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 10;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 15;
  LParametrosCalculoBeneficioREIDI.BasePis := 150;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 150;
  LParametrosCalculoBeneficioREIDI.EhOptanteDoSimples := True;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(fComparaValoresDecimais(ReturnValue.ValorDoDescontoBeneficioREIDI, 0));
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

procedure TestTCalculoImpostoBeneficioREIDI.TestDeducaoIcmsSemPisCofins;
  Var
    ReturnValue: TResultadoCalculoBeneficioREIDI;
    LParametrosCalculoBeneficioREIDI: TParametrosCalculoBeneficioREIDI;
    LCalculoImpostoBeneficioREIDI : TCalculoImpostoBeneficioREIDI;
begin
  FillChar(LParametrosCalculoBeneficioREIDI, Sizeof(LParametrosCalculoBeneficioREIDI), #0);
  LParametrosCalculoBeneficioREIDI.ValorTotalDoItem := 100;
  LParametrosCalculoBeneficioREIDI.AliquotaDeIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.ValorDoIcmsDoItem := 12;
  LParametrosCalculoBeneficioREIDI.BeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.DeduzirIcmsDoBeneficioREIDI := True;
  LParametrosCalculoBeneficioREIDI.AliquotaPis := 0;
  LParametrosCalculoBeneficioREIDI.AliquotaCofins := 0;
  LParametrosCalculoBeneficioREIDI.BasePis := 100;
  LParametrosCalculoBeneficioREIDI.BaseCofins := 100;

  LCalculoImpostoBeneficioREIDI := TCalculoImpostoBeneficioREIDI.Create(objCore);
  Try
    ReturnValue := LCalculoImpostoBeneficioREIDI.CalcularBeneficioREIDI(LParametrosCalculoBeneficioREIDI);
    CheckTrue(ReturnValue.ValorDoDescontoBeneficioREIDI = 0);
  Finally
    FreeAndNil(LCalculoImpostoBeneficioREIDI);
  End;
end;

initialization
  RegisterTest(TestTCalculoImpostoBeneficioREIDI.Suite);

end.
