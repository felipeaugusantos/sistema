unit untBellaCorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TBellaCorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private
    function fGetSQLTin(strTabela: String): String;
    function fGetFields(strAbr: String): String;
    function fGetUnionTin: String;
  public
    constructor Create(); override;
  end;

  TBellaCorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
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

{ TBellaCorMultiSelectLocalizador }

constructor TBellaCorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT BEL_MD5KEY FROM BEL_CADBEL WHERE FALSE', 'BEL_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   BEL_CADBEL               ' +
      ' WHERE BEL_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add( fGetUnionTin );
end;

function TBellaCorMultiSelectLocalizador.fGetFields(strAbr: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 1 To MAX_QTD_BAS Do
  Begin
    Result := Result + strAbr + 'FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' AS BEL_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
    Result := Result + '(' + strAbr + 'QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ' / ' + strAbr + 'QTDITE) AS BEL_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ';
  End;
  Result := Result + strAbr + 'DTAENT DTAENT, ' + strAbr + 'HORENT HORENT ';
end;

function TBellaCorMultiSelectLocalizador.fGetSQLTin(strTabela: String): String;
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

function TBellaCorMultiSelectLocalizador.fGetUnionTin: String;

  function fGetFields: String;
    Var
      intCnt : Integer;
  begin
    Result := '';
    For intCnt := 1 To MAX_QTD_BAS Do
    Begin
      Result := Result + ' BEL_QTDB' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
      Result := Result + ' BEL_FORM' + TStrUtils.fStrZero(IntToStr(intCnt),2) + ', ' ;
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

{ TBellaCorMultiSelectLocalizadorBase }

constructor TBellaCorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BEL_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   BEL_CADBAS B                      ' +
    '   INNER JOIN BEL_CADBEL S           ' +
    '     ON  B.BAS_CODBAS = S.BEL_CODBAS ' +
    '     AND B.BAS_CODUNI = S.BEL_CODUNI ' +
    '     AND B.BAS_PRODUT = S.BEL_PRODUT ' +
    ' WHERE BEL_MD5KEY = :ITETIN          ');

  Sqls.Add( fGetUnionTin );
end;

function TBellaCorMultiSelectLocalizadorBase.fGetFields(strAbr: String): String;
begin
  Result :=          strAbr  + 'CODITE AS CODITE, ';
  Result := Result + strAbr  + 'DTAENT AS DTAENT, ';
  Result := Result + strAbr  + 'HORENT AS HORENT  ';
end;

function TBellaCorMultiSelectLocalizadorBase.fGetSQLTin(
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

function TBellaCorMultiSelectLocalizadorBase.fGetUnionTin: String;
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
  TMultiSelectLocalizadorFactory.RegistrarClasse('BEL', TBellaCorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('BELBAS', TBellaCorMultiSelectLocalizadorBase);

end.
