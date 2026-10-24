{*****************************************************************************************}
{* Classe responsável pelo encapsulamento de uma dll em um objeto, com isso é mais facil *}
{* trabalar com uma dll de tinta                                                         *}
{**************************************************************************************PH*}
unit untLibTintaDllWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Windows,
{$ENDIF}
  untLibTintas, untILibTinta, SysUtils, untIAutcomTintaWrapper,
  System.Generics.Collections;

type
  TpInicializaDevExpress = procedure;
  TpFinalizaDevExpres = procedure;

  TLibTintaDllWrapper = class(TInterfacedObject)
  private
    strNomeArquivoDll: string;
    handleDll: THandle;
    fGetTintadeMaquina: TGetTintadeMaquina;
    libTinta: ILibTinta;
    autcomTintaWrapper: IAutcomTintaWrapper;
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    class var dicDll: TDictionary<String, THandle>;
    procedure LoadDll;
    function GetIdePro: string;
  public
    constructor Create(const strNomeArquivoDll: string; const autcomTintaWrapper: IAutcomTintaWrapper);
    destructor Destroy; override;
    function GetTintadeMaquina(): ILibTinta;
    property IdePro: string read GetIdePro;
  end;

implementation

{ TLibTintaDllWrapper }

constructor TLibTintaDllWrapper.Create(const strNomeArquivoDll: string; const autcomTintaWrapper: IAutcomTintaWrapper);
begin
  inherited Create();
  Self.strNomeArquivoDll := strNomeArquivoDll;
  Self.libTinta := nil;
  Self.autcomTintaWrapper := autcomTintaWrapper;
end;

destructor TLibTintaDllWrapper.Destroy;
Var
  pFiniDX: TpFinalizaDevExpres;
begin
  libTinta := nil;
  fGetTintadeMaquina := nil;

  @pFiniDX := GetProcAddress(handleDll, 'dxFinalize');

  if @pFiniDX <> nil then
    pFiniDX;

  if handleDll <> 0 then
    FreeLibrary(handleDll);


  inherited;
end;

function TLibTintaDllWrapper.GetIdePro: string;
begin
  Result := GetTintadeMaquina().IdePro;
end;

function TLibTintaDllWrapper.GetTintadeMaquina(): ILibTinta;
begin
  if libTinta = nil then
  begin
    pDebugViaEventLog('[AutcomTinta][GetTintadeMaquina] Solicitada: ' + ExtractFileName(strNomeArquivoDll));

    if @fGetTintadeMaquina = nil then
      LoadDll;

    if @fGetTintadeMaquina <> nil then
    begin
      libTinta := fGetTintadeMaquina(autcomTintaWrapper);
      pDebugViaEventLog('[AutcomTinta][GetTintadeMaquina] ILibTinta Instânciada: ' + ExtractFileName(strNomeArquivoDll));
    end;
  end;
  Result := libTinta;
end;

procedure TLibTintaDllWrapper.LoadDll;
var
  pIniDX: TpInicializaDevExpress;
begin
  FMREW.BeginWrite;
  try
    If Not dicDll.ContainsKey(strNomeArquivoDll) Then
    Begin
      pDebugViaEventLog('[AutcomTinta][LoadDll] >>> LoadLibrary: ' + ExtractFileName(strNomeArquivoDll));

      handleDll := LoadLibrary(PWideChar(strNomeArquivoDll));

      if handleDll <> 0 then
      begin
        @pIniDX := GetProcAddress(handleDll, 'dxInitialize');
        if @pIniDX <> nil then
          pIniDX;
      end
      else
        pDebugViaEventLog('[AutcomTinta][LoadDll] LoadLibrary falhou: ' + strNomeArquivoDll);

      dicDll.AddOrSetValue(strNomeArquivoDll, handleDll);
    End;

    handleDll := dicDll[strNomeArquivoDll];

   {$IFDEF LINUX}
    fGetTintadeMaquina := GetProcAddress(handleDll, PWideChar('GetTintadeMaquina'));
   {$ELSE}
    fGetTintadeMaquina := GetProcAddress(handleDll, PAnsiChar('GetTintadeMaquina'));
   {$ENDIF}

    if @fGetTintadeMaquina = nil then
      pDebugViaEventLog('[AutcomTinta][LoadDll] !!! GetProcAddress Falhou: ' + ExtractFileName(strNomeArquivoDll));
  finally
    FMREW.EndWrite;
  end;
end;

initialization
  TLibTintaDllWrapper.dicDll := TDictionary<String, THandle>.Create;
  TLibTintaDllWrapper.FMREW  := TMultiReadExclusiveWriteSynchronizer.Create;
finalization
  FreeAndNil(TLibTintaDllWrapper.dicDll);
  FreeAndNil(TLibTintaDllWrapper.FMREW);
end.
