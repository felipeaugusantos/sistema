unit untQualiZapEnqueueMessageToSend;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, untFuncoesSimples, REST.Client,
  Data.DB, MemDS, DBAccess, Uni, untTypesSistema;

type

  TItemsClass = class
  private
    FDescription: String;
    FTitle: String;
  public
    property description: String read FDescription write FDescription;
    property title: String read FTitle write FTitle;
  end;

  TListConfigClass = class
  private
    FItems: TArray<TItemsClass>;
    FTitle: String;
  public
    property items: TArray<TItemsClass> read FItems write FItems;
    property title: String read FTitle write FTitle;
    destructor Destroy; override;
  end;

  TButtonsClass = class
  private
    FText: String;
    FUrl: String;
  public
    property text: String read FText write FText;
    property url: String read FUrl write FUrl;
  end;

  TUrlButtonConfigClass = class
  private
    FButtons: TArray<TButtonsClass>;
    FTitle: String;
  public
    property buttons: TArray<TButtonsClass> read FButtons write FButtons;
    property title: String read FTitle write FTitle;
    destructor Destroy; override;
  end;

  TButtonsConfigClass = class
  private
    FButtons: TArray<String>;
    FTitle: String;
  public
    property buttons: TArray<String> read FButtons write FButtons;
    property title: String read FTitle write FTitle;
  end;

  TEnqueueMessageToSend = class
  private
    FApiKey: String;
    FTemplateId: Integer;
    FHeaderFile: String;
    FHeaderFileName: String;
    FVarsdata: TArray<String>;
    FButtonsConfig: TButtonsConfigClass;
    FCampaignName: String;
    FExtData: String;
    FExtFlag: Extended;
    FFileId: Extended;
    FFile_id: Extended;
    FListConfig: TListConfigClass;
    FNumber: String;
    FQueueId: Extended;
    FText: String;
    FUrlButtonConfig: TUrlButtonConfigClass;
    FHidden: Boolean;
  public
    property apiKey: String read FApiKey write FApiKey;
    property templateId: Integer read FTemplateId write FTemplateId;
    property headerFile: String read FHeaderFile write FHeaderFile;
    property headerFileName: String read FHeaderFileName write FHeaderFileName;
    property varsdata: TArray<String> read FVarsdata write FVarsdata;
    property buttonsConfig: TButtonsConfigClass read FButtonsConfig write FButtonsConfig;
    property campaignName: String read FCampaignName write FCampaignName;
    property extData: String read FExtData write FExtData;
    property extFlag: Extended read FExtFlag write FExtFlag;
    property fileId: Extended read FFileId write FFileId;
    property file_id: Extended read FFile_id write FFile_id;
    property listConfig: TListConfigClass read FListConfig write FListConfig;
    property number: String read FNumber write FNumber;
    property queueId: Extended read FQueueId write FQueueId;
    property text: String read FText write FText;
    property urlButtonConfig: TUrlButtonConfigClass read FUrlButtonConfig write FUrlButtonConfig;
    property hidden: Boolean read FHidden write FHidden;
    constructor Create(blnCreateButtonsConfig, blnCreateUrlButtonConfig, blnCreateListConfig, blnMensagemOculta: Boolean);
    destructor Destroy; override;
    class function ToJsonString(EnqueueMessageToSend: TEnqueueMessageToSend): string;
  end;

  TReturnEnqueueMessageToSend = class
  private
    FEnqueuedId: Extended;
    FMessage: String;
  public
    property enqueuedId: Extended read FEnqueuedId write FEnqueuedId;
    property message: String read FMessage write FMessage;
    class function FromJsonString(AJsonString: string): TReturnEnqueueMessageToSend;
  end;

  TControllerEnqueueMessageToSend = class
  private
    class function fSend(EnqueueMessageToSend: TEnqueueMessageToSend; AutIncNotfic: String): TReturnEnqueueMessageToSend;
    class procedure pValidaFilaEApiKey(EnqueueMessageToSend: TEnqueueMessageToSend);
  public
    class function fSendMessage(EnqueueMessageToSend: TEnqueueMessageToSend; strNomGat, strFrmDis, AutIncNotfic: String; ACodOpe: String = ''): Boolean;
  end;

implementation

uses
  untRestApi, untQualiZapRestApi, untConstantes;

{TListConfigClass}

destructor TListConfigClass.Destroy;
var
  LitemsItem: TItemsClass;
begin

 for LitemsItem in FItems do
   LitemsItem.free;

  inherited;
end;

{TUrlButtonConfigClass}

destructor TUrlButtonConfigClass.Destroy;
var
  LbuttonsItem: TButtonsClass;
begin

 for LbuttonsItem in FButtons do
   LbuttonsItem.free;

  inherited;
end;

{TEnqueueMessageToSend}

