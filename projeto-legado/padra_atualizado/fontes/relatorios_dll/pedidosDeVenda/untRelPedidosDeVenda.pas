unit untRelPedidosDeVenda;

interface

Uses dxCore, SysUtils, TypesRel, System.Classes;


procedure prelpedidosdevenda(prmDllRel: Pointer);
function fSVN_RevisionRelPedVenda: String; stdcall;


implementation

uses untFuncoesFactory, untDllRelatorios, untIFuncoes, Vcl.Forms;

function fSVN_RevisionRelPedVenda: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelpedidosdevenda(prmDllRel: Pointer);
Var
  objDllRel : TParamDllRelPedidosDeVenda;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelPedidosDeVenda');

  End;
  pLiberaModulos;
End;


initialization
  dxInitialize;

finalization
  dxFinalize;

end.
