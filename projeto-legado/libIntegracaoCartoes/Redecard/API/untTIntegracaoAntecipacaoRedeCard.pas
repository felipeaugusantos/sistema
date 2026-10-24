unit untTIntegracaoAntecipacaoRedeCard;

interface

Uses untFuncoesSimples,System.JSON,System.StrUtils,System.SysUtils,REST.Types, REST.Client,
     Vcl.Forms,untFuncoes,untIDataset,Variants, untConstantes,System.Classes,
     System.NetEncoding,System.DateUtils,Winapi.ShellAPI,Winapi.Windows,
     untGravando,IdHTTP, idComponent,idAntiFreeze, IdSSLOpenSSL,HTTPSend,
     blcksock, synautil, ssl_openssl,System.ZLib, IdCompressorZlib,
     untConfirmaAntecipacaoRedeCard;


Type
  TDadosAcesso = Record
    ClientId: String;
    SecretCode: String;
    Usuario: String;
    Senha: String;
    ChaveBasic: String;
    ChaveSecretaCitel: String;
    DocumentoEmpresa: String;
    Code: String;
    Error: String;
    RefreshToken: String;
  End;

Type
  TDadosToken = Record
  private
    Access_Token : String;
    Expiracao: Integer;
    RefreshToken: String;
    RefreshTime: TTime;
    Exception : String;
    function GetAccessToken: String;
    function ExecutarRefreshToken:Boolean;
  Public
    Property AccessToken : String Read GetAccessToken Write Access_Token;
  end;

Type
  TDadosRequisicao = Record
    CodigoEstabelecimento,
    DataRecebimento,
    SaldoComGravame,
    TipoAntecipacao,
    ModalidadeRecebiveis,
    FiltrandoPor,
    Saldo,
    DataInicial,
    DataFinal,
    PercentualDesconto,
    CodigoOperador: String;
  private
    function RetornaCodigoEstabelecimento:String;
    function RetornaCodigoDataRecebimento:String;
    function RetornaCodigoSaldoGravame:String;
    function RetornaCodigoTipoAntecipacao:String;
    function RetornaCodigoModalidadeRecebiveis:String;
    function RetornaCodigoFiltroPor:String;
    function RetornaDataInicial:String;
    function RetornaDataFinal:String;
  public
    property Estabelecimento:            String    Read RetornaCodigoEstabelecimento;
    property CodigoDataRecebimento:      String    Read RetornaCodigoDataRecebimento;
    property CodigoSaldoGravame:         String    Read RetornaCodigoSaldoGravame;
    property CodigoTipoAntecipacao:      String    Read RetornaCodigoTipoAntecipacao;
    property CodigoModalidadeRecebiveis: String    Read RetornaCodigoModalidadeRecebiveis;
    property CodigoFiltrarPor:           String    Read RetornaCodigoFiltroPor;
    property DataInicio:                 String    Read RetornaDataInicial;
    property DataFim:                    String    Read RetornaDataFinal;
  End;

Type
  TIntegracaoAntecipacaoRedeCard = class(TObject)
  private
    FRestClient: TRestClient;
    FRestRequest: TRestRequest;
    FRestResponse: TRestResponse;
    FHTTPSend: THTTPSend;

    FHomologacao: Boolean;

    FUrlToken,
    FUrlConsentimento,
    FUrlSimulacao,
    FUrlEfetivacao,
    FUrlCallBack,
    FUrlConsultaSaldo,
    FAmbiente: String;

    FAutorizacao: TDadosAcesso;
    FDadosToken : TDadosToken;
    FDadosRequisicao: TDadosRequisicao;

    FBuscarCode: Boolean;

    FTotalLivre,
    FTotalGravame: String;

    FSimulacaoHOJE:String;
    FSimulacaoUTIL:String;
    FHoraAntecipacao:TTime;

    FProximoDiaUtil: Boolean;
    FAntecipacaoRealizada: Boolean;
    FConsultouSaldo : Boolean;
    FSimulou:Boolean;

    function RetornaRequisicaoSimulacao: String;
    function RetornaChaveBasic(AClientID,AClientSecret: String): String;
    procedure CriarComponentesRequisicao;
    function RetornaSQLInsertSimulacao: String;
    procedure OnAfterExecute(Sender: TCustomRESTRequest);
    function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
    function CorrigeDadosBanco(AValor: Variant): Variant;
    procedure CarregaURL;
    procedure GerarToken;
    procedure CarregaCredenciaisAcesso;
  //procedure GerarTokenClientCredentials; comentada, vai que um dia precisa...
    procedure GerarTokenAuthorizationCode;
    function RetornaCodeConsentimento: Boolean;
    function RetornaUrlRetornaCode:String;
    function RetornaUrlConsentimento:String;
    function RetornaRefreshToken(AGrantType: String):String;
    procedure GerarTokenRefresh;
    function PedirConsentimento: Boolean;
    procedure GravarRetornoRequisicaoToken(AJSONRetorno: String; AGrantType:String);
    function OnExceptionRequisicao(AStatusCode: Integer; AStatusText: String) : Boolean;
    function MensagemErro422(AStatusCode: Integer; AStatusText: String) : String;
    function MensagemErro403(AStatusCode: Integer; AStatusText: String) : String;
    function MensagemErro504(AStatusCode: Integer; AStatusText: String) : String;
    procedure RealizaSimulacaoAntecipacao;
    procedure EfetivarAntecipacao;
    procedure ConfirmarAntecipacao;
    function AceitaAntecipar: Boolean;
    procedure GravarAntecipacao(ARetorno, ARequisicao: String; AEfetivacao:Boolean);
    function RetornaTotalGravame:String;
    function RetornaTotalLivre:String;
    function RetornaTotalDisponivel:String;
    procedure MarcarSimulacaoComoConfirmada(AAutoincrem:String);
    function RetornaAutoIcremSimulacaoEfetivada:String;
    function RetornaMensagemRecebimento:String;
    function RetornaSeExisteConfiguracaoVazia:Boolean;
  public
    Constructor Create; reintroduce;
    Destructor Destroy; override;
    procedure RealizarAntecipacao;
    function VerificarSeGerouCodeConsentimento: Boolean;
    procedure RealizarConcessaDeAutorizacao;
    procedure ConsultaSaldo;

    property BuscarCode:           Boolean          Read FBuscarCode             Write FBuscarCode;
    property Autorizacao:          TDadosAcesso     Read FAutorizacao;
    property DadosRequisicao:      TDadosRequisicao Read FDadosRequisicao        Write FDadosRequisicao;
    property TotalLivre:           String           Read RetornaTotalLivre       write FTotalLivre;
    property TotalGravame:         String           Read RetornaTotalGravame     write FTotalGravame;
    property TotalDisponivel:      String           read RetornaTotalDisponivel;
    property AntecipacaoRealizada: Boolean          read FAntecipacaoRealizada;
    property SimulacaoEfetivada:   String           Read RetornaAutoIcremSimulacaoEfetivada;
    property MensagemRecebimento:  String           Read RetornaMensagemRecebimento;
    property ConsultouSaldo:       Boolean          Read FConsultouSaldo;
    property ExisteConfiguracaoVazia : Boolean     Read RetornaSeExisteConfiguracaoVazia;

  End;

