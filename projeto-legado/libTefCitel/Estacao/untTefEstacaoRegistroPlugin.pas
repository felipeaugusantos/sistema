unit untTefEstacaoRegistroPlugin;

{ Req. 456190 - registro do plug-in de canal DVC no HKCU de quem esta logado.

  Serve ao switch /registraplugin do TefEstacaoService.exe, que e a acao da
  tarefa agendada "CitelTefRegistraPlugin" criada pelo instalador da estacao.

  QUEM COBRE O QUE

  O instalador grava direto no hive do usuario da sessao interativa, e isso
  resolve UMA pessoa - a que estava logada na hora. Esta unidade cobre todo o
  resto: o operador do outro turno, quem teve o perfil recriado, quem entrar
  amanha. A tarefa dispara no logon de cada um e roda COMO ele, entao o HKCU
  e sempre o certo - inclusive quando o instalador foi elevado por outra
  conta.

  POR QUE ISTO VIVE DENTRO DO EXE DO SERVICO

  A tarefa roda na sessao interativa. Acao de console (.cmd, reg.exe) faz o
  Windows abrir uma janela, e o caixa veria um lampejo a cada logon. O
  TefEstacaoService.exe e subsistema GUI e nao abre console nenhum. Nao ha
  binario novo: ele ja esta na pasta da estacao e ja esta na exclusao do
  Defender - o que importa num requisito com o C.7 em aberto.

  SEM LOG EM ARQUIVO, DE PROPOSITO

  Isto roda como usuario COMUM. A pasta da estacao nasce com Users apenas em
  leitura/execucao, entao tentar gravar log ali falharia em toda execucao e
  so geraria ruido. O canal de diagnostico e o CODIGO DE SAIDA, que o
  Agendador de Tarefas guarda em LastTaskResult:

    0  registrado
    2  TefCitelDvcPlugin.dll nao esta na pasta - instalacao incompleta
    3  nao foi possivel gravar no HKCU

  O canal de volume (TefCitelUpd) e OPCIONAL nas duas pontas: DLL ausente
  nao e erro, so faz a estacao atualizar pelo caminho lento (RF45). }

interface

{ O switch pedido na linha de comando? Mora aqui, e nao no .dpr, para o
  nome ficar num lugar so - e para o .dpr nao precisar de System.SysUtils
  so por causa do FindCmdLineSwitch. }
function fPediuRegistrarPlugin: Boolean;

{ Devolve o codigo de saida - ver a tabela acima. }
function fRegistraPluginDoUsuario: Integer;

implementation

uses
  Winapi.Windows, System.SysUtils, System.Win.Registry,
  untTefCitelAtuComum;

const
  TEF_SWITCH_REGISTRA = 'registraplugin';

function fPediuRegistrarPlugin: Boolean;
begin
  Result := FindCmdLineSwitch(TEF_SWITCH_REGISTRA, ['/', '-'], True);
end;

function fGravaCanal(const AstrCanal, AstrCaminhoDll: String): Boolean;
var
  LobjRegistro: TRegistry;
begin
  Result := False;

  { Exatamente o que o DllRegisterServer do plug-in faz: UM valor de string,
    e mais nada. Sem CLSID, sem type library - por isso o instalador tambem
    dispensa o regsvr32. }
  LobjRegistro := TRegistry.Create(KEY_WRITE);
  try
    LobjRegistro.RootKey := HKEY_CURRENT_USER;
    if LobjRegistro.OpenKey(TEF_ATU_CHAVE_ADDIN + '\' + AstrCanal, True) then
    try
      LobjRegistro.WriteString('Name', AstrCaminhoDll);
      Result := True;
    finally
      LobjRegistro.CloseKey;
    end;
  finally
    LobjRegistro.Free;
  end;
end;

function fRegistraPluginDoUsuario: Integer;
var
  LstrDir, LstrDll: String;
begin
  { A pasta e a do proprio executavel, nunca um caminho fixo: a instalacao
    pode nao estar em C:\Tef_Citel, e a tarefa nao tem como saber disso de
    outro jeito. }
  LstrDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  LstrDll := LstrDir + TEF_ATU_DLL_PLUGIN;
  if not FileExists(LstrDll) then
    Exit(2);

  if not fGravaCanal(TEF_ATU_CANAL_TEF, LstrDll) then
    Exit(3);

  { Opcional: ausencia nao e erro. }
  LstrDll := LstrDir + TEF_ATU_DLL_PLUGIN_UPD;
  if FileExists(LstrDll) then
    fGravaCanal(String(TEF_UPD_CANAL), LstrDll);

  Result := 0;
end;

end.
