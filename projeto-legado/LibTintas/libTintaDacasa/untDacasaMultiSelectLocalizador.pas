unit untDacasaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TDacasaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TDacasaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TDacasaMultiSelectLocalizador }

constructor TDacasaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT DCA_MD5KEY FROM DCA_CADDCA WHERE FALSE', 'DCA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   DCA_CADDCA               ' +
      ' WHERE DCA_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TDacasaMultiSelectLocalizadorBase }

constructor TDacasaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   DCA_CADDCA C                   ' +
    '   INNER JOIN DCA_CADBAS B        ' +
    '     ON C.DCA_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.DCA_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.DCA_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.DCA_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('DCA', TDacasaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('DCABAS', TDacasaMultiSelectLocalizadorBase);

end.
