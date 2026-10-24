unit untMapsDistanceMatrix;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, untCitelOsrmTableApi,
  System.JSON, strUtils, Math, System.DateUtils, untMaplinkMatrixDistance,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, UniClientDataSet, Uni,
  {$ENDIF LINUX}
  untTypesSistema,
  Data.DB, MemDS, DBAccess;

type
  TOrder = (ordNone, ordFixed);

  TAvoid = (none ,tolls, highways, ferries);

  TDuration_in_trafficClass = class
  private
    FText: String;
    FValue: Extended;
  public
    property text: String read FText write FText;
    property value: Extended read FValue write FValue;
  end;

  TDurationClass = class
  private
    FText: String;
    FValue: Extended;
  public
    property text: String read FText write FText;
    property value: Extended read FValue write FValue;
  end;

  TDistanceClass = class
  private
    FText: String;
    FValue: Extended;
  public
    property text: String read FText write FText;
    property value: Extended read FValue write FValue;
  end;

  TElementsClass = class
  private
    FDistance: TDistanceClass;
    FDuration: TDurationClass;
    FDuration_in_traffic: TDuration_in_trafficClass;
    FStatus: String;
  public
    property distance: TDistanceClass read FDistance write FDistance;
    property duration: TDurationClass read FDuration write FDuration;
    property duration_in_traffic: TDuration_in_trafficClass read FDuration_in_traffic write FDuration_in_traffic;
    property status: String read FStatus write FStatus;
    constructor Create;
    destructor Destroy; override;

    class function fNew: TElementsClass;

    function f_distance(AValue: Extended): TElementsClass;
    function f_duration(AValue: Extended): TElementsClass;
    function f_duration_in_traffic(AValue: Extended): TElementsClass;
    function f_status(AValue: String): TElementsClass;
  end;

  TRowsClass = class
  private
    FElements: TArray<TElementsClass>;
  public
    property elements: TArray<TElementsClass> read FElements write FElements;
    destructor Destroy; override;
  end;

  TMapsDistanceMatrix = class
  private
    FDestination_addresses: TArray<String>;
    FOrigin_addresses: TArray<String>;
    FRows: TArray<TRowsClass>;
    FStatus: String;
  public
    property destination_addresses: TArray<String> read FDestination_addresses write FDestination_addresses;
    property origin_addresses: TArray<String> read FOrigin_addresses write FOrigin_addresses;
    property rows: TArray<TRowsClass> read FRows write FRows;
    property status: String read FStatus write FStatus;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TMapsDistanceMatrix;
  end;

  //BEGIN - CONTROLLER
  TControllerMapsDistanceMatrix = class
  private
    const
      FILTRO = 'GER_MARDES = ''M'' AND GER_ORDIMP > 0';

    class function fGetDistanceMatrix(strOrigem: String; arrDestinos: TArray<String>; strAvoid, strKey: String; blnKeySecundaria: Boolean): TMapsDistanceMatrix; overload;
    class procedure pAtualizaConsumoKey(strAutInc, strKey, strSinal: String; intQtdEle: Integer; blnKeySecundaria, blnRobo: Boolean);
    class function fVerifica_KeyP_UrlP_Origem(strKey, strOrigem: String): Boolean;
    class function fVerifica_KeyS_UrlS(strKey, strUrl: String): Boolean;
    class function fVerificaUsoKey(var blnKeySecundaria: Boolean; var strKey, strAutInc: String; cdsMaps: TUniClientDataSet; blnRobo: Boolean): Boolean;
    class function fRetornaEnderecos(cdsMaps: TUniClientDataSet; order: TOrder): TArray<String>;
    class function fVerificaObjeto(MapsDistanceMatrix: TMapsDistanceMatrix): Boolean;
    class function fProcessaRota(MapsDistanceMatrix: TMapsDistanceMatrix; var fltDistancia: Double; var intRecNo: Integer;
      var order: TOrder; cdsMaps: TUniClientDataSet): Boolean;
    class procedure pProcessaRetornos(MapsDistanceMatrix: TMapsDistanceMatrix;
      cdsMaps: TUniClientDataSet; intRecNo: Integer; fltDistancia: Double; var fltDistanciaAcumulada, fltTempoAcumulado: Double; var intOrdem: Integer; var strOrigem: String; order: TOrder); overload;
    class procedure pProcessaRetornosErros(cdsMaps: TUniClientDataSet; intRecNo: Integer);
    class procedure pVerificaSeRetonaParaCD(cdsMaps: TUniClientDataSet; intOrdem: Integer; var blnRetCD: Boolean);
    class procedure pRetornaOrigemEDestino(cdsMaps: TUniClientDataSet; blnRetCd: Boolean; order: TOrder; var strOrigem: String; var arrDestinos: TArray<String>);
    class procedure pGravaRotaRetornoCD(MapsDistanceMatrix: TMapsDistanceMatrix; cdsRomRet: TUniClientDataSet);
    class procedure pVerificaSeRemoveFiltroPrioridades(cdsMaps: TUniClientDataSet;
                                                       var strOrigem: String;
                                                       var order: TOrder;
                                                       blnRobo: Boolean); overload;
    class function fEntregaJaRecebeuAhCargaNaFilial(cdsMaps: TUniClientDataSet; intRecNo: Integer; var intRecNoFilial: Integer; var blnProcurandoFilial: Boolean; order: TOrder): Boolean;
    class function fFiltroRetCD(intOrdem: Integer): String;
    class function fFiltroPrioridade: String;
    class function fFiltroGeral: String;
    class function fIgnorarDestino(intCount: Integer): Boolean;

    class function fPosicionaNaFilial(order: TOrder;
                                      var blnPararAnalise,
                                      blnProcurandoFilial: Boolean;
                                      fltMenorDistancia: Double;
                                      var fltMenorDistanciaFilial,
                                      fltDistancia: Double;
                                      intRecNoFilial: Integer;
                                      var intRecNo,
                                      intRecNoFilialAnterior:Integer): Boolean;

    class function fRetornaDestino(order: TOrder;
                                   intCount: Integer;
                                   fltDistanciaEncontrada: Double;
                                   var fltDistancia: Double;
                                   var intRecNo: Integer): Boolean;

    class procedure pExibeMensagemErro(blnExibeMensagem: Boolean);

    class procedure pExibeMensagemKeys(blnExibeMensagem: Boolean);

    class procedure pPreencheOriginObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix);

    class procedure pPreencheDestinationObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix);

    class procedure pPreencheElementsObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix); overload;

    class function fPossibilidadeEnderecoDivergente(strEnderecoRetornado, strCepSolicitado,
      strCidadeSolicitada: String): Boolean;

    class function fEhCEP(strCep: String): Boolean;

    class function fPreparaComparacaoCidade(strCidade: String): String;

    class function fRetornaOrigem(strCoordenada, strSiteId: String): TArray<TOriginsClass>;

    class function fRetornaDestinos(cdsMaps: TUniClientDataSet; blnRetCd: Boolean; order: TOrder): TArray<TDestinationsClass>;

    class procedure pVerificaSeRemoveFiltroPrioridades(cdsMaps: TUniClientDataSet;
                                                       MaplinkMatrixDistance: TMaplinkMatrixDistance;
                                                       var order: TOrder); overload;

    class procedure pProcessaRetornos(MapsDistanceMatrix: TMapsDistanceMatrix;
      cdsMaps: TUniClientDataSet; intRecNo: Integer; fltDistancia: Double; var fltDistanciaAcumulada, fltTempoAcumulado: Double; var intOrdem: Integer; MaplinkMatrixDistance: TMaplinkMatrixDistance; order: TOrder); overload;

    class function fProximoDestinoEhNoMesmoLocal(order: TOrder;
                                                 cdsMaps: TUniClientDataSet;
                                                 strReferencia: String;
                                                 var fltDistancia: Double;
                                                 var intRecNo: Integer): Boolean;

    class procedure pPreencheElementsObjetoResult(MapsDistanceMatrix: TMapsDistanceMatrix; RetornoMaplinkMatrixDistance: TRetornoMaplinkMatrixDistance); overload;

    class function fGetDistanceMatrix(MaplinkMatrixDistance: TMaplinkMatrixDistance): TMapsDistanceMatrix; overload;

    class function fGetDistanceMatrix(const ACoordenadas: String; order: TOrder): TMapsDistanceMatrix; overload;

    class procedure pPreencheElementsObjetoResult(MapsDistanceMatrix: TMapsDistanceMatrix; CitelOsrmTableApi: TCitelOsrmTableApi; order: TOrder); overload;
  public
    class function fRetCoordenadaExtended(strCoordenada: String; LatLon: TLatLon): Extended; overload;
    class function fRetCoordenadaString(strCoordenada: String; LatLon: TLatLon): String; overload;

    class function fRetAvoidStr(avoid : TAvoid): String;

    class function fRetornaCoordenadas(cdsMaps: TUniClientDataSet): TArray<String>;

    class procedure pProcessarMapsDistanceMatrix(cdsMaps,
                                                 cdsRomRet: TUniClientDataSet;
                                                 order: TOrder;
                                                 avoid: TAvoid;
                                                 var blnProcessado: Boolean;
                                                 strLocalizacaoIniciar: String = '';
                                                 blnExibeMensagem: Boolean = False;
                                                 blnRobo: Boolean = False); overload;

    class procedure pProcessarMapsDistanceMatrix(cdsMaps,
                                                 cdsRomRet: TUniClientDataSet;
                                                 order: TOrder;
                                                 avoidanceTypes: TArray<String>;
                                                 calculationMode: String;
                                                 var blnProcessado: Boolean;
                                                 strLocalizacaoIniciar: String = '';
                                                 blnExibeMensagem: Boolean = False); overload;

    class procedure pProcessarMapsDistanceMatrix(cdsMaps,
                                                 cdsRomRet: TUniClientDataSet;
                                                 order: TOrder;
                                                 var blnProcessado: Boolean;
                                                 strLocalizacaoIniciar: String = '';
                                                 blnExibeMensagem: Boolean = False;
                                                 blnRobo: Boolean = False); overload;
  end;
  //END - CONTROLLER

  var
    arrRecNoErr: array of Integer;
    arrIgnorar: Array Of String;

