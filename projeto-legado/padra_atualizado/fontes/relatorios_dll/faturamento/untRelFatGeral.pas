unit untRelFatGeral;

interface

Uses Forms, dxCore, SysUtils, StrUtils;

procedure prelfatgeral(prmDllRel: Pointer);
function fSVN_RevisionRelFatGeral: String; stdcall;

implementation

uses
  TypesRel, untDllRelatorios, untIFuncoes, System.Classes,
  untFuncoesFactory, untConstantes,
  untRelFatReciboAvulso;


function fSVN_RevisionRelFatGeral: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelfatgeral(prmDllRel: Pointer);
  Var
    objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFatGeral');
    
    Case relTipRel of
      relFatReciboAvulso          : pCriarForm(TfrmRelFatReciboAvulso, frmRelFatReciboAvulso);
    End;

  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
