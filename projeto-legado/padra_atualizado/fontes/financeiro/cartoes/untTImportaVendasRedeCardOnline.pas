unit untTImportaVendasRedeCardOnline;

interface

uses  Uni, System.SysUtils, System.Classes, System.StrUtils, idHTTP, IdBaseComponent,
      IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
      Json, Forms, idAntiFreeze, System.Generics.Collections, DateUtils,
      WinAPI.Windows, IdCoder, IdCoder3to4, IdCoderMIME,untFuncoesSimples,
      System.NetEncoding,cxProgressBar,untGravando,System.Variants,
      Data.DB;

Type
  TVendasPagamento = Class
    CodigoBandeira,
    CodigoEstabelecimento,
    Flex,
    NumeroCartao,
    CodigoProduto,
    CodigoModalidade,
    Parcela,
    ResumoVenda,
    Tokenizado,
    TotalParcelas,
    Status,
    DataVenda,
    Autorizacao,
    DataVencimento,
    NomeBandeira,
    NSU,
    ModalidadeProduto,
    Modalidade,
    AlteracaoDeValor,
    HashVenda,
    IDPagamento: String;

    TaxaFlex,
    ValorFlex,
    ValorMDR,
    ValorMDROriginal,
    TaxaMDR,
    ValorFlexOriginal,
    QuantiaValorFlex,
    ValorTaxa,
    ValorBruto,
    ValorBrutoOriginal,
    ValorDesconto,
    ValorDescontoOriginal,
    ValorLiquido,
    ValorLiquidoOriginal,
    ValorVenda: Double;
  end;


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
  TImportaVendasRedeCardOnline = class(TObject)
  private
    LDadosToken: TDadosToken;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    LRequisicao: TidHTTP;
    LPgtoSemVenda: TUniQuery;
    LListaVendasPagamento: TList<TVendasPagamento>;
    LCamposTabelaVenda: String;
    LParametrosTabelaVenda: String;
    FGravando : TfrmGravando;
    FPagina: Integer;
    FEstabelecimentoPagamento: String;
    procedure GerarToken;
    procedure CriarProtocoloSSL;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    function RetornaChaveBasic(AClientID, AClientSecret: String): String;
    procedure CriarComponenteRequisicao;
    function CriaQueryPagamentosSemVenda(ADataInicial,ADataFinal: TDateTime):TUniQuery;
    function ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function GravaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
    function RetornaLinkConsultaVendaID(AEstabelecimento,AIdPamento,ANextKey:String): String;
    function RetiraZerosEsquerda(AString: String): String;
    function RetornaValorJson(AObjeto: TJsonObject; ANomeCampo: String; ADouble: Boolean = False): Variant;
    procedure ImportandoVendasDoPagamento;
    procedure GravandoVendasImportadas;
    procedure StepStatus(pgbStatus: TcxProgressBar);
    function CorrigeDadosBanco(AValor: Variant): Variant;
    procedure CarregaEstruturaTabelaVenda;
    function EmpresaPossuiCredenciaisDeAutenticacao:Boolean;
    procedure ReimportarVendas(ADataInicial,ADataFinal: TDateTime);
    function RetornaTotalLiquidoVendas(ADataInicial,ADataFinal: TDateTime): Double;
    function RetornaTotalLiquidoPagamento(ADataInicial,ADataFinal: TDateTime): Double;
    procedure ApagarVendasImportadas(ADataInicial,ADataFinal: TDateTime);
    function ConsultarVenda(AEstabelecimentoVenda, AIdVenda, ANextKey: String): String;
  public
    constructor Create(ADataInicial,ADataFinal: TDateTime);
    Destructor Destroy; Override;
    procedure ImportacaoDasVendasFaltantes;
  End;

implementation

{ TImportaVendasRedeCardOnline }

procedure TImportaVendasRedeCardOnline.ApagarVendasImportadas(ADataInicial,
  ADataFinal: TDateTime);
  Var
    LVendas : TUniQuery;
    LSql : String;
