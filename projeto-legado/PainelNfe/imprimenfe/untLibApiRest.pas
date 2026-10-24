{untLibApiRest de NFeImpressao.exe}

unit untLibApiRest;

interface

uses untHttpTypes;

type
  TLibApiRest = class
  private
    fExecuteSoapWithMode: function(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall;
    FlibApiRest: Cardinal;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer;
  End;

implementation

uses
{$IF Defined(LINUX)}
{$ELSE}
  Windows,
{$IFEND}
  untUtil, SysUtils;

{ TLibApiRest }

constructor TLibApiRest.Create;
Var
  strMsg: String;
begin
  FlibApiRest := LoadLibrary(PChar('LibRest\api.rest.dll'));

  If (FlibApiRest = 0) Then
  Begin
    strMsg := 'Biblioteca "...LibRest\api.rest.dll" não encontrada!';
    Raise Exception.Create(strMsg);
  End
  Else
  Begin
    Try
      pLogImp('LoadLibrary(api.rest.dll) > '+IntToStr(FlibApiRest));
    Except
    End;
  End;

  @fExecuteSoapWithMode := GetProcAddress(FlibApiRest, PChar('ExecuteSoapWithMode'));

  If (Not Assigned(fExecuteSoapWithMode)) Then
  Begin
    Raise Exception.Create('Biblioteca "api.rest.dll" desatualizada sem a função ExecuteSoapWithMode!');
  End;
end;

destructor TLibApiRest.Destroy;
begin
  If (FlibApiRest <> 0) Then
  Begin
    FreeLibrary(FlibApiRest);
    Try
      pLogImp('FreeLibrary(api.rest.dll) < '+IntToStr(FlibApiRest));
    Except
    End;
    FlibApiRest := 0;
  End;

  inherited;
end;

function TLibApiRest.Execute(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol;
  AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno, AException: WideString): Integer;
begin
  Result := fExecuteSoapWithMode(AUrl, ordHTTPSecureProtocol, AmodeEnvSoap, AEnvelopeEnvio, AEnvelopeRetorno, AException);
end;

end.
