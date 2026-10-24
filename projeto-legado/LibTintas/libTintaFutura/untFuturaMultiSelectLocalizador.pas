unit untFuturaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TFuturaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

  TFuturaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TFuturaMultiSelectLocalizador }

constructor TFuturaMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT FUT_MD5KEY FROM FUT_CADFUT WHERE FALSE', 'FUT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   FUT_CADFUT               ' +
      ' WHERE FUT_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
   ' SELECT  ' +
   '  	*    ' +
   ' FROM    ' +
   '  	FUT_CADFUT ' +
   ' WHERE   ' +
   '  	CONCAT(IFNULL(FUT_REFERE, ""), ' +
   ' 	         IFNULL(FUT_UNIDAD, ""), ' +
   '        	 IFNULL(FUT_PRODUT, ""), ' +
   ' 	         IFNULL(FUT_SPRODU, ""), ' +
   '       	   IFNULL(FUT_CODBAS, "")) = :ITETIN ');

  Sqls.Add( fGetUnionTin );
end;

function TFuturaMultiSelectLocalizador.fGetFields(strAbr: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 1 To MAX_QTD_BAS Do
  Begin
    Result := Result + strAbr + 'FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' AS FUT_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
    Result := Result + '(' + strAbr + 'QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' / ' + strAbr + 'QTDITE) AS FUT_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
  End;
  Result := Result + strAbr + 'DTAENT DTAENT, ' + strAbr + 'HORENT HORENT ';
end;

function TFuturaMultiSelectLocalizador.fGetSQLTin(strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL; 
end;

function TFuturaMultiSelectLocalizador.fGetUnionTin: String;

  function fGetFields: String;
    Var
      intCnt : Integer;
  begin
    Result := '';
    For intCnt := 1 To MAX_QTD_BAS Do
    Begin
      Result := Result + ' FUT_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
      Result := Result + ' FUT_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
    End;
    Result := Result + 'DTAENT, HORENT ';
  end;

  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT ';
  strSQL := strSQL + fGetFields;
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

{ TFuturaMultiSelectLocalizadorBase }

constructor TFuturaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   FUT_CADFUT C                      ' +
    '   INNER JOIN FUT_CADBAS B           ' +
    '      ON C.FUT_CODBAS = B.BAS_CODBAS ' +
    '     AND C.FUT_UNIDAD = B.BAS_CODUNI ' +
    '     AND C.FUT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.FUT_MD5KEY = :ITETIN        ');

  Sqls.Add(
    ' SELECT                               ' +
    '   B.BAS_CODITE                       ' +
    ' FROM                                 ' +
    '   FUT_CADFUT C                       ' +
    '   INNER JOIN FUT_CADBAS B            ' +
    '      ON C.FUT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.FUT_UNIDAD = B.BAS_CODUNI  ' +
    '     AND C.FUT_PRODUT = B.BAS_PRODUT  ' +
    ' WHERE	CONCAT(IFNULL(FUT_REFERE, ""), ' +
    ' 	           IFNULL(FUT_UNIDAD, ""), ' +
    '        	     IFNULL(FUT_PRODUT, ""), ' +
    ' 	           IFNULL(FUT_SPRODU, ""), ' +
    '       	     IFNULL(FUT_CODBAS, "")) = :ITETIN ');

  Sqls.Add( fGetUnionTin );
end;

function TFuturaMultiSelectLocalizadorBase.fGetFields(strAbr: String): String;
begin
  Result :=          strAbr  + 'CODITE AS CODITE, ';
  Result := Result + strAbr  + 'DTAENT AS DTAENT, ';
  Result := Result + strAbr  + 'HORENT AS HORENT  ';
end;

function TFuturaMultiSelectLocalizadorBase.fGetSQLTin(
  strTabela: String): String;
  Var
    strSQL : String;
    strAbr : String;
begin
  strSQL := '';
  If (strTabela = 'TINDET') Then
    strAbr := 'DET_'
  Else
    strAbr := 'FDO_';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + fGetFields(strAbr);
  strSQL := strSQL + '   FROM ' + strTabela;
  strSQL := strSQL + '  WHERE ' + strAbr + 'ITETIN = :ITETIN ';
  Result := strSQL;
end;

function TFuturaMultiSelectLocalizadorBase.fGetUnionTin: String;
  Var
    strSQL : String;
begin
  strSQL :=          ' SELECT * ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + ' ( ';
  strSQL := strSQL + fGetSQLTin('TINDET') + ' UNION ALL ';
  strSQL := strSQL + fGetSQLTin('TINDOR') + '  ';
  strSQL := strSQL + ' ) TMPUNION ';
  strSQL := strSQL + ' ORDER BY DTAENT DESC, HORENT DESC ';
  strSQL := strSQL + ' LIMIT 1 ';
  Result := strSQL;
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('FUT', TFuturaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('FUTBAS', TFuturaMultiSelectLocalizadorBase);

end.