begin

  Try
    LVendas := fCriaQuery(Nil);

    LSql := 'DELETE                            '+
            'FROM                              '+
            '  [TABELA]                        '+
            'WHERE RED_VEN_RV BETWEEN :DTAINI  '+
            '  AND :DTAFIM                     ';

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text :=  StringReplace(LSql, '[TABELA]', 'RED_APVPAR', [rfReplaceAll]);
    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    LVendas.ExecSQL;

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text :=  StringReplace(LSql, '[TABELA]', 'RED_APVPGO', [rfReplaceAll]);
    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    LVendas.ExecSQL;

  Finally
    FreeAndNil(LVendas);
  End;
end;

procedure TImportaVendasRedeCardOnline.CarregaEstruturaTabelaVenda;
  Var
    LConsulta : TUniQuery;
    LCampo: TField;
begin
  LConsulta := fCriaQuery(Nil);

  Try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM RED_APVPGO WHERE FALSE');
    LConsulta.Open;


    LCamposTabelaVenda := '';
    LParametrosTabelaVenda := '';

    For LCampo In LConsulta.Fields Do
    Begin
      LCamposTabelaVenda     := LCamposTabelaVenda + LCampo.FieldName + ',';
      LParametrosTabelaVenda := LParametrosTabelaVenda + ':' + LCampo.FieldName + ',';
    End;

    LCamposTabelaVenda     := LeftStr(LCamposTabelaVenda, LCamposTabelaVenda.Length - 1);
    LParametrosTabelaVenda := LeftStr(LParametrosTabelaVenda, LParametrosTabelaVenda.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TImportaVendasRedeCardOnline.CorrigeDadosBanco(AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TImportaVendasRedeCardOnline.Create(ADataInicial,ADataFinal: TDateTime);
begin
  CriarProtocoloSSL;
  CriarComponenteRequisicao;
  LListaVendasPagamento := TList<TVendasPagamento>.Create;
  LPgtoSemVenda := CriaQueryPagamentosSemVenda(ADataInicial,ADataFinal);
  FPagina := 1;
  FEstabelecimentoPagamento := fCfgSis('REDPAG');
end;

function TImportaVendasRedeCardOnline.CriaQueryPagamentosSemVenda(ADataInicial,
  ADataFinal: TDateTime): TUniQuery;
begin

  ReimportarVendas(ADataInicial,ADataFinal);

  Try
    Result := fCriaQuery(Nil);
    Result.Close;
    Result.Sql.Clear;

    Result.Sql.Text := 'SELECT                                   '+
                       '  *                                      '+
                       'FROM                                     '+
                       '  RED_APPGTO PG                          '+
                       '  LEFT JOIN RED_APVPAR VP                '+
                       '    ON VP.RED_NUM_PV = PG.RED_NUM_PV     '+
                       '    AND VP.RED_NUM_RV = PG.RED_NUM_RV    '+
                       '    AND VP.RED_VEN_RV = PG.RED_DTAPAG    '+
                       '  LEFT JOIN RED_APVPGO VPGO              '+
                       '    ON VPGO.RED_NUM_PV = PG.RED_NUM_PV   '+
                       '    AND VPGO.RED_NUM_RV = PG.RED_NUM_RV  '+
                       '    AND VPGO.RED_VEN_RV = PG.RED_DTAPAG  '+
                       'WHERE PG.RED_DTAPAG BETWEEN :DTAINI      '+
                       '  AND :DTAFIM                            '+
                       '  AND VP.RED_NUM_RV IS NULL              '+
                       '  AND VPGO.RED_NUM_RV IS NULL            '+
                       '  GROUP BY PG.RED_PAG_ID                 ';

    Result.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    Result.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    Result.Open;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(Concat(E.Message,' [TImportaVendasRedeCardOnline.CriaQueryPagamentosSemVenda'));
    End;
  End;
end;

procedure TImportaVendasRedeCardOnline.CriarComponenteRequisicao;
begin
  LRequisicao := TIdHTTP.Create(Nil);
  LRequisicao.IOHandler := FProtocoloSSL;
  LRequisicao.Request.Connection := 'keep-alive';
  LRequisicao.Request.ContentType := 'application/json';
  LRequisicao.Response.KeepAlive := True;
  LRequisicao.HTTPOptions := [];
  LRequisicao.OnWork := OnWork;
end;

procedure TImportaVendasRedeCardOnline.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Application);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor TImportaVendasRedeCardOnline.Destroy;
begin
  FreeAndNil(LRequisicao);
  FreeAndNil(FProtocoloSSL);
  FreeAndNil(LListaVendasPagamento);
  If Assigned(LDadosToken) Then
    FreeAndNil(LDadosToken);
  If Assigned(LPgtoSemVenda) Then
    FreeAndNil(LPgtoSemVenda);

  inherited;
end;

function TImportaVendasRedeCardOnline.EmpresaPossuiCredenciaisDeAutenticacao: Boolean;
begin
  Result := True;
  If fEmptyStr(fCfgSis('REDUSU')) Then
    Result := False
  Else If fEmptyStr(fCfgSis('REDSEN')) Then
    Result := False
  Else If fEmptyStr(fCfgSis('REDCLI')) Then
    Result := False
  Else If fEmptyStr(fCfgSis('REDSEC')) Then
    Result := False;
end;

procedure TImportaVendasRedeCardOnline.GerarToken;
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

      LParametros.Add('username=' + fCfgSis('REDUSU'));
      LParametros.Add('password=' + fCfgSis('REDSEN'));

      LRequisicao := TIdHTTP.Create(Nil);
      LRequisicao.OnWork := OnWork;
      LRequisicao.IOHandler := FProtocoloSSL;
      LRequisicao.Request.ContentType := 'application/x-www-form-urlencoded';

      LRequisicao.Request.CustomHeaders.Add('Authorization: ' + RetornaChaveBasic(fCfgSis('REDCLI'),fCfgSis('REDSEC')));

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

procedure TImportaVendasRedeCardOnline.GravandoVendasImportadas;
begin
  Try
    pCriarFormularios(TfrmGravando, FGravando);
    FGravando.fExecutarAcao := GravaVendasPagamento;
    FGravando.lblGravando.Caption := 'Aguarde... Gravando Vendas Importadas.';
    FGravando.ShowModal;
  Finally
    FreeAndNil(FGravando);
  End;
end;

function TImportaVendasRedeCardOnline.GravaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LGravaVendasPagamento : TUniQuery;
    LVenda: TVendasPagamento;
begin
  Result := True;

  If (LListaVendasPagamento.Count = 0) Then
    Exit(False);

  LGravaVendasPagamento := fCriaQuery(nil);
  Try
    Try
      CarregaEstruturaTabelaVenda;
      LGravaVendasPagamento.Close;
      LGravaVendasPagamento.SQL.Clear;
      LGravaVendasPagamento.SQL.Text := 'REPLACE INTO RED_APVPGO (' + LCamposTabelaVenda + ') ' +
                                        ' VALUES (' + LParametrosTabelaVenda + ') ';

      pgbProgresso.Position := 0;
      pgbProgresso.Properties.Max := LListaVendasPagamento.Count;
      fStartTransaction;
      For LVenda In LListaVendasPagamento Do
      Begin
        LGravaVendasPagamento.Close;

        LGravaVendasPagamento.ParamByName('RED_NUM_PV').Value := CorrigeDadosBanco(LVenda.CodigoEstabelecimento);
        LGravaVendasPagamento.ParamByName('RED_CODBAN').Value := CorrigeDadosBanco(LVenda.CodigoBandeira);
        LGravaVendasPagamento.ParamByName('RED_VALTAX').Value := CorrigeDadosBanco(LVenda.ValorTaxa);
        LGravaVendasPagamento.ParamByName('RED_VALMDR').Value := CorrigeDadosBanco(LVenda.ValorMDR);
        LGravaVendasPagamento.ParamByName('RED_STATUS').Value := CorrigeDadosBanco(LVenda.Status);
        LGravaVendasPagamento.ParamByName('RED_DTAVEN').Value := CorrigeDadosBanco(LVenda.DataVenda);
        LGravaVendasPagamento.ParamByName('RED_TAXFLE').Value := CorrigeDadosBanco(LVenda.TaxaFlex);
        LGravaVendasPagamento.ParamByName('RED_CODAUT').Value := CorrigeDadosBanco(LVenda.Autorizacao);
        LGravaVendasPagamento.ParamByName('RED_DESBAN').Value := CorrigeDadosBanco(LVenda.NomeBandeira);
        LGravaVendasPagamento.ParamByName('RED_TOKENI').Value := CorrigeDadosBanco(LVenda.Tokenizado);
        LGravaVendasPagamento.ParamByName('RED_VALFLE').Value := CorrigeDadosBanco(LVenda.ValorFlex);
        LGravaVendasPagamento.ParamByName('RED_VEN_RV').Value := CorrigeDadosBanco(LVenda.DataVencimento);
        LGravaVendasPagamento.ParamByName('RED_BRU_RO').Value := CorrigeDadosBanco(LVenda.ValorVenda);
        LGravaVendasPagamento.ParamByName('RED_NUMNSU').Value := CorrigeDadosBanco(LVenda.NSU);
        LGravaVendasPagamento.ParamByName('RED_TAXMDR').Value := CorrigeDadosBanco(LVenda.TaxaMDR);
        LGravaVendasPagamento.ParamByName('RED_NUMCAR').Value := CorrigeDadosBanco(LVenda.NumeroCartao);
        LGravaVendasPagamento.ParamByName('RED_TOTPAR').Value := CorrigeDadosBanco(LVenda.TotalParcelas);
        LGravaVendasPagamento.ParamByName('RED_CODPRO').Value := CorrigeDadosBanco(LVenda.CodigoProduto);
        LGravaVendasPagamento.ParamByName('RED_TIPREG').Value := CorrigeDadosBanco(LVenda.Modalidade);
        LGravaVendasPagamento.ParamByName('RED_VALBRU').Value := CorrigeDadosBanco(LVenda.ValorBruto);
        LGravaVendasPagamento.ParamByName('RED_BRUPAR').Value := CorrigeDadosBanco(LVenda.ValorBrutoOriginal);
        LGravaVendasPagamento.ParamByName('RED_VALDES').Value := CorrigeDadosBanco(LVenda.ValorDesconto);
        LGravaVendasPagamento.ParamByName('RED_DESPAR').Value := CorrigeDadosBanco(LVenda.ValorDescontoOriginal);
        LGravaVendasPagamento.ParamByName('RED_VALLIQ').Value := CorrigeDadosBanco(LVenda.ValorLiquido);
        LGravaVendasPagamento.ParamByName('RED_LIQPAR').Value := CorrigeDadosBanco(LVenda.ValorLiquidoOriginal);
        LGravaVendasPagamento.ParamByName('RED_MDRPAR').Value := CorrigeDadosBanco(LVenda.ValorMDROriginal);
        LGravaVendasPagamento.ParamByName('RED_VDHASH').Value := CorrigeDadosBanco(LVenda.HashVenda);
        LGravaVendasPagamento.ParamByName('RED_ALTVLR').Value := CorrigeDadosBanco(LVenda.AlteracaoDeValor);
        LGravaVendasPagamento.ParamByName('RED_NUM_RV').Value := CorrigeDadosBanco(LVenda.ResumoVenda);
        LGravaVendasPagamento.ParamByName('RED_VDFLEX').Value := CorrigeDadosBanco(LVenda.Flex);
        LGravaVendasPagamento.ParamByName('RED_CODMOD').Value := CorrigeDadosBanco(LVenda.CodigoModalidade);
        LGravaVendasPagamento.ParamByName('RED_NUMPAR').Value := CorrigeDadosBanco(LVenda.Parcela);
        LGravaVendasPagamento.ParamByName('RED_PAG_ID').Value := CorrigeDadosBanco(LVenda.IDPagamento);
        LGravaVendasPagamento.ParamByName('RED_CONCIL').Value := 0;

        LGravaVendasPagamento.ExecSQL;
        StepStatus(pgbProgresso);
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LGravaVendasPagamento);
  End;
