unit untTEnvioEmailOutlookOAuth2;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, System.Json, Rest.Json,
     System.Generics.Collections, EncdDecd, System.NetEncoding,
     IdMessage, idText, IdAttachmentFile, idEmailAddress,
     untTEnvioEmailAutenticacaoOAuth2, untTEnvioEmailRestSynalist;

Type
  TPastasOutlook = Class(TPastasImap)
  public
    id,
    parentFolderId: String;

    childFolderCount,
    unreadItemCount,
    totalItemCount: Integer;

    isHidden: Boolean;
  End;

Type
  TEnvioEmailOutlookOAuth2 = class(TEnvioEmailRestSynalist)
  private
    FAutenticacaoOAuth2: TEnvioEmailAutenticacaoOAuth2;

    function RetornaUrlEnvioEmail(AIDEmailFrom: String): String;
    function RetornaUrlRetornaMensagemImap(AIDEmailFrom,
                                           AIDPasta,
                                           ANomeArquivoZip: String): String;

    function CriaRecipentObject(AEmail, ANome: String): TJsonObject;

    function RetornaDateTimeOffset(ADataHora: TDateTime): String;

    procedure CarregaAnexosDaMensagem(var AMensagem: TidMessage;
                                      AMensagemJson: TJsonObject);

    procedure CarregaDestinatariosDaMensagem(var AMensagem: TidMessage;
                                             AMensagemJson: TJsonObject);
  public
    Constructor Create(AAutenticacaoOAuth2: TEnvioEmailAutenticacaoOAuth2);

    function RetornaJsonMensagemMicrosoftOutlook(AMensagem: TIdMessage;
                                                 AGravaPastaEnviados,
                                                 AImportante: Boolean): TJsonObject;

    function ConverteEmailJsonParaidMessage(AMensagem: TJsonObject): TIdMessage;

    function EnviarEmailOutlook(AJsonEmail: TJsonObject;
                                AEmailFrom: String): Boolean;

    function ListaPastasImap: TList<TPastasOutlook>;

    function BuscaEmailPorIdOutlook(AIDPasta,
                                    ANomeArquivoZip: String): TJsonObject;

    function BuscaAnexnosEmailOutlook(AIDMenagemInterna: String): TJsonArray;
  end;

implementation
Uses untFuncoesSimples;

{ TEnvioEmailOutlookOAuth2 }

function TEnvioEmailOutlookOAuth2.BuscaAnexnosEmailOutlook(
  AIDMenagemInterna: String): TJsonArray;
  Var
    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;
begin
  LParametros := TStringList.Create;

  Result := TJsonArray.Create;

  Try
    LParametros.Add('Authorization: ' + FAutenticacaoOAuth2.GetToken);

    If ExecuteRestSynalist('GET',
                           'https://graph.microsoft.com/v1.0/users/' + FAutenticacaoOAuth2.EmailAzureID +
                                               '/messages/' + AIDMenagemInterna + '/attachments' ,
                           LParametros,
                           LRetorno,
                           EmptyStr,
                           'application/json') <> 200 Then
      Raise Exception.Create(TrataErrosEmailOutlook(LRetorno));

    LJsonObject := TJsonObject.ParseJSONValue(LRetorno) As TJsonObject;

    Result := TJsonObject.ParseJSONValue(LJsonObject.GetValue('value').ToJson) As TJsonArray;

    FreeAndNil(LJsonObject);
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TEnvioEmailOutlookOAuth2.BuscaEmailPorIdOutlook(AIDPasta,
  ANomeArquivoZip: String): TJsonObject;
  Var
    LRetorno: String;

    LParametros: TStringList;
begin
  LParametros := TStringList.Create;

  Result := Nil;

  Try
    LParametros.Add('Authorization: ' + FAutenticacaoOAuth2.GetToken);

    If ExecuteRestSynalist('GET',
                           RetornaUrlRetornaMensagemImap(FAutenticacaoOAuth2.EmailAzureID,
                                                         AIDPasta,
                                                         ANomeArquivoZip),
                           LParametros,
                           LRetorno,
                           EmptyStr,
                           'application/json') <> 200 Then
      Raise Exception.Create(TrataErrosEmailOutlook(LRetorno));

    Result := TJsonObject.ParseJSONValue(LRetorno) As TJsonObject;
  Finally
    FreeAndNil(LParametros);
  End;
end;

