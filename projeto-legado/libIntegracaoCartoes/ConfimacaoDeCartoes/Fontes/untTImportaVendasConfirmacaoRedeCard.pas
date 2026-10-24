unit untTImportaVendasConfirmacaoRedeCard;

interface

uses  Uni, System.SysUtils, System.Classes, System.StrUtils, idHTTP, IdBaseComponent,
      IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
      Json, Forms, idAntiFreeze, System.Generics.Collections, DateUtils,
      WinAPI.Windows, IdCoder, IdCoder3to4, IdCoderMIME,untFuncoesSimples,
      System.NetEncoding,cxProgressBar,untGravando,untNewGravando,System.Variants,
      Data.DB,untFuncoes,untTExtratoConfirmaCartoes, untConstantes;

Type
  TDadosToken = class
  private
    Access_Token : String;
    Expiracao: Integer;
    RefreshTime: TTime;
    Exception : String;
    function GetAccessToken: String;
  Public
    Property AccessToken : String  Read GetAccessToken  Write Access_Token;
  end;

Type
  TImportaVendasConfirmacaoRedeCard = class(TObject)
  private
    LDadosToken: TDadosToken;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;
    LPgtoSemVenda: TUniQuery;
    FGravando : TfrmGravando;
    FFormNewGravando: TfrmNewGravando;
    FPagina: Integer;
    FExtratoVendas: TList<TDadosVendas>;
    procedure GerarToken;
    procedure CriarProtocoloSSL;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    function RetornaChaveBasic(AClientID, AClientSecret: String): String;
    procedure CriarComponenteRequisicao;
    function CriaQueryPagamentosSemVenda(ADataInicial,ADataFinal: TDateTime):TUniQuery;
    function ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function RetornaLinkConsultaVendaID(AEstabelecimento,AIdPamento,ANextKey:String): String;
    function RetiraZerosEsquerda(AString: String): String;
    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ADouble: Boolean = False): Variant;
    procedure ImportandoVendasDoPagamento;
    function EmpresaPossuiCredenciaisDeAutenticacao:Boolean;
    function RetornaDataFormatada(AData: String):String;
  public
    constructor Create(ADataInicial,ADataFinal: TDateTime);
    Destructor Destroy; Override;
    procedure ImportacaoDasVendasFaltantes;

    property ExtratoVendas:  TList<TDadosVendas> Read FExtratoVendas Write FExtratoVendas;
  End;

implementation

{ TImportaVendasConfirmacaoRedeCard }

constructor TImportaVendasConfirmacaoRedeCard.Create(ADataInicial,ADataFinal: TDateTime);
begin
  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  LPgtoSemVenda := CriaQueryPagamentosSemVenda(ADataInicial,ADataFinal);
  FPagina := 1;
  FExtratoVendas := TList<TDadosVendas>.Create;
end;

function TImportaVendasConfirmacaoRedeCard.CriaQueryPagamentosSemVenda(ADataInicial,
  ADataFinal: TDateTime): TUniQuery;
begin

  Try
    Result := CriarQueryDLL;
    Result.Close;
    Result.Sql.Clear;

    Result.Sql.Text := 'SELECT                                   '+
                       '  *                                      '+
                       'FROM                                     '+
                       '  RED_APPGTO PG                          '+
                       '  LEFT JOIN EXTMCA V                     '+
                       '    ON V.EXT_NUM_PV = PG.RED_NUM_PV      '+
                       '    AND V.EXT_DTAVEN = PG.RED_DTAPAG     '+
                       'WHERE PG.RED_DTAPAG BETWEEN :DTAINI      '+
                       '  AND :DTAFIM                            '+
                       '  GROUP BY PG.RED_PAG_ID                 ';

    Result.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    Result.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    Result.Open;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(Concat(E.Message,' [TImportaVendasConfirmacaoRedeCard.CriaQueryPagamentosSemVenda'));
    End;
  End;
end;

procedure TImportaVendasConfirmacaoRedeCard.CriarComponenteRequisicao;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;
end;

