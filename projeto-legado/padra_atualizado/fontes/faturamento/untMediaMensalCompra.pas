unit untMediaMensalCompra;

interface

Uses SysUtils, Uni, untGravando, untFuncoesSimples, StrUtils, untConstantes,
ComboBoxFocus;

Type
  TMediaCompraResult = Array[0..2] of Array[0..1] of Double;
  Const
    arrMediaCompraDias : Array of Integer = [90, 180, 360];

  Function fMediaDeCompra(strCodCli : String) : TMediaCompraResult;
  Function fGetSQL : String;


implementation

Function fGetSQL : String;
  Var
    strSQL       : String;
    strCusTmp    : String;
Begin

  strCusTmp := fRetornaComposicaoPadrao;

  strSQL := '';
  strSQL := strSQL + ' SELECT SUM(IF((D.DET_ESPDOC = "BR") OR LOCATE(D.DET_CLAFIS,' + CLAFIS_BR + '), 0.00,  ';
  strSQL := strSQL + '   IF(LEFT(D.DET_CLAFIS,1) < 5, -(D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF),         ';
  strSQL := strSQL + '                                  D.DET_TOTITE - D.DET_DESESP - D.DET_DESCFF))) TOTITE,';
  strSQL := strSQL + '        SUM(IF(LEFT(D.DET_CLAFIS,1) < 5, -(' + strCusTmp + '), ' + strCusTmp + ')) AS  TOTCUS ';
  strSQL := strSQL + ' FROM MOVDET D                                                                         ';
  strSQL := strSQL + '      INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM                               ';
  strSQL := strSQL + '      LEFT  JOIN MOVICD ON     ICD_SEQGER = D.AUTOINCREM AND D.DET_VALRET = 0          ';
  strSQL := strSQL + ' WHERE '+cnsFiltroFFDVTR+' D.DET_PROEMB <> "S"                                         ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = "C"                                                              ';
  strSQL := strSQL + '   AND D.DET_CODCLI = :CODCLI                                                          ';
  strSQL := strSQL + '   AND D.DET_CODEMP = :CODEMP                                                          ';
  strSQL := strSQL + '   AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN                                        ';
  strSQL := strSQL + '   AND ((LOCATE(D.DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(D.DET_CLAFIS, :CLADEV) > 0))    ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL, ['D.']);
End;

Function fMediaDeCompra(strCodCli : String) : TMediaCompraResult;
  Var
    qryQuery : TUniQuery;
    intIndex : Integer;
Begin
  Try
    qryQuery := fCriaQuery;
    With qryQuery, SQL Do
    Begin
      Close;
      Clear;
      Add( fGetSQL );

      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('CLAFIS').AsString   := VS_strClaVen;
      ParamByName('CLADEV').AsString   := VS_strClaDev;
      ParamByName('DTAFIN').AsDateTime := fNow() -1;

      For intIndex := 0 To High(arrMediaCompraDias) Do
      Begin
        Close;
        ParamByName('DTAINI').AsDateTime := fNow() - 1 - arrMediaCompraDias[intIndex];
        Open;

        Result[intIndex][0] := FieldByName('TOTITE').AsFloat;
        Result[intIndex][1] := fCalculaPrecoVenda(2, FieldByName('TOTCUS').AsFloat,
                                                  FieldByName('TOTITE').AsFloat, 0, 0, 0, 0, 0);
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryQuery);
  End;

End;

end.
