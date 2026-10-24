library libCorreios;

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
  Uni,
  Correios.Types in '..\padra_atualizado\fontes\FuncoesCentralizadas\Correios.Types.pas',
  Correios.Interfaces in '..\padra_atualizado\fontes\FuncoesCentralizadas\Correios.Interfaces.pas',
  Correios.Classes in 'fontes\Correios.Classes.pas',
  Correios.Constantes in 'fontes\Correios.Constantes.pas',
  Correios.Controller in 'fontes\Correios.Controller.pas',
  Correios.Funcoes in 'fontes\Correios.Funcoes.pas',
  Correios.Main in 'fontes\Correios.Main.pas',
  Correios.Rest in 'fontes\Correios.Rest.pas';

{$R *.res}

function GetCorreioClass(const ACodEmp: WideString; var AQuery: TUniQuery): ICorreios; stdcall; export;
begin
  VS_strCodEmp := ACodEmp;
  VS_qryAux    := AQuery;

  PreencheVariaveisGlobais;

  Result := TCorreiosAPI.Create;
end;

exports
  GetCorreioClass;

begin
end.
