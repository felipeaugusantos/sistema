unit untLukscolor2MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLukscolor2MultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TLukscolor2MultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLukscolor2MultiSelectLocalizador }

constructor TLukscolor2MultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LKC_MD5KEY FROM LKC_CADLKC WHERE FALSE', 'LKC_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LKC_CADLKC               ' +
      ' WHERE LKC_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;


{ TLukscolor2MultiSelectLocalizadorBase }

constructor TLukscolor2MultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   LKC_CADLKC A                      ' +
    '   INNER JOIN LKC_CADBAS B           ' +
    '     ON A.LKC_CODBAS = B.BAS_CODBAS  ' +
    '     AND A.LKC_PRODUT = B.BAS_PRODUT ' +
    '     AND A.LKC_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE LKC_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LKC', TLukscolor2MultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LKCBAS', TLukscolor2MultiSelectLocalizadorBase);

end.