implementation

uses
  untRestApi, untMapsRestApi;

{TElementsClass}

constructor TElementsClass.Create;
begin
  inherited;
  FDistance := TDistanceClass.Create();
  FDuration := TDurationClass.Create();
  FDuration_in_traffic := TDuration_in_trafficClass.Create();
end;

destructor TElementsClass.Destroy;
begin
  FDistance.free;
  FDuration.free;
  FDuration_in_traffic.free;
  inherited;
end;

class function TElementsClass.fNew: TElementsClass;
begin
  Result := TElementsClass.Create;
end;

function TElementsClass.f_distance(AValue: Extended): TElementsClass;
begin
  FDistance.FValue := AValue;
  Result := Self;
end;

function TElementsClass.f_duration(AValue: Extended): TElementsClass;
begin
  FDuration.FValue := AValue;
  Result := Self;
end;

function TElementsClass.f_duration_in_traffic(AValue: Extended): TElementsClass;
begin
  FDuration_in_traffic.FValue := AValue;
  Result := Self;
end;

function TElementsClass.f_status(AValue: String): TElementsClass;
begin
  FStatus := AValue;
  Result := Self;
end;

{TRowsClass}

destructor TRowsClass.Destroy;
var
  LelementsItem: TElementsClass;
begin

 for LelementsItem in FElements do
   LelementsItem.free;

  inherited;
end;

{TMapsDistanceMatrix}

destructor TMapsDistanceMatrix.Destroy;
var
  LrowsItem: TRowsClass;
begin

 for LrowsItem in FRows do
   LrowsItem.free;

  inherited;
end;

class function TMapsDistanceMatrix.FromJsonString(AJsonString: string): TMapsDistanceMatrix;
begin
  result := TJson.JsonToObject<TMapsDistanceMatrix>(AJsonString)
end;

{ TControllerMapsDistanceMatrix }

class procedure TControllerMapsDistanceMatrix.pAtualizaConsumoKey(strAutInc, strKey, strSinal: String; intQtdEle: Integer; blnKeySecundaria, blnRobo: Boolean);
var
  qryKeyEle: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strSQL: String;
begin
  if blnKeySecundaria then
    Exit;

  qryKeyEle := fCriaQuery;
  try
    qryKeyEle.Close;

    if fEmptyStr(strAutInc) then
      strSQL := ' INSERT '+
                '   INTO '+
                ' KEYELE '+
                '  (AUTOINCREM, '+
                '   KEY_KEYAPI, '+
                '   KEY_COMPET, '+
                '   KEY_A_N_O_, '+
                '   KEY_CONELE, '+
                '   KEY_CONPOR) '+
                ' VALUES ( '+
                '   :AUTINC, '+
                '   :KEYAPI, '+
                '   :COMPET, '+
                '   :A_N_O_, '+
                '   :CONELE, '+
                '   :CONPOR) '
    else
      strSQL := ' UPDATE '+
                '   KEYELE '+
                ' SET '+
                '   KEY_CONELE = KEY_CONELE '+strSinal+' :CONELE '+
                ' WHERE '+
                '   AUTOINCREM = :AUTINC ';

    qryKeyEle.SQL.Text := strSQL;

    qryKeyEle.ParamByName('CONELE').AsInteger := intQtdEle;
    if fEmptyStr(strAutInc) then
    begin
      qryKeyEle.ParamByName('AUTINC').AsString  := fRetAutoIncrem('KEYELE', VS_strCodEmp);
      qryKeyEle.ParamByName('KEYAPI').AsString  := strKey;
      qryKeyEle.ParamByName('COMPET').AsString  := fStrZero(monthOf(fNow).ToString,2);
      qryKeyEle.ParamByName('A_N_O_').AsString  := YearOf(fNow).ToString;
      qryKeyEle.ParamByName('CONPOR').AsString  := IIF(blnRobo, 'R', 'A');
    end
    else
      qryKeyEle.ParamByName('AUTINC').AsString  := strAutInc;

    qryKeyEle.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryKeyEle);
    {$ENDIF LINUX}
  end;
end;

class function TControllerMapsDistanceMatrix.fRetAvoidStr(avoid : TAvoid): String;
begin
  case avoid of
    none: Result := '';
    tolls: Result := 'tolls';
    highways: Result := 'highways';
    ferries: Result := 'ferries';
  end;
end;

class function TControllerMapsDistanceMatrix.fRetCoordenadaExtended(
  strCoordenada: String; LatLon: TLatLon): Extended;
begin
  Result := StrToFloatDef(AnsiReplaceStr(IIF(LatLon = coorLat,
                                             Copy(strCoordenada, 0, Pos(',', strCoordenada)-1),
                                             Copy(strCoordenada, Pos(',', strCoordenada)+1)), '.', ','), 0);
end;

class function TControllerMapsDistanceMatrix.fRetCoordenadaString(strCoordenada: String; LatLon: TLatLon): String;
begin
  Result := IIF(LatLon = coorLat,
                Copy(strCoordenada, 0, Pos(',', strCoordenada)-1),
                Copy(strCoordenada, Pos(',', strCoordenada)+1));

  Result := Trim(Result);
end;

