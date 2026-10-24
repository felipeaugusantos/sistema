unit TestCFOPRemessaEstoqueExterno;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type 
  TestTCFOPRemessaEstoqueExterno = class(TTestCase)
  strict private
  public
  published
    procedure TestClassificacaoFiscal5905;
    procedure TestClassificacaoFiscal6905;
    procedure TestClassificacaoFiscal5949;
    procedure TestClassificacaoFiscal6949;
    procedure TestClassificacaoFiscalPrefixoVazio905;
  end;

implementation

uses untCFOPRemessaEstoqueExterno, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRemessaEstoqueExterno.TestClassificacaoFiscal5905;
  Var
    LCFOPRemessaEstoqueExterno : TCFOPRemessaEstoqueExterno;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPRemessaEstoqueExterno := TCFOPRemessaEstoqueExterno.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaEstoqueExterno.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5905');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaEstoqueExterno);
  End;
end;

procedure TestTCFOPRemessaEstoqueExterno.TestClassificacaoFiscal5949;
  Var
    LCFOPRemessaEstoqueExterno : TCFOPRemessaEstoqueExterno;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.RemessaEstoqueExternoClassificacao := '949';
  LCFOPRemessaEstoqueExterno := TCFOPRemessaEstoqueExterno.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaEstoqueExterno.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaEstoqueExterno);
  End;
end;

procedure TestTCFOPRemessaEstoqueExterno.TestClassificacaoFiscal6905;
  Var
    LCFOPRemessaEstoqueExterno : TCFOPRemessaEstoqueExterno;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPRemessaEstoqueExterno := TCFOPRemessaEstoqueExterno.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaEstoqueExterno.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6905');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaEstoqueExterno);
  End;
end;

procedure TestTCFOPRemessaEstoqueExterno.TestClassificacaoFiscal6949;
  Var
    LCFOPRemessaEstoqueExterno : TCFOPRemessaEstoqueExterno;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LInputDefine.RemessaEstoqueExternoClassificacao := '949';
  LCFOPRemessaEstoqueExterno := TCFOPRemessaEstoqueExterno.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaEstoqueExterno.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaEstoqueExterno);
  End;
end;

procedure TestTCFOPRemessaEstoqueExterno.TestClassificacaoFiscalPrefixoVazio905;
  Var
    LCFOPRemessaEstoqueExterno : TCFOPRemessaEstoqueExterno;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '';
  LCFOPRemessaEstoqueExterno := TCFOPRemessaEstoqueExterno.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaEstoqueExterno.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '905');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaEstoqueExterno);
  End;
end;

initialization
  RegisterTest(TestTCFOPRemessaEstoqueExterno.Suite);

end.

