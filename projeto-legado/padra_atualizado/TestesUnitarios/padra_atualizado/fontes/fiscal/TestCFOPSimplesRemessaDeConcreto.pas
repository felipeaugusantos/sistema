unit TestCFOPSimplesRemessaDeConcreto;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPSimplesRemessaDeConcreto = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalSimplesRemessaDeConcentro;
  end;

implementation

uses untCFOPSimplesRemessaDeConcreto, untTypesCFOP, System.SysUtils;

procedure TestTCFOPSimplesRemessaDeConcreto.SetUp;
begin
end;

procedure TestTCFOPSimplesRemessaDeConcreto.TearDown;
begin
end;

procedure TestTCFOPSimplesRemessaDeConcreto.TestClassificacaoFiscalSimplesRemessaDeConcentro;
  Var
    LCFOPSimplesRemessaDeConcreto : TCFOPSimplesRemessaDeConcreto;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPSimplesRemessaDeConcreto := TCFOPSimplesRemessaDeConcreto.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPSimplesRemessaDeConcreto.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPSimplesRemessaDeConcreto);
  End;
end;

initialization
  RegisterTest(TestTCFOPSimplesRemessaDeConcreto.Suite);

end.

