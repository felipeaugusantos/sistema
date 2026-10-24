unit untIProcessadorGravandoExecucaoArquivosInsertGravando;

interface

uses
  untIProcessadorGravandoExecucaoArquivosInsert, DB, untIGravando;

type
  IProcessadorGravandoExecucaoArquivosInsertGravando = interface(IProcessadorGravandoExecucaoArquivosInsert)
    ['{D63C22B0-D7DD-493E-9830-B1CB75A9CBAB}']
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet; const gravando: IGravando);
  end;

implementation

end.
