unit untLeinertexMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLeinertexMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TLeinertexMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLeinertexMultiSelectLocalizador }

constructor TLeinertexMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LEI_MD5KEY FROM LEI_CADLEI WHERE FALSE', 'LEI_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LEI_CADLEI               ' +
      ' WHERE LEI_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TLeinertexMultiSelectLocalizadorBase }

constructor TLeinertexMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   LEI_CADLEI C                   ' +
    '   INNER JOIN LEI_CADBAS B        ' +
    '     ON C.LEI_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.LEI_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.LEI_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.LEI_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LEI', TLeinertexMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('LEIBAS', TLeinertexMultiSelectLocalizadorBase);

end.
