unit untAmazonPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms,

     cxProgressBar, Uni,

     untIAmazonIntegracaoLibCartoes, untTAmazonFuncoes,
     untAmazonTipos;

Type
  TAmazonPgto = Class(TInterfacedObject, ICartoesAmazon)
  Private
    function fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;
    function fGetDados(strValor: String; blnFlt: Boolean = False): Variant;
    function RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;
    function RetornaPeriodoPagamento: String;
    function AgruparItensDoMesmoPedido: TArrRegistroAmazonPgto;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaAmazonPgto;
  End;

Var
  strDtaArq,
  strNomArq,
  strDtaPag,
  strDtaini,
  strDtaFim,
  strMoeda,
  strTotArq : String;

  VS_CodigoEmpresa: String;

  VS_IndicesCampos: TStringList;

  FRegAmazonPgto: TArrRegistroAmazonPgto;

Const
  NOMTAB = 'AMZ_AMPGTO';
  INICAM = 'AMZ_';

implementation

uses untAmazon, System.Generics.Collections;

class function TAmazonPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaAmazonPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 28);

    Result[00].strDescri := INICAM + 'AUTINC'; Result[00].strTipCmp := 'INT AUTO_INCREMENT NOT NULL';
    Result[01].strDescri := INICAM + 'SETIDE'; Result[01].strTipCmp := 'VARCHAR(20)';
    Result[02].strDescri := INICAM + 'DTAINI'; Result[02].strTipCmp := 'DATETIME';
    Result[03].strDescri := INICAM + 'DTAFIM'; Result[03].strTipCmp := 'DATETIME';
    Result[04].strDescri := INICAM + 'DTAPAG'; Result[04].strTipCmp := 'DATE';
    Result[05].strDescri := INICAM + 'TOTAMZ'; Result[05].strTipCmp := 'DECIMAL(15,2)';
    Result[06].strDescri := INICAM + 'MOEDAL'; Result[06].strTipCmp := 'CHAR(3)';
    Result[07].strDescri := INICAM + 'NOMARQ'; Result[07].strTipCmp := 'VARCHAR(50)';
    Result[08].strDescri := INICAM + 'DTAARQ'; Result[08].strTipCmp := 'DATE';
    Result[09].strDescri := INICAM + 'TIPTRA'; Result[09].strTipCmp := 'VARCHAR(40)';
    Result[10].strDescri := INICAM + 'IDEPED'; Result[10].strTipCmp := 'VARCHAR(30)';
    Result[11].strDescri := INICAM + 'ID_SEL'; Result[11].strTipCmp := 'VARCHAR(30)';
    Result[12].strDescri := INICAM + 'IDAJUS'; Result[12].strTipCmp := 'VARCHAR(30)';
    Result[13].strDescri := INICAM + 'ID_ENV'; Result[13].strTipCmp := 'VARCHAR(20)';
    Result[14].strDescri := INICAM + 'TP_VLR'; Result[14].strTipCmp := 'VARCHAR(30)';
    Result[15].strDescri := INICAM + 'DESCVL'; Result[15].strTipCmp := 'VARCHAR(75)';
    Result[16].strDescri := INICAM + 'VALORT'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := INICAM + 'TIPFUL'; Result[17].strTipCmp := 'CHAR(3)';
    Result[18].strDescri := INICAM + 'DTATRA'; Result[18].strTipCmp := 'DATE';
    Result[19].strDescri := INICAM + 'DTAHPO'; Result[19].strTipCmp := 'DATETIME';
    Result[20].strDescri := INICAM + 'CODITM'; Result[20].strTipCmp := 'VARCHAR(20)';
    Result[21].strDescri := INICAM + 'IDITMV'; Result[21].strTipCmp := 'VARCHAR(30)';
    Result[22].strDescri := INICAM + 'IDAJIT'; Result[22].strTipCmp := 'VARCHAR(30)';
    Result[23].strDescri := INICAM + 'SKUCOD'; Result[23].strTipCmp := 'VARCHAR(50)';
    Result[24].strDescri := INICAM + 'QTDCOM'; Result[24].strTipCmp := 'INT DEFAULT 0';
    Result[25].strDescri := INICAM + 'ID_PRO'; Result[25].strTipCmp := 'VARCHAR(50)';
    Result[26].strDescri := INICAM + 'CODEMP'; Result[26].strTipCmp := 'CHAR(3)';
    Result[27].strDescri := INICAM + 'CONCIL'; Result[27].strTipCmp := 'INT(11)';
  End;
End;

class function TAmazonPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
  Var
    arrCampos: TArrEstruturaAmazonPgto;
    intCont  : Integer;
