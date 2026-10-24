unit untProfissionalAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TProfissionalAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TProfissionalAutomotivaMultiSelectLocalizador }

constructor TProfissionalAutomotivaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT PFA_MD5KEY FROM PFA_CADPFA WHERE FALSE', 'PFA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   PFA_CADPFA            ' +
      ' WHERE PFA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   PFA_CADPFA                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(PFA_CODNFM, '''')   ' +
    '     , IFNULL(PFA_CODBAS, '''') ' +
    '     , IFNULL(PFA_FABRIC, '''') ' +
    '     , IFNULL(PFA_CODCOR, '''') ' +
    '     , IFNULL(PFA_DESCOR, '''') ' +
    '     , IFNULL(PFA_MASIND, '''') ' +
    '     , IFNULL(PFA_VARIAN, '''') ' +
    '   ) = :ITETIN                  ');

end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('PFA', TProfissionalAutomotivaMultiSelectLocalizador);

end.
