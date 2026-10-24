unit untLuztolMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLuztolMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TLuztolMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLuztolMultiSelectLocalizador }

constructor TLuztolMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LUZ_MD5KEY FROM LUZ_CADLUZ WHERE FALSE', 'LUZ_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LUZ_CADLUZ               ' +
      ' WHERE LUZ_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TLuztolMultiSelectLocalizadorBase }

constructor TLuztolMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   LUZ_CADLUZ C                   ' +
    '   INNER JOIN LUZ_CADBAS B        ' +
    '     ON C.LUZ_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.LUZ_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.LUZ_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.LUZ_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LUZ', TLuztolMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LUZBAS', TLuztolMultiSelectLocalizadorBase);

end.
