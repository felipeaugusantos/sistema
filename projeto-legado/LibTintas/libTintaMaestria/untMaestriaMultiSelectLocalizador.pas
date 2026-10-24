unit untMaestriaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TMaestriaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TMaestriaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TMaestriaMultiSelectLocalizador }

constructor TMaestriaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT MAE_MD5KEY FROM MAE_CADMAE WHERE FALSE', 'MAE_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MAE_CADMAE               ' +
      ' WHERE MAE_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TMaestriaMultiSelectLocalizadorBase }

constructor TMaestriaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   MAE_CADMAE C                   ' +
    '   INNER JOIN MAE_CADBAS B        ' +
    '     ON C.MAE_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.MAE_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.MAE_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.MAE_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MAE', TMaestriaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('MAEBAS', TMaestriaMultiSelectLocalizadorBase);

end.
