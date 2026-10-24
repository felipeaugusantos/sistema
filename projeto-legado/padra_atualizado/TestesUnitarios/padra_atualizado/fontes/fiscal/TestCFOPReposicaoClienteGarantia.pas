unit TestCFOPReposicaoClienteGarantia;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPReposicaoClienteGarantia = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal5999;
    procedure TestClassificacaoFiscal6999;
    procedure TestClassificacaoFiscalPrefixoVazio999;
  end;

implementation

uses untCFOPReposicaoClienteGarantia, untTypesCFOP, System.SysUtils;

procedure TestTCFOPReposicaoClienteGarantia.SetUp;
begin
end;

procedure TestTCFOPReposicaoClienteGarantia.TearDown;
begin
end;

procedure TestTCFOPReposicaoClienteGarantia.TestClassificacaoFiscal5999;
  Var
    LCFOPReposicaoClienteGarantia : TCFOPReposicaoClienteGarantia;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPReposicaoClienteGarantia := TCFOPReposicaoClienteGarantia.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE, '999');
    LInputOutputClassificacao := LCFOPReposicaoClienteGarantia.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPReposicaoClienteGarantia);
  End;
end;

procedure TestTCFOPReposicaoClienteGarantia.TestClassificacaoFiscal6999;
  Var
    LCFOPReposicaoClienteGarantia : TCFOPReposicaoClienteGarantia;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPReposicaoClienteGarantia := TCFOPReposicaoClienteGarantia.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE, '999');
    LInputOutputClassificacao := LCFOPReposicaoClienteGarantia.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPReposicaoClienteGarantia);
  End;
end;

procedure TestTCFOPReposicaoClienteGarantia.TestClassificacaoFiscalPrefixoVazio999;
  Var
    LCFOPReposicaoClienteGarantia : TCFOPReposicaoClienteGarantia;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPReposicaoClienteGarantia := TCFOPReposicaoClienteGarantia.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIF_REPOSICAO_GARANTIA_CLIENTE, '999');
    LInputOutputClassificacao := LCFOPReposicaoClienteGarantia.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPReposicaoClienteGarantia);
  End;
end;

initialization
  RegisterTest(TestTCFOPReposicaoClienteGarantia.Suite);

end.
