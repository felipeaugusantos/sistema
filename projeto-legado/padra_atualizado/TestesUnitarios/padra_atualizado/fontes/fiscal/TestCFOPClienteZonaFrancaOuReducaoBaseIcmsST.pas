unit TestCFOPClienteZonaFrancaOuReducaoBaseIcmsST;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItem;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemComItemProvenienteDeIndustrializacao;

    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItem;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemComItemProvenienteDeIndustrializacao;
  end;

implementation

uses untCFOPClienteZonaFrancaOuReducaoBaseIcmsST, untTypesCFOP, System.SysUtils;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.SetUp;
begin
end;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.TearDown;
begin
end;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.TestClassificacaoFiscalComSubstituicaoTributariaDoItem;
  Var
    LCFOPClienteZonaFrancaOuReducaoBaseIcmsST : TCFOPClienteZonaFrancaOuReducaoBaseIcmsST;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.ItemSubstituido := True;
  LCFOPClienteZonaFrancaOuReducaoBaseIcmsST := TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteZonaFrancaOuReducaoBaseIcmsST.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteZonaFrancaOuReducaoBaseIcmsST);
  End;
end;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.TestClassificacaoFiscalComSubstituicaoTributariaDoItemComItemProvenienteDeIndustrializacao;
  Var
    LCFOPClienteZonaFrancaOuReducaoBaseIcmsST : TCFOPClienteZonaFrancaOuReducaoBaseIcmsST;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteZonaFrancaOuReducaoBaseIcmsST := TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteZonaFrancaOuReducaoBaseIcmsST.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1401');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteZonaFrancaOuReducaoBaseIcmsST);
  End;
end;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.TestClassificacaoFiscalSemSubstituicaoTributariaDoItem;
  Var
    LCFOPClienteZonaFrancaOuReducaoBaseIcmsST : TCFOPClienteZonaFrancaOuReducaoBaseIcmsST;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LCFOPClienteZonaFrancaOuReducaoBaseIcmsST := TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteZonaFrancaOuReducaoBaseIcmsST.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1110');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteZonaFrancaOuReducaoBaseIcmsST);
  End;
end;

procedure TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemComItemProvenienteDeIndustrializacao;
  Var
    LCFOPClienteZonaFrancaOuReducaoBaseIcmsST : TCFOPClienteZonaFrancaOuReducaoBaseIcmsST;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPClienteZonaFrancaOuReducaoBaseIcmsST := TCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteZonaFrancaOuReducaoBaseIcmsST.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1109');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteZonaFrancaOuReducaoBaseIcmsST);
  End;
end;

initialization
  RegisterTest(TestTCFOPClienteZonaFrancaOuReducaoBaseIcmsST.Suite);

end.