procedure TImportaVendasConfirmacaoRedeCard.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor TImportaVendasConfirmacaoRedeCard.Destroy;
begin
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);

  If Assigned(LDadosToken) Then
    FreeAndNil(LDadosToken);

  If Assigned(LPgtoSemVenda) Then
    FreeAndNil(LPgtoSemVenda);

  If Assigned(FExtratoVendas) Then
    If FExtratoVendas.Count > 0 Then
      FreeAndNil(FExtratoVendas);

  inherited;
end;

function TImportaVendasConfirmacaoRedeCard.EmpresaPossuiCredenciaisDeAutenticacao: Boolean;
begin
  Result := True;
  If fEmptyStr(fRetornaValorConfiguracao('CFG_REDUSU')) Then
    Result := False
  Else If fEmptyStr(fRetornaValorConfiguracao('CFG_REDSEN')) Then
    Result := False
  Else If fEmptyStr(fRetornaValorConfiguracao('CFG_REDCLI')) Then
    Result := False
  Else If fEmptyStr(fRetornaValorConfiguracao('CFG_REDSEC')) Then
    Result := False;
end;

procedure TImportaVendasConfirmacaoRedeCard.GerarToken;
  Var
    LRequisicao: TidHTTP;
    LParametros: TStringList;
    LResposta: String;
    LJsonObject: TJSONObject;
begin

  If Assigned(LDadosToken) Then
  Begin
    If (LDadosToken.RefreshTime >= fNow) And fEmptyStr(LDadosToken.Exception) Then
    Begin
      Exit;
    End;
    FreeAndNil(LDadosToken);
  End;

  Try
    Try
      LDadosToken := TDadosToken.Create;
      LParametros := TStringList.Create;
      LParametros.Add('grant_type=password');

      LParametros.Add('username=' + fRetornaValorConfiguracao('CFG_REDUSU'));
      LParametros.Add('password=' + fRetornaValorConfiguracao('CFG_REDSEN'));

      LRequisicao := TIdHTTP.Create(Nil);
      LRequisicao.OnWork := OnWork;
      LRequisicao.IOHandler := FProtocoloSSL;
      LRequisicao.Request.ContentType := 'application/x-www-form-urlencoded';

      LRequisicao.Request.CustomHeaders.Add('Authorization: ' + RetornaChaveBasic(fRetornaValorConfiguracao('CFG_REDCLI'),fRetornaValorConfiguracao('CFG_REDSEC')));

      Application.ProcessMessages;

      LResposta := LRequisicao.Post('https://api.userede.com.br/redelabs/oauth/token', LParametros);

      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      LDadosToken.Access_Token := LJsonObject.GetValue<String>('access_token');;
      LDadosToken.Expiracao    := LJsonObject.GetValue<Integer>('expires_in');
      LDadosToken.RefreshTime  := IncSecond(fNow, LJsonObject.GetValue<Integer>('expires_in'));

      LDadosToken.RefreshTime  := IncMinute(LDadosToken.RefreshTime,-2);
    Finally
      If Assigned(LParametros) Then
        FreeAndNil(LRequisicao);

      If Assigned(LParametros) Then
        FreeAndNil(LParametros);

      If Assigned(LJsonObject) Then
        FreeAndNil(LJsonObject);
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      LDadosToken.Exception :=  'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                                'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                'PRODUÇÃO. Erro:' + E.ErrorMessage;
    End;

    On E: Exception Do
    Begin
      LDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                               'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                               'PRODUÇÃO. Erro:' + E.Message;
    End;

  End;
end;

procedure TImportaVendasConfirmacaoRedeCard.ImportandoVendasDoPagamento;
begin
  If NewGravando Then
  Begin
    Try
      pCriarFormularios(TfrmNewGravando, FFormNewGravando);
      FFormNewGravando.fExecutarAcao := ImportaVendasPagamento;
      FFormNewGravando.lblGravando.Caption := 'Aguarde... Importando Vendas.';
      FFormNewGravando.pgbStatus.Visible := True;
      FFormNewGravando.ShowModal;
    Finally
      FreeAndNil(FFormNewGravando);
    End;
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmGravando, FGravando);
      FGravando.fExecutarAcao := ImportaVendasPagamento;
      FGravando.lblGravando.Caption := 'Aguarde... Importando Vendas.';
      FGravando.pgbStatus.Visible := True;
      FGravando.ShowModal;
    Finally
      FreeAndNil(FGravando);
    End;
  End;
