unit TestCFOPBrinde;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPBrinde = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal5910;
    procedure TestClassificacaoFiscal6910;
    procedure TestClassificacaoFiscalPrefixoVazio910;
  end;

implementation

uses untCFOPBrinde, untTypesCFOP, System.SysUtils;

procedure TestTCFOPBrinde.SetUp;
begin
end;

procedure TestTCFOPBrinde.TearDown;
begin
end;

procedure TestTCFOPBrinde.TestClassificacaoFiscal5910;
  Var
    LCFOPBrinde : TCFOPBrinde;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPBrinde := TCFOPBrinde.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BRINDE, '910');
    LInputOutputClassificacao := LCFOPBrinde.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5910');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBrinde);
  End;
end;

procedure TestTCFOPBrinde.TestClassificacaoFiscal6910;
  Var
    LCFOPBrinde : TCFOPBrinde;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPBrinde := TCFOPBrinde.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BRINDE, '910');
    LInputOutputClassificacao := LCFOPBrinde.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6910');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBrinde);
  End;
end;

procedure TestTCFOPBrinde.TestClassificacaoFiscalPrefixoVazio910;
  Var
    LCFOPBrinde : TCFOPBrinde;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBrinde := TCFOPBrinde.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BRINDE, '910');
    LInputOutputClassificacao := LCFOPBrinde.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '910');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBrinde);
  End;
end;

initialization
  RegisterTest(TestTCFOPBrinde.Suite);
end.

