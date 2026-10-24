unit untTRegraNegocioControleEstoque;

interface

uses UniClientDataSet, Generics.Collections, System.Generics.Defaults,
     untTItemNotaFiscal, untTDadosAbertura,
     Classes, SysUtils, strUtils, Uni, Dialogs, Forms,
     untICarregaNF, untTCarregaNFCompra, untTCarregaNFVenda, untTFactoryCarregaNF,
     untTProduto;

type
  TCarregaItensSubstituidos = class
  private
    FListaItens: TObjectList<TProduto>;
    FDadosAbertura: TDadosAbertura;
    FUFEmitente: string;

    procedure pCarregaUFEmitente;

    function fOrdenalistaCodigo: IComparer<TProduto>;
    function fRetTabelaInventario: string;
    function fRetSQL: string;
  public
    function fCarregar: TObjectList<TProduto>;

    constructor create(dadosAbertura: TDadosAbertura);
    Destructor Destroy; override;
  end;

  TRegraNegocioControleEstoque = class
  private
    FDadosAbertura: TDadosAbertura;
  public
    procedure pCarregaClientImpressao(cdsAux: TUniClientDataSet);

    constructor create(dadosAbertura: TDadosAbertura);
  end;

  CONST CST_SUBSTI = '10_30_60_70';

implementation

uses untFuncoesSimples,
     untIFuncoes;

{ TRegraNegocioControleEstoque }

constructor TRegraNegocioControleEstoque.create(dadosAbertura: TDadosAbertura);
begin
  inherited create;

  FDadosAbertura := dadosAbertura;
end;

procedure TRegraNegocioControleEstoque.pCarregaClientImpressao(cdsAux: TUniClientDataSet);
  //função que gerencia a regra de onde enviar a base de ST no layout de saída (SAIDAOUTROESTADO / SAIDACOMERCIALIZACAO)
  function fValidaValorBaseST(strTipo, strCliente: string; fltBaseST: double): double;
  begin
    Result := 0;

    if (fGetTipoAbfCliente(strCliente) = strTipo) then
      Result := fltBaseST;
  end;

  var
    carregadorItens: TCarregaItensSubstituidos;
    itensCompra: TObjectList<TItemNotaFiscal>;
    itensVenda: TObjectList<TItemNotaFiscal>;
    listaItens: TObjectList<TProduto>;
    itemNF: TItemNotaFiscal;
    carregador: ICarregaNF;
    item: TProduto;
