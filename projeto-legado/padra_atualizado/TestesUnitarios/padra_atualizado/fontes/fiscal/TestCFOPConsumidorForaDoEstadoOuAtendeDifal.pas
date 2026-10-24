unit TestCFOPConsumidorForaDoEstadoOuAtendeDifal;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPConsumidorForaDoEstadoOuAtendeDifal = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalComContribuinteDeIpi;
    procedure TestClassificacaoFiscalComContribuinteDeIpiComRevenda;
    procedure TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_108;
    procedure TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_404;
    procedure TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_404ComSubstituicaoTributariaDoItemSimples;
  end;

implementation

uses untCFOPConsumidorForaDoEstadoOuAtendeDifal, untTypesCFOP, System.SysUtils;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.SetUp;
begin
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TearDown;
begin
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TestClassificacaoFiscalComContribuinteDeIpi;
  Var
    LCFOPConsumidorForaDoEstadoOuAtendeDifal : TCFOPConsumidorForaDoEstadoOuAtendeDifal;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPConsumidorForaDoEstadoOuAtendeDifal := TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6107');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsumidorForaDoEstadoOuAtendeDifal);
  End;
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TestClassificacaoFiscalComContribuinteDeIpiComRevenda;
  Var
    LCFOPConsumidorForaDoEstadoOuAtendeDifal : TCFOPConsumidorForaDoEstadoOuAtendeDifal;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LCFOPConsumidorForaDoEstadoOuAtendeDifal := TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6108');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsumidorForaDoEstadoOuAtendeDifal);
  End;
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_108;
  Var
    LCFOPConsumidorForaDoEstadoOuAtendeDifal : TCFOPConsumidorForaDoEstadoOuAtendeDifal;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPConsumidorForaDoEstadoOuAtendeDifal := TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_VENDA_CLIENTES_FORAESTADO_SEM_INSCRICAO_INSCRICAO_ESTADUAL_6XXX, '108');
    LInputOutputClassificacao := LCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6108');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsumidorForaDoEstadoOuAtendeDifal);
  End;
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_404;
  Var
    LCFOPConsumidorForaDoEstadoOuAtendeDifal : TCFOPConsumidorForaDoEstadoOuAtendeDifal;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPConsumidorForaDoEstadoOuAtendeDifal := TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_VENDA_CLIENTES_FORAESTADO_SEM_INSCRICAO_INSCRICAO_ESTADUAL_6XXX, '404');
    LInputOutputClassificacao := LCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6108');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsumidorForaDoEstadoOuAtendeDifal);
  End;
end;

procedure TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.TestClassificacaoFiscalSemContribuinteDeIpiComCFG_CLAFES_404ComSubstituicaoTributariaDoItemSimples;
  Var
    LCFOPConsumidorForaDoEstadoOuAtendeDifal : TCFOPConsumidorForaDoEstadoOuAtendeDifal;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.SituacaoTributaria := '010';
  LCFOPConsumidorForaDoEstadoOuAtendeDifal := TCFOPConsumidorForaDoEstadoOuAtendeDifal.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_VENDA_CLIENTES_FORAESTADO_SEM_INSCRICAO_INSCRICAO_ESTADUAL_6XXX, '404');
    LInputOutputClassificacao := LCFOPConsumidorForaDoEstadoOuAtendeDifal.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConsumidorForaDoEstadoOuAtendeDifal);
  End;
end;

initialization
  RegisterTest(TestTCFOPConsumidorForaDoEstadoOuAtendeDifal.Suite);

end.

