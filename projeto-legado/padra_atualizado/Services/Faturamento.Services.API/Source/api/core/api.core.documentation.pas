unit api.core.documentation;

interface

uses
  MVCFramework.Swagger.Commons;

type
  TApiDocumentation = class sealed(TObject)
  public
    class function GetHeaderInformation(const pVersion: string): TMVCSwaggerInfo;
  end;

implementation

{ TApiDocumentation }

class function TApiDocumentation.GetHeaderInformation(const pVersion: string): TMVCSwaggerInfo;
begin
  Result.Title := 'Faturamento Services API (AUTCOM)';
  Result.Version := pVersion;
  Result.Description := 'Server API Documentation';
  Result.ContactUrl := 'https://www.citelsoftware.com.br';
end;

end.
