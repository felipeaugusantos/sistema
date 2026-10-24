unit untDacarMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TDacarMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TDacarMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TDacarMultiSelectLocalizador }

constructor TDacarMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT DAC_MD5KEY FROM DAC_CADDAC WHERE FALSE', 'DAC_MD5KEY', []);

    Sqls.Add(
      ' SELECT                         ' +
      '   *                            ' +
      ' FROM                           ' +
      '   DAC_CADDAC                   ' +
      ' WHERE DAC_MD5KEY = :ITETIN     ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   DAC_CADDAC                   ' +
    ' WHERE CONCAT(IFNULL(DAC_DESCRI,""),  ' +
    ' 	IFNULL(DAC_REFERE,""),       ' +
    ' 	IFNULL(DAC_CODUNI,""),       ' +
    ' 	IFNULL(DAC_EMBALA,""),       ' +
    ' 	IFNULL(DAC_PROCOD,""),       ' +
    ' 	IFNULL(DAC_CODBAS,""),       ' +
    ' 	IFNULL(DAC_CODFML,""),       ' +
    ' 	IFNULL(DAC_COLECA,""),       ' +
    ' 	IFNULL(DAC_CODCOR,"")) = :ITETIN; ');

  Sqls.Add(
    ' SELECT       ' +
    '   *          ' +
    ' FROM         ' +
    '   DAC_CADDAC ' +
    ' WHERE        ' +
    '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ');
end;

{ TDacarMultiSelectLocalizadorBase }

constructor TDacarMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
        ' SELECT                                ' +
        '   B.BAS_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   DAC_CADDAC A                        ' +
        '   INNER JOIN DAC_CADBAS B             ' +
        '     ON A.DAC_CODFML = B.BAS_CODFML    ' +
        '     AND A.DAC_CODBAS = B.BAS_BASE__   ' +
        '   INNER JOIN DAC_UNIDAC U             ' +
        '     ON B.BAS_UNIDAD = U.DAC_UNIAUT    ' +
        '     AND U.DAC_UNIAUT = A.DAC_CODUNI   ' +
        ' WHERE DAC_MD5KEY = :ITETIN     ');

  Sqls.Add(
        ' SELECT                                ' +
        '   B.BAS_CODITE AS CODITE              ' +
        ' FROM                                  ' +
        '   DAC_CADDAC A                        ' +
        '   INNER JOIN DAC_CADBAS B             ' +
        '     ON A.DAC_CODFML = B.BAS_CODFML    ' +
        '     AND A.DAC_CODBAS = B.BAS_BASE__   ' +
        '   INNER JOIN DAC_UNIDAC U             ' +
        '     ON B.BAS_UNIDAD = U.DAC_UNIAUT    ' +
        '     AND U.DAC_UNIAUT = A.DAC_CODUNI   ' +
        ' WHERE CONCAT(                         ' +
        '     IFNULL(A.DAC_DESCRI, '''')        ' +
        '     , IFNULL(A.DAC_REFERE, '''')      ' +
        '     , IFNULL(A.DAC_CODUNI, '''')      ' +
        '     , IFNULL(A.DAC_EMBALA, '''')      ' +
        '     , IFNULL(A.DAC_PROCOD, '''')      ' +
        '     , IFNULL(A.DAC_CODBAS, '''')      ' +
        '     , IFNULL(A.DAC_CODFML, '''')      ' +
        '     , IFNULL(A.DAC_COLECA, '''')      ' +
        '     , IFNULL(A.DAC_CODCOR, '''')      ' +
        '   ) = :ITETIN                         ');


  Sqls.Add(
        ' SELECT                                ' +
        '   B.BAS_CODITE  AS CODITE             ' +
        ' FROM                                  ' +
        '   DAC_CADDAC A                        ' +
        '   INNER JOIN DAC_CADBAS B             ' +
        '     ON A.DAC_CODFML = B.BAS_CODFML    ' +
        '     AND A.DAC_CODBAS = B.BAS_BASE__   ' +
        '   INNER JOIN DAC_UNIDAC U             ' +
        '     ON B.BAS_UNIDAD = U.DAC_UNIAUT    ' +
        '     AND U.DAC_UNIAUT = A.DAC_CODUNI   ' +
        ' WHERE                                 ' +
        '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DAC', TDacarMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('DACBAS', TDacarMultiSelectLocalizadorBase);

end.
