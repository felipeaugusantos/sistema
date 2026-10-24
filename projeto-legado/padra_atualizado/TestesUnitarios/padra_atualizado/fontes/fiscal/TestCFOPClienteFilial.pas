unit TestCFOPClienteFilial;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPClienteFilial = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPI;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevenda;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacao;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPI;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevenda;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacao;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPI;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevenda;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacao;

    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPICFOP6405;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevendaCFOP6405;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacaoCFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405;

    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;

    procedure TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemSemCSTDeVendaTributadoTransferencia;
    procedure TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia3Digitos;
    procedure TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia1Digito;
    procedure TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia2Digitos;
    procedure TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemSemCSTDeVendaTributadoTransferenciaSemCodigoDaSubstituicaoTributariaDoItem;

    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemSemCSTDeVendaSubstCombustivelELubrificanteTransferencia;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia3Digitos;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia1Digito;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia2Digitos;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemSemCodigoDaSubstituicaoTributariaDoItem;

    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemSemCSTDeVendaSubstDemaisTransferencia;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia3Digitos;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia1Digito;
    procedure TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia2Digitos;

    procedure TestClassificacaoFiscalConfirmacaoDevolucaoRegimeEspecialSemSubstituicaoTributaria;
    procedure TestClassificacaoFiscalConfirmacaoDevolucaoRegimeEspecialCOMSubstituicaoTributaria;

    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemImportacaoDiretaDoItem;

  end;

implementation

uses untCFOPClienteFilial, untTypesCFOP, System.SysUtils;

procedure TestTCFOPClienteFilial.SetUp;
begin
end;

procedure TestTCFOPClienteFilial.TearDown;
begin
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacao;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4321';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia := '9876';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1876');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevenda;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4321';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPI;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4321';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacao;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4321';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia := '9876';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1876');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevenda;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4321';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPI;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4321';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacao;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4321';
  LInputDefine.ClassificacaoDeIndustrializacaoTributadoTransferencia := '9876';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1876');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevenda;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4321';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPI;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '1234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4321';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1321');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPICFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevendaCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacaoCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoTributadoTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaTributadoTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoTributadoTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstCombustivelELubrificanteTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstCombustivelELubrificanteTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405;
  Var
    LCFOPAClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '6405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPAClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPAClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPAClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemNaoContribuinteIPICFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '6405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalConfirmacaoDevolucaoRegimeEspecialCOMSubstituicaoTributaria;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6134';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ConfirmacaoDevolucaoRegimeEspecial := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6411');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalConfirmacaoDevolucaoRegimeEspecialSemSubstituicaoTributaria;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := False;
  LInputDefine.ClassificacaoFiscalDoItem := '6134';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ConfirmacaoDevolucaoRegimeEspecial := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6134';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIRevendaCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6134';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemContribuinteIPIIndustrializacaoCFOP6405ClienteConsumidorFinal;
  Var
    LCFOPClientFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6234';
  LInputDefine.ClassificacaoDeVendaSubstDemaisProdutosTransferencia := '4405';
  LInputDefine.ClassificacaoDeIndustrializacaoSubstDemaisProdutosTransferencia := '9405';
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPClientFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPClientFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPClientFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia1Digito;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia := '0';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia2Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia := '00';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '100');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemComCSTDeVendaSubstCombustivelELubrificanteTransferencia3Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.CSTDeVendaSubstCombustivelELubrificanteTransferencia := '102';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemSemCodigoDaSubstituicaoTributariaDoItem;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemComCombustivelLubrificanteDoItemSemCSTDeVendaSubstCombustivelELubrificanteTransferencia;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia1Digito;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.CSTDeVendaSubstDemaisTransferencia := '0';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia2Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.CSTDeVendaSubstDemaisTransferencia := '00';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '100');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemComCSTDeVendaSubstDemaisTransferencia3Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.CSTDeVendaSubstDemaisTransferencia := '102';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemComSubstituicaoTributariaDoItemSemCombustivelLubrificanteDoItemSemCSTDeVendaSubstDemaisTransferencia;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia1Digito;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.CSTDeVendaTributadoTransferencia := '0';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia2Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.CSTDeVendaTributadoTransferencia := '00';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '100');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemComCSTDeVendaTributadoTransferencia3Digitos;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LInputDefine.SituacaoTributaria := '101';
  LInputDefine.CSTDeVendaTributadoTransferencia := '102';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemSemCSTDeVendaTributadoTransferencia;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.SituacaoTributaria := '101';
  LInputOutputClassificacao.SituacaoTributaria := '101';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, '101');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestCodigoDaSubstituicaoTributariaDoItemSemSubstituicaoTributariaDoItemSemCSTDeVendaTributadoTransferenciaSemCodigoDaSubstituicaoTributariaDoItem;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.SituacaoTributaria, EmptyStr);
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

procedure TestTCFOPClienteFilial.TestClassificacaoFiscalComSubstituicaoTributariaDoItemImportacaoDiretaDoItem;
  Var
    LCFOPClienteFilial : TCFOPClienteFilial;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ClassificacaoFiscalDoItem := '5102';
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.ClassificacaoDeVendaSubstImportacaoDireta := '5403';
  LInputDefine.ImportacaoDiretaDoItem := True;
  LInputDefine.TipoDeEmissaoTE := 'V';
  LInputDefine.TipoDeOperacaoDoPedidoDeVenda := 'V';
  LCFOPClienteFilial := TCFOPClienteFilial.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPClienteFilial.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
  Finally
    FreeAndNil(LCFOPClienteFilial);
  End;
end;

initialization
  RegisterTest(TestTCFOPClienteFilial.Suite);
end.

