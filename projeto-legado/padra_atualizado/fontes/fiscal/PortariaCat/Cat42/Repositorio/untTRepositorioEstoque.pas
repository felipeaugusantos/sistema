unit untTRepositorioEstoque;

interface

uses System.Generics.Defaults, System.Generics.Collections, Uni, SysUtils, StrUtils, untFuncoes,
     untTProduto, untTMateriaPrima, {untTItemProduzido, untTItemConsumidoProducao,}
     untFuncoesSimples, {untTConfiguracoes, untTLocalArquivo,} untTypesSistema, untFuncoesConsulta,
     untTDadosAbertura, Classes;{, untTRegistroInventarioSpedFiscal;}

type
  TRepositorioEstoque = class
  private
    FListaProdutosEstoqueSemFiltro: TObjectList<TProduto>; //Relatório de conferência da adjudicação
    FListaProdutosEstoque: TObjectList<TProduto>; //h010 adjudicação do Rio Grande do Sul
    FTabelaInventario: string;
    FAbertura: TDadosAbertura;
    FCadAbfGeral: string;
    FCALCULAR_ST_ADJUDICACAO: string;
    FALTERACAO_TRIBUTARIA: string;
    FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11: string;
    FPRECO_INV_CAT42: string;
    FPRECO_REGH010_CAMPO06: string;
    FPRECO_REGH010_CAMPO11: string;
    FEMPRESAS_SELECIONADAS_REGH010_REGK200: string;

    function fInventarioPeloCusto(strAlias : String = ''; strAliasImpFed : String = ''): string;
    function fRetBaseStEstoqueAdjudicacao(qryAux: TUniQuery; var blnStCalculado: boolean): double;
    function fRetPrecoDeduzidoImposto: string;

    //Adjudicação do Sul
    function fRetSqlEstoqueAdjudicacaoPorAbreviacao(arrLinhaGrupoExcluir: TConsultasArray; strAbrevSel: string): string;
    function fRetSqlEstoqueAdjudicacaoSemFiltro(arrLinhaGrupoExcluir: TConsultasArray): string;
    function fRetSqlEstoqueAdjudicacao(arrLinhaGrupoExcluir: TConsultasArray): string;

    //BlocoK
    function fRetSqlEstoquePorTabela(arrLinhaGrupoExcluir: TConsultasArray): string;
    function fRetPrecoCalcular(intIndicePreco: integer): string;

    procedure pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem: integer; strMensagem: string; produto: TProduto);
    procedure pCarregaAbfIcmGeralEmpresa; //carrega a variavel "FCadAbfGeral" com "S" CADITE e "N" ITEGER
    procedure pOrdenaListaItem;

    procedure pCarregaVariaveisConfiguracoes;

  public

    //função utilizada para validação dos produtos inventariados que não estão na regra
    function fRetProdutoEstoqueAdjudicacaoPorAbreviacao(strCodEmp, strLinGruExcluir, strAbrevSel: string; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
    function fRetProdutoEstoqueAdjudicacaoSemFiltro(strCodEmp, strLinGruExcluir: string; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
    function fRetProdutoEstoqueAdjudicacao(strCodEmp, strLinGruExcluir: string; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;

    function fRetProdutoEstoqueMT(strCodEmp, strNcm, strMotivo, strMargem: String): TObjectList<TProduto>;
    function fRetSqlEstoqueMT(strNcm, strMotivo, strMargem: String): String;

    //Cria tabela gravar movimentação inventario
    procedure pCriaTabelaMovimentacaoInventario;
    procedure pTabelaMovimentacaoAdjudicacao;
    procedure pTabelaParcelaAdjudicacao;

    function fRetProdutosEstoquePorTabela(strCodEmp, strLinGruExcluir: string; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
    function fRetValorTotalStInventario(produtos: TObjectList<TProduto>): double;
    function fRetValorTotalInventario(produtos: TObjectList<TProduto>): double;

    constructor Create(abertura: TDadosAbertura);
    destructor Destroy; override;

    property strTabelaInventario: string read FTabelaInventario write FTabelaInventario;
  end;

implementation

{ TRepositorioEstoque }

constructor TRepositorioEstoque.Create(abertura: TDadosAbertura);
begin
  inherited create;

  FListaProdutosEstoqueSemFiltro := TObjectList<TProduto>.Create;
  FListaProdutosEstoque := TObjectList<TProduto>.Create;
  FAbertura := abertura;

  pCarregaAbfIcmGeralEmpresa;
  pCarregaVariaveisConfiguracoes;
end;

destructor TRepositorioEstoque.Destroy;
begin
  FListaProdutosEstoqueSemFiltro.Free;
  FListaProdutosEstoque.Free;

  inherited;
end;

function TRepositorioEstoque.fInventarioPeloCusto(strAlias,
  strAliasImpFed: String): string;
begin
  Result := fPreInv(strAlias, strAliasImpFed, fCfgSis('PREINV'));
end;

function TRepositorioEstoque.fRetBaseStEstoqueAdjudicacao(qryAux: TUniQuery; var blnStCalculado: boolean): double;
begin
  Result := 0;

  blnStCalculado := False;

  with qryAux do
  begin
    if fEmptyStr(FieldByName('NOTULT').AsString) then
    begin
      Result := FieldByName('PRELIQ').AsFloat * FieldByName('IVA_ST').AsFloat;
      blnStCalculado := True;
    end
    else
    begin
      if (FieldByName('RETIDO').AsFloat > 0) and (Pos(FieldByName('CLAFIS').AsString, '1401_2401_1403_2403') > 0) then
      begin
        Result := FieldByName('RETIDO').AsFloat;
        blnStCalculado := False;
      end
      else
      begin
        //se for transferencia calcula
        if Pos(FieldByName('CLAFIS').AsString, '1409_2409') > 0 then
        begin
          Result := FieldByName('PRELIQ').AsFloat * FieldByName('IVA_ST').AsFloat;
          blnStCalculado := True;
        end
        //se for cfop 1401 ou 1403 e estiver marcado para calcular, calcula
        else if (Pos(FieldByName('CLAFIS').AsString, '1401_1403') > 0) and
                (FCALCULAR_ST_ADJUDICACAO = '1') then //Config 12 -SPED/Sub Apuração de ICMS
        begin
          Result := FieldByName('PRELIQ').AsFloat * FieldByName('IVA_ST').AsFloat;
          blnStCalculado := True;
        end;
      end;
    end;
  end;
end;

function TRepositorioEstoque.fRetPrecoCalcular(intIndicePreco: integer): string;
begin
  case intIndicePreco of
    0: Result := 'ITE_PRECUS';
    1: Result := 'ITE_PREMED';
  end;
end;

function TRepositorioEstoque.fRetPrecoDeduzidoImposto: string;
  var
    strQtdDec, strPrecoRateadoFornecedorIcmIpi: string;
begin
  Result := '';

  strQtdDec := fCfgSis('DECQTD', varString);

  strPrecoRateadoFornecedorIcmIpi := 'INV.ITE_PRECOM - IF(INV.ITE_DESF01 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF01) / 100), 0) ' +
                                                   ' - IF(INV.ITE_DESF02 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF02) / 100), 0) ' +
                                                   ' - IF(INV.ITE_DESF03 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF03) / 100), 0) ' +
                                                   ' - IF(INV.ITE_DESF04 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF04) / 100), 0) ' +
                                                   ' - IF(INV.ITE_DESF05 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF05) / 100), 0) ' +
                                                   ' - IF(INV.ITE_DESF06 > 0, ((INV.ITE_PRECOM * INV.ITE_DESF06) / 100), 0) ' +
                                                   ' - IF(INV.ITE_ICMENT > 0, ((INV.ITE_PRECOM * INV.ITE_ICMENT) / 100), 0) ' +
                                                   ' - IF(INV.ITE_IPIENT > 0, ((INV.ITE_PRECOM * INV.ITE_IPIENT) / 100), 0) ';

  Result := 'IF(INV.ITE_SUBSTI > 0, ROUND(' + strPrecoRateadoFornecedorIcmIpi + ' - IF(INV.ITE_SUBFED > 0, ((INV.ITE_PRECOM * INV.ITE_SUBFED) / 100), 0), ' + strQtdDec + '), ' +
                                  ' ROUND(' + strPrecoRateadoFornecedorIcmIpi + ' - IF(INV.ITE_SUBFED > 0, ((' + strPrecoRateadoFornecedorIcmIpi + ' * INV.ITE_SUBFED) / 100), 0), ' + strQtdDec + '))';
end;

function TRepositorioEstoque.fRetProdutoEstoqueAdjudicacao(strCodEmp,
  strLinGruExcluir: string; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
  var
    blnStCalculado: boolean;
    qryAux: TUniQuery;
    produto: TProduto;
    fltBaseST: double;
begin
  pCriaTabelaMovimentacaoInventario;

  Result := FListaProdutosEstoque;

  FListaProdutosEstoque.Clear;

  if fTabelaExiste(FTabelaInventario) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlEstoqueAdjudicacao(arrLinhaGrupoExcluir));
        ParamByName('CODEMP').AsString := strCodEmp;

        if Length(arrLinhaGrupoExcluir) > 0 then
          pSetaParam(arrLinhaGrupoExcluir[0].strCodigo, arrLinhaGrupoExcluir, strLinGruExcluir, 'CODGRU', qryAux);

        Open;

        First;
        while not Eof do
        begin
          fltBaseST := fRetBaseStEstoqueAdjudicacao(qryAux, blnStCalculado);

          if fltBaseST > 0 then
          begin
            produto := TProduto.Create;
            produto.strCodItem := FieldByName('CODITE').AsString;
            produto.strDescricaoItem := FieldByName('DESITE').AsString;
            produto.unidade.strSigla := FieldByName('BX_SIGUNI').AsString;
            produto.unidade.strCodigo := FieldByName('BX_CODUNI').AsString;

            produto.strDocumentoCompraAssociado := FieldByName('DOCUMENTO').AsString;
            produto.blnStCalculado := blnStCalculado;

            produto.strCodigoSituacaoTributaria := FieldByName('CODSIT').AsString;
            produto.fltQuantidade := FieldByName('QTDITE').AsFloat;
            produto.fltBaseICMS_ST := fltBaseST;
            produto.fltValorICMS_ST := ((fltBaseST)* 18) / 100;

            produto.strCfop := FieldByName('CLAFIS').AsString;

            produto.fltPrecoCompra := FieldByName('PRELIQ').AsFloat; //PRECO COMPRA FIXO
            produto.fltPreco := FieldByName('INV_PRECUS').AsFloat; //PRECO CONFIGURADO
            produto.fltIVA := FieldByName('IVA_ST').AsFloat;
            produto.fltSaldo := FieldByName('INV_SALDOS').AsFloat;
            produto.fltValor := FieldByName('INV_VALITE').AsFloat; //INV_SALDOS * INV_PRECUS(PRECO CONFIGURADO)
            Result.Add(produto);
          end;

          Next;
        end;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function TRepositorioEstoque.fRetProdutoEstoqueAdjudicacaoPorAbreviacao(strCodEmp, strLinGruExcluir, strAbrevSel: string;
  arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
  var
    qryAux: TUniQuery;
    produto: TProduto;
begin
  pCriaTabelaMovimentacaoInventario;

  Result := FListaProdutosEstoque;

  FListaProdutosEstoque.Clear;

  if fTabelaExiste(FTabelaInventario) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlEstoqueAdjudicacaoPorAbreviacao(arrLinhaGrupoExcluir, strAbrevSel));
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('ESTADO').AsString := 'RS';

        if Length(arrLinhaGrupoExcluir) > 0 then
          pSetaParam(arrLinhaGrupoExcluir[0].strCodigo, arrLinhaGrupoExcluir, strLinGruExcluir, 'CODGRU', qryAux);

        Open;

        First;
        while not Eof do
        begin
          if FieldByName('INV_VALITE').AsFloat > 0 then
          begin
            produto := TProduto.Create;
            produto.strCodItem := FieldByName('INV_CODITE').AsString;
            produto.strDescricaoItem := FieldByName('INV_DESITE').AsString;
            produto.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;
            produto.unidade.strCodigo := FieldByName('UNI_CODUNI').AsString;

            produto.strCodigoSituacaoTributaria := FieldByName('CODSIT').AsString;
            produto.fltBaseICMS_ST := FieldByName('BASE_ST').AsFloat;
            produto.fltValorICMS_ST := FieldByName('VLR_ST').AsFloat;

            produto.fltPrecoCompra := FieldByName('INV_PRECUS').AsFloat; //PRECO CONFIGURADO
            produto.fltPreco := FieldByName('INV_PRECUS').AsFloat; //PRECO CONFIGURADO
            produto.fltIVA := FieldByName('INV_IVA').AsFloat;
            produto.fltSaldo := FieldByName('INV_ITE_SALDOS').AsFloat;
            produto.fltValor := FieldByName('INV_VALITE').AsFloat; //INV_SALDOS * INV_PRECUS(PRECO CONFIGURADO)
            Result.Add(produto);
          end;

          Next;
        end;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function TRepositorioEstoque.fRetProdutoEstoqueAdjudicacaoSemFiltro(strCodEmp, strLinGruExcluir: string;
  arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
  var
    intTipoMensagem: integer;
    blnStCalculado: boolean;
    strMensagem: string;
    qryAux: TUniQuery;
    produto: TProduto;
    fltBaseST: double;
begin
  pCriaTabelaMovimentacaoInventario;

  Result := FListaProdutosEstoque;

  FListaProdutosEstoque.Clear;

  if fTabelaExiste(FTabelaInventario) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlEstoqueAdjudicacaoSemFiltro(arrLinhaGrupoExcluir));
        ParamByName('CODEMP').AsString := strCodEmp;

        if Length(arrLinhaGrupoExcluir) > 0 then
          pSetaParam(arrLinhaGrupoExcluir[0].strCodigo, arrLinhaGrupoExcluir, strLinGruExcluir, 'CODGRU', qryAux);

        Open;

        First;
        while not Eof do
        begin
          fltBaseST := fRetBaseStEstoqueAdjudicacao(qryAux, blnStCalculado);

          produto := TProduto.Create;
          produto.strCodItem := FieldByName('CODITE').AsString;
          produto.strDescricaoItem := FieldByName('DESITE').AsString;
          produto.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;
          produto.unidade.strCodigo := FieldByName('UNI_CODUNI').AsString;

          produto.strDocumentoCompraAssociado := FieldByName('DOCUMENTO').AsString;
          produto.blnStCalculado := blnStCalculado;

          produto.strCodigoSituacaoTributaria := FieldByName('CODSIT').AsString;
          produto.fltQuantidade := FieldByName('QTDITE').AsFloat;
          produto.fltBaseICMS_ST := fltBaseST;
          produto.fltValorICMS_ST := ((fltBaseST) * 18) / 100;

          produto.strCfop := FieldByName('CLAFIS').AsString;

          produto.fltPrecoCompra := FieldByName('PRELIQ').AsFloat; //PRECO COMPRA FIXO
          produto.fltPreco := FieldByName('INV_PRECUS').AsFloat; //PRECO CONFIGURADO
          produto.fltIVA := FieldByName('IVA_ST').AsFloat;
          produto.fltSaldo := FieldByName('INV_SALDOS').AsFloat;
          produto.fltValor := FieldByName('INV_VALITE').AsFloat; //INV_SALDOS * INV_PRECUS(PRECO CONFIGURADO)

          if fltBaseST <= 0 then
          begin
            intTipoMensagem := 1;
            strMensagem := 'PRODUTOS SEM CALCÚLO DA ST. VERIFICAR A NOTA DE COMPRA ASSOCIADA, PREÇO DE COMPRA DO INVENTÁRIO OU IVA';
            pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem, strMensagem, produto);
          end;

          if Pos(RightStr(FieldByName('CODSIT').AsString, 2), '10_60_70') <= 0 then
          begin
            intTipoMensagem := 2;
            strMensagem := 'PRODUTOS ENCONTRAM-SE COM CST DIFERENTE DA REGRA: X10_X60_X70.';
            pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem, strMensagem, produto);
          end;

          if FieldByName('INV_VALITE').AsFloat <= 0 then
          begin
            intTipoMensagem := 3;
            strMensagem := 'PRODUTOS SEM SALDO OU PREÇO(H010).';
            pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem, strMensagem, produto);
          end;

          if Copy(FieldByName('NOTULT').AsString, 13, 2) = 'PD' then
          begin
            intTipoMensagem := 4;
            strMensagem := 'PRODUTOS ASSOCIADO A UM PEDIDO COMO ULTIMA COMPRA.';
            pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem, strMensagem, produto);
          end;

          //1- validação, tem que ser CST = x10_x60_x70
          //2- não pode ser CFOP em branco para entrar nessa validação
          //3- validação, não enviar cfop 1401_1403_1409_2401_2403_2409
          if (Pos(RightStr(FieldByName('CODSIT').AsString, 2), '10_60_70') > 0) and
             (not fEmptyStr(FieldByName('CLAFIS').AsString)) and
             (Pos(FieldByName('CLAFIS').AsString, '1401_1403_1409_2401_2403_2409') <= 0) then
          begin
            intTipoMensagem := 5;
            strMensagem := 'PRODUTOS ENCONTRAM-SE COM CFOP DIFERENTE DA REGRA: 1401, 1403, 1409, 2401, 2403, 2409';
            pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem, strMensagem, produto);
          end;

          Result.Add(produto);

          Next;
        end;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function TRepositorioEstoque.fRetProdutoEstoqueMT(strCodEmp,
  strNcm, strMotivo, strMargem: string): TObjectList<TProduto>;