implementation

{ TIntegracaoAntecipacaoRedeCard }

function TIntegracaoAntecipacaoRedeCard.AceitaAntecipar: Boolean;
  Var
    qryDados: IDataset;
    LConfirmaAntecipacaoRedeCard: TfrmConfirmaAntecipacaoRedeCard;
begin
  Try
    qryDados := objFunctions.fGetDataSet;
    qryDados.Close;

    qryDados.SQL := ' SELECT                                   '+
                    '   RED_VALBRU,                            '+
                    '  (RED_VALBRU - RED_VALLIQ) AS DESCONTO,  '+
                    '   RED_VALTAX,                            '+
                    '   RED_VALLIQ                             '+
                    ' FROM                                     '+
                    '   RED_CADANT WHERE AUTOINCREM = :AUTINC  ';

    Try
      qryDados.ParamByName('AUTINC').AsString := FSimulacaoHOJE;
      qryDados.Open;

      pCriarFormularios(TfrmConfirmaAntecipacaoRedeCard,LConfirmaAntecipacaoRedeCard);
      LConfirmaAntecipacaoRedeCard.lblTotalAntecipado.Caption := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALBRU').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalDesconto.Caption   := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('DESCONTO').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalTaxa.Caption       :=  FormatFloat('#,######0.000000%', qryDados.FieldByName('RED_VALTAX').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalLiquido.Caption    := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALLIQ').AsFloat);

      qryDados.Close;
      qryDados.ParamByName('AUTINC').AsString := FSimulacaoUTIL;
      qryDados.Open;

      LConfirmaAntecipacaoRedeCard.lblTotalAntecipadoUtil.Caption := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALBRU').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalDescontoUtil.Caption   := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('DESCONTO').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalTaxaUtil.Caption       :=  FormatFloat('#,######0.000000%', qryDados.FieldByName('RED_VALTAX').AsFloat);
      LConfirmaAntecipacaoRedeCard.lblTotalLiquidoUtil.Caption    := 'R$ ' + FormatFloat('#,##0.00', qryDados.FieldByName('RED_VALLIQ').AsFloat);

      LConfirmaAntecipacaoRedeCard.ShowModal;

      Result := LConfirmaAntecipacaoRedeCard.Continuar;
      FProximoDiaUtil := LConfirmaAntecipacaoRedeCard.ProximoDiaUtil;

    Finally
      FreeAndNil(LConfirmaAntecipacaoRedeCard);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TIntegracaoAntecipacaoRedeCard.CarregaCredenciaisAcesso;
begin
  FAutorizacao.RefreshToken      := RetornaRefreshToken('authorization_code');
  FAutorizacao.SecretCode        := fRetornaValorConfiguracao('CFG_ATRSEC',VS_strCodEmp);
  FAutorizacao.ClientId          := fRetornaValorConfiguracao('CFG_ATRCLI',VS_strCodEmp);
  FAutorizacao.ChaveSecretaCitel := fRetornaValorConfiguracao('CFG_CHARED',VS_strCodEmp);
  FAutorizacao.Usuario           := fRetornaValorConfiguracao('CFG_ATRUSU',VS_strCodEmp);
  FAutorizacao.Senha             := fRetornaValorConfiguracao('CFG_ATRSEN',VS_strCodEmp);
  FAutorizacao.ChaveBasic        := RetornaChaveBasic(FAutorizacao.ClientId,FAutorizacao.SecretCode);
  FAutorizacao.DocumentoEmpresa  := fRetCGCEmpresa(VS_strCodEmp) + FormatDateTime('yyyymmdd', Date) + FormatDateTime('hhmmss', fTime());
end;

procedure TIntegracaoAntecipacaoRedeCard.CarregaURL;
begin
  FUrlToken         := fRetornaValorConfiguracao('CFG_URLTAR',VS_strCodEmp);
  FUrlConsentimento := fRetornaValorConfiguracao('CFG_URLCAR',VS_strCodEmp);
  FUrlSimulacao     := fRetornaValorConfiguracao('CFG_URLSAR',VS_strCodEmp);
  FUrlEfetivacao    := fRetornaValorConfiguracao('CFG_URLEAR',VS_strCodEmp);
  FUrlCallBack      := fRetornaValorConfiguracao('CFG_URLCBR',VS_strCodEmp);
  FUrlConsultaSaldo := fRetornaValorConfiguracao('CFG_URLCSR',VS_strCodEmp);
  FAmbiente := 'PRODUÇÃO';


  If FHomologacao Then
  Begin
    FAmbiente         := 'HOMOLOGAÇÃO';
    FUrlToken         := 'https://api-hom.userede.com.br/redelabs/oauth2/token';
    FUrlConsentimento := 'https://auth-hom.useredecloud.com.br/api/oauth2/authorize';
    FUrlSimulacao     := 'https://api-hom.userede.com.br/redelabs/anticipation/zenite/simulate';
    FUrlConsultaSaldo := 'https://api-hom.userede.com.br/redelabs/anticipation/zenite/balance/';
    FUrlEfetivacao    := 'https://api-hom.userede.com.br/redelabs/anticipation/zenite/hire';
  End;
end;