class procedure TControllerMapsDistanceMatrix.pGravaRotaRetornoCD(MapsDistanceMatrix: TMapsDistanceMatrix; cdsRomRet: TUniClientDataSet);
begin
  cdsRomRet.EmptyDataSet;
  if (MapsDistanceMatrix.rows[0].elements[0].status = 'OK') then
  begin
    cdsRomRet.Append;
    cdsRomRet.FieldByName('RET_DISTAN').AsFloat := RoundTo(MapsDistanceMatrix.rows[0].elements[0].distance.value / 1000, -2);
    cdsRomRet.FieldByName('RET_TMPRET').AsFloat := MapsDistanceMatrix.rows[0].elements[0].duration.value;
    cdsRomRet.Post;
  end
  else
  if (MapsDistanceMatrix.rows[0].elements[0].status <> 'OK') then
    {$IFNDEF LINUX}
    fMensagem('ATENÇÃO!', 'Não foi possível calcular a rota de retorno para o CD!', ['&Ok']);
    {$ENDIF LINUX}

end;

class function TControllerMapsDistanceMatrix.fVerifica_KeyP_UrlP_Origem(strKey, strOrigem: String): Boolean;
begin
  Result := False;

  if fEmptyStr(strKey) then
    Exit;

  if fEmptyStr(strOrigem) then
    Exit;

  if fEmptyStr(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLMDP'])) then
    Exit;

  Result := True;
end;

class function TControllerMapsDistanceMatrix.fVerifica_KeyS_UrlS(strKey, strUrl: String): Boolean;
begin
  Result := False;

  if fEmptyStr(strKey) then
    Exit;

  if (fEmptyStr(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLMDS']))) then
    Exit;

  Result := True;
end;

class function TControllerMapsDistanceMatrix.fVerificaUsoKey(var blnKeySecundaria: Boolean; var strKey, strAutInc: String; cdsMaps: TUniClientDataSet; blnRobo: Boolean): Boolean;
var
  intQtdConsumoAutcom: Integer;
  intQtdConsumoRobo: Integer;

  strAutIncKeyEleAutcom,
  strAutIncKeyEleRobo: String;
begin
  Result := True;

  if not blnKeySecundaria then
  begin
    intQtdConsumoAutcom := fRetQtdElementosKey(strKey, monthOf(fNow), YearOf(fNow), strAutIncKeyEleAutcom, False);
    intQtdConsumoRobo := fRetQtdElementosKey(strKey, monthOf(fNow), YearOf(fNow), strAutIncKeyEleRobo, True);

    strAutInc := IIF(blnRobo, strAutIncKeyEleRobo, strAutIncKeyEleAutcom);

    if (intQtdConsumoAutcom + intQtdConsumoRobo + cdsMaps.RecordCount) > fCfgSis('QTDELE', varInteger) then
    begin
      Result := fVerifica_KeyS_UrlS(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDS']),
                                    fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLMDS']));
      if Result then
      begin
        blnKeySecundaria := True;
        strKey := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDS']);
      end;
    end;
  end;

  pAtualizaConsumoKey(strAutInc, strKey, '+', cdsMaps.RecordCount, blnKeySecundaria, blnRobo);

end;

class function TControllerMapsDistanceMatrix.fRetornaEnderecos(cdsMaps: TUniClientDataSet; order: TOrder): TArray<String>;
var
  strDestinos: String;
  intQtdDestinos,
  intContador: Integer;
begin
  intQtdDestinos := 1;
  intContador := 0;

  SetLength(Result, Ceil(cdsMaps.RecordCount / 25));

  cdsMaps.First;
  while not cdsMaps.Eof do
  begin
    strDestinos := IIF(fEmptyStr(strDestinos), '', '|')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_ENDCON').AsString), cdsMaps.FieldByName('GER_ENDCON').AsString+' - ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_BAIRRO').AsString), cdsMaps.FieldByName('GER_BAIRRO').AsString+', ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_NOMCID').AsString), cdsMaps.FieldByName('GER_NOMCID').AsString+' - ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_ESTADO').AsString), cdsMaps.FieldByName('GER_ESTADO').AsString+', ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_CEPCON').AsString), cdsMaps.FieldByName('GER_CEPCON').AsString+', ', '')+
                   'Brazil';

    Result[intContador] := Result[intContador] + strDestinos;

    if order = ordFixed then
        Break;

    if intQtdDestinos mod 25 = 0 then
    begin
      strDestinos := EmptyStr;
      Inc(intContador);
    end;
    Inc(intQtdDestinos);

    cdsMaps.Next;
  end;
end;

class function TControllerMapsDistanceMatrix.fRetornaCoordenadas(cdsMaps: TUniClientDataSet): TArray<String>;
var
  strDestinos: String;
begin
  SetLength(Result, 1);

  cdsMaps.First;
  while not cdsMaps.Eof do
  begin
    strDestinos := IIF(fEmptyStr(strDestinos), '', ';')+
                   fRetCoordenadaString(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon)+','+fRetCoordenadaString(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat);

    Result[0] := Result[0] + strDestinos;

    cdsMaps.Next;
  end;
end;

class function TControllerMapsDistanceMatrix.fVerificaObjeto(MapsDistanceMatrix: TMapsDistanceMatrix): Boolean;
begin
  Result := False;

  if MapsDistanceMatrix = nil then
    Exit;

  if Length(MapsDistanceMatrix.rows) <= 0 then
    Exit;

  Result := True;
end;

class procedure TControllerMapsDistanceMatrix.pRetornaOrigemEDestino(cdsMaps: TUniClientDataSet; blnRetCd: Boolean; order: TOrder; var strOrigem: String; var arrDestinos: TArray<String>);
begin
  if blnRetCD then
  begin
    SetLength(arrDestinos, 1);

    if fCfgSis('APIROT') = 'GOOGLE' then
    begin
      strOrigem := fRetornaEnderecos(cdsMaps, order)[0];
      arrDestinos[0] := cdsMaps.FieldByName('GER_FINROT').AsString;
    end
    else if fCfgSis('APIROT') = 'CITEL' then
    begin
      strOrigem := fRetornaCoordenadas(cdsMaps)[0];
      arrDestinos[0] := fRetCoordenadaString(cdsMaps.FieldByName('GER_FINROT').AsString, coorLon)+','+
                        fRetCoordenadaString(cdsMaps.FieldByName('GER_FINROT').AsString, coorLat);
    end;
  end
  else
  begin
    if fCfgSis('APIROT') = 'GOOGLE' then
      arrDestinos := fRetornaEnderecos(cdsMaps, order)
    else if fCfgSis('APIROT') = 'CITEL' then
      arrDestinos := fRetornaCoordenadas(cdsMaps);
  end;
end;

class function TControllerMapsDistanceMatrix.fFiltroRetCD(intOrdem: Integer): String;
begin
  Result := FILTRO+' AND (GER_LOCALI = '+QuotedStr('OK') + ' OR ' + ' GER_LOCALI = '+QuotedStr('OK?') + ') AND GER_ORDIMP = '+IntToStr(intOrdem);
end;

class function TControllerMapsDistanceMatrix.fGetDistanceMatrix(
  MaplinkMatrixDistance: TMaplinkMatrixDistance): TMapsDistanceMatrix;
var
  RetornoMaplinkMatrixDistance: TRetornoMaplinkMatrixDistance;
begin
  Result := nil;

  RetornoMaplinkMatrixDistance := TControllerMaplinkMatrixDistance.fGetDistanceMatrix(MaplinkMatrixDistance);
  try
    if Assigned(RetornoMaplinkMatrixDistance) then
    begin
      Result := TMapsDistanceMatrix.Create;
      Result.status := 'OK';

      SetLength(Result.FRows, 1);

      pPreencheElementsObjetoResult(Result, RetornoMaplinkMatrixDistance);
    end;
  finally
    if Assigned(RetornoMaplinkMatrixDistance) then
      FreeAndNil(RetornoMaplinkMatrixDistance);
  end;
end;

class function TControllerMapsDistanceMatrix.fGetDistanceMatrix(const ACoordenadas: String; order: TOrder): TMapsDistanceMatrix;
var
  CitelOsrmTableApi: TCitelOsrmTableApi;
begin
  Result := nil;

  CitelOsrmTableApi := TCitelOsrmTableApi.fGetDistanceMatrix(ACoordenadas);
  try
    if Assigned(CitelOsrmTableApi) and (CitelOsrmTableApi.Code.ToUpper = 'OK') then
    begin
      Result := TMapsDistanceMatrix.Create;
      Result.status := CitelOsrmTableApi.Code.ToUpper;

      SetLength(Result.FRows, 1);

      pPreencheElementsObjetoResult(Result, CitelOsrmTableApi, order);
    end;
  finally
    FreeAndNil(CitelOsrmTableApi);
  end;
end;

class function TControllerMapsDistanceMatrix.fFiltroPrioridade: String;
begin
  Result := FILTRO+' AND GER_LOCALI = '+QuotedStr('')+' AND PRIORIDADE > 0 ';
end;

class function TControllerMapsDistanceMatrix.fFiltroGeral: String;
begin
  Result := FILTRO+' AND GER_LOCALI = '+QuotedStr('');
end;

class procedure TControllerMapsDistanceMatrix.pVerificaSeRemoveFiltroPrioridades(
  cdsMaps: TUniClientDataSet; MaplinkMatrixDistance: TMaplinkMatrixDistance;
  var order: TOrder);
begin
  if not cdsMaps.IsEmpty then
    Exit;

  if Pos('PRIORIDADE', cdsMaps.Filter) <= 0 then
    Exit;

  cdsMaps.Filtered := False;
  cdsMaps.Filter   := 'GER_MARDES = '+QuotedStr('M')+' AND GER_ORDIMP > 0 AND GER_LOCALI = '+QuotedStr('');
  cdsMaps.Filtered := True;

  if order = ordNone then
  begin
    MaplinkMatrixDistance.pDestroyOrigins;
    MaplinkMatrixDistance.origins := fRetornaOrigem(cdsMaps.FieldByName('GER_INIPAR').AsString, IntToStr(cdsMaps.RecNo));
  end;
end;

class procedure TControllerMapsDistanceMatrix.pVerificaSeRetonaParaCD(cdsMaps: TUniClientDataSet; intOrdem: Integer; var blnRetCD: Boolean);
var
  strFilter: String;
begin
  if cdsMaps.IsEmpty then
  begin
    strFilter := cdsMaps.Filter;

    blnRetCD := True;

    cdsMaps.Filtered := False;
    cdsMaps.Filter   := fFiltroRetCD(intOrdem);
    cdsMaps.Filtered := True;

    if fEmptyStr(cdsMaps.FieldByName('GER_FINROT').AsString) then
    begin
      cdsMaps.Filtered := False;
      cdsMaps.Filter   := strFilter;
      cdsMaps.Filtered := True;
    end;
  end
  else
  begin
    cdsMaps.Filtered := False;
    cdsMaps.Filter   := fFiltroPrioridade;
    cdsMaps.Filtered := True;

    if cdsMaps.IsEmpty then
    begin
      cdsMaps.Filtered := False;
      cdsMaps.Filter   := fFiltroGeral;
      cdsMaps.Filtered := True;
    end;
  end;
end;

class function TControllerMapsDistanceMatrix.fEntregaJaRecebeuAhCargaNaFilial(cdsMaps: TUniClientDataSet; intRecNo: Integer; var intRecNoFilial: Integer; var blnProcurandoFilial: Boolean; order: TOrder): Boolean;
var
  strCodFilial: String;
begin
  Result := True;

  if intRecNo < 0 then
    Exit;

  if order = ordFixed then
    Exit;

  cdsMaps.RecNo := intRecNo+1;
  strCodFilial := cdsMaps.FieldByName('CARGANAFILIAL').AsString;

  if not fEmptyStr(strCodFilial) then
  begin
    SetLength(arrIgnorar, Length(arrIgnorar)+1 );
    arrIgnorar[Length(arrIgnorar)-1] := IntToStr(intRecNo);

    cdsMaps.First;
    while not cdsMaps.Eof do
    begin
      if (cdsMaps.FieldByName('GER_CODEMP').AsString = strCodFilial) and
         (cdsMaps.FieldByName('GER_FILIAL').AsString = 'S') then
      begin
        intRecNoFilial := cdsMaps.RecNo-1;
        blnProcurandoFilial := True;
        Result := False;

        Break;
      end;

      cdsMaps.Next;
    end;
  end;

end;

class function TControllerMapsDistanceMatrix.fIgnorarDestino(intCount: Integer): Boolean;
begin
  Result := False;

  if (Length(arrIgnorar) > 0) and
     (MatchStr(IntToStr(intCount), arrIgnorar)) then
    Result := True;
end;

class function TControllerMapsDistanceMatrix.fPosicionaNaFilial(order: TOrder;
                                                                 var blnPararAnalise,
                                                                 blnProcurandoFilial: Boolean;
                                                                 fltMenorDistancia: Double;
                                                                 var fltMenorDistanciaFilial,
                                                                 fltDistancia: Double;
                                                                 intRecNoFilial: Integer;
                                                                 var intRecNo,
                                                                 intRecNoFilialAnterior:Integer): Boolean;
begin
  Result := False;

  blnPararAnalise := False;

  blnProcurandoFilial := False;

  if fltMenorDistancia < fltMenorDistanciaFilial then
  begin
    intRecNo := intRecNoFilial;
    intRecNoFilialAnterior := intRecNoFilial;

    fltMenorDistanciaFilial := fltMenorDistancia;
    fltDistancia := fltMenorDistanciaFilial;
    Result := True;
  end
  else
    intRecNo := intRecNoFilialAnterior;

end;

class function TControllerMapsDistanceMatrix.fRetornaDestino(order: TOrder;
                                                             intCount: Integer;
                                                             fltDistanciaEncontrada: Double;
                                                             var fltDistancia: Double;
                                                             var intRecNo: Integer): Boolean;
begin
  Result := False;

  if order = ordFixed then
  begin
    fltDistancia := fltDistanciaEncontrada;
    intRecNo := intCount;
    Result := True;
  end
  else
  begin
    if(fltDistanciaEncontrada < fltDistancia) then
    begin
      fltDistancia := fltDistanciaEncontrada;
      intRecNo := intCount;
    end;
  end;

end;

class function TControllerMapsDistanceMatrix.fProcessaRota(MapsDistanceMatrix: TMapsDistanceMatrix;
  var fltDistancia: Double; var intRecNo: Integer; var order: TOrder; cdsMaps: TUniClientDataSet): Boolean;
var
  intCount: Integer;

  intRecNoFilial,
  intRecNoFilialAnterior: Integer;

  blnProcurandoFilial,
  blnPararAnalise: Boolean;

  fltMenorDistanciaFilial: Double;
begin
  blnProcurandoFilial := False;

  fltDistancia := 9999999;
  fltMenorDistanciaFilial := 9999999;

  repeat

    repeat

      blnPararAnalise := True;

      for intCount:=0 to Length(MapsDistanceMatrix.rows[0].elements)-1 do
      begin

        if (MapsDistanceMatrix.rows[0].elements[intCount].status <> 'OK') then
        begin
          SetLength(arrRecNoErr, Length(arrRecNoErr)+1 );
          arrRecNoErr[Length(arrRecNoErr)-1] := intCount;
          Continue;
        end;

        if (blnProcurandoFilial) then
        begin

          if (intCount <> (intRecNoFilial)) then
            Continue
          else
          if fPosicionaNaFilial(order,
                                blnPararAnalise,
                                blnProcurandoFilial,
                                MapsDistanceMatrix.rows[0].elements[intCount].distance.value,
                                fltMenorDistanciaFilial,
                                fltDistancia,
                                intRecNoFilial,
                                intRecNo,
                                intRecNoFilialAnterior) then
            Break;
        end;

        if fIgnorarDestino(intCount) then
          Continue;

        if fRetornaDestino(order,
                           intCount,
                           MapsDistanceMatrix.rows[0].elements[intCount].distance.value,
                           fltDistancia,
                           intRecNo) then
          Break;

      end;

    until blnPararAnalise;

  until fEntregaJaRecebeuAhCargaNaFilial(cdsMaps, intRecNo, intRecNoFilial, blnProcurandoFilial, order);


  Result := (intRecNo > -1);

end;

class procedure TControllerMapsDistanceMatrix.pProcessaRetornos(MapsDistanceMatrix: TMapsDistanceMatrix;
cdsMaps: TUniClientDataSet; intRecNo: Integer; fltDistancia: Double;
var fltDistanciaAcumulada, fltTempoAcumulado: Double; var intOrdem: Integer; var strOrigem: String; order: TOrder);
var
  blnPossibilidadeEnderecoDivergente: Boolean;
  strEndereco: String;
begin
  fltDistanciaAcumulada := fltDistanciaAcumulada + fltDistancia;
  fltTempoAcumulado := fltTempoAcumulado + MapsDistanceMatrix.rows[0].elements[Integer(IIF(((order = ordFixed) and (fCfgSis('APIROT') = 'CITEL')), intOrdem, intRecNo))].duration.value;

  cdsMaps.RecNo := intRecNo+1;

  blnPossibilidadeEnderecoDivergente := False;
  if fCfgSis('APIROT') = 'GOOGLE' then
    blnPossibilidadeEnderecoDivergente := fPossibilidadeEnderecoDivergente(MapsDistanceMatrix.destination_addresses[intRecNo],
                                                                           cdsMaps.FieldByName('GER_CEPCON').AsString,
                                                                           cdsMaps.FieldByName('GER_NOMCID').AsString+'-'+cdsMaps.FieldByName('GER_ESTADO').AsString);
  repeat
    strEndereco := IIF(fCfgSis('APIROT') = 'GOOGLE', cdsMaps.FieldByName('GER_ENDCON').AsString, cdsMaps.FieldByName('GER_LATLON').AsString);

    intOrdem := intOrdem+1;

    if (order = ordFixed) and (fCfgSis('APIROT') = 'CITEL') then
    begin
      SetLength(arrIgnorar, Length(arrIgnorar)+1 );
      arrIgnorar[Length(arrIgnorar)-1] := IntToStr(intOrdem-1);
    end;

    cdsMaps.Edit;
    cdsMaps.FieldByName('GER_LOCALI').AsString := IIF(not blnPossibilidadeEnderecoDivergente, 'OK', 'OK?');
    cdsMaps.FieldByName('GER_DISTAN').AsFloat  := RoundTo(fltDistancia / 1000, -2);

    if fltDistancia <= 0.00 then
      cdsMaps.FieldByName('GER_TMPENT').AsFloat := 0.00
    else
      cdsMaps.FieldByName('GER_TMPENT').AsFloat := MapsDistanceMatrix.rows[0].elements[Integer(IIF(((order = ordFixed) and (fCfgSis('APIROT') = 'CITEL')), intOrdem-1, intRecNo))].duration.value;

    cdsMaps.FieldByName('GER_ORDIMP').AsString := IntToStr(intOrdem);

    if fCfgSis('APIROT') = 'GOOGLE' then
      strOrigem := IIF(not fEmptyStr(cdsMaps.FieldByName('GER_ENDCON').AsString), cdsMaps.FieldByName('GER_ENDCON').AsString+' - ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_BAIRRO').AsString), cdsMaps.FieldByName('GER_BAIRRO').AsString+', ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_NOMCID').AsString), cdsMaps.FieldByName('GER_NOMCID').AsString+' - ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_ESTADO').AsString), cdsMaps.FieldByName('GER_ESTADO').AsString+', ', '')+
                   IIF(not fEmptyStr(cdsMaps.FieldByName('GER_CEPCON').AsString), cdsMaps.FieldByName('GER_CEPCON').AsString+', ', '')+
                   'Brazil'
    else
      strOrigem := fRetCoordenadaString(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon) +','+ fRetCoordenadaString(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat);

    cdsMaps.Post;
  until not fProximoDestinoEhNoMesmoLocal(order, cdsMaps, strEndereco, fltDistancia, intRecNo);
