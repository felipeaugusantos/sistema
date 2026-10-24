unit untMontanaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TMontanaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TMontanaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TMontanaMultiSelectLocalizador }

constructor TMontanaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT MON_MD5KEY FROM MON_CADMON WHERE FALSE', 'MON_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MON_CADMON               ' +
      ' WHERE MON_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TMontanaMultiSelectLocalizadorBase }

constructor TMontanaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(' SELECT BAS_CODITE                                '+
           '   FROM MON_CADMON                                '+
           '  INNER JOIN MON_CADBAS ON BAS_CODBAS = MON_CODBAS'+
           '                       AND BAS_UNIDAD = MON_UNIDAD'+
           '                       AND BAS_ACABAM = MON_ACABAM'+
           '                       AND BAS_PRODUT = MON_PRODUT'+
           ' WHERE MON_MD5KEY = :ITETIN                       ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MON', TMontanaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('MONBAS', TMontanaMultiSelectLocalizadorBase);

end.