procedure TIntegracaoAntecipacaoRedeCard.ConfirmarAntecipacao;
begin
  If Not AceitaAntecipar Then
    Exit;

  FDadosRequisicao.DataRecebimento := IIF(FProximoDiaUtil,'Próximo dia Útil','Hoje');
  AguardeExecutarModalA(EfetivarAntecipacao,'Aguarde, Confirmando Antecipação.', '');
end;

procedure TIntegracaoAntecipacaoRedeCard.ConsultaSaldo;
  Var
    LResposta   : String;
    LFDataResp: TMemoryStream;
    LJsonRetorno: TJSONObject;
    LJsonObjectGroup: TJsonObject;
begin
  FConsultouSaldo := False;
  Try
    GerarToken;

    If fEmptyStr(FDadosToken.AccessToken) Then
      Exit;


    FHTTPSend.Headers.Clear;
    FHTTPSend.Headers.Add('Authorization: '+FDadosToken.AccessToken);
    FHTTPSend.Headers.Add('Content-Type: application/json');
    FHTTPSend.Headers.Add('Accept: application/json');

    Application.ProcessMessages;

    If FHTTPSend.HTTPMethod('GET', FUrlConsultaSaldo + FDadosRequisicao.Estabelecimento) Then
    Begin
      FHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If FHTTPSend.ResultCode <> 200 Then
        Begin
          If OnExceptionRequisicao(FHTTPSend.ResultCode,LResposta) Then
            Exit;

          Raise Exception.Create(FHTTPSend.ResultCode.ToString + ' - ' +
                                 LResposta);
        End;

      Finally
        FreeAndNil(LFDataResp);
      End;


    End;

    LJsonRetorno := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
    LJsonObjectGroup := LJsonRetorno.GetValue('object') as TJSONObject;

    FTotalGravame := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'totalNegotiatedGravame'));
    FTotalLivre   := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'totalFree'));
    FConsultouSaldo := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function TIntegracaoAntecipacaoRedeCard.CorrigeDadosBanco(
  AValor: Variant): Variant;
begin
  Result := Null;
  If Not fEmptyStr(AValor) Then
  Begin
    Result := AValor;
  End;
end;

constructor TIntegracaoAntecipacaoRedeCard.Create;
begin
  FHomologacao := fRetornaValorConfiguracao('CFG_ATRHOM',VS_strCodEmp).Equals('S');
  FBuscarCode := False;
  FProximoDiaUtil := False;
  FSimulou := False;
  FAntecipacaoRealizada := False;
  FConsultouSaldo := False;
  CarregaURL;
  CarregaCredenciaisAcesso;
  CriarComponentesRequisicao;
end;

procedure TIntegracaoAntecipacaoRedeCard.CriarComponentesRequisicao;
begin
  FRestClient := TRESTClient.Create(Nil);
  FRestClient.Accept              := 'application/json, text/plain; q=0.9, text/html;q=0.8';
  FRestClient.AcceptCharset       := 'UTF-8, *;q=0.8';
  FRestClient.ContentType         := 'application/json';
  FRestClient.HandleRedirects     := True;
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.Params.Clear;

  FRestResponse := TRESTResponse.Create(Nil);
  FRestResponse.ContentType := 'application/json';

  FRestRequest := TRESTRequest.Create(Nil);
  FRestRequest.Timeout            := 3600000;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.Client             := FRestClient;
  FRestRequest.Response           := FRestResponse;
  FRestRequest.SynchronizedEvents := False;
  FRestRequest.OnAfterExecute     := OnAfterExecute;


  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 90000 );
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;
end;

destructor TIntegracaoAntecipacaoRedeCard.Destroy;
begin
  If Assigned(FRestClient) Then
    FreeAndNil(FRestClient);

  If Assigned(FRestRequest) Then
    FreeAndNil(FRestRequest);

  If Assigned(FRestResponse) Then
    FreeAndNil(FRestResponse);

  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);
  inherited;
end;

procedure TIntegracaoAntecipacaoRedeCard.RealizarAntecipacao;
  Var
    I : Integer;
begin
  FSimulacaoHOJE := '';
  FSimulacaoUTIL := '';
  FProximoDiaUtil := False;
  FAntecipacaoRealizada := False;

  For I := 1 To  2 Do
  Begin

    If (I = 1) Then
    Begin
      If (fRetHoraServidor > StrToTime('14:20:00')) Then
      Begin
        FSimulou := True;
        Continue;
      End;
    End;


    FDadosRequisicao.DataRecebimento := IIF((I = 1),'Hoje','Próximo dia Útil');

    If Not ((I = 2) And Not FSimulou) Then
      AguardeExecutarModalA(RealizaSimulacaoAntecipacao,'Aguarde, Realizando Simulação('+I.ToString+'/2).', '');
  End;

  If Not fEmptyStr(FSimulacaoUTIL) Then
  Begin
    ConfirmarAntecipacao;
  End;
end;

procedure TIntegracaoAntecipacaoRedeCard.RealizarConcessaDeAutorizacao;
begin
  CarregaCredenciaisAcesso;

  If fEmptyStr(FAutorizacao.RefreshToken) Then
  Begin
    PedirConsentimento;
    Exit;
  End;

end;

procedure TIntegracaoAntecipacaoRedeCard.RealizaSimulacaoAntecipacao;
  Var
    LResposta   : String;
    LRequisicao : String;
    LFDataResp,
    LFDataReq: TMemoryStream;
begin

  FSimulou := False;

  Try
    GerarToken;

    If fEmptyStr(FDadosToken.AccessToken) Then
      Exit;

    FHTTPSend.Headers.Clear;
    FHTTPSend.Headers.Add('Authorization: '+FDadosToken.AccessToken);
    FHTTPSend.Headers.Add('Content-Type: application/json');
    FHTTPSend.Headers.Add('Accept: application/json');
    LRequisicao := RetornaRequisicaoSimulacao;

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LRequisicao)));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    Application.ProcessMessages;

    If FHTTPSend.HTTPMethod('POST', FUrlSimulacao) Then
    Begin
      FHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If FHTTPSend.ResultCode <> 201 Then
        Begin
          If OnExceptionRequisicao(FHTTPSend.ResultCode,LResposta) Then
            Exit;

          Raise Exception.Create(FHTTPSend.ResultCode.ToString + ' - ' +
                                 LResposta);
        End;

      Finally
        FreeAndNil(LFDataResp);
      End;

    End;

    GravarAntecipacao(LResposta, LRequisicao, False);
    FSimulou := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;


