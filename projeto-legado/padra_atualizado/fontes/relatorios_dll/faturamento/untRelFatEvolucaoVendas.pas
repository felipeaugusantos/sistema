unit untRelFatEvolucaoVendas;

interface

Uses Forms, dxCore, SysUtils, StrUtils;

procedure prelfatevolucaovendas(prmDllRel: Pointer);
function fSVN_RevisionRelFatEvolVendas: String; stdcall;

implementation

uses TypesRel, untDllRelatorios, untFuncoesFactory,
    untIFuncoes;

function fSVN_RevisionRelFatEvolVendas: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelfatevolucaovendas(prmDllRel: Pointer);
Var
  objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFatEvolucaoVendas');

    Case relTipRel of
      //relFatEvolVendasGrafico     : pCriarForm(TfrmRelFatEvolVendasGrafico, frmRelFatEvolVendasGrafico);
    End;

  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
