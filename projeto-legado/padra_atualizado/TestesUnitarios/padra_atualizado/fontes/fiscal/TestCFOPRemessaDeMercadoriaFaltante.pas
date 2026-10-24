unit TestCFOPRemessaDeMercadoriaFaltante;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRemessaDeMercadoriaFaltante = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRemessaDeMercadoriaFaltante;
  end;

implementation

uses untCFOPRemessaDeMercadoriaFaltante, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRemessaDeMercadoriaFaltante.SetUp;
begin
end;

procedure TestTCFOPRemessaDeMercadoriaFaltante.TearDown;
begin
end;

procedure TestTCFOPRemessaDeMercadoriaFaltante.TestRemessaDeMercadoriaFaltante;
  Var
    LCFOPRemessaDeMercadoriaFaltante : TCFOPRemessaDeMercadoriaFaltante;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPRemessaDeMercadoriaFaltante := TCFOPRemessaDeMercadoriaFaltante.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRemessaDeMercadoriaFaltante.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRemessaDeMercadoriaFaltante);
  End;
end;

initialization
  RegisterTest(TestTCFOPRemessaDeMercadoriaFaltante.Suite);

end.

