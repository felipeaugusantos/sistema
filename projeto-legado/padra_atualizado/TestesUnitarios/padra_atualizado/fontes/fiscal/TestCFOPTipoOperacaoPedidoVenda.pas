unit TestCFOPTipoOperacaoPedidoVenda;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPTipoOperacaoPedidoVenda = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestTipoOperacaoPedidoVendaBonificacao;
    procedure TestTipoOperacaoPedidoVendaContaOrdem;
    procedure TestTipoOperacaoPedidoVendaDemonstracao;
  end;

implementation

uses untCFOPTipoOperacaoPedidoVenda, untTypesCFOP, System.SysUtils;

procedure TestTCFOPTipoOperacaoPedidoVenda.SetUp;
begin
end;

procedure TestTCFOPTipoOperacaoPedidoVenda.TearDown;
begin
end;

procedure TestTCFOPTipoOperacaoPedidoVenda.TestTipoOperacaoPedidoVendaBonificacao;
  Var
    LCFOPTipoOperacaoPedidoVenda : TCFOPTipoOperacaoPedidoVenda;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'B';
  LCFOPTipoOperacaoPedidoVenda := TCFOPTipoOperacaoPedidoVenda.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPTipoOperacaoPedidoVenda.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1910');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPTipoOperacaoPedidoVenda);
  End;
end;

procedure TestTCFOPTipoOperacaoPedidoVenda.TestTipoOperacaoPedidoVendaContaOrdem;
  Var
    LCFOPTipoOperacaoPedidoVenda : TCFOPTipoOperacaoPedidoVenda;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'C';
  LCFOPTipoOperacaoPedidoVenda := TCFOPTipoOperacaoPedidoVenda.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPTipoOperacaoPedidoVenda.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1119');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPTipoOperacaoPedidoVenda);
  End;
end;

procedure TestTCFOPTipoOperacaoPedidoVenda.TestTipoOperacaoPedidoVendaDemonstracao;
 Var
    LCFOPTipoOperacaoPedidoVenda : TCFOPTipoOperacaoPedidoVenda;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'D';
  LCFOPTipoOperacaoPedidoVenda := TCFOPTipoOperacaoPedidoVenda.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPTipoOperacaoPedidoVenda.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1912');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPTipoOperacaoPedidoVenda);
  End;
end;

initialization
  RegisterTest(TestTCFOPTipoOperacaoPedidoVenda.Suite);

end.

