unit untDllGNRE;

interface

Uses Classes, Forms, SysUtils, Uni,
     Windows, untFuncoesSimples, untFuncoesRel;

Type
  TGnre = (GnrePernambuco);

  TGnreModulos = Record
    Banco: TUniConnection;
  End;

  TGnreVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String[200];
    strEmpEst : String[200];
    strEmpCod : String[3];
    strClaVen : String[255];
    strClaDev : String[255];
    utcRegist : TUltConsultas;
    blnModoClassico: Boolean;
  End;

  TGnreParam = Record
    prcExecutaRelatorio :  TExecutaRelatorio;
  End;

  TparamGnre = class(TObject)
    public
      intDebugH : Byte;
      frmTipGnr : TGnre;
      modRecMod : TGnreModulos;
      varRecVar : TGnreVariaveis;
      varParam  : TGnreParam;
      AppHandle : Hwnd;
  End;

  TProcedureGNRE = procedure (prmDllGnre: Pointer);

procedure pIniVariaveis(Var varRecVar: TGnreVariaveis);
procedure pIniModulos(Var modRecMod: TGnreModulos);

implementation

uses untModulo;


procedure pIniModulos(Var modRecMod: TGnreModulos);
Begin
  modRecMod.Banco := frmModulo.GetCurrentConnection;
End;

procedure pIniVariaveis(Var varRecVar: TGnreVariaveis);
Begin
  varRecVar.dtaVSDate := VS_Date;
  varRecVar.strLogUsu := ShortString(strLoginUsuarioLogado);
  varRecVar.strDesUsu := ShortString(strDescriUsuarioLogado);
  varRecVar.strEmpUsu := ShortString(strEmpAcessoUsuarioLogado);
  varRecVar.strEmpEst := ShortString(strEmpEstUsuarioLogado);
  varRecVar.strEmpCod := ShortString(String(VS_strCodEmp));
  varRecVar.strClaVen := ShortString(VS_strClaVen);
  varRecVar.strClaDev := ShortString(VS_strClaDev);
  varRecVar.utcRegist := utcRegistros;
  varRecVar.blnModoClassico := blnUsuarioLogadoUtilizaModoClassico;
End;

end.
