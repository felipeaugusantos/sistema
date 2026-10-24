unit untRelEstoque;

interface

Uses
  Forms, SysUtils, dxCore, TypesRel, untIFuncoes, System.Classes, untFuncoesRel;

procedure prelestoque(prmDllRel: Pointer);
function fSVN_RevisionRelEstoque: String; stdcall;

implementation

uses  untFuncoesfactory, untDllRelatorios;

(*
procedure pRelEstMovSaldoBal(objDllRel: TParamDllRelEstoque);
Begin
  With objDllRel, varRecEst Do
  Begin
    If Not blnTemParametros Then
      pCriarForm(TfrmRelEstMovSaldoBal, frmRelEstMovSaldoBal)
    Else
    Begin
      Try
        pCriarFormularios(TfrmRelEstMovSaldoBal, frmRelEstMovSaldoBal);
        frmRelEstMovSaldoBal.mskDtaIni.Text   := String(strDataSalBal);
        frmRelEstMovSaldoBal.mskDtaFin.Text   := String(strDataSalBal);
        frmRelEstMovSaldoBal.blnImprimeDireto := True;
        frmRelEstMovSaldoBal.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pRelEstMovSaldoBal]');
        End;
      End;

      pFreeAndNil(frmRelEstMovSaldoBal);

    End;
  End;
End;
*)

function fSVN_RevisionRelEstoque: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelestoque(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelEstoque;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    //pCarregaFuncoesDll(Nil, Nil, Nil, Nil);

    pIniciaLogLeak(intDebugH, 'libRelEstoque');

  End;

  pLiberaModulos;

End;

Initialization
  dxInitialize;

Finalization
  dxFinalize;

end.


