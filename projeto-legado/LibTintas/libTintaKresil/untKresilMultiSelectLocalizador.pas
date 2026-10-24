unit untKresilMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TKresilMultiSelectLocalizador = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

  TKresilMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TKresilMultiSelectLocalizador }

constructor TKresilMultiSelectLocalizador.Create;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT KRE_MD5KEY FROM KRE_CADKRE WHERE FALSE', 'KRE_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   KRE_CADKRE               ' +
      ' WHERE KRE_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;


{ TKresilMultiSelectLocalizadorBase }

constructor TKresilMultiSelectLocalizadorBase.Create;
begin
  inherited Create;

  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   KRE_CADKRE A                      ' +
    '   INNER JOIN KRE_CADBAS B           ' +
    '     ON A.KRE_BASE__ = B.BAS_BASE__  ' +
    '     AND A.KRE_PRODUT = B.BAS_PRODUT ' +
    '     AND A.KRE_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE KRE_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('KRE', TKresilMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('KREBAS', TKresilMultiSelectLocalizadorBase);

end.