var
  qryAux: TUniQuery;
  produto: TProduto;
begin
  Result := FListaProdutosEstoque;

  FListaProdutosEstoque.Clear;

  if fTabelaExiste(FTabelaInventario) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlEstoqueMT(strNcm, strMotivo, strMargem));
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        First;
        while not Eof do
        begin

          produto := TProduto.Create;
          produto.strCodItem := FieldByName('CODITE').AsString;
          produto.unidade.strSigla := FieldByName('UNI_SIGUNI').AsString;
          produto.unidade.strCodigo := FieldByName('UNI_CODUNI').AsString;

          produto.fltSaldo := FieldByName('ITE_SALDOS').AsFloat;
          produto.fltPreco := FieldByName('PRECO_CONFIG').AsFloat;
          produto.fltValor := FieldByName('BASE_ICMS').AsFloat;
          produto.fltBaseICMS_ST := FieldByName('BASE_ICMS').AsFloat;
          If strMotivo = '1' Then
            produto.fltValorICMS_ST := 0;
          If strMotivo = '2' Then
            produto.fltValorICMS_ST := FieldByName('CREDITO_ICMS_7').AsFloat;
          If strMotivo = '4' Then
            produto.fltValorICMS_ST := FieldByName('CREDITO_ST_1015').AsFloat;
          If strMotivo = '5' Then
            produto.fltValorICMS_ST := FieldByName('CREDITO_ST_15').AsFloat;

          produto.strCodigoSituacaoTributaria := '000';

          Result.Add(produto);

          Next;
        end;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function TRepositorioEstoque.fRetProdutosEstoquePorTabela(strCodEmp, strLinGruExcluir: String; arrLinhaGrupoExcluir: TConsultasArray): TObjectList<TProduto>;
  Var
    produto: TProduto;
    qryAux: TUniQuery;