end;

class function TControllerMapsDistanceMatrix.fPossibilidadeEnderecoDivergente(strEnderecoRetornado, strCepSolicitado,
strCidadeSolicitada: String): Boolean;
var
  blnCEPRetornadoEstaDivergente,
  blnCidadeRetornadaEstaDivergente: Boolean;

  arrEnderecoRetornado: TArray<String>;

  intContador: Integer;
begin
  Result := False;

  if (fEmptyStr(strCepSolicitado)) and (fEmptyStr(AnsiReplaceStr(strCidadeSolicitada, '-', ''))) then
    Exit;

  blnCEPRetornadoEstaDivergente := IIF(fEmptyStr(strCepSolicitado), False, True);
  blnCidadeRetornadaEstaDivergente := IIF(fEmptyStr(AnsiReplaceStr(strCidadeSolicitada, '-', '')), False, True);

  arrEnderecoRetornado := strEnderecoRetornado.Split([',']);

  for intContador := 0 to Length(arrEnderecoRetornado)-1 do
  begin

    if (blnCEPRetornadoEstaDivergente) and (fEhCEP(arrEnderecoRetornado[intContador])) then
      blnCEPRetornadoEstaDivergente := (Pos(Copy(Trim(arrEnderecoRetornado[intContador]),1,3), Copy(Trim(strCepSolicitado),1,3)) = 0);

    if blnCidadeRetornadaEstaDivergente then
      blnCidadeRetornadaEstaDivergente := not (fPreparaComparacaoCidade(arrEnderecoRetornado[intContador]) = fPreparaComparacaoCidade(strCidadeSolicitada));

  end;

  if (blnCEPRetornadoEstaDivergente) or (fEmptyStr(strCepSolicitado)) then
  begin
    if (blnCidadeRetornadaEstaDivergente) or (fEmptyStr(strCidadeSolicitada)) then
      Exit(True);
  end;