procedure TEnvioEmailOutlookOAuth2.CarregaAnexosDaMensagem(
  var AMensagem: TidMessage; AMensagemJson: TJsonObject);
  Var
    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LFileStream: TMemoryStream;

    LAttachmentFile: TIdAttachmentFile;

    LBytes: TBytes;
begin
  Try
    LJsonArray := BuscaAnexnosEmailOutlook(RetornaValorJson(AMensagemJson, 'id'));

    Try
      For LJsonValue In LJsonArray Do
      Begin
        LAttachmentFile := TIdAttachmentFile.Create(AMensagem.MessageParts);

        If RetornaValorJsonValue(LJsonValue, 'isInline').ToLower.Equals('true') Then
          LAttachmentFile.ContentDisposition := 'inline'
        Else
          LAttachmentFile.ContentDisposition := 'attachment';

        LAttachmentFile.ContentTransfer := 'base64';

        LBytes := TNetEncoding.Base64.DecodeStringToBytes(RetornaValorJsonValue(LJsonValue, 'contentBytes'));
        LFileStream := TMemoryStream.Create;
        LFileStream.WriteBuffer(LBytes[0], Length(LBytes));
        LFileStream.Position := 0;

        LAttachmentFile.LoadFromStream(LFileStream);
        LAttachmentFile.ContentId := '<' + RetornaValorJsonValue(LJsonValue, 'contentId') + '>';
        LAttachmentFile.ContentType := RetornaValorJsonValue(LJsonValue, 'contentType');
        LAttachmentFile.Name := RetornaValorJsonValue(LJsonValue, 'contentId');
        LAttachmentFile.FileName := RetornaValorJsonValue(LJsonValue, 'name');

        LFileStream.Free;
      End;
    Finally
      LAttachmentFile := TIdAttachmentFile.Create(AMensagem.MessageParts);
      FreeAndNil(LAttachmentFile);

      If Assigned(LJsonArray) Then
        LJsonArray.Free;
    End;
  Except
    Raise
  End;
end;

procedure TEnvioEmailOutlookOAuth2.CarregaDestinatariosDaMensagem(
  var AMensagem: TidMessage; AMensagemJson: TJsonObject);
  Var
    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LJsonAuxiliar: TJSONObject;

    LAddressItem: TIdEmailAddressItem;
begin
  //Para
  AMensagem.Recipients.Clear();

  If AMensagemJson.GetValue('toRecipients') <> Nil Then
  Begin
    LJsonArray := TJSONObject.ParseJSONValue(AMensagemJson.GetValue('toRecipients').ToJson) As TJsonArray;
    For LJsonValue In LJsonArray do
    Begin
      LAddressItem := AMensagem.Recipients.Add;

      LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonValue.ToJSON) As TJsonObject;

      LAddressItem.Address := RetornaValorJson(LJsonAuxiliar, 'address');
      LAddressItem.Name := RetornaValorJson(LJsonAuxiliar, 'name');
    End;

    LJsonArray.Free;
  End;

  //Cópia
  AMensagem.CCList.Clear();

  If AMensagemJson.GetValue('ccRecipients') <> Nil Then
  Begin
    LJsonArray := TJSONObject.ParseJSONValue(AMensagemJson.GetValue('ccRecipients').ToJson) As TJsonArray;
    For LJsonValue In LJsonArray do
    Begin
      LAddressItem := AMensagem.CCList.Add;

      LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonValue.ToJSON) As TJsonObject;

      LAddressItem.Address := RetornaValorJson(LJsonAuxiliar, 'address');
      LAddressItem.Name := RetornaValorJson(LJsonAuxiliar, 'name');
    End;

    LJsonArray.Free;
  End;

  AMensagem.BCCList.Clear();

  If AMensagemJson.GetValue('bccRecipients') <> Nil Then
  Begin
    LJsonArray := TJSONObject.ParseJSONValue(AMensagemJson.GetValue('bccRecipients').ToJson) As TJsonArray;
    For LJsonValue In LJsonArray do
    Begin
      LAddressItem := AMensagem.BCCList.Add;

      LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonValue.ToJSON) As TJsonObject;

      LAddressItem.Address := RetornaValorJson(LJsonAuxiliar, 'address');
      LAddressItem.Name := RetornaValorJson(LJsonAuxiliar, 'name');
    End;

    LJsonArray.Free;
  End;
end;

