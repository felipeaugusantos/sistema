unit untGenericGravandoExecucaoArquivosInsertGravando;

interface

uses
  untGenericGravandoExecucaoArquivosInsert, DB, untIProcessadorGravandoExecucaoArquivosInsertGravando,
  untIGravando, Uni;

type
  TGenericGravandoExecucaoArquivosInsertGravando = class(TGenericGravandoExecucaoArquivosInsert)
  protected
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando); override;
  public
    constructor Create(const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivosInsertGravando); reintroduce;
  end;

implementation

{ TGenericGravandoExecucaoArquivosInsertGravando }

constructor TGenericGravandoExecucaoArquivosInsertGravando.Create(
  const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivosInsertGravando);
begin
  inherited Create(processadorGravandoExecucaoArquivos);
end;

procedure TGenericGravandoExecucaoArquivosInsertGravando.GravarRegistro(const qryOrigem, qryDestino: TDataSet; const gravando: IGravando);
var
  strSql: string;
begin
  if qryDestino is TUniQuery then
  begin
    strSql := TUniQuery(qryDestino).SQL.Text;
    TUniQuery(qryDestino).SQL.Clear;
    TUniQuery(qryDestino).Params.Clear;
    TUniQuery(qryDestino).SQL.Text := strSql;
  end;

  IProcessadorGravandoExecucaoArquivosInsertGravando(processadorGravandoExecucaoArquivos).GravarRegistro(qryOrigem, qryDestino, gravando);
end;

end.
