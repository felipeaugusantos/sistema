unit untConsultasRel;

interface

uses
  Classes, SysUtils, Variants, untTypesSistema,
  Controls, StdCtrls, StrUtils, DateUtils, Forms,
  System.Generics.Collections, TypesRel,
  Uni, DB, untFuncoesSimples, untConsultas, untITintasDeMaquina, untFuncTinta,
  untZClient, untTSelecionaTinta, untFuncEditorRel;

Type
  TPesquisas =
    (pesSemPesquisa,
     pesAbreviacaoFiscal,
     pesECFFiscal,
     pesAbvCOF,
     pesAbvPIS,
     pesAjudante,
     pesAjusteEstoque,
     pesArmazem,
     pesTpAtendimento,
     pesAtendimento0800,
     pesAtividade,
     pesBanco,
     pesBandeiraCartao,
     pesCaixa,
     pesCampanha,
     pesCanalAcesso,
     pesCartao,
     pesCategoriaPedOrc,
     pesCest,
     pesCidade,
     pesClassificacaoIPI,
     pesClassificacaoFiscal,
     pesCliente,
     pesClienteFilial,
     pesCodigoCnae,
     pesComposicao,
     pesCodigoReceita,
     pesCodigoSimilar,
     pesComboProdutoVenda,
     pesCompleOcorrencia,
     pesCondicaoPagamento,
     pesConfiguracao,
     pesConfiguracaoTinta,
     pesConsumidores,
     pesContasdeResultado,
     pesContatoCliente,
     pesContratoLogEquip,
     pesCor,
     pesCorSimples,
     pesCorVeiculo,
     pesCSTCOF,
     pesCSTPIS,
     pesCSTCBS,
     pesDefeito,
     pesDepartamento,
     pesDiversos,
     pesDocSaidaComRegFat,
     pesDocSaidaSemRegFat,
     pesEmbarcacao,
     pesEmailsEnviados,
     pesEmpresa,
     pesEmpresaSimples,
     pesEmpresaCompleto,
     pesEndCliente,
     pesEquipamento,
     pesEquipLocacao,
     pesEfetivacaoPreco,
     pesEstado,
     pesEstoqueExternoEmpresas,
     pesEvento,
     pesFaseObra,
     pesFaixaFatEstimado,
     pesFinalidadeAjuste,
     pesFornecedor,
     pesFormaDePagamento,
     pesFuncionario,
     pesFuncionarioAutoincrem,
     pesFuncoesFuncionario,
     pesGrupoAtividade,
     pesGrupoCompra,
     pesGrupoConfiguracao,
     pesGrupoEcoFornecedores,
     pesGrupoOcorrencia,
     pesGrupoOperador,
     pesGrupoProduto,
     pesGrupoDePrecos,
     pesGrupoEcoFornec,
     pesGuiaReceita,
     pesItemEstrutura,
     pesAtivoImobDocAquisicao,
     pesLayoutCupomPromocao,
     pesLinhaGrupo,
     pesLinhaGrupoSimples,
     pesLocalArmazenamentoWMS,
     pesLocalizacaoDeSeparacao,
     pesLocalizacaoLote,
     pesLocalizacaoFisica,
     pesLote,
     pesLoteSeparacao,
     pesManifestoEncerrado,
     pesMarca,
     pesMarcaSimples,
     pesMarcaVeiculo,
     pesMaterialConsumo,
     pesMotivosAtend,
     pesMotVendasPerdidas,
     pesMotorista,
     pesModeloVeiculo,
     pesNatReceitaPisCof,
     pesOcorrencia,
     pesOperador,
     pesOrcCompra,
     pesNumOrcVen,
     pesOrdProIndustrial,
     pesParceiro,
     pesPedCompra,
     pesNumPedVen,
     pesPesquisap,
     pesPlanoContabil,
     pesPlanoContabilNovo,
     pesPlanoContas,
     pesPortador,
     pesPreNotEnt,
     pesProduto,
     pesProdutoSimples,
     pesProdutoAcabado,
     pesProjeto,
     pesPromocao,
     pesPromocaoBrinde,
     pesPromocaoCupom,
     pesProspecto,
     pesRecursoProjeto,
     pesRedeLojas,
     pesRegiao,
     pesRomaneio,
     pesQualificacao,
     pesSeqRota,
     pesSetorFilizola,
     pesServicos,
     pesSituacaoOcorrencia,
     pesSituacaoProduto,
     pesSituacaoTributaria,
     pesSubRegiao,
     pesTabelaDinamica,
     pesTabelaPrecoFornecedor,
     pesTintas,
     pesTipoAtendimento,
     pesTipoCliente,
     pesTipoImobilizado,
     pesTipoOcorrencia,
     pesTipoPlanoContabil,
     pesTipoServico,
     pesTransportadora,
     pesUnidade,
     pesVeiculo,
     pesFinanceira,
     pesMotivoVerbas,
     pesVerbas,
     pesOpeMobile,
     pesCondPagBosch);

Const
  ArrDescPesquisa: Array[pesSemPesquisa..pesCondPagBosch] Of String =
    ('',
    'Abreviação Fiscal',
    'Impressora Fiscal (ECF)',
    'Abreviação Fiscal COFINS',
    'Abreviação Fiscal PIS',
    'Ajudante',
    'Ajuste de Estoque',
    'Armazém',
    'Tipo de Atendimento',
    'Atendimento 0800',
    'Atividade',
    'Banco',
    'Bandeira de Cartão',
    'Caixa',
    'Campanha',
    'Canal de Acesso',
    'Cartão',
    'Categoria Pedido/Orçamento',
    'Cest',
    'Cidade',
    'Classificação de IPI',
    'Classificação Fiscal',
    'Cliente',
    'Cliente Filial',
    'Código do CNAE',
    'Composição',
    'Código da Guia da Receita',
    'Códigos Similares',
    'Combo de Produtos para Venda',
    'Complemento de Ocorrência',
    'Condição de Pagamento',
    'Configuração',
    'Configuração de Tinta de Máquina',
    'Consumidores',
    'Contas de Resultado',
    'Contatos de Cliente',
    'Contratos de Locação de Equipamentos',
    'Cor',
    'Cor (Consulta Simples)',
    'Cor Veículo',
    'CST COFINS',
    'CST PIS',
    'CST CBS/IBS',
    'Defeito',
    'Departamento',
    'Diversos',
    'Docto. de Saída com Regra de Fat.',
    'Docto. de Saída sem Regra de Fat.',
    'Embarcações',
    'Emails Enviados',
    'Empresa',
    'Empresa (Consulta Simples)',
    'Empresa (Completo)',
    'Endereço Cliente',
    'Equipamento',
	  'Equipamento (Locação)',
    'Efetivação de Preço',
    'Estado',
    'Estoque Externo - Empresas',
    'Centro de Custos',
    'Fase da Obra',
    'Faixa de Faturamento Estimado',
    'Finalidade de Ajuste de Estoque',
    'Fornecedor',
    'Forma de Pagamento',
    'Funcionário',
    'Funcionário Autoincrem',
    'Funções',
    'Grupo de Atividade',
    'Grupo de Compra',
    'Grupo de Configuração',
    'Grupo Econômico de Fornecedores',
    'Grupo de Ocorrência',
    'Grupo de Operador',
    'Grupo de Produto',
    'Grupo de Preços',
    'Grupo Econômico Fornecedor',
    'Guia da Receita',
    'Item Estrutura',
    'Imobilizado - Documentos de Aquisição',
    'Layout (Cupom Promoção)',
    'Linha/Grupo',
    'Linha/Grupo (Consulta Simples)',
    'Local de Armazenamento - WMS',
    'Localização de Separação',
    'Localização do Lote',
    'Localização Física',
    'Lote de Produtos',
    'Lote Separação',
    'Manifesto Encerrado',
    'Marca',
    'Marca (Consultas Simples)',
    'Marca de Veículo',
    'Material Consumo',
    'Motivos de Atendimento',
    'Motivos de Vendas Perdidas',
    'Motorista',
    'Modelo Veículo',
    'Natureza da Receita de PIS e COFINS',
    'Ocorrência',
    'Operador',
    'Orçamento de Compra',
    'Orçamento de Venda',
    'Ordem de Produção Industrial',
    'Parceiro',
    'Pedido de Compra',
    'Pedido de Venda',
    'Pesquisa',
    'Plano Contábil',
    'Plano Contábil Raiz',
    'Plano de Contas',
    'Portador',
    'Pré-nota Entrada',
    'Produto',
    'Produto (Consulta Simples)',
    'Produto Acabado',
    'Projetos',
    'Promoção',
    'Promoção de Brinde',
    'Promoção (Cupom)',
    'Prospecto',
    'Recursos de Projeto',
    'Rede de Lojas',
    'Região',
    'Romaneio',
    'Qualificação',
    'Seq. Rotas',
    'Setor Filizola',
    'Serviços',
    'Situação de Ocorrência',
    'Situação do Produto',
    'Situação Tributária',
    'Sub-região',
    'Tabela de Alteração de Preço Dinâmica',
    'Tabela de Preço de Fornecedor',
    'Tinta',
    'Tipo de Atendimento',
    'Tipo de Cliente',
    'Tipo de Imobilizado',
    'Tipo de Ocorrência',
    'Tipo de Plano Contábil',
    'Tipo de Serviço',
    'Transportadora',
    'Unidade',
    'Veículo',
    'Financeira',
    'Motivo das Verbas',
    'Verbas',
    'Operadores Mobile',
    'Condição de Pagamento BOSCH');

