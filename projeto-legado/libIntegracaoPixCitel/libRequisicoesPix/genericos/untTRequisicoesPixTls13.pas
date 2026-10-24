unit untTRequisicoesPixTls13;

interface
Uses System.Classes, REST.Types, REST.Client, Data.Bind.Components,
     Data.Bind.ObjectScope, System.Net.URLClient, System.Net.HttpClient,
     System.Net.HttpClientComponent, System.SysUtils, System.StrUtils,
     Windows, Registry, System.JSON, idHTTP, IdBaseComponent,
     IdComponent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
     IdSSL, IdSSLOpenSSL, Vcl.Forms, HTTPSend, blcksock, synautil, ssl_openssl;

Type
  TRequisicoesPixTls13 = class
    private
      FRestClient: TRestClient;
      FRestRequest: TRestRequest;
      FRestResponse: TRestResponse;

      FNomeCertificado: String;

      FNaoPossuiCertificado: Boolean;

      function RetornaBuildNumberVersaoWindows: Integer;

      procedure OnNeedClientCertificate(const Sender: TObject;
                                        const ARequest: TURLRequest;
                                        const ACertificateList: TCertificateList;
                                        var AnIndex: Integer);

      procedure CriarComponentesRequisicao(ACodigoBanco,
                                           ALinkRequisicao: String);

      function RetornaResultadoRequisicao(ACodigoStatus,
                                          ARetornoStatus,
                                          ACodigoBanco: String): String;

      function Erro500Sicoob(AResposta,
                             ALinkRequisicao,
                             AToken,
                             AClientID,
                             AClientSecret,
                             AArquivoCrt,
                             AArquivoKey,
                             ASenhaCertificado: String): String;
    public
      constructor Create;
      destructor Destroy; override;

      function GetToken(ACodigoBanco,
                        ALinkRequisicao,
                        ANomeCertificado,
                        AChaveBasic,
                        AClientID,
                        AClientSecret: String): String;

      function GetTokenSicoob(ALinkRequisicao,
                              ANomeCertificado,
                              AClientID,
                              AClientSecret,
                              ACertificadoCRT,
                              ACertificadoKey,
                              ASenhaCertificado: String): String;

      function GetTokenSynalist(ACodigoBanco,
                                ALinkRequisicao,
                                ANomeCertificado,
                                AChaveBasic,
                                AClientID,
                                AClientSecret,
                                ACertificadoCRT,
                                ACertificadoKey,
                                ASenhaCertificado: String): String;

      function CriarCobranca(ACodigoBanco,
                             ALinkRequisicao,
                             ANomeCertificado,
                             AToken,
                             ACorpoRequisicao,
                             AClientID,
                             AClientSecret: String): String;

      function CriarCobrancaSynalist(ACodigoBanco,
                                     ALinkRequisicao,
                                     AToken,
                                     ACorpoRequisicao,
                                     AClientID,
                                     AClientSecret,
                                     AArquivoCrt,
                                     AArquivoKey,
                                     ASenhaCertificado: String): String;

      function AlterarCobranca(ACodigoBanco,
                               ALinkRequisicao,
                               ANomeCertificado,
                               AToken,
                               ACorpoRequisicao,
                               AClientID,
                               AClientSecret: String): String;

      function AlterarCobrancaSynalist(ACodigoBanco,
                                       ALinkRequisicao,
                                       AToken,
                                       ACorpoRequisicao,
                                       AClientID,
                                       AClientSecret,
                                       AArquivoCrt,
                                       AArquivoKey,
                                       ASenhaCertificado: String): String;

      function ConsultarCobrancaPorIxId(ACodigoBanco,
                                        ALinkRequisicao,
                                        ANomeCertificado,
                                        AToken,
                                        AClientID,
                                        AClientSecret: String): String;

      function ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
                                                ALinkRequisicao,
                                                AToken,
                                                AClientID,
                                                AClientSecret,
                                                AArquivoCrt,
                                                AArquivoKey,
                                                ASenhaCertificado: String): String;

      function SolicitarDevolucao(ACodigoBanco,
                                  ALinkRequisicao,
                                  ANomeCertificado,
                                  ACorpoRequisicao,
                                  AToken,
                                  AClientID,
                                  AClientSecret: String): String;

      function SolicitarDevolucaoSynalist(ACodigoBanco,
                                          ALinkRequisicao,
                                          ACorpoRequisicao,
                                          AToken,
                                          AClientID,
                                          AClientSecret,
                                          AArquivoCrt,
                                          AArquivoKey,
                                          ASenhaCertificado: String): String;

      { SHIPAY }
      function GetTokenShipay(ACodigoBanco,
                              ALinkRequisicao,
                              ANomeCertificado,
                              AChaveAccess,
                              AClientID,
                              AClientSecret: String): String;

      function CriarCobrancaShipay(ACodigoBanco,
                                   ALinkRequisicao,
                                   ANomeCertificado,
                                   AToken,
                                   ACorpoRequisicao,
                                   AClientID,
                                   AClientSecret: String): String;

      function ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
                                                 ALinkRequisicao,
                                                 ANomeCertificado,
                                                 AToken,
                                                 AClientID,
                                                 AClientSecret: String): String;

      function CancelarCobrancaShipay(ACodigoBanco,
                                      ALinkRequisicao,
                                      ANomeCertificado,
                                      AToken,
                                      AClientID,
                                      AClientSecret: String): String;

      function SolicitarDevolucaoShipay(ACodigoBanco,
                                        ALinkRequisicao,
                                        ANomeCertificado,
                                        ACorpoRequisicao,
                                        AToken,
                                        AClientID,
                                        AClientSecret: String): String;
  end;