procedure TIntegracaoAntecipacaoRedeCard.EfetivarAntecipacao;
  Var
    LResposta   : String;
    LRequisicao : String;
    LFDataResp,
    LFDataReq: TMemoryStream;
begin

  Try
    GerarToken;

    If fEmptyStr(FDadosToken.AccessToken) Then
      Exit;

    FHTTPSend.Headers.Clear;
    FHTTPSend.Headers.Add('Authorization: '+FDadosToken.AccessToken);
    FHTTPSend.Headers.Add('Content-Type: application/json');
    FHTTPSend.Headers.Add('Accept: application/json');
    LRequisicao := RetornaRequisicaoSimulacao;

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LRequisicao)));
      FHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    Application.ProcessMessages;
    FHoraAntecipacao := fRetHoraServidor;

    If FHTTPSend.HTTPMethod('POST', FUrlEfetivacao) Then
    Begin
      FHTTPSend.Document.Position := 0;

      Try
        LFDataResp := TMemoryStream.Create;
        LFDataResp.LoadFromStream(FHTTPSend.Document);

        LFDataResp.Position := 0;
        LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        If FHTTPSend.ResultCode <> 201 Then
        Begin
          If OnExceptionRequisicao(FHTTPSend.ResultCode,LResposta) Then
            Exit;

          Raise Exception.Create(FHTTPSend.ResultCode.ToString + ' - ' +
                                 LResposta);
        End;

      Finally
        FreeAndNil(LFDataResp);
      End;

    End;

    GravarAntecipacao(LResposta, LRequisicao,True);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function TIntegracaoAntecipacaoRedeCard.RetornaAutoIcremSimulacaoEfetivada: String;
begin
  Result := IIF(FProximoDiaUtil,FSimulacaoUtil,FSimulacaoHOJE);
end;

function TIntegracaoAntecipacaoRedeCard.RetornaChaveBasic(AClientID,AClientSecret: String): String;
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

function TIntegracaoAntecipacaoRedeCard.RetornaCodeConsentimento: Boolean;
  Var
    LJsonObjectCode : TJSONObject;
    LResposta,
    LTimeStampRequisicao,
    LChaveBasicCitel : String;
begin
   Result := False;
  Try

    LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;
    LChaveBasicCitel :=  RetornaChaveBasic(LTimeStampRequisicao,untFuncoesSimples.GetMD5(LTimeStampRequisicao + FAutorizacao.ChaveSecretaCitel));

    FRestRequest.Params.Clear;
    FRestRequest.AddParameter('Content-Type', 'application/json', pkGETorPOST, [poAutoCreated]);
    FRestRequest.AddAuthParameter('Authorization', LChaveBasicCitel, pkHTTPHEADER, [poDoNotEncode]);

    FRestRequest.Method := rmGet;
    FRestClient.BaseUrl := RetornaUrlRetornaCode;

    FRestRequest.Execute;

    If FRestResponse.StatusCode = 404 Then
      Exit;

    If FRestResponse.StatusCode <> 200 Then
    Begin
      If OnExceptionRequisicao(FRestResponse.StatusCode,FRestResponse.StatusText) Then
        Exit;

      Raise Exception.Create(FRestResponse.StatusCode.ToString + ' - ' +
                             FRestResponse.StatusText);
    End;

    LResposta := FRestResponse.Content;

    Try
      LJsonObjectCode := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      FAutorizacao.Code :=  RetornaValorJson(LJsonObjectCode,'code');
      FAutorizacao.Error := RetornaValorJson(LJsonObjectCode,'error');
      FBuscarCode := False;
      Result := True;
    Finally
      FreeAndNil(LJsonObjectCode);
    End;

  Except

    On E:Exception Do
    Begin
      FBuscarCode := False;
      Raise Exception.Create(E.Message);
    End;
  End;

end;

function TIntegracaoAntecipacaoRedeCard.RetornaMensagemRecebimento: String;
begin
  Result := 'Você receberá o valor antecipado no próximo dia útil.';

 If Not FProximoDiaUtil Then
 Begin
   Result := 'Como você está antecipando antes das 14h20 no horário de Brasília, você receberá o valor antecipado hoje.';

   If (FHoraAntecipacao > StrToTime('14:20:00')) Then
     Result := 'Como você está antecipando após às 14h20 no horário de Brasília, você receberá o valor antecipado no próximo dia útil.';
 End;

end;

procedure TIntegracaoAntecipacaoRedeCard.GerarToken;
begin

  If Not fEmptyStr(FDadosToken.Access_Token) Then
  Begin
    If Not FDadosToken.ExecutarRefreshToken Then
    Begin
      Exit;
    End;
  End;

  CarregaCredenciaisAcesso;

  If fEmptyStr(FAutorizacao.RefreshToken) Then
  Begin
    PedirConsentimento;
    Exit;
  End;

  AguardeExecutarModalA(GerarTokenRefresh,'Aguarde, Realizando Autenticação.', '');

end;

procedure TIntegracaoAntecipacaoRedeCard.GerarTokenAuthorizationCode;
  Var
    LResposta : String;
    LJsonObject : TJSONObject;
    LIncMinute : Integer;
