unit untFuncoesWMS;

interface

uses
  System.SysUtils, System.Types, System.Math, Uni, untFuncoesSimples,
  untFuncTinta;

function fRetornaCapacidadePicking(strCodIte, strIdePro: String): Double; overload;
function fRetornaCapacidadePicking(var strCodLoc: String; strCodIte, strIdePro: String): Double; overload;
function fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(strCodIte: String; fltQtdIte: Double; strIdePro, strProAca: String): Boolean;
function fRetWherePicLab(const strAliasCadLot: String = 'CADLOT'): String;
function fProdutoPossuiLotePicLab(strCodIte: String; blnValidaSaldo: Boolean): Boolean;

implementation

function fRetornaCapacidadePicking(strCodIte, strIdePro: String): Double;
  Var
    strCodLoc: String;
begin
  Result := fRetornaCapacidadePicking(strCodLoc, strCodIte, strIdePro);
end;

function fRetornaCapacidadePicking(var strCodLoc: String; strCodIte, strIdePro: String): Double;
  Var
    qryCapacidade: TUniQuery;
begin
  strCodLoc := EmptyStr;
  Result := 0;
  qryCapacidade := fCriaQuery;

  Try
    qryCapacidade.Close;
    qryCapacidade.SQL.Clear;
    qryCapacidade.SQL.Add('SELECT DISTINCT');
    qryCapacidade.SQL.Add('  L.LOC_CODLOC,');
    qryCapacidade.SQL.Add('  IFNULL(I.LCI_QTDMAX,0) AS QTDMAX');
    qryCapacidade.SQL.Add('FROM CADLOT C');
    qryCapacidade.SQL.Add('INNER JOIN CADLOC L ON LOC_CODLOC = LOT_LOCFIS');
    qryCapacidade.SQL.Add('                   AND LOC_CODEMP = LOT_CODEMP');
    qryCapacidade.SQL.Add('INNER JOIN LOCITE I ON LCI_LOCFIS = L.AUTOINCREM');
    qryCapacidade.SQL.Add('                   AND LCI_CODITE = C.LOT_CODITE');
    qryCapacidade.SQL.Add('WHERE LOT_CODEMP = :CODEMP');
    qryCapacidade.SQL.Add('  AND LOT_CODITE = :CODITE');
    qryCapacidade.SQL.Add('  AND LOT_NUMLOT <> "A DEFINIR"');
    qryCapacidade.SQL.Add('  AND LOC_PICKIN = "S"');
    qryCapacidade.SQL.Add('  AND IFNULL(LOC_CRITIC,"N") = "N"');
    qryCapacidade.SQL.Add('  AND IFNULL(LOC_TRANSI,"N") = "N"');
    qryCapacidade.SQL.Add('  AND IFNULL(LOC_BALCAO,"N") = "N"');
    qryCapacidade.SQL.Add('  AND LOT_STATUS = "S"');

    If fUsaPickingLaboratorioWms Then
    Begin
      If fEhTintaImobiliaria(strIdePro) Then
        qryCapacidade.SQL.Add('  AND IFNULL(LOC_PRILAB,"N") = "S"')
      Else
        qryCapacidade.SQL.Add('  AND IFNULL(LOC_PRILAB,"N") = "N"');
    End;

    qryCapacidade.SQL.Add('ORDER BY');
    qryCapacidade.SQL.Add('  LOT_DTAVAL, LOC_CODLOC');

    qryCapacidade.ParamByName('CODITE').AsString := strCodIte;
    qryCapacidade.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryCapacidade.Open;

    While Not qryCapacidade.Eof Do
    Begin
      pIncrementaListaStr(qryCapacidade.FieldByName('LOC_CODLOC').AsString, strCodLoc, True);
      Result := Result + qryCapacidade.FieldByName('QTDMAX').AsFloat;
      qryCapacidade.Next;
    End;
  Finally
    FreeAndNil(qryCapacidade);
  End;
end;

function fSugereBufferQuantSepMaiorIgualCapacidadeMaxPicking(strCodIte: String; fltQtdIte: Double; strIdePro, strProAca: String): Boolean;
  Var
    fltCapacidadePicking: Double;
begin
  Result := False;

  If Not fCfgSis('BFSGIS', varBoolean) Then
    Exit;

  If Not SameText(strIdePro, 'NOR') Then
    Exit;

  If SameText(strProAca, 'S') Then
    Exit;

  fltCapacidadePicking := fRetornaCapacidadePicking(strCodIte, strIdePro);

  If SameValue(fltCapacidadePicking, 0) Then
    Exit;

  //fltQtdIte < fltCapacidadePicking
  If CompareValue(fltQtdIte, fltCapacidadePicking) = LessThanValue Then
    Exit;

  Result := True;
end;

function fRetWherePicLab(const strAliasCadLot: String = 'CADLOT'): String;
begin
  Result := '';
  Result := Result + ' CASE WHEN EXISTS( ';
  Result := Result + ' SELECT 1 FROM CADLOT T1 ';
  Result := Result + ' JOIN CADLOC T2 ON T2.LOC_CODLOC = T1.LOT_LOCFIS AND T2.LOC_CODEMP = T1.LOT_CODEMP ';
  Result := Result + ' WHERE T1.LOT_CODITE = '+ strAliasCadLot +'.LOT_CODITE ';
  Result := Result + '   AND T1.LOT_CODEMP = '+ strAliasCadLot +'.LOT_CODEMP ';
  Result := Result + '   AND T1.LOT_SALDOS > 0 ';
  Result := Result + '   AND T2.LOC_PICKIN = "S" ';
  Result := Result + '   AND T2.LOC_PRILAB = "S" ';
  Result := Result + ' )THEN LOC_PRILAB = "S" ';
  Result := Result + '  ELSE LOC_PICKIN = "S" END ';
end;

function fProdutoPossuiLotePicLab(strCodIte: String; blnValidaSaldo: Boolean): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT LOT_NUMLOT FROM CADLOT');
    qryAux.SQL.Add('JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP');
    qryAux.SQL.Add('WHERE LOT_CODITE = :CODITE');
    qryAux.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND LOC_PICKIN = "S"');
    qryAux.SQL.Add('  AND LOC_PRILAB = "S"');

    If blnValidaSaldo Then
      qryAux.SQL.Add(' AND LOT_SALDOS > 0 ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
