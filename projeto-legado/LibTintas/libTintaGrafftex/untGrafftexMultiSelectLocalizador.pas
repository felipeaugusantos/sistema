unit untGrafftexMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TGrafftexMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TGrafftexMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TGrafftexMultiSelectLocalizador }

constructor TGrafftexMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT GRA_MD5KEY FROM GRA_CADGRA WHERE FALSE', 'GRA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   GRA_CADGRA               ' +
      ' WHERE GRA_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TGrafftexMultiSelectLocalizadorBase }

constructor TGrafftexMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.GRA_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   GRA_CADBAS B                      ' +
    '   INNER JOIN GRA_CADGRA S           ' +
    '     ON  B.BAS_CODBAS = S.GRA_BASE__' +
    '     AND B.BAS_CODUNI = S.GRA_CODUNI ' +
    '     AND B.BAS_PRODUT = S.GRA_PRODUT ' +
    ' WHERE GRA_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('GRA', TGrafftexMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('GRABAS', TGrafftexMultiSelectLocalizadorBase);

end.
