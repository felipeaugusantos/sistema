unit untTRequisicoesCitelPix;

interface

Uses
 {$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
 {$ELSE}
  Vcl.Forms,
 {$ENDIF}
  System.Classes, System.SysUtils, System.DateUtils, System.StrUtils,
  untTiposPix, HTTPSend, blcksock, synautil, ssl_openssl, untIDataset,
  System.Json;

Type
  TDadosPixBoleto = record
    CodigoBanco,
    TxIdPix,
    QRCodePix,
    DataCriacao,
    Expiracao,
    ValorPix: String;
  end;

Type
  TRequisicoesCitelPix = Class
  Private
    class var FChaveAutorizacaoCitel: String;
    class var FEmpresaConfiguracao: String;
    class var FHomologacao: String;
    class var FEmpresaLinkPix: String;
    class var FChaveSantanderCitel: String;

    class function RetornaResultadoRequisicao(ACodigoStatus,
                                              ARetornoStatus: String): String;

    class procedure VerificaSeRetornouErro(ARetorno: String);

    class procedure CarregaChaveAutorizacaoCitel;

    class function GetChaveSantanderCitel: String; static;
  public
    class function RetornaDadosAutorizacaoWebhookItau(ACNPJCliente,
                                                      AChavePix,
                                                      AAutoIncremChavePix: String): String;

    class function RetornaCertificadosWebhookItau: String;

    class function IncluirQRCodePixBaseCitel(ALinkQRCodeCitelInclusao,
                                             ADadosRetorno,
                                             ARequisicao,
                                             ACodigoBanco,
                                             AAutoIncremPix: String;
                                             AUtilizaShipay: Boolean;
                                             ATransactionType: String): String;

    class function RemoverQRCodePixBaseCitel(ALinkQRCodeCitelExclusao: String;
                                             AGravarLogErr,
                                             APossuiLinkCitel: Boolean): Boolean;

    class function IncluirQRCodePixBoletoBaseCitel(ALinkQRCodeCitelInclusao: String;
                                                   ADadosPixBoleto: TDadosPixBoleto): String;

    class function ImportarCertificadoCitelWebhookSantander(AWorkspace: String): String;

    class function RetornaRefreshTokenWebhookBtgPactual(AChavePix,
                                                        AAuthBasic: String): String;

    class procedure AtualizaRefreshTokenWebhookBtgPactual(AChavePix,
                                                          ARefreshToken: String);

    class function DadosCertificadoPfxWebServiceCitel(AArquivoPfx,
                                                      ASenhaCertificado: String): String;

    class property ChaveSantanderCitel: String read GetChaveSantanderCitel;
  End;

implementation
Uses untFuncoesSimples, untTFuncoesAuxiliaresPix;
{ TRequisicoesCitelPix }

class function TRequisicoesCitelPix.DadosCertificadoPfxWebServiceCitel(
  AArquivoPfx, ASenhaCertificado: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LDadosRequisicao: TJsonObject;

    LLinkCertificado,
    LRetornoPost,
    LTimeStampRequisicao: String;

    LStatus: Integer;

    LParametros: TStringList;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.DadosCertificadoPfxWebServiceCitel');
 {$ENDIF}

  If FChaveAutorizacaoCitel.IsEmpty Then
    CarregaChaveAutorizacaoCitel;

  LParametros := TStringList.Create;

  LHTTPSend := THTTPSend.Create;
  LHTTPSend.MimeType  := 'application/json; charset=utf-8';
  LHTTPSend.Protocol  := '1.1';

  Try
    Try
      LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;

      LParametros.Add('WebHookItauAuthorizationCitel: ' + TFuncoesPix.RetornaChaveBasic(LTimeStampRequisicao,
                                                                      untFuncoesSimples.GetMD5(LTimeStampRequisicao +
                                                                                               FChaveAutorizacaoCitel)));

      LLinkCertificado := 'https://webhookitau.citelsoftware.com.br/ConversorCertificadosCitel/retornarDadosCertificadoPfx';

      LHTTPSend.Headers.AddStrings(LParametros);

      LDadosRequisicao := TJsonObject.Create;
      LDadosRequisicao.AddPair('senha', ASenhaCertificado);
      LDadosRequisicao.AddPair('arquivoCertificado', AArquivoPfx);

      Try
        LFDataReq := TMemoryStream.Create;
        WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao.ToJSON)));
        LHTTPSend.Document.LoadFromStream(LFDataReq);
      Finally
        FreeAndNil(LFDataReq);
        FreeAndNil(LDadosRequisicao);
      End;

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 30000 );
      LHTTPSend.Sock.ConnectionTimeout   := 30000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 30000;
      LHTTPSend.Sock.SocksTimeout        := 30000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

      If LHTTPSend.HTTPMethod('POST', LLinkCertificado) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          LRetornoPost := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          LStatus := LHTTPSend.ResultCode;
        Finally
          FreeAndNil(LFDataResp);
        End;

      End;

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      Result := LRetornoPost;
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}
        Result := E.Message;
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    FreeAndNil(LHTTPSend);
  End;