end;

function TImportaVendasConfirmacaoRedeCard.ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LLinkConsulta: String;
    LRetornoGet  : String;
    LNextKey     : String;
    LJsonRetorno : TJSONObject;
    LJsonObjectValue,
    LJsonObjectGroup : TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LDadosVendas : TDadosVendas;
begin
  If LPgtoSemVenda.IsEmpty Then Exit(False);

  Result := True;
  Try
    AguardeExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
    LRequisicao.Request.CustomHeaders.AddValue('authorization', 'Bearer ' + LDadosToken.AccessToken);
    LRequisicao.Request.CustomHeaders.AddValue('Content-Type', 'application/json');
    LRequisicao.Request.Method := 'GET';

    LPgtoSemVenda.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LPgtoSemVenda.RecordCount;
    Try
      While Not LPgtoSemVenda.Eof Do
      Begin
        LNextKey := '';
        Repeat
          LLinkConsulta := RetornaLinkConsultaVendaID(LPgtoSemVenda.FieldByName('RED_NUM_PV').AsString,
                                                      LPgtoSemVenda.FieldByName('RED_PAG_ID').AsString,
                                                      LNextKey);



          LRetornoGet := lRequisicao.Get(LLinkConsulta);
          LNextKey := '';

          If fEmptyStr(LRetornoGet) Then
            Continue;

          LJsonRetorno := TJSONObject.ParseJSONValue(LRetornoGet) as TJSONObject;
          LJsonObjectValue := LJsonRetorno.GetValue<TJSONObject>('cursor') as TJSONObject;
          If LJsonObjectValue.GetValue<string>('hasNextKey') = 'true' Then
            LNextKey := LJsonObjectValue.GetValue<string>('nextKey');

          LJsonObjectValue := LJsonRetorno.GetValue<TJSONObject>('content') as TJSONObject;
          LJsonArray := LJsonObjectValue.GetValue('installments') as TJsonArray;

          For LJsonValue In LJsonArray Do
          Begin
            LJsonObjectValue := TJSONObject.ParseJSONValue(LJSonValue.ToString) as TJSONObject;

            LDadosVendas.Estabelecimento := RetornaValorJson(LJsonObjectValue, 'merchantId');
            LDadosVendas.Estabelecimento := LDadosVendas.Estabelecimento.PadLeft(9, '0');
            LDadosVendas.Autorizacao     := RetornaValorJson(LJsonObjectValue, 'authorizationCode');

            LDadosVendas.Nsu             := fStrZero(Trim(RightStr(RetornaValorJson(LJsonObjectValue, 'nsu'), 14)), 14);
            LDadosVendas.Parcela         := fGetLetraAlfa(StrToInt(LeftStr(RetornaValorJson(LJsonObjectValue, 'installmentNumber'), 2)));
            LDadosVendas.Cartao          := RetornaValorJson(LJsonObjectValue, 'cardNumber');
            LDadosVendas.Bandeira        := fRetNomBandeira(LDadosVendas.Cartao);
            LDadosVendas.Status          := 'N';
            LDadosVendas.Operador        := strLoginUsuarioLogado;
            LDadosVendas.NomeOperadora   := 'REDECARD';

            LDadosVendas.DataTransacao   := StrToDate(RetornaDataFormatada(RetornaValorJson(LJsonObjectValue, 'saleDate')));
            LDadosVendas.DataVencimento  := StrToDate(RetornaDataFormatada(RetornaValorJson(LJsonObjectValue, 'expirationDate')));
            LDadosVendas.DataImportacao  := VS_Date;

            LJsonObjectGroup := LJsonObjectValue.GetValue('amountInfo') as TJSONObject;
            LDadosVendas.ValorBruto      := RetornaValorJson(LJsonObjectGroup, 'originalAmount',True);
            LDadosVendas.ValorTaxa       := RetornaValorJson(LJsonObjectValue, 'mdrAmount', True);
            LDadosVendas.ValorLiquido    := RetornaValorJson(LJsonObjectGroup, 'originalNetAmount',True);


            FExtratoVendas.Add(LDadosVendas);

          End;


        Until LNextKey.IsEmpty;

        LPgtoSemVenda.Next;
        pStep(pgbProgresso);
      End;
    Finally
      If Assigned(LJsonRetorno) Then
        FreeAndNil(LJsonRetorno);

      If Assigned(LJsonObjectValue) Then
        FreeAndNil(LJsonObjectValue);
    End;
  Except

    On E:EIdHTTPProtocolException Do
    Begin
      Raise Exception.Create(E.ErrorMessage);
    End;

    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TImportaVendasConfirmacaoRedeCard.ImportacaoDasVendasFaltantes;