begin
  Result := FListaProdutosEstoque;

  if fTabelaExiste(FTabelaInventario) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSqlEstoquePorTabela(arrLinhaGrupoExcluir));
        ParamByName('CODEMP').AsString := strCodEmp;

        if Length(arrLinhaGrupoExcluir) > 0 then
          pSetaParam(arrLinhaGrupoExcluir[0].strCodigo, arrLinhaGrupoExcluir, strLinGruExcluir, 'CODGRU', qryAux);

        Open;

        First;
        while not Eof do
        begin
          produto := TProduto.Create;
          produto.strCodFabricaItemForn := FieldByName('COD_FABRICA_ITEM').AsString;
          produto.strCodItem := FieldByName('ITEM').AsString;
          produto.strCodigoNCM := FieldByName('NCM').AsString;
          produto.fltPreco := FieldByName('PRECO').AsFloat;
          produto.fltQuantidade := FieldByName('QUANTIDADE').AsFloat;
          produto.fltSaldo := FieldByName('QUANTIDADE').AsFloat;
          produto.fltValor := FieldByName('INV_VALITE').AsFloat;
          produto.unidade.strSigla := FieldByName('SIGLA_UNIDADE').AsString;
          Result.Add(produto);

          Next;
        end;
      end;
    finally
      qryAux.Free;
    end;

    pOrdenaListaItem;
  end;
end;