function TEnvioEmailOutlookOAuth2.ConverteEmailJsonParaidMessage(
  AMensagem: TJsonObject): TIdMessage;
  Var
    LJsonAuxiliar: TJsonObject;

    LBody: TidText;

    LAddressItem: TIdEmailAddressItem;
begin
  Result := TIdMessage.Create();

  Try
    Result.Subject := RetornaValorJson(AMensagem, 'subject');

    Result.ContentType := 'multipart/mixed';
    Result.ContentDisposition := 'inline';
    Result.CharSet     := 'UTF-8';

    Result.Headers.Values['Message-Id'] := RetornaValorJson(AMensagem, 'internetMessageId');
    Result.ExtraHeaders.Values['Message-Id'] := RetornaValorJson(AMensagem, 'internetMessageId');

    LBody := TIdText.Create(Result.MessageParts, nil);
    LBody.Body.Clear();
    LBody.ContentType := 'multipart/related; type="text/html"';
    LBody.CharSet     := 'UTF-8';
    LBody.ParentPart  := -1;

    LBody := TIdText.Create(Result.MessageParts, nil);
    LBody.Body.Clear();
    LBody.ParentPart      := 0;
    LBody.ContentType     := 'text/html';
    LBody.ContentTransfer := 'quoted-printable';
    LBody.CharSet         := 'UTF-8';

    LJsonAuxiliar := TJSONObject.ParseJSONValue(AMensagem.GetValue('body').ToJson) As TJsonObject;

    LBody.Body.Text := RetornaValorJson(LJsonAuxiliar, 'content');

    CarregaAnexosDaMensagem(Result, AMensagem);

    //tem que ter muita paciência
    LAddressItem := TIdEmailAddressItem.Create();

    //From
    Result.FromList.Clear();

    LAddressItem := Result.FromList.Add;

    LJsonAuxiliar := TJSONObject.ParseJSONValue(AMensagem.GetValue('from').ToJson) As TJsonObject;
    LJsonAuxiliar := TJSONObject.ParseJSONValue(LJsonAuxiliar.GetValue('emailAddress').ToJson) As TJsonObject;

    LAddressItem.Address := RetornaValorJson(LJsonAuxiliar, 'address');
    LAddressItem.Name := RetornaValorJson(LJsonAuxiliar, 'name');

    LAddressItem := Result.FromList.Add;
    FreeAndNil(LAddressItem);

    Result.From.Name := RetornaValorJson(LJsonAuxiliar, 'name');
    Result.From.Address := RetornaValorJson(LJsonAuxiliar, 'address');

    CarregaDestinatariosDaMensagem(Result, AMensagem);
  Except
    Raise;
  End;
end;

constructor TEnvioEmailOutlookOAuth2.Create(
  AAutenticacaoOAuth2: TEnvioEmailAutenticacaoOAuth2);
begin
  FAutenticacaoOAuth2 := AAutenticacaoOAuth2;
end;

function TEnvioEmailOutlookOAuth2.EnviarEmailOutlook(
  AJsonEmail: TJsonObject; AEmailFrom: String): Boolean;
  Var
    LCorpoEmail,
    LRetorno: String;

    LParametros: TStringList;
begin
  Result := False;

  LCorpoEmail := TJson.Format(AJsonEmail);
  LParametros := TStringList.Create;

  Try
    LParametros.Add('Authorization: ' + FAutenticacaoOAuth2.GetToken);

    If ExecuteRestSynalist('POST',
                           RetornaUrlEnvioEmail(FAutenticacaoOAuth2.EmailAzureID),
                           LParametros,
                           LRetorno,
                           LCorpoEmail,
                           'application/json') <> 202 Then
      Raise Exception.Create(TrataErrosEmailOutlook(LRetorno));

    Result := True;
  Finally
    FreeAndNil(LParametros);
  End;
end;

function TEnvioEmailOutlookOAuth2.ListaPastasImap: TList<TPastasOutlook>;
  Var
    LRetorno: String;

    LParametros: TStringList;

    LJsonObject: TJsonObject;

    LJsonArray: TJsonArray;

    LJsonValue: TJsonValue;

    LPasta: TPastasOutLook;
