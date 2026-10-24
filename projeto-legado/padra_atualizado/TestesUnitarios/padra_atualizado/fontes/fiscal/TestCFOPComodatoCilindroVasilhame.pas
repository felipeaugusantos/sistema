unit TestCFOPComodatoCilindroVasilhame;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPComodatoCilindroVasilhame = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal5910;
    procedure TestClassificacaoFiscal6910;
    procedure TestClassificacaoFiscalPrefixoVazio910;
  end;

implementation

uses untCFOPComodatoCilindroVasilhame, untTypesCFOP, System.SysUtils;

procedure TestTCFOPComodatoCilindroVasilhame.SetUp;
begin
end;

procedure TestTCFOPComodatoCilindroVasilhame.TearDown;
begin
end;

procedure TestTCFOPComodatoCilindroVasilhame.TestClassificacaoFiscal5910;
  Var
    LCFOPComodatoCilindroVasilhame : TCFOPComodatoCilindroVasilhame;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPComodatoCilindroVasilhame := TCFOPComodatoCilindroVasilhame.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_COMODATO_CILINDRO_VASILHAME, '908');
    LInputOutputClassificacao := LCFOPComodatoCilindroVasilhame.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5908');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPComodatoCilindroVasilhame);
  End;
end;

procedure TestTCFOPComodatoCilindroVasilhame.TestClassificacaoFiscal6910;
  Var
    LCFOPComodatoCilindroVasilhame : TCFOPComodatoCilindroVasilhame;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPComodatoCilindroVasilhame := TCFOPComodatoCilindroVasilhame.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_COMODATO_CILINDRO_VASILHAME, '908');
    LInputOutputClassificacao := LCFOPComodatoCilindroVasilhame.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6908');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPComodatoCilindroVasilhame);
  End;
end;

procedure TestTCFOPComodatoCilindroVasilhame.TestClassificacaoFiscalPrefixoVazio910;
  Var
    LCFOPComodatoCilindroVasilhame : TCFOPComodatoCilindroVasilhame;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPComodatoCilindroVasilhame := TCFOPComodatoCilindroVasilhame.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_DE_COMODATO_CILINDRO_VASILHAME, '908');
    LInputOutputClassificacao := LCFOPComodatoCilindroVasilhame.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '908');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPComodatoCilindroVasilhame);
  End;
end;

initialization
  RegisterTest(TestTCFOPComodatoCilindroVasilhame.Suite);

end.

