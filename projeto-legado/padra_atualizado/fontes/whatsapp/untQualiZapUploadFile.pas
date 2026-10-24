unit untQualiZapUploadFile;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, untFuncoesSimples, REST.Client,
  Data.DB, MemDS, DBAccess, Uni, untTypesSistema;

type

  TUploadFile = class
  private
    FApiKey: String;
    FData: String;
    FDuration: Extended;
    FFileName: String;
    FHeight: Extended;
    FMimeType: String;
    FQueueId: Extended;
    FSaveToGallery: Boolean;
    FThumbnail: String;
    FTitle: String;
    FWidth: Extended;
  public
    property apiKey: String read FApiKey write FApiKey;
    property data: String read FData write FData;
    property duration: Extended read FDuration write FDuration;
    property fileName: String read FFileName write FFileName;
    property height: Extended read FHeight write FHeight;
    property mimeType: String read FMimeType write FMimeType;
    property queueId: Extended read FQueueId write FQueueId;
    property saveToGallery: Boolean read FSaveToGallery write FSaveToGallery;
    property thumbnail: String read FThumbnail write FThumbnail;
    property title: String read FTitle write FTitle;
    property width: Extended read FWidth write FWidth;
    class function ToJsonString(UploadFile: TUploadFile): string;
  end;

  TReturnUploadFile = class
  private
    FFileId: Extended;
    FGalleryId: Extended;
    FMimeType: String;
  public
    property fileId: Extended read FFileId write FFileId;
    property galleryId: Extended read FGalleryId write FGalleryId;
    property mimeType: String read FMimeType write FMimeType;
    class function FromJsonString(AJsonString: string): TReturnUploadFile;
  end;

  TControllerUploadFile = class
  private
    class procedure pValidaFilaEApiKey(UploadFile: TUploadFile; conexao: TUniConnection = nil);
    class function fUpload(UploadFile: TUploadFile; AutIncNotfic: String; conexao: TUniConnection = nil): TReturnUploadFile;
  public
    class function fUploadFile(UploadFile: TUploadFile; AutIncNotfic: String; conexao: TUniConnection = nil): TReturnUploadFile;
  end;

implementation

uses
  untRestApi, untQualiZapRestApi;

{TUploadFile}

class function TUploadFile.ToJsonString(UploadFile: TUploadFile): string;
begin
  Result := TJson.ObjectToJsonString(UploadFile);
end;

{TReturnUploadFile}

class function TReturnUploadFile.FromJsonString(AJsonString: string): TReturnUploadFile;
begin
  Result := TJson.JsonToObject<TReturnUploadFile>(AJsonString);
end;

class function TControllerUploadFile.fUploadFile(UploadFile: TUploadFile; AutIncNotfic: String; conexao: TUniConnection = nil): TReturnUploadFile;
begin
  pValidaFilaEApiKey(UploadFile, conexao);

  Result := fUpload(UploadFile, AutIncNotfic, conexao);
end;

class procedure TControllerUploadFile.pValidaFilaEApiKey(UploadFile: TUploadFile; conexao: TUniConnection = nil);
begin
  if fEmptyStr(UploadFile.apiKey) then
    fRetFilaEApiKeyPrincipalWhatsapp(UploadFile.FQueueId, UploadFile.FApiKey, conexao);
end;

class function TControllerUploadFile.fUpload(UploadFile: TUploadFile; AutIncNotfic: String; conexao: TUniConnection = nil): TReturnUploadFile;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/uploadFile';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TUploadFile.ToJsonString(UploadFile),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], AutIncNotfic) then
      Result := TReturnUploadFile.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
