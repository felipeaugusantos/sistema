unit untDllGatImeParametros;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\Services\core\services.core.uses.inc'},
{$ENDIF LINUX}
  Classes,
  SysUtils,
  Uni;

Type
  TGatImeModulos = Record
    Banco: {$IFDEF LINUX} IConnection {$ELSE} TUniConnection {$ENDIF LINUX};
    {$IFDEF LINUX}
    ConnectionManager: TConnectionsManager;
    {$ENDIF LINUX}
  End;

  TGatImeVariaveis = Record
    dtaVSDate : TDateTime;
    strLogUsu : String[3];
    strDesUsu : String[30];
    strEmpUsu : String;
    strEmpEst : String;
    strEmpCod : String[3];
  End;

  TparamGatIme = class(TObject)
    public
      intDebugH : Byte;
      modRecMod : TGatImeModulos;
      varRecVar : TGatImeVariaveis;
      {$IFDEF LINUX}
      Application: TApplication;
      {$ENDIF LINUX}
  End;

implementation

end.