begin
  cdsAux.EmptyDataSet;

  carregadorItens := TCarregaItensSubstituidos.Create(FDadosAbertura);
  try
    //carrega a lista de produtos substituidos
    listaItens := carregadorItens.fCarregar;

    //ordena a lista por código
    listaItens.sort(carregadorItens.fOrdenalistaCodigo);

    //carrega os dados para barra de progresso
    FDadosAbertura.progresso.Max := listaItens.Count;
    FDadosAbertura.progresso.Position := 0;

    //processa a lista de itens
    for item in listaItens do
    begin
      cdsAux.Append;
      //dados do cabecalho
      cdsAux.FieldByName('CODITE').AsString := item.strCodigo;
      cdsAux.FieldByName('CONTRIBUINTE').AsString := fCadEmp('NOMEMP');
      cdsAux.FieldByName('INSCREST').AsString := fCadEmp('I_E_S_');
      cdsAux.FieldByName('MESANO').AsString := FormatDateTime('MM/YYYY', FDadosAbertura.dtaDataInicial);
      cdsAux.FieldByName('DESCRICAO').AsString := item.strCodigo + ' - ' + item.strDescricao;
      cdsAux.FieldByName('UNIDADE').AsString := item.strUnidade;
      cdsAux.FieldByName('ALQST').AsFloat := item.fltAliquotaST;

      //primeira linha tem que conter a string "saldo inicial" na linha de data e os campos de totais preenchidos com as informações atuais do produto
      cdsAux.FieldByName('DATA').AsString := 'SALDO INICIAL';
      cdsAux.FieldByName('QTDTOTAL').AsFloat := item.fltSaldo;
      cdsAux.FieldByName('UNITARIOTOTAL').AsFloat := item.fltPreco;
      cdsAux.FieldByName('VALORTOTAL').AsFloat := fFormataFloat(item.fltTotal, 2);
      cdsAux.Post;

      //carrega todas as compras do produto no período
      carregador := TFactoryCarregaNF.fGetInstance.fRetCarregador('entrada', FDadosAbertura);
      itensCompra := carregador.fCarregar(item.strCodigo);

      for itemNF in itensCompra do
      begin
        //soma ao saldo de estoque, as quantidades compradas.
        item.fltSaldo := item.fltSaldo + itemNF.fltQuantidade;
        item.fltTotal := item.fltTotal + itemNF.fltTotalProduto;

        //LAYOUT - ENTRADAS
        cdsAux.Append;
        cdsAux.FieldByName('CODITE').AsString := item.strCodigo;
        cdsAux.FieldByName('DATA').AsString := FormatDateTime('DD/MM/YYYY', itemNF.dtaData);
        cdsAux.FieldByName('NFCOMPRA').AsString := itemNF.strNumero;
        cdsAux.FieldByName('SERIECOMPRA').AsString := itemNF.strSerie;
        cdsAux.FieldByName('QTDCOMPRA').AsFloat := itemNF.fltQuantidade;
        cdsAux.FieldByName('BASESTCOMPRA').AsFloat := itemNF.fltBaseSt;

        //LAYOUT - SALDOS
        cdsAux.FieldByName('QTDTOTAL').AsFloat := item.fltSaldo;
        cdsAux.FieldByName('UNITARIOTOTAL').AsFloat := fFormataFloat(item.fltTotal / item.fltSaldo, 2);
        cdsAux.FieldByName('VALORTOTAL').AsFloat := item.fltTotal;
        cdsAux.Post;
      end;

      //carrega todas as vendas para fora do estado do produto no período
      carregador := TFactoryCarregaNF.fGetInstance.fRetCarregador('saida', FDadosAbertura);
      itensVenda := carregador.fCarregar(item.strCodigo);

      for itemNF in itensVenda do
      begin
        //subtrai ao saldo de estoque, as quantidades vendidas.
        item.fltSaldo := item.fltSaldo - itemNF.fltQuantidade;
        item.fltTotal := item.fltTotal - itemNF.fltTotalProduto;

        //LAYOUT - SAÍDAS
        cdsAux.Append;
        cdsAux.FieldByName('CODITE').AsString := item.strCodigo;
        cdsAux.FieldByName('DATA').AsString := FormatDateTime('DD/MM/YYYY', itemNF.dtaData);
        cdsAux.FieldByName('NFVENDA').AsString := itemNF.strNumero;
        cdsAux.FieldByName('SERIEVENDA').AsString := itemNF.strSerie;
        cdsAux.FieldByName('QTDVENDA').AsFloat := itemNF.fltQuantidade;
        cdsAux.FieldByName('UNITARIOVENDA').AsFloat := itemNF.fltValorUnitario;
        cdsAux.FieldByName('SAIDACONSUMIDOR').AsFloat := 0;
        cdsAux.FieldByName('FATOGERADOR').AsFloat := 0;
        cdsAux.FieldByName('SAIDAISENTA').AsFloat := 0;

        //caso seja CCO = x10_x30_x70
        cdsAux.FieldByName('SAIDAOUTROESTADO').AsFloat := fValidaValorBaseST('CCO', itemNF.strCodigoParticipante, itemNF.fltBaseSt);
        //caso seja CNC = x10_x30_x70
        cdsAux.FieldByName('SAIDACOMERCIALIZACAO').AsFloat := fValidaValorBaseST('CNC', itemNF.strCodigoParticipante, itemNF.fltBaseSt);

        //LAYOUT - SALDOS
        cdsAux.FieldByName('QTDTOTAL').AsFloat := item.fltSaldo;
        cdsAux.FieldByName('UNITARIOTOTAL').AsFloat := fFormataFloat(item.fltTotal / item.fltSaldo, 2);
        cdsAux.FieldByName('VALORTOTAL').AsFloat := item.fltTotal;
        cdsAux.Post;
      end;

      FDadosAbertura.progresso.StepBy(1);
      Application.ProcessMessages;
    end;
  finally
    carregadorItens.Free;
  end;
end;

{ TCarregaItensSubstituidos }

constructor TCarregaItensSubstituidos.create(dadosAbertura: TDadosAbertura);
begin
  inherited create;

  FListaItens := TObjectList<TProduto>.Create;
  FDadosAbertura := dadosAbertura;

  pCarregaUFEmitente;
end;

destructor TCarregaItensSubstituidos.Destroy;
begin
  FListaItens.Free;
  inherited;
end;

