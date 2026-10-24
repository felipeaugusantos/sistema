unit untRelCadastros;

interface

Uses
  dxCore, SysUtils, Menus, TypesRel, untDllRelatorios, untIFuncoes, vcl.Forms, System.Classes;

procedure prelcadastro(prmDllRel: Pointer);
function fSVN_RevisionRelCadastro: String; stdcall;

implementation

uses  {
       untRelContratoAberturaCredito,
       untRelCadDireitosDeAcesso,
       untRelEtiqQtdRestante,
       untRelFichaCadFuncionario,
      }
      untFuncoesFactory;

{
Procedure pRelCadDireitosDeAcesso(mnuMainMenu: TMainMenu);
Begin
  pCriarFormularios(TfrmRelCadDireitosDeAcesso, frmRelCadDireitosDeAcesso);
  frmRelCadDireitosDeAcesso.mnuMainMenu := mnuMainMenu;
  frmRelCadDireitosDeAcesso.ShowModal;
  FreeAndNil(frmRelCadDireitosDeAcesso);
End;
}

function fSVN_RevisionRelCadastro: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelcadastro(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelCadastros;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH,'libRelCadastros');
  {
    Case relTipRel of
      RelContratoAberturaCredito : pCriarForm(TfrmRelContratoAberturaCredito, frmRelContratoAberturaCredito);
      relCadDireitosDeAcesso     : pRelCadDireitosDeAcesso(objDllRel.varRecCad.mnuMainMenu);
      relEtiqQtdRestante         : pCriarForm(TfrmRelEtiqQtdRestante, frmRelEtiqQtdRestante);
      relFichaCadFuncionario     : TfrmRelFichaCadFuncionario.pRelFichaCadFuncionario(varRecCad.strcodFun);
      TfrmRelFichaCadFuncionario.pRelFichaCadFuncionario(varRecCad.strCodFun);
    End;
   }
  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
