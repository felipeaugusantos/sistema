unit TestExpedicao.TSQLSeparadorLocalSeparacao;

interface

uses
  TestFramework, Classes, Expedicao.TSQLSeparadorLocalSeparacao,
  Expedicao.TManutencaoSeparadoresPorLocalConstantes, SysUtils, StrUtils;

type

  TestTSQLSeparadorLocalSeparacaoPorItem = class(TTestCase)
  strict private
    FSQLSeparadorLocalSeparacaoPorItem: TSQLSeparadorLocalSeparacaoPorItem;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaSQLItens;
    procedure TestfRetornaSQLLocaisSeparacao;
    procedure TestfRetornaSQLUpdateLocalSeparacao;
  end;
  // Test methods for class TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica

  TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica = class(TTestCase)
  strict private
    FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica: TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfRetornaSQLItens;
    procedure TestfRetornaSQLLocaisSeparacao;
    procedure TestfRetornaSQLUpdateLocalSeparacao;
  end;

implementation


procedure TestTSQLSeparadorLocalSeparacaoPorItem.SetUp;
begin
  FSQLSeparadorLocalSeparacaoPorItem := TSQLSeparadorLocalSeparacaoPorItem.Create;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorItem.TearDown;
begin
  FSQLSeparadorLocalSeparacaoPorItem.Free;
  FSQLSeparadorLocalSeparacaoPorItem := nil;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorItem.TestfRetornaSQLItens;
var
  stlSQL: TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                  );
    stlSQL.Add('  LOTDOR.AUTOINCREM AS CHAVE,'                           );
    stlSQL.Add('  LSE_CODIGO AS CODIGO_LOCAL_SEPARACAO,'                 );
    stlSQL.Add('  FDO_CODITE AS CODIGO_PRODUTO,'                         );
    stlSQL.Add('  ITE_DESITE AS DESCRICAO_PRODUTO,'                      );
    stlSQL.Add('  ITE_LOCFIS AS LOCALIZACAO_FISICA,'                     );
    stlSQL.Add('  LDO_QTDITE AS QUANTIDADE'                              );
    stlSQL.Add('FROM'                                                    );
    stlSQL.Add('  FATDOR'                                                );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'   );
    stlSQL.Add('  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = FDO_CODITE'   );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( '001' ) );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE'          );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'          );
    stlSQL.Add('  INNER JOIN CADITE ON CADITE.ITE_CODITE = FDO_CODITE'   );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                   );

    CheckEqualsString(stlSQL.Text, FSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLItens('001'));
  finally
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorItem.TestfRetornaSQLLocaisSeparacao;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                 );
    stlSQL.Add('  LSE_CODIGO AS CODIGO_LOCAL_SEPARACAO,'                                                );
    stlSQL.Add('  LSE_DESCRI AS LOCAL_SEPARACAO,'                                                       );
    stlSQL.Add('  CONCAT(OPE_CODOPE,"-", OPE_NOMOPE) AS SEPARADOR_ATUAL,'                               );
    stlSQL.Add('  "" AS SEPARADOR_NOVO,'                                                                );
    stlSQL.Add('  "" AS DESCRICAO_SEPARADOR_NOVO,'                                                      );
    stlSQL.Add('  (SUM( (LDO_SEPCOL = "S") OR (IFNULL(FDO_QTDSEP,0) > 0) ) > 0) AS SEPARACAO_INICIADA'  );
    stlSQL.Add('FROM'                                                                                   );
    stlSQL.Add('  FATDOR'                                                                               );
    stlSQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM'                                  );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                  );
    stlSQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE'                                         );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( '001' )                                );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = ITE_CODLSE'                                         );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                         );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                                                  );
    stlSQL.Add('GROUP BY LSE_CODIGO'                                                                    );

    CheckEqualsString(stlSQL.Text, FSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLLocaisSeparacao('001'));

  finally
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorItem.TestfRetornaSQLUpdateLocalSeparacao;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('UPDATE'                                                  );
    stlSQL.Add('  FATDOR'                                                );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'   );
    stlSQL.Add('  INNER JOIN ITEGER ON ITE_CODITE = FDO_CODITE'          );
    stlSQL.Add('									 AND ITE_CODEMP = '+QuotedStr( '001' ) );
    stlSQL.Add('SET LDO_CODSEP = :CODIGO_SEPARADOR_NOVO'                 );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                   );
    stlSQL.Add('  AND ITE_CODLSE = :CODIGO_LOCAL_SEPARACAO'              );

    CheckEqualsString(stlSQL.Text, FSQLSeparadorLocalSeparacaoPorItem.fRetornaSQLUpdateLocalSeparacao('001'));
  finally
    FreeAndNil(stlSQL);
  end;