function TRepositorioEstoque.fRetSqlEstoqueAdjudicacao(arrLinhaGrupoExcluir: TConsultasArray): string;
  function fRetPrecoConfigurado: string;
  begin
    if Pos(FPRECO_INV_CAT42, '0_2') > 0 then
      Result := 'INV.ITE_PRECOM'
    else
      Result := 'INV.ITE_IMPULT';
  end;

  function fRetStringPreliq: string;
  begin
    if Pos(FPRECO_INV_CAT42, '0_1') > 0 then
    begin
      Result := Result + '  IF(IFNULL(D.DET_IDEPRO, "NOR") = "NOR", ' + fRetPrecoConfigurado + ' * ((100-INV.ITE_DESF01)/100) * ((100-INV.ITE_DESF02)/100) * ((100-INV.ITE_DESF03)/100) * ';
      Result := Result + ' ((100-INV.ITE_DESF04)/100) * ((100-INV.ITE_DESF05)/100) * ((100-INV.ITE_DESF06)/100), ';
      Result := Result + '  T.DET_COMLIQ ) ';
      Result := Result + ' * ((100+INV.ITE_IPIENT)/100) * ((100+INV.ITE_FREENT)/100) AS PRELIQ, ';
    end
    else
    begin
      Result := Result + fRetPrecoConfigurado + ' AS PRELIQ, ';
    end;
  end;

  function fRetTipoPrecoEscolhidoConfig(strTipo: integer): string;
  begin
    Result := '';

    case strTipo of
      0: Result := 'PRECOM';
      1: Result := 'PRECUS';
      2: Result := 'PREVE1';
      3: Result := 'PREVE2';
      4: Result := 'PREVE3';
      5: Result := 'PREVE4';
      6: Result := 'PREVE5';
      7: Result := 'PREVE6';
      8: Result := 'PREVE7';
      9: Result := 'PREMED';
      10: Result := 'PREULT';
      11: Result := 'IMPULT';
      12: Result := 'PRELIQ';
    end;
  end;

  var
    strQtdDec, strQtdUni, strCampoPreco, strPrecoCampo11, strCampoQtd: string;
begin
  Result := '';

  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  strCampoPreco := fInventarioPeloCusto('INV', 'GER');

  //Preco carregado subtraindo os impostos (CAMPO 11 reg H010)
  strPrecoCampo11 := fRetPrecoDeduzidoImposto;

  //caso o usuário configure o  preco desses campos
  if (not (StrToInt(FPRECO_REGH010_CAMPO06) < 0)) and
     (FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11 = 'S') then
    strCampoPreco := 'INV.ITE_' + fRetTipoPrecoEscolhidoConfig(StrToInt(FPRECO_REGH010_CAMPO06));

  //caso o usuário configure o preco desses campos
  if (not (StrToInt(FPRECO_REGH010_CAMPO11) < 0)) and
     (FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11 = 'S') then
    strPrecoCampo11 := 'INV.ITE_' + fRetTipoPrecoEscolhidoConfig(StrToInt(FPRECO_REGH010_CAMPO11));

  if (Not fEmptyStr(strTabelaInventario)) and
     (fCampoExiste(strTabelaInventario, 'ITE_SAL_ML')) then
  begin
    if fCampoExiste(strTabelaInventario, 'ITE_CNV_ML') then
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') '
    else
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(ITE.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / ITE.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ';
  end
  else
  begin
    strCampoQtd := 'ROUND(INV.ITE_SALDOS, ' + strQtdDec + ') ' ;
  end;

  strCampoPreco := 'ROUND(' + strCampoPreco + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';

  strPrecoCampo11 := 'ROUND(' + strPrecoCampo11 + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';


  Result := Result + 'SELECT ';
  Result := Result + fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                               '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') ', 2) + ' AS INV_VALITE, ';
  Result := Result + '  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') AS INV_PRECUS, ';
  Result := Result + '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') AS INV_SALDOS, ';
  Result := Result + '  SUM((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0))) / SUM(D.DET_QTDITE) AS RETIDO, ';
  Result := Result + '  IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 1, 12), SUBSTRING(INV.ITE_NOTULT, 1, 6)) AS DOCUMENTO, ';
  Result := Result + '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ';
  Result := Result + fRetStringPreliq;
  Result := Result + '  INV.ITE_NOTULT AS NOTULT, ';
  Result := Result + '  INV.ITE_CODITE AS CODITE, ';
  Result := Result + '  INV.ITE_CODSIT AS CODSIT, ';
  Result := Result + '  ITE.ITE_DESITE AS DESITE, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  //#Result := Result + '  UNI_SIGUNI, ';
  //#Result := Result + '  UNI_CODUNI ';

  Result := Result + '  UNI_INV.UNI_SIGUNI AS AX_SIGUNI, ';
  Result := Result + '  UNI_INV.UNI_CODUNI AS AX_CODUNI, ';
  Result := Result + '  UNI_ITE.UNI_SIGUNI AS BX_SIGUNI, ';
  Result := Result + '  UNI_ITE.UNI_CODUNI AS BX_CODUNI ';

  Result := Result + '  FROM ';
  Result := Result + FTabelaInventario + ' INV ';

  Result := Result + '  LEFT JOIN CADITE ITE ';
  Result := Result + '    ON ITE.ITE_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN ITEGER GER ';
  Result := Result + '    ON GER.ITE_CODITE = INV.ITE_CODITE ';
  Result := Result + '    AND GER.ITE_CODEMP = INV.ITE_CODEMP ';

  //#Result := Result + '  LEFT JOIN CADUNI ';
  //#Result := Result + '    ON UNI_CODUNI = INV.ITE_CODUNI ';
  Result := Result + '  LEFT JOIN CADUNI UNI_INV ';
  Result := Result + '    ON UNI_INV.UNI_CODUNI = INV.ITE_CODUNI ';

  Result := Result + '  LEFT JOIN CADUNI UNI_ITE ';
  Result := Result + '    ON UNI_ITE.UNI_CODUNI = ITE.ITE_CODUNI ';

  Result := Result + '  LEFT JOIN MOVDET D ';
  Result := Result + '    ON CAST(D.DET_NUMDOC AS UNSIGNED) = CAST(IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 1, 12), SUBSTRING(INV.ITE_NOTULT, 1, 6)) AS UNSIGNED) ';
  Result := Result + '    AND D.DET_ESPDOC = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 13, 2), SUBSTRING(INV.ITE_NOTULT, 7, 2)) ';
  Result := Result + '    AND D.DET_CODEMP = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 15, 3), SUBSTRING(INV.ITE_NOTULT, 9, 3)) ';
  Result := Result + '    AND D.DET_SERIE_ = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 18, 3), SUBSTRING(INV.ITE_NOTULT, 12, 3)) ';
  Result := Result + '    AND D.DET_CODFOR = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 21, 8), SUBSTRING(INV.ITE_NOTULT, 15, 8)) ';
  Result := Result + '    AND D.DET_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN ABFICM ';
  Result := Result + '    ON ABF_CODABF = INV.ITE_CODABF ';
  Result := Result + '    AND ABF_ESTADO = "RS" ';

  Result := Result + '  WHERE LOCATE(RIGHT(INV.ITE_CODSIT, 2), "10_60_70") > 0 ';
  Result := Result + '    AND INV.ITE_CODEMP = :CODEMP ';
  Result := Result + '    AND INV.ITE_SALDOS > 0 ';
  Result := Result + '    AND ((SUBSTRING(INV.ITE_NOTULT, 13, 2) <> "PD") OR INV.ITE_NOTULT IS NULL) ';

  if Length(arrLinhaGrupoExcluir) > 0 then
    Result := Result + fStrLocateLinGru(arrLinhaGrupoExcluir, 'INV.ITE_CODGRU', 'CODGRU', False, True);

  Result := Result + '  GROUP BY INV.ITE_NOTULT, INV.ITE_CODITE  ';

  Result := Result + '  ORDER BY INV.ITE_CODITE ';
