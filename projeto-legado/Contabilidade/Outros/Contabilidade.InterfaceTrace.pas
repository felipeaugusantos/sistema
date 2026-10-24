unit Contabilidade.InterfaceTrace;

interface

uses Data.DB, Uni ;

type
  TBotaoSQLTrace = (tbInicio, tbPausa, tbSalva, tbShow, tbHide);
  TTipoSQLTrace = (ttSimples, ttCompleto, ttPerformance);
  TStatusSQLTrace = (stIniciado, stPausado);

  ISQLTraceContabilidade = interface
    function GetStackTrace: Boolean;
    function GetCabecalho: Boolean;
    function GetCountSQL: Integer;
    function GetStatus: TStatusSQLTrace;
    function GetTipo: TTipoSQLTrace;
    function GetTempFile: String;
    function GetAutenticado: Boolean;

    procedure SetStackTrace(const Value: Boolean);
    procedure SetCabecalho(const Value: Boolean);
    procedure SetCountSQL(const Value: Integer);
    procedure SetStatus(const Value: TStatusSQLTrace);
    procedure SetTipo(const Value: TTipoSQLTrace);
    procedure SetTempFile(const Value: String);
    procedure SetAutenticado(const Value: Boolean);

    procedure pIniciaTrace;
    procedure pPausaTrace;
    procedure pSalvaTrace;
    procedure pIncCountSQL;

    procedure pWrite(AText: String);

    property StackTrace: Boolean read GetStackTrace write SetStackTrace;
    property Cabecalho: Boolean read GetCabecalho write SetCabecalho;
    property CountSQL: Integer read GetCountSQL write SetCountSQL;
    property Status: TStatusSQLTrace read GetStatus write SetStatus;
    property Tipo: TTipoSQLTrace read GetTipo write SetTipo;
    property TempFile: String read GetTempFile write SetTempFile;
    property Autenticado: Boolean read GetAutenticado write SetAutenticado;
  end;

  ITraceViewerContabilidade = interface
   ['{AC125F2C-280C-4F1C-B028-05A4EB2BE921}']
    procedure Show();
    procedure Stop();
    procedure LogSQL(ALog: String);
    procedure LogTimer(AInfo: String);
    procedure LogThread(AInfo: String);
    procedure SetQueryEvents(ADataSet: TUniQuery);
    procedure SetSQLTrace(AObj: ISQLTraceContabilidade);
    function Visible(): Boolean;
    function EnabledSQLLog(): Boolean;
  End;

implementation

end.