Type
  TConsultasRel = class(TComponent)
  private
    FDecUni: Integer;
    FCadLoc: Boolean;

    FListaFiltros: TZClient;

    FListaFiltrosValor: TZClient;

    Function fSQLListaFiltros: String;
    Function fSQLListaFiltrosValor: String;

    Function fSQLListaFiltrosPesquisa: String;

    Procedure pIncluiFiltro(psgPesquisa: TPesquisas; strCodFiltro, strNomeFiltro: String);

    Procedure pCriaFiltrosPesquisaValor;

  public

    blnConsultaPelaGrid: Boolean;

    fAvaliaExpressaoString: TfuncAvaliaExpressaoString;

    fRetValorParametroGrid: TRetValorParametroGrid;

    cdsFiltrosPesquisa: TZClient;

    constructor Create(AOwner: TComponent);  Reintroduce;
    destructor Destroy; override;

    Procedure pCarregaFiltros(psgPesquisa: TPesquisas; strFiltros: String);
    Function fRetornaFiltros: String;
    Function fAvaliaExpressoesParametro(strInfo: String): Boolean;
    Function fRetValorParametro(strNomPar: String): String;
    Class Function fRetNomeOperadorRel(strCodOpe, strFilPes: String): String;
    Class Function fRetTipoOperador(strFilPes: String):String;

    Class Function fArrSelToString(arrSel: TConsultasArray; blnQuoted: Boolean): String;
    Class Function fRetDescricaoEdit(arrSel: TConsultasArray; pesPesquisa: TPesquisas): String;

    Class Function fNomePesquisaToTipo(strNomPesq: String): TPesquisas;
    Class Function fRetDescPesquisas: String;
    Class Function fRetDescricaoCompleta(strCodigo: String; pesPesquisa: TPesquisas; strFilPes: String = ''): String;
    Class Function fCompletaDescrPesquisa(pesPesquisa: TPesquisas): Boolean;
    Class Function fRetDescricaoRel(strCodigo, strNomPes: String): String;
    Class Function fTamanhoCampoPesquisa(pesPesquisa: TPesquisas): Integer;
    Class Function fTamanhoCampo(strNomCam, strTabela: String): Integer;

    Class Function fRetDescricao(strCodigo: String; pesPesquisa: TPesquisas; blnDescricao: Boolean = True; strFilPes: String = ''): String; Overload;
    Class Function fRetDescricao(strCodigo, strNomPes: String; blnValidaCompleta: Boolean = False; strFilPes: String = ''): String; Overload;

    Class Function fSQLLinhaGrupo(strNomCampo, strNomPar: String; arrLinha: TConsultasArray): String;
    Class Function fSQLPlanoContabilNovo(strNomCampo, strNomPar: String; arrPlanoContabilNovo: TConsultasArray): String;
    Class Function fSQLPlanoContas(strNomCampo, strNomPar: String; arrPlano: TConsultasArray): String;

    Class Procedure pValParToArrSel(strValPar: String; Var arrSel: TConsultasArray);

    Class Procedure pMontaValPar(Var strValPar: String; arrSel: TConsultasArray; blnSempreIn: Boolean = False);

    Function fPesqisaTabela(strNomPesq: String; Var strValPar, strDesEdt: String; frmForm: TForm; Var chrKey: Char; blnSimples: Boolean; var arrSel: TConsultasArray; APesquisa: TPesquisas = pesSemPesquisa): Boolean; overload;
    Function fPesqisaTabela(strNomPesq: String; Var strValPar, strDesEdt: String; frmForm: TForm; Var chrKey: Char; blnSimples: Boolean; APesquisa: TPesquisas = pesSemPesquisa): Boolean; overload;

    Procedure pMontaFiltrosPesquisa;

  published

    property cdsListaFiltros: TZClient read FListaFiltros;

  end;

implementation

uses Contabilidade.Consultas, Contabilidade.Funcoes ;

constructor TConsultasRel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  fRetValorParametroGrid := Nil;

  blnConsultaPelaGrid := False;

  FDecUni := fCfgSis('DECUNI', VarInteger);
  FCadLoc := fCfgSis('CADLOC', VarBoolean);

  cdsFiltrosPesquisa := TZClient.Create(Self, fSQLListaFiltrosPesquisa);

  pMontaFiltrosPesquisa;
  pCriaFiltrosPesquisaValor;
end;

destructor TConsultasRel.Destroy;
begin
  inherited;
end;

Function TConsultasRel.fSQLListaFiltros: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS  UNSIGNED) AS TIPPES, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(050)) AS CODFIL, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(050)) AS NOMFIL  ';
  Result := strSQL;
End;

Function TConsultasRel.fSQLListaFiltrosValor: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(""   AS CHAR(050)) AS CODFIL, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(255)) AS VALEXP  ';
  Result := strSQL;
End;

Function TConsultasRel.fSQLListaFiltrosPesquisa: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS  UNSIGNED) AS TIPPES, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(050)) AS CODFIL, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(050)) AS NOMFIL, ';
  strSQL := strSQL + '   CAST(""   AS CHAR(255)) AS EXPRES  ';
  Result := strSQL;
End;

Procedure TConsultasRel.pIncluiFiltro(psgPesquisa: TPesquisas; strCodFiltro, strNomeFiltro: String);
Begin
  FListaFiltros.Append;
  FListaFiltros.FieldByName('TIPPES').AsInteger := Ord(psgPesquisa);
  FListaFiltros.FieldByName('CODFIL').AsString  := strCodFiltro;
  FListaFiltros.FieldByName('NOMFIL').AsString  := strNomeFiltro;
  FListaFiltros.Post;
End;

Procedure TConsultasRel.pMontaFiltrosPesquisa;
Begin
  FListaFiltros := TZClient.Create(Self, fSQLListaFiltros);
  FListaFiltros.fLeDados('TConsultasRel.pMontaFiltrosPesquisa');
  FListaFiltros.EmptyDataSet;

  pIncluiFiltro(pesLote, 'CODITE', 'Código do Produto');
  pIncluiFiltro(pesLote, 'CODEMP', 'Código da Empresa');

  pIncluiFiltro(pesEndCliente, 'CODCLI', 'Código do Cliente');
  pIncluiFiltro(pesContatoCliente, 'CODCLI', 'Código do Cliente');

  pIncluiFiltro(pesDocSaidaComRegFat, 'ESPDOC', 'Espécie do Documento');
  pIncluiFiltro(pesDocSaidaComRegFat, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesDocSaidaComRegFat, 'DTAFIN', 'Data Final');

  pIncluiFiltro(pesDocSaidaSemRegFat, 'ESPDOC', 'Espécie do Documento');
  pIncluiFiltro(pesDocSaidaSemRegFat, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesDocSaidaSemRegFat, 'DTAFIN', 'Data Final');

  pIncluiFiltro(pesPedCompra, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesPedCompra, 'DTAFIN', 'Data Final');
  pIncluiFiltro(pesPedCompra, 'CODEMP', 'Código da Empresa');
  pIncluiFiltro(pesPedCompra, 'ABERTO', 'Somente Pedidos Abertos (S/N)');

  pIncluiFiltro(pesOrcCompra, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesOrcCompra, 'DTAFIN', 'Data Final');
  pIncluiFiltro(pesOrcCompra, 'CODEMP', 'Código da Empresa');

  pIncluiFiltro(pesNumPedVen, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesNumPedVen, 'DTAFIN', 'Data Final');

  pIncluiFiltro(pesNumOrcVen, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesNumOrcVen, 'DTAFIN', 'Data Final');

  pIncluiFiltro(pesEmailsEnviados, 'DTAINI', 'Data Inicial');
  pIncluiFiltro(pesEmailsEnviados, 'DTAFIN', 'Data Final');

  pIncluiFiltro(pesLocalizacaoLote, 'CODITE', 'Cód. Item');
  pIncluiFiltro(pesLocalizacaoLote, 'NUMLOT', 'Núm. Lote');
  pIncluiFiltro(pesLocalizacaoLote, 'CODEMP', 'Cód. Empresa');

  pIncluiFiltro(pesOperador, 'TIPOPE', 'Tipo Operador (G,M,V,C,A,S,E)');

  pIncluiFiltro(pesOrdProIndustrial, 'SITORD', 'Abertos/Baixados/Todas (A,B,T)');

  pIncluiFiltro(pesMaterialConsumo, 'CODFOR', 'Código do Fornecedor');

  pIncluiFiltro(pesAjusteEstoque, 'CODEMP', 'Código da Empresa');

  pIncluiFiltro(pesAtivoImobDocAquisicao, 'DTABAS', 'Periodo');
  pIncluiFiltro(pesAtivoImobDocAquisicao, 'CODEMP', 'Empresa');
  pIncluiFiltro(pesAtivoImobDocAquisicao, 'CLAIMO', 'Classificação');
  pIncluiFiltro(pesAtivoImobDocAquisicao, 'VENDID', 'Vendido');

  pIncluiFiltro(pesProduto, 'IMPLIS', 'Valida CFG_EXILIS? (S/N)');
  pIncluiFiltro(pesProdutoSimples, 'IMPLIS', 'Valida CFG_EXILIS? (S/N)');

  {* Gerentes                               *}
  {* Mecânicos                              *}
  {* Vendedor Interno/Representante Externo *}
  {* Compradores                            *}
  {* Administrativo                         *}
  {* Subgerente                             *}
  {* Somente vendedor da empresa logada     *}

End;

Procedure TConsultasRel.pCriaFiltrosPesquisaValor;
Begin
  FListaFiltrosValor := TZClient.Create(Self, fSQLListaFiltrosValor);
  FListaFiltrosValor.fLeDados('TConsultasRel.pCriaFiltrosPesquisaValor');
  FListaFiltrosValor.EmptyDataSet;
  FListaFiltrosValor.IndexFieldNames := 'CODFIL';
End;

Procedure TConsultasRel.pCarregaFiltros(psgPesquisa: TPesquisas; strFiltros: String);
  Var
    stlFiltros: TStringList;
    intContador: Integer;
    strFiltro: String;
