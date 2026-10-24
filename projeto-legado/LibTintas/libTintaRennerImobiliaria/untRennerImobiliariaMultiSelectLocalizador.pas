unit untRennerImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TRennerImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TRennerImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TRennerImobiliariaMultiSelectLocalizador }

constructor TRennerImobiliariaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT REI_MD5KEY FROM REI_CADREI WHERE FALSE', 'REI_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   REI_CADREI               ' +
      ' WHERE REI_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TRennerImobiliariaMultiSelectLocalizadorBase }

constructor TRennerImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE                      ' +
    ' FROM                                ' +
    '   REI_CADREI C                      ' +
    '   INNER JOIN REI_CADBAS B           ' +
    '     ON C.REI_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.REI_UNIDAD = B.BAS_UNIDAD ' +
    ' WHERE C.REI_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('REI', TRennerImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('REIBAS', TRennerImobiliariaMultiSelectLocalizadorBase);

end.