begin
  Result    := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);
  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY (AMZ_AUTINC), ';

  Result := Result + ' UNIQUE INDEX IDX_AMZ_UNIQUE (AMZ_SETIDE,AMZ_IDEPED,AMZ_TIPTRA,AMZ_TP_VLR,AMZ_DESCVL,AMZ_CODEMP)';

  Result := Result + ') ENGINE=INNODB';

end;

function TAmazonPgto.fGetDados(strValor: String; blnFlt: Boolean): Variant;
var
  rst: Variant;
  FS: TFormatSettings;
Begin
  rst := ' ';
  If strValor <> '' Then
    rst := strValor;

  If blnFlt Then
  Begin
    If rst = ' ' Then
      rst := 0;

    FS := TFormatSettings.Create;
    FS.DecimalSeparator := '.';
    rst := StrToFloatDef(StringReplace(VarToStr(rst), ',', '.', []), 0, FS);
  End;

  Result := rst;
end;

function TAmazonPgto.fRetVal(strVal: Variant; blnData: Boolean; blnCompleta: Boolean): Variant;
var
  LData: string;
Begin
  If TAmazonFuncoes.fEmptyStr(strVal) Then
    Exit(Null);

  Result := strVal;

 if blnData then
  begin
    LData := StringReplace(VarToStr(strVal), ' UTC', '', [rfReplaceAll]);
    LData := Trim(LData);

    if blnCompleta then
      Result := Copy(LData, 7, 4) + '-' +
                Copy(LData, 4, 2) + '-' +
                Copy(LData, 1, 2) + ' ' +
                Copy(LData, 12, 8)
    else
      Result := Copy(LData, 7, 4) + '-' +
                Copy(LData, 4, 2) + '-' +
                Copy(LData, 1, 2);
  end;
End;

procedure TAmazonPgto.pAdicionaLinha(strString: String);
  Var
    lstCampos: TStringList;
    intRegistro: Integer;
Begin
  lstCampos := Nil;

  Try
    lstCampos               := TStringList.Create;
    lstCampos.Delimiter     := #9;
    lstCampos.StrictDelimiter := True;
    lstCampos.DelimitedText := strString;

    If Not Assigned(VS_IndicesCampos) Then
    Begin
      VS_IndicesCampos                  := TStringList.Create;
      VS_IndicesCampos.StrictDelimiter  := True;
      VS_IndicesCampos.Delimiter        := #9;
    End;

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If Not Assigned(VS_DatasPagamento) Then
      VS_DatasPagamento := TStringList.Create;

    Try
      If (Pos('settlement-id', strString) > 0) And
         (Pos('transaction-type', strString) > 0) Then
      Begin
        VS_IndicesCampos.DelimitedText := strString;
        Exit;
      End;

      If lstCampos.Count = 0 Then
        Exit;

      If (lstCampos.Count > 0) And
         (VS_IndicesCampos.Count > 0) And
         (lstCampos[VS_IndicesCampos.IndexOf('transaction-type')] = '') Then
      Begin
        strDtaPag := lstCampos[VS_IndicesCampos.IndexOf('deposit-date')];
        strDtaini := lstCampos[VS_IndicesCampos.IndexOf('settlement-start-date')];
        strDtaFim := lstCampos[VS_IndicesCampos.IndexOf('settlement-end-date')];
        strTotArq :=  fGetDados(lstCampos[VS_IndicesCampos.IndexOf('total-amount')], True);
        strMoeda  := lstCampos[VS_IndicesCampos.IndexOf('currency')];
        Exit;
      End;

      SetLength(FRegAmazonPgto, Length(FRegAmazonPgto) + 1);
      intRegistro := Length(FRegAmazonPgto) - 1;

      FRegAmazonPgto[intRegistro].strIdentificacaoArquivo  := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('settlement-id')]);
      FRegAmazonPgto[intRegistro].strNomArq                := strNomArq;
      FRegAmazonPgto[intRegistro].strDtaArq                := strDtaArq;

      FRegAmazonPgto[intRegistro].strDtaPag                := strDtaPag;
      FRegAmazonPgto[intRegistro].strDtaini                := strDtaini;
      FRegAmazonPgto[intRegistro].strDtaFim                := strDtaFim;

      FRegAmazonPgto[intRegistro].strMoeda                 := strMoeda;
      FRegAmazonPgto[intRegistro].strTotArq                := fGetDados(strTotArq, True);

      FRegAmazonPgto[intRegistro].TransactionType          := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('transaction-type')]);
      FRegAmazonPgto[intRegistro].OrderID                  := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('order-id')]);
      FRegAmazonPgto[intRegistro].MerchantOrderID          := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('merchant-order-id')]);
      FRegAmazonPgto[intRegistro].AdjustmentID             := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('adjustment-id')]);
      FRegAmazonPgto[intRegistro].ShipmentID               := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('shipment-id')]);
      FRegAmazonPgto[intRegistro].AmountType               := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('amount-type')]);
      FRegAmazonPgto[intRegistro].AmountDescription        := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('amount-description')]);
      FRegAmazonPgto[intRegistro].Amount                   := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('amount')], True);
      FRegAmazonPgto[intRegistro].FulfillmentID            := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('fulfillment-id')]);
      FRegAmazonPgto[intRegistro].PostedDate               := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('posted-date')]);
      FRegAmazonPgto[intRegistro].PostedDateTime           := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('posted-date-time')]);
      FRegAmazonPgto[intRegistro].OrderItemCode            := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('order-item-code')]);
      FRegAmazonPgto[intRegistro].MerchantOrderItemID      := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('merchant-order-item-id')]);
      FRegAmazonPgto[intRegistro].MerchantAdjustmentItemID := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('merchant-adjustment-item-id')]);
      FRegAmazonPgto[intRegistro].SKU                      := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('sku')]);
      FRegAmazonPgto[intRegistro].QuantityPurchased        := StrToIntDef(lstCampos[VS_IndicesCampos.IndexOf('quantity-purchased')], 0);
      FRegAmazonPgto[intRegistro].PromotionID              := fGetDados(lstCampos[VS_IndicesCampos.IndexOf('promotion-id')]);
      FRegAmazonPgto[intRegistro].CodigoEmpresa            := VS_CodigoEmpresa;

      If Not TAmazonFuncoes.fEmptyStr(FRegAmazonPgto[intRegistro].PostedDate) Then
      Begin
        If VS_DatasPagamento.IndexOf(FRegAmazonPgto[intRegistro].PostedDate) < 0 Then
          VS_DatasPagamento.Add(FRegAmazonPgto[intRegistro].PostedDate);
      End;

      If VS_ListaEstabelecimentos.IndexOf(VS_CodigoEmpresa) < 0 Then
        VS_ListaEstabelecimentos.Add(VS_CodigoEmpresa);

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao importar o arquivo.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    If Assigned(lstCampos) Then
      FreeAndNil(lstCampos);
  End;
