unit TestCFOPUsoEConsumo;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPUsoEConsumo = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscal5999;
    procedure TestClassificacaoFiscal6999;
    procedure TestClassificacaoFiscalPrefixoVazio999;
  end;

implementation

uses untCFOPUsoEConsumo, untTypesCFOP, System.SysUtils;

procedure TestTCFOPUsoEConsumo.SetUp;
begin
end;

procedure TestTCFOPUsoEConsumo.TearDown;
begin
end;

procedure TestTCFOPUsoEConsumo.TestClassificacaoFiscal5999;
  Var
    LCFOPUsoEConsumo : TCFOPUsoEConsumo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LCFOPUsoEConsumo := TCFOPUsoEConsumo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_USO_E_CONSUMO, '999');
    LInputOutputClassificacao := LCFOPUsoEConsumo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPUsoEConsumo);
  End;
end;

procedure TestTCFOPUsoEConsumo.TestClassificacaoFiscal6999;
  Var
    LCFOPUsoEConsumo : TCFOPUsoEConsumo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LCFOPUsoEConsumo := TCFOPUsoEConsumo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_USO_E_CONSUMO, '999');
    LInputOutputClassificacao := LCFOPUsoEConsumo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPUsoEConsumo);
  End;
end;

procedure TestTCFOPUsoEConsumo.TestClassificacaoFiscalPrefixoVazio999;
  Var
    LCFOPUsoEConsumo : TCFOPUsoEConsumo;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPUsoEConsumo := TCFOPUsoEConsumo.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_USO_E_CONSUMO, '999');
    LInputOutputClassificacao := LCFOPUsoEConsumo.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPUsoEConsumo);
  End;
end;

initialization
  RegisterTest(TestTCFOPUsoEConsumo.Suite);

end.