begin
  Result := TList<TPastasOutlook>.Create;

  LParametros := TStringList.Create;

  If FAutenticacaoOAuth2.EmailAzureID.IsEmpty Then
    FAutenticacaoOAuth2.CarregaEmailIDAzureDadosModeloOperador(EmptyStr,
                                                               EmptyStr,
                                                               strLoginUsuarioLogado);

  Try
    Try
      LParametros.Add('Authorization: ' + FAutenticacaoOAuth2.GetToken);

      If Not MatchStr(ExecuteRestSynalist('GET',
                                          'https://graph.microsoft.com/v1.0/users/' + FAutenticacaoOAuth2.EmailAzureID + '/mailFolders',
                                          LParametros,
                                          LRetorno,
                                          EmptyStr,
                                          'application/json').ToString, ['200', '201']) Then
        Raise Exception.Create(LRetorno);

      LJsonObject := TJsonObject.ParseJSONValue(LRetorno) As TJsonObject;

      LJsonArray := TJsonObject.ParseJSONValue(LJsonObject.GetValue('value').ToJson) As TJsonArray;

      For LJsonValue In LJsonArray Do
      Begin
        LPasta := TPastasOutLook.Create;

        LPasta.folderName := RetornaValorJsonValue(LJsonValue, 'displayName');
        LPasta.id := RetornaValorJsonValue(LJsonValue, 'id');
        LPasta.parentFolderId := RetornaValorJsonValue(LJsonValue, 'parentFolderId');
        TryStrToInt(RetornaValorJsonValue(LJsonValue, 'parentFolderId'), LPasta.childFolderCount);
        TryStrToInt(RetornaValorJsonValue(LJsonValue, 'unreadItemCount'), LPasta.unreadItemCount);
        TryStrToInt(RetornaValorJsonValue(LJsonValue, 'totalItemCount'), LPasta.totalItemCount);
        LPasta.isHidden := RetornaValorJsonValue(LJsonValue, 'isHidden').ToLower.Equals('true');

        Result.Add(LPasta);
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(TrataErrosEmailOutlook(E.Message));
    End;
  Finally
    FreeAndNil(LParametros);

    If LJsonObject <> Nil Then
      FreeAndNil(LJsonObject);
  End;
end;

function TEnvioEmailOutlookOAuth2.RetornaUrlEnvioEmail(
  AIDEmailFrom: String): String;
Begin
  Result := 'https://graph.microsoft.com/v1.0/users/' + AIDEmailFrom + '/sendMail';
end;

function TEnvioEmailOutlookOAuth2.RetornaUrlRetornaMensagemImap(
  AIDEmailFrom, AIDPasta, ANomeArquivoZip: String): String;
Begin
  Result := 'https://graph.microsoft.com/v1.0/users/' + AIDEmailFrom +
            '/mailFolders/' + AIDPasta +
            '/messages?%24filter=internetMessageId%20eq%20%27%3C' + ANomeArquivoZip.Replace('.zip', EmptyStr) +
                                                   '%40' + FAutenticacaoOAuth2.EmailFrom.Substring(Pos('@', FAutenticacaoOAuth2.EmailFrom)) +
                                                   '%3E%27' ;
end;

function TEnvioEmailOutlookOAuth2.CriaRecipentObject(AEmail,
  ANome: String): TJsonObject;
  Var
    LJsonObjectAdd: TJsonObject;
begin
  LJsonObjectAdd := TJsonObject.Create;

  LJsonObjectAdd.AddPair('address', AEmail);
  If Not ANome.IsEmpty Then
    LJsonObjectAdd.AddPair('name', ANome);

  Result := TJsonObject.Create;
  Result.AddPair('emailAddress', LJsonObjectAdd);
end;

function TEnvioEmailOutlookOAuth2.RetornaDateTimeOffset(
  ADataHora: TDateTime): String;
begin
  Result := FormatDateTime('yyyy-mm-dd', ADataHora);
  Result := Result + 'T';
  Result := Result + FormatDateTime('hh:mm:ss', ADataHora) + 'Z';
end;

function TEnvioEmailOutlookOAuth2.RetornaJsonMensagemMicrosoftOutlook(AMensagem: TIdMessage;
  AGravaPastaEnviados, AImportante: Boolean): TJsonObject;
  Var
    LJsonObject,
    LJsonObjectAdd: TJsonObject;

    LJsonRecipients,
    LJsonArrayAdd: TJsonArray;

    LItemContador: Integer;

    LIdMensagem,
    LCorpoMensagem: String;
