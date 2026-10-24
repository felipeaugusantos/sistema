unit untTDadosDifal;

interface

uses StrUtils, Uni, untTypesSistema;

type
  TDadosDifal = class
  private
    FConexao: TUniConnection;

    function fRetParametroEmpresas(arrEmp: TConsultasArray): string;
    function fRetSQLCredito(arrEmp: TConsultasArray; strCodEmp: string): string;
    function fRetSQLDebito(arrEmp: TConsultasArray; strCodEmp: string): string;
  public
    function fRetCreditoPeriodo(dtaIni, dtaFin: TDateTime; arrEmp: TConsultasArray; strCodEmp: string = ''): Double;
    function fRetDebitoPeriodo(dtaIni, dtaFin: TDateTime; arrEmp: TConsultasArray; strCodEmp: string = ''): Double;

    constructor create(conexao: TUniConnection);
  end;

implementation

{ TDadosDifal }

constructor TDadosDifal.create(conexao: TUniConnection);
begin
  inherited create;
  FConexao := conexao;
end;

function TDadosDifal.fRetCreditoPeriodo(dtaIni, dtaFin: TDateTime; arrEmp: TConsultasArray; strCodEmp: string = ''): Double;
  var
    qryAux: TUniQuery;
begin
  qryAux := TUniQuery.Create(nil);
  qryAux.connection := FConexao;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLCredito(arrEmp, strCodEmp);
      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      if strCodEmp <> '' then
        ParamByName('CODEMP').AsString := strCodEmp
      else if Length(arrEmp) > 0 then
        ParamByName('CODEMP').AsString := fRetParametroEmpresas(arrEmp);

      Open;

      Result := FieldByName('VALOR').AsFloat;
    end;
  finally
    qryAux.Free;
  end;
end;

function TDadosDifal.fRetDebitoPeriodo(dtaIni, dtaFin: TDateTime; arrEmp: TConsultasArray; strCodEmp: string = ''): Double;
  var
    qryAux: TUniQuery;
begin
  qryAux := TUniQuery.Create(nil);
  qryAux.connection := FConexao;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLDebito(arrEmp, strCodEmp);
      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      if strCodEmp <> '' then
        ParamByName('CODEMP').AsString := strCodEmp
      else if Length(arrEmp) > 0 then
        ParamByName('CODEMP').AsString := fRetParametroEmpresas(arrEmp);

      Open;

      Result := FieldByName('VALOR').AsFloat;
    end;
  finally
    qryAux.Free;
  end;
end;

function TDadosDifal.fRetParametroEmpresas(arrEmp: TConsultasArray): string;
  var
    intIndex: integer;
begin
  Result := '';

  for intIndex := Low(arrEmp) to High(arrEmp) do
  begin
    Result := arrEmp[intIndex].strCodigo + '_';
  end;
end;

function TDadosDifal.fRetSQLCredito(arrEmp: TConsultasArray; strCodEmp: string): string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  IF((LOCATE(DET_CLAFIS, "1411_2411_1202_2202") > 0) AND (IFNULL(EMP_INSSUB, "") <> ""), ICD_VALORI, 0) AS ICD_VALORI ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVDET ';

  Result := Result + '  INNER JOIN MOVICD ';
  Result := Result + '    ON ICD_SEQGER = MOVDET.AUTOINCREM ';

  Result := Result + '  LEFT JOIN EMPISB ';
  Result := Result + '    ON EMP_CODEMP = DET_CODEMP ';
  Result := Result + '   AND EMP_ESTADO = DET_ESTADO ';

  Result := Result + 'WHERE DET_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND IFNULL(ICD_VALORI, 0) > 0 ';
  Result := Result + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  Result := Result + '  AND DET_ESPDOC = "NF" ';

  if (Length(arrEmp) > 0) or (strCodEmp <> '') then
    Result := Result + '  AND LOCATE(DET_CODEMP, :CODEMP) > 0 ';

  Result := Result + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVDET', 'NOTDET'), 'MOVICD', 'NOTICD');

  Result := 'SELECT SUM(ICD_VALORI) AS VALOR FROM (' + Result + ') AS TAB ';
end;

function TDadosDifal.fRetSQLDebito(arrEmp: TConsultasArray; strCodEmp: string): string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  IF(LOCATE(DET_CLAFIS, "1411_2411_1202_2202") > 0, 0, ICD_VALORI) AS ICD_VALORI ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVDET ';

  Result := Result + '  INNER JOIN MOVICD ';
  Result := Result + '    ON ICD_SEQGER = MOVDET.AUTOINCREM ';

  Result := Result + 'WHERE DET_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND IFNULL(ICD_VALORI, 0) > 0 ';
  Result := Result + '  AND IFNULL(DET_PROEMB, "") <> "S" ';
  Result := Result + '  AND DET_ESPDOC = "NF" ';

  if (Length(arrEmp) > 0) or (strCodEmp <> '') then
    Result := Result + '  AND LOCATE(DET_CODEMP, :CODEMP) > 0 ';

  Result := Result + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVDET', 'NOTDET'), 'MOVICD', 'NOTICD');

  Result := 'SELECT SUM(ICD_VALORI) AS VALOR FROM (' + Result + ') AS TAB ';
end;

end.
