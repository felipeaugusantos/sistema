unit TestCFOPDevolucaoDemonstracao;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPDevolucaoDemonstracao = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalForaDoEstado;
    procedure TestClassificacaoFiscalDentroDoEstado;
  end;

implementation

uses untCFOPDevolucaoDemonstracao, untTypesCFOP, System.SysUtils;

procedure TestTCFOPDevolucaoDemonstracao.SetUp;
begin
end;

procedure TestTCFOPDevolucaoDemonstracao.TearDown;
begin
end;

procedure TestTCFOPDevolucaoDemonstracao.TestClassificacaoFiscalDentroDoEstado;
  Var
    LCFOPDevolucaoDemonstracao : TCFOPDevolucaoDemonstracao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPDevolucaoDemonstracao := TCFOPDevolucaoDemonstracao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPDevolucaoDemonstracao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1913');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoDemonstracao);
  End;
end;

procedure TestTCFOPDevolucaoDemonstracao.TestClassificacaoFiscalForaDoEstado;
  Var
    LCFOPDevolucaoDemonstracao : TCFOPDevolucaoDemonstracao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LCFOPDevolucaoDemonstracao := TCFOPDevolucaoDemonstracao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPDevolucaoDemonstracao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2913');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoDemonstracao);
  End;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCFOPDevolucaoDemonstracao.Suite);
end.