end;

class function TRequisicoesCitelPix.ImportarCertificadoCitelWebhookSantander(
  AWorkspace: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LLinkCertificado,
    LRetornoPost,
    LValidade,
    LTimeStampRequisicao: String;

    LStatus: Integer;

    LParametros: TStringList;

    LDatasetCertificado: IDataset;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.ImportarCertificadoCitelWebhookSantander');
 {$ENDIF}

  LDatasetCertificado := VS_FuncoesExternas.fGetDataSet;
  LDatasetCertificado.SQL := 'SHOW TABLES LIKE "ATBCER"';
  LDatasetCertificado.Open;

  If LDatasetCertificado.IsEmpty Then
    Exit(EmptyStr);

  LDatasetCertificado.Close;
  LDatasetCertificado.SQL := 'SELECT LNK_URLLNK ' +
                             'FROM LNKBCO ' +
                             'WHERE LNK_CODBCO="033" ' +
                             '  AND LNK_CHAVE_="WEBHOOK_CITEL_GET_CERT_PROD" ' +
                             '  AND LNK_TIPAMB="P"';
  LDatasetCertificado.Open;
  If LDatasetCertificado.IsEmpty Then
    Raise Exception.Create('Links do Pix do banco Santander não mapeados. Entre em contato com a Citel.');

  LLinkCertificado := LDatasetCertificado.FieldByName('LNK_URLLNK').AsString;
  If LLinkCertificado.IsEmpty Then
    Raise Exception.Create('Links do Pix do banco Santander não mapeados. Entre em contato com a Citel.');

  LDatasetCertificado.Close;
  LDatasetCertificado.SQL := 'SELECT * FROM ATBCER WHERE CER_CODBCO="033"';
  LDatasetCertificado.Open;

  If Not LDatasetCertificado.IsEmpty Then
    Exit('sucesso');

  If FChaveAutorizacaoCitel.IsEmpty Then
    CarregaChaveAutorizacaoCitel;

  LParametros := TStringList.Create;

  LHTTPSend := THTTPSend.Create;
  LHTTPSend.MimeType  := 'application/json; charset=utf-8';
  LHTTPSend.Protocol  := '1.1';

  Try
    Try
      If AWorkSpace.IsEmpty Then
        AWorkSpace := 'ZDU1ZjE5YjQ4ZmZiY2FhMDY0NGY5YzczODRmNzMzNTY=';

      LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;

      LParametros.Add('WebHookSantanderAuthorizationCitel: ' + TFuncoesPix.RetornaChaveBasic(LTimeStampRequisicao,
                                                                            untFuncoesSimples.GetMD5(LTimeStampRequisicao +
                                                                                                     FChaveAutorizacaoCitel +
                                                                                                     AWorkspace)));

      LParametros.Add('WebHookSantanderWorkspace: ' +  AWorkSpace);
      LParametros.Add('workspaceCliente: ' +  AWorkSpace);

      LHTTPSend.Headers.AddStrings(LParametros);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 30000 );
      LHTTPSend.Sock.ConnectionTimeout   := 30000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 30000;
      LHTTPSend.Sock.SocksTimeout        := 30000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

      Try
        If LHTTPSend.HTTPMethod('GET', LLinkCertificado) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LRetornoPost := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            LStatus := LHTTPSend.ResultCode;
          Finally
            FreeAndNil(LFDataResp);
          End;

        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.ImportarCertificadoCitelWebhookSantander', LLinkCertificado, 'GET', '', LRetornoPost, LHTTPSend);
      End;

      If Not MatchStr(LStatus.ToString, ['200', '201']) Then
        Raise Exception.Create(LRetornoPost);

      LDatasetCertificado.Insert;
      LDatasetCertificado.FieldByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('ATBCER', VS_FuncoesExternas.fGetEmpresaLogada);
      LDatasetCertificado.FieldByName('CER_CODBCO').AsString := '033';
      LDatasetCertificado.FieldByName('CER_ARQPFX').AsString := TFuncoesPix.RetornaValorCampoJson('arquivoPfx', LRetornoPost);
      LDatasetCertificado.FieldByName('CER_SENCER').AsString := TFuncoesPix.RetornaValorCampoJson('senhaCertificado', LRetornoPost);

      LValidade := TFuncoesPix.RetornaValorCampoJson('validadeCertificado', LRetornoPost);
      If Not LValidade.IsEmpty Then
        LDatasetCertificado.FieldByName('CER_VALCER').AsFloat := EncodeDate(StrToInt(LValidade.Split(['-'])[0]),
                                                                            StrToInt(LValidade.Split(['-'])[1]),
                                                                            StrToInt(LValidade.Split(['-'])[2]));

      LDatasetCertificado.Post;

      Result := 'sucesso';
    Except
      On E: Exception Do
      Begin
       {$IFDEF LINUX}
        WriteError(E.Message);
       {$ENDIF}

        Result := E.Message;

        Raise;
      End;
    End;
  Finally
    FreeAndNil(LParametros);

    LDatasetCertificado.Close;

    FreeAndNil(LHTTPSend);
  End;