end;

procedure TImportaVendasRedeCardOnline.ImportandoVendasDoPagamento;
begin
  Try
    pCriarFormularios(TfrmGravando, FGravando);
    FGravando.fExecutarAcao := ImportaVendasPagamento;
    FGravando.lblGravando.Caption := 'Aguarde... Importando Vendas.';
    FGravando.ShowModal;
  Finally
    FreeAndNil(FGravando);
  End;
end;

function TImportaVendasRedeCardOnline.ConsultarVenda(AEstabelecimentoVenda, AIdVenda, ANextKey: String): String;
var
  LLinkConsulta: String;
begin
  LLinkConsulta := RetornaLinkConsultaVendaID(
    AEstabelecimentoVenda,
    AIdVenda,
    ANextKey);

  Result := LRequisicao.Get(LLinkConsulta);

  if not fEmptyStr(Result) then
    Exit;

  LLinkConsulta := RetornaLinkConsultaVendaID(
    FEstabelecimentoPagamento,
    AIdVenda,
    ANextKey);

  Result := LRequisicao.Get(LLinkConsulta);
end;

function TImportaVendasRedeCardOnline.ImportaVendasPagamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LRetornoGet  : String;
    LNextKey     : String;
    LJsonRetorno : TJSONObject;
    LJsonObjectValue,
    LJsonObjectGroup : TJsonObject;
    LJsonArray: TJSONArray;
    LJsonValue: TJsonValue;
    LVendasPagamento : TVendasPagamento;
