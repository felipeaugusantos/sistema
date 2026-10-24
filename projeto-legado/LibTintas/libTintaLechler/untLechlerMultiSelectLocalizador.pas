unit untLechlerMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLechlerMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLechlerMultiSelectLocalizador }

constructor TLechlerMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LEC_MD5KEY FROM LEC_CADLEC WHERE FALSE', 'LEC_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LEC_CADLEC            ' +
      ' WHERE LEC_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   LEC_CADLEC                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(LEC_CODNFM, '''')   ' +
    '     , IFNULL(LEC_CODBAS, '''') ' +
    '     , IFNULL(LEC_FABRIC, '''') ' +
    '     , IFNULL(LEC_CODCOR, '''') ' +
    '     , IFNULL(LEC_DESCOR, '''') ' +
    '     , IFNULL(LEC_MASIND, '''') ' +
    '     , IFNULL(LEC_VARIAN, '''') ' +
    '   ) = :ITETIN                  ');

end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LEC', TLechlerMultiSelectLocalizador);

end.
