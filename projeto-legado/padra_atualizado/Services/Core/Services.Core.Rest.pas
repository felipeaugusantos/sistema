unit Services.Core.Rest;

interface

uses System.Classes, System.SysUtils, System.Generics.Collections, Rest.Types,
  System.NetEncoding;

type
  TAuthenticator = class;

  TRestClient = class(TComponent)
  private
    FAccept: String;
    FAcceptCharset: String;
    FBaseURL: String;
    FAuthenticator: TAuthenticator;
    FContentType: String;
  public
    property Accept: String Read FAccept Write FAccept;
    property AcceptCharset: String Read FAcceptCharset Write FAcceptCharset;
    property Authenticator: TAuthenticator Read FAuthenticator
      Write FAuthenticator;
    property BaseURL: String Read FBaseURL Write FBaseURL;
    property ContentType: String Read FContentType Write FContentType;
  end;

  TAuthenticator = class abstract
  public
    constructor Create(ARestClient: TRestClient); virtual; abstract;
  end;

  TOAuth2TokenType = (ttBEARER, ttBASIC);

  TOAuth2Authenticator = class(TAuthenticator)
  private
    FRestClient: TRestClient;
    FClientID: String;
    FClientSecret: String;
    FTokenType: TOAuth2TokenType;
    FAccessToken: String;
  public
    constructor Create(ARestClient: TRestClient); override;

    property ClientID: String Read FClientID write FClientID;
    property ClientSecret: String Read FClientSecret write FClientSecret;
    property TokenType: TOAuth2TokenType Read FTokenType write FTokenType;
    property AccessToken: String Read FAccessToken write FAccessToken;
  end;

  TRestResponse = class
  private
    FRestClient: TRestClient;
    FContentType: String;
    FContent: String;
    FStatusCode: Integer;
    FHeaders: TStrings;
  public
    constructor Create(ARestClient: TRestClient);
    destructor Destroy; override;
    property ContentType: String Read FContentType Write FContentType;
    property Content: String Read FContent write FContent;
    property StatusCode: Integer Read FStatusCode write FStatusCode;
    property Headers: TStrings read FHeaders write FHeaders;
  end;

  TRestRequestParam = record
    Name: String;
    Value: String;
    Kind: TREstRequestParameterKind;
    Options: TRESTRequestParameterOptions;
    ContentType: TRESTContentType;
  end;

  TRestRequestParams = class
  private
    FParams: TList<TRestRequestParam>;
    function GetItem(index: Integer): TRestRequestParam;
    procedure SetItem(index: Integer; const Value: TRestRequestParam);
  public
    constructor Create();
    destructor Destroy; override;
    function Count: Integer;
    procedure AddItem(AName, AValue: string; AKind: TREstRequestParameterKind;
      AOptions: TRESTRequestParameterOptions = [];
      AContentType: TRESTContentType = ctNone);
    property Item[index: Integer]: TRestRequestParam Read GetItem
      Write SetItem; default;
    property Items: TList<TRestRequestParam> Read FParams;
  end;

  TRestMethod = (rmPOST, rmPUT, rmGET, rmDELETE, rmPATCH);

  TRestMethodHelper = record helper for TRestMethod
    function AsString: String;
  end;

  TRestRequest = class
  private
    FResponse: TRestResponse;
    FRestClient: TRestClient;
    FMethod: TRestMethod;
    FParams: TRestRequestParams;
    FResource: String;
    FAccept: String;
    FAcceptCharset: String;
    FFile: String;
  public
    constructor Create(ARestClient: TRestClient);
    destructor Destroy; override;
    procedure AddFile(const AFileName: String);
    procedure Execute;
    property Params: TRestRequestParams read FParams write FParams;
    property Response: TRestResponse read FResponse write FResponse;
    property RestClient: TRestClient read FRestClient write FRestClient;
    property Resource: String Read FResource write FResource;
    property Method: TRestMethod read FMethod write FMethod;
    property Accept: string read FAccept write FAccept;
    property AcceptCharset: string read FAcceptCharset write FAcceptCharset;
    property &File: string read FFile write FFile;
  end;

