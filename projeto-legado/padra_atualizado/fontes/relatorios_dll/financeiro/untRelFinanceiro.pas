unit untRelFinanceiro;

interface

Uses
  untModulo, untModuloSPR,  untModuloCfgRel, untModuloCfgAtb,

  untFuncoesRel, untFuncoesSimples, SysUtils,

  untRelCtpAnaDebitos,
  untRelCtpTitAbertoMes,
  untRelCtpEncQuitados,
  untRelCtpContaCorrente,
  untRelCtpIncDiarias,
  untRelCtpIncDiariasMes,
  untRelCtpTitContas,
  untRelCtpPosContabil,
  untRelCtpAgrup,

  untRelCtrAnaCreditos,
  untRelCtrTitRecPortador,
  untRelCtrTitReceb,
  untRelCtrReceber,
  untRelCtrIncDiarias,
  untRelPosContabil,
  untRelTitDeletados,
  untRelCtrCartoes,
  untRelCtrCartaCob,
  untCartaAnuencia,
  untRelDupAgr,
  untRelCtrReimpressaoDocs,
  untRelCtrComVendedor,
  untRelCtrLogDesagrup;

procedure prelfinanceiro(prmDllRel: Pointer);

implementation

procedure prelfinanceiro(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelFinanceiro;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin

    pSetaModulos(modRecMod);

    pCriaModulos;

    pSetaVariaveis(varRecVar);

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

      relCtrAnaCreditos    : pCriarForm(TfrmRelCtrAnaCreditos, frmRelCtrAnaCreditos);
      relCtrTitRecPortador : pCriarForm(TfrmRelCtrTitRecPortador,frmRelCtrTitRecPortador);
      relCtrTitReceb       : pCriarForm(TfrmRelCtrTitReceb, frmRelCtrTitReceb);
      relCtrReceber        : pCriarForm(TfrmRelCtrReceber, frmRelCtrReceber);
      relCtrIncDiarias     : pCriarForm(TfrmRelCtrIncDiarias, frmRelCtrIncDiarias);
      relPosContabil       : pCriarForm(TfrmRelPosContabil, frmRelPosContabil);
      relTitDeletados      : pCriarForm(TfrmRelTitDeletados, frmRelTitDeletados);
      relCtrCartoes        : pCriarForm(TfrmRelCtrCartoes,frmRelCtrCartoes);
      relCtrCartaCob       : pCriarForm(TfrmRelCartaCob,frmRelCartaCob);
      relCartaAnuencia     : pCriarForm(TfrmCartaAnuencia, frmCartaAnuencia);
      relDupAgr            : pCriarForm(TfrmRelDupAgr, frmRelDupAgr);
      relCtrReimpressaoDocs: pCriarForm(TfrmRelCtrReimpressaoDocs, frmRelCtrReimpressaoDocs);
      relCtrComVendedor    : pCriarForm(TfrmRelCtrComVendedor, frmRelCtrComVendedor);
      relCtrLogDesagrup    : pCriarForm(TfrmRelCtrLogDesagrup, frmRelCtrLogDesagrup);
    End;

  End;

  pLiberaModulos;

End;

end.
