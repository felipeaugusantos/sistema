unit untUnidac;

interface

uses Uni, untConnection, untQuery, Data.DB, untQueryParam, System.Classes;

type
  TUnidacConnection = class(TInterfacedObject, IConnection)
  private
    FUniConnection : TUniConnection;
    FAfterStartTransaction: TNotifyConnEvent ;
    FAfterCommit: TNotifyConnEvent ;
    FAfterRollback: TNotifyConnEvent ;
    procedure InitializeVars ;
    procedure SetAfterStartTransaction(const AValue: TNotifyConnEvent);
    function GetAfterStartTransaction: TNotifyConnEvent;
    procedure SetAfterCommit(const AValue: TNotifyConnEvent);
    function GetAfterCommit: TNotifyConnEvent;
    procedure SetAfterRollback(const AValue: TNotifyConnEvent);
    function GetAfterRollback: TNotifyConnEvent;
    procedure HandleTransactionOperation(AOperation: TTransactionState);
  public
    function InTransaction : Boolean;
    function NewQuery(const AExecTimeout : Cardinal = 0) : IQuery;
    procedure Commit;
    procedure Rollback;
    procedure Connect;
    procedure Disconnect;
    procedure StartTransaction;
    constructor Create; overload;
    constructor Create(AConn:TUniConnection); overload ;
    property AfterStartTransaction: TNotifyConnEvent read GetAfterStartTransaction write SetAfterStartTransaction;
    property AfterCommit: TNotifyConnEvent read GetAfterCommit write SetAfterCommit;
    property AfterRollback: TNotifyConnEvent read GetAfterRollback write SetAfterRollback;
  End;

  TUnidacQuery = class(TInterfacedObject, IQuery)
  private
    FUniQuery : TUniQuery;
  public
    procedure Close;
    procedure Open;
    procedure ExecSQL;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const ParamName: String): IQueryParam;
    function IsEmpty : Boolean;
    procedure Insert;
    procedure Post;
    procedure setSQL(const Value: TStrings);
    function getSQL: TStrings;
    property SQL: TStrings read getSQL write setSQL;
    procedure First;
    function Eof : Boolean;
    procedure Next;
    function FindField(const FieldName: string): TField;
    procedure Append;
    function Active : Boolean;
    procedure Edit;
    constructor Create(AUniConnection : TUniConnection);
    destructor Destroy; override;
  End;

  TUniDacQueryParam = class(TInterfacedObject, IQueryParam)
  private
    FParam : TUniParam;
  public
    function getAsString: String;
    function getAsInteger: Integer;
    function getAsDateTime: TDateTime;
    procedure setAsInteger(const Value: Integer);
    procedure setAsString(const Value: String);
    procedure setAsDateTime(const Value: TDateTime);
    property AsString: String read getAsString write setAsString;
    property AsInteger: Integer read getAsInteger write setAsInteger;
    property AsDateTime: TDateTime read getAsDateTime write setAsDateTime;
    constructor Create(const AParam: TUniParam);
  End;

implementation

uses untModulo, untFuncoesSimples, System.SysUtils;

{ TUnidacConnection }

procedure TUnidacConnection.Commit;
begin
  fCommit(FUniConnection);
  HandleTransactionOperation(tsCommiting);
end;

procedure TUnidacConnection.Connect;
begin
  If FUniConnection.Connected Then
    Exit;
  FUniConnection.Connected := True;
end;

constructor TUnidacConnection.Create(AConn: TUniConnection);
begin
  FUniConnection := AConn ;
  InitializeVars ;
end;

constructor TUnidacConnection.Create;
begin
  FUniConnection := frmModulo.GetCurrentConnection;
  InitializeVars ;
end;

procedure TUnidacConnection.Disconnect;
begin
  FUniConnection.Connected := False;
end;

function TUnidacConnection.GetAfterCommit: TNotifyConnEvent;
begin
  Result := FAfterCommit ;
end;

function TUnidacConnection.GetAfterRollback: TNotifyConnEvent;
begin
  Result := FAfterRollback ;
end;

function TUnidacConnection.GetAfterStartTransaction: TNotifyConnEvent;
begin
  Result := FAfterStartTransaction ;
end;

procedure TUnidacConnection.HandleTransactionOperation(
  AOperation: TTransactionState);