implementation

{ TRequisicoesPixTls13 }

function TRequisicoesPixTls13.AlterarCobranca(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPATCH;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);
  FRestRequest.AddParameter('Content-Type', 'application/json', pkHTTPHEADER, [poDoNotEncode]);

  FRestRequest.AddBody(ACorpoRequisicao, TRESTContentType.ctAPPLICATION_JSON);

  if ACodigoBanco <> '756' then
    FRestRequest.Resource := ALinkRequisicao.Replace(FRestClient.BaseURL + '/', EmptyStr)
  Else
  Begin
    FRestRequest.AddParameter('client_id', AClientId, pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Resource := '';
    FRestClient.BaseURL := ALinkRequisicao;
  End;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.AlterarCobrancaSynalist(ACodigoBanco,
  ALinkRequisicao, AToken, ACorpoRequisicao, AClientID, AClientSecret,
  AArquivoCrt, AArquivoKey, ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta: String;
begin
  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.Add('Authorization: Bearer ' + AToken);
      LHTTPSend.Headers.Add('Content-Type: application/json');

      if ACodigoBanco = '756' then
      Begin
        LHTTPSend.Headers.Add('client_id: ' + AClientId);


        LHTTPSend.sock.SSL.CertificateFile := AArquivoCrt;
        LHTTPSend.sock.ssl.PrivateKeyFile  := AArquivoKey;
        LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;
      End
      Else if ACodigoBanco = '748' then
      Begin
        LHTTPSend.sock.SSL.PFXfile     := AArquivoCrt;
        LHTTPSend.Sock.SSL.KeyPassword := ASenhaCertificado;
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ACorpoRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('PATCH', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          if LHTTPSend.ResultCode.ToString = '500' then
          Begin
            if ACodigoBanco = '756' then
            Begin
              Result := Erro500Sicoob(LResposta,
                                      ALinkRequisicao,
                                      AToken,
                                      AClientID,
                                      AClientSecret,
                                      AArquivoCrt,
                                      AArquivoKey,
                                      ASenhaCertificado);

              Exit;
            End;
          End;

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                ACodigoBanco);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   ACodigoBanco);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           ACodigoBanco);
    End;
  End;
end;

