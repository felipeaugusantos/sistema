unit untDllGnreFuncoes;

interface

Uses Classes, Forms, SysUtils, Uni, untDllGnre, Windows, untFuncoesSimples,
     untFuncoesRel;

  function fSVN_RevisionGNRE: String; stdcall; External 'libGNRE.dll' delayed;
  procedure pGNRE(prmDllGnre: Pointer); stdcall; External 'libGNRE.dll' delayed;
  procedure pGNRECarreg(prmDllTra: Pointer); stdcall; External 'libGNRE.dll' delayed;

  procedure pCarregaLibGnre(frmTipGnre: TGnre);

  procedure pCarregaGNRE(frmTipGnre: TGnre; Var varParametros: TGnreParam);

implementation

uses untModulo;

procedure pCarregaGNRE(frmTipGnre: TGnre; Var varParametros: TGnreParam);
Var
  objGnre : TparamGnre;

Begin

  Try
    objGnre := TparamGnre.Create;

    {$WARN SYMBOL_PLATFORM OFF}
    objGnre.intDebugH := DebugHook;
    {$WARN SYMBOL_PLATFORM ON}
    objGnre.frmTipGnr := frmTipGnre;
    pIniVariaveis(objGnre.VarRecVar);
    objGnre.AppHandle := Application.Handle;

    pIniModulos(objGnre.ModRecMod);

    objGnre.varParam := varParametros;

    pGNRE(objGnre);

    varParametros := objGnre.varParam;

    FreeAndNil(objGnre);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'DLL libGNRE');
    End;
  End;

End;

procedure pCarregaLibGnre(frmTipGnre: TGnre);
  Var
    varParametro : TGnreParam;
Begin
  FillChar(varParametro, SizeOf(varParametro), #0);
  varParametro.prcExecutaRelatorio :=  prcExecutaRelatorio;
  pCarregaGNRE(frmTipGnre, varParametro);
End;

end.
