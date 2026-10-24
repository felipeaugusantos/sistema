unit TestCFOPAkzoNobel;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPAkzoNobel = class(TTestCase)
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

uses untCFOPAkzoNobel, untTypesCFOP, System.SysUtils;

procedure TestTCFOPAkzoNobel.SetUp;
begin
end;

procedure TestTCFOPAkzoNobel.TearDown;
begin
end;

procedure TestTCFOPAkzoNobel.TestClassificacaoFiscal5999;
  Var
    LCFOPAkzoNobel : TCFOPAkzoNobel;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPAkzoNobel := TCFOPAkzoNobel.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_DOCUMENTO_VENDA_AKZONOBEL, '999');
    LInputOutputClassificacao := LCFOPAkzoNobel.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAkzoNobel);
  End;
end;

procedure TestTCFOPAkzoNobel.TestClassificacaoFiscal6999;
  Var
    LCFOPAkzoNobel : TCFOPAkzoNobel;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPAkzoNobel := TCFOPAkzoNobel.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_DOCUMENTO_VENDA_AKZONOBEL, '999');
    LInputOutputClassificacao := LCFOPAkzoNobel.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAkzoNobel);
  End;
end;

procedure TestTCFOPAkzoNobel.TestClassificacaoFiscalPrefixoVazio999;
  Var
    LCFOPAkzoNobel : TCFOPAkzoNobel;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPAkzoNobel := TCFOPAkzoNobel.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_DOCUMENTO_VENDA_AKZONOBEL, '999');
    LInputOutputClassificacao := LCFOPAkzoNobel.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAkzoNobel);
  End;
end;

initialization
  RegisterTest(TestTCFOPAkzoNobel.Suite);
end.