end;

procedure TAmazonPgto.pGravarRegistros(var pgbProg: TcxProgressBar);
  Var
    LGravacao: TUniQuery;
    LRegistro: TRegistroPgto;
    LRegistros: TArrRegistroAmazonPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;

    LGravacao.SQL.Text := TAmazonFuncoes.RetornaSQLReplace('AMZ_AMPGTO',  ['AMZ_CONCIL']);

    TAmazonFuncoes.CarregaRegistrosJaImportados('AMZ_AMPGTO',
                                                      ['AMZ_CONCIL', 'AMZ_DTAPAG'],
                                                      ['= 1',RetornaPeriodoPagamento]);

    pgbProg.Position := 0;

    LRegistros := AgruparItensDoMesmoPedido;

    If Length(LRegistros) <= 0 Then
      Exit;

    pgbProg.Properties.Max := Length(LRegistros)-1;

    For LRegistro In LRegistros Do
    Begin
      If LRegistro.TransactionType.Trim.IsEmpty Then
      Begin
        TAmazonFuncoes.pStepStatusGravacao(pgbProg);
        Continue;
      End;

      If RegistroJaImportado(LRegistro) Then
      Begin
        TAmazonFuncoes.pStepStatusGravacao(pgbProg);
        Continue;
      End;

      LGravacao.Close;

      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_SETIDE', fRetVal(LRegistro.strIdentificacaoArquivo));

      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTAINI', fRetVal(LRegistro.strDtaini, True, False));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTAFIM', fRetVal(LRegistro.strDtafim, True, False));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTAPAG', fRetVal(LRegistro.strDtaPag, True, False));

      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_TOTAMZ', fGetDados(VarToStr(LRegistro.strTotArq), True));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_MOEDAl', fRetVal(LRegistro.strMoeda));

      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_NOMARQ', fRetVal(LRegistro.strNomArq));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTAARQ', fRetVal(LRegistro.strDtaArq));


      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_TIPTRA', fRetVal(LRegistro.TransactionType));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_IDEPED', fRetVal(LRegistro.OrderID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_ID_SEL', fRetVal(LRegistro.MerchantOrderID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_IDAJUS', fRetVal(LRegistro.AdjustmentID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_ID_ENV', fRetVal(LRegistro.ShipmentID));

      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_TP_VLR', fRetVal(LRegistro.AmountType));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DESCVL', fRetVal(LRegistro.AmountDescription));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_VALORT', fRetVal(LRegistro.Amount));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_TIPFUL', fRetVal(LRegistro.FulfillmentID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTATRA', fRetVal(LRegistro.PostedDate,    True, False));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_DTAHPO', fRetVal(LRegistro.PostedDateTime, True, True));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_CODITM', fRetVal(LRegistro.OrderItemCode));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_IDITMV', fRetVal(LRegistro.MerchantOrderItemID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_IDAJIT', fRetVal(LRegistro.MerchantAdjustmentItemID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_SKUCOD', fRetVal(LRegistro.SKU));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_QTDCOM', fRetVal(LRegistro.QuantityPurchased));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_ID_PRO', fRetVal(LRegistro.PromotionID));
      TAmazonFuncoes.CarregaParametroDataset(LGravacao, 'AMZ_CODEMP', fRetVal(LRegistro.CodigoEmpresa));

      LGravacao.ExecSQL;

      TAmazonFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TAmazonFuncoes.GravarEstabelecimentos;
  Finally
    TAmazonFuncoes.FreeAndNilDatasets(LGravacao);

    If Assigned(VS_IndicesCampos) Then
      FreeAndNil(VS_IndicesCampos);

    If Assigned(VS_DatasPagamento) Then
      FreeAndNil(VS_DatasPagamento);
  End;