implementation

{ TOAuth2Authenticator }

uses Services.Core.Utils, StrUtils;

constructor TOAuth2Authenticator.Create(ARestClient: TRestClient);
begin
  FRestClient := ARestClient;
end;

{ TRestResponse }

constructor TRestResponse.Create(ARestClient: TRestClient);
begin
  FRestClient := ARestClient;
end;

destructor TRestResponse.Destroy;
begin
  if Assigned(FHeaders) then
    FHeaders.Free;
  inherited;
end;

{ TRestRequest }

procedure TRestRequest.AddFile(const AFileName: String);
begin
  &File := AFileName;
end;

constructor TRestRequest.Create(ARestClient: TRestClient);
begin
  FRestClient := ARestClient;
  FParams := TRestRequestParams.Create;
end;

destructor TRestRequest.Destroy;
begin
  FParams.Free;
  inherited;
end;

procedure TRestRequest.Execute;
Const
  ERROR_CODE = 'returned error: ';
Var
  LRequest,
  LUrl,
  LJson,
  strConCat: String;
  LParam: TRestRequestParam;
  LHeader: TStrings;
begin
  LHeader := nil;

  Try
    Sleep(250);
    LRequest := 'curl';
    LRequest := LRequest + ' --location ';//o cliente HTTP manipulará os redirecionamentos automaticamente
    LRequest := LRequest + ' --request ' + Self.Method.AsString;//GET, POST, PUT, DELETE
    LRequest := LRequest + ' --connect-timeout 10'; // 10 segundos timeout
    LRequest := LRequest + ' --max-time 60'; // 60 segundos tempo limite para concluir operação

    LUrl := TNetEncoding.Html.Encode(FRestClient.BaseURL + ifThen(Self.Resource.StartsWith('/'),'', '/') + Self.Resource)
      .Replace(' ', '%20').Replace('&amp;','&');

    {******************************}
    {*********  HEADER   **********}
    {****************************BL}
    For LParam In FParams.Items Do
      If (LParam.Kind = pkHTTPHEADER) And
         (LParam.ContentType = ctNone) Then
      Begin
        LRequest := LRequest + ' --header ' + QuotedStr(LParam.Name + ': ' +LParam.Value);
      End;

    {******************************}
    {**********   GET   ***********}
    {****************************BL}
    strConCat := '?';
    For LParam In FParams.Items Do
      If (LParam.Kind = pkGETorPOST) And
         (LParam.ContentType = ctNone) And
         (Self.Method = rmGET) Then
      Begin
        LUrl := LUrl + strConCat + LParam.Name + '=' + StringReplace(LParam.Value, ' ', '+', [rfReplaceAll]);
        strConCat := '&';
      End;

    LRequest := LRequest + ' --url ' + QuotedStr(LUrl);

    if fEmptyStr(&File) then
    begin
      LRequest := LRequest + ' --header ' +
        QuotedStr('Accept: ' + FRestClient.Accept);

      LRequest := LRequest + ' --header ' +
        QuotedStr('Content-Type: ' + FRestClient.ContentType);
    end;

    {*********************************}
    {********** POST / PUT ***********}
    {*******************************BL}
    For LParam In FParams.Items Do
      If (LParam.Kind = pkGETorPOST) And
         (LParam.ContentType = ctNone) And
         ((Self.Method = rmPOST) Or (Self.Method = rmPUT)) Then
      Begin
        LRequest := LRequest + ' --data-urlencode ' + QuotedStr(LParam.Name + '=' + LParam.Value);
      End;

    {*********************************}
    {********** JSON BODY ************}
    {*******************************BL}
    LJson := '';
    For LParam In FParams.Items Do
    begin
      If (LParam.Kind = pkREQUESTBODY) And
         (LParam.ContentType = ctAPPLICATION_JSON) Then
      Begin
        LJson := LParam.Value;
      End
    end;

    if not fEmptyStr(&File) then
      LRequest := LRequest + ' --form "file=@'+&File+'" ';

    If (Assigned(FRestClient)) And
       (FRestClient.Authenticator Is TOAuth2Authenticator) Then
    Begin
      If (TOAuth2Authenticator(FRestClient.Authenticator).TokenType = ttBEARER) And
         (Not TOAuth2Authenticator(FRestClient.Authenticator).AccessToken.IsEmpty) Then
      Begin
        LRequest := LRequest + ' --header ' +
          QuotedStr('Authorization: Bearer ' + TOAuth2Authenticator(FRestClient.Authenticator).AccessToken);
      End
      Else
      If (TOAuth2Authenticator(FRestClient.Authenticator).TokenType = ttBASIC) And
         (Not TOAuth2Authenticator(FRestClient.Authenticator).ClientID.IsEmpty) And
         (Not TOAuth2Authenticator(FRestClient.Authenticator).ClientSecret.IsEmpty) Then
      Begin
        TOAuth2Authenticator(FRestClient.Authenticator).AccessToken :=
          TNetencoding.Base64.Encode(TOAuth2Authenticator(FRestClient.Authenticator).ClientID.Trim+':'+
                                     TOAuth2Authenticator(FRestClient.Authenticator).ClientSecret.Trim);

        LRequest := LRequest + ' --header ' +
          QuotedStr('Authorization: Basic ' + TOAuth2Authenticator(FRestClient.Authenticator).AccessToken);
      End;
    End;

    FResponse.Content := ExecuteCurl(LRequest, LJson, Self.Method.AsString, False, LHeader);
    FResponse.Headers := LHeader;

    if (FRestClient.Authenticator Is TOAuth2Authenticator) Then
      TOAuth2Authenticator(FRestClient.Authenticator).AccessToken := ''; // limpa o token a cada chamada na api

    If FResponse.Content.StartsWith('*') Then//Ocorreu algum erro no curl
    Begin
      If FResponse.Content.Contains(ERROR_CODE) Then
        FResponse.StatusCode := StrToIntDef(Copy(FResponse.Content, Pos(ERROR_CODE, FResponse.Content) + Length(ERROR_CODE), 3), 400)
      Else
        FResponse.StatusCode := 400
    End
    Else
      FResponse.StatusCode := 200;
  Except
    On E: Exception do
      FResponse.StatusCode := 400;
  End;