end;

class function TRequisicoesCitelPix.IncluirQRCodePixBaseCitel(ALinkQRCodeCitelInclusao,
  ADadosRetorno, ARequisicao, ACodigoBanco, AAutoIncremPix: String;
  AUtilizaShipay: Boolean; ATransactionType: String): String;
  var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta,
    LCodigoRetorno,
    LTimeStampRequisicao,
    LDadosRequisicao,
    LCNPJEmpresaPix: String;

    LDadosPix: TDadosRetornoPixAVista;

    LDadosEmpresaPix: IDataset;

    LAuthorization: string;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.IncluirQRCodePixBaseCitel');
 {$ENDIF}

  Result := ADadosRetorno;

  Try
    CarregaChaveAutorizacaoCitel;

    LHTTPSend := THTTPSend.Create;
    LHTTPSend.MimeType  := 'application/json; charset=utf-8';
    LHTTPSend.Protocol  := '1.1';

    LDadosPix := TFuncoesPix.RetornaDadosDoRetornoPixAVista(ARequisicao,
                                                            ADadosRetorno,
                                                            AAutoIncremPix,
                                                            AUtilizaShipay);

    LDadosEmpresaPix := RetornaDadosEmpresaPix(FEmpresaConfiguracao,
                                               AAutoIncremPix,
                                               FEmpresaLinkPix);

    LCNPJEmpresaPix := LDadosEmpresaPix.FieldByName('EMP_C_G_C_').AsString;
    If FHomologacao = 'S' Then
      LCNPJEmpresaPix := '11111111111111';

    LDadosRequisicao := '{' + #13 +
                        '  "cnpj": "' + LCNPJEmpresaPix + '", ' + #13 +
                        '  "name": "' + LDadosEmpresaPix.FieldByName('EMP_NOMEMP').AsString + '", ' + #13 +
                        '  "fantasyName": "' + LDadosEmpresaPix.FieldByName('EMP_NOMFAN').AsString + '", ' + #13 +
                        '  "companyCode": "' + FEmpresaConfiguracao + '", ' + #13 +
                        '  "phoneNumber": "' + fLimpaCaracteresTelefone(LDadosEmpresaPix.FieldByName('EMP_FONE01').AsString) + '", ' + #13 +
                        '  "transactionId": "' + LDadosPix.Txid + '", ' + #13 +
                        '  "inclusionDate": "' + FormatDateTime('yyyy-MM-dd hh:mm:ss', RetornaCurrentTimeStampServidorDataHora) + '", ' + #13 +
                        '  "expires": ' + LDadosPix.Expiracao + ', ' + #13 +
                        '  "value": ' + FormatFloat(',0.00', LDadosPix.Valor).Replace('.', EmptyStr).Replace(',', '.') + ', ' + #13 +
                        '  "pixKey": "' + LDadosPix.TextoQrCode + '", ' + #13 +
                        '  "bankName": "' + RetornaNomeDoBanco(ACodigoBanco) + '", ' + #13 +
                        '  "transactionType": "' + ATransactionType + '" ' + #13 +
                        '}';

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
      LHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    Application.ProcessMessages;

    Try
      LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;

      LAuthorization := 'Authorization: ' +
                        TFuncoesPix.RetornaChaveBasic(LTimeStampRequisicao,
                        untFuncoesSimples.GetMD5(LTimeStampRequisicao + FChaveAutorizacaoCitel));

      LHTTPSend.Headers.Add(LAuthorization);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      Try
        If LHTTPSend.HTTPMethod('POST', ALinkQRCodeCitelInclusao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            LCodigoRetorno := LHTTPSend.ResultCode.ToString;

            If LCodigoRetorno = '200' Then
              Result := TFuncoesPix.AdicionaLinkCitelJson(ADadosRetorno,
                                                          LResposta,
                                                          ADadosRetorno.IsEmpty)
            Else
              Raise Exception.Create(LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.IncluirQRCodePixBaseCitel', ALinkQRCodeCitelInclusao, 'POST', LDadosRequisicao, LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
      FreeAndNil(LDadosPix);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLogErr_Pix('API Pix Citel [INSERIR] - Erro Código: ' +  LCodigoRetorno,
                       'Erro gerado: ' + E.Message + sLineBreak +
                       'POST ' + ALinkQRCodeCitelInclusao + sLineBreak +
                       LAuthorization + sLineBreak +
                       LDadosRequisicao);
    End;
  End;
end;

class function TRequisicoesCitelPix.IncluirQRCodePixBoletoBaseCitel(
  ALinkQRCodeCitelInclusao: String; ADadosPixBoleto: TDadosPixBoleto): String;
  var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;

    LResposta,
    LCodigoRetorno,
    LTimeStampRequisicao,
    LDadosRequisicao,
    LCNPJEmpresaLogada: String;

    LDadosEmpresaLogada: IDataset;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.IncluirQRCodePixBoletoBaseCitel');
 {$ENDIF}

  Result := EmptyStr;

  Try
    CarregaChaveAutorizacaoCitel;

    LHTTPSend := THTTPSend.Create;
    LHTTPSend.MimeType  := 'application/json; charset=utf-8';
    LHTTPSend.Protocol  := '1.1';

    LDadosEmpresaLogada := RetornaDadosEmpresaLogada(FEmpresaConfiguracao);

    LCNPJEmpresaLogada := LDadosEmpresaLogada.FieldByName('EMP_C_G_C_').AsString;
    If FHomologacao = 'S' Then
      LCNPJEmpresaLogada := '11111111111111';

    LDadosRequisicao := '{' + #13 +
                        '  "cnpj": "' + LCNPJEmpresaLogada + '", ' + #13 +
                        '  "name": "' + LDadosEmpresaLogada.FieldByName('EMP_NOMEMP').AsString + '", ' + #13 +
                        '  "fantasyName": "' + LDadosEmpresaLogada.FieldByName('EMP_NOMFAN').AsString + '", ' + #13 +
                        '  "companyCode": "' + FEmpresaConfiguracao + '", ' + #13 +
                        '  "transactionId": "' + ADadosPixBoleto.TxIdPix + '", ' + #13 +
                        '  "inclusionDate": "' + ADadosPixBoleto.DataCriacao + '", ' + #13 +
                        '  "expires": ' + ADadosPixBoleto.Expiracao + ', ' + #13 +
                        '  "value": ' + ADadosPixBoleto.ValorPix.Replace('.', EmptyStr).Replace(',', '.') + ', ' + #13 +
                        '  "pixKey": "' + ADadosPixBoleto.QRCodePix + '", ' + #13 +
                        '  "bankName": "' + RetornaNomeDoBanco(ADadosPixBoleto.CodigoBanco) + '" ' + #13 +
                        '}';

    Try
      LFDataReq := TMemoryStream.Create;
      WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(LDadosRequisicao)));
      LHTTPSend.Document.LoadFromStream(LFDataReq);
    Finally
      FreeAndNil(LFDataReq);
    End;

    Application.ProcessMessages;

    Try
      LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;

      LHTTPSend.Headers.Add('Authorization: ' +
                            TFuncoesPix.RetornaChaveBasic(LTimeStampRequisicao,
                            untFuncoesSimples.GetMD5(LTimeStampRequisicao + FChaveAutorizacaoCitel)));

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      Try
        If LHTTPSend.HTTPMethod('POST', ALinkQRCodeCitelInclusao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            LCodigoRetorno := LHTTPSend.ResultCode.ToString;

            If LCodigoRetorno = '200' Then
              Result := TFuncoesPix.AdicionaLinkCitelJson('',
                                                          LResposta,
                                                          True)
            Else
              Raise Exception.Create(LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.IncluirQRCodePixBoletoBaseCitel', ALinkQRCodeCitelInclusao, 'POST', LDadosRequisicao, LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLogErr_Pix('API Pix Citel [INSERIR] - Erro Código: ' +  LCodigoRetorno,
                       'Erro gerado: ' + E.Message);
    End;
  End;
end;

class function TRequisicoesCitelPix.RemoverQRCodePixBaseCitel(
  ALinkQRCodeCitelExclusao: String;
  AGravarLogErr, APossuiLinkCitel: Boolean): Boolean;
  Var
    LResposta,
    LTimeStampRequisicao,
    LCodigoRetorno: String;

    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.RemoverQRCodePixBaseCitel');
 {$ENDIF}

  Result := False;

  If Not APossuiLinkCitel Then
    Exit;

  Try
    Try
      CarregaChaveAutorizacaoCitel;

      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      Application.ProcessMessages;

      LTimeStampRequisicao := RetornaTimeStampEmMilisegundos.ToString;

      LHTTPSend.Headers.Add('Authorization: ' +
                            TFuncoesPix.RetornaChaveBasic(LTimeStampRequisicao,
                            untFuncoesSimples.GetMD5(LTimeStampRequisicao + FChaveAutorizacaoCitel)));

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      Try
        If LHTTPSend.HTTPMethod('DELETE', ALinkQRCodeCitelExclusao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            LCodigoRetorno := LHTTPSend.ResultCode.ToString;

            Result := LCodigoRetorno = '200';

            If Not Result Then
              Raise Exception.Create('HTTP/1.1 ' + LCodigoRetorno + '-' + LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.RemoverQRCodePixBaseCitel', ALinkQRCodeCitelExclusao, 'DELETE', '', LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      If AGravarLogErr Then
        GravarLogErr_Pix('API Pix Citel [EXCLUIR] - Erro Código: ' +  LCodigoRetorno,
                         'Erro gerado: ' + E.Message);
    End;
  End;
end;

class function TRequisicoesCitelPix.RetornaCertificadosWebhookItau: String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta,
    LLinkRequisicao: String;

    LDataRequisicao: Int64;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.RetornaCertificadosWebhookItau');
 {$ENDIF}

  Try
    Try
      CarregaChaveAutorizacaoCitel;

      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LDataRequisicao := untFuncoesSImples.RetornaTimeStampEmMilisegundos;

      LHTTPSend.Headers.Add('WebHookItauAuthorizationCitel: ' +
                            TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                            untFuncoesSimples.GetMD5(LDataRequisicao.ToString + FChaveAutorizacaoCitel)));

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      LLinkRequisicao := 'https://webhookitau.citelsoftware.com.br/authCitel/importCitelSoftwareKeys';

      Try
        If LHTTPSend.HTTPMethod('GET', LLinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                  LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
        Begin
          Result := RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                               LHTTPSend.Sock.LastErrorDesc);
        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.RetornaCertificadosWebhookItau', LLinkRequisicao, 'GET', '', LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message);
    End;
  End;

  Try
    VerificaSeRetornouErro(Result);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLOGERR_Pix('Webhook Itau Pix Citel [IMPORTAR CERT] - Erro Código: ' + TFuncoesPix.RetornaValorCampoJson('codigo', Result),
                       'Erro gerado: ' + E.Message);
    End;
  End;
end;

class function TRequisicoesCitelPix.RetornaDadosAutorizacaoWebhookItau(
  ACNPJCliente, AChavePix, AAutoIncremChavePix: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta,
    LLinkRequisicao: String;

    LDataRequisicao: Int64;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.RetornaDadosAutorizacaoWebhookItau');
 {$ENDIF}

  Try
    Try
      CarregaChaveAutorizacaoCitel;

      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LDataRequisicao := untFuncoesSImples.RetornaTimeStampEmMilisegundos;

      LHTTPSend.Headers.Add('WebHookItauAuthorizationCitel: ' +
                            TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                            untFuncoesSimples.GetMD5(LDataRequisicao.ToString + FChaveAutorizacaoCitel)));

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      LLinkRequisicao := 'https://webhookitau.citelsoftware.com.br/importLastCNPJ/' +
                         ACNPJCliente + '/' + AChavePix + '/' +
                         VS_FuncoesExternas.fIRetOperadorLogado + '/' +
                         AAutoIncremChavePix;

      Try
        If LHTTPSend.HTTPMethod('GET', LLinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result :=  RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                  LResposta);
          Finally
            FreeAndNil(LFDataResp);
          End;

        End
        Else
        Begin
          RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                     LHTTPSend.Sock.LastErrorDesc);
        End;
      Finally
        GravarLogAPI('TRequisicoesCitelPix.RetornaDadosAutorizacaoWebhookItau', LLinkRequisicao, 'GET', '', LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      Result := RetornaResultadoRequisicao('-1',
                                           E.Message);
    End;
  End;

  Try
    VerificaSeRetornouErro(Result);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLOGERR_Pix('Webhook Itau Pix Citel [CONSULTAR] - Erro Código: ' + TFuncoesPix.RetornaValorCampoJson('codigo', Result),
                       'Erro gerado: ' + E.Message);
    End;
  End;
end;

class function TRequisicoesCitelPix.RetornaRefreshTokenWebhookBtgPactual(
  AChavePix, AAuthBasic: String): String;
  Var
    LHTTPSend: THTTPSend;

    LFDataResp: TMemoryStream;

    LResposta,
    LLinkRequisicao: String;

    LDataRequisicao,
    LTempoRefreshToken: Int64;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.RetornaRefreshTokenWebhookBtgPactual');
 {$ENDIF}

  Try
    Try
      CarregaChaveAutorizacaoCitel;

      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LDataRequisicao := untFuncoesSImples.RetornaTimeStampEmMilisegundos;

      LHTTPSend.Headers.Add('WebhookSantanderAuthorizationCitel: ' +
                            TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                            untFuncoesSimples.GetMD5(LDataRequisicao.ToString + FChaveAutorizacaoCitel)));

      LHTTPSend.Headers.Add('authBasic: ' + AAuthBasic);
      LHTTPSend.Headers.Add('homologacao: ' + FHomologacao);
      LHTTPSend.Headers.Add('chavePix: ' + AChavePix);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      LLinkRequisicao := 'https://btgpactualservice.citelsoftware.com.br/BtgAuthorizationCitel/authorization/';
      If FHomologacao.Equals('S') Then
        LLinkRequisicao := 'http://150.230.84.83:8080/BtgAuthorizationCitel/authorization/';

      Try
        If LHTTPSend.HTTPMethod('POST', LLinkRequisicao) Then
        Begin
          LHTTPSend.Document.Position := 0;

          Try
            LFDataResp := TMemoryStream.Create;
            LFDataResp.LoadFromStream(LHTTPSend.Document);

            LFDataResp.Position := 0;
            LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

            Result := LResposta;
            If LHTTPSend.ResultCode <> 200 Then
              Raise Exception.Create(RetornaResultadoRequisicao('992',
                                                                TFuncoesPix.RetornaValorCampoJson('mensagem', Result)));

            If TryStrToInt64(TFuncoesPix.RetornaValorCampoJson('secondsOfRefresh', Result), LTempoRefreshToken) Then
            Begin
              If LTempoRefreshToken >= 864000 Then
              Begin
                LHTTPSend.Headers.Clear;
                LHTTPSend.Headers.Add('WebhookSantanderAuthorizationCitel: ' +
                                      TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                                      untFuncoesSimples.GetMD5(LDataRequisicao.ToString + FChaveAutorizacaoCitel)));

                LHTTPSend.Headers.Add('chavePix: ' + AChavePix);
                LHTTPSend.Headers.Add('refreshToken: ' + TFuncoesPix.RetornaValorCampoJson('refreshToken', Result));

                Try
                  LHTTPSend.HTTPMethod('DELETE', LLinkRequisicao);
                Except

                End;

                Raise Exception.Create(
                       TFuncoesPix.RetornaResultadoRequisicao('992',
                                                              'O consentimento do Banco Btg Pactual não foi atualizado por mais de 10 dias.' + #13 +
                                                                'Entre em Contas Bancárias, selecione a conta da chave pix, clique em ' +
                                                                'Validar Dados de Autorização e reafaça o consentimento.')
                                      );
              End;
            End;
          Finally
            FreeAndNil(LFDataResp);
          End;

          Exit;

        End;

        Raise Exception.Create(RetornaResultadoRequisicao(LHTTPSend.ResultCode.ToString,
                                                          LHTTPSend.Sock.LastErrorDesc));
      Finally
        GravarLogAPI('TRequisicoesCitelPix.RetornaRefreshTokenWebhookBtgPactual', LLinkRequisicao, 'POST', '', LResposta, LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    Raise;
  End;

  Try
    VerificaSeRetornouErro(Result);
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLOGERR_Pix('Webhook BtgPactual (SANTANDER) Pix Citel - Erro Código: ' + TFuncoesPix.RetornaValorCampoJson('codigo', Result),
                       'Erro gerado: ' + E.Message);
    End;
  End;
end;

class function TRequisicoesCitelPix.RetornaResultadoRequisicao(ACodigoStatus,
  ARetornoStatus: String): String;
  Var
    LJsonObject: TJsonObject;
begin
  Result := '{"codigo": "' + ACodigoStatus + '", ' +
            ' "resultado": ' + ARetornoStatus + '}';

  Try
    LJsonObject := TJsonObject.ParseJSONValue(ARetornoStatus) AS TJsonObject;

    If LJsonObject = Nil Then
      Result := '{"codigo": "' + ACodigoStatus + '", ' +
                ' "resultado": "' + ARetornoStatus + '"}';
  Except

  End;
end;

class procedure TRequisicoesCitelPix.AtualizaRefreshTokenWebhookBtgPactual(
  AChavePix, ARefreshToken: String);
  Var
    LHTTPSend: THTTPSend;

    LLinkRequisicao: String;

    LDataRequisicao: Int64;
begin
 {$IFDEF LINUX}
  WriteLog('TRequisicoesCitelPix.AtualizaRefreshTokenWebhookBtgPactual');
 {$ENDIF}

  Try
    Try
      CarregaChaveAutorizacaoCitel;

      LHTTPSend := THTTPSend.Create;
      LHTTPSend.MimeType  := 'application/json; charset=utf-8';
      LHTTPSend.Protocol  := '1.1';

      LDataRequisicao := untFuncoesSImples.RetornaTimeStampEmMilisegundos;

      LHTTPSend.Headers.Add('WebhookSantanderAuthorizationCitel: ' +
                            TFuncoesPix.RetornaChaveBasic(LDataRequisicao.ToString,
                            untFuncoesSimples.GetMD5(LDataRequisicao.ToString + FChaveAutorizacaoCitel)));

      LHTTPSend.Headers.Add('refreshToken: ' + ARefreshToken);
      LHTTPSend.Headers.Add('chavePix: ' + AChavePix);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 15000 );
      LHTTPSend.Sock.ConnectionTimeout   := 15000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 15000;
      LHTTPSend.Sock.SocksTimeout        := 15000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 15000;

      LLinkRequisicao := 'https://btgpactualservice.citelsoftware.com.br/BtgAuthorizationCitel/authorization/';
      If FHomologacao.Equals('S') Then
        LLinkRequisicao := 'http://150.230.84.83:8080/BtgAuthorizationCitel/authorization/';

      Try
        LHTTPSend.HTTPMethod('PATCH', LLinkRequisicao);
      Finally
        GravarLogAPI('TRequisicoesCitelPix.AtualizaRefreshTokenWebhookBtgPactual', LLinkRequisicao, 'PATCH', '', '', LHTTPSend);
      End;
    Finally
      FreeAndNil(LHTTPSend);
    End;
  Except
    On E: Exception Do
    Begin
     {$IFDEF LINUX}
      WriteError(E.Message);
     {$ENDIF}
      GravarLogErr_Pix(E.Message,
        {$IFDEF LINUX}'TRequisicoesCitelPix.AtualizaRefreshTokenWebhookBtgPactual'{$ELSE}fRetornaStack{$ENDIF});
    End;
  End;
