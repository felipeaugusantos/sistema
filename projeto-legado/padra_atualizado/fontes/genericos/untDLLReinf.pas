unit untDLLReinf;

interface

Uses Classes, Forms, SysUtils, Uni, untILiberacao,
     Windows, untFuncoesSimples, untFuncoesRel, untTypesSistema;

Type
  TFormulariosReinf = (IntegracaoReinf);

  TReinfModulos = Record
    Banco: TUniConnection;
  End;

  TReinfVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String;
    strEmpEst : String;
    strEmpCod : String[3];
    objTraceViewer: ITraceViewer;
    blnModoClassico: Boolean;
    utcRegist : TUltConsultas;
  End;

  TReinfParam = Record
    prcExecutaRelatorio :  TExecutaRelatorio;
    HandleOrigin: HWND;
  End;

  TparamReinf = class(TObject)
    public
      intDebugH : Byte;
      frmTipRei : TFormulariosReinf;
      modRecMod : TReinfModulos;
      varRecVar : TReinfVariaveis;
      varParam  : TReinfParam;
      objLibera : ILiberacao;
  End;

  TProcedureReinf = procedure (prmDllReinf: Pointer);

implementation

end.
