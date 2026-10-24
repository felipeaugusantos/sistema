unit untFatCalcularPrecosService;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Winapi.Windows,
  Vcl.Forms,
  Dialogs,
{$ENDIF}
  System.SysUtils,
  untFatCalcularServicePath,
  Faturamento.Precos.Interfaces.Servicos.Disponiveis;

  function GetFaturamentoPrecosService(Const ADirectory : String): IFaturamentoPrecosServicosDisponiveis;

implementation

var
  FaturamentoPrecosBplHandle: THandle;

Const
{$IFDEF LINUX}
  FaturamentoPrecosBpl = 'bplfaturamento.precos.servicos.so';
{$ELSE}
  FaturamentoPrecosBpl = 'faturamento.precos.servicos.bpl';
{$ENDIF}

function GetFaturamentoPrecosBpl(Const ADirectory : String): THandle;
var
  LPath   : String;
  LPathExe: String;
begin
  If FaturamentoPrecosBplHandle = 0 Then
  Begin
    LPathExe := ADirectory; //ExtractFilePath(Application.ExeName);

    TFatCalcularServicePath.LoadPackagesFromAuttin(LPathExe);

    LPath := TFatCalcularServicePath.GetPathFromAuttin(LPathExe);

    FaturamentoPrecosBplHandle := LoadPackage(PChar(LPath + FaturamentoPrecosBpl));
  End;
  Result := FaturamentoPrecosBplHandle;
end;

function GetFaturamentoPrecosProc(Const ADirectory, ANomeFuncao : String) : Pointer;
begin
  Result := GetProcAddress(GetFaturamentoPrecosBpl(ADirectory), PChar(ANomeFuncao));

  If Result = Nil Then
    Raise Exception.CreateFmt('Não foi possível obter a função %s da biblioteca %s. ' +
      'Verifique se o arquivo existe e está atualizado na pasta do sistema. ' +
      'Operação cancelada!', [ANomeFuncao, FaturamentoPrecosBpl]);
end;

function GetFaturamentoPrecosService(Const ADirectory : String): IFaturamentoPrecosServicosDisponiveis;
Var
  LFaturamentoPrecosService: function(): IFaturamentoPrecosServicosDisponiveis; StdCall;
begin
  LFaturamentoPrecosService := GetFaturamentoPrecosProc(ADirectory, 'GetFaturamentoPrecosService');
  Result := LFaturamentoPrecosService;
End;

initialization

finalization
  If FaturamentoPrecosBplHandle <> 0 Then
    UnloadPackage(FaturamentoPrecosBplHandle);
end.
