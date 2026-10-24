unit untAnjoImobiliaria2MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAnjoImobiliaria2MultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAnjoImobiliaria2MultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAnjoImobiliaria2MultiSelectLocalizador }

constructor TAnjoImobiliaria2MultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT AN2_MD5KEY FROM AN2_CADAN2 WHERE FALSE', 'AN2_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   AN2_CADAN2               ' +
      ' WHERE AN2_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TAnjoImobiliaria2MultiSelectLocalizadorBase }

constructor TAnjoImobiliaria2MultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   AN2_CADAN2 C                   ' +
    '   INNER JOIN AN2_CADBAS B        ' +
    '     ON C.AN2_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.AN2_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.AN2_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.AN2_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('AN2', TAnjoImobiliaria2MultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('AN2BAS', TAnjoImobiliaria2MultiSelectLocalizadorBase);

end.
