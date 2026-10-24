unit untColorbrazMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TColorbrazMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TColorbrazMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TColorbrazMultiSelectLocalizador }

constructor TColorbrazMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT CLB_MD5KEY FROM CLB_CADCLB WHERE FALSE', 'CLB_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CLB_CADCLB               ' +
      ' WHERE CLB_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;


{ TColorbrazMultiSelectLocalizadorBase }

constructor TColorbrazMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CLB_CADCLB A                      ' +
    '   INNER JOIN CLB_CADBAS B           ' +
    '     ON A.CLB_CODBAS = B.BAS_CODBAS  ' +
    '     AND A.CLB_PRODUT = B.BAS_PRODUT ' +
    '     AND A.CLB_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE CLB_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CLB', TColorbrazMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CLBBAS', TColorbrazMultiSelectLocalizadorBase);

end.
