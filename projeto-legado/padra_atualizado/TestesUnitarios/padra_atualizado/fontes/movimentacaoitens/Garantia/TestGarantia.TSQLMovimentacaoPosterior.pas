unit TestGarantia.TSQLMovimentacaoPosterior;

interface

uses
  TestFramework, Garantia.TSQLMovimentacaoPosterior, SysUtils, Classes;

type

  TestTSQLMovimentacaoPosterior = class(TTestCase)
  strict private
    FSQLMovimentacaoPosterior: TSQLMovimentacaoPosterior;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaSQL_RecebimentoCliente;
    procedure TestfRetornaSQLFiltroRecebimentoCliente_GA;
    procedure TestfRetornaSQLFiltroRecebimentoCliente_NW;
    procedure TestfRetornaSQLFiltroEmpresaEnvioFornecedor_FiltraEmpresa;
    procedure TestfRetornaSQL_EnvioFornecedor;
    procedure TestfRetornaSQL_RetornoFornecedor;
    procedure TestfRetornaSQLFiltroEmpresaEnvioFornecedor_MesmaEmpresa;
    procedure TestfRetornaSQLFiltroEmpresaEnvioFornecedor_NaoUtilizaGarantiaPelaMatriz;
  end;

implementation

procedure TestTSQLMovimentacaoPosterior.SetUp;
begin
  FSQLMovimentacaoPosterior := TSQLMovimentacaoPosterior.Create;
end;

procedure TestTSQLMovimentacaoPosterior.TearDown;
begin
  FSQLMovimentacaoPosterior.Free;
  FSQLMovimentacaoPosterior := nil;
end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQL_RecebimentoCliente;
var
  ReturnValue: string;

  sql : TStringList;
begin
  sql := TStringList.Create;
  try
    sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
    sql.Add('SELECT DISTINCT'                                       );
    sql.Add('  GAE_EMPENV AS CODEMP,'                               );
    sql.Add('  GAE_ESPENV AS ESPDOC,'                               );
    sql.Add('  GAE_NUMENV AS NUMDOC'                                );
    sql.Add('FROM MOVDET'                                           );
    sql.Add('  INNER JOIN MOVGRC ON GRC_SEQDET = MOVDET.AUTOINCREM' );
    sql.Add('  INNER JOIN MOVGAD D ON D.AUTOINCREM = GRC_SEQGAD'    );
    sql.Add('  INNER JOIN MOVGAE A ON A.GAE_SEQGAD = D.AUTOINCREM'  );
    sql.Add('WHERE DET_NUMDOC = :NUMDOC'                            );
    sql.Add('  AND DET_CODEMP = :CODEMP'                            );
    sql.Add('  AND DET_CODCLI = :CLIFOR'                            );
    sql.Add('  AND DET_ESPDOC = "GA"'                               );

    FSQLMovimentacaoPosterior.strSigla := 'GA';
    ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQL;

    CheckEqualsString(sql.Text, ReturnValue);
  finally
    FreeAndNil(sql);
  end;
end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQL_EnvioFornecedor;
var
  ReturnValue: string;

  sql : TStringList;
begin
  sql := TStringList.Create;
  try

    sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
    sql.Add('SELECT DISTINCT'                                       );
    sql.Add('  E.DET_CODEMP AS CODEMP,'                             );
    sql.Add('  E.DET_ESPDOC AS ESPDOC,'                             );
    sql.Add('  E.DET_NUMDOC AS NUMDOC'                              );
    sql.Add('FROM'                                                  );
    sql.Add('  MOVGAD D'                                            );
    sql.Add('  INNER JOIN MOVGAE A ON A.GAE_SEQGAD = D.AUTOINCREM'  );
    sql.Add('  INNER JOIN MOVGAG G ON G.AUTOINCREM = D.GAD_SEQGAG'  );
    sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQGAD'  );
    sql.Add('  INNER JOIN MOVDET E ON E.AUTOINCREM = U.GAU_SEQDET'  );
    sql.Add('WHERE GAE_NUMENV = :NUMDOC'                            );
    sql.Add('  AND GAE_ESPENV IN ("NF","GF")'                       );
    sql.Add('  AND D.GAD_CODFOR = :CLIFOR'                          );
    sql.Add('  AND IFNULL(E.DET_NUMDOC,"") <> ""'                   );
    sql.Add('    AND GAE_EMPENV = :CODEMP'                          );

    FSQLMovimentacaoPosterior.strSigla := 'GF';
    ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQL;

    CheckEqualsString(sql.Text, ReturnValue);
  finally
    FreeAndNil(sql);
  end;
end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQL_RetornoFornecedor;
var
  ReturnValue: string;

  sql : TStringList;