Begin
  stlFiltros := TStringList.Create;
  stlFiltros.Text := AnsiReplaceStr(strFiltros, '<<csq>>', #13#10);

  If Not cdsFiltrosPesquisa.fLeDados('TConsultasRel.pCarregaFiltros') Then
    Exit;

  cdsFiltrosPesquisa.EmptyDataSet;

  FListaFiltros.Filter   := 'TIPPES = ' + IntToStr(Ord(psgPesquisa));
  FListaFiltros.Filtered := True;
  FListaFiltros.First;

  While Not FListaFiltros.Eof Do
  Begin
    cdsFiltrosPesquisa.Append;
    cdsFiltrosPesquisa.FieldByName('TIPPES').AsInteger := FListaFiltros.FieldByName('TIPPES').AsInteger;
    cdsFiltrosPesquisa.FieldByName('CODFIL').AsString  := FListaFiltros.FieldByName('CODFIL').AsString;
    cdsFiltrosPesquisa.FieldByName('NOMFIL').AsString  := FListaFiltros.FieldByName('NOMFIL').AsString;

    For intContador := 0 To stlFiltros.Count - 1 Do
      If AnsiStartsStr(cdsFiltrosPesquisa.FieldByName('EXPRES').AsString, stlFiltros[intContador]) Then
      Begin
        strFiltro := stlFiltros[intContador];
        System.Delete(strFiltro, 1, Pos(';', strFiltro));
        cdsFiltrosPesquisa.FieldByName('EXPRES').AsString := strFiltro;
        stlFiltros.Delete(intContador);
        Break;
      End;

    cdsFiltrosPesquisa.Post;

    FListaFiltros.Next;
  End;

  FreeAndNil(stlFiltros);
End;

Function TConsultasRel.fRetornaFiltros: String;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;
  Result := '';

  cdsFiltrosPesquisa.First;

  While Not cdsFiltrosPesquisa.Eof Do
  Begin
    stlLista.Add(Concat(cdsFiltrosPesquisa.FieldByName('CODFIL').AsString, ';', cdsFiltrosPesquisa.FieldByName('EXPRES').AsString));

    cdsFiltrosPesquisa.Next;
  End;

  Result := AnsiReplaceStr(stlLista.Text, #13#10, '<<csq>>');

  FreeAndNil(stlLista);
End;

Function TConsultasRel.fAvaliaExpressoesParametro(strInfo: String): Boolean;
  Var
    stlFiltros: TStringList;
    intContador: Integer;
    strLinha,
    strFiltro: String;
    blnErro: Boolean;
Begin
  Result := True;
  stlFiltros := Nil;

  Try
    FListaFiltrosValor.EmptyDataSet;

    If strInfo.IsEmpty Then
      Exit;

    If Not Assigned(fAvaliaExpressaoString) Then
      Exit;

    stlFiltros := TStringList.Create;
    stlFiltros.Text := AnsiReplaceStr(strInfo, '<<csq>>', #13#10);

    For intContador := 0 To stlFiltros.Count - 1 Do
    Begin

      strLinha  := stlFiltros[intContador];
      strFiltro := LeftStr(strLinha, Pred(Pos(';', strLinha)));

      System.Delete(strLinha, 1, Pos(';', strLinha));

      If Not strLinha.IsEmpty Then
      Begin
        FListaFiltrosValor.Append;
        FListaFiltrosValor.FieldByName('CODFIL').AsString := strFiltro;
        FListaFiltrosValor.FieldByName('VALEXP').AsString := fAvaliaExpressaoString(strLinha, blnErro);
        FListaFiltrosValor.Post;

        If blnErro Then
        Begin
          Result := False;
          Exit;
        End;
      End;

    End;

  Finally

    If Assigned(stlFiltros) Then
      FreeAndNil(stlFiltros);
  End;

End;

Function TConsultasRel.fRetValorParametro(strNomPar: String): String;
Begin
  If blnConsultaPelaGrid Then
  Begin
    If Assigned(fRetValorParametroGrid) Then
      Result := fRetValorParametroGrid(strNomPar)
    Else
      Result := '';
  End Else
  Begin
    If FListaFiltrosValor.FindKey([strNomPar]) Then
      Result := FListaFiltrosValor.FieldByName('VALEXP').AsString
    Else
      Result := '';
  End;
End;

Class Function TConsultasRel.fRetDescPesquisas: String;
  Var
    sltLista: TStringList;
    desContador: TPesquisas;
Begin
  sltLista := TStringList.Create;

  For desContador := Low(TPesquisas) To High(TPesquisas) Do
    sltLista.Add(ArrDescPesquisa[desContador]);

  Result := sltLista.Text;

  FreeAndNil(sltLista);
End;

Class Function TConsultasRel.fNomePesquisaToTipo(strNomPesq: String): TPesquisas;
  Var
    desContador: TPesquisas;
Begin
  Result := pesSemPesquisa;

  If strNomPesq.IsEmpty Then
    Exit;

  For desContador := Low(TPesquisas) To High(TPesquisas) Do
    If SameText(strNomPesq, ArrDescPesquisa[desContador]) Then
    begin
      Result := desContador;
      Exit;
    End;
End;

Class Function TConsultasRel.fCompletaDescrPesquisa(pesPesquisa: TPesquisas): Boolean;
begin
  {* Tipos de pesquisa que não vão completar a descrição na frente do retorno *}
  Result := not(pesPesquisa in [pesPedCompra, pesOrcCompra, pesNumPedVen, pesNumOrcVen, pesPreNotEnt, pesRomaneio,
    pesLote, pesCodigoSimilar, pesDocSaidaComRegFat, pesDocSaidaSemRegFat, pesLocalizacaoLote, pesAjusteEstoque,
    pesAtivoImobDocAquisicao, pesLoteSeparacao, pesManifestoEncerrado, pesContratoLogEquip]);
end;

Class Function TConsultasRel.fRetDescricaoEdit(arrSel: TConsultasArray; pesPesquisa: TPesquisas): String;
Begin
  Result := '';

  If Length(arrSel) > 1 Then
    Result := fArrSelToString(arrSel, False)

  Else If Length(arrSel) > 0 Then
    Result := fRetDescricaoCompleta(arrSel[0].strCodigo, pesPesquisa);
End;

Class Function TConsultasRel.fRetDescricaoCompleta(strCodigo: String; pesPesquisa: TPesquisas; strFilPes: String = ''): String;
  Var
    blnCompletaDescricao: Boolean;
Begin
  blnCompletaDescricao := TConsultasRel.fCompletaDescrPesquisa(pesPesquisa);
  Result := IIF(blnCompletaDescricao, strCodigo + '-' + fRetDescricao(strCodigo, pesPesquisa, True, strFilPes), strCodigo);
End;

Class Function TConsultasRel.fRetDescricao(strCodigo: String; pesPesquisa: TPesquisas; blnDescricao: Boolean = True;
  strFilPes: String = ''): String;
  Var
    objTintas: ITintasDeMaquina;
Begin
  Case pesPesquisa  Of
    pesAbreviacaoFiscal:       Result := fRetDesAbfIcm(strCodigo);
    pesECFFiscal:              Result := fCampoTabela('ECF_DESCRI', 'CADECF', ['ECF_CODECF'], [strCodigo]);
    pesArmazem:                Result := fRetNomeArmazem(strCodigo);
    pesAjudante:               Result := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [strCodigo], False);
    pesAjusteEstoque:          Result := fCampoTabela('GER_NUMDOC', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC'], [strCodigo, 'AJ']);
    pesAtividade:              Result := fRetNomAtividade(strCodigo);
    pesTpAtendimento:          Result := fCampoTabela('TPA_DESCRI', 'CADTPA', ['TPA_CODIGO'], [strCodigo]);
    pesAtendimento0800:        Result := fRetSeqAtd0800(strCodigo);
    pesBanco:                  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodigo]);
    pesBandeiraCartao:         Result := fRetNomBandeira(strCodigo);
    pesCaixa:                  Result := fCampoTabela('CAX_DESCRI', 'CADCAX', ['CAX_CODCAX'], [strCodigo]);
    pesCampanha:               Result := fCampoTabela('CMG_DESCMG', 'CAMGER', ['CMG_CODCMG'], [strCodigo]);
    pesCanalAcesso:            Result := fRetNomCanalAcesso(strCodigo);
    pesCartao:                 Result := fCampoTabela('CAR_DESCAR', 'CADCAR', ['CAR_CODCAR'], [strCodigo]);
    pesCategoriaPedOrc:        Result := fCampoTabela('CAT_DESCRI', 'CATEGO', ['CAT_CODIGO'], [strCodigo]);
    pesCest:                   Result := fCampoTabela('CES_DESCRI', 'CDCEST', ['CES_CDCEST'], [strCodigo]);
    pesCidade:                 Result := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodigo], False);
    pesClassificacaoFiscal : Result := fCampoTabela('CFO_DESCR1','CADCFO',['CFO_CODCFO'],[strCodigo]);
    pesCliente          : Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodigo]);
    pesClienteFilial    : Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodigo]);
    pesCodigoCnae       : Result := fCampoTabela('CNA_NOMCNA', 'CADCNA', ['CNA_CODCNA'], [strCodigo]);
    pesCodigoReceita:          Result := fCampoTabela('TRI_DESCRI', 'TIPTRI', ['TRI_CODTRI'], [strCodigo]);
    pesGuiaReceita:            Result := fCampoTabela('GUI_DESCRI', 'GUITRI', ['GUI_CODGUI'], [strCodigo]);
    pesCodigoSimilar    : Result := fCampoTabela('ITE_CODSIM', 'CADITE', ['LPAD(ITE_CODSIM, 6, ''0'')'], [strCodigo]);
    pesComboProdutoVenda: Result := fCampoTabela('COM_DESCOM', 'COMVEN', ['COM_CODCOM'], [strCodigo]);
    pesCompleOcorrencia : Result := fCampoTabela('COC_DESCOC', 'CADCOC', ['COC_CODCOC'], [strCodigo]);
    pesCondicaoPagamento: Result := fCampoTabela('CND_DESCRI', 'CADCND', ['CND_CODIGO'], [strCodigo], False);
    pesComposicao:             Result := fCampoTabela('GCO_DESCOM', 'GERCOM', ['GCO_CODCOM'], [strCodigo], False);
    pesConfiguracao:           Result := fRetNomCfg(strCodigo);
    pesConfiguracaoTinta:      Result := fRetNomCfgTin(strCodigo);
    pesConsumidores:           Result := fCampoTabela('CON_NOMCON', 'CLICON', ['CON_C_P_F_'], [strCodigo]);
    pesContratoLogEquip:       Result := fCampoTabela('EQL_NROCON', 'CONEQL', ['EQL_NROCON'], [strCodigo]);
    pesCor:                    Result := fCampoTabela('COR_DESCOR', 'CADCOR', ['COR_CODCOR'], [strCodigo]);
    pesCorVeiculo:             Result := fCampoTabela('COR_DESCOR', 'CORVEI', ['COR_CODCOR'], [strCodigo]);
    pesContasdeResultado:      Result := fRetContaResultado(strCodigo);
    pesCorSimples:             Result := fCampoTabela('COR_DESCOR', 'CADCOR', ['COR_CODCOR'], [strCodigo]);
    pesDefeito:                Result := fCampoTabela('DFE_DESCRI', 'CADDFE', ['DFE_CODIGO'], [strCodigo]);
    pesDepartamento:           Result := fCampoTabela('DEP_DESCRI', 'CADDEP', ['DEP_CODIGO'], [strCodigo]);
    pesDiversos:               Result := fCampoTabela('DIV_NOMDIV', 'CADDIV', ['DIV_CODDIV'], [strCodigo]);
    pesDocSaidaComRegFat:      Result := fCampoTabela('GER_NUMDOC', 'MOVGER', ['GER_NUMDOC'], [strCodigo]);
    pesDocSaidaSemRegFat:      Result := fCampoTabela('GER_NUMDOC', 'MOVGER', ['GER_NUMDOC'], [strCodigo]);
    pesEmbarcacao:             Result := fCampoTabela('EMB_NOMEMB', 'CADEMB', ['EMB_CODEMB'], [strCodigo]);
    pesEmailsEnviados:         Result := fCampoTabela('ENV_EMASTO', 'EMAENV', ['ENV_EMACOD'], [strCodigo]);
    pesEmpresa:                If Pos(strCodigo, strEmpAcessoUsuarioLogado) > 0 Then
                                 Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodigo], False)
                               Else
                                 Result := '';
    pesEmpresaSimples:         If Pos(strCodigo, strEmpAcessoUsuarioLogado) > 0 Then
                                 Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodigo], False)
                               Else
                                 Result := '';
    pesEmpresaCompleto:       If Pos(strCodigo, strEmpAcessoUsuarioLogado) > 0 Then
                                 Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodigo], False)
                               Else
                                 Result := '';

    pesEndCliente:             Result := fCampoTabela('ETC_ENDENT', 'ENTCLI', ['AUTOINCREM'], [strCodigo]);
    pesContatoCliente:         Result := fCampoTabela('CLI_NOMCTT', 'CLICTT', ['AUTOINCREM'], [strCodigo]);
    pesEquipamento:            Result := fCampoTabela('EQU_DESCRI', 'CADEQU', ['EQU_CODIGO'], [strCodigo]);
    pesEquipLocacao:           Result := fCampoTabela('EQL_DESCRI', 'CADEQL', ['EQL_CODIGO'], [strCodigo]);
    pesEfetivacaoPreco:        Result := fRetEfetivacaoPreco(strCodigo);
    pesEstado:                 Result := fRetNomeEstado(strCodigo);
    pesEstoqueExternoEmpresas: Result := fCampoTabela('EEE_DESEEE', 'CADEEE', ['EEE_CODEEE'], [strCodigo]);
    pesEvento:                 Result := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [strCodigo]);
    pesFaseObra:               Result := fCampoTabela('FAS_DESCRI', 'FASOBR', ['FAS_CODFAS'], [strCodigo]);
    pesFaixaFatEstimado:       Result := fCampoTabela('CRF_DESCRI', 'CRMFAI', ['CRF_CODIGO'], [strCodigo]);
    pesFornecedor:             Result := fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [strCodigo]);
    pesFormaDePagamento:       Result := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], [strCodigo], False);
    pesFuncionario:            Result := fCampoTabela('FUN_NOMFUN', 'CADFUN', ['FUN_CODFUN'], [strCodigo]);
    pesFuncionarioAutoincrem:  Result := fCampoTabela('FUN_NOMFUN', 'CADFUN', ['AUTOINCREM'], [strCodigo]);
    pesFuncoesFuncionario:     Result := fCampoTabela('FNC_NOMFNC', 'CADFNC', ['FNC_CODFNC'], [strCodigo]);
    pesGrupoAtividade:         Result := fCampoTabela('GAT_DESCRI', 'CADGAT', ['GAT_CODGAT'], [strCodigo]);
    pesGrupoCompra:            Result := fRetDescGrupoCompra(strCodigo);
    pesGrupoConfiguracao:      Result := strCodigo;
    pesGrupoEcoFornecedores:   Result := fCampoTabela('GEF_DESGEF', 'GRECFR', ['GEF_CODGEF'], [strCodigo]);
    pesGrupoOcorrencia:        Result := fCampoTabela('GOC_DESGOC', 'CADGOC', ['GOC_CODGOC'], [strCodigo]);
    pesGrupoOperador:          Result := fRetNomCadGpo(strCodigo);
    pesGrupoProduto:           Result := fCampoTabela('PRD_DESGRU', 'GRPPRD', ['PRD_CODGRU'], [strCodigo]);// fRetNomeGrupoProduto(strCodigo);
    pesGrupoDePrecos:          Result := fRetNomeGrupoPrecos(strCodigo);
    pesGrupoEcoFornec:         Result := fCampoTabela('GEF_DESGEF', 'GRECFR', ['GEF_CODGEF'], [strCodigo]);
    pesItemEstrutura:          Result := fRetItemEstrutura(strCodigo);
    pesAtivoImobDocAquisicao:  Result := fCampoTabela('IMO_DOCAQU', 'CADIMO', ['IMO_DOCAQU'], [strCodigo]);
    pesLayoutCupomPromocao:    Result := fCampoTabela('LAY_DESCRI', 'LAYETI', ['LAY_CODLAY', 'LAY_TIPLAY'], [strCodigo, '229']);
    pesLinhaGrupo:             Result := fCampoTabela('GRU_DESGRU', 'CADGRU', ['GRU_CODGRU'], [strCodigo]);
    pesLinhaGrupoSimples:      Result := fCampoTabela('GRU_DESGRU', 'CADGRU', ['GRU_CODGRU'], [strCodigo]);
    pesLocalArmazenamentoWMS:  Result := fCampoTabela('LAR_DESLAR', 'CADLAR', ['LAR_CODLAR'], [strCodigo]);
    pesLocalizacaoDeSeparacao: Result := fCampoTabela('LSE_DESCRI', 'CADLSE', ['LSE_CODIGO'], [strCodigo]);
    pesLocalizacaoFisica:      If fCfgSis('CADLOC', VarBoolean) Then
                                 Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'], [strCodigo, VS_strCodEmp], False)
                               Else
                                 Result := '';

    pesLocalizacaoLote:        Result := fCampoTabela('LLC_LOCFIS', 'LOTLOC', ['LLC_LOCFIS'], [strCodigo]);
    pesLoteSeparacao:          Result := fCampoTabela('RLG_NUMLOT', 'ROMLGE', ['RLG_NUMLOT'], [strCodigo]);
    pesManifestoEncerrado:     Result := strCodigo;
    pesMarca:                  Result := fCampoTabela('MAR_DESMAR', 'CADMAR', ['MAR_CODMAR'], [strCodigo]);
    pesMarcaSimples:           Result := fCampoTabela('MAR_DESMAR', 'CADMAR', ['MAR_CODMAR'], [strCodigo]);
    pesMarcaVeiculo:           Result := fCampoTabela('MAR_DESMAR', 'MARVEI', ['MAR_CODMAR'], [strCodigo]);
    pesMaterialCOnsumo:        Result := fCampoTabela('MCO_DESCRI', 'CADMCO', ['MCO_CODMCO'], [strCodigo]);
    pesMotivosAtend:           Result := fCampoTabela('MOT_DESCRI', 'MOTATE', ['MOT_CODMOT'], [strCodigo]);
    pesMotVendasPerdidas:      Result := fCampoTabela('MOT_DESMOT', 'MOTVPD', ['MOT_CODMOT'], [strCodigo]);
    pesMotorista:              Result := fCampoTabela('MOT_NOMMOT', 'CADMOT', ['MOT_CODMOT'], [strCodigo]);
    pesModeloVeiculo:          Result := fCampoTabela('MOD_DESMOD', 'MODVEI', ['MOD_CODMOD'], [strCodigo]);
    pesNatReceitaPisCof:       Result := fCampoTabela('NRE_DESNAT', 'CADNRE', ['NRE_CODNAT'], [strCodigo]);
    pesNumPedVen:              Result := fCampoTabela('FGO_NUMDOC', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC'], [strCodigo, 'PD']);
    pesNumOrcVen:              Result := fCampoTabela('FGO_NUMDOC', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC'], [strCodigo, 'OR']);
    pesOcorrencia:             Result := fRetDescOcorrencia(strCodigo);
    pesOperador:               Result := fRetNomeOperadorRel(strCodigo, strFilPes);
    pesParceiro:               Result := fCampoTabela('PAR_NOMPAR', 'CADPAR', ['PAR_CODPAR'], [strCodigo]);
    pesPedCompra:              Result := fCampoTabela('PCG_NUMPED', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC'], [strCodigo, 'PD']);
    pesOrcCompra:              Result := fCampoTabela('PCG_NUMPED', 'PCMGER', ['PCG_NUMPED', 'PCG_ESPDOC'], [strCodigo, 'OR']);
    pesOrdProIndustrial:       Result := fCampoTabela('ORD_CODORD', 'ORDGER', ['ORD_CODORD'], [strCodigo]);
    pesPesquisap:              Result := fCampoTabela('PES_DESPES', 'CADPES', ['PES_CODPES'], [strCodigo]);
    pesPlanoContabil:          Result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [strCodigo, fRetTplacoEmpresaLogada]);
    pesPlanoContabilNovo:      Result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [strCodigo, fRetTplacoEmpresaLogada]);
    pesPlanoContas:            Result := fCampoTabela('CTA_DESCTA', 'CADCTA', ['CTA_CODCTA'], [strCodigo]);
    pesPortador:               If (Pos(strCodigo, strPortadoresOperador) > 0) Or (Not fCfgSis('DACPOR', varBoolean)) Then
                                 Result := fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [strCodigo])
                               Else
                                 Result := '';
    pesPreNotEnt:              Result := fCampoTabela('B08_NNF', 'GERELE', ['B08_NNF'], [strCodigo]);
    pesProduto:                Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodigo], False);
    pesProdutoSimples:         Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodigo], False);
    pesProdutoAcabado:         Result := fCampoTabela('ACA_DESCRI', 'CADACA', ['ACA_CODACA'], [strCodigo]);
    pesProjeto:                Result := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [strCodigo]);
    pesPromocao:               Result := fCampoTabela('PRO_DESPRO', 'CADPRO', ['PRO_CODPRO'], [strCodigo]);
    pesPromocaoBrinde:         Result := fCampoTabela('PRO_DESPRO', 'PROBRI_GER', ['PRO_CODPRO'], [strCodigo]);
    pesPromocaoCupom:          Result := fCampoTabela('CPP_DESCPP', 'CADCPP', ['CPP_CODCPP'], [strCodigo]);
    pesProspecto:              Result := fCampoTabela('PRO_NOMCLI', 'PROSPE', ['PRO_CODPRO'], [strCodigo]);
    pesRecursoProjeto:         Result := fCampoTabela('REP_NOMREP', 'CADREP', ['REP_CODREP'], [strCodigo]);
    pesRedeLojas:              Result := fCampoTabela('RED_DESRED', 'CADRED', ['RED_CODRED'], [strCodigo]);
    pesRegiao:                 Result := fRetNomRegiao(strCodigo);
    pesRomaneio:               Result := fCampoTabela('GER_NUMROM', 'ROMGERX', ['GER_NUMROM'], [strCodigo]);
    pesQualificacao:           Result := fCampoTabela('QUA_DESQUA', 'CADQUA', ['QUA_CODQUA'], [strCodigo]);
    pesSeqRota:                Result := fCampoTabela('ENT_CODIGO', 'ENTREG', ['ENT_CODIGO'], [strCodigo]);
    pesSetorFilizola:          Result := fRetDesSfz(strCodigo);
    pesServicos:               Result := fCampoTabela('SER_DESSER', 'CADSER', ['SER_CODSER'], [strCodigo]);
    pesSituacaoOcorrencia:     Result := fRetDesSitOco(strCodigo);
    pesSituacaoProduto:        Result := fRetNomSituacaoProduto(strCodigo);
    pesSituacaoTributaria:     Result := fCampoTabela('TRI_DESC01', 'CADTRI', ['TRI_CODTRI'], [strCodigo]);
    pesSubRegiao:              Result := fRetNomSubRegiao(strCodigo);
    pesTabelaDinamica:         Result := fRetNomTabelaDinamica(strCodigo);
    pesTabelaPrecoFornecedor:  Result := fRetNomTabelaPreco(strCodigo);
    pesTipoAtendimento       :Result := fCampoTabela('TPA_DESCRI', 'CADTPA', ['TPA_CODIGO'], [strCodigo]);
    pesTipoCliente          : Result := fCampoTabela('TIP_DESTIP', 'TIPCLG', ['TIP_CODTIP'], [strCodigo]);
    pesTipoImobilizado      : Result := fCampoTabela('TIP_DESCRI', 'TIPIMO', ['TIP_CODTIP'], [strCodigo]);
    pesTipoOcorrencia        :Result := fRetDescTipoOcorrencia(strCodigo);
    pesTipoPlanoContabil:      Result := fCampoTabela('ACO_DESCRI', 'TPLACO', ['ACO_CODIGO'], [strCodigo]);
    pesTipoServico           :Result := fCampoTabela('TPS_DESCRI', 'TIPSER', ['TPS_CODIGO'], [strCodigo]);
    pesTintas:                 Begin
                                 If (VS_strUsaTmq = 'S') Then
                                 Begin
                                   objTintas := fGetTintasdeMaquina;

                                   If objTintas.fEstaDisponivel(strCodigo) Then
                                     Result  := objTintas.fGetNomeTinta(strCodigo)
                                   Else
                                     Result := '';
                                 End
                                 Else
                                   Result := '';
                               End;
    pesTransportadora:         Result := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'], [strCodigo]);
    pesUnidade:                Result := fCampoTabela('UNI_DESUNI', 'CADUNI', ['UNI_CODUNI'], [strCodigo], False);
    pesVeiculo:                Result := fRetDescVeiculo(strCodigo);
    pesFinalidadeAjuste:       Result := fCampoTabela('FAJ_DESCRI', 'FINAJU', ['FAJ_CODIGO'], [strCodigo]);
    pesAbvPIS:                 Result := fCampoTabela('APC_DESCRI', 'PISSAI', ['APC_CODAPC'], [strCodigo]);
    pesCSTPIS:                 Result := fCampoTabela('CST_DESCRI', 'CSTPIS', ['CST_CODCST'], [strCodigo]);
    pesCSTCBS:                 Result := fCampoTabela('NOME_CCLASSTRIB', 'CLASSTRIBPUBLICACAO', ['CCLASSTRIB'], [strCodigo]);
    pesAbvCOF:                 Result := fCampoTabela('APC_DESCRI', 'COFSAI', ['APC_CODAPC'], [strCodigo]);
    pesCSTCOF:                 Result := fCampoTabela('CST_DESCRI', 'CSTCOF', ['CST_CODCST'], [strCodigo]);
    pesFinanceira:             Result := fCampoTabela('FIN_DESCRI', 'CADFIN', ['FIN_CODIGO'], [strCodigo]);
    pesMotivoVerbas:           Result := fCampoTabela('VBA_DESMOT', 'MOTVBA', ['VBA_CODMOT'], [strCodigo]);
    pesVerbas:                 Result := fCampoTabela('VER_DESVER', 'CADVER', ['VER_CODVER'], [strCodigo]);
    pesOpeMobile:              Result := fRetNomeOpeMobile(strCodigo);
    pesCondPagBosch:           Result := fRetCondPagBosch(strCodigo);

    Else                       Result := '';
  End;

  Result := IIF(blnDescricao, Result, '');