end;

class procedure TRequisicoesCitelPix.CarregaChaveAutorizacaoCitel;
begin
  FEmpresaConfiguracao := VS_FuncoesExternas.fGetEmpresaLogada;
  FHomologacao := fCfgSis('HOMPIX', FEmpresaConfiguracao);
  FEmpresaLinkPix := fCfgSis('EMPPIX', FEmpresaConfiguracao);

  If FEmpresaLinkPix.IsEmpty Then
    FEmpresaLinkPix := 'V';

  If Not FChaveAutorizacaoCitel.IsEmpty Then
    Exit;

  FChaveAutorizacaoCitel := fCfgSis('CHVCIT', FEmpresaConfiguracao);

  If FChaveAutorizacaoCitel.IsEmpty Then
  Begin
    FChaveAutorizacaoCitel := 'uLtr@-F!n&320147';

    untFuncoesSimples.AdicionaAlteraConfiguracao('CFG_CHVCIT',
                                                 FChaveAutorizacaoCitel,
                                                 FEmpresaConfiguracao,
                                                 'Chave para Pix Citel',
                                                 'PIX');
  End;
end;

class function TRequisicoesCitelPix.GetChaveSantanderCitel: String;
begin
  If Not FChaveSantanderCitel.IsEmpty Then
    Exit(FChaveSantanderCitel);

  FChaveSantanderCitel := fCfgSis('SANCHA', FEmpresaConfiguracao);

  If FChaveSantanderCitel.IsEmpty Then
  Begin
    FChaveSantanderCitel := 'CIT51225';

    untFuncoesSimples.AdicionaAlteraConfiguracao('CFG_SANCHA',
                                                 FChaveSantanderCitel,
                                                 VS_FuncoesExternas.fGetEmpresaLogada,
                                                 'Chave Citel para o Banco Santander (NÃO ALTERAR SEM PERMISSÃO)',
                                                 'AUTBAN');
  End;

  Result := FChaveSantanderCitel;
end;

class procedure TRequisicoesCitelPix.VerificaSeRetornouErro(ARetorno: String);
  Var
    LCodigoRetorno: String;
begin
  LCodigoRetorno := TFuncoesPix.RetornaValorCampoJson('codigo', ARetorno);
  If Not MatchStr(LCodigoRetorno, ['200', '201', EmptyStr]) Then
    Raise Exception.Create(TFuncoesPix.RetornaValorCampoJson('resultado', ARetorno, True));
end;

Initialization
  TRequisicoesCitelPix.FChaveSantanderCitel := EmptyStr;

end.
