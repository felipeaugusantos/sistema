unit TestCFOPRecebimentoGarantiaOutrasEntradas;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRecebimentoGarantiaOutrasEntradas = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestOutrasEntradasOuEntregaFuturaClassificacaoFiscalRecebimentoGarantiaSt;
    procedure TestOutrasEntradasOuEntregaFuturaClassificacaoFiscalRecebimentoGarantia;
  end;

implementation

uses untCFOPRecebimentoGarantiaOutrasEntradas, untTypesCFOP, System.SysUtils;

procedure TestTCFOPRecebimentoGarantiaOutrasEntradas.SetUp;
begin
end;

procedure TestTCFOPRecebimentoGarantiaOutrasEntradas.TearDown;
begin
end;

procedure TestTCFOPRecebimentoGarantiaOutrasEntradas.TestOutrasEntradasOuEntregaFuturaClassificacaoFiscalRecebimentoGarantia;
  Var
    LCFOPRecebimentoGarantiaOutrasEntradas : TCFOPRecebimentoGarantiaOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClassificacaoFiscalRecebimentoGarantiaSt := '2915';
  LInputDefine.ClassificacaoFiscalRecebimentoGarantia := '2915';
  LCFOPRecebimentoGarantiaOutrasEntradas := TCFOPRecebimentoGarantiaOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRecebimentoGarantiaOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRecebimentoGarantiaOutrasEntradas);
  End;
end;

procedure TestTCFOPRecebimentoGarantiaOutrasEntradas.TestOutrasEntradasOuEntregaFuturaClassificacaoFiscalRecebimentoGarantiaSt;
  Var
    LCFOPRecebimentoGarantiaOutrasEntradas : TCFOPRecebimentoGarantiaOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '2';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalRecebimentoGarantiaSt := '1915';
  LInputDefine.ClassificacaoFiscalRecebimentoGarantia := '1915';
  LCFOPRecebimentoGarantiaOutrasEntradas := TCFOPRecebimentoGarantiaOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPRecebimentoGarantiaOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRecebimentoGarantiaOutrasEntradas);
  End;
end;

initialization
  RegisterTest(TestTCFOPRecebimentoGarantiaOutrasEntradas.Suite);

end.

