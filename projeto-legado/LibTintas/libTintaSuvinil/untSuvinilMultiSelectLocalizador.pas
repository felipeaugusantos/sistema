unit untSuvinilMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSuvinilMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSuvinilMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSuvinilMultiSelectLocalizador }

constructor TSuvinilMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SUV_MD5KEY FROM SUV_CADSUV WHERE FALSE', 'SUV_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SUV_CADSUV               ' +
      ' WHERE SUV_MD5KEY = :ITETIN ');
  Except
    Raise;
  End;
end;

{ TSuvinilMultiSelectLocalizadorBase }

constructor TSuvinilMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.SUV_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SUV_CADBAS B                      ' +
    '   INNER JOIN SUV_CADSUV S           ' +
    '     ON B.SUV_CODFML = S.SUV_CODFML  ' +
    '     AND B.SUV_CODBAS = S.SUV_CODBAS ' +
    '     AND B.SUV_CODUNI = S.SUV_CODUNI ' +
    ' WHERE SUV_MD5KEY = :ITETIN          ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SUV', TSuvinilMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SUVBAS', TSuvinilMultiSelectLocalizadorBase);

end.
