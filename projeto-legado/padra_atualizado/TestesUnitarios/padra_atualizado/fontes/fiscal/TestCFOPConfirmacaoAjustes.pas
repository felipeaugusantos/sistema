unit TestCFOPConfirmacaoAjustes;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPConfirmacaoAjustes = class(TTestCase)
  strict private
    const
      ENTRADA = 'E';
      SAIDA = 'S';
      VENDA = '1';
      CLASSIFICACOES_DE_SAIDA = 'Classificações de Saída';
      CLASSIFICACOES_DE_VENDA = 'Classificações de Venda';
      CLASSIFICACOES_DE_ENTRADA = 'Classificações de Entrada';
      CLASSIFICACOES_DE_COMPRA = 'Classificações de Compra';
      CLASSIFICACOES_DE_TRANSFERENCIA = 'Classificações de Transferência';
      TRIBUTADO = 'Tributado';
      SUBST_COMB_LUBRIFICANTE = 'Subst. Comb./Lubrificante';
      SUBST_IMPORTACAO_DIRETA = 'Subst. Imp. Direta';
      SUBST_DEMAIS_PRODUTOS = 'Subst. Demais Produtos';
  strict private
    procedure pSetarValoresDefault;
    function fRetornaMensagemClassificacaoVazia(Const psCodigoDaEmpresa, psGrupo, psSubGrupo, psCampo: string): string;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifVendaTribSaida;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemCombustivelLubDoItem;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItem;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifVendaTribSaida;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemCombustivelLubDoItem;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItem;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraSubstDemaisProdEntrada;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraTributadoEntrada;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfSubstDemaisProdEntrada;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfTributadoDemaisProdEntrada;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifVendaTribSaidaClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemCombustivelLubDoItemClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemClassificacaoVazia;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifVendaTribSaidaClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemCombustivelLubDoItemClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemClassificacaoVazia;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraSubstDemaisProdEntradaClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraTributadoEntradaClassificacaoVazia;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfSubstDemaisProdEntradaClassificacaoVazia;
    procedure TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfTributadoDemaisProdEntradaClassificacaoVazia;

    procedure TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialEntradaItemDentroEstado;
    procedure TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialEntradaItemForaEstado;
    procedure TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialSaidaItemDentroEstado;
    procedure TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialSaidaItemForaEstado;

    procedure TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemImportacaoDiretaClassificacaoVazia;

    procedure TestMensagemRetorno;
    procedure TestAbortarProcedimento;
  end;

implementation

uses untCFOPConfirmacaoAjustes, untTypesCFOP, System.SysUtils,
  untTestTransferenciaEstoqueEmpresaDadosDB;

procedure TestTCFOPConfirmacaoAjustes.pSetarValoresDefault;
begin
  SetObjTransferenciaEstoqueEmpresaDadosDB(TTestTransferenciaEstoqueEmpresaDadosDB.New());
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaTributadoEntrada := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaSubstDemaisProdutosSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaTributadoSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstDemaisProdutosSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaSubstCombLubrificanteSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaTributadoSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeCompraSubstDemaisProdutosEntrada := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstCombLubrificanteSaida := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeCompraTributadoEntrada := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := EmptyStr;
  TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := False;
end;

function TestTCFOPConfirmacaoAjustes.fRetornaMensagemClassificacaoVazia(
  Const psCodigoDaEmpresa, psGrupo, psSubGrupo, psCampo: string): string;
begin
  Result :=
    'A CFOP para emissão da nota está vazia. ' +
    'Antes de continuar, acesse o cadastro da empresa ' +
    psCodigoDaEmpresa + ', ' +
    'aba "Configuração de Transf. de Estoque" e informe a ' +
    'CFOP no campo: "' + psGrupo + '" - "' + psSubGrupo +
    '" - "' + psCampo + '".';
end;

procedure TestTCFOPConfirmacaoAjustes.SetUp;
begin
  pSetarValoresDefault;
end;

