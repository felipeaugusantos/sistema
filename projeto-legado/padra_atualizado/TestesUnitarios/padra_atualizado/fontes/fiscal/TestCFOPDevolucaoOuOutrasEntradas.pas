unit TestCFOPDevolucaoOuOutrasEntradas;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPDevolucaoOuOutrasEntradas = class(TTestCase)
  strict private
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalBrindeDentroEstado;
    procedure TestClassificacaoFiscalBrindeForaEstado;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItem;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacaoComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacaoComCFG_HEFCOE_S;
    procedure TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaDentroEstado;
    procedure TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaForaEstado;
    procedure TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaComClassificacaoPredefinida;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
    procedure TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  end;

implementation

uses untCFOPDevolucaoOuOutrasEntradas, untTypesCFOP, System.SysUtils;

procedure TestTCFOPDevolucaoOuOutrasEntradas.SetUp;
begin
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TearDown;
begin
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '1102';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1411');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '2202';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LInputDefine.ClassificacaoFiscalDoItem := '2102';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2411');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2411');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '1102';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalBrindeDentroEstado;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ItemBrinde := True;
  LInputDefine.OpcaoDeDocumento := 'DV';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalBrindeForaEstado;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ItemBrinde := True;
  LInputDefine.OpcaoDeDocumento := 'DV';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2949');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '1';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1201');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntregaFuturaDoItem := True;
  LInputDefine.ClassificacaoFiscalDoItem := '2102';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.EntregaFuturaDoItem := True;
  LInputDefine.ClassificacaoFiscalDoItem := '2102';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacaoComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2201');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItem;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2202');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2201');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.EntregaFuturaDoItem := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1102';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1411');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.EntregaFuturaDoItem := True;
  LInputDefine.ClassificacaoFiscalDoItem := '1102';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1922');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalSemSubstituicaoTributariaDoItemDentroEstadoComEntregaFuturaDoItemItemProvenienteDeIndustrializacaoComCFG_HEFCOE_S;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.EntregaFuturaDoItem := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1201');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaComClassificacaoPredefinida;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '6202';
  LInputDefine.ClassificacaoDoItem := '6101';
  LInputDefine.EhEspelhoDevolucaoClienteGarantia := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6202';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_RECEBIMENTO_GARANTIA_CLIENTE, '915');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6101');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaDentroEstado;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '5202';
  LInputDefine.EhEspelhoDevolucaoClienteGarantia := True;
  LInputDefine.ClassificacaoFiscalDoItem := '5202';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_RECEBIMENTO_GARANTIA_CLIENTE, '915');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalEspelhoDevolucaoClienteGarantiaForaEstado;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ClassificacaoFiscalDoItem := '6202';
  LInputDefine.EhEspelhoDevolucaoClienteGarantia := True;
  LInputDefine.ClassificacaoFiscalDoItem := '6202';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_RECEBIMENTO_GARANTIA_CLIENTE, '915');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6915');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemDentroEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1410');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

procedure TestTCFOPDevolucaoOuOutrasEntradas.TestClassificacaoFiscalComSubstituicaoTributariaDoItemForaEstadoSemEntregaFuturaDoItemItemProvenienteDeIndustrializacao;
  Var
    LCFOPDevolucaoOuOutrasEntradas : TCFOPDevolucaoOuOutrasEntradas;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.ItemSubstituido := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LCFOPDevolucaoOuOutrasEntradas := TCFOPDevolucaoOuOutrasEntradas.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_ENTREGA_FUTURA_COMO_CONTROLE_ENTREGA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    LInputOutputClassificacao := LCFOPDevolucaoOuOutrasEntradas.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2410');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPDevolucaoOuOutrasEntradas);
  End;
end;

initialization
  RegisterTest(TestTCFOPDevolucaoOuOutrasEntradas.Suite);

end.