function TRequisicoesPixTls13.CancelarCobrancaShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmDELETE;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);

  FRestClient.BaseURL := ALinkRequisicao;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.ConsultarCobrancaPorIxId(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmGet;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);
  FRestRequest.AddParameter('Content-Type', 'application/json', pkHTTPHEADER, [poDoNotEncode]);

  if ACodigoBanco <> '756' then
    FRestRequest.Resource := ALinkRequisicao.Replace(FRestClient.BaseURL + '/', EmptyStr)
  Else
  Begin
    FRestRequest.AddParameter('client_id', AClientId, pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Resource := '';
    FRestClient.BaseURL := ALinkRequisicao;
  End;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.ConsultarCobrancaPorIxIdSynalist(ACodigoBanco,
  ALinkRequisicao, AToken, AClientID, AClientSecret, AArquivoCrt, AArquivoKey,
  ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta: String;
begin
  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.Add('Authorization: Bearer ' + AToken);
      LHTTPSend.Headers.Add('Content-Type: application/json');

      if ACodigoBanco = '756' then
      Begin
        LHTTPSend.Headers.Add('client_id: ' + AClientId);


        LHTTPSend.sock.SSL.CertificateFile := AArquivoCrt;
        LHTTPSend.sock.ssl.PrivateKeyFile  := AArquivoKey;
        LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;
      End
      Else if ACodigoBanco = '748' then
      Begin
        LHTTPSend.sock.SSL.PFXfile     := AArquivoCrt;
        LHTTPSend.Sock.SSL.KeyPassword := ASenhaCertificado;
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      If LHTTPSend.HTTPMethod('GET', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                ACodigoBanco);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   ACodigoBanco);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           ACodigoBanco);
    End;
  End;
end;

function TRequisicoesPixTls13.ConsultarCobrancaPorOrderIdShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, AToken, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmGet;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);

  FRestRequest.Resource := '';
  FRestClient.BaseURL := ALinkRequisicao;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

constructor TRequisicoesPixTls13.Create;
begin

end;

function TRequisicoesPixTls13.CriarCobranca(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPUT;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);
  FRestRequest.AddParameter('Content-Type', 'application/json', pkHTTPHEADER, [poDoNotEncode]);

  FRestRequest.AddBody(ACorpoRequisicao, TRESTContentType.ctAPPLICATION_JSON);

  if ACodigoBanco <> '756' then
    FRestRequest.Resource := ALinkRequisicao.Replace(FRestClient.BaseURL + '/', EmptyStr)
  Else
  Begin
    FRestRequest.AddParameter('client_id', AClientId, pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Resource := '';
    FRestClient.BaseURL := ALinkRequisicao;
  End;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.CriarCobrancaShipay(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AToken, ACorpoRequisicao, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPOST;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);

  FRestRequest.AddBody(ACorpoRequisicao, TRESTContentType.ctAPPLICATION_JSON);

  FRestClient.BaseURL := ALinkRequisicao;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.CriarCobrancaSynalist(ACodigoBanco,
  ALinkRequisicao, AToken, ACorpoRequisicao, AClientID, AClientSecret,
  AArquivoCrt, AArquivoKey, ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta: String;
begin
  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.Add('Authorization: Bearer ' + AToken);
      LHTTPSend.Headers.Add('Content-Type: application/json');

      if ACodigoBanco = '756' then
      Begin
        LHTTPSend.Headers.Add('client_id: ' + AClientId);


        LHTTPSend.sock.SSL.CertificateFile := AArquivoCrt;
        LHTTPSend.sock.ssl.PrivateKeyFile  := AArquivoKey;
        LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;
      End
      Else if ACodigoBanco = '748' then
      Begin
        LHTTPSend.sock.SSL.PFXfile     := AArquivoCrt;
        LHTTPSend.Sock.SSL.KeyPassword := ASenhaCertificado;
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ACorpoRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('PUT', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          if LHTTPSend.ResultCode.ToString = '500' then
          Begin
            if ACodigoBanco = '756' then
            Begin
              Result := Erro500Sicoob(LResposta,
                                      ALinkRequisicao,
                                      AToken,
                                      AClientID,
                                      AClientSecret,
                                      AArquivoCrt,
                                      AArquivoKey,
                                      ASenhaCertificado);

              Exit;
            End;
          End;

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                ACodigoBanco);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   ACodigoBanco);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           ACodigoBanco);
    End;
  End;
end;

procedure TRequisicoesPixTls13.CriarComponentesRequisicao(ACodigoBanco,
  ALinkRequisicao: String);
