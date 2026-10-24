unit DominioSistemas.Service.ConsultasEspecificas;

interface

uses
  DominioSistemas.Core.ConsultaInterface, DominioSistemas.Core.ApiClientInterface ;

type
  TConsultasEspecificas = class(TInterfacedObject, IConsultaProtocolo, IConsultaAtivacao)
  public
    function fProcessamento(const AApi: IApiClient; const AProtocolo: String): String;
    function fInformacao(const AApi: IApiClient): TInfoAtivacao;
    function fGerarIntegrationKeyApp(const AApi: IApiClient): String ;
  end ;

implementation

uses
  System.JSON, System.SysUtils ;

{ TConsultasEspecificas }

function TConsultasEspecificas.fGerarIntegrationKeyApp(const AApi: IApiClient): String;
var
  LRetornoJson: String ;
  LRetorno: TJSONObject ;
begin
  LRetornoJson := AApi.fGerarIntegrationKeyApp('/integration/v1/activation/enable') ;
  LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LRetornoJson), 0) as TJSONObject ;
  try
    Result := LRetorno.GetValue<String>('integrationKey', EmptyStr);
  finally
    FreeAndNil(LRetorno) ;
  end ;
end;

function TConsultasEspecificas.fInformacao(const AApi: IApiClient): TInfoAtivacao;
var
  LRetornoJson: String ;
  LRetorno: TJSONObject ;
begin
  FillChar(Result, SizeOf(TInfoAtivacao), #0);
  LRetornoJson := AApi.fGetAtivacaoInfo('/integration/v1/activation/info') ;
  LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LRetornoJson), 0) as TJSONObject ;
  try
    Result.accountantOfficeName := LRetorno.GetValue<String>('accountantOfficeName') ;
    Result.accountantOfficeNationalIdentity := LRetorno.GetValue<String>('accountantOfficeNationalIdentity') ;
    Result.clientName := LRetorno.GetValue<String>('clientName') ;
    Result.clientNationalIdentity := LRetorno.GetValue<String>('clientNationalIdentity') ;
  finally
    FreeAndNil(LRetorno) ;
  end ;
end;

function TConsultasEspecificas.fProcessamento(const AApi: IApiClient; const AProtocolo: String): String;
begin
  Result := AApi.fGetDocumentoStatus('/invoice/v3/batches', AProtocolo);
end;

end.
