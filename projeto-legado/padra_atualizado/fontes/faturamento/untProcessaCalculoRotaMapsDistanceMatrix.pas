unit untProcessaCalculoRotaMapsDistanceMatrix;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils, untMapsDistanceMatrix,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TProcessaCalculoRotaMapsDistanceMatrix = class
  private
    function fRetEvitar(strAvoid: String): TAvoid;
    function fRetEvitarMaplink(strAvoid: String): TArray<String>;
    procedure pConfiguraCarregamentoNaFilial(cdsTmpDoc: TUniClientDataSet);
    procedure pCriaCdsMapsDistanceMatrix(var cdsRomRet, cdsTmpDoc: TUniClientDataSet);
    function fSubstituiOrdImp(var cdsTmpDoc: TUniClientDataSet; var arrOrdImpOri: Array Of Integer): Integer;
    function fRetPontoInicial(strNumeroRomaneio, strEmpresaRomaneio: String): String;
  public
    procedure pProcessarCalculoRotaMapsDistanceMatrix;
  end;

implementation

{ TProcessaCalculoRotaMapsDistanceMatrix }

uses untMaplinkMultiGeocode, untMaplinkPlanning, untCitelOsrmTripApi;

function TProcessaCalculoRotaMapsDistanceMatrix.fRetEvitar(strAvoid: String): TAvoid;
begin
  Result := none;
  case AnsiIndexStr(strAvoid, ['tolls', 'highways','ferries']) of
    1: Result := tolls;
    2: Result := highways;
    3: Result := ferries;
  end;
end;

function TProcessaCalculoRotaMapsDistanceMatrix.fRetEvitarMaplink(strAvoid: String): TArray<String>;
var
  strDelimitador: String;
begin
  Result := nil;

  if fEmptyStr(strAvoid) then
    Exit;

  strDelimitador := ',';
  Result := strAvoid.Split(strDelimitador);
end;

procedure TProcessaCalculoRotaMapsDistanceMatrix.pConfiguraCarregamentoNaFilial(cdsTmpDoc: TUniClientDataSet);
var
  cdsFilial: TUniCLientDataSet;
begin
  cdsFilial := TUniClientDataSet.Create(nil);
  try
    pCloneDataSet(cdsFilial, cdsTmpDoc);

    cdsFilial.Filtered := False;
    cdsFilial.Filter := 'GER_FILIAL = '+QuotedStr('S');
    cdsFilial.Filtered := True;
    while not cdsFilial.Eof do
    begin
      cdsTmpDoc.Filtered := False;
      cdsTmpDoc.Filter := 'GER_CODEMP = '+QuotedStr(cdsFilial.FieldByName('GER_CODEMP').AsString)+' AND '+
                          'GER_FILIAL = '+QuotedStr('N');
      cdsTmpDoc.Filtered := True;

      while not cdsTmpDoc.Eof do
      begin
        cdsTmpDoc.Edit;
        cdsTmpDoc.FieldByName('CARGANAFILIAL').AsString := cdsFilial.FieldByName('GER_CODEMP').AsString;
        cdsTmpDoc.Post;

        cdsTmpDoc.Next;
      end;

      cdsFilial.Next;
    end;

  finally
    cdsTmpDoc.Filtered := False;
    cdsFilial.Free;
  end;

end;

function fGravaRomRet(cdsRomRet: TUniClientDataSet; strNumRom, strCodEmp: String): Boolean;
var
  qryRomRet: IQuery;
begin
  Result := True;

  cdsRomRet.First;

  qryRomRet := fCriaQuery;
  try
    try
      qryRomRet.Close;
      qryRomRet.SQL.Text :=
      ' DELETE FROM ROMRET '+
      ' WHERE '+
      '   RET_NUMROM = :NUMROM AND '+
      '   RET_EMPROM = :EMPROM ';

      qryRomRet.ParamByName('NUMROM').AsString := strNumRom;
      qryRomRet.ParamByName('EMPROM').AsString := strCodEmp;
      qryRomRet.ExecSQL;

      if (cdsRomRet.FieldByName('RET_DISTAN').AsFloat > 0.00) and
         (cdsRomRet.FieldByName('RET_TMPRET').AsFloat > 0.00) then
      begin
        qryRomRet.Close;
        qryRomRet.SQL.Text :=
        ' INSERT INTO ROMRET '+
        '  (AUTOINCREM, '+
        '   RET_DISTAN, '+
        '   RET_TMPRET, '+
        '   RET_NUMROM, '+
        '   RET_EMPROM) '+
        ' VALUES '+
        '  (:AUTINC, '+
        '   :DISTAN, '+
        '   :TMPRET, '+
        '   :NUMROM, '+
        '   :EMPROM) ';

        qryRomRet.ParamByName('AUTINC').AsString := fRetAutoIncrem('ROMRET', strCodEmp);;
        qryRomRet.ParamByName('DISTAN').AsFloat  := cdsRomRet.FieldByName('RET_DISTAN').AsFloat;
        qryRomRet.ParamByName('TMPRET').AsFloat  := cdsRomRet.FieldByName('RET_TMPRET').AsFloat;
        qryRomRet.ParamByName('NUMROM').AsString := strNumRom;
        qryRomRet.ParamByName('EMPROM').AsString := strCodEmp;

        qryRomRet.ExecSQL;
      end;
    except
      Result := False;
    end;
  finally
    cdsRomRet.EmptyDataSet;
  end;
