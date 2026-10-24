program EnviaComissaoProfissional;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Services.Core.Cache in '..\..\..\Core\Services.Core.Cache.pas',
  Services.Core.Connection.Interfaces in '..\..\..\Core\Services.Core.Connection.Interfaces.pas',
  Services.Core.Connection.Manager in '..\..\..\Core\Services.Core.Connection.Manager.pas',
  Services.Core.Connection.UniDac in '..\..\..\Core\Services.Core.Connection.UniDac.pas',
  Services.Core.Settings in '..\..\..\Core\Services.Core.Settings.pas',
  Services.Core.Task.Lock in '..\..\..\Core\Services.Core.Task.Lock.pas',
  Services.Core.Task.Monitor in '..\..\..\Core\Services.Core.Task.Monitor.pas',
  Services.Core.Types in '..\..\..\Core\Services.Core.Types.pas',
  Services.Core.Utils in '..\..\..\Core\Services.Core.Utils.pas',
  Services.Core.Rest in '..\..\..\Core\Services.Core.Rest.pas',
  Services.Comissao.Profissional in '..\..\Source\Services.Comissao.Profissional.pas',
  untRestApi in '..\..\..\..\fontes\faturamento\untRestApi.pas',
  untTypesSistema in '..\..\..\..\fontes\genericos\untTypesSistema.pas',
  untFuncoesDicionarios in '..\..\..\..\fontes\genericos\untFuncoesDicionarios.pas',
  untHorarioSistema in '..\..\..\..\fontes\genericos\untHorarioSistema.pas',
  untComissaoProfissionalRestApi in '..\..\Source\untComissaoProfissionalRestApi.pas',
  untComissaoProfissional in '..\..\Source\untComissaoProfissional.pas',
  untComissaoProfissionalAutenticacaoRestApi in '..\..\Source\untComissaoProfissionalAutenticacaoRestApi.pas';

begin
  FormatSettings_ptBR;
  pSetUsuarioConexaoAutcomCitel;

  While True do
  Begin
    try
      Writeln(DateTimeToStr(fNow) + ' - ' + 'Iniciando Comissão Profissional ...');

      If Not fProcessarComissaoProfissional Then
        Sleep(60000);

      Writeln(DateTimeToStr(fNow) + ' - ' + 'Finalizando Comissão Profissional ...');
    except
      on E: Exception do
        Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
    end;
    Sleep(10000);
  End;

end.