begin

  Try

    Try
      FRestRequest.Params.Clear;
      FRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('grant_type', 'authorization_code', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('code', FAutorizacao.Code, pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('redirect_uri', FUrlCallBack, pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddAuthParameter('Authorization', FAutorizacao.ChaveBasic, pkHTTPHEADER, [poDoNotEncode]);

      FRestRequest.Method := rmPost;

      FRestClient.BaseUrl := FUrlToken;

      FRestRequest.Execute;

      LResposta := FRestResponse.Content;

      If FRestResponse.StatusCode <> 200 Then
      Begin
        If OnExceptionRequisicao(FRestResponse.StatusCode,FRestResponse.StatusText) Then
          Exit;

        Raise Exception.Create(FRestResponse.StatusCode.ToString + ' - ' +
                               FRestResponse.StatusText);
      End;

      GravarRetornoRequisicaoToken(LResposta,'authorization_code');
      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      FDadosToken.Access_Token := RetornaValorJson(LJsonObject,'access_token');
      FDadosToken.RefreshToken := RetornaValorJson(LJsonObject,'refresh_token');
      FDadosToken.Expiracao := StrToInt(RetornaValorJson(LJsonObject,'expires_in'));

      LIncMinute := Round(FDadosToken.Expiracao/60);
      LIncMinute := (LIncMinute - 1);
      FDadosToken.RefreshTime := IncMinute(fTime(),LIncMinute);

    Except
      On E: Exception Do
      Begin
        FDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 'PRODUÇÃO. Erro:' + E.Message;
      End;
    End;
  Finally
//    LJsonObject := Nil;
  End;
end;

function TIntegracaoAntecipacaoRedeCard.RetornaRefreshToken(AGrantType: String):String;
  Var
    LArqCon : IDataSet;
    LJsonObject : TJSONObject;
begin
  Try
    LArqCon     := objFunctions.fGetDataSet;
    LArqCon.Close;
    LArqCon.SQL := 'SELECT                      '+
                   '  RED_JSORET                '+
                   'FROM                        '+
                   '  RED_TKNANT                '+
                   'WHERE RED_GRATYP = :GRATYP  ';

    LArqCon.ParamByName('GRATYP').AsString := AGrantType;
    LArqCon.Open;

    Result := LArqCon.FieldByName('RED_JSORET').AsString;

    If Not fEmptyStr(Result) Then
    Begin
      LJsonObject := TJSONObject.ParseJSONValue(Result) As TJSONObject;
      Result := RetornaValorJson(LJsonObject,'refresh_token');
    End;

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

{procedure TIntegracaoAntecipacaoRedeCard.GerarTokenClientCredentials;
  Var
    LResposta : String;
    LJsonObject : TJSONObject;
    LIncMinute : Integer;
begin

  Try

    Try
      FRestRequest.Params.Clear;
      FRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('grant_type', 'client_credentials', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddAuthParameter('Authorization', FAutorizacao.ChaveBasic, pkHTTPHEADER, [poDoNotEncode]);

      FRestRequest.Method := rmPost;

      FRestClient.BaseUrl := FUrlToken;

      FRestRequest.Execute;

      LResposta := FRestResponse.Content;

      If FRestResponse.StatusCode <> 200 Then
      Begin
        If OnExceptionRequisicao(FRestResponse.StatusCode,FRestResponse.StatusText) Then
          Exit;

        Raise Exception.Create(FRestResponse.StatusCode.ToString + ' - ' +
                               FRestResponse.StatusText);
      End;

      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      FDadosToken.Access_Token := RetornaValorJson(LJsonObject,'access_token');
      FDadosToken.RefreshToken := RetornaValorJson(LJsonObject,'refresh_token');
      FDadosToken.Expiracao := StrToInt(RetornaValorJson(LJsonObject,'expires_in'));

      LIncMinute := Round(FDadosToken.Expiracao/60);
      LIncMinute := (LIncMinute - 1);
      FDadosToken.RefreshTime := IncMinute(fTime(), LIncMinute);

    Except
      On E: Exception Do
      Begin
        FDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 'PRODUÇÃO. Erro:' + E.Message;
      End;
    End;
  Finally
   // LJsonObject := Nil;
  End;
end; }

procedure TIntegracaoAntecipacaoRedeCard.GerarTokenRefresh;
  Var
    LResposta : String;
    LJsonObject : TJSONObject;
    LIncMinute : Integer;
begin

  Try

    Try
      FRestRequest.Params.Clear;
      FRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('grant_type', 'refresh_token', pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddParameter('refresh_token', FAutorizacao.RefreshToken, pkGETorPOST, [poAutoCreated]);
      FRestRequest.AddAuthParameter('Authorization', FAutorizacao.ChaveBasic, pkHTTPHEADER, [poDoNotEncode]);

      FRestRequest.Method := rmPost;
      FRestClient.BaseUrl := FUrlToken;

      FRestRequest.Execute;

      LResposta := FRestResponse.Content;

      If FRestResponse.StatusCode <> 200 Then
      Begin
        If OnExceptionRequisicao(FRestResponse.StatusCode,FRestResponse.StatusText) Then
          Exit;

        Raise Exception.Create(FRestResponse.StatusCode.ToString + ' - ' +
                               FRestResponse.StatusText);
      End;

      GravarRetornoRequisicaoToken(LResposta,'authorization_code');
      LJsonObject := TJSONObject.ParseJSONValue(LResposta) as TJSONObject;
      FDadosToken.Access_Token := RetornaValorJson(LJsonObject,'access_token');
      FDadosToken.RefreshToken := RetornaValorJson(LJsonObject,'refresh_token');
      FDadosToken.Expiracao := StrToInt(RetornaValorJson(LJsonObject,'expires_in'));

      LIncMinute := Round(FDadosToken.Expiracao/60);
      LIncMinute := (LIncMinute - 1);
      FDadosToken.RefreshTime := IncMinute(fTime(), LIncMinute);

    Except
      On E: Exception Do
      Begin
        FDadosToken.Exception := 'Ocorreu um erro ao realizar a autenticação no servidor da RedeCard.' + #13 +
                                 'Verifique se as chaves de autenticação da conta estão liberadas para utilização no ambiente de ' +
                                 'PRODUÇÃO. Erro:' + E.Message;
      End;
    End;
  Finally
    //LJsonObject := Nil;
  End;
end;

procedure TIntegracaoAntecipacaoRedeCard.GravarRetornoRequisicaoToken(AJSONRetorno, AGrantType: String);
  Var
    LTknAnt : IDataSet;
Begin

  Try
    LTknAnt     := objFunctions.fGetDataSet;
    LTknAnt.Close;
    LTknAnt.SQL := 'REPLACE INTO RED_TKNANT (RED_JSORET, RED_GRATYP) '+
                   'VALUES (:JSORET, :GRATYP)                    ';

    LTknAnt.ParamByName('JSORET').AsString := PrettyJSON(AJSONRetorno);
    LTknAnt.ParamByName('GRATYP').AsString := AGrantType;
    LTknAnt.ExecSQL;

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

function TIntegracaoAntecipacaoRedeCard.RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := '';
  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function TIntegracaoAntecipacaoRedeCard.VerificarSeGerouCodeConsentimento: Boolean;
begin
  Result := False;

  If RetornaCodeConsentimento Then
  Begin

    If fEmptyStr(FAutorizacao.Code) Then
      Exit;

    GerarTokenAuthorizationCode;
    Result := True;
  End;

end;

procedure TIntegracaoAntecipacaoRedeCard.GravarAntecipacao(ARetorno, ARequisicao: String;AEfetivacao:Boolean);
  Var
    LJsonRetorno: TJSONObject;
    LJsonObjectGroup: TJsonObject;
    LInsert: IDataSet;
    LAutoincrem: String;
begin

  Try
    LInsert := objFunctions.fGetDataSet;
    LJsonRetorno := TJSONObject.ParseJSONValue(ARetorno) as TJSONObject;
    LJsonObjectGroup := LJsonRetorno.GetValue('object') as TJSONObject;

    Try
      LInsert.SQL := RetornaSQLInsertSimulacao;
      LInsert.Close;
      LAutoIncrem := RetornaSequencial('RED_CADANT',VS_strCodEmp);;

      If FDadosRequisicao.DataRecebimento.Equals('Hoje') Then
        FSimulacaoHOJE := LAutoIncrem
      Else
        FSimulacaoUtil := LAutoIncrem;

      LInsert.ParamByName('AUTOINCREM').AsString := LAutoIncrem;

      LInsert.ParamByName('RED_CODANT').Value := CorrigeDadosBanco(RetornaValorJson(LJsonRetorno,'code'));
      LInsert.ParamByName('RED_MSGREQ').Value := CorrigeDadosBanco(RetornaValorJson(LJsonRetorno,'message'));

      LInsert.ParamByName('RED_VALTAX').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'periodRate'));
      LInsert.ParamByName('RED_VALLIQ').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'netValue'));
      LInsert.ParamByName('RED_VALROT').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'totalRotatingAmount'));
      LInsert.ParamByName('RED_VALPAR').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'parcelAmount'));
      LInsert.ParamByName('RED_TAXEFE').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'effectiveRate'));
      LInsert.ParamByName('RED_CUSFIN').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'financialCost'));
      LInsert.ParamByName('RED_TAXMEN').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'monthRate'));
      LInsert.ParamByName('RED_DTAINI').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'initialDueDate'));
      LInsert.ParamByName('RED_DTAFIN').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'finalDueDate'));
      LInsert.ParamByName('RED_MEDPRA').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'averageTerm'));
      LInsert.ParamByName('RED_TIPPRO').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'product'));
      LInsert.ParamByName('RED_VALSPR').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'spread'));
      LInsert.ParamByName('RED_VALBRU').Value := CorrigeDadosBanco(RetornaValorJson(LJsonObjectGroup,'grossValue'));

      LInsert.ParamByName('RED_JSOENV').Value := ARequisicao;
      LInsert.ParamByName('RED_JSORET').Value := PrettyJSON(ARetorno);
      LInsert.ParamByName('RED_OPEANT').Value := strLoginUsuarioLogado;
      LInsert.ParamByName('RED_DTAANT').Value := Date;
      LInsert.ParamByName('RED_HORANT').Value := fTime();
      LInsert.ParamByName('RED_CODEST').Value := FDadosRequisicao.Estabelecimento;

      LInsert.ExecSQL;

      If AEfetivacao Then
        MarcarSimulacaoComoConfirmada(LAutoIncrem);

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    If Assigned(LJsonRetorno) Then
      FreeAndNil(LJsonRetorno);
  End;
