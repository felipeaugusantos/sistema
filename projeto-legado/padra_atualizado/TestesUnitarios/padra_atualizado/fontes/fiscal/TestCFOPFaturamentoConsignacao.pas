unit TestCFOPFaturamentoConsignacao;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPFaturamentoConsignacao = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFaturamentoConsignacaoDentroEstadoCFOP;
    procedure TestFaturamentoConsignacaoForaEstadoCFOP;
  end;

implementation

uses untCFOPFaturamentoConsignacao, untTypesCFOP, System.SysUtils;

procedure TestTCFOPFaturamentoConsignacao.SetUp;
begin
end;

procedure TestTCFOPFaturamentoConsignacao.TearDown;
begin
end;

procedure TestTCFOPFaturamentoConsignacao.TestFaturamentoConsignacaoDentroEstadoCFOP;
  Var
    LCFOPFaturamentoConsignacao : TCFOPFaturamentoConsignacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPFaturamentoConsignacao := TCFOPFaturamentoConsignacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_FATURAMENTO_MERCADORIA_CONSIGNACAO, '59176917');
    LInputOutputClassificacao := LCFOPFaturamentoConsignacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5917');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPFaturamentoConsignacao);
  End;
end;

procedure TestTCFOPFaturamentoConsignacao.TestFaturamentoConsignacaoForaEstadoCFOP;
  Var
    LCFOPFaturamentoConsignacao : TCFOPFaturamentoConsignacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LCFOPFaturamentoConsignacao := TCFOPFaturamentoConsignacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, '59176917');
    LInputOutputClassificacao := LCFOPFaturamentoConsignacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6917');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPFaturamentoConsignacao);
  End;
end;

initialization
  RegisterTest(TestTCFOPFaturamentoConsignacao.Suite);

end.