end;

function TRepositorioEstoque.fRetSqlEstoqueAdjudicacaoPorAbreviacao(arrLinhaGrupoExcluir: TConsultasArray; strAbrevSel: string): string;
  function fRetTipoPrecoEscolhidoConfig(strTipo: integer): string;
  begin
    Result := '';

    case strTipo of
      0: Result := 'PRECOM';
      1: Result := 'PRECUS';
      2: Result := 'PREVE1';
      3: Result := 'PREVE2';
      4: Result := 'PREVE3';
      5: Result := 'PREVE4';
      6: Result := 'PREVE5';
      7: Result := 'PREVE6';
      8: Result := 'PREVE7';
      9: Result := 'PREMED';
      10: Result := 'PREULT';
      11: Result := 'IMPULT';
      12: Result := 'PRELIQ';
    end;
  end;

  var
    strSql, strCampoPreco, strCampoQtd, strQtdDec, strQtdUni: string;
begin
  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  strCampoPreco := fInventarioPeloCusto('INV', 'GER');

  if (Not fEmptyStr(FTabelaInventario)) and
     (fCampoExiste(FTabelaInventario, 'ITE_SAL_ML')) then
  begin
    if fCampoExiste(FTabelaInventario, 'ITE_CNV_ML') then
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') '
    else
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(ITE.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / ITE.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ';
  end
  else
  begin
    strCampoQtd := 'ROUND(INV.ITE_SALDOS, ' + strQtdDec + ') ' ;
  end;

  strCampoPreco := 'ROUND(' + strCampoPreco + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';

  strSql :=          'SELECT  DISTINCT ';
  strSql := strSql + '  INV.ITE_CODEMP, ';
  strSql := strSql + '  INV.ITE_PRECOM, ';
  strSql := strSql + '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') AS INV_SALDOS, ';
  strSql := strSql + '  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') AS INV_PRECUS, ';
  strSql := strSql + '  ROUND(IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') * ABF.ABF_IVA_ST_ENT_PEJ, 2) AS BASE_ST, ';
  strSql := strSql + '  ROUND(((IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') * ABF.ABF_IVA_ST_ENT_PEJ) * ABF_ALQRET_ENT_PEJ) / 100, ' + strQtdDec + ') AS VLR_ST, ';
  strSql := strSql + '  INV.ITE_SALDOS AS INV_ITE_SALDOS, ';
  strSql := strSql + '  INV.ITE_SUBSTI AS INV_ITE_SUBSTI, ';
  strSql := strSql + '  GER.ITE_SUBSTI AS GER_ITE_SUBSTI, ';
  strSql := strSql + '  INV.ITE_PREMED AS INV_PREMED, ';
  strSql := strSql + '  ABF.ABF_IVA_ST_ENT_PEJ AS INV_IVA, ';
  strSql := strSql + '  INV.ITE_CODITE AS INV_CODITE, ';
  strSql := strSql + '  INV.ITE_DESITE AS INV_DESITE, ';
  strSql := strSql + '  INV.ITE_CODSIT AS CODSIT, ';
  strSql := strSql + '  UNI_CODUNI, ';
  strSql := strSql + '  UNI_SIGUNI, ';

  strSql := strSql + fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                               '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') ', 2) + ' AS INV_VALITE ';

  strSql := strSql + '  FROM ' + FTabelaInventario + ' INV ';

  strSql := strSql + ' INNER JOIN CADITE ITE ';
  strSql := strSql + '   ON ITE.ITE_CODITE = INV.ITE_CODITE ';

  strSQL := strSQL + '  LEFT JOIN ITEGER GER ';
  strSQL := strSQL + '   ON GER.ITE_CODITE = INV.ITE_CODITE ';
  strSQL := strSQL + '   AND GER.ITE_CODEMP = INV.ITE_CODEMP ';

  strSql := strSql + '  LEFT JOIN CADUNI UNI ';
  strSql := strSql + '   ON ITE.ITE_CODUNI = UNI_CODUNI ';

  strSql := strSql + '  LEFT JOIN ABFICM ABF ON ';

  if fCfgSis('TIPABF') = '1' then
    strSql := strSql + '  ABF_CODABF = ITE.ITE_CODABF '
  else
    strSql := strSql + '  ABF_CODABF = GER.ITE_CODABF ';

  strSql := strSql + '    AND ABF_ESTADO = :ESTADO ';

  strSql := strSql + ' WHERE INV.ITE_CODEMP = :CODEMP ';

  if not fEmptyStr(strAbrevSel) then
    strSql := strSql + '   AND INV.ITE_CODABF IN ' + strAbrevSel;

  if Length(arrLinhaGrupoExcluir) > 0 then
    strSql := strSql + fStrLocateLinGru(arrLinhaGrupoExcluir, 'INV.ITE_CODGRU', 'CODGRU', False, True);

  strSql := strSql + ' GROUP BY INV.ITE_CODITE ';

  Result := strSql;
end;

function TRepositorioEstoque.fRetSqlEstoqueAdjudicacaoSemFiltro(
  arrLinhaGrupoExcluir: TConsultasArray): string;
  function fRetTipoPrecoEscolhidoConfig(strTipo: integer): string;
  begin
    Result := '';

    case strTipo of
      0: Result := 'PRECOM';
      1: Result := 'PRECUS';
      2: Result := 'PREVE1';
      3: Result := 'PREVE2';
      4: Result := 'PREVE3';
      5: Result := 'PREVE4';
      6: Result := 'PREVE5';
      7: Result := 'PREVE6';
      8: Result := 'PREVE7';
      9: Result := 'PREMED';
      10: Result := 'PREULT';
      11: Result := 'IMPULT';
      12: Result := 'PRELIQ';
    end;
  end;

  var
    strQtdDec, strQtdUni, strCampoPreco, strPrecoCampo11, strCampoQtd: string;
    strPrecoConfigurado: string;
