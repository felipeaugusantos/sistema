unit api.client.core;

interface

uses
  Winapi.Windows,
  DateUtils,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.NetConsts,
  System.Net.URLClient,
  System.Net.HttpClient,
  System.Net.Mime,
  System.NetEncoding,
  Soap.EncdDecd,
  OpenSSL.RSAUtils;

type
  {$M+}
  TApiClientCore = class
  private
    FRequest: THTTPClient;
    FFormData: TMultipartFormData;
    FResponse: IHTTPResponse;

    FUrl: String;
    FMetodo: String;
    FToken: String;
    FJsonRetorno: String;
    FJsonEnvio: String;
    FStatusCode: Integer;
    FContentType: String;
    FFormDataField: String;
    FFormDataFieldValue: String;
    FFormDataFile: String;
    FFormDataFilePath: String;
    FProxyServer: String;
    FProxyPort: Integer;
    FProxyUsername: String;
    FProxyPassword: String;
    FBytes: TBytes;

  published
    property Url: String read FUrl write FUrl;
    property Metodo: String read FMetodo write FMetodo;
    property Token: String read FToken write FToken;
    property ContentType: String read FContentType write FContentType;
    property FormDataField: String read FFormDataField write FFormDataField;
    property FormDataFieldValue: String read FFormDataFieldValue write FFormDataFieldValue;
    property FormDataFile: String read FFormDataFile write FFormDataFile;
    property FormDataFilePath: String read FFormDataFilePath write FFormDataFilePath;
    property ProxyServer: String read FProxyServer write FProxyServer;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property ProxyUsername: String read FProxyUsername write FProxyUsername;
    property ProxyPassword: String read FProxyPassword write FProxyPassword;
    property Bytes: TBytes read FBytes write FBytes;
    property JsonEnvio: String read FJsonEnvio write FJsonEnvio;
    property JsonRetorno: String read FJsonRetorno;
    property StatusCode: Integer read FStatusCode;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
  end;

type
  TToken = class
  private
    FCnpjEmitente: WideString;
    FPrefixoCliente: String;
    FChavePublica: TStringList;
    FUnixTimestamp: Int64;
    function fRetornaUnixTimestamp: Int64;
    function fCriptografa(AConteudo: WideString; AChavePublica: TStringList): AnsiString;
  published
    property CnpjEmitente: WideString  read FCnpjEmitente   write FCnpjEmitente;
    property PrefixoCliente: String    read FPrefixoCliente write FPrefixoCliente;
    property ChavePublica: TStringList read FChavePublica   write FChavePublica;
    property UnixTimestamp: Int64      read FUnixTimestamp  write FUnixTimestamp;
  public
    function Execute: WideString;
    function ExecutePrefix: WideString;
  end;

implementation

{ TApiClientCore }

constructor TApiClientCore.Create;
begin
  FRequest := THTTPClient.Create;
  FFormData := TMultipartFormData.Create();
end;

destructor TApiClientCore.Destroy;
begin
  If Assigned(FRequest) Then
    FreeAndNil(FRequest);

  If Assigned(FFormData) Then
    FreeAndNil(FFormData);

  inherited;
end;

procedure TApiClientCore.Execute;
var
  LBytes: TBytes;
  LBytesStream: TBytesStream;
  LStringStream: TStringStream;
