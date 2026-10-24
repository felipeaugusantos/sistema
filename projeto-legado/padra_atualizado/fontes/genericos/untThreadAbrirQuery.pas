unit untThreadAbrirQuery;

interface

uses
  Classes, Uni, SysUtils;

type
  TThreadAbrirQuery = class(TThread)
  private
    conBanco: TUniConnection;
    qryGen: TUniQuery;
  protected
    procedure Execute; override;
  public
    constructor Create(const qryGen: TUniQuery); reintroduce;
    destructor Destroy; override;
    property Terminated;
    property DataSet: TUniQuery read qryGen;
  end;

implementation
uses untComponentHelper, untFuncoesSimples;
{ TThreadAbrirQuery }

constructor TThreadAbrirQuery.Create(const qryGen: TUniQuery);
begin
  inherited Create(False);
  conBanco := TUniConnection(qryGen.Connection.GetCopy);
  conBanco.Name := '';
  qryGen.InsertComponent(conBanco);
  Self.qryGen := qryGen;
  Self.qryGen.Connection := conBanco;
end;

destructor TThreadAbrirQuery.Destroy;
begin
  inherited;
end;

procedure TThreadAbrirQuery.Execute;
begin
  pLog('TThreadAbrirQuery.Execute');
  Try
    Try
      qryGen.DisableControls;
      qryGen.Open;
      qryGen.Last;
      qryGen.First;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    qryGen.EnableControls;
    Terminate;
  End;
end;

end.
