unit TestCFOPAtivoImobilizado;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPAtivoImobilizado = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalDentroEstado;
    procedure TestClassificacaoFiscalForaEstado;
  end;

implementation

uses untCFOPAtivoImobilizado, untTypesCFOP, System.SysUtils;

procedure TestTCFOPAtivoImobilizado.SetUp;
begin
end;

procedure TestTCFOPAtivoImobilizado.TearDown;
begin
end;

procedure TestTCFOPAtivoImobilizado.TestClassificacaoFiscalDentroEstado;
  Var
    LCFOPAtivoImobilizado : TCFOPAtivoImobilizado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPAtivoImobilizado := TCFOPAtivoImobilizado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_ATIVO_IMOBILIZADO, '551');
    LInputOutputClassificacao := LCFOPAtivoImobilizado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5551');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAtivoImobilizado);
  End;
end;

procedure TestTCFOPAtivoImobilizado.TestClassificacaoFiscalForaEstado;
  Var
    LCFOPAtivoImobilizado : TCFOPAtivoImobilizado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputOutputClassificacao.PrefixoClassificacao := EmptyStr;
  LCFOPAtivoImobilizado := TCFOPAtivoImobilizado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_ATIVO_IMOBILIZADO, '551');
    LInputOutputClassificacao := LCFOPAtivoImobilizado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6551');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAtivoImobilizado);
  End;
end;

initialization
  RegisterTest(TestTCFOPAtivoImobilizado.Suite);
end.