end;

procedure TProcessaCalculoRotaMapsDistanceMatrix.pCriaCdsMapsDistanceMatrix(var cdsRomRet, cdsTmpDoc : TUniClientDataSet);
begin
  cdsRomRet := TUniClientDataSet.Create(nil);
  cdsRomRet.FieldDefs.Add('RET_DISTAN', ftFloat);
  cdsRomRet.FieldDefs.Add('RET_TMPRET', ftFloat);
  cdsRomRet.CreateDataSet;

  cdsTmpDoc := TUniClientDataSet.Create(nil);
  cdsTmpDoc.FieldDefs.Add('GER_MARDES',    ftString, 01);
  cdsTmpDoc.FieldDefs.Add('AUTOINCREM',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_CODEMP',    ftString, 03);
  cdsTmpDoc.FieldDefs.Add('GER_ENDCON',    ftString, 80);
  cdsTmpDoc.FieldDefs.Add('GER_BAIRRO',    ftString, 30);
  cdsTmpDoc.FieldDefs.Add('GER_NOMCID',    ftString, 40);
  cdsTmpDoc.FieldDefs.Add('GER_ESTADO',    ftString, 02);
  cdsTmpDoc.FieldDefs.Add('GER_CEPCON',    ftString, 08);
  cdsTmpDoc.FieldDefs.Add('GER_LOCALI',    ftString, 30);
  cdsTmpDoc.FieldDefs.Add('GER_DISTAN',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('GER_TMPENT',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('PRIORIDADE',    ftInteger   );
  cdsTmpDoc.FieldDefs.Add('GER_EVITAR',    ftString, 150);
  cdsTmpDoc.FieldDefs.Add('CARGANAFILIAL', ftString, 03);
  cdsTmpDoc.FieldDefs.Add('GER_FILIAL',    ftString, 01);
  cdsTmpDoc.FieldDefs.Add('GER_ORDIMP',    ftInteger   );
  cdsTmpDoc.FieldDefs.Add('GER_INIPAR',    ftString, 300);
  cdsTmpDoc.FieldDefs.Add('GER_FINROT',    ftString, 300);
  cdsTmpDoc.FieldDefs.Add('GER_ALTEND',    ftString, 1);
  cdsTmpDoc.FieldDefs.Add('GER_LATLON',    ftString, 100);
  cdsTmpDoc.FieldDefs.Add('GER_FSTSHT',    ftString, 15);
  cdsTmpDoc.FieldDefs.Add('GER_ESPDOC',    ftString, 2);
  cdsTmpDoc.FieldDefs.Add('GER_AUTINC',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_NOMTBL',    ftString, 20);
  cdsTmpDoc.FieldDefs.Add('GER_PESBRU',    ftFloat     );
  cdsTmpDoc.FieldDefs.Add('GER_VOLUME',    ftFloat     );
  cdsTmpDoc.CreateDataSet;

  cdsTmpDoc.IndexFieldNames := 'GER_ORDIMP';
end;

function TProcessaCalculoRotaMapsDistanceMatrix.fSubstituiOrdImp(var cdsTmpDoc: TUniClientDataSet;
                                                                 var arrOrdImpOri: Array Of Integer): Integer;
var
  intCount,
  intCountOrdImp: Integer;
  intOrdImp: Integer;
begin
  intOrdImp := 999999;
  intCountOrdImp := 0;

  for intCount := 0 to Length(arrOrdImpOri)-1 do
  begin
    if (arrOrdImpOri[intCount] < intOrdImp) and
       (arrOrdImpOri[intCount] > -1) then
    begin
      intOrdImp := arrOrdImpOri[intCount];
      intCountOrdImp := intCount;
    end;
  end;

  arrOrdImpOri[intCountOrdImp] := -1;

  Result := intOrdImp;
end;

function TProcessaCalculoRotaMapsDistanceMatrix.fRetPontoInicial(strNumeroRomaneio, strEmpresaRomaneio: String): String;
var
  qryPtoIni: IQuery;
begin
  Result := '';

  qryPtoIni := fCriaQuery;

  qryPtoIni.Close;
  qryPtoIni.SQL.Text :=
  ' SELECT '+
  '   GER_ENDENT, '+
  '   GER_BAIENT, '+
  '   GER_CEPENT, '+
  '   CID_ESTADO, '+
  '   CID_NOMCID, '+
  '   GER_LATLON  '+
  ' FROM '+
  '   ROMGERX '+
  ' INNER JOIN CADCID ON '+
  '   GER_CIDENT = CID_CODCID '+
  ' WHERE '+
  '   GER_DTABAI IS NOT NULL AND '+
  '   GER_NUMROM = :NUMROM AND '+
  '   GER_EMPROM = :EMPROM '+
  ' ORDER BY '+
  '   GER_DTABAI DESC, '+
  '   GER_HORBAI DESC '+
  ' LIMIT 1 ';

  qryPtoIni.ParamByName('NUMROM').AsString := strNumeroRomaneio;
  qryPtoIni.ParamByName('EMPROM').AsString := strEmpresaRomaneio;
  qryPtoIni.Open;

  if fCfgSis('APIROT', varString) = 'GOOGLE' then
  begin
    if not qryPtoIni.IsEmpty then
      Result := IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_ENDENT').AsString), qryPtoIni.FieldByName('GER_ENDENT').AsString+' - ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_BAIENT').AsString), qryPtoIni.FieldByName('GER_BAIENT').AsString+', ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('CID_NOMCID').AsString), qryPtoIni.FieldByName('CID_NOMCID').AsString+' - ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('CID_ESTADO').AsString), qryPtoIni.FieldByName('CID_ESTADO').AsString+', ', '')+
                IIF(not fEmptyStr(qryPtoIni.FieldByName('GER_CEPENT').AsString), qryPtoIni.FieldByName('GER_CEPENT').AsString+', ', '')+
                'Brazil'
  end
  else if fCfgSis('APIROT', varString) = 'MAPLINK' then
    Result := qryPtoIni.FieldByName('GER_LATLON').AsString
  else if fCfgSis('APIROT', varString) = 'CITEL' then
    Result := qryPtoIni.FieldByName('GER_LATLON').AsString;
end;

procedure TProcessaCalculoRotaMapsDistanceMatrix.pProcessarCalculoRotaMapsDistanceMatrix;
var
  blnComita: Boolean;
  cdsRomRet,
  cdsTmpDoc : TUniClientDataSet;
  qryRota: IQuery;

  arrOrdImpOri: Array Of Integer;

  strNumRom,
  strEmpRom,
  strReoAutInc : String;

  blnProcessado: Boolean;
  strMsgRetorno: String;
begin
  blnProcessado := False;
  strMsgRetorno := EmptyStr;

  qryRota := fCriaQuery;
  try
    qryRota.Close;
    qryRota.SQL.Text :=
    ' SELECT '+
    '   R.AUTOINCREM, '+
    '   RR.AUTOINCREM AS REO_AUTINC, '+
    '   IF(RR.REO_SEQGER = R.AUTOINCREM, 1, GER_PRIORI) AS PRIORIDADE, '+
    '   R.GER_ORDIMP, '+
    '   R.GER_CODEMP, '+
    '   R.GER_ENDENT, '+
    '   R.GER_BAIENT, '+
    '   C.CID_NOMCID, '+
    '   C.CID_ESTADO, '+
    '   R.GER_CEPENT, '+
    '   R.GER_EVITAR, '+
    '   R.GER_FILIAL, '+
    '   R.GER_INIPAR, '+
    '   R.GER_FINROT, '+
    '   R.GER_ALTEND, '+
    '   R.GER_LATLON, '+
    '   R.GER_FSTSHT, '+
    '   R.GER_ESPDOC, '+
    '   R.GER_AUTINC, '+
    '   R.GER_NOMTAB AS GER_NOMTBL, '+
    '   R.GER_PESBRU, '+
    '   R.GER_VOLUME, '+
    '   RR.REO_NUMROM, '+
    '   RR.REO_EMPROM '+
    ' FROM '+
    '   REOROM RR '+
    ' INNER JOIN ROMGERX R ON '+
    '   RR.REO_NUMROM = R.GER_NUMROM AND '+
    '   RR.REO_EMPROM = R.GER_EMPROM AND '+
    '   R.GER_DTABAI IS NULL '+
    ' INNER JOIN CADCID C ON '+
    '   R.GER_CIDENT = C.CID_CODCID '+
    ' WHERE '+
    '   RR.REO_EXECUT = "N" AND '+
    '   RR.REO_EMPROM = :EMPROM ';

    qryRota.ParamByName('EMPROM').AsString := VS_strCodEmp;
    qryRota.Open;

    if qryRota.IsEmpty then
      Exit;

    strNumRom := qryRota.FieldByName('REO_NUMROM').AsString;
    strEmpRom := qryRota.FieldByName('REO_EMPROM').AsString;
    strReoAutInc := qryRota.FieldByName('REO_AUTINC').AsString;

    pCriaCdsMapsDistanceMatrix(cdsRomRet, cdsTmpDoc);
    try
      qryRota.First;
      while not qryRota.Eof do
      begin
        SetLength(arrOrdImpOri, Length(arrOrdImpOri)+1);
        arrOrdImpOri[Length(arrOrdImpOri)-1] := qryRota.FieldByName('GER_ORDIMP').AsInteger;

        cdsTmpDoc.Append;
        cdsTmpDoc.FieldByName('GER_MARDES').AsString  := 'M';
        cdsTmpDoc.FieldByName('AUTOINCREM').AsString  := qryRota.FieldByName('AUTOINCREM').AsString;
        cdsTmpDoc.FieldByName('GER_CODEMP').AsString  := qryRota.FieldByName('GER_CODEMP').AsString;
        cdsTmpDoc.FieldByName('GER_ENDCON').AsString  := qryRota.FieldByName('GER_ENDENT').AsString;
        cdsTmpDoc.FieldByName('GER_BAIRRO').AsString  := qryRota.FieldByName('GER_BAIENT').AsString;
        cdsTmpDoc.FieldByName('GER_NOMCID').AsString  := qryRota.FieldByName('CID_NOMCID').AsString;
        cdsTmpDoc.FieldByName('GER_ESTADO').AsString  := qryRota.FieldByName('CID_ESTADO').AsString;
        cdsTmpDoc.FieldByName('GER_CEPCON').AsString  := qryRota.FieldByName('GER_CEPENT').AsString;
        cdsTmpDoc.FieldByName('GER_LOCALI').AsString  := '';
        cdsTmpDoc.FieldByName('PRIORIDADE').AsInteger := qryRota.FieldByName('PRIORIDADE').AsInteger;
        cdsTmpDoc.FieldByName('GER_EVITAR').AsString  := qryRota.FieldByName('GER_EVITAR').AsString;
        cdsTmpDoc.FieldByName('GER_FILIAL').AsString  := qryRota.FieldByName('GER_FILIAL').AsString;
        cdsTmpDoc.FieldByName('GER_ORDIMP').AsInteger := qryRota.FieldByName('GER_ORDIMP').AsInteger;
        cdsTmpDoc.FieldByName('GER_INIPAR').AsString  := qryRota.FieldByName('GER_INIPAR').AsString;
        cdsTmpDoc.FieldByName('GER_FINROT').AsString  := qryRota.FieldByName('GER_FINROT').AsString;
        cdsTmpDoc.FieldByName('GER_ALTEND').AsString  := qryRota.FieldByName('GER_ALTEND').AsString;
        cdsTmpDoc.FieldByName('GER_LATLON').AsString  := qryRota.FieldByName('GER_LATLON').AsString;
        cdsTmpDoc.FieldByName('GER_FSTSHT').AsString  := qryRota.FieldByName('GER_FSTSHT').AsString;
        cdsTmpDoc.FieldByName('GER_ESPDOC').AsString  := qryRota.FieldByName('GER_ESPDOC').AsString;
        cdsTmpDoc.FieldByName('GER_AUTINC').AsString  := qryRota.FieldByName('GER_AUTINC').AsString;
        cdsTmpDoc.FieldByName('GER_NOMTBL').AsString  := qryRota.FieldByName('GER_NOMTBL').AsString;
        cdsTmpDoc.FieldByName('GER_PESBRU').AsFloat   := qryRota.FieldByName('GER_PESBRU').AsFloat;
        cdsTmpDoc.FieldByName('GER_VOLUME').AsFloat   := qryRota.FieldByName('GER_VOLUME').AsFloat;
        cdsTmpDoc.Post;

        qryRota.Next;
      end;

      pConfiguraCarregamentoNaFilial(cdsTmpDoc);

      if fCfgSis('APIROT', varString) = 'GOOGLE' then
        TControllerMapsDistanceMatrix.pProcessarMapsDistanceMatrix(cdsTmpDoc,
                                                                   cdsRomRet,
                                                                   ordNone,
                                                                   fRetEvitar(cdsTmpDoc.FieldByName('GER_EVITAR').AsString),
                                                                   blnProcessado,
                                                                   fRetPontoInicial(qryRota.FieldByName('REO_NUMROM').AsString,
                                                                                    qryRota.FieldByName('REO_EMPROM').AsString),
                                                                   False,
                                                                   True)
      else if fCfgSis('APIROT', varString) = 'MAPLINK' then
      begin
        if TControllerMaplinkMultiGeocode.fRetCoordenadasDosEnderecos(cdsTmpDoc, strMsgRetorno) then
        begin
          blnProcessado := TControllerMaplinkPlanning.fPlanejarRota(cdsTmpDoc,
                                                                    cdsRomRet,
                                                                    cdsTmpDoc.FieldByName('GER_FSTSHT').AsString,
                                                                    fRetEvitarMaplink(cdsTmpDoc.FieldByName('GER_EVITAR').AsString),
                                                                    False,
                                                                    strMsgRetorno,
                                                                    fRetPontoInicial(qryRota.FieldByName('REO_NUMROM').AsString,
                                                                                     qryRota.FieldByName('REO_EMPROM').AsString));
        end;
      end
      else if fCfgSis('APIROT', varString) = 'CITEL' then
      begin
        if TControllerMaplinkMultiGeocode.fRetCoordenadasDosEnderecos(cdsTmpDoc, strMsgRetorno) then
        begin
          blnProcessado := TCitelOsrmTripApi.fPlanejarRota(cdsTmpDoc,
                                                           cdsRomRet,
                                                           strMsgRetorno,
                                                           fRetPontoInicial(qryRota.FieldByName('REO_NUMROM').AsString,
                                                                            qryRota.FieldByName('REO_EMPROM').AsString));
        end;
      end;

      if not blnProcessado then
        Exit;

      fStartTransaction;

      cdsTmpDoc.Filtered := False;
      cdsTmpDoc.First;
      while not cdsTmpDoc.Eof do
      begin
        qryRota.Close;
        qryRota.SQL.Text :=
        ' UPDATE '+
        '   ROMGERX '+
        ' SET '+
        '   GER_ORDIMP = :ORDIMP '+
        '  ,GER_DISTAN = :DISTAN '+
        '  ,GER_TMPENT = :TMPENT '+
        '  ,GER_LOCALI = :LOCALI '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryRota.ParamByName('ORDIMP').AsInteger := fSubstituiOrdImp(cdsTmpDoc, arrOrdImpOri);
        qryRota.ParamByName('DISTAN').AsFloat   := cdsTmpDoc.FieldByName('GER_DISTAN').AsFloat;
        qryRota.ParamByName('TMPENT').AsFloat   := cdsTmpDoc.FieldByName('GER_TMPENT').AsFloat;
        qryRota.ParamByName('LOCALI').AsString  := cdsTmpDoc.FieldByName('GER_LOCALI').AsString;
        qryRota.ParamByName('AUTINC').AsString  := cdsTmpDoc.FieldByName('AUTOINCREM').AsString;
        qryRota.ExecSQL;

        cdsTmpDoc.Next;
      end;

      blnComita := fGravaRomRet(cdsRomRet, strNumRom, strEmpRom);

      if blnComita then
      begin
        qryRota.Close;
        qryRota.SQL.Text :=
        ' UPDATE '+
        '   REOROM '+
        ' SET '+
        '   REO_EXECUT = "S" '+
        ' WHERE '+
        '   AUTOINCREM = :AUTINC ';

        qryRota.ParamByName('AUTINC').AsString := strReoAutInc;
        qryRota.ExecSQL;

        fCommit;
      end
      else
        fRollback;

    finally
      cdsRomRet.Free;
      cdsTmpDoc.Free;
    end;

  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message);
      if fInTransaction then
        fRollback;
    end;
  end;

end;

end.
