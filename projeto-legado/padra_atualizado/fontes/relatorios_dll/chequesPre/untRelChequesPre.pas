unit untRelChequesPre;

interface

Uses
  dxCore, SysUtils;

procedure prelchequespre(prmDllRel: Pointer);
function fSVN_RevisionRelCheques: String; stdcall;

implementation

uses untFuncoesFactory, untRelChqInclDiarias, untRelChqDepos, untRelChqRepassados,
  untRelChqPredatados, untRelChqDevolvidos, untRelChqEmCustodia, untRelPosContabilChq,
  untRelChqTelecheque, untRelChqDeletados, TypesRel, untDllRelatorios,
  untReimpressaoBorderoTelecheque, untIFuncoes, Vcl.Forms, untRelChqLogAcomp,
  System.Classes;

procedure pRelChqRepassados(objDllRel: TParamDllRelChequesPre);
begin
  With objDllRel, varRecEst Do
  Begin
    Try
      pCriarFormularios(TfrmRelChqRepassados, frmRelChqRepassados);
      frmRelChqRepassados.arrCheques := arrCheques;
      frmRelChqRepassados.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[]');
    End;
    pFreeAndNil(frmRelChqRepassados);
  End;
end;

function fSVN_RevisionRelCheques: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelchequespre(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelChequesPre;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH,'libRelChequesPre');
    
    Case relTipRel of
      relChqInclDiarias               : pCriarForm(TfrmRelChqInclDiarias, frmRelChqInclDiarias);
      relChqDepos                     : pCriarForm(TfrmRelChqDepos, frmRelChqDepos);
      relChqRepassados                : pRelChqRepassados(objDllRel);
      relChqPredatados                : pCriarForm(TfrmRelChqPredatados, frmRelChqPredatados);
      relChqDevolvidos                : pCriarForm(TfrmRelChqDevolvidos, frmRelChqDevolvidos);
      relChqEmCustodia                : pCriarForm(TfrmRelChqEmCustodia, frmRelChqEmCustodia);
      relPosContabilChq               : pCriarForm(TfrmRelPosContabilChq, frmRelPosContabilChq);
      relChqTelecheque                : pCriarForm(TfrmRelChqTelecheque, frmRelChqTelecheque);
      relReimpressaoBorderoTelecheque : pCriarForm(TfrmReimpressaoBorderoTelecheque, frmReimpressaoBorderoTelecheque);
      relChqDeletados                 : pCriarForm(TfrmRelChqDeletados, frmRelChqDeletados);
      relChqLogAcomp                  : pCriarForm(TfrmRelChqLogAcomp, frmRelChqLogAcomp);
    End;

  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