end;

class function TControllerMapsDistanceMatrix.fEhCEP(strCep: String): Boolean;
begin
  Result := False;

  strCep := Trim(strCep);
  strCep := AnsiReplaceStr(strCep, '-', '');

  if fIsNumber(strCep) then
    Result := True;

  if (Result) and (Length(strCep) <> 8) then
    Result := False;
end;

class function TControllerMapsDistanceMatrix.fPreparaComparacaoCidade(strCidade: String): String;
begin
  Result := Trim(strCidade);
  Result := AnsiReplaceStr(strCidade, '-', '');
  Result := fTiraEspacos(Result);
  Result := fRemoveAcento(Result);
  Result := UpperCase(Result);
end;

class procedure TControllerMapsDistanceMatrix.pProcessaRetornos(
  MapsDistanceMatrix: TMapsDistanceMatrix; cdsMaps: TUniClientDataSet;
  intRecNo: Integer; fltDistancia: Double; var fltDistanciaAcumulada,
  fltTempoAcumulado: Double; var intOrdem: Integer;
  MaplinkMatrixDistance: TMaplinkMatrixDistance; order: TOrder);
var
  strLatLon: String;
begin
  fltDistanciaAcumulada := fltDistanciaAcumulada + fltDistancia;
  fltTempoAcumulado := fltTempoAcumulado + MapsDistanceMatrix.rows[0].elements[intRecNo].duration.value;

  cdsMaps.RecNo := intRecNo+1;

  repeat
    strLatLon := cdsMaps.FieldByName('GER_LATLON').AsString;

    intOrdem := intOrdem+1;

    cdsMaps.Edit;
    cdsMaps.FieldByName('GER_LOCALI').AsString := IIF((cdsMaps.FieldByName('GER_LOCALI').AsString = 'OK?'), 'OK?', 'OK');
    cdsMaps.FieldByName('GER_DISTAN').AsFloat  := RoundTo(fltDistancia / 1000, -2);

    if fltDistancia <= 0.00 then
      cdsMaps.FieldByName('GER_TMPENT').AsFloat := 0.00
    else
      cdsMaps.FieldByName('GER_TMPENT').AsFloat := MapsDistanceMatrix.rows[0].elements[intRecNo].duration.value;

    cdsMaps.FieldByName('GER_ORDIMP').AsString := IntToStr(intOrdem);

    MaplinkMatrixDistance.pDestroyOrigins;
    MaplinkMatrixDistance.origins := fRetornaOrigem(cdsMaps.FieldByName('GER_LATLON').AsString, IntToStr(cdsMaps.RecNo));

    cdsMaps.Post;
  until not fProximoDestinoEhNoMesmoLocal(order, cdsMaps, strLatLon, fltDistancia, intRecNo);
