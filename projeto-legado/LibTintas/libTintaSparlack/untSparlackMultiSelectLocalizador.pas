unit untSparlackMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSparlackMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSparlackMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSparlackMultiSelectLocalizador }

constructor TSparlackMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SPA_MD5KEY '+
                                          '  FROM SPA_CADSPA '+
                                          ' WHERE FALSE', 'SPA_MD5KEY', []);
    Sqls.Add(
      ' SELECT *                   ' +
      '   FROM SPA_CADSPA          ' +
      ' WHERE SPA_MD5KEY = :ITETIN ');
  Except

  End;
end;

{ TSparlackMultiSelectLocalizadorBase }

constructor TSparlackMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(' SELECT B.BAS_CODITE                                     ' +
           '   FROM SPA_CADSPA F                                     ' +
           '  INNER JOIN SPA_CADBAS B ON F.SPA_CODBAS = B.BAS_CODBAS ' +
           '                         AND F.SPA_CODUNI = B.BAS_CODUNI ' +
           '                         AND F.SPA_PRODUT = B.BAS_PRODUT ' +
           '  WHERE F.SPA_MD5KEY  = :ITETIN                          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SPA', TSparlackMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SPABAS', TSparlackMultiSelectLocalizadorBase);

end.