begin
  FRestClient := TRestClient.Create(Nil);
  FRestClient.RaiseExceptionOn500 := False;
  FRestClient.SynchronizedEvents := True;
  FRestClient.HandleRedirects := True;
  FRestClient.OnNeedClientCertificate := OnNeedClientCertificate;

  FRestResponse := TRESTResponse.Create(Nil);

  FRestRequest := TRestRequest.Create(Nil);
  FRestRequest.Client := FRestClient;
  FRestRequest.Response := FRestResponse;

  if ACodigoBanco = '748' then
  Begin
    FRestClient.BaseURL := LeftStr(ALinkRequisicao, 31);
    if Pos('api-pix-h', ALinkRequisicao) > 0 then
      FRestClient.BaseURL := LeftStr(ALinkRequisicao, 32);
  End;
end;

destructor TRequisicoesPixTls13.Destroy;
begin
  if Assigned(FRestRequest) then
    FreeAndNil(FRestRequest);

  if Assigned(FRestResponse) then
    FreeAndNil(FRestResponse);

  if Assigned(FRestClient) then
    FreeAndNil(FRestClient);
end;

function TRequisicoesPixTls13.Erro500Sicoob(AResposta, ALinkRequisicao,
  AToken, AClientID, AClientSecret, AArquivoCrt, AArquivoKey,
  ASenhaCertificado: String): String;
begin
  Result := ConsultarCobrancaPorIxIdSynalist('756',
                                             ALinkRequisicao,
                                             AToken,
                                             AClientID,
                                             AClientSecret,
                                             AArquivoCrt,
                                             AArquivoKey,
                                             ASenhaCertificado);
  if Pos('"status":', Result) <= 0 then
    Result := RetornaResultadoRequisicao('500',
                                         AResposta,
                                         '756');
end;