begin
  If LPgtoSemVenda.IsEmpty Then Exit(False);

  Result := True;
  Try
    TfrmGravando.fExecutarModalA(GerarToken,'Aguarde, Realizando Autenticação.', '');
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
          LRetornoGet := ConsultarVenda(LPgtoSemVenda.FieldByName('RED_NUM_PV').AsString,
                                        LPgtoSemVenda.FieldByName('RED_PAG_ID').AsString,
                                        LNextKey);

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
            LVendasPagamento := TVendasPagamento.Create;

            LVendasPagamento.IDPagamento           := LPgtoSemVenda.FieldByName('RED_PAG_ID').AsString;
            LVendasPagamento.CodigoBandeira        := RetornaValorJson(LJsonObjectValue, 'brandCode');
            LVendasPagamento.NumeroCartao          := RetornaValorJson(LJsonObjectValue, 'cardNumber');
            LVendasPagamento.CodigoEstabelecimento := RetornaValorJson(LJsonObjectValue, 'merchantId');
            LVendasPagamento.Flex                  := RetornaValorJson(LJsonObjectValue, 'flex');
            LVendasPagamento.ModalidadeProduto     := RetornaValorJson(LJsonObjectValue, 'modalityProductCode');
            LVendasPagamento.CodigoModalidade      := RetornaValorJson(LJsonObjectValue, 'modalityCode');
            LVendasPagamento.Parcela               := RetornaValorJson(LJsonObjectValue, 'installmentNumber');
            LVendasPagamento.ResumoVenda           := RetornaValorJson(LJsonObjectValue, 'rvNumber');
            LVendasPagamento.ValorMDR              := RetornaValorJson(LJsonObjectValue, 'mdrAmount', True);
            LVendasPagamento.TaxaMDR               := RetornaValorJson(LJsonObjectValue, 'mdrFee', True);
            LVendasPagamento.TaxaFlex              := RetornaValorJson(LJsonObjectValue, 'flexFee',True);
            LVendasPagamento.Tokenizado            := RetornaValorJson(LJsonObjectValue, 'tokenized');
            LVendasPagamento.TotalParcelas         := RetornaValorJson(LJsonObjectValue, 'installmentQuantity');
            LVendasPagamento.Status                := RetornaValorJson(LJsonObjectValue, 'status');
            LVendasPagamento.DataVenda             := RetornaValorJson(LJsonObjectValue, 'saleDate');
            LVendasPagamento.ValorFlexOriginal     := RetornaValorJson(LJsonObjectValue, 'originalFlexAmount',True);
            LVendasPagamento.ValorFlex             := RetornaValorJson(LJsonObjectValue, 'flexAmount',True);
            LVendasPagamento.Autorizacao           := RetornaValorJson(LJsonObjectValue, 'authorizationCode');
            LVendasPagamento.ValorTaxa             := RetornaValorJson(LJsonObjectValue, 'feeTotal',true);
            LVendasPagamento.DataVencimento        := RetornaValorJson(LJsonObjectValue, 'expirationDate');
            LVendasPagamento.NomeBandeira          := RetornaValorJson(LJsonObjectValue, 'brand');
            LVendasPagamento.ModalidadeProduto     := RetornaValorJson(LJsonObjectValue, 'modalityProduct');
            LVendasPagamento.Modalidade            := RetornaValorJson(LJsonObjectValue, 'modality');
            LVendasPagamento.ValorMDROriginal      := RetornaValorJson(LJsonObjectValue, 'originalMdrAmount',True);
            LVendasPagamento.ValorVenda            := RetornaValorJson(LJsonObjectValue, 'saleAmount', True);
            LVendasPagamento.HashVenda             := RetornaValorJson(LJsonObjectValue, 'hashUniqueSale');
            LVendasPagamento.NSU                   := RetornaValorJson(LJsonObjectValue, 'nsu');

            LJsonObjectGroup := LJsonObjectValue.GetValue('amountInfo') as TJSONObject;
            LVendasPagamento.ValorBruto             := RetornaValorJson(LJsonObjectGroup, 'amount',True);
            LVendasPagamento.ValorBrutoOriginal     := RetornaValorJson(LJsonObjectGroup, 'originalAmount',True);
            LVendasPagamento.ValorLiquido           := RetornaValorJson(LJsonObjectGroup, 'netAmount',True);
            LVendasPagamento.ValorLiquidoOriginal   := RetornaValorJson(LJsonObjectGroup, 'originalNetAmount',True);
            LVendasPagamento.ValorDesconto          := RetornaValorJson(LJsonObjectGroup, 'discountAmount',True);
            LVendasPagamento.ValorDescontoOriginal  := RetornaValorJson(LJsonObjectGroup, 'originalDiscountAmount',True);
            LVendasPagamento.AlteracaoDeValor       := RetornaValorJson(LJsonObjectGroup, 'valueChange');

            LVendasPagamento.CodigoEstabelecimento := LVendasPagamento.CodigoEstabelecimento.PadLeft(9, '0');

            LListaVendasPagamento.Add(LVendasPagamento);
            Application.ProcessMessages;

          End;


        Until LNextKey.IsEmpty;

        LPgtoSemVenda.Next;
        StepStatus(pgbProgresso);
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

