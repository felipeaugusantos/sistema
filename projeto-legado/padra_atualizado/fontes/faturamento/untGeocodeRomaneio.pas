unit untGeocodeRomaneio;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.StrUtils, Vcl.Controls,
  System.JSON, System.Classes, untMaplinkMultiGeocode, untGeocode, untGoogleGeocoding,
  untFuncoesSimples, REST.Client, Vcl.StdCtrls, UniClientDataSet,
  Data.DB, MemDS, DBAccess, Uni;

type
  TGeocodeRomaneio = class
  private
    class function fProcessaGeocodeMaplink(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;
    class function fProcessaGeocodeGoogle(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;
    class function fValidaResultsGoogle(AResults: untGoogleGeocoding.TResultsClass): Boolean;
    class function fQuantidadeDeCepDoClienteEncontradoNosResultados(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet): Integer;
    class procedure pDefinirEnderecoResultadoUnico(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);
    class procedure pDefinirEnderecoCepCliente(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);
    class procedure pEscolherEndereco(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);

    class function fRetEnderecos(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;

    class procedure pGravaCoordenadasNaENTCLI(cdsEnderecos: TUniClientDataSet);

    class function fPossibilidadeEnderecoDivergente(strEnderecoRetornado, strCepSolicitado, strCidadeSolicitada: String): Boolean;

    class function fEhCEP(strCep: String): Boolean;

    class function fPreparaComparacaoCidade(strCidade: String): String;

    class function fAnalisaCoordenadas(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
  public
    class function fProcessaGeocodeDosEnderecos(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
  end;

implementation

uses untEnderecosGeocode;

class procedure TGeocodeRomaneio.pGravaCoordenadasNaENTCLI(cdsEnderecos: TUniClientDataSet);
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

class function TGeocodeRomaneio.fPreparaComparacaoCidade(strCidade: String): String;
begin
  Result := Trim(strCidade);
  Result := AnsiReplaceStr(strCidade, '-', '');
  Result := fTiraEspacos(Result);
  Result := fRemoveAcento(Result);
  Result := UpperCase(Result);
end;

class function TGeocodeRomaneio.fEhCEP(strCep: String): Boolean;
begin
  Result := False;

  strCep := Trim(strCep);
  strCep := AnsiReplaceStr(strCep, '-', '');

  if fIsNumber(strCep) then
    Result := True;

  if (Result) and (Length(strCep) <> 8) then
    Result := False;
end;

class function TGeocodeRomaneio.fPossibilidadeEnderecoDivergente(strEnderecoRetornado, strCepSolicitado,
strCidadeSolicitada: String): Boolean;
var
  blnCEPRetornadoEstaDivergente,
  blnCidadeRetornadaEstaDivergente: Boolean;

  arrEnderecoRetornado: TArray<String>;

  intContador: Integer;
begin
  Result := False;

  if fEmptyStr(strEnderecoRetornado) then
    Exit;

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

class function TGeocodeRomaneio.fAnalisaCoordenadas(
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

class function TGeocodeRomaneio.fProcessaGeocodeDosEnderecos(
  cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): Boolean;
var
  EnderecosGeocode: IEnderecosGeocode;
  Endereco : IEnderecoGeocode;

  blnPossibilidadeEnderecoDivergente: Boolean;
begin
  EnderecosGeocode := fRetEnderecos(cdsEnderecos, strMsgRetorno);
  if Assigned(EnderecosGeocode) then
  begin
    for Endereco in EnderecosGeocode.fRetEnderecosGeocode do
    begin
      if (Endereco.fGetLatitude = 0) and (Endereco.fGetLongitude = 0) then
        Continue;

      cdsEnderecos.RecNo := StrToInt(Endereco.fGetId);

      cdsEnderecos.Edit;
      cdsEnderecos.FieldByName('GER_LATLON').AsString := AnsiReplaceStr(Endereco.fGetLatitude.ToString, ',', '.') +','+
                                                         AnsiReplaceStr(Endereco.fGetLongitude.ToString, ',', '.');

      blnPossibilidadeEnderecoDivergente := fPossibilidadeEnderecoDivergente(Endereco.fGetEndereco,
                                                                             cdsEnderecos.FieldByName('GER_CEPCON').AsString,
                                                                             cdsEnderecos.FieldByName('GER_NOMCID').AsString);

      cdsEnderecos.FieldByName('GER_LOCALI').AsString := IIF(not blnPossibilidadeEnderecoDivergente, '', 'OK?');

      cdsEnderecos.Post;

      if not blnPossibilidadeEnderecoDivergente then
        pGravaCoordenadasNaENTCLI(cdsEnderecos);
    end;
  end;

  Result := fAnalisaCoordenadas(cdsEnderecos, strMsgRetorno);
end;

class function TGeocodeRomaneio.fRetEnderecos(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;
begin
  Result := nil;

  if fCfgSis('APIROT') = 'MAPLINK' then
    Result := fProcessaGeocodeMaplink(cdsEnderecos, strMsgRetorno)
  else if fCfgSis('APIROT') = 'CITEL' then
    Result := fProcessaGeocodeGoogle(cdsEnderecos, strMsgRetorno);
end;

class function TGeocodeRomaneio.fProcessaGeocodeMaplink(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;
var
  MultiGeocode: TMultiGeocode;
  RetornoMultiGeocode: TRetornoMultiGeocode;

  Resultado: untMaplinkMultiGeocode.TResultsClass;
begin
  Result := nil;
  RetornoMultiGeocode := nil;

  MultiGeocode := TMultiGeocode.Create;
  try
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

        MultiGeocode.pAddEndereco(TEnderecos.fNew()
                                    .f_id(IntToStr(cdsEnderecos.RecNo))
                                    .f_road(cdsEnderecos.FieldByName('GER_ENDCON').AsString)
                                    .f_number(fRetNumeroEndereco(cdsEnderecos.FieldByName('GER_ENDCON').AsString))
                                    .f_district(cdsEnderecos.FieldByName('GER_BAIRRO').AsString)
                                    .f_zipcode(cdsEnderecos.FieldByName('GER_CEPCON').AsString)
                                    .f_city(cdsEnderecos.FieldByName('GER_NOMCID').AsString)
                                    .f_state(cdsEnderecos.FieldByName('GER_ESTADO').AsString));

        cdsEnderecos.Next;
      end;

      if Length(MultiGeocode.Enderecos) = 0 then
        Exit;

      RetornoMultiGeocode := TControllerMaplinkMultiGeocode.fRetCoordenadas(MultiGeocode);
      if Assigned(RetornoMultiGeocode) then
      begin
        Result := TEnderecosGeocode.Create;

        for Resultado in RetornoMultiGeocode.results do
        begin
          if (Resultado.address.mainLocation.lat = 0) and (Resultado.address.mainLocation.lon = 0) then
            Continue;

          Result.pAddEnderecoGeocode(Resultado.address.mainLocation.lat,
                                     Resultado.address.mainLocation.lon,
                                     Resultado.strLabel,
                                     Resultado.id);
        end;
      end
      else
      begin
        if fEmptyStr(strMsgRetorno) then
          strMsgRetorno := 'Ocorreu uma falha na comunicação com a GEOCODE API!';
      end;

    except
      on E: Exception do
      begin
        if fEmptyStr(strMsgRetorno) then
          strMsgRetorno := 'Ocorreram erros ao obter as coordenadas dos endereços!';

        {$IFNDEF LINUX}
        pMensagensErro(E.Message, 'TGeocodeRomaneio.fProcessaGeocodeMaplink');
        {$ENDIF LINUX}
      end;
    end;
  finally
    FreeAndNil(MultiGeocode);

    if Assigned(RetornoMultiGeocode) then
      FreeAndNil(RetornoMultiGeocode);
  end;
end;

class function TGeocodeRomaneio.fProcessaGeocodeGoogle(cdsEnderecos: TUniClientDataSet; var strMsgRetorno: String): IEnderecosGeocode;
var
  GoogleGeocoding: TGoogleGeocoding;
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

      GoogleGeocoding := TGoogleGeocoding.fProcessa(cdsEnderecos.FieldByName('GER_ENDCON').AsString,
                                                    cdsEnderecos.FieldByName('GER_BAIRRO').AsString,
                                                    cdsEnderecos.FieldByName('GER_NOMCID').AsString,
                                                    cdsEnderecos.FieldByName('GER_ESTADO').AsString,
                                                    cdsEnderecos.FieldByName('GER_CEPCON').AsString);
      try
        if (Assigned(GoogleGeocoding)) and (GoogleGeocoding.status = 'OK') then
        begin
          if not Assigned(Result) then
            Result := TEnderecosGeocode.Create;

          if Length(GoogleGeocoding.results) = 1 then
            pDefinirEnderecoResultadoUnico(GoogleGeocoding, cdsEnderecos, Result)
          else if fQuantidadeDeCepDoClienteEncontradoNosResultados(GoogleGeocoding, cdsEnderecos) = 1 then
            pDefinirEnderecoCepCliente(GoogleGeocoding, cdsEnderecos, Result)
          else
            pEscolherEndereco(GoogleGeocoding, cdsEnderecos, Result);
        end
        else
        begin
          if fEmptyStr(strMsgRetorno) then
            strMsgRetorno := 'Ocorreu uma falha na comunicação com a GEOCODE API!';
        end;
      finally
        if Assigned(GoogleGeocoding) then
          FreeAndNil(GoogleGeocoding);
      end;

      cdsEnderecos.Next;
    end;
  except
    on E: Exception do
    begin
      if fEmptyStr(strMsgRetorno) then
        strMsgRetorno := 'Ocorreram erros ao obter as coordenadas dos endereços!';

      {$IFNDEF LINUX}
      pMensagensErro(E.Message, 'TGeocodeRomaneio.fProcessaGeocodeGoogle');
      {$ENDIF LINUX}
    end;
  end;
end;

class function TGeocodeRomaneio.fValidaResultsGoogle(AResults: untGoogleGeocoding.TResultsClass): Boolean;
begin
  Result := True;

  if not Assigned(AResults.geometry.location) then
    Exit(False);

  if (AResults.geometry.location.lat = 0) and (AResults.geometry.location.lng = 0) then
    Exit(False);
end;

class function TGeocodeRomaneio.fQuantidadeDeCepDoClienteEncontradoNosResultados(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet): Integer;
var
  Results: untGoogleGeocoding.TResultsClass;
begin
  Result := 0;

  for Results in GoogleGeocoding.results do
  begin
    if not fValidaResultsGoogle(Results) then
      Continue;

    if Pos(fFormataCEP(cdsEnderecos.FieldByName('GER_CEPCON').AsString), Results.formatted_address) <= 0 then
      Continue;

    Inc(Result);
  end;
end;

class procedure TGeocodeRomaneio.pDefinirEnderecoResultadoUnico(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);
begin
  if fValidaResultsGoogle(GoogleGeocoding.results[0]) then
    Result.pAddEnderecoGeocode(GoogleGeocoding.results[0].geometry.location.lat,
                               GoogleGeocoding.results[0].geometry.location.lng,
                               GoogleGeocoding.results[0].formatted_address,
                               cdsEnderecos.RecNo.ToString);
end;

class procedure TGeocodeRomaneio.pDefinirEnderecoCepCliente(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);
var
  Results: untGoogleGeocoding.TResultsClass;
begin
  for Results in GoogleGeocoding.results do
  begin
    if not fValidaResultsGoogle(Results) then
      Continue;

    if Pos(fFormataCEP(cdsEnderecos.FieldByName('GER_CEPCON').AsString), Results.formatted_address) <= 0 then
      Continue;

    Result.pAddEnderecoGeocode(Results.geometry.location.lat,
                               Results.geometry.location.lng,
                               Results.formatted_address,
                               cdsEnderecos.RecNo.ToString);
    Break;
  end;
end;

class procedure TGeocodeRomaneio.pEscolherEndereco(GoogleGeocoding: TGoogleGeocoding; cdsEnderecos: TUniClientDataSet; Result: IEnderecosGeocode);
var
  frmEnderecosGeocode: TfrmEnderecosGeocode;
begin
  pCriarFormularios(TfrmEnderecosGeocode, frmEnderecosGeocode);
  try
    frmEnderecosGeocode.pnlEndereco.Caption := cdsEnderecos.FieldByName('GER_ENDCON').AsString + ' ' +
                                               cdsEnderecos.FieldByName('GER_BAIRRO').AsString + ', ' +
                                               cdsEnderecos.FieldByName('GER_NOMCID').AsString + '-' +
                                               cdsEnderecos.FieldByName('GER_ESTADO').AsString + ' ' +
                                               cdsEnderecos.FieldByName('GER_CEPCON').AsString;

    frmEnderecosGeocode.GoogleGeocoding := GoogleGeocoding;
    frmEnderecosGeocode.ShowModal;
    if frmEnderecosGeocode.ModalResult = mrOk then
    begin
      if frmEnderecosGeocode.rdgSelecionar.Checked then
        Result.pAddEnderecoGeocode(frmEnderecosGeocode.cdsEnderecos.FieldByName('LATITUDE').AsExtended,
                                   frmEnderecosGeocode.cdsEnderecos.FieldByName('LONGITUDE').AsExtended,
                                   frmEnderecosGeocode.cdsEnderecos.FieldByName('ENDERECO').AsString,
                                   cdsEnderecos.RecNo.ToString)
      else
        Result.pAddEnderecoGeocode(StrToFloat(frmEnderecosGeocode.edtLatitude.Text),
                                   StrToFloat(frmEnderecosGeocode.edtLongitude.Text),
                                   EmptyStr,
                                   cdsEnderecos.RecNo.ToString);
    end;
  finally
    pFreeAndNil(frmEnderecosGeocode);
  end;
end;

end.
