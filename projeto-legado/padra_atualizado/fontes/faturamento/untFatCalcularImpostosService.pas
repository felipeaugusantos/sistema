unit untFatCalcularImpostosService;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Winapi.Windows,
{$ENDIF}
 System.SysUtils, Faturamento.Impostos.Interfaces.Servicos.Disponiveis;

  function GetFaturamentoImpostosService(): IFaturamentoImpostosServicosDisponiveis;

implementation

var
  FaturamentoImpostosBplHandle: THandle;

const
{$IFDEF LINUX}
  FaturamentoImpostosBpl = 'bplfaturamento.impostos.servicos.so';
{$ELSE}
  FaturamentoImpostosBpl = 'faturamento.impostos.servicos.bpl';
{$ENDIF}

function GetFaturamentoImpostosBpl: THandle;
begin
  If FaturamentoImpostosBplHandle = 0 Then
    FaturamentoImpostosBplHandle := LoadPackage(FaturamentoImpostosBpl);
  Result := FaturamentoImpostosBplHandle;
end;

function GetFaturamentoImpostosProc(Const ANomeFuncao : String) : Pointer;
begin
  Result := GetProcAddress(GetFaturamentoImpostosBpl, PChar(ANomeFuncao));

  If Result = Nil Then
    Raise Exception.CreateFmt('Não foi possível obter a função %s da biblioteca %s. ' +
      'Verifique se o arquivo existe e está atualizado na pasta do sistema. ' +
      'Operação cancelada!', [ANomeFuncao, FaturamentoImpostosBpl]);
end;

function GetFaturamentoImpostosService(): IFaturamentoImpostosServicosDisponiveis;
Var
  LFaturamentoImpostosService: function(): IFaturamentoImpostosServicosDisponiveis; StdCall;
begin
  LFaturamentoImpostosService := GetFaturamentoImpostosProc('GetFaturamentoImpostosService');
  Result := LFaturamentoImpostosService;
end;

initialization

finalization
  If FaturamentoImpostosBplHandle <> 0 Then
    UnloadPackage(FaturamentoImpostosBplHandle);

end.
