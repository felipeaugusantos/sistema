unit TestCFOPOrdemDeProducaoAvulsaTintometrico;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPOrdemDeProducaoAvulsaTintometrico = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestOrdemDeProducaoAvulsaTintometricoEmprestimo;
    procedure TestOrdemDeProducaoAvulsaTintometrico;
  end;

implementation

uses untCFOPOrdemDeProducaoAvulsaTintometrico, untTypesCFOP, System.SysUtils;

procedure TestTCFOPOrdemDeProducaoAvulsaTintometrico.SetUp;
begin
end;

procedure TestTCFOPOrdemDeProducaoAvulsaTintometrico.TearDown;
begin
end;

procedure TestTCFOPOrdemDeProducaoAvulsaTintometrico.TestOrdemDeProducaoAvulsaTintometrico;
  Var
    LCFOPOrdemDeProducaoAvulsaTintometrico : TCFOPOrdemDeProducaoAvulsaTintometrico;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.TipoDeEmprestimo := 'S';
  LCFOPOrdemDeProducaoAvulsaTintometrico := TCFOPOrdemDeProducaoAvulsaTintometrico.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPOrdemDeProducaoAvulsaTintometrico.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5888');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPOrdemDeProducaoAvulsaTintometrico);
  End;
end;

procedure TestTCFOPOrdemDeProducaoAvulsaTintometrico.TestOrdemDeProducaoAvulsaTintometricoEmprestimo;
  Var
    LCFOPOrdemDeProducaoAvulsaTintometrico : TCFOPOrdemDeProducaoAvulsaTintometrico;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.TipoDeEmprestimo := 'E';
  LCFOPOrdemDeProducaoAvulsaTintometrico := TCFOPOrdemDeProducaoAvulsaTintometrico.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPOrdemDeProducaoAvulsaTintometrico.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1888');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPOrdemDeProducaoAvulsaTintometrico);
  End;
end;

initialization
  RegisterTest(TestTCFOPOrdemDeProducaoAvulsaTintometrico.Suite);

end.

