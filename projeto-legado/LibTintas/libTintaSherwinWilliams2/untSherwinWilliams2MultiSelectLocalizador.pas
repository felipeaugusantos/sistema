unit untSherwinWilliams2MultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TSherwinWilliams2MultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TSherwinWilliams2MultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TSherwinWilliams2MultiSelectLocalizador }

constructor TSherwinWilliams2MultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT SHW_MD5KEY FROM SHW_CADSHW WHERE FALSE', 'SHW_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   SHW_CADSHW               ' +
      ' WHERE SHW_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TSherwinWilliams2MultiSelectLocalizadorBase }

constructor TSherwinWilliams2MultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.SHW_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   SHW_CADBAS B                      ' +
    '   INNER JOIN SHW_CADSHW S           ' +
    '     ON  B.BAS_CODBAS = S.SHW_BASE__ ' +
    '     AND B.BAS_CODUNI = S.SHW_CODUNI ' +
    '     AND B.BAS_PRODUT = S.SHW_PRODUT ' +
    ' WHERE SHW_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('SHW', TSherwinWilliams2MultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('SHWBAS', TSherwinWilliams2MultiSelectLocalizadorBase);

end.
