unit untMazaImobiliariaMultiSelectLocalizador;

interface

uses
  untMultiSelectLocalizador, SysUtils;

const
  MAX_QTD_BAS = 20;

type
  TMazaImobiliariaMultiSelectLocalizador = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

  TMazaImobiliariaMultiSelectLocalizadorBase = class(TMultiSelectLocalizador)
  private

  public
    constructor Create(); override;
  end;

implementation

uses
  untMultiSelectLocalizadorFactory, untStrUtils, untIDataSet,
  untAutcomTintaFactory;

{ TMazaImobiliariaMultiSelectLocalizador }

constructor TMazaImobiliariaMultiSelectLocalizador.Create;
//  Var
//    dtsCampoExiste: IDataSet;
begin
  inherited Create;

  Try
    TAutcomTintaFactory.Get.GetValorCampo('SELECT MZI_MD5KEY '+
                                          '  FROM MZI_CADMZI '+
                                          ' WHERE FALSE', 'MZI_MD5KEY', []);
    Sqls.Add(
      ' SELECT *                   ' +
      '   FROM MZI_CADMZI          ' +
      ' WHERE MZI_MD5KEY = :ITETIN ');
  Except

  End;

  Sqls.Add(
    ' SELECT *                              '+
    '   FROM MZI_CADMZI                     '+
    '  WHERE                                '+
    '    CONCAT(IFNULL(MZI_CODMZI, ""),     '+
    '    IFNULL(MZI_CODEMP, ""),            '+
    '    IFNULL(MZI_CODUNI, ""),            '+
    '    IFNULL(MZI_PRODUT, ""),            '+
    '    IFNULL(MZI_COLNUM, ""),            '+
    '    IFNULL(MZI_CODBAS, "")) = :ITETIN  ');
end;

{ TMazaImobiliariaMultiSelectLocalizadorBase }

constructor TMazaImobiliariaMultiSelectLocalizadorBase.Create;
begin
  inherited Create;
  Sqls.Add(' SELECT B.BAS_CODITE                                     ' +
           '   FROM MZI_CADMZI F                                     ' +
           '  INNER JOIN MZI_CADBAS B ON F.MZI_CODBAS = B.BAS_CODBAS ' +
           '                         AND F.MZI_CODUNI = B.BAS_CODUNI ' +
           '  WHERE F.MZI_MD5KEY  = :ITETIN                          ');

  Sqls.Add(' SELECT B.BAS_CODITE                                     ' +
           '   FROM MZI_CADMZI F                                     ' +
           '  INNER JOIN MZI_CADBAS B ON F.MZI_CODBAS = B.BAS_CODBAS ' +
           '                         AND F.MZI_CODUNI = B.BAS_CODUNI ' +
           '  WHERE CONCAT(IFNULL(MZI_CODMZI, ""),                   ' +
           '    IFNULL(MZI_CODEMP, ""),                              ' +
           '    IFNULL(MZI_CODUNI, ""),                              ' +
           '    IFNULL(MZI_PRODUT, ""),                              ' +
           '    IFNULL(MZI_COLNUM, ""),                              ' +
           '    IFNULL(MZI_CODBAS, "")) = :ITETIN                    ');
end;

initialization
  TMultiSelectLocalizadorFactory.RegistrarClasse('MZI', TMazaImobiliariaMultiSelectLocalizador);
  TMultiSelectLocalizadorFactory.RegistrarClasse('MZIBAS', TMazaImobiliariaMultiSelectLocalizadorBase);

end.
