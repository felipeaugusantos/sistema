unit untFuncoesDllFiscalCat42;

interface

  Uses untConstCompartilhadaCat42,
       untFuncoesSimples,
       untGravando,
       Vcl.Themes,
       Vcl.Styles,
       Vcl.SysStyles;

 procedure fChamaProcessoCat42(ATipoChamadaCat42: TTipoChamadaCat42; Var varParametros: TCat42Variaveis); stdcall; External 'libFiscalCat42.dll' delayed;
 procedure pIniVariaveis(Var varParametros: TCat42Variaveis);

implementation

procedure pIniVariaveis(Var varParametros: TCat42Variaveis);
var
  strCodEmp: String;
Begin
  strCodEmp := VS_strCodEmp;
  varParametros.dtaVSDate := VS_Date;
  varParametros.strLogUsu := ShortString(strLoginUsuarioLogado);
  varParametros.strDesUsu := ShortString(strDescriUsuarioLogado);
  varParametros.strEmpUsu := ShortString(strEmpAcessoUsuarioLogado);
  varParametros.strEmpEst := ShortString(strEmpEstUsuarioLogado);
  varParametros.strEmpCod := ShortString(strCodEmp);
  varParametros.strClaVen := ShortString(VS_strClaVen);
  varParametros.strClaDev := ShortString(VS_strClaDev);
  varParametros.blnUsuarioLogadoUtilizaModoClassico := blnUsuarioLogadoUtilizaModoClassico;
End;

end.
