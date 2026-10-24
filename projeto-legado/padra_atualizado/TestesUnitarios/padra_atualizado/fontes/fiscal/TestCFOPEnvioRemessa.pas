unit TestCFOPEnvioRemessa;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPEnvioRemessa = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEnvioRemessaEnvioMercadoriaDemais;
    procedure TestEnvioRemessaEnvioMercadoriaSubstituido;
  end;

implementation

uses untCFOPEnvioRemessa, untTypesCFOP, System.SysUtils;

procedure TestTCFOPEnvioRemessa.SetUp;
begin
end;

procedure TestTCFOPEnvioRemessa.TearDown;
begin
end;

procedure TestTCFOPEnvioRemessa.TestEnvioRemessaEnvioMercadoriaDemais;
  Var
    LCFOPEnvioRemessa : TCFOPEnvioRemessa;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.ItemSubstituido := False;
  LCFOPEnvioRemessa := TCFOPEnvioRemessa.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_DEMAIS, '904');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_SUBSTITUIDO, '415');
    LInputOutputClassificacao := LCFOPEnvioRemessa.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1904');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEnvioRemessa);
  End;
end;

procedure TestTCFOPEnvioRemessa.TestEnvioRemessaEnvioMercadoriaSubstituido;
  Var
    LCFOPEnvioRemessa : TCFOPEnvioRemessa;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LCFOPEnvioRemessa := TCFOPEnvioRemessa.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_DEMAIS, '904');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_SAIDA_SUBSTITUIDO, '415');
    LInputOutputClassificacao := LCFOPEnvioRemessa.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5415');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEnvioRemessa);
  End;
end;

initialization
  RegisterTest(TestTCFOPEnvioRemessa.Suite);

end.

