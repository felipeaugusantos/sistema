unit TestuntDefineCFOP;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTDefineCFOP = class(TTestCase)
  strict private
    procedure SetaValoresDefault;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestVendaABaseDeTrocaDentroDoEstado;
    procedure TestVendaABaseDeTrocaForaDoEstado;
    procedure TestAmostraGratisDentroDoEstado;
    procedure TestAmostraGratisForaDoEstado;
    procedure TestAmostraGratisForaDoEstadoTributado;
    procedure TestAmostraGratisForaDoEstadoSubstituido;
    procedure TestAmostraGratisForaDoEstadoSubstituidoEntrada;
    procedure TestComplementoFornecedorValor;
    procedure TestComplementoFornecedorValorAbortarProcedimento;
  end;

implementation

uses untDefineCFOP, untTypesCFOP, System.SysUtils, Shared.Functions.Types;

procedure TestTDefineCFOP.SetaValoresDefault;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, EmptyStr);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_ITEM_TAXA_BOMBEAMENTO_CONFIRMACAO_NOTA_CONCRETO, EmptyStr);
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'N');
end;

procedure TestTDefineCFOP.SetUp;
begin
  SetaValoresDefault;
end;

procedure TestTDefineCFOP.TearDown;
begin
end;

procedure TestTDefineCFOP.TestAmostraGratisDentroDoEstado;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'S');
    LInputDefine.EntradaOuSaidaDoItem := 'S';
    LInputDefine.DentroDoEstado := True;
    LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'A';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '5911');
    CheckEqualsString(LResultado.PrefixoClassificacao, '5');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestAmostraGratisForaDoEstado;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'S');
    LInputDefine.EntradaOuSaidaDoItem := 'S';
    LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'A';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '6911');
    CheckEqualsString(LResultado.PrefixoClassificacao, '6');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestAmostraGratisForaDoEstadoSubstituido;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'S');
    LInputDefine.EntradaOuSaidaDoItem := 'S';
    LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'A';
    LInputDefine.SituacaoTributaria := '060';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '6911');
    CheckEqualsString(LResultado.SituacaoTributaria, '060');
    CheckEqualsString(LResultado.PrefixoClassificacao, '6');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestAmostraGratisForaDoEstadoSubstituidoEntrada;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'S');
    LInputDefine.EntradaOuSaidaDoItem := 'E';
    LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'A';
    LInputDefine.SituacaoTributaria := '060';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, EmptyStr);
    CheckEqualsString(LResultado.PrefixoClassificacao, EmptyStr);
    CheckTrue(LResultado.AbortarProcedimento);
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestAmostraGratisForaDoEstadoTributado;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_HABILITA_OPERACAO_DE_AMOSTRA_PEDIDO_VENDA, 'S');
    LInputDefine.EntradaOuSaidaDoItem := 'S';
    LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'A';
    LInputDefine.SituacaoTributaria := '000';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '6911');
    CheckEqualsString(LResultado.SituacaoTributaria, '041');
    CheckEqualsString(LResultado.PrefixoClassificacao, '6');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestComplementoFornecedorValor;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
    arrNfe: TNfeComplementoItens;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    SetLength(arrNfe, 1);
    arrNfe[0].strAutInc := '02900000000078633012';
    arrNfe[0].strClaFis := '5915';
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    LInputDefine.NFComplementoFornecedorValor := True;
    LInputDefine.NFeComplementoItens := arrNfe;
    LInputDefine.IncrementoItemAComplementar := '02900000000078633012';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '5915');
    CheckEqualsString(LResultado.PrefixoClassificacao, '5');
    CheckEqualsString(LResultado.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestComplementoFornecedorValorAbortarProcedimento;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
    arrNfe: TNfeComplementoItens;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    SetLength(arrNfe, 1);
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    LInputDefine.NFComplementoFornecedorValor := True;
    LInputDefine.NFeComplementoItens := arrNfe;
    LInputDefine.IncrementoItemAComplementar := '02900000000078633012';
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, EmptyStr);
    CheckEqualsString(LResultado.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LResultado.ClassificacaoDeServico, EmptyStr);
    CheckTrue(LResultado.AbortarProcedimento);
    CheckTrue(LResultado.MensagemRetorno <> EmptyStr);
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestVendaABaseDeTrocaDentroDoEstado;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, '949');
    LInputDefine.DentroDoEstadoCFOP := True;
    LInputDefine.NotaEspecialVendaABaseDeTroca := True;
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '1949');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

procedure TestTDefineCFOP.TestVendaABaseDeTrocaForaDoEstado;
  Var
    LDefineCFOP : TDefineCFOP;
    LInputDefine : TInputDefineClassificacaoFiscal;
    LResultado : TInputOutputClassificacaoFiscal;
begin
  LDefineCFOP := TDefineCFOP.Create(objConfiguracoes);
  Try
    FillChar(LInputDefine, SizeOf(LInputDefine), #0);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, '949');
    LInputDefine.DentroDoEstadoCFOP := False;
    LInputDefine.NotaEspecialVendaABaseDeTroca := True;
    LResultado := LDefineCFOP.GetClassificacao(LInputDefine);
    CheckEqualsString(LResultado.Classificacao, '2949');
  Finally
    FreeAndNil(LDefineCFOP);
  End;
end;

initialization
  RegisterTest(TestTDefineCFOP.Suite);

end.

