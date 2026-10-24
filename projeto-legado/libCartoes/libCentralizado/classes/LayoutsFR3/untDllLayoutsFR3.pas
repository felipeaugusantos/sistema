unit untDllLayoutsFR3;

interface

Uses Classes, Forms, SysUtils, Uni, Windows,
  untFuncoesSimples, untTypesSistema, untTelasAbertas;

Type
  TLayoutsFR3Modulos = Record
    Banco: TUniConnection;
  End;

  TLayoutsFR3Variaveis = Record
    dtaVSDate: TDateTime;
    strLogUsu: String[3];
    strDesUsu: String[30];
    strEmpUsu: String[200];
    strEmpEst: String[200];
    strEmpCod: String[3];
    utcRegist: TUltConsultas;
    objTraceViewer: ITraceViewer;
    blnModoClassico: Boolean;
    objTelasAbertas : ITelasAbertas;
  End;

  TParamLayoutsFR3 = class(TObject)
  public
    intDebugH: Byte;
    modRecMod: TLayoutsFR3Modulos;
    varRecVar: TLayoutsFR3Variaveis;
  End;

procedure pIniVariaveis(Var varRecVar: TLayoutsFR3Variaveis);
procedure pIniModulos(Var modRecMod: TLayoutsFR3Modulos);

implementation

uses untModulo;

procedure pIniModulos(Var modRecMod: TLayoutsFR3Modulos);
Begin
  modRecMod.Banco := frmModulo.GetCurrentConnection;
End;

procedure pIniVariaveis(Var varRecVar: TLayoutsFR3Variaveis);
Begin
  varRecVar.dtaVSDate := VS_Date;
  varRecVar.strLogUsu := ShortString(strLoginUsuarioLogado);
  varRecVar.strDesUsu := ShortString(strDescriUsuarioLogado);
  varRecVar.strEmpUsu := ShortString(strEmpAcessoUsuarioLogado);
  varRecVar.strEmpEst := ShortString(strEmpEstUsuarioLogado);
  varRecVar.strEmpCod := ShortString(String(VS_strCodEmp));
  varRecVar.utcRegist := utcRegistros;
  varRecVar.objTraceViewer := VS_objTraceViewer;
  varRecVar.blnModoClassico := blnUsuarioLogadoUtilizaModoClassico;
  varRecVar.objTelasAbertas := untTelasAbertas.objTelasAbertas;
End;

end.