End;

Class Function TConsultasRel.fRetDescricao(strCodigo, strNomPes: String; blnValidaCompleta: Boolean = False; strFilPes: String = ''): String;
var
  blnCompletaDescricao: Boolean;
Begin
  blnCompletaDescricao := (not blnValidaCompleta) or (TConsultasRel.fCompletaDescrPesquisa(TConsultasRel.fNomePesquisaToTipo(strNomPes)));
  Result := TConsultasRel.fRetDescricao(strCodigo, TConsultasRel.fNomePesquisaToTipo(strNomPes), blnCompletaDescricao, strFilPes);
End;

Class Function TConsultasRel.fTamanhoCampoPesquisa(pesPesquisa: TPesquisas): Integer;
Begin
  Case pesPesquisa  Of
    pesAbreviacaoFiscal:       Result := fTamanhoCampo('ABF_CODABF', 'ABFICM');
    pesECFFiscal:              Result := fTamanhoCampo('ECF_CODECF', 'CADECF');
    pesAjudante:               Result := fTamanhoCampo('AJU_CODAJU', 'CADAJU');
    pesAjusteEstoque:          Result := fTamanhoCampo('GER_NUMDOC', 'MOVGER');
    pesArmazem:                Result := fTamanhoCampo('AMZ_CODAMZ', 'CADAMZ');
    pesAtividade:              Result := fTamanhoCampo('ATI_CODATI', 'CADATI');
    pesTpAtendimento:          Result := fTamanhoCampo('TPA_CODIGO', 'CADTPA');
    pesAtendimento0800:        Result := fTamanhoCampo('TEL_SEQUEN', 'CAD800');
    pesBanco:                  Result := fTamanhoCampo('BCO_CODBCO', 'CADBCO');
    pesBandeiraCartao:         Result := fTamanhoCampo('BAN_CODBAN', 'CADBAN');
    pesCaixa:                  Result := fTamanhoCampo('CAX_CODCAX', 'CADCAX');
    pesCampanha:               Result := fTamanhoCampo('CMG_CODCMG', 'CAMGER');
    pesCanalAcesso:            Result := fTamanhoCampo('CAC_CODCAC', 'CADCAC');
    pesCartao:                 Result := fTamanhoCampo('CAR_CODCAR', 'CADCAR');
    pesCategoriaPedOrc:        Result := fTamanhoCampo('CAT_CODIGO', 'CATEGO');
    pesCest:                   Result := fTamanhoCampo('CES_CDCEST', 'CDCEST');
    pesCidade:                 Result := fTamanhoCampo('CID_CODCID', 'CADCID');
    pesClassificacaoFiscal : Result := fTamanhoCampo('CFO_CODCFO','CADCFO');
    pesCliente             : Result := fTamanhoCampo('CLI_CODCLI', 'CADCLI');
    pesClienteFilial    : Result := fTamanhoCampo('CLI_CODCLI', 'CADCLI');
    pesCodigoCnae       : Result := fTamanhoCampo('CNA_CODCNA', 'CADCNA');
    pesCodigoReceita:          Result := 0; //fTamanhoCampo('TRI_CODTRI', 'TIPTRI');
    pesGuiaReceita:            Result := 0; //fTamanhoCampo('GUI_CODGUI', 'GUITRI');
    pesCodigoSimilar    : Result := fTamanhoCampo('ITE_CODSIM', 'CADITE');
    pesComboProdutoVenda: Result := fTamanhoCampo('COM_CODCOM', 'COMVEN');
    pesCompleOcorrencia : Result := fTamanhoCampo('COC_CODCOC', 'CADCOC');
    pesCondicaoPagamento: Result := fTamanhoCampo('CND_CODIGO', 'CADCND');
    pesComposicao:             Result := fTamanhoCampo('GCO_CODCOM', 'GERCOM');
    pesConfiguracao:           Result := 6;
    pesConfiguracaoTinta:      Result := 6;
    pesContratoLogEquip:       Result := fTamanhoCampo('EQL_NROCON', 'CONEQL');
    pesCor:                    Result := fTamanhoCampo('COR_CODCOR', 'CADCOR');
    pesCorVeiculo:             Result := fTamanhoCampo('COR_CODCOR', 'CORVEI');
    pesContasdeResultado:      Result := fTamanhoCampo('CRE_CODCRE', 'CTARES');
    pesCorSimples:             Result := fTamanhoCampo('COR_CODCOR', 'CADCOR');
    pesDefeito:                Result := fTamanhoCampo('DFE_CODIGO', 'CADDFE');
    pesDepartamento:           Result := fTamanhoCampo('DEP_CODIGO', 'CADDEP');
    pesDiversos:               Result := fTamanhoCampo('DIV_CODDIV', 'CADDIV');
    pesDocSaidaComRegFat:      Result := fTamanhoCampo('GER_NUMDOC', 'MOVGER');
    pesDocSaidaSemRegFat:      Result := fTamanhoCampo('GER_NUMDOC', 'MOVGER');
    pesEmbarcacao:             Result := fTamanhoCampo('EMB_CODEMB', 'CADEMB');
    pesEmailsEnviados:         Result := 20; {fTamanhoCampo('ENV_EMACOD', 'EMAENV');}
    pesEmpresa:                Result := fTamanhoCampo('EMP_CODEMP', 'CADEMP');
    pesEmpresaSimples:         Result := fTamanhoCampo('EMP_CODEMP', 'CADEMP');
    pesEmpresaCompleto:        Result := fTamanhoCampo('EMP_CODEMP', 'CADEMP');
    pesEndCliente :            Result := fTamanhoCampo('AUTOINCREM', 'ENTCLI');
    pesContatoCliente:         Result := fTamanhoCampo('AUTOINCREM', 'CLICTT');
    pesEquipamento:            Result := fTamanhoCampo('EQU_CODIGO', 'CADEQU');
    pesEquipLocacao:           Result := fTamanhoCampo('EQL_CODIGO', 'CADEQL');
    pesEfetivacaoPreco:        Result := 8;
    pesEstado:                 Result := 2;
    pesEstoqueExternoEmpresas: Result := fTamanhoCampo('EEE_CODEEE', 'CADEEE');
    pesEvento:                 Result := fTamanhoCampo('EVE_CODEVE', 'CADEVE');
    pesFaseObra:               Result := fTamanhoCampo('FAS_CODFAS', 'FASOBR');
    pesFaixaFatEstimado:       Result := fTamanhoCampo('CRF_CODIGO', 'CRMFAI');
    pesFornecedor:             Result := fTamanhoCampo('FOR_CODFOR', 'CADFOR');
    pesFormaDePagamento:       Result := fTamanhoCampo('FPG_CODIGO', 'CADFPG');
    pesFuncionario:            Result := fTamanhoCampo('FUN_CODFUN', 'CADFUN');
    pesFuncionarioAutoincrem:  Result := fTamanhoCampo('AUTOINCREM', 'CADFUN');
    pesFuncoesFuncionario:     Result := fTamanhoCampo('FNC_CODFNC', 'CADFNC');
    pesGrupoAtividade:         Result := fTamanhoCampo('GAT_CODGAT', 'CADGAT');
    pesGrupoCompra:            Result := fTamanhoCampo('GRU_CODIGO', 'GRU_COMPRA');
    pesGrupoConfiguracao:      Result := 0;
    pesGrupoEcoFornecedores:   Result := fTamanhoCampo('GEF_CODGEF', 'GRECFR');
    pesGrupoOcorrencia:        Result := fTamanhoCampo('GOC_CODGOC', 'CADGOC');
    pesGrupoOperador:          Result := fTamanhoCampo('GPO_CODGPO', 'CADGPO');
    pesGrupoProduto:           Result := fTamanhoCampo('PRD_CODGRU', 'GRPPRD');
    pesGrupoDePrecos:          Result := fTamanhoCampo('ITE_CODGPR', 'CADITE');
    pesGrupoEcoFornec:         Result := fTamanhoCampo('GEF_CODGEF', 'GRECFR');
    pesItemEstrutura:          Result := fTamanhoCampo('GMT_CODITE', 'GERMAT');
    pesAtivoImobDocAquisicao:  Result := 12;
    pesLayoutCupomPromocao:    Result := fTamanhoCampo('LAY_CODLAY', 'LAYETI');
    pesLinhaGrupoSimples:      Result := fTamanhoCampo('GRU_CODGRU', 'CADGRU');
    pesLocalArmazenamentoWMS:  Result := fTamanhoCampo('LAR_CODLAR', 'CADLAR');
    pesLocalizacaoDeSeparacao: Result := fTamanhoCampo('LSE_CODIGO', 'CADLSE');
    pesLocalizacaoLote:        Result := fCfgSis('QCUCLL', VarInteger);
    pesLoteSeparacao:          Result := 8;
    pesManifestoEncerrado:     Result := 6;
    pesMarca:                  Result := fTamanhoCampo('MAR_CODMAR', 'CADMAR');
    pesMarcaSimples:           Result := fTamanhoCampo('MAR_CODMAR', 'CADMAR');
    pesMarcaVeiculo:           Result := fTamanhoCampo('MAR_CODMAR', 'MARVEI');
    pesMaterialConsumo:        Result := fTamanhoCampo('MCO_CODMCO', 'CADMCO');
    pesMotivosAtend:           Result := fTamanhoCampo('MOT_CODMOT', 'MOTATE');
    pesMotVendasPerdidas:      Result := fTamanhoCampo('MOT_CODMOT', 'MOTVPD');
    pesMotorista:              Result := fTamanhoCampo('MOT_CODMOT', 'CADMOT');
    pesModeloVeiculo:          Result := fTamanhoCampo('MOD_CODMOD', 'MODVEI');
    pesNatReceitaPisCof:       Result := fTamanhoCampo('NRE_CODNAT', 'CADNRE');
    pesNumPedVen:              Result := fTamanhoCampo('FGO_NUMDOC', 'FATGOR');
    pesNumOrcVen:              Result := fTamanhoCampo('FGO_NUMDOC', 'FATGOR');
    pesOcorrencia:             Result := fTamanhoCampo('OCO_CODOCO', 'CADOCO');
    pesOperador:               Result := fTamanhoCampo('OPE_CODOPE', 'CADOPE');
    pesParceiro:               Result := fTamanhoCampo('PAR_CODPAR', 'CADPAR');
    pesPedCompra:              Result := fTamanhoCampo('PCG_NUMPED', 'PCMGER');
    pesOrcCompra:              Result := fTamanhoCampo('PCG_NUMPED', 'PCMGER');
    pesOrdProIndustrial:       Result := 3;
    pesPesquisap:              Result := fTamanhoCampo('PES_CODPES', 'CADPES');
    pesPlanoContabil:          Result := fRetornaQtdCharPlanoContabil();
    pesPlanoContabilNovo:      Result := fRetornaQtdCharPlanoContabil();
    pesPortador:               Result := fTamanhoCampo('POR_CODPOR', 'CADPOR');
    pesPreNotEnt:              Result := fTamanhoCampo('B08_NNF', 'GERELE');
    pesProduto:                Result := fTamanhoCampo('ITE_CODITE', 'CADITE');
    pesProdutoSimples:         Result := fTamanhoCampo('ITE_CODITE', 'CADITE');
    pesProdutoAcabado:         Result := fTamanhoCampo('ACA_CODACA', 'CADACA');
    pesProjeto:                Result := fTamanhoCampo('PRJ_CODPRJ', 'CADPRJ');
    pesPromocao:               Result := fTamanhoCampo('PRO_CODPRO', 'CADPRO');
    pesPromocaoBrinde:         Result := fTamanhoCampo('PRO_CODPRO', 'PROBRI_GER');
    pesPromocaoCupom:          Result := fTamanhoCampo('CPP_CODCPP', 'CADCPP');
    pesProspecto:              Result := fTamanhoCampo('PRO_CODPRO', 'PROSPE');
    pesRecursoProjeto:         Result := fTamanhoCampo('REP_CODREP', 'CADREP');
    pesRedeLojas:              Result := fTamanhoCampo('RED_CODRED', 'CADRED');
    pesRegiao:                 Result := fTamanhoCampo('REG_CODREG', 'CADREG');
    pesRomaneio:               Result := fTamanhoCampo('GER_NUMROM', 'ROMGERX');
    pesQualificacao:           Result := fTamanhoCampo('QUA_CODQUA', 'CADQUA');
    pesSeqRota:                Result := fTamanhoCampo('ENT_CODIGO', 'ENTREG');
    pesSetorFilizola:          Result := fTamanhoCampo('SFZ_CODSFZ', 'CADSFZ'{'CADPRO'});
    pesServicos:               Result := fTamanhoCampo('SER_CODSER', 'CADSER');
    pesSituacaoOcorrencia:     Result := fTamanhoCampo('SIT_CODSIT','SITOCO');
    pesSituacaoProduto:        Result := fTamanhoCampo('SIT_CODIGO', 'SITPRO'{'CADSFZ'});
    pesSituacaoTributaria:     Result := fTamanhoCampo('TRI_CODTRI', 'CADTRI');
    pesSubRegiao:              Result := fTamanhoCampo('SUB_CODSUB', 'CADSUB');
    pesTabelaDinamica:         Result := fTamanhoCampo('PRE_CODTAB', 'ITETAB');
    pesTabelaPrecoFornecedor:  Result := fTamanhoCampo('TAB_CODTAB', 'TABPRE');
    pesTintas:                Result := 3;
    pesTipoAtendimento        :Result := fTamanhoCampo('TPA_CODIGO', 'CADTPA');
    pesTipoCliente     :      Result := fTamanhoCampo('TIP_CODTIP', 'TIPCLG');
    pesTipoImobilizado       :Result := fTamanhoCampo('TIP_CODTIP','TIPIMO');
    pesTipoOcorrencia        :Result := fTamanhoCampo('TOC_CODTOC', 'CADTOC');
    pesTipoPlanoContabil:      Result := fTamanhoCampo('ACO_CODIGO', 'TPLACO');
    pesTipoServico     :      Result := fTamanhoCampo('TPS_CODIGO', 'TIPSER');
    pesTransportadora  :      Result := fTamanhoCampo('TRA_CODTRA', 'CADTRA');
    pesUnidade:                Result := fTamanhoCampo('UNI_CODUNI', 'CADUNI');
    pesVeiculo:                Result := fTamanhoCampo('VEI_PLAVEI', 'CADVEI');
    pesAbvPIS:                 Result := fTamanhoCampo('APC_CODAPC', 'PISSAI');
    pesCSTPIS:                 Result := fTamanhoCampo('CST_CODCST', 'CSTPIS');
    pesCSTCBS:                 Result := fTamanhoCampo('CCLASSTRIB', 'CLASSTRIBPUBLICACAO');
    pesAbvCOF:                 Result := fTamanhoCampo('APC_CODAPC', 'COFSAI');
    pesCSTCOF:                 Result := fTamanhoCampo('CST_CODCST', 'CSTCOF');
    pesFinanceira:             Result := fTamanhoCampo('FIN_CODIGO', 'CADFIN');
    pesMotivoVerbas:           Result := fTamanhoCampo('VBA_CODMOT', 'MOTVBA');
    pesVerbas:                 Result := fTamanhoCampo('VER_CODVER', 'CADVER');
    pesOpeMobile:              Result := fTamanhoCampo('MOB_CODOPE', 'CADOPE_MOB');
    pesCondPagBosch:           Result := fTamanhoCampo('CND_CODCND', 'BOSCH_CADCND');
    pesFinalidadeAjuste:      Result := fTamanhoCampo('FAJ_CODIGO', 'FINAJU');

    Else                       Result := 0;
  End;
