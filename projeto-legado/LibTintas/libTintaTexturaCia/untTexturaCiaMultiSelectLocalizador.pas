unit untTexturaCiaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TTexturaCiaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TTexturaCiaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TTexturaCiaMultiSelectLocalizador }

constructor TTexturaCiaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT TEX_MD5KEY FROM TEX_CADTEX WHERE FALSE', 'TEX_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   TEX_CADTEX               ' +
      ' WHERE TEX_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TTexturaCiaMultiSelectLocalizadorBase }

constructor TTexturaCiaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   TEX_CADTEX C                   ' +
    '   INNER JOIN TEX_CADBAS B        ' +
    '     ON C.TEX_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.TEX_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.TEX_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.TEX_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('TEX', TTexturaCiaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('TEXBAS', TTexturaCiaMultiSelectLocalizadorBase);

end.
