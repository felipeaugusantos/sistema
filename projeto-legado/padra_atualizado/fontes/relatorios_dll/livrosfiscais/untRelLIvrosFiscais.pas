unit untRelLIvrosFiscais;

interface

Uses
  Forms,
  dxCore,
  SysUtils,
  TypesRel,
  untDllRelatorios,
  untTypesSistema;

procedure prellivrosfiscais(prmDllRel: Pointer);
function fSVN_RevisionRelFiscais: String; stdcall;

implementation

uses untFuncoesFactory,
  untIFuncoes;

function fSVN_RevisionRelFiscais: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prellivrosfiscais(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelLivrosFiscais;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelLivrosFiscais');
    
    Case relTipRel of
      relFiscControleEstoqueCat1799 : pCriarForm(TfrmControleEstoqueCat17, frmControleEstoqueCat17);
    End;

  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