constructor TEnqueueMessageToSend.Create(blnCreateButtonsConfig, blnCreateUrlButtonConfig, blnCreateListConfig, blnMensagemOculta: Boolean);
begin
  FHidden := blnMensagemOculta;

  if blnCreateButtonsConfig then
    FButtonsConfig := TButtonsConfigClass.Create();

  if blnCreateUrlButtonConfig then
    FUrlButtonConfig := TUrlButtonConfigClass.Create();

  if blnCreateListConfig then
    FListConfig := TListConfigClass.Create();
end;

destructor TEnqueueMessageToSend.Destroy;
begin
  if Assigned(FButtonsConfig) then
    FreeAndNil(FButtonsConfig);

  if Assigned(FUrlButtonConfig) then
    FreeAndNil(FUrlButtonConfig);

  if Assigned(FListConfig) then
    FreeAndNil(FListConfig);

  inherited;
end;

class function TEnqueueMessageToSend.ToJsonString(EnqueueMessageToSend: TEnqueueMessageToSend): string;
begin
  result := TJson.ObjectToJsonString(EnqueueMessageToSend);
end;

{TReturnEnqueueMessageToSend}
class function TReturnEnqueueMessageToSend.FromJsonString(AJsonString: string): TReturnEnqueueMessageToSend;
begin
  result := TJson.JsonToObject<TReturnEnqueueMessageToSend>(AJsonString);
end;

{ TControllerEnqueueMessageToSend }

class function TControllerEnqueueMessageToSend.fSendMessage(
  EnqueueMessageToSend: TEnqueueMessageToSend; strNomGat, strFrmDis, AutIncNotfic: String; ACodOpe: String = ''): Boolean;
var
  ReturnEnqueueMessageToSend: TReturnEnqueueMessageToSend;
  qryWppEnv: TUniQuery;
begin
  Result := False;

  pValidaFilaEApiKey(EnqueueMessageToSend);

  {*************************************************************************}
  {************************** Enviando a mensagem **************************}
  {***********************************************************************BL}
  ReturnEnqueueMessageToSend := fSend(EnqueueMessageToSend, AutIncNotfic);

  if Assigned(ReturnEnqueueMessageToSend) then
  begin
    Result := True;

    qryWppEnv := fCriaQuery(nil);
    try
      qryWppEnv.Close;
      qryWppEnv.SQL.Text :=
      STR_SQL_NAO_REPLICAR+
      ' INSERT INTO WPPENV '+
      '   (AUTOINCREM, '+
      '    WPP_FILENV, '+
      '    WPP_CELULA, '+
      '    WPP_MENSAG, '+
      '    WPP_DTAENV, '+
      '    WPP_CODEMP, '+
      '    WPP_CODOPE, '+
      '    WPP_NOMGAT, '+
      '    WPP_FRMDIS, '+
      '    WPP_SEQNOT) '+
      ' VALUES '+
      '   (:AUTINC, '+
      '    :FILENV, '+
      '    :CELULA, '+
      '    :MENSAG, '+
      '    :DTAENV, '+
      '    :CODEMP, '+
      '    :CODOPE, '+
      '    :NOMGAT, '+
      '    :FRMDIS, '+
      '    :SEQNOT) ';

      qryWppEnv.ParamByName('AUTINC').AsString   := fRetAutoIncrem('WPPENV', VS_strCodEmp);
      qryWppEnv.ParamByName('FILENV').AsString   := FloatToStr(EnqueueMessageToSend.FQueueId);
      qryWppEnv.ParamByName('CELULA').AsString   := EnqueueMessageToSend.number;
      qryWppEnv.ParamByName('MENSAG').AsString   := EnqueueMessageToSend.text;
      qryWppEnv.ParamByName('DTAENV').AsDateTime := fRetDtaHraServidor;
      qryWppEnv.ParamByName('CODEMP').AsString   := VS_strCodEmp;
      qryWppEnv.ParamByName('CODOPE').AsString   := IIF(fEmptyStr(ACodOpe), strLoginUsuarioLogado, ACodOpe);
      qryWppEnv.ParamByName('NOMGAT').AsString   := strNomGat;
      qryWppEnv.ParamByName('FRMDIS').AsString   := strFrmDis;
      qryWppEnv.ParamByName('SEQNOT').AsString   := AutIncNotfic;
      qryWppEnv.ExecSql;
    finally
      FreeAndNil(qryWppEnv);
    end;
    FreeAndNil(ReturnEnqueueMessageToSend);
  end;
end;

class procedure TControllerEnqueueMessageToSend.pValidaFilaEApiKey(EnqueueMessageToSend: TEnqueueMessageToSend);
begin
  if fEmptyStr(EnqueueMessageToSend.apiKey) then
    fRetFilaEApiKeyPrincipalWhatsapp(EnqueueMessageToSend.FQueueId, EnqueueMessageToSend.FApiKey);
end;

class function TControllerEnqueueMessageToSend.fSend(EnqueueMessageToSend: TEnqueueMessageToSend; AutIncNotfic: String): TReturnEnqueueMessageToSend;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/enqueueMessageToSend';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TEnqueueMessageToSend.ToJsonString(EnqueueMessageToSend),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], AutIncNotfic) then
      Result := TReturnEnqueueMessageToSend.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
