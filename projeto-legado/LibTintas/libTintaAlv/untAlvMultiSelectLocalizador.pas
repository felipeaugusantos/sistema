unit untAlvMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAlvMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAlvMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAlvMultiSelectLocalizador }

constructor TAlvMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ALV_MD5KEY FROM ALV_CADALV WHERE FALSE', 'ALV_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ALV_CADALV               ' +
      ' WHERE ALV_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TAlvMultiSelectLocalizadorBase }

constructor TAlvMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ALV_CADALV C                   ' +
    '   INNER JOIN ALV_CADBAS B        ' +
    '     ON C.ALV_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.ALV_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.ALV_PRODUT = B.BAS_PRODUT ' +
    '     AND C.ALV_VOLUME = B.BAS_EMBALA ' +
    ' WHERE C.ALV_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALV', TAlvMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALVBAS', TAlvMultiSelectLocalizadorBase);

end.
