unit untFalcaoMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TFalcaoMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TFalcaoMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TFalcaoMultiSelectLocalizador }

constructor TFalcaoMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT FAL_MD5KEY FROM FAL_CADFAL WHERE FALSE', 'FAL_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   FAL_CADFAL               ' +
      ' WHERE FAL_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TFalcaoMultiSelectLocalizadorBase }

constructor TFalcaoMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.FAL_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   FAL_CADBAS B                      ' +
    '   INNER JOIN FAL_CADFAL S           ' +
    '     ON  B.BAS_DESCRI = S.FAL_BASE__ ' +
    '     AND B.BAS_CODUNI = S.FAL_CODUNI ' +
    '     AND B.BAS_LINHA_ = S.FAL_LINHA_ ' +
    ' WHERE FAL_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('FAL', TFalcaoMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('FALBAS', TFalcaoMultiSelectLocalizadorBase);

end.