End;

Class Function TConsultasRel.fTamanhoCampo(strNomCam, strTabela: String): Integer;
  Var
    qryCampo: TUniQuery;
Begin
  qryCampo := fCriaQuery;
  With qryCampo, SQL Do
  Begin
    Add('SELECT ' + strNomCam);
    Add('FROM ' + strTabela);
    Add('WHERE FALSE');

    Open;

    Result := Fields[0].Size;
  End;
  FreeAndNil(qryCampo);
End;

Class Function TConsultasRel.fRetDescricaoRel(strCodigo, strNomPes: String): String;
Begin
  Result := TConsultasRel.fRetDescricaoCompleta(strCodigo, TConsultasRel.fNomePesquisaToTipo(strNomPes));
End;

Class function TConsultasRel.fRetTipoOperador(strFilPes: String): String;
var
  lstOpe: TStringList;
  idxOpe: Integer;
begin
  Result := '';

  try
    try
      lstOpe := TStringList.Create;
      lstOpe.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strFilPes, ';', #13#10), '<<csq>>', #13#10), '"', ''), '''', '');
      idxOpe := lstOpe.IndexOf('TIPOPE');
      Result := lstOpe[idxOpe + 1];
    except
      Result := '';
    end;
  finally
    If (Assigned(lstOpe)) Then
      FreeAndNil(lstOpe);
  end;

