unit untFiredac;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  untConnection, untQuery, untQueryParam, untTypesSistema, DB, System.Classes,
  System.SysUtils;

type
  TFireDacConnection = class(TInterfacedObject, IConnection)
  private
    FFDConnection : TFDConnection;
    FDDriverLink : TFDPhysMySQLDriverLink;
    FDCursor : TFDGUIxWaitCursor;
    FDatabaseParameters : TDatabaseParameters;
    FAfterStartTransaction: TNotifyConnEvent;
    FAfterCommit: TNotifyConnEvent;
    FAfterRollback: TNotifyConnEvent;
    FSafeDisconnection : Boolean;
    function NewConnection: TFDConnection;
    procedure SetAfterStartTransaction(const AValue: TNotifyConnEvent);
    function GetAfterStartTransaction: TNotifyConnEvent;
    procedure SetAfterCommit(const AValue: TNotifyConnEvent);
    function GetAfterCommit: TNotifyConnEvent;
    procedure SetAfterRollback(const AValue: TNotifyConnEvent);
    function GetAfterRollback: TNotifyConnEvent;
   // procedure HandleTransactionOperation(AOperation: TTransactionState);
    procedure OnRecover(ASender: TObject; AInitiator: TObject; AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure InternalAfterConnect(Sender: TObject);
  public
    function InTransaction : Boolean;
    function NewQuery(const AExecTimeout : Cardinal = 0) : IQuery;
    procedure Commit;
    procedure Rollback;
    procedure Connect;
    procedure Disconnect;
    procedure StartTransaction;
    property AfterStartTransaction: TNotifyConnEvent read GetAfterStartTransaction write SetAfterStartTransaction;
    property AfterCommit: TNotifyConnEvent read GetAfterCommit write SetAfterCommit;
    property AfterRollback: TNotifyConnEvent read GetAfterRollback write SetAfterRollback;
    constructor Create(const ADatabaseParameters : TDatabaseParameters; const ASafeDisconnection : Boolean = False);
    destructor Destroy; override;
  End;

  TFireDacQuery = class(TInterfacedObject, IQuery)
  private
    FFDQuery : TFDQuery;
    function getSQL: TStrings;
    procedure setSQL(const Value: TStrings);
  public
    procedure Close;
    procedure Open;
    function FieldByName(const FieldName: string): TField;
    function ParamByName(const ParamName: String): IQueryParam;
    function IsEmpty : Boolean;
    procedure Insert;
    procedure Post;
    procedure ExecSQL;
    property SQL: TStrings read getSQL write setSQL;
    procedure First;
    function Eof : Boolean;
    procedure Next;
    function FindField(const FieldName: string): TField;
    procedure Append;
    function Active : Boolean;
    procedure Edit;
    constructor Create(const AFDConnection : TFDConnection; const AExecTimeout : Cardinal = 0);
    destructor Destroy; override;
  End;

  TFireDacQueryParam = class(TInterfacedObject, IQueryParam)
  private
    FParam : TFDParam;
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
    constructor Create(const AParam: TFDParam);
  End;

implementation

uses Vcl.Forms;

{ TFiredacConnection }

constructor TFireDacConnection.Create(const ADatabaseParameters : TDatabaseParameters; const ASafeDisconnection : Boolean = False);
begin
  FSafeDisconnection := ASafeDisconnection;
  FDatabaseParameters := ADatabaseParameters;
  FDDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
  FDDriverLink.VendorLib := FDatabaseParameters.VendorLib;
  FDCursor := TFDGUIxWaitCursor.Create(nil);
  FFDConnection := Self.NewConnection;
  FAfterStartTransaction := Nil ;
  FAfterCommit := Nil ;
  FAfterRollback := Nil ;
end;

destructor TFireDacConnection.Destroy;
begin
  FreeAndNil(FFDConnection);
  FreeAndNil(FDDriverLink);
  FreeAndNil(FDCursor);
  inherited;
end;

function TFireDacQuery.Eof: Boolean;
begin
  Result := FFDQuery.Eof;
end;

procedure TFireDacConnection.Connect;
begin
  FFDConnection.Connected := True;
end;

procedure TFireDacConnection.Disconnect;
begin
  FFDConnection.Connected := False;
end;

function TFireDacConnection.GetAfterCommit: TNotifyConnEvent;
begin
  Result := FAfterCommit ;
end;

function TFireDacConnection.GetAfterRollback: TNotifyConnEvent;
begin
  Result := FAfterRollback ;
end;

function TFireDacConnection.GetAfterStartTransaction: TNotifyConnEvent;
begin
  Result := FAfterStartTransaction ;
end;

{procedure TFireDacConnection.HandleTransactionOperation(
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
end;}

procedure TFireDacConnection.Commit;
begin
  FFDConnection.Commit;
end;

procedure TFireDacConnection.InternalAfterConnect(Sender: TObject);
begin
  If (Assigned(FFDConnection)) And (FFDConnection.Connected) And (Trim(FDatabaseParameters.IsolationLevelSQLInstruction)<>'') Then
    FFDConnection.ExecSQL(FDatabaseParameters.IsolationLevelSQLInstruction);
end;

function TFireDacConnection.InTransaction: Boolean;
begin
  Result := FFDConnection.InTransaction;
end;

function TFireDacConnection.NewQuery(const AExecTimeout : Cardinal = 0): IQuery;
begin
  Result := TFireDacQuery.Create(FFDConnection, AExecTimeout);
end;

procedure TFireDacConnection.OnRecover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  AAction := faFail;
end;

procedure TFireDacConnection.Rollback;
begin
  FFDConnection.Rollback;
end;

procedure TFireDacConnection.SetAfterCommit(const AValue: TNotifyConnEvent);
begin
  FAfterCommit := AValue ;
end;

procedure TFireDacConnection.SetAfterRollback(const AValue: TNotifyConnEvent);
begin
  FAfterRollback := AValue ;
end;

procedure TFireDacConnection.SetAfterStartTransaction(
  const AValue: TNotifyConnEvent);
begin
  FAfterStartTransaction := AValue ;
end;

procedure TFireDacConnection.StartTransaction;
begin
  FFDConnection.StartTransaction;
end;

function TFireDacConnection.NewConnection: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ResourceOptions.AutoReconnect := True;
  Result.Params.Add('Database=' + FDatabaseParameters.Database);
  Result.Params.Add('User_Name=' + FDatabaseParameters.Username);
  Result.Params.Add('Password=' + FDatabaseParameters.Password);
  Result.Params.Add('Port=' + FDatabaseParameters.Port.ToString);
  Result.Params.Add('Server=' + FDatabaseParameters.Server);
  Result.Params.Add('DriverID=' + FDatabaseParameters.Driver);
  If (FSafeDisconnection) Then
  Begin
    Result.OnRecover := OnRecover;
    Result.TxOptions.DisconnectAction := xdRollback;
  End;
  Result.AfterConnect := InternalAfterConnect;
end;

{ TFireDacQuery }

function TFireDacQuery.Active: Boolean;
begin
  Result := FFDQuery.Active;
end;

procedure TFireDacQuery.Append;
begin
  FFDQuery.Append;
end;

procedure TFireDacQuery.Close;
begin
  FFDQuery.Close;
end;

constructor TFireDacQuery.Create(const AFDConnection : TFDConnection; const AExecTimeout : Cardinal = 0);
begin
  FFDQuery := TFDQuery.Create(Nil);
  FFDQuery.Connection := AFDConnection;
  If AExecTimeout > 0 Then
    FFDQuery.ResourceOptions.CmdExecTimeout := AExecTimeout;
end;

destructor TFireDacQuery.Destroy;
begin
  FreeAndNil(FFDQuery);
  inherited;
end;

procedure TFireDacQuery.Edit;
begin
  FFDQuery.Edit;
end;

procedure TFireDacQuery.ExecSQL;
begin
  FFDQuery.ExecSQL;
end;

function TFireDacQuery.FieldByName(const FieldName: string): TField;
begin
  Result := FFDQuery.FieldByName(FieldName);
end;

function TFireDacQuery.FindField(const FieldName: string): TField;
begin
  Result := FFDQuery.FindField(FieldName);
end;

procedure TFireDacQuery.First;
begin
  FFDQuery.First;
end;

function TFireDacQuery.getSQL: TStrings;
begin
  Result := FFDQuery.SQL;
end;

procedure TFireDacQuery.Insert;
begin
  FFDQuery.Insert;
end;

function TFireDacQuery.IsEmpty: Boolean;
begin
  Result := FFDQuery.IsEmpty;
end;

procedure TFireDacQuery.Next;
begin
  FFDQuery.Next;
end;

procedure TFireDacQuery.Open;
begin
  FFDQuery.Open;
end;

function TFireDacQuery.ParamByName(const ParamName: String): IQueryParam;
begin
  Result := TFireDacQueryParam.Create(FFDQuery.ParamByName(ParamName));
end;

procedure TFireDacQuery.Post;
begin
  FFDQuery.Post;
end;

procedure TFireDacQuery.setSQL(const Value: TStrings);
begin
  FFDQuery.SQL := Value;
end;

{ TFireDacQueryParam }

constructor TFireDacQueryParam.Create(const AParam: TFDParam);
begin
  FParam := AParam;
end;

function TFireDacQueryParam.getAsDateTime: TDateTime;
begin
  Result := FParam.AsDateTime;
end;

function TFireDacQueryParam.getAsInteger: Integer;
begin
  Result := FParam.AsInteger;
end;

function TFireDacQueryParam.getAsString: String;
begin
  Result := FParam.AsString;
end;

procedure TFireDacQueryParam.setAsDateTime(const Value: TDateTime);
begin
  FParam.AsDateTime := Value;
end;

procedure TFireDacQueryParam.setAsInteger(const Value: Integer);
begin
  FParam.AsInteger := Value;
end;

procedure TFireDacQueryParam.setAsString(const Value: String);
begin
  FParam.AsString := Value;
end;

end.
