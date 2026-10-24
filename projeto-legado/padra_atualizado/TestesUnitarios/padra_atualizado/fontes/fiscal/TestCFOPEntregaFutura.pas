unit TestCFOPEntregaFutura;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPEntregaFutura = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEntregaFuturaDentroEstadoCFOP;
    procedure TestEntregaFuturaForaEstadoCFOP;
    procedure TestEntregaFuturaExterior;
  end;

implementation

uses untCFOPEntregaFutura, untTypesCFOP, System.SysUtils;

procedure TestTCFOPEntregaFutura.SetUp;
begin
end;

procedure TestTCFOPEntregaFutura.TearDown;
begin
end;


procedure TestTCFOPEntregaFutura.TestEntregaFuturaExterior;
  Var
    LCFOPEntregaFutura : TCFOPEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClienteEstado := 'EX';
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPEntregaFutura := TCFOPEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, '7922');
  Finally
    FreeAndNil(LCFOPEntregaFutura);
  End;
end;

procedure TestTCFOPEntregaFutura.TestEntregaFuturaDentroEstadoCFOP;
  Var
    LCFOPEntregaFutura : TCFOPEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPEntregaFutura := TCFOPEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEntregaFutura);
  End;
end;

procedure TestTCFOPEntregaFutura.TestEntregaFuturaForaEstadoCFOP;
  Var
    LCFOPEntregaFutura : TCFOPEntregaFutura;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClienteEstado := 'SP';
  LCFOPEntregaFutura := TCFOPEntregaFutura.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEntregaFutura.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEntregaFutura);
  End;
end;

initialization
  RegisterTest(TestTCFOPEntregaFutura.Suite);

end.

