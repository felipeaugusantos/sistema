unit untRelFatComissao;

interface

Uses Forms, dxCore, SysUtils, StrUtils, Classes;

procedure prelfatcomissao(prmDllRel: Pointer);
function fSVN_RevisionRelFatComissao: String; stdcall;

implementation

uses TypesRel, untDllRelatorios, untFuncoesFactory, untIFuncoes;

procedure pRelFatComVendedor(objDllRel: TParamDllRelFaturamento);
Begin
  With objDllRel Do
  Begin

    Try
      pCriarFormularios(TfrmRelFatComVendedor, frmRelFatComVendedor);
      frmRelFatComVendedor.blnSenha := True;
      frmRelFatComVendedor.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[pRelFatComVendedor]');
      End;
    End;

    pFreeAndNil(frmRelFatComVendedor);

  End;
End;

function fSVN_RevisionRelFatComissao: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelfatcomissao(prmDllRel: Pointer);
Var
  objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFatComissao');

    Case relTipRel of
      relFatComVendedor           : pRelFatComVendedor(objDllRel);
    End;

  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