end;

Class function TConsultasRel.fRetNomeOperadorRel(strCodOpe, strFilPes: String): String;
var
  strTipOpe : String;
begin
  Result := '';
  strTipOpe := '';

  if (strFilPes.Contains('TIPOPE')) Then
  Begin
    strTipOpe := fRetTipoOperador(strFilPes);
  End;

  if (strTipOpe = '') Then
    Result := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [strCodOpe])
  Else
    Result := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE', 'OPE_INTEXT'], [strCodOpe, strTipOpe]);
end;

Class Function TConsultasRel.fArrSelToString(arrSel: TConsultasArray; blnQuoted: Boolean): String;
  Var
    intContador: Integer;
    stlInfos: TStringList;
Begin
  stlInfos := TStringList.Create;

  For intContador := Low(arrSel) To High(arrSel) Do
    If Not fEmptyStr(arrSel[intContador].strCodigo) Then
      stlInfos.Add(arrSel[intContador].strCodigo);

  Result := fCommaText(stlInfos, blnQuoted);

  FreeAndNil(stlInfos);
End;

Class Function TConsultasRel.fSQLLinhaGrupo(strNomCampo, strNomPar: String; arrLinha: TConsultasArray): String;
  Var
    intContador: Integer;
Begin
  Result := ' (';

  For intContador := Low(arrLinha) To High(arrLinha) Do
  Begin
    If RightStr(arrLinha[intContador].strCodigo, 3) = '000' Then
      Result := Result + ' (LEFT(' + strNomCampo + ', 3) = ' +  QuotedStr(LeftStr(arrLinha[intContador].strCodigo, 3)) + ') '
    Else
      Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrLinha[intContador].strCodigo) + ') ';

    If intContador <> High(arrLinha) Then
      Result := Result + ' OR ';
  End;

  Result := Result + ' ) ';
End;

Class Function TConsultasRel.fSQLPlanoContabilNovo(strNomCampo, strNomPar: String; arrPlanoContabilNovo: TConsultasArray): String;
  Var
    intContador,
    intMaskPlanco,
    intQtdMaskConfig,
    intTrechoMaskPlanco: Integer;
    stlPlanoContabilNovo: TStringList;
    blnPassouZeros: Boolean;
    strEspacos: string;
Begin
  Result := ' (';

  stlPlanoContabilNovo := Split(AnsiReplaceStr(fCfgSis('MSKCON'), '-', ''), '.');
  intQtdMaskConfig := Length(AnsiReplaceStr(AnsiReplaceStr(fCfgSis('MSKCON'), '.', ''), '-', ''));

  For intContador := Low(arrPlanoContabilNovo) To High(arrPlanoContabilNovo) Do
  Begin

    blnPassouZeros := False;

    for intMaskPlanco := 1 to stlPlanoContabilNovo.Count - 1 do
    begin
      strEspacos := '';
      for intTrechoMaskPlanco := stlPlanoContabilNovo.Count - 1 downto intMaskPlanco do
        strEspacos := strEspacos + fPadL('', Length(stlPlanoContabilNovo[intTrechoMaskPlanco]), ' ');
      If RightStr(fPadR(arrPlanoContabilNovo[intContador].strCodigo, intQtdMaskConfig, ' '), Length(strEspacos)) = strEspacos Then
      begin
        Result := Result + ' (LEFT(' + strNomCampo + ', ' + IntToStr(intQtdMaskConfig - Length(strEspacos)) + ') = ' +  QuotedStr(LeftStr(arrPlanoContabilNovo[intContador].strCodigo, (intQtdMaskConfig - Length(strEspacos)))) + ') ';
        blnPassouZeros := True;
        Break;
      end;
    end;

    if not blnPassouZeros then
      Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrPlanoContabilNovo[intContador].strCodigo) + ') ';

    If intContador <> High(arrPlanoContabilNovo) Then
        Result := Result + ' OR ';

  End;

  FreeAndNil(stlPlanoContabilNovo);

  Result := Result + ' ) ';
End;

