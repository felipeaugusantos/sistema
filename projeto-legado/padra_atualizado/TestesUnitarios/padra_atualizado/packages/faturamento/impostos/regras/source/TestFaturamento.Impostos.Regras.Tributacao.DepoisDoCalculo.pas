unit TestFaturamento.Impostos.Regras.Tributacao.DepoisDoCalculo;

interface

uses
  TestFramework,
  Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo,
  Faturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo,
  Faturamento.Impostos.Regras.Tributacao.DepoisDoCalculo;

type

  TestTImpostosRegrasDepoisDoCalculo = class(TTestCase)
  strict private
    FReducaoRICMPR : Boolean;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem : Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;

    procedure SetarParametrosDefault;
    function RetornarClasseParametros : IParametrosRegrasTributacaoDepoisDoCalculo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestResultadoRegrasTributacaoDepoisDoCalculo;
    procedure TestResultadoRegrasTributacaoDepoisDoCalculo_AliquotaDaSubstituicaoTributariaDoItemSemBaseDeCalculo;
    procedure TestResultadoRegrasTributacaoDepoisDoCalculo_AliquotaDaSubstituicaoTributariaDoItemComBaseDeCalculo;
    procedure TestReducaoPercentualBaseSubstituicaoTributaria;
    procedure TestReducaoPercentualBaseSubstituicaoTributariaReducaoRICMPR;
    procedure TestAliquotaDaSubstituicaoTributariaDoItemSemBaseDeCalculo;
    procedure TestAliquotaDaSubstituicaoTributariaDoItemComBaseDeCalculo;
  end;

implementation


function TestTImpostosRegrasDepoisDoCalculo.RetornarClasseParametros: IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result :=
    TParametrosRegrasTributacaoDepoisDoCalculo.New
      .ReducaoRICMPR(FReducaoRICMPR)
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FPercentualDaBaseDaSubstituicaoTributariaDoItem)
      .AliquotaDaSubstituicaoTributariaDoItem(FAliquotaDaSubstituicaoTributariaDoItem);
end;

procedure TestTImpostosRegrasDepoisDoCalculo.SetarParametrosDefault;
begin
  FReducaoRICMPR := false;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := 10;
  FAliquotaDaSubstituicaoTributariaDoItem := 0;
end;

procedure TestTImpostosRegrasDepoisDoCalculo.SetUp;
begin
  inherited;

end;

procedure TestTImpostosRegrasDepoisDoCalculo.TearDown;
begin
  inherited;

end;


procedure TestTImpostosRegrasDepoisDoCalculo.TestAliquotaDaSubstituicaoTributariaDoItemComBaseDeCalculo;
Var
  ReturnValue : IRegraImpostosTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  FAliquotaDaSubstituicaoTributariaDoItem := 18;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).AliquotaDaSubstituicaoTributariaDoItem;

  CheckTrue(ReturnValue <> Nil);
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestAliquotaDaSubstituicaoTributariaDoItemSemBaseDeCalculo;
Var
  ReturnValue : IRegraImpostosTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).AliquotaDaSubstituicaoTributariaDoItem;

  CheckTrue(ReturnValue <> Nil);
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestReducaoPercentualBaseSubstituicaoTributaria;
Var
  ReturnValue : IRegraImpostosTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).ReducaoPercentualBaseSubstituicaoTributaria;


  CheckTrue(ReturnValue <> Nil );
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestReducaoPercentualBaseSubstituicaoTributariaReducaoRICMPR;
Var
  ReturnValue : IRegraImpostosTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;
  FReducaoRICMPR := True;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).ReducaoPercentualBaseSubstituicaoTributaria;

  CheckTrue(ReturnValue <> Nil );
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestResultadoRegrasTributacaoDepoisDoCalculo;
Var
  ReturnValue : IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).ResultadoRegrasTributacaoDepoisDoCalculo;

  CheckTrue(ReturnValue.PercentualDaBaseDaSubstituicaoTributariaDoItem = 0);
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestResultadoRegrasTributacaoDepoisDoCalculo_AliquotaDaSubstituicaoTributariaDoItemComBaseDeCalculo;
Var
  ReturnValue : IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  FAliquotaDaSubstituicaoTributariaDoItem := 18;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).AliquotaDaSubstituicaoTributariaDoItem.ResultadoRegrasTributacaoDepoisDoCalculo;

  CheckTrue((ReturnValue.PercentualDaBaseDaSubstituicaoTributariaDoItem = 0) And
            (ReturnValue.AliquotaDaSubstituicaoTributariaDoItem = 18));
end;

procedure TestTImpostosRegrasDepoisDoCalculo.TestResultadoRegrasTributacaoDepoisDoCalculo_AliquotaDaSubstituicaoTributariaDoItemSemBaseDeCalculo;
Var
  ReturnValue : IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  SetarParametrosDefault;

  ReturnValue := TRegraImpostosTributacaoDepoisDoCalculo.New(RetornarClasseParametros).AliquotaDaSubstituicaoTributariaDoItem.ResultadoRegrasTributacaoDepoisDoCalculo;

  CheckTrue((ReturnValue.PercentualDaBaseDaSubstituicaoTributariaDoItem = 0) And
            (ReturnValue.AliquotaDaSubstituicaoTributariaDoItem = 0));
end;

initialization
  RegisterTest(TestTImpostosRegrasDepoisDoCalculo.Suite);
end.

