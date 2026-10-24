unit untTEnvioEmailRestSynalist;

interface

Uses System.Classes, System.SysUtils, Vcl.Forms, System.StrUtils, System.Json,
     blcksock, synautil, ssl_openssl, HTTPSend;

Type
  TEnvioEmailRestSynalist = Class
  private
    procedure OnHeartBeat(Sender: TObject);

    function RetornaDescricaoErroUsuario(ATextoMensagem: String): String;

    function RetornaJsonErro(AComponente: THTTPSend;
                             AErroException: String = ''): String;
  public
    function ExecuteRestSynalist(const AMetodo,
                                       AUrl: String;
                                       AParametros: TStringList;
                                   out AJsonRetorno: String;
                                       AJsonEnvio: String = '';
                                       AMineType: String = ''): Integer;

    function TrataErrosEmailOutlook(ARetorno: String): String;
  End;

implementation

Uses untFuncoesSimples, untRestApi;

{ TEnvioEmailRestSynalist }

function TEnvioEmailRestSynalist.ExecuteRestSynalist(const AMetodo,
  AUrl: String; AParametros: TStringList; out AJsonRetorno: String; AJsonEnvio,
  AMineType: String): Integer;
  Var
    LHTTPSend: THTTPSend;

    LFDataReq,
    LFDataResp: TMemoryStream;
begin
   LHTTPSend := THTTPSend.Create;
   LHTTPSend.Sock.OnHeartbeat := OnHeartBeat;

   Result := -1;

  Try
    Try
      LHTTPSend.MimeType  := 'application/x-www-form-urlencoded';
      If Not AMineType.IsEmpty Then
        LHTTPSend.MimeType := AMineType;

      LHTTPSend.Protocol  := '1.1';

      If Assigned(AParametros) Then
        LHTTPSend.Headers.AddStrings(AParametros);

      LHTTPSend.Sock.SSL.SSLType:= LT_all;

      LHTTPSend.Sock.SetTimeout( 30000 );
      LHTTPSend.Sock.ConnectionTimeout   := 30000;
      LHTTPSend.Sock.InterPacketTimeout  := False;
      LHTTPSend.Sock.NonblockSendTimeout := 30000;
      LHTTPSend.Sock.SocksTimeout        := 30000;
      LHTTPSend.Sock.HTTPTunnelTimeout   := 30000;

      If Not AJsonEnvio.IsEmpty Then
      Begin
        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(AJsonEnvio)));
          LHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;
      End;

      If LHTTPSend.HTTPMethod(AMetodo, AUrl) Then
      Begin
        LHTTPSend.Document.Position := 0;

        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(LHTTPSend.Document);

          LFDataResp.Position := 0;
          AJsonRetorno := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

          Result := LHTTPSend.ResultCode;

          try
            TControllerRest.pGravaLogApiAvulsa('MICROSOFTMAIL', AUrl, AJsonEnvio, AJsonRetorno, Result);
          except
          end;

          If Not MatchStr(Result.ToString, ['200', '201', '202']) Then
              Raise Exception.Create(AJsonRetorno);
        Finally
          FreeAndNil(LFDataResp);
        End;

      End
      Else
      Begin
        AJsonRetorno := RetornaJsonErro(LHTTPSend);

        Result := LHTTPSend.ResultCode;

        try
          TControllerRest.pGravaLogApiAvulsa('MICROSOFTMAIL', AUrl, AJsonEnvio, AJsonRetorno, Result);
        except
        end;

        Raise Exception.Create(LHTTPSend.Sock.LastErrorDesc);
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(RetornaJsonErro(LHTTPSend, E.Message));
    End;
  Finally
    FreeAndNil(LHTTPSend);

    Application.ProcessMessages;
  End;
end;

procedure TEnvioEmailRestSynalist.OnHeartBeat(Sender: TObject);
begin
  Application.ProcessMessages;
end;

function TEnvioEmailRestSynalist.RetornaDescricaoErroUsuario(
  ATextoMensagem: String): String;
begin
  Result := ATextoMensagem;

  If Result.ToLowerInvariant.Contains('the mailbox is either inactive, soft-deleted, or is hosted on-premise') Then
    Exit('O e-mail utilizado não possui conta vinculada ao Microsoft 365, ' +
         'está inativa ou não está liberada para envio de e-mails em aplicativos de terceiros.' + #13 +
         'Erro gerado: ' + ATextoMensagem);

  If Result.ToLowerInvariant.Contains('application with identifier') Then
  Begin
    If Result.ToLowerInvariant.Contains('was not found in the directory') Then
      Exit('O ID do Cliente não foi encontrado no diretório especificado. Verifique os dados digitados.');
  End;

  If Result.ToLowerInvariant.Contains('specified tenant identifier') Then
  Begin
    If Result.ToLowerInvariant.Contains('is neither a valid dns name, nor a valid external domain') Then
      Exit('O ID do Diretório não foi encontrado. Verifique os dados digitados.');
  End;

  If Result.ToLowerInvariant.Contains('invalid client secret provided. ensure the secret being sent in the request is the client secret') Then
    Exit('O Segredo digitado para esse ID de Cliente não é válido. Verifique os dados digitados.');
end;
function TEnvioEmailRestSynalist.RetornaJsonErro(AComponente: THTTPSend;
  AErroException: String): String;
  Var
    LErroString: String;

    LFDataResp: TMemoryStream;
begin
  Result := AComponente.Sock.GetErrorDescEx + '-' + AComponente.Sock.LastErrorDesc;
  LFDataResp := TMemoryStream.Create;

  Try
    If AComponente.Document <> Nil Then
    Begin
      AComponente.Document.Position := 0;

      LFDataResp.LoadFromStream(AComponente.Document);

      LFDataResp.Position := 0;
      LErroString := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));
      If Not LErroString.Trim.IsEmpty Then
        Result := LErroString;
    End;

    If Not AErroException.IsEmpty Then
    Begin
      If Not Result.Equals(AErroException) Then
        Result := Result + ' - ' + AErroException;
    End;
  Finally
    FreeAndNil(LFDataResp);
  End;
end;

function TEnvioEmailRestSynalist.TrataErrosEmailOutlook(
  ARetorno: String): String;
  Var
    LJsonObject: TJsonObject;
begin
  Result := ARetorno;

  Try
    LJsonObject := TJsonObject.ParseJSONValue(ARetorno) AS TJsonObject;

    If LJsonObject = Nil THen
      Exit;

    Try
      //Erro validação Azure
      If LJsonObject.GetValue('error_description') <> Nil Then
        Exit(RetornaDescricaoErroUsuario(RetornaValorJson(LJsonObject, 'error_description')));

      //Erro validação email
      If LJsonObject.GetValue('error') <> Nil Then
      Begin
        LJsonObject := TJsonObject.ParseJSONValue(LJsonObject.GetValue('error').ToJson) AS TJsonObject;

        If LJsonObject.GetValue('message') <> Nil Then
          Result := RetornaDescricaoErroUsuario(RetornaValorJson(LJsonObject, 'message'));
      End;
    Finally
      If LJsonObject <> Nil Then
        FreeAndNil(LJsonObject);
    End;
  Except
    //não para a rotina e vai retornar o ARETORNO
  End;
end;

end.
