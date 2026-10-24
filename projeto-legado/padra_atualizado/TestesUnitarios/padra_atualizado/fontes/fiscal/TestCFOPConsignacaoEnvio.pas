unit TestCFOPConsignacaoEnvio;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPConsignacaoEnvio = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestConsignacaoEnvioMercadoria;
  end;

implementation

uses untCFOPConsignacaoEnvio, untTypesCFOP, System.SysUtils;

procedure TestTCFOPConsignacaoEnvio.SetUp;
begin
end;

procedure TestTCFOPConsignacaoEnvio.TearDown;
begin
end;

procedure TestTCFOPConsignacaoEnvio.TestConsignacaoEnvioMercadoria;
  Var
    LCFOPConsignacaoEnvio : TCFOPConsignacaoEnvio;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPConsignacaoEnvio := TCFOPConsignacaoEnvio.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_ENVIO_MERCADORIA_CONSIGNACAO, '5666');
    LInputOutputClassificacao := LCFOPConsignacaoEnvio.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1666');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsignacaoEnvio);
  End;
end;

initialization
  RegisterTest(TestTCFOPConsignacaoEnvio.Suite);

end.

