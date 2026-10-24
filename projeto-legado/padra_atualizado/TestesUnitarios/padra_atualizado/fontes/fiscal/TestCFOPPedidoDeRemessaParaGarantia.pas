unit TestCFOPPedidoDeRemessaParaGarantia;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPPedidoDeRemessaParaGarantia = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPedidoDeRemessaParaGarantiaClassificacaoFiscal;
  end;

implementation

uses untCFOPPedidoDeRemessaParaGarantia, untTypesCFOP, System.SysUtils;

procedure TestTCFOPPedidoDeRemessaParaGarantia.SetUp;
begin
end;

procedure TestTCFOPPedidoDeRemessaParaGarantia.TearDown;
begin
end;

procedure TestTCFOPPedidoDeRemessaParaGarantia.TestPedidoDeRemessaParaGarantiaClassificacaoFiscal;
  Var
    LCFOPPedidoDeRemessaParaGarantia : TCFOPPedidoDeRemessaParaGarantia;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPPedidoDeRemessaParaGarantia := TCFOPPedidoDeRemessaParaGarantia.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_REMESSA_GARANTIA_CONSERTO, '999');
    LInputOutputClassificacao := LCFOPPedidoDeRemessaParaGarantia.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPPedidoDeRemessaParaGarantia);
  End;
end;

initialization
  RegisterTest(TestTCFOPPedidoDeRemessaParaGarantia.Suite);

end.

