unit untMaplinkJobs;

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

  TMaplinkJobs = class
  private
    FCreatedAt: Extended;
    FError: String;
    FId: String;
    FPercent: String;
    FStatus: String;
    FStep: String;
    FType: String;
  public
    property createdAt: Extended read FCreatedAt write FCreatedAt;
    property error: String read FError write FError;
    property id: String read FId write FId;
    property percent: String read FPercent write FPercent;
    property status: String read FStatus write FStatus;
    property step: String read FStep write FStep;
    property &type: String read FType write FType;
    class function FromJsonString(AJsonString: string): TMaplinkJobs;
  end;

implementation

{ TMaplinkJobs }

class function TMaplinkJobs.FromJsonString(AJsonString: string): TMaplinkJobs;
begin
  Result := TJson.JsonToObject<TMaplinkJobs>(AJsonString);
end;

end.