Class Function TConsultasRel.fSQLPlanoContas(strNomCampo, strNomPar: String; arrPlano: TConsultasArray): String;
  Var
    intContador: Integer;
Begin
  Result := ' (';

  For intContador := Low(arrPlano) To High(arrPlano) Do
  Begin
    If RightStr(arrPlano[intContador].strCodigo, 5) = '00000' Then
      Result := Result + ' (LEFT(' + strNomCampo + ', 2) = ' +  QuotedStr(LeftStr(arrPlano[intContador].strCodigo, 2)) + ') '
    Else If RightStr(arrPlano[intContador].strCodigo, 3) = '000' Then
      Result := Result + ' (LEFT(' + strNomCampo + ', 4) = ' +  QuotedStr(LeftStr(arrPlano[intContador].strCodigo, 4)) + ') '
    Else
      Result := Result + ' (' + strNomCampo + ' = ' + QuotedStr(arrPlano[intContador].strCodigo) + ') ';

    If intContador <> High(arrPlano) Then
      Result := Result + ' OR ';
  End;

  Result := Result + ' ) ';
End;

Class Procedure TConsultasRel.pValParToArrSel(strValPar: String; Var arrSel: TConsultasArray);
  Var
    stlLista: TStringList;
    intContador: Integer;
Begin
  Delete(strValPar, 1, Length(' IN ('));
  strValPar := LeftStr(strValPar, Length(strValPar) -1);

  stlLista := TStringList.Create;
  stlLista.CommaText := strValPar;

  SetLength(arrSel, stlLista.Count);
  For intContador := Low(arrSel) To High(arrSel) Do
    arrSel[intContador].strCodigo := copy(stlLista[intContador], 2, Length(stlLista[intContador]) - 2);

  stlLista.Clear;
  FreeAndNil(stlLista);
End;

function TConsultasRel.fPesqisaTabela(strNomPesq: String; var strValPar,
  strDesEdt: String; frmForm: TForm; var chrKey: Char; blnSimples: Boolean; APesquisa: TPesquisas = pesSemPesquisa): Boolean;
  Var
    arrSel : TConsultasArray;
begin
  Result := fPesqisaTabela(strNomPesq, strValPar, strDesEdt, frmForm, chrKey, blnSimples, arrSel, APesquisa);
end;

Function TConsultasRel.fPesqisaTabela(strNomPesq: String; Var strValPar, strDesEdt: String;
                                      frmForm: TForm; Var chrKey: Char; blnSimples: Boolean;
                                      var arrSel: TConsultasArray; APesquisa: TPesquisas = pesSemPesquisa): Boolean;
  Var
    pesPesquisa: TPesquisas;
    qryConsulta: TUniQuery;
    recNotEle: TRecInfoNotaEletronica;
    strDoc, strDtaIni, strDtaFim: string;
    blnGerentes: Boolean;
    blnMecanicos: Boolean;
    blnVenRepre: Boolean;
    blnCompradores: Boolean;
    blnAdministrativo: Boolean;
    blnSubGerentes: Boolean;
    blnVendedorEmpLog: Boolean;
    staState: TStateOPI;
    tpcPsqOPI: TPesquisaOPI;
    blnImpLis: Boolean;
    blnAberto: Boolean;
