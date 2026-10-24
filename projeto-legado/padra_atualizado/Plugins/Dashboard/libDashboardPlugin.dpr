library libDashboardPlugin;

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
  System.SysUtils,
  System.Classes,
  untInterfacePlugin in '..\..\fontes\Interfaces\untInterfacePlugin.pas',
  untFrameBase in 'fontes\untFrameBase.pas' {fraBaseFrame: TFrame},
  untComparativo in 'fontes\untComparativo.pas' {fraComparativo: TFrame},
  untDiasUteis in 'fontes\untDiasUteis.pas' {fraDiasUteis: TFrame},
  untDMPlugin in 'fontes\untDMPlugin.pas' {DMPlugin: TDataModule},
  untMetas in 'fontes\untMetas.pas' {fraMetas: TFrame},
  untFmxDashboard in 'fontes\untFmxDashboard.pas' {fmxDashboard},
  untPrzMed in 'fontes\untPrzMed.pas' {fraPrzMed: TFrame};

{$R *.res}

exports
  pMostraDashboard,
  pInicializaPlugin;

begin
end.
