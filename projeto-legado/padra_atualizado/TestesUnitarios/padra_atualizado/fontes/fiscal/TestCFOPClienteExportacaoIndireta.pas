unit TestCFOPClienteExportacaoIndireta;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPClienteExportacaoIndireta = class(TTestCase)
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegrasDeExportacaoIndiretaContribuinteIpiIndrustrializado;
    procedure TestRegrasDeExportacaoIndiretaContribuinteIpiRevenda;
    procedure TestRegrasDeExportacaoIndiretaNaoContribuinteIpiIndrustrializado;
    procedure TestRegrasDeExportacaoIndiretaNaoContribuinteIpiRevenda;
  end;

implementation

uses untCFOPClienteExportacaoIndireta, untTypesCFOP, System.SysUtils;

{ TestTCFOPClienteExportacaoIndireta }

procedure TestTCFOPClienteExportacaoIndireta.SetUp;
begin
end;

procedure TestTCFOPClienteExportacaoIndireta.TearDown;
begin
end;

procedure TestTCFOPClienteExportacaoIndireta.TestRegrasDeExportacaoIndiretaContribuinteIpiIndrustrializado;
  Var
    LCFOPClienteExportacaoIndireta : TCFOPClienteExportacaoIndireta;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteExportacaoIndireta := TCFOPClienteExportacaoIndireta.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteExportacaoIndireta.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5501');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExportacaoIndireta);
  End;
end;

procedure TestTCFOPClienteExportacaoIndireta.TestRegrasDeExportacaoIndiretaContribuinteIpiRevenda;
  Var
    LCFOPClienteExportacaoIndireta : TCFOPClienteExportacaoIndireta;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LCFOPClienteExportacaoIndireta := TCFOPClienteExportacaoIndireta.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteExportacaoIndireta.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5502');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExportacaoIndireta);
  End;
end;

procedure TestTCFOPClienteExportacaoIndireta.TestRegrasDeExportacaoIndiretaNaoContribuinteIpiIndrustrializado;
  Var
    LCFOPClienteExportacaoIndireta : TCFOPClienteExportacaoIndireta;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteExportacaoIndireta := TCFOPClienteExportacaoIndireta.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteExportacaoIndireta.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5502');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExportacaoIndireta);
  End;
end;

procedure TestTCFOPClienteExportacaoIndireta.TestRegrasDeExportacaoIndiretaNaoContribuinteIpiRevenda;
  Var
    LCFOPClienteExportacaoIndireta : TCFOPClienteExportacaoIndireta;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LCFOPClienteExportacaoIndireta := TCFOPClienteExportacaoIndireta.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteExportacaoIndireta.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5502');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteExportacaoIndireta);
  End;
end;

initialization
  RegisterTest(TestTCFOPClienteExportacaoIndireta.Suite);

end.
