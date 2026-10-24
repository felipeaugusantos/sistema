unit untDllLayoutsFR3Funcoes;

interface

uses
  untQckOrdProIndustrial, OrdemProducaoIndustrial.Tipos;

function fExisteAjuda(strNomFor, strNomRel: String):Boolean;
procedure pExibirAjudaGmail;
procedure pExibirAjudaOutlook;
procedure pExibirAjudaRegistroCSGetnet;
procedure pExibirAjuda(strNomFor, strNomRel: String);
procedure pExibirModeloLayoutConfigurado(strCodCfg: String; strValCfg: String = '');
procedure pCarregarLayoutsOrdemProducaoIndustrial(AQckOrdProIndustrial: TfrmQckOrdProIndustrial);

implementation

uses
  untTypesSistema, untDllLayoutsFR3, Classes, Forms, SysUtils, Uni, Windows, untFuncoesSimples, untModulo;

const
  IMP_EXT_DLL = 'libLayoutsFR3.dll';

function fVerificaHelpExiste(strNomFor, strNomRel: String):Boolean; stdcall; External IMP_EXT_DLL delayed;
procedure pAjudaGmail; stdcall; External IMP_EXT_DLL delayed;
procedure pAjudaOutlook; stdcall; External IMP_EXT_DLL delayed;
procedure pAjudaRegistroCSGetnet; stdcall; External IMP_EXT_DLL delayed;
procedure pAbreAjuda(strNomFor, strNomRel: String); stdcall; External IMP_EXT_DLL delayed;
procedure pLayoutsFR3Init(AParams: Pointer); stdcall; External IMP_EXT_DLL delayed;
procedure pExibirModeloLayoutCfgSis(strCodCfg: String; strValCfg: String = ''); stdcall; External IMP_EXT_DLL delayed;
procedure pCarregarQckOrdProIndustrialLayouts(AQckOrdProIndustrial: TfrmQckOrdProIndustrial); stdcall; External IMP_EXT_DLL delayed;

{$WARN SYMBOL_PLATFORM OFF}
procedure pCarregarDllLayoutsFR3;
var
  LParams: TParamLayoutsFR3;
begin
  try
    LParams := TParamLayoutsFR3.Create;
    try
      LParams.intDebugH := DebugHook;
      pIniVariaveis(LParams.VarRecVar);
      pIniModulos(LParams.ModRecMod);
      pLayoutsFR3Init(LParams);
    finally
      FreeAndNil(LParams);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, 'DLL ' + IMP_EXT_DLL);
  end;
end;
{$WARN SYMBOL_PLATFORM ON}

procedure pExibirModeloLayoutConfigurado(strCodCfg: String; strValCfg: String = '');
begin
  pCarregarDllLayoutsFR3;
  pExibirModeloLayoutCfgSis(strCodCfg, strValCfg);
end;

procedure pCarregarLayoutsOrdemProducaoIndustrial(AQckOrdProIndustrial: TfrmQckOrdProIndustrial);
begin
  pCarregarDllLayoutsFR3;
  pCarregarQckOrdProIndustrialLayouts(AQckOrdProIndustrial);
end;

function fExisteAjuda(strNomFor, strNomRel: String):Boolean;
begin
  pCarregarDllLayoutsFR3;
  Result := fVerificaHelpExiste(strNomFor, strNomRel);
end;

procedure pExibirAjudaGmail;
begin
  pCarregarDllLayoutsFR3;
  pAjudaGmail;
end;

procedure pExibirAjudaOutlook;
begin
  pCarregarDllLayoutsFR3;
  pAjudaOutlook;
end;

procedure pExibirAjudaRegistroCSGetnet;
begin
  pCarregarDllLayoutsFR3;
  pAjudaRegistroCSGetnet;
end;

procedure pExibirAjuda(strNomFor, strNomRel: String);
begin
  pCarregarDllLayoutsFR3;
  pAbreAjuda(strNomFor, strNomRel);
end;

end.
