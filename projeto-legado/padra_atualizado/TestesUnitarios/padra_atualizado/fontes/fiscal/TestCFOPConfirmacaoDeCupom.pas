unit TestCFOPConfirmacaoDeCupom;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPConfirmacaoDeCupom = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal;
  end;

implementation

uses untCFOPConfirmacaoDeCupom, untTypesCFOP, System.SysUtils;

procedure TestTCFOPConfirmacaoDeCupom.SetUp;
begin
end;

procedure TestTCFOPConfirmacaoDeCupom.TearDown;
begin
end;

procedure TestTCFOPConfirmacaoDeCupom.TestClassificacaoFiscal;
  Var
    LCFOPConfirmacaoDeCupom : TCFOPConfirmacaoDeCupom;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPConfirmacaoDeCupom := TCFOPConfirmacaoDeCupom.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_CONFIRMACAO, '929');
    LInputOutputClassificacao := LCFOPConfirmacaoDeCupom.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1929');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoDeCupom);
  End;
end;

initialization
  RegisterTest(TestTCFOPConfirmacaoDeCupom.Suite);

end.

