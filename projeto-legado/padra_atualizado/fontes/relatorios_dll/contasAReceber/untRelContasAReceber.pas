unit untRelContasAReceber;

interface

Uses
  dxCore,
  SysUtils;

procedure prelcontasareceber(prmDllRel: Pointer);
function fSVN_RevisionRelContasReceber: String; stdcall;

implementation

uses untFuncoesFactory, untRelCtrAnaCreditos, untRelCtrTitRecPortador, untRelCtrTitReceb,
  untRelCtrReceber, untRelCtrIncDiarias, untRelPosContabil, untRelTitDeletados,
  untRelCtrCartoes, untCartaAnuencia, untRelDupAgr, untRelCtrComVendedor, untRelCtrLogDesagrup,
  untRelBoletosImpressos, untRelCtrInadimplencia, untRelCtrAnaliseCredito, untRelDupEnvBanco,
  untRelPosContabilCar, untRelCtrBordero, untRelCtrHistReceb, untRelCtrCreditosUtilizados,
  untRelCtrCartaProtesto, untRelCtrFpgFatRec, untRelCtrRegistroDuplicatas, untRelCtrAgingCobranca,
  untRelCtrCartaDes, untRelCtrContaCorrenteProduto, TypesRel,
  untDllRelatorios, untIFuncoes, Vcl.Forms, untRelCtrExportaCobranca;

function fSVN_RevisionRelContasReceber: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelcontasareceber(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelContasAReceber;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH,'libRelContasAReceber');

    Case relTipRel of
      relCtrAnaCreditos       : pCriarForm(TfrmRelCtrAnaCreditos, frmRelCtrAnaCreditos);
      relCtrTitRecPortador    : pCriarForm(TfrmRelCtrTitRecPortador,frmRelCtrTitRecPortador);
      relCtrTitReceb          : pCriarForm(TfrmRelCtrTitReceb, frmRelCtrTitReceb);
      relCtrReceber           : pCriarForm(TfrmRelCtrReceber, frmRelCtrReceber);
      relCtrIncDiarias        : pCriarForm(TfrmRelCtrIncDiarias, frmRelCtrIncDiarias);
      relPosContabil          : pCriarForm(TfrmRelPosContabil, frmRelPosContabil);
      relTitDeletados         : pCriarForm(TfrmRelTitDeletados, frmRelTitDeletados);
      relCtrCartoes           : pCriarForm(TfrmRelCtrCartoes,frmRelCtrCartoes);
      relCartaAnuencia        : pCriarForm(TfrmCartaAnuencia, frmCartaAnuencia);
      relDupAgr               : pCriarForm(TfrmRelDupAgr, frmRelDupAgr);
      relCtrComVendedor       : pCriarForm(TfrmRelCtrComVendedor, frmRelCtrComVendedor);
      relCtrLogDesagrup       : pCriarForm(TfrmRelCtrLogDesagrup, frmRelCtrLogDesagrup);
      relBoletosImpressos     : pCriarForm(TfrmRelBoletosImpressos, frmRelBoletosImpressos);
      relCtrInadimplencia     : pCriarForm(TfrmRelCtrInadimplencia, frmRelCtrInadimplencia);
      relCtrAnaliseCredito    : pCriarForm(TfrmRelCtrAnaliseCredito, frmRelCtrAnaliseCredito);
      relDupEnvBanco          : pCriarForm(TfrmRelDupEnvBanco, frmRelDupEnvBanco);
      relPosContabilCar       : pCriarForm(TfrmRelPosContabilCar, frmRelPosContabilCar);
      relCtrBordero           : pCriarForm(TfrmRelCtrBordero, frmRelCtrBordero);
      relCtrHistReceb         : pCriarForm(TfrmRelCtrHistReceb, frmRelCtrHistReceb);
      relCtrCreditosUtilizados: pCriarForm(TfrmRelCtrCreditosUtilizados, frmRelCtrCreditosUtilizados);
      relCtrCartaProtesto     : pCriarForm(TfrmRelCtrCartaProtesto, frmRelCtrCartaProtesto);
      relCtrFpgFatRec         : pCriarForm(TfrmRelCtrFpgFatRec, frmRelCtrFpgFatRec);
      relCtrRegistroDuplicatas: pCriarForm(TfrmRelCtrRegistroDuplicatas, frmRelCtrRegistroDuplicatas);
      relCtrCartaDes          : pCriarForm(TfrmRelCtrCartaDes, frmRelCtrCartaDes);
      relCtrAgingCobranca     : pCriarForm(TfrmRelCtrAgingCobranca, frmRelCtrAgingCobranca);
      relCtrContaCorrenteProduto: pCriarForm(TfrmRelCtrContaCorrenteProduto, frmRelCtrContaCorrenteProduto);
      relCtrExportaCobranca   : pCriarForm(TfrmRelCtrExportaCobranca, frmRelCtrExportaCobranca);
    End;

  End;

  pLiberaModulos;

End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
