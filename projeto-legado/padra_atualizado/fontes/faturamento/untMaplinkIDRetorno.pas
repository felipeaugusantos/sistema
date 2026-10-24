unit untMaplinkIDRetorno;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, DateUtils, System.Variants,
  System.JSON, strUtils, System.Classes, Math,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  REST.Client, Vcl.Forms, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

  TMaplinkIDRetorno = class
  private
    FId: String;
  public
    property id: String read FId write FId;
    class function FromJsonString(AJsonString: string): TMaplinkIDRetorno;
  end;

implementation

{ TMaplinkIDRetorno }

class function TMaplinkIDRetorno.FromJsonString(
  AJsonString: string): TMaplinkIDRetorno;
begin
  Result := TJson.JsonToObject<TMaplinkIDRetorno>(AJsonString);
end;

end.
