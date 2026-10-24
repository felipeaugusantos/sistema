unit untRennerProcessadorGravandoFactory;

interface

uses untGenericGravando;

type
  TRennerProcessadorGravandoFactory = class(TInterfacedObject)
  public
    class function GetArrayGravando: TArrayGravandoExecucao;
  end;

implementation
uses untProcessadorGravandoExecucaoArquivosRennerBases,
  untProcessadorGravandoExecucaoArquivosRennerColorantes,
  untProcessadorGravandoExecucaoArquivosRennerCores,
  untGravandoFactory, untGenericGravandoExecucaoArquivos,
  untGenericGravandoExecucaoArquivosInsert;
{ TRennerProcessadorGravandoFactory }

class function TRennerProcessadorGravandoFactory.GetArrayGravando: TArrayGravandoExecucao;
begin
  Result := TGravandoFactory.ArrayToTArrayGravandoExecucao([
    TGenericGravandoExecucaoArquivos.Create(TProcessadorGravandoExecucaoArquivosRennerBases.Create),
    TGenericGravandoExecucaoArquivos.Create(TProcessadorGravandoExecucaoArquivosRennerColorantes.Create),
    TGenericGravandoExecucaoArquivosInsert.Create(TProcessadorGravandoExecucaoArquivosRennerCores.Create)
  ])
end;

end.
