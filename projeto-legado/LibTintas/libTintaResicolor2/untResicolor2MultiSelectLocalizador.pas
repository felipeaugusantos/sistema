unit untResicolor2MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TResicolor2MultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TResicolor2MultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TResicolor2MultiSelectLocalizador }

constructor TResicolor2MultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT RS2_MD5KEY FROM RS2_CADRS2 WHERE FALSE', 'RS2_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   RS2_CADRS2               ' +
      ' WHERE RS2_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TResicolor2MultiSelectLocalizadorBase }

constructor TResicolor2MultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   RS2_CADRS2 C                   ' +
    '   INNER JOIN RS2_CADBAS B        ' +
    '     ON C.RS2_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.RS2_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.RS2_PRODUT = B.BAS_PRODUT ' +
    '     AND C.RS2_EMBALA = B.BAS_EMBALA ' +
    ' WHERE C.RS2_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('RS2', TResicolor2MultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('RS2BAS', TResicolor2MultiSelectLocalizadorBase);

end.
