unit TestCFOPExcecoesServico;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPExcecoesServico = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestExcecoesServicoDentroEstadoCFOP;
    procedure TestExcecoesServicoForaEstadoCFOP;
    procedure TestExcecoesServicoExterior;
  end;

implementation

uses untCFOPExcecoesServico, untTypesCFOP, System.SysUtils;

procedure TestTCFOPExcecoesServico.SetUp;
begin
end;

procedure TestTCFOPExcecoesServico.TearDown;
begin
end;

procedure TestTCFOPExcecoesServico.TestExcecoesServicoExterior;
  Var
    LCFOPExcecoesServico : TCFOPExcecoesServico;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  LInputDefine.ClienteEstado := 'EX';
  LInputDefine.DentroDoEstadoCFOP := True;
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPExcecoesServico := TCFOPExcecoesServico.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPExcecoesServico.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, '7933');
  Finally
    FreeAndNil(LCFOPExcecoesServico);
  End;
end;

procedure TestTCFOPExcecoesServico.TestExcecoesServicoDentroEstadoCFOP;
  Var
    LCFOPExcecoesServico : TCFOPExcecoesServico;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  LInputDefine.ClienteEstado := 'SP';
  LInputDefine.DentroDoEstadoCFOP := True;
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPExcecoesServico := TCFOPExcecoesServico.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPExcecoesServico.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5933');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, '5933');
  Finally
    FreeAndNil(LCFOPExcecoesServico);
  End;
end;

procedure TestTCFOPExcecoesServico.TestExcecoesServicoForaEstadoCFOP;
  Var
    LCFOPExcecoesServico : TCFOPExcecoesServico;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  LInputDefine.ClienteEstado := 'SP';
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPExcecoesServico := TCFOPExcecoesServico.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPExcecoesServico.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6933');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, '6933');
  Finally
    FreeAndNil(LCFOPExcecoesServico);
  End;
end;

initialization
  RegisterTest(TestTCFOPExcecoesServico.Suite);

end.