end;

procedure TIntegracaoAntecipacaoRedeCard.MarcarSimulacaoComoConfirmada(AAutoincrem:String);
  Var
    qryDados: IDataset;
begin
  Try
    FAntecipacaoRealizada := True;

    qryDados := objFunctions.fGetDataSet;
    qryDados.Close;

    qryDados.SQL := 'UPDATE                     '+
                    ' RED_CADANT                '+
                    'SET                        '+
                    '  RED_CONTRA = "S"         '+
                    'WHERE AUTOINCREM =:AUTINC  ';

      qryDados.ParamByName('AUTINC').AsString := AAutoincrem;
      qryDados.ExecSQL;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TIntegracaoAntecipacaoRedeCard.MensagemErro403(AStatusCode: Integer;
  AStatusText: String): String;
begin
  Result :=  'Chaves de autorização, Ponto de Venda (Estabelecimento) incorretos'+
             ' ou não liberado utilização no ambiente de ' + FAmbiente + '!';
End;

function TIntegracaoAntecipacaoRedeCard.MensagemErro422(AStatusCode: Integer;
  AStatusText: String): String;
begin
   Result :='Ocorreu um erro ao conectar-se ao serviço da RedeCard.' + #13 +
            'Tente novamente mais tarde!' + #13#13 +
            'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                 AStatusText;

  If Pos(AnsiLowerCase('companyNumber no has value for anticipation'),AnsiLowerCase(AStatusText)) > 0 Then
    Result := 'Ponto de venda inválido ou não possui saldo suficiente para realizar antecipação!'

  Else if Pos(AnsiLowerCase('service temporarily unavailable'),AnsiLowerCase(AStatusText)) > 0  Then
    Result := 'O serviço da RedeCard está temporariamente indisponível.' + #13 +
              'Tente novamente mais tarde!'

  Else if Pos(AnsiLowerCase('there are no anticipation valid values'),AnsiLowerCase(AStatusText)) > 0 Then
    Result := 'Considerando os filtros informados não há saldo disponível para realizar a antecipação!'

  Else if Pos(AnsiLowerCase('Day: must be a valid value'),AnsiLowerCase(AStatusText)) > 0 Then
    Result := 'A data informada para o período de '+FDadosRequisicao.FiltrandoPor +' não é valida!'

  Else if Pos(AnsiLowerCase('Error in communicating external'),AnsiLowerCase(AStatusText)) > 0 Then
   Result :='Ocorreu um erro na comunicação externa do serviço da RedeCard.' + #13 +
            'Tente novamente mais tarde!';

end;

