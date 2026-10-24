unit untFatCalcularMargemService;

interface

uses
{$IFDEF LINUX}

{$ELSE}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, Faturamento.Margem.Interfaces.Servicos.Disponiveis;

function GetFaturamentoMargemService(): IFaturamentoMargemServicosDisponiveis;

implementation

var
  FaturamentoMargemBplHandle: THandle;

Const
{$IFDEF LINUX}
  FaturamentoMargemBpl = 'bplfaturamento.margem.servicos.so';
{$ELSE}
  FaturamentoMargemBpl = 'faturamento.margem.servicos.bpl';
{$ENDIF}

function GetFaturamentoMargemBpl: THandle;
begin
  If FaturamentoMargemBplHandle = 0 Then
    FaturamentoMargemBplHandle := LoadPackage(FaturamentoMargemBpl);
  Result := FaturamentoMargemBplHandle;
end;

function GetFaturamentoMargemProc(Const ANomeFuncao : String) : Pointer;
begin
  Result := GetProcAddress(GetFaturamentoMargemBpl, PChar(ANomeFuncao));

  If Result = Nil Then
    Raise Exception.CreateFmt('Não foi possível obter a função %s da biblioteca %s. ' +
      'Verifique se o arquivo existe e está atualizado na pasta do sistema. ' +
      'Operação cancelada!', [ANomeFuncao, FaturamentoMargemBpl]);
end;

function GetFaturamentoMargemService(): IFaturamentoMargemServicosDisponiveis;
Var
  LFaturamentoMargemService: function(): IFaturamentoMargemServicosDisponiveis; StdCall;
begin
  LFaturamentoMargemService := GetFaturamentoMargemProc('GetFaturamentoMargemService');
  Result := LFaturamentoMargemService;
end;

initialization

finalization
  If FaturamentoMargemBplHandle <> 0 Then
    UnloadPackage(FaturamentoMargemBplHandle);
end.
