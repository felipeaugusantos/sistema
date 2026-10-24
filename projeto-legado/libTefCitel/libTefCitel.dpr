library libTefCitel;

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
  System.SysUtils,
  System.Classes,
  MidasLib,
  untInterfaceTefCitel in 'untInterfaceTefCitel.pas',
  untFuncoesLibTefCitel in 'untFuncoesLibTefCitel.pas',
  untTefCitel in 'untTefCitel.pas',
  untTefCitelNCR in 'untTefCitelNCR.pas',
  untTefCitelComum in 'untTefCitelComum.pas',
  untScopeNCR in 'untScopeNCR.pas',
  untTefCitelIntervalos in 'untTefCitelIntervalos.pas',
  untFormatarMensagemErro in 'untFormatarMensagemErro.pas',
  untTefCitelDvcTransporte in 'untTefCitelDvcTransporte.pas',
  untTefCitelDvc in 'untTefCitelDvc.pas',
  untTefCitelAtuComum in 'untTefCitelAtuComum.pas',
  untTefCitelDvcAtualizacao in 'untTefCitelDvcAtualizacao.pas',
  untTefCitelDvcUpdateTransporte in 'untTefCitelDvcUpdateTransporte.pas';

{$R *.res}

exports
  fCriarTefCitel,
  pSetConfirmaTomadaPinpadTef,
  fAtualizaEstacaoTefDll,
  pSetProgressoAtualizacaoTef,
  pSetThreadPrincipalHost;

begin
end.
