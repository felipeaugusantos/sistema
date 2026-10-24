unit TestCFOPOutrasSaidasParaConserto;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPOutrasSaidasParaConserto = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestOutrasSaidasDentroDoEstadoCFOP;
    procedure TestOutrasSaidasForaDoEstadoCFOP;
  end;

implementation

uses untCFOPOutrasSaidasParaConserto, untTypesCFOP, System.SysUtils;

procedure TestTCFOPOutrasSaidasParaConserto.SetUp;
begin
end;

procedure TestTCFOPOutrasSaidasParaConserto.TearDown;
begin
end;

procedure TestTCFOPOutrasSaidasParaConserto.TestOutrasSaidasDentroDoEstadoCFOP;
  Var
    LCFOPOutrasSaidasParaConserto : TCFOPOutrasSaidasParaConserto;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPOutrasSaidasParaConserto := TCFOPOutrasSaidasParaConserto.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO, '59156915');
    LInputOutputClassificacao := LCFOPOutrasSaidasParaConserto.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPOutrasSaidasParaConserto);
  End;
end;

procedure TestTCFOPOutrasSaidasParaConserto.TestOutrasSaidasForaDoEstadoCFOP;
  Var
    LCFOPOutrasSaidasParaConserto : TCFOPOutrasSaidasParaConserto;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LCFOPOutrasSaidasParaConserto := TCFOPOutrasSaidasParaConserto.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_SAIDA_PARA_CONSERTO, '59156915');
    LInputOutputClassificacao := LCFOPOutrasSaidasParaConserto.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPOutrasSaidasParaConserto);
  End;
end;

initialization
  RegisterTest(TestTCFOPOutrasSaidasParaConserto.Suite);

end.