begin
  Result := '';

  if FPRECO_INV_CAT42 = '0' then
    strPrecoConfigurado := 'INV.ITE_PRECOM'
  else
    strPrecoConfigurado := 'INV.ITE_IMPULT';

  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  strCampoPreco := fInventarioPeloCusto('INV', 'GER');

  //Preco carregado subtraindo os impostos (CAMPO 11 reg H010)
  strPrecoCampo11 := fRetPrecoDeduzidoImposto;

  //caso o usuário configure o  preco desses campos
  if (not (StrToInt(FPRECO_REGH010_CAMPO06) < 0)) and
     (FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11 = 'S') then
    strCampoPreco := 'INV.ITE_' + fRetTipoPrecoEscolhidoConfig(StrToInt(FPRECO_REGH010_CAMPO06));

  //caso o usuário configure o preco desses campos
  if (not (StrToInt(FPRECO_REGH010_CAMPO11) < 0)) and
     (FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11 = 'S') then
    strPrecoCampo11 := 'INV.ITE_' + fRetTipoPrecoEscolhidoConfig(StrToInt(FPRECO_REGH010_CAMPO11));

  if (Not fEmptyStr(strTabelaInventario)) and
     (fCampoExiste(strTabelaInventario, 'ITE_SAL_ML')) then
  begin
    if fCampoExiste(strTabelaInventario, 'ITE_CNV_ML') then
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') '
    else
      strCampoQtd := 'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(ITE.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / ITE.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ';
  end
  else
  begin
    strCampoQtd := 'ROUND(INV.ITE_SALDOS, ' + strQtdDec + ') ' ;
  end;

  strCampoPreco := 'ROUND(' + strCampoPreco + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';

  strPrecoCampo11 := 'ROUND(' + strPrecoCampo11 + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';


  Result := Result + 'SELECT ';
  Result := Result + fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                               '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') ', 2) + ' AS INV_VALITE, ';
  Result := Result + '  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') AS INV_PRECUS, ';
  Result := Result + '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') AS INV_SALDOS, ';
  Result := Result + '  SUM((IFNULL(D.DET_BASRET, 0) + IFNULL(T.DET_BAERET, 0))) / SUM(D.DET_QTDITE) AS RETIDO, ';
  Result := Result + '  IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 1, 12), SUBSTRING(INV.ITE_NOTULT, 1, 6)) AS DOCUMENTO, ';
  Result := Result + '  ABF_IVA_ST_ENT_PEJ AS IVA_ST, ';
  Result := Result + '  IF(IFNULL(D.DET_IDEPRO, "NOR") = "NOR", ' + strPrecoConfigurado + ' * ((100-INV.ITE_DESF01)/100) * ((100-INV.ITE_DESF02)/100) * ((100-INV.ITE_DESF03)/100) * ';
  Result := Result + ' ((100-INV.ITE_DESF04)/100) * ((100-INV.ITE_DESF05)/100) * ((100-INV.ITE_DESF06)/100), ';
  Result := Result + '  T.DET_COMLIQ ) ';
  Result := Result + ' * ((100+INV.ITE_IPIENT)/100) * ((100+INV.ITE_FREENT)/100) * ABF_IVA_ST_ENT_PEJ AS PRELIQ, ';
  Result := Result + '  INV.ITE_NOTULT AS NOTULT, ';
  Result := Result + '  INV.ITE_CODITE AS CODITE, ';
  Result := Result + '  INV.ITE_CODSIT AS CODSIT, ';
  Result := Result + '  ITE.ITE_DESITE AS DESITE, ';
  Result := Result + '  D.DET_QTDITE AS QTDITE, ';
  Result := Result + '  D.DET_CLAFIS AS CLAFIS, ';
  Result := Result + '  UNI_SIGUNI, ';
  Result := Result + '  UNI_CODUNI ';

  Result := Result + '  FROM ';
  Result := Result + FTabelaInventario + ' INV ';

  Result := Result + '  LEFT JOIN CADITE ITE ';
  Result := Result + '    ON ITE.ITE_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN ITEGER GER ';
  Result := Result + '    ON GER.ITE_CODITE = INV.ITE_CODITE ';
  Result := Result + '    AND GER.ITE_CODEMP = INV.ITE_CODEMP ';

  Result := Result + '  LEFT JOIN CADUNI ';
  Result := Result + '    ON UNI_CODUNI = INV.ITE_CODUNI ';

  Result := Result + '  LEFT JOIN MOVDET D ';
  Result := Result + '    ON CAST(D.DET_NUMDOC AS UNSIGNED) = CAST(IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 1, 12), SUBSTRING(INV.ITE_NOTULT, 1, 6)) AS UNSIGNED) ';
  Result := Result + '    AND D.DET_ESPDOC = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 13, 2), SUBSTRING(INV.ITE_NOTULT, 7, 2)) ';
  Result := Result + '    AND D.DET_CODEMP = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 15, 3), SUBSTRING(INV.ITE_NOTULT, 9, 3)) ';
  Result := Result + '    AND D.DET_SERIE_ = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 18, 3), SUBSTRING(INV.ITE_NOTULT, 12, 3)) ';
  Result := Result + '    AND D.DET_CODFOR = IF(LENGTH(INV.ITE_NOTULT) > 22, SUBSTRING(INV.ITE_NOTULT, 21, 8), SUBSTRING(INV.ITE_NOTULT, 15, 8)) ';
  Result := Result + '    AND D.DET_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN MOVTRI T ';
  Result := Result + '    ON T.DET_SEQGER = D.AUTOINCREM ';

  Result := Result + '  LEFT JOIN ABFICM ';
  Result := Result + '    ON ABF_CODABF = INV.ITE_CODABF ';
  Result := Result + '    AND ABF_ESTADO = "RS" ';

  Result := Result + '  WHERE INV.ITE_CODEMP = :CODEMP ';

  if Length(arrLinhaGrupoExcluir) > 0 then
    Result := Result + fStrLocateLinGru(arrLinhaGrupoExcluir, 'INV.ITE_CODGRU', 'CODGRU', False, True);

  Result := Result + '  GROUP BY INV.ITE_NOTULT, INV.ITE_CODITE  ';

  Result := Result + '  ORDER BY INV.ITE_CODITE ';
end;

function TRepositorioEstoque.fRetSqlEstoqueMT(strNcm,
  strMotivo, strMargem: String): String;
var
  strCampoPreco: String;
  strMargem2: String;
  strMargem4: String;
  strMargem5: String;
  strSaldos:  String;
begin
  strMargem2 := '7';
  strMargem4 := '10.15';
  strMargem5 := '15';
  If strMotivo = '2' Then
  Begin
    If fEmptyStr(strMargem) Then
      strMargem2 := '7'
    Else
      strMargem2 := StringReplace(strMargem,',','.',[]);
  End;
  If strMotivo = '4' Then
  Begin
    If fEmptyStr(strMargem) Then
      strMargem4 := '10.15'
    Else
      strMargem4 := StringReplace(strMargem,',','.',[]);
  End;
  If strMotivo = '5' Then
  Begin
    If fEmptyStr(strMargem) Then
      strMargem5 := '15'
    Else
      strMargem5 := StringReplace(strMargem,',','.',[]);
  End;

  strCampoPreco := fInventarioPeloCusto('INV');
  //strCampoPreco := 'ROUND(' + strCampoPreco + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + fCfgSis('DECUNI', varString) + ')';


  strCampoPreco := ' ROUND(IFNULL('+strCampoPreco+',0)/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), 4)' ;
  strSaldos := ' ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), 3), 3) ';


  Result := '';

  Result := Result + ' SELECT ';
  Result := Result + '   "'+strMotivo+'"  AS MOTIVO, ';
  Result := Result + '   UNI_SIGUNI, ';
  Result := Result + '   UNI_CODUNI, ';
  Result := Result + '   INV.ITE_CLAIPI, ';
  Result := Result + '   INV.ITE_CODITE AS CODITE, ';
  Result := Result + '   INV.ITE_PREMED, ';
  Result := Result + '   INV.ITE_PRECUS, ';
  Result := Result + '   INV.ITE_PREULT, ';
  Result := Result + '   INV.ITE_IMPULT, ';
  Result := Result + '   INV.ITE_PRECOM, ';

  Result := Result + '   '+strSaldos+' AS ITE_SALDOS, ';

  strSaldos :=  fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                               '  IF(' + strSaldos + ' < 0.0, 0.0, ' + strSaldos + ') ', 2);

  Result := Result + '   INV.ITE_CODSIT AS CODSIT, ';
  Result := Result + '   '+strCampoPreco+' AS PRECO_CONFIG,';
  Result := Result + strSaldos + ' AS BASE_ICMS, ';
  Result := Result + '   ROUND(('+strSaldos+') *  '+strMargem2+' / 100,2) AS CREDITO_ICMS_7, ';
  Result := Result + '   ROUND(('+strSaldos+') *  '+strMargem4+' / 100,2) AS CREDITO_ST_1015, ';
  Result := Result + '   ROUND(('+strSaldos+') *  '+strMargem5+' / 100,2) AS CREDITO_ST_15 ';


  Result := Result + '   FROM '+FTabelaInventario+' INV  ';

  Result := Result + ' INNER JOIN CADITE ITE ';
  Result := Result + '   ON ITE.ITE_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN CADUNI UNI ';
  Result := Result + '   ON ITE.ITE_CODUNI = UNI_CODUNI ';

  Result := Result + '   WHERE INV.ITE_CODEMP = :CODEMP ';

  strSaldos := ' ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), 3), 3) ';

  Result := Result + '   AND ('+strSaldos+') > 0 ';

  Result := Result + '   AND INV.ITE_CLAIPI IN ('+strNcm+')';

  Result := Result + '  GROUP BY INV.ITE_CODITE  ';

  Result := Result + '  ORDER BY INV.ITE_CODITE ';