end;

class function TControllerMapsDistanceMatrix.fProximoDestinoEhNoMesmoLocal(order: TOrder;
                                                                           cdsMaps: TUniClientDataSet;
                                                                           strReferencia: String;
                                                                           var fltDistancia: Double;
                                                                           var intRecNo: Integer): Boolean;
begin
  Result := False;

  if order <> ordFixed then
    Exit;

  if cdsMaps.IsEmpty then
    Exit;

  intRecNo := intRecNo+1;

  if strReferencia = cdsMaps.FieldByName(IIF(Pos(fCfgSis('APIROT'), 'MAPLINK_CITEL_') > 0, 'GER_LATLON', 'GER_ENDCON')).AsString then
  begin
    fltDistancia := 0;
    Exit(True);
  end;
end;

class procedure TControllerMapsDistanceMatrix.pProcessaRetornosErros(
  cdsMaps: TUniClientDataSet; intRecNo: Integer);
var
  intCount: Integer;
begin
  if (Length(arrRecNoErr) > 0)then
  begin

    for intCount:=Length(arrRecNoErr)-1 downto 0 do
    begin
      if (intRecNo > -1) then
      begin
        if (intRecNo > arrRecNoErr[intCount]) then
          cdsMaps.RecNo := arrRecNoErr[intCount]+1
        else
          cdsMaps.RecNo := arrRecNoErr[intCount];
      end
      else
        cdsMaps.RecNo := arrRecNoErr[intCount]+1;

      cdsMaps.Edit;
      cdsMaps.FieldByName('GER_LOCALI').AsString := 'ERRO';
      cdsMaps.FieldByName('GER_DISTAN').AsFloat  := 0;
      cdsMaps.FieldByName('GER_TMPENT').AsFloat  := 0;
      cdsMaps.FieldByName('GER_ORDIMP').AsString := '999';

      cdsMaps.Post;
    end;

  end;
end;

class procedure TControllerMapsDistanceMatrix.pVerificaSeRemoveFiltroPrioridades(cdsMaps: TUniClientDataSet;
                                                                                 var strOrigem: String;
                                                                                 var order: TOrder;
                                                                                 blnRobo: Boolean);
begin
  if not cdsMaps.IsEmpty then
    Exit;

  if Pos('PRIORIDADE', cdsMaps.Filter) <= 0 then
    Exit;

  SetLength(arrIgnorar, 0 );

  cdsMaps.Filtered := False;
  cdsMaps.Filter   := 'GER_MARDES = '+QuotedStr('M')+' AND GER_ORDIMP > 0 AND GER_LOCALI = '+QuotedStr('');
  cdsMaps.Filtered := True;

  if (not blnRobo) and (order = ordNone) then
    strOrigem := cdsMaps.FieldByName('GER_INIPAR').AsString;
end;

class procedure TControllerMapsDistanceMatrix.pExibeMensagemErro(blnExibeMensagem: Boolean);
begin
  if not blnExibeMensagem then
    Exit;

  {$IFNDEF LINUX}
  fMensagem('ATENÇÃO!', 'Rota não Calculada.'+#13#10+
                        'Nenhuma informação da matriz de distância retornada!', ['&Ok']);
  {$ENDIF LINUX}
end;

class procedure TControllerMapsDistanceMatrix.pExibeMensagemKeys(blnExibeMensagem: Boolean);
begin
  if not blnExibeMensagem then
    Exit;

  {$IFNDEF LINUX}
  fMensagem('ATENÇÃO!', 'Por favor, verifique se as configurações CFG_KEYMDP, CFG_URLMDP e '+
                        ' CFG_LATLON estão preenchidas corretamente!', ['&Ok']);
  {$ENDIF LINUX}
end;

class procedure TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsMaps,
                                                                           cdsRomRet: TUniClientDataSet;
                                                                           order: TOrder;
                                                                           avoidanceTypes: TArray<String>;
                                                                           calculationMode: String;
                                                                           var blnProcessado: Boolean;
                                                                           strLocalizacaoIniciar: String = '';
                                                                           blnExibeMensagem: Boolean = False);
const
  TRIP_PROFILE = 'MAPLINK';
  PONTO_DE_INICIO = 'PTI';
var
  MapsDistanceMatrix: TMapsDistanceMatrix;
  MaplinkMatrixDistance: TMaplinkMatrixDistance;

  intRecNo,
  intOrdem: Integer;

  fltDistancia,
  fltDistanciaAcumulada,
  fltTempoAcumulado: Double;

  blnRetCD: Boolean;
begin
  blnProcessado := True;

  intOrdem := 0;
  fltDistanciaAcumulada := 0;
  fltTempoAcumulado := 0;
  blnRetCD := False;

  MaplinkMatrixDistance := TMaplinkMatrixDistance.Create;
  try
    MaplinkMatrixDistance.origins := fRetornaOrigem(IIF(fEmptyStr(strLocalizacaoIniciar),
                                                        cdsMaps.FieldByName('GER_INIPAR').AsString,
                                                        strLocalizacaoIniciar),
                                                    PONTO_DE_INICIO);

    MaplinkMatrixDistance.avoidanceTypes := avoidanceTypes;
    MaplinkMatrixDistance.calculationMode := calculationMode;
    MaplinkMatrixDistance.tripProfile := TRIP_PROFILE;

    while (blnProcessado) and (not blnRetCD) do
    begin
      pVerificaSeRetonaParaCD(cdsMaps, intOrdem, blnRetCD);

      cdsMaps.First;
      while not cdsMaps.IsEmpty do
      begin
        MaplinkMatrixDistance.pDestroyDestinations;
        MaplinkMatrixDistance.destinations := fRetornaDestinos(cdsMaps, blnRetCd, order);

        MapsDistanceMatrix := fGetDistanceMatrix(MaplinkMatrixDistance);
        try
          if fVerificaObjeto(MapsDistanceMatrix) then
          begin

            if blnRetCD then
            begin
              pGravaRotaRetornoCD(MapsDistanceMatrix, cdsRomRet);
              Break;
            end
            else
            begin
              intRecNo := -1;
              SetLength(arrRecNoErr, 0 );
              SetLength(arrIgnorar, 0 );

              if fProcessaRota(MapsDistanceMatrix, fltDistancia, intRecNo, order, cdsMaps) then
                pProcessaRetornos(MapsDistanceMatrix,
                                  cdsMaps,
                                  intRecNo,
                                  fltDistancia,
                                  fltDistanciaAcumulada,
                                  fltTempoAcumulado,
                                  intOrdem,
                                  MaplinkMatrixDistance,
                                  order);

              pProcessaRetornosErros(cdsMaps,
                                     intRecNo);

              cdsMaps.First;
            end;

            pVerificaSeRemoveFiltroPrioridades(cdsMaps, MaplinkMatrixDistance, order);
          end
          else
          begin
            pExibeMensagemErro(blnExibeMensagem);
            blnProcessado := False;
            Break;
          end;
        finally
          if Assigned(MapsDistanceMatrix) then
            FreeAndNil(MapsDistanceMatrix);
        end;
      end;

    end;
  finally
    FreeAndNil(MaplinkMatrixDistance);
  end;
