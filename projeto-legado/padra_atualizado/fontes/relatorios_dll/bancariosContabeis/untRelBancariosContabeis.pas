unit untRelBancariosContabeis;

interface

Uses Forms, dxCore, SysUtils, StrUtils;

procedure prelbancarioscontabeis(prmDllRel: Pointer);
function fSVN_RevisionRelBancarios: String; stdcall;

implementation

uses untFuncoesFactory,   TypesRel, untDllRelatorios, untIFuncoes,
  System.Classes, untConstantes;

function fSVN_RevisionRelBancarios: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelbancarioscontabeis(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelBancariosContabeis;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH,'libRelBancariosContabeis');
    
  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

End.


