unit untCatalagoFraga.VehicleByPlate;

interface

uses Generics.Collections, Rest.Json, System.SysUtils, System.StrUtils, System.Net.HttpClient, System.Net.URLClient, System.Classes, Uni, untConstantes;

type

  TModelsClass = class
  private
    FEngines: TArray<String>;
    FName: String;
  public
    property engines: TArray<String> read FEngines write FEngines;
    property name: String read FName write FName;
  end;

  TVehicleByPlateClass = class
  private
    FBrand: String;
    FColor: String;
    FMadeYear: Integer;
    FModelYear: Integer;
    FModels: TArray<TModelsClass>;
    FPlate: String;
  public
    property brand: String read FBrand write FBrand;
    property color: String read FColor write FColor;
    property madeYear: Integer read FMadeYear write FMadeYear;
    property modelYear: Integer read FModelYear write FModelYear;
    property models: TArray<TModelsClass> read FModels write FModels;
    property plate: String read FPlate write FPlate;
    destructor Destroy; override;
  end;

  TDataClass = class
  private
    FVehicleByPlate: TVehicleByPlateClass;
  public
    property vehicleByPlate: TVehicleByPlateClass read FVehicleByPlate write FVehicleByPlate;
    constructor Create;
    destructor Destroy; override;
  end;

  TLocationsClass = class
  private
    FColumn: Extended;
    FLine: Extended;
  public
    property column: Extended read FColumn write FColumn;
    property line: Extended read FLine write FLine;
  end;

  TErrorsClass = class
  private
    FLocations: TArray<TLocationsClass>;
    FMessage: String;
    FPath: TArray<String>;
  public
    property locations: TArray<TLocationsClass> read FLocations write FLocations;
    property message: String read FMessage write FMessage;
    property path: TArray<String> read FPath write FPath;
    destructor Destroy; override;
  end;

  TFragaVehicleByPlate = class
  private
    FData: TDataClass;
    FErrors: TArray<TErrorsClass>;

    class procedure pGravaLog(strParam, strRecurs, strResult: String; intStatus: Integer);
    class function fRetQueryGraphQL(const AstrPlaca: String): String;
    class function fRetornouErro(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
    class function fRetornouDadosGerais(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
    class function fRetornouDadosModelo(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
    class function fVehicleByPlate(const AstrPlaca: String): TFragaVehicleByPlate;
    class function fRetPlaVei(const AstrPlaca: String; out AstrMarca, AstrModelo, AstrAno: String): Boolean;
    class procedure pGravaPlaVei(const AstrPlaca: String; const AstrMarca, AstrModelo, AstrAno: String);
  public
    property data: TDataClass read FData write FData;
    property errors: TArray<TErrorsClass> read FErrors write FErrors;

    constructor Create;
    destructor Destroy; override;

    class function FromJsonString(AJsonString: string): TFragaVehicleByPlate;

    class procedure pRetVeiculoPorPlaca(const AstrPlaca: String; out AstrMarca, AstrModelo, AstrAno: String);
  end;

implementation

uses
  untFuncoesSimples, untRestApi, untCatalogoFragaRestApi,
  untTokenCatalogoFraga, untGravando;

{TVehicleByPlateClass}

destructor TVehicleByPlateClass.Destroy;
var
  LmodelsItem: TModelsClass;
begin

 for LmodelsItem in FModels do
   LmodelsItem.free;

  inherited;
end;

{TDataClass}

constructor TDataClass.Create;
begin
  inherited;
  FVehicleByPlate := TVehicleByPlateClass.Create();
end;

destructor TDataClass.Destroy;
begin
  FVehicleByPlate.free;
  inherited;
end;

{ TErrorsClass }

destructor TErrorsClass.Destroy;
var
  LlocationsItem: TLocationsClass;
begin

 for LlocationsItem in FLocations do
   LlocationsItem.free;

  inherited;
end;


{TFragaVehicleByPlate}

constructor TFragaVehicleByPlate.Create;
begin
  inherited;
  FData := TDataClass.Create();
end;

destructor TFragaVehicleByPlate.Destroy;
var
  Error: TErrorsClass;
begin
  FData.free;

  for Error in FErrors do
    Error.Free;

  SetLength(FErrors, 0);
  inherited;
end;

class function TFragaVehicleByPlate.FromJsonString(AJsonString: string): TFragaVehicleByPlate;
begin
  result := TJson.JsonToObject<TFragaVehicleByPlate>(AJsonString)
end;

class procedure TFragaVehicleByPlate.pRetVeiculoPorPlaca(
  const AstrPlaca: String; out AstrMarca, AstrModelo, AstrAno: String);
var
  FragaVehicleByPlate: TFragaVehicleByPlate;
begin
  AstrMarca := EmptyStr;
  AstrModelo := EmptyStr;
  AstrAno := EmptyStr;

  if Length(AstrPlaca) < 7 then
  begin
    pMensagemOk('Placa Inválida!');
    Exit;
  end;

  if fRetPlaVei(AstrPlaca.ToUpper, AstrMarca, AstrModelo, AstrAno) then
    Exit;

  FragaVehicleByPlate := fVehicleByPlate(AstrPlaca.ToUpper);
  try
    if fRetornouErro(FragaVehicleByPlate) then
      Exit;

    if fRetornouDadosGerais(FragaVehicleByPlate) then
      AstrMarca := FragaVehicleByPlate.data.vehicleByPlate.brand;

    if fRetornouDadosModelo(FragaVehicleByPlate) then
      AstrModelo := FragaVehicleByPlate.data.vehicleByPlate.models[0].name;

    if fRetornouDadosGerais(FragaVehicleByPlate) then
      AstrAno := FragaVehicleByPlate.data.vehicleByPlate.madeYear.ToString;

    pGravaPlaVei(AstrPlaca.ToUpper, AstrMarca, AstrModelo, AstrAno);
  finally
    FreeAndNil(FragaVehicleByPlate);
  end;
end;

class function TFragaVehicleByPlate.fRetPlaVei(const AstrPlaca: String;
  out AstrMarca, AstrModelo, AstrAno: String): Boolean;
var
  qryPlaVei: TUniQuery;
begin
  Result := False;

  qryPlaVei := fCriaQuery;
  try
    qryPlaVei.Close;
    qryPlaVei.SQL.Text :=
    ' SELECT * FROM PLAVEI WHERE VEI_PLACA_ = :PLACA_ ';
    qryPlaVei.ParamByName('PLACA_').AsString := AstrPlaca;
    qryPlaVei.Open;

    if not qryPlaVei.IsEmpty then
    begin
      AstrMarca := qryPlaVei.FieldByName('VEI_MARCA_').AsString;
      AstrModelo := qryPlaVei.FieldByName('VEI_MODELO').AsString;
      AstrAno := qryPlaVei.FieldByName('VEI_A_N_O_').AsString;

      Result := True;
    end;
  finally
    FreeAndNil(qryPlaVei);
  end;
end;

class function TFragaVehicleByPlate.fRetornouErro(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
begin
  Result := False;

  if (Assigned(FragaVehicleByPlate)) and (Length(FragaVehicleByPlate.errors) > 0) then
  begin
    if FragaVehicleByPlate.errors[0].message = 'Plate invalid.' then
    begin
      pMensagemOk('Placa Inválida!');
      Exit(True);
    end;

    pMensagemOk('Não foi possível comunicar com a Api.'+ sLineBreak +
                'Erro: ' + FragaVehicleByPlate.errors[0].message);

    Exit(True);
  end;
end;

class function TFragaVehicleByPlate.fRetornouDadosGerais(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
begin
  Result := True;

  if not Assigned(FragaVehicleByPlate) then
    Exit(False);

  if not Assigned(FragaVehicleByPlate.data) then
    Exit(False);

  if not Assigned(FragaVehicleByPlate.data.vehicleByPlate) then
    Exit(False);
end;

class function TFragaVehicleByPlate.fRetornouDadosModelo(FragaVehicleByPlate: TFragaVehicleByPlate): Boolean;
begin
  Result := True;

  if not fRetornouDadosGerais(FragaVehicleByPlate) then
    Exit(False);

  if Length(FragaVehicleByPlate.data.vehicleByPlate.models) = 0 then
    Exit(False);
end;

class function TFragaVehicleByPlate.fVehicleByPlate(
  const AstrPlaca: String): TFragaVehicleByPlate;
var
  HTTP: THTTPClient;
  Resp: IHTTPResponse;
begin
  Result := nil;

  TTokenCatalogoFraga.pRefreshTokenFraga;

  if fEmptyStr(VS_strToken) then
  begin
    pMensagemOk('Não foi possível obter o token de acesso à api. Por favor, verifique as configurações "INTEGRAÇÃO DE SISTEMAS - CATÁLOGO FRAGA"!');
    Exit;
  end;

  HTTP := THTTPClient.Create;
  try
    HTTP.CustomHeaders['Authorization'] := 'Bearer ' + untTokenCatalogoFraga.VS_strToken;
    HTTP.CustomHeaders['Accept'] := 'application/json';
    HTTP.ContentType := 'application/json';

    Resp := HTTP.Post(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_URLFRA', VS_strCodEmp], True, EmptyStr),
                      TStringStream.Create(fRetQueryGraphQL(AstrPlaca), TEncoding.UTF8));

    pGravaLog(fRetQueryGraphQL(AstrPlaca), fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_URLFRA', VS_strCodEmp], True, EmptyStr), Resp.ContentAsString, Resp.StatusCode);

    if MatchStr(Resp.StatusCode.ToString, ['200', '400']) then
      Result := TFragaVehicleByPlate.FromJsonString(Resp.ContentAsString);
  finally
    HTTP.Free;
  end;
end;

// não funcionou com RESTCLIENT
{class function TFragaVehicleByPlate.fVehicleByPlate(
  const AstrPlaca: String): TFragaVehicleByPlate;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('FRAGA_CATALOGO', TCatalogoFragaRestApi.fConfigurarCatalogoFraga);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method := rmPOST;

    TTokenCatalogoFraga.pRefreshTokenFraga;

    if fEmptyStr(VS_strToken) then
    begin
      pMensagemOk('Não foi possível obter o token de acesso à api. Por favor, verifique as configurações "INTEGRAÇÃO DE SISTEMAS - CATÁLOGO FRAGA"!');
      Exit;
    end;

    RestRequest.Params.AddItem('Authorization', 'Bearer '+VS_strToken, pkHTTPHEADER);
    RESTRequest.AddParameter('Content-Type', 'application/json', pkHTTPHEADER, [poDoNotEncode]);
    RESTRequest.AddParameter('Accept', 'application/json', pkHTTPHEADER, [poDoNotEncode]);

    RESTRequest
    .Params
    .AddItem(  '',
               fRetQueryGraphQL(AstrPlaca),
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '400'], EmptyStr) then
      Result := TFragaVehicleByPlate.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;}

class function TFragaVehicleByPlate.fRetQueryGraphQL(const AstrPlaca: String): String;
begin
   Result :=
     ' { '+
     '   "query":  '+
     '     "query { '+
     '        vehicleByPlate(plate: \"'+AstrPlaca+'\") '+
     '        { '+
     '           plate '+
     '           brand '+
     '           color '+
     '           madeYear '+
     '           modelYear '+
     '           models { '+
     '             name '+
     '             engines '+
     '           } '+
     '        } '+
     '     }" '+
     ' } ';
end;

class procedure TFragaVehicleByPlate.pGravaLog(strParam, strRecurs, strResult: String; intStatus: Integer);
var
  qryLogAPI: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LstrColunasInsertWindows: String ;
  LstrParansInsertWindows: String ;
begin
 {$IFNDEF LINUX}
  pValidaProCod('LOGAPI');
  LstrColunasInsertWindows := ', LOG_NOMMAQ, LOG_CODEMP ' ;
  LstrParansInsertWindows := ', :NOMMAQ, :CODEMP ' ;
 {$ELSE }
  LstrColunasInsertWindows := '' ;
  LstrParansInsertWindows := '' ;
 {$ENDIF LINUX};

  qryLogAPI := fCriaQuery;
  try
    qryLogAPI.Close;
    qryLogAPI.SQL.Clear;
    qryLogAPI.SQL.Text :=
    STR_SQL_NAO_REPLICAR+
    ' INSERT INTO '+
    '   LOGAPI '+
    '  (AUTOINCREM, '+
    '   LOG_DTAENT, '+
    '   LOG_HORENT, '+
    '   LOG_RECURS, '+
    '   LOG_PARAME, '+
    '   LOG_RESULT, '+
    '   LOG_STATUS, '+
    '   LOG_LOGAPI  '+
    LstrColunasInsertWindows +
    '    )          '+
    ' VALUES '+
    '  (:AUTINC,    '+
    '   :DTAENT,    '+
    '   :HORENT,    '+
    '   :RECURS,    '+
    '   :PARAME,    '+
    '   :RESULT,    '+
    '   :STATUS,    '+
    '   :LOGAPI     '+
    LstrParansInsertWindows +
    '    )          ';

    qryLogAPI.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGAPI', VS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := fTime();

    qryLogAPI.ParamByName('RECURS').AsString  := strRecurs;
    qryLogAPI.ParamByName('PARAME').AsString  := strParam;
    qryLogAPI.ParamByName('RESULT').AsString  := strResult;
    qryLogAPI.ParamByName('STATUS').AsInteger := intStatus;
    qryLogAPI.ParamByName('LOGAPI').AsString  := 'FRAGA_CATALOGO';
    {$IFNDEF LINUX}
    qryLogAPI.ParamByName('NOMMAQ').AsString  := VS_ComputerNetName;
    qryLogAPI.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    {$ENDIF LINUX}
    qryLogAPI.ExecSQL;

  finally
   {$IFNDEF LINUX}
     qryLogAPI.Free;
   {$ENDIF LINUX}
  end;

end;

class procedure TFragaVehicleByPlate.pGravaPlaVei(const AstrPlaca, AstrMarca,
  AstrModelo, AstrAno: String);
var
  qryPlaVei: TUniQuery;
begin
  qryPlaVei := fCriaQuery;
  try
    qryPlaVei.Close;
    qryPlaVei.SQL.Text := ' REPLACE INTO PLAVEI (VEI_PLACA_, VEI_MARCA_, VEI_MODELO, VEI_A_N_O_) VALUES (:PLACA_, :MARCA_, :MODELO, :A_N_O_) ';
    qryPlaVei.ParamByName('PLACA_').AsString := AstrPlaca;
    qryPlaVei.ParamByName('MARCA_').AsString := AstrMarca;
    qryPlaVei.ParamByName('MODELO').AsString := AstrModelo;
    qryPlaVei.ParamByName('A_N_O_').AsString := AstrAno;
    qryPlaVei.ExecSQL;
  finally
    FreeAndNil(qryPlaVei);
  end;
end;

end.
