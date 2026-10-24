unit untITSQLTrace;

interface

uses Controls, DASQLMonitor, DBAccess, Classes;

Type
  TBotao       = (tbInicio, tbPausa, tbSalva, tbShow, tbHide);
  TTipoTrace   = (ttSimples, ttCompleto, ttPerformance);
  TStatusTrace = (stIniciado, stPausado);

  ITSQLTrace = interface
    function GetStackTrace: Boolean;
    function GetCabecalho: Boolean;
    function GetCountSQL: Integer;
    function GetStatus: TStatusTrace;
    function GetTipo: TTipoTrace;
    function GetTempFile: String;
    function GetAutenticado: Boolean;

    procedure SetStackTrace(const Value: Boolean);
    procedure SetCabecalho(const Value: Boolean);
    procedure SetCountSQL(const Value: Integer);
    procedure SetStatus(const Value: TStatusTrace);
    procedure SetTipo(const Value: TTipoTrace);
    procedure SetTempFile(const Value: String);
    procedure SetAutenticado(const Value: Boolean);

    procedure pIniciaTrace;
    procedure pPausaTrace;
    procedure pSalvaTrace;
    procedure pIncCountSQL;

    function ParseSQLCitel(const SQL: string; Params: TObject): string;
    function ParseSQL(const SQL: string): String;

    procedure pShowDebugForm(DASQLMonitorClass: TDASQLMonitorClass;
      Component: TComponent; SQL: string; Params: TDAParams; Caption: string);

    property StackTrace : Boolean        read GetStackTrace  write SetStackTrace;
    property Cabecalho  : Boolean        read GetCabecalho   write SetCabecalho;
    property CountSQL   : Integer        read GetCountSQL    write SetCountSQL;
    property Status     : TStatusTrace   read GetStatus      write SetStatus;
    property Tipo       : TTipoTrace     read GetTipo        write SetTipo;
    property TempFile   : String         read GetTempFile    write SetTempFile;
    property Autenticado: Boolean        read GetAutenticado write SetAutenticado;
  end;

implementation

end.
