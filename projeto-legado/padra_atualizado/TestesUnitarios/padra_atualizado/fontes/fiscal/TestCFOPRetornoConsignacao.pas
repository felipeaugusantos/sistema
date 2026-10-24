unit TestCFOPRetornoConsignacao;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRetornoConsignacao = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRetornoConsignacaoDentroEstadoCFOP;
    procedure TestRetornoConsignacaoForaEstadoCFOP;
  end;

implementation

uses untCFOPRetornoConsignacao, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRetornoConsignacao.SetUp;
begin
end;

procedure TestTCFOPRetornoConsignacao.TearDown;
begin
end;

procedure TestTCFOPRetornoConsignacao.TestRetornoConsignacaoDentroEstadoCFOP;
  Var
    LCFOPRetornoConsignacao : TCFOPRetornoConsignacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPRetornoConsignacao := TCFOPRetornoConsignacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, '59176917');
    LInputOutputClassificacao := LCFOPRetornoConsignacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1917');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRetornoConsignacao);
  End;
end;

procedure TestTCFOPRetornoConsignacao.TestRetornoConsignacaoForaEstadoCFOP;
  Var
    LCFOPRetornoConsignacao : TCFOPRetornoConsignacao;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LCFOPRetornoConsignacao := TCFOPRetornoConsignacao.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_RETORNO_MERCADORIA_CONSIGNACAO, '59176917');
    LInputOutputClassificacao := LCFOPRetornoConsignacao.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2917');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRetornoConsignacao);
  End;
end;

initialization
  RegisterTest(TestTCFOPRetornoConsignacao.Suite);

end.

