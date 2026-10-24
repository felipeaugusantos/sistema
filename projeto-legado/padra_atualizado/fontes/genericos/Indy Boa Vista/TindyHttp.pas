unit TindyHttp;

interface

uses
  ShareMem,
  System.Classes,
  vcl.forms,
  System.SysUtils,
  System.StrUtils,
  Xml.XMLDoc,Xml.XMLIntf,
  Vcl.StdCtrls,System.Net.HttpClient,
  idHTTP, IdSSLOpenSSL,idComponent;

Type
  IndyHttp = class
  private
    FHTTP: TidHTTP;
    FProtocoloSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure CriarProtocoloSSL;
    function Post( AUrl : String; ABody: String; out ARetorno: String):Integer;
    procedure CriarComponenteRequisicao;
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
    constructor Create; overload;
    destructor Destroy; override;
  end;

  function Execute(const AMetodo, AUrl : String; ABody: String; out ARetorno: String): Integer; stdcall; export;

implementation

function Execute(const AMetodo, AUrl : String; ABody: String; out ARetorno: String): Integer; stdcall; export;
  Var
    LIndyHttp : IndyHttp;
begin
   Result := 0;

   Try
     LIndyHttp := IndyHttp.Create;

     If UpperCase(AMetodo).Equals('POST') Then
     Begin
       Result := LIndyHttp.Post(AUrl, ABody, ARetorno);
     End;

   Finally
     FreeAndNil(LIndyHttp);
   End;
end;



{ IndyHttp }

constructor IndyHttp.Create;
begin
  CriarProtocoloSSL;
  CriarComponenteRequisicao;
end;

procedure IndyHttp.CriarComponenteRequisicao;
begin
  FHTTP := TIdHTTP.Create(Nil);
  FHTTP.IOHandler := FProtocoloSSL;
  FHTTP.Request.Connection := 'keep-alive';
  FHTTP.Request.ContentType := 'application/xml';
  FHTTP.Response.KeepAlive := True;
  FHTTP.HTTPOptions := [];
  FHTTP.OnWork := OnWork;
  FHTTP.HandleRedirects := True;
end;

procedure IndyHttp.CriarProtocoloSSL;
begin
  FProtocoloSSL := TIdSSLIOHandlerSocketOpenSSL.Create(Nil);
  FProtocoloSSL.SSLOptions.Mode := sslmUnassigned;
  FProtocoloSSL.SSLOptions.Method := sslvTLSv1_2;
  FProtocoloSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
end;

destructor IndyHttp.Destroy;
begin
  FreeAndNil(FHTTP);
  FreeAndNil(FProtocoloSSL);
  inherited;
end;

procedure IndyHttp.OnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  Application.ProcessMessages;
end;

function IndyHttp.Post(AUrl : String; ABody: String; out ARetorno: String): Integer;
begin
  Try
    ARetorno := FHTTP.Post(AUrl, ABody);
    Result := FHTTP.ResponseCode;
  Except
    On E: Exception Do
    Begin
      ARetorno := Concat('Erro: ',E.Message);
      Result := FHTTP.ResponseCode;
    End;

    On E :EIdHTTPProtocolException Do
    Begin
      Result := FHTTP.ResponseCode;
      ARetorno := FHTTP.ResponseText;
    End;

  End;
end;

end.
