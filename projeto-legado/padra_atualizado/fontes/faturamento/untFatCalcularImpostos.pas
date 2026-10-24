unit untFatCalcularImpostos;

interface

uses
  Rest.Json, Winapi.Windows, System.SysUtils, Forms, Classes;

implementation

var
  FaturamentoImpostosBplHandle: THandle;

Const
  FaturamentoImpostosBpl = 'faturamento.impostos.calculos.bpl';

initialization

finalization
  If FaturamentoImpostosBplHandle <> 0 Then
    UnloadPackage(FaturamentoImpostosBplHandle);

end.
