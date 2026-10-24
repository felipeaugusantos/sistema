unit untLechlerAutomotivaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TLechlerAutomotivaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;


implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TLechlerAutomotivaMultiSelectLocalizador }

constructor TLechlerAutomotivaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT LCA_MD5KEY FROM LCA_CADLCA WHERE FALSE', 'LCA_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   LCA_CADLCA            ' +
      ' WHERE LCA_MD5KEY = :ITETIN ');
  Except
    //
  End;

  Sqls.Add(
    ' SELECT                         ' +
    '   *                            ' +
    ' FROM                           ' +
    '   LCA_CADLCA                ' +
    ' WHERE CONCAT(                  ' +
    '     IFNULL(LCA_CODIGO, '''')   ' +
    '     , IFNULL(LCA_DESCRI, '''') ' +
    '     , IFNULL(LCA_NOMCOR, '''') ' +
    '     , IFNULL(LCA_MONTAD, '''') ' +
    '     , IFNULL(LCA_REFCOR, '''') ' +
    '     , IFNULL(LCA_VARIAN, '''') ' +
    '   ) = :ITETIN                  ');

end;


initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('LCA', TLechlerAutomotivaMultiSelectLocalizador);

end.