procedure TestTCFOPConfirmacaoAjustes.TearDown;
begin
  SetObjTransferenciaEstoqueEmpresaDadosDB(Nil);
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialEntradaItemDentroEstado;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_ENTRADA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialEntradaItemForaEstado;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_ENTRADA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '2102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '2');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialSaidaItemDentroEstado;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.DentroDoEstadoCFOP := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalNaoRetornouInfNaoClienteFilialSaidaItemForaEstado;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '6102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '6');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfSubstDemaisProdEntrada;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '010';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada := '1111';
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1111');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfSubstDemaisProdEntradaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '010';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_EMISSAO_NOTAFISCAL_AJUSTE_ESTOQUE_SAIDA, '102');
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_ENTRADA, CLASSIFICACOES_DE_TRANSFERENCIA, SUBST_DEMAIS_PRODUTOS);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfTributadoDemaisProdEntrada;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '000';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaTributadoEntrada := '1111';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1111');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifTransfTributadoDemaisProdEntradaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '000';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_ENTRADA, CLASSIFICACOES_DE_TRANSFERENCIA, TRIBUTADO);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifVendaTribSaida;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaTributadoSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaClassifVendaTribSaidaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_TRANSFERENCIA, TRIBUTADO);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItem;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstDemaisProdutosSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_TRANSFERENCIA, SUBST_DEMAIS_PRODUTOS);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemCombustivelLubDoItem;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeTransferenciaSubstCombLubrificanteSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoNaoVendaSubstTribItemCombustivelLubDoItemClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_TRANSFERENCIA, SUBST_COMB_LUBRIFICANTE);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraSubstDemaisProdEntrada;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '010';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeCompraSubstDemaisProdutosEntrada := '1111';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1111');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraSubstDemaisProdEntradaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '010';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_ENTRADA, CLASSIFICACOES_DE_COMPRA, SUBST_DEMAIS_PRODUTOS);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraTributadoEntrada;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '000';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeCompraTributadoEntrada := '1111';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '1111');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '1');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifCompraTributadoEntradaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := ENTRADA;
  LInputDefine.SituacaoTributaria := '000';
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_ENTRADA, CLASSIFICACOES_DE_COMPRA, TRIBUTADO);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifVendaTribSaida;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaTributadoSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaClassifVendaTribSaidaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_VENDA, TRIBUTADO);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_VENDA, SUBST_DEMAIS_PRODUTOS);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemCombustivelLubDoItem;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaSubstCombLubrificanteSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemCombustivelLubDoItemClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_VENDA, SUBST_COMB_LUBRIFICANTE);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItem;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).ClassificacaoDeVendaSubstDemaisProdutosSaida := '5555';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestClassificacaoFiscalRetornouInfTipOperacaoVendaSubstTribItemImportacaoDiretaClassificacaoVazia;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
    LMensagemRetorno : String;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputDefine.EntradaOuSaidaDoItem := SAIDA;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).RetornouInformacoes := True;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).TipoDeOperacao := VENDA;
    TTestTransferenciaEstoqueEmpresaDadosDB(objTransferenciaEstoqueEmpresa).CodigoDaEmpresa := '001';
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    LMensagemRetorno := fRetornaMensagemClassificacaoVazia('001', CLASSIFICACOES_DE_SAIDA, CLASSIFICACOES_DE_VENDA, SUBST_IMPORTACAO_DIRETA);
    CheckEqualsString(LInputOutputClassificacao.Classificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, LMensagemRetorno);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestMensagemRetorno;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.MensagemRetorno, EmptyStr);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

procedure TestTCFOPConfirmacaoAjustes.TestAbortarProcedimento;
  Var
    LCFOPConfirmacaoAjustes : TCFOPConfirmacaoAjustes;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LCFOPConfirmacaoAjustes := TCFOPConfirmacaoAjustes.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    LInputOutputClassificacao := LCFOPConfirmacaoAjustes.GetClassificacao;
    CheckFalse(LInputOutputClassificacao.AbortarProcedimento);
  Finally
    FreeAndNil(LCFOPConfirmacaoAjustes);
  End;
end;

initialization
  RegisterTest(TestTCFOPConfirmacaoAjustes.Suite);

end.

