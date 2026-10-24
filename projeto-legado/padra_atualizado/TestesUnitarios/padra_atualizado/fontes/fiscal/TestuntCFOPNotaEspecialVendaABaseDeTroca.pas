unit TestuntCFOPNotaEspecialVendaABaseDeTroca;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPNotaEspecialVendaABaseDeTroca = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDentroDoEstado;
    procedure TestForaDoEstado;
  end;

implementation

uses untCFOPNotaEspecialVendaABaseDeTroca, untTypesCFOP, System.SysUtils;

procedure TestTCFOPNotaEspecialVendaABaseDeTroca.SetUp;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, EmptyStr);
end;

procedure TestTCFOPNotaEspecialVendaABaseDeTroca.TearDown;
begin
end;

procedure TestTCFOPNotaEspecialVendaABaseDeTroca.TestDentroDoEstado;
  Var
    CFOPNotaEspecialVendaABaseDeTroca : TCFOPNotaEspecialVendaABaseDeTroca;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  CFOPNotaEspecialVendaABaseDeTroca := TCFOPNotaEspecialVendaABaseDeTroca.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, '949');
    LInputOutputClassificacao := CFOPNotaEspecialVendaABaseDeTroca.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(CFOPNotaEspecialVendaABaseDeTroca);
  End;
end;

procedure TestTCFOPNotaEspecialVendaABaseDeTroca.TestForaDoEstado;
  Var
    CFOPNotaEspecialVendaABaseDeTroca : TCFOPNotaEspecialVendaABaseDeTroca;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  CFOPNotaEspecialVendaABaseDeTroca := TCFOPNotaEspecialVendaABaseDeTroca.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_VENDA_A_BASE_DE_TROCA, '949');
    LInputOutputClassificacao := CFOPNotaEspecialVendaABaseDeTroca.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(CFOPNotaEspecialVendaABaseDeTroca);
  End;
end;

initialization
  RegisterTest(TestTCFOPNotaEspecialVendaABaseDeTroca.Suite);
end.