begin
  If EmpresaPossuiCredenciaisDeAutenticacao Then
  Begin
    If Not LPgtoSemVenda.IsEmpty  Then
    Begin
      ImportandoVendasDoPagamento;
    End;
  End;
end;

function TImportaVendasConfirmacaoRedeCard.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String; ADouble: Boolean = False): Variant;
begin
  If ADouble Then
  Begin
    Result := 0;
    If AObjeto.GetValue(ANomeCampo) <> Nil Then
      Result := AObjeto.GetValue<double>(ANomeCampo);
  End Else
  Begin
    Result := '';
    If AObjeto.GetValue(ANomeCampo) <> Nil Then
      Result := AObjeto.GetValue<string>(ANomeCampo);
  End;
end;

procedure TImportaVendasConfirmacaoRedeCard.OnWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;


function TImportaVendasConfirmacaoRedeCard.RetiraZerosEsquerda(AString: String): String;
begin
  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TImportaVendasConfirmacaoRedeCard.RetornaChaveBasic(AClientID,AClientSecret: String): String;
  Var
    LBase64: TBase64Encoding;
begin
  Result := '';

  If AClientID.IsEmpty Then
    Exit;

  If AClientSecret.IsEmpty Then
    Exit;

  Try
    LBase64 := TBase64Encoding.Create(0);

    Result := 'Basic ' + LBase64.Encode(AClientID + ':' + AClientSecret);
  Finally
    FreeAndNil(LBase64);
  End;

end;

function TImportaVendasConfirmacaoRedeCard.RetornaDataFormatada(
  AData: String): String;
begin
  Result :=  Copy(AData, 9, 2) +'/'+
             Copy(AData, 6, 2) +'/'+
             Copy(AData, 1, 4)
end;

function TImportaVendasConfirmacaoRedeCard.RetornaLinkConsultaVendaID(AEstabelecimento, AIdPamento,ANextKey: String): String;
begin
  Result := 'https://api.userede.com.br/redelabs/merchant-statement/v2/payments/installments/[ESTABELECIMENTO]/[ID_PAGAMENTO]?size=100' ;
  Result := StringReplace(Result, '[ESTABELECIMENTO]', RetiraZerosEsquerda(AEstabelecimento), [rfReplaceAll]);
  Result := StringReplace(Result, '[ID_PAGAMENTO]',AIdPamento, [rfReplaceAll]);

  If Not ANextKey.IsEmpty Then
  Begin
    Result := Result + '&pageKey=' + ANextKey;
    Inc(FPagina);
  End
  Else
    FPagina := 1;

  If Assigned(FGravando) Then
    FGravando.lblGravando.Caption := 'Aguarde... Importando Vendas (Página ' + FPagina.ToString + ')'
  Else
    FFormNewGravando.lblGravando.Caption := 'Aguarde... Importando Vendas (Página ' + FPagina.ToString + ')';
end;

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  If Not fEmptyStr(Self.Exception) Then
    Raise System.SysUtils.Exception.Create(Self.Exception)
  Else
    Result := Self.Access_Token;
end;

end.
