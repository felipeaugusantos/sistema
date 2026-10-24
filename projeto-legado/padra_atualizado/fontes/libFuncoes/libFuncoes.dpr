library libFuncoes;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  MidasLib,
  SysUtils,
  Classes,
  RlConsts,
  Windows,
  {$IFDEF TIMERLOG}
  untTimerLog in '..\genericos\untTimerLog.pas',
  {$ENDIF }
  untIConfTinta in '..\Interfaces\untIConfTinta.pas',
  untFuncoesGen in 'untFuncoesGen.pas',
  untFuncoesCXGrid in 'untFuncoesCXGrid.pas',
  untMensagem in 'untMensagem.pas' {frmMensagem},
  untConstantes in '..\genericos\untConstantes.pas',
  untStyleHookFix in '..\genericos\untStyleHookFix.pas',
  untClassPanelCx in 'untClassPanelCx.pas',
  untConfiguraConsultaEdicao in 'untConfiguraConsultaEdicao.pas' {frmConfiguraConsultaEdicao},
  untConsultaCxGridNova in 'untConsultaCxGridNova.pas' {frmConsultaCxGridNova},
  untConfiguraConsulta in 'untConfiguraConsulta.pas',
  untPesquisa in 'untPesquisa.pas',
  untTypesSistema in '..\genericos\untTypesSistema.pas',
  untGravando in '..\genericos\untGravando.pas' {frmGravando},
  untGenericProcedureFormGravando in '..\genericos\untGenericProcedureFormGravando.pas',
  untIFuncoesCXGrid in 'untIFuncoesCXGrid.pas',
  untInterfacedObjectNoCount in '..\FuncoesCentralizadas\untInterfacedObjectNoCount.pas',
  untICfgSis in '..\Interfaces\untICfgSis.pas',
  untModuloReplicacaoLibFuncoes in 'untModuloReplicacaoLibFuncoes.pas' {frmModuloReplicacaoLibFuncoes: TDataModule},
  untFuncoesGenCompartilhada in '..\genericos\untFuncoesGenCompartilhada.pas',
  untFuncoesCitelGrid in 'untFuncoesCitelGrid.pas',
  untIFuncoesCitelGrid in 'untIFuncoesCitelGrid.pas',
  untHorarioSistema in '..\genericos\untHorarioSistema.pas',
  TypesLayoutPedidoCompra in '..\genericos\TypesLayoutPedidoCompra.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
Exports
  pIniciaDllFuncoes,
  pReassignConexaoLibFuncoes,
  pCriarFormularios,
  pFreeAndNil,
  pRetornaPrecos,
  pSetaClient,
  fCriaQuery,
  fCriarQuery,
  fConsulta,
  fEmptyStr,
  fStrZero,
  fFormataFloat,
  fStrToFloat,
  fMensagem,
  fRetAutoIncrem,
  fFormataAutInc,
  fProdutoCadastrado,
  fComponentByName,
  fPadL,
  fPadC,
  fPadR,
  fMskDigitos,
  fRetEmpresaFisica,
  fExecutaSQL,
  fGetFuncoesCxGrid,
  dxInitializeFuncoes,
  dxFinalizeFuncoes,
  fSVN_RevisionFuncoes,
  pSetForegroundWindowsConsulta,
  fGetFuncoesCitelGrid;

begin
  RlConsts.SetVersion(3,71,'B');
end.