end;

function TAmazonPgto.AgruparItensDoMesmoPedido: TArrRegistroAmazonPgto;
  Var
    LRegistro: TRegistroPgto;
    LChavesGravadas: TDictionary<String, Integer>;
    LLinhasLidas: TStringList;
    LChave,
    LLinha: String;
    LIndice: Integer;
begin
  // A chave unica da AMZ_AMPGTO (settlement, pedido, tipo de transacao, tipo e
  // descricao do valor) nao tem o item. Pedido com mais de um item traz um
  // Principal, um Commission... por item, e o REPLACE gravava so os do ultimo
  // item: a venda ficava menor que o deposito. Por isso os itens diferentes na
  // mesma chave sao somados aqui. Linha repetida (o mesmo arquivo selecionado
  // duas vezes) continua valendo uma vez so, como no REPLACE.
  SetLength(Result, 0);

  LChavesGravadas := TDictionary<String, Integer>.Create;
  LLinhasLidas    := TStringList.Create;
  Try
    LLinhasLidas.Sorted := True;

    For LRegistro In FRegAmazonPgto Do
    Begin
      LChave := LRegistro.strIdentificacaoArquivo + '|' +
                LRegistro.OrderID                 + '|' +
                LRegistro.TransactionType         + '|' +
                LRegistro.AmountType              + '|' +
                LRegistro.AmountDescription;

      LLinha := LChave                              + '|' +
                LRegistro.OrderItemCode             + '|' +
                LRegistro.AdjustmentID              + '|' +
                LRegistro.MerchantAdjustmentItemID  + '|' +
                LRegistro.ShipmentID                + '|' +
                LRegistro.PromotionID               + '|' +
                LRegistro.SKU                       + '|' +
                IntToStr(LRegistro.QuantityPurchased) + '|' +
                LRegistro.PostedDateTime            + '|' +
                FloatToStr(LRegistro.Amount);

      If LLinhasLidas.IndexOf(LLinha) >= 0 Then
        Continue;

      LLinhasLidas.Add(LLinha);

      If LChavesGravadas.TryGetValue(LChave, LIndice) Then
      Begin
        Result[LIndice].Amount := Result[LIndice].Amount + LRegistro.Amount;
        Continue;
      End;

      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := LRegistro;
      LChavesGravadas.Add(LChave, High(Result));
    End;
  Finally
    FreeAndNil(LChavesGravadas);
    FreeAndNil(LLinhasLidas);
  End;
end;

function TAmazonPgto.RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;
begin
  Result := VS_RegistrosJaImportados.Locate(
              'AMZ_SETIDE;AMZ_IDEPED;AMZ_TP_VLR;AMZ_DESCVL;AMZ_TIPTRA',
              VarArrayOf([ARegistro.strIdentificacaoArquivo,
                          ARegistro.OrderID,
                          ARegistro.AmountType,
                          ARegistro.AmountDescription,
                          ARegistro.TransactionType]),
              []);
end;

function TAmazonPgto.RetornaPeriodoPagamento: String;
  Var
    LDataInicial: String;
    LDataFinal  : String;
begin
  VS_DatasPagamento.Sort;
  LDataInicial := VS_DatasPagamento[0];
  LDataFinal   := VS_DatasPagamento[VS_DatasPagamento.Count - 1];

  Result := 'BETWEEN "' + LDataInicial + '" AND ' +
            '        "' + LDataFinal   + '" ';
end;

end.
