unit untGenericProcedureFormGravando;

interface

uses
  cxProgressBar, System.SysUtils, Vcl.Forms,

  untLibContaBancariaInterfacesTipos;

type
  TGenericProcedureFormGravando = class(TInterfacedObject)
  private
    genericProcedure: TGenericProcedure;
    genericFunctionProgresso: TReferenceFunctionProgresso;
  public
    function functionFormGravando(pgbProgresso: TcxProgressBar): Boolean;
    function functionFormGravandoProgresso(pgbProgresso: TcxProgressBar): Boolean;

    constructor Create(genericProcedure: TGenericProcedure); overload;
    constructor Create(genericFunctionProgresso: TReferenceFunctionProgresso); overload;
  end;


implementation

{ TGenericProcedureFormGravando }

constructor TGenericProcedureFormGravando.Create(genericProcedure: TGenericProcedure);
begin
  inherited Create();
  Self.genericProcedure := genericProcedure;
end;

constructor TGenericProcedureFormGravando.Create(
  genericFunctionProgresso: TReferenceFunctionProgresso);
begin
  inherited Create();
  Self.genericFunctionProgresso := genericFunctionProgresso;
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

      on E: Exception do
        Raise Exception.Create(E.Message);

    End;
  Finally
  End;
end;

function TGenericProcedureFormGravando.functionFormGravandoProgresso(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := False;
  Try
    Try
      Application.ProcessMessages;
      Result := genericFunctionProgresso(pgbProgresso);
      Application.ProcessMessages;
    Except
      on E: Exception do
        Raise Exception.Create(E.Message);

      on E: Exception do
        Raise Exception.Create(E.Message);

    End;
  Finally
  End;
end;

end.