function TIntegracaoAntecipacaoRedeCard.MensagemErro504(AStatusCode: Integer;
  AStatusText: String): String;
begin
  Result := 'Ocorreu um erro interno no serviço da RedeCard. ' + #13 +
            'Tente novamente mais tarde!';
end;

procedure TIntegracaoAntecipacaoRedeCard.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

function TIntegracaoAntecipacaoRedeCard.PedirConsentimento: Boolean;
begin
  Result := False;

  If fMensagem('AVISO', 'Você será redirecionado para a página de consentimento da RedeCard, ' + #10#13 +
                        'onde deverá informar as credenciais do usuário master do '+ #10#13 +
                        'Portal Userede e nos conceder acesso para realizar a antecipação dos recebíveis. '  + #10#13 +
                        'Deseja continuar com a operação?', ['&Sim', '&Não'], 2) = 2 Then
  Begin
    Exit;
  End;

  FBuscarCode := True;
  ShellExecute(Application.Handle, 'open',PChar(RetornaUrlConsentimento),nil,nil,SW_SHOWMAXIMIZED);

end;

function TIntegracaoAntecipacaoRedeCard.RetornaRequisicaoSimulacao: String;
  Var
    LJsonRequisicao: TJSONObject;
begin
  Try
    LJsonRequisicao := TJsonObject.Create;

    Try
      LJsonRequisicao.AddPair('companyNumber',RetiraZerosEsquerda(FDadosRequisicao.CodigoEstabelecimento));
      LJsonRequisicao.AddPair('workingDaysToPayment',FDadosRequisicao.CodigoDataRecebimento);
      LJsonRequisicao.AddPair('anticipationGravame',FDadosRequisicao.CodigoSaldoGravame);
      LJsonRequisicao.AddPair('anticipationType',FDadosRequisicao.CodigoTipoAntecipacao);
      LJsonRequisicao.AddPair('product',FDadosRequisicao.CodigoModalidadeRecebiveis);
      LJsonRequisicao.AddPair('operationUser',FDadosRequisicao.CodigoOperador);
      LJsonRequisicao.AddPair('anticipationAmount',RetornaCampoDecimalJSON(FDadosRequisicao.Saldo));


      LJsonRequisicao.AddPair('selectionType',FDadosRequisicao.CodigoFiltrarPor);
      LJsonRequisicao.AddPair('firstDay',FDadosRequisicao.DataInicio);
      LJsonRequisicao.AddPair('lastDay',FDadosRequisicao.DataFim);

      Result := PrettyJSON(LJsonRequisicao.ToString);


    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LJsonRequisicao);
  End;


end;

function TIntegracaoAntecipacaoRedeCard.RetornaSeExisteConfiguracaoVazia: Boolean;
begin
  Result := False;

  If fEmptyStr(FUrlToken)              Then Result := True
  Else If fEmptyStr(FUrlConsentimento) Then Result := True
  Else If fEmptyStr(FUrlSimulacao)     Then Result := True
  Else If fEmptyStr(FUrlEfetivacao)    Then Result := True
  Else If fEmptyStr(FUrlCallBack)      Then Result := True
  Else If fEmptyStr(FUrlConsultaSaldo) Then Result := True

  Else If fEmptyStr(FAutorizacao.SecretCode)        Then Result := True
  Else If fEmptyStr(FAutorizacao.ClientId)          Then Result := True
  Else If fEmptyStr(FAutorizacao.ChaveSecretaCitel) Then Result := True
  Else If fEmptyStr(FAutorizacao.Usuario)           Then Result := True
  Else If fEmptyStr(FAutorizacao.Senha)             Then Result := True;

  If Result Then
    fMensagem('ATENÇÃO!', 'Para utilizar a rotina, configure todas as '+
                          'configurações do grupo: ANTECIPAÇÃO DE RECEBÍVEIS - REDECARD', ['&O k']);

end;

function TIntegracaoAntecipacaoRedeCard.RetornaSQLInsertSimulacao: String;
begin
  Result := 'INSERT INTO RED_CADANT ( '+
                'AUTOINCREM,  '+
                'RED_CODANT,  '+
                'RED_MSGREQ,  '+
                'RED_VALTAX,  '+
                'RED_VALLIQ,  '+
                'RED_VALROT,  '+
                'RED_VALPAR,  '+
                'RED_TAXEFE,  '+
                'RED_CUSFIN,  '+
                'RED_TAXMEN,  '+
                'RED_DTAINI,  '+
                'RED_DTAFIN,  '+
                'RED_MEDPRA,  '+
                'RED_TIPPRO,  '+
                'RED_VALSPR,  '+
                'RED_VALBRU,  '+
                'RED_JSOENV,  '+
                'RED_JSORET,  '+
                'RED_OPEANT,  '+
                'RED_DTAANT,  '+
                'RED_HORANT,  '+
                'RED_CODEST   '+
                ')            '+
                'VALUES       '+
                ' (           '+
               ':AUTOINCREM,  '+
               ':RED_CODANT,  '+
               ':RED_MSGREQ,  '+
               ':RED_VALTAX,  '+
               ':RED_VALLIQ,  '+
               ':RED_VALROT,  '+
               ':RED_VALPAR,  '+
               ':RED_TAXEFE,  '+
               ':RED_CUSFIN,  '+
               ':RED_TAXMEN,  '+
               ':RED_DTAINI,  '+
               ':RED_DTAFIN,  '+
               ':RED_MEDPRA,  '+
               ':RED_TIPPRO,  '+
               ':RED_VALSPR,  '+
               ':RED_VALBRU,  '+
               ':RED_JSOENV,  '+
               ':RED_JSORET,  '+
               ':RED_OPEANT,  '+
               ':RED_DTAANT,  '+
               ':RED_HORANT,  '+
               ':RED_CODEST   '+
                '  )';
end;

function TIntegracaoAntecipacaoRedeCard.RetornaTotalDisponivel: String;
  Var
    LTotal:Double;
begin
  LTotal := (fStrToFloat(Self.FTotalGravame.Replace('.',',')) + fStrToFloat(Self.FTotalLivre.Replace('.',',')));
  Result := FormatFloat('#,##0.00', LTotal);
end;

