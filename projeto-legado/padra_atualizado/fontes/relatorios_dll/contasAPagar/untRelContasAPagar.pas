unit untRelContasAPagar;

interface

Uses
  dxCore, SysUtils, TypesRel, untDllRelatorios, untIFuncoes, vcl.Forms;

procedure prelcontasapagar(prmDllRel: Pointer);
function fSVN_RevisionRelContasPagar: String; Stdcall;

implementation

uses untFuncoesFactory, untRelCtpAnaDebitos, untRelCtpTitAbertoMes, untRelCtpEncQuitados,
  untRelCtpContaCorrente, untRelCtpIncDiarias, untRelCtpIncDiariasMes, untRelCtpTitContas,
  untRelCtpPosContabil, untRelCtpAgrup, untRelCtpTitPortador, untRelCtpTitContasAno,
  untrelCtpKmRodadoVeic, untRelCtpChequesEmitidos, untRelCtpTitPagosComCheque,
  untRelCtpReimpressaoDocs, untRelCtpTitDeletados, untRelCtpLogAcompDuplic;

function fSVN_RevisionRelContasPagar: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelcontasapagar(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelContasAPagar;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH,'libRelContasAPagar');

    Case relTipRel of
      relCtpAnaDebitos     : pCriarForm(TfrmRelCtpAnaDebitos, frmRelCtpAnaDebitos);
      relCtpTitAbertoMes   : pCriarForm(TfrmRelCtpTitAbertoMes,frmRelCtpTitAbertoMes);
      relCtpEncQuitados    : pCriarForm(TfrmRelCtpEncQuitados, frmRelCtpEncQuitados);
      relCtpContaCorrente  : pCriarForm(TfrmRelCtpContaCorrente, frmRelCtpContaCorrente);
      relCtpIncDiarias     : pCriarForm(TfrmRelCtpIncDiarias, frmRelCtpIncDiarias);
      relCtpIncDiariasMes  : pCriarForm(TfrmRelCtpIncDiariasMes, frmRelCtpIncDiariasMes);
      relCtpTitContas      : pCriarForm(TfrmRelCtpTitContas, frmRelCtpTitContas);
      relCtpPosContabil    : pCriarForm(TfrmRelCtpPosContabil, frmRelCtpPosContabil);
      relCtpAgrup          : pCriarForm(TFrmRelCtpAgrup,FrmRelCtpAgrup);
      relCtpTitPortador    : pCriarForm(TfrmRelCtpTitPortador, frmRelCtpTitPortador);
      relCtpTitPagosComCheque : pCriarForm(TfrmRelCtpTitPagosComCheque, frmRelCtpTitPagosComCheque);
      relCtpTitContasAno      : pCriarForm(TfrmRelCtpTitContasAno, frmRelCtpTitContasAno);
      relCtpKmRodadoVeic      : pCriarForm(TfrmRelCtpKmRodadoVeic, frmRelCtpKmRodadoVeic);
      relCtpChequesEmitidos   : pCriarForm(TfrmRelCtpChequesEmitidos, frmRelCtpChequesEmitidos);
      relCtpReimpDocs         : pCriarForm(TfrmRelCtpReimpressaoDoc, frmRelCtpReimpressaoDoc);
      relCtpTitDeletados      : pCriarForm(TfrmRelCtpTitDeletados, frmRelCtpTitDeletados);
      relCtpLogAcompDuplic    : pCriarForm(TfrmRelCtpLogAcompDuplic, frmRelCtpLogAcompDuplic);
    End;

  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
