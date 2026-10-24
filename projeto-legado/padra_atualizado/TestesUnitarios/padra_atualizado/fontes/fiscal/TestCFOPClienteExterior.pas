unit TestCFOPClienteExterior;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPClienteExterior = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegrasNaoVendaPresencialDevolucaoOuOutrasEntradasContrinuinteDeIpi;  //3201
    procedure TestRegrasNaoVendaPresencialDevolucaoOuOutrasEntradasSemContrinuinteDeIpi; // 3202
    procedure TestRegrasVendaPresencialContrinuinteDeIpiIndustrializacao; // 7101
    procedure TestRegrasVendaPresencialSemContrinuinteDeIpi; // 7102
    procedure TestRegrasVendaPresencialDrawback; // 7127
  end;

implementation

uses untCFOPClienteExterior, untTypesCFOP, System.SysUtils;

procedure TestTCFOPClienteExterior.SetUp;
begin
end;

procedure TestTCFOPClienteExterior.TearDown;
begin
end;

procedure TestTCFOPClienteExterior.TestRegrasNaoVendaPresencialDevolucaoOuOutrasEntradasContrinuinteDeIpi;
  Var
    LCFOPClienteExterior : TCFOPClienteExterior;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.VendaPresencial := False;
  LInputDefine.OpcaoDeDocumento := 'DV';
  LCFOPClienteExterior := TCFOPClienteExterior.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteExterior.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '3201');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '3');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExterior);
  End;
end;

procedure TestTCFOPClienteExterior.TestRegrasNaoVendaPresencialDevolucaoOuOutrasEntradasSemContrinuinteDeIpi;
  Var
    LCFOPClienteExterior : TCFOPClienteExterior;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.VendaPresencial := False;
  LInputDefine.OpcaoDeDocumento := 'DV';
  LCFOPClienteExterior := TCFOPClienteExterior.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteExterior.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '3202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '3');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExterior);
  End;
end;

procedure TestTCFOPClienteExterior.TestRegrasVendaPresencialContrinuinteDeIpiIndustrializacao;
  Var
    LCFOPClienteExterior : TCFOPClienteExterior;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.VendaPresencial := False;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteExterior := TCFOPClienteExterior.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteExterior.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '7101');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '7');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExterior);
  End;
end;

procedure TestTCFOPClienteExterior.TestRegrasVendaPresencialSemContrinuinteDeIpi;
  Var
    LCFOPClienteExterior : TCFOPClienteExterior;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.VendaPresencial := False;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteExterior := TCFOPClienteExterior.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteExterior.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '7102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '7');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExterior);
  End;
end;

procedure TestTCFOPClienteExterior.TestRegrasVendaPresencialDrawback;
  Var
    LCFOPClienteExterior : TCFOPClienteExterior;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.VendaPresencial := False;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.ItemDrawback := True;
  LCFOPClienteExterior := TCFOPClienteExterior.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteExterior.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '7127');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '7');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExterior);
  End;
end;

initialization
  RegisterTest(TestTCFOPClienteExterior.Suite);

end.

