unit untModulo;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, MySQLUniProvider,
  DASQLMonitor, UniSQLMonitor, frxclass, Windows;

type
  TfrmModulo = class(TDataModule)
    Database: TUniConnection;
    sqlMonitor: TUniSQLMonitor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DatabaseAfterConnect(Sender: TObject);
  private
    { Private declarations }
    FMainThreadID: Cardinal;
  public
    { Public declarations }
    VersionTitle: String;
    function GetCurrentConnection: TUniConnection; overload;
    function GetCurrentConnection(AThreadId: Cardinal): TUniConnection; overload;
    class function GetMySqlStatementsHistory: string; overload;
    class function GetMySqlStatementsHistory(AConn: TUniConnection): string; overload;
    class function fGravarRelErro(strMensagemErro, strRelatorio, strUltSQL: String; conexao: TUniConnection = nil): Integer;
  end;

  TCriarConexao = class
  Private
    FConexao: TUniConnection;
  public
    constructor Create(AInfo: string = ''; blnConexaoIndependente: Boolean = True);
    destructor Destroy; override;
    property objConexao: TUniConnection Read FConexao;
  end;

  TModuloEvents = class
    class procedure AfterConnect(Sender: TObject);
  End;

  TDiretivasDaConexao = class
    class procedure DefineIsolationLevel(const ADatabase: TUniConnection);
  End;

var
  frmModulo: TfrmModulo;

implementation

uses
  untThreadUtils, untFuncoesSimples, untHorarioSistema, untConstantes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TCriarConexao }

constructor TCriarConexao.Create(AInfo: string; blnConexaoIndependente: Boolean);
begin
  if AInfo.IsEmpty then
    AInfo := 'Undefined';
  if blnConexaoIndependente then
    FConexao := TSafeThread.Connections.GetLocalConnection(AInfo)
  else
    FConexao := frmModulo.Database;
end;

destructor TCriarConexao.Destroy;
begin
  TSafeThread.Connections.RemoveLocalConnection(FConexao);
  inherited Destroy;
end;

class function TfrmModulo.fGravarRelErro(strMensagemErro, strRelatorio, strUltSQL: String; conexao: TUniConnection = nil): Integer;
Var
  qryLogErr: TUniQuery;
  intLogErr: Integer;
begin
  intLogErr := 0;

  Try
    qryLogErr := fCriaQuery(nil, conexao);
    qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

    With qryLogErr Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := fTime();
      FieldByName('LOG_DESCRI').AsString   := strMensagemErro;
      FieldByName('LOG_RELERR').AsString   := strRelatorio;
      if FindField('LOG_ULTSQL') <> nil then
        FindField('LOG_ULTSQL').AsString := strUltSQL;
      Post;
      intLogErr := FieldByName('AUTOINCREM').AsInteger;
      Close;
    End;

  Finally
    Result := intLogErr;
    FreeAndNil(qryLogErr);
  End;
end;

procedure TfrmModulo.DatabaseAfterConnect(Sender: TObject);
begin
  TModuloEvents.AfterConnect(Sender);
end;

procedure TfrmModulo.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  FMainThreadID := GetCurrentThreadId;
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin
    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End;
  End;
end;

function TfrmModulo.GetCurrentConnection: TUniConnection;
begin
  If GetCurrentThreadId = FMainThreadID Then
    Result := Self.Database
  Else If TSafeThread.Connections.HasThreadConnection(GetCurrentThreadId) Then
    Result := TSafeThread.Connections.GetThreadConnection(GetCurrentThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.Database;
end;

function TfrmModulo.GetCurrentConnection(AThreadId: Cardinal): TUniConnection;
begin
  If AThreadId = 0 Then
    Result := Self.Database
  Else If AThreadId = FMainThreadID Then
    Result := Self.Database
  Else If TSafeThread.Connections.HasThreadConnection(AThreadId) Then
    Result := TSafeThread.Connections.GetThreadConnection(AThreadId, 'TfrmModulo.GetCurrentConnection')
  Else
    Result := Self.GetCurrentConnection;
end;

class function TfrmModulo.GetMySqlStatementsHistory: string;
begin
  Result := TSafeThread.Connections.GetAllMySqlStatementsHistory;
end;

class function TfrmModulo.GetMySqlStatementsHistory(AConn: TUniConnection): string;
const
  sLineSeparator = '--------------------------------------------------------------------------------';
var
  LQuery: TUniQuery;
begin
  If Not Assigned(AConn) Then Exit(EmptyStr);

  LQuery := TUniQuery.Create(nil);
  try
    LQuery.Connection := AConn;
    try
      LQuery.SQL.Add(' SELECT ');
      LQuery.SQL.Add('   GROUP_CONCAT( ');
      LQuery.SQL.Add('     "CONNECTION_ID.....: ", ');
      LQuery.SQL.Add('     IFNULL(t.PROCESSLIST_ID, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "THREAD_ID.........: ", ');
      LQuery.SQL.Add('     IFNULL(t.THREAD_ID, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "EVENT_NAME........: ", ');
      LQuery.SQL.Add('     IFNULL(event_name, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "OBJECT_NAME.......: ", ');
      LQuery.SQL.Add('     IFNULL(object_name, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "NESTING_EVENT_TYPE: ", ');
      LQuery.SQL.Add('     IFNULL(nesting_event_type, ""), ');
      LQuery.SQL.Add('     "\n", ');
      LQuery.SQL.Add('     "SQL_TEXT..........:\n\n", ');
      LQuery.SQL.Add('     IFNULL(SQL_TEXT, ""), ');
      LQuery.SQL.Add('     "\n" ');
      LQuery.SQL.Add('     ORDER BY EVENT_ID DESC SEPARATOR "' + sLineSeparator + '\n" ');
      LQuery.SQL.Add('   ) ');
      LQuery.SQL.Add(' FROM ');
      LQuery.SQL.Add('   performance_schema.events_statements_history h ');
      LQuery.SQL.Add('   inner join performance_schema.threads t ');
      LQuery.SQL.Add('     on h.THREAD_ID = t.THREAD_ID ');
      LQuery.SQL.Add(' WHERE CURRENT_SCHEMA = DATABASE() ');
      LQuery.SQL.Add('   AND t.PROCESSLIST_ID = CONNECTION_ID(); ');
      LQuery.Open;
      Result := LQuery.Fields[0].AsString;
    except
      on E: Exception do
      begin
        Result := E.Message;
      end;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

{ TModuloEvents }

class procedure TModuloEvents.AfterConnect(Sender: TObject);
begin
  If (Not Assigned(Sender)) Then
    Exit;
  If (Not (Sender Is TUniConnection)) Then
    Exit;
  DefinirTimeZoneEmSessaoMySql(TUniConnection(Sender), VS_strCodEmp);
  TDiretivasDaConexao.DefineIsolationLevel(TUniConnection(Sender));
end;

{ TDiretivasDaConexao }

class procedure TDiretivasDaConexao.DefineIsolationLevel(const ADatabase: TUniConnection);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery(Nil, ADatabase);
  Try
    LQuery.Close;
    LQuery.SQL.Text := DEFAULT_ISOLATION_LEVEL_SQL_INSTRUCTION;
    LQuery.ExecSQL;
  Finally
    FreeAndNil(LQuery);
  End;
end;

end.
