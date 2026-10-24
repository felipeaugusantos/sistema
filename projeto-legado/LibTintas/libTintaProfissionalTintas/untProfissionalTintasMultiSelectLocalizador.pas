unit untProfissionalTintasMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TProfissionalTintasMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TProfissionalTintasMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TProfissionalTintasMultiSelectLocalizador }

constructor TProfissionalTintasMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT PRT_MD5KEY FROM PRT_CADPRT WHERE FALSE', 'PRT_MD5KEY', []);

    Sqls.Add(
      ' SELECT                     ' +
      '   *                        ' +
      ' FROM                       ' +
      '   PRT_CADPRT               ' +
      ' WHERE PRT_MD5KEY = :ITETIN ');
  Except
    //
  End;
end;

{ TProfissionalTintasMultiSelectLocalizadorBase }

constructor TProfissionalTintasMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(
    ' SELECT                              ' +
    '   B.BAS_CODITE AS CODITE            ' +
    ' FROM                                ' +
    '   PRT_CADPRT C                   ' +
    '   INNER JOIN PRT_CADBAS B        ' +
    '     ON C.PRT_CODBAS = B.BAS_CODBAS  ' +
    '     AND C.PRT_UNIDAD = B.BAS_UNIDAD ' +
    '     AND C.PRT_PRODUT = B.BAS_PRODUT ' +
    ' WHERE C.PRT_MD5KEY = :ITETIN        ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('PRT', TProfissionalTintasMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('PRTBAS', TProfissionalTintasMultiSelectLocalizadorBase);

end.
