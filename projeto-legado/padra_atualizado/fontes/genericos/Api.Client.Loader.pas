unit Api.Client.Loader;

interface

uses
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  System.SyncObjs;

type
  TTokenCache = record
    Token: string;
    ExpiraEm: TDateTime;
  end;

type
  TGetTokenPrefixFunc = function(const APrefixoCliente: String;
                                 const AChavePublica: WideString;
                                 const AUnixTimestamp: Int64;
                                 const APathLibREST: String;
                                 Buffer: PChar;
                                 BufferSize: Integer): Integer; stdcall;

  TApiClientLoader = class
  private
    FDLLHandle: HMODULE;
    FGetTokenPrefix: TGetTokenPrefixFunc;

    class var FInstance: TApiClientLoader;
    class var FLock: TCriticalSection;

    function CarregarDLL: Boolean;
    function ResolverMetodos: Boolean;
    procedure DescarregarDLL;

    constructor CreatePrivate;

  public
    Cache : TTokenCache;
    destructor Destroy; override;

    class function GetInstance: TApiClientLoader;
    class procedure ReleaseInstance;

    function IsDLLCarregada: Boolean;

    function GetTokenPrefix(const APrefixoCliente: String;
                            const AChavePublica: String;
                            const AUnixTimestamp: Int64;
                            const APathLibREST: String): String;
  end;

implementation

{*********************}
{* SINGLETON CONTROL *}
{*********************}

class function TApiClientLoader.GetInstance: TApiClientLoader;
begin
  if not Assigned(FInstance) then
  begin
    FLock.Enter;
    try
      if not Assigned(FInstance) then
        FInstance := TApiClientLoader.CreatePrivate;
    finally
      FLock.Leave;
    end;
  end;

  Result := FInstance;
end;

class procedure TApiClientLoader.ReleaseInstance;
begin
  if not Assigned(FInstance) then
    Exit;

  FLock.Enter;
  try
    FreeAndNil(FInstance);
  finally
    FLock.Leave;
  end;
end;

{***************}
{* CONSTRUCTOR *}
{***************}

constructor TApiClientLoader.CreatePrivate;
begin
  inherited Create;

  FDLLHandle      := 0;
  FGetTokenPrefix := nil;

  Cache.Token    := '';
  Cache.ExpiraEm := 0;

  if not CarregarDLL then
    raise Exception.Create('Falha ao carregar a DLL LibREST.');

  if not ResolverMetodos then
    raise Exception.Create('Falha ao resolver métodos da DLL LibREST.');
end;

destructor TApiClientLoader.Destroy;
begin
  DescarregarDLL;

  inherited;
end;

{***************}
{* DLL CONTROL *}
{***************}

function TApiClientLoader.CarregarDLL: Boolean;
var
  DLLPath: string;
begin
  Result := False;

  DLLPath := ExtractFilePath(ParamStr(0)) + 'api.client.dll';

  FDLLHandle := LoadLibrary(PChar(DLLPath));

  if FDLLHandle = 0 then
    Exit;

  Result := True;
end;

procedure TApiClientLoader.DescarregarDLL;
begin
  if FDLLHandle <> 0 then
  begin
    FreeLibrary(FDLLHandle);
    FDLLHandle := 0;
  end;
end;

function TApiClientLoader.ResolverMetodos: Boolean;
begin
  Result := False;

  @FGetTokenPrefix := GetProcAddress(FDLLHandle, 'GetTokenPrefix');

  if not Assigned(FGetTokenPrefix) then
    Exit;

  Result := True;
end;

function TApiClientLoader.IsDLLCarregada: Boolean;
begin
  Result := (FDLLHandle <> 0) and Assigned(FGetTokenPrefix);
end;

{*************}
{* MAIN CALL *}
{*************}

function TApiClientLoader.GetTokenPrefix(const APrefixoCliente: String;
                                         const AChavePublica: String;
                                         const AUnixTimestamp: Int64;
                                         const APathLibREST: String): String;
Const
  TOKEN_VALIDADE_MINUTOS = 10;
var
  Buffer: array[0..2047] of WideChar;
  Retorno: Integer;
begin
  if not Assigned(FGetTokenPrefix) then
    raise Exception.Create('Método GetTokenPrefix não carregado.');

  ZeroMemory(@Buffer, SizeOf(Buffer));

  FLock.Enter;
  try
    Retorno := FGetTokenPrefix(
                 APrefixoCliente,
                 AChavePublica,
                 AUnixTimestamp,
                 APathLibREST,
                 @Buffer,
                 Length(Buffer));
  finally
    FLock.Leave;
  end;

  if Retorno <= 0 then
    raise Exception.Create('Erro ao gerar token na DLL.');

  SetString(Result, Buffer, Retorno);

  Cache.Token := Result;
  Cache.ExpiraEm := Now + (TOKEN_VALIDADE_MINUTOS / (24*60));
end;

{******************}
{* INITIALIZATION *}
{******************}

initialization
  TApiClientLoader.FLock := TCriticalSection.Create;

finalization
  TApiClientLoader.ReleaseInstance;
  TApiClientLoader.FLock.Free;

end.

