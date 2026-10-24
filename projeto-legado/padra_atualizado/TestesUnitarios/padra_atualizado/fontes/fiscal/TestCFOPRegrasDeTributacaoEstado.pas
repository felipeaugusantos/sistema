unit TestCFOPRegrasDeTributacaoEstado;

interface

uses
  TestFramework, Shared.Functions.Configuracoes;

type
  TestTCFOPRegrasDeTributacaoEstado = class(TTestCase)
  strict private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRegrasDeTributacaoTributado109;
    procedure TestRegrasDeTributacaoTributado110;
    procedure TestRegrasDeTributacaoTributado102;
    procedure TestRegrasDeTributacaoTributado101;
    procedure TestRegrasDeTributacaoTributado655;
    procedure TestRegrasDeTributacaoTributado656;
    procedure TestRegrasDeTributacaosubstituidoCombustivelLubrificanteDoItemClienteConsumidorFinal;
    procedure TestRegrasDeTributacaosubstituidoCombustivelLubrificanteDoItem;
    procedure TestRegrasDeTributacaoSubstituidoNormalNaoConsumidor;
    procedure TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributarioNaoContribuinteIpiDentroEstado403;
    procedure TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributario403;
    procedure TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributario405;
    procedure TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializados;
    procedure TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializados404;
    procedure TestRegrasDeTributacaoVendaDentroDoEstadoCFOP405;
    procedure TestRegrasDeTributacaoVendaForaDentroDoEstadoCFOP403;
    procedure TestRegrasDeTributacaoVendaForaDentroDoEstadoCFOP404;
    procedure TestRegrasDeTributacaoImportacaoDiretaOuRevendaProdutosImportados403;
    procedure TestRegrasDeTributacaoImportacaoDiretaOuRevendaProdutosImportados405;
    procedure TestRegrasDeTributacaoSemImportacaoDiretaOuRevendaProdutosImportados405;
    procedure TestRegrasDeTributacaoSemImportacaoDiretaDentroEstadoProdutoStNacionaisNaoIndustrializados;
    procedure TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializados403;
    procedure TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializadosConf;
    procedure TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializados;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidor403;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidor405;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoProdutoStNacionaisNaoIndustrializado;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoProdutoStNacionaisNaoIndustrializadoConf;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoSemProdutoStNacionaisNaoIndustrializadoConf;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidorForaEstadoProdutoStNacionaisNaoIndustrializadoCfopX403;
    procedure TestRegrasDeTributacaoSubstituidoNormalConsumidorForaEstadoProdutoStNacionaisNaoIndustrializadoCfop;
    procedure TestRegrasDeTributacaoClafisVendaForaEstadoProdutoStNacionaisNaoIndustrializadosConsumidor;
    procedure TestRegrasDeTributacaoClafisVendaForaEstadoProdutoStNacionaisNaoIndustrializadosConsumidor404;
    procedure TestRegrasDeTributacaoContribuinteDeIpiItemProvenienteDeIndustrializacao401;
    procedure TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializadosNaoConsumidor404;
  end;

implementation

uses untCFOPRegrasDeTributacaoEstado, untTypesCFOP, System.SysUtils, Shared.Functions.Constantes;

