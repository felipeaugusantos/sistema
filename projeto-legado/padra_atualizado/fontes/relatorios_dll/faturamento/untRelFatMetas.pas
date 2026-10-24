unit untRelFatMetas;

interface

Uses Forms, dxCore, SysUtils, StrUtils, Classes;

procedure prelfatmetas(prmDllRel: Pointer);
function fSVN_RevisionRelFatMetas: String; stdcall;

implementation

uses TypesRel, untDllRelatorios, untFuncoesFactory, untIFuncoes;

function fSVN_RevisionRelFatMetas: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelfatmetas(prmDllRel: Pointer);
Var
  objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFatMetas');



  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
