unit untChreonMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TChreonMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TChreonMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TChreonMultiSelectLocalizador }

constructor TChreonMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT CHR_MD5KEY FROM CHR_CADCHR WHERE FALSE', 'CHR_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   CHR_CADCHR               ' +
      ' WHERE CHR_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TChreonMultiSelectLocalizadorBase }

constructor TChreonMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   CHR_CADCHR C                   ' +
    '   INNER JOIN CHR_CADBAS B        ' +
    '     ON C.CHR_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.CHR_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.CHR_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.CHR_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('CHR', TChreonMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('CHRBAS', TChreonMultiSelectLocalizadorBase);

end.
