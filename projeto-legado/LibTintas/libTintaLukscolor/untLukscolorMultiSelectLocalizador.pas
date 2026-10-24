unit untLukscolorMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLukscolorMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TLukscolorMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLukscolorMultiSelectLocalizador }

constructor TLukscolorMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LKD_MD5KEY FROM LKD_CADLKD WHERE FALSE', 'LKD_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LKD_CADLKD               ' +
      ' WHERE LKD_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT ' +
    '   * ' +
    ' FROM ' +
    '   LKD_CADLKD ' +
    ' WHERE ' +
    '   CONCAT(LKD_DESCRI, " ", LKD_CODIGO, " ", LKD_CODIG2, " ", LKD_UNIDAD) = :ITETIN ');


end;

{ TLukscolorMultiSelectLocalizadorBase }

constructor TLukscolorMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                               ' +
    '   B.BAS_CODITE AS CODITE             ' +
    ' FROM                                 ' +
    '   LKD_CADLKD C                       ' +
    '  INNER JOIN LKD_CADBAS B            ' +
    '     ON C.LKD_BASE__ = B.BAS_BASE__   ' +
    '    AND C.LKD_UNIDAD = B.BAS_UNIDAD  ' +
    '    AND C.LKD_PROKEY = B.BAS_PROKEY  ' +
    '    AND C.LKD_SUBKEY = B.BAS_SUBKEY ' +
    '  WHERE C.LKD_MD5KEY = :ITETIN         ');

  Sqls.Add(
        ' SELECT                                ' +
        '   B.BAS_CODITE  AS CODITE             ' +
        ' FROM                                  ' +
        '   LKD_CADLKD L                        ' +
        '   INNER JOIN LKD_CADBAS B             ' +
        '     ON L.LKD_BASE__ = B.BAS_BASE__    ' +
        '    AND L.LKD_PROKEY = B.BAS_PROKEY   ' +
        '    AND L.LKD_SUBKEY = B.BAS_SUBKEY   ' +
        '    AND L.LKD_UNIDAD = B.BAS_UNIDAD   ' +
        '  WHERE CONCAT(                         ' +
        '     L.LKD_DESCRI                      ' +
        '     , '' ''                           ' +
        '     , L.LKD_CODIGO                    ' +
        '     , '' ''                           ' +
        '     , L.LKD_CODIG2                    ' +
        '     , '' ''                           ' +
        '     , L.LKD_UNIDAD                    ' +
        '   ) = :ITETIN                         ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LKS', TLukscolorMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LKDBAS', TLukscolorMultiSelectLocalizadorBase);

end.
