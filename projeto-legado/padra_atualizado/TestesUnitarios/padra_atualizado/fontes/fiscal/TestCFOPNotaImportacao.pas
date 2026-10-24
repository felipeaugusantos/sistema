unit TestCFOPNotaImportacao;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPNotaImportacao = class(TTestCase)
  strict private
    procedure pSetarValoresDefault;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestNotaImportacao;
    procedure TestNotaImportacaoContribuinteIPI;
  end;

implementation

uses untCFOPNotaImportacao, untTypesCFOP, System.SysUtils;

procedure TestTCFOPNotaImportacao.pSetarValoresDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
end;

procedure TestTCFOPNotaImportacao.SetUp;
begin
  pSetarValoresDefault;
end;

procedure TestTCFOPNotaImportacao.TearDown;
begin
end;

procedure TestTCFOPNotaImportacao.TestNotaImportacao;
  Var
    LCFOPNotaImportacao : TCFOPNotaImportacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPNotaImportacao := TCFOPNotaImportacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_NOTA_IMPORTACAO, '3102');
    LInputOutputClassificacao := LCFOPNotaImportacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '3102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '3');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNotaImportacao);
  End;
end;

procedure TestTCFOPNotaImportacao.TestNotaImportacaoContribuinteIPI;
  Var
    LCFOPNotaImportacao : TCFOPNotaImportacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPNotaImportacao := TCFOPNotaImportacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_NOTA_IMPORTACAO, '3101');
    LInputOutputClassificacao := LCFOPNotaImportacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '3101');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '3');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNotaImportacao);
  End;
end;

initialization
  RegisterTest(TestTCFOPNotaImportacao.Suite);

end.

