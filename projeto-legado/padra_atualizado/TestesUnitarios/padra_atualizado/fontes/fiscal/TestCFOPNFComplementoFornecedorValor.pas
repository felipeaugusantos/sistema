unit TestCFOPNFComplementoFornecedorValor;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPNFComplementoFornecedorValor = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoServico;
    procedure TestClassificacaoFiscalArrNfeNil;
    procedure TestClassificacaoFiscalAutIncVazio;
    procedure TestClassificacaoFiscalAutIncNaoEncontrado;
    procedure TestClassificacaoFiscal;
    procedure TestMensagemRetorno;
    procedure TestAbortarProcedimento;
  end;

implementation

uses untCFOPNFComplementoFornecedorValor, untTypesCFOP, System.SysUtils,
  Shared.Functions.Types;

procedure TestTCFOPNFComplementoFornecedorValor.SetUp;
begin
end;

procedure TestTCFOPNFComplementoFornecedorValor.TearDown;
begin
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestClassificacaoFiscal;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    arrNfe: TNfeComplementoItens;
begin
  SetLength(arrNfe, 1);
  arrNfe[0].strAutInc := '02500000000078633012';
  arrNfe[0].strClaFis := '5915';

  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.NFeComplementoItens := arrNfe;
  LInputDefine.IncrementoItemAComplementar := '02500000000078633012';
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestClassificacaoFiscalArrNfeNil;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.NFeComplementoItens := Nil;
  LInputDefine.IncrementoItemAComplementar := '02500000000078633012';
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestClassificacaoFiscalAutIncNaoEncontrado;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    arrNfe: TNfeComplementoItens;
begin
  SetLength(arrNfe, 1);
  arrNfe[0].strAutInc := '02500000000078633012';
  arrNfe[0].strClaFis := '5915';

  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.NFeComplementoItens := arrNfe;
  LInputDefine.IncrementoItemAComplementar := '02500000000078633012-';
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestClassificacaoFiscalAutIncVazio;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    arrNfe: TNfeComplementoItens;
begin
  SetLength(arrNfe, 1);
  arrNfe[0].strAutInc := '02500000000078633012';
  arrNfe[0].strClaFis := '5915';
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.NFeComplementoItens := arrNfe;
  LInputDefine.IncrementoItemAComplementar := EmptyStr;
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestClassificacaoServico;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.NFeComplementoItens := Nil;
  LInputDefine.IncrementoItemAComplementar := EmptyStr;
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestMensagemRetorno;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, EmptyStr);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

procedure TestTCFOPNFComplementoFornecedorValor.TestAbortarProcedimento;
  Var
    LCFOPNFComplementoFornecedorValor : TCFOPNFComplementoFornecedorValor;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPNFComplementoFornecedorValor := TCFOPNFComplementoFornecedorValor.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPNFComplementoFornecedorValor.GetClassificacao;
    CheckFalse(LInputOutputClassificacao.AbortarProcedimento);
  Finally
    FreeAndNil(LCFOPNFComplementoFornecedorValor);
  End;
end;

initialization
  RegisterTest(TestTCFOPNFComplementoFornecedorValor.Suite);

end.

