unit untDllReinfFuncoes;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses Classes, Forms, SysUtils, Uni, Windows, untFuncoesSimples, untDLLReinf,
     untILiberacao, untLiberacao, untFuncoesRel;

  procedure pReinf(prmDllreinf: Pointer); stdcall; External 'libReinf.dll' delayed;
  function fSVN_RevisionReinf: String; stdcall; External 'libReinf.dll' delayed;

  Procedure pReinfParam(frmFormulario: TFormulariosReinf; HandleOrigin: HWND = 0);

  procedure pIniVariaveis(Var varRecVariaveis: TReinfVariaveis);
  procedure pIniModulos(Var modRecMod: TReinfModulos);

implementation

uses
  untModulo, untFuncIns;

Procedure pReinfParam(frmFormulario: TFormulariosReinf; HandleOrigin: HWND = 0);
  Var
    objReinf : TparamReinf;
    varParametro : TReinfParam;
Begin
  Try
    varParametro.prcExecutaRelatorio :=  prcExecutaRelatorio;
    varParametro.HandleOrigin := HandleOrigin;

    objReinf := TparamReinf.Create;

    {$WARN SYMBOL_PLATFORM OFF}
    objReinf.intDebugH := DebugHook;
    {$WARN SYMBOL_PLATFORM ON}
    objReinf.frmTipRei := frmFormulario;
    pIniModulos(objReinf.ModRecMod);
    pIniVariaveis(objReinf.varRecVar);
    objReinf.varParam := varParametro;
    objReinf.objLibera := TLiberacao.Create;

    pReinf(objReinf);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'DLL libReinf');
    End;
  End;

End;

procedure pIniModulos(Var modRecMod: TReinfModulos);
Begin
  modRecMod.Banco := frmModulo.GetCurrentConnection;
End;

procedure pIniVariaveis(Var varRecVariaveis: TReinfVariaveis);
Begin
  varRecVariaveis.dtaVSDate := VS_Date;
  varRecVariaveis.strLogUsu := ShortString(strLoginUsuarioLogado);
  varRecVariaveis.strDesUsu := ShortString(strDescriUsuarioLogado);
  varRecVariaveis.strEmpUsu := String(strEmpAcessoUsuarioLogado);
  varRecVariaveis.strEmpEst := String(strEmpEstUsuarioLogado);
  varRecVariaveis.strEmpCod := ShortString(String(VS_strCodEmp));
  varRecVariaveis.objTraceViewer := untFuncoesSimples.VS_objTraceViewer;
  varRecVariaveis.blnModoClassico := blnUsuarioLogadoUtilizaModoClassico;
  varRecVariaveis.utcRegist := utcRegistros;
End;

end.
