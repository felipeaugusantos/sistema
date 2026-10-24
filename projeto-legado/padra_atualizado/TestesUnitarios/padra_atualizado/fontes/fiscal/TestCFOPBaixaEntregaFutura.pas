unit TestCFOPBaixaEntregaFutura;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPBaixaEntregaFutura = class(TTestCase)
  strict private
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalDentroDoEstadoVendaPresencialRevenda;
    procedure TestClassificacaoFiscalDentroDoEstadoVendaPresencialIndustrializacao;
    procedure TestClassificacaoFiscalDentroDoEstadoVendaNaoPresencialRevenda;
    procedure TestClassificacaoFiscalDentroDoEstadoVendaNaoPresencialIndustrializacao;
    procedure TestClassificacaoFiscalForaDoEstadoVendaPresencialRevenda;
    procedure TestClassificacaoFiscalForaDoEstadoVendaPresencialIndustrializacao;
    procedure TestClassificacaoFiscalForaDoEstadoVendaNaoPresencialRevenda;
    procedure TestClassificacaoFiscalForaDoEstadoVendaNaoPresencialIndustrializacao;
    procedure TestClassificacaoClienteExteriorRevenda;
    procedure TestClassificacaoClienteExteriorIndustrializacao;
    procedure TestClassificacaoDeServicoClienteNaoExterior;
    procedure TestClassificacaoDeServicoClienteExterior;
    procedure TestClassificacaoFiscalBaixaEntregaFuturaEmitindoEntradaEstoqueItemEstrutura;
    procedure TestClassificacaoFiscalControleEntregaEscolheTipoDocumento;
  end;

implementation

uses untCFOPBaixaEntregaFutura, untTypesCFOP, System.SysUtils, System.StrUtils;

procedure TestTCFOPBaixaEntregaFutura.SetUp;
begin
end;

procedure TestTCFOPBaixaEntregaFutura.TearDown;
begin
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalDentroDoEstadoVendaPresencialRevenda;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA, '117');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalDentroDoEstadoVendaPresencialIndustrializacao;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_INDUSTRIALIZACAO, '116');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5116');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalBaixaEntregaFuturaEmitindoEntradaEstoqueItemEstrutura;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.EntradaOuSaidaDoItem := 'E';
  LInputDefine.ProdutoEmbalagem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EMITIR_DOCUMENTO_COM_ITEM, '2');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_BAIXA_ENTREGA_FUTURA_DE_ITEM_ESTRUTURA_EXIBIR_ITEM, '1');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalControleEntregaEscolheTipoDocumento;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
  Const
    ClassificacaoOriginal = '5405';
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.VendaPresencial := False;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.ClassificacaoDoItem := ClassificacaoOriginal;
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LInputOutputClassificacao.Classificacao := ClassificacaoOriginal;

  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA, '117');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_OPC_TIPODOC_BAIXA_ENTREGA_FUTURA, '2');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, ClassificacaoOriginal);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, LeftStr(ClassificacaoOriginal, 1));
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalDentroDoEstadoVendaNaoPresencialRevenda;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.VendaPresencial := False;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA, '117');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalDentroDoEstadoVendaNaoPresencialIndustrializacao;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.VendaPresencial := False;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_INDUSTRIALIZACAO, '116');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5116');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalForaDoEstadoVendaNaoPresencialRevenda;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := False;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA, '117');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalForaDoEstadoVendaNaoPresencialIndustrializacao;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := False;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_INDUSTRIALIZACAO, '116');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6116');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalForaDoEstadoVendaPresencialRevenda;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_REVENDA, '117');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoFiscalForaDoEstadoVendaPresencialIndustrializacao;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_BAIXA_ENTREGA_FUTURA_VENDA_INDUSTRIALIZACAO, '116');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5116');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoClienteExteriorRevenda;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'EX';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '7117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '7');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoClienteExteriorIndustrializacao;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'EX';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '7117');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '7');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoDeServicoClienteExterior;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'EX';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

procedure TestTCFOPBaixaEntregaFutura.TestClassificacaoDeServicoClienteNaoExterior;
  Var
    LCFOPBaixaEntregaFutura : TCFOPBaixaEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.VendaPresencial := True;
  LInputDefine.ClienteEstado := 'SP';
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPBaixaEntregaFutura := TCFOPBaixaEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPBaixaEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPBaixaEntregaFutura);
  End;
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTCFOPBaixaEntregaFutura.Suite);
end.

