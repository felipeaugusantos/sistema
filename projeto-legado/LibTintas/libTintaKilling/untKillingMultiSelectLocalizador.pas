unit untKillingMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TKillingMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TKillingMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TKillingMultiSelectLocalizador }

constructor TKillingMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT KIL_MD5KEY '+
                                          '  FROM KILD_CADKIL '+
                                          ' WHERE FALSE', 'KIL_MD5KEY', []);
    Sqls.Add(
      ' SELECT *                   ' +
      '   FROM KILD_CADKIL          ' +
      ' WHERE KIL_MD5KEY = :ITETIN ');
  Except

  End;
end;

{ TKillingMultiSelectLocalizadorBase }

constructor TKillingMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(' SELECT B.BAS_CODITE                                      ' +
           '   FROM KILD_CADKIL F                                     ' +
           '  INNER JOIN KILD_CADBAS B ON F.KIL_CODBAS = B.BAS_CODBAS ' +
           '                         AND F.KIL_CODUNI = B.BAS_CODUNI  ' +
           '                         AND F.KIL_CODFML = B.BAS_CODFML  ' +
           '  WHERE F.KIL_MD5KEY  = :ITETIN                           ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('KIL', TKillingMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('KILDBAS', TKillingMultiSelectLocalizadorBase);

end.
