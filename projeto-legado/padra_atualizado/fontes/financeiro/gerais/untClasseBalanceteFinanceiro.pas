unit untClasseBalanceteFinanceiro;

interface

uses Classes, DB, untFuncoesSimples, Uni, untTypesSistema;

Type TCadClaCCu = Class (TComponent)

  private
    FAutInc: String;
    FCodEmp: String;
    FCodCCu: String;
    FDesCCu: String;
    FDesRe1: String;
    FDesRe2: String;
    FDesRe3: String;

    procedure setCodCCu(const Value: String);
    procedure setDesCCu(const Value: String);
    procedure setDesRe1(const Value: String);
    procedure setDesRe2(const Value: String);
    procedure setDesRe3(const Value: String);
  public
    qryClaCCu: TUniQuery;
    arrDefCam: TArrDefCam;

    property strAutInc: String Read FAutInc Write FAutInc;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strCodCCu: String Read FCodCCu Write setCodCCu;
    property strDesCCu: String Read FDesCCu Write setDesCCu;
    property strDesRe1: String Read FDesRe1 Write setDesRe1;
    property strDesRe2: String Read FDesRe2 Write setDesRe2;
    property strDesRe3: String Read FDesRe2 Write setDesRe3;

    class function fRetSQLCadCta: String;
    class function fRetSQLCadCCC: String;
    class function fRetSQLTitCla(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
    class function fRetSQLNaoVin(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
    class function fRetSQLValCla(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
    class function fRetCtrEmAberto(strCodPor: String): Double;
    class function fRetChqEmAberto(strCodPor: String): Double;
    class function fRetSqlBase(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;

    constructor Create(Owner: TComponent); reintroduce;
  end;

Const
  arrCampos : Array[0..6] Of String     = ('CCC_CODIGO', 'CCC_DESCRI', 'CCC_DESRE1', 'CCC_DESRE2', 'CCC_DESRE3', 'CCC_CODEMP', 'AUTOINCREM');
  arrDescri : Array[0..6] Of String     = ('Código', 'Descrição', 'Desc. Reduzida 1', 'Desc. Reduzida 2', 'Desc. Reduzida 3', 'Emp.', 'AUTOINCREM');
  arrTipCam : Array[0..6] Of TFieldType = (ftString, ftString, ftString, ftString, ftString, ftString, ftString);
  arrTamCam : Array[0..6] Of Integer    = (4, 40, 10, 10, 10, 3, 20);
  arrVisible: Array[0..6] Of Boolean    = (True, True, True, True, True, True, False);
  arrFormat : Array[0..6] Of String     = ('', '', '', '', '', '', '');

implementation

uses SysUtils, StrUtils, untFuncoesConsulta;

{ TCadClaCCu }

constructor TCadClaCCu.Create(Owner: TComponent);
  Var
    intCon: Integer;
begin
  Try
    SetLength(arrDefCam, 5);

    For intCon := 0 To Length(arrDefCam)-1 Do
    Begin
      arrDefCam[intCon].strNomCam  := arrCampos[intCon];
      arrDefCam[intCon].strDesCri  := arrDescri[intCon];
      arrDefCam[intCon].ftpTipCam  := arrTipCam[intCon];
      arrDefCam[intCon].intTamCam  := arrTamCam[intCon];
      arrDefCam[intCon].blnVisible := arrVisible[intCon];
      arrDefCam[intCon].strFormat  := arrFormat[intCon];
    End;

    qryClaCCu := fCriaQuery(Self);
    With qryClaCCu Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CADCCC WHERE FALSE');
      Open;
    End;

    FAutInc := '';
    FCodEmp := '';
    FCodCCu := '';
    FDesCCu := '';
    FDesRe1 := '';
    FDesRe2 := '';
    FDesRe3 := '';
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadClaCCu!' + #13 + E.Message);
  End;
end;

class function TCadClaCCu.fRetChqEmAberto(strCodPor: String): Double;
  Var
    strSQL: String;
    qryChq: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(IFNULL(CHQ_VALCHQ, 0)) AS VAL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ((CHQ_DTADEP IS NULL) OR ';
    strSQL := strSQL + '  ((CHQ_DTADEP IS NOT NULL) AND ';
    strSQL := strSQL + '   (CHQ_DTADEV IS NOT NULL) AND ';
    strSQL := strSQL + '   (CHQ_DTADP2 IS NULL))) AND ';
    strSQL := strSQL + '  CHQ_CODPOR = :CODPOR ';

    qryChq := fCriaQuery;
    With qryChq Do
    Begin
      Close;
      SQL.Text := 'SELECT SUM(VAL) AS CHQ_ABERTO FROM (' + strSQL + ') AS TABELA';
      ParamByName('CODPOR').AsString := strCodPor;
      Open;

      If Not IsEmpty Then Result := FieldByName('CHQ_ABERTO').AsFloat
      Else Result := 0;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
  FreeAndNil(qryChq);

end;

class function TCadClaCCu.fRetCtrEmAberto(strCodPor: String): Double;
  Var
    strSQL: String;
    qryCtr: TUniQuery;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  SUM(CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) AS VAL ';
    strSQL := strSQL + 'FROM                     ';
    strSQL := strSQL + '  CADREC                 ';
    strSQL := strSQL + 'WHERE                    ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL AND ';
    strSQL := strSQL + '  CTR_CODPOR = :CODPOR   ';

    qryCtr := fCriaQuery;
    With qryCtr Do
    Begin
      Close;
      SQL.Text := 'SELECT SUM(VAL) AS CTR_ABERTO FROM (' + strSQL + ') AS TABELA ';
      ParamByName('CODPOR').AsString := strCodPor;
      Open;

      Result := FieldByName('CTR_ABERTO').AsFloat;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
  FreeAndNil(qryCtr);
end;

class function TCadClaCCu.fRetSQLCadCCC: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  CCC_CODIGO,       ';
  Result := Result + '  CCC_DESCRI,       ';
  Result := Result + '  CCC_DESRE1,       ';
  Result := Result + '  CCC_DESRE2,       ';
  Result := Result + '  CCC_DESRE3,       ';
  Result := Result + '  AUTOINCREM        ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADCCC            ';
  Result := Result + 'WHERE               ';
  Result := Result + '  TRUE              ';
  Result := Result + 'ORDER BY            ';
  Result := Result + '  CCC_CODIGO        ';
end;

class function TCadClaCCu.fRetSQLCadCta: String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  CTA_CODCTA,       ';
  Result := Result + '  CTA_DESCTA,       ';
  Result := Result + '  CTA_CODCCC,       ';
  Result := Result + '  AUTOINCREM        ';
  Result := Result + 'FROM                ';
  Result := Result + '  CADCTA            ';
  Result := Result + 'WHERE               ';
  Result := Result + '  RIGHT(CTA_CODCTA, 3) <> ' + QuotedStr('000');
  Result := Result + 'ORDER BY            ';
  Result := Result + '  CTA_CODCTA        ';
end;

class function TCadClaCCu.fRetSQLNaoVin(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  SUM(CTB_VALLAN) AS CTB_VALLAN, ';
  Result := Result + '  CTB_CODCTA, ';
  Result := Result + '  CTA_DESCTA  ';
  Result := Result + 'FROM ( ';
  Result := Result + fRetSqlBase(intTipFil, arrCodPor, objCodPor, '');
  Result := Result + ') AS TABELA  ';
  Result := Result + 'WHERE ';
  Result := Result + '  CCC_CODIGO IS NULL ';
  Result := Result + 'GROUP BY ';
  Result := Result + '  CTB_CODCTA, CTA_DESCTA ';
  Result := Result + 'ORDER BY ';
  Result := Result + '  CTB_CODCTA, CTA_DESCTA ';
end;

class function TCadClaCCu.fRetSQLTitCla(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  * ';
  Result := Result + 'FROM ( ';
  Result := Result + fRetSqlBase(intTipFil, arrCodPor, objCodPor, strEmpPar);
  Result := Result + ') AS TABELA  ';
  Result := Result + 'WHERE ';
  Result := Result + '  CCC_CODIGO IS NOT NULL ';
  Result := Result + 'GROUP BY      ';
  Result := Result + '  CCC_CODIGO, CCC_TIPOPE, CTB_CREDEB ';
  Result := Result + 'ORDER BY      ';
  Result := Result + '  CCC_TIPOPE, CCC_CODIGO ';
end;

class function TCadClaCCu.fRetSQLValCla(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  CCC_CODIGO, ';
  Result := Result + '  POR_CODPOR AS CTB_CODPOR, ';
  Result := Result + '  CTB_CODCTA, ';
  Result := Result + '  CTB_DTALAN, ';
  Result := Result + '  SUM(CTB_VALLAN) AS CTB_VALLAN, ';
  Result := Result + '  CTB_CREDEB, ';
  Result := Result + '  CCC_TIPOPE  ';
  Result := Result + 'FROM ( ';
  Result := Result + fRetSqlBase(intTipFil, arrCodPor, objCodPor, strEmpPar);
  Result := Result + ') AS TABELA   ';
  Result := Result + 'GROUP BY      ';
  Result := Result + '  CCC_TIPOPE, ';
  Result := Result + '  CCC_CODIGO, ';
  Result := Result + '  POR_CODPOR  ';
  Result := Result + 'ORDER BY      ';
  Result := Result + '  CCC_TIPOPE, ';
  Result := Result + '  CTB_CREDEB, ';
  Result := Result + '  CCC_CODIGO  ';
end;

procedure TCadClaCCu.setCodCCu(const Value: String);
begin
  FCodCCu := Value;
end;

procedure TCadClaCCu.setDesCCu(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FDesCCu := Value
  Else
    Raise Exception.Create('A Descrição deve ser preenchida!');
end;

procedure TCadClaCCu.setDesRe1(const Value: String);
begin
  FDesRe1 := Value;
end;

procedure TCadClaCCu.setDesRe2(const Value: String);
begin
  FDesRe2 := Value;
end;

procedure TCadClaCCu.setDesRe3(const Value: String);
begin
  FDesRe3 := Value;
end;

class function TCadClaCCu.fRetSqlBase(intTipFil: Integer; arrCodPor: TConsultasArray; objCodPor: TObject; strEmpPar: String): String;
Begin
  Result := 'SELECT SQL_NO_CACHE ' +
            '  CCC_CODIGO, ' +
            '  CONCAT(IFNULL(CCC_DESRE1, ""), " ", IFNULL(CCC_DESRE2, ""), " ", IFNULL(CCC_DESRE3, "")) AS CCC_DESCRI, ' +
            '  POR_CODPOR, ' +
            '  CONCAT(LEFT(CTB_CODCTA, 2), ".", SUBSTR(CTB_CODCTA, 3,3), ".", RIGHT(CTB_CODCTA, 3)) AS CTB_CODCTA, ' +
            '  CTA_DESCTA, ' +
            '  CTB_DTALAN, ' +
            '  IF(CTB_CREDEB = "C", CTB_VALLAN, -CTB_VALLAN) AS CTB_VALLAN, ' +
            '  CTB_CREDEB, ' +
            '  IF(CCC_TIPOPE = 1, "E", IF(CCC_TIPOPE = 2, "S", "E/S")) AS CCC_TIPOPE ' +
            'FROM ' +
            '  CADPOR ' +
            '  LEFT JOIN MOVBAN ON POR_CODPOR = CTB_CODPOR '+
            '                  AND CTB_DTALAN BETWEEN IF(POR_DTAINI > :DTAINI, POR_DTAINI, :DTAINI) '+
            '                                     AND :DTAFIN ' +
            '  LEFT JOIN CADCTA ON CTB_CODCTA = CTA_CODCTA ' +
            '  LEFT JOIN CADCCC ON CTA_CODCCC = CCC_CODIGO ' +
            'WHERE ' +
            '  TRUE ';

  If Not fEmptyStr(strEmpPar) Then
    Result := Result + ' AND LOCATE(CTB_CODEMP, "' + strEmpPar + '") > 0 ';

  If (intTipFil = 0) Then
    Result := Result + ' AND CTB_DTACON IS NOT NULL '
  Else
  If (intTipFil = 1) Then
    Result := Result + ' AND CTB_DTACON IS NULL ';

  Result := Result + fStrLocate(objCodPor, arrCodPor, 'POR_CODPOR', 'CODPOR');
End;

end.