end;

class function TControllerMapsDistanceMatrix.fRetornaOrigem(strCoordenada, strSiteId: String): TArray<TOriginsClass>;
begin
  SetLength(Result, 1);
  Result[0] := TOriginsClass.fNew()
                              .f_latitude(fRetCoordenadaExtended(strCoordenada, coorLat))
                              .f_longitude(fRetCoordenadaExtended(strCoordenada, coorLon))
                              .f_siteId(strSiteId);
end;

class function TControllerMapsDistanceMatrix.fRetornaDestinos(cdsMaps: TUniClientDataSet; blnRetCd: Boolean; order: TOrder): TArray<TDestinationsClass>;
begin
  Result := nil;

  if blnRetCD then
  begin
    SetLength(Result, 1);

    Result[0] := TDestinationsClass.fNew()
                                     .f_latitude(fRetCoordenadaExtended(cdsMaps.FieldByName('GER_FINROT').AsString, coorLat))
                                     .f_longitude(fRetCoordenadaExtended(cdsMaps.FieldByName('GER_FINROT').AsString, coorLon))
                                     .f_siteId(IntToStr(cdsMaps.RecNo));

  end
  else
  begin
    cdsMaps.First;
    while not cdsMaps.Eof do
    begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := TDestinationsClass.fNew()
                                                      .f_latitude(fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat))
                                                      .f_longitude(fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon))
                                                      .f_siteId(IntToStr(cdsMaps.RecNo));

      if order = ordFixed then
        Break;

      cdsMaps.Next;
    end;
  end;
end;

class procedure TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsMaps,
                                                                           cdsRomRet: TUniClientDataSet;
                                                                           order: TOrder;
                                                                           avoid: TAvoid;
                                                                           var blnProcessado: Boolean;
                                                                           strLocalizacaoIniciar: String = '';
                                                                           blnExibeMensagem: Boolean = False;
                                                                           blnRobo: Boolean = False);
var
  MapsDistanceMatrix: TMapsDistanceMatrix;
  strOrigem,
  strKey,
  strAutInc: String;

  arrDestinos: TArray<String>;

  intRecNo,
  intOrdem: Integer;

  fltDistancia,
  fltDistanciaAcumulada,
  fltTempoAcumulado: Double;

  blnKeySecundaria: Boolean;
  blnRetCD: Boolean;

begin
  blnProcessado := True;

  intOrdem := 0;
  fltDistanciaAcumulada := 0;
  fltTempoAcumulado := 0;
  blnKeySecundaria := False;
  blnRetCD := False;

  cdsRomRet.EmptyDataSet;

  strOrigem := IIF(fEmptyStr(strLocalizacaoIniciar), cdsMaps.FieldByName('GER_INIPAR').AsString, strLocalizacaoIniciar);
  strKey := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP']);

  if fVerifica_KeyP_UrlP_Origem(strKey, strOrigem) then
  begin

    while (blnProcessado) and (not blnRetCD) do
    begin
      pVerificaSeRetonaParaCD(cdsMaps, intOrdem, blnRetCD);

      cdsMaps.First;
      while not cdsMaps.IsEmpty do
      begin
        if not fVerificaUsoKey(blnKeySecundaria, strKey, strAutInc, cdsMaps, blnRobo) then
        begin
          {$IFNDEF LINUX}
          fMensagem('ATENÇÃO!', 'Por favor, verifique se as configurações CFG_KEYMDS e CFG_URLMDS estão preenchidas corretamente!', ['&Ok']);
          {$ENDIF LINUX}
          Break;
        end;

        pRetornaOrigemEDestino(cdsMaps, blnRetCd, order, strOrigem, arrDestinos);

        if (blnRetCd) and (fEmptyStr(arrDestinos[0])) then
          Break;

        MapsDistanceMatrix := fGetDistanceMatrix(strOrigem,
                                                 arrDestinos,
                                                 fRetAvoidStr(avoid),
                                                 strKey,
                                                 blnKeySecundaria);
        try
          if fVerificaObjeto(MapsDistanceMatrix) then
          begin

            if blnRetCD then
            begin
              pGravaRotaRetornoCD(MapsDistanceMatrix, cdsRomRet);
              Break;
            end
            else
            begin
              intRecNo := -1;
              SetLength(arrRecNoErr, 0 );
              SetLength(arrIgnorar, 0 );

              if fProcessaRota(MapsDistanceMatrix, fltDistancia, intRecNo, order, cdsMaps) then
                pProcessaRetornos(MapsDistanceMatrix,
                                  cdsMaps,
                                  intRecNo,
                                  fltDistancia,
                                  fltDistanciaAcumulada,
                                  fltTempoAcumulado,
                                  intOrdem,
                                  strOrigem,
                                  order);

              pProcessaRetornosErros(cdsMaps,
                                     intRecNo);

              cdsMaps.First;
            end;

            pVerificaSeRemoveFiltroPrioridades(cdsMaps, strOrigem, order, blnRobo);
          end
          else
          begin
            pAtualizaConsumoKey(strAutInc, strKey, '-', cdsMaps.RecordCount, blnKeySecundaria, blnRobo);

            pExibeMensagemErro(blnExibeMensagem);
            blnProcessado := False;
            Break;
          end;
        finally
          if Assigned(MapsDistanceMatrix) then
            FreeAndNil(MapsDistanceMatrix);
        end;

      end;

    end;

  end
  else
    pExibeMensagemKeys(blnExibeMensagem);
end;

class procedure TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsMaps,
                                                                           cdsRomRet: TUniClientDataSet;
                                                                           order: TOrder;
                                                                           var blnProcessado: Boolean;
                                                                           strLocalizacaoIniciar: String = '';
                                                                           blnExibeMensagem: Boolean = False;
                                                                           blnRobo: Boolean = False);
var
  MapsDistanceMatrix: TMapsDistanceMatrix;
  strOrigem: String;

  arrDestinos: TArray<String>;

  intRecNo,
  intOrdem: Integer;

  fltDistancia,
  fltDistanciaAcumulada,
  fltTempoAcumulado: Double;

  blnRetCD: Boolean;
begin
  blnProcessado := True;

  intOrdem := 0;
  fltDistanciaAcumulada := 0;
  fltTempoAcumulado := 0;
  blnRetCD := False;

  cdsRomRet.EmptyDataSet;

  strOrigem := IIF(fEmptyStr(strLocalizacaoIniciar),
                   fRetCoordenadaString(cdsMaps.FieldByName('GER_INIPAR').AsString, coorLon)+','+fRetCoordenadaString(cdsMaps.FieldByName('GER_INIPAR').AsString, coorLat),
                   fRetCoordenadaString(strLocalizacaoIniciar, coorLon)+','+fRetCoordenadaString(strLocalizacaoIniciar, coorLat));
  while (blnProcessado) and (not blnRetCD) do
  begin
    pVerificaSeRetonaParaCD(cdsMaps, intOrdem, blnRetCD);

    cdsMaps.First;
    while not cdsMaps.IsEmpty do
    begin
      pRetornaOrigemEDestino(cdsMaps, blnRetCd, order, strOrigem, arrDestinos);

      if (blnRetCd) and (fEmptyStr(arrDestinos[0])) then
        Break;

      MapsDistanceMatrix := fGetDistanceMatrix(strOrigem+';'+arrDestinos[0], order);
      try
        if fVerificaObjeto(MapsDistanceMatrix) then
        begin
          if blnRetCD then
          begin
            pGravaRotaRetornoCD(MapsDistanceMatrix, cdsRomRet);
            Break;
          end
          else
          begin
            intRecNo := -1;
            SetLength(arrRecNoErr, 0 );
            SetLength(arrIgnorar, 0 );

            while not cdsMaps.IsEmpty do
            begin
              if fProcessaRota(MapsDistanceMatrix, fltDistancia, intRecNo, order, cdsMaps) then
                pProcessaRetornos(MapsDistanceMatrix,
                                  cdsMaps,
                                  IIF(order = ordNone, intRecNo, 0),
                                  fltDistancia,
                                  fltDistanciaAcumulada,
                                  fltTempoAcumulado,
                                  intOrdem,
                                  strOrigem,
                                  order);

              pProcessaRetornosErros(cdsMaps,
                                     intRecNo);

              if order = ordNone then
                Break;
            end;
            cdsMaps.First;
          end;

          pVerificaSeRemoveFiltroPrioridades(cdsMaps, strOrigem, order, blnRobo);
        end
        else
        begin
          pExibeMensagemErro(blnExibeMensagem);
          blnProcessado := False;
          Break;
        end;
      finally
        if Assigned(MapsDistanceMatrix) then
          FreeAndNil(MapsDistanceMatrix);
      end;
    end;

  end;