begin
  sql := TStringList.Create;
  try

    sql.Add('/* TSQLMovimentacaoPosterior.fRetornaSQL */'           );
    sql.Add('SELECT DISTINCT'                                       );
    sql.Add('  A.GER_CODEMP AS CODEMP,'                             );
    sql.Add('  A.GER_ESPDOC AS ESPDOC,'                             );
    sql.Add('  A.GER_NUMDOC AS NUMDOC'                              );
    sql.Add('FROM'                                                  );
    sql.Add('  MOVGER G'                                            );
    sql.Add('  INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER'  );
    sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQDET'  );
    sql.Add('  INNER JOIN MOVGER A ON A.AUTOINCREM = U.GAU_AIBXRF'  );
    sql.Add('WHERE D.DET_ESPDOC = "GR"'                             );
    sql.Add('  AND D.DET_NUMDOC = :NUMDOC'                          );
    sql.Add('  AND D.DET_CODEMP = :CODEMP'                          );
    sql.Add('  AND D.DET_CODFOR = :CLIFOR'                          );

    sql.Add('UNION ALL'                                             );

    sql.Add('SELECT DISTINCT'                                       );
    sql.Add('  A.GER_CODEMP AS CODEMP,'                             );
    sql.Add('  A.GER_ESPDOC AS ESPDOC,'                             );
    sql.Add('  A.GER_NUMDOC AS NUMDOC'                              );
    sql.Add('FROM'                                                  );
    sql.Add('  MOVGER G'                                            );
    sql.Add('  INNER JOIN MOVDET D ON G.AUTOINCREM = D.DET_SEQGER'  );
    sql.Add('  INNER JOIN MOVGAU U ON D.AUTOINCREM = U.GAU_SEQDET'  );
    sql.Add('  INNER JOIN MOVGER A ON A.AUTOINCREM = U.GAU_AIBXRF'  );
    sql.Add('WHERE D.DET_ESPDOC = "NF"'                             );
    sql.Add('  AND D.DET_NUMDOC = :NUMDOC'                          );
    sql.Add('  AND D.DET_CODEMP = :CODEMP'                          );
    sql.Add('  AND D.DET_CODFOR = :CLIFOR'                          );

    FSQLMovimentacaoPosterior.strSigla := 'GR';
    ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQL;

    CheckEqualsString(sql.Text, ReturnValue);
  finally
    FreeAndNil(sql);
  end;
end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQLFiltroRecebimentoCliente_GA;
var
  ReturnValue: string;
begin
  FSQLMovimentacaoPosterior.strSigla := 'GA';
  ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQLFiltroRecebimentoCliente;

  CheckEqualsString('AND DET_ESPDOC = "GA"', ReturnValue);
end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQLFiltroRecebimentoCliente_NW;
var
  ReturnValue: string;
begin
  FSQLMovimentacaoPosterior.strSigla := 'NW';
  ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQLFiltroRecebimentoCliente;

  CheckEqualsString('AND DET_ESPDOC = "NF"', ReturnValue);
end;


procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQLFiltroEmpresaEnvioFornecedor_FiltraEmpresa;
var
  ReturnValue: string;
begin

  FSQLMovimentacaoPosterior.strCodigoEmpresaLogada   := '001';
  FSQLMovimentacaoPosterior.strCodigoEmpresaGarantia := '002';
  FSQLMovimentacaoPosterior.blnUtilizaGarantiaPelaMatriz := true;

  ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQLFiltroEmpresaEnvioFornecedor;

  CheckEqualsString('  AND GAE_EMPENV = :CODEMP', ReturnValue);

end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQLFiltroEmpresaEnvioFornecedor_MesmaEmpresa;
var
  ReturnValue: string;
begin

  FSQLMovimentacaoPosterior.strCodigoEmpresaLogada   := '001';
  FSQLMovimentacaoPosterior.strCodigoEmpresaGarantia := '001';
  FSQLMovimentacaoPosterior.blnUtilizaGarantiaPelaMatriz := true;

  ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQLFiltroEmpresaEnvioFornecedor;

  CheckEqualsString('AND GAE_EMPENV = :CODEMP', Trim(ReturnValue));

end;

procedure TestTSQLMovimentacaoPosterior.TestfRetornaSQLFiltroEmpresaEnvioFornecedor_NaoUtilizaGarantiaPelaMatriz;
var
  ReturnValue: string;
begin

  FSQLMovimentacaoPosterior.strCodigoEmpresaLogada   := '001';
  FSQLMovimentacaoPosterior.strCodigoEmpresaGarantia := '002';
  FSQLMovimentacaoPosterior.blnUtilizaGarantiaPelaMatriz := false;

  ReturnValue := FSQLMovimentacaoPosterior.fRetornaSQLFiltroEmpresaEnvioFornecedor;

  CheckEqualsString('AND GAE_EMPENV = :CODEMP', Trim(ReturnValue));

end;

initialization

  RegisterTest(TestTSQLMovimentacaoPosterior.Suite);
end.

