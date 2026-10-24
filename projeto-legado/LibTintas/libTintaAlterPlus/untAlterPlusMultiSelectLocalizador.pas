unit untAlterPlusMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAlterPlusMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAlterPlusMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAlterPlusMultiSelectLocalizador }

constructor TAlterPlusMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ALP_MD5KEY FROM ALP_CADALP WHERE FALSE', 'ALP_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ALP_CADALP               ' +
      ' WHERE ALP_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TAlterPlusMultiSelectLocalizadorBase }

constructor TAlterPlusMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.ALP_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ALP_CADBAS B                      ' +
    '   INNER JOIN ALP_CADALP S           ' +
    '     ON  B.BAS_CODBAS = S.ALP_CODBAS' +
    '     AND B.BAS_CODUNI = S.ALP_CODUNI ' +
    '     AND B.BAS_DESCRI = S.ALP_PRODUT ' +
    ' WHERE ALP_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALP', TAlterPlusMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALPBAS', TAlterPlusMultiSelectLocalizadorBase);

end.