end;

{ TRestRequestParams }

procedure TRestRequestParams.AddItem(AName, AValue: string;
  AKind: TREstRequestParameterKind; AOptions: TRESTRequestParameterOptions = [];
  AContentType: TRESTContentType = ctNone);
Var
  LItem: TRestRequestParam;
begin
  LItem.Name := AName;
  LItem.Value := AValue;
  LItem.Kind := AKind;
  LItem.Options := AOptions;
  LItem.ContentType := AContentType;
  FParams.Add(LItem);
end;

function TRestRequestParams.Count: Integer;
begin
  Result := FParams.Count;
end;

constructor TRestRequestParams.Create;
begin
  FParams := TList<TRestRequestParam>.Create;
end;

destructor TRestRequestParams.Destroy;
begin
  FParams.Free;
  inherited;
end;

function TRestRequestParams.GetItem(index: Integer): TRestRequestParam;
begin
  Result := FParams[index];
end;

procedure TRestRequestParams.SetItem(index: Integer;
  const Value: TRestRequestParam);
begin
  FParams[index] := Value;
end;

{ TRestMethodHelper }

function TRestMethodHelper.AsString: String;
begin
  case Self of
    rmPOST: Result := 'POST';
    rmPUT: Result := 'PUT';
    rmGET: Result := 'GET';
    rmDELETE: Result := 'DELETE';
    Else Result := '';
  end;
end;

end.


