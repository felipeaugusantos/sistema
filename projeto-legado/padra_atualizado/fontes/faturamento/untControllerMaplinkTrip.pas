unit untControllerMaplinkTrip;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, DateUtils, System.Variants,
  System.JSON, strUtils, System.Classes, Math,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.Forms, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni, untMaplinkIDRetorno, untMaplinkJobs, untMaplinkTripClasses;

type
  TControllerMaplinkTrip = class
  private
    class function fProblem(MaplinkTrip: TMaplinkTrip): TRetornoMaplinkTrip;
    class function fSolutions(strId: String): TRetornoMaplinkTrip;
    class function fProblemEstaSendoSolucionado(strId: String): Boolean;
    class function fJobs(strId: String): TMaplinkJobs;
  public
    class function fRetPoints(arrWayPoints: TArray<String>; arrAvoidanceTypes: TArray<String>; strCalculationMode: String): TRetornoMaplinkTrip;
    class function fRetPointsArray(arrWayPoints: TArray<String>; arrAvoidanceTypes: TArray<String>; strCalculationMode: String): TArray<TArray<String>>;
  end;


implementation

uses untRestApi, untMaplinkRestApi, untTypesSistema, untMapsDistanceMatrix;

{ TControllerMaplinkTrip }

class function TControllerMaplinkTrip.fRetPoints(arrWayPoints: TArray<String>; arrAvoidanceTypes: TArray<String>;
  strCalculationMode: String): TRetornoMaplinkTrip;
var
  MaplinkTrip: TMaplinkTrip;
  intCount: Integer;
begin
  if fEmptyStr(strCalculationMode) then
    strCalculationMode := 'THE_FASTEST';

  MaplinkTrip := TMaplinkTrip.Create;
  try
    MaplinkTrip.calculationMode := strCalculationMode;
    MaplinkTrip.avoidanceTypes := arrAvoidanceTypes;
    for intCount := Low(arrWayPoints) to High(arrWayPoints) do
    begin
      MaplinkTrip.pAddPoint(TPointsSend.fNew()
                              .f_siteId(IntToStr(intCount))
                              .f_latitude(TControllerMapsDistanceMatrix.fRetCoordenadaExtended(arrWayPoints[intCount], coorLat))
                              .f_longitude(TControllerMapsDistanceMatrix.fRetCoordenadaExtended(arrWayPoints[intCount], coorLon)));
    end;

    Result := fProblem(MaplinkTrip);
  finally
    FreeAndNil(MaplinkTrip);
  end;
end;

class function TControllerMaplinkTrip.fRetPointsArray(arrWayPoints: TArray<String>; arrAvoidanceTypes: TArray<String>; strCalculationMode: String): TArray<TArray<String>>;
var
  MaplinkTrip: TMaplinkTrip;
  intCount: Integer;

  RetornoMaplinkTrip: TRetornoMaplinkTrip;
  Leg: TLegsClass;
  Point: TPoints;
begin
  if fEmptyStr(strCalculationMode) then
    strCalculationMode := 'THE_FASTEST';

  MaplinkTrip := TMaplinkTrip.Create;
  try
    MaplinkTrip.calculationMode := strCalculationMode;
    MaplinkTrip.avoidanceTypes := arrAvoidanceTypes;
    for intCount := Low(arrWayPoints) to High(arrWayPoints) do
    begin
      MaplinkTrip.pAddPoint(TPointsSend.fNew()
                              .f_siteId(IntToStr(intCount))
                              .f_latitude(TControllerMapsDistanceMatrix.fRetCoordenadaExtended(arrWayPoints[intCount], coorLat))
                              .f_longitude(TControllerMapsDistanceMatrix.fRetCoordenadaExtended(arrWayPoints[intCount], coorLon)));
    end;

    RetornoMaplinkTrip := fProblem(MaplinkTrip);
    if not Assigned(RetornoMaplinkTrip) then
      Exit;

    try
      for Leg in RetornoMaplinkTrip.legs do
      begin
        for Point in Leg.points do
        begin
          SetLength(Result, Length(Result)+1);
          SetLength(Result[Length(Result)-1], 2);

          Result[Length(Result)-1][0] := FloatToStr(Point.latitude);
          Result[Length(Result)-1][1] := FloatToStr(Point.longitude);
        end;
      end;
    finally
      FreeAndNil(RetornoMaplinkTrip);
    end;
  finally
    FreeAndNil(MaplinkTrip);
  end;
end;

class function TControllerMaplinkTrip.fProblem(MaplinkTrip: TMaplinkTrip): TRetornoMaplinkTrip;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  IdRetornoMaplinkTrip: TMaplinkIDRetorno;

  JSONRetorno: String;
begin
  Result := nil;
  IdRetornoMaplinkTrip := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'trip/v1/problems';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               MaplinkTrip.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '201']) then
    begin
      IdRetornoMaplinkTrip := TMaplinkIDRetorno.FromJsonString(JSONRetorno);
      Result := TControllerMaplinkTrip.fSolutions(IdRetornoMaplinkTrip.id);
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;

    if Assigned(IdRetornoMaplinkTrip) then
      IdRetornoMaplinkTrip.Free;
  end;

end;

class function TControllerMaplinkTrip.fSolutions(strId: String): TRetornoMaplinkTrip;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'trip/v1/solutions/'+strId;
    RestRequest.Method := rmGET;

    repeat

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      begin
        Result := TRetornoMaplinkTrip.FromJsonString(JSONRetorno);
        Break;
      end;

      Sleep(5000);
      {$IFNDEF LINUX}
      Application.ProcessMessages;
      {$ENDIF LINUX}

      if not fProblemEstaSendoSolucionado(strId) then
        Break;

    until RestRequest.Response.StatusCode <> 404;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TControllerMaplinkTrip.fProblemEstaSendoSolucionado(
  strId: String): Boolean;
var
  RetornoMaplinkTripJobs: TMaplinkJobs;
begin
  Result := True;

  RetornoMaplinkTripJobs := fJobs(strId);
  if Assigned(RetornoMaplinkTripJobs) then
  begin
    Result := not (RetornoMaplinkTripJobs.&type = 'ERROR');
  end;
end;

class function TControllerMaplinkTrip.fJobs(strId: String): TMaplinkJobs;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'trip/v1/jobs/'+strId;
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TMaplinkJobs.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
