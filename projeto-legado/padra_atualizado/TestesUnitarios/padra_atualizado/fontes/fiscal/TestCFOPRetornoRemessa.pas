unit TestCFOPRetornoRemessa;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRetornoRemessa = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRetornoRemessaDentroEstadoCFOP;
    procedure TestRetornoRemessaForaEstadoCFOP;
  end;

implementation

uses untCFOPRetornoRemessa, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRetornoRemessa.SetUp;
begin
end;

procedure TestTCFOPRetornoRemessa.TearDown;
begin
end;

procedure TestTCFOPRetornoRemessa.TestRetornoRemessaDentroEstadoCFOP;
  Var
    LCFOPRetornoRemessa : TCFOPRetornoRemessa;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPRetornoRemessa := TCFOPRetornoRemessa.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_ENTRADA, '904');
    LInputOutputClassificacao := LCFOPRetornoRemessa.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1904');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRetornoRemessa);
  End;
end;

procedure TestTCFOPRetornoRemessa.TestRetornoRemessaForaEstadoCFOP;
  Var
    LCFOPRetornoRemessa : TCFOPRetornoRemessa;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPRetornoRemessa := TCFOPRetornoRemessa.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CFOP_REMESSA_ENTRADA, '904');
    LInputOutputClassificacao := LCFOPRetornoRemessa.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2904');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRetornoRemessa);
  End;
end;

initialization
  RegisterTest(TestTCFOPRetornoRemessa.Suite);

end.

