unit untAlvAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TAlvAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TAlvAutomotivaMultiSelectLocalizador }

constructor TAlvAutomotivaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT ALA_MD5KEY FROM ALA_CADALA WHERE FALSE', 'ALA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   ALA_CADALA            ' +
      ' WHERE ALA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   ALA_CADALA                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(ALA_CODIGO, '''')   ' +
    '     , IFNULL(ALA_DESCRI, '''') ' +
    '     , IFNULL(ALA_NOMCOR, '''') ' +
    '     , IFNULL(ALA_MONTAD, '''') ' +
    '     , IFNULL(ALA_REFCOR, '''') ' +
    '     , IFNULL(ALA_VARIAN, '''') ' +
    '   ) = :ITETIN                  ');

end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('ALA', TAlvAutomotivaMultiSelectLocalizador);

end.