end;

function TRepositorioEstoque.fRetSqlEstoquePorTabela(arrLinhaGrupoExcluir: TConsultasArray): String;
  var
    strSql, strCampoPreco, strCampoQtd, strQtdDec, strQtdUni: string;
begin
  strQtdDec := fCfgSis('DECQTD', varString);
  strQtdUni := fCfgSis('DECUNI', varString);

  if Assigned(FAbertura) then
    strCampoPreco := 'INV.' + fRetPrecoCalcular(FAbertura.intCampoPrecoEstoque)
  else
    strCampoPreco := 'INV.ITE_PRECUS';

  if (Not fEmptyStr(FTabelaInventario)) and
     (fCampoExiste(FTabelaInventario, 'ITE_SAL_ML')) then
  begin
    if fCampoExiste(FTabelaInventario, 'ITE_CNV_ML') then
      strCampoQtd := IIF(fEmptyStr(FEMPRESAS_SELECIONADAS_REGH010_REGK200),
                    'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / INV.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ',
                    'ROUND(ROUND(((INV.ITE_SALDOS + TB1.AX1_SALDOS) + IF(IFNULL(INV.ITE_CNV_ML, 0) > 0, (IFNULL(INV.ITE_SAL_ML, 0) + IFNULL(TB1.AX1_SAL_ML ,0)) / INV.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ')
    else
      strCampoQtd := IIF(fEmptyStr(FEMPRESAS_SELECIONADAS_REGH010_REGK200),
                     'ROUND(ROUND((INV.ITE_SALDOS + IF(IFNULL(ITE.ITE_CNV_ML, 0) > 0, IFNULL(INV.ITE_SAL_ML, 0) / ITE.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ',
                     'ROUND(ROUND(((INV.ITE_SALDOS + TB1.AX1_SALDOS) + IF(IFNULL(ITE.ITE_CNV_ML, 0) > 0, (IFNULL(INV.ITE_SAL_ML, 0) + IFNULL(TB1.AX1_SAL_ML, 0)) / ITE.ITE_CNV_ML, 0)), ' + strQtdDec + '), ' + strQtdDec + ') ');
  end
  else
  begin
    strCampoQtd := IIF(fEmptyStr(FEMPRESAS_SELECIONADAS_REGH010_REGK200),
                   'ROUND(INV.ITE_SALDOS, ' + strQtdDec + ') ',
                   'ROUND((INV.ITE_SALDOS + IFNULL(TB1.AX1_SALDOS, 0)), ' + strQtdDec + ') ');
  end;

  strCampoPreco := 'ROUND(' + strCampoPreco + '/ IF((ITE.ITE_FATCNV = 0) OR (ITE.ITE_FATCNV IS NULL), 1, ITE.ITE_FATCNV), ' + strQtdUni + ')';

  strSql := '';
  strSql := strSql + 'SELECT ';
  strSql := strSql + '  ITE.ITE_CLAIPI AS NCM, ';
  strSql := strSql + '  INV.ITE_CODITE AS ITEM, ';
  strSql := strSql + '  UNI.UNI_SIGUNI AS SIGLA_UNIDADE, ';
  strSql := strSql + '  IFNULL(ITE.ITE_CODPAG, "") AS CODPAG, ';
  strSql := strSql + '  IFNULL(ITE.ITE_CODFAB, "") AS COD_FABRICA_ITEM, ';
  strSql := strSql + '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') AS QUANTIDADE, ';
  strSql := strSql + '  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') AS PRECO, ';
  strSql := strSql + fRoundSql('  IF(' + strCampoPreco + ' < 0.0, 0.0, ' + strCampoPreco + ') *  ' +
                               '  IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') ', 2) + ' AS INV_VALITE ';

  strSql := strSql + ' FROM ';
  strSql := strSql + '   ' + FTabelaInventario + ' INV ';

  strSql := strSql + '   INNER JOIN CADITE ITE ';
  strSql := strSql + '    ON ITE.ITE_CODITE = INV.ITE_CODITE ';

  strSql := strSql + '   INNER JOIN ITEGER GER ';
  strSql := strSql + '    ON GER.ITE_CODITE = INV.ITE_CODITE ';
  strSql := strSql + '    AND GER.ITE_CODEMP = INV.ITE_CODEMP ';

  strSql := strSql + '   LEFT JOIN CADUNI UNI ';
  strSql := strSql + '    ON UNI.UNI_CODUNI = INV.ITE_CODUNI ';

  if not fEmptyStr(FEMPRESAS_SELECIONADAS_REGH010_REGK200) then
  begin
    strSql := strSql + '  LEFT JOIN ';
    strSql := strSql + '    (SELECT ';
    strSql := strSql + '      AX1.ITE_CODITE AS AX1_CODITE, ';
    strSql := strSql + '      SUM(AX1.ITE_SALDOS) AS AX1_SALDOS, ';
    strSql := strSql + '      SUM(AX1.ITE_SAL_ML) AS AX1_SAL_ML ';
    strSql := strSql + '    FROM ' + FTabelaInventario + ' AX1 ';
    strSql := strSql + '    WHERE (LOCATE(AX1.ITE_CODEMP, "' + FEMPRESAS_SELECIONADAS_REGH010_REGK200 + '")>0) ';
    strSql := strSql + '    GROUP BY AX1.ITE_CODITE) TB1 ';
    strSql := strSql + '    ON TB1.AX1_CODITE = INV.ITE_CODITE ';
  end;

  strSql := strSql + 'WHERE IF(' + strCampoQtd + ' < 0.0, 0.0, ' + strCampoQtd + ') > 0 ';
  strSql := strSql + '  AND INV.ITE_CODEMP = :CODEMP ';

  if fCampoExiste('ITEGER', 'ITE_TIPPRO') and fCampoExiste('CADITE', 'ITE_TIPPRO') then
  begin
    strSql := strSql + '  AND LOCATE(GER.ITE_TIPPRO, "00_01_02_03_04_05_10_") > 0 ';
    strSql := strSql + '  AND LOCATE(ITE.ITE_TIPPRO, "00_01_02_03_04_05_10_") > 0 ';
  end
  else if fCampoExiste('ITEGER', 'ITE_TIPPRO') then
    strSql := strSql + '  AND LOCATE(GER.ITE_TIPPRO, "00_01_02_03_04_05_10_") > 0 '
  else if fCampoExiste('CADITE', 'ITE_TIPPRO') then
    strSql := strSql + '  AND LOCATE(ITE.ITE_TIPPRO, "00_01_02_03_04_05_10_") > 0 ';

  if Length(arrLinhaGrupoExcluir) > 0 then
    strSql := strSql + fStrLocateLinGru(arrLinhaGrupoExcluir, 'INV.ITE_CODGRU', 'CODGRU', False, True);

  Result := strSql;