begin
  LBytesStream := nil;
  LStringStream := nil;

  if not FProxyServer.IsEmpty then
  Begin
    FRequest.ProxySettings.Create(FProxyServer, FProxyPort, FProxyUsername, FProxyPassword);
  End;

  FRequest.CustomHeaders['Authorization'] := FToken;

  if Pos('Basic', FToken) > 0 then
    FRequest.Accept := 'application/json';

  Case AnsiIndexText(Metodo, ['GET','DELETE','POST']) Of
    0: FResponse := FRequest.Get(FUrl);
    1: FResponse := FRequest.Delete(FUrl);
    2: Begin
         Try
           If (not FormDataField.IsEmpty) Or (not FormDataFile.IsEmpty) then
           Begin
             Try
               if not FormDataField.IsEmpty then
                 FFormData.AddField(FormDataField, FormDataFieldValue);

               if not FormDataFile.IsEmpty then
                 FFormData.AddFile(FormDataFile, FormDataFilePath);

               FResponse := FRequest.Post(FUrl, FFormData);
             Except

             End;
           End
           Else if Assigned(FBytes) then
           Begin
             Try
               LBytesStream := TBytesStream.Create(FBytes);
               FFormData.AddStream('file', LBytesStream, 'documento', FContentType);

               FResponse := FRequest.Post(FUrl, FFormData);
             Except

             End;
           End
           Else
           Begin
             Try
               FRequest.ContentType := FContentType;

               LBytes := TEncoding.UTF8.GetBytes(FJsonEnvio);
               LBytesStream := TBytesStream.Create(LBytes);

               FResponse := FRequest.Post(FUrl, LBytesStream);
             Except

             End;
           End;
         Finally
           If Assigned(LBytesStream) Then
             FreeAndNil(LBytesStream);
         End;
       End;
  End;

  FJsonRetorno := FResponse.ContentAsString;
  FStatusCode  := FResponse.StatusCode;

  If Pos('pdf', FResponse.MimeType) > 0 Then
  Begin
    LStringStream := TStringStream.Create(RawByteString(FResponse.ContentAsString));

    Try
      FJsonRetorno := LStringStream.DataString;
    Finally
      FreeAndNil(LStringStream);
    End;
  End;

end;

{ TToken }

function TToken.fRetornaUnixTimestamp: Int64;
var
  DateTime: TDateTime;
  SystemTime: TSystemTime;
begin
  If not (UnixTimestamp = 326503521948) Then
  Begin
    Result := UnixTimestamp;
    Exit;
  End;

  GetSystemTime(SystemTime);
  DateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
              EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
  Result := DateUtils.MilliSecondsBetween(DateTime, UnixDateDelta);
end;

function TToken.ExecutePrefix: WideString;
var
  LCriptografado: AnsiString;
begin
  LCriptografado := fCriptografa(FPrefixoCliente+'|'+ IntToStr(FUnixTimestamp), FChavePublica);

  Result := FPrefixoCliente+'|'+ IntToStr(FUnixTimestamp) +'|'+ WideString(LCriptografado);

  Result := StringReplace( StringReplace(Result, #13, '', [rfReplaceAll]), #10, '', [rfReplaceAll]);
end;

function TToken.fCriptografa(AConteudo: WideString; AChavePublica: TStringList): AnsiString;
var
  rsa:        TRSAUtil;
  pubkey:     TRSAPublicKey;
  outStream:  TBytesStream;
  keyStream:  TStringStream;
  inStream:   TStringStream;
begin
  if not Assigned(AChavePublica) then
    raise Exception.Create('Chave pública não fornecida.');

  rsa       := nil;
  pubkey    := nil;
  outStream := nil;
  keyStream := nil;
  inStream  := nil;

  Try
    rsa := TRSAUtil.Create;

    keyStream := TStringStream.Create(AChavePublica.Text);
    pubkey    := TRSAPublicKey.Create;
    pubkey.LoadFromStream(keyStream);

    rsa.PublicKey := pubkey;

    inStream  := TStringStream.Create(AConteudo);
    outStream := TBytesStream.Create;
    rsa.PublicEncrypt(inStream, outStream);

    Result := EncodeBase64(outStream.Bytes, outStream.Size);
  Finally
    FreeAndNil(inStream);
    FreeAndNil(keyStream);
    FreeAndNil(outStream);
    FreeAndNil(pubkey);
    FreeAndNil(rsa);
  End;
end;

function TToken.Execute;
var
  LUnixTimestamp: WideString;
  LCriptografado: AnsiString;
begin
  LUnixTimestamp := IntToStr(fRetornaUnixTimestamp);
  LCriptografado := fCriptografa(FCnpjEmitente+'|'+ LUnixTimestamp, FChavePublica);

  Result := FCnpjEmitente+'|'+ LUnixTimestamp +'|'+ WideString(LCriptografado);

  Result := StringReplace( StringReplace(Result, #13, '', [rfReplaceAll]), #10, '', [rfReplaceAll]);
end;

end.
