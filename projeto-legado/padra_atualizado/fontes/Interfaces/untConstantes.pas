unit untConstantes;

interface

Uses SysUtils, {$IFDEF VER180}
                 Messages,
                 DB;
               {$ELSE}
                 Winapi.Messages,
                 UniClientDataSet,
                 Data.DB;
               {$ENDIF}

  Type
    ExceptionAutCom = Class(Exception);
    {$IFDEF VER180}
      TGenericProcedureWithClientParamAndVar = procedure(Var strParamPorReferencia1: String; strParamPorValor1: String; cdsConsulta: TDataSet);
    {$ELSE}
      TGenericProcedureWithClientParamAndVar = procedure(Var strParamPorReferencia1: String; strParamPorValor1: String; cdsConsulta: TUniClientDataSet);
    {$ENDIF}

  Const
    MAX_TABELA_PRECOS = 7;
    ERROR_FOREIGN_KEY_DELETE = 1217;
    ERROR_FOREIGN_KEY_INSERT = 1216;
    ERROR_PRIMARY_KEY_INSERT = 1062;
    CM_AVISOS = WM_USER + 1;
    WM_MESSAGEATUALIZADADOSCONSULTA = WM_USER + 777;
    WM_MESSAGELIMPARFILTROCONSULTA  = WM_USER + 778;
    WM_MESSAGENAVEGANDOGRIDCONSULTA = WM_USER + 779;
    WM_MESSAGEPRESSIONOUTABCONSULTA = WM_USER + 780;
    WM_MESSAGECONSULTAFORMRESIZE    = WM_USER + 781;
    WM_MESSAGEATUALIZOUTOTALVENDA   = WM_USER + 782;
    WM_MESSAGEATUALIZAPESQUISA      = WM_USER + 783;

implementation

end.

