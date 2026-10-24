unit untCitelNominatimSearchApi;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, DateUtils, System.Variants,
  System.JSON, strUtils, System.Classes, Math,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.Forms, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

  TAddressClass = class
  private
    FCity: String;
    FCountry: String;
    FCountry_code: String;
    FMunicipality: String;
    FNeighbourhood: String;
    FPostcode: String;
    FRegion: String;
    FRoad: String;
    FState: String;
    FState_district: String;
    FSuburb: String;
  public
    property city: String read FCity write FCity;
    property country: String read FCountry write FCountry;
    property country_code: String read FCountry_code write FCountry_code;
    property municipality: String read FMunicipality write FMunicipality;
    property neighbourhood: String read FNeighbourhood write FNeighbourhood;
    property postcode: String read FPostcode write FPostcode;
    property region: String read FRegion write FRegion;
    property road: String read FRoad write FRoad;
    property state: String read FState write FState;
    property state_district: String read FState_district write FState_district;
    property suburb: String read FSuburb write FSuburb;
  end;

  TItemClass = class
  private
    FAddress: TAddressClass;
    FAddresstype: String;
    FBoundingbox: TArray<String>;
    FClass: String;
    FDisplay_name: String;
    FImportance: Extended;
    FLat: String;
    FLicence: String;
    FLon: String;
    FName: String;
    FOsm_id: Extended;
    FOsm_type: String;
    FPlace_id: Extended;
    FPlace_rank: Extended;
    FType: String;
  public
    property address: TAddressClass read FAddress write FAddress;
    property addresstype: String read FAddresstype write FAddresstype;
    property boundingbox: TArray<String> read FBoundingbox write FBoundingbox;
    property &class: String read FClass write FClass;
    property display_name: String read FDisplay_name write FDisplay_name;
    property importance: Extended read FImportance write FImportance;
    property lat: String read FLat write FLat;
    property licence: String read FLicence write FLicence;
    property lon: String read FLon write FLon;
    property name: String read FName write FName;
    property osm_id: Extended read FOsm_id write FOsm_id;
    property osm_type: String read FOsm_type write FOsm_type;
    property place_id: Extended read FPlace_id write FPlace_id;
    property place_rank: Extended read FPlace_rank write FPlace_rank;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TCitelNominatimSearchApi = class
  private
    FItems: TArray<TItemClass>;

    class procedure pGravaCoordenadasNaENTCLI(cdsEnderecos: TUniClientDataSet);

    class function fPossibilidadeEnderecoDivergente(const strCidadeRetornada, strCidadeSolicitada: String): Boolean;

    class function fPreparaComparacaoCidade(strCidade: String): String;

    class function fAnalisaCoordenadas(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;

    class function fRetCoordenadas(AEndereco, ABairro: String): TCitelNominatimSearchApi;
  public
    property Items: TArray<TItemClass> read FItems write FItems;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TCitelNominatimSearchApi;

    class function fRetCoordenadasDosEnderecos(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
  end;

implementation

uses untCitelNominatimRestApi, untRestApi;

{TItemClass}

constructor TItemClass.Create;
begin
  inherited;
  FAddress := TAddressClass.Create();
end;

destructor TItemClass.Destroy;
begin
  FAddress.free;
  inherited;
end;

{TCitelNominatimSearchApi}

destructor TCitelNominatimSearchApi.Destroy;
var
  LItemsItem: TItemClass;
begin

 for LItemsItem in FItems do
   LItemsItem.free;

  inherited;
end;

class function TCitelNominatimSearchApi.FromJsonString(AJsonString: string): TCitelNominatimSearchApi;
begin
  result := TJson.JsonToObject<TCitelNominatimSearchApi>('{ "Items": '+AJsonString+'}');
end;

class procedure TCitelNominatimSearchApi.pGravaCoordenadasNaENTCLI(cdsEnderecos: TUniClientDataSet);
var
  qryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

  strNomTbl,
  strNomTblAux: String;
begin
  if (cdsEnderecos.FieldByName('GER_FILIAL').AsString <> 'S') and
     (cdsEnderecos.FieldByName('GER_ESPDOC').AsString = 'OX') then
    Exit;

  if cdsEnderecos.FieldByName('GER_ALTEND').AsString = 'S' then
    Exit;

  qryAux := fCriaQuery;
  try
    if cdsEnderecos.FieldByName('GER_FILIAL').AsString <> 'S' then
    begin
      strNomTbl    := cdsEnderecos.FieldByName('GER_NOMTBL').AsString;
      strNomTblAux := AnsiReplaceStr(strNomTbl, 'FATGOR', 'AUXGOR');
      strNomTblAux := AnsiReplaceStr(strNomTblAux, 'MOVGER', 'AUXMOV');
      strNomTblAux := AnsiReplaceStr(strNomTblAux, 'NOTGER', 'AUXNOT');

      qryAux.Close;
      qryAux.SQL.Text :=
      ' UPDATE '+
      '   ENTCLI '+
      ' SET '+
      '   ETC_LATLON = :LATLON '+
      ' WHERE '+
      '   AUTOINCREM = ( SELECT '+
      '                    AUX_ENTGER '+
      '                  FROM '+
                           strNomTbl+
      '                  INNER JOIN '+strNomTblAux+
      '                    ON '+strNomTbl+'.AUTOINCREM = '+strNomTblAux+'.AUX_SEQGER '+
      '                  WHERE '+
                           strNomTbl+'.AUTOINCREM = :AUTINC ) ';

      qryAux.ParamByName('LATLON').AsString := cdsEnderecos.FieldByName('GER_LATLON').AsString;
      qryAux.ParamByName('AUTINC').AsString := cdsEnderecos.FieldByName('GER_AUTINC').AsString;
      qryAux.ExecSQL;
    end
    else
    begin
      qryAux.Close;
      qryAux.SQL.Text :=
      ' UPDATE '+
      '   CADEMP '+
      ' SET '+
      '   EMP_LATLON = :LATLON '+
      ' WHERE '+
      '   EMP_CODEMP = :CODEMP ';

      qryAux.ParamByName('LATLON').AsString := cdsEnderecos.FieldByName('GER_LATLON').AsString;
      qryAux.ParamByName('CODEMP').AsString := cdsEnderecos.FieldByName('GER_CODEMP').AsString;
      qryAux.ExecSQL;
    end;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryAux);
    {$ENDIF LINUX}
  end;
end;

class function TCitelNominatimSearchApi.fPreparaComparacaoCidade(strCidade: String): String;
begin
  Result := Trim(strCidade);
  Result := AnsiReplaceStr(strCidade, '-', '');
  Result := fTiraEspacos(Result);
  Result := fRemoveAcento(Result);
  Result := UpperCase(Result);
end;

class function TCitelNominatimSearchApi.fPossibilidadeEnderecoDivergente(const strCidadeRetornada, strCidadeSolicitada: String): Boolean;
var
  blnCidadeRetornadaEstaDivergente: Boolean;
begin
  Result := False;

  if (fEmptyStr(AnsiReplaceStr(strCidadeSolicitada, '-', ''))) or (fEmptyStr(strCidadeRetornada)) then
    Exit;

  blnCidadeRetornadaEstaDivergente := IIF(fEmptyStr(AnsiReplaceStr(strCidadeSolicitada, '-', '')), False, True);

  if blnCidadeRetornadaEstaDivergente then
    blnCidadeRetornadaEstaDivergente := not (fPreparaComparacaoCidade(strCidadeRetornada) = fPreparaComparacaoCidade(strCidadeSolicitada));

  if (blnCidadeRetornadaEstaDivergente) or (fEmptyStr(strCidadeSolicitada)) then
    Exit(True);
end;

class function TCitelNominatimSearchApi.fAnalisaCoordenadas(
  cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
var
  strDocs: String;
begin
  strDocs := EmptyStr;

  cdsEnderecos.First;
  while not cdsEnderecos.Eof do
  begin
    if fEmptyStr(cdsEnderecos.FieldByName('GER_LATLON').AsString) then
      strDocs := strDocs + cdsEnderecos.FieldByName('GER_NUMDOC').AsString +'-'+
                           cdsEnderecos.FieldByName('GER_ESPDOC').AsString +'-'+
                           cdsEnderecos.FieldByName('GER_CODEMP').AsString +sLineBreak;

    cdsEnderecos.Next;
  end;

  Result := fEmptyStr(strDocs);

  if not Result then
    strMsgRetorno := 'Não foi possível localizar o endereço do(s) documentos(s) abaixo:'+sLineBreak+
                     strDocs+sLineBreak+
                     'Por favor, revise o(s) endereço(s) de entrega e tente novamente!';
end;

class function TCitelNominatimSearchApi.fRetCoordenadasDosEnderecos(
  cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
var
  CitelNominatimSearchApi: TCitelNominatimSearchApi;
  blnPossibilidadeEnderecoDivergente: Boolean;
begin
  try
    cdsEnderecos.First;
    while not cdsEnderecos.Eof do
    begin
      if (not fEmptyStr(cdsEnderecos.FieldByName('GER_LATLON').AsString)) and
         (cdsEnderecos.FieldByName('GER_LATLON').AsString <> '0,0') and
         (cdsEnderecos.FieldByName('GER_ALTEND').AsString = 'N') then
      begin
        cdsEnderecos.Next;
        Continue;
      end;

      CitelNominatimSearchApi := fRetCoordenadas(cdsEnderecos.FieldByName('GER_ENDCON').AsString+' '+
                                                 cdsEnderecos.FieldByName('GER_BAIRRO').AsString+' '+
                                                 cdsEnderecos.FieldByName('GER_NOMCID').AsString+'-'+
                                                 cdsEnderecos.FieldByName('GER_ESTADO').AsString,
                                                 cdsEnderecos.FieldByName('GER_BAIRRO').AsString);
      try
        if not Assigned(CitelNominatimSearchApi.Items) then
        begin
          cdsEnderecos.Next;
          Continue;
        end
        else
        begin
          if (Assigned(CitelNominatimSearchApi.Items)) and
             (Length(CitelNominatimSearchApi.Items) <= 0) then
          begin
            cdsEnderecos.Next;
            Continue;
          end;
        end;

        if (fEmptyStr(CitelNominatimSearchApi.Items[0].lat)) and (fEmptyStr(CitelNominatimSearchApi.Items[0].lon)) then
        begin
          cdsEnderecos.Next;
          Continue;
        end;

        cdsEnderecos.Edit;
        cdsEnderecos.FieldByName('GER_LATLON').AsString := AnsiReplaceStr(CitelNominatimSearchApi.Items[0].lat, ',', '.') +','+
                                                           AnsiReplaceStr(CitelNominatimSearchApi.Items[0].lon, ',', '.');

        blnPossibilidadeEnderecoDivergente := fPossibilidadeEnderecoDivergente(CitelNominatimSearchApi.Items[0].address.city,
                                                                               cdsEnderecos.FieldByName('GER_NOMCID').AsString);

        cdsEnderecos.FieldByName('GER_LOCALI').AsString := IIF(not blnPossibilidadeEnderecoDivergente, '', 'OK?');

        cdsEnderecos.Post;

        if not blnPossibilidadeEnderecoDivergente then
          pGravaCoordenadasNaENTCLI(cdsEnderecos);

        cdsEnderecos.Next;
      finally
        FreeAndNil(CitelNominatimSearchApi);
      end;

    end;

    Result := fAnalisaCoordenadas(cdsEnderecos, strMsgRetorno);

  except
    on E: Exception do
    begin
      if fEmptyStr(strMsgRetorno) then
        strMsgRetorno := 'Ocorreram erros ao obter as coordenadas dos endereços!';

      Result := False;

      {$IFNDEF LINUX}
      pMensagensErro(E.Message, 'TControllerMaplinkMultiGeocode.fRetCoordenadasDosEnderecos');
      {$ENDIF LINUX}
    end;
  end;
end;

class function TCitelNominatimSearchApi.fRetCoordenadas(AEndereco, ABairro: String): TCitelNominatimSearchApi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
  intTentativa: Integer;
begin
  Result := nil;
  intTentativa := 0;

  ControllerRest := TControllerRest.Create('CITEL_NOMINATIM', TCitelNominatimRestApi.fConfigurarCitelNominatim);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'search?q='+AEndereco;
    RestRequest.Params.AddItem('format', 'json', pkGETorPOST);
    RestRequest.Params.AddItem('limit', '1', pkGETorPOST);
    RestRequest.Params.AddItem('addressdetails', '1', pkGETorPOST);
    RestRequest.Method := rmGET;

    repeat
      if intTentativa = 1 then
        RestRequest.Resource := 'search?q='+AnsiReplaceStr(AEndereco, ABairro, '');

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
        Result := TCitelNominatimSearchApi.FromJsonString(JSONRetorno);

      if (not Assigned(Result.Items)) or
         ((Assigned(Result.Items)) and (Length(Result.Items) <= 0)) then
       Inc(intTentativa);

    until ((Assigned(Result.Items)) and (Length(Result.Items) > 0)) or (intTentativa = 2);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