procedure TestTCFOPRegrasDeTributacaoEstado.SetUp;
begin
  objConfiguracoes.fAtualizaValorConfiguracao(CFG_QUANDO_VENDER_PARA_CLIENTE_ZONA_FRANCA_DE_MANAUS_ONDE_O_PRODUTO_E_SUBSTITUIDO_USAR_CFOP_X109_OU_X110, '');
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TearDown;
begin
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado655;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := true;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5655');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado656;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5656');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaosubstituidoCombustivelLubrificanteDoItemClienteConsumidorFinal;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5655');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalNaoConsumidor;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5401');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributarioNaoContribuinteIpiDentroEstado403;// aqui
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ImportacaoDiretaDoItem := True;
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := '1234567890';
  LInputDefine.ClienteMicroEmpreendedor := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributario403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaForaDentroDoEstadoCFOP404;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializados;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidor403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoProdutoStNacionaisNaoIndustrializado;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '222');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5222');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidorForaEstadoProdutoStNacionaisNaoIndustrializadoCfopX403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidorForaEstadoProdutoStNacionaisNaoIndustrializadoCfop;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '888');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5888');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoProdutoStNacionaisNaoIndustrializadoConf;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '555');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5555');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidorDentroEstadoSemProdutoStNacionaisNaoIndustrializadoConf;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, EmptyStr);
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalConsumidor405;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializadosConf;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '999');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSemImportacaoDiretaForaEstadoProdutoStNacionaisNaoIndustrializados403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSemImportacaoDiretaDentroEstadoProdutoStNacionaisNaoIndustrializados;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '111');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5111');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSemImportacaoDiretaOuRevendaProdutosImportados405;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoImportacaoDiretaOuRevendaProdutosImportados405;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoClafisVendaForaEstadoProdutoStNacionaisNaoIndustrializadosConsumidor;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR, '999');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5999');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoContribuinteDeIpiItemProvenienteDeIndustrializacao401;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5401');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoClafisVendaForaEstadoProdutoStNacionaisNaoIndustrializadosConsumidor404;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_FORAESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS_CONSUMIDOR, '999');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoImportacaoDiretaOuRevendaProdutosImportados403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaForaDentroDoEstadoCFOP403;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5403');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaDentroDoEstadoCFOP405;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializados;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LInputDefine.ImportacaoDiretaDoItem := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '666');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5666');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializados404;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoSubstituidoNormalImportacaoDiretaSubstitutoTributario405;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUTO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5405');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaosubstituidoCombustivelLubrificanteDoItem;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LInputDefine.ClienteConsumidorFinal := True;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5656');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado101;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5101');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado102;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5102');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado109;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'I';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteZonaFranca := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5109');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoTributado110;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := False;
  LInputDefine.CombustivelLubrificanteDoItem := True;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteZonaFranca := True;
  LInputDefine.ClienteInscricaoEstadual := EmptyStr;
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5110');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

procedure TestTCFOPRegrasDeTributacaoEstado.TestRegrasDeTributacaoVendaDentroEstadoProdutoStNacionaisNaoIndustrializadosNaoConsumidor404;
  Var
    LCFOPRegrasDeTributacaoEstado : TCFOPRegrasDeTributacaoEstado;
    LInputDefine: TInputDefineClassificacaoFiscal;
    LInputOutputClassificacao: TInputOutputClassificacaoFiscal;
begin
  FillChar(LInputDefine, SizeOf(LInputDefine), #0);
  FillChar(LInputOutputClassificacao, SizeOf(LInputOutputClassificacao), #0);
  LInputOutputClassificacao.PrefixoClassificacao := '5';
  LInputDefine.ItemSubstituido := True;
  LInputDefine.CombustivelLubrificanteDoItem := False;
  LInputDefine.IndustrializacaoOuRevenda := 'R';
  LInputDefine.DentroDoEstadoCFOP := False;
  LInputDefine.ClienteInscricaoEstadual := '0623962590098';
  LInputDefine.ClienteMicroEmpreendedor := False;
  LCFOPRegrasDeTributacaoEstado := TCFOPRegrasDeTributacaoEstado.Create(LInputDefine, objConfiguracoes, LInputOutputClassificacao);
  Try
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_PARA_CONTRIBUINTE_DE_IPI_QUE_REALIZA_VENDA_FORA_DO_ESTADO_PARA_PRODUTOS_ST_NAO_INDUSTRIALIZADOS_NAO_CONSUMIDOR, '404');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_COMBUSTIVEL_LUBRIFICANTE_TRIBUTADOS_CFOP_REGRA_X656_655, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLAFIS_VENDA_DENTROESTADO_PRODUTOSST_NACIONAIS_NAO_INDUSTRIALIZADOS, '');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_SUBSTITUTO_NA_OPERACAO_COM_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CONTRIBUINTE_IPI, 'S');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_UTILIZA_IMPORTACAO_DIRETA, 'N');
    objConfiguracoes.fAtualizaValorConfiguracao(CFG_CLASSIFICACAO_EMPRESA_QUANTO_A_SUBSTITUICAO_TRIBUTARIA, SUBSTITUIDO_TRIBUTARIO);
    LInputOutputClassificacao := LCFOPRegrasDeTributacaoEstado.GetClassificacao;
    CheckEqualsString(LInputOutputClassificacao.Classificacao, '5404');
    CheckEqualsString(LInputOutputClassificacao.PrefixoClassificacao, '5');
    CheckEqualsString(LInputOutputClassificacao.ClassificacaoDeServico, EmptyStr);
  Finally
    FreeAndNil(LCFOPRegrasDeTributacaoEstado);
  End;
end;

initialization
  RegisterTest(TestTCFOPRegrasDeTributacaoEstado.Suite);

end.