begin
  case AOperation of
    tsStarting:
      begin
        if Assigned(FAfterStartTransaction) then
          FAfterStartTransaction(Self) ;
      end ;
    tsCommiting:
      begin
        if Assigned(FAfterCommit) then
          FAfterCommit(Self) ;
      end ;
    tsRollingback:
      begin
        if Assigned(FAfterRollback) then
          FAfterRollback(self) ;
      end ;
  end ;
end;

procedure TUnidacConnection.InitializeVars;
begin
  FAfterStartTransaction := Nil ;
  FAfterCommit := Nil ;
  FAfterRollback := Nil ;
end;

function TUnidacConnection.InTransaction: Boolean;
begin
  Result := fInTransaction(FUniConnection);
end;

function TUnidacConnection.NewQuery(const AExecTimeout: Cardinal = 0): IQuery;
begin
  Result := TUnidacQuery.Create(FUniConnection);
end;

procedure TUnidacConnection.Rollback;
begin
  fRollBack(FUniConnection);
  HandleTransactionOperation(tsRollingback);
end;

procedure TUnidacConnection.SetAfterCommit(const AValue: TNotifyConnEvent);
begin
  FAfterCommit := AValue ;
end;

procedure TUnidacConnection.SetAfterRollback(const AValue: TNotifyConnEvent);
begin
  FAfterRollback := AValue ;
end;

procedure TUnidacConnection.SetAfterStartTransaction(
  const AValue: TNotifyConnEvent);
begin
  FAfterStartTransaction := AValue ;
end;

procedure TUnidacConnection.StartTransaction;
begin
  fStartTransaction(FUniConnection);
  HandleTransactionOperation(tsStarting);
end;

{ TUnidacQuery }

function TUnidacQuery.Active: Boolean;
begin
  Result := FUniQuery.Active;
end;

procedure TUnidacQuery.Append;
begin
  FUniQuery.Append;
end;

procedure TUnidacQuery.Close;
begin
  FUniQuery.Close;
end;

constructor TUnidacQuery.Create(AUniConnection : TUniConnection);
begin
  FUniQuery := fCriaQuery(AUniConnection);
end;

destructor TUnidacQuery.Destroy;
begin
  FreeAndNil(FUniQuery);
  inherited;
end;

procedure TUnidacQuery.Edit;
begin
  FUniQuery.Edit;
end;

function TUnidacQuery.Eof: Boolean;
begin
  Result := FUniQuery.Eof;
end;

procedure TUnidacQuery.ExecSQL;
begin
  FUniQuery.ExecSQL;
end;

function TUnidacQuery.FieldByName(const FieldName: string): TField;
begin
  Result := FUniQuery.FieldByName(FieldName);
end;

function TUnidacQuery.FindField(const FieldName: string): TField;
begin
  Result := FUniQuery.FindField(FieldName);
end;

procedure TUnidacQuery.First;
begin
  FUniQuery.First;
end;

function TUnidacQuery.getSQL: TStrings;
begin
  Result := FUniQuery.SQL;
end;

procedure TUnidacQuery.Insert;
begin
  FUniQuery.Insert;
end;

function TUnidacQuery.IsEmpty: Boolean;
begin
  Result := FUniQuery.IsEmpty;
end;

procedure TUnidacQuery.Next;
begin
  FUniQuery.Next;
end;

procedure TUnidacQuery.Open;
begin
  FUniQuery.Open;
end;

function TUnidacQuery.ParamByName(const ParamName: String): IQueryParam;
begin
  Result := TUniDacQueryParam.Create(FUniQuery.ParamByName(ParamName));
end;

procedure TUnidacQuery.Post;
begin
  FUniQuery.Post;
end;

procedure TUnidacQuery.setSQL(const Value: TStrings);
begin
  FUniQuery.SQL := Value;
end;

{ TUniDacQueryParam }

constructor TUniDacQueryParam.Create(const AParam: TUniParam);
begin
  FParam := AParam;
end;

function TUniDacQueryParam.getAsDateTime: TDateTime;
begin
  Result := FParam.AsDateTime;
end;

function TUniDacQueryParam.getAsInteger: Integer;
begin
  Result := FParam.AsInteger;
end;

function TUniDacQueryParam.getAsString: String;
begin
  Result := FParam.AsString;
end;

procedure TUniDacQueryParam.setAsDateTime(const Value: TDateTime);
begin
  FParam.AsDateTime := Value;
end;

procedure TUniDacQueryParam.setAsInteger(const Value: Integer);
begin
  FParam.AsInteger := Value;
end;

procedure TUniDacQueryParam.setAsString(const Value: String);
begin
  FParam.AsString := Value;
end;

end.