procedure TImportaVendasRedeCardOnline.ImportacaoDasVendasFaltantes;
begin
  If EmpresaPossuiCredenciaisDeAutenticacao Then
  Begin
    If Not LPgtoSemVenda.IsEmpty  Then
    Begin
      ImportandoVendasDoPagamento;
      GravandoVendasImportadas;
    End;
  End;
end;

function TImportaVendasRedeCardOnline.RetornaValorJson(AObjeto: TJsonObject;
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

procedure TImportaVendasRedeCardOnline.StepStatus(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TImportaVendasRedeCardOnline.OnWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;


procedure TImportaVendasRedeCardOnline.ReimportarVendas(ADataInicial,
  ADataFinal: TDateTime);
  Var
    LTotalLiquidoPagamentos : Double;
    LTotalLiquidoVendas : Double;
    LDiferenca: Double;
begin
  Try
    LTotalLiquidoPagamentos := RetornaTotalLiquidoPagamento(ADataInicial,ADataFinal);
    LTotalLiquidoVendas :=  RetornaTotalLiquidoVendas(ADataInicial,ADataFinal);

    LDiferenca := (LTotalLiquidoPagamentos - LTotalLiquidoVendas);
    If Not ((fFormataFloat(LDiferenca, 2) <= 0.01999) And (fFormataFloat(LDiferenca, 2) >= -0.01999))  Then
    Begin
      ApagarVendasImportadas(ADataInicial,ADataFinal);
    End;

  Except
    On E: Exception Do
    Begin
      Raise  Exception.Create(E.Message);
    End;
  End;
end;

function TImportaVendasRedeCardOnline.RetiraZerosEsquerda(AString: String): String;
begin
  While AString[1] = '0' do
    Delete(AString,1,1);

  Result := AString;
end;

function TImportaVendasRedeCardOnline.RetornaChaveBasic(AClientID,AClientSecret: String): String;
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

function TImportaVendasRedeCardOnline.RetornaLinkConsultaVendaID(AEstabelecimento, AIdPamento,ANextKey: String): String;
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

  FGravando.lblGravando.Caption := 'Aguarde... Importando Vendas (Página ' + FPagina.ToString + ')';
end;

function TImportaVendasRedeCardOnline.RetornaTotalLiquidoPagamento(ADataInicial,
  ADataFinal: TDateTime): Double;
  Var
    LPagamento : TUniQuery;
begin
  Try
    LPagamento := fCriaQuery(Nil);

    LPagamento.Close;
    LPagamento.Sql.Clear;
    LPagamento.Sql.Text := 'SELECT                                            '+
                           '   SUM(RED_VALBRU - RED_VALDES) AS TOTAL_LIQUIDO  '+
                           ' FROM                                             '+
                           '   RED_APPGTO                                     '+
                           'WHERE RED_DTAPAG BETWEEN :DTAINI                  '+
                           '  AND :DTAFIM                                     ';

    LPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    LPagamento.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    LPagamento.Open;

    Result := fFormataFloat(LPagamento.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LPagamento);
  End;
end;

function TImportaVendasRedeCardOnline.RetornaTotalLiquidoVendas(ADataInicial,
  ADataFinal: TDateTime): Double;
  Var
    LVendas : TUniQuery;
begin
  Try
    LVendas := fCriaQuery(Nil);

    LVendas.Close;
    LVendas.Sql.Clear;
    LVendas.Sql.Text := 'SELECT                             '+
                        '  SUM(RED_LIQPAR) AS TOTAL_LIQUIDO '+
                        'FROM                               '+
                        '  (SELECT                          '+
                        '    RED_VEN_RV,                    '+
                        '    RED_NUM_PV,                    '+
                        '    RED_NUM_RV,                    '+
                        '    RED_NUMNSU,                    '+
                        '    RED_NUMPAR,                    '+
                        '    RED_LIQPAR                     '+
                        '  FROM                             '+
                        '    RED_APVPAR                     '+
                        '  UNION                            '+
                        '  SELECT                           '+
                        '    RED_VEN_RV,                    '+
                        '    RED_NUM_PV,                    '+
                        '    RED_NUM_RV,                    '+
                        '    RED_NUMNSU,                    '+
                        '    RED_NUMPAR,                    '+
                        '    RED_VALLIQ AS RED_LIQPAR       '+
                        '  FROM                             '+
                        '   RED_APVPGO                      '+
                        'WHERE RED_STATUS IN ("PAID","ANTICIPATED","SCHEDULLED") '+
                        ' ) AS VENDA                        '+
                        ' WHERE RED_VEN_RV BETWEEN :DTAINI  '+
                        '  AND :DTAFIM                      ';

    LVendas.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', ADataInicial);
    LVendas.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', ADataFinal);
    LVendas.Open;

    Result := fFormataFloat(LVendas.FieldByName('TOTAL_LIQUIDO').AsFloat,2);

  Finally
    FreeAndNil(LVendas);
  End;
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
