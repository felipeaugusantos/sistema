unit untExecuteSoapWithMode;

interface

uses untHttpTypes;

function fExecuteSoapWithMode(const AUrl: WideString;
                              const ordHTTPSecureProtocol: TordHTTPSecureProtocol;
                              const AmodeEnvSoap: TmodeEnvSoap;
                              const AEnvelopeEnvio: WideString;
                              out AEnvelopeRetorno: WideString;
                              out AException: WideString): Integer;

function fUsaOpenSSLOnLibNfe(const AmodeEnvSoap: TmodeEnvSoap): Boolean;

implementation

uses {$IF RTLVersion >= 28}
     untIndyHttpConnect,
     {$IFEND}
     untLibApiRest, StrUtils, SysUtils;

function fExecuteSoapWithMode(const AUrl: WideString;
                              const ordHTTPSecureProtocol: TordHTTPSecureProtocol;
                              const AmodeEnvSoap: TmodeEnvSoap;
                              const AEnvelopeEnvio: WideString;
                              out AEnvelopeRetorno: WideString;
                              out AException: WideString): Integer;
  var
    {$IF RTLVersion >= 28}
    objIndyHttpConnect: TIndyHttpConnect;
    {$IFEND}
    objLibApiRest: TLibApiRest;
begin
  {$IF RTLVersion >= 28}
  If fUsaOpenSSLOnLibNfe(AmodeEnvSoap) Then
  Begin
    objIndyHttpConnect := TIndyHttpConnect.Create(AUrl, ordHTTPSecureProtocol);
    Try
      Try
        objIndyHttpConnect.Execute(AEnvelopeEnvio);
        AEnvelopeRetorno := objIndyHttpConnect.Response;
        Result := objIndyHttpConnect.StatusCode;
      Except
        On E: Exception Do
        Begin
          Result := 0;
          AException := E.Message;
        End;
      End;
    Finally
      FreeAndNil(objIndyHttpConnect);
    End;
  End
  Else
  {$IFEND}
  Begin
    objLibApiRest := TLibApiRest.Create;
    Try
      Result := objLibApiRest.Execute(AUrl, ordHTTPSecureProtocol, AmodeEnvSoap, AEnvelopeEnvio, AEnvelopeRetorno, AException);
    Finally
      FreeAndNil(objLibApiRest);
    End;
  End;
end;

function fUsaOpenSSLOnLibNfe(const AmodeEnvSoap: TmodeEnvSoap): Boolean;
begin
  Result := True;

  If (AmodeEnvSoap = modeOpen) Then
    Exit;

  If (AmodeEnvSoap = modeNull) Then
    Exit;

  Result := False;
end;

end.
