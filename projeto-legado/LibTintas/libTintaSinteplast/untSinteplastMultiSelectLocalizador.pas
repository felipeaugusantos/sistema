unit untSinteplastMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSinteplastMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSinteplastMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSinteplastMultiSelectLocalizador }

constructor TSinteplastMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SIN_MD5KEY FROM SIN_CADSIN WHERE FALSE', 'SIN_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SIN_CADSIN               ' +
      ' WHERE SIN_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TSinteplastMultiSelectLocalizadorBase }

constructor TSinteplastMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SIN_CADSIN C                   ' +
    '   INNER JOIN SIN_CADBAS B        ' +
    '     ON C.SIN_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.SIN_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.SIN_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.SIN_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SIN', TSinteplastMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SINBAS', TSinteplastMultiSelectLocalizadorBase);

end.
