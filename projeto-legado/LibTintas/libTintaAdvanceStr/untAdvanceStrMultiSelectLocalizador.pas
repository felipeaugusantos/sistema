unit untAdvanceStrMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAdvanceStrMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TAdvanceStrMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAdvanceStrMultiSelectLocalizador }

constructor TAdvanceStrMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ADS_MD5KEY FROM ADS_CADADS WHERE FALSE', 'ADS_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ADS_CADADS               ' +
      ' WHERE ADS_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TAdvanceStrMultiSelectLocalizadorBase }

constructor TAdvanceStrMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   ADS_CADADS C                   ' +
    '   INNER JOIN ADS_CADBAS B        ' +
    '     ON C.ADS_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.ADS_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.ADS_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.ADS_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADS', TAdvanceStrMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('ADSBAS', TAdvanceStrMultiSelectLocalizadorBase);

end.
