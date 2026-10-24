unit untGenericProcedureFormGravando;

interface

uses
  untConstantes, cxProgressBar, SysUtils, Forms, untFuncoes;

type
  TGenericProcedureFormGravando = class(TInterfacedObject)
  private
    genericProcedure: TGenericProcedure;
  public
    function functionFormGravando(pgbProgresso: TcxProgressBar): Boolean;
    constructor Create(genericProcedure: TGenericProcedure);
  end;


implementation

{ TGenericProcedureFormGravando }

constructor TGenericProcedureFormGravando.Create(genericProcedure: TGenericProcedure);
begin
  inherited Create();
  Self.genericProcedure := genericProcedure;
end;

function TGenericProcedureFormGravando.functionFormGravando(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  Try
    Try
      Application.ProcessMessages;
      genericProcedure;
      Application.ProcessMessages;
      Result := True;
    Except
      on E: Exception do
        Raise Exception.Create(E.Message);

    End;
  Finally
  End;                            
end;

end.