Begin
  qryConsulta := Nil;

  If APesquisa <> pesSemPesquisa Then
    pesPesquisa :=  APesquisa
  Else
    pesPesquisa := fNomePesquisaToTipo(strNomPesq);

  strDtaIni := '';
  strDtaFim := '';

  staState  := staTodas;
  tpcPsqOPI := poiLote;

  blnGerentes       := False;
  blnMecanicos      := False;
  blnVenRepre       := False;
  blnCompradores    := False;
  blnAdministrativo := False;
  blnSubGerentes    := False;
  blnVendedorEmpLog := False;

  blnImpLis := True;

  blnAberto := True;

  if fRetValorParametro('DTAINI') <> '' then
    strDtaIni := FormatDateTime('yyyy-MM-dd', StrToDate(fRetValorParametro('DTAINI')));

  if fRetValorParametro('DTAFIN') <> '' then
    strDtaFim := FormatDateTime('yyyy-MM-dd', StrToDate(fRetValorParametro('DTAFIN')));

  if fRetValorParametro('IMPLIS') <> '' then
    blnImpLis := fRetValorParametro('IMPLIS') = 'S';

  if fRetValorParametro('ABERTO') <> '' then
    blnAberto := fRetValorParametro('ABERTO') = 'S';

  if fRetValorParametro('SITORD') <> '' then
  begin
    if fRetValorParametro('SITORD') = 'A' then
      staState := staAbertas
    else if fRetValorParametro('SITORD') = 'B' then
      staState := staBaixadas
    else
      staState := staTodas;
  end;

  if fRetValorParametro('TIPOPE') <> '' then
    case AnsiIndexStr(fRetValorParametro('TIPOPE'), ['G','M','V','C','A','S','E']) of
      0 : blnGerentes       := True;
      1 : blnMecanicos      := True;
      2 : blnVenRepre       := True;
      3 : blnCompradores    := True;
      4 : blnAdministrativo := True;
      5 : blnSubGerentes    := True;
      6 : blnVendedorEmpLog := True;
    end;

  Case pesPesquisa  Of
    pesAbreviacaoFiscal      : Result := fPesqAbrevFiscal(frmForm, Nil, Nil, nil, chrKey, arrSel, blnSimples);
    pesECFFiscal             : Result := fPesqECF(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesAjudante              : Result := fPesqAjudantes(frmForm, Nil, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesAjusteEstoque         : Result := fPesqAjuste(frmForm, Nil, Nil, chrKey, arrSel, fRetValorParametro('CODEMP'), blnSimples, 'Consulta de Ajustes de Estoque', True);
    pesArmazem               : Result := fPesqArmazem(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesAtividade             : Result := fPesqAtividade(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTpAtendimento         : Result := fPesqTipoAtendimento(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesAtendimento0800       : Result := fPesqCadAte0800(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, True);
    pesBanco                 : Result := fPesqBanco(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesBandeiraCartao        : Result := fPesqCartaoBandeira(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCaixa                 : Result := fPesqCaixas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCampanha              : Result := fPesqCampanha(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples,'',True);
    pesCanalAcesso           : Result := fPesqCanalAcesso(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCartao                : Result := fPesqCartao(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, False, False, True, True);
    pesCategoriaPedOrc       : Result := fPesqCategoriaOrPd(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCest                  : Result := fPesqCest(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCidade                : Result := fPesqCidade(frmForm, Nil, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesClassificacaoIPI      : Result := fPesqClaIPI(frmForm, Nil, Nil, chRkey, arrSel, False);
    pesCliente               : Result := fPesqCliente(conCliSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesClienteFilial         : Result := fPesqCliente(conCliSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, Nil, False,'','TE');
    pesCodigoCnae            : Result := fPesqCNAE(conSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, 'Consulta Tabela CNAE', False);
    pesCodigoReceita         : Result := fPesqGuiaReceitaFederal(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGuiaReceita           : Result := fPesqGuiaReceita(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCodigoSimilar         : Result := fPesqCodSimilar(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesComboProdutoVenda     : Result := fPesqComboVenda(frmForm, Nil,Nil,Nil, chrKey, arrSel, True, True);
    pesClassificacaoFiscal   : Result := fPesqCFOP(frmForm, Nil,Nil,Nil,chrKey, arrSel, blnSimples);
    pesConfiguracao          : Result := fPesqCfgSis(frmForm, Nil, Nil, Nil, chrKey, arrSel, True);
    pesConfiguracaoTinta     : Result := fPesqCfgTin(frmForm, Nil, Nil, Nil, chrKey, arrSel, True);
    pesCompleOcorrencia      : Result := fPesqComplementosOcorrencias(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCondicaoPagamento     : Result := fPesqCondicoesPgto(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesComposicao            : Result := fPesqComposicao(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesConsumidores          : Result := fPesqConsumidores(frmForm, nil, nil, nil, nil, nil, chrKey, arrSel, '', blnSimples, True);
    pesContratoLogEquip      : Result := fPesqContratoLocEquip(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCor                   : Result := fPesqCores(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCorVeiculo            : Result := fPesqCorVeiculo(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesContasdeResultado     : Result := fPesqCtaResultado(frmForm, Nil,nil, Nil, chrKey, arrSel, False, True);
    pesContatoCliente        : Result := fPesqCliCtt(frmform, Nil, Nil, chrKey, arrSel, fRetValorParametro('CODCLI'), blnSimples);
    pesCorSimples            : Result := fPesqCores(frmForm, Nil, Nil, Nil, chrKey, arrSel, True);
    pesDefeito               : Result := fPesqDefeito(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesDiversos              : Result := fPesqDiversos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesDocSaidaComRegFat     : Result := fPesqDocumentosSaida(frmForm, Nil, Nil, chrKey, arrSel, Nil, blnSimples, True, strDtaIni, strDtaFim, fRetValorParametro('ESPDOC'));
    pesDocSaidaSemRegFat     : Result := fPesqDocumentosSaida(frmForm, Nil, Nil, chrKey, arrSel, Nil, blnSimples, False, strDtaIni, strDtaFim, fRetValorParametro('ESPDOC'));
    pesDepartamento          : Result := fPesqDepartamento(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesEmbarcacao            : Result := fPesqCadastroEmbarcacoes(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, '');
    pesEmailsEnviados        : Result := fPesqEmailEnviado(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, strDtaIni, strDtaFim);
    pesEmpresa               : Result := fPesqEmpresa(conEmpSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, True  {* Restringir empresas que usuário tem acesso  *});
    pesEmpresaSimples        : Result := fPesqEmpresa(conEmpSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, True, True  {* Restringir empresas que usuário tem acesso  *});
    pesEmpresaCompleto       : Result := fPesqEmpresa(conEmpCompleta, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, True, '', False, '', '', tmvIndefinido, False, False, True);

    pesEndCliente            : Result := fPesqEntregaCliente(frmform, Nil, Nil, Nil, chrKey, arrSel,blnSimples, fRetValorParametro('CODCLI'));

    pesEquipamento           : Result := fPesqEquipamento(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesEquipLocacao          : Result := fPesqCadastroEquipLocacao(frmForm, Nil, Nil, Nil, chrKey, arrSel, False, '', 0, 0, Nil);
    pesEfetivacaoPreco       : Result := fPesqEfetivacaoDePreco(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesEstado                : Result := fPesqEstado(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesEstoqueExternoEmpresas: Result := fPesqEmpresaEstoqueExterno(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesEvento                : Result := fPesqEventos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFaseObra              : Result := fPesqFaseObra(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFaixaFatEstimado      : Result := fPesqFaixaFaturamentoCRM(frmform, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFornecedor            : Result := fPesqFornecedor(conForSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFormaDePagamento      : Result := fPesqFormaPgto(conFpgSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFuncionario           : Result := fPesqFuncionarios(frmForm, Nil, Nil, Nil, chrKey, arrsel, blnSimples, Nil, '', True );
    pesFuncionarioAutoincrem : Result := fPesqFuncionarios(frmForm, Nil, Nil, Nil, chrKey, arrsel, blnSimples, Nil, '', False );
    pesFuncoesFuncionario    : Result := fPesqFuncoes(frmForm, Nil, Nil, Nil, chrKey, arrsel, blnSimples);
    pesGrupoAtividade        : Result := fPesqGrupoAtividade(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoCompra           : Result := fPesqGrupoCompra(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoConfiguracao     : Result := fPesqGruCfg(frmForm, nil, nil, chrKey, arrSel, blnSimples);
    pesGrupoEcoFornecedores  : Result := fPesqGrupoEcoFornec(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoOcorrencia       : Result := fPesqGruposOcorrencias(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoOperador         : Result := fPesqGrupoOperador(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoProduto          : Result := fPesqGrupoProduto(frmForm, Nil, Nil, Nil, chrkey, arrSel, blnSimples);
    pesGrupoDePrecos         : Result := fPesqGrupoPrecos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesGrupoEcoFornec        : Result := fPesqGrupoEcoFornec(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesItemEstrutura         : Result := fPesqEstrutura(frmForm, Nil, Nil, chrkey, arrSel, False, 'Consulta de Estruturas', True);
    pesAtivoImobDocAquisicao : Result := fPesqAtivoImobDocumentos(frmForm, Nil, Nil, Nil, chrKey, arrSel, False, fRetValorParametro('DTABAS'), fRetValorParametro('CODEMP'), fRetValorParametro('CLAIMO'), fRetValorParametro('VENDID'));
    pesLayoutCupomPromocao   : Result := fPesqLayout(frmForm, Nil, Nil, Nil,'J',chrKey, arrSel, False, IntToStr(ARR_TIPO_LAYOUT[tpeCupomPromocao]), tplDocumentos, False);
    pesLinhaGrupo            : Result := fPesqGrupo(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesLinhaGrupoSimples     : Result := fPesqGrupo(frmForm, Nil, Nil, Nil, chrKey, arrSel, True);
    pesLocalArmazenamentoWMS : Result := fPesqLocalArmazenamentoWms(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);

    pesLocalizacaoFisica     : If FCadLoc Then
                                 Result := fPesqLocFisica(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples)
                               Else
                                 Result := False;

    pesLocalizacaoLote       : Result := fPesqLotLoc(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, fRetValorParametro('CODITE'), fRetValorParametro('NUMLOT'));
    pesLocalizacaoDeSeparacao: Result := fPesqLocSep(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);

    pesLote                  : Result := fPesqLoteItens(frmForm, Nil, Nil, FDecUni, Nil, chrKey, arrSel, blnSimples,
                                                        fRetValorParametro('CODITE'),
                                                        fRetValorParametro('CODEMP'),
                                                        False, //  blnSoAtivos: Boolean = False;
                                                        True); //  blnRetNumLot: Boolean = False;
    pesLoteSeparacao         : Result := fPesqRomaneioLoteSeparacao(frmForm, Nil, Nil, chrKey, arrSel, blnSimples);
    pesManifestoEncerrado    : Result := fPesqManifestosEncerrados(frmForm, Nil, Nil, chrKey, arrSel, blnSimples);

    pesMarca                 : Result := fPesqMarcas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesMarcaSimples          : Result := fPesqMarcas(frmForm, Nil, Nil, Nil, chrKey, arrSel, True);
    pesMarcaVeiculo          : Result := fPesqMarcaVeiculo(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesMaterialConsumo       : Result := fPesqMaterialConsumo(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, fRetValorParametro('CODFOR'));
    pesMotivosAtend          : Result := fPesqMotivosAtend(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesMotorista             : Result := fPesqMotorista(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesModeloVeiculo         : Result := fPesqModeloVeiculo(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesNatReceitaPisCof      : Result := fPesqNatReceitaPisCof(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesMotVendasPerdidas     : Result := fPesqMotVendasPerdidas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesNumPedVen             : Result := fPesqPedOrc(conPedCompleta, frmForm, 'PD', 'PD', VS_strCodEmp, Nil, Nil, Nil, qryConsulta, chrKey, arrSel, blnSimples, Nil, '', 'N', '', False, True, strDtaIni, strDtaFim);
    pesNumOrcVen             : Result := fPesqPedOrc(conPedCompleta, frmForm, 'OR', 'OR', VS_strCodEmp, Nil, Nil, Nil, qryConsulta, chrKey, arrSel, blnSimples, Nil, '', 'N', '', False, True, strDtaIni, strDtaFim);
    pesOcorrencia            : Result := fPesqOcorrencia(frmForm, Nil, Nil, Nil, chrKey , arrSel, blnSimples);
    pesOperador              : Result := fPesqOperador(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, False, blnGerentes, blnMecanicos, blnVenRepre, blnCompradores, blnAdministrativo, blnSubGerentes, blnVendedorEmpLog);
    pesParceiro              : Result := fPesqParceiro(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPedCompra             : Result := fPesqPedidoCompra(frmForm, Nil, qryConsulta, chrKey, arrSel, strDoc, IIF(Length(fRetValorParametro('CODEMP')) = 3, fRetValorParametro('CODEMP'), ''), 0, blnSimples, Nil, '3.600', 'Consulta de Pedidos de Compra', False, True, strDtaIni, strDtaFim, blnAberto);
    pesOrcCompra             : Result := fPesqPedidoCompra(frmForm, Nil, qryConsulta, chrKey, arrSel, strDoc, IIF(Length(fRetValorParametro('CODEMP')) = 3, fRetValorParametro('CODEMP'), ''), 1, blnSimples, Nil, '3.600', 'Consulta de Orçamentos de Compra', False, True, strDtaIni, strDtaFim);
    pesOrdProIndustrial      : Result := fPesqOrdProIndustrial(frmForm, Nil, Nil, Nil, chrKey, arrSel, tpcPsqOPI, blnSimples, staState, '', '', '', '', '', True);
    pesPesquisap             : Result := fPesqPesquisa(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPlanoContabil         : Result := fPesqPlanoContabil(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, '', True, True);
    pesPlanoContabilNovo     : Result := fPesqPlanoContabil(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, '', True, True);
    pesPlanoContas           : Result := fPesqCentroCusto(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPortador              : Result := fPesqPortador(conSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, 'Consulta de Portadores', '', False, False, '', True);
    pesPreNotEnt             : Result := fPesqGereleDigPedido(frmForm, Nil, qryConsulta, recNotEle, chrKey, arrSel, blnSimples, xmlEntradaMercadoria, True);
    pesProduto               : Result := fPesqItem(conIteSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, nil, 'Consulta de Itens', IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD')), '', 0, False, False, 3,
                                                   cdrCodIte, '', False, '', '', True, False, True, '', False, False, False, False, False, False, False, False, '', -1,
                                                   False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', False, False, blnImpLis);
    pesProdutoSimples        : Result := fPesqItem(conIteSimples, frmForm, Nil, Nil, Nil, chrKey, arrSel, True, nil, 'Consulta de Itens', '1', '', 0, False, False, 3,
                                                   cdrCodIte, '', False, '', '', True, False, True, '', False, False, False, False, False, False, False, False, '', -1,
                                                   False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', False, False, blnImpLis);
    pesProdutoAcabado        : Result := fPesqProdAcabado(frmform, Nil, Nil, Nil, chrKey, ArrSel,'', '', blnSimples,'Consulta de Produtos Acabados');
    pesProjeto               : Result := fPesqProjetos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPromocao              : Result := fPesqPromocoes(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPromocaoBrinde        : Result := fPesqPromocoesBrindes(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesPromocaoCupom         : Result := fPesqPromoCupom(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, 'C');
    pesProspecto             : Result := fPesqProspecto(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, False, True);
    pesRecursoProjeto        : Result := fPesqRecursoProjeto(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesRedeLojas             : Result := fPesqRedeLojas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesRegiao                : Result := fPesqRegiao(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesRomaneio              : Result := fPesqRomaneio(frmForm, Nil, Nil, chrKey, arrSel, '', blnSimples, True, 'Consulta de Romaneios', True);
    pesQualificacao          : Result := fPesqQualificacao(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesSeqRota               : Result := fPesqEntregasRotasRegiao(frmForm, Nil,Nil,Nil, chrKey,arrSel,blnSimples,'','',False);
    pesSetorFilizola         : Result := fPesqSetFlz(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesServicos              : Result := fPesqServicos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesSituacaoOcorrencia    : Result := fPesqSitOcorrencias(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesSituacaoProduto       : Result := fPesqSituacaoProduto(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesSituacaoTributaria    : Result := fPesqSitTributaria(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesSubRegiao             : Result := fPesqSubRegiao(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTabelaDinamica        : Result := fPesqTabDinamica(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTabelaPrecoFornecedor : Result := fPesqTabelaPreco(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTipoAtendimento       : Result := fPesqTipoAtendimento(frmForm, Nil, Nil, Nil, chrKey, arrSel);
    pesTipoCliente           : Result := fPesqTipoCliente(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTipoImobilizado       : Result := fPesqTipoImobilizado(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTipoOcorrencia        : Result := fPesqTiposOcorrencias(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTipoPlanoContabil     : Result := fPesqTipoPlanoContabil(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesTipoServico           : Result := fPesqTipoServico(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);

    pesTintas:                Begin
                                chrKey := #0;

                                strValPar := fEscolheTintaNovo('');

                                Result := Not fEmptyStr(strValPar);

                                If Result Then
                                  strDesEdt := fRetDescricaoCompleta(strValPar, pesTintas);

                                Exit;
                              End;

    pesTransportadora  :      Result := fPesqTransportadora(conTraSimples,frmForm, Nil, Nil ,Nil, chrKey, arrSel, blnSimples);
    pesUnidade         :      Result := fPesqUnidade(frmForm, Nil, Nil, Nil, Nil, chrkey, arrSel, blnSimples);
    pesVeiculo         :      Result := fPesqVeiculos(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples, True, ' VEI_STATUS = "A" ');
    pesFinalidadeAjuste:      Result := fPesqFinalidadeAjuste(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);

    pesAbvPIS         :      Result := fPesqPisSai(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCSTPIS         :      Result := fPesqCstPis(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCSTCBS         :      Result := fPesqCstCBS(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesAbvCOF         :      Result := fPesqCofSai(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCSTCOF         :      Result := fPesqCstCof(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesFinanceira     :      Result := fPesqFinanceira(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesMotivoVerbas   :      Result := fPesqMotivoVerbas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesVerbas         :      Result := fPesqVerbas(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesOpeMobile      :      Result := fPesqOpeMobile(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);
    pesCondPagBosch   :      Result := fPesqCondPagBosch2(frmForm, Nil, Nil, Nil, chrKey, arrSel, blnSimples);

    Else Result := False;
  End;

  If Result Then
  Begin
    chrKey := #0;

    pMontaValPar(strValPar, arrSel);

    strDesEdt := fRetDescricaoEdit(arrSel, pesPesquisa);

  End;
End;

Class Procedure TConsultasRel.pMontaValPar(Var strValPar: String; arrSel: TConsultasArray; blnSempreIn: Boolean = False);
Begin
  If (Length(arrSel) > 1) Or blnSempreIn Then
    strValPar := ' IN (' + fArrSelToString(arrSel, True) + ')'

  Else If Length(arrSel) > 0 Then
    strValPar := arrSel[0].strCodigo;
End;

end.