function TIntegracaoAntecipacaoRedeCard.RetornaTotalGravame: String;
begin
  Result := '0,00';

  If Not fEmptyStr(Self.FTotalGravame) Then
  Begin
    Result := FormatFloat('#,##0.00', fStrToFloat(Self.FTotalGravame.Replace('.',',')));
  End;
end;

function TIntegracaoAntecipacaoRedeCard.RetornaTotalLivre: String;
begin
  Result := '0,00';

  If Not fEmptyStr(Self.FTotalLivre) Then
  Begin
    Result := FormatFloat('#,##0.00', fStrToFloat(Self.FTotalLivre.Replace('.',',')));
  End;
end;

function TIntegracaoAntecipacaoRedeCard.RetornaUrlConsentimento: String;
begin
  Result := FUrlConsentimento
            +'?response_type=code'
            +'&client_id=' + FAutorizacao.ClientId
            +'&scope=anticipation'
            +'&redirect_uri=' + FUrlCallBack
            +'&state=' + FAutorizacao.DocumentoEmpresa
end;

function TIntegracaoAntecipacaoRedeCard.RetornaUrlRetornaCode: String;
begin
  Result := FUrlCallBack + '/consent/' + FAutorizacao.DocumentoEmpresa;
end;

{ TDadosRequisicao }

function TDadosRequisicao.RetornaCodigoDataRecebimento: String;
begin
  Result := '1';

  If Trim(Self.DataRecebimento).Equals('Hoje') Then
    Result := '0';
end;

function TDadosRequisicao.RetornaCodigoEstabelecimento: String;
begin
  Result := RetiraZerosEsquerda(Self.CodigoEstabelecimento);
end;

function TDadosRequisicao.RetornaCodigoFiltroPor: String;
begin
  Result := '';
  If Self.FiltrandoPor.Equals('Vencimento') Then
    Result := 'V'
  Else If Self.FiltrandoPor.Equals('Apresentação') Then
    Result := 'A';
end;

function TDadosRequisicao.RetornaCodigoModalidadeRecebiveis: String;
begin
  Result := 'A';

  If Trim(Self.ModalidadeRecebiveis).Equals('Rotativo') Then
    Result := 'R'

  Else If Trim(Self.ModalidadeRecebiveis).Equals('Parcelado') Then
    Result := 'P';
end;

function TDadosRequisicao.RetornaCodigoSaldoGravame: String;
begin
  Result := 'false';

  If Trim(Self.SaldoComGravame).Equals('Sim') Then
    Result := 'true';
end;

function TDadosRequisicao.RetornaCodigoTipoAntecipacao: String;
begin
  Result := 'T';

  If Trim(Self.TipoAntecipacao).Equals('Parcial') Then
    Result := 'P';
end;

function TDadosRequisicao.RetornaDataInicial: String;
begin
  Result := '';

  If Not fEmptyStr(Self.DataInicial) Then
  Begin
    Result := FormatDateTime('DD/MM/YYYY',StrToDate(Self.DataInicial));
  End;
end;

function TDadosRequisicao.RetornaDataFinal: String;
begin
  Result := '';

  If Not fEmptyStr(Self.DataFinal) Then
  Begin
    Result := FormatDateTime('DD/MM/YYYY',StrToDate(Self.DataFinal));
  End;
end;

{ TDadosToken }

function TDadosToken.GetAccessToken: String;
begin
  Result := '';

  If Not fEmptyStr(Self.Exception) Then
    Raise System.SysUtils.Exception.Create(Self.Exception)

  Else If Not fEmptyStr(Self.Access_Token) Then
    Result :=' Bearer ' + Self.Access_Token;

end;


function TDadosToken.ExecutarRefreshToken: Boolean;
begin
   Result := False;

  If (fTime() > Self.RefreshTime) Then
    Exit(True);

 If Not fEmptyStr(Self.Exception) Then
   Exit(True);
end;


function TIntegracaoAntecipacaoRedeCard.OnExceptionRequisicao(AStatusCode: Integer; AStatusText: String): Boolean;
  Var
    LMensagem : String;
    LJsonObject : TJSONObject;
    LMsgJson: String;
begin
  Result := False;

  Try
    LJsonObject := TJSONObject.ParseJSONValue(AStatusText) as TJSONObject;
    LJsonObject := LJsonObject.GetValue('errors') as TJSONObject;
    LMsgJson :=  RetornaValorJson(LJsonObject,'message');

    If Not fEmptyStr(LMsgJson) Then
      AStatusText := LMsgJson;
  Except
    //
  End;


  if AStatusCode = 400 Then
  Begin
    LMensagem := 'Requisição incorreta, verifique se os campos estão preenchidos corretamente!'  + #13#13 +
                               'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                                    AStatusText;
  End
  Else If AStatusCode = 401 Then
  Begin
    LMensagem := 'Chaves de autorização, Ponto de Venda (Estabelecimento) incorretas ou não liberado utilização no ambiente de ' + FAmbiente + '!' + #13#13 +
                               'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                                    AStatusText;
  End
  Else
  Begin
    LMensagem :='Ocorreu um erro ao conectar-se ao serviço da RedeCard.' + #13 +
                           'Tente novamente mais tarde!' + #13#13 +
                           'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                                AStatusText;

    Case AStatusCode Of
      403 : LMensagem := MensagemErro403(AStatusCode,AStatusText);

      422 : LMensagem := MensagemErro422(AStatusCode,AStatusText);

      404 : LMensagem := 'O serviço da RedeCard não encontrou algo!' + #13#13 +
                         'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                              AStatusText;

      503 : LMensagem := 'O serviço da RedeCard está com problemas no funcionamento. Tente novamente mais tarde!' + #13#13 +
                         'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                              AStatusText;
      504 : LMensagem := MensagemErro504(AStatusCode,AStatusText);

      500 : LMensagem :='Ocorreu um erro interno no serviço da RedeCard. ' + #13 +
                        'Tente novamente mais tarde!' + #13#13 +
                        'Código do Retorno API RedeCard: ' + AStatusCode.ToString + '-' +
                                                             AStatusText;
    End;


  End;

  If Not fEmptyStr(LMensagem) Then
  Begin
    fMensagem('ATENÇÃO!', LMensagem, ['&O k']);
    Result := True;
  End;
end;

end.