begin
  Result := TJsonObject.Create;

  LJsonObject := TJsonObject.Create;
  LJsonObject.AddPair('subject', AMensagem.Subject);

  //Corpo
  LJsonObjectAdd := TJsonObject.Create;
  LJsonObjectAdd.AddPair('contentType', 'html');

  LCorpoMensagem := EmptyStr;
  For LItemContador := 0 To AMensagem.MessageParts.Count -1 Do
  Begin
    If AMensagem.MessageParts[LItemContador] Is TidText Then
      LCorpoMensagem := LCorpoMensagem + TidText(AMensagem.MessageParts[LItemContador]).Body.Text;
  End;

  LJsonObjectAdd.AddPair('content', LCorpoMensagem);
  LJsonObject.AddPair('body', LJsonObjectAdd);

  //Remetente
  LJsonObject.AddPair('from', CriaRecipentObject(AMensagem.From.Address,
                                                 AMensagem.From.Name));

  //Para
  LJsonRecipients := TJsonArray.Create;
  For LItemContador := 0 To AMensagem.Recipients.Count - 1 Do
    LJsonRecipients.AddElement(CriaRecipentObject(AMensagem.Recipients[LItemContador].Address,
                                                  AMensagem.Recipients[LItemContador].Name) As TJsonValue);

  If LJsonRecipients.Count > 0 Then
    LJsonObject.AddPair('toRecipients', LJsonRecipients);

  //Cópia
  LJsonRecipients := TJsonArray.Create;
  For LItemContador := 0 To AMensagem.CCList.Count - 1 Do
    LJsonRecipients.AddElement(CriaRecipentObject(AMensagem.CCList[LItemContador].Address,
                                                  AMensagem.CCList[LItemContador].Name) As TJsonValue);

  If LJsonRecipients.Count > 0 Then
    LJsonObject.AddPair('ccRecipients', LJsonRecipients);

  //Cópia  Oculta
  LJsonRecipients := TJsonArray.Create;
  For LItemContador := 0 To AMensagem.BccList.Count - 1 Do
    LJsonRecipients.AddElement(CriaRecipentObject(AMensagem.BccList[LItemContador].Address,
                                                  AMensagem.BccList[LItemContador].Name) As TJsonValue);
  
  If LJsonRecipients.Count > 0 Then
    LJsonObject.AddPair('bccRecipients', LJsonRecipients);

  LIdMensagem := AMensagem.ExtraHeaders.Values['Message-Id'];

  LJsonObject.AddPair('createdDateTime', RetornaDateTimeOffset(fNow));
  LJsonObject.AddPair('id', LIdMensagem);
  LJsonObject.AddPair('importance', IIF(Not AImportante, 'normal', 'high'));

  LJsonObject.AddPair('internetMessageId', LIdMensagem);

  LJsonObject.AddPair('hasAttachments', TJSONBool.Create(AMensagem.MessageParts.Count > 0));
  If AMensagem.MessageParts.Count > 0 Then
  Begin
    LJsonArrayAdd := TJsonArray.Create;

    For LItemContador := 0 To AMensagem.MessageParts.Count -1 Do
    Begin
      If AMensagem.MessageParts[LItemContador] Is TIdAttachmentFile Then
      Begin
        LJsonObjectAdd := TJsonObject.Create;
        LJsonObjectAdd.AddPair('@odata.type', '#microsoft.graph.fileAttachment');
        LJsonObjectAdd.AddPair('contentBytes', RetornaArquivoBase64(TIdAttachmentFile(AMensagem.MessageParts[LItemContador]).StoredPathName));
        LJsonObjectAdd.AddPair('contentId', AMensagem.MessageParts[LItemContador].ContentID.Replace('<', EmptyStr).Replace('>', EmptyStr));
        LJsonObjectAdd.AddPair('contentType', AMensagem.MessageParts[LItemContador].ContentType);
        LJsonObjectAdd.AddPair('id', AMensagem.MessageParts[LItemContador].ID.ToString);
        LJsonObjectAdd.AddPair('isInline', TJSONBool.Create(AMensagem.MessageParts[LItemContador].ContentDisposition.Equals('inline')));
        LJsonObjectAdd.AddPair('name', AMensagem.MessageParts[LItemContador].FileName);

        LJsonArrayAdd.AddElement(LJsonObjectAdd As TJsonValue);
      End;
    End;

    LJsonObject.AddPair('attachments', LJsonArrayAdd);
  End;

  Result.AddPair('message', LJsonObject);
  Result.AddPair('saveToSentItems', TJSONBool.Create(AGravaPastaEnviados));
end;

end.