end;

function TRepositorioEstoque.fRetValorTotalInventario(produtos: TObjectList<TProduto>): double;
  var
    produto: TProduto;
begin
  Result := 0;

  for produto in produtos do
  begin
    Result := Result + produto.fltValor;
  end;
end;

function TRepositorioEstoque.fRetValorTotalStInventario(produtos: TObjectList<TProduto>): double;
  var
    produto: TProduto;
begin
  Result := 0;

  for produto in produtos do
  begin
    Result := Result + fFormataFloat(fFormataFloat(produto.fltValorICMS_ST, 2) * fFormataFloat(produto.fltSaldo, 3), 2);
  end;
end;

procedure TRepositorioEstoque.pAdicionarMensagemEstadoProdutoEstocado(intTipoMensagem: integer; strMensagem: string; produto: TProduto);
  var
    objMensagem: TMensagemEstadoProdutoEstocado;
begin
  objMensagem := TMensagemEstadoProdutoEstocado.Create;
  objMensagem.intTipoMensagem := intTipoMensagem;
  objMensagem.strMensagem := strMensagem;

  produto.pAdicionaMensagemEstadoProdutoEstocado(objMensagem);
end;

procedure TRepositorioEstoque.pCarregaAbfIcmGeralEmpresa;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODEMP = :CODEMP AND SIS_CODCFG = "CFG_TIPABF" ';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      FCadAbfGeral := IIF(FieldByName('SIS_VALCFG').AsString = '1', 'S', 'N');
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TRepositorioEstoque.pCarregaVariaveisConfiguracoes;
begin
  FCALCULAR_ST_ADJUDICACAO := fCfgSpd('CALCULAR_ST_ADJUDICACAO');
  FALTERACAO_TRIBUTARIA := fCfgSpd('ALTERACAO_TRIBUTARIA');
  FUTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11 := fCfgSpd('UTILIZAR_PRECO_CONFIGURADO_CAMPO06_CAMPO11');
  FPRECO_INV_CAT42 := fCfgSpd('PRECO_INV_CAT42');
  FPRECO_REGH010_CAMPO06 := fCfgSpd('PRECO_REGH010_CAMPO06');
  FPRECO_REGH010_CAMPO11 := fCfgSpd('PRECO_REGH010_CAMPO11');
  FEMPRESAS_SELECIONADAS_REGH010_REGK200 := fCfgSpd('EMPRESAS_SELECIONADAS_REGH010_REGK200');
end;

procedure TRepositorioEstoque.pCriaTabelaMovimentacaoInventario;
begin
  //Cria tabela movimentação inventario.
  pTabelaMovimentacaoAdjudicacao;
  pTabelaParcelaAdjudicacao;
end;

procedure TRepositorioEstoque.pOrdenaListaItem;
  Var
    criterioComparacao: TComparison<TProduto>;
    comparador: IComparer<TProduto>;
begin
  criterioComparacao := function(const Left: TProduto; const Right: TProduto): Integer
  begin
    If Left.strCodItem = Right.strCodItem Then
    Begin
      Result := 0;
    End
    Else If Left.strCodItem > Right.strCodItem Then
    Begin
      Result := 1;
    End
    Else
    Begin
      Result := -1;
    End;

  End;
  comparador := TComparer<TProduto>.Construct(criterioComparacao);
end;

procedure TRepositorioEstoque.pTabelaMovimentacaoAdjudicacao;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);

  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('CREATE TABLE IF NOT EXISTS MADJUD ( ');
      SQL.Add('  AUTOINCREM INT(10) NOT NULL AUTO_INCREMENT, ');
      SQL.Add('  CODITE VARCHAR(200) DEFAULT NULL, ');
      SQL.add('  CODFIS VARCHAR(4) DEFAULT NULL, ');
      SQL.Add('  SALDO DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  DOCUMENTO VARCHAR(12) DEFAULT NULL, ');
      SQL.Add('  CFOP VARCHAR(4) DEFAULT NULL, ');
      SQL.Add('  BASEST DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  BASE_TOTAL_ENT DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  VLRST DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  PRECOCOMPRA DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  IVA DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  PRECOCALC DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  BASE_TOTAL_CALC DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  TOTALH020 DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  PRECOH020 DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  PRECO DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  TOTALH010 DECIMAL(15,4) DEFAULT NULL, ');
      SQL.Add('  CODEMP CHAR(3) NOT NULL, ');
      SQL.Add('  TABELAINVENTARIO VARCHAR(40) NOT NULL, ');
      SQL.Add('  CONFIGABRICMS VARCHAR(120) DEFAULT NULL, ');
      SQL.Add('  TIPORELATORIO CHAR(1) DEFAULT NULL, ');
      SQL.Add('  VALIDARST CHAR(1) DEFAULT NULL, ');
      SQL.Add('  VALIDARPRECO CHAR(1) DEFAULT NULL, ');
      SQL.Add('  VALIDARCST CHAR(1) DEFAULT NULL, ');
      SQL.Add('  VALIDARPEDULTCOMPRA CHAR(1) DEFAULT NULL, ');
      SQL.Add('  VALIDARCFOP CHAR(1) DEFAULT NULL, ');
      SQL.add('  TIPOMENSAGEM INT(10) DEFAULT NULL, ');
      SQL.add('  MENSAGEM VARCHAR(200) DEFAULT NULL, ');
      SQL.add('  PARCELASGERADAS CHAR(1) DEFAULT NULL, ');
      SQL.Add('  PRIMARY KEY (AUTOINCREM,CODEMP,TABELAINVENTARIO) ');
      SQL.Add(') ENGINE=INNODB AUTO_INCREMENT=0 DEFAULT CHARSET=latin1 ');
      ExecSQL;
    end;
  finally
      qryAux.Free;
  end;
end;

procedure TRepositorioEstoque.pTabelaParcelaAdjudicacao;
begin
  //Tabela para gravar as parcelas para servir como paramentros no SPED
  if (fTabelaExiste('PARADJ')) then
  begin
  end;
end;

end.
