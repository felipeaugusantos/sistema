unit untMegaTintasMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TMegaTintasMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TMegaTintasMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TMegaTintasMultiSelectLocalizador }

constructor TMegaTintasMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT MEG_MD5KEY FROM MEG_CADMEG WHERE FALSE', 'MEG_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   MEG_CADMEG               ' +
      ' WHERE MEG_MD5KEY = :ITETIN ');
  Except
    //
  End;

end;

{ TMegaTintasMultiSelectLocalizadorBase }

constructor TMegaTintasMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.MEG_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   MEG_CADBAS B                      ' +
    '   INNER JOIN MEG_CADMEG S           ' +
    '     ON  B.BAS_CODBAS = S.MEG_BASE__' +
    '     AND B.BAS_CODUNI = S.MEG_CODUNI ' +
    '     AND B.BAS_DESCRI = S.MEG_PRODUT ' +
    ' WHERE MEG_MD5KEY = :ITETIN          ');

end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MEG', TMegaTintasMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('MEGBAS', TMegaTintasMultiSelectLocalizadorBase);

end.
