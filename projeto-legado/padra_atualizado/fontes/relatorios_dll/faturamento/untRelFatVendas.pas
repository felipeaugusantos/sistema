unit untRelFatVendas;

interface

Uses Forms, dxCore, SysUtils, StrUtils, Classes;

procedure prelfatvendas(prmDllRel: Pointer);
function fSVN_RevisionRelFatVendas: String; stdcall;

implementation

uses TypesRel, untDllRelatorios, untFuncoesFactory, untIFuncoes,
    untRelFatVendasMarkup, untRelFatVendasMarkupAndor, untRelFatVendasMarkupMod6;

function fSVN_RevisionRelFatVendas: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure prelfatvendas(prmDllRel: Pointer);
Var
  objDllRel : TParamDllRelFaturamento;
Begin
  objDllRel := prmDllRel;

  With objDllRel Do
  Begin
    pSetaModulos(modRecMod);

    pCriaModulos(varRecVar);

    pIniciaLogLeak(intDebugH, 'libRelFatVendas');

    Case relTipRel of
      relFatVendasMarkup          : If fCfgSis('MODMKP', varInteger) = 6 Then
                                      pCriarForm(TfrmRelFatVendasMarkupMod6, frmRelFatVendasMarkupMod6)
                                    Else
                                      pCriarForm(TfrmRelFatVendasMarkup, frmRelFatVendasMarkup);

      relFatVendasMarkupAndor     : pCriarForm(TfrmRelFatVendasMarkupAndor, frmRelFatVendasMarkupAndor);
    End;

  End;

  pLiberaModulos;
End;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.
