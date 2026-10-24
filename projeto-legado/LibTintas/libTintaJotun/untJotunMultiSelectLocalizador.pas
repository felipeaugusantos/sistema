unit untJotunMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TJotunMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TJotunMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TJotunMultiSelectLocalizador }

constructor TJotunMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT JOT_MD5KEY FROM JOT_CADJOT WHERE FALSE', 'JOT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   JOT_CADJOT               ' +
      ' WHERE JOT_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TJotunMultiSelectLocalizadorBase }

constructor TJotunMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.JOT_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   JOT_CADBAS B                      ' +
    '   INNER JOIN JOT_CADJOT S           ' +
    '     ON  B.BAS_CODBAS = S.JOT_BASE__ ' +
    '     AND B.BAS_CODUNI = S.JOT_CODUNI ' +
    '     AND B.BAS_EMBALA = S.JOT_EMBALA ' +
    '     AND B.BAS_TIPO__ = S.JOT_TIPO__ '+
    ' WHERE JOT_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('JOT', TJotunMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('JOTBAS', TJotunMultiSelectLocalizadorBase);

end.
