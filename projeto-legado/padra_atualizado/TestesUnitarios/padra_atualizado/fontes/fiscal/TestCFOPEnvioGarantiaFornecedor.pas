unit TestCFOPEnvioGarantiaFornecedor;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPEnvioGarantiaFornecedor = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEnvioGarantiaFornecedorSubstituicaoTributariaDoItem;
    procedure TestEnvioGarantiaFornecedor;
  end;

implementation

uses untCFOPEnvioGarantiaFornecedor, untTypesCFOP, System.SysUtils;

procedure TestTCFOPEnvioGarantiaFornecedor.SetUp;
begin
end;

procedure TestTCFOPEnvioGarantiaFornecedor.TearDown;
begin
end;

procedure TestTCFOPEnvioGarantiaFornecedor.TestEnvioGarantiaFornecedorSubstituicaoTributariaDoItem;
  Var
    LCFOPEnvioGarantiaFornecedor : TCFOPEnvioGarantiaFornecedor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '3';
  LInputDefine.ClassificacaoFiscalEnvioGarantia := '1000';
  LInputDefine.ClassificacaoFiscalEnvioGarantiaST := '2000';
  LInputDefine.ItemSubstituido := True;
  LCFOPEnvioGarantiaFornecedor := TCFOPEnvioGarantiaFornecedor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEnvioGarantiaFornecedor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '3000');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '3');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEnvioGarantiaFornecedor);
  End;
end;

procedure TestTCFOPEnvioGarantiaFornecedor.TestEnvioGarantiaFornecedor;
  Var
    LCFOPEnvioGarantiaFornecedor : TCFOPEnvioGarantiaFornecedor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '6';
  LInputDefine.ClassificacaoFiscalEnvioGarantia := '1000';
  LInputDefine.ClassificacaoFiscalEnvioGarantiaST := '2000';
  LInputDefine.ItemSubstituido := False;
  LCFOPEnvioGarantiaFornecedor := TCFOPEnvioGarantiaFornecedor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPEnvioGarantiaFornecedor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6000');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPEnvioGarantiaFornecedor);
  End;
end;

initialization
  RegisterTest(TestTCFOPEnvioGarantiaFornecedor.Suite);

end.

