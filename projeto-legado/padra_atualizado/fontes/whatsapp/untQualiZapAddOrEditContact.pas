unit untQualiZapAddOrEditContact;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, untFuncoesSimples, REST.Client,
  Data.DB, MemDS, DBAccess, Uni, untTypesSistema,
  UniClientDataSet;

type

  TContact = class
  private
    FAddress: String;
    FAddressComp: String;
    FCity: String;
    FCountry: String;
    FDocument: String;
    FEmail: String;
    FFacebook: String;
    FFree1: String;
    FFree2: String;
    FHouseNumber: String;
    FInstagram: String;
    FName: String;
    FNeighborhood: String;
    FNumber: String;
    FPostalCode: String;
    FPreferredAgent: Extended;
    FPreferredAgents: TArray<Extended>;
    FState: String;
    FTags: TArray<Extended>;
  public
    property address: String read FAddress write FAddress;
    property addressComp: String read FAddressComp write FAddressComp;
    property city: String read FCity write FCity;
    property country: String read FCountry write FCountry;
    property document: String read FDocument write FDocument;
    property email: String read FEmail write FEmail;
    property facebook: String read FFacebook write FFacebook;
    property free1: String read FFree1 write FFree1;
    property free2: String read FFree2 write FFree2;
    property houseNumber: String read FHouseNumber write FHouseNumber;
    property instagram: String read FInstagram write FInstagram;
    property name: String read FName write FName;
    property neighborhood: String read FNeighborhood write FNeighborhood;
    property number: String read FNumber write FNumber;
    property postalCode: String read FPostalCode write FPostalCode;
    property preferredAgent: Extended read FPreferredAgent write FPreferredAgent;
    property preferredAgents: TArray<Extended> read FPreferredAgents write FPreferredAgents;
    property state: String read FState write FState;
    property tags: TArray<Extended> read FTags write FTags;
  end;

  TAddContact = class(TContact)
  private
    FQueueId: Extended;
    FApiKey: String;
  public
    property queueId: Extended read FQueueId write FQueueId;
    property apiKey: String read FApiKey write FApiKey;
    class function ToJsonString(AddContact: TAddContact): string;
  end;

  TReturnAddContact = class
  private
    FcontactId: Extended;
  public
    property contactId: Extended read FcontactId write FcontactId;
    class function FromJsonString(AJsonString: string): TReturnAddContact;
  end;

  TEditContact = class(TContact)
  private
    FQueueId: Extended;
    FApiKey: String;
    FId: Extended;
  public
    property queueId: Extended read FQueueId write FQueueId;
    property apiKey: String read FApiKey write FApiKey;
    property id: Extended read FId write FId;
    class function ToJsonString(EditContact: TEditContact): string;
  end;

  TReturnMessage = class
  private
    FMessage: String;
  public
    property messages: String read FMessage write FMessage;
    class function FromJsonString(AJsonString: string): TReturnMessage;
  end;

  TControllerAddOrEditContact = class
  private
    class function fAddOrEdit(AddContact: TAddContact; var intStatusRetorno: Integer): TReturnAddContact; overload;
    class function fAddOrEdit(EditContact: TEditContact; var intStatusRetorno: Integer): TReturnMessage; overload;

    class procedure pAlimetaObjeto(cdsContatos: TUniClientDataSet; objContato: TContact);
    class function fRetFilaEApiKey(var extIdFila: Extended; var strApiKey: String): Boolean;

    class procedure pGravaIdCiDe(const strTabela, strAutInc: String; const extIdCiDe: Extended);

    class function fRetMensagem(strMessages: String; intStatusCode: Integer): String;

  public
    class procedure pAddOrEditContact(cdsContatos: TUniClientDataSet);
    class function fCriaCdsContatos: TUniClientDataSet;
  end;

implementation

{ TAddContact }

uses untQualiZapRestApi, untRestApi, untConstantes, untFuncoesGenerica,
  untQualiZapSearchContact;

class function TAddContact.ToJsonString(AddContact: TAddContact): string;
begin
  Result := TJson.ObjectToJsonString(AddContact);
end;

{ TReturnAddContact }

class function TReturnAddContact.FromJsonString(AJsonString: string): TReturnAddContact;
begin
  Result := TJson.JsonToObject<TReturnAddContact>(AJsonString);
end;

{ TEditContact }

class function TEditContact.ToJsonString(EditContact: TEditContact): string;
begin
  Result := TJson.ObjectToJsonString(EditContact);
end;

{ TReturnMessage }

class function TReturnMessage.FromJsonString(AJsonString: string): TReturnMessage;
begin
  Result := TJson.JsonToObject<TReturnMessage>(AJsonString);
end;

{ TControllerAddOrEditContact }

