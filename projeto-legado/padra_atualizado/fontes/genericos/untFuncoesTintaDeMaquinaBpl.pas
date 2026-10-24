unit untFuncoesTintaDeMaquinaBpl;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms,
  Windows,
{$ENDIF}
  System.SysUtils,
  untTipoTinta,
  Shared.Functions.Configuracoes;

  Var
    fTipoTinta: function(strIdePro: String): TTipoTinta; stdcall;

  function RetornarAutcomTintaDll : THandle;

  function fGetTintaImobiliaria(Const strIdePro : String) : Boolean;
  function fGetTintaAutomotiva(Const strIdePro : String)  : Boolean;
  function fGetTintaIndustrial(Const strIdePro : String)  : Boolean;

implementation

uses
  untConstantes;

function RetornarAutcomTintaDll : THandle;
begin
  Result := 0;

  If (objConfiguracoes.fGetValorConfiguracao(CFG_USA_TINTA_DE_MAQUINA,varString) <> 'S') Then
  begin
    Exit;
  end;

  Result := LoadLibrary(PChar(ExtractFilePath(Application.ExeName) + DLL_TINTA_PATH));

  fTipoTinta := GetProcAddress(Result, PChar('fTipoTinta'));
end;

function fGetTintaImobiliaria(Const strIdePro : String) : Boolean;
begin
  result := (fTipoTinta(strIdePro) = ttImobiliaria);
end;

function fGetTintaAutomotiva(Const strIdePro : String)  : Boolean;
begin
  result := (fTipoTinta(strIdePro) = ttAutomotiva);
end;

function fGetTintaIndustrial(Const strIdePro : String)  : Boolean;
begin
  result := (fTipoTinta(strIdePro) = ttIndustrial);
end;



end.