function TRequisicoesPixTls13.GetToken(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AChaveBasic, AClientID, AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/x-www-form-urlencoded';
  FRestRequest.Accept := 'application/x-www-form-urlencoded';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPOST;
  FRestRequest.Params.Clear;

  if ACodigoBanco <> '756' then
  Begin
    FRestRequest.AddParameter('Authorization', AChaveBasic, pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.AddParameter('Content-Type', 'application/x-www-form-urlencoded', pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Resource := ALinkRequisicao.Replace(FRestClient.BaseURL + '/', EmptyStr);
  End
  Else
  Begin
    FRestRequest.AddParameter('grant_type', 'client_credentials', pkGETorPOST, [poDoNotEncode]);
    FRestRequest.AddParameter('client_id', AClientId, pkGETorPOST, [poDoNotEncode]);
    FRestRequest.AddParameter('client_secret', AClientSecret, pkGETorPOST, [poDoNotEncode]);
    FRestRequest.AddParameter('scope', 'cob.read cob.write pix.read pix.write', pkGETorPOST, [poDoNotEncode]);
    FRestClient.BaseURL := ALinkRequisicao;
  End;

  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.GetTokenSicoob(ALinkRequisicao,
                                             ANomeCertificado,
                                             AClientID,
                                             AClientSecret,
                                             ACertificadoCRT,
                                             ACertificadoKey,
                                             ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta,
    LDadosRequisicao: String;
Begin
  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/x-www-form-urlencoded; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.Add('Content-Type: application/x-www-form-urlencoded');

      LDadosRequisicao := 'grant_type=client_credentials&' +
                          'client_id=' + AClientID + '&' +
                          'client_secret=' + AClientSecret + '&' +
                          'scope=cob.read cob.write pix.read pix.write';

      LHTTPSend.sock.SSL.CertificateFile := ACertificadoCRT;
      LHTTPSend.sock.ssl.PrivateKeyFile  := ACertificadoKey;
      LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('POST', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                '756');
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   '756');
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           '756');
    End;
  End;
End;

function TRequisicoesPixTls13.GetTokenSynalist(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AChaveBasic, AClientID, AClientSecret, ACertificadoCRT,
  ACertificadoKey, ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta,
    LDadosRequisicao: String;
Begin
  Try
    Try
      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/x-www-form-urlencoded; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LDadosRequisicao := '';

      If ACodigoBanco <> '748' Then
      Begin
        LHTTPSend.sock.SSL.CertificateFile := ACertificadoCRT;
        LHTTPSend.sock.ssl.PrivateKeyFile  := ACertificadoKey;
        LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;
      End
      Else
      Begin
        LHTTPSend.Sock.SSL.PFXfile     := ACertificadoCRT;
        LHTTPSend.Sock.SSL.KeyPassword := ASenhaCertificado;

        LHTTPSend.Headers.Add('Content-Type: application/x-www-form-urlencoded');
        LHTTPSend.Headers.Add('Authorization: ' + AChaveBasic);
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      if ACodigoBanco <> '748' Then
      Begin
        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;
      End;

      If LHTTPSend.HTTPMethod('POST', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                ACodigoBanco);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   ACodigoBanco);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           ACodigoBanco);
    End;
  End;
end;

function TRequisicoesPixTls13.GetTokenShipay(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, AChaveAccess, AClientID, AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPOST;
  FRestRequest.Params.Clear;

  FRestRequest.Params.AddBody('{' +
                              '  "access_key": "' + AChaveAccess + '",' +
                              '  "client_id": "' + AClientID + '",' +
                              '  "secret_key": "' + AClientSecret + '"' +
                              '}', ctAPPLICATION_JSON);

  FRestClient.BaseURL := ALinkRequisicao;

  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

procedure TRequisicoesPixTls13.OnNeedClientCertificate(const Sender: TObject;
  const ARequest: TURLRequest; const ACertificateList: TCertificateList;
  var AnIndex: Integer);
  Var
    LContador: Integer;
begin
  for LContador := 0 to ACertificateList.Count - 1 do
  Begin
    if FNomeCertificado.Trim = ACertificateList[LContador].CertName.Trim then
      AnIndex := LContador;
  End;

  FNaoPossuiCertificado := AnIndex = -1;
end;

function TRequisicoesPixTls13.RetornaBuildNumberVersaoWindows: Integer;
  Var
    LRegistro: TRegistry;
Begin
  Try
    LRegistro := TRegistry.Create;
    LRegistro.Access := KEY_READ;
    LRegistro.RootKey := HKEY_LOCAL_MACHINE;

    LRegistro.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\', true);

    Result := 0;
    Try
      If LRegistro.ReadString('CurrentBuild') <> '' Then
        Result := StrToInt(LRegistro.ReadString('CurrentBuild'));
    Except

    End;
  Finally
    FreeAndNil(LRegistro);
  End;
end;

function TRequisicoesPixTls13.RetornaResultadoRequisicao(ACodigoStatus,
  ARetornoStatus, ACodigoBanco: String): String;
  Var
    LJsonObject: TJsonObject;
begin
  Result := '{"codigo": "' + ACodigoStatus + '", ' +
            ' "resultado": ' + ARetornoStatus + '}';

  if MatchStr(ACodigoStatus, ['200', '201']) then
    Exit;

  if ACodigoBanco = '756' then
  Begin
    Try
      LJsonObject := TJSONObject.ParseJSONValue(ARetornoStatus) as TJSONObject;

      If LJsonObject.GetValue('detail') <> Nil Then
      Begin
        Result := '{"codigo": "' + ACodigoStatus + '", ' +
                  ' "resultado": "' + LJsonObject.GetValue<String>('detail') + '"}';
      End;

      LJsonObject.Free;
    Except

    End;

    Exit;
  End;


  if Not FNomeCertificado.IsEmpty then
  Begin
    if FNaoPossuiCertificado then
      Result := '{"codigo": "990", ' +
                ' "resultado": "O equipamento não possui o certificado PFX instalado."}'
    Else
    Begin
      If RetornaBuildNumberVersaoWindows < 9200 Then
      Begin
        if Pos('sicredi', FRestClient.BaseURL.ToLower) > 0 then
          Result := '{"codigo": "991", ' +
                    ' "resultado": "O recebimento por Pix para o banco Sicredi deve utilizado ' +
                                   'em equipamentos com a versão do Windows 8.1 ou superior."}';
      End;
    End;
  End;
end;

function TRequisicoesPixTls13.SolicitarDevolucao(ACodigoBanco, ALinkRequisicao,
  ANomeCertificado, ACorpoRequisicao, AToken, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmPUT;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);

  if ACodigoBanco <> '756' then
  Begin
    FRestRequest.AddParameter('Content-Type', 'application/json', pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.Resource := ALinkRequisicao.Replace(FRestClient.BaseURL + '/', EmptyStr);
    FRestRequest.AddBody(ACorpoRequisicao, TRESTContentType.ctAPPLICATION_JSON);
  End
  Else
  Begin
    FRestClient.AutoCreateParams := True;
    FRestRequest.AutoCreateParams := True;
    FRestClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRestRequest.AddParameter('client_id', AClientId, pkHTTPHEADER, [poDoNotEncode]);
    FRestRequest.AddParameter('Body', ACorpoRequisicao, pkREQUESTBODY, [poDoNotEncode]);
    FRestRequest.Params[2].ContentType := ctAPPLICATION_JSON;

    FRestRequest.Resource := '';
    FRestClient.BaseURL := ALinkRequisicao;
  End;

  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.SolicitarDevolucaoShipay(ACodigoBanco,
  ALinkRequisicao, ANomeCertificado, ACorpoRequisicao, AToken, AClientID,
  AClientSecret: String): String;
begin
  FNomeCertificado := ANomeCertificado;

  CriarComponentesRequisicao(ACodigoBanco,
                             ALinkRequisicao);

  FRestClient.Accept := 'application/json';
  FRestRequest.Accept := 'application/json';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestRequest.AcceptCharset := 'utf-8, *;q=0.8';

  FRestRequest.Method := rmDELETE;
  FRestRequest.Params.Clear;
  FRestRequest.AddParameter('Authorization', 'Bearer ' + AToken, pkHTTPHEADER, [poDoNotEncode]);

  FRestRequest.AddBody(ACorpoRequisicao, TRESTContentType.ctAPPLICATION_JSON);

  FRestClient.BaseURL := ALinkRequisicao;
  FRestRequest.Execute;

  Result := RetornaResultadoRequisicao(FRestResponse.StatusCode.ToString,
                                       FRestResponse.Content,
                                       ACodigoBanco);
end;

function TRequisicoesPixTls13.SolicitarDevolucaoSynalist(ACodigoBanco,
  ALinkRequisicao, ACorpoRequisicao, AToken, AClientID, AClientSecret,
  AArquivoCrt, AArquivoKey, ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta: String;
begin
  Try
    Try
      LHTTPSend :=THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LHTTPSend.Headers.Add('Authorization: Bearer ' + AToken);
      LHTTPSend.Headers.Add('Content-Type: application/json');

      if ACodigoBanco = '756' then
      Begin
        LHTTPSend.Headers.Add('client_id: ' + AClientId);


        LHTTPSend.sock.SSL.CertificateFile := AArquivoCrt;
        LHTTPSend.sock.ssl.PrivateKeyFile  := AArquivoKey;
        LHTTPSend.Sock.SSL.KeyPassword     := ASenhaCertificado;
      End
      Else if ACodigoBanco = '748' then
      Begin
        LHTTPSend.sock.SSL.PFXfile     := AArquivoCrt;
        LHTTPSend.Sock.SSL.KeyPassword := ASenhaCertificado;
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 90000 );
      LHTTPSend.Sock.ConnectionTimeout   := 90000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 90000;
      LHTTPSend.Sock.SocksTimeout        := 90000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 90000;

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(ACorpoRequisicao)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
      End;

      If LHTTPSend.HTTPMethod('PUT', ALinkRequisicao) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          if LHTTPSend.ResultCode.ToString = '500' then
          Begin
            if ACodigoBanco = '756' then
            Begin
              Result := Erro500Sicoob(LResposta,
                                      ALinkRequisicao,
                                      AToken,
                                      AClientID,
                                      AClientSecret,
                                      AArquivoCrt,
                                      AArquivoKey,
                                      ASenhaCertificado);

              Exit;
            End;
          End;

          Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                LResposta,
                                                ACodigoBanco);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                   LHTTPSend.Sock.LastErrorDesc,
                                   ACodigoBanco);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message,
                                           ACodigoBanco);
    End;
  End;
end;

end.