class function TControllerAddOrEditContact.fCriaCdsContatos: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  Result.FieldDefs.Add('MARDES'     , ftString, 001);
  Result.FieldDefs.Add('TABELA'     , ftString, 006);
  Result.FieldDefs.Add('AUTOINCREM' , ftString, 020);
  Result.FieldDefs.Add('CTT_C_E_P_' , ftString, 009);
  Result.FieldDefs.Add('CTT_ENDERE' , ftString, 060);
  Result.FieldDefs.Add('CTT_NOMCID' , ftString, 040);
  Result.FieldDefs.Add('CTT_ESTADO' , ftString, 002);
  Result.FieldDefs.Add('CTT_PAIS__' , ftString, 060);
  Result.FieldDefs.Add('CTT_CODCLI' , ftString, 008);
  Result.FieldDefs.Add('CTT_NOMCTT' , ftString, 060);
  Result.FieldDefs.Add('CTT_DOCUME' , ftString, 018);
  Result.FieldDefs.Add('CTT_CELULA' , ftString, 015);
  Result.FieldDefs.Add('CTT_EMAIL_' , ftString, 255);
  Result.FieldDefs.Add('CTT_CODVEN' , ftString, 003);
  Result.FieldDefs.Add('CTT_VENDED' , ftString, 033);
  Result.FieldDefs.Add('CTT_IDEAGE' , ftExtended   );
  Result.FieldDefs.Add('CTT_IDCIDE' , ftExtended   );
  Result.FieldDefs.Add('SITUACAO'   , ftString, 255);

  Result.CreateDataSet;

  TStringField(Result.FieldByName('CTT_CELULA')).EditMask := fRetMascaraFonePais;
end;

class procedure TControllerAddOrEditContact.pAddOrEditContact(cdsContatos: TUniClientDataSet);
var
  AddContact: TAddContact;
  ReturnAddContact: TReturnAddContact;

  EditContact: TEditContact;
  ReturnEditContact: TReturnMessage;

  extIdFila: Extended;
  strApiKey: String;

  blnSincronizado: Boolean;

  intStatusRetorno: Integer;

  SearchContact: TReturnSearchContact;
begin
  AddContact := nil;
  ReturnAddContact := nil;
  EditContact := nil;
  ReturnEditContact := nil;

  blnSincronizado := False;

  if cdsContatos.IsEmpty then
    Exit;

  if not fRetFilaEApiKey(extIdFila, strApiKey) then
    Exit;

  AddContact := TAddContact.Create;
  EditContact := TEditContact.Create;
  try
    AddContact.queueId := extIdFila;
    AddContact.apiKey := strApiKey;

    EditContact.queueId := extIdFila;
    EditContact.apiKey := strApiKey;

    cdsContatos.DisableControls;

    cdsContatos.First;
    while not cdsContatos.IsEmpty do
    begin
      repeat
        if cdsContatos.FieldByName('CTT_IDCIDE').AsExtended = 0 then
        begin
          SearchContact := TSearchContact.fSearchContact(FIELD_NUMBER, '55'+cdsContatos.FieldByName('CTT_CELULA').AsString);
          if Assigned(SearchContact) then
          begin
            pGravaIdCiDe(cdsContatos.FieldByName('TABELA').AsString,
                         cdsContatos.FieldByName('AUTOINCREM').AsString,
                         SearchContact.id);

            cdsContatos.Edit;
            cdsContatos.FieldByName('CTT_IDCIDE').AsExtended := SearchContact.id;
            cdsContatos.Post;
          end;
        end;

        if cdsContatos.FieldByName('CTT_IDCIDE').AsExtended = 0 then
        begin
          pAlimetaObjeto(cdsContatos, AddContact);

          ReturnAddContact := fAddOrEdit(AddContact, intStatusRetorno);
          if Assigned(ReturnAddContact) then
          begin
            pGravaIdCiDe(cdsContatos.FieldByName('TABELA').AsString,
                         cdsContatos.FieldByName('AUTOINCREM').AsString,
                         ReturnAddContact.contactId);

            cdsContatos.Edit;
            cdsContatos.FieldByName('CTT_IDCIDE').AsExtended := ReturnAddContact.contactId;
            cdsContatos.Post;

            blnSincronizado := True;
            FreeAndNil(ReturnAddContact);
          end;
        end
        else
        begin
          pAlimetaObjeto(cdsContatos, EditContact);
          EditContact.id := cdsContatos.FieldByName('CTT_IDCIDE').AsExtended;

          ReturnEditContact := fAddOrEdit(EditContact, intStatusRetorno);
          if Assigned(ReturnEditContact)then
          begin
            blnSincronizado := True;
            FreeAndNil(ReturnEditContact);
          end
          else if intStatusRetorno = 404 then
          begin
            cdsContatos.Edit;
            cdsContatos.FieldByName('CTT_IDCIDE').AsExtended := 0;
            cdsContatos.Post;
          end;
        end;

      until intStatusRetorno <> 404;

      cdsContatos.Edit;
      cdsContatos.FieldByName('SITUACAO').AsString := IIF(blnSincronizado,
                                                          RETORNO_SUCESSO_ENVIO_CONTATO,
                                                          RETORNO_INSUCESSO_ENVIO_CONTATO);
      cdsContatos.FieldByName('MARDES').AsString := 'D';
      cdsContatos.Post;
    end;

  finally
    cdsContatos.EnableControls;

    FreeAndNil(AddContact);
    FreeAndNil(EditContact);
  end;
