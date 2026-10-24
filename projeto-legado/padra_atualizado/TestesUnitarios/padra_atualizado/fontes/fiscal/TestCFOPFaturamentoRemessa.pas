unit TestCFOPFaturamentoRemessa;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPFaturamentoRemessa = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFaturamentoRemessaEnvioMercadoria;
  end;

implementation

uses untCFOPFaturamentoRemessa, untTypesCFOP, System.SysUtils;

procedure TestTCFOPFaturamentoRemessa.SetUp;
begin
end;

procedure TestTCFOPFaturamentoRemessa.TearDown;
begin
end;

procedure TestTCFOPFaturamentoRemessa.TestFaturamentoRemessaEnvioMercadoria;
  Var
    LCFOPFaturamentoRemessa : TCFOPFaturamentoRemessa;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPFaturamentoRemessa := TCFOPFaturamentoRemessa.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_VENDA_FORA_ESTABELECIMENTO, '104');
    LInputOutputClassificacao := LCFOPFaturamentoRemessa.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1104');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPFaturamentoRemessa);
  End;
end;

initialization
  RegisterTest(TestTCFOPFaturamentoRemessa.Suite);

end.

