unit untTCat42;

interface

uses untTDadosAberturaExportacaoCat42,
     System.Generics.Collections,
     untTControleEstoqueCat42,
     untTItemNotaUtilizadoCat,
     untTRepositorioCat42,
     untTItemNotaFiscal,
     untTUtilidadeCat42,
     UniClientDataSet,
     untTEstoqueCat42,
     untTRegistroCat,
     untTypesSistema,
     untTNotaFiscal,
     System.Math,
     SysUtils,
     Dialogs,
     Classes,
     Forms,
     Uni;

type
  TCat42 = class
  private
    FListaDadosEstoque: TObjectList<TEstoqueCat42>;
    FAbertura: TDadosAberturaExportacaoCat42;
    FControleEstoque: TControleEstoqueCat42;
    FUtilidadeCat42: TUtilidadeCat42;
    FRepositorio: TRepositorioCat42;
    FStlEnquadramento: TStringList;

    FUnitarioIcmsCompra: double;
    FCstUnitoIcmsCompra: double;
    FExtUnitoIcmsCompra: double;
    FVIcmsSubstitutoCom: double;
    FArrayUntIcmsCompra: Array of Double;

    FEnquadramentos: string;
    FCampo23: double;

    function fCarregaEnquadramentos(stlEnquadramento: TStringList): string;

    function fRetCampo15(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo16(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo17(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo18(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo19(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
    function fRetCampo20(strEnquadramento: string; fltVlrConVenda: double; fltAliqIcms: double): double;
    function fRetCampo21(strEnquadramento: string; fltQtdVendida, fltIcmsUnitarioCompra: double): double;
    function fRetCampo25(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada, fltValorCampo20, fltValorCampo21: double; strCfop: string): double;
    function fRetCampo26(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada, fltValorCampo20: double; strCfop: string): double;
    function fRetCampo27(strEnquadramento: string; fltValorCampo21: double; strCfop: string): double;

    procedure pCarregaCdsDadosDevolucaoEntrada(var intContador: integer; cdsDados, cdsDadosContabil: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCarregaCdsDadosDevolucaoSaida(var intContador: integer; cdsDados: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCarregaCdsDadosEntradas(intContador: integer; cdsDados: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);
    procedure pCarregaCdsDadosSaidas(intContador: integer; cdsDados, cdsDadosContabil: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);

    procedure pLimpaArray(arrayIcmsCompra: array of Double);
  public
    function fCarregaDadosControleEstoque(cdsDados, cdsDadosContabil: TUniClientDataSet): boolean;

    procedure pGravarDados(cdsDados: TUniClientDataSet);
    procedure pDeletaSemFiltro;

    constructor Create(abertura: TDadosAberturaExportacaoCat42; arrProduto: TConsultasArray; stlEnquadramento: TStringList; arrLinhaGrupo: TConsultasArray; blnCarregaEnqd: boolean = True);
    destructor Destroy; override;
  end;

implementation

uses untTValidacaoSaldoCat42Factory,
     untTValidacaoSaldoTotalCat42,
     untFuncoes,
     untTipo;

{ TCat42 }

constructor TCat42.Create(abertura: TDadosAberturaExportacaoCat42; arrProduto: TConsultasArray; stlEnquadramento: TStringList; arrLinhaGrupo: TConsultasArray; blnCarregaEnqd: boolean = True);
begin
  inherited create;

  FRepositorio := TRepositorioCat42.Create(abertura, FStlEnquadramento);
  FStlEnquadramento := stlEnquadramento;
  FUnitarioIcmsCompra := 0;
  FCstUnitoIcmsCompra := 0;
  FExtUnitoIcmsCompra := 0;
  FVIcmsSubstitutoCom := 0;
  FAbertura := abertura;

  if blnCarregaEnqd then
    FEnquadramentos := fCarregaEnquadramentos(FStlEnquadramento);

  FUtilidadeCat42 := TUtilidadeCat42.Create;
  FControleEstoque := TControleEstoqueCat42.create(FAbertura, arrProduto, FStlEnquadramento, arrLinhaGrupo);
end;

destructor TCat42.Destroy;
begin
  FControleEstoque.Free;
  FRepositorio.Free;
  FUtilidadeCat42.Free;

  inherited;
end;

function TCat42.fCarregaDadosControleEstoque(cdsDados, cdsDadosContabil: TUniClientDataSet): boolean;
  var
    validadorSaldo: TValidacaoSaldoTotalCat42;
    registroCat: TRegistroCat;
    estoque: TEstoqueCat42;
    intContador: integer;
begin
  //carrega o saldo de estoque e a movimentação do mês em questão: entradas, devoluções e saídas
  FListaDadosEstoque := FControleEstoque.fCarregaDados;

  //objeto que atribuiu false para geração dos produtos com saldo total negativo quando solicitado por config
  if (FAbertura.tipoConferencia = tccSim) or (FAbertura.tipoConferencia = tccConf) then
  begin
    validadorSaldo := TValidacaoSaldoCat42Factory.fRetValidacaoSaldo(FListaDadosEstoque, FAbertura, FAbertura.tipoConferencia);
    try
      if Assigned(validadorSaldo) then
        validadorSaldo.pValidarSaldoTotal;
    finally
      if Assigned(validadorSaldo) then
        validadorSaldo.Free;
    end;
  end;

  FAbertura.lblOperacao.Caption := 'Gerando relatório...';
  FAbertura.lblOperacao.Visible := True;
  FAbertura.progressoTela.Max := FListaDadosEstoque.Count;
  FAbertura.progressoTela.Position := 0;
  Application.ProcessMessages;

  for estoque in FListaDadosEstoque do
  begin
    intContador := 1;

    FCampo23 := 0;

    if estoque.blnEnviaMovimentacao then
    begin
      cdsDados.Append;
      cdsDados.FieldByName('MERCADORIA').AsString := estoque.strProduto + ' - ' + estoque.strDescricaoProduto;
      cdsDados.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
      cdsDados.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
      cdsDados.FieldByName('UNIDADE').AsString := estoque.strUnidade;
      cdsDados.FieldByName('CODITE').AsString := estoque.strProduto;

      //Retorna a alíquota do ICMS do produto. Ricardo Lima - 21/06/2016
      cdsDados.FieldByName('ALIQUOTA').AsFloat := FUtilidadeCat42.fRetAliquotaICMS(FAbertura.empresa.strCodigo, estoque.strProduto);

      cdsDados.FieldByName('CAMPO01').AsInteger := intContador;
      cdsDados.FieldByName('CAMPO22').AsFloat := estoque.fltQtdFinal;
      cdsDados.FieldByName('CAMPO23').AsFloat := IIF((estoque.fltSaldoFinal > 0) and (estoque.fltQtdFinal > 0), estoque.fltSaldoFinal / estoque.fltQtdFinal, 0);
      cdsDados.FieldByName('CAMPO24').AsFloat := estoque.fltSaldoFinal;
      cdsDados.Post;

      if (Assigned(estoque.listaRegistroCat)) then
      begin
        //carrega o icms unitario da ultima compra do produto, para calculo do campo21 nos registros de saída
        //# FUnitarioIcmsCompra := estoque.fCarregaIcmsUnitarioCompra(FAbertura)[0];

        Setlength(FArrayUntIcmsCompra, 4);
        estoque.fCarregaIcmsUnitarioCompra(FAbertura, FArrayUntIcmsCompra);
        FUnitarioIcmsCompra := FArrayUntIcmsCompra[0]; // VALOR_ICMS_UNIT (untTEstoqueCat42:fCarregaIcmsUnitarioCompra)
        FCstUnitoIcmsCompra := FArrayUntIcmsCompra[1]; // DET_CODFIS (untTEstoqueCat42:fCarregaIcmsUnitarioCompra)
        FExtUnitoIcmsCompra := FArrayUntIcmsCompra[2]; // CASO NÃO ENCONTRE NOTA DE ENTRADA NA BUSCA DO ICMS UNITÁRIO
        FVIcmsSubstitutoCom := FArrayUntIcmsCompra[3]; // DETELE IF(DET_QTDITE > 0, (IFNULL(DLE.N27_VICMSSUBSTITUTO, 0) / DET_QTDITE), 0) AS VL_ICMS_SUBSTITUTO
        pLimpaArray(FArrayUntIcmsCompra);
        FArrayUntIcmsCompra := nil;

        //ordena a lista por cfop e data, para aparecer primeiro as compras, depois as devoluções e por ultimo as vendas.
        estoque.listaRegistroCat.Sort(estoque.fOrdenaListaDataCfop);

        for registroCat in estoque.listaRegistroCat do
        begin
          intContador := intContador + 1;

          if Pos(registroCat.itemNota.strCfop, VS_strClaDev) > 0 then
          begin
            if StrToInt(registroCat.itemNota.strCfop) > 5000 then
              pCarregaCdsDadosDevolucaoEntrada(intContador, cdsDados, cdsDadosContabil, estoque, registroCat)
            else
              pCarregaCdsDadosDevolucaoSaida(intContador, cdsDados, estoque, registroCat);
          end
          else if StrToInt(registroCat.itemNota.strCfop) > 5000 then
            pCarregaCdsDadosSaidas(intContador, cdsDados, cdsDadosContabil, estoque, registroCat)
          else
            pCarregaCdsDadosEntradas(intContador, cdsDados, estoque, registroCat);
        end;
      end;

    end;

    FAbertura.progressoTela.StepBy(1);
    Application.ProcessMessages;

  end;

  Result := cdsDados.RecordCount > 0;
end;

function TCat42.fCarregaEnquadramentos(stlEnquadramento: TStringList): string;
  var
    intContador: integer;
begin
  Result := '';

  for intContador := 0 to stlEnquadramento.Count - 1 do
  begin
    Result := Result + stlEnquadramento[intContador] + '_';
  end;
end;

function TCat42.fRetCampo15(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "1", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '1' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TCat42.fRetCampo16(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "2", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '2' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TCat42.fRetCampo17(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;

begin
  //se o enquadramento for igual a "3", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '3' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TCat42.fRetCampo18(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;

begin
  //se o enquadramento for igual a "4", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '4' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TCat42.fRetCampo19(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada: double): double;
begin
  //se o enquadramento for igual a "1", resultado = quantidade vendida * ST unitário ñ creditado da compra
  Result := 0;

  if strEnquadramento = '0' then
    Result := fltQtdVendida * fltStUnitariaComprada;
end;

function TCat42.fRetCampo20(strEnquadramento: string; fltVlrConVenda: double; fltAliqIcms: double): double;
begin
  //se o enquadramento for 1 ou 3, o mesmo deve calcular o vlrcon da Venda * alq interna do estado / 100;  ex:((100,00 * 18) / 100)
  Result := 0;

  //fltAliqIcms traz a porcentagem da alíquota a ser calculada. Ricardo Lima - 18/06/2019

  if Pos(strEnquadramento, '1_3') > 0 then
    Result := (fltVlrConVenda * fltAliqIcms) / 100;
end;

function TCat42.fRetCampo21(strEnquadramento: string; fltQtdVendida, fltIcmsUnitarioCompra: double): double;
begin
  Result := 0;

  if Pos(strEnquadramento, '1_2_4') > 0 then
    Result := fTrunca(fltQtdVendida * fltIcmsUnitarioCompra, 2);
end;

function TCat42.fRetCampo25(strEnquadramento: string; fltQtdVendida, fltStUnitariaComprada,
  fltValorCampo20, fltValorCampo21: double; strCfop: string): double;
begin
  Result := 0;

  if Pos(strEnquadramento, '1_3') > 0 then
  begin

    (* Requisito 186297 ver com o André - Clientes reclamando
    if Pos(strEnquadramento, '1') > 0 then
    begin
      if fltValorCampo20 - (fltQtdVendida * fltStUnitariaComprada) > 0 then
        Result := fltValorCampo20 - (fltQtdVendida * fltStUnitariaComprada);
    end else
    begin if (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo20 > 0 then
        Result := (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo20;
    end;*)

    //requisito de reverte observação: voltei ao que era antes referente ao requisito 186297
    if (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo20 > 0 then
      Result := (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo20;
  end
  else if Pos(strEnquadramento, '2_4') > 0 then
  begin
    if (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo21 > 0 then
      Result := (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo21
    else
    begin
      if (strCfop = '2') then
        Result := (fltQtdVendida * fltStUnitariaComprada) - fltValorCampo21;
    end
  end
end;

function TCat42.fRetCampo26(strEnquadramento: string; fltQtdVendida,
  fltStUnitariaComprada, fltValorCampo20: double; strCfop: string): double;
begin
  Result := 0;

  if strEnquadramento = '1' then
  begin
    if fltValorCampo20 - (fltQtdVendida * fltStUnitariaComprada) > 0 then
      Result := fltValorCampo20 - (fltQtdVendida * fltStUnitariaComprada)
    else
    begin
      if (strCfop = '2') then
        Result := fltValorCampo20 - (fltQtdVendida * fltStUnitariaComprada);
    end;
  end
end;

function TCat42.fRetCampo27(strEnquadramento: string; fltValorCampo21: double; strCfop: string): double;
begin
  Result := 0;

  if strEnquadramento = '4' then
    Result := fltValorCampo21
end;

procedure TCat42.pCarregaCdsDadosDevolucaoEntrada(var intContador: integer; cdsDados, cdsDadosContabil: TUniClientDataSet; estoque: TEstoqueCat42;
  registroCat: TRegistroCat);

  var
    fltAliqICMS: double;
begin
  //caso não tenha sido feito compras no nês, o mesmo deve capturar a aliquota pelo estoque
  if FCampo23 = 0 then
    FCampo23 := IIF((estoque.fltSaldoFinal > 0) and (estoque.fltQtdFinal > 0), estoque.fltSaldoFinal / estoque.fltQtdFinal, 0);

  //inicio
  cdsDadosContabil.Open;

  if cdsDadosContabil.Locate('CFOP', registroCat.itemNota.strCfop, []) then
    cdsDadosContabil.Edit
  Else cdsDadosContabil.Append;

  cdsDadosContabil.FieldByName('VALORCONTABIL').AsFloat  := cdsDadosContabil.FieldByName('VALORCONTABIL').AsFloat+registroCat.itemNota.fltValorContabil;
  cdsDadosContabil.FieldByName('ENQUADRAMENTO').AsString := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, FCampo23, 0);
  cdsDadosContabil.FieldByName('CFOP').AsString          := registroCat.itemNota.strCfop;
  cdsDadosContabil.Post;
  cdsDadosContabil.Close;
  //fim

  //Retorna a alíquota do ICMS do produto. Ricardo - 21/06/2019
  fltAliqICMS := FUtilidadeCat42.fRetAliquotaICMS(FAbertura.empresa.strCodigo, registroCat.itemNota.strCodIte);

  //quantidade anterior - quantidade vendida(Campo13)
  estoque.fltQtdFinal := estoque.fltQtdFinal - registroCat.itemNota.fltQuantidade;
  //saldo anterior - quantidade vendida * St unitário da compra, presentes nos campos: 15,16,17,18 e 19
  estoque.fltSaldoFinal := estoque.fltSaldoFinal - (registroCat.itemNota.fltQuantidade * FCampo23);

  cdsDados.Append;
  //DADOS CABEÇALHO
  cdsDados.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
  cdsDados.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
  cdsDados.FieldByName('MERCADORIA').AsString := registroCat.itemNota.strCodIte + ' - ' + registroCat.itemNota.strDesIte;
  cdsDados.FieldByName('CODITE').AsString := registroCat.itemNota.strCodIte;
  cdsDados.FieldByName('UNIDADE').AsString := registroCat.itemNota.strUnidade;
  cdsDados.FieldByName('ALIQUOTA').AsFloat := fltAliqICMS;
  cdsDados.FieldByName('VALORCONTABIL').AsFloat := registroCat.itemNota.fltValorContabil;

  //DADOS GERAIS DA NOTA DE VENDA
  cdsDados.FieldByName('CAMPO01').AsInteger := intContador;
  cdsDados.FieldByName('CAMPO02').AsString := FormatDateTime('DD/MM/YYYY', registroCat.itemNota.dtaDtaEnt);
  cdsDados.FieldByName('CAMPO03').AsString := registroCat.itemNota.strChaveAcesso;
  cdsDados.FieldByName('CAMPO04').AsString := '';
  cdsDados.FieldByName('CAMPO05').AsString := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),'E','E'); {(*)para identificar se existi nota fiscal referenciada}
  cdsDados.FieldByName('CAMPO06').AsString := registroCat.itemNota.strSerie;
  cdsDados.FieldByName('CAMPO07').AsString := registroCat.itemNota.strNumDoc;
  cdsDados.FieldByName('CAMPO08').AsString := registroCat.itemNota.participante.strCodigo;
  cdsDados.FieldByName('CAMPO09').AsString := registroCat.itemNota.strCfop;
  cdsDados.FieldByName('CAMPO10').AsString := '1';
  cdsDados.FieldByName('CAMPO11').AsFloat := registroCat.itemNota.fltQuantidade * (-1);
  cdsDados.FieldByName('CAMPO12').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), registroCat.itemNota.fltQuantidade * FCampo23 * (-1),0);
  cdsDados.FieldByName('CAMPO13').AsFloat := 0;
  cdsDados.FieldByName('CAMPO14').AsFloat := 0;

  //ENQUADRAMENTOS DO ICMS ST
  cdsDados.FieldByName('CAMPO15').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);
  cdsDados.FieldByName('CAMPO16').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);
  cdsDados.FieldByName('CAMPO17').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);
  cdsDados.FieldByName('CAMPO18').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);
  cdsDados.FieldByName('CAMPO19').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);

  //VALORES DE CONFRONTO
  cdsDados.FieldByName('CAMPO20').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);
  cdsDados.FieldByName('CAMPO21').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), 0,0);

  //DADOS TOTAIS DO ESTOQUE
  cdsDados.FieldByName('CAMPO22').AsFloat := estoque.fltQtdFinal;
  cdsDados.FieldByName('CAMPO23').AsFloat := FCampo23;
  cdsDados.FieldByName('CAMPO24').AsFloat := estoque.fltSaldoFinal;

  //APURAÇÃO
  cdsDados.FieldByName('CAMPO25').AsFloat := 0;
  cdsDados.FieldByName('CAMPO26').AsFloat := 0;
  cdsDados.FieldByName('CAMPO27').AsFloat := 0;

  cdsDados.FieldByName('INCVEN').AsString := '';

  cdsDados.Post;
end;

procedure TCat42.pCarregaCdsDadosDevolucaoSaida(var intContador: integer; cdsDados: TUniClientDataSet; estoque: TEstoqueCat42;
  registroCat: TRegistroCat);
var
  fltAliqICMS: double;
begin
  //caso não tenha sido feito compras no nês, o mesmo deve capturar a aliquota pelo estoque
  if FCampo23 = 0 then
    FCampo23 := IIF((estoque.fltSaldoFinal > 0) and (estoque.fltQtdFinal > 0), estoque.fltSaldoFinal / estoque.fltQtdFinal, 0);

  //Retorna a alíquota do ICMS do produto. Ricardo - 21/06/2019
  fltAliqICMS := FUtilidadeCat42.fRetAliquotaICMS(FAbertura.empresa.strCodigo, registroCat.itemNota.strCodIte);

  //quantidade anterior + quantidade vendida(Campo13)
  estoque.fltQtdFinal := estoque.fltQtdFinal + registroCat.itemNota.fltQuantidade;
  //saldo anterior + quantidade vendida * St unitário da compra, presentes nos campos: 15,16,17,18 e 19
  estoque.fltSaldoFinal := estoque.fltSaldoFinal + (registroCat.itemNota.fltQuantidade * FCampo23);

  cdsDados.Append;
  //DADOS CABEÇALHO
  cdsDados.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
  cdsDados.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
  cdsDados.FieldByName('MERCADORIA').AsString := registroCat.itemNota.strCodIte + ' - ' + registroCat.itemNota.strDesIte;
  cdsDados.FieldByName('CODITE').AsString := registroCat.itemNota.strCodIte;
  cdsDados.FieldByName('UNIDADE').AsString := registroCat.itemNota.strUnidade;
  cdsDados.FieldByName('ALIQUOTA').AsFloat := fltAliqICMS;

  //DADOS GERAIS DA NOTA DE VENDA
  cdsDados.FieldByName('CAMPO01').AsInteger := intContador;
  cdsDados.FieldByName('CAMPO02').AsString := FormatDateTime('DD/MM/YYYY', registroCat.itemNota.dtaDtaEnt);
  cdsDados.FieldByName('CAMPO03').AsString := registroCat.itemNota.strChaveAcesso;
  cdsDados.FieldByName('CAMPO04').AsString := '';
  cdsDados.FieldByName('CAMPO05').AsString := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),'E','E'); {(*)para identificar se existi nota fiscal referenciada}
  cdsDados.FieldByName('CAMPO06').AsString := registroCat.itemNota.strSerie;
  cdsDados.FieldByName('CAMPO07').AsString := registroCat.itemNota.strNumDoc;
  cdsDados.FieldByName('CAMPO08').AsString := registroCat.itemNota.participante.strCodigo;
  cdsDados.FieldByName('CAMPO09').AsString := registroCat.itemNota.strCfop;
  cdsDados.FieldByName('CAMPO10').AsString := '1';
  cdsDados.FieldByName('CAMPO11').AsFloat := 0;
  cdsDados.FieldByName('CAMPO12').AsFloat := 0;
  cdsDados.FieldByName('CAMPO13').AsFloat := registroCat.itemNota.fltQuantidade * (-1);

  //# cdsDados.FieldByName('CAMPO14').AsFloat := 0;
  cdsDados.FieldByName('CAMPO14').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, FCampo23, 0) * (-1), 0) ;

  //ENQUADRAMENTOS DO ICMS ST
  cdsDados.FieldByName('CAMPO15').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo15(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23) * (-1), 0),0);
  cdsDados.FieldByName('CAMPO16').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo16(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23) * (-1), 0),0);
  cdsDados.FieldByName('CAMPO17').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo17(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23) * (-1), 0),0);
  cdsDados.FieldByName('CAMPO18').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo18(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23) * (-1), 0),0);
  cdsDados.FieldByName('CAMPO19').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo19(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23) * (-1), 0),0);

  //VALORES DE CONFRONTO
  cdsDados.FieldByName('CAMPO20').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
    IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fRetCampo20(registroCat.strEnquadramento, registroCat.itemNota.fltValorContabil, fltAliqICMS) * (-1), 0),0);
  cdsDados.FieldByName('CAMPO21').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
                                                     IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                             fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade,
                                                               IIF(FUnitarioIcmsCompra > 0, FUnitarioIcmsCompra, estoque.fltVlrIcmsUnitario)), 0) * (-1),0);

  //DADOS TOTAIS DO ESTOQUE
  cdsDados.FieldByName('CAMPO22').AsFloat := estoque.fltQtdFinal;
  cdsDados.FieldByName('CAMPO23').AsFloat := FCampo23;
  cdsDados.FieldByName('CAMPO24').AsFloat := estoque.fltSaldoFinal;

  //APURAÇÃO
  if (Copy(registroCat.itemNota.strCfop, 0, 1) <> '2') then
  begin
    cdsDados.FieldByName('CAMPO25').AsFloat := 0;
    cdsDados.FieldByName('CAMPO26').AsFloat := 0;
    cdsDados.FieldByName('CAMPO27').AsFloat := 0;
  end
  else
  begin

    (* Requisito 186297 ver com o André - Clientes reclamando
    cdsDados.FieldByName('CAMPO25').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
                                                 IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                   fFormataFloat(fRetCampo25(registroCat.strEnquadramento,
                                                                             registroCat.itemNota.fltQuantidade,
                                                                             ((FCampo23) * (-1)),
                                                                             cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                             cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                             Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0), 0);

    cdsDados.FieldByName('CAMPO26').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
                                                 IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                   fFormataFloat(fRetCampo26(registroCat.strEnquadramento,
                                                                             registroCat.itemNota.fltQuantidade,
                                                                             ((FCampo23) * (-1)),
                                                                             cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                             Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0), 0);

    cdsDados.FieldByName('CAMPO27').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev),
                                                 IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                   fFormataFloat(fRetCampo27(registroCat.strEnquadramento,
                                                                             cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                             Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0), 0);*)

    //requisito de reverte observação: voltei ao que era antes referente ao requisito 186297
    cdsDados.FieldByName('CAMPO25').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                                                              fFormataFloat(fRetCampo25(registroCat.strEnquadramento,
                                                                                              registroCat.itemNota.fltQuantidade,
                                                                                              ((FCampo23) * (-1)),
                                                                                              cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                              cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                              Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0), 0);

    cdsDados.FieldByName('CAMPO26').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                                                              fFormataFloat(fRetCampo26(registroCat.strEnquadramento,
                                                                                              registroCat.itemNota.fltQuantidade,
                                                                                              ((FCampo23) * (-1)),
                                                                                              cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                              Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0), 0);

    if (StrToInt(registroCat.itemNota.strCfop) > 6000) and (registroCat.strEnquadramento = '4') and (estoque.strCodSitPrimDg = '1') then
      cdsDados.FieldByName('CAMPO27').AsFloat := 0
    else
    begin
      cdsDados.FieldByName('CAMPO27').AsFloat := IIF(not fEmptyStr(registroCat.itemNota.strDocDev), IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                                                                fFormataFloat(fRetCampo27(registroCat.strEnquadramento,
                                                                                                cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                                Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0), 0);

      if (cdsDados.FieldByName('CAMPO27').AsFloat > 0) and (FVIcmsSubstitutoCom > 0) then
        cdsDados.FieldByName('CAMPO27').AsFloat := FVIcmsSubstitutoCom;
    end;
  end;

  cdsDados.FieldByName('INCVEN').AsString := '';
  cdsDados.Post;
end;

procedure TCat42.pCarregaCdsDadosEntradas(intContador: integer; cdsDados: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);
begin
  //quantidade anterior + quantidade comprada(campo11)
  estoque.fltQtdFinal := estoque.fltQtdFinal + registroCat.itemNota.fltQuantidade;
  //saldo anterior + valor total do icms st(campo12)
  estoque.fltSaldoFinal := estoque.fltSaldoFinal + registroCat.itemNota.fltValorRetidoNaoCreditado;

  cdsDados.Append;
  //DADOS CABEÇALHO
  cdsDados.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
  cdsDados.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
  cdsDados.FieldByName('MERCADORIA').AsString := registroCat.itemNota.strCodIte + ' - ' + registroCat.itemNota.strDesIte;
  cdsDados.FieldByName('CODITE').AsString := registroCat.itemNota.strCodIte;
  cdsDados.FieldByName('UNIDADE').AsString := registroCat.itemNota.strUnidade;
  cdsDados.FieldByName('ALIQUOTA').AsFloat := 18;

  //DADOS GERAIS DA NOTA DE COMPRA
  cdsDados.FieldByName('CAMPO01').AsInteger := intContador;
  cdsDados.FieldByName('CAMPO02').AsString := FormatDateTime('DD/MM/YYYY', registroCat.itemNota.dtaDtaEnt);
  cdsDados.FieldByName('CAMPO03').AsString := registroCat.itemNota.strChaveAcesso;
  cdsDados.FieldByName('CAMPO04').AsString := '';
  cdsDados.FieldByName('CAMPO05').AsString := 'E';
  cdsDados.FieldByName('CAMPO06').AsString := registroCat.itemNota.strSerie;
  cdsDados.FieldByName('CAMPO07').AsString := registroCat.itemNota.strNumDoc;
  cdsDados.FieldByName('CAMPO08').AsString := registroCat.itemNota.participante.strCodigo;
  cdsDados.FieldByName('CAMPO09').AsString := registroCat.itemNota.strCfop;
  cdsDados.FieldByName('CAMPO10').AsString := '1';
  cdsDados.FieldByName('CAMPO11').AsFloat := registroCat.itemNota.fltQuantidade;
  cdsDados.FieldByName('CAMPO12').AsFloat := registroCat.itemNota.fltValorRetidoNaoCreditado;
  cdsDados.FieldByName('CAMPO13').AsFloat := 0;
  cdsDados.FieldByName('CAMPO14').AsFloat := 0;
  cdsDados.FieldByName('CAMPO15').AsFloat := 0;
  cdsDados.FieldByName('CAMPO16').AsFloat := 0;
  cdsDados.FieldByName('CAMPO17').AsFloat := 0;
  cdsDados.FieldByName('CAMPO18').AsFloat := 0;
  cdsDados.FieldByName('CAMPO19').AsFloat := 0;
  cdsDados.FieldByName('CAMPO20').AsFloat := 0;
  cdsDados.FieldByName('CAMPO21').AsFloat := 0;

  FCampo23 := IIF((estoque.fltSaldoFinal > 0) and (estoque.fltQtdFinal > 0), estoque.fltSaldoFinal / estoque.fltQtdFinal, 0);

  //DADOS TOTAIS DO ESTOQUE
  cdsDados.FieldByName('CAMPO22').AsFloat := estoque.fltQtdFinal;
  cdsDados.FieldByName('CAMPO23').AsFloat := estoque.fltSaldoFinal / estoque.fltQtdFinal;
  cdsDados.FieldByName('CAMPO24').AsFloat := estoque.fltSaldoFinal;

  //APURAÇÃO
  cdsDados.FieldByName('CAMPO25').AsFloat := 0;
  cdsDados.FieldByName('CAMPO26').AsFloat := 0;
  cdsDados.FieldByName('CAMPO27').AsFloat := 0;

  cdsDados.FieldByName('INCVEN').AsString := '';
  cdsDados.Post;
end;

procedure TCat42.pCarregaCdsDadosSaidas(intContador: integer; cdsDados, cdsDadosContabil: TUniClientDataSet; estoque: TEstoqueCat42; registroCat: TRegistroCat);
  var
    fltAliqICMS,
    fltCampo15,
    fltCampo16,
    fltCampo17,
    fltCampo18,
    fltCampo19,
    fltCampo21,
    fltCampo21RetCond: double;

begin
  //caso não tenha sido feito compras no nês, o mesmo deve capturar a aliquota pelo estoque
  if FCampo23 = 0 then
    FCampo23 := IIF((estoque.fltSaldoFinal > 0) and (estoque.fltQtdFinal > 0), estoque.fltSaldoFinal / estoque.fltQtdFinal, 0);

  if Pos(registroCat.strEnquadramento, FEnquadramentos) > 0 then
  begin
    cdsDadosContabil.Open;

    if cdsDadosContabil.Locate('CFOP', registroCat.itemNota.strCfop, []) then
      cdsDadosContabil.Edit
    Else cdsDadosContabil.Append;

    cdsDadosContabil.FieldByName('VALORCONTABIL').AsFloat  := cdsDadosContabil.FieldByName('VALORCONTABIL').AsFloat + registroCat.itemNota.fltValorContabil;
    cdsDadosContabil.FieldByName('ENQUADRAMENTO').AsString := registroCat.strEnquadramento;
    cdsDadosContabil.FieldByName('CFOP').AsString          := registroCat.itemNota.strCfop;
    cdsDadosContabil.Post;
    cdsDadosContabil.Close;
  end;

  //Retorna a alíquota do ICMS do produto. Ricardo - 21/06/2016
  fltAliqICMS := FUtilidadeCat42.fRetAliquotaICMS(FAbertura.empresa.strCodigo, registroCat.itemNota.strCodIte);

  fltCampo15 := fRetCampo15(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo16 := fRetCampo16(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo17 := fRetCampo17(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo18 := fRetCampo18(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);
  fltCampo19 := fRetCampo19(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FCampo23);

  //## inicio ******************************************************************************** CAT42
  {fltCampo21 := IIF(((FCstUnitoIcmsCompra = 30) or (FExtUnitoIcmsCompra = 0)), 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                    fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, IIF(FUnitarioIcmsCompra > 0, FUnitarioIcmsCompra, estoque.fltVlrIcmsUnitario)), 0));}

  if (FExtUnitoIcmsCompra > 0) then
  begin
    if (FCstUnitoIcmsCompra = 30) then
    begin
      if (FUnitarioIcmsCompra > 0) then
        fltCampo21RetCond := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
          fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, FUnitarioIcmsCompra), 0)
      else
        fltCampo21RetCond := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
          fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, estoque.fltVlrIcmsUnitario), 0)
    end else
      fltCampo21RetCond := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
        fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, IIF(FUnitarioIcmsCompra > 0, FUnitarioIcmsCompra, estoque.fltVlrIcmsUnitario)), 0)
  end else
    fltCampo21RetCond := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
      fRetCampo21(registroCat.strEnquadramento, registroCat.itemNota.fltQuantidade, estoque.fltVlrIcmsUnitario), 0);

  fltCampo21 := fltCampo21RetCond;
  //## fim *****************************************************************************************

  //quantidade anterior - quantidade vendida(Campo13)
  estoque.fltQtdFinal := estoque.fltQtdFinal - registroCat.itemNota.fltQuantidade;
  //saldo anterior - quantidade vendida * St unitário da compra, presentes nos campos: 15,16,17,18 e 19
  estoque.fltSaldoFinal := estoque.fltSaldoFinal - fltCampo15 - fltCampo16 - fltCampo17 - fltCampo18 - fltCampo19;

  //DADOS CABEÇALHO
  cdsDados.Append;
  cdsDados.FieldByName('NOMEMP').AsString := FAbertura.empresa.strRazaoSocial;
  cdsDados.FieldByName('IES').AsString := fRetornaIESformatada(FAbertura.empresa.strInscricaoEstadual, 'SP');
  cdsDados.FieldByName('MERCADORIA').AsString := registroCat.itemNota.strCodIte + ' - ' + registroCat.itemNota.strDesIte;
  cdsDados.FieldByName('CODITE').AsString := registroCat.itemNota.strCodIte;
  cdsDados.FieldByName('UNIDADE').AsString := registroCat.itemNota.strUnidade;
  cdsDados.FieldByName('ALIQUOTA').AsFloat := fltAliqICMS;
  cdsDados.FieldByName('VALORCONTABIL').AsFloat := registroCat.itemNota.fltValorContabil;

  //DADOS GERAIS DA NOTA DE VENDA
  cdsDados.FieldByName('CAMPO01').AsInteger := intContador;
  cdsDados.FieldByName('CAMPO02').AsString := FormatDateTime('DD/MM/YYYY', registroCat.itemNota.dtaDtaEnt);
  cdsDados.FieldByName('CAMPO03').AsString := registroCat.itemNota.strChaveAcesso;
  cdsDados.FieldByName('CAMPO04').AsString := '';
  cdsDados.FieldByName('CAMPO05').AsString := 'S';
  cdsDados.FieldByName('CAMPO06').AsString := registroCat.itemNota.strSerie;
  cdsDados.FieldByName('CAMPO07').AsString := registroCat.itemNota.strNumDoc;
  cdsDados.FieldByName('CAMPO08').AsString := registroCat.itemNota.participante.strCodigo;
  cdsDados.FieldByName('CAMPO09').AsString := registroCat.itemNota.strCfop;
  cdsDados.FieldByName('CAMPO10').AsString := '1';
  cdsDados.FieldByName('CAMPO11').AsFloat := 0;
  cdsDados.FieldByName('CAMPO12').AsFloat := 0;
  cdsDados.FieldByName('CAMPO13').AsFloat := registroCat.itemNota.fltQuantidade;
  //se o enquadramento capturado não foi marcado, o mesmo enviará zero, apenas computará o saldo
  cdsDados.FieldByName('CAMPO14').AsFloat := IIF(fltCampo21 = 0, 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, FCampo23, 0));

  //ENQUADRAMENTOS DO ICMS ST
  cdsDados.FieldByName('CAMPO15').AsFloat := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fltCampo15, 0);
  cdsDados.FieldByName('CAMPO16').AsFloat := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fltCampo16, 0);
  cdsDados.FieldByName('CAMPO17').AsFloat := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fltCampo17, 0);
  If FAbertura.blnUtilizarConfigCfopCstEnquadramentos then
    cdsDados.FieldByName('CAMPO18').AsFloat := IIF( fltCampo21 = 0, 0, IIF( Pos( registroCat.itemNota.strCfop, FRepositorio.fRetCfopEnquadramento('4') ) > 0, fltCampo18, 0 ))
  Else
    cdsDados.FieldByName('CAMPO18').AsFloat := IIF(fltCampo21 = 0, 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fltCampo18, 0));
  cdsDados.FieldByName('CAMPO19').AsFloat := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fltCampo19, 0);

  //VALORES DE CONFRONTO
  cdsDados.FieldByName('CAMPO20').AsFloat := IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                 fRetCampo20(registroCat.strEnquadramento, registroCat.itemNota.fltValorContabil, fltAliqICMS),
                                                 0);

  cdsDados.FieldByName('CAMPO21').AsFloat := IIF(fltCampo21 = 0, 0, fltCampo21);

  //DADOS TOTAIS DO ESTOQUE
  cdsDados.FieldByName('CAMPO22').AsFloat := estoque.fltQtdFinal;
  cdsDados.FieldByName('CAMPO23').AsFloat := FCampo23;
  cdsDados.FieldByName('CAMPO24').AsFloat := estoque.fltSaldoFinal;

  //APURAÇÃO

  (* Requisito 186297 ver com o André - Clientes reclamando
  cdsDados.FieldByName('CAMPO25').AsFloat := IIF(fltCampo21 = 0,
                                               //1 CAMPO 25
                                               IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo25(registroCat.strEnquadramento,
                                                                                                                                     registroCat.itemNota.fltQuantidade,
                                                                                                                                     FCampo23,
                                                                                                                                     cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                                                                     cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                                                                     Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0),
                                               //2 CAMPO 25
                                               IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo25(registroCat.strEnquadramento,
                                                                                                                                     registroCat.itemNota.fltQuantidade,
                                                                                                                                     FCampo23,
                                                                                                                                     cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                                                                     cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                                                                     Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0));

  cdsDados.FieldByName('CAMPO26').AsFloat := IIF(fltCampo21 = 0,
                                               //1 CAMPO 26
                                               IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo26(registroCat.strEnquadramento,
                                                                                                                                     registroCat.itemNota.fltQuantidade,
                                                                                                                                     FCampo23,
                                                                                                                                     cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                                                                     Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0),
                                               //2 CAMPO 26
                                               IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo26(registroCat.strEnquadramento,
                                                                                                                                     registroCat.itemNota.fltQuantidade,
                                                                                                                                     FCampo23,
                                                                                                                                     cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                                                                     Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0));

  cdsDados.FieldByName('CAMPO27').AsFloat := IIF(fltCampo21 = 0,
                                               0,
                                               IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo27(registroCat.strEnquadramento,
                                                                                                                                     cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                                                                     Copy(registroCat.itemNota.strCfop, 0, 1)), 2),
                                               0));*)

  //requisito de reverte observação: voltei ao que era antes referente ao requisito 186297
  cdsDados.FieldByName('CAMPO25').AsFloat := IIF(fltCampo21 = 0, 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo25(registroCat.strEnquadramento,
                                                                                             registroCat.itemNota.fltQuantidade,
                                                                                             FCampo23,
                                                                                             cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                             cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                             Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0));

  cdsDados.FieldByName('CAMPO26').AsFloat := IIF(fltCampo21 = 0, 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0, fFormataFloat(fRetCampo26(registroCat.strEnquadramento,
                                                                                             registroCat.itemNota.fltQuantidade,
                                                                                             FCampo23,
                                                                                             cdsDados.FieldByName('CAMPO20').AsFloat,
                                                                                             Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0));

  if (StrToInt(registroCat.itemNota.strCfop) > 6000) and (registroCat.strEnquadramento = '4') and (estoque.strCodSitPrimDg = '1') then
    cdsDados.FieldByName('CAMPO27').AsFloat := 0
  else
  begin
    cdsDados.FieldByName('CAMPO27').AsFloat := IIF(fltCampo21 = 0, 0, IIF(Pos(registroCat.strEnquadramento, FEnquadramentos) > 0,
                                                                                              fFormataFloat(fRetCampo27(registroCat.strEnquadramento,
                                                                                              cdsDados.FieldByName('CAMPO21').AsFloat,
                                                                                              Copy(registroCat.itemNota.strCfop, 0, 1)), 2), 0));

    if (cdsDados.FieldByName('CAMPO27').AsFloat > 0) and (FVIcmsSubstitutoCom > 0) then
      cdsDados.FieldByName('CAMPO27').AsFloat := FVIcmsSubstitutoCom;
  end;

  cdsDados.FieldByName('INCVEN').AsString := registroCat.itemNota.strAutoIncrem;
  cdsDados.Post;
end;

procedure TCat42.pDeletaSemFiltro;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM CAT_42_DADOS ';
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Text := 'DELETE FROM CAT_42_SALDOS ';
      ExecSQL;
    end;
  finally
    qryAux.Free;
  end;
end;

procedure TCat42.pGravarDados(cdsDados: TUniClientDataSet);
  var
    qryReplace: TUniQuery;
    estoque: TEstoqueCat42;
begin
  FAbertura.progressoTela.Visible := True;
  qryReplace := fCriaQuery(nil);
  try
    with qryReplace do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO CAT_42_DADOS (');
      SQL.Add(' AUTOINCREM, CAT_CAMP01, CAT_CAMP02, CAT_CAMP03, CAT_CAMP04, CAT_CAMP05,');
      SQL.Add(' CAT_CAMP06, CAT_CAMP07, CAT_CAMP08, CAT_CAMP09, CAT_CAMP10, CAT_CAMP11,');
      SQL.Add(' CAT_CAMP12, CAT_CAMP13, CAT_CAMP14, CAT_CAMP15, CAT_CAMP16, CAT_CAMP17,');
      SQL.Add(' CAT_CAMP18, CAT_CAMP19, CAT_CAMP20, CAT_CAMP21, CAT_CAMP22, CAT_CAMP23,');
      SQL.Add(' CAT_CAMP24, CAT_CAMP25, CAT_CAMP26, CAT_CAMP27,');
      SQL.Add(' CAT_MESANO, CAT_CODEMP, CAT_CODITE, CAT_INCVEN');
      if fCampoExiste('CAT_42_DADOS', 'VALORCONTABIL') then
        SQL.Add(', VALORCONTABIL ');
      SQL.Add(' )');
      SQL.Add('VALUES (');
      SQL.Add(' :AUTOINCREM, :CAMP01, :CAMP02, :CAMP03, :CAMP04, :CAMP05,');
      SQL.Add(' :CAMP06, :CAMP07, :CAMP08, :CAMP09, :CAMP10, :CAMP11,');
      SQL.Add(' :CAMP12, :CAMP13, :CAMP14, :CAMP15, :CAMP16, :CAMP17,');
      SQL.Add(' :CAMP18, :CAMP19, :CAMP20, :CAMP21, :CAMP22, :CAMP23,');
      SQL.Add(' :CAMP24, :CAMP25, :CAMP26, :CAMP27,');
      SQL.Add(' :MESANO, :CODEMP, :CODITE, :INCVEN');
      if fCampoExiste('CAT_42_DADOS', 'VALORCONTABIL') then
      SQL.Add(', :VALORCONTABIL');
      SQL.Add(') ');

      FAbertura.lblOperacao.Caption := 'Gravando dados...';
      FAbertura.progressoTela.Max := cdsDados.RecordCount;
      FAbertura.progressoTela.Position := 0;
      Application.ProcessMessages;

      cdsDados.First;
      while not cdsDados.Eof do
      begin
        //gravando o relatório como foi exportado, os dados de entrada e saída
        Close;
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CAT_42_DADOS', FAbertura.empresa.strCodigo);
        ParamByName('CAMP01').AsInteger := cdsDados.FieldByName('CAMPO01').AsInteger;
        ParamByName('CAMP02').AsString := cdsDados.FieldByName('CAMPO02').AsString;
        ParamByName('CAMP03').AsString := cdsDados.FieldByName('CAMPO03').AsString;
        ParamByName('CAMP04').AsString := cdsDados.FieldByName('CAMPO04').AsString;
        ParamByName('CAMP05').AsString := cdsDados.FieldByName('CAMPO05').AsString;
        ParamByName('CAMP06').AsString := cdsDados.FieldByName('CAMPO06').AsString;
        ParamByName('CAMP07').AsString := cdsDados.FieldByName('CAMPO07').AsString;
        ParamByName('CAMP08').AsString := cdsDados.FieldByName('CAMPO08').AsString;
        ParamByName('CAMP09').AsString := cdsDados.FieldByName('CAMPO09').AsString;
        ParamByName('CAMP10').AsString := cdsDados.FieldByName('CAMPO10').AsString;
        ParamByName('CAMP11').AsFloat := cdsDados.FieldByName('CAMPO11').AsFloat;
        ParamByName('CAMP12').AsFloat := cdsDados.FieldByName('CAMPO12').AsFloat;
        ParamByName('CAMP13').AsFloat := cdsDados.FieldByName('CAMPO13').AsFloat;
        ParamByName('CAMP14').AsFloat := cdsDados.FieldByName('CAMPO14').AsFloat;
        ParamByName('CAMP15').AsFloat := cdsDados.FieldByName('CAMPO15').AsFloat;
        ParamByName('CAMP16').AsFloat := cdsDados.FieldByName('CAMPO16').AsFloat;
        ParamByName('CAMP17').AsFloat := cdsDados.FieldByName('CAMPO17').AsFloat;
        ParamByName('CAMP18').AsFloat := cdsDados.FieldByName('CAMPO18').AsFloat;
        ParamByName('CAMP19').AsFloat := cdsDados.FieldByName('CAMPO19').AsFloat;
        ParamByName('CAMP20').AsFloat := cdsDados.FieldByName('CAMPO20').AsFloat;
        ParamByName('CAMP21').AsFloat := cdsDados.FieldByName('CAMPO21').AsFloat;
        ParamByName('CAMP22').AsFloat := cdsDados.FieldByName('CAMPO22').AsFloat;
        ParamByName('CAMP23').AsFloat := cdsDados.FieldByName('CAMPO23').AsFloat;
        ParamByName('CAMP24').AsFloat := cdsDados.FieldByName('CAMPO24').AsFloat;
        ParamByName('CAMP25').AsFloat := cdsDados.FieldByName('CAMPO25').AsFloat;
        ParamByName('CAMP26').AsFloat := cdsDados.FieldByName('CAMPO26').AsFloat;
        ParamByName('CAMP27').AsFloat := cdsDados.FieldByName('CAMPO27').AsFloat;
        ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FAbertura.dtaDataInicial);
        ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
        ParamByName('CODITE').AsString := cdsDados.FieldByName('CODITE').AsString;
        ParamByName('INCVEN').AsString := cdsDados.FieldByName('INCVEN').AsString;
        if fCampoExiste('CAT_42_DADOS', 'VALORCONTABIL') then
          ParamByName('VALORCONTABIL').AsFloat := cdsDados.FieldByName('VALORCONTABIL').AsFloat;
        ExecSQL;

        FAbertura.progressoTela.StepBy(1);
        Application.ProcessMessages;

        cdsDados.Next;
      end;

      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO CAT_42_SALDOS (');
      SQL.Add(' AUTOINCREM, CAT_CODITE, CAT_QTDINI, CAT_QTDFIN, CAT_SALINI, CAT_SALFIN, CAT_MESANO, CAT_CODEMP) ');
      SQL.Add('VALUES (');
      SQL.Add(' :AUTOINCREM, :CODITE, :QTDINI, :QTDFIN, :SALINI, :SALFIN, :MESANO, :CODEMP) ');

      FAbertura.lblOperacao.Caption := 'Gravando saldos...';
      FAbertura.progressoTela.Max := FListaDadosEstoque.Count;
      FAbertura.progressoTela.Position := 0;
      Application.ProcessMessages;

      for estoque in FListaDadosEstoque do
      begin
        //gravando dados do saldo, qtd inicial/final e valor inicial/final
        if estoque.blnEnviaMovimentacao then
        begin
          Close;
          ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('CAT_42_SALDOS', FAbertura.empresa.strCodigo);
          ParamByName('CODITE').AsString := estoque.strProduto;
          ParamByName('QTDINI').AsFloat := estoque.fltQtdInicial;
          ParamByName('QTDFIN').AsFloat := estoque.fltQtdFinal;
          ParamByName('SALINI').AsFloat := estoque.fltSaldoInicial;
          ParamByName('SALFIN').AsFloat := estoque.fltSaldoFinal;
          ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', FAbertura.dtaDataInicial);
          ParamByName('CODEMP').AsString := FAbertura.empresa.strCodigo;
          ExecSQL;
        end;

        FAbertura.progressoTela.StepBy(1);
        Application.ProcessMessages;
      end;
    end;
  finally
    qryReplace.Free;
  end;
end;

procedure TCat42.pLimpaArray(arrayIcmsCompra: array of Double);
  var
    i: Integer;
begin
  for i:= Low(arrayIcmsCompra) to High(arrayIcmsCompra) do
    arrayIcmsCompra[i] := 0;
end;

end.