end;

procedure TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.SetUp;
begin
  FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica := TSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.Create;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.TearDown;
begin
  FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.Free;
  FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica := nil;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.TestfRetornaSQLItens;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                  );
    stlSQL.Add('  LOTDOR.AUTOINCREM AS CHAVE,'                           );
    stlSQL.Add('  LSE_CODIGO AS CODIGO_LOCAL_SEPARACAO,'                 );
    stlSQL.Add('  FDO_CODITE AS CODIGO_PRODUTO,'                         );
    stlSQL.Add('  ITE_DESITE AS DESCRICAO_PRODUTO,'                      );
    stlSQL.Add('  LOT_LOCFIS AS LOCALIZACAO_FISICA,'                     );
    stlSQL.Add('  LDO_QTDITE AS QUANTIDADE'                              );
    stlSQL.Add('FROM'                                                    );
    stlSQL.Add('  FATDOR'                                                );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'   );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'          );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'          );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( '001' ) );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'          );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'          );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE'          );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'          );
    stlSQL.Add('  INNER JOIN CADITE ON ITE_CODITE = FDO_CODITE'          );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                   );

    CheckEqualsString(stlSQL.Text, FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLItens( '001' ) );
  finally
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.TestfRetornaSQLLocaisSeparacao;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('SELECT'                                                                                );
    stlSQL.Add('  LSE_CODIGO AS CODIGO_LOCAL_SEPARACAO,'                                               );
    stlSQL.Add('  LSE_DESCRI AS LOCAL_SEPARACAO,'                                                      );
    stlSQL.Add('  CONCAT(OPE_CODOPE,"-", OPE_NOMOPE) AS SEPARADOR_ATUAL,'                              );
    stlSQL.Add('  "" AS SEPARADOR_NOVO,'                                                               );
    stlSQL.Add('  "" AS DESCRICAO_SEPARADOR_NOVO,'                                                     );
    stlSQL.Add('  (SUM( (LDO_SEPCOL = "S") OR (IFNULL(FDO_QTDSEP,0) > 0) ) > 0) AS SEPARACAO_INICIADA' );
    stlSQL.Add('FROM'                                                                                  );
    stlSQL.Add('  FATDOR'                                                                              );
    stlSQL.Add('  INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM'                                 );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'                                 );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'                                        );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'                                        );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( '001' )                               );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'                                        );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'                                        );
    stlSQL.Add('  INNER JOIN CADLSE ON LSE_CODIGO = LOC_CODLSE'                                        );
    stlSQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = LDO_CODSEP'                                        );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                                                 );
    stlSQL.Add('GROUP BY LSE_CODIGO'                                                                   );

    CheckEqualsString(stlSQL.Text, FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLLocaisSeparacao( '001' ));
  finally
    FreeAndNil(stlSQL);
  end;
end;

procedure TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.TestfRetornaSQLUpdateLocalSeparacao;
var
  stlSQL : TStringList;
begin
  stlSQL := TStringList.Create();
  try
    stlSQL.Add('UPDATE'                                                   );
    stlSQL.Add('  FATDOR'                                                 );
    stlSQL.Add('  INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM'    );
    stlSQL.Add('  INNER JOIN CADLOT ON LOT_NUMLOT = LDO_NUMLOT'           );
    stlSQL.Add('									 AND LOT_CODITE = FDO_CODITE'           );
    stlSQL.Add('									 AND LOT_CODEMP = '+QuotedStr( '001' )  );
    stlSQL.Add('  INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS'           );
    stlSQL.Add('                   AND LOC_CODEMP = LOT_CODEMP'           );
    stlSQL.Add('SET LDO_CODSEP = :CODIGO_SEPARADOR_NOVO'                  );
    stlSQL.Add('WHERE FDO_SEQGER = :AUTOINCREM_FATGOR'                    );
    stlSQL.Add('  AND LOC_CODLSE = :CODIGO_LOCAL_SEPARACAO'               );

    CheckEqualsString( stlSQL.Text, FSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.fRetornaSQLUpdateLocalSeparacao( '001' ) );
  finally
    FreeAndNil(stlSQL);
  end;

end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTSQLSeparadorLocalSeparacaoPorItem.Suite);
  RegisterTest(TestTSQLSeparadorLocalSeparacaoPorLocalizacaoFisica.Suite);
end.