end;

class procedure TControllerAddOrEditContact.pAlimetaObjeto(cdsContatos: TUniClientDataSet; objContato: TContact);
begin
  objContato.postalCode     := cdsContatos.FieldByName('CTT_C_E_P_').AsString;
  objContato.address        := cdsContatos.FieldByName('CTT_ENDERE').AsString;
  objContato.city           := cdsContatos.FieldByName('CTT_NOMCID').AsString;
  objContato.state          := cdsContatos.FieldByName('CTT_ESTADO').AsString;
  objContato.country        := cdsContatos.FieldByName('CTT_PAIS__').AsString;
  objContato.free1          := cdsContatos.FieldByName('CTT_CODCLI').AsString;
  objContato.name           := cdsContatos.FieldByName('CTT_NOMCTT').AsString;
  objContato.document       := cdsContatos.FieldByName('CTT_DOCUME').AsString;
  objContato.number         := '55'+cdsContatos.FieldByName('CTT_CELULA').AsString;
  objContato.email          := cdsContatos.FieldByName('CTT_EMAIL_').AsString;
  objContato.preferredAgent := cdsContatos.FieldByName('CTT_IDEAGE').AsExtended;

  SetLength(objContato.FPreferredAgents, 1);
  objContato.preferredAgents[0] := objContato.preferredAgent;
end;

class function TControllerAddOrEditContact.fRetFilaEApiKey(var extIdFila: Extended; var strApiKey: String): Boolean;
begin
  Result := fRetFilaEApiKeyPrincipalWhatsapp(extIdFila, strApiKey);
  if not Result then
    fMensagem('ATENÇÃO!', 'Para sincronizar contatos com o CitelDesk é necessário que alguma fila seja definada como Fila Principal.', ['&Ok']);
end;

class procedure TControllerAddOrEditContact.pGravaIdCiDe(const strTabela, strAutInc: String;
  const extIdCiDe: Extended);
var
  qryIdCiDe: TUniQuery;
begin
  qryIdCiDe := fCriaQuery(nil);
  try
    qryIdCiDe.Close;
    qryIdCiDe.SQL.Text :=
    ' UPDATE '+strTabela+
    ' SET '+
    '   CLI_IDCIDE = :IDCIDE '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryIdCiDe.ParamByName('IDCIDE').Value := extIdCiDe;
    qryIdCiDe.ParamByName('AUTINC').AsString := strAutInc;
    qryIdCiDe.ExecSQL;
  finally
    FreeAndNil(qryIdCiDe);
  end;
end;

class function TControllerAddOrEditContact.fAddOrEdit(AddContact: TAddContact; var intStatusRetorno: Integer): TReturnAddContact;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  ReturnMessageErro: TReturnMessage;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/addContact';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TAddContact.ToJsonString(AddContact),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TReturnAddContact.FromJsonString(JSONRetorno)
    else
    begin
      try
        ReturnMessageErro := TReturnMessage.FromJsonString(JSONRetorno);
        fMensagem('ATENÇÃO!', fRetMensagem(ReturnMessageErro.messages, RestRequest.Response.StatusCode), ['&Ok']);

        FreeAndNil(ReturnMessageErro);
      except
      end;
    end;

    intStatusRetorno := RestRequest.Response.StatusCode;
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TControllerAddOrEditContact.fAddOrEdit(EditContact: TEditContact; var intStatusRetorno: Integer): TReturnMessage;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  ReturnMessageErro: TReturnMessage;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/editContact';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TEditContact.ToJsonString(EditContact),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TReturnMessage.FromJsonString(JSONRetorno)
    else
    begin
      try
        ReturnMessageErro := TReturnMessage.FromJsonString(JSONRetorno);
        fMensagem('WHATSAPP - CONTATO NÃO SINCRONIZADO!', fRetMensagem(ReturnMessageErro.messages, RestRequest.Response.StatusCode), ['&Ok']);

        FreeAndNil(ReturnMessageErro);
      except
      end;
    end;

    intStatusRetorno := RestRequest.Response.StatusCode;
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TControllerAddOrEditContact.fRetMensagem(strMessages: String; intStatusCode: Integer): String;
begin
  case intStatusCode of
    400: Result := 'Envio não realizado. Dados obrigatórios faltando!';
    401: Result := 'Envio não autorizado. Por favor, verifique se as configurações do grupo INTEGRAÇÃO DE SISTEMAS - WHATSAPP estão preenchidas corretamente!';
    500: Result := 'Erro interno da Api!';
    503: Result := 'Fila indisponível, desabilitada, desconectada ou não autenticada!';
    else
      Result := 'Não foi possível estabelecer conexão com a Api!'+#13#10+strMessages;
  end;
end;

end.
