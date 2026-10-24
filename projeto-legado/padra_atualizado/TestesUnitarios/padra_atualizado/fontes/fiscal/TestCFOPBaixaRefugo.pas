unit TestCFOPBaixaRefugo;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPBaixaRefugo = class(TTestCase)
  published
    procedure TestClassificacaoFiscal5999;
    procedure TestClassificacaoFiscal6999;
    procedure TestClassificacaoFiscalPrefixoVazio999;
  end;

implementation

uses untCFOPBaixaRefugo, untTypesCFOP, System.SysUtils;

procedure TestTCFOPBaixaRefugo.TestClassificacaoFiscal5999;
  Var
    LCFOPBaixaRefugo : TCFOPBaixaRefugo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPBaixaRefugo := TCFOPBaixaRefugo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_PRODUTOS_REFUGADOS, '999');
    LInputOutputClassificacao := LCFOPBaixaRefugo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaRefugo);
  End;
end;

procedure TestTCFOPBaixaRefugo.TestClassificacaoFiscal6999;
  Var
    LCFOPBaixaRefugo : TCFOPBaixaRefugo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPBaixaRefugo := TCFOPBaixaRefugo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_PRODUTOS_REFUGADOS, '999');
    LInputOutputClassificacao := LCFOPBaixaRefugo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaRefugo);
  End;
end;

procedure TestTCFOPBaixaRefugo.TestClassificacaoFiscalPrefixoVazio999;
  Var
    LCFOPBaixaRefugo : TCFOPBaixaRefugo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPBaixaRefugo := TCFOPBaixaRefugo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_PRODUTOS_REFUGADOS, '999');
    LInputOutputClassificacao := LCFOPBaixaRefugo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaRefugo);
  End;
end;

initialization
  RegisterTest(TestTCFOPBaixaRefugo.Suite);

end.

