unit untConnection;

interface

uses untQuery;

type
  IConnection = Interface ;
  TTransactionState = (tsStarting, tsCommiting, tsRollingback);
  TNotifyConnEvent = reference to procedure(const objConexao: IConnection) ;

  IConnection = Interface
    ['{18790982-BBF7-45FD-9531-687061463176}']
    function InTransaction : Boolean;
    function NewQuery(const AExecTimeout : Cardinal = 0) : IQuery;
    procedure Commit;
    procedure Rollback;
    procedure Connect;
    procedure Disconnect;
    procedure StartTransaction;
    procedure SetAfterStartTransaction(const AValue: TNotifyConnEvent);
    function GetAfterStartTransaction: TNotifyConnEvent;
    procedure SetAfterCommit(const AValue: TNotifyConnEvent);
    function GetAfterCommit: TNotifyConnEvent;
    procedure SetAfterRollback(const AValue: TNotifyConnEvent);
    function GetAfterRollback: TNotifyConnEvent;
    property AfterStartTransaction: TNotifyConnEvent read GetAfterStartTransaction write SetAfterStartTransaction;
    property AfterCommit: TNotifyConnEvent read GetAfterCommit write SetAfterCommit;
    property AfterRollback: TNotifyConnEvent read GetAfterRollback write SetAfterRollback;
  End;

implementation

end.
