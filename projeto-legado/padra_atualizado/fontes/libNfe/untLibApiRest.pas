{untLibApiRest de {linNfe.dll}

unit untLibApiRest;

interface

uses untHttpTypes;

type
  TLibApiRest = class
  private
    fExecuteSoapWithMode: function(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer; stdcall;
    FlibApiRest: Cardinal;
    function fParseModeEnvSoap(AmodeEnvSoap: TmodeEnvSoap): TmodeEnvSoap;
  public
    constructor Create;
    destructor Destroy; override;
    function Execute(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol; AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno: WideString; out AException: WideString): Integer;
  End;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  Windows,
{$ENDIF}
  untInterfaces, untUtil, SysUtils;

{ TLibApiRest }

constructor TLibApiRest.Create;
  Var
    strMsg: String;
    resultValidacao: TResultadoValidacao;
begin
{$IFDEF LINUX}
  FlibApiRest := LoadLibrary(PChar('libapi.rest.so'));
{$ELSE}
  FlibApiRest := LoadLibrary(PChar('LibRest\api.rest.dll'));
{$ENDIF}

  If (FlibApiRest = 0) Then
  Begin
  {$IFDEF LINUX}
    strMsg := 'Biblioteca "libapi.rest.so" não encontrada!';
  {$ELSE}
    strMsg := 'Biblioteca "...LibRest\api.rest.dll" não encontrada!';
  {$ENDIF}
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End
  Else
  Begin
    Try
    {$IFDEF LINUX}
      pLogImp('LoadLibrary(libapi.rest.so) > '+IntToStr(FlibApiRest));
    {$ELSE}
      pLogImp('LoadLibrary(api.rest.dll) > '+IntToStr(FlibApiRest));
    {$ENDIF}
    Except
    End;
  End;

  @fExecuteSoapWithMode := GetProcAddress(FlibApiRest, PChar('ExecuteSoapWithMode'));

  If (Not Assigned(fExecuteSoapWithMode)) Then
  Begin
  {$IFDEF LINUX}
    strMsg := 'Biblioteca "libapi.rest.so" desatualizada sem a função ExecuteSoapWithMode!';
  {$ELSE}
    strMsg := 'Biblioteca "api.rest.dll" desatualizada sem a função ExecuteSoapWithMode!';
  {$ENDIF}
    resultValidacao := TResultadoValidacao.Create;
    resultValidacao.pAdicionarErro(strMsg, Nil);
    Raise ErrosValidacaoNFE.Create(strMsg, resultValidacao);
  End;
end;

destructor TLibApiRest.Destroy;
begin
  If (FlibApiRest <> 0) Then
  Begin
    FreeLibrary(FlibApiRest);
    Try
    {$IFDEF LINUX}
      pLogImp('FreeLibrary(libapi.rest.so) < '+IntToStr(FlibApiRest));
    {$ELSE}
      pLogImp('FreeLibrary(api.rest.dll) < '+IntToStr(FlibApiRest));
    {$ENDIF}
    Except
    End;
    FlibApiRest := 0;
  End;

  inherited;
end;

function TLibApiRest.fParseModeEnvSoap(AmodeEnvSoap: TmodeEnvSoap): TmodeEnvSoap;
begin
  Result := AmodeEnvSoap;
  If (Result In [modeOpAp]) Then
    Result := modeOpen;
end;

function TLibApiRest.Execute(AUrl: WideString; ordHTTPSecureProtocol: TordHTTPSecureProtocol;
  AmodeEnvSoap: TmodeEnvSoap; AEnvelopeEnvio: WideString; out AEnvelopeRetorno, AException: WideString): Integer;
begin
  Result := fExecuteSoapWithMode(AUrl, ordHTTPSecureProtocol, fParseModeEnvSoap(AmodeEnvSoap), AEnvelopeEnvio, AEnvelopeRetorno, AException);
end;

end.
