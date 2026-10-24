unit untProcessaIntelipost;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type
  TIntelipost = class sealed(TInterfacedObject, {$IFDEF LINUX}ITaskMonitorProcedure {$ELSE}IMonitorProcedure{$ENDIF LINUX})
  private
    procedure pEnvarPedidoIntelipost;
  public
    procedure pExecute;
    procedure pExecuteAll;
    function fExecute : TResultExecute;
  end;

implementation

{ TIntelipost }

uses untIntelipost.ShipmentOrder;

procedure TIntelipost.pExecute;
begin
  inherited;
  pEnvarPedidoIntelipost;
end;

procedure TIntelipost.pExecuteAll;
begin
  if not fCfgSis('ITPUTI', varBoolean) then
    Exit;

  pEnvarPedidoIntelipost;
end;

function TIntelipost.fExecute: TResultExecute;
begin

end;

procedure TIntelipost.pEnvarPedidoIntelipost;
var
  qryPedido: {$IFNDEF LINUX} TUniQuery {$ELSE} IQuery {$ENDIF LINUX};
  strMsgRetorno: String;
begin
  qryPedido := fCriaQuery;
  try
    qryPedido.Close;
    qryPedido.SQL.Text :=
    ' SELECT '+
    '   ITP_SEQFGO '+
    ' FROM '+
    '   INTPOS '+
    ' WHERE '+
    '   ITP_PEDENV = "N" AND '+
    '   ITP_CODEMP = :CODEMP ';

    qryPedido.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryPedido.Open;

    qryPedido.First;
    while not qryPedido.Eof do
    begin
      TIntelipostShipmentOrder.fEnviarPedidoIntelipost(qryPedido.FieldByName('ITP_SEQFGO').AsString, strMsgRetorno, False);
      qryPedido.Next;
    end;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryPedido);
    {$ENDIF LINUX}
  end;
end;

end.
