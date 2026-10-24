unit untGenericGravandoExecucaoArquivosInsert;

interface

uses
  untIProcessadorGravandoExecucaoArquivosInsert, Uni, untGenericGravandoExecucaoArquivos,
  DB, untIGravando;

type
  TGenericGravandoExecucaoArquivosInsert = class(TGenericGravandoExecucaoArquivos)
  protected
    function GetDataSetDestino(): TUniQuery; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando); override;
  public
    constructor Create(const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivosInsert); reintroduce;
  end;


implementation

uses
  untFuncoesSimples;

{ TGenericGravandoExecucaoArquivosInsert }

constructor TGenericGravandoExecucaoArquivosInsert.Create(
  const processadorGravandoExecucaoArquivos: IProcessadorGravandoExecucaoArquivosInsert);
begin
  inherited Create(processadorGravandoExecucaoArquivos);
end;

function TGenericGravandoExecucaoArquivosInsert.GetDataSetDestino: TUniQuery;
begin
  Result := fCriaQuery();
  Result.SQL.Text := processadorGravandoExecucaoArquivos.GetSqlDestino;
end;

procedure TGenericGravandoExecucaoArquivosInsert.GravarRegistro(const qryOrigem, qryDestino: TDataSet; const gravando: IGravando);
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

  inherited GravarRegistro(qryOrigem, qryDestino, gravando);
end;

end.

