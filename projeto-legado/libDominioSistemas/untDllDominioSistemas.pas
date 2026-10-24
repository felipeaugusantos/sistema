unit untDllDominioSistemas;

interface

Uses Classes, Forms, SysUtils, Uni,  Windows, untTypesSistema ;

type
  TTipoDominio = (tpdIntegracaoAPI) ;

  TDominioVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String[200];
    strEmpEst : String[200];
    strEmpCod : String[3];
    objTraceViewer: ITraceViewer;
    blnModoClassico: Boolean;
    strCodigoFiltro: String;
  End;

  TDominioModulos = Record
    Banco: TUniConnection;
  End ;

  TParamDominio = class(TObject)
  public
    intDebugH : Byte;
    frmTipCad : TTipoDominio;
    modRecMod : TDominioModulos;
    varRecVar : TDominioVariaveis;
  End;

  TProcedureDominio = procedure (prmDllTra: Pointer);

implementation

end.