function TCarregaItensSubstituidos.fCarregar: TObjectList<TProduto>;
  var
    qryAux: TUniQuery;
    produto: TProduto;
begin
  Result := FListaItens;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQL;
      ParamByName('CODEMP').AsString := FDadosAbertura.strCodigoEmpresa;
      ParamByName('ESTADO').AsString := FUFEmitente;
      Open;

      First;
      while not Eof do
      begin
        produto := TProduto.Create;
        produto.strCodigo := FieldByName('CODITE').AsString;
        produto.strDescricao := FieldByName('DESITE').AsString;
        produto.strUnidade := FieldByName('UNIDADE').AsString;
        produto.fltAliquotaST := FieldByName('ALQ_ST').AsFloat;
        produto.fltSaldo := FieldByName('SALDOS').AsFloat;
        produto.fltPreco := FieldByName('PRECO').AsFloat;
        produto.pSetTotal; //saldo * preco, carregando var FTotal
        FListaItens.Add(produto);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TCarregaItensSubstituidos.fOrdenalistaCodigo: IComparer<TProduto>;
  Var
    criterioComparacao: TComparison<TProduto>;
begin
  criterioComparacao := function(const L: TProduto; const R: TProduto): Integer
                        begin
                          Result := CompareText(L.strCodigo, R.strCodigo);
                        end;

  Result := TComparer<TProduto>.Construct(criterioComparacao);
end;

function TCarregaItensSubstituidos.fRetSQL: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  C.ITE_CODITE AS CODITE, ';
  Result := Result + '  C.ITE_DESITE AS DESITE, ';
  Result := Result + '  UNI_SIGUNI AS UNIDADE, ';
  Result := Result + '  ABF_ALQICM_SAI_NCO AS ALQ_ST, ';
  Result := Result + '  INV.ITE_SALDOS AS SALDOS, ';
  Result := Result +  fPreInv('INV', 'I', '') + ' AS PRECO ';

  Result := Result + 'FROM ';
  Result := Result + fRetTabelaInventario + ' INV ';

  Result := Result + '  LEFT JOIN CADITE C ';
  Result := Result + '    ON C.ITE_CODITE = INV.ITE_CODITE ';

  Result := Result + '  LEFT JOIN ITEGER I ';
  Result := Result + '    ON I.ITE_CODITE = C.ITE_CODITE ';
  Result := Result + '    AND I.ITE_CODEMP = INV.ITE_CODEMP ';

  Result := Result + '  LEFT JOIN CADUNI ';
  Result := Result + '    ON UNI_CODUNI = C.ITE_UNICOM ';

  Result := Result + '  LEFT JOIN ABFICM ';

  if fCfgSis('TIPABF') = '1' then
    Result := Result + '  ON ABF_CODABF = C.ITE_CODABF ' //PELO CADITE QUANDO FOR GERAL
  else
    Result := Result + '  ON ABF_CODABF = I.ITE_CODABF '; //PELO ITEGER QUANDO FOR POR LOJA

  Result := Result + '    AND ABF_ESTADO = :ESTADO ';

  Result := Result + 'WHERE LOCATE(RIGHT(ABF_CODSIT_SAI_NCO, 2), ' + QuotedStr(CST_SUBSTI) + ') > 0 ';
  Result := Result + '  AND INV.ITE_SALDOS > 0 ';
  Result := Result + '  AND INV.ITE_CODEMP = :CODEMP ';

  if not fEmptyStr(FDadosAbertura.fRetCodIteSelecionadoConcatenado) then
    Result := Result + ' AND LOCATE(INV.ITE_CODITE, ' + QuotedStr(FDadosAbertura.fRetCodIteSelecionadoConcatenado) + ') > 0 ';
end;

function TCarregaItensSubstituidos.fRetTabelaInventario: string;
  var
    dataInventario: TDateTime;
    ano, mes: string;
begin
  //retorna a data de inventário do mês passado, para somar as compras e subtratir as vendas
  dataInventario := IncMonth(FDadosAbertura.dtaDataFinal, -1);
  ano := FormatDateTime('yyyy', dataInventario);
  mes := FormatDateTime('mm', dataInventario);

  Result := 'I_' + ano + mes;
end;

procedure TCarregaItensSubstituidos.pCarregaUFEmitente;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT CID_ESTADO FROM CADEMP LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID WHERE EMP_CODEMP = :CODEMP ';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      FUFEmitente := FieldByName('CID_ESTADO').AsString;
    end;
  finally
    qryAux.Free;
  end;
end;

end.
