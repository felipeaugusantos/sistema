unit TestCFOPEmprestimo;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPEmprestimo = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal1999;
    procedure TestClassificacaoFiscal5999;
  end;

implementation

uses untCFOPEmprestimo, untTypesCFOP, System.SysUtils;

procedure TestTCFOPEmprestimo.SetUp;
begin
end;

procedure TestTCFOPEmprestimo.TearDown;
begin
end;

procedure TestTCFOPEmprestimo.TestClassificacaoFiscal1999;
  Var
    LCFOPEmprestimo : TCFOPEmprestimo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.TipoDeEmprestimo := 'E';
  LCFOPEmprestimo := TCFOPEmprestimo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEmprestimo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEmprestimo);
  End;
end;

procedure TestTCFOPEmprestimo.TestClassificacaoFiscal5999;
  Var
    LCFOPEmprestimo : TCFOPEmprestimo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.TipoDeEmprestimo := 'S';
  LCFOPEmprestimo := TCFOPEmprestimo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEmprestimo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEmprestimo);
  End;
end;

initialization
  RegisterTest(TestTCFOPEmprestimo.Suite);

end.