end;

class function TControllerMapsDistanceMatrix.fGetDistanceMatrix(strOrigem: String; arrDestinos: TArray<String>; strAvoid, strKey: String; blnKeySecundaria: Boolean): TMapsDistanceMatrix;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  intContadorDestinos: Integer;

  JSONRetorno: String;
  MapsDistanceMatrix: TMapsDistanceMatrix;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create(IIF(blnKeySecundaria, 'DISTANCEMATRIX', 'GOOGLEMAPS'), TControllerMaps.fConfigurarMaps);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'maps/api/distancematrix/json';
    RestRequest.Method   := rmGET;

    RestRequest.Params.AddItem('origins', strOrigem, pkGETorPOST);

    if not fEmptyStr(strAvoid) then
      RestRequest.Params.AddItem('avoid', strAvoid, pkGETorPOST);

    RestRequest.Params.AddItem('key', strKey, pkGETorPOST);

    for intContadorDestinos := 0 to Length(arrDestinos)-1 do
    begin
      RestRequest.Params.AddItem('destinations', arrDestinos[intContadorDestinos], pkGETorPOST);

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      begin
        MapsDistanceMatrix := TMapsDistanceMatrix.FromJsonString(JSONRetorno);

        if not fVerificaObjeto(MapsDistanceMatrix) then
        begin
          Result := nil;
          Break;
        end;

        if not Assigned(Result) then
        begin
          Result := TMapsDistanceMatrix.Create;
          Result.status := MapsDistanceMatrix.status;

          SetLength(Result.FRows, 1);

          pPreencheOriginObjetoResult(Result, MapsDistanceMatrix);
        end;

        pPreencheDestinationObjetoResult(Result, MapsDistanceMatrix);
        pPreencheElementsObjetoResult(Result, MapsDistanceMatrix);
      end
      else
      begin
        {$IFNDEF LINUX}
        fMensagem('', 'Ocorreu uma falha na comunicação com a API Matriz de distância!',['&OK']);
        {$ENDIF LINUX}

        Break;
      end;
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

class procedure TControllerMapsDistanceMatrix.pPreencheOriginObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix);
var
  intContador: Integer;
begin
  for intContador := 0 to Length(MapsDistanceMatrix.origin_addresses)-1 do
  begin
    SetLength(Result.FOrigin_addresses, Length(Result.origin_addresses)+1);
    Result.origin_addresses[Length(Result.origin_addresses)-1] := MapsDistanceMatrix.origin_addresses[intContador];
  end;
end;

class procedure TControllerMapsDistanceMatrix.pPreencheDestinationObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix);
var
  intContador: Integer;
begin
  for intContador := 0 to Length(MapsDistanceMatrix.destination_addresses)-1 do
  begin
    SetLength(Result.FDestination_addresses, Length(Result.destination_addresses)+1);
    Result.destination_addresses[Length(Result.destination_addresses)-1] := MapsDistanceMatrix.destination_addresses[intContador];
  end;
end;

class procedure TControllerMapsDistanceMatrix.pPreencheElementsObjetoResult(Result, MapsDistanceMatrix: TMapsDistanceMatrix);
var
  element: TElementsClass;
begin
  if not Assigned(Result.rows[0]) then
    Result.rows[0] := TRowsClass.Create;

  for element in MapsDistanceMatrix.rows[0].elements do
  begin
    SetLength(Result.rows[0].FElements, Length(Result.rows[0].elements)+1);
    Result.rows[0].elements[Length(Result.rows[0].elements)-1] := element;
  end;
end;

class procedure TControllerMapsDistanceMatrix.pPreencheElementsObjetoResult(MapsDistanceMatrix: TMapsDistanceMatrix; RetornoMaplinkMatrixDistance: TRetornoMaplinkMatrixDistance);
var
  elementMaplink: TElementsClassMaplink;
begin
  if not Assigned(MapsDistanceMatrix.rows[0]) then
    MapsDistanceMatrix.rows[0] := TRowsClass.Create;

  for elementMaplink in RetornoMaplinkMatrixDistance.elements do
  begin
    SetLength(MapsDistanceMatrix.rows[0].FElements, Length(MapsDistanceMatrix.rows[0].elements)+1);

    MapsDistanceMatrix.rows[0].elements[Length(MapsDistanceMatrix.rows[0].elements)-1] := TElementsClass.fNew()
                                                                                            .f_distance(elementMaplink.distance)
                                                                                            .f_duration(elementMaplink.nominalDuration)
                                                                                            .f_duration_in_traffic(elementMaplink.nominalDuration)
                                                                                            .f_status('OK');
  end;
end;

class procedure TControllerMapsDistanceMatrix.pPreencheElementsObjetoResult(MapsDistanceMatrix: TMapsDistanceMatrix; CitelOsrmTableApi: TCitelOsrmTableApi; order: TOrder);
var
  intCount: Integer;
begin
  if not Assigned(MapsDistanceMatrix.rows[0]) then
    MapsDistanceMatrix.rows[0] := TRowsClass.Create;

  if order = ordNone then
  begin
    for intCount:=1 to High(CitelOsrmTableApi.Distances[0]) do
    begin
      SetLength(MapsDistanceMatrix.rows[0].FElements, Length(MapsDistanceMatrix.rows[0].elements)+1);

      MapsDistanceMatrix.rows[0].elements[Length(MapsDistanceMatrix.rows[0].elements)-1] := TElementsClass.fNew()
                                                                                              .f_distance(CitelOsrmTableApi.Distances[0][intCount])
                                                                                              .f_duration(CitelOsrmTableApi.Durations[0][intCount])
                                                                                              .f_duration_in_traffic(CitelOsrmTableApi.Durations[0][intCount])
                                                                                              .f_status('OK');
    end;
  end
  else if order = ordFixed then
  begin
    for intCount:=0 to High(CitelOsrmTableApi.Distances)-1 do
    begin
      SetLength(MapsDistanceMatrix.rows[0].FElements, Length(MapsDistanceMatrix.rows[0].elements)+1);

      MapsDistanceMatrix.rows[0].elements[Length(MapsDistanceMatrix.rows[0].elements)-1] := TElementsClass.fNew()
                                                                                              .f_distance(CitelOsrmTableApi.Distances[intCount][intCount+1])
                                                                                              .f_duration(CitelOsrmTableApi.Durations[intCount][intCount+1])
                                                                                              .f_duration_in_traffic(CitelOsrmTableApi.Durations[intCount][intCount+1])
                                                                                              .f_status('OK');
    end;
  end;

end;

end.
