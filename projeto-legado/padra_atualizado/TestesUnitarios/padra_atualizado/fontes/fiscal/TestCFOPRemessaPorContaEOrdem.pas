unit TestCFOPRemessaPorContaEOrdem;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRemessaPorContaEOrdem = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRemessaPorContaEOrdem;
    procedure TestRemessaPorContaEOrdemCFGVazia;
  end;

implementation

uses untCFOPRemessaPorContaEOrdem, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRemessaPorContaEOrdem.SetUp;
begin
end;

procedure TestTCFOPRemessaPorContaEOrdem.TearDown;
begin
end;

procedure TestTCFOPRemessaPorContaEOrdem.TestRemessaPorContaEOrdem;
  Var
    LCFOPRemessaPorContaEOrdem : TCFOPRemessaPorContaEOrdem;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPRemessaPorContaEOrdem := TCFOPRemessaPorContaEOrdem.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaPorContaEOrdem.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1923');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaPorContaEOrdem);
  End;
end;

procedure TestTCFOPRemessaPorContaEOrdem.TestRemessaPorContaEOrdemCFGVazia;
  Var
    LCFOPRemessaPorContaEOrdem : TCFOPRemessaPorContaEOrdem;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPRemessaPorContaEOrdem := TCFOPRemessaPorContaEOrdem.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_NOTA_REMESSA_CONTRA_ORDEM, '');
    LInputOutputClassificacao := LCFOPRemessaPorContaEOrdem.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1923');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaPorContaEOrdem);
  End;
end;

initialization
  RegisterTest(TestTCFOPRemessaPorContaEOrdem.Suite);
end.

